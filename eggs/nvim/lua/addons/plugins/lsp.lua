local pack = require("utils.pack")
local cfg = require("addons.cfg")

-- LSP
pack.install({
    source = { pack.gh "neovim/nvim-lspconfig" },
    enabled = vim.g.lsp_enabled,

    dependencies = {
        {
            source = { pack.gh "j-hui/fidget.nvim" },
            enabled = true,
            callback = function()
                require("fidget").setup({})
            end,
        },

        {
            source = { pack.gh "mason-org/mason.nvim" },
            enabled = true,
            callback = function() end,
        },

        {
            source = { pack.gh "mason-org/mason-lspconfig.nvim" },
            enabled = true,
            callback = function() end,
        },

        {
            source = { pack.gh "WhoIsSethDaniel/mason-tool-installer.nvim" },
            enabled = true,
            callback = function() end,
        },
    },

    callback = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                -- Add to which-key menu
                require("utils.require")("which-key", function(key)
                    key.add({
                        { "<leader>c", group = "[C]ode (LSP)" },
                        { "<leader>cd", group = "[C]ode [D]ocument" },
                        { "<leader>cr", group = "[C]ode [R]ename" },
                        { "<leader>cw", group = "[C]ode [W]orkspace" },
                    })
                end)

                -- Jump to the definition of the word under your cursor
                -- To jump back, press <C-t>
                map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

                -- Jump to declaration
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                -- Find references for the word under your cursor
                map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                -- Jump to the implementation of the word under your cursor
                map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

                -- Open floating window with error
                map("gh", vim.diagnostic.open_float, "[G]oto [H]elp popup")

                -- Jump to the type of the word under your cursor
                map("<leader>cD", require("telescope.builtin").lsp_type_definitions, "[C]ode Type [D]efinition")

                -- Fuzzy find all the symbols in your current document
                map("<leader>cds", require("telescope.builtin").lsp_document_symbols, "[C]ode [D]ocument [S]ymbols")

                -- Fuzzy find all the symbols in your current workspace
                map("<leader>cws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[C]ode [W]orkspace [S]ymbols")

                -- Rename the variable under your cursor
                map("<leader>crn", vim.lsp.buf.rename, "[C]ode [R]e[n]ame")

                -- Execute a code action
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

                -- Disable LSP
                vim.keymap.set("n", "<leader>cs", function()
                    local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })

                    for _, client in ipairs(clients) do
                        vim.lsp.enable(client.name, false)
                    end
                end, { desc = "[C]ode LSP [S]top" })

                -- Highlight references when the cursor idles on a definition
                local client = vim.lsp.get_client_by_id(event.data.client_id)

                if client and client:supports_method("textDocument/documentHighlight", event.buf) then
                    local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
                        end,
                    })
                end

                -- Enable inlay hints user command
                if client and client:supports_method("textDocument/inlayHint", event.buf) then
                    map("<leader>ch", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                    end, "[C]ode Inlay [H]ints")
                end
            end,
        })

        require("mason").setup()

        require("mason-tool-installer").setup({
            ensure_installed = vim.tbl_keys(cfg.servers),
        })

        for name, server in pairs(cfg.servers) do
            vim.lsp.config(name, server)
            vim.lsp.enable(name)
        end
    end,
})

-- Formatting
pack.install({
    source = { pack.gh "stevearc/conform.nvim" },
    enabled = vim.g.lsp_enabled,

    dependencies = {},

    callback = function()
        local conform = require("conform")

        conform.setup({
            notify_on_error = false,
            format_on_save = function() end, -- Do not format on save
            default_format_opts = { lsp_format = "fallback" },
            formatters_by_ft = vim.tbl_deep_extend("force", { lua = { "stylua" } }, cfg.format.ft),
        })

        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            conform.format({ async = true })
        end, { desc = "[F]ormat buffer" })
    end,
})

-- Autocomplete & Snippets
pack.install({
    source = { pack.gh "saghen/blink.cmp" },
    enabled = vim.g.lsp_enabled,

    dependencies = {
        {
            source = { pack.gh "saghen/blink.lib" },
            enabled = true,
            callback = function() end,
        },

        {
            source = { pack.gh "L3MON4D3/LuaSnip" },
            enabled = true,
            callback = function()
                require("luasnip").setup({})
            end,
        },
    },

    callback = function()
        local cmp = require("blink.cmp")

        -- NOTE: Will hang until built
        cmp.build():pwait()

        -- https://cmp.saghen.dev/configuration/keymap
        cmp.setup({
            keymap = {
                preset = "default",

                ["<C-e>"] = { "show", "show_documentation", "hide_documentation" },
            },

            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 0,
                },

                ghost_text = {
                    enabled = true,
                    show_with_menu = true,
                },
            },

            cmdline = {
                keymap = { preset = "inherit" },
                completion = { menu = { auto_show = false } },
            },

            appearance = { nerd_font_variant = "mono" },
            sources = { default = { "lsp", "path", "snippets", "buffer" } },
            snippets = { preset = "luasnip" },
            fuzzy = { implementation = "rust" }, -- OR "lua"
            signature = { enabled = true },
        })
    end,
})
