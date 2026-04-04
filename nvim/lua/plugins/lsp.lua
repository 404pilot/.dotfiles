-- =============================================================================
-- LSP — language server protocol (neovim 0.11+ native API)
--
-- Stack:
--   mason            → installs/manages LSP server binaries  (:Mason)
--   mason-lspconfig  → maps mason packages to lsp server names + auto-installs
--   nvim-lspconfig   → provides default server configs (cmd, filetypes, root_dir)
--   vim.lsp.config   → neovim 0.11 native API for per-server configuration
-- =============================================================================
return {
  -- mason: install and manage LSP server binaries
  -- ref: https://github.com/williamboman/mason.nvim
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- mason-lspconfig: auto-install servers and map to neovim LSP names
  -- ref: https://github.com/williamboman/mason-lspconfig.nvim
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",          -- bash (bash-language-server)
          "powershell_es",   -- powershell (PowerShell Editor Services)
          "ts_ls",           -- javascript + typescript
        },
        automatic_installation = true,
      })
    end,
  },

  -- nvim-lspconfig: registers default server configs (cmd, filetypes, root_dir)
  -- we do NOT call lspconfig[server].setup() — use vim.lsp.config instead (0.11+)
  -- ref: https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- keymaps applied when an LSP attaches to a buffer
      local on_attach = function(_, bufnr)
        local map = function(keys, action, desc)
          vim.keymap.set("n", keys, action, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        map("gd",          vim.lsp.buf.definition,    "go to definition")
        map("gr",          vim.lsp.buf.references,    "references")
        map("K",           vim.lsp.buf.hover,          "hover docs")
        map("<leader>rn",  vim.lsp.buf.rename,         "rename symbol")
        map("<leader>ca",  vim.lsp.buf.code_action,    "code action")
        map("[d",          vim.diagnostic.goto_prev,   "previous diagnostic")
        map("]d",          vim.diagnostic.goto_next,   "next diagnostic")
        map("<leader>d",   vim.diagnostic.open_float,  "show diagnostic")
      end

      -- configure and enable each server using the neovim 0.11 native API
      local servers = { "bashls", "powershell_es", "ts_ls" }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
          on_attach    = on_attach,
        })
      end

      vim.lsp.enable(servers)
    end,
  },
}
