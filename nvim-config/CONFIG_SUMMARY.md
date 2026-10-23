# Neovim 配置总结文档

## 环境信息

LSP 默认关闭，适用于公司电脑的第三方程序白名单限制。需要启用时，先确认语言服务器已获准运行并安装，再将本机 chezmoi 配置 `[data]` 中的 `enableLsp` 设为 `true`，应用配置并重启 Neovim。

| 项目 | 值 |
|------|-----|
| Neovim 版本 | 0.12+ |
| 操作系统 | Windows 10 |
| 插件管理 | vim.pack（Neovim 0.12 原生） |
| 主要语言 | C++ / Qt / Python |
| VSCode 集成 | 支持（自动检测并适配） |

## 目录结构

```
nvim/
├── init.lua                    -- 入口文件，加载所有模块
├── lua/config/
│   ├── basic.lua               -- 基础选项（编码、搜索、补全等）
│   ├── style.lua               -- 外观样式（行号、状态栏、颜色）
│   ├── tabsize.lua             -- 缩进设置（4 空格，适合 C++/Python）
│   ├── plugins.lua             -- 插件管理（vim.pack 配置）
│   ├── keybindings.lua         -- 快捷键配置
│   ├── autocmds.lua            -- 自动命令
│   └── colorscheme.lua         -- 配色方案
└── CONFIG_SUMMARY.md           -- 本文档
```

## 插件列表

所有插件通过 `vim.pack` 原生管理，无需额外安装插件管理器。

### mini.nvim 插件集合

