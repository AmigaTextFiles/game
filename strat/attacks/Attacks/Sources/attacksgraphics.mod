IMPLEMENTATION MODULE attacksgraphics;

(*$R-V-*) (* range checking OFF, overflow checking OFF *)

(* This is the implementation module of all the graphics stuff for my
  ataxx program.
*)

(**************************************************************)
FROM TermInOut
  IMPORT   WriteString, WriteLn;

FROM SYSTEM
  IMPORT   BYTE, ADR, LONGWORD, ADDRESS;

FROM Memory
  IMPORT   AllocMem, FreeMem, MemReqSet, MemChip, MemClear;

FROM Preferences
  IMPORT   Preferences, GetPrefs;

FROM Views
  IMPORT   ViewModesSet, Sprites, LoadRGB4, SetRGB4, ViewPort, ColorTable,
           GetRGB4;

FROM Rasters
  IMPORT   RastPort, Jam1, Jam2;

FROM Drawing
  IMPORT   SetAPen, SetOPen, SetDrMd, Draw, Move, RectFill, DrawCircle,
           WritePixel, ReadPixel;

FROM header
  IMPORT   boardtype, playertype, squaretype, boardrange, state, pointercode,
           movetype, printmsgtype;

FROM input
  IMPORT   WaitForMouseUp, ChangeToMainMenu;

FROM attackssprites
  IMPORT   InitPointers, circle, mypointer, emptysquare, blocksquare;

FROM Ports
  IMPORT   GetMsg, ReplyMsg, MsgPortPtr, WaitPort, MessagePtr;

FROM Conversions
  IMPORT   ConvNumberToString;

FROM Intuition
  IMPORT   NewScreen, OpenScreen, ScreenPtr, Screen, CustomScreen,
           CloseScreen, NewWindow, WindowPtr, WindowFlagsSet,
           IDCMPFlagsSet, OpenWindow, CloseWindow, ClearMenuStrip,
           WindowFlags, IDCMPFlags, ScreenFlags, IntuiMessagePtr,
           SetPointer, ClearPointer, IntuiText, PrintIText, ShowTitle;

(***********************************************************************)

CONST
  Black = 0;
  White = 1;
  BGrey = 2;

  Red   = 3;     DarkRed = 4;      LtRed = 5;
  Blue  = 6;     DarkBlue = 7;     LtBlue = 8;
  HGrey = 9;     HDarkGrey = 10;   HLtGrey = 11;

  Green = 14;    DarkGreen = 13;   LtGreen = 12;     (* other colors *)
  Yellow = 15;   DarkYellow = 16;  LtYellow = 18;
  Orange = 18;   DarkOrange = 19;  LtOrange = 20;
  Purple = 21;   DarkPurple = 22;  LtPurple = 23;
  Violet = 24;   DarkViolet = 25;  LtViolet = 26;
  Cyan = 27;     DarkCyan = 28;    LtCyan = 29;

VAR
  ns : NewScreen;               (* The screen and graphics vars  *)
  myscreenptr : ScreenPtr;
  myrastport : RastPort;
  myviewport : ViewPort;
  mycolortable : ColorTable;

  nw : NewWindow;               (* The backdrop window vars      *)

  itext : IntuiText;            (* For displaying text  *)

  oldmousecolor1, oldmousecolor2, oldmousecolor3 :   (* Hold the colors  *)
     ARRAY [1..3] OF CARDINAL;                       (* of the original   *)
                                                     (* mouse.            *)

(**************************************************************************)

PROCEDURE InitializeScreen() : BOOLEAN;

(*      Starts the graphix running.                                    *)
(* Sets up all the graphics variables and draws the first graphics     *)
(* that will be presented.  It returns true if all the actions worked, *)
(* false otherwise.                                                    *)
(*                                                                     *)
(*   INPUT                                                             *)
(*            n/a                                                      *)
(*                                                                     *)
(*   OUTPUT                                                            *)
(*            Returns a boolean value that tells if the operation was  *)
(*            succussful or not.  If successful, the screen (along     *)
(*            with the accompanying graphics) is started.              *)
(*                                                                     *)
(*   NOTE:    This uses mostly globals to this module.  It should      *)
(*            work fine.                                               *)

VAR
  i : CARDINAL;
  oldcolor : LONGCARD;             (* holds the initial result of GetRGB4 *)
  preferences : Preferences;
  foo : ADDRESS;

