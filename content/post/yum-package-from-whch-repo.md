+++
date = "2016-03-21T22:26:32+01:00"
title = "package from which yum repo"
description = "Last week i have a problem with yum, i want so see what packages are include in a repository. This is not easy with yum, so i will share the trick here. You simple need the following commandline."
tags = [ "Centos", "Red Hat", "yum", "repo" ]
categories = [
  "Unix",
  "yum"
]
+++

Last week i have a problem with yum, i want so see what packages are include in a repository. This is not easy with yum, so i will share the trick here. You simple need the following commandline. 

```
yum --disablerepo="*" --enablerepo="$REPO" list available
```

This tell yum to disable all repositories and only enable that one you want to know and list alle packages for this repository. 

With the following command yum will show you all os it's repos:

yum repolist

Good Night,
Daniel 
