/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You find a second corpse not far around the corner and begin to rip off sections of flesh when you hear
 movement above, just then a black man wearing a blue police uniform leaps out and blasts your head with a shotgun.
Being a Zombie you manage to stumble round the corner before the second shot completely detaches your head....'
echo 'Attack him? Yes, No, Maybe So'
 pull answer
   Select
    When answer = Yes then cmd = 'shot.rexx'
    When answer = No then cmd = 'cured.rexx'
    When answer = Maybe So then cmd = 'dead.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'Food2.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
   
  

