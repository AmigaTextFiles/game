	.file	"z_sweapon.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"soldier/solatck2.wav"
	.align 2
.LC1:
	.string	"soldier/solatck1.wav"
	.align 2
.LC2:
	.string	"soldier/solatck3.wav"
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC4:
	.long 0x3f800000
	.align 2
.LC5:
	.long 0x0
	.section	".text"
	.align 2
	.globl StroggWeaponFire
	.type	 StroggWeaponFire,@function
StroggWeaponFire:
	stwu 1,-112(1)
	mflr 0
	stmw 29,100(1)
	stw 0,116(1)
	mr 31,3
	addi 30,1,32
	lwz 3,84(31)
	addi 29,1,48
	mr 4,30
	mr 5,29
	li 6,0
	addi 3,3,4732
	bl AngleVectors
	lwz 9,508(31)
	lis 8,0x4330
	lis 11,.LC3@ha
	lwz 3,84(31)
	lis 0,0x40e0
	addi 9,9,-8
	la 11,.LC3@l(11)
	stw 0,68(1)
	xoris 9,9,0x8000
	lfd 13,0(11)
	mr 7,29
	stw 9,92(1)
	li 11,0
	addi 4,31,4
	stw 8,88(1)
	addi 5,1,64
	mr 6,30
	lfd 0,88(1)
	addi 8,1,16
	stw 11,64(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,72(1)
	bl P_ProjectSource
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,16
	bc 12,2,.L9
	bc 12,1,.L13
	cmpwi 0,0,15
	bc 12,2,.L8
	b .L7
.L13:
	cmpwi 0,0,17
	bc 12,2,.L10
	b .L7
.L8:
	mr 5,30
	addi 4,1,16
	mr 3,31
	li 9,0
	li 6,5
	li 7,600
	li 8,8
	bl fire_blaster
	lis 29,gi@ha
	lis 3,.LC0@ha
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	b .L14
.L9:
	li 0,2
	mr 5,30
	stw 0,8(1)
	addi 4,1,16
	mr 3,31
	li 9,500
	li 6,2
	li 7,1
	li 8,1000
	li 10,12
	bl fire_shotgun
	lis 29,gi@ha
	lis 3,.LC1@ha
	la 29,gi@l(29)
	la 3,.LC1@l(3)
.L14:
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC4@ha
	lwz 0,16(29)
	lis 11,.LC4@ha
	la 9,.LC4@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC4@l(11)
	li 4,1
	mtlr 0
	lis 9,.LC5@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC5@l(9)
	lfs 3,0(9)
	blrl
	b .L7
.L10:
	mr 5,30
	addi 4,1,16
	mr 3,31
	li 9,500
	li 6,2
	li 7,4
	li 8,300
	li 10,4
	bl fire_bullet
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC4@ha
	lwz 0,16(29)
	lis 11,.LC4@ha
	la 9,.LC4@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC4@l(11)
	li 4,1
	mtlr 0
	lis 9,.LC5@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC5@l(9)
	lfs 3,0(9)
	blrl
.L7:
	mr 3,31
	addi 4,1,16
	li 5,1
	bl PlayerNoise
	lwz 11,84(31)
	lwz 9,1820(11)
	addi 9,9,-1
	stw 9,1820(11)
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe1:
	.size	 StroggWeaponFire,.Lfe1-StroggWeaponFire
	.section	".rodata"
	.align 2
.LC6:
	.long 0x46fffe00
	.align 3
.LC7:
	.long 0x3fe99999
	.long 0x9999999a
	.align 2
.LC8:
	.long 0x41000000
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC10:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Think_StroggSoldierWeapon
	.type	 Think_StroggSoldierWeapon,@function
Think_StroggSoldierWeapon:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	li 28,-1
	lwz 10,84(31)
	li 29,-1
	lwz 9,4664(10)
	lwz 8,4620(10)
	lwz 0,4612(10)
	cmpwi 0,9,1
	lwz 30,1820(10)
	or 0,8,0
	rlwinm 7,0,0,30,30
	rlwinm 11,0,0,31,31
	bc 12,2,.L32
	cmplwi 0,9,1
	bc 12,0,.L17
	cmpwi 0,9,7
	bc 12,2,.L38
	b .L16
.L17:
	lwz 0,4900(10)
	cmpwi 0,0,-1
	bc 12,1,.L76
	lwz 0,4904(10)
	cmpwi 0,0,-1
	bc 4,1,.L20
	li 0,9
	mr 3,31
	stw 0,92(10)
	bl ChangeLeftWeapon
	b .L15
.L20:
	srawi 0,30,31
	subf 0,30,0
	srwi 9,0,31
	and. 0,11,9
	bc 12,2,.L22
	rlwinm 0,8,0,0,30
	stw 0,4620(10)
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,17
	bc 4,2,.L79
	b .L27
.L22:
	neg 0,7
	srwi 0,0,31
	and. 11,0,9
	bc 12,2,.L26
	rlwinm 0,8,0,31,29
	stw 0,4620(10)
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,17
	bc 12,2,.L27
.L79:
	li 29,4
	mr 3,31
	bl StroggWeaponFire
	b .L28
.L27:
	li 0,4
	stw 0,92(9)
.L28:
	li 28,7
	b .L16
.L26:
	lis 9,level+4@ha
	lfs 13,992(31)
	lis 10,.LC8@ha
	lfs 0,level+4@l(9)
	la 10,.LC8@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L30
	li 29,10
	li 28,1
	b .L16
.L30:
	li 29,9
	b .L16
.L32:
	lwz 0,4900(10)
	cmpwi 0,0,-1
	bc 4,1,.L33
.L76:
	li 29,29
	li 28,4
	b .L16
.L33:
	lwz 0,4904(10)
	cmpwi 0,0,-1
	bc 4,1,.L35
	mr 3,31
	bl ChangeLeftWeapon
	b .L15
.L35:
	neg 0,7
	srwi 0,0,31
	or. 9,11,0
	bc 12,2,.L16
	li 0,0
	li 11,9
	stw 0,4664(10)
	b .L77
.L38:
	lwz 0,1816(10)
	cmpwi 0,0,17
	bc 4,2,.L16
	cmpwi 0,11,0
	bc 12,2,.L41
	lwz 0,92(10)
	cmpwi 0,0,9
	bc 4,2,.L16
.L41:
	addi 0,30,-1
	li 9,9
	or 0,30,0
	stw 9,92(10)
	srwi 0,0,31
	and. 0,0,11
	bc 4,2,.L15
	lwz 9,84(31)
	lis 11,level+4@ha
	mr 3,31
	stw 0,4664(9)
	lfs 0,level+4@l(11)
	stfs 0,992(31)
	bl Think_StroggSoldierWeapon
	b .L15
.L16:
	lwz 11,84(31)
	lwz 9,92(11)
	mr 8,11
	addi 9,9,-3
	cmplwi 0,9,29
	bc 12,1,.L70
	lis 11,.L72@ha
	slwi 10,9,2
	la 11,.L72@l(11)
	lis 9,.L72@ha
	lwzx 0,10,11
	la 9,.L72@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L72:
	.long .L46-.L72
	.long .L47-.L72
	.long .L52-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L55-.L72
	.long .L45-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L63-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L63-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L63-.L72
	.long .L70-.L72
	.long .L65-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L68-.L72
.L46:
	li 0,0
	li 11,9
	stw 0,4664(8)
.L77:
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_StroggSoldierWeapon
	b .L15
.L47:
	lwz 0,1816(8)
	cmpwi 0,0,17
	bc 4,2,.L78
	cmpwi 0,30,0
	bc 4,1,.L49
	mr 3,31
	bl StroggWeaponFire
	lwz 9,84(31)
	li 0,8
	stw 0,92(9)
	b .L45
.L49:
	li 0,9
	stw 0,92(8)
	b .L45
.L52:
	lwz 0,1816(8)
	cmpwi 0,0,15
	bc 4,2,.L78
	li 0,7
	stw 0,92(8)
	b .L45
.L55:
	lwz 0,1816(8)
	cmpwi 0,0,17
	bc 4,2,.L56
	cmpwi 0,30,0
	bc 4,1,.L57
	mr 3,31
	bl StroggWeaponFire
	lwz 9,84(31)
	li 0,4
	stw 0,92(9)
	b .L45
.L57:
.L56:
	li 0,9
	li 11,0
	stw 0,92(8)
	lwz 9,84(31)
	stw 11,4664(9)
	b .L45
.L63:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,12(1)
	lis 10,.LC9@ha
	lis 11,.LC7@ha
	la 10,.LC9@l(10)
	stw 0,8(1)
	lfd 13,0(10)
	lfd 0,8(1)
	lis 10,.LC6@ha
	lfs 11,.LC6@l(10)
	lfd 12,.LC7@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 12,0,.L15
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L45
.L65:
	bl rand
	li 29,10
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,12(1)
	lis 10,.LC9@ha
	lis 11,.LC6@ha
	la 10,.LC9@l(10)
	stw 0,8(1)
	lfd 13,0(10)
	lfd 0,8(1)
	lis 10,.LC10@ha
	lfs 12,.LC6@l(11)
	la 10,.LC10@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L45
	li 29,9
	li 28,0
	b .L45
.L68:
	li 0,0
	stw 0,4832(8)
	lwz 9,84(31)
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L45
	mr 3,31
	bl ChangeRightWeapon
	b .L45
.L70:
	cmpwi 0,29,-1
	bc 4,2,.L75
.L78:
	lwz 9,92(8)
	addi 9,9,1
	stw 9,92(8)
.L45:
	cmpwi 0,29,-1
	bc 12,2,.L73
.L75:
	lwz 9,84(31)
	stw 29,92(9)
.L73:
	cmpwi 0,28,-1
	bc 12,2,.L15
	lwz 9,84(31)
	stw 28,4664(9)
.L15:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Think_StroggSoldierWeapon,.Lfe2-Think_StroggSoldierWeapon
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
