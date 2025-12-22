/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
echo 'You walk up to the lift and go in...As it reaches the next floor you hear the tortured groanings of hungry Zombies, you decide to climb through the roof of the lift to escape from them...however just as you are climbing up the door opens and hundreds of flesh eating zombies begin to rip your legs off...you slump to the floor and lose consciousness seconds after you have experienced them slurping your intestines up like noodles...'
   echo '[PUSH RETURN]'
   pull answer
   Address command 'Dawn:bits/VT Dawn:bits/lift.gif >nil:'
   Address command 'rx Dawn:bits/again.rexx'
