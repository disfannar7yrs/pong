ai = {}

function ai:load()
    self.w = Screen_w * 0.025 --AI PADDLE SIZE (WIDTH/HEIGHT)
    self.h = Screen_h * 0.2
    self.x = Screen_w-(self.w*3) --AI STARTING POSITION (X/Y)
    self.y = (Screen_h/2)-(self.h/2)
    self.vely = 0   --AI CURRENT SPEED
    self.accel = 1 --AI ACCELERATION/HOW FAST TO REACH MAX SPEED
    self.maxspeed = 10
end

function ai:check_bounds() --MAKES SURE AI NEVER GOES BEYOND THE BOUNDARIES OF WINDOW
    if self.y <= 0 then
        self.y = 0
    elseif self.y >= Screen_h - self.h then
        self.y = Screen_h - self.h
    end
end

function ai:update(dt)
    ball_pos = ball.y + (ball.h/2) --GET BALL'S CENTER POSITION
    self.center = self.y+(self.h/2)
    --UPDATE AI SCALE COMPARED TO WINDOW SIZE
    self.x = Screen_w-(self.w*3)
    self.w = Screen_w * 0.025
    self.h = Screen_h * 0.2
    --MOVEMENT
    self.y = self.y + self.vely
    ai:check_bounds()
    if ball.dx > 0 then
        if ball_pos < self.y then
            self.vely = self.vely - self.accel
            if self.vely <= -self.maxspeed then
                self.vely = -self.maxspeed
            end
        elseif ball_pos > self.y+self.h then
            self.vely = self.vely + self.accel
            if self.vely >= self.maxspeed then
                self.vely = self.maxspeed
            end
        else
            self.vely = lerp(self.vely, 0, 0.01)
        end
    end
end

function ai:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end
