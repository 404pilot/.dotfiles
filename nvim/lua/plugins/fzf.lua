-- =============================================================================
-- Fuzzy finder — fzf-lua
-- ref: https://github.com/ibhagwan/fzf-lua
--
-- Key bindings (defined in keymaps.lua):
--   <leader>ff  find files
--   <leader>fg  live grep
--   <leader>fb  buffers
--   <leader>fr  recent files
--   <leader>fk  keymaps
-- =============================================================================
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      winopts = {
        height  = 0.85,
        width   = 0.80,
        preview = {
          layout = "vertical",      -- preview on the right
        },
      },
    })
  end,
}
