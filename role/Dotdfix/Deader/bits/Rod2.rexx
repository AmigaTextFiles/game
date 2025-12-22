/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You grab the metal Rod and smash the Zombies head off with one blow. Its corpse falls to the ground and you see a hoard of flesh eating zombies coming towards you...'
echo 'North & South are the only safe options...which way?'
    pull answer
   Select
    When answer = North then cmd = 'shop.rexx'
    When answer = South then cmd = 'fun.rexx'
    When answer = N then cmd = 'shop.rexx'
    When answer = S then cmd = 'fun.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'Rod2.rexx'
   End
   Address command 'rx Dawn:bits/'cmd

