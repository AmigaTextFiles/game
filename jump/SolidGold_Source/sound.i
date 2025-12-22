*
* Sound defines
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*


MAXSOUNDS	equ	16

; sound sets
SSET_MENU	equ	0
SSET_WORLD1	equ	1


; sound fx table format
		rsreset
SFXptr		rs.l	1
SFXlen		rs.w	1
SFXper		rs.w	1
SFXvol		rs.w	1
sizeof_SFX	rs.b	0

; sound IDs Menu
;SND_MCHOOSE	equ	0*sizeof_SFX
SND_MSELECT	equ	0*sizeof_SFX

; sound IDs World 1 (also used for 2, 3, 4)
SND_PLING	equ	0*sizeof_SFX
SND_CHECKPOINT	equ	1*sizeof_SFX
SND_SCREAM	equ	2*sizeof_SFX
SND_SPLASH	equ	3*sizeof_SFX
SND_HIT		equ	4*sizeof_SFX
SND_WALL	equ	5*sizeof_SFX
SND_XLIFE	equ	6*sizeof_SFX
SND_SWITCH	equ	7*sizeof_SFX
SND_SPRING	equ	4*sizeof_SFX	; currently same as SND_HIT
SND_IGNITE	equ	7*sizeof_SFX	; currently same as SND_SWITCH
SND_BONUS	equ	8*sizeof_SFX
