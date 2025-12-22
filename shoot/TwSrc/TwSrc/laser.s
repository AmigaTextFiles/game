	.file	"laser.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0xbca3d70a
	.align 2
.LC1:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl Laser_Explode
	.type	 Laser_Explode,@function
Laser_Explode:
	stwu 1,-80(1)
	mflr 0
	stmw 29,68(1)
	stw 0,84(1)
	mr 31,3
	lwz 3,256(31)
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L7
	addi 4,31,4
	li 5,2
	bl PlayerNoise
.L7:
	lwz 9,816(31)
	cmpwi 0,9,0
	bc 12,2,.L8
	lfs 0,200(9)
	lis 11,.LC1@ha
	addi 29,1,24
	lfs 13,188(9)
	la 11,.LC1@l(11)
	addi 3,9,4
	lfs 1,0(11)
	mr 4,29
	mr 5,29
	fadds 13,13,0
	stfs 13,24(1)
	lfs 13,204(9)
	lfs 0,192(9)
	fadds 0,0,13
	stfs 0,28(1)
	lfs 0,208(9)
	lfs 13,196(9)
	fadds 13,13,0
	stfs 13,32(1)
	bl VectorMA
	lfs 0,4(31)
	mr 3,29
	lfs 13,8(31)
	lfs 12,12(31)
	lfs 11,28(1)
	lfs 9,24(1)
	lfs 10,32(1)
	fsubs 13,13,11
	fsubs 0,0,9
	fsubs 12,12,10
	stfs 13,28(1)
	stfs 0,24(1)
	stfs 12,32(1)
	bl VectorLength
	lwz 9,816(31)
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,40(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,44(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,48(1)
.L8:
	lis 9,.LC0@ha
	addi 3,31,4
	lfs 1,.LC0@l(9)
	mr 30,3
	addi 4,31,620
	addi 5,1,8
	bl VectorMA
	lis 9,gi@ha
	li 3,3
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,964(31)
	cmpwi 0,0,0
	bc 12,2,.L9
	lwz 0,828(31)
	cmpwi 0,0,0
	bc 12,2,.L10
	lwz 0,100(29)
	li 3,18
	b .L15
.L10:
	lwz 0,100(29)
	li 3,17
	b .L15
.L9:
	lwz 0,828(31)
	cmpwi 0,0,0
	bc 12,2,.L13
	lwz 0,100(29)
	li 3,8
.L15:
	mtlr 0
	blrl
	b .L12
.L13:
	lwz 0,100(29)
	li 3,7
	mtlr 0
	blrl
.L12:
	lis 29,gi@ha
	addi 3,1,8
	la 29,gi@l(29)
	lwz 9,120(29)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,30
	li 4,1
	mtlr 0
	blrl
	mr 3,31
	bl G_FreeEdict
	lwz 0,84(1)
	mtlr 0
	lmw 29,68(1)
	la 1,80(1)
	blr
.Lfe1:
	.size	 Laser_Explode,.Lfe1-Laser_Explode
	.section	".rodata"
	.align 2
.LC2:
	.long -218959632
	.long -791555373
	.long -202116623
	.long -589439265
	.long -522067229
	.align 2
.LC3:
	.string	"Cells"
	.align 2
.LC4:
	.string	"Not enough cells for laser.\n"
	.align 2
.LC5:
	.string	"Too far from wall.\n"
	.align 2
.LC6:
	.string	"Laser attached.\n"
	.align 2
.LC7:
	.string	"world/laser.wav"
	.align 2
.LC8:
	.string	"laser_yaya"
	.align 2
.LC10:
	.string	"models/objects/grenade2/tris.md2"
	.align 2
.LC9:
	.long 0x46fffe00
	.align 2
.LC11:
	.long 0x42480000
	.align 3
.LC12:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC13:
	.long 0x42700000
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC15:
	.long 0x447a0000
	.align 2
.LC16:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl PlaceLaser
	.type	 PlaceLaser,@function
PlaceLaser:
	stwu 1,-208(1)
	mflr 0
	stfd 31,200(1)
	stmw 23,164(1)
	stw 0,212(1)
	mr 31,3
	lis 11,.LC2@ha
	lwz 28,84(31)
	la 9,.LC2@l(11)
	addi 30,1,104
	lwz 8,.LC2@l(11)
	lwz 7,16(9)
	cmpwi 0,28,0
	lwz 0,4(9)
	lwz 11,8(9)
	lwz 10,12(9)
	stw 8,104(1)
	stw 0,4(30)
	stw 11,8(30)
	stw 10,12(30)
	stw 7,16(30)
	bc 12,2,.L19
	lwz 0,728(31)
	cmpwi 0,0,0
	bc 4,1,.L19
	lis 27,.LC3@ha
	lis 29,0x38e3
	la 3,.LC3@l(27)
	ori 29,29,36409
	bl FindItem
	addi 11,28,748
	lis 9,itemlist@ha
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,29
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,11,3
	cmpwi 0,0,149
	bc 12,1,.L22
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC4@l(5)
	b .L26
.L22:
	lfs 12,4(31)
	addi 4,1,8
	li 5,0
	lfs 13,8(31)
	li 6,0
	lfs 0,12(31)
	lwz 3,84(31)
	stfs 12,24(1)
	stfs 13,28(1)
	addi 3,3,3752
	stfs 0,32(1)
	bl AngleVectors
	lis 11,.LC11@ha
	mr 4,31
	lfs 10,8(1)
	la 11,.LC11@l(11)
	lfsu 0,4(4)
	lis 9,gi@ha
	lfs 11,0(11)
	la 23,gi@l(9)
	addi 3,1,40
	lfs 13,12(31)
	li 9,3
	li 5,0
	lfs 9,8(31)
	li 6,0
	addi 7,1,24
	fmadds 10,10,11,0
	lfs 12,12(1)
	mr 8,31
	lfs 0,16(1)
	lwz 11,48(23)
	fmadds 12,12,11,9
	stfs 10,24(1)
	fmadds 0,0,11,13
	mtlr 11
	stfs 12,28(1)
	stfs 0,32(1)
	blrl
	lfs 0,48(1)
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L23
	lwz 0,8(23)
	lis 5,.LC5@ha
	mr 3,31
	la 5,.LC5@l(5)
.L26:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L19
.L23:
	lwz 9,84(1)
	cmpwi 0,9,0
	bc 12,2,.L24
	lwz 0,16(9)
	andi. 9,0,4
	bc 4,2,.L19
.L24:
	lwz 11,8(23)
	lis 5,.LC6@ha
	li 4,2
	la 5,.LC6@l(5)
	mr 3,31
	mtlr 11
	lis 9,.LC13@ha
	addi 24,1,64
	la 9,.LC13@l(9)
	li 26,0
	lfs 31,0(9)
	li 25,2
	crxor 6,6,6
	blrl
	la 3,.LC3@l(27)
	bl FindItem
	subf 3,28,3
	lwz 11,84(31)
	mullw 3,3,29
	addi 11,11,748
	srawi 3,3,3
	slwi 3,3,2
	lwzx 9,11,3
	addi 9,9,-150
	stwx 9,11,3
	bl G_Spawn
	mr 28,3
	li 0,160
	li 9,1
	stw 0,68(28)
	lis 3,.LC7@ha
	stw 9,40(28)
	la 3,.LC7@l(3)
	addi 29,28,16
	stw 26,264(28)
	stw 26,248(28)
	lwz 9,36(23)
	mtlr 9
	blrl
	lis 9,.LC8@ha
	stw 3,76(28)
	la 9,.LC8@l(9)
	stw 25,56(28)
	stw 9,284(28)
	stw 31,256(28)
	lwz 0,908(31)
	stw 0,908(28)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,156(1)
	lis 9,.LC14@ha
	lis 8,.LC9@ha
	stw 0,152(1)
	la 9,.LC14@l(9)
	lis 11,.LC15@ha
	lfd 13,0(9)
	la 11,.LC15@l(11)
	lis 7,pre_target_laser_think@ha
	lfd 0,152(1)
	lis 9,0x6666
	la 7,pre_target_laser_think@l(7)
	lfs 11,.LC9@l(8)
	ori 9,9,26215
	lis 27,level@ha
	lfs 10,0(11)
	li 8,100
	la 27,level@l(27)
	fsub 0,0,13
	mr 11,10
	mr 4,29
	mr 3,24
	frsp 0,0
	fdivs 0,0,11
	fmuls 0,0,10
	fmr 13,0
	fctiwz 12,13
	stfd 12,152(1)
	lwz 11,156(1)
	mulhw 9,11,9
	srawi 10,11,31
	srawi 9,9,1
	subf 9,10,9
	slwi 0,9,2
	add 0,0,9
	subf 11,0,11
	slwi 11,11,2
	lwzx 0,30,11
	stw 8,792(28)
	stw 7,680(28)
	stw 0,60(28)
	lfs 0,4(27)
	fadds 0,0,31
	stfs 0,888(28)
	lwz 0,908(31)
	stw 0,908(28)
	lfs 0,52(1)
	stfs 0,4(28)
	lfs 13,56(1)
	stfs 13,8(28)
	lfs 0,60(1)
	stfs 0,12(28)
	bl vectoangles
	addi 4,28,584
	mr 3,29
	bl G_SetMovedir
	lis 0,0xc100
	lis 9,0x4100
	stw 0,196(28)
	mr 3,28
	stw 0,188(28)
	stw 0,192(28)
	stw 9,208(28)
	stw 9,200(28)
	stw 9,204(28)
	lwz 9,72(23)
	mtlr 9
	blrl
	mr 3,28
	bl target_laser_off
	lis 9,.LC16@ha
	lfs 0,4(27)
	la 9,.LC16@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,672(28)
	bl G_Spawn
	mr 29,3
	li 0,0
	stw 0,200(29)
	mr 3,24
	addi 4,29,16
	stw 0,196(29)
	stw 0,192(29)
	stw 0,188(29)
	stw 0,208(29)
	stw 0,204(29)
	lfs 0,52(1)
	stfs 0,4(29)
	lfs 13,56(1)
	stfs 13,8(29)
	lfs 0,60(1)
	stfs 0,12(29)
	bl vectoangles
	li 10,20
	lis 9,laser_pain@ha
	stw 10,756(29)
	lis 11,laser_die@ha
	lis 0,0x600
	stw 10,728(29)
	la 9,laser_pain@l(9)
	ori 0,0,3
	lwz 10,908(31)
	la 11,laser_die@l(11)
	lis 3,.LC10@ha
	stw 0,252(29)
	la 3,.LC10@l(3)
	stw 9,696(29)
	stw 10,908(29)
	stw 11,700(29)
	stw 26,264(29)
	lwz 9,32(23)
	mtlr 9
	blrl
	stw 3,40(29)
	lis 9,G_FreeEdict@ha
	lis 0,0x201
	stw 28,256(29)
	ori 0,0,3
	la 9,G_FreeEdict@l(9)
	lfs 0,4(27)
	mr 3,29
	stw 9,680(29)
	stw 0,252(29)
	fadds 0,0,31
	stw 25,248(29)
	stw 25,788(29)
	stfs 0,672(29)
	lwz 0,72(23)
	mtlr 0
	blrl
.L19:
	lwz 0,212(1)
	mtlr 0
	lmw 23,164(1)
	lfd 31,200(1)
	la 1,208(1)
	blr
.Lfe2:
	.size	 PlaceLaser,.Lfe2-PlaceLaser
	.align 2
	.globl pre_target_laser_think
	.type	 pre_target_laser_think,@function
pre_target_laser_think:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl target_laser_on
	lis 9,target_laser_think@ha
	la 9,target_laser_think@l(9)
	stw 9,680(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 pre_target_laser_think,.Lfe3-pre_target_laser_think
	.align 2
	.globl laser_die
	.type	 laser_die,@function
laser_die:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 3,256(29)
	bl G_FreeEdict
	mr 3,29
	bl Laser_Explode
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 laser_die,.Lfe4-laser_die
	.section	".rodata"
	.align 2
.LC17:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl laser_pain
	.type	 laser_pain,@function
laser_pain:
	lis 9,level+4@ha
	lfs 0,708(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bclr 12,0
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,708(3)
	blr
.Lfe5:
	.size	 laser_pain,.Lfe5-laser_pain
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
