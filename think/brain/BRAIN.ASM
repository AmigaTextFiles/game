		opt	c-,d-,l-,x-

*
*   Brain Version 1.01
*
*   © André Wichmann of CLUSTER in 1990
*
*   Started on  25/05/1990
*   Last update 30/09/1990
*

		incdir	RAM:include/
		include	exec/exec_lib.i
		include	exec/exec.i
		include	exec/memory.i
		include	intuition/intuition_lib.i
		include	intuition/intuition.i
		include	graphics/graphics_lib.i
		include	libraries/dos_lib.i
		include	libraries/dosextens.i

ALLOC		MACRO
		move.l	#\1,d0
		move.l	#\2,d1
		CALLEXEC AllocMem
		ENDM
FREE		MACRO
		move.l	\1,a1
		move.l	#\2,d0
		CALLEXEC FreeMem
		ENDM
MENU		MACRO
		dc.l	\1
		dc.w	\2,\3,\4,\5
		dc.w	MENUENABLED
		dc.l	Titel_\@
		dc.l	\6
		dc.w	0,0,0,0
Titel_\@	dc.b	\7,0
		EVEN
		ENDM

ITEM		MACRO
		dc.l	\1
		dc.w	\2,\3,\4,\5
		dc.w	ITEMENABLED!ITEMTEXT!HIGHCOMP!\6
		dc.l	0
		dc.l	Name_\@
		dc.l	0
		dc.b	\7,0
		dc.l	0
		dc.w	0
Name_\@		dc.b	0,2
		dc.b	RP_JAM1,0
		dc.w	2,2
		dc.l	0
		dc.l	String_\@
		dc.l	0
String_\@	dc.b	\8,0
		EVEN
		ENDM
EXCLUDE		MACRO
		dc.l	\1
		dc.w	\2,\3,\4,\5
		dc.w	ITEMENABLED!ITEMTEXT!HIGHCOMP!CHECKIT!\6
		dc.l	\7
		dc.l	Name_\@
		dc.l	0
		dc.b	0,0
		dc.l	0
		dc.w	0
Name_\@		dc.b	0,2
		dc.b	RP_JAM1,0
		dc.w	2,2
		dc.l	0
		dc.l	String_\@
		dc.l	0
String_\@	dc.b	\8,0
		EVEN
		ENDM

BOOLGAD		MACRO
		dc.l	\1
		dc.w	\2,\3,\4,\5
		dc.w	GADGHNONE
		dc.w	RELVERIFY
		dc.w	BOOLGADGET
		dc.l	0,0,0,0,0
		dc.w	\6
		dc.l	0
		ENDM
PRINT		MACRO
		move.l	\1,d0
		move.l	\2,d1
		move.l	rp(pc),a1
		CALLGRAF Move
		lea	Text_\@(pc),a0
		bsr	Print_text
		bra.s	Branch_\@
Text_\@		dc.b	\3,0
		EVEN
Branch_\@
		ENDM
LINE		MACRO
		move.l	rp(pc),a1
		move.l	\5,d0
		CALLGRAF SetAPen
		move.l	rp(pc),a1
		move.l	\1,d0
		move.l	\2,d1
		CALLGRAF Move
		move.l	\3,d0
		move.l	\4,d1
		CALLGRAF Draw
		ENDM
BOX		MACRO
		move.l	rp(pc),a1
		move.l	\5,d0
		CALLGRAF SetAPen
		move.l	rp(pc),a1
		move.l	\1,d0
		move.l	\2,d1
		move.l	\3,d2
		move.l	\4,d3
		CALLGRAF RectFill
		LINE	\1,\2,\3,\2,#5
		LINE	\1,\2,\1,\4,#5
		LINE	\3,\2,\3,\4,#6
		LINE	\1,\4,\3,\4,#6
		move.l	rp(pc),a1
		move.l	#7,d0
		CALLGRAF SetAPen
		move.l	rp(pc),a1
		move.l	\5,d0
		CALLGRAF SetBPen
		ENDM

