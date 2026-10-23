# dotfiles：Windows / WSL2 / macOS

Git/GitHub 保存配置历史；chezmoi 按机器生成配置并部署到用户目录。插件、语言服务器、编译器和字体仍在每台机器单独安装。

## 目录和部署位置

配置仍在 `nvim-config/`、`vim-config/`、`zsh-config/` 中编辑。`dot_config/`、`AppData/`、`dot_vim/` 及根目录的 `.tmpl` 是部署映射：通过 `include` 原样读取配置，没有复制配置内容。`.chezmoiignore` 根据操作系统选择目标。

| 配置源 | Windows | WSL2 / macOS |
| --- | --- | --- |
| `nvim-config/` | `~/AppData/Local/nvim/` | `~/.config/nvim/` |
| `vim-config/`（运行文件） | `~/.vim/` | `~/.vim/` |
| `vim-config/.vimrc` | `~/_vimrc` | `~/.vimrc` |
| `zsh-config/.zshrc` | 跳过 | `~/.zshrc` |
| `empty_dot_tmux.conf` | 跳过 | `~/.tmux.conf` |
| `_vsvimrc` | `~/_vsvimrc` | 跳过 |

采用默认的用户目录布局。Windows 若重定向过 LOCALAPPDATA，或设置了 XDG_CONFIG_HOME / NVIM_APPNAME，请先在 Neovim 中执行 `:echo stdpath('config')`，再调整部署映射。Vim 在 Windows 也使用 `.vim` 存放运行文件，`_vimrc` 显式加载它，不依赖 `vimfiles`。

映射不是符号链接，不需要 Windows 开发者模式。未使用 `exact_`，不会清空目标目录中的其他文件。删除源文件后，旧的已部署文件可能仍需手动清理。

## 首次使用当前仓库

