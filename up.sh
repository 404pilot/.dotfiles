#!/bin/bash
# set -x
set -euo pipefail

######################################################
if [ ! -d ~/.dotfiles ]; then
  echo "#### pull .dotfiles"
  (cd && git clone git@github.com:404pilot/.dotfiles.git)
fi

# TODO check all apps are installed correctly

######################################################
## bash & bash_completion & jenv & rbenv
# echo "#### Config bash and other configs (bash_completion, jenv, rbenv)"

# cp ~/.dotfiles/bash/bash_profile ~/.bash_profile

# rm ~/.bashrc
# echo "source ~/.dotfiles/bash/bash_bridge" > ~/.bashrc
# echo "source ~/.dotfiles/bash/bash_other_app_configs" >> ~/.bashrc

######################################################
## zsh & jenv & sdkman
echo "#### Config zsh and other configs (bash_completion, jenv, sdkman ...)"

rm ~/.zshrc || true \
  && ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc

######################################################
## editorConfig
echo "#### Config vim"

rm ~/.vimrc || true \
  && ln -s ~/.dotfiles/vim/vimrc ~/.vimrc

######################################################
## editorConfig
echo "#### Config editorConfig"

rm ~/.editorconfig || true \
  && ln -s ~/.dotfiles/editorConfig/editorconfig ~/.editorconfig

######################################################
## tmux
echo "#### Config tmux"

# make sure terminal: $TERM=xterm-256color
rm ~/.tmux.conf || true \
  && ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

######################################################
## Karabiner
## by default, click 'Open config folder' from karabiner will delete the symbolink file and generate the latest configuration json file
##   which it is a way to configure stuff in GUI first and then get the corresponding configuration file
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

######################################################
## poetry
POETRY_CONFIG_PATH="${HOME}/Library/Application Support/pypoetry"

rm "${POETRY_CONFIG_PATH}/config.toml" || true \
  && ln -s ~/.dotfiles/poetry/config.toml "${POETRY_CONFIG_PATH}/config.toml"

######################################################
## git
echo "#### Config git"

rm ~/.gitconfig || true \
  && ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig

if [ -d ~/work/private ] && [ ! -f ~/work/private/gitconfig-work ]; then
  echo "######## Please modify ~/work/private/gitconfig-work"
  cp ~/.dotfiles/git/gitconfig-work ~/work/private
fi

if [ -d ~/work/public ] && [ ! -f ~/work/public/gitconfig-work ]; then
  echo "######## Please modify ~/work/public/gitconfig-work"
  cp ~/.dotfiles/git/gitconfig-work ~/work/public
fi

######################################################
## done
echo "#### Finish"
