	.file	"z_glauncher.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC0:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC1:
	.long 0xc0000000
	.align 2
.LC2:
	.long 0x40200000
	.align 2
.LC3:
	.long 0x43200000
	.section	".text"
	.align 2
	.globl GrenadelauncherFire
	.type	 GrenadelauncherFire,@function
GrenadelauncherFire:
	stwu 1,-112(1)
	mflr 0
	stmw 26,88(1)
	stw 0,116(1)
	mr 31,3
	lwz 9,508(31)
	lis 10,0x4330
	lis 8,.LC0@ha
	la 8,.LC0@l(8)
	lwz 3,84(31)
	addi 30,1,24
	addi 9,9,-8
	lfd 13,0(8)
	lis 0,0x4100
	xoris 9,9,0x8000
	addi 28,1,40
	stw 0,12(1)
	stw 9,84(1)
	mr 27,4
	addi 29,1,56
	stw 10,80(1)
	addi 3,3,4732
	mr 4,30
	lfd 0,80(1)
	mr 5,28
	li 6,0
	stw 0,8(1)
	mr 26,29
	fsub 0,0,13
	frsp 0,0
	stfs 0,16(1)
	bl AngleVectors
	lwz 3,84(31)
	addi 4,31,4
	mr 8,29
	mr 7,28
	addi 5,1,8
	mr 6,30
	bl P_ProjectSource
	lis 8,.LC1@ha
	lwz 4,84(31)
	mr 3,30
	la 8,.LC1@l(8)
	lfs 1,0(8)
	addi 4,4,4680
	bl VectorScale
	lwz 9,84(31)
	cmpwi 0,27,0
	lis 0,0xbf80
	stw 0,4668(9)
	bc 12,2,.L7
	lwz 9,84(31)
	mr 5,30
	mr 3,31
	mr 4,26
	li 6,120
	lwz 8,1828(9)
	li 7,900
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	lfs 1,0(9)
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 2,0(9)
	bl fire_cgrenade
	b .L8
.L7:
	lwz 9,84(31)
	mr 5,30
	mr 3,31
	mr 4,26
	li 6,120
	lwz 8,1828(9)
	li 7,900
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	lfs 1,0(9)
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 2,0(9)
	bl fire_grenade
.L8:
	mr 4,26
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
	li 3,8
	mtlr 9
	blrl
	lwz 0,88(29)
	li 4,2
	addi 3,31,4
	mtlr 0
	blrl
	li 4,0
	li 8,0
.L12:
	lwz 10,84(31)
	addi 9,10,1848
	lwz 11,1828(10)
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,2,.L11
	addi 10,10,1976
	lwzx 9,10,8
	addi 9,9,-1
	stwx 9,10,8
	lwz 11,84(31)
	addi 11,11,1976
	lwzx 0,11,8
	cmpwi 0,0,0
	bc 12,1,.L10
	mr 3,31
	bl RemoveItem
	b .L10
.L11:
	addi 4,4,1
	addi 8,8,4
	cmpwi 0,4,31
	bc 4,1,.L12
.L10:
	lwz 0,116(1)
	mtlr 0
	lmw 26,88(1)
	la 1,112(1)
	blr
.Lfe1:
	.size	 GrenadelauncherFire,.Lfe1-GrenadelauncherFire
	.section	".rodata"
	.align 2
.LC4:
	.string	"weapons/shotcock.wav"
	.align 2
.LC5:
	.long 0x46fffe00
	.align 2
.LC6:
	.long 0x41000000
	.align 2
.LC7:
	.long 0x3f800000
	.align 2
.LC8:
	.long 0x0
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
	.globl Think_GrenadeLauncher
	.type	 Think_GrenadeLauncher,@function
Think_GrenadeLauncher:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	li 30,-1
	lwz 10,84(31)
	li 29,-1
	lwz 9,4664(10)
	lwz 11,4620(10)
	lwz 0,4612(10)
	cmpwi 0,9,1
	lha 8,130(10)
	or 0,11,0
	rlwinm 6,0,0,30,30
	rlwinm 7,0,0,31,31
	bc 12,2,.L29
	cmplwi 0,9,1
	bc 12,0,.L18
	cmpwi 0,9,9
	bc 12,2,.L35
	cmpwi 0,9,10
	bc 12,2,.L36
	b .L17
