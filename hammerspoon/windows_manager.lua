require("helper")

-- ************************************************************
-- Windows Management
-- ************************************************************

hs.window.animationDuration  = 0

local CENTER_COORDINATE      = { x = 0.1, y = 0, w = 0.8, h = 1 }
local MAXIMIZED_COORDINATE   = { x = 0, y = 0, w = 1, h = 1 }
local LEFT_HALF_COORDINATE   = { x = 0, y = 0, w = 0.5, h = 1 }
local RIGHT_HALF_COORDINATE  = { x = 0.5, y = 0, w = 0.5, h = 1 }
local TOP_HALF_COORDINATE    = { x = 0, y = 0, w = 1, h = 0.5 }
local BOTTOM_HALF_COORDINATE = { x = 0, y = 0.5, w = 1, h = 0.5 }

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

local function bind_keys_for_windows_management()
  hs.hotkey.bind({ "alt" }, "u", function() adjustFrame(CENTER_COORDINATE) end)
  hs.hotkey.bind({ "alt" }, "o", function() adjustFrame(MAXIMIZED_COORDINATE) end)

  hs.hotkey.bind({ "alt" }, "i", function() adjustFrame(TOP_HALF_COORDINATE) end)
  hs.hotkey.bind({ "alt" }, "k", function() adjustFrame(BOTTOM_HALF_COORDINATE) end)
  hs.hotkey.bind({ "alt" }, "j", toNextScreen)
  hs.hotkey.bind({ "alt" }, "l", toPreviousScreen)

  hs.hotkey.bind({ "alt, shift" }, "j", function() adjustFrame(LEFT_HALF_COORDINATE) end)
  hs.hotkey.bind({ "alt, shift" }, "l", function() adjustFrame(RIGHT_HALF_COORDINATE) end)
  -- hs.hotkey.bind({"alt, shift"}, "l", toNextScreen)
  -- hs.hotkey.bind({"alt, shift"}, "j", toPreviousScreen)
end

bind_keys_for_windows_management()

-- ************************************************************
-- auto layout
-- ************************************************************
-- get monitor name by
--   for index,value in pairs(hs.screen.allScreens()) do print(value:name() .. " - " .. value:id()) end
-- get application name by
--   for key,value in pairs(hs.application.runningApplications()) do print(key,value) end

local MAC_SCREEN        = "Built-in Retina Display"
local Dell_P2721Q_LEFT  = "DELL P2721Q (1)"
local Dell_P2721Q_RIGHT = "DELL P2721Q (2)"
local Dell_U2718Q       = "DELL U2718Q"

