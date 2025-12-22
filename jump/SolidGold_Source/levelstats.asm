*
* Show level statistics and extra bonus.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* init_stats()
* level_stats(d0.b=song, a0=colortable)
*
* StatAct
* LivesLost
* LevelJumps
* LevelDistance
* LevelTime
*

	include	"display.i"
	include	"view.i"
	include	"font.i"
	include	"map.i"
	include	"game.i"
	include	"hero.i"
	include	"sound.i"
	include	"levelstats.i"


; screen layout
HEADER_ROW	equ	1
COLLITEMS_ROW	equ	6
ITEMS_ROW	equ	8
LEFTCOL		equ	2

ITEMNAM_COL	equ	LEFTCOL+3	; item name
ITEMCOLL_COL	equ	LEFTCOL+22	; number of items collected
ITEMTOT_COL	equ	LEFTCOL+26	; total number of items in level
ITEMBON_COL	equ	LEFTCOL+31	; bonus score +0000

NUM_EXTRASTATS	equ	3
EXTRASTATS_ROW	equ	ITEMS_ROW+2*NUM_STATS
DASHED_ROW	equ	EXTRASTATS_ROW+NUM_EXTRASTATS+1
SCORE_COL	equ	LEFTCOL+30	; start column of score digits

; hero animation
STATHERO_Y	equ	2*GAMEFONTH+2
MAXANIMCNT	equ	16
MAXANIMOFFS	equ	2*4		; two animation phases

; macro for item text and counters
	macro	ITEM
\1:	dc.b	\2
\1End:
	dcb.b	(ITEMCOLL_COL-ITEMNAM_COL)-(\1End-\1),' '
	dc.b	"000/000",0
	endm


; from input.asm
	xref	readController

; from main.asm
	xref	set_vertb_irq
	xref	clr_vertb_irq
	xref	divu32

; from display.asm
	xref	display_off
	xref	make_stdviews
	xref	startdisplay
	xref	waitvertb
	xref	View

; from game.asm
	xref	addScore
	xref	Score
	xref	Level

; from fgblocks.asm
	xref	getFgTypeImage
	xref	countFgItems

; from hero.asm
	xref	HeroAnims

; from monster.asm
	xref	getMonster16Image
	xref	count_monsters

; from newlevel.asm
	xref	StageStrings

; from blit.asm
	xref	clear_display
	xref	bltcopy
	xref	bltclear

; from font.asm
	xref	mfont8_center
	xref	mfont8_print

; from music.asm
	xref	startMusic
	xref	stopMusic
	xref	musicFadeIn
	xref	musicFadeOut

; from sound.asm
	xref	playSFX



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	init_stats
init_stats:
; Reset all statistic counters, count monsters and collectable items
; in the current map.

	move.l	a2,-(sp)
	lea	StatSet(a4),a2

	; reset statistic counters
	move.l	a2,a0
	lea	StatAct(a4),a1
	moveq	#Stat_sizeof/2-1,d0
.1:	clr.w	(a0)+
	clr.w	(a1)+
	dbf	d0,.1

	clr.w	LivesLost(a4)
	clr.w	LevelJumps(a4)
	clr.l	LevelDistance(a4)
	clr.l	LevelTime(a4)

	; count items in foreground map
	move.l	a2,a0
	bsr	countFgItems

	; count killable monsters
	bsr	count_monsters
	move.w	d0,Stat_Killed(a2)

	move.l	(sp)+,a2
	rts


;---------------------------------------------------------------------------
	xdef	level_stats
level_stats:
; Open a new screen and display all statistics about the finished level.
; Assume that the 8px font is already loaded (which should have happened
; at the beginning of each new world).
; d0.b = song position to play
; a0 = world's color table

	movem.l	d2-d3/a2-a3/a5,-(sp)
	move.l	a0,-(sp)		; save colortable
	move.w	d0,-(sp)		; song position

	;------------------
	; Init the display.
	;------------------

	bsr	display_off

	; make sure joystick button has been released again
