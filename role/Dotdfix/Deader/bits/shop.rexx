/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'you find yourself in a computer shop....which system would you like to play on?'
echo 'PC, Amiga, SNES, Playstation, Saturn, N64 ?'
    pull answer
   Select
    When answer = PC then cmd = 'pc.rexx'
    When answer = Amiga then cmd = 'Amiga.rexx'
    When answer = SNES then cmd = 'snes.rexx'
    When answer = playstation then cmd = 'psx.rexx'
    When answer = Saturn then cmd = 'saturn.rexx'
    When answer = N64 then cmd = 'n64.rexx'
    When answer = psx then cmd = 'psx.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'shop.rexx'
   End
   Address command 'rx Dawn:bits/'cmd

