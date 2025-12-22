/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'The Zombie is old and as soon as you touch him his head falls off...followed by his neck...then suddenly lots of beetles emerge from the Zombies head and fly towards you... What do you do..?'
      echo 'Run through the beetles? Wait?'
    pull answer
   Select
    When answer = Run then cmd = 'run.rexx'
    When answer = Wait then cmd = 'dwee.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'dwee.rexx'
   End
   Address command 'rx Dawn:bits/'cmd

