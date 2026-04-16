-- ============================================================
-- 插件管理入口 - 使用 Neovim 0.12 原生 vim.pack
--
-- 常用操作：
--   安装插件：首次启动自动提示，按 y 确认
--   更新插件：:lua vim.pack.update()
--   删除插件：先移除配置，再 :lua vim.pack.del({ '插件名' })
--   查看状态：:lua vim.pack.update(nil, { offline = true })
-- ============================================================

local is_vscode = vim.g.is_vscode

-- ============================================================
-- VSCode 模式：仅加载编辑增强插件
-- ============================================================
if is_vscode then
  vim.pack.add({
    "https://github.com/nvim-mini/mini.nvim",
  })
  require("config.plugins.editing")
  return
end

-- ============================================================
-- 完整模式：加载所有插件
-- ============================================================
vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lua/plenary.nvim",    -- neo-tree 依赖
  "https://github.com/MunifTanjim/nui.nvim",     -- neo-tree 依赖
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/stevearc/aerial.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/catppuccin/nvim",
  "https://github.com/rose-pine/neovim",
  "https://github.com/shaunsingh/nord.nvim",
  "https://github.com/romus204/tree-sitter-manager.nvim",
})

-- 按功能模块加载配置
require("config.plugins.editing")
require("config.plugins.ui")
require("config.plugins.files")
require("config.plugins.git")
require("config.plugins.symbols")
require("config.plugins.formatting")
require("config.plugins.treesitter")
require("config.plugins.sessions")
require("config.plugins.starter")
