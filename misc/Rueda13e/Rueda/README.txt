                 ______________________________________________
                |  __        __  _    __     _    __           |
                | |__) |  | |__ | \  |__|     |   __) ENHANCED |
                | |  \ |__| |__ |__\ |  |  v  | o __)          |
      __________|                                              |_________
     /                        __   ___  ___  ______                      \
     \                       /  ) /    /  /   /   /  /                   /
      \                     /__/ /__  /__/   /   /__/                   /
       \                   /__) /____/  /___/  ____/                   /
        \                                                             /
         \                 s  o  f  t  w  o  r  k  s                 /
          \             _______________________________             /
           \___________/                               \___________/ 
                       \         README FILE           /
                        \_____________________________/


CONGRATULATIONS!  You just downloaded the best wheel of fortune game out
for the wonderful Amiga computer..  This version is has these glorious new
features I have added for the ENHANCED version of 1.3 (1.3e) :


· keyboard support!  no more mouse-to-keyboard-to-mouse-to-keyboard, etc.
· complete mouse support!  you can now click on a letter to choose it!
· major graphic face lifts.. almost all screens have been enhanced
· timer now works!  and i decided to give 30 seconds for those of you who
  can't type as fast as the programmer!  timer will give you 30 seconds on
  any computer, regardless of speed
· added 'letters used' display
· made puzzles an external txt file--see EDITING PUZZLES.TXT for editing
· added about 50 puzzles to the list, and took out old crap ones !;>
· fixed graphical wheel spinning problems (glitch on bottom)
· changed prize graphics, made a _little_ more attractive
· fixed ! ? ' - , characters for puzzles - had problems displaying them
· fixed 'mouse disappearing' problem at Play Again? prompt
· got rid of the 'i love bankrupt' problem.. made wheel spinning a little
  more 'random'
· many many other general bug fixes and algorithm enhancements (but the code
  is STILL a complete mess :)



--------------------------------------------------------------------------
THANK YOU TO ALL INTERNET ACQUAINTANCES WHO EMAILED ME AND REPORTED
BUGS/ASKED FOR FEATURES!!!  HOPEFULLY I GOT ALL THE BUGS AND ADDED ALL THE
FEATURES!!

Version 1.4 is under way and is going to support 1-4 players, will have a
completely new look, all new code from scratch, and hopefully some great
MOD theme songs for Title, Main and Final ..  Watch for this version!
--------------------------------------------------------------------------


Welcome to Rueda1.3e.  The 1.3 version of Rueda was planned as a Registered-
only release, but I decided to distribute it fully functional out in
the Amiga community.  These are the major "registered" features added from
1.2 to 1.3:

· Theme song		· Great graphics	· New effects
· Sound effects		· A Computer player	· 100% Fruit Juice!


                        _______________________________
 ______________________/                               \__________________  
                       \         COMPATIBILITY         /
                        \_____________________________/

This version of AMOS was compiled with the AMOS PRO compiler, so it 
should be fully compatible with the Amiga line.  I ran it on my accel-
erated 1200 and I didn't have to reboot and select ECS mode (like you did
on version 1.3).  I have used it on an A500, A500 w/AdSpeed & 2.0, and
A3000UX.  I wrote Rueda1.3 on an Amiga 500, 2.04, 3 megs, 52 megs, ADSpeed,
in AMOS and the AMOS compiler (Wonderful programs).  Rueda1.3e was
developed on my new A3000UX 25/4/105 with the same software.  Later fixes
were done on yet another computer that I have upgraded to, my 1200 14/6/120
with 25mhz '882.  

                        _______________________________
 ______________________/                               \__________________  
                       \           THE GAME            /
                        \_____________________________/


Rueda is Spanish for wheel.  It originally had the actual name "Wheel of
Fortune," but I declined using it for various reasons.  Rueda allows you to
play the fun game of Wheel of Fortune on your computer, either alone or
with a partner.  The graphics were designed to be attractive, simple and
functional (like me!).  It started out as a project to learn AMOS, but two
months later turned out to be a commercial-quality game.  (OK, now 2 1/2
months of work :) (OK, now 4 months of work and 4 months of dinking around)

The game was written in the (wonderfully easy to use yet powerful) AMOS
language, then compiled with the AMOS Compiler.

This version of Rueda can be played by one or two players.  If one player
chooses to play solitaire, he competes with the computer in three rounds of
fun to see who can accumulate the most money..if the human wins, he gets to
play the final round!

If two players is selected, two humans compete in the same fashion of three
rounds of blood and sweat to an exciting finish in the final round!

