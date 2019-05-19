+++
title = "Use Sonos in diffent Subnet"
date = "2019-05-19T10:06:08+01:00"
description = "I have my Sonos One in my diffrent subnet to allow access from my internal LAN and my Guest wifi. To make this work I need to make some tweaks on the Router."
tags = [ "Sonos", "Linux", "Router" ]
categories = [ "Audio", "Sonos" ]
+++
I don't want to have my new Sonos One in my private LAN. Because Quest should also able to play music over the Sonos. So I place the Sonos in my IoT LAN. 

To make Sonos work across diffrent networks you need to do the following taks on your router. 

I use a simple Debian Linux system as my Router. With this I am very flexible in my setup. Here I will show the steps I did to make my Sonos working across VLANs. 

# IGMP Proxy
Sonos use multicast for their discovery. To make this discovery working over VLANs you need to install a IGMP(Internet Group Management Protocol) proxy on your router. I use **pimd** for that I is a simple deamon with very easy setup. 

By default pimd is enabled on all non localhost interfaces. So you need to only disable it on the interfaces you don't need it. Like in may case. 

``` /etc/pimd.conf
phyint enp1s0 disable
phyint ppp0 disable
phyint docker0 disable
```

Their I nothing more to do. Just restart the clients will find your sonos device. 

# Firewall Rules
I added the following firewalls rules to my router to allow access between Sonos and my clients.
```
SRC CLIENTS - DST-BROADCAST (224.0.0.0/4)
IGMP
UDP1900

SRC CLIENT- DST SONOS Network Brodcast (x.x.x.255 for an /24)
UDP6969

SRC SONOS - DST CLIENT:
TCP-3401
UDP-1901
UDP30000-60000
TCP30000-60000

SRC CLIENT - DST SONOS:
UDP319-320
TCP30000-60000
TCP7000
TCP1443
TCP1400
TCP1900
UDP30000-60000
```

# ZeroConf
For the basic sonos function you don't need Zeroconf. But also want to use airplay2 with the Sonos One from my iPhone. The iPhone find the airplay speaker over Bonjour/Zeroconf, because of that we need to enable zeroconf on our router to use them as reflector. 

On Debian you can simply use the avahi daemon to act as zeroconf relflector. You just need to change change enable the reflector function in avahi. 
``` /etc/avahi/avahi-daemon.conf
[reflector]
enable_reflector=yes
```
Don't forget to enable the avahi service. So I will start after a reboot automatically. 


# MAC Filter
I have a mac filter list on my IoT wifi. You can find the mac address of your Sonos on the buttom. The MAC is part of the serial number:
The follwing serialnumber will result in the MAC AA:BB:CC:DD:EE:FF.
``` 
#### AA-BB-CC-DD-EE-FF-##
``` 
