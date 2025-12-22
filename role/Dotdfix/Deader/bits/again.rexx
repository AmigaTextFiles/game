/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'Unlucky on your last venture....you have been granted another life....do you want to have another go?'
echo 'Yes or No'
pull answer
    Select
    When answer = Yes then cmd = 'quit2.rexx'
    When answer = No then cmd = 'quit.rexx'
    When answer = Y then cmd = 'quit2.rexx'
    When answer = N then cmd = 'quit.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'again.rexx'
   End
   Address command 'rx Dawn:bits/'cmd

 