MESSAGE		MACRO
		move.l	rp(pc),a1
		move.l	#0,d0
		CALLGRAF SetAPen
		move.l	rp(pc),a1
		move.l	#0,d0
		CALLGRAF SetBPen
		move.l	rp(pc),a1
		move.l	\1,d0
		move.l	\2,d1
		CALLGRAF Move
		lea	Spaces(pc),a0
		bsr	Print_text
		move.l	rp(pc),a1
		move.l	\1+2,d0
		move.l	\2+2,d1
		CALLGRAF Move
		lea	Spaces(pc),a0
		bsr	Print_text
		move.l	rp(pc),a1
		move.l	#RP_JAM1,d0
		CALLGRAF SetDrMd
		move.l	rp(pc),a1
		move.l	#0,d0
		CALLGRAF SetBPen
		move.l	rp(pc),a1
		move.l	#6,d0
		CALLGRAF SetAPen
		move.l	rp(pc),a1
		move.l	\1+2,d0
		move.l	\2+2,d1
		CALLGRAF Move
		lea	String_\@(pc),a0
		bsr	Print_text
		move.l	rp(pc),a1
		move.l	#5,d0
		CALLGRAF SetAPen
		move.l	rp(pc),a1
		move.l	\1+1,d0
		move.l	\2+1,d1
		CALLGRAF Move
		lea	String_\@(pc),a0
		bsr	Print_text
		move.l	rp(pc),a1
		move.l	#4,d0
		CALLGRAF SetAPen
		move.l	rp(pc),a1
		move.l	\1,d0
		move.l	\2,d1
		CALLGRAF Move
		lea	String_\@(pc),a0
		bsr	Print_text
		move.l	rp(pc),a1
		move.l	#RP_JAM2,d0
		CALLGRAF SetDrMd
		bra.s	Label_\@
String_\@	dc.b	\3,0
		EVEN
Label_\@
		ENDM

		SECTION	"Brain",CODE

		include	user/WBStartup.i

_Main		bsr	OpenLibs
		move.l	#4*8*8,d0
		move.l	#MEMF_PUBLIC!MEMF_CLEAR,d1
		CALLEXEC AllocMem
		move.l	d0,LevelA
		move.l	#4*8*8,d0
		move.l	#MEMF_PUBLIC!MEMF_CLEAR,d1
		CALLEXEC AllocMem
		move.l	d0,LevelB
		move.l	#4*64*8*8,d0
		move.l	#MEMF_PUBLIC!MEMF_CLEAR,d1
		CALLEXEC AllocMem
		move.l	d0,Undo
		move.l	#64*gg_SIZEOF,d0
		move.l	#MEMF_PUBLIC!MEMF_CLEAR,d1
		CALLEXEC AllocMem
		move.l	d0,GadgetX
		move.l	d0,Gadget4

New_Size	bsr	CloseInt
		bsr	OpenInt
		tst.l	Screenptr
		beq	Fail_1
		BOX	#44,#184,#123,#199,#1
		PRINT	#52,#194,<"NEW GAME">
		BOX	#140,#184,#187,#199,#2
		PRINT	#148,#194,<"QUIT">
		BOX	#204,#184,#275,#199,#3
		PRINT	#212,#194,<"ICONIFY">
		BOX	#100,#166,#147,#181,#4
		PRINT	#108,#176,<"UNDO">
		BOX	#164,#166,#219,#181,#1
		PRINT	#172,#176,<"RETRY">
		bsr	DisplayAbout

Create_New	clr.l	Won
		bsr	New_Level
		bsr	Show_LevelA
		bsr	Show_LevelB
		move.l	#0,Move
		MESSAGE	#8,#148,<"                                     ">

Main_Event	move.l	Windowptr(pc),a0
		bsr	Get_Message
		cmp.l	#MENUPICK,d6
		beq	Do_Menu
		clr.l	d0
		move.w	gg_GadgetID(a4),d0
		cmp.l	#128,d0
		beq	Create_New
		cmp.l	#129,d0
		beq	_End
		cmp.l	#130,d0
		beq	Iconify
		cmp.l	#131,d0
		beq	Un_do
		cmp.l	#132,d0
		beq	Retry
		move.l	LevelB(pc),a0
		move.l	d0,d1
		lsl.l	#2,d1
		cmp.l	#0,(a0,d1)
		bne	IllegalMove
		movem.l	d0-d7/a0-a6,-(sp)
		move.l	Undo(pc),a1
		move.l	Move(pc),d0
		mulu	#4*64,d0
		add.l	d0,a1
		move.l	LevelB(pc),a0
		move.l	Looper(pc),d0
