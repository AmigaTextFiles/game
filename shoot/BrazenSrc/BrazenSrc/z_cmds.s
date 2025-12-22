	.file	"z_cmds.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC0:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC1:
	.long 0x41800000
	.align 2
.LC2:
	.long 0x41400000
	.align 2
.LC3:
	.long 0x41000000
	.align 2
.LC4:
	.long 0x40a00000
	.align 2
.LC5:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl ThrowRightHandItem
	.type	 ThrowRightHandItem,@function
ThrowRightHandItem:
	stwu 1,-176(1)
	mflr 0
	stfd 31,168(1)
	stmw 23,132(1)
	stw 0,180(1)
	mr 31,3
	mr 29,4
	lwz 9,84(31)
	li 24,0
	lwz 3,1816(9)
	cmpwi 0,3,1
	bc 4,1,.L6
	bl GetItemByTag
	mr. 30,3
	bc 12,2,.L6
	lwz 9,84(31)
	lwz 0,480(31)
	lfs 13,4732(9)
	cmpwi 0,0,0
	stfs 13,24(1)
	lfs 0,4736(9)
	stfs 0,28(1)
	lfs 13,4740(9)
	stfs 13,32(1)
	bc 12,1,.L9
	li 0,0
	stw 0,24(1)
.L9:
	addi 27,1,24
	addi 4,1,8
	li 5,0
	li 6,0
	mr 3,27
	lis 23,0x4330
	bl AngleVectors
	lis 9,.LC0@ha
	xoris 0,29,0x8000
	la 9,.LC0@l(9)
	addi 3,1,8
	lfd 31,0(9)
	addi 29,1,40
	addi 26,1,56
	addi 25,1,72
	stw 0,124(1)
	addi 28,1,88
	mr 4,3
	stw 23,120(1)
	lfd 1,120(1)
	fsub 1,1,31
	frsp 1,1
	bl VectorScale
	mr 6,28
	mr 3,27
	mr 4,26
	mr 5,25
	bl AngleVectors
	lis 9,.LC1@ha
	lfs 12,4(31)
	mr 3,29
	lfs 13,8(31)
	la 9,.LC1@l(9)
	mr 5,29
	lfs 0,12(31)
	mr 4,28
	lfs 1,0(9)
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
	bl VectorMA
	lis 9,.LC2@ha
	mr 3,29
	la 9,.LC2@l(9)
	mr 5,29
	lfs 1,0(9)
	mr 4,26
	bl VectorMA
	lis 9,.LC3@ha
	mr 3,29
	la 9,.LC3@l(9)
	mr 5,29
	lfs 1,0(9)
	mr 4,25
	bl VectorMA
	mr 5,29
	mr 3,31
	mr 4,30
	addi 6,1,8
	bl LaunchItem
	mr. 29,3
	bc 12,2,.L10
	lis 11,.LC4@ha
	lis 9,level+4@ha
	la 11,.LC4@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	stw 24,56(29)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 3,28(30)
	bl GetItemByTag
	mr. 24,3
	bc 12,2,.L11
	lwz 0,32(24)
	andi. 9,0,64
	bc 12,2,.L11
	lwz 9,84(31)
	lwz 0,1820(9)
	stw 0,532(29)
	lwz 9,24(30)
	cmpwi 0,9,0
	bc 4,1,.L13
	cmpwi 0,0,0
	bc 4,1,.L13
	divw 0,9,0
	lfs 13,428(29)
	mulli 0,0,28
	xoris 0,0,0x8000
	stw 0,124(1)
	stw 23,120(1)
	lfd 0,120(1)
	fsub 0,0,31
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(29)
	b .L13
.L11:
	lwz 0,32(30)
	andi. 11,0,5
	bc 12,2,.L14
	lwz 9,84(31)
	lwz 0,1820(9)
	stw 0,532(29)
	b .L13
.L14:
	lis 11,.LC5@ha
	lis 9,level+4@ha
	la 11,.LC5@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,428(29)
.L13:
	lwz 9,648(29)
	lwz 0,20(9)
	cmpwi 7,0,27
	xori 0,0,10
	subfic 9,0,0
	adde 0,9,0
	mfcr 9
	rlwinm 9,9,31,1
	or. 11,0,9
	bc 12,2,.L16
	bc 4,30,.L17
	lwz 9,84(31)
	lwz 0,1820(9)
	stw 0,532(29)
.L17:
	li 3,10
	li 27,0
	bl GetItemByTag
	li 26,0
	li 28,0
	stw 3,648(29)
.L21:
	lwz 11,84(31)
	addi 9,11,1848
	lwzx 0,9,28
	cmpwi 0,0,27
	bc 4,2,.L22
	addi 9,11,1976
	mr 3,31
	lwzx 0,9,28
	mr 4,27
	stw 0,532(29)
	lwz 9,84(31)
	addi 9,9,1976
	stwx 26,9,28
	bl RemoveItem
.L22:
	lwz 9,84(31)
	addi 9,9,1848
	lwzx 0,9,28
	cmpwi 0,0,10
	bc 4,2,.L20
	mr 3,31
	mr 4,27
	bl RemoveItem
.L20:
	addi 27,27,1
	addi 28,28,4
	cmpwi 0,27,31
	bc 4,1,.L21
