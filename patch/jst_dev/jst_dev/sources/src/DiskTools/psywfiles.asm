; *** Psygnosis disk utilities V1.1
; *** Written by Jean-François Fabre

	include	"libs.i"

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
	lea	$10(A0),A1	; for directory buffer, variable by $10
	lea	$C00(A0),A2	; for directory block list, constant
	moveq.l	#1,D6		; the file counter, starts at 1

	; *** LOOP ON THE FILES
wloop$
	cmp.b	#$FF,(A1)	; no name -> no more files
	beq	WF_OK

	; ** for each file, allocate a buffer to join the
	; ** different file parts

	move.l	$C(A1),D0	; file length
	add.l	#$400,D0	; to be able not to overflow buffer
	move.l	D0,blocksize	; store the size

	movem.l	D1-A6,-(sp)
	move.l	blocksize,D0
	move.l	#MEMF_CLEAR,D1
	move.l	_SysBase,A6
	JSRLIB	AllocMem
	movem.l	(sp)+,D1-A6
	move.l	D0,blockbuffer
	beq	WF_AM_Error
	
	move.l	blockbuffer,A4	; A4: current pointer on the file buffer

	; ** search the block bitmap for relevant blocks

	moveq.l	#0,D3	; block counter
sloop$
	move.b	(A2,D3.W),D4

	cmp.w	#$3FF,D3
	bcs	notend$

	cmp.b	#$FF,D4
	beq	writefile$	; end of block info -> write file please
	bra	WF_DC_Error	; ripped disk corrupt, directory error

notend$
	cmp.b	D6,D4		; block matches our file??
	beq	matchblock$
nextblock$
	addq.l	#1,D3		; next offset
	bra	sloop$

	; *** calculate the real offset and copy the block in the buffer
matchblock$
	move.l	D3,D4		; copy position
	lsl.l	#8,D4		; *256
	lsl.l	#2,D4		; *4   -> *$400
	sub.l	#$3000,D4	; we started from physical track 2
	move.l	DiskBuffer,A3
	add.l	D4,A3

	; ** copies a block in the file buffer

	move.w	#$FF,D5
bcopy$
	move.l	(A3)+,(A4)+
	dbf	D5,bcopy$

	bra	nextblock$

writefile$
	; *** open a new file

	move.l	A1,D1		; pointer on the file name to create
	move.l	#MODE_NEWFILE,D2
	move.l	dosbase,A6
	movem.l	D1-A6,-(sp)
	JSRLIB	Open		; open a new file
	movem.l	(sp)+,D1-A6
	tst.l	D0
	beq	WF_CF_Error

	; *** write the data to the file

	move.l	D0,FHandle
	move.l	D0,D1
	move.l	blockbuffer,D2
	move.l	$C(A1),D3	; file length
	move.l	dosbase,A6
	movem.l	D1-A6,-(sp)
	JSRLIB	Write
	movem.l	(sp)+,D1-A6

	; *** close the file

	move.l	FHandle,D1
	move.l	dosbase,A6
	movem.l	D1-A6,-(sp)
	JSRLIB	Close
	movem.l	(sp)+,D1-A6
	clr.l	FHandle

	bsr	FreeBlockBuffer

	; *** increase the pointer
	; *** and the file counter
nextfile$
	lea	$10(A1),A1
	addq.l	#1,D6
	bra	wloop$
	
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
	bsr	FreeBlockBuffer
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
	
FreeBlockBuffer:
	STORE_REGS
	move.l	blockbuffer,D1
	beq	skip$
	move.l	D1,A1
	move.l	blocksize,D0
	move.l	_SysBase,A6
	JSRLIB	FreeMem
	clr.l	blockbuffer
skip$
	RESTORE_REGS
	rts

blocksize:
	dc.l	0
blockbuffer:
	dc.l	0
DiskBuffer:
	dc.l	0
FHandle:
	dc.l	0
dosbase:
	dc.l	0
dosname:
	dc.b	"dos.library",0
