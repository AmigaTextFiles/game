MODULE PointerSpritesTst; (* 3-94 v1.1 *)

(* shows how to use the module PointerSprites (modifying the mousepointer) *)
(* first the internal predefined Sprites, then a userdefined Sprite *)

FROM SYSTEM IMPORT
  ADR, ASSEMBLE;

FROM DosL IMPORT
  Delay;
FROM IntuitionD IMPORT
  WindowPtr, IDCMPFlagSet, WindowFlags, WindowFlagSet;
FROM IntuitionL IMPORT
  CloseWindow;
FROM QuickIntuition IMPORT
  AddWindow;

FROM PointerSprites IMPORT
  cPNr, InitPtr, SetPtr;

VAR
  wp:WindowPtr;

PROCEDURE Internals;
VAR
  n:INTEGER;
BEGIN
      (* Show Internals (in PointerSprites) *)
  FOR n:=1 TO cPNr DO
    SetPtr(wp,n);
    Delay(50);
  END;
      (* show last-used pointer *)
  SetPtr(wp,-1);
  Delay(50);
      (* restore to standard pointer *)
  SetPtr(wp,0);
  Delay(50);
END Internals;

PROCEDURE SprData; (*$ EntryExitCode:=FALSE *)
BEGIN
      (* talk 16x17 sh *)
  ASSEMBLE(DC.W 0,0,
$0000,$0FF0,$0FF0,$300C,$3FFC,$4002,$7FFE,$8001,
$7FFE,$8001,$7FFE,$8001,$7FFE,$8001,$7FFE,$8001,
$7FFE,$8001,$3FFC,$4002,$0FF0,$300C,$0600,$09F0,
$0600,$0900,$0C00,$1200,$0800,$1400,$1000,$2800,
$0000,$7000,
         0,0 END);
END SprData;

PROCEDURE Custom;
VAR
  OwnPtrNr:INTEGER;
BEGIN
      (* Initiate to width=16,heigh=17,xOffset=-7,yOffset=-7 *)
  InitPtr(ADR(SprData),16,17,-7,-7);
      (* Remember its number (max is 64 total) *)
  OwnPtrNr:=cPNr;
      (* Show *)
  SetPtr(wp,OwnPtrNr);
  Delay(50);
      (* restore to standard pointer *)
  SetPtr(wp,0);
END Custom;

BEGIN
  AddWindow(wp,ADR('PointerSprites TEST'),0,0,200,120,0,1,IDCMPFlagSet{},
               WindowFlagSet{windowDrag,windowDepth},NIL,NIL,NIL,10,22,-1,-1);
    Internals;
    Custom;
    Delay(100);
  CloseWindow(wp);
END PointerSpritesTst.
