-- ============================================================
-- UI 增强插件
-- ============================================================

-- mini.clue：快捷键提示面板（类似 which-key）
-- 按下触发键后延迟显示可用的快捷键列表及其描述
local miniclue = require("mini.clue")
miniclue.setup({
  triggers = {
    -- Leader 键触发（显示所有 <Leader> 开头的快捷键）
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },
    -- g 前缀（内置操作，如 gg, gd, gU 等）
    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },
    -- Ctrl+w 前缀（窗口操作）
    { mode = "n", keys = "<C-w>" },
    -- s 前缀（surround 操作）
    { mode = "n", keys = "s" },
    { mode = "x", keys = "s" },
    -- 括号导航（如 [b 上一个 buffer，]d 下一个诊断）
    { mode = "n", keys = "[" },
    { mode = "n", keys = "]" },
    -- z 前缀（折叠和拼写等）
    { mode = "n", keys = "z" },
  },
  window = {
    delay = 300,             -- 按下键后 300ms 显示提示
    config = { width = 40 }, -- 提示窗口宽度
  },
})

-- mini.statusline：轻量状态栏
-- 显示模式、文件名、位置等信息（替代 showmode）
require("mini.statusline").setup({
  use_icons = true,          -- 使用图标（需要 Nerd Font）
})

-- mini.tabline：顶部标签栏（类似 VSCode 的多标签页）
-- 显示所有打开的缓冲区，点击或用快捷键切换
require("mini.tabline").setup({
  show_icons = true,         -- 显示文件类型图标
  tabpage = false,           -- 不显示 Vim 原生 tabpage（只显示 buffer）
})

-- 自定义 tabline：在左侧添加留白，对齐 neo-tree 宽度
-- Neovim 的 tabline 是全局的，跨越整个窗口顶部
-- 当 neo-tree 打开时，在左侧填充等宽空格让标签与编辑区对齐
_G.padded_tabline = function()
  local padding = ""
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "neo-tree" then
      padding = string.rep(" ", vim.api.nvim_win_get_width(win))
      break
    end
  end
  return padding .. MiniTabline.make_tabline_string()
end
vim.o.tabline = "%!v:lua._G.padded_tabline()"

-- mini.icons：文件类型图标（mini 插件内部使用）
require("mini.icons").setup()

-- nvim-web-devicons：文件图标（neo-tree 依赖）
require("nvim-web-devicons").setup({ default = true })
