*
* AmigaOS support routines.
* Functions for taking over the system and for restoring the OS and the
* initial hardware state.
*
* d0/Z=ok = openlibs()
* d0/Z=ok = killOS()
* restoreOS()
* d0=handle = openFile(a0=filename, d0=writeFlag)
* d0/Z=error = readFile(d0=handle, d1=numBytes, a0=buffer)
* d0/Z=error = writeFile(d0=handle, d1=numBytes, a0=buffer)
* closeFile(d0=handle)
*
* PALflag
*

	include	"exec/execbase.i"
	include	"exec/libraries.i"
	include	"dos/dos.i"
	include "dos/dosextens.i"
	include "graphics/gfxbase.i"

	include	"custom.i"


; AmigaOS constants
EXECBASE	equ	4

; exec LVOs
Supervisor	equ	-30
Forbid		equ	-132
GetMsg		equ	-372
ReplyMsg	equ	-378
WaitPort	equ	-384
CloseLibrary	equ	-414
OpenLibrary	equ	-552

; dos LVOs
Open		equ	-30
Close		equ	-36
Read		equ	-42
Write		equ	-48

; graphics LVOs
LoadView	equ	-222
WaitBlit	equ	-228
WaitTOF		equ	-270
OwnBlitter	equ	-456
DisownBlitter	equ	-462



	mc68010
	near	a4

	code


;---------------------------------------------------------------------------
	xdef	openlibs
openlibs:
; Open dos.library.
; -> d0/Z = ok

	move.l	(EXECBASE).w,a6
	lea	DOSName(pc),a1
	moveq	#33,d0
	jsr	OpenLibrary(a6)
	move.l	d0,_DOSBase(a4)
	beq	restoreOS

	moveq	#0,d0
	rts


;---------------------------------------------------------------------------
	xdef	killOS
killOS:
; Handle a Workbench startup. Save the auto vector location.
; Turn off AGA and graphics cards and load a NULL view. Lock the blitter.
;
; -> d0/Z = ok

	move.l	(EXECBASE).w,a6
	move.l	ThisTask(a6),a2
	cmp.b	#NT_PROCESS,LN_TYPE(a2)
	bne	.2
	tst.l	pr_CLI(a2)
	bne	.2

	; started from Workbench: get WBStartupMsg
.1:	lea	pr_MsgPort(a2),a0
	jsr	WaitPort(a6)
	lea	pr_MsgPort(a2),a0
	jsr	GetMsg(a6)
	move.l	d0,WBStartupMsg(a4)
	beq	.1

	; get VBR
.2:	moveq	#0,d0
	btst	#AFB_68010,AttnFlags+1(a6)
	beq	.3
	lea	getVBR(pc),a5
	jsr	Supervisor(a6)
.3:	move.l	d0,AutoVecBase(a4)

	; open graphics.library
	lea	GfxName(pc),a1
	moveq	#33,d0
	jsr	OpenLibrary(a6)
	move.l	d0,_GfxBase(a4)
	beq	restoreOS
	move.l	d0,a6

	; save current active view and load a NULL view
	move.l	gb_ActiView(a6),ActiView(a4)
	sub.l	a1,a1
	jsr	LoadView(a6)
	jsr	WaitTOF(a6)
	jsr	WaitTOF(a6)

	; get exclusive blitter access
	jsr	OwnBlitter(a6)
	jsr	WaitBlit(a6)

	; determine PAL/NTSC
	moveq	#0,d0			; BEAMCON0 NTSC
	btst	#PALn,gb_DisplayFlags+1(a6)
	beq	.4
	st	PALflag(a4)
	moveq	#$20,d2			; BEAMCON0 PAL

	; disable AGA/ECS features
.4:	lea	CUSTOM,a6
	move.w	#$0020,BEAMCON0(a6)
	lea	BplconInit(pc),a0
	lea	BPLCON0(a6),a1
	moveq	#7-1,d0
.5:	move.w	(a0)+,(a1)+
	dbf	d0,.5

	; set OCS fetch-mode
	moveq	#0,d0
	move.w	d0,FMODE(a6)
	rts

BplconInit:	; Init. for BPLCON0..4, BPL1/2MOD
	dc.w	$0000,$0000,$0024,$0c00,$0000,$0000,$0011

DOSName:
	dc.b	"dos.library",0

GfxName:
	dc.b	"graphics.library",0
	even


;---------------------------------------------------------------------------
	xdef	restoreOS
restoreOS:
; Restore the OS display, free the blitter, reply a Workbench message.

	lea	CUSTOM,a3
	move.l	(EXECBASE).w,a5
	move.l	_GfxBase(a4),d0
	beq	.1

	; restore system view and release blitter
	move.l	d0,a6
	jsr	WaitBlit(a6)
	move.l	ActiView(a4),a1
	jsr	LoadView(a6)
	jsr	DisownBlitter(a6)
	move.l	gb_copinit(a6),COP1LC(a3)

	; close graphics.library
	move.l	a6,a1
	move.l	a5,a6
	jsr	CloseLibrary(a6)

	; reply WB-message
.1:	move.l	a5,a6
	move.l	WBStartupMsg(a4),d0
	beq	.2
	move.l	d0,a1
	jsr	Forbid(a6)
	jsr	ReplyMsg(a6)

.2:	move.l	_DOSBase(a4),d0
	beq	.3
	move.l	d0,a1
	jsr	CloseLibrary(a6)

.3:	moveq	#1,d0
	rts


getVBR:
	movec	vbr,d0
	rte


;---------------------------------------------------------------------------
	xdef	openFile
openFile:
; a0 = filename
; d0 = write-flag (0=read, 1=write)
; -> d0/Z = handle

	movem.l	d2/a6,-(sp)
	move.l	_DOSBase(a4),a6

	move.l	a0,d1
	move.l	#MODE_OLDFILE,d2
	tst.b	d0
	beq	.1
	addq.l	#1,d2
.1:	jsr	Open(a6)

	movem.l	(sp)+,d2/a6
	rts


;---------------------------------------------------------------------------
	xdef	closeFile
closeFile:
; d0 = handle

	move.l	a6,-(sp)
	move.l	_DOSBase(a4),a6

	move.l	d0,d1
	jsr	Close(a6)

	move.l	(sp)+,a6
	rts


;---------------------------------------------------------------------------
	xdef	readFile
readFile:
; d0 = handle
; d1 = number of bytes to read
; a0 = read buffer
; -> d0/Z = ok

	movem.l	d1-d3/a6,-(sp)
	move.l	_DOSBase(a4),a6

	move.l	d1,d3
	move.l	a0,d2
	move.l	d0,d1
	jsr	Read(a6)

	movem.l	(sp)+,d1-d3/a6
	sub.l	d1,d0
	rts


;---------------------------------------------------------------------------
	xdef	writeFile
writeFile:
; d0 = handle
; d1 = number of bytes to write
; a0 = write buffer
; -> d0/Z = ok

	movem.l	d1-d3/a6,-(sp)
	move.l	_DOSBase(a4),a6

	move.l	d1,d3
	move.l	a0,d2
	move.l	d0,d1
	jsr	Write(a6)

	movem.l	(sp)+,d1-d3/a6
	sub.l	d1,d0
	rts



	section	__MERGED,bss


_DOSBase:
	ds.l	1

_GfxBase:
	ds.l	1

WBStartupMsg:
	ds.l	1

ActiView:
	ds.l	1

	xdef	AutoVecBase
AutoVecBase:
	ds.l	1

	xdef	PALflag
PALflag:
	ds.b	1
	even
