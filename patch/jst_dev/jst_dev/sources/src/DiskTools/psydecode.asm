; *** Psygnosis disk utilities V1.1
; *** Written by Jean-François Fabre

	XDEF	_DecodeTrack
	XDEF	@DecodeTrack


DECODEREG EQUR D6


; ** out D0: <0: error 

; ** C entrypoint


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

; ** assembly entrypoint

_DecodeTrack:
	move.l	4(sp),D0
	move.l	8(sp),A0

@DecodeTrack:
	movem.l	D1-A6,-(sp)

	move.l	A0,A1	; dec
	move.l	D0,A0	; raw

	bsr	GetSync
	tst.l	D0
	bne	syncerr

	move.l	D1,D6	; shift

	MOVE	#$0400,D7
	moveq.l	#0,D1
	subq.l	#2,A0
		
	; *** 6 stages to decode the buffer

decloop
	BSR	DecodeRawData
	TST	D0
	bne	exit
	LEA	$400(A1),A1
	addq.l	#1,D1
	cmp.l	#6,D1
	bne	decloop
	moveq.l	#0,D0
exit:
	MOVEM.L	(A7)+,D1-A6
	RTS

syncerr
	moveq	#-2,D0
	bra	exit

; ** in A1: decoded buffer
;       A0: raw buffer

;       D7: # of bytes to decode
;	D1: part of the track to decode (0-3)

DecodeRawData:
	MOVEM.L	D1/D6-D7/A0-A1,-(A7)
	LEA	2(A0),A0
	MULU	#$0804,D1
	ADDA.L	D1,A0		; offset
	MOVE	D7,-(sp)
	MOVEQ	#2,D7
	BSR	DecodeRawPart	; decode 2 words -> 2 bytes
	MOVE	(A1),D0		; checksum

	MOVE	(sp)+,D7
	BSR	DecodeRawPart	; decode D7 words -> D7 bytes
	CMP	#$0400,D7	; $400 initially asked?
	BNE	DRD_ok		; no -> return without error
	BSR	ChecksumData	; calculates theoric checksum
	SUB	D1,D0		; compares with checksum read
	BEQ	DRD_ok		; ok
	MOVEQ	#-1,D0		; error, wrong checksum
	bra	DRD_exit
DRD_ok
	moveq.l	#0,D0
DRD_exit
	MOVEM.L	(A7)+,D1/D6-D7/A0-A1
	RTS

; *** calculates checksum

; in : A1 pointer on decoded data
; out: D1 checksum

ChecksumData:
	MOVEM.L	D7/A1,-(A7)
	MOVE	#$01FF,D7
	MOVEQ	#0,D1
LAB_0027:
	ADD.W	(A1)+,D1
	DBF	D7,LAB_0027
	MOVEM.L	(A7)+,D7/A1
	RTS

; ** in  A1: decoded data buffer
; **     D7: # of words->bytes to decode

DecodeRawPart:
	MOVEM.L	D0-D7/A1,-(A7)
	LSR	#1,D7
	SUBQ	#1,D7
	MOVE	#$5555,D4
	MOVE	#$AAAA,D5
LAB_003C:
	; ** harry's code

	movem.l	D3-D4,-(sp)
	move.l	(A0)+,D0	; higher part (dest register)
	move.l	(A0),D3
	lsr.l	D6,D3		; shift lower part with count
	moveq	#$20,D4
	sub.l	D6,D4
	lsl.l	D4,D0		;higher part has to be shifted to fill
	or.l	D3,D0		;the rest-place, a longword has 20 bits
	movem.l	(sp)+,D3-D4	

	move.w	D0,D1	; D1: low
	swap	D0		; D0: high

;	MOVE	(A0)+,D0
;	MOVE	(A0)+,D1	; original

	ASL	#1,D0
	AND	D5,D0
	AND	D4,D1
	OR	D1,D0
	MOVE.W	D0,(A1)+
	DBF	D7,LAB_003C
	MOVEM.L	(A7)+,D0-D7/A1
	RTS
	

DiskId
	dc.l	0
nbsectors:
	dc.l	0
worklen:
	dc.l	0
blockbuffer:
	dc.l	0
blocksize:
	dc.l	0
returncode:
	dc.l	0
