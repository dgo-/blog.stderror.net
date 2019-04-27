+++
title = "Use Bose QuietComfort 35 II on Linux"
date = "2019-04-27T10:06:08+01:00"
description = "Howto use the new Bose QuietComfort 35 II bluetooth headphone on my Linux(Debian buster) maschine."
tags = [ "LinuxOnDesktop", "Linux", "QuietComfort", "Bose", "QC35II", "pulseaudio" ]
categories = [  "Linux", "Desktop", "pulseaudio" ]
+++
I want to configure my new Bose QuietComfort 35 II to use them as bluetooth headphones on my Linux laptop. 

## Bluetooth
On my debian buster laptop I had no problem to pair the the QC35 II with the laptop. I just us the default blueman configuration. 

## Pulseaudio
To switch the sound after connect directly to the bluetooth headphones. I just placed one line in in the pulseaudio configuration. 

``` /etc/pulse/default.pa
load-module module-switch-on-connect
```
## Headset
I don't really get the QC35 II satisfactorily working for me. I have there mostly three issues.

* First of all if I switch the headphones to handfree mode I hear constantly noise. 
* The audio messages from the QC35 are not really useful if you use the headset on Linux Laptop as headset. If you disable the messages in the app this problem go away. 
* The automatic profile switching between A2DP and HSP/HFP was not working. To solve this I setup the **auto_switch=2** to **load-module module-bluetooth-policy** in */etc/pulse/default.pa*

Overall it is a little bit sad that the Quiet Comfort 35 II not working grat as Bluetooth Headset with Linux. If you find a way to do this please let me know. 
