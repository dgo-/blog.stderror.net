+++
title = "Fortinet CheatSheet"
date = "2018-03-18T09:18:04+01:00"
description = "Most useful fortinet command for debugging"
tags = [ "fortinet", "CheatSheet" ]
categories = [  "CheatSheet" ]
+++
Hi, 

this is my fortinet CheatSheet created for version 5.6:

# General Information
## NTP Status
```
diagnose sys ntp status
```

## ARP table

```
diagnose ip arp list
```

## routing table
### show active routing table
```
get router info routing-table all
```

### show all configured routes
```
get router info routing-table database
```

## show NAT table
```
get system session list
```

# VPN
## Phase1
### show phase1
```
diag vpn ike gateway list name <name_of_phase1>
```

### clear phase1 
```
diag vpn ike gateway clear name <name_of_phase1>
```

## Phase2
### show phase2
```
diag vpn tunnel list name <name_of_phase1>
```

### bring phase2 up/down
```
diag vpn tunnel up   <name_of_phase2>
diag vpn tunnel down <name_of_phase2>
```

### reset phase2
```
diag vpn tunnel reset <name_of_phase1>
```
 
### show vpn logs
```
diagnose debug reset                                            # reset the debug settings
diagnose vpn ike log-filter clear                               # clear the logfilter
diagnose vpn ike log-filter dst-addr4 <REMOTE_VPN_GATEWAY_IP>   # set a filter to only show logs to the given gateway
diagnose debug app ike 255                                      # set the IKE log level to 255 (loglevel below)
diagnose debug enable                                           # enable the debug log
diagnose debug disable                                          # disable the debug log
```
**IKE log level**
-1 or 255 means all message of debug in Phase1/2.
But there are more debug levels for specific information:
              2 Shows config changes
              4 Shows connections which will be established
              8 Only Phase-1 as Phase-2 comunications messages
             16 Shows only NAT-T (Nat-Traversal)
             32 Shows only DPD 
             64 Shows only Encryption/Decryption Key's
            128 Shows only Encryption Traffic payload
You can build also a sum of the log level you interested in. 
 
# Packet Sniffer
```
# syntax
diagnose sniffer packet <interface_name> <‘filter’> [<verbose>] [<count>] [<time_zone>]
#example
diagnose sniffer packet any 'host 8.8.8.8' 4
```
**interface**  
any means all interfaces or the interface name
**count**
slow only package up to the count limit. Zero means no limit.
**time_zone**
a = UTC time
l = local time (default)

## Filter
```
# syntax
'[ [src|dst] host<host_name_or_IP1> ] [ [src|dst] host<host_name_or_IP2>] [ [arp|ip|gre|esp|udp|tcp] [port_no] ] [ [arp|ip|gre|esp|udp|tcp] [port_no] ]'
```
 
**Examples**
```
Not Port 443              = '!port 443'
Port 443                  = 'port 443'
Host                      = 'host 192.168.1.1'
Host und Host             = 'host 192.168.1.1 and host 192.168.1.2'
Host und Port 443         = 'host 192.168.1.1 and port 443'
Host und nicht Port 443   = 'host 192.168.1.1 and !port 443'
Host oder Port 443        = 'host 192.168.1.1 or port 443'
only udp Traffic          = 'udp'
only SYN Flag             = 'tcp[13]&2==2'
only ARP Packete          = 'arp' 
no filter                 = none
```
## verbose
       1 - Shows the header of a packet (default)
       2 - Shows the header and data of IP packets
       3 - Shows the header and data of  Ethernet Packets (Frames ACSII und HEX)
       4 - Shows the header and Interface Name of Packets
       5 - Shows the header and data of IP Packets with Interface Name
       6 - Shows the header and of Ethernet Packets with Interface Name

# Flow
```
diagnose debug reset                                          # reset the diagnose output
diagnose debug flow filter daddr <dest_IP>                    # limit the output to the destination address
diagnose debug enable                                         # enable the debug output
diagnose debug flow trace start 10                            # display the next 10 packets, after that, disable the flow
diagnose debug disable                                        # disable the debug log
```

# HA
## show HA status
```
diagnose sys ha status
```

## verify the HA sync status
show the checksum of the configuration
```
diagnose sys ha checksum show
```
## switch to the slave
```
execute ha manage ?                # show devices
execute ha manage <device-index>   # switch to the slave
```

## Force Failover
```
diagnose sys ha reset-uptime
```
Fortinet have no "ha change" command. We need to reset the uptime with the command or change the prio. 
 
# Performace
## Performace overview
```
get system performance status
```
## TOP
```
diagnose sys top
```
