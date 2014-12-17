### Zabbix Template to discover Linux MD devices

This template and userparameters will allow you to use Low Level Discovery (LLD) to discover md devices on your linux system en monitor them.
To be able to use the template, you will need to add the userparameters to the Zabbix agent. This can be done by copy/pasting them into the zabbix agent config file or placing the userparameter-md.conf file in the configured include directory for the agent.

All items use info from /proc/mdstat, no need for mdadm or other utilities. For more info see https://raid.wiki.kernel.org/index.php/Mdstat .


## Provided Items

- vfs.md.personalities (character) : Outputs the kernel capabilities with regard to md levels. 
- vfs.md.unused (character) : Outputs the unused md devices
- vfs.md.discovery (LLD) : Returns a LLD of the md* devices with the following macros: {#MDDEVICE} {#MDLEVEL} {#MDSTATE}
- vfs.md.status (character) : Returns th estate of the md device
- vfs.md.level (unsigned) : Returns the raid level of the device
- vfs.md.members (character) : Returns the member devices of the RAID set
- vfs.md.nummembers (unsigned) : Returns the number of members in the RAID set
- vfs.md.size (unsigned) : Returns the block size of the RAID device
- vfs.md.needed (unsigned) : The number of devices ideally in use
- vfs.md.active (unsigned) : The number of devices currently active
- vfs.md.up (unsigned) : The number of devices in UP state
- vfs.md.down (unsigned) : The number of devices in DOWN state
- vfs.md.recoverperc (float) : The percentage the device has recovered
- vfs.md.recoverspeed (unsigned) : The speed the device is recovering with (in blocks/sec)
- vfs.md.recovereta (character) : The time needed to full recovery of the device

## Triggers

There are some basic triggers included, tune them to your needs.

## Graphs

I've included a graph to show the recovery rate of the devices and also a graph with UP and DOWN state of the member devices.

 
