	XDEF	_DecodeTrack
	XDEF	DecodeTrack

RESYNC_LEN = $1A00
SYNC_WORD =$1448

start:
	move.l	#dectrack,A0
	move.l	#rawtrack,D0
	move.l	diskkey,D1
	bsr	DecodeTrack
	rts

ResyncTrack:
	move.l	RawBuffer(pc),A0
	move.l	Shift(pc),D0
	move.l	#RESYNC_LEN,D1
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
	move.l	12(A7),D1	; disk key

; ** assembly entrypoint

DecodeTrack:
	movem.l	D1-A6,-(sp)

	move.l	A0,A1	; dec
	move.l	D0,A0	; raw

	move.l	D1,diskkey

	bsr	GetSync
	tst.l	D0
	bne	syncerr

	move.l	A1,DecodedBuffer
	move.l	A0,RawBuffer
	move.l	D1,Shift

	bsr	ResyncTrack

	move.l	DecodedBuffer,A2
	lea	synctrack+4,A5
	
	bsr	Decode

exit:

	movem.l	(sp)+,D1-A6
	rts


decodeerr
	moveq	#-1,D0
	rts

decodeerr2
	moveq	#1,D0
	add.w	sectorcount,D0
	rts

syncerr
	moveq	#-2,D0
	bra	exit

Decode:

sks:
	CMPI.W	#SYNC_WORD,(A5)
	bne	go
	addq.l	#2,A5
	bra	sks
go:
	CMPI.W	#$4891,(A5)
	BNE.W	decodeerr

	clr.l	sectorcount

LB_DFFA:
	LEA	$0002(A5),A0
	MOVE.L	(A0)+,D0
	MOVE.L	(A0)+,D1
	ANDI.L	#$55555555,D0
	ANDI.L	#$55555555,D1
	ADD.L	D0,D0
	OR.L	D1,D0
	MOVE.L	diskkey,D1
	BSET	#$1F,D1
	EOR.L	D1,D0
	MOVE.L	D0,D3
	SWAP	D0
	LSR.W	#8,D0

	LEA	$000A(A5),A0
	BSR.B	ChecksumZone
	CMP.W	D0,D3
	BNE.B	decodeerr2
	MOVE.L	A2,A1
	BSR.B	DecodeZone
	LEA	$0200(A2),A2

LB_E066
	ADDA.W	#$040A,A5
	MOVE.W	(A5)+,D0
	MOVEQ	#$00,D1
	MOVEQ	#$07,D2
LB_E070	ROXL.W	#2,D0
	ROXL.B	#1,D1
	DBF	D2,LB_E070

	ADD.W	D1,D1
	ADDA.L	D1,A5
	ADDQ.W	#1,sectorcount
	CMPI.W	#$000C,sectorcount
	BNE.W	LB_DFFA
	MOVEQ.L	#$0,D0
	RTS	

ChecksumZone
	MOVEM.L	D1/D2/A0,-(A7)
	MOVEQ	#$00,D0
	MOVE.W	#$00FF,D1
LB_E0BC	MOVE.L	(A0)+,D2
	EOR.L	D2,D0
	DBF	D1,LB_E0BC
	ANDI.L	#$55555555,D0
	MOVE.L	D0,D1
	SWAP	D1
	ADD.W	D1,D1
	OR.W	D1,D0
	MOVEM.L	(A7)+,D1/D2/A0
	RTS

DecodeZone
	MOVEM.L	D0-D4/A0-A2,-(A7)
	MOVEQ	#$7F,D0
	LEA	$0200(A0),A2
	MOVE.L	#$55555555,D3
	MOVE.L	diskkey,D4
LB_E0EC	MOVE.L	(A0)+,D1
	MOVE.L	(A2)+,D2
	AND.L	D3,D1
	AND.L	D3,D2
	ADD.L	D1,D1
	OR.L	D2,D1
	EOR.L	D1,D4
	MOVE.L	D4,(A1)+
	MOVE.L	D1,D4
	DBF	D0,LB_E0EC
	MOVEM.L	(A7)+,D0-D4/A0-A2
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
	moveq.l	#-2,D0
ExitSyn
	movem.l	(sp)+,D2-D6/A1-A6
	rts
RawBuffer:
	dc.l	0
DecodedBuffer:
	dc.l	0
Shift:
	dc.l	0
diskkey:
	dc.l	0
sectorcount:
	dc.l	0
dectrack:
;;	blk.b	$1900,0
rawtrack:
;;	incbin	"rob.raw"

synctrack:
	blk.w	RESYNC_LEN+$100,0