Copy_Level	move.l	(a0)+,(a1)+
		dbra	d0,Copy_Level
		addq.l	#1,Move
		movem.l	(sp)+,d0-d7/a0-a6
		bsr	Set
		bsr	Show_LevelB
		MESSAGE	#8,#148,<"                                     ">
		move.l	LevelA(pc),a0
		move.l	LevelB(pc),a1
		move.l	Looper(pc),d0
Compare		cmp.l	(a0)+,(a1)+
		bne	Main_Event
		dbra	d0,Compare
		MESSAGE	#8,#148,<"       --- LEVEL FINISHED ! ---      ">
		move.l	#1,Won
		bra	Main_Event

Un_do		tst.l	Move
		bne	UndoOk
		MESSAGE	#8,#148,<"         --- CAN'T UNDO !!! ---      ">
		bra	Main_Event
UndoOk		subq.l	#1,Move
		move.l	Undo(pc),a0
		move.l	Move(pc),d0
		mulu	#4*64,d0
		add.l	d0,a0
		move.l	LevelB(pc),a1
		move.l	Looper(pc),d0
ReCopy_Level	move.l	(a0)+,(a1)+
		dbra	d0,ReCopy_Level
		bsr	Show_LevelB
		bra	Main_Event

Iconify		bsr	CloseInt
		lea	AvailWindow(pc),a0
		CALLINT OpenWindow
		move.l	d0,Windowptr
		move.l	d0,a0
		move.l	wd_RPort(a0),rp

IconEvent	bsr	Show_Mem
		move.l	#25,d1
		CALLDOS Delay
		move.l	Windowptr(pc),a0
		move.l	wd_UserPort(a0),a0
		CALLEXEC GetMsg
		tst.l	d0
		beq.s	IconEvent
		move.l	d0,a1
		CALLEXEC ReplyMsg

		move.l	Windowptr(pc),a0
		CALLINT CloseWindow
		bsr	OpenInt
		BOX	#44,#184,#123,#199,#1
		PRINT	#52,#194,<"NEW GAME">
		BOX	#140,#184,#187,#199,#2
		PRINT	#148,#194,<"QUIT">
		BOX	#204,#184,#275,#199,#3
		PRINT	#212,#194,<"ICONIFY">
		BOX	#100,#166,#147,#181,#4
		PRINT	#108,#176,<"UNDO">
		BOX	#164,#166,#219,#181,#1
		PRINT	#172,#176,<"RETRY">
		bsr	Show_LevelA
		bsr	Show_LevelB
		bra	Main_Event

Show_Mem	lea	Title+2(pc),a5
		move.l	#MEMF_CHIP,d1
		CALLEXEC AvailMem
		lea	Title+2(pc),a5
		bsr	ConvertDec
		move.l	#MEMF_FAST,d1
		CALLEXEC AvailMem
		move.b	#" ",(a5)+
		move.b	#"F",(a5)+
		move.b	#":",(a5)+
		bsr.s	ConvertDec
		move.l	#MEMF_LARGEST,d1
		CALLEXEC AvailMem
		move.b	#" ",(a5)+
		move.b	#"L",(a5)+
		move.b	#":",(a5)+
		bsr.s	ConvertDec
		move.l	#0,d1
		CALLEXEC AvailMem
		move.b	#" ",(a5)+
		move.b	#"A",(a5)+
		move.b	#":",(a5)+
		bsr.s	ConvertDec
		clr.b	(a5)+
		move.l	rp(pc),a1
		move.l	#30,d0
		move.l	#7,d1
		CALLGRAF Move
		lea	Title(pc),a0
		move.l	#31,d0
		CALLGRAF Text
		rts

ConvertDec	lsr.l	#8,d0
		lsr.l	#2,d0
		move.l	#10000,d1
		moveq	#4,d2
		clr.l	d3
