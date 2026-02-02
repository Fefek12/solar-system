--[[
        gravitation = yes
        position = good
        hakenr = no
        fps = 300
        moons = yes
        graphics = fire
]]

function love.load()
    Star = {
        x = love.graphics.getWidth() / 2,
        y = love.graphics.getHeight() / 2,
        r = 75,
    }
    Planets = {}
end

function love.update(dt)
    for _, planet in pairs(Planets) do
        planet.a = planet.a + (planet.s * dt)
        local distance = Star.r * planet.pos
        planet.x = Star.x + math.cos(math.rad(planet.a)) * distance
        planet.y = Star.y + math.sin(math.rad(planet.a)) * distance

        if planet.moons and #planet.moons > 0 then
            for _, moon in pairs(planet.moons) do
                moon.a = moon.a + (moon.s * dt)
                local moon_distance = planet.r * moon.pos
                moon.x = planet.x + math.cos(math.rad(moon.a)) * moon_distance
                moon.y = planet.y + math.sin(math.rad(moon.a)) * moon_distance
            end
        end
    end
end

function love.draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle("fill", Star.x, Star.y, Star.r)

    for _, planet in pairs(Planets) do
        love.graphics.setColor(love.math.colorFromBytes(35, 35, 35))
        love.graphics.circle("line", Star.x, Star.y, Star.r * planet.pos)
        love.graphics.setColor(love.math.colorFromBytes(planet.c[1], planet.c[2], planet.c[3]))
        love.graphics.circle("fill", planet.x, planet.y, planet.r)

        if planet.moons and #planet.moons > 0 then
            for _, moon in pairs(planet.moons) do
                love.graphics.setColor(love.math.colorFromBytes(35, 35, 35))
                love.graphics.circle("line", planet.x, planet.y, planet.r * moon.pos)
                love.graphics.setColor(love.math.colorFromBytes(moon.c[1], moon.c[2], moon.c[3]))
                love.graphics.circle("fill", moon.x, moon.y, moon.r)
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
        local planet = {
            pos = 0, -- star is the first element of solar system
            c = {},

            x = 0,
            y = 0,
            r = 0,
            s = 0, -- degrees per second
            a = 0,

            moons = {}
        }

        local position = 2
        for i in pairs(Planets) do
            position = position + 2
        end

        planet.pos = position
        planet.r = math.random(Star.r / 10, Star.r / 4)
        planet.s = math.random(20, 100)
        planet.c = { math.random(255), math.random(255), math.random(255) }

        table.insert(Planets, planet)
    elseif key == "2" then
        if not Planets or #Planets <= 0 then return end

        local moon = {
            c = {},

            x = 0,
            y = 0,
            r = 0,
            s = 0, -- degrees per second
            a = 0,
        }

        local planet = Planets[math.random(1, #Planets)]

        moon.pos = planet.pos
        moon.r = math.random(planet.r / 10, planet.r / 4)
        moon.s = math.random(planet.s / 2, planet.s * 2)
        moon.c = { math.random(255), math.random(255), math.random(255) }

        table.insert(planet.moons, moon)
    end
end
