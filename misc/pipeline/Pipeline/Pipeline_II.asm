		opt	c-,d-,o1+,o2+,ow-,l+

*
*   PIPELINE II
*
*   Written by André Wichmann of CLUSTER in Mar-Apr 1990
*
*   Concept: EMPIRE       (Pipe Mania/Pipe Dream)
*            MASTERTRONIC (Locomotion or something like that)
*
*   This program is FREEWARE ! For further information read the doc-file !
*
*   Improvements made from 14/08/90 to 22/08/90
*   Last update made on 10/12/90
*

		incdir	"RAM:include/"
		include	"exec/exec_lib.i"
		include	"Libraries/dos_lib.i"

*** Equates

		XREF	_Intro		Link it with 'Intro.o'

DMACONR		equ	$DFF002
JOY0DAT		equ	$DFF00A
JOY1DAT		equ	$DFF00C
BLTCON0		equ	$DFF040
BLTCON1		equ	$DFF042
BLTAFWM		equ	$DFF044
BLTALWM		equ	$DFF046
BLTCPTH		equ	$DFF048
BLTBPTH		equ	$DFF04C
BLTAPTH		equ	$DFF050
BLTDPTH		equ	$DFF054
BLTSIZE		equ	$DFF058
BLTCMOD		equ	$DFF060
BLTBMOD		equ	$DFF062
BLTAMOD		equ	$DFF064
BLTDMOD		equ	$DFF066
DIWSTRT		equ	$DFF08E
DIWSTOP		equ	$DFF090
DDFSTRT		equ	$DFF092
DDFSTOP		equ	$DFF094
BPL1PTH		equ	$DFF0E0
BPL1PTL		equ	$DFF0E2
BPL2PTH		equ	$DFF0E4
BPL2PTL		equ	$DFF0E6
BPL3PTH		equ	$DFF0E8
BPL3PTL		equ	$DFF0EA
BPL4PTH		equ	$DFF0EC
BPL4PTL		equ	$DFF0EE
BPL5PTH		equ	$DFF0F0
BPL5PTL		equ	$DFF0F2
BPL6PTH		equ	$DFF0F4
BPL6PTL		equ	$DFF0F6
BPL1MOD		equ	$DFF108
BPL2MOD		equ	$DFF10A
BPLCON0		equ	$DFF100
BPLCON1		equ	$DFF102
BPLCON2		equ	$DFF104
DMACONW		equ	$DFF096
DMACON		equ	$DFF096
COLOR00		equ	$DFF180
VHPOSR		equ	$DFF006
CIAAPRA		equ	$BFE001
STARTLIST	equ	38
COP1LC		equ	$DFF080
COPJMP1		equ	$DFF088
SPR0DAT		equ	$DFF144
CHIP		equ	$10002
Planesize	equ	256*40
Planes		equ	5
CLsize		equ	1000*4

*** Macros


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

MPRINT		MACRO
		move.l	#1,Text_Flag
		move.l	#3,Text_Delay
		move.l	Plane0,a1
		add.l	#\1*Planesize,a1
		add.l	#\2+\3*40,a1
		lea	\4,a0
		bsr	Print_Text
		ENDM

PRINT		MACRO
		move.l	Plane0,a1
		add.l	#\1*Planesize,a1
		add.l	#\2+\3*40,a1
		lea	\4,a0
		bsr	Print_Text
		ENDM

		SECTION	"Pipeline",CODE_C

***** Main *****

		include "Libraries/Dosextens.i"
	
		movem.l	d0/a0,-(sp)
		clr.l	_WBenchMsg
		sub.l	a1,a1
		CALLEXEC FindTask
		move.l	d0,a4
		tst.l	pr_CLI(a4)
		beq	_WB
		movem.l	(sp)+,d0/a0
		bra	_run
_WB		lea	pr_MsgPort(a4),a0
		CALLEXEC WaitPort
		lea	pr_MsgPort(a4),a0
		CALLEXEC GetMsg
		move.l	d0,_WBenchMsg
		movem.l	(sp)+,d0/a0
_run		jsr	_Intro
		bsr	_main
		move.l	d0,-(sp)
		tst.l	_WBenchMsg
		beq	_Exit
		CALLEXEC Forbid
		move.l	_WBenchMsg(pc),a1
		CALLEXEC ReplyMsg
_Exit		move.l	(sp)+,d0
		rts

_WBenchMsg	ds.l	1

_Main		bsr	OpenLibs
		sub.l	a1,a1
		CALLEXEC FindTask
		move.l	d0,a0
		move.l	pr_WindowPtr(a0),OldWindow
		move.l	#-1,pr_WindowPtr(a0)
		ALLOC	Planesize*4,CHIP
		move.l	d0,PlayPic
		ALLOC	18*4*2*16,CHIP
		move.l	d0,PlayObj
		ALLOC	48*2*16,CHIP
		move.l	d0,PlayFloat
		ALLOC	512,CHIP
		move.l	d0,PlayFont
		ALLOC	3*130*40,CHIP
		move.l	d0,PipeCluster
		ALLOC	4*232*40,CHIP
		move.l	d0,PipeLogo
		move.l	#Filen_0,d1
		move.l	#1005,d2
		CALLDOS Open
		move.l	d0,d7
		move.l	d7,d1
		move.l	PlayPic,d2
		move.l	#Planesize*4,d3
		CALLDOS Read
		move.l	d7,d1
		CALLDOS Close
		move.l	#Filen_1,d1
		move.l	#1005,d2
		CALLDOS Open
		move.l	d0,d7
		move.l	d7,d1
		move.l	PlayObj,d2
		move.l	#18*4*2*16,d3
		CALLDOS Read
		move.l	d7,d1
		CALLDOS Close
		move.l	#Filen_2,d1
		move.l	#1005,d2
		CALLDOS Open
		move.l	d0,d7
		move.l	d7,d1
		move.l	PlayFloat,d2
		move.l	#48*2*16,d3
		CALLDOS Read
		move.l	d7,d1
		CALLDOS Close
		move.l	#Filen_3,d1
		move.l	#1005,d2
		CALLDOS Open
		move.l	d0,d7
		move.l	d7,d1
		move.l	PlayFont,d2
		move.l	#512,d3
		CALLDOS Read
		move.l	d7,d1
		CALLDOS Close
		move.l	#Filen_4,d1
		move.l	#1005,d2
		CALLDOS Open
		move.l	d0,d7
		move.l	d7,d1
		move.l	PipeCluster,d2
		move.l	#3*130*40,d3
		CALLDOS Read
		move.l	d7,d1
		CALLDOS Close
		move.l	#Filen_5,d1
		move.l	#1005,d2
		CALLDOS Open
		move.l	d0,d7
		move.l	d7,d1
		move.l	PipeLogo,d2
		move.l	#4*232*40,d3
		CALLDOS Read
		move.l	d7,d1
		CALLDOS Close
		move.l	#Filen_6,d1
		move.l	#1005,d2
		CALLDOS Open
		tst.l	d0
		beq	No_Highscores
		move.l	d0,d7
		move.l	d7,d1
		move.l	#HOF,d2
		move.l	#240,d3
		CALLDOS Read
		move.l	d7,d1
		CALLDOS Close
No_Highscores	move.l	#200,d1
		CALLDOS Delay
		bset.b	#1,$bfe001
		jsr	Start_Muzak
		move.l	#2,Difficulty

Title		ALLOC	Planesize*Planes,CHIP
		move.l 	d0,Plane0
		ALLOC	CLSize,CHIP
		move.l	d0,CLadr
		move.l	d0,a0
		move.l	Plane0,d1
		move.w	#BPL1PTH-$DFF000,d3
		move.w	#Planes-1,d4
Make_CL		move.w 	d3,(a0)+
		addq.w	#2,d3
		swap	d1
		move.w	d1,(a0)+
		move.w	d3,(a0)+
		addq.w	#2,d3
		swap 	d1
		move.w	d1,(a0)+
		add.l	#Planesize,d1
		dbra	d4,Make_CL
		move.w	#$180,(a0)+
		move.w	#0,(a0)+
		move.l	a0,Target
		move.l	#$fffffffe,(a0)
		
		CALLEXEC Forbid
		move.w	#%0000000111100000,DMACONW
		clr.l	SPR0DAT
		move.l	CLAdr,COP1LC
		clr.w	COPJMP1
		move.w	#$3081,DIWSTRT
		move.w 	#$30c1,DIWSTOP
		move.w  #$0038,DDFSTRT
		move.w  #$00d0,DDFSTOP
		move.w  #%0101000000000000,BPLCON0
		clr.w	BPLCON1
		clr.w	BPLCON2
		clr.w	BPL1MOD
		clr.w	BPL2MOD
		move.w	#%1000011111011111,DMACONW

Title_Loop	bsr	Clear_Colors
		move.l	Target,a0
		move.l	#$fffffffe,(a0)
		move.l	PipeLogo,a0
		move.l	Plane0,a1
		move.l	#3,d7
Show_Logo_1	move.l	a1,a2
		move.l	#232*40-1,d6
Show_Logo_2	move.b	(a0)+,(a2)+
		dbra	d6,Show_Logo_2
		add.l	#Planesize,a1
		dbra	d7,Show_Logo_1

		PRINT	4,0,10,HOFText
		lea	HOFBuffer,a0
		move.l	#39,d0
Clear_HOFB	move.b	#" ",(a0)+
		dbra	d0,Clear_HOFB

		lea	HOF,a5
		move.l	#42*40,d6
		move.l	#9,d7
Show_High	move.l	(a5)+,d2
		movem.l	d6/d7/a5,-(sp)
		bsr	BinDec
		movem.l	(sp)+,d6/d7/a5
		lea	HOFBuffer+4,a1
		lea	Dec_Buffer+1,a0
		move.l	#6,d0
Copy_Score	move.b	(a0)+,(a1)+
		dbra	d0,Copy_Score
		move.b	#" ",(a1)+
		move.b	#" ",(a1)+
		move.b	#" ",(a1)+
		move.l	#19,d0
Copy_Name	move.b	(a5)+,(a1)+
		dbra	d0,Copy_Name
		move.b	#0,(a1)+
		movem.l	d6/d7/a5,-(sp)
		move.l	Plane0,a1
		add.l	#4*Planesize,a1
		add.l	d6,a1
		lea	HOFBuffer,a0
		bsr	Print_Text
		movem.l	(sp)+,d6/d7/a5
		add.l	#16*40,d6
		dbra	d7,Show_High

		lea	TitleCols_1,a5
		bsr	Fade_In

		move.l	#8,d6
TWait1_2	move.l	#$ffff,d7
TWait_1		btst	#7,$BFE001
		beq	StartGame1
		btst	#6,$BFE001
		beq	EndGame1
		dbra	d7,TWait_1
		dbra	d6,TWait1_2

		lea	TitleCols_1,a5
		bsr	Fade_Out

		bsr	Clear_Colors
		move.l	Plane0,a1
		move.l	#5*Planesize-1,d0
ClearTPlanes	move.b	#0,(a1)+
		dbra	d0,ClearTPlanes

		move.l	Target,a0
		move.w	#$400f,d1
		move.w	#$0000,d2
		move.l	#15,d0
Spreadloop_1	move.w	d1,(a0)+
		move.w	#$fffe,(a0)+
		move.w	#$1a0,(a0)+
		move.w	d2,(a0)+
		add.w	#$0110,d2
		add.w	#$0200,d1
		dbra	d0,Spreadloop_1
		move.w	#$d00f,d1
		move.w	#$0ff0,d2
		move.l	#15,d0
