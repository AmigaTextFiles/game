*
* Game menu, credits, highscores.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* $d0=level = menu()
* loadHiscores()
*

	include	"custom.i"
	include	"display.i"
	include	"view.i"
	include	"sound.i"
	include	"font.i"
	include	"menu.i"
	include	"game.i"
	include	"mob.i"
	include	"files.i"
	include	"macros.i"


; Sparkling Star structure
		rsreset
Smob		rs.b	sizeof_MOB	; MOB structure (position, image)
Sfirstanim	rs.w	1		; first animation frame
Slastanim	rs.w	1		; last animation frame
Sanim		rs.w	1		; current animation frame
Scounter	rs.w	1		; counter for next animation frame
sizeof_Star	rs.b	0


; from memory.asm
	xref	save_chipmem
	xref	restore_chipmem

; from trackdisk.asm
	xref	td_loadcr_chip
	xref	td_read
	ifd	TDWRITE
	xref	td_write
	endif
	ifd	TDFORMAT
	xref	td_format
	endif
	xref	td_motoroff

; from init.asm
	xref	stackcheck

; from input.asm
	xref	readController
	xref	getkey
	xref	clearkeys

; from main.asm
	xref	set_vertb_irq
	xref	clr_vertb_irq
	xref	rand
	xref	loaderr
	xref	panic
	xref	color_scale
	xref	color_intensity
	xref	Button
	xref	UpDown
	xref	LeftRight
	xref	LastKey

; from display.asm
	xref	display_off
	xref	make_stdviews
	xref	write_clist_colors
	xref	write_clist_wait
	xref	startdisplay
	xref	startclist
	xref	switchView
	xref	View

; from tiles.asm
	xref	makeBlkTable

; from bob.asm
	xref	initBOBs
	xref	newBOB
	xref	unlinkBOB
	xref	updateBOBs
	xref	drawBOBs
	xref	undrawBOBs

; from game.asm
	xref	StartLevel
	xref	Level
	xref	Score
	xref	Lives

; from newlevel.asm
	xref	LevelPasswords
	xref	StageStrings

; from blit.asm
	xref	clear_display
	xref	bltclear
	xref	bltcopy

; from font.asm
	xref	load_menufonts
	xref	mfont8_print
	xref	mfont16_print

; from music.asm
	xref	loadMusic
	xref	startMusic
	xref	stopMusic
	xref	musicFadeOut

; from sound.asm
	xref	loadSFX
	xref	playSFX



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	menu
menu:
; Show the game menu.
; -> d0 = game level to play, -1 for introduction

	; remember allocated ChipRAM during the menu
	bsr	save_chipmem
	move.l	d0,MenuChipPtr(a4)

	; Show Loading image, while reading menu data.
	bsr	loading_image


	;----------------------
	; Load all needed data.
	;----------------------

	bsr	loadgfx
	bsr	load_menufonts

	moveq	#FIL_MODMENU,d0
	bsr	loadMusic

	moveq	#SSET_MENU,d0
	bsr	loadSFX

	; now the disk motor can be turned off
	bsr	td_motoroff

	; set initial menu startup phase
	bsr	set_phase_start


	;--------------------
	; Set up the display.
	;--------------------

	bsr	display_off
	bsr	clear_colors

	lea	update_clist(pc),a0
	bsr	make_stdviews

	; init BOB system (for the stars)
	move.l	View(a4),a5
	bsr	initBOBs
	move.l	View+4(a4),a5
	bsr	initBOBs

	; init sparkling stars and their MOBs
	bsr	init_stars

	; initialize menu-specific View-data, draw the logo into both Views
	move.l	View(a4),a5
	bsr	init_view
	move.l	View+4(a4),a5
	bsr	init_view

	; reset status variables
	clr.w	FrameCnt(a4)
	clr.w	LastRank(a4)
	clr.w	LastUp(a4)
	clr.b	LastButton(a4)
	clr.b	Action(a4)
	clr.b	WriteFlag(a4)
	clr.b	QuitMenu(a4)

	; purge key buffer
	bsr	clearkeys
	clr.b	LastKey(a4)


	;----------------------------------------------
	; Start the music, display and the menu engine.
	;----------------------------------------------

	; Check whether last score qualified for high score list.
	bsr	qualifyScore
	move.b	d0,NewHighscore(a4)
	beq	.1

	; New Highscore: play the high score music.
	moveq	#MENUMUS_HISCORE,d0
	SKIPW

	; Play the Solid Gold main menu theme.
.1:	moveq	#MENUMUS_SONG,d0
	moveq	#MENUMUS_VOLUME,d1
	bsr	startMusic

	; Now start the display DMA.
	bsr	startclist

	; Run the menu engine during VERTB interrupt.
	lea	do_menu(pc),a0
	bsr	set_vertb_irq


	;--------------------------------
	; Menu running in vertical blank.
	;--------------------------------

menu_loop:
	ifd	KILLOS
	ifd	DEBUG
	bsr	stackcheck		; check for stack overflow
	endif
	endif

	tst.b	WriteFlag(a4)
	bne	writeHiscores

	tst.b	QuitMenu(a4)
	beq	menu_loop


	;--------------------
	; Menu has been quit.
	;--------------------

	bsr	display_off
	bsr	clr_vertb_irq
	bsr	stopMusic

	move.l	MenuChipPtr(a4),a0
	bsr	restore_chipmem

	moveq	#0,d0
	move.b	Action(a4),d0
	rts				; return to main program loop


	;-------------------------------------------------
	; Write the current high score table back to disk.
	;-------------------------------------------------

writeHiscores:
	move.l	Hiscores(a4),a0

	ifd	TDWRITE
	move.w	#HISCORES_TRACK*11,d0
	moveq	#1,d1
	bsr	td_write
	endif

	ifd	TDFORMAT
	move.w	#HISCORES_TRACK,d0
	bsr	td_format
	endif

	; Ignore any write-errors. There is nothing we can do about it.

	clr.b	WriteFlag(a4)
	bsr	td_motoroff
	bra	menu_loop


;---------------------------------------------------------------------------
loading_image:
; Make a standard display with a disk image, to show that we are now
; loading menu data.
; Registers, except a4 and a6, are not preserved!

	; Load the image. It is preceded by a header of the form:
	; 0: width, 2: height, 4: 32 x RGB4 colors
	moveq	#FIL_LOADING,d0
	bsr	td_loadcr_chip
	beq	loaderr
	move.l	d0,a3			; a3 image header

	; kill old VERTB routines (e.g. for fading the boot-logo)
	bsr	clr_vertb_irq

	; set up the display
	bsr	display_off
	sub.l	a0,a0
	bsr	make_stdviews

	; We are using the first View. No double buffering.
	move.l	View(a4),a5
	bsr	clear_display

	; blit the image to the center of the display
	movem.w	(a3)+,d2-d3		; d2=width in pixels, d3=height
	move.w	#DISPW,d0
	sub.w	d2,d0
	asr.w	#1,d0
	move.w	#DISPH,d1
	sub.w	d3,d1
	asr.w	#1,d1
	asr.w	#4,d2			; width in words for bltcopy
	mulu	#PLANES,d3		; height * depth
	lea	64(a3),a0		; image data
	bsr	bltcopy

	; Now load the colortable and start the display DMA.
	move.l	a3,a0			; colortable pointer
	bra	startdisplay


