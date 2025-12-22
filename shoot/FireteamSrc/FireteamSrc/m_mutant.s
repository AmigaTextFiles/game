	.file	"m_mutant.c"
gcc2_compiled.:
	.globl mutant_frames_stand
	.section	".data"
	.align 2
	.type	 mutant_frames_stand,@object
mutant_frames_stand:
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
	.size	 mutant_frames_stand,612
	.globl mutant_move_stand
	.align 2
	.type	 mutant_move_stand,@object
	.size	 mutant_move_stand,16
mutant_move_stand:
	.long 62
	.long 112
	.long mutant_frames_stand
	.long 0
	.globl mutant_frames_idle
	.align 2
	.type	 mutant_frames_idle,@object
mutant_frames_idle:
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
	.long mutant_idle_loop
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
	.size	 mutant_frames_idle,156
	.globl mutant_move_idle
	.align 2
	.type	 mutant_move_idle,@object
	.size	 mutant_move_idle,16
mutant_move_idle:
	.long 113
	.long 125
	.long mutant_frames_idle
	.long mutant_stand
	.globl mutant_frames_walk
	.align 2
	.type	 mutant_frames_walk,@object
mutant_frames_walk:
	.long ai_walk
	.long 0x40400000
	.long 0
	.long ai_walk
	.long 0x3f800000
	.long 0
	.long ai_walk
	.long 0x40a00000
	.long 0
	.long ai_walk
	.long 0x41200000
	.long 0
	.long ai_walk
	.long 0x41500000
	.long 0
	.long ai_walk
	.long 0x41200000
	.long 0
	.long ai_walk
	.long 0x0
	.long 0
	.long ai_walk
	.long 0x40a00000
	.long 0
	.long ai_walk
	.long 0x40c00000
	.long 0
	.long ai_walk
	.long 0x41800000
	.long 0
	.long ai_walk
	.long 0x41700000
	.long 0
	.long ai_walk
	.long 0x40c00000
	.long 0
	.size	 mutant_frames_walk,144
	.globl mutant_move_walk
	.align 2
	.type	 mutant_move_walk,@object
	.size	 mutant_move_walk,16
mutant_move_walk:
	.long 130
	.long 141
	.long mutant_frames_walk
	.long 0
	.globl mutant_frames_start_walk
	.align 2
	.type	 mutant_frames_start_walk,@object
mutant_frames_start_walk:
	.long ai_walk
	.long 0x40a00000
	.long 0
	.long ai_walk
	.long 0x40a00000
	.long 0
	.long ai_walk
	.long 0xc0000000
	.long 0
	.long ai_walk
	.long 0x3f800000
	.long 0
	.size	 mutant_frames_start_walk,48
	.globl mutant_move_start_walk
	.align 2
	.type	 mutant_move_start_walk,@object
	.size	 mutant_move_start_walk,16
mutant_move_start_walk:
	.long 126
	.long 129
	.long mutant_frames_start_walk
	.long mutant_walk_loop
	.globl mutant_frames_run
	.align 2
	.type	 mutant_frames_run,@object
mutant_frames_run:
	.long ai_run
	.long 0x42200000
	.long 0
	.long ai_run
	.long 0x42200000
	.long mutant_step
	.long ai_run
	.long 0x41c00000
	.long 0
	.long ai_run
	.long 0x40a00000
	.long mutant_step
	.long ai_run
	.long 0x41880000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.size	 mutant_frames_run,72
	.globl mutant_move_run
	.align 2
	.type	 mutant_move_run,@object
	.size	 mutant_move_run,16
mutant_move_run:
	.long 56
	.long 61
	.long mutant_frames_run
	.long 0
	.globl mutant_frames_attack
	.align 2
	.type	 mutant_frames_attack,@object
mutant_frames_attack:
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long mutant_hit_left
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long mutant_hit_right
	.long ai_charge
	.long 0x0
	.long mutant_check_refire
	.size	 mutant_frames_attack,84
	.globl mutant_move_attack
	.align 2
	.type	 mutant_move_attack,@object
	.size	 mutant_move_attack,16
mutant_move_attack:
	.long 8
	.long 14
	.long mutant_frames_attack
	.long mutant_run
	.globl mutant_frames_jump
	.align 2
	.type	 mutant_frames_jump,@object
mutant_frames_jump:
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x41880000
	.long 0
	.long ai_charge
	.long 0x41700000
	.long mutant_jump_takeoff
	.long ai_charge
	.long 0x41700000
	.long 0
	.long ai_charge
	.long 0x41700000
	.long mutant_check_landing
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x40400000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.size	 mutant_frames_jump,96
	.globl mutant_move_jump
	.align 2
	.type	 mutant_move_jump,@object
	.size	 mutant_move_jump,16
mutant_move_jump:
	.long 0
	.long 7
	.long mutant_frames_jump
	.long mutant_run
	.section	".rodata"
	.align 2
