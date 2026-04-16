-- ============================================================
-- 代码格式化 - conform.nvim
--
-- 支持的格式化工具（需要单独安装）：
--   C/C++：clang-format（随 LLVM/Clang 安装，Qt 开发通常已有）
--   Python：black（pip install black）
--   Lua：stylua（cargo install stylua 或 scoop install stylua）
--
-- 常用操作：
--   <Leader>f   格式化当前文件 / 选中区域
-- ============================================================

local ok, conform = pcall(require, "conform")
if not ok then return end

conform.setup({
  -- 各语言对应的格式化工具
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
    python = { "black" },
    lua = { "stylua" },
  },
  -- 不自动格式化（按 <Leader>f 手动触发）
  format_on_save = false,
})

-- 快捷键：<Leader>f 格式化当前文件（可视模式下格式化选中区域）
vim.keymap.set({ "n", "v" }, "<Leader>f", function()
  conform.format({ lsp_fallback = true })
end, { desc = "格式化代码" })
