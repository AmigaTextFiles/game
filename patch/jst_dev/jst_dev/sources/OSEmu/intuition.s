* $Id: intuition.s 1.1 1999/02/03 04:10:30 jotd Exp jotd $
**************************************************************************
*   INTUITION-LIBRARY                                                    *
**************************************************************************
**************************************************************************
*   INITIALIZATION                                                       *
**************************************************************************

REMEMBER_SIZE = $4000	; 16K (2000 allocations)

INTUIINIT	move.l	_intbase,d0
		beq	.init
		rts

.init		move.l	#-_LVOBltBitMapRastPort,d0
		move.l	#242,d1
		lea	_intname,a0
		bsr	_InitLibrary
		move.l	d0,a0
		move.l	d0,_intbase
		
		patch	_LVOCloseWorkBench(a0),CLOSEWB(pc)
		patch	_LVOClearDMRequest(A0),MYRTZ(PC)
		patch	_LVOOpenWindow(A0),_OPENWINDOW(PC)
		patch	_LVOCloseWindow(A0),_CLOSEWINDOW(PC)
		patch	_LVOCloseScreen(A0),MYRTS(PC)		; -- added by JOTD
		patch	_LVOShowTitle(A0),MYRTS(PC)		; -- added by JOTD
		patch	_LVOClearPointer(A0),MYRTS(PC)		; -- added by JOTD
		patch	_LVOClearMenuStrip(A0),MYRTS(PC)	; -- added by JOTD
		patch	_LVOOpenWorkBench(A0),_OPENWB(PC)	; -- added by JOTD
		patch	_LVOAlohaWorkbench(A0),MYRTS(PC)	; -- added by JOTD
		patch	_LVORethinkDisplay(A0),MYRTS(PC)	; -- added by JOTD
		patch	_LVORemakeDisplay(A0),MYRTS(PC)		; -- added by JOTD
		patch	_LVOCurrentTime(A0),_CURRENTTIME(PC)	; -- added by JOTD
		patch	_LVOGetPrefs(A0),_GETPREFS(PC)		; -- added by JOTD
		patch	_LVOSetPrefs(A0),_SETPREFS(PC)		; -- dummy, JOTD
		patch	_LVOOpenScreen(A0),_OPENSCREEN(PC)	; -- dummy, JOTD
;		patch	_LVOSetPointer(A0),_SETPOINTER(PC)	; -- dummy, JOTD
		patch	_LVOLockIBase(A0),_LOCKIBASE(PC)
		patch	_LVOAllocRemember(A0),_ALLOCREMEMBER(PC)
		patch	_LVOFreeRemember(A0),_FREEREMEMBER(PC)

		movem.l	D0-A6,-(A7)

		; allocate memory for AllocRemember/FreeRemember functions
		; added by JOTD

		move.l	#REMEMBER_SIZE,D0
		move.l	#MEMF_CLEAR,D1
		bsr	ALLOCM
		move.l	D0,REMEMBER_TABLE
		beq.b	.fail		; could not allocate the memory!

		add.l	#REMEMBER_SIZE,D0
		move.l	D0,REMEMBER_TOP

		movem.l	(A7)+,D0-A6
		rts

.fail		pea	_LVOOpenLibrary
		pea	_execname
		bra	_emufail
	
**************************************************************************
*   SCREEN FUNCTIONS                                                     *
**************************************************************************

_SETPOINTER:
	rts

_OPENSCREEN:
	move.l	A0,D0	; returns user pointer (dummy function!)
	rts

_OPENWB:
	moveq.l	#1,D0	; non-NULL
	rts

ISCLOSED
	dc.l	0	; added by JOTD

;since there is no workbench, closing should awlays return 0 for success
;but some programs loop until the routine returns false (ok the wb is closed)

CLOSEWB
	movem.l	A0,-(A7)
	lea	ISCLOSED(pc),A0
	move.l	(A0),D0		; first time returns 0, and 1 afterwards
	move.l	#1,(A0)
	movem.l	(A7)+,A0
	RTS

_SETPREFS:
	move.l	A0,D0	
	rts

; < A0: PrefBuffer
; < D0: Size
; > D0: returns PrefBuffer

_GETPREFS
	lea	prefsdata(pc),A1
	move.l	D0,D1
	move.l	D0,A0
	subq.l	#1,D1
.copy
	move.b	(A1)+,(A0)+
	dbf	D1,.copy
	rts

