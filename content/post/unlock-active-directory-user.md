+++
date = "2016-10-23T22:26:32+01:00"
title = "unlock an active directory user"
description = "In common active directory enviorment the user account will be locked after some failed login attempt. This is a security mechamisen against brute-force attack to find out the account password. Often this is to secure for the users so they will lock their useraccount by her self. It is a common admin task to free the user. The way over the default windows mmc take often much time."
tags = [ "user", "unlock", "windows", "Active Diretory", "Perl" ]
categories = [
  "Windows",
  "Active Directory"
]
+++
in common active directory enviorment the user account will be locked after some failed login attempt. This is a security mechamisen against brute-force attack to find out the account password. 

Often this is to secure for the users so they will lock their useraccount by her self. It is a common admin task to free the user. The way over the default windows mmc take often much time. 

But it is quite simple to script the unlock process. The locked state hold in the active directory attribute "lockoutTime". If an account is locked in this field contains the time when the account was locked. To unlock the account you can simple write a 0 in the field and the user is free again. 

I build a script for myself to save me some importent lifetime. You can find the script in my github bin repository here is the link. 
https://github.com/dgo-/bin

Good Night,
Daniel
