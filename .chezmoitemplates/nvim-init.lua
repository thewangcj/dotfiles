-- 本机开关由 chezmoi 配置中的数据生成，未设置时默认关闭。
vim.g.enable_lsp = {{ if (get . "enableLsp") }}true{{ else }}false{{ end }}
vim.g.enable_treesitter = {{ if (get . "enableTreesitter") }}true{{ else }}false{{ end }}
-- 本机 Git Bash 路径；空字符串表示未指定。
vim.g.nvim_bash = {{ get . "nvimBash" | default "" | quote }}

{{ include (joinPath .chezmoi.sourceDir "nvim-config/init.lua") }}
