/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
echo 'Do you feel like going ice skating??'
   pull answer
   Select
    When answer = yes then cmd = 'ice.rexx'
    When answer = y then cmd = 'ice.rexx'
    When answer = No then cmd = 'sausage.rexx'
    When answer = N then cmd = 'sausage.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    otherwise cmd = 'lefty.rexx'
    end
    address command 'rx dawn:bits/'cmd

