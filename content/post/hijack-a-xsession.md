+++
date = "2017-01-15T22:26:32+01:00"
title = "hijack a xsession"
description = "In this actricle I will describe how to hijack a X session from a diffrent user. So you are able to start X application in a diffrent user session, maybe open an browser window on the screen. For this method you will probelly need root access on the mashine where the X session is running you want to hijack."
tags = [ "X", "hack", "hijack", "Xsession" ]
categories = [
  "X",
  "Unixx",
  "Hack"
]
+++

In this actricle I will describe how to hijack a X session from a diffrent user. So you are able to start X application in a diffrent user session, maybe open an browser window on the screen. For this method you will probelly need root access on the mashine where the X session is running you want to hijack. 

## X11 security model
The X11 security model is preety simple. You only have to know two diffrent things to connect to the Xserver.

### X Display
The display is mostly something like :0 or :1. The first X11 display is :0 and :1 is the second display on the local mashine. At an xsession startup the envirmentvariable $DISPLAY will be set with display. Any X11 application uses this variable to determine how to contact the X11 server and show it's windows when it starts up.

To get all locally available active displays you can run the following command.
``` bash
ls -l /tmp/.X11-unix/
``` 
This will show something like this:

```
srwxrwxrwx 1 gdm          gdm   0 Jan  2 08:42 X0
srwxrwxrwx 1 bob          users 0 Jan  2 08:42 X1
```

This show you the a GDM is running and on display :0. Also an user bob is login on display :1. 

### X11 Magic Cookie
The second thing you have to know to connect to the Xserver is the cookie. This is the secret to connect to the Xserver if you have no right screct the connection will be dropped. The cookies ontain just a random string and are stored in your home in the .Xauthority file. You also can look add the cookies with the xauth(1) command. 

``` bash
-rw------- 1 bob users 663 Jan 10 11:46 .Xauthority

xauth list
10.0.3.1:0  MIT-MAGIC-COOKIE-1  9dc4e1e8469218001b2455ea39902f3b
mashine/unix:50  MIT-MAGIC-COOKIE-1  1b3c9c6a8101149edaa2e5033566b1d7
``` 

## hijack the xsession
So now you can use your knowledge to hijack the xsession. So in this example I will remote login to bobs mashine by ssh as root. 

First we need the display what used for bobs session. Above we find out the bobs session is running on display 1. Now we set your $DISPLAY variable to display 1. 

``` bash
DISPLAY=:1
export DISPLAY
```

Ok half way done. So now we need the cookies from bob. As root this is no problem, we simple can you the Xauthority in the home from bob. I will show how this works below.

``` bash
xauth list
xauth:  creating new authority file /root/.Xauthority
  
XAUTHORITY=/home/bob/.Xauthority
export XAUTHORITY
  
xauth list
10.0.3.1:0  MIT-MAGIC-COOKIE-1  9dc4e1e8469218001b2455ea39902f3b
mashine/unix:50  MIT-MAGIC-COOKIE-1  1b3c9c6a8101149edaa2e5033566b1d7
```

Done! Now all X application we open will use the Display and cookies from bob. At this point we are able to open windows on this screen. So if I run xclock like in the following example the application will show on this screen. 

``` bash
xclock &
```

This is very helpfull the show notification on the screen from user or to anger your colleagues. 

Good night,
Daniel
