/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You walk along a coriddor and a horrific smell gets worse as you get further along...you find a decapitated zombie lying on the floor'
      echo '[PUSH RETURN]'
    pull answer
   Address command 'rx Dawn:bits/zombod.rexx'