.L16:
	lis 9,.LC0@ha
	lwz 10,84(31)
	la 9,.LC0@l(9)
	lwz 0,508(29)
	lis 8,0x4330
	lfd 13,0(9)
	lwz 9,1824(10)
	or 0,0,9
	stw 0,508(29)
	lwz 9,84(31)
	lwz 0,1828(9)
	xoris 0,0,0x8000
	stw 0,124(1)
	stw 8,120(1)
	lfd 0,120(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,992(29)
	lwz 9,20(30)
	addi 9,9,-8
	cmplwi 0,9,1
	bc 12,1,.L25
	lwz 0,532(29)
	cmpwi 0,0,1
	bc 4,1,.L25
	li 0,1
	lis 11,gi+72@ha
	stw 0,532(29)
	mr 3,29
	lwz 9,84(31)
	stw 0,1820(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	b .L6
.L25:
	lis 9,gi+72@ha
	mr 3,29
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L10:
	lwz 11,84(31)
	li 0,0
	li 10,1
	stw 0,4832(11)
	lwz 9,84(31)
	stw 10,1816(9)
	lwz 11,84(31)
	stw 0,1820(11)
	lwz 9,84(31)
	stw 0,1824(9)
.L6:
	lwz 0,180(1)
	mtlr 0
	lmw 23,132(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe1:
	.size	 ThrowRightHandItem,.Lfe1-ThrowRightHandItem
	.section	".rodata"
	.align 3
.LC6:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC7:
	.long 0x0
	.align 2
.LC8:
	.long 0xc0000000
	.align 2
.LC9:
	.long 0x41800000
	.align 2
.LC10:
	.long 0x41400000
	.align 2
.LC11:
	.long 0xc1000000
	.align 2
.LC12:
	.long 0x40a00000
	.align 2
.LC13:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl ThrowLeftHandItem
	.type	 ThrowLeftHandItem,@function
ThrowLeftHandItem:
	stwu 1,-160(1)
	mflr 0
	stmw 23,124(1)
	stw 0,164(1)
	mr 31,3
	mr 30,4
	lwz 9,84(31)
	lwz 3,1832(9)
	cmpwi 0,3,1
	bc 4,1,.L27
	bl GetItemByTag
	mr. 25,3
	bc 12,2,.L27
	lwz 9,84(31)
	lwz 0,480(31)
	lfs 13,4732(9)
	cmpwi 0,0,0
	stfs 13,24(1)
	lfs 0,4736(9)
	stfs 0,28(1)
	lfs 13,4740(9)
	stfs 13,32(1)
	bc 12,1,.L30
	li 0,0
	stw 0,24(1)
.L30:
	addi 26,1,24
	addi 27,1,56
	addi 4,1,8
	li 5,0
	li 6,0
	mr 3,26
	bl AngleVectors
	mr 23,27
	xoris 0,30,0x8000
	stw 0,116(1)
	lis 11,0x4330
	lis 10,.LC6@ha
	stw 11,112(1)
	la 10,.LC6@l(10)
	addi 3,1,8
	lfd 0,0(10)
	addi 28,1,72
	addi 29,1,88
	lfd 1,112(1)
	mr 4,3
	mr 24,28
	mr 30,29
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	mr 3,26
	mr 4,27
	mr 5,28
	mr 6,29
	bl AngleVectors
	lis 9,.LC7@ha
	lfs 11,64(1)
	la 9,.LC7@l(9)
	lfs 12,4(31)
	lfs 0,0(9)
	lfs 13,8(31)
	fcmpu 0,11,0
	lfs 0,12(31)
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
	bc 4,0,.L31
	fadds 1,11,11
	addi 0,1,40
	mr 4,30
	mr 3,0
	mr 5,0
	mr 29,0
	bl VectorMA
	b .L32
.L31:
	addi 29,1,40
	bc 4,1,.L32
	lis 9,.LC8@ha
	mr 3,29
	la 9,.LC8@l(9)
	mr 5,29
	lfs 1,0(9)
	mr 4,30
	fmuls 1,11,1
	bl VectorMA
.L32:
	lis 9,.LC9@ha
	mr 4,30
	la 9,.LC9@l(9)
	mr 3,29
	lfs 1,0(9)
	mr 5,29
	bl VectorMA
	lis 9,.LC10@ha
	mr 4,23
	la 9,.LC10@l(9)
	mr 3,29
	lfs 1,0(9)
	mr 5,29
	bl VectorMA
	lis 9,.LC11@ha
	mr 4,24
	la 9,.LC11@l(9)
	mr 3,29
	lfs 1,0(9)
	mr 5,29
	bl VectorMA
	mr 5,29
	mr 3,31
	mr 4,25
	addi 6,1,8
	bl LaunchItem
	mr. 28,3
	bc 12,2,.L34
	lis 10,.LC12@ha
	lis 9,level+4@ha
	la 10,.LC12@l(10)
	lfs 0,level+4@l(9)
	li 0,0
	lfs 13,0(10)
	stw 0,56(28)
	fadds 0,0,13
	stfs 0,428(28)
	lwz 3,28(25)
	bl GetItemByTag
	mr. 3,3
	bc 12,2,.L35
	lwz 0,32(3)
	andi. 9,0,64
	bc 12,2,.L35
	lwz 9,84(31)
	lwz 0,1836(9)
	stw 0,532(28)
	lwz 3,24(25)
	cmpwi 0,3,0
	bc 4,1,.L37
	cmpwi 0,0,0
	bc 4,1,.L37
	divw 0,3,0
	lis 11,0x4330
	lfs 13,428(28)
	lis 10,.LC6@ha
	la 10,.LC6@l(10)
	lfd 12,0(10)
	mulli 0,0,28
	xoris 0,0,0x8000
	stw 0,116(1)
	stw 11,112(1)
	lfd 0,112(1)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(28)
	b .L37
.L35:
	lwz 0,32(25)
	andi. 11,0,5
	bc 12,2,.L38
	lwz 9,84(31)
	lwz 0,1836(9)
	stw 0,532(28)
	b .L37
.L38:
	lis 10,.LC13@ha
	lis 9,level+4@ha
	la 10,.LC13@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(28)
.L37:
	lwz 9,648(28)
	lwz 0,20(9)
	cmpwi 7,0,27
	xori 0,0,10
	subfic 11,0,0
	adde 0,11,0
	mfcr 9
	rlwinm 9,9,31,1
	or. 10,0,9
	bc 12,2,.L40
	bc 4,30,.L41
	lwz 9,84(31)
	lwz 0,1836(9)
	stw 0,532(28)
.L41:
	li 3,10
	li 27,0
	bl GetItemByTag
	li 30,0
	li 29,0
	stw 3,648(28)
.L45:
	lwz 11,84(31)
	addi 9,11,1848
	lwzx 0,9,29
	cmpwi 0,0,27
	bc 4,2,.L46
	addi 9,11,1976
	mr 3,31
	lwzx 0,9,29
	mr 4,27
	stw 0,532(28)
	lwz 9,84(31)
	addi 9,9,1976
	stwx 30,9,29
	bl RemoveItem
.L46:
	lwz 9,84(31)
	addi 9,9,1848
	lwzx 0,9,29
	cmpwi 0,0,10
	bc 4,2,.L44
	mr 3,31
	mr 4,27
	bl RemoveItem
.L44:
	addi 27,27,1
	addi 29,29,4
	cmpwi 0,27,31
	bc 4,1,.L45
.L40:
	lis 9,.LC6@ha
	lwz 10,84(31)
	la 9,.LC6@l(9)
	lwz 0,508(28)
	lis 8,0x4330
	lfd 13,0(9)
	lwz 9,1840(10)
	or 0,0,9
	stw 0,508(28)
	lwz 9,84(31)
	lwz 0,1844(9)
	xoris 0,0,0x8000
	stw 0,116(1)
	stw 8,112(1)
	lfd 0,112(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,992(28)
.L34:
	lwz 11,84(31)
	li 0,0
	li 10,1
	stw 0,4832(11)
	lwz 9,84(31)
	stw 10,1832(9)
	lwz 11,84(31)
	stw 0,1836(11)
	lwz 9,84(31)
	stw 0,1840(9)
.L27:
	lwz 0,164(1)
	mtlr 0
	lmw 23,124(1)
	la 1,160(1)
	blr
.Lfe2:
	.size	 ThrowLeftHandItem,.Lfe2-ThrowLeftHandItem
	.section	".rodata"
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC15:
	.long 0x0
	.align 2
.LC16:
	.long 0xc0000000
	.align 2
.LC17:
	.long 0x41800000
	.align 2
.LC18:
	.long 0x41400000
	.align 2
.LC19:
	.long 0x41000000
	.align 2
.LC20:
	.long 0x40a00000
	.align 2
.LC21:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl ThrowBodyAreaItem
	.type	 ThrowBodyAreaItem,@function
ThrowBodyAreaItem:
	stwu 1,-176(1)
	mflr 0
	stmw 21,132(1)
	stw 0,180(1)
	mr 31,3
	mr 23,5
	lwz 11,84(31)
	slwi 0,23,2
	mr 30,4
	addi 9,11,1848
	lwzx 0,9,0
	cmpwi 0,0,1
	bc 4,1,.L79
	cmpwi 0,0,27
	bc 4,2,.L51
	lwz 0,1832(11)
	cmpwi 0,0,10
	bc 4,2,.L53
	b .L78
.L51:
	cmpwi 0,0,10
	bc 4,2,.L53
	lwz 0,1832(11)
	cmpwi 0,0,27
	bc 4,2,.L79
.L78:
	mr 3,31
	li 4,150
	bl ThrowRightHandItem
.L79:
	li 3,0
	b .L76
.L53:
	lwz 9,84(31)
	slwi 0,23,2
	mr 25,0
	addi 9,9,1848
	lwzx 3,9,0
	bl GetItemByTag
	mr. 24,3
	bc 12,2,.L79
	lwz 9,84(31)
	lwz 0,480(31)
	lfs 13,4732(9)
	cmpwi 0,0,0
	stfs 13,24(1)
	lfs 0,4736(9)
	stfs 0,28(1)
	lfs 13,4740(9)
	stfs 13,32(1)
	bc 12,1,.L57
	li 0,0
	stw 0,24(1)
.L57:
	addi 26,1,24
	addi 27,1,56
	addi 4,1,8
	li 5,0
	li 6,0
	mr 3,26
	bl AngleVectors
	mr 21,27
	xoris 0,30,0x8000
	stw 0,124(1)
	lis 11,0x4330
	lis 7,.LC14@ha
	la 7,.LC14@l(7)
	stw 11,120(1)
	addi 3,1,8
	lfd 0,0(7)
	addi 28,1,72
	addi 29,1,88
	lfd 1,120(1)
	mr 4,3
	mr 22,28
	mr 30,29
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	mr 3,26
	mr 4,27
	mr 5,28
	mr 6,29
	bl AngleVectors
	lis 7,.LC15@ha
	lfs 11,64(1)
	la 7,.LC15@l(7)
	lfs 12,4(31)
	lfs 0,0(7)
	lfs 13,8(31)
	fcmpu 0,11,0
	lfs 0,12(31)
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
	bc 4,0,.L58
	fadds 1,11,11
	addi 0,1,40
	mr 4,30
	mr 3,0
	mr 5,0
	mr 29,0
	bl VectorMA
	b .L59
.L58:
	addi 29,1,40
	bc 4,1,.L59
	lis 7,.LC16@ha
	mr 3,29
	la 7,.LC16@l(7)
	mr 5,29
	lfs 1,0(7)
	mr 4,30
	fmuls 1,11,1
	bl VectorMA
.L59:
	lis 7,.LC17@ha
	mr 4,30
	la 7,.LC17@l(7)
	mr 3,29
	lfs 1,0(7)
	mr 5,29
	bl VectorMA
	lis 7,.LC18@ha
	mr 4,21
	la 7,.LC18@l(7)
	mr 3,29
	lfs 1,0(7)
	mr 5,29
	bl VectorMA
	lis 7,.LC19@ha
	mr 4,22
	la 7,.LC19@l(7)
	mr 3,29
	lfs 1,0(7)
	mr 5,29
	bl VectorMA
	mr 5,29
	mr 3,31
	mr 4,24
	addi 6,1,8
	bl LaunchItem
	mr. 28,3
	bc 12,2,.L61
	lwz 9,84(31)
	lis 7,.LC20@ha
	lis 10,level+4@ha
	la 7,.LC20@l(7)
	li 11,0
	addi 9,9,1976
	lfs 13,0(7)
	lwzx 0,9,25
	stw 0,532(28)
	lfs 0,level+4@l(10)
	stw 11,56(28)
	fadds 0,0,13
	stfs 0,428(28)
	lwz 3,28(24)
	bl GetItemByTag
	mr. 3,3
	bc 12,2,.L62
	lwz 0,32(3)
	andi. 7,0,64
	bc 12,2,.L62
	lwz 9,24(24)
	cmpwi 0,9,0
	bc 4,1,.L64
	lwz 0,532(28)
	cmpwi 0,0,0
	bc 4,1,.L64
	divw 0,9,0
	lis 11,0x4330
	lis 10,.LC14@ha
	lfs 13,428(28)
	la 10,.LC14@l(10)
	lfd 12,0(10)
	mulli 0,0,28
	xoris 0,0,0x8000
	stw 0,124(1)
	stw 11,120(1)
	lfd 0,120(1)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(28)
	b .L64
.L62:
	lis 11,.LC21@ha
	lis 9,level+4@ha
	la 11,.LC21@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,428(28)
.L64:
	lwz 9,648(28)
	lwz 0,20(9)
	cmpwi 7,0,27
	xori 0,0,10
	subfic 7,0,0
	adde 0,7,0
	mfcr 9
	rlwinm 9,9,31,1
	or. 10,0,9
	bc 12,2,.L65
	bc 4,30,.L66
	lwz 9,84(31)
	addi 9,9,1976
	lwzx 0,9,25
	stw 0,532(28)
.L66:
	li 3,10
	li 27,0
	bl GetItemByTag
	li 30,0
	li 29,0
	stw 3,648(28)
.L70:
	lwz 11,84(31)
	addi 9,11,1848
	lwzx 0,9,29
	cmpwi 0,0,27
	bc 4,2,.L71
	addi 9,11,1976
	mr 3,31
	lwzx 0,9,29
	mr 4,27
	stw 0,532(28)
	lwz 9,84(31)
	addi 9,9,1976
	stwx 30,9,29
	bl RemoveItem
.L71:
	lwz 9,84(31)
	addi 9,9,1848
	lwzx 0,9,29
	cmpwi 0,0,10
	bc 4,2,.L69
	mr 3,31
	mr 4,27
	bl RemoveItem
.L69:
	addi 27,27,1
	addi 29,29,4
	cmpwi 0,27,31
	bc 4,1,.L70
.L65:
	lwz 9,84(31)
	lis 8,0x4330
	lwz 11,508(28)
	lis 7,.LC14@ha
	addi 9,9,2104
	la 7,.LC14@l(7)
	lwzx 0,9,25
	lfd 13,0(7)
	or 11,11,0
	stw 11,508(28)
	lwz 9,84(31)
	addi 9,9,2232
	lwzx 0,9,25
	xoris 0,0,0x8000
	stw 0,124(1)
	stw 8,120(1)
	lfd 0,120(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,992(28)
	lwz 9,20(24)
	addi 9,9,-8
	cmplwi 0,9,1
	bc 12,1,.L61
	lwz 0,532(28)
	cmpwi 0,0,1
	bc 4,1,.L61
	li 0,1
	lis 11,gi+72@ha
	stw 0,532(28)
	mr 3,28
	lwz 9,84(31)
	addi 9,9,1976
	stwx 0,9,25
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	b .L80
.L61:
	mr 3,31
	mr 4,23
	bl RemoveItem
.L80:
	mr 3,28
.L76:
	lwz 0,180(1)
	mtlr 0
	lmw 21,132(1)
	la 1,176(1)
	blr
.Lfe3:
	.size	 ThrowBodyAreaItem,.Lfe3-ThrowBodyAreaItem
	.align 2
	.globl CmdDropWeapon
	.type	 CmdDropWeapon,@function
CmdDropWeapon:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L81
	lwz 9,84(31)
	lwz 29,1816(9)
	lwz 30,1832(9)
	cmpwi 0,29,1
	bc 4,1,.L83
	cmpwi 0,30,1
	bc 4,1,.L94
	lwz 0,1820(9)
	li 8,0
	li 10,0
	lwz 9,1836(9)
	cmpw 0,9,0
	bc 4,1,.L85
	cmpwi 0,9,0
	bc 4,2,.L84
.L85:
	li 10,1
.L84:
	lwz 9,84(31)
	lwz 11,1820(9)
	lwz 0,1836(9)
	cmpw 0,11,0
	bc 4,1,.L87
	cmpwi 0,11,0
	bc 4,2,.L86
.L87:
	li 8,1
.L86:
	and. 0,8,10
	bc 12,2,.L88
	mr 3,31
	li 4,50
	bl ThrowRightHandItem
	b .L99
.L88:
	cmpwi 0,10,0
	bc 4,2,.L99
	cmpwi 0,8,0
	bc 12,2,.L93
	mr 3,31
	li 4,50
	bl ThrowRightHandItem
	b .L93
.L83:
	cmpwi 0,30,1
	bc 4,1,.L94
.L99:
	mr 3,31
	li 4,50
	bl ThrowLeftHandItem
	b .L93
.L94:
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,1
	bc 4,1,.L93
	mr 3,31
	li 4,50
	bl ThrowRightHandItem
.L93:
	lwz 9,84(31)
	lwz 0,1832(9)
	cmpwi 0,0,1
	bc 4,1,.L97
	stw 0,1816(9)
	li 8,0
	lwz 9,84(31)
	lwz 0,1836(9)
	stw 0,1820(9)
	lwz 11,84(31)
	lwz 0,1840(11)
	stw 0,1824(11)
	lwz 10,84(31)
	lwz 0,1844(10)
	stw 0,1828(10)
	lwz 9,84(31)
	stw 8,1832(9)
	lwz 11,84(31)
	stw 8,1836(11)
	lwz 9,84(31)
	stw 8,1840(9)
	lwz 11,84(31)
	stw 8,1844(11)
.L97:
	mr 3,31
	bl SetupItemModels
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,1
	bc 12,1,.L81
	lwz 0,1832(9)
	cmpwi 0,0,1
	bc 12,1,.L81
	mr 3,31
	mr 4,29
	mr 5,30
	bl AutoSwitchWeapon
.L81:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 CmdDropWeapon,.Lfe4-CmdDropWeapon
	.section	".rodata"
	.align 2
.LC22:
	.string	"i_null"
	.align 2
.LC23:
	.string	"i_highlight"
	.align 2
.LC24:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl DrawItemSelect
	.type	 DrawItemSelect,@function
DrawItemSelect:
	stwu 1,-32(1)
	mflr 0
	mfcr 12
	stmw 27,12(1)
	stw 0,36(1)
	stw 12,8(1)
	mr 30,3
	lwz 11,84(30)
	lwz 0,4924(11)
	cmpwi 0,0,0
	bc 12,0,.L100
	lis 9,level+4@ha
	lfs 13,4920(11)
	lis 10,.LC24@ha
	lfs 0,level+4@l(9)
	la 10,.LC24@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,1,.L103
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 12,1,.L102
.L103:
	lis 9,gi@ha
	lis 3,.LC22@ha
	lha 29,166(11)
	la 31,gi@l(9)
	la 3,.LC22@l(3)
	lwz 9,40(31)
	lis 28,.LC22@ha
	mtlr 9
	blrl
	cmpw 0,29,3
	bc 12,2,.L104
	li 29,16
.L108:
	lwz 9,40(31)
	la 3,.LC22@l(28)
	mtlr 9
	blrl
	add 0,29,29
	lwz 9,84(30)
	addi 29,29,1
	cmpwi 0,29,22
	addi 9,9,120
	sthx 3,9,0
	bc 4,1,.L108
	lis 9,gi+40@ha
	lis 3,.LC22@ha
	lwz 0,gi+40@l(9)
	la 3,.LC22@l(3)
	mtlr 0
	blrl
	lwz 9,84(30)
	sth 3,166(9)
.L104:
	lwz 9,84(30)
	lis 0,0xc120
	stw 0,4920(9)
	b .L100
.L102:
	li 0,0
	li 31,0
	stw 0,4836(11)
	li 0,32
	lwz 9,84(30)
	mtctr 0
	lwz 29,4924(9)
	addi 10,9,4928
.L168:
	slwi 0,29,2
	addi 11,31,1
	lwzx 9,10,0
	addi 29,29,1
	cmpwi 7,29,32
	addi 0,9,-1
	or 9,9,0
	srawi 9,9,31
	mfcr 0
	rlwinm 0,0,29,1
	andc 11,11,9
	neg 0,0
	and 9,31,9
	and 29,29,0
	or 31,9,11
	bdnz .L168
	cmpwi 0,31,0
	bc 4,1,.L100
	cmpwi 7,31,8
	lis 9,gi@ha
	la 29,gi@l(9)
	lis 3,.LC23@ha
	lwz 11,40(29)
	la 3,.LC23@l(3)
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	mtlr 11
	nor 9,0,0
	and 0,31,0
	rlwinm 9,9,0,29,31
	or 31,0,9
	blrl
	lwz 11,84(30)
	sth 3,166(11)
	lwz 9,84(30)
	lwz 0,4924(9)
	addi 9,9,4928
	slwi 0,0,2
	lwzx 3,9,0
	bl GetItemByTag
	mr. 3,3
	bc 12,2,.L119
	lwz 0,40(29)
	lwz 3,12(3)
	mtlr 0
	blrl
	lwz 9,84(30)
	sth 3,158(9)
.L119:
	cmpwi 7,31,6
	lwz 9,84(30)
	cmpwi 0,31,1
	lwz 29,4924(9)
	cmpwi 4,31,5
	mfcr 27
	rlwinm 27,27,28,0xf0000000
	cmpwi 3,31,2
	cmpwi 7,31,3
	cmpwi 2,31,4
	mfcr 28
	rlwinm 28,28,28,0xf0000000
	bc 4,1,.L120
	li 31,0
	b .L121
.L123:
	addi 31,31,1
.L121:
	cmpwi 0,31,31
	bc 12,1,.L120
	addi 29,29,1
	lwz 11,84(30)
	cmpwi 7,29,32
	addi 11,11,4928
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	and 29,29,0
	slwi 9,29,2
	lwzx 3,11,9
	bl GetItemByTag
	mr. 3,3
	bc 12,2,.L123
	lis 9,gi+40@ha
	lwz 3,12(3)
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	lwz 9,84(30)
	sth 3,160(9)
.L120:
	mtcrf 128,28
	bc 4,1,.L128
	lis 9,gi@ha
	li 31,0
	la 28,gi@l(9)
	b .L129
.L131:
	addi 31,31,1
.L129:
	cmpwi 0,31,31
	bc 12,1,.L128
	addi 29,29,1
	lwz 11,84(30)
	cmpwi 7,29,32
	addi 11,11,4928
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	and 29,29,0
	slwi 9,29,2
	lwzx 3,11,9
	bl GetItemByTag
	mr. 3,3
	bc 12,2,.L131
	lwz 0,40(28)
	lwz 3,12(3)
	mtlr 0
	blrl
	lwz 9,84(30)
	sth 3,162(9)
.L128:
	bc 4,17,.L136
	lis 9,gi@ha
	li 31,0
	la 28,gi@l(9)
	b .L137
.L139:
	addi 31,31,1
.L137:
	cmpwi 0,31,31
	bc 12,1,.L136
	addi 29,29,1
	lwz 11,84(30)
	cmpwi 7,29,32
	addi 11,11,4928
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	and 29,29,0
	slwi 9,29,2
	lwzx 3,11,9
	bl GetItemByTag
	mr. 3,3
	bc 12,2,.L139
	lwz 0,40(28)
	lwz 3,12(3)
	mtlr 0
	blrl
	lwz 9,84(30)
	sth 3,164(9)
.L136:
	lwz 9,84(30)
	lwz 29,4924(9)
	bc 4,13,.L144
	lis 9,gi@ha
	li 31,0
	la 28,gi@l(9)
	b .L145
.L147:
	addi 31,31,1
.L145:
	cmpwi 0,31,31
	bc 12,1,.L144
	addi 29,29,-1
	lwz 10,84(30)
	nor 11,29,29
	srawi 11,11,31
	addi 10,10,4928
	nor 0,11,11
	and 11,29,11
	rlwinm 0,0,0,27,31
	or 29,11,0
	slwi 9,29,2
	lwzx 3,10,9
	bl GetItemByTag
	mr. 3,3
	bc 12,2,.L147
	lwz 0,40(28)
	lwz 3,12(3)
	mtlr 0
	blrl
	lwz 9,84(30)
	sth 3,156(9)
.L144:
	bc 4,9,.L152
	lis 9,gi@ha
	li 31,0
	la 28,gi@l(9)
	b .L153
.L155:
	addi 31,31,1
.L153:
	cmpwi 0,31,31
	bc 12,1,.L152
	addi 29,29,-1
	lwz 10,84(30)
	nor 11,29,29
	srawi 11,11,31
	addi 10,10,4928
	nor 0,11,11
	and 11,29,11
	rlwinm 0,0,0,27,31
	or 29,11,0
	slwi 9,29,2
	lwzx 3,10,9
	bl GetItemByTag
	mr. 3,3
	bc 12,2,.L155
	lwz 0,40(28)
	lwz 3,12(3)
	mtlr 0
	blrl
	lwz 9,84(30)
	sth 3,154(9)
.L152:
	mtcrf 128,27
	bc 4,1,.L100
	lis 9,gi@ha
	li 31,0
	la 28,gi@l(9)
	b .L161
.L163:
	addi 31,31,1
.L161:
	cmpwi 0,31,31
	bc 12,1,.L100
	addi 29,29,-1
	lwz 10,84(30)
	nor 11,29,29
	srawi 11,11,31
	addi 10,10,4928
	nor 0,11,11
	and 11,29,11
	rlwinm 0,0,0,27,31
	or 29,11,0
	slwi 9,29,2
	lwzx 3,10,9
	bl GetItemByTag
	mr. 3,3
	bc 12,2,.L163
	lwz 0,40(28)
	lwz 3,12(3)
	mtlr 0
	blrl
	lwz 9,84(30)
	sth 3,152(9)
.L100:
	lwz 0,36(1)
	lwz 12,8(1)
	mtlr 0
	lmw 27,12(1)
	mtcrf 56,12
	la 1,32(1)
	blr
.Lfe5:
	.size	 DrawItemSelect,.Lfe5-DrawItemSelect
	.section	".rodata"
	.align 2
.LC25:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl CmdNext
	.type	 CmdNext,@function
CmdNext:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L172
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 12,2,.L172
	lis 9,gi@ha
	li 31,16
	la 28,gi@l(9)
	lis 29,.LC22@ha
.L178:
	lwz 9,40(28)
	la 3,.LC22@l(29)
	mtlr 9
	blrl
	add 0,31,31
	lwz 9,84(30)
	addi 31,31,1
	cmpwi 0,31,22
	addi 9,9,120
	sthx 3,9,0
	bc 4,1,.L178
	lis 9,gi+40@ha
	lis 3,.LC22@ha
	lwz 0,gi+40@l(9)
	la 3,.LC22@l(3)
	mtlr 0
	blrl
	lwz 9,84(30)
	li 4,0
	li 5,128
	sth 3,166(9)
	lwz 3,84(30)
	addi 3,3,4928
	crxor 6,6,6
	bl memset
	lwz 3,84(30)
	li 5,128
	li 4,0
	addi 3,3,5056
	crxor 6,6,6
	bl memset
	lwz 9,84(30)
	li 0,1
	li 10,32
	li 5,0
	li 3,2
	stw 0,4928(9)
	li 6,0
	lwz 9,84(30)
	stw 10,5056(9)
	lwz 11,84(30)
	lwz 10,1832(11)
	lwz 8,1816(11)
	addi 0,10,-2
	subfic 0,0,20
	subfe 0,0,0
	addi 9,8,-2
	andc 10,10,0
	subfic 9,9,20
	subfe 9,9,9
	rlwinm 0,0,0,30,30
	andc 8,8,9
	or 10,0,10
	and 9,10,9
	or 10,9,8
.L185:
	li 0,32
	li 31,0
	mtctr 0
	li 7,0
	mr 8,6
.L233:
	lwz 11,84(30)
	addi 9,11,1848
	lwzx 0,9,7
	cmpw 0,0,10
	bc 4,2,.L188
	addi 9,11,4928
	addi 8,8,4
	stwx 10,9,8
	addi 6,6,4
	addi 5,5,1
	lwz 9,84(30)
	addi 9,9,5056
	stwx 31,9,8
.L188:
	addi 7,7,4
	addi 31,31,1
	bdnz .L233
	cmpwi 6,5,31
	bc 12,25,.L183
	addi 10,10,1
	addi 3,3,1
	cmpwi 7,10,23
	cmpwi 0,3,22
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,10,0
	rlwinm 9,9,0,30,30
	or 10,0,9
	bc 4,1,.L185
.L183:
	lwz 10,84(30)
	slwi 8,5,2
	li 3,24
	addi 11,10,4928
	mr 4,10
	lwzx 9,11,8
	addi 10,9,1
	cmpwi 7,10,23
	mfcr 0
	rlwinm 0,0,30,1
	neg 0,0
	nor 9,0,0
	and 0,10,0
	rlwinm 9,9,0,27,28
	or 10,0,9
	bc 12,25,.L197
	mr 6,8
.L200:
	li 0,32
	li 31,0
	mtctr 0
	li 7,0
	mr 8,6
.L232:
	lwz 11,84(30)
	addi 9,11,1848
	lwzx 0,9,7
	cmpw 0,0,10
	bc 4,2,.L203
	addi 5,5,1
	addi 8,8,4
	cmpwi 0,5,31
	addi 6,6,4
	bc 12,1,.L203
	addi 11,11,4928
	stwx 10,11,8
	lwz 9,84(30)
	addi 9,9,5056
	stwx 31,9,8
.L203:
	addi 7,7,4
	addi 31,31,1
	lwz 4,84(30)
	bdnz .L232
	cmpwi 0,5,31
	bc 12,1,.L197
	addi 10,10,1
	addi 3,3,1
	cmpwi 7,10,52
	cmpwi 0,3,51
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,10,0
	rlwinm 9,9,0,27,28
	or 10,0,9
	bc 4,1,.L200
.L197:
	lwz 10,4924(4)
	cmpwi 0,10,31
	bc 4,1,.L212
	li 0,0
	b .L213
.L212:
	slwi 10,10,2
	addi 9,4,4928
	lwzx 11,9,10
	srawi 0,11,31
	subf 0,11,0
	srwi 0,0,31
.L213:
	cmpwi 0,0,0
	bc 4,2,.L211
	lwz 9,84(30)
	stw 0,4924(9)
.L211:
	lwz 11,84(30)
	lis 9,level+4@ha
	lis 10,.LC25@ha
	lfs 12,level+4@l(9)
	la 10,.LC25@l(10)
	lfs 0,4920(11)
	lfs 13,0(10)
	fsubs 0,12,0
	fcmpu 0,0,13
	bc 4,1,.L215
	stfs 12,4920(11)
	b .L172
.L215:
	li 0,33
	lwz 8,4924(11)
	li 31,0
	mtctr 0
	li 7,0
.L231:
	lwz 9,84(30)
	lwz 11,4924(9)
	addi 11,11,1
	stw 11,4924(9)
	lwz 9,84(30)
	lwz 0,4924(9)
	cmpwi 0,0,31
	bc 4,1,.L222
	stw 7,4924(9)
	lwz 9,84(30)
	lwz 0,4924(9)
	cmpwi 0,0,31
	bc 4,1,.L222
	li 0,0
	b .L223
.L222:
	lwz 11,84(30)
	lwz 9,4924(11)
	addi 11,11,4928
	slwi 9,9,2
	lwzx 10,11,9
	srawi 0,10,31
	subf 0,10,0
	srwi 0,0,31
.L223:
	cmpwi 0,0,0
	bc 4,2,.L217
	addi 31,31,1
	bdnz .L231
.L217:
	cmpwi 0,31,33
	bc 4,2,.L226
	lwz 9,84(30)
	stw 8,4924(9)
.L226:
	lwz 9,84(30)
	lwz 10,4924(9)
	cmpwi 0,10,31
	bc 4,1,.L228
	li 0,0
	b .L229
.L228:
	slwi 10,10,2
	addi 9,9,4928
	lwzx 11,9,10
	srawi 0,11,31
	subf 0,11,0
	srwi 0,0,31
.L229:
	cmpwi 0,0,0
	bc 4,2,.L227
	lwz 9,84(30)
	stw 0,4924(9)
.L227:
	lis 9,level+4@ha
	lwz 11,84(30)
	lfs 0,level+4@l(9)
	stfs 0,4920(11)
.L172:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 CmdNext,.Lfe6-CmdNext
	.section	".rodata"
	.align 2
.LC26:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl CmdPrev
	.type	 CmdPrev,@function
CmdPrev:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 4,0
	lwz 3,84(31)
	li 5,128
	addi 3,3,4928
	crxor 6,6,6
	bl memset
	lwz 3,84(31)
	li 4,0
	li 5,128
	addi 3,3,5056
	crxor 6,6,6
	bl memset
	lwz 9,84(31)
	li 0,1
	li 10,32
	li 4,0
	li 12,2
	stw 0,4928(9)
	li 5,0
	lwz 9,84(31)
	stw 10,5056(9)
	lwz 11,84(31)
	lwz 10,1832(11)
	lwz 8,1816(11)
	addi 0,10,-2
	subfic 0,0,20
	subfe 0,0,0
	addi 9,8,-2
	andc 10,10,0
	subfic 9,9,20
	subfe 9,9,9
	rlwinm 0,0,0,30,30
	andc 8,8,9
	or 10,0,10
	and 9,10,9
	or 10,9,8
.L240:
	li 0,32
	li 6,0
	mtctr 0
	li 7,0
	mr 8,5
.L288:
	lwz 11,84(31)
	addi 9,11,1848
	lwzx 0,9,7
	cmpw 0,0,10
	bc 4,2,.L243
	addi 9,11,4928
	addi 8,8,4
	stwx 10,9,8
	addi 5,5,4
	addi 4,4,1
	lwz 9,84(31)
	addi 9,9,5056
	stwx 6,9,8
.L243:
	addi 7,7,4
	addi 6,6,1
	bdnz .L288
	cmpwi 6,4,31
	bc 12,25,.L238
	addi 10,10,1
	addi 12,12,1
	cmpwi 7,10,23
	cmpwi 0,12,22
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,10,0
	rlwinm 9,9,0,30,30
	or 10,0,9
	bc 4,1,.L240
.L238:
	lwz 10,84(31)
	slwi 8,4,2
	li 12,24
	addi 11,10,4928
	mr 3,10
	lwzx 9,11,8
	addi 10,9,1
	cmpwi 7,10,23
	mfcr 0
	rlwinm 0,0,30,1
	neg 0,0
	nor 9,0,0
	and 0,10,0
	rlwinm 9,9,0,27,28
	or 10,0,9
	bc 12,25,.L252
	mr 5,8
.L255:
	li 0,32
	li 6,0
	mtctr 0
	li 7,0
	mr 8,5
.L287:
	lwz 11,84(31)
	addi 9,11,1848
	lwzx 0,9,7
	cmpw 0,0,10
	bc 4,2,.L258
	addi 4,4,1
	addi 8,8,4
	cmpwi 0,4,31
	addi 5,5,4
	bc 12,1,.L258
	addi 11,11,4928
	stwx 10,11,8
	lwz 9,84(31)
	addi 9,9,5056
	stwx 6,9,8
.L258:
	addi 7,7,4
	addi 6,6,1
	lwz 3,84(31)
	bdnz .L287
	cmpwi 0,4,31
	bc 12,1,.L252
	addi 10,10,1
	addi 12,12,1
	cmpwi 7,10,52
	cmpwi 0,12,51
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,10,0
	rlwinm 9,9,0,27,28
	or 10,0,9
	bc 4,1,.L255
.L252:
	lwz 10,4924(3)
	cmpwi 0,10,31
	bc 4,1,.L267
	li 0,0
	b .L268
.L267:
	slwi 10,10,2
	addi 9,3,4928
	lwzx 11,9,10
	srawi 0,11,31
	subf 0,11,0
	srwi 0,0,31
.L268:
	cmpwi 0,0,0
	bc 4,2,.L266
	lwz 9,84(31)
	stw 0,4924(9)
.L266:
	lwz 11,84(31)
	lis 9,level+4@ha
	lis 10,.LC26@ha
	lfs 12,level+4@l(9)
	la 10,.LC26@l(10)
	lfs 0,4920(11)
	lfs 13,0(10)
	fsubs 0,12,0
	fcmpu 0,0,13
	bc 4,1,.L270
	stfs 12,4920(11)
	b .L234
.L270:
	li 0,33
	lwz 8,4924(11)
	li 6,0
	mtctr 0
	li 7,31
.L286:
	lwz 9,84(31)
	lwz 11,4924(9)
	addi 11,11,-1
	stw 11,4924(9)
	lwz 9,84(31)
	lwz 0,4924(9)
	cmpwi 0,0,0
	bc 4,0,.L275
	stw 7,4924(9)
.L275:
	lwz 9,84(31)
	lwz 10,4924(9)
	cmpwi 0,10,31
	bc 4,1,.L277
	li 0,0
	b .L278
.L277:
	slwi 10,10,2
	addi 9,9,4928
	lwzx 11,9,10
	srawi 0,11,31
	subf 0,11,0
	srwi 0,0,31
.L278:
	cmpwi 0,0,0
	bc 4,2,.L272
	addi 6,6,1
	bdnz .L286
.L272:
	cmpwi 0,6,33
	bc 4,2,.L281
	lwz 9,84(31)
	stw 8,4924(9)
.L281:
	lwz 9,84(31)
	lwz 10,4924(9)
	cmpwi 0,10,31
	bc 4,1,.L283
	li 0,0
	b .L284
.L283:
	slwi 10,10,2
	addi 9,9,4928
	lwzx 11,9,10
	srawi 0,11,31
	subf 0,11,0
	srwi 0,0,31
.L284:
	cmpwi 0,0,0
	bc 4,2,.L282
	lwz 9,84(31)
	stw 0,4924(9)
.L282:
	lis 9,level+4@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	stfs 0,4920(11)
.L234:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 CmdPrev,.Lfe7-CmdPrev
	.section	".rodata"
	.align 2
.LC27:
	.string	"You must run the server with '+set cheats 1' to enable this command.\n"
	.align 2
.LC28:
	.string	"all"
	.align 2
.LC29:
	.string	"health"
	.align 2
.LC30:
	.string	"weapon_supershotgun"
	.align 2
.LC31:
	.string	"weapon_shotgun"
	.align 2
.LC32:
	.string	"super shotgun"
	.align 2
.LC35:
	.string	"misc_actor"
	.align 2
.LC36:
	.string	"unknown entity\n"
	.align 2
.LC33:
	.long 0x46fffe00
	.align 3
.LC34:
	.long 0x40668000
	.long 0x0
	.align 2
.LC37:
	.long 0x0
	.align 3
.LC38:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC39:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC40:
	.long 0x43960000
	.align 2
.LC41:
	.long 0x43160000
	.align 2
.LC42:
	.long 0x42c80000
	.align 2
.LC43:
	.long 0x42000000
	.align 2
.LC44:
	.long 0x41800000
	.align 2
.LC45:
	.long 0x40a00000
	.align 2
.LC46:
	.long 0x41f00000
	.align 2
.LC47:
	.long 0x43000000
	.section	".text"
	.align 2
	.globl CmdGive
	.type	 CmdGive,@function
CmdGive:
	stwu 1,-160(1)
	mflr 0
	stfd 30,144(1)
	stfd 31,152(1)
	stmw 26,120(1)
	stw 0,164(1)
	lis 9,deathmatch@ha
	lis 8,.LC37@ha
	lwz 11,deathmatch@l(9)
	la 8,.LC37@l(8)
	mr 26,3
	lfs 13,0(8)
	mr 29,4
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L290
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L290
	lis 9,gi+8@ha
	lis 5,.LC27@ha
	lwz 0,gi+8@l(9)
	la 5,.LC27@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L289
.L290:
	lis 9,gi@ha
	cmpwi 0,29,0
	la 31,gi@l(9)
	lwz 9,164(31)
	mfcr 28
	mtlr 9
	blrl
	mr 30,3
	mtcrf 128,28
	bc 12,2,.L291
	mr 30,29
	b .L292
.L291:
	lwz 0,160(31)
	li 3,1
	mtlr 0
	blrl
	lis 4,.LC28@ha
	la 4,.LC28@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L292
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L289
	lis 9,itemlist@ha
	mr 27,11
	la 30,itemlist@l(9)
	li 31,0
	mr 28,30
.L297:
	cmpwi 0,28,0
	bc 12,2,.L296
	lwzx 4,31,30
	cmpwi 0,4,0
	bc 12,2,.L296
	mr 3,26
	bl CmdGive
.L296:
	lwz 0,1556(27)
	addi 29,29,1
	addi 28,28,44
	addi 31,31,44
	cmpw 0,29,0
	bc 12,0,.L297
	b .L289
.L292:
	lis 9,gi@ha
	li 3,1
	la 31,gi@l(9)
	lwz 9,160(31)
	mtlr 9
	blrl
	lis 4,.LC29@ha
	la 4,.LC29@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L300
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L301
	lwz 0,160(31)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	stw 3,480(26)
	b .L289
.L301:
	lwz 0,484(26)
	stw 0,480(26)
	b .L289
.L300:
	lis 4,.LC30@ha
	mr 3,30
	la 4,.LC30@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L303
	lis 9,.LC31@ha
	la 30,.LC31@l(9)
.L303:
	lis 4,.LC32@ha
	mr 3,30
	la 4,.LC32@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L304
	lis 9,.LC31@ha
	la 30,.LC31@l(9)
.L304:
	lwz 9,84(26)
	li 0,0
	mtcrf 128,28
	lfs 0,4732(9)
	stfs 0,24(1)
	lfs 13,4736(9)
	stfs 13,28(1)
	lfs 0,4740(9)
	stw 0,24(1)
	stfs 0,32(1)
	bc 12,2,.L305
	bl rand
	lis 29,0x4330
	rlwinm 3,3,0,17,31
	lfs 12,28(1)
	xoris 3,3,0x8000
	lis 8,.LC38@ha
	stw 3,116(1)
	la 8,.LC38@l(8)
	lis 10,.LC33@ha
	stw 29,112(1)
	lis 11,.LC39@ha
	addi 28,1,24
	lfd 31,0(8)
	la 11,.LC39@l(11)
	addi 4,1,8
	lfd 13,112(1)
	li 5,0
	li 6,0
	lfs 30,.LC33@l(10)
	mr 3,28
	lfd 10,0(11)
	fsub 13,13,31
	lis 11,.LC34@ha
	lfd 11,.LC34@l(11)
	frsp 13,13
	fdivs 13,13,30
	fmr 0,13
	fsub 0,0,10
	fadd 0,0,0
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,28(1)
	bl AngleVectors
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC40@ha
	stw 3,116(1)
	lis 10,.LC41@ha
	la 8,.LC40@l(8)
	stw 29,112(1)
	la 10,.LC41@l(10)
	addi 3,1,8
	lfd 1,112(1)
	mr 4,3
	lfs 13,0(8)
	lfs 0,0(10)
	fsub 1,1,31
	frsp 1,1
	fdivs 1,1,30
	fmadds 1,1,13,0
	bl VectorScale
	bl rand
	rlwinm 3,3,0,17,31
	lfs 13,16(1)
	xoris 3,3,0x8000
	lis 8,.LC42@ha
	stw 3,116(1)
	la 8,.LC42@l(8)
	stw 29,112(1)
	mr 3,28
	lfd 0,112(1)
	lfs 12,0(8)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmadds 0,0,12,12
	fadds 13,13,0
	stfs 13,16(1)
	b .L306
.L305:
	addi 29,1,24
	addi 4,1,8
	mr 3,29
	li 5,0
	li 6,0
	bl AngleVectors
	lis 8,.LC41@ha
	addi 3,1,8
	la 8,.LC41@l(8)
	mr 4,3
	lfs 1,0(8)
	bl VectorScale
	mr 3,29
.L306:
	addi 27,1,56
	addi 29,1,88
	addi 5,1,72
	mr 6,29
	mr 4,27
	bl AngleVectors
	lis 8,.LC43@ha
	lfs 12,4(26)
	addi 31,1,40
	lfs 13,8(26)
	la 8,.LC43@l(8)
	mr 3,31
	lfs 0,12(26)
	mr 4,27
	mr 5,31
	lfs 1,0(8)
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
	bl VectorMA
	lis 8,.LC44@ha
	mr 4,29
	la 8,.LC44@l(8)
	mr 3,31
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	mr 3,30
	bl FindItemByClassname
	mr. 28,3
	bc 4,2,.L314
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	mr 30,3
	bl FindItem
	mr. 28,3
	bc 12,2,.L308
.L314:
	mr 3,26
	mr 5,31
	mr 4,28
	addi 6,1,8
	bl LaunchItem
	mr. 29,3
	bc 12,2,.L289
	lis 9,level@ha
	lis 8,.LC45@ha
	lwz 11,648(29)
	la 9,level@l(9)
	la 8,.LC45@l(8)
	lfs 0,4(9)
	li 0,0
	lis 10,.LC46@ha
	lfs 13,0(8)
	la 10,.LC46@l(10)
	stw 0,56(29)
	lfs 12,0(10)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,24(28)
	stw 0,532(29)
	lfs 0,4(9)
	fadds 0,0,12
	stfs 0,428(29)
	lwz 0,20(11)
	cmpwi 0,0,12
	bc 4,2,.L310
	lwz 0,508(29)
	ori 0,0,15
	stw 0,508(29)
.L310:
	lwz 11,648(29)
	lis 10,0x4330
	lis 8,.LC38@ha
	mr 3,29
	lwz 0,28(11)
	la 8,.LC38@l(8)
	lfd 13,0(8)
	xoris 0,0,0x8000
	lis 8,gi+72@ha
	stw 0,116(1)
	stw 10,112(1)
	lfd 0,112(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,992(29)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	b .L289
.L308:
	mr 3,30
	bl HasSpawnFunc
	cmpwi 0,3,0
	bc 12,2,.L311
	bl G_Spawn
	mr 29,3
	lis 8,.LC47@ha
	stw 30,280(29)
	la 8,.LC47@l(8)
	mr 4,27
	lfs 13,24(1)
	addi 3,26,4
	addi 5,29,4
	lfs 1,0(8)
	stfs 13,16(29)
	lfs 0,28(1)
	stfs 0,20(29)
	lfs 13,32(1)
	stfs 13,24(29)
	bl VectorMA
	lis 8,.LC44@ha
	lfs 0,12(29)
	lis 4,.LC35@ha
	la 8,.LC44@l(8)
	mr 3,30
	lfs 13,0(8)
	la 4,.LC35@l(4)
	fadds 0,0,13
	stfs 0,12(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L312
	li 3,12
	bl GetItemByTag
	stw 3,648(29)
.L312:
	cmpwi 0,29,0
	bc 12,2,.L311
	mr 3,29
	crxor 6,6,6
	bl ED_CallSpawn
	b .L289
.L311:
	lis 9,gi+8@ha
	lis 5,.LC36@ha
	lwz 0,gi+8@l(9)
	mr 3,26
	la 5,.LC36@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L289:
	lwz 0,164(1)
	mtlr 0
	lmw 26,120(1)
	lfd 30,144(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe8:
	.size	 CmdGive,.Lfe8-CmdGive
	.section	".rodata"
	.align 2
.LC48:
	.string	"No other players to chase."
	.align 3
.LC50:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC51:
	.long 0x47800000
	.align 2
.LC52:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl EndCoopView
	.type	 EndCoopView,@function
EndCoopView:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	li 7,0
	lwz 11,84(31)
	li 0,1
	li 10,32
	li 8,14
	stw 7,4892(11)
	lwz 9,84(31)
	stw 7,4896(9)
	lwz 11,84(31)
	sth 7,144(11)
	lwz 9,84(31)
	stw 0,0(9)
	lwz 11,84(31)
	stb 10,16(11)
	lwz 9,84(31)
	stb 8,17(9)
	lwz 30,324(31)
	cmpwi 0,30,0
	bc 12,2,.L334
	lwz 9,84(31)
	lwz 0,5184(9)
	cmpwi 0,0,0
	bc 4,2,.L334
	mr 7,30
	lis 11,.LC51@ha
	lfs 13,4(7)
	la 11,.LC51@l(11)
	li 0,3
	lfs 10,0(11)
	mtctr 0
	li 5,0
	li 6,0
	lis 11,.LC52@ha
	stfs 13,4(31)
	la 11,.LC52@l(11)
	lfs 0,8(7)
	lfs 11,0(11)
	stfs 0,8(31)
	lfs 13,12(7)
	stfs 13,12(31)
	lfs 0,1004(7)
	stfs 0,16(31)
	lfs 13,1008(7)
	stfs 13,20(31)
	lfs 0,1012(7)
	stfs 0,24(31)
	lfs 13,1004(7)
	stfs 13,28(9)
	lfs 0,1008(7)
	lwz 9,84(31)
	stfs 0,32(9)
	lfs 0,1012(7)
	lwz 11,84(31)
	stfs 0,36(11)
	lfs 0,1004(7)
	lwz 9,84(31)
	stfs 0,4732(9)
	lfs 0,1008(7)
	lwz 11,84(31)
	stfs 0,4736(11)
	lfs 13,1012(7)
	lwz 9,84(31)
	stfs 13,4740(9)
.L340:
	lwz 11,84(31)
	add 0,5,5
	addi 5,5,1
	addi 10,11,4548
	addi 9,11,4732
	lfsx 0,9,6
	addi 11,11,20
	lfsx 13,10,6
	addi 6,6,4
	fsubs 0,0,13
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 8,28(1)
	sthx 8,11,0
	bdnz .L340
	li 29,0
	li 9,4
	stw 29,1016(30)
	li 11,2
	mr 3,31
	lwz 0,184(31)
	stw 9,260(31)
	rlwinm 0,0,0,0,30
	stw 11,248(31)
	stw 0,184(31)
	bl SetupItemModels
	lwz 0,184(30)
	lis 9,G_FreeEdict@ha
	lis 10,level+4@ha
	la 9,G_FreeEdict@l(9)
	stw 29,248(30)
	lis 11,.LC50@ha
	ori 0,0,1
	stw 9,436(30)
	li 7,0
	stw 0,184(30)
	lfs 0,level+4@l(10)
	lfd 13,.LC50@l(11)
	stw 29,324(30)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
	stw 7,324(31)
.L334:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 EndCoopView,.Lfe9-EndCoopView
	.section	".rodata"
	.align 3
.LC53:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC54:
	.long 0x0
	.align 2
.LC55:
	.long 0x3f800000
	.align 3
.LC56:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CmdCoopView
	.type	 CmdCoopView,@function
CmdCoopView:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 11,.LC54@ha
	lis 9,deathmatch@ha
	la 11,.LC54@l(11)
	mr 30,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L341
	lwz 9,84(30)
	lwz 31,4892(9)
	cmpwi 0,31,0
	bc 12,2,.L343
	bl ChaseNext
	lwz 9,84(30)
	lwz 0,4892(9)
	cmpw 0,0,31
	bc 12,2,.L345
	cmpw 0,0,30
	bc 4,2,.L341
.L345:
	mr 3,30
	bl EndCoopView
	b .L341
.L343:
	lis 11,.LC55@ha
	lis 9,maxclients@ha
	la 11,.LC55@l(11)
	li 10,1
	lfs 0,0(11)
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L356
	lis 9,g_edicts@ha
	fmr 12,13
	lis 8,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	addi 11,11,1084
	lfd 13,0(9)
.L349:
	cmpw 0,11,30
	bc 12,2,.L351
	lwz 9,84(11)
	lwz 0,5184(9)
	cmpwi 0,0,0
	bc 4,2,.L351
	lwz 0,260(11)
	cmpwi 0,0,1
	bc 12,2,.L351
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L351
	lwz 0,4560(9)
	cmpwi 0,0,0
	bc 12,2,.L355
.L351:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,1084
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L349
.L356:
	lis 9,gi+12@ha
	lis 4,.LC48@ha
	lwz 0,gi+12@l(9)
	la 4,.LC48@l(4)
	mr 3,30
	mtlr 0
	crxor 6,6,6
	blrl
	li 11,0
.L355:
	lwz 9,84(30)
	stw 11,4892(9)
	lwz 9,84(30)
	lwz 0,4892(9)
	cmpwi 0,0,0
	bc 12,2,.L341
	lwz 0,5184(9)
	cmpwi 0,0,0
	bc 4,2,.L358
	bl G_Spawn
	mr. 31,3
	bc 12,2,.L341
	li 5,84
	mr 4,30
	mr 3,31
	crxor 6,6,6
	bl memcpy
	lis 9,g_edicts@ha
	lis 11,0xa27a
	lwz 0,g_edicts@l(9)
	ori 11,11,52719
	li 7,7
	lis 6,level+4@ha
	lis 8,.LC53@ha
	subf 0,0,31
	lis 10,DecoyThink@ha
	mullw 0,0,11
	la 10,DecoyThink@l(10)
	lis 5,gi+72@ha
	li 11,1
	mr 3,31
	srawi 0,0,2
	stw 0,0(31)
	lwz 9,84(30)
	lfs 0,28(9)
	stfs 0,1004(31)
	lwz 9,84(30)
	lfs 0,32(9)
	stfs 0,1008(31)
	lwz 9,84(30)
	lfs 0,36(9)
	stfs 0,1012(31)
	lwz 0,184(30)
	stw 0,184(31)
	lfs 0,188(30)
	stfs 0,188(31)
	lfs 13,192(30)
	stfs 13,192(31)
	lfs 0,196(30)
	stfs 0,196(31)
	lfs 13,200(30)
	stfs 13,200(31)
	lfs 0,204(30)
	stfs 0,204(31)
	lfs 13,208(30)
	stfs 13,208(31)
	lfs 0,212(30)
	stfs 0,212(31)
	lfs 13,216(30)
	stfs 13,216(31)
	lfs 0,220(30)
	stfs 0,220(31)
	lfs 13,224(30)
	stfs 13,224(31)
	lfs 0,228(30)
	stfs 0,228(31)
	lfs 13,232(30)
	lfd 12,.LC53@l(8)
	stfs 13,232(31)
	lfs 0,236(30)
	stfs 0,236(31)
	lfs 13,240(30)
	stfs 13,240(31)
	lfs 0,244(30)
	stfs 0,244(31)
	lwz 0,508(30)
	stw 0,508(31)
	lwz 9,248(30)
	stw 9,248(31)
	lwz 0,252(30)
	stw 0,252(31)
	lwz 9,256(30)
	stw 7,260(31)
	stw 9,256(31)
	lwz 0,512(30)
	stw 0,512(31)
	lwz 9,480(30)
	stw 9,480(31)
	lfs 0,level+4@l(6)
	stw 10,436(31)
	stw 11,1016(31)
	stw 30,324(31)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(31)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
	stw 31,324(30)
.L358:
	lwz 10,84(30)
	li 11,1
	li 8,0
	lis 7,gi+72@ha
	mr 3,30
	stw 11,0(10)
	lwz 9,84(30)
	stw 11,4896(9)
	lwz 0,184(30)
	lwz 9,84(30)
	ori 0,0,1
	stw 11,260(30)
	stw 0,184(30)
	stw 8,248(30)
	stw 8,88(9)
	lwz 0,gi+72@l(7)
	mtlr 0
	blrl
	mr 3,30
	bl UpdateChaseCam
.L341:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 CmdCoopView,.Lfe10-CmdCoopView
	.section	".rodata"
	.align 2
.LC57:
	.string	"pact"
	.align 2
.LC58:
	.string	"mact"
	.align 2
.LC59:
	.string	"drop"
	.align 2
.LC60:
	.string	"weapprev"
	.align 2
.LC61:
	.string	"weapnext"
	.align 2
.LC62:
	.string	"give"
	.align 2
.LC63:
	.string	"reload"
	.align 2
.LC64:
	.string	"coopview"
	.align 2
.LC65:
	.string	"gotosecret"
	.align 2
.LC66:
	.long 0x3f800000
	.align 2
.LC67:
	.long 0x0
	.section	".text"
	.align 2
	.globl z_ClientCommand
	.type	 z_ClientCommand,@function
z_ClientCommand:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+160@ha
	mr 31,3
	lwz 0,gi+160@l(9)
	li 3,0
	mtlr 0
	blrl
	mr 29,3
	lis 4,.LC57@ha
	la 4,.LC57@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L362
	lwz 9,84(31)
	li 0,1
	b .L389
.L362:
	lis 4,.LC58@ha
	mr 3,29
	la 4,.LC58@l(4)
	bl Q_stricmp
	mr. 0,3
	bc 4,2,.L364
	lwz 9,84(31)
.L389:
	li 3,1
	stw 0,4916(9)
	b .L388
.L364:
	lis 4,.LC59@ha
	mr 3,29
	la 4,.LC59@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L366
	lwz 11,84(31)
	lis 9,level+4@ha
	lis 10,.LC66@ha
	lfs 12,level+4@l(9)
	la 10,.LC66@l(10)
	lfs 0,4920(11)
	lfs 13,0(10)
	fsubs 0,12,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L367
	stfs 12,4920(11)
	li 4,150
	mr 3,31
	lwz 9,84(31)
	lis 29,0xc120
	lwz 0,4924(9)
	addi 9,9,5056
	slwi 0,0,2
	lwzx 5,9,0
	bl ThrowBodyAreaItem
	lwz 9,84(31)
	mr 3,31
	stw 29,4920(9)
	bl CmdPrev
	lwz 9,84(31)
	mr 3,31
	stw 29,4920(9)
	b .L394
.L367:
	mr 3,31
	bl CmdDropWeapon
	b .L395
.L366:
	lis 4,.LC60@ha
	mr 3,29
	la 4,.LC60@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L372
	mr 3,31
	bl CmdPrev
.L395:
	li 3,1
	b .L388
.L372:
	lis 4,.LC61@ha
	mr 3,29
	la 4,.LC61@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L374
	mr 3,31
.L394:
	bl CmdNext
	b .L395
.L374:
	lis 4,.LC62@ha
	mr 3,29
	la 4,.LC62@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L376
	mr 3,31
	li 4,0
	bl CmdGive
	b .L395
.L376:
	lis 4,.LC63@ha
	mr 3,29
	la 4,.LC63@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L378
	mr 3,31
	bl CanRightReload
	cmpwi 0,3,0
	bc 12,2,.L395
	lwz 9,84(31)
	li 0,9
	stw 0,4664(9)
	b .L395
.L378:
	lis 4,.LC64@ha
	mr 3,29
	la 4,.LC64@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L382
	mr 3,31
	bl CmdCoopView
	b .L395
.L382:
	lis 4,.LC65@ha
	mr 3,29
	la 4,.LC65@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L384
	lis 9,.LC67@ha
	lis 11,sv_edit@ha
	la 9,.LC67@l(9)
	lfs 13,0(9)
	lwz 9,sv_edit@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L385
	mr 3,31
	bl CmdGotoSecret
	b .L395
.L385:
.L384:
	li 3,0
.L388:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 z_ClientCommand,.Lfe11-z_ClientCommand
	.align 2
	.globl UpdateInv
	.type	 UpdateInv,@function
UpdateInv:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	lis 28,0xc120
	lwz 9,84(29)
	stw 28,4920(9)
	bl CmdPrev
	lwz 9,84(29)
	mr 3,29
	stw 28,4920(9)
	bl CmdNext
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 UpdateInv,.Lfe12-UpdateInv
	.section	".rodata"
	.align 2
.LC68:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl CmdDrop
	.type	 CmdDrop,@function
CmdDrop:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lis 9,level+4@ha
	lwz 11,84(31)
	lis 10,.LC68@ha
	lfs 12,level+4@l(9)
	la 10,.LC68@l(10)
	lfs 0,4920(11)
	lfs 13,0(10)
	fsubs 0,12,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L317
	stfs 12,4920(11)
	li 4,150
	lwz 9,84(31)
	lis 29,0xc120
	lwz 0,4924(9)
	addi 9,9,5056
	slwi 0,0,2
	lwzx 5,9,0
	bl ThrowBodyAreaItem
	lwz 9,84(31)
	mr 3,31
	stw 29,4920(9)
	bl CmdPrev
	lwz 9,84(31)
	mr 3,31
	stw 29,4920(9)
	bl CmdNext
	b .L319
.L317:
	mr 3,31
	bl CmdDropWeapon
.L319:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 CmdDrop,.Lfe13-CmdDrop
	.align 2
	.globl CmdReload
	.type	 CmdReload,@function
CmdReload:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl CanRightReload
	cmpwi 0,3,0
	bc 12,2,.L321
	lwz 9,84(31)
	li 0,9
	stw 0,4664(9)
.L321:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 CmdReload,.Lfe14-CmdReload
	.section	".rodata"
	.align 2
.LC69:
	.long 0x3f800000
	.align 3
.LC70:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl zGetChaseTarget
	.type	 zGetChaseTarget,@function
zGetChaseTarget:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC69@ha
	lis 9,maxclients@ha
	la 11,.LC69@l(11)
	mr 10,3
	lfs 0,0(11)
	li 8,1
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L324
	lis 9,g_edicts@ha
	fmr 12,13
	lis 7,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC70@ha
	la 9,.LC70@l(9)
	addi 3,11,1084
	lfd 13,0(9)
.L326:
	cmpw 0,3,10
	bc 12,2,.L325
	lwz 9,84(3)
	lwz 0,5184(9)
	cmpwi 0,0,0
	bc 4,2,.L325
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 12,2,.L325
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L325
	lwz 0,4560(9)
	cmpwi 0,0,0
	bc 12,2,.L396
.L325:
	addi 8,8,1
	xoris 0,8,0x8000
	addi 3,3,1084
	stw 0,12(1)
	stw 7,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L326
.L324:
	lis 9,gi+12@ha
	lis 4,.LC48@ha
	lwz 0,gi+12@l(9)
	mr 3,10
	la 4,.LC48@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
.L396:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 zGetChaseTarget,.Lfe15-zGetChaseTarget
	.section	".rodata"
	.align 3
.LC71:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 DecoyThink,@function
DecoyThink:
	lwz 9,56(3)
	lis 0,0xd20d
	lis 11,.LC71@ha
	ori 0,0,8403
	lfd 13,.LC71@l(11)
	lis 10,level+4@ha
	addi 9,9,1
	mulhw 0,9,0
	srawi 11,9,31
	add 0,0,9
	srawi 0,0,5
	subf 0,11,0
	mulli 0,0,39
	subf 9,0,9
	stw 9,56(3)
	lfs 0,level+4@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe16:
	.size	 DecoyThink,.Lfe16-DecoyThink
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
