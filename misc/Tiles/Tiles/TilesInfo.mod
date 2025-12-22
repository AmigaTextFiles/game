
IMPLEMENTATION MODULE TilesInfo;

(*
This module displays a requester with some info
about Tiles.

Created: 6/11/86 by Richie Bielak

Modified:

CopyRight (c) 1986, by Richie Bielak

This program may be freely distributed. But please leave
my name in. Thanks... Richie.

Turned into TilesInfo by Todd Lewis in 1988.  Thanks alot, Richie!
*)

FROM Intuition    IMPORT WindowPtr, IDCMPFlagSet, IntuitionText, Requester,
                         RequesterFlagSet, Gadget, PropInfoPtr, GadgetFlagSet,
                         ActivationFlagSet, ActivationFlags, Border;
FROM Requesters   IMPORT InitRequester, Request;
FROM SYSTEM       IMPORT ADR, BYTE, ADDRESS;
FROM GraphicsLibrary IMPORT Jam2, Jam1, DrawingModeSet;


VAR
  NULL : ADDRESS;
  InfoRequest : Requester;

PROCEDURE ShowTilesInfo (wp : WindowPtr);
  VAR succ : BOOLEAN;
  BEGIN
    succ := Request (InfoRequest, wp)
  END ShowTilesInfo;

(* ++++ GADGET related variables ++++++ *)
CONST
  InfoGadWidth = 70;
  InfoGadHeight = 10;
  BOOLGADGET = 1H;
  REQGADGET = 1000H;
VAR
  InfoGadText    : IntuitionText;
  InfoGad        : Gadget;
  InfoGadTextStr : ARRAY [0..20] OF CHAR;
  InfoGadBorder  : Border;
  InfoGadPairs   : ARRAY [1..10] OF INTEGER;

(* ++++++++++++++++++++++++++++++++++++ *)
PROCEDURE SetUpGadget ();
  BEGIN
    InfoGadTextStr := "Continue";

    (* Coordinates for border of the gadget box *)
    InfoGadPairs [1] := 0;    InfoGadPairs [2] := 0;
    InfoGadPairs [3] := InfoGadWidth+1;    InfoGadPairs [4] := 0;
    InfoGadPairs [5] := InfoGadWidth+1;
    InfoGadPairs [6] := InfoGadHeight+1;
    InfoGadPairs [7] := 0;    InfoGadPairs [8] := InfoGadHeight+1;
    InfoGadPairs [9] := 0;    InfoGadPairs [10] := 0;

    WITH InfoGadBorder DO
      LeftEdge := -1; TopEdge := -1;
      FrontPen := BYTE (3); BackPen := BYTE (0);
      DrawMode := BYTE (Jam1); Count := BYTE (5);
      XY := ADR (InfoGadPairs); NextBorder := NULL;
    END;

    WITH InfoGadText DO
      FrontPen := BYTE (2); BackPen := BYTE (1);
      DrawMode := BYTE (DrawingModeSet {Jam2});
      LeftEdge := 1; TopEdge := 1;
      ITextFont := NULL; NextText := NULL;
      IText := ADR (InfoGadTextStr);
    END;

    WITH InfoGad DO
      NextGadget := NULL;
      LeftEdge := (InfoReqWidth DIV 2) - (InfoGadWidth DIV 2);
      TopEdge := InfoReqHeight - (InfoGadHeight + 5);
      Width := InfoGadWidth; Height := InfoGadHeight;
      Flags := GadgetFlagSet {};
      Activation := ActivationFlagSet {EndGadget, RelVerify};
      GadgetType := BOOLGADGET + REQGADGET;
      GadgetRender := ADR (InfoGadBorder);
      SelectRender := NULL;
      GadgetText := ADR (InfoGadText);
      MutualExclude := 0;
      SpecialInfoProp := PropInfoPtr (0);
      GadgetID := 0; UserData := NULL
    END;
  END SetUpGadget;

