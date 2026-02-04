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
require("src/GUI")

local star = {}
local planets = {}
local lastTemp = nil

function love.load() end

function love.update(dt)
    for _, planet in pairs(planets) do
        UpdatePlanet(star, planet, dt)
        if #planet.moons > 0 then
            for _, moon in pairs(planet.moons) do
                UpdateMoon(planet, moon, dt)
            end
        end
    end
end

function love.draw()
    if star and star.x and star.y and star.r then DrawStar(star) end

    for _, planet in pairs(planets) do
        DrawPlanet(star, planet)
        if #planet.moons > 0 then
            for _, moon in pairs(planet.moons) do
                DrawMoon(planet, moon)
            end
        end
    end

    HoverUi(star, planets)
end

-- INPUT HANDLING --

function love.keypressed(key)
    if key == "f1" or key == "f11" then
        if love.window.getFullscreen() then
            love.window.setFullscreen(false)
        else
            love.window.setFullscreen(true)
        end

        if not star or not star.x or not star.y then return end

        star.x = love.graphics.getWidth() / 2
        star.y = love.graphics.getHeight() / 2
    elseif key == "1" then
        star = CreateStar()
        if not lastTemp then
            lastTemp = star.temp
        else
            if lastTemp ~= star.temp then
                PlanetsChanged(planets, star)
                lastTemp = star.temp
            end
        end
    elseif key == "2" then
        if not star or not star.x or not star.y then return end

        local planet = CreatePlanet(star, planets, nil)

        table.insert(planets, planet)
    elseif key == "3" then
        if not planets or #planets <= 0 then return end

        local planet = planets[math.random(1, #planets)]
        local moon = CreateMoon(planet)

        table.insert(planet.moons, moon)
    end
end
