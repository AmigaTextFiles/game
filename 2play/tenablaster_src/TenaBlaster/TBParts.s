
ShowPlayer1Coords
	lea	Player1DEF(a5),a0
	move.l	plBob(a0),a0
	movem.w	bobX(a0),d0/d1
	addq.w	#8,d0
	addq.w	#7,d1
	swap	d0
	move.w	d1,d0
	cmp.l	LastCoords,d0
	beq	.Loop3
	move.l	d0,-(sp)
	move.l	d0,LastCoords
	lea	CoordsText(pc),a0
	sub.l	a1,a1
.Loop	move.b	(a0)+,d0
	beq	.Loop3
	cmp.b	#'*',d0
	beq	.Loop2
	bsr	PrintSChar
	addq.w	#1,a1
	bra	.Loop
.Loop2	move.w	(sp)+,d3
	ext.l	d3
	bsr	PrintDECLong
	bra	.Loop
.Loop3	rts

LastCoords
	ds.l	1
	
CoordsText
	dc.b	"BOBX=*, BOBY=*",0
	even

PrintSChar
	ext.w	d0
	lea	Font-$20,a3
	add.w	d0,a3
	move.l	SysPlaneA(a5),a2
	add.l	a1,a2
	move.b	0*FMOD(a3),0*42*5(a2)
	move.b	1*FMOD(a3),1*42*5(a2)
	move.b	2*FMOD(a3),2*42*5(a2)
	move.b	3*FMOD(a3),3*42*5(a2)
	move.b	4*FMOD(a3),4*42*5(a2)
	move.b	5*FMOD(a3),5*42*5(a2)
	move.b	6*FMOD(a3),6*42*5(a2)
	move.b	7*FMOD(a3),7*42*5(a2)
	rts

PrintDECLong
	move.w	#1000,d2
	bsr	.A
	move.w	#100,d2
	bsr	.A
	move.w	#10,d2
	bsr	.A
	move.w	#1,d2
.A	divu	d2,d3
	add.b	#$30,d3
	move.b	d3,d0
	clr.w	d3
	swap	d3
	bsr	PrintSChar
	addq.w	#1,a1
	rts

;--------------------------------------------
;Init fenyreklam
InitFReklam
	move.l	PlaneB(a5),d0
	move.l	d0,SPlaneA(a5)
	add.l	#44,d0
	move.l	d0,SPlaneB(a5)
	move.l	SPlaneA(a5),a1
	moveq	#0,d1
.Loop1	moveq	#0,d0
.Loop2	move.l	a1,a2
	add.w	d0,a2
	lea	ScrollMask(pc),a0
	move.b	(a0)+,0*44*2(a2)
	move.b	(a0)+,1*44*2(a2)
	move.b	(a0)+,2*44*2(a2)
	move.b	(a0)+,3*44*2(a2)
	move.b	(a0)+,4*44*2(a2)
	move.b	(a0)+,5*44*2(a2)
	move.b	(a0)+,6*44*2(a2)
	move.b	(a0),7*44*2(a2)
	addq.w	#1,d0
	cmp.w	#44,d0
	blt	.Loop2
	add.l	#44*2*8,a1
	addq.w	#1,d1
	cmp.w	#2,d1
	blt	.Loop1
	move.l	copPalettaB(a5),a0
	addq.l	#2,a0
	lea	ScrollPal(pc),a1
	moveq	#3,d0
.Loop	move.w	(a1)+,(a0)+
	addq.w	#2,a0
	dbf	d0,.Loop
	clr.w	FRCount(a5)
	pea	FRText(pc)
	move.l	(sp)+,FRTextPtr(a5)
	rts

ScrollPal
	dc.w	$000,$310,$da0,$310
ScrollMask
	dc.b	%11111111
	dc.b	%10101010
	dc.b	%11111111
	dc.b	%10101010
	dc.b	%11111111
	dc.b	%10101010
	dc.b	%11111111
	dc.b	%10101010

FRText	dc.b	"!TENABLASTER! .C.1995 TENAX SOFTWARE"
	dc.b	" ! THE ULTIMATE MULTI PLAYER GAME ! "
	dc.b	" TENABLASTER WAS PROGRAMMED DESIGNED AND"
	dc.b	" UPDATED BY PETER BAKOTA, SOFTWARE CONSULTANT JOSEPH KURINA"
	dc.b	" ARTWORX BY TIBERIUS CHONKAS ...                       "
	dc.b	0
	even
			
