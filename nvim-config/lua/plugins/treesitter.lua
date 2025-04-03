return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            -- 确保这些语言已经安装
            ensure_installed = {"c", "cpp", "lua", "cmake"},
            -- 启用代码高亮
            highlight = {
                enable = true,
                -- 禁用默认的颜色
                disable = function(lang, buf)
                    return lang == "help" or vim.api.nvim_buf_line_count(buf) > 10000
                end,
                -- 启用额外的Vim语法高亮
                additional_vim_regex_highlighting = false,
            },
            -- 启用增量选择
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>", -- 初始化选择
                    node_incremental = "<CR>", -- 增量选择
                    scope_incremental = "<S-CR>", -- 作用域增量选择
                    node_decremental = "<BS>", -- 减量选择
                },
            },
        })
    end
}
