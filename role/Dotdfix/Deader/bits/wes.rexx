/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
echo 'This leads to a care takers room... you see a scientist lying on the floor half dead. He speaks to you....'
echo '[PUSH RETURN]'
 pull answer
 address command 'rx dawn:bits/quit.rexx'
    Address command 'run >nil: dawn:bits/zombieplayer dir=dawn:bits/ play=zombietune2 nowindow'
echo '* Scientist - Get the cannister please...'
echo '[PUSH RETURN]'
 pull answer
echo ' You - What?'
echo '[PUSH RETURN]'
 pull answer
echo '* Scientist - that cannister there will kill the dead....'
echo '[PUSH RETURN]'
 pull answer
echo ' You - This one?'
echo '[PUSH RETURN]'
 pull answer
echo ' You pick up a green cannister which is next to lots of experimental equipment and chemicals...the cannister is warm and is labeled BLOOD OF ROMERO..'
echo '[PUSH RETURN]'
 pull answer
echo '* Scientist - Take that cannister and put it into the central heating system....cough, cough,'
echo '[PUSH RETURN]'
 pull answer
echo ' You - hmmm ok'
echo '[PUSH RETURN]'
 pull answer
echo '* Scientist - But make sure you....you g..g..e...t... cough..'
echo '[PUSH RETURN]'
 pull answer
echo ' You - I what?'
 echo '[PUSH RETURN]'
  pull answer
echo ' You grab the old man but his eyes close and he dies....'
echo '[PUSH RETURN]'
 pull answer
echo ' You think to yourself what he was saying and you realise that he must have meant put the cannister into the central heating system and then get out of the building quick...'
address command 'Wait 6'
address command 'run >nil: dawn:bits/play16 dawn:bits/BANG.SND'
address command 'run >nil: dawn:bits/play16 dawn:bits/BANG.SND'
address command 'run >nil: dawn:bits/play16 dawn:bits/BANG.SND'
address command 'run >nil: dawn:bits/play16 dawn:bits/BANG.SND'
echo '----'
echo ' You turn around to see the scientist in zombie form, he is grasping a pistol and trying to shoot himself in the head....presumably he is not 100% zombie yet and he is trying to stop himself experiencing a fate worse than death....You take the gun off him and look away, you point it at his head and pull the trigger, his head exlodes and the walls are splattered with his brains....'
echo '[PUSH RETURN]'
pull answer
echo ' You get the cannister and goto the central heating system...'
echo '[PUSH RETURN]'
 pull answer
 address command 'rx dawn:bits/heating.rexx'
   
