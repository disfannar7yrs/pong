local player = require "player"
local ai = require "ai"
local ball = require "ball"

function love.load()

end

function love.update(dt)
  player:update(dt)
  ai:update(dt)
  ball:update(dt)
end

function love.draw()
  player:draw()
  ai:draw()
  ball:draw()
end
