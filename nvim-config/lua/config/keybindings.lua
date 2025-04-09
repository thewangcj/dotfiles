local map = vim.api.nvim_set_keymap

local function make_opts(desc)
    return {
        noremap = true,
        silent = true,
        desc = desc
    }
end
-- which-key 会读取 map 设置的 desc 作为描述信息来生成快捷键帮助
-- 所以这里需要设置 desc 来描述快捷键的功能
-- 例如：map("n", "<leader>w", ":w<CR>", make_opts("保存文件"))

-- 窗口管理快捷键映射
-- windows 分屏快捷键
map("n", "<leader>sv", ":vsp<CR>", make_opts("垂直分屏"))
map("n", "<leader>sh", ":sp<CR>", make_opts("水平分屏"))
-- 关闭当前
map("n", "<leader>sc", "<C-w>c", make_opts("关闭当前"))
-- 关闭其他
map("n", "<leader>so", "<C-w>o", make_opts("关闭其他"))
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", make_opts("移动到左边窗口"))
map("n", "<A-j>", "<C-w>j", make_opts("移动到下边窗口"))
map("n", "<A-k>", "<C-w>k", make_opts("移动到上边窗口"))
map("n", "<A-l>", "<C-w>l", make_opts("移动到右边窗口"))

-- 左右比例控制
map("n", "<leader>s,", ":vertical resize -20<CR>", make_opts("减少宽度"))
map("n", "<leader>s.", ":vertical resize +20<CR>", make_opts("增加宽度"))
-- 上下比例
map("n", "<leader>sj", ":resize +10<CR>", make_opts("增加高度"))
map("n", "<leader>sk", ":resize -10<CR>", make_opts("减少高度"))
-- 等比例
map("n", "<leader>s=", "<C-w>=", make_opts("等宽"))

-- Terminal相关
map("n", "<leader>t", ":sp | terminal<CR>", make_opts("打开终端"))
map("n", "<leader>vt", ":vsp | terminal<CR>", make_opts("在下方新开tab打开终端"))
map("t", "<Esc>", "<C-\\><C-n>", make_opts("退出终端"))
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], make_opts("移动到左边窗口"))
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], make_opts("移动到下边窗口"))
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], make_opts("移动到上边窗口"))
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], make_opts("移动到右边窗口"))

-- visual模式下缩进代码
map("v", "<", "<gv", make_opts("向左缩进"))
map("v", ">", ">gv", make_opts("向右缩进"))
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", make_opts("向下移动选中行"))
map("v", "K", ":move '<-2<CR>gv-gv", make_opts("向上移动选中行"))

-- 上下滚动浏览
map("n", "<C-j>", "5j", make_opts("向下滚动5行"))
map("n", "<C-k>", "5k", make_opts("向上滚动5行"))
-- ctrl u / ctrl + d  只移动10行，默认是移动半屏
map("n", "<C-u>", "10k", make_opts("向上滚动10行"))
map("n", "<C-d>", "10j", make_opts("向下滚动10行"))

-- 在visual 模式里粘贴不要复制
map("v", "p", '"_dP', make_opts("粘贴不复制"))

-- 退出
map("n", "<leader>q", ":q<CR>", make_opts("退出"))
map("n", "<leader>qq", ":q!<CR>", make_opts("强制退出"))
map("n", "<leader>Q", ":qa!<CR>", make_opts("全部退出"))

-- Telescope
-- 查找文件
map("n", "<C-p>", ":Telescope find_files<CR>", make_opts("查找文件"))
-- 全局搜索
map("n", "<C-f>", ":Telescope live_grep<CR>", make_opts("全局搜索"))


local pluginKeys = {}
-- neo-tree.nvim 快捷键, 放到这里方便管理
map("n", "<leader>e", "<Cmd>Neotree reveal<CR>", make_opts("打开当前文件所在文件夹"))