FReklam	lea	$dff000,a6
.WBlt	btst	#6,$2(a6)
	bne	.WBlt
	move.w	#$e9f0,$40(a6)
	move.l	#$ffffffff,$44(a6)
	move.w	#42,$64(a6)
	move.w	#42,$66(a6)
	move.l	SPlaneB(a5),a1
	move.l	a1,a0
	subq.w	#2,a1
	movem.l	a0/a1,$50(a6)
	move.w	#16<<6+23,$58(a6)
	subq.w	#1,FRCount(a5)
	bpl	FRExit
	move.w	#7,FRCount(a5)
	move.l	FRTextPtr(a5),a0
	moveq	#0,d0
	move.b	(a0)+,d0
	bne	.NotEOL
	lea	FRText(pc),a0
.NotEOL	move.l	a0,FRTextPtr(a5)
	lea	CharTab(pc),a0
.Loop	cmp.b	(a0)+,d0
	beq	.Found
	tst.b	(a0)
	bpl	.Loop
	moveq	#0,d0
	bra	FRBlankChar
.Found	move.l	a0,d0
	sub.l	#CharTab+1,d0
FRBlankChar
	add.w	d0,d0
	lea	FRFont,a0
	add.w	d0,a0
	move.l	SPlaneB(a5),a1
	add.w	#42,a1
.WBlt2	btst	#6,$2(a6)
	bne	.WBlt2
	move.w	#$9f0,$40(a6)
	move.w	#40*2-2,$64(a6)
	move.w	#44*2-2,$66(a6)
	movem.l	a0/a1,$50(a6)
	move.w	#16<<6+1,$58(a6)
FRExit	rts

ClearSPaletta
	move.l	copPalettaB(a5),a0
	moveq	#3,d0
.Loop	clr.w	(a0)+
	addq.w	#2,a0
	dbf	d0,.Loop
	rts


MakeEHBF
	lea	$dff000,a6
.WBlt	btst	#6,$2(a6)
	bne	.WBlt
	clr.w	$60(a6)
	clr.w	$66(a6)
	move.l	#$030a0000,$40(a6)
	move.l	#$ffffffff,$44(a6)
	move.w	#$5555,$74(a6)
	move.l	a0,$48(a6)
	move.l	a0,$54(a6)
	bra	BltAllPlanes
	
;objectnb=d0,temp1=a0,(temp2=a2),dest=a1
ZoomBlock
	move.l	PlaneC(a5),a2
	movem.l	a0/a1,-(sp)
	move.l	a2,a1
	lsl.w	#2,d0
	lea	ObjectsAddress(a5),a0
	move.l	(a0,d0.w),a0
	moveq	#15,d0
.Loop	move.w	0*40(a0),(a1)+
	move.w	1*40(a0),(a1)+
	move.w	2*40(a0),(a1)+
	move.w	3*40(a0),(a1)+
	move.w	4*40(a0),(a1)+
	add.l	#40*5,a0
	dbf	d0,.Loop
	move.l	(sp),a1
	move.l	a2,a0
	moveq	#4,d0
	moveq	#4,d1
	moveq	#1*5,d2
	moveq	#16,d3
	bsr	Zoom
	movem.l	(sp)+,a0/a1
	move.w	#$09f0,$40(a6)
	move.w	#$ffff,$46(a6)
	move.w	#4*2*5-8,$64(a6)
	move.w	#42*5-8,$66(a6)
	moveq	#4,d0
.Loop2	movem.l	a0/a1,$50(a6)
	move.w	#(16*4)<<6+4,$58(a6)
	addq.l	#4*2,a0
	add.l	#42,a1
.WBlt	btst	#6,$2(a6)
	bne	.WBlt
	dbf	d0,.Loop2
	rts

