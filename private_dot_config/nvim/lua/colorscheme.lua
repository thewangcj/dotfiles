local colorscheme = "kanagawa"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " 没有找到！")
  return
end

-- Get zephyr color
-- local zephyr =  require('zephyr').zephyr.yellow/teal/fg/bg
