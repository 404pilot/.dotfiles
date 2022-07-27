local function log(message)
  print(">>>>>>" .. message)
end

-- ************************************************************
-- Windows Management
-- ************************************************************

hs.window.animationDuration = 0

local centerCoordinate =      {x = 0.1, y = 0,    w = 0.8,  h = 1}
local maximizedCoordinate =   {x = 0,   y = 0,    w = 1,    h = 1}
local leftHalfCoordinate =    {x = 0,   y = 0,    w = 0.5,  h = 1}
local rightHalfCoordinate =   {x = 0.5, y = 0,    w = 0.5,  h = 1}
local topHalfCoordinate =     {x = 0,   y = 0,    w = 1,    h = 0.5}
local bottomHalfCoordinate =  {x = 0,   y = 0.5,  w = 1,    h = 0.5}

local function adjustFrame(coordinate)
  hs.window.focusedWindow():moveToUnit(coordinate)
end

local function toNextScreen()
  local win = hs.window.focusedWindow()
  local nextScreen = win:screen():next()
  win:moveToScreen(nextScreen)
end

local function toPreviousScreen()
  local win = hs.window.focusedWindow()
  local nextScreen = win:screen():previous()
  win:moveToScreen(nextScreen)
end

hs.hotkey.bind({"alt"}, "u", function() adjustFrame(centerCoordinate) end)
hs.hotkey.bind({"alt"}, "o", function() adjustFrame(maximizedCoordinate) end)

hs.hotkey.bind({"alt"}, "i", function() adjustFrame(topHalfCoordinate) end)
hs.hotkey.bind({"alt"}, "k", function() adjustFrame(bottomHalfCoordinate) end)
hs.hotkey.bind({"alt"}, "j", toNextScreen)
hs.hotkey.bind({"alt"}, "l", toPreviousScreen)

hs.hotkey.bind({"alt, shift"}, "j", function() adjustFrame(leftHalfCoordinate) end)
hs.hotkey.bind({"alt, shift"}, "l", function() adjustFrame(rightHalfCoordinate) end)
-- hs.hotkey.bind({"alt, shift"}, "l", toNextScreen)
-- hs.hotkey.bind({"alt, shift"}, "j", toPreviousScreen)

-- ************************************************************
-- Application Shortcuts (use name in applications folder)
-- ************************************************************
-- list all running applications: (it might be changed in Big Sur. Look for application name in Application folder)
-- Use `hs.application.enableSpotlightForNameSearches(true)` in Big Sur unless I can find something better in the future
-- I believe the issue is some applications are not put in Application folder like IntelliJ Idea
--   for key,value in pairs(hs.application.runningApplications()) do print(key,value) end
SHORTCUT_MAPPING = {
  ["Default"] = {
      c       = "Google Chrome",
      e       = "iTerm",
      ["`"]   = "Finder",
      ["1"]   = "Visual Studio Code",
      ["2"]   = "Typora",
      ["3"]   = "Notion",
  },
  ["Jedi"] = {
      c       = "Google Chrome",
      a       = "IntelliJ IDEA Community Edition",
      e       = "iTerm",
      ["`"]   = "Finder",
      ["1"]   = "Visual Studio Code",
      ["2"]   = "Typora",
      ["3"]   = "Notion",
  },
  ["FVF"] = {
      f       =   "Google Chrome Canary",
      c       =   "Google Chrome",
      a       =   "IntelliJ IDEA",
      s       =   "PyCharm Community",
      v       =   "Preview",
      -- v       =   "Postman",
      e       =   "iTerm",
      -- r       =   "Royal TSX",
      -- r       =   "Microsoft Remote Desktop",
      -- r       =   "Postico",
      ["`"]   =   "Finder",
      ["1"]   =   "Visual Studio Code",
      ["2"]   =   "Typora",
      ["3"]   =   "Notion",
      -- ['4']   =   "Slack",
      ['4']   =   "Microsoft Teams",
      -- ['5']   =   "Royal TSX",
      -- ['5']   =   "Microsoft Remote Desktop",
      ['6']   =   "Microsoft Outlook",
  },
  ["Rocket"] = {
      c       = "Google Chrome",
      f       = "Microsoft Edge",
      e       = "iTerm",
      v       = "Microsoft Word",
      r       = "Microsoft Remote Desktop",
      ["`"]   = "Finder",
      ["1"]   = "Visual Studio Code",
      ["2"]   = "MarkText",
      ["3"]   = "Notion",
      ['4']   = "Microsoft Teams",
      ['6']   = "Microsoft Outlook",
  },
}

local function getMapping(laptop_id, mapping)
  for key, value in pairs(mapping) do
    if laptop_id:find("^" .. key) ~= nil then
      return value
    end
  end

  return SHORTCUT_MAPPING["Default"]
end

laptop_id = hs.host.localizedName() -- name can be found in preferences/sharing
laptop_shortcut = getMapping(laptop_id, SHORTCUT_MAPPING)
-- laptop_shortcut = SHORTCUT_MAPPING[laptop_id]

hs.application.enableSpotlightForNameSearches(true)
for shortcut, app in pairs(laptop_shortcut) do
  hs.hotkey.bind({"alt"}, shortcut, function() hs.application.launchOrFocus(app) end)
end

-- https://github.com/Hammerspoon/hammerspoon/issues/272

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
-- auto layout
-- ************************************************************
-- get monitor name by
--   for index,value in pairs(hs.screen.allScreens()) do print(value:name() .. " - " .. value:id()) end
-- get application name by
--   for key,value in pairs(hs.application.runningApplications()) do print(key,value) end

local macScreen   = "Built-in Retina Display"
local macScreenLua = "Built%-in Retina Display"
local dellP2721Q = "DELL P2721Q"
local dellU2718Q = "DELL U2718Q"

