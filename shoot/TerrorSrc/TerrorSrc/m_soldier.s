	.file	"m_soldier.c"
gcc2_compiled.:
	.globl soldier_frames_stand1
	.section	".data"
	.align 2
	.type	 soldier_frames_stand1,@object
soldier_frames_stand1:
	.long ai_stand
	.long 0x0
	.long soldier_idle
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
	.size	 soldier_frames_stand1,240
	.globl soldier_move_stand1
	.align 2
	.type	 soldier_move_stand1,@object
	.size	 soldier_move_stand1,16
soldier_move_stand1:
	.long 0
	.long 19
	.long soldier_frames_stand1
	.long soldier_stand
	.globl soldier_frames_stand3
	.align 2
	.type	 soldier_frames_stand3,@object
soldier_frames_stand3:
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
	.size	 soldier_frames_stand3,240
	.globl soldier_move_stand3
	.align 2
	.type	 soldier_move_stand3,@object
	.size	 soldier_move_stand3,16
soldier_move_stand3:
	.long 20
	.long 39
	.long soldier_frames_stand3
	.long soldier_stand
	.globl soldier_frames_walk1
	.align 2
	.type	 soldier_frames_walk1,@object
soldier_frames_walk1:
	.long ai_walk
	.long 0x40c00000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x40a00000
	.long 0
	.long ai_walk
	.long 0x40400000
	.long 0
	.long ai_walk
	.long 0xbf800000
	.long soldier_walk1_random
	.long ai_walk
	.long 0x0
	.long 0
	.size	 soldier_frames_walk1,72
	.globl soldier_move_walk1
	.align 2
	.type	 soldier_move_walk1,@object
	.size	 soldier_move_walk1,16
soldier_move_walk1:
	.long 40
	.long 45
	.long soldier_frames_walk1
	.long 0
	.globl soldier_frames_walk2
	.align 2
	.type	 soldier_frames_walk2,@object
soldier_frames_walk2:
	.long ai_walk
	.long 0x40c00000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x40a00000
	.long 0
	.long ai_walk
	.long 0x40400000
	.long 0
	.long ai_walk
	.long 0xbf800000
	.long soldier_walk1_random
	.long ai_walk
	.long 0x0
	.long 0
	.size	 soldier_frames_walk2,72
	.globl soldier_move_walk2
	.align 2
	.type	 soldier_move_walk2,@object
	.size	 soldier_move_walk2,16
soldier_move_walk2:
	.long 40
	.long 45
	.long soldier_frames_walk2
	.long 0
	.globl soldier_frames_start_run
	.align 2
	.type	 soldier_frames_start_run,@object
soldier_frames_start_run:
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41300000
	.long 0
	.long ai_run
	.long 0x41300000
	.long 0
	.long ai_run
	.long 0x41800000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41700000
	.long 0
	.size	 soldier_frames_start_run,72
	.globl soldier_move_start_run
	.align 2
	.type	 soldier_move_start_run,@object
	.size	 soldier_move_start_run,16
soldier_move_start_run:
	.long 40
	.long 45
	.long soldier_frames_start_run
	.long soldier_run
	.globl soldier_frames_run
	.align 2
	.type	 soldier_frames_run,@object
soldier_frames_run:
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41300000
	.long 0
	.long ai_run
	.long 0x41300000
	.long 0
	.long ai_run
	.long 0x41800000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41700000
	.long 0
	.size	 soldier_frames_run,72
	.globl soldier_move_run
	.align 2
	.type	 soldier_move_run,@object
	.size	 soldier_move_run,16
soldier_move_run:
	.long 40
	.long 45
	.long soldier_frames_run
	.long 0
	.globl soldier_frames_pain1
	.align 2
	.type	 soldier_frames_pain1,@object
soldier_frames_pain1:
	.long ai_move
	.long 0xc0400000
	.long 0
	.long ai_move
	.long 0x40800000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 soldier_frames_pain1,48
	.globl soldier_move_pain1
	.align 2
	.type	 soldier_move_pain1,@object
	.size	 soldier_move_pain1,16
soldier_move_pain1:
	.long 58
	.long 61
	.long soldier_frames_pain1
	.long soldier_run
	.globl soldier_frames_pain2
	.align 2
	.type	 soldier_frames_pain2,@object
soldier_frames_pain2:
	.long ai_move
	.long 0xc1500000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0x40800000
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.size	 soldier_frames_pain2,48
	.globl soldier_move_pain2
	.align 2
	.type	 soldier_move_pain2,@object
	.size	 soldier_move_pain2,16
soldier_move_pain2:
	.long 54
	.long 57
	.long soldier_frames_pain2
	.long soldier_run
	.globl soldier_frames_pain3
	.align 2
	.type	 soldier_frames_pain3,@object
soldier_frames_pain3:
	.long ai_move
	.long 0xc1000000
	.long 0
	.long ai_move
	.long 0xc0400000
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x40800000
	.long 0
	.size	 soldier_frames_pain3,48
	.globl soldier_move_pain3
	.align 2
	.type	 soldier_move_pain3,@object
	.size	 soldier_move_pain3,16
soldier_move_pain3:
	.long 62
	.long 65
	.long soldier_frames_pain3
	.long soldier_run
	.globl soldier_frames_pain4
	.align 2
	.type	 soldier_frames_pain4,@object
soldier_frames_pain4:
	.long ai_move
	.long 0xc1000000
	.long 0
	.long ai_move
	.long 0xc0400000
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x40800000
	.long 0
	.size	 soldier_frames_pain4,48
	.globl soldier_move_pain4
	.align 2
	.type	 soldier_move_pain4,@object
	.size	 soldier_move_pain4,16
soldier_move_pain4:
	.long 62
	.long 65
	.long soldier_frames_pain4
	.long soldier_run
	.section	".rodata"
	.align 2
.LC7:
	.long 0x46fffe00
	.align 3
.LC8:
	.long 0x3fd51eb8
	.long 0x51eb851f
	.align 3
.LC9:
	.long 0x3fe51eb8
	.long 0x51eb851f
	.align 2
.LC10:
	.long 0x42c80000
	.align 2
.LC11:
	.long 0x40400000
	.align 2
.LC12:
	.long 0x3f800000
	.align 2
.LC13:
	.long 0x0
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl soldier_pain
	.type	 soldier_pain,@function
soldier_pain:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,464(31)
	fcmpu 0,13,0
	bc 4,0,.L26
	lis 9,.LC10@ha
	lfs 13,384(31)
	la 9,.LC10@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L25
	lwz 0,772(31)
	lis 9,soldier_move_pain1@ha
	la 9,soldier_move_pain1@l(9)
	cmpw 0,0,9
	bc 12,2,.L28
	lis 9,soldier_move_pain2@ha
	la 9,soldier_move_pain2@l(9)
	cmpw 0,0,9
	bc 12,2,.L28
	lis 9,soldier_move_pain3@ha
	la 9,soldier_move_pain3@l(9)
	cmpw 0,0,9
	bc 4,2,.L25