local CUSTOM_LAYOUTS    = {
  officeLayout = {
    screens = { Dell_P2721Q_LEFT, Dell_P2721Q_RIGHT },
    appConfigs = {
      { "Google Chrome",                 Dell_P2721Q_LEFT,  MAXIMIZED_COORDINATE },
      { "Microsoft Edge",                Dell_P2721Q_LEFT,  MAXIMIZED_COORDINATE },
      { "Microsoft Remote Desktop Beta", Dell_P2721Q_LEFT,  MAXIMIZED_COORDINATE },
      { "Code",                          Dell_P2721Q_LEFT,  MAXIMIZED_COORDINATE },
      { "klogg log viewer",              Dell_P2721Q_LEFT,  MAXIMIZED_COORDINATE },

      { "Finder",                        Dell_P2721Q_RIGHT, CENTER_COORDINATE },
      { "Activity Monitor",              Dell_P2721Q_RIGHT, CENTER_COORDINATE },
      { "MarkText",                      Dell_P2721Q_RIGHT, CENTER_COORDINATE },
      { "Preview",                       Dell_P2721Q_RIGHT, MAXIMIZED_COORDINATE },
      { "iTerm2",                        Dell_P2721Q_RIGHT, MAXIMIZED_COORDINATE },
      { "Microsoft Outlook",             Dell_P2721Q_RIGHT, MAXIMIZED_COORDINATE },
      { "Microsoft Word",                Dell_P2721Q_RIGHT, MAXIMIZED_COORDINATE },
      { "Microsoft Excel",               Dell_P2721Q_RIGHT, MAXIMIZED_COORDINATE },
      { "Notion",                        Dell_P2721Q_RIGHT, CENTER_COORDINATE },
      { "Microsoft Teams",               Dell_P2721Q_RIGHT, MAXIMIZED_COORDINATE },
      { "Arc",                           Dell_P2721Q_RIGHT, CENTER_COORDINATE },
    }
  },
  homeLayout = {
    screens = { MAC_SCREEN, Dell_U2718Q },
    appConfigs = {
      { "Google Chrome",            Dell_U2718Q, MAXIMIZED_COORDINATE },
      { "Microsoft Edge",           Dell_U2718Q, MAXIMIZED_COORDINATE },
      { "Microsoft Remote Desktop", Dell_U2718Q, MAXIMIZED_COORDINATE },
      { "Code",                     Dell_U2718Q, MAXIMIZED_COORDINATE },
      { "klogg log viewer",         Dell_U2718Q, MAXIMIZED_COORDINATE },

      { "Finder",                   MAC_SCREEN,  CENTER_COORDINATE },
      { "Activity Monitor",         MAC_SCREEN,  CENTER_COORDINATE },
      { "MarkText",                 MAC_SCREEN,  CENTER_COORDINATE },
      { "Preview",                  MAC_SCREEN,  MAXIMIZED_COORDINATE },
      { "iTerm2",                   MAC_SCREEN,  MAXIMIZED_COORDINATE },
      { "Microsoft Outlook",        MAC_SCREEN,  MAXIMIZED_COORDINATE },
      { "Microsoft Word",           MAC_SCREEN,  MAXIMIZED_COORDINATE },
      { "Microsoft Excel",          MAC_SCREEN,  MAXIMIZED_COORDINATE },
      { "Notion",                   MAC_SCREEN,  MAXIMIZED_COORDINATE },
      { "Microsoft Teams",          MAC_SCREEN,  MAXIMIZED_COORDINATE },
    }
  },
  defaultLayout = {
    screens = "default",
    appConfigs = {
      { "iTerm2",            MAC_SCREEN, CENTER_COORDINATE },
      { "Notion",            MAC_SCREEN, CENTER_COORDINATE },
      { "Trello",            MAC_SCREEN, CENTER_COORDINATE },
      { "Typora",            MAC_SCREEN, CENTER_COORDINATE },
      { "Finder",            MAC_SCREEN, CENTER_COORDINATE },
      { "Activity Monitor",  MAC_SCREEN, CENTER_COORDINATE },
      { "MarkText",          MAC_SCREEN, CENTER_COORDINATE },
      { "Microsoft Teams",   MAC_SCREEN, MAXIMIZED_COORDINATE },
      { "Code",              MAC_SCREEN, MAXIMIZED_COORDINATE },
      { "Preview",           MAC_SCREEN, MAXIMIZED_COORDINATE },
      { "Google Chrome",     MAC_SCREEN, MAXIMIZED_COORDINATE },
      { "IntelliJ IDEA",     MAC_SCREEN, MAXIMIZED_COORDINATE },
      { "Microsoft Outlook", MAC_SCREEN, MAXIMIZED_COORDINATE },
      { "PyCharm",           MAC_SCREEN, MAXIMIZED_COORDINATE },
      { "klogg log viewer",  MAC_SCREEN, MAXIMIZED_COORDINATE },
    }
  }
}

-- For each layout, there is a screens combination key to be used to idenitfy which layout will be used
-- Basically, it concatenates all screens names sorted by the name
local function getScreensCombinationKey(screens)
  -- screens: a list of screen names
  local screensCopy = { table.unpack(screens) }
  table.sort(screensCopy)

  return table.concat(screensCopy, ",")
end

local function applyLayout(layout)
  local transformedLayout = {}

  for _, appConfig in pairs(layout["appConfigs"]) do
    -- Try to get first two applications which are matched by name because
    --    google chrome and google chrome canary are sharing the same "Google Chrome"

    local app1, app2 = hs.application.find(appConfig[1])

    local apps = { app1, app2 }

    for i = 1, 2 do
      if apps[i] ~= nil then
        -- if hs.application.name(apps[i]) == appConfig[1] then
        if apps[i].name(apps[i]) == appConfig[1] then
          -- for example, "Built-in Retina Display" needs to be converted to "Built%-in Retina Display"
          local escapedScreenName = appConfig[2]:gsub("([%(%)%-])", "%%%1") -- escape '(', ')' and '-'
          log('app: ' .. appConfig[1] .. '-> escapedScreenName is ' .. escapedScreenName)

          table.insert(transformedLayout, { apps[i], nil, hs.screen.find(escapedScreenName), appConfig[3], nil, nil })
          break;
        end
      end
    end
  end

  hs.layout.apply(transformedLayout)
