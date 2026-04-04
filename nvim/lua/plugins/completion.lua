-- =============================================================================
-- Completion — nvim-cmp
-- ref: https://github.com/hrsh7th/nvim-cmp
--
-- Sources (in priority order):
--   nvim_lsp  → language server suggestions
--   luasnip   → snippet expansion
--   buffer    → words in current buffer
--   path      → filesystem paths
-- =============================================================================
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",      -- LSP source
    "hrsh7th/cmp-buffer",        -- buffer words source
    "hrsh7th/cmp-path",          -- path source
    "L3MON4D3/LuaSnip",          -- snippet engine
    "saadparwaiz1/cmp_luasnip",  -- luasnip source for cmp
  },
  config = function()
    local cmp     = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-n>"]     = cmp.mapping.select_next_item(),
        ["<C-p>"]     = cmp.mapping.select_prev_item(),
        ["<C-d>"]     = cmp.mapping.scroll_docs(-4),
        ["<C-f>"]     = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),       -- trigger completion manually
        ["<CR>"]      = cmp.mapping.confirm({ select = true }),

        -- tab: cycle through items or jump through snippet placeholders
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}
