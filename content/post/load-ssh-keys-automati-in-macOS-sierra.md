+++
date = "2017-12-26T16:07:08+01:00"
title = "use ssh with keychain on macOS sierra"
description = "load ssh keys automatic in macOS sierra"
tags = [ "ssh", "macOS", "sierra" ]
categories = [
  "macOS",
  "ssh"
]
+++

Since macOS sierra ssh **not automaticly** use the the passhrase from the keychain. You have to **configure** ssh to use the **keychain** to lookup the passhrase. 

In this snippet from my *~/ssh/config* I enable the keychain with *UseKeychain yes*. The *AddKeysToAgent yes* line load the key by the frist use in the ssh agent. With *IdentityFile* I added my two ssh keys. 

``` ssh
Host *
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa
  IdentityFile ~/.ssh/id_ed25519
```

After you configure ssh you have to save the passphrase in the keychain you can do this with the following command. 
``` bash
ssh-add -K
# if you have a keyfile with a now default name
ssh-add -K $keyfile
```

Good Night,
Daniel