Convert		divu	d1,d0
		divu	#10,d1
		add.b	#"0",d0
		cmp.b	#"0",d0
		bne.s	Not_ZeroA
		tst.l	d3
		bne.s	Not_ZeroA
		move.b	#" ",d0
		bra.s	LetterOut
Not_ZeroA	move.l	#1,d3
LetterOut	move.b	d0,(a5)+
		swap	d0
		and.l	#$ffff,d0
		dbra	d2,Convert
		rts

AvailWindow	dc.w	588-(36*8-4),0,36*8-8,10
		dc.b	-1,-1
		dc.l	CLOSEWINDOW!MOUSEBUTTONS
		dc.l	SMART_REFRESH!WINDOWDRAG!WINDOWCLOSE!RMBTRAP
		dc.l	0
		dc.l	0
		dc.l	0
		dc.l	0
		dc.l	0
		dc.w	0,0,0,0
		dc.w	WBENCHSCREEN
Windowptr_1	ds.l	1

Title		dc.b	"C:"
		ds.b	38
Buffer		ds.b	16

Do_Menu		cmp.l	#MENUNULL,d7
		beq	Main_Event
		move.l	d7,d0
		and.l	#%11111,d0
		lsl.l	#2,d0
		lea	Titles(pc),a0
		move.l	(a0,d0),a0
		move.l	d7,d0
		lsr.l	#5,d0
		and.l	#%111111,d0
		lsl.l	#2,d0
		move.l	(a0,d0),a0
		jmp	(a0)

Titles		dc.l	Items1,Items2,Items2
Items1		dc.l	Calc_Size,Create_New,Retry,Un_do,Iconify,About,_End
Items2		dc.l	Main_Event,Main_Event,Main_Event,Main_Event,Main_Event,Main_Event,Main_Event
Items3		dc.l	Main_Event,Main_Event,Main_Event,Main_Event,Main_Event,Main_Event,Main_Event

About		clr.l	AboutFlag
		bsr.s	DisplayAbout
		bra	Main_Event

DisplayAbout	move.l	Screenptr(pc),ScreenptrA
		move.l	rp(pc),hrp
		tst.l	AboutFlag
		bne	AboutFail
		lea	AboutWindow(pc),a0
		CALLINT OpenWindow
		tst.l	d0
		beq	AboutFail
		move.l	d0,WindowptrA
		move.l	d0,a0
		move.l	wd_RPort(a0),rp
		move.l	#1,AboutFlag

		BOX	#0,#0,#247,#179,#0
		MESSAGE	#8+2,#8+4,<"     BRAIN Version 1.01">
		MESSAGE	#12+2,#18+8,<"© André Wichmann of CLUSTER">
		MESSAGE	#12+2,#28+8,<"  Posener Weg 4">
		MESSAGE	#12+2,#38+8,<"  5300 Bonn 1">
		MESSAGE	#12+2,#48+8,<"  West Germany">
		MESSAGE	#8+2,#68+8,<"  This game is FREEWARE and">
		MESSAGE #12+2,#78+8,<"may be copied as long as the">
		MESSAGE	#8+2,#88+8,<"  doc-file is included, the">
		MESSAGE	#8+2,#98+8,<" credits are not changed and">
		MESSAGE	#12+2,#108+8,<" - NO - profit is made with">
		MESSAGE	#12+2,#118+8,<"       distribution.">
		MESSAGE	#8+2,#138+8,<"Dedicated to all programmers">
		MESSAGE	#12+2,#148+8,<" who don't know what to do">
		MESSAGE	#8+2,#158+8,<"while assembling/compiling!">
		LINE	#247,#0,#247,#179,#6

		move.l	WindowptrA(pc),a0
		bsr	Get_Message

		move.l	WindowptrA(pc),a0
		CALLINT CloseWindow
AboutFail	move.l	hrp(pc),rp
		rts

AboutWindow	dc.w	36,10,248,180
		dc.b	-1,-1
		dc.l	MOUSEBUTTONS
		dc.l	SMART_REFRESH!ACTIVATE!BORDERLESS!RMBTRAP
		dc.l	0,0,0
ScreenptrA	ds.l	1
		dc.l	0
		dc.w	0,0,0,0
		dc.w	CUSTOMSCREEN

