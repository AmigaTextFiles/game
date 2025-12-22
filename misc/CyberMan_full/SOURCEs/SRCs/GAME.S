*******************************************************************************
*                                   CYBER-MAN                                 *
*                      Copyright (c) 1993 by Fabio Bizzetti                   *
*                              All rights reserved.                           *
*                                                                             *
* NO PART OF THIS SOURCE (AND ANY SOURCE/DATA/GRAPHIC/SOUND OF CYBER MAN) CAN *
*   BE REPRODUCED,COPIED,STORED IN A RETRIEVAL SYSTEM,OR TRANSMITTED IN ANY   *
*      FORM WITHOUT THE PRIOR WRITTEN PERMISSION OF THE COPYRIGHT HOLDER.     *
*******************************************************************************
; 
; CYBERMAN ---(GAME ROUTINE)---
;

;	BSR.W	SAVE_SYSTEM	;SOLO IN CASO DI ASMONE!!!
CYBERMAN:
;	BRA.W	ASMONE_SETUP	;SOLO IN CASO DI ASMONE!!!

	MOVE.B	#$FF,$BFD100	;SPEGNE IL MOTORE
	MOVE.B	#$F7,$BFD100
	MOVE.W	#10,BPROF(A0)	;max distance of view
	CLR.B	WIRE(A0)	;enable filled tubes
	BRA.W	ACTION_SETUP	;SOLO IN CASO DI ACTION REPLAY!!!
********************************
MAIN:
	MOVE.W	#$7FFF,$9A(A6)	;DISABLE INTERRUPTs
	MOVE.W	#$00FF,$96(A6)	;DISABLE COPPER,BLITTER,SPRITEs & AUDIO DMA

	BSR.W	DRAW		;SET UP DRAW

	MOVE.W	#$8300,$96(A6)
	MOVE.W	#$0000,$104(A6)	;bplcon2 -->playfield priority
	BSR.W	CYBER_MAN_screen
	TST.W	D0
	BEQ.B	PLAY

	BSR.W	ENEMY_screen
	TST.W	D0
	BEQ.B	PLAY

	BSR.W	BONUS_screen
	TST.W	D0
	BEQ.B	PLAY

	BRA.B	MAIN
********************************
PLAY:
	MOVE.W	#$0200,$100(A6)	;BLACK SCREEN
	MOVE.W	#$0000,$180(A6)
	MOVE.L	PAGE_0(A0),A1
	MOVE.W	#24575,D0
.clear	CLR.L	(A1)+
	DBRA	D0,.clear

	ST.B	RADAR(A0)
	ST.B	HUD(A0)
	CLR.W	CHEAT_E(A0)
	CLR.W	CHEAT_L(A0)
	CLR.B	CHEATED(A0)
	CLR.B	WELL_DONE_CNT(A0)
	CLR.L	0.W

	BSR.W	WAITVBL50

	CLR.B	AUD1_PRI(A0)
	MOVE.L	EMPTY_PT(A0),A5
	ADD.L	#1024,A5		;sicuramente 1024 bytes a zero
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,$A0(A6)		;aud0pt
	MOVE.W	#512,$A4(A6)		;aud0len
	MOVE.W	#128,$A6(A6)		;aud0per
	MOVE.L	A5,$C0(A6)		;aud2pt
	MOVE.W	#512,$C4(A6)		;aud2len
	MOVE.W	#128,$C6(A6)		;aud2per
	MOVE.L	A5,$D0(A6)		;aud3pt
	MOVE.W	#512,$D4(A6)		;aud3len
	MOVE.W	#128,$D6(A6)		;aud3per
	MOVE.W	#$87FD,$96(A6)		;DMACON

	BSR.W	INT+$4		;SET UP INT
	BSR.W	DRAW		;SET UP DRAW

	MOVE.W	#$87E0,$96(A6)	;DMACON
	MOVE.W	#$7FFF,$9C(A6)	;INTREQ
	MOVE.W	#$0680,$9C(A6)
	MOVE.W	#$C6A8,$9A(A6)	;enable VBLANK
	MOVE.W	#$4200,$100(A6)	;
********************************
GAME:

	BSR.B	VARs_COPY
	BSR.B	AUDIO_GHOST
	BSR.W	DRAW+4		;DRAW scenario

	TST.B	ENDGAME(A0)
	BNE.W	END_GAME
	TST.B	GAMEOVER(A0)
	BNE.W	GAME_OVER

	BRA.B	GAME		;SOLO IN CASO DI ACTION REPLAY!!!
********************************


;	BTST.B	#2,$16(A6)	;SOLO IN CASO DI ASMONE!!!
;	BNE.B	GAME		;
;Exit	BRA.W	RESTORE_SYSTEM	;
****************************************************************************
; VARs_COPY                                                   16 Apr 1993
;

VARs_COPY:
	MOVE.W	INT_ALPHA(A0),ALPHA(A0)
	MOVE.W	INT_VX(A0),VX(A0)
	MOVE.W	INT_VY(A0),VY(A0)
	MOVE.W	INT_H(A0),H(A0)
	TST.B	GHOSTSEE(A0)
	BEQ.B	.exit
	LEA	ENEMYes(A0),A1
	LEA	RG_STRUCT(A0),A2
	MOVE.W	LEVEL(A0),D0
	BEQ.B	.exit
	SUBQ.W	#1,D0
	LSL.W	#7,D0		;128 bytes per LEVEL
	ADD.W	D0,A1
	MOVEQ	#4,D1
.loop	MOVE.W	GVX(A1),RGVX(A2)
	MOVE.W	GVY(A1),RGVY(A2)
	MOVE.B	GALPHA(A1),RGALPHA(A2)
	MOVE.B	GBAD(A1),RGBAD(A2)
	MOVE.B	GFACE(A1),RGFACE(A2)
	MOVE.B	GCONTROL(A1),RGCTRL(A2)
	ADD.W	#16,A1
	ADD.W	#8,A2
	DBRA	D1,.loop
.exit
	RTS
; END of VARs_COPY routines
****************************************************************************
; AUDIO_GHOST                                                 20 Apr 1993
;

AUDIO_GHOST:
	LEA	ENEMYes(A0),A1
	MOVE.W	LEVEL(A0),D0
	BNE.B	.0
	MOVEQ	#-1,D6		;force also AUD3BACK
	BRA.W	AUD2BACK
.0	SUBQ.W	#1,D0
	LSL.W	#7,D0		;128 bytes per LEVEL
	ADD.W	D0,A1
	MOVEQ	#-1,D5		;MIN1
	MOVEQ	#-1,D6		;MIN2

	MOVEQ	#4,D7
.loop	MOVE.W	GVX(A1),D0
	MOVE.W	GVY(A1),D1
	SUB.W	VX(A0),D0
	BPL.B	.1
	NEG.W	D0
.1	SUB.W	VY(A0),D1
	BPL.B	.2
	NEG.W	D1
.2	ADD.W	D1,D0		;D0=DIST (0..8191)
	CMP.W	D5,D0
	BHI.B	.3
	MOVE.W	D5,D6		;MIN2=MIN1
	MOVE.B	D3,D4
	MOVE.W	D0,D5		;MIN1=DIST
	MOVE.B	GFACE(A1),D3
	BRA.B	.4
.3	CMP.W	D6,D0
	BHI.B	.4
	MOVE.W	D0,D6		;MIN2=DIST
	MOVE.B	GFACE(A1),D4
.4	ADD.W	#16,A1
	DBRA	D7,.loop
	SUB.W	#64,D5
	BPL.B	.5
	MOVEQ	#0,D5
.5	SUB.W	#64,D6
	BPL.B	.6
	MOVEQ	#0,D6
.6
	CMP.W	#255,D5		;MIN1_DIST
	BHI.W	AUD2BACK
	MOVEQ	#64,D0
	LSR.W	#2,D5
	SUB.W	D5,D0
	AND.W	#$00FF,D3
	ADD.W	D3,D3
	MOVE.W	AUD2TAB(PC,D3.W),D3
	JMP	AUD2TAB(PC,D3.W)
AUD2TAB:
PC	set	*
	DC.W	EMPTY2-PC
	DC.W	MACK2-PC
	DC.W	JOY2-PC
	DC.W	ST2-PC
	DC.W	PITA2-PC

EMPTY2:
	MOVE.L	EMPTY_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD2_PT(A0)
	MOVE.W	EMPTY_LEN(A0),AUD2_LEN(A0)
	MOVE.W	D0,AUD2_VOL(A0)
	MOVE.W	D0,$C8(A6)
	MOVE.W	$6(A6),D0		;vhposr
	AND.W	#$00F0,D0
	ADD.W	#300,D0
	MOVE.W	D0,AUD2_PER(A0)
	BRA.W	AUD3

MACK2:
	MOVE.L	MACKINTOSH_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD2_PT(A0)
	MOVE.W	MACKINTOSH_LEN(A0),AUD2_LEN(A0)
	MOVE.W	D0,AUD2_VOL(A0)
	MOVE.W	D0,$C8(A6)
	MOVE.W	#254,AUD2_PER(A0)
	BRA.W	AUD3

JOY2:
	MOVE.L	JOYPAD_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD2_PT(A0)
	MOVE.W	JOYPAD_LEN(A0),AUD2_LEN(A0)
	MOVE.W	D0,AUD2_VOL(A0)
	MOVE.W	D0,$C8(A6)
	MOVE.W	#202,AUD2_PER(A0)
	BRA.B	AUD3

ST2:
	MOVE.L	SYNTAX_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD2_PT(A0)
	MOVE.W	SYNTAX_LEN(A0),AUD2_LEN(A0)
	MOVE.W	D0,AUD2_VOL(A0)
	MOVE.W	D0,$C8(A6)
	MOVE.W	#127,AUD2_PER(A0)
	BRA.B	AUD3

PITA2:
	MOVE.L	PITAGORAs_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD2_PT(A0)
	MOVE.W	PITAGORAs_LEN(A0),AUD2_LEN(A0)
	MOVE.W	D0,AUD2_VOL(A0)
	MOVE.W	D0,$C8(A6)
	MOVE.W	#254,AUD2_PER(A0)
	BRA.B	AUD3

AUD2BACK:
	MOVE.L	BACK_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD2_PT(A0)
	MOVE.W	BACK_LEN(A0),AUD2_LEN(A0)
	MOVE.W	#254,AUD2_PER(A0)
	MOVE.W	#64,AUD2_VOL(A0)
*******
AUD3:
	CMP.W	#255,D6		;MIN2_DIST
	BHI.W	AUD3BACK
	MOVEQ	#64,D0
	LSR.W	#2,D6
	SUB.W	D6,D0
	ADD.W	D4,D4
	AND.W	#$00FF,D4
	MOVE.W	AUD3TAB(PC,D4.W),D4
	JMP	AUD3TAB(PC,D4.W)
