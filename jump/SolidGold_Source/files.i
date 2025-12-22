*
* Directory definitions.
* Matches the sequence of files in diskimage.asm.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*

DISK_ID		equ	$474f4c44	; "GOLD", id for SolidGold disk

FIL_NONE	equ	-1		; no valid file

		rsreset
; Menu
FIL_LOADING	rs.b	1
FIL_LOGOSOLID	rs.b	1
FIL_LOGOGOLD	rs.b	1
FIL_LOGOSTARS	rs.b	1
FIL_POINTER	rs.b	1
FIL_MFONT8	rs.b	1
FIL_MFONT16	rs.b	1
FIL_MODMENU	rs.b	2		; .trk and .smp file
;FIL_SFXMENU	rs.b	1
FIL_SFXSELECT	rs.b	1

; Introduction
FIL_MODINTRO	rs.b	2		; .trk and .smp file
FIL_INTROSCENE1	rs.b	1
FIL_INTROSCENE2	rs.b	1
FIL_INTROSCENE3	rs.b	1
FIL_INTROSCENE4	rs.b	1
FIL_INTROSCENE5	rs.b	1
FIL_INTROSCENE6	rs.b	1

; Miscellaneous
FIL_MODLOADWRLD	rs.b	1		; mod file in a single block
FIL_ENDPIC	rs.b	1

; Game files
FIL_HERO22	rs.b	1
FIL_GAMEFONT8	rs.b	1
FIL_GAMESPRITES	rs.b	1
FIL_SFXPLING	rs.b	1
FIL_SFXCHKPT	rs.b	1
FIL_SFXSCREAM	rs.b	1
FIL_SFXSPLASH	rs.b	1
FIL_SFXHIT	rs.b	1
FIL_SFXWALL	rs.b	1
FIL_SFXXLIFE	rs.b	1
FIL_SFXBONUS	rs.b	1

; World 1
FIL_LOADPIC1	rs.b	1
FIL_TYPES1	rs.b	1
FIL_TILES1	rs.b	1
FIL_FG1		rs.b	1
FIL_MONSTCHAR1	rs.b	1
FIL_16MONST1	rs.b	1
FIL_20MONST1	rs.b	1
FIL_COPPER1	rs.b	1
FIL_MOD1	rs.b	2		; .trk and .smp file
FIL_MAP1_1	rs.b	1
FIL_MAP1_2	rs.b	1

; World 2
FIL_LOADPIC2	rs.b	1
FIL_TYPES2	rs.b	1
FIL_TILES2	rs.b	1
FIL_FG2		rs.b	1
FIL_MONSTCHAR2	rs.b	1
FIL_16MONST2	rs.b	1
FIL_20MONST2	rs.b	1
FIL_COPPER2	rs.b	1
FIL_MOD2	rs.b	2		; .trk and .smp file
FIL_MAP2_1	rs.b	1
FIL_MAP2_2	rs.b	1
FIL_MAP2_3	rs.b	1

; World 3
FIL_LOADPIC3	rs.b	1
FIL_TYPES3	rs.b	1
FIL_TILES3	rs.b	1
FIL_FG3		rs.b	1
FIL_MONSTCHAR3	rs.b	1
FIL_16MONST3	rs.b	1
FIL_20MONST3	rs.b	1
FIL_COPPER3	rs.b	1
FIL_MOD3	rs.b	2		; .trk and .smp file
FIL_MAP3_1	rs.b	1
FIL_MAP3_2	rs.b	1
FIL_MAP3_3	rs.b	1

; World 4
FIL_LOADPIC4	rs.b	1
FIL_TYPES4	rs.b	1
FIL_TILES4	rs.b	1
FIL_FG4		rs.b	1
FIL_MONSTCHAR4	rs.b	1
FIL_16MONST4	rs.b	1
FIL_20MONST4	rs.b	1
FIL_COPPER4	rs.b	1
FIL_MOD4	rs.b	2		; .trk and .smp file
FIL_MAP4_1	rs.b	1
FIL_MAP4_2	rs.b	1
