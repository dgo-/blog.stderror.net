+++
date = "2020-06-27T16:07:08+01:00"
title = "Disable debian system mails"
description = "How to disable debian system mails. for example the apt update mails"
tags = [ "mail", "debian" ]
categories = [
  "debian"
]
+++

Debian often send you local mail for updates or stuff like this, because I find it really annoying, if I get mail notification in my shell. This is stuff from the 80s and no longer needed on mordern system. 

To disable the local mails I just set a blackhole alias for my user to drop all this mails. I used this with the default debian exim config. Here is my **/etc/aliases**
```
# /etc/aliases
mailer-daemon: postmaster
postmaster: root
nobody: root
hostmaster: root
usenet: root
news: root
webmaster: root
www: root
ftp: root
abuse: root
noc: root
security: root
root: dgo
dgo: :blackhole:
```

You just have to add the **:backhole:** behind your user. The exim will drop all mails. 
