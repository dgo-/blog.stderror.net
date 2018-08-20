+++
title = "how to setup edgerouter with telekom vdsl"
date = "2018-08-13"
description = "Howto setup a edgerouter with vdsl"
tags = [ "ubnt", "dsl", "router", "telekom" ]
categories = [
  "network",
  "HowTo"
]
+++
My ISP is the Telekom in Germany. I use a drytek modem in front of my **edgerouter**. 

# prepare the Interfaces
First of all I preapre all interfaces on my **edgerouter**. 

My Interfaces:
eth0     => to modem
eth0.7   => internet connection
eth0.8   => TV streaming
eth1     => managment
eth2     => wifi AP 
eth2.37  => private LAN
eth2.50  => guest LAN
eth2.101 => Internet of things LAN


```
set interfaces ethernet eth0 vif 7 description 'DSL'
set interfaces ethernet eth0 vif 7 mtu 1500

set interfaces ethernet eth0 vif 7 pppoe 0 default-route auto
set interfaces ethernet eth0 vif 7 pppoe 0 mtu 1492
set interfaces ethernet eth0 vif 7 pppoe 0 name-server none
set interfaces ethernet eth0 vif 7 pppoe 0 user-id 'XXXXXXXXXXXXXXXXXXXXXXXXXXXX@t-online.de'
set interfaces ethernet eth0 vif 7 pppoe 0 password XXXXXXXXXXX

set interfaces ethernet eth0 vif 7 pppoe 0 ipv6 address autoconf
set interfaces ethernet eth0 vif 7 pppoe 0 ipv6 dup-addr-detect-transmits 1

# TV
set interfaces ethernet eth0 vif 8 address dhcp
set interfaces ethernet eth0 vif 8 description TV
set interfaces ethernet eth0 vif 8 mtu 1500

# Managment
set interfaces ethernet eth1 address 192.168.42.1/24
set interfaces ethernet eth1 description 'Ironforge (Managment)'
set interfaces ethernet eth1 ipv6 dup-addr-detect-transmits 1

# Transfer
delete interfaces ethernet eth0  address 192.168.1.1/24  # delete default IP
set interfaces ethernet eth0 address 192.168.1.42/24
set interfaces ethernet eth0 description 'Transfer to Vigor'

# wifi
set interfaces ethernet eth2 address 192.168.200.1/24
set interfaces ethernet eth2 description Wifi-AP
set interfaces ethernet eth2 mtu 1500

# networks
set interfaces ethernet eth2 vif 37 description  'Dalaran (private)'
set interfaces ethernet eth2 vif 37 address 10.13.37.1/24
set interfaces ethernet eth2 vif 37 ipv6 dup-addr-detect-transmits 1

set interfaces ethernet eth2 vif 50 description  'Booty Bay (guest)'
set interfaces ethernet eth2 vif 50 address 10.13.50.1/24
set interfaces ethernet eth2 vif 50 ipv6 dup-addr-detect-transmits 1

set interfaces ethernet eth2 vif 101 description 'Gadgetzan (Internet of shit)'
set interfaces ethernet eth2 vif 101 address 10.13.101.1/24
set interfaces ethernet eth2 vif 101 ipv6 dup-addr-detect-transmits 1
```

# IPv6
My Internet connection I a dual stack connection. So I need to configure IPv6 for also for my home networks. The **edgerouter** request a */56* Prefix from my ISP. I also drop the DNS server from my provider. 
```
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd prefix-only
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd rapid-commit enable
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd no-dns
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 prefix-length 56
```

Now I setup in all my LANs with IPv6 a DHCP Server on the edgerouter to delegate the prefix in the network segments. 
```
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 interface eth1 host-address '::1'
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 interface eth1 no-dns
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 interface eth1 prefix-id 42
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 interface eth1 service slaac

set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 interface eth2.37 host-address '::1'
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 interface eth2.37 no-dns
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 interface eth2.37 prefix-id 37
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 interface eth2.37 service slaac

set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 interface eth2.50 host-address '::1'
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 interface eth2.50 no-dns
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 interface eth2.50 prefix-id 50
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 interface eth2.50 service slaac

set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 interface eth2.101 host-address '::1'
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 interface eth2.101 no-dns
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 interface eth2.101 prefix-id 65 # in hex
set interfaces ethernet eth0 vif 7 pppoe 0 dhcpv6-pd pd 0 interface eth2.101 service slaac
```