OptionsPointTB
	dc.l	7+4*8*42*5	;Player	1
	dc.l	7+5*8*42*5	;Player 2
	dc.l	7+6*8*42*5	;Player	3
	dc.l	7+7*8*42*5	;Player	4
	dc.l	7+8*8*42*5	;Player 5
	dc.l	7+13*8*42*5	;Wins
	dc.l	7+15*8*42*5	;Players
	dc.l	7+17*8*42*5	;Shop
	dc.l	7+19*8*42*5	;Shrinking
	dc.l	7+21*8*42*5	;Start money
	dc.l	7+23*8*42*5	;Level
	dc.l	7+25*8*42*5	;Gambling
	dc.l	7+28*8*42*5	;Start game

OptionsMain
	bsr	InitABPlanes
	move.l	PlaneA(a5),d0
	move.l	CopperListA(a5),a0
	bsr	MakeCList42
	move.l	CopperListA(a5),a0
	bsr	SetCopperList
	move.l	PlaneA(a5),a0
	bsr	ClearPlane
	move.l	PlaneB(a5),a0
	bsr	ClearPlane
	move.l	PlaneC(a5),a0
	bsr	ClearPlane
	moveq	#6,d0
	moveq	#1,d1
	moveq	#30,d2
	moveq	#8,d3
	moveq	#16,d4
	bsr	DrawBoxA
	moveq	#6,d0
	moveq	#10,d1
	moveq	#30,d2
	moveq	#19,d3
	moveq	#16,d4
	bsr	DrawBoxA
	move.l	PlaneA(a5),a0
	bsr	CopyToBkg
	lea	OptionsText(pc),a0
	sub.l	a1,a1
	moveq	#1,d1
	bsr	PrintTextLinesA
	bsr	PrintWinsNeeded
	bsr	PrintPlayersNb
	bsr	PrintLevelCode
	bsr	PrintStartMoney
	bsr	PrintGlobalFlags
	bsr	PrintPlayersDef
	lea	DefaultPaletta(pc),a1
	clr.w	(a1)
	bsr	SetCopPaletta
	move.w	#MAXOPTIONS,OPNumber(a5)
	clr.b	OPLastStick(a5)
OptionsLoop
	bsr	WaitBOF
	moveq	#bxPOINTER,d0
	lea	OptionsPointTB(pc),a1
	bsr	PrintPointer
	tst.b	$45+KBMatrix(a5)
	bne	.Exit
	moveq	#1,d0
	bsr	ReadNrmJoystick
	btst	#bitFire,d0
	bne	.Wait
	cmp.b	OPLastStick(a5),d0
	beq	OptionsLoop
	move.b	d0,OPLastStick(a5)
	btst	#bitLeft,d0
	bne	.OptLEFT
	btst	#bitRight,d0
	bne	.OptRIGHT
	btst	#bitUp,d0
	bne	.OptOpUp
	btst	#bitDown,d0
	bne	.OptOpDown
	bra	OptionsLoop
.OptOpUp
	moveq	#$20,d0
	lea	OptionsPointTB(pc),a1
	bsr	PrintPointer
	MakeFx	OptionsFx
	subq.w	#1,OPNumber(a5)
	bpl	OptionsLoop
	move.w	#MAXOPTIONS,OPNumber(a5)
	bra	OptionsLoop

.OptOpDown
	moveq	#$20,d0
	lea	OptionsPointTB(pc),a1
	bsr	PrintPointer
	MakeFx	OptionsFx
	addq.w	#1,OPNumber(a5)
	cmp.w	#MAXOPTIONS+1,OPNumber(a5)
	bne	OptionsLoop
	clr.w	OPNumber(a5)
	bra	OptionsLoop
	
.OptLEFT
	move.w	OPNumber(a5),d0
	lsl.w	#2,d0
	jsr	.OptJump1(pc,d0.w)
	bra	OptionsLoop
.OptJump1
	bra.w	OPPlayerSettingsL
	bra.w	OPPlayerSettingsL
	bra.w	OPPlayerSettingsL
	bra.w	OPPlayerSettingsL
	bra.w	OPPlayerSettingsL
	bra.w	OPWinsL
	bra.w	OPPlayersL
	bra.w	OPShopL
	bra.w	OPShrinkingL
	bra.w	OPStartMoneyL
	bra.w	OPLevelL
	bra.w	OPGamblingL
	bra.w	OPNop
		
.OptRIGHT
	move.w	OPNumber(a5),d0
	lsl.w	#2,d0
	jsr	.OptJump2(pc,d0.w)
	bra	OptionsLoop
