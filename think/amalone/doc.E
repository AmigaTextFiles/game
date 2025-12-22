Documentation of aMalone
========================

Rules of the game
-----------------
A player can move 1, 2, or 3 marbles of its own color to neighbour squares
on the game board. Two or three marbles to be moved must lie connected on
a straight line. The marbles can be moved in 6 directions, but not outside
the board. Besides, a move with 2 or 3 marbles may push one or two
opponent marbles. This is only allowed when the opponent marbles lie on
the same line as the players marbles, and when all marbles are connected.
The number of pushing marbles must exceed the number of opponent marbles.
Hence, the possible configurations are 2 against 1, 3 against 1, 3 against
2. The outmost opponent marble must be pushed to an empty square, or
outside the board. A player, who has pushed 6 opponent marbles outside the
board, wins the game.

Notation
--------
A notation has been defined for the moves. This enables saving a game on
disk, and loading it afterwards.
Firstly, the notation for the squares is explained. The board has 61
squares, namely the centre and 6 groups of 10 squares. Each group
corresponds to a side of the hexagonal board. The groups/sides are
numbered A, B, C, D, E, F. The centre is named GG. Player black is in
front of group A, and player white in front of group D. The order of the
groups is anti-clockwise. On the screen, each group of the playing board
has its own hue. The squares of a group are numbered 0, 1, .. , 9 . The
number increases from centre to border, and from left to right. Hence, the
squares are named :

          E6  D9  D8  D7  D6

        E7  E3  D5  D4  D3  C9

      E8  E4  E1  D2  D1  C5  C8

    E9  E5  E2  E0  D0  C2  C4  C7

  F6  F3  F1  F0  GG  C0  C1  C3  C6

    F7  F4  F2  A0  B0  B2  B5  B9

      F8  F5  A1  A2  B1  B4  B8

        F9  A3  A4  A5  B3  B7

          A6  A7  A8  A9  B6

The notation of a move is as follows : <n><s1>-<s2><x>
<n>  = the number of playing marbles, viz. '1', '2', '3'
<s1> = the current square of the top-marble of a row
<s2> = the square to which the top-marble is moved
<x>  = 'l' when the row is moved to the left
     = 'r' when the row is moved to the right
     = '+' when an opponent marble is pushed outside the board
     = empty, when a row is moved straightly, without pushing an
       opponent marble outside the board

Examples :
- Black marble at B0 is moved to GG ==> 1B0-GG
- Black marbles at A0, A1, A3 are moved to F0, F2, F5 ==> 3A0-F0l
- Black marbles at GG, B0 are moved to D0, C0 ==> 2GG-D0r
- Black marbles at E2, F0, A0 push two white marbles at E4, E7 ==> 3E2-E4+

Setup a position
----------------
The little lamp indicates the player who begins. If you press the left
mouse button above a square, then a marble appears with the color of this
player. If such a marble was already there, then it disappears. If you press
the right mouse button, then a marble appears with the opponent color.

Help
----
File 'help.L' contains the name of the file, which is listed by the programs
help-function, e.g. 'help.doc.E'.

Program start
-------------
Program aMalone can be started by clicking the icon. By default, the
program has a buffer of 512 plies, i.e. 256 whole moves. When the
buffer is too small, then save the game. Restart the program in the CLI
with the maximum number of plies as argument, e.g. : aMalone 1024


At last, I would like to wish you much pleasure at playing aMalone. I
recommend you to buy the original game (abalone), because it is a lot of
fun to move the real marbles over the board.
