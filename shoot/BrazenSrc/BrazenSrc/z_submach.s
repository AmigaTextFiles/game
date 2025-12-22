	.file	"z_submach.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC0:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl FireSubMach
	.type	 FireSubMach,@function
FireSubMach:
	stwu 1,-112(1)
	mflr 0
	stmw 26,88(1)
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
	lwz 11,84(31)
	lwz 0,1844(11)
	b .L15
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
	lwz 11,84(31)
	lwz 0,1828(11)
.L15:
	xori 30,0,35
	subfic 9,30,0
	adde 30,9,30
	lwz 3,84(31)
	addi 28,1,24
	addi 4,1,8
	mr 5,28
	li 6,0
	addi 3,3,4732
	addi 29,31,4
	bl AngleVectors
	mr 26,29
	addi 8,1,56
	lwz 3,84(31)
	mr 7,28
	mr 27,8
	mr 4,29
	addi 5,1,40
	addi 6,1,8
	bl P_ProjectSource
	cmpwi 0,30,1
	bc 4,2,.L11
	li 9,100
	mr 3,31
	mr 4,27
	addi 5,1,8
	li 6,30
	li 7,30
	li 8,100
	li 10,39
	bl fire_bullet
	lwz 9,84(31)
	stw 30,5188(9)
	b .L12
.L11:
	mr 3,31
	mr 4,27
	addi 5,1,8
	li 6,7
	li 7,30
	li 8,100
	li 9,100
	li 10,4
	bl fire_bullet
.L12:
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
	xori 3,30,1
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
	mr 4,27
	mr 3,31
	li 5,1
	bl PlayerNoise
	lwz 9,84(31)
	li 0,4
	stw 0,4792(9)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L13
	lwz 0,92(11)
	li 9,168
	rlwinm 0,0,0,31,31
	subfic 0,0,160
	b .L16
.L13:
	lwz 0,92(11)
	li 9,53
	rlwinm 0,0,0,31,31
	subfic 0,0,46
.L16:
	stw 0,56(31)
	stw 9,4788(11)
	lwz 0,116(1)
	mtlr 0
	lmw 26,88(1)
	la 1,112(1)
	blr
.Lfe1:
	.size	 FireSubMach,.Lfe1-FireSubMach
	.section	".rodata"
	.align 2
.LC2:
	.string	"weapons/sub_clipout.wav"
	.align 2
.LC3:
	.string	"weapons/sub_clipin.wav"
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
	.globl Think_SubMach
	.type	 Think_SubMach,@function
Think_SubMach:
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
	lha 8,136(9)
	rlwinm 27,0,0,30,30
	rlwinm 7,0,0,31,31
	bc 12,1,.L18
	lis 11,.L49@ha
	slwi 10,10,2
	la 11,.L49@l(11)
	lis 9,.L49@ha
	lwzx 0,10,11
	la 9,.L49@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L49:
	.long .L19-.L49
	.long .L34-.L49
	.long .L18-.L49
	.long .L18-.L49
	.long .L18-.L49
	.long .L18-.L49
	.long .L18-.L49
	.long .L41-.L49
	.long .L45-.L49
	.long .L40-.L49
	.long .L18-.L49
.L19:
	lwz 11,84(31)
	lwz 0,4900(11)
	cmpwi 0,0,-1
	bc 12,1,.L76
	lwz 0,4904(11)
	cmpwi 0,0,-1
	bc 4,1,.L22
	li 0,6
	mr 3,31
	stw 0,92(11)
	bl ChangeLeftWeapon
	b .L17
.L22:
	cmpwi 0,7,0
	bc 12,2,.L24
	lwz 0,4620(11)
	cmpwi 0,29,0
	rlwinm 0,0,0,0,30
	stw 0,4620(11)
	bc 12,1,.L25
	mr 3,31
	bl CanRightReload
	cmpwi 0,3,0
	bc 4,2,.L40
	b .L32
.L25:
	lwz 9,84(31)
	li 0,5
	li 28,7
	b .L77
.L24:
	srawi 0,8,31
	neg 9,27
	subf 0,8,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L30
	lwz 0,4620(11)
	li 30,102
	li 28,8
	rlwinm 0,0,0,31,29
	stw 0,4620(11)
	b .L18
.L30:
	lis 9,level+4@ha
	lfs 13,992(31)
	lis 11,.LC4@ha
	lfs 0,level+4@l(9)
	la 11,.LC4@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L32
	li 30,7
	li 28,1
	b .L18
.L32:
	li 30,6
	b .L18