;---------------------------------------------------------------------------
do_menu:
; The menu engine. Handle user input and do animations.
; Running in VERTB interrupt.
; a4 = SmallData base
; a6 = CUSTOM

	;-------------------------
	; next key from the queue
	;-------------------------
	bsr	getkey
	move.b	d0,LastKey(a4)

	;------------------------------------------
	; read and remember joystick port 2 status
	;------------------------------------------
	moveq	#1,d0
	bsr	readController
	move.l	d0,Button(a4)		; set Button, UpDown, LeftRight

	;-----------------------------------------------------------
	; switch Views, so we can render to the new background View
	;-----------------------------------------------------------
	bsr	switchView
	move.l	a0,a5			; a5 rendering View
	addq.w	#1,FrameCnt(a4)

	;-------------------------------------------
	; update intensities and undraw BOBs (stars)
	;-------------------------------------------
	bsr	update_intensities
	bsr	undrawBOBs

	;------------------------
	; do phase-specific work
	;------------------------
	move.w	Phase(a4),d0
	cmp.w	Vphase(a5),d0
	bne	new_phase

	move.w	PhaseTab(pc,d0.w),d0
	jmp	PhaseTab(pc,d0.w)

new_phase:
	; Clear parts of the bitmap, when entering a new phase.
	clr.w	Vindex(a5)
	move.w	Vphase(a5),d1
	move.w	d0,Vphase(a5)
	add.w	d1,d1
	add.w	d1,d1
	movem.w	PhCleanupRegion(pc,d1.w),d0-d3
	tst.w	d2			; clear, when width>0
	beq	phase_done
	bsr	bltclear

	;-----------------------
	; draw and update stars
	;-----------------------
phase_done:
	bsr	updateBOBs
	bsr	drawBOBs
	bra	update_stars


PhaseTab:
	dc.w	phaseStart-PhaseTab
	dc.w	phaseCredits-PhaseTab
	dc.w	phaseMainInit-PhaseTab
	dc.w	phaseMain-PhaseTab
	dc.w	phasePasswdInit-PhaseTab
	dc.w	phasePasswd-PhaseTab
	dc.w	phaseHiscoresInit-PhaseTab
	dc.w	phaseHiscores-PhaseTab
	dc.w	phaseEnterNameInit-PhaseTab
	dc.w	phaseEnterName-PhaseTab
	dc.w	phaseExit-PhaseTab


	; Region of bitmap to clean up, when leaving that phase.
PhCleanupRegion:
	; MPHASE_START
	dc.w	0,0,0,0	
	; MPHASE_CREDITS
	dc.w	0,CRED_PRESSBTN_Y,DISPW,(DISPH-CRED_PRESSBTN_Y)*PLANES
	; MPHASE_MAIN (two phases)
	dc.w	0,0,0,0
	dc.w	0,MAIN_MENU_Y,DISPW,(MAIN_MENU_YEND-MAIN_MENU_Y)*PLANES
	; MPHASE_PASSWORD (two phases)
	dc.w	0,0,0,0
	dc.w	0,INPUT_HEAD_Y,DISPW,(INPUT_YEND-INPUT_HEAD_Y)*PLANES
	; MPHASE_HISCORES (two phases)
	dc.w	0,0,0,0
	dc.w	0,HISCORES_TITLEY,DISPW,(HISCORES_YEND-HISCORES_TITLEY)*PLANES
	; MPHASE_NAME (two phases)
	dc.w	0,0,0,0
	dc.w	0,INPUT_HEAD_Y,DISPW,(INPUT_YEND-INPUT_HEAD_Y)*PLANES
	; MPHASE_EXIT
	dc.w	0,0,0,0


;---------------------------------------------------------------------------
menu_intensity:
; Recalculate color table with new intensity.
; a3 = desintation color table
; d6 = intensity ($00-$f0)
; Destroys d2, d3, d7, a2.

	lea	MenuColors(a4),a2
	moveq	#NCOLORS-1,d7
.1:	move.w	(a2)+,d0
	move.w	d6,d1
	bsr	color_intensity
	move.w	d0,(a3)+
	dbf	d7,.1
	rts


;---------------------------------------------------------------------------
mirror_colors:
; Translate a color table to a lowest/highest color range, used for
; the mirror region.
; a2 = source color table
; a3 = desintation color table
; d6 = loColorRGB4.w | hiColorRGB4.w
; Destroys d2 - d5, d7.

	moveq	#NCOLORS-1,d7
.1:	move.w	(a2)+,d0
	move.l	d6,d1
	bsr	color_scale
	move.w	d0,(a3)+
	dbf	d7,.1
	rts


;---------------------------------------------------------------------------
update_intensities:
; Recalculate and update colors, when NrmIntensity or DimIntensity are not
; the same in the current View.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	moveq	#-$10,d6
	and.w	NrmIntensity(a4),d6
	cmp.w	NrmColIntens(a4),d6
	beq	.1

	; calculate normal colors based on new intensity
	move.w	d6,NrmColIntens(a4)
	lea	NrmColors(a4),a3
	bsr	menu_intensity

	; calculate low and high mirror color based on this intensity
	move.w	#MIRROR_LOCOLOR,d0
	move.w	d6,d1
	bsr	color_intensity
	move.w	d6,d1
	move.w	d0,d6
	swap	d6
	move.w	#MIRROR_HICOLOR,d0
	bsr	color_intensity
	move.w	d0,d6
	move.l	d6,MirrorColorRange(a4)

	; then translate the menu colors into this color region
	lea	MenuColors(a4),a2
	lea	NrmMirrColors(a4),a3
	bsr	mirror_colors

.1:	moveq	#-$10,d6
	and.w	DimIntensity(a4),d6
	cmp.w	DimColIntens(a4),d6
	beq	.2

	; calculate dimmed colors based on new intensity
	move.w	d6,DimColIntens(a4)
	lea	DimColors(a4),a3
	bsr	menu_intensity

	; translate dimmed colors into the mirror region
	lea	DimColors(a4),a2
	lea	DimMirrColors(a4),a3
	move.l	MirrorColorRange(a4),d6
	bsr	mirror_colors

	; update View's copper list
.2:	move.l	Vclist(a5),a0
	lea	MCl_dynamic(a0),a0


;---------------------------------------------------------------------------
update_clist:
; Write dynamic part of menu copper list at MCl_colortop.
; 1. Set normal positive BPLxMOD for interleaving.
; 2. Set 32 color registers.
; 3. Wait for a specific row, set 32 color registers.
; 4. Wait for a specific row, set 32 color registers.
; 5. Wait for MIRROR_VPOS, negate BPLxMOD and load 32 color registers.
; 6. Wait for mirrored row from 4., set 32 color registers.
; 7. Wait for mirrored row from 3., set 32 color registers.
; This allows us to dim a part of the screen, which is mirrored at the bottom.
; a0 = copper list pointer at MCl_dynamic
; -> a0 = new copperlist pointer

	movem.l	d2-d3,-(sp)
	moveq	#0,d2			; flag for "VPOS $100 passed"
	move.w	#MIRROR_VPOS,d3

	; reset standard BPLxMOD
	move.l	#BPL1MOD<<16|((PLANES-1)*BPR+(BPR-DISPW/8)),(a0)+
	move.l	#BPL2MOD<<16|((PLANES-1)*BPR+(BPR-DISPW/8)),(a0)+

	; set original menu colors at top of display
	lea	NrmColors(a4),a1
	bsr	write_clist_colors

	; set changed colors at a variable position
	move.w	ColorVStart(a4),d0
	beq	.1
	bsr	write_clist_wait
	lea	DimColors(a4),a1
	bsr	write_clist_colors

	; reset original colors at another variable position
	move.w	ColorVStop(a4),d0
	beq	.1
	bsr	write_clist_wait
	lea	NrmColors(a4),a1
	bsr	write_clist_colors

	; Wait for start of mirrored region. Set BPLxMOD to display the
	; bitmap backwards. Load mirror colors.
.1:	move.w	d3,d0			; MIRROR_VPOS
	bsr	write_clist_wait
	move.l	#BPL1MOD<<16|((-(PLANES*BPR+DISPW/8))&$ffff),(a0)+
	move.l	#BPL2MOD<<16|((-(PLANES*BPR+DISPW/8))&$ffff),(a0)+
	lea	NrmMirrColors(a4),a1
	bsr	write_clist_colors

	; Note that ColorVStart marks the first line with dimmed colors,
	; while ColorVStop marks the first line with normal colors. So
	; we have to wait for MIRROR_VPOS+(MIRROR_VPOS-ColorVStop)+1 for
	; the first dimmed line in the mirror region. Also add one for
	; ColorVStart, which marks the end of the dimmed mirror region.

	; set changed mirror colors
	move.w	ColorVStop(a4),d1
	beq	.2
	move.w	d3,d0
	sub.w	d1,d0
