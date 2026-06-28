---@param module string
---@param fn? fun(mod:any):any
---@return any
return function(module, fn)
    local ok, mod = pcall(require, module)

    if not ok then
        vim.notify(("Failed to load %s"):format(module, vim.log.levels.WARN))
        return
    end

    if not fn then return end
    return fn(mod)
end
