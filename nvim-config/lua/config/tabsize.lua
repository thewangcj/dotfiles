-- tabsize.lua

-- 缩进2个空格等于一个 tab
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftround = true

-- 禁止展开 tab
vim.o.expandtab = false
vim.bo.expandtab = false