;	addq.w	#1,d0
	add.w	d3,d0
	cmp.w	#VEND,d0
	bhs	.2
	bsr	write_clist_wait
	lea	DimMirrColors(a4),a1
	bsr	write_clist_colors

	; reset original mirror colors
	move.w	ColorVStart(a4),d1
	beq	.2
	move.w	d3,d0
	sub.w	d1,d0
;	addq.w	#1,d0
	add.w	d3,d0
	cmp.w	#VEND,d0
	bhs	.2
	bsr	write_clist_wait
	lea	NrmMirrColors(a4),a1
	bsr	write_clist_colors

	; resetting COLOR00 to black ends the mirrored region
.2:	move.w	#VEND,d0
	bsr	write_clist_wait
	move.l	#COLOR00<<16|$000,(a0)+

	; end of copper list
	moveq	#-2,d0
	move.l	d0,(a0)+

	movem.l	(sp)+,d2-d3
	rts


;---------------------------------------------------------------------------
phaseStart:
; Menu startup. Logo is already drawn. Slowly increase color intensities
; up to maximum level.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	moveq	#DINTENS_START,d0
	add.w	d0,NrmIntensity(a4)
	add.w	d0,DimIntensity(a4)

	cmp.w	#$ff,NrmIntensity(a4)
	blo	phase_done

	; Full intensity reached.
	; Check if last score qualifies for an entry into the high score list.
	tst.b	NewHighscore(a4)
	bne	.1

	; Go to the next phase (show credits).
	bsr	set_phase_credits
	bra	phase_done

	; Next phase is highscore entry.
.1:	bsr	set_phase_entername
	bra	phase_done


;---------------------------------------------------------------------------
phaseCredits:
; Fade the credits in and out.
; Pressing the button proceeds to the main menu phase.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	tst.w	Delay(a4)
	beq	.do_credits
	subq.w	#1,Delay(a4)		; do nothing for Delay frames
	bra	.press_button

.do_credits:
	move.w	CredIndex(a4),d0
	beq	.1
	cmp.w	Vindex(a5),d0
	bne	.1
	subq.w	#2,d0
	move.w	d0,CredIndex(a4)
.1:	move.w	d0,Vindex(a5)

	move.w	.workTab(pc,d0.w),d0
	jmp	.workTab(pc,d0.w)

.workTab:
	dc.w	.change_intensity-.workTab
	dc.w	.print_name-.workTab
	dc.w	.print_category-.workTab
	dc.w	.clear_credits-.workTab


.change_intensity:
	; change color intensity of credits
	move.w	DimIntensity(a4),d1
	move.w	DeltaIntensity(a4),d0
	bmi	.decrease_intensity

	; increase credits intensity
	add.w	d0,d1
	cmp.w	#$ff,d1
	blo	.set_intensity

	; highest intensity reached: wait some time before dimming it again
	move.w	#CRED_DELAY,Delay(a4)
	move.w	#$ff,d1
	bra	.change_dir

.decrease_intensity:
	add.w	d0,d1
	bpl	.set_intensity

	; Lowest intensity reached. Request to draw the next credits.
	move.w	Index(a4),d0
	addq.w	#8,d0
	cmp.w	#CreditsTabEnd-CreditsTab,d0
	blo	.2
	moveq	#0,d0
.2:	move.w	d0,Index(a4)

	move.w	#6,CredIndex(a4)	; redraw credits in the next steps
	moveq	#0,d1

.change_dir:
	neg.w	DeltaIntensity(a4)

.set_intensity:
	move.w	d1,DimIntensity(a4)


.press_button:
	; print a flashing "press button" text
	moveq	#PressButtonX,d0
	move.w	#CRED_PRESSBTN_Y,d1
	moveq	#16,d2
	and.w	FrameCnt(a4),d2
	bne	.7
	move.w	#PressButtonWidth,d2
	move.w	#MENUFONT8H*PLANES,d3
	bsr	bltclear
	bra	.8
.7:	lea	PressButtonTxt(pc),a0
	bsr	mfont8_print

	; pressed button proceeds to main menu
.8:	move.b	Button(a4),d2
	beq	.9

	tst.b	LastButton(a4)
	bne	phase_done
	moveq	#SND_MSELECT,d0
	bsr	playSFX
	bsr	set_phase_main

.9:	move.b	d2,LastButton(a4)
	bra	phase_done


.clear_credits:
	; clear the credits region, to redraw them in the nexts steps
	moveq	#0,d0
	move.w	#CRED_CATEGORY_Y,d1
	move.w	#DISPW,d2
	move.w	#(CRED_NAME_Y+MENUFONT16H-CRED_CATEGORY_Y)*PLANES,d3
	bsr	bltclear
	bra	.press_button


.print_category:
	; print the current credits category in small letters
	move.w	Index(a4),d0		; d0 CreditsTable index
	move.l	CreditsTab(pc,d0.w),a0
	moveq	#0,d0
	move.b	(a0)+,d0		; centered xpos
	move.w	#CRED_CATEGORY_Y,d1
	bsr	mfont8_print
	bra	.press_button


.print_name:
	; print the current credits name in big letters
	move.w	Index(a4),d0		; d0 CreditsTable index
	move.l	CreditsTab+4(pc,d0.w),a0
	moveq	#0,d0
	move.b	(a0)+,d0		; centered xpos
	move.w	#CRED_NAME_Y,d1
	bsr	mfont16_print
	bra	.press_button


	; Credits table. Category and name pointers for each entry.
CreditsTab:
	dc.l	Cred1Cat,Cred1Name
	dc.l	Cred2Cat,Cred2Name
	dc.l	Cred3Cat,Cred3Name
	dc.l	Cred4Cat,Cred3Name
	dc.l	Cred5Cat,Cred3Name
	dc.l	Cred6Cat,Cred4Name
	dc.l	Cred7Cat,Cred5Name
	dc.l	Cred7Cat,Cred6Name
CreditsTabEnd:

	xdef	PressButtonTxt
	xdef	PressButtonX
	CENTTXT	8,PressButton,"PRESS BUTTON"
	even


;---------------------------------------------------------------------------
phaseMainInit:
; Draw the menu items, one after another. Then fade them in.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	tst.b	NewHighscore(a4)
	bne	.start_music

	moveq	#-4,d0
	and.w	Index(a4),d0
	cmp.w	#MenuTxtTabEnd-MenuTxtTab,d0
	bhs	.fade_in

	; draw next menu item
	move.l	MenuTxtTab(pc,d0.w),a0
	lsr.w	#1,d0
	move.w	MenuItemYTab(pc,d0.w),d1
	moveq	#MAIN_MENU_X,d0
	bsr	mfont8_print
	addq.w	#1,Index(a4)
	bra	phase_done

.fade_in:
	moveq	#DINTENS_MINIT,d0
	add.w	DimIntensity(a4),d0
	cmp.w	#$ff,d0
	blo	.2

	; menu init phase done - proceed to menu phase
	move.w	#$ff,d0
	addq.w	#2,Phase(a4)

	moveq	#0,d1			; select start game
	tst.w	Level(a4)
	beq	.1
	; game had already been played: select continue game
	moveq	#1,d1
.1:	move.w	d1,Index(a4)

.2:	move.w	d0,DimIntensity(a4)
	bra	phase_done

.start_music:
	; Player just entered a new highscore with a different music, so
	; we have to restart the main menu theme.
	moveq	#MENUMUS_SONG,d0
	moveq	#MENUMUS_VOLUME,d1
	bsr	startMusic

	clr.b	NewHighscore(a4)
	bra	phase_done


