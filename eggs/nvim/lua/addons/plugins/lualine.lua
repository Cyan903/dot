-- Status line
-- :help lualine
return {
    "nvim-lualine/lualine.nvim",

    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        local lualine = require("lualine")
        local colors = {
            bg = "#000000", -- {< replace_color(data.colors.background) >}
            fg = "#FFFFFF", -- {< replace_color(data.colors.foreground) >}
            yellow = "#FFFF00", -- {< replace_color(data.colors.yellow) >}
            cyan = "#00FFFF", -- {< replace_color(data.colors.cyan) >}
            darkblue = "#8080FF", -- {< replace_color(data.colors.hblue) >}
            green = "#00FF00", -- {< replace_color(data.colors.green) >}
            orange = "#FFA500", -- {< replace_color(data.colors.orange) >}
            violet = "#FFFF99", -- {< replace_color(data.colors.hyellow) >}
            magenta = "#FF00FF", -- {< replace_color(data.colors.magenta) >}
            blue = "#5C5CFF", -- {< replace_color(data.colors.blue) >}
            red = "#FF0000", -- {< replace_color(data.colors.red) >}
        }

        local config = {
            options = {
                component_separators = "",
                section_separators = "",
                theme = {
                    normal = { c = { fg = colors.fg, bg = colors.bg } },
                    inactive = { c = { fg = colors.fg, bg = colors.bg } },
                },
            },

            sections = {
                -- Remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},

                -- These will be filled later
                lualine_c = {},
                lualine_x = {},
            },

            inactive_sections = {
                -- Remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
        }

        -- Mode component
        table.insert(config.sections.lualine_c, {
            "mode",
            icon = " ",
            color = function()
                local mode_color = {
                    n = colors.red,
                    i = colors.green,
                    v = colors.blue,
                    [""] = colors.blue,
                    V = colors.blue,
                    c = colors.magenta,
                    no = colors.red,
                    s = colors.orange,
                    S = colors.orange,
                    [""] = colors.orange,
                    ic = colors.yellow,
                    R = colors.violet,
                    Rv = colors.violet,
                    cv = colors.red,
                    ce = colors.red,
                    r = colors.cyan,
                    rm = colors.cyan,
                    ["r?"] = colors.cyan,
                    ["!"] = colors.red,
                    t = colors.red,
                }

                return { fg = mode_color[vim.fn.mode()], gui = "bold" }
            end,
        })

        -- Spelunk component
        require("util.srequire")("spelunk", function()
            table.insert(config.sections.lualine_c, {
                "spelunk",
                color = { fg = colors.orange, gui = "bold" },
            })
        end)

        -- Filename component
        table.insert(config.sections.lualine_c, {
            "filename",
            icon = "",
            cond = function()
                return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
            end,

            color = { fg = colors.magenta, gui = "bold" },
        })

        -- LSP diagnostics component
        table.insert(config.sections.lualine_x, {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " " },
            diagnostics_color = {
                error = { fg = colors.red },
                warn = { fg = colors.yellow },
                info = { fg = colors.cyan },
            },
        })

        -- LSP component
        table.insert(config.sections.lualine_x, {
            function()
                local msg = "None"
                local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                local clients = vim.lsp.get_clients()

                if next(clients) == nil then
                    return msg
                end

                for _, client in ipairs(clients) do
                    ---@diagnostic disable-next-line: undefined-field
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return client.name
                    end
                end

                return msg
            end,

            icon = " ",
            color = { fg = "#ffffff", gui = "bold" },
        })

        -- Git branch component
        table.insert(config.sections.lualine_x, {
            "branch",
            icon = "",
            color = { fg = colors.violet, gui = "bold" },
        })

        -- Encoding component
        table.insert(config.sections.lualine_x, {
            "o:encoding",
            fmt = string.upper,
            cond = function()
                return vim.fn.winwidth(0) > 80
            end,

            color = { fg = colors.green, gui = "bold" },
        })

        -- File format component
        table.insert(config.sections.lualine_x, {
            "fileformat",
            fmt = string.upper,
            icons_enabled = true,
            color = { fg = colors.green, gui = "bold" },
        })

        lualine.setup(config)
    end,
}