.LC3:
	.long 0x46fffe00
	.align 3
.LC4:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 3
.LC5:
	.long 0x3fe80000
	.long 0x0
	.align 3
.LC6:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC7:
	.long 0x42c80000
	.align 3
.LC8:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl mutant_check_jump
	.type	 mutant_check_jump,@function
mutant_check_jump:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	mr 9,3
	lis 10,.LC5@ha
	lwz 11,540(9)
	la 10,.LC5@l(10)
	lfd 13,0(10)
	lfs 12,220(11)
	lfs 11,244(11)
	lfs 0,220(9)
	fmadd 13,11,13,12
	fcmpu 0,0,13
	bc 12,1,.L57
	lis 10,.LC6@ha
	lfs 13,232(9)
	la 10,.LC6@l(10)
	lfd 0,0(10)
	fmadd 0,11,0,12
	fcmpu 0,13,0
	bc 12,0,.L57
	lfs 12,4(11)
	li 0,0
	addi 3,1,8
	lfs 0,4(9)
	lfs 13,8(9)
	fsubs 0,0,12
	stfs 0,8(1)
	lfs 12,8(11)
	stw 0,16(1)
	fsubs 13,13,12
	stfs 13,12(1)
	bl VectorLength
	lis 9,.LC7@ha
	la 9,.LC7@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L53
.L57:
	li 3,0
	b .L56
.L53:
	bc 4,1,.L54
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC8@ha
	lis 11,.LC4@ha
	la 10,.LC8@l(10)
	stw 0,24(1)
	li 3,0
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC3@ha
	lfs 11,.LC3@l(10)
	lfd 12,.LC4@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 12,0,.L56
.L54:
	li 3,1
.L56:
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe1:
	.size	 mutant_check_jump,.Lfe1-mutant_check_jump
	.globl mutant_frames_pain1
	.section	".data"
	.align 2
	.type	 mutant_frames_pain1,@object
mutant_frames_pain1:
	.long ai_move
	.long 0x40800000
	.long 0
	.long ai_move
	.long 0xc0400000
	.long 0
	.long ai_move
	.long 0xc1000000
	.long 0
	.long ai_move
	.long 0x40000000
	.long 0
	.long ai_move
	.long 0x40a00000
	.long 0
	.size	 mutant_frames_pain1,60
	.globl mutant_move_pain1
	.align 2
	.type	 mutant_move_pain1,@object
	.size	 mutant_move_pain1,16
mutant_move_pain1:
	.long 34
	.long 38
	.long mutant_frames_pain1
	.long mutant_run
	.globl mutant_frames_pain2
	.align 2
	.type	 mutant_frames_pain2,@object
mutant_frames_pain2:
	.long ai_move
	.long 0xc1c00000
	.long 0
	.long ai_move
	.long 0x41300000
	.long 0
	.long ai_move
	.long 0x40a00000
	.long 0
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0x40c00000
	.long 0
	.long ai_move
	.long 0x40800000
	.long 0
	.size	 mutant_frames_pain2,72
	.globl mutant_move_pain2
	.align 2
	.type	 mutant_move_pain2,@object
	.size	 mutant_move_pain2,16
mutant_move_pain2:
	.long 39
	.long 44
	.long mutant_frames_pain2
	.long mutant_run
	.globl mutant_frames_pain3
	.align 2
	.type	 mutant_frames_pain3,@object
mutant_frames_pain3:
	.long ai_move
	.long 0xc1b00000
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x40000000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x40c00000
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x40000000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.size	 mutant_frames_pain3,132
	.globl mutant_move_pain3
	.align 2
	.type	 mutant_move_pain3,@object
	.size	 mutant_move_pain3,16
mutant_move_pain3:
	.long 45
	.long 55
	.long mutant_frames_pain3
	.long mutant_run
	.section	".rodata"
	.align 2
.LC9:
	.long 0x46fffe00
	.align 3
.LC10:
	.long 0x3fd51eb8
	.long 0x51eb851f
	.align 3
.LC11:
	.long 0x3fe51eb8
	.long 0x51eb851f
	.align 2
.LC12:
	.long 0x40400000
	.align 3
.LC13:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC14:
	.long 0x3f800000
	.align 2
.LC15:
	.long 0x0
	.section	".text"
	.align 2
	.globl mutant_pain
	.type	 mutant_pain,@function
mutant_pain:
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
	bc 4,0,.L66
	li 0,1
	stw 0,60(31)
