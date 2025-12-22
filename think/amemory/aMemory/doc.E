                           aMemory  by  Tis Veugen

Introduction
============
 aMemory is the implementation of a well-known game which is being played
in several forms for a long time.  The game consists of a big amount of
small cards with pictures on one side.  There are always two cards with the
same picture.  At the beginning, the cards are laid down nicely in rows and
columns without seeing and knowing the picture.  Alternatively, two players
turn 2 cards, firstly one card and then the other.  The goal is to turn
cards with the same picture.  When two such cards have been found, they are
removed, and the same player "shoots" again.  At the end when all cards are
removed, the player with the most cards is the winner.
 The game is intended to train your memory.  Especially children of three
years and older, appear to be very successful for this game.  Therefore,
the program has been built such that even small children can control it
with a joystick (but also with the mouse).  For some options the mouse must
be used.
 The program has 2 screens, the menu screen and the play screen.

Menu screen
===========
 The 'cursor' is the small clown with the red hair and the blinking eyes.
Initially, it is placed at the '1' of the left column of digits.  You can
move this clown using the mouse as well as the joystick.  Using the
joystick is described firstly.
 With the joystick, you can push the clown to the left, the right, up,
down, or diagonally.  A choice is confirmed by pushing the fire button.
The two columns of digits belong to the possible player names.  The small
clowns with the orange hair indicates the names of the selected players.
The clown in the first column indicates the player to start.  It is
possible to play against the Amiga.  Simply select player 'Computer'.
 The playing level, a number between 0 and 9, can be selected at the top
right.  This only matters when the Amiga is your opponent.  At level "0"
the computer quickly forgets the already turned cards.  At level "9" the
computer remembers everything!
 At the right bottom, you can set the number of cards with multiples of 6.
The total screen can have 54 cards maximally.
 The two icons at the bottom of the screen are for starting the game (at
the left), and for finishing the program (at the right).
 The program contains a speech module, which tells the player to move.  The
speech can be toggled on or off with the icon at the bottom left.

 The icon at the top left indicates whether the names in the middle of the
screen are either the player names, or the names of the IFF-files
containing the pictures for the cards.  In the latter case, you can select
whether pictures are retrieved from an IFF-file (refer to 'Configuration').
An IFF-file is used, when it has a clown in the second column of digits. If
the cursor stands in the first column at an empty name, and you press the
fire button, then a file-requester appears for selecting the name of an
IFF-file.  Controlling this requester with the mouse (!) is
straightforward.  When clicking "OK" the IFF-file with pictures is added to
the list.  If the cursor stands in the first column at a present name, and
you press the fire button, then the file is removed from the list.
 The mouse and the joystick can both be used at the same time.  Just point
to an icon or a clown with the mouse, and press the left mouse button.

Play screen
===========
 You can select a card by pressing the fire button.  A player is able to
choose a card when the square 'cursor' is coloured red and white.  If the
'cursor' has colours green and black, then press to fire button to continue
the game.
 The little lamp in front of the player names indicates the player to move.
Furthermore, the speech module tells which player has to move.
 The yellow bar with the red border shows the current score.  When a pair
of cards has been found, both (!) bars change.  The player, whose bar is
full firstly, wins the game.
 The icon at the top left is used for returning to the menu screen.  To
avoid erros, you must press the fire button twice.

You can also use the following keys :
 Q      : quit program
 s      : toggle speech module on/off
 u      : joystick up
 d      : joystick down
 l      : joystick left
 r      : joystick right
 spatie : fire button
 <n>    : digit to change playing level

Configuration
=============
 There are 3 files, named ".files", ".names", ".talks", for configuring the
aMemory program.

 File ".talks" contains the texts prenounced by the speech module.  These
texts are made up of phonemes, and will be sent to the 'narrator.device'.
The phonemes are described in the "AMIGA ROM Kernel Reference Manual:
Libraries and Devices".  The tool 'phonemed' helps you at building the
phonemes.

 File ".names" contains the player names together with the phonetic texts.

 The pictures for the cards are (in modus HIRES) 64 pixels wide and 32
pixels high.  So, the size of an IFF-file containing pictures must be a
multiple of the width and height of a single picture.  The enclosed files
have been drawn by DPaintII, and (partly) saved as brush.  File
PICTOS.10.8.IFF is not a brush; on the contrary the others are brushes.
 The complete names of the IFF-files are in file ".files" .  At startup all
file names are read from ".files", and the IFF-files are copied to bitmaps.
The pictures of all files mentioned above require 203K memory, since a
single picture requires 1K.  In case of insufficient chip memory, the
program stops.
