-- ============================================================
-- LSP 配置 - 使用 Neovim 0.12 原生 vim.lsp API
--
-- 通过 init.lua 中的 vim.g.enable_lsp 开关控制
-- 需要系统已安装对应语言服务器：
--   C++/Qt：clangd（https://clangd.llvm.org/）
--   Python：pyright（npm install -g pyright）
--
-- 快捷键：
--   gd          跳转到定义
--   gD          跳转到类型定义
--   gr          查找所有引用
--   gi          跳转到实现
--   K           显示悬停文档
--   <Leader>rn  重命名符号
--   <Leader>ca  代码操作
--   <Leader>e   显示行诊断
--   [d          上一个诊断
--   ]d          下一个诊断
-- ============================================================

-- LSP 快捷键：仅在 LSP 服务器附加到缓冲区时生效
local function on_attach(client, bufnr)
  local function map(keys, cmd, desc)
    vim.keymap.set("n", keys, cmd, { buffer = bufnr, desc = desc })
  end

  map("gd", vim.lsp.buf.definition, "跳转到定义")
  map("gD", vim.lsp.buf.type_definition, "跳转到类型定义")
  map("gr", vim.lsp.buf.references, "查找所有引用")
  map("gi", vim.lsp.buf.implementation, "跳转到实现")
  map("K", vim.lsp.buf.hover, "显示悬停文档")
  map("<Leader>rn", vim.lsp.buf.rename, "重命名符号")
  map("<Leader>ca", vim.lsp.buf.code_action, "代码操作")
  map("<Leader>e", vim.diagnostic.open_float, "显示行诊断")
  map("[d", vim.diagnostic.goto_prev, "上一个诊断")
  map("]d", vim.diagnostic.goto_next, "下一个诊断")
end

-- ============================================================
-- 使用 vim.lsp.config 配置语言服务器（Neovim 0.11+ 原生 API）
-- ============================================================

-- clangd：C / C++ / Qt
-- CMake 项目加 -DCMAKE_EXPORT_COMPILE_COMMANDS=ON 生成编译数据库，
-- clangd 会自动识别。也可在项目根目录放 .clangd 配置文件。
vim.lsp.config("clangd", {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { ".clangd", "compile_commands.json", ".git" },
  on_attach = on_attach,
  -- Qt 头文件路径（根据实际安装位置调整）：
  -- 如果 Qt 通过 MSYS2 安装：
  --   C:/msys64/mingw64/include/qt6
  -- 如果通过 Qt Installer 安装：
  --   C:/Qt/6.x.x/mingw_64/include
  -- 取消下面注释并填写正确路径即可：
  -- cmd = {
  --   "clangd",
  --   "--header-insertion=never",
  --   "--query-driver=C:/msys64/mingw64/bin/g++.exe",
  -- },
})

-- pyright：Python
vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
  on_attach = on_attach,
})

-- 启用语言服务器
vim.lsp.enable("clangd")
vim.lsp.enable("pyright")

-- ============================================================
-- 诊断显示样式
-- ============================================================
vim.diagnostic.config({
  -- 使用虚拟文本显示诊断（行尾浮动提示）
  virtual_text = {
    spacing = 4,
    prefix = "●",
  },
  float = {
    border = "rounded",
  },
  -- 诊断排序：错误优先
  severity_sort = true,
})

-- 悬停文档窗口样式
vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
  config = config or {}
  config.border = "rounded"
  return vim.lsp.handlers.hover(err, result, ctx, config)
end

-- 签名帮助窗口样式
vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
  config = config or {}
  config.border = "rounded"
  return vim.lsp.handlers.signature_help(err, result, ctx, config)
end
