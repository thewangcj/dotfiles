-- ============================================================
-- Tree-sitter 语法高亮
-- 提供精确的语法高亮，比正则匹配更准确
-- 注意：VSCode 模式下不加载，使用 VSCode 自身的高亮
-- ============================================================

local ok, ts_config = pcall(require, "nvim-treesitter.configs")
if not ok then return end

ts_config.setup({
  -- 自动安装以下语言的解析器
  ensure_installed = {
    -- C/C++ 和构建工具（C++ / Qt 开发必需）
    "c", "cpp", "cmake", "make",
    -- Python
    "python",
    -- Lua（Neovim 配置用）
    "lua", "luadoc",
    -- Neovim 相关
    "vim", "vimdoc", "query",
    -- 数据格式
    "json", "yaml", "toml",
    -- 脚本和标记语言
    "bash", "markdown", "markdown_inline",
    -- 其他实用语言
    "diff", "regex", "css",
  },
  highlight = {
    enable = true,          -- 启用基于 Tree-sitter 的语法高亮
  },
  indent = {
    enable = true,          -- 启用基于 Tree-sitter 的智能缩进
  },
})
