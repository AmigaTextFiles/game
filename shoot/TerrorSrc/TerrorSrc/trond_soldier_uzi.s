	.file	"trond_soldier_uzi.c"
gcc2_compiled.:
	.globl soldier_frames_stand1_uzi
	.section	".data"
	.align 2
	.type	 soldier_frames_stand1_uzi,@object
soldier_frames_stand1_uzi:
	.long ai_stand
	.long 0x0
	.long soldier_idle_uzi
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
	.size	 soldier_frames_stand1_uzi,240
	.globl soldier_move_stand1_uzi
	.align 2
	.type	 soldier_move_stand1_uzi,@object
	.size	 soldier_move_stand1_uzi,16
soldier_move_stand1_uzi:
	.long 0
	.long 19
	.long soldier_frames_stand1_uzi
	.long soldier_stand_uzi
	.globl soldier_frames_stand3_uzi
	.align 2
	.type	 soldier_frames_stand3_uzi,@object
soldier_frames_stand3_uzi:
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
	.size	 soldier_frames_stand3_uzi,240
	.globl soldier_move_stand3_uzi
	.align 2
	.type	 soldier_move_stand3_uzi,@object
	.size	 soldier_move_stand3_uzi,16
soldier_move_stand3_uzi:
	.long 20
	.long 39
	.long soldier_frames_stand3_uzi
	.long soldier_stand_uzi
	.globl soldier_frames_walk1_uzi
	.align 2
	.type	 soldier_frames_walk1_uzi,@object
soldier_frames_walk1_uzi:
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
	.long soldier_walk1_random_uzi
	.long ai_walk
	.long 0x0
	.long 0
	.size	 soldier_frames_walk1_uzi,72
	.globl soldier_move_walk1_uzi
	.align 2
	.type	 soldier_move_walk1_uzi,@object
	.size	 soldier_move_walk1_uzi,16
soldier_move_walk1_uzi:
	.long 40
	.long 45
	.long soldier_frames_walk1_uzi
	.long 0
	.globl soldier_frames_walk2_uzi
	.align 2
	.type	 soldier_frames_walk2_uzi,@object
soldier_frames_walk2_uzi:
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
	.long soldier_walk1_random_uzi
	.long ai_walk
	.long 0x0
	.long 0
	.size	 soldier_frames_walk2_uzi,72
	.globl soldier_move_walk2_uzi
	.align 2
	.type	 soldier_move_walk2_uzi,@object
	.size	 soldier_move_walk2_uzi,16
soldier_move_walk2_uzi:
	.long 40
	.long 45
	.long soldier_frames_walk2_uzi
	.long 0
	.globl soldier_frames_start_run_uzi
	.align 2
	.type	 soldier_frames_start_run_uzi,@object
soldier_frames_start_run_uzi:
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
	.size	 soldier_frames_start_run_uzi,72
	.globl soldier_move_start_run_uzi
	.align 2
	.type	 soldier_move_start_run_uzi,@object
	.size	 soldier_move_start_run_uzi,16
soldier_move_start_run_uzi:
	.long 40
	.long 45
	.long soldier_frames_start_run_uzi
	.long soldier_run_uzi
	.globl soldier_frames_run_uzi
	.align 2
	.type	 soldier_frames_run_uzi,@object
soldier_frames_run_uzi:
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
	.size	 soldier_frames_run_uzi,72
	.globl soldier_move_run_uzi
	.align 2
	.type	 soldier_move_run_uzi,@object
	.size	 soldier_move_run_uzi,16
soldier_move_run_uzi:
	.long 40
	.long 45
	.long soldier_frames_run_uzi
	.long 0
	.globl soldier_frames_pain1_uzi
	.align 2
	.type	 soldier_frames_pain1_uzi,@object
soldier_frames_pain1_uzi:
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
	.size	 soldier_frames_pain1_uzi,48
	.globl soldier_move_pain1_uzi
	.align 2
	.type	 soldier_move_pain1_uzi,@object
	.size	 soldier_move_pain1_uzi,16
soldier_move_pain1_uzi:
	.long 58
	.long 61
	.long soldier_frames_pain1_uzi
	.long soldier_run_uzi
	.globl soldier_frames_pain2_uzi
	.align 2
	.type	 soldier_frames_pain2_uzi,@object
soldier_frames_pain2_uzi:
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
	.size	 soldier_frames_pain2_uzi,48
	.globl soldier_move_pain2_uzi
	.align 2
	.type	 soldier_move_pain2_uzi,@object
	.size	 soldier_move_pain2_uzi,16
soldier_move_pain2_uzi:
	.long 54
	.long 57
	.long soldier_frames_pain2_uzi
	.long soldier_run_uzi
	.globl soldier_frames_pain3_uzi
	.align 2
	.type	 soldier_frames_pain3_uzi,@object
soldier_frames_pain3_uzi:
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
	.size	 soldier_frames_pain3_uzi,48
	.globl soldier_move_pain3_uzi
	.align 2
	.type	 soldier_move_pain3_uzi,@object
	.size	 soldier_move_pain3_uzi,16
soldier_move_pain3_uzi:
	.long 62
	.long 65
	.long soldier_frames_pain3_uzi
	.long soldier_run_uzi
	.globl soldier_frames_pain4_uzi
	.align 2
	.type	 soldier_frames_pain4_uzi,@object
soldier_frames_pain4_uzi:
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
	.size	 soldier_frames_pain4_uzi,48
	.globl soldier_move_pain4_uzi
	.align 2
	.type	 soldier_move_pain4_uzi,@object
	.size	 soldier_move_pain4_uzi,16
