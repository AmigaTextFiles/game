MODULE MineSweeper;

(*
   History:


   v2.7  8 March 1994
   ------------------
   Fixed the bugs introduced in 2.6 :-)
    * Mines can now be marked down the left column
    * MututalExclude code in Static/Mobile sub menus fixed
    * Documentation now up-to-date.
    * Coloured numbers now working correctly (3.0 only function)

   v2.6  8 February 1994
   ---------------------
   Minor Bug Fix, option change.
   Releasing RMB, in 'mark guess' mode over uncovered square, caused
   garbage squares down left edge. (Ingimar Robertsson)
   Made 'safe' behavior of guessed squares optional. (Ingimar Robertsson)
   (Hopefully) Fixed bugs with colours not being freed on exit.


   v2.5 13 December 1993
   ---------------------
   This is the first version of the source I am releasing for MineSweeper.

   I don't really recommend anyone try use more than snippets of this.
   I feel safe you won't, as you would have to port it first ;-)
   
   Any comments you find in the code are likely to have been added just
   prior to this release, and are likely to be minimal.
   
   I don't want any mail regarding any of this code!
   
   Bear in mind that much of the most messy bits of code could be
   vastly improved if I removed the requirement for compatability
   with 1.3, but at this point it's not worth it.
   
   13 December 1993
   John Matthews
   tribble@gphs.vuw.ac.nz

*)

IMPORT Intuition;
IMPORT FastRandom;
IMPORT Ports;
IMPORT Text;
IMPORT Pens;
IMPORT Rasters;
IMPORT Interrupts;
IMPORT EasyText;
IMPORT InputEvents;
IMPORT Storage;
IMPORT Graphics;
IMPORT Blitter;
IMPORT Memory;
IMPORT BlitHardware;
IMPORT Views;
IMPORT EasyTimer;
IMPORT Tasks;
IMPORT TaskUtils;
IMPORT DOS;
IMPORT DOSProcess;
IMPORT EasyMenus;
IMPORT ImageTools;
IMPORT Pointer;
IMPORT RunTime;
IMPORT ExecBase;
IMPORT Console;
IMPORT LinkedObjects;
IMPORT Utility;
FROM SYSTEM IMPORT
	ADR, BYTE, ADDRESS, SHIFT, SETREG, REGISTER, STRPTR, LONG, CODE;


FROM ChipData IMPORT
	dataPtr;

CONST
	ColoursID = 0636F6C73H;

TYPE
	ColourNames = (* Attempted colours under V39 *)
					  (* The actual values are linked in, but are just 96bit primaries *)
	(	cnNull,
		cnWhite,
		cnBlue,
		cnRed,
		cnGreen,
		cnYellow,
		cnViolet,
		cnPaleBlue,
		cnBlack
	);
	ColourNameSet = SET OF ColourNames;
	AColour =
	RECORD
		acR, acG, acB : LONGCARD;
		(* Ala 3.0, FFFFFFFFH represents full strength component *)
	END;
	ColourArrayPtr = POINTER TO ColourArray;
	ColourArray = ARRAY ColourNames OF AColour;
	ColourInfoRecPtr = POINTER TO ColourInfoRec;
	ColourInfoRec =
	RECORD
		id : LONGCARD;  (* This is just for linking purposes, my compiler is very old *)
		cols : ColourArrayPtr;
	END;


TYPE
	SkillLevel =
	(	Beginner,
		Intermediate,
		Expert,
		Custom
	);
	MenuVals =
	(	mNewGame,
		mBeginner,
		mIntermediate,
		mExpert,
		mCustom,
		mQuestions,
		mCursor,
		mSafe,
		mScores,
		mAbout,
		mShrink,
		mQuit);

	HA = (* for overloaded display/input window *)
	(	modeAbout,
		modeScores,
		modeGetName,
		modeGetCustom
	);

CONST
	HighScoreVersion = 3; (* For the highscore file *)
	strID = 30;
   InitLevel = Intermediate; (* Default if no highscore file *)

	(* Some string constants, let's keep them together *)
	Version = "$VER: MineSweeper 2.7 (8.3.94)";
	TaskName = "Sweep Seconds";
	GameText = "Game";
	GameTextLen = 4;
	CompleteText = "Completion";
	CompleteTextLen = 10;
	MineSweeperName = "MineSweeper";
	MaxStringLength = 30;
	MineScores = "s:MineSweeper.highscores";
   IntermediateString = "Intermediate";
   BeginnerString = "Beginner";
   ExpertString = "Expert";
   CustomString = "Custom";
	SquareFontName = "Courier.font";
	SquareFontSize = 13;

	MinFieldWidth = 8;  (* Arbitrary *)
	MinFieldHeight = 8;

	MaxFieldWidth = 32; (* NOT Arbitrary, 32bits per register! *)
	MaxFieldHeight = 32;

	MinMines = 1;
	MaxMines = 999;

	SquareWidth = 16;   (* blitting constants *)
	SquareWidth3 = SquareWidth * 3;

	TopWindowArea = 32;

	NewGameID = 101; (* Gadget ID, not really used *)

	UnknownImage = 0; (* Image numbers, images are linked in *)
	BlankImage = 1;
	WonderImage = 2;
	GuessImage = 3;
	MineImage = 4;
	FoundMineImage = 5;
	BadGuessImage = 6;
	SureImage = 7;
	SmileyImage = 16;
	AstonishedImage = 17;
	UnhappyImage = 18;
	SunGlassesImage = 19;
	FirstImage = 0;
	LastImage = 7;  (* Keep lower res images after 1:1 ones *)
	FadePat = 20;
	DigitOffset = 21; (* Numbers as images faster/smoother/less flicker than Text() *)
	OneSecond = 1;
	NoReStart = FALSE;
	DoReStart = TRUE;

	MaxStackDepth = 256; (* Should be enough with Queue functions. Stack may need more *)

	CopyAtoD = Blitter.StraightCopy;

	NormalIDCMPs =
       Intuition.IDCMPFlagSet{Intuition.GadgetDown,Intuition.GadgetUp,
                              Intuition.MouseMove, Intuition.MenuPick,
                              Intuition.CloseWindowFlag, Intuition.MouseButtons,
                              Intuition.NewSize, Intuition.RefreshWindow,
                              Intuition.RawKey
                             };
	WaitingIDCMPs =
       Intuition.IDCMPFlagSet{Intuition.GadgetUp,
                              Intuition.CloseWindowFlag, Intuition.MenuPick,
                              Intuition.NewSize, Intuition.RefreshWindow,
                              Intuition.RawKey
                             };

TYPE
	MovingStateType =
	(	NoMove,
		NormalMove,
		SafeMove,
		MineMove
	);
	MovingStateSet = SET OF MovingStateType;

	CompleteMethodType =
	(	AllMinesFound,
		AllNonMinesFound,
		AllSquaresFound, (* Both   *)
		EitherCompletion (* Either *)
	);
	FieldType =
	(	fMines,
		fCovered,
		fGuessed,
		fWondered
	);

	MineFieldRow =
	RECORD
		Mines,
		Covered,
		Guessed,
		Wondered : LONGBITSET;
	END;
	SquareState = (UnknownState, BlankState, WonderState, GuessState, MineState, FoundMineState, BadGuessState);
	SquarePtr = POINTER TO SquareRecord;
	SquareRecord =
	RECORD
	  CASE : BOOLEAN OF
	    FALSE : l : LONGCARD
	  | TRUE  : xv,yv : INTEGER
	  END
	END;
	Score =
	RECORD
	  NameLength : BYTE;
	  Pad : BYTE;
	  Seconds : CARDINAL;
	  Name : STRPTR;
	END;
	HighScoreRecordPtr = POINTER TO HighScoreRecord;
	HighScoreRecord =
	RECORD
	  InitX, InitY : INTEGER;
	  DefLevel : SkillLevel;
	  DefQuestions : BOOLEAN;
	  scores : ARRAY SkillLevel OF Score;
	END;
        FullStringGadPtr = POINTER TO FullStringGad;
        FullStringGad =
        RECORD
          Gad : Intuition.Gadget;
          SI : Intuition.StringInfo;
          se : Intuition.StringExtend;
          borders : ARRAY [0..1] OF Intuition.Border;
          slines : ARRAY [0..9] OF LONGCARD;
          fsBuffer, fsUndoBuffer : ARRAY [0..MaxStringLength] OF CHAR;
        END;
	SmallString = ARRAY [0..7] OF CHAR;
	CustomRec =
	RECORD
	  version : CARDINAL;
	  Width,Height,Mines : INTEGER;
	END;

VAR
	FieldWindow : Intuition.WindowPtr;
	NewGameGad : Intuition.GadgetPtr;
	ClipStore : ADDRESS;
	FieldBM : Graphics.BitMapPtr;
	ClipRPort,
	FieldRPort : Rasters.RastPortPtr;
	MainTask, TimerTask : Tasks.TaskPtr;
	MainProcess : DOSProcess.ProcessPtr;
	OLDprWindow : ADDRESS;
	SquareFont : Text.TextFontPtr;
	SquareFontAttr : Text.TextAttr;
	SquareFontAttrPtr : Text.TextAttrPtr;
	menu : Intuition.MenuPtr;
	HighScores : HighScoreRecordPtr;
	EntryGad : FullStringGadPtr;
	SquareImages : ARRAY [FirstImage..LastImage] OF Intuition.ImagePtr;
	CoveredRow : LONGBITSET;
	FadePattern : ADDRESS;
	CT : ADDRESS;
	FaceImage : Intuition.ImagePtr;

	FieldRows : ARRAY [0..MaxFieldHeight - 1] OF MineFieldRow;
	RealStackBuffer : ARRAY [0..MaxStackDepth - 1] OF SquareRecord;

  (* The comment identifiers Stack and Queue control how
     MineSweeper looks around a square with no mines around it.
     Queues are fastest, result in less depth, and a direct ripple
     outwards.
     Stacks look more interesting ;-)
   *)

(*Stack+
	StackBuffer : SquarePtr;
	Stack : SquarePtr;
*Stack-*)

(*Queue+*)
	StackBuffer : POINTER TO ARRAY [0..MaxStackDepth - 1] OF SquareRecord;
	StackIn, StackOut : CARDINAL;
(*Queue-*)
	
	customrec : CustomRec;
	
	FieldWidth, FieldHeight, NumMines, MinesThisLevel, LastFieldWidth,
	LastFieldHeight, LeftFieldBorder, TopFieldBorder, TopWindowBorder,
	RightFieldBorder, FillParam : INTEGER;
	FieldWindowWidth, FieldWindowHeight, RightWindowBorder, BottomWindowBorder,
	LeftTextBorder, RightTextBorder, TopTextBorder, TextWidth, TextHeight,
	LeftSquareText, TopSquareText, SquareHeight, SquareHeight3, LastSquareCount,
	GuessedMines, GuessedRightMines : INTEGER;
	QuitNow, WaitingForNew, V36Colours,
	TimerError, FirstHit, TimerIsGoing, Restarting,
	V36, Questions, Laced, Shrunk, WindowSized,
	FromMouse, MovingAllowed, SafeIfMarked : BOOLEAN;
	CompleteMethod : CompleteMethodType;
	Lastx, Lasty, Lastxp, Lastyp : INTEGER;
	ClipBM : Graphics.BitMap;
	MovingState, LastState : MovingStateType;
	Pen1,Pen2 : CARDINAL;
	ClipTempRas : Rasters.TmpRas;
	TimerAckBit, CountBit, StartBit, StopBit, WindowBit : Tasks.SIGNAL;
	WaitBits, TimerAcks : Tasks.SignalSet;
	NonMinesCovered,Seconds, NewHigh : CARDINAL;
	Level : SkillLevel;
	SmileX, SmileY : CARDINAL;
	ObtainedPens : ColourNameSet;
	ColourPens : ARRAY ColourNames OF CARDINAL;
	
	ChunkyBuf : ARRAY [0..31] OF SquareState;

(*StackCheck+
	StackDepth, StackDepthReached : CARDINAL;
*StackCheck-*)



PROCEDURE FlashDisplay(num : CARDINAL);
BEGIN
  WHILE num > 0 DO
    DEC(num);
    Views.WaitTOF;
    Blitter.ClipBlit(
       FieldRPort,LeftFieldBorder,TopFieldBorder,
       FieldRPort,LeftFieldBorder,TopFieldBorder,
       FieldWindowWidth, FieldWindowHeight,
       BYTE(48)
    );
    Views.WaitTOF;
  END;
END FlashDisplay;

PROCEDURE TestGameOver(); FORWARD;

PROCEDURE RefreshDisplay(refresh : BOOLEAN); FORWARD;

PROCEDURE DoFill(rp : Rasters.RastPortPtr; pt : ADDRESS; ph : INTEGER; pen,l,t,r,b : CARDINAL);
BEGIN
  IF RunTime.ExecVersion < 39 THEN
    Pens.SetDrMd(rp,Rasters.Jam2);
    Pens.SetAPen(rp,pen);
    Pens.SetBPen(rp,0);
  ELSE
    Pens.SetABPenDrMd(rp,pen,0,Rasters.Jam2)
  END;
  Pens.SetAfPat(rp,pt,ph);
  Blitter.BltPattern(rp,NIL,l,t,r,b,2);
END DoFill;


(*$LONG_ADDR+*)
PROCEDURE ConvNum(VAR str : ARRAY OF CHAR; v : INTEGER);
VAR
	sp : POINTER TO CHAR;
	t : INTEGER;
	n : BOOLEAN;

  PROCEDURE AddDigit(d : INTEGER);
  BEGIN
    sp^ := CHR(ORD('0') + d);;
    INC(sp);
  END AddDigit;
  

BEGIN
  sp := ADR(str);
  n := v < 0;
  v := ABS(v);
  t := v DIV 1000;
  DEC(v,t * 1000);
  IF n THEN
    sp^ := '-';
    INC(sp);
  ELSE
    AddDigit(t);
  END;
  t := v DIV 100;
  DEC(v,t * 100);
  AddDigit(t);
  t := v DIV 10;
  DEC(v,t * 10);
  AddDigit(t);
  AddDigit(v);
  sp^ := 0C
END ConvNum;
(*$LONG_ADDR-*)

PROCEDURE WriteNum(v : INTEGER; x,y : CARDINAL);
VAR
	t : INTEGER;
	n : BOOLEAN;

  PROCEDURE AddDigit(d : INTEGER);
  BEGIN
    Intuition.DrawImage(FieldRPort,dataPtr^.Images[DigitOffset + d],x,y);
    INC(x,10);
  END AddDigit;
  

BEGIN
  n := v < 0;
  v := ABS(v);
  t := v DIV 1000;
  DEC(v,t * 1000);
  IF n THEN
    t := 10; (* negative digit *)
  END;
  AddDigit(t);
  t := v DIV 100;
  DEC(v,t * 100);
  AddDigit(t);
  t := v DIV 10;
  DEC(v,t * 10);
  AddDigit(t);
  AddDigit(v);
END WriteNum;

PROCEDURE SetSize(l : SkillLevel);
BEGIN
  Level := l;
  CASE l OF
     Beginner :
       FieldWidth := 8;
       FieldHeight := 8;
       MinesThisLevel := 10;
   | Intermediate :
       FieldWidth := 16;
       FieldHeight := 16;
       MinesThisLevel := 40;
   | Expert :
       FieldWidth := 32;
       FieldHeight := 16;
       MinesThisLevel := 99;
   | Custom :
       WITH customrec DO
         FieldWidth := Width;
         FieldHeight := Height;
         MinesThisLevel := Mines;
       END; 
  END
END SetSize;


PROCEDURE UpdateMineCountDisplay();
VAR
	Unfound : INTEGER;
	str : SmallString;
BEGIN
  Unfound := NumMines - GuessedMines;
  WriteNum(Unfound,LeftTextBorder, TopTextBorder);
END UpdateMineCountDisplay;

PROCEDURE UpdateTime();
VAR
	str : SmallString;
BEGIN
  WriteNum(Seconds,RightTextBorder, TopTextBorder);
END UpdateTime;

