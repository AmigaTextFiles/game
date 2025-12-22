;*********************************************************************
;*
;* Space Pilot Of Death (SPOD)
;*
;* Author: Marten W.
;* Date  : 2021
;*
;* Conntact: nefitzlo2@gmx.de 
;*           www.goldmomo.org
;*
;*********************************************************************


	incdir	"Work:Assembler/SpacePilotOfDeath/"	;not needed if make/assembler in same directory
	include "include/global.i"
	include "include/custom.i"
	include "include/macros.i"
	include "include/pt_replay.i"

;************************************************
;* planes defines
;************************************************

SCREEN_WIDTH		equ 320
SCREEN_HEIGHT		equ 224	

BG_VSCREEN_X_OFFSET	equ 16
BG_VSCREEN_WIDTH	equ 320+BG_VSCREEN_X_OFFSET	
BG_VSCREEN_HEIGHT	equ SCREEN_HEIGHT	
BG_BITPLANES		equ 2

FG_LOGO_VSCREEN_WIDTH	equ 320
FG_LOGO_VSCREEN_HEIGHT	equ 72	
FG_LOGO_BITPLANES	equ 2

FG_TEXT_VSCREEN_WIDTH	equ 320
FG_TEXT_VSCREEN_HEIGHT	equ SCREEN_HEIGHT	;used by logo SCREEN_HEIGHT-FG_LOGO_VSCREEN_HEIGHT, used full in game
FG_TEXT_BITPLANES	equ 1
		
;************************************************
;* structs/defs (needed by macros)
;************************************************

	rsreset                  
sStone_gfxObjectAdr	rs.l	1        
sStone_state 		rs.w 	1        
sStone_x		rs.w	1 
sStone_y	   	rs.w	1 
sStone_xSpeed		rs.w	1 
sStone_ySpeed		rs.w	1  
sStone_sizeOf 	so              
		
;************************************************
;* start and init
;************************************************

	movem.l	d1-d7/a0-a6,-(sp)
	
        bsr	Init			;open libs and check cpu
	tst.l	d0
	bne	ErrorInit
	
	bsr	readHiscore
	
	bsr	OSOff			;stop os
		
	bsr	initKeyboard
	bsr	main
	bsr	releaseKeyboard
	bsr	OSOn 			;os recover   
			
	;debug

	IFD	DEBUG
	move	testVal4,-(sp)
	move	testVal3,-(sp)
	move	testVal2,-(sp)
	move	testVal1,-(sp)
	move	scanLinesUsed,-(sp)
	lea	scanLinesUsedText,a0
	move.l	sp,a1
	jsr	Printf	
	lea	10(sp),sp	
	ENDIF
	
	bsr	writeHiscore
		  
	bsr	Cleanup		;cleanup and end
	moveq.l	#0,d0
	
End	movem.l	(sp)+,d1-d7/a0-a6
	rts

ErrorInit
	bsr	Cleanup		;cleanup and end
	moveq.l	#1,d0
	bra.s	End

;************************************************
;* main
;************************************************	
	
main	
	
	lea	$dff000,a6	  
	move	#$85ef,$96(a6)		;audio, copper, blitter, sprites, bpl
	move	#$0010,$96(a6)		;DMACON no disk dma
	
	;generate star sprites
	
	bsr	genStarSprites	
			
	;generate star x positions
	
	bsr	randStarXArrays
	
	;set sprite ptrs to empty
	
	lea	logoSpr0+2,a0
	bsr	clearSprites
	
	;enable mod
	
	move.l	vecBase,a0
	moveq	#1,d0
	lea	$dff000,a6
	jsr	_mt_install_cia
	
.globalLoop	

	moveq	#0,d0
	lea	logoMod,a0
	suba.l	a1,a1
	lea	$dff000,a6
	jsr	_mt_init
	move.b	#1,_mt_Enable

	;logo 
	
	IFND	NOLOGO
	bsr	logoLoop
	move	logoReturn,d0	;return state
	cmp	#2,d0		;exit
	beq	.globalLoopExit
	ENDIF
	
	move.b	#0,_mt_Enable
	lea	$dff000,a6
	bsr	_mt_end
	
	IFD	LMQUIT
	btst	#6,$bfe001
        beq	.globalLoopExit
	ENDIF
	
	;game
	
	bsr	gameLoop
	
	;
	
	bra	.globalLoop
	
.globalLoopExit	
	
	;disable mod
	
	lea	$dff000,a6
	jsr	_mt_remove_cia
	
	lea	$dff000,a6
	jsr	_mt_end
	 	  		  
	rts
	
;************************************************
;*
;* gameLoop
;*
;* use *
;*
;************************************************

gameLoop

	;set and clear fg text bpl
	
	moveq	#FG_TEXT_BITPLANES-1,d1
	move.l	#fgPlane,d0
	lea	gameFgCopPl,a0
.setTxtFgPbl	
	move	d0,6(a0)
	swap	d0
	move	d0,2(a0)
	addq.l	#8,a0
	add.l	#(FG_TEXT_VSCREEN_WIDTH)/8,d0
	dbf	d1,.setTxtFgPbl
	
	lea	fgPlane,a0
	move.l	#((FG_TEXT_VSCREEN_WIDTH*FG_TEXT_VSCREEN_HEIGHT)/32*FG_TEXT_BITPLANES)-1,d0
	moveq	#$0,d1	;value
.clrFgTxtLoop
	move.l	d1,(a0)+
	dbf	d0,.clrFgTxtLoop
	
	;clear bg buffers
	
	move.l	bgPlaneBackground,a0
	bsr	clearBGHard
	move.l	bgPlaneFront,a0
	bsr	clearBGHard
	
	;set bpl for background (prevent 1 frame glitch)
	
	move.l	bgPlaneFront,d0
	add.l	#BG_VSCREEN_X_OFFSET/8,d0
	lea	gameBgCopPl+2,a0
	bsr	setBGBpls
	
	;init stones (all reset)
	
	move	#sStone_state_RESET,d0
	bsr 	initStones
	
	moveq	#MAX_STONES-1,d0
	lea	StoneObjects,a0 ;act one
.stAct	
	move	#sStone_state_ACTIVE,sStone_state(a0)	;set state
	lea	sStone_sizeOf(a0),a0
	dbf	d0,.stAct
	
	;clear gametime
	
	bsr	clearGameTimer
	
	;text
	
	moveq	#0,d0
	moveq	#0,d1
	lea	gameTextPower,a0
	bsr	drawFGText8x8
	
	moveq	#0,d0
	moveq	#8*1,d1
	lea	gameTextTime,a0
	bsr	drawFGText8x8
	
	;reset colors
	
	move	#$0,d0			
	bsr	resetFadeColors
	
	IFEQ    GAME_START_STATE,GAME_STATE_COLORS_UP
	
	lea	gameLogoLut,a0
	move	#(gameLogoLutEnd-gameLogoLut),d0
	lsr	#3,d0
	subq	#1,d0	
.setGCLoop	
	move	#0,d2		;no change
	bsr	fadeColors
	dbf	d0,.setGCLoop
	
	ENDIF
	
	;game ship
	
	bsr 	initGameShip
	
	;set star speed (also for prolog)
		
	lea	prologStarSpeed,a0
	move	#1+GAME_STAR_START_INC,d0
	move	#2+GAME_STAR_START_INC,d1
	move	#5+GAME_STAR_START_INC,d2
	move	#8+GAME_STAR_START_INC,d3
	movem	d0-d3,(a0)
	bsr	setStarsSpeed
	
	;set copperlist  
	
	move.l 	#copperListGame,$84(a6) 

	;init states
	
	move	#GAME_START_STATE,gameState
	clr	gameStateCounter
	move	#272,shipPower
	
	;game loop
	
.gameVBLoop

	;WAITVMIN	#IVSTOP
	WAITV	#IVSTOP
	
	GETVd0		
	move	d0,testVal4
	
	;move bg stars
	
	DEBC 	#$f00
	
	lea	gameSpr4,a0
	bsr	moveStars
	
	;swap screen buffers
	
	DEBC 	#$0ff
	
	lea	bgPlaneFront,a0
	lea	bgPlaneBackground,a1
	move.l	(a0),d0		;front
	move.l	(a1),d1		;bg
	move.l	d1,(a0)		;front
	move.l	d0,(a1)		;bg
	
	;set bpl for background
	
	move.l	bgPlaneFront,d0
	add.l	#BG_VSCREEN_X_OFFSET/8,d0
	lea	gameBgCopPl+2,a0
	bsr	setBGBpls
	
	;
	
	DEBC 	#$0f0
	
	;clear background
	
	move.l	bgPlaneBackground,a0
	bsr	clearBGHard
	
	;draw power bar
	
	DEBC 	#$f0f
	bsr	drawPowerBar
	
	;
	
	cmp	#GAME_STATE_PLAY,gameState
	bne	.noCollision
	move	gameShipData+sGameShip_state,d0
	btst	#GAME_SHIP_STATE_COLLISION_BIT,d0
	beq	.noCollision
	
	
	lea	sndSfxCollision,a0
	lea	$dff000,a6
	bsr	_mt_playfx
	
	move	shipPower,d0
	sub	#SHIP_CL_POWER_DEC,d0
	tst	d0
	bge	.powerGood
	clr	d0		;game over
.powerGood
	move	d0,shipPower
.noCollision
		
	;draw time
	
	DEBC 	#$0e0
	
	cmp	#GAME_STATE_PLAY,gameState
	bne	.noIncTimer
	bsr	incrementGameTimer
.noIncTimer
	
	DEBC 	#$666
	
	bsr	drawGameTimer
		
	;check keyboard and joy1
	
	DEBC 	#$00f
	bsr	checkKeyboard
	bsr	checkJoy1
	
	DEBC 	#$333
	
	cmp	#GAME_STATE_PLAY,gameState
	bne	.noShipMove
	bsr	checkShipMove
.noShipMove

	DEBC 	#$eee

	bsr	checkShipAnim
	
	DEBC 	#$abc
	
	;draw ship
	
	lea	gameShipData,a0
	movem	sGameShip_xy(a0),d0-d1
	move.l	sGameShip_gfxAdr(a0),a1
	
	lea	gameSpr0+2,a0
	bsr	moveShipSprite
	
	;move stones
	
	move	gameState,d0
	cmp	#GAME_STATE_PLAY,d0
	blo	.noStoneMove		;lower no stone move
	sne	d0			;equal move and rerand else no rerand after screen out
	bsr	moveStones
.noStoneMove	
		
	;check stones
	
	bsr	checkStones
		
	DEBC  	#$fff
			
	;draw stones

	bsr	drawStones
	
	;check collision
	
	bsr	checkShipCollision
	
	;color ship
	
	lea	gameColorShipEg,a0
	movem.l	(a0),d0/a1	;color, dest adr
	eor.l	#$008080,d0
	move.l	d0,(a0)
	move	fadeColorMul,d1
	bsr	colorDiv
	move	d0,(a1)		;write color
	
	;colors
	
	bsr	gameProcessColorState	
	
	;process prolog
	
	cmp	#GAME_STATE_PROLOG,gameState
	bne	.noProlog
	bsr	gameProcessPrologState
.noProlog

	;process epilog
	
	cmp	#GAME_STATE_EPILOG,gameState
	bne	.noEpilog
	bsr	gameProcessEpilogState
.noEpilog
	
	;process name input
	
	cmp	#GAME_STATE_NAME_INPUT,gameState
	bne	.noNameInput
	bsr	gameProcessNameInputState
.noNameInput
	
	;process hiscore
	
	cmp	#GAME_STATE_HISCORE,gameState
	bne	.noHiscore
	bsr	gameProcessHiscoreState
.noHiscore
	
	
	;process game states
	
	bsr	gameStateProcess
	
	GETVd0		
	sub	d0,testVal4
	
	;
	
	DEBC 	#$000
	
	btst	#6,$bfe001
        beq	.gameLoopEnd
	
	cmp	#GAME_STATE_END,gameState
	beq	.gameLoopEnd
	 
	bra	.gameVBLoop

.gameLoopEnd
	rts
	
;************************************************
;*
;* gameStateProcess
;*
;************************************************

gameStateProcess
	
	lea	gameState,a0
	lea	gameStateCounter,a1
	move	(a0),d0	;state
	move	(a1),d1 ;sub counter
	
	move	d0,d2
	and	#$7,d2
	add	d2,d2
	add	d2,d2
	move.l	gameStateFctLut(pc,d2.w),a2	;jump
	jsr	(a2)

	move	d0,(a0)
	move	d1,(a1)

	rts

	cnop	0,4
	
gameStateFctLut		dc.l	fctGAME_STATE_COLORS_UP		;colors from dark		
			dc.l	fctGAME_STATE_PROLOG		;decrease star speed		
			dc.l	fctGAME_STATE_PLAY		;game
			dc.l	fctGAME_STATE_EPILOG		;move ship out
			dc.l	fctGAME_STATE_NAME_INPUT	;name input when in hiscore
                        dc.l	fctGAME_STATE_HISCORE		;draw hiscore
                        dc.l	fctGAME_STATE_COLORS_DOWN	;colors to dark
			dc.l	fctGAME_STATE_END
			dc.l	fctGAME_STATE_END			
			

	cnop	0,4
	
fctGAME_STATE_COLORS_UP
	addq	#1,d1
	cmp	#50,d1
	ble	.gcupHoldState
	moveq	#0,d1
	move	#GAME_STATE_PROLOG,d0
.gcupHoldState	
	rts	
	
fctGAME_STATE_PROLOG	
	addq	#1,d1
	cmp	#400,d1
	ble	.gProHoldState
	moveq	#0,d1
	move	#GAME_STATE_PLAY,d0
.gProHoldState	
	rts	
	
fctGAME_STATE_PLAY	
	tst	shipPower
	bgt	.powerGood
	moveq	#0,d1
	move	#GAME_STATE_EPILOG,d0
.powerGood	
	rts	
	
fctGAME_STATE_EPILOG
	addq	#1,d1
	cmp	#400,d1
	ble	.gEpiHoldState	
	moveq	#0,d1
	move	#GAME_STATE_NAME_INPUT,d0
	move	#NISUB_STATE_START,nameInputSubState	;reset sub state
.gEpiHoldState		
	rts	
	
fctGAME_STATE_NAME_INPUT
	
	cmp	#NISUB_STATE_END,nameInputSubState
	bne	.gEpiHoldState	
	moveq	#0,d1
	move	#GAME_STATE_HISCORE,d0
	move	#HSSUB_STATE_START,hiscoreSubState	;reset hiscore sub state
.gEpiHoldState		
	rts		
	
fctGAME_STATE_HISCORE
	addq	#1,d1
	cmp	#HSSUB_STATE_FINISH,hiscoreSubState
	bne	.gHiscoreHoldState
	moveq	#0,d1	
	move	#GAME_STATE_COLORS_DOWN,d0
.gHiscoreHoldState	
	rts	
	
fctGAME_STATE_COLORS_DOWN	
	addq	#1,d1
	cmp	#100,d1
	ble	.gcdwnHoldState
	moveq	#0,d1
	move	#GAME_STATE_END,d0
.gcdwnHoldState	
	rts	
	
fctGAME_STATE_END	
	rts	
	
	
;************************************************
;*
;* gameProcessHiscoreState
;*
;************************************************
	
gameProcessNameInputState

	movem.l	d0-d2/a0-a4,-(sp)
	
	IFD	DEBUG
	move 	#$399,gameTime+2
	ENDIF

	move	nameInputSubState,d0	
	cmp	#NISUB_STATE_START,d0
	bne	.notStart
	;** START STATE
	;move	#NISUB_STATE_INPUT,nameInputSubState
	
	lea	clText+1,a1
	lea	clTextPos,a2
	lea	clCText,a3
	lea	clCurserCnt,a4
	moveq	#CLTextLength-1,d0
	bsr	initTextInput
	
	;check time
	
	move	gameTime+2,d0		; game time
	move.l	((HISCORE_LENGTH-1)*4)+hiscoreList,a0	;last entry in hiscore
	move	hiScore_min_sec(a0),d1	; time
		
	cmp	d0,d1
	bls	.inHiscore
	move	#NISUB_STATE_END,nameInputSubState
	bra	.finishGNIState
.inHiscore	
	move	#NISUB_STATE_INPUT,nameInputSubState
	bra	.finishGNIState
	
	
.notStart	
	cmp	#NISUB_STATE_INPUT,d0
	bne	.notInput
	;** INPUT STATE
	
	;draw text
	
	moveq	#12,d0
	moveq	#8*12,d1
	lea	gameTextInputName,a0
	bsr	drawFGText8x8
	
	;
	
	moveq	#13,d0
	moveq	#8*14,d1
	lea	clText,a0
	bsr	drawFGText8x8

	;
	
	moveq	#14,d0
	moveq	#8*15,d1
	lea	clCText,a0
	bsr	drawFGText8x8
	
	;process input
	
	lea	rawKey,a0
	movem	(a0),d0-d1	;current, last
	move	d0,2(a0)
	
	lea	clText+1,a1
	lea	clTextPos,a2
	lea	clCText,a3
	lea	clCurserCnt,a4
	move	#CLTextLength-1,d2
	bsr	processTextInput
	
	tst	d0			;not zero is enter
	beq	.finishGNIState
	
	;goto clear state
	
	move	#NISUB_STATE_CLR,nameInputSubState
	clr	nameInputSubCount
	bra	.finishGNIState
	
.notInput

	cmp	#NISUB_STATE_CLR,d0
	bne	.notClr
	
	;** CLR STATE
	
	lea	nameInputSubCount,a0
	moveq	#0,d0
	move	(a0),d0
	move.l	#9*8,d1
	add	#1,(a0)
	
	move	#11,d3
.textClrLoop
	bsr	clrFGText8x8
	add	#8,d1
	dbf	d3,.textClrLoop
	
	cmp	#39,(a0)
	ble	.finishGNIState
	move	#NISUB_STATE_UPDATE_HISCORE,nameInputSubState
	bra	.finishGNIState
.notClr

	cmp	#NISUB_STATE_UPDATE_HISCORE,d0
	bne	.notUpdateHiscore
	
	;** UPDATE HISCORE STATE
	
	;copy to last (non visible) entry in hiscore list
	
	move.l	hiscoreLast,a1
	move	gameTime+2,d0		; game time
	move	d0,hiScore_min_sec(a1)
	
	lea	clText+1,a0
	addq.l	#hiScore_name,a1
	
	moveq	#HISCORE_NAME_LENGTH-1,d0	;name
