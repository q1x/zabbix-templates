# Powershell script to fetch a list of autostarted services via WMI and report back in a JSON
# formatted message that Zabbix will understand for Low Level Discovery purposes.

<<<<<<< HEAD
=======
# This script is getting 2 arguments as input -regex "The regular expression that will search each like to match" -sun "The Service Unique Name"
# The Service Unique Name it will be used in Zabbix to create special Item prototypes for this Family of services

# Example Run command:  powershell .\service_lld_WMI.ps1 -regex "'Application\w+'" -sun "_app"
#For compatibility reasons if you run the script without arguments it will return the same format. 

param([string]$regex = "regex", [string]$sun = "sun")

#Write-Host "$regex"
#Write-Host "$sun"

>>>>>>> 7ae467f961ad9d1c938b12aee81ca40ef8886cb1
# First, fetch the list of auto started services
$colItems = Get-WmiObject Win32_Service | where-object { $_.StartMode -ne 'Disabled' }
# Output the JSON header
Write-Host "{";
write-host "`t ""data"":[";
write-host

<<<<<<< HEAD
=======
#For compatibility reasons if you run the script with out arguments it will return the same data format.
if  ($regex -eq "regex"){
	$sun=""
}

>>>>>>> 7ae467f961ad9d1c938b12aee81ca40ef8886cb1
#temp variable
$temp = 1

# For each object in the list of services, print the output of the JSON message with the object properties that we are interessted in
foreach ($objItem in $colItems) {
<<<<<<< HEAD
 $exe_dir = $objItem.PathName
 $exe_dir = $exe_dir -replace '\s.*$',''
 $exe_dir = $exe_dir -replace '"?(.+\\).+exe.*$','$1'
 $exe_dir = $exe_dir -replace '\\','/'
 $exe_dir = $exe_dir -replace '"',''
 
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
=======
	$exe_dir = $objItem.PathName
	$exe_dir = $exe_dir -replace '"?(.+\\).+exe.*','$1'
	$exe_dir = $exe_dir -replace '\\','/'
	
	# Remove text with "text" from the Description
	$desc_val = $objItem.Description
	$desc_val = $desc_val -replace '\"','@'
 
	$line = " { `"{#SERVICESTATE$sun}`":`"" + $objItem.State + "`", `"{#SERVICEDISPLAY$sun}`":`"" + $objItem.DisplayName + "`", `"{#SERVICENAME$sun}`":`"" + $objItem.Name + "`", `"{#SERVICEDESC$sun}`":`"" + $desc_val + "`", `"{#SERVICEDIR$sun}`":`"" + $exe_dir + "`" }"
	
	if (($line -match $regex) -Or ($regex -eq "regex")){
		if ($temp -eq 0){
			Write-Host ",";
		} 
		else{
			$temp = 0;
		}	
		Write-Host -NoNewline $line
	}
>>>>>>> 7ae467f961ad9d1c938b12aee81ca40ef8886cb1
}

# Close the JSON message
write-host
write-host
write-host "`t ]";
write-host "}"