.L18:
	lwz 0,4900(10)
	cmpwi 0,0,-1
	bc 12,1,.L56
	lwz 0,4904(10)
	cmpwi 0,0,-1
	bc 4,1,.L21
	li 0,18
	mr 3,31
	stw 0,92(10)
	bl ChangeLeftWeapon
	b .L16
.L21:
	srawi 0,8,31
	subf 0,8,0
	srwi 9,0,31
	and. 0,7,9
	bc 12,2,.L23
	rlwinm 0,11,0,0,30
	li 30,7
	stw 0,4620(10)
	li 11,7
	mr 3,31
	lwz 9,84(31)
	li 4,0
	b .L57
.L23:
	neg 0,6
	srwi 0,0,31
	and. 8,0,9
	bc 12,2,.L25
	rlwinm 0,11,0,31,29
	li 30,8
	stw 0,4620(10)
	li 11,7
	mr 3,31
	lwz 9,84(31)
	li 4,1
.L57:
	stw 11,92(9)
	bl GrenadelauncherFire
	b .L17
.L25:
	lis 9,level+4@ha
	lfs 13,992(31)
	lis 8,.LC6@ha
	lfs 0,level+4@l(9)
	la 8,.LC6@l(8)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L27
	li 29,19
	li 30,1
	b .L17
.L27:
	li 29,18
	b .L17
.L29:
	lwz 0,4900(10)
	cmpwi 0,0,-1
	bc 4,1,.L30
.L56:
	li 29,61
	li 30,4
	b .L17
.L30:
	lwz 0,4904(10)
	cmpwi 0,0,-1
	bc 4,1,.L32
	mr 3,31
	bl ChangeLeftWeapon
	b .L16
.L32:
	neg 0,6
	srwi 0,0,31
	or. 8,7,0
	bc 12,2,.L17
	b .L42
.L35:
	li 29,61
	li 30,10
	b .L17
.L36:
	lwz 0,92(10)
	cmpwi 0,0,65
	bc 4,2,.L17
	lis 29,gi@ha
	lis 3,.LC4@ha
	la 29,gi@l(29)
	la 3,.LC4@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC7@ha
	lis 9,.LC7@ha
	lis 10,.LC8@ha
	la 9,.LC7@l(9)
	la 10,.LC8@l(10)
	mr 5,3
	lfs 2,0(9)
	mtlr 0
	la 8,.LC7@l(8)
	lfs 3,0(10)
	li 4,0
	mr 3,31
	lfs 1,0(8)
	blrl
	lwz 9,84(31)
	li 10,0
	stw 10,1820(9)
	lwz 11,84(31)
	lwz 0,4908(11)
	stw 0,1828(11)
	lwz 9,84(31)
	stw 10,4908(9)
	lwz 11,84(31)
	stw 10,92(11)
	b .L16
.L17:
	lwz 9,84(31)
	lwz 0,92(9)
	mr 10,9
	cmpwi 0,0,18
	bc 12,2,.L40
	bc 12,1,.L52
	cmpwi 0,0,6
	bc 12,2,.L42
	cmpwi 0,0,17
	bc 12,2,.L42
	b .L49
.L52:
	cmpwi 0,0,60
	bc 12,2,.L44
	cmpwi 0,0,65
	bc 12,2,.L47
	b .L49
.L42:
	li 0,0
	li 11,18
	stw 0,4664(10)
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_GrenadeLauncher
	b .L16
.L44:
	bl rand
	li 29,19
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 8,.LC9@ha
	lis 11,.LC5@ha
	la 8,.LC9@l(8)
	stw 0,24(1)
	lis 10,.LC10@ha
	lfd 13,0(8)
	la 10,.LC10@l(10)
	lfd 0,24(1)
	lfs 12,.LC5@l(11)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L40
	li 29,18
	li 30,0
	b .L40
.L47:
	lwz 0,4900(10)
	cmpwi 0,0,-1
	bc 4,1,.L40
	mr 3,31
	bl ChangeRightWeapon
	b .L40
.L49:
	cmpwi 0,29,-1
	bc 4,2,.L55
	lwz 9,92(10)
	addi 9,9,1
	stw 9,92(10)
.L40:
	cmpwi 0,29,-1
	bc 12,2,.L53
.L55:
	lwz 9,84(31)
	stw 29,92(9)
.L53:
	cmpwi 0,30,-1
	bc 12,2,.L16
	lwz 9,84(31)
	stw 30,4664(9)
.L16:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Think_GrenadeLauncher,.Lfe2-Think_GrenadeLauncher
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
