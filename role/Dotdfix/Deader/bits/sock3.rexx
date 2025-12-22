/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
 echo 'You finally see light at the end of the corridor and stumble out of the open door just as the gas is becoming too much for you to handle....you cough a few times and turn around to take a look at the shopping mall. All the windows are unclear because of the green gas inside the building, you cant see any zombies....they must be all dead!!'
 echo '[PUSH RETURN]'
 pull answer
address command 'run >nil: dawn:bits/play16 dawn:bits/groan.iff'
address command 'run >nil: dawn:bits/play16 dawn:bits/groan.iff'
address command 'run >nil: dawn:bits/play16 dawn:bits/groan.iff'
echo 'You turn around and your heart stops...the Zombies are NOT DEAD they are escaping through a door and heading straight towards you! You freeze and you cant move, you feel a pain in your chest because of the shock and the zombies are still getting closer.....'
echo '[PUSH RETURN]'
pull answer
echo 'Just then the zombies slow down, and stumble slightly...then they all begin to drop like flies....after seconds they are all on the floor...the gas must have taken a while to kick in....you walk over to the nearest zombie and see that there is steam rising from it...it is dissolving....you give the shopping center one last look and then disappear into the wilderness to try and clear your mind of this terrifying experience......'
echo '[PUSH RETURN]'
pull answer
echo 'LOOK OUT FOR DAWN OF THE DEADER II - DAY OF THE DEADER!'
address command 'wait 4'
address command 'rx dawn:bits/quit.rexx'
Address command 'run >nil: dawn:bits/zombieplayer dir=dawn:bits/ play=zombietune2 nowindow'
address command 'run >nil: dawn:bits/scalammplayer dawn:bits/end'
address command 'wait 25'
address command 'rx dawn:bits/quit.rexx'

  

