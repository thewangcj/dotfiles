-- ============================================================
-- Git 集成插件
-- ============================================================

-- gitsigns：git 行级标记 + 当行 blame 显示
-- 功能：
--   1. 左侧符号栏显示每行的 git 状态（新增/修改/删除）
--   2. 光标所在行最右侧显示 commit 信息（作者、时间、消息）
--   3. 支持 stage/revert/preview hunks 等操作
require("gitsigns").setup({
  -- 当行 blame 显示（类似 VSCode GitLens）
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,       -- 使用虚拟文本显示（行尾右侧）
    virt_text_pos = "eol",  -- 显示在行尾（end of line）
    delay = 300,            -- 光标停留 300ms 后显示
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  -- 快捷键（行级操作，仅对 git 仓库中的文件生效）
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local function bmap(mode, lhr, rhr, desc)
      vim.keymap.set(mode, lhr, rhr, { buffer = bufnr, desc = desc })
    end

    -- 导航到上一个/下一个修改块（hunk）
    bmap("n", "]h", function()
      if vim.wo.diff then return "]h" end
      vim.schedule(function() gs.nav_hunk("next") end)
      return "<Ignore>"
    end, "下一个修改块")
    bmap("n", "[h", function()
      if vim.wo.diff then return "[h" end
      vim.schedule(function() gs.nav_hunk("prev") end)
      return "<Ignore>"
    end, "上一个修改块")

    -- 行级操作
    bmap("n", "<leader>hs", gs.stage_hunk, "暂存修改块（stage hunk）")
    bmap("n", "<leader>hr", gs.reset_hunk, "还原修改块（reset hunk）")
    bmap("n", "<leader>hp", gs.preview_hunk, "预览修改（preview hunk）")
    bmap("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "完整 blame")

    -- 可视模式下操作
    bmap("v", "<leader>hs", function()
      gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "暂存选中的修改块")
    bmap("v", "<leader>hr", function()
      gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "还原选中的修改块")
  end,
})
