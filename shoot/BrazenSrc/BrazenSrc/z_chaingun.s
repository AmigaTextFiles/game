	.file	"z_chaingun.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x46fffe00
	.align 3
.LC1:
	.long 0x3fd66666
	.long 0x66666666
	.align 3
.LC2:
	.long 0x3fe66666
	.long 0x66666666
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC4:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC5:
	.long 0x40100000
	.long 0x0
	.align 3
.LC6:
	.long 0x401c0000
	.long 0x0
	.align 2
.LC7:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl FireChaingun
	.type	 FireChaingun,@function
FireChaingun:
	stwu 1,-192(1)
	mflr 0
	stfd 25,136(1)
	stfd 26,144(1)
	stfd 27,152(1)
	stfd 28,160(1)
	stfd 29,168(1)
	stfd 30,176(1)
	stfd 31,184(1)
	stmw 24,104(1)
	stw 0,196(1)
	mr 31,3
	li 0,1
	lwz 11,84(31)
	li 10,4
	mr 27,4
	stw 0,5188(11)
	lwz 9,84(31)
	stw 10,4792(9)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L7
	lwz 0,92(11)
	li 9,168
	rlwinm 0,0,0,31,31
	subfic 0,0,160
	b .L27
.L7:
	lwz 0,92(11)
	li 9,53
	rlwinm 0,0,0,31,31
	subfic 0,0,46