AUD3TAB:
PC	set	*
	DC.W	EMPTY3-PC
	DC.W	MACK3-PC
	DC.W	JOY3-PC
	DC.W	ST3-PC
	DC.W	PITA3-PC

EMPTY3:
	MOVE.L	EMPTY_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD3_PT(A0)
	MOVE.W	EMPTY_LEN(A0),AUD3_LEN(A0)
	MOVE.W	D0,AUD3_VOL(A0)
	MOVE.W	D0,$D8(A6)
	MOVE.W	$6(A6),D0		;vhposr
	AND.W	#$00F0,D0
	ADD.W	#300,D0
	MOVE.W	D0,AUD3_PER(A0)
	BRA.W	AUDIO_GHOST_EXIT

MACK3:
	MOVE.L	MACKINTOSH_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD3_PT(A0)
	MOVE.W	MACKINTOSH_LEN(A0),AUD3_LEN(A0)
	MOVE.W	D0,AUD3_VOL(A0)
	MOVE.W	D0,$D8(A6)
	MOVE.W	#254,AUD3_PER(A0)
	BRA.W	AUDIO_GHOST_EXIT

JOY3:
	MOVE.L	JOYPAD_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD3_PT(A0)
	MOVE.W	JOYPAD_LEN(A0),AUD3_LEN(A0)
	MOVE.W	D0,AUD3_VOL(A0)
	MOVE.W	D0,$D8(A6)
	MOVE.W	#202,AUD3_PER(A0)
	BRA.B	AUDIO_GHOST_EXIT

ST3:
	MOVE.L	SYNTAX_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD3_PT(A0)
	MOVE.W	SYNTAX_LEN(A0),AUD3_LEN(A0)
	MOVE.W	D0,AUD3_VOL(A0)
	MOVE.W	D0,$D8(A6)
	MOVE.W	#127,AUD3_PER(A0)
	BRA.B	AUDIO_GHOST_EXIT

PITA3:
	MOVE.L	PITAGORAs_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD3_PT(A0)
	MOVE.W	PITAGORAs_LEN(A0),AUD3_LEN(A0)
	MOVE.W	D0,AUD3_VOL(A0)
	MOVE.W	D0,$D8(A6)
	MOVE.W	#254,AUD3_PER(A0)
	BRA.B	AUDIO_GHOST_EXIT

AUD3BACK:
	MOVE.L	BACK_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD3_PT(A0)
	MOVE.W	BACK_LEN(A0),AUD3_LEN(A0)
	MOVE.W	#254,AUD3_PER(A0)
	MOVE.W	#64,AUD3_VOL(A0)
*******	
AUDIO_GHOST_EXIT:
	RTS
; END of AUDIO_GHOST routines
****************************************************************************
; INT_KEY                                                     20 Apr 1993
;

INT_KEY:
	MOVEM.L	D0/A5,-(SP)
	LEA.L	$BFE000,A5
	BTST.B	#3,$1f(A6)	;INTREQ KEYBOARD TEST
	BEQ.W	.exit		;no request

	MOVEQ	#$00,D0
	MOVE.B	$c01(A5),D0
	BSET	#6,$e01(A5)

	MOVE.B	#$3C,$BFD400	;wait 85 usec
	MOVE.B	#0,$BFD500
	MOVE.B	#$51,$BFDE00
	BTST.B	#0,$BFDD00
.wi	BTST.B	#0,$BFDD00
	BEQ.B	.wi

	BCLR	#6,$e01(A5)

	CMP.B	#$77,D0		;if RETURN key pressed
	BNE.B	.1
	NOT.B	WIRE(A0)	;toggle WIRE tubes
	BRA.W	.exit

.1	CMP.B	#$67,D0		;if CURS UP key pressed
	BNE.B	.2
	ADDQ.W	#1,BPROF(A0)	;increase BPROF
	CMP.W	#14,BPROF(A0)
	BCS.W	.exit
	MOVE.W	#14,BPROF(A0)
	BRA.W	.exit

.2	CMP.B	#$65,D0		;if CURS DW key pressed
	BNE.B	.3
	SUBQ.W	#1,BPROF(A0)	;decrease BPROF
	CMP.W	#1,BPROF(A0)
	BCC.W	.exit
	MOVE.W	#1,BPROF(A0)
	BRA.W	.exit

.3	CMP.B	#$7F,D0		;if SPACE key pressed Then PAUSE
	BNE.B	.4
	BTST.B	#5,$1d(A6)	;VBLANK interrupt enable TEST
	BEQ.B	.e		;branch if disabled
	ST.B	AUDPAUSE(A0)
	MOVE.W	#$0020,$9A(A6)	;disable VBLANK
	MOVE.W	#0,$A8(A6)	;clear AUD vol 0
	MOVE.W	#0,$B8(A6)	;clear AUD vol 1
	MOVE.W	#0,$C8(A6)	;clear AUD vol 2
	MOVE.W	#0,$D8(A6)	;clear AUD vol 3
	MOVE.W	#$000C,$96(A6)	;AUD23 DMA OFF
	CLR.W	CHEAT_E(A0)
	CLR.W	CHEAT_L(A0)
	BRA.B	.exit
.e	CLR.B	AUDPAUSE(A0)
	CLR.W	CHEAT_E(A0)
	CLR.W	CHEAT_L(A0)
	MOVE.W	#$8600,$9C(A6)
	MOVE.W	#$C620,$9A(A6)	;enable VBLANK
	BRA.B	.exit

.4	CMP.B	#$75,D0		;if ESC key pressed
	BNE.B	.5
	ST.B	GAMEOVER(A0)	;GAME OVER
	BRA.B	.exit

.5	CMP.B	#$41,D0		;if HELP key pressed
	BNE.B	.6
	ADD.W	#10,CHEAT_E(A0)	;CHEAT MODE energy
	BRA.B	.exit

.6	CMP.B	#$73,D0		;if DEL key pressed
	BNE.B	.7
	ADD.W	#10,CHEAT_L(A0)	;CHEAT MODE level
	BRA.B	.exit

.7	CMP.B	#$57,D0		;if F5 key pressed
	BNE.B	.8
	MOVE.W	#$4200,$100(A6)	;NO INTERLACE
	BRA.B	.exit

.8	CMP.B	#$55,D0		;if F6 key pressed
	BNE.B	.exit
	MOVE.W	#$4204,$100(A6)	;INTERLACE

.exit	TST.B	$BFED01		;clear CIAA interrupt
	MOVE.W	#$0008,$9c(A6)	;INTREQ KEYBOARD CLEAR
	MOVEM.L	(SP)+,D0/A5
	RTE
; END of INT_KEY routine
****************************************************************************
; INT_AUDIO                                                   20 Apr 1993
;

INT_AUDIO:
	MOVEM.L	D0-D7/A0-A5,-(SP)
	TST.B	AUDPAUSE(A0)
	BEQ.B	.ok
	MOVE.W	#$0680,$9C(A6)	;clear requests
	MOVE.W	#$0680,$9A(A6)	;clear ints
	CLR.B	AUDPAUSE(A0)
	BRA.W	.noreq3
.ok	BTST.B	#0,$1e(A6)	;INTREQ AUDIO 1 test
	BEQ.B	.noreq1
	MOVE.L	EMPTY_PT(A0),A5	;2 bytes sicuramente a 0
	ADD.L	#2000,A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,$B0(A6)	;AUDIO 1 OFF
	MOVE.W	#1,$B4(A6)
	CMP.B	#1,AUD1_PRI(A0)
	BHI.B	.pri
	MOVE.W	#$0100,$9A(A6)	;DISABLE INT
.pri	SUBQ.B	#1,AUD1_PRI(A0)
	BPL.B	.over
	CLR.B	AUD1_PRI(A0)
.over	MOVE.W	#$0100,$9c(A6)	;INTREQ AUDIO 1 clear

.noreq1	BTST.B	#7,$1f(A6)	;INTREQ AUDIO 0 test
	BEQ.B	.noreq0
	MOVE.W	#$0001,$96(A6)	;DMA 0 OFF
	BSR.W	W300
	MOVE.L	AUD0_PT(A0),$A0(A6)	;AUD0PT
	MOVE.W	AUD0_LEN(A0),$A4(A6)	;AUD0LEN
	MOVE.W	AUD0_PER(A0),$A6(A6)	;AUD0PER
	MOVE.W	#$0080,$9C(A6)		;clear INT 0
	MOVE.W	#$8201,$96(A6)		;START DMA 0
	BSR.W	W300
	MOVE.W	#$0080,$9C(A6)		;clear INT 0

.noreq0	BTST.B	#1,$1e(A6)	;INTREQ AUDIO 2 test
	BEQ.B	.noreq2
	MOVE.W	#$0004,$96(A6)	;DMA 2 OFF
	BSR.B	W300
	MOVE.L	AUD2_PT(A0),$C0(A6)	;AUD2PT
	MOVE.W	AUD2_LEN(A0),$C4(A6)	;AUD2LEN
	MOVE.W	AUD2_PER(A0),$C6(A6)	;AUD2PER
	MOVE.W	AUD2_VOL(A0),$C8(A6)	;AUD2VOL
	MOVE.W	#$0200,$9C(A6)		;clear INT 2
	MOVE.W	#$8204,$96(A6)		;START DMA 2
	BSR.B	W300
	MOVE.W	#$0200,$9C(A6)		;clear INT 2

.noreq2	BTST.B	#2,$1e(A6)	;INTREQ AUDIO 3 test
	BEQ.B	.noreq3
	MOVE.W	#$0008,$96(A6)	;DMA 3 OFF
	BSR.B	W300
	MOVE.L	AUD3_PT(A0),$D0(A6)	;AUD3PT
	MOVE.W	AUD3_LEN(A0),$D4(A6)	;AUD3LEN
	MOVE.W	AUD3_PER(A0),$D6(A6)	;AUD3PER
	MOVE.W	AUD3_VOL(A0),$D8(A6)	;AUD3VOL
	MOVE.W	#$0400,$9C(A6)		;clear INT 3
	MOVE.W	#$8208,$96(A6)		;START DMA 3
	BSR.B	W300
	MOVE.W	#$0400,$9C(A6)		;clear INT 3

.noreq3	MOVEM.L	(SP)+,D0-D7/A0-A5
	RTE

W300	MOVE.B	#$D7,$BFD400	;wait 300 usec
	MOVE.B	#0,$BFD500
	MOVE.B	#$51,$BFDE00
	BTST.B	#0,$BFDD00
.wi	BTST.B	#0,$BFDD00
	BEQ.B	.wi
	RTS

; END of INT_AUDIO routines
****************************************************************************
; GAME_OVER                                                   24 Apr 1993
;

GAME_OVER:
	CLR.B	WELL_DONE_CNT(A0)
	MOVE.W	#$FFFF,ENERGY(A0)
	CMP.W	#64,H(A0)
	BEQ.B	.ok
	BRA.W	GAME