# DHCP
To have also IPv4 adresse in my LAN I also setup a DHCP server for each LAN segment. 

To enable DNS resolution I added the the following lines.
```
set service dhcp-server hostfile-update enable
set service dhcp-server dynamic-dns-update enable true
```

Now I crete for each network a DHCP server. 
```
set service dhcp-server shared-network-name Ironforge subnet 192.168.42.0/24 start 192.168.42.11 stop 192.168.42.200
set service dhcp-server shared-network-name Ironforge subnet 192.168.42.0/24 default-router 192.168.42.1
set service dhcp-server shared-network-name Ironforge subnet 192.168.42.0/24 dns-server 192.168.42.1
set service dhcp-server shared-network-name Ironforge subnet 192.168.42.0/24 domain-name home.stderror.net
set service dhcp-server shared-network-name Ironforge subnet 192.168.42.0/24 time-server 192.168.42.1

set service dhcp-server shared-network-name Dalaran subnet 10.13.37.0/24 start 10.13.37.11 stop 10.13.37.200
set service dhcp-server shared-network-name Dalaran subnet 10.13.37.0/24 default-router 10.13.37.1
set service dhcp-server shared-network-name Dalaran subnet 10.13.37.0/24 dns-server 10.13.37.1
set service dhcp-server shared-network-name Dalaran subnet 10.13.37.0/24 domain-name home.stderror.net
set service dhcp-server shared-network-name Dalaran subnet 10.13.37.0/24 time-server 10.13.37.1

set service dhcp-server shared-network-name Booty-Bay subnet 10.13.50.0/24 start 10.13.50.11 stop 10.13.50.200
set service dhcp-server shared-network-name Booty-Bay subnet 10.13.50.0/24 default-router 10.13.50.1
set service dhcp-server shared-network-name Booty-Bay subnet 10.13.50.0/24 dns-server 10.13.50.1
set service dhcp-server shared-network-name Booty-Bay subnet 10.13.50.0/24 domain-name home.stderror.net
set service dhcp-server shared-network-name Booty-Bay subnet 10.13.50.0/24 time-server 10.13.50.1

set service dhcp-server shared-network-name Gadgetzan subnet 10.13.101.0/24 start 10.13.101.11 stop 10.13.101.200
set service dhcp-server shared-network-name Gadgetzan subnet 10.13.101.0/24 default-router 10.13.101.1
set service dhcp-server shared-network-name Gadgetzan subnet 10.13.101.0/24 dns-server 10.13.101.1
set service dhcp-server shared-network-name Gadgetzan subnet 10.13.101.0/24 domain-name home.stderror.net
set service dhcp-server shared-network-name Gadgetzan subnet 10.13.101.0/24 time-server 10.13.101.1
```

# Firewall
I set some options to the firewall. 
```
set firewall receive-redirects disable
set firewall send-redirects enable
set firewall source-validation disable
set firewall syn-cookies enable
set firewall ipv6-receive-redirects disable
set firewall ipv6-src-route disable
set firewall all-ping enable
set firewall broadcast-ping disable
set firewall options mss-clamp  interface-type pppoe
set firewall options mss-clamp6 interface-type pppoe
set firewall options mss-clamp  mss 1452
set firewall options mss-clamp6 mss 1432
```

