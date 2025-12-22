-----------------------------------
TankGame 1.0e,  Build: 4th Jan 2010
-----------------------------------
(C) 2009-2010 by Dennis Busch, Dennis-Busch@gmx.net, http://www.dennisbusch.de

Content
-------
    0.) Disclaimer
    1.) What is it?
    2a.) Why does it exist?
    2b.) Version History
    3.) How to play, Controls
    4.) Copyright & Spreading
    5.) References

    
0.) Disclaimer
--------------
    #include <std_disclaimer.h>
    "I do not accept responsibility for any effects, adverse or otherwise, that 
     this code may have on you, your computer, your sanity, your  dog, and 
     anything else that you can think of. Use it at your own risk."
     ---
     All code was written and compiled without evil intention. 
     Use the executable at your own risk.

    
1.) What is it?
---------------
    TankGame is a simple game for two players, written in C++, using the 
    wonderful "Allegro"[R1] library as a framework.
    
    The goal of the game for each player is to eliminate the respective other 
    player by destroying their tank within a timelimit or to do as much damage 
    as possible.
    
    Inspiration: The game was inspired by an Atari 2600 game, 
    called "Combat"[R2].
    
    
2a.) Why does it exist?
----------------------
    It was originally written for a school assignment based on the following 
    requirements:
    - game for two to four players
    - not single player against the machine
    - may be written in any language
    - must have a help option with instructions
    - scores must be saved into a file
    - must use OOP
    - use of PHP is allowed
    - must have a GUI
    - if it uses a database, it must be created at runtime or be included
    
    - must fit into a zip file of a maximum of 5MB
    - a runnable executable must be included
    - fully commented sourcecode must be included

2b.) Version History
--------------------
    1.0e 4th Jan 2010
         -set the default color depth to 32 (can be changed in constants.cfg)
         -fixed a minor problem with the graphic resources not being converted
          correctly upon initialization

    1.0d 3rd Jan 2010
         -added sound effects (created with "SFXR"[R3])
    
    1.0c 17th May 2009
         -the original version for the assignment 


3.) How to play
---------------
    From the main menu use up and down arrow keys and enter-key to go to 
    "Choose Players" to select the players.
    
    In the "Choose Players" menu, use up and down arrow keys to navigate through
    the registered player names and use left and right arrow keys to assign the
    green and the red tanks to two different players.
    
    Navigate to "register new player" and hit enter to register a new player.
    Use the escape key to go back to the main menu.
    
    Use left and right arrow keys in main menu to select the battle arena.
    
    Navigate to "Start Game" and hit enter-key to start the match.
    
    In the game, the control keys are the following.
    
IMPORTANT NOTE about the rotation keys:
    They work like this: TAP a key once to start rotating in that direction
                         TAP the key again to stop rotating in that direction
    It is not necessary to keep the rotation key depressed.
    It is not recommended to keep any key depressed, because of the hardware 
    limitations of most keyboards (there is a maximum number of keys that can
    be depressed at the same time, which is between 3 and 6 for most keyboards).
    
KEYS for green tank:
    Q,W - rotate gun counterclockwise, clockwise
    A,S - rotate tank counterclockwise, clockwise
    E - fire gun (only possible if it is loaded)
    D - toggle engine between <forward, stop, reverse, stop>
    
KEYS for red tank:
    numpad7, numpad8 - rotate gun counterclockwise, clockwise 
    numpad4, numpad5 - rotate tank counterclockwise, clockwise
    numpad9 - fire gun (only possible if it is loaded)
    numpad6 - toggle engine between <forward, stop, reverse, stop>
    
    ALTERNATE KEYS for red tank for keyboards that don't have a number pad
    are U,I,J,K,O,L (functions in same order as above)
    
    Each players goal is to destroy the other tank or to do as much damage as
    possible within the timelimit to win.
    
    Shooting builds up heat. Getting hit builds up heat as well.
    If a players tank is too hot, it can not shoot until it cools down a bit.
    
    The more damage a tank has taken, the slower it will be able to move.
    
    The winning player scores one point.
    The winning player scores two additional points if he wins without 
    taking any damage.
    
    Have Fun!
    
    You can always check how well each individual player did, by viewing the
    "Scores" from the main menu.
        
    
4.) Copyright & Spreading
-------------------------
    all code is (C) 2009-2010 by Dennis Busch,
    reuse without explicit written permission from author for any purpose other 
    than compiling it into a runnable executable or for educational evaluation
    is strictly prohibited

    all graphics are (C) 2009 by Dennis Busch,
    reuse without explicit written permission from author for either commercial 
    or non-commercial use is strictly prohibited
    
    all sounds were generated using SFXR [R3] by carefully setting and tweaking
    all the available parameters :)

You may spread as many copies of this archive as you wish, provided that you 
keep the archive intact and in its original form and that you do not remove or 
change this copyright notice and that you do not claim to have intellectual 
ownership rights to any of its content.


5.) References
--------------
    [R1] Allegro - http://alleg.sourceforge.net/
         Allegro is released as giftware by the Allegro developer community.
    
    [R2] Combat - http://en.wikipedia.org/wiki/Combat_(video_game)
         Combat is (C) 1977 by Atari, Inc.
 
    [R3] SFXR - http://www.drpetter.se/project_sfxr.html
         SFXR is a Sound Effect Generator written by DrPetter 2007-12-14
