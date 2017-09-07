+++
date = "2017-09-05T16:07:08+01:00"
title = "OpenMange failure after update"
description = "How to fix OpenManage failure after update"
tags = [ "OpenManage", "nagios"  ]
categories = [
  "Unix"
]
+++

If you use the [OpenManage](http://linux.dell.com/repo/hardware/omsa.html) tools from Dell to monitor the server hardware maybe with nagios or something else. You may have notice the after an update from the OpenManage Tools showing something like the following error. 

```
UNKNOWN: Storage Error! No controllers found
UNKNOWN: Problem running 'omreport chassis memory': Error: Memory object not found
UNKNOWN: Problem running 'omreport chassis fans': Error! No fan probes found on this system.
UNKNOWN: Problem running 'omreport chassis temps': Error! No temperature probes found on this system.
UNKNOWN: Problem running 'omreport chassis volts': Error! No voltage probes found on this system.
WARNING: Chassis Service Tag is bogus: 'N/A'
```

This looks like your hole server is gone. But you only have to restart all OpenManage services. After the your server is ready again. 
Here the commands to restart the services. 

``` bash
service dataeng stop
service dsm_sa_ipmi start
service dataeng start
```

