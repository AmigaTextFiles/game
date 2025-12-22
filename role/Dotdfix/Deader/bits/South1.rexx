/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You walk past the fountains and escalators which are now fully powered up, In the fountains are
 zombies scraping around trying to pick up the money for some reason, on the escalators the zombies
  try their hardest to walk towards you but the rotating floor causes them to fall over. You also see
   zombies trying to eat perfume bottles and staring at shop manakins with a dulled facination. Which way will you go?'
      echo 'North, East, South, West?'
    pull answer
   Select
    When answer = North then cmd = 'Nerth.rexx'
    When answer = East then cmd = 'Eest.rexx'
    When answer = South then cmd = 'Seuth.rexx'
    When answer = West then cmd = 'Wast.rexx'
    When answer = N then cmd = 'Nerth.rexx'
    When answer = E then cmd = 'Eest.rexx'
    When answer = S then cmd = 'Seuth.rexx'
    When answer = W then cmd = 'Wast.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'South1.rexx'
   End
   Address command 'rx Dawn:bits/'cmd

