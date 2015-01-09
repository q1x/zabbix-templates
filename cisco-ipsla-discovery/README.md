# Zabbix Cisco IP SLA discovery 

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


