return {
    "neovim/nvim-lspconfig",
    dependencies = {"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp"},
    config = function()
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")

        -- 设置补全能力
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- 定义 on_attach 回调
        local on_attach = function(_, bufnr)
            local map = function(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, {
                    buffer = bufnr,
                    desc = desc
                })
            end

            -- 跳转和帮助
            map("n", "gd", vim.lsp.buf.definition, "跳转到定义")
            map("n", "gD", vim.lsp.buf.declaration, "跳转到声明")
            map("n", "gi", vim.lsp.buf.implementation, "跳转到实现")
            map("n", "gr", vim.lsp.buf.references, "查看引用")
            map("n", "K", vim.lsp.buf.hover, "悬停文档")
            map("n", "<C-k>", vim.lsp.buf.signature_help, "签名帮助")

            -- 操作
            map("n", "<leader>rn", vim.lsp.buf.rename, "重命名")
            map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")

            -- 诊断
            map("n", "[d", vim.diagnostic.goto_prev, "上一个诊断")
            map("n", "]d", vim.diagnostic.goto_next, "下一个诊断")
            map("n", "<leader>ee", vim.diagnostic.open_float, "诊断浮窗")
        end
        -- mason
        require("mason").setup({})
        -- mason-lspconfig 自动管理
        mason_lspconfig.setup({
            ensure_installed = {"clangd@18.1.3", "lua_ls"},
            automatic_installation = false,
        })

        mason_lspconfig.setup_handlers({function(server)
            lspconfig[server].setup({
                capabilities = capabilities,
                on_attach = on_attach
            })
        end})
    end
}
