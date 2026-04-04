-- =============================================================================
-- Color scheme — gruvbox
-- ref: https://github.com/ellisonleao/gruvbox.nvim
-- =============================================================================
return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,           -- load before all other plugins
  config = function()
    require("gruvbox").setup({
      contrast = "hard",     -- "hard" | "medium" | "soft"
      italic = {
        strings   = false,   -- don't italicize strings
        comments  = true,
        operators = false,
        folds     = true,
      },
    })

    vim.o.background = "dark"
    vim.cmd("colorscheme gruvbox")
  end,
}
