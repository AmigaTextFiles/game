* $Id: mathffp.s 1.1 1999/02/03 04:09:05 jotd Exp $

**************************************************************************
*   MATHFFP-LIBRARY                                                      *
**************************************************************************
**************************************************************************
*   INITIALIZATION                                                       *
**************************************************************************

MATHFFPINIT	move.l	_mffpbase,d0
		beq	.init
		rts

.init		move.l	#-_LVOSPDiv,d0
		move.l	#LIB_SIZE,D1
		lea	_mffpname,a0
		jsr	_InitLibrary
		move.l	d0,a0
		move.l	d0,_mffpbase

		patch	_LVOSPFlt(a0),SPFlt(pc)
		patch	_LVOSPFix(a0),SPFix(pc)
		patch	_LVOSPDiv(a0),SPDiv(pc)
		patch	_LVOSPMul(a0),SPMul(pc)
		
		rts

; < D0: signed int
; > D0: double precision float

	dc.b	"SPFlt",0	
SPFlt:
	MOVEQ	#95,D1
	TST.L	D0
	BEQ.S	.lab_0003
	BPL.S	.lab_0000
	MOVEQ	#-32,D1
	NEG.L	D0
	BVS.S	.lab_0002
	SUBQ.B	#1,D1
.lab_0000:
	CMP.L	#$00007FFF,D0
	BHI.S	.lab_0001
	SWAP	D0
	SUB.B	#$10,D1
.lab_0001:
	ADD.L	D0,D0
	DBMI	D1,.lab_0001
	TST.B	D0
	BPL.S	.lab_0002
	ADD.L	#$00000100,D0
	BCC.S	.lab_0002
	ROXR.L	#1,D0
	ADDQ.B	#1,D1
.lab_0002:
	MOVE.B	D1,D0
.lab_0003:
	RTS

SPFlt_jotd:
	tst.l	D0
	beq.b	.exit
	
	movem.l	D1-D2,-(A7)

	move.w	#$40,D2

	btst	#31,D0
	beq	.positive
	move.w	#$C0,D2
	neg.l	D0
.positive:
	move.l	D0,D1
.sh1loop:
	tst.l	D1
	beq.b	.sh1out
	addq.l	#1,D2
	lsr.l	#1,D1
	bra.b	.sh1loop
.sh1out:

.sh2loop:
	btst	#31,D0
	bne.b	.sh2out
	add.l	D0,D0
	bra.b	.sh2loop
.sh2out:
	or.w	D2,D0

	movem.l	(A7)+,D1-D2

.exit
	rts
	
; SPDiv:
; < D0 : numerator
; < D1 : divisor
; > D0 : result
;
; Ripped and adapted by JOTD from ROM code (shame :) )

	dc.b	"SPDiv",0
SPDiv:
	MOVEM.L	D3-D5,-(A7)		;18: 48E71C00
	MOVE.B	D1,D5			;1C: 1A01
	beq	.divbyzero
	MOVE.L	D0,D4			;20: 2800
	BEQ	.rslt0			;22: 67DC
	MOVEQ	#-128,D3		;24: 7680
	ADD	D5,D5			;26: DA45
	ADD	D4,D4			;28: D844
	EOR.B	D3,D5			;2A: B705
	EOR.B	D3,D4			;2C: B704
	SUB.B	D5,D4			;2E: 9805
	BVS.S	.overflow
	CLR.B	D0			;32: 4200
	SWAP	D0			;34: 4840
	SWAP	D1			;36: 4841
	CMP	D1,D0			;38: B041
	BMI.S	.LAB_0005		;3A: 6B06
	ADDQ.B	#2,D4			;3C: 5404
	BVS.S	.overflow
	ROR.L	#1,D0			;40: E298
.LAB_0005:
	SWAP	D0			;42: 4840
	MOVE.B	D3,D5			;44: 1A03
	EOR	D5,D4			;46: BB44
	LSR	#1,D4			;48: E24C
	MOVE.L	D0,D3			;4A: 2600
	DIVU	D1,D3			;4C: 86C1
	MOVE	D3,D5			;4E: 3A03
	MULU	D1,D3			;50: C6C1
	SUB.L	D3,D0			;52: 9083
	SWAP	D0			;54: 4840
	SWAP	D1			;56: 4841
	MOVE	D1,D3			;58: 3601
	CLR.B	D3			;5A: 4203
	MULU	D5,D3			;5C: C6C5
	SUB.L	D3,D0			;5E: 9083
	BCC.S	.LAB_0007		;60: 6406
.LAB_0006:
	SUBQ	#1,D5			;62: 5345
	ADD.L	D1,D0			;64: D081
	BCC.S	.LAB_0006		;66: 64FA