.L66:
	lis 9,level+4@ha
	lfs 0,464(31)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L65
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	lfs 12,0(9)
	lis 9,skill@ha
	lwz 11,skill@l(9)
	fadds 13,13,12
	stfs 13,464(31)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L65
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC13@ha
	lis 10,.LC9@ha
	la 11,.LC13@l(11)
	stw 0,16(1)
	lfd 12,0(11)
	lfd 0,16(1)
	lis 11,.LC10@ha
	lfs 11,.LC9@l(10)
	lfd 13,.LC10@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,11
	fmr 12,0
	fcmpu 0,12,13
	bc 4,0,.L69
	lis 9,gi+16@ha
	lis 11,sound_pain1@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC14@ha
	lwz 5,sound_pain1@l(11)
	la 9,.LC14@l(9)
	lis 11,.LC14@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC14@l(11)
	lis 9,.LC15@ha
	lfs 2,0(11)
	la 9,.LC15@l(9)
	lfs 3,0(9)
	blrl
	lis 9,mutant_move_pain1@ha
	la 9,mutant_move_pain1@l(9)
	b .L73
.L69:
	lis 9,.LC11@ha
	lfd 0,.LC11@l(9)
	fcmpu 0,12,0
	bc 4,0,.L71
	lis 9,gi+16@ha
	lis 11,sound_pain2@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC14@ha
	lwz 5,sound_pain2@l(11)
	la 9,.LC14@l(9)
	lis 11,.LC14@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC14@l(11)
	lis 9,.LC15@ha
	lfs 2,0(11)
	la 9,.LC15@l(9)
	lfs 3,0(9)
	blrl
	lis 9,mutant_move_pain2@ha
	la 9,mutant_move_pain2@l(9)
	b .L73
.L71:
	lis 9,gi+16@ha
	lis 11,sound_pain1@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC14@ha
	lwz 5,sound_pain1@l(11)
	la 9,.LC14@l(9)
	lis 11,.LC14@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC14@l(11)
	lis 9,.LC15@ha
	lfs 2,0(11)
	la 9,.LC15@l(9)
	lfs 3,0(9)
	blrl
	lis 9,mutant_move_pain3@ha
	la 9,mutant_move_pain3@l(9)
.L73:
	stw 9,772(31)
.L65:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 mutant_pain,.Lfe2-mutant_pain
	.globl mutant_frames_death1
	.section	".data"
	.align 2
	.type	 mutant_frames_death1,@object
mutant_frames_death1:
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
	.size	 mutant_frames_death1,108
	.globl mutant_move_death1
	.align 2
	.type	 mutant_move_death1,@object
	.size	 mutant_move_death1,16
mutant_move_death1:
	.long 15
	.long 23
	.long mutant_frames_death1
	.long mutant_dead
	.globl mutant_frames_death2
	.align 2
	.type	 mutant_frames_death2,@object
mutant_frames_death2:
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
	.size	 mutant_frames_death2,120
	.globl mutant_move_death2
	.align 2
	.type	 mutant_move_death2,@object
	.size	 mutant_move_death2,16
mutant_move_death2:
	.long 24
	.long 33
	.long mutant_frames_death2
	.long mutant_dead
	.section	".rodata"
	.align 2
.LC16:
	.string	"misc/udeath.wav"
	.align 2
.LC17:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC18:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC19:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC21:
	.string	"mutant/mutatck1.wav"
	.align 2
.LC22:
	.string	"mutant/mutatck2.wav"
	.align 2
.LC23:
	.string	"mutant/mutatck3.wav"
	.align 2
.LC24:
	.string	"mutant/mutdeth1.wav"
	.align 2
.LC25:
	.string	"mutant/mutidle1.wav"
	.align 2
.LC26:
	.string	"mutant/mutpain1.wav"
	.align 2
.LC27:
	.string	"mutant/mutpain2.wav"
	.align 2
.LC28:
	.string	"mutant/mutsght1.wav"
	.align 2
.LC29:
	.string	"mutant/mutsrch1.wav"
	.align 2
.LC30:
	.string	"mutant/step1.wav"
	.align 2
.LC31:
	.string	"mutant/step2.wav"
	.align 2
.LC32:
	.string	"mutant/step3.wav"
	.align 2
.LC33:
	.string	"mutant/thud1.wav"
	.align 2
.LC34:
	.string	"models/monsters/mutant/tris.md2"
	.section	".text"
	.align 2
	.globl SP_monster_mutant
	.type	 SP_monster_mutant,@function
