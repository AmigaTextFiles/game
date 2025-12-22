/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'Tom Savini enters the room, followed by George A. Romero.....They strike you to the floor and proceed to beat you up....'
 echo 'Do you wish to leave?'
    pull answer
   Select
    When answer = Yes then cmd = 'hellz.rexx'
    When answer = No then cmd = 'savini3.rexx'
    When answer = Y then cmd = 'hellz.rexx'
    When answer = N then cmd = 'savini3.rexx'
    Otherwise cmd = 'savini3.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
   
  

