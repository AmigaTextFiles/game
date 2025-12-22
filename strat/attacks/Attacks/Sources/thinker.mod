IMPLEMENTATION MODULE thinker;

(*$R-V-*)        (* Range checking OFF, overflow checking OFF *)

(*   This module handles all the routines necessary for the computer to   *)
(* to play.  It also has some routines that are convenient for checking   *)
(* to see if the human player screwed up or not.                          *)

FROM attacksgraphics
  IMPORT   ChangePointer, DrawSquare, mywindowptr;
FROM header
  IMPORT   state, movetype, boardrange, boardtype, playertype, squaretype,
           allmovestype, difficulty, pointercode, gameover, currentpointer,
           backedup, maxmovetypemoves;
FROM mdgenerallib
  IMPORT   RealRandom, MyPause;
FROM Intuition
  IMPORT   IDCMPFlags, IntuiMessagePtr, MENUNUM, ITEMNUM;
FROM Ports
  IMPORT   GetMsg, ReplyMsg;
FROM RandomNumbers
  IMPORT   Random;
FROM TermInOut
  IMPORT   WriteString, WriteLn, WriteCard, WriteInt;


CONST
  winnumber  =  100;            (* This is number returned for a WIN.  *)
  losenumber = -100;            (* This one's for a LOSE.              *)
  ranpick = 0.1;                (* This tells how smart it is for diff *)
                                (*  level 2.                           *)
  maxmoves = 400;               (* The maximun number of moves genera- *)
                                (*  ted per level.                     *)
  numwhich = 5;                 (* Tells how many guesses the computer *)
                                (*  gets when doing difficulty 2.      *)

VAR
  interrupt : BOOLEAN;          (* When this is TRUE, then the compu-  *)
                                (*  ter's move is to be aborted.       *)
  imessageptr : IntuiMessagePtr;   (* Points to an intuimessage     *)

(************************************************************************)
PROCEDURE OtherPlayer (player : playertype) : playertype;

(*   Simply returns the other player     *)
BEGIN
  IF player = red THEN
     RETURN blue;
     END;
  RETURN red;
END OtherPlayer;

(************************************************************************)
PROCEDURE LegalMove (move : movetype) : BOOLEAN;

(*   This simply checks to see if the given move is a valid move, con- *)
(* sidering the current state of the game.  It is NOT assumed that     *)
(* the initial component of the move is valid.  It does NOT assume     *)
(* both of the move components are valid locations.  But it does as-   *)
(* sume that the board has been properly initialized so that the outer *)
(* edges are blocks.  It operates using the global variable, state.    *)

VAR
  legal : BOOLEAN;
  checkx, checky : boardrange;     (* used to see if moves are in range *)

BEGIN
  legal := FALSE;
  IF (state.board[move.fromX, move.fromY] = state.turn) AND
     (state.board[move.toX,move.toY] = empty) THEN
     IF move.toX > move.fromX THEN
        checkx := move.toX - move.fromX;
        ELSE checkx := move.fromX - move.toX;
        END;
     IF move.toY > move.fromY THEN
        checky := move.toY - move.fromY;
        ELSE checky := move.fromY - move.toY;
        END;
     IF (checkx < 3) AND (checky < 3) THEN
        legal := TRUE;
        END;
     END;

  RETURN legal;
END LegalMove;


(**************************************************************************)
PROCEDURE FindAllMoves (VAR board : boardtype; player : playertype;
                        VAR moves : allmovestype);

(*   This procedure finds all the possible moves for player in the posi-  *)
(* tion of the given board.  The resultant moves are stored in the vari-  *)
(* able, moves.  If there are no moves possible, then moves.nummoves = 0. *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            board                Of boardtype.  It describes the state  *)
(*                                 of the board in question.              *)
(*                                                                        *)
(*            player               This tells which side (player) this    *)
(*                                 procedure checks the moves for.        *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            moves                The data structure that holds all the  *)
(*                                 moves.                                 *)
VAR
  i, j : boardrange;

BEGIN
  moves.nummoves := 0;
  FOR i := 1 TO 7 DO   FOR j := 1 TO 7 DO
     IF board[i,j] = player THEN
        IF (moves.nummoves < maxmoves) AND (board[i-2,j-2] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i - 2;
           moves.moves[moves.nummoves].toY := j - 2;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i-2,j-1] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i - 2;
           moves.moves[moves.nummoves].toY := j - 1;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i-2,j] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i - 2;
           moves.moves[moves.nummoves].toY := j;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i-2,j+1] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i - 2;
           moves.moves[moves.nummoves].toY := j + 1;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i-2,j+2] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i - 2;
           moves.moves[moves.nummoves].toY := j + 2;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i-1,j-2] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i - 1;
           moves.moves[moves.nummoves].toY := j - 2;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i-1,j-1] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i - 1;
           moves.moves[moves.nummoves].toY := j - 1;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i-1,j] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i - 1;
           moves.moves[moves.nummoves].toY := j;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i-1,j+1] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i - 1;
           moves.moves[moves.nummoves].toY := j + 1;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i-1,j+2] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i - 1;
           moves.moves[moves.nummoves].toY := j + 2;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i,j-2] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i;
           moves.moves[moves.nummoves].toY := j - 2;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i,j-1] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i;
           moves.moves[moves.nummoves].toY := j - 1;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i,j+1] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i;
           moves.moves[moves.nummoves].toY := j + 1;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i,j+2] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i;
           moves.moves[moves.nummoves].toY := j + 2;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i+1,j-2] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i + 1;
           moves.moves[moves.nummoves].toY := j - 2;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i+1,j-1] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i + 1;
           moves.moves[moves.nummoves].toY := j - 1;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i+1,j] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i + 1;
           moves.moves[moves.nummoves].toY := j;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i+1,j+1] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i + 1;
           moves.moves[moves.nummoves].toY := j + 1;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i+1,j+2] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i + 1;
           moves.moves[moves.nummoves].toY := j + 2;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i+2,j-2] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i + 2;
           moves.moves[moves.nummoves].toY := j - 2;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i+2,j-1] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i + 2;
           moves.moves[moves.nummoves].toY := j - 1;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i+2,j] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i + 2;
           moves.moves[moves.nummoves].toY := j;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i+2,j+1] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i + 2;
           moves.moves[moves.nummoves].toY := j + 1;
           END;
        IF (moves.nummoves < maxmoves) AND (board[i+2,j+2] = empty) THEN
           IF moves.nummoves = maxmovetypemoves THEN
              RETURN;
              END;
           INC(moves.nummoves);
           moves.moves[moves.nummoves].fromX := i;
           moves.moves[moves.nummoves].fromY := j;
           moves.moves[moves.nummoves].toX := i + 2;
           moves.moves[moves.nummoves].toY := j + 2;
           END;
        END;
     END; END;
