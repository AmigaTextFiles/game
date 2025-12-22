IMPLEMENTATION MODULE PointerSprites;

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Chks:=TRUE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)

(*$ LongAlign:=TRUE StackParms:=TRUE CStrings:=TRUE LargeVars:=FALSE *)
(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=TRUE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=TRUE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

FROM SYSTEM IMPORT
  ADDRESS,ADR,ASSEMBLE;
FROM IntuitionD IMPORT
  WindowPtr;
FROM IntuitionL IMPORT
  SetPointer,ClearPointer;
FROM QuickIntuition IMPORT
  ChipPicture;
(*$IF Test *)
  FROM W IMPORT
    WRITELN, WRITE, CONCAT, s, l, lf, c, READs;
(*$ENDIF *)

PROCEDURE S01; (*$ EntryExitCode:=FALSE*)
BEGIN
  ASSEMBLE(DC.W 
    0,0,
    $0FC3,$0000,
    $3FF3,$0000,
    $30C3,$0000,
    $0000,$3C03,
    $0000,$3FC3,
    $0000,$03C3,
    $C033,$C033,
    $FFC0,$FFC0,
    $3F03,$3F03,
    1,0, 1,0, 1,0, 1,0, 1,0, 1,0, 1,0,
    0,0 END);
END S01;

PROCEDURE S02; (*$ EntryExitCode:=FALSE *)
BEGIN
  ASSEMBLE(DC.W 0,0,
         $FFFF,0,
         $8181,0,
         $87E1,0,
         $9FF9,0,
         $FFFF,6,
         $83C1,0,
         $FFFF,0,
         $FFFF,0,
         $FFFF,24,
         $FFFF,0,
         $FFFF,0,
         $FFFF,0,
         $FFFF,0,
         $FF5F,0,
         $FFFF,0,
         $FFFF,0,
         0,0 END);
END S02;

PROCEDURE S03; (*$ EntryExitCode:=FALSE *)
BEGIN
    (* gribe 16x20 sh *)
  ASSEMBLE(DC.W 0,0,
$0000,$0380,$0380,$0C60,$0CE0,$3310,$3F70,$4088,
$07B8,$7844,$79D8,$8624,$FEFC,$0102,$CF7C,$3082,
$07FC,$C802,$03FC,$0402,$03FE,$6401,$63FF,$9C00,
$BFFF,$4000,$5FFF,$A000,$1FFF,$6000,$07DF,$1820,
$000F,$07D0,$0007,$0008,$0003,$0004,$0001,$0002,
         0,0 END);
END S03;

PROCEDURE S04; (*$ EntryExitCode:=FALSE *)
BEGIN
    (* grebet 16x20 sho *)
  ASSEMBLE(DC.W 0,0,
        $0000,$0160,
        $0160,$0690,
        $03B0,$0C48,
        $0DD8,$1224,
        $1EEC,$2112,
        $3F7C,$4082,
        $37BE,$C841,
        $93FE,$6C01,
        $A9FF,$5E00,
        $B5FF,$4E00,
        $71FF,$0E00,
        $3FFF,$4000,
        $1FFF,$2000,
        $0FFF,$3000,
        $03FF,$1C00,
        $1507,$3FE8,
        $0A03,$3F84,
        $1501,$3F82,
        $0000,$7FC0,
        $0000,$7FC0,        
         0,0 END);
END S04;

PROCEDURE S05; (*$ EntryExitCode:=FALSE *)
BEGIN
    (* sove 16x25 sh *)
  ASSEMBLE(DC.W 0,0,
$003F,$0000,$0002,$003D,$0004,$0002,$0008,$0004,
$0010,$0008,$003F,$0000,$0000,$003F,$0000,$0000,
$0000,$0000,$01F8,$0000,$0010,$01E8,$0020,$0010,
$0040,$0020,$0080,$0040,$01F8,$0000,$0000,$01F8,
$0000,$0000,$FC00,$0000,$0800,$F400,$1000,$0800,
$2000,$1000,$4000,$2000,$FC00,$0000,$0000,$FC00,
$0000,$0000,
         0,0 END);
END S05;

PROCEDURE S06; (*$ EntryExitCode:=FALSE *)
BEGIN
    (* tale 16x17 sh *)
  ASSEMBLE(DC.W 0,0,
$0000,$0FF0,$0FF0,$300C,$3FFC,$4002,$7FFE,$8001,
$7FFE,$8001,$7FFE,$8001,$7FFE,$8001,$7FFE,$8001,
$7FFE,$8001,$3FFC,$4002,$0FF0,$300C,$0600,$09F0,
$0600,$0900,$0C00,$1200,$0800,$1400,$1000,$2800,
$0000,$7000,
         0,0 END);
END S06;

CONST MaxSpr=64;
VAR
  sSpr:ARRAY[1..MaxSpr] OF RECORD
         psSi    : ADDRESS;
         iXs,iYs : INTEGER;
         iXo,iYo : INTEGER;
       END;
  cOldPNr,O2,O3,O4,cCPNr:INTEGER;

PROCEDURE SetPtr(pw:WindowPtr; iNr:INTEGER);
BEGIN
  IF (iNr>=-1) & (iNr<=INTEGER(cPNr)) THEN
    IF iNr=-1 THEN (* POP *)
      iNr:=cOldPNr;
      cOldPNr:=O2;
      O2:=O3;
      O3:=O4;
    ELSE (* PUSH *)
      O4:=O3;
      O3:=O2;
      O2:=cOldPNr;
      cOldPNr:=cCPNr;
    END; 
    cCPNr:=iNr;
    IF iNr=0 THEN
      ClearPointer(pw);
    ELSE
      WITH sSpr[iNr] DO
        (* Window, Pointer, Height!!!, Width!!!, XOffset, YOffset *)
        SetPointer(pw,psSi,iYs,iXs,iXo,iYo);
      END;
    END;
  END;
END SetPtr;

PROCEDURE InitPtr(prDt:ADDRESS; iXsz,iYsz,iXof,iYof:INTEGER);
BEGIN
  INC(cPNr);
  WITH sSpr[cPNr] DO
    psSi:=ChipPicture(prDt,4+2*iYsz);
    iXs:=iXsz;
    iYs:=iYsz;
    iXo:=iXof;
    iYo:=iYof;
  END;
END InitPtr;

BEGIN
(*$IF Test *)
  WRITELN(s('PointerSprites.1'));
(*$ENDIF *)
  FOR cPNr:=1 TO MaxSpr DO sSpr[cPNr].psSi:=NIL END;
  cPNr:=0;
  cOldPNr:=0;
  cCPNr:=0;
  InitPtr(ADR(S01),16,16,-7,-7);
  InitPtr(ADR(S02),16,16,-7,-7);
  InitPtr(ADR(S03),16,20,-7,-7);
  InitPtr(ADR(S04),16,20,-7,-7);
  InitPtr(ADR(S05),16,25,-7,-7);
  InitPtr(ADR(S06),16,17,-7,-7);
(*$IF Test *)
  WRITELN(s('PointerSprites.2'));
(*$ENDIF *)
END PointerSprites.
