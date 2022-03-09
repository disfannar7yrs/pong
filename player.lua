player = {}

function player:load()
    self.w = Screen_w * 0.025 --SIZE (W=WIDTH, H=HEIGHT)
    self.h = Screen_h * 0.2
    self.x = self.w*2 --POSITION FROM WALL
    self.y = (Screen_h/2)-(self.h/2) --STARTING POSITION
    self.center = (self.y+self.h)/2
    self.vely = 0   --CURRENT VELOCITY OF PLAYER PADDLE
    self.accel = 2 --ACCELERATION/HOW FAST TO REACH MAX SPEED
    self.maxspeed = 12
end

function player:check_bounds() --MAKES SURE PLAYER NEVER GOES BEYOND THE BOUNDARIES OF WINDOW
    if self.y <= 0 then
        self.y = 0
    elseif self.y + self.h >= Screen_h then
        self.y = Screen_h - self.h
    end
end

function player:update(dt)
    self.center = self.y+(self.h/2)
    player:check_bounds()
    --UPDATE PLAYER SCALE COMPARED TO WINDOW SIZE
    self.x = self.w*2
    self.w = Screen_w * 0.025
    self.h = Screen_h * 0.2
    --MOVEMENT
    self.y = self.y + self.vely
    if love.keyboard.isDown('down') then
        self.vely = self.vely + self.accel
        if self.vely >= self.maxspeed then
            self.vely = self.maxspeed
        end
    elseif love.keyboard.isDown('up') then
        self.vely = self.vely - self.accel
        if self.vely <= -self.maxspeed then
            self.vely = -self.maxspeed
        end
    else
        self.vely = lerp(self.vely, 0, 0.2) --LINEAR INTERPOLATION TO SLOW PLAYER SOFTLY DOWN TO ZERO IF NO BUTTON IS PRESSED
    end
end

function player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end
