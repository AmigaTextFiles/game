	.file	"m_brain.c"
gcc2_compiled.:
	.globl brain_frames_stand
	.section	".data"
	.align 2
	.type	 brain_frames_stand,@object
brain_frames_stand:
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.size	 brain_frames_stand,360
	.globl brain_move_stand
	.align 2
	.type	 brain_move_stand,@object
	.size	 brain_move_stand,16
brain_move_stand:
	.long 162
	.long 191
	.long brain_frames_stand
	.long 0
	.globl brain_frames_idle
	.align 2
	.type	 brain_frames_idle,@object
brain_frames_idle:
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.size	 brain_frames_idle,360
	.globl brain_move_idle
	.align 2
	.type	 brain_move_idle,@object
	.size	 brain_move_idle,16
brain_move_idle:
	.long 192
	.long 221
	.long brain_frames_idle
	.long brain_stand
	.globl brain_frames_walk1
	.align 2
	.type	 brain_frames_walk1,@object
brain_frames_walk1:
	.long ai_walk
	.long 0x40e00000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x40400000
	.long 0
	.long ai_walk
	.long 0x40400000
	.long 0
	.long ai_walk
	.long 0x3f800000
	.long 0
	.long ai_walk
	.long 0x0
	.long 0
	.long ai_walk
	.long 0x0
	.long 0
	.long ai_walk
	.long 0x41100000
	.long 0
	.long ai_walk
	.long 0xc0800000
	.long 0
	.long ai_walk
	.long 0xbf800000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.size	 brain_frames_walk1,132
	.globl brain_move_walk1
	.align 2
	.type	 brain_move_walk1,@object
	.size	 brain_move_walk1,16
brain_move_walk1:
	.long 0
	.long 10
	.long brain_frames_walk1
	.long 0
	.globl brain_frames_defense
	.align 2
	.type	 brain_frames_defense,@object
brain_frames_defense:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 brain_frames_defense,108
	.globl brain_move_defense
	.align 2
	.type	 brain_move_defense,@object
	.size	 brain_move_defense,16
brain_move_defense:
	.long 154
	.long 161
	.long brain_frames_defense
	.long 0
	.globl brain_frames_pain3
	.align 2
	.type	 brain_frames_pain3,@object
brain_frames_pain3:
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0x40000000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0xc0800000
	.long 0
	.size	 brain_frames_pain3,72
	.globl brain_move_pain3
	.align 2
	.type	 brain_move_pain3,@object
	.size	 brain_move_pain3,16
brain_move_pain3:
	.long 117
	.long 122
	.long brain_frames_pain3
	.long brain_run
	.globl brain_frames_pain2
	.align 2
	.type	 brain_frames_pain2,@object
brain_frames_pain2:
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0xc0000000
	.long 0
	.size	 brain_frames_pain2,96
	.globl brain_move_pain2
	.align 2
	.type	 brain_move_pain2,@object
	.size	 brain_move_pain2,16
brain_move_pain2:
	.long 109
	.long 116
	.long brain_frames_pain2
	.long brain_run
	.globl brain_frames_pain1
	.align 2
	.type	 brain_frames_pain1,@object
brain_frames_pain1:
	.long ai_move
	.long 0xc0c00000
	.long 0
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0xc0c00000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x40000000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x40000000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x40e00000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.size	 brain_frames_pain1,252
	.globl brain_move_pain1
	.align 2
	.type	 brain_move_pain1,@object
	.size	 brain_move_pain1,16
brain_move_pain1:
	.long 88
	.long 108
	.long brain_frames_pain1
	.long brain_run
	.globl brain_frames_duck
	.align 2
	.type	 brain_frames_duck,@object
brain_frames_duck:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0xc0000000
	.long brain_duck_down
	.long ai_move
	.long 0x41880000
	.long brain_duck_hold
	.long ai_move
	.long 0xc0400000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long brain_duck_up
	.long ai_move
	.long 0xc0a00000
	.long 0
	.long ai_move
	.long 0xc0c00000
	.long 0
	.long ai_move
	.long 0xc0c00000
	.long 0
	.size	 brain_frames_duck,96
	.globl brain_move_duck
	.align 2
	.type	 brain_move_duck,@object
	.size	 brain_move_duck,16
