*
* Loading animation when a new world is entered
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* newworld_screen()
*

	include	"display.i"
	include	"view.i"
	include	"world.i"
	include	"hero.i"
	include	"files.i"


; screen layout
WPIC_Y		equ	12
WLOADING_Y	equ	220

; space between the end of the picture and start of the description text
WDESCR_OFFS	equ	8

; hero animation
MAXANIMCNT	equ	8
MAXANIMOFFS	equ	4*4


; from memory.asm
	xref	AllocFromTop

; from trackdisk.asm
	xref	td_loadcr_chip

; from main.asm
	xref	set_vertb_irq
	xref	loaderr

; from display.asm
	xref	make_stdviews
	xref	write_clist_colors
	xref	write_clist_wait
	xref	startclist
	xref	View

; from blit.asm
	xref	clear_display
	xref	bltclear
	xref	bltimg
	xref	bltcopy

; from font.asm
	xref	load_smallfont
	xref	mfont8_center
	xref	Font8Colors

; from hero.asm
	xref	HeroColors
	xref	HeroAnims

; from music.asm
	xref	loadChipMusic
	xref	startChipMusic



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	newworld_screen
newworld_screen:
; Show a screen with a picture characterizing the new world and a short
; text below it. Start a VERTB animation which shows the hero running and
; jumping.
; a2 = World resource pointer

	movem.l	d2-d3/a3/a5,-(sp)

	; Allocate all memory from top of Chip RAM, so it is not
	; overwritten during loading of world data and we can easily
	; deallocate it after loading is done.
	st	AllocFromTop(a4)

	; first load and start the loading music
	moveq	#0,d0
	move.b	WFloadmod(a2),d0
	bsr	loadChipMusic
	moveq	#0,d0
	moveq	#LOADWORLD_VOL,d1
	bsr	startChipMusic

	; load 8px font
	bsr	load_smallfont

	; Load a small picture which characterizes the new world.
	; WARNING: It is assumed to have a width, which is a multiple
	; of 16, and is preceded by a header.
	moveq	#0,d0
	move.b	WFpicture(a2),d0
	bsr	td_loadcr_chip
	move.l	d0,WorldPicture(a4)
	beq	loaderr
	move.l	d0,a3			; a3 world picture header

	; set up the display
	lea	newworld_clist(pc),a0
	bsr	make_stdviews

	; We are using the first View. No double buffering.
	move.l	View(a4),a5
	bsr	clear_display

	; blit the picture
	move.w	(a3)+,d2		; width
	move.w	#DISPW,d0
	sub.w	d2,d0
	asr.w	#1,d0			; center it horizontally
	moveq	#WPIC_Y,d1
	asr.w	#4,d2			; width in words
	move.w	(a3)+,d3		; height
	lea	64(a3),a0		; skip color table to image data
	bsr	bltimg

	; print description
	moveq	#0,d0
	move.b	WFworld(a2),d0		; current world: 1, 2, 3 or 4
	lsl.w	#2,d0
	lea	Descriptions(a4),a0
	move.l	-4(a0,d0.w),a0
	move.l	WorldPicture(a4),a1
	moveq	#WPIC_Y+WDESCR_OFFS,d2
	add.w	2(a1),d2
	bsr	print_description

	; print "loading" centered
	move.w	#WLOADING_Y,d1
	lea	LoadingTxt(pc),a0
	bsr	mfont8_center

	; Now start the display DMA.
	bsr	startclist

	move.w	#MAXANIMCNT-1,AnimCnt(a4)
	clr.w	AnimOffs(a4)
	lea	newworld_anim(pc),a0
	bsr	set_vertb_irq

	; Do normal Chip RAM allocations again, while loading the world.
	clr.b	AllocFromTop(a4)

	movem.l	(sp)+,d2-d3/a3/a5
	rts


LoadingTxt:
	dc.b	"LOADING",0
	even


;---------------------------------------------------------------------------
print_description:
; Print a world description text. Each line is terminated by zero. The
; last line by two zeros. Each line is centered. The first line is printed
; on top of the picture (ypos=0).
; a0 = description text start
; d2 = starting ypos for the second and following lines

	move.l	a2,-(sp)
	move.l	a0,a2
	moveq	#0,d1
	bsr	mfont8_center		; print the location on top
	bra	.2

	; print next line centered below the picture
.1:	move.l	a2,a0
	move.w	d2,d1
	bsr	mfont8_center

	; go to next line
	addq.w	#8,d2
.2:	tst.b	(a2)+
	bne	.2
	tst.b	(a2)
	bne	.1

	move.l	(sp)+,a2
	rts


