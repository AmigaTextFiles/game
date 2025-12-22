	.file	"m_parasite.c"
gcc2_compiled.:
	.globl parasite_frames_start_fidget
	.section	".data"
	.align 2
	.type	 parasite_frames_start_fidget,@object
parasite_frames_start_fidget:
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
	.size	 parasite_frames_start_fidget,48
	.globl parasite_move_start_fidget
	.align 2
	.type	 parasite_move_start_fidget,@object
	.size	 parasite_move_start_fidget,16
parasite_move_start_fidget:
	.long 100
	.long 103
	.long parasite_frames_start_fidget
	.long parasite_do_fidget
	.globl parasite_frames_fidget
	.align 2
	.type	 parasite_frames_fidget,@object
parasite_frames_fidget:
	.long ai_stand
	.long 0x0
	.long parasite_scratch
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long parasite_scratch
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.size	 parasite_frames_fidget,72
	.globl parasite_move_fidget
	.align 2
	.type	 parasite_move_fidget,@object
	.size	 parasite_move_fidget,16
parasite_move_fidget:
	.long 104
	.long 109
	.long parasite_frames_fidget
	.long parasite_refidget
	.globl parasite_frames_end_fidget
	.align 2
	.type	 parasite_frames_end_fidget,@object
parasite_frames_end_fidget:
	.long ai_stand
	.long 0x0
	.long parasite_scratch
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
	.size	 parasite_frames_end_fidget,96
	.globl parasite_move_end_fidget
	.align 2
	.type	 parasite_move_end_fidget,@object
	.size	 parasite_move_end_fidget,16
parasite_move_end_fidget:
	.long 110
	.long 117
	.long parasite_frames_end_fidget
	.long parasite_stand
	.globl parasite_frames_stand
	.align 2
	.type	 parasite_frames_stand,@object
parasite_frames_stand:
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long parasite_tap
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long parasite_tap
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
	.long parasite_tap
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long parasite_tap
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
	.long parasite_tap
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long parasite_tap
	.size	 parasite_frames_stand,204
	.globl parasite_move_stand
	.align 2
	.type	 parasite_move_stand,@object
	.size	 parasite_move_stand,16
parasite_move_stand:
	.long 83
	.long 99
	.long parasite_frames_stand
	.long parasite_stand
	.globl parasite_frames_run
	.align 2
	.type	 parasite_frames_run,@object
parasite_frames_run:
	.long ai_run
	.long 0x41f00000
	.long 0
	.long ai_run
	.long 0x41f00000
	.long 0
	.long ai_run
	.long 0x41b00000
	.long 0
	.long ai_run
	.long 0x41980000
	.long 0
	.long ai_run
	.long 0x41c00000
	.long 0
	.long ai_run
	.long 0x41e00000
	.long 0
	.long ai_run
	.long 0x41c80000
	.long 0
	.size	 parasite_frames_run,84
	.globl parasite_move_run
	.align 2
	.type	 parasite_move_run,@object
	.size	 parasite_move_run,16
parasite_move_run:
	.long 70
	.long 76
	.long parasite_frames_run
	.long 0
	.globl parasite_frames_start_run
	.align 2
	.type	 parasite_frames_start_run,@object
parasite_frames_start_run:
	.long ai_run
	.long 0x0
	.long 0
	.long ai_run
	.long 0x41f00000
	.long 0
	.size	 parasite_frames_start_run,24
	.globl parasite_move_start_run
	.align 2
	.type	 parasite_move_start_run,@object
	.size	 parasite_move_start_run,16
parasite_move_start_run:
	.long 68
	.long 69
	.long parasite_frames_start_run
	.long parasite_run
	.globl parasite_frames_stop_run
	.align 2
	.type	 parasite_frames_stop_run,@object
parasite_frames_stop_run:
	.long ai_run
	.long 0x41a00000
	.long 0
	.long ai_run
	.long 0x41a00000
	.long 0
	.long ai_run
	.long 0x41400000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x0
	.long 0
	.long ai_run
	.long 0x0
	.long 0
	.size	 parasite_frames_stop_run,72
	.globl parasite_move_stop_run
	.align 2
	.type	 parasite_move_stop_run,@object
	.size	 parasite_move_stop_run,16
parasite_move_stop_run:
	.long 77
	.long 82
	.long parasite_frames_stop_run
	.long 0
	.globl parasite_frames_walk
	.align 2
	.type	 parasite_frames_walk,@object
parasite_frames_walk:
	.long ai_walk
	.long 0x41f00000
	.long 0
	.long ai_walk
	.long 0x41f00000
	.long 0
	.long ai_walk
	.long 0x41b00000
	.long 0
	.long ai_walk
	.long 0x41980000
	.long 0
	.long ai_walk
	.long 0x41c00000
	.long 0
	.long ai_walk
	.long 0x41e00000
	.long 0
	.long ai_walk
	.long 0x41c80000
	.long 0
	.size	 parasite_frames_walk,84
	.globl parasite_move_walk
	.align 2
	.type	 parasite_move_walk,@object
	.size	 parasite_move_walk,16
parasite_move_walk:
	.long 70
	.long 76
	.long parasite_frames_walk
	.long parasite_walk
	.globl parasite_frames_start_walk
	.align 2
	.type	 parasite_frames_start_walk,@object