brain_move_duck:
	.long 146
	.long 153
	.long brain_frames_duck
	.long brain_run
	.globl brain_frames_death2
	.align 2
	.type	 brain_frames_death2,@object
brain_frames_death2:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x41100000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 brain_frames_death2,60
	.globl brain_move_death2
	.align 2
	.type	 brain_move_death2,@object
	.size	 brain_move_death2,16
brain_move_death2:
	.long 141
	.long 145
	.long brain_frames_death2
	.long brain_dead
	.globl brain_frames_death1
	.align 2
	.type	 brain_frames_death1,@object
brain_frames_death1:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0x41100000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 brain_frames_death1,216
	.globl brain_move_death1
	.align 2
	.type	 brain_move_death1,@object
	.size	 brain_move_death1,16
brain_move_death1:
	.long 123
	.long 140
	.long brain_frames_death1
	.long brain_dead
	.globl brain_frames_attack1
	.align 2
	.type	 brain_frames_attack1,@object
brain_frames_attack1:
	.long ai_charge
	.long 0x41000000
	.long 0
	.long ai_charge
	.long 0x40400000
	.long 0
	.long ai_charge
	.long 0x40a00000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0xc0400000
	.long brain_swing_right
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0xc0a00000
	.long 0
	.long ai_charge
	.long 0xc0e00000
	.long brain_hit_right
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x40c00000
	.long brain_swing_left
	.long ai_charge
	.long 0x3f800000
	.long 0
	.long ai_charge
	.long 0x40000000
	.long brain_hit_left
	.long ai_charge
	.long 0xc0400000
	.long 0
	.long ai_charge
	.long 0x40c00000
	.long 0
	.long ai_charge
	.long 0xbf800000
	.long 0
	.long ai_charge
	.long 0xc0400000
	.long 0
	.long ai_charge
	.long 0x40000000
	.long 0
	.long ai_charge
	.long 0xc1300000
	.long 0
	.size	 brain_frames_attack1,216
	.globl brain_move_attack1
	.align 2
	.type	 brain_move_attack1,@object
	.size	 brain_move_attack1,16
brain_move_attack1:
	.long 53
	.long 70
	.long brain_frames_attack1
	.long brain_run
	.globl brain_frames_attack2
	.align 2
	.type	 brain_frames_attack2,@object
brain_frames_attack2:
	.long ai_charge
	.long 0x40a00000
	.long 0
	.long ai_charge
	.long 0xc0800000
	.long 0
	.long ai_charge
	.long 0xc0800000
	.long 0
	.long ai_charge
	.long 0xc0400000
	.long 0
	.long ai_charge
	.long 0x0
	.long brain_chest_open
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x41500000
	.long brain_tentacle_attack
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x40000000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0xc1100000
	.long brain_chest_closed
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x40800000
	.long 0
	.long ai_charge
	.long 0x40400000
	.long 0
	.long ai_charge
	.long 0x40000000
	.long 0
	.long ai_charge
	.long 0xc0400000
	.long 0
	.long ai_charge
	.long 0xc0c00000
	.long 0
	.size	 brain_frames_attack2,204
	.globl brain_move_attack2
	.align 2
	.type	 brain_move_attack2,@object
	.size	 brain_move_attack2,16
brain_move_attack2:
	.long 71
	.long 87
	.long brain_frames_attack2
	.long brain_run
	.globl brain_frames_run
	.align 2
	.type	 brain_frames_run,@object
brain_frames_run:
	.long ai_run
	.long 0x41100000
	.long 0
	.long ai_run
	.long 0x40000000
	.long 0
	.long ai_run
	.long 0x40400000
	.long 0
	.long ai_run
	.long 0x40400000
	.long 0
	.long ai_run
	.long 0x3f800000
	.long 0
	.long ai_run
	.long 0x0
	.long 0
	.long ai_run
	.long 0x0
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0xc0800000
	.long 0
	.long ai_run
	.long 0xbf800000
	.long 0
	.long ai_run
	.long 0x40000000
	.long 0
	.size	 brain_frames_run,132
	.globl brain_move_run
	.align 2
	.type	 brain_move_run,@object
	.size	 brain_move_run,16
brain_move_run:
	.long 0
	.long 10
	.long brain_frames_run
	.long 0
	.section	".rodata"
	.align 2
.LC2:
	.long 0x46fffe00
	.align 3
.LC3:
	.long 0x3fd51eb8
	.long 0x51eb851f
	.align 3