.copyName
	move.b	(a0)+,(a1)+
	dbf	d0,.copyName
	
	bsr	sortHiscore	;sort hiscore and end
	
	
	move	#NISUB_STATE_END,nameInputSubState
	bra	.finishGNIState
	
.notUpdateHiscore
	
	nop
.finishGNIState

	movem.l	(sp)+,d0-d2/a0-a4
	rts
	
NISUB_STATE_START		equ	0	
NISUB_STATE_INPUT		equ 	1
NISUB_STATE_CLR			equ 	2
NISUB_STATE_UPDATE_HISCORE	equ	3
NISUB_STATE_END			equ 	4

nameInputSubState	dc.w	NISUB_STATE_START
nameInputSubCount	dc.w	0	
	
	cnop	0,4
	
	
;************************************************************************************************
;*
;* initTextInput
;*
;* d0.w = max text (buffer) length -1
;*
;* a1   = text adr
;* a2   = text pos adr (word)
;* a3   = curser text buffer adr
;* a4   = curser text buffer state adr (word)
;*	
;************************************************************************************************
	
initTextInput

	move.l	d1,-(sp)
	
	moveq	#' ',d1
.clrLoop
	move.b	d1,(a1)+
	move.b	d1,(a3)+
	dbf	d0,.clrLoop
	
	clr.w	(a2)
	clr.w	(a4)

	move.l	(sp)+,d1
	rts	
	
;************************************************
;*
;* gameProcessHiscoreState
;*
;************************************************	
	
gameProcessHiscoreState	

	move	hiscoreSubState,d4
	
	;check STATE_START
	
	cmp	#HSSUB_STATE_START,d4
	bne	.noStateStart
	move	#HSSUB_STATE_DRAW_SCORE,hiscoreSubState
	clr	hiscoreSubCount
	
	;**** STATE_START
	
	;draw hiscore text
	
	moveq	#17,d0
	move.l	#8*8,d1	
	lea	gameTextHiscore,a0
	bsr	drawFGText8x8
	
	bra	.processHSEnd
.noStateStart	

	;check DRAW_SCORE

	cmp	#HSSUB_STATE_DRAW_SCORE,d4
	bne	.noStateDraw
	
	;**** STATE_DRAW_SCORE
	
	lea	gameStateCounter,a0
	move	(a0),d0
	add	#1,d0
	and	#$f,d0
	move	d0,(a0)
	tst	d0
	bne	.processHSEnd
	
	lea	hiscoreSubCount,a0
	moveq	#0,d0
	move	(a0),d0
	add	#1,(a0)
	cmp	#HISCORE_LENGTH,d0
	bne	.continueDraw
	
	move	#HSSUB_STATE_WAIT_AD,hiscoreSubState
	clr	hiscoreSubCount
	bra	.processHSEnd
	
.continueDraw	
	
	;draw hiscore (d0.w is pos)
	
	
	moveq	#14,d2		;text x offset (x8)
	moveq	#10*8,d3	;text y offset
	bsr	drawHiscoreLine
	
.noStateDraw
.processHSEnd

	;hiscore finish
	
	cmp	#HSSUB_STATE_WAIT_AD,d4
	bne	.noStateWaitAd
	
	;**** HSSUB_STATE_WAIT_AD
	
	lea	gameStateCounter,a0
	move	(a0),d0
	add	#1,d0
	move	d0,(a0)
	cmp	#300,d0
	ble	.noStateWaitAd
	
	move	#HSSUB_STATE_FINISH,hiscoreSubState
	clr	hiscoreSubCount	

.noStateWaitAd



	rts
	
HSSUB_STATE_START	equ 	0
HSSUB_STATE_DRAW_SCORE	equ 	1
HSSUB_STATE_WAIT_AD	equ	2
HSSUB_STATE_FINISH	equ	3
	
hiscoreSubState		dc.w	HSSUB_STATE_START	
hiscoreSubCount		dc.w	0


;************************************************
;*
;* drawHiscoreLine 
;*
;* note: text y position is +=line pos * 8pixel
;*
;* d0.w	= line pos 0..HISCORE_LENGTH-1 (higher values will ignored)
;* d2.w = text x offset (in pixel * 8)
;* d3.w = text y offset (in pixel)
;*
;************************************************

drawHiscoreLine

	movem.l	d0-d1/a0-a2,-(sp)

	cmp	#HISCORE_LENGTH-1,d0
	bgt	.outOfRange
	
	and.l	#$ffff,d0
	lsl	#2,d0	;=cnt*4
	
	lea	hiscoreList,a1
	add.l	d0,a1
	add	d0,d0	;=cnt*8
	move	d0,d1
	add	d3,d1	;+offset
	move.l	(a1),a2			;hiscore line
	move	hiScore_min_sec(a2),d0	;time in min:sec 8:8 bcd
	
	lea	gameTextHiscoreTimeValue,a0	;00:00
	bsr	timeToString
	
	moveq	#0,d0
	move	d2,d0
	lea	gameTextHiscoreTimeValue,a0	;time
	bsr	drawFGText8x8
	
	moveq	#6,d0
	add	d2,d0
	lea	hiScore_name(a2),a0	;get text
	bsr	drawFGText8x8

.outOfRange
	movem.l	(sp)+,d0-d1/a0-a2
	rts
	
;************************************************
;*
;* gameProcessEpilogState
;*
;************************************************
	
gameProcessEpilogState

	lea	gameShipData,a0
	or	#1<<GAME_SHIP_STATE_EXPLOSION_BIT,sGameShip_state(a0)
	move	sGameShip_xy+2(a0),d0
	cmp	#SCREEN_HEIGHT,d0
	bgt	.noMoveOut
	addq	#2,d0
	move	d0,sGameShip_xy+2(a0)
.noMoveOut

	move 	gameStateCounter,d0
	cmp	#0,d0
	bne	.noExplSnd
	
	lea	sndSfxExplo,a0
	lea	$dff000,a6
	bsr	_mt_playfx
	
.noExplSnd
	rts
	
;************************************************
;*
;* gameProcessPrologState
;*
;************************************************
	
gameProcessPrologState

	move	gameStateCounter,d4
	
	cmp	#200,d4
	bge	.noStarBreak
	lea	prologStarSpeed,a0
	movem	(a0),d0-d3
	subq	#1,d0
	subq	#1,d1
	subq	#1,d2
	subq	#1,d3
	movem	d0-d3,(a0)
	bsr	setStarsSpeed
.noStarBreak

	cmp	#50,d4
	bne	.noText1
	moveq	#17,d0
	move.l	#9*8,d1
	lea	gameTextProlog1,a0
	bsr	drawFGText8x8
	bsr	playSndInfo
.noText1
	cmp	#70,d4
	bne	.noText2
	moveq	#7,d0
	move.l	#11*8,d1
	lea	gameTextProlog2,a0
	bsr	drawFGText8x8
	bsr	playSndInfo
.noText2
	cmp	#90,d4
	bne	.noText3
	moveq	#7,d0
	move.l	#13*8,d1
	lea	gameTextProlog3,a0
	bsr	drawFGText8x8
	bsr	playSndInfo
.noText3
	cmp	#110,d4
	bne	.noText4
	moveq	#7,d0
	move.l	#14*8,d1
	lea	gameTextProlog4,a0
	bsr	drawFGText8x8
	bsr	playSndInfo
.noText4
	cmp	#130,d4
	bne	.noText5
	moveq	#7,d0
	move.l	#15*8,d1
	lea	gameTextProlog5,a0
	bsr	drawFGText8x8
	bsr	playSndInfo
.noText5
	cmp	#150,d4
	bne	.noText6
	moveq	#7,d0
	move.l	#16*8,d1
	lea	gameTextProlog6,a0
	bsr	drawFGText8x8
	bsr	playSndInfo
.noText6
	cmp	#170,d4
	bne	.noText7
	moveq	#7,d0
	move.l	#18*8,d1
	lea	gameTextProlog7,a0
	bsr	drawFGText8x8
	bsr	playSndInfo
.noText7
	cmp	#190,d4
	bne	.noText8
	moveq	#15,d0
	move.l	#20*8,d1
	lea	gameTextProlog8,a0
	bsr	drawFGText8x8
	bsr	playSndInfo
.noText8

	cmp	#0,d4
	bne	.noTextClearRst
	clr	prologClearPos
.noTextClearRst

	cmp	#350,d4
	ble	.noTextClear
	cmp	#350+40,d4
	bgt	.noTextClear
	
	lea	prologClearPos,a0
	moveq	#0,d0
	move	(a0),d0
	move.l	#9*8,d1
	add	#1,(a0)
	
	move	#11,d3
.textClrLoop
	bsr	clrFGText8x8
	add	#8,d1
	dbf	d3,.textClrLoop
	
.noTextClear
	
	rts

playSndInfo
	lea	sndSfxInfo,a0
	lea	$dff000,a6
	bsr	_mt_playfx
	rts

GAME_STAR_START_INC	equ	200

		
prologClearPos	dc.w	0
prologStarSpeed	dc.w	1+GAME_STAR_START_INC,2+GAME_STAR_START_INC,5+GAME_STAR_START_INC,8+GAME_STAR_START_INC
		
;************************************************
;*
;* gameProcessColorState
;*
;************************************************
	
gameProcessColorState	
	
	movem.l	d0/d2/a0,-(sp)
	move	gameState,d0
	cmp	#GAME_STATE_COLORS_UP,d0
	bne	.noUpColorProcess
	move	#1,d2		;up
	bsr	.gameLogoColorFade
.noUpColorProcess	
	cmp	#GAME_STATE_COLORS_DOWN,d0
	bne	.noDownColorProcess
	move	#-1,d2		;down
	bsr	.gameLogoColorFade
.noDownColorProcess
	movem.l	(sp)+,d0/d2/a0
	rts
	
.gameLogoColorFade	
	lea	gameLogoLut,a0
	moveq	#15,d0		;count of processed colors
.fadeCLoop	
	bsr	fadeColors
	dbf	d0,.fadeCLoop	
	rts


;************************************************
;*
;* initGameShip
;*
;************************************************	
	
initGameShip	

	lea	gameShipData,a0
	move	#(1<<GAME_SHIP_STATE_MOVE_BIT),sGameShip_state(a0)	;moveable
	move	#SCREEN_WIDTH/2-16-8,d0
	move	#SCREEN_HEIGHT-45,d1
	movem	d0-d1,sGameShip_xy(a0)
	movem	d0-d1,sGameShip_xyLast(a0)
	
	move.l	#shipSprites+(544*1),sGameShip_gfxAdr(a0)
	clr	sGameShip_animCount(a0)
		
	rts

;************************************************
;*
;* initGameShip
;*
;************************************************

checkShipCollision

	move	$dff00e,d0		;CLXDAT
	lea	gameShipData+sGameShip_state,a0
	and	#%110,d0		;Playfiel 1 to Spr 0..3
	move	(a0),d1
	and	#~(1<<GAME_SHIP_STATE_COLLISION_BIT),d1
	tst	d0
	beq	.noCol
	or	#1<<GAME_SHIP_STATE_COLLISION_BIT,d1
.noCol	
	move	d1,(a0)
	rts
	
;************************************************
;*
;* checkShipMove
;*
;************************************************	
	
checkShipMove

	movem.l	d0-d3/a0-a1,-(sp)

	lea	gameShipData,a0

	;move 	xy to last xy

	
	movem	sGameShip_xy(a0),d0-d1
	movem	d0-d1,sGameShip_xyLast(a0)
	
	;check and update movement (d0,d1 xy)
	
	move	sGameShip_state(a0),d2
	btst	#GAME_SHIP_STATE_MOVE_BIT,d2	;moveable
	beq	.noMoveable
		
	lea	rawKeyMap,a1	
	move.b	joy1Dat,d3	;joy is ref key or'ed over
	move.b	9(a1),d2
	
	btst	#4,d2		;4c	-> 0100 1100 -> 94
	beq	.noKeyUp
	bset	#1,d3	
.noKeyUp	
	btst	#5,d2		;4d	-> 0100 1101 -> 95
	beq	.noKeyDwn
	bset	#0,d3	
.noKeyDwn
	btst	#6,d2		;4e	-> 0100 1110 -> 96
	beq	.noKeyRight
	bset	#3,d3	
.noKeyRight
	btst	#7,d2		;47	-> 0100 1111 -> 97
	beq	.noKeyLeft
	bset	#2,d3	
.noKeyLeft
	btst	#0,8(a1)	;40	-> 0100 0000 -> 80
	beq	.noSpace
	bset	#4,d3	
.noSpace	
		
	moveq	#2,d2		;speed update	
	btst	#0,d3
	beq	.noDwn
	add	d2,d1
.noDwn	btst	#1,d3
	beq	.noUp
	sub	d2,d1
.noUp	btst	#2,d3
	beq	.noLeft
	sub	d2,d0
.noLeft	btst	#3,d3
	beq	.noRight
	add	d2,d0
.noRight	
	
.noMoveable

	;clamp xy (d0,d1 xy)
	
	cmp	#0,d0
	bge	.xPosGe0
	moveq	#0,d0
	move	#1,sGameShip_xyLast(a0)	;let left view
.xPosGe0
	cmp	#SCREEN_WIDTH-32,d0
	ble	.xPosLtMax
	move	#SCREEN_WIDTH-32,d0
	move	#SCREEN_WIDTH-33,sGameShip_xyLast(a0)	;let right view
.xPosLtMax
	cmp	#-1,d1
	bge	.yPosGe0
	move	#-1,d1
.yPosGe0
	cmp	#SCREEN_HEIGHT-27,d1
	blt	.yPosLtMax
	move	#SCREEN_HEIGHT-27,d1
.yPosLtMax

	movem	d0-d1,sGameShip_xy(a0)
	movem.l	(sp)+,d0-d3/a0-a1
	rts
	

;************************************************
;*
;* checkShipAnim
;*
;************************************************

checkShipAnim

	movem.l	d0-d3/a0-a1,-(sp)

	lea	gameShipData,a0
	movem	sGameShip_xy(a0),d0-d1

	;calc sprite gfx selection  (d0,d1 xy)
	
	move	sGameShip_xyLast(a0),d2
	move	sGameShip_state(a0),d3
	
	;add offset at collision
	
	btst	#GAME_SHIP_STATE_EXPLOSION_BIT,d3
	beq	.noExplUpdate
	
	move	sGameShip_animCount(a0),d3
	addq	#1,d3
	move	d3,sGameShip_animCount(a0)
	lsr	#2,d3
	and	#$3,d3
	add	d3,d3
	move	explAnimMul(pc,d3.w),d0
	lea	shipSprites+(GAME_SHIP_SPRITE_GFX_SIZE*9),a1
	lea	(a1,d0.w),a1
	
	bra	.noColUpdate
	
.noExplUpdate	

	;left/right check
	
	lea	shipSprites+(GAME_SHIP_SPRITE_GFX_SIZE),a1	; 1 2(x) 3
	cmp	d0,d2
	beq	.noXChange
	bgt	.xLower
	lea	GAME_SHIP_SPRITE_GFX_SIZE(a1),a1		; 1 2 3(x)
	bra	.noXChange
.xLower	
	lea	-GAME_SHIP_SPRITE_GFX_SIZE(a1),a1		; 1(x) 2 3
.noXChange	

	
	;collision check
	
	btst	#GAME_SHIP_STATE_COLLISION_BIT,d3
	beq	.noColUpdate
	bchg	#GAME_SHIP_STATE_COLLANIM,d3
	move	d3,sGameShip_state(a0)
	btst	#GAME_SHIP_STATE_COLLANIM,d3
	bne	.noAnimOffset
	lea	3*GAME_SHIP_SPRITE_GFX_SIZE(a1),a1
.noAnimOffset	
	lea	3*GAME_SHIP_SPRITE_GFX_SIZE(a1),a1
.noColUpdate

	move.l	a1,sGameShip_gfxAdr(a0)

	movem.l	(sp)+,d0-d3/a0-a1

	rts
	
explAnimMul	dc.w	0,GAME_SHIP_SPRITE_GFX_SIZE,GAME_SHIP_SPRITE_GFX_SIZE*2,GAME_SHIP_SPRITE_GFX_SIZE	
	
;************************************************
;*
;* incrementGameTimer
;*
;************************************************

incrementGameTimer

	;check ticks and inc sec/min

	lea	gameTime,a0
	movem	(a0),d0-d1
	addq	#1,d0			;x not set because no c out
	cmp	#50,d0			;TODO NTSC (HEIGHT)
	ble	.noTimeUpdate
	moveq	#0,d0
	move	#1,d3
	abcd	d3,d1			;bcd arithmetic used \o/
	cmp.b	#$60,d1
	bne	.noTimeUpdate
	lsr	#8,d1			;x not set because max is $59
	abcd	d3,d1			;at 99+1 overflow -> 0
	lsl	#8,d1
.noTimeUpdate	

	movem	d0-d1,(a0)	
	rts
	
;************************************************
;*
;* drawGameTimer
;*
;************************************************	
	
drawGameTimer

	;generate string

	move	gameTime+2,d0		;time
	lea	gameTextTimeValue,a0	;00:00
	bsr	timeToString
	
	;
	
	moveq	#6,d0
	moveq	#8*1,d1
	lea	gameTextTimeValue,a0
	bsr	drawFGText8x8
	
	rts
	
	cnop	0,4
	
gameTime	dc.w		0,0	;gameTimeTick 0..49
					;gameTime     min:sec (8:8)
	cnop	0,4
	
;************************************************
;*
;* timeToString
;*
;* d0 = value in min:sec (8:8)
;* a0 = dest string (min 5 chars) format MM:SS
;*
;************************************************	
	
timeToString

	movem.l	d0-d2/a0,-(sp)
	
	moveq	#3,d1
.decSet	rol	#4,d0
	move	d0,d2
	and	#$f,d2
	add	#'0',d2
	move.b	d2,(a0)+
	cmp	#2,d1
	bne	.skipDp
	addq.l	#1,a0
.skipDp	dbf	d1,.decSet
	
	movem.l	(sp)+,d0-d2/a0
	rts
	
;************************************************
;*
;* clearGameTimer
;*
;************************************************

clearGameTimer	

	clr.l	gameTime
	rts
	

