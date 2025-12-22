*
* Intro definitions
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*


; Number of introduction scenes
NUM_SCENES	equ	6

; IntroData flags
INTROALIGNRIGHT	equ	1

; Intro music
INTROMUS_SONG	equ	0
INTROMUS_VOLUME	equ	48

; Color intensity modification speed
DINTENS_TEXT	equ	2
DINTENS_BUTTON	equ	4
DINTENS_EXIT	equ	4

; Minimum intensity for "press button" text
BTN_MIN_INTENS	equ	$40


; View structure extensions.
; We reuse the part after Vid, which is otherwise only used by the game.
		rsset	Vid+2
Vscncolors	rs.w	NCOLORS		; original scene colors
Vtxtcolors	rs.w	NCOLORS		; original text colors
Vdimcolors	rs.w	NCOLORS		; dimmed text colors
Vbtncolors	rs.w	NCOLORS		; "press button" colors
Vtxtvstart	rs.w	1		; vpos of text colors
Vtxtintens	rs.w	1		; intensity of text colors
Vbtnintens	rs.w	1		; intensity of "press button" colors
Vbtndeltaintens	rs.w	1
sizeof_IntrView	rs.b	0
		ifgt	sizeof_IntrView-sizeof_View
		fail	"Intro View extensions are too big!"
		endif