.L28:
	lis 9,soldier_move_pain4@ha
	la 9,soldier_move_pain4@l(9)
	b .L39
.L26:
	lis 11,.LC11@ha
	lwz 0,60(31)
	la 11,.LC11@l(11)
	lfs 0,0(11)
	ori 0,0,1
	cmpwi 0,0,1
	fadds 0,13,0
	stfs 0,464(31)
	bc 4,2,.L29
	lis 9,gi+16@ha
	lis 11,sound_pain_light@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC12@ha
	lwz 5,sound_pain_light@l(11)
	b .L40
.L29:
	cmpwi 0,0,3
	bc 4,2,.L31
	lis 9,gi+16@ha
	lis 11,sound_pain@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC12@ha
	lwz 5,sound_pain@l(11)
.L40:
	la 9,.LC12@l(9)
	lis 11,.LC12@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC12@l(11)
	lis 9,.LC13@ha
	lfs 2,0(11)
	la 9,.LC13@l(9)
	lfs 3,0(9)
	blrl
	b .L30
.L31:
	lis 9,gi+16@ha
	lis 11,sound_pain_ss@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC12@ha
	lwz 5,sound_pain_ss@l(11)
	la 9,.LC12@l(9)
	lis 11,.LC12@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC12@l(11)
	lis 9,.LC13@ha
	lfs 2,0(11)
	la 9,.LC13@l(9)
	lfs 3,0(9)
	blrl
.L30:
	lis 9,.LC10@ha
	lfs 13,384(31)
	la 9,.LC10@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L33
	lis 9,soldier_move_pain4@ha
	la 9,soldier_move_pain4@l(9)
	b .L39
.L33:
	lis 9,.LC11@ha
	lis 11,skill@ha
	la 9,.LC11@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L25
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC14@ha
	lis 10,.LC7@ha
	la 11,.LC14@l(11)
	stw 0,16(1)
	lfd 12,0(11)
	lfd 0,16(1)
	lis 11,.LC8@ha
	lfs 11,.LC7@l(10)
	lfd 13,.LC8@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,11
	fmr 12,0
	fcmpu 0,12,13
	bc 4,0,.L35
	lis 9,soldier_move_pain1@ha
	la 9,soldier_move_pain1@l(9)
	b .L39
.L35:
	lis 9,.LC9@ha
	lfd 0,.LC9@l(9)
	fcmpu 0,12,0
	bc 4,0,.L37
	lis 9,soldier_move_pain2@ha
	la 9,soldier_move_pain2@l(9)
	b .L39
.L37:
	lis 9,soldier_move_pain3@ha
	la 9,soldier_move_pain3@l(9)
.L39:
	stw 9,772(31)
.L25:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 soldier_pain,.Lfe1-soldier_pain
	.section	".data"
	.align 2
	.type	 blaster_flash,@object
blaster_flash:
	.long 39
	.long 40
	.long 83
	.long 86
	.long 89
	.long 92
	.long 95
	.long 98
	.size	 blaster_flash,32
	.align 2
	.type	 shotgun_flash,@object
shotgun_flash:
	.long 41
	.long 42
	.long 84
	.long 87
	.long 90
	.long 93
	.long 96
	.long 99
	.size	 shotgun_flash,32
	.align 2
	.type	 machinegun_flash,@object
machinegun_flash:
	.long 43
	.long 44
	.long 85
	.long 88
	.long 91
	.long 94
	.long 97
	.long 100
	.size	 machinegun_flash,32
	.section	".rodata"
	.align 2
.LC15:
	.long 0x46fffe00
	.align 3
.LC16:
	.long 0x408f4000
	.long 0x0
	.align 3
.LC17:
	.long 0x407f4000
	.long 0x0
	.align 3
.LC18:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC19:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC20:
	.long 0x46000000
	.align 2
.LC21:
	.long 0x0
	.section	".text"
	.align 2
	.globl soldier_fire
	.type	 soldier_fire,@function
soldier_fire:
	stwu 1,-208(1)
	mflr 0
	stfd 28,176(1)
	stfd 29,184(1)
	stfd 30,192(1)
	stfd 31,200(1)
	stmw 23,140(1)
	stw 0,212(1)
	mr 29,4
	lis 9,blaster_flash@ha
	addi 31,1,24
	addi 30,1,40
	slwi 0,29,2
	la 9,blaster_flash@l(9)
	mr 24,3
	lwzx 23,9,0
	mr 4,31
	addi 3,24,16
	mr 5,30
	li 6,0
	bl AngleVectors
	mulli 0,23,12
	lis 4,monster_flash_offset@ha
	addi 3,24,4
	la 4,monster_flash_offset@l(4)
	mr 5,31
	add 4,0,4
	mr 6,30
	addi 7,1,8
	bl G_ProjectSource
	addi 29,29,-5
	cmplwi 0,29,1
	bc 12,1,.L42
	lfs 0,24(1)
	addi 5,1,72
	lfs 13,28(1)
	lfs 12,32(1)
	stfs 0,72(1)
	stfs 13,76(1)
	stfs 12,80(1)
	b .L43
.L42:
	lwz 9,540(24)
	lis 28,0x4330
	lfs 0,8(1)
	lis 10,.LC18@ha
	addi 26,1,72
	lfs 12,4(9)
	la 10,.LC18@l(10)
	addi 27,1,88
	lfs 10,12(1)
	addi 29,1,104
	addi 25,1,56
	lfd 31,0(10)
	mr 3,26
	mr 4,27
	stfs 12,104(1)
	lis 10,.LC19@ha
	fsubs 12,12,0
	lfs 11,16(1)
	la 10,.LC19@l(10)
	lfs 0,8(9)
	lfd 28,0(10)
	stfs 0,108(1)
	lfs 13,12(9)
	fsubs 0,0,10
	stfs 13,112(1)
	lwz 0,508(9)
	stfs 0,76(1)
	xoris 0,0,0x8000
	stfs 12,72(1)
	stw 0,132(1)
	stw 28,128(1)
	lfd 0,128(1)
	fsub 0,0,31
	frsp 0,0
	fadds 13,13,0
	fsubs 11,13,11
	stfs 13,112(1)
	stfs 11,80(1)
	bl vectoangles
	mr 6,25
	mr 4,31
	mr 5,30
	mr 3,27
	bl AngleVectors
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC15@ha
	stw 3,132(1)
	lis 11,.LC16@ha
	stw 28,128(1)
	lfd 0,128(1)
	lfs 29,.LC15@l(10)
	lfd 13,.LC16@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 30,0
	fsub 30,30,28
	fadd 30,30,30
	fmul 30,30,13
	frsp 30,30
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC17@ha
	stw 3,132(1)
	lis 10,.LC20@ha
	mr 4,31
	stw 28,128(1)
	la 10,.LC20@l(10)
	addi 3,1,8
	lfd 0,128(1)
	mr 5,29
	lfd 13,.LC17@l(11)
	lfs 1,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 31,0
	fsub 31,31,28
	fadd 31,31,31
	fmul 31,31,13
	frsp 31,31
	bl VectorMA
	fmr 1,30
	mr 4,30
	mr 3,29
	mr 5,29
	bl VectorMA
	fmr 1,31
	mr 3,29
	mr 4,25
	mr 5,3
	bl VectorMA
	lfs 11,8(1)
	mr 3,26
	lfs 12,104(1)
	lfs 13,108(1)
	lfs 10,12(1)
	fsubs 12,12,11
	lfs 0,112(1)
	lfs 11,16(1)
	fsubs 13,13,10
	stfs 12,72(1)
	fsubs 0,0,11
	stfs 13,76(1)
	stfs 0,80(1)
	bl VectorNormalize
	mr 5,26
