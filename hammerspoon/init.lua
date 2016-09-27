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
  -- local win = hs.window.focusedWindow()
  -- local f = win:frame()
  -- local screen = win:screen()
  -- local max = screen:frame()
  --
  -- win:moveToUnit(coordinate)

  -- f.x = max.x + max.w * coordinate.x
  -- f.y = max.y + max.h * coordinate.y
  -- f.w = max.w * coordinate.w
  -- f.h = max.h * coordinate.h

  -- win:setFrame(f)
end

local function toRightScreen()
  hs.window.focusedWindow():moveOneScreenEast(true, true)
end

local function toLeftScreen()
  hs.window.focusedWindow():moveOneScreenWest(true, true)
end

hs.hotkey.bind({"alt"}, "u", function() adjustFrame(centerCoordinate) end)
hs.hotkey.bind({"alt"}, "o", function() adjustFrame(maximizedCoordinate) end)

hs.hotkey.bind({"alt"}, "i", function() adjustFrame(topHalfCoordinate) end)
hs.hotkey.bind({"alt"}, "k", function() adjustFrame(bottomHalfCoordinate) end)

hs.hotkey.bind({"alt"}, "l", toRightScreen)
hs.hotkey.bind({"alt"}, "j", toLeftScreen)

-- ************************************************************
-- Application Shortcuts
-- ************************************************************

shortcuts = {
  c       =   "Google Chrome",
  a       =   "IntelliJ IDEA",
  v       =   "Postman",
  e       =   "iTerm",
  ["`"]   =   "Finder",
  ["1"]   =   "Atom",
  ["2"]   =   "Typora",
  ["3"]   =   "Safari",
  ['4']   =   "Slack"
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

-- local function findScreenFrame(screenName)
--   for index, screen in pairs(hs.screen.allScreens()) do
--     if screen:name() == screenName then
--       print(screen:name())
--       return screen:frame()
--     end
--   end
-- end

-- local function geometryRect(screenFrame, coordinate)
--   local x = screenFrame.x + screenFrame.w * coordinate.x
--   local y = screenFrame.y + screenFrame.h * coordinate.y
--   local w = screenFrame.w * coordinate.w
--   local h = screenFrame.h * coordinate.h
--
--   -- why does hammerspoon use offset here??? http://www.hammerspoon.org/docs/hs.layout.html#apply
--   if x < 0 then
--     x = (screenFrame.w + x) * (-1)
--   end
--
--   if y < 0 then
--     y = (screenFrame.h + y) * (-1)
--   end
--
--   return hs.geometry.rect(x, y, w, h)
-- end
--
-- only mac monitor is activated
local defautLayout = {
  -- get all active windows
  {"iTerm2",        nil,  macScreenName,   centerCoordinate,    nil, nil},
  {"Google Chrome", nil,  macScreenName,   maximizedCoordinate, nil, nil},
  {"Safari",        nil,  macScreenName,   centerCoordinate,    nil, nil},
  {"Slack",         nil,  macScreenName,   centerCoordinate,    nil, nil},
  {"IntelliJ IDEA", nil,  macScreenName,   maximizedCoordinate, nil, nil}
}

local threeMonitorsLayout = {
  {"iTerm2",        nil,  macScreenName,    centerCoordinate,      nil, nil},

  {"Google Chrome", nil,  middleScreenName, maximizedCoordinate,   nil, nil},

  {"Safari",        nil,  eastScreenName,   topHalfCoordinate,     nil, nil},
  {"Slack",         nil,  eastScreenName,   bottomHalfCoordinate,  nil, nil}
}

local function applyLayoutWhenNoExternelMonitorsAreUsed()
  hs.layout.apply(defautLayout)
end

local function applyLayoutWhenTwoExternelMonitorsAreUsed()
  hs.layout.apply(threeMonitorsLayout)
end

hs.hotkey.bind({"alt"}, "9", applyLayoutWhenNoExternelMonitorsAreUsed)
hs.hotkey.bind({"alt"}, "0", applyLayoutWhenTwoExternelMonitorsAreUsed)


-- local lastNumberOfScreens = #hs.screen.allScreens()
-- function screenWatcher()
--     print(table.show(hs.screen.allScreens(), "allScreens"))
--     newNumberOfScreens = #hs.screen.allScreens()
--
--     -- FIXME: This is awful if we swap primary screen to the external display. all the windows swap around, pointlessly.
--     -- if lastNumberOfScreens ~= newNumberOfScreens then
--         if newNumberOfScreens == 1 then
--             notify("Screens changed to Internal Display")
--             hs.layout.apply(internal_display)
--         elseif newNumberOfScreens == 2 then
--             notify("Screens changed to Desk Display")
--             hs.layout.apply(desk_display)
--         end
--     -- end
--
--     lastNumberOfScreens = newNumberOfScreens
-- end
-- hs.screen.watcher.new(screenWatcher):start()
-- hs.hotkey.bind(ctrlaltcmd, 'S', screenWatcher)