BEGIN
      (*******************************)
      (* Making new screen structure *)
      (*******************************)

  ns.LeftEdge := 0; ns.TopEdge := 0;
  ns.Width := 320; ns.Height := 200;
  ns.Depth := 4;
  ns.DetailPen := BYTE(0); ns.BlockPen := BYTE(1);
  ns.ViewModes := ViewModesSet{Sprites};    (* Not quite sure about this *)
  ns.Type := CustomScreen;
  ns.Font := NIL;                           (* Using default font *)
  ns.DefaultTitle := ADR("Attacks");
  ns.Gadgets := NIL;

  myscreenptr := OpenScreen(ns);
  IF myscreenptr = NIL THEN
     WriteString ("Couldn't open screen."); WriteLn;
     RETURN FALSE;
     END;

  ShowTitle(myscreenptr^, FALSE);     (* Put title BEHIND the backdrop's *)


        (**************************************)
        (* Get vars for the graphics routines *)
        (**************************************)

  myrastport := myscreenptr^.RastPort;
  myviewport := myscreenptr^.ViewPort;

  foo := GetPrefs(ADR(preferences), SIZE(Preferences));
           (* Here, I'm getting the default colors for the orig. mouse *)
  oldmousecolor1[1] := preferences.color17 DIV 128;
  oldmousecolor1[2] := preferences.color17 DIV 8;
  oldmousecolor1[3] := preferences.color17;
  oldmousecolor2[1] := preferences.color18 DIV 128;
  oldmousecolor2[2] := preferences.color18 DIV 8;
  oldmousecolor2[3] := preferences.color18;
  oldmousecolor3[1] := preferences.color19 DIV 128;
  oldmousecolor3[2] := preferences.color19 DIV 8;
  oldmousecolor3[3] := preferences.color19;

        (************************************)
        (* Preparing the ColorMap structure *)
        (************************************)

                                      (* Defining the colors *)
  mycolortable [0] := 0000H;   (* Black *)
  mycolortable [1] := 0FFFH;   (* White *)
  mycolortable [2] := 0AAAH;   (* BGrey *)
  mycolortable [3] := 0D00H;   (* Red *)
  mycolortable [4] := 0900H;   (* Dark Red *)
  mycolortable [5] := 0F55H;   (* Light Red *)
  mycolortable [6] := 024EH;   (* Blue *)
  mycolortable [7] := 000AH;   (* Dark Blue *)
  mycolortable [8] := 066FH;   (* Light Blue *)
  mycolortable [9] := 0666H;   (* HGrey *)
  mycolortable [10] := 0444H;   (* HDark Grey *)
  mycolortable [11] := 0888H;   (* HLight Grey *)
  mycolortable [12] := 09F9H;   (* Light Green *)
  mycolortable [13] := 0090H;   (* Dark Green *)
  mycolortable [14] := 00E0H;   (* Green *)
  mycolortable [15] := 0EE0H;   (* Yellow *)

                                      (* This changes the colors *)
  LoadRGB4 (myviewport, ADR (mycolortable), 16);


        (*******************************)
        (* Now, open a backdrop window *)
        (*******************************)

  nw.LeftEdge := 0; nw.TopEdge := 0;
  nw.Width := 320; nw.Height := 200;
  nw.DetailPen := BYTE(-1); nw.BlockPen := BYTE(-1);  (* use screen's pens *)
  nw.Flags := WindowFlagsSet {BackDrop, Borderless, Activate};
  nw.IDCMPFlags := IDCMPFlagsSet {MouseButtons, MenuPick};
  nw.FirstGadget := NIL;
  nw.CheckMark := NIL;
  nw.Title := NIL;                       (* NO TITLE *)
  nw.Type := CustomScreen;
  nw.Screen := myscreenptr;

  mywindowptr := OpenWindow(nw);
  IF mywindowptr = NIL THEN
     CloseScreen(myscreenptr^);
     WriteString ("Couldn't open window."); WriteLn;
     RETURN FALSE;
     END;

        (***************************)
        (* Draw the initial screen *)
        (***************************)

(* Set the drawing mode *)
  SetDrMd(myrastport, Jam1);

(* Blank the screen *)
  SetAPen(myrastport, Black);      (* set A pen *)
  SetOPen(myrastport, Black);      (* and the outline pen too! *)
  RectFill(myrastport,0,0,319,199);

(* Drawing a blank board *)
SetAPen(myrastport, BGrey);
  SetOPen(myrastport, BGrey);
  RectFill(myrastport,52,18,267,198);

  i := 82;                         (* draw vertical lines *)
  SetAPen(myrastport, Black);      (* black *)
  REPEAT
     Move(myrastport, i, 18);
     Draw(myrastport, i, 199);
     i := i + 31;
  UNTIL i = 268;

  i := 43;                         (* now the horizontal *)
  REPEAT
     Move(myrastport, 52, i);
     Draw(myrastport, 268, i);
     i := i + 26;
  UNTIL i = 199;

           (*********************)
           (* Put in the scores *)
           (*********************)
  itext.FrontPen := BYTE(Red);
  itext.DrawMode := Jam1;
  itext.LeftEdge := 10;   itext.TopEdge := 15;
  itext.ITextFont := NIL;
  itext.IText := ADR("SCORE");
  itext.NextText := NIL;
  PrintIText(myrastport,itext, 0, 0);

  itext.FrontPen := BYTE(Blue);
  itext.LeftEdge := 270;
  PrintIText(myrastport,itext, 0, 0);


  RETURN InitPointers();           (* Lastly, set up the pointer sprites *)
END InitializeScreen;


(**************************************************************************)

PROCEDURE CleanupGraphics;

(*      Stops the graphix and deallocates all graphix allocated        *)
(* memory.  It assumes that the graphics HAS been succussfully initi-  *)
(* ated.                                                               *)
(*                                                                     *)
(*   INPUT                                                             *)
(*            n/a                                                      *)
(*                                                                     *)
(*   OUTPUT                                                            *)
(*            n/a                                                      *)
(*                                                                     *)
(*   NOTE:    This accesses and (hopefully) removes all the globals    *)
(*            that were activated by the init procedure.               *)


VAR i : CARDINAL;

BEGIN
  FreeMem (ADDRESS(circle), 76);       (* deallocate sprite mem *)
  FreeMem (ADDRESS(mypointer[red]), 76);
  FreeMem (ADDRESS(mypointer[blue]), 76);
  FreeMem (ADDRESS(emptysquare), 76);
  FreeMem (ADDRESS(blocksquare), 76);

  CloseWindow(mywindowptr^);    (* With intuition, this is easy! *)
  CloseScreen(myscreenptr^);
END CleanupGraphics;



(***********************************************************************)

PROCEDURE DrawSquare (xloc : boardrange; yloc : boardrange;
                      square : squaretype);

(*      This routine modifies only a single square, rather than the    *)
(* whole board like the DrawBoard routine does.  Considering the upper *)
(* left corner as square (1,1), this routine will replace the given    *)
(* square with the specified item (either a block, empty, red, or      *)
(* blue).                                                              *)
(*                                                                     *)
(*   INPUT                                                             *)
(*            xloc, yloc     These two numbers describe the location   *)
(*                           of the square to change.                  *)
(*                                                                     *)
(*            square         This tells the routine what to change     *)
(*                           the square to.                            *)
(*                                                                     *)
(*                                                                     *)
(*   OUTPUT                                                            *)
(*                     The display is change so that only the square   *)
(*                     indicated looks like the new type.              *)

VAR
  x, y : CARDINAL;        (* The top left corner of the square   *)
  foo : INTEGER;

BEGIN
     (* First, find the upper left corner of the square in question *)
  x := xloc * 31 + 21;
  y := yloc * 26 - 8;

  CASE square OF
     | empty  :
           SetAPen(myrastport, BGrey);
           SetOPen(myrastport, BGrey);
           RectFill(myrastport, x, y, x + 29, y + 24);

     | block  :
           SetAPen(myrastport, HGrey);
           SetOPen(myrastport, HGrey);
           RectFill(myrastport, x + 3, y + 3, x + 26, y + 21);
           SetAPen(myrastport, HLtGrey);    (* highlight *)
           Move(myrastport, x, y + 23);
           Draw(myrastport, x, y);
           Draw(myrastport, x + 29, y);
           Move(myrastport, x + 28, y + 1);
           Draw(myrastport, x + 1, y + 1);
           Draw(myrastport, x + 1, y + 22);
           Move(myrastport, x + 2, y + 21);
           Draw(myrastport, x + 2, y + 2);
           Draw(myrastport, x + 27, y + 2);
           SetAPen(myrastport, HDarkGrey);    (* shading *)
           Move(myrastport, x, y + 24);
           Draw(myrastport, x + 29, y + 24);
           Draw(myrastport, x + 29, y + 1);
           Move(myrastport, x + 28, y + 2);
           Draw(myrastport, x + 28, y + 23);
           Draw(myrastport, x + 1, y + 23);
           Move(myrastport, x + 2, y + 22);
           Draw(myrastport, x + 27, y + 22);
           Draw(myrastport, x + 27, y + 3);
     | red    :
           SetAPen(myrastport, BGrey);
           SetOPen(myrastport, BGrey);
           RectFill(myrastport, x, y, x + 29, y + 24);
           SetAPen(myrastport, Red);
           SetOPen(myrastport, Red);
           RectFill(myrastport, x + 6, y + 4, x + 22, y + 20);

           Move(myrastport, x +  7, y +  3);   (* Innermost lines   *)
           Draw(myrastport, x + 21, y +  3);
           Move(myrastport, x + 23, y +  5);
           Draw(myrastport, x + 23, y + 19);
           Move(myrastport, x + 21, y + 21);
           Draw(myrastport, x +  7, y + 21);
           Move(myrastport, x +  5, y + 19);
           Draw(myrastport, x +  5, y +  5);

           Move(myrastport, x +  9, y +  2);
           Draw(myrastport, x + 19, y +  2);
           Move(myrastport, x + 24, y +  7);
           Draw(myrastport, x + 24, y + 17);
           Move(myrastport, x + 19, y + 22);
           Draw(myrastport, x +  9, y + 22);
           Move(myrastport, x +  4, y + 17);
           Draw(myrastport, x +  4, y +  7);

           SetAPen(myrastport, DarkRed);       (* Draw Outer circle *)
           DrawCircle(myrastport, x + 14, y + 12, 11);
           SetAPen(myrastport, Red);                 (* Correct the circle *)
           foo := WritePixel(myrastport, x + 7, y + 4);
           foo := WritePixel(myrastport, x + 21, y + 4);
           foo := WritePixel(myrastport, x + 6, y + 5);
           foo := WritePixel(myrastport, x + 22, y + 5);
           foo := WritePixel(myrastport, x + 6, y + 19);
           foo := WritePixel(myrastport, x + 7, y + 20);
           SetAPen(myrastport, DarkRed);
           foo := WritePixel(myrastport, x + 7, y + 3);
           foo := WritePixel(myrastport, x + 21, y + 3);
           foo := WritePixel(myrastport, x + 5, y + 5);
           foo := WritePixel(myrastport, x + 23, y + 5);
           foo := WritePixel(myrastport, x + 5, y + 19);
           foo := WritePixel(myrastport, x + 23, y + 19);
           foo := WritePixel(myrastport, x + 7, y + 21);
           foo := WritePixel(myrastport, x + 21, y + 21);

           foo := WritePixel(myrastport, x + 16, y + 6);  (* put in shading *)
           foo := WritePixel(myrastport, x + 17, y + 6);
           foo := WritePixel(myrastport, x +  9, y +  8);
           foo := WritePixel(myrastport, x + 10, y +  8);
           foo := WritePixel(myrastport, x + 12, y +  8);
           foo := WritePixel(myrastport, x + 13, y +  8);
           foo := WritePixel(myrastport, x + 16, y +  8);
           foo := WritePixel(myrastport, x + 12, y +  9);
           foo := WritePixel(myrastport, x + 14, y +  9);
           foo := WritePixel(myrastport, x +  9, y + 10);
           foo := WritePixel(myrastport, x + 14, y + 10);
           foo := WritePixel(myrastport, x +  7, y + 11);
           foo := WritePixel(myrastport, x + 11, y + 11);
           foo := WritePixel(myrastport, x +  8, y + 12);
           foo := WritePixel(myrastport, x + 13, y + 12);
           foo := WritePixel(myrastport, x +  8, y + 13);
           foo := WritePixel(myrastport, x + 12, y + 13);
           foo := WritePixel(myrastport, x + 24, y + 14);
           foo := WritePixel(myrastport, x + 10, y + 15);
           foo := WritePixel(myrastport, x + 12, y + 16);
           foo := WritePixel(myrastport, x + 17, y + 21);
           foo := WritePixel(myrastport, x + 18, y + 21);
           Move(myrastport, x + 13, y + 5 );
           Draw(myrastport, x + 15, y +  5);
           Move(myrastport, x + 10, y + 6 );
           Draw(myrastport, x + 14, y +  6);
           Move(myrastport, x +  9, y +  7);
           Draw(myrastport, x + 16, y +  7);
           Move(myrastport, x + 17, y + 8 );
           Draw(myrastport, x + 17, y + 10);
           Move(myrastport, x +  7, y +  9);
           Draw(myrastport, x + 10, y +  9);
           Move(myrastport, x +  8, y + 10);
           Draw(myrastport, x + 10, y + 12);
           Move(myrastport, x + 15, y + 22);
           Draw(myrastport, x + 17, y + 22);
           Move(myrastport, x + 19, y + 21);
           Draw(myrastport, x + 23, y + 17);
           Move(myrastport, x + 22, y + 17);
           Draw(myrastport, x + 24, y + 15);

           SetAPen(myrastport, LtRed);             (* Highlight circle *)
           foo := WritePixel(myrastport, x + 13, y +  2);
           foo := WritePixel(myrastport, x + 10, y +  3);
           foo := WritePixel(myrastport, x + 19, y +  6);
           foo := WritePixel(myrastport, x +  8, y +  7);
           foo := WritePixel(myrastport, x + 21, y +  8);
           foo := WritePixel(myrastport, x +  6, y +  9);
           foo := WritePixel(myrastport, x + 19, y + 10);
           foo := WritePixel(myrastport, x +  6, y + 11);
           foo := WritePixel(myrastport, x + 15, y + 11);
           foo := WritePixel(myrastport, x + 20, y + 11);
           foo := WritePixel(myrastport, x + 23, y + 12);
           foo := WritePixel(myrastport, x +  9, y + 13);
           foo := WritePixel(myrastport, x + 18, y + 13);
           foo := WritePixel(myrastport, x + 20, y + 13);
           foo := WritePixel(myrastport, x + 16, y + 14);
           foo := WritePixel(myrastport, x + 23, y + 14);
           foo := WritePixel(myrastport, x +  6, y + 15);
           foo := WritePixel(myrastport, x + 14, y + 15);
           foo := WritePixel(myrastport, x + 18, y + 15);
           foo := WritePixel(myrastport, x + 18, y + 16);
           foo := WritePixel(myrastport, x +  8, y + 17);
           foo := WritePixel(myrastport, x + 16, y + 17);
           foo := WritePixel(myrastport, x + 13, y + 18);
           foo := WritePixel(myrastport, x + 17, y + 18);
           foo := WritePixel(myrastport, x +  9, y + 19);
           foo := WritePixel(myrastport, x + 10, y + 19);
           foo := WritePixel(myrastport, x + 12, y + 19);
           foo := WritePixel(myrastport, x + 14, y + 19);
           foo := WritePixel(myrastport, x + 17, y + 19);
           foo := WritePixel(myrastport, x + 18, y + 19);
           foo := WritePixel(myrastport, x + 13, y + 21);
           foo := WritePixel(myrastport, x + 14, y + 21);
           foo := WritePixel(myrastport, x + 16, y + 21);
           Move(myrastport, x + 12, y + 3 );
           Draw(myrastport, x + 15, y + 3 );
           Move(myrastport, x +  8, y +  4);
           Draw(myrastport, x + 17, y +  4);
           Move(myrastport, x +  9, y +  5);
           Draw(myrastport, x + 12, y +  5);
           Move(myrastport, x + 16, y +  5);
           Draw(myrastport, x + 18, y +  5);
           Move(myrastport, x +  7, y +  5);
           Draw(myrastport, x +  7, y +  8);
           Move(myrastport, x +  6, y +  6);
           Draw(myrastport, x +  9, y +  6);
           Move(myrastport, x +  5, y +  8);
           Draw(myrastport, x +  8, y +  8);
           Move(myrastport, x +  5, y +  8);
           Draw(myrastport, x +  5, y + 13);
           Move(myrastport, x + 11, y + 20);
           Draw(myrastport, x + 18, y + 20);
           Move(myrastport, x + 19, y + 17);
           Draw(myrastport, x + 19, y + 19);
           Move(myrastport, x + 20, y + 16);
           Draw(myrastport, x + 20, y + 18);
           Move(myrastport, x + 21, y + 14);
           Draw(myrastport, x + 21, y + 16);
           Move(myrastport, x + 22, y + 11);
           Draw(myrastport, x + 22, y + 15);

     | blue   :
           SetAPen(myrastport, BGrey);
           SetOPen(myrastport, BGrey);
           RectFill(myrastport, x, y, x + 29, y + 24);
           SetAPen(myrastport, Blue);
           SetOPen(myrastport, Blue);
           RectFill(myrastport, x + 6, y + 4, x + 22, y + 20);

           Move(myrastport, x +  7, y +  3);   (* Innermost lines   *)
           Draw(myrastport, x + 21, y +  3);
           Move(myrastport, x + 23, y +  5);
           Draw(myrastport, x + 23, y + 19);
           Move(myrastport, x + 21, y + 21);
           Draw(myrastport, x +  7, y + 21);
           Move(myrastport, x +  5, y + 19);
           Draw(myrastport, x +  5, y +  5);

           Move(myrastport, x +  9, y +  2);
           Draw(myrastport, x + 19, y +  2);
           Move(myrastport, x + 24, y +  7);
           Draw(myrastport, x + 24, y + 17);
           Move(myrastport, x + 19, y + 22);
           Draw(myrastport, x +  9, y + 22);
           Move(myrastport, x +  4, y + 17);
           Draw(myrastport, x +  4, y +  7);

           SetAPen(myrastport, DarkBlue);       (* Draw Outer circle *)
           DrawCircle(myrastport, x + 14, y + 12, 11);
           SetAPen(myrastport, Blue);                 (* Correct the circle *)
           foo := WritePixel(myrastport, x + 7, y + 4);
           foo := WritePixel(myrastport, x + 21, y + 4);
           foo := WritePixel(myrastport, x + 6, y + 5);
           foo := WritePixel(myrastport, x + 22, y + 5);
           foo := WritePixel(myrastport, x + 6, y + 19);
           foo := WritePixel(myrastport, x + 7, y + 20);
           SetAPen(myrastport, DarkBlue);
           foo := WritePixel(myrastport, x + 7, y + 3);
           foo := WritePixel(myrastport, x + 21, y + 3);
           foo := WritePixel(myrastport, x + 5, y + 5);
           foo := WritePixel(myrastport, x + 23, y + 5);
           foo := WritePixel(myrastport, x + 5, y + 19);
           foo := WritePixel(myrastport, x + 23, y + 19);
           foo := WritePixel(myrastport, x + 7, y + 21);
           foo := WritePixel(myrastport, x + 21, y + 21);

           foo := WritePixel(myrastport, x + 16, y + 6);  (* put in shading *)
           foo := WritePixel(myrastport, x + 17, y + 6);
           foo := WritePixel(myrastport, x +  9, y +  8);
           foo := WritePixel(myrastport, x + 10, y +  8);
           foo := WritePixel(myrastport, x + 12, y +  8);
           foo := WritePixel(myrastport, x + 13, y +  8);
           foo := WritePixel(myrastport, x + 16, y +  8);
           foo := WritePixel(myrastport, x + 12, y +  9);
           foo := WritePixel(myrastport, x + 14, y +  9);
           foo := WritePixel(myrastport, x +  9, y + 10);
           foo := WritePixel(myrastport, x + 14, y + 10);
           foo := WritePixel(myrastport, x +  7, y + 11);
           foo := WritePixel(myrastport, x + 11, y + 11);
           foo := WritePixel(myrastport, x +  8, y + 12);
           foo := WritePixel(myrastport, x + 13, y + 12);
           foo := WritePixel(myrastport, x +  8, y + 13);
           foo := WritePixel(myrastport, x + 12, y + 13);
           foo := WritePixel(myrastport, x + 24, y + 14);
           foo := WritePixel(myrastport, x + 10, y + 15);
           foo := WritePixel(myrastport, x + 12, y + 16);
           foo := WritePixel(myrastport, x + 17, y + 21);
           foo := WritePixel(myrastport, x + 18, y + 21);
           Move(myrastport, x + 13, y + 5 );
           Draw(myrastport, x + 15, y +  5);
           Move(myrastport, x + 10, y + 6 );
           Draw(myrastport, x + 14, y +  6);
           Move(myrastport, x +  9, y +  7);
           Draw(myrastport, x + 16, y +  7);
           Move(myrastport, x + 17, y + 8 );
           Draw(myrastport, x + 17, y + 10);
           Move(myrastport, x +  7, y +  9);
           Draw(myrastport, x + 10, y +  9);
           Move(myrastport, x +  8, y + 10);
           Draw(myrastport, x + 10, y + 12);
           Move(myrastport, x + 15, y + 22);
           Draw(myrastport, x + 17, y + 22);
           Move(myrastport, x + 19, y + 21);
           Draw(myrastport, x + 23, y + 17);
           Move(myrastport, x + 22, y + 17);
           Draw(myrastport, x + 24, y + 15);

           SetAPen(myrastport, LtBlue);             (* Highlight circle *)
           foo := WritePixel(myrastport, x + 13, y +  2);
           foo := WritePixel(myrastport, x + 10, y +  3);
           foo := WritePixel(myrastport, x + 19, y +  6);
           foo := WritePixel(myrastport, x +  8, y +  7);
           foo := WritePixel(myrastport, x + 21, y +  8);
           foo := WritePixel(myrastport, x +  6, y +  9);
           foo := WritePixel(myrastport, x + 19, y + 10);
           foo := WritePixel(myrastport, x +  6, y + 11);
           foo := WritePixel(myrastport, x + 15, y + 11);
           foo := WritePixel(myrastport, x + 20, y + 11);
           foo := WritePixel(myrastport, x + 23, y + 12);
           foo := WritePixel(myrastport, x +  9, y + 13);
           foo := WritePixel(myrastport, x + 18, y + 13);
           foo := WritePixel(myrastport, x + 20, y + 13);
           foo := WritePixel(myrastport, x + 16, y + 14);
           foo := WritePixel(myrastport, x + 23, y + 14);
           foo := WritePixel(myrastport, x +  6, y + 15);
           foo := WritePixel(myrastport, x + 14, y + 15);
           foo := WritePixel(myrastport, x + 18, y + 15);
           foo := WritePixel(myrastport, x + 18, y + 16);
           foo := WritePixel(myrastport, x +  8, y + 17);
           foo := WritePixel(myrastport, x + 16, y + 17);
           foo := WritePixel(myrastport, x + 13, y + 18);
           foo := WritePixel(myrastport, x + 17, y + 18);
           foo := WritePixel(myrastport, x +  9, y + 19);
           foo := WritePixel(myrastport, x + 10, y + 19);
           foo := WritePixel(myrastport, x + 12, y + 19);
           foo := WritePixel(myrastport, x + 14, y + 19);
           foo := WritePixel(myrastport, x + 17, y + 19);
           foo := WritePixel(myrastport, x + 18, y + 19);
           foo := WritePixel(myrastport, x + 13, y + 21);
           foo := WritePixel(myrastport, x + 14, y + 21);
           foo := WritePixel(myrastport, x + 16, y + 21);
           Move(myrastport, x + 12, y + 3 );
           Draw(myrastport, x + 15, y + 3 );
           Move(myrastport, x +  8, y +  4);
           Draw(myrastport, x + 17, y +  4);
           Move(myrastport, x +  9, y +  5);
           Draw(myrastport, x + 12, y +  5);
           Move(myrastport, x + 16, y +  5);
           Draw(myrastport, x + 18, y +  5);
           Move(myrastport, x +  7, y +  5);
           Draw(myrastport, x +  7, y +  8);
           Move(myrastport, x +  6, y +  6);
           Draw(myrastport, x +  9, y +  6);
           Move(myrastport, x +  5, y +  8);
           Draw(myrastport, x +  8, y +  8);
           Move(myrastport, x +  5, y +  8);
           Draw(myrastport, x +  5, y + 13);
           Move(myrastport, x + 11, y + 20);
           Draw(myrastport, x + 18, y + 20);
           Move(myrastport, x + 19, y + 17);
           Draw(myrastport, x + 19, y + 19);
           Move(myrastport, x + 20, y + 16);
           Draw(myrastport, x + 20, y + 18);
           Move(myrastport, x + 21, y + 14);
           Draw(myrastport, x + 21, y + 16);
           Move(myrastport, x + 22, y + 11);
           Draw(myrastport, x + 22, y + 15);

  END;

END DrawSquare;


(***********************************************************************)

PROCEDURE HighlightSquare (xloc : boardrange; yloc : boardrange;
                      player : playertype);

(*      This routine highlights the given square in the color of the   *)
(* specified player.  It is assumed that checking has already been     *)
(* made so that the highlighting makes sense.                          *)
(*                                                                     *)
(*   INPUT                                                             *)
(*            xloc, yloc     These two numbers describe the location   *)
(*                           of the square to change.                  *)
(*                                                                     *)
(*            player         This tells the routine what colors to     *)
(*                           use.                                      *)
(*                                                                     *)
(*                                                                     *)
(*   OUTPUT                                                            *)
(*                     The display is change so that only the square   *)
(*                     indicated looks highlighted.                    *)

VAR
  x, y : CARDINAL;        (* The top left corner of the square   *)

BEGIN
     (* First, find the upper left corner of the square in question *)
  x := xloc * 31 + 21;
  y := yloc * 26 - 8;

     (* Now, change the color of the border of the square *)
  IF player = red THEN
     SetAPen(myrastport, Red);
     ELSE SetAPen(myrastport, Blue);
     END;
  Move(myrastport, x - 1,  y - 1);
  Draw(myrastport, x + 30, y - 1);
  Draw(myrastport, x + 30, y + 25);
  Draw(myrastport, x - 1,  y + 25);
  Draw(myrastport, x - 1,  y - 1);
  Move(myrastport, x    ,  y    );
  Draw(myrastport, x + 29, y    );
  Draw(myrastport, x + 29, y + 24);
  Draw(myrastport, x    ,  y + 24);
  Draw(myrastport, x    ,  y    );

(*
  IF player = red THEN                (* Do the highlighting *)
     SetAPen(myrastport, DarkRed);
     ELSE SetAPen(myrastport, DarkBlue);
     END;

Move(myrastport, x + 4, y + 7);    Draw(myrastport, x + 9, y + 2);
Move(myrastport, x + 3, y +10);    Draw(myrastport, x +12, y + 1);
Move(myrastport, x + 3, y +12);    Draw(myrastport, x +14, y + 1);
Move(myrastport, x + 3, y +14);    Draw(myrastport, x +16, y + 1);
Move(myrastport, x + 4, y +15);    Draw(myrastport, x +17, y + 2);
Move(myrastport, x + 4, y +17);    Draw(myrastport, x +19, y + 2);
Move(myrastport, x + 5, y +18);    Draw(myrastport, x +20, y + 3);
Move(myrastport, x + 6, y +19);    Draw(myrastport, x +21, y + 4);
Move(myrastport, x + 7, y +20);    Draw(myrastport, x +22, y + 5);
Move(myrastport, x + 8, y +21);    Draw(myrastport, x +23, y + 6);
Move(myrastport, x + 9, y +22);    Draw(myrastport, x +24, y + 7);
Move(myrastport, x +11, y +22);    Draw(myrastport, x +24, y + 9);
Move(myrastport, x +12, y +23);    Draw(myrastport, x +25, y +10);
Move(myrastport, x +14, y +23);    Draw(myrastport, x +25, y +12);
Move(myrastport, x +16, y +23);    Draw(myrastport, x +25, y +14);
Move(myrastport, x +19, y +22);    Draw(myrastport, x +24, y +17);
*)

END HighlightSquare;


(***********************************************************************)

PROCEDURE UnHighlightSquare (xloc : boardrange; yloc : boardrange;
                             player : playertype);

(*      This routine UNhighlights the given square.  It undoes the     *)
(* effects of HighlightSquare.  Similarly, it assumes that checking    *)
(* has already been done so that unhighlighting makes sense.           *)
(*                                                                     *)
(*   INPUT                                                             *)
(*            xloc, yloc     These two numbers describe the location   *)
(*                           of the square to change.                  *)
(*                                                                     *)
(*            player         This is the color of the square to UN-    *)
(*                           highlight.                                *)
(*                                                                     *)
(*   OUTPUT                                                            *)
(*                     The display is change so that only the square   *)
(*                     indicated looks UNhighlighted.                  *)

VAR
  x, y : CARDINAL;        (* The top left corner of the square   *)

BEGIN
     (* First, find the upper left corner of the square in question *)
  x := xloc * 31 + 21;
  y := yloc * 26 - 8;

  SetAPen(myrastport, Black);
  Move(myrastport, x - 1,  y - 1);
  Draw(myrastport, x + 30, y - 1);
  Draw(myrastport, x + 30, y + 25);
  Draw(myrastport, x - 1,  y + 25);
  Draw(myrastport, x - 1,  y - 1);
  SetAPen(myrastport, BGrey);
  Move(myrastport, x    ,  y    );
  Draw(myrastport, x + 29, y    );
  Draw(myrastport, x + 29, y + 24);
  Draw(myrastport, x    ,  y + 24);
  Draw(myrastport, x    ,  y    );

(*
  CASE state.board[xloc,yloc] OF             (* UnDo the highlighting *)
     | red    :
           SetAPen(myrastport, Red);
     | blue   :
           SetAPen(myrastport, Blue);
     | empty  :
           SetAPen(myrastport, BGrey);
     | block  :
           SetAPen(myrastport, Black);
     END;
Move(myrastport, x + 4, y + 7);    Draw(myrastport, x + 9, y + 2);
Move(myrastport, x + 3, y +10);    Draw(myrastport, x +12, y + 1);
Move(myrastport, x + 3, y +12);    Draw(myrastport, x +14, y + 1);
Move(myrastport, x + 3, y +14);    Draw(myrastport, x +16, y + 1);
Move(myrastport, x + 4, y +15);    Draw(myrastport, x +17, y + 2);
Move(myrastport, x + 4, y +17);    Draw(myrastport, x +19, y + 2);
Move(myrastport, x + 5, y +18);    Draw(myrastport, x +20, y + 3);
Move(myrastport, x + 6, y +19);    Draw(myrastport, x +21, y + 4);
Move(myrastport, x + 7, y +20);    Draw(myrastport, x +22, y + 5);
Move(myrastport, x + 8, y +21);    Draw(myrastport, x +23, y + 6);
Move(myrastport, x + 9, y +22);    Draw(myrastport, x +24, y + 7);
Move(myrastport, x +11, y +22);    Draw(myrastport, x +24, y + 9);
Move(myrastport, x +12, y +23);    Draw(myrastport, x +25, y +10);
Move(myrastport, x +14, y +23);    Draw(myrastport, x +25, y +12);
Move(myrastport, x +16, y +23);    Draw(myrastport, x +25, y +14);
Move(myrastport, x +19, y +22);    Draw(myrastport, x +24, y +17);
*)
END UnHighlightSquare;


(**************************************************************************)

PROCEDURE DrawBoard (board : boardtype);

(*      Replaces the current display with the given board.             *)
(*                                                                     *)
(*   INPUT                                                             *)
(*            board       A variable of boardtype that describes the   *)
(*                        contents of every location of a board.       *)
(*                                                                     *)
(*   OUTPUT                                                            *)
(*            The screen is modified to display the contents of the    *)
(*            input data.                                              *)

VAR
  i, j : boardrange;
  x, y : CARDINAL;        (* The top left corner of the square   *)

BEGIN

  FOR j := 1 TO 7 DO
     FOR i := 1 TO 7 DO
        x := i * 31 + 35;    (* Find the center of the square in question *)
        y := j * 26 + 4;
        CASE board[i,j] OF
           | red    :
              IF ReadPixel(myrastport, x, y) # Red THEN
                 DrawSquare(i, j, red);
                 END;
           | blue   :
              IF ReadPixel(myrastport, x, y) # Blue THEN
                 DrawSquare(i, j, blue);
                 END;
           | empty  :
              IF ReadPixel(myrastport, x, y) # BGrey THEN
                 DrawSquare(i, j, empty);
                 END;
           | block  :
              IF ReadPixel(myrastport, x, y) # HGrey THEN
                 DrawSquare(i, j, block);
                 END;
           END; (* case *)
     END;
  END;
END DrawBoard;


(*************************************************************************)

PROCEDURE ChangePointer (code : pointercode);

(*      This changes the mouse pointer.  The code determines what the  *)
(* pointer is changed to.                                              *)
(*                                                                     *)
(*   INPUT                                                             *)
(*            code        This variable is of the enumerated type,     *)
(*                        pointercode.  It consists of RedCircle,      *)
(*                        BlueCircle, and Default.  The Default code   *)
(*                        tells this routine to restore the pointer    *)
(*                        to whatever it was when the program was      *)
(*                        started.                                     *)
(*                                                                     *)
(*   OUTPUT                                                            *)
(*            The mouse pointer is immediately changed to the desired  *)
(*            pointer.                                                 *)

BEGIN
  CASE code OF
     |  RedCircle   :
        SetRGB4 (myviewport, 18, 15, 5, 5);    (* Red *)
        SetRGB4 (myviewport, 17, 13, 0, 0);    (* Lt Red   *)
        SetRGB4 (myviewport, 19, 9, 0, 0);     (*  Dark Red *)
        SetPointer(mywindowptr^, ADDRESS(circle), 16, 16, -7, -7);

     |  BlueCircle  :
        SetRGB4 (myviewport, 18, 6, 6, 15);    (* Blue *)
        SetRGB4 (myviewport, 17, 3, 4, 14);    (* Lt Blue   *)
        SetRGB4 (myviewport, 19, 0, 0, 10);    (*  Dark Blue *)
        SetPointer(mywindowptr^, ADDRESS(circle), 16, 16, -7, -7);

     |  RedPointer  :
        SetRGB4 (myviewport, 17, 13, 0, 0);     (* red *)
        SetRGB4 (myviewport, 18, 0, 0, 0);     (* black *)
        SetRGB4 (myviewport, 19, 0, 0, 0);     (* black *)
        SetPointer(mywindowptr^, ADDRESS(mypointer[red]), 10, 16, -1, -2);

     |  BluePointer :
        SetRGB4 (myviewport, 17, 2, 4, 14);    (* blue *)
        SetRGB4 (myviewport, 18, 2, 4, 14);    (* blue *)
        SetRGB4 (myviewport, 19, 0, 0, 0);     (* black *)
        SetPointer(mywindowptr^, ADDRESS(mypointer[blue]), 10, 16, -16, -2);

     |  DefaultPointer :
        SetRGB4 (myviewport, 17, oldmousecolor1[1], oldmousecolor1[2], oldmousecolor1[3]);
        SetRGB4 (myviewport, 18, oldmousecolor2[1], oldmousecolor2[2], oldmousecolor2[3]);
        SetRGB4 (myviewport, 19, oldmousecolor3[1], oldmousecolor3[2], oldmousecolor3[3]);
        ClearPointer(mywindowptr^);

     |  EmptySquare :
        SetRGB4 (myviewport, 18, 10, 10, 10);
        SetRGB4 (myviewport, 17, 0, 0, 0);
        SetRGB4 (myviewport, 19, 0, 0, 0);
        SetPointer(mywindowptr^, ADDRESS(emptysquare), 16, 16, -7, -7);

     |  BlockSquare :
        SetRGB4 (myviewport, 18, 8, 8, 8);
        SetRGB4 (myviewport, 17, 6, 6, 6);
        SetRGB4 (myviewport, 19, 4, 4, 4);     (* This is color 11 *)
        SetPointer(mywindowptr^, ADDRESS(blocksquare), 16, 16, -7, -7);
     END;

END ChangePointer;


(**************************************************************************)

PROCEDURE PrintTurn (player : playertype);

(*      Displays whose turn it is by the message on the top of the     *)
(* screen                                                              *)
(*                                                                     *)
(*   INPUT                                                             *)
(*            player      The player whose turn it now is.             *)
(*                                                                     *)
(*   OUTPUT                                                            *)
(*            The screen is modified to display whose turn it is.      *)
BEGIN
        (* First, blank out the old message *)
  itext.FrontPen := BYTE(Black);
  itext.BackPen := BYTE(Black);
  itext.DrawMode := Jam2;
  itext.LeftEdge := 0;   itext.TopEdge := 0;
  itext.ITextFont := NIL;
  itext.IText := ADR("               ");
  itext.NextText := NIL;
  PrintIText(myrastport,itext, 117, 7);

  itext.FrontPen := BYTE(Black);
  IF player = red THEN
     itext.BackPen := BYTE(Red);
     itext.IText := ADR("Red's Turn");
     PrintIText(myrastport,itext, 121,7);
  ELSE
     itext.BackPen := BYTE(Blue);
     itext.IText := ADR("Blue's Turn");
     PrintIText(myrastport,itext, 117,7);
  END;
END PrintTurn;

(**************************************************************************)
PROCEDURE PrintMsg (msg : printmsgtype);

(*   Prints the message at the top of the screen.  This procedure should  *)
(* not be confused with the procedure PrintTurn, which displays who's     *)
(* turn it is to play.                                                    *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            msg                  This is which message to display.      *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*            The screen is changed to display the desired message.       *)

BEGIN
        (* First, blank out the old message *)
  itext.FrontPen := BYTE(Black);
  itext.BackPen := BYTE(Black);
  itext.DrawMode := Jam2;
  itext.LeftEdge := 0;   itext.TopEdge := 0;
  itext.ITextFont := NIL;
  itext.IText := ADR("              ");
  itext.NextText := NIL;
  PrintIText(myrastport,itext, 117, 7);

  CASE msg OF
     GameOver :
        itext.FrontPen := BYTE(White);
        itext.IText := ADR("Game Over");
        PrintIText(myrastport, itext, 125,7);
        |

     Thinking :
        IF state.turn = red THEN
           itext.FrontPen := BYTE(Red);
           ELSE itext.FrontPen := BYTE(Blue);
           END;
        itext.IText := ADR("Thinking...");
        PrintIText(myrastport, itext, 129,7);
        |
     END;

END PrintMsg;


(**************************************************************************)

PROCEDURE ShowScore (redscore : CARDINAL; bluescore : CARDINAL);

(*      Displays the scores.                                           *)
(*                                                                     *)
(*   INPUT                                                             *)
(*            redscore    The number of squares occupied by the red    *)
(*                        player.                                      *)
(*                                                                     *)
(*            bluescore   The number of squares occupied by the blue   *)
(*                        player.                                      *)
(*                                                                     *)
(*   OUTPUT                                                            *)
(*            The screen is modified to display the scores.            *)

VAR
  str : ARRAY [1..8] OF CHAR;

BEGIN
        (* First, blank out the old scores *)
  itext.FrontPen := BYTE(Black);
  itext.BackPen := BYTE(Black);
  itext.DrawMode := Jam2;
  itext.LeftEdge := 0;   itext.TopEdge := 0;
  itext.ITextFont := NIL;
  itext.IText := ADR("  ");
  itext.NextText := NIL;
  PrintIText(myrastport,itext, 22, 25);
  PrintIText(myrastport,itext, 282, 25);

  itext.FrontPen := BYTE(Red);
  itext.DrawMode := Jam1;
  ConvNumberToString(str, LONGWORD(redscore), FALSE, 10, 2, " ");
  itext.IText := ADR(str);
  PrintIText(myrastport,itext, 23, 25);

  itext.FrontPen := BYTE(Blue);
  ConvNumberToString(str, LONGWORD(bluescore), FALSE, 10, 2, " ");
  itext.IText := ADR(str);
  PrintIText(myrastport,itext, 282, 25);

END ShowScore;


(**************************************************************************)
PROCEDURE ShowAbout;

(*   Simply displays a message about the programmer and then waits for *)
(* a mouse click to then erase this new display and return to the old  *)
(* one.                                                                *)

VAR
  i, j : boardrange;

BEGIN
  ClearMenuStrip( mywindowptr^ );
  SetAPen(myrastport,DarkGreen);           (* Draw the rectangle *)
  SetOPen(myrastport,Green);
  RectFill(myrastport,52,69,267,143);

  itext.FrontPen := BYTE(White);         (* Printing the text *)
  itext.DrawMode := Jam1;
  itext.LeftEdge := 56;   itext.TopEdge := 73;
  itext.ITextFont := NIL;
  itext.IText := ADR("ATTACKS");
  itext.NextText := NIL;
  PrintIText(myrastport,itext, 0, 0);
  itext.TopEdge := 93;
  itext.IText := ADR("was brought to you by");
  PrintIText(myrastport,itext, 0, 0);
  itext.TopEdge := 113;
  itext.IText := ADR("        Scott Biggs");
  PrintIText(myrastport,itext, 0, 0);
  itext.TopEdge := 123;
  itext.IText := ADR("        6313 Walnut Hills");
  PrintIText(myrastport,itext, 0, 0);
  itext.TopEdge := 133;
  itext.IText := ADR("        Austin, TX  78723");
  PrintIText(myrastport,itext, 0, 0);

  WaitForMouseUp;

  SetAPen(myrastport,Black);           (* Erase the rectangle *)
  SetOPen(myrastport,Black);
  RectFill(myrastport,52,69,267,143);
  FOR j := 3 TO 5 DO
     FOR i := 1 TO 7 DO
        DrawSquare(i,j,state.board[i,j]);
        END;
     END;
  ChangeToMainMenu;
END ShowAbout;


(***********************************************************************)



END attacksgraphics.