.L43:
	lis 9,.LC21@ha
	lis 11,deathmatch@ha
	la 9,.LC21@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L44
	mr 3,24
	mr 10,23
	addi 4,1,8
	li 6,52
	li 7,150
	li 8,200
	li 9,200
	bl monster_fire_bullet
	b .L45
.L44:
	mr 3,24
	mr 10,23
	addi 4,1,8
	li 6,52
	li 7,150
	li 8,900
	li 9,900
	bl monster_fire_bullet
.L45:
	lwz 0,212(1)
	mtlr 0
	lmw 23,140(1)
	lfd 28,176(1)
	lfd 29,184(1)
	lfd 30,192(1)
	lfd 31,200(1)
	la 1,208(1)
	blr
.Lfe2:
	.size	 soldier_fire,.Lfe2-soldier_fire
	.section	".rodata"
	.align 2
.LC22:
	.string	"police"
	.globl soldier_frames_attack1
	.section	".data"
	.align 2
	.type	 soldier_frames_attack1,@object
soldier_frames_attack1:
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long soldier_fire1
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
	.long soldier_fire1
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.size	 soldier_frames_attack1,96
	.globl soldier_move_attack1
	.align 2
	.type	 soldier_move_attack1,@object
	.size	 soldier_move_attack1,16
soldier_move_attack1:
	.long 46
	.long 53
	.long soldier_frames_attack1
	.long soldier_run
	.globl soldier_frames_attack2
	.align 2
	.type	 soldier_frames_attack2,@object
soldier_frames_attack2:
	.long ai_charge
	.long 0x0
	.long soldier_fire2
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
	.long soldier_fire2
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.size	 soldier_frames_attack2,96
	.globl soldier_move_attack2
	.align 2
	.type	 soldier_move_attack2,@object
	.size	 soldier_move_attack2,16
soldier_move_attack2:
	.long 46
	.long 53
	.long soldier_frames_attack2
	.long soldier_run
	.globl soldier_frames_attack3
	.align 2
	.type	 soldier_frames_attack3,@object
soldier_frames_attack3:
	.long ai_charge
	.long 0x0
	.long soldier_fire3
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long soldier_fire3
	.long ai_charge
	.long 0x0
	.long soldier_duck_up
	.size	 soldier_frames_attack3,48
	.globl soldier_move_attack3
	.align 2
	.type	 soldier_move_attack3,@object
	.size	 soldier_move_attack3,16
soldier_move_attack3:
	.long 46
	.long 49
	.long soldier_frames_attack3
	.long soldier_run
	.globl soldier_frames_attack4
	.align 2
	.type	 soldier_frames_attack4,@object
soldier_frames_attack4:
	.long ai_charge
	.long 0x0
	.long soldier_fire4
	.long ai_charge
	.long 0x0
	.long 0
	.size	 soldier_frames_attack4,24
	.globl soldier_move_attack4
	.align 2
	.type	 soldier_move_attack4,@object
	.size	 soldier_move_attack4,16
soldier_move_attack4:
	.long 46
	.long 47
	.long soldier_frames_attack4
	.long soldier_run
	.globl soldier_frames_attack6
	.align 2
	.type	 soldier_frames_attack6,@object
soldier_frames_attack6:
	.long ai_charge
	.long 0x41400000
	.long 0
	.long ai_charge
	.long 0x41300000
	.long soldier_fire8
	.long ai_charge
	.long 0x41400000
	.long 0
	.long ai_charge
	.long 0x41880000
	.long soldier_attack6_refire
	.size	 soldier_frames_attack6,48
	.globl soldier_move_attack6
	.align 2
	.type	 soldier_move_attack6,@object
	.size	 soldier_move_attack6,16
soldier_move_attack6:
	.long 46
	.long 49
	.long soldier_frames_attack6
	.long soldier_run
	.globl soldier_frames_duck
	.align 2
	.type	 soldier_frames_duck,@object
soldier_frames_duck:
	.long ai_move
	.long 0x40a00000
	.long soldier_duck_down
	.long ai_move
	.long 0xbf800000
	.long soldier_duck_hold
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x0
	.long soldier_duck_up
	.long ai_move
	.long 0x40a00000
	.long 0
	.size	 soldier_frames_duck,60
	.globl soldier_move_duck
	.align 2
	.type	 soldier_move_duck,@object
	.size	 soldier_move_duck,16
soldier_move_duck:
	.long 135
	.long 139
	.long soldier_frames_duck
	.long soldier_run
	.section	".rodata"
	.align 2
.LC29:
	.long 0x46fffe00
	.align 3
.LC30:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC31:
	.long 0x3fd51eb8
	.long 0x51eb851f
	.align 3
.LC32:
	.long 0x3fe51eb8
	.long 0x51eb851f
	.align 3
.LC33:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC34:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC35:
	.long 0x0
	.align 2
.LC36:
	.long 0x3f800000
	.align 2
.LC37:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl soldier_dodge
	.type	 soldier_dodge,@function
soldier_dodge:
	stwu 1,-64(1)
	mflr 0
	stfd 29,40(1)
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 29,28(1)
	stw 0,68(1)
	mr 31,3
	mr 30,4
	fmr 30,1
	bl rand
	lis 29,0x4330
	lis 9,.LC33@ha
	rlwinm 3,3,0,17,31
	la 9,.LC33@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC29@ha
	lis 10,.LC34@ha
	lfs 29,.LC29@l(11)
	la 10,.LC34@l(10)
	stw 3,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	lfd 12,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 13,0,29
	fcmpu 0,13,12
	bc 12,1,.L98
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L100
	stw 30,540(31)
.L100:
	lis 9,.LC35@ha
	lis 30,skill@ha
	la 9,.LC35@l(9)
	lfs 0,0(9)
	lwz 9,skill@l(30)
	lfs 13,20(9)
	fcmpu 0,13,0
	bc 4,2,.L101
	lis 9,soldier_move_duck@ha
	la 9,soldier_move_duck@l(9)
	b .L108
