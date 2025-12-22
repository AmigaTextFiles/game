; Wibble World Giddy © 1993 Phil Ruston
; loader by Kyzer

	include	whdload.i
	include	whdmacros.i

base	SLAVE_HEADER
	dc.w	6,WHDLF_Disk!WHDLF_NoError
	dc.l	$80000,0		; basemem, 0
	dc.w	start-base,0,0		; slave code, dir, dontcache
	dc.b	0,$59			; debugkey, quitkey

start	move.l	a0,a2

	lea	$14a00,a0
	move.l	#8*512,d0
	move.l	#$5b600,d1
	moveq	#1,d2
	jsr	resload_DiskLoad(a2)	; load game data: $14a00-$70000
	lea	$70000,a0
	move.l	a0,a3
	move.l	#739*512,d0
	move.l	#$fc00,d1
	moveq	#1,d2
	jsr	resload_DiskLoad(a2)	; load game code: $70000-$7fc00

	move.w	#$83c0,$dff096		; setclr!master!raster!copper!blitter
	skip	4,$18(a3)		; remove disk init
	skip	4,$2e(a3)		; remove disk load
	jsr	resload_FlushCache(a2)
	jmp	(a3)			; run the game
