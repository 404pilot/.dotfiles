#!/bin/bash
# set -x
set -euo pipefail

install_apps=false
update_mac_defaults=false

for arg in "$@"; do
  case $arg in
    --apps)         install_apps=true ;;
    --mac-defaults) update_mac_defaults=true ;;
    *) echo "[bootstrap] unknown option: $arg" >&2; exit 1 ;;
  esac
done

log() { echo "[bootstrap] $1"; }

# ---------------------------------------------------------------------------
# dotfiles
# ---------------------------------------------------------------------------
if [ ! -d ~/.dotfiles ]; then
  log "cloning dotfiles"
  (cd && GIT_SSH_COMMAND='ssh -i ~/.ssh/id_rsa_personal -o IdentitiesOnly=yes' git clone git@github.com:404pilot/.dotfiles.git)
fi

# ---------------------------------------------------------------------------
# apps (brew bundle)
# ---------------------------------------------------------------------------
if [[ "$install_apps" == true ]]; then
  log "installing apps via Brewfile"
  brew bundle --file ~/.dotfiles/Brewfile
fi

# ---------------------------------------------------------------------------
# iTerm2
# ---------------------------------------------------------------------------
log "configuring iTerm2"
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.dotfiles/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# ---------------------------------------------------------------------------
# zsh
# ---------------------------------------------------------------------------
log "configuring zsh"
rm ~/.zshrc || true \
  && ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc

# ---------------------------------------------------------------------------
# vim
# ---------------------------------------------------------------------------
log "configuring vim"
rm ~/.vimrc || true \
  && ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
# vim-plug and plugins auto-install on first vim launch (configured in vimrc)

# ---------------------------------------------------------------------------
# neovim
# ---------------------------------------------------------------------------
log "configuring neovim"
rm -rf ~/.config/nvim || true \
  && ln -s ~/.dotfiles/nvim ~/.config/nvim

# ---------------------------------------------------------------------------
# starship
# ---------------------------------------------------------------------------
log "configuring starship"
mkdir -p ~/.config
rm -f ~/.config/starship.toml || true \
  && ln -s ~/.dotfiles/starship/starship.toml ~/.config/starship.toml

# ---------------------------------------------------------------------------
# editorConfig
# ---------------------------------------------------------------------------
log "configuring editorConfig"
rm ~/.editorconfig || true \
  && ln -s ~/.dotfiles/editorConfig/editorconfig ~/.editorconfig

# ---------------------------------------------------------------------------
# tmux
# ---------------------------------------------------------------------------
log "configuring tmux"
rm ~/.tmux.conf || true \
  && ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

export TERM=xterm-256color

if [ ! -d ~/.tmux/plugins/tpm ]; then
  log "installing tmux plugins (tpm)"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/bin/install_plugins
fi

# ---------------------------------------------------------------------------
# ssh
# ---------------------------------------------------------------------------
log "configuring ssh"
rm ~/.ssh/config || true \
  && ln -s ~/.dotfiles/ssh/config ~/.ssh/config

# ---------------------------------------------------------------------------
# karabiner
#
# tip: clicking 'Open config folder' in Karabiner deletes the symlink and
#      regenerates the JSON — useful for GUI-first config then syncing back.
# tip: find bundle ID via:
#        osascript -e 'id of app "Microsoft Remote Desktop"'
#        mdls -name kMDItemCFBundleIdentifier /Applications/App.app
# ---------------------------------------------------------------------------
log "configuring karabiner"
rm ~/.config/karabiner/karabiner.json || true \
  && ln -s ~/.dotfiles/karabiner/karabiner.json ~/.config/karabiner/karabiner.json

# ---------------------------------------------------------------------------
# hammerspoon
# ---------------------------------------------------------------------------
log "configuring hammerspoon"
rm ~/.hammerspoon/init.lua || mkdir ~/.hammerspoon || true \
  && ln -s ~/.dotfiles/hammerspoon/init.lua ~/.hammerspoon/init.lua

# ---------------------------------------------------------------------------
# poetry (tag:python)
# ---------------------------------------------------------------------------
log "configuring poetry"
POETRY_CONFIG_PATH="${HOME}/Library/Application Support/pypoetry"
if [ -d "${POETRY_CONFIG_PATH}" ]; then
  rm "${POETRY_CONFIG_PATH}/config.toml" || true \
    && ln -s ~/.dotfiles/poetry/config.toml "${POETRY_CONFIG_PATH}/config.toml"
fi

# ---------------------------------------------------------------------------
# git
# ---------------------------------------------------------------------------
log "configuring git"
rm ~/.gitconfig || true \
  && ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig

setup_git_config_for_work() {
  local location=$1
  mkdir -p "$location"
  if [ ! -f "$location/gitconfig-work" ]; then
    log "please modify $location/gitconfig-work"
    cp ~/.dotfiles/git/gitconfig-work "$location"
  fi
}

setup_git_config_for_work ~/Work/private
setup_git_config_for_work ~/Work/public
setup_git_config_for_work ~/Work/ms

# ---------------------------------------------------------------------------
# azure — isolated credentials per workspace
# ---------------------------------------------------------------------------
log "configuring azure (direnv)"
setup_azure_envrc() {
  local dir=$1 config_dir=$2 label=$3
  mkdir -p "$dir"
  cat > "$dir/.envrc" <<ENVRC
export AZURE_CONFIG_DIR="\$HOME/$config_dir"
export AZURE_LABEL="$label"
ENVRC
  direnv allow "$dir"
}

setup_azure_envrc ~/Work .azure-work work
setup_azure_envrc ~/404pilot .azure-404pilot personal

# ---------------------------------------------------------------------------
# sleepwatcher
# ---------------------------------------------------------------------------
log "configuring sleepwatcher"
rm ~/.sleep || true \
  && ln -s ~/.dotfiles/sleepwatcher/sleep ~/.sleep

rm ~/.wakeup || true \
  && ln -s ~/.dotfiles/sleepwatcher/wakeup ~/.wakeup

brew services restart sleepwatcher

# ---------------------------------------------------------------------------
# macOS defaults
# ref: https://macos-defaults.com
# ---------------------------------------------------------------------------
if [[ "$update_mac_defaults" == true ]]; then
  log "applying macOS defaults"

  # backup current settings
  defaults read > /tmp/defaults_read_$(date -u +"%Y-%m-%dT%H:%M:%SZ").bak

  defaults write com.apple.screencapture location "$HOME/Documents" && killall SystemUIServer
  defaults write -g ApplePressAndHoldEnabled -bool false
  defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true" && killall Finder
  defaults write com.apple.finder "ShowPathbar" -bool true && killall Finder
  defaults write com.apple.dock "orientation" -string "left" \
    && defaults write com.apple.dock "show-recents" -bool "false" \
    && killall Dock
  defaults write com.apple.finder "FXPreferredGroupBy" -string "Kind" \
    && defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv" \
    && killall Finder
fi

# ---------------------------------------------------------------------------
# done
# ---------------------------------------------------------------------------
log "done"
