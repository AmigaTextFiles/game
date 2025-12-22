*
* Font constants
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*

; font dimensions
GAMEFONTW	equ	8
GAMEFONTH	equ	8

MENUFONT8W	equ	480		; 60 8x8 characters in a row
MENUFONT8H	equ	8
MENUFONT8SIZE	equ	(MENUFONT8W>>3)*MENUFONT8H*PLANES

MENUFONT16W	equ	16
MENUFONT16H	equ	20
MENUFONT16CHARS	equ	64		; 64 characters in this font
MENUFONT16SIZE	equ	(MENUFONT16W>>3)*MENUFONT16H*PLANES

; Menu font 8px color registers
MFONT8_COLOR1	equ	21
MFONT8_COLOR2	equ	23
MFONT8_COLOR3	equ	27
