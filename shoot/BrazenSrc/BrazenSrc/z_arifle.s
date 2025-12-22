	.file	"z_arifle.c"
gcc2_compiled.:
	.section	".text"
	.align 2
	.globl ReloadGLauncher
	.type	 ReloadGLauncher,@function
ReloadGLauncher:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,0
	li 10,0
.L18:
	lwz 11,84(3)
	addi 9,11,1848
	lwzx 0,9,10
	cmpwi 0,0,28
	bc 4,2,.L17
	addi 11,11,1976
	lwzx 9,11,10
	addi 9,9,-1
	stwx 9,11,10
	lwz 9,84(3)
	lwz 0,1824(9)
	andi. 11,0,1
	bc 4,2,.L20
	ori 0,0,1
	b .L29
.L20:
	andi. 11,0,2
	bc 4,2,.L22
	ori 0,0,2
	b .L29
.L22:
	andi. 11,0,4
	bc 4,2,.L24
	ori 0,0,4
	b .L29
.L24:
	andi. 11,0,8
	bc 4,2,.L21
	ori 0,0,8
.L29:
	stw 0,1824(9)
.L21:
	lwz 9,84(3)
	addi 9,9,1976
	lwzx 0,9,10
	cmpwi 0,0,0
	bc 12,1,.L16
	bl RemoveItem
	b .L16
.L17:
	addi 4,4,1
	addi 10,10,4
	cmpwi 0,4,31
	bc 4,1,.L18
.L16:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe1:
	.size	 ReloadGLauncher,.Lfe1-ReloadGLauncher
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
	.long 0x43200000
	.align 2
.LC3:
	.long 0x40200000
	.section	".text"
	.align 2
	.globl ARGLauncherFire
	.type	 ARGLauncherFire,@function
ARGLauncherFire:
	stwu 1,-128(1)
	mflr 0
	stmw 25,100(1)
	stw 0,132(1)
	mr 28,3
	lwz 9,508(28)
	lis 10,0x4330
	lis 8,.LC0@ha
	la 8,.LC0@l(8)
	lwz 3,84(28)
	addi 29,1,24
	addi 9,9,-8
	lfd 13,0(8)
	addi 27,1,40
	xoris 9,9,0x8000
	lis 0,0x4100
	stw 9,92(1)
	addi 26,1,56
	mr 4,29
	stw 10,88(1)
	addi 3,3,4732
	mr 5,27
	lfd 0,88(1)
	li 6,0
	addi 25,28,4
	stw 0,12(1)
	stw 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,16(1)
	bl AngleVectors
	lwz 3,84(28)
	addi 5,1,8
	mr 6,29
	mr 8,26
	mr 7,27
	mr 4,25
	bl P_ProjectSource
	lis 8,.LC1@ha
	lwz 4,84(28)
	mr 3,29
	la 8,.LC1@l(8)
	lfs 1,0(8)
	addi 4,4,4680
	bl VectorScale
	lwz 9,84(28)
	lis 0,0xbf80
	lis 8,.LC2@ha
	la 8,.LC2@l(8)
	mr 5,29
	stw 0,4668(9)
	mr 4,26
	li 6,120
	lis 9,.LC3@ha
	lfs 2,0(8)
	li 7,900
	la 9,.LC3@l(9)
	li 8,28
	lfs 1,0(9)
	mr 3,28
	bl fire_cgrenade
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
	subf 3,3,28
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(29)
	li 3,8
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,25
	li 4,2
	mtlr 0
	blrl
	lwz 9,84(28)
	lwz 0,1824(9)
	andi. 8,0,8
	bc 12,2,.L31
	rlwinm 0,0,0,29,27
	b .L38
.L31:
	andi. 11,0,4
	bc 12,2,.L33
	rlwinm 0,0,0,30,28
	b .L38
.L33:
	andi. 8,0,2
	bc 12,2,.L35
	rlwinm 0,0,0,31,29
	b .L38
.L35:
	andi. 11,0,1
	bc 12,2,.L32
	rlwinm 0,0,0,0,30
.L38:
	stw 0,1824(9)
.L32:
	lwz 0,132(1)
	mtlr 0
	lmw 25,100(1)
	la 1,128(1)
	blr
