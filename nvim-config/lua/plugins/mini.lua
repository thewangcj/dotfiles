-- plugins echasnovski/mini.nvim
return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
        require('mini.splitjoin').setup()  -- 示例配置，根据需要修改
        -- 可以添加其他 mini.nvim 模块的配置
        require('mini.sessions').setup()
        require('mini.starter').setup()
        -- require('mini.tabline').setup()
        require('mini.statusline').setup()
        require('mini.git').setup()
        require('mini.trailspace').setup() -- 可以将多余的空白字符显示出来
        require('mini.comment').setup()
    end
}
