-- =============================================================================
-- which-key — popup showing available keybindings after a prefix
-- ref: https://github.com/folke/which-key.nvim
--
-- Press <leader> (space) and wait — a popup shows all available shortcuts
-- =============================================================================
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>f", group = "find" },
      { "<leader>h", group = "hunk (git)" },
      { "<leader>c", group = "code action" },
    },
  },
  keys = {
    {
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc = "buffer local keymaps (which-key)",
    },
  },
}
