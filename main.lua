require("player")
require("ai")
require("ball")

function lerp(a,b,t)
  return a*(1-t)+(t*b)
end

function love.load()
  Screen_w = love.graphics.getWidth()
  Screen_h = love.graphics.getHeight()
  Player_score = 0
  AI_score = 0
  player:load()
  ai:load()
  ball:load()
end

function love.update(dt)
  Screen_w = love.graphics.getWidth()
  Screen_h = love.graphics.getHeight()

  player:update(dt)
  ai:update(dt)
  ball:update(dt)
end

function love.draw()
  love.graphics.print(Player_score, Screen_w/4, Screen_h/2,0, 10, 10)

  player:draw()
  ai:draw()
  ball:draw()
end
