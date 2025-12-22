/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'

echo 'You decide to go for an ice skate on the rink below. You open the door and walk onto the ice rink...big Mistake!! As you walk into the room hundreds of zombies stand up on the ice and walk towards you. One of your ice skates gets jammed in the metal grid and the zombies
 are rapidly approaching....The Zombies are about 2 meters away from you when you manage to rip off the ice skate...which way?'
    echo 'There are exits to the North, South, East, West'
    pull answer
   Select
    When answer = North then cmd = 'Nor.rexx'
    When answer = N then cmd = 'Nor.rexx'
    When answer = South then cmd = 'Sou.rexx'
    When answer = S then cmd = 'Sou.rexx'
    When answer = East then cmd = 'Eas.rexx'
    When answer = E then cmd = 'Eas.rexx'
    When answer = West then cmd = 'Wes.rexx'
    When answer = W then cmd = 'Wes.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'ice.rexx'
   End
   Address command 'rx Dawn:bits/'cmd



  
