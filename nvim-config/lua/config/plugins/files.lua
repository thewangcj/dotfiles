-- ============================================================
-- 文件管理插件
-- ============================================================

-- neo-tree：文件目录树（类似 VSCode 左侧文件浏览器）
-- 常驻左侧栏，支持 git 状态标记、文件过滤、文件操作
require("neo-tree").setup({
  -- 关闭后自动跳回最后一个窗口
  close_if_last_window = true,
  -- 顶部显示 source 标签（文件/缓冲区/git）
  source_selector = {
    winbar = true,
    sources = {
      { source = "filesystem", display_name = "  文件  " },
      { source = "buffers",    display_name = "  缓冲区" },
      { source = "git_status", display_name = "  Git  " },
    },
  },
  window = {
    width = 30,             -- 侧栏宽度
    mappings = {
      ["<space>"] = "toggle_node",   -- 展开/折叠
      ["<cr>"]    = "open",          -- 打开文件/目录
      ["l"]       = "open",          -- 打开（类似 VSCode 点击）
      ["h"]       = "close_node",    -- 折叠目录
      ["a"]       = { "add", config = { show_path = "relative" } }, -- 新建
      ["d"]       = "delete",        -- 删除
      ["r"]       = "rename",        -- 重命名
      ["y"]       = "copy_to_clipboard",    -- 复制
      ["x"]       = "cut_to_clipboard",     -- 剪切
      ["p"]       = "paste_from_clipboard", -- 粘贴
      ["q"]       = "close_window",  -- 关闭文件树
      ["R"]       = "refresh",       -- 刷新
      ["H"]       = "toggle_hidden", -- 显示/隐藏隐藏文件
      ["/"]       = "fuzzy_finder",  -- 模糊搜索文件名
      ["<bs>"]    = "navigate_up",   -- 返回上级目录
    },
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,       -- 显示 .开头的文件
      hide_gitignored = false,     -- 显示 .gitignore 中的文件
    },
    follow_current_file = {
      enabled = true,              -- 自动定位到当前文件
    },
    window = {
      mappings = {
        ["."] = "set_root",        -- 将当前目录设为根目录
      },
    },
  },
})

-- mini.pick：模糊查找器（类似 Telescope / fzf）
-- 内置多种查找器：文件、grep、buffer、帮助标签等
require("mini.pick").setup()

-- mini.extra：扩展功能模块
-- 提供额外的 pickers 和工具（如最近文件、命令历史等）
require("mini.extra").setup()
