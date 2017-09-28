#!/bin/bash
set -e
# set -x

######################################################
echo "#### pull .dotfiles"

if [ -f ~/.dotfiles ]; then
  (cd && git clone git@github.com:404pilot/.dotfiles.git)
fi

######################################################
## bash & bash_completion & jenv & rbenv
echo "#### Config bash and other configs (bash_completion, jenv, rbenv)"

cp ~/.dotfiles/bash/bash_profile ~/.bash_profile

echo "source ~/.dotfiles/bash/bash_bridge" > ~/.bashrc
echo "source ~/.dotfiles/bash/bash_other_app_configs" >> ~/.bashrc

######################################################
## git
echo "#### Config git"

rm ~/.gitconfig || true \
  && ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig

######################################################
## editorConfig
echo "#### Config editorConfig"

rm ~/.editorConfig || true\
  && ln -s ~/.dotfiles/editorConfig/editorConfig ~/.editorConfig

######################################################
## tmux
echo "#### Config tmux"

# make sure terminal: $TERM=xterm-256color
rm ~/.tmux.conf || true \
  && ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

######################################################
## Karabiner
echo "#### Config karabiner"

rm ~/.config/karabiner/karabiner.json || true \
  && ln -s ~/.dotfiles/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
# rm ~/Library/Application\ Support/Karabiner/private.xml || true \
#   && ln -s ~/.dotfiles/karabiner/private.xml ~/Library/Application\ Support/Karabiner/private.xml

######################################################
## hammerspoon
echo "#### Config hammerspoon"

rm ~/.hammerspoon/init.lua || mkdir ~/.hammerspoon  || true \
  && ln -s ~/.dotfiles/hammerspoon/init.lua ~/.hammerspoon/init.lua

######################################################
## shuttle
echo "#### Config shuttle"

rm ~/.shuttle.json || true \
  && ln -s ~/.dotfiles/shuttle/shuttle.json ~/.shuttle.json

echo "#### Finish"
