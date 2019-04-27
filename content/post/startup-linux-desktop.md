+++
title = "startup process from my Desktop Linux"
date = "2019-04-27T10:06:08+01:00"
description = "How I startup my Linux laptop up to i3"
tags = [ "LinuxOnDesktop", "Linux", "Thinkpad", "T480", "i3" ]
categories = [  "Linux", "Desktop", "i3" ]
+++
I will just explain how my laptop startup look like. One boot process from grub to login. I use Laptop only for me so I don't have to take care for multiuser. 

I try no make the boot process as minimal as possible. And require as well user interaction as possible. 

## Grub
First of all I will use grub as my bootloader to load Linux itself. 

I setup the grub timeout to 0 get get a faster boot time. 
``` /etc/default/grub
GRUB_TIMEOUT=0
```

To apply the settings I have to rebuild the grub configuration with:
```
update-grub
```

## Linux
After Linux has started it will immediately decrypt my harddrive. For that I need to insert my Key.

## Systemd
Linux will start systemd will take care of starting all oder needed processes. When the system is ready systemd will mange the autologin. I don't use a dispaly manager I just login right in to the shell. 

### systemd autologin 

I setup the autologin on the following way:

With the command following command I will create the configuration file for the login. (/etc/systemd/system/getty@tty1.service.d/override.conf)
```
systemctl edit getty@tty1
```
Add the lines to the configuration file:
```
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin USERNAME --noclear %I 38400 $TERM
```

Enable the new service in systemd
```
systemctl enable getty@tty1.service
```
At the next boot you will be log in automatically. 

## user session
I use ZSH as my login shell. It will first check if an xserver is running and we are on tty1. I do this by adding the following snippet to my .zprofile.
```
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
                  exec startx
fi
```

## xsession
The *startx* command load the .xinitrc file in my home directory. I only will explain here the importend parts of my .xinitrc file. The full file can be found in my dotfiles. 

I start my user services with systemd. Some of the application need to have information the running xserver. For application of this kind I first load the X variables in to systemd and DBUS. 
```
systemctl --user import-environment DISPLAY XAUTHORITY &
if command -v dbus-update-activation-environment >/dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY &
fi
```

To start the application with systemd I start my x target. this systemd target I includes all the service I want to start in my user session and depends on X.
```
systemctl --user start x.target & 
```
**Don't enable the target if you do this it will start before you have the variables you need**

At the end I start i3 as my display manager with:
```
exec /usr/bin/i3
``` 
