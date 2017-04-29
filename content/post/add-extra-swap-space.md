+++
title = "add extra swap space"
date = "2016-12-01"
description = "When you temporary need more Memory, maybe to open a large heap dump or something else. You can simple create a file and use it as swap extra space."
tags = [ "swap", "extra", "space" ]
categories = [
  "Unix"
]
+++

## Why i need swap
Swap is space on the hard disk to where the operating system can store data the does not fit on in the memory any more. The Swap Space is part of the virtual memory. Every time when the system runs out of memory, the operating system begins the write the old and not often used part from memory to the swap pace on the hard drive. 

It is significantly slower to access the data from the swap space as from the main memory. When your computer all the time use the swap it becomes slow, because the wait every time to get the data back from disk to the memory. When you often use a lot of swap space you maybe consider to upgrade your RAM. 

When you temporary need more Memory, maybe to open a large heap dump or something else. You can simple create a file and use it as swap extra space. 

## Create a swap file
Before you create an swap file you must check if you have enough free space on your disk. Simple run the following command: 

```bash
df -h
```

Now you can choose one of your partions to get to put the swap file on it. In this example I will place the swap file under / and name it *exra-swap*. 

A simple way to create a fix size swap file is to use the programm **fallocate**. 

We want to create a 4GB swap file. 
```bash
sudo fallocate -l 4G /extra-swap
```

After the creation of the swap file we change the right to 600. So only root can access the swap file. If all user can read the swap file it is a security risk, because some user can read password stored in memory from an order user. 
```bash
sudo chmod 600 /extra-swap
```

Now we can check if everything going well.
```bash
ls -lh  /extra-swap
```

## Start using the swap file
To use our new swap file we must first initialize the swap file 

```bash
sudo mkswap /extra-swap
```

Now we are ready to assign your file to the swap. 
```bash
sudo swapon /extra-swap
```

To see if the swap space is working we can use htop, top or just free. 
```bash
free -h
```

## Make swap file persistent
If need the extra swap often we can make it persistent. So the system use our swap file after a reboot again to swap data. This is really simple we just have to add one line to the */etc/fstab*
```
/extra-swap none swap sw 0 0
```