Calc_Size	lea	Item2_1(pc),a0
		move.l	#2,d0
Get_NewX	move.w	mi_Flags(a0),d1
		and.l	#TOGGLESELECT,d1
		tst.l	d1
		bne.s	YeahX
		move.l	(a0),a0
		addq.l	#1,d0
		bra.s	Get_NewX
YeahX		move.w	d0,XSize
		move.l	#2,d0
		lea	Item3_1(pc),a0
Get_NewY	move.w	mi_Flags(a0),d1
		and.l	#TOGGLESELECT,d1
		tst.l	d1
		bne.s	YeahY
		move.l	(a0),a0
		addq.l	#1,d0
		bra.s	Get_NewY
YeahY		move.w	d0,YSize
		clr.l	d0
		clr.l	d1
		move.w	XSize(pc),d0
		move.w	YSize(pc),d1
		move.l	d0,d2
		move.l	d1,d3
		mulu	d3,d2
		move.w	d2,Mul
		subq.l	#1,d2
		move.l	d2,Looper
		subq.l	#1,d0
		subq.l	#1,d1
		move.l	d0,XLooper
		move.l	d1,YLooper
		bra	New_Size

Retry		move.l	LevelB(pc),a0
		move.l	Looper(pc),d0
ClearB		move.l	#0,(a0)+
		dbra	d0,ClearB
		bsr	Show_LevelB
		move.l	#0,Move
		bra	Main_Event

IllegalMove	tst.l	Won
		bne	Main_Event
		MESSAGE #8,#148,<"        --- ILLEGAL MOVE ! ---       ">
		bra	Main_Event

_End
Fail_2		bsr	CloseInt
Fail_1		bsr	CloseLibs
		move.l	LevelA(pc),a1
		move.l	#4*8*8,d0
		CALLEXEC FreeMem
		move.l	LevelB(pc),a1
		move.l	#4*8*8,d0
		CALLEXEC FreeMem
		move.l	Undo(pc),a1
		move.l	#4*64*8*8,d0
		CALLEXEC FreeMem
		move.l	GadgetX(pc),a1
		move.l	#64*gg_SIZEOF,d0
		CALLEXEC FreeMem
		clr.l	d0
		rts

OpenLibs	lea	Intuitionname,a1
		clr.l	d0
		CALLEXEC OpenLibrary
		move.l	d0,_IntuitionBase
		lea	Graphicsname,a1
		clr.l	d0
		CALLEXEC OpenLibrary
		move.l	d0,_GfxBase
		lea	Dosname,a1
		clr.l	d0
		CALLEXEC OpenLibrary
		move.l	d0,_DosBase
		rts
CloseLibs	move.l	_IntuitionBase,a1
		CALLEXEC CloseLibrary
		move.l	_GfxBase,a1
		CALLEXEC CloseLibrary
		move.l	_DosBase,a1
		CALLEXEC CloseLibrary
		rts

Get_Message	move.l	a0,a5
Clear_Port	move.l	wd_UserPort(a5),a0
		CALLEXEC GetMsg
		tst.l	d0
		bne.s	Clear_Port
Wait_Event	move.l	wd_UserPort(a5),a0
		move.b	MP_SIGBIT(a0),d1
		clr.l	d0
		bset	d1,d0
		CALLEXEC Wait
		move.l	wd_UserPort(a5),a0
		CALLEXEC GetMsg
		tst.l	d0
		beq.s	Wait_Event
		move.l	d0,a1
		move.l	im_Class(a1),d6
		clr.l	d7
		move.w	im_Code(a1),d7
		move.l	im_IAddress(a1),a4
		CALLEXEC ReplyMsg
		rts

New_Level	move.l	LevelA(pc),a0
		move.l	LevelB(pc),a1
		move.l	Looper(pc),d0
ClearLvs	move.l	#0,(a0)+
		move.l	#0,(a1)+
		dbra	d0,ClearLvs
		lea	RandomTab(pc),a0
		move.l	#0,d0
SetRandom	move.l	d0,(a0)+
		addq.l	#1,d0
		cmp.w	Mul,d0
		bne.s	SetRandom
		move.l	Looper(pc),d7
		lea	RandomTab(pc),a5
