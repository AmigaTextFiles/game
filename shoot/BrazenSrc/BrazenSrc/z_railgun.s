	.file	"z_railgun.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0xc0400000
	.align 3
.LC1:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl RailgunFire
	.type	 RailgunFire,@function
RailgunFire:
	stwu 1,-112(1)
	mflr 0
	stmw 26,88(1)
	stw 0,116(1)
	mr 31,3
	addi 29,1,24
	lwz 3,84(31)
	addi 28,1,40
	mr 4,29
	li 6,0
	mr 5,28
	addi 3,3,4732
	addi 26,31,4
	bl AngleVectors
	lis 9,.LC0@ha
	lwz 4,84(31)
	mr 3,29
	la 9,.LC0@l(9)
	lfs 1,0(9)
	addi 4,4,4680
	bl VectorScale
	lwz 9,84(31)
	lis 0,0xc040
	lis 27,0x4330
	lis 10,0x40e0
	stw 0,4668(9)
	addi 8,1,8
	addi 5,1,56
	lis 9,.LC1@ha
	li 0,0
	lwz 3,84(31)
	la 9,.LC1@l(9)
	mr 6,29
	lfd 13,0(9)
	mr 7,28
	mr 4,26
	lwz 9,508(31)
	stw 0,56(1)
	addi 9,9,-8
	stw 10,60(1)
	xoris 9,9,0x8000
	stw 9,84(1)
	stw 27,80(1)
	lfd 0,80(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	bl P_ProjectSource
	addi 4,1,8
	li 6,150
	li 7,250
	mr 5,29
	mr 3,31
	bl fire_rail
	addi 4,1,8
	li 5,1
	mr 3,31
	bl PlayerNoise
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xa27a
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,52719
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(29)
	li 3,6
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
	lwz 11,84(31)
	addi 4,1,8
	mr 3,31
	li 5,1
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	bl PlayerNoise
	li 4,0
	li 8,0
.L10:
	lwz 10,84(31)
	addi 9,10,1848
	lwzx 0,9,8
	cmpwi 0,0,30
	bc 4,2,.L9
	addi 10,10,1976
	lwzx 9,10,8
	addi 9,9,-1
	stwx 9,10,8
	lwz 11,84(31)
	addi 11,11,1976
	lwzx 0,11,8
	cmpwi 0,0,0
	bc 12,1,.L8
	mr 3,31
	bl RemoveItem
	b .L8
.L9:
	addi 4,4,1
	addi 8,8,4
	cmpwi 0,4,31
	bc 4,1,.L10
.L8:
	lwz 0,116(1)
	mtlr 0
	lmw 26,88(1)
	la 1,112(1)
	blr
.Lfe1:
	.size	 RailgunFire,.Lfe1-RailgunFire
	.section	".rodata"
	.align 2
.LC2:
	.string	"weapons/rg_hum.wav"
	.align 2
.LC3:
	.long 0x46fffe00
	.align 2
.LC4:
	.long 0x41000000
	.align 3
.LC5:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC6:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Think_Railgun
	.type	 Think_Railgun,@function
Think_Railgun:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	li 29,-1
	lwz 9,84(31)
	li 30,-1
	lwz 11,4664(9)
	lwz 10,4620(9)
	lwz 0,4612(9)
	cmpwi 0,11,0
	lha 8,130(9)
	or 0,10,0
	rlwinm 6,0,0,30,30
	rlwinm 7,0,0,31,31
	bc 12,2,.L16
	cmpwi 0,11,1
	bc 12,2,.L27
	b .L15
.L16:
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 12,1,.L51
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L19
	li 0,19
	mr 3,31
	stw 0,92(9)
	bl ChangeLeftWeapon
	b .L14
.L19:
	srawi 0,8,31
	subf 0,8,0
	srwi 11,0,31
	and. 0,7,11
	bc 12,2,.L21
	rlwinm 0,10,0,0,30
	li 11,4
	stw 0,4620(9)
	li 29,7
	b .L52
.L21:
	neg 0,6
	srwi 0,0,31
	and. 8,0,11
	bc 12,2,.L23
	rlwinm 0,10,0,31,29
	li 11,4
	stw 0,4620(9)
	li 29,8
.L52:
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl RailgunFire
	b .L15
.L23:
	lis 9,level+4@ha
	lfs 13,992(31)
	lis 8,.LC4@ha
	lfs 0,level+4@l(9)
	la 8,.LC4@l(8)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L25
	li 30,20
	li 29,1
	b .L15
.L25:
	li 30,19
	b .L15
.L27:
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L28
.L51:
	li 30,57
	li 29,4
	b .L15
.L28:
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L30
	mr 3,31
	bl ChangeLeftWeapon
	b .L14
.L30:
	neg 0,6
	srwi 0,0,31
	or. 8,7,0
	bc 12,2,.L15
	li 0,0
	li 11,19
	stw 0,4664(9)
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_Railgun
	b .L14
.L15:
	lwz 9,84(31)
	lwz 0,92(9)
	mr 8,9
	cmpwi 0,0,19
	bc 12,2,.L38
	bc 12,1,.L47
	cmpwi 0,0,3
	bc 12,2,.L36
	cmpwi 0,0,18
	bc 12,2,.L37
	b .L44
.L47:
	cmpwi 0,0,56
	bc 12,2,.L39
	cmpwi 0,0,61
	bc 12,2,.L42
	b .L44
.L36:
	li 0,0
	li 10,19
	stw 0,4664(8)
	lis 11,gi+36@ha
	lis 3,.LC2@ha
	lwz 9,84(31)
	la 3,.LC2@l(3)
	stw 10,92(9)
	lwz 0,gi+36@l(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 3,4832(9)
	mr 3,31
	bl Think_Railgun
	b .L14
.L37:
	li 0,0
	li 11,19
	stw 0,4664(8)
	lwz 9,84(31)
	stw 11,92(9)
	b .L35
.L38:
	lis 9,gi+36@ha
	lis 3,.LC2@ha
	lwz 0,gi+36@l(9)
	la 3,.LC2@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 3,4832(9)
	b .L35
.L39:
	bl rand
	li 30,20
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 8,.LC5@ha
	lis 11,.LC3@ha
	la 8,.LC5@l(8)
	stw 0,24(1)
	lis 10,.LC6@ha
	lfd 13,0(8)
	la 10,.LC6@l(10)
	lfd 0,24(1)
	lfs 12,.LC3@l(11)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L35
	li 30,19
	li 29,0
	b .L35
.L42:
	li 0,0
	stw 0,4832(8)
	lwz 9,84(31)
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L35
	mr 3,31
	bl ChangeRightWeapon
	b .L35
.L44:
	cmpwi 0,30,-1
	bc 4,2,.L50
	lwz 9,92(8)
	addi 9,9,1
	stw 9,92(8)
.L35:
	cmpwi 0,30,-1
	bc 12,2,.L48
.L50:
	lwz 9,84(31)
	stw 30,92(9)
.L48:
	cmpwi 0,29,-1
	bc 12,2,.L14
	lwz 9,84(31)
	stw 29,4664(9)
.L14:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Think_Railgun,.Lfe2-Think_Railgun
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
