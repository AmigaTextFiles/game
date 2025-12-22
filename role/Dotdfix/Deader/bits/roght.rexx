/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'A zombie crawls towards you covered in blood. It looks innocent even though it is covered in blood. You begin to get strange thoughts... maybe this zombie could be
 brought back to being human you think for a brief second...'
      echo 'Try and revive the zombie or kill it?'
    pull answer
   Select
    When answer = revive then cmd = 'eddy.rexx'
    When answer = kill then cmd = 'zib.rexx'
    When answer = revive it then cmd = 'eddy.rexx'
    When answer = kill it then cmd = 'zib.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    When answer = revive zombie then cmd = 'eddy.rexx'
    When answer = kill zombie then cmd = 'zib.rexx'
    When answer = revive the zombie then cmd = 'eddy.rexx'
    When answer = kill the zombie then cmd = 'zib.rexx'
    When answer = try and revive the zombie then cmd = 'eddy.rexx'
    When answer = kill zombie now then cmd = 'zib.rexx'
    Otherwise cmd = 'escalator.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
