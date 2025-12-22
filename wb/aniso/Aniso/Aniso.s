;	Aniso - a small puzzle game
;	Copyright 1992 Barry McConnell
;	Set TAB stops to 10!

	include	exec/exec_lib.i
	include	exec/execbase.i
	include	exec/memory.i
	include	intuition/intuition_lib.i
	include	dos/dos_lib.i
	include	dos/dosextens.i
	include	graphics/graphics_lib.i
	include	libraries/gadtools_lib.i
	
	include	graphics/gfxbase.i
	include	intuition/intuition.i
	include	libraries/gadtools.i


CALLGAD	MACRO
	move.l	_GadBase,a6
	jsr	_LVO\1(a6)
	ENDM

	SECTION	Aniso,CODE

	movem.l	d0/a0,-(a7)
	clr.l	ReturnMsg
	movea.w	#0,a1
	CALLEXEC	FindTask
	movea.l	d0,a4
	tst.l	pr_CLI(a4)		started from WB or CLI?
	bne.s	SkipWB
	lea	pr_MsgPort(a4),a0
	CALLEXEC	WaitPort
	lea	pr_MsgPort(a4),a0
	CALLEXEC	GetMsg
	move.l	d0,ReturnMsg		save it for later reply
SkipWB	movem.l	(a7)+,d0/a0
	bsr.s	Main
	move.l	d0,-(a7)			save exit code
	tst.l	ReturnMsg			started from CLI?
	beq.s	End
	CALLEXEC	Forbid
	move.l	ReturnMsg,a1
	CALLEXEC	ReplyMsg
End	move.l	(a7)+,d0
	rts
	
Main	lea	IntName,a1
	moveq.l	#37,d0
	CALLEXEC	OpenLibrary
	tst.l	d0
	beq	end

	move.l	d0,_IntuitionBase

	lea	DosName,a1
	moveq.l	#37,d0
	CALLEXEC	OpenLibrary
	tst.l	d0
	beq	closeint

	move.l	d0,_DOSBase	

	lea	GadName,a1
	moveq.l	#37,d0
	CALLEXEC	OpenLibrary
	tst.l	d0
	beq	closedos

	move.l	d0,_GadBase	

	lea	GfxName,a1
	moveq.l	#37,d0
	CALLEXEC	OpenLibrary
	tst.l	d0
	beq	closegad

	move.l	d0,_GfxBase

	movea.l	d0,a0
	move.l	gb_DefaultFont(a0),a1
	move.l	a1,SysFont
	lea	DefFont,a2
	move.l	LN_NAME(a1),(a2)+
	move.w	tf_YSize(a1),(a2)

	movea.w	#0,a0
	CALLINT	LockPubScreen
	tst.l	d0
	beq	closegfx

	move.l	d0,PubScr

	movea.l	d0,a3
	move.l	sc_Font(a3),a0
	CALLGRAF	OpenFont
	tst.l	d0
	beq	unlock

	move.l	d0,ScrFont

	move.l	d0,a1
	CALLGRAF	CloseFont

	movea.l	a3,a0
	movea.w	#0,a1
	CALLGAD	GetVisualInfoA
	tst.l	d0
	beq	unlock

	move.l	d0,VisInfo

