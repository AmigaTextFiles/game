*
* Plays the introduction sequence.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* intro()
*

	include	"custom.i"
	include	"display.i"
	include	"view.i"
	include	"font.i"
	include	"intro.i"
	include	"files.i"

; from memory.asm
	xref	save_chipmem
	xref	restore_chipmem

; from trackdisk.asm
	xref	td_loadcr_chip

; from input.asm
	xref	readController
	xref	getkey
	xref	clearkeys

; from display.asm
	xref	make_stdviews
	xref	write_clist_colors
	xref	write_clist_wait
	xref	copy_colors
	xref	startclist
	xref	switchView
	xref	copyView
	xref	waitvertb
	xref	View

; from main.asm
	xref	set_vertb_irq
	xref	clr_vertb_irq
	xref	color_intensity

; from menu.asm
	xref	PressButtonTxt
	xref	PressButtonX

; from blit.asm
	xref	clear_display
	xref	bltimg

; from font.asm
	xref	load_smallfont
	xref	mfont8_print
	xref	Font8Colors

; from music.asm
	xref	loadMusic
	xref	startMusic
	xref	stopMusic
	xref	musicFadeOut



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	intro
intro:
; Show the introduction as a sequence of pictures with text.

	; remember allocated ChipRAM during the intro
	bsr	save_chipmem
	move.l	d0,IntroChipPtr(a4)


	;-----------------------------------
	; Load the intro music and 8px font.
	;-----------------------------------

	moveq	#FIL_MODINTRO,d0
	bsr	loadMusic

	; play the music as early as possible
	moveq	#INTROMUS_SONG,d0
	moveq	#INTROMUS_VOLUME,d1
	bsr	startMusic

	bsr	load_smallfont


	;--------------------
	; Set up the display.
	;--------------------

	lea	intro_clist(pc),a0
	bsr	make_stdviews

	move.l	View(a4),a5
	bsr	init_view
	move.l	a5,d5			; d5 visible view
	move.l	View+4(a4),a5		; a5 background view
	bsr	init_view

	move.l	d5,VisView(a4)		; visible View for VERTB routine
	clr.w	Scene(a4)
	clr.b	PressButton(a4)

	; purge key buffer
	bsr	clearkeys

	; Show the first view.
	bsr	startclist

	; animate the introduction scenes during VERTB
	lea	anim_intro(pc),a0
	bsr	set_vertb_irq


	;--------------------------------
	; Show one scene after the other.
	;--------------------------------

	move.l	IntroDataPtr(a4),a3

intro_loop:
	; The scenes are stored in interleaved format, but with a
	; header containing the picture's width, height and color map.
	; WARNING: Pictures are assumed to have a width, which is a
	; multiple of 16!
	; 0: width
	; 2: height
	; 4: color map (32 RGB4 color entries)
	; 68: data

	bsr	clear_display

	; load next picture into a temporary ChipRAM buffer
	bsr	save_chipmem
	move.l	d0,d4
	moveq	#0,d0
	move.b	(a3)+,d0
	bmi	tmp_dealloc		; no more picture to load
	bsr	td_loadcr_chip
	move.l	d0,a2

	; Remember width and height.
	movem.w	(a2)+,d2-d3

	; Remember color table
	move.l	a2,a0
	lea	Vscncolors(a5),a1
	bsr	copy_colors

	; Write color map into the View's copper list.
	move.l	Vclist(a5),a0
	lea	ICl_colortop(a0),a0
	move.l	a2,a1
	bsr	write_clist_colors

	tst.b	(a3)+
	beq	bottom_text

	; INTROALIGNRIGHT: Picture is full height and aligned to the right.
	; So we start with the text in the middle of the screen. The colors
	; will be the same for the picture and the text.

	move.l	a2,a0
	bsr	set_text_colors

	move.w	#DISPW,d0
	sub.w	d2,d0
	move.w	#DISPH,d1
	sub.w	d3,d1
	asr.w	#1,d1

	moveq	#DISPH/2,d6		; d6 start of text section
	bra	draw_pic

bottom_text:
	; Center the picture at the top of the screen. The text will
	; start directly below it.

	lea	Font8Colors(a4),a0
	bsr	set_text_colors

	move.w	#DISPW,d0
	sub.w	d2,d0
	asr.w	#1,d0
	moveq	#0,d1

	move.w	d3,d6
	addq.w	#MENUFONT8H,d6
	and.w	#-MENUFONT8H,d6		; d6 start of text section

draw_pic:
	lea	64(a2),a0		; interleaved picture data
	asr.w	#4,d2			; width in words (see WARNING above)
	bsr	bltimg

	; set raster line for text colors
	moveq	#VSTART-1,d0
	add.w	d6,d0
	move.w	d0,Vtxtvstart(a5)

	; Text color intensity of the new picture is 0.
	; Also do not yet show "press button" on the new scene.
	clr.w	Vtxtintens(a5)
	clr.w	Vbtnintens(a5)

