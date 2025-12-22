/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'The image becomes clear as you stare into the metal'
address command 'wait 2'
   Address command 'Dawn:bits/VT Dawn:bits/nolegs.gif >nil:'
   say 'The Horrific sight of your body detached from your legs is too much for you to take and the shock instantly kills you. If the shock hadnt killed you the perpetual bleeding would have.'
   say 'Game Over......'
   address command 'wait 7'
   Address command 'rx dawn:bits/again.rexx'

