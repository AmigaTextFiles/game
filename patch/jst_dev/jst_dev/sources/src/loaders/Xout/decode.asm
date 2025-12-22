	XDEF	_DecodeTrack

SYNC_WORD = $8455 

GETLONG:MACRO
	movem.l	D3-D4,-(sp)
	move.l	(A2)+,\1	; higher part (dest register)
	move.l	(A2),D3
	lsr.l	D7,D3		; shift lower part with count
	moveq	#$20,D4
	sub.l	D7,D4
	lsl.l	D4,\1		;higher part has to be shifted to fill
	or.l	D3,\1		;the rest-place, a longword has 20 bits
	movem.l	(sp)+,D3-D4	
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
	CMP.W	#SYNC_WORD,D0	; sync?
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
	CMP.W	#SYNC_WORD,D0
	BNE.S	.SY

.1	MOVE.L	(A2),D0
	ADDQ.L	#2,A2
	LSR.L	D5,D0
	CMP.W	#SYNC_WORD,D0
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

	lea	$7FFE(A0),A2

	bsr	GetSync
	tst.l	D0
	bne	syncerr


	move.l	D1,D7		; shift : D7

	subq.l	#2,A0		; longword reader

LB_C962
	MOVE.L	(A0),D0		; read word
	addq.l	#2,A0
	lsr.l	D7,D0		; shift

	CMP.W	#$2AAA,D0
	BNE	decodeerr

	subq.l	#2,A0		; longword reader needs this

	move.l	A0,A2

	; *** begin read track

	MOVE.L	#$55555555,D3
	GETLONG	D5			; checksum!!

;	MOVE.L	(A2)+,D5

	AND.L	D3,D5			; checksum
	MOVEQ	#0,D1
	MOVE.L	#$0BA7,D0
decodeloop1

;	MOVE.L	(A2)+,D6

	GETLONG	D6

	AND.L	D3,D6
	ADD.L	D6,D1
	DBF	D0,decodeloop1

	AND.L	D3,D1
	CMP.L	D1,D5
	BNE	decodeerr		; wrong checksum

	MOVE.L	#$05D3,D0		;1D6: 303C05D3
	LEA	4(A0),A2

decodeloop2:
	move.l	A2,-(sp)
	lea	5968(A2),A2
	GETLONG	D1
	move.l	(sp)+,A2

;	MOVE.L	5968(A2),D1		;1E0: 222A1750

	GETLONG	D2

	AND.L	D3,D1			;1E6: C283
	AND.L	D3,D2			;1E8: C483
	ASL.L	#1,D2			;1EA: E382
	OR.L	D2,D1			;1EC: 8282
	MOVE.L	D1,(A1)+		;1EE: 22C1
	DBF	D0,decodeloop2


	movem.l	(sp)+,D1-A6
	moveq	#0,D0
	RTS	

syncerr:
	movem.l	(sp)+,D1-A6
	moveq	#-2,D0
	rts

decodeerr:
	movem.l	(sp)+,D1-A6
	moveq	#-1,D0
	rts

dectrack:
;	blk.b	$1A00,0
rawtrack:
;	incbin	"xout.raw"