tmp_dealloc:
	; deallocate the temporary picture buffer
	move.l	d4,a0
	bsr	restore_chipmem

	; Draw the scene's text from IntroData, starting at ypos d6.
	; Each line is terminated by zero. A second zero ends the text.

	bra	next_txt_line

draw_txt_line:
	moveq	#0,d0
	move.w	d6,d1
	bsr	mfont8_print

	; trace to start of next line
.1:	tst.b	(a3)+
	bne	.1

	; set ypos to next row
	addq.w	#MENUFONT8H,d6

next_txt_line:
	move.l	a3,a0
	tst.b	(a3)+			; no more lines?
	bne	draw_txt_line

	; Draw Press Button into the last row.
	move.w	#PressButtonX,d0
	move.w	#DISPH-MENUFONT8H,d1
	lea	PressButtonTxt(pc),a0
	bsr	mfont8_print

	; New scene is ready to display.
	move.w	Scene(a4),d6
	beq	next_scene		; no need to wait at first scene

	; Tell the VERTB-routine to show/animate "press button"
	move.l	d5,a0
	move.w	#BTN_MIN_INTENS,Vbtnintens(a0)
	st	PressButton(a4)

	; Wait for the button to be pressed and released.
	; Pressing the ESC key will quit the whole introduction
	; immediately.
	moveq	#0,d2

.1:	bsr	waitvertb

	; get next key from the queue while interrupts are disabled
	move.w	#$4000,INTENA(a6)
	bsr	getkey
	move.w	#$c000,INTENA(a6)
	cmp.b	#27,d0			; ESC
	beq	intro_cleanup

	moveq	#1,d0
	bsr	readController
	tst.l	d0
	bmi	.2
	tst.b	d2
	beq	.1
	bra	next_scene
.2:	moveq	#-1,d2
	bra	.1

next_scene:
	clr.b	PressButton(a4)

	addq.w	#1,d6
	cmp.w	#NUM_SCENES,d6
	bhi	intro_cleanup

	; switch the Views, to make the new scene visible in the next frame
	move.w	#$4000,INTENA(a6)
	move.w	d6,Scene(a4)
	bsr	switchView
	exg	d5,a5
	move.l	d5,VisView(a4)
	move.w	#$c000,INTENA(a6)

	bsr	waitvertb		; wait until display changed
	bra	intro_loop


	;-----------------------------------------------------
	; Set up a VERTB routine which fades colors and music.
	;-----------------------------------------------------

intro_cleanup:
	bsr	clr_vertb_irq

	; copy bitmap and colors from the visible View
	move.l	d5,a2
	lea	Vscncolors(a2),a0
	lea	Vscncolors(a5),a1
	bsr	copy_colors
	lea	Vdimcolors(a2),a0
	lea	Vtxtcolors(a5),a1
	bsr	copy_colors
	lea	Vdimcolors(a2),a0
	lea	Vtxtcolors(a2),a1
	bsr	copy_colors
	move.w	Vtxtvstart(a2),Vtxtvstart(a5)
	bsr	copyView

	st	FadeLevel(a4)

	lea	fade_intro(pc),a0
	bsr	set_vertb_irq

	; Wait until intro has faded away.
	; VERTB routine slowly descreses FadeLevel to zero.
.1:	tst.b	FadeLevel(a4)
	bne	.1


	;-------------------------
	; Cleanup. Return to main.
	;-------------------------

	; cleanup
	bsr	clr_vertb_irq
	bsr	stopMusic

	move.l	IntroChipPtr(a4),a0
	bra	restore_chipmem


;---------------------------------------------------------------------------
anim_intro:
; Animate colors of the visible View (VisView).
; Running in VERTB interrupt.
; a4 = SmallData base
; a6 = CUSTOM

	tst.w	Scene(a4)
	beq	.exit			; do nothing while loading 1st scene

	move.l	VisView(a4),a5

	; d5 maximum intensity
	; d7 bitmap of color registers, used for the font
	move.w	#$ff,d5
	move.l	#1<<MFONT8_COLOR1|1<<MFONT8_COLOR2|1<<MFONT8_COLOR3,d7

	; increase text intensities until 100% ($ff)
	move.w	Vtxtintens(a5),d4
	addq.w	#DINTENS_TEXT,d4
	cmp.w	d5,d4
	bls	.1
	move.w	d5,d4
.1:	move.w	d4,Vtxtintens(a5)

	lea	Vdimcolors(a5),a3
	bsr	.do_intensity

	; pulse color intensities of the "press button" text
	move.w	Vbtnintens(a5),d4
	tst.b	PressButton(a4)
	beq	.5
	add.w	Vbtndeltaintens(a5),d4
	cmp.w	#$ff,d4
	blo	.2
	move.w	#$ff,d4
	bra	.3
