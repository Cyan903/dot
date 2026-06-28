local pack = require("utils.pack")

pack.install({
    source = { pack.gh "folke/todo-comments.nvim" },
    enabled = true,

    dependencies = {
        {
            source = { pack.gh "nvim-lua/plenary.nvim" },
            enabled = true,
            callback = function() end
        }
    },

    -- Highlight TODO, WARN comments
    -- :help todo-comments
    callback = function()
        require("todo-comments").setup({ signs = false })
    end
})
