*
* Sprite constants
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* depends on display.i and font.i
*

; game sprites dimensions and positions
SCORE_SPRH	equ	GAMEFONTH
GEMSICON_SPRH	equ	15
GEMSNUM_SPRH	equ	GAMEFONTH
INFO_SPRH	equ	GAMEFONTH+2+GAMEFONTH
LIVESICON_SPRH	equ	14
LIVESNUM_SPRH	equ	GAMEFONTH

SCORE_SPRX	equ	4
SCORE_SPRY	equ	2
GEMS_SPRX	equ	4
GEMS_SPRY	equ	SCORE_SPRY+SCORE_SPRH+1
INFO_SPRY	equ	DISPH/4-INFO_SPRH/2
LIVES_SPRX	equ	DISPW-36
LIVES_SPRY	equ	DISPH-LIVESICON_SPRH-2

; size of sprite display lists in longwords
SPR01_LWORDS	equ	1+SCORE_SPRH+1+INFO_SPRH+1+GEMSICON_SPRH+1+LIVESICON_SPRH+1
SPR23_LWORDS	equ	1+SCORE_SPRH+1+INFO_SPRH+1+GEMSNUM_SPRH+1+LIVESNUM_SPRH+1
SPR45_LWORDS	equ	1+SCORE_SPRH+1+INFO_SPRH+1

; info sprite text rows (offset to sprite control words)
INFO_SPR_ROW1	equ	1<<2
INFO_SPR_ROW2	equ	(1+GAMEFONTH+2)<<2

; info sprites movement speed (per frame)
INFO_VXRIGHT	equ	4
INFO_VXLEFT	equ	8
