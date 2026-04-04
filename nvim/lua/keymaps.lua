-- =============================================================================
-- Keymaps
-- =============================================================================

vim.g.mapleader      = " "   -- space as leader
vim.g.maplocalleader = " "

local map = function(mode, keys, action, desc)
  vim.keymap.set(mode, keys, action, { desc = desc, silent = true })
end

-- ---------------------------------------------------------------------------
-- General
-- ---------------------------------------------------------------------------
map("n", "<Esc>",        "<cmd>nohlsearch<CR>",       "clear search highlight")
map("n", "<leader>w",    "<cmd>write<CR>",             "save file")
map("n", "<leader>q",    "<cmd>quit<CR>",              "quit")

-- ---------------------------------------------------------------------------
-- Window navigation — ctrl+hjkl to move between splits
-- ---------------------------------------------------------------------------
map("n", "<C-h>", "<C-w>h", "move to left split")
map("n", "<C-j>", "<C-w>j", "move to lower split")
map("n", "<C-k>", "<C-w>k", "move to upper split")
map("n", "<C-l>", "<C-w>l", "move to right split")

-- ---------------------------------------------------------------------------
-- Buffer navigation
-- ---------------------------------------------------------------------------
map("n", "<S-l>", "<cmd>bnext<CR>",     "next buffer")
map("n", "<S-h>", "<cmd>bprevious<CR>", "previous buffer")
map("n", "<leader>x", "<cmd>bdelete<CR>", "close buffer")

-- ---------------------------------------------------------------------------
-- Move lines up/down in visual mode
-- ---------------------------------------------------------------------------
map("v", "J", ":m '>+1<CR>gv=gv", "move selection down")
map("v", "K", ":m '<-2<CR>gv=gv", "move selection up")

-- ---------------------------------------------------------------------------
-- Keep cursor centered when scrolling
-- ---------------------------------------------------------------------------
map("n", "<C-d>", "<C-d>zz", "scroll down (centered)")
map("n", "<C-u>", "<C-u>zz", "scroll up (centered)")

-- ---------------------------------------------------------------------------
-- Plugin keymaps (defined here for discoverability; plugins also bind their own)
-- ---------------------------------------------------------------------------

-- neo-tree
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", "toggle file tree")

-- fzf-lua  (see plugins/fzf.lua for full config)
map("n", "<leader>ff", "<cmd>FzfLua files<CR>",    "find files")
map("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>","live grep")
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>",  "find buffers")
map("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", "recent files")
map("n", "<leader>fk", "<cmd>FzfLua keymaps<CR>",  "find keymaps")
