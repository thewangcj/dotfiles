-- ============================================================
-- 快捷键配置
--
-- mini.clue 会读取每个快捷键的 desc 字段来生成提示面板
-- 所以请确保为每个快捷键设置有意义的 desc 描述
--
-- 快捷键约定：
--   <Leader> + s*  = 窗口/分屏操作
--   <Leader> + q*  = 退出操作
--   <Leader> + t   = 终端操作
--   <Leader> + e   = 文件浏览器
--   <Leader> + b   = 缓冲区操作
--   <Leader> + r   = 最近文件
--   <C-p>          = 查找文件
--   <C-f>          = 全局搜索
-- ============================================================

local map = vim.keymap.set         -- 使用新版 API（支持 Lua 函数作为操作）
local is_vscode = vim.g.is_vscode

-- 辅助函数：创建带描述的快捷键选项
local function opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- ============================================================
-- 窗口管理
-- ============================================================

-- 分屏操作
map("n", "<leader>sv", "<C-w>v", opts("垂直分屏"))
map("n", "<leader>sh", "<C-w>s", opts("水平分屏"))
map("n", "<leader>sc", "<C-w>c", opts("关闭当前窗口"))
map("n", "<leader>so", "<C-w>o", opts("关闭其他窗口"))

-- Alt + hjkl 在窗口间跳转
map("n", "<A-h>", "<C-w>h", opts("跳到左边窗口"))
map("n", "<A-j>", "<C-w>j", opts("跳到下方窗口"))
map("n", "<A-k>", "<C-w>k", opts("跳到上方窗口"))
map("n", "<A-l>", "<C-w>l", opts("跳到右边窗口"))

-- 窗口大小调整
map("n", "<leader>s,", ":vertical resize -20<CR>", opts("减少宽度"))
map("n", "<leader>s.", ":vertical resize +20<CR>", opts("增加宽度"))
map("n", "<leader>sj", ":resize +10<CR>", opts("增加高度"))
map("n", "<leader>sk", ":resize -10<CR>", opts("减少高度"))
map("n", "<leader>s=", "<C-w>=", opts("等宽"))

-- ============================================================
-- 终端
-- ============================================================

map("n", "<leader>t", ":sp | terminal<CR>", opts("打开终端"))
map("n", "<leader>vt", ":vsp | terminal<CR>", opts("垂直分屏打开终端"))
-- 退出终端模式（回到普通模式）
map("t", "<Esc>", "<C-\\><C-n>", opts("退出终端模式"))
-- 终端模式下 Alt + hjkl 跳转窗口
map("t", "<A-h>", "<C-\\><C-N><C-w>h", opts("终端：跳到左边窗口"))
map("t", "<A-j>", "<C-\\><C-N><C-w>j", opts("终端：跳到下方窗口"))
map("t", "<A-k>", "<C-\\><C-N><C-w>k", opts("终端：跳到上方窗口"))
map("t", "<A-l>", "<C-\\><C-N><C-w>l", opts("终端：跳到右边窗口"))

-- ============================================================
-- 可视模式操作
-- ============================================================

-- 缩进后保持选中
map("v", "<", "<gv", opts("向左缩进"))
map("v", ">", ">gv", opts("向右缩进"))
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opts("向下移动选中行"))
map("v", "K", ":move '<-2<CR>gv-gv", opts("向上移动选中行"))
-- 粘贴但不覆盖寄存器内容
map("v", "p", '"_dP', opts("粘贴但不覆盖寄存器"))

-- ============================================================
-- 滚动
-- ============================================================

map("n", "<C-j>", "5j", opts("向下滚动 5 行"))
map("n", "<C-k>", "5k", opts("向上滚动 5 行"))
-- Ctrl+u/d 只移动 10 行（默认是半屏，太远了）
map("n", "<C-u>", "10k", opts("向上滚动 10 行"))
map("n", "<C-d>", "10j", opts("向下滚动 10 行"))

-- ============================================================
-- 退出
-- ============================================================

map("n", "<leader>q", ":q<CR>", opts("退出"))
map("n", "<leader>qq", ":q!<CR>", opts("强制退出"))
map("n", "<leader>Q", ":qa!<CR>", opts("全部退出"))

-- ============================================================
-- 插件快捷键（仅非 VSCode 模式生效）
-- ============================================================

if not is_vscode then
  -- neo-tree：文件目录树
  -- <Leader>e 打开/关闭左侧文件树，并自动定位到当前文件
  map("n", "<leader>e", ":Neotree reveal<CR>", opts("打开文件目录树"))

  -- mini.pick：模糊查找文件（替代 Telescope find_files）
  map("n", "<C-p>", function()
    require("mini.pick").builtin.files()
  end, opts("查找文件"))

  -- mini.pick：全局搜索（替代 Telescope live_grep）
  map("n", "<C-f>", function()
    require("mini.pick").builtin.grep_live()
  end, opts("全局搜索"))

  -- mini.pick：切换缓冲区
  map("n", "<leader>b", function()
    require("mini.pick").builtin.buffers()
  end, opts("切换缓冲区"))

  -- mini.extra：最近打开的文件
  map("n", "<leader>r", function()
    require("mini.extra").pickers.recent_files()
  end, opts("最近文件"))
end

-- ============================================================
-- mini.trailspace：清除行尾空格（所有模式通用）
-- ============================================================
map("n", "<leader>cs", function()
  require("mini.trailspace").trim()
end, opts("清除行尾空格"))
