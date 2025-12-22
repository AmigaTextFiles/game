/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You stumble along with 5 other zombies and struggle to remember life as a human....where can you get more warm flesh?'
echo 'east or west?'
   pull answer
   Select
    When answer = West then cmd = 'cured.rexx'
    When answer = W then cmd = 'cured.rexx'
    When answer = East then cmd = 'dead.rexx'
    When answer = E then cmd = 'dead.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'east.rexx'
   End
   Address command 'rx Dawn:bits/'cmd

   
  

