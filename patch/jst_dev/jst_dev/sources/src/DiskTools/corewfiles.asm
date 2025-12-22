; *** Core Design disk utility V1.0
; *** Written by Jean-François Fabre

	include	"libs.i"
	include	"macros.i"

	XREF	_SysBase

	XDEF	_WriteFiles
	XDEF	@WriteFiles


; *** create several files from the disk image
; *** very intricate routine, sorry

; in: A0/stack: diskfile buffer
; out D0: error flag (0=OK)

_WriteFiles:
	move.l	4(A7),A0
@WriteFiles:
	movem.l	D1-A6,-(sp)
	move.l	A0,DiskBuffer

	lea	dosname,A1
	moveq	#0,D0
	move.l	_SysBase,A6
	JSRLIB	OpenLibrary
	move.l	D0,dosbase
	beq	WF_UN_Error

	move.l	DiskBuffer,A0
	lea	$200(A0),A2	; for directory block list, constant

wfloop$:
	tst.b	(A2)
	beq	WF_OK	; end

	; *** get the file size and first sector

	moveq.l	#0,D4
	moveq.l	#0,D5

	move.l	($10,A2),D6	; file size
	move.w	($14,A2),D4	; track
	move.w	($16,A2),D5	; sector

	; ** open the first file

	move.l	A2,D1		; pointer on the file name to create
	lea	($20,A2),A2	; for next time
	move.l	#MODE_NEWFILE,D2
	move.l	dosbase,A6
	movem.l	D1-A6,-(sp)
	JSRLIB	Open		; open a new file
	movem.l	(sp)+,D1-A6
	move.l	D0,FHandle
	beq	WF_CF_Error

loop2$
	; *** get offset for a sector

	bsr	GetOffset
	moveq.l	#0,D4
	moveq.l	#0,D5
	move.w	(A3)+,D4
	move.w	(A3)+,D5	; next track/sector

	move.l	#$1FC,D3	; length if file still to read
	cmp.l	D3,D6
	bcc	writewhole$	
	move.l	D6,D3		; only writes D6 bytes (<$1FC)
writewhole$

	; *** write some data to the file

	move.l	FHandle,D1
	move.l	A3,D2		; buffer
	move.l	dosbase,A6
	movem.l	D1-A6,-(sp)
	JSRLIB	Write
	movem.l	(sp)+,D1-A6

	sub.l	D3,D6		; length remaining to be read
	beq	close$
	bcc	loop2$

	; *** close the file
close$
	move.l	FHandle,D1
	move.l	dosbase,A6
	movem.l	D1-A6,-(sp)
	JSRLIB	Close
	movem.l	(sp)+,D1-A6
	clr.l	FHandle

	bra	wfloop$

WF_OK:
	moveq.l	#0,D0
WF_Exit:
	move.l	dosbase,D1
	beq	fuck$
	move.l	D1,A1
	move.l	_SysBase,A6
	JSRLIB	CloseLibrary
	move.l	#0,dosbase
fuck$
	movem.l	(sp)+,D1-A6
	rts


WF_CF_Error:
	moveq.l	#-1,D0
	bra	WF_Exit

WF_UN_Error:
	moveq.l	#-2,D0
	bra	WF_Exit

WF_DC_Error:
	moveq.l	#-3,D0
	bra	WF_Exit

WF_AM_Error:
	moveq.l	#-5,D0
	bra	WF_Exit

GetOffset:
	move.l	A0,A3
	subq.l	#1,D4		; because we did not rip track 0 (dos boot)
	mulu	#$B,D4		; 1 track = 11 sectors
	add.l	D5,D4
	lsl.l	#8,D4		; * $100
	add.l	D4,D4		; * $200: offset in bytes
	add.l	D4,A3
	rts
	
filesize:
	dc.l	0
DiskBuffer:
	dc.l	0
FHandle:
	dc.l	0
dosbase:
	dc.l	0
dosname:
	dc.b	"dos.library",0
