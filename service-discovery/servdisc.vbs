' This code was converted from my powershell script by Mate Juroš @ https://github.com/gustisok
' I have not tested this code, please use with precaution. If you find any problems with it, let me know.
'---
' VB script to fetch a list of autostarted services via WMI and report back in a JSON
' formatted message that Zabbix will understand for Low Level Discovery purposes.
'
'#

'# First, fetch the list of auto started services
strComputer = "."
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colListOfServices = objWMIService.ExecQuery ("Select * from Win32_Service where Startmode='Auto'")

'# Output the JSON header
Set objStdOut = WScript.StdOut
objStdOut.Write "{" & vbCRLF
objStdOut.Write """data"":[" & vbCRLF
objStdOut.Write vbCRLF

dim OutputLine

'# For each object in the list of services, print the output of the JSON message with the object properties that we are interessted in

For Each objService in colListOfServices
OutputLine = OutputLine & " { ""{#SERVICESTATE}"":""" & objService.State & """ , ""{#SERVICEDISPLAY}"":""" & objService.DisplayName & """ , ""{#SERVICENAME}"":""" & objService.Name & """ , ""{#SERVICEDESC}"":""" & objService.Description & """ }," & vbCRLF
Next
OutputLine = Left(OutputLine, Len( OutputLine) - 1)
objStdOut.Write OutputLine & vbCRLF
'# Close the JSON message
objStdOut.Write vbCRLF
objStdOut.Write " ]" & vbCRLF
objStdOut.Write "}" & vbCRLF
objStdOut.Write vbCRLF