.L34:
	lwz 9,84(31)
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L35
.L76:
	li 30,86
	li 28,4
	b .L18
.L35:
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L37
	mr 3,31
	bl ChangeLeftWeapon
	b .L17
.L37:
	neg 0,27
	srwi 0,0,31
	or. 10,7,0
	bc 12,2,.L18
	li 0,0
	li 11,6
	stw 0,4664(9)
	b .L78
.L40:
	li 30,90
	li 28,10
	b .L18
.L41:
	cmpwi 0,7,0
	lwz 8,84(31)
	bc 12,2,.L43
	lwz 0,92(8)
	cmpwi 0,0,6
	bc 4,2,.L18
.L43:
	addi 0,29,-1
	li 9,6
	or 0,29,0
	stw 9,92(8)
	srwi 0,0,31
	and. 0,0,7
	bc 4,2,.L17
	lwz 9,84(31)
	lis 11,level+4@ha
	mr 3,31
	stw 0,4664(9)
	lfs 0,level+4@l(11)
	stfs 0,992(31)
	bl Think_SubMach
	b .L17
.L45:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,110
	bc 4,1,.L18
	li 0,8
	li 28,0
.L77:
	stw 0,92(9)
.L18:
	lwz 9,84(31)
	lwz 11,92(9)
	mr 8,9
	addi 10,11,-3
	cmplwi 0,10,103
	bc 12,1,.L70
	lis 11,.L72@ha
	slwi 10,10,2
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
	.long .L51-.L72
	.long .L52-.L72
	.long .L55-.L72
	.long .L50-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L59-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L62-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L64-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L65-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L66-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L70-.L72
	.long .L67-.L72
	.long .L69-.L72
.L51:
	li 0,0
	li 11,6
	stw 0,4664(8)
.L78:
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_SubMach
	b .L17
.L52:
	cmpwi 0,29,0
	bc 4,1,.L56
	mr 3,31
	li 4,0
	bl FireSubMach
	lwz 9,84(31)
	li 0,5
	stw 0,92(9)
	b .L50
.L55:
	cmpwi 0,29,0
	bc 4,1,.L56
	mr 3,31
	li 4,0
	bl FireSubMach
	lwz 9,84(31)
	li 0,4
	stw 0,92(9)
	b .L50
.L56:
	li 0,6
	stw 0,92(8)
	b .L50
.L59:
	bl rand
	li 30,7
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
	bc 12,0,.L50
	li 30,6
	li 28,0
	b .L50
.L62:
	lwz 0,4900(8)
	cmpwi 0,0,-1
	bc 4,1,.L50
	mr 3,31
	bl ChangeRightWeapon
	b .L50
.L64:
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
	b .L79
.L65:
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
	b .L79
.L66:
	li 28,0
	li 30,6
	b .L50
.L67:
	cmpwi 0,27,0
	bc 4,2,.L17
	b .L80
.L69:
	mr 3,31
	bl ThrowOffHandGrenade
.L79:
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L50
.L70:
	cmpwi 0,30,-1
	bc 4,2,.L75
.L80:
	lwz 9,92(8)
	addi 9,9,1
	stw 9,92(8)
.L50:
	cmpwi 0,30,-1
	bc 12,2,.L73
.L75:
	lwz 9,84(31)
	stw 30,92(9)
.L73:
	cmpwi 0,28,-1
	bc 12,2,.L17
	lwz 9,84(31)
	stw 28,4664(9)
.L17:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Think_SubMach,.Lfe2-Think_SubMach
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
	.globl Think_TwinSubMach
	.type	 Think_TwinSubMach,@function
Think_TwinSubMach:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr 31,3
	li 26,-1
	lwz 10,84(31)
	li 25,-1
	lwz 9,4664(10)
	lwz 11,4620(10)
	lwz 0,4612(10)
	cmpwi 0,9,1
	lwz 29,1820(10)
	or 0,11,0
	lwz 30,1836(10)
	rlwinm 27,0,0,30,30
	rlwinm 28,0,0,31,31
	bc 12,2,.L109
	cmplwi 0,9,1
	bc 12,0,.L83
	cmpwi 0,9,7
	bc 12,2,.L115
	cmpwi 0,9,9
	bc 12,2,.L108
	b .L82
