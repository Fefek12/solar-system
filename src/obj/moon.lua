function CreateMoon(planet)
    local moon = { -- moon object
        c = {},

        x = 0,
        y = 0,
        r = 0,
        s = 0, -- degrees per second
        a = 0,
    }

    moon.r = math.random(planet.r / 10, planet.r / 4)
    moon.c = { math.random(255), math.random(255), math.random(255) }

    moon.s = math.random(planet.s / 2, planet.s * 2)

    return moon
end

function DrawMoon(planet, moon)
    if moon == planet.moons[1] then
        love.graphics.setColor(love.math.colorFromBytes(35, 35, 35))
        love.graphics.circle("line", planet.x, planet.y, planet.r * planet.pos)
    end

    love.graphics.setColor(love.math.colorFromBytes(moon.c[1], moon.c[2], moon.c[3]))
    love.graphics.circle("fill", moon.x, moon.y, moon.r)
end

function UpdateMoon(planet, moon, dt)
    moon.a = moon.a + (moon.s * dt)
    local distance = planet.r * planet.pos
    moon.x = planet.x + math.cos(math.rad(moon.a)) * distance
    moon.y = planet.y + math.sin(math.rad(moon.a)) * distance
end
