/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You are in the ventilation system...its getting quite hot in here.....'
  echo 'which way now? Left or Right? There is also an escalator nearby...'
    pull answer
   Select
    When answer = Left then cmd = 'lefty.rexx'
    When answer = right then cmd = 'righty.rexx'
    When answer = L then cmd = 'lefty.rexx'
    When answer = R then cmd = 'righty.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    When answer = escalator then cmd = 'escalator.rexx'
    When answer = goto escalator then cmd = 'escalator.rexx'
    When answer = use escalator then cmd = 'escalator.rexx'
    Otherwise cmd = 'vents.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
   
  

