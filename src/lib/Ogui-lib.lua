-- Ogui-lib version 1.1
-- made with ♥️ by Fefek

local DEFAULT_FONT_SIZE = 14

Frame = {}
Frame.__index = Frame

function Frame.new(rgba)
    local obj = setmetatable({}, Frame)
    obj.elements = {}
    obj.width = 0
    obj.height = 0
    obj.color = rgba
    obj.pos = {}
    return obj
end

function Frame:add(element)
    if not element then return false end

    table.insert(self.elements, element)

    self.width = 0
    self.height = 0

    for _, e in pairs(self.elements) do
        local ew, eh = e:getSize()
        
        if ew > self.width then self.width = ew end
        
        self.height = self.height + eh
    end
end

function Frame:draw(x, y)
    self.pos = {x = x, y = y}

    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", x, y, self.width, self.height)

    local ex = x
    local ey = y

    for i, e in pairs(self.elements) do
        if self.elements[i - 1] then
            local _, eh = self.elements[i - 1]:getSize()
            ey = ey + eh
        end
        
        e:draw(ex, ey)
    end
end

function Frame:extend(extension)
    return extension()
end

function Frame:getSize()
    return self.width, self.height
end

function Frame:isHovered()
    local mx, my = love.mouse.getPosition()

    if not self.pos or not self.pos.x or not self.pos.y then return false end
    
    if mx >= self.pos.x and mx <= (self.pos.x + self.width) and my >= self.pos.y and my < (self.pos.y + self.height) then return true end
    
    return false
end

function Frame:destroy()
    for i = #self.elements, 1, -1 do
        self.elements[i] = nil
    end
    self.elements = nil
    setmetatable(self, nil)
    return true
end

function Frame:clear()
    for i in pairs(self.elements) do
        table.remove(self.elements, i)
    end
    self.width = 0
    self.height = 0
    return true
end

Text = {}
Text.__index = Text

function Text.new(content, scale, rgba)
    local obj = setmetatable({}, Text)
    obj.content = content
    obj.scale = scale
    obj.color = rgba

    local f = love.graphics.newFont(DEFAULT_FONT_SIZE * scale)
    local t = love.graphics.newText(f, content)

    obj.width = t:getWidth()
    obj.height = t:getHeight()

    f:release()
    t:release()

    return obj
end

function Text:getSize()
    return self.width, self.height
end

function Text:draw(x, y)
    local f = love.graphics.newFont(DEFAULT_FONT_SIZE * self.scale)
    local t = love.graphics.newText(f, self.content)

    love.graphics.setColor(self.color)
    love.graphics.draw(t, x, y)
end

Void = {}
Void.__index = Void

function Void.new(width, height, rgba)
    local obj = setmetatable({}, Void)
    obj.width = width
    obj.height = height
    obj.color = rgba or {1, 1, 1, 0}
    return obj
end

function Void:getSize()
    return self.width, self.height
end

function Void:draw(x, y)
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", x, y, self.width, self.height)
end