.L101:
	lis 9,level+4@ha
	lis 11,.LC30@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC30@l(11)
	fadds 0,0,30
	fadd 0,0,13
	frsp 0,0
	stfs 0,828(31)
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,skill@l(30)
	xoris 3,3,0x8000
	lis 10,.LC36@ha
	stw 3,20(1)
	la 10,.LC36@l(10)
	stw 29,16(1)
	lfd 0,16(1)
	lfs 13,0(10)
	lfs 12,20(11)
	fsub 0,0,31
	fcmpu 0,12,13
	frsp 0,0
	fdivs 13,0,29
	bc 4,2,.L102
	lis 9,.LC31@ha
	lfd 0,.LC31@l(9)
	fcmpu 0,13,0
	bc 4,1,.L105
	lis 9,soldier_move_duck@ha
	la 9,soldier_move_duck@l(9)
	b .L108
.L102:
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 0,0(9)
	fcmpu 0,12,0
	cror 3,2,1
	bc 4,3,.L105
	lis 9,.LC32@ha
	lfd 0,.LC32@l(9)
	fcmpu 0,13,0
	bc 4,1,.L106
	lis 9,soldier_move_duck@ha
	la 9,soldier_move_duck@l(9)
	b .L108
.L106:
.L105:
	lis 9,soldier_move_attack3@ha
	la 9,soldier_move_attack3@l(9)
.L108:
	stw 9,772(31)
