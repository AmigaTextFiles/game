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
	.section	".rodata"
	.align 2
.LC1:
	.long 0x46fffe00
	.align 2
.LC2:
	.long 0x3f800000
	.align 2
.LC3:
	.long 0x0
	.align 3
.LC4:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC5:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl mutant_hit_left
	.type	 mutant_hit_left,@function
mutant_hit_left:
	stwu 1,-48(1)
	mflr 0
	stw 31,44(1)
	stw 0,52(1)
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
	lis 10,.LC2@ha
	mr 3,31
	lwz 5,sound_hit@l(11)
	lis 9,.LC2@ha
	la 10,.LC2@l(10)
	lis 11,.LC3@ha
	la 9,.LC2@l(9)
	mtlr 0
	lfs 2,0(10)
	la 11,.LC3@l(11)
	lfs 1,0(9)
	li 4,1
	lfs 3,0(11)
	blrl
	lwz 0,60(31)
	andi. 9,0,2
	bc 12,2,.L26
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,36(1)
	lis 10,.LC4@ha
	lis 11,.LC1@ha
	la 10,.LC4@l(10)
	stw 0,32(1)
	lfd 13,0(10)
	lfd 0,32(1)
	lis 10,.LC5@ha
	lfs 12,.LC1@l(11)
	la 10,.LC5@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L26
	lwz 3,540(31)
	mr 4,31
	addi 5,3,4
	bl PBM_Ignite
	b .L26
