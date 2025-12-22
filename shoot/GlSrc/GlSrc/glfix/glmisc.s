	.file	"glmisc.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"doomspawn"
	.align 2
.LC1:
	.string	"Too close to wall.\n"
	.align 2
.LC2:
	.string	"Cells"
	.align 2
.LC3:
	.string	"Too close to ceiling.\n"
	.align 2
.LC4:
	.string	"Too close to floor.\n"
	.align 3
.LC5:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC6:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC7:
	.long 0x41800000
	.section	".text"
	.align 2
	.globl CheckBounds
	.type	 CheckBounds,@function
CheckBounds:
	stwu 1,-160(1)
	mflr 0
	stfd 31,152(1)
	stmw 22,112(1)
	stw 0,164(1)
	mr 24,4
	mr 31,3
	lwz 3,280(31)
	lis 4,.LC0@ha
	mr 30,5
	mr 26,6
	la 4,.LC0@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L7
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L16
	lwz 0,576(31)
	cmpwi 0,0,0
	bc 4,1,.L16
.L7:
	lfs 13,4(31)
	addi 29,1,40
	addi 27,1,24
	lfs 12,8(31)
	addi 4,1,8
	li 5,0
	lfs 0,12(31)
	li 6,0
	addi 28,31,4
	lwz 3,84(31)
	mr 22,29
	mr 25,28
	stfs 13,24(1)
	mr 23,27
	stfs 12,28(1)
	addi 3,3,3636
	stfs 0,32(1)
	bl AngleVectors
	xoris 11,30,0x8000
	lfs 8,4(31)
	stw 11,108(1)
	lis 0,0x4330
	mr 3,29
	lis 11,.LC5@ha
	stw 0,104(1)
	mr 4,28
	la 11,.LC5@l(11)
	lfd 0,104(1)
	li 5,0
	lfd 13,0(11)
	li 9,3
	li 6,0
	lis 11,gi@ha
	lfs 9,8(31)
	mr 7,27
	lfs 12,12(31)
	la 30,gi@l(11)
	mr 8,31
	fsub 0,0,13
	lfs 10,8(1)
	lfs 11,12(1)
	lfs 13,16(1)
	frsp 0,0
	lwz 11,48(30)
	mtlr 11
	fmadds 13,13,0,12
	fmadds 10,10,0,8
	fmadds 11,11,0,9
	stfs 13,32(1)
	stfs 10,24(1)
	stfs 11,28(1)
	blrl
	lfs 0,48(1)
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L10
	lwz 0,8(30)
	lis 5,.LC1@ha
	mr 3,31
	la 5,.LC1@l(5)
	b .L17
.L10:
	lwz 9,84(1)
	cmpwi 0,9,0
	bc 12,2,.L11
	lwz 0,16(9)
	andi. 9,0,4
	bc 12,2,.L11
.L16:
	li 3,0
	b .L15
.L11:
	lfs 12,4(31)
	lis 11,.LC6@ha
	addi 4,1,8
	lfs 13,8(31)
	la 11,.LC6@l(11)
	li 5,0
	lfs 0,12(31)
	li 6,0
	lis 30,vec3_origin@ha
	lwz 3,84(31)
	lfd 31,0(11)
	stfs 12,24(1)
	addi 3,3,3636
	stfs 13,28(1)
	stfs 0,32(1)
	bl AngleVectors
	xoris 11,24,0x8000
	lfs 13,12(31)
	stw 11,108(1)
	lis 0,0x4330
	la 5,vec3_origin@l(30)
	lis 11,.LC5@ha
	stw 0,104(1)
	mr 3,22
	la 11,.LC5@l(11)
	lfd 0,104(1)
	mr 4,25
	lfd 12,0(11)
	mr 6,5
	mr 7,23
	lis 11,gi@ha
	mr 8,31
	la 29,gi@l(11)
	li 9,3
	fsub 0,0,12
	lwz 11,48(29)
	mtlr 11
	frsp 0,0
	fadds 13,13,0
	stfs 13,32(1)
	blrl
	lfs 0,48(1)
	fcmpu 0,0,31
	bc 12,2,.L13
	lwz 0,8(29)
	lis 5,.LC3@ha
	mr 3,31
	la 5,.LC3@l(5)
	b .L17
.L13:
	lfs 12,4(31)
	addi 4,1,8
	li 5,0
	lfs 13,8(31)
	li 6,0
	lfs 0,12(31)
	lwz 3,84(31)
	stfs 13,28(1)
	stfs 0,32(1)
	addi 3,3,3636
	stfs 12,24(1)
	bl AngleVectors
	lis 9,.LC7@ha
	lfs 0,12(31)
	la 5,vec3_origin@l(30)
	la 9,.LC7@l(9)
	lwz 11,48(29)
	mr 3,22
	lfs 13,0(9)
	mr 4,25
	mr 7,23
	mr 6,5
	mr 8,31
	mtlr 11
	li 9,3
	fsubs 0,0,13
	stfs 0,32(1)
	blrl
	lfs 0,48(1)
	fcmpu 0,0,31
	bc 4,2,.L14
	li 3,1
	b .L15
.L14:
	lwz 0,8(29)
	lis 5,.LC4@ha
	mr 3,31
	la 5,.LC4@l(5)
.L17:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	bl FindItem
	lis 11,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 9,11,3
	addi 10,10,740
	mullw 9,9,0
	li 3,0
	rlwinm 9,9,0,0,29
	lwzx 0,10,9
	add 0,0,26
	stwx 0,10,9
.L15:
	lwz 0,164(1)
	mtlr 0
	lmw 22,112(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe1:
	.size	 CheckBounds,.Lfe1-CheckBounds
	.comm	maplist,292,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