Init	movea.l	SysFont,a0
	movea.l	ScrFont,a1
	move.w	tf_XSize(a0),d3		width of system default font
	move.w	tf_YSize(a0),d4		height of system default font
	move.w	tf_YSize(a1),d5		height of default screen font
	move.w	d5,sfsize

	move.w	Size,d2
	move.w	d2,d0
	mulu	#6,d0
	addi.w	#9,d0
	mulu	d3,d0
	addi.w	#36,d0
	move.w	d2,d1
	mulu	#8,d1
	add.w	d1,d0
	move.l	d0,winwidth

	move.w	d2,d0
	addq.w	#1,d0
	mulu	d4,d0
	addi.w	#27,d0
	move.w	d2,d1
	mulu	#10,d1
	add.w	d1,d0
	add.w	d5,d0			allow room for title bar
	move.l	d0,winheight

	move.w	d2,d0
	mulu	d0,d0
	add.w	d0,d0
	move.l	d0,d6
	addi.w	#4,d0
	mulu	#30,d0			30 bytes per NewGadget structure
	move.l	d0,Mem1
	move.l	#MEMF_ANY!MEMF_CLEAR,d1
	CALLEXEC	AllocMem
	tst.l	d0
	beq	freevi

	move.l	d0,GadMem
	move.l	d6,d0
	add.w	d0,d0
	move.l	d0,Mem2
	move.l	#MEMF_ANY!MEMF_CLEAR,d1
	CALLEXEC	AllocMem
	tst.l	d0
	beq	freegmem

	move.l	d0,TextMem
	move.w	d3,d0
	mulu	#3,d0
	addq.w	#4,d0			width of one gadget
	move.w	d0,width
	mulu	d2,d0
	move.w	d0,nwidth			width of n gadgets

	move.w	d4,d0
	addi.w	#10,d0			height of one gadget
	move.w	d0,height
	mulu	d2,d0			height of n gadgets
	move.w	d0,nheight		height of n gadgets

	move.w	d2,d0
	mulu	d0,d0
	add.w	d0,d0			memory taken by text by n*n buttons
	move.w	d0,ntext

	move.w	Size,d5
	mulu	d5,d5
	mulu	#30,d5			memory taken by n*n NewGadgets

	movea.l	GadMem,a0
	movea.l	TextMem,a1
	moveq.w	#10,d1			gadget ID
	clr.w	d7			row counter
row	clr.w	d6			column counter
column	movem.l	a0-a1,-(a7)

	move.w	width,d0
	mulu	d6,d0
	addq.w	#8,d0
	move.w	d0,(a0)			left (text)
	add.w	nwidth,d0
	addi.w	#10,d0
	move.w	d0,0(a0,d5)		left (button)
	adda.w	#2,a0

	move.w	height,d0
	mulu	d7,d0
	addq.w	#7,d0
	add.w	sfsize,d0
	move.w	d0,(a0)			top (text)
	move.w	d0,0(a0,d5)		top (button)
	adda.w	#2,a0

	move.w	width,d0
	subq.w	#4,d0
	move.w	d0,(a0)			width (text)
	move.w	d0,0(a0,d5)		width (button)
	adda.w	#2,a0

	move.w	height,d0
	subq.w	#4,d0
	move.w	d0,(a0)			height (text)
	move.w	d0,0(a0,d5)		height (button)
	adda.w	#2,a0

	move.l	a1,(a0)			text (text)
	adda.w	ntext,a1
	move.l	a1,0(a0,d5)		text (button)
	adda.w	#4,a0

	lea	DefFont,a2
	move.l	a2,(a0)			Default Font (text)
	move.l	a2,0(a0,d5)		Default Font (button)
	adda.w	#4,a0

	move.w	d1,(a0)			ID (text)
	move.w	d2,d0
	mulu	d0,d0
	add.w	d1,d0
	move.w	d0,0(a0,d5)		ID (button)
	adda.w	#2,a0
	addq.w	#1,d1

	moveq.l	#PLACETEXT_IN,d0
	move.l	d0,(a0)			flags (text)
	move.l	d0,0(a0,d5)		flags (button)
	adda.w	#4,a0

	move.l	VisInfo,d0
	move.l	d0,(a0)			Visual Info (text)
	move.l	d0,0(a0,d5)		Visual Info (button)
	adda.w	#4,a0

	move.l	#TEXT_KIND,(a0)		user data (text)
	move.l	#BUTTON_KIND,0(a0,d5)	user data (button)

	movem.l	(a7)+,a0-a1
	adda.w	#30,a0
	adda.w	#2,a1
	addq.b	#1,d6
	cmp.b	d2,d6
	bne	column
	addq.b	#1,d7
	cmp.b	d2,d7
	bne	row

	adda.l	d5,a0
	movea.l	a0,a1

	lea	Buttons,a0
	move.w	nheight,d0
	add.w	#15,d0
	add.w	sfsize,d0
	move.w	d0,2(a0)			top
	move.w	d0,32(a0)
	move.w	d0,62(a0)

	move.w	d3,d0
	mulu	#8,d0
	move.w	d0,d6
	move.w	d0,4(a0)			width
	move.w	d0,34(a0)
	move.w	d0,64(a0)

	move.w	d4,d0
	addq.w	#6,d0
	move.w	d0,6(a0)			height
	move.w	d0,36(a0)
	move.w	d0,66(a0)
	move.w	d0,96(a0)

	move.l	VisInfo,d0
	move.l	d0,22(a0)			VisualInfo
	move.l	d0,52(a0)
	move.l	d0,82(a0)
	move.l	d0,112(a0)

	move.w	d2,d0
	mulu	#6,d0
	subi.w	#15,d0
	mulu	d3,d0
	add.w	#20,d0
	move.w	d2,d1
	mulu	#8,d1
	add.w	d1,d0
	ror.l	#1,d0			distance between each button

	move.w	d6,d1
	addi.w	#8,d1
	add.w	d0,d1
	move.w	d1,30(a0)			left (2nd button)
	add.w	d6,d1
	add.w	d0,d1
	move.w	d1,60(a0)			left (3rd button)

	move.w	nwidth,d0
	add.w	d0,d0
	addi.w	#28,d0
	move.w	d0,90(a0)			left (cycle)

	move.w	height,d0
	addq.w	#7,d0
	add.w	sfsize,d0
	move.w	d0,92(a0)			top (cycle)

	move.w	d3,d0
	mulu	#9,d0
	move.w	d0,94(a0)			width (cycle)

	moveq.l	#120,d0
	CALLEXEC	CopyMem

	move.w	Size,d0
	move.w	d0,SizeCopy
	subq.w	#3,d0
	move.l	d0,CycActive

	bsr	Shuffle

	lea	glist,a0
	CALLGAD	CreateContext
	tst.l	d0
	beq	freetmem

	movea.l	d0,a0
	movea.l	GadMem,a1
	move.w	Size,d2
	mulu	d2,d2
	add.w	d2,d2
	addi.w	#4,d2
	lea	Tag1,a2
	clr.l	FirstBox
	clr.l	FirstBut

