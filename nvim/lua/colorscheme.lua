-- local colorscheme = "gruvbox"
-- local colorscheme = "tokyonight"
local colorscheme = "OceanicNext"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme) -- run :colorscheme OceanicNext
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " 没有找到！")
  return
end