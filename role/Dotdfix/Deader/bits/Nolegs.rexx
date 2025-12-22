/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You look away hoping not to see anything but unfortunately the image reflects off a nearby shop window
 and everything becomes very clear.....'
address command 'wait 4'
   Address command 'Dawn:bits/VT Dawn:bits/nolegs.gif >nil:'
   say 'The Horrific sight of your body detached from your legs is too much for you to take and the shock instantly kills you. If the shock hadnt killed you the perpetual bleeding would have.'
   say 'Game Over......'
   address command 'wait 4'
   address command 'rx dawn:bits/again.rexx'