soldier_move_pain4_uzi:
	.long 62
	.long 65
	.long soldier_frames_pain4_uzi
	.long soldier_run_uzi
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
	.globl soldier_pain_uzi
	.type	 soldier_pain_uzi,@function
soldier_pain_uzi:
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
	lis 9,soldier_move_pain1_uzi@ha
	la 9,soldier_move_pain1_uzi@l(9)
	cmpw 0,0,9
	bc 12,2,.L28
	lis 9,soldier_move_pain2_uzi@ha
	la 9,soldier_move_pain2_uzi@l(9)
	cmpw 0,0,9
	bc 12,2,.L28
	lis 9,soldier_move_pain3_uzi@ha
	la 9,soldier_move_pain3_uzi@l(9)
	cmpw 0,0,9
	bc 4,2,.L25
.L28:
	lis 9,soldier_move_pain4_uzi@ha
	la 9,soldier_move_pain4_uzi@l(9)
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
	lis 9,soldier_move_pain4_uzi@ha
	la 9,soldier_move_pain4_uzi@l(9)
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
	lis 9,soldier_move_pain1_uzi@ha
	la 9,soldier_move_pain1_uzi@l(9)
	b .L39
.L35:
	lis 9,.LC9@ha
	lfd 0,.LC9@l(9)
	fcmpu 0,12,0
	bc 4,0,.L37
	lis 9,soldier_move_pain2_uzi@ha
	la 9,soldier_move_pain2_uzi@l(9)
	b .L39
.L37:
	lis 9,soldier_move_pain3_uzi@ha
	la 9,soldier_move_pain3_uzi@l(9)
.L39:
	stw 9,772(31)
.L25:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 soldier_pain_uzi,.Lfe1-soldier_pain_uzi
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
	.globl soldier_fire_uzi
	.type	 soldier_fire_uzi,@function
soldier_fire_uzi:
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
	li 6,25
	li 7,150
	li 8,200
	li 9,200
	bl monster_fire_uzi
	b .L45
.L44:
	mr 3,24
	mr 10,23
	addi 4,1,8
	li 6,25
	li 7,150
	li 8,900
	li 9,900
	bl monster_fire_uzi
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
	.size	 soldier_fire_uzi,.Lfe2-soldier_fire_uzi
	.globl soldier_frames_attack1_uzi
	.section	".data"
	.align 2
	.type	 soldier_frames_attack1_uzi,@object
soldier_frames_attack1_uzi:
	.long ai_charge
	.long 0x0
	.long soldier_fire1_uzi
	.long ai_charge
	.long 0x0
	.long soldier_fire1_uzi
	.long ai_charge
	.long 0x0
	.long soldier_fire1_uzi
	.long ai_charge
	.long 0x0
	.long soldier_fire1_uzi
	.long ai_charge
	.long 0x0
	.long soldier_fire1_uzi
	.long ai_charge
	.long 0x0
	.long soldier_fire1_uzi
	.long ai_charge
	.long 0x0
	.long soldier_fire1_uzi
	.long ai_charge
	.long 0x0
	.long soldier_fire1_uzi
	.size	 soldier_frames_attack1_uzi,96
	.globl soldier_move_attack1_uzi
	.align 2
	.type	 soldier_move_attack1_uzi,@object
	.size	 soldier_move_attack1_uzi,16
soldier_move_attack1_uzi:
	.long 46
	.long 53
	.long soldier_frames_attack1_uzi
	.long soldier_run_uzi
	.globl soldier_frames_attack2_uzi
	.align 2
	.type	 soldier_frames_attack2_uzi,@object
soldier_frames_attack2_uzi:
	.long ai_charge
	.long 0x0
	.long soldier_fire2_uzi
	.long ai_charge
	.long 0x0
	.long soldier_fire2_uzi
	.long ai_charge
	.long 0x0
	.long soldier_fire2_uzi
	.long ai_charge
	.long 0x0
	.long soldier_fire2_uzi
	.long ai_charge
	.long 0x0
	.long soldier_fire2_uzi
	.long ai_charge
	.long 0x0
	.long soldier_fire2_uzi
	.long ai_charge
	.long 0x0
	.long soldier_fire2_uzi
	.long ai_charge
	.long 0x0
	.long soldier_fire2_uzi
	.size	 soldier_frames_attack2_uzi,96
	.globl soldier_move_attack2_uzi
	.align 2
	.type	 soldier_move_attack2_uzi,@object
	.size	 soldier_move_attack2_uzi,16
soldier_move_attack2_uzi:
	.long 46
	.long 53
	.long soldier_frames_attack2_uzi
	.long soldier_run_uzi
	.globl soldier_frames_attack3_uzi
	.align 2
	.type	 soldier_frames_attack3_uzi,@object
soldier_frames_attack3_uzi:
	.long ai_charge
	.long 0x0
	.long soldier_fire3_uzi
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long soldier_fire3_uzi
	.long ai_charge
	.long 0x0
	.long soldier_duck_up_uzi
	.size	 soldier_frames_attack3_uzi,48
	.globl soldier_move_attack3_uzi
	.align 2
	.type	 soldier_move_attack3_uzi,@object
	.size	 soldier_move_attack3_uzi,16
soldier_move_attack3_uzi:
	.long 46
	.long 49
	.long soldier_frames_attack3_uzi
	.long soldier_run_uzi
	.globl soldier_frames_attack4_uzi
	.align 2
	.type	 soldier_frames_attack4_uzi,@object
soldier_frames_attack4_uzi:
	.long ai_charge
	.long 0x0
	.long soldier_fire4_uzi
	.long ai_charge
	.long 0x0
	.long 0
	.size	 soldier_frames_attack4_uzi,24
	.globl soldier_move_attack4_uzi
	.align 2
	.type	 soldier_move_attack4_uzi,@object
	.size	 soldier_move_attack4_uzi,16
