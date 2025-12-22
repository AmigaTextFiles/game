/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
wait 1


say 'You turn a corner and accidentally slip on a disembodied limb which sends you hurtling off the balcony.
 One of the last things you feel is a sharp wire ripping through your waist and then seconds later that same wire
falling ontop of you followed by lots of lighting equipment. A Steel sheet misses your face by 2 inches and as
 you stuggle to breath the metal shows your reflection.'
      echo 'Do you look at the reflection? Yes, No, Maybe So'
    pull answer
   Select
    When answer = Yes then cmd = 'NoLegsR.rexx'
    When answer = No then cmd = 'NoLegs.rexx'
    When answer = Maybe So then cmd = 'NoLegsR.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'dead.rexx'
   End
   Address command 'rx Dawn:bits/'cmd