.1:	bsr	waitvertb
	moveq	#1,d0
	bsr	readController
	tst.l	d0
	bmi	.1

	; set up the display
	sub.l	a0,a0
	bsr	make_stdviews

	; We are using the first View. No double buffering.
	move.l	View(a4),a5
	bsr	clear_display

	;------------------------------------
	; Write static texts onto the screen.
	;------------------------------------

	; make and print statistics header on top of the screen
	move.l	Header(a4),a0
	lea	HeaderStageTxt-HeaderTxt(a0),a1
	lea	StageStrings(a4),a2
	move.w	Level(a4),d0
	lsl.w	#2,d0
	add.w	d0,a2
	move.b	(a2)+,(a1)+
	move.b	(a2)+,(a1)+
	move.b	(a2),(a1)
	moveq	#HEADER_ROW*GAMEFONTH,d1
	bsr	mfont8_center		; LEVEL x-y STATISTICS

	move.w	#MAXANIMCNT-1,AnimCnt(a4)
	clr.w	AnimOffs(a4)
	bsr	update_anim		; draw the initial hero image

	; print collected items section
	move.l	CollItems(a4),a0
	moveq	#LEFTCOL*GAMEFONTW,d0
	moveq	#COLLITEMS_ROW*GAMEFONTH,d1
	bsr	mfont8_print

	bsr	print_collected_items

	; additional statistics
	bsr	print_additional_items

	; print dashed line for final score
	moveq	#0,d2
	move.w	#'-'<<8,-(sp)
.2:	move.l	sp,a0
	move.w	d2,d0
	move.w	#DASHED_ROW*GAMEFONTH,d1
	bsr	mfont8_print
	addq.w	#GAMEFONTW,d2
	cmp.w	#DISPW,d2
	blo	.2
	addq.l	#2,sp

	; print extra bonus and score line
	move.l	ExtraBonus(a4),a0
	moveq	#LEFTCOL*GAMEFONTW,d0
	move.w	#(DASHED_ROW+1)*GAMEFONTH,d1
	bsr	mfont8_print

	move.l	TheScore(a4),a0
	moveq	#LEFTCOL*GAMEFONTW,d0
	move.w	#(DASHED_ROW+2)*GAMEFONTH,d1
	bsr	mfont8_print
	bsr	printScore

	;-----------------------------------
	; start statistics background music
	;-----------------------------------

	move.w	(sp)+,d0		; world's statistic tune
	moveq	#0,d1			; volume will be increased later
	bsr	startMusic

	;---------------------------------------------
	; Show the screen and animate it during VERTB.
	;---------------------------------------------

	; Load the world's colors and start the display DMA.
	move.l	(sp)+,a0
	bsr	startdisplay

	; reset animated statistic counters
	lea	StatCnt(a4),a0
	lea	StatAsc(a4),a1
	move.l	#$30303000,d1		; "000"
	moveq	#NUM_STATS-1,d0
.3:	clr.w	(a0)+
	move.l	d1,(a1)+
	dbf	d0,.3

	; reset variables
	clr.w	Row(a4)
	clr.w	TotalBonus(a4)
	clr.w	FadeOut(a4)
	clr.b	ButtonPressed(a4)
	clr.b	Quit(a4)

	lea	animate_stats(pc),a0
	bsr	set_vertb_irq

wait_for_button:
	tst.b	Quit(a4)
	beq	wait_for_button

	;-----------------------------------------
	; cleanup - stop VERTB animation and music
	;-----------------------------------------

	bsr	clr_vertb_irq
	bsr	stopMusic

	movem.l	(sp)+,d2-d3/a2-a3/a5
	rts