.ok	MOVE.W	#$4000,$9A(A6)	;DISABLE INTERRUPTs
	MOVE.W	#$002F,$96(A6)	;DISABLE SPRITEs & AUDIO DMA

	LEA.L	INT_ext(PC),A1
	MOVE.L	A1,$6C.W
	MOVE.W	$9A(A6),temp
	MOVE.W	#$7FFF,$9A(A6)
	MOVE.W	#$C020,$9A(A6)

	BSR.W	WAITVBL50

	MOVE.L	Copper_LIST_0(A0),A1
	MOVE.L	#$FFFFFFFE,$64(A1)
	MOVE.L	Copper_LIST_1(A0),A1
	MOVE.L	#$FFFFFFFE,$64(A1)
	CLR.B	BACKGROUND(A0)

	CLR.B	HUD(A0)
	MOVE.B	#0,3.W
.ciclo	CMP.W	#255,H(A0)
	BHI.B	.exit
	MOVE.W	H(A0),D0
	BSR.W	PALETTE
	BSR.W	DRAW+4
	MOVE.B	3.W,D0		;TOD VSync 50 Hertz
	MOVE.B	#0,3.W
	AND.W	#$00FF,D0
	ADD.W	D0,H(A0)
	BRA.B	.ciclo
.exit	MOVE.W	#$0200,$100(A6)
	MOVE.W	#$00FF,$96(A6)

	MOVE.W	#$7FFF,$9A(A6)
	MOVE.W	temp,D0
	AND.W	#$3FFF,D0
	OR.W	#$8000,D0
	MOVE.W	D0,$9A(A6)
	LEA.L	INT(PC),A1
	MOVE.L	A1,$6C.W

	MOVEQ	#0,D0
	MOVE.W	#15,D1
.loop1	MOVE.W	D0,$180(A6)
	MOVE.W	#$0020,$9c(A6)	;clear VB bit
.waitv1	BTST.B	#5,$1f(A6)	;test VB bit
	BEQ.B	.waitv1
	ADD.W	#$0111,D0
	DBRA	D1,.loop1

	MOVE.W	#$0FFF,D0
	MOVE.W	#15,D1
.loop2	MOVE.W	D0,$180(A6)
	MOVE.W	#$0020,$9c(A6)	;clear VB bit
.waitv2	BTST.B	#5,$1f(A6)	;test VB bit
	BEQ.B	.waitv2
	SUB.W	#$0111,D0
	DBRA	D1,.loop2

	CLR.B	GAMEOVER(A0)
	ST.B	HUD(A0)

	MOVE.L	Copper_LIST_0(A0),A1
	MOVE.L	#$0180006F,$64(A1)
	MOVE.L	Copper_LIST_1(A0),A1
	MOVE.L	#$0180006F,$64(A1)

	BRA.W	MAIN

temp	DC.W	0

; END of GAME_OVER routine
****************************************************************************
; END_GAME                                                    16 Sep 1993
;

END_GAME:
	CLR.B	GAMEOVER(A0)
	MOVE.W	#$FFFF,ENERGY(A0)
	CLR.B	WELL_DONE_CNT(A0)
	CMP.W	#64,H(A0)
	BEQ.B	.ok
	BRA.W	GAME
.ok	MOVE.W	#$4000,$9A(A6)	;DISABLE INTERRUPTs
	MOVE.W	#$002F,$96(A6)	;DISABLE SPRITEs & AUDIO DMA

	LEA.L	INT_ext(PC),A1
	MOVE.L	A1,$6C.W
	MOVE.W	$9A(A6),temp
	MOVE.W	#$7FFF,$9A(A6)
	MOVE.W	#$C020,$9A(A6)

	BSR.W	WAITVBL50

	MOVE.L	Copper_LIST_0(A0),A1
	MOVE.L	#$FFFFFFFE,$64(A1)
	MOVE.L	Copper_LIST_1(A0),A1
	MOVE.L	#$FFFFFFFE,$64(A1)
	CLR.B	BACKGROUND(A0)

	MOVE.L	AUDIO_PT(A0),A1
	ADD.L	ANGEL_PT(A0),A1
	MOVE.L	A1,$A0(A6)	;aud0pt
	MOVE.L	A1,$B0(A6)	;aud1pt
	MOVE.L	A1,$C0(A6)	;aud2pt
	MOVE.L	A1,$D0(A6)	;aud3pt
	MOVE.W	ANGEL_LEN(A0),D0
	MOVE.W	D0,$A4(A6)	;aud0len
	MOVE.W	D0,$B4(A6)	;aud1len
	MOVE.W	D0,$C4(A6)	;aud2len
	MOVE.W	D0,$D4(A6)	;aud3len
	MOVE.W	#64,$A8(A6)	;aud0vol
	MOVE.W	#64,$B8(A6)	;aud1vol
	MOVE.W	#64,$C8(A6)	;aud2vol
	MOVE.W	#64,$D8(A6)	;aud3vol

	MOVE.W	#315,$A6(A6)	;aud0per
	MOVE.W	#630,$B6(A6)	;aud1per
	MOVE.W	#945,$C6(A6)	;aud2per
	MOVE.W	#1260,$D6(A6)	;aud3per

	MOVE.W	#$820F,$96(A6)	;ENABLE AUDIO DMA

	CLR.B	HUD(A0)
	MOVE.B	#0,3.W
.ciclo	CMP.W	#255,H(A0)
	BHI.B	.exit
	MOVE.W	H(A0),D0
	BSR.W	PALETTE

	MOVEQ	#0,D1
	MOVE.W	#379,D0
	SUB.W	H(A0),D0
	MOVE.W	D0,$A6(A6)	;aud0per
	ADD.W	D0,D1
	ADD.W	D0,D1
	MOVE.W	D1,$B6(A6)	;aud1per
	ADD.W	D0,D1
	MOVE.W	D1,$C6(A6)	;aud2per
	ADD.W	D0,D1
	MOVE.W	D1,$D6(A6)	;aud3per

	BSR.W	DRAW+4
	MOVE.B	3.W,D0		;TOD VSync 50 Hertz
	MOVE.B	#0,3.W
	AND.W	#$00FF,D0
	ADD.W	D0,H(A0)
	BRA.B	.ciclo
.exit	CLR.B	GAMEOVER(A0)
	ST.B	HUD(A0)

	MOVE.W	#$7FFF,$9A(A6)
	MOVE.W	temp,D0
	AND.W	#$3FFF,D0
	OR.W	#$8000,D0
	MOVE.W	D0,$9A(A6)
	LEA.L	INT(PC),A1
	MOVE.L	A1,$6C.W

	MOVE.L	Copper_LIST_0(A0),A1
	MOVE.L	#$0180006F,$64(A1)
	MOVE.L	Copper_LIST_1(A0),A1
	MOVE.L	#$0180006F,$64(A1)


	TST.B	CHEATED(A0)
	BNE.B	.hi3
	MOVE.L	BEST_time(A0),D0
	CMP.L	VB(A0),D0
	BLT.B	.hi1
	MOVE.L	VB(A0),BEST_time(A0)
.hi1	MOVE.L	BEST_score(A0),D0
	CMP.L	SCORE(A0),D0
	BGT.B	.hi2
	MOVE.L	SCORE(A0),BEST_score(A0)
.hi2	MOVE.L	SCORE(A0),D0
	MOVE.L	VB(A0),D1
	DIVU.W	#50,D1
	DIVU.W	D1,D0
	AND.L	#$0000FFFF,D0
	CMP.L	BEST_sctm(A0),D0
	BLT.B	.hi3
	MOVE.L	D0,BEST_sctm(A0)
.hi3	CLR.B	CHEATED(A0)

	MOVE.W	#$0200,$100(A6)	;BLACK SCREEN
	MOVE.W	#$4000,$9A(A6)	;DISABLE INTERRUPTs
	MOVE.W	#$00F0,$96(A6)	;DISABLE COPPER,BLITTER,SPRITEs & AUDIO DMA

	MOVE.L	END_GAME_scr(A0),A1
	MOVE.L	PAGE_0(A0),A2
	MOVE.W	#18431,D0
.copy	MOVE.L	(A1)+,(A2)+
	DBRA	D0,.copy

	MOVE.L	PAGE_0(A0),A1
	MOVEQ	#0,D7		;timer

	MOVE.W	#$1e71,$8e(A6)	;diwstrt
	MOVE.W	#$35d1,$90(A6)	;diwstop
	MOVE.W	#$0000,$180(A6)	;color00
	MOVE.W	#$0f00,$182(A6)	;color01
	MOVE.W	#$0222,$184(A6)	;color02
	MOVE.W	#$00f0,$186(A6)	;color03
	MOVE.W	#$0444,$188(A6)	;color04
	MOVE.W	#$000f,$18a(A6)	;color05
	MOVE.W	#$0666,$18c(A6)	;color06
	MOVE.W	#$0777,$18e(A6)	;color07
	MOVE.W	#$0888,$190(A6)	;color08
	MOVE.W	#$0999,$192(A6)	;color09
	MOVE.W	#$00ff,$194(A6)	;color10
	MOVE.W	#$0bbb,$196(A6)	;color11
	MOVE.W	#$0ff0,$198(A6)	;color12
	MOVE.W	#$0ddd,$19a(A6)	;color13
	MOVE.W	#$0f0f,$19c(A6)	;color14
	MOVE.W	#$0fff,$19e(A6)	;color15

.lp	MOVE.W	#$0020,$9c(A6)	;clear VB bit
.wb	BTST.B	#5,$1f(A6)	;test VB bit
	BEQ.B	.wb

	MOVE.L	A1,$e0(A6)	;bpl0pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$e4(A6)	;bpl1pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$e8(A6)	;bpl2pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$ec(A6)	;bpl3pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$f0(A6)	;bpl4pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$f4(A6)	;bpl5pt
	SUB.L	#$F000,A1

	MOVE.W	#$6A00,$100(A6)	;

	MOVEQ	#1,D0		;uP Flag Zero=0
	BTST.B	#7,$BFE001
	BNE.B	.over
.pull	MOVE.W	#$0200,$100(A6)	;
	BTST.B	#7,$BFE001
	BEQ.B	.pull
	MOVEQ	#0,D0
	BRA.W	.flash

.over	ADDQ.W	#1,D7
	CMP.W	#1500,D7	;MAX = 30 sec
	BNE.B	.lp

.flash	MOVE.W	#$0200,$100(A6)
	MOVE.W	#$00FF,$96(A6)

	MOVEQ	#0,D0
	MOVE.W	#15,D1
.loop1	MOVE.W	D0,$180(A6)
	MOVE.W	#$0020,$9c(A6)	;clear VB bit
.waitv1	BTST.B	#5,$1f(A6)	;test VB bit
	BEQ.B	.waitv1
	ADD.W	#$0111,D0
	DBRA	D1,.loop1

	MOVE.W	#$0FFF,D0
	MOVE.W	#15,D1
.loop2	MOVE.W	D0,$180(A6)
	MOVE.W	#$0020,$9c(A6)	;clear VB bit
