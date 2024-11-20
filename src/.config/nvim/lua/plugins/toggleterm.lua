-- Toggle terminal
-- :help toggleterm
return {
    "akinsho/toggleterm.nvim",

    version = "*",
    config = function()
        local toggleterm = require("toggleterm")
        local terminal = require("toggleterm.terminal").Terminal

        local default_opts = {
            display_name = "Default",
            cmd = "ZSH_VI_DISABLED=true " .. vim.o.shell,
        }

        local terms = { Default = terminal:new(default_opts) }
        local cterm = "Default"

        -- Add to which-key menu
        require("util.safe_require")("which-key", function(key)
            key.add({
                { "<leader>t", group = "[T]erminal (toggleterm)" },
            })
        end)

        -- Create terminal session
        vim.keymap.set("n", "<leader>ta", function()
            local name = vim.fn.input("Enter terminal name: ")

            if name == "" then
                print("[toggleterm] nothing to create!")
                return
            end

            for t in pairs(terms) do
                if t == name then
                    print("[toggleterm] `" .. name .. "` is a duplicate session!")
                    return
                end
            end

            terms[name] = terminal:new({
                display_name = name,
                cmd = default_opts.cmd,
            })

            cterm = name
        end, { desc = "Create new terminal session" })

        -- Select the terminal session
        vim.keymap.set("n", "<leader>ts", function()
            local names = {}

            for t in pairs(terms) do
                names[#names + 1] = t
            end

            vim.ui.select(names, { prompt = "Select session (" .. cterm .. ")" }, function(session_name)
                if not session_name then
                    return
                end

                terms[session_name]:toggle(20, "float")
                cterm = session_name
            end)
        end, { desc = "Terminal session selection menu" })

        -- Delete terminal session
        vim.keymap.set("n", "<leader>td", function()
            local names = {}

            for t in pairs(terms) do
                names[#names + 1] = t
            end

            vim.ui.select(names, { prompt = "Delete session (" .. cterm .. ")" }, function(session_name)
                if not session_name then
                    return
                end

                if cterm == session_name then
                    print("[toggleterm] Cannot delete current session!")
                    return
                end

                terms[session_name] = nil
            end)
        end, { desc = "Delete session from menu" })

        -- Easier way to exit
        vim.keymap.set("t", "<Esc>", function()
            for t in pairs(terms) do
                terms[t]:close()
            end
        end, { desc = "Exit terminal mode" })

        -- Open terminal
        vim.keymap.set("n", "<leader>tt", function()
            terms[cterm]:toggle(20, "float")
        end, { desc = "Open floating terminal" })

        vim.keymap.set("n", "<leader>tj", function()
            terms[cterm]:toggle(20, "horizontal")
        end, { desc = "Open horizontal terminal" })

        -- The kemap set in `config/keymap.lua` can interfere with this plugin
        vim.keymap.del("t", "<Esc><Esc>")

        -- Setup terminal
        toggleterm.setup({})
    end,
}
