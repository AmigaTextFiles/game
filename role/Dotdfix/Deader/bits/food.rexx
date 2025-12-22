/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'you stumble as fast as your zombified limbs will take you and soon come across a human corpse surrounded by other ghoulish
 flesh eaters. You reach out your scabby hands and begin to eat a portion of the corpses left leg, the taste is meaty and has a
  sort of wriggly texture. You feel like you are eating a prime Gammon steak and continue to indulge yourself. A niggling memory of
  past life keeps teeling you it is wrong from the back of your mind but none of that matters. All you can think of is when this flesh
  runs out, where will you get more....'
    echo '[PUSH RETURN]'
    pull answer
    Address command 'Dawn:bits/VT Dawn:bits/half.gif >nil:'
   echo 'which way now.....East, South, West'
  pull answer
   Select
    When answer = East then cmd = 'cured.rexx'
    When answer = South then cmd = 'Dead.rexx'
    When answer = West then cmd = 'Food2.rexx'
    When answer = E then cmd = 'cured.rexx'
    When answer = S then cmd = 'Dead.rexx'
    When answer = W then cmd = 'Food2.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'Food.rexx'
   End
   Address command 'rx Dawn:bits/'cmd
   
  

