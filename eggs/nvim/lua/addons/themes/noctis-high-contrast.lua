local pack = require("utils.pack")

pack.install({
    source = { pack.gh "iagorrr/noctishc.nvim" },
    enabled = true,

    dependencies = {},

    -- Noctis High Contrast
    -- :help N/A
    callback = function()
        vim.cmd.colorscheme("noctishc")
    end
})