parasite_frames_start_walk:
	.long ai_walk
	.long 0x0
	.long 0
	.long ai_walk
	.long 0x41f00000
	.long parasite_walk
	.size	 parasite_frames_start_walk,24
	.globl parasite_move_start_walk
	.align 2
	.type	 parasite_move_start_walk,@object
	.size	 parasite_move_start_walk,16
parasite_move_start_walk:
	.long 68
	.long 69
	.long parasite_frames_start_walk
	.long 0
	.globl parasite_frames_stop_walk
	.align 2
	.type	 parasite_frames_stop_walk,@object
parasite_frames_stop_walk:
	.long ai_walk
	.long 0x41a00000
	.long 0
	.long ai_walk
	.long 0x41a00000
	.long 0
	.long ai_walk
	.long 0x41400000
	.long 0
	.long ai_walk
	.long 0x41200000
	.long 0
	.long ai_walk
	.long 0x0
	.long 0
	.long ai_walk
	.long 0x0
	.long 0
	.size	 parasite_frames_stop_walk,72
	.globl parasite_move_stop_walk
	.align 2
	.type	 parasite_move_stop_walk,@object
	.size	 parasite_move_stop_walk,16
parasite_move_stop_walk:
	.long 77
	.long 82
	.long parasite_frames_stop_walk
	.long 0
	.globl parasite_frames_pain1
	.align 2
	.type	 parasite_frames_pain1,@object
parasite_frames_pain1:
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
	.long 0x40c00000
	.long 0
	.long ai_move
	.long 0x41800000
	.long 0
	.long ai_move
	.long 0xc0c00000
	.long 0
	.long ai_move
	.long 0xc0e00000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 parasite_frames_pain1,132
	.globl parasite_move_pain1
	.align 2
	.type	 parasite_move_pain1,@object
	.size	 parasite_move_pain1,16
parasite_move_pain1:
	.long 57
	.long 67
	.long parasite_frames_pain1
	.long parasite_start_run
	.section	".rodata"
	.align 2
.LC3:
	.long 0x43800000
	.align 2
.LC4:
	.long 0xc3340000
	.align 2
.LC5:
	.long 0x43b40000
	.align 3
.LC6:
	.long 0x403e0000
	.long 0x0
	.align 2
.LC7:
	.long 0x41000000
	.align 2
.LC8:
	.long 0x3f800000
	.align 2
.LC9:
	.long 0x0
	.section	".text"
	.align 2
	.globl parasite_drain_attack
	.type	 parasite_drain_attack,@function
parasite_drain_attack:
	stwu 1,-240(1)
	mflr 0
	stmw 27,220(1)
	stw 0,244(1)
	addi 29,1,48
	addi 28,1,64
	mr 31,3
	addi 27,1,32
	addi 3,31,16
	mr 4,29
	mr 5,28
	li 6,0
	bl AngleVectors
	mr 30,27
	lis 0,0x41c0
	li 9,0
	lis 11,0x40c0
	stw 9,20(1)
	mr 5,29
	stw 0,16(1)
	mr 6,28
	addi 3,31,4
	stw 11,24(1)
	addi 4,1,16
	mr 7,27
	bl G_ProjectSource
	lwz 9,816(31)
	addi 3,1,176
	lfs 12,32(1)
	lfs 0,4(9)
	lfs 11,36(1)
	stfs 0,80(1)
	fsubs 12,12,0
	lfs 13,8(9)
	lfs 0,40(1)
	stfs 13,84(1)
	fsubs 11,11,13
	lfs 10,12(9)
	stfs 12,176(1)
	stfs 11,180(1)
	fsubs 0,0,10
	stfs 10,88(1)
	stfs 0,184(1)
	bl VectorLength
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,1,.L57
	addi 3,1,176
	addi 4,1,192
	bl vectoangles
	lis 9,.LC4@ha
	lfs 13,192(1)
	la 9,.LC4@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L41
	lis 11,.LC5@ha
	la 11,.LC5@l(11)
	lfs 0,0(11)
	fadds 0,13,0
	stfs 0,192(1)
