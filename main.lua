_G.love= require "love"

local Crab=require "Entities/Crab" crab=Crab

function love.load()
end

function love.update(dt)
    crab.UpperHand:update(crab)
    crab.LowerHand:update(crab)
end

function love.draw()
    crab.Body:draw()
    crab.Body.Hitbox:draw()
    crab.UpperHand:draw()
    crab.LowerHand:draw()
end

function love.keypressed(key)
    if key=="w" or key=="up" then
        crab.is_attacking_upper=true
    end
    if key=="down" or key=="down" then
        crab.is_attacking_lower=true
    end
end

function love.keyreleased(key)
    --[[if key=="w" or key=="up" then
        crab.is_attacking_upper=false
    end
    if key=="down" or key=="down" then
        crab.is_attacking_lower=false
    end--]]
end