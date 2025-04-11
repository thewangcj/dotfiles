-- style.lua

-- 样式
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.termguicolors = true
-- 启用真彩色支持
vim.opt.termguicolors = true
-- 不可见字符的显示
vim.opt.list = false

-- split window 从下边和右边出现
vim.opt.splitbelow = true
vim.opt.splitright = true

-- 使用相对行号
vim.wo.number = true
vim.wo.relativenumber = true
-- 高亮所在行
vim.wo.cursorline = true
-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"
-- 右侧参考线，超过表示代码太长了，考虑换行
vim.wo.colorcolumn = "120"
-- 命令行高为2，提供足够的显示空间
vim.opt.cmdheight = 2

-- 永远显示 tabline
vim.opt.showtabline = 2
-- 使用增强状态栏插件后不再需要 vim 的模式提示
vim.opt.showmode = false
