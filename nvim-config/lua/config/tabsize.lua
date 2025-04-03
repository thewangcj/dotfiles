-- tabsize.lua

vim.o.tabstop = 4		-- 1个 Tab 显示为 4 个空格
vim.bo.tabstop = 4
vim.o.softtabstop = 4 	-- 退格键删除 Tab 时按 4 个空格处理
vim.o.shiftround = true

-- 禁止展开 tab
vim.o.expandtab = false
vim.bo.expandtab = false