MenuTxtTab:
	dc.l	Menu1Txt,Menu2Txt,Menu3Txt,Menu4Txt,Menu5Txt,Menu6Txt
MenuTxtTabEnd:


MenuItemYTab:
	dc.w	MAIN_MENU_Y+0*MAIN_MENU_STEP
	dc.w	MAIN_MENU_Y+1*MAIN_MENU_STEP
	dc.w	MAIN_MENU_Y+2*MAIN_MENU_STEP
	dc.w	MAIN_MENU_Y+3*MAIN_MENU_STEP
	dc.w	MAIN_MENU_Y+4*MAIN_MENU_STEP
	dc.w	MAIN_MENU_Y+5*MAIN_MENU_STEP


;---------------------------------------------------------------------------
phaseMain:
; Joystick up/down selects a menu item. Button activates it.
; Pulse the color intensities of the currently selected item and
; draw a pointer at the left side.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	; clear the pointer image
	moveq	#MAIN_PTR_X,d0
	move.w	Vptry(a5),d1
	beq	.1			; not set
	moveq	#POINTERW,d2
	moveq	#POINTERH*PLANES,d3
	bsr	bltclear

	; select a menu item with the joystick
.1:	bsr	menu_item_select

	; set first and last raster line of current menu item
	add.w	d0,d0
	move.w	MenuItemYTab(pc,d0.w),d1
	moveq	#VSTART-1,d0
	add.w	d1,d0
	move.w	d0,ColorVStart(a4)
	add.w	#MAIN_MENU_STEP,d0
	move.w	d0,ColorVStop(a4)

	; draw the pointer image left to it
	move.l	Pointer(a4),a0
	moveq	#MAIN_PTR_X,d0
	add.w	#(MAIN_MENU_STEP-POINTERH)/2,d1
	move.w	d1,Vptry(a5)
	moveq	#POINTERW>>4,d2
	moveq	#POINTERH*PLANES,d3
	bsr	bltcopy

	; pulse color intensities of current menu item
	move.w	DimIntensity(a4),d0
	add.w	DeltaIntensity(a4),d0
	cmp.w	#$ff,d0
	blo	.2
	move.w	#$ff,d0
	bra	.3
.2:	cmp.w	#MAIN_MIN_INTENS,d0
	bhs	.4
	move.w	#MAIN_MIN_INTENS,d0
.3:	neg.w	DeltaIntensity(a4)
.4:	move.w	d0,DimIntensity(a4)

	; button selects a menu item
	move.b	Button(a4),d6
	beq	.5

	tst.b	LastButton(a4)
	bne	phase_done

	; menu item selected
	moveq	#SND_MSELECT,d0
	bsr	playSFX
	move.w	Index(a4),d0
	add.w	d0,d0
	move.w	MenuActionTab(pc,d0.w),d0
	jsr	MenuActionTab(pc,d0.w)

.5:	move.b	d6,LastButton(a4)
	bra	phase_done


MenuActionTab:
	dc.w	startGame-MenuActionTab
	dc.w	continueGame-MenuActionTab
	dc.w	set_phase_password-MenuActionTab
	dc.w	startIntro-MenuActionTab
	dc.w	set_phase_highscores-MenuActionTab
	dc.w	set_phase_credits-MenuActionTab

startGame:
	moveq	#1,d0
	bra	set_phase_exit		; start game with first level

continueGame:
	move.w	Level(a4),d0		; continue with last level
	beq	startGame		; No previous game. Start first level.
	cmp.w	#MAXLEVEL,d0
	bhi	startGame		; Finished game. Start first level.
	bra	set_phase_exit

startIntro:
	moveq	#-1,d0
	bra	set_phase_exit		; run the introduction


;---------------------------------------------------------------------------
menu_item_select:
; Joystick up/down handling to select the previous/next menu item.
; -> d0 = new selected menu item

	move.w	Index(a4),d1
	move.b	UpDown(a4),d0
	bne	.2

	; stick released: clear LastUp and LastDown
	clr.w	LastUp(a4)
.1:	move.w	d1,d0
	rts

.2:	bpl	.3
	tst.b	LastUp(a4)
	bne	.1			; already up, release first
	st	LastUp(a4)

	; previous menu item
	subq.w	#1,d1
	bpl	.4
	moveq	#0,d0			; first menu item reached
	rts

.3:	tst.b	LastDown(a4)
	bne	.1			; already down, release first
	st	LastDown(a4)

	; next menu item
	addq.w	#1,d1
	cmp.w	#MAIN_MENU_ITEMS,d1
	blo	.4
	moveq	#MAIN_MENU_ITEMS-1,d0	; last menu item reached
	rts

.4:	;moveq	#SND_MCHOOSE,d0
	;bsr	playSFX
	move.w	d1,Index(a4)
	move.w	d1,d0
	rts


;---------------------------------------------------------------------------
phasePasswdInit:
; Draw the "enter password" text.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	; proceed to next phase, when both Views have been initialized
	move.w	Index(a4),d0
	cmp.w	#2,d0
	bhs	.nextphase
	addq.w	#1,d0
	move.w	d0,Index(a4)

	; print "please enter password"
	moveq	#EnterPasswordX,d0
	move.w	#INPUT_HEAD_Y,d1
	lea	EnterPasswordTxt(pc),a0
	bsr	mfont8_print

	bra	phase_done

.nextphase:
	addq.w	#2,Phase(a4)
	clr.w	Index(a4)		; first position in password

	move.w	#PASS_ENTRY_X,d0
	bsr	reset_input

	bra	phase_done


	CENTTXT	8,EnterPassword,"PLEASE ENTER PASSWORD"
	even


;---------------------------------------------------------------------------
phasePasswd:
; Enter a level password. When it matches, select the level for playing.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	; get next key, update display
	move.w	InputX(a4),d0
	moveq	#PASS_LEN,d1
	bsr	handle_input

	cmp.b	#27,d0			; escape
	bne	.1
	bsr	set_phase_main		; return to main menu
	bra	phase_done

.1:	cmp.b	#10,d0			; enter
	bne	phase_done
	moveq	#SND_MSELECT,d0
	bsr	playSFX

	; confirm the input, check for matching passwords
	bsr	check_password
	bra	phase_done


;---------------------------------------------------------------------------
phaseHiscoresInit:
; Draw the highscore table. One rank after another. Format:
; <-------------------------------------->
; 10 NIGHT OWL DESIGN...... 1-1 1-1 000000
; a5 = View
; Registers, except a4 - a6, are not preserved!

	move.w	Index(a4),d7
	asr.w	#1,d7
	bmi	.print_header

	; get current highscore list entry to print
	move.l	Hiscores(a4),a2
	move.w	d7,d0
	lsl.w	#sizeof_HS_shift,d0
	add.w	d0,a2			; a2 pointer to highscore entry

	; construct the text line to print on the stack
	lea	-44(sp),sp
	move.l	sp,a1
	moveq	#' ',d6

	; rank
	move.w	#$2031,d0		; " 1"
	add.w	d7,d0
	cmp.w	#$2039,d0
	bls	.1
	move.w	#$3130,d0		; "10"
.1:	move.w	d0,(a1)+
	move.b	d6,(a1)+

	; name
	moveq	#HISCORE_NAMELEN-1,d0
	lea	HSname(a2),a0
.2:	move.b	(a0)+,(a1)+
	dbf	d0,.2
	move.b	d6,(a1)+

	; start level
	move.b	HSstart(a2),d0
	bsr	.insertstage

	; end level
	move.b	HSend(a2),d0
	bsr	.insertstage

	; score in BCD
	move.b	HSscore(a2),d0
	bsr	.insertbcd
	move.b	HSscore+1(a2),d0
	bsr	.insertbcd
	move.b	HSscore+2(a2),d0
	bsr	.insertbcd
	clr.b	(a1)

	; print the highscore line from the buffer
	moveq	#0,d0
	move.w	#HISCORES_Y,d1
	lsl.w	#3,d7			; add Index * MENUFONT8H
	add.w	d7,d1
	move.l	sp,a0
	bsr	mfont8_print

	lea	44(sp),sp
