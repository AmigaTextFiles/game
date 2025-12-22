*
* Monster characteristics and animations for all 9 types of world 2.
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


; Monster type 1: serpent
	dc.w	MSTRAT_LRP,20,1,$10
	dc.w	0,1,15,19
	dc.w	MKILL_DROP,SND_HIT
	ANIM20	5,20,21,22,21
	ANIM20	5,40,41,40,43
	ANIM20	10,24,25,26
	ANIM20	10,44,45,46

; Monster type 2: fish
	dc.w	MSTRAT_JMP,20,-31,$00
	dc.w	0,1,15,18
	dc.w	MKILL_DROP,SND_HIT
	ANIM20	5,60,61,62,61
	ANIM20	5,80,81,82,81
	ANIM20	1,0
	ANIM20	1,0

; Monster type 3: white quick maya
	dc.w	MSTRAT_LRP,20,2,$15
	dc.w	2,0,13,19
	dc.w	MKILL_FALL,SND_HIT
	ANIM20	4,100,101,100,103
	ANIM20	4,120,121,122,121
	ANIM20	6,104,105,106,105
	ANIM20	6,104,105,106,105

; Monster type 4: red fat maya
	dc.w	MSTRAT_LRP,20,1,$10
	dc.w	1,1,14,19
	dc.w	MKILL_FALL,SND_HIT
	ANIM20	4,186,187,186,189
	ANIM20	4,206,207,208,207
	ANIM20	6,190,191,192,193
	ANIM20	6,190,191,192,193

; Monster type 5: bat
	dc.w	MSTRAT_LRF,16,1,$20
	dc.w	0,1,15,12
	dc.w	MKILL_VANISH,SND_HIT
	ANIM16	3,228,229,230,229
	ANIM16	3,248,249,248,251
	ANIM16	12,232,233,234
	ANIM16	12,232,233,234

; Monster type 6: saw blade
	dc.w	MSTRAT_LRP,16,1,$00
	dc.w	1,7,15,15
	dc.w	0,0
	ANIM16	3,60,61,62,63
	ANIM16	3,60,61,62,63
	ANIM16	1,0
	ANIM16	1,0

; Monster type 7: boulder
	dc.w	MSTRAT_LR,16,1,$00
	dc.w	0,2,15,15
	dc.w	0,0
	ANIM16	3,208,209,210,211
	ANIM16	3,211,210,209,208
	ANIM16	1,0
	ANIM16	1,0

; Monster type 8: spear trap
	dc.w	MSTRAT_UDBLK,16,1,$00
	dc.w	1,0,14,15
	dc.w	0,0
	ANIM16	6,100,101,102,103,102,101
	ANIM16	6,100,101,102,103,102,101
	ANIM16	1,0
	ANIM16	1,0

; Monster type 9: spider
	dc.w	MSTRAT_LRP,16,1,$15
	dc.w	1,4,14,15
	dc.w	MKILL_DROP,SND_HIT
	ANIM16	4,108,109,110,109
	ANIM16	4,128,129,128,131
	ANIM16	10,112,113,114
	ANIM16	10,132,133,134
