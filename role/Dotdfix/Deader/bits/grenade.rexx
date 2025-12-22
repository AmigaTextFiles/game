/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
wait 1


say 'foolishly you toss a grenade in an ammo shop and dive for cover behind a gun rack waiting for the inevitable explosion. B00M! The entire shopping complex bursts into flames.....you have solved the Zombie problem but unfortunately you are dead.....'
   echo '[PUSH RETURN]'
   pull answer
   Address command 'rx Dawn:bits/again.rexx'

