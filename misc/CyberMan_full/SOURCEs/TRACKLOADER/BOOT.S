;******************************************************************************
;
;   CYBER-MAN
;
; BOOT routine                                                19 Apr 1993
;
;

BOOT:
	DC.L	$444F5300	;DOS
	DC.L	$00000000	;CHECKSUM
	DC.L	$00000370	;880 = BOOT

	LEA	$DFF000,A6
	LEA	$070000,A4
	MOVE.L	#$01000,A7	;STACK POINTER
	MOVE.W	#$7FFF,$9A(A6)	;intena
	MOVE.W	#$7FFF,$96(A6)	;dmacon
	MOVE.W	#$8210,$96(A6)
	MOVE.W	#$0000,$180(A6)	;color00

	MOVE.W	#$03FF,D0	; CLEAR $00000-$01000 of CHIP-MEM
	LEA	$00000.W,A1
.clr1	CLR.L	(A1)+
	DBRA	D0,.clr1

	LEA	LOADER(PC),A1
	MOVE.W	#$00FF,D0
	LEA	$00400.W,A2	; $400 = ADDRESS of LOADER
.copy	MOVE.L	(A1)+,(A2)+
	DBRA	D0,.copy
	JMP	$400

LOADER:	MOVE.W	#$FDFF,D0	; CLEAR $01000-$80000 of CHIP-MEM
	LEA	$01000.W,A1
.clr2	CLR.L	(A1)+
	CLR.L	(A1)+
	DBRA	D0,.clr2

	BSR.W	FIND_FASTRAM	; A0 = Address of FAST RAM 512k

	MOVEQ	#-1,D0		; CLEAR $00000-$80000 of FAST-MEM
	MOVE.L	A0,A1
.clr3	CLR.L	(A1)+
	CLR.L	(A1)+
	DBRA	D0,.clr3

	LEA	$BFD000,A1
	LEA	$BFE001,A2
	BSR.B	TRACKLOADER

	MOVE.L	A0,A1
	ADD.L	#$28000,A1	;PROGRAM Address
	JMP	(A1)

; END of BOOT routine
*******************************************************************************
*
* TRACKLOADER routine                                         19 Apr 1993
*
*
*   D0,D1,D2,D3,D6,D7 = Local use
*
*   A1 = CIAB            $BFD000     pre-load
*   A2 = CIAA            $BFE001     pre-load
*   A3 = VAR  --local variables--
*   A4 = BUFFER          $070000     pre-load    LENGHT = 16k
*   A5 = used by DECODE routine
*   A6 = CUSTOM          $DFF000     pre-load
*   A7 = STACK POINTER   $001000     pre-load
*
* D4,D5,A0 = Unused
*

TRACKLOADER:
	LEA	VAR(PC),A3

	MOVE.B	$100(A1),D0
	AND.B	#$7F,D0
	MOVE.B	D0,$100(A1)	;MOTOR ON
	AND.B	#$F5,D0
	OR.B	#$72,D0
	MOVE.B	D0,$100(A1)	;DF0 , dir00

	MOVE.B	$E00(A1),D0
	AND.B	#$C0,D0
	OR.B	#8,D0
	MOVE.B	D0,$E00(A1)	;ciacrA
	MOVE.B	#$7F,$D00(A1)	;ciacrB

READY:	BTST.B	#5,(A2)
	BNE.B	READY

	BTST.B	#4,(A2)		;track00 ?
	BEQ.B	.go
.seek00	BSR.W	STEP_HEAD
	BTST.B	#4,(A2)
	BNE.B	.seek00

.go	MOVE.B	$100(A1),D0
	AND.B	#$FD,D0
	MOVE.B	D0,$100(A1)	;dir79
	CLR.W	track(A3)	;num of track (0..159)
