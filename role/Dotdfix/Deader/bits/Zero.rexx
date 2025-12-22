/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'A discusting, decayed zombie wearing a diy belt leaps out at you....in his diy belt he has 2 items which you could kill him with. Which do you choose?'
      echo 'screwdriver or ruler?'
    pull answer
      Select
    When answer = screwdriver then cmd = 'screw.rexx'
    When answer = ruler then cmd = 'ruler.rexx'
    When answer = use screw driver then cmd = 'screw.rexx'
    When answer = use ruler then cmd = 'ruler.rexx'
    When answer = kill him with screwdriver then cmd = 'screw.rexx'
    When answer = kill him with ruler then cmd = 'ruler.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'Zero.rexx'
   End
   Address command 'rx Dawn:bits/'cmd


   
