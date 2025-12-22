*
* Sound effects
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* loadSFX(d0.w=soundSetNo)
* playSFX(d0.w=soundNo)
*

	include	"sound.i"
	include	"files.i"
	include	"custom.i"


; sound set format
		rsreset
SSETfile	rs.b	1
SSETvol		rs.b	1
SSETper		rs.w	1
sizeof_SndSet	rs.b	0

	macro	SNDSET
	dc.b	\1,\3
	dc.w	\2
	endm

	macro	SETEND
	dc.b	FIL_NONE,0
	dc.w	0
	endm


; from memory.asm
	xref	alloc_chipmem

; from trackdisk.asm
	xref	td_loadcr
	xref	td_sizecr

; from main.asm
	xref	loaderr
	xref	ovflowerr

; from ptplayer.asm
	xref	mt_soundfx



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	loadSFX
loadSFX:
; Load a set of sound effects into Chip RAM and initialize the sfx table.
; d0.w = sound set number

	movem.l	a2-a3/a5,-(sp)

	; find selected set of sound samples to load
	lea	SoundSets(pc),a2
	tst.w	d0
	bra	.2

.1:	move.b	SSETfile(a2),d1
	lea	sizeof_SndSet(a2),a2
	bpl	.1

	subq.w	#1,d0
.2:	bne	.1

	; load sound samples

	lea	Sounds(a4),a3
	lea	SoundsEnd(a4),a5
	bra	.4

.3:	bsr	td_sizecr
	beq	loaderr
	move.l	d0,d1
	lsr.l	#1,d1
	move.w	d1,SFXlen(a3)

	bsr	alloc_chipmem
	move.l	d0,SFXptr(a3)

	move.l	d0,a0
	moveq	#0,d0
	move.b	SSETfile(a2),d0
	bsr	td_loadcr
	beq	loaderr

	moveq	#0,d0
	move.b	SSETvol(a2),d0
	move.w	d0,SFXvol(a3)
	move.w	SSETper(a2),SFXper(a3)

	lea	sizeof_SndSet(a2),a2
	lea	sizeof_SFX(a3),a3
	cmp.l	a5,a3
	bhs	ovflowerr

.4:	moveq	#0,d0
	move.b	SSETfile(a2),d0
	bpl	.3

	movem.l	(sp)+,a2-a3/a5
	rts


	; Table of sound sets to load into our sfx table.
SoundSets:
	; Intro
	;SNDSET	FIL_SFXMENU,320,64
	SNDSET	FIL_SFXSELECT,320,64
	SETEND
	; World 1..4
	SNDSET	FIL_SFXPLING,320,64
	SNDSET	FIL_SFXCHKPT,320,64
	SNDSET	FIL_SFXSCREAM,320,64
	SNDSET	FIL_SFXSPLASH,320,64
	SNDSET	FIL_SFXHIT,320,64
	SNDSET	FIL_SFXWALL,320,64
	SNDSET	FIL_SFXXLIFE,320,64
	SNDSET	FIL_SFXSELECT,320,64
	SNDSET	FIL_SFXBONUS,320,64
	SETEND


;---------------------------------------------------------------------------
	xdef	playSFX
playSFX:
; Play a sound effects sample on a suitable channel.
; Disable music on this channel until replay is finished.
; d0.w = sound number
; All registers, except d0, are preserved!

	movem.l	d1-d2/a0/a6,-(sp)

	lea	Sounds(a4),a6
	add.w	d0,a6
	move.l	(a6)+,a0
	movem.w	(a6),d0-d2

	lea	CUSTOM,a6		; make sure a6 is CUSTOM
	bsr	mt_soundfx

	movem.l	(sp)+,d1-d2/a0/a6
	rts



	section	__MERGED,bss


	; Sound FX table.
	; Format: ptr, length in words, period, volume.
Sounds:
	ds.b	MAXSOUNDS*sizeof_SFX
SoundsEnd:
