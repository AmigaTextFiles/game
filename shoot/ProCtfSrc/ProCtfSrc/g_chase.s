	.file	"g_chase.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"xv 0 yb -58 string2 \"Chasing %s\""
	.align 3
.LC1:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC2:
	.long 0x42600000
	.align 2
.LC3:
	.long 0xc1f00000
	.align 2
.LC4:
	.long 0x41a00000
	.align 2
.LC5:
	.long 0x41800000
	.align 2
.LC6:
	.long 0x40c00000
	.align 2
.LC7:
	.long 0x3f800000
	.align 2
.LC8:
	.long 0x40000000
	.align 2
.LC9:
	.long 0x47800000
	.align 2
.LC10:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl UpdateChaseCam
	.type	 UpdateChaseCam,@function
UpdateChaseCam:
	stwu 1,-1280(1)
	mflr 0
	stfd 30,1264(1)
	stfd 31,1272(1)
	stmw 25,1236(1)
	stw 0,1284(1)
	mr 31,3
	lwz 9,84(31)
	lwz 29,3788(9)
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 4,2,.L7
	stw 0,3788(9)
	b .L6
.L7:
	lfs 13,4(29)
	lis 11,0x4330
	lfs 10,4(31)
	lis 10,.LC1@ha
	la 10,.LC1@l(10)
	stfs 13,24(1)
	lfs 0,8(29)
	lfs 12,8(31)
	lfd 11,0(10)
	stfs 0,28(1)
	lis 10,.LC2@ha
	lfs 13,12(29)
	la 10,.LC2@l(10)
	lfs 0,12(31)
	stfs 10,152(1)
	stfs 13,32(1)
	stfs 0,160(1)
	stfs 12,156(1)
	lwz 0,508(29)
	lfs 9,0(10)
	xoris 0,0,0x8000
	stw 0,1228(1)
	stw 11,1224(1)
	lfd 0,1224(1)
	fsub 0,0,11
	frsp 0,0
	fadds 13,13,0
	stfs 13,32(1)
	lwz 9,84(29)
	lfs 0,3652(9)
	stfs 0,168(1)
	fcmpu 0,0,9
	lwz 9,84(29)
	lfs 0,3656(9)
	stfs 0,172(1)
	lwz 9,84(29)
	lfs 0,3660(9)
	stfs 0,176(1)
	bc 4,1,.L8
	stfs 9,168(1)
.L8:
	addi 28,1,56
	addi 5,1,72
	addi 3,1,168
	addi 30,1,24
	mr 4,28
	li 6,0
	bl AngleVectors
	mr 3,28
	bl VectorNormalize
	lis 9,.LC3@ha
	mr 3,30
	la 9,.LC3@l(9)
	mr 4,28
	lfs 1,0(9)
	addi 5,1,8
	bl VectorMA
	lis 9,.LC4@ha
	lfs 0,12(29)
	la 9,.LC4@l(9)
	lfs 12,16(1)
	lfs 13,0(9)
	fadds 0,0,13
	fcmpu 0,12,0
	bc 4,0,.L9
	stfs 0,16(1)
.L9:
	lwz 0,552(29)
	cmpwi 0,0,0
	bc 4,2,.L10
	lis 10,.LC5@ha
	lfs 0,16(1)
	la 10,.LC5@l(10)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,16(1)
.L10:
	lis 9,gi@ha
	lis 25,vec3_origin@ha
	la 26,gi@l(9)
	lis 11,.LC6@ha
	lwz 10,48(26)
	addi 27,1,88
	la 5,vec3_origin@l(25)
	la 11,.LC6@l(11)
	mr 6,5
	addi 7,1,8
	li 9,3
	mtlr 10
	lfs 31,0(11)
	mr 4,30
	mr 8,29
	mr 3,27
	lis 11,.LC7@ha
	la 11,.LC7@l(11)
	addi 30,1,40
	lfs 30,0(11)
	blrl
	lis 9,.LC8@ha
	lfs 12,100(1)
	mr 4,28
	lfs 13,104(1)
	la 9,.LC8@l(9)
	mr 3,30
	lfs 0,108(1)
	mr 5,30
	lfs 1,0(9)
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
	bl VectorMA
	lfs 12,48(1)
	la 5,vec3_origin@l(25)
	mr 3,27
	lwz 11,48(26)
	mr 4,30
	mr 6,5
	lfs 0,44(1)
	addi 7,1,8
	mr 8,29
	fadds 12,12,31
	lfs 13,40(1)
	li 9,3
	mtlr 11
	stfs 0,12(1)
	stfs 13,8(1)
	stfs 12,16(1)
	blrl
	lfs 0,96(1)
	fcmpu 0,0,30
	bc 4,0,.L11
	lfs 0,108(1)
	lfs 12,100(1)
	lfs 13,104(1)
	fsubs 0,0,31
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
.L11:
	lfs 12,48(1)
	la 5,vec3_origin@l(25)
	mr 3,27
	lwz 0,48(26)
	mr 4,30
	mr 6,5
	lfs 0,44(1)
	addi 7,1,8
	mr 8,29
	fsubs 12,12,31
	lfs 13,40(1)
	li 9,3
	mtlr 0
	stfs 0,12(1)
	stfs 13,8(1)
	stfs 12,16(1)
	blrl
	lfs 0,96(1)
	fcmpu 0,0,30
	bc 4,0,.L12
	lfs 0,108(1)
	lfs 12,100(1)
	lfs 13,104(1)
	fadds 0,0,31
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
.L12:
	lwz 9,84(31)
	li 0,4
	lis 10,.LC9@ha
	lis 11,.LC10@ha
	la 10,.LC9@l(10)
	stw 0,0(9)
	la 11,.LC10@l(11)
	li 6,0
	li 0,3
	lfs 0,40(1)
	li 7,0
	lfs 13,44(1)
	mtctr 0
	lfs 12,48(1)
	lfs 10,0(10)
	lfs 11,0(11)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
