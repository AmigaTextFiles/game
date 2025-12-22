* $Id: keyboard.s 1.1 1999/02/03 04:10:31 jotd Exp $
**************************************************************************
*   KEYBOARD DEVICE                                                      *
**************************************************************************
**************************************************************************
*   INITIALIZATION                                                       *
**************************************************************************

ReadMatrix:
	movem.l	D0/A0-A2,-(A7)
	lea	KeyboardMatrix(pc),A2
	move.l	(IO_DATA,A1),A0
	move.l	(IO_LENGTH,A1),D0
	beq.b	.exit
.copy:
	move.b	(A2)+,(A0)+
	subq.l	#1,D0
	bne.b	.copy
.exit
	movem.l	(A7)+,D0/A0-A2
	rts

StoreKbValue:
	bsr	UpdKbMatrix

	rts

; < D0: raw keycode

UpdKbMatrix:
	movem.l	D0-D2/A0,-(A7)
	lea	KeyboardMatrix(pc),A0

	and.l	#$FF,D0
	move.b	D0,D2

	move.b	D0,D1

	and.b	#7,D1	; D1 MOD 8
	lsr.b	#3,D0	; D0 DIV 8

	add.l	D0,A0

	btst	#7,D2	; key up or down?
	beq	.down
	bclr	D1,(A0)
	bra	.exit
.down
	bset	D1,(A0)
.exit
	movem.l	(A7)+,D0-D2/A0
	rts

KeyboardMatrix:
	blk.b	20,0
