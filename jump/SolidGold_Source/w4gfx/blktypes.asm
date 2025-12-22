*
* Tables with solid, lethal and animated block types for World 4.
* Each table has 256 bytes, for a maximum of 256 different blocks.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*

SolidBlocksTable:
	; Non-zero types are solid ground. Special solid ground types:
	; 1: SB_SOLID, normal solid wall or ground
	; 2: SB_BRBEND, bridge, display tile+1 when hero is standing on it
	; 3: SB_BRCRUMB4, crumbling bridge, four tile sequence
	; 4: SB_BRCRUMB5, crumbling bridge, five tile sequence
	; 5: SB_STCRUSH4, crushed stone, four tile sequence
	; 6: SB_STCRUSH5, crushed stone, five tile sequence
	; 7: SB_SPRING, spring platform, makes hero jump
	; 8: SB_TREADLEFT, treadmill moving to the left
	; 9: SB_TREADRIGHT, treadmill moving to the right
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0		; 000-019
	dc.b	0,0,0,0,8,8,8,8,8,8,8,8,8,1,1,1,0,0,0,0		; 020-039
	dc.b	1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0		; 040-059
	dc.b	0,0,0,0,0,0,0,5,1,1,0,3,1,1,0,0,0,0,0,0		; 060-079
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 080-099
	dc.b	1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 100-119
	dc.b	0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0		; 120-139
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0		; 140-159
	dc.b	0,0,1,2,1,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0		; 160-179
	dc.b	0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1		; 180-199
	dc.b	0,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0		; 200-219
	dc.b	0,1,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0,0,0,1		; 220-239
	dc.b	0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0			; 240-255

BackgdBlocksTable:
S	set	-1
	; Entries > 0 are lethal or change the movement mode.
	; -1 (S): BB_SOLID, solid block hint for monsters
	; 1: BB_STDDEATH, standard death
	; 2: BB_DROWNING, drowning
	; 5: BB_SWITCH, switch replaces tile-1 with tile-2
	; 6: BB_STAIRSLEFT, stairs on the left side
	; 7: BB_STAIRSRIGHT, stairs on the right side
	; 8: BB_START, start tile
	; 9: BB_EXIT, exit tile
	;10: BB_ILLUMTORCH, illuminating torch
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,6,7,0,0,0,S,0,0		; 000-019
	dc.b	9,0,0,0,S,S,S,S,S,S,S,S,S,S,S,S,8,9,0,0		; 020-039
	dc.b	S,S,S,S,0,S,S,S,S,S,S,S,S,S,S,S,S,S,S,0		; 040-059
	dc.b	1,0,0,0,0,0,0,S,S,S,0,S,S,S,0,0,0,0,0,0		; 060-079
	dc.b	0,0,0,0,0,0,0,10,0,1,1,0,1,1,0,0,0,0,0,0	; 080-099
	dc.b	S,S,0,0,S,5,0,0,0,0,0,0,0,0,0,1,1,1,1,0		; 100-119
	dc.b	0,0,0,0,0,0,0,0,S,0,0,0,0,0,0,0,0,0,0,0		; 120-139
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,S,0,0		; 140-159
	dc.b	0,0,S,S,S,S,S,2,2,0,0,0,0,0,0,0,0,0,0,0		; 160-179
	dc.b	1,1,1,1,0,0,0,0,S,S,S,S,S,S,S,S,S,S,S,S		; 180-199
	dc.b	1,S,0,0,0,0,0,0,0,0,0,0,S,S,S,S,0,0,0,0		; 200-219
	dc.b	0,S,S,S,S,0,0,0,0,0,S,S,S,S,0,0,0,0,0,S		; 220-239
	dc.b	1,1,1,1,0,S,S,S,S,S,0,0,0,0,0,0			; 240-255

FgBlockTypeTable:
	; Types of foreground blocks.
	; 1: checkpoint
	; 2: bonus1 (coin)
	; 3: bonus2 (ruby)
	; 4: bonus3 (emerald)
	; 5: bonus4 (diamond)
	; 6: extra life
	dc.b	0,6,6,6,6,6,2,2,2,2,0,0,0,0,0,0,0,0,0,0		; 000-019
	dc.b	0,0,0,0,1,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0		; 020-039
	dc.b	0,0,0,0,0,0,2,2,2,2,0,0,0,0,0,0,0,0,0,0		; 040-059
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 060-079
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 080-099
	dc.b	3,3,3,3,4,4,4,5,5,5,0,0,0,0,0,0,0,0,0,0		; 100-119
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 120-139
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 140-159
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 160-179
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 180-199
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 200-219
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 220-239
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0			; 240-255

AnimBlocksTable:
	; Non-zero types start a background tile animation when map is loaded
	; 1: three-tile treadmill animation loop
	; 2: three-tile fire animation loop
	; 3: four-tile spear animation loop
	; 4: three-tile torch animation loop
	; 5: three-tile water animation loop
	; 6: four-tile spring-trap animation loop
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 000-019
	dc.b	0,0,0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0		; 020-039
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 040-059
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0		; 060-079
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 080-099
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0		; 100-119
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 120-139
	dc.b	0,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 140-159
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 160-179
	dc.b	0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 180-199
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 200-219
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0		; 220-239
	dc.b	6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0			; 240-255

AnimPhasesAndSpeed:
; number of animation phases and speed in frames for AnimBlocksTable
	dc.b	0,0
	dc.b	3,4			; three-tile treadmill animation
	dc.b	3,7			; three-tile fire animation
	dc.b	4,15			; four-tile spear animation
	dc.b	3,17			; three-tile torch animation
	dc.b	3,9			; three-tile water animation
	dc.b	4,8			; four-tile spring-trap animation
