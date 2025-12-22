*
* Map illumination routines.
* Changes two reserved colors for a defined period of time to make
* parts of the map visible.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* reset_illumination(a5=View, a0=colortab, d0.w=world)
* Z = start_illumination(a0=mapoffset, d0.b=tilecode, d6.w=xpos, d7.w=ypos)
* $illuminate(a5=View)
*

	include	"display.i"
	include	"view.i"
	include	"map.i"


; from main.asm
	xref	color_intensity

; from tiles.asm
	xref	newSingleTileAnim



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	reset_illumination
reset_illumination:
; World 4 reserves two color registers for illumination. Reset those
; colors to black. They are illuminated for a short period by touching a
; special tile.
; All other worlds simply reset to the normal full intensity color.
; a5 = View
; a0 = Colortable RGB4
; d0.w = World number (1..4)

	move.l	Vclist(a5),a1		; the View's copperlist

	subq.w	#4,d0
	beq	.world4

	; set ILLUMCOLOR1 and ILLUMCOLOR2 to their normal values
	move.w	ILLUMCOLOR1<<1(a0),Cl_illcolors+2(a1)
	move.w	ILLUMCOLOR2<<1(a0),Cl_illcolors+6(a1)

	clr.w	IllumTimer(a4)
	rts

.world4:
	; reset ILLUMCOLOR1 and ILLUMCOLOR2 to black (not illuminated)
	move.w	d0,Cl_illcolors+2(a1)
	move.w	d0,Cl_illcolors+6(a1)

	; remember their normal values
	move.w	ILLUMCOLOR1<<1(a0),IllumColor1(a4)
	move.w	ILLUMCOLOR2<<1(a0),IllumColor2(a4)

	tst.w	IllumTimer(a4)
	beq	.exit

	; Illumination is still active, so we have to abort it and
	; extinguish the torch with a tile animation.
	move.l	d2,-(sp)
	movem.w	IllumXpos(a4),d0-d2
	move.l	IllumMapOff(a4),a0
	bsr	newSingleTileAnim
	move.l	(sp)+,d2

	clr.w	IllumTimer(a4)
.exit:
	rts


;---------------------------------------------------------------------------
	xdef	start_illumination
start_illumination:
; Start the illumination timer. Do a tile animation to ignite the torch.
; a0 = torch tile map offset
; d0.b = torch tile code
; d6.w = tile map xpos
; d7.w = tile map ypos
; -> Z-flag set when ok

	tst.w	IllumTimer(a4)
	bne	.1			; last illumination still running

	move.l	d2,-(sp)

	; Remember tile animation data for the end of illumination.
	moveq	#-1,d2			; allow retrigger
	move.b	d0,d2
	move.w	d6,d0
	move.w	d7,d1
	movem.w	d0-d2,IllumXpos(a4)
	move.l	a0,IllumMapOff(a4)

	; Ignite the torch with a tile animation.
	addq.b	#1,d2			; d2 new tile code: ignited
	bsr	newSingleTileAnim

	; Start illumination timer. Colors will be intensified during
	; this period.
	move.w	#ILLUM_TIME,IllumTimer(a4)

	move.l	(sp)+,d2
	moveq	#0,d0
.1:	rts


;---------------------------------------------------------------------------
	xdef	illuminate
illuminate:
; Illuminate two colors for a period of ILLUM_TIME frames.
; During the first 15 frames the colors are intensified until their final
; RGB values have been reached. The last 16 frames of the period are used
; to fade the two colors to black again.
; The colors are updated in the current View's copperlist.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	move.w	IllumTimer(a4),d0
	bne	.1
	rts

	; get the View's copperlist pointer
.1:	move.l	Vclist(a5),a2

	; load the full intensity value of the two colors
	movem.w	IllumColor1(a4),d4-d5

	; update illumination timer
	subq.w	#1,d0
	move.w	d0,IllumTimer(a4)

	cmp.w	#ILLUM_TIME-16,d0
	bls	.2

	; first phase: intensify the colors
	move.w	#ILLUM_TIME,d6
	sub.w	d0,d6
	bra	.3

.2:	cmp.w	#15,d0
	bhs	.4

	; last phase: fade the colors to black
	move.w	d0,d6
	bne	.3

	; timer reached zero, extinguish the torch with a tile animation
	movem.w	IllumXpos(a4),d0-d2
	move.l	IllumMapOff(a4),a0
	bsr	newSingleTileAnim

	; calculate color intensity
.3:	lsl.w	#4,d6
	move.w	d4,d0
	move.w	d6,d1
	bsr	color_intensity
	move.w	d0,Cl_illcolors+2(a2)	; write first color to copperlist
	move.w	d5,d0
	move.w	d6,d1
	bsr	color_intensity
	move.w	d0,Cl_illcolors+6(a2)	; write second color to copperlist
	rts

	; set full intensity
.4:	move.w	d4,Cl_illcolors+2(a2)	; write first color to copperlist
	move.w	d5,Cl_illcolors+6(a2)	; write second color to copperlist
	rts



	section	__MERGED,bss


	; Timer for illuminating two colors in a map.
IllumTimer:
	ds.w	1

	; Fully illuminated color RGB4 values.
IllumColor1:
	ds.w	1
IllumColor2:
	ds.w	1

	; Animation data for extinguishing the torch tile at the end.
IllumXpos:
	ds.w	1
IllumYpos:
	ds.w	1
IllumTileCode:
	ds.w	1
IllumMapOff:
	ds.l	1
