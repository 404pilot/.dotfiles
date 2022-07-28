require("helper")

-- ************************************************************
-- Windows Management
-- ************************************************************

hs.window.animationDuration = 0

local CENTER_COORDINATE       =      {x = 0.1, y = 0,    w = 0.8,  h = 1}
local MAXIMIZED_COORDINATE    =      {x = 0,   y = 0,    w = 1,    h = 1}
local LEFT_HALF_COORDINATE    =      {x = 0,   y = 0,    w = 0.5,  h = 1}
local RIGHT_HALF_COORDINATE   =      {x = 0.5, y = 0,    w = 0.5,  h = 1}
local TOP_HALF_COORDINATE     =      {x = 0,   y = 0,    w = 1,    h = 0.5}
local BOTTOM_HALF_COORDINATE  =      {x = 0,   y = 0.5,  w = 1,    h = 0.5}

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
  hs.hotkey.bind({"alt"}, "u", function() adjustFrame(CENTER_COORDINATE) end)
  hs.hotkey.bind({"alt"}, "o", function() adjustFrame(MAXIMIZED_COORDINATE) end)

  hs.hotkey.bind({"alt"}, "i", function() adjustFrame(TOP_HALF_COORDINATE) end)
  hs.hotkey.bind({"alt"}, "k", function() adjustFrame(BOTTOM_HALF_COORDINATE) end)
  hs.hotkey.bind({"alt"}, "j", toNextScreen)
  hs.hotkey.bind({"alt"}, "l", toPreviousScreen)

  hs.hotkey.bind({"alt, shift"}, "j", function() adjustFrame(LEFT_HALF_COORDINATE) end)
  hs.hotkey.bind({"alt, shift"}, "l", function() adjustFrame(RIGHT_HALF_COORDINATE) end)
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

local MAC_SCREEN   = "Built-in Retina Display"
local MAC_SCREEN_LUA = "Built%-in Retina Display"
local Dell_P2721Q = "DELL P2721Q"
local Dell_U2718Q = "DELL U2718Q"

local CUSTOM_LAYOUTS = {
  officeLayout={
    -- office: Dell_P2721Q(main) - MAC_SCREEN
    screens={Dell_P2721Q, MAC_SCREEN},
    appConfigs={
      {"Google Chrome",             Dell_P2721Q,     MAXIMIZED_COORDINATE},
      {"Microsoft Edge",            Dell_P2721Q,     MAXIMIZED_COORDINATE},
      {"Microsoft Remote Desktop",  Dell_P2721Q,     MAXIMIZED_COORDINATE},
      {"Code",                      Dell_P2721Q,     MAXIMIZED_COORDINATE},

      {"Finder",                    MAC_SCREEN,      CENTER_COORDINATE},
      {"Activity Monitor",          MAC_SCREEN,      CENTER_COORDINATE},
      {"MarkText",                  MAC_SCREEN,      CENTER_COORDINATE},
      {"Preview",                   MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"iTerm2",                    MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"Microsoft Outlook",         MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"Microsoft Word",            MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"Microsoft Excel",           MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"Notion",                    MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"Microsoft Teams",           MAC_SCREEN,      MAXIMIZED_COORDINATE},
    }
  },
  homeLayout={
    -- home: MAC_SCREEN(main) - Dell_U2718Q
    screens={MAC_SCREEN,Dell_U2718Q},
    appConfigs={
      {"Google Chrome",             Dell_U2718Q,     MAXIMIZED_COORDINATE},
      {"Microsoft Edge",            Dell_U2718Q,     MAXIMIZED_COORDINATE},
      {"Microsoft Remote Desktop",  Dell_U2718Q,     MAXIMIZED_COORDINATE},
      {"Code",                      Dell_U2718Q,     MAXIMIZED_COORDINATE},

      {"Finder",                    MAC_SCREEN,      CENTER_COORDINATE},
      {"Activity Monitor",          MAC_SCREEN,      CENTER_COORDINATE},
      {"MarkText",                  MAC_SCREEN,      CENTER_COORDINATE},
      {"Preview",                   MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"iTerm2",                    MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"Microsoft Outlook",         MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"Microsoft Word",            MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"Microsoft Excel",           MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"Notion",                    MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"Microsoft Teams",           MAC_SCREEN,      MAXIMIZED_COORDINATE},
    }
  },
  defaultLayout={
    screens={MAC_SCREEN},
    appConfigs={
      {"iTerm2",                    MAC_SCREEN,      CENTER_COORDINATE},
      {"Notion",                    MAC_SCREEN,      CENTER_COORDINATE},
      {"Postman",                   MAC_SCREEN,      CENTER_COORDINATE},
      {"Slack",                     MAC_SCREEN,      CENTER_COORDINATE},
      {"Trello",                    MAC_SCREEN,      CENTER_COORDINATE},
      {"Typora",                    MAC_SCREEN,      CENTER_COORDINATE},
      {"Finder",                    MAC_SCREEN,      CENTER_COORDINATE},
      {"Telegram",                  MAC_SCREEN,      CENTER_COORDINATE},
      {"Activity Monitor",          MAC_SCREEN,      CENTER_COORDINATE},
      {"Code",                      MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"Preview",                   MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"Google Chrome",             MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"Google Chrome Canary",      MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"IntelliJ IDEA",             MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"Microsoft Outlook",         MAC_SCREEN,      MAXIMIZED_COORDINATE},
      {"PyCharm",                   MAC_SCREEN,      MAXIMIZED_COORDINATE},
    }
  }
}

local function getScreensId(screens)
  -- screens: a list of screen names
  local screensCopy = {table.unpack(screens)}
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
          if appConfig[2] == MAC_SCREEN then
            -- hack!
            table.insert(transformedLayout, {apps[i], nil, hs.screen.find(MAC_SCREEN_LUA), appConfig[3], nil, nil})
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

  for _, layout in pairs(CUSTOM_LAYOUTS) do
    if getScreensId(layout["screens"]) == currentScreensId then
      log("Using layout: " .. currentScreensId)
      applyLayout(layout)
      return
    end
  end

  log("There is no matching layout found")
end

local function bind_keys_for_windows_auto_formatting()
  hs.hotkey.bind({"alt"}, "0", reformatLayout)
end

bind_keys_for_windows_auto_formatting()

-- ************************************************************
-- screen watcher to set layouts automatically
-- ************************************************************
local lastRecordedScreensId = getCurrentScreensId()

local function screenChangedCallback()
  if lastRecordedScreensId ~= getCurrentScreensId() then
    reformatLayout()
  end
end

local function register_screen_change_detector()
  -- http://www.hammerspoon.org/go/#variablelife
  -- use a global variable to keep watchers out of being GCed
  screenWatcher = hs.screen.watcher.new(screenChangedCallback):start()
end

register_screen_change_detector()
