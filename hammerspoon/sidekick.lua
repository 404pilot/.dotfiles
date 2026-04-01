require("helper")

local SCRIPTS_DIR = os.getenv("HOME") .. "/.dotfiles/hammerspoon/scripts"

-- ---------------------------------------------------------------------------
-- Scripts — hotkey-triggered shell scripts
-- ---------------------------------------------------------------------------
local function runScript(name)
  local cmd = SCRIPTS_DIR .. "/" .. name .. " >> $HOME/.dotfiles/.log/$(date +%F).log 2>&1"
  hs.execute(cmd)
end

local function searchInAdo()        runScript("search_in_ado.sh") end
local function runPlaceholder()     runScript("run_placeholder.sh") end
local function openLatestLogFile()  runScript("open_latest_log_file.sh") end

local function putOsToSleep()
  hs.execute("osascript -e 'tell application \"Finder\" to sleep'")
end

local function restartRemoteDesktop()
  hs.execute("pkill KILL 'Microsoft Remote Desktop'")
  hs.execute("sleep 1")
  hs.execute("open '/Applications/Microsoft Remote Desktop.app'")
end

hs.hotkey.bind({"alt"},      "7", runPlaceholder)
hs.hotkey.bind({"alt"},      "8", searchInAdo)
hs.hotkey.bind({"alt"},      "9", openLatestLogFile)
hs.hotkey.bind({"ctrl,alt"}, "5", putOsToSleep)
hs.hotkey.bind({"ctrl,alt"}, "8", restartRemoteDesktop)

-- ---------------------------------------------------------------------------
-- WiFi watcher — mute audio when leaving home network
-- ref: requires Location Services access for Hammerspoon
-- ---------------------------------------------------------------------------
local HOME_SSIDS = { "404fi", "404fi_5G" }
local lastSSID   = hs.wifi.currentNetwork()

local function isHomeNetwork(ssid)
  for _, s in pairs(HOME_SSIDS) do
    if s == ssid then return true end
  end
  return false
end

local function ssidChangedCallback()
  local newSSID = hs.wifi.currentNetwork()
  local device  = hs.audiodevice.defaultOutputDevice()

  log("wifi changed: " .. (lastSSID or "nil") .. " → " .. (newSSID or "nil"))

  if newSSID == lastSSID then return end

  if isHomeNetwork(newSSID) then
    if device:muted() then device:setMuted(false) end
    if device:volume() == 0 then device:setVolume(25) end
  else
    if device:muted() then device:setMuted(false) end
    device:setVolume(0)
  end

  lastSSID = newSSID
end

-- global intentionally — prevents watcher from being garbage collected
wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback):start()
