	XDEF	_DecodeTrack
	XDEF	DecodeTrack

SYNC_WORD =$8915

GETLONG:MACRO
	movem.l	D3-D4,-(sp)
	move.l	(A0)+,\1	; higher part (dest register)
	move.l	(A0),D3
	lsr.l	D5,D3		; shift lower part with count
	moveq	#$20,D4
	sub.l	D5,D4
	lsl.l	D4,\1		;higher part has to be shifted to fill
	or.l	D3,\1		;the rest-place, a longword has 20 bits
	movem.l	(sp)+,D3-D4	
	ENDM



start:
	move.l	#dectrack,A0
	move.l	#rawtrack,D0
	bsr	DecodeTrack
	rts

; < D7-1: number of longwords to read

DecodeLong:
	MOVEQ	#0,D6			;2A2: 7C00
	move.l	Shift,D5
loop:
	MOVE.L	(A0)+,D0		;2A4: 2018
	MOVE.L	(A0)+,D1		;2A6: 2218
;	GETLONG	D0
;	GETLONG	D1
	ANDI.L	#$55555555,D0		;2A8: 028055555555
	ANDI.L	#$55555555,D1		;2AE: 028155555555
	ADD.L	D0,D0			;2B4: D080
	OR.L	D1,D0			;2B6: 8081
	MOVE.L	D0,(A1)+		;2B8: 22C0
	ADD.L	D0,D6			;2BA: DC80
	DBF	D7,loop
	RTS				;2C0: 4E75

ResyncTrack:
	move.l	RawBuffer(pc),A0
	move.l	Shift(pc),D0
	move.l	#$1850,D1
	subq.l	#6,A0
	lea	synctrack,A1
st_loop:
	move.l	(A0),D2
	lsr.l	D0,D2
	addq.l	#2,A0
	move.w	D2,(A1)+
	dbf	D1,st_loop
	rts

; ** C entrypoint

_DecodeTrack:
	move.l	4(A7),D0	; raw buffer
	move.l	8(A7),A0	; destination (decoded)

; ** assembly entrypoint

DecodeTrack:
	movem.l	D1-A6,-(sp)

	move.l	A0,A1	; dec
	move.l	D0,A0	; raw

	bsr	GetSync
	tst.l	D0
	bne	syncerr

	move.l	A1,DecodedBuffer
	move.l	A0,RawBuffer
	move.l	D1,Shift

	bsr	ResyncTrack

	lea	synctrack,A0
	addq.l	#4,A0

	move.l	DecodedBuffer,A1
	moveq.l	#0,D7
	bsr	DecodeLong
	move.l	D6,Checksum

	move.l	DecodedBuffer,A1
	move.l	#$57F,D7
	bsr	DecodeLong

	cmp.l	Checksum,D6
	bne	decodeerr
	moveq.l	#0,D0

exit
	movem.l	(sp)+,D1-A6
	rts


decodeerr
	moveq	#1,D0
	bra	exit

syncerr
	moveq	#2,D0
	bra	exit


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
RawBuffer:
	dc.l	0
DecodedBuffer:
	dc.l	0
Shift:
	dc.l	0
Checksum:
	dc.l	0
dectrack:
;	blk.b	$1900,0
rawtrack:
;	incbin	"jag"
synctrack:
	blk.w	$1880,0
