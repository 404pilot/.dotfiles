#!/bin/bash

# check current paths

## bash & jenv & bash_completion
echo "#### Config bash & jenv ####"
echo "source ~/.dotfiles/bash/bash_bridge" >> ~/.bashrc \
    && source ~/.bashrc

## git
echo "#### Config git ####"
rm ~/.gitconfig \
    | ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig

## editorConfig
echo "#### Config editorConfig ####"
rm ~/.editorConfig \
    | ln -s ~/.dotfiles/editorConfig/editorConfig ~/.editorConfig

## tmux
echo "#### Config tmux ####"
# make sure terminal: $TERM=xterm-256color
rm ~/.tmux.conf \
    | ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

## Karabiner
echo "#### Config karabiner ####"
rm ~/Library/Application\ Support/Karabiner/private.xml \
    && ln -s ~/.dotfiles/Karabiner/private.xml ~/Library/Application\ Support/Karabiner/private.xml

## hammerspoon
echo "#### Config hammerspoon ####"
rm ~/.hammerspoon/init.lua \
    | mkdir ~/.hammerspoon \
    | ln -s ~/.dotfiles/hammerspoon/init.lua ~/.hammerspoon/init.lua
