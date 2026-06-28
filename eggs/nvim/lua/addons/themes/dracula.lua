local pack = require("utils.pack")

pack.install({
    source = { pack.gh "Mofiqul/dracula.nvim" },
    enabled = true,

    dependencies = {},

    -- Dracula theme
    -- :help dracula
    callback = function()
        vim.cmd.colorscheme("dracula")
    end
})