;---------------------------------------------------------------------------
print_collected_items:
; Print all collectable items with the amount initially present in the map.
; a5 = View

	movem.l	d2-d5/a2-a3,-(sp)

	moveq	#NUM_STATS-1,d4
	moveq	#ITEMS_ROW*GAMEFONTH,d5
	lea	Items(a4),a2
	lea	StatSet(a4),a3

.1:	move.b	.imgtypes(pc,d4.w),d0
	beq	.4
	bpl	.2

	bsr	getMonster16Image	; look for first monster16 image
	tst.l	d0
	beq	.4
	move.l	d0,a0
	bra	.3

.2:	bsr	getFgTypeImage		; foreground tile of this type

	; draw an image of the item at the left border
.3:	moveq	#LEFTCOL*GAMEFONTW,d0
	move.w	d5,d1
	subq.w	#4,d1
	moveq	#1,d2
	moveq	#16*PLANES,d3
	bsr	bltcopy

	; print name and total number of items
.4:	move.l	(a2)+,a0
	lea	ITEMTOT_COL-ITEMNAM_COL(a0),a1
	move.w	(a3)+,d0
	bsr	insert3digits
	moveq	#ITEMNAM_COL*GAMEFONTW,d0
	move.w	d5,d1
	bsr	mfont8_print

	add.w	#2*GAMEFONTH,d5		; next row
	dbf	d4,.1

	movem.l	(sp)+,d2-d5/a2-a3
	rts

	; Table of foreground block types for each statistic entry,
	; from Stat_ExtraLives to Stat_Gold (reverse!).
.imgtypes:
	dc.b	FB_EXTRALIFE,-1,FB_RUBY,FB_DIAMOND,FB_EMERALD,FB_COIN
	even


;---------------------------------------------------------------------------
insert3digits:
; Convert an unsigned 16-bit word into 3 decimal ASCII digits.
; d0.w = value to insert
; a1 = destination pointer
; -> a1 = pointer after inserted digits
; a0 is preserved!

	moveq	#0,d1
	move.w	d0,d1
	moveq	#'0',d0
	divu	#100,d1
	add.b	d0,d1
	move.b	d1,(a1)+
	clr.w	d1
	swap	d1
	divu	#10,d1
	add.b	d0,d1
	move.b	d1,(a1)+
	swap	d1
	add.b	d0,d1
	move.b	d1,(a1)+
	rts


;---------------------------------------------------------------------------
print_additional_items:
; Print additional statistical information lines.
; a5 = View

	movem.l	d2-d3/a2-a3,-(sp)
	subq.l	#8,sp			; ASCII buffer (max. 7 digits)

	moveq	#NUM_EXTRASTATS-1,d2
	move.w	#EXTRASTATS_ROW*GAMEFONTH,d3
	lea	AddItems(a4),a2
	lea	AddStats(a4),a3

	; print description
.1:	move.l	(a2)+,a0
	moveq	#LEFTCOL*GAMEFONTW,d0
	move.w	d3,d1
	bsr	mfont8_print

	; convert counter into an ASCII string and print it
	move.l	(a3)+,a0
	move.l	(a0),d0
	move.l	sp,a0
	bsr	ulong2str
	move.w	#ITEMCOLL_COL*GAMEFONTW,d0
	move.w	d3,d1
	bsr	mfont8_print

	addq.w	#GAMEFONTH,d3		; next row
	dbf	d2,.1

	; print level time in MM:SS
	move.l	TimeNeeded(a4),a0
	moveq	#LEFTCOL*GAMEFONTW,d0
	move.w	d3,d1
	bsr	mfont8_print

	; convert number of frames spend into seconds
	move.l	LevelTime(a4),d0
	moveq	#50,d1
	bsr	divu32

	move.l	sp,a0
	divu	#60,d0
	bsr	.write2digits		; minutes
	move.b	#':',(a0)+
	swap	d0
	bsr	.write2digits		; seconds
	clr.b	(a0)

	move.l	sp,a0
	move.w	#ITEMCOLL_COL*GAMEFONTW,d0
	move.w	d3,d1
	bsr	mfont8_print

	addq.l	#8,sp
	movem.l	(sp)+,d2-d3/a2-a3
	rts

