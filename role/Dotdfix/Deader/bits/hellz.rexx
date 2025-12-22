/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
wait 1


say 'Ok.... you will be transported to a random location in the game. And try not to
 swear again or you will return to HELL'
  address command 'wait 3'
      echo 'Selecting Random Location in Game...'
 address command 'wait 1'
 echo '*** 3 ***'
 address command 'wait 1'
 echo '*** 2 ***'
 address command 'wait 1'
 echo '*** 1 ***'
 address command 'wait 1'

r = Random(1,5,Time('S'))
Select
 When r = 1 then cmd = 'vents.rexx'
 When r = 2 then cmd = 'seuth.rexx'
 When r = 3 then cmd = 'Smee.rexx'
 When r = 4 then cmd = 'shop.rexx'
 Otherwise cmd = 'escalator.rexx'
End
Address command 'rx dawn:bits/'cmd

