-- ============================================================
-- 配色方案
--
-- 当前使用 Neovim 内置深色主题 habamax（无需安装额外插件）
-- 如需使用其他主题，可先通过 vim.pack.add 安装，再切换：
--   例如安装 kanagawa：
--   vim.pack.add({ 'https://github.com/rebelot/kanagawa.nvim' })
--   然后把下方 colorscheme 改为 'kanagawa'
-- ============================================================

-- 按优先级尝试加载配色方案，使用第一个成功的
local colorschemes = { "habamax", "default" }
for _, scheme in ipairs(colorschemes) do
  local ok = pcall(vim.cmd.colorscheme, scheme)
  if ok then
    break
  end
end
