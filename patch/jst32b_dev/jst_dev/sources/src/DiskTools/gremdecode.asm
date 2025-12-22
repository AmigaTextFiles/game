	XDEF	_DecodeTrack

GET_D0D1:MACRO
	movem.l	D3-D4,-(sp)
	move.l	(A0)+,D0	; higher part (dest register)
	move.l	(A0),D3
	lsr.l	D6,D3		; shift lower part with count
	moveq	#$20,D4
	sub.l	D6,D4
	lsl.l	D4,D0		;higher part has to be shifted to fill
	or.l	D3,D0		;the rest-place, a longword has 20 bits
	movem.l	(sp)+,D3-D4	
	move.w	D0,D1
	swap	D0
	ENDM

asmtest:
	move.l	#dectrack,A0
	move.l	#rawtrack,D0
	bsr	DecodeTrack
	rts

; *** finds sync and shift

; in A0 rawdata
; out: D0 = 0 if success
;      D1 = shift (0-15)

GetSync:
	movem.l	D2-D6/A1-A6,-(sp)

	MOVE.L	A0,A2
	lea	$7C00(A2),A4		;end of rawtrack

.SHF2	MOVEQ.L	#$10-1,D5

	; *** try to find the sync shift (0 to 15)

.SHF1	MOVE.L	(A2),D0		; a longword of data
	LSR.L	D5,D0		; shift it by D5
	CMP.W	#$4489,D0	; sync?
	BEQ.S	.SY		; yes: found sync AND shift
	DBF	D5,.SHF1
	ADDQ.L	#2,A2
	cmp.l	A2,A4
	beq	ErrorSyn
	BRA.S	.SHF2

	; ** shift has been found, sync too.

.SY	MOVE.L	(A2),D0
	ADDQ.L	#2,A2
	LSR.L	D5,D0			;d5 is the shifting-number when sync was found
	CMP.W	#$4489,D0
	BNE.S	.SY

.1	MOVE.L	(A2),D0
	ADDQ.L	#2,A2
	LSR.L	D5,D0
	CMP.W	#$4489,D0
	BEQ.S	.1

	moveq	#0,D0
	move.l	A2,A0	; buffer synced
	move.l	D5,D1	; shift
	bra	ExitSyn

ErrorSyn:
	moveq	#-1,D0
ExitSyn
	movem.l	(sp)+,D2-D6/A1-A6
	rts

_DecodeTrack:
	move.l	4(sp),D0
	move.l	8(sp),A0
DecodeTrack
	movem.l	D1-A6,-(sp)

	move.l	A0,A1	; dec
	move.l	D0,A0	; raw

	bsr	GetSync
	tst.l	D0
	bne	syncerr

	lea	$7FFE(A0),A2

	move.l	D1,D6		; shift : D6

	subq.l	#2,A0		; longword reader

	; *** until $5555 met

LB_C962
	MOVE.L	(A0),D0		; read word
	addq.l	#2,A0
	lsr.l	D6,D0		; shift

	cmp.l	A0,A2
	beq	decodeerr

	CMP.W	#$5555,D0
	BNE.B	LB_C962		; until ==$5555


	MOVE.W	#$0BFF,D7
	MOVE.W	#$5555,D2
	moveq	#0,D3

	subq.l	#2,A0
decodeloop
	; boucle executee $C00 fois (*2=$1800: 1 track)

	GET_D0D1

;	MOVE.W	(A0)+,D0	; read word
;	MOVE.W	(A0)+,D1	; read word

	AND.W	D2,D0
	AND.W	D2,D1
	ADD.W	D1,D1
	ADD.W	D0,D1
	MOVE.W	D1,(A1)+	; write word
	ADD.W	D1,D3

	; SNIP


	DBF	D7,decodeloop

;	MOVE.W	(A0)+,D0	; read word
;	MOVE.W	(A0)+,D1	; read word

	GET_D0D1

	AND.W	D2,D0
	AND.W	D2,D1
	ADD.W	D1,D1
	ADD.W	D0,D1
	MOVE.W	D1,D7

	cmp.w	D3,D7
	bne	decodeerr

	movem.l	(sp)+,D1-A6
	moveq	#0,D0
	RTS	

	; ** garbage

;	MOVE.W	(A0)+,D0	; read word
;	MOVE.W	(A0)+,D1	; read word

	GET_D0D1

	AND.W	D2,D0
	AND.W	D2,D1
	ADD.W	D1,D1
	ADD.W	D0,D1
	MOVE.W	D1,D6

syncerr:
	movem.l	(sp)+,D1-A6
	moveq	#-2,D0
	rts

decodeerr:
	movem.l	(sp)+,D1-A6
	moveq	#-1,D0
	rts

dectrack:
;	blk.b	$1900,0
rawtrack:
;	incbin	"sb2.raw"