## Ruleset
Here an example of my firewall rules. 
```
# WAN-2-Local
set firewall name      WAN_2_LOCAL  default-action drop
set firewall name      WAN_2_LOCAL  description 'IPv4 from WAN to router'
set firewall name      WAN_2_LOCAL  enable-default-log
set firewall ipv6-name WAN6_2_LOCAL default-action drop
set firewall ipv6-name WAN6_2_LOCAL description 'IPv6 from WAN to router'
set firewall ipv6-name WAN6_2_LOCAL enable-default-log

set firewall name      WAN_2_LOCAL  rule 1 action drop
set firewall name      WAN_2_LOCAL  rule 1 description 'Drop invalid state'
set firewall name      WAN_2_LOCAL  rule 1 log disable
set firewall name      WAN_2_LOCAL  rule 1 state invalid enable
set firewall ipv6-name WAN6_2_LOCAL rule 1 action drop
set firewall ipv6-name WAN6_2_LOCAL rule 1 description 'Drop invalid state'
set firewall ipv6-name WAN6_2_LOCAL rule 1 log disable
set firewall ipv6-name WAN6_2_LOCAL rule 1 state invalid enable

set firewall name      WAN_2_LOCAL  rule 5 action accept
set firewall name      WAN_2_LOCAL  rule 5 description 'Allow established/related'
set firewall name      WAN_2_LOCAL  rule 5 log disable
set firewall name      WAN_2_LOCAL  rule 5 state established enable
set firewall name      WAN_2_LOCAL  rule 5 state related enable
set firewall ipv6-name WAN6_2_LOCAL rule 5 action accept
set firewall ipv6-name WAN6_2_LOCAL rule 5 description 'Allow established/related'
set firewall ipv6-name WAN6_2_LOCAL rule 5 log disable
set firewall ipv6-name WAN6_2_LOCAL rule 5 state established enable
set firewall ipv6-name WAN6_2_LOCAL rule 5 state related enable

set firewall name      WAN_2_LOCAL  rule 11 action accept
set firewall name      WAN_2_LOCAL  rule 11 description 'Allow ICMP'
set firewall name      WAN_2_LOCAL  rule 11 log disable
set firewall name      WAN_2_LOCAL  rule 11 protocol icmp
set firewall ipv6-name WAN6_2_LOCAL rule 11 action accept
set firewall ipv6-name WAN6_2_LOCAL rule 11 description 'Allow ICMPv6'
set firewall ipv6-name WAN6_2_LOCAL rule 11 log disable
set firewall ipv6-name WAN6_2_LOCAL rule 11 protocol icmpv6

set firewall ipv6-name WAN6_2_LOCAL rule 101 action accept
set firewall ipv6-name WAN6_2_LOCAL rule 101 description 'Allow DHCPv6 packets'
set firewall ipv6-name WAN6_2_LOCAL rule 101 destination port 546
set firewall ipv6-name WAN6_2_LOCAL rule 101 source port 547
set firewall ipv6-name WAN6_2_LOCAL rule 101 protocol udp
set firewall ipv6-name WAN6_2_LOCAL rule 101 log disable

set firewall name WAN_2_LOCAL rule 201 action accept
set firewall name WAN_2_LOCAL rule 201 description 'Allow Multicast'
set firewall name WAN_2_LOCAL rule 201 destination address 224.0.0.0/4
set firewall name WAN_2_LOCAL rule 201 log disable
set firewall name WAN_2_LOCAL rule 201 protocol all

# WAN-2-IN
set firewall name      WAN_2_IN default-action drop
set firewall name      WAN_2_IN description 'IPV6 WAN to IN'
set firewall name      WAN_2_IN enable-default-log
set firewall ipv6-name WAN6_2_IN default-action drop
set firewall ipv6-name WAN6_2_IN description 'IPv6 WAN to IN'
set firewall ipv6-name WAN6_2_IN enable-default-log

set firewall name      WAN_2_IN  rule 1 action drop
set firewall name      WAN_2_IN  rule 1 description 'Drop invalid state'
set firewall name      WAN_2_IN  rule 1 state invalid enable
set firewall ipv6-name WAN6_2_IN rule 1 action drop
set firewall ipv6-name WAN6_2_IN rule 1 description 'Drop invalid state'
set firewall ipv6-name WAN6_2_IN rule 1 state invalid enable

set firewall name      WAN_2_IN  rule 2 action accept
set firewall name      WAN_2_IN  rule 2 description 'Allow established/related'
set firewall name      WAN_2_IN  rule 2 state established enable
set firewall name      WAN_2_IN  rule 2 state related enable
set firewall ipv6-name WAN6_2_IN rule 2 action accept
set firewall ipv6-name WAN6_2_IN rule 2 description 'Allow established/related'
set firewall ipv6-name WAN6_2_IN rule 2 state established enable
set firewall ipv6-name WAN6_2_IN rule 2 state related enable

# WAN-2-out
set firewall name      WAN_2_out  default-action accept
set firewall name      WAN_2_out  description 'IPV6 WAN to out'
set firewall name      WAN_2_out  enable-default-log
set firewall ipv6-name WAN6_2_out default-action accept
set firewall ipv6-name WAN6_2_out description 'IPv6 WAN to out'
set firewall ipv6-name WAN6_2_out enable-default-log

# Ironforge-2-in
set firewall name      Ironforge_2_in  default-action accept
set firewall name      Ironforge_2_in  description 'IPV6 Ironforge to in'
set firewall name      Ironforge_2_in  enable-default-log
set firewall ipv6-name Ironforge6_2_in default-action accept
set firewall ipv6-name Ironforge6_2_in description 'IPv6 Ironforge to in'
set firewall ipv6-name Ironforge6_2_in enable-default-log

# Ironforge-2-out
set firewall name      Ironforge_2_out  default-action reject
set firewall name      Ironforge_2_out  description 'IPV6 Ironforge to out'
set firewall name      Ironforge_2_out  enable-default-log
set firewall ipv6-name Ironforge6_2_out default-action reject
set firewall ipv6-name Ironforge6_2_out description 'IPv6 Ironforge to out'
set firewall ipv6-name Ironforge6_2_out enable-default-log

set firewall name      Ironforge_2_out  rule 1 action drop
set firewall name      Ironforge_2_out  rule 1 description 'Drop invalid state'
set firewall name      Ironforge_2_out  rule 1 state invalid enable
set firewall ipv6-name Ironforge6_2_out rule 1 action drop
set firewall ipv6-name Ironforge6_2_out rule 1 description 'Drop invalid state'
set firewall ipv6-name Ironforge6_2_out rule 1 state invalid enable

set firewall name      Ironforge_2_out  rule 2 action accept
set firewall name      Ironforge_2_out  rule 2 description 'Allow established/related'
set firewall name      Ironforge_2_out  rule 2 state established enable
set firewall name      Ironforge_2_out  rule 2 state related enable
set firewall ipv6-name Ironforge6_2_out rule 2 action accept
set firewall ipv6-name Ironforge6_2_out rule 2 description 'Allow established/related'
set firewall ipv6-name Ironforge6_2_out rule 2 state established enable
set firewall ipv6-name Ironforge6_2_out rule 2 state related enable

# Ironforge-2-local
set firewall name      Ironforge_2_local  default-action accept
set firewall name      Ironforge_2_local  description 'IPV6 Ironforge to local'
set firewall name      Ironforge_2_local  enable-default-log
set firewall ipv6-name Ironforge6_2_local default-action accept
set firewall ipv6-name Ironforge6_2_local description 'IPv6 Ironforge to local'
set firewall ipv6-name Ironforge6_2_local enable-default-log

# Dalaran-2-in
set firewall name      Dalaran_2_in  default-action accept
set firewall name      Dalaran_2_in  description 'IPV6 Dalaran to in'
set firewall name      Dalaran_2_in  enable-default-log
set firewall ipv6-name Dalaran6_2_in default-action accept
set firewall ipv6-name Dalaran6_2_in description 'IPv6 Dalaran to in'
set firewall ipv6-name Dalaran6_2_in enable-default-log

# Dalaran-2-out
set firewall name      Dalaran_2_out  default-action reject
set firewall name      Dalaran_2_out  description 'IPV6 Dalaran to out'
set firewall name      Dalaran_2_out  enable-default-log
set firewall ipv6-name Dalaran6_2_out default-action reject
set firewall ipv6-name Dalaran6_2_out description 'IPv6 Dalaran to out'
set firewall ipv6-name Dalaran6_2_out enable-default-log

set firewall name      Dalaran_2_out  rule 1 action drop
set firewall name      Dalaran_2_out  rule 1 description 'Drop invalid state'
set firewall name      Dalaran_2_out  rule 1 state invalid enable
set firewall ipv6-name Dalaran6_2_out rule 1 action drop
set firewall ipv6-name Dalaran6_2_out rule 1 description 'Drop invalid state'
set firewall ipv6-name Dalaran6_2_out rule 1 state invalid enable

set firewall name      Dalaran_2_out  rule 2 action accept
set firewall name      Dalaran_2_out  rule 2 description 'Allow established/related'
set firewall name      Dalaran_2_out  rule 2 state established enable
set firewall name      Dalaran_2_out  rule 2 state related enable
set firewall ipv6-name Dalaran6_2_out rule 2 action accept
set firewall ipv6-name Dalaran6_2_out rule 2 description 'Allow established/related'
set firewall ipv6-name Dalaran6_2_out rule 2 state established enable
set firewall ipv6-name Dalaran6_2_out rule 2 state related enable

# Dalaran-2-local
set firewall name      Dalaran_2_local  default-action reject
set firewall name      Dalaran_2_local  description 'IPV6 Dalaran to local'
set firewall name      Dalaran_2_local  enable-default-log
set firewall ipv6-name Dalaran6_2_local default-action reject
set firewall ipv6-name Dalaran6_2_local description 'IPv6 Dalaran to local'
set firewall ipv6-name Dalaran6_2_local enable-default-log

set firewall name Dalaran_2_local rule 201 action accept
set firewall name Dalaran_2_local rule 201 description DNS
set firewall name Dalaran_2_local rule 201 log disable
set firewall name Dalaran_2_local rule 201 destination port 53
set firewall name Dalaran_2_local rule 201 protocol tcp_udp

set firewall name Dalaran_2_local rule 202 action accept
set firewall name Dalaran_2_local rule 202 description DHCP
set firewall name Dalaran_2_local rule 202 log disable
set firewall name Dalaran_2_local rule 202 destination port 67,68
set firewall name Dalaran_2_local rule 202 protocol udp

set firewall name Dalaran_2_local rule 203 action accept
set firewall name Dalaran_2_local rule 203 description NTP
set firewall name Dalaran_2_local rule 203 log disable
set firewall name Dalaran_2_local rule 203 destination port 123
set firewall name Dalaran_2_local rule 203 protocol udp

# Booty-Bay-2-in
set firewall name      Booty-Bay_2_in  default-action accept
set firewall name      Booty-Bay_2_in  description 'IPV6 Booty-Bay to in'
set firewall name      Booty-Bay_2_in  enable-default-log
set firewall ipv6-name Booty-Bay6_2_in default-action accept
set firewall ipv6-name Booty-Bay6_2_in description 'IPv6 Booty-Bay to in'
set firewall ipv6-name Booty-Bay6_2_in enable-default-log

# Booty-Bay-2-out
set firewall name      Booty-Bay_2_out  default-action reject
set firewall name      Booty-Bay_2_out  description 'IPV6 Booty-Bay to out'
set firewall name      Booty-Bay_2_out  enable-default-log
set firewall ipv6-name Booty-Bay6_2_out default-action reject
set firewall ipv6-name Booty-Bay6_2_out description 'IPv6 Booty-Bay to out'
set firewall ipv6-name Booty-Bay6_2_out enable-default-log

set firewall name      Booty-Bay_2_out  rule 1 action drop
set firewall name      Booty-Bay_2_out  rule 1 description 'Drop invalid state'
set firewall name      Booty-Bay_2_out  rule 1 state invalid enable
set firewall ipv6-name Booty-Bay6_2_out rule 1 action drop
set firewall ipv6-name Booty-Bay6_2_out rule 1 description 'Drop invalid state'
set firewall ipv6-name Booty-Bay6_2_out rule 1 state invalid enable

set firewall name      Booty-Bay_2_out  rule 2 action accept
set firewall name      Booty-Bay_2_out  rule 2 description 'Allow established/related'
set firewall name      Booty-Bay_2_out  rule 2 state established enable
set firewall name      Booty-Bay_2_out  rule 2 state related enable
set firewall ipv6-name Booty-Bay6_2_out rule 2 action accept
set firewall ipv6-name Booty-Bay6_2_out rule 2 description 'Allow established/related'
set firewall ipv6-name Booty-Bay6_2_out rule 2 state established enable
set firewall ipv6-name Booty-Bay6_2_out rule 2 state related enable

# Booty-Bay-2-local
set firewall name      Booty-Bay_2_local  default-action reject
set firewall name      Booty-Bay_2_local  description 'IPV6 Booty-Bay to local'
set firewall name      Booty-Bay_2_local  enable-default-log
set firewall ipv6-name Booty-Bay6_2_local default-action reject
set firewall ipv6-name Booty-Bay6_2_local description 'IPv6 Booty-Bay to local'
set firewall ipv6-name Booty-Bay6_2_local enable-default-log

set firewall name Booty-Bay_2_local rule 201 action accept
set firewall name Booty-Bay_2_local rule 201 description DNS
set firewall name Booty-Bay_2_local rule 201 log disable
set firewall name Booty-Bay_2_local rule 201 destination port 53
set firewall name Booty-Bay_2_local rule 201 protocol tcp_udp

set firewall name Booty-Bay_2_local rule 202 action accept
set firewall name Booty-Bay_2_local rule 202 description DHCP
set firewall name Booty-Bay_2_local rule 202 log disable
set firewall name Booty-Bay_2_local rule 202 destination port 67,68
set firewall name Booty-Bay_2_local rule 202 protocol udp

set firewall name Booty-Bay_2_local rule 203 action accept
set firewall name Booty-Bay_2_local rule 203 description NTP
set firewall name Booty-Bay_2_local rule 203 log disable
set firewall name Booty-Bay_2_local rule 203 destination port 123
set firewall name Booty-Bay_2_local rule 203 protocol udp

# Gadgetzan-2-in
set firewall name      Gadgetzan_2_in  default-action accept
set firewall name      Gadgetzan_2_in  description 'IPV6 Gadgetzan to in'
set firewall name      Gadgetzan_2_in  enable-default-log
set firewall ipv6-name Gadgetzan6_2_in default-action accept
set firewall ipv6-name Gadgetzan6_2_in description 'IPv6 Gadgetzan to in'
set firewall ipv6-name Gadgetzan6_2_in enable-default-log

# Gadgetzan-2-out
set firewall name      Gadgetzan_2_out  default-action reject
set firewall name      Gadgetzan_2_out  description 'IPV6 Gadgetzan to out'
set firewall name      Gadgetzan_2_out  enable-default-log
set firewall ipv6-name Gadgetzan6_2_out default-action reject
set firewall ipv6-name Gadgetzan6_2_out description 'IPv6 Gadgetzan to out'
set firewall ipv6-name Gadgetzan6_2_out enable-default-log

set firewall name      Gadgetzan_2_out  rule 1 action drop
set firewall name      Gadgetzan_2_out  rule 1 description 'Drop invalid state'
set firewall name      Gadgetzan_2_out  rule 1 state invalid enable
set firewall ipv6-name Gadgetzan6_2_out rule 1 action drop
set firewall ipv6-name Gadgetzan6_2_out rule 1 description 'Drop invalid state'
set firewall ipv6-name Gadgetzan6_2_out rule 1 state invalid enable

set firewall name      Gadgetzan_2_out  rule 2 action accept
set firewall name      Gadgetzan_2_out  rule 2 description 'Allow established/related'
set firewall name      Gadgetzan_2_out  rule 2 state established enable
set firewall name      Gadgetzan_2_out  rule 2 state related enable
set firewall ipv6-name Gadgetzan6_2_out rule 2 action accept
set firewall ipv6-name Gadgetzan6_2_out rule 2 description 'Allow established/related'
set firewall ipv6-name Gadgetzan6_2_out rule 2 state established enable
set firewall ipv6-name Gadgetzan6_2_out rule 2 state related enable

# Gadgetzan-2-local
set firewall name      Gadgetzan_2_local  default-action reject
set firewall name      Gadgetzan_2_local  description 'IPV6 Gadgetzan to local'
set firewall name      Gadgetzan_2_local  enable-default-log
set firewall ipv6-name Gadgetzan6_2_local default-action reject
set firewall ipv6-name Gadgetzan6_2_local description 'IPv6 Gadgetzan to local'
set firewall ipv6-name Gadgetzan6_2_local enable-default-log

set firewall name Gadgetzan_2_local rule 201 action accept
set firewall name Gadgetzan_2_local rule 201 description DNS
set firewall name Gadgetzan_2_local rule 201 log disable
set firewall name Gadgetzan_2_local rule 201 destination port 53
set firewall name Gadgetzan_2_local rule 201 protocol tcp_udp

set firewall name Gadgetzan_2_local rule 202 action accept
set firewall name Gadgetzan_2_local rule 202 description DHCP
set firewall name Gadgetzan_2_local rule 202 log disable
set firewall name Gadgetzan_2_local rule 202 destination port 67,68
set firewall name Gadgetzan_2_local rule 202 protocol udp

set firewall name Gadgetzan_2_local rule 203 action accept
set firewall name Gadgetzan_2_local rule 203 description NTP
set firewall name Gadgetzan_2_local rule 203 log disable
set firewall name Gadgetzan_2_local rule 203 destination port 123
set firewall name Gadgetzan_2_local rule 203 protocol udp

# TV-2-Local
set firewall name TV_2_Local default-action drop
set firewall name TV_2_Local description 'TV-2-Local'
set firewall name TV_2_Local enable-default-log

set firewall name TV_2_Local rule 101 action accept
set firewall name TV_2_Local rule 101 description 'Allow IPTV Multicast UDP'
set firewall name TV_2_Local rule 101 destination address 224.0.0.0/4
set firewall name TV_2_Local rule 101 log disable
set firewall name TV_2_Local rule 101 protocol udp
set firewall name TV_2_Local rule 101 source

set firewall name TV_2_Local rule 102 action accept
set firewall name TV_2_Local rule 102 description 'Allow IGMP'
set firewall name TV_2_Local rule 102 log disable
set firewall name TV_2_Local rule 102 protocol igmp
```

