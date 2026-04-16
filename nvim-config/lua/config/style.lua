-- ============================================================
-- 外观样式设置
-- ============================================================

vim.opt.background = "dark"       -- 深色背景
vim.opt.list = false              -- 不显示不可见字符

-- 分屏行为：新窗口出现在下方和右方
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.cmdheight = 1             -- 命令行高度

-- 以下设置由 VSCode 自身管理，VSCode 模式下跳过
if not vim.g.is_vscode then
  vim.opt.termguicolors = true      -- 启用真彩色支持
  vim.wo.number = true              -- 显示行号
  vim.wo.relativenumber = true      -- 相对行号（方便跳转）
  vim.wo.cursorline = true          -- 高亮当前行
  vim.wo.signcolumn = "yes"         -- 始终显示符号列（避免抖动）
  vim.wo.colorcolumn = "120"        -- 第 120 列参考线
  vim.opt.showtabline = 2           -- 始终显示标签页栏
  vim.opt.showmode = false          -- 不显示模式（由状态栏插件显示）
end
