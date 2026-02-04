local PADDING = 0        -- space between the elements of ui and the background or the frame !! CAN BE SAFELY EDITED !!
local CURSOR_MARGIN = 15 -- space between the cursor and ui !! CAN BE SAFELY EDITED !!

local ui = {
    e = {},

    w = 0,
    h = PADDING
}

local function execute()
    local executed = {}
    for i in pairs(ui.e) do
        table.insert(executed, ui.i)
    end
    if #executed > 0 then return true end
end

function ResetUi()
    for i in pairs(ui.e) do
        table.remove(ui.e, i)
    end
    ui.w = 0
    ui.h = PADDING

    if execute() then ResetUi() end
end

function AddElements(type, content)
    if type == "text" then
        local font = love.graphics.getFont()
        local text = love.graphics.newText(font)
        text:set(content)

        local w = text:getWidth()
        local h = text:getHeight()

        if ui.w < w then ui.w = w + PADDING end
        ui.h = ui.h + h

        table.insert(ui.e, text)
    end
end

function DrawUi(x, y, bg_rgba, c_rgba)
    local x = x + CURSOR_MARGIN
    local y = y + CURSOR_MARGIN

    love.graphics.setColor(bg_rgba)
    love.graphics.rectangle("fill", x, y, ui.w, ui.h)

    for i, e in pairs(ui.e) do
        local ex = x + PADDING
        local ey = PADDING

        if e:type() == "Text" or e == "text" then
            if i ~= 1 then
                ey = ey + y
                ey = ey + (ui.e[i - 1]:getHeight() * (i - 1)) -- get height of element before the current one
            else
                ey = ey + y
            end
        end

        love.graphics.setColor(c_rgba)
        love.graphics.draw(ui.e[i], ex, ey)
    end
end
