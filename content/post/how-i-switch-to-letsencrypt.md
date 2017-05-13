+++
date = "2017-05-13T16:07:08+01:00"
title = "How I switch to letsencrypt"
description = ""
tags = [ "TLS", "letsencrpt" ]
categories = [
  "letsencrypt"
]
+++
I switch this year all my TLS certificates from CAcert to Let's Encrypt. For all my personal webservers and mailservers. 

## What I want from TLS certificates
For my personal stuff I only want to provide encryption for my websites and mail. I don't need some stong identity checks. The certificates should trusted by the most common devices so I don't need to import the CA all the time and the visitors on my websites get no warning messages. 

## Why I switch from CAcert to Let' Encrypt
I stay for around 5 years with CAcert. I think it was a good social Certificate Authority, but it never got into the common browser an operating systems. I think Let's Encrypt will kill CAcert, because only real advantage form CAcert was that the certificates has no cost. A lot of CAcert user will switch to Let's encrypt, because the certificates are also free and trusted. 
Let's Encrypt have another big advantage the to can renew your certificates automatically. Who have never forgotten to renew an TLS certficate?

## Setup Let's Encrypt
For most Linux distribution Let's Encrpyt ship the [cerbot](https://certbot.eff.org/) tool, which is used to create and renew the certificates. I don't want the an application updates my webserver configuration so I only use it to create a certificate and make the configuration by myself. I used the webroot method to verfiy the request. In this method certbot place to data in your document root to veryfiy the you control the domain. 

### Services
I used the following services whitout problems with Let's Encrypt:

* nginx
* dovecot
* postfix

Not forget to restart the services after you renew a certificate! 


Good Night, <br>
Daniel 