(* +++++++ These variables are needed for the requester's stuff +++ *)
CONST
  InfoReqWidth = 330;
  InfoReqHeight = 140;

VAR
  InfoReqBorder : Border;
  InfoReqPairs  : ARRAY [1..10] OF INTEGER;
  InfoReqText   : ARRAY [0..9] OF IntuitionText;


(* ++++++++++++++++++++++++++++++++++++ *)
PROCEDURE SetUpRequester ();
  BEGIN
    (* Set up the border stuff *)
    (* Coordinates for border of the gadget box *)
    InfoReqPairs [1] := 0;    InfoReqPairs [2] := 0;
    InfoReqPairs [3] := InfoReqWidth-3;    InfoReqPairs [4] := 0;
    InfoReqPairs [5] := InfoReqWidth-3;
    InfoReqPairs [6] := InfoReqHeight-3;
    InfoReqPairs [7] := 0;    InfoReqPairs [8] := InfoReqHeight-3;
    InfoReqPairs [9] := 0;    InfoReqPairs [10] := 0;

    WITH InfoReqBorder DO
      LeftEdge := 1; TopEdge := 1;
      FrontPen := BYTE (3); BackPen := BYTE (0);
      DrawMode := BYTE (Jam1); Count := BYTE (5);
      XY := ADR (InfoReqPairs); NextBorder := NULL;
    END;

    (* Set up the requester *)
    InitRequester (InfoRequest);

    WITH InfoRequest DO
      LeftEdge := 20; TopEdge := 30;
      Width := InfoReqWidth; Height := InfoReqHeight;
      ReqGadget := ADR (InfoGad);
      ReqText := ADR (InfoReqText);
      ReqBorder := ADR (InfoReqBorder);
      BackFill := BYTE (1);
    END;

  END SetUpRequester;

(* ++++++++++++++++++++++++++++++++++++ *)
PROCEDURE SetUpRequesterText ();

  (* ++++++++++++++++++++++++++++ *)
  PROCEDURE InitIText (VAR itext : IntuitionText;
                       L, T : CARDINAL;
       Next : ADDRESS;
       VAR text : ARRAY OF CHAR);
    BEGIN
      WITH itext DO
        FrontPen := BYTE (2); BackPen := BYTE (1);
        DrawMode := BYTE (DrawingModeSet {Jam2});
        LeftEdge := L; TopEdge := T;
        ITextFont := NULL; NextText := Next;
        IText := ADR (text);
      END;
    END InitIText;

  BEGIN
    InitIText (InfoReqText[0], 7,  6, ADR (InfoReqText[1]),
               "            Tiles!  Ver2.1            ");
    InitIText (InfoReqText[1], 7, 16, ADR (InfoReqText[2]),
               "  Copyright (c) 1988 - Todd M. Lewis. ");
    InitIText (InfoReqText[2], 7, 24, ADR (InfoReqText[3]),
               "  Parts Copyright 1986 - Richie Bielak.");
    InitIText (InfoReqText[3], 7, 34, ADR (InfoReqText[4]),
               "  email: utoddl@unc.bitnet            ");
    InitIText (InfoReqText[4], 7, 43, ADR (InfoReqText[5]),
               "         utoddl@ecsvax.uncecs.edu     ");
    InitIText (InfoReqText[5], 7, 55, ADR (InfoReqText[6]),
               "     (Your comments are welcome.)     ");
    InitIText (InfoReqText[6], 7, 64, ADR (InfoReqText[7]),
               "    TDI/Modula-2, Ver. 3.02a/4.00a    ");
    InitIText (InfoReqText[7], 7, 86, ADR (InfoReqText[8]),
               "  Thanks to Doug McIntyre for ideas.  ");
    InitIText (InfoReqText[8], 7, 99, ADR (InfoReqText[9]),
               "  Special thanks to Tamara, my wife, ");
    InitIText (InfoReqText[9], 7, 108, NULL,
               "  for her understanding and patience. ");
  END SetUpRequesterText;

(* +++++++++++++++++++++++++++++ *)
PROCEDURE InitTilesInfo ();
  BEGIN
    (* Initialize the Gadget that goes with the requester *)
    SetUpGadget ();
    (* Initialize text for the requester *)
    SetUpRequesterText ();
    (* Initialize the requester *)
    SetUpRequester ();
  END InitTilesInfo;

BEGIN
  NULL := ADDRESS (0);
END TilesInfo.


