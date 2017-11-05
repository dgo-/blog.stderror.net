+++
title = "Google File Stream Disaster"
date = "2017-11-01T10:06:08+01:00"
description = "I tryed the new google file stream application and it was a disaster"
tags = [ "gsuite", "rant", "google file stream"  ]
categories = [  "cloud", "rant" ]
+++
Because I switch my mail system from decided server to googles gsuite. I want to try google new file stream application for **google drive**. 

First I only tested the mac version. So I can not talk over the windows version. 
 
## Why I have a look to Google File Stream
I am already a **Gsuite** and a Dropbox customer. So I try to give **Google Drive** with the new File Stream client a chance. So I don't have to pay both servies and safe some money. 

## Google File Stream replace Google Backup and Sync
Google launched their new **File Stream** application on 26 of September this year. To replace the old google drive client for the **Gsuite** customers. [Here](https://support.google.com/a/answer/7491633?hl=en) you can find a comparison of the clients.

### What are the new features of Google File Stream
Under the hood google have change a lot of things. But I think they only ship some new feature for endusers.
* Access files in Team Drives
* Stream files on demand
* Sync only individual files

There are great new features for teams and to work together. 

## My criticism of the File Stream client
During my test phase I find some **concerns** for the use of File stream. I will give you and short overview.

### own FUSE filesystem
Google build there own **[FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace)** filesystem for File Stream. FUSE filesystem are running in the userspace and are not integratet in the kernel. Because of the they are much slower the normale filesystem. Also you don't be able to fast move file to the File Stream folder, because you have copy the whole file and not simple map the file to a diffrent folder. MacOS list filesystem in the finder list and you can simple umount the filesystem, in most case you don't want to umount the google drive filesystem. In my opinion this is not really userfriendly. To get the Google File Stream running you have to enable it in system prefences. If you don't allow it the client always crash without a useful error message.  

### slow upload rates
I my test the upload was between 100kbit and 250kbit. So my files will take 3 weeks to upload. That is definite to long. My internet connection have an upload speed for 1Mbit. So if Google give me full upload speed I have to upload my files in around 3 days. 

### ugly client 
The File Stream client look a little bit like: "Hey we have to ship the product next week, but we have no GUI! Let's build a same webview app" I my test the client was really slow, not often update the client that are uploaded. 

### own files not local anymore
You have to configure the the client keep your files local by default all files are only in the cloud. This I a nice feature for **Team Drives** but not for your own folder. 

## Conclusion
I will not using Google File Stream and stay by Dropbox. In fact the overall performace is to slow for me. 