.write2digits:
	moveq	#0,d1
	move.w	d0,d1
	divu	#10,d1
	add.b	#'0',d1
	move.b	d1,(a0)+
	swap	d1
	add.b	#'0',d1
	move.b	d1,(a0)+
	rts


;---------------------------------------------------------------------------
ulong2str:
; Convert an unsigned 32-bit value into a decimal string up to 7 digits.
; d0 = unsigned 32-bit value
; a0 = destination string buffer (8 bytes)
; -> a0 = pointer to beginning of converted ASCII string

	movem.l	d2-d3,-(sp)

	moveq	#'0',d2
	moveq	#7-1,d3
	addq.l	#8,a0
	moveq	#0,d1

.1:	move.b	d1,-(a0)
	moveq	#10,d1
	bsr	divu32
	add.b	d2,d1
	tst.l	d0
	dbeq	d3,.1

	move.b	d1,-(a0)

	movem.l	(sp)+,d2-d3
	rts


;---------------------------------------------------------------------------
printScore:
; Print the 6-digit BCD score.

	subq.l	#8,sp			; ASCII buffer

	; convert BCD score to ASCII
	lea	Score(a4),a0
	move.l	sp,a1
	bsr	insertBCDdigits
	bsr	insertBCDdigits
	bsr	insertBCDdigits
	clr.b	(a1)

	; print it
	move.l	sp,a0
	move.w	#SCORE_COL*GAMEFONTW,d0
	move.w	#(DASHED_ROW+2)*GAMEFONTH,d1
	bsr	mfont8_print

	addq.l	#8,sp
	rts


;---------------------------------------------------------------------------
printBonus:
; Print a bonus in the form "+9999" from two BCD bytes.
; a0 = pointer to BCD bonus (4 digits)
; d6.w = text ypos

	subq.l	#8,sp

	; convert BCD bonus to ASCII
	move.l	sp,a1
	move.b	#'+',(a1)+
	bsr	insertBCDdigits
	bsr	insertBCDdigits
	clr.b	(a1)

	; print it
	move.l	sp,a0
	move.w	#ITEMBON_COL*GAMEFONTW,d0
	move.w	d6,d1
	bsr	mfont8_print

	addq.l	#8,sp
	rts


;---------------------------------------------------------------------------
insertBCDdigits:
; Convert two BCD digits into two decimal ASCII digits.
; a0 = Pointer to BCD byte
; a1 = Pointer to destination string
; -> a0 = updated BCD pointer
; -> a1 = updated destination pointer

	move.b	(a0)+,d0
	moveq	#15,d1
	and.b	d0,d1
	lsr.b	#4,d0
	add.b	#'0',d0
	move.b	d0,(a1)+
	add.b	#'0',d1
	move.b	d1,(a1)+
	rts


;---------------------------------------------------------------------------
addBonus:
; Add a 4-digit BCD to the total bonus given (TotalBonus).
; d0.w = additional bonus in BCD
; All registers, except d0, are preserved!

	movem.l	a0-a1,-(sp)

	move.l	sp,a0
	move.w	d0,-(sp)
	lea	TotalBonus+2(a4),a1
	sub.w	d0,d0			; clear X
	abcd	-(a0),-(a1)
	abcd	-(a0),-(a1)
	addq.l	#2,sp
	bcc	.1

	; total BCD bonus overflowed, reset to $9999
	move.b	#$99,d0
	move.b	d0,(a1)+
	move.b	d0,(a1)

.1:	movem.l	(sp)+,a0-a1
	rts