SetLevelA	move.l	d7,-(sp)
Get_RND		move.w	$dff006,d0
		lsr.w	#8,d0
		move.w	$dff006,d1
		lsr.w	#1,d0
		eor.b	d1,d0
		move.w	$dff006,d1
		lsr.w	#4,d0
		eor.b	d1,d0
		and.l	#15,d0
		cmp.b	d7,d0
		bgt.s	Get_RND
		lsl.l	#2,d0
		move.l	(a5,d0),d6
		move.l	#-1,(a5,d0)
		move.l	d6,d0
		movem.l	d0-d7/a0-a6,-(sp)
		move.l	LevelA(pc),a0
		bsr.s	Set
		cmp.w	#20,Mul
		bgt.s	No_Show
		bsr	Show_LevelA
No_Show		movem.l	(sp)+,d0-d7/a0-a6
		lea	RandomTab(pc),a0
		lea	RandomTab(pc),a1
		move.l	Looper(pc),d0
ShortenTab	move.l	(a0)+,d1
		tst.l	d1
		bmi.s	No_Back
		move.l	d1,(a1)+
No_Back		dbra	d0,ShortenTab
		move.l	(sp)+,d7
		dbra	d7,SetLevelA
		bsr	Show_LevelA
		rts

Set		move.l	d0,d1
		lsl.l	#2,d0
		move.l	#1,(a0,d0)
		divu	XSize,d1
		move.l	d1,d0
		and.l	#$f,d1
		swap	d0
		and.l	#$f,d0
		move.l	d0,d2
		move.l	d1,d3
		addq.l	#1,d0
		bsr.s	Plot
		move.l	d2,d0
		move.l	d3,d1
		addq.l	#1,d1
		bsr.s	Plot
		move.l	d2,d0
		move.l	d3,d1
		subq.l	#1,d0
		bsr.s	Plot
		move.l	d2,d0
		move.l	d3,d1
		subq.l	#1,d1
		bsr.s	Plot
		rts

Plot		tst.l	d0
		bmi.s	NoPlot
		cmp.w	XSize,d0
		bge.s	NoPlot
		tst.l	d1
		bmi.s	NoPlot
		cmp.w	YSize,d1
		bge.s	NoPlot
		mulu	XSize,d1
		add.l	d1,d0
		lsl.l	#2,d0
		cmp.l	#0,(a0,d0)
		beq.s	NoPlot
		add.l	#1,(a0,d0)
		cmp.l	#4,(a0,d0)
		ble.s	NoPlot
		move.l	#1,(a0,d0)
NoPlot		rts

Show_LevelA	move.l	LevelA(pc),a5
		move.l	#0,d5
		move.l	YLooper(pc),d7
SLALoop_1	move.l	XBaseA(pc),d4
		move.l	XLooper(pc),d6
SLALoop_2	move.l	d4,d2
		move.l	d5,d3
		add.l	#15,d2
		add.l	#15,d3
		BOX	d4,d5,d2,d3,(a5)
		move.l	rp(pc),a1
		move.l	d4,d0
		move.l	d5,d1
		add.l	#4,d0
		add.l	#10,d1
		CALLGRAF Move
		move.l	(a5)+,d0
		add.b	#"0",d0
		cmp.b	#"0",d0
		bne.s	Not_Zero
		move.b	#" ",d0
Not_Zero	move.b	d0,Number
		lea	Number(pc),a0
		move.l	#1,d0
		CALLGRAF Text
		add.l	#16,d4
		dbra	d6,SLALoop_2
		add.l	#16,d5
		dbra	d7,SLALoop_1
		rts

Show_LevelB	move.l	LevelB(pc),a5
		move.l	#0,d5
		move.l	YLooper(pc),d7
SLBLoop_1	move.l	XBaseB(pc),d4
		move.l	XLooper(pc),d6
SLBLoop_2	move.l	d4,d2
		move.l	d5,d3
		add.l	#15,d2
		add.l	#15,d3
		BOX	d4,d5,d2,d3,(a5)
		move.l	rp(pc),a1
		move.l	d4,d0
		move.l	d5,d1
		add.l	#4,d0
		add.l	#10,d1
		CALLGRAF Move
		move.l	(a5)+,d0
		add.b	#"0",d0
		cmp.b	#"0",d0
		bne.s	Not_Zero2
		move.b	#" ",d0
