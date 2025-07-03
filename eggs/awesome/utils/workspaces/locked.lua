local awful = require("awful")
local gears = require("gears")

return function(t)
    if not t.selected then
        return
    end

    for s in screen do
        if s ~= t.screen then
            local other_tag = awful.tag.find_by_name(s, t.name)

            if other_tag then
                other_tag:view_only()
            end
        end
    end

    -- Ensure the master window is always focused (or whatever is found first as a fallback)
    gears.timer.delayed_call(function()
        local mouse_screen = screen[mouse.screen]

        if not mouse_screen then
            return
        end

        local tag = mouse_screen.selected_tag

        if not tag then
            return
        end

        local clients = tag:clients()

        if #clients > 0 then
            local master_client = awful.client.getmaster()

            if master_client then
                client.focus = master_client
                master_client:raise()
            end
        end
    end)
end
