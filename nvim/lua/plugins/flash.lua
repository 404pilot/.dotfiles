-- =============================================================================
-- Flash — fast cursor movement (easymotion + sneak replacement)
-- ref: https://github.com/folke/flash.nvim
--
-- Key bindings:
--   s        sneak-style jump: type 2 chars to jump to any match on screen
--   S        treesitter-aware jump: select a syntax node
--   <CR>     in f/t/F/T motions: toggle flash for enhanced targeting
-- =============================================================================
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  config = function()
    require("flash").setup()
  end,
  keys = {
    { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "flash jump" },
    { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "flash treesitter node" },
    { "r",     mode = "o",               function() require("flash").remote() end,             desc = "flash remote" },
    { "<CR>",  mode = { "n", "o", "x" }, function() require("flash").toggle() end,            desc = "flash toggle" },
  },
}
