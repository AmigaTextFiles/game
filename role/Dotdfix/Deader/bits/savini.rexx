/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'Savini is NOT amused.....You have been brought to Zombie Hell for swearing....'
 echo 'Do you wish to leave?'
    pull answer
   Select
    When answer = Yes then cmd = 'hellz.rexx'
    When answer = No then cmd = 'savini2.rexx'
    When answer = Y then cmd = 'hellz.rexx'
    When answer = N then cmd = 'savini2.rexx'
    Otherwise cmd = 'savini2.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
   
  

