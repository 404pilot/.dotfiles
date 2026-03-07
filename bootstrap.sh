#!/bin/bash
# set -x
set -euo pipefail

install_apps=false
install_fonts=false
update_mac_defaults=false

for arg in "$@"; do
  case $arg in
    --apps)         install_apps=true ;;
    --fonts)        install_fonts=true ;;
    --mac-defaults) update_mac_defaults=true ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done

# ---------------------------------------------------------------------------
# Clone dotfiles
# ---------------------------------------------------------------------------
if [ ! -d ~/.dotfiles ]; then
  echo "#### pull .dotfiles"
  (cd && GIT_SSH_COMMAND='ssh -i ~/.ssh/id_rsa_personal -o IdentitiesOnly=yes' git clone git@github.com:404pilot/.dotfiles.git)
fi

# ---------------------------------------------------------------------------
# Install necessary apps
# ---------------------------------------------------------------------------
apps=(git ccat vim zsh antigen autojump tmux blueutil sleepwatcher direnv nvm)

if [[ "$install_apps" == true ]]; then
  for app in "${apps[@]}"
  do
    echo "#### install $app"
    brew list $app || brew install $app
  done
fi

# ---------------------------------------------------------------------------
# Install fonts
# ---------------------------------------------------------------------------
if [[ "$install_fonts" == true ]]; then
  brew tap homebrew/cask-fonts || true && brew install --cask font-fira-code-nerd-font
fi

# ---------------------------------------------------------------------------
# iTerm2
# ---------------------------------------------------------------------------
echo "### Config iterm2"
# Specify the preferences directory
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.dotfiles/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# ---------------------------------------------------------------------------
# bash & bash_completion & jenv & rbenv (disabled)
# ---------------------------------------------------------------------------
# echo "#### Config bash and other configs (bash_completion, jenv, rbenv)"

# cp ~/.dotfiles/bash/bash_profile ~/.bash_profile

# rm ~/.bashrc
# echo "source ~/.dotfiles/bash/bash_bridge" > ~/.bashrc
# echo "source ~/.dotfiles/bash/bash_other_app_configs" >> ~/.bashrc

# ---------------------------------------------------------------------------
# zsh & jenv & sdkman
# ---------------------------------------------------------------------------
echo "#### Config zsh and other configs (bash_completion, jenv, sdkman ...)"

rm ~/.zshrc || true \
  && ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc

# ---------------------------------------------------------------------------
# vim
# ---------------------------------------------------------------------------
echo "#### Config vim"

rm ~/.vimrc || true \
  && ln -s ~/.dotfiles/vim/vimrc ~/.vimrc

# vim-plug and plugins auto-install on first vim launch (configured in vimrc)

# ---------------------------------------------------------------------------
# editorConfig
# ---------------------------------------------------------------------------
echo "#### Config editorConfig"

rm ~/.editorconfig || true \
  && ln -s ~/.dotfiles/editorConfig/editorconfig ~/.editorconfig

# ---------------------------------------------------------------------------
# tmux
# ---------------------------------------------------------------------------
echo "#### Config tmux"

rm ~/.tmux.conf || true \
  && ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

# make sure terminal: $TERM=xterm-256color
export TERM=xterm-256color

if [ ! -d ~/.tmux/plugins/tpm ]; then
  echo "git clone tpm plugins..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "installing plugins..."
  ~/.tmux/plugins/tpm/bin/install_plugins
fi

# ---------------------------------------------------------------------------
# ssh
# ---------------------------------------------------------------------------
echo "#### Config ssh"

rm ~/.ssh/config || true \
  && ln -s ~/.dotfiles/ssh/config ~/.ssh/config

# ---------------------------------------------------------------------------
# Karabiner
#
# By default, clicking 'Open config folder' in Karabiner deletes the symlink
# and regenerates the JSON — useful for GUI-first config then syncing back.
#
# Tips: find bundle ID via:
#   osascript -e 'id of app "Microsoft Remote Desktop"'
#   mdls -name kMDItemCFBundleIdentifier /Applications/Microsoft\ Remote\ Desktop\ Beta.app
# ---------------------------------------------------------------------------
echo "#### Config karabiner"

rm ~/.config/karabiner/karabiner.json || true \
  && ln -s ~/.dotfiles/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
# rm ~/Library/Application\ Support/Karabiner/private.xml || true \
#   && ln -s ~/.dotfiles/karabiner/private.xml ~/Library/Application\ Support/Karabiner/private.xml

# ---------------------------------------------------------------------------
# Hammerspoon
# ---------------------------------------------------------------------------
echo "#### Config hammerspoon"

rm ~/.hammerspoon/init.lua || mkdir ~/.hammerspoon  || true \
  && ln -s ~/.dotfiles/hammerspoon/init.lua ~/.hammerspoon/init.lua

# ---------------------------------------------------------------------------
# Shuttle
# ---------------------------------------------------------------------------
echo "#### Config shuttle"

rm ~/.shuttle.json || true \
  && ln -s ~/.dotfiles/shuttle/shuttle.json ~/.shuttle.json

# ---------------------------------------------------------------------------
# IdeaVim (tag:java)
# ---------------------------------------------------------------------------
echo "#### Config ideavim"

rm ~/.ideavimrc || true \
  && ln -s ~/.dotfiles/ideavim/ideavimrc ~/.ideavimrc

# ---------------------------------------------------------------------------
# Poetry (tag:python)
# ---------------------------------------------------------------------------
echo "#### Config poetry"

POETRY_CONFIG_PATH="${HOME}/Library/Application Support/pypoetry"

if [ -d "${POETRY_CONFIG_PATH}" ]; then
  rm "${POETRY_CONFIG_PATH}/config.toml" || true \
    && ln -s ~/.dotfiles/poetry/config.toml "${POETRY_CONFIG_PATH}/config.toml"
fi

# ---------------------------------------------------------------------------
# git
# ---------------------------------------------------------------------------
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

# ---------------------------------------------------------------------------
# sleepwatcher
# ---------------------------------------------------------------------------
echo "#### Config sleepwatcher"
rm ~/.sleep || true \
  && ln -s ~/.dotfiles/sleepwatcher/sleep ~/.sleep

rm ~/.wakeup || true \
  && ln -s ~/.dotfiles/sleepwatcher/wakeup ~/.wakeup

brew services restart sleepwatcher

# ---------------------------------------------------------------------------
# macOS defaults
# see docs at https://macos-defaults.com/
# ---------------------------------------------------------------------------
echo "#### Config macOS defaults values"
if [[ "$update_mac_defaults" == true ]]; then
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

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------
echo "#### Finish"