.waitv2	BTST.B	#5,$1f(A6)	;test VB bit
	BEQ.B	.waitv2
	SUB.W	#$0111,D0
	DBRA	D1,.loop2

	BRA.W	MAIN

; END of END_GAME routine
****************************************************************************
; PALETTE                                                     18 Sep 1993
;
; D0=64..255

PALETTE:
	SUB.W	#64,D0
	AND.W	#$00F0,D0	; D0 = 0..11
	ADD.W	D0,D0
	MOVE.L	COLORTABLE(A0),A1
	ADD.W	D0,A1		;A1 = TABLE
	MOVE.L	A6,A2
	ADD.L	#$180,A2	;A2 = color00
	MOVE.W	#15,D0

.loop	MOVE.W	(A1)+,(A2)+
	DBRA	D0,.loop

	RTS

; END of PALETTE routine
****************************************************************************
; CYBER_MAN_screen                                            15 Sep 1993
;

CYBER_MAN_screen:
	MOVE.W	#$0200,$100(A6)	;BLACK SCREEN
	MOVE.W	#$0000,$180(A6)
	BSR.W	WAITVBL15

	MOVE.L	CYBER_MAN_scr(A0),A1
	MOVE.L	PAGE_0(A0),A2
	MOVE.W	#15359,D0
.copy	MOVE.L	(A1)+,(A2)+
	DBRA	D0,.copy
********************************
	MOVE.L	PAGE_0(A0),A1
	MOVEQ	#3,D1		;COLOR

	ADD.W	#$2E42,A1
	MOVE.L	#$FFFF,D7
	MOVE.L	BEST_score(A0),D0
	CMP.L	#999900,D0
	BLS.B	.ok
	MOVE.L	#999900,D0
.ok	DIVS.W	#100,D0
	MOVEQ	#0,D6	
	AND.L	D7,D0
	DIVS.W	#10000,D0
	BEQ.B	.1
	MOVEQ	#-1,D6
.1	BSR.W	DRAW_NUMBER
	SWAP	D0
	AND.L	D7,D0
	DIVS.W	#1000,D0
	BEQ.B	.2
	MOVEQ	#-1,D6
.2	BSR.W	DRAW_NUMBER
	SWAP	D0
	AND.L	D7,D0
	DIVS.W	#100,D0
	BEQ.B	.3
	MOVEQ	#-1,D6
.3	BSR.W	DRAW_NUMBER
	SWAP	D0
	AND.L	D7,D0
	DIVS.W	#10,D0
	BEQ.B	.4
	MOVEQ	#-1,D6
.4	BSR.W	DRAW_NUMBER
	SWAP	D0
	AND.L	D7,D0
	BEQ.B	.5
	MOVEQ	#-1,D6
.5	BSR.W	DRAW_NUMBER
	MOVEQ	#0,D0
	BSR.W	DRAW_NUMBER
	MOVEQ	#0,D0
	BSR.W	DRAW_NUMBER
********************************
	MOVE.L	PAGE_0(A0),A1
	MOVEQ	#3,D1		;COLOR

	ADD.W	#$2E63,A1
	MOVE.L	#$FFFF,D7
	MOVE.L	BEST_time(A0),D0
	CMP.L	#499999,D0
	BHI.B	.sctm
	DIVS.W	#50,D0
	AND.L	D7,D0
	MOVEQ	#0,D6	
	DIVS.W	#1000,D0
	BEQ.B	.1b
	MOVEQ	#-1,D6
.1b	BSR.W	DRAW_NUMBER
	SWAP	D0
	AND.L	D7,D0
	DIVS.W	#100,D0
	BEQ.B	.2b
	MOVEQ	#-1,D6
.2b	BSR.W	DRAW_NUMBER
	SWAP	D0
	AND.L	D7,D0
	DIVS.W	#10,D0
	BEQ.B	.3b
	MOVEQ	#-1,D6
.3b	BSR.W	DRAW_NUMBER
	SWAP	D0
	AND.L	D7,D0
	MOVEQ	#-1,D6
	BSR.W	DRAW_NUMBER
********************************
.sctm	MOVE.L	PAGE_0(A0),A1
	MOVEQ	#3,D1		;COLOR

	ADD.W	#$2E52,A1
	MOVE.L	#$FFFF,D7
	MOVE.L	BEST_sctm(A0),D0
	BEQ.B	.screen
	CMP.L	#9999,D0
	BLS.B	.sc1
	MOVE.L	#9999,D0
.sc1	MOVEQ	#0,D6	
	DIVS.W	#1000,D0
	BEQ.B	.1c
	MOVEQ	#-1,D6
.1c	BSR.W	DRAW_NUMBER
	SWAP	D0
	AND.L	D7,D0
	DIVS.W	#100,D0
	BEQ.B	.2c
	MOVEQ	#-1,D6
.2c	BSR.W	DRAW_NUMBER
	SWAP	D0
	AND.L	D7,D0
	DIVS.W	#10,D0
	BEQ.B	.3c
	MOVEQ	#-1,D6
.3c	BSR.W	DRAW_NUMBER
	SWAP	D0
	AND.L	D7,D0
	MOVEQ	#-1,D6
	BSR.W	DRAW_NUMBER
********************************
.screen	MOVE.L	PAGE_0(A0),A1
	MOVEQ	#0,D7		;timer

	MOVE.W	#$1e71,$8e(A6)	;diwstrt
	MOVE.W	#$35d1,$90(A6)	;diwstop
	MOVE.W	#$0000,$180(A6)	;color00
	MOVE.W	#$0aaa,$182(A6)	;color01
	MOVE.W	#$0888,$184(A6)	;color02
	MOVE.W	#$0ddd,$186(A6)	;color03
	MOVE.W	#$0fb0,$188(A6)	;color04
	MOVE.W	#$0b00,$18a(A6)	;color05
	MOVE.W	#$0c00,$18c(A6)	;color06
	MOVE.W	#$0d00,$18e(A6)	;color07
	MOVE.W	#$00b0,$190(A6)	;color08
	MOVE.W	#$00e0,$192(A6)	;color09
	MOVE.W	#$0a08,$194(A6)	;color10
	MOVE.W	#$0d0a,$196(A6)	;color11
	MOVE.W	#$00c0,$198(A6)	;color12
	MOVE.W	#$000b,$19a(A6)	;color13
	MOVE.W	#$000d,$19c(A6)	;color14
	MOVE.W	#$000f,$19e(A6)	;color15
	MOVE.W	#$0f60,$1a0(A6)	;color16
	MOVE.W	#$0555,$1a2(A6)	;color17
	MOVE.W	#$0666,$1a4(A6)	;color18
	MOVE.W	#$0777,$1a6(A6)	;color19
	MOVE.W	#$0500,$1a8(A6)	;color20
	MOVE.W	#$0600,$1aa(A6)	;color21
	MOVE.W	#$0700,$1ac(A6)	;color22
	MOVE.W	#$0800,$1ae(A6)	;color23
	MOVE.W	#$0040,$1b0(A6)	;color24
	MOVE.W	#$0060,$1b2(A6)	;color25
	MOVE.W	#$0504,$1b4(A6)	;color26
	MOVE.W	#$0605,$1b6(A6)	;color27
	MOVE.W	#$0050,$1b8(A6)	;color28
	MOVE.W	#$0006,$1ba(A6)	;color29
	MOVE.W	#$0007,$1bc(A6)	;color30
	MOVE.W	#$0008,$1be(A6)	;color31

.loop	MOVE.W	#$0020,$9c(A6)	;clear VB bit
.waitvb	BTST.B	#5,$1f(A6)	;test VB bit
	BEQ.B	.waitvb

	MOVE.L	A1,$e0(A6)	;bpl0pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$e4(A6)	;bpl1pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$e8(A6)	;bpl2pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$ec(A6)	;bpl3pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$f0(A6)	;bpl4pt
	SUB.L	#$C000,A1

	MOVE.W	#$5200,$100(A6)	;

	MOVEQ	#1,D0		;uP Flag Zero=0
	BTST.B	#7,$BFE001
	BNE.B	.over
.pull	MOVE.W	#$0200,$100(A6)	;
	BTST.B	#7,$BFE001
	BEQ.B	.pull
	MOVEQ	#0,D0
	RTS

.over	ADDQ.W	#1,D7
	CMP.W	#750,D7		;MAX = 15 sec
	BNE.B	.loop
	RTS

; END of 'CYBER_MAN_screen' routine
;******************************************************************************
; DRAW_NUMBER routine                                         17 Sep 1993
;

DRAW_NUMBER:
	TST.B	D6
	BEQ.B	.exit
	AND.W	#$000F,D0
	ADD.W	D0,D0
	MOVE.W	.tab(PC,D0.W),D0
	LEA	.tab(PC,D0.W),A5

	BTST	#0,D1		;PLANE 0
	JSR	(A5)

	ADD.L	#$3000,A1
	BTST	#1,D1		;PLANE 1
	JSR	(A5)

	ADD.L	#$3000,A1
	BTST	#2,D1		;PLANE 2
	JSR	(A5)

	ADD.L	#$3000,A1
	BTST	#3,D1		;PLANE 3
	JSR	(A5)

	ADD.L	#$3000,A1
	BTST	#4,D1		;PLANE 4
	JSR	(A5)

	SUB.L	#$C000,A1
	ADDQ.W	#1,A1		;CURS RIGHT
.exit	RTS
.tab
PC	set	*
	DC.W	DRAW0-PC
	DC.W	DRAW1-PC
	DC.W	DRAW2-PC
	DC.W	DRAW3-PC
	DC.W	DRAW4-PC
	DC.W	DRAW5-PC
	DC.W	DRAW6-PC
	DC.W	DRAW7-PC
	DC.W	DRAW8-PC
	DC.W	DRAW9-PC

DRAW0:	BNE.B	.or
	AND.B	#$83,(A1)
	AND.B	#$bb,$2c(A1)
	AND.B	#$bb,$58(A1)
	AND.B	#$bb,$84(A1)
	AND.B	#$9b,$b0(A1)
	AND.B	#$9b,$dc(A1)
	AND.B	#$83,$108(A1)
	RTS
.or	OR.B	#$7c,(A1)
	OR.B	#$44,$2c(A1)
	OR.B	#$44,$58(A1)
	OR.B	#$44,$84(A1)
	OR.B	#$64,$b0(A1)
	OR.B	#$64,$dc(A1)
	OR.B	#$7c,$108(A1)
	RTS

DRAW1:	BNE.B	.or
	AND.B	#$8f,(A1)
	AND.B	#$ef,$2c(A1)
	AND.B	#$ef,$58(A1)
	AND.B	#$ef,$84(A1)
	AND.B	#$ef,$b0(A1)
	AND.B	#$ef,$dc(A1)
	AND.B	#$83,$108(A1)
	RTS
