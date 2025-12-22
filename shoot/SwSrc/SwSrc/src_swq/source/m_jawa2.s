	.file	"m_jawa2.c"
gcc2_compiled.:
	.globl jawa2_frames_stand2
	.section	".data"
	.align 2
	.type	 jawa2_frames_stand2,@object
jawa2_frames_stand2:
	.long ai_stand
	.long 0x0
	.long 0
	.size	 jawa2_frames_stand2,12
	.globl jawa2_move_stand2
	.align 2
	.type	 jawa2_move_stand2,@object
	.size	 jawa2_move_stand2,16
jawa2_move_stand2:
	.long 0
	.long 0
	.long jawa2_frames_stand2
	.long jawa2_stand
	.globl jawa2_frames_stand1
	.align 2
	.type	 jawa2_frames_stand1,@object
jawa2_frames_stand1:
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.size	 jawa2_frames_stand1,180
	.globl jawa2_move_stand1
	.align 2
	.type	 jawa2_move_stand1,@object
	.size	 jawa2_move_stand1,16
jawa2_move_stand1:
	.long 0
	.long 14
	.long jawa2_frames_stand1
	.long jawa2_stand
	.globl jawa2_frames_idle1
	.align 2
	.type	 jawa2_frames_idle1,@object
jawa2_frames_idle1:
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.size	 jawa2_frames_idle1,72
	.globl jawa2_move_idle1
	.align 2
	.type	 jawa2_move_idle1,@object
	.size	 jawa2_move_idle1,16
jawa2_move_idle1:
	.long 33
	.long 38
	.long jawa2_frames_idle1
	.long jawa2_stand
	.section	".rodata"
	.align 2
.LC0:
	.long 0x46fffe00
	.align 3
.LC1:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC2:
	.long 0x3fea8f5c
	.long 0x28f5c28f
	.align 3
.LC3:
	.long 0x3fe51eb8
	.long 0x51eb851f
	.align 3
.LC4:
	.long 0x3fdf5c28
	.long 0xf5c28f5c
	.align 3
.LC5:
	.long 0x3fd47ae1
	.long 0x47ae147b
	.align 3
.LC6:
	.long 0x3fc33333
	.long 0x33333333
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC8:
	.long 0x3f800000
	.align 2
.LC9:
	.long 0x40000000
	.align 2
.LC10:
	.long 0x0
	.section	".text"
	.align 2
	.globl jawa2_slacking_talk
	.type	 jawa2_slacking_talk,@function
jawa2_slacking_talk:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 30,24(1)
	stw 0,52(1)
	mr 31,3
	lis 30,0x4330
	bl rand
	lis 9,.LC7@ha
	rlwinm 3,3,0,17,31
	la 9,.LC7@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 10,.LC0@ha
	lis 11,.LC1@ha
	lfs 30,.LC0@l(10)
	stw 3,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	lfd 12,.LC1@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 12,0,.L6
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC2@ha
	stw 3,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	lfd 13,.LC2@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 12,0
	fcmpu 0,12,13
	bc 4,1,.L8
	lis 9,gi+16@ha
	lis 11,sound_talk1@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC8@ha
	lwz 5,sound_talk1@l(11)
	b .L18
.L8:
	lis 9,.LC3@ha
	lfd 0,.LC3@l(9)
	fcmpu 0,12,0
	bc 4,1,.L10
	lis 9,gi+16@ha
	lis 11,sound_talk2@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC8@ha
	lwz 5,sound_talk2@l(11)
	b .L18
.L10:
	lis 9,.LC4@ha
	lfd 0,.LC4@l(9)
	fcmpu 0,12,0
	bc 4,1,.L12
	lis 9,gi+16@ha
	lis 11,sound_talk3@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC8@ha
	lwz 5,sound_talk3@l(11)
	b .L18
.L12:
	lis 9,.LC5@ha
	lfd 0,.LC5@l(9)
	fcmpu 0,12,0
	bc 4,1,.L14
	lis 9,gi+16@ha
	lis 11,sound_agree@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC8@ha
	lwz 5,sound_agree@l(11)
	b .L18
.L14:
	lis 9,.LC6@ha
	lfd 0,.LC6@l(9)
	fcmpu 0,12,0
	bc 4,1,.L16
	lis 9,gi+16@ha
	lis 11,sound_talk5@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC8@ha
	lwz 5,sound_talk5@l(11)