Not_Zero2	move.b	d0,Number
		lea	Number(pc),a0
		move.l	#1,d0
		CALLGRAF Text
		add.l	#16,d4
		dbra	d6,SLBLoop_2
		add.l	#16,d5
		dbra	d7,SLBLoop_1
		rts

OpenInt		clr.l	d0
		move.w	XSize(pc),d0
		mulu	#16,d0
		mulu	#2,d0
		add.l	#16,d0
		move.l	#320,d1
		sub.l	d0,d1
		divu	#2,d1
		and.l	#$ffff,d1
		move.l	d1,XBaseA
		add.l	#16,d1
		clr.l	d0
		move.w	XSize(pc),d0
		mulu	#16,d0
		add.l	d0,d1
		move.l	d1,XBaseB
		
		move.l	GadgetX(pc),a5
		move.l	#0,d5
		move.l	YLooper(pc),d7
		move.l	#0,d3
Build_1		move.l	XBaseB(pc),d4
		move.l	XLooper(pc),d6
Build_2		move.l	a5,(a5)
		add.l	#gg_SIZEOF,(a5)+
		move.w	d4,(a5)+
		move.w	d5,(a5)+
		move.w	#16,(a5)+
		move.w	#16,(a5)+
		move.w	#GADGHCOMP,(a5)+
		move.w	#RELVERIFY,(a5)+
		move.w	#BOOLGADGET,(a5)+
		move.l	#0,(a5)+
		move.l	#0,(a5)+
		move.l	#0,(a5)+
		move.l	#0,(a5)+
		move.l	#0,(a5)+
		move.w	d3,(a5)+
		move.l	#0,(a5)+
		addq.w	#1,d3
		add.w	#16,d4
		dbra	d6,Build_2
		add.w	#16,d5
		dbra	d7,Build_1
		sub.l	#gg_SIZEOF,a5
		move.l	#0,(a5)

		clr.l	Screenptr
		lea	Screen_1(pc),a0
		CALLINT OpenScreen
		tst.l	d0
		beq.s	NoScreen
		move.l	d0,Screenptr
		move.l	d0,a0
		add.l	#44,a0
		lea	Colortable(pc),a1
		move.l	#8,d0
		CALLGRAF LoadRGB4
		lea	Window_1(pc),a0
		CALLINT OpenWindow
		tst.l	d0
		beq.s	NoWindow
		move.l	d0,Windowptr
		move.l	d0,a0
		move.l	wd_RPort(a0),rp
		move.l	Windowptr(pc),a0
		lea	Menu1(pc),a1
		CALLINT SetMenuStrip
		rts
NoWindow	move.l	Screenptr(pc),a0
		CALLINT CloseScreen
		clr.l	Screenptr
NoScreen	rts

CloseInt	tst.l	Windowptr
		beq.s	No_IntClose
		move.l	Windowptr(pc),a0
		CALLINT CloseWindow
		move.l	Screenptr(pc),a0
		CALLINT CloseScreen
		clr.l	Screenptr
		clr.l	Windowptr
No_IntClose	rts

Print_text	clr.l	d0
		move.l	a0,a2
Count_Letters	cmp.b	#0,(a2)
		beq.s	Found_Zero
		addq.l	#1,d0
		addq.l	#1,a2
		bra.s	Count_Letters
Found_Zero	CALLGRAF Text
		rts

Screen_1	dc.w	0,0,320,200,3
		dc.b	0,1
		dc.w	0,CUSTOMSCREEN
		dc.l	Topaz_80,0,0,0

Topaz_80	dc.l	T80_Name
		dc.w	TOPAZ_EIGHTY
		dc.b	FS_NORMAL
		dc.b	FPF_ROMFONT
T80_Name	dc.b	"topaz.font",0
		EVEN

Window_1	dc.w	0,0,320,200
		dc.b	-1,-1
		dc.l	GADGETUP!GADGETDOWN!MENUPICK
		dc.l	SMART_REFRESH!ACTIVATE!BORDERLESS
		dc.l	Gadget0
		dc.l	0,0