soldier_move_attack4_uzi:
	.long 46
	.long 47
	.long soldier_frames_attack4_uzi
	.long soldier_run_uzi
	.globl soldier_frames_attack6_uzi
	.align 2
	.type	 soldier_frames_attack6_uzi,@object
soldier_frames_attack6_uzi:
	.long ai_charge
	.long 0x41400000
	.long 0
	.long ai_charge
	.long 0x41300000
	.long soldier_fire8_uzi
	.long ai_charge
	.long 0x41400000
	.long 0
	.long ai_charge
	.long 0x41880000
	.long soldier_attack6_refire_uzi
	.size	 soldier_frames_attack6_uzi,48
	.globl soldier_move_attack6_uzi
	.align 2
	.type	 soldier_move_attack6_uzi,@object
	.size	 soldier_move_attack6_uzi,16
soldier_move_attack6_uzi:
	.long 46
	.long 49
	.long soldier_frames_attack6_uzi
	.long soldier_run_uzi
	.globl soldier_frames_duck_uzi
	.align 2
	.type	 soldier_frames_duck_uzi,@object
soldier_frames_duck_uzi:
	.long ai_move
	.long 0x40a00000
	.long soldier_duck_down_uzi
	.long ai_move
	.long 0xbf800000
	.long soldier_duck_hold_uzi
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x0
	.long soldier_duck_up_uzi
	.long ai_move
	.long 0x40a00000
	.long 0
	.size	 soldier_frames_duck_uzi,60
	.globl soldier_move_duck_uzi
	.align 2
	.type	 soldier_move_duck_uzi,@object
	.size	 soldier_move_duck_uzi,16
soldier_move_duck_uzi:
	.long 135
	.long 139
	.long soldier_frames_duck_uzi
	.long soldier_run_uzi
	.section	".rodata"
	.align 2
.LC28:
	.long 0x46fffe00
	.align 3
.LC29:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC30:
	.long 0x3fd51eb8
	.long 0x51eb851f
	.align 3
.LC31:
	.long 0x3fe51eb8
	.long 0x51eb851f
	.align 3
.LC32:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC33:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC34:
	.long 0x0
	.align 2
.LC35:
	.long 0x3f800000
	.align 2
.LC36:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl soldier_dodge_uzi
	.type	 soldier_dodge_uzi,@function
soldier_dodge_uzi:
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
	lis 9,.LC32@ha
	rlwinm 3,3,0,17,31
	la 9,.LC32@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC28@ha
	lis 10,.LC33@ha
	lfs 29,.LC28@l(11)
	la 10,.LC33@l(10)
	stw 3,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	lfd 12,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 13,0,29
	fcmpu 0,13,12
	bc 12,1,.L97
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L99
	stw 30,540(31)
.L99:
	lis 9,.LC34@ha
	lis 30,skill@ha
	la 9,.LC34@l(9)
	lfs 0,0(9)
	lwz 9,skill@l(30)
	lfs 13,20(9)
	fcmpu 0,13,0
	bc 4,2,.L100
	lis 9,soldier_move_duck_uzi@ha
	la 9,soldier_move_duck_uzi@l(9)
	b .L107
.L100:
	lis 9,level+4@ha
	lis 11,.LC29@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC29@l(11)
	fadds 0,0,30
	fadd 0,0,13
	frsp 0,0
	stfs 0,828(31)
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,skill@l(30)
	xoris 3,3,0x8000
	lis 10,.LC35@ha
	stw 3,20(1)
	la 10,.LC35@l(10)
	stw 29,16(1)
	lfd 0,16(1)
	lfs 13,0(10)
	lfs 12,20(11)
	fsub 0,0,31
	fcmpu 0,12,13
	frsp 0,0
	fdivs 13,0,29
	bc 4,2,.L101
	lis 9,.LC30@ha
	lfd 0,.LC30@l(9)
	fcmpu 0,13,0
	bc 4,1,.L104
	lis 9,soldier_move_duck_uzi@ha
	la 9,soldier_move_duck_uzi@l(9)
	b .L107
.L101:
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 0,0(9)
	fcmpu 0,12,0
	cror 3,2,1
	bc 4,3,.L104
	lis 9,.LC31@ha
	lfd 0,.LC31@l(9)
	fcmpu 0,13,0
	bc 4,1,.L105
	lis 9,soldier_move_duck_uzi@ha
	la 9,soldier_move_duck_uzi@l(9)
	b .L107
.L105:
.L104:
	lis 9,soldier_move_attack3_uzi@ha
	la 9,soldier_move_attack3_uzi@l(9)
.L107:
	stw 9,772(31)
