/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You go up the escalator onto the top floor of the mall...'
      echo 'left or right?'
    pull answer
   Select
    When answer = Left then cmd = 'nth.rexx'
    When answer = Right then cmd = 'roght.rexx'
    When answer = L then cmd = 'nth.rexx'
    When answer = R then cmd = 'roght.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'escalator.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
