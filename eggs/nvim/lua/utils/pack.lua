local M = {}

---@param repo string
---@return string
M.gh = function(repo) return "https://github.com/" .. repo end

---@class Install
---@field source (string|vim.pack.Spec)[] - Plugin source(s)
---@field enabled boolean - Enable/disable plugin
---@field dependencies? Install[] - Dependency sources (list)
---@field callback function - Callback function

---@param opts Install
---@return boolean
M._load = function(opts)
    -- Load plugin
    local _, err = pcall(vim.pack.add, opts.source)

    if err then
        vim.notify(("Failed to load %s"):format(opts.source, vim.log.levels.WARN))
        return false
    end

    -- Run callback
    opts.callback()
    return true
end

---@param opts Install
---@return nil
M.install = function(opts)
    if not opts.enabled then return end

    -- Load dependencies
    for _, dep in ipairs(opts.dependencies or {}) do
        if dep.enabled then
            if not M._load(dep) then return end
        end
    end

    -- Load plugin
    M._load(opts)
end

---@return nil
M.clean = function()
    local active_plugins = {}
    local unused_plugins = {}

    for _, plugin in ipairs(vim.pack.get()) do
        active_plugins[plugin.spec.name] = plugin.active
    end

    for _, plugin in ipairs(vim.pack.get()) do
        if not active_plugins[plugin.spec.name] then
            table.insert(unused_plugins, plugin.spec.name)
        end
    end

    if #unused_plugins == 0 then
        vim.notify("No unused plugins.")
        return
    end

    local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
    if choice == 1 then vim.pack.del(unused_plugins) end
end

return M
