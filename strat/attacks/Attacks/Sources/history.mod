IMPLEMENTATION MODULE history;

(*$R-*) (* range checking OFF *)

FROM header
  IMPORT   boardtype, boardrange, histnodetype, histnodeptrtype, historytype,
           playertype;
FROM Storage
  IMPORT   ALLOCATE, DEALLOCATE;
FROM TermInOut
  IMPORT   WriteString, WriteLn, WriteCard;


(*************************************************************************)

PROCEDURE InitHistory (VAR history : historytype;
                       board : boardtype;  player : playertype) : BOOLEAN;

(*   This takes an uninitialized variable of history type and sets all    *)
(* the appropriate things to an initial value.                            *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            history           Variable of history type.  It should be   *)
(*                              unused.                                   *)
(*                                                                        *)
(*            board             This board should represent the current   *)
(*                              board state.                              *)
(*                                                                        *)
(*            player            And similarly for the player.             *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            history           Same variable.  It will be modified so    *)
(*                              that it will reflect an initial state.    *)
(*                                                                        *)
(*            The function will return TRUE only if it can properly in-   *)
(*            itialize the variable.  If something goes wrong -> FALSE.   *)
VAR
  ptr : histnodeptrtype;

BEGIN
  ALLOCATE(ptr, SIZE(histnodetype));
  IF ptr = NIL THEN
     RETURN FALSE;
     END;
  ptr^.board := board;
  ptr^.turn := player;
  ptr^.next := NIL;
  ptr^.previous := NIL;
  history.currentmove := ptr;
  history.nummoves := 1;
  RETURN TRUE;
END InitHistory;

(**************************************************************************)

PROCEDURE AddToHistory (VAR history : historytype;
                            board : boardtype;  player : playertype)
                         : BOOLEAN;