## assign firewall rules to interfaces
On a **edgerouter** you need to assign all firewall rules to an interface. 
```
set interfaces ethernet eth0 vif 7 pppoe 0 firewall local name      WAN_2_LOCAL
set interfaces ethernet eth0 vif 7 pppoe 0 firewall local ipv6-name WAN6_2_LOCAL
set interfaces ethernet eth0 vif 7 pppoe 0 firewall in name      WAN_2_IN
set interfaces ethernet eth0 vif 7 pppoe 0 firewall in ipv6-name WAN6_2_IN
set interfaces ethernet eth0 vif 7 pppoe 0 firewall out name      WAN_2_out
set interfaces ethernet eth0 vif 7 pppoe 0 firewall out ipv6-name WAN6_2_out

set interfaces ethernet eth0 vif 8 firewall local name TV_2_Local

set interfaces ethernet eth1 firewall in name Ironforge_2_in
set interfaces ethernet eth1 firewall in ipv6-name Ironforge6_2_in
set interfaces ethernet eth1 firewall local name Ironforge_2_local
set interfaces ethernet eth1 firewall local ipv6-name Ironforge6_2_local 
set interfaces ethernet eth1 firewall out name Ironforge_2_out
set interfaces ethernet eth1 firewall out ipv6-name Ironforge6_2_out

set interfaces ethernet eth2 vif 37 firewall local name      Dalaran_2_local
set interfaces ethernet eth2 vif 37 firewall local ipv6-name Dalaran6_2_local
set interfaces ethernet eth2 vif 37 firewall in name      Dalaran_2_in
set interfaces ethernet eth2 vif 37 firewall in ipv6-name Dalaran6_2_in
set interfaces ethernet eth2 vif 37 firewall out name      Dalaran_2_out
set interfaces ethernet eth2 vif 37 firewall out ipv6-name Dalaran6_2_out

set interfaces ethernet eth2 vif 50 firewall local name      Booty-Bay_2_local
set interfaces ethernet eth2 vif 50 firewall local ipv6-name Booty-Bay6_2_local
set interfaces ethernet eth2 vif 50 firewall in name      Booty-Bay_2_in
set interfaces ethernet eth2 vif 50 firewall in ipv6-name Booty-Bay6_2_in
set interfaces ethernet eth2 vif 50 firewall out name      Booty-Bay_2_out
set interfaces ethernet eth2 vif 50 firewall out ipv6-name Booty-Bay6_2_out

set interfaces ethernet eth2 vif 101 firewall local name      Gadgetzan_2_local
set interfaces ethernet eth2 vif 101 firewall local ipv6-name Gadgetzan6_2_local
set interfaces ethernet eth2 vif 101 firewall in name      Gadgetzan_2_in
set interfaces ethernet eth2 vif 101 firewall in ipv6-name Gadgetzan6_2_in
set interfaces ethernet eth2 vif 101 firewall out name      Gadgetzan_2_out
set interfaces ethernet eth2 vif 101 firewall out ipv6-name Gadgetzan6_2_out
```

## NAT
I need also a NAT to source NAT my whole IPv4 network. 
```
set service nat rule 5010 description 'masquerade for WAN'
set service nat rule 5010 outbound-interface pppoe0
set service nat rule 5010 type masquerade
set service nat rule 5010 protocol all
```

# ICMP proxy for TV
To make the TV working I need to enable multicast. 
```
set protocols igmp-proxy interface eth2.101 alt-subnet 0.0.0.0/0
set protocols igmp-proxy interface eth2.101 role downstream
set protocols igmp-proxy interface eth2.101 threshold 1
set protocols igmp-proxy interface eth2.101 whitelist 239.35.0.0/16
set protocols igmp-proxy interface eth0.8 alt-subnet 0.0.0.0/0
set protocols igmp-proxy interface eth0.8 role upstream
set protocols igmp-proxy interface eth0.8 threshold 1
```


At the end save the configuration and you are ready to go. 