PROCEDURE TimerProc();
VAR
	WaitSigs, GotSigs : Tasks.SignalSet;
	Counting : BOOLEAN;

  PROCEDURE TimerExit();
  BEGIN
    Interrupts.Forbid;
    TimerIsGoing := FALSE;
    IF StartBit # Tasks.NoSignals THEN
      Tasks.FreeSignal(StartBit)
    END;
    IF StopBit # Tasks.NoSignals THEN
      Tasks.FreeSignal(StopBit)
    END;
    EasyTimer.DeleteTimer;
    Tasks.Signal(MainTask,TimerAcks);
    TaskUtils.DeleteTask(TimerTask);
  END TimerExit;
  

BEGIN
  Counting := FALSE;
  StartBit := Tasks.AllocSignal(Tasks.AnySignal);
  StopBit := Tasks.AllocSignal(Tasks.AnySignal);
  IF (StartBit = Tasks.NoSignals) OR (StopBit = Tasks.NoSignals)
    OR ~EasyTimer.CreateTimer() THEN
    TimerError := TRUE;
    TimerExit;
  END;
  Tasks.Signal(MainTask,TimerAcks);
  TimerIsGoing := TRUE;
  WaitSigs := Tasks.SignalSet{CARDINAL(EasyTimer.TimerBit),CARDINAL(StartBit),CARDINAL(StopBit)};
  LOOP
    GotSigs := Tasks.Wait(WaitSigs);
    IF CARDINAL(StartBit) IN GotSigs THEN
      EasyTimer.SendTimeDelay(OneSecond);
      Counting := TRUE;
      Tasks.Signal(MainTask,TimerAcks);
    END;
    IF CARDINAL(EasyTimer.TimerBit) IN GotSigs THEN
      EasyTimer.TimerAck;
      IF Counting THEN
        EasyTimer.SendTimeDelay(OneSecond);
        IF (Seconds < 9999) THEN
          INC(Seconds)
        END;
        Tasks.Signal(MainTask,Tasks.SignalSet{CARDINAL(CountBit)});
      END;
    END;
    IF CARDINAL(StopBit) IN GotSigs THEN
      Counting := FALSE;
      IF QuitNow THEN
        TimerExit;
      ELSE
        Tasks.Signal(MainTask,TimerAcks);
      END
    END;
  END
END TimerProc;

PROCEDURE StartTimer();
VAR
	sigs : Tasks.SignalSet;
BEGIN
  Tasks.Signal(TimerTask,Tasks.SignalSet{CARDINAL(StartBit)});
  sigs := Tasks.Wait(TimerAcks);
  UpdateTime;
END StartTimer;

PROCEDURE StopTimer();
VAR
	sigs : Tasks.SignalSet;
BEGIN
  IF TimerIsGoing THEN
    Tasks.Signal(TimerTask,Tasks.SignalSet{CARDINAL(StopBit)});
    sigs := Tasks.Wait(TimerAcks);
  END;
END StopTimer;

PROCEDURE EndGame(StartNew : BOOLEAN);
BEGIN
  StopTimer;
  IF ~StartNew THEN
    Intuition.ModifyIDCMP(FieldWindow,WaitingIDCMPs);
    FieldWindow^.Flags :=
         FieldWindow^.Flags
       - Intuition.WindowFlagSet{Intuition.RMBTrap,Intuition.ReportMouseFlag};
    WaitingForNew := TRUE;
    MovingState := NoMove;
  END;
  RETURN
END EndGame;

PROCEDURE GetPens(cm : Views.ColorMapPtr);
VAR
	tags : ARRAY [0..1] OF Utility.TagItem;
	res : LONGINT;
	cir : ColourInfoRecPtr;
	i : ColourNames;
BEGIN
  IF ObtainedPens # ColourNameSet{} THEN
    RETURN
  END;
  tags[0].tiTag := Pens.OBP_Precision;
  tags[0].tiData := Pens.Precision_Image;
  tags[1].tiTag := Utility.TAGDone;
  cir := LinkedObjects.FindObject(ColoursID);
  IF (RunTime.ExecVersion < 39) OR (cir = NIL) THEN
    FOR i := MIN(ColourNames) TO MAX(ColourNames) DO
      ColourPens[i] := Pen2;
    END
  ELSE
    cm := FieldWindow^.WScreen^.VPort.ColorMap;
    i := MIN(ColourNames);
    LOOP
      INC(i);
      WITH cir^.cols^[i] DO
        res := Pens.ObtainBestPen(cm,acR,acG,acB,ADR(tags));
        IF res >= 0 THEN
          ColourPens[i] := CARDINAL(res);
          INCL(ObtainedPens,i);
          
        END;
      END;
      IF i = MAX(ColourNames) THEN
        EXIT
      END;
    END
  END;
END GetPens;


PROCEDURE FindColourScheme;
VAR
  CM : Views.ColorMapPtr;

  PROCEDURE Intensity(Entry : LONGINT) : INTEGER;
  VAR
    temp, result, i : INTEGER;
  BEGIN
    result := 1;
    temp := Views.GetRGB4(CM,Entry);
    FOR i := 0 TO 2 DO
      result := result * INTEGER(BITSET(temp) * BITSET{0..3});
      temp := SHIFT(temp,-4);
    END;
    RETURN result
  END Intensity;
  
VAR
  dummy : LONGCARD;
  i : CARDINAL;
BEGIN
  CM := FieldWindow^.WScreen^.VPort.ColorMap;
  GetPens(CM);
  V36Colours := (Intensity(2) > Intensity(1));
  IF V36Colours THEN
    Pen1 := 1;
    Pen2 := 2;
  ELSE
    i := 0;
    WHILE i < CARDINAL(dataPtr^.NumImages) DO
      ImageTools.ReversePlanes(dataPtr^.Images[i]);
      INC(i)
    END;
    Pen2 := 1;
    Pen1 := 2;
  END;
END FindColourScheme;


PROCEDURE InitClip(d:CARDINAL) : BOOLEAN;
VAR
	rs,frs : LONGCARD;
	w,h : CARDINAL;
BEGIN
  w := SquareWidth3;
  h := SquareHeight3;
  rs := Graphics.RASSIZE(w,h);
  frs := rs * LONGCARD(d);
  ClipStore := Storage.TrackAllocMem(frs,Memory.MemReqSet{Memory.MemChip});
  IF ClipStore = NIL THEN RETURN FALSE END;
  Storage.ALLOCATE(ClipRPort,SIZE(ClipRPort^));
  IF ClipRPort = NIL THEN RETURN FALSE END;
  Rasters.InitRastPort(ClipRPort);
  ClipRPort^.BitMap := ADR(ClipBM);
  Rasters.InitTmpRas(ADR(ClipTempRas),Storage.TrackAllocMem(frs,Memory.MemReqSet{Memory.MemChip}),frs);
  ClipRPort^.TmpRas := ADR(ClipTempRas);
  frs := LONGCARD(ClipStore);
  Graphics.InitBitMap(ADR(ClipBM),d,w,h);
  WITH ClipBM DO
    w := 0;
    WHILE w < d DO
      Planes[w] := ADDRESS(frs);
      INC(frs,rs);
      INC(w);
    END
  END;
END InitClip;





PROCEDURE PushStack(xi,yi : INTEGER);
BEGIN
  IF (CARDINAL(xi) < CARDINAL(FieldWidth)) & (CARDINAL(yi) < CARDINAL(FieldHeight)) THEN
    WITH FieldRows[yi] DO
      IF (CARDINAL(xi) IN Covered) & ~(CARDINAL(xi) IN Guessed) THEN
        EXCL(Covered,CARDINAL(xi));
(*Queue+*)
        WITH StackBuffer^[StackIn] DO
          xv := xi;
          yv := yi;
        END;
        StackIn := (StackIn + 1) MOD MaxStackDepth;
(*Queue-*)
(*Stack+
        Stack^.l := LONG(xi,yi);
        INC(Stack,4);
*Stack-*)
(*StackCheck+
        INC(StackDepth);
        IF StackDepth >= MaxStackDepth THEN
          TermOut.WriteString("Stack Depth Exceeded\n");
        END;
        IF StackDepth >= StackDepthReached THEN
          StackDepthReached := StackDepth
        END;
*StackCheck-*)
      END;
    END
  END
END PushStack;

(***LookAsm+*)
(*$LONG_ADDR+*)
PROCEDURE LookAround(xi,yi : INTEGER);
BEGIN
(*Queue+*)
	SETREG(0,yi);
	SETREG(1,xi);
	SETREG(2,FieldWidth);
	SETREG(3,FieldHeight);
	SETREG(4,MaxStackDepth);
	SETREG(8,ADR(FieldRows));
	SETREG(9,StackBuffer);
	SETREG(10,ADR(StackIn));
