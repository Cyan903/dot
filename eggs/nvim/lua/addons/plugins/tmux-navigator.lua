local pack = require("utils.pack")

pack.install({
    source = { pack.gh "christoomey/vim-tmux-navigator" },
    enabled = vim.fn.executable("tmux") == 1,

    dependencies = {},

    -- Additional support for tmux
    -- :help tmux-navigator
    callback = function() end
})
