/*
\\  Dawn Of The Dead RPG  - By Gareth Murfin
//  Game created in Arexx - ver$  Dawn Of The Dead RPG v1.0a
\\
*/
address command 'Dawn:bits/style R 2'
wait 1


echo '+--------------------------------------------------------+'
say '| Welcome to the Dawn of the Deader RPG By Gareth Murfin.|'
echo '+--------------------------------------------------------+'
address command 'wait 1'
  Address command 'Dawn:bits/say Welcome to the dawn of the deader rpg, By Gareth Murfin'
wait 1
 say 'What do you want your character to be called?'
 pull name
 if name = Romero then address command 'Dawn:bits/say Rome ero Mode innitiated'
        echo 'from now on you will be called' name '!'
address command 'wait 1'
echo 'You awake to find yourself lying face down in a store room in some kind of
 giant shopping mall. Around you are numerous boxes of supplies consisting of hundreds
 of tins of spam and a few other non essential items. Seconds later your memory begins to return,
 you cant remember alot but you know that you came here to escape from some major natural disaster.
 You climb to your feet and stumble to a nearby window, your vision is still blurey so it takes a
 few seconds to focus. When your vision becomes clear a cold feeling of dredd runs through your
 body as you begin to remember more and more. This natural disaster was far worse than anything
 in history. Through some strange happenings the dead are returning as Zombies.....'
 echo '[PRESS RETURN]'
pull answer
   Address command 'Dawn:bits/VT Dawn:bits/mall.gif >nil:'
      echo 'You walk forward a few meters and see the button to turn the power on to the Mall.'
      echo 'What next?'
      pull answer
   Select
    When answer = Push button then cmd = 'You push the button and it causes the lights to come on, music to play and shop displays to move...'
    When answer = button then cmd = 'You push the button and it causes the lights to come on, music to play and shop displays to move...'
    When answer = power then cmd = 'You push the button and it causes the lights to come on, music to play and shop displays to move...'
    When answer = push then cmd = 'You push the button and it causes the lights to come on, music to play and shop displays to move...'
    When answer = Shit then cmd = 'Savini is not amused 'name '......he pushes the button for you.'
    Otherwise cmd = 'That is not an option right now 'name' ...You decide to push the button...and it causes the lights to come on, music to play and shop displays to move...'
   End

   echo cmd
Address command 'wait 2'
   Address command  'run >nil: Dawn:bits/zombieplayer dir=Dawn:bits/ play=zombietune nowindow'
      echo 'There are exits to the North & South'
    pull answer
   Select
    When answer = North then cmd = 'North1.rexx'
    When answer = N then cmd = 'North1.rexx'
    When answer = South then cmd = 'South1.rexx'
    When answer = S then cmd = 'South1.rexx'
    When answer = East then cmd = 'North1.rexx'
    When answer = Shit then cmd = 'savini.rexx'
    Otherwise cmd = 'North1.rexx'
   End
   Address command 'rx Dawn:bits/'cmd

