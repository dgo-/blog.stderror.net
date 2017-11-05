+++
title = "Host Static Hugo Website on S3 With Cloudflare"
date = "2017-10-31T18:44:50+01:00"
description = ""
tags = [ "aws", "cloudflare", "S3", "hugo" ]
categories = [  "cloud" ]
+++
I migrate my personal website from a decided server to a more modern cloud solution. I used the [aws S3 Service](https://aws.amazon.com/s3/) as basic file store and webserver. After that I use the free [cloudflare service](https://www.cloudflare.com/) to enable TLS on my site. 

## Generate the website
For my personal website I use the [hugo website generator](https://gohugo.io/). I used hugo because it is a lite fast app to generate static website from markdown files. Hugo perpare a directory that  everything contains that is needed for the website. So I simple can upload this directory to my S3 bucket. 

With the following command hugo build for site.
```
hugo --quiet
```

### advantages from static websites
I like static websites for sites where the content not needed to change dynamically. By this sites static content have in my opinion serveral advantages:
* fast
* secure 
* resource saving

## use aws S3 as webserver
First you have to create a new bucket for your website. Note that each bucket name have to be unique. So you can simple us for domain name *www.example.com*. To tell S3 to act as webserver you need to enable the option *Static website hosting*. Here you also need to enter an Document index, which is usually *index.html*. You also able to enter an error page here. That all you need to setup S3 to act as Webserver for your website.  

Now S3 show you the URL for your website. This is looking something like this *http://www.example.com.s3-website.eu-central-1.amazonaws.com*.
### upload the website to S3 bucket
I use the [s3cmd app](http://s3tools.org/s3cmd) to upload my website to S3. 

You can simply upload for site with the command. 
```
s3cmd sync  public/ s3://www.example.com --exclude '.DS_Store' --delete-removed
```
I exclude *.DS_Store* files and remove files not longer needed from S3. 

## set cloudflare in front of your website
To setup cloudflare you login to cloudflare and go to the DNS tab. Here you just have to add a new **CNAME** record to your zone the points to your AWS S3 domain. Make sure that you enable CDN. 

## conclusion
That it now you have a website with global CDN in front, with SSL, and without managing a whole server. 

