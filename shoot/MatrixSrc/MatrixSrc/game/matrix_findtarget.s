	.file	"matrix_findtarget.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"misc_explobox"
	.align 2
.LC1:
	.long 0x41800000
	.align 2
.LC2:
	.long 0x447a0000
	.align 2
.LC3:
	.long 0x43340000
	.align 2
.LC4:
	.long 0x43b40000
	.align 3
.LC5:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Matrix_SniperZoom
	.type	 Matrix_SniperZoom,@function
Matrix_SniperZoom:
	stwu 1,-128(1)
	mflr 0
	stfd 30,112(1)
	stfd 31,120(1)
	stmw 29,100(1)
	stw 0,132(1)
	lis 9,.LC1@ha
	mr 31,3
	la 9,.LC1@l(9)
	li 30,0
	lfs 30,0(9)
	li 29,0
	b .L23
.L25:
	lwz 0,184(29)
	andi. 11,0,4
	bc 4,2,.L26
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L23
.L26:
	lwz 0,256(31)
	cmpw 0,29,0
	bc 12,2,.L23
	lwz 0,512(29)
	cmpwi 0,0,0
	bc 12,2,.L23
	lwz 0,480(29)
	cmpwi 0,0,0
	bc 4,1,.L23
	mr 3,31
	mr 4,29
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L23
	mr 3,31
	mr 4,29
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L23
	lfs 0,4(31)
	cmpwi 0,30,0
	lfs 13,4(29)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 0,8(29)
	fsubs 0,0,12
	stfs 0,28(1)
	lfs 13,12(29)
	fsubs 13,13,11
	fadds 13,13,30
	stfs 13,32(1)
	bc 12,2,.L33
	addi 3,1,24
	bl VectorLength
	fmr 31,1
	addi 3,1,8
	bl VectorLength
	fcmpu 0,31,1
	bc 4,0,.L23
.L33:
	lfs 0,24(1)
	mr 30,29
	lfs 13,28(1)
	lfs 12,32(1)
	stfs 0,8(1)
	stfs 13,12(1)
	stfs 12,16(1)
.L23:
	lis 9,.LC2@ha
	mr 3,29
	la 9,.LC2@l(9)
	addi 4,31,4
	lfs 1,0(9)
	bl findradius
	mr. 29,3
	bc 4,2,.L25
	cmpwi 0,30,0
	bc 12,2,.L35
	addi 3,1,8
	addi 29,1,56
	bl VectorNormalize
	addi 3,1,8
	mr 4,29
	bl vectoangles
	lis 11,.LC3@ha
	li 0,2
	lwz 9,84(31)
	la 11,.LC3@l(11)
	mtctr 0
	addi 10,1,40
	lfs 11,0(11)
	mr 8,10
	addi 9,9,3668
	lis 11,.LC4@ha
	la 11,.LC4@l(11)
	lfs 12,0(11)
	li 11,0
.L39:
	lfs 0,0(9)
	lfsx 13,11,29
	addi 9,9,4
	fsubs 0,0,13
	fabs 0,0
	fcmpu 0,0,11
	stfsx 0,11,8
	bc 4,1,.L38
	fsubs 0,12,0
	stfsx 0,11,10
.L38:
	addi 11,11,4
	bdnz .L39
	lfs 0,44(1)
	li 0,0
	lfs 1,40(1)
	stw 0,48(1)
	fmuls 0,0,0
	fmadds 1,1,1,0
	bl sqrt
	fctiwz 0,1
	stfd 0,88(1)
	lwz 11,92(1)
	addi 0,11,5
	add 11,0,0
	cmpwi 0,11,89
	bc 12,1,.L42
	xoris 11,11,0x8000
	lis 0,0x4330
	lwz 10,84(31)
	stw 11,92(1)
	lis 11,.LC5@ha
	stw 0,88(1)
	la 11,.LC5@l(11)
	lfd 0,88(1)
	lfd 13,0(11)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(10)
	b .L35
.L42:
	lwz 9,84(31)
	lis 0,0x42b4
	stw 0,112(9)
