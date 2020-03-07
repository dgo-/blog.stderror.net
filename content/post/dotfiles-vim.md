+++
title = "My vim-plug setup"
description = "I change vim plugin manager form pathogen to vim-plug"
date = "2020-03-07T11:53:40+01:00"
comments = false
tags = [ "dotfiles", "vim", "Desktop" ]
categories = [  "MyDotfiles", "Desktop", "vim" ]
+++
I change vim plugin manager form pathogen to vim-plug, because I want some plugin manager here that is still under active development. Also I want do get ride of the git submodules for all vim plugins. 

I search a bit around in the web and take the descision to go with **vim-plug**.

What I like on vim-plug is that I can simple **install** and **update** the plugins direct in vim. The configuration is also straigth forward and esay to understand. 

## Install
To install vim-plug you only need to download the [plug.vim](https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim) file to your **~/.vim/autoload** directory. 

## Usage
The usage is also really simple and the syntax is at the same time simple and powerful. 

To configure **vim-plug** you need to make a small section in your *vimrc*. There a small example out of my vimrc. I add some useful comments to explain everything. 
```vim
" start plugin section
" the path in the brackes tells vim-plug
" where to install the plugins
call plug#begin('~/.vim/plugged')

" first installs the fzf tool
Plug 'junegunn/fzf', { 'do': './install --bin' }
" after that install also the fzf vim plugin
Plug 'junegunn/fzf.vim'

" load nerdtree only if needed
Plug 'preservim/nerdtree' { 'on':  'NERDTreeToggle' }

" also install needed go binaries
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" End of the plugins section 
" Here the loading of the plugins starts.
call plug#end()
```

I would recommend you to exclude the *~/.vim/plugged* from your **dotfiles** and manage the plugins only with vim-plug.

You can find my whole configuration in my [dotfiles](https://github.com/dgo-/dotfiles/tree/master/vim) repository on github. 
