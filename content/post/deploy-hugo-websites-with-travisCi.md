+++
title = "I use Travis CI to deploy my static hugo websites to S3"
date = "2019-04-27T18:06:08+01:00"
description = "In this post I will describe how I deploy my static websites made with hugo to AWS S3 with the help of Travis CI"
tags = [ "webstite", "S3", "aws", "TravisCI", "hugo" ]
categories = [  "cloud", "website" ]
+++
As I described in my [Blog Post]({{< ref "host-static-hugo-website-on-s3-with-cloudflare.md" >}}) earlier. I make my websites with [Hugo](https://gohugo.io/) a static website generator written in go. I the last post I write how to deploy the website manually to S3. 

In this post I will show you how to build the site every time you push something to the repository and push it automatically to S3. I use [Travis Ci](https://travis-ci.org/) to do the automted build and upload to S3. 

## Travis CI 

### travis.yaml
To use Travis CI you have to add a **.travis.yaml** in the root of your repository. The file is the configuration for our build. Here my configuration to build, test and deploy my websites.
``` .travis.yaml
# Auto deploy repo from Github to Amazon S3 bucket via Travis CI
# * Set env vars for ACCESS_KEY_ID, BUCKET_NAME and SECRET_ACCESS_KEY on Travis 
# * Update `bucket.name` in `sync` command
# * Assumes your `publishDir` is the default (`public`) - if not update `sync` command

language: go
before_install:
 - export NOKOGIRI_USE_SYSTEM_LIBRARIES=true
addons:
  apt:
    packages:
    - libcurl4-openssl-dev # required to avoid SSL errors
install: go get -v github.com/spf13/hugo
before_script:
  - ruby --version
  - gem install html-proofer
  - python --version
  - sudo pip install s3cmd
script:
  - hugo
  - htmlproofer public/ 
after_success:
  - s3cmd sync --delete-removed --no-preserve --acl-private --access_key=$ACCESS_KEY_ID --secret_key=$SECRET_ACCESS_KEY -r public/ s3://$BUCKET_NAME
notifications:
    email: true
```

Up to the *script* block travis is installing some dependencies. 

In the **script** block do the *real work* by generate the page and test the page with the *html-proffer* tool. 

If the *script* block run without problem it will execute the **after_script** block. In the blog travis deploy the generated website to S3. 

### Setup your repository for travis
To enable your website repo you can just enable it in the webinterface from Travis CI. 

My script also need to set up three following environment variables:
* ACCESS_KEY_ID (aws access key)
* SECRET_ACCESS_KEY (aws secrect access key)
* BUCKET_NAME (bucket name to deploy to)

Just setup the variables in the build settings webinterface. 

## S3 security
I deploy all files with the option **--acl-private** this set the ACL the only I can access the files. 
How to allow the access over cloudflare I write [here]({{< ref "limit-S3-access-to-cloudflare.md">}}).
