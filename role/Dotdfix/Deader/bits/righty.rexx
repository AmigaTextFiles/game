/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
echo 'You drop down into the store room which you started in, outside the store room now the zombies are congregating, the only way out is to go back into the vents and drop down into the leisure section or to go out the way in which you entered the shopping mall, the window...'
   echo 'Which way? The vents or the Window leading outside..?'
    pull answer
   Select
    When answer = Vents then cmd = 'vents.rexx'
    When answer = V then cmd = 'vents.rexx'
    When answer = Back then cmd = 'lefty.rexx'
    When answer = B then cmd = 'lefty.rexx'
    When answer = Window then cmd = 'outside.rexx'
    When answer = W then cmd = 'Outside.rexx'
    When answer = Outside then cmd = 'Outside.rexx'
    When answer = O then cmd = 'Outside.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'lefty.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
