ball = {}

function load:load()
    self.x = Screen_w/2
    self.y = Screen_h/2
    self.dx = 0
    self.dy = 0
    self.w = Screen_w * 0.025
    self.x = Screen_h * 0.025
    self.speed = 10
end

function ball:update(dt)
    -- UPDATE BALL SIZE COMPARED TO SCREEN SIZE
    self.w = Screen_w * 0.025
    self.x = Screen_h * 0.025
end

function ball:draw()
    love.graphics.rectangle("fill", ball.x, ball.y, ball.w, ball.h)
end
