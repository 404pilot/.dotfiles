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
