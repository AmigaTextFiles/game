*
* Game constants and structures
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*


; number of lives on game start (BCD)
NUMLIVES	equ	$03

; maximum level in the game (we start with level 1)
MAXLEVEL	equ	10

; Game modes
GAME_RUNNING	equ	-1
GAME_STOPPED	equ	0
GAME_MESSAGE	equ	1
GAME_WAITBTN	equ	2
GAME_READY	equ	3

; Music volumes (0-64)
SONG_VOLUME	equ	32
JINGLE_VOLUME	equ	48
STATS_VOLUME	equ	64

; number of gems for an extra life (BCD)
GEMS_XLIFE	equ	$50

; extra bonus for all item categories (BCD)
GOLDBONUS	equ	$0500
EMRLDBONUS	equ	$0800
DIAMBONUS	equ	$1000
RUBYBONUS	equ	$1500
KILLBONUS	equ	$2000
