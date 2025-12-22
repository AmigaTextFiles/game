/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You come across an Ammo shop, it is filled with large guns and rockets.....just then a Zombie approaches....You have a large choice of weapons with which to destroy him..'
echo' Will you use the ShotGun, HandGun, Rocket or Grenade?'
    pull answer
   Select
    When answer = shotgun then cmd = 'killed.rexx'
    When answer = handgun then cmd = 'killed.rexx'
    When answer = rocket then cmd = 'killed.rexx'
    When answer = Grenade then cmd = 'grenade.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'fun.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
   
  

