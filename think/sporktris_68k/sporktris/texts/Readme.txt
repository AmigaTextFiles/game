Sporktris v1.1 Readme (09/30/2007)

See http://www.happyspork.com/games for latest version.

Contents:
-3. Description
-2. Features
-1. Known Bugs
0. Controls
1. Scoring
2. Feedback
3. Source
4. Donate
5. License

---


-3. Description
----------------

Sporktris is a clone of Tetris-clones. It has no "twist" to the  
rules, and it is basically just a great game. You should try it  
sometime.


-2. Features
-------------

* Customizable keys
* Nifty level backgrounds, and coloured pieces to go with them
* Highscores
* Cross-platform (works on at least Mac OS X, Windows and Linux)
* Its own key repeat system (allows for holding down two keys at once,  
among other things)
* Automatically pauses when it isn't in front
* Will not cause a raccoon infestation in your home or work place
* Handy Features list

-1. Known Bugs
---------------

* Very occasionally a key will get "stuck" down
* Readme sections start at -3 (humor laws prevent me from fixing this)
* Will not cause a raccoon infestation in your home or work place

If you find more, please let me know (see "2. Feedback").


0. Controls
------------

The controls can be seen and modified in the Settings menu in-game.  
The default controls are:

Move left: <left arrow>
Move right: <right arrow>
Turn clockwise: <up arrow>
Turn counter-clockwise: <shift>
Move down: <down arrow>
Drop: <space>
Pause: p
End game: <escape>

I recommend using IJKL instead of the arrow keys, so you can play  
with one hand. The defaults are as they are so it's more obvious for  
new players who don't read documentation. To change the controls in  
the Settings menu, click on the control you want to change, and then  
press the key you want to change it to.


1. Scoring
-----------

You gain points every time you get a complete line. The scoring  
algorithm is:

lines * lines * level

Where lines is the number of lines you got, and level is the level  
you are on. So for instance, 4 lines on level 2 would get you 4 * 4 *  
2 = 32 points. You go up a level every 10 lines (if you start at a
level higher than 1, you initially go up a level when you get start
level * 10 lines).


2. Feedback
------------

If you'd like to report a bug, request a feature, give general  
feedback, or just say hi, feel free to email me at  
ben@happyspork.com. For other contact methods, see
http://www.happyspork.com/contact


3. Source
----------

Sporktris is written in C++, using SDL for graphics and input. It's  
released under the GNU GPL (see "5. License"), and the source can be  
downloaded from http://www.happyspork.com/games

The source may be a bit messy, as it started out as my project to  
help me learn C++ and SDL.


4. Donate
----------

Countless hours of coding, incalculable hours of bug fixing,
inconceivable hours of "play testing", insignificant seconds of picture
taking, and nonexistent hours of raccoon training went into Sporktris.
If you just can't accept that I'm giving all that away for free, you're
more than welcome to send a donation via PayPal to ben@happyspork.com
(or email me if you'd prefer to use a different method).

Donations will go towards motivating more development on this project
and others like it, as well as making sure I don't go broke. They will
definitely not go towards funding raccoon infestations.


5. License
-----------

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY.

See the License.txt file for more details.