.OptJump2
	bra.w	OPPlayerSettingsR
	bra.w	OPPlayerSettingsR
	bra.w	OPPlayerSettingsR
	bra.w	OPPlayerSettingsR
	bra.w	OPPlayerSettingsR
	bra.w	OPWinsR
	bra.w	OPPlayersR
	bra.w	OPShopR
	bra.w	OPShrinkingR
	bra.w	OPStartMoneyR
	bra.w	OPLevelR
	bra.w	OPGamblingR
	bra.w	OPNop
		
.Wait	btst	#7,$bfe001
	beq	.Wait
	cmp.w	#MAXOPTIONS,OPNumber(a5)
	bne	OptionsLoop
	tst.w	StartMoney(a5)
	beq	.Exit
	lea	PlayersTB(pc),a0
	moveq	#4,d0
.Loop	move.l	(a0)+,a1
	add.l	a5,a1
	move.w	StartMoney(a5),plMoney(a1)
	dbf	d0,.Loop
.Exit	rts

; -----------------------------------
OPPlayerSettingsR
	move.w	OPNumber(a5),d0
	lsl.w	#2,d0
	lea	PlayersTB(pc),a1
	move.l	(a1,d0.w),a1
	add.l	a5,a1
	cmp.b	#ctKeyb,plControl(a1)
	beq	RedefineKeys
	addq.b	#1,plControl(a1)
	bra	PrintPlayerControl
		
RedefineKeys
OPNop	rts

OPPlayerSettingsL
	move.w	OPNumber(a5),d0
	lsl.w	#2,d0
	lea	PlayersTB(pc),a1
	move.l	(a1,d0.w),a1
	add.l	a5,a1
	tst.b	plControl(a1)
	beq	EnterPlayerName
	subq.b	#1,plControl(a1)
PrintPlayerControl
	moveq	#0,d0
	move.b	plControl(a1),d0
	move.w	OPNumber(a5),d1
	bsr	PrintControlType
	rts

EnterPlayerName
	lea	plName(a1),a0
	move.w	OPNumber(a5),d1
	bsr	EnterString
	rts
;-------------------------------
OPWinsR	cmp.w	#9,WinsNeeded(a5)
	beq	OPError
	addq.w	#1,WinsNeeded(a5)
	bra	PrintWinsNeeded

OPWinsL	cmp.w	#3,WinsNeeded(a5)
	beq	OPError
	subq.w	#1,WinsNeeded(a5)
PrintWinsNeeded
	move.w	WinsNeeded(a5),d0
	lea	22+13*8*42*5,a1
	moveq	#1,d1
	bsr	PrintDECNum
	rts

OPError	MakeFx	TimeBFx
	rts
	
;-------------------------------

OPPlayersR
	cmp.w	#5,PlayersNb(a5)
	beq	OPError
	addq.w	#1,PlayersNb(a5)
	bra	PrintPlayersNb

OPPlayersL
	cmp.w	#2,PlayersNb(a5)
	beq	OPError
	subq.w	#1,PlayersNb(a5)
PrintPlayersNb
	move.w	PlayersNb(a5),d0
	lea	22+15*8*42*5,a1
	moveq	#1,d1
	bsr	PrintDECNum
OPRts	rts
;-------------------------------
OPShopR	btst	#bitSHOP,GlobalFlags(a5)
	bne	OPRts
	bset	#bitSHOP,GlobalFlags(a5)
	lea	22+17*8*42*5,a1
PrintOnText
	lea	OnText(pc),a0
	moveq	#1,d1
	bsr	PrintTextLinesA
	rts

OPShopL	btst	#bitSHOP,GlobalFlags(a5)
	beq	OPRts
	bclr	#bitSHOP,GlobalFlags(a5)
	lea	22+17*8*42*5,a1
PrintOffText
	lea	OffText(pc),a0
	moveq	#1,d1
	bsr	PrintTextLinesA
	rts
;-----------------------------------
OPShrinkingR
	btst	#bitSHRINKING,GlobalFlags(a5)
	bne	OPRts
	bset	#bitSHRINKING,GlobalFlags(a5)
	lea	22+19*8*42*5,a1
	bra	PrintOnText

OPShrinkingL
	btst	#bitSHRINKING,GlobalFlags(a5)
	beq	OPRts
	bclr	#bitSHRINKING,GlobalFlags(a5)
	lea	22+19*8*42*5,a1
	bra	PrintOffText