;************************************************
;*
;* drawPowerBar
;*
;************************************************

drawPowerBar

	;width 272 (17*16)

	lea	fgPlane+6,a2	;note: allignment
	
	move	shipPower,d0
	cmp	#272,d0
	ble	.maxOk
	move	#272,d0
.maxOk	
	move	d0,d1
	lsr	#4,d0		;/16 -> fill
	move	#17,d2
	sub	d0,d2		;clear
	and	#$f,d1		;rest 16
	
	tst	d1
	beq	.noSub16	
	sub	#1,d2
.noSub16

	move	#$ffff,d3
	tst	d0
	ble	.noFill
	sub	#1,d0
	bsr	.pBdraw16x7Loop
.noFill	

	tst	d1
	beq	.noDrSub16
	subq	#1,d1
	add	d1,d1	
	move	pMask(pc,d1.w),d3
	moveq	#0,d0
	bsr	.pBdraw16x7Loop
.noDrSub16	
	
	move	#$0,d3
	tst	d2
	ble	.noClr
	subq	#1,d2
	move	d2,d0
	bsr	.pBdraw16x7Loop
.noClr	
	rts
		
.pBdraw16x7Loop
	move	d3,FG_TEXT_VSCREEN_WIDTH/8*0(a2)
	move	d3,FG_TEXT_VSCREEN_WIDTH/8*1(a2)
	move	d3,FG_TEXT_VSCREEN_WIDTH/8*2(a2)
	move	d3,FG_TEXT_VSCREEN_WIDTH/8*3(a2)
	move	d3,FG_TEXT_VSCREEN_WIDTH/8*4(a2)
	move	d3,FG_TEXT_VSCREEN_WIDTH/8*5(a2)
	move	d3,FG_TEXT_VSCREEN_WIDTH/8*6(a2)
	addq.l	#2,a2
	dbf	d0,.pBdraw16x7Loop

	rts
		      
pMask	dc.w	$8000,$c000,$e000,$f000,$f800,$fc00,$fe00,$ff00,$ff80,$ffc0,$ffe0,$fff0,$fff8,$fffc,$fffe
shipPower	dc.w	272

	cnop	0,4
	
;************************************************
;*
;* logoLoop
;*
;*
;* use *
;*
;************************************************

logoLoop

	;set and clear fg text bpl
	
	moveq	#FG_TEXT_BITPLANES-1,d1
	move.l	#fgPlane,d0
	lea	logoFgTextCopPl,a0
.setTxtFgPbl	
	move	d0,6(a0)
	swap	d0
	move	d0,2(a0)
	addq.l	#8,a0
	add.l	#(FG_TEXT_VSCREEN_WIDTH)/8,d0
	dbf	d1,.setTxtFgPbl
	
	lea	fgPlane,a0
	move.l	#((FG_TEXT_VSCREEN_WIDTH*FG_TEXT_VSCREEN_HEIGHT)/32*FG_TEXT_BITPLANES)-1,d0
	moveq	#0,d1	;value
.clrFgTxtLoop
	move.l	d1,(a0)+
	dbf	d0,.clrFgTxtLoop
		
	;init stones (all active)
	
	move	#sStone_state_ACTIVE,d0
	bsr 	initStones	
		
	;reset logo text states
	
	bsr	resetLogoTextStates
	
	;set fg logo bpl
	
	moveq	#FG_LOGO_BITPLANES-1,d1
	move.l	#logo,d0
	lea	logoFgCopPl,a0
.setFgLogoPbl	
	move	d0,6(a0)
	swap	d0
	move	d0,2(a0)
	swap	d0
	addq.l	#8,a0
	add.l	#(FG_LOGO_VSCREEN_WIDTH)/8,d0
	dbf	d1,.setFgLogoPbl
	
	;clear bg buffers
	
	move.l	bgPlaneBackground,a0
	bsr	clearBGHard
	move.l	bgPlaneFront,a0
	bsr	clearBGHard	
	
	;set bpl for background (prevent 1 frame glitch)
	
	move.l	bgPlaneFront,d0
	add.l	#BG_VSCREEN_X_OFFSET/8,d0
	lea	gameBgCopPl+2,a0
	bsr	setBGBpls

	;reset colors
	
	move	#$0,d0
	bsr	resetFadeColors
	
	lea	colorLogoLut,a0
	move	#(colorLogoLutEnd-colorLogoLut),d0
	lsr	#3,d0
	subq	#1,d0
	
	;move	d0,testVal1
	
.setCLoop	
	move	#0,d2		;no change
	bsr	fadeColors
	dbf	d0,.setCLoop
	
	;set star speed
		
	moveq	#1,d0
	moveq	#2,d1
	moveq	#5,d2
	moveq	#8,d3
	bsr	setStarsSpeed
		
	;set copperlist  
	
	move.l 	#copperListLogo,$84(a6) 	
	
	;reset states 
	
	move	#LOGO_STATE_COLORS_UP,logoState
	clr	logoStateCounter
	clr	logoReturn

	;*logo loop
	
.loopVBLogo

	WAITVMIN	#IVSTOP
	
	;move bg stars
	
	DEBC 	#$f00
	
	lea	logoSpr4,a0
	bsr	moveStars
	
	;move ship
	
	DEBC 	#$ff0
	
	bsr	moveLogoShip
	
	;check keyboard and joy1
	
	DEBC 	#$0000
	bsr	checkKeyboard
	bsr	checkJoy1
	
	;swap screen buffers
	
	DEBC 	#$0ff
	
	lea	bgPlaneFront,a0
	lea	bgPlaneBackground,a1
	move.l	(a0),d0		;front
	move.l	(a1),d1		;bg
	move.l	d1,(a0)		;front
	move.l	d0,(a1)		;bg
	
	;set bpl for background
	
	move.l	bgPlaneFront,d0
	add.l	#BG_VSCREEN_X_OFFSET/8,d0
	lea	logoBgCopPl+2,a0
	bsr	setBGBpls
	
	;
	
	DEBC 	#$0f0
	
	;clear background
	
	move.l	bgPlaneBackground,a0
	bsr	clearBGHard
		
	;move stones
	
	moveq	#0,d0
	bsr	moveStones
		
	;check stones
	
	bsr	checkStones
		
	DEBC  	#$fff
			
	;draw stones

	bsr	drawStones

	;check and draw start/exit, set and check states
	
	DEBC 	#$0f0f
	
	cmp	#LOGO_STATE_SHOW,logoState
	bne	.noSelect
	bsr	checkAndDrawLogoText
	move	d0,logoReturn
.noSelect
	
	;process color states
	
	bsr	logoProcessColorState

	DEBC 	#$00ff
	
	bsr	logoStateProcess
	
	;	
	GETVd0		
	lea	scanLinesUsed,a0
	move	(a0),d1
	cmp	d1,d0
	blt	.noScanLineUsedUpdate
	move	d0,(a0)
.noScanLineUsedUpdate	
	
	;frame finish
		
	DEBC  	#$0000

	IFD	LMQUIT
	btst	#6,$bfe001
        beq	.logoEnd	
	ENDIF
	
	cmp	#LOGO_STATE_END,logoState
	beq	.logoEnd

	bra	.loopVBLogo
	
.logoEnd
	rts

;************************************************
;*
;* logoStateProcess
;*
;************************************************

logoStateProcess
	
	lea	logoState,a0
	lea	logoStateCounter,a1
	move	(a0),d0	;state
	move	(a1),d1 ;sub counter
	
	move	d0,d2
	and	#$3,d2
	add	d2,d2
	add	d2,d2
	move.l	logoStateFctLut(pc,d2.w),a2	;jump
	jsr	(a2)

	move	d0,(a0)
	move	d1,(a1)

	rts

	cnop	0,4

logoStateFctLut		dc.l	fctLOGO_STATE_SHOW			
			dc.l	fctLOGO_STATE_COLORS_DOWN		
			dc.l	fctLOGO_STATE_END	
			dc.l	fctLOGO_STATE_COLORS_UP		

	cnop	0,4
	
LOGO_FADE_UP_VBS	equ	100	
	
fctLOGO_STATE_SHOW
	tst	logoReturn
	beq	.noExit
	move	#LOGO_STATE_COLORS_DOWN,d0
.noExit	
	rts
	
fctLOGO_STATE_COLORS_DOWN
	addq	#1,d1
	cmp	#LOGO_FADE_UP_VBS,d1
	ble	.cdownHoldState
	moveq	#0,d1
	move	#LOGO_STATE_END,d0
.cdownHoldState		
	rts
	
fctLOGO_STATE_END	
	rts
	
fctLOGO_STATE_COLORS_UP
	addq	#1,d1
	cmp	#LOGO_FADE_UP_VBS,d1
	ble	.cupHoldState
	moveq	#0,d1
	move	#LOGO_STATE_SHOW,d0
.cupHoldState	
	rts
	
;************************************************
;*
;* logoProcessColorState
;*
;************************************************
	
logoProcessColorState	
	
	movem.l	d0/d2/a0/a6,-(sp)
	
	lea	$dff000,a6
	move	logoState,d0
	cmp	#LOGO_STATE_COLORS_UP,d0
	bne	.noUpColorProcess
	move	#1,d2		;up
	bsr	.logoColorFade
	bsr	.setLogoFadeMasterVolume
.noUpColorProcess	
	cmp	#LOGO_STATE_COLORS_DOWN,d0
	bne	.noDownColorProcess
	move	#-1,d2		;down
	bsr	.logoColorFade
	bsr	.setLogoFadeMasterVolume
.noDownColorProcess
	movem.l	(sp)+,d0/d2/a0/a6
	rts
	
.logoColorFade	
	lea	colorLogoLut,a0
	moveq	#15,d0
.fadeCLoop	
	bsr	fadeColors
	dbf	d0,.fadeCLoop	
	rts
	
.setLogoFadeMasterVolume
	move	logoStateCounter,d0
	tst	d2
	bpl	.fUp
	moveq	#LOGO_FADE_UP_VBS,d2
	sub	d0,d2
	move	d2,d0
.fUp	
	cmp	#64,d0
	ble	.volInRange
	moveq	#64,d0
.volInRange
	bsr	_mt_mastervol
	rts
	
;************************************************
;*
;* setBGBpls
;*
;* d0 = bpl adr
;* a0 = copper bpl adr
;*
;************************************************
	
setBGBpls	
	move.l	d2,-(sp)
	
	moveq	#BG_BITPLANES-1,d2
.setBgPbl	
	move	d0,4(a0)
	swap	d0
	move	d0,(a0)
	swap	d0
	addq.l	#8,a0
	add.l	#(BG_VSCREEN_WIDTH)/8,d0
	dbf	d2,.setBgPbl
	
	move.l	(sp)+,d2	
	rts

;************************************************
;*
;* resetFadeColors
;*
;* d0 = fade mul init
;*
;************************************************

resetFadeColors
	
	clr	fadeColorPos
	and	#$f,d0
	move	d0,fadeColorMul
	rts


;************************************************
;*
;* fadeColors
;*
;* a0 = color lut
;* d2 = direction	(x,-x)
;*
;************************************************

fadeColors

	movem.l	d0-d2/a0-a1,-(sp)
	move	fadeColorPos,d0
	lsl	#3,d0		;*8
	lea	(a0,d0.w),a0	;p*12
	
	movem.l	(a0),d0/a1	;color, dest adr
	cmp.l	#0,a1
	beq	.resetColorPos
	move	fadeColorMul,d1
	and	#$f,d1
	bsr	colorDiv
	move.w	d0,(a1)		;to dest
	
	addq	#1,fadeColorPos
	
.fadeColosEnd
	movem.l	(sp)+,d0-d2/a0-a1
	rts

.resetColorPos
	clr	fadeColorPos
	
	lea	fadeColorMul,a0
	move	(a0),d0
	add	d2,d0		
	
	tst	d0
	blt	.fadeColosEnd	;<0
	cmp	#$f,d0
	bgt	.fadeColosEnd	;>15

	move	d0,(a0)	
	bra	.fadeColosEnd
	
fadeColorPos	dc.w	0
fadeColorMul	dc.w	$f

;************************************************
;*
;* initStones
;*
;* d0 = state
;*
;* a0
;*
;************************************************

initStones

	move.l	d1,-(sp)
	
	moveq	#MAX_STONES-1,d1
	lea	StoneObjects,a0
.iStoneLoop

	bsr	randStone
			
	move	d0,sStone_state(a0)	;set state
	
	lea	sStone_sizeOf(a0),a0
	dbf	d1,.iStoneLoop
	
	move.l	(sp)+,d1
	rts
	
;************************************************
;*
;* drawStones
;*
;*
;* use d0-d2,a0-a1
;*	
;************************************************
	
drawStones

	moveq	#MAX_STONES-1,d2
	lea	StoneObjects,a1
.stoneDrawLoop

	
	cmp	#sStone_state_RESET,sStone_state(a1)
	beq	.noStoneDraw
	
	move.l	sStone_gfxObjectAdr(a1),a0	;gfx object
	move	sStone_x(a1),d0	;x:0
	move	sStone_y(a1),d1	;y:0
	asr	#STONE_XY_FRACTBITS,d0
	asr	#STONE_XY_FRACTBITS,d1
	add	#BG_VSCREEN_X_OFFSET,d0	;x offset
	bsr	drawStone
	
.noStoneDraw	
	
	lea	sStone_sizeOf(a1),a1	;next
	
	btst	#0,d2
	seq	d0
	and	#7,d0
	or	#8,d0
	DEBC	d0
	
	dbf	d2,.stoneDrawLoop

	rts
	
;************************************************
;*
;* randStone
;*
;* a0 = stone object
;*
;************************************************	
	
randStone	
	movem.l	d0-d1,-(sp)

	bsr	fastRand
	and	#%11100,d0
	move.l	.randGfxTable(pc,d0.w),d0
	move.l	d0,sStone_gfxObjectAdr(a0)

	;x

	bsr	fastRand
	move	d0,d1
	and	#$ff,d1
	bsr	fastRand
	and	#$7f,d0
	add	d1,d0
	sub	#32,d0
	lsl	#STONE_XY_FRACTBITS,d0
	move	d0,sStone_x(a0)
	
	;y
	
	bsr	fastRand
	and	#$7ff,d0
	neg	d0
	sub	#64<<STONE_XY_FRACTBITS,d0
	move	d0,sStone_y(a0)
	
	;sx
	
	bsr	fastRand
	and	#$7,d0
	subq	#4,d0
	move	d0,sStone_xSpeed(a0)
	
	;sy
	
	bsr	fastRand
	and	#$1f,d0
	addq	#8,d0
	move	d0,sStone_ySpeed(a0)
	
	movem.l	(sp)+,d0-d1

	rts

.randGfxTable	dc.l	stone1Gfx,stone2Gfx,stone3Gfx,stone4Gfx,stone5Gfx,stone6Gfx,stone1Gfx,stone6Gfx
	
;************************************************
;*
;* moveStones
;*
;* d0 = 0 rerand after out off screen
;*
;************************************************

moveStones
	movem.l	d0-d4/a0,-(sp)
	
	move	d0,d4
	moveq	#MAX_STONES-1,d3
	lea	StoneObjects,a0
.iStoneLoop

	cmp	#sStone_state_RESET,sStone_state(a0)
	beq	.moveStonesContinue
	
	;move

	move	sStone_x(a0),d0
	add	sStone_xSpeed(a0),d0
	move	d0,sStone_x(a0)

	move	sStone_y(a0),d1
	add	sStone_ySpeed(a0),d1
	move	d1,sStone_y(a0)

	;check xy
	
	cmp	#(SCREEN_HEIGHT+16)<<STONE_XY_FRACTBITS,d1
	bgt	.StoneReRand
	
	cmp	#(-64)<<STONE_XY_FRACTBITS,d0
	blt	.StoneReRand
	
	cmp	#(SCREEN_WIDTH+64)<<STONE_XY_FRACTBITS,d0
	bgt	.StoneReRand	
	
.moveStonesContinue	
	
	lea	sStone_sizeOf(a0),a0
	dbf	d3,.iStoneLoop

	movem.l	(sp)+,d0-d4/a0
	rts	
	
.StoneReRand
	tst	d4
	bne	.noRerand
	bsr	randStone
	bra.s	.moveStonesContinue

.noRerand
	move	#(-64)<<STONE_XY_FRACTBITS,sStone_x(a0)
	move	#(SCREEN_HEIGHT+16)<<STONE_XY_FRACTBITS,sStone_y(a0)
	bra.s	.moveStonesContinue

;************************************************
;*
;* checkStones
;*
;************************************************
	
checkStoneUpdateTable	;balanced time usage

	dc.w	0,1
	dc.w	2,3
	dc.w	4,5
	dc.w	6,8
	dc.w	9,11
	dc.w	12,15
	dc.w	16,20
	dc.w	21,31	

checkStoneUpdateState

	dc.w	0	
	
checkStones	

	movem.l	d0-d7/a0-a3,-(sp)
	
	lea	StoneObjects,a2

	lea	checkStoneUpdateState,a0
	move	(a0),d0
	addq	#1,d0
	and	#7,d0
	move	d0,(a0)
	
	lsl	#2,d0				;*4
	lea	checkStoneUpdateTable(pc,d0.w),a0
	movem	(a0),d6/a3	;start .. stop
	addq	#1,a3
	
.chSL1	cmp	a3,d6			;from start .. stop
	beq	.chSL1End
	
	;
	
	move	d6,d0
	addq	#1,d6			;start + 1	
	;mulu	#sStone_sizeOf,d0
	MULUC	sStone_sizeOf,d0,d7
	lea	(a2,d0.w),a0		;stone object 1
	
	;get data one time
	
	cmp	#sStone_state_RESET,sStone_state(a0)
	beq	.chSL1				;not active stone ignore all checks
	movem	sStone_x(a0),d0-d1			;x1 y1
	lsr	#STONE_XY_FRACTBITS,d0
	lsr	#STONE_XY_FRACTBITS,d1
	move.l	sStone_gfxObjectAdr(a0),a1
	add	sGfxObject_focusX(a1),d0		;mx1 = x1 + focusx1
	add	sGfxObject_focusY(a1),d1		;my1 = y1 + focusy1
	move	sGfxObject_radius(a1),d4		;ra1
	
	;
	
	
	move	d6,d7
