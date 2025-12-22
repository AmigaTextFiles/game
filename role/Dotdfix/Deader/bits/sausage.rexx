/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

echo 'You stand around for a bit having some fun and using the blood pressure machine......what now?'
    echo 'to the icerink, into the vents or up the escalator?'
    pull answer
   Select
    When answer = icerink then cmd = 'ice.rexx'
    When answer = rink then cmd = 'ice.rexx'
    When answer = vents then cmd = 'vents.rexx'
    When answer = back into the vents then cmd = 'vents.rexx'
    When answer = back then cmd = 'vents.rexx'
    When answer = into the vents then cmd = 'vents.rexx'
    When answer = the vents then cmd = 'vents.rexx'
    When answer = in the vents then cmd = 'vents.rexx'
    When answer = escalator then cmd = 'escalator.rexx'
    When answer = up the escalator then cmd = 'escalator.rexx'
    When answer = e then cmd = 'escalator.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'sausage.rexx'
   End
   Address command 'rx Dawn:bits/'cmd



  