.LAB_0007:
	MOVE.L	D1,D3			;68: 2601
	SWAP	D3			;6A: 4843
	CLR	D0			;6C: 4240
	DIVU	D3,D0			;6E: 80C3
	SWAP	D5			;70: 4845
	BMI.S	.LAB_0008		;72: 6B08
	MOVE	D0,D5			;74: 3A00
	ADD.L	D5,D5			;76: DA85
	SUBQ.B	#1,D4			;78: 5304
	MOVE	D5,D0			;7A: 3005
.LAB_0008:
	MOVE	D0,D5			;7C: 3A00
	ADD.L	#$00000080,D5		;7E: DABC00000080
	MOVE.L	D5,D0			;84: 2005
	MOVE.B	D4,D0			;86: 1004
	BEQ.S	.rslt0
.exit:
	MOVEM.L	(A7)+,D3-D5		;8A: 4CDF0038
	RTS				;8E: 4E75

.rslt0:
	MOVEQ	#0,D0			;10: 7000
	bra.b	.exit

.overflow:
.divbyzero:
	move.l	#$7FFFFF,D0
	bra	SPFlt		; big value

	dc.b	"SPMul",0
SPMul:
	MOVEM.L	D3-D5,-(A7)
	MOVE.B	D0,D5
	BEQ.S	lmul_0000
	MOVE.B	D1,D4
	BEQ.S	lmul_0003
	ADD	D5,D5
	ADD	D4,D4
	MOVEQ	#-128,D3
	EOR.B	D3,D4
	EOR.B	D3,D5
	ADD.B	D4,D5
	BVS.S	lmul_0004
	MOVE.B	D3,D4
	EOR	D4,D5
	ROR	#1,D5
	SWAP	D5
	MOVE	D1,D5
	CLR.B	D0
	CLR.B	D5
	MOVE	D5,D4
	MULU	D0,D4
	SWAP	D4
	MOVE.L	D0,D3
	SWAP	D3
	MULU	D5,D3
	ADD.L	D3,D4
	SWAP	D1
	MOVE.L	D1,D3
	MULU	D0,D3
	ADD.L	D3,D4
	CLR	D4
	ADDX.B	D4,D4
	SWAP	D4
	SWAP	D0
	MULU	D1,D0
	SWAP	D1
	SWAP	D5
	ADD.L	D4,D0
	BPL.S	lmul_0001
	ADD.L	#$00000080,D0
	MOVE.B	D5,D0
	BEQ.S	lmul_0003
lmul_0000:
	MOVEM.L	(A7)+,D3-D5
	RTS
lmul_0001:
	SUBQ.B	#1,D5
	BVS.S	lmul_0003
	BCS.S	lmul_0003
	MOVEQ	#64,D4
	ADD.L	D4,D0
	ADD.L	D0,D0
	BCC.S	lmul_0002
	ROXR.L	#1,D0
	ADDQ.B	#1,D5
lmul_0002:
	MOVE.B	D5,D0
	BEQ.S	lmul_0003
	MOVEM.L	(A7)+,D3-D5
	RTS
lmul_0003:
	MOVEQ	#0,D0
	MOVEM.L	(A7)+,D3-D5
	RTS
lmul_0004:
	BPL.S	lmul_0003
	EOR.B	D1,D0
	OR.L	#$FFFFFF7F,D0
	TST.B	D0
	ORI.B	#$02,CCR
	MOVEM.L	(A7)+,D3-D5
	RTS

	dc.b	"SPFix",0
SPFix:
	MOVE.B	D0,D1
	BMI.S	lfix_0003
	BEQ.S	lfix_0000
	CLR.B	D0
	SUB.B	#$41,D1
	BMI.S	lfix_0002
	SUB.B	#$1F,D1
	BPL.S	lfix_0001
	NEG.B	D1
	LSR.L	D1,D0
lfix_0000:
	RTS
lfix_0001:
	MOVEQ	#-1,D0
	LSR.L	#1,D0
	ORI.B	#$02,CCR
	RTS
lfix_0002:
	MOVEQ	#0,D0
	RTS
lfix_0003:
	CLR.B	D0
	SUB.B	#$C1,D1
	BMI.S	lfix_0002
	SUB.B	#$1F,D1
	BPL.S	lfix_0004
	NEG.B	D1
	LSR.L	D1,D0
	NEG.L	D0
	RTS
lfix_0004:
	BNE.S	lfix_0005
	NEG.L	D0
	TST.L	D0
	BMI.S	lfix_0000
lfix_0005:
	MOVEQ	#0,D0
	BSET	#31,D0
	ORI.B	#$02,CCR
	RTS
