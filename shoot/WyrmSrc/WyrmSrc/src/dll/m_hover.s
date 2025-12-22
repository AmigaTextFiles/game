	.file	"m_hover.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x46fffe00
	.align 3
.LC1:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC2:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC3:
	.long 0x3f800000
	.align 2
.LC4:
	.long 0x0
	.section	".text"
	.align 2
	.globl hover_search
	.type	 hover_search,@function
hover_search:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,400(31)
	cmpwi 0,0,224
	bc 12,1,.L10
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC1@ha
	lis 11,.LC0@ha
	la 10,.LC1@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC2@ha
	lfs 12,.LC0@l(11)
	la 10,.LC2@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L11
	lis 9,gi+16@ha
	lis 11,sound_search1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC4@ha
	mr 3,31
	lwz 5,sound_search1@l(11)
	b .L16
.L11:
	lis 9,gi+16@ha
	lis 11,sound_search2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC3@ha
	mr 3,31
	lwz 5,sound_search2@l(11)
	lis 9,.LC3@ha
	la 10,.LC3@l(10)
	lis 11,.LC4@ha
	la 9,.LC3@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC4@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
	b .L13
.L10:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC1@ha
	lis 11,.LC0@ha
	la 10,.LC1@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC2@ha
	lfs 12,.LC0@l(11)
	la 10,.LC2@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L14
	lis 9,gi+16@ha
	lis 11,daed_sound_search1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC4@ha
	mr 3,31
	lwz 5,daed_sound_search1@l(11)
.L16:
	lis 9,.LC3@ha
	la 10,.LC4@l(10)
	lis 11,.LC3@ha
	la 9,.LC3@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC3@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L13
.L14:
	lis 9,gi+16@ha
	lis 11,daed_sound_search2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC3@ha
	mr 3,31
	lwz 5,daed_sound_search2@l(11)
	lis 9,.LC3@ha
	la 10,.LC3@l(10)
	lis 11,.LC4@ha
	la 9,.LC3@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC4@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L13:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 hover_search,.Lfe1-hover_search
	.globl hover_frames_stand
	.section	".data"
	.align 2
	.type	 hover_frames_stand,@object
hover_frames_stand:
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
	.size	 hover_frames_stand,360
	.globl hover_move_stand
	.align 2
	.type	 hover_move_stand,@object
	.size	 hover_move_stand,16
hover_move_stand:
	.long 0
	.long 29
	.long hover_frames_stand
	.long 0
	.globl hover_frames_pain3
	.align 2
	.type	 hover_frames_pain3,@object
hover_frames_pain3:
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
	.size	 hover_frames_pain3,108
	.globl hover_move_pain3
	.align 2
	.type	 hover_move_pain3,@object
	.size	 hover_move_pain3,16
hover_move_pain3:
	.long 153
	.long 161
	.long hover_frames_pain3
	.long hover_run
	.globl hover_frames_pain2
	.align 2
	.type	 hover_frames_pain2,@object
hover_frames_pain2:
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
	.size	 hover_frames_pain2,144
	.globl hover_move_pain2
	.align 2
	.type	 hover_move_pain2,@object
	.size	 hover_move_pain2,16
hover_move_pain2:
	.long 141
	.long 152
	.long hover_frames_pain2
	.long hover_run
	.globl hover_frames_pain1
	.align 2
	.type	 hover_frames_pain1,@object
hover_frames_pain1:
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
	.long 0xc1000000
	.long 0
	.long ai_move
	.long 0xc0800000
	.long 0
	.long ai_move
	.long 0xc0c00000
	.long 0
	.long ai_move
	.long 0xc0800000
	.long 0
	.long ai_move
	.long 0xc0400000
	.long 0
	.long ai_move
	.long 0x3f800000
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
	.long 0x0
	.long 0
	.long ai_move
	.long 0x40000000
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x40000000
	.long 0
	.long ai_move
	.long 0x40e00000
	.long 0
	.long ai_move
	.long 0x3f800000
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
	.long 0x0
	.long 0
	.long ai_move
	.long 0x40a00000
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x40800000
	.long 0
	.size	 hover_frames_pain1,336
	.globl hover_move_pain1
	.align 2
	.type	 hover_move_pain1,@object
	.size	 hover_move_pain1,16
hover_move_pain1:
	.long 113
	.long 140
	.long hover_frames_pain1
	.long hover_run
	.globl hover_frames_walk
	.align 2
	.type	 hover_frames_walk,@object
hover_frames_walk:
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.size	 hover_frames_walk,420
	.globl hover_move_walk
	.align 2
	.type	 hover_move_walk,@object
	.size	 hover_move_walk,16
