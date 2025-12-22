(*$T- Range Checking Off (bombs if we turn it on!) *)
(* $ S - Stack Checking Off *)
MODULE Tiles;

(* Game stolen from the Mac by Todd Lewis.
   Lots of code ideas from Trails, by Richard Bielak.
   Created: 3/15/88 by Todd Lewis
   Modified:
Copyright (c) 1988 by Todd Lewis
This program can be freely copied, but please
leave Richie's name in. Thanks, Todd.
*)

FROM SYSTEM    IMPORT ADR, BYTE, WORD, ADDRESS, SETREG, NULL;
FROM Intuition IMPORT IntuitionName, IntuitionBase,

                      IntuiMessagePtr, IDCMPFlags, IDCMPFlagSet;
FROM GraphicsLibrary IMPORT GraphicsName, GraphicsBase;
FROM Libraries  IMPORT OpenLibrary,CloseLibrary;
FROM Windows IMPORT ReportMouse, CloseWindow, ViewPortAddress;
FROM Ports      IMPORT WaitPort, ReplyMsg, MessagePtr, GetMsg;
FROM InputEvents IMPORT LButton, UpPrefix;
FROM Screens    IMPORT CloseScreen;
FROM Colors IMPORT SetRGB4;
(* FROM DOSProcessHandler IMPORT Exit; Nope! Doesn't do process right *)
IMPORT AMIGAX;
FROM DOSExtensions IMPORT ProcessPtr, Process;
FROM Interrupts IMPORT Forbid;
(* The modules below are home grown *)
FROM TilesMenu IMPORT ConnectMenu, DisconnectMenu, TilesMenuType,
                       ActionItemType, SymetryItemType, SizeItemType,
       SquareSizeItemType;
FROM TilesPlay   IMPORT InitTiles,FreeBitMap,UserInput;
FROM TilesScreen IMPORT SetUpScreen,wp,sp;
FROM TilesInfo IMPORT ShowTilesInfo, InitTilesInfo;
FROM DecodeMenu IMPORT MenuNull, MenuNumber, ItemNumber;

CONST
  IntuitionRev = 29;

PROCEDURE OpenLibraries () : BOOLEAN;
  BEGIN
    (* Open intuition library *)
    IntuitionBase := OpenLibrary (IntuitionName,IntuitionRev);
    IF IntuitionBase = 0 THEN
      RETURN FALSE
    END;

    (* Now open the graphics library *)
    GraphicsBase := OpenLibrary (GraphicsName, 0);
    IF GraphicsBase = 0 THEN
      CloseLibrary(IntuitionBase);
      RETURN FALSE
    END;
    RETURN TRUE
  END OpenLibraries;

PROCEDURE CloseLibraries();
  BEGIN
    IF (GraphicsBase # 0)
       THEN CloseLibrary(GraphicsBase); END;
    IF (IntuitionBase # 0)
       THEN CloseLibrary(IntuitionBase); END;
    END CloseLibraries;

(* ++++++++++++++++++++++++++++++++++++ *)
PROCEDURE ProcessMenuRequest (code : CARDINAL; VAR quit : BOOLEAN);
  VAR
    menu, item : CARDINAL;

  BEGIN
    menu := MenuNumber (code); item := ItemNumber (code);
    CASE TilesMenuType (menu) OF
      Actions:
        CASE ActionItemType (item) OF
          NewBoard : InitTiles;     |
          AboutTiles: ShowTilesInfo( wp ); |
          QuitTiles:  quit := TRUE; |
         END;
      END;
  END ProcessMenuRequest;


PROCEDURE ProcessButton (code, x, y : CARDINAL);
  VAR ButtonDown : BOOLEAN;
  BEGIN
    (* If the button was just pressed,     *)
    (* Play the piece through UserInput.   *)
    ButtonDown := code = LButton;
    IF ButtonDown THEN UserInput(x,y); END;
  END ProcessButton;

PROCEDURE ProcessMessages;
  VAR
    MsgPtr : IntuiMessagePtr;
    Quit   : BOOLEAN;
    code   : CARDINAL;
    class  : IDCMPFlagSet;
    x, y   : CARDINAL;
  BEGIN
    Quit := FALSE;

    (* Get messages from intuition, and process them *)
    REPEAT
      (* Wait for a message *)
      MsgPtr := IntuiMessagePtr(WaitPort (wp^.UserPort));
      (* Got something, process it *)
      REPEAT
        MsgPtr := IntuiMessagePtr(GetMsg(wp^.UserPort));
        IF MsgPtr <> NULL THEN
          class := MsgPtr^.Class;
          code  := MsgPtr^.Code;
          x     := MsgPtr^.MouseX;
          y     := MsgPtr^.MouseY;
          ReplyMsg (MessagePtr(MsgPtr));
          IF   (class = IDCMPFlagSet {MouseButtons})
              THEN  ProcessButton (code, x, y)
            ELSIF (class = IDCMPFlagSet {MenuPick}) AND (code <> MenuNull)
              THEN ProcessMenuRequest (code, Quit);
            END;
          END; (* IF *)
        UNTIL MsgPtr = NULL
      UNTIL Quit
  END ProcessMessages;

PROCEDURE SetColors;
  VAR vpa : ADDRESS;
  BEGIN
    vpa := ViewPortAddress(wp);
    SetRGB4(vpa, 0, 0, 5,13);
    SetRGB4(vpa, 1,12,13,14);
    SetRGB4(vpa, 2, 3, 4, 8);
    SetRGB4(vpa, 3, 4,11,15);

    SetRGB4(vpa, 4,12, 4, 0);
    SetRGB4(vpa, 5,15,13,12);
    SetRGB4(vpa, 6, 8, 4, 3);
    SetRGB4(vpa, 7,15,11, 5);

    SetRGB4(vpa, 8, 0, 3, 9);
    SetRGB4(vpa, 9, 6, 7, 8);
    SetRGB4(vpa,10, 1, 1, 3);
    SetRGB4(vpa,11, 2, 5, 7);

    SetRGB4(vpa,12,15, 0, 2);
    SetRGB4(vpa,13,11,11, 0);
    SetRGB4(vpa,14, 4, 8, 2);
    SetRGB4(vpa,15, 2, 5, 1);
    END SetColors;

VAR
  i : CARDINAL;
  processptr : ProcessPtr;
  startupmsg : ADDRESS;
BEGIN
  IF OpenLibraries() THEN
    InitTilesInfo;
    SetUpScreen;
    (* Attach menu to the window *)
    ConnectMenu(wp);
    (* Don't report mouse until Button is clicked *)
    ReportMouse(wp,FALSE);
    SetColors;
    InitTiles;
    ProcessMessages;
    FreeBitMap;
    DisconnectMenu(wp);
    (* Close the window and screen  *)
    CloseWindow(wp);
    CloseScreen(sp);
    CloseLibraries;
    END; (* IF *)
  (*  Exit(0);  Nope!  Doesn't close a process right! *)
  processptr := AMIGAX.ProcessPtr;
  IF (processptr^.prTaskNum = 0)   (* 0 = not cli, !0 = cli *)
        THEN startupmsg := GetMsg(ADR(processptr^.prMsgPort));
             IF (startupmsg # ADDRESS(0))
                THEN Forbid;
                     ReplyMsg(startupmsg);
                END;
        END;
END Tiles.