gadloop	move.l	26(a1),d0			kind
	move.l	d0,-(a7)
	movea.l	a1,a5
	cmpi.w	#4,d2
	bne	nochange
	lea	Tag2,a2
nochange	CALLGAD	CreateGadgetA
	tst.l	d0
	bne	createok
	move.l	(a7)+,d0
	bra	freegads

createok	movea.l	a5,a1
	adda.w	#30,a1
	movea.l	d0,a0
	tst.l	FirstBox
	bne	notbox
	move.l	a0,FirstBox
notbox	move.l	(a7)+,d0
	cmpi.l	#BUTTON_KIND,d0
	bne	notbutton
	tst.l	FirstBut
	bne	notbutton
	move.l	a0,FirstBut
notbutton	subq.w	#1,d2
	bne	gadloop

	move.l	d0,CycleGad
	movea.w	#0,a0
	lea	WinTags,a1
	CALLINT	OpenWindowTagList
	tst.l	d0
	beq	freegads

	move.l	d0,MyWindow
	movea.l	d0,a0
	move.l	wd_UserPort(a0),MyIdcmp
	movea.l	MyWindow,a0
	CALLINT	ActivateWindow

sleep	movea.l	MyIdcmp,a0
	CALLEXEC	WaitPort

loop	movea.l	MyIdcmp,a0
	CALLGAD	GT_GetIMsg		something happened!
	tst.l	d0
	beq	sleep			received all messages
	movea.l	d0,a1
	move.l	im_Class(a1),d3		what exactly happened?
	move.w	im_Qualifier(a1),d4		with what?
	move.w	im_Code(a1),d5		its code
	movea.l	im_IAddress(a1),a2		and to what?
	CALLGAD	GT_ReplyIMsg

	cmpi.l	#CLOSEWINDOW,d3
	bne	noclose