.exit:
	addq.w	#1,Index(a4)
	cmp.w	#2*HISCORE_RANKS,Index(a4)
	blt	phase_done

	; All ranks have been printed. Proceed to next phase.
	addq.w	#2,Phase(a4)
	clr.w	Index(a4)
	bra	phase_done

.insertbcd:
	; write two digits from a BCD byte
	moveq	#'0',d2
	moveq	#15,d1
	and.b	d0,d1
	add.b	d2,d1
	lsr.b	#4,d0
	add.b	d2,d0
	move.b	d0,(a1)+
	move.b	d1,(a1)+
	rts

.insertstage:
	; Convert level (1-10) into a stage string ("1-1" to "4-2").
	; Level 11 is set when the game was finished ("END").
	lea	StageStrings(a4),a0
	ext.w	d0
	lsl.w	#2,d0
	add.w	d0,a0
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	d6,(a1)+
	rts

.print_header:
	; print hiscore list title
	moveq	#HiScoresTitleX,d0
	move.w	#HISCORES_TITLEY,d1
	lea	HiScoresTitleTxt(pc),a0
	bsr	mfont16_print
	bra	.exit


	CENTTXT	16,HiScoresTitle,"HIGH SCORES"
	even


;---------------------------------------------------------------------------
phaseHiscores:
; Pulse intensity of last high score entry. Wait for button.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	move.w	Index(a4),d0
	bne	phaseFadeout

	move.w	LastRank(a4),d0
	beq	.check_button

	; pulse color intensities of LastRank
	lsl.w	#3,d0			; *MENUFONT8H
	add.w	#VSTART+HISCORES_Y-MENUFONT8H-1,d0
	move.w	d0,ColorVStart(a4)
	add.w	#MENUFONT8H,d0
	move.w	d0,ColorVStop(a4)

	move.w	DimIntensity(a4),d0
	add.w	DeltaIntensity(a4),d0
	cmp.w	#$ff,d0
	blo	.1
	move.w	#$ff,d0
	bra	.2
.1:	cmp.w	#HI_MIN_INTENS,d0
	bhs	.3
	move.w	#HI_MIN_INTENS,d0
.2:	neg.w	DeltaIntensity(a4)
.3:	move.w	d0,DimIntensity(a4)

.check_button:
	; return to main menu when button was pressed
	move.b	Button(a4),d2
	beq	.exit

	tst.b	LastButton(a4)
	bne	phase_done
	moveq	#SND_MSELECT,d0
	bsr	playSFX

	tst.b	NewHighscore(a4)
	beq	.4

	; Highscore music is running. Fade it out first.
	addq.w	#1,Index(a4)
	move.w	#VSTART+HISCORES_TITLEY-1,ColorVStart(a4)
	move.w	#VSTART+HISCORES_YEND,ColorVStop(a4)
	move.w	#$ff,DimIntensity(a4)
	bra	.exit

	; return to main menu immediately
.4:	bsr	set_phase_main

.exit:
	move.b	d2,LastButton(a4)
	bra	phase_done


;---------------------------------------------------------------------------
phaseFadeout:
; Fade the high score list and music out. Then return to the main menu.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	move.l	#$10000,d0
	bsr	musicFadeOut

	sub.w	#DINTENS_FADEOUT,DimIntensity(a4)
	bpl	phase_done

	; stop music, return to main menu
	clr.w	DimIntensity(a4)
	bsr	stopMusic
	bsr	set_phase_main
	bra	phase_done


;---------------------------------------------------------------------------
phaseEnterNameInit:
; Draw the "enter name" text.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	; proceed to next phase, when both Views have been initialized
	move.w	Index(a4),d0
	cmp.w	#2,d0
	bhs	.nextphase
	addq.w	#1,d0
	move.w	d0,Index(a4)

	; print "please enter your name"
	moveq	#EnterNameX,d0
	move.w	#INPUT_HEAD_Y,d1
	lea	EnterNameTxt(pc),a0
	bsr	mfont8_print

	bra	phase_done

.nextphase:
	addq.w	#2,Phase(a4)
	clr.w	Index(a4)		; first position in password

	move.w	#NAME_ENTRY_X,d0
	bsr	reset_input

	bra	phase_done


	CENTTXT	8,EnterName,"PLEASE ENTER YOUR NAME"
	even


;---------------------------------------------------------------------------
phaseEnterName:
; Enter name for a new high score entry.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	; get next key, update display
	move.w	InputX(a4),d0
	bmi	.2
	moveq	#HISCORE_NAMELEN,d1
	bsr	handle_input

	cmp.b	#27,d0			; escape
	beq	.3

.1:	cmp.b	#10,d0			; enter
	bne	phase_done
	moveq	#SND_MSELECT,d0
	bsr	playSFX
	st	InputX(a4)		; indicates name is valid
	bra	phase_done

	; insert the new entry into the high score list
.2:	bsr	insertHiscore
	st	WriteFlag(a4)		; write new high scores to disk

	; clear the score to prevent reentry
.3:	lea	Score(a4),a0
	clr.b	(a0)+
	clr.b	(a0)+
	clr.b	(a0)

	bsr	set_phase_highscores	; now show the high score table
	bra	phase_done


;---------------------------------------------------------------------------
phaseExit:
; Fade out the menu screen. Quit the menu.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	move.l	#$10000,d0
	bsr	musicFadeOut

	moveq	#DINTENS_EXIT,d0
	sub.w	d0,DimIntensity(a4)
	bpl	.1
	clr.w	DimIntensity(a4)
.1:	sub.w	d0,NrmIntensity(a4)
	bpl	phase_done

	; quit the menu engine
	clr.w	NrmIntensity(a4)
	st	QuitMenu(a4)
	bra	phase_done


;---------------------------------------------------------------------------
loadgfx:
; Load the menu graphics (logos, menu pointer).

	move.l	a2,-(sp)

	moveq	#FIL_LOGOSOLID,d0
	bsr	td_loadcr_chip
	move.l	d0,LogoSolid(a4)
	beq	loaderr

	moveq	#FIL_LOGOGOLD,d0
	bsr	td_loadcr_chip
	move.l	d0,LogoGold(a4)
	beq	loaderr

	moveq	#FIL_POINTER,d0
	bsr	td_loadcr_chip
	move.l	d0,Pointer(a4)
	beq	loaderr

	; load stars animations
	moveq	#FIL_LOGOSTARS,d0
	bsr	td_loadcr_chip
	beq	loaderr
	move.l	d0,a2

	; make stars image pointer table
	lea	StarsTypes(a4),a0
	lea	StarsAnims(a4),a1
	moveq	#STARSTYPES,d0
	move.w	#STARSSIZE,d1
	bsr	makeBlkTable

	move.l	(sp)+,a2
	rts


;---------------------------------------------------------------------------
set_phase_start:
; Set startup phase.

	move.w	#MPHASE_START,Phase(a4)
	move.w	#VSTART+CRED_CATEGORY_Y-1,ColorVStart(a4)
	move.w	#VSTART+CRED_NAME_Y+MENUFONT16H,ColorVStop(a4)
	clr.w	NrmIntensity(a4)
	clr.w	DimIntensity(a4)
	rts


;---------------------------------------------------------------------------
set_phase_credits:
; Set credits phase.

	move.w	#MPHASE_CREDITS,Phase(a4)
	move.w	#VSTART+CRED_CATEGORY_Y-1,ColorVStart(a4)
	move.w	#VSTART+CRED_NAME_Y+MENUFONT16H,ColorVStop(a4)
	move.w	#$ff,NrmIntensity(a4)
	clr.w	DimIntensity(a4)

	move.w	#CreditsTabEnd-CreditsTab,Index(a4)
	clr.w	CredIndex(a4)
	clr.w	Delay(a4)
	move.w	#-DINTENS_CREDITS,DeltaIntensity(a4)
	rts


