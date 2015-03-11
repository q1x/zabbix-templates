# ZABBIX/tshark packet analysis

This Zabbix template uses tshark (part of the wireshark project) to analyse network traffic on a capture interface.
Doing this allows you to perform monitoring of certain types of network traffic passing by on the capture interface and plot these over time. Very, very useful if the interface you are monitoring is a SPAN or monitor port of an import network uplink.

The template and scripts facilitate in counting duplicate acks, retransmissions, lost segments, etc. but could easily be adjusted to trend different types of data. For instance, one could start monitoring the numer of 5xx HTTP status codes passing over the network to spot an increase in webserver backend errors that clients are facing.

## Usage

There are 2 scripts provided:

- A capture script which will create new capture files every 60 seconds (`zbxcapture.sh`)
- An analyser script which will parse the capture files and push the data to Zabbix (`zbxanalyze.sh`)

Make sure the variables in both of the scripts are setup properly for your situation.
I recommend to put both of these scripts in a crontab for a user that has sufficient permissions to access the NIC that you are trying to monitor.

```
* * * * * /path/to/zbxcapture.sh
* * * * * /path/to/zbxanalyze.sh
```