.seek02	
	MOVE.W	track(A3),D0
	CMP.W	#2,D0
	BEQ.B	.track02
	ADDQ.W	#1,D0
	MOVE.W	D0,track(A3)
	BTST.L	#0,D0
	BNE.B	.seek02
	BSR.W	STEP_HEAD
	BRA.B	.seek02

.track02				;load SOUND (tracks 2..27)
	MOVE.L	#$01000,dest(A3)
.sound	CMP.W	#28,track(A3)
	BEQ.B	.track28
	BSR.W	READ_TRACK
	BRA.W	.sound

.track28				;load RADAR,SHAPES,COPPER (tr. 28..70)
	MOVE.L	#$2B000,dest(A3)
.shapes	CMP.W	#71,track(A3)
	BEQ.B	.track71
	BSR.W	READ_TRACK
	BRA.W	.shapes

.track71				;load TABs,MAP,PROGRAM (tracks 71..107)
	MOVE.L	A0,dest(A3)
.tabs	CMP.W	#108,track(A3)
	BEQ.B	.track108
	BSR.W	READ_TRACK
	BRA.W	.tabs

.track108				;load SCREENs,PALETTE (tracks 108..159)
	MOVE.L	A0,dest(A3)
	ADD.L	#$38000,dest(A3)
.screen	CMP.W	#160,track(A3)
	BEQ.B	.exit
	BSR.W	READ_TRACK
	BRA.W	.screen

.exit	RTS

************************************************
VAR:
dest	RS.L	1
track	RS.W	1
sector	RS.W	1

	DC.L	1	;dest
	DC.W	1	;track
	DC.W	1	;sector
************************************************

READ_TRACK:
	MOVE.W	track(A3),D0	;num of track (0..159)
	AND.W	#1,D0
	LSL.W	#2,D0
	EOR.W	#4,D0
	MOVE.B	$100(A1),D1
	AND.B	#$FB,D1
	OR.B	D1,D0
	MOVE.B	D0,$100(A1)	;SELEZIONA la faccia del disco
	MOVE.L	A4,$20(A6)	;dskpt	-->BUFFER
	MOVE.W	#$0002,$9C(A6)	;intreq
	MOVE.W	#$4489,$7E(A6)	;dsksync
	MOVE.W	#$8400,$9E(A6)	;adkcon
	MOVE.W	#$4000,$24(A6)	;dsklen
	MOVE.W	#$9E00,$24(A6)
	MOVE.W	#$9E00,$24(A6)
.wbf	BTST.B	#1,$1F(A6)	;intreqr
	BEQ.B	.wbf
	MOVE.W	#0002,$9C(A6)	;clear DSKBLK interrupt
	MOVE.W	#$4000,$24(A6)	;dsklen

	CLR.B	sector(A3)

	MOVE.L	A1,-(A7)	;CIAB
	MOVE.L	A2,-(A7)	;CIAA
.decode	MOVE.L	A4,A1		;A4 = BUFFER
	ADD.L	#$200,A1
	MOVE.L	#$55555555,D7
.sync	CMP.W	#$4489,(A1)+
	BNE.B	.sync
.sync2	CMP.W	#$4489,(A1)
	BNE.B	.data
	ADDQ.L	#2,A1
	BRA.B	.sync2
.data	LEA	4(A1),A2
	MOVE.L	(A1)+,D0
	MOVE.L	(A2)+,D1
	AND.L	D7,D0
	LSL.L	#1,D0
	AND.L	D7,D1
	OR.L	D1,D0
	ROR.L	#8,D0
	MOVE.B	sector(A3),D1
	CMP.B	D1,D0
	BEQ.B	.sector
	LEA	$3E8(A1),A1
	BRA.B	.sync
.sector	LEA	$34(A1),A1
	LEA	$200(A1),A2
	MOVE.L	dest(A3),A5
	MOVEQ	#$7F,D6
