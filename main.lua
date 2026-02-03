--[[
        gravitation = yes
        position = good
        hakenr = no
        fps = 300
        moons = yes
        graphics = fire
]]

require("solar-system/planet")
require("solar-system/moon")

function love.load()
    Star = {
        x = love.graphics.getWidth() / 2,
        y = love.graphics.getHeight() / 2,
        r = 100,
    }
    Planets = {}
end

function love.update(dt)
    for _, planet in pairs(Planets) do
        UpdatePlanet(Star, planet, dt)
        if #planet.moons > 0 then
            for _, moon in pairs(planet.moons) do
                UpdateMoon(planet, moon, dt)
            end
        end
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 0)
    love.graphics.circle("fill", Star.x, Star.y, Star.r)

    for _, planet in pairs(Planets) do
        DrawPlanet(Star, planet)
        if #planet.moons > 0 then
            for _, moon in pairs(planet.moons) do
                DrawMoon(planet, moon)
            end
        end
    end
end

function love.keypressed(key)
    if key == "f1" then
        if love.window.getFullscreen() then
            love.window.setFullscreen(false)
        else
            love.window.setFullscreen(true)
        end
        Star.x = love.graphics.getWidth() / 2
        Star.y = love.graphics.getHeight() / 2
    elseif key == "1" then
        local planet = CreatePlanet(Star, Planets)

        table.insert(Planets, planet)
    elseif key == "2" then
        if not Planets or #Planets <= 0 then return end

        local planet = Planets[math.random(1, #Planets)]
        local moon = CreateMoon(planet)

        table.insert(planet.moons, moon)
    end
end
