
		include "exec/types.i"
		include "exec/exec.i"
		include "exec/resident.i"

		section text,CODE

		xref	_geta4
		xref	_Init
		xref	_CoProc

		xdef	_DeviceName
		xdef	_IdString
		xdef	_DUMmySeg

		xref	_DevOpen
		xref	_DevClose
		xref	_DevExpunge
		xref	_DevBeginIO
		xref	_DevAbortIO

		xdef	_TagDevOpen
		xdef	_TagDevClose
		xdef	_TagDevExpunge
		xdef	_TagDevBeginIO
		xdef	_TagDevAbortIO


		moveq.l #0,D0		;   word
		rts			;   word

InitDesc:
		dc.w	RTC_MATCHWORD
		dc.l	InitDesc
		dc.l	EndCode
		dc.b	0		;   not auto-init
		dc.b	2		;   version
		dc.b	NT_DEVICE
		dc.b	0		;   priority
		dc.l	_DeviceName
		dc.l	_IdString
		dc.l	_TagInit
		dc.l	0		;   extra ?
		dc.l	0
		dc.l	0

		dc.w	0		;   word (long align)

		ds.l	0		;   LW align
		dc.l	16
_DUMmySeg:	dc.l	0
		nop
		nop
		jsr	_geta4(pc)
		jmp	_CoProc(PC)

		;   C Interface routines

_TagInit:
		move.l	A4,-(sp)
		move.l	A0,-(sp)
		jsr	_geta4(pc)
		jsr	_Init(pc)
		addq.l	#4,sp
		move.l	(sp)+,A4
		rts

_TagDevOpen:
		move.l	A4,-(sp)
		move.l	D1,-(sp)
		move.l	A1,-(sp)
		move.l	D0,-(sp)
		jsr	_geta4(pc)
		jsr	_DevOpen(pc)
		lea	12(sp),sp
		move.l	(sp)+,A4
		rts

_TagDevExpunge:
		move.l	A4,-(sp)
		jsr	_geta4(pc)
		jsr	_DevExpunge(pc)
		move.l	(sp)+,A4

_TagDevClose:
		move.l	A4,-(sp)
		move.l	A1,-(sp)
		jsr	_geta4(pc)
		jsr	_DevClose(pc)
		addq.l	#4,sp
		move.l	(sp)+,A4
		rts

_TagDevBeginIO:
		move.l	A4,-(sp)
		move.l	A1,-(sp)
		jsr	_geta4(pc)
		jsr	_DevBeginIO(pc)
		addq.l	#4,sp
		move.l	(sp)+,A4
		rts

_TagDevAbortIO:
		move.l	A4,-(sp)
		move.l	A1,-(sp)
		jsr	_geta4(pc)
		jsr	_DevAbortIO(pc)
		addq.l	#4,sp
		move.l	(sp)+,A4
		rts


		section DATA,DATA

_DeviceName:	dc.b	'fmsdisk.device',0
_IdString:	dc.b	'fmsdisk.device 2.0 (16 April 1990)',13,10,0

EndCode:

		END

