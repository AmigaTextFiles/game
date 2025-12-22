*
* Map constants
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*


; maximum map dimensions
MAXMAPW		equ	256
MAXMAPH		equ	256

; extra lines at top and bottom of the map
MAPTOPEXTRA	equ	4	; hero can't jump over blocks on top of the map
MAPBOTEXTRA	equ	2	; two empty lines until hero left the map


; SolidBlockTable types
SB_VOID		equ	0*2	; hero moves through these blocks
SB_SOLID	equ	1*2	; normal solid ground
SB_BRBEND	equ	2*2	; bending bridge, display tile+1
SB_BRCRUMB4	equ	3*2	; crumbling bridge, four tile sequence
SB_BRCRUMB5	equ	4*2	; crumbling bridge, five tile sequence
SB_STCRUSH4	equ	5*2	; crushed stone, four tile sequence
SB_STCRUSH5	equ	6*2	; crushed stone, five tile sequence
SB_SPRING	equ	7*2	; spring platform, makes hero jump
SB_TREADLEFT	equ	8*2	; treadmill moving to the left
SB_TREADRIGHT	equ	9*2	; treadmill moving to the right

; treadmill speed (add to hero's speed)
LEFTTREADSPEED	equ	-1
RIGHTTREADSPEED	equ	1


; Background block types
BB_SOLID	equ	-1*2	; solid block for monsters
BB_STDDEATH	equ	1*2	; hero standard death
BB_DROWNING	equ	2*2	; hero drowning
BB_SWITCH	equ	5*2	; switch replaces tile-1 with tile-2
BB_STAIRSLEFT	equ	6*2	; stairs on the tile's left side
BB_STAIRSRIGHT	equ	7*2	; stairs on the tile's right side
BB_START	equ	8*2	; map start - there must be only one!
BB_EXIT		equ	9*2	; map exit
BB_ILLUMTORCH	equ	10*2	; illuminating torch

; illumination color registers and time
ILLUMCOLOR1	equ	9
ILLUMCOLOR2	equ	10
ILLUM_TIME	equ	8*50	; illuminate for 8 seconds


; Foreground block types
FB_CHECKPOINT	equ	1*2	; checkpoint location is saved in StartX/Y
FB_COIN		equ	2*2	; coin to collect
FB_RUBY		equ	3*2	; gem to collect (ruby)
FB_EMERALD	equ	4*2	; gem to collect (emerald)
FB_DIAMOND	equ	5*2	; gem to collect (diamond)
FB_EXTRALIFE	equ	6*2	; extra life

; Item scores (BCD)
COINSCORE	equ	$10
EMERALDSCORE	equ	$25
DIAMONDSCORE	equ	$30
RUBYSCORE	equ	$50


; Monster description. A variable number of monster records is
; stored at the end of each map.
		rsreset
MDtype		rs.w	1	; 1-9
MDdir		rs.w	1	; -1 for left, 1 for right
MDcol		rs.w	1
MDrow		rs.w	1
sizeof_MD	rs.b	0

MAXMONSTERS	equ	127	; leave one BOB for the hero


; Maximum map size on disk (including header and monsters)
; Header: "MAP8", width.w, height.w
MAXDSKMAPSIZE	equ	8+2*MAXMAPW*MAXMAPH+MAXMONSTERS*sizeof_MD

; Extra rows on top of the background map mirror the blocks of the first row.
; Extra rows between the background and foreground maps are used together.
; Extra rows after the foreground map are void.
TOPMAPSPACE	equ	MAPTOPEXTRA*MAXMAPW
		ifgt	MAPTOPEXTRA-MAPBOTEXTRA
MAPMIDEXTRA	equ	MAPTOPEXTRA
		else
MAPMIDEXTRA	equ	MAPBOTEXTRA
		endif
MIDMAPSPACE	equ	MAPMIDEXTRA*MAXMAPW
BOTMAPSPACE	equ	MAPBOTEXTRA*MAXMAPW

; We assume that the monster records and the map header fit into all the
; extra rows, after the map had been loaded into the buffer.
		ifgt	(8+MAXMONSTERS*sizeof_MD)-(TOPMAPSPACE+MIDMAPSPACE+BOTMAPSPACE)
		fail	"Too many monsters!"
		endif