.or	OR.B	#$70,(A1)
	OR.B	#$10,$2c(A1)
	OR.B	#$10,$58(A1)
	OR.B	#$10,$84(A1)
	OR.B	#$10,$b0(A1)
	OR.B	#$10,$dc(A1)
	OR.B	#$7c,$108(A1)
	RTS

DRAW2:	BNE.B	.or
	AND.B	#$81,(A1)
	AND.B	#$fd,$2c(A1)
	AND.B	#$fd,$58(A1)
	AND.B	#$81,$84(A1)
	AND.B	#$9f,$b0(A1)
	AND.B	#$9f,$dc(A1)
	AND.B	#$81,$108(A1)
	RTS
.or	OR.B	#$7e,(A1)
	OR.B	#$02,$2c(A1)
	OR.B	#$02,$58(A1)
	OR.B	#$7e,$84(A1)
	OR.B	#$60,$b0(A1)
	OR.B	#$60,$dc(A1)
	OR.B	#$7e,$108(A1)
	RTS

DRAW3:	BNE.B	.or
	AND.B	#$83,(A1)
	AND.B	#$fb,$2c(A1)
	AND.B	#$fb,$58(A1)
	AND.B	#$83,$84(A1)
	AND.B	#$f3,$b0(A1)
	AND.B	#$f3,$dc(A1)
	AND.B	#$83,$108(A1)
	RTS
.or	OR.B	#$7c,(A1)
	OR.B	#$04,$2c(A1)
	OR.B	#$04,$58(A1)
	OR.B	#$7c,$84(A1)
	OR.B	#$0c,$b0(A1)
	OR.B	#$0c,$dc(A1)
	OR.B	#$7c,$108(A1)
	RTS

DRAW4:	BNE.B	.or
	AND.B	#$bb,(A1)
	AND.B	#$bb,$2c(A1)
	AND.B	#$bb,$58(A1)
	AND.B	#$bb,$84(A1)
	AND.B	#$81,$b0(A1)
	AND.B	#$f3,$dc(A1)
	AND.B	#$f3,$108(A1)
	RTS
.or	OR.B	#$44,(A1)
	OR.B	#$44,$2c(A1)
	OR.B	#$44,$58(A1)
	OR.B	#$44,$84(A1)
	OR.B	#$7e,$b0(A1)
	OR.B	#$0c,$dc(A1)
	OR.B	#$0c,$108(A1)
	RTS

DRAW5:	BNE.B	.or
	AND.B	#$83,(A1)
	AND.B	#$bf,$2c(A1)
	AND.B	#$bf,$58(A1)
	AND.B	#$83,$84(A1)
	AND.B	#$f3,$b0(A1)
	AND.B	#$f3,$dc(A1)
	AND.B	#$83,$108(A1)
	RTS
.or	OR.B	#$7c,(A1)
	OR.B	#$40,$2c(A1)
	OR.B	#$40,$58(A1)
	OR.B	#$7c,$84(A1)
	OR.B	#$0c,$b0(A1)
	OR.B	#$4c,$dc(A1)
	OR.B	#$7c,$108(A1)
	RTS

DRAW6:	BNE.B	.or
	AND.B	#$83,(A1)
	AND.B	#$bb,$2c(A1)
	AND.B	#$bf,$58(A1)
	AND.B	#$83,$84(A1)
	AND.B	#$9b,$b0(A1)
	AND.B	#$9b,$dc(A1)
	AND.B	#$83,$108(A1)
	RTS
.or	OR.B	#$7c,(A1)
	OR.B	#$44,$2c(A1)
	OR.B	#$40,$58(A1)
	OR.B	#$7c,$84(A1)
	OR.B	#$64,$b0(A1)
	OR.B	#$64,$dc(A1)
	OR.B	#$7c,$108(A1)
	RTS

DRAW7:	BNE.B	.or
	AND.B	#$83,(A1)
	AND.B	#$bb,$2c(A1)
	AND.B	#$f7,$58(A1)
	AND.B	#$ef,$84(A1)
	AND.B	#$cf,$b0(A1)
	AND.B	#$cf,$dc(A1)
	AND.B	#$cf,$108(A1)
	RTS
.or	OR.B	#$7c,(A1)
	OR.B	#$44,$2c(A1)
	OR.B	#$08,$58(A1)
	OR.B	#$10,$84(A1)
	OR.B	#$30,$b0(A1)
	OR.B	#$30,$dc(A1)
	OR.B	#$30,$108(A1)
	RTS

DRAW8:	BNE.B	.or
	AND.B	#$83,(A1)
	AND.B	#$bb,$2c(A1)
	AND.B	#$bb,$58(A1)
	AND.B	#$83,$84(A1)
	AND.B	#$9b,$b0(A1)
	AND.B	#$9b,$dc(A1)
	AND.B	#$83,$108(A1)
	RTS
.or	OR.B	#$7c,(A1)
	OR.B	#$44,$2c(A1)
	OR.B	#$44,$58(A1)
	OR.B	#$7c,$84(A1)
	OR.B	#$64,$b0(A1)
	OR.B	#$64,$dc(A1)
	OR.B	#$7c,$108(A1)
	RTS

DRAW9:	BNE.B	.or
	AND.B	#$83,(A1)
	AND.B	#$bb,$2c(A1)
	AND.B	#$bb,$58(A1)
	AND.B	#$83,$84(A1)
	AND.B	#$f3,$b0(A1)
	AND.B	#$b3,$dc(A1)
	AND.B	#$83,$108(A1)
	RTS
.or	OR.B	#$7c,(A1)
	OR.B	#$44,$2c(A1)
	OR.B	#$44,$58(A1)
	OR.B	#$7c,$84(A1)
	OR.B	#$0c,$b0(A1)
	OR.B	#$4c,$dc(A1)
	OR.B	#$7c,$108(A1)
	RTS

; END of DRAW_NUMBER routine
;******************************************************************************
; ENEMY_screen                                                15 Sep 1993
;

ENEMY_screen:
	MOVE.W	#$0200,$100(A6)	;BLACK SCREEN
	MOVE.W	#$0000,$180(A6)
	BSR.W	WAITVBL15

	MOVE.L	ENEMY_scr(A0),A1
	MOVE.L	PAGE_0(A0),A2
	MOVE.W	#12287,D0
.copy	MOVE.L	(A1)+,(A2)+
	DBRA	D0,.copy

	MOVE.L	PAGE_0(A0),A1
	MOVEQ	#0,D7		;timer

	MOVE.W	#$1e71,$8e(A6)	;diwstrt
	MOVE.W	#$35d1,$90(A6)	;diwstop
	MOVE.W	#$0000,$180(A6)	;color00
	MOVE.W	#$0aaa,$182(A6)	;color01
	MOVE.W	#$000f,$184(A6)	;color02
	MOVE.W	#$000b,$186(A6)	;color03
	MOVE.W	#$088a,$188(A6)	;color04
	MOVE.W	#$0ff0,$18a(A6)	;color05
	MOVE.W	#$006f,$18c(A6)	;color06
	MOVE.W	#$0ccc,$18e(A6)	;color07
	MOVE.W	#$0c00,$190(A6)	;color08
	MOVE.W	#$0f00,$192(A6)	;color09
	MOVE.W	#$0900,$194(A6)	;color10
	MOVE.W	#$0c0a,$196(A6)	;color11
	MOVE.W	#$0e0c,$198(A6)	;color12
	MOVE.W	#$0a40,$19a(A6)	;color13
	MOVE.W	#$00f0,$19c(A6)	;color14
	MOVE.W	#$0fff,$19e(A6)	;color15

.loop	MOVE.W	#$0020,$9c(A6)	;clear VB bit
.waitvb	BTST.B	#5,$1f(A6)	;test VB bit
	BEQ.B	.waitvb

	MOVE.L	A1,$e0(A6)	;bpl0pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$e4(A6)	;bpl1pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$e8(A6)	;bpl2pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$ec(A6)	;bpl3pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$f0(A6)	;bpl4pt
	SUB.L	#$C000,A1

	MOVE.W	#$4200,$100(A6)	;

	MOVEQ	#1,D0		;uP Flag Zero=0
	BTST.B	#7,$BFE001
	BNE.B	.over
.pull	MOVE.W	#$0200,$100(A6)	;
	BTST.B	#7,$BFE001
	BEQ.B	.pull
	MOVEQ	#0,D0
	RTS

.over	ADDQ.W	#1,D7
	CMP.W	#750,D7		;MAX = 15 sec
	BNE.B	.loop
	RTS

; END of 'ENEMY_screen' routine
****************************************************************************
; BONUS_screen                                                15 Sep 1993
;

BONUS_screen:
	MOVE.W	#$0200,$100(A6)	;BLACK SCREEN
	MOVE.W	#$0000,$180(A6)
	BSR.W	WAITVBL15

	MOVE.L	BONUS_scr(A0),A1
	MOVE.L	PAGE_0(A0),A2
	MOVE.W	#12287,D0
.copy	MOVE.L	(A1)+,(A2)+
	DBRA	D0,.copy

	MOVE.L	PAGE_0(A0),A1
	MOVEQ	#0,D7		;timer

	MOVE.W	#$1e71,$8e(A6)	;diwstrt
	MOVE.W	#$35d1,$90(A6)	;diwstop
	MOVE.W	#$0000,$180(A6)	;color00
	MOVE.W	#$0aaa,$182(A6)	;color01
	MOVE.W	#$000f,$184(A6)	;color02
	MOVE.W	#$000b,$186(A6)	;color03
	MOVE.W	#$00c0,$188(A6)	;color04
	MOVE.W	#$0ff0,$18a(A6)	;color05
	MOVE.W	#$006f,$18c(A6)	;color06
	MOVE.W	#$0ccc,$18e(A6)	;color07
	MOVE.W	#$0c00,$190(A6)	;color08
	MOVE.W	#$0f00,$192(A6)	;color09
	MOVE.W	#$0900,$194(A6)	;color10
	MOVE.W	#$0c0a,$196(A6)	;color11
	MOVE.W	#$0e0c,$198(A6)	;color12
	MOVE.W	#$0a40,$19a(A6)	;color13
	MOVE.W	#$00f0,$19c(A6)	;color14
	MOVE.W	#$0fff,$19e(A6)	;color15

.loop	MOVE.W	#$0020,$9c(A6)	;clear VB bit
.waitvb	BTST.B	#5,$1f(A6)	;test VB bit
	BEQ.B	.waitvb

	MOVE.L	A1,$e0(A6)	;bpl0pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$e4(A6)	;bpl1pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$e8(A6)	;bpl2pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$ec(A6)	;bpl3pt
	ADD.L	#$3000,A1
	MOVE.L	A1,$f0(A6)	;bpl4pt
	SUB.L	#$C000,A1

	MOVE.W	#$4200,$100(A6)	;

	MOVEQ	#1,D0		;uP Flag Zero=0
	BTST.B	#7,$BFE001
	BNE.B	.over
