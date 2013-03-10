 rem Touhou 2600
 rem By Aqua Kitty (AKA Reisen, Udonge)
 rem Source: sample.bas, which comes with batariBASIC
 include 6lives.asm
 const lives_compact=1
 const lives_centered=1
 set smartbranching on
 rem I took a crack at a title screen here
 player1:
  %01000010
  %10100101
  %10100101
  %10100101
  %00000000
  %01000010
  %10100101
  %10100101
  %10100101
  %01000010
  %00000000
  %01000101
  %01000101
  %01000111
  %11100101
end
  drawscreen
 rem Begin loop
Begin
 COLUP1=64:COLUP0=64
 player1x=48:player1y=48
 if joy0fire then goto Init
 drawscreen
 goto Begin
 rem End of Begin Loop
 rem Start of Init routine
Init
 player1x = 40 : player1y = 16:player0x = 50 : player0y = 50
 COLUPF = 90:missile0height = 4:missile0y = 255
 lives = 96
 score = 00000
 rem End of Init
 rem You get the point, this is where the Main loop begins.
Main
 COLUP0 = 64
 COLUP1 = 14
 scorecolor = 10
 rem had to insert lives here.
 lifecolor = 64
 lives:
  %00000000
  %00000000
  %00011000
  %00111100
  %01111110
  %11111111
  %11101111
  %01000110
end
 rem Reimu
 player0:
  %01100110
  %01100110
  %11111111
  %11111111
  %01111110
  %10111101
  %01111110
  %01111110
  %01111110
  %11111111
  %11111111
  %01111110
  %11111111
  %11100111
  %11011011
end
  rem Ghosty
  player1:
  %01110000
  %00111100
  %01111110
  %11011011
  %11011011
  %11111111
  %10111101
end
 a = a + 1 : if a < 3 then Preshot
 a = 0
 if player1y < player0y then player1y = player1y + 1
 if player1y > player0y then player1y = player1y - 1
 if player1x < player0x then player1x = player1x + 2
 if player1x > player0x then player1x = player1x - 2
 if player1x = player0x && player1y < player0y then player1y = player1y + 2
 player1x = player1x : player1y = player1y
Preshot
 if missile0y > 240 then goto Shot
 missile0y = missile0y - 2:goto Skipshot
Shot
 if joy0fire then missile0y = player0y - 2:missile0x = player0x + 4
Skipshot
 drawscreen
 if collision(missile0,player1) then score=score+1:player1x=rand/2:player1y=rand/4:missile0y=255
 if collision(player0,player1) then lives=lives-32:player0y=50:player0x=40:player1y=0:player1x=rand/2
 if joy0up then player0y = player0y - 2
 if joy0down then player0y = player0y + 2
 if joy0left then player0x = player0x - 2 
 if joy0right then player0x = player0x + 2
 if lives < 32 then goto Kaput
 if lives > 224 then lives = 224 
 if switchreset then goto Init
 goto Main
 rem End of Main Loop
 rem Endgame Loop
Kaput
 score=score
 if joy0fire then goto Init
 goto Kaput
 rem The End of The End