The rules are the same as the Wheel of Fortune game show..pretty much, you
spin the wheel, guess a consonant, and you get the amount on the wheel
times the number of that letter in the puzzle.  Example: say the puzzle is
"AMIGA COMPUTER".  You spin and get $200, then choose an M.  You would
receive $400 for the two Ms.  Simple, huh?

You can buy vowels for $250, which will get you as many letters as there
are in the puzzle.  (If there are 4 A's, you don't have to pay $1000, just
$250.)

You can solve the puzzle anytime you want, and the current version does not
have a time limit.  Future versions may have a 20-30 second timer.  If you
guess the puzzle, you win that round, and your current score is added to
your total score.  Whomever has the most after three rounds plays the Final
Round.

In the Final Round, you first must choose a letter out of RUEDA to decide
your prize.  Then you are given a puzzle to solve in 30 seconds.  You
will first be shown the letters R, S, T, L, N, and E in the puzzle.  Then
you choose 3 consonants and 1 vowel.  After these are shown, you have 30
seconds to solve the puzzle!


                        _______________________________
 ______________________/                               \__________________  
                       \           CONTROLS            /
                        \_____________________________/

In the main screen you can type 1 or 2 to select the number of players.
When in the play screen, you will notice an line under a single character
in SPIN, BUY VOWEL and SOLVE.. but not QUIT.  The underlined character is
what you type to execute that button--you must click on QUIT (safety
feature, once you click on it, you are done with that game).
Space bar is another way to SPIN, and Return is another way to SOLVE.
When you are asked whether or not you want to play again, Y and N can be
typed for an answer.

                        _______________________________
 ______________________/                               \__________________  
                       \             SETUP             /
                        \_____________________________/


To setup Rueda, you must assign "Rueda:" to the directory where all the
graphic files reside.  As it was compressed originally, you must assign
"Rueda:" the the DATA directory.  After that, you can stick the actual
program anywhere you want, it just needs to find its files in the assign
"Rueda:".

Example:  "Assign RUEDA: ram:DATA/"

                        _______________________________
 ______________________/                               \__________________  
                       \      EDITING PUZZLES.TXT      /
                        \_____________________________/


Version 1.3e of Rueda uses an external text file to read in the puzzles
rather than Data statements hard-coded into the program.  This allows easy
puzzle expansion for me AND you.  (Well, not too easy, as you will soon see
:) The only problem is:  the file is in an abnormal format.  It IS a txt
file, but each line has an extra linefeed (ctrl-m) at the end of each line.
This is the format AMOS must have for inputting text files for some bizarre
reason.  Also, the puzzles are listed vertically ..  just type the
puzzles.txt file to see what i mean.

OK, so how do you add your own puzzles??  Well, say you want to add:  "This
programmer is messed up" to the puzzle list.  First you must decide the
best way to represent this puzzle on 4 lines, with 11 characters to each
line.  Each line is either what you want on that line, or an asterix to
denote a blank line.  My suggestion (which will follow the rest of the
puzzles) is:

this
programmer
is
messed up

Actually this is the only way to do it really :) But, now that you have
loaded up your fav text editor and loaded the puzzles.txt file ..  you then
type in the 4 lines, ending each line by typing CTRL-M, then return.  (Make
sure that you leave the -End- at the end of the file.)  Then, save the file
over top of puzzles.txt and now you have 1 new puzzle!  Please do not
attempt this if you are confused, EMAIL me first!

                        _______________________________
 ______________________/                               \__________________  
                       \         EMAIL ADDRESS         /
                        \_____________________________/


Look for other Beaty Softworks releases on the Net... like:

                        ---->  SIMPLICITY v1  <----

Which is a cool icon collection, much different than all the others..it
takes a different approach:  rather than make highly detailed, big .info's,
it uses a very simple and small design to save space and make using the WB
for people who don't need complicated graphics quicker.

                        ---->    DIAMONTES!   <----

This is my shareware version of Crystal Quest (classic game for the Mac)
for the Amiga!  I am in the final stages of producing this, and it has
some great graphics and animation.. but I am about to sell my 1200 for
financial reasons.  Hopefully I will work something out to keep this
great computer and finish Rueda 1.4 and Diamontes, but no promises!


Contact me at:  (or send a donation to further releases if you really like 
                 the game!)

gwj2565@risky.wcslc.edu  (don't know how long this account
                          will still be up, probably only
    -or-                  until June of '94 or so)

 Nathan Beaty 
 622 NE 11th             (permanant address, I'm always on the road but
 Newport, OR 97365        I'll check with this address often)

 - Nathan Beaty (skur)

eof