.L27:
	stw 0,56(31)
	stw 9,4788(11)
	lis 9,.LC0@ha
	lis 11,.LC1@ha
	lfs 29,.LC0@l(9)
	lis 10,.LC2@ha
	addi 26,31,4
	lis 9,.LC3@ha
	lfd 27,.LC1@l(11)
	lis 28,0x4330
	la 9,.LC3@l(9)
	lfd 28,.LC2@l(10)
	li 29,0
	lfd 30,0(9)
	li 30,3
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfd 31,0(9)
.L12:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,84(31)
	xoris 3,3,0x8000
	stw 3,100(1)
	addi 11,11,4680
	stw 28,96(1)
	lfd 13,96(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmul 0,0,27
	frsp 0,0
	stfsx 0,11,29
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,84(31)
	xoris 3,3,0x8000
	addic. 30,30,-1
	stw 3,100(1)
	addi 11,11,4668
	stw 28,96(1)
	lfd 13,96(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmul 0,0,28
	frsp 0,0
	stfsx 0,11,29
	addi 29,29,4
	bc 4,2,.L12
	lwz 9,84(31)
	lha 11,130(9)
	cmpw 7,11,27
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 11,11,0
	and 0,27,0
	or. 25,0,11
	bc 4,1,.L16
	lis 9,.LC0@ha
	addi 29,1,24
	lfs 27,.LC0@l(9)
	addi 28,1,40
	lis 27,0x4330
	lis 9,.LC3@ha
	mr 30,25
	la 9,.LC3@l(9)
	li 24,0
	lfd 30,0(9)
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfd 28,0(9)
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfd 29,0(9)
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfd 26,0(9)
	lis 9,.LC7@ha
	la 9,.LC7@l(9)
	lfs 25,0(9)
.L18:
	lwz 3,84(31)
	addi 6,1,56
	mr 4,29
	mr 5,28
	addi 3,3,4732
	bl AngleVectors
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,100(1)
	stw 27,96(1)
	lfd 0,96(1)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,27
	fmr 31,0
	fsub 31,31,28
	fadd 31,31,31
	fmadd 31,31,29,26
	frsp 31,31
	bl rand
	rlwinm 0,3,0,17,31
	lwz 11,508(31)
	xoris 0,0,0x8000
	mr 10,9
	lwz 3,84(31)
	stw 0,100(1)
	xoris 11,11,0x8000
	mr 4,26
	stw 27,96(1)
	addi 5,1,72
	mr 6,29
	lfd 13,96(1)
	mr 7,28
	addi 8,1,8
	stw 11,100(1)
	stw 27,96(1)
	fsub 13,13,30
	lfd 12,96(1)
	stfs 31,76(1)
	stw 24,72(1)
	frsp 13,13
	fsub 12,12,30
	fdivs 13,13,27
	fmr 0,13
	frsp 12,12
	fsub 0,0,28
	fadd 0,0,0
	fmul 0,0,29
	frsp 0,0
	fadds 0,0,12
	fsubs 0,0,25
	stfs 0,80(1)
	bl P_ProjectSource
	mr 3,31
	addi 4,1,8
	mr 5,29
	li 6,8
	li 7,2
	li 8,300
	li 9,500
	li 10,5
	bl fire_bullet
	addic. 30,30,-1
	bc 4,2,.L18
.L16:
	addi 4,1,8
	li 5,1
	mr 3,31
	li 30,0
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
	addi 3,25,2
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
	li 8,0
.L23:
	lwz 10,84(31)
	addi 9,10,1848
	lwzx 0,9,8
	cmpwi 0,0,27
	bc 4,2,.L22
	addi 10,10,1976
	lwzx 9,10,8
	addi 9,9,-1
	stwx 9,10,8
	lwz 11,84(31)
	addi 11,11,1976
	lwzx 0,11,8
	cmpwi 0,0,0
	bc 12,1,.L21
	mr 3,31
	mr 4,30
	bl RemoveItem
	b .L21
.L22:
	addi 30,30,1
	addi 8,8,4
	cmpwi 0,30,31
	bc 4,1,.L23
.L21:
	lwz 0,196(1)
	mtlr 0
	lmw 24,104(1)
	lfd 25,136(1)
	lfd 26,144(1)
	lfd 27,152(1)
	lfd 28,160(1)
	lfd 29,168(1)
	lfd 30,176(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe1:
	.size	 FireChaingun,.Lfe1-FireChaingun
	.section	".rodata"
	.align 2
.LC8:
	.string	"weapons/chngnl1a.wav"
	.align 2
.LC9:
	.string	"weapons/chngnu1a.wav"
	.align 2
.LC10:
	.string	"weapons/chngnd1a.wav"
	.align 2
.LC11:
	.long 0x46fffe00
	.align 2
.LC12:
	.long 0x41000000
	.align 2
.LC13:
	.long 0x3f800000
	.align 2
.LC14:
	.long 0x40000000
	.align 2
.LC15:
	.long 0x0
	.align 3
.LC16:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC17:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Think_Chaingun
	.type	 Think_Chaingun,@function
Think_Chaingun:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 31,3
	li 26,-1
	lwz 9,84(31)
	li 27,-1
	lwz 11,4664(9)
	lwz 10,4620(9)
	lwz 0,4612(9)
	cmpwi 0,11,1
	lha 28,130(9)
	or 0,10,0
	rlwinm 30,0,0,30,30
	rlwinm 29,0,0,31,31
	bc 12,2,.L41
	cmplwi 0,11,1
	bc 12,0,.L30
	cmpwi 0,11,7
	bc 12,2,.L47
	cmpwi 0,11,8
	bc 12,2,.L59
	b .L29
.L30:
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 12,1,.L82
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L33
	li 0,33
	mr 3,31
	stw 0,92(9)
	bl ChangeLeftWeapon
	b .L28
.L33:
	cmpwi 0,29,0
	bc 12,2,.L35
	rlwinm 0,10,0,0,30
	li 11,5
	stw 0,4620(9)
	li 26,7
	b .L83
.L35:
	cmpwi 0,30,0
	bc 12,2,.L37
	rlwinm 0,10,0,31,29
	li 11,5
	stw 0,4620(9)
	li 26,8
.L83:
	lwz 9,84(31)
	stw 11,92(9)
	b .L29
.L37:
	lis 9,level+4@ha
	lfs 13,992(31)
	lis 10,.LC12@ha
	lfs 0,level+4@l(9)
	la 10,.LC12@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L39
	li 27,33
	li 26,1
	b .L29
.L39:
	li 27,32
	b .L29
.L41:
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L42
.L82:
	li 27,62
	li 26,4
	b .L29
.L42:
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L44
	mr 3,31
	bl ChangeLeftWeapon
	b .L28
.L44:
	neg 0,30
	srwi 0,0,31
	or. 10,29,0
	bc 12,2,.L29
	li 0,0
	li 11,32
	stw 0,4664(9)
	b .L84
.L47:
	lwz 0,92(9)
	cmpwi 0,0,21
	bc 12,1,.L29
	lis 9,gi+36@ha
	lis 3,.LC8@ha
	lwz 0,gi+36@l(9)
	la 3,.LC8@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	cmpwi 0,28,0
	stw 3,4832(9)
	bc 4,1,.L49
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,9
	bc 12,1,.L50
	li 4,1
	b .L51
.L50:
	cmpwi 0,0,14
	bc 12,1,.L52
	addic 9,29,-1
	subfe 9,9,9
	nor 0,9,9
	rlwinm 9,9,0,31,31
	rlwinm 0,0,0,30,30
	or 4,9,0
	b .L51
.L52:
	li 4,3
.L51:
	cmpwi 0,4,0
	bc 4,1,.L49
	mr 3,31
	bl FireChaingun
.L49:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,21
	bc 4,2,.L29
	neg 0,30
	srwi 0,0,31
	or. 10,29,0
	bc 12,2,.L29
	cmpwi 0,29,0
	li 0,15
	stw 0,92(9)
	bc 4,2,.L28
	lwz 9,84(31)
	li 0,8
	stw 0,4664(9)
	b .L28
.L59:
	lwz 0,92(9)
	cmpwi 0,0,21
	bc 12,1,.L29
	lis 9,gi+36@ha
	lis 3,.LC8@ha
	lwz 0,gi+36@l(9)
	la 3,.LC8@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	cmpwi 0,29,0
	stw 3,4832(9)
	bc 12,2,.L61
	lwz 9,84(31)
	li 0,7
	stw 0,4664(9)
.L61:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,21
	bc 4,2,.L29
	neg 0,30
	srwi 0,0,31
	or. 10,29,0
	bc 12,2,.L29
	li 0,15
	stw 0,92(9)
	b .L28
.L29:
	lwz 11,84(31)
	lwz 9,92(11)
	mr 8,11
	addi 9,9,-4
	cmplwi 0,9,60
	bc 12,1,.L76
	lis 11,.L78@ha
	slwi 10,9,2
	la 11,.L78@l(11)
	lis 9,.L78@ha
	lwzx 0,10,11
	la 9,.L78@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L78:
	.long .L66-.L78
	.long .L67-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L68-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L69-.L78
	.long .L65-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L71-.L78
	.long .L76-.L78
	.long .L76-.L78
	.long .L74-.L78
.L66:
	li 0,0
	li 11,32
	stw 0,4664(8)
.L84:
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_Chaingun
	b .L28
.L67:
	lis 29,gi@ha
	lis 3,.LC9@ha
	la 29,gi@l(29)
	la 3,.LC9@l(3)
	lwz 9,36(29)
	b .L85
.L68:
	li 0,0
	lis 29,gi@ha
	stw 0,4832(8)
	la 29,gi@l(29)
	lis 3,.LC10@ha
	lwz 9,36(29)
	la 3,.LC10@l(3)
.L85:
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC13@ha
	lis 10,.LC14@ha
	lis 11,.LC15@ha
	la 9,.LC13@l(9)
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
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L65
.L69:
	lwz 9,92(8)
	li 26,0
	b .L86
.L71:
	bl rand
	li 27,33
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC16@ha
	lis 11,.LC11@ha
	la 10,.LC16@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC17@ha
	lfs 12,.LC11@l(11)
	la 10,.LC17@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L65
	li 27,32
	li 26,0
	b .L65
.L74:
	lwz 0,4900(8)
	cmpwi 0,0,-1
	bc 4,1,.L65
	mr 3,31
	bl ChangeRightWeapon
	b .L65
.L76:
	cmpwi 0,27,-1
	bc 4,2,.L81
	lwz 9,92(8)
.L86:
	addi 9,9,1
	stw 9,92(8)
.L65:
	cmpwi 0,27,-1
	bc 12,2,.L79
.L81:
	lwz 9,84(31)
	stw 27,92(9)
.L79:
	cmpwi 0,26,-1
	bc 12,2,.L28
	lwz 9,84(31)
	stw 26,4664(9)
.L28:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Think_Chaingun,.Lfe2-Think_Chaingun
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