;------------------------------------
OPStartMoneyR
	cmp.w	#12,StartMoney(a5)
	beq	OPError
	addq.w	#1,StartMoney(a5)
	bra	PrintStartMoney

OPStartMoneyL
	tst.w	StartMoney(a5)
	beq	OPError
	subq.w	#1,StartMoney(a5)
PrintStartMoney	
	lea	22+21*8*42*5,a1
	move.w	StartMoney(a5),d0
	beq	PrintOffText
	moveq	#1,d1
	bsr	PrintDECNum
	rts
;------------------------------------
	
OPLevelR
	cmp.w	#lcRANDOM,LevelCode(a5)
	beq	OPError
	addq.w	#1,LevelCode(a5)
	bra	PrintLevelCode

OPLevelL
	tst.w	LevelCode(a5)
	beq	OPError
	subq.w	#1,LevelCode(a5)
PrintLevelCode
	move.w	LevelCode(a5),d0
	lea	LTypes(pc),a0
	lea	22+23*8*42*5,a1
	moveq	#1,d1
	bsr	PrintOptionText
	rts

LTypes	dc.w	NorText-LTypes
	dc.w	MadText-LTypes
	dc.w	NowText-LTypes
	dc.w	RanText-LTypes

NorText	dc.b	"NORMAL  ",0
MadText	dc.b	"MAD     ",0
NowText	dc.b	"NO WALLS",0
RanText	dc.b	"RANDOM  ",0
;-------------------------------
OPGamblingR
	btst	#bitGAMBLING,GlobalFlags(a5)
	bne	OPRts
	bset	#bitGAMBLING,GlobalFlags(a5)
	lea	22+25*8*42*5,a1
PrintYesText
	lea	YesText(pc),a0
	moveq	#1,d1
	bsr	PrintTextLinesA
	rts

OPGamblingL
	btst	#bitGAMBLING,GlobalFlags(a5)
	beq	OPRts
	bclr	#bitGAMBLING,GlobalFlags(a5)
	lea	22+25*8*42*5,a1
PrintNoText
	lea	NoText(pc),a0
	moveq	#1,d1
	bsr	PrintTextLinesA
	rts
		
;----------------------------
PrintPlayersDef
	lea	PlayersTB(pc),a0
	moveq	#0,d1
.Loop	move.l	(a0)+,a1
	add.l	a5,a1
	movem.l	d1/a0,-(sp)
	moveq	#0,d0
	move.b	plControl(a1),d0
	move.w	d0,-(sp)
	lea	plName(a1),a0
	move.w	d1,d0
	mulu	#8*42*5,d0
	lea	9+4*8*42*5,a1
	add.l	d0,a1
	moveq	#2,d1
	bsr	PrintTextLinesA
	move.w	(sp)+,d0
	move.w	2(sp),d1
	bsr	PrintControlType
	movem.l	(sp)+,d1/a0
	addq.w	#1,d1
	cmp.w	#5,d1
	bne	.Loop
	rts
	
PrintGlobalFlags
	lea	OnText(pc),a0
	lea	22+17*8*42*5,a1
	btst	#bitSHOP,GlobalFlags(a5)
	bne	.A
	lea	OffText(pc),a0
.A	moveq	#1,d1
	bsr	PrintTextLinesA
	lea	OnText(pc),a0
	lea	22+19*8*42*5,a1
	btst	#bitSHRINKING,GlobalFlags(a5)
	bne	.B
	lea	OffText(pc),a0
.B	moveq	#1,d1
	bsr	PrintTextLinesA
	lea	YesText(pc),a0
	lea	22+25*8*42*5,a1
	btst	#bitGAMBLING,GlobalFlags(a5)
	bne	.C
	lea	NoText(pc),a0
.C	moveq	#1,d1
	bsr	PrintTextLinesA
	rts
	
;player number=d1, controltype=d0
PrintControlType
	lea	CTypes(pc),a0
	lea	21+4*8*42*5,a1
	mulu	#8*42*5,d1
	add.l	d1,a1
	moveq	#2,d1
	bsr	PrintOptionText
	rts

