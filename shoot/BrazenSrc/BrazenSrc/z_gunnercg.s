	.file	"z_gunnercg.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"gunner/gunatck2.wav"
	.align 2
.LC1:
	.string	"gunner/gunatck1.wav"
	.align 3
.LC2:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC3:
	.long 0x3f800000
	.align 2
.LC4:
	.long 0x0
	.align 2
.LC5:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl Think_GunnerWeapon
	.type	 Think_GunnerWeapon,@function
Think_GunnerWeapon:
	stwu 1,-128(1)
	mflr 0
	stmw 25,100(1)
	stw 0,132(1)
	mr 31,3
	li 26,-1
	lwz 10,84(31)
	li 25,-1
	lwz 30,4664(10)
	lwz 9,4620(10)
	lwz 0,4612(10)
	cmpwi 0,30,1
	lwz 11,1820(10)
	or 0,9,0
	rlwinm 27,0,0,30,30
	rlwinm 28,0,0,31,31
	bc 12,2,.L18
	cmplwi 0,30,1
	bc 12,0,.L9
	cmpwi 0,30,7
	bc 12,2,.L24
	cmpwi 0,30,8
	bc 12,2,.L30
	b .L8
.L9:
	lwz 0,4900(10)
	cmpwi 0,0,-1
	bc 12,1,.L50
	lwz 0,4904(10)
	cmpwi 0,0,-1
	bc 4,1,.L12
	li 0,16
	mr 3,31
	stw 0,92(10)
	bl ChangeLeftWeapon
	b .L7
.L12:
	cmpwi 0,28,0
	bc 12,2,.L14
	rlwinm 0,9,0,0,30
	li 11,4
	stw 0,4620(10)
	li 26,7
	b .L51
.L14:
	cmpwi 0,27,0
	bc 12,2,.L16
	rlwinm 0,9,0,31,29
	li 11,4
	stw 0,4620(10)
	li 26,8
.L51:
	lwz 9,84(31)
	stw 11,92(9)
	b .L8
.L16:
	li 25,16
	b .L8
.L18:
	lwz 0,4900(10)
	cmpwi 0,0,-1
	bc 4,1,.L19
.L50:
	li 25,17
	li 26,4
	b .L8
.L19:
	lwz 0,4904(10)
	cmpwi 0,0,-1
	bc 4,1,.L21
	mr 3,31
	bl ChangeLeftWeapon
	b .L7
.L21:
	neg 0,27
	srwi 0,0,31
	or. 9,28,0
	bc 12,2,.L8
	li 0,0
	li 11,16
	stw 0,4664(10)
	b .L52