.LC4:
	.long 0x3fe51eb8
	.long 0x51eb851f
	.align 2
.LC5:
	.long 0x40400000
	.align 3
.LC6:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC7:
	.long 0x3f800000
	.align 2
.LC8:
	.long 0x0
	.section	".text"
	.align 2
	.globl brain_pain
	.type	 brain_pain,@function
brain_pain:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,484(31)
	lwz 11,480(31)
	srwi 9,0,31
	add 0,0,9
	srawi 0,0,1
	cmpw 0,11,0
	bc 4,0,.L38
	li 0,1
	stw 0,60(31)
.L38:
	lis 9,level+4@ha
	lfs 0,464(31)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L37
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,464(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC6@ha
	lis 10,.LC2@ha
	la 11,.LC6@l(11)
	stw 0,16(1)
	lfd 12,0(11)
	lfd 0,16(1)
	lis 11,.LC3@ha
	lfs 11,.LC2@l(10)
	lfd 13,.LC3@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,11
	fmr 12,0
	fcmpu 0,12,13
	bc 4,0,.L40
	lis 9,gi+16@ha
	lis 11,sound_pain1@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC7@ha
	lwz 5,sound_pain1@l(11)
	la 9,.LC7@l(9)
	lis 11,.LC7@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC7@l(11)
	lis 9,.LC8@ha
	lfs 2,0(11)
	la 9,.LC8@l(9)
	lfs 3,0(9)
	blrl
	lis 9,brain_move_pain1@ha
	la 9,brain_move_pain1@l(9)
	b .L44
.L40:
	lis 9,.LC4@ha
	lfd 0,.LC4@l(9)
	fcmpu 0,12,0
	bc 4,0,.L42
	lis 9,gi+16@ha
	lis 11,sound_pain2@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC7@ha
	lwz 5,sound_pain2@l(11)
	la 9,.LC7@l(9)
	lis 11,.LC7@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC7@l(11)
	lis 9,.LC8@ha
	lfs 2,0(11)
	la 9,.LC8@l(9)
	lfs 3,0(9)
	blrl
	lis 9,brain_move_pain2@ha
	la 9,brain_move_pain2@l(9)
	b .L44
.L42:
	lis 9,gi+16@ha
	lis 11,sound_pain1@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC7@ha
	lwz 5,sound_pain1@l(11)
	la 9,.LC7@l(9)
	lis 11,.LC7@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC7@l(11)
	lis 9,.LC8@ha
	lfs 2,0(11)
	la 9,.LC8@l(9)
	lfs 3,0(9)
	blrl
	lis 9,brain_move_pain3@ha
	la 9,brain_move_pain3@l(9)
.L44:
	stw 9,772(31)
.L37:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 brain_pain,.Lfe1-brain_pain
	.section	".rodata"
	.align 2
.LC9:
	.string	"misc/udeath.wav"
	.align 2
.LC10:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC11:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC12:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC14:
	.string	"brain/brnatck1.wav"
	.align 2
.LC15:
	.string	"brain/brnatck2.wav"
	.align 2
.LC16:
	.string	"brain/brnatck3.wav"
	.align 2
.LC17:
	.string	"brain/brndeth1.wav"
	.align 2
.LC18:
	.string	"brain/brnidle1.wav"
	.align 2
.LC19:
	.string	"brain/brnidle2.wav"
	.align 2
.LC20:
	.string	"brain/brnlens1.wav"
	.align 2
.LC21:
	.string	"brain/brnpain1.wav"
	.align 2
.LC22:
	.string	"brain/brnpain2.wav"
	.align 2
.LC23:
	.string	"brain/brnsght1.wav"
	.align 2
.LC24:
	.string	"brain/brnsrch1.wav"
	.align 2
.LC25:
	.string	"brain/melee1.wav"
	.align 2
.LC26:
	.string	"brain/melee2.wav"
	.align 2
.LC27:
	.string	"brain/melee3.wav"
	.align 2
.LC28:
	.string	"models/monsters/brain/tris.md2"
	.align 2
.LC29:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_brain
	.type	 SP_monster_brain,@function
SP_monster_brain:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 11,.LC29@ha
	lis 9,deathmatch@ha
	la 11,.LC29@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L62
	lis 9,hunt@ha
	lwz 11,hunt@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L62
	bl G_FreeEdict
	b .L61
.L62:
	lis 29,gi@ha
	lis 3,.LC14@ha
	la 29,gi@l(29)
	la 3,.LC14@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_chest_open@ha
	lis 11,.LC15@ha
	stw 3,sound_chest_open@l(9)
	mtlr 10
	la 3,.LC15@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_tentacles_extend@ha
	lis 11,.LC16@ha
	stw 3,sound_tentacles_extend@l(9)
	mtlr 10
	la 3,.LC16@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_tentacles_retract@ha
	lis 11,.LC17@ha
	stw 3,sound_tentacles_retract@l(9)
	mtlr 10
	la 3,.LC17@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_death@ha
	lis 11,.LC18@ha
	stw 3,sound_death@l(9)
	mtlr 10
	la 3,.LC18@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_idle1@ha
	lis 11,.LC19@ha
	stw 3,sound_idle1@l(9)
	mtlr 10
	la 3,.LC19@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_idle2@ha
	lis 11,.LC20@ha
	stw 3,sound_idle2@l(9)
	mtlr 10
	la 3,.LC20@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_idle3@ha
	lis 11,.LC21@ha
	stw 3,sound_idle3@l(9)
	mtlr 10
	la 3,.LC21@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain1@ha
	lis 11,.LC22@ha
	stw 3,sound_pain1@l(9)
	mtlr 10
	la 3,.LC22@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain2@ha
	lis 11,.LC23@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC23@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sight@ha
	lis 11,.LC24@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC24@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_search@ha
	lis 11,.LC25@ha
	stw 3,sound_search@l(9)
	mtlr 10
	la 3,.LC25@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_melee1@ha
	lis 11,.LC26@ha
	stw 3,sound_melee1@l(9)
	mtlr 10
	la 3,.LC26@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_melee2@ha
	lis 11,.LC27@ha
	stw 3,sound_melee2@l(9)
	mtlr 10
	la 3,.LC27@l(11)
	blrl
	lis 9,sound_melee3@ha
	li 0,5
	stw 3,sound_melee3@l(9)
	li 11,2
	stw 0,260(31)
	lis 3,.LC28@ha
	stw 11,248(31)
	la 3,.LC28@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,brain_pain@ha
	lis 11,brain_die@ha
	stw 3,40(31)
	lis 10,brain_stand@ha
	lis 8,brain_walk@ha
	lis 7,brain_run@ha
	la 9,brain_pain@l(9)
	la 11,brain_die@l(11)
	la 10,brain_stand@l(10)
	stw 9,452(31)
	la 8,brain_walk@l(8)
	la 7,brain_run@l(7)
	stw 11,456(31)
	lis 0,0xc1c0
	stw 10,788(31)
	lis 6,brain_dodge@ha
	stw 8,800(31)
	lis 5,brain_melee@ha
	lis 4,brain_sight@ha
	stw 7,804(31)
	lis 28,brain_search@ha
	lis 27,brain_idle@ha
	stw 0,196(31)
	li 9,400
	la 6,brain_dodge@l(6)
	la 5,brain_melee@l(5)
	la 4,brain_sight@l(4)
	stw 9,400(31)
	la 28,brain_search@l(28)
	la 27,brain_idle@l(27)
	stw 6,808(31)
	lis 26,0xc180
	lis 25,0x4180
	stw 5,816(31)
	lis 11,0x4200
	li 10,300
	stw 26,192(31)
	li 8,-150
	li 7,1
	stw 25,204(31)
	li 0,100
	stw 11,208(31)
	mr 3,31
	stw 10,480(31)
	stw 8,488(31)
	stw 4,820(31)
	stw 28,796(31)
	stw 27,792(31)
	stw 7,884(31)
	stw 0,888(31)
	stw 26,188(31)
	stw 25,200(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lis 9,brain_move_stand@ha
	lis 0,0x3f80
	la 9,brain_move_stand@l(9)
	stw 0,784(31)
	mr 3,31
	stw 9,772(31)
	bl walkmonster_start
.L61:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 SP_monster_brain,.Lfe2-SP_monster_brain
	.comm	v_forward,12,4
	.comm	v_right,12,4
	.comm	v_up,12,4
	.comm	invis_index,4,4
	.comm	cripple_index,4,4
	.comm	robot_index,4,4
	.comm	sun_index,4,4
	.section	".sbss","aw",@nobits
	.align 2
sound_chest_open:
	.space	4
	.size	 sound_chest_open,4
	.align 2
sound_tentacles_extend:
	.space	4
	.size	 sound_tentacles_extend,4
	.align 2
sound_tentacles_retract:
	.space	4
	.size	 sound_tentacles_retract,4
	.align 2
sound_death:
	.space	4
	.size	 sound_death,4
	.align 2
sound_idle1:
	.space	4
	.size	 sound_idle1,4
	.align 2
sound_idle2:
	.space	4
	.size	 sound_idle2,4
	.align 2
sound_idle3:
	.space	4
	.size	 sound_idle3,4
	.align 2
sound_pain1:
	.space	4
	.size	 sound_pain1,4
	.align 2
sound_pain2:
	.space	4
	.size	 sound_pain2,4
	.align 2
sound_sight:
	.space	4
	.size	 sound_sight,4
	.align 2
sound_search:
	.space	4
	.size	 sound_search,4
	.align 2
sound_melee1:
	.space	4
	.size	 sound_melee1,4
	.align 2
sound_melee2:
	.space	4
	.size	 sound_melee2,4
	.align 2
sound_melee3:
	.space	4
	.size	 sound_melee3,4
	.section	".rodata"
	.align 2
.LC30:
	.long 0x3f800000
	.align 2
.LC31:
	.long 0x0
	.section	".text"
	.align 2
	.globl brain_sight
	.type	 brain_sight,@function
brain_sight:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_sight@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC30@ha
	lwz 5,sound_sight@l(11)
	la 9,.LC30@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 2,0(9)
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 brain_sight,.Lfe3-brain_sight
	.section	".rodata"
	.align 2
.LC32:
	.long 0x3f800000
	.align 2
.LC33:
	.long 0x0
	.section	".text"
	.align 2
	.globl brain_search
	.type	 brain_search,@function
brain_search:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_search@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC32@ha
	lwz 5,sound_search@l(11)
	la 9,.LC32@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 2,0(9)
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 brain_search,.Lfe4-brain_search
	.align 2
	.globl brain_run
	.type	 brain_run,@function
brain_run:
	li 0,1
	lwz 9,776(3)
	stw 0,884(3)
	andi. 0,9,1
	bc 12,2,.L35
	lis 9,brain_move_stand@ha
	la 9,brain_move_stand@l(9)
	stw 9,772(3)
	blr
.L35:
	lis 9,brain_move_run@ha
	la 9,brain_move_run@l(9)
	stw 9,772(3)
	blr
.Lfe5:
	.size	 brain_run,.Lfe5-brain_run
	.align 2
	.globl brain_dead
	.type	 brain_dead,@function
brain_dead:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 6,0xc180
	lis 5,0x4180
	lis 0,0xc1c0
	stw 6,192(9)
	lis 11,0xc100
	li 8,7
	stw 0,196(9)
	li 10,0
	stw 5,204(9)
	lis 7,gi+72@ha
	stw 11,208(9)
	stw 8,260(9)
	stw 10,428(9)
	stw 6,188(9)
	stw 5,200(9)
	lwz 0,gi+72@l(7)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 brain_dead,.Lfe6-brain_dead
	.align 2
	.globl brain_stand
	.type	 brain_stand,@function
brain_stand:
	lis 9,brain_move_stand@ha
	la 9,brain_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe7:
	.size	 brain_stand,.Lfe7-brain_stand
	.section	".rodata"
	.align 2
.LC34:
	.long 0x3f800000
	.align 2
.LC35:
	.long 0x40000000
	.align 2
.LC36:
	.long 0x0
	.section	".text"
	.align 2
	.globl brain_idle
	.type	 brain_idle,@function
brain_idle:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+16@ha
	mr 29,3
	lwz 0,gi+16@l(9)
	lis 11,sound_idle3@ha
	lis 9,.LC34@ha
	lwz 5,sound_idle3@l(11)
	li 4,0
	la 9,.LC34@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 2,0(9)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 3,0(9)
	blrl
	lis 9,brain_move_idle@ha
	la 9,brain_move_idle@l(9)
	stw 9,772(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 brain_idle,.Lfe8-brain_idle
	.align 2
	.globl brain_walk
	.type	 brain_walk,@function
brain_walk:
	lis 9,brain_move_walk1@ha
	la 9,brain_move_walk1@l(9)
	stw 9,772(3)
	blr
.Lfe9:
	.size	 brain_walk,.Lfe9-brain_walk
	.section	".rodata"
	.align 2
.LC37:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl brain_duck_down
	.type	 brain_duck_down,@function
brain_duck_down:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	lwz 0,776(10)
	andi. 9,0,2048
	bc 4,2,.L11
	lis 9,.LC37@ha
	lfs 0,208(10)
	ori 0,0,2048
	la 9,.LC37@l(9)
	stw 0,776(10)
	lis 11,gi+72@ha
	lfs 13,0(9)
	li 9,1
	stw 9,512(10)
	fsubs 0,0,13
	stfs 0,208(10)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L11:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 brain_duck_down,.Lfe10-brain_duck_down
	.align 2
	.globl brain_duck_hold
	.type	 brain_duck_hold,@function
brain_duck_hold:
	lis 9,level+4@ha
	lfs 0,828(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L14
	lwz 0,776(3)
	rlwinm 0,0,0,25,23
	stw 0,776(3)
	blr
.L14:
	lwz 0,776(3)
	ori 0,0,128
	stw 0,776(3)
	blr
.Lfe11:
	.size	 brain_duck_hold,.Lfe11-brain_duck_hold
	.section	".rodata"
	.align 2
.LC38:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl brain_duck_up
	.type	 brain_duck_up,@function
brain_duck_up:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC38@ha
	mr 9,3
	la 11,.LC38@l(11)
	lfs 0,208(9)
	lis 10,gi+72@ha
	lfs 13,0(11)
	lwz 0,776(9)
	li 11,2
	stw 11,512(9)
	fadds 0,0,13
	rlwinm 0,0,0,21,19
	stw 0,776(9)
	stfs 0,208(9)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe12:
	.size	 brain_duck_up,.Lfe12-brain_duck_up
	.section	".rodata"
	.align 2
.LC39:
	.long 0x46fffe00
	.align 3
.LC40:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC41:
	.long 0x3fd00000
	.long 0x0
	.align 3
.LC42:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl brain_dodge
	.type	 brain_dodge,@function
brain_dodge:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	fmr 31,1
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,12(1)
	lis 10,.LC40@ha
	lis 11,.LC39@ha
	la 10,.LC40@l(10)
	stw 0,8(1)
	lfd 13,0(10)
	lfd 0,8(1)
	lis 10,.LC41@ha
	lfs 12,.LC39@l(11)
	la 10,.LC41@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,1,.L17
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L19
	stw 30,540(31)
.L19:
	lis 11,level+4@ha
	lis 9,.LC42@ha
	lfs 0,level+4@l(11)
	la 9,.LC42@l(9)
	lfd 13,0(9)
	lis 9,brain_move_duck@ha
	fadds 0,0,31
	la 9,brain_move_duck@l(9)
	stw 9,772(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,828(31)
.L17:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 brain_dodge,.Lfe13-brain_dodge
	.section	".rodata"
	.align 2
.LC43:
	.long 0x3f800000
	.align 2
.LC44:
	.long 0x0
	.section	".text"
	.align 2
	.globl brain_swing_right
	.type	 brain_swing_right,@function
brain_swing_right:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_melee1@ha
	lwz 0,gi+16@l(9)
	li 4,4
	lis 9,.LC43@ha
	lwz 5,sound_melee1@l(11)
	la 9,.LC43@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 2,0(9)
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 brain_swing_right,.Lfe14-brain_swing_right
	.section	".rodata"
	.align 2
.LC45:
	.long 0x3f800000
	.align 2
.LC46:
	.long 0x0
	.section	".text"
	.align 2
	.globl brain_hit_right
	.type	 brain_hit_right,@function
brain_hit_right:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lis 0,0x42a0
	lfs 0,200(31)
	lis 9,0x4100
	stw 0,8(1)
	stw 9,16(1)
	stfs 0,12(1)
	bl rand
	lis 9,0x6666
	mr 5,3
	ori 9,9,26215
	srawi 11,5,31
	mulhw 9,5,9
	mr 3,31
	addi 4,1,8
	li 6,40
	li 7,32
	srawi 9,9,1
	subf 9,11,9
	slwi 0,9,2
	add 0,0,9
	subf 5,0,5
	addi 5,5,15
	bl fire_hit
	cmpwi 0,3,0
	bc 12,2,.L22
	lis 9,gi+16@ha
	lis 11,sound_melee3@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,1
	lis 9,.LC45@ha
	lwz 5,sound_melee3@l(11)
	la 9,.LC45@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC45@ha
	la 9,.LC45@l(9)
	lfs 2,0(9)
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 3,0(9)
	blrl
.L22:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 brain_hit_right,.Lfe15-brain_hit_right
	.section	".rodata"
	.align 2
.LC47:
	.long 0x3f800000
	.align 2
.LC48:
	.long 0x0
	.section	".text"
	.align 2
	.globl brain_swing_left
	.type	 brain_swing_left,@function
brain_swing_left:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_melee2@ha
	lwz 0,gi+16@l(9)
	li 4,4
	lis 9,.LC47@ha
	lwz 5,sound_melee2@l(11)
	la 9,.LC47@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfs 2,0(9)
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 brain_swing_left,.Lfe16-brain_swing_left
	.section	".rodata"
	.align 2
.LC49:
	.long 0x3f800000
	.align 2
.LC50:
	.long 0x0
	.section	".text"
	.align 2
	.globl brain_hit_left
	.type	 brain_hit_left,@function
brain_hit_left:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lis 0,0x42a0
	lfs 0,188(31)
	lis 9,0x4100
	stw 0,8(1)
	stw 9,16(1)
	stfs 0,12(1)
	bl rand
	lis 9,0x6666
	mr 5,3
	ori 9,9,26215
	srawi 11,5,31
	mulhw 9,5,9
	mr 3,31
	addi 4,1,8
	li 6,40
	li 7,32
	srawi 9,9,1
	subf 9,11,9
	slwi 0,9,2
	add 0,0,9
	subf 5,0,5
	addi 5,5,15
	bl fire_hit
	cmpwi 0,3,0
	bc 12,2,.L25
	lis 9,gi+16@ha
	lis 11,sound_melee3@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,1
	lis 9,.LC49@ha
	lwz 5,sound_melee3@l(11)
	la 9,.LC49@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfs 2,0(9)
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 3,0(9)
	blrl
.L25:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 brain_hit_left,.Lfe17-brain_hit_left
	.section	".rodata"
	.align 2
.LC51:
	.long 0x3f800000
	.align 2
.LC52:
	.long 0x0
	.section	".text"
	.align 2
	.globl brain_chest_open
	.type	 brain_chest_open,@function
brain_chest_open:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	li 11,0
	lwz 0,284(9)
	lis 10,sound_chest_open@ha
	lis 8,gi+16@ha
	stw 11,884(9)
	li 4,4
	lis 11,.LC51@ha
	rlwinm 0,0,0,16,14
	lwz 5,sound_chest_open@l(10)
	la 11,.LC51@l(11)
	stw 0,284(9)
	lfs 1,0(11)
	lis 9,.LC51@ha
	lis 11,.LC52@ha
	lwz 0,gi+16@l(8)
	la 9,.LC51@l(9)
	la 11,.LC52@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 brain_chest_open,.Lfe18-brain_chest_open
	.section	".rodata"
	.align 2
.LC53:
	.long 0x0
	.align 2
.LC54:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl brain_tentacle_attack
	.type	 brain_tentacle_attack,@function
brain_tentacle_attack:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stw 31,36(1)
	stw 0,52(1)
	lis 11,.LC53@ha
	lis 9,0x42a0
	la 11,.LC53@l(11)
	lis 0,0x4100
	stw 9,8(1)
	lfs 31,0(11)
	mr 31,3
	stw 0,16(1)
	stfs 31,12(1)
	bl rand
	lis 9,0x6666
	mr 5,3
	ori 9,9,26215
	srawi 11,5,31
	mulhw 9,5,9
	mr 3,31
	addi 4,1,8
	li 6,-600
	li 7,32
	srawi 9,9,1
	subf 9,11,9
	slwi 0,9,2
	add 0,0,9
	subf 5,0,5
	addi 5,5,10
	bl fire_hit
	cmpwi 0,3,0
	bc 12,2,.L28
	lis 9,skill@ha
	lwz 11,skill@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,1,.L28
	lwz 0,284(31)
	oris 0,0,0x1
	stw 0,284(31)
.L28:
	lis 9,gi+16@ha
	lis 11,sound_tentacles_retract@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,1
	lis 9,.LC54@ha
	lwz 5,sound_tentacles_retract@l(11)
	la 9,.LC54@l(9)
	lis 11,.LC54@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC54@l(11)
	lis 9,.LC53@ha
	lfs 2,0(11)
	la 9,.LC53@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,52(1)
	mtlr 0
	lwz 31,36(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe19:
	.size	 brain_tentacle_attack,.Lfe19-brain_tentacle_attack
	.align 2
	.globl brain_chest_closed
	.type	 brain_chest_closed,@function
brain_chest_closed:
	li 0,1
	lwz 11,284(3)
	stw 0,884(3)
	andis. 0,11,1
	bclr 12,2
	lis 9,brain_move_attack1@ha
	rlwinm 0,11,0,16,14
	la 9,brain_move_attack1@l(9)
	stw 0,284(3)
	stw 9,772(3)
	blr
.Lfe20:
	.size	 brain_chest_closed,.Lfe20-brain_chest_closed
	.section	".rodata"
	.align 2
.LC55:
	.long 0x46fffe00
	.align 3
.LC56:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC57:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl brain_melee
	.type	 brain_melee,@function
brain_melee:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC56@ha
	lis 11,.LC55@ha
	la 10,.LC56@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC57@ha
	lfs 12,.LC55@l(11)
	la 10,.LC57@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,0
	bc 4,3,.L32
	lis 9,brain_move_attack1@ha
	la 9,brain_move_attack1@l(9)
	b .L63
.L32:
	lis 9,brain_move_attack2@ha
	la 9,brain_move_attack2@l(9)
.L63:
	stw 9,772(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 brain_melee,.Lfe21-brain_melee
	.section	".rodata"
	.align 2
.LC58:
	.long 0x46fffe00
	.align 2
.LC59:
	.long 0x3f800000
	.align 2
.LC60:
	.long 0x0
	.align 3
.LC61:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC62:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl brain_die
	.type	 brain_die,@function
brain_die:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 30,3
	li 0,0
	lwz 11,480(30)
	mr 28,6
	lwz 9,488(30)
	stw 0,884(30)
	cmpw 0,11,9
	stw 0,64(30)
	bc 12,1,.L47
	lis 29,gi@ha
	lis 3,.LC9@ha
	la 29,gi@l(29)
	la 3,.LC9@l(3)
	lwz 9,36(29)
	lis 27,.LC10@ha
	lis 26,.LC11@ha
	li 31,2
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC59@ha
	lis 10,.LC59@ha
	lis 11,.LC60@ha
	mr 5,3
	la 9,.LC59@l(9)
	la 10,.LC59@l(10)
	mtlr 0
	la 11,.LC60@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L51:
	mr 3,30
	la 4,.LC10@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L51
	li 31,4
.L56:
	mr 3,30
	la 4,.LC11@l(26)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L56
	lis 4,.LC12@ha
	mr 5,28
	la 4,.LC12@l(4)
	mr 3,30
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,492(30)
	b .L46
.L47:
	lwz 0,492(30)
	cmpwi 0,0,2
	bc 12,2,.L46
	lis 11,gi+16@ha
	lis 9,sound_death@ha
	lwz 0,gi+16@l(11)
	lis 10,.LC59@ha
	mr 3,30
	lwz 5,sound_death@l(9)
	lis 11,.LC60@ha
	la 10,.LC59@l(10)
	lis 9,.LC59@ha
	la 11,.LC60@l(11)
	lfs 2,0(10)
	mtlr 0
	la 9,.LC59@l(9)
	lfs 3,0(11)
	li 4,2
	lfs 1,0(9)
	blrl
	li 0,2
	li 9,1
	stw 0,492(30)
	stw 9,512(30)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC61@ha
	lis 11,.LC58@ha
	la 10,.LC61@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC62@ha
	lfs 12,.LC58@l(11)
	la 10,.LC62@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,0
	bc 4,3,.L59
	lis 9,brain_move_death1@ha
	la 9,brain_move_death1@l(9)
	b .L64
.L59:
	lis 9,brain_move_death2@ha
	la 9,brain_move_death2@l(9)
.L64:
	stw 9,772(30)
.L46:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe22:
	.size	 brain_die,.Lfe22-brain_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
