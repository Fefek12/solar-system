local function execute(planets)
    local executed = {}

    for _, planet in pairs(planets) do
        print("Planet", planet.pos, ":", planet.r)
        table.insert(executed, planet)
    end

    if #executed > 0 then return true end
end

function DrawPlanet(Star, planet)
    love.graphics.setColor(love.math.colorFromBytes(35, 35, 35))
    love.graphics.circle("line", Star.x, Star.y, Star.r * planet.pos)
    love.graphics.setColor(love.math.colorFromBytes(planet.c[1], planet.c[2], planet.c[3]))
    love.graphics.circle("fill", planet.x, planet.y, planet.r)
end

function UpdatePlanet(star, planet, dt)
    planet.a = planet.a + (planet.s * dt)
    local distance = star.r * planet.pos
    planet.x = star.x + math.cos(math.rad(planet.a)) * distance
    planet.y = star.y + math.sin(math.rad(planet.a)) * distance
end

function CreatePlanet(star, planets, pos)
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
        for i in pairs(planets) do
            position = position + 2
        end
    else
        position = pos
    end

    planet.pos = position
    planet.r = math.random(star.r / 10, star.r / 4)
    planet.s = math.random(20, 100)
    planet.c = { math.random(255), math.random(255), math.random(255) }

    return planet
end

function PlanetsChanged(planets, star)
    for i in pairs(planets) do
        table.remove(planets, i)
    end
    if execute(planets) then PlanetsChanged(planets, star) end
end