Spreadloop_2	move.w	d1,(a0)+
		move.w	#$fffe,(a0)+
		move.w	#$1a0,(a0)+
		move.w	d2,(a0)+
		sub.w	#$0110,d2
		add.w	#$0200,d1
		dbra	d0,Spreadloop_2

		move.l	#$fffffffe,(a0)

		move.l	PipeCluster,a0
		move.l	Plane0,a1
		add.l	#40*40,a1
		move.l	#2,d7
Show_Logo_3	move.l	a1,a2
		move.l	#130*40-1,d6
Show_Logo_4	move.b	(a0)+,(a2)+
		dbra	d6,Show_Logo_4
		add.l	#Planesize,a1
		dbra	d7,Show_Logo_3
		lea	TitleCols_2,a5
		bsr	Fade_In

		move.l	#Scroll,Scrollptr
		move.l	#1,Scrflag
		bsr	Wait_Blt
		move.w	#$ffff,BLTAFWM
		move.w	#$ffff,BLTALWM
		clr.w	BLTCON1
		move.w	#%0000100111110000,BLTCON0

TwoLoop_1	move.l	#2,d1
		move.b	#$ff,d2
TwoLoop_2	move.w	VHPOSR,d0
		lsr.w	#8,d0
		cmp.b	d2,d0
		bne	TwoLoop_2
		subq.l	#1,d2
		dbra	d1,TwoLoop_2

		move.l	Plane0,a0
		add.l	#4*Planesize,a0
		add.l	#20*40,a0
		move.l	a0,BLTDPTH
		add.l	#1*40,a0
		move.l	a0,BLTAPTH
		clr.w	BLTAMOD
		clr.w	BLTDMOD
		move.w	#180*64+20,BLTSIZE
		bsr	Wait_Blt
		btst	#7,$BFE001
		beq	StartGame2
		btst	#6,$BFE001
		beq	EndGame2
		subq.l	#1,Scrflag
		tst.l	Scrflag
		bne	TwoLoop_1
		move.l	#8,Scrflag
		move.l	Scrollptr,a0
		lea	HOFBuffer,a1
		move.l	#39,d0
CopyLine	move.b	(a0)+,(a1)+
		dbra	d0,CopyLine
		move.b	#0,(a1)
		move.l	Plane0,a1
		add.l	#4*Planesize,a1
		add.l	#190*40,a1
		lea	HOFBuffer,a0
		bsr	Print_text
		add.l	#40,Scrollptr
		move.l	Scrollptr,a0
		cmp.b	#0,(a0)
		bne	TwoLoop_1

		lea	TitleCols_2,a5
		bsr	Fade_Out
		bra	Title_Loop

Wait_Blt	btst	#14,DMACONR
		bne	Wait_Blt
		rts

StartGame1	lea	TitleCols_1,a5
		bsr	Fade_Out
		bra	StartGame

EndGame1	lea	TitleCols_1,a5
		bsr	Fade_Out
		bra	EndGame

StartGame2	move.l	Target,a0
		move.l	#$fffffffe,(a0)
		lea	TitleCols_2,a5
		bsr	Fade_Out
		bra	StartGame

EndGame2	move.l	Target,a0
		move.l	#$fffffffe,(a0)
		lea	TitleCols_2,a5
		bsr	Fade_Out
		bra	EndGame

StartGame	move.w	#$7fff,DMACONW
		move.w	#%1000011011110000,DMACONW
		CALLEXEC Permit
		FREE	CLAdr,CLSize
		FREE	Plane0,Planesize*Planes

		clr.l	Play_Level
		clr.l	Score
Play_Loop	addq.l	#1,Play_Level
		bsr	Play
		cmp.l	#1,Status
		beq	Over
		bsr	Good
		bra	Play_Loop

Clear_Colors	lea	$DFF180,a0
		move.l	#31,d0
SetColos_1	move.w	#0,(a0)+
		dbra	d0,SetColos_1
		rts

EndGame		jsr	stop_muzak
		bclr.b	#1,$bfe001
		move.l	_GfxBase,a4
		move.l	STARTLIST(a4),COP1LC
		clr.w	COPJMP1
		move.w	#%1000011111111111,DMACONW
		CALLEXEC Permit
		FREE	CLAdr,CLSize
		FREE	Plane0,Planesize*Planes
		FREE	PlayPic,Planesize*4
		FREE	PlayObj,18*4*2*16
		FREE	PlayFloat,48*2*16
		FREE	PlayFont,512
		FREE	PipeCluster,3*130*40
		FREE	PipeLogo,4*232*40
		sub.l	a1,a1
		CALLEXEC FindTask
		move.l	d0,a0
		move.l	OldWindow,pr_WindowPtr(a0)
		clr.l	d0
		rts

*** Fade in with Colortable in ^a5 ***

Fade_In		lea	Hilftab,a0
		move.l	#31,d0
Clear_Tab	clr.w	(a0)+
		dbra	d0,Clear_Tab
		move.l	#15,d7
Fade_Loop_1	lea	Hilftab,a4
		move.l	a5,a3
		lea	Color00,a0
		move.l	#31,d0
Fade_Loop_2	move.w	(a4),(a0)+
		move.w	(a4),d1
		and.l	#15,d1
		move.w	(a3),d2
		and.l	#15,d2
		cmp.l	d1,d2
		beq	No_Increase_1
		addq.w	#1,(a4)
No_Increase_1	move.w	(a4),d1
		and.l	#%11110000,d1
		move.w	(a3),d2
		and.l	#%11110000,d2
		cmp.l	d1,d2
		beq	No_Increase_2
		add.w	#16,(a4)
No_Increase_2	move.w	(a4),d1
		and.l	#%111100000000,d1
		move.w	(a3),d2
		and.l	#%111100000000,d2
		cmp.l	d1,d2
		beq	No_Increase_3
		add.w	#256,(a4)
No_Increase_3	addq.l	#2,a4
		addq.l	#2,a3
		dbra	d0,Fade_Loop_2
		move.l	#$3fff,d0
Fade_Delay	dbra	d0,Fade_Delay
		dbra	d7,Fade_Loop_1
		rts

*** Fade out with Colortable in ^a5 ***

Fade_Out	lea	Hilftab,a0
		move.l	#31,d0
Copy_Tab	move.w	(a5)+,(a0)+
		dbra	d0,Copy_Tab
		move.l	#15,d7
FadeOut_Loop_1	lea	HilfTab,a0
		move.l	#31,d0
FadeOut_Loop_2	move.w	(a0),d1
		and.l	#15,d1
		tst.l	d1
		beq	No_Decrease_1
		sub.w	#1,(a0)
No_Decrease_1	move.w	(a0),d1
		lsr.w	#4,d1
		and.l	#15,d1
		tst.l	d1
		beq	No_Decrease_2
		sub.w	#16,(a0)
No_Decrease_2	move.w	(a0),d1
		lsr.w	#8,d1
		and.l	#15,d1
		tst.l	d1
		beq	No_Decrease_3
		sub.w	#256,(a0)
No_Decrease_3	addq.l	#2,a0
		dbra	d0,FadeOut_Loop_2
		lea	HilfTab,a0
		lea	$DFF180,a1
		move.l	#31,d0
FadeOut_Loop_3	move.w	(a0)+,(a1)+
		dbra	d0,FadeOut_Loop_3
		move.l	#$3fff,d0
FadeOut_Delay	dbra	d0,FadeOut_Delay
		dbra	d7,FadeOut_Loop_1
		rts

HilfTab		ds.w	32

***** Play a Level *****

Play	
		bsr	Get_Ready
		move.l	#3,d0
		sub.l	Difficulty,d0
		move.l	d0,Deleters
		ALLOC	Planesize*Planes,CHIP
		move.l 	d0,Plane0
		move.l	PlayPic,a0
		move.l	Plane0,a1
		move.l	#Planesize*4-1,d0
Copy_PlayPic	move.b	(a0)+,(a1)+
		dbra	d0,Copy_PlayPic
		ALLOC	CLSize,CHIP
		move.l	d0,CLadr
		move.l	d0,a0
		move.l	Plane0,d1
		move.w	#BPL1PTH-$DFF000,d3
		move.w	#Planes-1,d4
MakeCL		move.w 	d3,(a0)+
		addq.w	#2,d3
		swap	d1
		move.w	d1,(a0)+
		move.w	d3,(a0)+
		addq.w	#2,d3
		swap 	d1
		move.w	d1,(a0)+
		add.l	#Planesize,d1
		dbra	d4,MakeCL
		move.l	#$fffffffe,(a0)
		move.l	a0,Target

		CALLEXEC Forbid
		
		move.w	#%0000000111100000,DMACONW
		clr.l	SPR0DAT
		move.l	CLAdr,COP1LC
		clr.w	COPJMP1
		move.w	#$3081,DIWSTRT
		move.w 	#$30c1,DIWSTOP
		move.w  #$0038,DDFSTRT
		move.w  #$00d0,DDFSTOP
		move.w  #%0101000000000000,BPLCON0
		clr.w	BPLCON1
		clr.w	BPLCON2
		clr.w	BPL1MOD
		clr.w	BPL2MOD
		move.w	#%1000011111011111,DMACONW
		bsr	Clear_Colors

*** Init

No_deleters	move.l	Plane0,a0
		add.l	#4*Planesize,a0
		add.l	#7*16*40+120,a0
		move.l	#64,d0
Create_Time	move.w	#%0000001111111111,(a0)
		move.w	#%1111111111000000,2(a0)
		add.l	#40,a0
		dbra	d0,Create_Time
		clr.l	Time
		move.l	#8,Time_Split
		clr.l	Float_Flag
		clr.l	Status
		move.l	#4,Splitter
		clr.l	FinishFlag
		clr.l	EscFlag

		lea	Level,a0
		lea	Special,a1
		lea	Floats,a2
		move.l	#16*10-1,d0
Clear_Level	clr.b	(a0)+
		clr.b	(a1)+
		clr.b	(a2)+
		dbra	d0,Clear_Level

		move.l	Play_Level,d7
		move.l	d7,d6
		lsr.l	#1,d6
		add.l	d6,d7
		cmp.l	#45,d7
		blt.s	OkiDoki_1
		move.l	#45,d7
OkiDoki_1	subq.l	#1,d7
Set_Walls	bsr	RND
		and.l	#15,d0
		move.l	d0,d6
Get_Wall_Y	bsr	RND
		and.l	#15,d0
		cmp.l	#9,d0
		bhi	Get_Wall_Y
		move.l	d0,d1
		move.l	d6,d0
		lea	Level,a0
		add.l	d0,a0
		mulu	#16,d1
		add.l	d1,a0
		move.b	#16,(a0)
		dbra	d7,Set_Walls

		move.l	Play_Level,d7
		move.l	d7,d6
		lsr.l	#2,d6
		add.l	d6,d7
		cmp.l	#40,d7
		blt.s	OkiDoki_2
		move.l	#50,d7
OkiDoki_2	subq.l	#1,d7
Set_Specials	bsr	RND
		and.l	#15,d0
		move.l	d0,d6
Get_Special_Y	bsr	RND
		and.l	#15,d0
		cmp.l	#9,d0
		bhi	Get_Special_Y
		move.l	d0,d1
		move.l	d6,d0
		lea	Special,a0
		lea	Level,a1
		add.l	d0,a0
		mulu	#16,d1
		add.l	d1,a0
		add.l	d0,a1
		add.l	d1,a1
		tst.b	(a1)
		bne	Set_Specials
		bsr	RND
		and.l	#3,d0
		bset	#6,d0
		move.b	d0,(a0)
		dbra	d7,Set_Specials