hover_move_walk:
	.long 30
	.long 64
	.long hover_frames_walk
	.long 0
	.globl hover_frames_run
	.align 2
	.type	 hover_frames_run,@object
hover_frames_run:
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.size	 hover_frames_run,420
	.globl hover_move_run
	.align 2
	.type	 hover_move_run,@object
	.size	 hover_move_run,16
hover_move_run:
	.long 30
	.long 64
	.long hover_frames_run
	.long 0
	.globl hover_frames_death1
	.align 2
	.type	 hover_frames_death1,@object
hover_frames_death1:
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
	.long 0xc1200000
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x40a00000
	.long 0
	.long ai_move
	.long 0x40800000
	.long 0
	.long ai_move
	.long 0x40e00000
	.long 0
	.size	 hover_frames_death1,132
	.globl hover_move_death1
	.align 2
	.type	 hover_move_death1,@object
	.size	 hover_move_death1,16
hover_move_death1:
	.long 162
	.long 172
	.long hover_frames_death1
	.long hover_dead
	.globl hover_frames_start_attack
	.align 2
	.type	 hover_frames_start_attack,@object
hover_frames_start_attack:
	.long ai_charge
	.long 0x3f800000
	.long 0
	.long ai_charge
	.long 0x3f800000
	.long 0
	.long ai_charge
	.long 0x3f800000
	.long 0
	.size	 hover_frames_start_attack,36
	.globl hover_move_start_attack
	.align 2
	.type	 hover_move_start_attack,@object
	.size	 hover_move_start_attack,16
hover_move_start_attack:
	.long 197
	.long 199
	.long hover_frames_start_attack
	.long hover_attack
	.globl hover_frames_attack1
	.align 2
	.type	 hover_frames_attack1,@object
hover_frames_attack1:
	.long ai_charge
	.long 0xc1200000
	.long hover_fire_blaster
	.long ai_charge
	.long 0xc1200000
	.long hover_fire_blaster
	.long ai_charge
	.long 0x0
	.long hover_reattack
	.size	 hover_frames_attack1,36
	.globl hover_move_attack1
	.align 2
	.type	 hover_move_attack1,@object
	.size	 hover_move_attack1,16
hover_move_attack1:
	.long 200
	.long 202
	.long hover_frames_attack1
	.long 0
	.globl hover_frames_end_attack
	.align 2
	.type	 hover_frames_end_attack,@object
hover_frames_end_attack:
	.long ai_charge
	.long 0x3f800000
	.long 0
	.long ai_charge
	.long 0x3f800000
	.long 0
	.size	 hover_frames_end_attack,24
	.globl hover_move_end_attack
	.align 2
	.type	 hover_move_end_attack,@object
	.size	 hover_move_end_attack,16
hover_move_end_attack:
	.long 203
	.long 204
	.long hover_frames_end_attack
	.long hover_run
	.globl hover_frames_start_attack2
	.align 2
	.type	 hover_frames_start_attack2,@object
hover_frames_start_attack2:
	.long ai_charge
	.long 0x41700000
	.long 0
	.long ai_charge
	.long 0x41700000
	.long 0
	.long ai_charge
	.long 0x41700000
	.long 0
	.size	 hover_frames_start_attack2,36
	.globl hover_move_start_attack2
	.align 2
	.type	 hover_move_start_attack2,@object
	.size	 hover_move_start_attack2,16
hover_move_start_attack2:
	.long 197
	.long 199
	.long hover_frames_start_attack2
	.long hover_attack
	.globl hover_frames_attack2
	.align 2
	.type	 hover_frames_attack2,@object
hover_frames_attack2:
	.long ai_charge
	.long 0x41200000
	.long hover_fire_blaster
	.long ai_charge
	.long 0x41200000
	.long hover_fire_blaster
	.long ai_charge
	.long 0x41200000
	.long hover_reattack
	.size	 hover_frames_attack2,36
	.globl hover_move_attack2
	.align 2
	.type	 hover_move_attack2,@object
	.size	 hover_move_attack2,16
hover_move_attack2:
	.long 200
	.long 202
	.long hover_frames_attack2
	.long 0
	.globl hover_frames_end_attack2
	.align 2
	.type	 hover_frames_end_attack2,@object
hover_frames_end_attack2:
	.long ai_charge
	.long 0x41700000
	.long 0
	.long ai_charge
	.long 0x41700000
	.long 0
	.size	 hover_frames_end_attack2,24
	.globl hover_move_end_attack2
	.align 2
	.type	 hover_move_end_attack2,@object
	.size	 hover_move_end_attack2,16
hover_move_end_attack2:
	.long 203
	.long 204
	.long hover_frames_end_attack2
	.long hover_run
	.section	".rodata"
	.align 2