_OPENWINDOW	MOVE.L	A0,-(A7)
		MOVE.L	#$84,D0
		MOVEQ.L	#0,D1
		BSR.W	ALLOCM
		MOVE.L	D0,A1
		MOVE.L	(A7)+,A0
		MOVE.L	(A0),wd_LeftEdge(A1)
		MOVE.L	nw_Width(A0),wd_Width(A1)
		MOVE.W	nw_DetailPen(A0),wd_DetailPen(A1)
		MOVE.L	nw_IDCMPFlags(A0),wd_IDCMPFlags(A1)
		MOVE.L	nw_Flags(A0),wd_Flags(A1)
		MOVE.L	nw_FirstGadget(A0),wd_FirstGadget(A1)
		MOVE.L	nw_CheckMark(A0),wd_CheckMark(A1)
		MOVE.L	nw_Title(A0),wd_Title(A1)
		MOVE.L	nw_Screen(A0),wd_WScreen(A1)
;		MOVE.L	nw_BitMap(A0),wd_	;rastport ignored
		MOVE.L	nw_MinWidth(A0),wd_MinWidth(A1)
		MOVE.L	nw_MaxWidth(A0),wd_MaxWidth(A1)
		RTS

_CLOSEWINDOW	MOVE.L	A0,A1
		MOVE.L	#$84,D0
		BSR.W	FREEM
		RTS

_LOCKIBASE	MOVE.L	#'MYLK',D0
		RTS
		
**************************************************************************
*   ICON-LIBRARY                                                         *
**************************************************************************
**************************************************************************
*   INITIALIZATION                                                       *
**************************************************************************

ILIBINIT	move.l	_ilibbase,d0
		beq	.init
		rts

.init		move.l	#-_LVOBumpRevision,d0
		move.l	#LIB_SIZE,D1
		lea	_ilibname,a0
		bsr	_InitLibrary
		move.l	d0,a0
		move.l	d0,_ilibbase
		
;		patch	_LVOCloseWorkBench(a0),CLOSEWB(pc)

		rts


**************************************************************************
*   LAYERS-LIBRARY                                                       *
**************************************************************************
**************************************************************************
*   INITIALIZATION                                                       *
**************************************************************************

LAYERSINIT	move.l	_laybase,d0
		beq	.init
		rts

.init		move.l	#-_LVOMoveLayerInFrontOf,d0
		move.l	#LIB_SIZE,D1
		lea	_layname,a0
		bsr	_InitLibrary
		move.l	d0,a0
		move.l	d0,_laybase
		
;		patch	_LVOCloseWorkBench(a0),CLOSEWB(pc)

		rts

; mathffp, mathtrans stuff relocated in specific files

_CURRENTTIME:				; added by JOTD
	move.l	sec_timer,(A0)
	move.l	millisec_timer,(A1)
	rts

; AllocRemember (needed by SlamTilt)
;
; A0: struct Remember to allocate
; D0: size
; D1: flags

_ALLOCREMEMBER:
	movem.l	A4-A5,-(A7)

	; search for a spare location (0,xx)
	
	move.l	REMEMBER_TABLE(pc),A4
	move.l	REMEMBER_TOP(pc),A5	

.loop
	tst.l	(A4)
	beq.b	.found

	addq.l	#8,A4		; next
	cmp.l	A5,A4
	bcc.b	.fail		; table full!

.found:

	; store size

	move.l	D0,(4,A4)

	; perform alloc

	move.l	A0,-(A7)
	bsr	ALLOCM
	move.l	(A7)+,A0

	; store allocated pointer

	move.l	D0,(A4)

	tst.l	D0
	beq.b	.exit

	move.l	A4,(A0)	; A0 = struct Remember **
.exit
	movem.l	(A7)+,A4-A5
	rts

.fail		pea	_LVOAllocRemember
		pea	_intname
		bra	_emufail

; <A0: RememberKey
; <D0:= 0: just clear the structure
;     !=0: clear struct & free memory

_FREEREMEMBER:
	cmp.l	#0,A0
	beq.b	.exit	; NULL pointer passed

	move.l	(A0),A0	; pointer on the structure

	; check A0 against bounds

	cmp.l	REMEMBER_TABLE,A0
	bcs.b	.fail
	cmp.l	REMEMBER_TOP,A0
	bcc.b	.fail

	tst.l	D0
	beq.b	.clrstruct

	; free the memory

	move.l	(A0),A1
	move.l	(4,A0),D0

	move.l	A0,-(A7)
	bsr	FREEM
	move.l	(A7)+,A0

.clrstruct

	clr.l	(A0)
	clr.l	(4,A0)

.exit
	rts

.fail		pea	_LVOFreeRemember
		pea	_intname
		bra	_emufail


REMEMBER_TABLE:
	dc.l	0

REMEMBER_TOP:
	dc.l	0

prefsdata:
	incbin	"prefsfile"
	cnop	0,4
