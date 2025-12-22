/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'Ken Foree and David Emge grab you by the hair and kick you in the groin.....you aint just in here on your own boy!'
 echo 'Do you wish to leave?'
    pull answer
   Select
    When answer = Yes then cmd = 'hellz.rexx'
    When answer = No then cmd = 'savini4.rexx'
    When answer = Y then cmd = 'hellz.rexx'
    When answer = N then cmd = 'savini4.rexx'
    Otherwise cmd = 'savini4.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
   
  