;---------------------------------------------------------------------------
set_phase_main:
; Set main menu phase.

	move.w	#MPHASE_MAIN,Phase(a4)
	move.w	#VSTART+MAIN_MENU_Y-1,ColorVStart(a4)
	move.w	#VSTART+MAIN_MENU_YEND,ColorVStop(a4)
	move.w	#$ff,NrmIntensity(a4)
	clr.w	DimIntensity(a4)

	clr.w	Index(a4)
	move.w	#-DINTENS_MENU,DeltaIntensity(a4)
	rts


;---------------------------------------------------------------------------
set_phase_password:
; Set password-entry phase.

	move.w	#MPHASE_PASSWORD,Phase(a4)
	clr.w	ColorVStart(a4)
	clr.w	ColorVStop(a4)
	move.w	#$ff,NrmIntensity(a4)
	move.w	#$ff,DimIntensity(a4)

	clr.w	Index(a4)
	rts


;---------------------------------------------------------------------------
set_phase_highscores:
; Set highscores phase.

	move.w	#MPHASE_HISCORES,Phase(a4)
	clr.w	ColorVStart(a4)
	clr.w	ColorVStop(a4)
	move.w	#$ff,NrmIntensity(a4)
	move.w	#$ff,DimIntensity(a4)

	move.w	#-2,Index(a4)
	move.w	#DINTENS_HISCORE,DeltaIntensity(a4)
	rts


;---------------------------------------------------------------------------
set_phase_entername:
; Set name-entry phase for high score list.

	move.w	#MPHASE_NAME,Phase(a4)
	clr.w	ColorVStart(a4)
	clr.w	ColorVStop(a4)
	move.w	#$ff,NrmIntensity(a4)
	move.w	#$ff,DimIntensity(a4)

	clr.w	Index(a4)
	rts


;---------------------------------------------------------------------------
set_phase_exit:
; Set exit phase.
; d0 = action code

	move.w	#MPHASE_EXIT,Phase(a4)
	move.b	d0,Action(a4)
	rts


;---------------------------------------------------------------------------
reset_input:
; Clear input buffers.
; d0 = starting xpos of input on screen

	move.l	a2,-(sp)
	move.w	d0,InputX(a4)

	move.l	View(a4),a2
	lea	Vinpbuf(a2),a0
	move.l	View+4(a4),a2
	lea	Vinpbuf(a2),a1
	lea	InputBuffer(a4),a2

	moveq	#VINPBUFSIZE-1,d0
.1:	clr.b	(a0)+
	clr.b	(a1)+
	clr.b	(a2)+
	dbf	d0,.1

	move.l	(sp)+,a2
	rts


;---------------------------------------------------------------------------
handle_input:
; Append new characters to the buffer and update the display.
; a5 = View
; d0 = starting xpos of input line on screen
; d1 = max characters in buffer
; Registers, except a4 - a6, are not preserved!
; -> d0.b/Z = last character entered (Z means no key pressed)

	move.w	d0,d5
	move.w	d1,d6
	move.w	Index(a4),d7
	lea	InputBuffer(a4),a2	; a2 InputBuffer
	lea	(a2,d7.w),a0

	; get last pressed key and check for valid characters
	move.b	LastKey(a4),d4
	cmp.b	#' ',d4
	beq	.1
	cmp.b	#'0',d4
	blo	.2
	cmp.b	#'9',d4
	bls	.1
	cmp.b	#'A',d4
	blo	.3
	cmp.b	#'Z',d4
	bhi	.3
.1:	cmp.w	d6,d7			; discard character when buffer full
	bhs	.3

	; append new character
	move.b	d4,(a0)+
	clr.b	(a0)
	addq.w	#1,d7
	bra	.3

.2:	cmp.b	#8,d4			; backspace/delete
	bne	.3
	tst.w	d7
	beq	.3			; cannot backspace at the beginning

	; delete last character
	clr.b	-(a0)
	subq.w	#1,d7

.3:	move.w	d7,Index(a4)

	; Look for differences between the displayed string on the
	; current View and the new strings from the InputBuffer.
	; We have to delete and reprint the modified region.

	move.l	a2,a0
	lea	Vinpbuf(a5),a3
	move.w	d6,d3
	subq.w	#1,d3

.4:	move.b	(a0)+,d0
	move.b	d0,d2
	move.b	(a3)+,d1
	or.b	d1,d2
	beq	.5			; both strings are terminated here
	cmp.b	d0,d1
	dbne	d3,.4
	beq	.6			; equality on full length

	; Vinpbuf doesn't match InputBuffer. Delete everything from the
	; non-matching position until the end + 1 (to include the cursor).

	; back to the non-matching position
.5:	subq.l	#1,a0
	subq.l	#1,a3

	; Find out how many characters have to be deleted on screen.
	; We will at least delete one character to redraw the cursor.
.6:	move.l	a3,a1
	moveq	#0,d2
	moveq	#MENUFONT16W,d0
.7:	add.w	d0,d2			; d2 width of region to be deleted
	tst.b	(a1)+
	bne	.7

	; update Vinpbuf
	move.l	a3,a2			; a2 start of modified string
.8:	move.b	(a0)+,(a3)+
	bne	.8
	subq.l	#1,a3			; a3 end of modified string

	; calculate starting xpos for the modification on screen
	lea	Vinpbuf(a5),a0
	move.l	a2,d0
	sub.l	a0,d0
	lsl.w	#4,d0			; *MENUFONT16W
	add.w	d0,d5			; d5 xpos on screen

	; clear the modified region in the View's bitmap
	move.w	d5,d0
	move.w	#INPUT_Y,d1
	moveq	#MENUFONT16H*PLANES,d3
	bsr	bltclear

	; print the modified buffer, including a blinking cursor
	moveq	#16,d0
	and.w	FrameCnt(a4),d0
	beq	.9
	move.b	#$5b,(a3)		; append cursor
	clr.b	1(a3)

.9:	move.w	d5,d0
	move.w	#INPUT_Y,d1
	move.l	a2,a0
	bsr	mfont16_print
	clr.b	(a3)

	move.b	d4,d0			; return last entered character
	rts


;---------------------------------------------------------------------------
check_password:
; Compare the password in InputBuffer with all of the level passwords.
; Nothing difficult to crack, as this source will be released anyway. ;)
; Activate matching level.

	movem.l	d2-d3,-(sp)
	lea	LevelPasswords(a4),a1
	moveq	#1,d3			; start with level 1

	; compare with next level password
.1:	lea	InputBuffer(a4),a0
	moveq	#PASS_LEN-1,d2
	moveq	#$3f,d1
.2:	move.b	(a0)+,d0
	eor.b	d1,d0
	cmp.b	(a1)+,d0
	beq	.3
	bset	#15,d1			; passwords don't match
.3:	subq.b	#1,d1
	dbf	d2,.2

	tst.w	d1
	bpl	.4			; password found!

	; next level
	addq.w	#1,d3
	tst.b	(a1)
	bne	.1

	; no matching password found, return to main menu
	bsr	set_phase_main
	bra	.5

.4:	move.w	d3,d0			; start this level
	bsr	set_phase_exit
.5:	movem.l	(sp)+,d2-d3
	rts


;---------------------------------------------------------------------------
clear_colors:
; Initialize all colors with black.

	; set initial color intensities (we start with 0)
	clr.w	NrmColIntens(a4)
	clr.w	DimColIntens(a4)
	clr.l	MirrorColorRange(a4)

	lea	NrmColors(a4),a0
	lea	DimColors(a4),a1
	lea	NrmMirrColors(a4),a2
	lea	DimMirrColors(a4),a3
	moveq	#0,d0
	moveq	#NCOLORS-1,d1

