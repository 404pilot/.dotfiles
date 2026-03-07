-- ---------------------------------------------------------------------------
-- Application shortcuts — alt+key to launch/focus app, keyed by machine name
-- ---------------------------------------------------------------------------
-- App name = name shown in /Applications or via:
--   for key,value in pairs(hs.application.runningApplications()) do print(key,value) end
local SHORTCUT_MAPPING = {
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
      -- ['4']   =   "Microsoft Teams",
      ['4']   =   "Microsoft Teams (work or school)",
      -- ['5']   =   "Royal TSX",
      -- ['5']   =   "Microsoft Remote Desktop",
      ['6']   =   "Microsoft Outlook",
  },
  -- Go to 'General - About' to update 'Name'
  ["Donut"] = {
      c       = "Google Chrome",
      f       = "Microsoft Edge",
      e       = "iTerm",
      v       = "klogg",
      -- r       = "Microsoft Remote Desktop",
      r       = "Microsoft Remote Desktop Beta",
      a       = "Arc",
      ["`"]   = "Finder",
      ["1"]   = "Visual Studio Code",
      ["2"]   = "Typora",
      ["3"]   = "Notion",
      -- ['4']   = "Microsoft Teams classic",
      -- ['4']   =   "Microsoft Teams (work or school)",
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

local function bind_keys_for_application_shortcuts()
  local laptop_id = hs.host.localizedName() -- name can be found in System Settings > Sharing
  local laptop_shortcut = getMapping(laptop_id, SHORTCUT_MAPPING)

  hs.application.enableSpotlightForNameSearches(true)
  for shortcut, app in pairs(laptop_shortcut) do
    hs.hotkey.bind({"alt"}, shortcut, function() hs.application.launchOrFocus(app) end)
  end
end

bind_keys_for_application_shortcuts()

-- https://github.com/Hammerspoon/hammerspoon/issues/272
