	XDEF	_DecodeTrack
	XDEF	DecodeTrack

SYNC_WORD =$4489

GETLONG:MACRO
	movem.l	D3-D4,-(sp)
	move.l	(A1)+,\1	; higher part (dest register)
	move.l	(A1),D3
	lsr.l	D0,D3		; shift lower part with count
	moveq	#$20,D4
	sub.l	D0,D4
	lsl.l	D4,\1		;higher part has to be shifted to fill
	or.l	D3,\1		;the rest-place, a longword has 20 bits
	movem.l	(sp)+,D3-D4	
	ENDM

start:
	move.l	#dectrack,A0
	move.l	#rawtrack,D0
	bsr	DecodeTrack
	rts

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

	lea	synctrack,A1
	addq.l	#8,A1
	move.l	DecodedBuffer,A0

	bsr	Decode

	; checksum

	moveq	#0,D3
	MOVEA.L	A0,A1			;1F4: 2248
	MOVE	#$0C1B,D4		;1F6: 383C0C1B
LAB_0006:
	ADD	(A1)+,D3		;1FA: D659
	DBF	D4,LAB_0006		;1FC: 51CCFFFC
	MOVE	(A1),D4			;200: 3811
	CMP	D3,D4			;202: B843
	bne	decodeerr

	moveq	#0,D0
exit
	movem.l	(sp)+,D1-A6
	rts


decodeerr
	moveq	#1,D0
	bra	exit

syncerr
	moveq	#2,D0
	bra	exit

Decode:
	MOVEM.L	D0-D1/A0,-(A7)		;1E2: 48E7C080
	MOVE	#$0C1C,D7		;220: 3E3C0C1C
LAB_0008:
	MOVE	(A1)+,D0		;224: 3019
	MOVE	(A1)+,D1		;226: 3219
	ASL	#1,D0			;228: E340
	ANDI	#$AAAA,D0		;22A: 0240AAAA
	ANDI	#$5555,D1		;22E: 02415555
	OR	D1,D0			;232: 8041
	MOVE	D0,(A0)+		;234: 30C0
	DBF	D7,LAB_0008		;236: 51CFFFEC
	MOVEM.L	(A7)+,D0-D1/A0		;1EE: 4CDF0103
	RTS				

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
dectrack:
;	blk.b	$1900,0
rawtrack:
;	incbin	"menace.raw"

synctrack:
	blk.w	$1900,0