finish	move.w	#1,Terminate
	bra	closewind

noclose	cmpi.l	#VANILLAKEY,d3
	bne	nokey
	cmpi.w	#"n",d5
	beq	new
	cmpi.w	#"r",d5
	beq	retry
	cmpi.w	#"q",d5
	beq	finish
	bra	loop

nokey	move.w	gg_GadgetID(a2),d0
	cmpi.w	#200,d0
	bge	button
	cmpi.w	#10,d0
	blt	loop

	move.w	Size,d1
	mulu	d1,d1
	sub.w	d1,d0
	sub.w	#10,d0			button number
	bsr	IncSquare

update	movea.l	FirstBut,a0
	movea.l	MyWindow,a1
	movea.w	#0,a2
	move.w	Size,d0
	mulu	d0,d0
	CALLINT	RefreshGList

	move.w	Size,d0
	mulu	d0,d0
	cmp.w	Count,d0
	bne	loop
	bsr	TestWin
	bra	loop

button	cmpi.w	#200,d0
	beq	new
	cmpi.w	#201,d0
	beq	retry
	cmpi.w	#202,d0
	beq	finish
	cmpi.w	#203,d0
	bne	loop

	move.w	SizeCopy,d0
	and.b	#IEQUALIFIER_LSHIFT!IEQUALIFIER_RSHIFT,d4
	beq	cycadd
	subq.w	#1,d0
	cmp.w	#2,d0
	bne	endcyc
	move.w	#8,d0
	bra	endcyc
cycadd	addq.w	#1,d0
	cmp.w	#9,d0
	bne	endcyc
	move.w	#3,d0
endcyc	move.w	d0,SizeCopy
	bra	loop

new	move.w	SizeCopy,Size
	move.w	#0,Terminate
	movea.l	MyWindow,a0
	lea	WinTags,a1
	move.w	gg_LeftEdge(a0),6(a1)
	move.w	gg_TopEdge(a0),14(a1)
	bra	closewind

retry	bsr	Clear
	bra	update

closewind	movea.l	MyWindow,a0
	CALLINT	CloseWindow
freegads	lea	glist,a0
	CALLGAD	FreeGadgets
freetmem	move.l	Mem2,d0
	movea.l	TextMem,a1
	CALLEXEC	FreeMem
freegmem	move.l	Mem1,d0
	movea.l	GadMem,a1
	CALLEXEC	FreeMem
	tst.w	Terminate
	beq	Init
freevi	move.l	VisInfo,a0
	CALLGAD	FreeVisualInfo
unlock	movea.w	#0,a0
	movea.l	PubScr,a1
	CALLINT	UnlockPubScreen
closegfx	move.l	_GfxBase,a1
	CALLEXEC	CloseLibrary
closegad	move.l	_GadBase,a1
	CALLEXEC	CloseLibrary
closedos	move.l	_DOSBase,a1
	CALLEXEC	CloseLibrary
closeint	move.l	_IntuitionBase,a1
	CALLEXEC	CloseLibrary
end	rts

;	Initialise the random seed

InitRand	movem.l	d0-d1/a0,-(a7)
	movea.l	4,a0
	move.l	IdleCount(a0),d0
	move.l	DispCount(a0),d1
	rol.l	#8,d1
	rol.l	#8,d1
	eor.l	d0,d1
	move.l	d1,Rand
	movem.l	(a7)+,d0-d1/a0
	rts

;	Get a random number between d0.b = 0..n-1 and reseed. Returns number in d2.b.

GetRand	movem.l	d0-d1/d3/a0,-(a7)

	clr.w	d1
	move.b	d0,d1
	move.w	d1,d0
	move.l	Rand,d1
	clr.l	d2
	move.b	d1,d2
	divu	d0,d2
	ror.l	#8,d2
	ror.l	#8,d2			get remainder
	andi.l	#255,d2			mask off upper 24 bits
	ror.l	#8,d1
	eori.l	#$b798a43f,d1
	movea.l	4,a0
	move.l	DispCount(a0),d3
	eor.l	d3,d1
	move.l	d1,Rand

	movem.l	(a7)+,d0-d1/d3/a0
	rts

