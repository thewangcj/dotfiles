-- ============================================================
-- Tree-sitter 解析器管理 - tree-sitter-manager.nvim
--
-- Neovim 0.12 内置 treesitter，但额外语言的解析器需要手动安装
-- 此插件提供 TUI 界面管理解析器的安装/卸载
--
-- 前置要求：
--   tree-sitter CLI（已下载 tree-sitter.exe）
--   git
--   C 编译器（gcc / clang）
--
-- 快捷键：<Leader>tp 打开解析器管理面板
--
-- 管理面板内操作：
--   i    安装解析器
--   u    更新解析器
--   d    卸载解析器
--   q    退出
-- ============================================================

require("tree-sitter-manager").setup()

-- <Leader>tp：打开 tree-sitter 解析器管理面板
vim.keymap.set("n", "<Leader>tp", "<cmd>TSManager<CR>", { desc = "解析器管理" })
