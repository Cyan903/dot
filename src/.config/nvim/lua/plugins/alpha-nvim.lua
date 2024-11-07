-- Landing Page
-- :help alpha-nvim
return {
    "goolord/alpha-nvim",

    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-tree/nvim-tree.lua",
        "nvim-telescope/telescope.nvim",
    },

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        local config_path = os.getenv("NVIM_CONFIG_DIR") or "~/.config/nvim"
        local stats = require("lazy").stats()

        dashboard.section.header.val = require("util.load_header")

        dashboard.section.buttons.val = {
            dashboard.button("e", "New File", "<cmd>ene <CR>"),
            dashboard.button("r", "Recently Opened", "<cmd>Telescope oldfiles <CR>"),
            dashboard.button("c", "Neovim Config", "<cmd>cd " .. config_path .. "<CR>" .. "<cmd>NvimTreeOpen <CR>"),
            dashboard.button("h", "Check Health", "<cmd>checkhealth <CR>"),
            dashboard.button("q", "Quit", "<cmd>qa <CR>"),
        }

        dashboard.section.footer.val = " Loaded " .. stats.loaded .. " plugins out of " .. stats.count .. " total"

        -- Create section (required for the order to be correct)
        local section = {
            header = dashboard.section.header,
            buttons = dashboard.section.buttons,
            footer = dashboard.section.footer,
        }

        alpha.setup({
            layout = {
                { type = "padding", val = 4 },
                section.header,
                { type = "padding", val = 4 },
                section.buttons,
                { type = "padding", val = 4 },
                section.footer,
            },
        })
    end,
}