Get_Start_X	bsr	RND
		and.l	#15,d0
		beq	Get_Start_X
		cmp.l	#15,d0
		beq	Get_Start_X
		move.l	d0,Start_X
		move.l	d0,Crsr_X
Get_Start_Y	bsr	RND
		and.l	#15,d0
		beq	Get_Start_Y
		cmp.l	#8,d0
		bhi	Get_Start_Y
		move.l	d0,Start_Y
		move.l	d0,Crsr_Y
Get_Start_Dir	bsr	RND
		and.l	#3,d0
		move.l	d0,Float_Dir
		move.l	d0,d1
		lea	Level,a0
		add.l	Start_X,a0
		move.l	Start_Y,d0
		mulu	#16,d0
		add.l	d0,a0
		move.b	#17,(a0)
		clr.b	-17(a0)
		clr.b	-16(a0)
		clr.b	-15(a0)
		clr.b	-1(a0)
		clr.b	1(a0)
		clr.b	15(a0)
		clr.b	16(a0)
		clr.b	17(a0)
		lea	Special,a0
		add.l	Start_X,a0
		move.l	Start_Y,d0
		mulu	#16,d0
		add.l	d0,a0
		move.b	d1,(a0)
		move.l	Start_X,Float_X
		move.l	Start_Y,Float_Y
		clr.l	Float_Count
		clr.l	Float_Pointer
		clr.l	Float_Math
		clr.l	Joy_Revers

		lea	Level,a0
		lea	Special,a1
		move.l	#0,d1
Show_Lines	move.l	#0,d0
Show_Field	tst.b	(a0)
		bne	Show_Wall
		tst.b	(a1)
		bne	Show_Special
Next_Show	addq.l	#1,a0
		addq.l	#1,a1
		addq.l	#1,d0
		cmp.l	#16,d0
		bne	Show_Field
		addq.l	#1,d1
		cmp.l	#10,d1
		bne	Show_Lines
		bra	Continue
Show_Wall	movem.l	d0-d7/a0-a6,-(sp)
		move.l	#13,d2
		bsr	Show_Obj
		movem.l	(sp)+,d0-d7/a0-a6
		bra	Next_Show
Show_Special	movem.l	d0-d7/a0-a6,-(sp)
		move.l	#14,d2
		add.b	(a1),d2
		bclr	#6,d2
		bsr	Show_Obj
		movem.l	(sp)+,d0-d7/a0-a6
		bra	Next_Show

Continue	move.l	#9,d2
		add.l	Float_Dir,d2
		move.l	Start_X,d0
		move.l	Start_Y,d1
		bsr	Show_Obj
		bsr	Set_Crsr

		lea	Next,a0
		move.l	#4,d7
Get_Next	bsr	RND
		and.l	#7,d0
		beq	Get_Next
		move.b	d0,(a0)+
		dbra	d7,Get_Next
		bsr	Display_Next

		PRINT	4,1,195,Status_text
		move.l	Play_Level,d2
		bsr	BinDec
		PRINT	4,36,195,Dec_Buffer+6
		clr.l	Num_Specials
		move.l	HOF,d2
		bsr	BinDec
		PRINT	4,21,195,Dec_Buffer+1

		move.l	Target,a0
		move.w	#$ffdd,(a0)+
		move.w	#$fffe,(a0)+
		lea	BonusColors,a1
		move.l	#7,d0
		move.l	#$000f,d1
Set_Bonuscolors	move.w	d1,(a0)+
		move.w	#$fffe,(a0)+
		move.w	#$184,(a0)+
		move.w	(a1)+,(a0)+
		add.w	#$0100,d1
		dbra	d0,Set_Bonuscolors
		move.l	#$fffffffe,(a0)

		lea	Colors,a5
		bsr	Fade_In

Wait		bsr	Show_Score
		bsr	Check_Joy
		bsr	Sub_Time
		bsr	Float
		bsr	Delay
		tst.l	Status
		bne	LevelFinished
		cmp.l	#65,Time
		bge	Level_Ready
		btst	#6,$bfe001
		beq	Pausemode
		move.b	$BFEC01,d0
		cmp.b	#$75,d0
		beq	FastFlowOn
		bra	Wait

FastFlowOn	move.l	#1,EscFlag
		bra	Wait

Game_Fail
Level_Ready
		move.l	#1,FinishFlag
		bra	Wait
LevelFinished	move.l	Target,a0
		move.l	#$fffffffe,(a0)
		lea	Colors,a5
		bsr	Fade_Out
		move.w	#$7fff,DMACONW
		move.w	#%1000011011110000,DMACONW
		CALLEXEC Permit
		FREE	CLAdr,CLSize
		FREE	Plane0,Planesize*Planes
		rts
	
***** Subs *****

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

Intuitionname	dc.b	"intuition.library",0
		EVEN
Graphicsname	dc.b	"graphics.library",0
		EVEN
Dosname		dc.b	"dos.library",0
		EVEN
_IntuitionBase	ds.l	1
_GfxBase	ds.l	1
_DosBase	ds.l	1

Pausemode	btst	#6,$bfe001
		beq	Pausemode
pauseloop	btst	#6,$bfe001
		bne	Pauseloop
Pauseloop_2	btst	#6,$bfe001
		beq	Pauseloop_2
		bra	Wait

Over		bsr	Clear_Colors
		bsr	Create_Playfield
		lea	GO,a0
		move.l	Plane0,a1
		add.l	#8*40+5,a1
		move.l	#2,d0
go_1		move.l	a1,a2
		move.l	#49,d1
go_2		move.l	a2,a3
		move.l	#29,d2
go_3		move.b	(a0)+,(a3)+
		dbra	d2,go_3
		add.l	#40,a2
		dbra	d1,go_2
		add.l	#Planesize,a1
		dbra	d0,go_1
		lea	GR_Cols,a5
		bsr	Fade_in
		move.l	Target,a0
		move.l	#$800f,d1
		move.l	#$008,d2
		move.l	#$002,d3
		bsr	Rohr
		move.l	#$900f,d1
		move.l	#$888,d2
		move.l	#$222,d3
		bsr	Rohr
		move.l	#$a00f,d1
		move.l	#$080,d2
		move.l	#$020,d3
		bsr	Rohr
		move.l	#$b00f,d1
		move.l	#$800,d2
		move.l	#$200,d3
		bsr	Rohr
		move.l	#$c00f,d1
		move.l	#$880,d2
		move.l	#$220,d3
		bsr	Rohr
		move.l	#$d00f,d1
		move.l	#$880,d2
		move.l	#$220,d3
		bsr	Rohr
		move.l	#$e00f,d1
		move.l	#$880,d2
		move.l	#$220,d3
		bsr	Rohr
		move.w	#$184,(a0)+
		move.w	#$ff0,(a0)+
		move.l	#$fffffffe,(a0)
		PRINT	1,0,80,Overtext_2
		move.l	Score,d2
		bsr	BinDec
		lea	Dec_Buffer+1,a0
		lea	Overtext_9+22,a1
		move.l	#6,d0
Overscore	move.b	(a0)+,(a1)+
		dbra	d0,Overscore
		PRINT	1,0,96,Overtext_9
		move.l	Score,d1
		lea	HOF,a0
		move.l	#0,d0
Compare_Scores	move.l	(a0)+,d2
		add.l	#20,a0
		cmp.l	d1,d2
		blt	Highscore
		addq.l	#1,d0
		cmp.l	#10,d0
		bne	Compare_Scores
		PRINT	1,0,112,Overtext_4
		bra	Overwait
Highscore	sub.l	#24,a0
		cmp.l	#9,d0
		beq	No_Trans
		lea	HOF+9*24,a1
		move.l	#9,d1
Transfer	move.l	-24(a1),(a1)
		move.l	-20(a1),4(a1)
		move.l	-16(a1),8(a1)
		move.l	-12(a1),12(a1)
		move.l	-8(a1),16(a1)
		move.l	-4(a1),20(a1)
		sub.l	#24,a1
		subq.l	#1,d1
		cmp.l	d0,d1
		bne	Transfer
No_Trans	move.l	Score,(a0)+
		move.l	a0,Hiptr
		PRINT	1,0,112,Overtext_3
		PRINT	1,0,128,Overtext_5
		PRINT	1,0,144,Overtext_6
		PRINT	1,0,160,Overtext_7
		PRINT	1,0,176,Overtext_8
		move.l	#0,Crsr_X
		move.l	#0,Crsr_Y
		bsr	Set_Highcrsr
		lea	Hiname,a0
		move.l	#19,d0
Clear_Hiname	move.b	#"-",(a0)+
		dbra	d0,Clear_Hiname
		clr.b	(a0)
		move.l	#0,Hipos
Overloop	move.l	#$ff,d1
		move.l	#4,d2
Overloop_2	move.w	VHPOSR,d0
		lsr.w	#8,d0
		cmp.b	d1,d0
		bne	Overloop_2
		subq.l	#1,d1
		dbra	d2,Overloop_2

		bsr	Set_Highcrsr
		move.w	JOY1DAT,d0
		btst	#1,d0
		beq	OverNR
		addq.l	#1,Crsr_X
		btst	#0,d0
		bne	OverY
		addq.l	#1,Crsr_Y
OverNR		btst	#0,d0
		beq	OverY
		addq.l	#1,Crsr_Y
OverY		btst	#9,d0
		beq	OverNL
		subq.l	#1,Crsr_X
		btst	#8,d0
		bne	OverTX
		subq.l	#1,Crsr_Y
OverNL		btst	#8,d0
		beq	OverTX
		subq.l	#1,Crsr_Y
OverTX		move.l	Crsr_X,d0
		bpl	OverNNX1
		clr.l	Crsr_X
OverNNX1	cmp.l	#10,d0
		bne	OverNNX2
		move.l	#9,Crsr_X
OverNNX2	move.l	Crsr_Y,d0
		bpl	OverNNY1
		clr.l	Crsr_Y
OverNNY1	cmp.l	#3,d0
		bne	OverNNY2
		move.l	#2,Crsr_Y
OverNNY2	bsr	Set_Highcrsr
		btst	#7,$bfe001
		bne	Overloop
		move.l	Crsr_Y,d0
		mulu	#10,d0
		add.l	Crsr_X,d0
		cmp.l	#29,d0
		beq	HiEnd
		cmp.l	#28,d0
		beq	HiDel
		cmp.l	#27,d0
		beq	HiBlank
		cmp.l	#26,d0
		beq	HiPoint
		add.l	#"A",d0
Push_Char	cmp.l	#20,HiPos
		beq	OverLoop
		move.l	HiPos,d1
		lea	HiName,a0
		move.b	d0,(a0,d1)
		addq.l	#1,HiPos
		PRINT	1,10,128,HiName
		bra	OverLoop
HiDel		cmp.l	#0,HiPos
		beq	OverLoop
		subq.l	#1,HiPos
		move.l	HiPos,d1
		lea	HiName,a0
		move.b	#"-",(a0,d1)
		PRINT	1,10,128,HiName
		bra	OverLoop
HiBlank		move.b	#" ",d0
		bra	Push_Char
HiPoint		move.b	#".",d0
		bra	Push_Char

HiEnd		move.b	#"-",HiName+20
		move.l	Hiptr,a1
		move.l	#19,d0
