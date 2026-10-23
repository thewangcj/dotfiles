-- ============================================================
-- 符号大纲 - aerial.nvim
--
-- 仅使用已开启的 LSP 或 Tree-sitter 后端解析符号。
--
-- 快捷键：
--   <Leader>a   打开/关闭符号大纲侧边栏
--   <Leader>o   Telescope 模糊搜索符号（跳转到定义）
--
-- 大纲窗口内操作：
--   Enter    跳转到该符号
--   q        关闭大纲窗口
--   <C-v>    垂直分屏跳转
-- ============================================================

local backends = {}
if vim.g.enable_lsp then table.insert(backends, "lsp") end
if vim.g.enable_treesitter then table.insert(backends, "treesitter") end
if #backends == 0 then return end

require("aerial").setup({
  -- 后端优先级：LSP > Tree-sitter，关闭的后端不会启用。
  backends = backends,

  -- 大纲侧边栏配置
  float = {
    relative = "win",
    border = "rounded",
  },

  -- 导航窗口配置
  nav = {
    border = "rounded",
    max_height = 0.6,
    min_height = { 10, 0.1 },
    keys = {
      ["<CR>"] = "actions.jump",
      ["<C-v>"] = "actions.jump_vsplit",
      ["q"] = "actions.close",
    },
  },

  -- 大纲窗口内快捷键
  on_attach = function(bufnr)
    local map = function(keys, cmd, desc)
      vim.keymap.set("n", keys, cmd, { buffer = bufnr, desc = desc })
    end
    map("q", "<cmd>AerialToggle<CR>", "关闭大纲")
  end,
})

-- <Leader>a：打开/关闭符号大纲侧边栏
vim.keymap.set("n", "<Leader>a", "<cmd>AerialToggle right<CR>", { desc = "符号大纲" })

-- <Leader>o：使用 Telescope aerial 扩展模糊搜索符号
vim.keymap.set("n", "<Leader>o", "<cmd>Telescope aerial<CR>", { desc = "搜索符号" })