;---------------------------------------------------------------------------
animate_stats:
; Animate statistics line and by line.
; Running in VERTB interrupt.
; a4 = SmallData base
; a6 = CUSTOM

	move.l	View(a4),a5

	; first draw the next hero animation, which is most time critical
	bsr	update_anim

	move.w	Row(a4),d7		; current row to animate
	bmi	.update_volume

	cmp.w	#NUM_STATS,d7
	bhs	.show_bonus

	;------------------------------
	; Count up to the actual value.
	;------------------------------

	add.w	d7,d7			; Row*2 to index statistic entries
	moveq	#ITEMS_ROW,d6
	add.w	d7,d6			; d6 row to update on screen
	lsl.w	#3,d6			; *GAMEFONTH

	lea	StatCnt(a4),a0
	lea	StatAct(a4),a1
	move.w	(a0,d7.w),d0
	cmp.w	(a1,d7.w),d0		; finished counting?
	bne	.2

	cmp.w	#Stat_ExtraLives,d7
	beq	.1			; no bonus for extra lives found

	; Counted up to actual value. Check if it matches the total value.
	lea	StatSet(a4),a0
	cmp.w	(a0,d7.w),d0
	blo	.1

	; Grant a bonus for collecting all items of this category!
	moveq	#SND_BONUS,d0
	bsr	playSFX			; play sound effect

	lea	ItemBonus(a4),a0
	add.w	d7,a0
	move.w	(a0),d0
	bsr	addScore		; add to BCD score
	move.w	(a0),d0
	bsr	addBonus		; add to total BCD bonus
	bsr	printBonus

	; done with this item category, proceed to the next one
.1:	addq.w	#1,Row(a4)
	bra	.update_volume

	;-------------------------------------------
	; Increment and update current item counter.
	;-------------------------------------------

.2:	addq.w	#1,d0
	move.w	d0,(a0,d7.w)

	; clear the 3-digit region with the Blitter
	move.w	#ITEMCOLL_COL*GAMEFONTW,d0
	move.w	d6,d1
	moveq	#3*GAMEFONTW,d2
	moveq	#GAMEFONTH*PLANES,d3
	bsr	bltclear

	; update the counter string while the Blitter is busy
	lea	StatAsc(a4),a0
	add.w	d7,a0
	add.w	d7,a0
	lea	3(a0),a1

.3:	move.b	-(a1),d0
	cmp.b	#'9',d0
	blo	.4
	move.b	#'0',(a1)
	bra	.3
.4:	addq.b	#1,d0
	move.b	d0,(a1)

	; print new counter
	move.w	#ITEMCOLL_COL*GAMEFONTW,d0
	move.w	d6,d1
	bsr	mfont8_print
	bra	.update_volume

	;----------------------------------------------
	; Show any bonus, when given, and update score.
	;----------------------------------------------

.show_bonus:
	bhi	.show_score

	lea	TotalBonus(a4),a0
	tst.w	(a0)
	beq	.5

	; there was at least one bonus, so print the total bonus
	move.w	#(DASHED_ROW+1)*GAMEFONTH,d6
	bsr	printBonus

.5:	addq.w	#1,Row(a4)		; go to score
	bra	.update_volume

.show_score:
	; clear the old score with the Blitter
	move.w	#SCORE_COL*GAMEFONTW,d0
	move.w	#(DASHED_ROW+2)*GAMEFONTH,d1
	moveq	#6*GAMEFONTW,d2
	moveq	#GAMEFONTH*PLANES,d3
	bsr	bltclear

	; and update it
	bsr	printScore
	st	Row(a4)			; done with all statistics

	;--------------------------------
	; Update background music volume.
	;--------------------------------

.update_volume:
	tst.w	FadeOut(a4)
	beq	.6

	; music fade out
	move.l	#$20000,d0
	bsr	musicFadeOut

	subq.w	#1,FadeOut(a4)
	seq	Quit(a4)		; quit statistics when music is gone
	rts

	; music fade in
.6:	move.l	#$20000,d0
	moveq	#STATS_VOLUME,d1
	bsr	musicFadeIn

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
	move.w	#STATS_VOLUME/2,FadeOut(a4)

