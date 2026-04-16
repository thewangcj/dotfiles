-- ============================================================
-- 启动页插件
-- ============================================================

-- mini.starter：启动页（打开 nvim 时显示）
-- 显示最近编辑的文件、常用操作快捷入口
require("mini.starter").setup({
  -- 自动打开条件：无文件名参数时显示（即直接运行 nvim 时）
  evaluate_single_item = false,
  -- 启动页各区块
  items = {
    -- 最近使用的文件（最多 8 个）
    require("mini.starter").sections.recent_files(8, false),
    -- 已保存的会话列表（显示最多 5 个）
    require("mini.starter").sections.sessions(5, true),
    -- 书签（可自定义常用目录/文件）
    {
      name = "打开文件浏览器",
      action = "Neotree reveal",
      section = "快捷操作",
    },
    {
      name = "查找文件",
      action = "Telescope find_files",
      section = "快捷操作",
    },
    {
      name = "全局搜索",
      action = "Telescope live_grep",
      section = "快捷操作",
    },
  },
  -- 启动页头部显示的内容
  header = table.concat({
    "  ███╗   ██╗ ███████╗ ██████╗  ██████╗ ██╗     ██╗███╗   ███╗",
    "  ████╗  ██║ ██╔════╝██╔═══██╗██╔═══██╗██║     ██║████╗ ████║",
    "  ██╔██╗ ██║ █████╗  ██║   ██║██║   ██║██║     ██║██╔████╔██║",
    "  ██║╚██╗██║ ██╔══╝  ██║   ██║██║   ██║██║     ██║██║╚██╔╝██║",
    "  ██║ ╚████║ ███████╗╚██████╔╝╚██████╔╝███████╗██║██║ ╚═╝ ██║",
    "  ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝  ╚═════╝ ╚══════╝╚═╝╚═╝     ╚═╝",
    "",
    "  Neovim + C++ / Qt / Python",
  }, "\n"),
  -- 底部显示的信息
  footer = "",
  -- 按字母键即可触发对应操作
  content_hooks = {
    -- 在项目名称旁添加编号
    require("mini.starter").gen_hook.adding_bullet(),
    -- 按索引编号
    require("mini.starter").gen_hook.indexing("all", { "快捷操作" }),
  },
})