END FindAllMoves;

(********************************************************)
PROCEDURE GoodMovePossible (board : boardtype; player : playertype)
                            : BOOLEAN;
(*   This procedure returns TRUE only if on the given board, player has   *)
(* has a legal move available. It returns FALSE otherwise.                *)

VAR
  good : BOOLEAN;
  i,j : CARDINAL;

BEGIN
  FOR i := 1 TO 7 DO
    FOR j := 1 TO 7 DO
      IF board[i,j] = player  THEN
        IF board[i-2,j-2] = empty THEN RETURN(TRUE); END;
        IF board[i-1,j-2] = empty THEN RETURN(TRUE); END;
        IF board[i,j-2] = empty THEN RETURN(TRUE); END;
        IF board[i+1,j-2] = empty THEN RETURN(TRUE); END;
        IF board[i+2,j-2] = empty THEN RETURN(TRUE); END;
        IF board[i-2,j-1] = empty THEN RETURN(TRUE); END;
        IF board[i-1,j-1] = empty THEN RETURN(TRUE); END;
        IF board[i,j-1] = empty THEN RETURN(TRUE); END;
        IF board[i+1,j-1] = empty THEN RETURN(TRUE); END;
        IF board[i+2,j-1] = empty THEN RETURN(TRUE); END;
        IF board[i-2,j] = empty THEN RETURN(TRUE); END;
        IF board[i-1,j] = empty THEN RETURN(TRUE); END;
        IF board[i+1,j] = empty THEN RETURN(TRUE); END;
        IF board[i+2,j] = empty THEN RETURN(TRUE); END;
        IF board[i-2,j+1] = empty THEN RETURN(TRUE); END;
        IF board[i-1,j+1] = empty THEN RETURN(TRUE); END;
        IF board[i,j+1] = empty THEN RETURN(TRUE); END;
        IF board[i+1,j+1] = empty THEN RETURN(TRUE); END;
        IF board[i+2,j+1] = empty THEN RETURN(TRUE); END;
        IF board[i-2,j+2] = empty THEN RETURN(TRUE); END;
        IF board[i-1,j+2] = empty THEN RETURN(TRUE); END;
        IF board[i,j+2] = empty THEN RETURN(TRUE); END;
        IF board[i+1,j+2] = empty THEN RETURN(TRUE); END;
        IF board[i+2,j+2] = empty THEN RETURN(TRUE); END;
        END; (* main if *)
      END;  (* for j *)
    END; (* for i *)
  RETURN FALSE;       (* if it made it this far, then there's no moves *)
END GoodMovePossible;


(**************************************************************************)
PROCEDURE GetAMove (VAR amove : movetype;  VAR moves : allmovestype)
                    : BOOLEAN;

(*   The variable, amove, will be changed to hold one of the moves held   *)
(* in moves.  If there are no moves, then the function will return FALSE. *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            moves             A variable of allmovestype.  It holds a   *)
(*                              list of all the possible moves.           *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            amove             Of movetype.  This is simply one of the   *)
(*                              moves held in moves.                      *)
(*                                                                        *)
(*            moves             Will be changed to reflect the removal of *)
(*                              the move from this data structure.        *)
(*                                                                        *)
(*            This function returns TRUE normally.  When moves holds no   *)
(*            moves (ie, moves.nummoves = 0) then this returns FALSE.     *)
(*            The variable amove will then be unchanged.                  *)

BEGIN
  IF moves.nummoves = 0 THEN
     RETURN FALSE;
     END;
  amove := moves.moves[moves.nummoves];
  DEC(moves.nummoves);
  RETURN TRUE;
END GetAMove;


(**************************************************************************)
PROCEDURE MakeNewBoard (oldboard : boardtype;  VAR newboard : boardtype;
                        move : movetype;  player : playertype);

(*   This procedure makes the newboard that results from the application  *)
(* of the given move.  There is no error checking here.  It is assumed    *)
(* that the move is legal.  The player is the person who is moving.       *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            oldboard          A variable of boardtype.  This is the     *)
(*                              state before the move is made.            *)
(*                                                                        *)
(*            move              This describes the move to be made in     *)
(*                              movetype notation.                        *)
(*                                                                        *)
(*            player            The player who is making the move.        *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            newboard          The board that is the result of the move. *)

VAR
  other : playertype;

BEGIN
  newboard := oldboard;
  other := OtherPlayer(player);

  newboard[move.toX,move.toY] := player;    (* add the new square *)

           (*** check to see if old square should be erased ***)
  IF (move.fromX > move.toX) AND (move.fromX-2 = move.toX) OR
     (move.fromX < move.toX) AND (move.fromX+2 = move.toX) OR
     (move.fromY < move.toY) AND (move.fromY+2 = move.toY) OR
     (move.fromY > move.toY) AND (move.fromY-2 = move.toY) THEN
     newboard[move.fromX, move.fromY] := empty;
     END;

  IF oldboard[move.toX-1, move.toY-1] = other THEN
     newboard[move.toX-1, move.toY-1] := player;
     END;
  IF oldboard[move.toX-1, move.toY] = other THEN
     newboard[move.toX-1, move.toY] := player;
     END;
  IF oldboard[move.toX-1, move.toY+1] = other THEN
     newboard[move.toX-1, move.toY+1] := player;
     END;
  IF oldboard[move.toX, move.toY-1] = other THEN
     newboard[move.toX, move.toY-1] := player;
     END;
  IF oldboard[move.toX, move.toY+1] = other THEN
     newboard[move.toX, move.toY+1] := player;
     END;
  IF oldboard[move.toX+1, move.toY-1] = other THEN
     newboard[move.toX+1, move.toY-1] := player;
     END;
  IF oldboard[move.toX+1, move.toY] = other THEN
     newboard[move.toX+1, move.toY] := player;
     END;
  IF oldboard[move.toX+1, move.toY+1] = other THEN
     newboard[move.toX+1, move.toY+1] := player;
     END;
END MakeNewBoard;


(**************************************************************************)
PROCEDURE CountScore (board : boardtype; player : playertype)
                       : INTEGER;

(*   Given a board and a player, this function returns the player's score *)
(* (that is, for the computer part of the calculations).                  *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            board                This is the board that will be scanned *)
(*                                 to calculate the score.                *)
(*                                                                        *)
(*            player               The player who's score is wanted.      *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            The function returns the number of player's pieces on the   *)
(*            board minus the numbe of opposing pieces.                   *)

VAR
  i, j : boardrange;
  score : INTEGER;
  otherplayer : playertype;

BEGIN
  otherplayer := OtherPlayer(player);
  score := 0;
  FOR i := 1 TO 7 DO
     FOR j := 1 TO 7 DO
        IF board[i, j] = player THEN
           INC(score);
           ELSIF board [i, j] = otherplayer THEN
              DEC(score);
           END;
        END;
     END;
  RETURN score;
END CountScore;


(************************************************************************)
PROCEDURE GameOver;

(*   This is a little thing when the game is over.                     *)

BEGIN
  ChangePointer (DefaultPointer);
  currentpointer := DefaultPointer;
  gameover := TRUE;
END GameOver;


(***********************************************************************)
PROCEDURE DoMove (move : movetype) : BOOLEAN;

(*      This does the necessary changes to facilitate a move in the    *)
(* game.  It involves, finding out if the piece grows or jumps, alter- *)
(* ing the board to reflect this, update the history, and change the   *)
(* graphics.  Lastly, don't forget to change the player's turn!  Oh    *)
(* yeah, I did in fact forget.  Change the colors of all the opponents *)
(* who are adjacent to the new blob!                                   *)
(*      This routine returns TRUE if there's a move available.  It     *)
(* will return FALSE when the game is over.                            *)

VAR
  checkx, checky : boardrange;
  otherplayer : playertype;

BEGIN
  (* prelims *)
IF state.turn = red THEN              (* find other player's color *)
  otherplayer := blue;
  ELSE otherplayer := red;
  END;

     (** Is it a grow or a jump? **)
IF move.toX > move.fromX THEN
  checkx := move.toX - move.fromX;
  ELSE checkx := move.fromX - move.toX;
  END;
IF move.toY > move.fromY THEN
  checky := move.toY - move.fromY;
  ELSE checky := move.fromY - move.toY;
  END;

IF (checkx = 2) OR (checky = 2) THEN     (* It's a jumper! Undraw blob. *)
  state.board[move.fromX, move.fromY] := empty;
  DrawSquare(move.fromX, move.fromY, empty);
  END;

state.board[move.toX, move.toY] := state.turn;    (* Draw new blob. *)
DrawSquare (move.toX, move.toY, state.turn);

     (****************************************************)
     (* checking (and changing) all the adjacent squares *)
     (****************************************************)

IF (move.toX # 1) AND (move.toY # 1)
  AND (state.board[move.toX - 1, move.toY - 1] = otherplayer) THEN
     state.board[move.toX - 1, move.toY - 1] := state.turn;
     DrawSquare(move.toX - 1, move.toY - 1, state.turn);
  END;
IF (move.toY # 1)
  AND (state.board[move.toX, move.toY - 1] = otherplayer) THEN
     state.board[move.toX, move.toY - 1] := state.turn;
     DrawSquare(move.toX, move.toY - 1, state.turn);
  END;
IF (move.toX # 7) AND (move.toY # 1)
  AND (state.board[move.toX + 1, move.toY - 1] = otherplayer) THEN
     state.board[move.toX + 1, move.toY - 1] := state.turn;
     DrawSquare(move.toX + 1, move.toY - 1, state.turn);
  END;
IF (move.toX # 7)
  AND (state.board[move.toX + 1, move.toY] = otherplayer) THEN
     state.board[move.toX + 1, move.toY] := state.turn;
     DrawSquare(move.toX + 1, move.toY, state.turn);
  END;
IF (move.toX # 7) AND (move.toY # 7)
  AND (state.board[move.toX + 1, move.toY + 1] = otherplayer) THEN
     state.board[move.toX + 1, move.toY + 1] := state.turn;
     DrawSquare(move.toX + 1, move.toY + 1, state.turn);
  END;
IF (move.toY # 7)
  AND (state.board[move.toX, move.toY + 1] = otherplayer) THEN
     state.board[move.toX, move.toY + 1] := state.turn;
     DrawSquare(move.toX, move.toY + 1, state.turn);
  END;
IF (move.toX # 1) AND (move.toY # 7)
  AND (state.board[move.toX - 1, move.toY + 1] = otherplayer) THEN
     state.board[move.toX - 1, move.toY + 1] := state.turn;
     DrawSquare(move.toX - 1, move.toY + 1, state.turn);
  END;
IF (move.toX # 1)
  AND (state.board[move.toX - 1, move.toY] = otherplayer) THEN
     state.board[move.toX - 1, move.toY] := state.turn;
     DrawSquare(move.toX - 1, move.toY, state.turn);
  END;

IF GoodMovePossible(state.board, otherplayer) = TRUE THEN
  state.turn := otherplayer;      (* modifying whose turn it is *)
  ELSE
     IF GoodMovePossible(state.board, state.turn) = FALSE THEN
     GameOver;
     RETURN FALSE;
     END;
  END;

  RETURN TRUE;
END DoMove;


(**************************************************************************)
PROCEDURE EvalMove (VAR board : boardtype;  turn : playertype;
                    player : playertype;  level : CARDINAL)
                    : INTEGER;

(*   This is one of the most important procedures in the program.  It     *)
(* gives a rating for a given board that (hopefully) indicates the rela-  *)
(* tive value of this board for the given player.  A rating of 0 is a     *)
(* totally neutral rating.  Otherwise, the higher the number, the better  *)
(* the board should be for the player.  It works recursively.  The rat-   *)
(* ing of a board is the average of the ratings of the boards that can    *)
(* be generated from the board.  At the leaves of the tree, the rating is *)
(* simply how many of player's pieces there are minus its opponent's      *)
(* pieces.                                                                *)
(*   Change on Feb 12:  I've changed this so that the value returned is   *)
(* either the HIGHEST or the LOWEST value found, depending upon which     *)
(* level it is working.  This way, if it is the computer's turn to move,  *)
(* it will return the maximum value for the next level.  Otherwise, if    *)
(* it's the other's turn to move (in the projected game) then it will     *)
(* assume that the other will make the best move, resulting in a Minimum  *)
(* score for the computer.  I hope this works better than the average.    *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            board             A variable of boardtype.  This is the     *)
(*                              state that we are trying to evaluate.     *)
(*                                                                        *)
(*            turn              Who's turn is it right now?  May or may   *)
(*                              not be the player.                        *)
(*                                                                        *)
(*            player            The player in question that wants the     *)
(*                              board evaluated.  The result is in terms  *)
(*                              of this player.                           *)
(*                                                                        *)
(*            level             This tells how many levels deep the re-   *)
(*                              cursion is going.  It is the method of    *)
(*                              stopping the recursion.                   *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            This returns an integer representing the value of the given *)
(*            board to the player.                                        *)

VAR
  allmoves : allmovestype;         (* Holds all the moves from this board *)
  move : movetype;
  newboard : boardtype;
  otherturn : playertype;
  score, tempscore : INTEGER;
i,j : boardrange;

BEGIN
(*WriteString("Entering EvalMove\n");
IF turn = red THEN
  WriteString("   turn = red\n");
ELSE
  WriteString("   turn = blue\n");
  END;
IF player=red THEN
  WriteString("   player = red\n");
ELSE
  WriteString("   player = blue\n");
  END;
WriteString("   level = ");WriteCard(level,1);WriteLn;
WriteString("   board:\n");
FOR i := 1 TO 7 DO
  FOR j := 1 TO 7 DO
     WriteCard(ORD(board[j,i]),3);
     END;
  WriteLn;
  END;
*)
  imessageptr := GetMsg(mywindowptr^.UserPort^);  (* Did user abort? *)
  IF imessageptr # NIL THEN
     IF (MenuPick IN imessageptr^.Class) AND
        (MENUNUM(imessageptr^.Code) = 0) AND
        (ITEMNUM(imessageptr^.Code) = 0) THEN
        interrupt := TRUE;
        END;
     ReplyMsg(imessageptr);
     END;
  IF interrupt THEN RETURN 0;         (* user has aborted computer move *)
     END;

  IF level = 1 THEN                      (***  Base case  ***)
(*WriteString("Exiting EvalMove from the base case\n");*)
     RETURN CountScore(board, player);
     END;

  otherturn := OtherPlayer(turn);
  FindAllMoves(board, turn, allmoves);

  IF ODD(level) THEN                     (*** Set initial score  ***)
     score := MIN(INTEGER);
     ELSE score := MAX(INTEGER);
     END;

  IF allmoves.nummoves = 0 THEN          (***  No moves for turn  ***)
     FindAllMoves(board, otherturn, allmoves);
     IF allmoves.nummoves = 0 THEN
        IF player = turn THEN
           RETURN losenumber;
        ELSE
           RETURN winnumber;
           END;
        END;
     IF player = turn THEN
        RETURN losenumber DIV 2;
     ELSE
        RETURN winnumber DIV 2;
        END;
     END;

  WHILE GetAMove(move, allmoves) DO      (*** Normal operation ***)
     MakeNewBoard(board, newboard, move, turn);
     tempscore := EvalMove(newboard, otherturn, player, level - 1);
(*WriteString("   tempscore = ");WriteInt(tempscore,1);WriteLn;*)
     IF interrupt THEN RETURN 0;         (* just checking *)
        END;

     IF ODD(level) THEN                  (* Odd level, MAXIMIZE *)
        IF tempscore > score THEN
           score := tempscore;
           END;
        ELSE
           IF tempscore < score THEN
              score := tempscore;
              END;
        END;
(*WriteString("   score = ");WriteInt(score,1);WriteLn;*)
     END;
(*WriteString("Exiting EvalMove after WHILE loop and return score\n");*)
  RETURN score;

END EvalMove;


(**************************************************************************)
PROCEDURE DoComputerMove() : BOOLEAN;

(*   This is the computer equivalent of the procedure, DoMove.  It exe-   *)
(* cutes a computer's move, assuming that the computer already has a le-  *)
(* gitate move possible.  It utilizes the global variable, state.  Also   *)
(* note that this assumes that the current turn is the computer's turn.   *)
(* It's up to the caller to make sure that it is indeed time to play the  *)
(* computer.                                                              *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            n/a                                                         *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            The state and the screen will be changed to reflect the     *)
(*            move execute by the computer.                               *)

VAR
  movevalues : ARRAY[1..maxmoves] OF INTEGER;  (* holds the moves' values *)
  movelist : allmovestype;                  (* holds the moves themselves *)
  amove : movetype;
  newboard : boardtype;
  otherplayer : playertype;
  better : BOOLEAN;
  noother : BOOLEAN;
  i, j, counter,
  searchdepth,                     (* how deep do we search?              *)
  which : CARDINAL;                (* Tells which move has been selected. *)
  whicharray : ARRAY[1..numwhich]  (* Holds the moves for the one that    *)
           OF CARDINAL;            (*  picks a good move at random.       *)
  currentvalue : INTEGER;          (* What's the best value seen so far?  *)
  currentvalarray : ARRAY [1..numwhich]  (* Similar to whicharray   *)
           OF INTEGER;

BEGIN
  interrupt := FALSE;

  imessageptr := GetMsg(mywindowptr^.UserPort^);  (* Did user abort? *)
  IF imessageptr # NIL THEN
     IF (MenuPick IN imessageptr^.Class) AND
        (MENUNUM(imessageptr^.Code) = 0) AND
        (ITEMNUM(imessageptr^.Code) = 0) THEN
        interrupt := TRUE;
        END;
     ReplyMsg(imessageptr);
     END;
  IF interrupt THEN
     backedup := TRUE;
     RETURN TRUE;
     END;

  IF difficulty < 3 THEN        (* Finding the search depth. *)
     searchdepth := 1;
     ELSE searchdepth := difficulty - 2;
     END;

  otherplayer := OtherPlayer(state.turn);

  noother := TRUE;                         (* To speed things up at end *)
  FOR i := 1 TO 7 DO   FOR j := 1 TO 7 DO
     IF state.board[i,j] = otherplayer THEN
        noother := FALSE;
        i := 7; j := 7;
        END;
     END; END;
  IF noother THEN
     searchdepth := 1;
     END;

  FindAllMoves (state.board, state.turn, movelist);

  imessageptr := GetMsg(mywindowptr^.UserPort^);  (* Did user abort? *)
  IF imessageptr # NIL THEN
     IF (MenuPick IN imessageptr^.Class) AND
        (MENUNUM(imessageptr^.Code) = 0) AND
        (ITEMNUM(imessageptr^.Code) = 0) THEN
        interrupt := TRUE;
        END;
     ReplyMsg(imessageptr);
     END;
  IF interrupt THEN
     backedup := TRUE;
     RETURN TRUE;
     END;

  IF difficulty = 1 THEN        (* Tells to pick a move at random! *)
     which := CARDINAL(Random(LONGCARD(movelist.nummoves))) + 1;
     RETURN DoMove(movelist.moves[which]);
     END;

  counter := movelist.nummoves;

              (*****************************************)
              (* Find all the values for all the moves *)
              (*****************************************)
  WHILE counter > 0 DO
     MakeNewBoard(state.board, newboard, movelist.moves[counter], state.turn);
     movevalues[counter] :=
             EvalMove(newboard, otherplayer, state.turn, searchdepth);

     imessageptr := GetMsg(mywindowptr^.UserPort^);  (* Did user abort? *)
     IF imessageptr # NIL THEN
        IF (MenuPick IN imessageptr^.Class) AND
           (MENUNUM(imessageptr^.Code) = 0) AND
           (ITEMNUM(imessageptr^.Code) = 0) THEN
           interrupt := TRUE;
           END;
        ReplyMsg(imessageptr);
        END;

     IF interrupt THEN
        backedup := TRUE;
        RETURN TRUE;
        END;

     DEC(counter);
     END;
              (***********************)
              (* Deciding what to do *)
              (***********************)
  CASE difficulty OF

     0  :                 (* The computer TRIES to lose! *)
        currentvalue := MAX(INTEGER);
        FOR i := 1 TO movelist.nummoves DO
           IF movevalues[i] < currentvalue THEN
              which := i;
              currentvalue := movevalues[i];
              END;
           END;
           |
     2  :                 (* Takes one of the best numwhich moves *)
        IF movelist.nummoves <= numwhich THEN
           which := CARDINAL(Random(LONGCARD(movelist.nummoves))) + 1;
        ELSE
           FOR i := 1 TO numwhich DO     (* Set up the array *)
              j := CARDINAL(Random(LONGCARD(numwhich))) + 1;
              whicharray[i] := j;
              currentvalarray[i] := movevalues[j];
              END;

           FOR i := 1 TO movelist.nummoves DO  (* find the numwhich vals *)
              better := FALSE;
              j := 1;
              WHILE (NOT better) AND (j <= numwhich) DO
                 IF movevalues[i] > currentvalarray[j] THEN
                    better := TRUE;
                    whicharray[j] := i;
                    currentvalarray[j] := movevalues[i];
                    ELSE INC(j);
                    END;
                 END;  (* while *)
              END;  (* for i *)
           i := CARDINAL(Random(LONGCARD(numwhich))) + 1;
           which := whicharray[i];
        END;  (* if movelist.nummoves *)
           |

     ELSE
        currentvalue := MIN(INTEGER);
        FOR i := 1 TO movelist.nummoves DO
           IF movevalues[i] > currentvalue THEN
              which := i;
              currentvalue := movevalues[i];
              END;
           END;
     END;

  imessageptr := GetMsg(mywindowptr^.UserPort^);  (* Did user abort? *)
  IF imessageptr # NIL THEN
     IF (MenuPick IN imessageptr^.Class) AND
        (MENUNUM(imessageptr^.Code) = 0) AND
        (ITEMNUM(imessageptr^.Code) = 0) THEN
        interrupt := TRUE;
        END;
     ReplyMsg(imessageptr);
     END;
  IF interrupt THEN
     backedup := TRUE;
     RETURN TRUE;
     END;

  RETURN DoMove(movelist.moves[which]);

END DoComputerMove;


(******************************************************)

END thinker.