.L41:
	lfs 0,192(1)
	lis 9,.LC6@ha
	li 0,1
	la 9,.LC6@l(9)
	lfd 13,0(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,1,.L40
.L57:
	li 0,0
.L40:
	cmpwi 0,0,0
	bc 4,2,.L38
	lwz 9,816(31)
	lis 11,.LC7@ha
	addi 3,1,176
	la 11,.LC7@l(11)
	lfs 11,32(1)
	lfs 13,208(9)
	lfs 0,12(9)
	lfs 8,0(11)
	lfs 10,80(1)
	fadds 0,0,13
	lfs 12,36(1)
	lfs 9,84(1)
	lfs 13,40(1)
	fsubs 11,11,10
	fsubs 0,0,8
	fsubs 12,12,9
	stfs 11,176(1)
	fsubs 13,13,0
	stfs 0,88(1)
	stfs 12,180(1)
	stfs 13,184(1)
	bl VectorLength
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,1,.L58
	addi 3,1,176
	addi 4,1,192
	bl vectoangles
	lis 9,.LC4@ha
	lfs 13,192(1)
	la 9,.LC4@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L46
	lis 11,.LC5@ha
	la 11,.LC5@l(11)
	lfs 0,0(11)
	fadds 0,13,0
	stfs 0,192(1)
.L46:
	lfs 0,192(1)
	lis 9,.LC6@ha
	li 0,1
	la 9,.LC6@l(9)
	lfd 13,0(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,1,.L45
.L58:
	li 0,0
.L45:
	cmpwi 0,0,0
	bc 4,2,.L38
	lwz 9,816(31)
	lis 11,.LC7@ha
	addi 3,1,176
	la 11,.LC7@l(11)
	lfs 11,32(1)
	lfs 13,196(9)
	lfs 0,12(9)
	lfs 8,0(11)
	lfs 10,80(1)
	fadds 0,0,13
	lfs 12,36(1)
	lfs 9,84(1)
	lfs 13,40(1)
	fsubs 11,11,10
	fadds 0,0,8
	fsubs 12,12,9
	stfs 11,176(1)
	fsubs 13,13,0
	stfs 0,88(1)
	stfs 12,180(1)
	stfs 13,184(1)
	bl VectorLength
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,1,.L59
	addi 3,1,176
	addi 4,1,192
	bl vectoangles
	lis 9,.LC4@ha
	lfs 13,192(1)
	la 9,.LC4@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L51
	lis 11,.LC5@ha
	la 11,.LC5@l(11)
	lfs 0,0(11)
	fadds 0,13,0
	stfs 0,192(1)
.L51:
	lfs 0,192(1)
	lis 9,.LC6@ha
	li 0,1
	la 9,.LC6@l(9)
	lfd 13,0(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,1,.L50
.L59:
	li 0,0
.L50:
	cmpwi 0,0,0
	bc 12,2,.L37
.L38:
	lwz 11,816(31)
	lis 9,gi@ha
	addi 7,1,80
	la 29,gi@l(9)
	addi 3,1,112
	lfs 0,4(11)
	lis 9,0x600
	mr 4,30
	lwz 10,48(29)
	li 5,0
	li 6,0
	mr 8,31
	ori 9,9,3
	stfs 0,80(1)
	mtlr 10
	mr 27,7
	lfs 13,8(11)
	stfs 13,84(1)
	lfs 0,12(11)
	stfs 0,88(1)
	blrl
	lwz 3,164(1)
	lwz 0,816(31)
	cmpw 0,3,0
	bc 4,2,.L37
	lwz 0,56(31)
	cmpwi 0,0,41
	bc 4,2,.L54
	lis 9,sound_impact@ha
	lwz 0,16(29)
	lis 11,.LC8@ha
	lwz 5,sound_impact@l(9)
	la 11,.LC8@l(11)
	li 4,0
	lis 9,.LC8@ha
	lfs 2,0(11)
	mtlr 0
	li 28,5
	la 9,.LC8@l(9)
	lfs 1,0(9)
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 3,0(9)
	blrl
	b .L55
.L54:
	cmpwi 0,0,42
	bc 4,2,.L56
	lis 9,sound_suck@ha
	lwz 0,16(29)
	lis 11,.LC8@ha
	lwz 5,sound_suck@l(9)
	la 11,.LC8@l(11)
	mr 3,31
	lis 9,.LC8@ha
	li 4,1
	lfs 2,0(11)
	mtlr 0
	la 9,.LC8@l(9)
	lfs 1,0(9)
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 3,0(9)
	blrl
.L56:
	li 28,2
.L55:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,16
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x6f71
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,56853
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,120(29)
	mr 3,30
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
	lfs 0,80(1)
	mr 4,31
	li 0,8
	lfs 11,32(1)
	li 11,39
	lis 8,vec3_origin@ha
	lfs 12,36(1)
	la 8,vec3_origin@l(8)
	mr 9,28
	lfs 10,84(1)
	mr 5,4
	addi 6,1,96
	fsubs 11,11,0
	lfs 13,88(1)
	li 10,0
	lfs 0,40(1)
	fsubs 12,12,10
	lwz 3,816(31)
	stfs 11,96(1)
	fsubs 0,0,13
	stw 0,8(1)
	addi 7,3,4
	stfs 12,100(1)
	stw 11,12(1)
	stfs 0,104(1)
	bl T_Damage
.L37:
	lwz 0,244(1)
	mtlr 0
	lmw 27,220(1)
	la 1,240(1)
	blr
.Lfe1:
	.size	 parasite_drain_attack,.Lfe1-parasite_drain_attack
	.globl parasite_frames_drain
	.section	".data"
	.align 2
	.type	 parasite_frames_drain,@object
parasite_frames_drain:
	.long ai_charge
	.long 0x0
	.long parasite_launch
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x41700000
	.long parasite_drain_attack
	.long ai_charge
	.long 0x0
	.long parasite_drain_attack
	.long ai_charge
	.long 0x0
	.long parasite_drain_attack
	.long ai_charge
	.long 0x0
	.long parasite_drain_attack
	.long ai_charge
	.long 0x0
	.long parasite_drain_attack
	.long ai_charge
	.long 0xc0000000
	.long parasite_drain_attack
	.long ai_charge
	.long 0xc0000000
	.long parasite_drain_attack
	.long ai_charge
	.long 0xc0400000
	.long parasite_drain_attack
	.long ai_charge
	.long 0xc0000000
	.long parasite_drain_attack
	.long ai_charge
	.long 0x0
	.long parasite_drain_attack
	.long ai_charge
	.long 0xbf800000
	.long parasite_drain_attack
	.long ai_charge
	.long 0x0
	.long parasite_reel_in
	.long ai_charge
	.long 0xc0000000
	.long 0
	.long ai_charge
	.long 0xc0000000
	.long 0
	.long ai_charge
	.long 0xc0400000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.size	 parasite_frames_drain,216
	.globl parasite_move_drain
	.align 2
	.type	 parasite_move_drain,@object
	.size	 parasite_move_drain,16
parasite_move_drain:
	.long 39
	.long 56
	.long parasite_frames_drain
	.long parasite_start_run
	.globl parasite_frames_break
	.align 2
	.type	 parasite_frames_break,@object
parasite_frames_break:
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0xc0400000
	.long 0
	.long ai_charge
	.long 0x3f800000
	.long 0
	.long ai_charge
	.long 0x40000000
	.long 0
	.long ai_charge
	.long 0xc0400000
	.long 0
	.long ai_charge
	.long 0x3f800000
	.long 0
	.long ai_charge
	.long 0x3f800000
	.long 0
	.long ai_charge
	.long 0x40400000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0xc1900000
	.long 0
	.long ai_charge
	.long 0x40400000
	.long 0
	.long ai_charge
	.long 0x41100000
	.long 0
	.long ai_charge
	.long 0x40c00000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0xc1900000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x41000000
	.long 0
	.long ai_charge
	.long 0x41100000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0xc1900000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x40800000
	.long 0
	.long ai_charge
	.long 0x41300000
	.long 0
	.long ai_charge
	.long 0xc0000000
	.long 0
	.long ai_charge
	.long 0xc0a00000
	.long 0
	.long ai_charge
	.long 0x3f800000
	.long 0
	.size	 parasite_frames_break,384
	.globl parasite_move_break
	.align 2
	.type	 parasite_move_break,@object
	.size	 parasite_move_break,16
parasite_move_break:
	.long 0
	.long 31
	.long parasite_frames_break
	.long parasite_start_run
	.globl parasite_frames_death
	.align 2
	.type	 parasite_frames_death,@object
parasite_frames_death:
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
	.size	 parasite_frames_death,84
	.globl parasite_move_death
	.align 2
	.type	 parasite_move_death,@object
	.size	 parasite_move_death,16
parasite_move_death:
	.long 32
	.long 38
	.long parasite_frames_death
	.long parasite_dead
	.section	".rodata"
	.align 2
.LC10:
	.string	"misc/udeath.wav"
	.align 2
.LC11:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC12:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC13:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC14:
	.string	"parasite/parpain1.wav"
	.align 2
.LC15:
	.string	"parasite/parpain2.wav"
	.align 2
.LC16:
	.string	"parasite/pardeth1.wav"
	.align 2
.LC17:
	.string	"parasite/paratck1.wav"
	.align 2
.LC18:
	.string	"parasite/paratck2.wav"
	.align 2
.LC19:
	.string	"parasite/paratck3.wav"
	.align 2
.LC20:
	.string	"parasite/paratck4.wav"
	.align 2
.LC21:
	.string	"parasite/parsght1.wav"
	.align 2
.LC22:
	.string	"parasite/paridle1.wav"
	.align 2
.LC23:
	.string	"parasite/paridle2.wav"
	.align 2
.LC24:
	.string	"parasite/parsrch1.wav"
	.align 2
.LC25:
	.string	"models/monsters/parasite/tris.md2"
	.section	".text"
	.align 2
	.globl SP_monster_parasite
	.type	 SP_monster_parasite,@function
SP_monster_parasite:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 28,gi@ha
	mr 29,3
	la 28,gi@l(28)
	lis 3,.LC14@ha
	lwz 9,36(28)
	la 3,.LC14@l(3)
	mtlr 9
	blrl
	lwz 10,36(28)
	lis 9,sound_pain1@ha
	lis 11,.LC15@ha
	stw 3,sound_pain1@l(9)
	mtlr 10
	la 3,.LC15@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_pain2@ha
	lis 11,.LC16@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC16@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_die@ha
	lis 11,.LC17@ha
	stw 3,sound_die@l(9)
	mtlr 10
	la 3,.LC17@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_launch@ha
	lis 11,.LC18@ha
	stw 3,sound_launch@l(9)
	mtlr 10
	la 3,.LC18@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_impact@ha
	lis 11,.LC19@ha
	stw 3,sound_impact@l(9)
	mtlr 10
	la 3,.LC19@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_suck@ha
	lis 11,.LC20@ha
	stw 3,sound_suck@l(9)
	mtlr 10
	la 3,.LC20@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_reelin@ha
	lis 11,.LC21@ha
	stw 3,sound_reelin@l(9)
	mtlr 10
	la 3,.LC21@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_sight@ha
	lis 11,.LC22@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC22@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_tap@ha
	lis 11,.LC23@ha
	stw 3,sound_tap@l(9)
	mtlr 10
	la 3,.LC23@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_scratch@ha
	lis 11,.LC24@ha
	stw 3,sound_scratch@l(9)
	mtlr 10
	la 3,.LC24@l(11)
	blrl
	lwz 10,32(28)
	lis 9,sound_search@ha
	lis 11,.LC25@ha
	stw 3,sound_search@l(9)
	mtlr 10
	la 3,.LC25@l(11)
	blrl
	lis 9,parasite_pain@ha
	lis 11,parasite_die@ha
	stw 3,40(29)
	lis 10,parasite_stand@ha
	lis 8,parasite_start_walk@ha
	la 9,parasite_pain@l(9)
	la 11,parasite_die@l(11)
	la 10,parasite_stand@l(10)
	la 8,parasite_start_walk@l(8)
	stw 9,696(29)
	lis 0,0xc1c0
	stw 11,700(29)
	lis 7,parasite_start_run@ha
	stw 10,1140(29)
	lis 6,parasite_attack@ha
	lis 5,parasite_sight@ha
	stw 8,1152(29)
	lis 4,parasite_idle@ha
	li 9,175
	stw 0,196(29)
	la 7,parasite_start_run@l(7)
	la 6,parasite_attack@l(6)
	la 5,parasite_sight@l(5)
	la 4,parasite_idle@l(4)
	stw 9,728(29)
	lis 26,0xc180
	lis 25,0x4180
	stw 7,1156(29)
	lis 10,0x41c0
	li 8,5
	stw 26,192(29)
	li 11,-50
	li 0,250
	stw 25,204(29)
	li 27,2
	stw 10,208(29)
	mr 3,29
	stw 8,264(29)
	stw 27,248(29)
	stw 11,760(29)
	stw 0,644(29)
	stw 6,1164(29)
	stw 5,1172(29)
	stw 4,1144(29)
	stw 26,188(29)
	stw 25,200(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lis 9,parasite_move_stand@ha
	lis 0,0x3f80
	la 9,parasite_move_stand@l(9)
	stw 0,1136(29)
	mr 3,29
	stw 9,1124(29)
	bl walkmonster_start
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 SP_monster_parasite,.Lfe2-SP_monster_parasite
	.section	".rodata"
	.align 2
.LC26:
	.string	"Too close to wall.\n"
	.align 2
.LC27:
	.string	"Cells"
	.align 2
.LC28:
	.long 0x43160000
	.align 3
.LC29:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC30:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl SP_monster_parasite2
	.type	 SP_monster_parasite2,@function
SP_monster_parasite2:
	stwu 1,-128(1)
	mflr 0
	stmw 27,108(1)
	stw 0,132(1)
	mr 28,3
	lwz 3,84(28)
	cmpwi 0,3,0
	bc 12,2,.L79
	lwz 0,728(28)
	cmpwi 0,0,0
	bc 4,1,.L79
	lfs 12,4(28)
	addi 4,1,8
	addi 3,3,3752
	lfs 13,8(28)
	li 5,0
	li 6,0
	lfs 0,12(28)
	addi 27,28,4
	stfs 12,24(1)
	stfs 13,28(1)
	stfs 0,32(1)
	bl AngleVectors
	lis 11,.LC28@ha
	lfs 0,4(28)
	lis 9,gi@ha
	la 11,.LC28@l(11)
	lfs 10,8(1)
	la 30,gi@l(9)
	lfs 11,0(11)
	li 9,3
	addi 3,1,40
	lfs 13,12(28)
	mr 4,27
	li 5,0
	lfs 9,8(28)
	li 6,0
	addi 7,1,24
	fmadds 10,10,11,0
	lfs 12,12(1)
	mr 8,28
	lfs 0,16(1)
	lwz 11,48(30)
	fmadds 12,12,11,9
	stfs 10,24(1)
	fmadds 0,0,11,13
	mtlr 11
	stfs 12,28(1)
	stfs 0,32(1)
	blrl
	lfs 0,48(1)
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L82
	lwz 0,8(30)
	lis 5,.LC26@ha
	mr 3,28
	la 5,.LC26@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 3,.LC27@ha
	la 3,.LC27@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 10,84(28)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	mullw 3,3,0
	srawi 3,3,3
	stw 3,744(10)
	lwz 11,84(28)
	lwz 0,744(11)
	addi 11,11,748
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,50
	stwx 9,11,0
	b .L79
.L82:
	lwz 9,84(1)
	cmpwi 0,9,0
	bc 12,2,.L83
	lwz 0,16(9)
	andi. 9,0,4
	bc 4,2,.L79
.L83:
	bl G_Spawn
	cmpwi 0,28,0
	mr 31,3
	stw 28,1264(31)
	bc 12,2,.L85
	lwz 9,932(28)
	addi 9,9,1
	stw 9,932(28)
.L85:
	lwz 3,84(28)
	li 6,0
	addi 4,1,8
	li 5,0
	addi 29,31,4
	addi 3,3,3752
	bl AngleVectors
	lis 9,.LC30@ha
	mr 5,29
	la 9,.LC30@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 3,27
	bl VectorMA
	lwz 0,908(28)
	li 3,1
	stw 0,908(31)
	lfs 0,16(28)
	stfs 0,16(31)
	lfs 13,20(28)
	stfs 13,20(31)
	lfs 0,24(28)
	stfs 0,24(31)
	lwz 9,100(30)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x6f71
	lwz 10,104(30)
	lwz 3,g_edicts@l(9)
	ori 0,0,56853
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(30)
	li 3,9
	mtlr 9
	blrl
	lwz 9,88(30)
	li 4,2
	mr 3,29
	mtlr 9
	blrl
	lwz 9,36(30)
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	mtlr 9
	blrl
	lis 9,sound_pain1@ha
	lwz 10,36(30)
	lis 11,.LC15@ha
	stw 3,sound_pain1@l(9)
	mtlr 10
	la 3,.LC15@l(11)
	blrl
	lis 9,sound_pain2@ha
	lwz 10,36(30)
	lis 11,.LC16@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC16@l(11)
	blrl
	lis 9,sound_die@ha
	lwz 10,36(30)
	lis 11,.LC17@ha
	stw 3,sound_die@l(9)
	mtlr 10
	la 3,.LC17@l(11)
	blrl
	lis 9,sound_launch@ha
	lwz 10,36(30)
	lis 11,.LC18@ha
	stw 3,sound_launch@l(9)
	mtlr 10
	la 3,.LC18@l(11)
	blrl
	lis 9,sound_impact@ha
	lwz 10,36(30)
	lis 11,.LC19@ha
	stw 3,sound_impact@l(9)
	mtlr 10
	la 3,.LC19@l(11)
	blrl
	lis 9,sound_suck@ha
	lwz 10,36(30)
	lis 11,.LC20@ha
	stw 3,sound_suck@l(9)
	mtlr 10
	la 3,.LC20@l(11)
	blrl
	lis 9,sound_reelin@ha
	lwz 10,36(30)
	lis 11,.LC21@ha
	stw 3,sound_reelin@l(9)
	mtlr 10
	la 3,.LC21@l(11)
	blrl
	lis 9,sound_sight@ha
	lwz 10,36(30)
	lis 11,.LC22@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC22@l(11)
	blrl
	lis 9,sound_tap@ha
	lwz 10,36(30)
	lis 11,.LC23@ha
	stw 3,sound_tap@l(9)
	mtlr 10
	la 3,.LC23@l(11)
	blrl
	lis 9,sound_scratch@ha
	lwz 10,36(30)
	lis 11,.LC24@ha
	stw 3,sound_scratch@l(9)
	mtlr 10
	la 3,.LC24@l(11)
	blrl
	lis 9,sound_search@ha
	lwz 10,32(30)
	lis 11,.LC25@ha
	stw 3,sound_search@l(9)
	mtlr 10
	la 3,.LC25@l(11)
	blrl
	lis 9,parasite_pain@ha
	lis 11,parasite_die@ha
	stw 3,40(31)
	lis 10,parasite_stand@ha
	lis 8,parasite_start_walk@ha
	la 9,parasite_pain@l(9)
	la 11,parasite_die@l(11)
	la 10,parasite_stand@l(10)
	la 8,parasite_start_walk@l(8)
	stw 9,696(31)
	lis 0,0xc1c0
	stw 11,700(31)
	lis 7,parasite_start_run@ha
	stw 10,1140(31)
	lis 6,parasite_attack@ha
	lis 5,parasite_sight@ha
	stw 8,1152(31)
	lis 4,parasite_idle@ha
	li 9,175
	stw 0,196(31)
	la 7,parasite_start_run@l(7)
	la 6,parasite_attack@l(6)
	la 5,parasite_sight@l(5)
	la 4,parasite_idle@l(4)
	stw 9,728(31)
	lis 28,0xc180
	lis 27,0x4180
	stw 7,1156(31)
	lis 10,0x41c0
	li 8,5
	stw 28,192(31)
	li 11,-50
	li 0,250
	stw 27,204(31)
	li 29,2
	stw 10,208(31)
	mr 3,31
	stw 8,264(31)
	stw 29,248(31)
	stw 11,760(31)
	stw 0,644(31)
	stw 6,1164(31)
	stw 5,1172(31)
	stw 4,1144(31)
	stw 28,188(31)
	stw 27,200(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lis 9,parasite_move_stand@ha
	lis 0,0x3f80
	la 9,parasite_move_stand@l(9)
	stw 0,1136(31)
	mr 3,31
	stw 9,1124(31)
	bl walkmonster_start
.L79:
	lwz 0,132(1)
	mtlr 0
	lmw 27,108(1)
	la 1,128(1)
	blr
.Lfe3:
	.size	 SP_monster_parasite2,.Lfe3-SP_monster_parasite2
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
sound_die:
	.space	4
	.size	 sound_die,4
	.align 2
sound_launch:
	.space	4
	.size	 sound_launch,4
	.align 2
sound_impact:
	.space	4
	.size	 sound_impact,4
	.align 2
sound_suck:
	.space	4
	.size	 sound_suck,4
	.align 2
sound_reelin:
	.space	4
	.size	 sound_reelin,4
	.align 2
sound_sight:
	.space	4
	.size	 sound_sight,4
	.align 2
sound_tap:
	.space	4
	.size	 sound_tap,4
	.align 2
sound_scratch:
	.space	4
	.size	 sound_scratch,4
	.align 2
sound_search:
	.space	4
	.size	 sound_search,4
	.section	".text"
	.align 2
	.globl parasite_stand
	.type	 parasite_stand,@function
parasite_stand:
	lis 9,parasite_move_stand@ha
	la 9,parasite_move_stand@l(9)
	stw 9,1124(3)
	blr
.Lfe4:
	.size	 parasite_stand,.Lfe4-parasite_stand
	.align 2
	.globl parasite_start_run
	.type	 parasite_start_run,@function
parasite_start_run:
	lwz 0,1128(3)
	andi. 9,0,1
	bc 12,2,.L20
	lis 9,parasite_move_stand@ha
	la 9,parasite_move_stand@l(9)
	stw 9,1124(3)
	blr
.L20:
	lis 9,parasite_move_start_run@ha
	la 9,parasite_move_start_run@l(9)
	stw 9,1124(3)
	blr
.Lfe5:
	.size	 parasite_start_run,.Lfe5-parasite_start_run
	.align 2
	.globl parasite_run
	.type	 parasite_run,@function
parasite_run:
	lwz 0,1128(3)
	andi. 9,0,1
	bc 12,2,.L23
	lis 9,parasite_move_stand@ha
	la 9,parasite_move_stand@l(9)
	stw 9,1124(3)
	blr
.L23:
	lis 9,parasite_move_run@ha
	la 9,parasite_move_run@l(9)
	stw 9,1124(3)
	blr
.Lfe6:
	.size	 parasite_run,.Lfe6-parasite_run
	.align 2
	.globl parasite_walk
	.type	 parasite_walk,@function
parasite_walk:
	lis 9,parasite_move_walk@ha
	la 9,parasite_move_walk@l(9)
	stw 9,1124(3)
	blr
.Lfe7:
	.size	 parasite_walk,.Lfe7-parasite_walk
	.align 2
	.globl parasite_start_walk
	.type	 parasite_start_walk,@function
parasite_start_walk:
	lis 9,parasite_move_start_walk@ha
	la 9,parasite_move_start_walk@l(9)
	stw 9,1124(3)
	blr
.Lfe8:
	.size	 parasite_start_walk,.Lfe8-parasite_start_walk
	.align 2
	.globl parasite_end_fidget
	.type	 parasite_end_fidget,@function
parasite_end_fidget:
	lis 9,parasite_move_end_fidget@ha
	la 9,parasite_move_end_fidget@l(9)
	stw 9,1124(3)
	blr
.Lfe9:
	.size	 parasite_end_fidget,.Lfe9-parasite_end_fidget
	.align 2
	.globl parasite_do_fidget
	.type	 parasite_do_fidget,@function
parasite_do_fidget:
	lis 9,parasite_move_fidget@ha
	la 9,parasite_move_fidget@l(9)
	stw 9,1124(3)
	blr
.Lfe10:
	.size	 parasite_do_fidget,.Lfe10-parasite_do_fidget
	.section	".rodata"
	.align 2
.LC31:
	.long 0x46fffe00
	.align 3
.LC32:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC33:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl parasite_refidget
	.type	 parasite_refidget,@function
parasite_refidget:
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
	lis 11,.LC33@ha
	lis 10,.LC31@ha
	la 11,.LC33@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC32@ha
	lfs 11,.LC31@l(10)
	lfd 12,.LC32@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,0
	bc 4,3,.L15
	lis 9,parasite_move_fidget@ha
	la 9,parasite_move_fidget@l(9)
	b .L86
.L15:
	lis 9,parasite_move_end_fidget@ha
	la 9,parasite_move_end_fidget@l(9)
.L86:
	stw 9,1124(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 parasite_refidget,.Lfe11-parasite_refidget
	.section	".rodata"
	.align 2
.LC34:
	.long 0x3f800000
	.align 2
.LC35:
	.long 0x0
	.section	".text"
	.align 2
	.globl parasite_launch
	.type	 parasite_launch,@function
parasite_launch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_launch@ha
	lwz 0,gi+16@l(9)
	li 4,1
	lis 9,.LC34@ha
	lwz 5,sound_launch@l(11)
	la 9,.LC34@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	lfs 2,0(9)
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe12:
	.size	 parasite_launch,.Lfe12-parasite_launch
	.section	".rodata"
	.align 2
.LC36:
	.long 0x3f800000
	.align 2
.LC37:
	.long 0x0
	.section	".text"
	.align 2
	.globl parasite_reel_in
	.type	 parasite_reel_in,@function
parasite_reel_in:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_reelin@ha
	lwz 0,gi+16@l(9)
	li 4,1
	lis 9,.LC36@ha
	lwz 5,sound_reelin@l(11)
	la 9,.LC36@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 2,0(9)
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 parasite_reel_in,.Lfe13-parasite_reel_in
	.section	".rodata"
	.align 2
.LC38:
	.long 0x3f800000
	.align 2
.LC39:
	.long 0x0
	.section	".text"
	.align 2
	.globl parasite_sight
	.type	 parasite_sight,@function
parasite_sight:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_sight@ha
	lwz 0,gi+16@l(9)
	li 4,1
	lis 9,.LC38@ha
	lwz 5,sound_sight@l(11)
	la 9,.LC38@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 2,0(9)
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 parasite_sight,.Lfe14-parasite_sight
	.section	".rodata"
	.align 2
.LC40:
	.long 0x3f800000
	.align 2
.LC41:
	.long 0x40000000
	.align 2
.LC42:
	.long 0x0
	.section	".text"
	.align 2
	.globl parasite_tap
	.type	 parasite_tap,@function
parasite_tap:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_tap@ha
	lwz 0,gi+16@l(9)
	li 4,1
	lis 9,.LC40@ha
	lwz 5,sound_tap@l(11)
	la 9,.LC40@l(9)
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
.Lfe15:
	.size	 parasite_tap,.Lfe15-parasite_tap
	.section	".rodata"
	.align 2
.LC43:
	.long 0x3f800000
	.align 2
.LC44:
	.long 0x40000000
	.align 2
.LC45:
	.long 0x0
	.section	".text"
	.align 2
	.globl parasite_scratch
	.type	 parasite_scratch,@function
parasite_scratch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_scratch@ha
	lwz 0,gi+16@l(9)
	li 4,1
	lis 9,.LC43@ha
	lwz 5,sound_scratch@l(11)
	la 9,.LC43@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 2,0(9)
	lis 9,.LC45@ha
	la 9,.LC45@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 parasite_scratch,.Lfe16-parasite_scratch
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
	.globl parasite_search
	.type	 parasite_search,@function
parasite_search:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_search@ha
	lwz 0,gi+16@l(9)
	li 4,1
	lis 9,.LC46@ha
	lwz 5,sound_search@l(11)
	la 9,.LC46@l(9)
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
.Lfe17:
	.size	 parasite_search,.Lfe17-parasite_search
	.align 2
	.globl parasite_idle
	.type	 parasite_idle,@function
parasite_idle:
	lis 9,parasite_move_start_fidget@ha
	la 9,parasite_move_start_fidget@l(9)
	stw 9,1124(3)
	blr
.Lfe18:
	.size	 parasite_idle,.Lfe18-parasite_idle
	.section	".rodata"
	.align 2
.LC49:
	.long 0x46fffe00
	.align 2
.LC50:
	.long 0x40400000
	.align 3
.LC51:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC52:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC53:
	.long 0x3f800000
	.align 2
.LC54:
	.long 0x0
	.section	".text"
	.align 2
	.globl parasite_pain
	.type	 parasite_pain,@function
parasite_pain:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,756(31)
	lwz 11,728(31)
	srwi 9,0,31
	add 0,0,9
	srawi 0,0,1
	cmpw 0,11,0
	bc 4,0,.L28
	li 0,1
	stw 0,60(31)
.L28:
	lis 9,level+4@ha
	lfs 0,708(31)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L27
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 12,0(9)
	lis 9,skill@ha
	lwz 11,skill@l(9)
	fadds 13,13,12
	stfs 13,708(31)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L27
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC51@ha
	lis 11,.LC49@ha
	la 10,.LC51@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC52@ha
	lfs 12,.LC49@l(11)
	la 10,.LC52@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L31
	lis 9,gi+16@ha
	lis 11,sound_pain1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC54@ha
	mr 3,31
	lwz 5,sound_pain1@l(11)
	lis 9,.LC53@ha
	la 10,.LC54@l(10)
	lis 11,.LC53@ha
	la 9,.LC53@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC53@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L32
.L31:
	lis 9,gi+16@ha
	lis 11,sound_pain2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC53@ha
	mr 3,31
	lwz 5,sound_pain2@l(11)
	lis 9,.LC53@ha
	la 10,.LC53@l(10)
	lis 11,.LC54@ha
	la 9,.LC53@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC54@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L32:
	lis 9,parasite_move_pain1@ha
	la 9,parasite_move_pain1@l(9)
	stw 9,1124(31)
.L27:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 parasite_pain,.Lfe19-parasite_pain
	.align 2
	.globl parasite_attack
	.type	 parasite_attack,@function
parasite_attack:
	lis 9,parasite_move_drain@ha
	la 9,parasite_move_drain@l(9)
	stw 9,1124(3)
	blr
.Lfe20:
	.size	 parasite_attack,.Lfe20-parasite_attack
	.align 2
	.globl parasite_dead
	.type	 parasite_dead,@function
parasite_dead:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 11,0xc1c0
	lwz 0,184(9)
	lis 5,0xc180
	lis 6,0x4180
	stw 11,196(9)
	lis 8,0xc100
	li 7,7
	ori 0,0,2
	li 10,0
	stw 5,192(9)
	stw 6,204(9)
	lis 11,gi+72@ha
	stw 8,208(9)
	stw 7,264(9)
	stw 0,184(9)
	stw 10,672(9)
	stw 5,188(9)
	stw 6,200(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 parasite_dead,.Lfe21-parasite_dead
	.section	".rodata"
	.align 2
.LC55:
	.long 0x3f800000
	.align 2
.LC56:
	.long 0x0
	.section	".text"
	.align 2
	.globl parasite_die
	.type	 parasite_die,@function
parasite_die:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 31,3
	mr 28,6
	lwz 9,728(31)
	lwz 0,760(31)
	cmpw 0,9,0
	bc 12,1,.L63
	lis 29,gi@ha
	lis 3,.LC10@ha
	la 29,gi@l(29)
	la 3,.LC10@l(3)
	lwz 9,36(29)
	lis 27,.LC11@ha
	lis 26,.LC12@ha
	li 30,2
	mtlr 9
	blrl
	lis 9,.LC55@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC55@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 2,0(9)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 3,0(9)
	blrl
.L67:
	mr 3,31
	la 4,.LC11@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L67
	li 30,4
.L72:
	mr 3,31
	la 4,.LC12@l(26)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L72
	lis 4,.LC13@ha
	mr 5,28
	la 4,.LC13@l(4)
	mr 3,31
	li 6,0
	bl ThrowHead
	lwz 0,764(31)
	cmpwi 0,0,2
	bc 12,2,.L74
	lwz 11,1264(31)
	cmpwi 0,11,0
	bc 12,2,.L74
	lwz 9,932(11)
	addi 9,9,-1
	stw 9,932(11)
.L74:
	li 0,2
	stw 0,764(31)
	b .L62
.L63:
	lwz 0,764(31)
	cmpwi 0,0,2
	bc 12,2,.L62
	lis 9,gi+16@ha
	lis 11,sound_die@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC55@ha
	lwz 5,sound_die@l(11)
	la 9,.LC55@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 2,0(9)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 3,0(9)
	blrl
	lwz 10,1264(31)
	lis 9,parasite_move_death@ha
	li 0,2
	la 9,parasite_move_death@l(9)
	li 11,1
	stw 0,764(31)
	cmpwi 0,10,0
	stw 11,788(31)
	stw 9,1124(31)
	bc 12,2,.L62
	lwz 9,932(10)
	addi 9,9,-1
	stw 9,932(10)
.L62:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 parasite_die,.Lfe22-parasite_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