.9:	rts


;---------------------------------------------------------------------------
update_anim:
; Draw the next hero animation on top of the screen.
; a5 = View

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
	add.w	#HERO_DONE,d0
	move.l	(a0,d0.w),a0

	; update animation on screen
	move.w	#(DISPW-HEROW)/2,d0
	moveq	#STATHERO_Y,d1
	moveq	#HEROW>>4,d2
	move.w	#HEROH*PLANES,d3
	bsr	bltcopy
	moveq	#0,d0

.2:	move.w	d0,AnimCnt(a4)
	rts



	section	__MERGED,data


	; string pointers
Header:
	dc.l	HeaderTxt
CollItems:
	dc.l	CollItemsTxt
TimeNeeded:
	dc.l	TimeTxt
ExtraBonus:
	dc.l	ExtraBonusTxt
TheScore:
	dc.l	ScoreTxt

Items:		; Warning! Must be the same order as in the Stat structure!
	dc.l	GoldTxt,EmeraldsTxt,DiamondsTxt
	dc.l	RubysTxt,EnemKilledTxt,ExtraLivesTxt

	; BCD extra bonus, when collected all items of a category.
	; Order must be the same as in the Stat structure.
ItemBonus:
	dc.w	GOLDBONUS,EMRLDBONUS,DIAMBONUS,RUBYBONUS,KILLBONUS,0

	; Extra statistics. Same order of AddItems and AddStats required!
AddItems:
	dc.l	LivesLostTxt,DistCoveredTxt,NumJumpsTxt

	; Pointer to extra statistics
AddStats:
	dc.l	LivesLost-2,LevelDistance,LevelJumps-2



	data


	; statistical texts
HeaderTxt:
	dc.b	"LEVEL "
HeaderStageTxt:
	dc.b	"0-0 STATISTICS",0
CollItemsTxt:
	dc.b	"COLLECTED ITEMS",0

	ITEM	GoldTxt,"GOLD COINS"
	ITEM	EmeraldsTxt,"EMERALDS"
	ITEM	DiamondsTxt,"DIAMONDS"
	ITEM	RubysTxt,"RUBYS"
	ITEM	EnemKilledTxt,"ENEMIES KILLED"
	ITEM	ExtraLivesTxt,"EXTRA LIVES"

LivesLostTxt:
	dc.b	"LIVES LOST",0
DistCoveredTxt:
	dc.b	"DISTANCE IN PIXELS",0
NumJumpsTxt:
	dc.b	"NUMBER OF JUMPS",0
TimeTxt:
	dc.b	"TIME IN MM:SS",0

ExtraBonusTxt:
	dc.b	"EXTRA BONUS",0
ScoreTxt:
	dc.b	"SCORE",0
	even



	section	__MERGED,bss


	; statistical data, values present in level
StatSet:
	ds.b	Stat_sizeof

	; statistical data, actual values reached by player
	xdef	StatAct
StatAct:
	ds.b	Stat_sizeof

	; animated statistic counters
StatCnt:
	ds.b	Stat_sizeof

	; current statistic counter in ASCII
StatAsc:
	ds.b	NUM_STATS*4

	xdef	LivesLost
	ds.w	1
LivesLost:
	ds.w	1

	xdef	LevelJumps
	ds.w	1
LevelJumps:
	ds.w	1

	xdef	LevelDistance
LevelDistance:
	ds.l	1

	xdef	LevelTime
LevelTime:
	ds.l	1

	; hero animation
AnimCnt:
	ds.w	1
AnimOffs:
	ds.w	1

	; current statistic row to animate
Row:
	ds.w	1

	; total bonus granted in BCD
TotalBonus:
	ds.w	1

	; frames to fade out the music after pressing the button
FadeOut:
	ds.w	1

	; button handling and quit flag
ButtonPressed:
	ds.b	1
Quit:
	ds.b	1
