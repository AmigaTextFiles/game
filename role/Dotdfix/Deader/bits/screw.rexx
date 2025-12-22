/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You drive the screw driver into the Zombies ear and kill him almost instantly.....you head along the corridor further...'
      echo 'you can go North, South, East or West'
    pull answer
   Select
    When answer = North then cmd = 'Nor.rexx'
    When answer = N then cmd = 'Nor.rexx'
    When answer = South then cmd = 'Sou.rexx'
    When answer = S then cmd = 'Sou.rexx'
    When answer = East then cmd = 'Eas.rexx'
    When answer = E then cmd = 'Eas.rexx'
    When answer = West then cmd = 'Wes.rexx'
    When answer = W then cmd = 'Wes.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'screw.rexx'
   End
   Address command 'rx Dawn:bits/'cmd


   


   