来自 [nvim-mini/mini.nvim](https://github.com/nvim-mini/mini.nvim)，一个包含 30+ 实用小插件的单仓库。

| 插件 | 功能 | VSCode 模式 | 快捷键 |
|------|------|:-----------:|--------|
| **mini.pairs** | 自动括号配对 | ✓ | 自动生效 |
| **mini.surround** | 包围操作（加/删/改引号、括号等） | ✓ | `sa` `sd` `sr` `sf` |
| **mini.ai** | 增强文本对象（缩进块、函数参数等） | ✓ | `vii` `dia` 等 |
| **mini.comment** | 快速注释 | ✓ | `gcc` `gc` `gbc` |
| **mini.clue** | 快捷键提示面板 | ✗ | 自动弹出（延迟 300ms） |
| **mini.statusline** | 轻量状态栏 | ✗ | 自动生效 |
| **mini.icons** | 文件类型图标 | ✗ | 自动生效 |
| **mini.files** | 文件浏览器（实时预览） | ✗ | `<Leader>e` |
| **mini.pick** | 模糊查找器 | ✗ | `<C-p>` `<C-f>` `<Leader>b` |
| **mini.extra** | 扩展 pickers | ✗ | `<Leader>r` |

### 其他插件

| 插件 | 功能 | VSCode 模式 |
|------|------|:-----------:|
| **nvim-treesitter** | 语法高亮和代码理解 | ✗ |

> VSCode 模式下，编辑增强插件（pairs/surround/ai/comment）仍然可用，
> UI 类插件和 treesitter 跳过，使用 VSCode 自身的能力。

## 快捷键一览

Leader 键 = `空格`

### 窗口管理

| 快捷键 | 功能 |
|--------|------|
| `<Leader>sv` | 垂直分屏 |
| `<Leader>sh` | 水平分屏 |
| `<Leader>sc` | 关闭当前窗口 |
| `<Leader>so` | 关闭其他窗口 |
| `<Alt+h/j/k/l>` | 窗口间跳转 |
| `<Leader>s,` | 减少宽度 |
| `<Leader>s.` | 增加宽度 |
| `<Leader>sj` | 增加高度 |
| `<Leader>sk` | 减少高度 |
| `<Leader>s=` | 等宽 |

### 终端

| 快捷键 | 功能 |
|--------|------|
| `<Leader>t` | 水平分屏打开终端 |
| `<Leader>vt` | 垂直分屏打开终端 |
| `<Esc>` (终端模式) | 退出终端模式 |

### 编辑

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `< / >` | 可视 | 缩进并保持选中 |
| `J / K` | 可视 | 上下移动选中行 |
| `p` | 可视 | 粘贴但不覆盖寄存器 |
| `gcc` | 普通 | 注释/取消注释当前行 |
| `gc` | 可视 | 注释/取消注释选中区域 |

### 滚动

| 快捷键 | 功能 |
|--------|------|
| `<C-j>` | 向下滚动 5 行 |
| `<C-k>` | 向上滚动 5 行 |
| `<C-u>` | 向上滚动 10 行 |
| `<C-d>` | 向下滚动 10 行 |

### 插件

| 快捷键 | 功能 |
|--------|------|
| `<Leader>e` | 打开文件浏览器（mini.files） |
| `<C-p>` | 查找文件（mini.pick） |
| `<C-f>` | 全局搜索（mini.pick grep） |
| `<Leader>b` | 切换缓冲区 |
| `<Leader>r` | 最近文件 |

### 退出

| 快捷键 | 功能 |
|--------|------|
| `<Leader>q` | 退出 |
| `<Leader>qq` | 强制退出 |
| `<Leader>Q` | 全部退出 |

## 插件管理命令

```vim
" 更新所有插件（会显示确认面板，:write 确认，:quit 取消）
:lua vim.pack.update()

" 更新指定插件
:lua vim.pack.update({ 'mini.nvim' })

" 强制更新（跳过确认）
:lua vim.pack.update(nil, { force = true })

" 查看已安装插件状态（离线模式，不下载）
:lua vim.pack.update(nil, { offline = true })

" 删除插件（需先从 plugins.lua 中移除对应配置）
:lua vim.pack.del({ '插件名' })

" 查看未激活的插件（可用于清理）
:lua for _, p in ipairs(vim.pack.get()) do if not p.active then print(p.spec.name) end end
```

## mini.surround 操作速查

| 命令 | 功能 | 示例 |
|------|------|------|
| `sa{motion}{char}` | 添加包围 | `saiw"` → 给单词加双引号 |
| `sd{char}` | 删除包围 | `sd"` → 删除双引号 |
| `sr{old}{new}` | 替换包围 | `sr"'` → 双引号换单引号 |
| `sf{char}` | 找到并包围 | `sf"` → 找到下一个引号 |

## 修复的问题

| # | 问题 | 修复方式 |
|---|------|---------|
| 1 | 无插件管理器，Telescope/neo-tree 快捷键无效 | 使用 vim.pack + mini 插件替代 |
| 2 | colorscheme.lua 从未被加载 | init.lua 中添加 require |
| 3 | shiftwidth 在 basic.lua(2) 和 tabsize.lua(4) 中冲突 | 移除 basic.lua 中的设置，统一在 tabsize.lua 中管理 |
| 4 | timeoutlen 重复设置（100 然后 500） | 只保留最终值 500ms |
| 5 | termguicolors 重复 3 次 | 只保留 1 次 |
| 6 | tabstop 重复设置 | 只保留 1 次 |
| 7 | completeopt 使用 vim.g 而非 vim.opt | 改为 vim.opt |
| 8 | pluginKeys 导出但从未使用 | 改用 mini.files 内置快捷键，移除死代码 |
| 9 | 无 VSCode 环境检测 | 添加 vim.g.vscode 检测，VSCode 下跳过 UI 插件 |
| 10 | 使用旧版 nvim_set_keymap API | 改为 vim.keymap.set（支持 Lua 函数） |
| 11 | pumheight 偏小(5) | 调整为 10 |
| 12 | cmdheight 偏大(2) | 调整为 1（状态栏已由 mini.statusline 提供） |

## Tree-sitter 解析器

Tree-sitter 默认关闭，使用内置语法高亮，不加载解析器管理插件。需要时将本机 chezmoi 配置 `[data]` 中的 `enableTreesitter` 设为 `true`，应用配置并重启，再用 `<Leader>tp` 手动管理解析器。LSP 和 Tree-sitter 均关闭时，符号大纲和符号搜索也不启用。

可按需要安装以下语言的解析器：

- **C/C++**：`c`, `cpp`, `cmake`, `make`
- **Python**：`python`
- **Lua**：`lua`, `luadoc`
- **Neovim**：`vim`, `vimdoc`, `query`
- **数据格式**：`json`, `yaml`, `toml`
- **脚本/标记**：`bash`, `markdown`, `markdown_inline`
- **其他**：`diff`, `regex`, `css`

## 参考链接

- [vim.pack 官方文档](https://neovim.io/doc/user/pack/)
- [vim.pack 使用指南](https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack)
- [Neovim 0.12 更新日志](https://neovim.io/doc/user/news-0.12/)
- [mini.nvim 仓库](https://github.com/nvim-mini/mini.nvim)
- [nvim-treesitter 仓库](https://github.com/nvim-treesitter/nvim-treesitter)

## 必要工具
- tree-sitter-cli（可选）：启用 Tree-sitter 后用于编译解析器，可从 https://github.com/tree-sitter/tree-sitter 下载
- ripgrep: 直接在 https://github.com/BurntSushi/ripgrep 下载即可
- gcc（可选）：编译解析器时需要，Windows 可使用 MinGW
- clangd（可选）：启用 C++ LSP 时需要
- git: 安装插件时需要
- im-select.exe 用于自动切换输入法，直接在 https://github.com/daipeihust/im-select/tree/master/win/out/x64 里下载然后添加到环境变量
