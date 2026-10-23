-- 输入法工具按当前系统选择；未安装时跳过。
local is_windows = vim.fn.has('win32') == 1 or vim.fn.has('wsl') == 1
local command, default_im
if is_windows then
  command, default_im = 'im-select.exe', '1033'
elseif vim.fn.has('macunix') == 1 then
  command, default_im = 'macism', 'com.apple.keylayout.ABC'
elseif vim.fn.executable('fcitx5-remote') == 1 then
  command, default_im = 'fcitx5-remote', 'keyboard-us'
elseif vim.fn.executable('fcitx-remote') == 1 then
  command, default_im = 'fcitx-remote', '1'
elseif vim.fn.executable('ibus') == 1 then
  command, default_im = 'ibus', 'xkb:us::eng'
end
if command and vim.fn.executable(command) == 1 then
  require('im_select').setup({
    default_command = command,
    default_im_select = default_im,
  })
end