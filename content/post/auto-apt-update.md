+++
title = "Automatic search for new updates with apt"
date = "2020-04-01"
description = "How to run apt update automatic perodic. Also show how your system download new updates already. Without unattended-upgrades"
tags = [ "laptop", "debian", "apt" ]
categories = [ "linuxondesktop", "debian"]
+++

I had always the problem that my system don't show me if updates are available. The most online howto just install the *unattended-upgrades* tool. But I don't want to automatic install updates because I am running debian unstable and I want to have the control over my system. 

The good thing is that everything you need for this is already installed on a debian system. You just have to configure it. 

First of all I change the the apt config under */etc/apt/apt.conf.d/10periodic*:
```
# used by: /usr/lib/apt/apt.systemd.daily 

# update package list
#  - Do "apt-get update" automatically every n-days (0=disable)
APT::Periodic::Update-Package-Lists "1";

# download upgrade packages
#  - Do "apt-get upgrade --download-only" every n-days (0=disable)
APT::Periodic::Download-Upgradeable-Packages "1";

# apt autoclean
#  - Do "apt-get autoclean" every n-days (0=disable)
APT::Periodic::AutocleanInterval "1";
```
This configuration options are read used by the script **/usr/lib/apt/apt.systemd.daily**. The will be run via **systemd** automatically. 

Now we are actually got to go. There is only one problem. The default systemd timer runs only two times a day. 
I want the the timer run every two hours, because I use a laptop and it is most not always on, because of the the timer with the default settings will not run very often. 

To change this we can simple create a systemd override for the **apt-daily.timer**. For that simple run the follwoing command:
```
systemctl edit apt-daily.timer
```

Now a editor will open with an empty file will open, add the following lines to the file and save it:
```
[Timer]
OnCalendar=0/2:00:00
```
This will let the job run every two hours. 


