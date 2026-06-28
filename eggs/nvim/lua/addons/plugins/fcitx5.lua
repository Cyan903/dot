local pack = require("utils.pack")

pack.install({
    source = { pack.gh "pysan3/fcitx5.nvim" },
    enabled = vim.fn.executable("fcitx5-remote") == 1,

    dependencies = {},

    -- Support for fcitx5
    -- :help fcitx5
    callback = function()
        local en = "keyboard-us"

        require("fcitx5").setup({
            imname = {
                norm = en,
                ins = en,
                cmd = en,
            },

            -- What really matters
            remember_prior = true,
        })
    end
})