Clear_OldHi	move.b	#" ",(a1)+
		dbra	d0,Clear_OldHi
		cmp.b	#"-",HiName
		bne	Not_EmptyHi
		move.l	#"UNKN",HiName
		move.l	#"OWN-",HiName+4
Not_EmptyHi	lea	HiName,a0
Search_End	cmp.b	#"-",(a0)+
		bne	Search_End
		subq.l	#1,a0
Copy_HiName	move.b	-(a0),-(a1)
		cmp.b	#"!",-1(a0)
		bne	Copy_HiName
		move.l	Target,a0
		move.l	#$fffffffe,(a0)
		lea	GR_Cols,a5
		bsr	Fade_out
Real_HiEnd	bsr	Remove_Playfield
		move.l	#Filen_6,d1
		move.l	#1006,d2
		CALLDOS Open
		tst.l	d0
		beq	No_SaveHigh
		move.l	d0,d7
		move.l	d7,d1
		move.l	#HOF,d2
		move.l	#240,d3
		CALLDOS Write
		move.l	d7,d1
		CALLDOS Close
		move.l	#250,d1
		CALLDOS Delay
No_SaveHigh	bra	Title

Overwait	btst	#7,$bfe001
		bne	Overwait
		move.l	Target,a0
		move.l	#$fffffffe,(a0)
		lea	GR_Cols,a5
		bsr	Fade_out
		bsr	Remove_Playfield
		bra	Title
Set_Highcrsr	move.l	Plane0,a0
		add.l	#256*40+144*40+10,a0
		move.l	Crsr_x,d0
		mulu	#2,d0
		add.l	d0,a0
		move.l	Crsr_Y,d0
		mulu	#8*80,d0
		add.l	d0,a0
		move.l	#6,d0
SetFrame	eor.b	#%11111110,(a0)
		add.l	#40,a0
		dbra	d0,SetFrame
		rts

Rohr		move.l	#3,d0
Rup		move.w	d1,(a0)+
		move.w	#$fffe,(a0)+
		move.w	#$184,(a0)+
		move.w	d2,(a0)+
		add.w	#$0100,d1
		add.w	d3,d2
		dbra	d0,Rup
		sub.w	d3,d2
		move.l	#3,d0
Rdown		move.w	d1,(a0)+
		move.w	#$fffe,(a0)+
		move.w	#$184,(a0)+
		move.w	d2,(a0)+
		sub.w	d3,d2
		add.w	#$0100,d1
		dbra	d0,Rdown
		rts

Good		bsr	Clear_Colors
		bsr	Create_Playfield
		lea	NL,a0
		move.l	Plane0,a1
		add.l	#40*40+4,a1
		move.l	#2,d0
nl_1		move.l	a1,a2
		move.l	#49,d1
nl_2		move.l	a2,a3
		move.l	#30,d2
nl_3		move.b	(a0)+,(a3)+
		dbra	d2,nl_3
		add.l	#40,a2
		dbra	d1,nl_2
		add.l	#Planesize,a1
		dbra	d0,nl_1
		lea	GR_Cols,a5
		bsr	Fade_in
		move.l	Target,a0
		lea	Goodcols,a1
		move.l	#$a40f,d1
		move.l	#39,d0
nl_4		move.w	d1,(a0)+
		move.w	#$fffe,(a0)+
		move.w	#$184,(a0)+
		move.w	(a1)+,(a0)+
		add.w	#$0100,d1
		dbra	d0,nl_4
		move.l	#$fffffffe,(a0)
		PRINT	1,0,116,Goodtext_2
		tst.l	Num_Specials
		beq	No_SBonus
		move.l	Num_Specials,d2
		bsr	BinDec
		move.b	Dec_Buffer+5,Goodtext_4+15
		move.b	Dec_Buffer+6,Goodtext_4+16
		move.b	Dec_Buffer+7,Goodtext_4+17
		move.l	Play_Level,d0
		mulu	#50,d0
		move.l	Num_Specials,d1
		mulu	d1,d0
		move.l	d0,d2
		add.l	d0,Score
		bsr	BinDec
		lea	Dec_Buffer+1,a0
		lea	Goodtext_4+31,a1
		move.l	#6,d0
Copy_Bonus	move.b	(a0)+,(a1)+
		dbra	d0,Copy_Bonus
		PRINT	1,0,132,Goodtext_3
		PRINT	1,0,148,Goodtext_4
No_SBonus
Good_Wait	btst	#7,$BFE001
		bne	Good_Wait
		move.l	Target,a0
		move.l	#$fffffffe,(a0)
		lea	GR_Cols,a5
		bsr	Fade_out
		bsr	Remove_Playfield
		rts

Get_Ready	bsr	Create_Playfield
		move.l	Play_Level,d2
		bsr	BinDec
		cmp.b	#" ",Dec_Buffer+6
		bne	No_Space
		move.b	#"0",Dec_Buffer+6
No_Space	move.l	#"LEVE",Dec_Buffer
		move.w	#"L ",Dec_Buffer+4
		lea	GR,a0
		move.l	Plane0,a1
		add.l	#15*40+12,a1
		move.l	#2,d0
gr_1		move.l	a1,a2
		move.l	#129,d1
gr_2		move.l	a2,a3
		move.l	#16,d2
gr_3		move.b	(a0)+,(a3)+
		dbra	d2,gr_3
		add.l	#40,a2
		dbra	d1,gr_2
		add.l	#Planesize,a1
		dbra	d0,gr_1
		lea	GR_Cols,a5
		bsr	Fade_in
		PRINT	1,16,150,Dec_Buffer
		move.l	Target,a0
		lea	GR_Stripes,a1
		move.w	#$c60f,d1
		move.l	#23,d0
gr_4		move.w	d1,(a0)+
		move.w	#$fffe,(a0)+
		move.w	#$184,(a0)+
		move.w	(a1)+,(a0)+
		add.w	#$0100,d1
		dbra	d0,gr_4
		move.l	#$fffffffe,(a0)
gr_loop1	move.l	#$ffff,d0
gr_delay	swap	d0
		swap	d0
		dbra	d0,gr_delay
		cmp.l	#1,Difficulty
		bne.s	gr_no1
		PRINT	1,0,166,Dif_1
gr_no1		cmp.l	#2,Difficulty
		bne.s	gr_no2
		PRINT	1,0,166,Dif_2
gr_no2		cmp.l	#3,Difficulty
		bne.s	gr_no3
		PRINT	1,0,166,Dif_3
gr_no3
gr_wf		move.w	JOY1DAT,d0
		btst	#1,d0
		beq.s	gr_noright
		addq.l	#1,Difficulty
		cmp.l	#4,Difficulty
		bne.s	gr_no4
		move.l	#1,Difficulty
gr_no4		bra	gr_loop1
gr_noright	btst	#9,d0
		beq.s	gr_noleft
		subq.l	#1,Difficulty
		bne.s	gr_no0
		move.l	#3,Difficulty
gr_no0		bra	gr_loop1
gr_noleft	btst	#7,$bfe001
		bne.s	gr_wf
		move.l	Target,a0
		move.l	#$fffffffe,(a0)
		lea	GR_Cols,a5
		bsr	Fade_out
		bsr	Remove_Playfield
		rts

Create_Playfield
		move.l  #3*Planesize,d0
		move.l  #CHIP,d1
	 	CALLEXEC AllocMem
		move.l 	d0,Plane0
		move.l	#CLsize,d0
		move.l	#Chip,d1
		CALLEXEC AllocMem
		move.l	d0,CLadr
		move.l	d0,a0
		move.l	Plane0,d1
		move.w	#BPL1PTH-$DFF000,d3
		move.w	#3-1,d4
MakeCL_X	move.w 	d3,(a0)+
		addq.w	#2,d3
		swap	d1
		move.w	d1,(a0)+
		move.w	d3,(a0)+
		addq.w	#2,d3
		swap 	d1
		move.w	d1,(a0)+
		add.l	#Planesize,d1
		dbra	d4,MakeCL_X
		move.l	a0,Target
		move.l	#$fffffffe,(a0)
		CALLEXEC Forbid
		move.w	#%0000000111100000,DMACONW
		clr.l	SPR0DAT
		move.l	CLadr,COP1LC
		clr.w	COPJMP1
		move.w	#$3081,DIWSTRT
		move.w 	#$30c1,DIWSTOP
		move.w  #$0038,DDFSTRT
		move.w  #$00d0,DDFSTOP
		move.w  #%0011000000000000,BPLCON0
		clr.w	BPLCON1
		clr.w	BPLCON2
		clr.w	BPL1MOD
		clr.w	BPL2MOD
		move.w	#%1000011111011111,DMACONW
		move.w	#$000,$dff180
		move.w	#$000,$dff182
		move.w	#$000,$dff184
		move.w	#$000,$dff186
		move.w	#$000,$dff188
		move.w	#$000,$dff18a
		move.w	#$000,$dff18c
		move.w	#$000,$dff18e
		rts

Remove_Playfield
		move.w	#$7fff,DMACONW
		move.w	#%1000011011110000,DMACONW
		CALLEXEC Permit
		move.l	CLadr,a1
		move.l	#CLsize,d0
		CALLEXEC FreeMem
		move.l  Plane0,a1
		move.l	#3*Planesize,d0
		CALLEXEC FreeMem
		rts

Float		tst.l	Flow_Flag
		beq	Flow
		subq.l	#1,Flow_Delay
		beq	End_Flow_Delay
		rts
End_Flow_Delay	clr.l	Flow_Flag
		MPRINT	1,1,208,Clear_line
		rts
Flow		subq.l	#1,Splitter
		beq	Real_Float
		rts
Real_Float	move.l	#6,d0
		sub.l	Difficulty,d0
		move.l	d0,Splitter
		tst.l	Float_Flag
		bne	Lets_float
		rts
Lets_float	tst.l	Float_Count
		beq	New_Float
		subq.l	#1,Float_Count
		move.l	Plane0,a1
		add.l	#16*40+6,a1
		move.l	Float_X,d0
		mulu	#2,d0
		add.l	d0,a1
		move.l	Float_Y,d1
		mulu	#16*40,d1
		add.l	d1,a1
		move.l	#15,d1
		move.l	Float_Pointer,a0
Mark_Float	move.w	(a0)+,d0
		eor.w	#$ffff,d0
		and.w	d0,(a1)
		add.l	#Planesize,a1
		and.w	d0,(a1)
		add.l	#Planesize,a1
		and.w	d0,(a1)
		add.l	#Planesize,a1
		eor.w	#$ffff,d0
		or.w	d0,(a1)
		add.l	#40,a1
		sub.l	#3*Planesize,a1
		dbra	d1,Mark_Float
		tst.l	Float_Math
		bne	False_Dir_2
		add.l	#32,Float_Pointer
		rts
False_Dir_2	sub.l	#32,Float_Pointer
		rts

New_Float	tst.l	Text_Flag
		beq	No_Text
		subq.l	#1,Text_Delay
		bne	No_Text
		MPRINT	1,1,208,Clear_Line
		clr.l	Text_Flag
