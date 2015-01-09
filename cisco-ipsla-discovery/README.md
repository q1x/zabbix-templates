# Zabbix Cisco IP SLA discovery 
This template uses Zabbix SNMP Low-Level Discovery (LLD) to discover Cisco IP SLA checks that are configured on Cisco router devices.
IP SLA enables you to monitor performance of networks and servers directly from your edge devices.

Zabbix will discover IP SLA configuration and metrics and poll them so they can be graphed in the Zabbix GUI.
There are also some triggers included that will allow you to alert on error conditions.
Please be advised that in order for this to work, Zabbix needs to poll the router more often then that the route polls the monitored service as to not miss an error condition.
E.g., if the router polls a service every 2 minutes, let Zabbix poll the router every minute for metric items.
This is because we currently don't use SNMP traps to catch the IP SLA errors.

The template currently supports the following IP SLA types:

- DNS (http://www.cisco.com/c/en/us/td/docs/ios-xml/ios/ipsla/configuration/15-mt/sla-15-mt-book/sla_dns.html)
- HTTP (http://www.cisco.com/c/en/us/td/docs/ios-xml/ios/ipsla/configuration/15-mt/sla-15-mt-book/sla_http.html)

Others might follow :-)


## Needed valuemaps

Before using the template, please create the following valuemaps or the import will fail:

`HTTP status`:  
200 ⇒ OK  
301 ⇒ MOVED-PERMANENTLY  
302 ⇒ MOVED-TEMPORARILY  
400 ⇒ BAD-REQUEST  
401 ⇒ NOT-AUTHORIZED  
403 ⇒ FORBIDDEN  
404 ⇒ NOT FOUND  
500 ⇒ INTERNAL SERVER ERROR  
501 ⇒ NOT-IMPLEMENTED  
502 ⇒ SERVICE-OVERLOADED  
503 ⇒ GW-TIMEOUT  

`IP SLA HTTP Operation`:  
0 ⇒ N/A  
1 ⇒ HTTP GET  

`IP SLA Oper Status`:  
1 ⇒ Reset  
2 ⇒ Orderly Stop  
3 ⇒ Immediate Stop  
4 ⇒ Pending  
5 ⇒ Inactive  
6 ⇒ Active  
7 ⇒ Restart  

`IP SLA RTT Status`:  
0 ⇒ other  
1 ⇒ ok  
2 ⇒ disconnected  
3 ⇒ overThreshold  
4 ⇒ timeout  
5 ⇒ busy  
6 ⇒ notConnected  
7 ⇒ dropped  
8 ⇒ sequenceError  
9 ⇒ verifyError  
10 ⇒ applicationSpecific  
11 ⇒ dnsServerTimeout  
12 ⇒ tcpConnectTimeout  
13 ⇒ httpTransactionTimeout  
14 ⇒ dnsQueryError  
15 ⇒ httpError  
16 ⇒ error  
17 ⇒ mplsLspEchoTxError  
18 ⇒ mplsLspUnreachable  
19 ⇒ mplsLspMalformedReq  
20 ⇒ mplsLspReachButNotFEC  


