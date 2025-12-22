MODULE attacks;

(*   This is the main module for the program Attacks.  It sets up the     *)
(* game, cleans up, and holds the main loop of the game.  There are a few *)
(* little routines in here to assist the main, but most of the routines   *)
(* are located in their respective modules.  Everything in here is writ-  *)
(* ten by me, except the menu module, which was written by Chris Mlsna    *)
(* and modified by me.  The menu module is probably the most useful for   *)
(* applying to your own programs, since its routines are not specifically *)
(* made for this program.  But don't blame me about Chris's lack of docu- *)
(* mentation!                                                             *)
(*                                                                        *)
(*   The whole thing was made using Avant-Garde's Benchmark Modula-2 by   *)
(* by Leon Frenkel.  As you can see, it actually does the job.            *)
(*                                                                        *)
(*   If you have any questions about this program or programming in gene- *)
(* ral, please feel free to contact me.  My address can be found in the   *)
(* program and in the doc file.  Hope you enjoy/learn/whatever!           *)
(*                                                                        *)
(*      Scott Biggs                                                       *)


(*$R-V-*) (* range checking OFF, overflow checking OFF *)

(****************************************)
(*      IMPORTS                         *)
(****************************************)

FROM header
  IMPORT   state, squaretype, boardsize, boardtype, movetype, boardrange,
           playertype, gameover, pointercode, currentpointer, difficulty,
           thinkertype, whoisred, whoisblue, printmsgtype, backedup;
FROM attacksgraphics
  IMPORT   InitializeScreen, DrawBoard, DrawSquare, CleanupGraphics,
           ChangePointer, ShowScore, PrintTurn, PrintMsg, ShowAbout;
FROM input
  IMPORT   moveAttempted, eventtype, GetEvent, InitMenus, CloseMenus,
           EditBoard, ChangeToEditMenu, ChangeToMainMenu,
           ChangeToComputerMenu;
FROM boards
  IMPORT   numboards, setup0, setup1, setup2, setup3, setup4;
FROM history
  IMPORT   InitHistory, PopHistory, CloseHistory, AddToHistory, NewHistory,
           UpHistory;
FROM thinker
  IMPORT   LegalMove, GoodMovePossible, DoMove, DoComputerMove;
FROM mdgenerallib
  IMPORT   MyPause;
FROM AmigaDOS
  IMPORT   DateStampRecord, DateStamp;
FROM RandomNumbers
  IMPORT   Seed, Random;
FROM TermInOut
  IMPORT   WriteLn, WriteString;


(************************************************************************)

PROCEDURE NewBoard (VAR newboard : boardtype);

(*   This chooses one of the available new boards at random and then   *)
(* makes the board that which was chosen.  It's up to the caller to do *)
(* anything with the new board variable.                               *)

VAR
  whichboard : CARDINAL;

BEGIN
  whichboard := CARDINAL (Random(numboards));
  INC(whichboard);
  CASE whichboard OF
     1  :  newboard := setup1;  |
     2  :  newboard := setup2;  |
     3  :  newboard := setup3;  |
     4  :  newboard := setup4;  |
     ELSE newboard := setup0;
     END;
END NewBoard;

(************************************************************************)

PROCEDURE setup;

VAR
  d : DateStampRecord;

BEGIN
  DateStamp(d);        (* init random generator   *)
  Seed := LONGCARD(d.dsDays * d.dsMinute * d.dsTick);

  IF NOT InitializeScreen() THEN               (* Sets up the graphix   *)
     WriteString("Couldn't initialize graphics.\n");
     HALT;
     END;
  difficulty := 2;        (* makes it kinda' good *)
  whoisred := human;
  whoisblue := computer;
  InitMenus;
  NewBoard(state.board);
  state.turn := red;
  ChangePointer (RedPointer);
  PrintTurn(red);
  currentpointer := RedPointer;
  DrawBoard(state.board);       (* Draws the board on the screen          *)
  IF NOT InitHistory(state.history, state.board, state.turn) THEN
     WriteString("Couldn't initialize the history.\n");
     HALT;
     END;
END setup;


(************************************************************************)
PROCEDURE Cleanup;
BEGIN
  CloseHistory(state.history);
  ChangePointer(DefaultPointer);
  currentpointer := DefaultPointer;
  CloseMenus;
  CleanupGraphics;
END Cleanup;


(************************************************************************)
PROCEDURE CheckForGameOver;

(*   This checks to see if only one player is remaining.  If so, then  *)
(* gameover is set to TRUE.                                            *)

VAR
  i, j : boardrange;
  any : BOOLEAN;

BEGIN
  any := FALSE;
  FOR i := 1 TO 7 DO  FOR j := 1 TO 7 DO       (* check for no reds *)
     IF state.board[i,j] = red THEN
        any := TRUE;
        END;
     END; END;
  IF any = FALSE THEN
     gameover := TRUE;
     RETURN;
     END;

  any := FALSE;
  FOR i := 1 TO 7 DO  FOR j := 1 TO 7 DO       (* check for no blues *)
     IF state.board[i,j] = blue THEN
        any := TRUE;
        END;
     END; END;
  IF any = FALSE THEN
     gameover := TRUE;
     END;
END CheckForGameOver;


(************************************************************************)
(*      MAIN                                                            *)
(************************************************************************)

VAR
event : eventtype;              (* Holds the code for the input events  *)
quit,                           (* True when the loop should be exited  *)
playmore : BOOLEAN;             (* Is FALSE when the game is over       *)
redscore, bluescore : CARDINAL; (* The respective scores.               *)
i, j : boardrange;
foo : BOOLEAN;                  (* used for scratch *)
fooboard : boardtype;
footurn : playertype;
otherplayer : playertype;


BEGIN
  setup;
  quit := FALSE;
  gameover := FALSE;
  backedup := FALSE;

REPEAT
  redscore := 0;    bluescore := 0;      (* doing the scores *)
  FOR i := 1 TO 7 DO
     FOR j := 1 TO 7 DO
        IF state.board[i,j] = red THEN
           INC(redscore);
           ELSE IF state.board[i,j] = blue THEN
                 INC(bluescore);
                 END;
           END;
        END;
     END;
  ShowScore(redscore, bluescore);

           (******************************)
           (* Check & DO computer's turn *)
           (******************************)

  IF (NOT gameover) AND
     (NOT backedup) AND
     (((state.turn = red) AND (whoisred = computer)) OR
     ((state.turn = blue) AND (whoisblue = computer)))
  THEN
     PrintMsg(Thinking);
     ChangeToComputerMenu;
     foo := DoComputerMove();
     IF NOT backedup THEN
        foo := AddToHistory(state.history, state.board, state.turn);
        END;
     ChangeToMainMenu;


           (**************************************)
           (* otherwise, get an event and do it! *)
           (**************************************)
  ELSE
     event := GetEvent(state.turn);
     IF state.turn = red THEN
        otherplayer := blue;
        ELSE otherplayer := red;
        END;

     CASE event OF

        NEWGAME  :
           gameover := FALSE;
           backedup := FALSE;
           NewBoard(state.board);
           state.turn := red;
           DrawBoard(state.board);
           NewHistory(state.history, state.board, state.turn);
           |

        EDIT     :
           ChangeToEditMenu;
           IF EditBoard(state.board, state.turn) THEN
              foo := AddToHistory(state.history, state.board, state.turn);
              IF GoodMovePossible(state.board, state.turn) THEN
                 gameover := FALSE;
                 ELSE
                    IF state.turn = red THEN
                       otherplayer := blue;
                       ELSE otherplayer := red;
                       END;
                    IF GoodMovePossible(state.board, otherplayer) THEN
                       state.turn := otherplayer;
                       gameover := FALSE;
                       ELSE gameover := TRUE;
                       END;
                 END;
              END;
           ChangeToMainMenu;
           |

        QUIT     :
           quit := TRUE;
           |

        MOVE    :
           IF LegalMove(moveAttempted) THEN
              foo := DoMove(moveAttempted);
              foo := AddToHistory(state.history, state.board, state.turn);
              backedup := FALSE;
              END;
           |

        FORCE    :
           IF NOT gameover THEN
              PrintMsg(Thinking);
              ChangeToComputerMenu;
              foo := DoComputerMove();
              IF NOT backedup THEN
                 foo := AddToHistory(state.history, state.board, state.turn);
                 END;
              backedup := FALSE;
              ChangeToMainMenu;
              END;
           |

        ABOUT    :
           ShowAbout;
           |

        BACKUP   :
              IF PopHistory(state.history, state.board, state.turn) THEN
                 gameover := FALSE;
                 backedup := TRUE;
                 DrawBoard (state.board);
                 END;
              |

        REDO     :
              IF UpHistory(state.history, state.board, state.turn) THEN
                 backedup := TRUE;
                 DrawBoard (state.board);
                 IF (NOT GoodMovePossible(state.board, red)) AND
                    (NOT GoodMovePossible(state.board, blue))
                    THEN
                       gameover := TRUE;
                    END;
                 END;
                 |

        OOPS     :              (* The right button was hit w/o  *)
                 |              (*  selecting a menu. Do nada.   *)

    END; (* CASE *)

  END; (* if computer's turn *)

  CheckForGameOver;
  IF gameover THEN                 (* Takes care of the messages *)
     PrintMsg(GameOver);
     ChangePointer(DefaultPointer);
     ELSE PrintTurn(state.turn);
        IF state.turn = red THEN
           ChangePointer(RedPointer);
           currentpointer := RedPointer;
           ELSE ChangePointer(BluePointer);
                currentpointer := BluePointer;
           END;
     END;

UNTIL quit = TRUE;

Cleanup;

END attacks.
