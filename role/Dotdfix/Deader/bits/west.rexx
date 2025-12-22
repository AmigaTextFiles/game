/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'A human pops out and shoots you in the chest....you crawl along with your vital organs hanging out of your body.....which way?'
echo 'east or west?'
   pull answer
   Select
    When answer = West then cmd = 'cured.rexx'
    When answer = W then cmd = 'cured.rexx'
    When answer = East then cmd = 'food.rexx'
    When answer = E then cmd = 'food.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'west.rexx'
   End
   Address command 'rx Dawn:bits/'cmd

   
  

