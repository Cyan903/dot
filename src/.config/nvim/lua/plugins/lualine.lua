-- Status line
-- :help lualine
return {
    "nvim-lualine/lualine.nvim",

    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        local lualine = require("lualine")
        local colors = {
            bg = "#202328",
            fg = "#bbc2cf",
            yellow = "#ECBE7B",
            cyan = "#008080",
            darkblue = "#081633",
            green = "#98be65",
            orange = "#FF8800",
            violet = "#a9a1e1",
            magenta = "#c678dd",
            blue = "#51afef",
            red = "#ec5f67",
        }

        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
            end,

            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end,

            check_git_workspace = function()
                local filepath = vim.fn.expand("%:p:h")
                local gitdir = vim.fn.finddir(".git", filepath .. ";")

                return gitdir and #gitdir > 0 and #gitdir < #filepath
            end,
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

        -- Bar component
        table.insert(config.sections.lualine_c, {
            function()
                return "▊"
            end,

            color = { fg = colors.blue },
            padding = { left = 0, right = 1 },
        })

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

                return { fg = mode_color[vim.fn.mode()] }
            end,
        })

        -- Filesize component
        table.insert(config.sections.lualine_c, { "filesize", cond = conditions.buffer_not_empty })

        -- Filename component
        table.insert(config.sections.lualine_c, {
            "filename",
            cond = conditions.buffer_not_empty,
            color = { fg = colors.magenta, gui = "bold" },
        })

        -- Location component
        table.insert(config.sections.lualine_c, { "location" })

        -- Progress component
        table.insert(config.sections.lualine_c, { "progress", color = { fg = colors.fg, gui = "bold" } })

        -- LSP diagnostics component
        table.insert(config.sections.lualine_c, {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " " },
            diagnostics_color = {
                error = { fg = colors.red },
                warn = { fg = colors.yellow },
                info = { fg = colors.cyan },
            },
        })

        -- Middle component
        table.insert(config.sections.lualine_c, {
            function()
                return "%="
            end,
        })

        -- LSP component
        table.insert(config.sections.lualine_c, {
            function()
                local msg = "No Active Lsp"
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

        -- Encoding component
        table.insert(config.sections.lualine_x, {
            "o:encoding",
            fmt = string.upper,
            cond = conditions.hide_in_width,
            color = { fg = colors.green, gui = "bold" },
        })

        -- File format component
        table.insert(config.sections.lualine_x, {
            "fileformat",
            fmt = string.upper,
            icons_enabled = true,
            color = { fg = colors.green, gui = "bold" },
        })

        -- Git branch component
        table.insert(config.sections.lualine_x, {
            "branch",
            icon = "",
            color = { fg = colors.violet, gui = "bold" },
        })

        -- Spelunk component
        require("util.safe_require")("spelunk", function()
            table.insert(config.sections.lualine_x, {
                "spelunk",
                color = { fg = colors.red, gui = "bold" },
            })
        end)

        -- Bar component
        table.insert(config.sections.lualine_x, {
            function()
                return "▊"
            end,

            color = { fg = colors.blue },
            padding = { left = 1 },
        })

        lualine.setup(config)
    end,
}