.chSL2	cmp	#MAX_STONES,d7		;from start+1 .. max-1
	bge	.chSL2End
	
	;
	
	move	d7,d5
	;mulu	#sStone_sizeOf,d5
	MULUC	sStone_sizeOf,d5,d2
	lea	(a2,d5.w),a1		;stone object 2
	cmp	#sStone_state_RESET,sStone_state(a1)	;not active stone ignore all checks
	beq	.chNoCollision	
	
	bsr	checkColisionStones
	tst.b	d5
	beq	.chNoCollision
	
	bsr	updateAfterColisionStones
	
.chNoCollision	
	;
	
	addq	#1,d7
	bra	.chSL2
.chSL2End	
	bra	.chSL1
.chSL1End
	
	movem.l	(sp)+,d0-d7/a0-a3
	rts
	
;************************************************
;*
;* checkColisionStones
;*
;*
;* d0 = stone 1    x + focusx
;* d1 = stone 1    y + focusy
;* d4 = stone 1    radius
;* a1 = stone 2
;*
;* return d5.b == 0 no collision
;*
;* use d2,d3
;*
;************************************************

checkColisionStones


	move.l	a1,-(sp)
	
	movem	sStone_x(a1),d2-d3		;x2 y2
	lsr	#STONE_XY_FRACTBITS,d2
	lsr	#STONE_XY_FRACTBITS,d3
	move.l	sStone_gfxObjectAdr(a1),a1
	add	sGfxObject_focusX(a1),d2		;mx2 = x2 + focusx2
	add	sGfxObject_focusY(a1),d3		;my2 = y2 + focusy2
	
	sub	d0,d2					;mx2 - mx1
	sub	d1,d3					;my2 - my1
	
	muls	d2,d2					;^2
	muls	d3,d3					;^2
	add.l	d2,d3					;distance^2
	
	move	sGfxObject_radius(a1),d2		;ra12 = ra2 + ra1
	add	d4,d2
	muls	d2,d2					;ra12^2
	
	cmp.l	d2,d3					;distance^2 < ra12^2
	sle	d5
	
	move.l	(sp)+,a1
	rts

;************************************************
;*
;* updateAfterColisionStones
;*
;*
;* a0 = stone 1
;* a1 = stone 2
;*
;************************************************

updateAfterColisionStones

	movem.l	d0-d5/a0-a2,-(sp)

	;sx = (m1 * xspeed1 + m2 * xspeed2) / (m1 + m2)
        ;sy = (m1 * yspeed1 + m2 * yspeed2) / (m1 + m2)
	
	movem	sStone_xSpeed(a0),d0-d1			;xspeed1 yspeed1
	move.l	sStone_gfxObjectAdr(a0),a2
	move	sGfxObject_mass(a2),d4			;m1
	
	movem	sStone_xSpeed(a1),d2-d3			;xspeed2 yspeed2
	move.l	sStone_gfxObjectAdr(a1),a2
	move	sGfxObject_mass(a2),d5			;m2
		
	muls	d4,d0						;m1 * xspeed1
	muls	d5,d2						;m2 * xspeed2
	add.l	d0,d2						;+
	
	muls	d4,d1						;m1 * yspeed1
	muls	d5,d3						;m2 * yspeed2
	add.l	d1,d3						;+
	
	add	d4,d5						;m1 + m2
	divs	d5,d2					
	divs	d5,d3
	
	movem	d2-d3,sStone_xSpeed(a0)			;xspeed1 yspeed1			
	movem	d2-d3,sStone_xSpeed(a1)			;xspeed2 yspeed2		
	
	moveq	#(1<<STONE_XY_FRACTBITS)-1,d0			;mask for fract clear
	not	d0
	and	d0,sStone_x(a0)
	and	d0,sStone_y(a0)
	and	d0,sStone_x(a1)
	and	d0,sStone_y(a1)
			
	movem.l	(sp)+,d0-d5/a0-a2
	rts

;************************************************
;*
;* fastRand
;*
;*
;* return: d0.w = rand value
;*
;************************************************
	
fastRand

	move.l	.fastRandSeed,d0
	mulu	#8121,d0
	add.l	#28411,d0	
	move.l	d0,.fastRandSeed
	swap	d0
	rts	

	cnop	0,4
.fastRandSeed	dc.l	$5eed	

;************************************************
;*
;* checkJoy1
;*     	
;* trash: d0, d1
;*
;************************************************

checkJoy1
	bsr	readJoy1Direction
	move.b	$bfe001,d1		;CIAA pra
	and.b	#$80,d1
	eor.b	#$80,d1
	lsr.b	#3,d1
	or.b	d1,d0
	move.b	d0,joy1Dat
	rts
	
joy1Dat	dc.b	0		 ;%---FRLUD	(F = Fire Button 1; R = Right L = Left U = Up/Forward D = Down/Backward - = not defined)
	cnop	0,4
	
;************************************************
;*
;* readJoy1Direction
;*
;* 
;* d0.b = %---RLUD	(R = Right L = Left U = Up/Forward D = Down/Backward - = not defined)
;*     	
;************************************************

readJoy1Direction

	move	$dff00c,d0	;JOYDAT1
				;YYYYYYYYXXXXXXXX
				;7654321076543210	
				
				;U = Y1 xor Y0
				;L = Y1
				;D = X1 xor X0
				;R = X1
				
	ror.b	#2,d0		;YYYYYYYYXXXXXXXX
				;7654321010765432
	lsr	#6,d0		;      YYYYYYYYXX
				;      7654321010
				;            YYXX
	and	#$f,d0		;            1010
	
	move.b	readJoy1Table(pc,d0.w),d0	
	rts	

	
				;YYXX
				;1010    
readJoy1Table	dc.b	%0000	;0000    
		dc.b	%0001	;0001    D
		dc.b	%1001	;0010 R  D
		dc.b	%1000   ;0011 R  
		dc.b	%0010   ;0100   U
		dc.b	%0011   ;0101   UD
		dc.b	%1011   ;0110 R UD
		dc.b	%1010   ;0111 R U
		dc.b	%0110   ;1000  LU
		dc.b	%0111   ;1001  LUD
		dc.b	%1111   ;1010 RLUD
		dc.b	%1110   ;1011 RLU
		dc.b	%0100   ;1100  L 
		dc.b	%0101   ;1101  L D
		dc.b	%1101   ;1110 RL D
		dc.b	%1100   ;1111 RL 
		
	cnop	0,4	
	
;************************************************
;*
;* drawStone
;*
;* d0.w = x 		(signed)
;* d1.w = y 		(signed)
;*
;* a0.l = gfx object
;*
;*
;*
;************************************************

drawStone
	movem.l	d2-d7/a0-a3/a5/a6,-(sp)

	lea	$dff000,a6

	move	sGfxObject_width(a0),d2
	add	#16,d2			;16 pixel for blitter words right
	move	d2,d6
	move	sGfxObject_height(a0),d3

	;************************************
	;check y

	moveq	#0,d5			;y source offset
	cmp	#BG_VSCREEN_HEIGHT,d1
	bge	.drawStoneEnd		;y>=screen height
	
	cmp	#0,d1			;y < 0
	bge	.dsYPositive
	add	d1,d3			;then add to height
	neg	d1			;diff positive
	move	d1,d5			;y source offset
	clr	d1			;y = 0	
.dsYPositive	
	
	;check height
	
	cmp	#0,d3
	ble	.drawStoneEnd		;hight<=0

	move	d1,d7
	add	d3,d7			;height + y
	sub	#BG_VSCREEN_HEIGHT,d7	;height + y - screen height
	cmp	#0,d7
	ble	.dsCutHeight
	sub	d7,d3			;-diff
.dsCutHeight	


	;************************************
	;check x
	
	moveq	#0,d4			;x source offset
	cmp	#BG_VSCREEN_WIDTH,d0
	bge	.drawStoneEnd		;x>=screen width
	
	cmp	#0,d0			
	bge	.dsXPositive		;x>0
	
	move	d2,d4
	add	d0,d2			;new width = (-x + width) 
	and	#$fff0,d2		;                          & 0xfff0
	sub	d2,d4			;offset = width - new width
	
	add	#16,d0			;x new = (x + 16) & 0xf
	and	#$f,d0
	
	cmp	#16,d2			;width <= 16
	blt	.drawStoneEnd		;nothing to draw
	
.dsXPositive

	;check width
	
	move	#0,a5
	move	d2,d7			;width
	add	d0,d7			;      + x
	sub	#BG_VSCREEN_WIDTH+16,d7	;          - screen width = diff
	cmp	#0,d7			;check signed?
	ble	.dsNoWidthCut		;<= 0 nothing todo
	move	d7,a5
	sub	d7,d2			;
	
.dsNoWidthCut
	
	;d0 = x
	;d1 = y
	;d2 = object draw width		
	;d3 = object draw height 	
	;d4 = x offset		(in object)		
	;d5 = y offset          (in object)	
	;d6 = object width gfx		(real width for modulo calculation)
	;d7 
	
	;a0 = object struct
	;a5 = shift over vscreen
	
	move	d0,d7			;d7 = x
	and	#$fff0,d2		;d2 = width & 0xfff0
		
	;calculate source a/b offset
		
	muls	d6,d5			;gfx width * y offset
	lsr	#3,d5			;/8*BITPLANES = /8*2 = /4
	add	d5,d5
	
	lsr	#3,d4			; xoffset / 8 
	add	d4,d5
		
	move.l	sGfxObject_planesAdr(a0),a1		; planes gfx
	move.l	sGfxObject_mskPlanesAdr(a0),a2	; planes gfx mask	
	
	lea	(a1,d5.w),a1
	lea	(a2,d5.w),a2	
	
	;calculate source/destination c/d offset
	
	move.l	bgPlaneBackground,a3
	muls	#BG_VSCREEN_WIDTH/8*BG_BITPLANES,d1	;screen width * y 
	add.l	d1,a3
	lsr	#3,d0				;x / 8	
	lea	(a3,d0.w),a3			;offset
	
	;wait blit

	move	#$8400,$96(a6)		;DMACON blit prio

.waitBlit
	btst	#6,2(a6)		;DMACONR
	bne.s	.waitBlit	
	
	move	#$0400,$96(a6)		;DMACON blit prio
	
	;
		
	move	d6,d0
	sub	d2,d0
	lsr	#3,d0			; / 8
	move	d0,$64(a6)		;BLTAMOD
	move	d0,$62(a6)		;BLTBMOD
	
	move	#BG_VSCREEN_WIDTH,d0
	sub	d2,d0			;screenwidth - draw width (uncut)	
	lsr	#3,d0			;                            / 8
	
	move	d0,$60(a6)		;BLTCMOD
	move	d0,$66(a6)		;BLTDMOD
	
	move	a5,d0			;shift over screen width
	and	#$f,d0
	move	#$ffff,d1
	lsl	d0,d1
	
	move	d1,$46(a6)		;BLTALWM
	move	#$ffff,$44(a6)		;BLTAFWM
		
	
	;minterm calculation
	;
	;(a and b) or (not a and c)
	;ab + ~ac 
	;ab(c*~c) + ~a(b*~b)c
	;abc+ab~c+~abc+~a~bc
	
	;A B C 
	;0 0 0 = 0 ~A~B~C
	;0 0 1 = 1 ~A~BC
	;0 1 0 = 2 ~AB~C
	;0 1 1 = 3 ~ABC
	;1 0 0 = 4 A~B~C
	;1 0 1 = 5 A~BC
	;1 1 0 = 6 AB~C
	;1 1 1 = 7 ABC
	
	;7    6    3     1
	;
	;          7654 3210
	;minterm = 1100 1010 = $ca
		
	and	#$f,d7			;x shift (low nibble of x)
	ror	#4,d7
	move	d7,$42(a6)		;BLTCON1 BSH (15..12)
	or	#$0fca,d7		;	 ASH (15..12) USE ABCD + minterms 
	move	d7,$40(a6)		;BLTCON0 
					;BLTxPTH C B A D
	movem.l	a1-a2,$4c(a6)		;BLTBPTH	gfx
					;BLTAPTH	msk   		
	move.l	a3,$48(a6)   		;BLTCPTH	bg	
	move.l	a3,$54(a6)  		;BLTDPTH	bg
	
	lsl	#7,d3			;(height*bitplanes) << 6 (v pos)
	lsr	#4,d2			;width / 16
	or	d2,d3			;set to width
	
	move	d3,$58(a6)		;BLTSIZE
	

.drawStoneEnd	
	movem.l	(sp)+,d2-d7/a0-a3/a5/a6
	rts

;************************************************
;*
;* clearBGSoft
;*
;* a0 = bg adr
;*
;************************************************

clearBGSoft

	movem.l	d0-d5/a0,-(sp)
	
	move.l	#((BG_VSCREEN_WIDTH*BG_VSCREEN_HEIGHT)/32*BG_BITPLANES/4)-1,d0
	move.l	#$0,d1	;value
	move.l	d1,d2
	move.l	d1,d3
	move.l	d1,d4
	moveq.l	#16,d5
.clrBgLoop
	movem.l	d1-d4,(a0)
	add.l	d5,a0
	dbf	d0,.clrBgLoop
	movem.l (sp)+,d0-d5/a0
	rts

;************************************************
;*
;* clearBGHard
;*
;* a0 = bg adr
;*
;************************************************

clearBGHard

	movem.l	a6,-(sp)
	
	;wait blit

.clearBGHardWaitBlit
	btst	#6,2(a6)		;DMACONR
	bne.s	.clearBGHardWaitBlit
	
	lea	$dff000,a6	
	move	#BG_VSCREEN_X_OFFSET/8,$66(a6)		;BLTDMOD
	move	#$0100,$40(a6)				;USE D (no minterms = 0)
							;BLTCON0
	clr	$42(a6)					;BLTCON1
	add.l	#BG_VSCREEN_X_OFFSET/8,a0	
	move.l	a0,$54(a6) 				;BLTDPTH

	move	#((BG_VSCREEN_HEIGHT*2)<<6)|(SCREEN_WIDTH/16),$58(a6)		;BLTSIZE
									;hhhhhhhhhhwwwwww 10:6	
	movem.l (sp)+,a6
	rts
	
;************************************************
;*
;* drawFGText8x8
;*
;* a0 = text
;* d0.w = pos x (8 pixel steps)
;* d1.w = pos y
;*
;*
;************************************************

drawFGText8x8

	movem.l	d1-d2/a0-a3,-(sp)
	
	lea	font1,a1
	lea	fgPlane,a2
	and.l	#$ffff,d0
	add.l	d0,a2		;+x
	;mulu	#FG_TEXT_VSCREEN_WIDTH/8,d1
	MULUC	(FG_TEXT_VSCREEN_WIDTH/8),d1,d2
	add.l	d1,a2		;+y
	
.drawTextLoop
	moveq	#0,d2
	move.b	(a0)+,d2
	tst.b	d2
	beq	.drawTextLoopEnd
	
	sub.b	#' ',d2
	cmp.b	#58,d2
	bls	.charInRange
	moveq	#0,d2
.charInRange	
	lea	(a1,d2.w),a3
	
	move.b	(59*0)(a3),(FG_TEXT_VSCREEN_WIDTH/8)*0(a2)
	move.b	(59*1)(a3),(FG_TEXT_VSCREEN_WIDTH/8)*1(a2)
	move.b	(59*2)(a3),(FG_TEXT_VSCREEN_WIDTH/8)*2(a2)
	move.b	(59*3)(a3),(FG_TEXT_VSCREEN_WIDTH/8)*3(a2)
	move.b	(59*4)(a3),(FG_TEXT_VSCREEN_WIDTH/8)*4(a2)
	move.b	(59*5)(a3),(FG_TEXT_VSCREEN_WIDTH/8)*5(a2)
	move.b	(59*6)(a3),(FG_TEXT_VSCREEN_WIDTH/8)*6(a2)
	move.b	(59*7)(a3),(FG_TEXT_VSCREEN_WIDTH/8)*7(a2)
		
	addq.l	#1,a2
	bra	.drawTextLoop
	
.drawTextLoopEnd	
	movem.l (sp)+,d1-d2/a0-a3
	rts	
	
;************************************************
;*
;* drawFGHexText8x8
;*
;* d0   = pos x (8 pixel steps)
;* d1   = pos y
;* d2.w = hex value
;*
;*
;************************************************

drawFGHexText8x8

	movem.l	d0-d4/a0-a2,-(sp)
	
	lea	font1,a1
	lea	fgPlane,a2
	and.l	#$ffff,d0
	add.l	d0,a2		;+x
	;mulu	#FG_TEXT_VSCREEN_WIDTH/8,d1
	MULUC	(FG_TEXT_VSCREEN_WIDTH/8),d1,d3
	add.l	d1,a2		;+x
	
	moveq	#4-1,d1
.drawHexLoop
	
	rol	#4,d2
	move	d2,d5
	and	#$f,d5
	cmp	#9,d5
	bgt	.drawHexA_F
	add	#16,d5
.drawHexA_F_rts
		
	moveq	#0,d4
	moveq	#7,d3
.drawHexCopy	
	move.b	(a1,d5.w),(a2,d4.w)
	add	#59,d5
	add	#FG_TEXT_VSCREEN_WIDTH/8,d4
	dbf	d3,.drawHexCopy
	addq.l	#1,a2
	
	dbf	d1,.drawHexLoop
	
.drawTextLoopEnd	
	movem.l (sp)+,d0-d4/a0-a2
	rts
	
.drawHexA_F
	add	#8+15,d5
	bra	.drawHexA_F_rts	
	
;************************************************
;*
;* clrFGText8x8
;*
;* d0.l = pos x (8 pixel steps)
;* d1.l = pos y
;*
;************************************************

clrFGText8x8

	movem.l	d1-d2/a0,-(sp)

	lea	fgPlane,a0
	add.l	d0,a0		;+x
	;mulu	#FG_TEXT_VSCREEN_WIDTH/8,d1
	MULUC	(FG_TEXT_VSCREEN_WIDTH/8),d1,d2
	add.l	d1,a0		;+y
	
	clr.b	(FG_TEXT_VSCREEN_WIDTH/8)*0(a0)
	clr.b   (FG_TEXT_VSCREEN_WIDTH/8)*1(a0)
	clr.b   (FG_TEXT_VSCREEN_WIDTH/8)*2(a0)
	clr.b   (FG_TEXT_VSCREEN_WIDTH/8)*3(a0)
	clr.b   (FG_TEXT_VSCREEN_WIDTH/8)*4(a0)
	clr.b   (FG_TEXT_VSCREEN_WIDTH/8)*5(a0)
	clr.b   (FG_TEXT_VSCREEN_WIDTH/8)*6(a0)
	clr.b   (FG_TEXT_VSCREEN_WIDTH/8)*7(a0)
	
	movem.l	(sp)+,d1-d2/a0
	rts
	
