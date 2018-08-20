+++
title = "Howto setup a IPSec VPN connection to a edgerouter"
date = "2018-08-15"
description = "How to setup a L2TP IPSec VPN with a local router on a edgerouter."
tags = [ "ubnt", "vpn", "router" ]
categories = [
  "network",
  "HowTo"
]
+++

# VPN setup
I setup an VPN with PSK for host authentication. 
```
set vpn l2tp remote-access ipsec-settings authentication mode pre-shared-secret
set vpn l2tp remote-access ipsec-settings authentication pre-shared-secret PSK
```

Configure a network range remote clients.
```
set vpn l2tp remote-access client-ip-pool start 192.168.200.100
set vpn l2tp remote-access client-ip-pool stop  192.168.200.199
```

I have a PPPOE internet connection so my IP changes sometimes, because of the I configured the IPSec Interface listen to all IPs. 
```
set vpn l2tp remote-access outside-address 0.0.0.0
set vpn ipsec ipsec-interfaces interface pppoe0
```

I set the authenication mode to local, because we want to use local user. The default is to use a radius server. 
```
set vpn l2tp remote-access authentication mode local
```

Now I can add user for my IPsec VPN. To create more then one user you have to repat this step for each user. 
```
set vpn l2tp remote-access authentication local-users username USERNAME password PASSWORD 
```

# Firewall Rules
To allow clients to connect via IPSec to your **edgerouter** we need to open the IPSec ports to LOCAL. 

```
set firewall name WAN_2_LOCAL rule 210 action accept
set firewall name WAN_2_LOCAL rule 210 description ike
set firewall name WAN_2_LOCAL rule 210 destination port 500
set firewall name WAN_2_LOCAL rule 210 log disable
set firewall name WAN_2_LOCAL rule 210 protocol udp

set firewall name WAN_2_LOCAL rule 211 action accept
set firewall name WAN_2_LOCAL rule 211 description esp
set firewall name WAN_2_LOCAL rule 211 log disable
set firewall name WAN_2_LOCAL rule 211 protocol esp

set firewall name WAN_2_LOCAL rule 212 action accept
set firewall name WAN_2_LOCAL rule 212 description nat-t
set firewall name WAN_2_LOCAL rule 212 destination port 4500
set firewall name WAN_2_LOCAL rule 212 log disable
set firewall name WAN_2_LOCAL rule 212 protocol udp

set firewall name WAN_2_LOCAL rule 213 action accept
set firewall name WAN_2_LOCAL rule 213 description l2tp
set firewall name WAN_2_LOCAL rule 213 destination port 1701
set firewall name WAN_2_LOCAL rule 213 ipsec match-ipsec
set firewall name WAN_2_LOCAL rule 213 log disable
set firewall name WAN_2_LOCAL rule 213 protocol udp
```

At the end save your configuration an try to connect to the VPN. 
