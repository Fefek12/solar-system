local function debug(Planets)
    local planets = {}

    for _, planet in pairs(Planets) do
        print("Planet", planet.pos, ":", planet.r)
        table.insert(planets, planet)
    end

    if #planets > 0 then return true end
end

function DrawPlanet(Star, planet)
    love.graphics.setColor(love.math.colorFromBytes(35, 35, 35))
    love.graphics.circle("line", Star.x, Star.y, Star.r * planet.pos)
    love.graphics.setColor(love.math.colorFromBytes(planet.c[1], planet.c[2], planet.c[3]))
    love.graphics.circle("fill", planet.x, planet.y, planet.r)
end

function UpdatePlanet(Star, planet, dt)
    planet.a = planet.a + (planet.s * dt)
    local distance = Star.r * planet.pos
    planet.x = Star.x + math.cos(math.rad(planet.a)) * distance
    planet.y = Star.y + math.sin(math.rad(planet.a)) * distance
end

function CreatePlanet(Star, Planets, pos)
    local planet = { -- planet object
        pos = 0,     -- star is the first element of solar system
        c = {},

        x = 0,
        y = 0,
        r = 0,
        s = 0, -- degrees per second
        a = 0,

        moons = {}
    }

    local position
    if not pos then
        position = 2
        for i in pairs(Planets) do
            position = position + 2
        end
    else
        position = pos
    end

    planet.pos = position
    planet.r = math.random(Star.r / 10, Star.r / 4)
    planet.s = math.random(20, 100)
    planet.c = { math.random(255), math.random(255), math.random(255) }

    return planet
end

function PlanetsChanged(Planets, Star)
    for i in pairs(Planets) do
        table.remove(Planets, i)
    end
    if debug(Planets) then PlanetsChanged(Planets, Star) end
end
