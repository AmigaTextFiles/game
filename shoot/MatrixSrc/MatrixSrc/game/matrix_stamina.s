	.file	"matrix_stamina.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"breath3.wav"
	.align 2
.LC1:
	.string	"breath2.wav"
	.align 2
.LC2:
	.string	"breath1.wav"
	.section	".text"
	.align 2
	.globl heavybreathing
	.type	 heavybreathing,@function
heavybreathing:
	lwz 0,492(3)
	cmpwi 0,0,0
	bclr 4,2
	lwz 9,972(3)
	addi 9,9,1
	cmpwi 0,9,10
	stw 9,972(3)
	bclr 4,1
	stw 0,972(3)
	blr
.Lfe1:
	.size	 heavybreathing,.Lfe1-heavybreathing
	.section	".rodata"
	.align 3
.LC3:
	.long 0x3fefae14
	.long 0x7ae147ae
	.align 2
.LC4:
	.long 0x3f800000
	.align 2
.LC5:
	.long 0x437a0000
	.align 3
.LC6:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC7:
	.long 0x0
	.section	".text"
	.align 2
	.globl MatrixStamina
	.type	 MatrixStamina,@function
MatrixStamina:
	stwu 1,-16(1)
	lwz 9,84(3)
	lwz 0,3488(9)
	cmpwi 0,0,0
	bc 12,2,.L16
	lis 5,.LC4@ha
	lfs 0,924(3)
	lis 9,.LC5@ha
	la 5,.LC4@l(5)
	la 9,.LC5@l(9)
	lfs 13,0(5)
	lfs 12,0(9)
	fadds 0,0,13
	fcmpu 0,0,12
	stfs 0,924(3)
	bc 4,1,.L16
	stfs 12,924(3)
.L16:
	lwz 9,984(3)
	cmpwi 0,9,0
	bc 12,2,.L18
	mulli 9,9,50
	lwz 0,980(3)
	addi 9,9,200
	cmpw 0,0,9
	bc 12,2,.L18
	stw 9,980(3)
.L18:
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 4,2,.L15
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 12,0,.L15
	lwz 9,84(3)
	lwz 6,1812(9)
	cmpwi 0,6,0
	bc 4,2,.L15
	lwz 9,984(3)
	lis 7,0x4330
	lwz 11,980(3)
	lis 5,.LC6@ha
	mr 8,10
	srwi 0,9,31
	la 5,.LC6@l(5)
	lfs 11,924(3)
	add 9,9,0
	lfd 12,0(5)
	xoris 11,11,0x8000
	srawi 9,9,1
	stw 6,952(3)
	addi 9,9,1
	xoris 9,9,0x8000
	stw 9,12(1)
	stw 7,8(1)
	lfd 13,8(1)
	stw 11,12(1)
	stw 7,8(1)
	lfd 0,8(1)
	fsub 13,13,12
	fsub 0,0,12
	frsp 13,13
	frsp 0,0
	fadds 11,11,13
	fcmpu 0,11,0
	stfs 11,924(3)
	bc 4,1,.L22
	lis 9,.LC3@ha
	fmr 0,11
	lfd 13,.LC3@l(9)
	fsub 0,0,13
	frsp 0,0
	stfs 0,924(3)
.L22:
	lis 9,.LC7@ha
	lfs 0,924(3)
	la 9,.LC7@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L23
	stfs 13,924(3)
.L23:
	lwz 9,988(3)
	cmpwi 0,9,0
	bc 12,2,.L24
	mulli 9,9,50
	lwz 0,484(3)
	addi 11,9,100
	cmpw 0,0,11
	bc 12,2,.L24
	lwz 9,84(3)
	stw 11,484(3)
	stw 11,728(9)
.L24:
	lis 11,deathmatch@ha
	lis 5,.LC7@ha
	lwz 9,deathmatch@l(11)
	la 5,.LC7@l(5)
	lfs 13,0(5)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L25
	lis 11,level@ha
	lwz 10,84(3)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC6@ha
	lfs 12,3888(10)
	xoris 0,0,0x8000
	la 11,.LC6@l(11)
	stw 0,12(1)
	stw 8,8(1)
	lfd 13,0(11)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L25
	lwz 0,264(3)
	ori 0,0,32
	b .L27
.L25:
	lwz 0,264(3)
	rlwinm 0,0,0,27,25
.L27:
	stw 0,264(3)
.L15:
	la 1,16(1)
	blr
.Lfe2:
	.size	 MatrixStamina,.Lfe2-MatrixStamina
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
