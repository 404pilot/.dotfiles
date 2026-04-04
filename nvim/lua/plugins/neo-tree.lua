-- =============================================================================
-- File tree — neo-tree
-- ref: https://github.com/nvim-neo-tree/neo-tree.nvim
--
-- Key bindings:
--   <leader>e   toggle file tree (defined in keymaps.lua)
--   within tree: o/enter=open, a=new file, d=delete, r=rename, y=copy, x=cut, p=paste
-- =============================================================================
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,   -- close neovim if neo-tree is the last window

      window = {
        width = 30,
      },

      filesystem = {
        filtered_items = {
          hide_dotfiles = false,     -- show dotfiles (useful for config editing)
          hide_gitignored = true,
        },
        follow_current_file = {
          enabled = true,            -- auto-reveal current file in tree
        },
      },
    })
  end,
}