.LC7:
	.string	"hover_reattack: unexpected state %d\n"
	.align 3
.LC8:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl hover_fire_blaster
	.type	 hover_fire_blaster,@function
hover_fire_blaster:
	stwu 1,-128(1)
	mflr 0
	stmw 27,108(1)
	stw 0,132(1)
	mr 31,3
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L25
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L25
	lwz 29,56(31)
	addi 28,1,24
	addi 27,1,40
	mr 4,28
	addi 3,31,16
	xori 29,29,200
	addic 29,29,-1
	subfe 29,29,29
	mr 5,27
	rlwinm 29,29,0,25,25
	li 6,0
	bl AngleVectors
	lis 4,monster_flash_offset+744@ha
	mr 5,28
	la 4,monster_flash_offset+744@l(4)
	mr 6,27
	addi 3,31,4
	addi 7,1,8
	bl G_ProjectSource
	lwz 11,540(31)
	lis 28,0x4330
	lfs 0,8(1)
	lis 9,.LC8@ha
	mr 3,31
	lfs 12,4(11)
	la 9,.LC8@l(9)
	addi 4,1,8
	lfs 10,12(1)
	addi 5,1,72
	li 6,1
	lfd 9,0(9)
	li 7,1000
	li 8,62
	stfs 12,56(1)
	mr 9,29
	fsubs 12,12,0
	lfs 11,16(1)
	lfs 0,8(11)
	stfs 0,60(1)
	lfs 13,12(11)
	fsubs 0,0,10
	stfs 13,64(1)
	lwz 0,508(11)
	stfs 0,76(1)
	xoris 0,0,0x8000
	stfs 12,72(1)
	stw 0,100(1)
	stw 28,96(1)
	lfd 0,96(1)
	fsub 0,0,9
	frsp 0,0
	fadds 13,13,0
	fsubs 11,13,11
	stfs 13,64(1)
	stfs 11,80(1)
	bl monster_fire_blaster
.L25:
	lwz 0,132(1)
	mtlr 0
	lmw 27,108(1)
	la 1,128(1)
	blr
.Lfe2:
	.size	 hover_fire_blaster,.Lfe2-hover_fire_blaster
	.section	".rodata"
	.align 2
.LC11:
	.long 0x46fffe00
	.align 3
.LC12:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC13:
	.long 0x3fdccccc
	.long 0xcccccccd
	.align 2
.LC14:
	.long 0x40400000
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC16:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC17:
	.long 0x3f800000
	.align 2
.LC18:
	.long 0x0
	.section	".text"
	.align 2
	.globl hover_pain
	.type	 hover_pain,@function
hover_pain:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,484(31)
	lwz 11,480(31)
	srwi 9,0,31
	add 0,0,9
	srawi 0,0,1
	cmpw 0,11,0
	bc 4,0,.L44
	lwz 0,60(31)
	ori 0,0,1
	stw 0,60(31)
.L44:
	lis 9,level+4@ha
	lfs 0,464(31)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L43
	lis 9,.LC14@ha
	lis 30,skill@ha
	la 9,.LC14@l(9)
	lfs 12,0(9)
	lwz 9,skill@l(30)
	fadds 13,13,12
	stfs 13,464(31)
	lfs 0,20(9)
	fcmpu 0,0,12
	bc 12,2,.L43
	cmpwi 0,5,25
	bc 12,1,.L47
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC15@ha
	lis 11,.LC11@ha
	la 10,.LC15@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC16@ha
	lfs 12,.LC11@l(11)
	la 10,.LC16@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L48
	lwz 0,400(31)
	cmpwi 0,0,224
	bc 12,1,.L49
	lis 9,gi+16@ha
	lis 11,sound_pain1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC18@ha
	mr 3,31
	lwz 5,sound_pain1@l(11)
	lis 9,.LC17@ha
	la 10,.LC18@l(10)
	lis 11,.LC17@ha
	la 9,.LC17@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC17@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L50
.L49:
	lis 9,gi+16@ha
	lis 11,daed_sound_pain1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC17@ha
	mr 3,31
	lwz 5,daed_sound_pain1@l(11)
	lis 9,.LC17@ha
	la 10,.LC17@l(10)
	lis 11,.LC18@ha
	la 9,.LC17@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC18@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L50:
	lis 9,hover_move_pain3@ha
	la 9,hover_move_pain3@l(9)
	b .L61
.L48:
	lwz 0,400(31)
	cmpwi 0,0,224
	bc 4,1,.L62
	b .L59
