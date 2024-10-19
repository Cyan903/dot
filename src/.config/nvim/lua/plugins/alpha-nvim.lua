-- Dashboard
-- :help alpha
return {
    "goolord/alpha-nvim",

    dependencies = { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    config = function()
        local startify = require("alpha.themes.startify")

        if vim.g.have_nerd_font then
            startify.file_icons.provider = "devicons"
        end

        require("alpha").setup(startify.config)
    end,
}