.1:	move.w	d0,(a0)+
	move.w	d0,(a1)+
	move.w	d0,(a2)+
	move.w	d0,(a3)+
	dbf	d1,.1

	rts


;---------------------------------------------------------------------------
init_stars:
; Initialize Stars structures and constant data in MOBs for NUM_STARS stars.
; Position and image pointer is set when the MOB is used.
; Each new star gets the next animation from the (circular) list.

	movem.l	d2-d3/a2-a3/a5,-(sp)

	lea	Stars(a4),a5
	moveq	#NUM_STARS,d2

	lea	StarsAnimData(a4),a3
	bra	.2

	; MOB
.1:	move.w	#STARSH,MOheight(a5)
	move.w	#STARSW>>4,MOwidth(a5)

	; Star animation range.
	move.w	(a2),d0
	swap	d0			; MSW first anim frame
	move.w	(a2)+,d0
	add.w	(a2)+,d0		; LSW last anim frame
	lsl.l	#2,d0			; *4 for table index
	move.l	d0,Sfirstanim(a5)	; set Sfirstanim | Slastanim

	; Make star first appear after a random number of frame,
	; between 0 and 31.
	bsr	rand
	and.w	#31,d0
	move.w	d0,Scounter(a5)
	st	Sanim(a5)

	lea	sizeof_Star(a5),a5

	subq.w	#1,d3
	bne	.3
.2:	move.l	a3,a2
	moveq	#NUM_STARS_ANIMS,d3

.3:	dbf	d2,.1

	movem.l	(sp)+,d2-d3/a2-a3/a5
	rts


;---------------------------------------------------------------------------
update_stars:
; Animate and reposition our sparkling stars.
; a5 = View
; Registers, except a4 - a6, are not preserved!

	moveq	#NUM_STARS-1,d7
	moveq	#STARS_ANIM_CNT,d6	; number of frames per animation phase
	lea	Stars(a4),a3
	lea	StarsAnims(a4),a2

.loop:
	subq.w	#1,Scounter(a3)
	bne	.next

	; Scounter reached zero: set next animation frame
	move.w	d6,Scounter(a3)

	move.w	Sanim(a3),d0
	bmi	.newposition		; attach BOBs for a new position

	addq.w	#4,d0
	cmp.w	Slastanim(a3),d0
	blo	.setanim

	; Last animation frame has passed.
	; Unlink the BOBs to make the star disappear shortly, before
	; it reappears at a new position.
	move.l	a3,a0
	bsr	unlinkBOB
	st	Sanim(a3)		; get a new position next time
	bra	.next

.newposition:
	; Generate a new random position in the region of the GOLD image
	; (between STARSRX/STARSRY and STARSRX+STARSRW/STARSRY+STARSRH).
	; Avoid modulo operations by masking and subtracting the random value.
	bsr	rand
	and.w	#STARSRW_MASK,d0
	move.w	d0,d1
	sub.w	#STARSRW,d1
	bmi	.1
	move.w	d1,d0
.1:	add.w	#STARSRX,d0
	move.w	d0,MOxpos(a3)

	bsr	rand
	and.w	#STARSRH_MASK,d0
	move.w	d0,d1
	sub.w	#STARSRH,d1
	bmi	.2
	move.w	d1,d0
.2:	add.w	#STARSRY,d0
	move.w	d0,MOypos(a3)

	; attach BOBs
	move.l	a3,a0
	bsr	newBOB
	beq	.nobob

	; set the first animation
	move.w	Sfirstanim(a3),d0

.setanim:
	; load image and mask for current animation phase
	move.w	d0,Sanim(a3)

	move.l	(a2,d0.w),a0
	move.l	a0,MOimage(a3)
	lea	STARSSIZE(a0),a0
	move.l	a0,MOmask(a3)

.next:
	lea	sizeof_Star(a3),a3
	dbf	d7,.loop
	rts

.nobob:
	move.w	#$ff8,d0		; light yellow: out of BOBs
	bra	panic


;---------------------------------------------------------------------------
init_view:
; Initialize the View, clear the bitmap. Draw the logo.
; a5 = View

	move.w	#MPHASE_START,Vphase(a5)

	; pointer position is undefined
	clr.w	Vptry(a5)

	; clear the View's visible bitmap
	bsr	clear_display

	; Draw "Solid" and "Gold" images at the top of the screen.
	move.l	LogoSolid(a4),a0
	move.w	#LSOLIDX,d0
	moveq	#LSOLIDY,d1
	moveq	#LSOLIDW>>4,d2
	move.w	#LSOLIDH*PLANES,d3
	bsr	bltcopy

	move.l	LogoGold(a4),a0
	move.w	#LGOLDX,d0
	move.w	#LGOLDY,d1
	moveq	#LGOLDW>>4,d2
	move.w	#LGOLDH*PLANES,d3
	bra	bltcopy


;---------------------------------------------------------------------------
	xdef	loadHiscores
