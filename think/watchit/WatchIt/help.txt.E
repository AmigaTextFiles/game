    INTRODUCTION
    ============
Program WatchIt is the computer version of a game well-known in the
Netherlands by the name 'Onderuit'.  The original game is played with real
turning wheels mounted on both sides of a vertical board.  So, a player
can't watch the opponent marbles.  Although, after thoroughly investigating
the position of the holes in each wheel, and having a fabulous memory, it
should be possible to known the complete opponent configuration.  For a
computer this is very easy.  That's the reason why in this program the game
is played with complete information about the opponent.


    RULES
    =====
Initially, all 10 marbles are in the holes at the upper side.  The goal of
the game is to move all your own marbles to the holes at the lower side.
The player reaching this goal firstly, is the winner; and the game ends.  A
marble may fall inside a hole of a wheel, and it may also fall outside that
hole.  By turning the wheels you can move the marbles each time one wheel
further downwards.  Since the wheels at the front side and at the rear side
are "fixed" together, you are able to thwart your opponent.  But, sometimes
you must help your opponent to make some progress on your own.  When it's
your turn, you select a wheel and turn it forth and back as much as you
wish.  However, it is forbidden to select the wheel used by your opponent
at his latest turn.  There is one exception to this rule:  you may always
turn the bottom wheel with the 5 holes, when you are able to finish the
game.
The numbers of the marbles do not matter in the current version of the
program.  It is allowed to put the marbles in the bottom holes in arbitrary
order.


    INSTALLATION
    ============
WatchIt needs the following files :
  WatchIt.info  WorkBench icon
  screen.iff    user interface screen
  help.txt.D    help text in German
  help.txt.E    help text in English
  help.txt.N    help text in Dutch
  help.txt      copy of help.txt.E
Furthermore, the font ruby/12 is needed.
The program can be started from the WorkBench or from the CLI.  The
possible CLI options are :

  -h<depth>   set the depth of the history buffer (512)
  -m<number>  set the number of moves for the computations (10000)

The move counter in the middle of the screen shows the actual depth of the
history buffer.  When a game takes longer than 512 moves, then the history
buffer needs to be enlarged.  Firstly, save the game; then, restart the
program using option -h; finally, load the game and proceed.
The operating syteem version OS 2.04 is required.


    USER INTERFACE
    ==============
You can turn a wheel by clicking on it with the mouse.  Clicking at the
right half forces the wheel to turn to the right, in clockwise direction.
Clicking at the left half forces the wheel to turn to the left, in
anti-clockwise direction.  The wheel keeps turning as long as you press the
mouse button.  However, the wheel stops at an opening to a neighbouring
wheel.  This is handy for correctly positioning the wheel to fetch or
deliver a marble.  You must release the mouse button and press it again to
continue.  Note that you may turn the wheel forth and back as long as you
wish.  When you turn a wheel once, then the small black vertical bar in the
centre of the wheel disappears.  The wheel used by your opponent at the
previous turn is marked by a blue cross in the centre of the wheel.  You
indicate the end of your turn by clicking at the opponent's screen half.
The little lamp beside the player names tells the player to move.  The
(sub)menus have the following meaning :

   Project        General control.
     New game     Start a new game.
     Save game    Save a game.
     Load game    Load a game.
     Help         Show the help text.
     Quit         Stop the program.

   Move           Traverse some moves forward or backward.
     Begin        Go to the first move. This is handy for replay.
     Back-1       Go backward a single move.
     Back-2       Go backward two moves.
     Forward      Go forward a single move. This is only possible after
                  stepping backwards one or more moves.
     End          Go to the latest move.
     Compute      The computer calculates a move; this can be used when
                  actually a human has to move.

   Players        Tell the kind of players.
     Player 1     Tell player 1.
       Human      A human is player 1.
       Name       Enter your name, and play as player 1.
       Amiga      The computer plays as player 1.
     Player 2     Tell player 2.
       Human      analoguously to 'Player 1'
       Name       analoguously to 'Player 1'
       Amiga      analoguously to 'Player 1'

   Profile        Adjust the computer settings for calculating a move.
     Level        Enter the level between 1 and 9. At level '4' (the
                  default level) the computer calculates 4 moves ahead.
     Selectivity  Search selectively the best move by taking into
                  account only the best 3 possibilities per wheel.
                  In case of 'none' all possibilities are taken into
                  account.  In case of a number 'x' the selectivity only
                  refers to the 'x' lowest search depths.  At a selectivity
                  of '4' the default selectivity) and level '4' the
                  selectivity applies to each search depth.  At a
                  selectivity of e.g. '3' all moves are taken into account
                  at the highest search depth, but at the 3 other, lower
                  search depths the selectivity applies.

     Search move  Select a move according to 3 criterions :
       first      Play the optimal move, the first one in the row.
       ties       When more optimal moves exist with equal evaluation,
                  then choose an arbitrary one.
       random     Play an arbitrary good move. This option guarantees
                  more variation in the computer's moves.
     Player 1     Determine the profile for player 1.
       snap       Fix the current settings 'Level', 'Selectivity',
                  and 'Search move' for player 1.
       free       Release the fixed profile : use the actual profile.
     Player 2     Determine the profile for player 2.
       snap       analoguously to 'Player 1'
       free       analoguously to 'Player 1'




  COPYRIGHTS
  ==========
Program WatchIt is ©opyright by Tis Veugen, February 1995.
Distribution for non-commercial purposes is granted.
                       __
            ________  / /
            \__  __/ / /
Tis Veugen     \ \  / /
Schubertlaan 2  \ \/ /
5583 XW Waalre   \__/
The Netherlands
