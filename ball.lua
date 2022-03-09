ball = {}

function kickoff() --ÁSTAND BOLTA Í UPPHAFI HVERRAR LOTU
    dir = {1, -1} --LISTI YFIR BÁÐAR MÖGULEGAR ÁTTIR X ÁSS
    ball.x = (Screen_w/2)-(ball.w/2) --UPPHAFSPUNKTUR BOLTA
    ball.y = (Screen_h/2)-(ball.h/2)
    ball.dx = math.random(#dir) --VELJUM AF HANDAHÓFI AÐRA HVORA ÁTTINA ÚR LISTANUM AÐ OFAN BOLTI STEFNIR Í UPPHAFI LOTU
    ball.dy = 0
    ball.speed = 4 --HRAÐI BOLTA
    ball.game_on = true
end

function ball:load()
    self.w = Screen_w * 0.025 --STÆRÐ BOLTA
    self.h = Screen_h * 0.025
    kickoff()
end

--HÉR KOMA NOKKUR FUNCTION SEM RÁÐA ÚR ÁREKSTRUM:
function player_collision()  --ÞETTA FUNCTION SPYR HVORT BOLTI HAFI REKIST Í SPAÐA SPILARA
    if ball.x <= player.x + player.w and ball.x + ball.w >= player.x then --EF BOLTI ER LENGRA TIL VINSTRI EN HÆGRI HLIÐ SPAÐA OG LENGRA TIL HÆGRI EN VINSTRI HLIÐ SPAÐA
        if ball.y + ball.h >= player.y and ball.y <= player.y + player.h then --ÞÁ EF BOLTI ER LÍKA STAÐSETTUR LÆGRA EN TOPPUR SPAÐA OG HÆRRA EN BOTN HANS
           return true --ÞÁ ER ÞETTA FUNCTION SATT
        end
    end
end

function player_angle() --HÉR ÁVEÐUM VIÐ Í HVAÐA ÁTT BOLTI SKOPPAR AF SPAÐA SPILARA
    plr_center = player.center
    ball_center = ball.y + (ball.h/2)
    if ball_center < plr_center then --EF BOLTI LENDIR FYRIR OFAN MIÐJU SPAÐA
        dist = (plr_center-ball_center)/(player.h/2) --HÉR DEILUM VIÐ FJARLÆGÐ BOLTANS FRÁ MIÐJU SPAÐA Í HELMINGS HÆÐ SPAÐANS OG FÁUM HLUTFALL SEM
        ball.dy = -(ball.speed*dist) --VIÐ MARGFÖLDUM SVO HÉR MEÐ HRAÐA BOLTANS OG NOTUM TIL AÐ FÁ HRAÐA BOLTA Á Y ÁS
    elseif ball_center > plr_center then
        dist = (ball_center-plr_center)/(player.h/2)
        ball.dy = ball.speed*dist
    end
end

function ai_collision() --SAMA OG PLAYER_COLLISION() NEMA FYRIR SPAÐA TÖLVUNNAR
    if ball.x + ball.w >= ai.x and ball.x <= ai.x + ai.w then
        if ball.y + ball.h >= ai.y and ball.y <= ai.y + ai.h then
           return true 
        end
    end
end

function ai_angle() --SAMA OG PLAYER_ANGLE() NEMA FYRIR SPAÐA TÖLVUNNAR
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

function border_collision() --EF BOLTI LENDIR Á TOPPI EÐA BOTNI GLUGGA ÞÁ LÁTUM VIÐ HANN SKOPPA TL BAKA Á Y ÁS
    if ball.y <= 0 or 
    ball.y + ball.h > Screen_h then
        ball.dy = ball.dy * -1
    end
end
--------

function goals() --EF BOLTI FER ÚT FYRIR GLUGGAMÖRK Á VINSTRI EÐA HÆGRI KANTI FÆR ANNAR KEPPINAUTUR STIG
    if ball.x > Screen_w then --EF BOLTI FER ÚTAF HÆGRA MEGIN
        if ball.game_on then 
            Player_score = Player_score + 1 --ÞÁ FÆR LEIKMAÐUR STIG
            ball.game_on = false --HÉR SLÖKKVUM VIÐ Á GAME_ON BREYTUNNI TIL AÐ PASSA AÐ TÖLVAN SKRÁI BARA EITT STIG
            kickoff() --BYRJUM NÆSTU LOTU
        end
    elseif ball.x + ball.h < 0 then --EF BOLTI FER ÚTAF VINSTRA MEGIN
        if ball.game_on then
            AI_score = AI_score + 1 --ÞÁ FÆR TÖLVAN STIG
            ball.game_on = false
            kickoff()
        end
    end
end

function ball:update(dt)
    self.w = Screen_w * 0.025 --HÉR UPPFÆRUM VIÐ STÆRÐ BOLTA ÚTFRÁ GLUGGASTÆRÐ
    self.h = self.w
    --HREYFING
    self.x = self.x + self.dx --HREYFING ER STAÐSETNING + HRAÐI
    self.y = self.y + self.dy
    self.dx = self.dx * self.speed
    if self.dx >= self.speed then --PÖSSUM AÐ HRAÐINN FARI ALDREI YFIR HÁMARKSHRAÐA
        self.dx = self.speed
    elseif self.dx <= -self.speed then
        self.dx = -self.speed
    end
    if self.dy >= self.speed then
        self.dy = self.speed
    elseif self.dy <= -self.speed then
        self.dy = -self.speed
    end
    --ÁREKSTRAR
    if player_collision() then --EF BOLTI REKST Á SPAÐA SPILARANS
        self.dx = self.dx * -1 --SKJÓTUM VIÐ BOLTANUM Í ÖFUGA ÁTT Á X ÁS
        player_angle() --SVO NOTUM VIÐ ÞETTA FUNCTION TIL AÐ FÁ ÁTT BOLTANS Á Y ÁS
        self.speed = self.speed + 0.25 --BOLTI EYKUR HRAÐA UM 0.25 Í HVERT SINN SEM HANN LENDIR Á SPAÐA
    end
    if ai_collision() then --SAMA OG HÉR AÐ OFAN NEMA FYRIR TÖLVUNA
        self.dx = self.dx * -1
        ai_angle()
        self.speed = self.speed + 0.25
    end
    border_collision()

    goals()
end

function ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h) --HÉR TEIKNUM VIÐ BOLTANN
end