(*   This takes an initialized variable of history type and adds the      *)
(* board to it.  NOTE: it is up to the caller to maintain all the proper  *)
(* changes to its own state.  This just keeps track of the moves.         *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            history           Variable of history type.  It definately  *)
(*                              should be initialized.                    *)
(*                                                                        *)
(*            board             A boardtype.  It is what will be added    *)
(*                              to the history.                           *)
(*                                                                        *)
(*            player            Whose turn it was to move at this board's *)
(*                              configuration.                            *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            history           Same variable.  It will be modified so    *)
(*                              that it will now hold the new board.      *)
(*                                                                        *)
(*            The function will return TRUE only if it can properly add   *)
(*            the new board to the history.  If something goes wrong,     *)
(*            then this will try to return the original history and       *)
(*            return FALSE.                                               *)

VAR
  ptr : histnodeptrtype;

BEGIN
           (* This removes all the moves off the top *)
  WHILE history.currentmove^.next # NIL DO
     ptr := history.currentmove^.next;
     history.currentmove^.next := ptr^.next;
     DEALLOCATE(ptr, SIZE(histnodetype));
     DEC(history.nummoves);
     END;

           (* Here we add the new move to the data struct *)
  ALLOCATE(ptr, SIZE(histnodetype));
  IF ptr = NIL THEN
     RETURN FALSE;
     END;
  ptr^.board := board;
  ptr^.turn := player;

  ptr^.previous := history.currentmove;
  ptr^.next := NIL;
  history.currentmove^.next := ptr;
  history.currentmove := ptr;
  INC (history.nummoves);
  RETURN TRUE;
END AddToHistory;

(**************************************************************************)

PROCEDURE PopHistory (VAR history : historytype;
                      VAR board : boardtype;  VAR player : playertype)
                         : BOOLEAN;

(*   This takes an initialized variable of history type and removes the   *)
(* most recent move from it.  The result is put into the variable board.  *)
(* If there are no boards in the current history (ie, the history list    *)
(* is empty) then the function will return FALSE.                         *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            history           Variable of history type.  It definately  *)
(*                              should be initialized.                    *)
(*                                                                        *)
(*            board             A boardtype.  Initially it is garbage.    *)
(*                                                                        *)
(*            player            A playertype.  Also garbage at the start. *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            history           Same variable.  It will be modified so    *)
(*                              that it no longer holds the returned      *)
(*                              board.                                    *)
(*                                                                        *)
(*            board             This will hold the board that is re-      *)
(*                              turned.  If the history contains no pre-  *)
(*                              vious boards, then this variable is un-   *)
(*                              changed.                                  *)
(*                                                                        *)
(*            player            Holds the player whose turn it is for the *)
(*                              returned board.                           *)
(*                                                                        *)
(*                                                                        *)
(*            The function will return TRUE only if it can properly pop   *)
(*            a board from it.  If the history is empty, then the func-   *)
(*            returns FALSE.                                              *)


BEGIN
  IF history.currentmove^.previous = NIL THEN
     RETURN FALSE;
     END;
  history.currentmove := history.currentmove^.previous;
  board := history.currentmove^.board;
  player := history.currentmove^.turn;
  RETURN TRUE;
END PopHistory;


(**************************************************************************)
PROCEDURE UpHistory (VAR history : historytype;  VAR board : boardtype;
                     VAR player : playertype) : BOOLEAN;

(*   This is used to REDO moves.  It is called and works very much like   *)
(* PopHistory.                                                            *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            history           Variable of history type.  It definately  *)
(*                              should be initialized.                    *)
(*                                                                        *)
(*            board             A boardtype.  Initially it is garbage.    *)
(*                                                                        *)
(*            player            A playertype.  Also garbage at the start. *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            history           Same variable.  It may be modified, but   *)
(*                              don't worry about it.                     *)
(*                                                                        *)
(*            board             This will hold the board that is re-      *)
(*                              turned.  If the history contains no next  *)
(*                              boards, then this variable is unchange.   *)
(*                                                                        *)
(*            player            Holds the player whose turn it is for the *)
(*                              returned board.                           *)
(*                                                                        *)
(*                                                                        *)
(*            The function will return TRUE only if it can properly make  *)
(*            a board from it.  If there is no further boards to go Up,   *)
(*            it returns FALSE.                                           *)

BEGIN
  IF history.currentmove^.next = NIL THEN
     RETURN FALSE;
     END;

  history.currentmove := history.currentmove^.next;
  board := history.currentmove^.board;
  player := history.currentmove^.turn;
  RETURN TRUE;

END UpHistory;

(**************************************************************************)
PROCEDURE NewHistory (VAR history : historytype;  board : boardtype;
                      player : playertype);

(*   Given an already initialized history, this resets it to make a brand *)
(* new history structure with the current board and player set in it.     *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            history           Variable of history type.  It definately  *)
(*                              should be initialized, though not neces-  *)
(*                              sarily full of boards.                    *)
(*                                                                        *)
(*            board             This board should represent the current   *)
(*                              board state.                              *)
(*                                                                        *)
(*            player            And similarly for the player.             *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            history           Same variable.  It will be modified so    *)
(*                              that it now is devoid of boards save one. *)

VAR
  ptr : histnodeptrtype;

BEGIN
           (* This removes all the moves off the top *)
  WHILE history.currentmove^.next # NIL DO
     ptr := history.currentmove^.next;
     history.currentmove^.next := ptr^.next;
     DEALLOCATE(ptr, SIZE(histnodetype));
     DEC(history.nummoves);
     END;

           (* Removes all the moves off the bottem *)
  WHILE history.currentmove^.previous # NIL DO
     ptr := history.currentmove^.previous;
     history.currentmove^.previous := ptr^.previous;
     DEALLOCATE(ptr, SIZE(histnodetype));
     DEC(history.nummoves);
     END;

  history.currentmove^.board := board;
  history.currentmove^.turn := player;
END NewHistory;


(**************************************************************************)

PROCEDURE CloseHistory (VAR history : historytype);

(*   This takes a variable of history type and clears all the memory and  *)
(* etc associated with it.                                                *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            history           Variable of history type.                 *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            history           Same variable.  It will be modified and   *)
(*                              should NOT be used after calling this     *)
(*                              routine.                                  *)
VAR
  fooboard : boardtype;
  fooplayer : playertype;

BEGIN
  NewHistory(history, fooboard, fooplayer);
  DEALLOCATE(history.currentmove, SIZE(histnodetype));
END CloseHistory;

(*************************************************)
END history.
