require("math")
require("player")
local ai = require "ai"
local ball = require "ball"

function lerp(a,b,t)
  return a*(1-t)+(t*b)
end

function love.load()
  Screen_w = love.graphics.getWidth()
  Screen_h = love.graphics.getHeight()
  player:load()
end

function love.update(dt)
  Screen_w = love.graphics.getWidth()
  Screen_h = love.graphics.getHeight()
  
  player:update(dt)
  --[[  ai:update(dt)
  ball:update(dt) ]]
end

function love.draw()
  player:draw()
  print(player.vely)
  --[[ ai:draw()
  ball:draw() ]]
end