end

local function getCurrentScreensCombinationKey()
  local currentScreens = {}
  for _, screen in ipairs(hs.screen.allScreens()) do
    table.insert(currentScreens, screen:name())
  end

  return getScreensCombinationKey(currentScreens)
end

local function reformatLayout()
  if #hs.screen.allScreens() == 1 then
    log("Using layout: default")
    applyLayout(CUSTOM_LAYOUTS['defaultLayout'])
    return
  end

  currentScreensCombinationKey = getCurrentScreensCombinationKey()

  for _, layout in pairs(CUSTOM_LAYOUTS) do
    if getScreensCombinationKey(layout["screens"]) == currentScreensCombinationKey then
      log("Using layout: " .. currentScreensCombinationKey)
      applyLayout(layout)
      return
    end
  end

  log("There is no matching layout found")
end

local function bind_keys_for_windows_auto_formatting()
  hs.hotkey.bind({ "alt" }, "0", reformatLayout)
end

bind_keys_for_windows_auto_formatting()

-- ************************************************************
-- screen watcher to set layouts automatically
-- ************************************************************
local lastRecordedScreensCombinationKey = getCurrentScreensCombinationKey()

local function screenChangedCallback()
  local currentScreensCombinationKey = getCurrentScreensCombinationKey()
  if lastRecordedScreensCombinationKey ~= currentScreensCombinationKey then
    log("Reformatting layouts. current id = " .. currentScreensCombinationKey .. "; last recorded id = " .. lastRecordedScreensCombinationKey)
    hs.execute("sleep 2")

    reformatLayout()

    lastRecordedScreensCombinationKey = currentScreensCombinationKey
  end
end

local function register_screen_change_detector()
  -- http://www.hammerspoon.org/go/#variablelife
  -- use a global variable to keep watchers out of being GCed
  screenWatcher = hs.screen.watcher.new(screenChangedCallback):start()
end

register_screen_change_detector()

-- ************************************************************
-- Screens layout arrangement
-- ************************************************************
local homeScreens = { MAC_SCREEN, Dell_U2718Q }

local function getResolution(screenName)
  local screenX = hs.screen.find(screenName)
  local x = screenX:currentMode()['w']
  local y = screenX:currentMode()['h']

  log("screen " .. screenName .. "resolution: " .. x .. " x " .. y)

  return { x, y }
end

--       ┌────────┐
-- ┌─────┤  dell  │
-- │ mac ├────────┘
-- └─────┘
local function setScreensArrangementA()
  if getCurrentScreensCombinationKey() == getScreensCombinationKey(homeScreens) then
    log("At home!")

    local macResolution = getResolution(MAC_SCREEN_LUA)
    local dellResolution = getResolution(Dell_U2718Q)
    local gap = 360

    local x = macResolution[1]
    local y = (dellResolution[2] + gap - macResolution[2]) * -1

    log("Setting origin: " .. x .. " x " .. y)

    hs.screen.find(Dell_U2718Q):setOrigin(x, y)

    hs.notify.show("Hammerspoon", "Updating display arragement", "ArrangementA")
  end
end

-- ┌─────────┐
-- │  dell   │
-- └─┬─────┬─┘
--   │ mac │
--   └─────┘
local function setScreensArrangementB()
  if getCurrentScreensCombinationKey() == getScreensCombinationKey(homeScreens) then
    log("At home!")

    local macResolution = getResolution(MAC_SCREEN_LUA)
    local dellResolution = getResolution(Dell_U2718Q)

    local x = (dellResolution[1] - macResolution[1]) / 2 * -1
    local y = dellResolution[2] * -1

    log("Setting origin: " .. x .. " x " .. y)

    hs.screen.find(Dell_U2718Q):setOrigin(x, y)

    hs.notify.show("Hammerspoon", "Updating display arragement", "ArrangementB")
  end
end

local function bindKeysToSetScreensArrangement()
  hs.hotkey.bind({ "alt" }, "-", function() setScreensArrangementA() end)
  hs.hotkey.bind({ "alt" }, "=", function() setScreensArrangementB() end)
end

bindKeysToSetScreensArrangement()
