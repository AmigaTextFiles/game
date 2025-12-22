*
* MOD music replayer
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* initMusic()
* exitMusic()
* loadMusic(d0.w=fileIndex)
* startMusic(d0.w=songPos, d1.w=masterVol)
* loadChipMusic(d0.w=fileIndex)
* startChipMusic(d0.w=songPos, d1.w=masterVol)
* stopMusic()
* musicFadeIn(d0=volDelta, d1.w=maxVol)
* musicFadeOut(d0=volDelta)
*

	include	"custom.i"


; memory requirements of the tracks of the biggest Protracker MOD file
TRKSPACE	equ	65536


; from os.asm
	xref	AutoVecBase
	xref	PALflag

; from trackdisk.asm
	xref	td_loadcr
	xref	td_loadcr_chip

; from main.asm
	xref	ovflowerr
	xref	loaderr

; from ptplayer.asm
	xref	mt_install_cia
	xref	mt_remove_cia
	xref	mt_Enable
	xref	mt_init
	xref	mt_end
	xref	mt_mastervol



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	initMusic
initMusic:
; Initialize the player, install music interrupt.

	bsr	mt_end

	move.l	AutoVecBase(a4),a0
	move.b	PALflag(a4),d0
	bra	mt_install_cia


;---------------------------------------------------------------------------
	xdef	exitMusic
exitMusic:
; Stop all music, remove the player interrupt.

	bsr	mt_end
	bra	mt_remove_cia


;---------------------------------------------------------------------------
	xdef	loadMusic
loadMusic:
; Load a new music module's samples into Chip RAM and the rest into the
; TrkBuffer. Warning: music from the same buffers must be stopped first!
; Do not start playing it yet.
; d0.w = file index of the track part, samples are in the following file

	move.l	d2,-(sp)
	move.w	d0,d2			; file ID

	; load the track part (song arrangement, sample info, patterns)
	move.l	TrkData(a4),a0
	bsr	td_loadcr
	beq	loaderr
	cmp.l	#TRKSPACE,d0
	bhi	ovflowerr

	; load the samples into Chip RAM
	addq.w	#1,d2
	move.w	d2,d0
	bsr	td_loadcr_chip
	move.l	d0,SmpData(a4)
	beq	loaderr

	move.l	(sp)+,d2
	rts


;---------------------------------------------------------------------------
	xdef	startMusic
startMusic:
; d0.w = song position
; d1.w = master volume

	tst.b	mt_Enable(a4)
	bne	.1			; music is already playing?

	movem.l	d1-d2/a2,-(sp)

	; initialize mod - destroys d2/a2
	move.l	TrkData(a4),a0
	move.l	SmpData(a4),a1
	bsr	mt_init

	; set master volume
	move.l	(sp)+,d0
	move.w	d0,MasterVol(a4)
	clr.w	MasterVol+2(a4)
	bsr	mt_mastervol

	st	mt_Enable(a4)
	movem.l	(sp)+,d2/a2

.1:	rts


;---------------------------------------------------------------------------
	xdef	loadChipMusic
loadChipMusic:
; Stop any running music. Load a new module as a single block into
; Chip RAM. Do not start playing it yet.
; d0.w = file index of module

	bsr	td_loadcr_chip
	move.l	d0,Mod(a4)
	beq	loaderr
	rts


;---------------------------------------------------------------------------
	xdef	startChipMusic
startChipMusic:
; d0.w = song position
; d1.w = master volume

	tst.b	mt_Enable(a4)
	bne	.1			; music is already playing?

	movem.l	d1-d2/a2,-(sp)

	; initialize mod - destroys d2/a2
	move.l	Mod(a4),a0
	sub.l	a1,a1
	bsr	mt_init

	; set master volume
	move.l	(sp)+,d0
	move.w	d0,MasterVol(a4)
	clr.w	MasterVol+2(a4)
	bsr	mt_mastervol

	st	mt_Enable(a4)
	movem.l	(sp)+,d2/a2

.1:	rts


;---------------------------------------------------------------------------
	xdef	stopMusic
stopMusic:
; Stop current music module.

	bra	mt_end


;---------------------------------------------------------------------------
	xdef	musicFadeIn
musicFadeIn:
; Increment music volume by fixedpoint delta.
; d0 = volume delta (16+16 bits fixed point)
; d1 = max volume .w

	move.l	d2,-(sp)

	swap	d1
	clr.w	d1

	move.l	MasterVol(a4),d2
	add.l	d2,d0

	; limit on given max volume
	cmp.l	d1,d0
	ble	.1
	move.l	d1,d0

.1:	move.l	d0,MasterVol(a4)

	; set new master vol, when integer part had changed
	swap	d0
	swap	d2
	cmp.w	d0,d2
	beq	.2
	bsr	mt_mastervol

.2:	move.l	(sp)+,d2
	rts


;---------------------------------------------------------------------------
	xdef	musicFadeOut
musicFadeOut:
; Decrement music volume by fixedpoint delta.
; d0 = volume delta (16+16 bits fixed point)

	move.l	MasterVol(a4),d1
	move.l	d1,a0

	sub.l	d0,d1
	bpl	.1
	moveq	#0,d1			; cannot fall below zero
.1:	move.l	d1,MasterVol(a4)

	; set new master vol, when integer part has changed
	swap	d1
	move.w	d1,d0
	move.l	a0,d1
	swap	d1
	cmp.w	d0,d1
	bne	mt_mastervol
	rts



	bss


TrkBuffer:
	ds.b	TRKSPACE



	section	__MERGED,data


	; tracker module header and patterns
TrkData:
	dc.l	TrkBuffer



	section	__MERGED,bss


	; tracker module sample buffer in Chip RAM, loaded by loadMusic
SmpData:
	ds.l	1

	; pointer to a complete module in Chip RAM, loaded by loadChipMusic
Mod:
	ds.l	1

	; current master volume in 16+16 bits fixed point
MasterVol:
	ds.w	1			; master volume
	ds.w	1			; fraction
