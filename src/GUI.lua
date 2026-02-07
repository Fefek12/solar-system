require("src/lib/Ogui-lib")

function HoverUi(star, planets)
    if not star or not star.x then return end

    local mx, my = love.mouse.getPosition()

    local distStar = math.sqrt((mx - star.x) ^ 2 + (my - star.y) ^ 2)

    if distStar <= star.r then
        local ui = Frame.new({0.2, 0.2, 0.2, 1})
        ui:add(Text.new("temperature: ".. star.temp, 1, {1, 1, 1, 1}))
        ui:add(Text.new("size: ".. star.r, 1, {1, 1, 1, 1}))
        ui:add(Text.new("type: ".. star.type, 1, {1, 1, 1, 1}))
        ui:draw(mx + 15, my + 15)
        return
    end
    
    if planets then
        for _, planet in pairs(planets) do
            local distPlanet = math.sqrt((mx - planet.x) ^ 2 + (my - planet.y) ^ 2)

            if distPlanet <= planet.r then
                local ui = Frame.new({0.2, 0.2, 0.2, 1})
                ui:add(Text.new("size: ".. planet.r, 1, {1, 1, 1, 1}))
                ui:add(Text.new("speed: ".. planet.s, 1, {1, 1, 1, 1}))
                ui:add(Text.new("moons: ".. #planet.moons, 1, {1, 1, 1, 1}))
                ui:draw(mx + 15, my + 15)
                return
            end
        end
    end
end
