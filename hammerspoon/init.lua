hs.window.animationDuration = 0

local function adjustFrame(x, y, w, h)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w * x
  f.y = max.y + max.h * y
  f.w = max.w * w
  f.h = max.h * h

  win:setFrame(f)
end

local function toCenter()
  adjustFrame(0.1, 0, 0.8, 1)
end

local function toFull()
  adjustFrame(0, 0, 1, 1)
end

local function toTopHalf()
  adjustFrame(0, 0, 1, 0.5)
end

local function toBottomHalf()
  adjustFrame(0, 0.5, 1, 0.5)
end

local function toRightScreen()
  hs.window.focusedWindow():moveOneScreenEast(true, true)
end

local function toLeftScreen()
  hs.window.focusedWindow():moveOneScreenWest(true, true)
end

hs.hotkey.bind({"alt"}, "u", toCenter)
hs.hotkey.bind({"alt"}, "o", toFull)

hs.hotkey.bind({"alt"}, "i", toTopHalf)
hs.hotkey.bind({"alt"}, "k", toBottomHalf)

hs.hotkey.bind({"alt"}, "l", toRightScreen)
hs.hotkey.bind({"alt"}, "j", toLeftScreen)