.L21:
	lwz 8,84(31)
	add 0,6,6
	lwz 9,84(29)
	addi 6,6,1
	addi 11,8,3456
	addi 9,9,3652
	lfsx 12,11,7
	addi 8,8,20
	lfsx 0,9,7
	addi 7,7,4
	fsubs 0,0,12
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 13,0
	stfd 13,1224(1)
	lwz 10,1228(1)
	sthx 10,8,0
	bdnz .L21
	lwz 9,84(29)
	li 10,0
	lis 8,gi+72@ha
	lwz 11,84(31)
	mr 3,31
	lfs 0,3652(9)
	stfs 0,28(11)
	lwz 9,84(29)
	lwz 11,84(31)
	lfs 0,3656(9)
	stfs 0,32(11)
	lwz 9,84(29)
	lwz 11,84(31)
	lfs 0,3660(9)
	stfs 0,36(11)
	lwz 9,84(29)
	lwz 11,84(31)
	lfs 0,3652(9)
	stfs 0,3652(11)
	lwz 9,84(29)
	lwz 11,84(31)
	lfs 0,3656(9)
	stfs 0,3656(11)
	lwz 9,84(29)
	lwz 11,84(31)
	lfs 0,3660(9)
	stfs 0,3660(11)
	lwz 9,84(31)
	stw 10,508(31)
	lbz 0,16(9)
	ori 0,0,64
	stb 0,16(9)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	lwz 11,84(31)
	lwz 0,3504(11)
	cmpwi 0,0,0
	bc 4,2,.L20
	lwz 0,3512(11)
	cmpwi 0,0,0
	bc 4,2,.L20
	lwz 0,3516(11)
	cmpwi 0,0,0
	bc 4,2,.L20
	lwz 0,3520(11)
	cmpwi 0,0,0
	bc 4,2,.L20
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,31
	bc 12,2,.L19
.L20:
	lwz 9,84(31)
	lwz 0,3792(9)
	mr 11,9
	cmpwi 0,0,0
	bc 12,2,.L6
.L19:
	li 0,0
	addi 28,1,184
	stw 0,3792(11)
	lis 4,.LC0@ha
	mr 3,28
	lwz 5,84(29)
	la 4,.LC0@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl sprintf
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,0
	mtlr 0
	blrl
.L6:
	lwz 0,1284(1)
	mtlr 0
	lmw 25,1236(1)
	lfd 30,1264(1)
	lfd 31,1272(1)
	la 1,1280(1)
	blr
.Lfe1:
	.size	 UpdateChaseCam,.Lfe1-UpdateChaseCam
	.section	".rodata"
	.align 3
.LC11:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ChaseNext
	.type	 ChaseNext,@function
ChaseNext:
	stwu 1,-16(1)
	lwz 8,84(3)
	lwz 7,3788(8)
	cmpwi 0,7,0
	bc 12,2,.L22
	lis 9,g_edicts@ha
	mr 6,8
	lwz 11,g_edicts@l(9)
	lis 0,0xdb43
	lis 5,0x4330
	ori 0,0,47903
	lis 9,maxclients@ha
	mr 8,11
	lwz 10,maxclients@l(9)
	subf 11,11,7
	lis 9,.LC11@ha
	mullw 11,11,0
	la 9,.LC11@l(9)
	lfs 12,20(10)
	mr 7,6
	lfd 13,0(9)
	srawi 11,11,2
	mulli 0,11,892
	add 10,0,8
.L30:
	addi 11,11,1
	xoris 0,11,0x8000
	addi 10,10,892
	stw 0,12(1)
	stw 5,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,1,.L27
	addi 10,8,892
	li 11,1
.L27:
	mr 9,10
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L26
	lwz 0,248(9)
	cmpwi 0,0,0
	bc 4,2,.L25
.L26:
	lwz 0,3788(7)
	cmpw 0,9,0
	bc 4,2,.L30
.L25:
	stw 9,3788(6)
	li 0,1
	lwz 9,84(3)
	stw 0,3792(9)
.L22:
	la 1,16(1)
	blr
.Lfe2:
	.size	 ChaseNext,.Lfe2-ChaseNext
	.align 2
	.globl ChasePrev
	.type	 ChasePrev,@function
ChasePrev:
	stwu 1,-16(1)
	lwz 10,84(3)
	lwz 8,3788(10)
	cmpwi 0,8,0
	bc 12,2,.L31
	lis 9,g_edicts@ha
	lis 11,0xdb43
	lwz 0,g_edicts@l(9)
	ori 11,11,47903
	mr 5,10
	lis 9,maxclients@ha
	mr 7,0
	lwz 6,maxclients@l(9)
	subf 0,0,8
	mullw 0,0,11
	mr 8,5
	srawi 10,0,2
.L39:
	addic. 10,10,-1
	bc 12,1,.L36
	lfs 0,20(6)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 10,12(1)
.L36:
	mulli 0,10,892
	add 11,7,0
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L35
	lwz 0,248(11)
	cmpwi 0,0,0
	bc 4,2,.L34
.L35:
	lwz 0,3788(8)
	cmpw 0,11,0
	bc 4,2,.L39
.L34:
	stw 11,3788(5)
	li 0,1
	lwz 9,84(3)
	stw 0,3792(9)
.L31:
	la 1,16(1)
	blr
.Lfe3:
	.size	 ChasePrev,.Lfe3-ChasePrev
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
