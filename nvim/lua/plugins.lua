local packer = require("packer")
packer.startup({
  function(use)
    -- Packer 可以管理自己本身
    use "wbthomason/packer.nvim"
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
    use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } })
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
    use("arkav/lualine-lsp-progress")
    use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
    use("LinArcX/telescope-env.nvim")
    use({"glepnir/dashboard-nvim", requires = {"nvim-tree/nvim-web-devicons"} })
    use("ahmedkhalf/project.nvim")
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    --------------------- LSP --------------------
    use("williamboman/nvim-lsp-installer")
    -- Lspconfig
    use({ "neovim/nvim-lspconfig" })

    -- 你的插件列表...
    -- tokyonight
    use("mhartington/oceanic-next")
    use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end
    }
  }
})

-- 每次保存 plugins.lua 自动安装插件
local status_ok, _ = pcall(vim.cmd, [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
  ]])

if not status_ok then
  vim.notify("Not able to run :PackerSync automatically")
  return
end