No_Text		move.l	#1,Delay_Flag
		move.l	Float_Dir,d4
		move.l	#8,Float_Count
		move.l	Float_Dir,d1
		mulu	#4,d1
		lea	Float_Add_X1,a0
		move.l	Float_X,d0
		add.l	(a0,d1),d0
		move.l	d0,Float_X
		lea	Float_Add_Y1,a0
		move.l	Float_Y,d0
		add.l	(a0,d1),d0
		move.l	d0,Float_Y
		cmp.l	#-1,Float_X
		beq	Game_Over
		cmp.l	#-1,Float_Y
		beq	Game_Over
		cmp.l	#16,Float_X
		beq	Game_Over
		cmp.l	#10,Float_Y
		beq	Game_Over
		lea	Level,a0
		add.l	Float_X,a0
		move.l	Float_Y,d0
		mulu	#16,d0
		add.l	d0,a0
		lea	Eingang_1,a1
		lea	Eingang_2,a2
		clr.l	d0
		move.b	(a0),d0
		move.l	d0,d7
		cmp.b	#7,d0
		bhi	Game_Over
		cmp.l	#3,d0
		beq	Eingang_Ok
		mulu	#4,d0
		add.l	d0,a1
		add.l	d0,a2
		move.l	Float_Dir,d0
		move.l	(a1),d1
		cmp.l	d0,d1
		beq	Eingang_Ok
		move.l	(a2),d1
		cmp.l	d0,d1
		beq	Eingang_Ok
		bra	Game_Over
Eingang_Ok	add.l	#15,Score
		lea	Floats,a0
		add.l	Float_X,a0
		move.l	Float_Y,d0
		mulu	#16,d0
		add.l	d0,a0
		tst.b	(a0)
		beq	No_Crossbonus
		MPRINT	1,1,208,Cross_Line
		add.l	#100,Score
No_Crossbonus	move.b	#1,(a0)
		lea	Special,a0
		add.l	Float_X,a0
		move.l	Float_Y,d0
		mulu	#16,d0
		add.l	d0,a0
		clr.l	d0
		move.b	(a0),d0
		tst.b	d0
		beq	No_Special
		addq.l	#1,Num_Specials
		bclr	#6,d0
		mulu	#4,d0
		lea	Special_Jmps_1,a0
		move.l	(a0,d0),a0
		movem.l	d0-d7/a0-a6,-(sp)
		jsr	(a0)
		movem.l	(sp)+,d0-d7/a0-a6
No_Special	lea	Ausgang_1,a0
		lea	Ausgang_2,a1
		move.l	d7,d6
		cmp.l	#3,d7
		beq	Cross
		mulu	#4,d7
		add.l	d7,a0
		add.l	d7,a1
		lea	Dir_Negations,a2
		move.l	Float_Dir,d0
		mulu	#4,d0
		add.l	d0,a2
		move.l	(a2),d0
		move.l	(a0),d1
		cmp.l	d0,d1
		bne	New_Dir
		move.l	(a1),d1
New_Dir		move.l	d1,Float_Dir
		cmp.l	#3,d6
		beq	Cross_2
		move.l	d1,d0
		mulu	#4,d0
		lea	Kind,a0
		move.l	d6,d5
		mulu	#4,d5
		add.l	d5,a0
		move.l	(a0),d5
		mulu	#16,d5
		lea	Zero,a0
		add.l	d5,a0
		mulu	#4,d4
		add.l	d4,a0
		move.l	(a0),Float_Math
		cmp.l	#-1,Float_Math
		beq	Game_Over
		lea	Float_Ptrs,a0
		mulu	#4,d6
		add.l	d6,a0
		move.l	(a0),Float_Pointer
		tst.l	Float_Math
		beq	Ptr_Ok
		add.l	#7*2*16,Float_Pointer
Ptr_OK		move.l	PlayFloat,d3
		add.l	d3,Float_Pointer
		bra	Float
Cross		move.l	Float_Dir,d1
		bra	New_Dir
Cross_2		lea	Crosskind,a0
		move.l	Float_Dir,d0
		mulu	#4,d0
		add.l	d0,a0
		lea	Crossptr,a1
		lea	Crossmath,a2
		add.l	(a0),a1
		add.l	(a0),a2
		move.l	(a1),Float_Pointer
		move.l	(a2),Float_Math
		bra	Ptr_OK
False_Dir	add.l	#8*2*16,Float_Pointer
		bra	Float
Game_Over	move.l	FinishFlag,Status
		addq.l	#1,Status
		rts

Special_0	MPRINT	1,1,208,Spec0_Line
		move.l	#1,Flow_Flag
		move.l	#60,Flow_Delay
		rts

Special_1	MPRINT	1,1,208,Spec1_Line
		add.l	#500,Score
		rts

Special_2	bsr	RND
		and.l	#15,d0
		cmp.l	#12,d0
		bhi	Special_2
		lea	RND_Jmps,a0
		mulu	#4,d0
		move.l	(a0,d0),a0
		jsr	(a0)
		rts

Special_3	MPRINT	1,1,208,Spec3_Line
		move.l	#1,Time_Flag
		move.l	#60,Time_Delay
		rts

Sub_Time	tst.l	FinishFlag
		bne	BackAtOnce
		tst.l	Time_Flag
		beq	Do_Sub_Time
		subq.l	#1,Time_Delay
		beq	End_Time_Delay
		rts
End_Time_Delay	clr.l	Time_Flag
		rts
Do_Sub_Time	subq.l	#1,Time_Split
		beq	New_Time
		rts
New_Time	move.l	#23,d0
		move.l	Difficulty,d1
		lsl.l	#1,d1
		sub.l	d1,d0
		move.l	d0,Time_Split
		addq.l	#1,Time
		bsr	Show_Time
		move.l	#28,d0
		move.l	Play_Level,d1
		cmp.l	#24,d1
		blt	No_High
		move.l	#24,d1
No_High		move.l	#4,d3
		sub.l	Difficulty,d3
		divu	d3,d1
		and.l	#$ffff,d1
		sub.l	d1,d0
		cmp.l	Time,d0
		beq	Start_Floating
		rts
Start_Floating	move.l	#1,Float_Flag

Show_Time	move.l	Plane0,a0
		add.l	#4*Planesize,a0
		add.l	#7*16*40+80,a0
		move.l	Time,d0
		mulu	#40,d0
		add.l	d0,a0
		clr.l	(a0)
		rts

Check_Joy	tst.l	FinishFlag
		bne	BackAtOnce
		tst.l	Joy_Flag
		beq	Do_Joy
		subq.l	#1,Joy_Delay
		beq	End_Joy_Delay
		rts
End_Joy_Delay	clr.l	Joy_Flag
		rts
Do_Joy		bsr	Del_Crsr
		bsr	Test_Joy
		bsr	Set_Crsr
		btst	#7,CIAAPRA
		beq	Fire
		clr.l	Fireflag
		rts
Fire		cmp.b	#$41,$bfec01
		bne	No_ch
		move.l	(sp)+,d0
		bra	LevelFinished

		dc.b	"     Yeah, the cheat-mode is around here !!! -AW-     "
		EVEN

No_ch		lea	Level,a0
		add.l	Crsr_X,a0
		move.l	Crsr_Y,d0
		mulu	#16,d0
		add.l	d0,a0
		cmp.b	#32,(a0)
		beq	Scroll_Next
		tst.b	(a0)
		bne	Maybe_delete
		clr.l	Fireflag
		move.b	Next+4,(a0)
		move.l	Crsr_X,d0
		move.l	Crsr_Y,d1
		clr.l	d2
		move.b	Next+4,d2
		bsr	Show_Obj
Scroll_Next	move.b	Next+3,Next+4
		move.b	Next+2,Next+3
		move.b	Next+1,Next+2
		move.b	Next+0,Next+1
Get_Next_obj	bsr	RND
		and.l	#7,d0
		beq	Get_Next_obj
		move.b	d0,Next
		bsr	Display_Next
End_Fire	clr.l	Fireflag
		rts

Maybe_delete	cmp.b	#17,(a0)
		beq	End_Fire
		tst.l	Deleters
		beq	End_Fire
		lea	Floats,a1
		add.l	Crsr_X,a1
		move.l	Crsr_Y,d0
		mulu	#16,d0
		add.l	d0,a1
		tst.b	(a1)
		bne	End_Fire
		cmp.l	#6,Fireflag
		beq	Delete_it
		addq.l	#1,Fireflag
		rts
Delete_it	clr.l	Fireflag
		subq.l	#1,Deleters
		move.b	#0,(a0)
		move.l	Crsr_X,d0
		move.l	Crsr_Y,d1
		move.l	#0,d2
		bsr	Show_Obj
		MPRINT	1,1,208,Delete_Text
		cmp.l	#250,Score
		bgt	More_500
		move.l	#0,Score
		bra	Fire
More_500	sub.l	#250,Score
		bra	Fire

Set_Crsr	move.l	Plane0,a0
		add.l	#4*Planesize,a0
		add.l	#16*40+6,a0
		move.l	Crsr_X,d0
		mulu	#2,d0
		add.l	d0,a0
		move.l	Crsr_Y,d0
		mulu	#16*40,d0
		add.l	d0,a0
		move.w	#$ffff,(a0)
		move.w	#$ffff,40(a0)
		move.w	#$ffff,14*40(a0)
		move.w	#$ffff,15*40(a0)
		add.l	#2*40,a0
		move.l	#11,d0
Set_Cursor	move.w	#%1100000000000011,(a0)
		add.l	#40,a0
		dbra	d0,Set_Cursor
		rts

Del_Crsr	move.l	Plane0,a0
		add.l	#4*Planesize,a0
		add.l	#16*40+6,a0
		move.l	Crsr_X,d0
		mulu	#2,d0
		add.l	d0,a0
		move.l	Crsr_Y,d0
		mulu	#16*40,d0
		add.l	d0,a0
		move.l	#15,d0
Del_Cursor	clr.w	(a0)
		add.l	#40,a0
		dbra	d0,Del_Cursor
		rts

Test_Joy	clr.l	Change_X
		clr.l	Change_Y
		move.w	JOY1DAT,d0
		btst	#1,d0
		beq	Not_Right
		addq.l	#1,Crsr_X
		move.l	#-2,Change_X
		btst	#0,d0
		bne	Joy_Y
		addq.l	#1,Crsr_Y
		move.l	#-2,Change_Y
Not_Right	btst	#0,d0
		beq	Joy_Y
		addq.l	#1,Crsr_Y
		move.l	#-2,Change_Y
Joy_Y		btst	#9,d0
		beq	Not_Left
		subq.l	#1,Crsr_X
		move.l	#2,Change_X
		btst	#8,d0
		bne	Tst_X
		subq.l	#1,Crsr_Y
		move.l	#2,Change_Y
Not_Left	btst	#8,d0
		beq	Tst_X
		subq.l	#1,Crsr_Y
		move.l	#2,Change_Y
Tst_X		tst.l	Joy_Revers
		beq	No_Revers
		move.l	Change_X,d0
		add.l	d0,Crsr_X
		move.l	Change_Y,d0
		add.l	d0,Crsr_Y
No_Revers	move.l	Crsr_X,d0
		bpl	Not_NegX
		clr.l	Crsr_X
Not_NegX	cmp.l	#15,d0
		ble	Tst_Y
		move.l	#15,Crsr_X
Tst_Y		move.l	Crsr_Y,d0
		bpl	Not_NegY
		clr.l	Crsr_Y
Not_NegY	cmp.l	#9,d0
		ble	End_Joy
		move.l	#9,Crsr_Y
End_Joy		rts

Delay		tst.l	FinishFlag
		bne	FastFlow
		tst.l	EscFlag
		bne	FastFlow
		tst.l	Delay_Flag
		bne	Short_One
		move.l	#11,d0
		move.l	Difficulty,d1
		sub.l	d1,d0
		bra	Delay_Loop_1
