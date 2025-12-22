/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You head north and find yourself in a warm room, there is a strange smell in the room......suddenly you turn around to see one of the most horrific sites youve ever seen!'
      echo '[PUSH RETURN]'
    pull answer
   Address command 'Dawn:bits/vt dawn:bits/discusting >nil:'
   echo 'Which way? Left or Right?'
   pull answer
   Select
    When answer = Left then cmd = 'zombod.rexx'
    When answer = Right then cmd = 'roght.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    When answer = L then cmd = 'zombod.rexx'
    When answer = R then cmd = 'roght.rexx'
    Otherwise cmd = 'Nerth.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
