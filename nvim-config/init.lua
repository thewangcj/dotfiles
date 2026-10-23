-- ============================================================
-- Neovim 配置入口文件
-- 适用于 Neovim 0.12+，使用 vim.pack 原生插件管理
-- 主要开发语言：C++ / Qt / Python
-- ============================================================

-- 设置 Leader 键为空格（必须在加载插件之前设置）
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 判断是否在 VSCode Neovim 插件中运行
-- VSCode 的 Neovim 插件会自动设置 vim.g.vscode = 1
vim.g.is_vscode = vim.g.vscode ~= nil

-- LSP 默认关闭，适用于有第三方程序白名单限制的环境。
-- 本机通过 chezmoi 的 enableLsp 参数覆盖默认值。
if vim.g.enable_lsp == nil then
  vim.g.enable_lsp = false
end

-- Tree-sitter 默认关闭，使用内置语法高亮。
-- 本机通过 chezmoi 的 enableTreesitter 参数覆盖默认值。
if vim.g.enable_treesitter == nil then
  vim.g.enable_treesitter = false
end

-- 加载基础配置（始终加载）
require("config.basic")
require("config.style")
require("config.tabsize")

-- 加载插件（根据环境自动适配 VSCode/完整模式）
require("config.plugins")

-- 加载快捷键配置
require("config.keybindings")

-- 加载自动命令
require("config.autocmds")

-- 加载配色方案（VSCode 使用自己的主题，跳过）
if not vim.g.is_vscode then
  require("config.colorscheme")
end