Short_One	clr.l	Delay_Flag
		move.l	#7,d0
		sub.l	Difficulty,d0
		bra	Delay_Loop_1
FastFlow	move.l	#1,d0
		bra	Delay_Loop_1
Delay_Loop_1	move.l	#$fff,d1
Delay_Loop_2	dbra	d1,Delay_Loop_2
		dbra	d0,Delay_Loop_1
BackAtOnce	rts

Show_Obj	move.l	Plane0,a0
		add.l	#16*40+6,a0
		mulu	#2,d0
		add.l	d0,a0
		mulu	#16*40,d1
		add.l	d1,a0
		move.l	PlayObj,a1
		mulu	#4*2*16,d2
		add.l	d2,a1
		move.l	#3,d7
Display_Obj	move.l	a0,a2
		move.l	#15,d6
Show_Obj_Plane	move.w	(a1)+,(a2)
		add.l	#40,a2
		dbra	d6,Show_Obj_Plane
		add.l	#Planesize,a0
		dbra	d7,Display_Obj
		rts

Display_Next	lea	Next,a5
		move.l	Plane0,a4
		add.l	#14*40+1,a4
		move.l	#4,d7
Show_Next	clr.l	d0
		move.b	(a5)+,d0
		mulu	#4*2*16,d0
		move.l	PlayObj,a0
		add.l	d0,a0
		move.l	a4,a3
		move.l	#3,d6
Copy_Next	move.l	a3,a2
		move.l	#15,d5
Copy_Next_Plane	move.b	(a0)+,(a2)
		move.b	(a0)+,1(a2)
		add.l	#40,a2
		dbra	d5,Copy_Next_Plane
		add.l	#Planesize,a3
		dbra	d6,Copy_Next
		add.l	#16*40,a4
		dbra	d7,Show_Next
		rts

RND		move.w	$dff006,d0
		lsr.w	#8,d0
		move.w	$dff006,d1
		lsr.w	#1,d1
		eor.l	d1,d0
		move.w	$dff006,d1
		lsr.w	#5,d1
		eor.l	d1,d0
		move.w	$dff006,d1
		lsr.w	#3,d1
		eor.l	d1,d0
		rts

Show_Score	move.l	Score,d2
		bsr	BinDec
		PRINT	4,7,195,Dec_Buffer+1
		rts

BinDec		move.l	#7,d0
		lea	Dec_Buffer,a0
		lea	pwrof10,a1
BD_Next		move.l	#"0",d1
Dec		add.l	#1,d1
		sub.l	(a1),d2
		bcc	Dec
		subq.l	#1,d1
		add.l	(a1),d2
		move.b	d1,(a0)+
		lea	4(a1),a1
		dbra	d0,BD_Next
		lea	Dec_Buffer,a0
		move.l	#6,d0
Del_Zeros	cmp.b	#"0",(a0)
		bne	End_Del_Zeros
		move.b	#" ",(a0)+
		dbra	d0,Del_Zeros
End_Del_Zeros	rts

Print_Text	clr.l	d0
		move.b	(a0)+,d0
		tst.l	d0
		beq	EOT
		sub.b	#$20,d0
		mulu	#8,d0
		move.l	PlayFont,a2
		add.l	d0,a2
		move.l	a1,a3
		move.l	#7,d1
Copy_Char	move.b	(a2)+,(a3)
		add.l	#40,a3
		dbra	d1,Copy_Char
		addq.l	#1,a1
		bra	Print_Text
EOT		rts

S0		bsr	Check_Room
		tst.l	d0
		beq	Ok_2
		bra	S1
Ok_2		MPRINT	1,1,208,S0_Text
Set		bsr	RND
		and.l	#15,d0
		move.l	d0,d6
SGet_Wall_Y	bsr	RND
		and.l	#15,d0
		cmp.l	#9,d0
		bhi	SGet_Wall_Y
		move.l	d0,d1
		move.l	d6,d0
		lea	Level,a0
		add.l	d0,a0
		mulu	#16,d1
		add.l	d1,a0
		tst.b	(a0)
		bne	Set
		move.b	#16,(a0)
		divu	#16,d1
		move.l	#13,d2
		bsr	Show_Obj
		rts

Check_Room	lea	Level,a0
		move.l	#16*10-1,d0
		clr.l	d1
Count_Free	cmp.b	#0,(a0)
		bne	No_Blank
		addq.l	#1,d1
No_Blank	addq.l	#1,a0
		dbra	d0,Count_Free
		cmp.l	#50,d1
		bls	No_Room
		clr.l	d0
		rts
No_Room		move.l	#1,d0
		rts

S1		MPRINT	1,1,208,S1_Text
		add.l	#600,Score
		rts

S2		bsr	Check_Room
		tst.l	d0
		beq	Ok_1
		bra	S1
Ok_1		MPRINT	1,1,208,S2_Text
Set_2		bsr	RND
		and.l	#15,d0
		move.l	d0,d6
Get_Hole_Y	bsr	RND
		and.l	#15,d0
		cmp.l	#9,d0
		bhi	Get_Hole_Y
		move.l	d0,d1
		move.l	d6,d0
		lea	Level,a0
		add.l	d0,a0
		mulu	#16,d1
		add.l	d1,a0
		tst.b	(a0)
		bne	Set_2
		move.b	#32,(a0)
		divu	#16,d1
		move.l	Plane0,a0
		add.l	#16*40+6,a0
		mulu	#2,d0
		add.l	d0,a0
		mulu	#16*40,d1
		add.l	d1,a0
		move.l	#15,d0
Set_Black_Hole	clr.w	(a0)
		add.l	#Planesize,a0
		clr.w	(a0)
		add.l	#Planesize,a0
		clr.w	(a0)
		add.l	#Planesize,a0
		clr.w	(a0)
		sub.l	#3*Planesize,a0
		add.l	#40,a0
		dbra	d0,Set_Black_Hole
		rts

S3		MPRINT	1,1,208,S3_Text
		rts

S4		MPRINT	1,1,208,S4_Text
		move.l	#1,Time_Flag
		move.l	#60,Time_Delay
		rts

S5		MPRINT	1,1,208,S5_Text
		move.l	#1,Flow_Flag
		move.l	#60,Flow_Delay
		rts

S6		MPRINT	1,1,208,S6_Text
		cmp.l	#200,Score
		bls	Gets_Zero
		sub.l	#200,Score
		rts
Gets_Zero	clr.l	Score
		rts

S7		MPRINT	1,1,208,S7_Text
		rts

S8		MPRINT	1,1,208,S8_Text
		move.l	#1,Joy_Flag
		move.l	#60,Joy_Delay
		rts

S9		MPRINT	1,1,208,S9_Text
		move.l	#1,Joy_Revers
		rts

S10		MPRINT	1,1,208,S10_Text
		move.l	#0,d1
		lea	Level,a0
Delete_Loop	move.l	#0,d0
Delete_L2	cmp.b	#16,(a0)
		bne	No_Wall
		clr.b	(a0)
		movem.l	d0-d7/a0-a6,-(sp)
		move.l	#0,d2
		bsr	Show_Obj
		movem.l	(sp)+,d0-d7/a0-a6
No_Wall		addq.l	#1,a0
		addq.l	#1,d0
		cmp.l	#16,d0
		bne	Delete_L2
		addq.l	#1,d1
		cmp.l	#10,d1
		bne	Delete_Loop
		rts

S11		MPRINT	1,1,208,S11_Text
		move.l	#0,d1
		lea	Level,a0
		lea	Special,a1
Change_Loop	move.l	#0,d0
Change_L2	cmp.b	#16,(a0)
		bne	No_Wall_2
		movem.l	d0-d7/a0-a6,-(sp)
		bsr	RND
		and.l	#3,d0
		cmp.l	#1,d0
		bne	No_Change
		movem.l	(sp)+,d0-d7/a0-a6
		movem.l	d0-d7/a0-a6,-(sp)
		clr.b	(a0)
		move.b	#64+1,(a1)
		move.l	#15,d2
		bsr	Show_Obj
No_Change	movem.l	(sp)+,d0-d7/a0-a6
No_Wall_2	addq.l	#1,a0
		addq.l	#1,a1
		addq.l	#1,d0
		cmp.l	#16,d0
		bne	Change_L2
		addq.l	#1,d1
		cmp.l	#10,d1
		bne	Change_Loop
		rts

S12		MPRINT	1,1,208,S12_Text
		move.w	#$700,$DFF180+16
		rts

*** Replay-routine taken from SOUNDTRACKER and converted to DevPac ***

start:	bsr.s	start_muzak
	rts

start_muzak:
	move.l	#data,muzakoffset

init0:	move.l	muzakoffset,a0
	add.l	#472,a0
	move.l	#$80,d0
	clr.l	d1
init1:	move.l	d1,d2
	subq.w	#1,d0
init2:	move.b	(a0)+,d1
	cmp.b	d2,d1
	bgt.s	init1
	dbf	d0,init2
	addq.b	#1,d2

init3:	move.l	muzakoffset,a0
	lea	pointers(pc),a1
	lsl.l	#8,d2
	lsl.l	#2,d2
	add.l	#600,d2
	add.l	a0,d2
	moveq	#14,d0
init4:	move.l	d2,(a1)+
	clr.l	d1
	move.w	42(a0),d1
	lsl.l	#1,d1
	add.l	d1,d2
	add.l	#30,a0
	dbf	d0,init4

init5:	clr.w	$dff0a8
	clr.w	$dff0b8
	clr.w	$dff0c8
	clr.w	$dff0d8
	clr.w	timpos
	clr.l	trkpos
	clr.l	patpos

init6:	move.l	muzakoffset,a0
	move.b	470(a0),numpat+1
	move.l	$6c.w,lev3save+2
	move.l	#lev3interrupt,$6c.w
	rts

stop_muzak:
	move.l	lev3save+2,$6c.w
	clr.w	$dff0a8
	clr.w	$dff0b8
	clr.w	$dff0c8
	clr.w	$dff0d8
	move.w	#$f,$dff096
	rts

lev3interrupt:
	bsr.s	replay_muzak
lev3save:
	jmp	$0

replay_muzak:
	movem.l	d0-d7/a0-a6,-(a7)
	addq.w	#1,timpos
speed:	cmp.w	#6,timpos
	beq.w	replaystep

chaneleffects:
	lea	datach0(pc),a6
	tst.b	3(a6)
	beq.s	ceff1
	lea	$dff0a0,a5
	bsr.s	ceff5
ceff1:	lea	datach1(pc),a6
	tst.b	3(a6)
	beq.s	ceff2
	lea	$dff0b0,a5
	bsr.s	ceff5
ceff2:	lea	datach2(pc),a6
	tst.b	3(a6)
	beq.s	ceff3
	lea	$dff0c0,a5
	bsr.s	ceff5
ceff3:	lea	datach3(pc),a6
	tst.b	3(a6)
	beq.s	ceff4
	lea	$dff0d0,a5
	bsr.s	ceff5
ceff4:	movem.l	(a7)+,d0-d7/a0-a6
	rts

ceff5:	move.b	2(a6),d0
	and.b	#$f,d0
	tst.b	d0
	beq.s	arpreggiato
	cmp.b	#1,d0
	beq.w	pitchup
	cmp.b	#2,d0
	beq.w	pitchdown
	cmp.b	#12,d0
	beq.w	setvol
	cmp.b	#14,d0
	beq.w	setfilt
	cmp.b	#15,d0
	beq.w	setspeed
	rts

