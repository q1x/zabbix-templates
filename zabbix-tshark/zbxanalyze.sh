#!/bin/bash
#
# This script starts a tshark analysis run on the network captures that have been aquired by the partner script.
# The data will be converted into Zabbix item values and pushed into Zabbix with the zabbix_sender.
# Afterwards, the capture file will be removed.
#
# Run this script from cron to assure a timely conversion of data and cleanup of the capture files.
#

#Defines capture file location
CAPLOC="/var/tmp/zbxcap"

#Capture filename (<$CAPPREFIX>_<seq#>_<timestamp>.<$CAPSUFFIX>)
CAPPREFIX="zbxcap"
CAPSUFFIX="pcap"

#Specify the PID File for this process
PID="/var/tmp/zbxtshark.pid"

#Location of the binaries
TSHARK="/usr/bin/tshark"
CAPINFOS="/usr/bin/capinfos"
ZBXSEND="/usr/bin/zabbix_sender"

#Hostname in Zabbix
ZBXHOST=TCP_Analysis

#Zabbix server to send item values to
ZBXSERVER=127.0.0.1
ZBXPORT=10051


#######################
## DO NOT EDIT BELOW ##
#######################

# Check if already running. If so, exit.
[[ -f "$PID" ]] && exit 1

# Set PID File to prevent spawning of a new process
echo $$ > "$PID"

# Just to be sure :)
mkdir -p "$CAPLOC"

# Let's start the loop and skip the 2 newest files to prevent locking problems
for CAPFILE in $(ls -t $CAPLOC/$CAPPREFIX*.$CAPSUFFIX | sed 1,2d);
        do

        # Convert the capture file timestamp to unix time
        TIME=`date -d "$(echo $CAPFILE | grep -o '[0-9]\{14\}' | sed 's/\([0-9]\{4\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)/\1-\2-\3\ \4:\5:/')" +%s`

        # Use Capinfos to calculate the average throughput of the packets in the capture file
        SPEED=$($CAPINFOS -i -Tm $CAPFILE 2>/dev/null | sed 1d | cut -d "," -f 2)

        # Let tshark analyze the capture file
        OUTPUT=$($TSHARK -r $CAPFILE -q -z io,stat,0,"COUNT(frame)frame","COUNT(tcp.analysis.retransmission)tcp.analysis.retransmission","COUNT(tcp.analysis.fast_retransmission)tcp.analysis.fast_retransmission","COUNT(tcp.analysis.duplicate_ack)tcp.analysis.duplicate_ack","COUNT(tcp.analysis.out_of_order)tcp.analysis.out_of_order","COUNT(tcp.analysis.lost_segment)tcp.analysis.lost_segment","COUNT(tcp.analysis.ack_lost_segment)tcp.analysis.ack_lost_segment","COUNT(tcp.analysis.zero_window)tcp.analysis.zero_window" 2>/dev/null | grep ^0)

        # Set variables with item values
        FRAMES=$(echo $OUTPUT | awk '{ print $2 }')
        RETRANS=$(echo $OUTPUT | awk '{ print $3 }')
        RETRANSP=$(echo "scale=2; $RETRANS*100/$FRAMES" | bc | sed 's/^\./0./')
        FRETRANS=$(echo $OUTPUT | awk '{ print $4 }')
        FRETRANSP=$(echo "scale=2; $FRETRANS*100/$FRAMES" | bc | sed 's/^\./0./')
        DUPACK=$(echo $OUTPUT | awk '{ print $5 }')
        DUPACKP=$(echo "scale=2; $DUPACK*100/$FRAMES" | bc | sed 's/^\./0./')
        OUTOO=$(echo $OUTPUT | awk '{ print $6 }')
        OUTOOP=$(echo "scale=2; $OUTOO*100/$FRAMES" | bc | sed 's/^\./0./')
        LOSTSEG=$(echo $OUTPUT | awk '{ print $7 }')
        LOSTSEGP=$(echo "scale=2; $LOSTSEG*100/$FRAMES" | bc | sed 's/^\./0./')
        ALOSTSEG=$(echo $OUTPUT | awk '{ print $8 }')
        ALOSTSEGP=$(echo "scale=2; $ALOSTSEG*100/$FRAMES" | bc | sed 's/^\./0./')
        ZEROWIN=$(echo $OUTPUT | awk '{ print $9 }')
        ZEROWINP=$(echo "scale=2; $ZEROWIN*100/$FRAMES" | bc | sed 's/^\./0./')

        # Output to zabbix_sender
        echo "$ZBXHOST tshark.speed $TIME $SPEED
$ZBXHOST tshark.frames $TIME $FRAMES
$ZBXHOST tshark.retransmissions $TIME $RETRANS
$ZBXHOST tshark.retransmissions.perc $TIME $RETRANSP
$ZBXHOST tshark.fast_retransmissions $TIME $FRETRANS
$ZBXHOST tshark.fast_retransmissions.perc $TIME $FRETRANSP
$ZBXHOST tshark.duplicate_ack $TIME $DUPACK
$ZBXHOST tshark.duplicate_ack.perc $TIME $DUPACKP
$ZBXHOST tshark.out_of_order $TIME $OUTOO
$ZBXHOST tshark.out_of_order.perc $TIME $OUTOOP
$ZBXHOST tshark.lost_segment $TIME $LOSTSEG
$ZBXHOST tshark.lost_segment.perc $TIME $LOSTSEGP
$ZBXHOST tshark.ack_lost_segment $TIME $ALOSTSEG
$ZBXHOST tshark.ack_lost_segment.perc $TIME $ALOSTSEGP
$ZBXHOST tshark.zero_window $TIME $ZEROWIN
$ZBXHOST tshark.zero_window.perc $TIME $ZEROWINP" | $ZBXSEND -z $ZBXSERVER -p $ZBXPORT -T -i - && rm $CAPFILE
done

# Remove PID
rm "$PID"
