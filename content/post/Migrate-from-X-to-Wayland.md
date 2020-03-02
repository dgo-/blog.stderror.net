+++
title = "Migrate From X to Wayland"
description = "After sway was finally moved to debian testing I make the move and switch from X to wayland."
date = "2020-03-01T11:53:40+01:00"
comments = false
tags = [ "linuxondesktop", "linux", "sway", "wayland", "i3", "firefox" ]
categories = [  "Linux", "Desktop", "sway" ]
+++
I have watched the wayland now already for a long time. But I was afraid to switch on such a importent configuration in my desktop setup. Because I used i3 for long time now, because of that I want to switch direct to **sway**, but I don't want to keep track of a self compiled sway, so I waited until sway get in **Debian** testing. This finially happens in the last month.
I will write here a bit about expirence.

## launch
I have on my personal laptop no Display Manager. I start **sway** direct from my *.zprofile* After the login on **tty1**.
``` sh
# start wayland
if [ "$(tty)" = "/dev/tty1" ]; then
  export GDK_BACKEND=wayland
  export MOZ_ENABLE_WAYLAND=1
  export CLUTTER_BACKEND=wayland
  export QT_QPA_PLATFORM=wayland-egl
  export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
  export QT_WAYLAND_FORCE_DPI=phyiscal
  export ECORE_EVAS_EVAS_ENGINE=wayland_egl
  export ELM_ENGINE=wayland_egl
  export SDL_VIDEODRIVER=wayland
  export _JAVA_AWT_WM_NONREPARENTING=1

	exec sway
fi
```
I added also some environment variables here to tell application to use wayland.

In the testing phase I had my old X I3 setup running on tty1. I started wayland on **tty2** to test all changes. After I was worked as expected I commented out my X startup and switch the sway startup to **tty1**.

## sway
Because I used I3 before there was no problem to migrate to sway.

### configuration
I started from the default sway configuration and then migrate my i3 settings step by step in the sway configuration. I takes a while, but I was quite easy. For my whole configuration please check my dotfiles linked below.

## Problems

### Tray Icons
Tray Icons not working fully in sway. There I already an [issue](https://github.com/swaywm/sway/issues/3799) on github to track the progress.

### screen lock after sleep
I setup [i3lock]({{< ref "i3-lock-sleep.md" >}}) to lock my screen always before go to sleep. 

This cause problems, because systemd start always *i3lock*, but *swayidle* also start *swaylock*. The keyboard was somehow lost between them and I was not able to unlock my session.

I simple solve it by disable the i3lock:
```
sudo systemctl disable i3lock.service
```

### Firefox
To get Firefox using wayland you need to setup the environment variable **MOZ_ENABLE_WAYLAND=1**. I added it also to my *.zprofile* file. (See above)

My Firefox 68.5.0esr (Debian/bullseye) was not starting and give always the error message:
```
dbus[3833]: arguments to dbus_message_new_method_call() were incorrect, assertion "_dbus_check_is_valid_path (path)" failed in file ../../../dbus/dbus-message.c line 1366.
This is normally a bug in some application using the D-Bus library.

  D-Bus not built with -rdynamic so unable to print a backtrace
Redirecting call to abort() to mozalloc_abort
```

I found online a workaround for this by adding the option **--no-remote** to firefox then everthing works fine for me. 

There is also already a [bug](https://bugzilla.mozilla.org/show_bug.cgi?id=1551664) at mozilla,that is already fixed. The fix will be in Firefox 74. 

## conclusion
Overall the migration going really well. For the moment I have no problem. Let's see how it is going.

I not fully migrated to **wayland** I use also **xwayland**. Because many application are not support wayland yet. For exampe chrome.

## dotfiles
To have a full view about of my dotfiles check my [Repo](https://github.com/dgo-/dotfiles)
