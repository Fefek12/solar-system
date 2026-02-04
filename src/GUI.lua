require("src/lib/uilib")

function HoverUi(star, planets)
    if not star or not star.x then return end

    local mx, my = love.mouse.getPosition()

    local distStar = math.sqrt((mx - star.x) ^ 2 + (my - star.y) ^ 2)

    if distStar <= star.r then
        ResetUi()
        AddElements("text", "temperature: " .. star.temp .. "K")
        AddElements("text", "size: " .. star.r)
        AddElements("text", "type: " .. star.type)
        DrawUi(mx, my, { 0.2, 0.2, 0.2, 0.7 }, { 1, 1, 1, 1 })
        ResetUi()
        return
    end

    if planets then
        for _, planet in pairs(planets) do
            local distPlanet = math.sqrt((mx - planet.x) ^ 2 + (my - planet.y) ^ 2)

            if distPlanet <= planet.r then
                ResetUi()
                AddElements("text", "size: " .. planet.r)
                AddElements("text", "speed: " .. planet.s)
                AddElements("text", "moons: " .. #planet.moons)
                DrawUi(mx, my, { 0.2, 0.2, 0.2, 0.7 }, { 1, 1, 1, 1 })
                ResetUi()
                break
            end
        end
    end
end