CTypes	dc.w	Joy1Text-CTypes
	dc.w	Joy2Text-CTypes
	dc.w	Joy3Text-CTypes
	dc.w	Joy4Text-CTypes
	dc.w	KeybText-CTypes
Joy1Text
	dc.b	"JOYSTICK #1",0
Joy2Text
	dc.b	"JOYSTICK #2",0
Joy3Text
	dc.b	"PARALEL  #1",0
Joy4Text
	dc.b	"PARALEL  #2",0
KeybText
	dc.b	"KEYBOARD   ",0
	even
	
; -------------------------------
;buffer=a0, playernum=d1
EnterString
	moveq	#7,d3
	mulu	#42*5*8,d1
	add.l	#9+4*8*42*5,d1
	move.l	d1,a1
	add.w	d3,a1
	moveq	#bxCURSOR,d4
.EnterLoop
	eor.b	#$60,d4
	bsr	WaitBOF
	move.b	d4,d0
	moveq	#31,d1
	bsr	PrintAChar
	move.b	KBLastK(a5),d0
	beq	.EnterLoop
	clr.b	KBLastK(a5)
	cmp.b	#$d,d0
	beq	.EndOfInput
	cmp.b	#$8,d0
	beq	.BS
	cmp.b	#$20,d0
	blt	.EnterLoop
	cmp.b	#$60,d0
	bge	.EnterLoop
	cmp.w	#7,d3
	beq	.EnterLoop
	move.b	d0,(a0,d3.w)
	moveq	#2,d1
	bsr	PrintAChar
	addq.w	#1,d3
	addq.w	#1,a1
	bra	.EnterLoop
.BS	tst.w	d3
	beq	.EnterLoop
	moveq	#$20,d0
	move.b	d0,-1(a0,d3.w)
	bsr	PrintAChar
	subq.w	#1,d3
	subq.w	#1,a1
	bra	.EnterLoop
.EndOfInput
	moveq	#$20,d0
	bsr	PrintAChar
.Loop2	cmp.w	#$7,d3
	beq	.NoFill
	move.b	#$20,(a0,d3.w)
	addq.w	#1,d3
	bra	.Loop2
.NoFill	rts

;optioinNum=d0, pen=d1, printoffset=a1
PrintOptionText
	add.w	d0,d0
	add.w	(a0,d0.w),a0
	bsr	PrintTextLinesA
	rts
	
MAXOPTIONS	EQU	12

OptionsText
	dc.b	"tttttp31;  MAIN MENU",$a
	dc.b	$a
	dc.b	"tttp8;PLAYERS:",$a
	dc.b	$a
	dc.b	$a
	dc.b	$a
	dc.b	$a
	dc.b	$a
	dc.b	$a
	dc.b	$a
	dc.b	$a
	dc.b	"tttp8;OPTIONS:",$a,$a
	dc.b	"tttp1;WINS NEEDED :",$a,$a
	dc.b	"tttPLAYERS     :",$a,$a
	dc.b	"tttSHOP        :",$a,$a
	dc.b	"tttSHRINKING   :",$a,$a
	dc.b	"tttSTARTMONEY  :",$a,$a
	dc.b	"tttLEVEL       :",$a,$a
	dc.b	"tttGAMBLING    :",$a,$a
	dc.b	$a
	dc.b	"tttp2;START GAME ..."
	dc.b	0

OnText	dc.b	"ON ",0
OffText	dc.b	"OFF",0
YesText	dc.b	"YES",0
NoText	dc.b	"NO ",0
	even

FadeIn	move.l	copPaletta(a5),a0
	addq.w	#2,a0
	movem.l	a0/a1,-(sp)
	moveq	#15,d2
.loop1	movem.l	(sp),a0/a1
	moveq	#31,d3
.loop2	move.w	(a0),d0
	move.w	(a1),d1
	and.w	#$00f,d0
	and.w	#$00f,d1
	cmp.w	d0,d1
	beq	.bloop
	addq.w	#1,(a0)
.bloop	move.w	(a0),d0
	move.w	(a1),d1
	and.w	#$0f0,d0
	and.w	#$0f0,d1
	cmp.w	d0,d1
	beq	.gloop
	add.w	#$10,(a0)
.gloop	move.w	(a0),d0
	move.w	(a1),d1
	and.w	#$f00,d0
	and.w	#$f00,d1
	cmp.w	d0,d1
	beq	.rloop
	add.w	#$100,(a0)
