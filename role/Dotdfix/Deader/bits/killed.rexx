/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You watch in glee as parts of the Zombie splatter off the walls and his head catapults into pile of knives in the corner. The zombies body stumbles around headless and you pull
 out a pistol to finish off the horrific creature. As you shoot it in the chest it collapses in a pool of blood. You stock up on guns and ammo and decide to climb through the vent shafts.
 You are very safe in here because the zombies would never be able to get in....crawling along you see a top view of the entire shopping complex. You can see at least 200 Zombies which are still
  roaming around aimlessly looking for their next unfortunate victim.'
  echo 'which way now? Left or Right?'
    pull answer
   Select
    When answer = Left then cmd = 'lefty.rexx'
    When answer = right then cmd = 'righty.rexx'
    When answer = L then cmd = 'lefty.rexx'
    When answer = R then cmd = 'righty.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'killed.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
   
  

