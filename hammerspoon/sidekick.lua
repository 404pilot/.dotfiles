-- ************************************************************
-- Scripts
-- ************************************************************
local function setAwsCredentials()
  hs.execute("~/.dotfiles/hammerspoon/updateAws.sh")
  -- hs.execute("echo \"$(pbpaste)\" > ~/.aws/credentials")

  hs.notify.new({title="Hammerspoon", informativeText="AWS credentials is updated"}):send()
end

-- website will trigger tampermonkey scripts to call some hammerspoon scripts
local function intiProcessToLoadAwsCredentials()
  -- hs.execute("open https://rax.io/vdo-dev-aws")
  hs.execute("open https://rax.io/pvc-dev-aws")
end

-- hs.hotkey.bind({"alt"}, "8", intiProcessToLoadAwsCredentials)
-- hs.hotkey.bind({"alt"}, "9", setAwsCredentials)

-- ************************************************************
-- URL handlers
-- ************************************************************
-- ➜  Chrome  defaults read com.google.Chrome ExternalProtocolDialogShowAlwaysOpenCheckbox
-- 2020-02-05 09:19:29.451 defaults[87394:6359726]
-- The domain/default pair of (com.google.Chrome, ExternalProtocolDialogShowAlwaysOpenCheckbox) does not exist
-- ➜  Chrome defaults write com.google.Chrome ExternalProtocolDialogShowAlwaysOpenCheckbox -bool true

-- ➜  Chrome defaults read com.google.Chrome ExternalProtocolDialogShowAlwaysOpenCheckbox
-- 1
-- Restart Chrome
-- $ defaults read | grep Chrome
-- $ defaults write com.google.Chrome.canary ExternalProtocolDialogShowAlwaysOpenCheckbox -bool true
-- $ defaults read com.google.Chrome.canary
hs.urlevent.bind("update_aws", setAwsCredentials)


-- ************************************************************
-- wifi watcher to mute audio when it is not a home environment
-- ************************************************************
local homeSSIDs = {"404fi", "404fi_5G"}
local lastSSID = hs.wifi.currentNetwork()

function inTable(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then
          return true
        end
    end

    return false
end

function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()
    device = hs.audiodevice.defaultOutputDevice()

    if newSSID ~= lastSSID then
      -- os.execute("sleep " .. tonumber(2))
      -- hs.notify.new({title="Hammerspoon", informativeText="Debug:no the same SSID"}):send()

      if inTable(homeSSIDs, newSSID) then
        if device:muted() then
          device:setMuted(false)
        end
        -- hs.audiodevice.defaultOutputDevice():setMuted(false)

        if device:volume() == 0 then
          device:setVolume(25)
        end
      else
        -- hs.notify.new({title="Hammerspoon", informativeText="Mute audio since this is not a home wifi"}):send()

        if device:muted() then
          device:setMuted(false)
        end
        device:setVolume(0)
        -- hs.audiodevice.defaultOutputDevice():setMuted(false)
        -- hs.audiodevice.defaultOutputDevice():setVolume(0)
      end

      lastSSID = newSSID
    end
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback):start()


-- function keyStrokes(str)
--   return function()
--       hs.eventtap.keyStrokes(str)
--   end
-- end
-- hs.hotkey.bind({"ctrl", "alt", "cmd"}, "L", keyStrokes("console.log("))

-- function chrome_active_tab_with_name(name)
--   return function()
--       hs.osascript.javascript([[
--           // below is javascript code
--           var chrome = Application('Google Chrome');
--           chrome.activate();
--           var wins = chrome.windows;

--           // loop tabs to find a web page with a title of <name>
--           function main() {
--               for (var i = 0; i < wins.length; i++) {
--                   var win = wins.at(i);
--                   var tabs = win.tabs;
--                   for (var j = 0; j < tabs.length; j++) {
--                   var tab = tabs.at(j);
--                   tab.title(); j;
--                   if (tab.title().indexOf(']] .. name .. [[') > -1) {
--                           win.activeTabIndex = j + 1;
--                           return;
--                       }
--                   }
--               }
--           }
--           main();
--           // end of javascript
--       ]])
--   end
-- end

-- --- Use
-- hs.hotkey.bind({"alt"}, "H", chrome_active_tab_with_name("HipChat"))