.2:	cmp.w	#BTN_MIN_INTENS,d4
	bhs	.4
	move.w	#BTN_MIN_INTENS,d4
.3:	neg.w	Vbtndeltaintens(a5)
.4:	move.w	d4,Vbtnintens(a5)

	; calculate new BtnColors based on pulsed intensity
.5:	lea	Vbtncolors(a5),a3
	bsr	.do_intensity

	; update colors in visible View's copper list
	move.l	Vclist(a5),a0
	lea	ICl_waitmid(a0),a0
	bra	update_clist


.do_intensity:
	; apply the intensity on text colors only
	and.w	#$f0,d4
	lea	Vtxtcolors(a5),a2
	moveq	#0,d6

.6:	move.w	(a2)+,d0
	btst	d6,d7
	beq	.7
	move.w	d4,d1
	bsr	color_intensity
.7:	move.w	d0,(a3)+
	addq.w	#1,d6
	cmp.w	#NCOLORS,d6
	bne	.6
.exit:
	rts


;---------------------------------------------------------------------------
fade_intro:
; Fade colors and music volume.
; Running in VERTB interrupt.
; a4 = SmallData base
; a6 = CUSTOM

	bsr	switchView
	move.l	a0,a5			; a5 background View

	; fade music volume
	move.l	#$10000,d0
	bsr	musicFadeOut

	; fade color intensity
	moveq	#0,d4
	move.b	FadeLevel(a4),d4
	subq.w	#DINTENS_EXIT,d4
	bpl	.1
	moveq	#0,d4
.1:	move.b	d4,FadeLevel(a4)
	and.w	#$f0,d4

	; calculate new text colors, hide "press button"
	lea	Vtxtcolors(a5),a2
	lea	Vdimcolors(a5),a3
	moveq	#NCOLORS-1,d5
.2:	clr.w	Vbtncolors-Vdimcolors(a3)
	move.w	(a2)+,d0
	move.w	d4,d1
	bsr	color_intensity
	move.w	d0,(a3)+
	dbf	d5,.2

	; write new picture color intensities on top of display
	lea	Vscncolors(a5),a2
	move.l	Vclist(a5),a0
	lea	ICl_colortop+2(a0),a3
	moveq	#NCOLORS-1,d5
.3:	move.w	(a2)+,d0
	move.w	d4,d1
	bsr	color_intensity
	move.w	d0,(a3)
	addq.l	#4,a3
	dbf	d5,.3

	; write text colors to copper list
	lea	-2(a3),a0
	bra	update_clist


;---------------------------------------------------------------------------
intro_clist:
; Write dynamic part of intro copper list at ICl_colortop.
; 1. Load 32 color registers for the picture.
; 2. Wait for start of text-section, load 32 text colors
; 3. Wait for row before "press button", load 32 text colors
; a0 = copper list pointer at ICl_colortop
; a5 = View
; -> a0 = new copperlist pointer

	; The View is cleared, so Vdimcolors contains all black.
	lea	Vdimcolors(a5),a1
	bsr	write_clist_colors


;---------------------------------------------------------------------------
update_clist:
; Update colors for text and "press button".
; a0 = copper list pointer at ICl_waitmid
; a5 = View
; -> a0 = new copperlist pointer

	move.l	d2,-(sp)
	moveq	#0,d2			; flag for "vpos $100 passed"

	; set colors for text section
	move.w	Vtxtvstart(a5),d0
	bsr	write_clist_wait
	lea	Vdimcolors(a5),a1
	bsr	write_clist_colors

	; set colors for "press button"
	move.w	#VSTART+DISPH-(MENUFONT8H+1),d0
	bsr	write_clist_wait
	lea	Vbtncolors(a5),a1
	bsr	write_clist_colors

	; end of copper list
	moveq	#-2,d0
	move.l	d0,(a0)+

	move.l	(sp)+,d2
	rts


;---------------------------------------------------------------------------
set_text_colors:
; Copy NCOLORS colors to the View's Vtxtcolors.
; a0 = color map to copy
; a5 = View

	lea	Vtxtcolors(a5),a1
	bra	copy_colors


;---------------------------------------------------------------------------
init_view:
; Initialize the View, clear the bitmap.
; a5 = View

	move.w	#VSTART+DISPH/2,Vtxtvstart(a5)

	; set initial color intensities (we start with 0)
	clr.w	Vtxtintens(a5)
	clr.w	Vbtnintens(a5)
	move.w	#DINTENS_BUTTON,Vbtndeltaintens(a5)

	; clear the View's visible bitmap
	bra	clear_display



	section	__MERGED,data


IntroDataPtr:
	dc.l	IntroData



	section	__MERGED,bss


	; Remember the base Chip RAM address for all data loaded by
	; the intro. So it can be deallocated on exit.
