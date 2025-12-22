*
* Tile constants
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*


; background and foreground tiles/blocks
BLKW		equ	16
BLKH		equ	16
BLKSIZE		equ	(BLKW>>3)*BLKH*PLANES


; Background Tile Animation
		rsreset
TAtype		rs.w	1	; 0:inactive, 2=single, 4=sequence, 6=loop
TAcol		rs.w	1
TArow		rs.w	1
TAmapoff	rs.l	1	; map offset
TAbmoff		rs.l	1	; bitmap offset (0: need recalculation)
TAview1		rs.b	1	; current tile on bitmap1
TAview2		rs.b	1	; current tile on bitmap2
TAlast		rs.b	1	; last tile of animation
TAfirst		rs.b	1	; first tile of animation
TAcnt		rs.b	1	; current frame counter
TAspeed		rs.b	1	; frames until next animation phase
sizeof_TileAnim	rs.b	0

MAXTILEANIMS	equ	128

; tile animation types
TA_DISABLED	equ	0
TA_SINGLE	equ	2	; single tile animation (just update a tile)
TA_SEQUENCE	equ	4	; one-time animation sequence
TA_LOOP		equ	6	; continuous animation loop


; Switch Tiles
; A table with Switch Tile records is built after loading a new map.
; It remembers all locations of tiles to be replaced, when activating
; a switch for tile code STold.
		rsreset
STold		rs.b	1	; tile code to replace
STnew		rs.b	1	; new tile code
STcol		rs.w	1
STrow		rs.w	1
STmapoff	rs.l	1
sizeof_SwiTile	rs.b	0

MAXSWITCHTILES	equ	48
