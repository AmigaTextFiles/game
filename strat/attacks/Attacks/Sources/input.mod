IMPLEMENTATION MODULE input;

(*$R-*) (* range checking OFF *)


(*   This module deals with all the input of the program, Ataxx.  It must *)
(* be linked with the graphics module, because the IDCMP events are       *)
(* linked to the window.  Therefore, some of the structures that should   *)
(* be hidden in the ataxxgraphics module are visible so that this module  *)
(* can use them.  The only procedure visible here is GetEvent.            *)


FROM header
  IMPORT   playertype, movetype, boardrange, boardtype, state,
           squaretype,          (* Strangely, it's necessary to compile!  *)
           gameover, pointercode, difficulty, whoisred, whoisblue,
           thinkertype;
FROM attacksgraphics
  IMPORT   mywindowptr,         (* Necessary for getting IDCMP events  *)
           HighlightSquare, UnHighlightSquare, ChangePointer,
           DrawBoard, DrawSquare, PrintTurn;
FROM mdgenerallib
  IMPORT MyPause;
FROM Ports
  IMPORT   GetMsg, ReplyMsg, MsgPortPtr, WaitPort, MessagePtr;
FROM Tasks
  IMPORT SignalSet, Wait;
FROM SYSTEM
  IMPORT ADDRESS, LONGWORD;
FROM Intuition
  IMPORT   IntuiMessagePtr, SelectDown, SelectUp, SetMenuStrip,
           ClearMenuStrip, IDCMPFlagsSet, IDCMPFlags, MENUNUM, ITEMNUM,
           MenuItemMutualExcludeSet;
FROM MenuUtil
  IMPORT   MENUBARPTR, InitMenuBar, ArrangeMenus, AddMenu, AddItem,
           DisposeMenuBar;

VAR
  mymsgportptr : MsgPortPtr;       (* Points to my message port     *)
  mousex, mousey : INTEGER;        (* The coordinates of last IDCMP event *)

  mymenuptr : MENUBARPTR;          (* For Chris' menu routines *)

  editpointerstate : squaretype;   (* This tells what the state of the *)
                                   (*  pointer is during editing.      *)

(**************************************************************************)
PROCEDURE InitMenus;

(*   This initializes the menus for the program.  Simple.                 *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            n/a                                                         *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            The menus for the program now should work.                  *)
(*                                                                        *)

BEGIN
  InitMenuBar(mymenuptr);

  AddMenu(mymenuptr, "Project");        (* First menu *)
  AddItem(mymenuptr, "New Game    ", "N", MenuItemMutualExcludeSet{}, FALSE);
  AddItem(mymenuptr, "Edit Board    ", "E", MenuItemMutualExcludeSet{}, FALSE);
  AddItem(mymenuptr, "About", 0C, MenuItemMutualExcludeSet{}, FALSE);
  AddItem(mymenuptr, "Quit    ", "Q", MenuItemMutualExcludeSet{}, FALSE);

  AddMenu(mymenuptr, "Commands");
  AddItem(mymenuptr, "Backup a move    ", "B", MenuItemMutualExcludeSet{}, FALSE);
  AddItem(mymenuptr, "Redo a move    ", "R", MenuItemMutualExcludeSet{}, FALSE);
  AddItem(mymenuptr, "Force Computer to move    ", "F", MenuItemMutualExcludeSet{}, FALSE);

  AddMenu(mymenuptr, "Options");         (* Second menu *)
  AddItem(mymenuptr, "  Red is Human", 0C, MenuItemMutualExcludeSet{1}, whoisred = human);
  AddItem(mymenuptr, "  Red is Computer", 0C, MenuItemMutualExcludeSet{0}, whoisred = computer);
  AddItem(mymenuptr, "  Blue is Human", 0C, MenuItemMutualExcludeSet{3}, whoisblue = human);
  AddItem(mymenuptr, "  Blue is Computer", 0C, MenuItemMutualExcludeSet{2}, whoisblue = computer);
  AddItem(mymenuptr, "", 0C, MenuItemMutualExcludeSet{}, FALSE);
  AddItem(mymenuptr, "  Tries to Lose", 0C, MenuItemMutualExcludeSet{6,7,8,9}, difficulty = 0);
  AddItem(mymenuptr, "  Easy", 0C, MenuItemMutualExcludeSet{5,7,8,9}, difficulty = 1);
  AddItem(mymenuptr, "  Kinda' Good", 0C, MenuItemMutualExcludeSet{5,6,8,9}, difficulty = 2);
  AddItem(mymenuptr, "  Good", 0C, MenuItemMutualExcludeSet{4,5,7,9}, difficulty = 3);
  AddItem(mymenuptr, "  Very Good", 0C, MenuItemMutualExcludeSet{5,6,7,8}, difficulty = 4);

  ArrangeMenus(mymenuptr);
  SetMenuStrip( mywindowptr^, mymenuptr^.FirstMenuPtr^ );
END InitMenus;


(**************************************************************************)
PROCEDURE CloseMenus;

(*   This closes and deallocates the memory for the menus.                *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            n/a                                                         *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            Kills the menus.                                            *)
(*                                                                        *)

BEGIN
  ClearMenuStrip( mywindowptr^ );
  DisposeMenuBar( mymenuptr );
END CloseMenus;


(**************************************************************************)
PROCEDURE ChangeToEditMenu;

(*   Clears the current menu and makes the Edit menu.                     *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            n/a                                                         *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            Remakes the menu bar.                                       *)

BEGIN
  CloseMenus;
  InitMenuBar(mymenuptr);

  AddMenu(mymenuptr, "Project");
  AddItem(mymenuptr, "Exit Edit Mode", 0C, MenuItemMutualExcludeSet{}, FALSE);

  AddMenu(mymenuptr, "Player");
  IF state.turn = red THEN
     AddItem(mymenuptr, "  Red to move", 0C, MenuItemMutualExcludeSet {1}, TRUE);
     AddItem(mymenuptr, "  Blue to move", 0C, MenuItemMutualExcludeSet {0}, FALSE);
     ELSE
     AddItem(mymenuptr, "  Red to move", 0C, MenuItemMutualExcludeSet {1}, FALSE);
     AddItem(mymenuptr, "  Blue to move", 0C, MenuItemMutualExcludeSet {0}, TRUE);
     END;

  AddMenu(mymenuptr, "Build");
  AddItem(mymenuptr, "  Empty Space", 0C,
          MenuItemMutualExcludeSet{1,2,3}, editpointerstate = empty);
  AddItem(mymenuptr, "  Block Space", 0C,
          MenuItemMutualExcludeSet{0,2,3}, editpointerstate = block);
  AddItem(mymenuptr, "  Red Player", 0C,
          MenuItemMutualExcludeSet{0,1,3}, editpointerstate = red);
  AddItem(mymenuptr, "  Blue Player", 0C,
          MenuItemMutualExcludeSet{0,1,2}, editpointerstate = blue);

  AddMenu(mymenuptr, "Major");
  AddItem(mymenuptr, "Cancel All", 0C, MenuItemMutualExcludeSet{}, FALSE);
  AddItem(mymenuptr, "All Empty", 0C, MenuItemMutualExcludeSet{}, FALSE);
  AddItem(mymenuptr, "All Blocks", 0C, MenuItemMutualExcludeSet{}, FALSE);

  ArrangeMenus(mymenuptr);
  SetMenuStrip( mywindowptr^, mymenuptr^.FirstMenuPtr^ );
END ChangeToEditMenu;


(**************************************************************************)
PROCEDURE ChangeToComputerMenu;

(*   Clears the current menu and makes the menu to be displayed during    *)
(* the time the computer is moving.                                       *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            n/a                                                         *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            Remakes the menu bar.                                       *)
BEGIN
  CloseMenus;
  InitMenuBar(mymenuptr);

  AddMenu(mymenuptr, "Stop!");
  AddItem(mymenuptr, "Abort Computer's Move    ", "A", MenuItemMutualExcludeSet{}, FALSE);

  ArrangeMenus(mymenuptr);
  SetMenuStrip( mywindowptr^, mymenuptr^.FirstMenuPtr^ );
END ChangeToComputerMenu;

(**************************************************************************)
PROCEDURE ChangeToMainMenu;

(*   Clears the current menu and makes the regular Main menu.             *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            n/a                                                         *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            Remakes the menu bar.                                       *)
(*                                                                        *)

BEGIN
  CloseMenus;
  InitMenus;
END ChangeToMainMenu;


(**************************************************************************)
PROCEDURE GetPrimitiveEvent(VAR msgcode : CARDINAL;
                            VAR msgclass : IDCMPFlagsSet);

(*   This is the low-level procedure that waits for an IDCMP event and    *)
(* then returns the code associated with it.  This routine also replies   *)
(* to Intuition quickly so that inputs don't build up (hopefully).        *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            All input comes from the USER!                              *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            The direct IDCMP code is returned.                          *)
(*                                                                        *)

VAR
  imessageptr : IntuiMessagePtr;   (* Points to an intuimessage     *)
  Signals      : SignalSet;

BEGIN
                             (* Waits for an IDCMP event *)
  Signals :=
     Wait( SignalSet{ CARDINAL(mywindowptr^.UserPort^.mpSigBit) } );

  REPEAT
                          (* Takes the first event off the event queue *)
    imessageptr := GetMsg(mywindowptr^.UserPort^);
     IF imessageptr # NIL THEN
        mousex := imessageptr^.MouseX;
        mousey := imessageptr^.MouseY;
        msgcode := imessageptr^.Code;
        msgclass := imessageptr^.Class;
        ReplyMsg(imessageptr);
        END;
    UNTIL imessageptr = NIL;

END GetPrimitiveEvent;


(**************************************************************************)
PROCEDURE TransCoordToBoard (screenx : INTEGER; screeny : INTEGER;
                          VAR boardx : boardrange; VAR boardy : boardrange)
                          : BOOLEAN;

(*      Given two coordinates representing a low resolution screen's      *)
(* pixel location, this returns with the second two variables represent-  *)
(* ing the corresponding location on the ataxx board.  In other words,    *)
(* this finds out which square a certain pixel belongs to.  If the pixel  *)
(* does not belong to a square, then the function returns FALSE.          *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            screenx, screeny     These two numbers are simply coordi-   *)
(*                                 nates from the screen.  The screen     *)
(*                                 is low res, so the values are 0..319   *)
(*                                 and 0..199.                            *)
(*                                                                        *)
(*            boardx, boardy       Although they are input, they're real- *)
(*                                 just considered as garbage inputs.     *)
(*                                                                        *)
(*   OUPUT                                                                *)
(*            boardx, boardy       These numbers will reflect the square  *)
(*                                 of the board where the screenx,screeny *)
(*                                 pixel falls.  If the pixel is not in   *)
(*                                 a square, then these are unchanged.    *)
(*                                                                        *)
(*            The function returns a TRUE if the pixel location was in a  *)
(*            board square, and FALSE otherwise.                          *)

VAR
  goodvalue : BOOLEAN;       (* Tells whether we've found a place or not  *)

BEGIN
  goodvalue := FALSE;
  IF (51 < screenx) AND (screenx < 268) AND       (* check range *)
     (17 < screeny) AND (screeny < 199) AND
     (((screenx - 51) MOD 31) # 0) AND            (* check on a line   *)
     (((screeny - 17) MOD 26) # 0)
     THEN
        goodvalue := TRUE;
        boardx := (screenx - 21) DIV 31;          (* change the values *)
        boardy := (screeny + 8) DIV 26;
     END;

  RETURN goodvalue;

END TransCoordToBoard;



(************************************************************)

PROCEDURE ProcessMenuPick( code     : CARDINAL) : eventtype;

(*      This takes a code, assuming that this is the code returned for    *)
(* a menu event, and translates it into MY event code, which is returned. *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            code        This is the code that was received by the IDCMP *)
(*                        input event.  The IDCMP class has already re-   *)
(*                        vealed that this code is of a MenuPick class    *)
(*                        (a menu event).                                 *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            This returns an eventtype that specifies exactly what kind  *)
(*            of event occurred.  Of course this routine will only return *)
(*            what kind of menu event only.                               *)

VAR
  menunumber, itemnumber : CARDINAL;

BEGIN
  menunumber := MENUNUM(code);
  itemnumber := ITEMNUM(code);

  CASE menunumber OF            (* this is pretty simple, now.   *)
     | 0  :
        CASE itemnumber OF
           | 0  :
              RETURN NEWGAME;

           | 1  :
              RETURN EDIT;

           | 2  :
              RETURN ABOUT;

           | 3  :
              RETURN QUIT;
           END;

     | 1  :
        CASE itemnumber OF
           | 0  :
              RETURN BACKUP;

           | 1  :
              RETURN REDO;

           | 2  :
              RETURN FORCE;
           END;

     | 2  :
        CASE itemnumber OF
           | 0  :
              whoisred := human;
              RETURN OOPS;
           | 1  :
              whoisred := computer;
              RETURN OOPS;
           | 2  :
              whoisblue := human;
              RETURN OOPS;
           | 3  :
              whoisblue := computer;
              RETURN OOPS;
           | 4  :
              RETURN OOPS;
           | 5  :
              difficulty := 0;
              RETURN OOPS;
           | 6  :
              difficulty := 1;
              RETURN OOPS;
           | 7  :
              difficulty := 2;
              RETURN OOPS;
           | 8  :
              difficulty := 3;
              RETURN OOPS;
           | 9  :
              difficulty := 4;
              RETURN OOPS;
           END;

     ELSE RETURN OOPS;

     END;

END ProcessMenuPick;


(**************************************************************************)

PROCEDURE GetEvent (player : playertype) : eventtype;

(*   This procedure returns a code indicating a specific input event.     *)
(* Such events are like a menu selection, or a player's move.  If the     *)
(* event is a move, then the specific move will be specified in the var-  *)
(* iable, moveAttempted.  It is expected that this routine will be called *)
(* and then waited for until the user(s) makes some sort of imput.  It    *)
(* is the responsibility of this and subordinate procedures to do the     *)
(* waiting in a proper fashion.                                           *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            player      Tells the procedure who's turn it currently is. *)
(*                        Necessary because this does some checking to    *)
(*                        see if a correct move was made.                 *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            Returns a variable of eventtype that indicates the high-    *)
(*            level input event.  If the event is a move by a player,     *)
(*            then the variable moveAttempted will hold the move.         *)

VAR
  msgcode : CARDINAL;
  msgclass : IDCMPFlagsSet;
  foo : BOOLEAN;

BEGIN   (*******************************************)
        (* First, check to see if the game is over *)
        (*******************************************)
  IF gameover THEN
     REPEAT
        GetPrimitiveEvent(msgcode, msgclass);
     UNTIL MenuPick IN msgclass;
     RETURN ProcessMenuPick(msgcode);
     END;

        (*************************)
        (*  get the from square  *)
        (*************************)
REPEAT                          (* loop until mouse down in right place *)
     GetPrimitiveEvent(msgcode, msgclass);

  IF MenuPick IN msgclass THEN     (* Or there's a menu selection.     *)
     RETURN ProcessMenuPick(msgcode);
     END;

UNTIL (msgcode = SelectDown) AND
      (TransCoordToBoard(mousex, mousey,
        moveAttempted.fromX, moveAttempted.fromY) = TRUE) AND
      (state.board[moveAttempted.fromX, moveAttempted.fromY] = player);

HighlightSquare(moveAttempted.fromX, moveAttempted.fromY, player);
IF state.turn = red THEN
  ChangePointer(RedCircle);
  ELSE ChangePointer(BlueCircle);
  END;

        (***********************)
        (* Get the dest sqaure *)
        (***********************)

REPEAT
     GetPrimitiveEvent(msgcode, msgclass);
UNTIL msgcode = SelectUp;
foo := TransCoordToBoard(mousex, mousey,
        moveAttempted.toX, moveAttempted.toY);

UnHighlightSquare(moveAttempted.fromX,moveAttempted.fromY, player);

RETURN MOVE;

END GetEvent;

(**************************************************************************)
PROCEDURE EditBoard (VAR board : boardtype; VAR player : playertype)
              : BOOLEAN;

(*   This procedure controls all the necessary input and outputs for mod- *)
(* ifying the board and returns whether or not any changes were made.     *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            board             The current board.                        *)
(*                                                                        *)
(*            player            The current player to move.  This is      *)
(*                              needed to return the pointer to the old   *)
(*                              state.                                    *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            board             This is returned reflecting the modified  *)
(*                              state.                                    *)
(*                                                                        *)
(*            The function returns TRUE only if the board was actually    *)
(*            altered.  A return of FALSE signifies that no changes were  *)
(*            made to the board.                                          *)

VAR
  done : BOOLEAN;
  modified : BOOLEAN;
  msgcode : CARDINAL;
  msgclass : IDCMPFlagsSet;
  menunumber, itemnumber : CARDINAL;
  backupboard : boardtype;
  backupplayer : playertype;
  boardx, boardy, i, j : boardrange;

BEGIN
  CASE editpointerstate OF
     | empty  :
        ChangePointer(EmptySquare);
     | block  :
        ChangePointer(BlockSquare);
     | red    :
        ChangePointer(RedCircle);
     | blue   :
        ChangePointer(BlueCircle);
     END;

  backupboard := board;
  backupplayer := player;
  done := FALSE;
  modified := FALSE;

  REPEAT
     GetPrimitiveEvent(msgcode, msgclass);

     IF MenuPick IN msgclass THEN        (* Doing menu selection *)
        menunumber := MENUNUM(msgcode);
        itemnumber := ITEMNUM(msgcode);
        CASE menunumber OF
           |  0  :
              CASE itemnumber OF
                 |  0  :                    (* quit *)
                    done := TRUE;
                 END;  (* case itemnumber *)

           |  1  :
              CASE itemnumber OF
                 |  0  :
                    IF player # red THEN
                       player := red;
                       PrintTurn(player);
                       modified := TRUE;
                       END;

                 |  1  :
                    IF player # blue THEN
                       player := blue;
                       PrintTurn(player);
                       modified := TRUE;
                       END;
                 END;

           |  2  :
              CASE itemnumber OF
                 |  0  :                    (* blank square *)
                    ChangePointer(EmptySquare);
                    editpointerstate := empty;

                 |  1  :
                    ChangePointer(BlockSquare);
                    editpointerstate := block;

                 |  2  :
                    ChangePointer(RedCircle);
                    editpointerstate := red;

                 |  3  :
                    ChangePointer(BlueCircle);
                    editpointerstate := blue;
                 END;  (* case itemnumber *)

           |  3  :
              CASE itemnumber OF
                 |  0  :                          (* cancel changes *)
                    board := backupboard;
                    player := backupplayer;
                    PrintTurn(player);
                    modified := FALSE;
                    ChangeToEditMenu;
                    DrawBoard (board);

                 |  1  :                          (* make 'em all empty *)
                    FOR i := 1 TO 7 DO
                       FOR j := 1 TO 7 DO
                          board[i,j] := empty;
                          END;
                       END;
                    modified := TRUE;
                    DrawBoard (board);

                 |  2  :                          (* make 'em all blocks *)
                    FOR i := 1 TO 7 DO
                       FOR j := 1 TO 7 DO
                          board[i,j] := block;
                          END;
                       END;
                    modified := TRUE;
                    DrawBoard (board);

                 END;  (* case itemnumber *)
           END;  (* case menunumber *)


        ELSE                             (* Not a menu, but a click! *)
           IF (msgcode = SelectUp) AND   (* only want an UP mouse button  *)
                 TransCoordToBoard(mousex, mousey, boardx, boardy) THEN
              board[boardx, boardy] := editpointerstate;
              DrawSquare(boardx, boardy, editpointerstate);
              modified := TRUE;
              END;
        END;

  UNTIL done;
(*
  IF player = red THEN                   (* Revert the pointer   *)
     ChangePointer(RedPointer);
     ELSE ChangePointer(BluePointer);
     END;
*)
  RETURN modified;

END EditBoard;


(**************************************************************************)
PROCEDURE WaitForMouseUp;

(*   This simple procedure just waits until the left mouse button is re-  *)
(* leased.                                                                *)
VAR
  msgcode : CARDINAL;
  msgclass : IDCMPFlagsSet;

BEGIN
  REPEAT
     GetPrimitiveEvent(msgcode, msgclass);
  UNTIL msgcode = SelectUp;
END WaitForMouseUp;

(******************************************************************)

BEGIN
  editpointerstate := empty;
END input.
