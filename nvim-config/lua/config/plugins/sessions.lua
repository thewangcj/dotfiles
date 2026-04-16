-- ============================================================
-- 会话管理 - mini.sessions
--
-- 保存/恢复 Neovim 的工作区状态（窗口布局、打开的文件等）
--
-- 快捷键：
--   <Leader>ss   保存会话
--   <Leader>sl   加载会话
--   <Leader>sd   删除会话
--
-- 会话文件保存在：stdpath("data")/session/
-- ============================================================

local sessions_dir = vim.fn.stdpath("data") .. "/session"
-- 确保会话目录存在
vim.fn.mkdir(sessions_dir, "p")

require("mini.sessions").setup({
  -- 会话文件存储目录
  directory = sessions_dir,
  -- 自动读取当前目录的会话（如果存在）
  autoread = false,
  -- 自动写入会话（退出时自动保存）
  autowrite = false,
  -- 会话中忽略的数据
  hooks = {
    -- 保存前执行：关闭 neo-tree 和终端，避免恢复时报错
    pre = {
      function()
        pcall(vim.cmd, "Neotree close")
        -- 关闭所有终端缓冲区
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.bo[buf].buftype == "terminal" then
            pcall(vim.api.nvim_buf_delete, buf, { force = true })
          end
        end
      end,
    },
  },
})

-- <Leader>ss：保存当前会话
vim.keymap.set("n", "<Leader>ss", function()
  -- 用当前目录名作为会话名
  local name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  MiniSessions.write(name)
  vim.notify("会话已保存: " .. name)
end, { desc = "保存会话" })

-- <Leader>sl：加载会话
vim.keymap.set("n", "<Leader>sl", function()
  MiniSessions.select("read")
end, { desc = "加载会话" })

-- <Leader>sd：删除会话
vim.keymap.set("n", "<Leader>sd", function()
  MiniSessions.select("delete")
end, { desc = "删除会话" })
