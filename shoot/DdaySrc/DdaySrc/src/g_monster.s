	.file	"g_monster.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"infantry/inflies1.wav"
	.align 2
.LC3:
	.string	"players/cloth.wav"
	.align 2
.LC4:
	.string	"player/watr_out.wav"
	.align 2
.LC7:
	.string	"player/lava1.wav"
	.align 2
.LC8:
	.string	"player/lava2.wav"
	.align 2
.LC9:
	.string	"player/watr_in.wav"
	.align 3
.LC5:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC6:
	.long 0x46fffe00
	.align 2
.LC10:
	.long 0x41400000
	.align 3
.LC11:
	.long 0x40000000
	.long 0x0
	.align 2
.LC12:
	.long 0x3f800000
	.align 2
.LC13:
	.long 0x41100000
	.align 2
.LC14:
	.long 0x0
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC16:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl M_WorldEffects
	.type	 M_WorldEffects,@function
M_WorldEffects:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,484(31)
	cmpwi 0,0,0
	bc 4,1,.L23
	lwz 0,268(31)
	andi. 9,0,2
	bc 4,2,.L24
	lwz 0,620(31)
	cmpwi 0,0,2
	bc 12,1,.L31
	lis 10,.LC10@ha
	lis 9,level+4@ha
	la 10,.LC10@l(10)
	b .L53
.L24:
	lwz 0,620(31)
	cmpwi 0,0,0
	bc 4,1,.L31
	lis 10,.LC13@ha
	lis 9,level+4@ha
	la 10,.LC13@l(10)
.L53:
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,408(31)
	b .L23
.L31:
	lis 9,level@ha
	lfs 13,408(31)
	la 29,level@l(9)
	lfs 1,4(29)
	fcmpu 0,13,1
	bc 4,0,.L23
	lfs 0,468(31)
	fcmpu 0,0,1
	bc 4,0,.L23
	fsubs 1,1,13
	bl floor
	lis 9,.LC11@ha
	fadd 1,1,1
	la 9,.LC11@l(9)
	li 0,2
	lfd 13,0(9)
	lis 6,vec3_origin@ha
	mr 3,31
	lis 9,g_edicts@ha
	stw 0,8(1)
	la 6,vec3_origin@l(6)
	lwz 4,g_edicts@l(9)
	addi 7,31,4
	mr 8,6
	fadd 1,1,13
	li 9,17
	li 10,0
	stw 9,12(1)
	mr 5,4
	fctiwz 0,1
	stfd 0,24(1)
	lwz 11,28(1)
	cmpwi 7,11,16
	mfcr 9
	rlwinm 9,9,29,1
	neg 9,9
	nor 0,9,9
	and 9,11,9
	rlwinm 0,0,0,28,31
	or 9,9,0
	bl T_Damage
	lis 9,.LC12@ha
	lfs 0,4(29)
	la 9,.LC12@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,468(31)
.L23:
	lwz 8,620(31)
	cmpwi 0,8,0
	bc 4,2,.L36
	lwz 0,268(31)
	andi. 10,0,8
	bc 12,2,.L22
	lwz 0,616(31)
	andi. 11,0,8
	bc 12,2,.L38
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC12@ha
	lis 10,.LC12@ha
	lis 11,.LC14@ha
	mr 5,3
	la 9,.LC12@l(9)
	la 10,.LC12@l(10)
	mtlr 0
	la 11,.LC14@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L39
.L38:
	lis 29,gi@ha
	lis 3,.LC4@ha
	la 29,gi@l(29)
	la 3,.LC4@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC12@ha
	lis 10,.LC12@ha
	lis 11,.LC14@ha
	mr 5,3
	la 9,.LC12@l(9)
	la 10,.LC12@l(10)
	mtlr 0
	la 11,.LC14@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L39:
	lwz 0,268(31)
	rlwinm 0,0,0,29,27
	b .L54
.L36:
	lwz 0,616(31)
	andi. 9,0,8
	bc 12,2,.L40
	lwz 0,268(31)
	andi. 7,0,128
	bc 4,2,.L40
	lis 9,level+4@ha
	lfs 0,472(31)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L40
	fmr 0,13
	lis 11,.LC5@ha
	lis 10,g_edicts@ha
	stw 7,8(1)
	lfd 13,.LC5@l(11)
	lis 6,vec3_origin@ha
	li 0,19
	mulli 9,8,10
	lwz 4,g_edicts@l(10)
	la 6,vec3_origin@l(6)
	mr 3,31
	stw 0,12(1)
	addi 7,31,4
	mr 8,6
	fadd 0,0,13
	li 10,0
	mr 5,4
	frsp 0,0
	stfs 0,472(31)
	bl T_Damage
.L40:
	lwz 0,616(31)
	andi. 9,0,16
	bc 12,2,.L42
	lwz 0,268(31)
	andi. 10,0,64
	bc 4,2,.L42
	lis 9,level+4@ha
	lfs 0,472(31)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L42
	lis 11,.LC12@ha
	lwz 9,620(31)
	lis 6,vec3_origin@ha
	la 11,.LC12@l(11)
	li 0,18
	stw 10,8(1)
	lfs 0,0(11)
	la 6,vec3_origin@l(6)
	slwi 9,9,2
	lis 11,g_edicts@ha
	stw 0,12(1)
	mr 3,31
	lwz 4,g_edicts@l(11)
	addi 7,31,4
	mr 8,6
	fadds 0,13,0
	li 10,0
	mr 5,4
	stfs 0,472(31)
	bl T_Damage