;---------------------------------------------------------------------------
newworld_clist:
; Append color tables for the picture, the text and the hero to the
; standard copper list.
; a0 = copper list pointer
; a5 = View
; -> a0 = new copperlist pointer

	movem.l	d2/a2,-(sp)
	moveq	#0,d2			; WAIT $100 flag for write_clist_wait

	; text colors for description header
	lea	Font8Colors(a4),a1
	bsr	write_clist_colors

	; picture colors
	move.l	WorldPicture(a4),a2
	moveq	#VSTART+WPIC_Y-1,d0
	bsr	write_clist_wait
	lea	4(a2),a1
	bsr	write_clist_colors

	; text colors for description
	moveq	#VSTART+WPIC_Y+WDESCR_OFFS-1,d0
	add.w	2(a2),d0
	bsr	write_clist_wait
	lea	Font8Colors(a4),a1
	bsr	write_clist_colors

	; hero colors
	move.w	#VSTART+WLOADING_Y-HEROH-2,d0
	bsr	write_clist_wait
	lea	HeroColors(a4),a1
	bsr	write_clist_colors

	; text colors again (for "loading")
	move.w	#VSTART+WLOADING_Y-1,d0
	bsr	write_clist_wait
	lea	Font8Colors(a4),a1
	bsr	write_clist_colors

	movem.l	(sp)+,d2/a2
	rts


;---------------------------------------------------------------------------
newworld_anim:
; Loading animation. Show the hero running right on top of the "loading"
; text.
; Running in VERTB interrupt.
; a4 = SmallData base
; a6 = CUSTOM

	move.l	View(a4),a5

	move.w	AnimCnt(a4),d0
	addq.w	#1,d0
	cmp.w	#MAXANIMCNT,d0
	bne	.2

	; next animation phase
	move.w	AnimOffs(a4),d0
	addq.w	#4,d0
	cmp.w	#MAXANIMOFFS,d0
	bne	.1
	moveq	#0,d0
.1:	move.w	d0,AnimOffs(a4)

	; get image pointer for this phase
	lea	HeroAnims(a4),a0
	add.w	#HERO_ANIMRIGHT,d0
	move.l	(a0,d0.w),a0

	; update animation on screen
	move.w	#(DISPW-HEROW)/2,d0
	move.w	#WLOADING_Y-HEROH-1,d1
	moveq	#HEROW>>4,d2
	move.w	#HEROH*PLANES,d3
	bsr	bltcopy
	moveq	#0,d0

.2:	move.w	d0,AnimCnt(a4)
	rts



	data


	; A short text, introducing the new world. Appears below the picture.
	;        0.........1.........2.........3.........
World1Txt:
	dc.b	"LONDON, LORD MONTGOMERY'S MANSION.",0
	dc.b	"THE LORD CLOSED HIS EYES AND STOPPED",0
	dc.b	"BREATHING. JOHN KAYLE ESCAPED THROUGH",0
	dc.b	"THE SECRET DOOR AND STARTED SEARCHING",0
	dc.b	"FOR THE HOLY ARTEFACT.",0,0
World2Txt:
	dc.b	"TIKAL, GUATEMALA.",0
	dc.b	"AFTER KAYLE GOT RID OF HIS PURSUERS,",0
	dc.b	"HE INSPECTED THE STRANGE FRAGMENT OF",0
	dc.b	"A RELIEF HE HAD MANAGED TO SNATCH FROM",0
	dc.b	"THEM. JOHN REALISED THAT THE JOURNEY",0
	dc.b	"WOULD NOW TAKE HIM TO TIKAL, THE",0
	dc.b	"LEGENDARY CITY OF THE MAYAS.",0,0
World3Txt:
	dc.b	"GIZEH, EGYPT.",0
	dc.b	"KAYLE LOOKED AT ANOTHER PIECE OF THE",0
	dc.b	"RELIEF IN HIS HANDS. IN ITS MIDDLE,",0
	dc.b	"THERE WAS A GIANT SPHINX. NOW HE WAS",0
	dc.b	"SURE: MORE ANSWERS COULD ONLY BE FOUND",0
	dc.b	"IN EGYPT, BENEATH THE SPHINX.",0,0
World4Txt:
	dc.b	"BABYLON, IRAQ.",0
	dc.b	"STILL RESTLESS, KAYLE FORCED HIMSELF TO",0
	dc.b	"RELAX IN HIS SEAT. HE HAD REACHED THE",0
	dc.b	"AIRCRAFT, BUT THE MEMBERS OF THAT",0
	dc.b	"SECRET SOCIETY WERE SURELY STILL CHASING",0
	dc.b	"AFTER HIM. YET THE GATE OF ISHTAR HAD",0
	dc.b	"SHOWN HIM HIS NEW DESTINATION: BABYLON.",0,0



	section	__MERGED,data


	; pointers to world descriptions
Descriptions:
	dc.l	World1Txt,World2Txt,World3Txt,World4Txt



	section	__MERGED,bss


	; Pointer to the world picture's header. Format:
	; 0: width
	; 2: height
	; 4: color map (32 RGB4 color entries)
	; 68: interleaved picture data
WorldPicture:
	ds.l	1

	; current hero animation phase
AnimCnt:
	ds.w	1
AnimOffs:
	ds.w	1
