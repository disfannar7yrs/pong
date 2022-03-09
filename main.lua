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
  love.graphics.setDefaultFilter("nearest")
  G_over = false
  winner = nil
  player:load()
  ai:load()
  ball:load()
end

function whois_winner()
  if Player_score > AI_score then
    winner = "PLAYER WINS"
  elseif Player_score < AI_score then
    winner = "COMPUTER WINS"
  else
    winner = "DRAW"
  end
end

function love.update(dt)
  whois_winner()
  Screen_w = love.graphics.getWidth()
  Screen_h = love.graphics.getHeight()
  if not G_over then
    player:update(dt)
    ai:update(dt)
    ball:update(dt)
  else
    if love.keyboard.isDown('space') then
      Player_score = 0
      AI_score = 0
      G_over = false
    end
  end
  if Player_score >= 10
  or AI_score >= 10 then
    G_over = true
  end
end

function love.draw()
  love.graphics.print(Player_score, (Screen_w/2)-(Screen_w*0.2), Screen_h*0.025,0, 10, 10)
  love.graphics.print(AI_score, (Screen_w/2)+(Screen_w*0.1), Screen_h*0.025,0, 10, 10)

  player:draw()
  ai:draw()
  ball:draw()
  if G_over then
    love.graphics.print(winner,0, Screen_h/2,0,8,8)
    love.graphics.print("Press spacebar to Go Again", Screen_w/2, Screen_h/4)
  end
end
