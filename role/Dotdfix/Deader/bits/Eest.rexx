/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You walk through a door leading into a corridor'
      echo 'left or right?'
    pull answer
   Select
    When answer = Left then cmd = 'laft.rexx'
    When answer = Right then cmd = 'roght.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    When answer = L then cmd = 'laft.rexx'
    When answer = R then cmd = 'roght.rexx'
    Otherwise cmd = 'eest.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