.L24:
	lis 9,gi+16@ha
	lis 11,sound_swing@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC2@ha
	mr 3,31
	lwz 5,sound_swing@l(11)
	lis 9,.LC2@ha
	la 10,.LC2@l(10)
	lis 11,.LC3@ha
	la 9,.LC2@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC3@l(11)
	li 4,1
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L26:
	lwz 0,52(1)
	mtlr 0
	lwz 31,44(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 mutant_hit_left,.Lfe1-mutant_hit_left
	.section	".rodata"
	.align 2
.LC6:
	.long 0x46fffe00
	.align 2
.LC7:
	.long 0x3f800000
	.align 2
.LC8:
	.long 0x0
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC10:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl mutant_hit_right
	.type	 mutant_hit_right,@function
mutant_hit_right:
	stwu 1,-48(1)
	mflr 0
	stw 31,44(1)
	stw 0,52(1)
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
	bc 12,2,.L28
	lis 9,gi+16@ha
	lis 11,sound_hit2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC7@ha
	mr 3,31
	lwz 5,sound_hit2@l(11)
	lis 9,.LC7@ha
	la 10,.LC7@l(10)
	lis 11,.LC8@ha
	la 9,.LC7@l(9)
	mtlr 0
	lfs 2,0(10)
	la 11,.LC8@l(11)
	lfs 1,0(9)
	li 4,1
	lfs 3,0(11)
	blrl
	lwz 0,60(31)
	andi. 9,0,2
	bc 12,2,.L30
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,36(1)
	lis 10,.LC9@ha
	lis 11,.LC6@ha
	la 10,.LC9@l(10)
	stw 0,32(1)
	lfd 13,0(10)
	lfd 0,32(1)
	lis 10,.LC10@ha
	lfs 12,.LC6@l(11)
	la 10,.LC10@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L30
	lwz 3,540(31)
	mr 4,31
	addi 5,3,4
	bl PBM_Ignite
	b .L30
.L28:
	lis 9,gi+16@ha
	lis 11,sound_swing@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC7@ha
	mr 3,31
	lwz 5,sound_swing@l(11)
	lis 9,.LC7@ha
	la 10,.LC7@l(10)
	lis 11,.LC8@ha
	la 9,.LC7@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC8@l(11)
	li 4,1
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L30:
	lwz 0,52(1)
	mtlr 0
	lwz 31,44(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 mutant_hit_right,.Lfe2-mutant_hit_right
	.globl mutant_frames_attack
	.section	".data"
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
	.globl mutant_frames_attack_demon
	.align 2
	.type	 mutant_frames_attack_demon,@object
mutant_frames_attack_demon:
	.long ai_charge
	.long 0x0
	.long mutant_init_demonattack
	.long ai_charge
	.long 0x0
	.long mutant_finish_demonattack
	.long ai_charge
	.long 0x0
	.long 0
	.size	 mutant_frames_attack_demon,36
	.globl mutant_move_attack_demon
	.align 2
	.type	 mutant_move_attack_demon,@object
	.size	 mutant_move_attack_demon,16
mutant_move_attack_demon:
	.long 62
	.long 64
	.long mutant_frames_attack_demon
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
.LC14:
	.long 0x46fffe00
	.align 3
.LC15:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 3
.LC16:
	.long 0x3fe80000
	.long 0x0
	.align 3
.LC17:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC18:
	.long 0x42c80000
	.align 3
.LC19:
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
	lis 10,.LC16@ha
	lwz 11,540(9)
	la 10,.LC16@l(10)
	lfd 13,0(10)
	lfs 12,220(11)
	lfs 11,244(11)
	lfs 0,220(9)
	fmadd 13,11,13,12
	fcmpu 0,0,13
	bc 12,1,.L63
	lis 10,.LC17@ha
	lfs 13,232(9)
	la 10,.LC17@l(10)
	lfd 0,0(10)
	fmadd 0,11,0,12
	fcmpu 0,13,0
	bc 12,0,.L63
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
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L59
.L63:
	li 3,0
	b .L62
.L59:
	bc 4,1,.L60
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC19@ha
	lis 11,.LC15@ha
	la 10,.LC19@l(10)
	stw 0,24(1)
	li 3,0
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC14@ha
	lfs 11,.LC14@l(10)
	lfd 12,.LC15@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 12,0,.L62
.L60:
	li 3,1
.L62:
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe3:
	.size	 mutant_check_jump,.Lfe3-mutant_check_jump
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
.LC20:
	.long 0x46fffe00
	.align 3
.LC21:
	.long 0x3fd51eb8
	.long 0x51eb851f
	.align 3
.LC22:
	.long 0x3fe51eb8
	.long 0x51eb851f
	.align 2
.LC23:
	.long 0x40400000
	.align 3
.LC24:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC25:
	.long 0x3f800000
	.align 2
.LC26:
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
	bc 4,0,.L72
	lwz 0,60(31)
	cmpwi 0,0,0
	bc 4,2,.L72
	li 0,1
	stw 0,60(31)
.L72:
	lis 9,level+4@ha
	lfs 0,464(31)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L71
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 12,0(9)
	lis 9,skill@ha
	lwz 11,skill@l(9)
	fadds 13,13,12
	stfs 13,464(31)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L71
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC24@ha
	lis 10,.LC20@ha
	la 11,.LC24@l(11)
	stw 0,16(1)
	lfd 12,0(11)
	lfd 0,16(1)
	lis 11,.LC21@ha
	lfs 11,.LC20@l(10)
	lfd 13,.LC21@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,11
	fmr 12,0
	fcmpu 0,12,13
	bc 4,0,.L75
	lis 9,gi+16@ha
	lis 11,sound_pain1@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC25@ha
	lwz 5,sound_pain1@l(11)
	la 9,.LC25@l(9)
	lis 11,.LC25@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC25@l(11)
	lis 9,.LC26@ha
	lfs 2,0(11)
	la 9,.LC26@l(9)
	lfs 3,0(9)
	blrl
	lis 9,mutant_move_pain1@ha
	la 9,mutant_move_pain1@l(9)
	b .L79
.L75:
	lis 9,.LC22@ha
	lfd 0,.LC22@l(9)
	fcmpu 0,12,0
	bc 4,0,.L77
	lis 9,gi+16@ha
	lis 11,sound_pain2@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC25@ha
	lwz 5,sound_pain2@l(11)
	la 9,.LC25@l(9)
	lis 11,.LC25@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC25@l(11)
	lis 9,.LC26@ha
	lfs 2,0(11)
	la 9,.LC26@l(9)
	lfs 3,0(9)
	blrl
	lis 9,mutant_move_pain2@ha
	la 9,mutant_move_pain2@l(9)
	b .L79
.L77:
	lis 9,gi+16@ha
	lis 11,sound_pain1@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC25@ha
	lwz 5,sound_pain1@l(11)
	la 9,.LC25@l(9)
	lis 11,.LC25@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC25@l(11)
	lis 9,.LC26@ha
	lfs 2,0(11)
	la 9,.LC26@l(9)
	lfs 3,0(9)
	blrl
	lis 9,mutant_move_pain3@ha
	la 9,mutant_move_pain3@l(9)
.L79:
	stw 9,772(31)
.L71:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 mutant_pain,.Lfe4-mutant_pain
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
.LC27:
	.string	"misc/udeath.wav"
	.align 2
.LC28:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC29:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC30:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC31:
	.long 0x46fffe00
	.align 2
.LC32:
	.long 0x3f800000
	.align 2
.LC33:
	.long 0x0
	.align 3
.LC34:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC35:
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
	bc 12,1,.L82
	lis 29,gi@ha
	lis 3,.LC27@ha
	la 29,gi@l(29)
	la 3,.LC27@l(3)
	lwz 9,36(29)
	lis 27,.LC28@ha
	lis 26,.LC29@ha
	li 31,2
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC32@ha
	lis 10,.LC32@ha
	lis 11,.LC33@ha
	mr 5,3
	la 9,.LC32@l(9)
	la 10,.LC32@l(10)
	mtlr 0
	la 11,.LC33@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L86:
	mr 3,30
	la 4,.LC28@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L86
	li 31,4
.L91:
	mr 3,30
	la 4,.LC29@l(26)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L91
	lis 4,.LC30@ha
	mr 5,28
	la 4,.LC30@l(4)
	mr 3,30
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,492(30)
	b .L81
.L82:
	lwz 0,492(30)
	cmpwi 0,0,2
	bc 12,2,.L81
	lis 9,gi+16@ha
	lis 11,sound_death@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC32@ha
	mr 3,30
	lwz 5,sound_death@l(11)
	lis 9,.LC32@ha
	la 10,.LC32@l(10)
	lis 11,.LC33@ha
	la 9,.LC32@l(9)
	mtlr 0
	lfs 2,0(10)
	la 11,.LC33@l(11)
	lfs 1,0(9)
	li 4,2
	lfs 3,0(11)
	blrl
	lwz 9,60(30)
	li 11,1
	li 0,2
	stw 0,492(30)
	cmpwi 0,9,0
	stw 11,512(30)
	bc 4,2,.L94
	stw 11,60(30)
.L94:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC34@ha
	lis 11,.LC31@ha
	la 10,.LC34@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC35@ha
	lfs 12,.LC31@l(11)
	la 10,.LC35@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L95
	lis 9,mutant_move_death1@ha
	la 9,mutant_move_death1@l(9)
	b .L97
.L95:
	lis 9,mutant_move_death2@ha
	la 9,mutant_move_death2@l(9)
.L97:
	stw 9,772(30)
.L81:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 mutant_die,.Lfe5-mutant_die
	.globl mutant_frames_jump_up
	.section	".data"
	.align 2
	.type	 mutant_frames_jump_up,@object
mutant_frames_jump_up:
	.long ai_move
	.long 0xc1000000
	.long 0
	.long ai_move
	.long 0xc1000000
	.long mutant_jump_up
	.long ai_move
	.long 0x0
	.long mutant_jump_wait_land
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 mutant_frames_jump_up,60
	.globl mutant_move_jump_up
	.align 2
	.type	 mutant_move_jump_up,@object
	.size	 mutant_move_jump_up,16
mutant_move_jump_up:
	.long 56
	.long 60
	.long mutant_frames_jump_up
	.long mutant_run
	.globl mutant_frames_jump_down
	.align 2
	.type	 mutant_frames_jump_down,@object
mutant_frames_jump_down:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long mutant_jump_down
	.long ai_move
	.long 0x0
	.long mutant_jump_wait_land
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 mutant_frames_jump_down,60
	.globl mutant_move_jump_down
	.align 2
	.type	 mutant_move_jump_down,@object
	.size	 mutant_move_jump_down,16
mutant_move_jump_down:
	.long 56
	.long 60
	.long mutant_frames_jump_down
	.long mutant_run
	.section	".rodata"
	.align 2
.LC36:
	.string	"mutant/mutatck1.wav"
	.align 2
.LC37:
	.string	"mutant/mutatck2.wav"
	.align 2
.LC38:
	.string	"mutant/mutatck3.wav"
	.align 2
.LC39:
	.string	"mutant/mutdeth1.wav"
	.align 2
.LC40:
	.string	"mutant/mutidle1.wav"
	.align 2
.LC41:
	.string	"mutant/mutpain1.wav"
	.align 2
.LC42:
	.string	"mutant/mutpain2.wav"
	.align 2
.LC43:
	.string	"mutant/mutsght1.wav"
	.align 2
.LC44:
	.string	"mutant/mutsrch1.wav"
	.align 2
.LC45:
	.string	"mutant/step1.wav"
	.align 2
.LC46:
	.string	"mutant/step2.wav"
	.align 2
.LC47:
	.string	"mutant/step3.wav"
	.align 2
.LC48:
	.string	"mutant/thud1.wav"
	.align 2
.LC49:
	.string	"models/monsters/mutant/tris.md2"
	.align 2
.LC50:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_mutant_normal
	.type	 SP_monster_mutant_normal,@function
SP_monster_mutant_normal:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 11,.LC50@ha
	lis 9,deathmatch@ha
	la 11,.LC50@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L115
	bl G_FreeEdict
	b .L114
.L115:
	lis 29,gi@ha
	lis 3,.LC36@ha
	la 29,gi@l(29)
	la 3,.LC36@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_swing@ha
	lis 11,.LC37@ha
	stw 3,sound_swing@l(9)
	mtlr 10
	la 3,.LC37@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_hit@ha
	lis 11,.LC38@ha
	stw 3,sound_hit@l(9)
	mtlr 10
	la 3,.LC38@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_hit2@ha
	lis 11,.LC39@ha
	stw 3,sound_hit2@l(9)
	mtlr 10
	la 3,.LC39@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_death@ha
	lis 11,.LC40@ha
	stw 3,sound_death@l(9)
	mtlr 10
	la 3,.LC40@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_idle@ha
	lis 11,.LC41@ha
	stw 3,sound_idle@l(9)
	mtlr 10
	la 3,.LC41@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain1@ha
	lis 11,.LC42@ha
	stw 3,sound_pain1@l(9)
	mtlr 10
	la 3,.LC42@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain2@ha
	lis 11,.LC43@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC43@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sight@ha
	lis 11,.LC44@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC44@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_search@ha
	lis 11,.LC45@ha
	stw 3,sound_search@l(9)
	mtlr 10
	la 3,.LC45@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_step1@ha
	lis 11,.LC46@ha
	stw 3,sound_step1@l(9)
	mtlr 10
	la 3,.LC46@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_step2@ha
	lis 11,.LC47@ha
	stw 3,sound_step2@l(9)
	mtlr 10
	la 3,.LC47@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_step3@ha
	lis 11,.LC48@ha
	stw 3,sound_step3@l(9)
	mtlr 10
	la 3,.LC48@l(11)
	blrl
	lis 9,sound_thud@ha
	li 0,5
	stw 3,sound_thud@l(9)
	li 11,2
	stw 0,260(31)
	lis 3,.LC49@ha
	stw 11,248(31)
	la 3,.LC49@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,mutant_pain@ha
	lis 11,mutant_die@ha
	stw 3,40(31)
	lis 10,mutant_stand@ha
	lis 8,mutant_walk@ha
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
	lis 25,mutant_blocked@ha
	lis 7,0x4200
	li 8,300
	la 6,mutant_jump@l(6)
	stw 7,204(31)
	la 5,mutant_melee@l(5)
	la 4,mutant_sight@l(4)
	stw 6,812(31)
	lis 9,0x4240
	li 11,-120
	stw 8,400(31)
	li 10,0
	la 28,mutant_search@l(28)
	stw 9,208(31)
	la 27,mutant_idle@l(27)
	la 26,mutant_checkattack@l(26)
	stw 11,488(31)
	la 25,mutant_blocked@l(25)
	lis 24,0xc200
	stw 10,808(31)
	lis 0,0xc1c0
	stw 5,816(31)
	mr 3,31
	stw 4,820(31)
	stw 7,200(31)
	stw 8,480(31)
	stw 24,192(31)
	stw 0,196(31)
	stw 28,796(31)
	stw 27,792(31)
	stw 26,824(31)
	stw 25,892(31)
	stw 24,188(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lis 9,mutant_move_stand@ha
	lis 11,SP_monster_mutant_normal@ha
	lis 0,0x3f80
	la 9,mutant_move_stand@l(9)
	la 11,SP_monster_mutant_normal@l(11)
	stw 0,784(31)
	mr 3,31
	stw 9,772(31)
	stw 11,992(31)
	bl walkmonster_start
	lwz 0,1136(31)
	ori 0,0,792
	stw 0,1136(31)
.L114:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 SP_monster_mutant_normal,.Lfe6-SP_monster_mutant_normal
	.section	".rodata"
	.align 2
.LC51:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_mutant_demon
	.type	 SP_monster_mutant_demon,@function
SP_monster_mutant_demon:
	stwu 1,-48(1)
	mflr 0
	stmw 22,8(1)
	stw 0,52(1)
	lis 11,.LC51@ha
	lis 9,deathmatch@ha
	la 11,.LC51@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L117
	bl G_FreeEdict
	b .L116
.L117:
	lis 29,gi@ha
	lis 3,.LC36@ha
	la 29,gi@l(29)
	la 3,.LC36@l(3)
	lwz 9,36(29)
	li 22,2
	li 23,0
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_swing@ha
	lis 11,.LC37@ha
	stw 3,sound_swing@l(9)
	mtlr 10
	la 3,.LC37@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_hit@ha
	lis 11,.LC38@ha
	stw 3,sound_hit@l(9)
	mtlr 10
	la 3,.LC38@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_hit2@ha
	lis 11,.LC39@ha
	stw 3,sound_hit2@l(9)
	mtlr 10
	la 3,.LC39@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_death@ha
	lis 11,.LC40@ha
	stw 3,sound_death@l(9)
	mtlr 10
	la 3,.LC40@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_idle@ha
	lis 11,.LC41@ha
	stw 3,sound_idle@l(9)
	mtlr 10
	la 3,.LC41@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain1@ha
	lis 11,.LC42@ha
	stw 3,sound_pain1@l(9)
	mtlr 10
	la 3,.LC42@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain2@ha
	lis 11,.LC43@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC43@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sight@ha
	lis 11,.LC44@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC44@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_search@ha
	lis 11,.LC45@ha
	stw 3,sound_search@l(9)
	mtlr 10
	la 3,.LC45@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_step1@ha
	lis 11,.LC46@ha
	stw 3,sound_step1@l(9)
	mtlr 10
	la 3,.LC46@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_step2@ha
	lis 11,.LC47@ha
	stw 3,sound_step2@l(9)
	mtlr 10
	la 3,.LC47@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_step3@ha
	lis 11,.LC48@ha
	stw 3,sound_step3@l(9)
	mtlr 10
	la 3,.LC48@l(11)
	blrl
	lis 9,sound_thud@ha
	li 0,5
	stw 3,sound_thud@l(9)
	stw 0,260(31)
	lis 3,.LC49@ha
	stw 22,248(31)
	la 3,.LC49@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,mutant_pain@ha
	lis 11,mutant_die@ha
	stw 3,40(31)
	lis 10,mutant_stand@ha
	lis 8,mutant_walk@ha
	stw 23,808(31)
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
	lis 25,mutant_blocked@ha
	lis 7,0x4200
	la 6,mutant_jump@l(6)
	la 5,mutant_melee@l(5)
	stw 7,204(31)
	la 4,mutant_sight@l(4)
	lis 8,0x4240
	stw 6,812(31)
	li 11,600
	li 10,-1
	stw 8,208(31)
	li 9,400
	la 28,mutant_search@l(28)
	stw 11,480(31)
	la 27,mutant_idle@l(27)
	la 26,mutant_checkattack@l(26)
	stw 10,488(31)
	la 25,mutant_blocked@l(25)
	lis 24,0xc200
	stw 9,400(31)
	lis 0,0xc1c0
	stw 5,816(31)
	mr 3,31
	stw 4,820(31)
	stw 7,200(31)
	stw 24,192(31)
	stw 0,196(31)
	stw 28,796(31)
	stw 27,792(31)
	stw 26,824(31)
	stw 25,892(31)
	stw 24,188(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lis 9,mutant_move_stand@ha
	lis 11,SP_monster_mutant_demon@ha
	la 9,mutant_move_stand@l(9)
	la 11,SP_monster_mutant_demon@l(11)
	lis 0,0x3f80
	stw 9,772(31)
	mr 3,31
	stw 0,784(31)
	stw 11,992(31)
	bl walkmonster_start
	stw 23,1136(31)
	stw 22,60(31)
.L116:
	lwz 0,52(1)
	mtlr 0
	lmw 22,8(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 SP_monster_mutant_demon,.Lfe7-SP_monster_mutant_demon
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
.LC54:
	.long 0x3f800000
	.align 2
.LC55:
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
	lis 9,.LC54@ha
	lwz 5,sound_step1@l(11)
	b .L121
.L7:
	cmpwi 0,9,1
	bc 4,2,.L9
	lis 9,gi+16@ha
	lis 11,sound_step2@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC54@ha
	lwz 5,sound_step2@l(11)
.L121:
	la 9,.LC54@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC54@ha
	la 9,.LC54@l(9)
	lfs 2,0(9)
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 3,0(9)
	blrl
	b .L8
.L9:
	lis 9,gi+16@ha
	lis 11,sound_step3@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC54@ha
	lwz 5,sound_step3@l(11)
	la 9,.LC54@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC54@ha
	la 9,.LC54@l(9)
	lfs 2,0(9)
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 3,0(9)
	blrl
.L8:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 mutant_step,.Lfe8-mutant_step
	.section	".rodata"
	.align 2
.LC56:
	.long 0x3f800000
	.align 2
.LC57:
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
	lis 9,.LC56@ha
	lwz 5,sound_sight@l(11)
	la 9,.LC56@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 2,0(9)
	lis 9,.LC57@ha
	la 9,.LC57@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 mutant_sight,.Lfe9-mutant_sight
	.section	".rodata"
	.align 2
.LC58:
	.long 0x3f800000
	.align 2
.LC59:
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
	lis 9,.LC58@ha
	lwz 5,sound_search@l(11)
	la 9,.LC58@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC58@ha
	la 9,.LC58@l(9)
	lfs 2,0(9)
	lis 9,.LC59@ha
	la 9,.LC59@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 mutant_search,.Lfe10-mutant_search
	.section	".rodata"
	.align 2
.LC60:
	.long 0x3f800000
	.align 2
.LC61:
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
	lis 9,.LC60@ha
	lwz 5,sound_swing@l(11)
	la 9,.LC60@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC60@ha
	la 9,.LC60@l(9)
	lfs 2,0(9)
	lis 9,.LC61@ha
	la 9,.LC61@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 mutant_swing,.Lfe11-mutant_swing
	.align 2
	.globl mutant_stand
	.type	 mutant_stand,@function
mutant_stand:
	lis 9,mutant_move_stand@ha
	la 9,mutant_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe12:
	.size	 mutant_stand,.Lfe12-mutant_stand
	.section	".rodata"
	.align 2
.LC62:
	.long 0x46fffe00
	.align 3
.LC63:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC64:
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
	lis 10,.LC63@ha
	lis 11,.LC62@ha
	la 10,.LC63@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC64@ha
	lfs 12,.LC62@l(11)
	la 10,.LC64@l(10)
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
.Lfe13:
	.size	 mutant_idle_loop,.Lfe13-mutant_idle_loop
	.section	".rodata"
	.align 2
.LC65:
	.long 0x3f800000
	.align 2
.LC66:
	.long 0x40000000
	.align 2
.LC67:
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
	lis 9,.LC65@ha
	lwz 0,gi+16@l(11)
	la 9,.LC65@l(9)
	lwz 5,sound_idle@l(10)
	lfs 1,0(9)
	mtlr 0
	lis 9,.LC66@ha
	la 9,.LC66@l(9)
	lfs 2,0(9)
	lis 9,.LC67@ha
	la 9,.LC67@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 mutant_idle,.Lfe14-mutant_idle
	.align 2
	.globl mutant_walk
	.type	 mutant_walk,@function
mutant_walk:
	lis 9,mutant_move_start_walk@ha
	la 9,mutant_move_start_walk@l(9)
	stw 9,772(3)
	blr
.Lfe15:
	.size	 mutant_walk,.Lfe15-mutant_walk
	.align 2
	.globl mutant_walk_loop
	.type	 mutant_walk_loop,@function
mutant_walk_loop:
	lis 9,mutant_move_walk@ha
	la 9,mutant_move_walk@l(9)
	stw 9,772(3)
	blr
.Lfe16:
	.size	 mutant_walk_loop,.Lfe16-mutant_walk_loop
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
.Lfe17:
	.size	 mutant_run,.Lfe17-mutant_run
	.section	".rodata"
	.align 2
.LC68:
	.long 0x46fffe00
	.align 2
.LC69:
	.long 0x40400000
	.align 3
.LC70:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC71:
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
	bc 12,2,.L31
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L31
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L31
	lis 9,.LC69@ha
	lis 11,skill@ha
	la 9,.LC69@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L36
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC70@ha
	lis 11,.LC68@ha
	la 10,.LC70@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC71@ha
	lfs 12,.LC68@l(11)
	la 10,.LC71@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L35
.L36:
	lwz 4,540(31)
	mr 3,31
	bl range
	cmpwi 0,3,0
	bc 4,2,.L31
.L35:
	li 0,8
	stw 0,780(31)
.L31:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 mutant_check_refire,.Lfe18-mutant_check_refire
	.align 2
	.globl mutant_finish_demonattack
	.type	 mutant_finish_demonattack,@function
mutant_finish_demonattack:
	li 0,5
	stw 0,260(3)
	blr
.Lfe19:
	.size	 mutant_finish_demonattack,.Lfe19-mutant_finish_demonattack
	.section	".rodata"
	.align 2
.LC72:
	.long 0x0
	.align 2
.LC73:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl mutant_init_demonattack
	.type	 mutant_init_demonattack,@function
mutant_init_demonattack:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,.LC72@ha
	mr 29,3
	la 9,.LC72@l(9)
	lfs 1,0(9)
	mr 4,29
	addi 5,29,4
	bl MakePositron
	li 0,0
	lis 11,.LC73@ha
	lis 9,level+4@ha
	stw 0,260(29)
	la 11,.LC73@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 mutant_init_demonattack,.Lfe20-mutant_init_demonattack
	.section	".rodata"
	.align 2
.LC74:
	.long 0x46fffe00
	.align 3
.LC75:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC76:
	.long 0x3fd00000
	.long 0x0
	.section	".text"
	.align 2
	.globl mutant_melee
	.type	 mutant_melee,@function
mutant_melee:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,60(31)
	cmpwi 0,0,1
	bc 4,1,.L40
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC75@ha
	lis 11,.LC74@ha
	la 10,.LC75@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC76@ha
	lfs 12,.LC74@l(11)
	la 10,.LC76@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L40
	lis 9,mutant_move_attack_demon@ha
	la 9,mutant_move_attack_demon@l(9)
	b .L122
.L40:
	lis 9,mutant_move_attack@ha
	la 9,mutant_move_attack@l(9)
.L122:
	stw 9,772(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 mutant_melee,.Lfe21-mutant_melee
	.section	".rodata"
	.align 2
.LC77:
	.long 0x46fffe00
	.align 2
.LC78:
	.long 0x43c80000
	.align 3
.LC79:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC80:
	.long 0x41200000
	.align 2
.LC81:
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
	bc 4,1,.L46
	lwz 0,512(28)
	cmpwi 0,0,0
	bc 12,2,.L44
	addi 30,31,376
	mr 3,30
	bl VectorLength
	lis 9,.LC78@ha
	la 9,.LC78@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,1,.L44
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
	lis 10,.LC79@ha
	lis 11,.LC77@ha
	stw 0,56(1)
	la 10,.LC79@l(10)
	mr 3,28
	lfd 0,0(10)
	li 0,0
	mr 6,30
	lfd 13,56(1)
	lis 10,.LC80@ha
	mr 8,29
	lfs 11,.LC77@l(11)
	la 10,.LC80@l(10)
	mr 4,31
	lfs 9,0(10)
	mr 5,31
	addi 7,1,16
	fsub 13,13,0
	lis 10,.LC81@ha
	stw 0,12(1)
	la 10,.LC81@l(10)
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
.L44:
	mr 3,31
	bl M_CheckBottom
	mr. 3,3
	bc 4,2,.L46
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L42
	li 0,1
	stw 3,444(31)
	stw 0,780(31)
	b .L42
.L46:
	li 0,0
	stw 0,444(31)
.L42:
	lwz 0,84(1)
	mtlr 0
	lmw 28,64(1)
	la 1,80(1)
	blr
.Lfe22:
	.size	 mutant_jump_touch,.Lfe22-mutant_jump_touch
	.section	".rodata"
	.align 2
.LC82:
	.long 0x3f800000
	.align 2
.LC83:
	.long 0x0
	.align 2
.LC84:
	.long 0x44160000
	.align 2
.LC85:
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
	lis 9,.LC82@ha
	lwz 5,sound_sight@l(11)
	li 4,2
	la 9,.LC82@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC82@ha
	la 9,.LC82@l(9)
	lfs 2,0(9)
	lis 9,.LC83@ha
	la 9,.LC83@l(9)
	lfs 3,0(9)
	blrl
	addi 4,1,8
	li 6,0
	addi 3,29,16
	li 5,0
	bl AngleVectors
	lis 9,.LC82@ha
	lfs 0,12(29)
	addi 3,1,8
	la 9,.LC82@l(9)
	addi 4,29,376
	lfs 13,0(9)
	lis 9,.LC84@ha
	la 9,.LC84@l(9)
	fadds 0,0,13
	lfs 1,0(9)
	stfs 0,12(29)
	bl VectorScale
	lwz 11,776(29)
	lis 0,0x437a
	li 10,0
	lis 9,.LC85@ha
	stw 0,384(29)
	lis 8,level+4@ha
	ori 11,11,2048
	la 9,.LC85@l(9)
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
.Lfe23:
	.size	 mutant_jump_takeoff,.Lfe23-mutant_jump_takeoff
	.section	".rodata"
	.align 2
.LC86:
	.long 0x3f800000
	.align 2
.LC87:
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
	bc 12,2,.L50
	lis 9,gi+16@ha
	lis 11,sound_thud@ha
	lwz 0,gi+16@l(9)
	li 4,1
	lis 9,.LC86@ha
	lwz 5,sound_thud@l(11)
	la 9,.LC86@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC86@ha
	la 9,.LC86@l(9)
	lfs 2,0(9)
	lis 9,.LC87@ha
	la 9,.LC87@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,776(31)
	li 9,0
	stw 9,832(31)
	rlwinm 0,0,0,21,19
	stw 0,776(31)
	b .L49
.L50:
	lis 9,level+4@ha
	lfs 13,832(31)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	li 0,4
	bc 4,1,.L51
	li 0,1
.L51:
	stw 0,780(31)
.L49:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe24:
	.size	 mutant_check_landing,.Lfe24-mutant_check_landing
	.align 2
	.globl mutant_jump
	.type	 mutant_jump,@function
mutant_jump:
	lis 9,mutant_move_jump@ha
	la 9,mutant_move_jump@l(9)
	stw 9,772(3)
	blr
.Lfe25:
	.size	 mutant_jump,.Lfe25-mutant_jump
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
.Lfe26:
	.size	 mutant_check_melee,.Lfe26-mutant_check_melee
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
	bc 12,2,.L126
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L126
	mr 3,31
	bl range
	cmpwi 0,3,0
	bc 4,2,.L67
	li 0,3
	b .L127
.L67:
	mr 3,31
	bl mutant_check_jump
	cmpwi 0,3,0
	bc 4,2,.L70
.L126:
	li 3,0
	b .L125
.L70:
	li 0,4
.L127:
	li 3,1
	stw 0,868(31)
.L125:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe27:
	.size	 mutant_checkattack,.Lfe27-mutant_checkattack
	.align 2
	.globl mutant_dead
	.type	 mutant_dead,@function
mutant_dead:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 7,0xc180
	lwz 0,184(29)
	lis 8,0x4180
	lis 9,0xc1c0
	lis 11,0xc100
	li 10,7
	stw 9,196(29)
	ori 0,0,2
	stw 7,192(29)
	stw 0,184(29)
	stw 8,204(29)
	stw 11,208(29)
	stw 10,260(29)
	stw 7,188(29)
	stw 8,200(29)
	bl SetMonsterRespawn
	lis 9,gi+72@ha
	mr 3,29
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe28:
	.size	 mutant_dead,.Lfe28-mutant_dead
	.section	".rodata"
	.align 2
.LC88:
	.long 0x42c80000
	.align 2
.LC89:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl mutant_jump_down
	.type	 mutant_jump_down,@function
mutant_jump_down:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	addi 28,1,24
	mr 29,3
	addi 3,29,16
	addi 4,1,8
	mr 6,28
	li 5,0
	bl AngleVectors
	addi 29,29,376
	lis 9,.LC88@ha
	mr 3,29
	la 9,.LC88@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,29
	bl VectorMA
	lis 9,.LC89@ha
	mr 3,29
	la 9,.LC89@l(9)
	mr 4,28
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe29:
	.size	 mutant_jump_down,.Lfe29-mutant_jump_down
	.section	".rodata"
	.align 2
.LC90:
	.long 0x43480000
	.align 2
.LC91:
	.long 0x43e10000
	.section	".text"
	.align 2
	.globl mutant_jump_up
	.type	 mutant_jump_up,@function
mutant_jump_up:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	addi 28,1,24
	mr 29,3
	addi 3,29,16
	addi 4,1,8
	mr 6,28
	li 5,0
	bl AngleVectors
	addi 29,29,376
	lis 9,.LC90@ha
	mr 3,29
	la 9,.LC90@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,29
	bl VectorMA
	lis 9,.LC91@ha
	mr 3,29
	la 9,.LC91@l(9)
	mr 4,28
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe30:
	.size	 mutant_jump_up,.Lfe30-mutant_jump_up
	.align 2
	.globl mutant_jump_wait_land
	.type	 mutant_jump_wait_land,@function
mutant_jump_wait_land:
	lwz 0,552(3)
	cmpwi 0,0,0
	bc 4,2,.L101
	lwz 0,56(3)
	stw 0,780(3)
	blr
.L101:
	lwz 9,56(3)
	addi 9,9,1
	stw 9,780(3)
	blr
.Lfe31:
	.size	 mutant_jump_wait_land,.Lfe31-mutant_jump_wait_land
	.align 2
	.globl mutant_jump_updown
	.type	 mutant_jump_updown,@function
mutant_jump_updown:
	lwz 9,540(3)
	cmpwi 0,9,0
	bclr 12,2
	lfs 13,12(9)
	lfs 0,12(3)
	fcmpu 0,13,0
	bc 4,1,.L105
	lis 9,mutant_move_jump_up@ha
	la 9,mutant_move_jump_up@l(9)
	stw 9,772(3)
	blr
.L105:
	lis 9,mutant_move_jump_down@ha
	la 9,mutant_move_jump_down@l(9)
	stw 9,772(3)
	blr
.Lfe32:
	.size	 mutant_jump_updown,.Lfe32-mutant_jump_updown
	.section	".rodata"
	.align 2
.LC92:
	.long 0x43800000
	.align 2
.LC93:
	.long 0x42880000
	.section	".text"
	.align 2
	.globl mutant_blocked
	.type	 mutant_blocked,@function
mutant_blocked:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 31,20(1)
	stw 0,36(1)
	lis 9,.LC92@ha
	fmr 31,1
	mr 31,3
	la 9,.LC92@l(9)
	lfs 2,0(9)
	lis 9,.LC93@ha
	la 9,.LC93@l(9)
	lfs 3,0(9)
	bl blocked_checkjump
	cmpwi 0,3,0
	bc 12,2,.L108
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L110
	lfs 13,12(9)
	lfs 0,12(31)
	fcmpu 0,13,0
	bc 4,1,.L111
	lis 9,mutant_move_jump_up@ha
	la 9,mutant_move_jump_up@l(9)
	b .L129
.L111:
	lis 9,mutant_move_jump_down@ha
	la 9,mutant_move_jump_down@l(9)
.L129:
	stw 9,772(31)
.L110:
	li 3,1
	b .L107
.L108:
	fmr 1,31
	mr 3,31
	bl blocked_checkplat
	cmpwi 0,3,0
	bc 12,2,.L107
	li 3,1
.L107:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 mutant_blocked,.Lfe33-mutant_blocked
	.section	".rodata"
	.align 2
.LC94:
	.long 0x46fffe00
	.align 3
.LC95:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC96:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_monster_mutant
	.type	 SP_monster_mutant,@function
SP_monster_mutant:
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
	lis 11,.LC96@ha
	lis 10,.LC94@ha
	la 11,.LC96@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC95@ha
	lfs 11,.LC94@l(10)
	lfd 12,.LC95@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L119
	mr 3,31
	bl SP_monster_mutant_normal
	b .L120
.L119:
	mr 3,31
	bl SP_monster_mutant_demon
.L120:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 SP_monster_mutant,.Lfe34-SP_monster_mutant
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
