*
* Display the end sequence of the game.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* $end_sequence()
*

	include	"custom.i"
	include	"display.i"
	include	"view.i"
	include	"files.i"


; screen layout
ENDPIC_Y	equ	0

; space between the picture and the text
ENDTXT_OFFS	equ	4

; end scene music comes from a song inside the title music mod
ENDMUS_SONG	equ	$20
ENDMUS_VOLUME	equ	48

; speed of text intensity modification
DINTENS_TXT	equ	$02


; from memory.asm
	xref	save_chipmem
	xref	restore_chipmem

; from trackdisk.asm
	xref	td_loadcr_chip
	xref	td_motoroff

; from input.asm
	xref	readController

; from main.asm
	xref	set_vertb_irq
	xref	clr_vertb_irq
	xref	color_intensity
	xref	loaderr
	xref	panic

; from display.asm
	xref	display_off
	xref	make_stdviews
	xref	write_clist_colors
	xref	write_clist_wait
	xref	startclist
	xref	View

; from blit.asm
	xref	clear_display
	xref	bltimg

; from font.asm
	xref	load_smallfont
	xref	mfont8_center
	xref	Font8Colors

; from music.asm
	xref	loadMusic
	xref	startMusic
	xref	stopMusic
	xref	musicFadeOut



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	end_sequence
end_sequence:
; Open a new screen, load the end-picture and display a short text.
; Assume the display is already disabled (in exitgame).

	; remember allocated ChipRAM during the end sequence
	bsr	save_chipmem
	move.l	d0,EndSeqChipPtr(a4)

	; reset text line color intensity variables
	move.w	#STORY_LINES,TxtCnt(a4)
	clr.w	TxtIntens(a4)
	move.w	#VSTART,TxtDimPos(a4)	; hmm...

	clr.w	FadeOut(a4)		; no music fade-out yet
	clr.b	ButtonPressed(a4)
	clr.b	Quit(a4)


	;---------------------
	; Load end scene data.
	;---------------------

	; first load the music
	moveq	#FIL_MODMENU,d0
	bsr	loadMusic

	; and start playing
	moveq	#ENDMUS_SONG,d0
	moveq	#ENDMUS_VOLUME,d1
	bsr	startMusic

	; load 8px font
	bsr	load_smallfont

	; Load the picture.
	; WARNING: It is assumed to have a width, which is a multiple
	; of 16, and is preceded by a header.
	moveq	#FIL_ENDPIC,d0
	bsr	td_loadcr_chip
	move.l	d0,EndSeqPicture(a4)
	beq	loaderr
	move.l	d0,a3			; a3 picture header

	; now the disk motor can be turned off
	bsr	td_motoroff


	;------------------
	; Init the display.
	;------------------

	; set up the display
	lea	endseq_clist(pc),a0
	bsr	make_stdviews

	; We are using the first View. No double buffering.
	move.l	View(a4),a5
	bsr	clear_display

	; blit the picture
	move.w	(a3)+,d2		; width
	move.w	#DISPW,d0
	sub.w	d2,d0
	asr.w	#1,d0			; center it horizontally
	moveq	#ENDPIC_Y,d7
	move.w	d7,d1
	asr.w	#4,d2			; width in words
	move.w	(a3)+,d3		; height
	add.w	d3,d7
	lea	64(a3),a0		; skip color table to image data
	bsr	bltimg

	; print the story text
	addq.w	#ENDTXT_OFFS,d7
	cmp.w	#DISPH-8*STORY_LINES,d7
	bhi	pic_too_high		; not enough room for the story
	moveq	#VSTART-1,d0
	add.w	d7,d0
	move.w	d0,TxtDimPos(a4)	; set first VPOS for dimmed colors

	lea	EndTexts(a4),a2
	bra	.2

.1:	move.l	d0,a0
	move.w	d7,d1
	bsr	mfont8_center
	addq.w	#8,d7
.2:	move.l	(a2)+,d0
	bne	.1

	; Now start the display DMA.
	bsr	startclist


	;------------------------
	; Animate story in VERTB.
	;------------------------

	lea	endseq_anim(pc),a0
	bsr	set_vertb_irq

.loop:
	tst.b	Quit(a4)
	beq	.loop


	;---------
	; Cleanup.
	;---------

	bsr	display_off
	bsr	clr_vertb_irq
	bsr	stopMusic

	move.l	EndSeqChipPtr(a4),a0
	bra	restore_chipmem


pic_too_high:
	move.w	#$963,d0		; brown: picture is too high
	bra	panic


;---------------------------------------------------------------------------
endseq_clist:
; Append color tables for the picture and the text part to the
; standard copper list.
; a0 = copper list pointer
; a5 = View
; -> a0 = new copperlist pointer

	movem.l	d2/a2,-(sp)
	moveq	#0,d2			; WAIT $100 flag for write_clist_wait

	; display on
	move.l	#BPLCON0<<16|PLANES<<12|$200,(a0)+

	; set picture colors at top of frame
	move.l	EndSeqPicture(a4),a2
	lea	4(a2),a1
	bsr	write_clist_colors

	; set text colors below the picture
	moveq	#VSTART+ENDPIC_Y,d0
	add.w	2(a2),d0
	bsr	write_clist_wait
	tst.w	d2
	bne	pic_too_high

	lea	Font8Colors(a4),a1
	bsr	write_clist_colors

	bsr	update_clist		; update dimmed text colors

	movem.l	(sp)+,d2/a2
	rts


