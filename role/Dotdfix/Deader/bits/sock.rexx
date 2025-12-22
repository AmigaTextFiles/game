/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
 echo 'You run down the corridor shooting on coming zombies with your gun...and dodging lunging attacks from their scabby hands.....A large door blocks your way...'
echo '[PUSH RETURN]'
 pull answer
echo 'You pull out a rocket and prepare to fire it...it could be risky....do you really want to do this?'
echo 'Yes or No?'
  pull answer
   Select
    When answer = Yes then cmd = 'sock3.rexx'
    When answer = Y then cmd = 'sock3.rexx'
    When answer = No then cmd = 'haha2.rexx'
    When answer = N then cmd = 'haha2.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'sock.rexx'
   End
   Address command 'rx Dawn:bits/'cmd



  

