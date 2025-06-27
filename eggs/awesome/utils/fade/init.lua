return function(self, c3, index, objects)
    local sel = 1
    local weight = "normal"
    local fade = {
        "#ffffff",
        "#a5a6a9",
        "#78797f",
        "#4b4d54",
        "#34363e",
        "#30323a",
        "#2b2d36",
        "#272932",
        "#22242d",
    }

    for i in pairs(objects) do
        if objects[i].selected then
            sel = objects[i].index
        end
    end

    if c3.selected then
        weight = "ultrabold"
    end

    self:get_children_by_id("index_role")[1].markup = "<span weight='" .. weight .. "' color='" .. fade[math.abs(index - sel) + 1] .. "' font_desc='FreeMono 8'>" .. objects[index].name .. "</span>"
end