;************************************************************************************************
;*
;* copyStars
;*
;* d0.w = offset 						[reg will modified]
;*
;* a0.l = starArray1	(star x data)				[reg will modified]
;* a1.l = sprX copper list entry (+2 PTH)			[reg will modified]
;* a2.l = sprDataOdd						[reg will modified]
;* a3.l = sprDataEven
;*
;************************************************************************************************

copyStars
	
	movem.l	d1/a6,-(sp)
		
	move.l	a2,d1
	btst	#0,d0		;count even or odd
	beq	.notEven
	move.l	a3,d1
.notEven	
	
	;set sprh/l 
	 
	move.l	d1,a2					;D
	move	d1,4(a1)
	swap	d1
	move	d1,(a1)
	
	and	#$1fe,d0				;counter /2 &ff *2 -> &1fe
	lea	(a0,d0.w),a0				;add offset 
							;B
	move.l	a2,a1					;A
	
	;

	lea	$dff000,a6	
	
	move	#$8400,$96(a6)		;DMACON blit prio
.cSwB1B
	btst	#6,2(a6)
	bne.s	.cSwB1B	
	move	#$0400,$96(a6)		;DMACON no blit prio	
	
	move.l	#$0dfc0000,$40(a6)			;BLTCON0 USE A (sprOdd/even),B (star Array),D (sprOdd/even) ; (minterm = a -> D = A|B -> a+b -> a(b*~b)(c*~c) + (a*~a)b(c*~c) -> abc + ab~c + a~bc + a~b~c + abc + ab~c + ~abc + ~ab~c -> 76543200 -> $FC)  ;BLTCON1 = 0
	move.l	#$ff00ffff,$44(a6)			;BLTAFWM = $ff00 (remove old X Pos); BLTALWM = ~0
	movem.l	a0-a2,$4c(a6)				;BLTBPTH; BLTAPTH ;BLTDPTH 
	clr.w	$62(a6)					;BLTBMOD =  0
	move.l	#$00060006,$64(a6)			;BTLAMOD = BLTDMOD = 6
	move	#((SCREEN_HEIGHT/2)<<6)|1,$58(a6)	;BLTSIZE h = HEIGHT w -> start
	
	movem.l	(sp)+,d1/a6
	rts
	
;************************************************************************************************
;*
;* genStarSprites
;*
;************************************************************************************************	
	
genStarSprites

	move.l	#$80000000,d0
	moveq	#0,d1		
	lea	star0SprDataEven,a0
	bsr	genStarSpriteData
	
	move.l	#$80000000,d0
	moveq	#1,d1		
	lea	star0SprDataOdd,a0
	bsr	genStarSpriteData
	
	move.l	#$8000,d0
	moveq	#0,d1		
	lea	star1SprDataEven,a0
	bsr	genStarSpriteData
	
	move.l	#$8000,d0
	moveq	#1,d1		
	lea	star1SprDataOdd,a0
	bsr	genStarSpriteData
	
	move.l	#$80000000,d0
	moveq	#0,d1		
	lea	star2SprDataEven,a0
	bsr	genStarSpriteData
	
	move.l	#$80000000,d0
	moveq	#1,d1		
	lea	star2SprDataOdd,a0
	bsr	genStarSpriteData
	
	move.l	#$8000,d0
	moveq	#0,d1		
	lea	star3SprDataEven,a0
	bsr	genStarSpriteData
	
	move.l	#$8000,d0
	moveq	#1,d1		
	lea	star3SprDataOdd,a0
	bsr	genStarSpriteData

	rts
	
	
;************************************************************************************************
;*
;* genStarSpriteData
;*
;* d0.l = spr data 32 bit
;* d1.w = offset (0..1)						[reg will modified]					
;*
;* a0.l = destination						[reg will modified]
;*
;************************************************************************************************
	
genStarSpriteData

	movem.l	d2-d6,-(sp)
	
	move.l	#(SCREEN_HEIGHT/2)-1,d6
	and	#1,d1		;
	add	#IVSTART,d1	;start = IVSTART + offset
.gsLoop
	move	d1,d3		;start
	move	d1,d4		
	addq	#1,d4		;stop = start +1 
	
	move	d3,d5
	lsl	#8,d5
	move	d5,(a0)+	;VVVVVVVV00000000
	
	clr.b	d3		;0000000V 00000000 
	lsr	#6,d3		;00000000 00000V00 
	move	d4,d5		;0000000v vvvvvvvv
	lsl	#8,d5		;vvvvvvvv 00000000
	or	d3,d5		;vvvvvvvv 00000V00
	clr.b	d4		;0000000v 00000000
	lsr	#7,d4		;00000000 000000v0
	or	d4,d5		
	move	d5,(a0)+	;vvvvvvvv 00000Vv
	move.l	d0,(a0)+	;gfx
	
	addq	#2,d1		;i+=2
	dbf	d6,.gsLoop
	
	clr.l	(a0)+		;zero
	clr.l	(a0)+

	movem.l	(sp)+,d2-d6
	rts
	
;************************************************************************************************
;*
;* clearSprites
;*
;* a0.l = first ptr to sprh in copperlist (8 sprite pth,ptl)
;	
;************************************************************************************************
	
clearSprites

	move.l	#.sprEmpty,d0
	moveq	#8-1,d1
.csLopp	
	move	d0,4(a0)
	swap	d0
	move	d0,(a0)
	swap	d0
	addq	#8,a0
	dbf	d1,.csLopp	
	rts
	
.sprEmpty	
	dc.w	$0090,$0002,$0000,$0000,$0000,$0000	
	cnop	0,4
	
;************************************************************************************************
;*
;* randStarXArrays
;*	
;************************************************************************************************

randStarXArrays

	lea	.starArrays,a1
	lea	.starArrayMaks,a2
	moveq	#4-1,d1
.starArrayLoop

	move.l 	(a1)+,a0
	move 	(a2)+,d4
	move.l	#256-1,d2
.genStarPos
	move	d2,d3
	moveq	#0,d0
	and	d4,d3
	bne	.skip
	bsr	fastRand
	add	#IHSTART/2,d0
	and	#$ff,d0
.skip	move	d0,(a0)+
	move	d0,(256*2)-2(a0)	;same data mirrored 
	dbf	d2,.genStarPos
	dbf	d1,.starArrayLoop
	
	rts
	
	cnop	0,4
	
.starArrays	dc.l	starArray1,starArray2,starArray3,starArray4
.starArrayMaks	dc.w	0,1,1,1

;************************************************************************************************
;*
;* moveStars
;*
;* a0 = spr (4) cop ptr  (spr 5,6,7 follow)
;*	
;************************************************************************************************

moveStars

	movem.l	d0-d3/a0-a4,-(sp)
	move.l	a0,a4

	;spr4
	
	move	.starCounter4,d0
	asr	#5,d0
	lea	starArray4,a0
	lea	2+(8*0)(a4),a1
	lea	star0SprDataOdd,a2
	lea	star0SprDataEven,a3
	bsr	copyStars
	
	;spr5
	
	move	.starCounter3,d0
	asr	#5,d0
	lea	starArray3,a0
	lea	2+(8*1)(a4),a1
	lea	star1SprDataOdd,a2
	lea	star1SprDataEven,a3
	bsr	copyStars
	
	;spr6
	
	move	.starCounter2,d0
	asr	#5,d0
	lea	starArray2,a0
	lea	2+(8*2)(a4),a1
	lea	star2SprDataOdd,a2
	lea	star2SprDataEven,a3
	bsr	copyStars

	;spr7
	
	move	.starCounter,d0
	asr	#5,d0
	lea	starArray1,a0
	lea	2+(8*3)(a4),a1
	lea	star3SprDataOdd,a2
	lea	star3SprDataEven,a3
	bsr	copyStars
		
	lea	.starCounter,a0
	movem	starSpeed,d0-d3
	sub	d0,(a0)+
	sub	d1,(a0)+
	sub	d2,(a0)+
	sub	d3,(a0)

	movem.l (sp)+,d0-d3/a0-a4
	rts

.starCounter	dc.w	0<<6	
.starCounter2	dc.w	32<<6
.starCounter3	dc.w	64<<6
.starCounter4	dc.w	96<<6

starSpeed	dc.w	1,2,5,8

;************************************************************************************************
;*
;* setStarsSpeed
;*
;* d0..d3 = new speed (default 1,2,5,8)
;*	
;************************************************************************************************

setStarsSpeed
	movem	d0-d3,starSpeed
	rts
	
	cnop	0,4	

;************************************************
;*	
;* moveShipSprite
;* 
;* d0.w = x (modfied)
;* d1.w = y (modfied)
;*
;* a0.l = spr cop + 2
;* a1.l = spr data
;*
;************************************************
	
moveShipSprite

	movem.l	d1-d3/a1,-(sp)

	;SPRxPOS
	;5432109876543210
	;111111
	;
	;VVVVVVVVHHHHHHHH
	;76543210a9876543 V = VStart 7..0
	;		  H = HStart 8..1

	;SPRxCTL
	;5432109876543210
	;111111
	;
	;vvvvvvvvA0000VvH v = VStop 7..0 ; VStart = 8; vStop = 8
	;                 H = HStart 0
	;
	
	;d3 = SPRxPOS:SPRxCTL
	;1098765432109876 5432109876543210
	;3311111111121111 111111
	;
	;VVVVVVVVHHHHHHHH vvvvvvvvA----VvH
	
	cmp	#-32,d0
	bgt	.xInMargin
	cmp	#SCREEN_WIDTH,d0
	blt	.xInMargin
	moveq	#0,d0
.xInMargin	
	
	cmp	#-16,d0
	bgt	.yInMargin
	cmp	#SCREEN_HEIGHT,d1
	blt	.yInMargin
	moveq	#0,d1
.yInMargin	
	
	
	add	#IVSTART,d1	
	move	d1,d2		;-------- -------- 0000000V VVVVVVVV VStart
	add	#32,d2		;-------- -------- 0000000v vvvvvvvv VStop
	
	swap	d1		;0000000V VVVVVVVV -------- --------
	clr	d1		;0000000V VVVVVVVV 00000000 00000000
	rol.l	#8,d1		;VVVVVVVV 00000000 00000000 0000000V
	add	d1,d1		;VVVVVVVV 00000000 00000000 000000V0
	add	d1,d1		;VVVVVVVV 00000000 00000000 00000V00
	
	rol	#8,d2		;-------- -------- vvvvvvvv 0000000v
	add.b	d2,d2		;-------- -------- vvvvvvvv 000000v0
	
	add	#IHSTART,d0	;-------- -------- 0000000H HHHHHHHH HStart
	move	d0,d3
	
	swap	d0		;0000000H HHHHHHHH -------- -------- 
	clr	d0		;0000000H HHHHHHHH 00000000 00000000 
	lsr.l	#1,d0		;00000000 HHHHHHHH H0000000 00000000
	rol	#1,d0		;00000000 HHHHHHHH 00000000 0000000H
	
	add	#16,d3
	
	swap	d3		;0000000H HHHHHHHH -------- -------- 
	clr	d3		;0000000H HHHHHHHH 00000000 00000000 
	lsr.l	#1,d3		;00000000 HHHHHHHH H0000000 00000000
	rol	#1,d3		;00000000 HHHHHHHH 00000000 0000000H
	
	or.l	d1,d0		;VVVVVVVV HHHHHHHH 00000000 00000V0H
	or	d2,d0		;VVVVVVVV HHHHHHHH vvvvvvvv 00000VvH
	
	or.l	d1,d3
	or	d2,d3
		
	move.l	a1,d2
	move	d2,4(a0)
	swap	d2
	move	d2,(a0)
	move.l	d0,(a1)
	
	lea	(4+128+4)(a1),a1
	lea	8(a0),a0
	move.l	a1,d2
	move	d2,4(a0)
	swap	d2
	move	d2,(a0)
	or	#$80,d0
	move.l	d0,(a1)
	
	lea	((4+128+4))(a1),a1
	lea	8(a0),a0
	move.l	a1,d2
	move	d2,4(a0)
	swap	d2
	move	d2,(a0)
	move.l	d3,(a1)
	
	lea	((4+128+4))(a1),a1
	lea	8(a0),a0
	move.l	a1,d2
	move	d2,4(a0)
	swap	d2
	move	d2,(a0)
	or	#$80,d3
	move.l	d3,(a1)
	
	movem.l	(sp)+,d1-d3/a1

	rts

;************************************************
;*	
;* moveLogoShip
;*
;************************************************

moveLogoShip

LSHIP_X_SPACE	equ 128

	;move

	lea	.logoShipAdd,a0
	movem	(a0),d0-d1
	add	d0,d1
	cmp	#SCREEN_WIDTH+LSHIP_X_SPACE,d1
	blt	.inRangeMax
	neg	d0
.inRangeMax	
	cmp	#-LSHIP_X_SPACE-32,d1
	bge	.inRangeMin
	neg	d0
.inRangeMin

	movem	d0-d1,(a0)
	
	;set ship sprites
	
	lea	shipSpritesL,a1
	tst	d0
	bpl	.posDir
	lea	shipSpritesR,a1
.posDir
	
	lea	logoSpr0+2,a0
	move	.logoShipX,d0
	move	#22,d1
	bsr	moveShipSprite
	
	;color ship
	
	lea	logoColorShipEg,a0
	movem.l	(a0),d0/a1	;color, dest adr
	eor.l	#$008080,d0
	move.l	d0,(a0)
	move	fadeColorMul,d1
	bsr	colorDiv
	move	d0,(a1)		;write color
	
	;color bg move
	
	move	.logoShipX,d0
	cmp	#SCREEN_WIDTH,d0
	bge	.outHRange
	cmp	#-32,d0
	blt	.outHRange

	asr	#1,d0
	add	#(IHSTART>>1)+8,d0
	or	#1,d0
	lea	logoCopColor6+9,a0
	move.b	d0,16*0(a0)
	move.b	d0,16*1(a0)
	move.b	d0,16*2(a0)
	move.b	d0,16*3(a0)
	move.b	d0,16*4(a0)
	move.b	d0,16*5(a0)
	move.b	d0,16*6(a0)
	move.b	d0,16*7(a0)
	move.b	d0,16*8(a0)
	move.b	d0,16*9(a0)
	move.b	d0,16*10(a0)
	move.b	d0,16*11(a0)
	move.b	d0,16*12(a0)
	move.b	d0,16*13(a0)
	move.b	d0,16*14(a0)
	move.b	d0,16*15(a0)
	
.outHRange

	rts
	
.logoShip	
.logoShipAdd	dc.w	3	
.logoShipX	dc.w	-LSHIP_X_SPACE	

	cnop	0,4

;************************************************************************************************
;*
;* initKeyboard
;*	
;************************************************************************************************
	
initKeyboard

	move	#$ffff,rawKey
	move	#$ffff,lastRawKey
	
	lea	rawKeyMap,a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)
	
	rts

;************************************************************************************************
;*
;* checkKeyboard
;*
;* note: call one time per frame
;*       scan code is placed in rawKey (0xffff is nothing received)
;*       rawKeyMap has bits for keys ordered by scancode (pressed = 1)
;*	
;************************************************************************************************
	
checkKeyboard

	movem.l	d0-d2/a0-a2,-(sp)

	lea	$bfe001,a0		;CIA A	
	lea	checkKeyboardState,a1
	tst.b	(a1)
	bne.s	.keyBoardState2
	
	;state 1
	
	btst.b	#3,$d00(a0)		;test SP in CIAICR (serial data received)
	beq	.keyBoardEnd		;no data available
	
	moveq	#0,d0
	move.b	$c00(a0),d0		;get (CIASDR)
	not.b	d0
	ror.b	#1,d0 	
	move.w	d0,rawKey		;and store raw key 
	
	move	d0,d1
	move	d0,d2
	lsr	#3,d1			;sxxxxxxx -> 000sxxxx
	and	#$7,d0			;xxx
	and	#$f,d1
	
	lea	rawKeyMap(pc,d1.w),a2
	bclr.b	d0,(a2)
	btst	#7,d2
	bne	.keyNotPressed
	bset.b	d0,(a2)
.keyNotPressed

	
	or.b	#1<<6,$e00(a0)		;set output mode (SPMODE = output (1)) in CIACRA (handshake for keyboard)
	
	st	(a1)			;next .keyBoardState2
	bra	.keyBoardEnd	

.keyBoardState2

	;state 2
		
	and.b	#~(1<<6),$e00(a0)	;set input mode (SPMODE = input (0)) in CIACRA 
	sf	(a1)			;next .keyBoardState1
		
.keyBoardEnd	

	movem.l	(sp)+,d0-d2/a0-a2
	rts
	
	cnop	0,4

rawKeyMap		ds.l	4
rawKey			dc.w	0
lastRawKey		dc.w	0
checkKeyboardState	dc.b	0

	cnop	0,4

;************************************************************************************************
;*
;* releaseKeyboard
;*	
;************************************************************************************************
	
releaseKeyboard

	tst.b	checkKeyboardState
	beq	.keyboardNoWait		;nothing todo (no wait for handshake)
	
	WAITV	#$10
	WAITV	#$20			;maybe no vblank to last checkKeyboard
	
	bsr	checkKeyboard		;have to handshake
	
.keyboardNoWait
	rts
	
;************************************************************************************************
;*
;* keyToAscii
;*	
;* return:
;*
;* d0.w = if not $ffff then 'ascii' value (no shift etc.)
;*
;************************************************************************************************	

keyToAscii
	
	move	rawKey,d0
	cmp	#$5f,d0
	bgt	.noKey	
	
	move.b	.rawBig(pc,d0.w),d0
	rts

.noKey	move	#$ffff,d0
	rts

			;              U             UNNN           UUNNNU          UNNNNSBTEREDUUU UUDFBFFFFFFFFFF     H
			;              N             NPPP           NNPPPN          NPPPPPAANESENNN NPOOW1234567891     E
			;	       D             DAAA           DDAAAD          DAAAAACBTRCLDDD D WRA         0     L
			;              E             EDDD           EEDDDE          EDDDDCK ET  EEE E NWR               P
			;              F             F              FF   F          F    ES R   FFF F  DD               
			;
			;0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF
			;                11111111111111112222222222222222333333333333333344444444444444445555555555555555
