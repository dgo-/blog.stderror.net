+++
title = "get local macadress"
date = "2016-05-21"
description = "In my job i sometimes need to know the MAC adresse of an local device. Sometimes you need to look in the invertory but this is always some pain. so I got the cool way and you arp the get the mac adresse from devices in a local network."
tags = [ "macadress", "IP", "arp" ]
categories = [ 
  "Script", "IP"
]
+++

Hi guys, 

in my job i sometimes need to know the MAC adresse of an local device. Sometimes you need to look in the invertory but this is always some pain. so I got the cool way and you arp the get the mac adresse from devices in a local network. 

ARP the address resolotion protocol is used in IPv4 to get the mac address for an IP address so you can send data to the device in a boadcast domain. And so I use simple the existing arp mechanisam to get mac adress whitout looking in an invertory.

I write a little tool to make the whole process more comfotable. It is called marp an You can find it here:
github.com/dgo-/bin/blob/master/marp (no longer exists)

Good Night,
Daniel
