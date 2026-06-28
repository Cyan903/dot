local pack = require("utils.pack")

pack.install({
    source = { pack.gh "lewis6991/gitsigns.nvim" },
    enabled = vim.fn.executable("git") == 1,

    dependencies = {},

    -- Git signs in status column
    -- :help gitsigns
    callback = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        })
    end
})