;	Increments the square d0.b and its neighbours (if necessary). Returns d4.b=0 if unsuccessful
;	(ie. square already occupied).

IncSquare	movem.l	d0-d3/a0,-(a7)

	clr.l	d1
	move.b	d0,d1
	move.w	d1,d0
	divu	Size,d1			row
	move.w	d1,d3
	mulu	Size,d3
	move.w	d0,d2
	sub.w	d3,d2			column

	move.b	#1,d4
	bsr	inc
	tst.b	d4
	beq	endincsq

	addq.w	#1,Count
	clr.b	d4
	subq.w	#1,d1
	bsr	inc
	addq.w	#2,d1
	bsr	inc
	subq.w	#1,d1
	subq.w	#1,d2
	bsr	inc
	addq.w	#2,d2
	bsr	inc
	move.b	#1,d4

endincsq	movem.l	(a7)+,d0-d3/a0
	rts

;	Increments value in button (d1,d2). Tests for invalidity. Doesn't increment if 0 and d4.b=0, or if
;	>0 and d4.b=1. Returns d4.b=0 for latter case.

inc	cmpi.w	#-1,d1
	beq	incerr
	cmpi.w	#-1,d2
	beq	incerr
	move.w	Size,d3
	cmp.w	d3,d1
	beq	incerr
	cmp.w	d3,d2
	beq	incerr
	mulu	d1,d3
	add.w	d2,d3
	add.w	d3,d3
	add.w	ntext,d3
	movea.l	TextMem,a0
	move.b	0(a0,d3.w),d0
	cmpi.b	#" ",d0
	bne	incok
	tst.b	d4
	beq	incerr
	move.b	#"1",d0
	bra	endinc
incok	tst.b	d4
	bne	incerr
	addq.b	#1,d0
	cmpi.b	#"5",d0
	bne	endinc
	move.b	#"1",d0
endinc	move.b	d0,0(a0,d3.w)
	rts
incerr	clr.b	d4
	rts

;	Clear the buttons (reset to zero)

Clear	movem.l	d0/a0,-(a7)

	movea.l	TextMem,a0
	adda.w	ntext,a0
	move.w	Size,d0
	mulu	d0,d0
clearlp	move.b	#" ",(a0)
	adda.w	#2,a0
	subq.w	#1,d0
	bne	clearlp
	bsr	Reset

	movem.l	(a7)+,d0/a0
	rts

;	Initialise a new board

Shuffle	movem.l	d0-d4/a0-a1,-(a7)

	movea.l	TextMem,a0
	movea.l	a0,a3
	move.w	Size,d0
	mulu	d0,d0
	move.w	d0,d3
	add.w	d0,d0
	
wipe	move.b	#" ",(a0)
	adda.w	#2,a0
	subq.w	#1,d0
	bne	wipe

	movea.l	a3,a0
	move.w	d3,d1
	move.w	ntext,-(a7)
	clr.w	ntext

shuflp	moveq.b	#2,d0
	bsr	GetRand
	move.b	d2,d5			direction to move if square is already occupied
	move.w	d3,d0
	bsr	GetRand
trynext	move.b	d2,d0
	bsr	IncSquare
	tst.b	d4
	bne	wasempty

	tst.b	d5
	beq	prevsq
	addq.b	#1,d2
	cmp.b	d3,d2
	bne	trynext
	clr.b	d2
	bra	trynext
prevsq	subq.b	#1,d2
	cmpi.b	#-1,d2
	bne	trynext
	move.b	d3,d2
	subq.b	#1,d2
	bra	trynext

wasempty	subq.w	#1,d1
	bne	shuflp

	clr.w	Count

	move.w	(a7)+,ntext
	movem.l	(a7)+,d0-d4/a0-a1
	rts

;	Initialise the window title bar and move count

Reset	clr.w	Count
	movea.l	MyWindow,a0
	lea	MainTxt,a1
	movea.w	#-1,a2
	CALLINT	SetWindowTitles
	rts

