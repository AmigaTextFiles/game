/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
wait 1


say 'You walk along the tiled surface and notice a Zombie coming towards you. It seems to be very
 hungry and wouldnt hesitate about eating you. There are 2 objects near by...in the spur of the moment you cant decide
 which one to pick up, the shotgun or the metalRod....quick which one will it be??'
      echo 'ShotGun or MetalRod'
    pull answer
   Select
    When answer = ShotGun then cmd = 'Gun1.rexx'
    When answer = MetalRod then cmd = 'Rod2.rexx'
    When answer = Metal Rod then cmd = 'Rod2.rexx'
    When answer = Get ShotGun then cmd = 'Gun1.rexx'
    When answer = Get MetalRod then cmd = 'Rod2.rexx'
    When answer = Get Metal Rod then cmd = 'Rod2.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'North1.rexx'
   End
   Address command 'rx Dawn:bits/'cmd

