+++
date = "2016-12-26T16:07:08+01:00"
title = "timestamp"
description = "In the shell you can easy get a unix timestamp when you enter the following command"
tags = [ "time", "timestamp" ]
categories = [
  "Unix"
]
+++

I often need timestamp on the commandline or in scripts to save files with the exact time. 

In the shell you can easy get a unix timestamp when you enter the following command:
``` bash
date +%s
```
You can now simple save a mysqldump from with the exact time in the filename. 

``` bash
mysqldump DATABSE > DATABASE-`date +%s`.sql
```

Also you are able to create a bash/zsh alias for the timestamp. Just put the follwing line in your shell configuration:

``` bash
alias timestamp = date +%s
```

Good Night,
Daniel
