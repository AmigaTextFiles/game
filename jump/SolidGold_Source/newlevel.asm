*
* Print new level and password.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* newlevel_scr_open(d0.b=fontflag, d1=World.w|Level.w)
* newlevel_scr_close()
*
* LevelPasswords
* StageStrings
*

	include	"display.i"
	include	"view.i"


; screen layout
STAGE_Y		equ	80
PASSWORD_Y	equ	110
PRESSBUTTON_Y	equ	220

; Macro to encrypt a level password
; Arguments: 6 characters of the password
	macro	PASSWD
	dc.b	\1^$3f,\2^$3e,\3^$3d,\4^$3c,\5^$3b,\6^$3a
	endm


; from memory.asm
	xref	free_topchipmem
	xref	AllocFromTop

; from input.asm
	xref	readController

; from display.asm
	xref	display_off
	xref	make_stdviews
	xref	startdisplay
	xref	waitvertb
	xref	View

; from menu.asm
	xref	PressButtonTxt
	xref	PressButtonX

; from blit.asm
	xref	clear_display

; from font.asm
	xref	load_smallfont
	xref	mfont8_center
	xref	mfont8_print
	xref	Font8Colors



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	newlevel_scr_open
newlevel_scr_open:
; Open a new screen, make sure the 8px font is loaded and print the
; new level number and its password.
; d0 = font-load-flag (false means that the font8 is already loaded)
; d1 = World.w | Level.w

	movem.l	d1-d3/a5,-(sp)

	; Allocte all memory from top of Chip RAM, so it is not
	; overwritten during loading of level data and we can easily
	; deallocate it after loading is done.
	st	AllocFromTop(a4)

	; load 8px font
	tst.b	d0
	beq	.1
	bsr	load_smallfont

	; set up the display
.1:	sub.l	a0,a0
	bsr	make_stdviews

	; We are using the first View. No double buffering.
	move.l	View(a4),a5
	bsr	clear_display

	; prepare the world/level string
	lea	StageTxt(a4),a0
	movem.w	(sp)+,d2-d3		; d2=world, d3=level
	add.b	#'0',d2
	move.b	d2,WorldDigit-StageTxt(a0)
	lea	StageStrings(a4),a1
	move.w	d3,d0
	lsl.w	#2,d0
	move.b	2(a1,d0.w),LevelDigit-StageTxt(a0)

	; print "world X - level Y" centered
	moveq	#STAGE_Y,d1
	bsr	mfont8_center

	; print password for this level (d3)
	move.w	d3,d0
	bsr	decrypt_password
	lea	PasswordTxt(a4),a0
	move.w	#PASSWORD_Y,d1
	bsr	mfont8_center

	; Now start the display DMA.
	lea	Font8Colors(a4),a0
	bsr	startdisplay

	; Do normal Chip RAM allocations again, while loading the level.
	clr.b	AllocFromTop(a4)

	movem.l	(sp)+,d2-d3/a5
	rts


;---------------------------------------------------------------------------
decrypt_password:
; Decrypt password for the given level and write it to PasswordDecrypted.
; d0 = level

	lea	LevelPasswords(a4),a0
	mulu	#6,d0
	add.w	d0,a0
	lea	PasswordDecrypted+6(a4),a1

	moveq	#5,d1
.1:	move.b	-(a0),-(a1)
	moveq	#$3f,d0
	sub.b	d1,d0
	eor.b	d0,(a1)
	dbf	d1,.1

	rts


;---------------------------------------------------------------------------
	xdef	newlevel_scr_close
newlevel_scr_close:
; Print "press button" and wait for the button. Then close the screen
; and free all memory allocated at the top of Chip RAM.

	move.l	a5,-(sp)

	move.l	View(a4),a5
	move.w	#PressButtonX,d0
	move.w	#PRESSBUTTON_Y,d1
	lea	PressButtonTxt(pc),a0
	bsr	mfont8_print

	; wait for button
.waitbutton:
	bsr	waitvertb
	moveq	#1,d0
	bsr	readController
	tst.l	d0
	bpl	.waitbutton

	; wait until button is released
.waitreleased:
	bsr	waitvertb
	moveq	#1,d0
	bsr	readController
	tst.l	d0
	bmi	.waitreleased

	bsr	display_off

	; Free memory for loading screens, allocated during loadworld
	; and loadlevel.
	bsr	free_topchipmem

	move.l	(sp)+,a5
	rts



	section	__MERGED,data


	; "World X - LEVEL Y" string to print centered onto the screen
StageTxt:
	dc.b	"WORLD "
WorldDigit:
	dc.b	"0 - LEVEL "
LevelDigit:
	dc.b	"0",0

PasswordTxt:
	dc.b	"YOUR PASSWORD IS: "
PasswordDecrypted:
	dc.b	"XXXXXX",0

	; Encrypted passwords for all levels, terminated by 0
	xdef	LevelPasswords
LevelPasswords:
	; World 1
	PASSWD	'L','E','T','S','G','O'
	PASSWD	'L','O','N','D','O','N'
	; World 2
	PASSWD	'M','E','X','I','C','O'
	PASSWD	'M','E','R','I','D','A'
	PASSWD	'B','E','L','I','Z','E'
	; World 3
	PASSWD	'S','P','H','I','N','X'
	PASSWD	'P','H','A','R','A','O'
	PASSWD	'A','N','U','B','I','S'
	; World 4
	PASSWD	'I','S','H','T','A','R'
	PASSWD	'T','I','G','R','I','S'
	dc.b	0
	even

	; Table to convert a level (0-10) into a stage string.
	xdef	StageStrings
StageStrings:
	dc.b	"ILL",0			; level 0 is illegal
	dc.b	"1-1",0
	dc.b	"1-2",0
	dc.b	"2-1",0
	dc.b	"2-2",0
	dc.b	"2-3",0
	dc.b	"3-1",0
	dc.b	"3-2",0
	dc.b	"3-3",0
	dc.b	"4-1",0
	dc.b	"4-2",0
	dc.b	"END",0			; finished the game
	even
