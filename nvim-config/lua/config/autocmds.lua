-- ============================================================
-- 自动命令（Autocmds）
-- ============================================================

-- 打开文件时自动跳转到上次光标所在位置
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')  -- 上次退出时的光标位置
    local lcount = vim.api.nvim_buf_line_count(0)    -- 文件总行数
    -- 只有当标记位置在有效范围内才跳转
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
