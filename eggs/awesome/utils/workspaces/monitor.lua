local awful = require("awful")

local function swap_screens(dir)
    return function()
        local currentScreen = awful.screen.focused()
        local targetScreen = currentScreen:get_next_in_direction(dir)

        -- Validate
        if not targetScreen then
            return
        end

        -- Swap layouts
        local targetLayout = awful.layout.get(currentScreen)
        local swappedLayout = awful.layout.get(targetScreen)

        awful.layout.set(swappedLayout, currentScreen.selected_tag)
        awful.layout.set(targetLayout, targetScreen.selected_tag)

        -- Swap number of master clients
        local targetMaster = awful.tag.getnmaster(currentScreen.selected_tag)
        local swappedMaster = awful.tag.getnmaster(targetScreen.selected_tag)

        awful.tag.setnmaster(swappedMaster, currentScreen.selected_tag)
        awful.tag.setnmaster(targetMaster, targetScreen.selected_tag)

        -- Swap master width
        local targetWidth = awful.tag.getmwfact(currentScreen.selected_tag)
        local swappedWidth = awful.tag.getmwfact(targetScreen.selected_tag)

        awful.tag.setmwfact(swappedWidth, currentScreen.selected_tag)
        awful.tag.setmwfact(targetWidth, targetScreen.selected_tag)

        -- Swap number of columns
        local targetCols = awful.tag.getncol(currentScreen.selected_tag)
        local swappedCols = awful.tag.getncol(targetScreen.selected_tag)

        awful.tag.setncol(swappedCols, currentScreen.selected_tag)
        awful.tag.setncol(targetCols, targetScreen.selected_tag)

        -- Swap clients
        local targetClients = currentScreen.selected_tag:clients()
        local swappedClients = targetScreen.selected_tag:clients()

        for _, client in ipairs(targetClients) do
            client:move_to_screen(targetScreen.index)
        end

        for _, client in ipairs(swappedClients) do
            client:move_to_screen(currentScreen.index)
        end

        awful.screen.focus(targetScreen)
    end
end

local function focus_screens(dir)
    return function()
        local targetScreen = awful.screen.focused():get_next_in_direction(dir)

        if targetScreen then
            awful.screen.focus(targetScreen)
        end
    end
end

local function move_screens(dir)
    return function(c)
        local targetscreen = awful.screen.focused():get_next_in_direction(dir)

        if targetscreen then
            local tag = targetscreen.selected_tag

            if tag then
                c:move_to_screen(targetscreen)
                c:move_to_tag(tag)

                tag:view_only()
            end
        end
    end
end

return {
    swap_screens = swap_screens,
    focus_screens = focus_screens,
    move_screens = move_screens,
}
