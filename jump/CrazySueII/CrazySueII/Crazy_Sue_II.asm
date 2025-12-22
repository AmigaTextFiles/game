; Crazy Sue II loader

	include	whdload.i

_base	SLAVE_HEADER
	dc.w	4,WHDLF_NoError		; whdload version required, flags
	dc.l	$80000,0		; basemem, 0
	dc.w	_Start-_base,0,0	; slave code, dir, dontcache
	dc.b	0,$59			; debugkey, quitkey

_Start	move.l	a0,a6
	lea	sue(pc),a0
	lea	$6000.w,a1		; load Crazy Sue II at $6000
	jsr	resload_LoadFileDecrunch(a6)
	jmp	$9C58			; run Crazy Sue II at $9C58

sue	dc.b	"Crazy_Sue_II.bin",0