.pull	MOVE.W	#$0200,$100(A6)	;
	BTST.B	#7,$BFE001
	BEQ.B	.pull
	MOVEQ	#0,D0
	RTS

.over	ADDQ.W	#1,D7
	CMP.W	#750,D7		;MAX = 15 sec
	BNE.B	.loop
	RTS

; END of 'BONUS_screen' routine
****************************************************************************

WAITVBL50:
	MOVEM.L	D0-D2,-(SP)
	MOVEQ	#50,D2
.Wvbl1l	MOVE.L	$DFF004,D1
	AND.L	#$0001FF00,D1
	CMP.L	#$00008000,D1
	BCS.B	.Wvbl1l
.Wvbl1	MOVE.L	$DFF004,D0
	AND.L	#$0001FF00,D0
	CMP.L	D1,D0
	BCC.B	.Wvbl1
	DBRA	D2,.Wvbl1l
	MOVEM.L	(SP)+,D0-D2
	RTS

WAITVBL15:
	MOVEM.L	D0-D2,-(SP)
	MOVEQ	#15,D2
.Wvbl1l	MOVE.L	$DFF004,D1
	AND.L	#$0001FF00,D1
	CMP.L	#$00008000,D1
	BCS.B	.Wvbl1l
.Wvbl1	MOVE.L	$DFF004,D0
	AND.L	#$0001FF00,D0
	CMP.L	D1,D0
	BCC.B	.Wvbl1
	DBRA	D2,.Wvbl1l
	MOVEM.L	(SP)+,D0-D2
	RTS

*******************************************************************************
;                             CYBER-DRAW LIBRARY              27 Mar 1993
;
;	bra.w	SET_UP		; Call SCREEN & set registers
;	bra.w	CYBER_DRAW	; All to COMPUTE/DISPLAY scenario
;
; END of CYBER-DRAW library
****************************************************************************
****************************************************************************
; DEF_TAB.asm                                                 20 Mar 1993
;
; indirizzi TABELLE usate da CYBER-MAN

BLIMIT0		= $0000		;.B (BDIST)
BLIMIT1		= $0010		;.B (BDIST)
L5		= $0090		;.B = L5 (RLINE)
L4		= $0490		;.B = L4 (RLINE)
L3		= $0890		;.B = L3 (RLINE)
L2		= $0c90		;.B = L2 (RLINE) non usato!
L1		= $1090		;.B = L1 (RLINE)
L0		= $1490		;.B = L0 (RLINE) non usato!
PX		= $1890		;.W = PX  (BRX,RLINE)
BORDER0		= $5890		;.B = Usato per ricavare BCODE / PR= 0..31
BORDER1		= $5990		;.B = Usato per ricavare BCODE / PR=32..63
WAVE_LIST	= $5a90		;.B ( wave 0,1,2,3 )
MASK_LEFT	= $5ad0		;.W = MASK_LEFT  per RECTANGLE AFWM
MASK_RIGHT	= $5af0		;.W = MASK_RIGHT per RECTANGLE ALWM

; $5b10		= VAR.asm	; vedi il FILE 'VAR.asm'
; $5e00		= VAR_INT.asm	; vedi il FILE 'VAR_INT.asm'

WHICH_LEVEL	= $6000		;.B = MAP localizzazione 4K
; $7000-$7400	= COPPER	;|||||| PER LO SVILUPPO COPPERLIST ||||||
Mul_Y		= $7400		;.W = Addr_Y*44 (Y)
OBJ_E		= $7650		; Rotate 4 Bits...
OBJ_S		= $7660		; Rotate 4 Bits...
OBJ_W		= $7670		; Rotate 4 Bits...
HIGH_SKY	= $7680		;.B = TAB(H) altezza CYBER/16 per SKY
; $7780-$7800	=  ---Empty!---	; 288 bytes ($120)
ENEMYes_BAK	= $7800		; 25/32 GHOST STRUCT SetUp
ENEMYes		= $7A80		; 25/32 GHOST STRUCT Game
JUMP_SHORT	= $7D00		; 128 bytes
JUMP_MID	= $7D80		; 256 bytes
JUMP_LONG	= $7E80		; 384 bytes
;PY		= $8000		;.W = (H,RLINE) --- H=64..255 / DIST=0..255
; END of DEF_TAB.asm
****************************************************************************
; VAR.asm                                                     18 Mar 1993
;  dichiarazione VARIABILI usate da CYBER_MAN
;   default = .W

BUFFER		= $5b10	; usato da POLYGON & da PYRAMID , 128 bytes
X0		= $5b90
X1		= $5b92
Y0		= $5b94
Y1		= $5b96
INK		= $5b98
X		= $5b90	; per OBJECT (come X0)
Y		= $5b92	; per OBJECT (come X1)
R		= $5b94	; per OBJECT (come Y0)
SCREEN_DRAW	= $5b9c	; LONG WORD!
SCREEN_SHOW	= $5ba0	; LONG WORD!
BACK_NORTH_PT	= $5ba8	; ( indirizzo sfondo NORD 4 plane )
BACK_EAST_PT	= $5bac	; ( indirizzo sfondo EST 4 plane )
BACK_SOUTH_PT	= $5bb0	; ( indirizzo sfondo SUD 4 plane )
BACK_WEST_PT	= $5bb4	; ( indirizzo sfondo OVEST 4 plane )
SHAPES		= $5bb8	; ( indirizzo base OBJECT GRAPHICs )
Copper_LIST_0	= $5bbc	; indirizzo COPPERLIST Screen=$68000
Copper_LIST_1	= $5bc0	; indirizzo COPPERLIST Screen=$74000
Copper_LIST_HAM	= $5bc4	; indirizzo COPPERLIST Schermo titoli HAM
Copper_LIST_2_3	= $5bc8	; indirizzo COPPERLIST Schermi INFO/SELECT
PAGE_0		= $5bcc	; LONG! --- $68000
PAGE_1		= $5bd0	; LONG! --- $74000
CURRENT_COPLIST	= $5bd4	; LONG! -Puntatore copperlist visualizzata-
HIDE_COPLIST	= $5bd8	; LONG! -Puntatore copperlist prossima DBF-
FILLBLIT	= $5c30	; LONG! -Puntatore FILL buffer

ALPHA		= $5bdc	;0=NORTH / 1=EAST / 2=SOUTH / 3=WEST
H		= $5bde	; ( JUMP ) - 0..31 Altezza
VX		= $5be0	; Coordinata X corrente di PAC (0..4095)
VY		= $5be2	; Coordinata Y corrente di PAC (0..4095)
;BPOSX		= $5be4
;BPOSY		= $5be6
;BX		= $5be8
;BY		= $5bea
;BLIMIT		= $5bec
;BRX		= $5bee
;BRY		= $5bf0
;RY		= $5bf2
;V0		= $5bf4
;V1		= $5bf6
;V2		= $5bf8
;V3		= $5bfa
;V4		= $5bfc
;V5		= $5bfe
;V6		= $5c00
;V7		= $5c02
;PR		= $5c04	;Posizione relativa dentro il BLOCCO
;PR_K		= $5c06
;PR_FLAG	= $5c08
BPROF		= $5c0a	;Livello BLOCCHI profondita' --( 0..14 )
;WAVS		= $5c0c	;usato da WAVE 0..3
;TYPE		= $5c0e
;OBJ		= $5c10	;WORD --- ruotato
;INFO_N0	= $5c12
;INFO_N1	= $5c14
;INFO_E0	= $5c16
;INFO_E1	= $5c18
;INFO_S0	= $5c1a
;INFO_S1	= $5c1c
;INFO_W0	= $5c1e
;INFO_W1	= $5c20
;INFO_TP	= $5c22
;INFO_BT	= $5c24
;EXT		= $5c26 ; Att! viene ruotato come gli INFO e OBJ
;AUX		= $5c28
;BCODE		= $5c2a
;LAST_ALPHA	= $5c2c	;WORD  --- usato da TURN
;OBJ2		= $5c34	;WORD --- non ruotato
WIRE		= $5c36	;BYTE --- FLAG (se=0 allora TUBI pieni,se=1 WIRE frame)
BACKGROUND	= $5c37	;BYTE --- FLAG (se=0 allora no sfondo,se=1 da FAST RAM)
GHOSTSEE	= $5c38	;BYTE --- FLAG (se=0 allora no GHOSTs,se=1 visibili)
;TURNING	= $5c39	;BYTE ---- FLAG (usato internamente)
;BLEEDING	= $5c3a	;BYTE ---- FLAG (usato internamente)
RADAR		= $5c3b	; BYTE! ---- FLAG (1=RADAR acceso)
RADAR_PT	= $5c3c	; LONG! -Puntatore dati sprite per RADAR
HUD		= $5c40	;BYTE! ---- Head Up Display visibile?
AUDPAUSE	= $5c41	;BYTE! ---- Used by KEYBOARD's PAUSE routine
CHEAT_E		= $5c42	;WORD! ---- Used by ENERGY cheat mode
CHEAT_L		= $5c44	;WORD! ---- Used by LEVEL cheat mode
CHEATED		= $5c46	;BYTE! ---- Used by ENDGAME
WELL_DONE_CNT	= $5c47	;BYTE! ----
CYBER_MAN_scr	= $5c48	;LONG! ---- Puntatore schermo 32 colori
ENEMY_scr	= $5c4c	;LONG! ---- Puntatore schermo 16 colori
BONUS_scr	= $5c50	;LONG! ---- Puntatore schermo 16 colori
END_GAME_scr	= $5c54	;LONG! ---- Puntatore schermo 4096 colori
BEST_score	= $5c58	;LONG!
BEST_time	= $5c5c	;LONG!
BEST_sctm	= $5c60	;LONG!
COLORTABLE	= $5c64	;LONG! ---- Puntatore PALETTE fade out schermo

RG_STRUCT	= $5e80
GDRAW		= $5eb0
;OFFSET rispetto a RG_STRUCT
RGVX		= 0	;WORD! =GVX
RGVY		= 2	;WORD! =GVY
RGALPHA		= 4	;BYTE! =GALPHA
RGBAD		= 5	;BYTE! =BAD
RGFACE		= 6	;BYTE! =per GHOST DRAW
RGCTRL		= 7	;BYTE! =GCONTROL

; ---- ESTERNI ----
ADDRESS_MAP	= $5ba4	;LONG WORD!   --- COMUNE A CYBER INT (!!!)
;TURNSPEED	= $5e4d	;BYTE! --- usato da TURN --- comune a CYBER INT (!!!)
PAUSE		= $5e1e	;BYTE! INPUT stop interrupt - COMUNE A CYBER INT (!!!)
GPAUSE		= $5e1f	;BYTE! INPUT stop interrupt - COMUNE A CYBER INT (!!!)

; ---- AUDIO ----
	rsset	$5d00
AUDIO_PT	rs.l	1	;LONG! Puntatore BASE Audio

