-- 先加载基础配置
require("basic")

-- 安装 lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 插件设置
require("plugins")

-- 快捷键映射
require("keybindings")

-- 主题设置
local ok, colorscheme = pcall(require, "colorscheme")
if not ok then
  print("colorscheme load error!")
end

-- 插件配置
require("plugin-config.nvim-tree")
require("plugin-config.bufferline")
require("plugin-config.lualine")
require("plugin-config.telescope")
-- require("plugin-config.nvim-treesitter")
-- require("plugin-config.alpha")
-- require("plugin-config.project")

-- lsp
-- require("lsp.setup")
-- require("lsp.cmp")
