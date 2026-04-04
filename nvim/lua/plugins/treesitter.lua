-- =============================================================================
-- Treesitter — syntax highlighting and code understanding
-- ref: https://github.com/nvim-treesitter/nvim-treesitter
-- =============================================================================
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",       -- update parsers when plugin updates
  config = function()
    -- guard: plugin may not be installed yet on first headless launch
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok then return end

    configs.setup({

      -- parsers to always install
      ensure_installed = {
        "bash",
        "javascript",
        "typescript",
        "lua",
        "json",
        "yaml",
        "markdown",
        "vim",
        "vimdoc",
      },

      auto_install = true,   -- auto-install missing parsers when opening a file

      highlight = {
        enable = true,
      },

      indent = {
        enable = true,       -- treesitter-based indentation
      },
    })
  end,

}
