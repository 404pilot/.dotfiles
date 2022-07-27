#!/bin/bash
# set -x
set -euo pipefail

choice_install_apps="skip_by_default"
choice_install_fonts="skip_by_default"
choice_update_mac_defaults="skip_by_default"

while getopts ":a:f:m:" opt; do
  case $opt in
    a) choice_install_apps="$OPTARG"
    ;;
    f) choice_install_fonts="$OPTARG"
    ;;
    m) choice_update_mac_defaults="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac
done

######################################################
## clone dotfiles
if [ ! -d ~/.dotfiles ]; then
  echo "#### pull .dotfiles"
  (cd && GIT_SSH_COMMAND='ssh -i ~/.ssh/id_rsa_personal -o IdentitiesOnly=yes' git clone git@github.com:404pilot/.dotfiles.git)
fi

######################################################
## install necessary apps
apps=(git ccat vim zsh antigen autojump tmux blueutil sleepwatcher direnv)

if [[ "$choice_install_apps" == "install_apps" ]]; then
  for app in "${apps[@]}"
  do
    echo "#### install $app"
    brew list $app || brew install $app
  done
fi

######################################################
## install fonts
if [[ "$choice_install_fonts" == "install_fonts" ]]; then
  brew tap homebrew/cask-fonts || true && brew install --cask font-fira-code
fi

######################################################
## iterm2
echo "### Config iterm2"
# Specify the preferences directory
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.dotfiles/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

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
## vim
echo "#### Config vim"

rm ~/.vimrc || true \
  && ln -s ~/.dotfiles/vim/vimrc ~/.vimrc \
  && curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

######################################################
## ideavim
echo "#### Config ideavim"

rm ~/.ideavimrc || true \
  && ln -s ~/.dotfiles/ideavim/ideavimrc ~/.ideavimrc

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

if [ ! -d ~/.tmux/plugins/tpm ]; then
  echo "git clone tpm plugins..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

######################################################
## ssh
echo "#### Config ssh"

rm ~/.ssh/config || true \
  && ln -s ~/.dotfiles/ssh/config ~/.ssh/config

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
# echo "#### Config poetry"
#
# POETRY_CONFIG_PATH="${HOME}/Library/Application Support/pypoetry"
#
# if [ -d "${POETRY_CONFIG_PATH}" ]; then
#   rm "${POETRY_CONFIG_PATH}/config.toml" || true \
#     && ln -s ~/.dotfiles/poetry/config.toml "${POETRY_CONFIG_PATH}/config.toml"
# fi

######################################################
## git
echo "#### Config git"

rm ~/.gitconfig || true \
  && ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig

function set_up_git_config_for_work(){
  local location=$1

  mkdir -p $location

  if [ ! -f $location/gitconfig-work ]; then
    echo "######## Please modify $location/gitconfig-work"
    cp ~/.dotfiles/git/gitconfig-work $location
  fi
}

set_up_git_config_for_work ~/Work/private
set_up_git_config_for_work ~/Work/public
set_up_git_config_for_work ~/Work/ms


######################################################
## sleepwatcher
echo "#### Config sleepwatcher"
rm ~/.sleep || true \
  && ln -s ~/.dotfiles/sleepwatcher/sleep ~/.sleep

rm ~/.wakeup || true \
  && ln -s ~/.dotfiles/sleepwatcher/wakeup ~/.wakeup

brew services restart sleepwatcher

######################################################
## macOS
# see docs at https://macos-defaults.com/
# defaults reads
# defaults domains
# lots of configurations exist at ~/Library/Preferences
echo "#### Config macOS defaults values"
if [[ "$choice_update_mac_defaults" == "update_mac_defaults" ]]; then
  # backup current settings
  defaults read > /tmp/defaults_read_$(date -u +"%Y-%m-%dT%H:%M:%SZ").bak

  # save screenshots to ~/Documents
  defaults write com.apple.screencapture location $HOME/documents && killall SystemUIServer

  # allow repeated keys
  defaults write -g ApplePressAndHoldEnabled -bool false

  # show all extensions name
  defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true" && killall Finder

  # show path
  defaults write com.apple.finder "ShowPathbar" -bool true && killall Finder

  # set dock position
  defaults write com.apple.dock "orientation" -string "left" \
    && defaults write com.apple.dock "show-recents" -bool "false" \
    && killall Dock

  # set default view in finder
  defaults write com.apple.finder "FXPreferredGroupBy" -string "Kind" \
    && defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv" \
    && killall Finder
fi

######################################################
## done
echo "#### Finish"