arpreggiato:
	cmp.w	#1,timpos
	beq.s	arp1
	cmp.w	#2,timpos
	beq.s	arp2
	cmp.w	#3,timpos
	beq.s	arp3
	cmp.w	#4,timpos
	beq.s	arp1
	cmp.w	#5,timpos
	beq.s	arp2
	rts

arp1:	clr.l	d0
	move.b	3(a6),d0
	lsr.b	#4,d0
	bra.s	arp4
arp2:	clr.l	d0
	move.b	3(a6),d0
	and.b	#$f,d0
	bra.s	arp4
arp3:	move.w	16(a6),d2
	bra.s	arp6
arp4:	lsl.w	#1,d0
	clr.l	d1
	move.w	16(a6),d1
	lea	notetable,a0
arp5:	move.w	(a0,d0.w),d2
	cmp.w	(a0),d1
	beq.s	arp6
	addq.l	#2,a0
	bra.s	arp5
arp6:	move.w	d2,6(a5)
	rts

pitchdown:
	bsr.s	newrou
	clr.l	d0
	move.b	3(a6),d0
	and.b	#$f,d0
	add.w	d0,(a4)
	cmp.w	#$358,(a4)
	bmi.s	ok1
	move.w	#$358,(a4)
ok1:	move.w	(a4),6(a5)
	rts

pitchup:bsr.s	newrou
	clr.l	d0
	move.b	3(a6),d0
	and.b	#$f,d0
	sub.w	d0,(a4)
	cmp.w	#$71,(a4)
	bpl.s	ok2
	move.w	#$71,(a4)
ok2:	move.w	(a4),6(a5)
	rts

setvol:	move.b	3(a6),8(a5)
	rts

setfilt:move.b	3(a6),d0
	and.b	#1,d0
	lsl.b	#1,d0
	and.b	#$fd,$bfe001
	or.b	d0,$bfe001
	rts

setspeed:
	clr.l	d0
	move.b	3(a6),d0
	and.b	#$f,d0
	move.w	d0,speed+2
	rts

newrou:	cmp.l	#datach0,a6
	bne.s	next1
	lea	voi1(pc),a4
	rts
next1:	cmp.l	#datach1,a6
	bne.s	next2
	lea	voi2(pc),a4
	rts
next2:	cmp.l	#datach2,a6
	bne.s	next3
	lea	voi3(pc),a4
	rts
next3:	lea	voi4(pc),a4
	rts

replaystep:
	clr.w	timpos
	move.l	muzakoffset,a0
	move.l	a0,a3
	add.l	#12,a3
	move.l	a0,a2
	add.l	#472,a2
	add.l	#600,a0
	clr.l	d1
	move.l	trkpos,d0
	move.b	(a2,d0),d1
	lsl.l	#8,d1
	lsl.l	#2,d1
	add.l	patpos,d1
	clr.w	enbits
	lea	$dff0a0,a5
	lea	datach0(pc),a6
	bsr.w	chanelhandler
	lea	$dff0b0,a5
	lea	datach1(pc),a6
	bsr.w	chanelhandler
	lea	$dff0c0,a5
	lea	datach2(pc),a6
	bsr.w	chanelhandler
	lea	$dff0d0,a5
	lea	datach3(pc),a6
	bsr.w	chanelhandler
	move.w	#400,d0
rep1:	dbf	d0,rep1
	move.w	#$8000,d0
	or.w	enbits,d0
	move.w	d0,$dff096
	cmp.w	#1,datach0+14
	bne.s	rep2
	clr.w	datach0+14
	move.w	#1,$dff0a4
rep2:	cmp.w	#1,datach1+14
	bne.s	rep3
	clr.w	datach1+14
	move.w	#1,$dff0b4
rep3:	cmp.w	#1,datach2+14
	bne.s	rep4
	clr.w	datach2+14
	move.w	#1,$dff0c4
rep4:	cmp.w	#1,datach3+14
	bne.s	rep5
	clr.w	datach3+14
	move.w	#1,$dff0d4

rep5:	add.l	#16,patpos
	cmp.l	#64*16,patpos
	bne.s	rep6
	clr.l	patpos
	addq.l	#1,trkpos
	clr.l	d0
	move.w	numpat,d0
	cmp.l	trkpos,d0
	bne.s	rep6
	clr.l	trkpos
rep6:	movem.l	(a7)+,d0-d7/a0-a6
	rts

chanelhandler:
	move.l	(a0,d1.l),(a6)
	addq.l	#4,d1
	clr.l	d2
	move.b	2(a6),d2
	lsr.b	#4,d2
	beq.s	chan2
	move.l	d2,d4
	lsl.l	#2,d2
	mulu	#30,d4
	lea	pointers-4(pc),a1
	move.l	(a1,d2.l),4(a6)
	move.w	(a3,d4.l),8(a6)
	move.w	2(a3,d4.l),18(a6)

	move.l	d0,-(a7)
	move.b	2(a6),d0
	and.b	#$f,d0
	cmp.b	#$c,d0
	bne.s	ok3
	move.b	3(a6),8(a5)
	bra.s	ok4
ok3:	move.w	2(a3,d4.l),8(a5)
ok4:	move.l	(a7)+,d0

	clr.l	d3
	move.w	4(a3,d4),d3
	add.l	4(a6),d3
	move.l	d3,10(a6)
	move.w	6(a3,d4),14(a6)
	cmp.w	#1,14(a6)
	beq.s	chan2
	move.l	10(a6),4(a6)
	move.w	6(a3,d4),8(a6)
chan2:	tst.w	(a6)
	beq.s	chan4
	move.w	22(a6),$dff096
	tst.w	14(a6)
	bne.s	chan3
	move.w	#1,14(a6)
chan3:	bsr.w	newrou
	move.w	(a6),(a4)
	move.w	(a6),16(a6)
	move.l	4(a6),0(a5)
	move.w	8(a6),4(a5)
	move.w	(a6),6(a5)
	move.w	22(a6),d0
	or.w	d0,enbits
	move.w	18(a6),20(a6)
chan4:	rts

datach0:	ds.w	11
		dc.w	1
datach1:	ds.w	11
		dc.w	2
datach2:	ds.w	11
		dc.w	4
datach3:	ds.w	11
		dc.w	8
voi1:		dc.w	0
voi2:		dc.w	0
voi3:		dc.w	0
voi4:		dc.w	0
pointers:	ds.l	15
notetable:	dc.w	856,808,762,720,678,640,604,570
		dc.w	538,508,480,453,428,404,381,360
		dc.w	339,320,302,285,269,254,240,226  
		dc.w	214,202,190,180,170,160,151,143
		dc.w	135,127,120,113,000
muzakoffset:	dc.l	0
trkpos:		dc.l	0
patpos:		dc.l	0
numpat:		dc.w	0
enbits:		dc.w	0
timpos:		dc.w	0
data:		INCBIN	"Pipeline_II:Pipeline_II/data/Pipesong.MUS"

***** Vars *****

Plane0		ds.l	1
CLadr		ds.l	1		
Colors		dc.w	$000,$ddd,$555,$888,$aaa,$f12,$a00,$700
		dc.w	$dd0,$050,$080,$0f0,$00e,$55f,$99f,$c08
		dc.w	$fff,$fff,$fff,$fff,$fff,$fff,$fff,$fff
		dc.w	$fff,$fff,$fff,$fff,$fff,$fff,$fff,$fff
Crsr_X		dc.l	0
Crsr_Y		dc.l	0
Start_X		dc.l	0
Start_Y		dc.l	0
PlayPic		dc.l	0
PlayObj		dc.l	0
PlayFloat	dc.l	0
PlayFont	dc.l	0
PipeLogo	dc.l	0
PipeCluster	dc.l	0
Time		dc.l	0
Time_Split	dc.l	0
Float_Flag	dc.l	0
Float_X		dc.l	0
Float_Y		dc.l	0
Float_Dir	dc.l	0
Float_Count	dc.l	0
Float_Math	dc.l	0
Float_Pointer	dc.l	0
Float_Add_X1	dc.l	0,1,0,-1
Float_Add_Y1	dc.l	-1,0,1,0
Status		dc.l	0
Eingang_1	dc.l	-1,0,3,-1,2,3,3,1
Eingang_2	dc.l	-1,2,1,-1,1,2,0,0
Ausgang_1	dc.l	-1,0,1,-1,0,0,1,3
Ausgang_2	dc.l	-1,2,3,-1,3,1,2,2
Dir_Negations	dc.l	2,3,0,1
Kind		dc.l	-1,5,4,-1,0,3,2,1
Zero		dc.l	-1,0,1,-1
One		dc.l	1,0,-1,-1
Two		dc.l	0,-1,-1,1
Three		dc.l	-1,-1,0,1
Four		dc.l	-1,0,-1,1
Five		dc.l	1,-1,0,-1
Float_Ptrs	dc.l	-1,5*256,4*256,-1,0*256,3*256,2*256,1*256
Splitter	dc.l	0
RND_Counter	ds.l	1
Crosskind	dc.l	0,4,8,12
Crossptr	dc.l	5*256+7*32,4*256,5*256,4*256+7*32
Crossmath	dc.l	1,0,0,1
Play_Level	ds.l	1
pwrof10		dc.l	10000000
		dc.l	1000000
		dc.l	100000
		dc.l	10000
		dc.l	1000
		dc.l	100
		dc.l	10
		dc.l	1
Score		ds.l	1
BonusColors	dc.w	$990,$bb0,$dd0,$ff0,$dd0,$bb0,$990,$555
Special_Jmps_1	dc.l	Special_0,Special_1,Special_2,Special_3
Target		ds.l	1
Scrollptr	ds.l	1
Scrflag		ds.l	1
Flashdir	ds.w	1
Flashcol	ds.w	1
Hiptr		ds.l	1
Hipos		ds.l	1
FinishFlag	ds.l	1
EscFlag		ds.l	1
OldWindow	ds.l	1

*** Buffers

Level		ds.b	20*20
Special		ds.b	20*20
Floats		ds.b	20*20
Next		ds.b	8
Dec_Buffer	ds.b	16
Delay_Flag	ds.l	1
Flow_Flag	ds.l	1
Flow_Delay	ds.l	1
Time_Flag	ds.l	1
Time_Delay	ds.l	1
Num_Specials	ds.l	1
Difficulty	ds.l	1
GR_Cols		dc.w	$000,$440,$ff0,$dd0,$bb0,$990,$770,$550
		ds.w	24
gr_stripes	dc.w	$f22,$f44,$f66,$f88,$faa,$fcc,$fee,$fff
		ds.w	8
		dc.w	$f2f,$f4f,$f6f,$f8f,$faf,$fcf,$fef,$ff0
RND_Jmps	dc.l	s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12
Joy_Flag	ds.l	1
Joy_Delay	ds.l	1
Joy_Revers	ds.l	1
Change_X	ds.l	1
Change_Y	ds.l	1
Text_Flag	ds.l	1
Text_Delay	ds.l	1
Deleters	ds.l	1
Fireflag	ds.l	1
TitleCols_1	dc.w	$000,$f44,$e44,$e33,$d33,$d33,$c22,$c22
		dc.w	$b22,$b11,$a11,$a11,$911,$900,$800,$700
		dc.w	$ff0,$ff0,$ff0,$ff0,$ff0,$ff0,$ff0,$ff0
		dc.w	$ff0,$ff0,$ff0,$ff0,$ff0,$ff0,$ff0,$ff0
