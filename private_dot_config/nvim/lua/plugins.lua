local packer = require("packer")
packer.startup({
  function(use)
    -- Packer 可以管理自己本身
    use 'wbthomason/packer.nvim'

    -- 你的插件列表...
    ---------------------- plugins ------------------------
    -- nvim-tree
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
    -- bufferline
    use({
      "akinsho/bufferline.nvim",
      requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" },
    })
    -- lualine
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
    })
    use("arkav/lualine-lsp-progress")
    -- telescope
    use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }
    -- telescope extensions
    use "LinArcX/telescope-env.nvim"
    -- alpha-nvim
    use {
      'goolord/alpha-nvim',
      config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
      end
    }
    -- project
    use("ahmedkhalf/project.nvim")
    -- nvim-treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    -- LSP
    use({ "williamboman/mason.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })
    use({ "neovim/nvim-lspconfig" })
    -- which key
    use {
        "folke/which-key.nvim",
        config = function()
        require("which-key").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
    end
}

    -- 补全引擎
    use("hrsh7th/nvim-cmp")
    -- snippet 引擎
     use("hrsh7th/vim-vsnip")
    -- 补全源
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }

    -- 常见编程语言代码段
    use("rafamadriz/friendly-snippets")

    --------------------- colorschemes --------------------
    -- tokyonight
    use 'folke/tokyonight.nvim'
    -- OceanicNext
    use 'mhartington/oceanic-next'
    -- kanagawa
    use "rebelot/kanagawa.nvim"
    -- zephyr
    use({ 'glepnir/zephyr-nvim',
          requires = { 'nvim-treesitter/nvim-treesitter', opt = true },
        })
    -- nord
    use 'shaunsingh/nord.nvim'
    -- onedark
    use 'ful1e5/onedark.nvim'
    -- nightfox
    use 'EdenEast/nightfox.nvim'
    -------------------------------------------------------
  end,

  config = {
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end,
    },
    -- 并发数限制
    max_jobs = 16,
    -- 自定义源
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      -- default_url_format = "https://gitclone.com/github.com/%s",
    },
  },
  -- 每次保存 plugins.lua 自动安装插件
  pcall(
    vim.cmd,
   [[
     augroup packer_user_config
     autocmd!
     autocmd BufWritePost plugins.lua source <afile> | PackerSync
     augroup end
   ]]
  )
})
