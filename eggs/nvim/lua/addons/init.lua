local pack = require("utils.pack")

-- Set pack binds
vim.keymap.set("n", "<leader>pc", pack.clean, { desc = "[P]ack [C]lean" })
vim.keymap.set("n", "<leader>ph", function() vim.cmd([[ :checkhealth vim.lsp ]]) end, { desc = "[P]ack [H]ealth" })

---@class AddonsConfig
---@field plugins string[]?
---@field custom string[]?
---@field theme string?

---@param opts AddonsConfig
---@return nil
return function(opts)
    local r = require("utils.require")

    -- Load plugins
    if opts.plugins then
        for _, plugin in ipairs(opts.plugins) do
            r("addons.plugins." .. plugin)
        end
    end

    -- Load custom
    if opts.custom then
        for _, custom in ipairs(opts.custom) do
            r("addons.custom." .. custom)
        end
    end

    -- Load theme
    if opts.theme then
        r("addons.themes." .. opts.theme)
    end
end
