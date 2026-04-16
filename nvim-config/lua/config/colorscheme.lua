-- ============================================================
-- 配色方案管理
--
-- <Leader>ct 打开选择面板，可切换所有主题及子风格
-- 选择后会自动记住，下次启动自动加载
-- ============================================================

-- 主题列表：每个主题包含名称、插件名和多个子风格
local themes = {
  {
    label = "Tokyo Night",
    name = "tokyonight",
    variants = {
      { "Storm",  function() require("tokyonight").setup({ style = "storm", styles = { comments = { italic = true }, keywords = { italic = true } } }) end },
      { "Moon",   function() require("tokyonight").setup({ style = "moon",  styles = { comments = { italic = true }, keywords = { italic = true } } }) end },
      { "Night",  function() require("tokyonight").setup({ style = "night", styles = { comments = { italic = true }, keywords = { italic = true } } }) end },
      { "Day",    function() require("tokyonight").setup({ style = "day",   styles = { comments = { italic = true }, keywords = { italic = true } } }) end },
    },
  },
  {
    label = "Catppuccin",
    name = "catppuccin",
    variants = {
      { "Latte",      function() require("catppuccin").setup({ flavour = "latte",      transparent_background = false, integrations = { gitsigns = true, neo_tree = true, mini = true } }) end },
      { "Frappe",     function() require("catppuccin").setup({ flavour = "frappe",     transparent_background = false, integrations = { gitsigns = true, neo_tree = true, mini = true } }) end },
      { "Macchiato",  function() require("catppuccin").setup({ flavour = "macchiato",  transparent_background = false, integrations = { gitsigns = true, neo_tree = true, mini = true } }) end },
      { "Mocha",      function() require("catppuccin").setup({ flavour = "mocha",      transparent_background = false, integrations = { gitsigns = true, neo_tree = true, mini = true } }) end },
    },
  },
  {
    label = "Rose Pine",
    name = "rose-pine",
    variants = {
      { "Main",  function() require("rose-pine").setup({ variant = "main" }) end },
      { "Moon",  function() require("rose-pine").setup({ variant = "moon" }) end },
      { "Dawn",  function() require("rose-pine").setup({ variant = "dawn" }) end },
    },
  },
  {
    label = "Nord",
    name = "nord",
    variants = {
      { "Default", function() require("nord").set() end },
    },
  },
}

-- 构建扁平化的选择列表：{ label, apply }  用于选择面板和保存/加载
local function build_items()
  local items = {}
  for _, t in ipairs(themes) do
    for _, v in ipairs(t.variants) do
      table.insert(items, {
        label = #t.variants == 1 and t.label or (t.label .. " - " .. v[1]),
        id = t.name .. "|" .. v[1],     -- 保存到文件的标识
        colorscheme = t.name,
        apply = v[2],
      })
    end
  end
  return items
end

-- 偏好文件路径（记住上次选择的主题）
local pref_file = vim.fn.stdpath("data") .. "/colorscheme-preference"

-- 应用指定 id 的主题
local function apply_by_id(id)
  for _, item in ipairs(build_items()) do
    if item.id == id then
      item.apply()
      vim.cmd.colorscheme(item.colorscheme)
      -- 保存偏好
      local f = io.open(pref_file, "w")
      if f then
        f:write(item.id)
        f:close()
      end
      return
    end
  end
end

-- 启动时加载上次选择的主题，否则使用默认
local default_id = "tokyonight|Storm"
local f = io.open(pref_file, "r")
local saved_id = f and f:read("*l")
if f then f:close() end
apply_by_id(saved_id or default_id)

-- <Leader>ct：打开主题选择面板
vim.keymap.set("n", "<Leader>ct", function()
  local items = build_items()
  local labels = {}
  for _, item in ipairs(items) do
    table.insert(labels, item.label)
  end
  vim.ui.select(labels, { prompt = "选择配色方案" }, function(choice)
    if not choice then return end
    for _, item in ipairs(items) do
      if item.label == choice then
        apply_by_id(item.id)
        return
      end
    end
  end)
end, { desc = "切换配色方案" })
