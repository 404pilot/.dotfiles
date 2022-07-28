require("helper")

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
