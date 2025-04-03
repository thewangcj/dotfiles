-- ================ 保留原始 map 调用（确保功能生效） ================
local map = vim.api.nvim_set_keymap
local opt = {
    noremap = true,
    silent = true
}

-- 窗口管理快捷键映射
-- 取消 s 默认功能
map("n", "s", "", opt)
-- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- 关闭当前
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt)
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)

-- 左右比例控制
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
map("n", "s,", ":vertical resize -20<CR>", opt)
map("n", "s.", ":vertical resize +20<CR>", opt)
-- 上下比例
map("n", "sj", ":resize +10<CR>", opt)
map("n", "sk", ":resize -10<CR>", opt)
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
-- 等比例
map("n", "s=", "<C-w>=", opt)

-- Terminal相关
map("n", "<leader>t", ":sp | terminal<CR>", opt)
map("n", "<leader>vt", ":vsp | terminal<CR>", opt)
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 上下滚动浏览
map("n", "<C-j>", "5j", opt)
map("n", "<C-k>", "5k", opt)
-- ctrl u / ctrl + d  只移动10行，默认是移动半屏
map("n", "<C-u>", "10k", opt)
map("n", "<C-d>", "10j", opt)

-- 在visual 模式里粘贴不要复制
map("v", "p", '"_dP', opt)

-- 退出
map("n", "<leader>q", ":q<CR>", opt)
map("n", "<leader>qq", ":q!<CR>", opt)
map("n", "<leader>Q", ":qa!<CR>", opt)

-- ================ 配置 which-key ================
local wk = require("which-key")

wk.add({
    { "<leader>t", "<cmd>sp | terminal<cr>", desc = "打开终端" },
    { "<leader>vt", "<cmd>vsp | terminal<cr>", desc = "在下方新开tab打开终端" },

    { "s", group = "Split/Resize" },
    { "sv", "<cmd>vsp<cr>", desc = "垂直分屏" },
    { "sh", "<cmd>sp<cr>", desc = "水平分屏" },
    { "sc", "<C-w>c", desc = "关闭窗口" },
    { "so", "<C-w>o", desc = "关闭其他窗口" },
    { "s,", "<cmd>vertical resize -20<cr>", desc = "减少宽度" },
    { "s.", "<cmd>vertical resize +20<cr>", desc = "增加宽度" },
    { "sj", "<cmd>resize +10<cr>", desc = "增加宽度" },
    { "sk", "<cmd>resize -10<cr>", desc = "减少宽度" },
    { "s=", "<C-w>=", desc = "等宽" },

	{ "<leader>q", "<cmd>q<cr>", desc = "退出" },
	{ "<leader>qq", "<cmd>q!<cr>", desc = "强制退出" },
	{ "<leader>Q", "<cmd>qa!<cr>", desc = "全部退出" },

    { "<C-Left>", "<cmd>vertical resize -2<cr>", desc = "减少宽度" },
    { "<C-Right>", "<cmd>vertical resize +2<cr>", desc = "增加宽度" },
    { "<C-Down>", "<cmd>resize +2<cr>", desc = "增加宽度" },
    { "<C-Up>", "<cmd>resize -2<cr>", desc = "减少宽度" },

    { "<C-j>", "5j", desc = "光标向下移动五行" },
    { "<C-k>", "5k", desc = "光标向上移动五行" },
    { "<C-u>", "10k", desc = "页面向上移动10行" },
    { "<C-d>", "10j", desc = "页面向下移动10行" },

    {
        mode = "t", -- Terminal mode mappings
        { "<Esc>", "<C-\\><C-n>", desc = "退出terminal" },
        { "<A-h>", "<C-\\><C-N><C-w>h", desc = "向左移动" },
        { "<A-j>", "<C-\\><C-N><C-w>j", desc = "向下移动" },
        { "<A-k>", "<C-\\><C-N><C-w>k", desc = "向上移动" },
        { "<A-l>", "<C-\\><C-N><C-w>l", desc = "向右移动" },
    },

    {
        mode = "v", -- Visual mode mappings
        { "<", "<gv", desc = "向左缩进" },
        { ">", ">gv", desc = "向右缩进" },
        { "p", '"_dP', desc = "Paste Without Copy" },
        { "J", "<cmd>move '>+1<CR>gv-gv<cr>", desc = "向下移动选中行" },
        { "K", "<cmd>move '<-2<CR>gv-gv<cr>", desc = "向上移动选中行" },
    }
})