Screenptr	ds.l	1
		dc.l	0
		dc.w	0,0,0,0
		dc.w	CUSTOMSCREEN
Gadget0		BOOLGAD	Gadget1,44,184,80,16,128
Gadget1		BOOLGAD	Gadget2,140,184,48,16,129
Gadget2		BOOLGAD Gadget3,204,184,72,16,130
Gadget3		BOOLGAD Gadget4,100,166,48,16,131
Gadget4		BOOLGAD GadgetX,164,166,56,16,132

Menu1		MENU	Menu2,16,0,80,12,Item1_1,<"Project   ">
Item1_1		ITEM	Item1_2,0,0,80,12,0,0,<"New Size  ">
Item1_2		ITEM	Item1_3,0,12,80,12,0,0,<"New Game  ">
Item1_3		ITEM	Item1_4,0,24,80,12,0,0,<"New Try   ">
Item1_4		ITEM	Item1_5,0,36,80,12,0,0,<"Undo      ">
Item1_5		ITEM	Item1_6,0,48,80,12,0,0,<"Iconify   ">
Item1_6		ITEM	Item1_7,0,60,80,12,0,0,<"About...  ">
Item1_7		ITEM	0,0,72,80,12,0,0,<"Quit      ">
Menu2		MENU	Menu3,112,0,64,12,Item2_1,<"X-Size  ">
Item2_1		EXCLUDE Item2_2,0,0,64,12,0,%1111110,<"   2    ">
Item2_2		EXCLUDE Item2_3,0,12,64,12,TOGGLESELECT,%1111101,<"   3    ">
Item2_3		EXCLUDE Item2_4,0,24,64,12,0,%1111011,<"   4    ">
Item2_4		EXCLUDE Item2_5,0,36,64,12,0,%1110111,<"   5    ">
Item2_5		EXCLUDE Item2_6,0,48,64,12,0,%1101111,<"   6    ">
Item2_6		EXCLUDE Item2_7,0,60,64,12,0,%1011111,<"   7    ">
Item2_7		EXCLUDE 0,0,72,64,12,0,%0111111,<"   8    ">
Menu3		MENU	0,192,0,64,12,Item3_1,<"Y-Size  ">
Item3_1		EXCLUDE Item3_2,0,0,64,12,0,%1111110,<"   2    ">
Item3_2		EXCLUDE Item3_3,0,12,64,12,TOGGLESELECT,%1111101,<"   3    ">
Item3_3		EXCLUDE Item3_4,0,24,64,12,0,%1111011,<"   4    ">
Item3_4		EXCLUDE Item3_5,0,36,64,12,0,%1110111,<"   5    ">
Item3_5		EXCLUDE Item3_6,0,48,64,12,0,%1101111,<"   6    ">
Item3_6		EXCLUDE Item3_7,0,60,64,12,0,%1011111,<"   7    ">
Item3_7		EXCLUDE 0,0,72,64,12,0,%0111111,<"   8    ">

		SECTION	"Brain",DATA

XSize		dc.w	3
YSize		dc.w	3
Looper		dc.l	3*3-1
Mul		dc.w	3*3
XLooper		dc.l	3-1
YLooper		dc.l	3-1
Colortable	dc.w	$000,$a00,$00a,$808,$066,$999,$333,$bbb
Spaces		dc.b	"                                     ",0
		EVEN
Intuitionname	dc.b	"intuition.library",0
		EVEN
Graphicsname	dc.b	"graphics.library",0
		EVEN
Dosname		dc.b	"dos.library",0
		EVEN

		SECTION	"Brain",BSS

Windowptr	ds.l	1
rp		ds.l	1
Won		ds.l	1
XBaseB		ds.l	1
XBaseA		ds.l	1
Move		ds.l	1
LevelA		ds.l	1
LevelB		ds.l	1
Undo		ds.l	1
GadgetX		ds.l	1
Number		ds.l	1
RandomTab	ds.l	10*10
_IntuitionBase	ds.l	1
_GfxBase	ds.l	1
_DosBase	ds.l	1
hrp		ds.l	1
AboutFlag	ds.l	1
WindowptrA	ds.l	1

