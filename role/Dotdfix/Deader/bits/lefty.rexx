/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
echo 'You drop down into the leisure department and you feel like you are in paradise. The Zombies are safely locked behind a 2 inch thick glass wall and the room is filled with sporting equipment, clothes, sweets, food, Tvs, Computers and loads of other things. For the first 10 minutes you run around sampling the clothes and food and even playing basket ball in a proper net.'
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

