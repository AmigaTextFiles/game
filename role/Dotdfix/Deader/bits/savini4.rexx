/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'Gaylen Ross and Scott H. Reiniger enter the room, they pull you to the floor and inflict lots of pain of you, weve got this man weve got this by the ass, they yell...'
 echo 'Do you wish to leave?'
    pull answer
   Select
    When answer = Yes then cmd = 'hellz.rexx'
    When answer = No then cmd = 'savini5.rexx'
    When answer = Y then cmd = 'hellz.rexx'
    When answer = N then cmd = 'savini5.rexx'
    Otherwise cmd = 'savini5.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
   
  