.Lfe2:
	.size	 ARGLauncherFire,.Lfe2-ARGLauncherFire
	.section	".rodata"
	.align 3
.LC4:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl FireAssaultRifle
	.type	 FireAssaultRifle,@function
FireAssaultRifle:
	stwu 1,-112(1)
	mflr 0
	stmw 27,92(1)
	stw 0,116(1)
	mr 31,3
	lwz 9,508(31)
	lis 8,0x4330
	lis 10,.LC4@ha
	la 10,.LC4@l(10)
	lwz 7,84(31)
	li 0,0
	addi 9,9,-2
	lfd 13,0(10)
	addi 28,1,24
	xoris 9,9,0x8000
	lis 10,0x4000
	stw 0,40(1)
	stw 9,84(1)
	addi 29,1,56
	addi 4,1,8
	stw 8,80(1)
	mr 5,28
	li 6,0
	lfd 0,80(1)
	addi 27,31,4
	stw 10,44(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,48(1)
	lwz 9,1820(7)
	addi 9,9,-1
	stw 9,1820(7)
	lwz 3,84(31)
	addi 3,3,4732
	bl AngleVectors
	lwz 3,84(31)
	addi 5,1,40
	addi 6,1,8
	mr 8,29
	mr 7,28
	mr 4,27
	bl P_ProjectSource
	lwz 11,84(31)
	li 0,1
	li 9,100
	li 10,36
	addi 5,1,8
	stw 0,5188(11)
	li 6,13
	li 7,30
	li 8,100
	mr 4,29
	mr 3,31
	bl fire_bullet
	mr 4,29
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
	li 3,14
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	lwz 9,84(31)
	li 0,4
	stw 0,4792(9)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L40
	lwz 0,92(11)
	li 9,168
	rlwinm 0,0,0,31,31
	subfic 0,0,160
	b .L42
.L40:
	lwz 0,92(11)
	li 9,53
	rlwinm 0,0,0,31,31
	subfic 0,0,46
.L42:
	stw 0,56(31)
	stw 9,4788(11)
	lwz 0,116(1)
	mtlr 0
	lmw 27,92(1)
	la 1,112(1)
	blr
.Lfe3:
	.size	 FireAssaultRifle,.Lfe3-FireAssaultRifle
	.section	".rodata"
	.align 2
.LC6:
	.string	"weapons/arifle_clipout.wav"
	.align 2
.LC7:
	.string	"weapons/arifle_clipin.wav"
	.align 2
.LC8:
	.string	"weapons/shotcock.wav"
	.align 2
.LC5:
	.long 0x46fffe00
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
	.align 2
.LC12:
	.long 0x3f800000
	.align 2
.LC13:
	.long 0x0
	.section	".text"
	.align 2
	.globl Think_AssaultRifle
	.type	 Think_AssaultRifle,@function
Think_AssaultRifle:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 31,3
	li 27,-1
	lwz 9,84(31)
	li 30,-1
	lwz 10,4664(9)
	lwz 0,4620(9)
	lwz 11,4612(9)
	cmplwi 0,10,9
	lwz 28,1820(9)
	or 0,0,11
	lha 8,136(9)
	rlwinm 29,0,0,30,30
	rlwinm 7,0,0,31,31
	bc 12,1,.L44
	lis 11,.L91@ha
	slwi 10,10,2
	la 11,.L91@l(11)
	lis 9,.L91@ha
	lwzx 0,10,11
	la 9,.L91@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L91:
	.long .L45-.L91
	.long .L77-.L91
	.long .L44-.L91
	.long .L44-.L91
	.long .L44-.L91
	.long .L44-.L91
	.long .L44-.L91
	.long .L73-.L91
	.long .L83-.L91
	.long .L72-.L91
.L45:
	lwz 9,84(31)
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 12,1,.L132
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L48
	li 0,11
	mr 3,31
	stw 0,92(9)
	bl ChangeLeftWeapon
	b .L43
.L48:
	cmpwi 0,7,0
	bc 12,2,.L50
	lwz 0,4620(9)
	cmpwi 0,28,0
	rlwinm 0,0,0,0,30
	stw 0,4620(9)
	bc 12,1,.L51
	mr 3,31
	bl CanRightReload
	cmpwi 0,3,0
	bc 4,2,.L72
	b .L70
.L51:
	lwz 9,84(31)
	li 0,6
	li 27,7
	stw 0,92(9)
	b .L44
.L50:
	cmpwi 0,29,0
	bc 12,2,.L56
	lwz 0,4620(9)
	cmpwi 0,8,0
	rlwinm 0,0,0,31,29
	stw 0,4620(9)
	bc 12,1,.L57
	lwz 9,84(31)
	lwz 0,1824(9)
	mr 8,9
	andi. 9,0,8
	bc 12,2,.L59
	b .L133
.L128:
	li 0,1
	b .L60
.L59:
	li 10,32
	addi 9,8,1848
	mtctr 10
.L131:
	lwz 0,0(9)
	addi 9,9,4
	cmpwi 0,0,28
	bc 12,2,.L128
	bdnz .L131
.L133:
	li 0,0
.L60:
	cmpwi 0,0,0
	bc 12,2,.L70
	li 30,69
	li 27,11
	b .L44
.L57:
	lwz 9,84(31)
	li 0,58
	li 27,8
	stw 0,92(9)
	b .L44
.L56:
	lis 9,level+4@ha
	lfs 13,992(31)
	lis 11,.LC9@ha
	lfs 0,level+4@l(9)
	la 11,.LC9@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L70
	li 30,12
	li 27,1
	b .L44
.L70:
	li 30,11
	b .L44
.L72:
	li 30,35
	li 27,10
	b .L44
.L73:
	cmpwi 0,7,0
	lwz 8,84(31)
	bc 12,2,.L75
	lwz 0,92(8)
	cmpwi 0,0,11
	bc 12,2,.L75
	cmpwi 0,0,7
	bc 4,2,.L44
.L75:
	addi 0,28,-1
	li 9,11
	or 0,28,0
	stw 9,92(8)
	srwi 0,0,31
	and. 0,0,7
	bc 4,2,.L43
	lwz 9,84(31)
	lis 11,level+4@ha
	mr 3,31
	stw 0,4664(9)
	lfs 0,level+4@l(11)
	stfs 0,992(31)
	bl Think_AssaultRifle
	b .L43
.L77:
	lwz 9,84(31)
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L78
.L132:
	li 30,31
	li 27,4
	b .L44
.L78:
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L80
	mr 3,31
	bl ChangeLeftWeapon
	b .L43
.L80:
	neg 0,29
	srwi 0,0,31
	or. 10,7,0
	bc 12,2,.L44
	li 0,0
	li 11,11
	stw 0,4664(9)
	b .L134
.L83:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,60
	bc 4,2,.L84
	srawi 0,8,31
	subf 0,8,0
	srwi 0,0,31
	and. 10,7,0
	bc 12,2,.L85
	mr 3,31
	bl ARGLauncherFire
	lwz 9,84(31)
	li 0,61
	stw 0,92(9)
	b .L43
.L85:
	cmpwi 0,29,0
	bc 4,2,.L43
	stw 29,4664(9)
	li 0,11
	lwz 9,84(31)
	stw 0,92(9)
.L84:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,68
	bc 4,2,.L44
	li 0,60
	stw 0,92(9)
	b .L43
.L44:
	lwz 9,84(31)
	lwz 11,92(9)
	mr 8,9
	addi 10,11,-5
	cmplwi 0,10,70
	bc 12,1,.L122
	lis 11,.L124@ha
	slwi 10,10,2
	la 11,.L124@l(11)
	lis 9,.L124@ha
	lwzx 0,10,11
	la 9,.L124@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L124:
	.long .L93-.L124
	.long .L94-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L97-.L124
	.long .L92-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L101-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L104-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L106-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L107-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L108-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L109-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L122-.L124
	.long .L110-.L124
	.long .L111-.L124
.L93:
	li 0,0
	li 11,11
	stw 0,4664(8)
.L134:
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_AssaultRifle
	b .L43
.L94:
	cmpwi 0,28,0
	bc 4,1,.L98
	mr 3,31
	bl FireAssaultRifle
	lwz 9,84(31)
	li 0,10
	stw 0,92(9)
	b .L92
.L97:
	cmpwi 0,28,0
	bc 4,1,.L98
	mr 3,31
	bl FireAssaultRifle
	lwz 9,84(31)
	li 0,6
	stw 0,92(9)
	b .L92
.L98:
	li 0,11
	stw 0,92(8)
	b .L92
.L101:
	bl rand
	li 30,12
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC10@ha
	lis 11,.LC5@ha
	la 10,.LC10@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC11@ha
	lfs 12,.LC5@l(11)
	la 10,.LC11@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L92
	b .L112
.L104:
	lwz 0,4900(8)
	cmpwi 0,0,-1
	bc 4,1,.L92
	mr 3,31
	bl ChangeRightWeapon
	b .L92
.L106:
	lis 29,gi@ha
	lis 3,.LC6@ha
	la 29,gi@l(29)
	la 3,.LC6@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC12@ha
	lis 10,.LC12@ha
	lis 11,.LC13@ha
	mr 5,3
	la 11,.LC13@l(11)
	la 9,.LC12@l(9)
	mtlr 0
	la 10,.LC12@l(10)
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
	b .L135
.L107:
	lis 29,gi@ha
	lis 3,.LC7@ha
	la 29,gi@l(29)
	la 3,.LC7@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC12@ha
	lis 10,.LC12@ha
	lis 11,.LC13@ha
	la 9,.LC12@l(9)
	la 11,.LC13@l(11)
	mr 5,3
	lfs 1,0(9)
	mtlr 0
	la 10,.LC12@l(10)
	lfs 3,0(11)
	li 4,0
	mr 3,31
	lfs 2,0(10)
	blrl
	mr 3,31
	li 4,0
	bl ReloadHand
	b .L135
.L108:
	li 0,0
	li 11,11
	stw 0,4664(8)
	lwz 9,84(31)
	stw 11,92(9)
	b .L92
.L109:
	lis 29,gi@ha
	lis 3,.LC8@ha
	la 29,gi@l(29)
	la 3,.LC8@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC12@ha
	lis 10,.LC12@ha
	lis 11,.LC13@ha
	la 9,.LC12@l(9)
	la 11,.LC13@l(11)
	mr 5,3
	lfs 1,0(9)
	mtlr 0
	la 10,.LC12@l(10)
	lfs 3,0(11)
	li 4,0
	mr 3,31
	lfs 2,0(10)
	blrl
	b .L135
.L110:
	mr 3,31
	bl ReloadGLauncher
.L135:
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L92
.L111:
	cmpwi 0,29,0
	bc 12,2,.L112
	lwz 0,1824(8)
	andi. 9,0,8
	bc 12,2,.L113
	b .L136
.L129:
	li 0,1
	b .L114
.L113:
	li 10,32
	addi 9,8,1848
	mtctr 10
.L130:
	lwz 0,0(9)
	addi 9,9,4
	cmpwi 0,0,28
	bc 12,2,.L129
	bdnz .L130
.L136:
	li 0,0
.L114:
	cmpwi 0,0,0
	bc 12,2,.L112
	li 30,69
	li 27,11
	b .L92
.L112:
	li 30,11
	li 27,0
	b .L92
.L122:
	cmpwi 0,30,-1
	bc 4,2,.L127
	lwz 9,92(8)
	addi 9,9,1
	stw 9,92(8)
.L92:
	cmpwi 0,30,-1
	bc 12,2,.L125
.L127:
	lwz 9,84(31)
	stw 30,92(9)
.L125:
	cmpwi 0,27,-1
	bc 12,2,.L43
	lwz 9,84(31)
	stw 27,4664(9)
.L43:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 Think_AssaultRifle,.Lfe4-Think_AssaultRifle
	.align 2
	.globl CanReloadGLauncher
	.type	 CanReloadGLauncher,@function
CanReloadGLauncher:
	lwz 9,84(3)
	lwz 0,1824(9)
	andi. 11,0,8
	bc 12,2,.L7
	li 3,0
	blr
.L138:
	li 3,1
	blr
.L7:
	li 0,32
	addi 9,9,1848
	mtctr 0
.L139:
	lwz 0,0(9)
	addi 9,9,4
	cmpwi 0,0,28
	bc 12,2,.L138
	bdnz .L139
	li 3,0
	blr
.Lfe5:
	.size	 CanReloadGLauncher,.Lfe5-CanReloadGLauncher
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