.rloop	addq.w	#4,a0
	addq.w	#2,a1
	dbf	d3,.loop2
	bsr	WaitBOF
	bsr	WaitBOF
	bsr	WaitBOF
	bsr	WaitBOF
	dbf	d2,.loop1
	addq.w	#4+4,sp
	rts

FadeOut	move.l	copPaletta(a5),a0
	addq.w	#2,a0
	move.l	a0,-(sp)
	moveq	#15,d2
.loop1	move.l	(sp),a0
	moveq	#31,d3
.loop2	move.w	(a0),d0
	and.w	#$00f,d0
	beq	.bloop
	subq.w	#1,(a0)
.bloop	move.w	(a0),d0
	and.w	#$0f0,d0
	beq	.gloop
	sub.w	#$10,(a0)
.gloop	move.w	(a0),d0
	and.w	#$f00,d0
	beq	.rloop
	sub.w	#$100,(a0)
.rloop	addq.w	#4,a0
	dbf	d3,.loop2
	bsr	WaitBOF
	bsr	WaitBOF
	bsr	WaitBOF
	bsr	WaitBOF
	dbf	d2,.loop1
	addq.w	#4,sp
	rts

;------------------------------------
FadeIn	MOVE.L	A1,A0
	MOVE.L	copPaletta(a5),a1
	addq.w	#2,a1
	MOVE.L	#$3F,D6
lbC00000A
	MOVEM.L	A0/A1,-(SP)
.lbC00000A
	CMP.B	#$FF,$DFF006
	BNE.S	.lbC00000A
	MOVE.L	#$1F,D4
lbC000026
	MOVE.L	D6,D7
	LSR.L	#2,D7
	JSR	lbC0000B2
	DBRA	D4,lbC000026
	MOVEM.L	(SP)+,A0/A1
	SUBQ.L	#1,D6
	BPL.S	lbC00000A
	RTS

FadeOut	MOVE.L	A1,A0
	MOVE.L	copPaletta(a5),a1
	addq.w	#2,a1
	MOVE.L	#0,D6
lbC000056
	MOVEM.L	A0/A1,-(SP)
.lbC000056
	CMP.B	#$FF,$DFF006
	BNE.S	.lbC000056
	MOVE.L	#$1F,D4
lbC000072
	MOVE.L	D6,D7
	LSR.L	#2,D7
	JSR	lbC0000B2
	DBRA	D4,lbC000072
	MOVEM.L	(SP)+,A0/A1
	ADDQ.L	#1,D6
	CMP.L	#$40,D6
	BNE.S	lbC000056
	RTS

lbC0000B2
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	AND.W	#$F00,D0
	LSR.W	#4,D0
	LEA	FadeSinTab(pc),A2
	ADD.L	D7,A2
	MOVE.B	0(A2,D0.W),D1
	MOVE.W	(A0),D0
	AND.W	#$F0,D0
	MOVE.B	0(A2,D0.W),D2
	MOVE.W	(A0),D0
	AND.W	#15,D0
	LSL.W	#4,D0
	MOVE.B	0(A2,D0.W),D3
	MOVEQ	#0,D0
	MOVE.B	D1,D0
	LSL.W	#4,D0
	ADD.B	D2,D0
	LSL.W	#4,D0
	ADD.B	D3,D0
	MOVE.W	D0,(A1)
	ADDQ.L	#2,A0
	ADDQ.L	#4,A1
	RTS

