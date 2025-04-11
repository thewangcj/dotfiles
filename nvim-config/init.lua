vim.g.mapleader = " "       -- 全局 Leader 键（默认为 \）
vim.g.maplocalleader = " "  -- 本地 Leader 键（默认为 \）

require("config.basic")
require("config.style")
require("config.tabsize")
require("config.lazy")
require("config.keybindings")
require("config.colorscheme")
require("config.autocmds")