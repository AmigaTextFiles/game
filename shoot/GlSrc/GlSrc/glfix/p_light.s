	.file	"p_light.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"weapons/noammo.wav"
	.align 2
.LC1:
	.string	"flashlight"
	.align 2
.LC2:
	.string	"sprites/s_fl.sp2"
	.align 3
.LC3:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC4:
	.long 0x3f800000
	.align 2
.LC5:
	.long 0x0
	.section	".text"
	.align 2
	.globl FL_make
	.type	 FL_make,@function
FL_make:
	stwu 1,-96(1)
	mflr 0
	stmw 28,80(1)
	stw 0,100(1)
	mr 31,3
	lwz 3,84(31)
	lwz 28,1812(3)
	cmpwi 0,28,0
	bc 4,2,.L6
	lwz 30,988(31)
	cmpwi 0,30,0
	bc 12,2,.L8
	mr 3,30
	bl G_FreeEdict
	lis 29,gi@ha
	stw 28,988(31)
	lis 3,.LC0@ha
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC4@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC4@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 2,0(9)
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 3,0(9)
	blrl
	b .L6
.L8:
	addi 29,1,24
	addi 28,1,40
	mr 4,29
	addi 3,3,3636
	mr 5,28
	li 6,0
	bl AngleVectors
	li 9,0
	lis 0,0x42c8
	mr 5,29
	stw 9,64(1)
	addi 4,1,56
	stw 0,56(1)
	addi 7,1,8
	mr 6,28
	stw 9,60(1)
	addi 3,31,4
	bl G_ProjectSource
	bl G_Spawn
	stw 3,988(31)
	li 0,1
	lis 10,.LC1@ha
	stw 31,256(3)
	la 10,.LC1@l(10)
	lis 29,gi@ha
	lwz 11,988(31)
	la 29,gi@l(29)
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	stw 0,260(11)
	lwz 9,988(31)
	stw 30,248(9)
	lwz 11,988(31)
	stw 10,280(11)
	lwz 9,32(29)
	mtlr 9
	blrl
	lwz 9,988(31)
	lis 11,.LC3@ha
	lis 10,FL_think@ha
	lfd 13,.LC3@l(11)
	la 10,FL_think@l(10)
	lis 8,level+4@ha
	stw 3,40(9)
	lwz 9,988(31)
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	stw 30,60(9)
	lwz 11,988(31)
	lwz 0,64(11)
	ori 0,0,64
	stw 0,64(11)
	lwz 9,988(31)
	stw 10,532(9)
	lfs 0,level+4@l(8)
	lwz 9,988(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(9)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC4@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC4@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 2,0(9)
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 3,0(9)
	blrl
.L6:
	lwz 0,100(1)
	mtlr 0
	lmw 28,80(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 FL_make,.Lfe1-FL_make
	.section	".rodata"
	.align 3
.LC6:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC8:
	.long 0x46000000
	.align 2
.LC9:
	.long 0x3f800000
	.align 2
.LC10:
	.long 0xc0800000
	.section	".text"
	.align 2
	.globl FL_think
	.type	 FL_think,@function
FL_think:
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
	addi 3,3,3636
	bl AngleVectors
	lwz 3,256(31)
	lis 9,0x40c0
	lis 0,0x41c0
	stw 9,60(1)
	addi 7,1,8
	lis 9,.LC7@ha
	stw 0,56(1)
	addi 4,1,56
	la 9,.LC7@l(9)
	lis 0,0x4330
	lfd 13,0(9)
	mr 6,29
	mr 5,30
	lwz 9,604(3)
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
	lis 9,.LC8@ha
	addi 3,1,8
	la 9,.LC8@l(9)
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
	lis 9,.LC9@ha
	lfs 13,128(1)
	la 9,.LC9@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L10
	lis 11,.LC10@ha
	mr 4,30
	la 11,.LC10@l(11)
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
.L10:
	lwz 9,172(1)
	lwz 0,184(9)
	andi. 11,0,4
	bc 4,2,.L12
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L11
.L12:
	lwz 0,608(9)
	cmpwi 0,0,0
	bc 12,2,.L14
	lwz 0,256(31)
	cmpw 0,9,0
	bc 12,2,.L14
	li 0,1
.L11:
	stw 0,60(31)
.L14:
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
	lis 11,.LC6@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC6@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
	lwz 0,212(1)
	mtlr 0
	lmw 28,192(1)
	la 1,208(1)
	blr
.Lfe2:
	.size	 FL_think,.Lfe2-FL_think
	.comm	maplist,292,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