(*     1 0000:                          ;d0 - y*)
(*     2 0000:                          ;d1 - x*)
(*     3 0000:                          ;d2 - FieldWidth*)
(*     4 0000:                          ;d3 - FieldHeight*)
(*     5 0000:                          ;d4 - MaxStackDepth*)
(*     6 0000:                          ;a0 - FieldRows*)
(*     7 0000:                          ;a1 - Stack*)
(*     8 0000:                          ;a2 - ADR(StackIn)*)
(*     9 0000:*)  CODE(05341H);(*                    subq.w #1,d1	; start left*)
(*    10 0002:*)  CODE(05340H);(*                    subq.w #1,d0	; top*)
(*    11 0004:*)  CODE(03a00H);(*                    move.w d0,d5	; initial offset into FieldRows*)
(*    12 0006:*)  CODE(0e945H);(*                    asl.w #4,d5		; 16 bytes per block *)
(*    13 0008:*)  CODE(0d0c5H);(*                    adda.w d5,a0	; add it IN*)
(*    14 000a:*)  CODE(0b043H);(*                    cmp.w d3,d0		; neg y ?*)
(*    15 000c:*)  CODE(06438H);(*                    bcc row2			; skip first row*)
(*    16 000e:*)  CODE(02a28H,00008H);(*             move.l 8(a0),d5; Guessed*)
(*    17 0012:*)  CODE(04685H);(*                    NOT.l d5			; ~Guessed*)
(*    18 0014:*)  CODE(02c28H,00004H);(*             move.l 4(a0),d6; Covered for this row*)
(*    19 0018:*)  CODE(0ca86H);(*                    AND.l d6,d5		; only do if covered & ~guessed*)
(*    20 001a:*)  CODE(0b242H);(*                    cmp.w d2,d1		; x neg ?*)
(*    21 001c:*)  CODE(06408H);(*                    bcc c12			; skip col*)
(*    22 001e:*)  CODE(00305H);(*                    btst.l d1,d5	; check square conditions*)
(*    23 0020:*)  CODE(06704H);(*                    beq c12			; failed, skip*)
(*    24 0022:*)  CODE(06100H,00092H);(*             bsr.s nq			; passed, enqueue*)
(*    25 0026:*)  CODE(05241H);(*              c12:  addq.w #1,d1	; next col*)
(*    26 0028:*)  CODE(0b242H);(*                    cmp.w d2,d1*)
(*    27 002a:*)  CODE(06408H);(*                    bcc c13*)
(*    28 002c:*)  CODE(00305H);(*                    btst.l d1,d5*)
(*    29 002e:*)  CODE(06704H);(*                    beq c13*)
(*    30 0030:*)  CODE(06100H,00084H);(*             bsr.s nq*)
(*    31 0034:*)  CODE(05241H);(*              c13:  addq.w #1,d1*)
(*    32 0036:*)  CODE(0b242H);(*                    cmp.w d2,d1*)
(*    33 0038:*)  CODE(06406H);(*                    bcc c1e*)
(*    34 003a:*)  CODE(00305H);(*                    btst.l d1,d5*)
(*    35 003c:*)  CODE(06702H);(*                    beq c1e*)
(*    36 003e:*)  CODE(06176H);(*                    bsr.s nq*)
(*    37 0040:*)  CODE(05541H);(*              c1e:  subq.w #2,d1*)
(*    38 0042:*)  CODE(02146H,00004H);(*             move.l d6,4(a0); save Covered for this row*)
(*    39 0046:*)  CODE(05088H);(*              row2: addq.l #8,a0*)
(*    40 0048:*)  CODE(05088H);(*                    addq.l #8,a0*)
(*    41 004a:*)  CODE(05240H);(*                    addq.w #1,d0*)
(*    42 004c:*)  CODE(0b043H);(*                    cmp.w d3,d0*)
(*    43 004e:*)  CODE(06428H);(*                    bcc row3*)
(*    44 0050:*)  CODE(02a28H,00008H);(*             move.l 8(a0),d5*)
(*    45 0054:*)  CODE(04685H);(*                    NOT.l d5*)
(*    46 0056:*)  CODE(02c28H,00004H);(*             move.l 4(a0),d6*)
(*    47 005a:*)  CODE(0ca86H);(*                    AND.l d6,d5*)
(*    48 005c:*)  CODE(0b242H);(*                    cmp.w d2,d1*)
(*    49 005e:*)  CODE(06406H);(*                    bcc c23*)
(*    50 0060:*)  CODE(00305H);(*                    btst.l d1,d5*)
(*    51 0062:*)  CODE(06702H);(*                    beq c23*)
(*    52 0064:*)  CODE(06150H);(*                    bsr.s nq*)
(*    53 0066:*)  CODE(05441H);(*              c23:  addq.w #2,d1*)
(*    54 0068:*)  CODE(0b242H);(*                    cmp.w d2,d1*)
(*    55 006a:*)  CODE(06406H);(*                    bcc c2e*)
(*    56 006c:*)  CODE(00305H);(*                    btst.l d1,d5*)
(*    57 006e:*)  CODE(06702H);(*                    beq c2e*)
(*    58 0070:*)  CODE(06144H);(*                    bsr.s nq*)
(*    59 0072:*)  CODE(05541H);(*              c2e:  subq.w #2,d1*)
(*    60 0074:*)  CODE(02146H,00004H);(*             move.l d6,4(a0)*)
(*    61 0078:*)  CODE(05240H);(*              row3: addq.w #1,d0*)
(*    62 007a:*)  CODE(0b043H);(*                    cmp.w d3,d0*)
(*    63 007c:*)  CODE(06452H);(*                    bcc fin*)
(*    64 007e:*)  CODE(05088H);(*                    addq.l #8,a0*)
(*    65 0080:*)  CODE(05088H);(*                    addq.l #8,a0*)
(*    66 0082:*)  CODE(02a28H,00008H);(*             move.l 8(a0),d5*)
(*    67 0086:*)  CODE(04685H);(*                    NOT.l d5*)
(*    68 0088:*)  CODE(02c28H,00004H);(*             move.l 4(a0),d6*)
(*    69 008c:*)  CODE(0ca86H);(*                    AND.l d6,d5*)
(*    70 008e:*)  CODE(0b242H);(*                    cmp.w d2,d1*)
(*    71 0090:*)  CODE(06406H);(*                    bcc c32*)
(*    72 0092:*)  CODE(00305H);(*                    btst.l d1,d5*)
(*    73 0094:*)  CODE(06702H);(*                    beq c32*)
(*    74 0096:*)  CODE(0611eH);(*                    bsr.s nq*)
(*    75 0098:*)  CODE(05241H);(*              c32:  addq.w #1,d1*)
(*    76 009a:*)  CODE(0b242H);(*                    cmp.w d2,d1*)
(*    77 009c:*)  CODE(06406H);(*                    bcc c33*)
(*    78 009e:*)  CODE(00305H);(*                    btst.l d1,d5*)
(*    79 00a0:*)  CODE(06702H);(*                    beq c33*)
(*    80 00a2:*)  CODE(06112H);(*                    bsr.s nq*)
(*    81 00a4:*)  CODE(05241H);(*              c33:  addq.w #1,d1*)
(*    82 00a6:*)  CODE(0b242H);(*                    cmp.w d2,d1*)
(*    83 00a8:*)  CODE(06406H);(*                    bcc c3e*)
(*    84 00aa:*)  CODE(00305H);(*                    btst.l d1,d5*)
(*    85 00ac:*)  CODE(06702H);(*                    beq c3e*)
(*    86 00ae:*)  CODE(06106H);(*                    bsr.s nq*)
(*    87 00b0:*)  CODE(02146H,00004H);(*       c3e:  move.l d6,4(a0)*)
(*    88 00b4:*)  CODE(0601aH);(*              		bra.s fin*)
(*    89 00b6:*)  CODE(03e12H);(*              nq:	move.w (a2),d7	; queue index*)
(*    90 00b8:*)  CODE(0e547H);(*              		asl.w #2,d7		; scale for longwords*)
(*    91 00ba:*)  CODE(047f1H,07000H);(*       		lea.l 0(a1,d7.w),a3 ; get pos*)
(*    92 00be:*)  CODE(036c1H);(*              		move.w d1,(a3)+	; save x*)
(*    93 00c0:*)  CODE(03680H);(*              		move.w d0,(a3)		; save y*)
(*    94 00c2:*)  CODE(00386H);(*                    bclr.l d1,d6		; uncover square*)
(*    95 00c4:*)  CODE(05252H);(*              		addq.w #1,(a2)		; inc stack pos*)
(*    96 00c6:*)  CODE(0b852H);(*              		cmp.w (a2),d4		; wrap ?*)
(*    97 00c8:*)  CODE(06702H);(*              		beq.s wrap*)
(*    98 00ca:*)  CODE(04e75H);(*              		rts*)
(*    99 00cc:*)  CODE(04252H);(*              wrap:	clr.w (a2)*)
(*   100 00ce:*)  CODE(04e75H);(*              		rts*)
(*   101 00d0:*)  CODE(04e71H);(*              fin:  nop*)
(*Queue-*)
(*Stack+
	SETREG(0,yi);
	SETREG(1,xi);
	SETREG(2,FieldWidth);
	SETREG(3,FieldHeight);
	SETREG(8,ADR(FieldRows));
	SETREG(10,ADR(Stack));
(*     1 0000:                          ;d0 - y*)
(*     2 0000:                          ;d1 - x*)
(*     3 0000:                          ;d2 - FieldWidth*)
(*     4 0000:                          ;d3 - FieldHeight*)
(*     5 0000:                          ;a0 - FieldRows*)
(*     6 0000:                          ;a1 - Stack*)
(*     7 0000:                          ;a2 - ADR(Stack)*)
(*     8 0000:*)  CODE(02252H);(*                    move.l (a2),a1*)
(*     9 0002:*)  CODE(05341H);(*                    subq.w #1,d1*)
(*    10 0004:*)  CODE(05340H);(*                    subq.w #1,d0*)
(*    11 0006:*)  CODE(03800H);(*                    move.w d0,d4*)
(*    12 0008:*)  CODE(0e944H);(*                    asl.w #4,d4*)
(*    13 000a:*)  CODE(0d0c4H);(*                    adda.w d4,a0*)
(*    14 000c:*)  CODE(0b043H);(*                    cmp.w d3,d0*)
(*    15 000e:*)  CODE(06440H);(*                    bcc row2*)
(*    16 0010:*)  CODE(02a28H,00008H);(*             move.l 8(a0),d5*)
(*    17 0014:*)  CODE(04685H);(*                    NOT.l d5*)
(*    18 0016:*)  CODE(02c28H,00004H);(*             move.l 4(a0),d6*)
(*    19 001a:*)  CODE(0ca86H);(*                    AND.l d6,d5*)
(*    20 001c:*)  CODE(0b242H);(*                    cmp.w d2,d1*)
(*    21 001e:*)  CODE(0640aH);(*                    bcc c12*)
(*    22 0020:*)  CODE(00305H);(*                    btst.l d1,d5*)
(*    23 0022:*)  CODE(06706H);(*                    beq c12*)
(*    24 0024:*)  CODE(032c1H);(*                    move.w d1,(a1)+*)
(*    25 0026:*)  CODE(032c0H);(*                    move.w d0,(a1)+*)
(*    26 0028:*)  CODE(00386H);(*                    bclr.l d1,d6*)
(*    27 002a:*)  CODE(05241H);(*              c12:  addq.w #1,d1*)
(*    28 002c:*)  CODE(0b242H);(*                    cmp.w d2,d1*)
(*    29 002e:*)  CODE(0640aH);(*                    bcc c13*)
(*    30 0030:*)  CODE(00305H);(*                    btst.l d1,d5*)
(*    31 0032:*)  CODE(06706H);(*                    beq c13*)
(*    32 0034:*)  CODE(032c1H);(*                    move.w d1,(a1)+*)
(*    33 0036:*)  CODE(032c0H);(*                    move.w d0,(a1)+*)
(*    34 0038:*)  CODE(00386H);(*                    bclr.l d1,d6*)
(*    35 003a:*)  CODE(05241H);(*              c13:  addq.w #1,d1*)
(*    36 003c:*)  CODE(0b242H);(*                    cmp.w d2,d1*)
(*    37 003e:*)  CODE(0640aH);(*                    bcc c1e*)
(*    38 0040:*)  CODE(00305H);(*                    btst.l d1,d5*)
(*    39 0042:*)  CODE(06706H);(*                    beq c1e*)
(*    40 0044:*)  CODE(032c1H);(*                    move.w d1,(a1)+*)
(*    41 0046:*)  CODE(032c0H);(*                    move.w d0,(a1)+*)
(*    42 0048:*)  CODE(00386H);(*                    bclr.l d1,d6*)
(*    43 004a:*)  CODE(05541H);(*              c1e:  subq.w #2,d1*)
(*    44 004c:*)  CODE(02146H,00004H);(*             move.l d6,4(a0)*)
(*    45 0050:*)  CODE(05088H);(*              row2: addq.l #8,a0*)
(*    46 0052:*)  CODE(05088H);(*                    addq.l #8,a0*)
(*    47 0054:*)  CODE(05240H);(*                    addq.w #1,d0*)
(*    48 0056:*)  CODE(0b043H);(*                    cmp.w d3,d0*)
(*    49 0058:*)  CODE(06430H);(*                    bcc row3*)
(*    50 005a:*)  CODE(02a28H,00008H);(*             move.l 8(a0),d5*)
(*    51 005e:*)  CODE(04685H);(*                    NOT.l d5*)
(*    52 0060:*)  CODE(02c28H,00004H);(*             move.l 4(a0),d6*)
(*    53 0064:*)  CODE(0ca86H);(*                    AND.l d6,d5*)
(*    54 0066:*)  CODE(0b242H);(*                    cmp.w d2,d1*)
(*    55 0068:*)  CODE(0640aH);(*                    bcc c23*)
(*    56 006a:*)  CODE(00305H);(*                    btst.l d1,d5*)
(*    57 006c:*)  CODE(06706H);(*                    beq c23*)
(*    58 006e:*)  CODE(032c1H);(*                    move.w d1,(a1)+*)
(*    59 0070:*)  CODE(032c0H);(*                    move.w d0,(a1)+*)
(*    60 0072:*)  CODE(00386H);(*                    bclr.l d1,d6*)
(*    61 0074:*)  CODE(05441H);(*              c23:  addq.w #2,d1*)
(*    62 0076:*)  CODE(0b242H);(*                    cmp.w d2,d1*)
(*    63 0078:*)  CODE(0640aH);(*                    bcc c2e*)
(*    64 007a:*)  CODE(00305H);(*                    btst.l d1,d5*)
(*    65 007c:*)  CODE(06706H);(*                    beq c2e*)
(*    66 007e:*)  CODE(032c1H);(*                    move.w d1,(a1)+*)
(*    67 0080:*)  CODE(032c0H);(*                    move.w d0,(a1)+*)
(*    68 0082:*)  CODE(00386H);(*                    bclr.l d1,d6*)
(*    69 0084:*)  CODE(05541H);(*              c2e:  subq.w #2,d1*)
(*    70 0086:*)  CODE(02146H,00004H);(*             move.l d6,4(a0)*)
(*    71 008a:*)  CODE(05240H);(*              row3: addq.w #1,d0*)
(*    72 008c:*)  CODE(0b043H);(*                    cmp.w d3,d0*)
(*    73 008e:*)  CODE(06442H);(*                    bcc fin*)
(*    74 0090:*)  CODE(05088H);(*                    addq.l #8,a0*)
(*    75 0092:*)  CODE(05088H);(*                    addq.l #8,a0*)
(*    76 0094:*)  CODE(02a28H,00008H);(*             move.l 8(a0),d5*)
(*    77 0098:*)  CODE(04685H);(*                    NOT.l d5*)
(*    78 009a:*)  CODE(02c28H,00004H);(*             move.l 4(a0),d6*)
(*    79 009e:*)  CODE(0ca86H);(*                    AND.l d6,d5*)
(*    80 00a0:*)  CODE(0b242H);(*                    cmp.w d2,d1*)
(*    81 00a2:*)  CODE(0640aH);(*                    bcc c32*)
(*    82 00a4:*)  CODE(00305H);(*                    btst.l d1,d5*)
(*    83 00a6:*)  CODE(06706H);(*                    beq c32*)
(*    84 00a8:*)  CODE(032c1H);(*                    move.w d1,(a1)+*)
(*    85 00aa:*)  CODE(032c0H);(*                    move.w d0,(a1)+*)
(*    86 00ac:*)  CODE(00386H);(*                    bclr.l d1,d6*)
(*    87 00ae:*)  CODE(05241H);(*              c32:  addq.w #1,d1*)
(*    88 00b0:*)  CODE(0b242H);(*                    cmp.w d2,d1*)
(*    89 00b2:*)  CODE(0640aH);(*                    bcc c33*)
(*    90 00b4:*)  CODE(00305H);(*                    btst.l d1,d5*)
(*    91 00b6:*)  CODE(06706H);(*                    beq c33*)
(*    92 00b8:*)  CODE(032c1H);(*                    move.w d1,(a1)+*)
(*    93 00ba:*)  CODE(032c0H);(*                    move.w d0,(a1)+*)
(*    94 00bc:*)  CODE(00386H);(*                    bclr.l d1,d6*)
(*    95 00be:*)  CODE(05241H);(*              c33:  addq.w #1,d1*)
(*    96 00c0:*)  CODE(0b242H);(*                    cmp.w d2,d1*)
(*    97 00c2:*)  CODE(0640aH);(*                    bcc c3e*)
(*    98 00c4:*)  CODE(00305H);(*                    btst.l d1,d5*)
(*    99 00c6:*)  CODE(06706H);(*                    beq c3e*)
(*   100 00c8:*)  CODE(032c1H);(*                    move.w d1,(a1)+*)
(*   101 00ca:*)  CODE(032c0H);(*                    move.w d0,(a1)+*)
(*   102 00cc:*)  CODE(00386H);(*                    bclr.l d1,d6*)
(*   103 00ce:*)  CODE(02146H,00004H);(*       c3e:  move.l d6,4(a0)*)
(*   104 00d2:*)  CODE(02489H);(*              fin:  move.l a1,(a2)*)
*Stack-*)
END LookAround;
(*$LONG_ADDR=*)
(***LookAsm-*)

(***LookM2+
PROCEDURE LookAround(xi,yi : INTEGER);
BEGIN
  PushStack(xi - 1,yi - 1);
  PushStack(xi + 1,yi - 1);
  PushStack(xi + 1,yi + 1);
  PushStack(xi - 1,yi + 1);

  PushStack(xi - 1,yi);
  PushStack(xi,yi - 1);
  PushStack(xi + 1,yi);
  PushStack(xi,yi + 1);


END LookAround;
*LookM2-*)

PROCEDURE PopStack(VAR x,y : INTEGER) : BOOLEAN;
BEGIN
(*Queue+*)
  IF StackIn = StackOut THEN
    RETURN FALSE
  END;
  WITH StackBuffer^[StackOut] DO
    x := xv;
    y := yv;
  END;
  StackOut := (StackOut + 1) MOD MaxStackDepth;
(*Queue-*)

(*Stack+
  IF Stack = StackBuffer THEN
    RETURN FALSE
  END;
  DEC(Stack,4);
  WITH Stack^ DO
    x := xv;
    y := yv;
  END;
*Stack-*)

(*StackCheck+
  DEC(StackDepth);
*StackCheck-*)

  RETURN TRUE
END PopStack;

PROCEDURE EmptyStack();
BEGIN
(*Queue+*)
  StackIn := 0;
  StackOut := 0;
(*Queue-*)
(*Stack+
  Stack := StackBuffer;
*Stack-*)

(*StackCheck+
    TermOut.WriteString("MAX Stack Depth = ");
    TermOut.WriteCard(StackDepthReached,1);
    TermOut.WriteLn;
    StackDepthReached := 0;
  StackDepth := 0;
*StackCheck-*)
END EmptyStack;


PROCEDURE Transform(VAR x,y : INTEGER) : BOOLEAN;
BEGIN
	DEC(x, LeftFieldBorder);
	IF x < 0 THEN RETURN FALSE END;
	DEC(y,TopFieldBorder);
	IF y < 0 THEN RETURN FALSE END;
	x := x DIV SquareWidth;
	y := y DIV SquareHeight;
   IF (x >= FieldWidth) OR (y >= FieldHeight) THEN
     RETURN FALSE
   END;
	RETURN TRUE
END Transform;

PROCEDURE InitEntryGad() : BOOLEAN;
VAR
	lp : POINTER TO LONGCARD;
	h : CARDINAL;
	strWidth : CARDINAL;

  PROCEDURE addpoint(x,y : INTEGER);
  BEGIN
    lp^ := LONG(x,y);
    INC(lp,4);
  END addpoint;
  
BEGIN
  IF EntryGad = NIL THEN
    strWidth :=  30 * SquareFont^.tfXSize;
    Storage.ALLOCATE(EntryGad,SIZE(EntryGad^));
    IF EntryGad = NIL THEN RETURN FALSE END;
    h := SquareFont^.tfYSize;
    WITH EntryGad^ DO
      lp := ADR(slines[0]);
      addpoint(0,0);
      addpoint(strWidth + 2,0);
      addpoint(strWidth + 2,h + 2);
      addpoint(0,h + 2);
      addpoint(0,0);
      addpoint(0,0);
      addpoint(strWidth + 2,0);
      addpoint(strWidth + 2,h + 2);
      addpoint(0,h + 2);
      addpoint(0,0);
      WITH borders[0] DO
        LeftEdge := -1;
        TopEdge := -1;
        FrontPen := BYTE(Pen1);
        DrawMode := Rasters.Jam1;
        Count := BYTE(5);
        XY := ADR(slines[0]);
        NextBorder := ADR(borders[1]);
      END;
      WITH borders[1] DO
        LeftEdge := -2;
        TopEdge := -2;
        FrontPen := BYTE(Pen2);
        DrawMode := Rasters.Jam1;
        Count := BYTE(5);
        XY := ADR(slines[5]);
      END;
      WITH se DO
        Font := SquareFont;
        Pens[0] := BYTE(1);
        Pens[1] := BYTE(0);
        ActivePens[0] := BYTE(2);
        ActivePens[1] := BYTE(3);
      END;
      WITH SI DO
        Buffer := ADR(fsBuffer);
        UndoBuffer := ADR(fsUndoBuffer);
        MaxChars := MaxStringLength + 1;
        Extension := ADR(se);
      END;
      WITH Gad DO
        TopEdge := - INTEGER(4 * h);
        LeftEdge := 5 * SquareFont^.tfXSize;
        Width := strWidth;
        Height := h;
        Flags := Intuition.GadgetFlagSet{Intuition.GRelBottom, Intuition.GFStringExtend};
        Activation := Intuition.ActivationFlagSet{Intuition.RelVerify, Intuition.StringCenter};
        GadgetType := Intuition.StrGadget;
        GadgetRenderB := ADR(borders[0]);
        GadgetText := NIL;
        SpecialInfoS := ADR(SI);
        GadgetID := strID;
      END;
    END;
  END;
  RETURN TRUE
END InitEntryGad;



PROCEDURE InitFields() : BOOLEAN;
VAR
	sec,mic : LONGCARD;
	i,j : INTEGER;
	x,y : CARDINAL;
BEGIN
  NumMines := MinesThisLevel;
  i := (FieldWidth * FieldHeight);
  IF NumMines > (i - 2) THEN
    NumMines := i - 2; (* Silly Person *)
  END;
  NonMinesCovered := i - NumMines;
  Restarting := TRUE;
  WaitingForNew := FALSE;
  Intuition.CurrentTime(sec,mic);
  sec := LONGCARD(LONGBITSET(sec)/LONGBITSET(mic));
  FastRandom.seed := sec;
  CoveredRow := LONGBITSET{0..FieldWidth - 1};
  FOR i := 0 TO FieldHeight - 1 DO
    WITH FieldRows[i] DO
      Mines := LONGBITSET{};
      Covered := CoveredRow;
      Guessed := LONGBITSET{};
      Wondered := LONGBITSET{};
    END
  END;
  i := 0;
  WHILE i < NumMines DO
    x := FastRandom.Random(FieldWidth);
    y := FastRandom.Random(FieldHeight);
    WITH FieldRows[y] DO
      IF ~(x IN Mines) THEN
        INCL(Mines,x);
        INC(i);
      END;
    END;
  END;
  GuessedMines := 0;
  GuessedRightMines := 0;
  RETURN TRUE
END InitFields;

PROCEDURE ShowSquare(x,y : CARDINAL; state : SquareState);
VAR
	square : Intuition.ImagePtr;
BEGIN
  x := SquareWidth * x + CARDINAL(LeftFieldBorder);
  y := CARDINAL(SquareHeight) * y + CARDINAL(TopFieldBorder);
  Intuition.DrawImage(FieldRPort,SquareImages[ORD(state)],x,y)
END ShowSquare;


PROCEDURE MySizeWindow(tw,th : INTEGER) : BOOLEAN;
VAR
	msg : Intuition.IntuiMessagePtr;
	port : Ports.MsgPortPtr;
	dx,dy : INTEGER;
BEGIN
  WITH FieldWindow^ DO
    IF tw > WScreen^.Width THEN
      RETURN FALSE
    END;
    IF th > WScreen^.Height THEN
      RETURN FALSE
    END;
    port := UserPort;
    dx := tw - Width;
    dy := th - Height;
    IF LeftEdge + tw > WScreen^.Width THEN
      Intuition.MoveWindow(FieldWindow,WScreen^.Width - tw - LeftEdge,0);
    END;
    IF TopEdge + th > WScreen^.Height THEN
      Intuition.MoveWindow(FieldWindow,0,WScreen^.Height - th - TopEdge);
    END;
  END;
  Intuition.SizeWindow(FieldWindow,dx,dy);
  WindowSized := TRUE;
(*
  LOOP
    LOOP
      msg := Ports.GetMsg(port);
      IF msg # NIL THEN EXIT END;
      msg := Ports.WaitPort(port);
    END;
    IF Intuition.RefreshWindow IN msg^.Class THEN
      Intuition.BeginRefresh(FieldWindow);
      Intuition.EndRefresh(FieldWindow, TRUE);
    END;
    IF Intuition.NewSize IN msg^.Class THEN
      EXIT
    END;
    Ports.ReplyMsg(msg);
  END;
  Ports.ReplyMsg(msg);
*)
  RETURN TRUE;
END MySizeWindow;

PROCEDURE MenuCheckedIf(b:BOOLEAN);
BEGIN
  IF b THEN
    INCL(EasyMenus.nextItemFlags,Intuition.Checked)
  ELSE
    EXCL(EasyMenus.nextItemFlags,Intuition.Checked)
  END
END MenuCheckedIf;

PROCEDURE OpenFonts();
VAR
	vp : Views.ViewPtr;
BEGIN
(*
  CountFontAttrPtr := ADR(CountFontAttr);
*)
  WITH SquareFontAttr DO
    taName  := ADR(SquareFontName);
    taYSize := SquareFontSize;
    taStyle := Text.NormalStyle;
    taFlags := Text.FontFlagSet{Text.DiskFont};
    vp := Intuition.ViewAddress();
    IF Views.HiRes IN vp^.Modes THEN
      IF ~(Views.Lace IN vp^.Modes) THEN
        INCL(taFlags,Text.TallDot)
      END
    ELSE
      IF Views.Lace IN vp^.Modes THEN
        INCL(taFlags,Text.LongDot)
      END
    END
  END;

  SquareFontAttrPtr := NIL;
  IF Laced THEN
    SquareFontAttrPtr := ADR(SquareFontAttr);
  END;

  SquareFont := EasyText.EasyOpenFont(SquareFontAttrPtr);
  IF SquareFont = NIL THEN
    SquareFontAttrPtr := NIL;
    SquareFont := EasyText.EasyOpenFont(SquareFontAttrPtr)
  END;
  WITH SquareFont^ DO
    LeftSquareText := LeftFieldBorder + (SquareWidth - INTEGER(tfXSize)) DIV 2;
    TopSquareText := TopFieldBorder + (SquareHeight - INTEGER(tfYSize)) DIV 2;
  END;
END OpenFonts;

PROCEDURE CreateMenus();
BEGIN
  menu := NIL;
(*  IF V36 THEN*)
    EasyMenus.nextTextAttr := ADR(SquareFontAttr);
    EasyMenus.nextItemHeight := SquareFont^.tfYSize + 2;
(*  END;*)

      
  EasyMenus.StartStrip;

  EasyMenus.nextFrontPen := 2;
  EasyMenus.nextBackPen := 1;
  EasyMenus.nextIntuiTopEdge := 0;

  EasyMenus.AddMenu(GameText, Intuition.CheckWidth + (Intuition.CommWidth * 2) + SquareFont^.tfXSize * 12);

  EasyMenus.AddItem("New",'N');

  INCL(EasyMenus.nextItemFlags,Intuition.CheckIt);

  MenuCheckedIf(Level = Beginner);
  EasyMenus.AddItem(BeginnerString,'B');
  EasyMenus.currentItem^.MutualExclude := LONGBITSET{2,3,4};

  MenuCheckedIf(Level = Intermediate);
  EasyMenus.AddItem(IntermediateString,'I');
  EasyMenus.currentItem^.MutualExclude := LONGBITSET{1,3,4};

  MenuCheckedIf(Level = Expert);
  EasyMenus.AddItem(ExpertString,'E');
  EasyMenus.currentItem^.MutualExclude := LONGBITSET{1,2,4};

  MenuCheckedIf(Level = Custom);
  EasyMenus.AddItem(CustomString,'C');
  EasyMenus.currentItem^.MutualExclude := LONGBITSET{1,2,3};

  INCL(EasyMenus.nextItemFlags,Intuition.MenuToggle);

  MenuCheckedIf(Questions);
  EasyMenus.AddItem("Marks (?)",'M');
  
  EasyMenus.nextItemFlags := Intuition.ItemFlagSet{Intuition.ItemText, Intuition.ItemEnabled} + Intuition.HighComp;
  EasyMenus.AddItem("Cursor",0C);
  EasyMenus.nextSubLeftEdge := EasyMenus.nextItemLeftEdge + EasyMenus.nextItemWidth - 20;
  EasyMenus.nextSubHeight := EasyMenus.nextItemHeight;
  EasyMenus.nextSubWidth := SquareFont^.tfXSize * 9;
  EasyMenus.nextSubFlags := Intuition.ItemFlagSet{Intuition.ItemText, Intuition.ItemEnabled, Intuition.CheckIt} + Intuition.HighComp;
  IF MovingAllowed THEN
    INCL(EasyMenus.nextSubFlags,Intuition.Checked)
  ELSE
    EXCL(EasyMenus.nextSubFlags,Intuition.Checked)
  END;
  EasyMenus.AddSub("Mobile",0C);
  EasyMenus.currentSub^.MutualExclude := LONGBITSET{1};
  IF MovingAllowed THEN
    EXCL(EasyMenus.nextSubFlags,Intuition.Checked)
  ELSE
    INCL(EasyMenus.nextSubFlags,Intuition.Checked)
  END;
  EasyMenus.AddSub("Static",0C);
  EasyMenus.currentSub^.MutualExclude := LONGBITSET{0};

  EasyMenus.nextItemFlags := Intuition.ItemFlagSet{Intuition.ItemText, Intuition.ItemEnabled, Intuition.MenuToggle, Intuition.CheckIt} + Intuition.HighComp;
  MenuCheckedIf(SafeIfMarked);
  EasyMenus.AddItem("Safe If Marked",0C);

  EasyMenus.nextItemFlags := Intuition.ItemFlagSet{Intuition.ItemText, Intuition.ItemEnabled} + Intuition.HighComp;
  EasyMenus.AddItem("Best Times",'T');
  EasyMenus.AddItem("About MineSweeper",'?');
  EasyMenus.AddItem("Pause",'P');
  EasyMenus.AddItem("Quit",'Q');

(*  EasyMenus.AddItem("Test",0C);*)

  EasyMenus.AddMenu(CompleteText,Intuition.CheckWidth + (Intuition.CommWidth * 2) + SquareFont^.tfXSize * 12);
  
  EasyMenus.nextItemFlags := Intuition.ItemFlagSet{Intuition.ItemText, Intuition.ItemEnabled, Intuition.CheckIt} + Intuition.HighComp;
  MenuCheckedIf(CompleteMethod = AllMinesFound);
  EasyMenus.AddItem("All Mines Found",0C);
  EasyMenus.currentItem^.MutualExclude := LONGBITSET{1,2,3};
  MenuCheckedIf(CompleteMethod = AllNonMinesFound);
  EasyMenus.AddItem("All Non Mines Found",0C);
  EasyMenus.currentItem^.MutualExclude := LONGBITSET{0,2,3};
  MenuCheckedIf(CompleteMethod = AllSquaresFound);
  EasyMenus.AddItem("Both",0C);
  EasyMenus.currentItem^.MutualExclude := LONGBITSET{0,1,3};
  MenuCheckedIf(CompleteMethod = EitherCompletion);
  EasyMenus.AddItem("Either",0C);
  EasyMenus.currentItem^.MutualExclude := LONGBITSET{0,1,2};
  
  IF ~EasyMenus.stripFailed THEN
    menu := EasyMenus.currentStrip;
  END;
END CreateMenus;

PROCEDURE CreateFieldWindow() : BOOLEAN;
VAR
	nw : Intuition.NewWindowPtr;
	FullWindowWidth, FullWindowHeight, gadpos, TextOffset : INTEGER;
	TooBig, Sized : BOOLEAN;
BEGIN
  Sized := FALSE;
  FieldWindowWidth := SquareWidth * FieldWidth;
  FieldWindowHeight := SquareHeight * FieldHeight;
  RightFieldBorder := LeftFieldBorder + FieldWindowWidth - 1;
  FullWindowWidth := FieldWindowWidth + LeftFieldBorder + RightWindowBorder;
  FullWindowHeight := FieldWindowHeight + TopFieldBorder + BottomWindowBorder;
  IF FieldWindow = NIL THEN
    Storage.ALLOCATE(nw,SIZE(nw^));
    IF nw = NIL THEN RETURN FALSE END;
    WITH nw^ DO
      LeftEdge := HighScores^.InitX;
      TopEdge := HighScores^.InitY;
      Width := FullWindowWidth;
      Height := FullWindowHeight;
      DetailPen := BYTE(2);
      BlockPen := BYTE(1);
      IDCMPFlags := NormalIDCMPs;
      Flags :=
       Intuition.WindowFlagSet{Intuition.WindowDrag,Intuition.WindowDepth,
                               Intuition.WindowClose,Intuition.Activate,
                               Intuition.ReportMouseFlag
                              } + Intuition.SimpleRefresh;
      CheckMark := SquareImages[GuessImage];
      Title := ADR(MineSweeperName);
      Type := Intuition.WBenchScreen;
    END;
    Storage.ALLOCATE(NewGameGad,SIZE(NewGameGad^) (* * 2*) );
    IF NewGameGad = NIL THEN
      RETURN FALSE
    END;
    FieldWindow := Intuition.OpenWindow(nw);
    IF FieldWindow = NIL THEN
      nw^.LeftEdge := 0;
      nw^.TopEdge := 0;
      FieldWindow := Intuition.OpenWindow(nw);
      IF FieldWindow = NIL THEN
        IF Level # Beginner THEN
          Storage.DEALLOCATE(nw,0);
          Storage.DEALLOCATE(NewGameGad,0);
          SetSize(Beginner);
          RETURN CreateFieldWindow()
        END;
      END
    END;
    IF menu # NIL THEN
      menu^.Width := Text.TextLength(ADR(FieldWindow^.WScreen^.RPort),ADR(GameText),GameTextLen) * 2;
      WITH menu^.NextMenu^ DO
        Width := Text.TextLength(ADR(FieldWindow^.WScreen^.RPort),ADR(CompleteText),CompleteTextLen) * 2;
        LeftEdge := menu^.LeftEdge + menu^.Width + 10;
      END;
      Intuition.SetMenuStrip(FieldWindow,menu)
    END;
    Pointer.SetMyPointer(FieldWindow);
    Storage.DEALLOCATE(nw,0);
    FieldRPort := FieldWindow^.RPort;
    Pens.SetWrMsk(FieldRPort,{0,1});
(*
    WITH FieldRPort^ DO
      TermOut.WriteString("Mask = ");
      TermOut.WriteHex(CARDINAL(Mask),1);
      TermOut.WriteString("\nAreaPtrn = ");
      TermOut.WriteLongHex(AreaPtrn,1);
      TermOut.WriteString("\nAreaPtSz = ");
      TermOut.WriteInt(INTEGER(AreaPtSz),1);
      TermOut.WriteLn;
    END;
*)
    FindColourScheme;


    
    WITH FieldWindow^ DO
      MainProcess^.prWindowPtr := FieldWindow;
      WindowBit := Tasks.SIGNAL(UserPort^.mpSigBit);
      IF ~InitClip(CARDINAL(WScreen^.BMap.Depth)) THEN
        RETURN FALSE
      END;
      (*Intuition.RefreshWindowFrame(FieldWindow);*)
      Pens.SetDrMd(RPort,Rasters.Jam1);
    END;
    WITH NewGameGad^ DO
      NextGadget := NIL;
      GadgetRenderI := dataPtr^.Images[SmileyImage];
      SelectRenderI := dataPtr^.Images[AstonishedImage];
      Width := GadgetRenderI^.Width;
      Height := GadgetRenderI^.Height;
      LeftEdge := (FieldWindowWidth DIV 2) + LeftFieldBorder - (Width DIV 2);
      TopEdge := TopWindowBorder + (TopWindowArea - Height) DIV 2;
      Flags := Intuition.GadgetFlagSet{Intuition.GadgImage} + Intuition.GadgHImage;
      Activation := Intuition.ActivationFlagSet{Intuition.RelVerify};
      GadgetType := Intuition.BoolGadget;
      GadgetID := NewGameID;
    END;
    gadpos := Intuition.AddGList(FieldWindow,NewGameGad,-1,2,NIL);
      IF ~MySizeWindow(FullWindowWidth, FullWindowHeight) THEN
        IF Level # Beginner THEN
          SetSize(Beginner);
          RETURN CreateFieldWindow()
        END;
        Intuition.CloseWindow(FieldWindow);
        RETURN FALSE
      END;
      Sized := TRUE;
  ELSE
    gadpos := Intuition.RemoveGadget(FieldWindow,NewGameGad);
    IF (LastFieldWidth # FieldWidth) OR (LastFieldHeight # FieldHeight) THEN
      IF ~MySizeWindow(FullWindowWidth, FullWindowHeight) THEN
        IF Level = Beginner THEN
          RETURN FALSE
        END;
        DEC(Level);
        SetSize(Level);
        RETURN CreateFieldWindow()
      END;
    END;
    WITH NewGameGad^ DO
      GadgetRenderI := dataPtr^.Images[SmileyImage];
      SelectRenderI := dataPtr^.Images[AstonishedImage];
      LeftEdge := (FieldWindowWidth DIV 2) + LeftFieldBorder - (Width DIV 2);
      TopEdge := TopWindowBorder + (TopWindowArea - Height) DIV 2;
    END;
    gadpos := Intuition.AddGadget(FieldWindow,NewGameGad,-1);
  END;
  LastFieldWidth := FieldWidth;
  LastFieldHeight := FieldHeight;
  TooBig := FALSE;
  TopTextBorder := TopWindowBorder + (TopWindowArea - 14 (*INTEGER(CountFont^.tfYSize)*)) DIV 2;
  TextWidth := (4 * 10 (*CountFont^.tfXSize*)) + 1;
  TextHeight := 14 (*CountFont^.tfYSize*) + 1;
  TextOffset := (NewGameGad^.LeftEdge - LeftFieldBorder - TextWidth) DIV 2;
  LeftTextBorder := LeftFieldBorder + TextOffset;
  RightTextBorder := NewGameGad^.LeftEdge + NewGameGad^.Width + TextOffset - 1;
  IF ODD(LeftTextBorder) THEN DEC(LeftTextBorder) END;
  IF ODD(RightTextBorder) THEN DEC(RightTextBorder) END;
  WITH NewGameGad^ DO
    SmileX := LeftEdge;
    SmileY := TopEdge;
  END;
  IF Shrunk THEN
    Shrunk := FALSE;
    (*RefreshDisplay(TRUE);*)
    IF ~WaitingForNew THEN StartTimer END;
    RETURN TRUE
  END;
  IF InitFields() THEN
    Intuition.ModifyIDCMP(FieldWindow,NormalIDCMPs);
    INCL(FieldWindow^.Flags,Intuition.ReportMouseFlag);
    RETURN TRUE
  ELSE
    RETURN FALSE
  END
END CreateFieldWindow;



(*
PROCEDURE Count(Field : FieldType; xi,yi : INTEGER) : CARDINAL;

  PROCEDURE TestSquare(xi,yi : INTEGER) : CARDINAL;
  VAR b : BOOLEAN;
  BEGIN
    IF (CARDINAL(xi) < CARDINAL(FieldWidth)) & (CARDINAL(yi) < CARDINAL(FieldHeight)) THEN
      WITH FieldRows[CARDINAL(yi)] DO
        CASE Field OF
        | fMines    : b := CARDINAL(xi) IN Mines;
        | fCovered  : b := CARDINAL(xi) IN Covered;
        | fGuessed  : b := CARDINAL(xi) IN Guessed;
        | fWondered : b := CARDINAL(xi) IN Wondered;
        END;
      END;
      RETURN CARDINAL(b);
    END;
    RETURN 0
  END TestSquare;

BEGIN
  RETURN
    TestSquare(xi-1,yi-1)
 +  TestSquare(xi,yi-1)
 +  TestSquare(xi+1,yi-1)
 +  TestSquare(xi-1,yi)
 +  TestSquare(xi+1,yi)
 +  TestSquare(xi-1,yi+1)
 +  TestSquare(xi,yi+1)
 +  TestSquare(xi+1,yi+1);
END Count;
*)

PROCEDURE Count(Field : FieldType; xi,yi : INTEGER) : CARDINAL;
BEGIN
	SETREG(8,ADR(FieldRows));
	SETREG(1,FieldWidth);
	SETREG(2,FieldHeight);
	SETREG(3,xi);
	SETREG(4,yi);
	SETREG(5,Field);
(*     2 0000:                    ;		a0 = address of FieldRows*)
(*     3 0000:                    ;		d0 = result*)
(*     4 0000:                    ;		d1 = FieldWidth*)
(*     5 0000:                    ;		d2 = FieldHeight*)
(*     6 0000:                    ;		d3 = x*)
(*     7 0000:                    ;		d4 = y*)
(*     8 0000:                    ;		d5 = offset of field in row, eg 0 = mines, 1 = Covered etc*)
(*     9 0000:*)  CODE(05343H);(*              		subq.w #1,d3*)
(*    10 0002:*)  CODE(05344H);(*              		subq.w #1,d4*)
(*    11 0004:*)  CODE(07000H);(*              		moveq.l #0,d0*)
(*    12 0006:*)  CODE(0611eH);(*              		bsr one	; x-1,y-1*)
(*    13 0008:*)  CODE(05243H);(*              		addq.w #1,d3*)
(*    14 000a:*)  CODE(0611aH);(*              		bsr one	;   x,y-1*)
(*    15 000c:*)  CODE(05243H);(*              		addq.w #1,d3*)
(*    16 000e:*)  CODE(06116H);(*              		bsr one	; x+1,y-1*)
(*    17 0010:*)  CODE(05244H);(*              		addq.w #1,d4*)
(*    18 0012:*)  CODE(06112H);(*              		bsr one	; x+1,y*)
(*    19 0014:*)  CODE(05543H);(*              		subq.w #2,d3*)
(*    20 0016:                    		;bsr one	;   x,y - don't test square itself*)
(*    21 0016:                    		;subq.w #1,d3*)
(*    22 0016:*)  CODE(0610eH);(*              		bsr one	; x-1,y*)
(*    23 0018:*)  CODE(05244H);(*              		addq.w #1,d4*)
(*    24 001a:*)  CODE(0610aH);(*              		bsr one	; x-1,y+1*)
(*    25 001c:*)  CODE(05243H);(*              		addq.w #1,d3*)
(*    26 001e:*)  CODE(06106H);(*              		bsr one	;   x,y+1*)
(*    27 0020:*)  CODE(05243H);(*              		addq.w #1,d3*)
(*    28 0022:*)  CODE(06102H);(*              		bsr one	; x+1,y+1*)
(*    29 0024:*)  CODE(0601cH);(*              		bra.s fin*)
(*    30 0026:                    *)
(*    31 0026:*)  CODE(0b641H);(*              one:	cmp.w d1,d3*)
(*    32 0028:*)  CODE(06416H);(*              		bcc.s out*)
(*    33 002a:*)  CODE(0b842H);(*              		cmp.w d2,d4*)
(*    34 002c:*)  CODE(06412H);(*              		bcc.s out*)
(*    35 002e:*)  CODE(03c04H);(*              		move.w d4,d6*)
(*    36 0030:*)  CODE(0e546H);(*              		asl.w #2,d6*)
(*    37 0032:*)  CODE(0dc45H);(*              		add.w d5,d6*)
(*    38 0034:*)  CODE(0e546H);(*              		asl.w #2,d6*)
(*    39 0036:*)  CODE(02c30H,06000H);(*      		move.l (0,a0,d6),d6*)
(*    40 003a:*)  CODE(00706H);(*              		btst.l d3,d6*)
(*    41 003c:*)  CODE(06702H);(*              		beq.s out*)
(*    42 003e:*)  CODE(05280H);(*              		addq.l #1,d0*)
(*    43 0040:*)  CODE(04e75H);(*              out:	rts*)
(*    44 0042:  4e71              fin:	nop*)
END Count;

(*
PROCEDURE StateOfSquare(x,y : CARDINAL) : SquareState;
VAR
	state : SquareState;
BEGIN
  WITH FieldRows[y] DO
    IF x IN Covered THEN
      state := UnknownState
      IF x IN Wondered THEN
        state := WonderState
        IF x IN Guessed THEN
          state := GuessState
        END
      END
    ELSE
      state := BlankState;
      IF x IN Mines THEN
        state := MineState
      END
    END;
  END;
  RETURN state;
END StateOfSquare;
*)

(*$X-*)
PROCEDURE ChunkyTable();
BEGIN
  CODE(0101H,0101H,0000H,0203H,0404H,0404H,0000H,0203H);
  CODE(0101H,0106H,0000H,0206H,0505H,0505H,0404H,0403H);
END ChunkyTable;


PROCEDURE StateOfSquare(x,y : CARDINAL) : SquareState;
(* This routine uses the Chunky table to convert from an
   element in a 2D bitmap to a SquareState
*)
BEGIN
	SETREG(1,y);
	SETREG(3,x);
	SETREG(8,ADR(FieldRows));
	SETREG(9,CT);
	SETREG(0,WaitingForNew);
(*     2 0000:*)  CODE(0e949H);(*              		lsl.w #4,d1*)
(*     3 0002:*)  CODE(0e908H);(*              		lsl.b #4,d0*)
(*     4 0004:*)  CODE(0d0c1H);(*              		adda.w d1,a0*)
(*     5 0006:*)  CODE(02418H);(*              		move.l (a0)+,d2*)
(*     6 0008:*)  CODE(00702H);(*              		btst.l d3,d2*)
(*     7 000a:*)  CODE(06704H);(*              		beq.s b0*)
(*     8 000c:*)  CODE(008c0H,00003H);(*       		bset.l #3,d0*)
(*     9 0010:*)  CODE(02418H);(*              b0:	move.l (a0)+,d2*)
(*    10 0012:*)  CODE(00702H);(*              		btst.l d3,d2*)
(*    11 0014:*)  CODE(06704H);(*              		beq.s b1*)
(*    12 0016:*)  CODE(008c0H,00002H);(*       		bset.l #2,d0*)
(*    13 001a:*)  CODE(02418H);(*              b1:	move.l (a0)+,d2*)
(*    14 001c:*)  CODE(00702H);(*              		btst.l d3,d2*)
(*    15 001e:*)  CODE(06704H);(*              		beq.s b2*)
(*    16 0020:*)  CODE(008c0H,00000H);(*       		bset.l #0,d0*)
(*    17 0024:*)  CODE(02410H);(*              b2:	move.l (a0),d2*)
(*    18 0026:*)  CODE(00702H);(*              		btst.l d3,d2*)
(*    19 0028:*)  CODE(06704H);(*              		beq.s b3*)
(*    20 002a:*)  CODE(008c0H,00001H);(*       		bset.l #1,d0*)
(*    21 002e:*)  CODE(01031H,00000H);(*       b3:	move.b 0(a1,d0.w),d0*)
END StateOfSquare;


PROCEDURE ShowASquare(x,y : CARDINAL);
VAR
	square : Intuition.ImagePtr;
	state : SquareState;
	xp,yp : CARDINAL;
	b : BOOLEAN;
	str : CHAR;
BEGIN
  state := StateOfSquare(x,y);
  xp := SquareWidth * x;
  yp := CARDINAL(SquareHeight) * y;
  Intuition.DrawImage(FieldRPort,SquareImages[ORD(state)],xp  + CARDINAL(LeftFieldBorder),yp  + CARDINAL(TopFieldBorder));
  IF state = BlankState THEN
    LastSquareCount := Count(fMines,x,y);
    IF LastSquareCount > 0 THEN
      str := CHR(ORD('0') + LastSquareCount);
      EasyText.DoShadowWrite
		(	SquareFont,FieldRPort,ADR(str),
			CARDINAL(LeftSquareText) + xp,CARDINAL(TopSquareText) + yp,
			CARDINAL(ColourPens[VAL(ColourNames,LastSquareCount)]),Pen1,1
		);
    END
  END
END ShowASquare;


PROCEDURE Chunky(row : CARDINAL);
BEGIN
  SETREG(8,ADR(FieldRows));
  SETREG(0,row);
  SETREG(1,WaitingForNew);
  SETREG(9,ADR(ChunkyBuf));
  SETREG(10,CT);
  SETREG(6,FieldWidth);
(*     1 0000:*)  CODE(0e980H);(*              		asl.l #4,d0*)
(*     2 0002:*)  CODE(0d1c0H);(*              		adda.l d0,a0*)
(*     3 0004:*)  CODE(0e901H);(*              		asl.b #4,d1*)
(*     4 0006:*)  CODE(0d5c1H);(*              		adda.l d1,a2*)
(*     5 0008:*)  CODE(07000H);(*              		moveq.l #0,d0*)
(*     6 000a:*)  CODE(02418H);(*              		move.l (a0)+,d2	;Mines*)
(*     7 000c:*)  CODE(02618H);(*              		move.l (a0)+,d3	;Covered*)
(*     8 000e:*)  CODE(02818H);(*              		move.l (a0)+,d4	;Guessed*)
(*     9 0010:*)  CODE(02a10H);(*              		move.l (a0),d5		;Wondered*)
(*    10 0012:*)  CODE(05386H);(*              		subq.l #1,d6*)
(*    11 0014:*)  CODE(07e00H);(*              l0:	moveq.l #0,d7*)
(*    12 0016:*)  CODE(00102H);(*              		btst.l d0,d2*)
(*    13 0018:*)  CODE(06702H);(*              		beq.s co*)
(*    14 001a:*)  CODE(05007H);(*              		addq.b #8,d7*)
(*    15 001c:*)  CODE(00103H);(*              co:	btst.l d0,d3*)
(*    16 001e:*)  CODE(06702H);(*              		beq.s wo*)
(*    17 0020:*)  CODE(05807H);(*              		addq.b #4,d7*)
(*    18 0022:*)  CODE(00105H);(*              wo:	btst.l d0,d5*)
(*    19 0024:*)  CODE(06702H);(*              		beq.s gu*)
(*    20 0026:*)  CODE(05407H);(*              		addq.b #2,d7*)
(*    21 0028:*)  CODE(00104H);(*              gu:	btst.l d0,d4*)
(*    22 002a:*)  CODE(06702H);(*              		beq.s wb*)
(*    23 002c:*)  CODE(05207H);(*              		addq.b #1,d7*)
(*    24 002e:*)  CODE(012f2H,07800H);(*       wb:	move.b 0(a2,d7.l),(a1)+*)
(*    25 0032:*)  CODE(05200H);(*              		addq.b #1,d0*)
(*    26 0034:*)  CODE(051ceH,0ffdeH);(*       		dbra d6,l0*)
END Chunky;

(*$X-*)
PROCEDURE TestChunkyTable();
BEGIN
  CODE(0001H,0203H,0405H,0607H,0809H,0A0BH,0C0DH,0E0FH);
  CODE(1011H,1213H,1415H,1617H,1819H,1A1BH,1C1DH,1E1FH);
END TestChunkyTable;


PROCEDURE ShowARow(y : CARDINAL);
(* Refresh one row of the display *)
VAR
	state : SquareState;
	x, xp,yp,xt,yt : CARDINAL;
	sqv : INTEGER;
	str : CHAR;
	cp : POINTER TO SquareState;
BEGIN
  x := 0;
  xp := CARDINAL(LeftFieldBorder);
  xt := CARDINAL(LeftSquareText);
  yp := (CARDINAL(SquareHeight) * y);
  yt := yp;
  INC(yp, CARDINAL(TopFieldBorder));
  INC(yt, CARDINAL(TopSquareText));
  Chunky(y);
  cp := ADR(ChunkyBuf);
  REPEAT
    state := cp^;
    INC(cp);
    Intuition.DrawImage(FieldRPort,SquareImages[ORD(state)],xp,yp);
    IF state = BlankState THEN
      sqv := Count(fMines,x,y);
      IF sqv > 0 THEN
        str := CHR(ORD('0') + sqv);
        EasyText.DoShadowWrite(SquareFont,FieldRPort,ADR(str),xt,yt,CARDINAL(ColourPens[VAL(ColourNames,sqv)]),Pen1,1);
      END
    END;
    INC(x);
    INC(xp,SquareWidth);
    INC(xt,SquareWidth);
  UNTIL x = CARDINAL(FieldWidth);
END ShowARow;

(*ShowStates+
PROCEDURE ShowStates();
VAR
	cp : POINTER TO SquareState;
	x,y : INTEGER;
BEGIN
  CT := ADR(TestChunkyTable);
  FOR y := 0 TO FieldHeight - 1 DO
    Chunky(y);
    cp := ADR(ChunkyBuf);
    FOR x := 0 TO FieldWidth - 1 DO
      TermOut.WriteHex(CARDINAL(cp^),2);
      INC(cp);
    END;
    TermOut.WriteLn;

    FOR x := 0 TO FieldWidth - 1 DO
      TermOut.WriteHex(CARDINAL(StateOfSquare(x,y)),2);
    END;
    TermOut.WriteLn;
    TermOut.WriteLn;
  END;
  CT := ADR(ChunkyTable);
END ShowStates;
*ShowStates-*)

(*
PROCEDURE ShowARow(y : CARDINAL);
VAR
	square : Intuition.ImagePtr;
	state : SquareState;
	x, xp,yp, xt, yt : CARDINAL;
	sqv : INTEGER;
	str : ARRAY [0..1] OF CHAR;
BEGIN
  x := 0;
  xp := 0;
  yp := CARDINAL(SquareHeight) * y;
  WITH FieldRows[y] DO
    REPEAT
      IF x IN Covered THEN
        state := UnknownState;
        IF x IN Wondered THEN
          state := WonderState;
          IF x IN Guessed THEN
            state := GuessState
          END
        END
      ELSE
        state := BlankState;
        IF x IN Mines THEN
          state := MineState
        END
      END;
      Intuition.DrawImage(FieldRPort,SquareImages[ORD(state)],xp  + CARDINAL(LeftFieldBorder),yp  + CARDINAL(TopFieldBorder));
      IF state = BlankState THEN
        sqv := Count(fMines,x,y);
        IF sqv > 0 THEN
          str[0] := CHR(ORD('0') + sqv);
          str[1] := 0C;
            xt := CARDINAL(LeftSquareText) + xp;
            yt := CARDINAL(TopSquareText) + yp;
            EasyText.DoWrite(SquareFont,FieldRPort,str,xt + 1,yt + 1,Pen1,-1,1);
            EasyText.DoWrite(SquareFont,FieldRPort,str,xt,yt,Pen2,-1,1);
        END
      END;
      INC(x);
      INC(xp,SquareWidth);
    UNTIL x = CARDINAL(FieldWidth);
  END;
END ShowARow;
*)

PROCEDURE ChangeFaceImage(ImageNum : CARDINAL);
VAR
	gadpos : INTEGER;
BEGIN
  FaceImage := dataPtr^.Images[ImageNum];
  IF NewGameGad^.GadgetRenderI # FaceImage THEN
    gadpos := Intuition.RemoveGadget(FieldWindow,NewGameGad);
    NewGameGad^.GadgetRenderI := FaceImage;
    gadpos := Intuition.AddGadget(FieldWindow,NewGameGad,gadpos);
  END;
  Intuition.RefreshGList(NewGameGad,FieldWindow,NIL,1);
END ChangeFaceImage;


PROCEDURE UncoveredAMine(x,y : CARDINAL);
VAR
	i,j : CARDINAL;
	cp : POINTER TO SquareState;
BEGIN
  EndGame(NoReStart);
  ChangeFaceImage(UnhappyImage);
  
  FOR j := 0 TO CARDINAL(FieldHeight) - 1 DO
    Chunky(j);
    cp := ADR(ChunkyBuf);
    FOR i := 0 TO CARDINAL(FieldWidth) - 1 DO
      CASE cp^ OF
      | UnknownState, BlankState, WonderState, GuessState :
      | MineState	:
			ShowSquare(i,j,MineState);
      | FoundMineState	:
      	ShowSquare(i,j,FoundMineState);
      | BadGuessState	:
      	ShowSquare(i,j,BadGuessState);
      END;
      INC(cp);
    END
  END;
  FlashDisplay(4);
END UncoveredAMine;


PROCEDURE ProcessStack();
VAR
	xi,yi : INTEGER;
BEGIN
  WHILE PopStack(xi,yi) DO
    IF CARDINAL(xi) IN FieldRows[CARDINAL(yi)].Mines THEN
      UncoveredAMine(xi,yi);
    ELSE
      DEC(NonMinesCovered);
      ShowASquare(xi,yi);
      IF LastSquareCount (*Count(fMines,xi,yi)*) = 0 THEN
        LookAround(xi,yi);
      END;
    END
  END;
  TestGameOver;
END ProcessStack;

PROCEDURE Guess(x,y : CARDINAL);
BEGIN
  IF INTEGER(x) >= 0 THEN
    WITH FieldRows[y] DO
      IF (x IN Covered) THEN
        IF x IN Guessed THEN
          EXCL(Guessed,x);
          IF ~Questions THEN
            EXCL(Wondered,x);
          END;
          DEC(GuessedMines);
          IF x IN Mines THEN
            DEC(GuessedRightMines)
          END;
        ELSIF x IN Wondered THEN
          EXCL(Wondered,x);
        ELSE
          INCL(Guessed,x);
          INCL(Wondered,x);
          INC(GuessedMines);
          IF x IN Mines THEN
            INC(GuessedRightMines)
          END
        END
      END;
    END;
    ShowASquare(x,y);
    UpdateMineCountDisplay;
    TestGameOver;
  END;
END Guess;



PROCEDURE RefreshDisplay(refresh : BOOLEAN);
VAR
	x,y : INTEGER;
	xp,yp : INTEGER;
BEGIN
  IF refresh THEN
    Intuition.BeginRefresh(FieldWindow);
    IF WindowSized THEN
      Intuition.EndRefresh(FieldWindow,TRUE);
    END;
  END;
  IF ~Shrunk THEN
    WITH FieldWindow^ DO
      DoFill(FieldRPort,FadePattern,1,Pen1,INTEGER(BorderLeft),INTEGER(BorderTop),Width - INTEGER(BorderRight) - 1,Height - INTEGER(BorderBottom) - 1);
    END;

    DoFill(FieldRPort,FadePattern,1,3,LeftFieldBorder,TopWindowBorder,RightFieldBorder,TopWindowBorder + TopWindowArea - 1);

    Pens.SetAPen(FieldRPort,Pen1);
    Pens.Move(FieldRPort,LeftFieldBorder,TopFieldBorder - 2);
    Pens.Draw(FieldRPort,LeftFieldBorder,TopWindowBorder);
    Pens.Draw(FieldRPort,RightFieldBorder,TopWindowBorder);


    Pens.SetAPen(FieldRPort,Pen2);
    Pens.Move(FieldRPort,RightFieldBorder, TopWindowBorder);
    Pens.Draw(FieldRPort,RightFieldBorder, TopFieldBorder - 2);
    Pens.Draw(FieldRPort,LeftFieldBorder,TopFieldBorder - 2);

    UpdateMineCountDisplay;
    UpdateTime;
    yp := TopFieldBorder;

    Pens.SetWrMsk(FieldRPort,{0..15});
    DoFill(FieldRPort,SquareImages[ORD(UnknownState)]^.ImageData,FillParam,3,LeftFieldBorder,TopFieldBorder,RightFieldBorder,TopFieldBorder + FieldWindowHeight - 1);
    Pens.SetWrMsk(FieldRPort,{0,1});

    y := FieldHeight;
    IF WaitingForNew THEN
      WHILE y > 0 DO
        DEC(y);
        WITH FieldRows[CARDINAL(y)] DO
          IF (Covered - Mines) # CoveredRow THEN
            ShowARow(y)
          END
        END;
      END;
    ELSE
      WHILE y > 0 DO
        DEC(y);
        IF FieldRows[CARDINAL(y)].Covered # CoveredRow THEN
          ShowARow(y)
        END;
      END;
    END;
    Restarting := FALSE;
  END;
  IF refresh & ~WindowSized THEN
    Intuition.EndRefresh(FieldWindow,TRUE);
  END;
  WindowSized := FALSE;
  Intuition.RefreshGList(NewGameGad,FieldWindow,NIL,1);
END RefreshDisplay;

PROCEDURE UnCover(x,y : CARDINAL);
VAR
	nx,ny : CARDINAL;
BEGIN
  WITH FieldRows[y] DO
    IF SafeIfMarked THEN
      IF (x IN Wondered) OR (x IN Guessed) THEN
        RETURN
      END;
    END;
    IF FirstHit THEN
      IF x IN Mines THEN
        IF ~SafeIfMarked THEN
          IF (x IN Wondered) & (x IN Guessed) THEN
            DEC(GuessedRightMines);
          END;
        END;
        ny := FastRandom.Random(FieldHeight);
        WHILE FieldRows[ny].Mines = CoveredRow DO
          ny := (ny + 1) MOD CARDINAL(FieldHeight);
        END;
        nx := FastRandom.Random(FieldWidth);
        WHILE nx IN FieldRows[ny].Mines DO
          nx := (nx + 1) MOD CARDINAL(FieldWidth);
        END;
        IF (nx IN FieldRows[ny].Wondered) & (nx IN FieldRows[ny].Guessed) THEN
          INC(GuessedRightMines);
        END;
        INCL(FieldRows[ny].Mines,nx);
        EXCL(Mines,x);
      END;
      StartTimer;
      FirstHit := FALSE
    END;
    Lastx := -1;
    IF ~SafeIfMarked THEN
      IF x IN Wondered THEN
        EXCL(Wondered,x);
        IF x IN Guessed THEN
          EXCL(Guessed,x);
          DEC(GuessedMines);
          IF x IN Mines THEN
            DEC(GuessedRightMines);
          END;
          UpdateMineCountDisplay;
        END;
      END;
    END;
(*
    IF x IN Mines THEN
      INCL(Guessed,x);
      EXCL(Wondered,x);
    END;
*)
  END;
  PushStack(x,y);
  ProcessStack;
END UnCover;

PROCEDURE SureSquare(x,y : CARDINAL);
BEGIN
  IF ~(x IN FieldRows[y].Covered) & (Count(fGuessed,x,y) = Count(fMines,x,y)) THEN
    LookAround(x,y);
    ProcessStack;
  END;
END SureSquare;

PROCEDURE ShowAround(x,y : INTEGER; image : Intuition.ImagePtr);
VAR
	xp,yp : INTEGER;
	mfr : MineFieldRow;

  PROCEDURE ShowOne;
  VAR
    sqr : Intuition.ImagePtr;
  BEGIN
    SETREG(2,x);
    IF (CARDINAL(REGISTER(2)) < CARDINAL(FieldWidth)) & (CARDINAL(y) < CARDINAL(FieldHeight)) THEN
      IF CARDINAL(REGISTER(2)) IN mfr.Covered THEN
        sqr := image;
        IF CARDINAL(REGISTER(2)) IN mfr.Wondered THEN
          sqr := SquareImages[WonderImage + CARDINAL(CARDINAL(REGISTER(2)) IN mfr.Guessed)];
        END;
        Intuition.DrawImage(FieldRPort,sqr,xp,yp);
      END;
    END
  END ShowOne;
  
BEGIN
  DEC(x);
  DEC(y);
  xp := x * SquareWidth + LeftFieldBorder;
  yp := y * SquareHeight + TopFieldBorder;
  
  mfr := FieldRows[y];
  ShowOne;
  INC(x);
  INC(xp,SquareWidth);
  ShowOne;
  INC(x);
  INC(xp,SquareWidth);
  ShowOne;
  INC(y);
  INC(yp,SquareHeight);
  mfr := FieldRows[y];
  ShowOne;
  DEC(x);
  DEC(xp,SquareWidth);
  ShowOne;
  DEC(x);
  DEC(xp,SquareWidth);
  ShowOne;
  INC(y);
  INC(yp,SquareHeight);
  mfr := FieldRows[y];
  ShowOne;
  INC(x);
  INC(xp,SquareWidth);
  ShowOne;
  INC(x);
  INC(xp,SquareWidth);
  ShowOne;
END ShowAround;


PROCEDURE ShowPos(x,y : INTEGER; OnBoard : BOOLEAN);
VAR
	str : ARRAY [0..11] OF CHAR;
	covered, b : BOOLEAN;
	xp,yp : INTEGER;
	square : Intuition.ImagePtr;
BEGIN
	IF (Lastx = x) & (Lasty = y) THEN RETURN END;
	IF Lastx >= 0 THEN
	  CASE LastState OF
	    NormalMove,MineMove :
	      Blitter.BltBitMapRastPort(ADR(ClipBM),0,0,FieldRPort,Lastxp,Lastyp,SquareWidth,SquareHeight,CopyAtoD);
	  | SafeMove :
	      Blitter.BltBitMapRastPort(ADR(ClipBM),0,0,FieldRPort,Lastxp,Lastyp,SquareWidth3,SquareHeight3,CopyAtoD);
	  ELSE
	  END;
	END;
	IF OnBoard THEN
     xp := x * SquareWidth + LeftFieldBorder;
     yp := y * SquareHeight + TopFieldBorder;
     covered := (CARDINAL(x) IN FieldRows[CARDINAL(y)].Covered);
     CASE MovingState OF
     | NormalMove :
       IF covered THEN
         Blitter.ClipBlit(FieldRPort,xp,yp,ClipRPort,0,0,SquareWidth,SquareHeight,CopyAtoD);
         Intuition.DrawImage(FieldRPort,SquareImages[SureImage],xp,yp);
       ELSE
         x := -1
       END;
     | MineMove :
       IF covered THEN
         Blitter.ClipBlit(FieldRPort,xp,yp,ClipRPort,0,0,SquareWidth,SquareHeight,CopyAtoD);
         Intuition.DrawImage(FieldRPort,SquareImages[GuessImage],xp,yp);
       ELSE
         x := -1
       END;
     | SafeMove :
       DEC(xp,SquareWidth);
       DEC(yp,SquareHeight);
       Blitter.ClipBlit(FieldRPort,xp,yp,ClipRPort,0,0,SquareWidth3,SquareHeight3,CopyAtoD);
       ShowAround(x,y,SquareImages[SureImage]);
     ELSE
     END;
     Lastx := x;
     Lasty := y;
     Lastxp := xp;
     Lastyp := yp;
     LastState := MovingState;
   ELSE
     Lastx := -1
   END;
END ShowPos;

PROCEDURE MakeWindow() : Intuition.WindowPtr;
VAR
	nw : Intuition.NewWindowPtr;
	res : Intuition.WindowPtr;
BEGIN
  res := NIL;
  Storage.ALLOCATE(nw,SIZE(nw^));
  IF nw # NIL THEN
    WITH nw^ DO
      Width := 40 * SquareFont^.tfXSize;
      Height := 16 * SquareFont^.tfYSize;
      LeftEdge := FieldWindow^.LeftEdge + ((FieldWindow^.Width - Width) DIV 2);
      IF LeftEdge < 0 THEN LeftEdge := 0
      ELSIF (LeftEdge + Width) > FieldWindow^.WScreen^.Width THEN
        LeftEdge := FieldWindow^.WScreen^.Width - Width
      END;
      TopEdge := FieldWindow^.TopEdge + ((FieldWindow^.Height - Height) DIV 2);
      IF TopEdge < 0 THEN TopEdge := 0
      ELSIF (TopEdge + Height) > FieldWindow^.WScreen^.Height THEN
        TopEdge := FieldWindow^.WScreen^.Height - Height;
      END;
      Flags := Intuition.WindowFlagSet{Intuition.Activate, Intuition.NoCareRefresh};
      DetailPen := BYTE(Pen1);
      BlockPen := BYTE(Pen2);
      Type := Intuition.WBenchScreen;
    END;
    res := Intuition.OpenWindow(nw);
    Storage.DEALLOCATE(nw,0);
  END;
  RETURN res
END MakeWindow;

PROCEDURE myCloseWindow(win : Intuition.WindowPtr);
BEGIN
  win^.UserPort := NIL;
  Intuition.CloseWindow(win);
END myCloseWindow;

TYPE
	WaitMode = (waitWin,waitHigh,waitVal);

PROCEDURE WaitOnWindow(win : Intuition.WindowPtr; mode : WaitMode);
VAR
	port : Ports.MsgPortPtr;
	msg : Intuition.IntuiMessagePtr;
BEGIN
  port := FieldWindow^.UserPort;
  win^.UserPort := port;
  Intuition.ModifyIDCMP(win,Intuition.IDCMPFlagSet{Intuition.MouseButtons, Intuition.ActiveWindow, Intuition.GadgetUp});
  LOOP
    IF mode # waitWin THEN
      SETREG(0,Intuition.ActivateGadget(ADR(EntryGad^.Gad),win,NIL));
    END;
    LOOP
      msg := Ports.GetMsg(port);
      IF msg # NIL THEN
        EXIT
      END;
      msg := Ports.WaitPort(port);
    END;
    WITH msg^ DO
      IF  (IDCMPWindow = win) THEN
        IF  (Intuition.MouseButtons IN Class)
          & (Code = Intuition.SelectUp)
        THEN
          IF mode = waitWin THEN
            Ports.ReplyMsg(msg);
            EXIT
          END
        ELSIF (Intuition.GadgetUp IN Class) THEN
          Ports.ReplyMsg(msg);
          IF mode = waitHigh THEN
            WITH HighScores^.scores[Level] DO
              WITH EntryGad^.SI DO
                NameLength := BYTE(NumChars);
                IF Name # NIL THEN
                  Storage.DEALLOCATE(Name,0)
                END;
                Name := NIL;
                IF NameLength # BYTE(0) THEN
                  Storage.ALLOCATE(Name,LONGINT(CARDINAL(NameLength) + 1));
                  IF Name # NIL THEN
  
                    Memory.CopyMem(Buffer,Name,CARDINAL(NameLength) + 1);
  
                  ELSE
                    NameLength := BYTE(0)
                  END;
                END
              END
            END;
          END;
          EXIT
        END;
      ELSIF (IDCMPWindow = FieldWindow) THEN
        IF (Intuition.RefreshWindow IN Class) THEN
          RefreshDisplay(TRUE);
        END
      END;
    END;
    Ports.ReplyMsg(msg);
  END;
  IF mode # waitVal THEN
    myCloseWindow(win);
  END;
END WaitOnWindow;

CONST
	Spacer = "-----------";

TYPE
	EnterType = (eWidth,eHeight,eMines);

PROCEDURE ShowHighAbout(mode : HA);
VAR
	AboutWindow : Intuition.WindowPtr;
	line,linewidth,left,newval : INTEGER;
	rp : Rasters.RastPortPtr;
	Entering : EnterType;
	NewCustom : BOOLEAN;

   (*$STRING-*)
	PROCEDURE DoLine(str : ARRAY OF CHAR; length : INTEGER; colour : ColourNames);
	VAR
	   l : INTEGER;
	BEGIN
	  l := ((linewidth - (length * INTEGER(SquareFont^.tfXSize))) DIV 2) + left;
	  EasyText.DoShadowWrite(SquareFont,rp,ADR(str),l, line,ColourPens[colour],Pen1,length);
     INC(line,INTEGER(SquareFont^.tfYSize));
	END DoLine;

  (*$STRING-*)
  PROCEDURE ShowScore(str : ARRAY OF CHAR; strl : CARDINAL; level : SkillLevel);
  VAR
    sp : STRPTR;
    l : INTEGER;
    buf : ARRAY [0..39] OF CHAR;
  BEGIN
    DoLine(str,strl,cnBlue);
    WITH HighScores^.scores[level] DO
      
      ConvNum(buf,Seconds);
      Memory.CopyMem(ADR(" by "),ADR(buf[4]),4);
      sp := ADR("Anonymous");
      l := 9;
      IF NameLength # BYTE(0) THEN
        sp := Name;
        l := CARDINAL(NameLength);
      END;
      Memory.CopyMem(sp,ADR(buf[8]),l);
      DoLine(buf,l+8,cnRed);
      DoLine(Spacer,11,cnGreen);
    END
  END ShowScore;
  
  PROCEDURE ConvertNumber(VAR s : ARRAY OF CHAR; index,v : CARDINAL) : CARDINAL;
  VAR
    sp : POINTER TO CHAR;
    dig : BOOLEAN;
    l,i,chars : CARDINAL;
  BEGIN
    dig := FALSE;
    sp := ADR(s) + ADDRESS(index);
    chars := 0;
    l := 1000;
    WHILE l > 0 DO
      i := (v DIV l);
      IF dig OR (i > 0) THEN
        sp^ := CHR(ORD("0") + i);
        INC(sp);
        INC(chars);
        dig := TRUE;
      END;
      v := v MOD l;
      l := l DIV 10;
    END;
    sp^ := 0C;
    RETURN chars
  END ConvertNumber;
  
	
  (*$STRING-*)
  PROCEDURE ShowValue(str : ARRAY OF CHAR; strl,val : CARDINAL);
  VAR
    buf : ARRAY [0..39] OF CHAR;
  BEGIN
    Memory.CopyMem(ADR(str),ADR(buf),strl);
    INC(strl,ConvertNumber(buf,strl,val));
    DoLine(buf,strl,cnBlue);
  END ShowValue;

  PROCEDURE SetVal(v:INTEGER);
  VAR
    sp : POINTER TO CHAR;
    l, i : INTEGER;
  BEGIN
    newval := v;
    WITH EntryGad^.SI DO
      LongInt := LONGINT(v);
      NumChars := ConvertNumber(Buffer^,0,v);
      BufferPos := NumChars;
    END;
  END SetVal;

  PROCEDURE ClearWin();
  VAR
  	top, width, height : INTEGER;
  BEGIN
    WITH AboutWindow^ DO
      Pens.SetWrMsk(RPort,{0..15});
      left := INTEGER(BorderLeft);
      width := Width - INTEGER(BorderRight) - 1;
      top := INTEGER(BorderTop);
      height := Height - INTEGER(BorderBottom) - 1;
      DoFill(RPort,FadePattern,1,ColourPens[cnWhite], left, top, width, height);
      INC(left,16);
      INC(top,8);
      DEC(width,32);
      DEC(height,16);
      linewidth := width; (*Width - (INTEGER(BorderLeft) + INTEGER(BorderRight));*)
      Pens.SetAPen(RPort,0);
      Pens.RectFill(RPort,left, top, left + width, top + height);
      Pens.Move(RPort,left,top + height);
      Pens.SetAPen(RPort,Pen2);
      Pens.Draw(RPort,left,top);
      Pens.Draw(RPort,left + width,top);
      Pens.SetAPen(RPort,Pen1);
      Pens.Draw(RPort,left + width,top + height);
      Pens.Draw(RPort,left,top + height);
      line := INTEGER(BorderTop) + 14 (*INTEGER(CountFont^.tfYSize)*);
    END;
  END ClearWin;
  

BEGIN
  AboutWindow := MakeWindow();
  IF AboutWindow # NIL THEN
    rp := AboutWindow^.RPort;
    ClearWin;
    CASE mode OF
      modeAbout :
         DoLine(" ",1,cnWhite);
         DoLine("MineSweeper Version 2.7",23,cnWhite);
         DoLine("8th March 1994",14,cnWhite);
         DoLine(Spacer,11,cnGreen);
         DoLine("John Matthews",13,cnBlue);
         DoLine("4 Wadham Grove,",15,cnBlue);
         DoLine("Tawa,",5,cnBlue);
         DoLine("New Zealand",11,cnBlue);
         DoLine("Phone 64 4 232 7805",19,cnBlue);
         DoLine(Spacer,11,cnGreen);
         DoLine("Internet: probable unavailable",30,cnViolet);
         WaitOnWindow(AboutWindow, waitWin);
    | modeScores :
         DoLine("Best Times",10,cnWhite);
         DoLine(Spacer,11,cnGreen);
         ShowScore(BeginnerString,8,Beginner);
         ShowScore(IntermediateString,12,Intermediate);
         ShowScore(ExpertString,6,Expert);
         ShowScore(CustomString,6,Custom);
         WaitOnWindow(AboutWindow, waitWin);
    | modeGetName :
         IF InitEntryGad() THEN
           EXCL(EntryGad^.Gad.Activation,Intuition.LongInt);
           DoLine("Best Time !",11,cnWhite);
           DoLine(Spacer,11,cnGreen);
           ShowScore("Previous Best",13,Level);
           DoLine(" ",1,cnWhite);
           ShowValue("New Best ",9,NewHigh);
           DoLine(Spacer,11,cnGreen);
           DoLine("Enter your name...",18,cnPaleBlue);
           WITH EntryGad^.SI DO
             WITH HighScores^.scores[Level] DO
               NumChars := CARDINAL(NameLength);
               Seconds := NewHigh;
               DispPos := 0;
               UndoPos := 0;
               Memory.CopyMem(Name,Buffer,NumChars + 1);
             END
           END;
           SETREG(0,Intuition.AddGadget(AboutWindow,ADR(EntryGad^.Gad),-1));
           Intuition.RefreshGList(ADR(EntryGad^.Gad),AboutWindow,NIL,1);
         END;
         WaitOnWindow(AboutWindow, waitHigh);
    | modeGetCustom :
         IF InitEntryGad() THEN
           NewCustom := FALSE;
           INCL(EntryGad^.Gad.Activation,Intuition.LongInt);
           Entering := eWidth;
           LOOP
             DoLine(" ",1,cnWhite);
             DoLine("Custom Setup",12,cnWhite);
             DoLine(Spacer,11,cnGreen);
             ShowValue("Width   = ",10,customrec.Width);
             ShowValue("Height  = ",10,customrec.Height);
             ShowValue("# Mines = ",10,customrec.Mines);
             DoLine(Spacer,11,cnGreen);
             CASE Entering OF
             | eWidth  : DoLine("New Width   :",13,cnRed); SetVal(customrec.Width);
             | eHeight : DoLine("New Height  :",13,cnRed); SetVal(customrec.Height);
             | eMines  : DoLine("New # Mines :",13,cnRed); SetVal(customrec.Mines);
             END;
             EntryGad^.SI.LongInt := LONGINT(newval);
             SETREG(0,Intuition.AddGadget(AboutWindow,ADR(EntryGad^.Gad),-1));
             Intuition.RefreshGList(ADR(EntryGad^.Gad),AboutWindow,NIL,1);
             WaitOnWindow(AboutWindow, waitVal);
             SETREG(0,Intuition.RemoveGadget(AboutWindow,ADR(EntryGad^.Gad)));
             newval := INTEGER(EntryGad^.SI.LongInt);
             CASE Entering OF
             | eWidth :
					IF (newval < MinFieldWidth) THEN newval := MinFieldWidth END;
					IF (newval > MaxFieldWidth) THEN newval := MaxFieldWidth END;
					NewCustom := NewCustom OR (customrec.Width # newval);
					customrec.Width := newval;
             | eHeight :
					IF (newval < MinFieldHeight) THEN newval := MinFieldHeight END;
					IF (newval > MaxFieldHeight) THEN newval := MaxFieldHeight END;
					NewCustom := NewCustom OR (customrec.Height # newval);
					customrec.Height := newval;
				 | eMines :
				   IF (newval < MinMines) THEN newval := MinMines END;
				   IF (newval > MaxMines) THEN newval := MaxMines END;
				   NewCustom := NewCustom OR (customrec.Mines # newval);
				   customrec.Mines := newval;
				   myCloseWindow(AboutWindow);
				   IF NewCustom THEN
				     WITH HighScores^.scores[Custom] DO
				       Seconds := 9999;
				       NameLength := BYTE(0);
				       IF Name # NIL THEN
				         Storage.DEALLOCATE(Name,0);
				         Name := NIL;
				       END
				     END
				   END;
				   RETURN
				 END;
				 INC(Entering);
				 ClearWin();
			  END;
			END;
    END;
  END;
END ShowHighAbout;

PROCEDURE TestGameOver();
VAR
	f : LONGBITSET;
	i,j : INTEGER;
	r : BOOLEAN;
BEGIN
	IF ~WaitingForNew THEN
	  CASE CompleteMethod OF
	  | AllMinesFound :
	      r := (GuessedRightMines # NumMines)
	  | AllNonMinesFound :
	      r := (NonMinesCovered > 0)
	  | AllSquaresFound :
	      r := (GuessedRightMines # NumMines) OR (NonMinesCovered > 0)
	  | EitherCompletion :
	      r := ~((GuessedRightMines = NumMines) OR (NonMinesCovered = 0))
	  END;
	  IF r THEN RETURN END;
     EndGame(NoReStart);
     ChangeFaceImage(SunGlassesImage);
     FlashDisplay(2);
     FOR i := 0 TO FieldHeight - 1 DO
      WITH FieldRows[i] DO
        f := (Mines * Covered);
        Guessed := Guessed + f;
        Wondered := Wondered + f;
        FOR j := 0 TO FieldWidth - 1 DO
          IF CARDINAL(j) IN f THEN
            ShowSquare(j,i,GuessState)
          END
        END;
      END;
     END;
     IF Seconds < HighScores^.scores[Level].Seconds THEN
       NewHigh := Seconds;
       ShowHighAbout(modeGetName);
     END;
   END
END TestGameOver;


PROCEDURE ShrinkWindow();
VAR
	gadpos : INTEGER;
	bool : BOOLEAN;
BEGIN
  IF ~Shrunk THEN
    Shrunk := TRUE;
    StopTimer;
    LastFieldWidth := 0;
    gadpos := Intuition.RemoveGadget(FieldWindow,NewGameGad);
    WITH NewGameGad^ DO
      LeftEdge := LeftFieldBorder;
      TopEdge := TopWindowBorder;
      bool := MySizeWindow(LeftEdge + RightWindowBorder + Width - 1,
                           TopEdge + BottomWindowBorder + Height - 1);
    END;
    gadpos := Intuition.AddGadget(FieldWindow,NewGameGad,-1);
    WITH FieldWindow^ DO
      DoFill(FieldRPort,FadePattern,1,Pen1,INTEGER(BorderLeft),INTEGER(BorderTop),Width - INTEGER(BorderRight) - 1,Height - INTEGER(BorderBottom) - 1);
    END;
    Intuition.RefreshGadgets(NewGameGad,FieldWindow,NIL);
  END
END ShrinkWindow;


PROCEDURE ProcessMenus(menunum : CARDINAL) : BOOLEAN;
VAR
	itemnum : CARDINAL;
	mItem : Intuition.MenuItemPtr;
	newsize,newgame : BOOLEAN;
	sl : SkillLevel;
BEGIN
  newgame := FALSE;
  newsize := FALSE;
  WHILE menunum # Intuition.MenuNULL DO
    itemnum := Intuition.ITEMNUM(menunum);
    mItem := Intuition.ItemAddress(menu,menunum);
    IF Intuition.MENUNUM(menunum) = 0 THEN
      CASE VAL(MenuVals,itemnum) OF
        mNewGame :
          newgame := TRUE;
      | mBeginner .. mCustom :
          sl := VAL(SkillLevel,itemnum - ORD(mBeginner));
          newsize := TRUE;
          IF sl = Custom THEN
            ShowHighAbout(modeGetCustom)
          END;
      | mQuestions : Questions := Intuition.Checked IN mItem^.Flags
      | mCursor :
          MovingAllowed := (Intuition.SUBNUM(menunum) = 0);
      | mSafe : SafeIfMarked := Intuition.Checked IN mItem^.Flags
      | mScores : ShowHighAbout(modeScores);
      | mAbout : ShowHighAbout(modeAbout);
      | mShrink :
         IF Shrunk THEN
           IF ~CreateFieldWindow() THEN
             RETURN FALSE
           END;
         ELSE
           ShrinkWindow;
         END;
      | mQuit : QuitNow := TRUE; RETURN TRUE
(*      | mTest : ShowStates;*)
      END;
    ELSE
      CompleteMethod := VAL(CompleteMethodType,itemnum)
    END;
    menunum := mItem^.NextSelect
  END;
  IF newsize THEN
    SetSize(sl);
    RETURN TRUE
  END;
  IF newgame THEN
    RETURN TRUE
  END;
  RETURN FALSE
END ProcessMenus;


PROCEDURE PlayGame() : BOOLEAN;
VAR
	port : Ports.MsgPortPtr;
	msgcopy : Intuition.IntuiMessage;
	OnBoard, Breaking : BOOLEAN;

  PROCEDURE AWaitEvent;
  VAR
	msg : Intuition.IntuiMessagePtr;
	sigs : Tasks.SignalSet;
  BEGIN
    sigs := Tasks.SetSignal(Tasks.SignalSet{},WaitBits);
    LOOP
      IF DOS.SIGBreakC IN sigs THEN
        Breaking := TRUE;
        RETURN
      END;
      IF CARDINAL(CountBit) IN sigs THEN
        UpdateTime;
      END;
      sigs := Tasks.SignalSet{};
      msg := Ports.GetMsg(port);
      IF msg # NIL THEN
        IF msg^.IDCMPWindow = FieldWindow THEN
          msgcopy := msg^;
          Ports.ReplyMsg(msg);
          OnBoard := Transform(msgcopy.MouseX,msgcopy.MouseY);
          IF OnBoard & ~WaitingForNew THEN
            INCL(FieldWindow^.Flags,Intuition.RMBTrap)
          ELSE
            EXCL(FieldWindow^.Flags,Intuition.RMBTrap)
          END;
          RETURN
        END;
        Ports.ReplyMsg(msg);
      ELSE
        sigs := Tasks.Wait(WaitBits);
      END;
    END
  END AWaitEvent;

  PROCEDURE ChangeMoveState( newstate : MovingStateType; AllowedStarting : MovingStateSet; MouseChange : BOOLEAN);
  VAR
  	x,y : INTEGER;
  BEGIN
    WITH msgcopy DO
      IF MovingState = NoMove THEN
        IF OnBoard & (newstate # NoMove) THEN
          Intuition.DrawImage(FieldRPort,dataPtr^.Images[AstonishedImage],SmileX, SmileY);
          FromMouse := MouseChange;
          MovingState := newstate;
          ShowPos(MouseX, MouseY, OnBoard);
        END
      ELSE
        x := Lastx;
        y := Lasty;
        ShowPos(-1,-1,FALSE);
        IF (newstate = NoMove)
            & (MovingState IN AllowedStarting)
            & (FromMouse = MouseChange)
        THEN
          IF OnBoard THEN
            CASE MovingState OF
            | NoMove     :
            | NormalMove : UnCover(x,y);
            | SafeMove   : SureSquare(x,y);
            | MineMove   : Guess(x,y);
            END;
          END;
        END;
        MovingState := NoMove;
        Intuition.DrawImage(FieldRPort,FaceImage,SmileX, SmileY);
      END
    END;
  END ChangeMoveState;
  

BEGIN
   ChangeFaceImage(SmileyImage);
   EmptyStack;
	MovingState := NoMove;
   WaitBits := Tasks.SignalSet{DOS.SIGBreakC,CARDINAL(CountBit),CARDINAL(WindowBit)};
	Seconds := 0;
	UpdateTime;
	port := FieldWindow^.UserPort;
	FirstHit := TRUE;
	Lastx := -1;
	Lasty := 0;
	LastState := NoMove;
	Breaking := FALSE;
	RefreshDisplay(FALSE);
	LOOP
	   AWaitEvent;
	   IF Breaking THEN
	     StopTimer;
	     RETURN TRUE
	   END;
      WITH msgcopy DO
         IF Intuition.CloseWindowFlag IN Class THEN
         	StopTimer;
            RETURN TRUE
         ELSIF Intuition.MenuPick IN Class THEN
            IF ProcessMenus(Code) THEN
              EndGame(DoReStart);
              RETURN FALSE
            END;
         ELSIF Intuition.NewSize IN Class THEN
            RefreshDisplay(TRUE);
         ELSIF Intuition.RefreshWindow IN Class THEN
            RefreshDisplay(TRUE);
         ELSIF Intuition.MouseButtons IN Class THEN
            IF (Code = Intuition.MenuUp) THEN
              ChangeMoveState(NoMove,MovingStateSet{SafeMove,MineMove},TRUE);
            ELSIF (Code = Intuition.MenuDown) THEN
              IF CARDINAL(MouseX) IN FieldRows[MouseY].Covered THEN
                ChangeMoveState(MineMove,MovingStateSet{},TRUE);
              ELSE
                ChangeMoveState(SafeMove,MovingStateSet{},TRUE);
              END;
            ELSIF (Code = Intuition.SelectUp) THEN
              ChangeMoveState(NoMove,MovingStateSet{NormalMove},TRUE);
            ELSIF (Code = Intuition.SelectDown) & OnBoard THEN
              ChangeMoveState(NormalMove,MovingStateSet{},TRUE);
            END;
         ELSIF Intuition.GadgetUp IN Class THEN
           ChangeMoveState(NoMove,MovingStateSet{MineMove,SafeMove,NormalMove},TRUE);
           IF Shrunk THEN
             IF ~CreateFieldWindow() THEN
               RETURN FALSE
             END;
           ELSE
             EndGame(DoReStart);
             RETURN FALSE
           END;
         ELSIF Intuition.GadgetDown IN Class THEN
             ChangeMoveState(NoMove,MovingStateSet{MineMove,SafeMove,NormalMove},TRUE);
         ELSIF Intuition.RawKey IN Class THEN
           IF BITSET(InputEvents.IECodeUpPrefix) * BITSET(Code) # BITSET{} THEN
             (* key up *)
             ChangeMoveState(NoMove,MovingStateSet{SafeMove,MineMove,NormalMove},FALSE);
             IF ~WaitingForNew THEN
               INCL(FieldWindow^.Flags,Intuition.RMBTrap)
             END
           ELSE
             IF OnBoard & (MovingState = NoMove) THEN
               CASE Console.RawToASCII(msgcopy) OF
               | 'm','M','g','G' :
                  ChangeMoveState(MineMove,MovingStateSet{},FALSE);
               | 'u','U','1' :
                  ChangeMoveState(NormalMove,MovingStateSet{},FALSE);
               | 'l','L','a','A' :
                  ChangeMoveState(SafeMove,MovingStateSet{},FALSE);
               | '2' :
                 IF CARDINAL(MouseX) IN FieldRows[MouseY].Covered THEN
                   ChangeMoveState(MineMove,MovingStateSet{},FALSE);
                 ELSE
                   ChangeMoveState(SafeMove,MovingStateSet{},FALSE);
                 END;
               | 'p','P' :
                 OnBoard := FALSE;
                 ChangeMoveState(NoMove,MovingStateSet{SafeMove,MineMove,NormalMove},FALSE);
                 IF Shrunk THEN
                   IF ~CreateFieldWindow() THEN
                     RETURN FALSE
                   END;
                 ELSE
                   ShrinkWindow;
                 END;
(***TestLookAround+
               | 't' : TestLookAround(MouseX,MouseY);
*TestLookAround-*)
               ELSE
                 EXCL(FieldWindow^.Flags,Intuition.RMBTrap)
               END
             END
           END
         ELSIF MovingAllowed & (Intuition.MouseMove IN Class) THEN
           IF (MovingState # NoMove) THEN
             ShowPos(MouseX, MouseY, OnBoard)
           END;
         END
      END
	END;
	RETURN FALSE
END PlayGame;

PROCEDURE CloseDisplay();
VAR
	port : Ports.MsgPortPtr;
	msg : ADDRESS;
	cm : Views.ColorMapPtr;
	cn : ColourNames;
BEGIN
	port := FieldWindow^.UserPort;
	Interrupts.Forbid;
	LOOP
		msg := Ports.GetMsg(port);
		IF msg = NIL THEN EXIT END;
		Ports.ReplyMsg(msg);
	END;
	cm := FieldWindow^.WScreen^.VPort.ColorMap;
   FOR cn := MIN(ColourNames) TO MAX(ColourNames) DO
     IF cn IN ObtainedPens THEN
       Pens.ReleasePen(cm,LONGCARD(ColourPens[cn]))
     END
   END;
   ObtainedPens := ColourNameSet{};
   
	Intuition.CloseWindow(FieldWindow);
	Interrupts.Permit;
END CloseDisplay;

PROCEDURE SetUpTimer() : BOOLEAN;
VAR
	sigs : Tasks.SignalSet;
	oldpri : INTEGER;
BEGIN
  TimerAcks := Tasks.SignalSet{CARDINAL(TimerAckBit)};
  oldpri := Tasks.SetTaskPri(MainTask,0);
  TimerTask := TaskUtils.CreateTask(ADR(TaskName),1,TimerProc,4096);
  sigs := Tasks.Wait(TimerAcks);
  RETURN ~TimerError;
END SetUpTimer;

PROCEDURE GetHighScores();
VAR
	fh : DOS.FileHandle;
	err : LONGINT;
	i : CARDINAL;
	l : SkillLevel;
	b : BYTE;

  PROCEDURE ReadScore(level : SkillLevel) : BOOLEAN;
  BEGIN
    WITH HighScores^.scores[level] DO
      Name := NIL;
      IF CARDINAL(NameLength) > 0 THEN
        err := -1;
        Storage.ALLOCATE(Name,LONGINT(CARDINAL(NameLength)) + 1);
        IF Name # NIL THEN
          err := DOS.Read(fh,Name,LONGINT(CARDINAL(NameLength)));
        END;
        IF err # LONGINT(CARDINAL(NameLength)) THEN
          RETURN FALSE
        END;
      END;
    END;
    RETURN TRUE
  END ReadScore;
  

BEGIN
  CompleteMethod := AllSquaresFound;
  Storage.ALLOCATE(HighScores, SIZE(HighScores^));
  IF HighScores = NIL THEN HALT END;
  FOR l := Beginner TO Custom DO
    WITH HighScores^.scores[l] DO
      Seconds := 9999;
    END;
  END;
  WITH HighScores^ DO
    DefLevel := Beginner;
    DefQuestions := TRUE;
  END;
  WITH customrec DO
    version := 1;
    Width := 8;
    Height := 8;
    Mines := 10;
  END;
  fh := DOS.Open(ADR(MineScores),DOS.ModeOldFile);
  IF fh # NIL THEN
    err := DOS.Read(fh,HighScores,SIZE(HighScores^) - SIZE(Score));
    IF err # SIZE(HighScores^) - SIZE(Score) THEN
      SETREG(0,DOS.Close(fh));
      RETURN
    END;
    FOR l := Beginner TO Expert DO
      IF ~ReadScore(l) THEN
        SETREG(0,DOS.Close(fh));
        RETURN
      END;
    END;
    err := DOS.Read(fh,ADR(HighScores^.scores[Custom]),SIZE(Score));
    HighScores^.scores[Custom].Name := NIL;
    IF (err # SIZE(Score)) OR ~ReadScore(Custom) THEN
      HighScores^.scores[Custom].NameLength := BYTE(0);
      SETREG(0,DOS.Close(fh));
      RETURN
    END;
    err :=DOS.Read(fh,ADR(customrec),SIZE(customrec));
    IF (err # SIZE(customrec)) THEN
      HighScores^.scores[Custom].NameLength := BYTE(0);
      SETREG(0,DOS.Close(fh));
      RETURN
    END;
    err := DOS.Read(fh,ADR(b),SIZE(b));
    IF (err = SIZE(b)) THEN
      CompleteMethod := VAL(CompleteMethodType,b)
    END;
    err := DOS.Read(fh,ADR(b),SIZE(b));
    IF (err = SIZE(b)) THEN
      MovingAllowed := (b = BYTE(1));
    END;
    err := DOS.Read(fh,ADR(b),SIZE(b));
    IF (err = SIZE(b)) THEN
      SafeIfMarked := (b = BYTE(1));
    END;
  END;
  SETREG(0,DOS.Close(fh));
END GetHighScores;

PROCEDURE SaveHighScores();
VAR
	fh : DOS.FileHandle;
	err : LONGINT;
	i : CARDINAL;
	l : SkillLevel;
	b : BYTE;

  PROCEDURE WriteScore(level : SkillLevel) : BOOLEAN;
  BEGIN
    WITH HighScores^.scores[level] DO
      IF CARDINAL(NameLength) > 0 THEN
        err := -1;
        err := DOS.Write(fh,Name,LONGINT(CARDINAL(NameLength)));
        IF err # LONGINT(CARDINAL(NameLength)) THEN
          RETURN FALSE
        END;
      END;
    END;
    RETURN TRUE;
  END WriteScore;
  

BEGIN
  IF HighScores = NIL THEN RETURN END;
  WITH HighScores^ DO
    InitX := FieldWindow^.LeftEdge;
    InitY := FieldWindow^.TopEdge;
    DefLevel := Level;
    DefQuestions := Questions;
  END;
  fh := DOS.Open(ADR(MineScores),DOS.ModeNewFile);
  IF fh # NIL THEN
    err := DOS.Write(fh,HighScores,SIZE(HighScores^) - SIZE(Score));
    IF err # (SIZE(HighScores^) - SIZE(Score)) THEN
      SETREG(0,DOS.Close(fh));
      RETURN
    END;
    FOR l := Beginner TO Expert DO
      IF ~WriteScore(l) THEN
        SETREG(0,DOS.Close(fh));
        RETURN
      END;
    END;
    err := DOS.Write(fh,ADR(HighScores^.scores[Custom]),SIZE(Score));
    IF (err # SIZE(Score)) OR ~WriteScore(Custom) THEN
      SETREG(0,DOS.Close(fh));
      RETURN
    END;
    customrec.version := HighScoreVersion;
    IF (DOS.Write(fh,ADR(customrec),SIZE(customrec)) = SIZE(customrec)) THEN
      b := BYTE(CompleteMethod);
      err := DOS.Write(fh,ADR(b),SIZE(b));
      IF err = SIZE(b) THEN
        b := BYTE(0);
        IF MovingAllowed THEN
          b := BYTE(1);
        END;
        err := DOS.Write(fh,ADR(b),SIZE(b));
        IF err = SIZE(b) THEN
          b := BYTE(0);
          IF SafeIfMarked THEN
            b := BYTE(1);
          END;
          err := DOS.Write(fh,ADR(b),SIZE(b));
        END;
      END
    END;
  END;
  SETREG(0,DOS.Close(fh));
END SaveHighScores;

PROCEDURE GetWindowSizes() : BOOLEAN;
VAR
	nw : Intuition.NewWindowPtr;
	win : Intuition.WindowPtr;
	vp : Views.ViewPortPtr;
BEGIN
  V36 := (RunTime.ExecVersion > 35);
  Storage.ALLOCATE(nw,SIZE(nw^));
  IF nw = NIL THEN RETURN FALSE END;
  WITH nw^ DO
    Width := 10;
    Height := 10;
    Flags := Intuition.WindowFlagSet{Intuition.BackDrop};
    Type := Intuition.WBenchScreen;
    Title := ADR(MineSweeperName);
  END;
  win := Intuition.OpenWindow(nw);
  Storage.DEALLOCATE(nw,0);
  IF win = NIL THEN
    RETURN FALSE
  END;
  vp := Intuition.ViewPortAddress(win);
  Laced := Views.Lace IN vp^.Modes;
  IF Laced THEN
    SquareHeight := 16;
    Memory.CopyMem(ADR(dataPtr^.Images[FirstImage]),ADR(SquareImages),SIZE(SquareImages));
    FillParam := -4;
  ELSE
    SquareHeight := 8;
    Memory.CopyMem(ADR(dataPtr^.Images[LastImage + 1]),ADR(SquareImages),SIZE(SquareImages));
    FillParam := -3;
  END;
  SquareHeight3 := SquareHeight * 3;
  WITH win^ DO
    LeftFieldBorder := INTEGER(BorderLeft) + 16 - (INTEGER(BorderLeft) MOD 16);
    TopWindowBorder := INTEGER(BorderTop) + 1;
    RightWindowBorder := INTEGER(BorderRight) + 16 - (INTEGER(BorderRight) MOD 16);
    BottomWindowBorder := INTEGER(BorderBottom) + 16 - (INTEGER(BorderBottom) MOD 16);
    TopFieldBorder := TopWindowBorder + TopWindowArea;
    INC(TopFieldBorder,SquareHeight - (TopFieldBorder MOD SquareHeight));
  END;
  Intuition.CloseWindow(win);
  RETURN TRUE
END GetWindowSizes;


BEGIN
  ObtainedPens := ColourNameSet{};
  CT := ADR(ChunkyTable);
(*  Storage.ALLOCATE(StackBuffer,SIZE(SquareRecord) * MaxStackDepth);*)
  StackBuffer := ADR(RealStackBuffer);
(*StackCheck+
  StackDepthReached := 0;
*StackCheck-*)
  Shrunk := FALSE;
  EntryGad := NIL;
  MovingAllowed := TRUE;
  SafeIfMarked := FALSE;
  IF dataPtr = NIL THEN HALT END;
  FadePattern := dataPtr^.Images[FadePat]^.ImageData;
  IF ~GetWindowSizes() THEN HALT END;
  GetHighScores;
  WITH HighScores^ DO
    Questions := DefQuestions;
    SetSize(DefLevel);
  END;
  OpenFonts;
  CreateMenus;
  MainTask := Tasks.FindTask(Tasks.CurrentTask);
  MainProcess := DOSProcess.ProcessPtr(MainTask);
  OLDprWindow := MainProcess^.prWindowPtr;
  QuitNow := FALSE;
  TimerIsGoing := FALSE;
  TimerError := FALSE;
  TimerAckBit := Tasks.AllocSignal(Tasks.AnySignal);
  CountBit := Tasks.AllocSignal(Tasks.AnySignal);
  IF (TimerAckBit # Tasks.NoSignals) & (CountBit # Tasks.NoSignals) THEN
    IF SetUpTimer() THEN
      FieldWindow := NIL;
      REPEAT
        QuitNow := (~CreateFieldWindow()) OR PlayGame() OR QuitNow;
      UNTIL QuitNow;
      StopTimer;
      MainProcess^.prWindowPtr := OLDprWindow;
      SaveHighScores;
      CloseDisplay;
      (*ShowFields*)
    END
  END;
  IF (TimerAckBit # Tasks.NoSignals) THEN
    Tasks.FreeSignal(TimerAckBit);
  END;
  IF (CountBit # Tasks.NoSignals) THEN
    Tasks.FreeSignal(CountBit);
  END;
(*    EasyText.EasyCloseFont(CountFont);*)
  EasyText.EasyCloseFont(SquareFont);
(*StackCheck+
  TermOut.WriteString("MAX Stack Depth = ");
  TermOut.WriteCard(StackDepthReached,1);
  TermOut.WriteLn;
*StackCheck-*)
END MineSweeper.
