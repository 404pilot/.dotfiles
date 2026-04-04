-- =============================================================================
-- Git signs — gutter indicators for changed lines
-- ref: https://github.com/lewis6991/gitsigns.nvim
--
-- Signs:
--   │  added line
--   │  changed line
--   ▸  deleted line
-- =============================================================================
return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "▸" },
        topdelete    = { text = "▸" },
        changedelete = { text = "│" },
      },

      -- navigate between hunks
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(keys, action, desc)
          vim.keymap.set("n", keys, action, { buffer = bufnr, desc = "Git: " .. desc })
        end

        map("]h", gs.next_hunk, "next hunk")
        map("[h", gs.prev_hunk, "previous hunk")
        map("<leader>hp", gs.preview_hunk,    "preview hunk")
        map("<leader>hr", gs.reset_hunk,      "reset hunk")
        map("<leader>hs", gs.stage_hunk,      "stage hunk")
        map("<leader>hb", gs.blame_line,      "blame line")
      end,
    })
  end,
}
