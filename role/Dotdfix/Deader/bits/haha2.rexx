/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
 echo 'you put down your weapon and try to find another way through the door...as you do this a hoard of hungry zombies hurtle round the corner and rip you limb from limb...seconds later they are devouring your vital organs...'
echo 'Would you like to shout CHOKE ON THEM as they rip your legs off?'
pull answer
 Select
    When answer = Yes then cmd = 'Well done atleast you got some satifaction before you were killed'
    When answer = No then cmd = 'You were killed and you didnt even have good last words......'
    When answer = Maybe So then cmd = 'sausage!!'
    When answer = Shit then cmd = 'rx savini.rexx'
    Otherwise cmd = 'rx haha2.rexx'
   End
echo 'GAME OVER....'
address command 'wait 4'
address command 'rx dawn:bits/again.rexx'

  

