-- basic.lua

----------------------------------------------------------------------
-- 编码设置
----------------------------------------------------------------------
-- utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = 'utf-8'
-- 打开文件时自动尝试下面顺序的编码
vim.o.fileencodings = "ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1"

----------------------------------------------------------------------
-- 基础设置
----------------------------------------------------------------------
-- 自动缩进：新行对齐当前行
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
-- 打开 C/C++ 语言缩进优化
vim.o.cindent = true
-- Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
vim.o.winaltkeys = "no"
-- 关闭自动换行
vim.o.wrap = false
-- 打开功能键超时检测（终端下功能键为一串 ESC 开头的字符串）
vim.o.ttimeout = true
-- 设置 timeoutlen 为等待键盘快捷键连击时间100毫秒
vim.o.timeoutlen = 100
-- 显示光标位置
vim.o.ruler = true

----------------------------------------------------------------------
-- 搜索设置
----------------------------------------------------------------------
-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 高亮搜索内容
vim.o.hlsearch = true
-- 边输入边搜索
vim.o.incsearch = true

----------------------------------------------------------------------
-- 备份设置
----------------------------------------------------------------------
-- 禁止创建备份文件
vim.o.backup = true
vim.o.writebackup = true
vim.o.swapfile = false
-- smaller updatetime
vim.o.updatetime = 300
-- 禁用 undo文件
vim.o.undofile = false

----------------------------------------------------------------------
-- 其他设置
----------------------------------------------------------------------
-- jkhl 移动时光标周围保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- >> << 时移动长度
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2

-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true
-- 禁止折行
vim.wo.wrap = false
-- 光标在行首尾时<Left><Right>可以跳到下一行
vim.o.whichwrap = '<,>,[,]'
-- 允许隐藏被修改过的buffer
vim.o.hidden = true
-- 鼠标支持
vim.o.mouse = "a"

----------------------------------------------------------------------
-- 补全设置
----------------------------------------------------------------------
-- 自动补全不自动选中
vim.g.completeopt = "menu,menuone,noselect,noinsert"
-- 补全增强
vim.o.wildmenu = true
-- Dont' pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. 'c'
-- 补全最多显示5行
vim.o.pumheight = 5

-- python provider
vim.g.python3_host_prog = 'C:/Users/changjiewang/tools/nvim-win64/.venv/Scripts/python.exe'
