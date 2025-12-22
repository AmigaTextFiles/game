Welcome to my very first (completed) Amiga game.

The game principle of Wordle according to German Wikipedia: 
The word you are looking for consists of five letters and must be placed in 
square,  adjacent fields, similar to a crossword puzzle.  There are a total of 
six attempts for each word. Unlike the crossword puzzle, however, there are no
clues as to the content of the the solution word. The game mechanics are 
similar to games such as Mastermind. 

The player enters any five-letter word in the first line , whereupon the 
letters are highlighted in color: A gray background  stands for letters that 
do not appear in the searched word; yellow background stands for letters that 
occur elsewhere in the searched word and green background for letters that 
appear in the same position in the searched word. 

Now the player has the opportunity to approach the searched word in the five 
following lines. The aim of the word game is to find the word you are looking 
for in as few attempts as possible.

This game has been modeled to the best of my knowledge on the game principle 
of the original game by Josh Wardle. It runs from Kick/WB 1.2 on an 
unaccelerated Amiga with 1MB RAM (512kb ChipRAM and 512kb SlowRAM are 
sufficient). It has also been successfully tested on Kick 3.2, 68060 and lots 
of RAM.

The operation of the game should be self-explanatory. When starting the game, 
a language selection screen appears first. Depending on which language you 
choose, the interface is localized and, of course, only terms in the 
corresponding language are queried. In addition, the key assignment of the 
virtual keyboard is adapted to the appropriate layout (Z and Y are swapped). 

You only play with the mouse. After each entry of a valid(!) word, e.g. "ABCDE"
is not accepted, a check is made to see whether the word entered matches the 
solution word being sought. If a letter is in the correct position, it is 
colored green in the line of the trial as well as the key on the virtual 
keyboard. If a letter is contained in the solution word but in a different 
position, it is colored yellow (as is the key on the virtual keyboard). If the
letter is not contained in the solution word, it is colored grey.

The statistics are only saved to the hard disk/diskette when the game is ended 
by pressing the "End" or "Quit" button. The current streak is retained over 
various game sessions as long as the solution is guessed.


Future: 
Bugfixes, if necessary.


New features in V1.2:
- The game is now also available in a French version.

- The QWERTY keyboard in the English version did not work correctly.

- A few intentional waiting pauses have been shortened to make the game a little
  "snappier". Now it no longer feels like the computer is overloaded... 
  (which even an A500 never was)

- The graphics have been minimally changed. No one will probably notice, but
  I was bothered by a superfluous pixel...


New features in V1.1: 
- The game is no longer only playable in German, but if you are interested 
  also in English.

- The loading process has been optimized a little, so that it is a little faster 
  from floppy disk. If it is copied to hard disk, you should not notice any 
  difference. 

- If you want to keep your statistics from the old version, simply copy the 
  file "score" from the old directory to the new one.


I would be very pleased to receive feedback. An encouraging "Thanks for the 
game, I'm having a lot of fun!" increases the motivation enormously to 
continue working on games in the future. If you notice a word that should at 
least be included in the "comparison list" but is not accepted as a "unknown 
word", please let me know. With just under 7500 German and almost 6000 English
words, the comparison list is not small, but certainly not complete.


Acknowledgments: 

- Karl Jeacle for the help with the English word lists and for beta testing
 
- Mickaël "BatteMan" Pernot for the French translation and word lists and
  for beta testing
 
- All members of the A1K forum for testing the pre-release version and many 
  warm words. 
   
- Rob Cranley and Don Adam for tips



Have fun.

Andreas "Etze" Gouders
E-Mail: a-etze(at)gmx.de
