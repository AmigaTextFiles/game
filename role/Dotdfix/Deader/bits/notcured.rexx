/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You were on the verge of recovery but slowly you begin to feel groggy and sluggish. Seconds later you are a flesh eating zombie again, your craving for human flesh grows...'
echo 'east or west?'
   pull answer
   Select
    When answer = East then cmd = 'east.rexx'
    When answer = E then cmd = 'east.rexx'
    When answer = West then cmd = 'west.rexx'
    When answer = W then cmd = 'west.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'notcured.rexx'
   End
   Address command 'rx Dawn:bits/'cmd

   
  

