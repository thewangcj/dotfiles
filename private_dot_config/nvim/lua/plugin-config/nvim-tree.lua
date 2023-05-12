local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
    vim.notify("没有找到 nvim-tree")
  return
end

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- nvim_tree.setup({
  --- 上略

  -- project plugin 需要这样设置
  -- update_cwd = true,
  -- update_focused_file = {
    -- enable = true,
    -- update_cwd = true,
  -- },

  -- 下略
-- }
-- empty setup using defaults
require("nvim-tree").setup()
