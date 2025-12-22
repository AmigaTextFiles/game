	.file	"matrix_movement.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC0:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC1:
	.long 0x3f800000
	.align 2
.LC2:
	.long 0x40a00000
	.align 2
.LC3:
	.long 0x42000000
	.align 2
.LC4:
	.long 0x43960000
	.align 2
.LC5:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl MatrixJump
	.type	 MatrixJump,@function
MatrixJump:
	stwu 1,-240(1)
	mflr 0
	stfd 29,216(1)
	stfd 30,224(1)
	stfd 31,232(1)
	stmw 19,164(1)
	stw 0,244(1)
	lis 9,level@ha
	mr 31,3
	la 19,level@l(9)
	lis 11,gi@ha
	lis 9,.LC0@ha
	la 20,gi@l(11)
	la 9,.LC0@l(9)
	addi 28,31,4
	lfd 31,0(9)
	addi 24,1,104
	lis 21,vec3_origin@ha
	lis 9,.LC1@ha
	li 25,0
	la 9,.LC1@l(9)
	lis 22,0x4330
	lfs 29,0(9)
	addi 29,1,72
	addi 30,1,88
	lis 9,.LC2@ha
	li 26,0
	la 9,.LC2@l(9)
	lis 23,0x4396
	lfs 30,0(9)
	li 27,4
