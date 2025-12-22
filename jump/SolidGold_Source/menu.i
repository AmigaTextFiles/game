*
* Menu definitions
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*


; Logo dimensions
LSOLIDW		equ	96
LSOLIDH		equ	23
LSOLIDX		equ	(DISPW-LSOLIDW)/2
LSOLIDY		equ	0
LGOLDW		equ	208		; also change STARSRW_MASK!
LGOLDH		equ	63		; also change STARSRH_MASK!
LGOLDX		equ	(DISPW-LGOLDW)/2
LGOLDY		equ	LSOLIDY+LSOLIDH

; Sparkling stars animation
STARSTYPES	equ	16		; max. types/images from the BMP file
STARSW		equ	16
STARSH		equ	16
STARSSIZE	equ	(STARSW>>3)*STARSH*PLANES
NUM_STARS	equ	4		; maximum visible stars
NUM_STARS_ANIMS	equ	2		; number of different animations
STARS_ANIM_CNT	equ	8		; number of frames for each anim phase

; Region where the sparkling stars appear (inside the GOLD logo)
STARSRX		equ	LGOLDX+8
STARSRY		equ	LGOLDY+2
STARSRW		equ	LGOLDW-2*8
STARSRH		equ	LGOLDH-4*2
STARSRW_MASK	equ	255		; mask for random numbers
STARSRH_MASK	equ	63		; mask for random numbers

; Mirrored region at the bottom of the screen
MIRROR_VPOS	equ	VSTART+192	; start of mirroring surface
MIRROR_LOCOLOR	equ	$511		; dark red for black
MIRROR_HICOLOR	equ	$944		; medium pink for white

; Menu pointer
POINTERW	equ	16
POINTERH	equ	8

; Menu music
MENUMUS_SONG	equ	$00
MENUMUS_HISCORE	equ	$12
MENUMUS_VOLUME	equ	48

; Menu animation phases
MPHASE_START	equ	0
MPHASE_CREDITS	equ	2
MPHASE_MAIN	equ	4		; two phases
MPHASE_PASSWORD	equ	8		; two phases
MPHASE_HISCORES	equ	12		; two phases
MPHASE_NAME	equ	16		; two phases
MPHASE_EXIT	equ	20

; Color intensity modification speed
DINTENS_START	equ	$08
DINTENS_CREDITS	equ	$04
DINTENS_MINIT	equ	$06
DINTENS_MENU	equ	$08
DINTENS_HISCORE	equ	$08
DINTENS_FADEOUT	equ	$04
DINTENS_EXIT	equ	$04

; Credits definitions
CRED_CATEGORY_Y	equ	DISPH/2+32	; in 8px font
CRED_NAME_Y	equ	CRED_CATEGORY_Y+MENUFONT8H+2
CRED_PRESSBTN_Y	equ	DISPH/2
CRED_DELAY	equ	50

; Main menu definitions
MAIN_MENU_X	equ	104
MAIN_MENU_Y	equ	106
MAIN_MENU_STEP	equ	MENUFONT8H+6	; distance between two menu items
MAIN_MENU_ITEMS	equ	6
MAIN_MENU_YEND	equ	MAIN_MENU_Y+MAIN_MENU_ITEMS*MAIN_MENU_STEP
MAIN_PTR_X	equ	80
MAIN_MIN_INTENS	equ	$80		; minimum menu item intensity

; Input buffer definitions
INPUT_HEAD_Y	equ	DISPH/2+32	; in 8px font
INPUT_Y		equ	INPUT_HEAD_Y+12	; in 16px font
INPUT_YEND	equ	INPUT_Y+MENUFONT16H

; Enter password definitions
PASS_LEN	equ	6
PASS_ENTRY_X	equ	(DISPW-PASS_LEN*MENUFONT16W)/2

; High score definitions
HISCORES_TRACK	equ	159		; first block on last track
HISCORE_RANKS	equ	10		; number of ranks in list
DEFHISCORE_LO	equ	$1000		; lowest default score (BCD)
DEFHISCORE_STEP	equ	$7000		; default step to next higher rank
HISCORES_TITLEY	equ	LGOLDY+LGOLDH+3
HISCORES_Y	equ	HISCORES_TITLEY+MENUFONT16H+2
HISCORES_YEND	equ	HISCORES_Y+HISCORE_RANKS*MENUFONT8H
HI_MIN_INTENS	equ	$a0		; minimum high score entry intensity
HISCORE_NAMELEN	equ	20

; High score list entry definition.
		rsreset
HSscore		rs.b	3		; score in BCD
HSstart		rs.b	1		; start level
HSend		rs.b	1		; end level
HSlives		rs.b	1		; lives left (when finishing game)
HSname		rs.b	HISCORE_NAMELEN	; name with up to 20 characters
sizeof_HS	equ	32		; should be a power of 2
sizeof_HS_shift	equ	5

; Enter highscore name definitions
NAME_ENTRY_X	equ	0		; 20 characters need full width


; View structure extensions.
; We reuse the part after Vid, which is otherwise only used by the game.
VINPBUFSIZE	equ	64

		rsset	Vid+2
Vphase		rs.w	1
Vindex		rs.w	1		; reset to 0 on phase change
Vptry		rs.w	1		; last ypos of pointer image
sizeof_MenuView	rs.b	0
		ifgt	sizeof_MenuView-Vvboblist
		fail	"Menu View extensions are too big!"
		endif
Vinpbuf		equ	Vdrawnodes	; set to unused Vdrawnodes area
		ifgt	(Vinpbuf+VINPBUFSIZE)-Vbobs
		fail	"Menu View extensions (Vinpbuf) are too big!"
		endif


; Macros.

	; Default high score entry name.
	macro	DEFAULT_ENTRY_NAME
	dc.b	"NIGHT OWL DESIGN"
	endm


	; Define a text with width in pixel and xpos for centered display.
	; Arguments: fontwidth, labelbase, string
	macro	CENTTXT
\2Txt:
	dc.b	\3
\2Width	equ	\1*(*-\2Txt)
\2X	equ	(DISPW-\2Width)/2
	dc.b	0
	endm


	; Macro creates a credits text entry of the format:
	; dc.b xpos, string, 0
	; Arguments: fontwidth, label, string
	macro	CREDTXT
\2:
	dc.b	(DISPW-(.\2End-(\2+1))*\1)/2
	dc.b	\3
.\2End:
	dc.b	0
	endm
