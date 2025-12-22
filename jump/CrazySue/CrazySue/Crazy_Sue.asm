; Crazy Sue loader by Kyzer/CSG

	include	whdload.i
	include	whdmacros.i

_base	SLAVE_HEADER
	dc.w	4,WHDLF_NoKbd		; whdload version required, flags
	dc.l	$80000,0		; basemem, 0
	dc.w	_Start-_base,0,0	; slave code, dir, dontcache
	dc.b	0,$59			; debugkey, quitkey


_Start	lea	_funcs(pc),a1		; save whdload funcptr
	move.l	a0,(a1)
	move.l	a0,a6

	lea	sue(pc),a0		; load Crazy_Sue.bin to $2000
	lea	$2000.w,a1
	jsr	resload_LoadFileDecrunch(a6)
	tst.l	d1
	beq.s	.ok
	movem.l	a0/d1,-(sp)		; quit on failure to load
	pea	TDREASON_DOSREAD.w
	jmp	resload_Abort(a6)

.ok	lea	hisc(pc),a0
	lea	$15458,a1
	jsr	resload_LoadFile(a6)	; load hiscores file (if exists)
	patch	$1539c,_savehi		; install hiscoresave patch

	jmp	$12000			; run Crazy Sue at $12000


; save hiscores (location: after completion of name entry on hiscore table)
_savehi	movem.l	a0/a1/a6/d0/d1,-(sp)
	lea	hisc(pc),a0
	lea	$15458,a1
	moveq	#100,d0
	move.l	_funcs(pc),a6		; get whdload funcptr
	jsr	resload_SaveFile(a6)	; save hiscores file
	movem.l	(sp)+,a0/a1/a6/d0/d1
	jmp	$153aa			; go back into game


_funcs	dc.l	0
sue	dc.b	"Crazy_Sue.bin",0
hisc	dc.b	"Crazy_Sue.hisc",0
