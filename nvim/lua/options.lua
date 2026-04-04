-- =============================================================================
-- Editor options
-- =============================================================================

local opt = vim.opt

-- ---------------------------------------------------------------------------
-- Line numbers
-- ---------------------------------------------------------------------------
opt.number         = true    -- show absolute line number on current line
opt.relativenumber = true    -- show relative numbers on all other lines

-- ---------------------------------------------------------------------------
-- Indentation
-- ---------------------------------------------------------------------------
opt.tabstop     = 2          -- tab = 2 spaces
opt.shiftwidth  = 2          -- indent = 2 spaces
opt.expandtab   = true       -- use spaces instead of tabs
opt.smartindent = true       -- auto-indent new lines

-- ---------------------------------------------------------------------------
-- Search
-- ---------------------------------------------------------------------------
opt.ignorecase = true        -- case-insensitive search...
opt.smartcase  = true        -- ...unless the query contains uppercase
opt.hlsearch   = true        -- highlight matches
opt.incsearch  = true        -- show matches as you type

-- ---------------------------------------------------------------------------
-- Appearance
-- ---------------------------------------------------------------------------
opt.cursorline  = true       -- highlight the current line
opt.signcolumn  = "yes"      -- always show sign column (prevents layout shift)
opt.wrap        = false      -- don't wrap long lines
opt.scrolloff   = 8          -- keep 8 lines visible above/below cursor
opt.termguicolors = true     -- enable 24-bit color

-- ---------------------------------------------------------------------------
-- Splits
-- ---------------------------------------------------------------------------
opt.splitright = true        -- vertical splits open to the right
opt.splitbelow = true        -- horizontal splits open below

-- ---------------------------------------------------------------------------
-- Clipboard
-- ---------------------------------------------------------------------------
opt.clipboard = "unnamedplus" -- sync with system clipboard

-- ---------------------------------------------------------------------------
-- Files
-- ---------------------------------------------------------------------------
opt.swapfile = false         -- no swap files
opt.backup   = false         -- no backup files
opt.undofile = true          -- persistent undo across sessions
