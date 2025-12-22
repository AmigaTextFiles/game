	.file	"z_infweapon.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC1:
	.string	"infantry/infatck1.wav"
	.align 3
.LC0:
	.long 0x400921fb
	.long 0x54442d18
	.align 3
.LC2:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC3:
	.long 0x40180000
	.long 0x0
	.align 3
.LC4:
	.long 0x0
	.long 0x0
	.align 3
.LC5:
	.long 0xc0100000
	.long 0x0
	.align 3
.LC6:
	.long 0x40100000
	.long 0x0
	.align 2
.LC7:
	.long 0x3f800000
	.align 2
.LC8:
	.long 0x0
	.section	".text"
	.align 2
	.globl InfWeaponFire
	.type	 InfWeaponFire,@function
InfWeaponFire:
	stwu 1,-128(1)
	mflr 0
	stfd 29,104(1)
	stfd 30,112(1)
	stfd 31,120(1)
	stmw 29,92(1)
	stw 0,132(1)
	mr 31,3
	addi 29,1,24
	lwz 3,84(31)
	addi 30,1,40
	mr 4,29
	mr 5,30
	li 6,0
	addi 3,3,4732
	bl AngleVectors
	lwz 11,84(31)
	lwz 9,4784(11)
	addi 9,9,1
	stw 9,4784(11)
	lwz 9,84(31)
	lwz 0,4784(9)
	cmpwi 0,0,6
	bc 4,1,.L7
	li 0,1
	stw 0,4784(9)
