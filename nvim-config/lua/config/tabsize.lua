-- ============================================================
-- 缩进宽度设置
-- 主要为 C++ 和 Python 设计，统一使用 4 空格缩进
-- 注意：此处设置的 shiftwidth 会覆盖 basic.lua 中的值
-- ============================================================

vim.opt.tabstop = 4         -- 1 个 Tab 显示为 4 个空格宽度
vim.opt.softtabstop = 4     -- 退格键删除 Tab 时按 4 个空格处理
vim.opt.shiftwidth = 4      -- 自动缩进步长为 4 个空格
vim.opt.shiftround = true   -- 缩进取整到 shiftwidth 的倍数
vim.opt.expandtab = true    -- 将 Tab 转换为空格（Python 必需）
