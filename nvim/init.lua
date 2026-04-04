-- =============================================================================
-- Entry point
-- Load order matters: options and keymaps before plugins.
-- =============================================================================

require("options")
require("keymaps")

-- ---------------------------------------------------------------------------
-- Bootstrap lazy.nvim (plugin manager)
-- ref: https://github.com/folke/lazy.nvim
-- ---------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- ---------------------------------------------------------------------------
-- Load plugins
-- Each file in lua/plugins/ returns a lazy plugin spec.
-- ---------------------------------------------------------------------------
require("lazy").setup("plugins", {
  change_detection = { notify = false },   -- don't notify on config file changes
})
