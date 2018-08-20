+++
title = "how to base setup a edgerouter"
date = "2018-08-13"
description = "HowTo configura make the basic configuration on a edgerouter lite from ubnt."
tags = [ "ubnt", "router" ]
categories = [
  "network",
  "HowTo"
]
+++

I use since some year the [edgerouter lite](https://www.ubnt.com/edgemax/edgerouter-lite/) from ubnt. I am total happy with this device it have a solid performace and is really feature rich. The core OS is OpenSource.  

Today I will you some of the basic configuration for an **edgerouter**. I did my configuration mostly over the CLI. So simple login to your router via ssh. 

To go in the *configuration* mode you need to typ: 
```
configure
```

# DNS settings
## Hostname
Simple set the hostname.
```
set system host-name $FQDN
``` 

## Domain name
Set the domain for the device.
```
set system domain-name $DOMAIN
```

## Local DNS cache
I use my **edgerouter** as local DNS resolver in my networks. I you here the google and cloudflare DNS servers with IPv6 and IPv4. 
``` 
set service dns forwarding cache-size 3000
set service dns forwarding name-server 2001:4860:4860::8888
set service dns forwarding name-server 2606:4700:4700::1111
set service dns forwarding name-server 8.8.8.8
set service dns forwarding name-server 1.1.1.1
```

I limit the DNS access to my networks, so I disable here my WAN interface. 
```
set service dns forwarding except-interface eth0
set service dns forwarding except-interface eth0.7
set service dns forwarding except-interface eth0.8
```

# User
Setup your own admin user.
```
set system login user USER authentication plaintext-password PASSWORD
set system login user USER level admin
```

Remove the default admin user.
```
delete system login user ubnt
```

# Hardware Offloading:
To get the real performace for the small router you need to enable hardware offloading. So the router use the hardware acceleration.
```
set system offload ipv4 forwarding enable
set system offload ipv4 gre enable
set system offload ipv4 pppoe enable
set system offload ipv4 vlan enable
set system offload ipv6 forwarding enable
set system offload ipv6 pppoe disable
set system offload ipv6 vlan enable
```
Note: I disable pppoe offloading for IPv6, because the edgrouter lite not support IPv6 pppoe and vlan offloading on the same time. So I disabled IPv6 because my pppoe session is IPv4. 

# Configuration 

With *commit* you apply the configuration and with *save* you make the configuration reboot save.
```
commit
save
```