.L7:
	lwz 9,508(31)
	lis 7,0x4330
	lis 11,.LC2@ha
	lwz 6,84(31)
	li 0,0
	addi 9,9,-8
	la 11,.LC2@l(11)
	stw 0,56(1)
	xoris 9,9,0x8000
	lfd 11,0(11)
	mr 8,10
	stw 9,84(1)
	lis 11,0x40e0
	stw 7,80(1)
	lis 9,.LC3@ha
	lfd 0,80(1)
	la 9,.LC3@l(9)
	stw 11,60(1)
	lis 11,.LC0@ha
	lfd 12,0(9)
	fsub 0,0,11
	lfd 13,.LC0@l(11)
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfd 29,0(9)
	frsp 0,0
	stfs 0,64(1)
	lwz 0,4784(6)
	add 0,0,0
	xoris 0,0,0x8000
	stw 0,84(1)
	stw 7,80(1)
	lfd 0,80(1)
	fsub 0,0,11
	fmul 0,0,13
	fdiv 0,0,12
	frsp 0,0
	fmr 30,0
	fmr 1,30
	bl sin
	lis 9,.LC5@ha
	lfs 31,64(1)
	la 9,.LC5@l(9)
	lfd 13,0(9)
	fmadd 0,1,13,29
	fmr 1,30
	frsp 0,0
	stfs 0,56(1)
	bl cos
	lis 9,.LC6@ha
	lwz 3,84(31)
	addi 5,1,56
	la 9,.LC6@l(9)
	addi 8,1,8
	lfd 0,0(9)
	mr 6,29
	mr 7,30
	addi 4,31,4
	fmadd 1,1,0,31
	frsp 1,1
	stfs 1,64(1)
	bl P_ProjectSource
	li 9,500
	addi 4,1,8
	li 10,4
	mr 5,29
	li 6,3
	li 7,4
	li 8,300
	mr 3,31
	bl fire_bullet
	lis 29,gi@ha
	lis 3,.LC1@ha
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC7@ha
	lwz 0,16(29)
	lis 11,.LC8@ha
	la 9,.LC7@l(9)
	la 11,.LC8@l(11)
	lfs 2,0(9)
	mr 5,3
	li 4,1
	mtlr 0
	lis 9,.LC7@ha
	lfs 3,0(11)
	mr 3,31
	la 9,.LC7@l(9)
	lfs 1,0(9)
	blrl
	mr 3,31
	addi 4,1,8
	li 5,1
	bl PlayerNoise
	lwz 11,84(31)
	lwz 9,1820(11)
	addi 9,9,-1
	stw 9,1820(11)
	lwz 0,132(1)
	mtlr 0
	lmw 29,92(1)
	lfd 29,104(1)
	lfd 30,112(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe1:
	.size	 InfWeaponFire,.Lfe1-InfWeaponFire
	.section	".rodata"
	.align 2
.LC9:
	.long 0x46fffe00
	.align 3
.LC10:
	.long 0x3fe99999
	.long 0x9999999a
	.align 2
.LC11:
	.long 0x41000000
	.align 3
.LC12:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC13:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Think_InfWeapon
	.type	 Think_InfWeapon,@function
Think_InfWeapon:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	li 29,-1
	lwz 10,84(31)
	li 30,-1
	lwz 9,4664(10)
	lwz 8,4620(10)
	lwz 0,4612(10)
	cmpwi 0,9,1
	lwz 7,1820(10)
	or 0,8,0
	rlwinm 6,0,0,30,30
	rlwinm 11,0,0,31,31
	bc 12,2,.L21
	cmplwi 0,9,1
	bc 12,0,.L10
	cmpwi 0,9,7
	bc 12,2,.L27
	b .L9
.L10:
	lwz 0,4900(10)
	cmpwi 0,0,-1
	bc 12,1,.L56
	lwz 0,4904(10)
	cmpwi 0,0,-1
	bc 4,1,.L13
	li 0,6
	mr 3,31
	stw 0,92(10)
	bl ChangeLeftWeapon
	b .L8
.L13:
	srawi 0,7,31
	subf 0,7,0
	srwi 9,0,31
	and. 0,11,9
	bc 12,2,.L15
	rlwinm 0,8,0,0,30
	b .L57
.L15:
	neg 0,6
	srwi 0,0,31
	and. 11,0,9
	bc 12,2,.L17
	rlwinm 0,8,0,31,29
.L57:
	li 11,4
	stw 0,4620(10)
	li 29,7
	lwz 9,84(31)
	stw 11,92(9)
	b .L9
.L17:
	lis 9,level+4@ha
	lfs 13,992(31)
	lis 10,.LC11@ha
	lfs 0,level+4@l(9)
	la 10,.LC11@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L19
	li 30,7
	li 29,1
	b .L9
.L19:
	li 30,6
	b .L9
.L21:
	lwz 0,4900(10)
	cmpwi 0,0,-1
	bc 4,1,.L22
.L56:
	li 30,16
	li 29,4
	b .L9
.L22:
	lwz 0,4904(10)
	cmpwi 0,0,-1
	bc 4,1,.L24
	mr 3,31
	bl ChangeLeftWeapon
	b .L8
.L24:
	neg 0,6
	srwi 0,0,31
	or. 9,11,0
	bc 12,2,.L9
	li 0,0
	li 11,6
	stw 0,4664(10)
	b .L58
.L27:
	cmpwi 0,11,0
	bc 12,2,.L29
	lwz 0,92(10)
	cmpwi 0,0,6
	bc 4,2,.L9
.L29:
	addi 0,7,-1
	li 9,6
	or 0,7,0
	stw 9,92(10)
	srwi 0,0,31
	and. 0,0,11
	bc 4,2,.L8
	lwz 9,84(31)
	lis 11,level+4@ha
	mr 3,31
	stw 0,4664(9)
	lfs 0,level+4@l(11)
	stfs 0,992(31)
	bl Think_InfWeapon
	b .L8
.L9:
	lwz 11,84(31)
	lwz 9,92(11)
	mr 8,11
	addi 9,9,-3
	cmplwi 0,9,16
	bc 12,1,.L50
	lis 11,.L52@ha
	slwi 10,9,2
	la 11,.L52@l(11)
	lis 9,.L52@ha
	lwzx 0,10,11
	la 9,.L52@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L52:
	.long .L34-.L52
	.long .L35-.L52
	.long .L38-.L52
	.long .L33-.L52
	.long .L50-.L52
	.long .L50-.L52
	.long .L50-.L52
	.long .L43-.L52
	.long .L50-.L52
	.long .L50-.L52
	.long .L50-.L52
	.long .L43-.L52
	.long .L45-.L52
	.long .L50-.L52
	.long .L50-.L52
	.long .L50-.L52
	.long .L48-.L52
.L34:
	li 0,0
	li 11,6
	stw 0,4664(8)
.L58:
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_InfWeapon
	b .L8
.L35:
	cmpwi 0,7,0
	bc 4,1,.L39
	mr 3,31
	bl InfWeaponFire
	lwz 9,84(31)
	li 0,5
	stw 0,92(9)
	b .L33
.L38:
	cmpwi 0,7,0
	bc 4,1,.L39
	mr 3,31
	bl InfWeaponFire
	lwz 9,84(31)
	li 0,4
	stw 0,92(9)
	b .L33
.L39:
	li 0,6
	stw 0,92(8)
	b .L33
.L43:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC12@ha
	lis 11,.LC10@ha
	la 10,.LC12@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC9@ha
	lfs 11,.LC9@l(10)
	lfd 12,.LC10@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 12,0,.L8
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L33
.L45:
	bl rand
	li 30,7
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC12@ha
	lis 11,.LC9@ha
	la 10,.LC12@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC13@ha
	lfs 12,.LC9@l(11)
	la 10,.LC13@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L33
	li 30,6
	li 29,0
	b .L33
.L48:
	li 0,0
	stw 0,4832(8)
	lwz 9,84(31)
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L33
	mr 3,31
	bl ChangeRightWeapon
	b .L33
.L50:
	cmpwi 0,30,-1
	bc 4,2,.L55
	lwz 9,92(8)
	addi 9,9,1
	stw 9,92(8)
.L33:
	cmpwi 0,30,-1
	bc 12,2,.L53
.L55:
	lwz 9,84(31)
	stw 30,92(9)
.L53:
	cmpwi 0,29,-1
	bc 12,2,.L8
	lwz 9,84(31)
	stw 29,4664(9)
.L8:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Think_InfWeapon,.Lfe2-Think_InfWeapon
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
