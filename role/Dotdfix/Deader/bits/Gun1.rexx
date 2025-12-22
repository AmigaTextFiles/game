/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
wait 1


say 'You grab the shotgun and line it up with the Zombies head, but wait!! There are no bullets!
 Fumbling around for your last seconds as the flesh is torn from your body you ironically see an Ammo shop ahead of you, on your knees
 you crawl to it..But its too late, by the time you reach the shop you forget why you wanted to be there
 and turn around to go and quench this unsatisfiable urge for human flesh.'
 say 'Even though you are a zombie you still have some control on your mind, but bearing in mind that your aim
 is no longer to escape from the zombies, it is now to get human flesh, where do you go?'
      echo 'Left or Right'
    pull answer
   Select
    When answer = Left then cmd = 'Dead.rexx'
    When answer = L then cmd = 'Dead.rexx'
    When answer = Right then cmd = 'Food.rexx'
    When answer = R then cmd = 'Food.rexx'
    When answer = up then cmd = 'Dead.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'Gun1.rexx'
   End
   Address command 'rx Dawn:bits/'cmd

