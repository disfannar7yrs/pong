require("player") --HÉR BENDUM VIÐ Á ÞAU SKJÖL SEM ÞETTA SKJAL ÞARF AÐ VÍSA Í
require("ai")
require("ball")

function lerp(a,b,t) --LÍNULEG BRÚUN. ÞESSA FORMÚLU MUNUM VIÐ NOTA SVO ÞEGAR LEIKMENN HÆTTA AÐ HREYFA SIG HÆGJA ÞEIR Á SÉR Í STAÐ ÞESS AÐ SNARSTOPPA
  return a*(1-t)+(t*b) --A=NÚVERANDI HRAÐI, B=HRAÐINN SEM VIÐ VILJUM (0 Í OKKAR TILFELLI), T=TÍMI
end

function love.load() --HÉR HLÖÐUM VIÐ INN ÝMSAR UPPLÝSINGAR SEM VIÐ ÞURFUM ÞEGAR LEIKUR ER RÆSTUR
  Screen_w = love.graphics.getWidth() --SETJUM BREIDD GLUGGA INN Í BREYTU TIL AÐ NOTA ANNARS STAÐAR
  Screen_h = love.graphics.getHeight() --SAMA MEÐ HÆÐ GLUGGA
  Player_score = 0 --STIG LEIKMANNS
  AI_score = 0 --STIG TÖLVU
  love.graphics.setDefaultFilter("nearest") --HÉR SEGJUM VIÐ HVERNIG TÖLVAN Á AÐ STÆKKA MYNDIR OG TEXTA
  G_over = false --ER LEIK LOKIÐ
  winner = nil --BÚUM TIL BREYTUNA WINNER SEM VIÐ SVO FYLUM INN Í HÉR SÍÐAR
  player:load() --FÁUM UPPLÝSINGAR ÚR LOAD FUNCTION Í PLAYER.LUA
  ai:load()
  ball:load()
end

function whois_winner() --HVOR ER MEÐ HÆRRI STIG
  if Player_score > AI_score then
    winner = "ÞÚ VANNST :)"
  elseif Player_score < AI_score then
    winner = "TÖLVAN VANN :("
  else
    winner = "JAFNTEFLI"
  end
end

function love.update(dt) --HÉR SETJUM VIÐ INN KÓÐA OG ÚTREIKNINGA SEM ÞARF AÐ UPPFÆRA 60 SINNUM Á SEKUNDU. HÉR GERAST TÖFRARNIR
  whois_winner() --HÖLDUM ÚTI HVOR ER YFIR
  Screen_w = love.graphics.getWidth() --UPPFÆRUM GLUGGASTÆRÐ
  Screen_h = love.graphics.getHeight()
  if not G_over then --EF LEIK ER EKKI LOKIÐ KEYRUM VIÐ UPDATE FUNCTION ÚR ÖÐRUM SKRÁM
    player:update(dt)
    ai:update(dt)
    ball:update(dt)
  else --ANNARS FER LEIKURINN Í PÁSU
    if love.keyboard.isDown('space') then --ÞAR TIL VIÐ ÝTUM Á SPACE
      Player_score = 0 --ÞÁ NÚLLSTILLUM VIÐ SKORIÐ
      AI_score = 0
      G_over = false --OG LEYFUM LEIKNUM AÐ KEYRA Á NÝ
    end
  end
  if Player_score >= 10 --EF ANNAR LEIKMAÐUR NÆR 10 STIGUM ER LEIKI LOKIÐ
  or AI_score >= 10 then
    G_over = true
  end
end

function love.draw() --HÉR TEIKNUM VIÐ SVO ALLA GRAFÍK Á SKJÁINN
  love.graphics.print(Player_score, (Screen_w/2)-(Screen_w*0.2), Screen_h*0.025,0, 10, 10) --HÖFUM STIGIN ALLTAF UPPI
  love.graphics.print(AI_score, (Screen_w/2)+(Screen_w*0.1), Screen_h*0.025,0, 10, 10)

  player:draw() --FÁUM HVAÐ ÞARF AÐ TEIKNA ÚR ÖÐRUM SKRÁM
  ai:draw()
  ball:draw()
  if G_over then -- EF LEIK ER LOKIÐ SKRIFUM ÞÁ EFTIRFARANDI Á SKJÁINN
    love.graphics.print(winner,0, Screen_h/2,0,8,8)
    love.graphics.print("ÝTTU Á SPACE TIL AÐ SPILA AFTUR", Screen_w/2, Screen_h/4)
  end
end
