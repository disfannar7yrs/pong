ball = {}

function kickoff() --BALL CONDITION AT GAME START OR AFTER GOAL
    dir = {1, -1}
    ball.x = (Screen_w/2)-(ball.w/2)
    ball.y = (Screen_h/2)-(ball.h/2)
    ball.dx = math.random(#dir)
    ball.dy = 0
    ball.speed = 4
    ball.game_on = true
end

function ball:load()
    self.w = Screen_w * 0.025
    self.h = Screen_h * 0.025
    kickoff()
end

--COLLISION FUNCTIONS:
function player_collision() --CHECKS WHEN BALL MEETS PADDLE ON THE X AXIS, IF BALL IS LOWER THAN TOP OF PADDLE AND HIGHER THAN BOTTOM. IF SO RETURNS TRUE.
    if ball.x <= player.x + player.w and ball.x + ball.w >= player.x then
        if ball.y + ball.h >= player.y and ball.y <= player.y + player.h then
           return true 
        end
    end
end

function player_angle() --GETS ANGLE OF BALL'S BOUNCE BACK ON COLLISION WITH PLAYER PADDLE BASED ON WHERE ON PADDLE THE COLLISION TAKES PLACE
    plr_center = player.center
    ball_center = ball.y + (ball.h/2)
    if ball_center < plr_center then
        dist = (plr_center-ball_center)/(player.h/2)
        ball.dy = -(ball.speed*dist)
    elseif ball_center > plr_center then
        dist = (ball_center-plr_center)/(player.h/2)
        ball.dy = ball.speed*dist
    end
end

function ai_collision() --SAME AS PLAYER_COLLISION() BUT FOR AI PADDLE
    if ball.x + ball.w >= ai.x and ball.x <= ai.x + ai.w then
        if ball.y + ball.h >= ai.y and ball.y <= ai.y + ai.h then
           return true 
        end
    end
end

function ai_angle() --SAME AS PLAYER_ANGLE() BUT FOR AI PADDLE
    ai_center = ai.center
    ball_center = ball.y + (ball.h/2)
    if ball_center < ai_center then
        dist = (ai_center-ball_center)/(ai.h/2)
        ball.dy = -(ball.speed*dist)
    elseif ball_center > ai_center then
        dist = (ball_center-ai_center)/(ai.h/2)
        ball.dy = ball.speed*dist
    end
end

function border_collision() --IF BALL HITS TOP OR BOTTOM SCREEN BOUNDARIES, REVERSE MOTION ON Y AXIS
    if ball.y <= 0 or 
    ball.y + ball.h > Screen_h then
        ball.dy = ball.dy * -1
    end
end
--------

function goals() --IF BALL GOES OFF EITHER SIDE OF SCREEN GIVE POINT TO THE PADDLE ON THE OTHER SIDE
    if ball.x > Screen_w then
        if ball.game_on then
            Player_score = Player_score + 1
            ball.game_on = false
            kickoff()
        end
    elseif ball.x + ball.h < 0 then
        if ball.game_on then
            AI_score = AI_score + 1
            ball.game_on = false
            kickoff()
        end
    end
end

function ball:update(dt)
    self.w = Screen_w * 0.025
    self.h = self.w
    --MOVEMENT
    self.x = self.x + self.dx
    self.y = self.y + self.dy
    self.dx = self.dx * self.speed
    if self.dx >= self.speed then
        self.dx = self.speed
    elseif self.dx <= -self.speed then
        self.dx = -self.speed
    end
    if self.dy >= self.speed then
        self.dy = self.speed
    elseif self.dy <= -self.speed then
        self.dy = -self.speed
    end
    --COLLISION
    if player_collision() then
        self.dx = self.dx * -1
        player_angle()
        self.speed = self.speed + 0.25
    end
    if ai_collision() then
        self.dx = self.dx * -1
        ai_angle()
        self.speed = self.speed + 0.25
    end
    border_collision()

    goals()
end

function ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end