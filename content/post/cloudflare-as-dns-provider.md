+++
title = "Cloudflare as DNS Provider"
date = "2017-10-31T15:29:43+01:00"
description = ""
tags = [ "cloudflare", "DNS" ]
categories = [  "cloud" ]
+++
I switched my [DNS](https://en.wikipedia.org/wiki/Domain_Name_System) server Provider to [cloudflare](https://www.cloudflare.com/). I only switch the DNS server provider not the DNS register Service. 

## How to switch the DNS servers to cloudflare
It is really simple to switch your DNS server to cloudflare. The documentation from cloudflare is really straight forward. After you create a cloudflare account you will guide step by step throw the setup. 

Here I will give a short list what to do to setup [cloudflare DNS](https://www.cloudflare.com/dns/).

* First you have to create a cloudflare account. 
* Enter your domain to cloudflare (cloudflare get all your DNS entries for your old DNS Server. So don't have to copy all DNS records by your self.)
* Now you cloudflare give you your new DNS Server. You have to give this server now to your DNS registrar to switch the NS entries for your domain. 
* After your registrar change the NS records you swtched your DNS to cloudflare. 

## Advantages of cloudflare nameserver
Cloudflare have a lot of advantages here I will name the most importent for me:
* Global AnyCast DNS
cloudflare not only have 2 DNS Server. The have globle DNS system with 30 location in europa. So your request can get a really fast response from anywhere. [Here](https://www.cloudflare.com/network/) you find more for the cloudflare network. 
* simple Webinterface
Cloudflare have a really good webinterface. It is simple but have all functions you need. 
* Support DNSSEC
Cloudflare DNS system support [DNSSEC](https://www.cloudflare.com/dns/dnssec/) method. 
* free of charge
For personal use cloudflare is free. The pro plans start at 20$ a month. [Here](https://www.cloudflare.com/plans/) you can find more over cloudflare plans.

## More than DNS provider
Cloudflare is not mainly a DNS provider. The main bussines from cloudflare is being a [Content Delivery Network](https://en.wikipedia.org/wiki/Content_Delivery_Network) with DOS protection. So cloudflare will enable by default there CDN function for your websites. 

### Disable CDN 
If you have website the not should go over a the cloudflare CDN you can simple disable it by clicking on the cloud on the DNS entry row. To check if the CDN is disabled you can simple check the DNS entry with the command:
``` 
host your.website.com
```
If this command return the IP form your server than the CDN is not used. If the CDN is used the command will return the IP of the cloudflare CDN. 