;	Check to see if the user has won the game, and set the title bar accordingly

TestWin	movea.l	TextMem,a0
	movea.l	a0,a1
	adda.w	ntext,a1
	move.w	Size,d0
	mulu	d0,d0
	subq.w	#1,d0

testlp	cmp.w	(a0)+,(a1)+
	dbne	d0,testlp
	cmpi.w	#-1,d0
	beq	win

	movea.l	MyWindow,a0
	lea	LoseTxt,a1
	movea.w	#-1,a2
	CALLINT	SetWindowTitles
	rts

win	movea.l	MyWindow,a0
	lea	WinTxt,a1
	movea.w	#-1,a2
	CALLINT	SetWindowTitles
	rts

	SECTION	Data,DATA

IntName	INTNAME
DosName	DOSNAME
GfxName	GRAFNAME
GadName	dc.b	"gadtools.library"

DefFont	dc.l	0
	dc.w	0
	dc.b	0,0

Size	dc.w	3

WinTags	dc.l	WA_Left,50
	dc.l	WA_Top,50
	dc.l	WA_Width
winwidth	dc.l	0
	dc.l	WA_Height
winheight	dc.l	0
	dc.l	WA_IDCMP,CLOSEWINDOW!GADGETUP!VANILLAKEY
	dc.l	WA_Gadgets,glist
	dc.l	WA_Title,MainTxt
	dc.l	WA_DragBar,1
	dc.l	WA_DepthGadget,1
	dc.l	WA_CloseGadget,1
	dc.l	0

MainTxt	dc.b	"Aniso",0
WinTxt	dc.b	"Well Done!",0
LoseTxt	dc.b	"Try Again...",0

Buttons	dc.w	8,0,0,0
	dc.l	NewTxt,DefFont
	dc.w	200
	dc.l	PLACETEXT_IN,0,BUTTON_KIND

	dc.w	0,0,0,0
	dc.l	RetryTxt,DefFont
	dc.w	201
	dc.l	PLACETEXT_IN,0,BUTTON_KIND

	dc.w	0,0,0,0
	dc.l	QuitTxt,DefFont
	dc.w	202
	dc.l	PLACETEXT_IN,0,BUTTON_KIND

	dc.w	0,0,0,0
	dc.l	0,DefFont
	dc.w	203
	dc.l	PLACETEXT_IN,0,CYCLE_KIND

NewTxt	dc.b	"_New",0
RetryTxt	dc.b	"_Retry",0
QuitTxt	dc.b	"_Quit",0

Tag1	dc.l	GTTX_Border,1,0

Tag2	dc.l	GT_Underscore,"_"
	dc.l	GTCY_Labels,Array
	dc.l	GTCY_Active
CycActive	dc.l	0,0

Array	dc.l	a1,a2,a3,a4,a5,a6,0
a1	dc.b	"3x3",0
a2	dc.b	"4x4",0
a3	dc.b	"5x5",0
a4	dc.b	"6x6",0
a5	dc.b	"7x7",0
a6	dc.b	"8x8",0

	SECTION	Variables,BSS

_IntuitionBase ds.l	1
_DOSBase	ds.l	1
_GadBase	ds.l	1
_GfxBase	ds.l	1

ReturnMsg	ds.l	1
SysFont	ds.l	1
ScrFont	ds.l	1
PubScr	ds.l	1
VisInfo	ds.l	1
MyWindow	ds.l	1
MyIdcmp	ds.l	1
CycleGad	ds.l	1
FirstBox	ds.l	1
FirstBut	ds.l	1

sfsize	ds.w	1
width	ds.l	1
nwidth	ds.l	1
height	ds.l	1
nheight	ds.l	1
ntext	ds.w	1

SizeCopy	ds.w	1
Rand	ds.l	1
GadMem	ds.l	1
TextMem	ds.l	1
Mem1	ds.l	1
Mem2	ds.l	1
Terminate	ds.w	1
Count	ds.w	1

glist	ds.l	44

	end
