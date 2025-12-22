/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You enter a large room.....there are 4 exits and the room looks as though it has never been touched
 by the zombies.....you could be safe here for a while...'
      echo 'North East South or West or Wait?'
    pull answer
   Select
    When answer = west then cmd = 'wst.rexx'
    When answer = north then cmd = 'est.rexx'
    When answer = east then cmd = 'nth.rexx'
    When answer = south then cmd = 'sot.rexx'
    When answer = w then cmd = 'wst.rexx'
    When answer = n then cmd = 'est.rexx'
    When answer = e then cmd = 'nth.rexx'
    When answer = s then cmd = 'sot.rexx'
    When answer = Wait then cmd = 'waity.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'smee.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
