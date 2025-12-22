	.file	"z_pistol.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC0:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl FirePistol
	.type	 FirePistol,@function
FirePistol:
	stwu 1,-112(1)
	mflr 0
	stmw 27,92(1)
	stw 0,116(1)
	cmpwi 0,4,0
	mr 31,3
	bc 12,2,.L7
	lwz 9,508(31)
	lis 8,0x4330
	lis 10,.LC0@ha
	lwz 7,84(31)
	li 0,0
	addi 9,9,-2
	la 10,.LC0@l(10)
	stw 0,40(1)
	xoris 9,9,0x8000
	lfd 13,0(10)
	stw 9,84(1)
	lis 10,0xc000
	stw 8,80(1)
	lfd 0,80(1)
	stw 10,44(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,48(1)
	lwz 9,1836(7)
	addi 9,9,-1
	stw 9,1836(7)
	b .L8
.L7:
	lwz 9,508(31)
	lis 8,0x4330
	lis 10,.LC0@ha
	lwz 7,84(31)
	li 0,0
	addi 9,9,-2
	la 10,.LC0@l(10)
	stw 0,40(1)
	xoris 9,9,0x8000
	lfd 13,0(10)
	stw 9,84(1)
	lis 10,0x4000
	stw 8,80(1)
	lfd 0,80(1)
	stw 10,44(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,48(1)
	lwz 9,1820(7)
	addi 9,9,-1
	stw 9,1820(7)
.L8:
	lwz 3,84(31)
	addi 29,1,24
	addi 4,1,8
	mr 5,29
	li 6,0
	addi 3,3,4732
	addi 27,31,4
	bl AngleVectors
	addi 28,1,56
	lwz 3,84(31)
	addi 5,1,40
	addi 6,1,8
	mr 7,29
	mr 4,27
	mr 8,28
	bl P_ProjectSource
	lwz 11,84(31)
	li 9,100
	mr 4,28
	addi 5,1,8
	li 6,15
	lwz 10,1832(11)
	li 7,30
	li 8,100
	mr 3,31
	xori 10,10,2
	addic 10,10,-1
	subfe 10,10,10
	andi. 10,10,35
	ori 10,10,34
	bl fire_bullet
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
	li 3,0
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	lwz 0,116(1)
	mtlr 0
	lmw 27,92(1)
	la 1,112(1)
	blr
.Lfe1:
	.size	 FirePistol,.Lfe1-FirePistol
	.section	".rodata"
	.align 2
.LC2:
	.string	"weapons/pistol_clipout.wav"
	.align 2
.LC3:
	.string	"weapons/pistol_clipin.wav"
	.align 2
.LC1:
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
	.align 2
.LC7:
	.long 0x3f800000
	.align 2
.LC8:
	.long 0x0
	.section	".text"
	.align 2
	.globl Think_Pistol
	.type	 Think_Pistol,@function
Think_Pistol:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 31,3
	li 28,-1
	lwz 9,84(31)
	li 30,-1
	lwz 10,4664(9)
	lwz 0,4620(9)
	lwz 11,4612(9)
	cmplwi 0,10,10
	lwz 29,1820(9)
	or 0,0,11
	lha 7,136(9)
	rlwinm 27,0,0,30,30
	rlwinm 8,0,0,31,31
	bc 12,1,.L12
	lis 11,.L43@ha
	slwi 10,10,2
	la 11,.L43@l(11)
	lis 9,.L43@ha
	lwzx 0,10,11
	la 9,.L43@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L43:
	.long .L13-.L43
	.long .L28-.L43
	.long .L12-.L43
	.long .L12-.L43
	.long .L12-.L43
	.long .L12-.L43
	.long .L12-.L43
	.long .L35-.L43
	.long .L39-.L43
	.long .L34-.L43
	.long .L12-.L43
.L13:
	lwz 11,84(31)
	lwz 0,4900(11)
	cmpwi 0,0,-1
	bc 12,1,.L67
	lwz 0,4904(11)
	cmpwi 0,0,-1
	bc 4,1,.L16
	li 0,8
	mr 3,31
	stw 0,92(11)
	bl ChangeLeftWeapon
	b .L11
.L16:
	cmpwi 0,8,0
	bc 12,2,.L18
	lwz 0,4620(11)
	cmpwi 0,29,0
	rlwinm 0,0,0,0,30
	stw 0,4620(11)
	bc 12,1,.L19
	mr 3,31
	bl CanRightReload
	cmpwi 0,3,0
	bc 4,2,.L34
	b .L26
.L19:
	lwz 9,84(31)
	li 0,5
	li 28,7
	mr 3,31
	li 4,0
	stw 0,92(9)
	bl FirePistol
	b .L12
.L18:
	srawi 0,7,31
	neg 9,27
	subf 0,7,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L24
	lwz 0,4620(11)
	li 30,75
	li 28,8
	rlwinm 0,0,0,31,29
	stw 0,4620(11)
	b .L12
.L24:
	lis 9,level+4@ha
	lfs 13,992(31)
	lis 11,.LC4@ha
	lfs 0,level+4@l(9)
	la 11,.LC4@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L26
	li 30,9
	li 28,1
	b .L12
.L26:
	li 30,8
	b .L12
.L28:
	lwz 9,84(31)
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L29
.L67:
	li 30,58
	li 28,4
	b .L12
.L29:
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L31
	mr 3,31
	bl ChangeLeftWeapon
	b .L11
.L31:
	neg 0,27
	srwi 0,0,31
	or. 10,8,0
	bc 12,2,.L12
	li 0,0
	li 11,8
	stw 0,4664(9)
	b .L68
.L34:
	li 30,62
	li 28,10
	b .L12
.L35:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,8
	bc 4,2,.L36
	li 0,9
	stw 0,92(9)
	b .L11
.L36:
	cmpwi 0,0,10
	bc 4,2,.L12
	addi 0,29,-1
	or 0,29,0
	srwi 0,0,31
	and. 0,0,8
	bc 4,2,.L11
	stw 0,4664(9)
	mr 3,31
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,992(31)
	bl Think_Pistol
	b .L11
.L39:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,82
	bc 4,1,.L12
	li 0,8
	li 28,0
	stw 0,92(9)
.L12:
	lwz 11,84(31)
	lwz 9,92(11)
	mr 8,11
	addi 9,9,-4
	cmplwi 0,9,75
	bc 12,1,.L61
	lis 11,.L63@ha
	slwi 10,9,2
	la 11,.L63@l(11)
	lis 9,.L63@ha
	lwzx 0,10,11
	la 9,.L63@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L63:
	.long .L45-.L63
	.long .L61-.L63
	.long .L47-.L63
	.long .L47-.L63
	.long .L44-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L50-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L53-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L55-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L56-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L57-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L61-.L63
	.long .L58-.L63
	.long .L60-.L63
.L45:
	li 0,0
	li 11,8
	stw 0,4664(8)
.L68:
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_Pistol
	b .L11
.L47:
	cmpwi 0,29,0
	bc 4,1,.L69
	mr 3,31
	li 4,0
	bl FirePistol
	b .L69
.L50:
	bl rand
	li 30,9
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC5@ha
	lis 11,.LC1@ha
	la 10,.LC5@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC6@ha
	lfs 12,.LC1@l(11)
	la 10,.LC6@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L44
	li 30,8
	li 28,0
	b .L44
.L53:
	lwz 0,4900(8)
	cmpwi 0,0,-1
	bc 4,1,.L44
	mr 3,31
	bl ChangeRightWeapon
	b .L44
.L55:
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC7@ha
	lis 10,.LC7@ha
	lis 11,.LC8@ha
	mr 5,3
	la 11,.LC8@l(11)
	la 9,.LC7@l(9)
	mtlr 0
	la 10,.LC7@l(10)
	lfs 1,0(9)
	li 4,0
	lfs 3,0(11)
	mr 3,31
	lfs 2,0(10)
	blrl
	lwz 9,84(31)
	mr 3,31
	lwz 5,1820(9)
	lwz 4,1828(9)
	bl DropClip
	lwz 9,84(31)
	li 0,0
	stw 0,1820(9)
	b .L69
.L56:
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC7@ha
	lis 10,.LC7@ha
	lis 11,.LC8@ha
	la 9,.LC7@l(9)
	la 11,.LC8@l(11)
	mr 5,3
	lfs 1,0(9)
	mtlr 0
	la 10,.LC7@l(10)
	lfs 3,0(11)
	li 4,0
	mr 3,31
	lfs 2,0(10)
	blrl
	mr 3,31
	li 4,0
	bl ReloadHand
	b .L69
.L57:
	li 28,0
	li 30,13
	b .L44
.L58:
	cmpwi 0,27,0
	bc 4,2,.L11
	b .L70
.L60:
	mr 3,31
	bl ThrowOffHandGrenade
.L69:
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L44
.L61:
	cmpwi 0,30,-1
	bc 4,2,.L66
.L70:
	lwz 9,92(8)
	addi 9,9,1
	stw 9,92(8)
.L44:
	cmpwi 0,30,-1
	bc 12,2,.L64
.L66:
	lwz 9,84(31)
	stw 30,92(9)
.L64:
	cmpwi 0,28,-1
	bc 12,2,.L11
	lwz 9,84(31)
	stw 28,4664(9)
.L11:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Think_Pistol,.Lfe2-Think_Pistol
	.section	".rodata"
	.align 2
.LC9:
	.long 0x46fffe00
	.align 2
.LC10:
	.long 0x41000000
	.align 3
.LC11:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC12:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC13:
	.long 0x3f800000
	.align 2
.LC14:
	.long 0x0
	.section	".text"
	.align 2
	.globl Think_TwinPistol
	.type	 Think_TwinPistol,@function
Think_TwinPistol:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr 31,3
	li 25,-1
	lwz 9,84(31)
	li 26,-1
	lwz 10,4664(9)
	lwz 0,4620(9)
	lwz 11,4612(9)
	cmplwi 0,10,11
	lwz 29,1820(9)
	or 0,0,11
	lwz 30,1836(9)
	rlwinm 27,0,0,30,30
	rlwinm 28,0,0,31,31
	bc 12,1,.L72
	lis 11,.L115@ha
	slwi 10,10,2
	la 11,.L115@l(11)
	lis 9,.L115@ha
	lwzx 0,10,11
	la 9,.L115@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L115:
	.long .L73-.L115
	.long .L95-.L115
	.long .L72-.L115
	.long .L72-.L115
	.long .L72-.L115
	.long .L72-.L115
	.long .L101-.L115
	.long .L103-.L115
	.long .L108-.L115
	.long .L94-.L115
	.long .L72-.L115
	.long .L72-.L115
.L73:
	lwz 11,84(31)
	lwz 0,4900(11)
	cmpwi 0,0,-1
	bc 4,1,.L74
	li 0,10
	mr 3,31
	stw 0,92(11)
	bl ChangeRightWeapon
	b .L71
.L74:
	lwz 0,4904(11)
	cmpwi 0,0,-1
	bc 12,1,.L148
	neg 0,27
	srwi 0,0,31
	and. 8,28,0
	bc 12,2,.L78
	srawi 9,30,31
	srawi 0,29,31
	subf 9,30,9
	subf 0,29,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L78
	li 0,75
	mr 3,31
	li 4,1
	stw 0,92(11)
	li 25,6
	bl FirePistol
	mr 3,31
	li 4,0
	bl FirePistol
	b .L72
.L78:
	cmpwi 0,28,0
	bc 12,2,.L80
	lwz 9,84(31)
	cmpwi 0,29,0
	lwz 0,4620(9)
	rlwinm 0,0,0,0,30
	stw 0,4620(9)
	bc 12,1,.L81
	mr 3,31
	bl CanRightReload
	cmpwi 0,3,0
	bc 4,2,.L94
	b .L92
.L81:
	lwz 9,84(31)
	li 0,7
	li 25,7
	mr 3,31
	li 4,0
	b .L149
.L80:
	cmpwi 0,27,0
	bc 12,2,.L86
	lwz 9,84(31)
	cmpwi 0,30,0
	lwz 0,4620(9)
	rlwinm 0,0,0,31,29
	stw 0,4620(9)
	bc 12,1,.L87
	mr 3,31
	bl CanLeftReload
	cmpwi 0,3,0
	bc 12,2,.L92
	li 26,59
	li 25,11
	b .L72
.L87:
	lwz 9,84(31)
	li 0,53
	li 25,8
	mr 3,31
	li 4,1
.L149:
	stw 0,92(9)
	bl FirePistol
	b .L72
.L86:
	lis 9,level+4@ha
	lfs 13,992(31)
	lis 8,.LC10@ha
	lfs 0,level+4@l(9)
	la 8,.LC10@l(8)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L92
	li 26,11
	li 25,1
	b .L72
.L92:
	li 26,10
	b .L72
.L94:
	li 26,37
	li 25,10
	b .L72
.L95:
	lwz 9,84(31)
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L96
	li 0,10
	mr 3,31
	stw 0,92(9)
	bl ChangeRightWeapon
	b .L71
.L96:
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L98
.L148:
	li 26,30
	li 25,5
	b .L72
.L98:
	neg 0,27
	srwi 0,0,31
	or. 8,28,0
	bc 12,2,.L72
	li 0,0
	li 11,10
	stw 0,4664(9)
	b .L150
.L101:
	lwz 11,84(31)
	lwz 0,92(11)
	cmpwi 0,0,79
	bc 4,2,.L72
	b .L111
.L103:
	lwz 10,84(31)
	lwz 9,92(10)
	cmpwi 0,9,10
	bc 4,2,.L104
	li 0,11
	stw 0,92(10)
	b .L71
.L104:
	neg 0,27
	xori 9,9,11
	subfic 8,9,0
	adde 9,8,9
	srwi 0,0,31
	and. 11,9,0
	bc 12,2,.L105
	cmpwi 0,30,0
	bc 4,1,.L105
	lwz 0,4620(10)
	li 11,53
	li 25,8
	mr 3,31
	li 4,1
	rlwinm 0,0,0,31,29
	stw 0,4620(10)
	lwz 9,84(31)
	stw 11,92(9)
	bl FirePistol
.L105:
	lwz 11,84(31)
	lwz 0,92(11)
	cmpwi 0,0,12
	bc 4,2,.L72
	addi 0,29,-1
	or 0,29,0
	srwi 0,0,31
	and. 8,0,28
	bc 12,2,.L111
	cmpwi 0,27,0
	b .L153
.L108:
	lwz 9,84(31)
	lwz 0,92(9)
	xori 0,0,57
	subfic 8,0,0
	adde 0,8,0
	and. 10,0,28
	bc 12,2,.L109
	cmpwi 0,29,0
	bc 4,1,.L109
	lwz 0,4620(9)
	li 11,7
	li 25,7
	mr 3,31
	li 4,0
	rlwinm 0,0,0,0,30
	stw 0,4620(9)
	lwz 9,84(31)
	stw 11,92(9)
	bl FirePistol
.L109:
	lwz 11,84(31)
	lwz 0,92(11)
	cmpwi 0,0,58
	bc 4,2,.L72
	addi 0,30,-1
	neg 9,27
	or 0,30,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,0,9
	bc 12,2,.L111
	cmpwi 0,28,0
.L153:
	bc 12,2,.L71
.L111:
	li 0,0
	lis 9,level+4@ha
	stw 0,4664(11)
	mr 3,31
	lfs 0,level+4@l(9)
	stfs 0,992(31)
	bl Think_TwinPistol
	b .L71
.L72:
	lwz 11,84(31)
	lwz 9,92(11)
	mr 8,11
	addi 9,9,-6
	cmplwi 0,9,73
	bc 12,1,.L142
	lis 11,.L144@ha
	slwi 10,9,2
	la 11,.L144@l(11)
	lis 9,.L144@ha
	lwzx 0,10,11
	la 9,.L144@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L144:
	.long .L117-.L144
	.long .L142-.L144
	.long .L119-.L144
	.long .L119-.L144
	.long .L116-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L129-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L132-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L133-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L134-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L138-.L144
	.long .L142-.L144
	.long .L122-.L144
	.long .L122-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L135-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L136-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L142-.L144
	.long .L138-.L144
	.long .L142-.L144
	.long .L125-.L144
	.long .L125-.L144
	.long .L142-.L144
	.long .L139-.L144
.L117:
	li 0,0
	li 11,10
	stw 0,4664(8)
.L150:
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_TwinPistol
	b .L71
.L119:
	cmpwi 0,29,0
	bc 4,1,.L151
	mr 3,31
	li 4,0
	bl FirePistol
	b .L151
.L122:
	cmpwi 0,30,0
	bc 4,1,.L151
	mr 3,31
	li 4,1
	bl FirePistol
	b .L151
.L125:
	cmpwi 0,29,0
	bc 4,1,.L126
	mr 3,31
	li 4,0
	bl FirePistol
.L126:
	cmpwi 0,30,0
	bc 4,1,.L151
	mr 3,31
	li 4,1
	bl FirePistol
	b .L151
.L129:
	bl rand
	li 26,11
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 8,.LC11@ha
	lis 11,.LC9@ha
	la 8,.LC11@l(8)
	stw 0,24(1)
	lis 10,.LC12@ha
	lfd 13,0(8)
	la 10,.LC12@l(10)
	lfd 0,24(1)
	lfs 12,.LC9@l(11)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L116
	li 26,10
	li 25,0
	b .L116
.L132:
	mr 3,31
	bl ChangeLeftWeapon
	b .L116
.L133:
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC13@ha
	lis 9,.LC13@ha
	lis 10,.LC14@ha
	mr 5,3
	la 8,.LC13@l(8)
	la 9,.LC13@l(9)
	mtlr 0
	la 10,.LC14@l(10)
	lfs 2,0(9)
	li 4,0
	mr 3,31
	lfs 1,0(8)
	lfs 3,0(10)
	blrl
	lwz 9,84(31)
	mr 3,31
	lwz 5,1820(9)
	lwz 4,1828(9)
	bl DropClip
	lwz 9,84(31)
	li 0,0
	stw 0,1820(9)
	b .L151
.L134:
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC13@ha
	lis 9,.LC13@ha
	lis 10,.LC14@ha
	la 9,.LC13@l(9)
	mr 5,3
	la 8,.LC13@l(8)
	lfs 2,0(9)
	mtlr 0
	la 10,.LC14@l(10)
	li 4,0
	lfs 1,0(8)
	mr 3,31
	lfs 3,0(10)
	blrl
	mr 3,31
	li 4,0
	b .L152
.L135:
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC13@ha
	lis 9,.LC13@ha
	lis 10,.LC14@ha
	mr 5,3
	la 8,.LC13@l(8)
	la 9,.LC13@l(9)
	mtlr 0
	la 10,.LC14@l(10)
	lfs 2,0(9)
	li 4,0
	mr 3,31
	lfs 1,0(8)
	lfs 3,0(10)
	blrl
	lwz 9,84(31)
	mr 3,31
	lwz 5,1836(9)
	lwz 4,1844(9)
	bl DropClip
	lwz 9,84(31)
	li 0,0
	stw 0,1836(9)
	b .L151
.L136:
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC13@ha
	lis 9,.LC13@ha
	lis 10,.LC14@ha
	la 9,.LC13@l(9)
	mr 5,3
	la 8,.LC13@l(8)
	lfs 2,0(9)
	mtlr 0
	la 10,.LC14@l(10)
	li 4,0
	lfs 1,0(8)
	mr 3,31
	lfs 3,0(10)
	blrl
	mr 3,31
	li 4,4
.L152:
	bl ReloadHand
.L151:
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L116
.L138:
	li 25,0
	li 26,12
	b .L116
.L139:
	li 9,10
	srawi 0,29,31
	stw 9,92(8)
	li 10,0
	subf 0,29,0
	lwz 11,84(31)
	lis 9,level+4@ha
	srwi 0,0,31
	and. 8,28,0
	stw 10,4664(11)
	lfs 0,level+4@l(9)
	stfs 0,992(31)
	bc 4,2,.L141
	srawi 0,30,31
	neg 9,27
	subf 0,30,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L116
.L141:
	mr 3,31
	bl Think_TwinPistol
	b .L71
.L142:
	cmpwi 0,26,-1
	bc 4,2,.L147
	lwz 9,92(8)
	addi 9,9,1
	stw 9,92(8)
.L116:
	cmpwi 0,26,-1
	bc 12,2,.L145
.L147:
	lwz 9,84(31)
	stw 26,92(9)
.L145:
	cmpwi 0,25,-1
	bc 12,2,.L71
	lwz 9,84(31)
	stw 25,4664(9)
.L71:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 Think_TwinPistol,.Lfe3-Think_TwinPistol
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
