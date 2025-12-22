/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You walk down a dimly lit corridor and the smell of rotting flesh stings your nose, it gets stronger as you move forward and then suddnely a Zombie leaps out...What do you do to him?'
      echo 'Headbutt Him, Kick Him, Rip his head off, Smack him around a bit '
    pull answer
   Select
    When answer = Headbutt Him then cmd = 'zombod.rexx'
    When answer = Kick Him then cmd = 'zombod.rexx'
    When answer = Rip his head off then cmd = 'zombod.rexx'
    When answer = Smack him around a bit then cmd = 'zombod.rexx'
    When answer = headbutt then cmd = 'zombod.rexx'
    When answer = kick then cmd = 'zombod.rexx'
    When answer = rip then cmd = 'zombod.rexx'
    When answer = rip head off then cmd = 'zombod.rexx'
    When answer = smack him around a bit then cmd = 'zombod.rexx'
    When answer = smack him then cmd = 'zombod.rexx'
    When answer = smack him around then cmd = 'zombod.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'Seuth.rexx'
   End
   Address command 'rx Dawn:bits/'cmd