WIND_PT		rs.l	1	;LONG! Puntatore indirizzo suono WIND
BACK_PT		rs.l	1	;LONG! Puntatore indirizzo suono BACK
ALARM_PT	rs.l	1	;LONG! Puntatore indirizzo suono ALARM
ANGEL_PT	rs.l	1	;LONG! Puntatore indirizzo suono ANGEL
DEVIL_PT	rs.l	1	;LONG! Puntatore indirizzo suono DEVIL
EAT_PT		rs.l	1	;LONG! Puntatore indirizzo suono EAT
BLEEDING_PT	rs.l	1	;LONG! Puntatore indirizzo suono BLEEDING
CASHING_PT	rs.l	1	;LONG! Puntatore indirizzo suono CASHING
WELCOME_PT	rs.l	1	;LONG! Puntatore indirizzo suono WELCOME
ENDLEVEL_PT	rs.l	1	;LONG! Puntatore indirizzo suono ENDLEVEL
BONUS_PT	rs.l	1	;LONG! Puntatore indirizzo suono BONUS
EMPTY_PT	rs.l	1	;LONG! Puntatore indirizzo suono EMPTY
MACKINTOSH_PT	rs.l	1	;LONG! Puntatore indirizzo suono MACKINTOSH
JOYPAD_PT	rs.l	1	;LONG! Puntatore indirizzo suono JOYPAD
SYNTAX_PT	rs.l	1	;LONG! Puntatore indirizzo suono SYNTAX
PITAGORAs_PT	rs.l	1	;LONG! Puntatore indirizzo suono PITAGORAs

WIND_LEN	rs.w	1	;LONG! Lunghezza suono WIND
BACK_LEN	rs.w	1	;LONG! Lunghezza suono BACK
ALARM_LEN	rs.w	1	;LONG! Lunghezza suono ALARM
ANGEL_LEN	rs.w	1	;LONG! Lunghezza suono ANGEL
DEVIL_LEN	rs.w	1	;LONG! Lunghezza suono DEVIL
EAT_LEN		rs.w	1	;LONG! Lunghezza suono EAT
BLEEDING_LEN	rs.w	1	;LONG! Lunghezza suono BLEEDING
CASHING_LEN	rs.w	1	;LONG! Lunghezza suono CASHING
WELCOME_LEN	rs.w	1	;LONG! Lunghezza suono WELCOME
ENDLEVEL_LEN	rs.w	1	;LONG! Lunghezza suono ENDLEVEL
BONUS_LEN	rs.w	1	;LONG! Lunghezza suono BONUS
EMPTY_LEN	rs.w	1	;LONG! Lunghezza suono EMPTY
MACKINTOSH_LEN	rs.w	1	;LONG! Lunghezza suono MACKINTOSH
JOYPAD_LEN	rs.w	1	;LONG! Lunghezza suono JOYPAD
SYNTAX_LEN	rs.w	1	;LONG! Lunghezza suono SYNTAX
PITAGORAs_LEN	rs.w	1	;LONG! Lunghezza suono PITAGORAs

AUD0_PT		rs.l	1	;LONG!
AUD0_LEN	rs.w	1	;WORD!
AUD0_PER	rs.w	1	;WORD!

AUD2_PT		rs.l	1	;LONG! CANALE GHOST 1
AUD2_LEN	rs.w	1	;WORD!
AUD2_PER	rs.w	1	;WORD!
AUD2_VOL	rs.w	1	;WORD!

AUD3_PT		rs.l	1	;LONG! CANALE GHOST 2
AUD3_LEN	rs.w	1	;WORD!
AUD3_PER	rs.w	1	;WORD!
AUD3_VOL	rs.w	1	;WORD!

AUD_FLAG	rs.b	1	;Usato in varie parti
AUD1_PRI	rs.b	1	;Priorita' sul canale 1

; END of VAR.asm
****************************************************************************
*                                                                          *
*                                                                          *
*                                                                          *
****************************************************************************
;                             CYBER-INT LIBRARY               22 Mar 1993
;
;	bra.w	INTERRUPT
;	bra.w	SET_UP		;At start of game..PILLs/GV?s/
;	bra.w	CYBER_INT	;
;	bra.w	GHOST_INT	;
;	bra.w	GAME_INT	;
;
; END of CYBER-DRAW library
****************************************************************************
****************************************************************************
; VAR_INT.asm                                                 22 Mar 1993
;  dichiarazione VARIABILI usate dall'INTERRUPT di CYBER_MAN
;   default = .W