loadHiscores:
; Try to load the high scores from the last track on the disk. Make sure
; the high scores are valid by calculating a check sum. Reset high scores
; to default entries when invalid (either fresh disk or manipulated).
; Registers, except a4 and a6, are not preserved!

	move.l	Hiscores(a4),a2

	; read the high scores block from disk
	move.w	#HISCORES_TRACK*11,d0
	moveq	#1,d1
	move.l	a2,a0
	bsr	td_read
	bne	.reset_to_default

	; Calculate a simple checksum over the block. The checksum is
	; stored in the last longword (#127). It is calculated by summing
	; up the first 127 longwords and inverting the result (to make
	; sure that a zero-block is invalid).

	move.l	a2,a0
	moveq	#0,d0
	moveq	#126,d1
.1:	add.l	(a0)+,d0
	dbf	d1,.1

	not.l	d0
	cmp.l	(a0),d0
	bne	.reset_to_default
	rts				; ok, high scores are valid


.reset_to_default:
	; Fill the high score table with default entries.

	move.l	sp,a0
	move.l	#DEFHISCORE_LO<<8,-(sp)
	move.l	sp,a1
	move.l	#DEFHISCORE_STEP<<8,-(sp)

	lea	HISCORE_RANKS*sizeof_HS-sizeof_HS(a2),a2
	moveq	#HISCORE_RANKS-1,d1

.2:	move.l	(a1),(a2)		; HSscore and HSstart
	addq.l	#1,(a2)+

	; calculate next higher score
	sub.w	d0,d0			; clear X
	abcd	-(a1),-(a0)		; adds HSstart, which is always 0
	abcd	-(a1),-(a0)		; now add 6 BCD digits of HSscore...
	abcd	-(a1),-(a0)
	abcd	-(a1),-(a0)
	addq.l	#4,a0
	addq.l	#4,a1

	move.b	#1,(a2)+		; HSend
	clr.b	(a2)+			; HSlives

	; copy default name
	moveq	#HISCORE_NAMELEN-1,d0
	lea	DefaultEntryName(pc),a3
.3:	move.b	(a3)+,(a2)+
	dbf	d0,.3

	; skip the unused part of the entry
	lea	sizeof_HS-HISCORE_NAMELEN-HSname(a2),a2

	; loop to next higher rank
	lea	-2*sizeof_HS(a2),a2
	dbf	d1,.2

	addq.l	#8,sp
	bra	checksumHiscores


	; Default entry in high score list. Must not exceed the length of
	; HISCORE_NAMELEN characters.
DefaultEntryName:
	DEFAULT_ENTRY_NAME
DefaultEntryNameEnd:
	dcb.b	HISCORE_NAMELEN-(DefaultEntryNameEnd-DefaultEntryName),32
	even


;---------------------------------------------------------------------------
insertHiscore:
; Insert new high score into the table. Request writing of the new
; high score list to disk.
; Registers, except a4 - a6, are not preserved!

	move.l	Score(a4),d2
	lsr.l	#8,d2			; d2 last score in BCD
	move.l	Hiscores(a4),a2
	clr.w	LastRank(a4)

	; find the first rank with a lower score
	move.l	a2,a0
	moveq	#HISCORE_RANKS-1,d1
.1:	addq.w	#1,LastRank(a4)
	move.l	HSscore(a0),d0
	lea	sizeof_HS(a0),a0
	lsr.l	#8,d0
	cmp.l	d2,d0
	dblo	d1,.1
	lea	-sizeof_HS(a0),a3	; a3 entry location

	lea	HISCORE_RANKS*sizeof_HS-sizeof_HS(a2),a0
	cmp.l	a3,a0
	beq	.4			; score is last rank

	; move all entries below one rank down
.2:	move.l	a0,a1
	lea	-sizeof_HS(a0),a0
	moveq	#(sizeof_HS/4)-1,d0
.3:	move.l	(a0)+,(a1)+
	dbf	d0,.3
	lea	-sizeof_HS(a0),a0
	cmp.l	a3,a0
	bhi	.2

	; enter new score
.4:	move.l	Score(a4),d0
	move.b	StartLevel+1(a4),d0
	move.l	d0,(a3)+		; HSscore and HSstart
	move.b	Level+1(a4),(a3)+	; HSend (end level)
	move.b	Lives(a4),(a3)+		; HSlives

	; copy the name from the InputBuffer
	lea	InputBuffer(a4),a0
	moveq	#HISCORE_NAMELEN-1,d0
.5:	move.b	(a0)+,(a3)+
	dbeq	d0,.5
	bne	checksumHiscores

	; fill up with blanks
	moveq	#' ',d1
	subq.l	#1,a3
.6:	move.b	d1,(a3)+
	dbf	d0,.6


;---------------------------------------------------------------------------
checksumHiscores:
; Calculate and write checksum for high scores table.

	move.l	Hiscores(a4),a0
	moveq	#0,d0
	moveq	#126,d1
.1:	add.l	(a0)+,d0
	dbf	d1,.1
	not.l	d0
	move.l	d0,(a0)
	rts


;---------------------------------------------------------------------------
qualifyScore:
; Check if the current score is higher than the lowest rank's score.
; -> d0/Z = zero means score is too low for high scores

	cmp.b	#$99,Lives(a4)
	beq	.1			; no highscore when cheating

	move.l	Hiscores(a4),a0
	move.l	HISCORE_RANKS*sizeof_HS-sizeof_HS+HSscore(a0),d0
	lsr.l	#8,d0

	move.l	Score(a4),d1
	lsr.l	#8,d1

	cmp.l	d0,d1
	bhi	.2
.1:	moveq	#0,d0			; too low
	rts
.2:	moveq	#1,d0			; new entry!
	rts



	section	__MERGED,data


	; Menu color table, 32xRGB4
MenuColors:
	incbin	"gfx/menu.cmap"

	; Types of sparkling star images
StarsTypes:
	incbin	"gfx/starstypes.bin"

	; NUM_STARS_ANIMS entries with:
	; First animation frame and number of animation frames.
StarsAnimData:
	dc.w	0,5
	dc.w	8,4

	; pointer to high score table
Hiscores:
	dc.l	HiscoresBuffer



	section	__MERGED,bss


	; Remember the base Chip RAM address for all data loaded by
	; the menu. So it can be deallocated on exit.
MenuChipPtr:
	ds.l	1

	; Pointers to masked menu graphics of various size.
LogoSolid:
	ds.l	1
LogoGold:
	ds.l	1
Pointer:
	ds.l	1

	; Table of sparkling stars animations.
StarsAnims:
	ds.l	STARSTYPES

	; Rank of last highscore entry.
LastRank:
	ds.w	1

	; Starting xpos to display the input.
InputX:
	ds.w	1

	; Counts each rendered frame.
FrameCnt:
	ds.w	1

	; Menu animation phase.
	; - Start up, change NrmColors to full intensity.
	; - Credits menu.
	; - Main menu.
Phase:
	ds.w	1

	; MOB structures for sparkling stars.
Stars:
	ds.b	NUM_STARS*sizeof_Star

	; Start and stop vertical raster position for color changes.
ColorVStart:
	ds.w	1
ColorVStop:
	ds.w	1

	; Current menu colors (outside of the dimmed region).
NrmColors:
	ds.w	NCOLORS

	; Current menu colors in the dimmed region between ColorVStart/Stop.
DimColors:
	ds.w	NCOLORS

	; Current low and high RGB4 color contraints for the mirror region.
MirrorColorRange:
	ds.w	2

	; Current mirrored colors (outside of the dimmed region).
NrmMirrColors:
	ds.w	NCOLORS

	; Current mirrored colors inside the dimmed region:
	; MIRROR_VPOS+(MIRROR_VPOS-ColorVStop)+1 to
	; MIRROR_VPOS+(MIRROR_VPOS-ColorVStart)
DimMirrColors:
	ds.w	NCOLORS

	; Selected color intensities ($00-$ff).
NrmIntensity:
	ds.w	1
DimIntensity:
	ds.w	1

	; Current color intensities of menu color tables. They are
	; recalculated when the above selected intensities differ.
NrmColIntens:
	ds.w	1
DimColIntens:
	ds.w	1

	; General purpose index used in current phase (credits, menu item, ..)
Index:
	ds.w	1

	; Current state in credits phase.
	; 0 is instensity modification. Higher values indicate deletion
	; or drawing of a credits text.
CredIndex:
	ds.w	1

	; Do nothing for the specified number of frames
Delay:
	ds.w	1

	; Add this to DimIntensity until $00 or $ff is reached
DeltaIntensity:
	ds.w	1

	; Entered password or name for high scores
InputBuffer:
	ds.b	VINPBUFSIZE

	; Flags to control the release of the joystick or button
LastUp:
	ds.b	1
LastDown:
	ds.b	1
LastButton:
	ds.b	1

	; Selected level number of -1 for introduction
Action:
	ds.b	1

	; True, when the player wants to play the game, or see the intro
QuitMenu:
	ds.b	1

	; True, when a new high score should be entered.
NewHighscore:
	ds.b	1

	; True, when the high score table has to be written back to disk
WriteFlag:
	ds.b	1
	even



	data


	; Credits
	CREDTXT	8,Cred1Cat,"CREATED IN 2013 BY"
	CREDTXT	8,Cred2Cat,"PROGRAMMING"
	CREDTXT	8,Cred3Cat,"GRAPHICS"
	CREDTXT	8,Cred4Cat,"MUSIC"
	CREDTXT	8,Cred5Cat,"LEVEL DESIGN"
	CREDTXT	8,Cred6Cat,"STORY"
	CREDTXT	8,Cred7Cat,"BETA TESTING"

	CREDTXT	16,Cred1Name,"NIGHT OWL DESIGN"
	CREDTXT	16,Cred2Name,"FRANK WILLE"
	CREDTXT	16,Cred3Name,"GERRIT WILLE"
	CREDTXT	16,Cred4Name,"PIERRE HORN"
	CREDTXT	16,Cred5Name,"DAVID STEVES"
	CREDTXT	16,Cred6Name,"MARCUS GERARDS"

	; Menu items
Menu1Txt:
	dc.b	"START GAME",0
Menu2Txt:
	dc.b	"CONTINUE GAME",0
Menu3Txt:
	dc.b	"ENTER PASSWORD",0
Menu4Txt:
	dc.b	"INTRODUCTION",0
Menu5Txt:
	dc.b	"HIGH SCORES",0
Menu6Txt:
	dc.b	"CREDITS",0
	even



	bss


	; Buffer for the high scores table. Only the first block is needed,
	; but we have to write (format) the whole track.
HiscoresBuffer:
	ds.b	512
	ifd	TDFORMAT
	ds.b	10*512
	endif
