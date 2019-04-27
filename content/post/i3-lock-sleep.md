+++
title = "How to lock for i3 computer"
date = "2019-04-27T10:06:08+01:00"
description = "How I lock my i3 laptop."
tags = [ "LinuxOnDesktop", "Linux", "Thinkpad", "T480", "i3" ]
categories = [  "Linux", "Desktop", "i3" ]
+++

I have two method to lock my screen. One is to close just the cover from my T480. And the second is to just press and hotkey. 

## i3lock
I use the i3 own screenlocker tool i3lock. It is really soild and only do the needful. Nothing more no bloat. 

There the basic i3lock command I use:
```
i3lock -i ~/.config/i3/lock.png -f
```
* -i give the picture shown from i3lock
* -f show the number of failed attempts

## Lock i3 with hotkey
I simply bind the lock function to F12. So I am able to really fast lock the computer, just by pressing one key. For that I just add one line to my i3 config file. 
```
bindsym F12   exec i3lock -i ~/.config/i3/lock.png -f
```

## Lock i3 by close the cover
Do do this I just created a systemd service that always run if the laptop goes to sleep state. 

``` /etc/systemd/system/i3lock.service
[Unit]
Description=i3lock
Before=sleep.target

[Service]
User=USERNAME
Type=forking
Environment=DISPLAY=:0
ExecStart=/usr/bin/i3lock -i /home/USERNAME/.config/i3/lock.png -f

[Install]
WantedBy=sleep.target
``` 

To activate the service run:
```
systemctl enable i3lock.service
``` 

**This method will only be used for single user systems, because I use a gloabl systemd unit**
