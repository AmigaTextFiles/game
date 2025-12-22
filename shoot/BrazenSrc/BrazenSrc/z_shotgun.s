	.file	"z_shotgun.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC0:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl FireShotgun
	.type	 FireShotgun,@function
FireShotgun:
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
	stw 0,48(1)
	xoris 9,9,0x8000
	lfd 13,0(10)
	stw 9,84(1)
	lis 10,0xc000
	stw 8,80(1)
	lfd 0,80(1)
	stw 10,52(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,56(1)
	lwz 9,1836(7)
	addi 9,9,-1
	stw 9,1836(7)
	lwz 11,84(31)
	lwz 0,1844(11)
	cmpwi 0,0,31
	bc 12,2,.L19
	b .L12
.L7:
	lwz 9,508(31)
	lis 8,0x4330
	lis 10,.LC0@ha
	lwz 7,84(31)
	li 0,0
	addi 9,9,-2
	la 10,.LC0@l(10)
	stw 0,48(1)
	xoris 9,9,0x8000
	lfd 13,0(10)
	stw 9,84(1)
	lis 10,0x4000
	stw 8,80(1)
	lfd 0,80(1)
	stw 10,52(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,56(1)
	lwz 9,1820(7)
	addi 9,9,-1
	stw 9,1820(7)
	lwz 11,84(31)
	lwz 0,1828(11)
	cmpwi 0,0,31
	bc 4,2,.L12
.L19:
	li 30,1
	b .L11
.L12:
	xori 0,0,32
	addic 0,0,-1
	subfe 0,0,0
	rlwinm 30,0,0,30,30
.L11:
	lwz 3,84(31)
	addi 28,1,32
	addi 4,1,16
	mr 5,28
	li 6,0
	addi 3,3,4732
	addi 29,31,4
	bl AngleVectors
	mr 26,29
	addi 8,1,64
	lwz 3,84(31)
	mr 7,28
	mr 27,8
	mr 4,29
	addi 5,1,48
	addi 6,1,16
	bl P_ProjectSource
	cmpwi 0,30,1
	bc 4,2,.L15
	mr 3,31
	mr 4,27
	addi 5,1,16
	li 6,80
	li 7,30
	li 8,100
	li 9,100
	li 10,37
	bl fire_bullet
	b .L16
.L15:
	cmpwi 0,30,2
	bc 4,2,.L17
	mr 3,31
	mr 4,27
	addi 5,1,16
	li 6,80
	li 7,30
	li 8,100
	li 9,100
	li 10,38
	bl fire_bullet
	b .L16
.L17:
	li 0,2
	mr 3,31
	stw 0,8(1)
	mr 4,27
	addi 5,1,16
	li 6,6
	li 7,12
	li 8,1000
	li 9,500
	li 10,15
	bl fire_shotgun
.L16:
	mr 4,27
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
	li 3,13
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
	lwz 0,116(1)
	mtlr 0
	lmw 26,88(1)
	la 1,112(1)
	blr
.Lfe1:
	.size	 FireShotgun,.Lfe1-FireShotgun
	.section	".rodata"
	.align 2
.LC2:
	.string	"weapons/shotgun_clipout.wav"
	.align 2
.LC3:
	.string	"weapons/shotgun_clipin.wav"
	.align 2
.LC4:
	.string	"weapons/shotcock.wav"
	.align 2
.LC1:
	.long 0x46fffe00
	.align 2
.LC5:
	.long 0x41000000
	.align 3
.LC6:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC7:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC8:
	.long 0x3f800000
	.align 2
.LC9:
	.long 0x0
	.section	".text"
	.align 2
	.globl Think_Shotgun
	.type	 Think_Shotgun,@function
Think_Shotgun:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	li 28,-1
	lwz 9,84(31)
	li 30,-1
	lwz 10,4664(9)
	lwz 0,4620(9)
	lwz 11,4612(9)
	cmplwi 0,10,10
	lwz 7,1820(9)
	or 0,0,11
	lha 6,136(9)
	rlwinm 29,0,0,30,30
	rlwinm 8,0,0,31,31
	bc 12,1,.L21
	lis 11,.L51@ha
	slwi 10,10,2
	la 11,.L51@l(11)
	lis 9,.L51@ha
	lwzx 0,10,11
	la 9,.L51@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L51:
	.long .L22-.L51
	.long .L37-.L51
	.long .L21-.L51
	.long .L21-.L51
	.long .L21-.L51
	.long .L21-.L51
	.long .L21-.L51
	.long .L44-.L51
	.long .L47-.L51
	.long .L43-.L51
	.long .L21-.L51
.L22:
	lwz 11,84(31)
	lwz 0,4900(11)
	cmpwi 0,0,-1
	bc 12,1,.L73
	lwz 0,4904(11)
	cmpwi 0,0,-1
	bc 4,1,.L25
	li 0,8
	mr 3,31
	stw 0,92(11)
	bl ChangeLeftWeapon
	b .L20
.L25:
	cmpwi 0,8,0
	bc 12,2,.L27
	lwz 0,4620(11)
	cmpwi 0,7,0
	rlwinm 0,0,0,0,30
	stw 0,4620(11)
	bc 12,1,.L28
	mr 3,31
	bl CanRightReload
	cmpwi 0,3,0
	bc 4,2,.L43
	b .L35
.L28:
	li 30,4
	li 28,7
	mr 3,31
	li 4,0
	bl FireShotgun
	b .L21
.L27:
	srawi 0,6,31
	neg 9,29
	subf 0,6,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L33
	lwz 0,4620(11)
	li 30,82
	li 28,8
	rlwinm 0,0,0,31,29
	stw 0,4620(11)
	b .L21
.L33:
	lis 9,level+4@ha
	lfs 13,992(31)
	lis 11,.LC5@ha
	lfs 0,level+4@l(9)
	la 11,.LC5@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L35
	li 30,9
	li 28,1
	b .L21
.L35:
	li 30,8
	b .L21
.L37:
	lwz 9,84(31)
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L38
.L73:
	li 30,62
	li 28,4
	b .L21
.L38:
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L40
	mr 3,31
	bl ChangeLeftWeapon
	b .L20
.L40:
	neg 0,29
	srwi 0,0,31
	or. 10,8,0
	bc 12,2,.L21
	li 0,0
	li 11,8
	stw 0,4664(9)
	b .L74
.L43:
	li 30,65
	li 28,10
	b .L21
.L44:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,8
	bc 4,2,.L21
	addi 0,7,-1
	or 0,7,0
	srwi 0,0,31
	and. 0,0,8
	bc 4,2,.L20
	stw 0,4664(9)
	mr 3,31
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,992(31)
	bl Think_Shotgun
	b .L20
.L47:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,90
	bc 4,1,.L21
	li 0,8
	li 28,0
	stw 0,92(9)
.L21:
	lwz 11,84(31)
	lwz 9,92(11)
	mr 8,11
	addi 9,9,-3
	cmplwi 0,9,83
	bc 12,1,.L67
	lis 11,.L69@ha
	slwi 10,9,2
	la 11,.L69@l(11)
	lis 9,.L69@ha
	lwzx 0,10,11
	la 9,.L69@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L69:
	.long .L53-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L52-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L55-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L58-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L60-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L61-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L62-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L63-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L67-.L69
	.long .L64-.L69
	.long .L66-.L69
.L53:
	li 0,0
	li 11,8
	stw 0,4664(8)
.L74:
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_Shotgun
	b .L20
.L55:
	bl rand
	li 30,9
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,12(1)
	lis 10,.LC6@ha
	lis 11,.LC1@ha
	la 10,.LC6@l(10)
	stw 0,8(1)
	lfd 13,0(10)
	lfd 0,8(1)
	lis 10,.LC7@ha
	lfs 12,.LC1@l(11)
	la 10,.LC7@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L52
	li 30,8
	li 28,0
	b .L52
.L58:
	lwz 0,4900(8)
	cmpwi 0,0,-1
	bc 4,1,.L52
	mr 3,31
	bl ChangeRightWeapon
	b .L52
.L60:
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC8@ha
	lis 10,.LC8@ha
	lis 11,.LC9@ha
	mr 5,3
	la 11,.LC9@l(11)
	la 9,.LC8@l(9)
	mtlr 0
	la 10,.LC8@l(10)
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
	b .L75
.L61:
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC8@ha
	lis 10,.LC8@ha
	lis 11,.LC9@ha
	la 9,.LC8@l(9)
	la 11,.LC9@l(11)
	mr 5,3
	lfs 1,0(9)
	mtlr 0
	la 10,.LC8@l(10)
	lfs 3,0(11)
	li 4,0
	mr 3,31
	lfs 2,0(10)
	blrl
	b .L75
.L62:
	lis 29,gi@ha
	lis 3,.LC4@ha
	la 29,gi@l(29)
	la 3,.LC4@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC8@ha
	lis 10,.LC8@ha
	lis 11,.LC9@ha
	la 9,.LC8@l(9)
	la 11,.LC9@l(11)
	mr 5,3
	lfs 1,0(9)
	mtlr 0
	la 10,.LC8@l(10)
	lfs 3,0(11)
	li 4,0
	mr 3,31
	lfs 2,0(10)
	blrl
	mr 3,31
	li 4,0
	bl ReloadHand
	b .L75
.L63:
	li 28,0
	li 30,8
	b .L52
.L64:
	cmpwi 0,29,0
	bc 4,2,.L20
	b .L76
.L66:
	mr 3,31
	bl ThrowOffHandGrenade
.L75:
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L52
.L67:
	cmpwi 0,30,-1
	bc 4,2,.L72
.L76:
	lwz 9,92(8)
	addi 9,9,1
	stw 9,92(8)
.L52:
	cmpwi 0,30,-1
	bc 12,2,.L70
.L72:
	lwz 9,84(31)
	stw 30,92(9)
.L70:
	cmpwi 0,28,-1
	bc 12,2,.L20
	lwz 9,84(31)
	stw 28,4664(9)
.L20:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Think_Shotgun,.Lfe2-Think_Shotgun
	.section	".rodata"
	.align 2
.LC10:
	.long 0x46fffe00
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
	.align 2
.LC14:
	.long 0x3f800000
	.align 2
.LC15:
	.long 0x0
	.section	".text"
	.align 2
	.globl Think_TwinShotgun
	.type	 Think_TwinShotgun,@function
Think_TwinShotgun:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 31,3
	li 28,-1
	lwz 9,84(31)
	li 27,-1
	lwz 10,4664(9)
	lwz 0,4620(9)
	lwz 11,4612(9)
	cmplwi 0,10,9
	lwz 30,1820(9)
	or 0,0,11
	lwz 29,1836(9)
	rlwinm 7,0,0,30,30
	rlwinm 8,0,0,31,31
	bc 12,1,.L78
	lis 11,.L156@ha
	slwi 10,10,2
	la 11,.L156@l(11)
	lis 9,.L156@ha
	lwzx 0,10,11
	la 9,.L156@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L156:
	.long .L79-.L156
	.long .L104-.L156
	.long .L78-.L156
	.long .L78-.L156
	.long .L78-.L156
	.long .L78-.L156
	.long .L78-.L156
	.long .L113-.L156
	.long .L124-.L156
	.long .L112-.L156
.L79:
	lwz 9,84(31)
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 12,1,.L183
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 12,1,.L184
	cmpwi 0,8,0
	bc 12,2,.L84
	lwz 0,4620(9)
	cmpwi 0,30,0
	rlwinm 0,0,0,0,30
	stw 0,4620(9)
	bc 12,1,.L85
	lwz 9,84(31)
	li 0,13
	mr 3,31
	stw 0,92(9)
	bl CanRightReload
	cmpwi 0,3,0
	bc 4,2,.L112
	cmpwi 0,29,0
	bc 4,1,.L78
	lwz 9,84(31)
	li 0,61
	li 28,8
	b .L185
.L85:
	cmpwi 0,29,0
	bc 4,1,.L90
	lwz 9,84(31)
	li 0,91
	li 28,7
	b .L185
.L90:
	lwz 9,84(31)
	li 0,7
	li 28,8
	b .L185
.L84:
	cmpwi 0,7,0
	bc 12,2,.L93
	lwz 0,4620(9)
	cmpwi 0,29,0
	rlwinm 0,0,0,31,29
	stw 0,4620(9)
	bc 12,1,.L94
	lwz 9,84(31)
	li 0,13
	mr 3,31
	stw 0,92(9)
	bl CanLeftReload
	cmpwi 0,3,0
	bc 12,2,.L95
	li 27,67
	li 28,11
	b .L78
.L95:
	cmpwi 0,30,0
	bc 4,1,.L78
	lwz 9,84(31)
	li 0,7
	li 28,8
	b .L185
.L94:
	cmpw 0,30,29
	bc 4,1,.L99
	lwz 9,84(31)
	li 0,7
	b .L186
.L99:
	lwz 9,84(31)
	li 0,61
.L186:
	stw 0,92(9)
	li 28,8
	b .L78
.L93:
	lis 9,level+4@ha
	lfs 13,992(31)
	lis 10,.LC11@ha
	lfs 0,level+4@l(9)
	la 10,.LC11@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L187
	li 27,14
	li 28,1
	b .L78
.L104:
	lwz 9,84(31)
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L105
.L183:
	li 0,13
	mr 3,31
	stw 0,92(9)
	bl ChangeRightWeapon
	b .L77
.L105:
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L107
.L184:
	li 27,31
	li 28,5
	b .L78
.L107:
	neg 0,7
	srwi 0,0,31
	or. 10,8,0
	bc 12,2,.L78
	cmpw 0,30,29
	li 0,0
	stw 0,4664(9)
	bc 12,1,.L110
	lwz 9,84(31)
	li 0,61
	b .L188
.L110:
	lwz 9,84(31)
	li 0,7
.L188:
	stw 0,92(9)
	b .L189
.L112:
	li 27,37
	li 28,10
	b .L78
.L113:
	lwz 11,84(31)
	lwz 0,92(11)
	xori 9,0,13
	subfic 10,9,0
	adde 9,10,9
	xori 0,0,97
	subfic 10,0,0
	adde 0,10,0
	or. 10,0,9
	bc 12,2,.L78
	cmpwi 0,8,0
	bc 4,2,.L115
	li 27,13
	li 28,0
	b .L78
.L115:
	cmpwi 0,30,0
	bc 12,1,.L117
	cmpwi 0,29,0
	bc 4,1,.L118
	li 0,61
	stw 0,92(11)
	b .L78
.L118:
	li 0,13
	stw 0,92(11)
	b .L77
.L117:
	cmpwi 0,29,0
	bc 12,1,.L122
	li 0,7
	li 28,8
	stw 0,92(11)
	b .L78
.L122:
	li 0,91
	stw 0,92(11)
	b .L78
.L124:
	lwz 9,84(31)
	lwz 11,92(9)
	mr 8,9
	cmpwi 0,11,13
	bc 12,2,.L138
	bc 4,1,.L154
	cmpwi 0,11,66
	bc 12,1,.L78
	cmpwi 0,11,65
	bc 12,0,.L78
	b .L141
.L154:
	cmpwi 0,11,11
	bc 12,0,.L78
	cmpwi 0,7,0
	bc 4,2,.L128
	cmpwi 0,11,12
	b .L190
.L128:
	addi 9,29,-1
	addi 0,30,-1
	or 9,29,9
	or 0,30,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L131
	cmpwi 0,11,12
	b .L191
.L131:
	cmpwi 0,29,0
	bc 4,1,.L135
	li 0,61
	stw 0,92(8)
	b .L78
.L135:
	cmpwi 0,30,0
	bc 4,1,.L78
	cmpwi 0,11,12
	bc 4,2,.L78
	li 0,7
	stw 0,92(8)
	b .L78
.L138:
	cmpwi 0,7,0
	bc 4,2,.L77
	stw 7,4664(8)
.L189:
	mr 3,31
	bl Think_TwinShotgun
	b .L77
.L141:
	cmpwi 0,7,0
	bc 4,2,.L142
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,66
.L190:
	bc 4,2,.L78
	li 28,0
.L187:
	li 27,13
	b .L78
.L142:
	addi 9,29,-1
	addi 0,30,-1
	or 9,29,9
	or 0,30,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L145
	lwz 0,92(8)
	cmpwi 0,0,66
.L191:
	bc 4,2,.L78
	li 0,13
	stw 0,92(8)
	b .L77
.L145:
	cmpwi 0,30,0
	bc 4,1,.L149
	lwz 9,84(31)
	li 0,7
	b .L185
.L149:
	cmpwi 0,29,0
	bc 4,1,.L78
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,66
	bc 4,2,.L78
	li 0,61
.L185:
	stw 0,92(9)
.L78:
	lwz 9,84(31)
	lwz 11,92(9)
	mr 8,9
	addi 10,11,-6
	cmplwi 0,10,85
	bc 12,1,.L177
	lis 11,.L179@ha
	slwi 10,10,2
	la 11,.L179@l(11)
	lis 9,.L179@ha
	lwzx 0,10,11
	la 9,.L179@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L179:
	.long .L160-.L179
	.long .L161-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L160-.L179
	.long .L157-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L163-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L166-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L167-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L168-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L169-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L175-.L179
	.long .L194-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L160-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L171-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L172-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L173-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L177-.L179
	.long .L175-.L179
	.long .L176-.L179
.L160:
	li 0,0
	li 11,13
	stw 0,4664(8)
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_TwinShotgun
	b .L77
.L161:
	mr 3,31
	li 4,0
	b .L192
.L163:
	bl rand
	li 27,14
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC12@ha
	lis 11,.LC10@ha
	la 10,.LC12@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC13@ha
	lfs 12,.LC10@l(11)
	la 10,.LC13@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L157
	li 27,13
	li 28,0
	b .L157
.L166:
	mr 3,31
	bl ChangeLeftWeapon
	lwz 9,84(31)
	li 0,8
	stw 0,92(9)
	b .L157
.L167:
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC14@ha
	lis 10,.LC14@ha
	lis 11,.LC15@ha
	mr 5,3
	la 11,.LC15@l(11)
	la 9,.LC14@l(9)
	mtlr 0
	la 10,.LC14@l(10)
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
	b .L193
.L168:
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC14@ha
	lis 10,.LC14@ha
	lis 11,.LC15@ha
	la 9,.LC14@l(9)
	la 11,.LC15@l(11)
	mr 5,3
	lfs 1,0(9)
	mtlr 0
	la 10,.LC14@l(10)
	lfs 3,0(11)
	li 4,0
	mr 3,31
	lfs 2,0(10)
	blrl
	b .L193
.L169:
	lis 29,gi@ha
	lis 3,.LC4@ha
	la 29,gi@l(29)
	la 3,.LC4@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC14@ha
	lis 10,.LC14@ha
	lis 11,.LC15@ha
	la 9,.LC14@l(9)
	la 11,.LC15@l(11)
	mr 5,3
	lfs 1,0(9)
	mtlr 0
	la 10,.LC14@l(10)
	lfs 3,0(11)
	li 4,0
	mr 3,31
	lfs 2,0(10)
	blrl
	mr 3,31
	li 4,0
	bl ReloadHand
	b .L193
.L171:
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC14@ha
	lis 10,.LC14@ha
	lis 11,.LC15@ha
	mr 5,3
	la 11,.LC15@l(11)
	la 9,.LC14@l(9)
	mtlr 0
	la 10,.LC14@l(10)
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
	b .L193
.L172:
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC14@ha
	lis 10,.LC14@ha
	lis 11,.LC15@ha
	la 9,.LC14@l(9)
	la 11,.LC15@l(11)
	mr 5,3
	lfs 1,0(9)
	mtlr 0
	la 10,.LC14@l(10)
	lfs 3,0(11)
	li 4,0
	mr 3,31
	lfs 2,0(10)
	blrl
	b .L193
.L173:
	lis 29,gi@ha
	lis 3,.LC4@ha
	la 29,gi@l(29)
	la 3,.LC4@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC14@ha
	lis 10,.LC14@ha
	lis 11,.LC15@ha
	la 9,.LC14@l(9)
	la 11,.LC15@l(11)
	mr 5,3
	lfs 1,0(9)
	mtlr 0
	la 10,.LC14@l(10)
	lfs 3,0(11)
	li 4,0
	mr 3,31
	lfs 2,0(10)
	blrl
	mr 3,31
	li 4,4
	bl ReloadHand
	b .L193
.L175:
	li 28,0
	li 27,13
	b .L157
.L176:
	mr 3,31
	li 4,0
	bl FireShotgun
.L194:
	mr 3,31
	li 4,1
.L192:
	bl FireShotgun
.L193:
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L157
.L177:
	cmpwi 0,27,-1
	bc 4,2,.L182
	lwz 9,92(8)
	addi 9,9,1
	stw 9,92(8)
.L157:
	cmpwi 0,27,-1
	bc 12,2,.L180
.L182:
	lwz 9,84(31)
	stw 27,92(9)
.L180:
	cmpwi 0,28,-1
	bc 12,2,.L77
	lwz 9,84(31)
	stw 28,4664(9)
.L77:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 Think_TwinShotgun,.Lfe3-Think_TwinShotgun
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