.rawBig		dc.b	"`1234567890-=  0QWERTYUIOP[] 123ASDFGHJKL;   456 ZXCVBNM,./ .789          -(              ()/*+ "			
;.rawUnshifted	dc.b	"`1234567890-=  0qwertyuiop[] 123asdfghjkl;'  456 zxcvbnm,./ .789          -(              ()/*+ "
;.rawShifted	dc.b	"~!@#$%^&*()_+| 0QWERTYUIOP{} 123ASDFGHJKL:\"  456 ZXCVBNM<>  .789          -               ()/*+ "

	cnop	0,4
	
;************************************************************************************************
;*
;* processTextInput
;*
;* d0.w = current key code
;* d1.w = last key code
;* d2.w = max text (buffer) length -1
;*
;*
;* a1   = text adr
;* a2   = text pos adr (word)
;* a3   = curser text buffer adr
;* a4   = curser text buffer state adr (word)
;*
;* return:
;*
;* d0   = 1 when return pressed 
;*	
;************************************************************************************************

processTextInput

	move.l	d3,-(sp)

	moveq	#' ',d3

	cmp	d0,d1
	beq	.noClKeyChange
	
	cmp	#$41,d0
	beq	.backSpace
	
	cmp	#$44,d0
	beq	.enter
			
	bsr	keyToAscii
	cmp	#$ffff,d0
	beq	.ptiEnd
	
	;set char
	
	move	(a2),d1		;clTextPos
	cmp	d2,d1		;in text range
	bge	.ptiEnd		;
	move.b	d0,(a1,d1.w)	;val in text
	
	addq	#1,d1	
	move	d1,(a2)
	
.ptiEnd	
	moveq	#0,d0

.ptiEndE
	move.l	(sp)+,d3
	rts
	
	;enter
	
.enter	
	moveq	#1,d0
	bra	.ptiEndE

	;back space
	
.backSpace	
	
	move	(a2),d0		;clTextPos
	tst	d0
	beq	.leftLimit
	
	sub	#1,d0
	move	d0,(a2)
	move.b	d3,(a1,d0.w)	;clear last
.leftLimit	
	bra	.ptiEnd	
	
	;no key change draw curser
	
.noClKeyChange	

	move	(a4),d1		;curser state
	add	#1,d1
	move	d1,(a4)
	and	#$4,d1
	
	move	(a2),d0		;clTextPos
	
	move.l	a3,a0
.clrLoop
	move.b	d3,(a0)+
	dbf	d2,.clrLoop
		
	tst	d1
	bne	.noFlip
	move.b	#'&',(a3,d0.w)
.noFlip
	bra	.ptiEnd		

;************************************************
;*	
;* checkAndDrawLogoText
;*
;* return:
;*
;* d0.w -> 0 nothing; 1 start; 2 exit
;*
;************************************************

checkAndDrawLogoText

	movem.l	d1-d3/a0-a1,-(sp)

	movem	cadState,d0-d1	;state,;sub counter	
	move	d0,d2
	and	#$7,d2
	add	d2,d2
	add	d2,d2
	move.l	checkAndDrawLogoTextStates(pc,d2.w),a2	;jump
	jsr	(a2)

	movem	d0-d1,cadState
	
	cmp	#CADLTS_FINISH,d0
	beq	.retCodeSet
	moveq	#0,d0		
.cadFinish

	movem.l	(sp)+,d1-d3/a0-a1
	rts
	
.retCodeSet
	move	cADRetCode,d0
	bra.s	.cadFinish
	
checkAndDrawLogoTextStates

	dc.l	fctCADLTS_DRAW_LOGO_START
	dc.l	fctCADLTS_DRAW_LOGO_TEXT
	dc.l	fctCADLTS_DRAW_SELECTION	
	dc.l	fctCADLTS_CHK_SET_SEL	
	dc.l	fctCADLTS_DRAW_HISCORE_TEXT
	dc.l	fctCADLTS_FINISH
	dc.l	fctCADLTS_CLEAR_LOGO_TEXT
	
cadState	dc.w	CADLTS_DRAW_LOGO_START,0	;state,counter	
cADRetCode	dc.w	0 ;0 nothing; 1 start; 2 exit

	cnop	0,4
	
CADLTS_DRAW_LOGO_START		equ	0	
CADLTS_DRAW_LOGO_TEXT		equ	1
CADLTS_DRAW_SELECTION		equ	2
CADLTS_CHK_SET_SEL		equ	3
CADLTS_DRAW_HISCORE_TEXT	equ	4
CADLTS_FINISH			equ	5
CADLTS_CLEAR_LOGO_TEXT		equ	6

;************************************************
;*	
;* resetLogoTextStates
;*
;************************************************
	
resetLogoTextStates

	move	#CADLTS_DRAW_LOGO_START,cadState
	clr	cadState+2
	clr	cADSEData+css_hsOrTitle
	rts
	
; goto CADLTS_DRAW_LOGO_TEXT	
	
fctCADLTS_DRAW_LOGO_START	
	moveq	#0,d1
	moveq	#CADLTS_DRAW_LOGO_TEXT,d0	
	rts
	
; draw logo text and goto CADLTS_DRAW_SELECTION	
	
fctCADLTS_DRAW_LOGO_TEXT
	
	addq	#1,d1
	move	d1,d3
	
	cmp	#5,d3
	bne	.t1
	moveq	#10,d0
	moveq	#8*2,d1
	lea	logoText,a0
	bsr	drawFGText8x8
.t1
	cmp	#10,d3
	bne	.t2
	moveq	#13,d0
	moveq	#8*3,d1
	lea	logoText1,a0
	bsr	drawFGText8x8
.t2	
	cmp	#15,d3
	bne	.t3
	moveq	#13,d0
	moveq	#8*4,d1
	lea	logoText2,a0
	bsr	drawFGText8x8
.t3
	cmp	#20,d3
	bne	.t4
	moveq	#11,d0
	moveq	#8*5,d1
	lea	logoText3,a0
	bsr	drawFGText8x8
.t4
	cmp	#25,d3
	bne	.t5
	moveq	#7,d0
	moveq	#8*7,d1
	lea	logoText4,a0
	bsr	drawFGText8x8
.t5	
	cmp	#30,d3
	bne	.t6
	moveq	#13,d0
	moveq	#8*8,d1
	lea	logoText5,a0
	bsr	drawFGText8x8
.t6	
	cmp	#35,d3
	bne	.t7
	moveq	#12,d0
	moveq	#8*10,d1
	lea	logoText6,a0
	bsr	drawFGText8x8
.t7	
	;state check

	moveq	#CADLTS_DRAW_LOGO_TEXT,d0
	cmp	#40,d3
	bne	.notNext
	moveq	#CADLTS_DRAW_SELECTION,d0
	clr	d3
.notNext

	move	d3,d1
	rts	
	
; check keyboard/joy draw selection and goto CADLTS_DRAW_HISCORE_TEXT or CADLTS_CLEAR_LOGO_TEXT at hiscore/logo sel or CADLTS_FINISH at start/exit

fctCADLTS_DRAW_SELECTION

	moveq	#18,d0
	moveq	#8*13,d1
	lea	logoTextStart,a0
	bsr	drawFGText8x8
	
	moveq	#14,d0
	moveq	#8*14,d1
	lea	logoTextHiscore,a0
	bsr	drawFGText8x8
	
	moveq	#18,d0
	moveq	#8*15,d1
	lea	logoTextExit,a0
	bsr	drawFGText8x8

	moveq	#CADLTS_CHK_SET_SEL,d0
	moveq	#0,d1
	rts

	
fctCADLTS_CHK_SET_SEL

	lea	cADSEData,a2		;
	
	;check up/down
	
	lea	.returnOfSel,a1		;returnpos to stack
	
	move.b	joy1Dat,d0
	cmp	css_lastJoyDat(a2),d0
	beq	.sameJoyDat
	move	d0,css_lastJoyDat(a2)
	btst	#1,d0
	bne	.selUp
	btst	#0,d0
	bne	.selDwn	
.sameJoyDat	

	;keyboard
	
	move	rawKey,d0
	cmp	css_lastRawKey(a2),d0
	beq	.sameKeyCode
	move	d0,css_lastRawKey(a2)
	cmp	#$4c,d0
	beq	.selUp
	cmp	#$4d,d0
	beq	.selDwn
.sameKeyCode

	
.returnOfSel	
	
	;do only at 0 from 15 frames
	
	move	css_counter(a2),d0
	addq	#1,d0
	move	d0,css_counter(a2)
	and	#$7,d0
	tst	d0
	bne	.waitTime
	
	;clear last stars
	
	move	css_lastSelect(a2),d1
	lsl	#3,d1		;last select * 8
	add	#8*13,d1
	moveq	#15-3,d0
	bsr	clrFGText8x8
	moveq	#23+5,d0
	bsr	clrFGText8x8
	
	move	css_counter(a2),d0
	and	#$8,d0
	tst	d0
	bne	.noOverDraw
	
	;draw stars
		
	move	css_select(a2),d1	
	lsl	#3,d1		;select * 8
	add	#8*13,d1
	moveq	#15-3,d0
	lea	logoTextStar,a0
	bsr	drawFGText8x8
	moveq	#23+5,d0
	bsr	drawFGText8x8
	
.noOverDraw	
	
	move	css_select(a2),css_lastSelect(a2)	;current -> last
	
.waitTime	
	
	;check fire / return
	;fire      enter 44->c4         joy %1----
	
	moveq	#0,d0
	move.b	joy1Dat,d1
	and.b	#$10,d1
	tst.b	d1
	beq	.noFire
	moveq	#1,d0
.noFire	
	move	rawKey,d1
	cmp	#$44,d1
	bne	.noReturn
	moveq	#1,d0
.noReturn	

	tst	d0
	beq	.noFireOrReturn
	
	;fire or enter
	
	cmp	#0,css_select(a2)	;start
	beq	.startActivated
	cmp	#2,css_select(a2)	;exit
	beq	.exitActivated
	
	;else hiscore or title
	
	moveq	#CADLTS_DRAW_HISCORE_TEXT,d0
	eor	#1,css_hsOrTitle(a2)	;z = if zero
	bne	.nextTitle
	moveq	#CADLTS_CLEAR_LOGO_TEXT,d0
.nextTitle	

	moveq	#0,d1
	rts
	
.startActivated	
	move	#1,cADRetCode	; ;0 nothing; 1 start; 2 exit
	moveq	#CADLTS_FINISH,d0
	moveq	#0,d1
	rts
	
.exitActivated	
	move	#2,cADRetCode	; ;0 nothing; 1 start; 2 exit
	moveq	#CADLTS_FINISH,d0
	moveq	#0,d1
	rts
	
.noFireOrReturn	
	moveq	#CADLTS_CHK_SET_SEL,d0
	moveq	#0,d1
	rts
	
.selUp	tst	css_select(a2)
	beq	.noUp
	subq	#1,css_select(a2)
.noUp	jmp	(a1)

.selDwn	cmp	#2,css_select(a2)
	beq	.noDown
	addq	#1,css_select(a2)
.noDown	jmp	(a1)	

	rsreset
css_select	rs.w	1	;current
css_lastSelect	rs.w	1	;last
css_counter	rs.w	1
css_lastRawKey	rs.w	1
css_lastJoyDat	rs.w	1
css_hsOrTitle	rs.w	1	;hiscore or title lsb	
css_sizeOf	so	

		cnop	0,4
cADSEData	dcb.b	css_sizeOf,0
		cnop	0,4
		
; draw hiscore and goto CADLTS_CHK_SET_SEL

fctCADLTS_DRAW_HISCORE_TEXT

	addq	#1,d1
	move	d1,d3
	
	cmp	#35,d1
	bge	.noClr
	
	moveq	#0,d0
	moveq	#0,d1
	move	d3,d0
	move	#11,d2
.textClrLoop
	bsr	clrFGText8x8
	add	#8,d1
	dbf	d2,.textClrLoop
	
.noClr	

	cmp	#50,d1
	blt	.noHiscore
	cmp	#50+HISCORE_LENGTH+1,d1
	bge	.noHiscore
	
	move.l	d3,-(sp)
	moveq	#0,d3
	move	d1,d3
	sub	#50,d3
	
	move.l	d3,d0	;score line = line
	moveq	#15,d2	;text x
	moveq	#8*3,d3	;y offset = 0
	bsr	drawHiscoreLine
	move.l	(sp)+,d3
	
.noHiscore

	;
	moveq	#CADLTS_DRAW_HISCORE_TEXT,d0
	cmp	#70,d1
	bne	.notFinish
	moveq	#CADLTS_CHK_SET_SEL,d0
.notFinish

	move	d3,d1
	rts			

; selection is finished

fctCADLTS_FINISH
	moveq	#CADLTS_FINISH,d0
	moveq	#0,d1
	rts

; clear text and goto CADLTS_DRAW_LOGO_START

fctCADLTS_CLEAR_LOGO_TEXT

	addq	#1,d1
	move	d1,d3
	
	cmp	#35,d1
	bge	.noClr
	
	moveq	#0,d0
	moveq	#0,d1
	move	d3,d0
	move	#11,d2
.textClrLoop
	bsr	clrFGText8x8
	add	#8,d1
	dbf	d2,.textClrLoop
	
.noClr	

	moveq	#CADLTS_CLEAR_LOGO_TEXT,d0

	cmp	#50,d1
	bne	.noGotoText
	moveq	#CADLTS_DRAW_LOGO_START,d0
	moveq	#0,d3
.noGotoText	
	move	d3,d1
	rts
	

;************************************************
;*	
;* colorDiv
;*
;* d0.l = 00rr ggbb
;* d1.w = multiplier (0..f -> dark 0..1)	(modfied)
;*
;* d0.w = 0rgb
;*
;************************************************
		
colorDiv
	movem.l	d2/a0,-(sp)
	and.l	#$00f0f0f0,d0
	lea	mdTab(pc,d1.w),a0
	move	d0,d1
	lsr	#8,d1		;00g0
	move.b	(a0,d1.w),d1	;000G
	lsl	#4,d1		;00G0
	move	d0,d2		;g0b0
	and	#$ff,d2		;00b0
	or.b	(a0,d2.w),d1	;00GB
	swap	d0		;00g0 00r0 
	move.b	(a0,d0.w),d0	;000R
	lsl	#8,d0		;0R00
	or	d1,d0		;0RGB
	movem.l	(sp)+,d2/a0
	rts
		
mdTab	dc.b    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
	dc.b    $00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$02
	dc.b    $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$03
	dc.b    $00,$00,$00,$01,$01,$01,$01,$02,$02,$02,$02,$03,$03,$03,$03,$04
	dc.b    $00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$03,$04,$04,$04,$05
	dc.b    $00,$00,$01,$01,$01,$02,$02,$03,$03,$03,$04,$04,$04,$05,$05,$06
	dc.b    $00,$00,$01,$01,$02,$02,$03,$03,$03,$04,$04,$05,$05,$06,$06,$07
	dc.b    $00,$01,$01,$02,$02,$03,$03,$04,$04,$05,$05,$06,$06,$07,$07,$08
	dc.b    $00,$01,$01,$02,$02,$03,$03,$04,$05,$05,$06,$06,$07,$07,$08,$09
	dc.b    $00,$01,$01,$02,$03,$03,$04,$05,$05,$06,$06,$07,$08,$08,$09,$0A
	dc.b    $00,$01,$02,$02,$03,$04,$04,$05,$06,$06,$07,$08,$08,$09,$0A,$0B
	dc.b    $00,$01,$02,$03,$03,$04,$05,$06,$06,$07,$08,$09,$09,$0A,$0B,$0C
	dc.b    $00,$01,$02,$03,$04,$04,$05,$06,$07,$08,$08,$09,$0A,$0B,$0C,$0D
	dc.b    $00,$01,$02,$03,$04,$05,$06,$07,$07,$08,$09,$0A,$0B,$0C,$0D,$0E
	dc.b    $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	
	cnop	0,4
	
;************************************************
;*	
;* sortHiscore
;*
;************************************************	
	
sortHiscore

	movem.l	d0-d2/a0-a1,-(sp)

.bubbleLoop	
	lea	hiscoreList,a0
	moveq	#HISCORE_LENGTH-1,d2	;note: 1 more for new entry
	moveq	#0,d3
.bubbleUp	
	movem.l	(a0),a1-a2		;i & i+1
	move.w	hiScore_min_sec(a1),d0	;t[i]
	move.w	hiScore_min_sec(a2),d1	;t[i+1]
	cmp	d0,d1
	bls	.noSwp
	exg	a1,a2
	movem.l a1-a2,(a0)
	moveq	#1,d3			;something swaped
.noSwp	addq.l	#4,a0
	dbf	d2,.bubbleUp
	tst	d3
	bne	.bubbleLoop		;while something is swapped

	movem.l	(sp)+,d0-d2/a0-a1
	rts	
	
	cnop	0,4
	
;************************************************
;*	
;* writeHiscore
;*
;************************************************
	
writeHiscore

	move.l	_DOSBase,d2
	move.l	d2,a6
	tst.l	d2
	beq	.writeEnd
	
	;open
	
	move.l	#hicoreFileName,d1
	move.l	#DOS_MODE_NEWFILE,d2
	jsr	_LVOOpen(a6)		
	tst.l	d0
	beq	.writeHiscoreOpenFails	;can't open
	move.l	d0,hiscoreFH
	
	;write
	
	move.l	d0,d1	
	move.l	#hiscoreDefault,d2
	move.l	#(HISCORE_LENGTH+1)*hiScoreObject_sizeOf,d3
	jsr	_LVOWrite(a6)	
	
	;close
	
	move.l	hiscoreFH,d1
	jsr	_LVOClose(a6)
	
.writeEnd
	rts
	
	
.writeHiscoreOpenFails

	cmp	#1,FromCLI
	bne	.writeEnd

	lea	cantWriteHiscoreText,a0
	jsr	Printf	
	
	bra	.writeEnd
	
;************************************************
;*	
;* readHiscore
;*
;************************************************
	
