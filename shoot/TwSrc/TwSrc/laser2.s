	.file	"laser2.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"lasersight off.\n"
	.align 2
.LC1:
	.string	"lasersight on.\n"
	.align 2
.LC2:
	.string	"lasersight"
	.align 2
.LC3:
	.string	"models/objects/sight/tris.md2"
	.align 3
.LC4:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_LaserSight
	.type	 SP_LaserSight,@function
SP_LaserSight:
	stwu 1,-96(1)
	mflr 0
	stmw 27,76(1)
	stw 0,100(1)
	mr 31,3
	lwz 30,1244(31)
	cmpwi 0,30,0
	bc 12,2,.L7
	mr 3,30
	bl G_FreeEdict
	li 0,0
	lis 9,gi+8@ha
	stw 0,1244(31)
	lis 5,.LC0@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	la 5,.LC0@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L7:
	lis 28,gi@ha
	lis 5,.LC1@ha
	la 28,gi@l(28)
	mr 3,31
	lwz 9,8(28)
	la 5,.LC1@l(5)
	li 4,2
	addi 29,1,24
	addi 27,1,40
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 3,84(31)
	mr 4,29
	mr 5,27
	li 6,0
	addi 3,3,3752
	bl AngleVectors
	li 9,0
	lis 0,0x42c8
	addi 7,1,8
	stw 9,64(1)
	mr 5,29
	stw 0,56(1)
	mr 6,27
	addi 4,1,56
	stw 9,60(1)
	addi 3,31,4
	bl G_ProjectSource
	bl G_Spawn
	stw 3,1244(31)
	li 0,1
	lis 11,.LC3@ha
	stw 31,256(3)
	lis 10,.LC2@ha
	lwz 9,1244(31)
	la 3,.LC3@l(11)
	la 10,.LC2@l(10)
	stw 0,264(9)
	lwz 11,1244(31)
	stw 30,248(11)
	lwz 9,1244(31)
	stw 10,284(9)
	lwz 0,32(28)
	mtlr 0
	blrl
	lwz 8,1244(31)
	lis 11,.LC4@ha
	lis 10,LaserSightThink@ha
	lfd 13,.LC4@l(11)
	la 10,LaserSightThink@l(10)
	lis 7,level+4@ha
	stw 3,40(8)
	lwz 9,1244(31)
	stw 30,60(9)
	lwz 11,1244(31)
	lwz 0,68(11)
	ori 0,0,8
	stw 0,68(11)
	lwz 9,1244(31)
	stw 10,680(9)
	lfs 0,level+4@l(7)
	lwz 9,1244(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(9)
.L6:
	lwz 0,100(1)
	mtlr 0
	lmw 27,76(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 SP_LaserSight,.Lfe1-SP_LaserSight
	.section	".rodata"
	.align 3
.LC5:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC6:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC7:
	.long 0x46000000
	.align 2
.LC8:
	.long 0x3f800000
	.align 2
.LC9:
	.long 0xc0800000
	.section	".text"
	.align 2
	.globl LaserSightThink
	.type	 LaserSightThink,@function
LaserSightThink:
	stwu 1,-208(1)
	mflr 0
	stmw 28,192(1)
	stw 0,212(1)
	mr 31,3
	addi 30,1,72
	lwz 9,256(31)
	addi 29,1,88
	addi 28,1,24
	addi 6,1,104
	mr 4,30
	lwz 3,84(9)
	mr 5,29
	addi 3,3,3752
	bl AngleVectors
	lwz 3,256(31)
	lis 9,0x40c0
	lis 0,0x41c0
	stw 9,60(1)
	addi 7,1,8
	lis 9,.LC6@ha
	stw 0,56(1)
	addi 4,1,56
	la 9,.LC6@l(9)
	lis 0,0x4330
	lfd 13,0(9)
	mr 6,29
	mr 5,30
	lwz 9,784(3)
	addi 3,3,4
	addi 9,9,-7
	xoris 9,9,0x8000
	stw 9,188(1)
	stw 0,184(1)
	lfd 0,184(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	bl G_ProjectSource
	lis 9,.LC7@ha
	addi 3,1,8
	la 9,.LC7@l(9)
	mr 4,30
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 8,256(31)
	lwz 0,gi+48@l(11)
	ori 9,9,1
	mr 7,28
	addi 3,1,120
	addi 4,1,8
	li 5,0
	li 6,0
	mtlr 0
	blrl
	lis 9,.LC8@ha
	lfs 13,128(1)
	la 9,.LC8@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L9
	lis 11,.LC9@ha
	mr 4,30
	la 11,.LC9@l(11)
	addi 3,1,132
	lfs 1,0(11)
	addi 5,1,40
	bl VectorMA
	lfs 0,40(1)
	lfs 13,44(1)
	lfs 12,48(1)
	stfs 0,132(1)
	stfs 13,136(1)
	stfs 12,140(1)
.L9:
	lwz 9,172(1)
	lwz 0,184(9)
	andi. 11,0,4
	bc 4,2,.L11
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L10
.L11:
	lwz 0,788(9)
	cmpwi 0,0,0
	bc 12,2,.L13
	lwz 0,256(31)
	cmpw 0,9,0
	bc 12,2,.L13
	li 0,1
.L10:
	stw 0,60(31)
.L13:
	addi 3,1,144
	addi 4,31,16
	bl vectoangles
	lfs 0,136(1)
	lis 9,gi+72@ha
	mr 3,31
	lfs 13,140(1)
	lfs 12,132(1)
	stfs 0,8(31)
	stfs 13,12(31)
	stfs 12,4(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC5@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC5@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
	lwz 0,212(1)
	mtlr 0
	lmw 28,192(1)
	la 1,208(1)
	blr
.Lfe2:
	.size	 LaserSightThink,.Lfe2-LaserSightThink
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
