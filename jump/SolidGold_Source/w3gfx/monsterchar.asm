*
* Monster characteristics and animations for all 9 types of world 3.
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
*   MSTRAT_LRPRNM: like LRP, randomly switch to next monster type
*   MSTRAT_LRFRD: like LRF, randomly descend and switch to prev. monster type
*   MSTRAT_SHT: shoot, restart after hitting an obstacle
*   MSTRAT_LEAP: randomly leap forward
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


; Monster type 1: ancient egyptian
	dc.w	MSTRAT_LRP,20,2,$15
	dc.w	1,3,14,19
	dc.w	MKILL_FALL,SND_HIT
	ANIM20	4,20,21,20,23
	ANIM20	4,40,41,42,41
	ANIM20	6,24,25,26,25
	ANIM20	6,24,25,26,25

; Monster type 2: mummy
	dc.w	MSTRAT_LRP,20,1,$20
	dc.w	1,1,14,19
	dc.w	MKILL_DROP,SND_HIT
	ANIM20	4,60,61,62,63,64,63,62,61
	ANIM20	4,80,81,82,83,84,83,82,81
	ANIM20	10,65,66,67
	ANIM20	10,85,86,87

; Monster type 3: frog
	dc.w	MSTRAT_LEAP,20,2,$30
	dc.w	1,2,14,19
	dc.w	MKILL_DROP,SND_HIT
	ANIM20	4,180,181,182
	ANIM20	4,200,201,202
	ANIM20	10,183,184,185
	ANIM20	10,203,204,205

; Monster type 4: anubis
	dc.w	MSTRAT_LRP,20,1,$20
	dc.w	1,1,14,19
	dc.w	MKILL_FALL,SND_HIT
	ANIM20	6,10,11,12,13
	ANIM20	6,30,31,32,33
	ANIM20	6,14,15,16,17
	ANIM20	6,14,15,16,17

; Monster type 5: spiked stone block
	dc.w	MSTRAT_FALL,20,-1,$00
	dc.w	0,0,15,19
	dc.w	0,0
	ANIM20	1,70
	ANIM20	1,70
	ANIM20	5,70,71,72
	ANIM20	5,70,71,72

; Monster type 6: modern egyptian
	dc.w	MSTRAT_LRP,20,1,$15
	dc.w	3,1,13,19
	dc.w	MKILL_DROP,SND_HIT
	ANIM20	6,110,111,112,113
	ANIM20	6,130,131,132,133
	ANIM20	6,114,115,116
	ANIM20	6,134,135,136

; Monster type 7: fire ball
	dc.w	MSTRAT_SHT,16,2,$00
	dc.w	1,4,14,12
	dc.w	0,0
	ANIM16	4,20,21,22
	ANIM16	4,0,1,2
	ANIM16	1,0
	ANIM16	1,0

; Monster type 8: scorpion
	dc.w	MSTRAT_LRP,16,1,$00
	dc.w	1,2,14,15
	dc.w	0,0
	ANIM16	8,40,41,40,43
	ANIM16	8,60,61,62,61
	ANIM16	1,0
	ANIM16	1,0

; Monster type 9: scarab crawling
	dc.w	MSTRAT_LRPRNM,20,1,$30
	dc.w	0,7,15,19
	dc.w	MKILL_DROP,SND_HIT
	ANIM20	4,100,101,102,101
	ANIM20	4,120,121,120,123
	ANIM20	10,104,105,106
	ANIM20	10,124,125,126

; Monster type 10: scarab flying
	dc.w	MSTRAT_LRFRD,20,2,$30
	dc.w	0,0,15,19
	dc.w	MKILL_DROP,SND_HIT
	ANIM20	4,140,141,142,141
	ANIM20	4,160,161,160,163
	ANIM20	10,104,105,106
	ANIM20	10,124,125,126
