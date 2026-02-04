--[[
        gravitation = yes
        position = good
        hakenr = no
        fps = 300
        moons = yes
        graphics = fire
]]

require("src/obj/planet")
require("src/obj/moon")
require("src/obj/star")

function love.load()
    Star = {}
    Planets = {}
    LastTemp = nil
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
    if Star and Star.x and Star.y and Star.r then DrawStar(Star) end

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
    if key == "f1" or key == "f11" then
        if love.window.getFullscreen() then
            love.window.setFullscreen(false)
        else
            love.window.setFullscreen(true)
        end
        Star.x = love.graphics.getWidth() / 2
        Star.y = love.graphics.getHeight() / 2
    elseif key == "1" then
        Star = CreateStar()
        if not LastTemp then
            LastTemp = Star.temp
        else
            if LastTemp ~= Star.temp then
                PlanetsChanged(Planets, Star)
                LastTemp = Star.temp
            end
        end
    elseif key == "2" then
        local planet = CreatePlanet(Star, Planets, nil)

        table.insert(Planets, planet)
    elseif key == "3" then
        if not Planets or #Planets <= 0 then return end

        local planet = Planets[math.random(1, #Planets)]
        local moon = CreateMoon(planet)

        table.insert(planet.moons, moon)
    end
end