;THISM		= $5e00	; il Joy attuale
;LASTM		= $5e02	; il Joy precedente
;M		= $5e04	; movimento attuale
;MLEFT		= $5e06	; JoyLEFT
;MRIGHT		= $5e08	; JoyRIGHT
;MDOWN		= $5e0a	; JoyDOWN
;SALTA		= $5e0c	; FLAG ..0=non salta \ 1=SHORT \ 2=MID \ 3=LONG
INT_JUMP	= $5e0e	; --- FASE DI SALTO ---
;BX		= $5e10	; blocco X dove si trova CYBER
;BY		= $5e12	;    "   Y   "   "   "     "
;PBX		= $5e14	; 0..63 posizione X dentro il blocco
;PBY		= $5e16	; 0..63     "     Y    "    "    "
INT_ALPHA	= $5e18	; 0..NORTH \ 1..EAST \ 2..SOUTH \ 3..WEST
INT_VX		= $5e1a	; coordinata assoluta X di CYBER
INT_VY		= $5e1c	;      "         "    Y  "   "
;TYPE		= $5e20	; contiene il TYPE del blocco dove e' CYBER
;OBJ		= $5e22	;     "     "  OBJ  "     "     "  "    "
;UP		= $5e24	; contiene il TYPE sopra CYBER
;LE		= $5e26	;     "     "   "  a sinistra di CYBER
;RI		= $5e28	;     "     "   "  a destra di CYBER
;DW		= $5e2a	;     "     "   "  sotto CYBER
SUPERPILL	= $5e2c	; conta i VB durante ' FANTASMI mangiabili '
GHOSTSTOP	= $5e2e	; conta i VB durante ' STOP FANTASMI '
DEVIL		= $5e30	; conta i VB durante ' DIAVOLO rubaenergia '
ANGEL		= $5e32	; conta i VB durante ' ANGELO imbattibile '
VB		= $5e34	; LONG WORD!  .. conta i VB ( PAUSA = stop! )
SCORE		= $5e38	; LONG WORD!  .. contiene i PUNTI
ENERGY		= $5e3c	; quantita' ENERGIA di CYBER..
POWERJUMP	= $5e3e	; da immettere in SALTA
SPEED		= $5e40	; velocita' corrente di CYBER ( VEDI SLOW/FAST/QUICK )
VELOCITY	= $5e42	; velocita' settata di CYBER ( senza JOYUP )
INT_H		= $5e44	; altezza CYBER
LEVEL		= $5e46	; current level (1..5) or 0=OUT 
PILLS_1		= $5e48	;.B contiene il numero di pillole del LIVELLO 1
PILLS_2		= $5e49	;.B contiene il numero di pillole del LIVELLO 2
PILLS_3		= $5e4a	;.B contiene il numero di pillole del LIVELLO 3
PILLS_4		= $5e4b	;.B contiene il numero di pillole del LIVELLO 4
PILLS_5		= $5e4c	;.B contiene il numero di pillole del LIVELLO 5
;GFAIL		= $5e4e	;BYTE! -comune per TUTTI i GHOST
;GLAST		= $5e4f	;BYTE! -comune per TUTTI i GHST
;REMCYBER	= $5e50	;LONG! -puntatore GHOST MAP precedente al CYBER attuale
GAMEOVER	= $5e54	;BYTE! -FLAG (NORMAL=0/Game Over=1)
ENDGAME		= $5e55	;BYTE! -FLAG (NORMAL=0/End Game=1)
GHOST_OVERLAY	= $5e56 ;BYTE! ---- FLAG (usato internamente)
WELCOMED	= $5e57	;BYTE! ---- FLAG (gia' chiusa porta?)

;OFFSET rispetto a STRUCT_GHOST -->reg.A1
GVX		= $0	;WORD!
GVY		= $2	;WORD!
GSPEED		= $4	;WORD!
GALPHA		= $6	;BYTE!
GBAD		= $7	;BYTE! --- AGGRESSIVO
GLIBERO		= $8	;BYTE!
GGHOST		= $9	;BYTE!
GCYBER		= $a	;BYTE!
GLIBEROV	= $b	;BYTE! --- VULNERABILE
GGHOSTV		= $c	;BYTE! --- VULNERABILE
GCYBERV		= $d	;BYTE! --- VULNERABILE
GFACE		= $e	;BYTE! per CYBER_DRAW shape del GHOST
GCONTROL	= $f	;BYTE! bit 0=VULNERABILE (if=1)

; ---- ESTERNI ---- (VEDI VAR.asm)
;ADDRESS_MAP	= $5ba4	;LONG WORD!   --- COMUNE A CYBER DRAW (!!!)
;TURNSPEED	= $5e4d	;BYTE! --- usato da TURN --- comune a CYBER DRAW (!!!)
;PAUSE		= $5e1e	;BYTE! INPUT stop interrupt - COMUNE A CYBER DRAW (!!!)
;GPAUSE		= $5e1f	;BYTE! INPUT stop interrupt - COMUNE A CYBER DRAW (!!!)
;WAVS		= $5c0c	;WORD! COMUNE A CYBER DRAW (!!!)
; END of VAR_INT.asm
*******************************************************************************
*                                                                             *
*                               END OF CYBER-MAN                              *
*                      Copyright (c) 1993 by Fabio Bizzetti                   *
*                              All rights reserved.                           *
*                                                                             *
*******************************************************************************
ACTION_SETUP:

;	LEA	$C00000,A0	;A0 = TABs
	LEA	$DFF000,A6	;CUSTOM

	MOVE.L	A0,A7
	ADD.L	#$38000,A7	;STACK POINTER

	BSET.B	#1,$BFE001	;LED OFF
	MOVE.W	#$7FFF,$9A(A6)	;INTENA
	MOVE.W	#$7FFF,$96(A6)	;DMACON
	MOVE.B	#$00,$BFEF01	;TOD VSYNC 50 Hz
	MOVE.B	#$00,$BFDF00	;TOD HSYNC 15625 Hz

	MOVE.L	#$1000,AUDIO_PT(A0)
	CLR.B	AUD1_PRI(A0)
	MOVE.L	EMPTY_PT(A0),A5
	ADD.L	#1024,A5		;sicuramente 1024 bytes a zero
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,$A0(A6)		;aud0pt
	MOVE.W	#512,$A4(A6)		;aud0len
	MOVE.W	#128,$A6(A6)		;aud0per
	MOVE.L	A5,$C0(A6)		;aud2pt
	MOVE.W	#512,$C4(A6)		;aud2len
	MOVE.W	#128,$C6(A6)		;aud2per
	MOVE.L	A5,$D0(A6)		;aud3pt
	MOVE.W	#512,$D4(A6)		;aud3len
	MOVE.W	#128,$D6(A6)		;aud3per
	MOVE.W	#$87FD,$96(A6)		;DMACON
	MOVE.L	WIND_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD0_PT(A0)
	MOVE.W	WIND_LEN(A0),AUD0_LEN(A0)
	MOVE.L	BACK_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD2_PT(A0)
	MOVE.L	A5,AUD3_PT(A0)
	MOVE.W	BACK_LEN(A0),AUD2_LEN(A0)
	MOVE.W	BACK_LEN(A0),AUD3_LEN(A0)

	MOVE.L	A0,D0
	ADD.L	#$20000,D0
	MOVE.L	D0,ADDRESS_MAP(A0)

	MOVE.L	#$68000,PAGE_0(A0)
	MOVE.L	#$74000,PAGE_1(A0)
	MOVE.L	#$65000,FILLBLIT(A0)
	MOVE.L	#$64000,Copper_LIST_0(A0)
	MOVE.L	#$64200,Copper_LIST_1(A0)

	MOVE.L	A0,D0
	ADD.L	#$38000,D0
	MOVE.L	D0,BACK_NORTH_PT(A0)
	ADD.L	#$3400,D0
	MOVE.L	D0,BACK_EAST_PT(A0)
	ADD.L	#$3400,D0
	MOVE.L	D0,BACK_SOUTH_PT(A0)
	ADD.L	#$3400,D0
	MOVE.L	D0,BACK_WEST_PT(A0)

	MOVE.L	A0,D0
	ADD.L	#$45000,D0
	MOVE.L	D0,CYBER_MAN_scr(A0)

	MOVE.L	A0,D0
	ADD.L	#$54000,D0
	MOVE.L	D0,ENEMY_scr(A0)

	MOVE.L	A0,D0
	ADD.L	#$60000,D0
	MOVE.L	D0,BONUS_scr(A0)

	MOVE.L	A0,D0
	ADD.L	#$6C000,D0
	MOVE.L	D0,END_GAME_scr(A0)

	MOVE.L	A0,D0
	ADD.L	#$7E000,D0
	MOVE.L	D0,COLORTABLE(A0)

	MOVE.L	#$2E000,SHAPES(A0)
	MOVE.L	#$2B000,RADAR_PT(A0)

	LEA	INT(PC),A1	;START INTs
	MOVE.L	A1,$6C.W
	LEA	INT_KEY(PC),A1
	MOVE.L	A1,$68.W
	LEA	INT_AUDIO(PC),A1
	MOVE.L	A1,$70.W

	MOVE.L	#$00000000,BEST_score(A0)
	MOVE.L	#$7fffffff,BEST_time(A0)
	MOVE.L	#0,BEST_sctm(A0)

	BRA.W	MAIN
*******************************************************************************
SAVE_SYSTEM:
	LEA	OLDINTREQ(PC),A1
	MOVE.W	$DFF01E,(A1)			;PRESERVA L'INTREQ
	LEA	OLDINTENA(PC),A1
	MOVE.W	$DFF01C,(A1)			;PRESERVA L'INTENA
	LEA	OLDDMACON(PC),A1
	MOVE.W	$DFF002,(A1)			;PRESERVA IL DMACON
	LEA	OLD_TOD_50(PC),A1
	MOVE.B	$BFEF01,(A1)			;TOD VSYNC 50 Hz
	LEA	OLD_TOD_15625(PC),A1
	MOVE.B	$BFDF00,(A1)			;TOD HSYNC 15625 Hz
	MOVE.L	4.W,A6				;APRE LA GRAPHICS.LIBRARY
	MOVEQ	#0,D0
	LEA	GFX_NAME(PC),A1
	JSR	-408(A6)			;EXEC _OldOpenLibrary
	MOVE.L	D0,A1
	LEA	OLDCOP(PC),A5
	MOVE.L	$26(A0),(A5)			;COPPERLIST ORIGINALE 1
	LEA	OLDCOP2(PC),A5
	MOVE.L	$36(A0),(A5)			;COPPERLIST ORIGINALE 2
	MOVEQ	#0,D0
	JSR	-414(A6)			;EXEC _CLOSELIBRARY
	LEA	OLDINTVB(PC),A1
	MOVE.L	$6C,(A1)			;SALVA IL VETTORE 3
	LEA	OLDINTKEY(PC),A1
	MOVE.L	$68,(A1)			;SALVA IL VETTORE 2
	LEA	OLDINTAUDIO(PC),A1
	MOVE.L	$70,(A1)			;SALVA IL VETTORE 4
	RTS

RESTORE_SYSTEM:
	MOVE.L	OLDINTVB(PC),$6C		;RIPRISTINA IL VETTORE 3
	MOVE.L	OLDINTKEY(PC),$68		;RIPRISTINA IL VETTORE 2
	MOVE.L	OLDINTAUDIO(PC),$70		;RIPRISTINA IL VETTORE 4
	MOVE.L	OLDCOP(PC),$DFF080		;RIPRISTINA LA COPPERLIST
	MOVE.L	OLDCOP2(PC),$DFF084		;RIPRISTINA LA COPPERLIST
	MOVE.B	OLD_TOD_50(PC),$BFEF01		;TOD VSYNC 50 Hz
	MOVE.B	OLD_TOD_15625(PC),$BFDF00	;TOD HSYNC 15625 Hz
	MOVE.W	OLDDMACON(PC),D0		;RIPRISTINA IL DMACON
	MOVE.W	OLDINTREQ(PC),D1		;RIPRISTINA L'INTREQ
	MOVE.W	OLDINTENA(PC),D2		;RIPRISTINA L'INTENA
	BSET.L	#15,D0				;ATTIVA IL BIT DI CONTROLLO
	BSET.L	#15,D1				;ATTIVA IL BIT DI CONTROLLO
	BSET.L	#15,D2				;ATTIVA IL BIT DI CONTROLLO
	MOVE.W	#$7FFF,$DFF096			;clear DMACON
	MOVE.W	#$7FFF,$DFF09C			;clear INTREQ
	MOVE.W	#$7FFF,$DFF09A			;clear INTENA
	MOVE.W	D0,$DFF096			;RIPRISTINA IL DMACON
	MOVE.W	D1,$DFF09C			;RIPRISTINA L'INTREQ
	MOVE.W	D2,$DFF09A			;RIPRISTINA L'INTENA
	RTS

OLDCOP		DS.L	1
OLDCOP2		DS.L	1
OLDINTREQ	DS.W	1
OLDINTENA	DS.W	1
OLDDMACON	DS.W	1
OLDINTVB	DS.L	1
OLDINTKEY	DS.L	1
OLDINTAUDIO	DS.L	1
OLD_TOD_50	DS.B	1
OLD_TOD_15625	DS.B	1

GFX_NAME	dc.b	'graphics.library',0
		DS.B	1			;per allineare a WORD
*******************************************************************************
ASMONE_SETUP:
	LEA	$C58000,A0	;TABs
	LEA	$DFF000,A6	;CUSTOM
	MOVE.W	#$7FFF,$9A(A6)	;INTENA
	MOVE.W	#$7FFF,$96(A6)	;DMACON
	BSET.B	#1,$BFE001	;LED OFF
	MOVE.B	#$00,$BFEF01	;TOD VSYNC 50 Hz
	MOVE.B	#$00,$BFDF00	;TOD HSYNC 15625 Hz

	CLR.B	AUD1_PRI(A0)
	MOVE.L	EMPTY_PT(A0),A5
	ADD.L	#1024,A5		;sicuramente 1024 bytes a zero
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,$A0(A6)		;aud0pt
	MOVE.W	#512,$A4(A6)		;aud0len
	MOVE.W	#128,$A6(A6)		;aud0per
	MOVE.L	A5,$C0(A6)		;aud2pt
	MOVE.W	#512,$C4(A6)		;aud2len
	MOVE.W	#128,$C6(A6)		;aud2per
	MOVE.L	A5,$D0(A6)		;aud3pt
	MOVE.W	#512,$D4(A6)		;aud3len
	MOVE.W	#128,$D6(A6)		;aud3per
	MOVE.W	#$87FD,$96(A6)		;DMACON
	MOVE.L	WIND_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD0_PT(A0)
	MOVE.W	WIND_LEN(A0),AUD0_LEN(A0)
	MOVE.L	BACK_PT(A0),A5
	ADD.L	AUDIO_PT(A0),A5
	MOVE.L	A5,AUD2_PT(A0)
	MOVE.L	A5,AUD3_PT(A0)
	MOVE.W	BACK_LEN(A0),AUD2_LEN(A0)
	MOVE.W	BACK_LEN(A0),AUD3_LEN(A0)

	BTST.B	#6,$BFE001
	BEQ.W	.continue

	MOVE.L	#$4f000,ADDRESS_MAP(A0)
	MOVE.L	#$68000,PAGE_0(A0)
	MOVE.L	#$74000,PAGE_1(A0)
	MOVE.L	#$65000,FILLBLIT(A0)
	MOVE.L	#$57000,Copper_LIST_0(A0)
	MOVE.L	#$57200,Copper_LIST_1(A0)
	MOVE.L	#$58000,BACK_NORTH_PT(A0)
	MOVE.L	#$5b400,BACK_EAST_PT(A0)
	MOVE.L	#$5e800,BACK_SOUTH_PT(A0)
	MOVE.L	#$61C00,BACK_WEST_PT(A0)
	MOVE.L	#$18000,SHAPES(A0)
	MOVE.L	#$4B000,RADAR_PT(A0)
	MOVE.L	#$1000,AUDIO_PT(A0)
	MOVE.W	#$5,BPROF(A0)
	ST.B	RADAR(A0)
	ST.B	HUD(A0)
	CLR.W	CHEAT_E(A0)
	CLR.W	CHEAT_L(A0)
	CLR.B	CHEATED(A0)

	BSR.W	INT+$4		;SET UP INT
.continue
	BSR.B	DRAW		;SET UP DRAW

	LEA	INT(PC),A1	;START INTs
	MOVE.L	A1,$6C.W
	LEA	INT_KEY(PC),A1
	MOVE.L	A1,$68.W
	LEA	INT_AUDIO(PC),A1
	MOVE.L	A1,$70.W

	BRA.W	MAIN
*******************************************************************************

********************

DRAW	incbin	EH:game/CyberMan/BINs/CYBER_DRAW

INT_ext:
	MOVEM.L	D0-D7/A1-A5,-(SP)
	MOVE.W	$DFF01C,D0
	AND.W	$DFF01E,D0
	BTST.L	#5,D0
	BEQ.B	LVL3_EXIT
	ADDQ.B	#1,3.W
LVL3_EXIT:
	MOVE.W	#$0060,$DFF09C		;Clear VB(+BLIT) bit
	MOVEM.L	(SP)+,D0-D7/A1-A5
	RTE

INT	incbin	EH:game/CyberMan/BINs/CYBER_INT

********************

*******************************************************************************