local layouts = {
  officeLayout={
    -- office: dellP2721Q(main) - macScreen
    screens={dellP2721Q, macScreen},
    appConfigs={
      {"Google Chrome",             dellP2721Q,  maximizedCoordinate},
      {"Microsoft Edge",            dellP2721Q,  maximizedCoordinate},
      {"Microsoft Remote Desktop",  dellP2721Q,  maximizedCoordinate},
      {"Code",                      dellP2721Q,  maximizedCoordinate},

      {"Finder",                    macScreen,      centerCoordinate},
      {"Activity Monitor",          macScreen,      centerCoordinate},
      {"MarkText",                  macScreen,      centerCoordinate},
      {"Preview",                   macScreen,      maximizedCoordinate},
      {"iTerm2",                    macScreen,      maximizedCoordinate},
      {"Microsoft Outlook",         macScreen,      maximizedCoordinate},
      {"Microsoft Word",            macScreen,      maximizedCoordinate},
      {"Microsoft Excel",           macScreen,      maximizedCoordinate},
      {"Notion",                    macScreen,      maximizedCoordinate},
      {"Microsoft Teams",           macScreen,      maximizedCoordinate},
    }
  },
  homeLayout={
    -- home: macScreen(main) - dellU2718Q
    screens={macScreen,dellU2718Q},
    appConfigs={
      {"Google Chrome",             dellU2718Q,     maximizedCoordinate},
      {"Microsoft Edge",            dellU2718Q,     maximizedCoordinate},
      {"Microsoft Remote Desktop",  dellU2718Q,     maximizedCoordinate},
      {"Code",                      dellU2718Q,     maximizedCoordinate},

      {"Finder",                    macScreen,      centerCoordinate},
      {"Activity Monitor",          macScreen,      centerCoordinate},
      {"MarkText",                  macScreen,      centerCoordinate},
      {"Preview",                   macScreen,      maximizedCoordinate},
      {"iTerm2",                    macScreen,      maximizedCoordinate},
      {"Microsoft Outlook",         macScreen,      maximizedCoordinate},
      {"Microsoft Word",            macScreen,      maximizedCoordinate},
      {"Microsoft Excel",           macScreen,      maximizedCoordinate},
      {"Notion",                    macScreen,      maximizedCoordinate},
      {"Microsoft Teams",           macScreen,      maximizedCoordinate},
    }
  },
  defaultLayout={
    screens={macScreen},
    appConfigs={
      {"iTerm2",                  macScreen,   centerCoordinate},
      {"Notion",                  macScreen,   centerCoordinate},
      {"Postman",                 macScreen,   centerCoordinate},
      {"Slack",                   macScreen,   centerCoordinate},
      {"Trello",                  macScreen,   centerCoordinate},
      {"Typora",                  macScreen,   centerCoordinate},
      {"Finder",                  macScreen,   centerCoordinate},
      {"Telegram",                macScreen,   centerCoordinate},
      {"Activity Monitor",        macScreen,   centerCoordinate},
      {"Code",                    macScreen,   maximizedCoordinate},
      {"Preview",                 macScreen,   maximizedCoordinate},
      {"Google Chrome",           macScreen,   maximizedCoordinate},
      {"Google Chrome Canary",    macScreen,   maximizedCoordinate},
      {"IntelliJ IDEA",           macScreen,   maximizedCoordinate},
      {"Microsoft Outlook",       macScreen,   maximizedCoordinate},
      {"PyCharm",                 macScreen,   maximizedCoordinate},
    }
  }
}

local function getScreensId(screens)
  screensCopy = {}
  for _, screen in ipairs(screens) do
    table.insert(screensCopy, screen)
  end

  table.sort(screensCopy)

  return table.concat(screensCopy, ",")
end

local function applyLayout(layout)
  transformedLayout = {}

  for _, appConfig in pairs(layout["appConfigs"]) do
    -- Try to get first two applications which are matched by name because
    --    google chrome and google chrome canary are sharing the same "Google Chrome"

    local app1, app2 = hs.application.find(appConfig[1])

    local apps = {app1, app2}

    for i = 1, 2 do
      if apps[i] ~= nil then
        -- if hs.application.name(apps[i]) == appConfig[1] then
        if apps[i].name(apps[i]) == appConfig[1] then
          if appConfig[2] == macScreen then
            table.insert(transformedLayout, {apps[i], nil, hs.screen.find(macScreenLua), appConfig[3], nil, nil})
          else
            table.insert(transformedLayout, {apps[i], nil, hs.screen.find(appConfig[2]), appConfig[3], nil, nil})
          end
          break;
        end
      end
    end
  end

  hs.layout.apply(transformedLayout)
end

local function getCurrentScreensId()
  currentScreens = {}
  for _, screen in ipairs(hs.screen.allScreens()) do
    table.insert(currentScreens, screen:name())
  end

  return getScreensId(currentScreens)
end

local function reformatLayout()
  currentScreensId = getCurrentScreensId()

  for _, layout in pairs(layouts) do
    if getScreensId(layout["screens"]) == currentScreensId then
      log("Using layout: " .. currentScreensId)
      applyLayout(layout)
      return
    end
  end

  log("There is no matching layout found")
end

hs.hotkey.bind({"alt"}, "0", reformatLayout)

-- ************************************************************
-- screen watcher to set layouts automatically
-- ************************************************************
local lastRecordedScreensId = getCurrentScreensId()

function screenChangedCallback()
  if lastRecordedScreensId ~= getCurrentScreensId() then
    reformatLayout()
  end
end

-- http://www.hammerspoon.org/go/#variablelife
-- use a global variable to keep watchers out of being GCed
screenWatcher = hs.screen.watcher.new(screenChangedCallback):start()

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
