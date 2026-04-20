-- ============================================================
-- 输入法自动切换
-- ============================================================

-- im-select.nvim：根据 Neovim 模式自动切换输入法
-- 进入插入模式时恢复之前的输入法，退出插入/命令模式时切换到英文
-- 各平台需要安装 im-select：
--   Windows：https://github.com/daipeihust/im-select 安装 im-select.exe
--   macOS：  brew install im-select（或系统自带）
--   Linux：  https://github.com/daipeihust/im-select 编译安装

local is_win = vim.fn.has("win32") == 1

require("im_select").setup({
  -- 默认输入法：Windows 用键盘布局代码 1033（英文 US），macOS/Linux 用 ABC
  default_im_select = is_win and "1033" or "com.apple.keylayout.ABC",
  -- 命令名称：Windows 带 .exe 后缀
  default_command = is_win and "im-select.exe" or "im-select",
})