.L24:
	lwz 9,92(10)
	addi 9,9,-7
	cmplwi 0,9,4
	bc 12,1,.L8
	cmpwi 0,11,0
	bc 4,1,.L26
	addi 4,1,24
	addi 5,1,40
	addi 3,10,4732
	li 6,0
	bl AngleVectors
	lwz 9,508(31)
	lis 8,0x4330
	lis 11,.LC2@ha
	lwz 3,84(31)
	li 0,0
	addi 9,9,-8
	la 11,.LC2@l(11)
	stw 0,56(1)
	xoris 9,9,0x8000
	lfd 13,0(11)
	addi 5,1,56
	stw 9,92(1)
	lis 11,0x40e0
	addi 6,1,24
	stw 8,88(1)
	addi 7,1,40
	addi 4,31,4
	lfd 0,88(1)
	addi 8,1,8
	stw 11,60(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	bl P_ProjectSource
	li 9,500
	addi 4,1,8
	addi 5,1,24
	li 10,4
	li 6,3
	li 7,4
	li 8,300
	mr 3,31
	bl fire_bullet
	lis 29,gi@ha
	lis 3,.LC0@ha
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC3@ha
	lwz 0,16(29)
	lis 11,.LC3@ha
	la 9,.LC3@l(9)
	la 11,.LC3@l(11)
	lfs 1,0(9)
	mr 5,3
	li 4,1
	mtlr 0
	lis 9,.LC4@ha
	lfs 2,0(11)
	mr 3,31
	la 9,.LC4@l(9)
	lfs 3,0(9)
	blrl
	mr 3,31
	addi 4,1,8
	li 5,1
	bl PlayerNoise
	lwz 11,84(31)
	lwz 9,1820(11)
	addi 9,9,-1
	stw 9,1820(11)
.L26:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,11
	bc 4,2,.L8
	neg 0,27
	srwi 0,0,31
	or. 11,28,0
	bc 12,2,.L8
	cmpwi 0,28,0
	stw 30,92(9)
	bc 4,2,.L7
	lwz 9,84(31)
	li 0,8
	stw 0,4664(9)
	b .L7
.L30:
	lwz 9,92(10)
	addi 9,9,-7
	cmplwi 0,9,4
	bc 12,1,.L8
	cmpwi 0,28,0
	bc 12,2,.L32
	li 0,7
	stw 0,4664(10)
.L32:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,11
	bc 4,2,.L8
	neg 0,27
	srwi 0,0,31
	or. 11,28,0
	bc 12,2,.L8
	li 0,7
	stw 0,92(9)
	b .L7
.L8:
	lwz 11,84(31)
	lwz 9,92(11)
	mr 8,11
	addi 9,9,-3
	cmplwi 0,9,17
	bc 12,1,.L44
	lis 11,.L46@ha
	slwi 10,9,2
	la 11,.L46@l(11)
	lis 9,.L46@ha
	lwzx 0,10,11
	la 9,.L46@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L46:
	.long .L37-.L46
	.long .L39-.L46
	.long .L44-.L46
	.long .L44-.L46
	.long .L44-.L46
	.long .L44-.L46
	.long .L44-.L46
	.long .L44-.L46
	.long .L44-.L46
	.long .L39-.L46
	.long .L44-.L46
	.long .L44-.L46
	.long .L40-.L46
	.long .L36-.L46
	.long .L44-.L46
	.long .L44-.L46
	.long .L44-.L46
	.long .L42-.L46
.L37:
	li 0,0
	li 11,16
	stw 0,4664(8)
.L52:
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_GunnerWeapon
	b .L7
.L39:
	lis 29,gi@ha
	lis 3,.LC1@ha
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC3@ha
	lwz 0,16(29)
	lis 11,.LC5@ha
	la 9,.LC3@l(9)
	la 11,.LC5@l(11)
	lfs 1,0(9)
	mr 5,3
	li 4,0
	mtlr 0
	lis 9,.LC4@ha
	lfs 2,0(11)
	mr 3,31
	la 9,.LC4@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L36
.L40:
	li 0,0
	li 11,16
	stw 0,4664(8)
	lwz 9,84(31)
	stw 11,92(9)
	b .L36
.L42:
	li 0,0
	stw 0,4832(8)
	lwz 9,84(31)
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L36
	mr 3,31
	bl ChangeRightWeapon
	b .L36
.L44:
	cmpwi 0,25,-1
	bc 4,2,.L49
	lwz 9,92(8)
	addi 9,9,1
	stw 9,92(8)
.L36:
	cmpwi 0,25,-1
	bc 12,2,.L47
.L49:
	lwz 9,84(31)
	stw 25,92(9)
.L47:
	cmpwi 0,26,-1
	bc 12,2,.L7
	lwz 9,84(31)
	stw 26,4664(9)
.L7:
	lwz 0,132(1)
	mtlr 0
	lmw 25,100(1)
	la 1,128(1)
	blr
.Lfe1:
	.size	 Think_GunnerWeapon,.Lfe1-Think_GunnerWeapon
	.section	".rodata"
	.align 3
.LC6:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC7:
	.long 0x3f800000
	.align 2
.LC8:
	.long 0x0
	.section	".text"
	.align 2
	.globl GunnerWeaponFire
	.type	 GunnerWeaponFire,@function
GunnerWeaponFire:
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
	lis 11,.LC6@ha
	lwz 3,84(28)
	li 0,0
	addi 9,9,-8
	la 11,.LC6@l(11)
	stw 0,56(1)
	xoris 9,9,0x8000
	lfd 13,0(11)
	addi 5,1,56
	stw 9,84(1)
	lis 11,0x40e0
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
	li 9,500
	addi 4,1,8
	li 10,4
	mr 5,29
	li 6,3
	li 7,4
	li 8,300
	mr 3,28
	bl fire_bullet
	lis 29,gi@ha
	lis 3,.LC0@ha
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC7@ha
	lwz 0,16(29)
	lis 11,.LC7@ha
	la 9,.LC7@l(9)
	la 11,.LC7@l(11)
	lfs 1,0(9)
	mr 5,3
	li 4,1
	mtlr 0
	lis 9,.LC8@ha
	lfs 2,0(11)
	mr 3,28
	la 9,.LC8@l(9)
	lfs 3,0(9)
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
.Lfe2:
	.size	 GunnerWeaponFire,.Lfe2-GunnerWeaponFire
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
