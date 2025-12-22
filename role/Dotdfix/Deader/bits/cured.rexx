/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'As you walk past a deserted furniture shop you see a reflection of your zombified face and begin to remember life as a human....the more you remember the more human you feel.
 You concentrate and slowly your head becomes clearer...Now you just need something to wake yourself up with...'
 echo 'Dip your head in the water fountain? Yes or No?'
    pull answer
   Select
    When answer = Yes then cmd = 'cured2.rexx'
    When answer = No then cmd = 'notcured.rexx'
    When answer = Y then cmd = 'cured2.rexx'
    When answer = N then cmd = 'notcured.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'cured.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
   
  

