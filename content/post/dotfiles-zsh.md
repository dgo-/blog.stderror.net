+++
title = "My zinit zsh setup"
description = "In this post I will write a bit over my zsh setup"
date = "2020-03-08T09:53:40+01:00"
comments = false
tags = [ "dotfiles", "zsh", "Desktop" ]
categories = [  "MyDotfiles", "Desktop", "zsh" ]
+++
I am switch now a couple of years from bash to zsh and never regrets the decision. Even apple move finally in 2019 from bash to [zsh](https://support.apple.com/en-us/HT208050).

The probaly biggest advantage from zsh are the many community projects build with and around them for example [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh). I also started with **oh-my-zsh** I used it your one or two year after that I go with a more homebrew solution. 

## zinit
I my current setup I use [zinit](https://github.com/zdharma/zinit) as plugin manager. It helps me to keep all my **zsh** plugins up to date without managing many plunins as submodules in my dotfiles repository. 

You can simple self upgrade zinit with the following command:
```zsh
zinit self-update
```

Also you can update all the plugins with:
```zsh
zinit update
```

## prompt
I used as [pure](https://github.com/sindresorhus/pure) as prompt it is really fast and also looks awesome. I really like the minimal approach. 

## other Plugins that I used

**[LS_COLORS](https://github.com/trapd00r/LS_COLORS)**: In this package are color definition for ls to add a bit more color to the shell. 

**[zsh-extract](https://github.com/alexrochas/zsh-extract)**: extract is a small function do the work for gzip, tar, rar and many more. 

**[fast-syntax-highlighting](https://github.com/zdharma/fast-syntax-highlighting)**: This plugin highlight the zsh syntax on the fly when writing shell code

**[forgit](https://github.com/wfxr/forgit)**: is a small tool the implemt useful commands build on top of fzf


You can find my whole configuration in my [dotfiles](https://github.com/dgo-/dotfiles/tree/master/zsh) repository on github. 

There is a link to the [website](https://www.zsh.org/) of zsh. Great projects need no fancy website!
