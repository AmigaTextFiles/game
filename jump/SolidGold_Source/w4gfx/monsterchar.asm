*
* Monster characteristics and animations for all 11 types of world 4.
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
*   MSTRAT_COV: when attacked, stops and protects itself, can be jumped on
*   MSTRAT_UD: walk/fly up/down until obstacle
*   MSTRAT_LRPYNM: like LRP, switch to next monster, when hero on same ypos
*   MSTRAT_ARCH: stand an aim at h., switch to prev. m. when h. ypos differs
*   MSTRAT_MIS: missile flies until hitting an obstacle, then disappears
*   MSTRAT_HOR: fly left/right, turn at obstacle
*   MSTRAT_WIZ: like LRP, but magic protection when hero comes too near
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


; Monster type 1: shield babylonian
	dc.w	MSTRAT_COV,20,1,$00
	dc.w	1,0,14,19
	dc.w	0,0
	ANIM20	6,0,1,2,3
	ANIM20	6,20,21,22,23
	ANIM20	19,4,5
	ANIM20	19,24,25

; Monster type 2: fire burst
	dc.w	MSTRAT_NONE,20,0,$00
	dc.w	0,0,15,19
	dc.w	0,0
	ANIM20	4,80,81,82,83,84
	ANIM20	4,80,81,82,83,84
	ANIM20	1,0
	ANIM20	1,0

; Monster type 3: babylonian warrior
	dc.w	MSTRAT_LRP,20,2,$15
	dc.w	2,1,13,19
	dc.w	MKILL_FALL,SND_HIT
	ANIM20	6,100,101,102,103
	ANIM20	6,120,121,122,123
	ANIM20	6,104,105,106,105
	ANIM20	6,104,105,106,105

; Monster type 4: small dragon
	dc.w	MSTRAT_LRF,20,1,$20
	dc.w	0,1,15,19
	dc.w	MKILL_DROP,SND_HIT
	ANIM20	7,140,141,142,141
	ANIM20	7,160,161,160,163
	ANIM20	6,144,145,146
	ANIM20	6,164,165,166

; Monster type 5: spider
	dc.w	MSTRAT_UD,20,1,$00
	dc.w	1,3,14,16
	dc.w	0,0
	ANIM20	6,200,201,202,201
	ANIM20	6,180,181,182,181
	ANIM20	1,0
	ANIM20	1,0

; Monster type 6: wizard
	dc.w	MSTRAT_WIZ,20,1,$30
	dc.w	2,0,13,19
	dc.w	MKILL_RVANISH,SND_HIT
	ANIM20	6,220,221,222,223
	ANIM20	6,204,205,206,207
	ANIM20	12,170,171,172
	ANIM20	8,188,189,190,191

; Monster type 7: wasp
	dc.w	MSTRAT_HOR,16,2,$25
	dc.w	0,3,15,12
	dc.w	MKILL_DROP,SND_HIT
	ANIM16	3,0,1,2,1
	ANIM16	3,20,21,20,23
	ANIM16	6,4,5,6
	ANIM16	6,24,25,26

; Monster type 8: grasshopper
	dc.w	MSTRAT_LEAP,16,2,$30
	dc.w	1,7,14,19
	dc.w	MKILL_DROP,SND_HIT
	ANIM16	4,60,61,62
	ANIM16	4,40,41,42
	ANIM16	15,63,64
	ANIM16	15,43,44

; Monster type 9: babylonian archer
	dc.w	MSTRAT_LRPYNM,20,1,$30
	dc.w	2,0,13,19
	dc.w	MKILL_DROP,SND_HIT
	ANIM20	6,40,41,42,43
	ANIM20	6,60,61,62,63
	ANIM20	10,44,45,46
	ANIM20	10,64,65,66

; Monster type 10: babylonian archer shooting
	dc.w	MSTRAT_ARCH,20,2,$20
	dc.w	1,0,14,19
	dc.w	MKILL_DROP,SND_HIT
	ANIM20V	1,47,25,48
	ANIM20V	1,67,25,68
	ANIM20	10,44,45,46
	ANIM20	10,64,65,66

; Monster type 11: arrow
	dc.w	MSTRAT_MIS,16,2,$00
	dc.w	2,7,13,9
	dc.w	0,0
	ANIM16	1,80
	ANIM16	1,81
	ANIM16	1,0
	ANIM16	1,0
