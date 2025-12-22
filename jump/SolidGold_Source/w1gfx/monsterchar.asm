*
* Monster characteristics and animations for all 9 types of world 1.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* Layout of a record (all entries 16-bit words):
* - movement strategy
*   MSTRAT_NONE: no movement, only animation
*   MSTRAT_LR: move left/right, fall from platforms
*   MSTRAT_LRP: move left/right, stay on a platform
*   MSTRAT_LRF: fly left/right until obstacle
*   MSTRAT_JMP: jump, fall back to base position
*   MSTRAT_UDBLK: move up/down within a block
*   MSTRAT_FALL: falling down, then move back to base pos
*   MSTRAT_DROP: drop down, then start again at base pos
*   MSTRAT_SHT: shoot, restart after hitting an obstacle
* - monster height
* - movement speed
* - points for killing that monster
* - upper-left and lower-right point of collision rectangle
* - type of animation to show when killed
*   MKILL_NONE: no animation, just disappear
*   MKILL_DROP: squash animation and drop dead
*   MKILL_VANISH: vanishing animation
*   MKILL_FALL: fall out of the screen
* - sound to play when killed
* - number of left movement animation frames
* - MT_ANIMFRAMES left movement animation indexes
* - number of right movement animation frames
* - MT_ANIMFRAMES right movement animation indexes
* - number of facing-left kill animation frames
* - MT_ANIMFRAMES kill animation indexes, while facing left
* - number of facing-right kill animation frames
* - MT_ANIMFRAMES kill animation indexes, while facing right
*

	include	"display.i"
	include	"sound.i"
	include	"monster.i"
	include	"monsteranim.i"


; Monster type 1: dog
	dc.w	MSTRAT_LRP,16,2,$15
	dc.w	0,1,15,15
	dc.w	MKILL_DROP,SND_HIT
	ANIM16	4,20,21,20,23
	ANIM16	4,40,41,42,41
	ANIM16	10,24,25,26
	ANIM16	10,44,45,46

; Monster type 2: agent
	dc.w	MSTRAT_LRP,20,1,$10
	dc.w	2,0,13,19
	dc.w	MKILL_DROP,SND_HIT
	ANIM20	6,140,141,142,143
	ANIM20	6,160,161,162,163
	ANIM20	9,144,145,146
	ANIM20	9,164,165,166

; Monster type 3: rowdie
	dc.w	MSTRAT_LRP,20,1,$10
	dc.w	1,0,14,19
	dc.w	MKILL_FALL,SND_HIT
	ANIM20	6,40,41,42,43
	ANIM20	6,60,61,62,63
	ANIM20	6,44,45,46,45
	ANIM20	6,44,45,46,45

; Monster type 4: acid blob
	dc.w	MSTRAT_DROP,16,1,$00
	dc.w	4,4,11,11
	dc.w	0,0
	ANIM16	10,0,1,2
	ANIM16	1,3
	ANIM16	10,4,5,6
	ANIM16	10,4,5,6

; Monster type 5: rat
	dc.w	MSTRAT_LRP,16,2,$15
	dc.w	0,4,15,15
	dc.w	MKILL_DROP,SND_HIT
	ANIM16	3,60,61,60,63
	ANIM16	3,80,81,82,81
	ANIM16	10,64,65,66
	ANIM16	10,84,85,86

; Monster type 6: barrel
	dc.w	MSTRAT_LR,16,2,$00
	dc.w	0,0,15,15
	dc.w	0,0
	ANIM16	3,100,101,102,103
	ANIM16	3,103,102,101,100
	ANIM16	1,0
	ANIM16	1,0

; Monster type 7: ghost
	dc.w	MSTRAT_LRF,20,1,$00
	dc.w	0,1,15,19
	dc.w	0,0
	ANIM20	5,100,101,102,103
	ANIM20	5,120,121,122,123
	ANIM20	1,0
	ANIM20	1,0

; Monster type 8: stone block
	dc.w	MSTRAT_FALL,20,-1,$00
	dc.w	0,0,15,19
	dc.w	0,0
	ANIM20	1,85
	ANIM20	1,85
	ANIM20	6,86,87,86,85
	ANIM20	6,86,87,86,85

; Monster type 9: cannon ball
	dc.w	MSTRAT_SHT,16,2,$00
	dc.w	4,9,11,15
	dc.w	0,0
	ANIM16	1,120
	ANIM16	1,120
	ANIM16	1,0
	ANIM16	1,0
