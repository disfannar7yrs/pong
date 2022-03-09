player = {}

function player:load()
    self.w = Screen_w * 0.025 --STÆRÐ SPAÐA SPILARA (W=WIDTH=BREIDD, H=HEIGHT=HÆÐ)
    self.h = Screen_h * 0.2
    self.x = self.w*2 --STAÐSETNING SPAÐA Á X ÁS
    self.y = (Screen_h/2)-(self.h/2) --UPPHAFSPUNKTUR SPAÐA Á Y ÁS
    self.center = (self.y+self.h)/2 --MIÐJA SPAÐA
    self.vely = 0   --NÚVERANDI HRAÐI
    self.accel = 2 --HRÖÐUN SPILARA (HVERSU HRATT HANN KEMST UPP Í HÁMARKSHRAÐA)
    self.maxspeed = 12 --HÁMARKSHRAÐI
end

function player:check_bounds() --GENGUR Í SKUGGA UM AÐ SPAÐI FARI ALDREI ÚT FYRIR GLUGGAMÖRK
    if self.y <= 0 then
        self.y = 0
    elseif self.y + self.h >= Screen_h then
        self.y = Screen_h - self.h
    end
end

function player:update(dt)
    self.center = self.y+(self.h/2) --UPPFÆRA STAÐSETNINGU MIÐJU SPAÐANS Á Y ÁS
    player:check_bounds()
    --UPPFÆRA STÆRÐ SPAÐANS MIÐAÐ VIÐ GLUGGASTÆRÐ
    self.x = self.w*2
    self.w = Screen_w * 0.025
    self.h = Screen_h * 0.2
    --HREYFING
    self.y = self.y + self.vely --HREYFING ER STAÐSETNING + HRAÐI
    if love.keyboard.isDown('down') then --EF VIÐ ÝTUM Á ÖRINA NIÐUR Á LYKLABORÐINU FER SPAÐINN NIÐUR
        self.vely = self.vely + self.accel
        if self.vely >= self.maxspeed then --PÖSSUM AÐ HRAÐI SPAÐA VERÐI ALDREI HÆRRI EN HÁMARKSHRAÐI
            self.vely = self.maxspeed
        end
    elseif love.keyboard.isDown('up') then --ÝTUM Á ÖRINA UPP TIL AÐ SPAÐI FARI UPP
        self.vely = self.vely - self.accel
        if self.vely <= -self.maxspeed then --PÖSSUM AÐ NEIKVÆÐUR HRAÐI SÉ ALDREI MINNI EN MÍNUS HÁMARKSHRAÐI
            self.vely = -self.maxspeed
        end
    else
        self.vely = lerp(self.vely, 0, 0.2) --EF VIÐ SLEPPUM ÖRVATÖKKUNUM HÆGIR SPILARI Á SÉR Í STAÐ ÞESS AÐ SNARSTANSA
    end
end

function player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h) --HÉR TEIKNUM VIÐ SPAÐA SPILARANS
end