FadeSinTab
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$02,$02,$02,$02,$02,$01,$01
	dc.b	$01,$01,$01,$01,$00,$00,$00,$00,$00,$03,$03,$03,$03
	dc.b	$02,$02,$02,$02,$01,$01,$01,$01,$00,$00,$00,$00,$04
	dc.b	$04,$04,$03,$03,$03,$03,$02,$02,$02,$01,$01,$01,$00
	dc.b	$00,$00,$05,$05,$05,$04,$04,$03,$03,$03,$02,$02,$01
	dc.b	$01,$01,$00,$00,$00,$06,$06,$05,$05,$05,$04,$04,$03
	dc.b	$03,$02,$02,$02,$01,$01,$00,$00,$07,$07,$06,$06,$05
	dc.b	$05,$04,$04,$03,$03,$02,$02,$01,$01,$00,$00,$08,$08
	dc.b	$07,$07,$06,$06,$05,$04,$04,$03,$03,$02,$02,$01,$00
	dc.b	$00,$09,$09,$08,$08,$07,$06,$06,$05,$05,$04,$03,$03
	dc.b	$02,$02,$01,$00,$0A,$0A,$09,$08,$08,$07,$06,$05,$05
	dc.b	$04,$03,$02,$02,$01,$00,$00,$0B,$0B,$0A,$09,$08,$08
	dc.b	$07,$06,$05,$05,$04,$03,$02,$02,$01,$00,$0C,$0C,$0B
	dc.b	$0A,$09,$08,$08,$07,$06,$05,$04,$04,$03,$02,$01,$00
	dc.b	$0D,$0C,$0B,$0A,$0A,$09,$08,$07,$06,$05,$04,$04,$03
	dc.b	$02,$01,$00,$0E,$0D,$0C,$0B,$0A,$09,$08,$08,$07,$06
	dc.b	$05,$04,$03,$02,$01,$00,$0F,$0E,$0D,$0C,$0B,$0A,$09
	dc.b	$08,$07,$06,$05,$04,$03,$02,$01,$00

Random	MOVE.L	D1,-(SP)
	MOVE.B	$BFE401,D1
	ADD.B	$BFE601,D1
	ASL.W	#8,D1
	ADD.B	$BFE501,D1
	ADD.B	$BFE701,D1
	ADD.L	RndSeed(A5),D1
	ASL.L	#2,D1
	ADD.L	D1,RndSeed(A5)
	ASL.L	#3,D1
	ADD.L	D1,RndSeed(a5)
	ADD.L	D1,D1
	ADD.L	D1,RndSeed(a5)
	ADD.L	D1,D1
	ADD.L	D1,RndSeed(a5)
	ADD.L	D1,D1
	ADD.L	D1,RndSeed(a5)
	ADD.L	D1,D1
	ADD.L	D1,RndSeed(a5)
	ADD.L	D1,D1
	ADD.L	D1,D1
	ADD.L	RndSeed(a5),D1
	ADDI.L	#$29,D1
	ADD.W	$DFF006,D1
	SWAP	D1
	MOVE.L	D1,RndSeed(a5)
	AND.L	#$FFFF,D1
	EXG	D0,D1
	DIVU	D1,D0
	SWAP	D0
	MOVE.L	(SP)+,D1
	RTS
	

* DString=a0, PrintOffset=a1, colorpen=d1

PrintDString
	move.b	d1,d5
	moveq	#0,d4
.Loop1	move.b	(a0)+,d0
	beq	.Loop2
	bsr	PrintDChar
	bchg	#0,d4
	beq	.Loop1
	addq.w	#1,a1
	bra	.Loop1
.Loop2	rts

PrintDChar
	sub.b	#$30,d0
	ext.w	d0
	moveq	#-$10,d1
	lsr.w	d0
	bcc	.Loop1
	not.b	d1
.Loop1	movem.l	d5/a1,-(sp)
	lea	DGFont(pc),a0
	add.w	d0,a0
	moveq	#4,d6
.Loop5	move.l	a0,-(sp)
	move.l	a1,a2
	lsr.b	d5
	bcs	.Loop6
	moveq	#7,d3
.Loop8	moveq	#-$10,d2
	btst	#0,d4
	bne	.Loop7
	not.b	d2
.Loop7	and.b	d2,(a2)
	add.w	#42*5,a2
	dbf	d3,.Loop8
	bra	.Loop9

.Loop6	moveq	#7,d3
.Loop2	move.b	(a0),d0
	and.b	d1,d0
	tst.b	d1
	bpl	.Loop3
	lsr.b	#4,d0
.Loop3	moveq	#-$10,d2
	btst	#0,d4
	bne	.Loop4
	lsl.b	#4,d0
	not.b	d2
.Loop4	and.b	d2,(a2)
	or.b	d0,(a2)
	add.w	#6,a0
	add.w	#42*5,a2
	dbf	d3,.Loop2
.Loop9	move.l	(sp)+,a0
	add.w	#42,a1
	dbf	d6,.Loop5
	movem.l	(sp)+,d5/a1
	rts
	