pluginKeys.neoTreeDefaultList = {
    ["<space>"] = {
        "toggle_node",
        nowait = false -- disable `nowait` if you have existing combos starting with this char that you want to use
    },
    ["<2-LeftMouse>"] = "open",
    ["<cr>"] = "open",
    ["<esc>"] = "cancel", -- close preview or floating neo-tree window
    ["P"] = {
        "toggle_preview",
        config = {
            use_float = true,
            use_image_nvim = true
        }
    },
    -- Read `# Preview Mode` for more information
    ["l"] = "focus_preview",
    ["S"] = "open_split",
    ["s"] = "open_vsplit",
    -- ["S"] = "split_with_window_picker",
    -- ["s"] = "vsplit_with_window_picker",
    ["t"] = "open_tabnew",
    -- ["<cr>"] = "open_drop",
    -- ["t"] = "open_tab_drop",
    ["w"] = "open_with_window_picker",
    -- ["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
    ["C"] = "close_node",
    -- ['C'] = 'close_all_subnodes',
    ["z"] = "close_all_nodes",
    -- ["Z"] = "expand_all_nodes",
    ["a"] = {
        "add",
        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
            show_path = "none" -- "none", "relative", "absolute"
        }
    },
    ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
    ["d"] = "delete",
    ["r"] = "rename",
    ["b"] = "rename_basename",
    ["y"] = "copy_to_clipboard",
    ["x"] = "cut_to_clipboard",
    ["p"] = "paste_from_clipboard",
    ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
    -- ["c"] = {
    --  "copy",
    --  config = {
    --    show_path = "none" -- "none", "relative", "absolute"
    --  }
    -- }
    ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
    ["q"] = "close_window",
    ["R"] = "refresh",
    ["?"] = "show_help",
    ["<"] = "prev_source",
    [">"] = "next_source",
    ["i"] = "show_file_details"
    -- ["i"] = {
    --   "show_file_details",
    --   -- format strings of the timestamps shown for date created and last modified (see `:h os.date()`)
    --   -- both options accept a string or a function that takes in the date in seconds and returns a string to display
    --   -- config = {
    --   --   created_format = "%Y-%m-%d %I:%M %p",
    --   --   modified_format = "relative", -- equivalent to the line below
    --   --   modified_format = function(seconds) return require('neo-tree.utils').relative_date(seconds) end
    --   -- }
    -- },
}

pluginKeys.neoTreeFileSystem = {
    ["<bs>"] = "navigate_up",
    ["."] = "set_root",
    ["H"] = "toggle_hidden",
    ["/"] = "fuzzy_finder",
    ["D"] = "fuzzy_finder_directory",
    ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
    -- ["D"] = "fuzzy_sorter_directory",
    ["f"] = "filter_on_submit",
    ["<c-x>"] = "clear_filter",
    ["[g"] = "prev_git_modified",
    ["]g"] = "next_git_modified",
    ["o"] = {
        "show_help",
        nowait = false,
        config = {
            title = "Order by",
            prefix_key = "o"
        }
    },
    ["oc"] = {
        "order_by_created",
        nowait = false
    },
    ["od"] = {
        "order_by_diagnostics",
        nowait = false
    },
    ["og"] = {
        "order_by_git_status",
        nowait = false
    },
    ["om"] = {
        "order_by_modified",
        nowait = false
    },
    ["on"] = {
        "order_by_name",
        nowait = false
    },
    ["os"] = {
        "order_by_size",
        nowait = false
    },
    ["ot"] = {
        "order_by_type",
        nowait = false
    }
    -- ['<key>'] = function(state) ... end,
}

pluginKeys.neoTreeBuffer = {
    ["d"] = "buffer_delete",
    ["bd"] = "buffer_delete",
    ["<bs>"] = "navigate_up",
    ["."] = "set_root",
    ["o"] = {
        "show_help",
        nowait = false,
        config = {
            title = "Order by",
            prefix_key = "o"
        }
    },
    ["oc"] = {
        "order_by_created",
        nowait = false
    },
    ["od"] = {
        "order_by_diagnostics",
        nowait = false
    },
    ["om"] = {
        "order_by_modified",
        nowait = false
    },
    ["on"] = {
        "order_by_name",
        nowait = false
    },
    ["os"] = {
        "order_by_size",
        nowait = false
    },
    ["ot"] = {
        "order_by_type",
        nowait = false
    }
}

return pluginKeys