readHiscore

	move.l	_DOSBase,d2
	move.l	d2,a6
	tst.l	d2
	beq	.readEnd
	
	;open
	
	move.l	#hicoreFileName,d1
	move.l	#DOS_MODE_OLDFILE,d2
	jsr	_LVOOpen(a6)		
	tst.l	d0
	beq	.readEnd		;can't open
	move.l	d0,hiscoreFH
	
	;read
	
	move.l	d0,d1	
	move.l	#hiscoreDefault,d2
	move.l	#(HISCORE_LENGTH+1)*hiScoreObject_sizeOf,d3
	jsr	_LVORead(a6)	
	
	;close
	
	move.l	hiscoreFH,d1
	jsr	_LVOClose(a6)
	
.readEnd

	bsr 	sortHiscore		;sort all

	rts	
	
	cnop	0,4
	
hiscoreFH	dc.l	0	

DOS_MODE_NEWFILE	equ	1006
DOS_MODE_OLDFILE	equ	1005	
DOS_MODE_READWRITE	equ	1004
DOS_EXCLUSIVE_LOCK	equ   	-1	;used for dos lock
DOS_INFO_DATA_SIZEOF	equ	$24
DOS_INFO_DATA_DiskState	equ	8
	
;************************************************
;*	
;* helper
;*
;************************************************

	include "os.s"
	
;data	
	
	;SECTION	":D",DATA
	
scanLinesUsedText	dc.b	"max need %d scanlines (test vals %d %d %d %d)",10,0
cantWriteHiscoreText	dc.b	"Can't write hiscore\n",0
logoText		dc.b	"PROGRAMMING MARTEN W.",0
logoText1		dc.b	"AKA GOLDMOMO",0
logoText2		dc.b	"GFX ARBORIS",0
logoText3		dc.b	"MOD/SFX UNKNOWN/ME",0
logoText4		dc.b	"DESIGNED FOR UNACCELERATED",0
logoText5		dc.b	"O/ECS MACHINES",0
logoText6		dc.b	"DEVELOPED IN 2021",0

logoTextStart		dc.b	"START",0
logoTextHiscore		dc.b	"HISCORE/TITLE",0
logoTextExit		dc.b	"EXIT",0
logoTextStar		dc.b	"*",0
TextCharEmpty		dc.b	" ",0

gameTextPower		dc.b	"SHIELD",0
gameTextTime		dc.b	" TIME",0
gameTextTimeValue	dc.b	"00:00",0

gameTextProlog1		dc.b	"ALARM",0
gameTextProlog2		dc.b	"ASTEROID FIELD DETECTED",0
gameTextProlog3		dc.b	"MALFUNCTION IN AUTOPILOT",0
gameTextProlog4		dc.b	"MALFUNCTION IN GUN CONTROL",0
gameTextProlog5		dc.b	"MALFUNCTION IN COMMUNICATION",0
gameTextProlog6		dc.b	"MALFUNCTION IN WARP DRIVE",0
gameTextProlog7		dc.b	"MANUAL CONTROL SWITCHED ON",0
gameTextProlog8		dc.b	"GOOD LUCK",0

gameTextHiscore			dc.b	"HISCORE",0
gameTextHiscoreTimeValue	dc.b	"00:00",0

gameTextInputName	dc.b	"ENTER YOUR NAME",0

;text input
		cnop	0,4
                        ;         11
			 ;12345678
clText		dc.b	"           ", 0
		cnop	0,4
		        ;01230123012301
clCText		dc.b	"           ",0	;need long align
		cnop	0,4

clCurserCnt	dc.w	0		
clTextPos	dc.w	0

CLTextLength	equ	9

	cnop	0,4

testVal1	dc.w	0
testVal2	dc.w	1
testVal3	dc.w	2
testVal4	dc.w	3
scanLinesUsed	dc.w	0

	cnop	0,4

bgPlaneFront		dc.l	bgPlData	
bgPlaneBackground	dc.l	bgPlData2

; logo state

	cnop	0,4
	
LOGO_STATE_SHOW			equ 	0
LOGO_STATE_COLORS_DOWN		equ	1
LOGO_STATE_END			equ	2
LOGO_STATE_COLORS_UP		equ	3

logoState		dc.w	LOGO_STATE_SHOW
logoReturn		dc.w	0		;0 nothing; 1 start; 2 exit
logoStateCounter 	dc.w	0

	cnop	0,4	
	
; game state

	cnop	0,4	

GAME_STATE_COLORS_UP	equ 	0
GAME_STATE_PROLOG	equ 	1
GAME_STATE_PLAY		equ 	2
GAME_STATE_EPILOG	equ 	3
GAME_STATE_NAME_INPUT	equ 	4
GAME_STATE_HISCORE	equ	5
GAME_STATE_COLORS_DOWN	equ 	6
GAME_STATE_END		equ 	7

gameState		dc.w	0
gameStateCounter	dc.w	0
	cnop	0,4		
	
; game ship related	
	
	cnop	0,4
	
GAME_SHIP_SPRITE_GFX_SIZE	equ	544

GAME_SHIP_STATE_MOVE_BIT	equ	0	;0 stop, 1 move
GAME_SHIP_STATE_COLLISION_BIT	equ	1	;0 no, 1 collision
GAME_SHIP_STATE_COLLANIM	equ	2	;collision anim count 1 bit
GAME_SHIP_STATE_EXPLOSION_BIT	equ	3	;0 no, 1 explosion

	rsreset
sGameShip_gfxAdr	rs.l	1
sGameShip_xy		rs.l	1
sGameShip_xyLast	rs.l	1
sGameShip_state		rs.w	1
sGameShip_animCount	rs.w	1
sGameShip_sizeOf 	so  

gameShipData		ds.b	sGameShip_sizeOf	

	cnop	0,4	
	
; stones struct etc.	

	cnop	0,4

STONE_XY_FRACTBITS	equ	3	

sStone_state_RESET	equ	0
sStone_state_ACTIVE	equ	1

	
MAX_STONES 		equ	32

StoneObjects		ds.b	(MAX_STONES*sStone_sizeOf)

	cnop	0,4
	
; stones gfx etc.	

	rsreset
sGfxObject_planesAdr	rs.l	1
sGfxObject_mskPlanesAdr	rs.l	1	
sGfxObject_width	rs.w	1
sGfxObject_height	rs.w	1
sGfxObject_focusX	rs.w	1
sGfxObject_focusY	rs.w	1
sGfxObject_radius	rs.w	1
sGfxObject_mass		rs.w	1

sGfxObject_sizeOf	so

stone1Gfx	
		dc.l	stone1Pls,stone1PlsMask	;48x49
		dc.w	48,49
		dc.w	25,24,14,220
		cnop	0,4
		
stone2Gfx	dc.l	stone2Pls,stone2PlsMask ;48x43
		dc.w	48,43
		dc.w	24,23,12,161
		cnop	0,4
		
stone3Gfx	dc.l	stone3Pls,stone3PlsMask ;32x31
		dc.w	32,31
		dc.w	20,18,10,78
		cnop	0,4
		
stone4Gfx	dc.l	stone4Pls,stone4PlsMask ;16x26
		dc.w	16,26
		dc.w	8,14,7,23
		cnop	0,4
		
stone5Gfx	dc.l	stone5Pls,stone5PlsMask ;16x19
		dc.w	16,19
		dc.w	11,11,7,17
		cnop	0,4
		
stone6Gfx	dc.l	stone6Pls,stone6PlsMask	;16x12
		dc.w	16,12
		dc.w	6,7,5,8
		
		
	cnop	0,4

sndSfxCollision
	dc.l	sndCollision
	dc.w	(1778+2)/2
	dc.w	222
	dc.w	32
	dc.b	-1
	dc.b	1

	cnop	0,4
	
sndSfxInfo	
	dc.l	sndInfo
	dc.w	(1218+2)/2
	dc.w	850
	dc.w	44
	dc.b	-1
	dc.b	1

	cnop	0,4


sndSfxExplo
	dc.l	sndExplo
	dc.w	(9464+2)/2
	dc.w	850
	dc.w	44
	dc.b	-1
	dc.b	1

	cnop	0,4
	
	;Hiscore related
	
hicoreFileName	dc.b	"hiscore",0
		cnop	0,4
	
HISCORE_NAME_LENGTH	equ	8	
	
	rsreset
hiScore_min_sec	rs.w	1	;BCD!
hiScore_name	rs.b	(HISCORE_NAME_LENGTH+1)
hiScore_info	rs.b	1	
hiScoreObject_sizeOf	so

HISCORE_LENGTH	equ	8

hiscoreList	dc.l	hiscoreDefault+(hiScoreObject_sizeOf*0)
		dc.l	hiscoreDefault+(hiScoreObject_sizeOf*1)
		dc.l	hiscoreDefault+(hiScoreObject_sizeOf*2)
		dc.l	hiscoreDefault+(hiScoreObject_sizeOf*3)
		dc.l	hiscoreDefault+(hiScoreObject_sizeOf*4)
		dc.l	hiscoreDefault+(hiScoreObject_sizeOf*5)
		dc.l	hiscoreDefault+(hiScoreObject_sizeOf*6)
		dc.l	hiscoreDefault+(hiScoreObject_sizeOf*7)
hiscoreLast	dc.l	hiscoreDefault+(hiScoreObject_sizeOf*8) ;new entry



hiscoreDefault

		          ;01234567
	dc.b	2,3*16+9 ,"ARES    ",0,0	;R.I.P.
	dc.b	1,5*16+1 ,"MARTEN  ",0,0
	dc.b	1,4*16+8 ,"BUB     ",0,0
	dc.b	1,3*16+3 ,"UNKER   ",0,0
	dc.b	1,1*16+9 ,"NUTHATCH",0,0
	dc.b	1,0*16+7 ,"FOX     ",0,0
	dc.b	0,4*16+2 ,"NOMOT   ",0,0
	dc.b	0,2*16+7 ,"STONE   ",0,0
	dc.b	0,0*16+0 ,"        ",0,0  ;new entry
	
	
	cnop	0,4

	;Color luts

colorLogoLut
		dc.l	$00000000,(logoColorsA+2)+(0*4)
		dc.l	$00404040,(logoColorsA+2)+(1*4)
		dc.l	$00806050,(logoColorsA+2)+(2*4)
		dc.l	$00303030,(logoColorsA+2)+(3*4)
		dc.l	$00f00000,(logoColorsA+2)+(4*4)
		dc.l	$00202020,(logoColorsA+2)+(5*4)
		dc.l	$00803000,(logoColorsA+2)+(6*4)
		dc.l	$0000f000,(logoColorsA+2)+(7*4)
		dc.l	$000080f0,(logoColorsA+2)+(8*4)
		dc.l	$00800000,(logoColorsA+2)+(9*4)
		dc.l	$0070a0e0,(logoColorsA+2)+(10*4)
		dc.l	$000040b0,(logoColorsA+2)+(11*4)
		dc.l	$00f0b010,(logoColorsA+2)+(12*4)
		dc.l	$00e04010,(logoColorsA+2)+(13*4)
		dc.l	$00403060,(logoColorsA+2)+(14*4)
		dc.l	$00500030,(logoColorsA+2)+(15*4)
		dc.l	$00808080,(logoColorsA+2)+(16*4)
		dc.l	$00707070,(logoColorsA+2)+(17*4)
		dc.l	$00f07000,(logoColorsA+2)+(18*4)
		dc.l	$00c0a090,(logoColorsA+2)+(19*4)
		dc.l	$00505050,(logoColorsA+2)+(20*4)
		dc.l	$00303030,(logoColorsA+2)+(21*4)
logoColorShipEg	dc.l	$00f0f0f0,(logoColorsA+2)+(22*4)		;ship toggle color
		dc.l	$00700000,(logoCopColor6+6)+(0*16)
		dc.l	$00800000,(logoCopColor6+6)+(1*16)
		dc.l	$00900000,(logoCopColor6+6)+(2*16)
		dc.l	$00a00000,(logoCopColor6+6)+(3*16)
		dc.l	$00b00000,(logoCopColor6+6)+(4*16)
		dc.l	$00c00000,(logoCopColor6+6)+(5*16)
		dc.l	$00d00000,(logoCopColor6+6)+(6*16)
		dc.l	$00e00000,(logoCopColor6+6)+(7*16)
		dc.l	$00f00000,(logoCopColor6+6)+(8*16)
		dc.l	$00e00000,(logoCopColor6+6)+(9*16)
		dc.l	$00d00000,(logoCopColor6+6)+(10*16)
		dc.l	$00c00000,(logoCopColor6+6)+(11*16)
		dc.l	$00b00000,(logoCopColor6+6)+(12*16)
		dc.l	$00a00000,(logoCopColor6+6)+(13*16)
		dc.l	$00900000,(logoCopColor6+6)+(14*16)
		dc.l	$00800000,(logoCopColor6+6)+(15*16)
		dc.l	$00704000,(logoCopColor6+14)+(0*16)
		dc.l	$00805000,(logoCopColor6+14)+(1*16)
		dc.l	$00906000,(logoCopColor6+14)+(2*16)
		dc.l	$00a07000,(logoCopColor6+14)+(3*16)
		dc.l	$00b08000,(logoCopColor6+14)+(4*16)
		dc.l	$00c09000,(logoCopColor6+14)+(5*16)
		dc.l	$00d0a000,(logoCopColor6+14)+(6*16)
		dc.l	$00e0b000,(logoCopColor6+14)+(7*16)
		dc.l	$00f0c000,(logoCopColor6+14)+(8*16)
		dc.l	$00e0b000,(logoCopColor6+14)+(9*16)
		dc.l	$00d0a000,(logoCopColor6+14)+(10*16)
		dc.l	$00c09000,(logoCopColor6+14)+(11*16)
		dc.l	$00b08000,(logoCopColor6+14)+(12*16)
		dc.l	$00a07000,(logoCopColor6+14)+(13*16)
		dc.l	$00906000,(logoCopColor6+14)+(14*16)
		dc.l	$00805000,(logoCopColor6+14)+(15*16)
		dc.l	$00705000,(logoCopColor2+6)+(0*8)
		dc.l	$00806000,(logoCopColor2+6)+(1*8)
		dc.l	$00906000,(logoCopColor2+6)+(2*8)
		dc.l	$00a06000,(logoCopColor2+6)+(3*8)
		dc.l	$00b06000,(logoCopColor2+6)+(4*8)
		dc.l	$00c06000,(logoCopColor2+6)+(5*8)
		dc.l	$00d06000,(logoCopColor2+6)+(6*8)
		dc.l	$00e06000,(logoCopColor2+6)+(7*8)
		dc.l	$00f06000,(logoCopColor2+6)+(8*8)
		dc.l	$00e06000,(logoCopColor2+6)+(9*8)
		dc.l	$00f06000,(logoCopColor2+6)+(10*8)
		dc.l	$00f0f050,(logoColorsB+2)
colorLogoLutEnd	dc.l	0,0 ;adr = 0 -> end

gameLogoLut
		dc.l	$00000000,(gameColors+2)+(0*4)
		dc.l	$00404040,(gameColors+2)+(1*4)
		dc.l	$00806050,(gameColors+2)+(2*4)
		dc.l	$00303030,(gameColors+2)+(3*4)
		dc.l	$00f0f000,(gameColors+2)+(4*4)
		dc.l	$0000f000,(gameColors+2)+(5*4)
		dc.l	$000080f0,(gameColors+2)+(6*4)
		dc.l	$00800000,(gameColors+2)+(7*4)
		dc.l	$0070a0e0,(gameColors+2)+(8*4)
		dc.l	$000040b0,(gameColors+2)+(9*4)
		dc.l	$00f0b010,(gameColors+2)+(10*4)
		dc.l	$00e04010,(gameColors+2)+(11*4)
		dc.l	$00403060,(gameColors+2)+(12*4)
		dc.l	$00500030,(gameColors+2)+(13*4)
		dc.l	$00808080,(gameColors+2)+(14*4)
		dc.l	$00707070,(gameColors+2)+(15*4)
		dc.l	$00f07000,(gameColors+2)+(16*4)
		dc.l	$00c0a090,(gameColors+2)+(17*4)
		dc.l	$00505050,(gameColors+2)+(18*4)
		dc.l	$00303030,(gameColors+2)+(19*4)
gameColorShipEg	dc.l	$00f0f0f0,(gameColors+2)+(20*4)	;ship toggle color	
		dc.l	$00b0b000,(gameCopColor+6)+(0*8)
		dc.l	$00c0c000,(gameCopColor+6)+(1*8)
		dc.l	$00d0d000,(gameCopColor+6)+(2*8)
		dc.l	$00e0e000,(gameCopColor+6)+(3*8)
		dc.l	$00d0d000,(gameCopColor+6)+(4*8)
		dc.l	$00c0c000,(gameCopColor+6)+(5*8)
		dc.l	$00b0b000,(gameCopColor+6)+(6*8)
		dc.l	$0000b000,(gameCopColor+6)+(7*8)
		dc.l	$0000c000,(gameCopColor+6)+(8*8)
		dc.l	$0000d000,(gameCopColor+6)+(9*8)
		dc.l	$0000e000,(gameCopColor+6)+(10*8)
		dc.l	$0000d000,(gameCopColor+6)+(11*8)
		dc.l	$0000c000,(gameCopColor+6)+(12*8)
		dc.l	$0000b000,(gameCopColor+6)+(13*8)
		dc.l	$00f03030,(gameCopColor2+6)+(0*8)	
gameLogoLutEnd	dc.l	0,0 ;adr = 0 -> end

	cnop	0,4

	SECTION	":CD",DATA_C

	cnop	0,8

IHSTART 	equ $81
IHSTOP 	 	equ $c1
IVSTART	 	equ $34 ;$2c
IVSTOP  	equ IVSTART+SCREEN_HEIGHT ;($12c)
IDDFSTART 	equ $39 ;((HSTART/2)-8.5)
IDDFSTOP	equ $d0 ;DDFSTART+(8*(SCREEN_WIDTH/16-1))

;
;               Odd		Even
; DP BPL usage 	Pf1(C0-C7)	Pf2(C8-C15)
;	1	1		-
;	2	1		2
;      	3	1,3		2			;BG Pf1, Text Pf2
; 	4	1,3		2,4			;BG Pf1, Logo Pf2
; 	5	1,3,5		2,4			
; 	6	1,3,5		2,4,6
;

;************************************************
;*	
;* copperListLogo
;*
;************************************************