.L42:
	lwz 0,268(31)
	andi. 9,0,8
	bc 4,2,.L22
	lwz 0,184(31)
	andi. 10,0,2
	bc 4,2,.L45
	lwz 0,616(31)
	andi. 11,0,8
	bc 12,2,.L46
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC15@ha
	lis 11,.LC6@ha
	la 10,.LC15@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC16@ha
	lfs 12,.LC6@l(11)
	la 10,.LC16@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,0
	bc 4,3,.L47
	lis 29,gi@ha
	lis 3,.LC7@ha
	la 29,gi@l(29)
	la 3,.LC7@l(3)
	b .L55
.L47:
	lis 29,gi@ha
	lis 3,.LC8@ha
	la 29,gi@l(29)
	la 3,.LC8@l(3)
	b .L55
.L46:
	andi. 9,0,16
	bc 12,2,.L50
	lis 29,gi@ha
	lis 3,.LC9@ha
	la 29,gi@l(29)
	la 3,.LC9@l(3)
.L55:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC12@ha
	lis 10,.LC12@ha
	lis 11,.LC14@ha
	mr 5,3
	la 9,.LC12@l(9)
	la 10,.LC12@l(10)
	mtlr 0
	la 11,.LC14@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L45
.L50:
	andi. 9,0,32
	bc 12,2,.L45
	lis 29,gi@ha
	lis 3,.LC9@ha
	la 29,gi@l(29)
	la 3,.LC9@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC12@ha
	lis 10,.LC12@ha
	lis 11,.LC14@ha
	mr 5,3
	la 9,.LC12@l(9)
	la 10,.LC12@l(10)
	mtlr 0
	la 11,.LC14@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L45:
	lwz 0,268(31)
	li 9,0
	stw 9,472(31)
	ori 0,0,8
.L54:
	stw 0,268(31)
.L22:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 M_WorldEffects,.Lfe1-M_WorldEffects
	.section	".rodata"
	.align 3
.LC17:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC18:
	.long 0x3f800000
	.align 2
.LC19:
	.long 0x43800000
	.align 2
.LC20:
	.long 0x42c80000
	.align 3
.LC21:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC22:
	.long 0x41d00000
	.align 2
.LC23:
	.long 0x41b00000
	.section	".text"
	.align 2
	.globl M_droptofloor
	.type	 M_droptofloor,@function
