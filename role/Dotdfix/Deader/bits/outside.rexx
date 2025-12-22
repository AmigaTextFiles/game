/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

say 'You head ontop of the building, there are numerous puddles up here and strangely a tennis racket and balls. You decide to have a quick game of tennis and begin to hit the balls against the wall to release your anger....Meanwhile down below at the very bottom of the building there are still lots of zombies scratching at the entrance to the shopping Mall.'
 echo 'Look over the edge of the building? Yes or No?'
    pull answer
   Select
    When answer = Yes then cmd = 'You look over the edge of the building and see the many zombies below...nothing else interests you..'
    When answer = No then cmd = 'You decide not to look over the edge of the building..nothing else interests you here..'
    When answer = Y then cmd = 'You look of the edge over the building and see the many zombies below...nothing else interests you..'
    When answer = N then cmd = 'Youre too afraid to look over the edge of the building in case you fall...nothing else interests you here..'
    When answer = Shit then cmd = 'You are a very rude person....'
   Otherwise cmd = 'I dont understand, bottom breath..'
   End
   echo cmd

   echo '[PUSH RETURN]'
   pull answer

   echo 'You suddenly see lots of pipes, closer inspection shows that these pipes lead to different parts of the Mall'
         echo 'There are ten pipes you could go down... pick a pipe 1-10'
    pull answer
   Select
    When answer = 1 then cmd = 'seuth.rexx'
    When answer = 2 then cmd = 'Eest.rexx'
    When answer = 3 then cmd = 'Nerth.rexx'
    When answer = 4 then cmd = 'roght.rexx'
    When answer = 5 then cmd = 'est.rexx'
    When answer = 6 then cmd = 'nth.rexx'
    When answer = 7 then cmd = 'shop.rexx'
    When answer = 8 then cmd = 'laft.rexx'
    When answer = 9 then cmd = 'Zero.rexx'
    When answer = 10 then cmd = 'nth.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'outside.rexx'
   End
   Address command 'rx Dawn:bits/'cmd

