-- style.lua

-- 样式
vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true
-- 启用真彩色支持
vim.opt.termguicolors = true
-- 不可见字符的显示
vim.o.list = false

-- split window 从下边和右边出现
vim.o.splitbelow = true
vim.o.splitright = true

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
vim.o.cmdheight = 2

-- 永远显示 tabline
vim.o.showtabline = 2
-- 使用增强状态栏插件后不再需要 vim 的模式提示
vim.o.showmode = false
