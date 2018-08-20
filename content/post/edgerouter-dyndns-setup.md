+++
title = "how to setup dynDNS on a edgerouter with cloudflare"
date = "2018-08-14"
description = "How to setup dynDNS with cloudflare on a edgrouter lite."
tags = [ "ubnt", "DNS", "router", "cloudflare" ]
categories = [
  "network",
  "HowTo"
]
+++

I use the free cloudflare DNS service for my private domain. I also want to use this for my dynDNS setup. I the last year **ubnt** have updated the *ddclient* on the **edgeOS** for the cloudflareV4 API. Now the setup work easy out of the box. 

Just you the following snippet:

```
set service dns dynamic interface pppoe0 service custom-cloudflare protocol cloudflare
set service dns dynamic interface pppoe0 service custom-cloudflare host-name FQDN_to_update
set service dns dynamic interface pppoe0 service custom-cloudflare login CLOUDFLARE_USER
set service dns dynamic interface pppoe0 service custom-cloudflare password API_KEY 
set service dns dynamic interface pppoe0 service custom-cloudflare options "zone=YOUR_ZONE use=web ssl=yes"
```

At the end save the configuration and you are done. 