先安装 chezmoi：Windows 可用 `winget install --id twpayne.chezmoi --exact`；macOS 可用 `brew install chezmoi`；WSL2 按 [官方安装说明](https://www.chezmoi.io/install/) 安装 Linux 版本。

公司 Windows 笔记本有可执行文件白名单要求时，将下载的 `chezmoi.exe` 改名为 `FSLighting-chezmoi.exe`，放入 PATH，并把下文所有 `chezmoi` 命令替换为 `FSLighting-chezmoi`。当前验证使用的程序位于 `.tmp-chezmoi/bin/FSLighting-chezmoi.exe`，未安装到系统目录，也不提交到 Git。此规则只适用于这台公司的 Windows 环境。

先备份现有配置，包括上表中的目标目录。如果原来用 `ln -s` 建立了配置链接，先备份后移除那些链接，避免部署继续写入旧仓库。

在当前仓库根目录运行（PowerShell、bash、zsh 都适用）：

```sh
chezmoi init --source .
chezmoi managed
chezmoi diff
chezmoi apply --dry-run --verbose
chezmoi apply
```

`init --source .` 将当前目录设为这台机器的 sourceDir；后续不必反复指定。先检查 diff，再 apply。此仓库没有自动安装软件或修改系统设置的运行脚本。

## 新机器

先把本次改动提交并推送到 GitHub，再在每台机器执行：

```sh
chezmoi init https://github.com/thewangcj/dotfiles.git
chezmoi diff
chezmoi apply
```

私有仓库需要先配置 GitHub 认证，也可以使用 SSH URL。Windows 和 WSL2 分别初始化，各自拥有一个克隆；WSL2 建议将仓库存放在 Linux 的 home 中。不要让两套 Neovim 共用插件目录，Windows 的二进制插件和 Linux 的二进制插件不能混用。

## 安装编辑器依赖

### 每台机器单独设置功能开关

仓库默认关闭 LSP 和 Tree-sitter。执行 `chezmoi edit-config`，在本机 `~/.config/chezmoi/chezmoi.toml` 的 `[data]` 中设置开关，例如仅开启 Tree-sitter：

```toml
[data]
enableLsp = false
enableTreesitter = true
```

保留已有的 `sourceDir` 和其他设置；若已有 `[data]`，在该节中添加或修改字段，不要重复创建。公司电脑使用 `FSLighting-chezmoi.exe edit-config`。

然后执行 `chezmoi diff`、`chezmoi apply` 并重启 Neovim。chezmoi 会按本机数据生成入口配置，仓库默认值仍然为 `false`。本机配置不提交到 Git，重新执行 `init` 时会保留这两个开关。不要直接修改部署后的 `init.lua`，后续 `apply` 会重新生成它。

### 工具依赖

- **Neovim 0.12+**：现有配置使用 `vim.pack`；各平台先用 `nvim --version` 确认版本。包管理器版本不足时需安装满足要求的版本。
- **Git、ripgrep**：用于下载插件和 Telescope 搜索。
- **Tree-sitter CLI、C 编译器（可选）**：Tree-sitter 默认关闭，保留内置语法高亮。需要时将本机 chezmoi 配置 `[data]` 中的 `enableTreesitter` 设为 `true`，应用配置并重启 Neovim，再用 `<Leader>tp` 管理解析器。编译解析器时需要 CLI 和 C 编译器：Windows 可用 LLVM 或 MinGW，macOS 可安装 Xcode Command Line Tools，WSL2 可安装 build-essential。LSP 和 Tree-sitter 均关闭时，符号大纲及其搜索快捷键也不启用。
- **clangd、pyright-langserver（可选）**：分别用于 C/C++ 和 Python。LSP 默认关闭，无需安装语言服务器；确认工具已获准运行并安装到 PATH 后，将本机 chezmoi 配置 `[data]` 中的 `enableLsp` 设为 `true`，应用配置并重启 Neovim。Qt 的编译数据库、工具链路径放在项目的 CMake / `.clangd` 中。
- **clang-format、black、stylua**：对应 C/C++、Python、Lua 格式化，按需要安装。
- **Nerd Font**：在 Windows Terminal、macOS 终端或 GUI 编辑器中选择，供图标显示。
- **输入法（可选）**：Windows / WSL2 使用 PATH 中的 `im-select.exe`；macOS 使用 `macism`；普通 Linux 使用 fcitx5、fcitx 或 ibus。工具不存在时自动跳过。WSL2 需要启用 Windows 互操作并能找到该 exe。
- **Vim**：首次打开后执行 `:PlugInstall`。Neovim 首次启动按提示安装插件；完成后执行 `:checkhealth` 检查当前机器依赖。
- **zsh（可选）**：另行安装 Oh My Zsh 和所需额外插件。不存在的插件会跳过；没有 Oh My Zsh 时仍加载其余 shell 设置。

Windows 默认沿用 Neovim 自身的 shell。需要 Git Bash 时，在本机 chezmoi 配置现有的 `[data]` 中添加 bash.exe 的完整路径：

```toml
nvimBash = 'C:\Program Files\Git\bin\bash.exe'
```

使用单引号可避免 TOML 中的反斜杠转义。执行 `chezmoi apply` 并重启 Neovim 后生效；该路径只保存在本机，重新初始化时会保留。默认值为空字符串。路径未设置时也支持读取 `NVIM_BASH` 环境变量，例如 PowerShell：

```powershell
$env:NVIM_BASH = 'C:\Program Files\Git\bin\bash.exe'
```

zsh 不再覆盖 DISPLAY，保留 WSLg 自动设置。旧版 WSL X Server、代理地址等机器专属设置放入 `~/.zshrc.local`，这个文件不纳入仓库。

## 日常修改和跨机器同步

本仓库用了 include 映射，请直接编辑原始配置目录；`chezmoi edit` 会打开映射模板，不适合编辑这里的完整配置。也不要直接对整个目标目录执行 `chezmoi add` / `re-add`，否则可能把映射替换成当前机器的独立副本。

```sh
chezmoi cd
# 编辑 nvim-config/、vim-config/ 或 zsh-config/ 中的配置
chezmoi diff
chezmoi apply
# 实际运行编辑器验证，再提交
git add .
git commit -m "Update editor configuration"
git push
```

其他机器运行 `chezmoi update`，它会拉取 Git 更新并部署。需要先审阅时：`chezmoi git pull -- --ff-only`，然后 `chezmoi diff`、`chezmoi apply`。推送前先处理 Git 冲突，chezmoi 不负责自动合并多台机器的编辑。

新增或删除配置文件后，重新生成映射（Windows PowerShell）：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/update-chezmoi-mappings.ps1
```

macOS / WSL2 如装有 PowerShell 7，可用 `pwsh -NoProfile -File scripts/update-chezmoi-mappings.ps1`。已有文件的内容变化无需生成。也可以参照相邻 `.tmpl` 手动添加/删除映射，Neovim 的两个平台目录需同时更新。

`vim.pack` 更新后会修改部署目录的 `nvim-pack-lock.json`。需要同步插件版本时，把该文件复制回 `nvim-config/nvim-pack-lock.json`，检查后一起提交。插件下载、parser、session、缓存、颜色偏好等运行状态留在本机，不应加入 Git。

## 本次兼容性调整

- 消除 Neovim 对 `C:/Program Files/Git` 的固定依赖。
- 按 Windows / WSL / macOS / Linux 选择输入法工具，并检测工具是否存在。
- Vim 使用 fnameescape 加载脚本，支持用户目录包含空格。
- zsh 使用当前 HOME，检测 Oh My Zsh 和插件，修正 `.local` 路径，保留 WSLg 的 DISPLAY。
- 用 `.gitattributes` 固定脚本与配置文件的 LF 换行。

`git_config.sh` 仍作为历史文件保留，不部署、不执行。旧模块说明中的路径或依赖若与本文冲突，以本文和实际配置为准。

验证：chezmoi 2.73.0 已在仓库临时目录完成 Windows apply / verify；通过覆盖平台数据验证 Linux、macOS 的 apply / verify 和目标路径。Neovim Lua 文件语法检查及五种输入法环境分支检查通过。尚未在真实 WSL2 / macOS 环境启动完整插件配置，也未覆盖当前用户目录。

参考：[chezmoi 快速入门](https://www.chezmoi.io/quick-start/)、[平台差异](https://www.chezmoi.io/user-guide/manage-machine-to-machine-differences/)、[include](https://www.chezmoi.io/reference/templates/functions/include/)、[im-select.nvim](https://github.com/keaising/im-select.nvim)。
