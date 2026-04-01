package.path = os.getenv("HOME") .. '/.dotfiles/hammerspoon/?.lua;' .. package.path

-- enable hammerspoon command line tool: hs -c "hs.reload()"
hs.ipc.cliInstall()

log = function(msg) print("[hs] " .. msg) end   -- bootstrap log before helper loads

log("loading application_shortcuts")  ; require "application_shortcuts"
log("loading windows_manager")        ; require "windows_manager"
log("loading sidekick")               ; require "sidekick"