.L10:
	xoris 0,26,0x8000
	stw 25,104(1)
	stw 0,156(1)
	li 6,0
	mr 3,24
	stw 22,152(1)
	mr 4,29
	li 5,0
	lfd 0,152(1)
	addi 26,26,90
	stw 25,112(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,108(1)
	bl AngleVectors
	lis 9,.LC3@ha
	mr 3,28
	la 9,.LC3@l(9)
	mr 4,29
	lfs 1,0(9)
	mr 5,30
	bl VectorMA
	lwz 11,48(20)
	la 5,vec3_origin@l(21)
	addi 3,1,8
	mr 4,28
	li 9,3
	mr 6,5
	mr 7,30
	mtlr 11
	mr 8,31
	blrl
	lfs 0,16(1)
	lis 9,.LC4@ha
	addi 3,1,32
	la 9,.LC4@l(9)
	addi 4,1,120
	lfs 1,0(9)
	fcmpu 0,0,29
	bc 4,0,.L9
	bl VectorScale
	lfs 13,924(31)
	li 0,0
	lis 9,.LC5@ha
	lfs 0,124(1)
	la 9,.LC5@l(9)
	lfs 12,120(1)
	fsubs 13,13,30
	stw 0,552(31)
	stfs 0,380(31)
	stfs 12,376(31)
	stfs 13,924(31)
	stw 23,384(31)
	lfs 0,4(19)
	lfs 11,0(9)
	li 9,3
	stw 9,1000(31)
	fadds 0,0,11
	stfs 0,904(31)
.L9:
	addic. 27,27,-1
	bc 4,2,.L10
	lwz 0,244(1)
	mtlr 0
	lmw 19,164(1)
	lfd 29,216(1)
	lfd 30,224(1)
	lfd 31,232(1)
	la 1,240(1)
	blr
.Lfe1:
	.size	 MatrixJump,.Lfe1-MatrixJump
	.section	".rodata"
	.align 3
.LC6:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC7:
	.long 0x46fffe00
	.align 2
.LC8:
	.long 0xc2c80000
	.align 3
.LC9:
	.long 0x3fb00000
	.long 0x0
	.align 2
.LC10:
	.long 0x0
	.align 2
.LC11:
	.long 0xc3b40000
	.align 2
.LC12:
	.long 0x43b40000
	.align 3
.LC13:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC14:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC15:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl MatrixFlip
	.type	 MatrixFlip,@function
MatrixFlip:
	stwu 1,-80(1)
	mflr 0
	stw 31,76(1)
	stw 0,84(1)
	mr 31,3
	addi 4,1,8
	lwz 3,84(31)
	addi 5,1,24
	addi 6,1,40
	addi 3,3,3668
	bl AngleVectors
	lfs 13,12(1)
	lfs 0,380(31)
	lfs 12,376(31)
	lfs 11,8(1)
	fmuls 0,0,13
	lwz 0,492(31)
	lfs 13,384(31)
	cmpwi 0,0,0
	fmadds 12,12,11,0
	lfs 0,16(1)
	fmadds 13,13,0,12
	bc 4,2,.L13
	lwz 0,1000(31)
	cmpwi 0,0,0
	bc 4,2,.L15
	lwz 0,996(31)
	cmpwi 0,0,0
	bc 12,2,.L15
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,1,.L15
	lha 0,938(31)
	cmpwi 0,0,0
	bc 4,1,.L16
	li 0,1
	stw 0,1000(31)
.L16:
	lha 0,938(31)
	cmpwi 0,0,0
	bc 4,0,.L17
	li 0,2
	stw 0,1000(31)
.L17:
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L15
	li 0,3
	stw 0,1000(31)
.L15:
	lwz 0,1000(31)
	cmpwi 0,0,3
	bc 4,2,.L19
	lis 9,sv_gravity@ha
	lis 10,.LC9@ha
	lfs 13,16(31)
	lwz 11,sv_gravity@l(9)
	la 10,.LC9@l(10)
	li 0,4
	lfd 12,0(10)
	lfs 0,20(11)
	li 10,154
	lwz 9,84(31)
	fmul 0,0,12
	fsub 13,13,0
	frsp 13,13
	stfs 13,16(31)
	stw 0,3728(9)
	stw 10,56(31)
.L19:
	lwz 0,1000(31)
	cmpwi 0,0,6
	bc 4,2,.L20
	lis 9,sv_gravity@ha
	lfs 13,16(31)
	lis 11,.LC6@ha
	lwz 10,sv_gravity@l(9)
	lfd 12,.LC6@l(11)
	lfs 0,20(10)
	fmadd 0,0,12,13
	frsp 0,0
	stfs 0,16(31)
.L20:
	lwz 0,1000(31)
	cmpwi 0,0,2
	bc 4,2,.L21
	lis 11,.LC9@ha
	lis 9,sv_gravity@ha
	lfs 13,24(31)
	la 11,.LC9@l(11)
	li 10,4
	lfd 12,0(11)
	li 0,154
	lwz 11,sv_gravity@l(9)
	lis 9,.LC10@ha
	lfs 0,20(11)
	la 9,.LC10@l(9)
	lfs 11,0(9)
	lwz 9,84(31)
	fmadd 0,0,12,13
	frsp 0,0
	stfs 0,24(31)
	stw 10,3728(9)
	lfs 0,24(31)
	stw 0,56(31)
	fcmpu 0,0,11
	bc 4,2,.L22
	li 0,0
	stw 0,1000(31)
.L22:
	lis 10,.LC11@ha
	lfs 13,24(31)
	la 10,.LC11@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,0,.L21
	li 0,0
	stw 0,1000(31)
.L21:
	lwz 0,1000(31)
	cmpwi 0,0,1
	bc 4,2,.L24
	lis 11,.LC9@ha
	lis 9,sv_gravity@ha
	lfs 13,24(31)
	la 11,.LC9@l(11)
	li 10,4
	lfd 12,0(11)
	li 0,154
	lwz 11,sv_gravity@l(9)
	lis 9,.LC10@ha
	lfs 0,20(11)
	la 9,.LC10@l(9)
	lfs 11,0(9)
	lwz 9,84(31)
	fmul 0,0,12
	fsub 13,13,0
	frsp 13,13
	stfs 13,24(31)
	stw 10,3728(9)
	lfs 0,24(31)
	stw 0,56(31)
	fcmpu 0,0,11
	bc 4,2,.L25
	li 0,0
	stw 0,1000(31)
.L25:
	lis 10,.LC12@ha
	lfs 13,24(31)
	la 10,.LC12@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L24
	li 0,0
	stw 0,1000(31)
.L24:
	lwz 9,1000(31)
	addi 11,31,376
	addi 9,9,-7
	cmplwi 0,9,1
	bc 12,1,.L27
	cmpwi 0,11,0
	bc 4,2,.L27
	stw 11,1000(31)
.L27:
	lwz 0,1000(31)
	cmpwi 0,0,7
	bc 4,2,.L28
	cmpwi 0,11,0
	bc 12,2,.L28
	lis 0,0x4387
	b .L63
.L28:
	lwz 0,1000(31)
	cmpwi 0,0,8
	bc 4,2,.L30
	cmpwi 0,11,0
	bc 12,2,.L61
	lis 0,0x42b4
	b .L63
.L30:
	cmpwi 0,11,0
	bc 4,2,.L29
.L61:
	li 0,0
.L63:
	stw 0,24(31)
.L29:
	lwz 0,1000(31)
	cmpwi 0,0,5
	bc 4,2,.L33
	lwz 0,1040(31)
	cmpwi 0,0,2
	bc 4,2,.L34
	li 0,0
	lis 9,0x4387
	lis 11,0x4248
	stw 0,16(31)
	stw 9,24(31)
	stw 11,384(31)
.L34:
	lwz 0,1040(31)
	cmpwi 0,0,1
	bc 4,2,.L35
	li 0,0
	lis 9,0x42b4
	lis 11,0x4248
	stw 0,16(31)
	stw 9,24(31)
	stw 11,384(31)
.L35:
	lwz 0,1040(31)
	cmpwi 0,0,0
	bc 4,2,.L36
	lis 0,0x4387
	li 9,0
	lis 11,0x4396
	stw 0,16(31)
	stw 9,24(31)
	stw 11,384(31)
.L36:
	lwz 0,1040(31)
	cmpwi 0,0,3
	bc 4,2,.L37
	li 0,0
	lis 11,0x4334
	lwz 10,84(31)
	stw 0,16(31)
	lis 9,0x4396
	stw 11,24(31)
	lfs 0,3672(10)
	stw 9,384(31)
	stfs 0,20(31)
.L37:
	lwz 9,84(31)
	lis 0,0xbf80
	stw 0,3604(9)
	lwz 11,56(31)
	cmpwi 0,11,45
	bc 4,2,.L33
	lwz 9,84(31)
	li 0,4
	li 11,39
	stw 0,3728(9)
	stw 11,56(31)
.L33:
	lwz 0,1000(31)
	cmpwi 0,0,9
	bc 4,2,.L39
	lwz 0,1092(31)
	cmpwi 0,0,4
	bc 4,2,.L40
	lwz 11,84(31)
	li 0,6
	li 10,45
	li 8,43
	stw 0,3728(11)
	lwz 9,84(31)
	stw 10,56(31)
	stw 8,3724(9)
.L40:
	lwz 0,1092(31)
	cmpwi 0,0,3
	bc 4,2,.L41
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,68(1)
	lis 10,.LC13@ha
	lis 11,.LC7@ha
	la 10,.LC13@l(10)
	stw 0,64(1)
	lfd 13,0(10)
	lfd 0,64(1)
	lis 10,.LC14@ha
	lfs 12,.LC7@l(11)
	la 10,.LC14@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L42
	lwz 11,84(31)
	li 0,6
	li 10,44
	li 8,43
	b .L64
.L42:
	lwz 11,84(31)
	li 0,6
	li 10,41
	li 8,40
.L64:
	stw 0,3728(11)
	lwz 9,84(31)
	stw 10,56(31)
	stw 8,3724(9)
.L41:
	lwz 0,1092(31)
	cmpwi 0,0,2
	bc 4,2,.L44
	lwz 11,84(31)
	li 0,4
	li 10,113
	li 8,120
	stw 0,3728(11)
	lwz 9,84(31)
	stw 10,56(31)
	stw 8,3724(9)
.L44:
	lwz 0,1092(31)
	cmpwi 0,0,1
	bc 4,2,.L45
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,68(1)
	lis 10,.LC13@ha
	lis 11,.LC7@ha
	la 10,.LC13@l(10)
	stw 0,64(1)
	lfd 13,0(10)
	lfd 0,64(1)
	lis 10,.LC14@ha
	lfs 12,.LC7@l(11)
	la 10,.LC14@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L46
	lwz 11,84(31)
	li 0,4
	li 10,58
	li 8,60
	b .L65
.L46:
	lwz 11,84(31)
	li 0,4
	li 10,62
	li 8,64
.L65:
	stw 0,3728(11)
	lwz 9,84(31)
	stw 10,56(31)
	stw 8,3724(9)
.L45:
	lwz 0,1092(31)
	cmpwi 0,0,5
	bc 4,2,.L48
	lwz 11,84(31)
	li 0,4
	li 10,72
	li 8,75
	stw 0,3728(11)
	lwz 9,84(31)
	stw 10,56(31)
	stw 8,3724(9)
.L48:
	li 0,0
	stw 0,1092(31)
.L39:
	lwz 9,84(31)
	lwz 11,56(31)
	lwz 0,3724(9)
	cmpw 0,0,11
	bc 4,2,.L49
	lwz 0,1000(31)
	cmpwi 0,0,9
	bc 4,2,.L49
	li 0,0
	stw 0,1000(31)
.L49:
	lwz 0,1000(31)
	cmpwi 0,0,3
	bc 4,2,.L50
	lis 11,.LC10@ha
	lfs 13,16(31)
	la 11,.LC10@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L51
	li 0,0
	stw 0,1000(31)
.L51:
	lis 9,.LC11@ha
	lfs 13,16(31)
	la 9,.LC11@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L50
	li 0,0
	stw 0,1000(31)
.L50:
	lwz 0,1000(31)
	cmpwi 0,0,6
	bc 4,2,.L53
	lis 10,.LC10@ha
	lfs 13,16(31)
	la 10,.LC10@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,2,.L54
	li 0,0
	stw 0,1000(31)
.L54:
	lis 11,.LC12@ha
	lfs 13,16(31)
	la 11,.LC12@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L53
	li 0,0
	stw 0,1000(31)
.L53:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L62
	lwz 0,1000(31)
	cmpwi 0,0,6
	bc 12,2,.L56
	cmpwi 0,0,8
	bc 12,2,.L56
	cmpwi 0,0,7
	bc 12,2,.L56
	cmpwi 0,0,9
	bc 12,2,.L56
	li 0,0
	stw 0,1000(31)
.L56:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L58
.L62:
	lwz 0,1000(31)
	cmpwi 0,0,0
	bc 4,2,.L58
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L57
.L58:
	li 0,0
	stw 0,1032(31)
.L57:
	lwz 0,1032(31)
	cmpwi 0,0,0
	bc 12,2,.L13
	lis 9,.LC15@ha
	lis 11,level+4@ha
	la 9,.LC15@l(9)
	lfs 0,level+4@l(11)
	lfs 12,0(9)
	fmuls 0,0,12
	fctiwz 13,0
	stfd 13,64(1)
	lwz 9,68(1)
	andi. 10,9,1
	bc 12,2,.L13
	mr 3,31
	bl SpawnShadow
.L13:
	lwz 0,84(1)
	mtlr 0
	lwz 31,76(1)
	la 1,80(1)
	blr
.Lfe2:
	.size	 MatrixFlip,.Lfe2-MatrixFlip
	.section	".rodata"
	.align 2
.LC16:
	.long 0xc3480000
	.align 2
.LC17:
	.long 0x42b40000
	.align 2
.LC18:
	.long 0x3f800000
	.align 2
.LC19:
	.long 0x41c00000
	.align 2
.LC20:
	.long 0x42400000
	.align 2
.LC21:
	.long 0x43960000
	.align 2
.LC22:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl MatrixRunUpWalls
	.type	 MatrixRunUpWalls,@function
MatrixRunUpWalls:
	stwu 1,-272(1)
	mflr 0
	stfd 30,256(1)
	stfd 31,264(1)
	stmw 21,212(1)
	stw 0,276(1)
	mr 31,3
	li 27,0
	bl MatrixRunRAlongWalls
	mr 3,31
	bl MatrixRunLAlongWalls
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L66
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L66
	lwz 21,552(31)
	cmpwi 0,21,0
	bc 4,2,.L66
	lha 0,940(31)
	cmpwi 0,0,0
	bc 12,1,.L70
	stw 27,1000(31)
	b .L66
.L70:
	lis 8,.LC16@ha
	lfs 13,384(31)
	la 8,.LC16@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 12,0,.L66
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,1,.L66
	lwz 9,84(31)
	lis 11,.LC17@ha
	lis 8,.LC18@ha
	la 11,.LC17@l(11)
	addi 26,1,56
	lfs 0,3668(9)
	la 8,.LC18@l(8)
	li 22,0
	lfs 30,0(11)
	addi 29,1,24
	addi 4,1,8
	addi 25,1,72
	li 6,0
	lfs 31,0(8)
	stfs 0,56(1)
	mr 3,26
	li 5,0
	lfs 13,3672(9)
	addi 30,31,4
	lis 23,vec3_origin@ha
	stfs 13,60(1)
	fsubs 12,13,30
	lfs 0,3676(9)
	stw 22,56(1)
	stfs 12,60(1)
	stfs 0,64(1)
	bl AngleVectors
	lis 8,.LC19@ha
	addi 4,1,8
	la 8,.LC19@l(8)
	mr 3,30
	lfs 1,0(8)
	mr 5,29
	bl VectorMA
	lis 9,gi@ha
	la 5,vec3_origin@l(23)
	la 24,gi@l(9)
	mr 3,25
	lwz 11,48(24)
	lis 9,0x1
	mr 4,30
	mr 6,5
	mr 7,29
	mr 8,31
	ori 9,9,3
	mtlr 11
	blrl
	lfs 0,80(1)
	fcmpu 0,0,31
	bc 4,0,.L73
	lfs 12,84(1)
	li 0,1
	li 27,1
	lfs 0,88(1)
	lfs 13,92(1)
	stw 0,1040(31)
	stfs 12,148(1)
	stfs 0,152(1)
	stfs 13,156(1)
.L73:
	lwz 9,84(31)
	addi 4,1,8
	li 6,0
	lwz 11,116(1)
	mr 3,26
	li 5,0
	lfs 0,3668(9)
	lwz 0,16(11)
	stfs 0,56(1)
	rlwinm 28,0,30,31,31
	lfs 13,3672(9)
	stfs 13,60(1)
	fadds 12,13,30
	lfs 0,3676(9)
	stw 22,56(1)
	stfs 12,60(1)
	stfs 0,64(1)
	bl AngleVectors
	lis 8,.LC19@ha
	addi 4,1,8
	la 8,.LC19@l(8)
	mr 3,30
	lfs 1,0(8)
	mr 5,29
	bl VectorMA
	lwz 11,48(24)
	la 5,vec3_origin@l(23)
	lis 9,0x1
	mr 8,31
	ori 9,9,3
	mr 3,25
	mr 4,30
	mtlr 11
	mr 6,5
	mr 7,29
	blrl
	lfs 0,80(1)
	xori 9,27,1
	fcmpu 7,0,31
	mfcr 0
	rlwinm 0,0,29,1
	and. 8,0,9
	bc 12,2,.L75
	lfs 12,84(1)
	li 0,2
	li 27,1
	lfs 0,88(1)
	lfs 13,92(1)
	stw 0,1040(31)
	stfs 12,148(1)
	stfs 0,152(1)
	stfs 13,156(1)
.L75:
	lwz 11,84(31)
	lis 10,0x4387
	addi 4,1,8
	lwz 9,116(1)
	li 6,0
	mr 3,26
	lfs 0,3668(11)
	li 5,0
	lwz 0,16(9)
	stfs 0,56(1)
	andi. 9,0,4
	lfs 0,3672(11)
	mfcr 9
	rlwinm 9,9,3,1
	stfs 0,60(1)
	neg 9,9
	lfs 0,3676(11)
	addi 0,9,1
	and 9,28,9
	stw 10,56(1)
	or 28,9,0
	stfs 0,64(1)
	bl AngleVectors
	lis 8,.LC20@ha
	addi 4,1,8
	la 8,.LC20@l(8)
	mr 3,30
	lfs 1,0(8)
	mr 5,29
	bl VectorMA
	lwz 11,48(24)
	la 5,vec3_origin@l(23)
	lis 9,0x1
	mr 8,31
	ori 9,9,3
	mr 3,25
	mr 4,30
	mtlr 11
	mr 6,5
	mr 7,29
	blrl
	lfs 0,80(1)
	xori 9,27,1
	fcmpu 7,0,31
	mfcr 0
	rlwinm 0,0,29,1
	and. 8,0,9
	bc 12,2,.L77
	lfs 12,84(1)
	li 0,3
	li 27,1
	lfs 0,88(1)
	lfs 13,92(1)
	stw 0,1040(31)
	stfs 12,148(1)
	stfs 0,152(1)
	stfs 13,156(1)
.L77:
	lwz 11,84(31)
	addi 4,1,8
	li 6,0
	lwz 9,116(1)
	mr 3,26
	li 5,0
	lfs 0,3668(11)
	lwz 0,16(9)
	stfs 0,56(1)
	andi. 9,0,4
	lfs 0,3672(11)
	mfcr 9
	rlwinm 9,9,3,1
	stfs 0,60(1)
	neg 9,9
	lfs 0,3676(11)
	addi 0,9,1
	and 9,28,9
	stw 22,56(1)
	or 28,9,0
	stfs 0,64(1)
	bl AngleVectors
	lis 8,.LC19@ha
	addi 4,1,8
	la 8,.LC19@l(8)
	mr 3,30
	lfs 1,0(8)
	mr 5,29
	bl VectorMA
	lwz 0,48(24)
	la 5,vec3_origin@l(23)
	lis 9,0x1
	mr 8,31
	ori 9,9,3
	mtlr 0
	mr 3,25
	mr 4,30
	mr 7,29
	mr 6,5
	blrl
	lfs 0,80(1)
	xori 9,27,1
	fcmpu 7,0,31
	mfcr 0
	rlwinm 0,0,29,1
	and. 8,0,9
	bc 12,2,.L79
	lfs 0,84(1)
	li 27,1
	lfs 13,88(1)
	lfs 12,92(1)
	stw 21,1040(31)
	stfs 0,148(1)
	stfs 13,152(1)
	stfs 12,156(1)
.L79:
	lwz 9,116(1)
	lwz 0,16(9)
	andi. 9,0,4
	mfcr 9
	rlwinm 9,9,3,1
	neg 9,9
	addi 11,9,1
	and 9,28,9
	or. 28,9,11
	mfcr 0
	rlwinm 0,0,3,1
	and. 11,27,0
	bc 12,2,.L81
	lwz 0,1000(31)
	cmpwi 0,0,5
	bc 12,2,.L82
	lwz 11,84(31)
	li 0,4
	li 10,39
	li 8,45
	li 7,5
	stw 0,3728(11)
	lwz 9,84(31)
	stw 10,56(31)
	stw 8,3724(9)
	stw 7,1000(31)
.L82:
	li 0,1
	stw 0,956(31)
.L81:
	cmpwi 0,28,0
	bc 12,2,.L83
	li 0,0
	stw 0,1000(31)
	stw 0,956(31)
.L83:
	cmpwi 0,27,0
	bc 4,2,.L84
	stw 27,1000(31)
	stw 27,956(31)
.L84:
	lwz 0,956(31)
	cmpwi 0,0,1
	bc 4,2,.L85
	lis 0,0x4396
	stw 0,384(31)
.L85:
	lha 0,936(31)
	cmpwi 0,0,0
	bc 4,0,.L66
	lwz 0,1000(31)
	cmpwi 0,0,5
	bc 4,2,.L66
	lwz 0,1040(31)
	cmpwi 0,0,3
	bc 12,2,.L66
	lfs 12,4(31)
	addi 29,1,40
	lfs 11,148(1)
	mr 3,29
	lfs 13,8(31)
	lfs 0,12(31)
	fsubs 12,12,11
	lfs 10,152(1)
	lfs 11,156(1)
	fsubs 13,13,10
	stfs 12,40(1)
	fsubs 0,0,11
	stfs 13,44(1)
	stfs 0,48(1)
	bl VectorNormalize
	lis 8,.LC21@ha
	mr 3,29
	la 8,.LC21@l(8)
	mr 4,3
	lfs 1,0(8)
	bl VectorScale
	lfs 0,44(1)
	lis 11,0x4396
	li 10,0
	lfs 13,40(1)
	lis 8,.LC22@ha
	lis 9,level+4@ha
	la 8,.LC22@l(8)
	stw 11,384(31)
	li 0,3
	stfs 0,380(31)
	stfs 13,376(31)
	stw 10,552(31)
	lfs 0,level+4@l(9)
	lfs 12,0(8)
	stw 0,1000(31)
	fadds 0,0,12
	stfs 0,904(31)
.L66:
	lwz 0,276(1)
	mtlr 0
	lmw 21,212(1)
	lfd 30,256(1)
	lfd 31,264(1)
	la 1,272(1)
	blr
.Lfe3:
	.size	 MatrixRunUpWalls,.Lfe3-MatrixRunUpWalls
	.section	".rodata"
	.align 2
.LC23:
	.long 0x42b40000
	.align 2
.LC24:
	.long 0x41c00000
	.align 2
.LC25:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl MatrixRunLAlongWalls
	.type	 MatrixRunLAlongWalls,@function
MatrixRunLAlongWalls:
	stwu 1,-160(1)
	mflr 0
	stmw 28,144(1)
	stw 0,164(1)
	mr 31,3
	addic. 0,31,376
	bc 4,2,.L94
	stw 0,1000(31)
	b .L93
.L94:
	lwz 9,1000(31)
	addic 0,9,-1
	subfe 11,0,9
	xori 10,9,8
	addic 9,10,-1
	subfe 0,9,10
	and. 30,0,11
	bc 4,2,.L93
	lwz 9,84(31)
	lis 11,.LC23@ha
	li 0,0
	la 11,.LC23@l(11)
	addi 28,1,24
	lfs 13,3668(9)
	addi 3,1,56
	addi 4,1,8
	lfs 12,0(11)
	li 6,0
	li 5,0
	addi 29,31,4
	stfs 13,56(1)
	lfs 0,3672(9)
	stfs 0,60(1)
	fsubs 12,0,12
	lfs 13,3676(9)
	stw 0,56(1)
	stfs 12,60(1)
	stfs 13,64(1)
	bl AngleVectors
	lis 9,.LC24@ha
	addi 4,1,8
	la 9,.LC24@l(9)
	mr 5,28
	lfs 1,0(9)
	mr 3,29
	bl VectorMA
	lis 9,gi+48@ha
	lis 5,vec3_origin@ha
	lwz 0,gi+48@l(9)
	la 5,vec3_origin@l(5)
	mr 4,29
	li 9,3
	mr 7,28
	addi 3,1,72
	mr 6,5
	mtlr 0
	mr 8,31
	blrl
	lis 9,.LC25@ha
	lfs 13,80(1)
	la 9,.LC25@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L96
	li 0,8
	stw 0,1000(31)
	b .L93
.L96:
	stw 30,1000(31)
.L93:
	lwz 0,164(1)
	mtlr 0
	lmw 28,144(1)
	la 1,160(1)
	blr
.Lfe4:
	.size	 MatrixRunLAlongWalls,.Lfe4-MatrixRunLAlongWalls
	.section	".rodata"
	.align 2
.LC26:
	.string	"cl_forwardspeed"
	.align 2
.LC27:
	.string	"180"
	.align 2
.LC28:
	.string	"cl_sidespeed"
	.align 2
.LC29:
	.string	"cl_upspeed"
	.align 2
.LC30:
	.string	"50"
	.align 2
.LC31:
	.string	"200"
	.align 2
.LC33:
	.string	"matrixjump.wav"
	.align 2
.LC32:
	.long 0x443b8000
	.align 2
.LC34:
	.long 0x42480000
	.align 3
.LC35:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC36:
	.long 0x3fe80000
	.long 0x0
	.align 2
.LC37:
	.long 0x3f800000
	.align 2
.LC38:
	.long 0x0
	.section	".text"
	.align 2
	.globl SuperJump
	.type	 SuperJump,@function
SuperJump:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 29,52(1)
	stw 0,84(1)
	lis 9,.LC34@ha
	mr 31,3
	la 9,.LC34@l(9)
	lfs 12,924(31)
	lfs 11,0(9)
	fcmpu 0,12,11
	bc 12,0,.L104
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L104
	lis 11,level@ha
	lwz 10,84(31)
	lwz 0,level@l(11)
	lis 30,0x4330
	li 29,600
	lis 11,.LC35@ha
	lfs 13,3876(10)
	xoris 0,0,0x8000
	la 11,.LC35@l(11)
	stw 0,44(1)
	stw 30,40(1)
	lfd 30,0(11)
	lfd 0,40(1)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L107
	li 29,400
.L107:
	lfs 0,380(31)
	fsubs 13,12,11
	lfs 1,376(31)
	fmuls 0,0,0
	stfs 13,924(31)
	fmadds 1,1,1,0
	bl sqrt
	lis 9,.LC32@ha
	frsp 1,1
	lfs 0,.LC32@l(9)
	fcmpu 0,1,0
	bc 12,1,.L104
	lwz 3,84(31)
	addi 4,1,8
	li 6,0
	li 5,0
	addi 3,3,3668
	bl AngleVectors
	xoris 0,29,0x8000
	stw 0,44(1)
	addi 3,31,376
	addi 4,1,8
	stw 30,40(1)
	mr 5,3
	lfd 31,40(1)
	fsub 31,31,30
	frsp 1,31
	bl VectorMA
	lfs 0,384(31)
	lis 9,.LC36@ha
	li 0,1
	la 9,.LC36@l(9)
	lis 29,gi@ha
	stw 0,1032(31)
	lfd 13,0(9)
	la 29,gi@l(29)
	lis 3,.LC33@ha
	la 3,.LC33@l(3)
	fmadd 31,31,13,0
	frsp 31,31
	stfs 31,384(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC37@ha
	lwz 0,16(29)
	lis 11,.LC37@ha
	la 9,.LC37@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC37@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC38@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC38@l(9)
	lfs 3,0(9)
	blrl
.L104:
	lwz 0,84(1)
	mtlr 0
	lmw 29,52(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe5:
	.size	 SuperJump,.Lfe5-SuperJump
	.section	".rodata"
	.align 2
.LC40:
	.string	"shadow"
	.align 2
.LC41:
	.string	"players/female/tris.md2"
	.align 2
.LC42:
	.string	"players/cyborg/tris.md2"
	.align 2
.LC43:
	.string	"players/male/tris.md2"
	.align 2
.LC39:
	.long 0x46fffe00
	.align 3
.LC44:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC45:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC46:
	.long 0x0
	.align 2
.LC47:
	.long 0x43340000
	.section	".text"
	.align 2
	.globl SpawnShadow
	.type	 SpawnShadow,@function
SpawnShadow:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	lwz 0,492(29)
	cmpwi 0,0,0
	bc 4,2,.L110
	lis 11,level@ha
	lwz 10,84(29)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC45@ha
	lfs 12,3876(10)
	xoris 0,0,0x8000
	la 11,.LC45@l(11)
	stw 0,28(1)
	stw 8,24(1)
	lfd 13,0(11)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L112
	lwz 0,552(29)
	cmpwi 0,0,0
	bc 12,2,.L112
	bl SpawnWave
	b .L110
.L112:
	bl G_Spawn
	mr 31,3
	mr 4,29
	li 5,84
	crxor 6,6,6
	bl memcpy
	lis 9,.LC46@ha
	lfs 0,376(29)
	la 9,.LC46@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L113
	lfs 0,380(29)
	fcmpu 0,0,13
	bc 4,2,.L113
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 9,.LC45@ha
	lis 10,.LC39@ha
	la 9,.LC45@l(9)
	stw 0,24(1)
	lfd 11,0(9)
	lfd 0,24(1)
	lis 9,.LC47@ha
	lfs 13,.LC39@l(10)
	la 9,.LC47@l(9)
	lfs 10,0(9)
	fsub 0,0,11
	mr 9,11
	frsp 0,0
	fdivs 0,0,13
	fmuls 0,0,10
	fmr 13,0
	fctiwz 12,13
	stfd 12,24(1)
	lwz 9,28(1)
	stw 9,56(31)
.L113:
	li 0,0
	lis 9,.LC40@ha
	stw 0,44(31)
	la 9,.LC40@l(9)
	mr 3,29
	stw 0,48(31)
	stw 0,52(31)
	lfs 0,28(29)
	stfs 0,4(31)
	lfs 13,32(29)
	stfs 13,8(31)
	lfs 0,36(29)
	stfs 0,12(31)
	lfs 13,16(29)
	stfs 13,16(31)
	lfs 0,20(29)
	stfs 0,20(31)
	lfs 13,24(29)
	stw 9,280(31)
	stw 0,248(31)
	stfs 13,24(31)
	stw 0,260(31)
	stw 29,256(31)
	crxor 6,6,6
	bl IsFemale
	cmpwi 0,3,0
	bc 12,2,.L114
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	b .L118
.L114:
	mr 3,29
	crxor 6,6,6
	bl IsNeutral
	cmpwi 0,3,0
	bc 12,2,.L116
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	b .L118
.L116:
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
.L118:
	stw 9,268(31)
	lwz 0,64(31)
	li 11,0
	li 7,100
	li 9,-40
	stw 11,60(31)
	lis 29,level+4@ha
	oris 0,0,0x1000
	stw 9,488(31)
	lis 4,.LC44@ha
	stw 0,64(31)
	lis 9,G_FreeEdict@ha
	lis 5,0xc180
	stw 11,612(31)
	li 0,0
	lis 6,0x4180
	stw 11,608(31)
	la 9,G_FreeEdict@l(9)
	lis 10,0xc1c0
	stw 7,484(31)
	lis 8,0x4200
	lis 11,gi+72@ha
	stw 7,480(31)
	mr 3,31
	lfs 0,level+4@l(29)
	lfd 13,.LC44@l(4)
	stw 9,436(31)
	stw 5,192(31)
	stw 10,196(31)
	stw 6,204(31)
	fadd 0,0,13
	stw 8,208(31)
	stw 0,376(31)
	stw 5,188(31)
	frsp 0,0
	stw 6,200(31)
	stw 0,384(31)
	stw 0,380(31)
	stfs 0,428(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L110:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 SpawnShadow,.Lfe6-SpawnShadow
	.section	".rodata"
	.align 2
.LC48:
	.string	"speedwave"
	.align 2
.LC49:
	.string	"models/objects/speed/tris.md2"
	.align 3
.LC50:
	.long 0x3fd99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SpawnWave
	.type	 SpawnWave,@function
SpawnWave:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 31,3
	lwz 30,492(31)
	cmpwi 0,30,0
	bc 4,2,.L122
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L122
	bl G_Spawn
	li 27,0
	mr 29,3
	li 5,84
	mr 4,31
	crxor 6,6,6
	bl memcpy
	stw 30,44(29)
	addi 3,31,376
	addi 4,29,16
	stw 30,48(29)
	stw 30,52(29)
	lfs 0,28(31)
	stfs 0,4(29)
	lfs 13,32(31)
	stfs 13,8(29)
	lfs 0,36(31)
	stfs 0,12(29)
	bl vectoangles
	lis 9,.LC48@ha
	lis 28,gi@ha
	stw 30,248(29)
	la 9,.LC48@l(9)
	la 28,gi@l(28)
	stw 31,256(29)
	stw 9,280(29)
	lis 3,.LC49@ha
	stw 27,16(29)
	la 3,.LC49@l(3)
	stw 27,24(29)
	stw 30,56(29)
	stw 30,260(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lwz 0,64(29)
	lis 8,level+4@ha
	lis 11,.LC50@ha
	stw 3,40(29)
	lis 9,G_FreeEdict@ha
	lis 7,0xc180
	oris 0,0,0x1000
	lfd 13,.LC50@l(11)
	lis 10,0x4180
	stw 0,64(29)
	la 9,G_FreeEdict@l(9)
	lis 11,0x4200
	lfs 0,level+4@l(8)
	lis 0,0xc1c0
	mr 3,29
	stw 9,436(29)
	stw 7,192(29)
	stw 0,196(29)
	stw 10,204(29)
	stw 11,208(29)
	fadd 0,0,13
	stw 27,376(29)
	stw 7,188(29)
	stw 10,200(29)
	frsp 0,0
	stw 27,384(29)
	stw 27,380(29)
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
.L122:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 SpawnWave,.Lfe7-SpawnWave
	.section	".rodata"
	.align 2
.LC51:
	.string	"%i"
	.align 3
.LC52:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC53:
	.long 0x0
	.align 2
.LC54:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl MatrixCheckSpeed
	.type	 MatrixCheckSpeed,@function
MatrixCheckSpeed:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	la 8,level@l(9)
	lis 10,0x4330
	lis 9,.LC52@ha
	xoris 0,0,0x8000
	la 9,.LC52@l(9)
	stw 0,44(1)
	stw 10,40(1)
	lfd 12,0(9)
	lfd 0,40(1)
	lwz 9,84(3)
	fsub 0,0,12
	lfs 13,3876(9)
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L126
	lis 9,.LC53@ha
	lfs 0,376(3)
	la 9,.LC53@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L128
	lfs 0,380(3)
	fcmpu 0,0,13
	bc 12,2,.L127
.L128:
	lis 9,.LC54@ha
	lfs 0,4(8)
	la 9,.LC54@l(9)
	lfs 12,0(9)
	fmuls 0,0,12
	fctiwz 13,0
	stfd 13,40(1)
	lwz 6,44(1)
.L127:
	andi. 0,6,1
	bc 12,2,.L125
	bl SpawnWave
	b .L125
.L126:
	lfs 0,1084(3)
	fcmpu 0,0,12
	bc 4,1,.L130
	lfs 12,1072(3)
	li 0,0
	li 6,0
	lfs 0,1076(3)
	lfs 13,1080(3)
	stfs 12,28(3)
	stfs 0,32(3)
	stfs 13,36(3)
	stw 0,376(3)
	stw 0,384(3)
	stw 0,380(3)
	b .L131
.L130:
	li 6,180
.L131:
	lha 0,936(3)
	cmpw 0,0,6
	bc 12,1,.L133
	lha 0,938(3)
	cmpw 0,0,6
	bc 4,1,.L125
.L133:
	lis 5,.LC51@ha
	addi 3,1,8
	la 5,.LC51@l(5)
	li 4,12
	crxor 6,6,6
	bl Com_sprintf
	lis 29,gi@ha
	lis 3,.LC26@ha
	la 29,gi@l(29)
	addi 4,1,8
	lwz 9,148(29)
	la 3,.LC26@l(3)
	mtlr 9
	blrl
	lwz 0,148(29)
	lis 3,.LC28@ha
	addi 4,1,8
	la 3,.LC28@l(3)
	mtlr 0
	blrl
.L125:
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 MatrixCheckSpeed,.Lfe8-MatrixCheckSpeed
	.section	".rodata"
	.align 2
.LC55:
	.long 0x42b40000
	.align 2
.LC56:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl MatrixScreenTilt
	.type	 MatrixScreenTilt,@function
MatrixScreenTilt:
	lwz 0,1088(3)
	cmpwi 0,0,0
	bclr 12,2
	lwz 0,492(3)
	cmpwi 0,0,0
	bclr 4,2
	lwz 0,1000(3)
	cmpwi 0,0,5
	bc 4,2,.L138
	lwz 0,1040(3)
	cmpwi 0,0,2
	bc 4,2,.L137
	lwz 9,84(3)
	lis 11,.LC55@ha
	la 11,.LC55@l(11)
.L143:
	lfs 0,3612(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,3612(9)
	blr
.L137:
	cmpwi 0,0,1
	bc 4,2,.L138
	lwz 9,84(3)
	lis 11,.LC55@ha
	la 11,.LC55@l(11)
.L144:
	lfs 0,3612(9)
	lfs 13,0(11)
	fsubs 0,0,13
	stfs 0,3612(9)
	blr
.L138:
	lhz 0,938(3)
	mr 9,0
	extsh 0,0
	cmpwi 0,0,0
	bc 4,1,.L139
	lwz 0,552(3)
	cmpwi 0,0,0
	bc 4,2,.L139
	lwz 9,84(3)
	lis 11,.LC56@ha
	la 11,.LC56@l(11)
	b .L143
.L139:
	andi. 0,9,32768
	bc 12,2,.L140
	lwz 0,552(3)
	cmpwi 0,0,0
	bc 4,2,.L140
	lwz 9,84(3)
	lis 11,.LC56@ha
	la 11,.LC56@l(11)
	b .L144
.L140:
	extsh. 0,9
	bc 4,1,.L141
	lwz 9,84(3)
	lis 11,.LC56@ha
	la 11,.LC56@l(11)
	b .L143
.L141:
	bclr 4,0
	lwz 9,84(3)
	lis 11,.LC56@ha
	la 11,.LC56@l(11)
	b .L144
.Lfe9:
	.size	 MatrixScreenTilt,.Lfe9-MatrixScreenTilt
	.align 2
	.globl MatrixFallingRoll
	.type	 MatrixFallingRoll,@function
MatrixFallingRoll:
	mr 9,3
	lha 0,940(9)
	mr 3,4
	cmpwi 0,0,0
	bclr 4,0
	li 0,6
	li 3,0
	stw 0,1000(9)
	blr
.Lfe10:
	.size	 MatrixFallingRoll,.Lfe10-MatrixFallingRoll
	.section	".rodata"
	.align 3
.LC57:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC58:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl MatrixSpeed
	.type	 MatrixSpeed,@function
MatrixSpeed:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	la 30,level@l(9)
	lis 10,0x4330
	lis 9,.LC57@ha
	mr 31,3
	xoris 0,0,0x8000
	la 9,.LC57@l(9)
	stw 0,12(1)
	stw 10,8(1)
	lfd 12,0(9)
	lfd 0,8(1)
	lwz 9,84(31)
	fsub 0,0,12
	lfs 13,3876(9)
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L101
	lis 29,gi@ha
	lis 28,.LC27@ha
	la 29,gi@l(29)
	lis 3,.LC26@ha
	lwz 9,148(29)
	la 4,.LC27@l(28)
	la 3,.LC26@l(3)
	mtlr 9
	blrl
	lwz 9,148(29)
	lis 3,.LC28@ha
	la 4,.LC27@l(28)
	la 3,.LC28@l(3)
	mtlr 9
	blrl
	lwz 0,148(29)
	lis 3,.LC29@ha
	lis 4,.LC30@ha
	la 3,.LC29@l(3)
	la 4,.LC30@l(4)
	mtlr 0
	blrl
	lis 9,.LC58@ha
	lfs 0,4(30)
	la 9,.LC58@l(9)
	lfs 12,0(9)
	fmuls 0,0,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	andi. 0,9,1
	bc 12,2,.L103
	mr 3,31
	bl SpawnShadow
	b .L103
.L101:
	lis 29,gi@ha
	lis 28,.LC31@ha
	la 29,gi@l(29)
	lis 3,.LC26@ha
	lwz 9,148(29)
	la 4,.LC31@l(28)
	la 3,.LC26@l(3)
	mtlr 9
	blrl
	lwz 0,148(29)
	lis 3,.LC28@ha
	la 4,.LC31@l(28)
	la 3,.LC28@l(3)
	mtlr 0
	blrl
.L103:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 MatrixSpeed,.Lfe11-MatrixSpeed
	.section	".rodata"
	.align 2
.LC59:
	.long 0x42b40000
	.align 2
.LC60:
	.long 0x41c00000
	.align 2
.LC61:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl MatrixRunRAlongWalls
	.type	 MatrixRunRAlongWalls,@function
MatrixRunRAlongWalls:
	stwu 1,-160(1)
	mflr 0
	stmw 28,144(1)
	stw 0,164(1)
	mr 31,3
	addic. 0,31,376
	bc 4,2,.L89
	stw 0,1000(31)
	b .L88
.L89:
	lwz 9,1000(31)
	addi 0,9,-7
	addic 10,9,-1
	subfe 11,10,9
	subfic 0,0,1
	subfe 0,0,0
	neg 0,0
	and. 30,0,11
	bc 4,2,.L88
	lwz 9,84(31)
	lis 11,.LC59@ha
	li 0,0
	la 11,.LC59@l(11)
	addi 28,1,24
	lfs 13,3668(9)
	addi 3,1,56
	addi 4,1,8
	lfs 12,0(11)
	li 6,0
	li 5,0
	addi 29,31,4
	stfs 13,56(1)
	lfs 0,3672(9)
	stfs 0,60(1)
	fadds 12,0,12
	lfs 13,3676(9)
	stw 0,56(1)
	stfs 12,60(1)
	stfs 13,64(1)
	bl AngleVectors
	lis 9,.LC60@ha
	addi 4,1,8
	la 9,.LC60@l(9)
	mr 5,28
	lfs 1,0(9)
	mr 3,29
	bl VectorMA
	lis 9,gi+48@ha
	lis 5,vec3_origin@ha
	lwz 0,gi+48@l(9)
	la 5,vec3_origin@l(5)
	mr 4,29
	li 9,3
	mr 7,28
	addi 3,1,72
	mr 6,5
	mtlr 0
	mr 8,31
	blrl
	lis 9,.LC61@ha
	lfs 13,80(1)
	la 9,.LC61@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L91
	li 0,7
	stw 0,1000(31)
	b .L88
.L91:
	stw 30,1000(31)
.L88:
	lwz 0,164(1)
	mtlr 0
	lmw 28,144(1)
	la 1,160(1)
	blr
.Lfe12:
	.size	 MatrixRunRAlongWalls,.Lfe12-MatrixRunRAlongWalls
	.align 2
	.globl SpeedWaveThink
	.type	 SpeedWaveThink,@function
SpeedWaveThink:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,56(3)
	cmpwi 0,9,3
	bc 4,2,.L120
	bl G_FreeEdict
	b .L121
.L120:
	addi 0,9,1
	stw 0,56(3)
.L121:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 SpeedWaveThink,.Lfe13-SpeedWaveThink
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
