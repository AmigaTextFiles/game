/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
 echo 'Well done the cannister burst open in the heating system...now all you have to do is escape from this shopping center..'
echo '[PUSH RETURN]'
 pull answer
echo 'The green gas begins to get into your system and you feel tired....you want to lie down all the time....you are very tired.....'
echo 'Lie Down? Yes or No?'
  pull answer
   Select
    When answer = Yes then cmd = 'haha.rexx'
    When answer = Y then cmd = 'haha.rexx'
    When answer = No then cmd = 'sock.rexx'
    When answer = N then cmd = 'sock.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'sock2.rexx'
   End
   Address command 'rx Dawn:bits/'cmd



  