.L83:
	lwz 0,4900(10)
	cmpwi 0,0,-1
	bc 12,1,.L171
	lwz 0,4904(10)
	cmpwi 0,0,-1
	bc 12,1,.L172
	cmpwi 0,28,0
	bc 12,2,.L88
	cmpwi 0,29,0
	rlwinm 0,11,0,0,30
	stw 0,4620(10)
	bc 12,1,.L89
	mr 3,31
	bl CanRightReload
	cmpwi 0,3,0
	bc 12,2,.L90
	li 25,53
	li 26,10
	b .L82
.L90:
	cmpwi 0,30,0
	bc 4,1,.L82
	b .L103
.L89:
	cmpwi 0,30,0
	bc 4,1,.L94
	lwz 9,84(31)
	li 0,88
	b .L173
.L94:
	lwz 9,84(31)
	li 0,7
	b .L173
.L88:
	cmpwi 0,27,0
	bc 12,2,.L97
	cmpwi 0,30,0
	rlwinm 0,11,0,31,29
	stw 0,4620(10)
	bc 12,1,.L98
	mr 3,31
	bl CanLeftReload
	cmpwi 0,3,0
	bc 12,2,.L99
	li 25,71
	li 26,11
	b .L82
.L99:
	cmpwi 0,29,0
	bc 4,1,.L82
	lwz 9,84(31)
	li 0,7
	b .L173
.L98:
	cmpwi 0,29,0
	bc 4,1,.L103
	lwz 9,84(31)
	li 0,88
	b .L173
.L103:
	lwz 9,84(31)
	li 0,70
.L173:
	li 26,7
	stw 0,92(9)
	b .L82
.L97:
	lis 9,level+4@ha
	lfs 13,992(31)
	lis 10,.LC10@ha
	lfs 0,level+4@l(9)
	la 10,.LC10@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L106
	li 25,9
	li 26,1
	b .L82
.L106:
	li 25,8
	b .L82
.L108:
	li 25,37
	li 26,10
	b .L82
.L109:
	lwz 0,4900(10)
	cmpwi 0,0,-1
	bc 4,1,.L110
.L171:
	li 0,8
	mr 3,31
	stw 0,92(10)
	bl ChangeRightWeapon
	b .L81
.L110:
	lwz 0,4904(10)
	cmpwi 0,0,-1
	bc 4,1,.L112
.L172:
	li 25,48
	li 26,5
	b .L82
.L112:
	neg 0,27
	srwi 0,0,31
	or. 9,28,0
	bc 12,2,.L82
	li 0,0
	li 11,8
	stw 0,4664(10)
	b .L174
.L115:
	addi 9,29,-1
	addi 0,30,-1
	or 9,29,9
	or 0,30,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 12,2,.L82
	li 9,8
	neg 0,27
	srwi 0,0,31
	stw 9,92(10)
	or. 9,28,0
	bc 4,2,.L81
	li 26,0
.L82:
	lwz 11,84(31)
	lwz 9,92(11)
	mr 8,11
	addi 9,9,-5
	cmplwi 0,9,83
	bc 12,1,.L165
	lis 11,.L167@ha
	slwi 10,9,2
	la 11,.L167@l(11)
	lis 9,.L167@ha
	lwzx 0,10,11
	la 9,.L167@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L167:
	.long .L121-.L167
	.long .L122-.L167
	.long .L126-.L167
	.long .L120-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L131-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L134-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L135-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L136-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L164-.L167
	.long .L139-.L167
	.long .L143-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L137-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L138-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L165-.L167
	.long .L164-.L167
	.long .L147-.L167
	.long .L155-.L167
.L121:
	li 0,0
	li 11,8
	stw 0,4664(8)
.L174:
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_TwinSubMach
	b .L81
.L122:
	xori 9,28,1
	subfic 10,27,0
	adde 0,10,27
	and. 11,9,0
	bc 4,2,.L175
	cmpwi 0,29,0
	bc 4,1,.L120
	b .L176
.L126:
	xori 9,28,1
	subfic 10,27,0
	adde 0,10,27
	and. 11,9,0
	bc 4,2,.L175
	cmpwi 0,29,0
	bc 4,1,.L120
	b .L177
.L131:
	bl rand
	li 25,9
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC11@ha
	lis 11,.LC9@ha
	la 10,.LC11@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC12@ha
	lfs 12,.LC9@l(11)
	la 10,.LC12@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L120
	li 25,8
	li 26,0
	b .L120
.L134:
	mr 3,31
	bl ChangeLeftWeapon
	b .L178
.L135:
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC13@ha
	lis 10,.LC13@ha
	lis 11,.LC14@ha
	mr 5,3
	la 11,.LC14@l(11)
	la 9,.LC13@l(9)
	mtlr 0
	la 10,.LC13@l(10)
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
	b .L179
