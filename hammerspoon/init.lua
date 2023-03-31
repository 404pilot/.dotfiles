package.path = os.getenv("HOME") .. '/.dotfiles/hammerspoon/?.lua;' .. package.path

require "application_shortcuts"
require "windows_manager"
require "sidekick"

-- use hammerspoon command line tool: hs -c "hs.reload()"
hs.ipc.cliInstall()
