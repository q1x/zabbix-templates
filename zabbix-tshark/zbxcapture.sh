#!/bin/bash
#
# This script starts a tshark capture dump on the specified interface that will output capture files
# that can be analyzed by the partner script.
#
# Because it checks if the process is already running or not, it can be scheduled in cron which will
# result in a sort of watchdog functionality.
#
#

#Defines capture file location
CAPLOC="/var/tmp/zbxcap"

#Capture filename
CAPFILE="zbxcap.pcap"

#Specify the interface where tshark will capture packets on
CAPINT="eth1"

#Location of the tshark binary
TSHARK="/usr/bin/tshark"

# Set the interval with which tshark will skip to a new capture file. The creation date/time will be used as the timestamp in Zabbix.
INTERVAL=60

mkdir -p "$CAPLOC"

[[ "$(ps -f -C tshark | grep "$CAPINT" | grep -c $CAPLOC/$CAPFILE)" -eq 0 ]] && $TSHARK -i $CAPINT -b duration:$INTERVAL -w $CAPLOC/$CAPFILE -q > /dev/null 2>&1