.L47:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 7,skill@l(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC15@ha
	lis 11,.LC11@ha
	la 10,.LC15@l(10)
	stw 0,16(1)
	lis 8,.LC13@ha
	lfd 11,0(10)
	lfd 0,16(1)
	lis 10,.LC12@ha
	lfs 10,.LC11@l(11)
	lfs 12,20(7)
	fsub 0,0,11
	lfd 13,.LC12@l(10)
	lfd 11,.LC13@l(8)
	frsp 0,0
	fmul 12,12,13
	fdivs 0,0,10
	fsub 11,11,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L55
	lwz 0,400(31)
	cmpwi 0,0,224
	bc 12,1,.L56
	lis 9,gi+16@ha
	lis 11,sound_pain1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC18@ha
	mr 3,31
	lwz 5,sound_pain1@l(11)
	lis 9,.LC17@ha
	la 10,.LC18@l(10)
	lis 11,.LC17@ha
	la 9,.LC17@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC17@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L57
.L56:
	lis 9,gi+16@ha
	lis 11,daed_sound_pain1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC17@ha
	mr 3,31
	lwz 5,daed_sound_pain1@l(11)
	lis 9,.LC17@ha
	la 10,.LC17@l(10)
	lis 11,.LC18@ha
	la 9,.LC17@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC18@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L57:
	lis 9,hover_move_pain1@ha
	la 9,hover_move_pain1@l(9)
	b .L61
.L55:
	lwz 0,400(31)
	cmpwi 0,0,224
	bc 12,1,.L59
.L62:
	lis 9,gi+16@ha
	lis 11,sound_pain2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC17@ha
	mr 3,31
	lwz 5,sound_pain2@l(11)
	lis 9,.LC17@ha
	la 10,.LC17@l(10)
	lis 11,.LC18@ha
	la 9,.LC17@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC18@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
	b .L60
.L59:
	lis 9,gi+16@ha
	lis 11,daed_sound_pain2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC17@ha
	mr 3,31
	lwz 5,daed_sound_pain2@l(11)
	lis 9,.LC17@ha
	la 10,.LC17@l(10)
	lis 11,.LC18@ha
	la 9,.LC17@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC18@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L60:
	lis 9,hover_move_pain2@ha
	la 9,hover_move_pain2@l(9)
.L61:
	stw 9,772(31)
.L43:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 hover_pain,.Lfe3-hover_pain
	.section	".rodata"
	.align 2
.LC20:
	.string	""
	.align 2
.LC22:
	.string	"misc/udeath.wav"
	.align 2
.LC23:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC24:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC25:
	.long 0x46fffe00
	.align 2
.LC26:
	.long 0x3f800000
	.align 2
.LC27:
	.long 0x0
	.align 3
.LC28:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC29:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl hover_die
	.type	 hover_die,@function
hover_die:
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
	bc 12,1,.L68
	lis 29,gi@ha
	lis 3,.LC22@ha
	la 29,gi@l(29)
	la 3,.LC22@l(3)
	lwz 9,36(29)
	lis 27,.LC23@ha
	lis 26,.LC24@ha
	li 31,2
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC26@ha
	lis 10,.LC26@ha
	lis 11,.LC27@ha
	mr 5,3
	la 9,.LC26@l(9)
	la 10,.LC26@l(10)
	mtlr 0
	la 11,.LC27@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L72:
	mr 3,30
	la 4,.LC23@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L72
	li 31,2
.L77:
	mr 3,30
	la 4,.LC24@l(26)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L77
	lis 4,.LC24@ha
	mr 5,28
	la 4,.LC24@l(4)
	mr 3,30
	li 6,0
	li 31,2
	bl ThrowHead
	stw 31,492(30)
	b .L67
.L68:
	lwz 0,492(30)
	cmpwi 0,0,2
	bc 12,2,.L67
	lwz 0,400(30)
	cmpwi 0,0,224
	bc 12,1,.L80
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC28@ha
	lis 11,.LC25@ha
	la 10,.LC28@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC29@ha
	lfs 12,.LC25@l(11)
	la 10,.LC29@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L81
	lis 9,gi+16@ha
	lis 11,sound_death1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC27@ha
	mr 3,30
	lwz 5,sound_death1@l(11)
	b .L86
.L81:
	lis 9,gi+16@ha
	lis 11,sound_death2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC26@ha
	mr 3,30
	lwz 5,sound_death2@l(11)
	lis 9,.LC26@ha
	la 10,.LC26@l(10)
	lis 11,.LC27@ha
	la 9,.LC26@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC27@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
	b .L83
.L80:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC28@ha
	lis 11,.LC25@ha
	la 10,.LC28@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC29@ha
	lfs 12,.LC25@l(11)
	la 10,.LC29@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L84
	lis 9,gi+16@ha
	lis 11,daed_sound_death1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC27@ha
	mr 3,30
	lwz 5,daed_sound_death1@l(11)
.L86:
	lis 9,.LC26@ha
	la 10,.LC27@l(10)
	lis 11,.LC26@ha
	la 9,.LC26@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC26@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L83
.L84:
	lis 9,gi+16@ha
	lis 11,daed_sound_death2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC26@ha
	mr 3,30
	lwz 5,daed_sound_death2@l(11)
	lis 9,.LC26@ha
	la 10,.LC26@l(10)
	lis 11,.LC27@ha
	la 9,.LC26@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC27@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L83:
	lis 9,hover_move_death1@ha
	li 0,2
	la 9,hover_move_death1@l(9)
	li 11,1
	stw 0,492(30)
	stw 9,772(30)
	stw 11,512(30)
.L67:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 hover_die,.Lfe4-hover_die
	.section	".rodata"
	.align 2
.LC31:
	.string	"models/monsters/hover/tris.md2"
	.align 2
.LC32:
	.string	"monster_daedalus"
	.align 2
.LC33:
	.string	"daedalus/daedidle1.wav"
	.align 2
.LC34:
	.string	"daedalus/daedpain1.wav"
	.align 2
.LC35:
	.string	"daedalus/daedpain2.wav"
	.align 2
.LC36:
	.string	"daedalus/daeddeth1.wav"
	.align 2
.LC37:
	.string	"daedalus/daeddeth2.wav"
	.align 2
.LC38:
	.string	"daedalus/daedsght1.wav"
	.align 2
.LC39:
	.string	"daedalus/daedsrch1.wav"
	.align 2
.LC40:
	.string	"daedalus/daedsrch2.wav"
	.align 2
.LC41:
	.string	"tank/tnkatck3.wav"
	.align 2
.LC42:
	.string	"hover/hovpain1.wav"
	.align 2
.LC43:
	.string	"hover/hovpain2.wav"
	.align 2
.LC44:
	.string	"hover/hovdeth1.wav"
	.align 2
.LC45:
	.string	"hover/hovdeth2.wav"
	.align 2
.LC46:
	.string	"hover/hovsght1.wav"
	.align 2
.LC47:
	.string	"hover/hovsrch1.wav"
	.align 2
.LC48:
	.string	"hover/hovsrch2.wav"
	.align 2
.LC49:
	.string	"hover/hovatck1.wav"
	.align 2
.LC50:
	.string	"hover/hovidle1.wav"
	.align 2
.LC51:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_hover
	.type	 SP_monster_hover,@function
SP_monster_hover:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 11,.LC51@ha
	lis 9,deathmatch@ha
	la 11,.LC51@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L90
	bl G_FreeEdict
	b .L89
.L90:
	li 0,5
	li 11,2
	lis 9,gi@ha
	stw 0,260(31)
	lis 3,.LC31@ha
	stw 11,248(31)
	la 30,gi@l(9)
	la 3,.LC31@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lis 9,hover_pain@ha
	lis 11,hover_die@ha
	stw 3,40(31)
	lis 10,hover_stand@ha
	lis 8,hover_walk@ha
	lwz 3,280(31)
	la 9,hover_pain@l(9)
	la 11,hover_die@l(11)
	la 10,hover_stand@l(10)
	la 8,hover_walk@l(8)
	stw 9,452(31)
	stw 11,456(31)
	lis 7,hover_run@ha
	lis 6,hover_start_attack@ha
	stw 10,788(31)
	lis 5,hover_sight@ha
	lis 29,hover_search@ha
	stw 8,800(31)
	lis 28,hover_blocked@ha
	lis 0,0xc1c0
	la 7,hover_run@l(7)
	la 6,hover_start_attack@l(6)
	stw 0,196(31)
	la 5,hover_sight@l(5)
	la 29,hover_search@l(29)
	stw 7,804(31)
	la 28,hover_blocked@l(28)
	lis 27,0x41c0
	stw 6,812(31)
	lis 9,0x4200
	li 11,240
	stw 27,204(31)
	li 10,-100
	li 8,150
	stw 9,208(31)
	lis 4,.LC32@ha
	stw 11,480(31)
	la 4,.LC32@l(4)
	stw 10,488(31)
	stw 8,400(31)
	stw 5,820(31)
	stw 29,796(31)
	stw 28,892(31)
	stw 0,188(31)
	stw 0,192(31)
	stw 27,200(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L91
	li 0,450
	li 8,1
	lis 11,0x41c8
	li 10,100
	stw 0,480(31)
	li 9,225
	stw 8,884(31)
	lis 3,.LC33@ha
	stw 11,420(31)
	la 3,.LC33@l(3)
	stw 10,888(31)
	stw 9,400(31)
	lwz 9,36(30)
	mtlr 9
	blrl
	stw 3,76(31)
	lwz 9,36(30)
	lis 3,.LC34@ha
	la 3,.LC34@l(3)
	mtlr 9
	blrl
	lis 9,daed_sound_pain1@ha
	lwz 10,36(30)
	lis 11,.LC35@ha
	stw 3,daed_sound_pain1@l(9)
	mtlr 10
	la 3,.LC35@l(11)
	blrl
	lis 9,daed_sound_pain2@ha
	lwz 10,36(30)
	lis 11,.LC36@ha
	stw 3,daed_sound_pain2@l(9)
	mtlr 10
	la 3,.LC36@l(11)
	blrl
	lis 9,daed_sound_death1@ha
	lwz 10,36(30)
	lis 11,.LC37@ha
	stw 3,daed_sound_death1@l(9)
	mtlr 10
	la 3,.LC37@l(11)
	blrl
	lis 9,daed_sound_death2@ha
	lwz 10,36(30)
	lis 11,.LC38@ha
	stw 3,daed_sound_death2@l(9)
	mtlr 10
	la 3,.LC38@l(11)
	blrl
	lis 9,daed_sound_sight@ha
	lwz 10,36(30)
	lis 11,.LC39@ha
	stw 3,daed_sound_sight@l(9)
	mtlr 10
	la 3,.LC39@l(11)
	blrl
	lis 9,daed_sound_search1@ha
	lwz 10,36(30)
	lis 11,.LC40@ha
	stw 3,daed_sound_search1@l(9)
	la 3,.LC40@l(11)
	mtlr 10
	blrl
	lis 9,daed_sound_search2@ha
	lwz 0,36(30)
	lis 11,.LC41@ha
	stw 3,daed_sound_search2@l(9)
	la 3,.LC41@l(11)
	mtlr 0
	blrl
	b .L92
.L91:
	lwz 9,36(30)
	lis 3,.LC42@ha
	la 3,.LC42@l(3)
	mtlr 9
	blrl
	lis 9,sound_pain1@ha
	lwz 10,36(30)
	lis 11,.LC43@ha
	stw 3,sound_pain1@l(9)
	mtlr 10
	la 3,.LC43@l(11)
	blrl
	lis 9,sound_pain2@ha
	lwz 10,36(30)
	lis 11,.LC44@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC44@l(11)
	blrl
	lis 9,sound_death1@ha
	lwz 10,36(30)
	lis 11,.LC45@ha
	stw 3,sound_death1@l(9)
	mtlr 10
	la 3,.LC45@l(11)
	blrl
	lis 9,sound_death2@ha
	lwz 10,36(30)
	lis 11,.LC46@ha
	stw 3,sound_death2@l(9)
	mtlr 10
	la 3,.LC46@l(11)
	blrl
	lis 9,sound_sight@ha
	lwz 10,36(30)
	lis 11,.LC47@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC47@l(11)
	blrl
	lis 9,sound_search1@ha
	lwz 10,36(30)
	lis 11,.LC48@ha
	stw 3,sound_search1@l(9)
	mtlr 10
	la 3,.LC48@l(11)
	blrl
	lis 9,sound_search2@ha
	lwz 10,36(30)
	lis 11,.LC49@ha
	stw 3,sound_search2@l(9)
	mtlr 10
	la 3,.LC49@l(11)
	blrl
	lwz 0,36(30)
	lis 3,.LC50@ha
	la 3,.LC50@l(3)
	mtlr 0
	blrl
	stw 3,76(31)
.L92:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,hover_move_stand@ha
	lis 11,SP_monster_hover@ha
	la 9,hover_move_stand@l(9)
	la 11,SP_monster_hover@l(11)
	lis 0,0x3f80
	stw 9,772(31)
	mr 3,31
	stw 0,784(31)
	stw 11,992(31)
	bl flymonster_start
	lwz 3,280(31)
	lis 4,.LC32@ha
	la 4,.LC32@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L89
	li 0,2
	stw 0,60(31)
.L89:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 SP_monster_hover,.Lfe5-SP_monster_hover
	.section	".sbss","aw",@nobits
	.align 2
sound_pain1:
	.space	4
	.size	 sound_pain1,4
	.align 2
sound_pain2:
	.space	4
	.size	 sound_pain2,4
	.align 2
sound_death1:
	.space	4
	.size	 sound_death1,4
	.align 2
sound_death2:
	.space	4
	.size	 sound_death2,4
	.align 2
sound_sight:
	.space	4
	.size	 sound_sight,4
	.align 2
sound_search1:
	.space	4
	.size	 sound_search1,4
	.align 2
sound_search2:
	.space	4
	.size	 sound_search2,4
	.align 2
daed_sound_pain1:
	.space	4
	.size	 daed_sound_pain1,4
	.align 2
daed_sound_pain2:
	.space	4
	.size	 daed_sound_pain2,4
	.align 2
daed_sound_death1:
	.space	4
	.size	 daed_sound_death1,4
	.align 2
daed_sound_death2:
	.space	4
	.size	 daed_sound_death2,4
	.align 2
daed_sound_sight:
	.space	4
	.size	 daed_sound_sight,4
	.align 2
daed_sound_search1:
	.space	4
	.size	 daed_sound_search1,4
	.align 2
daed_sound_search2:
	.space	4
	.size	 daed_sound_search2,4
	.section	".rodata"
	.align 2
.LC52:
	.long 0x3f800000
	.align 2
.LC53:
	.long 0x0
	.section	".text"
	.align 2
	.globl hover_sight
	.type	 hover_sight,@function
hover_sight:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,400(3)
	cmpwi 0,0,224
	bc 12,1,.L7
	lis 9,gi+16@ha
	lis 11,sound_sight@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC52@ha
	lwz 5,sound_sight@l(11)
	la 9,.LC52@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 2,0(9)
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	lfs 3,0(9)
	blrl
	b .L8
.L7:
	lis 9,gi+16@ha
	lis 11,daed_sound_sight@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC52@ha
	lwz 5,daed_sound_sight@l(11)
	la 9,.LC52@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 2,0(9)
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	lfs 3,0(9)
	blrl
.L8:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 hover_sight,.Lfe6-hover_sight
	.align 2
	.globl hover_run
	.type	 hover_run,@function
hover_run:
	lwz 0,776(3)
	andi. 9,0,1
	bc 12,2,.L32
	lis 9,hover_move_stand@ha
	la 9,hover_move_stand@l(9)
	stw 9,772(3)
	blr
.L32:
	lis 9,hover_move_run@ha
	la 9,hover_move_run@l(9)
	stw 9,772(3)
	blr
.Lfe7:
	.size	 hover_run,.Lfe7-hover_run
	.align 2
	.globl hover_stand
	.type	 hover_stand,@function
hover_stand:
	lis 9,hover_move_stand@ha
	la 9,hover_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe8:
	.size	 hover_stand,.Lfe8-hover_stand
	.section	".rodata"
	.align 3
.LC54:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC55:
	.long 0x41700000
	.section	".text"
	.align 2
	.globl hover_dead
	.type	 hover_dead,@function
hover_dead:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 10,hover_deadthink@ha
	mr 9,3
	lis 5,0xc180
	lis 4,0x4180
	lis 0,0xc1c0
	lis 8,0xc100
	stw 5,192(9)
	la 10,hover_deadthink@l(10)
	li 7,7
	stw 8,208(9)
	lis 11,level@ha
	stw 0,196(9)
	lis 6,.LC54@ha
	stw 4,204(9)
	la 11,level@l(11)
	lis 8,.LC55@ha
	stw 7,260(9)
	la 8,.LC55@l(8)
	stw 10,436(9)
	stw 5,188(9)
	stw 4,200(9)
	lfs 0,4(11)
	lfd 13,.LC54@l(6)
	lfs 12,0(8)
	lis 8,gi+72@ha
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(9)
	lfs 13,4(11)
	fadds 13,13,12
	stfs 13,288(9)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 hover_dead,.Lfe9-hover_dead
	.section	".rodata"
	.align 3
.LC56:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC57:
	.long 0x46fffe00
	.align 2
.LC58:
	.long 0x0
	.align 3
.LC59:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC60:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC61:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl hover_attack
	.type	 hover_attack,@function
hover_attack:
	stwu 1,-48(1)
	mflr 0
	stfd 29,24(1)
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 30,16(1)
	stw 0,52(1)
	lis 11,.LC58@ha
	lis 9,skill@ha
	la 11,.LC58@l(11)
	mr 31,3
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L37
	lis 9,.LC58@ha
	la 9,.LC58@l(9)
	lfs 31,0(9)
	b .L38
.L37:
	lis 11,.LC59@ha
	fmr 0,13
	lis 9,.LC60@ha
	la 11,.LC59@l(11)
	la 9,.LC60@l(9)
	lfd 13,0(11)
	lfd 12,0(9)
	fdiv 13,13,0
	fsub 12,12,13
	frsp 31,12
.L38:
	lwz 0,400(31)
	cmpwi 0,0,150
	bc 4,1,.L39
	lis 9,.LC56@ha
	fmr 0,31
	lfd 13,.LC56@l(9)
	fadd 0,0,13
	frsp 31,0
.L39:
	bl rand
	lis 30,0x4330
	lis 9,.LC61@ha
	rlwinm 3,3,0,17,31
	la 9,.LC61@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 11,.LC57@ha
	lfs 29,.LC57@l(11)
	stw 3,12(1)
	stw 30,8(1)
	lfd 0,8(1)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,29
	fcmpu 0,0,31
	bc 4,1,.L40
	lis 9,hover_move_attack1@ha
	li 0,1
	la 9,hover_move_attack1@l(9)
	b .L94
.L40:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC59@ha
	stw 3,12(1)
	la 11,.LC59@l(11)
	stw 30,8(1)
	lfd 0,8(1)
	lfd 12,0(11)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,0
	bc 4,3,.L42
	lwz 0,872(31)
	subfic 0,0,1
	stw 0,872(31)
.L42:
	lis 9,hover_move_attack2@ha
	li 0,2
	la 9,hover_move_attack2@l(9)
.L94:
	stw 0,868(31)
	stw 9,772(31)
	lwz 0,52(1)
	mtlr 0
	lmw 30,16(1)
	lfd 29,24(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 hover_attack,.Lfe10-hover_attack
	.section	".rodata"
	.align 2
.LC62:
	.long 0x46fffe00
	.align 3
.LC63:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC64:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl hover_reattack
	.type	 hover_reattack,@function
hover_reattack:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 4,540(31)
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L18
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L18
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC64@ha
	lis 10,.LC62@ha
	la 11,.LC64@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC63@ha
	lfs 11,.LC62@l(10)
	lfd 12,.LC63@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,0
	bc 4,3,.L18
	lwz 4,868(31)
	cmpwi 0,4,1
	bc 4,2,.L21
	lis 9,hover_move_attack1@ha
	la 9,hover_move_attack1@l(9)
	b .L95
.L21:
	cmpwi 0,4,2
	bc 4,2,.L23
	lis 9,hover_move_attack2@ha
	la 9,hover_move_attack2@l(9)
	b .L95
.L23:
	lis 9,gi+4@ha
	lis 3,.LC7@ha
	lwz 0,gi+4@l(9)
	la 3,.LC7@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L18:
	lis 9,hover_move_end_attack@ha
	la 9,hover_move_end_attack@l(9)
.L95:
	stw 9,772(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 hover_reattack,.Lfe11-hover_reattack
	.align 2
	.globl hover_walk
	.type	 hover_walk,@function
hover_walk:
	lis 9,hover_move_walk@ha
	la 9,hover_move_walk@l(9)
	stw 9,772(3)
	blr
.Lfe12:
	.size	 hover_walk,.Lfe12-hover_walk
	.align 2
	.globl hover_start_attack
	.type	 hover_start_attack,@function
hover_start_attack:
	lis 9,hover_move_start_attack@ha
	la 9,hover_move_start_attack@l(9)
	stw 9,772(3)
	blr
.Lfe13:
	.size	 hover_start_attack,.Lfe13-hover_start_attack
	.section	".rodata"
	.align 3
.LC65:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl hover_deadthink
	.type	 hover_deadthink,@function
hover_deadthink:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L65
	lis 9,level+4@ha
	lfs 0,288(31)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L65
	fmr 0,13
	lis 9,.LC65@ha
	lfd 13,.LC65@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L64
.L65:
	mr 3,31
	addi 28,31,4
	bl SetMonsterRespawn
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,5
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,28
	li 4,2
	mtlr 9
	blrl
	lwz 0,32(29)
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	mtlr 0
	blrl
	li 0,0
	stw 3,40(31)
	stw 0,512(31)
	stw 0,248(31)
.L64:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 hover_deadthink,.Lfe14-hover_deadthink
	.section	".rodata"
	.align 3
.LC66:
	.long 0x3fa99999
	.long 0x9999999a
	.align 3
.LC67:
	.long 0x3fd00000
	.long 0x0
	.section	".text"
	.align 2
	.globl hover_blocked
	.type	 hover_blocked,@function
hover_blocked:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,skill@ha
	lis 11,.LC66@ha
	lwz 10,skill@l(9)
	lis 9,.LC67@ha
	lfd 0,.LC66@l(11)
	lfs 1,20(10)
	la 9,.LC67@l(9)
	lfd 13,0(9)
	fmadd 1,1,0,13
	frsp 1,1
	bl blocked_checkshot
	addic 9,3,-1
	subfe 0,9,3
	mr 3,0
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 hover_blocked,.Lfe15-hover_blocked
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
