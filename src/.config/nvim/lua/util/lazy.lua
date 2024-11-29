-- Load the lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end ---@diagnostic disable-next-line: undefined-field

vim.opt.rtp:prepend(lazypath)

-- Configure and install plugins
return function(opts)
    local opt = {}

    -- Load plugin
    for _, plugin in ipairs(opts.plugins) do
        table.insert(opt, { import = plugin })
    end

    -- Load theme
    if opts.theme then
        table.insert(opt, require("themes." .. opts.theme))
    end

    -- Load custom
    if opts.custom then
        for _, custom in ipairs(opts.custom) do
            table.insert(opt, custom)
        end
    end

    require("lazy").setup(opt)
end