.L35:
	lwz 0,132(1)
	mtlr 0
	lmw 29,100(1)
	lfd 30,112(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe1:
	.size	 Matrix_SniperZoom,.Lfe1-Matrix_SniperZoom
	.section	".rodata"
	.align 2
.LC6:
	.string	"schdown"
	.align 2
.LC7:
	.string	"schup"
	.align 2
.LC8:
	.string	"schleft"
	.align 2
.LC9:
	.string	"schright"
	.align 2
.LC11:
	.string	"schhit"
	.align 2
.LC12:
	.string	"blank"
	.align 2
.LC10:
	.long 0x44bb8000
	.align 2
.LC13:
	.long 0x41800000
	.align 2
.LC14:
	.long 0x45fa0000
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC16:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl MatrixSniperHud
	.type	 MatrixSniperHud,@function
MatrixSniperHud:
	stwu 1,-288(1)
	mflr 0
	stfd 31,280(1)
	stmw 27,260(1)
	stw 0,292(1)
	mr 31,3
	li 28,0
	li 29,0
	b .L55
.L57:
	lwz 0,184(29)
	andi. 5,0,4
	bc 4,2,.L58
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L55
.L58:
	lwz 0,256(31)
	cmpw 0,29,0
	bc 12,2,.L55
	lwz 0,512(29)
	cmpwi 0,0,0
	bc 12,2,.L55
	lwz 0,480(29)
	cmpwi 0,0,0
	bc 4,1,.L55
	mr 3,31
	mr 4,29
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L55
	mr 3,31
	mr 4,29
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L55
	lfs 0,4(31)
	lis 5,.LC13@ha
	cmpwi 0,28,0
	lfs 13,4(29)
	la 5,.LC13@l(5)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	lfs 10,0(5)
	stfs 13,24(1)
	lfs 0,8(29)
	fsubs 0,0,12
	stfs 0,28(1)
	lfs 13,12(29)
	fsubs 13,13,11
	fadds 13,13,10
	stfs 13,32(1)
	bc 12,2,.L65
	addi 3,1,24
	bl VectorLength
	fmr 31,1
	addi 3,1,8
	bl VectorLength
	fcmpu 0,31,1
	bc 4,0,.L55
.L65:
	lfs 0,24(1)
	mr 28,29
	lfs 13,28(1)
	lfs 12,32(1)
	stfs 0,8(1)
	stfs 13,12(1)
	stfs 12,16(1)
.L55:
	lis 5,.LC14@ha
	addi 4,31,4
	la 5,.LC14@l(5)
	mr 3,29
	lfs 1,0(5)
	mr 30,4
	bl findradius
	mr. 29,3
	bc 4,2,.L57
	cmpwi 0,28,0
	bc 12,2,.L67
	addi 3,1,8
	bl VectorNormalize
	addi 3,1,8
	addi 4,1,56
	bl vectoangles
	lfs 11,56(1)
	lfs 12,60(1)
	fmr 13,11
	fmr 0,12
	fabs 13,13
	fabs 0,0
	fcmpu 0,13,0
	bc 4,1,.L68
	lwz 9,84(31)
	lfs 0,3668(9)
	fcmpu 0,0,11
	bc 4,1,.L69
	lis 9,gi+40@ha
	lis 3,.LC6@ha
	lwz 0,gi+40@l(9)
	la 3,.LC6@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,160(9)
.L69:
	lwz 9,84(31)
	lfs 13,56(1)
	lfs 0,3668(9)
	fcmpu 0,0,13
	bc 4,0,.L71
	lis 9,gi+40@ha
	lis 3,.LC7@ha
	lwz 0,gi+40@l(9)
	la 3,.LC7@l(3)
	b .L83
.L68:
	lwz 9,84(31)
	lfs 0,3672(9)
	fcmpu 0,0,12
	bc 4,0,.L72
	lis 9,gi+40@ha
	lis 3,.LC8@ha
	lwz 0,gi+40@l(9)
	la 3,.LC8@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,160(9)
.L72:
	lwz 9,84(31)
	lfs 13,60(1)
	lfs 0,3672(9)
	fcmpu 0,0,13
	bc 4,1,.L71
	lis 9,gi+40@ha
	lis 3,.LC9@ha
	lwz 0,gi+40@l(9)
	la 3,.LC9@l(3)
.L83:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,160(9)
.L71:
	lwz 3,84(31)
	addi 28,1,72
	addi 29,1,88
	li 6,0
	li 5,0
	mr 4,28
	addi 3,3,3668
	bl AngleVectors
	mr 27,29
	lis 9,.LC10@ha
	mr 5,29
	lfs 1,.LC10@l(9)
	mr 4,28
	mr 3,30
	bl VectorMA
	lwz 9,508(31)
	lis 10,0x4330
	lis 5,.LC15@ha
	lwz 8,84(31)
	lis 0,0x40e0
	addi 9,9,-8
	la 5,.LC15@l(5)
	stw 0,220(1)
	xoris 9,9,0x8000
	lfd 13,0(5)
	li 7,0
	stw 9,252(1)
	addi 6,1,216
	stw 10,248(1)
	lfd 0,248(1)
	stw 7,104(1)
	stw 7,216(1)
	fsub 0,0,13
	stw 0,108(1)
	frsp 0,0
	stfs 0,224(1)
	stfs 0,112(1)
	lwz 0,716(8)
	cmpwi 0,0,1
	bc 4,2,.L74
	lis 0,0xc0e0
	stw 0,220(1)
	b .L75
.L74:
	cmpwi 0,0,2
	bc 4,2,.L75
	stw 7,4(6)
.L75:
	addi 5,1,72
	mr 3,30
	addi 4,1,216
	addi 6,1,120
	addi 7,1,136
	bl G_ProjectSource
	lis 9,gi@ha
	lis 5,vec3_origin@ha
	la 30,gi@l(9)
	la 5,vec3_origin@l(5)
	lwz 11,48(30)
	lis 9,0x202
	mr 6,5
	mr 7,27
	addi 3,1,152
	addi 4,1,136
	mr 8,31
	mtlr 11
	ori 9,9,3
	blrl
	lis 5,.LC16@ha
	lfs 13,160(1)
	la 5,.LC16@l(5)
	lfs 0,0(5)
	fcmpu 0,13,0
	bc 4,0,.L80
	lwz 9,204(1)
	cmpwi 0,9,0
	bc 12,2,.L80
	lwz 0,512(9)
	cmpwi 0,0,0
	bc 12,2,.L80
	lwz 0,40(30)
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	b .L84
.L67:
	lis 9,gi+40@ha
	lis 3,.LC12@ha
	lwz 0,gi+40@l(9)
	la 3,.LC12@l(3)
.L84:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,160(9)
.L80:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L81
	lwz 9,84(31)
	li 0,0
	b .L85
.L81:
	lwz 9,84(31)
	li 0,1
.L85:
	sth 0,182(9)
	lwz 0,292(1)
	mtlr 0
	lmw 27,260(1)
	lfd 31,280(1)
	la 1,288(1)
	blr
.Lfe2:
	.size	 MatrixSniperHud,.Lfe2-MatrixSniperHud
	.section	".rodata"
	.align 3
.LC17:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC18:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl MatrixOlympics
	.type	 MatrixOlympics,@function
MatrixOlympics:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	li 9,0
	lwz 0,492(31)
	li 30,0
	cmpwi 0,0,0
	bc 4,2,.L44
	lis 10,.LC17@ha
	lis 7,0x4330
	la 10,.LC17@l(10)
	addi 8,31,380
	lfd 11,0(10)
	addi 10,31,376
.L49:
	xoris 0,9,0x8000
	lfs 13,0(10)
	addi 10,10,4
	stw 0,20(1)
	mr 11,9
	cmpw 0,10,8
	stw 7,16(1)
	lfd 0,16(1)
	fsub 0,0,11
	frsp 0,0
	fmadds 13,13,13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 9,20(1)
	bc 4,1,.L49
	xoris 0,9,0x8000
	lis 11,0x4330
	lis 10,.LC17@ha
	stw 0,20(1)
	la 10,.LC17@l(10)
	stw 11,16(1)
	lfd 1,16(1)
	lfd 0,0(10)
	fsub 1,1,0
	bl sqrt
	fctiwz 0,1
	stfd 0,16(1)
	lwz 9,20(1)
	cmpwi 0,9,490
	bc 4,1,.L51
	lwz 0,1032(31)
	cmpwi 0,0,0
	bc 4,2,.L51
	lis 9,.LC18@ha
	lis 11,level+4@ha
	la 9,.LC18@l(9)
	lfs 0,level+4@l(11)
	lfs 12,0(9)
	fmuls 0,0,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 10,9,1
	bc 12,2,.L52
	mr 3,31
	bl SpawnShadow
.L52:
	li 30,1
.L51:
	lfs 0,384(31)
	xori 11,30,1
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpwi 7,9,290
	mfcr 0
	rlwinm 0,0,30,1
	and. 9,0,11
	bc 12,2,.L44
	lwz 0,1032(31)
	cmpwi 0,0,0
	bc 4,2,.L44
	li 0,1
	stw 0,1032(31)
.L44:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 MatrixOlympics,.Lfe3-MatrixOlympics
	.section	".rodata"
	.align 3
.LC19:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Matrix_FindTarget
	.type	 Matrix_FindTarget,@function
Matrix_FindTarget:
	stwu 1,-192(1)
	mflr 0
	stfd 31,184(1)
	stmw 27,164(1)
	stw 0,196(1)
	xoris 4,4,0x8000
	stw 4,156(1)
	lis 0,0x4330
	lis 11,.LC19@ha
	la 11,.LC19@l(11)
	stw 0,152(1)
	mr 30,3
	lfd 0,0(11)
	addi 29,30,4
	li 31,0
	lfd 31,152(1)
	lis 11,gi@ha
	lis 28,.LC0@ha
	la 27,gi@l(11)
	fsub 31,31,0
.L21:
	frsp 1,31
	mr 3,31
	addi 4,30,4
	bl findradius
	mr. 31,3
	bc 12,2,.L12
	cmpw 0,31,30
	bc 12,2,.L21
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L21
	lwz 0,184(31)
	andi. 9,0,4
	bc 4,2,.L16
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L16
	lwz 3,280(31)
	la 4,.LC0@l(28)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L21
.L16:
	lwz 0,48(27)
	lis 9,0x600
	mr 4,29
	addi 7,31,4
	mr 8,30
	addi 3,1,72
	li 5,0
	mtlr 0
	li 6,0
	ori 9,9,1
	blrl
.L19:
	b .L19
.L12:
	li 3,0
	lwz 0,196(1)
	mtlr 0
	lmw 27,164(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe4:
	.size	 Matrix_FindTarget,.Lfe4-Matrix_FindTarget
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
