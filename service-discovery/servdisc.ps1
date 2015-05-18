# Powershell script to fetch a list of autostarted services via WMI and report back in a JSON
# formatted message that Zabbix will understand for Low Level Discovery purposes.
#

# First, fetch the list of auto started services
$colItems = Get-WmiObject Win32_Service | where-object { $_.StartMode -ne 'Disabled' }
# Output the JSON header
Write-Host "{";
write-host "`t ""data"":[";
write-host

#temp variable
$temp = 1

# For each object in the list of services, print the output of the JSON message with the object properties that we are interessted in
foreach ($objItem in $colItems) {
 $exe_dir = $objItem.PathName
 $exe_dir = $exe_dir -replace '"?(.+\\).+exe.*$','$1'
 $exe_dir = $exe_dir -replace '\\','/'
 $exe_dir = $exe_dir -replace '"','\"'
 
 $desc_val = $objItem.Description
 $desc_val = $desc_val -replace '\"','@'
 
 if ($temp -eq 0){
	Write-Host ",";
 } 
 else{
	$temp = 0;
 }
 $line = " { `"{#SERVICESTATE}`":`"" + $objItem.State + "`", `"{#SERVICEDISPLAY}`":`"" + $objItem.DisplayName + "`", `"{#SERVICENAME}`":`"" + $objItem.Name + "`", `"{#SERVICEDESC}`":`"" + $desc_val + "`", `"{#SERVICEDIR}`":`"" + $exe_dir + "`" }"
 Write-Host -NoNewline $line
}

# Close the JSON message
write-host
write-host
write-host "`t ]";
write-host "}"
