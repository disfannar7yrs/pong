ai = {}

function ai:load()
    self.w = Screen_w * 0.025 --AI PADDLE SIZE (WIDTH/HEIGHT)
    self.h = Screen_h * 0.2
    self.x = Screen_w-(self.w*3) --AI STARTING POSITION (X/Y)
    self.y = (Screen_h/2)-(self.h/2)
    self.vely = 0   --AI CURRENT SPEED
    self.accel = 5  --AI ACCELERATION/HOW FAST TO REACH MAX SPEED
    self.maxspeed = 25
end

function check_bounds() --MAKES SURE AI NEVER GOES BEYOND THE BOUNDARIES OF WINDOW
    if ai.y <= 0 then
        ai.y = 0
    elseif ai.y >= Screen_h - ai.h then
        ai.y = Screen_h - ai.h
    end
end

function ai:update(dt)
    self.center = self.y+(self.h/2)
    --UPDATE AI SCALE COMPARED TO WINDOW SIZE
    self.x = Screen_w-(self.w*3)
    self.w = Screen_w * 0.025
    self.h = Screen_h * 0.2
    --MOVEMENT
    self.y = self.y + self.vely
    check_bounds()
end

function ai:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end
