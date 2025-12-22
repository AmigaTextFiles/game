/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
echo 'This direction leads into the control room, here you can change the music which is being played all through the mall and even control shop window displays'
   echo 'You reach forward and change the music...'
   echo '[PUSH RETURN]'
    pull answer
   Address command 'rx Dawn:bits/quit.rexx'
   Address command 'run >nil: dawn:bits/zombieplayer dir=dawn:bits/ play=zombietune2 nowindow'
   echo 'You head back to the previous room and the Zombies are closing in....'
   echo 'Which way will you go? North, South, West?'
   pull answer
   Select
    When answer = North then cmd = 'Nor.rexx'
    When answer = N then cmd = 'Nor.rexx'
    When answer = South then cmd = 'Sou.rexx'
    When answer = S then cmd = 'Sou.rexx'
    When answer = West then cmd = 'Wes.rexx'
    When answer = W then cmd = 'Wes.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'eas.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
