/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
echo 'This direction leads out of a fire exit and outside the shopping Mall...it is the place where you first entered the Mall and you can see the glass which you broke to get into the store room...'
   echo 'Which way? Into the store room where you started your adventure or ontop of the building?'
    pull answer
   Select
    When answer = Store room then cmd = 'righty.rexx'
    When answer = Store then cmd = 'righty.rexx'
    When answer = Ontop of the building then cmd = 'outside.rexx'
    When answer = ontop then cmd = 'outside.rexx'
    When answer = top then cmd = 'outside.rexx'
    When answer = building then cmd = 'outside.rexx'
    When answer = Up then cmd = 'outside.rexx'
    When answer = room then cmd = 'righty.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'nor.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