.L18:
	la 9,.LC8@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 2,0(9)
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 3,0(9)
	blrl
	b .L6
.L16:
	lis 9,gi+16@ha
	lis 11,sound_talk6@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC8@ha
	lwz 5,sound_talk6@l(11)
	la 9,.LC8@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 2,0(9)
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 3,0(9)
	blrl
.L6:
	lwz 0,52(1)
	mtlr 0
	lmw 30,24(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 jawa2_slacking_talk,.Lfe1-jawa2_slacking_talk
	.globl jawa2_frames_drink1
	.section	".data"
	.align 2
	.type	 jawa2_frames_drink1,@object
jawa2_frames_drink1:
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long jawa2_slacking_talk
	.size	 jawa2_frames_drink1,96
	.globl jawa2_move_drink1
	.align 2
	.type	 jawa2_move_drink1,@object
	.size	 jawa2_move_drink1,16
jawa2_move_drink1:
	.long 25
	.long 32
	.long jawa2_frames_drink1
	.long jawa2_stand
	.globl jawa2_frames_slacking1
	.align 2
	.type	 jawa2_frames_slacking1,@object
jawa2_frames_slacking1:
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long jawa2_slacking_talk
	.size	 jawa2_frames_slacking1,120
	.globl jawa2_move_slacking1
	.align 2
	.type	 jawa2_move_slacking1,@object
	.size	 jawa2_move_slacking1,16
jawa2_move_slacking1:
	.long 15
	.long 24
	.long jawa2_frames_slacking1
	.long jawa2_stand
	.globl jawa2_frames_workwall1
	.align 2
	.type	 jawa2_frames_workwall1,@object
jawa2_frames_workwall1:
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long jawa2_work_talk
	.size	 jawa2_frames_workwall1,180
	.globl jawa2_move_workwall1
	.align 2
	.type	 jawa2_move_workwall1,@object
	.size	 jawa2_move_workwall1,16
jawa2_move_workwall1:
	.long 39
	.long 53
	.long jawa2_frames_workwall1
	.long jawa2_stand
	.section	".rodata"
	.align 2
.LC14:
	.long 0x46fffe00
	.align 3
.LC15:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC16:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC17:
	.long 0x41c00000
	.align 2
.LC18:
	.long 0x41000000
	.align 2
.LC19:
	.long 0x41900000
	.align 2
.LC20:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl jawa2_workfloor_sparks
	.type	 jawa2_workfloor_sparks,@function
jawa2_workfloor_sparks:
	stwu 1,-96(1)
	mflr 0
	stmw 28,80(1)
	stw 0,100(1)
	mr 31,3
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,76(1)
	lis 11,.LC16@ha
	lis 10,.LC14@ha
	la 11,.LC16@l(11)
	stw 0,72(1)
	lfd 13,0(11)
	lfd 0,72(1)
	lis 11,.LC15@ha
	lfs 11,.LC14@l(10)
	lfd 12,.LC15@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 12,0,.L24
	lis 9,.LC17@ha
	lfs 0,12(31)
	addi 29,1,40
	la 9,.LC17@l(9)
	lfs 11,4(31)
	addi 28,1,24
	lfs 13,0(9)
	li 6,0
	mr 5,29
	lfs 12,8(31)
	addi 3,31,16
	mr 4,28
	stfs 11,8(1)
	fsubs 0,0,13
	stfs 12,12(1)
	stfs 0,16(1)
	bl AngleVectors
	lis 9,.LC18@ha
	addi 3,1,8
	la 9,.LC18@l(9)
	mr 4,29
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lis 9,.LC19@ha
	addi 3,1,8
	la 9,.LC19@l(9)
	mr 4,28
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lis 9,.LC20@ha
	lfs 13,32(1)
	lis 29,gi@ha
	la 9,.LC20@l(9)
	la 29,gi@l(29)
	lfs 12,24(1)
	lfs 0,0(9)
	li 3,3
	lwz 9,100(29)
	stfs 12,56(1)
	fadds 13,13,0
	mtlr 9
	lfs 0,28(1)
	stfs 13,64(1)
	stfs 0,60(1)
	blrl
	lwz 9,100(29)
	li 3,15
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,30
	mtlr 9
	blrl
	lwz 9,120(29)
	addi 3,1,8
	mtlr 9
	blrl
	lwz 9,124(29)
	addi 3,1,56
	mtlr 9
	blrl
	lwz 9,100(29)
	lis 3,0xd0d1
	ori 3,3,53971
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,1,8
	li 4,2
	mtlr 0
	blrl
.L24:
	lwz 0,100(1)
	mtlr 0
	lmw 28,80(1)
	la 1,96(1)
	blr
.Lfe2:
	.size	 jawa2_workfloor_sparks,.Lfe2-jawa2_workfloor_sparks
	.globl jawa2_frames_workfloor1
	.section	".data"
	.align 2
	.type	 jawa2_frames_workfloor1,@object
jawa2_frames_workfloor1:
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long jawa2_workfloor_sparks
	.long ai_stand
	.long 0x0
	.long jawa2_work_talk
	.size	 jawa2_frames_workfloor1,72
	.globl jawa2_move_workfloor1
	.align 2
	.type	 jawa2_move_workfloor1,@object
	.size	 jawa2_move_workfloor1,16
jawa2_move_workfloor1:
	.long 54
	.long 59
	.long jawa2_frames_workfloor1
	.long jawa2_stand
	.globl jawa2_frames_frust1
	.align 2
	.type	 jawa2_frames_frust1,@object
jawa2_frames_frust1:
	.long ai_stand
	.long 0x0
	.long jawa2_frust_talk
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long jawa2_workfloor_sparks
	.size	 jawa2_frames_frust1,48
	.globl jawa2_move_frust1
	.align 2
	.type	 jawa2_move_frust1,@object
	.size	 jawa2_move_frust1,16
jawa2_move_frust1:
	.long 60
	.long 63
	.long jawa2_frames_frust1
	.long jawa2_stand
	.globl jawa2_frames_sweat1
	.align 2
	.type	 jawa2_frames_sweat1,@object
jawa2_frames_sweat1:
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.size	 jawa2_frames_sweat1,72
	.globl jawa2_move_sweat1
	.align 2
	.type	 jawa2_move_sweat1,@object
	.size	 jawa2_move_sweat1,16
jawa2_move_sweat1:
	.long 64
	.long 69
	.long jawa2_frames_sweat1
	.long jawa2_stand
	.section	".rodata"
	.align 2
.LC21:
	.long 0x46fffe00
	.align 3
.LC22:
	.long 0x3fb1eb85
	.long 0x1eb851ec
	.align 3
.LC23:
	.long 0x3f9eb851
	.long 0xeb851eb8
	.align 3
.LC24:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC25:
	.long 0x3f847ae1
	.long 0x47ae147b
	.align 3
.LC26:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl jawa2_stand
	.type	 jawa2_stand,@function
jawa2_stand:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	bl rand
	rlwinm 3,3,0,17,31
	lwz 10,284(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC26@ha
	la 11,.LC26@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	andi. 0,10,1
	lfd 0,16(1)
	lis 11,.LC21@ha
	lfs 12,.LC21@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	bc 12,2,.L27
	lis 9,jawa2_move_workwall1@ha
	la 9,jawa2_move_workwall1@l(9)
	b .L44
.L27:
	andi. 11,10,8
	bc 12,2,.L29
	fmr 13,0
	lis 9,.LC22@ha
	lfd 0,.LC22@l(9)
	fcmpu 0,13,0
	bc 4,1,.L30
	lis 9,jawa2_move_workfloor1@ha
	la 9,jawa2_move_workfloor1@l(9)
	b .L44
.L30:
	lis 9,.LC23@ha
	lfd 0,.LC23@l(9)
	fcmpu 0,13,0
	bc 4,0,.L32
	lis 9,jawa2_move_frust1@ha
	la 9,jawa2_move_frust1@l(9)
	b .L44
.L32:
	lis 9,jawa2_move_sweat1@ha
	la 9,jawa2_move_sweat1@l(9)
	b .L44
.L29:
	andi. 0,10,4
	bc 12,2,.L35
	fmr 13,0
	lis 9,.LC24@ha
	lfd 0,.LC24@l(9)
	fcmpu 0,13,0
	bc 4,1,.L36
	lis 9,jawa2_move_slacking1@ha
	la 9,jawa2_move_slacking1@l(9)
	b .L44
.L36:
	lis 9,.LC23@ha
	lfd 0,.LC23@l(9)
	fcmpu 0,13,0
	bc 4,0,.L28
	lis 9,jawa2_move_drink1@ha
	la 9,jawa2_move_drink1@l(9)
	b .L44
.L35:
	fmr 13,0
	lis 9,.LC25@ha
	lfd 0,.LC25@l(9)
	fcmpu 0,13,0
	bc 4,0,.L40
	lis 9,jawa2_move_stand1@ha
	la 9,jawa2_move_stand1@l(9)
	b .L44
.L40:
	lis 9,.LC23@ha
	lfd 0,.LC23@l(9)
	fcmpu 0,13,0
	bc 4,0,.L42
	lis 9,jawa2_move_idle1@ha
	la 9,jawa2_move_idle1@l(9)
	b .L44
.L42:
	lis 9,jawa2_move_stand2@ha
	la 9,jawa2_move_stand2@l(9)
.L44:
	stw 9,772(31)
.L28:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 jawa2_stand,.Lfe3-jawa2_stand
	.globl jawa2_frames_walk1
	.section	".data"
	.align 2
	.type	 jawa2_frames_walk1,@object
jawa2_frames_walk1:
	.long ai_walk
	.long 0x40400000
	.long 0
	.long ai_walk
	.long 0x40c00000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x40400000
	.long 0
	.long ai_walk
	.long 0x40c00000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x40400000
	.long 0
	.long ai_walk
	.long 0x40c00000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.size	 jawa2_frames_walk1,144
	.globl jawa2_move_walk1
	.align 2
	.type	 jawa2_move_walk1,@object
	.size	 jawa2_move_walk1,16
jawa2_move_walk1:
	.long 70
	.long 81
	.long jawa2_frames_walk1
	.long 0
	.globl jawa2_frames_run1
	.align 2
	.type	 jawa2_frames_run1,@object
jawa2_frames_run1:
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
	.size	 jawa2_frames_run1,72
	.globl jawa2_move_run1
	.align 2
	.type	 jawa2_move_run1,@object
	.size	 jawa2_move_run1,16
jawa2_move_run1:
	.long 82
	.long 87
	.long jawa2_frames_run1
	.long 0
	.globl jawa2_frames_pain1
	.align 2
	.type	 jawa2_frames_pain1,@object
jawa2_frames_pain1:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 jawa2_frames_pain1,36
	.globl jawa2_move_pain1
	.align 2
	.type	 jawa2_move_pain1,@object
	.size	 jawa2_move_pain1,16
jawa2_move_pain1:
	.long 88
	.long 90
	.long jawa2_frames_pain1
	.long jawa2_run
	.globl jawa2_frames_death1
	.align 2
	.type	 jawa2_frames_death1,@object
jawa2_frames_death1:
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
	.size	 jawa2_frames_death1,228
	.globl jawa2_move_death1
	.align 2
	.type	 jawa2_move_death1,@object
	.size	 jawa2_move_death1,16
jawa2_move_death1:
	.long 91
	.long 109
	.long jawa2_frames_death1
	.long jawa2_dead
	.globl jawa2_frames_death2
	.align 2
	.type	 jawa2_frames_death2,@object
jawa2_frames_death2:
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
	.size	 jawa2_frames_death2,108
	.globl jawa2_move_death2
	.align 2
	.type	 jawa2_move_death2,@object
	.size	 jawa2_move_death2,16
jawa2_move_death2:
	.long 110
	.long 118
	.long jawa2_frames_death2
	.long jawa2_dead
	.section	".rodata"
	.align 2
.LC28:
	.string	"misc/udeath.wav"
	.align 2
.LC29:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC30:
	.string	"models/objects/gibs/chest/tris.md2"
	.align 2
.LC31:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC32:
	.long 0x46fffe00
	.align 2
.LC33:
	.long 0x0
	.align 2
.LC34:
	.long 0x3f800000
	.align 2
.LC35:
	.long 0x40400000
	.align 3
.LC36:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC37:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl jawa2_die
	.type	 jawa2_die,@function
jawa2_die:
	stwu 1,-64(1)
	mflr 0
	stfd 29,40(1)
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 28,24(1)
	stw 0,68(1)
	mr 31,3
	mr 30,6
	lwz 9,480(31)
	lwz 0,488(31)
	cmpw 0,9,0
	bc 12,1,.L58
	lis 29,gi@ha
	lis 9,.LC33@ha
	la 29,gi@l(29)
	la 9,.LC33@l(9)
	lwz 11,36(29)
	lis 3,.LC28@ha
	lis 10,.LC34@ha
	lfs 31,0(9)
	la 3,.LC28@l(3)
	la 10,.LC34@l(10)
	mtlr 11
	lis 9,.LC35@ha
	lfs 29,0(10)
	lis 28,.LC29@ha
	la 9,.LC35@l(9)
	lfs 30,0(9)
	blrl
	lwz 0,16(29)
	lis 9,.LC34@ha
	lis 10,.LC34@ha
	lis 11,.LC33@ha
	mr 5,3
	la 9,.LC34@l(9)
	la 10,.LC34@l(10)
	mtlr 0
	la 11,.LC33@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L62:
	fadds 31,31,29
	mr 3,31
	la 4,.LC29@l(28)
	mr 5,30
	li 6,0
	bl ThrowGib
	fcmpu 0,31,30
	bc 12,0,.L62
	lis 4,.LC30@ha
	mr 3,31
	la 4,.LC30@l(4)
	mr 5,30
	li 6,0
	bl ThrowGib
	lis 4,.LC31@ha
	mr 5,30
	la 4,.LC31@l(4)
	mr 3,31
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,492(31)
	b .L57
.L58:
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L57
	li 0,2
	li 9,1
	stw 0,492(31)
	stw 9,512(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC36@ha
	lis 11,.LC32@ha
	la 10,.LC36@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC37@ha
	lfs 12,.LC32@l(11)
	la 10,.LC37@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 31,0,12
	fmr 13,31
	fcmpu 0,13,11
	cror 3,2,1
	bc 4,3,.L65
	lis 9,gi+16@ha
	lis 11,sound_cry1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC33@ha
	mr 3,31
	lwz 5,sound_cry1@l(11)
	lis 9,.LC34@ha
	la 10,.LC33@l(10)
	lis 11,.LC34@ha
	la 9,.LC34@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC34@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L66
.L65:
	lis 9,gi+16@ha
	lis 11,sound_cry2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC34@ha
	mr 3,31
	lwz 5,sound_cry2@l(11)
	lis 9,.LC34@ha
	la 10,.LC34@l(10)
	lis 11,.LC33@ha
	la 9,.LC34@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC33@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L66:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC36@ha
	lis 11,.LC32@ha
	la 10,.LC36@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC37@ha
	lfs 12,.LC32@l(11)
	la 10,.LC37@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 31,0,12
	fmr 13,31
	fcmpu 0,13,11
	cror 3,2,1
	bc 4,3,.L67
	lis 9,jawa2_move_death1@ha
	la 9,jawa2_move_death1@l(9)
	b .L69
.L67:
	lis 9,jawa2_move_death2@ha
	la 9,jawa2_move_death2@l(9)
.L69:
	stw 9,772(31)
.L57:
	lwz 0,68(1)
	mtlr 0
	lmw 28,24(1)
	lfd 29,40(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 jawa2_die,.Lfe4-jawa2_die
	.section	".rodata"
	.align 2
.LC38:
	.string	"jawa/j_agree.wav"
	.align 2
.LC39:
	.string	"jawa/j_cry1.wav"
	.align 2
.LC40:
	.string	"jawa/j_cry2.wav"
	.align 2
.LC41:
	.string	"jawa/j_disagr.wav"
	.align 2
.LC42:
	.string	"jawa/j_lift1.wav"
	.align 2
.LC43:
	.string	"jawa/j_lift2.wav"
	.align 2
.LC44:
	.string	"jawa/j_scare.wav"
	.align 2
.LC45:
	.string	"jawa/j_talk1.wav"
	.align 2
.LC46:
	.string	"jawa/j_talk2.wav"
	.align 2
.LC47:
	.string	"jawa/j_talk3.wav"
	.align 2
.LC48:
	.string	"jawa/j_talk4.wav"
	.align 2
.LC49:
	.string	"jawa/j_talk5.wav"
	.align 2
.LC50:
	.string	"jawa/j_talk6.wav"
	.align 2
.LC51:
	.string	"jawa/j_work.wav"
	.align 2
.LC53:
	.string	"models/monsters/jawa/worker.md2"
	.align 2
.LC52:
	.long 0x46fffe00
	.align 2
.LC54:
	.long 0x3f99999a
	.align 2
.LC55:
	.long 0x0
	.align 3
.LC56:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC57:
	.long 0x41700000
	.align 2
.LC58:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl SP_monster_jawa2
	.type	 SP_monster_jawa2,@function
SP_monster_jawa2:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 11,.LC55@ha
	lis 9,deathmatch@ha
	la 11,.LC55@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L71
	bl G_FreeEdict
	b .L70
.L71:
	lis 29,gi@ha
	lis 3,.LC38@ha
	la 29,gi@l(29)
	la 3,.LC38@l(3)
	lwz 9,36(29)
	li 26,0
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_agree@ha
	lis 11,.LC39@ha
	stw 3,sound_agree@l(9)
	mtlr 10
	la 3,.LC39@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_cry1@ha
	lis 11,.LC40@ha
	stw 3,sound_cry1@l(9)
	mtlr 10
	la 3,.LC40@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_cry2@ha
	lis 11,.LC41@ha
	stw 3,sound_cry2@l(9)
	mtlr 10
	la 3,.LC41@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_disagree@ha
	lis 11,.LC42@ha
	stw 3,sound_disagree@l(9)
	mtlr 10
	la 3,.LC42@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_lift1@ha
	lis 11,.LC43@ha
	stw 3,sound_lift1@l(9)
	mtlr 10
	la 3,.LC43@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_lift2@ha
	lis 11,.LC44@ha
	stw 3,sound_lift2@l(9)
	mtlr 10
	la 3,.LC44@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_scare@ha
	lis 11,.LC45@ha
	stw 3,sound_scare@l(9)
	mtlr 10
	la 3,.LC45@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_talk1@ha
	lis 11,.LC46@ha
	stw 3,sound_talk1@l(9)
	mtlr 10
	la 3,.LC46@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_talk2@ha
	lis 11,.LC47@ha
	stw 3,sound_talk2@l(9)
	mtlr 10
	la 3,.LC47@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_talk3@ha
	lis 11,.LC48@ha
	stw 3,sound_talk3@l(9)
	mtlr 10
	la 3,.LC48@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_talk4@ha
	lis 11,.LC49@ha
	stw 3,sound_talk4@l(9)
	mtlr 10
	la 3,.LC49@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_talk5@ha
	lis 11,.LC50@ha
	stw 3,sound_talk5@l(9)
	mtlr 10
	la 3,.LC50@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_talk6@ha
	lis 11,.LC51@ha
	stw 3,sound_talk6@l(9)
	mtlr 10
	la 3,.LC51@l(11)
	blrl
	lis 9,sound_work@ha
	stw 3,sound_work@l(9)
	stw 26,60(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC56@ha
	lis 10,.LC52@ha
	stw 0,16(1)
	la 11,.LC56@l(11)
	lis 3,.LC53@ha
	lfd 13,0(11)
	li 0,-40
	la 3,.LC53@l(3)
	lfd 0,16(1)
	lis 11,.LC57@ha
	lfs 11,.LC52@l(10)
	la 11,.LC57@l(11)
	lfs 9,0(11)
	fsub 0,0,13
	lis 11,.LC58@ha
	stw 0,488(31)
	la 11,.LC58@l(11)
	lfs 10,0(11)
	frsp 0,0
	mr 11,9
	fdivs 0,0,11
	fmadds 0,0,9,10
	fmr 13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 11,20(1)
	stw 11,484(31)
	stw 11,480(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,.LC54@ha
	lis 11,jawa2_pain@ha
	lwz 4,776(31)
	lfs 0,.LC54@l(9)
	lis 10,jawa2_die@ha
	lis 8,jawa2_walk@ha
	lis 9,jawa2_stand@ha
	la 11,jawa2_pain@l(11)
	stw 3,40(31)
	la 10,jawa2_die@l(10)
	la 9,jawa2_stand@l(9)
	stw 11,452(31)
	la 8,jawa2_walk@l(8)
	lis 0,0xc1c0
	stw 10,456(31)
	stw 9,788(31)
	lis 5,jawa2_run@ha
	lis 7,jawa2_attack@ha
	stw 8,800(31)
	lis 6,jawa2_sight@ha
	la 5,jawa2_run@l(5)
	stw 0,196(31)
	la 7,jawa2_attack@l(7)
	la 6,jawa2_sight@l(6)
	ori 4,4,256
	lis 11,0x4200
	stfs 0,784(31)
	li 10,5
	li 8,2
	stw 11,208(31)
	lis 9,0x4234
	lis 28,0xc180
	stw 10,260(31)
	lis 27,0x4180
	li 0,50
	stw 8,248(31)
	stw 9,420(31)
	mr 3,31
	stw 5,804(31)
	stw 7,812(31)
	stw 6,820(31)
	stw 4,776(31)
	stw 26,816(31)
	stw 28,192(31)
	stw 27,204(31)
	stw 0,400(31)
	stw 28,188(31)
	stw 27,200(31)
	stw 26,808(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	mr 3,31
	bl walkmonster_start
.L70:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 SP_monster_jawa2,.Lfe5-SP_monster_jawa2
	.comm	node_count,2,2
	.comm	path_not_time_yet,4,4
	.comm	conversation_content,7760,4
	.comm	highlighted,4,4
	.comm	yeah_you,4,4
	.comm	its_me,4,4
	.comm	holdthephone,4,4
	.comm	NoTouch,4,4
	.comm	showingit,4,4
	.comm	path_time,4,4
	.comm	print_time,4,4
	.section	".sbss","aw",@nobits
	.align 2
sound_agree:
	.space	4
	.size	 sound_agree,4
	.align 2
sound_cry1:
	.space	4
	.size	 sound_cry1,4
	.align 2
sound_cry2:
	.space	4
	.size	 sound_cry2,4
	.align 2
sound_disagree:
	.space	4
	.size	 sound_disagree,4
	.align 2
sound_lift1:
	.space	4
	.size	 sound_lift1,4
	.align 2
sound_lift2:
	.space	4
	.size	 sound_lift2,4
	.align 2
sound_scare:
	.space	4
	.size	 sound_scare,4
	.align 2
sound_talk1:
	.space	4
	.size	 sound_talk1,4
	.align 2
sound_talk2:
	.space	4
	.size	 sound_talk2,4
	.align 2
sound_talk3:
	.space	4
	.size	 sound_talk3,4
	.align 2
sound_talk4:
	.space	4
	.size	 sound_talk4,4
	.align 2
sound_talk5:
	.space	4
	.size	 sound_talk5,4
	.align 2
sound_talk6:
	.space	4
	.size	 sound_talk6,4
	.align 2
sound_work:
	.space	4
	.size	 sound_work,4
	.section	".rodata"
	.align 2
.LC59:
	.long 0x46fffe00
	.align 3
.LC60:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 3
.LC61:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC62:
	.long 0x3f800000
	.align 2
.LC63:
	.long 0x40000000
	.align 2
.LC64:
	.long 0x0
	.section	".text"
	.align 2
	.globl jawa2_work_talk
	.type	 jawa2_work_talk,@function
jawa2_work_talk:
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
	lis 11,.LC61@ha
	lis 10,.LC59@ha
	la 11,.LC61@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC60@ha
	lfs 11,.LC59@l(10)
	lfd 12,.LC60@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L20
	lis 9,gi+16@ha
	lis 11,sound_work@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC62@ha
	lwz 5,sound_work@l(11)
	la 9,.LC62@l(9)
	lis 11,.LC63@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC63@l(11)
	lis 9,.LC64@ha
	lfs 2,0(11)
	la 9,.LC64@l(9)
	lfs 3,0(9)
	blrl
.L20:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 jawa2_work_talk,.Lfe6-jawa2_work_talk
	.section	".rodata"
	.align 2
.LC65:
	.long 0x46fffe00
	.align 3
.LC66:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC67:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC68:
	.long 0x3f800000
	.align 2
.LC69:
	.long 0x40000000
	.align 2
.LC70:
	.long 0x0
	.section	".text"
	.align 2
	.globl jawa2_frust_talk
	.type	 jawa2_frust_talk,@function
jawa2_frust_talk:
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
	lis 10,.LC66@ha
	lis 11,.LC65@ha
	la 10,.LC66@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC67@ha
	lfs 12,.LC65@l(11)
	la 10,.LC67@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L22
	lis 9,gi+16@ha
	lis 11,sound_cry1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC70@ha
	mr 3,31
	lwz 5,sound_cry1@l(11)
	lis 9,.LC69@ha
	la 10,.LC70@l(10)
	lis 11,.LC68@ha
	la 9,.LC69@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC68@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L23
.L22:
	lis 9,gi+16@ha
	lis 11,sound_cry2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC69@ha
	mr 3,31
	lwz 5,sound_cry2@l(11)
	lis 9,.LC68@ha
	la 10,.LC69@l(10)
	lis 11,.LC70@ha
	la 9,.LC68@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC70@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L23:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 jawa2_frust_talk,.Lfe7-jawa2_frust_talk
	.align 2
	.globl jawa2_walk
	.type	 jawa2_walk,@function
jawa2_walk:
	lis 9,jawa2_move_walk1@ha
	la 9,jawa2_move_walk1@l(9)
	stw 9,772(3)
	blr
.Lfe8:
	.size	 jawa2_walk,.Lfe8-jawa2_walk
	.align 2
	.globl jawa2_run
	.type	 jawa2_run,@function
jawa2_run:
	lwz 0,776(3)
	andi. 9,0,1
	bc 12,2,.L47
	lis 9,jawa2_move_stand1@ha
	la 9,jawa2_move_stand1@l(9)
	stw 9,772(3)
	blr
.L47:
	lis 9,jawa2_move_run1@ha
	la 9,jawa2_move_run1@l(9)
	stw 9,772(3)
	blr
.Lfe9:
	.size	 jawa2_run,.Lfe9-jawa2_run
	.section	".rodata"
	.align 2
.LC71:
	.long 0x46fffe00
	.align 2
.LC72:
	.long 0x40c00000
	.align 3
.LC73:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC74:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC75:
	.long 0x3f800000
	.align 2
.LC76:
	.long 0x0
	.align 2
.LC77:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl jawa2_pain
	.type	 jawa2_pain,@function
jawa2_pain:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,464(31)
	fcmpu 0,13,0
	bc 12,0,.L49
	lis 9,.LC72@ha
	la 9,.LC72@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,464(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC73@ha
	lis 11,.LC71@ha
	la 10,.LC73@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC74@ha
	lfs 12,.LC71@l(11)
	la 10,.LC74@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,1
	bc 4,3,.L51
	lis 9,gi+16@ha
	lis 11,sound_cry1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC76@ha
	mr 3,31
	lwz 5,sound_cry1@l(11)
	lis 9,.LC75@ha
	la 10,.LC76@l(10)
	lis 11,.LC75@ha
	la 9,.LC75@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC75@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L52
.L51:
	lis 9,gi+16@ha
	lis 11,sound_cry2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC75@ha
	mr 3,31
	lwz 5,sound_cry2@l(11)
	lis 9,.LC75@ha
	la 10,.LC75@l(10)
	lis 11,.LC76@ha
	la 9,.LC75@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC76@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L52:
	lis 9,.LC77@ha
	lis 11,skill@ha
	la 9,.LC77@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L49
	lis 9,jawa2_move_pain1@ha
	la 9,jawa2_move_pain1@l(9)
	stw 9,772(31)
.L49:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 jawa2_pain,.Lfe10-jawa2_pain
	.align 2
	.globl jawa2_attack
	.type	 jawa2_attack,@function
jawa2_attack:
	blr
.Lfe11:
	.size	 jawa2_attack,.Lfe11-jawa2_attack
	.align 2
	.globl jawa2_sight
	.type	 jawa2_sight,@function
jawa2_sight:
	blr
.Lfe12:
	.size	 jawa2_sight,.Lfe12-jawa2_sight
	.align 2
	.globl jawa2_dead
	.type	 jawa2_dead,@function
jawa2_dead:
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
	stw 7,260(9)
	stw 0,184(9)
	stw 10,428(9)
	stw 5,188(9)
	stw 6,200(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 jawa2_dead,.Lfe13-jawa2_dead
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