.L97:
	lwz 0,68(1)
	mtlr 0
	lmw 29,28(1)
	lfd 29,40(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 soldier_dodge_uzi,.Lfe3-soldier_dodge_uzi
	.section	".rodata"
	.align 2
.LC37:
	.string	"soldier/solpain2.wav"
	.align 2
.LC38:
	.string	"soldier/soldeth2.wav"
	.align 2
.LC39:
	.string	"models/objects/laser/tris.md2"
	.align 2
.LC40:
	.string	"misc/lasfly.wav"
	.align 2
.LC41:
	.string	"soldier/solatck2.wav"
	.align 2
.LC42:
	.string	"police"
	.align 2
.LC43:
	.string	"players/messiah/w_uzi.md2"
	.align 2
.LC44:
	.long 0x0
	.align 2
.LC45:
	.long 0x45fa0000
	.section	".text"
	.align 2
	.globl DM_Respawn_Uzi
	.type	 DM_Respawn_Uzi,@function
DM_Respawn_Uzi:
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
	bl SP_monster_soldier_uzi_x
	lwz 9,36(29)
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_pain_light@ha
	lis 11,.LC38@ha
	stw 3,sound_pain_light@l(9)
	mtlr 10
	la 3,.LC38@l(11)
	blrl
	lwz 10,32(29)
	lis 9,sound_death_light@ha
	lis 11,.LC39@ha
	stw 3,sound_death_light@l(9)
	mtlr 10
	la 3,.LC39@l(11)
	blrl
	lwz 9,36(29)
	lis 3,.LC40@ha
	la 3,.LC40@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC41@ha
	la 3,.LC41@l(3)
	mtlr 9
	blrl
	lwz 0,68(31)
	lis 9,.LC42@ha
	lis 11,0xfff0
	ori 11,11,48577
	la 9,.LC42@l(9)
	stw 30,60(31)
	ori 0,0,32768
	li 10,100
	stw 11,488(31)
	stw 9,280(31)
	lis 3,.LC43@ha
	stw 10,480(31)
	la 3,.LC43@l(3)
	stw 0,68(31)
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
	bc 12,2,.L109
	addi 29,31,4
	b .L110
.L112:
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L110
	stw 30,540(31)
.L110:
	lis 9,.LC45@ha
	mr 3,30
	la 9,.LC45@l(9)
	mr 4,29
	lfs 1,0(9)
	bl findradius
	mr. 30,3
	bc 4,2,.L112
.L109:
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 DM_Respawn_Uzi,.Lfe4-DM_Respawn_Uzi
	.globl soldier_frames_death1_uzi
	.section	".data"
	.align 2
	.type	 soldier_frames_death1_uzi,@object
soldier_frames_death1_uzi:
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
	.size	 soldier_frames_death1_uzi,72
	.globl soldier_move_death1_uzi
	.align 2
	.type	 soldier_move_death1_uzi,@object
	.size	 soldier_move_death1_uzi,16
soldier_move_death1_uzi:
	.long 178
	.long 183
	.long soldier_frames_death1_uzi
	.long soldier_dead_uzi
	.globl soldier_frames_death2_uzi
	.align 2
	.type	 soldier_frames_death2_uzi,@object
soldier_frames_death2_uzi:
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
	.size	 soldier_frames_death2_uzi,72
	.globl soldier_move_death2_uzi
	.align 2
	.type	 soldier_move_death2_uzi,@object
	.size	 soldier_move_death2_uzi,16
soldier_move_death2_uzi:
	.long 184
	.long 189
	.long soldier_frames_death2_uzi
	.long soldier_dead_uzi
	.globl soldier_frames_death3_uzi
	.align 2
	.type	 soldier_frames_death3_uzi,@object
soldier_frames_death3_uzi:
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
	.size	 soldier_frames_death3_uzi,96
	.globl soldier_move_death3_uzi
	.align 2
	.type	 soldier_move_death3_uzi,@object
	.size	 soldier_move_death3_uzi,16
soldier_move_death3_uzi:
	.long 190
	.long 197
	.long soldier_frames_death3_uzi
	.long soldier_dead_uzi
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
.LC50:
	.string	"uzi"
	.align 2
.LC51:
	.string	"uziclip"
	.align 2
.LC52:
	.long 0x3f800000
	.align 2
.LC53:
	.long 0x0
	.section	".text"
	.align 2
	.globl soldier_die_uzi
	.type	 soldier_die_uzi,@function
soldier_die_uzi:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	mr 28,6
	lwz 9,480(31)
	lwz 0,488(31)
	cmpw 0,9,0
	bc 12,1,.L121
	lis 29,gi@ha
	lis 3,.LC46@ha
	la 29,gi@l(29)
	la 3,.LC46@l(3)
	lwz 9,36(29)
	lis 27,.LC47@ha
	li 30,3
	mtlr 9
	blrl
	lis 9,.LC52@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC52@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 2,0(9)
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	lfs 3,0(9)
	blrl
.L125:
	mr 3,31
	la 4,.LC47@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L125
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
	b .L120
.L121:
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L120
	li 9,0
	li 0,2
	stw 0,492(31)
	stw 9,44(31)
	stw 9,512(31)
	stw 9,248(31)
	bl rand
	andi. 0,3,2
	bc 12,2,.L128
	lis 9,gi+16@ha
	lis 11,sound_death_light@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC52@ha
	lwz 5,sound_death_light@l(11)
	b .L147
.L128:
	bl rand
	andi. 0,3,1
	bc 12,2,.L130
	lis 9,gi+16@ha
	lis 11,sound_death@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC52@ha
	lwz 5,sound_death@l(11)
.L147:
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
	b .L129
.L130:
	lis 9,gi+16@ha
	lis 11,sound_death_ss@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC52@ha
	lwz 5,sound_death_ss@l(11)
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
.L129:
	lwz 0,916(31)
	cmpwi 0,0,3
	bc 4,2,.L132
	lis 9,soldier_move_death1_uzi@ha
	la 9,soldier_move_death1_uzi@l(9)
	b .L148
.L132:
	cmpwi 0,0,2
	bc 4,2,.L134
	lis 9,soldier_move_death2_uzi@ha
	la 9,soldier_move_death2_uzi@l(9)
	b .L148
.L134:
	lis 9,soldier_move_death3_uzi@ha
	la 9,soldier_move_death3_uzi@l(9)
.L148:
	stw 9,772(31)
	lis 9,.LC53@ha
	lis 11,deathmatch@ha
	la 9,.LC53@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L136
	bl rand
	andi. 0,3,1
	bc 12,2,.L137
	lis 3,.LC50@ha
	la 3,.LC50@l(3)
	bl FindItem
	b .L138
.L137:
	lis 3,.LC51@ha
	la 3,.LC51@l(3)
	bl FindItem
.L138:
	mr 4,3
	mr 3,31
	bl Drop_Item
	mr 29,3
	bl rand
	andi. 0,3,3
	bc 12,2,.L139
	li 0,5
	b .L149
.L139:
	bl rand
	andi. 0,3,2
	bc 12,2,.L141
	li 0,12
	b .L149
.L141:
	bl rand
	andi. 0,3,1
	li 0,27
	bc 12,2,.L143
	li 0,19
.L143:
.L149:
	stw 0,924(29)
.L136:
	lis 9,.LC53@ha
	lis 11,deathmatch@ha
	la 9,.LC53@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L120
	lwz 3,540(31)
	cmpwi 0,3,0
	bc 12,2,.L120
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L120
	lwz 9,3528(3)
	addi 9,9,1
	stw 9,3528(3)
.L120:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 soldier_die_uzi,.Lfe5-soldier_die_uzi
	.section	".rodata"
	.align 2
.LC54:
	.string	"players/messiah/tris.md2"
	.align 2
.LC56:
	.string	"soldier/solidle1.wav"
	.align 2
.LC57:
	.string	"soldier/solsght1.wav"
	.align 2
.LC58:
	.string	"soldier/solsrch1.wav"
	.align 2
.LC59:
	.string	"infantry/infatck3.wav"
	.align 2
.LC55:
	.long 0x3f99999a
	.align 2
.LC60:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_soldier_uzi_x
	.type	 SP_monster_soldier_uzi_x,@function
SP_monster_soldier_uzi_x:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 31,3
	la 29,gi@l(29)
	lis 3,.LC54@ha
	lwz 9,32(29)
	la 3,.LC54@l(3)
	mtlr 9
	blrl
	lis 9,.LC55@ha
	lis 7,0xc180
	stw 3,40(31)
	lfs 0,.LC55@l(9)
	lis 8,0x4180
	lis 0,0xc1c0
	lis 11,0x4200
	li 10,5
	stw 7,192(31)
	li 9,2
	stw 0,196(31)
	lis 3,.LC56@ha
	stfs 0,784(31)
	la 3,.LC56@l(3)
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
	lis 11,.LC57@ha
	stw 3,sound_idle@l(9)
	mtlr 10
	la 3,.LC57@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sight1@ha
	lis 11,.LC58@ha
	stw 3,sound_sight1@l(9)
	mtlr 10
	la 3,.LC58@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sight2@ha
	lis 11,.LC59@ha
	stw 3,sound_sight2@l(9)
	mtlr 10
	la 3,.LC59@l(11)
	blrl
	lis 10,sound_cock@ha
	lis 9,soldier_pain_uzi@ha
	stw 3,sound_cock@l(10)
	la 9,soldier_pain_uzi@l(9)
	lis 11,soldier_die_uzi@ha
	stw 9,452(31)
	lis 8,soldier_stand_uzi@ha
	lis 7,soldier_walk_uzi@ha
	lis 10,soldier_run_uzi@ha
	lis 6,soldier_dodge_uzi@ha
	lis 5,soldier_attack_uzi@ha
	lis 4,soldier_sight_uzi@ha
	la 11,soldier_die_uzi@l(11)
	la 8,soldier_stand_uzi@l(8)
	la 7,soldier_walk_uzi@l(7)
	la 10,soldier_run_uzi@l(10)
	stw 11,456(31)
	la 6,soldier_dodge_uzi@l(6)
	la 5,soldier_attack_uzi@l(5)
	stw 8,788(31)
	la 4,soldier_sight_uzi@l(4)
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
	lis 9,.LC60@ha
	lis 11,deathmatch@ha
	la 9,.LC60@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L151
	lwz 0,804(31)
	mr 3,31
	mtlr 0
	blrl
.L151:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 SP_monster_soldier_uzi_x,.Lfe6-SP_monster_soldier_uzi_x
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
.LC61:
	.long 0x46fffe00
	.align 3
.LC62:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC63:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC64:
	.long 0x3f800000
	.align 2
.LC65:
	.long 0x40000000
	.align 2
.LC66:
	.long 0x0
	.section	".text"
	.align 2
	.globl soldier_idle_uzi
	.type	 soldier_idle_uzi,@function
soldier_idle_uzi:
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
	lis 11,.LC63@ha
	lis 10,.LC61@ha
	la 11,.LC63@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC62@ha
	lfs 11,.LC61@l(10)
	lfd 12,.LC62@l(11)
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
	lis 9,.LC64@ha
	lwz 5,sound_idle@l(11)
	la 9,.LC64@l(9)
	lis 11,.LC65@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC65@l(11)
	lis 9,.LC66@ha
	lfs 2,0(11)
	la 9,.LC66@l(9)
	lfs 3,0(9)
	blrl
.L7:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 soldier_idle_uzi,.Lfe7-soldier_idle_uzi
	.section	".rodata"
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
	.globl soldier_cock_uzi
	.type	 soldier_cock_uzi,@function
soldier_cock_uzi:
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
	lis 9,.LC67@ha
	lwz 5,sound_cock@l(11)
	la 9,.LC67@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC68@ha
	la 9,.LC68@l(9)
	lfs 2,0(9)
	lis 9,.LC69@ha
	la 9,.LC69@l(9)
	lfs 3,0(9)
	blrl
	b .L10
.L9:
	lis 9,gi+16@ha
	lis 11,sound_cock@ha
	lwz 0,gi+16@l(9)
	li 4,1
	lis 9,.LC67@ha
	lwz 5,sound_cock@l(11)
	la 9,.LC67@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC67@ha
	la 9,.LC67@l(9)
	lfs 2,0(9)
	lis 9,.LC69@ha
	la 9,.LC69@l(9)
	lfs 3,0(9)
	blrl
.L10:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 soldier_cock_uzi,.Lfe8-soldier_cock_uzi
	.section	".rodata"
	.align 2
.LC70:
	.long 0x46fffe00
	.align 3
.LC71:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC72:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl soldier_stand_uzi
	.type	 soldier_stand_uzi,@function
soldier_stand_uzi:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	lis 9,soldier_move_stand3_uzi@ha
	lwz 0,772(31)
	la 30,soldier_move_stand3_uzi@l(9)
	cmpw 0,0,30
	bc 12,2,.L13
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC72@ha
	lis 10,.LC70@ha
	la 11,.LC72@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC71@ha
	lfs 11,.LC70@l(10)
	lfd 12,.LC71@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L12
.L13:
	lis 9,soldier_move_stand1_uzi@ha
	la 9,soldier_move_stand1_uzi@l(9)
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
	.size	 soldier_stand_uzi,.Lfe9-soldier_stand_uzi
	.section	".rodata"
	.align 2
.LC73:
	.long 0x46fffe00
	.align 3
.LC74:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC75:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl soldier_walk1_random_uzi
	.type	 soldier_walk1_random_uzi,@function
soldier_walk1_random_uzi:
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
	.size	 soldier_walk1_random_uzi,.Lfe10-soldier_walk1_random_uzi
	.section	".rodata"
	.align 2
.LC76:
	.long 0x46fffe00
	.align 3
.LC77:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC78:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl soldier_walk_uzi
	.type	 soldier_walk_uzi,@function
soldier_walk_uzi:
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
	lis 10,.LC77@ha
	lis 11,.LC76@ha
	la 10,.LC77@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC78@ha
	lfs 12,.LC76@l(11)
	la 10,.LC78@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L18
	lis 9,soldier_move_walk1_uzi@ha
	la 9,soldier_move_walk1_uzi@l(9)
	b .L154
.L18:
	lis 9,soldier_move_walk2_uzi@ha
	la 9,soldier_move_walk2_uzi@l(9)
.L154:
	stw 9,772(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 soldier_walk_uzi,.Lfe11-soldier_walk_uzi
	.align 2
	.globl soldier_run_uzi
	.type	 soldier_run_uzi,@function
soldier_run_uzi:
	lwz 0,776(3)
	andi. 9,0,1
	bc 12,2,.L21
	lis 9,soldier_move_stand1_uzi@ha
	la 9,soldier_move_stand1_uzi@l(9)
.L156:
	stw 9,772(3)
	blr
.L21:
	lwz 0,772(3)
	lis 9,soldier_move_walk1_uzi@ha
	la 9,soldier_move_walk1_uzi@l(9)
	cmpw 0,0,9
	bc 12,2,.L23
	lis 9,soldier_move_walk2_uzi@ha
	la 9,soldier_move_walk2_uzi@l(9)
	cmpw 0,0,9
	bc 12,2,.L23
	lis 9,soldier_move_start_run_uzi@ha
	la 9,soldier_move_start_run_uzi@l(9)
	cmpw 0,0,9
	bc 4,2,.L156
.L23:
	lis 9,soldier_move_run_uzi@ha
	la 9,soldier_move_run_uzi@l(9)
	b .L156
.Lfe12:
	.size	 soldier_run_uzi,.Lfe12-soldier_run_uzi
	.align 2
	.globl soldier_fire1_uzi
	.type	 soldier_fire1_uzi,@function
soldier_fire1_uzi:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,0
	bl soldier_fire_uzi
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 soldier_fire1_uzi,.Lfe13-soldier_fire1_uzi
	.align 2
	.globl soldier_attack1_refire1_uzi
	.type	 soldier_attack1_refire1_uzi,@function
soldier_attack1_refire1_uzi:
	blr
.Lfe14:
	.size	 soldier_attack1_refire1_uzi,.Lfe14-soldier_attack1_refire1_uzi
	.section	".rodata"
	.align 2
.LC80:
	.long 0x46fffe00
	.align 2
.LC81:
	.long 0x40400000
	.align 3
.LC82:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC83:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl soldier_attack1_refire2_uzi
	.type	 soldier_attack1_refire2_uzi,@function
soldier_attack1_refire2_uzi:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,540(31)
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L53
	lis 9,.LC81@ha
	lis 11,skill@ha
	la 9,.LC81@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L57
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC82@ha
	lis 11,.LC80@ha
	la 10,.LC82@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC83@ha
	lfs 12,.LC80@l(11)
	la 10,.LC83@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L56
.L57:
	lwz 4,540(31)
	mr 3,31
	bl range
	cmpwi 0,3,0
	bc 4,2,.L53
.L56:
	li 0,46
	stw 0,780(31)
.L53:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 soldier_attack1_refire2_uzi,.Lfe15-soldier_attack1_refire2_uzi
	.align 2
	.globl soldier_fire2_uzi
	.type	 soldier_fire2_uzi,@function
soldier_fire2_uzi:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,1
	bl soldier_fire_uzi
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 soldier_fire2_uzi,.Lfe16-soldier_fire2_uzi
	.section	".rodata"
	.align 2
.LC84:
	.long 0x46fffe00
	.align 2
.LC85:
	.long 0x40400000
	.align 3
.LC86:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC87:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl soldier_attack2_refire1_uzi
	.type	 soldier_attack2_refire1_uzi,@function
soldier_attack2_refire1_uzi:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,540(31)
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L59
	lis 9,.LC85@ha
	lis 11,skill@ha
	la 9,.LC85@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L63
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC86@ha
	lis 11,.LC84@ha
	la 10,.LC86@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC87@ha
	lfs 12,.LC84@l(11)
	la 10,.LC87@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L62
.L63:
	lwz 4,540(31)
	mr 3,31
	bl range
	cmpwi 0,3,0
	bc 4,2,.L61
.L62:
	li 0,46
	b .L157
.L61:
	li 0,48
.L157:
	stw 0,780(31)
.L59:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 soldier_attack2_refire1_uzi,.Lfe17-soldier_attack2_refire1_uzi
	.section	".rodata"
	.align 2
.LC88:
	.long 0x46fffe00
	.align 2
.LC89:
	.long 0x40400000
	.align 3
.LC90:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC91:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl soldier_attack2_refire2_uzi
	.type	 soldier_attack2_refire2_uzi,@function
soldier_attack2_refire2_uzi:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,540(31)
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L65
	lis 9,.LC89@ha
	lis 11,skill@ha
	la 9,.LC89@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L69
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC90@ha
	lis 11,.LC88@ha
	la 10,.LC90@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC91@ha
	lfs 12,.LC88@l(11)
	la 10,.LC91@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L68
.L69:
	lwz 4,540(31)
	mr 3,31
	bl range
	cmpwi 0,3,0
	bc 4,2,.L65
.L68:
	li 0,50
	stw 0,780(31)
.L65:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 soldier_attack2_refire2_uzi,.Lfe18-soldier_attack2_refire2_uzi
	.section	".rodata"
	.align 2
.LC92:
	.long 0x42000000
	.align 2
.LC93:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl soldier_duck_down_uzi
	.type	 soldier_duck_down_uzi,@function
soldier_duck_down_uzi:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	lwz 0,776(10)
	andi. 9,0,2048
	bc 4,2,.L70
	lis 9,.LC92@ha
	lfs 13,208(10)
	ori 0,0,2048
	la 9,.LC92@l(9)
	stw 0,776(10)
	lis 11,level+4@ha
	lfs 0,0(9)
	li 9,1
	stw 9,512(10)
	fsubs 13,13,0
	lis 9,.LC93@ha
	la 9,.LC93@l(9)
	lfs 12,0(9)
	stfs 13,208(10)
	lis 9,gi+72@ha
	lfs 0,level+4@l(11)
	fadds 0,0,12
	stfs 0,828(10)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L70:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 soldier_duck_down_uzi,.Lfe19-soldier_duck_down_uzi
	.section	".rodata"
	.align 2
.LC94:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl soldier_duck_up_uzi
	.type	 soldier_duck_up_uzi,@function
soldier_duck_up_uzi:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC94@ha
	mr 9,3
	la 11,.LC94@l(11)
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
	.size	 soldier_duck_up_uzi,.Lfe20-soldier_duck_up_uzi
	.section	".rodata"
	.align 2
.LC95:
	.long 0x42000000
	.align 2
.LC96:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl soldier_fire3_uzi
	.type	 soldier_fire3_uzi,@function
soldier_fire3_uzi:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,776(31)
	andi. 9,0,2048
	bc 4,2,.L75
	lis 9,.LC95@ha
	lfs 13,208(31)
	ori 0,0,2048
	la 9,.LC95@l(9)
	stw 0,776(31)
	lis 11,level+4@ha
	lfs 0,0(9)
	li 9,1
	stw 9,512(31)
	fsubs 13,13,0
	lis 9,.LC96@ha
	la 9,.LC96@l(9)
	lfs 12,0(9)
	stfs 13,208(31)
	lis 9,gi+72@ha
	lfs 0,level+4@l(11)
	fadds 0,0,12
	stfs 0,828(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L75:
	mr 3,31
	li 4,2
	bl soldier_fire_uzi
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe21:
	.size	 soldier_fire3_uzi,.Lfe21-soldier_fire3_uzi
	.section	".rodata"
	.align 3
.LC97:
	.long 0x3fd99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl soldier_attack3_refire_uzi
	.type	 soldier_attack3_refire_uzi,@function
soldier_attack3_refire_uzi:
	lis 11,level+4@ha
	lis 9,.LC97@ha
	lfs 0,828(3)
	lfs 13,level+4@l(11)
	lfd 12,.LC97@l(9)
	fadd 13,13,12
	fcmpu 0,13,0
	bclr 4,0
	li 0,46
	stw 0,780(3)
	blr
.Lfe22:
	.size	 soldier_attack3_refire_uzi,.Lfe22-soldier_attack3_refire_uzi
	.align 2
	.globl soldier_fire4_uzi
	.type	 soldier_fire4_uzi,@function
soldier_fire4_uzi:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,3
	bl soldier_fire_uzi
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 soldier_fire4_uzi,.Lfe23-soldier_fire4_uzi
	.align 2
	.globl soldier_fire8_uzi
	.type	 soldier_fire8_uzi,@function
soldier_fire8_uzi:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,7
	bl soldier_fire_uzi
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 soldier_fire8_uzi,.Lfe24-soldier_fire8_uzi
	.section	".rodata"
	.align 2
.LC98:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl soldier_attack6_refire_uzi
	.type	 soldier_attack6_refire_uzi,@function
soldier_attack6_refire_uzi:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 4,540(31)
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L80
	bl range
	cmpwi 0,3,1
	bc 4,1,.L80
	lis 9,.LC98@ha
	lis 11,skill@ha
	la 9,.LC98@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L80
	li 0,46
	stw 0,780(31)
.L80:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 soldier_attack6_refire_uzi,.Lfe25-soldier_attack6_refire_uzi
	.align 2
	.globl soldier_attack_uzi
	.type	 soldier_attack_uzi,@function
soldier_attack_uzi:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl rand
	andi. 0,3,1
	bc 12,2,.L85
	lis 9,soldier_move_attack1_uzi@ha
	la 9,soldier_move_attack1_uzi@l(9)
	b .L158
.L85:
	bl rand
	andi. 0,3,2
	bc 12,2,.L87
	lis 9,soldier_move_attack2_uzi@ha
	la 9,soldier_move_attack2_uzi@l(9)
	b .L158
.L87:
	lis 9,soldier_move_attack4_uzi@ha
	la 9,soldier_move_attack4_uzi@l(9)
.L158:
	stw 9,772(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe26:
	.size	 soldier_attack_uzi,.Lfe26-soldier_attack_uzi
	.section	".rodata"
	.align 2
.LC99:
	.long 0x46fffe00
	.align 3
.LC100:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC101:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC102:
	.long 0x3f800000
	.align 2
.LC103:
	.long 0x0
	.section	".text"
	.align 2
	.globl soldier_sight_uzi
	.type	 soldier_sight_uzi,@function
soldier_sight_uzi:
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
	lis 10,.LC100@ha
	lis 11,.LC99@ha
	la 10,.LC100@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC101@ha
	lfs 12,.LC99@l(11)
	la 10,.LC101@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L90
	lis 9,gi+16@ha
	lis 11,sound_sight1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC103@ha
	mr 3,31
	lwz 5,sound_sight1@l(11)
	lis 9,.LC102@ha
	la 10,.LC103@l(10)
	lis 11,.LC102@ha
	la 9,.LC102@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC102@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L91
.L90:
	lis 9,gi+16@ha
	lis 11,sound_sight2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC102@ha
	mr 3,31
	lwz 5,sound_sight2@l(11)
	lis 9,.LC102@ha
	la 10,.LC102@l(10)
	lis 11,.LC103@ha
	la 9,.LC102@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC103@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L91:
	lis 9,.LC103@ha
	lis 11,skill@ha
	la 9,.LC103@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,1,.L92
	lwz 4,540(31)
	mr 3,31
	bl range
	cmpwi 0,3,1
	bc 4,1,.L92
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC100@ha
	lis 11,.LC99@ha
	la 10,.LC100@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC101@ha
	lfs 12,.LC99@l(11)
	la 10,.LC101@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L92
	lis 9,soldier_move_attack6_uzi@ha
	la 9,soldier_move_attack6_uzi@l(9)
	stw 9,772(31)
.L92:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 soldier_sight_uzi,.Lfe27-soldier_sight_uzi
	.align 2
	.globl soldier_duck_hold_uzi
	.type	 soldier_duck_hold_uzi,@function
soldier_duck_hold_uzi:
	lis 9,level+4@ha
	lfs 0,828(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L95
	lwz 0,776(3)
	rlwinm 0,0,0,25,23
	stw 0,776(3)
	blr
.L95:
	lwz 0,776(3)
	ori 0,0,128
	stw 0,776(3)
	blr
.Lfe28:
	.size	 soldier_duck_hold_uzi,.Lfe28-soldier_duck_hold_uzi
	.align 2
	.globl soldier_fire6_uzi
	.type	 soldier_fire6_uzi,@function
soldier_fire6_uzi:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,5
	bl soldier_fire_uzi
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 soldier_fire6_uzi,.Lfe29-soldier_fire6_uzi
	.align 2
	.globl soldier_fire7_uzi
	.type	 soldier_fire7_uzi,@function
soldier_fire7_uzi:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,6
	bl soldier_fire_uzi
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 soldier_fire7_uzi,.Lfe30-soldier_fire7_uzi
	.section	".rodata"
	.align 2
.LC104:
	.long 0x0
	.align 2
.LC105:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl soldier_dead_uzi
	.type	 soldier_dead_uzi,@function
soldier_dead_uzi:
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
	lis 11,.LC104@ha
	stw 8,192(31)
	la 11,.LC104@l(11)
	stw 7,204(31)
	stw 10,208(31)
	stw 9,260(31)
	stw 0,184(31)
	stw 8,188(31)
	stw 7,200(31)
	lfs 13,0(11)
	lfs 0,20(6)
	fcmpu 0,0,13
	bc 12,2,.L118
	lis 9,.LC105@ha
	lis 11,level+4@ha
	la 9,.LC105@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,436(31)
	stfs 0,428(31)
	bl DM_Respawn_Uzi
	b .L119
.L118:
	stfs 13,428(31)
.L119:
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
	.size	 soldier_dead_uzi,.Lfe31-soldier_dead_uzi
	.section	".rodata"
	.align 2
.LC106:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_soldier_uzi
	.type	 SP_monster_soldier_uzi,@function
SP_monster_soldier_uzi:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 11,.LC106@ha
	lis 9,deathmatch@ha
	la 11,.LC106@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L153
	bl G_FreeEdict
	b .L152
.L153:
	mr 3,31
	bl SP_monster_soldier_uzi_x
	lis 29,gi@ha
	lis 3,.LC37@ha
	la 29,gi@l(29)
	la 3,.LC37@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_pain_light@ha
	lis 11,.LC38@ha
	stw 3,sound_pain_light@l(9)
	mtlr 10
	la 3,.LC38@l(11)
	blrl
	lwz 10,32(29)
	lis 9,sound_death_light@ha
	lis 11,.LC39@ha
	stw 3,sound_death_light@l(9)
	mtlr 10
	la 3,.LC39@l(11)
	blrl
	lwz 9,36(29)
	lis 3,.LC40@ha
	la 3,.LC40@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC41@ha
	la 3,.LC41@l(3)
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
.L152:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe32:
	.size	 SP_monster_soldier_uzi,.Lfe32-SP_monster_soldier_uzi
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