copperListLogo 

		dc.w	$008e,IHSTART+(IVSTART<<8)	;DIWSTRT V/H
		dc.w	$0090,IHSTOP+((IVSTOP&$ff)<<8)  ;DIWSTOP V/H
	
		dc.w	$0092,IDDFSTART			;DDFSTRT  HSTART / 2 - 8.5
		dc.w	$0094,IDDFSTOP			;DDFSTOP  DDFSTRT + (8 * (Width / 16 - 1))

		;
	
		dc.w	$0100,$4400	;BPLCON0  4 Bpl, dual playfield
		dc.w	$0102,$0000	;BPLCON1
		dc.w	$0104,$0052	;BPLCON2  playfield 2 prio over 1 (PF1P2 -> SP01 SP23 PF SP45 SP6) (PF2P2 -> SP01 SP23 PF SP45 SP6 )
		dc.w	$0106,$0c00	;BPLCON3  aga dpl fix		
		dc.w	$0108,(BG_VSCREEN_WIDTH*2-SCREEN_WIDTH)/8*(BG_BITPLANES-1)	;BPLMOD 1 bg interleaved (even)
		dc.w	$010a,(FG_LOGO_VSCREEN_WIDTH)/8*(FG_LOGO_BITPLANES-1)		;BPLMOD 2 fg logo	 (odd)
	
logoSpr0	dc.w	$0120,$0000,$0122,$0000			;sprpth,sprptl 0
logoSpr1	dc.w	$0124,$0000,$0126,$0000			;sprpth,sprptl 1
logoSpr2	dc.w	$0128,$0000,$012a,$0000			;sprpth,sprptl 2
logoSpr3	dc.w	$012c,$0000,$012e,$0000			;sprpth,sprptl 3	
logoSpr4	dc.w	$0130,$0000,$0132,$0000			;sprpth,sprptl 4
logoSpr5	dc.w	$0134,$0000,$0136,$0000			;sprpth,sprptl 5
logoSpr6	dc.w	$0138,$0000,$013a,$0000			;sprpth,sprptl 6
logoSpr7	dc.w	$013c,$0000,$013e,$0000			;sprpth,sprptl 7

logoBgCopPl	dc.w	$00e0,$0000	;pl 1
		dc.w	$00e2,$0000
		dc.w	$00e8,$0000	;pl 3
		dc.w	$00ea,$0000
	
logoFgCopPl	dc.w	$00e4,$0000	;pl 2
		dc.w	$00e6,$0000
		dc.w	$00ec,$0000	;pl 4
		dc.w	$00ee,$0000		

		
		
logoColorsA	dc.w	$0180,$0000	;C00  colors bg (pf1)
		dc.w	$0182,$0444	;C01
		dc.w	$0184,$0865	;C02
		dc.w	$0186,$0333	;C03
					;C04-C08 not used

		dc.w	$0192,$0f00	;C09 colors logo (pf2)
		dc.w	$0194,$0222	;C10
		dc.w	$0196,$0830	;C11
					;C12-C15 not used
			
		dc.w 	$01a0,$00f0	;C16 (0) ;spr color	
		dc.w 	$01a2,$008f	;C17 (1)
		dc.w 	$01a4,$0800	;C18 (2)
		dc.w 	$01a6,$07ae	;C19 (3)		
		dc.w 	$01a8,$004b	;C20 (4)	
		dc.w 	$01aa,$0fb1	;C21 (5)
		dc.w 	$01ac,$0e41	;C22 (6)
		dc.w 	$01ae,$0436	;C23 (7)

		dc.w 	$01b0,$0503	;C24 (8)  unused by stars ;stars 	
		dc.w 	$01b2,$0888	;C25 (9)
		dc.w 	$01b4,$0777	;C26 (10) 
		dc.w 	$01b6,$0f70	;C27 (11) unused by stars
		dc.w 	$01b8,$0ca9	;C28 (12) unused by stars	
		dc.w 	$01ba,$0555	;C29 (13)
		dc.w 	$01bc,$0333	;C30 (14)
		dc.w 	$01be,$0fff	;C31 (15) unused by stars, ship fire
	
logoCopColor6	dc.w	((IVSTART+31)<<8)|$1,$fffe,$0196,$0700,((IVSTART+31)<<8)|$13,$fffe,$0196,$0740	 ;0
		dc.w	((IVSTART+32)<<8)|$1,$fffe,$0196,$0800,((IVSTART+32)<<8)|$13,$fffe,$0196,$0850   ;1
		dc.w	((IVSTART+33)<<8)|$1,$fffe,$0196,$0900,((IVSTART+33)<<8)|$13,$fffe,$0196,$0960   ;2
		dc.w	((IVSTART+34)<<8)|$1,$fffe,$0196,$0a00,((IVSTART+34)<<8)|$13,$fffe,$0196,$0a70   ;3
		dc.w	((IVSTART+35)<<8)|$1,$fffe,$0196,$0b00,((IVSTART+35)<<8)|$13,$fffe,$0196,$0b80   ;4
		dc.w	((IVSTART+36)<<8)|$1,$fffe,$0196,$0c00,((IVSTART+36)<<8)|$13,$fffe,$0196,$0c90   ;5
		dc.w	((IVSTART+37)<<8)|$1,$fffe,$0196,$0d00,((IVSTART+37)<<8)|$13,$fffe,$0196,$0da0   ;6
		dc.w	((IVSTART+38)<<8)|$1,$fffe,$0196,$0e00,((IVSTART+38)<<8)|$13,$fffe,$0196,$0eb0   ;7
		dc.w	((IVSTART+39)<<8)|$1,$fffe,$0196,$0f00,((IVSTART+39)<<8)|$13,$fffe,$0196,$0fc0   ;8
		dc.w	((IVSTART+40)<<8)|$1,$fffe,$0196,$0e00,((IVSTART+40)<<8)|$13,$fffe,$0196,$0eb0   ;9
		dc.w	((IVSTART+41)<<8)|$1,$fffe,$0196,$0d00,((IVSTART+41)<<8)|$13,$fffe,$0196,$0da0   ;10
		dc.w	((IVSTART+42)<<8)|$1,$fffe,$0196,$0c00,((IVSTART+42)<<8)|$13,$fffe,$0196,$0c90   ;11
		dc.w	((IVSTART+43)<<8)|$1,$fffe,$0196,$0b00,((IVSTART+43)<<8)|$13,$fffe,$0196,$0b80   ;12
		dc.w	((IVSTART+44)<<8)|$1,$fffe,$0196,$0a00,((IVSTART+44)<<8)|$13,$fffe,$0196,$0a70   ;13
		dc.w	((IVSTART+45)<<8)|$1,$fffe,$0196,$0900,((IVSTART+45)<<8)|$13,$fffe,$0196,$0960   ;14
		dc.w	((IVSTART+46)<<8)|$1,$fffe,$0196,$0800,((IVSTART+46)<<8)|$13,$fffe,$0196,$0850   ;15
	
logoCopColor2	dc.w	((IVSTART+55)<<8)|$1,$fffe,$0192,$0700  ;0
		dc.w	((IVSTART+56)<<8)|$1,$fffe,$0192,$0800  ;1
		dc.w	((IVSTART+57)<<8)|$1,$fffe,$0192,$0900  ;2
		dc.w	((IVSTART+58)<<8)|$1,$fffe,$0192,$0a00  ;3
		dc.w	((IVSTART+59)<<8)|$1,$fffe,$0192,$0b00  ;4
		dc.w	((IVSTART+60)<<8)|$1,$fffe,$0192,$0c00  ;5
		dc.w	((IVSTART+61)<<8)|$1,$fffe,$0192,$0d00  ;6
		dc.w	((IVSTART+62)<<8)|$1,$fffe,$0192,$0e00  ;7
		dc.w	((IVSTART+63)<<8)|$1,$fffe,$0192,$0f00  ;8
		dc.w	((IVSTART+64)<<8)|$1,$fffe,$0192,$0e00  ;9
		dc.w	((IVSTART+65)<<8)|$1,$fffe,$0192,$0f00  ;10
	
	
		dc.w	((IVSTART+FG_LOGO_VSCREEN_HEIGHT-1)<<8)|$fd,$fffe
		
		;text starts here

		dc.w	$010a,$0000
		dc.w	$0100,$3400	;BPLCON0  3 Bpl, dual playfield
	
logoFgTextCopPl	dc.w	$00e4,$0000	;pl 2
		dc.w	$00e6,$0000
		
		;colors fg (pf2)
		
logoColorsB	dc.w	$0192,$0ff0
		
		;end
		
		dc.w	$ffff,$fffe
		
;
;               Odd		Even
; DP BPL usage 	Pf1(C0-C7)	Pf2(C8-C15)
;	1	1		-
;	2	1		2
;      	3	1,3		2			;BG Pf1, Status Pf2
; 	4	1,3		2,4			
; 	5	1,3,5		2,4			
; 	6	1,3,5		2,4,6
;		
		
;************************************************
;*	
;* copperListGame
;*
;************************************************
		
copperListGame

		dc.w	$008e,IHSTART+(IVSTART<<8)	;DIWSTRT V/H
		dc.w	$0090,IHSTOP+((IVSTOP&$ff)<<8)  ;DIWSTOP V/H
	
		dc.w	$0092,IDDFSTART			;DDFSTRT  HSTART / 2 - 8.5
		dc.w	$0094,IDDFSTOP			;DDFSTOP  DDFSTRT + (8 * (Width / 16 - 1))

		;
	
		dc.w	$0100,$3400	;BPLCON0  3 Bpl, dual playfield
		dc.w	$0102,$0000	;BPLCON1
		dc.w	$0104,$0052	;BPLCON2  playfield 2 prio over 1 (PF1P2 -> SP01 SP23 PF SP45 SP6) (PF2P2 -> SP01 SP23 PF SP45 SP6 )
		dc.w	$0106,$0c00	;BPLCON3  aga dpl fix	
		dc.w	$0108,(BG_VSCREEN_WIDTH*2-SCREEN_WIDTH)/8*(BG_BITPLANES-1)	;BPLMOD 1 bg interleaved (even)
		dc.w	$010a,0								;BPLMOD 2 
		dc.w	$0098,$3104;3140	;CLXCON Spr 0..3 Bpl 1 & 3 MVBP 1 & 3
	
gameSpr0	dc.w	$0120,$0000,$0122,$0000			;sprpth,sprptl 0	ship
gameSpr1	dc.w	$0124,$0000,$0126,$0000			;sprpth,sprptl 1	ship
gameSpr2	dc.w	$0128,$0000,$012a,$0000			;sprpth,sprptl 2	ship
gameSpr3	dc.w	$012c,$0000,$012e,$0000			;sprpth,sprptl 3	ship	
gameSpr4	dc.w	$0130,$0000,$0132,$0000			;sprpth,sprptl 4	stars 1
gameSpr5	dc.w	$0134,$0000,$0136,$0000			;sprpth,sprptl 5	stars 2
gameSpr6	dc.w	$0138,$0000,$013a,$0000			;sprpth,sprptl 6	stars 3
gameSpr7	dc.w	$013c,$0000,$013e,$0000			;sprpth,sprptl 7	stars 4

gameBgCopPl	dc.w	$00e0,$0000	;pl 1
		dc.w	$00e2,$0000
		dc.w	$00e8,$0000	;pl 3
		dc.w	$00ea,$0000
	
gameFgCopPl	dc.w	$00e4,$0000	;pl 2
		dc.w	$00e6,$0000
		
		
gameColors	dc.w	$0180,$0000	;C00  colors bg (pf1)
		dc.w	$0182,$0444	;C01
		dc.w	$0184,$0865	;C02
		dc.w	$0186,$0333	;C03
					;C04-C08 not used

		dc.w	$0192,$0ff0	;C09 colors fg (pf2)
					;C10-C15 not used
			
		dc.w 	$01a0,$00f0	;C16 (0) ;spr color	
		dc.w 	$01a2,$008f	;C17 (1)
		dc.w 	$01a4,$0800	;C18 (2)
		dc.w 	$01a6,$07ae	;C19 (3)		
		dc.w 	$01a8,$004b	;C20 (4)	
		dc.w 	$01aa,$0fb1	;C21 (5)
		dc.w 	$01ac,$0e41	;C22 (6)
		dc.w 	$01ae,$0436	;C23 (7)

		dc.w 	$01b0,$0503	;C24 (8)  unused by stars ;stars 	
		dc.w 	$01b2,$0888	;C25 (9)
		dc.w 	$01b4,$0777	;C26 (10) 
		dc.w 	$01b6,$0f70	;C27 (11) unused by stars
		dc.w 	$01b8,$0ca9	;C28 (12) unused by stars	
		dc.w 	$01ba,$0555	;C29 (13)
		dc.w 	$01bc,$0333	;C30 (14)
		dc.w 	$01be,$0fff	;C31 (15) unused by stars, ship fire

		;end
		
gameCopColor	dc.w	((IVSTART+0)<<8)|$1,$fffe,$0192,$0bb0  ;0
		dc.w	((IVSTART+1)<<8)|$1,$fffe,$0192,$0cc0  ;1
		dc.w	((IVSTART+2)<<8)|$1,$fffe,$0192,$0dd0  ;2
		dc.w	((IVSTART+3)<<8)|$1,$fffe,$0192,$0ee0  ;3
		dc.w	((IVSTART+4)<<8)|$1,$fffe,$0192,$0dd0  ;4
		dc.w	((IVSTART+5)<<8)|$1,$fffe,$0192,$0cc0  ;5
		dc.w	((IVSTART+6)<<8)|$1,$fffe,$0192,$0bb0  ;6
		
		dc.w	((IVSTART+8)<<8)|$1,$fffe,$0192,$00b0  ;7
		dc.w	((IVSTART+9)<<8)|$1,$fffe,$0192,$00c0  ;8
		dc.w	((IVSTART+10)<<8)|$1,$fffe,$0192,$00d0  ;9
		dc.w	((IVSTART+11)<<8)|$1,$fffe,$0192,$00e0  ;10
		dc.w	((IVSTART+12)<<8)|$1,$fffe,$0192,$00d0  ;11
		dc.w	((IVSTART+13)<<8)|$1,$fffe,$0192,$00c0  ;12
		dc.w	((IVSTART+14)<<8)|$1,$fffe,$0192,$00b0  ;13
		
gameCopColor2	dc.w	((IVSTART+15)<<8)|$1,$fffe,$0192,$0f00  ;		
		
		dc.w	$ffff,$fffe
		
	SECTION	":B",BSS_C
      
	cnop	0,8
	
	;planes bg (double buffered)

bgPlData	ds.l	(BG_VSCREEN_WIDTH*(BG_VSCREEN_HEIGHT+1))/32*BG_BITPLANES	;+1 line

	cnop	0,8

bgPlData2	ds.l	(BG_VSCREEN_WIDTH*(BG_VSCREEN_HEIGHT+1))/32*BG_BITPLANES	;+1 line

	cnop	0,8

fgPlane		ds.l	(FG_TEXT_VSCREEN_WIDTH*(FG_TEXT_VSCREEN_HEIGHT))/32*FG_TEXT_BITPLANES

	;starfield sprites and x buffers

star0SprDataEven	ds.l	(SCREEN_HEIGHT/2)*2 + 2
star0SprDataOdd		ds.l	(SCREEN_HEIGHT/2)*2 + 2
star1SprDataEven	ds.l	(SCREEN_HEIGHT/2)*2 + 2
star1SprDataOdd		ds.l	(SCREEN_HEIGHT/2)*2 + 2
star2SprDataEven	ds.l	(SCREEN_HEIGHT/2)*2 + 2
star2SprDataOdd		ds.l	(SCREEN_HEIGHT/2)*2 + 2
star3SprDataEven	ds.l	(SCREEN_HEIGHT/2)*2 + 2
star3SprDataOdd		ds.l	(SCREEN_HEIGHT/2)*2 + 2
	
starArray1	ds.w	256*2	
starArray2	ds.w	256*2
starArray3	ds.w	256*2
starArray4	ds.w	256*2	

	SECTION	":CD2",DATA_C
	
	cnop	0,4

stone1Pls	incbin  "gfx/stone1_48x49.raw"
stone1PlsMask	incbin  "gfx/stone1_48x49_msk.raw"

stone2Pls	incbin  "gfx/stone2_48x43.raw"
stone2PlsMask	incbin  "gfx/stone2_48x43_msk.raw"

stone3Pls	incbin  "gfx/stone3_32x31.raw"
stone3PlsMask	incbin  "gfx/stone3_32x31_msk.raw"

stone4Pls	incbin  "gfx/stone4_16x26.raw"
stone4PlsMask	incbin  "gfx/stone4_16x26_msk.raw"

stone5Pls	incbin  "gfx/stone5_16x19.raw"
stone5PlsMask	incbin  "gfx/stone5_16x19_msk.raw"

stone6Pls	incbin  "gfx/stone6_16x12.raw"
stone6PlsMask	incbin  "gfx/stone6_16x12_msk.raw"

font1		incbin  "gfx/font2_472x8_1.raw"

shipSprites	incbin	"gfx/sp_sprite_1.raw"
		incbin	"gfx/sp_sprite_2.raw"
		incbin	"gfx/sp_sprite_3.raw"
		incbin	"gfx/sp_sprite_4.raw"
		incbin	"gfx/sp_sprite_5.raw"
		incbin	"gfx/sp_sprite_6.raw"
		incbin	"gfx/sp_sprite_7.raw"
		incbin	"gfx/sp_sprite_8.raw"
		incbin	"gfx/sp_sprite_9.raw"
		incbin	"gfx/sp_sprite_ex1.raw"
		incbin	"gfx/sp_sprite_ex2.raw"
		incbin	"gfx/sp_sprite_ex3.raw"
		
shipSpritesL	incbin	"gfx/sp_sprite_r.raw"		
shipSpritesR	incbin	"gfx/sp_sprite_l.raw"
		

	cnop	0,8
	
logo	incbin	"gfx/LOGO_320_72_4C_interleaved.raw"	
	cnop	0,4
	
logoMod	incbin	"sfx/logo.mod"	
	cnop	0,4	
		
sndCollision	

	dc.w	0,0		;repeat start/length
	incbin	"sfx/collision.raw"
	cnop	0,4
	
sndInfo	dc.w	0,0		;repeat start/length
	incbin	"sfx/info.raw"
	
sndExplo
	dc.w	0,0		;repeat start/length
	incbin	"sfx/expl.raw"
	
	END

