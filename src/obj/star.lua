function CreateStar()
    local SIZE = {
        M = math.random(10, 70),
        K = math.random(70, 100),
        GA = math.random(90, 300),
        B = math.random(300, 1500)
    }

    local star = {
        x = love.graphics.getWidth() / 2,
        y = love.graphics.getHeight() / 2,
        r = 0,
        temp = math.random(1000, 30000),
        type = nil,

        c = {}
    }

    if star.temp < 3500 then -- M
        star.c = { 1, 0, 0 }
        star.r = SIZE.M
        star.type = "M"
    elseif star.temp >= 3500 and star.temp < 5000 then -- K
        star.c = { 1, 0.5, 0 }
        star.r = SIZE.K
        star.type = "K"
    elseif star.temp >= 5000 and star.temp < 10000 then -- [G ; A]
        star.c = { 1, 1, 1 }
        star.r = SIZE.GA
        star.type = "from G to A"
    elseif star.temp >= 10000 then -- B
        star.c = { 0, 0, 1 }
        star.r = SIZE.B
        star.type = "B"
    end

    return star
end

function DrawStar(star)
    love.graphics.setColor(star.c[1], star.c[2], star.c[3])
    love.graphics.circle("fill", star.x, star.y, star.r)
end