TitleCols_2	dc.w	$000,$72f,$71d,$61c,$51a,$508,$407,$305
		dc.w	$ff0,$ff0,$ff0,$ff0,$ff0,$ff0,$ff0,$ff0
		dc.w	$ff0,$ff0,$ff0,$ff0,$ff0,$ff0,$ff0,$ff0
		dc.w	$ff0,$ff0,$ff0,$ff0,$ff0,$ff0,$ff0,$ff0
Goodcols	dc.w	$2f2,$4f4,$6f6,$8f8,$afa,$cfc,$efe,$000
		ds.w	8
		dc.w	$f22,$f44,$f66,$f88,$faa,$fcc,$fee,$000
		ds.w	8
		dc.w	$f22,$f44,$f66,$f88,$faa,$fcc,$fee,$ff0
		ds.w	30
		dc.b	"!!"
Hiname		ds.b	20
		dc.b	0
		EVEN
gr		incbin	"Pipeline_II:Pipeline_II/data/Pipe_GR.GFX"
nl		incbin	"Pipeline_II:Pipeline_II/data/Pipe_NL.GFX"
go		incbin	"Pipeline_II:Pipeline_II/data/Pipe_GO.GFX"

**** Strings ****

Filen_0		dc.b	"Pipeline_II:Pipeline_II/data/Pipeline.GFX",0
		EVEN
Filen_1		dc.b	"Pipeline_II:Pipeline_II/data/PipeObj.GFX",0
		EVEN
Filen_2		dc.b	"Pipeline_II:Pipeline_II/data/PipeFloat.GFX",0
		EVEN
Filen_3		dc.b	"Pipeline_II:Pipeline_II/data/PipeFont.GFX",0
		EVEN
Filen_4		dc.b	"Pipeline_II:Pipeline_II/data/PipeCluster.GFX",0
		EVEN
Filen_5		dc.b	"Pipeline_II:Pipeline_II/data/PipeLogo.GFX",0
		EVEN
Filen_6		dc.b	"Pipeline_II:Pipeline_II/data/Pipeline.SCO",0
		EVEN
Status_text	dc.b	"SCORE:         HIGH:         LEVEL:  ",0
		EVEN
Clear_Line	dc.b	"                                     ",0
		EVEN
Cross_Line	dc.b	"CROSS BONUS 100 !!!                  ",0
		EVEN
Spec0_Line	dc.b	" FLOWING INTERRUPTED FOR A WHILE...  ",0
		EVEN
Spec1_Line	dc.b	"SCORE BONUS 500 !!!                  ",0
		EVEN
Spec3_Line	dc.b	"TIME STOPS SOME SECONDS...           ",0
		EVEN
Level_Text	dc.b	"LEVEL",0
		EVEN
S0_Text		dc.b	"SUDDENLY A WALL APPEARS...           ",0
		EVEN
S1_Text		dc.b	"YOUR SCORE WENT UP BY 600 !!!        ",0
		EVEN
S2_Text		dc.b	"A BLACK HOLE ARRIVED FROM DEEP SPACE!",0
		EVEN
S3_Text		dc.b	"GURU MEDITATION - SOFTWARE FAILURE !!",0
		EVEN
S4_Text		dc.b	"WHAT IS THAT ? THE CLOCK STOPS !!!   ",0
		EVEN
S5_Text		dc.b	"HUM ! THE OIL STOPS FLOWING !        ",0
		EVEN
S6_Text		dc.b	"AARGH ! YOUR SCORE WENT DOWN BY 200 !",0
		EVEN
S7_Text		dc.b	"HU ?!? NOTHING HAPPENS ! (NO IDEAS!) ",0
		EVEN
S8_Text		dc.b	"YOUR JOYSTICK-PORT HAS CRASHED !!!   ",0
		EVEN
S9_Text		dc.b	"TS, TS - YOUR JOYSTICK REVERSES...   ",0
		EVEN
S10_Text	dc.b	"UFF !!! WHERE ARE THE WALLS ???      ",0
		EVEN
S11_Text	dc.b	"SOME WALLS HAVE CHANGED !            ",0
		EVEN
S12_Text	dc.b	"BLOB !!! I CANNOT SEE ANY OIL ?!?    ",0
		EVEN
Delete_Text	dc.b	"SCORE-PENALTY 250 !!!                ",0
		EVEN
HOF		dc.l	10000
		dc.b	"      ANDRE WICHMANN"
		dc.l	9000
		dc.b	"             CLUSTER"
		dc.l	8000
		dc.b	"             CLUSTER"
		dc.l	7000
		dc.b	"             CLUSTER"
		dc.l	6000
		dc.b	"             CLUSTER"
		dc.l	5000
		dc.b	"             CLUSTER"
		dc.l	4000
		dc.b	"             CLUSTER"
		dc.l	3000
		dc.b	"             CLUSTER"
		dc.l	2000
		dc.b	"             CLUSTER"
		dc.l	1000
		dc.b	"             CLUSTER"
		EVEN
HOFText		dc.b	"       THE PIPELINE HALL OF FAME:",0
		EVEN
HOFBuffer	ds.b	42
		EVEN
Scroll		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"               PIPELINE II              "
		dc.b	"              -------------             "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"     (C) BY CLUSTER IN MAR/APR 1990     "
		dc.b	"                                        "
		dc.b	"          IMPROVED IN AUG 1990          "
		dc.b	"                                        "
		dc.b	"          UPDATED IN DEC 1990.          "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"           CONCEPT  EMPIRE (PIPEMANIA)  "
		dc.b	"                                        "
		dc.b	"  ADDITIONAL IDEAS  ANDRE WICHMANN      "
		dc.b	"                    MARTIN ROSENKRANZ   "
		dc.b	"                    GUIDO WEGENER       "
		dc.b	"                                        "
		dc.b	"       PROGRAMMING  ANDRE WICHMANN      "
		dc.b	"                                        "
		dc.b	"      IMPROVEMENTS  ANDRE WICHMANN      "
		dc.b	"                                        "
		dc.b	"     GAME GRAPHICS  ANDRE WICHMANN      "
		dc.b	"                                        "
		dc.b	"'PIPELINE/CLUSTER'  MARTIN ROSENKRANZ   "
		dc.b	"                                        "
		dc.b	"    CHARSET DESIGN  COMMODORE (C64)     "
		dc.b	"                                        "
		dc.b	"CHARSET CONVERSION  MARTIN ROSENKRANZ   "
		dc.b	"                                        "
		dc.b	"             MUSIC  ANDRE WICHMANN      "
		dc.b	"                                        "
		dc.b	"         ASSEMBLER  DEVPAC 2.14 (HISOFT)"
		dc.b	"                                        "
		dc.b	"      SOUND EDITOR  EAS SOUNDTRACKER    "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"  THIS PROGRAM IS FREEWARE AND MAY BE   "
		dc.b	" COPIED AS LONG AS THE DOC-FILE IS IN-  "
		dc.b	" CLUDED, NO CHANGES ARE SPREAD AND -NO- "
		dc.b	"  PROFIT IS MADE WITH DISTRIBUTION !!!  "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"             NEW FEATURES :             "
		dc.b	"                                        "
		dc.b	"                                        "
		DC.B	"      BETTER GRAPHICS (MADE BY AW)      "
		dc.b	"                                        "
		DC.B	"        OPTION TO DELETE A PIECE        "
		dc.b	"                                        "
		DC.B	"         3 LEVELS OF DIFFICULTY         "
		dc.b	"                                        "
		DC.B	"         THE GAME IS EASIER NOW         "
		dc.b	"                                        "
		DC.B	"    YOU CAN QUIT THE GAME (LEFT MB)     "
		dc.b	"                                        "
		DC.B	" NO PROBLEMS WITH WRITE-PROTECTED DISKS "
		dc.b	"                                        "
		DC.B	"              INTRO-SCREEN              "
		dc.b	"                                        "
		DC.B	"    CHEAT-MODE (TRY A FILE-MONITOR)     "
		dc.b	"                                        "
		DC.B	"       NEW DOCS (ENGLISH/GERMAN)        "
		dc.b	"                                        "
		dc.b	"     NO MOUSE-POINTER BETWEEN FADES     "
		dc.b	"                                        "
		DC.B	"    SEVERAL INTERNAL BUGS ARE FIXED     "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		DC.B	"                CHANGES:                "
		dc.b	"                                        "
		DC.B	"PAUSE AND RESUME WITH LEFT MOUSE-BUTTON "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"SORRY TO ALL NTSC-USERS, BUT I HOPE THAT"
		dc.b	"  THIS GAME WILL STILL BE PLAYABLE, MY  "
		dc.b	"NEXT PROGRAM WILL NOT USE THE WHOLE PAL-"
		dc.b	"          SCREEN ! (I HOPE...)          "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	" THE SCORES WILL BE SAVED (I HATE GAMES "
		dc.b	" WHERE THE SCORES ARE NOT SAVED !!), SO "
		dc.b	"      TRY TO BEAT THE HIGH-SCORE !      "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	" SEND BUG REPORTS, IMPROVEMENTS, IDEAS, "
		dc.b	"  MONEY OR JUST A FRIENDLY LETTER TO:   "
		dc.b	"                                        "
		dc.b	"             ANDRE WICHMANN             "
		dc.b	"             POSENER WEG 4              "
		dc.b	"             5300 BONN 1                "
		dc.b	"             WEST GERMANY               "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	" OTHER PROGRAMS AVAILABLE FROM CLUSTER: "
		dc.b	"                                        "
		DC.B	"  BRAIN, FILESELECT, NEWBOOT, ASHIDO,   "
		DC.B	" MEGATEXTER, X-GRAMS, WA-TOR, ICONTROL, "
		DC.B	"  QUO VADIS, ILBM-CONVERT, DC.L, BLOB,  "
		DC.B	"  TORWAT, POINTER SISTERS, INTROS ETC.  "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		DC.B	"        PROJECTS SOON FINISHED:         "
		dc.b	"                                        "
		DC.B	"    CONQUEST, ADVENTURE-INTERPRETER,    "
		DC.B	"           FILECAT AND PUSH.            "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"            ENJOY THE GAME !            "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	"                                        "
		dc.b	0
		EVEN
Goodtext_2	dc.b	"    YOU HAVE REACHED THE NEXT LEVEL!",0
		EVEN
Goodtext_3	dc.b	"    YOU HAVE EARNED A SPECIAL-BONUS!",0
		EVEN
Goodtext_4	dc.b	" SPECIALS USED:    BONUS SCORE:       ",0
		EVEN
Overtext_2	dc.b	"      .....YOU LOST THE GAME.....",0
		EVEN
Overtext_3	dc.b	"     YOU ENTERED THE HALL OF FAME !",0
		EVEN
Overtext_4	dc.b	"NO HIGH-SCORE THIS TIME, BUT NEXT GAME ?",0
		EVEN
Overtext_5	dc.b	"YOUR NAME:--------------------",0
		EVEN
Overtext_6	dc.b	"          A B C D E F G H I J",0
		EVEN
Overtext_7	dc.b	"          K L M N O P Q R S T",0
		EVEN
Overtext_8	dc.b	"          U V W X Y Z .   D E",0
		EVEN
Overtext_9	dc.b	"           YOUR SCORE:       ",0
		EVEN
Dif_1		dc.b	"           DIFFICULTY: NOVICE           ",0
		EVEN
Dif_2		dc.b	"           DIFFICULTY: NORMAL           ",0
		EVEN
Dif_3		dc.b	"           DIFFICULTY: CHAMP!           ",0
		EVEN