.loop	MOVE.L	(A1)+,D0
	MOVE.L	(A2)+,D1
	AND.L	D7,D0
	LSL.L	#1,D0
	AND.L	D7,D1
	OR.L	D1,D0
	MOVE.L	D0,(A5)+
	DBRA	D6,.loop
	MOVE.L	A5,dest(A3)

	ADDQ.B	#1,sector(A3)
	CMP.B	#11,sector(A3)
	BNE.B	.decode

	MOVE.L	(A7)+,A2	;CIAA
	MOVE.L	(A7)+,A1	;CIAB

	ADDQ.W	#1,track(A3)
	MOVE.W	track(A3),D0
	BTST.L	#0,D0
	BNE.B	.exit
	BRA.W	STEP_HEAD
.exit	RTS

STEP_HEAD:
	MOVE.B	$100(A1),D0
	AND.B	#$FE,D0
	MOVE.B	D0,$100(A1)	;Step HEAD
	ADDQ.B	#1,D0
	NOP
	NOP
	NOP
	NOP
	MOVE.B	D0,$100(A1)

	MOVE.B	$E00(A1),D0
	AND.B	#$C0,D0
	OR.B	#8,D0
	MOVE.B	D0,$E00(A1)	;ciacrA
	MOVE.B	#$7F,$D00(A1)	;ciacrB

	MOVE.W	#$2148,D0
	MOVE.B	D0,$400(A1)
	LSR.W	#8,D0
	MOVE.B	D0,$500(A1)
.wi	BTST.B	#0,$D00(A1)
	BEQ.B	.wi		;DELAY
	RTS

; END of TRACKLOADER routine
;******************************************************************************
;
; FIND_FASTRAM routine                                        19 Apr 1993
;
;

FIND_FASTRAM:
	MOVE.L	$200000,D0
	CLR.L	$200000
	MOVE.L	#'CHK0',$200000
	CMP.L	#'CHK0',$200000
	BNE.B	FIND.8
	MOVE.L	$27FFFC,D1
	CLR.L	$27FFFC
	MOVE.L	#'CHK1',$27FFFC
	CMP.L	#'CHK1',$27FFFC
	BNE.B	FIND.8
	MOVE.L	D0,$200000
	MOVE.L	D1,$27FFFC
	LEA	$200000,A0
	RTS

FIND.8	MOVE.L	$800000,D0
	CLR.L	$800000
	MOVE.L	#'CHK2',$800000
	CMP.L	#'CHK2',$800000
	BNE.B	FIND.C
	MOVE.L	$87FFFC,D1
	CLR.L	$87FFFC
	MOVE.L	#'CHK3',$87FFFC
	CMP.L	#'CHK3',$87FFFC
	BNE.B	FIND.C
	MOVE.L	D0,$800000
	MOVE.L	D1,$87FFFC
	LEA	$800000,A0
	RTS

FIND.C	MOVE.L	$C00000,D0
	CLR.L	$C00000
	MOVE.L	#'CHK4',$C00000
	CMP.L	#'CHK4',$C00000
	BNE.B	FIND.0
	MOVE.L	$C7FFFC,D0
	CLR.L	$C7FFFC
	MOVE.L	#'CHK5',$C7FFFC
	CMP.L	#'CHK5',$C7FFFC
	BNE.B	FIND.0
	MOVE.L	D0,$C00000
	MOVE.L	D1,$C7FFFC
	LEA	$C00000,A0
	RTS

FIND.0	MOVE.L	$080000,D0
	MOVE.L	$000000,D1
	CLR.L	$000000
	CLR.L	$080000
	MOVE.L	#'CHK6',$080000
	CMP.L	#'CHK6',$080000
	BNE.B	FIND.N
	CMP.L	#'CHK6',$000000
	BEQ.B	FIND.N
	MOVE.L	D0,$080000
	MOVE.L	D1,$000000
	LEA	$080000,A0
	RTS

FIND.N	MOVE.W	#$0F00,$DFF180	; ERROR = NO FAST RAM found -->RED SCREEN
	BRA.B	FIND.N

; END of FIND_FASTRAM routine
;******************************************************************************
