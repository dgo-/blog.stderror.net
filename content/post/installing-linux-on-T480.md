+++
title = "Installing Linux on T480"
date = "2019-03-19T10:06:08+01:00"
description = "How to install Debian GNU/Linux on my new Thinkpad T480. What is working what's not. Using i3 as my Window Manager"
tags = [ "LinuxOnDesktop", "Linux", "Thinkpad", "T480", "i3" ]
categories = [  "Linux", "Desktop", "i3" ]
+++

## My setup 
I prefer a really minimal desktop setup. This give me the possibilty to understand most of my enviorment and in case of problem I can fast find and solve the problem. Antoher advantage is that I have more RAM free for caches and buffers, this makes the system even faster.  

I don't use a display manager. I just use i3 as my Window Manager. To manage my network connections I use NetworkManager. 

## What is working what's not
Here a short overview whats working and what is not working. 

### Wifi
The wifi is working without problems out of box. 
### Bluetooth
The Bluetooth is also working right out of box. 
### Fingerprint
The fingerprint sensor is not working because of the lack of linux drivers. 
### Touchpad
The touchpad was working after the installtion. In the debian installer I had to use the trackpoint. To get multitouch working you do a little tweaks. 
### Backlight
The backlight is working. I had some trouble with the change the brightness in I3. 
### Camera
The camera works without problems. 
### Graphics
The graphics works fine for me because I just have the onboard Intel UHD 620. 

## Installation
I use my laptop in UEFI Mode. The debian installer works quite well with the T480. You can just install it, the only part where you have to think is the partion layout with encryption. 

### harddrive
I have 4 partions 
* /
* /boot
* /boot/efi
* /swap

I only encrypt **/** because it is most easy solution. Of course it not the most secure solution but for me it is enough. 
 

