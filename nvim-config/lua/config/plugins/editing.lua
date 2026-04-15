-- ============================================================
-- 编辑增强插件
-- VSCode 和独立模式通用
-- ============================================================

-- mini.pairs：自动括号配对
-- 输入 ( 时自动补全 )，支持 (), {}, [], "", '', ``
require("mini.pairs").setup()

-- mini.surround：包围操作
-- 常用操作：
--   saiw"  - 给当前单词加上双引号（surround add）
--   sdiw"  - 删除当前单词的双引号（surround delete）
--   sriw'  - 将双引号替换为单引号（surround replace）
--   sf"    - 找到下一个双引号并包围（surround find）
require("mini.surround").setup()

-- mini.ai：增强文本对象
-- 新增文本对象：
--   ii / ai - 缩进块（inner/around indent）
--   ia / aa - 函数参数（inner/around argument）
-- 示例：vii 选中同级缩进块，dia 删除函数参数
require("mini.ai").setup()

-- mini.comment：快速注释
-- gcc - 注释/取消注释当前行
-- gc  - 可视模式下注释/取消注释选中区域
-- gbc - 块注释当前行
require("mini.comment").setup()

-- mini.trailspace：高亮并一键清除行尾多余空格
-- 自动高亮行尾空格，<Leader>cs 清除当前文件所有行尾空格
require("mini.trailspace").setup()
