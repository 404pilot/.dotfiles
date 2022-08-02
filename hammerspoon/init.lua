package.path = os.getenv("HOME") .. '/.dotfiles/hammerspoon/?.lua;' .. package.path

require "application_shortcuts"
require "windows_manager"
require "sidekick"
