; Giddy 2 (public domain version) © 1994 Phil Ruston
; loader by Kyzer

	include	whdload.i
	include	whdmacros.i

base	SLAVE_HEADER
	dc.w	6,WHDLF_Disk!WHDLF_NoError
	dc.l	$100000,0		; basemem, 0
	dc.w	start-base,0,0		; slave code, dir, dontcache
	dc.b	0,$59			; debugkey, quitkey

resload	dc.l	0
start	lea	resload(pc),a1
	move.l	a0,(a1)
	move.l	a0,a2

	lea	$40000,a6
	moveq	#2,d7
	move.l	#40456,d6
	bsr.s	.load			; load intro

	clr.l	8(a6)			; writes to $dff1a0 -> writes to 0
	patch	$fa(a6),.cont		; come back to us after decrunching
	jsr	resload_FlushCache(a2)
	jmp	(a6)			; run decruncher
.cont	lea	$14600,a6
	patch	$3ee(a6),.load		; patch disk loader
	ret	$3c6(a6)		; remove disk init
	move.w	#1,$758(a6)		; skip 'F1 licenseware' logo
	move.l	resload(pc),a2
	jsr	resload_FlushCache(a2)
	jmp	(a6)			; run intro (and game!)

; a6 = load address, d6 = length, d7 = sector
.load	movem.l	d0-d2/a0-a2,-(sp)
	move.l	a6,a0
	move.l	d7,d0
	asl.l	#8,d0
	add.l	d0,d0
	move.l	d6,d1
	moveq	#1,d2
	move.l	resload(pc),a2
	jsr	resload_DiskLoad(a2)	; a0=addr/d0=offset/d1=size/d2=1

	cmp.w	#$fc,d7			; if loading the main game code
	bne.s	.not_main		; .. patch its loading routine
	patch	$3da4(a6),.load		; patch disk loader
	ret	$3d7c(a6)		; remove disk init
	jsr	resload_FlushCache(a2)
.not_main
	moveq	#0,d7
	movem.l	(sp)+,d0-d2/a0-a2
	rts
