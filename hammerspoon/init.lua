-- ************************************************************
-- Windows Management
-- ************************************************************

hs.window.animationDuration = 0

local centerCoordinate =      {x = 0.1, y = 0,    w = 0.8,  h = 1}
local maximizedCoordinate =   {x = 0,   y = 0,    w = 1,    h = 1}
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

hs.hotkey.bind({"alt"}, "l", toNextScreen)
hs.hotkey.bind({"alt"}, "j", toPreviousScreen)

-- ************************************************************
-- Application Shortcuts
-- ************************************************************

shortcuts = {
  c       =   "Google Chrome Canary",
  a       =   "IntelliJ IDEA",
  s       =   "RubyMine",
  v       =   "Postman",
  e       =   "iTerm",
  ["`"]   =   "Finder",
  ["1"]   =   "Atom",
  ["2"]   =   "Typora",
  ["3"]   =   "Safari",
  ['4']   =   "Slack",
  ['5']   =   "Postico"
}

for shortcut, app in pairs(shortcuts) do
  hs.hotkey.bind({"alt"}, shortcut, function() hs.application.launchOrFocus(app) end)
end

-- ************************************************************
-- auto layout
-- ************************************************************
local macScreenName    = "Color LCD"
local middleScreenName = "DELL P2210"
local eastScreenName   = "DELL G2210"

local defautLayout = {
  {"iTerm2",        nil,  macScreenName,   centerCoordinate,    nil, nil},
  {"Google Chrome", nil,  macScreenName,   maximizedCoordinate, nil, nil},
  {"Safari",        nil,  macScreenName,   centerCoordinate,    nil, nil},
  {"Slack",         nil,  macScreenName,   centerCoordinate,    nil, nil},
  {"IntelliJ IDEA", nil,  macScreenName,   maximizedCoordinate, nil, nil},
  {"RubyMine",      nil,  macScreenName,   maximizedCoordinate, nil, nil},
  {"Atom",          nil,  macScreenName,   centerCoordinate,    nil, nil},
  {"Postman",       nil,  macScreenName,   centerCoordinate,    nil, nil},
  {"Typora",        nil,  macScreenName,   centerCoordinate,    nil, nil}
}

local threeMonitorsLayout = {
  {"Atom",          nil,  macScreenName,    centerCoordinate,      nil, nil},
  {"iTerm2",        nil,  macScreenName,    centerCoordinate,      nil, nil},
  {"Typora",        nil,  macScreenName,    centerCoordinate,      nil, nil},

  {"Google Chrome", nil,  middleScreenName, maximizedCoordinate,   nil, nil},
  {"RubyMine",      nil,  middleScreenName, maximizedCoordinate,   nil, nil},
  {"IntelliJ IDEA", nil,  middleScreenName, maximizedCoordinate,   nil, nil},

  {"Safari",        nil,  eastScreenName,   topHalfCoordinate,     nil, nil},
  {"Slack",         nil,  eastScreenName,   bottomHalfCoordinate,  nil, nil},
  {"Postman",       nil,  eastScreenName,   maximizedCoordinate,   nil, nil}
}

local function applyLayoutWhenNoExternelMonitorsAreUsed()
  hs.layout.apply(defautLayout)
end

local function applyLayoutWhenTwoExternelMonitorsAreUsed()
  hs.layout.apply(threeMonitorsLayout)
end

local function reformatLayout()
  currentNumberOfScreens = #hs.screen.allScreens()

  if currentNumberOfScreens == 1 then
    applyLayoutWhenNoExternelMonitorsAreUsed()
  elseif currentNumberOfScreens == 3 then
    applyLayoutWhenTwoExternelMonitorsAreUsed()
  end
end

hs.hotkey.bind({"alt"}, "0", reformatLayout)

-- ************************************************************
-- screen watcher to set layouts automatically
-- ************************************************************
local lastNumberOfScreens = #hs.screen.allScreens()

function screenChangedCallback()
    currentNumberOfScreens = #hs.screen.allScreens()

    if currentNumberOfScreens ~= lastNumberOfScreens then
      if currentNumberOfScreens == 1 then
        -- all external screen are unpluged
        applyLayoutWhenNoExternelMonitorsAreUsed()
      elseif currentNumberOfScreens == 3 then
        -- either 1 screen or 3 screens in my life
        applyLayoutWhenTwoExternelMonitorsAreUsed()
      end

      lastNumberOfScreens = currentNumberOfScreens
    end
end

hs.screen.watcher.new(screenChangedCallback):start()

-- ************************************************************
-- wifi watcher to mute audio when it is not a home environment
-- ************************************************************
local homeSSIDs = {"NEXUS2016", "NEXUS2016_5G"}
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

    if newSSID ~= lastSSID then
      if inTable(homeSSIDs, newSSID) then
        if hs.audiodevice.defaultOutputDevice():muted() then
          hs.audiodevice.defaultOutputDevice():setMuted(false)
        end

        if hs.audiodevice.defaultOutputDevice():volume() == 0 then
          hs.audiodevice.defaultOutputDevice():setVolume(25)
        end
      else
        hs.notify.new({title="Hammerspoon", informativeText="Laptop is muted since this is not a home wifi"}):send()

        hs.audiodevice.defaultOutputDevice():setMuted(true)
      end

      lastSSID = newSSID
    end
end

hs.wifi.watcher.new(ssidChangedCallback):start()