IntroChipPtr:
	ds.l	1

	; Pointer to the currently visible view. The VERTB routine
	; will manipulate colors in its copper list.
VisView:
	ds.l	1

	; Current scene to display and to animate.
Scene:
	ds.w	1

	; Blinking "press button" text, when set to true
PressButton:
	ds.b	1

	; Color intensity level when fading out the intro.
FadeLevel:
	ds.b	1
	even



	data

	; Introduction pictures to load, flags and scene texts.
	;        ..........1.........2.........3.........
IntroData:
	dc.b	FIL_INTROSCENE1,0
	dc.b	"A LETTER FROM LORD JOFFREY MONTGOMERY",0
	dc.b	"WAS NOTHING SPECIAL AS SUCH.",0	
	dc.b	"NOT EVEN WHEN HIS MENTOR HADN'T",0
	dc.b	"CONTACTED HIM FOR SEVERAL YEARS.",0
	dc.b	"YET THE LETTER, WHICH HE WAS NOW HOLDING",0
	dc.b	"IN HIS HANDS, ALARMED HIM:",0,0

	dc.b	FIL_INTROSCENE2,0
	dc.b	"MY DEAR DOCTOR KAYLE,",0
	dc.b	"FORGIVE ME FOR NOT GETTING IN TOUCH FOR",0
	dc.b	"SUCH A LONG TIME, BUT RIGHT NOW I AM",0
	dc.b	"WORKING ON A RESEARCH PROJECT I NEED",0
	dc.b	"YOUR HELP WITH. I DO NOT DARE TO TELL",0
	dc.b	"YOU ABOUT ALL THE DETAILS IN THIS",0
	dc.b	"LETTER. SUFFICE IT TO SAY: I CAME INTO",0
	dc.b	"POSSESSION OF AN ARTEFACT FROM THE AGE",0
	dc.b	"OF THE MAYAS. IT IS AN ARTEFACT OF GREAT",0
	dc.b	"VALUE WHICH REQUIRES FURTHER RESEARCH.",0
	dc.b	"SO I BID YOU TO COME TO MY PROPERTY NEXT",0
	dc.b	"TUESDAY, AT 8 IN THE EVENING.",0
	dc.b	"YOURS SINCERELY, LORD JOFFREY MONTGOMERY",0,0

	dc.b	FIL_INTROSCENE3,0
	dc.b	"AT SAID TIME, HE ARRIVED AT THE MANSION",0
	dc.b	"IN THE SOUTH OF LONDON. THE GATE TO THE",0
	dc.b	"DRIVEWAY STOOD OPEN, SO HE PARKED HIS",0
	dc.b	"CAR ON THE ROAD AND ENTERED LORD",0
	dc.b	"MONTGOMERY'S PROPERTY.",0,0

	dc.b	FIL_INTROSCENE4,INTROALIGNRIGHT
	dc.b	"A SLIGHT FEELING OF",0
	dc.b	"UNEASE CREPT UP HIS",0
	dc.b	"SPINE WHEN HE FOUND",0
	dc.b	"THE FRONT DOOR OPEN.",0
	dc.b	"CAREFULLY HE",0
	dc.b	"APPROACHED THE LORD'S",0
	dc.b	"STUDY.",0
	dc.b	"THE DOOR WAS AJAR.",0
	dc.b	"AS QUIETLY AS HE",0
	dc.b	"COULD, JOHN KAYLE",0
	dc.b	"EDGED THROUGH THE",0
	dc.b	"DOOR.",0,0

	dc.b	FIL_INTROSCENE5,0
	dc.b	"LORD MONTGOMERY SAT IN HIS CHAIR,",0
	dc.b	"HUNCHED OVER HIS DESK. BLOOD HAD FLOWN",0
	dc.b	"ALL OVER THE DOCUMENTS. JOHN RUSHED TO",0
	dc.b	"HIM AND FELT FOR HIS PULSE. HE WAS",0
	dc.b	"STILL ALIVE. WHEN JOHN TOUCHED HIS",0
	dc.b	"SHOULDER, HE OPENED HIS EYES.",0,0

	dc.b	FIL_INTROSCENE6,0
	dc.b	"SO GLAD... YOU CAME. I HOPE IT'S NOT",0
	dc.b	"TOO LATE. THERE WERE MEN. THEY WANTED",0
	dc.b	"THE ARTEFACT. BUT UNTIL NOW, THEY",0
	dc.b	"COULDN'T FIND IT. HURRY! YOU HEAR ME?",0
	dc.b	"STEP THROUGH THE SECRET DOOR IN THAT",0
	dc.b	"WALL, AND FIND THE ARTEFACT BEFORE THE",0
	dc.b	"OTHERS...",0,0

	dc.b	FIL_NONE,0
	even