M_droptofloor:
	stwu 1,-208(1)
	mflr 0
	stfd 31,200(1)
	stmw 27,180(1)
	stw 0,212(1)
	lis 9,.LC18@ha
	mr 31,3
	la 9,.LC18@l(9)
	lfs 0,12(31)
	lis 11,.LC19@ha
	lfs 31,0(9)
	la 11,.LC19@l(11)
	addi 29,31,4
	lfs 12,4(31)
	lis 9,gi@ha
	addi 28,31,188
	lfs 13,8(31)
	la 30,gi@l(9)
	addi 27,31,200
	fadds 0,0,31
	lfs 11,0(11)
	lis 9,0x202
	addi 3,1,24
	stfs 12,8(1)
	mr 4,29
	mr 5,28
	stfs 13,12(1)
	mr 6,27
	addi 7,1,8
	stfs 0,12(31)
	mr 8,31
	ori 9,9,3
	lwz 11,48(30)
	fsubs 0,0,11
	mtlr 11
	stfs 0,16(1)
	blrl
	lfs 0,32(1)
	fcmpu 0,0,31
	bc 12,2,.L56
	lwz 0,24(1)
	cmpwi 0,0,0
	bc 4,2,.L56
	lfs 12,36(1)
	mr 3,31
	lfs 0,40(1)
	lfs 13,44(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	lwz 9,72(30)
	mtlr 9
	blrl
	lwz 0,268(31)
	andi. 0,0,3
	bc 4,2,.L60
	lis 9,.LC20@ha
	lfs 13,388(31)
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,1,.L68
	lfs 0,12(31)
	lis 11,.LC21@ha
	lis 9,0x202
	la 11,.LC21@l(11)
	lwz 0,48(30)
	ori 9,9,3
	lfd 11,0(11)
	mr 4,29
	mr 5,28
	lfs 13,8(31)
	mr 6,27
	addi 3,1,104
	lfs 12,4(31)
	addi 7,1,88
	mr 8,31
	mtlr 0
	fsub 0,0,11
	stfs 13,92(1)
	stfs 12,88(1)
	frsp 0,0
	stfs 0,96(1)
	blrl
	lfs 0,136(1)
	lis 9,.LC17@ha
	lfd 13,.LC17@l(9)
	fcmpu 0,0,13
	bc 4,0,.L62
	lwz 0,108(1)
	cmpwi 0,0,0
	bc 4,2,.L60
.L68:
	stw 0,560(31)
	b .L60
.L62:
	lwz 0,108(1)
	cmpwi 0,0,0
	bc 4,2,.L60
	lwz 0,104(1)
	cmpwi 0,0,0
	bc 4,2,.L60
	lfs 0,116(1)
	li 11,0
	lfs 13,120(1)
	lfs 12,124(1)
	lwz 9,156(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	stw 9,560(31)
	lwz 0,92(9)
	stw 11,388(31)
	stw 0,564(31)
.L60:
	lfs 12,196(31)
	lis 11,.LC18@ha
	lis 9,gi@ha
	lfs 13,12(31)
	la 11,.LC18@l(11)
	la 30,gi@l(9)
	lfs 11,0(11)
	addi 3,1,88
	lwz 9,52(30)
	fadds 13,13,12
	lfs 0,4(31)
	lfs 12,8(31)
	mtlr 9
	fadds 13,13,11
	stfs 0,88(1)
	stfs 12,92(1)
	stfs 13,96(1)
	blrl
	andi. 0,3,56
	bc 4,2,.L64
	stw 0,616(31)
	b .L69
.L64:
	lis 9,.LC22@ha
	lfs 0,96(1)
	li 0,1
	la 9,.LC22@l(9)
	stw 3,616(31)
	stw 0,620(31)
	addi 3,1,88
	lfs 13,0(9)
	lwz 9,52(30)
	fadds 0,0,13
	mtlr 9
	stfs 0,96(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L56
	lis 9,.LC23@ha
	lfs 0,96(1)
	li 0,2
	la 9,.LC23@l(9)
	stw 0,620(31)
	addi 3,1,88
	lfs 13,0(9)
	lwz 0,52(30)
	fadds 0,0,13
	mtlr 0
	stfs 0,96(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L56
	li 0,3
.L69:
	stw 0,620(31)
.L56:
	lwz 0,212(1)
	mtlr 0
	lmw 27,180(1)
	lfd 31,200(1)
	la 1,208(1)
	blr
.Lfe2:
	.size	 M_droptofloor,.Lfe2-M_droptofloor
	.section	".rodata"
	.align 3
.LC24:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC25:
	.long 0x0
	.section	".text"
	.align 2
	.globl M_MoveFrame
	.type	 M_MoveFrame,@function
M_MoveFrame:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,level+4@ha
	lis 11,.LC24@ha
	lfs 0,level+4@l(9)
	mr 31,3
	lfd 13,.LC24@l(11)
	lwz 9,824(31)
	lwz 30,816(31)
	cmpwi 0,9,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(31)
	bc 12,2,.L78
	lwz 0,0(30)
	cmpw 0,9,0
	bc 12,0,.L78
	lwz 0,4(30)
	cmpw 0,9,0
	bc 12,1,.L78
	li 0,0
	stw 9,56(31)
	stw 0,824(31)
	b .L79
.L78:
	lwz 9,56(31)
	lwz 0,4(30)
	cmpw 0,9,0
	bc 4,2,.L80
	lwz 0,12(30)
	cmpwi 0,0,0
	bc 12,2,.L80
	mtlr 0
	mr 3,31
	blrl
	lwz 0,184(31)
	lwz 30,816(31)
	andi. 9,0,2
	bc 4,2,.L77
.L80:
	lwz 9,56(31)
	lwz 0,0(30)
	cmpw 0,9,0
	bc 12,0,.L84
	lwz 0,4(30)
	cmpw 0,9,0
	bc 4,1,.L83
.L84:
	lwz 0,820(31)
	rlwinm 0,0,0,25,23
	stw 0,820(31)
	lwz 9,0(30)
	stw 9,56(31)
	b .L79
.L83:
	lwz 0,820(31)
	andi. 11,0,128
	bc 4,2,.L79
	addi 9,9,1
	stw 9,56(31)
	lwz 0,4(30)
	cmpw 0,9,0
	bc 4,1,.L79
	lwz 0,0(30)
	stw 0,56(31)
.L79:
	lwz 10,56(31)
	lwz 0,0(30)
	lwz 11,8(30)
	subf 29,0,10
	mulli 9,29,12
	lwzx 10,9,11
	add 9,9,11
	cmpwi 0,10,0
	bc 12,2,.L88
	lwz 0,820(31)
	andi. 11,0,128
	bc 4,2,.L89
	lfs 0,4(9)
	mr 3,31
	mtlr 10
	lfs 1,828(31)
	fmuls 1,0,1
	blrl
	b .L88
.L89:
	lis 9,.LC25@ha
	mr 3,31
	mtlr 10
	la 9,.LC25@l(9)
	lfs 1,0(9)
	blrl
.L88:
	lwz 0,8(30)
	mulli 9,29,12
	add 9,9,0
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 12,2,.L77
	mr 3,31
	mtlr 0
	blrl
.L77:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 M_MoveFrame,.Lfe3-M_MoveFrame
	.section	".rodata"
	.align 3
.LC26:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC27:
	.long 0x42c80000
	.align 3
.LC28:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC29:
	.long 0x3f800000
	.align 2
.LC30:
	.long 0x41d00000
	.align 2
.LC31:
	.long 0x41b00000
	.section	".text"
	.align 2
	.globl monster_think
	.type	 monster_think,@function
monster_think:
	stwu 1,-96(1)
	mflr 0
	stmw 30,88(1)
	stw 0,100(1)
	mr 31,3
	bl M_MoveFrame
	lwz 9,92(31)
	lis 11,gi@ha
	lwz 0,924(31)
	cmpw 0,9,0
	bc 12,2,.L93
	lwz 0,268(31)
	stw 9,924(31)
	andi. 0,0,3
	bc 4,2,.L93
	lis 9,.LC27@ha
	lfs 13,388(31)
	la 9,.LC27@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,1,.L110
	lfs 0,12(31)
	lis 10,.LC28@ha
	la 11,gi@l(11)
	la 10,.LC28@l(10)
	lwz 0,48(11)
	lis 9,0x202
	lfd 11,0(10)
	ori 9,9,3
	addi 3,1,24
	lfs 13,8(31)
	addi 4,31,4
	addi 5,31,188
	lfs 12,4(31)
	addi 6,31,200
	addi 7,1,8
	mtlr 0
	mr 8,31
	fsub 0,0,11
	stfs 13,12(1)
	stfs 12,8(1)
	frsp 0,0
	stfs 0,16(1)
	blrl
	lfs 0,56(1)
	lis 9,.LC26@ha
	lfd 13,.LC26@l(9)
	fcmpu 0,0,13
	bc 4,0,.L97
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L93
.L110:
	stw 0,560(31)
	b .L93
.L97:
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L93
	lwz 0,24(1)
	cmpwi 0,0,0
	bc 4,2,.L93
	lfs 0,36(1)
	li 11,0
	lfs 13,40(1)
	lfs 12,44(1)
	lwz 9,76(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	stw 9,560(31)
	lwz 0,92(9)
	stw 11,388(31)
	stw 0,564(31)
.L93:
	lfs 12,196(31)
	lis 10,.LC29@ha
	lis 9,gi@ha
	lfs 13,12(31)
	la 10,.LC29@l(10)
	la 30,gi@l(9)
	lfs 11,0(10)
	addi 3,1,8
	lwz 9,52(30)
	fadds 13,13,12
	lfs 0,4(31)
	lfs 12,8(31)
	mtlr 9
	fadds 13,13,11
	stfs 0,8(1)
	stfs 12,12(1)
	stfs 13,16(1)
	blrl
	andi. 0,3,56
	bc 4,2,.L99
	stw 0,616(31)
	b .L111
.L99:
	lis 9,.LC30@ha
	lfs 0,16(1)
	li 0,1
	la 9,.LC30@l(9)
	stw 3,616(31)
	stw 0,620(31)
	addi 3,1,8
	lfs 13,0(9)
	lwz 9,52(30)
	fadds 0,0,13
	mtlr 9
	stfs 0,16(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L100
	lis 9,.LC31@ha
	lfs 0,16(1)
	li 0,2
	la 9,.LC31@l(9)
	stw 0,620(31)
	addi 3,1,8
	lfs 13,0(9)
	lwz 0,52(30)
	fadds 0,0,13
	mtlr 0
	stfs 0,16(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L100
	li 0,3
.L111:
	stw 0,620(31)
.L100:
	mr 3,31
	bl M_WorldEffects
	lwz 0,820(31)
	lwz 9,64(31)
	lwz 11,68(31)
	andi. 10,0,16384
	rlwinm 0,9,0,24,21
	rlwinm 9,11,0,22,18
	stw 0,64(31)
	stw 9,68(31)
	bc 12,2,.L103
	ori 0,0,256
	ori 9,9,1024
	stw 0,64(31)
	stw 9,68(31)
.L103:
	lwz 0,484(31)
	cmpwi 0,0,0
	bc 4,1,.L105
	lis 9,level+4@ha
	lfs 13,504(31)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,1,.L105
	lwz 0,928(31)
	cmpwi 0,0,1
	bc 4,2,.L107
	lwz 0,64(31)
	ori 0,0,512
	stw 0,64(31)
	b .L105
.L107:
	cmpwi 0,0,2
	bc 4,2,.L105
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,2048
	stw 0,64(31)
	stw 9,68(31)
.L105:
	lwz 0,100(1)
	mtlr 0
	lmw 30,88(1)
	la 1,96(1)
	blr
.Lfe4:
	.size	 monster_think,.Lfe4-monster_think
	.section	".rodata"
	.align 2
.LC34:
	.string	"misc_insane"
	.align 2
.LC35:
	.string	"%s at %s has bad item: %s\n"
	.align 3
.LC33:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC36:
	.long 0x0
	.align 2
.LC37:
	.long 0x41400000
	.section	".text"
	.align 2
	.globl monster_start
	.type	 monster_start,@function
monster_start:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC36@ha
	lis 9,deathmatch@ha
	la 11,.LC36@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L128
	bl G_FreeEdict
	li 3,0
	b .L136
.L128:
	lwz 9,288(31)
	andi. 0,9,4
	bc 12,2,.L129
	lwz 0,820(31)
	andi. 11,0,256
	bc 4,2,.L130
	rlwinm 0,9,0,30,28
	ori 0,0,1
	stw 0,288(31)
.L129:
	lwz 0,820(31)
	andi. 9,0,256
	bc 4,2,.L130
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,288(11)
	addi 9,9,1
	stw 9,288(11)
.L130:
	lis 8,level@ha
	lis 9,.LC33@ha
	lwz 11,184(31)
	la 8,level@l(8)
	lfd 13,.LC33@l(9)
	li 7,1
	lfs 0,4(8)
	ori 11,11,4
	lis 9,.LC37@ha
	lwz 0,68(31)
	la 9,.LC37@l(9)
	lis 10,0x202
	stw 11,184(31)
	ori 10,10,3
	li 6,5120
	ori 0,0,64
	stw 7,516(31)
	rlwinm 11,11,0,31,29
	stw 0,68(31)
	li 7,0
	lis 4,.LC34@ha
	lfs 12,0(9)
	la 4,.LC34@l(4)
	fadd 0,0,13
	lwz 0,484(31)
	lis 9,monster_use@ha
	la 9,monster_use@l(9)
	lwz 3,284(31)
	frsp 0,0
	stfs 0,432(31)
	lfs 13,4(8)
	stw 9,452(31)
	stw 0,488(31)
	fadds 13,13,12
	stw 10,252(31)
	stw 7,496(31)
	stw 11,184(31)
	stfs 13,408(31)
	stw 6,984(31)
	stw 7,60(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L131
	lwz 0,984(31)
	ori 0,0,780
	stw 0,984(31)
.L131:
	lwz 0,868(31)
	cmpwi 0,0,0
	bc 4,2,.L132
	lis 9,M_CheckAttack@ha
	la 9,M_CheckAttack@l(9)
	stw 9,868(31)
.L132:
	lfs 12,4(31)
	lis 9,st@ha
	lfs 13,8(31)
	la 30,st@l(9)
	lfs 0,12(31)
	stfs 12,28(31)
	stfs 13,32(31)
	stfs 0,36(31)
	lwz 3,44(30)
	cmpwi 0,3,0
	bc 12,2,.L133
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,664(31)
	bc 4,2,.L133
	lis 29,gi@ha
	lwz 28,284(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC35@ha
	lwz 6,44(30)
	la 3,.LC35@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L133:
	lwz 0,816(31)
	cmpwi 0,0,0
	bc 12,2,.L135
	bl rand
	lwz 10,816(31)
	lwz 11,0(10)
	lwz 9,4(10)
	subf 9,11,9
	addi 9,9,1
	divw 0,3,9
	mullw 0,0,9
	subf 3,0,3
	add 11,11,3
	stw 11,56(31)
.L135:
	li 3,1
.L136:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 monster_start,.Lfe5-monster_start
	.section	".rodata"
	.align 2
.LC38:
	.string	"point_combat"
	.align 2
.LC39:
	.string	"%s at %s has target with mixed types\n"
	.align 2
.LC40:
	.string	"%s at (%i %i %i) has a bad combattarget %s : %s at (%i %i %i)\n"
	.align 2
.LC41:
	.string	"%s can't find target %s at %s\n"
	.align 2
.LC43:
	.string	"path_corner"
	.align 2
.LC42:
	.long 0x4cbebc20
	.align 3
.LC44:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl monster_start_go
	.type	 monster_start_go,@function
monster_start_go:
	stwu 1,-64(1)
	mflr 0
	stmw 26,40(1)
	stw 0,68(1)
	mr 31,3
	lwz 0,484(31)
	cmpwi 0,0,0
	bc 4,1,.L137
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L139
	li 30,0
	li 29,0
	li 27,0
	b .L140
.L142:
	lwz 3,284(30)
	lis 4,.LC38@ha
	la 4,.LC38@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L143
	lwz 0,300(31)
	li 27,1
	stw 0,324(31)
	b .L140
.L143:
	li 29,1
.L140:
	lwz 5,300(31)
	mr 3,30
	li 4,304
	bl G_Find
	mr. 30,3
	bc 4,2,.L142
	cmpwi 0,29,0
	bc 12,2,.L146
	lwz 0,324(31)
	cmpwi 0,0,0
	bc 12,2,.L146
	lis 29,gi@ha
	lwz 28,284(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC39@ha
	la 3,.LC39@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L146:
	cmpwi 0,27,0
	bc 12,2,.L139
	li 0,0
	stw 0,300(31)
.L139:
	lwz 0,324(31)
	cmpwi 0,0,0
	bc 12,2,.L148
	lis 9,gi@ha
	li 30,0
	la 26,gi@l(9)
	lis 27,.LC38@ha
	lis 28,.LC40@ha
	b .L149
.L151:
	lwz 3,284(30)
	la 4,.LC38@l(27)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L149
	lfs 13,4(31)
	la 3,.LC40@l(28)
	lfs 0,8(31)
	mr 6,5
	mr 7,5
	lfs 12,12(31)
	mr 10,5
	mr 11,5
	lfs 11,4(30)
	mr 29,5
	lfs 10,8(30)
	lwz 9,284(30)
	fctiwz 9,13
	lwz 4,284(31)
	fctiwz 8,0
	lwz 8,324(31)
	lwz 12,4(26)
	stfd 9,32(1)
	fctiwz 7,12
	lwz 5,36(1)
	mtlr 12
	stfd 8,32(1)
	fctiwz 5,11
	lwz 6,36(1)
	stfd 7,32(1)
	fctiwz 6,10
	lwz 7,36(1)
	stfd 5,32(1)
	lwz 10,36(1)
	stfd 6,32(1)
	lwz 11,36(1)
	stw 11,8(1)
	lfs 0,12(30)
	fctiwz 4,0
	stfd 4,32(1)
	lwz 29,36(1)
	stw 29,12(1)
	crxor 6,6,6
	blrl
.L149:
	lwz 5,324(31)
	mr 3,30
	li 4,304
	bl G_Find
	mr. 30,3
	bc 4,2,.L151
.L148:
	lwz 3,300(31)
	cmpwi 0,3,0
	bc 12,2,.L154
	bl G_PickTarget
	mr 30,3
	cmpwi 0,30,0
	stw 30,420(31)
	stw 30,416(31)
	bc 4,2,.L155
	lis 29,gi@ha
	lwz 27,284(31)
	addi 3,31,4
	la 29,gi@l(29)
	lwz 28,300(31)
	bl vtos
	mr 6,3
	lwz 0,4(29)
	mr 4,27
	lis 3,.LC41@ha
	mr 5,28
	la 3,.LC41@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,832(31)
	lis 9,.LC42@ha
	mr 3,31
	lfs 0,.LC42@l(9)
	stw 30,300(31)
	mtlr 11
	b .L160
.L155:
	lwz 3,284(30)
	lis 4,.LC43@ha
	la 4,.LC43@l(4)
	bl strcmp
	mr. 30,3
	bc 4,2,.L157
	lwz 9,416(31)
	addi 3,1,16
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,16(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,20(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,24(1)
	bl vectoyaw
	lwz 9,844(31)
	mr 3,31
	stfs 1,428(31)
	mtlr 9
	stfs 1,20(31)
	blrl
	stw 30,300(31)
	b .L159
.L157:
	lwz 11,832(31)
	lis 9,.LC42@ha
	mr 3,31
	lfs 0,.LC42@l(9)
	li 0,0
	mtlr 11
	stw 0,416(31)
	stw 0,420(31)
.L160:
	stfs 0,872(31)
	blrl
	b .L159
.L154:
	lwz 11,832(31)
	lis 9,.LC42@ha
	mr 3,31
	lfs 0,.LC42@l(9)
	mtlr 11
	stfs 0,872(31)
	blrl
.L159:
	lis 9,monster_think@ha
	lis 10,level+4@ha
	la 9,monster_think@l(9)
	lis 11,.LC44@ha
	stw 9,440(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC44@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(31)
.L137:
	lwz 0,68(1)
	mtlr 0
	lmw 26,40(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 monster_start_go,.Lfe6-monster_start_go
	.section	".rodata"
	.align 2
.LC45:
	.string	"%s in solid at %s\n"
	.comm	is_silenced,1,1
	.section	".text"
	.align 2
	.globl walkmonster_start
	.type	 walkmonster_start,@function
walkmonster_start:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,walkmonster_start_go@ha
	mr 11,3
	la 9,walkmonster_start_go@l(9)
	stw 9,440(11)
	bl monster_start
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 walkmonster_start,.Lfe7-walkmonster_start
	.align 2
	.globl swimmonster_start
	.type	 swimmonster_start,@function
swimmonster_start:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 11,swimmonster_start_go@ha
	lwz 0,268(9)
	la 11,swimmonster_start_go@l(11)
	stw 11,440(9)
	ori 0,0,2
	stw 0,268(9)
	bl monster_start
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 swimmonster_start,.Lfe8-swimmonster_start
	.align 2
	.globl flymonster_start
	.type	 flymonster_start,@function
flymonster_start:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 11,flymonster_start_go@ha
	lwz 0,268(9)
	la 11,flymonster_start_go@l(11)
	stw 11,440(9)
	ori 0,0,1
	stw 0,268(9)
	bl monster_start
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 flymonster_start,.Lfe9-flymonster_start
	.align 2
	.globl AttackFinished
	.type	 AttackFinished,@function
AttackFinished:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,1
	stfs 0,876(3)
	blr
.Lfe10:
	.size	 AttackFinished,.Lfe10-AttackFinished
	.align 2
	.globl monster_death_use
	.type	 monster_death_use,@function
monster_death_use:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 4,664(31)
	lwz 0,268(31)
	lwz 9,820(31)
	cmpwi 0,4,0
	rlwinm 0,0,0,0,29
	rlwinm 9,9,0,23,23
	stw 0,268(31)
	stw 9,820(31)
	bc 12,2,.L124
	bl Drop_Item
	li 0,0
	stw 0,664(31)
.L124:
	lwz 0,320(31)
	cmpwi 0,0,0
	bc 12,2,.L125
	stw 0,300(31)
.L125:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L123
	mr 3,31
	lwz 4,548(3)
	bl G_UseTargets
.L123:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 monster_death_use,.Lfe11-monster_death_use
	.section	".rodata"
	.align 2
.LC46:
	.long 0x3f800000
	.align 2
.LC47:
	.long 0x41d00000
	.align 2
.LC48:
	.long 0x41b00000
	.section	".text"
	.align 2
	.globl M_CatagorizePosition
	.type	 M_CatagorizePosition,@function
M_CatagorizePosition:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	lis 9,gi@ha
	lfs 12,196(31)
	la 30,gi@l(9)
	addi 3,1,8
	lfs 0,12(31)
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 13,4(31)
	lfs 11,0(9)
	fadds 0,0,12
	lwz 9,52(30)
	lfs 12,8(31)
	mtlr 9
	stfs 13,8(1)
	fadds 0,0,11
	stfs 12,12(1)
	stfs 0,16(1)
	blrl
	andi. 0,3,56
	bc 4,2,.L19
	stw 0,616(31)
	b .L180
.L19:
	lis 9,.LC47@ha
	lfs 0,16(1)
	li 0,1
	la 9,.LC47@l(9)
	stw 3,616(31)
	stw 0,620(31)
	addi 3,1,8
	lfs 13,0(9)
	lwz 9,52(30)
	fadds 0,0,13
	mtlr 9
	stfs 0,16(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L18
	lis 9,.LC48@ha
	lfs 0,16(1)
	li 0,2
	la 9,.LC48@l(9)
	stw 0,620(31)
	addi 3,1,8
	lfs 13,0(9)
	lwz 0,52(30)
	fadds 0,0,13
	mtlr 0
	stfs 0,16(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L18
	li 0,3
.L180:
	stw 0,620(31)
.L18:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 M_CatagorizePosition,.Lfe12-M_CatagorizePosition
	.section	".rodata"
	.align 2
.LC49:
	.long 0x46fffe00
	.align 3
.LC50:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC51:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC52:
	.long 0x40a00000
	.align 2
.LC53:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl M_FlyCheck
	.type	 M_FlyCheck,@function
M_FlyCheck:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 30,24(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,620(31)
	cmpwi 0,0,0
	bc 4,2,.L9
	bl rand
	lis 30,0x4330
	lis 9,.LC50@ha
	rlwinm 3,3,0,17,31
	la 9,.LC50@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC49@ha
	lis 10,.LC51@ha
	lfs 30,.LC49@l(11)
	la 10,.LC51@l(10)
	stw 3,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	lfd 12,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 12,1,.L9
	lis 9,M_FliesOn@ha
	la 9,M_FliesOn@l(9)
	stw 9,440(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC52@ha
	stw 3,20(1)
	la 10,.LC52@l(10)
	lis 11,level+4@ha
	stw 30,16(1)
	lfd 0,16(1)
	lfs 12,0(10)
	lfs 13,level+4@l(11)
	lis 10,.LC53@ha
	fsub 0,0,31
	la 10,.LC53@l(10)
	lfs 11,0(10)
	fadds 13,13,12
	frsp 0,0
	fdivs 0,0,30
	fmadds 0,0,11,13
	stfs 0,432(31)
.L9:
	lwz 0,52(1)
	mtlr 0
	lmw 30,24(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 M_FlyCheck,.Lfe13-M_FlyCheck
	.section	".rodata"
	.align 3
.LC54:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC55:
	.long 0x42c80000
	.align 3
.LC56:
	.long 0x3fd00000
	.long 0x0
	.section	".text"
	.align 2
	.globl M_CheckGround
	.type	 M_CheckGround,@function
M_CheckGround:
	stwu 1,-96(1)
	mflr 0
	stw 31,92(1)
	stw 0,100(1)
	mr 31,3
	lwz 0,268(31)
	andi. 0,0,3
	bc 4,2,.L13
	lis 9,.LC55@ha
	lfs 13,388(31)
	la 9,.LC55@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,1,.L181
	lfs 0,12(31)
	lis 9,.LC56@ha
	lis 11,gi+48@ha
	la 9,.LC56@l(9)
	lwz 0,gi+48@l(11)
	addi 3,1,24
	lfd 11,0(9)
	addi 4,31,4
	addi 5,31,188
	lis 9,0x202
	lfs 13,8(31)
	addi 6,31,200
	lfs 12,4(31)
	ori 9,9,3
	addi 7,1,8
	mtlr 0
	mr 8,31
	fsub 0,0,11
	stfs 13,12(1)
	stfs 12,8(1)
	frsp 0,0
	stfs 0,16(1)
	blrl
	lfs 0,56(1)
	lis 9,.LC54@ha
	lfd 13,.LC54@l(9)
	fcmpu 0,0,13
	bc 4,0,.L16
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L13
.L181:
	stw 0,560(31)
	b .L13
.L16:
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L13
	lwz 0,24(1)
	cmpwi 0,0,0
	bc 4,2,.L13
	lfs 0,36(1)
	li 11,0
	lfs 13,40(1)
	lfs 12,44(1)
	lwz 9,76(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	stw 9,560(31)
	lwz 0,92(9)
	stw 11,388(31)
	stw 0,564(31)
.L13:
	lwz 0,100(1)
	mtlr 0
	lwz 31,92(1)
	la 1,96(1)
	blr
.Lfe14:
	.size	 M_CheckGround,.Lfe14-M_CheckGround
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.section	".rodata"
	.align 2
.LC57:
	.long 0x42700000
	.section	".text"
	.align 2
	.type	 M_FliesOn,@function
M_FliesOn:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,620(31)
	cmpwi 0,0,0
	bc 4,2,.L7
	lwz 0,64(31)
	lis 9,gi+36@ha
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	ori 0,0,16384
	stw 0,64(31)
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
	lis 9,M_FliesOff@ha
	lis 10,.LC57@ha
	stw 3,76(31)
	la 9,M_FliesOff@l(9)
	lis 11,level+4@ha
	la 10,.LC57@l(10)
	stw 9,440(31)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,432(31)
.L7:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe15:
	.size	 M_FliesOn,.Lfe15-M_FliesOn
	.align 2
	.globl M_SetEffects
	.type	 M_SetEffects,@function
M_SetEffects:
	lwz 0,820(3)
	lwz 9,64(3)
	lwz 11,68(3)
	andi. 10,0,16384
	rlwinm 0,9,0,24,21
	rlwinm 9,11,0,22,18
	stw 0,64(3)
	stw 9,68(3)
	bc 12,2,.L71
	ori 0,0,256
	ori 9,9,1024
	stw 0,64(3)
	stw 9,68(3)
.L71:
	lwz 0,484(3)
	cmpwi 0,0,0
	bclr 4,1
	lis 9,level+4@ha
	lfs 13,504(3)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bclr 4,1
	lwz 0,928(3)
	cmpwi 0,0,1
	bc 4,2,.L74
	lwz 0,64(3)
	ori 0,0,512
	stw 0,64(3)
	blr
.L74:
	cmpwi 0,0,2
	bclr 4,2
	lwz 0,64(3)
	lwz 9,68(3)
	ori 0,0,256
	ori 9,9,2048
	stw 0,64(3)
	stw 9,68(3)
	blr
.Lfe16:
	.size	 M_SetEffects,.Lfe16-M_SetEffects
	.align 2
	.globl monster_use
	.type	 monster_use,@function
monster_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,548(3)
	cmpwi 0,0,0
	bc 4,2,.L112
	lwz 0,484(3)
	cmpwi 0,0,0
	bc 4,1,.L112
	lwz 0,268(5)
	andi. 9,0,32
	bc 4,2,.L112
	lwz 0,84(5)
	cmpwi 0,0,0
	bc 4,2,.L116
	lwz 0,820(5)
	andi. 9,0,256
	bc 12,2,.L112
.L116:
	stw 5,548(3)
	bl FoundTarget
.L112:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 monster_use,.Lfe17-monster_use
	.section	".rodata"
	.align 2
.LC58:
	.long 0x3f800000
	.align 2
.LC59:
	.long 0x41400000
	.section	".text"
	.align 2
	.globl monster_triggered_spawn
	.type	 monster_triggered_spawn,@function
monster_triggered_spawn:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,.LC58@ha
	mr 31,3
	la 9,.LC58@l(9)
	lfs 0,12(31)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(31)
	bl KillBox
	lwz 9,184(31)
	li 11,5
	li 0,2
	lis 10,.LC59@ha
	stw 11,264(31)
	lis 8,level+4@ha
	rlwinm 9,9,0,0,30
	stw 0,248(31)
	la 10,.LC59@l(10)
	stw 9,184(31)
	mr 3,31
	lfs 13,0(10)
	lfs 0,level+4@l(8)
	lis 10,gi+72@ha
	fadds 0,0,13
	stfs 0,408(31)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	mr 3,31
	bl monster_start_go
	lwz 9,548(31)
	cmpwi 0,9,0
	bc 12,2,.L118
	lwz 0,288(31)
	andi. 10,0,1
	bc 4,2,.L118
	lwz 0,268(9)
	andi. 11,0,32
	bc 4,2,.L118
	mr 3,31
	bl FoundTarget
	b .L119
.L118:
	li 0,0
	stw 0,548(31)
.L119:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe18:
	.size	 monster_triggered_spawn,.Lfe18-monster_triggered_spawn
	.section	".rodata"
	.align 3
.LC60:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl monster_triggered_spawn_use
	.type	 monster_triggered_spawn_use,@function
monster_triggered_spawn_use:
	lis 9,monster_triggered_spawn@ha
	lis 10,level+4@ha
	la 9,monster_triggered_spawn@l(9)
	lis 11,.LC60@ha
	stw 9,440(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC60@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(3)
	lwz 0,84(5)
	cmpwi 0,0,0
	bc 12,2,.L121
	stw 5,548(3)
.L121:
	lis 9,monster_use@ha
	la 9,monster_use@l(9)
	stw 9,452(3)
	blr
.Lfe19:
	.size	 monster_triggered_spawn_use,.Lfe19-monster_triggered_spawn_use
	.align 2
	.globl monster_triggered_start
	.type	 monster_triggered_start,@function
monster_triggered_start:
	lwz 0,184(3)
	lis 9,monster_triggered_spawn_use@ha
	li 11,0
	la 9,monster_triggered_spawn_use@l(9)
	li 10,0
	stw 11,264(3)
	ori 0,0,1
	stw 9,452(3)
	stw 0,184(3)
	stw 10,432(3)
	stw 11,248(3)
	blr
.Lfe20:
	.size	 monster_triggered_start,.Lfe20-monster_triggered_start
	.section	".rodata"
	.align 2
.LC61:
	.long 0x3f800000
	.align 2
.LC62:
	.long 0x0
	.section	".text"
	.align 2
	.globl walkmonster_start_go
	.type	 walkmonster_start_go,@function
walkmonster_start_go:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,288(31)
	andi. 9,0,2
	bc 4,2,.L162
	lis 11,.LC61@ha
	lis 9,level+4@ha
	la 11,.LC61@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,0,.L162
	bl M_droptofloor
	lwz 0,560(31)
	cmpwi 0,0,0
	bc 12,2,.L162
	lis 9,.LC62@ha
	lis 11,.LC62@ha
	la 9,.LC62@l(9)
	la 11,.LC62@l(11)
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(11)
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L162
	lis 29,gi@ha
	lwz 28,284(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC45@ha
	la 3,.LC45@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L162:
	lis 9,.LC62@ha
	lfs 0,424(31)
	la 9,.LC62@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L165
	lis 0,0x41a0
	stw 0,424(31)
.L165:
	li 0,25
	mr 3,31
	stw 0,512(31)
	bl monster_start_go
	lwz 0,288(31)
	andi. 9,0,2
	bc 12,2,.L166
	lwz 0,184(31)
	lis 9,monster_triggered_spawn_use@ha
	li 11,0
	la 9,monster_triggered_spawn_use@l(9)
	stw 11,264(31)
	ori 0,0,1
	stw 9,452(31)
	stw 0,184(31)
	stfs 31,432(31)
	stw 11,248(31)
.L166:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 walkmonster_start_go,.Lfe21-walkmonster_start_go
	.section	".rodata"
	.align 2
.LC63:
	.long 0x0
	.section	".text"
	.align 2
	.globl flymonster_start_go
	.type	 flymonster_start_go,@function
flymonster_start_go:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	lis 9,.LC63@ha
	mr 31,3
	la 9,.LC63@l(9)
	lfs 1,0(9)
	lis 9,.LC63@ha
	la 9,.LC63@l(9)
	lfs 2,0(9)
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L170
	lis 29,gi@ha
	lwz 28,284(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC45@ha
	la 3,.LC45@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L170:
	lis 9,.LC63@ha
	lfs 0,424(31)
	la 9,.LC63@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L171
	lis 0,0x4120
	stw 0,424(31)
.L171:
	li 0,25
	mr 3,31
	stw 0,512(31)
	bl monster_start_go
	lwz 0,288(31)
	andi. 9,0,2
	bc 12,2,.L172
	lwz 0,184(31)
	lis 9,monster_triggered_spawn_use@ha
	li 11,0
	la 9,monster_triggered_spawn_use@l(9)
	stw 11,264(31)
	ori 0,0,1
	stw 9,452(31)
	stw 0,184(31)
	stfs 31,432(31)
	stw 11,248(31)
.L172:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 flymonster_start_go,.Lfe22-flymonster_start_go
	.section	".rodata"
	.align 2
.LC64:
	.long 0x0
	.section	".text"
	.align 2
	.globl swimmonster_start_go
	.type	 swimmonster_start_go,@function
swimmonster_start_go:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 31,20(1)
	stw 0,36(1)
	lis 9,.LC64@ha
	mr 31,3
	la 9,.LC64@l(9)
	lfs 0,424(31)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L176
	lis 0,0x4120
	stw 0,424(31)
.L176:
	li 0,10
	mr 3,31
	stw 0,512(31)
	bl monster_start_go
	lwz 0,288(31)
	andi. 9,0,2
	bc 12,2,.L177
	lwz 0,184(31)
	lis 9,monster_triggered_spawn_use@ha
	li 11,0
	la 9,monster_triggered_spawn_use@l(9)
	stw 11,264(31)
	ori 0,0,1
	stw 9,452(31)
	stw 0,184(31)
	stfs 31,432(31)
	stw 11,248(31)
.L177:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 swimmonster_start_go,.Lfe23-swimmonster_start_go
	.align 2
	.type	 M_FliesOff,@function
M_FliesOff:
	lwz 0,64(3)
	li 9,0
	stw 9,76(3)
	rlwinm 0,0,0,18,16
	stw 0,64(3)
	blr
.Lfe24:
	.size	 M_FliesOff,.Lfe24-M_FliesOff
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
