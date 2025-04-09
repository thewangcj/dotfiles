return {
    "hrsh7th/nvim-cmp",
    dependencies = {"hrsh7th/cmp-nvim-lsp", -- 连接 LSP 与补全系统
    "hrsh7th/cmp-buffer", -- 来自当前 buffer 的补全
    "hrsh7th/cmp-path", -- 文件路径补全
    "L3MON4D3/LuaSnip" -- 可选：代码片段支持
    },
    config = function()
        local cmp = require("cmp")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- 使用 LuaSnip 作为 snippet 引擎
                end
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({
                    select = true
                }),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item()
            }),
            sources = cmp.config.sources({{
                name = "nvim_lsp"
            }, -- 来自 LSP 的补全
            {
                name = "luasnip"
            }, -- 来自 snippet 的补全
            {
                name = "buffer"
            }, -- 当前 buffer 词语
            {
                name = "path"
            } -- 文件路径
            })
        })
    end
}
