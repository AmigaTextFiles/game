	.file	"kamikaze.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Already in Kamikaze Mode!! Kiss you butt Goodbye!\n"
	.align 2
.LC1:
	.string	"Can't Kamikaze in God Mode, Whats the Point?"
	.align 2
.LC2:
	.string	"%s is a Kamikaze - BANZAI!!\n"
	.align 2
.LC3:
	.string	"makron/rail_up.wav"
	.align 3
.LC4:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC5:
	.long 0x3f800000
	.align 2
.LC6:
	.long 0x0
	.section	".text"
	.align 2
	.globl Start_Kamikaze_Mode
	.type	 Start_Kamikaze_Mode,@function
Start_Kamikaze_Mode:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3916(9)
	andi. 7,0,1
	bc 12,2,.L7
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	lwz 0,gi+8@l(9)
	la 5,.LC0@l(5)
	b .L9
.L7:
	lwz 0,268(31)
	andi. 7,0,16
	bc 12,2,.L8
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC1@l(5)
.L9:
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L8:
	li 28,1
	lis 0,0x4248
	stw 28,3916(9)
	lis 10,level@ha
	lis 8,0x4330
	lwz 11,84(31)
	lis 7,.LC4@ha
	la 7,.LC4@l(7)
	lis 4,.LC2@ha
	stw 0,3924(11)
	la 4,.LC2@l(4)
	li 3,1
	lwz 0,level@l(10)
	lfd 12,0(7)
	xoris 0,0,0x8000
	lwz 11,84(31)
	lis 7,gi@ha
	stw 0,12(1)
	la 29,gi@l(7)
	stw 8,8(1)
	lfd 0,8(1)
	lfs 13,3924(11)
	fsub 0,0,12
	frsp 0,0
	fadds 0,0,13
	stfs 0,3920(11)
	lwz 0,gi@l(7)
	lwz 5,84(31)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	stw 28,564(31)
	lis 3,.LC3@ha
	lwz 9,36(29)
	la 3,.LC3@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC5@ha
	lis 9,.LC6@ha
	lis 11,.LC6@ha
	mr 5,3
	la 7,.LC5@l(7)
	la 9,.LC6@l(9)
	mtlr 0
	la 11,.LC6@l(11)
	li 4,1
	lfs 1,0(7)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L6:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Start_Kamikaze_Mode,.Lfe1-Start_Kamikaze_Mode
	.align 2
	.globl Kamikaze_Active
	.type	 Kamikaze_Active,@function
Kamikaze_Active:
	lwz 9,84(3)
	lwz 3,3916(9)
	blr
.Lfe2:
	.size	 Kamikaze_Active,.Lfe2-Kamikaze_Active
	.section	".rodata"
	.align 2
.LC7:
	.long 0x43960000
	.align 2
.LC8:
	.long 0x43fa0000
	.section	".text"
	.align 2
	.globl Kamikaze_Explode
	.type	 Kamikaze_Explode,@function
Kamikaze_Explode:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,.LC7@ha
	mr 28,3
	la 9,.LC7@l(9)
	mr 4,28
	lfs 1,0(9)
	li 5,0
	li 6,37
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	addi 27,28,4
	lfs 2,0(9)
	bl T_RadiusDamage
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
	mr 3,27
	mtlr 9
	blrl
	lwz 9,84(28)
	li 0,0
	mr 3,27
	li 4,2
	stw 0,1812(9)
	lwz 0,88(29)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 Kamikaze_Explode,.Lfe3-Kamikaze_Explode
	.align 2
	.globl Kamikaze_Cancel
	.type	 Kamikaze_Cancel,@function
Kamikaze_Cancel:
	lwz 11,84(3)
	li 0,0
	li 10,0
	stw 0,3916(11)
	lwz 9,84(3)
	stw 10,3924(9)
	lwz 11,84(3)
	stw 10,3920(11)
	blr
.Lfe4:
	.size	 Kamikaze_Cancel,.Lfe4-Kamikaze_Cancel
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
