-- Load init.X based on config
return function(config)
    for _, app in ipairs(config) do
        if app[2] then
            require("core.init." .. app[1])
            return
        end
    end

    require("core.init.nvim")
end
