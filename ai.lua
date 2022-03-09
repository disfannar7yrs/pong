ai = {}

function ai:load()
    self.w = Screen_w * 0.025 --STÆRÐ SPAÐA TÖLVUNNAR
    self.h = Screen_h * 0.2
    self.x = Screen_w-(self.w*3) --UPPHAFSPUNKTUR TÖLVNNAR
    self.y = (Screen_h/2)-(self.h/2)
    self.vely = 0   --NÚVERANDI HRAÐI TÖLVUNNAR
    self.accel = 1 --HRÖÐUN TÖLVUNNAR (HVERSU HRATT HÚN FER UPP Í HÁMARKSHRAÐA)
    self.maxspeed = 10 --HÁMARKSHRAÐI
end

function ai:check_bounds() --ÞETTA FUNCTION GENGUR Í SKUGGA UM AÐ SPAÐI TÖLVUNNR FARI ALDREI ÚT FYRIR GLUGGAMÖRK
    if self.y <= 0 then
        self.y = 0
    elseif self.y >= Screen_h - self.h then
        self.y = Screen_h - self.h
    end
end

function ai:update(dt)
    ball_pos = ball.y + (ball.h/2) --STANSLAUST UPPFÆRÐ STAÐSETNING MIÐPUNKTS BOLTANS
    self.center = self.y+(self.h/2)
    --UPPFÆRA STÆRÐ SPAÐA MIÐAÐ VIÐ GLUGGASTÆRÐ
    self.x = Screen_w-(self.w*3)
    self.w = Screen_w * 0.025
    self.h = Screen_h * 0.2
    --HREYFING
    self.y = self.y + self.vely --HREYFING ER STAÐSETNING + HRAÐI
    ai:check_bounds()
    if ball.dx > 0 then --EF BOLTI STEFNIR Í ÁTT AÐ SPAÐA TÖLVU OG FER ÚT FYRIR MÖRK SPAÐANS Á Y ÁS ÞÁ FÆRIR TÖLVA SPAÐAN TIL AÐ VERJAST
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
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h) --HÉR TEIKNUM VIÐ SPAÐA TÖLVUNNAR
end