;---------------------------------------------------------------------------
endseq_anim:
; Animate the end sequence. Wait for button.
; Running in VERTB interrupt.
; a4 = SmallData base
; a6 = CUSTOM

	;-------------------------------------------------
	; Update copper list and set new text intensities.
	;-------------------------------------------------

	move.l	View(a4),a5
	bsr	update_clist

	tst.w	TxtCnt(a4)
	beq	.update_volume		; all rows already at full intensity

	moveq	#DINTENS_TXT,d0
	add.w	TxtIntens(a4),d0
	cmp.w	#$ff,d0
	blo	.1

	; full intensity of current row reached, proceed to next row
	moveq	#0,d0
	addq.w	#8,TxtDimPos(a4)
	subq.w	#1,TxtCnt(a4)

.1:	move.w	d0,TxtIntens(a4)

	;--------------------------------
	; Update background music volume.
	;--------------------------------

.update_volume:
	tst.w	FadeOut(a4)
	beq	.check_button

	; music fade out
	move.l	#$08000,d0
	bsr	musicFadeOut

	subq.w	#1,FadeOut(a4)
	seq	Quit(a4)		; quit end-sequence when music is gone
	rts

	;-----------------
	; Wait for button.
	;-----------------

.check_button:
	; handle the joystick button
	moveq	#1,d0
	bsr	readController
	tst.l	d0
	bpl	.released

	; button pressed
	bset	#0,ButtonPressed(a4)
	rts

.released:
	bclr	#0,ButtonPressed(a4)
	beq	.9
	
	; button was pressed before: start music fade-out
	move.w	#2*ENDMUS_VOLUME,FadeOut(a4)

.9:	rts


;---------------------------------------------------------------------------
update_clist:
; Update the WAIT instruction and the dimmed text colors.
; a5 = View

	movem.l	d2-d7/a2-a3,-(sp)
	moveq	#0,d2			; WAIT >=$100 flag

	move.l	Vclist(a5),a0
	lea	ECl_text(a0),a0

	; wait for position with dimmed text colors
	move.w	TxtDimPos(a4),d0
	bsr	write_clist_wait
	move.l	a0,a2

	; calculate and write dimmed text colors
	lea	Font8Colors+2(a4),a3
	moveq	#-$10,d4
	and.w	TxtIntens(a4),d4
	move.w	#COLOR01,d5
	moveq	#NCOLORS-2,d6
	move.w	d2,d7			; save flag before color_intensity

.1:	move.w	d5,(a2)+
	addq.w	#2,d5
	move.w	(a3)+,d0
	move.w	d4,d1
	bsr	color_intensity
	move.w	d0,(a2)+
	dbf	d6,.1

	; wait for the end of this text row and switch the display off
	move.l	a2,a0
	move.w	TxtDimPos(a4),d0
	addq.w	#8,d0
	move.w	d7,d2			; restore $100 flag for WAIT
	bsr	write_clist_wait

	move.l	#BPLCON0<<16,(a0)+	; display off

	moveq	#-2,d0
	move.l	d0,(a0)			; end of copper list

	movem.l	(sp)+,d2-d7/a2-a3
	rts



	data


	;        0.........1.........2.........3.........
EndTxt1:
	dc.b	"CONGRATULATIONS! DURING HIS JOURNEYS",0
EndTxt2:
	dc.b	"JOHN HAD FACED MANY ADVENTURES AND NOTED",0
EndTxt3:
	dc.b	"DOWN EVERYTHING HE FOUND OUT. HE BECAME",0
EndTxt4:
	dc.b	"CONVINCED THAT THERE WAS IN FACT A",0
EndTxt5:
	dc.b	"SECRET SOCIETY CONTROLLING THE FATE OF",0
EndTxt6:
	dc.b	"MANKIND, AND NOW HE COULD PROVE IT! HOW",0
EndTxt7:
	dc.b	"WOULD PEOPLE REACT TO THIS REVELATION?",0
EndTxt8:
	dc.b	"JOHN SHUDDERED, FEELING OBSERVED ALL OF",0
EndTxt9:
	dc.b	"A SUDDEN. OR DO THE OTHERS ALREADY KNOW?",0



	section	__MERGED,data


	; text pointers
EndTexts:
	dc.l	EndTxt1,EndTxt2,EndTxt3,EndTxt4,EndTxt5
	dc.l	EndTxt6,EndTxt7,EndTxt8,EndTxt9
STORY_LINES	equ	(*-EndTexts)>>2
	dc.l	0



	section	__MERGED,bss


	; Remember the base Chip RAM address for all data loaded by
	; the end sequence. So it can be deallocated on exit.
EndSeqChipPtr:
	ds.l	1

	; Pointer to the world picture's header. Format:
	; 0: width
	; 2: height
	; 4: color map (32 RGB4 color entries)
	; 68: interleaved picture data
EndSeqPicture:
	ds.l	1

	; VPOS of next text row to fade in
TxtDimPos:
	ds.w	1

	; number text lines left to fade in
TxtCnt:
	ds.w	1

	; current intensity level of this text line
TxtIntens:
	ds.w	1

	; frames to fade out the music after pressing the button
FadeOut:
	ds.w	1

	; button handling and quit flag
ButtonPressed:
	ds.b	1
Quit:
	ds.b	1