.L98:
	lwz 0,68(1)
	mtlr 0
	lmw 29,28(1)
	lfd 29,40(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 soldier_dodge,.Lfe3-soldier_dodge
	.section	".rodata"
	.align 2
.LC38:
	.string	"soldier/solpain2.wav"
	.align 2
.LC39:
	.string	"soldier/soldeth2.wav"
	.align 2
.LC40:
	.string	"models/objects/laser/tris.md2"
	.align 2
.LC41:
	.string	"misc/lasfly.wav"
	.align 2
.LC42:
	.string	"soldier/solatck2.wav"
	.align 2
.LC43:
	.string	"players/team2/w_1911.md2"
	.align 2
.LC44:
	.long 0x0
	.align 2
.LC45:
	.long 0x45fa0000
	.section	".text"
	.align 2
	.globl DM_Respawn
	.type	 DM_Respawn,@function
DM_Respawn:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	bl G_Spawn
	li 30,0
	mr 31,3
	addi 5,1,24
	addi 4,1,8
	bl SelectSpawnPoint
	lfs 13,8(1)
	lis 29,gi@ha
	mr 3,31
	la 29,gi@l(29)
	stfs 13,4(31)
	lfs 0,12(1)
	stfs 0,8(31)
	lfs 13,16(1)
	stfs 13,12(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	mr 3,31
	bl SP_monster_soldier_x
	lwz 9,36(29)
	lis 3,.LC38@ha
	la 3,.LC38@l(3)
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_pain_light@ha
	lis 11,.LC39@ha
	stw 3,sound_pain_light@l(9)
	mtlr 10
	la 3,.LC39@l(11)
	blrl
	lwz 10,32(29)
	lis 9,sound_death_light@ha
	lis 11,.LC40@ha
	stw 3,sound_death_light@l(9)
	mtlr 10
	la 3,.LC40@l(11)
	blrl
	lwz 9,36(29)
	lis 3,.LC41@ha
	la 3,.LC41@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC42@ha
	la 3,.LC42@l(3)
	mtlr 9
	blrl
	lwz 11,68(31)
	lis 0,0xfff0
	li 9,100
	ori 0,0,48577
	stw 9,480(31)
	lis 3,.LC43@ha
	ori 11,11,32768
	stw 0,488(31)
	la 3,.LC43@l(3)
	stw 11,68(31)
	stw 30,60(31)
	lwz 0,32(29)
	mtlr 0
	blrl
	lwz 9,800(31)
	stw 3,44(31)
	mtlr 9
	mr 3,31
	blrl
	lis 9,.LC44@ha
	lis 11,deathmatch@ha
	la 9,.LC44@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L110
	addi 29,31,4
	b .L111
.L113:
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L111
	stw 30,540(31)
.L111:
	lis 9,.LC45@ha
	mr 3,30
	la 9,.LC45@l(9)
	mr 4,29
	lfs 1,0(9)
	bl findradius
	mr. 30,3
	bc 4,2,.L113
.L110:
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 DM_Respawn,.Lfe4-DM_Respawn
	.globl soldier_frames_death1
	.section	".data"
	.align 2
	.type	 soldier_frames_death1,@object
soldier_frames_death1:
	.long ai_move
	.long 0xc1200000
	.long 0
	.long ai_move
	.long 0xc0a00000
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
	.size	 soldier_frames_death1,72
	.globl soldier_move_death1
	.align 2
	.type	 soldier_move_death1,@object
	.size	 soldier_move_death1,16
soldier_move_death1:
	.long 178
	.long 183
	.long soldier_frames_death1
	.long soldier_dead
	.globl soldier_frames_death2
	.align 2
	.type	 soldier_frames_death2,@object
soldier_frames_death2:
	.long ai_move
	.long 0xc0a00000
	.long 0
	.long ai_move
	.long 0xc0a00000
	.long 0
	.long ai_move
	.long 0xc0a00000
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
	.size	 soldier_frames_death2,72
	.globl soldier_move_death2
	.align 2
	.type	 soldier_move_death2,@object
	.size	 soldier_move_death2,16
soldier_move_death2:
	.long 184
	.long 189
	.long soldier_frames_death2
	.long soldier_dead
	.globl soldier_frames_death3
	.align 2
	.type	 soldier_frames_death3,@object
soldier_frames_death3:
	.long ai_move
	.long 0xc0a00000
	.long 0
	.long ai_move
	.long 0xc0a00000
	.long 0
	.long ai_move
	.long 0xc0a00000
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
	.size	 soldier_frames_death3,96
	.globl soldier_move_death3
	.align 2
	.type	 soldier_move_death3,@object
	.size	 soldier_move_death3,16
soldier_move_death3:
	.long 190
	.long 197
	.long soldier_frames_death3
	.long soldier_dead
	.section	".rodata"
	.align 2
.LC46:
	.string	"misc/udeath.wav"
	.align 2
.LC47:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC48:
	.string	"models/objects/gibs/chest/tris.md2"
	.align 2
.LC49:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC52:
	.string	"grenades"
	.align 2
.LC53:
	.string	"1911clip"
	.align 2
.LC50:
	.long 0x46fffe00
	.align 3
.LC51:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC54:
	.long 0x3f800000
	.align 2
.LC55:
	.long 0x0
	.align 3
.LC56:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl soldier_die
	.type	 soldier_die,@function
soldier_die:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 31,3
	mr 28,6
	lwz 9,480(31)
	lwz 0,488(31)
	cmpw 0,9,0
	bc 12,1,.L122
	lis 29,gi@ha
	lis 3,.LC46@ha
	la 29,gi@l(29)
	la 3,.LC46@l(3)
	lwz 9,36(29)
	lis 27,.LC47@ha
	li 30,3
	mtlr 9
	blrl
	lis 9,.LC54@ha
	lwz 0,16(29)
	lis 11,.LC54@ha
	la 9,.LC54@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC54@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC55@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC55@l(9)
	lfs 3,0(9)
	blrl
.L126:
	mr 3,31
	la 4,.LC47@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L126
	lis 4,.LC48@ha
	mr 3,31
	la 4,.LC48@l(4)
	mr 5,28
	li 6,0
	bl ThrowGib
	lis 4,.LC49@ha
	mr 5,28
	la 4,.LC49@l(4)
	mr 3,31
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,492(31)
	b .L121
.L122:
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L121
	li 9,0
	li 0,2
	stw 0,492(31)
	stw 9,44(31)
	stw 9,512(31)
	stw 9,248(31)
	bl rand
	andi. 0,3,2
	bc 12,2,.L129
	lis 9,gi+16@ha
	lis 11,sound_death_light@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC54@ha
	lwz 5,sound_death_light@l(11)
	b .L142
.L129:
	bl rand
	andi. 0,3,1
	bc 12,2,.L131
	lis 9,gi+16@ha
	lis 11,sound_death@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC54@ha
	lwz 5,sound_death@l(11)
.L142:
	la 9,.LC54@l(9)
	lis 11,.LC54@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC54@l(11)
	lis 9,.LC55@ha
	lfs 2,0(11)
	la 9,.LC55@l(9)
	lfs 3,0(9)
	blrl
	b .L130
.L131:
	lis 9,gi+16@ha
	lis 11,sound_death_ss@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC54@ha
	lwz 5,sound_death_ss@l(11)
	la 9,.LC54@l(9)
	lis 11,.LC54@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC54@l(11)
	lis 9,.LC55@ha
	lfs 2,0(11)
	la 9,.LC55@l(9)
	lfs 3,0(9)
	blrl
.L130:
	lwz 0,916(31)
	cmpwi 0,0,3
	bc 4,2,.L133
	lis 9,soldier_move_death1@ha
	la 9,soldier_move_death1@l(9)
	b .L143
.L133:
	cmpwi 0,0,2
	bc 4,2,.L135
	lis 9,soldier_move_death2@ha
	la 9,soldier_move_death2@l(9)
	b .L143
.L135:
	lis 9,soldier_move_death3@ha
	la 9,soldier_move_death3@l(9)
.L143:
	stw 9,772(31)
	lis 9,.LC55@ha
	lis 11,deathmatch@ha
	la 9,.LC55@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L137
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC56@ha
	lis 10,.LC50@ha
	la 11,.LC56@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC51@ha
	lfs 11,.LC50@l(10)
	lfd 12,.LC51@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L138
	lis 3,.LC52@ha
	la 3,.LC52@l(3)
	bl FindItem
	b .L139
.L138:
	lis 3,.LC53@ha
	la 3,.LC53@l(3)
	bl FindItem
.L139:
	mr 4,3
	mr 3,31
	bl Drop_Item
.L137:
	lis 9,deathmatch@ha
	li 0,0
	lwz 11,deathmatch@l(9)
	lis 9,.LC55@ha
	stw 0,52(31)
	la 9,.LC55@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L121
	lwz 3,540(31)
	cmpwi 0,3,0
	bc 12,2,.L121
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L121
	lwz 9,3528(3)
	addi 9,9,1
	stw 9,3528(3)
.L121:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 soldier_die,.Lfe5-soldier_die
	.section	".rodata"
	.align 2
.LC57:
	.string	"players/team2/tris.md2"
	.align 2
.LC59:
	.string	"soldier/solidle1.wav"
	.align 2
.LC60:
	.string	"soldier/solsght1.wav"
	.align 2
.LC61:
	.string	"soldier/solsrch1.wav"
	.align 2
.LC62:
	.string	"infantry/infatck3.wav"
	.align 2
.LC58:
	.long 0x3f99999a
	.align 2
.LC63:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_soldier_x
	.type	 SP_monster_soldier_x,@function
SP_monster_soldier_x:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 31,3
	la 29,gi@l(29)
	lis 3,.LC57@ha
	lwz 9,32(29)
	la 3,.LC57@l(3)
	mtlr 9
	blrl
	lis 9,.LC58@ha
	lis 7,0xc180
	stw 3,40(31)
	lfs 0,.LC58@l(9)
	lis 8,0x4180
	lis 0,0xc1c0
	lis 11,0x4200
	li 10,5
	stw 7,192(31)
	li 9,2
	stw 0,196(31)
	lis 3,.LC59@ha
	stfs 0,784(31)
	la 3,.LC59@l(3)
	stw 8,204(31)
	stw 7,188(31)
	stw 8,200(31)
	stw 11,208(31)
	stw 10,260(31)
	stw 9,248(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_idle@ha
	lis 11,.LC60@ha
	stw 3,sound_idle@l(9)
	mtlr 10
	la 3,.LC60@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sight1@ha
	lis 11,.LC61@ha
	stw 3,sound_sight1@l(9)
	mtlr 10
	la 3,.LC61@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sight2@ha
	lis 11,.LC62@ha
	stw 3,sound_sight2@l(9)
	mtlr 10
	la 3,.LC62@l(11)
	blrl
	lis 10,sound_cock@ha
	lis 9,soldier_pain@ha
	stw 3,sound_cock@l(10)
	la 9,soldier_pain@l(9)
	lis 11,soldier_die@ha
	stw 9,452(31)
	lis 8,soldier_stand@ha
	lis 7,soldier_walk@ha
	lis 10,soldier_run@ha
	lis 6,soldier_dodge@ha
	lis 5,soldier_attack@ha
	lis 4,soldier_sight@ha
	la 11,soldier_die@l(11)
	la 8,soldier_stand@l(8)
	la 7,soldier_walk@l(7)
	la 10,soldier_run@l(10)
	stw 11,456(31)
	la 6,soldier_dodge@l(6)
	la 5,soldier_attack@l(5)
	stw 8,788(31)
	la 4,soldier_sight@l(4)
	li 9,0
	stw 7,800(31)
	li 0,200
	stw 10,804(31)
	mr 3,31
	stw 6,808(31)
	stw 5,812(31)
	stw 4,820(31)
	stw 9,816(31)
	stw 0,400(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	mr 3,31
	bl walkmonster_start
	lis 9,.LC63@ha
	lis 11,deathmatch@ha
	la 9,.LC63@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L145
	lwz 0,804(31)
	mr 3,31
	mtlr 0
	blrl
.L145:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 SP_monster_soldier_x,.Lfe6-SP_monster_soldier_x
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_UZIclip,4,4
	.comm	item_9mm,4,4
	.comm	item_1911rounds,4,4
	.comm	item_50cal,4,4
	.comm	item_MARINERrounds,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_sshotgun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	ctfgame,24,4
	.comm	enemies,4,4
	.comm	spawned,4,4
	.comm	lms_round,4,4
	.comm	terror_l,4,4
	.comm	swat_l,4,4
	.comm	lms_delay,4,4
	.comm	lms_delay2,4,4
	.comm	lms_players,4,4
	.comm	lms_dead_players,4,4
	.comm	lms_alive_players,4,4
	.comm	lms_round_over,4,4
	.section	".sbss","aw",@nobits
	.align 2
sound_idle:
	.space	4
	.size	 sound_idle,4
	.align 2
sound_sight1:
	.space	4
	.size	 sound_sight1,4
	.align 2
sound_sight2:
	.space	4
	.size	 sound_sight2,4
	.align 2
sound_pain_light:
	.space	4
	.size	 sound_pain_light,4
	.align 2
sound_pain:
	.space	4
	.size	 sound_pain,4
	.align 2
sound_pain_ss:
	.space	4
	.size	 sound_pain_ss,4
	.align 2
sound_death_light:
	.space	4
	.size	 sound_death_light,4
	.align 2
sound_death:
	.space	4
	.size	 sound_death,4
	.align 2
sound_death_ss:
	.space	4
	.size	 sound_death_ss,4
	.align 2
sound_cock:
	.space	4
	.size	 sound_cock,4
	.section	".rodata"
	.align 2
.LC64:
	.long 0x46fffe00
	.align 3
.LC65:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC66:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC67:
	.long 0x3f800000
	.align 2
.LC68:
	.long 0x40000000
	.align 2
.LC69:
	.long 0x0
	.section	".text"
	.align 2
	.globl soldier_idle
	.type	 soldier_idle,@function
soldier_idle:
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
	lis 11,.LC66@ha
	lis 10,.LC64@ha
	la 11,.LC66@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC65@ha
	lfs 11,.LC64@l(10)
	lfd 12,.LC65@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L7
	lis 9,gi+16@ha
	lis 11,sound_idle@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC67@ha
	lwz 5,sound_idle@l(11)
	la 9,.LC67@l(9)
	lis 11,.LC68@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC68@l(11)
	lis 9,.LC69@ha
	lfs 2,0(11)
	la 9,.LC69@l(9)
	lfs 3,0(9)
	blrl
.L7:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 soldier_idle,.Lfe7-soldier_idle
	.section	".rodata"
	.align 2
.LC70:
	.long 0x3f800000
	.align 2
.LC71:
	.long 0x40000000
	.align 2
.LC72:
	.long 0x0
	.section	".text"
	.align 2
	.globl soldier_cock
	.type	 soldier_cock,@function
soldier_cock:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,56(3)
	cmpwi 0,0,0
	bc 4,2,.L9
	lis 9,gi+16@ha
	lis 11,sound_cock@ha
	lwz 0,gi+16@l(9)
	li 4,1
	lis 9,.LC70@ha
	lwz 5,sound_cock@l(11)
	la 9,.LC70@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC71@ha
	la 9,.LC71@l(9)
	lfs 2,0(9)
	lis 9,.LC72@ha
	la 9,.LC72@l(9)
	lfs 3,0(9)
	blrl
	b .L10
.L9:
	lis 9,gi+16@ha
	lis 11,sound_cock@ha
	lwz 0,gi+16@l(9)
	li 4,1
	lis 9,.LC70@ha
	lwz 5,sound_cock@l(11)
	la 9,.LC70@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC70@ha
	la 9,.LC70@l(9)
	lfs 2,0(9)
	lis 9,.LC72@ha
	la 9,.LC72@l(9)
	lfs 3,0(9)
	blrl
.L10:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 soldier_cock,.Lfe8-soldier_cock
	.section	".rodata"
	.align 2
.LC73:
	.long 0x46fffe00
	.align 3
.LC74:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC75:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl soldier_stand
	.type	 soldier_stand,@function
soldier_stand:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	lis 9,soldier_move_stand3@ha
	lwz 0,772(31)
	la 30,soldier_move_stand3@l(9)
	cmpw 0,0,30
	bc 12,2,.L13
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC75@ha
	lis 10,.LC73@ha
	la 11,.LC75@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC74@ha
	lfs 11,.LC73@l(10)
	lfd 12,.LC74@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L12
.L13:
	lis 9,soldier_move_stand1@ha
	la 9,soldier_move_stand1@l(9)
	stw 9,772(31)
	b .L14
.L12:
	stw 30,772(31)
.L14:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 soldier_stand,.Lfe9-soldier_stand
	.section	".rodata"
	.align 2
.LC76:
	.long 0x46fffe00
	.align 3
.LC77:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC78:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl soldier_walk1_random
	.type	 soldier_walk1_random,@function
soldier_walk1_random:
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
	lis 11,.LC78@ha
	lis 10,.LC76@ha
	la 11,.LC78@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC77@ha
	lfs 11,.LC76@l(10)
	lfd 12,.LC77@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L16
	li 0,40
	stw 0,780(31)
.L16:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 soldier_walk1_random,.Lfe10-soldier_walk1_random
	.section	".rodata"
	.align 2
.LC79:
	.long 0x46fffe00
	.align 3
.LC80:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC81:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl soldier_walk
	.type	 soldier_walk,@function
soldier_walk:
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
	lis 10,.LC80@ha
	lis 11,.LC79@ha
	la 10,.LC80@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC81@ha
	lfs 12,.LC79@l(11)
	la 10,.LC81@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L18
	lis 9,soldier_move_walk1@ha
	la 9,soldier_move_walk1@l(9)
	b .L148
.L18:
	lis 9,soldier_move_walk2@ha
	la 9,soldier_move_walk2@l(9)
.L148:
	stw 9,772(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 soldier_walk,.Lfe11-soldier_walk
	.align 2
	.globl soldier_run
	.type	 soldier_run,@function
soldier_run:
	lwz 0,776(3)
	andi. 9,0,1
	bc 12,2,.L21
	lis 9,soldier_move_stand1@ha
	la 9,soldier_move_stand1@l(9)
.L150:
	stw 9,772(3)
	blr
.L21:
	lwz 0,772(3)
	lis 9,soldier_move_walk1@ha
	la 9,soldier_move_walk1@l(9)
	cmpw 0,0,9
	bc 12,2,.L23
	lis 9,soldier_move_walk2@ha
	la 9,soldier_move_walk2@l(9)
	cmpw 0,0,9
	bc 12,2,.L23
	lis 9,soldier_move_start_run@ha
	la 9,soldier_move_start_run@l(9)
	cmpw 0,0,9
	bc 4,2,.L150
.L23:
	lis 9,soldier_move_run@ha
	la 9,soldier_move_run@l(9)
	b .L150
.Lfe12:
	.size	 soldier_run,.Lfe12-soldier_run
	.align 2
	.globl soldier_fire1
	.type	 soldier_fire1,@function
soldier_fire1:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,0
	bl soldier_fire
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 soldier_fire1,.Lfe13-soldier_fire1
	.section	".rodata"
	.align 2
.LC82:
	.long 0x46fffe00
	.align 2
.LC83:
	.long 0x40400000
	.align 3
.LC84:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC85:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl soldier_attack1_refire1
	.type	 soldier_attack1_refire1,@function
soldier_attack1_refire1:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lis 9,.LC22@ha
	lwz 0,280(31)
	la 9,.LC22@l(9)
	cmpw 0,0,9
	bc 4,2,.L47
	lwz 9,540(31)
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L47
	lis 9,.LC83@ha
	lis 11,skill@ha
	la 9,.LC83@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L52
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC84@ha
	lis 11,.LC82@ha
	la 10,.LC84@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC85@ha
	lfs 12,.LC82@l(11)
	la 10,.LC85@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L51
.L52:
	lwz 4,540(31)
	mr 3,31
	bl range
	cmpwi 0,3,0
.L51:
	li 0,46
	stw 0,780(31)
.L47:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 soldier_attack1_refire1,.Lfe14-soldier_attack1_refire1
	.section	".rodata"
	.align 2
.LC86:
	.long 0x46fffe00
	.align 2
.LC87:
	.long 0x40400000
	.align 3
.LC88:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC89:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl soldier_attack1_refire2
	.type	 soldier_attack1_refire2,@function
soldier_attack1_refire2:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,540(31)
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L54
	lis 9,.LC87@ha
	lis 11,skill@ha
	la 9,.LC87@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L58
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC88@ha
	lis 11,.LC86@ha
	la 10,.LC88@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC89@ha
	lfs 12,.LC86@l(11)
	la 10,.LC89@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L57
.L58:
	lwz 4,540(31)
	mr 3,31
	bl range
	cmpwi 0,3,0
	bc 4,2,.L54
.L57:
	li 0,46
	stw 0,780(31)
.L54:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 soldier_attack1_refire2,.Lfe15-soldier_attack1_refire2
	.align 2
	.globl soldier_fire2
	.type	 soldier_fire2,@function
soldier_fire2:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,1
	bl soldier_fire
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 soldier_fire2,.Lfe16-soldier_fire2
	.section	".rodata"
	.align 2
.LC90:
	.long 0x46fffe00
	.align 2
.LC91:
	.long 0x40400000
	.align 3
.LC92:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC93:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl soldier_attack2_refire1
	.type	 soldier_attack2_refire1,@function
soldier_attack2_refire1:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,540(31)
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L60
	lis 9,.LC91@ha
	lis 11,skill@ha
	la 9,.LC91@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L64
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC92@ha
	lis 11,.LC90@ha
	la 10,.LC92@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC93@ha
	lfs 12,.LC90@l(11)
	la 10,.LC93@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L63
.L64:
	lwz 4,540(31)
	mr 3,31
	bl range
	cmpwi 0,3,0
	bc 4,2,.L62
.L63:
	li 0,46
	b .L151
.L62:
	li 0,48
.L151:
	stw 0,780(31)
.L60:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 soldier_attack2_refire1,.Lfe17-soldier_attack2_refire1
	.section	".rodata"
	.align 2
.LC94:
	.long 0x46fffe00
	.align 2
.LC95:
	.long 0x40400000
	.align 3
.LC96:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC97:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl soldier_attack2_refire2
	.type	 soldier_attack2_refire2,@function
soldier_attack2_refire2:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,540(31)
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L66
	lis 9,.LC95@ha
	lis 11,skill@ha
	la 9,.LC95@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L70
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC96@ha
	lis 11,.LC94@ha
	la 10,.LC96@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC97@ha
	lfs 12,.LC94@l(11)
	la 10,.LC97@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L69
.L70:
	lwz 4,540(31)
	mr 3,31
	bl range
	cmpwi 0,3,0
	bc 4,2,.L66
.L69:
	li 0,50
	stw 0,780(31)
.L66:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 soldier_attack2_refire2,.Lfe18-soldier_attack2_refire2
	.section	".rodata"
	.align 2
.LC98:
	.long 0x42000000
	.align 2
.LC99:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl soldier_duck_down
	.type	 soldier_duck_down,@function
soldier_duck_down:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	lwz 0,776(10)
	andi. 9,0,2048
	bc 4,2,.L71
	lis 9,.LC98@ha
	lfs 13,208(10)
	ori 0,0,2048
	la 9,.LC98@l(9)
	stw 0,776(10)
	lis 11,level+4@ha
	lfs 0,0(9)
	li 9,1
	stw 9,512(10)
	fsubs 13,13,0
	lis 9,.LC99@ha
	la 9,.LC99@l(9)
	lfs 12,0(9)
	stfs 13,208(10)
	lis 9,gi+72@ha
	lfs 0,level+4@l(11)
	fadds 0,0,12
	stfs 0,828(10)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L71:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 soldier_duck_down,.Lfe19-soldier_duck_down
	.section	".rodata"
	.align 2
.LC100:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl soldier_duck_up
	.type	 soldier_duck_up,@function
soldier_duck_up:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC100@ha
	mr 9,3
	la 11,.LC100@l(11)
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
.Lfe20:
	.size	 soldier_duck_up,.Lfe20-soldier_duck_up
	.section	".rodata"
	.align 2
.LC101:
	.long 0x42000000
	.align 2
.LC102:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl soldier_fire3
	.type	 soldier_fire3,@function
soldier_fire3:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,776(31)
	andi. 9,0,2048
	bc 4,2,.L76
	lis 9,.LC101@ha
	lfs 13,208(31)
	ori 0,0,2048
	la 9,.LC101@l(9)
	stw 0,776(31)
	lis 11,level+4@ha
	lfs 0,0(9)
	li 9,1
	stw 9,512(31)
	fsubs 13,13,0
	lis 9,.LC102@ha
	la 9,.LC102@l(9)
	lfs 12,0(9)
	stfs 13,208(31)
	lis 9,gi+72@ha
	lfs 0,level+4@l(11)
	fadds 0,0,12
	stfs 0,828(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L76:
	mr 3,31
	li 4,2
	bl soldier_fire
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe21:
	.size	 soldier_fire3,.Lfe21-soldier_fire3
	.section	".rodata"
	.align 3
.LC103:
	.long 0x3fd99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl soldier_attack3_refire
	.type	 soldier_attack3_refire,@function
soldier_attack3_refire:
	lis 11,level+4@ha
	lis 9,.LC103@ha
	lfs 0,828(3)
	lfs 13,level+4@l(11)
	lfd 12,.LC103@l(9)
	fadd 13,13,12
	fcmpu 0,13,0
	bclr 4,0
	li 0,46
	stw 0,780(3)
	blr
.Lfe22:
	.size	 soldier_attack3_refire,.Lfe22-soldier_attack3_refire
	.align 2
	.globl soldier_fire4
	.type	 soldier_fire4,@function
soldier_fire4:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,3
	bl soldier_fire
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 soldier_fire4,.Lfe23-soldier_fire4
	.align 2
	.globl soldier_fire8
	.type	 soldier_fire8,@function
soldier_fire8:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,7
	bl soldier_fire
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 soldier_fire8,.Lfe24-soldier_fire8
	.section	".rodata"
	.align 2
.LC104:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl soldier_attack6_refire
	.type	 soldier_attack6_refire,@function
soldier_attack6_refire:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 4,540(31)
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L81
	bl range
	cmpwi 0,3,1
	bc 4,1,.L81
	lis 9,.LC104@ha
	lis 11,skill@ha
	la 9,.LC104@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L81
	li 0,46
	stw 0,780(31)
.L81:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 soldier_attack6_refire,.Lfe25-soldier_attack6_refire
	.align 2
	.globl soldier_attack
	.type	 soldier_attack,@function
soldier_attack:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl rand
	andi. 0,3,1
	bc 12,2,.L86
	lis 9,soldier_move_attack1@ha
	la 9,soldier_move_attack1@l(9)
	b .L152
.L86:
	bl rand
	andi. 0,3,2
	bc 12,2,.L88
	lis 9,soldier_move_attack2@ha
	la 9,soldier_move_attack2@l(9)
	b .L152
.L88:
	lis 9,soldier_move_attack4@ha
	la 9,soldier_move_attack4@l(9)
.L152:
	stw 9,772(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe26:
	.size	 soldier_attack,.Lfe26-soldier_attack
	.section	".rodata"
	.align 2
.LC105:
	.long 0x46fffe00
	.align 3
.LC106:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC107:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC108:
	.long 0x3f800000
	.align 2
.LC109:
	.long 0x0
	.section	".text"
	.align 2
	.globl soldier_sight
	.type	 soldier_sight,@function
soldier_sight:
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
	lis 10,.LC106@ha
	lis 11,.LC105@ha
	la 10,.LC106@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC107@ha
	lfs 12,.LC105@l(11)
	la 10,.LC107@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L91
	lis 9,gi+16@ha
	lis 11,sound_sight1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC109@ha
	mr 3,31
	lwz 5,sound_sight1@l(11)
	lis 9,.LC108@ha
	la 10,.LC109@l(10)
	lis 11,.LC108@ha
	la 9,.LC108@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC108@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L92
.L91:
	lis 9,gi+16@ha
	lis 11,sound_sight2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC108@ha
	mr 3,31
	lwz 5,sound_sight2@l(11)
	lis 9,.LC108@ha
	la 10,.LC108@l(10)
	lis 11,.LC109@ha
	la 9,.LC108@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC109@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L92:
	lis 9,.LC109@ha
	lis 11,skill@ha
	la 9,.LC109@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,1,.L93
	lwz 4,540(31)
	mr 3,31
	bl range
	cmpwi 0,3,1
	bc 4,1,.L93
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC106@ha
	lis 11,.LC105@ha
	la 10,.LC106@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC107@ha
	lfs 12,.LC105@l(11)
	la 10,.LC107@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L93
	lis 9,soldier_move_attack6@ha
	la 9,soldier_move_attack6@l(9)
	stw 9,772(31)
.L93:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 soldier_sight,.Lfe27-soldier_sight
	.align 2
	.globl soldier_duck_hold
	.type	 soldier_duck_hold,@function
soldier_duck_hold:
	lis 9,level+4@ha
	lfs 0,828(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L96
	lwz 0,776(3)
	rlwinm 0,0,0,25,23
	stw 0,776(3)
	blr
.L96:
	lwz 0,776(3)
	ori 0,0,128
	stw 0,776(3)
	blr
.Lfe28:
	.size	 soldier_duck_hold,.Lfe28-soldier_duck_hold
	.align 2
	.globl soldier_fire6
	.type	 soldier_fire6,@function
soldier_fire6:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,5
	bl soldier_fire
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 soldier_fire6,.Lfe29-soldier_fire6
	.align 2
	.globl soldier_fire7
	.type	 soldier_fire7,@function
soldier_fire7:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,6
	bl soldier_fire
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 soldier_fire7,.Lfe30-soldier_fire7
	.section	".rodata"
	.align 2
.LC110:
	.long 0x0
	.align 2
.LC111:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl soldier_dead
	.type	 soldier_dead,@function
soldier_dead:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 9,deathmatch@ha
	lwz 6,deathmatch@l(9)
	lis 11,0xc1c0
	lis 8,0xc180
	lwz 0,184(31)
	lis 7,0x4180
	lis 10,0xc100
	stw 11,196(31)
	li 9,7
	ori 0,0,2
	lis 11,.LC110@ha
	stw 8,192(31)
	la 11,.LC110@l(11)
	stw 7,204(31)
	stw 10,208(31)
	stw 9,260(31)
	stw 0,184(31)
	stw 8,188(31)
	stw 7,200(31)
	lfs 13,0(11)
	lfs 0,20(6)
	fcmpu 0,0,13
	bc 12,2,.L119
	lis 9,.LC111@ha
	lis 11,level+4@ha
	la 9,.LC111@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,436(31)
	stfs 0,428(31)
	bl DM_Respawn
	b .L120
.L119:
	stfs 13,428(31)
.L120:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe31:
	.size	 soldier_dead,.Lfe31-soldier_dead
	.section	".rodata"
	.align 2
.LC112:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_soldier_light
	.type	 SP_monster_soldier_light,@function
SP_monster_soldier_light:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 11,.LC112@ha
	lis 9,deathmatch@ha
	la 11,.LC112@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L147
	bl G_FreeEdict
	b .L146
.L147:
	mr 3,31
	bl SP_monster_soldier_x
	lis 29,gi@ha
	lis 3,.LC38@ha
	la 29,gi@l(29)
	la 3,.LC38@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_pain_light@ha
	lis 11,.LC39@ha
	stw 3,sound_pain_light@l(9)
	mtlr 10
	la 3,.LC39@l(11)
	blrl
	lwz 10,32(29)
	lis 9,sound_death_light@ha
	lis 11,.LC40@ha
	stw 3,sound_death_light@l(9)
	mtlr 10
	la 3,.LC40@l(11)
	blrl
	lwz 9,36(29)
	lis 3,.LC41@ha
	la 3,.LC41@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC42@ha
	la 3,.LC42@l(3)
	mtlr 9
	blrl
	lwz 0,68(31)
	lis 9,0xfff0
	li 11,0
	ori 9,9,48577
	li 10,100
	stw 11,60(31)
	ori 0,0,32768
	stw 10,480(31)
	lis 3,.LC43@ha
	stw 0,68(31)
	la 3,.LC43@l(3)
	stw 9,488(31)
	lwz 0,32(29)
	mtlr 0
	blrl
	stw 3,44(31)
.L146:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe32:
	.size	 SP_monster_soldier_light,.Lfe32-SP_monster_soldier_light
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
