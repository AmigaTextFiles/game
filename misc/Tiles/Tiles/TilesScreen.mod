(*
This module initializes the window and screen for
the trails program.

Created: 5/24/86 by Richie Bielak

Modified:

Copyright (c) 1986 by Richard Bielak

This program maybe freely copied. But please
leave my name in. Thanks.....Richie

Turned into TilesScreen by Todd Lewis in 1988.  Thanks alot Richie!
*)
IMPLEMENTATION MODULE TilesScreen;

FROM SYSTEM    IMPORT ADR, BYTE, ADDRESS, SETREG, NULL;
FROM Intuition IMPORT
     WindowFlags, NewWindow, IDCMPFlags, IDCMPFlagSet, WindowFlagSet,
     WindowPtr, ScreenPtr, CustomScreen;
FROM Windows   IMPORT OpenWindow, ReportMouse;
FROM Views     IMPORT Hires, ModeSet;
FROM Screens   IMPORT OpenScreen, NewScreen;
FROM Text      IMPORT TextAttr, NormalStyle, FontFlags,FontFlagSet;
FROM AmigaUtils IMPORT BPTRFromPtr;

VAR
  MyWindow : NewWindow;
  MyScreen : NewScreen;
  ScreenName : ARRAY [0..20] OF CHAR;
  FontName   : ARRAY [0..20] OF CHAR;
  MyFont   : TextAttr;

PROCEDURE InitScreen (VAR s : NewScreen);
  BEGIN
    ScreenName := " Tiles! ";
    FontName   := "topaz.font";
    WITH MyFont DO
      taName := BPTRFromPtr( ADR(FontName) );
      taYSize:= 8; (* TOPAZ_EIGHTY *)
      taStyle:= NormalStyle;
      taFlags:= FontFlagSet{ROMFont};
      END;
    WITH s DO
      LeftEdge := 0; TopEdge := 0; 
      Width := 640; Height := 200;
      Depth := 4;
      DetailPen := BYTE (0); BlockPen := BYTE (1);
      ViewModes := ModeSet {Hires};
      Type := CustomScreen;
      Font := ADR(MyFont);
      DefaultTitle := ADR (ScreenName);
      Gadgets := NULL;
      CustomBitMap := NULL
    END;
  END InitScreen;

PROCEDURE InitWindow (VAR w : NewWindow);
  BEGIN
    WITH w DO
      LeftEdge := 0; TopEdge := 0; Width := 640; Height := 200;
      DetailPen := BYTE (0);
      BlockPen := BYTE (1);
      Title := NULL;
      Flags := WindowFlagSet {Activate, Borderless, BackDrop,
                     ReportMouseFlag };
      IDCMPFlags := IDCMPFlagSet{CloseWindowFlag, MenuPick, ReqClear,
           MouseButtons, MouseMove, GadgetUp, GadgetDown};

      Type := CustomScreen;
      CheckMark := NULL;
      FirstGadget := NULL;
      Screen := sp;
      BitMap := NULL;
      MinWidth := 10; MinHeight := 10;
      MaxWidth := 640; MaxHeight := 200;
    END
  END InitWindow;

PROCEDURE SetUpScreen;
  BEGIN
    InitScreen (MyScreen);
    (* Define a new screen *)
    sp := OpenScreen (ADR(MyScreen));
    InitWindow (MyWindow);
    (* Now open the window *)
    wp := OpenWindow (MyWindow);
  END SetUpScreen;

BEGIN
END TilesScreen.


