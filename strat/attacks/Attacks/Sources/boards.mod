IMPLEMENTATION MODULE boards;

(*$R-V-*) (* range checking OFF, overflow checking OFF *)

(*   This module is a list of boards for the game.  After thinking about  *)
(* it for a while, I decided to use a list of setups rather than have the *)
(* possibilty of a random setup that was impossible to play.              *)

FROM header
  IMPORT   boardrange, boardsize, boardtype, squaretype;


(**************************************************************************)
PROCEDURE PrepBoard (VAR aboard : boardtype);

(*   This procedure fills in a board with all emtpy squares and then puts *)
(* red and blue squares in the opposing corners.                          *)


VAR
  i, j : boardrange;

BEGIN
  FOR j := 1 TO boardsize DO          (* first, make 'em all empty *)
     FOR i := 1 TO boardsize DO
        aboard[i,j] := empty;
     END;
  END;

  FOR i := -1 TO 9 DO                 (* Now, put in outer blocks   *)
     aboard[i,-1] := block;
     aboard[i, 0] := block;
     aboard[i, 8] := block;
     aboard[i, 9] := block;
     aboard[-1, i] := block;
     aboard[0, i] := block;
     aboard[8, i] := block;
     aboard[9, i] := block;
     END;

  aboard[1,1] := red;          (* put the players on opp corners *)
  aboard[7,7] := red;
  aboard[1,7] := blue;
  aboard[7,1] := blue;

END PrepBoard;

(**************************************************************************)
(*                              *)
(*      MAIN  (initialization)  *)
(*                              *)
(********************************)

VAR
  i : boardrange;

BEGIN
  PrepBoard(setup0);

  PrepBoard(setup1);
  setup1 [1,4] := block;             (* board 1 *)
  setup1 [7,4] := block;
  setup1 [4,1] := block;
  setup1 [4,7] := block;
  setup1 [4,4] := block;

  PrepBoard(setup2);
  setup2 [1,4] := block;
  setup2 [2,4] := block;
  setup2 [3,4] := block;
  setup2 [5,4] := block;
  setup2 [6,4] := block;
  setup2 [7,4] := block;
  setup2 [4,1] := block;
  setup2 [4,2] := block;
  setup2 [4,3] := block;
  setup2 [4,5] := block;
  setup2 [4,6] := block;
  setup2 [4,7] := block;

  PrepBoard(setup3);         (* This is one of my own *)
  setup3 [2,1] := block;
  setup3 [1,2] := block;
  setup3 [6,1] := block;
  setup3 [1,6] := block;
  setup3 [7,2] := block;
  setup3 [2,7] := block;
  setup3 [7,6] := block;
  setup3 [6,7] := block;
  setup3 [4,3] := block;
  setup3 [3,4] := block;
  setup3 [5,4] := block;
  setup3 [4,5] := block;

  PrepBoard(setup4);         (* This is one of my own *)
  FOR i := 2 TO 6 DO
     setup4 [4,i] := block;
     setup4 [i,4] := block;
     END;

END boards.
