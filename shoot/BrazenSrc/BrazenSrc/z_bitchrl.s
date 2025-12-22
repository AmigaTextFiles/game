	.file	"z_bitchrl.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"chick/chkatck2.wav"
	.align 3
.LC1:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC2:
	.long 0x42c80000
	.align 2
.LC3:
	.long 0x43fa0000
	.align 2
.LC4:
	.long 0x428c0000
	.align 2
.LC5:
	.long 0x3f800000
	.align 2
.LC6:
	.long 0x0
	.section	".text"
	.align 2
	.globl BitchWeaponFire
	.type	 BitchWeaponFire,@function
BitchWeaponFire:
	stwu 1,-112(1)
	mflr 0
	stmw 27,92(1)
	stw 0,116(1)
	mr 28,3
	addi 29,1,24
	lwz 3,84(28)
	addi 27,1,40
	mr 4,29
	mr 5,27
	li 6,0
	addi 3,3,4732
	bl AngleVectors
	lwz 9,508(28)
	lis 8,0x4330
	lis 11,.LC1@ha
	lwz 3,84(28)
	li 0,0
	addi 9,9,-8
	la 11,.LC1@l(11)
	stw 0,56(1)
	xoris 9,9,0x8000
	lfd 13,0(11)
	addi 5,1,56
	stw 9,84(1)
	lis 11,0x4080
	mr 6,29
	stw 8,80(1)
	mr 7,27
	addi 4,28,4
	lfd 0,80(1)
	addi 8,1,8
	stw 11,60(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	bl P_ProjectSource
	lis 11,.LC2@ha
	lis 9,skill@ha
	la 11,.LC2@l(11)
	lfs 11,0(11)
	addi 4,1,8
	mr 5,29
	lwz 11,skill@l(9)
	li 6,50
	li 8,50
	lis 9,.LC3@ha
	mr 3,28
	la 9,.LC3@l(9)
	lfs 0,20(11)
	lfs 12,0(9)
	lis 11,.LC4@ha
	la 11,.LC4@l(11)
	lfs 1,0(11)
	fmadds 0,0,11,12
	fctiwz 13,0
	stfd 13,80(1)
	lwz 7,84(1)
	bl fire_rocket
	lis 29,gi@ha
	lis 3,.LC0@ha
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC5@ha
	lwz 0,16(29)
	lis 11,.LC6@ha
	la 9,.LC5@l(9)
	la 11,.LC6@l(11)
	lfs 2,0(9)
	mr 5,3
	li 4,1
	mtlr 0
	lis 9,.LC5@ha
	lfs 3,0(11)
	mr 3,28
	la 9,.LC5@l(9)
	lfs 1,0(9)
	blrl
	mr 3,28
	addi 4,1,8
	li 5,1
	bl PlayerNoise
	lwz 11,84(28)
	lwz 9,1820(11)
	addi 9,9,-1
	stw 9,1820(11)
	lwz 0,116(1)
	mtlr 0
	lmw 27,92(1)
	la 1,112(1)
	blr
.Lfe1:
	.size	 BitchWeaponFire,.Lfe1-BitchWeaponFire
	.section	".rodata"
	.align 2
.LC7:
	.long 0x46fffe00
	.align 3
.LC8:
	.long 0x3fe99999
	.long 0x9999999a
	.align 2
.LC9:
	.long 0x41000000
	.align 3
.LC10:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC11:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Think_BitchWeapon
	.type	 Think_BitchWeapon,@function
Think_BitchWeapon:
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
	lwz 8,1820(9)
	or 0,10,0
	rlwinm 6,0,0,30,30
	rlwinm 7,0,0,31,31
	bc 12,2,.L9
	cmpwi 0,11,1
	bc 12,2,.L20
	b .L8
.L9:
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 12,1,.L45
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L12
	li 0,10
	mr 3,31
	stw 0,92(9)
	bl ChangeLeftWeapon
	b .L7
.L12:
	srawi 0,8,31
	subf 0,8,0
	srwi 11,0,31
	and. 0,7,11
	bc 12,2,.L14
	rlwinm 0,10,0,0,30
	b .L46
.L14:
	neg 0,6
	srwi 0,0,31
	and. 8,0,11
	bc 12,2,.L16
	rlwinm 0,10,0,31,29
.L46:
	li 30,4
	stw 0,4620(9)
	li 29,7
	mr 3,31
	bl BitchWeaponFire
	b .L8
.L16:
	lis 9,level+4@ha
	lfs 13,992(31)
	lis 8,.LC9@ha
	lfs 0,level+4@l(9)
	la 8,.LC9@l(8)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L18
	li 30,11
	li 29,1
	b .L8
.L18:
	li 30,10
	b .L8
.L20:
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L21
.L45:
	li 30,19
	li 29,4
	b .L8
.L21:
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L23
	mr 3,31
	bl ChangeLeftWeapon
	b .L7
.L23:
	neg 0,6
	srwi 0,0,31
	or. 8,7,0
	bc 12,2,.L8
	li 0,0
	li 11,10
	stw 0,4664(9)
	b .L47
.L8:
	lwz 11,84(31)
	lwz 9,92(11)
	mr 8,11
	addi 9,9,-3
	cmplwi 0,9,19
	bc 12,1,.L39
	lis 11,.L41@ha
	slwi 10,9,2
	la 11,.L41@l(11)
	lis 9,.L41@ha
	lwzx 0,10,11
	la 9,.L41@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L41:
	.long .L29-.L41
	.long .L39-.L41
	.long .L39-.L41
	.long .L39-.L41
	.long .L39-.L41
	.long .L39-.L41
	.long .L30-.L41
	.long .L28-.L41
	.long .L39-.L41
	.long .L39-.L41
	.long .L39-.L41
	.long .L32-.L41
	.long .L39-.L41
	.long .L39-.L41
	.long .L39-.L41
	.long .L34-.L41
	.long .L39-.L41
	.long .L39-.L41
	.long .L39-.L41
	.long .L37-.L41
.L29:
	li 0,0
	li 11,10
	stw 0,4664(8)
.L47:
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_BitchWeapon
	b .L7
.L30:
	li 0,0
	li 11,10
	stw 0,4664(8)
	lwz 9,84(31)
	stw 11,92(9)
	b .L28
.L32:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 8,.LC10@ha
	lis 10,.LC7@ha
	la 8,.LC10@l(8)
	stw 0,24(1)
	lis 11,.LC8@ha
	lfd 13,0(8)
	lfd 0,24(1)
	lfs 11,.LC7@l(10)
	lfd 12,.LC8@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 12,0,.L7
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L28
.L34:
	bl rand
	li 30,11
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 8,.LC10@ha
	lis 11,.LC7@ha
	la 8,.LC10@l(8)
	stw 0,24(1)
	lis 10,.LC11@ha
	lfd 13,0(8)
	la 10,.LC11@l(10)
	lfd 0,24(1)
	lfs 12,.LC7@l(11)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L28
	li 30,10
	li 29,0
	b .L28
.L37:
	li 0,0
	stw 0,4832(8)
	lwz 9,84(31)
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L28
	mr 3,31
	bl ChangeRightWeapon
	b .L28
.L39:
	cmpwi 0,30,-1
	bc 4,2,.L44
	lwz 9,92(8)
	addi 9,9,1
	stw 9,92(8)
.L28:
	cmpwi 0,30,-1
	bc 12,2,.L42
.L44:
	lwz 9,84(31)
	stw 30,92(9)
.L42:
	cmpwi 0,29,-1
	bc 12,2,.L7
	lwz 9,84(31)
	stw 29,4664(9)
.L7:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Think_BitchWeapon,.Lfe2-Think_BitchWeapon
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