.L136:
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC13@ha
	lis 10,.LC13@ha
	lis 11,.LC14@ha
	la 9,.LC13@l(9)
	la 11,.LC14@l(11)
	mr 5,3
	lfs 1,0(9)
	mtlr 0
	la 10,.LC13@l(10)
	lfs 3,0(11)
	li 4,0
	mr 3,31
	lfs 2,0(10)
	blrl
	mr 3,31
	li 4,0
	b .L180
.L137:
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC13@ha
	lis 10,.LC13@ha
	lis 11,.LC14@ha
	mr 5,3
	la 11,.LC14@l(11)
	la 9,.LC13@l(9)
	mtlr 0
	la 10,.LC13@l(10)
	lfs 1,0(9)
	li 4,0
	lfs 3,0(11)
	mr 3,31
	lfs 2,0(10)
	blrl
	lwz 9,84(31)
	mr 3,31
	lwz 5,1836(9)
	lwz 4,1844(9)
	bl DropClip
	lwz 9,84(31)
	li 0,0
	stw 0,1836(9)
	b .L179
.L138:
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC13@ha
	lis 10,.LC13@ha
	lis 11,.LC14@ha
	la 9,.LC13@l(9)
	la 11,.LC14@l(11)
	mr 5,3
	lfs 1,0(9)
	mtlr 0
	la 10,.LC13@l(10)
	lfs 3,0(11)
	li 4,0
	mr 3,31
	lfs 2,0(10)
	blrl
	mr 3,31
	li 4,4
.L180:
	bl ReloadHand
.L179:
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L120
.L139:
	xori 9,28,1
	subfic 10,27,0
	adde 0,10,27
	and. 11,9,0
	bc 4,2,.L175
	b .L152
.L143:
	xori 9,28,1
	subfic 10,27,0
	adde 0,10,27
	and. 11,9,0
	bc 4,2,.L175
	b .L160
.L147:
	xori 9,28,1
	subfic 10,27,0
	adde 0,10,27
	and. 11,9,0
	bc 4,2,.L175
	srawi 9,29,31
	srawi 0,30,31
	subf 9,29,9
	subf 0,30,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L150
	mr 3,31
	li 4,0
	bl FireSubMach
	mr 3,31
	li 4,1
	bl FireSubMach
	lwz 9,84(31)
	li 0,88
	stw 0,92(9)
	b .L120
.L150:
	cmpwi 0,29,0
	bc 4,1,.L152
.L176:
	mr 3,31
	li 4,0
	bl FireSubMach
	lwz 9,84(31)
	li 0,7
	stw 0,92(9)
	b .L120
.L152:
	cmpwi 0,30,0
	bc 4,1,.L120
	mr 3,31
	li 4,1
	bl FireSubMach
	lwz 9,84(31)
	li 0,70
	stw 0,92(9)
	b .L120
.L155:
	xori 9,28,1
	subfic 10,27,0
	adde 0,10,27
	and. 11,9,0
	bc 12,2,.L156
.L175:
	li 0,8
	li 26,0
	stw 0,92(8)
	b .L120
.L156:
	srawi 9,29,31
	srawi 0,30,31
	subf 9,29,9
	subf 0,30,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L158
	mr 3,31
	li 4,0
	bl FireSubMach
	mr 3,31
	li 4,1
	bl FireSubMach
	lwz 9,84(31)
	li 0,87
	stw 0,92(9)
	b .L120
.L158:
	cmpwi 0,29,0
	bc 4,1,.L160
.L177:
	mr 3,31
	li 4,0
	bl FireSubMach
.L178:
	lwz 9,84(31)
	li 0,6
	stw 0,92(9)
	b .L120
.L160:
	cmpwi 0,30,0
	bc 4,1,.L120
	mr 3,31
	li 4,1
	bl FireSubMach
	lwz 9,84(31)
	li 0,69
	stw 0,92(9)
	b .L120
.L164:
	li 26,0
	li 25,8
	b .L120
.L165:
	cmpwi 0,25,-1
	bc 4,2,.L170
	lwz 9,92(8)
	addi 9,9,1
	stw 9,92(8)
.L120:
	cmpwi 0,25,-1
	bc 12,2,.L168
.L170:
	lwz 9,84(31)
	stw 25,92(9)
.L168:
	cmpwi 0,26,-1
	bc 12,2,.L81
	lwz 9,84(31)
	stw 26,4664(9)
.L81:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 Think_TwinSubMach,.Lfe3-Think_TwinSubMach
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