SP_monster_mutant:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 31,3
	bl G_IsDeathmatch
	mr. 28,3
	bc 4,2,.L90
	lis 29,gi@ha
	lis 3,.LC21@ha
	la 29,gi@l(29)
	la 3,.LC21@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_swing@ha
	lis 11,.LC22@ha
	stw 3,sound_swing@l(9)
	mtlr 10
	la 3,.LC22@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_hit@ha
	lis 11,.LC23@ha
	stw 3,sound_hit@l(9)
	mtlr 10
	la 3,.LC23@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_hit2@ha
	lis 11,.LC24@ha
	stw 3,sound_hit2@l(9)
	mtlr 10
	la 3,.LC24@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_death@ha
	lis 11,.LC25@ha
	stw 3,sound_death@l(9)
	mtlr 10
	la 3,.LC25@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_idle@ha
	lis 11,.LC26@ha
	stw 3,sound_idle@l(9)
	mtlr 10
	la 3,.LC26@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain1@ha
	lis 11,.LC27@ha
	stw 3,sound_pain1@l(9)
	mtlr 10
	la 3,.LC27@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain2@ha
	lis 11,.LC28@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC28@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sight@ha
	lis 11,.LC29@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC29@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_search@ha
	lis 11,.LC30@ha
	stw 3,sound_search@l(9)
	mtlr 10
	la 3,.LC30@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_step1@ha
	lis 11,.LC31@ha
	stw 3,sound_step1@l(9)
	mtlr 10
	la 3,.LC31@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_step2@ha
	lis 11,.LC32@ha
	stw 3,sound_step2@l(9)
	mtlr 10
	la 3,.LC32@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_step3@ha
	lis 11,.LC33@ha
	stw 3,sound_step3@l(9)
	mtlr 10
	la 3,.LC33@l(11)
	blrl
	lis 9,sound_thud@ha
	li 0,5
	stw 3,sound_thud@l(9)
	li 11,2
	stw 0,260(31)
	lis 3,.LC34@ha
	stw 11,248(31)
	la 3,.LC34@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,mutant_pain@ha
	lis 11,mutant_die@ha
	stw 28,808(31)
	lis 10,mutant_stand@ha
	lis 8,mutant_walk@ha
	stw 3,40(31)
	lis 7,mutant_run@ha
	la 9,mutant_pain@l(9)
	la 11,mutant_die@l(11)
	la 10,mutant_stand@l(10)
	stw 9,452(31)
	la 8,mutant_walk@l(8)
	la 7,mutant_run@l(7)
	stw 11,456(31)
	stw 10,788(31)
	lis 6,mutant_jump@ha
	lis 5,mutant_melee@ha
	stw 8,800(31)
	lis 4,mutant_sight@ha
	lis 28,mutant_search@ha
	stw 7,804(31)
	lis 27,mutant_idle@ha
	lis 26,mutant_checkattack@ha
	lis 8,0xc200
	lis 7,0x4200
	li 10,300
	lis 9,0x4240
	stw 8,192(31)
	la 6,mutant_jump@l(6)
	la 5,mutant_melee@l(5)
	stw 9,208(31)
	la 4,mutant_sight@l(4)
	la 28,mutant_search@l(28)
	stw 6,812(31)
	la 27,mutant_idle@l(27)
	la 26,mutant_checkattack@l(26)
	stw 7,204(31)
	lis 0,0xc1c0
	li 11,-120
	stw 10,400(31)
	stw 0,196(31)
	mr 3,31
	stw 11,488(31)
	stw 5,816(31)
	stw 4,820(31)
	stw 28,796(31)
	stw 27,792(31)
	stw 26,824(31)
	stw 8,188(31)
	stw 7,200(31)
	stw 10,480(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lis 9,mutant_move_stand@ha
	lis 0,0x3f80
	la 9,mutant_move_stand@l(9)
	stw 0,784(31)
	mr 3,31
	stw 9,772(31)
	bl walkmonster_start
.L90:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 SP_monster_mutant,.Lfe3-SP_monster_mutant
	.comm	lights,4,4
	.comm	saved_client,780,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_blaster,4,4
	.comm	item_shotgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_supershotgun,4,4
	.comm	item_chaingun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_railgun,4,4
	.comm	item_bfg,4,4
	.comm	item_jacketarmor,4,4
	.comm	item_combatarmor,4,4
	.comm	item_bodyarmor,4,4
	.comm	item_armorshard,4,4
	.comm	item_powerscreen,4,4
	.comm	item_powershield,4,4
	.comm	item_adrenaline,4,4
	.comm	item_health,4,4
	.comm	item_stimpak,4,4
	.comm	item_health_large,4,4
	.comm	item_health_mega,4,4
	.comm	item_quad,4,4
	.comm	item_invulnerability,4,4
	.comm	item_silencer,4,4
	.comm	item_breather,4,4
	.comm	item_enviro,4,4
	.comm	item_pack,4,4
	.comm	item_bandolier,4,4
	.comm	item_ancient_head,4,4
	.comm	key_data_cd,4,4
	.comm	key_power_cube,4,4
	.comm	key_pyramid,4,4
	.comm	key_data_spinner,4,4
	.comm	key_pass,4,4
	.comm	key_blue_key,4,4
	.comm	key_red_key,4,4
	.comm	key_commander_head,4,4
	.comm	key_airstrike_target,4,4
	.section	".sbss","aw",@nobits
	.align 2
sound_swing:
	.space	4
	.size	 sound_swing,4
	.align 2
sound_hit:
	.space	4
	.size	 sound_hit,4
	.align 2
sound_hit2:
	.space	4
	.size	 sound_hit2,4
	.align 2
sound_death:
	.space	4
	.size	 sound_death,4
	.align 2
sound_idle:
	.space	4
	.size	 sound_idle,4
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
sound_step1:
	.space	4
	.size	 sound_step1,4
	.align 2
sound_step2:
	.space	4
	.size	 sound_step2,4
	.align 2
sound_step3:
	.space	4
	.size	 sound_step3,4
	.align 2
sound_thud:
	.space	4
	.size	 sound_thud,4
	.section	".rodata"
	.align 2
.LC35:
	.long 0x3f800000
	.align 2
.LC36:
	.long 0x0
	.section	".text"
	.align 2
	.globl mutant_step
	.type	 mutant_step,@function
mutant_step:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl rand
	lis 9,0x5555
	addi 3,3,1
	ori 9,9,21846
	srawi 11,3,31
	mulhw 9,3,9
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf. 9,0,3
	bc 4,2,.L7
	lis 9,gi+16@ha
	lis 11,sound_step1@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC35@ha
	lwz 5,sound_step1@l(11)
	b .L92
.L7:
	cmpwi 0,9,1
	bc 4,2,.L9
	lis 9,gi+16@ha
	lis 11,sound_step2@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC35@ha
	lwz 5,sound_step2@l(11)
.L92:
	la 9,.LC35@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 2,0(9)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 3,0(9)
	blrl
	b .L8
.L9:
	lis 9,gi+16@ha
	lis 11,sound_step3@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC35@ha
	lwz 5,sound_step3@l(11)
	la 9,.LC35@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 2,0(9)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 3,0(9)
	blrl
.L8:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 mutant_step,.Lfe4-mutant_step
	.section	".rodata"
	.align 2
.LC37:
	.long 0x3f800000
	.align 2
.LC38:
	.long 0x0
	.section	".text"
	.align 2
	.globl mutant_sight
	.type	 mutant_sight,@function
mutant_sight:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_sight@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC37@ha
	lwz 5,sound_sight@l(11)
	la 9,.LC37@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 2,0(9)
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe5:
	.size	 mutant_sight,.Lfe5-mutant_sight
	.section	".rodata"
	.align 2
.LC39:
	.long 0x3f800000
	.align 2
.LC40:
	.long 0x0
	.section	".text"
	.align 2
	.globl mutant_search
	.type	 mutant_search,@function
mutant_search:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_search@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC39@ha
	lwz 5,sound_search@l(11)
	la 9,.LC39@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 2,0(9)
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 mutant_search,.Lfe6-mutant_search
	.section	".rodata"
	.align 2
.LC41:
	.long 0x3f800000
	.align 2
.LC42:
	.long 0x0
	.section	".text"
	.align 2
	.globl mutant_swing
	.type	 mutant_swing,@function
mutant_swing:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_swing@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC41@ha
	lwz 5,sound_swing@l(11)
	la 9,.LC41@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 2,0(9)
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 mutant_swing,.Lfe7-mutant_swing
	.align 2
	.globl mutant_stand
	.type	 mutant_stand,@function
mutant_stand:
	lis 9,mutant_move_stand@ha
	la 9,mutant_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe8:
	.size	 mutant_stand,.Lfe8-mutant_stand
	.section	".rodata"
	.align 2
.LC43:
	.long 0x46fffe00
	.align 3
.LC44:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC45:
	.long 0x3fe80000
	.long 0x0
	.section	".text"
	.align 2
	.globl mutant_idle_loop
	.type	 mutant_idle_loop,@function
mutant_idle_loop:
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
	lis 10,.LC44@ha
	lis 11,.LC43@ha
	la 10,.LC44@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC45@ha
	lfs 12,.LC43@l(11)
	la 10,.LC45@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L16
	li 0,116
	stw 0,780(31)
.L16:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 mutant_idle_loop,.Lfe9-mutant_idle_loop
	.section	".rodata"
	.align 2
.LC46:
	.long 0x3f800000
	.align 2
.LC47:
	.long 0x40000000
	.align 2
.LC48:
	.long 0x0
	.section	".text"
	.align 2
	.globl mutant_idle
	.type	 mutant_idle,@function
mutant_idle:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,mutant_move_idle@ha
	lis 11,gi+16@ha
	la 9,mutant_move_idle@l(9)
	lis 10,sound_idle@ha
	stw 9,772(3)
	li 4,2
	lis 9,.LC46@ha
	lwz 0,gi+16@l(11)
	la 9,.LC46@l(9)
	lwz 5,sound_idle@l(10)
	lfs 1,0(9)
	mtlr 0
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
.Lfe10:
	.size	 mutant_idle,.Lfe10-mutant_idle
	.align 2
	.globl mutant_walk
	.type	 mutant_walk,@function
mutant_walk:
	lis 9,mutant_move_start_walk@ha
	la 9,mutant_move_start_walk@l(9)
	stw 9,772(3)
	blr
.Lfe11:
	.size	 mutant_walk,.Lfe11-mutant_walk
	.align 2
	.globl mutant_walk_loop
	.type	 mutant_walk_loop,@function
mutant_walk_loop:
	lis 9,mutant_move_walk@ha
	la 9,mutant_move_walk@l(9)
	stw 9,772(3)
	blr
.Lfe12:
	.size	 mutant_walk_loop,.Lfe12-mutant_walk_loop
	.align 2
	.globl mutant_run
	.type	 mutant_run,@function
mutant_run:
	lwz 0,776(3)
	andi. 9,0,1
	bc 12,2,.L21
	lis 9,mutant_move_stand@ha
	la 9,mutant_move_stand@l(9)
	stw 9,772(3)
	blr
.L21:
	lis 9,mutant_move_run@ha
	la 9,mutant_move_run@l(9)
	stw 9,772(3)
	blr
.Lfe13:
	.size	 mutant_run,.Lfe13-mutant_run
	.section	".rodata"
	.align 2
.LC49:
	.long 0x3f800000
	.align 2
.LC50:
	.long 0x0
	.section	".text"
	.align 2
	.globl mutant_hit_left
	.type	 mutant_hit_left,@function
mutant_hit_left:
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
	li 6,100
	srawi 9,9,1
	subf 9,11,9
	slwi 0,9,2
	add 0,0,9
	subf 5,0,5
	addi 5,5,10
	bl fire_hit
	cmpwi 0,3,0
	bc 12,2,.L24
	lis 9,gi+16@ha
	lis 11,sound_hit@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,1
	lis 9,.LC49@ha
	lwz 5,sound_hit@l(11)
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
	b .L25
.L24:
	lis 9,gi+16@ha
	lis 11,sound_swing@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,1
	lis 9,.LC49@ha
	lwz 5,sound_swing@l(11)
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
.Lfe14:
	.size	 mutant_hit_left,.Lfe14-mutant_hit_left
	.section	".rodata"
	.align 2
.LC51:
	.long 0x3f800000
	.align 2
.LC52:
	.long 0x0
	.section	".text"
	.align 2
	.globl mutant_hit_right
	.type	 mutant_hit_right,@function
mutant_hit_right:
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
	li 6,100
	srawi 9,9,1
	subf 9,11,9
	slwi 0,9,2
	add 0,0,9
	subf 5,0,5
	addi 5,5,10
	bl fire_hit
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 9,gi+16@ha
	lis 11,sound_hit2@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,1
	lis 9,.LC51@ha
	lwz 5,sound_hit2@l(11)
	la 9,.LC51@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 2,0(9)
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 3,0(9)
	blrl
	b .L28
.L27:
	lis 9,gi+16@ha
	lis 11,sound_swing@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,1
	lis 9,.LC51@ha
	lwz 5,sound_swing@l(11)
	la 9,.LC51@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 2,0(9)
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 3,0(9)
	blrl
.L28:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 mutant_hit_right,.Lfe15-mutant_hit_right
	.section	".rodata"
	.align 2
.LC53:
	.long 0x46fffe00
	.align 2
.LC54:
	.long 0x40400000
	.align 3
.LC55:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC56:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl mutant_check_refire
	.type	 mutant_check_refire,@function
mutant_check_refire:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L29
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L29
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L29
	lis 9,.LC54@ha
	lis 11,skill@ha
	la 9,.LC54@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L34
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC55@ha
	lis 11,.LC53@ha
	la 10,.LC55@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC56@ha
	lfs 12,.LC53@l(11)
	la 10,.LC56@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L33
.L34:
	lwz 4,540(31)
	mr 3,31
	bl range
	cmpwi 0,3,0
	bc 4,2,.L29
.L33:
	li 0,8
	stw 0,780(31)
.L29:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 mutant_check_refire,.Lfe16-mutant_check_refire
	.align 2
	.globl mutant_melee
	.type	 mutant_melee,@function
mutant_melee:
	lis 9,mutant_move_attack@ha
	la 9,mutant_move_attack@l(9)
	stw 9,772(3)
	blr
.Lfe17:
	.size	 mutant_melee,.Lfe17-mutant_melee
	.section	".rodata"
	.align 2
.LC57:
	.long 0x46fffe00
	.align 2
.LC58:
	.long 0x43c80000
	.align 3
.LC59:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC60:
	.long 0x41200000
	.align 2
.LC61:
	.long 0x42200000
	.section	".text"
	.align 2
	.globl mutant_jump_touch
	.type	 mutant_jump_touch,@function
mutant_jump_touch:
	stwu 1,-80(1)
	mflr 0
	stmw 28,64(1)
	stw 0,84(1)
	mr 31,3
	mr 28,4
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L40
	lwz 0,512(28)
	cmpwi 0,0,0
	bc 12,2,.L38
	addi 30,31,376
	mr 3,30
	bl VectorLength
	lis 9,.LC58@ha
	la 9,.LC58@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,1,.L38
	lfs 12,376(31)
	addi 29,1,32
	lfs 13,380(31)
	mr 3,29
	lfs 0,384(31)
	stfs 12,32(1)
	stfs 13,36(1)
	stfs 0,40(1)
	bl VectorNormalize
	lfs 1,200(31)
	mr 4,29
	addi 5,1,16
	addi 3,31,4
	bl VectorMA
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,60(1)
	lis 10,.LC59@ha
	lis 11,.LC57@ha
	stw 0,56(1)
	la 10,.LC59@l(10)
	mr 3,28
	lfd 0,0(10)
	li 0,0
	mr 6,30
	lfd 13,56(1)
	lis 10,.LC60@ha
	mr 8,29
	lfs 11,.LC57@l(11)
	la 10,.LC60@l(10)
	mr 4,31
	lfs 9,0(10)
	mr 5,31
	addi 7,1,16
	fsub 13,13,0
	lis 10,.LC61@ha
	stw 0,12(1)
	la 10,.LC61@l(10)
	stw 0,8(1)
	lfs 10,0(10)
	frsp 13,13
	fdivs 13,13,11
	fmadds 13,13,9,10
	fmr 0,13
	fctiwz 12,0
	stfd 12,56(1)
	lwz 9,60(1)
	mr 10,9
	bl T_Damage
.L38:
	mr 3,31
	bl M_CheckBottom
	mr. 3,3
	bc 4,2,.L40
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L36
	li 0,1
	stw 3,444(31)
	stw 0,780(31)
	b .L36
.L40:
	li 0,0
	stw 0,444(31)
.L36:
	lwz 0,84(1)
	mtlr 0
	lmw 28,64(1)
	la 1,80(1)
	blr
.Lfe18:
	.size	 mutant_jump_touch,.Lfe18-mutant_jump_touch
	.section	".rodata"
	.align 2
.LC62:
	.long 0x3f800000
	.align 2
.LC63:
	.long 0x0
	.align 2
.LC64:
	.long 0x44160000
	.align 2
.LC65:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl mutant_jump_takeoff
	.type	 mutant_jump_takeoff,@function
mutant_jump_takeoff:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,gi+16@ha
	mr 29,3
	lwz 0,gi+16@l(9)
	lis 11,sound_sight@ha
	lis 9,.LC62@ha
	lwz 5,sound_sight@l(11)
	li 4,2
	la 9,.LC62@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC62@ha
	la 9,.LC62@l(9)
	lfs 2,0(9)
	lis 9,.LC63@ha
	la 9,.LC63@l(9)
	lfs 3,0(9)
	blrl
	addi 4,1,8
	li 6,0
	addi 3,29,16
	li 5,0
	bl AngleVectors
	lis 9,.LC62@ha
	lfs 0,12(29)
	addi 3,1,8
	la 9,.LC62@l(9)
	addi 4,29,376
	lfs 13,0(9)
	lis 9,.LC64@ha
	la 9,.LC64@l(9)
	fadds 0,0,13
	lfs 1,0(9)
	stfs 0,12(29)
	bl VectorScale
	lwz 11,776(29)
	lis 0,0x437a
	li 10,0
	lis 9,.LC65@ha
	stw 0,384(29)
	lis 8,level+4@ha
	ori 11,11,2048
	la 9,.LC65@l(9)
	stw 10,552(29)
	stw 11,776(29)
	lfs 0,level+4@l(8)
	lfs 13,0(9)
	lis 9,mutant_jump_touch@ha
	la 9,mutant_jump_touch@l(9)
	fadds 0,0,13
	stw 9,444(29)
	stfs 0,832(29)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe19:
	.size	 mutant_jump_takeoff,.Lfe19-mutant_jump_takeoff
	.section	".rodata"
	.align 2
.LC66:
	.long 0x3f800000
	.align 2
.LC67:
	.long 0x0
	.section	".text"
	.align 2
	.globl mutant_check_landing
	.type	 mutant_check_landing,@function
mutant_check_landing:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L44
	lis 9,gi+16@ha
	lis 11,sound_thud@ha
	lwz 0,gi+16@l(9)
	li 4,1
	lis 9,.LC66@ha
	lwz 5,sound_thud@l(11)
	la 9,.LC66@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC66@ha
	la 9,.LC66@l(9)
	lfs 2,0(9)
	lis 9,.LC67@ha
	la 9,.LC67@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,776(31)
	li 9,0
	stw 9,832(31)
	rlwinm 0,0,0,21,19
	stw 0,776(31)
	b .L43
.L44:
	lis 9,level+4@ha
	lfs 13,832(31)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	li 0,4
	bc 4,1,.L45
	li 0,1
.L45:
	stw 0,780(31)
.L43:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe20:
	.size	 mutant_check_landing,.Lfe20-mutant_check_landing
	.align 2
	.globl mutant_jump
	.type	 mutant_jump,@function
mutant_jump:
	lis 9,mutant_move_jump@ha
	la 9,mutant_move_jump@l(9)
	stw 9,772(3)
	blr
.Lfe21:
	.size	 mutant_jump,.Lfe21-mutant_jump
	.align 2
	.globl mutant_check_melee
	.type	 mutant_check_melee,@function
mutant_check_melee:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 4,540(3)
	bl range
	subfic 0,3,0
	adde 3,0,3
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 mutant_check_melee,.Lfe22-mutant_check_melee
	.align 2
	.globl mutant_checkattack
	.type	 mutant_checkattack,@function
mutant_checkattack:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 4,540(31)
	cmpwi 0,4,0
	bc 12,2,.L96
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L96
	mr 3,31
	bl range
	cmpwi 0,3,0
	bc 4,2,.L61
	li 0,3
	b .L97
.L61:
	mr 3,31
	bl mutant_check_jump
	cmpwi 0,3,0
	bc 4,2,.L64
.L96:
	li 3,0
	b .L95
.L64:
	li 0,4
.L97:
	li 3,1
	stw 0,868(31)
.L95:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe23:
	.size	 mutant_checkattack,.Lfe23-mutant_checkattack
	.align 2
	.globl mutant_dead
	.type	 mutant_dead,@function
mutant_dead:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 6,0xc180
	lwz 0,184(29)
	lis 7,0x4180
	lis 9,0xc1c0
	lis 11,0xc100
	li 10,7
	stw 6,192(29)
	ori 0,0,2
	stw 9,196(29)
	lis 8,gi+72@ha
	stw 7,204(29)
	stw 11,208(29)
	stw 10,260(29)
	stw 0,184(29)
	stw 6,188(29)
	stw 7,200(29)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	mr 3,29
	bl M_FlyCheck
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 mutant_dead,.Lfe24-mutant_dead
	.section	".rodata"
	.align 2
.LC68:
	.long 0x46fffe00
	.align 2
.LC69:
	.long 0x3f800000
	.align 2
.LC70:
	.long 0x0
	.align 3
.LC71:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC72:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl mutant_die
	.type	 mutant_die,@function
mutant_die:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 30,3
	mr 28,6
	lwz 9,480(30)
	lwz 0,488(30)
	cmpw 0,9,0
	bc 12,1,.L76
	lis 29,gi@ha
	lis 3,.LC16@ha
	la 29,gi@l(29)
	la 3,.LC16@l(3)
	lwz 9,36(29)
	lis 27,.LC17@ha
	lis 26,.LC18@ha
	li 31,2
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC69@ha
	lis 10,.LC69@ha
	lis 11,.LC70@ha
	mr 5,3
	la 9,.LC69@l(9)
	la 10,.LC69@l(10)
	mtlr 0
	la 11,.LC70@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L80:
	mr 3,30
	la 4,.LC17@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L80
	li 31,4
.L85:
	mr 3,30
	la 4,.LC18@l(26)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L85
	lis 4,.LC19@ha
	mr 5,28
	la 4,.LC19@l(4)
	mr 3,30
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,492(30)
	b .L75
.L76:
	lwz 0,492(30)
	cmpwi 0,0,2
	bc 12,2,.L75
	lis 11,gi+16@ha
	lis 9,sound_death@ha
	lwz 0,gi+16@l(11)
	lis 10,.LC69@ha
	mr 3,30
	lwz 5,sound_death@l(9)
	lis 11,.LC70@ha
	la 10,.LC69@l(10)
	lis 9,.LC69@ha
	la 11,.LC70@l(11)
	lfs 2,0(10)
	mtlr 0
	la 9,.LC69@l(9)
	lfs 3,0(11)
	li 4,2
	lfs 1,0(9)
	blrl
	li 9,1
	li 0,2
	stw 0,492(30)
	stw 9,60(30)
	stw 9,512(30)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC71@ha
	lis 11,.LC68@ha
	la 10,.LC71@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC72@ha
	lfs 12,.LC68@l(11)
	la 10,.LC72@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L88
	lis 9,mutant_move_death1@ha
	la 9,mutant_move_death1@l(9)
	b .L98
.L88:
	lis 9,mutant_move_death2@ha
	la 9,mutant_move_death2@l(9)
.L98:
	stw 9,772(30)
.L75:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe25:
	.size	 mutant_die,.Lfe25-mutant_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
