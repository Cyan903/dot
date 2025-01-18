-- Load init.X based on config
return function(config)
    for _, app in ipairs(config) do
        if app[2] then
            require("init." .. app[1])
            return
        end
    end

    require("init.nvim")
end
