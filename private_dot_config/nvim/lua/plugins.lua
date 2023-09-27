require("lazy").setup({
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  "rebelot/kanagawa.nvim",
  { "kyazdani42/nvim-tree.lua", event = "VimEnter", dependencies = "nvim-tree/nvim-web-devicons" },
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  {'nvim-lualine/lualine.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  {'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = 'nvim-lua/plenary.nvim' },
})
