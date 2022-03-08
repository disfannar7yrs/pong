player = {}

function player:load()
    self.x = Screen_w * 0.05 --STARTING POSITION
    self.y = Screen_h/2
    self.w = Screen_w * 0.025 --SIZE (W=WIDTH, H=HEIGHT)
    self.h = Screen_h * 0.2
    self.vely = 0   --CURRENT VELOCITY OF PLAYER PADDLE
    self.accel = 5 --ACCELERATION/HOW FAST TO REACH MAX SPEED
    self.maxspeed = 25
end

function check_bounds() --MAKES SURE PLAYER NEVER GOES BEYOND THE BOUNDARIES OF WINDOW
    if player.y <= 0 then
        player.y = 0
    elseif player.y >= Screen_h - player.h then
        player.y = Screen_h - player.h
    end
end

function player:update(dt)
    --UPDATE PLAYER SCALE COMPARED TO WINDOW SIZE
    self.x = Screen_w * 0.05
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
    check_bounds()
end

function player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end
