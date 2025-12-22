	.file	"g_monster.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"infantry/inflies1.wav"
	.align 2
.LC3:
	.string	"player/watr_out.wav"
	.align 2
.LC6:
	.string	"player/lava1.wav"
	.align 2
.LC7:
	.string	"player/lava2.wav"
	.align 2
.LC8:
	.string	"player/watr_in.wav"
	.align 3
.LC4:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC5:
	.long 0x46fffe00
	.align 2
.LC9:
	.long 0x41400000
	.align 3
.LC10:
	.long 0x40000000
	.long 0x0
	.align 2
.LC11:
	.long 0x3f800000
	.align 2
.LC12:
	.long 0x41100000
	.align 2
.LC13:
	.long 0x0
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC15:
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
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L30
	lwz 0,264(31)
	andi. 9,0,2
	bc 4,2,.L31
	lwz 0,612(31)
	cmpwi 0,0,2
	bc 12,1,.L38
	lis 10,.LC9@ha
	lis 9,level+4@ha
	la 10,.LC9@l(10)
	b .L58
.L31:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,1,.L38
	lis 10,.LC12@ha
	lis 9,level+4@ha
	la 10,.LC12@l(10)
.L58:
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,404(31)
	b .L30
.L38:
	lis 9,level@ha
	lfs 13,404(31)
	la 29,level@l(9)
	lfs 1,4(29)
	fcmpu 0,13,1
	bc 4,0,.L30
	lfs 0,464(31)
	fcmpu 0,0,1
	bc 4,0,.L30
	fsubs 1,1,13
	bl floor
	lis 9,.LC10@ha
	fadd 1,1,1
	la 9,.LC10@l(9)
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
	lis 9,.LC11@ha
	lfs 0,4(29)
	la 9,.LC11@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,464(31)
.L30:
	lwz 8,612(31)
	cmpwi 0,8,0
	bc 4,2,.L43
	lwz 0,264(31)
	andi. 10,0,8
	bc 12,2,.L29
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC11@ha
	lis 10,.LC11@ha
	lis 11,.LC13@ha
	mr 5,3
	la 9,.LC11@l(9)
	la 10,.LC11@l(10)
	mtlr 0
	la 11,.LC13@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	lwz 0,264(31)
	rlwinm 0,0,0,29,27
	b .L59
.L43:
	lwz 0,608(31)
	andi. 9,0,8
	bc 12,2,.L45
	lwz 0,264(31)
	andi. 7,0,128
	bc 4,2,.L45
	lis 9,level+4@ha
	lfs 0,468(31)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L45
	fmr 0,13
	lis 11,.LC4@ha
	lis 10,g_edicts@ha
	stw 7,8(1)
	lfd 13,.LC4@l(11)
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
	stfs 0,468(31)
	bl T_Damage
.L45:
	lwz 0,608(31)
	andi. 9,0,16
	bc 12,2,.L47
	lwz 0,264(31)
	andi. 10,0,64
	bc 4,2,.L47
	lis 9,level+4@ha
	lfs 0,468(31)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L47
	lis 11,.LC11@ha
	lwz 9,612(31)
	lis 6,vec3_origin@ha
	la 11,.LC11@l(11)
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
	stfs 0,468(31)
	bl T_Damage
.L47:
	lwz 0,264(31)
	andi. 9,0,8
	bc 4,2,.L29
	lwz 0,184(31)
	andi. 10,0,2
	bc 4,2,.L50
	lwz 0,608(31)
	andi. 11,0,8
	bc 12,2,.L51
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC14@ha
	lis 11,.LC5@ha
	la 10,.LC14@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC15@ha
	lfs 12,.LC5@l(11)
	la 10,.LC15@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,0
	bc 4,3,.L52
	lis 29,gi@ha
	lis 3,.LC6@ha
	la 29,gi@l(29)
	la 3,.LC6@l(3)
	b .L60
.L52:
	lis 29,gi@ha
	lis 3,.LC7@ha
	la 29,gi@l(29)
	la 3,.LC7@l(3)
	b .L60
.L51:
	andi. 9,0,16
	bc 12,2,.L55
	lis 29,gi@ha
	lis 3,.LC8@ha
	la 29,gi@l(29)
	la 3,.LC8@l(3)
.L60:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC11@ha
	lis 10,.LC11@ha
	lis 11,.LC13@ha
	mr 5,3
	la 9,.LC11@l(9)
	la 10,.LC11@l(10)
	mtlr 0
	la 11,.LC13@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L50
.L55:
	andi. 9,0,32
	bc 12,2,.L50
	lis 29,gi@ha
	lis 3,.LC8@ha
	la 29,gi@l(29)
	la 3,.LC8@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC11@ha
	lis 10,.LC11@ha
	lis 11,.LC13@ha
	mr 5,3
	la 9,.LC11@l(9)
	la 10,.LC11@l(10)
	mtlr 0
	la 11,.LC13@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L50:
	lwz 0,264(31)
	li 9,0
	stw 9,468(31)
	ori 0,0,8
.L59:
	stw 0,264(31)
.L29:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 M_WorldEffects,.Lfe1-M_WorldEffects
	.section	".rodata"
	.align 3
.LC16:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC17:
	.long 0x3f800000
	.align 2
.LC18:
	.long 0x43800000
	.align 2
.LC19:
	.long 0x42c80000
	.align 3
.LC20:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC21:
	.long 0x41d00000
	.align 2
.LC22:
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
	lis 9,.LC17@ha
	mr 31,3
	la 9,.LC17@l(9)
	lfs 0,12(31)
	lis 11,.LC18@ha
	lfs 31,0(9)
	la 11,.LC18@l(11)
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
	bc 12,2,.L61
	lwz 0,24(1)
	cmpwi 0,0,0
	bc 4,2,.L61
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
	lwz 0,264(31)
	andi. 0,0,3
	bc 4,2,.L65
	lis 9,.LC19@ha
	lfs 13,384(31)
	la 9,.LC19@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,1,.L73
	lfs 0,12(31)
	lis 11,.LC20@ha
	lis 9,0x202
	la 11,.LC20@l(11)
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
	lis 9,.LC16@ha
	lfd 13,.LC16@l(9)
	fcmpu 0,0,13
	bc 4,0,.L67
	lwz 0,108(1)
	cmpwi 0,0,0
	bc 4,2,.L65
.L73:
	stw 0,552(31)
	b .L65
.L67:
	lwz 0,108(1)
	cmpwi 0,0,0
	bc 4,2,.L65
	lwz 0,104(1)
	cmpwi 0,0,0
	bc 4,2,.L65
	lfs 0,116(1)
	li 11,0
	lfs 13,120(1)
	lfs 12,124(1)
	lwz 9,156(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	stw 9,552(31)
	lwz 0,92(9)
	stw 11,384(31)
	stw 0,556(31)
.L65:
	lfs 12,196(31)
	lis 11,.LC17@ha
	lis 9,gi@ha
	lfs 13,12(31)
	la 11,.LC17@l(11)
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
	bc 4,2,.L69
	stw 0,608(31)
	b .L74
.L69:
	lis 9,.LC21@ha
	lfs 0,96(1)
	li 0,1
	la 9,.LC21@l(9)
	stw 3,608(31)
	stw 0,612(31)
	addi 3,1,88
	lfs 13,0(9)
	lwz 9,52(30)
	fadds 0,0,13
	mtlr 9
	stfs 0,96(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L61
	lis 9,.LC22@ha
	lfs 0,96(1)
	li 0,2
	la 9,.LC22@l(9)
	stw 0,612(31)
	addi 3,1,88
	lfs 13,0(9)
	lwz 0,52(30)
	fadds 0,0,13
	mtlr 0
	stfs 0,96(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L61
	li 0,3
.L74:
	stw 0,612(31)
.L61:
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
.LC23:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC24:
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
	lis 11,.LC23@ha
	lfs 0,level+4@l(9)
	mr 31,3
	lfd 13,.LC23@l(11)
	lwz 9,780(31)
	lwz 30,772(31)
	cmpwi 0,9,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 12,2,.L83
	lwz 0,0(30)
	cmpw 0,9,0
	bc 12,0,.L83
	lwz 0,4(30)
	cmpw 0,9,0
	bc 12,1,.L83
	li 0,0
	stw 9,56(31)
	stw 0,780(31)
	b .L84
.L83:
	lwz 9,56(31)
	lwz 0,4(30)
	cmpw 0,9,0
	bc 4,2,.L85
	lwz 0,12(30)
	cmpwi 0,0,0
	bc 12,2,.L85
	mtlr 0
	mr 3,31
	blrl
	lwz 0,184(31)
	lwz 30,772(31)
	andi. 9,0,2
	bc 4,2,.L82
.L85:
	lwz 9,56(31)
	lwz 0,0(30)
	cmpw 0,9,0
	bc 12,0,.L89
	lwz 0,4(30)
	cmpw 0,9,0
	bc 4,1,.L88
.L89:
	lwz 0,776(31)
	rlwinm 0,0,0,25,23
	stw 0,776(31)
	lwz 9,0(30)
	stw 9,56(31)
	b .L84
.L88:
	lwz 0,776(31)
	andi. 11,0,128
	bc 4,2,.L84
	addi 9,9,1
	stw 9,56(31)
	lwz 0,4(30)
	cmpw 0,9,0
	bc 4,1,.L84
	lwz 0,0(30)
	stw 0,56(31)
.L84:
	lwz 10,56(31)
	lwz 0,0(30)
	lwz 11,8(30)
	subf 29,0,10
	mulli 9,29,12
	lwzx 10,9,11
	add 9,9,11
	cmpwi 0,10,0
	bc 12,2,.L93
	lwz 0,776(31)
	andi. 11,0,128
	bc 4,2,.L94
	lfs 0,4(9)
	mr 3,31
	mtlr 10
	lfs 1,784(31)
	fmuls 1,0,1
	blrl
	b .L93
.L94:
	lis 9,.LC24@ha
	mr 3,31
	mtlr 10
	la 9,.LC24@l(9)
	lfs 1,0(9)
	blrl
.L93:
	lwz 0,8(30)
	mulli 9,29,12
	add 9,9,0
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 12,2,.L82
	mr 3,31
	mtlr 0
	blrl
.L82:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 M_MoveFrame,.Lfe3-M_MoveFrame
	.section	".rodata"
	.align 3
.LC25:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC26:
	.long 0x42c80000
	.align 3
.LC27:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC28:
	.long 0x3f800000
	.align 2
.LC29:
	.long 0x41d00000
	.align 2
.LC30:
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
	lwz 0,880(31)
	cmpw 0,9,0
	bc 12,2,.L98
	lwz 0,264(31)
	stw 9,880(31)
	andi. 0,0,3
	bc 4,2,.L98
	lis 9,.LC26@ha
	lfs 13,384(31)
	la 9,.LC26@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,1,.L115
	lfs 0,12(31)
	lis 10,.LC27@ha
	la 11,gi@l(11)
	la 10,.LC27@l(10)
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
	lis 9,.LC25@ha
	lfd 13,.LC25@l(9)
	fcmpu 0,0,13
	bc 4,0,.L102
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L98
.L115:
	stw 0,552(31)
	b .L98
.L102:
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L98
	lwz 0,24(1)
	cmpwi 0,0,0
	bc 4,2,.L98
	lfs 0,36(1)
	li 11,0
	lfs 13,40(1)
	lfs 12,44(1)
	lwz 9,76(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	stw 9,552(31)
	lwz 0,92(9)
	stw 11,384(31)
	stw 0,556(31)
.L98:
	lfs 12,196(31)
	lis 10,.LC28@ha
	lis 9,gi@ha
	lfs 13,12(31)
	la 10,.LC28@l(10)
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
	bc 4,2,.L104
	stw 0,608(31)
	b .L116
.L104:
	lis 9,.LC29@ha
	lfs 0,16(1)
	li 0,1
	la 9,.LC29@l(9)
	stw 3,608(31)
	stw 0,612(31)
	addi 3,1,8
	lfs 13,0(9)
	lwz 9,52(30)
	fadds 0,0,13
	mtlr 9
	stfs 0,16(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L105
	lis 9,.LC30@ha
	lfs 0,16(1)
	li 0,2
	la 9,.LC30@l(9)
	stw 0,612(31)
	addi 3,1,8
	lfs 13,0(9)
	lwz 0,52(30)
	fadds 0,0,13
	mtlr 0
	stfs 0,16(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L105
	li 0,3
.L116:
	stw 0,612(31)
.L105:
	mr 3,31
	bl M_WorldEffects
	lwz 0,776(31)
	lwz 9,64(31)
	lwz 11,68(31)
	andi. 10,0,16384
	rlwinm 0,9,0,24,21
	rlwinm 9,11,0,22,18
	stw 0,64(31)
	stw 9,68(31)
	bc 12,2,.L108
	ori 0,0,256
	ori 9,9,1024
	stw 0,64(31)
	stw 9,68(31)
.L108:
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L110
	lis 9,level+4@ha
	lfs 13,500(31)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,1,.L110
	lwz 0,884(31)
	cmpwi 0,0,1
	bc 4,2,.L112
	lwz 0,64(31)
	ori 0,0,512
	stw 0,64(31)
	b .L110
.L112:
	cmpwi 0,0,2
	bc 4,2,.L110
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,2048
	stw 0,64(31)
	stw 9,68(31)
.L110:
	lwz 0,100(1)
	mtlr 0
	lmw 30,88(1)
	la 1,96(1)
	blr
.Lfe4:
	.size	 monster_think,.Lfe4-monster_think
	.section	".rodata"
	.align 2
.LC33:
	.string	"%s at %s has bad item: %s\n"
	.align 3
.LC32:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC34:
	.long 0x0
	.align 2
.LC35:
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
	lis 11,.LC34@ha
	lis 9,deathmatch@ha
	la 11,.LC34@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L133
	bl G_FreeEdict
	li 3,0
	b .L140
.L133:
	lwz 9,284(31)
	andi. 0,9,4
	bc 12,2,.L134
	lwz 0,776(31)
	andi. 11,0,256
	bc 4,2,.L135
	rlwinm 0,9,0,30,28
	ori 0,0,1
	stw 0,284(31)
.L134:
	lwz 0,776(31)
	andi. 9,0,256
	bc 4,2,.L135
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,284(11)
	addi 9,9,1
	stw 9,284(11)
.L135:
	lis 8,level@ha
	lis 9,.LC32@ha
	lwz 11,184(31)
	la 8,level@l(8)
	lfd 13,.LC32@l(9)
	li 7,2
	lfs 0,4(8)
	ori 11,11,4
	lis 9,.LC35@ha
	lwz 0,68(31)
	la 9,.LC35@l(9)
	lis 10,0x202
	stw 11,184(31)
	li 6,0
	ori 10,10,3
	ori 0,0,64
	stw 7,512(31)
	rlwinm 11,11,0,31,29
	stw 0,68(31)
	lfs 12,0(9)
	fadd 0,0,13
	lwz 0,824(31)
	lis 9,monster_use@ha
	lwz 7,480(31)
	la 9,monster_use@l(9)
	cmpwi 0,0,0
	frsp 0,0
	stfs 0,428(31)
	lfs 13,4(8)
	stw 9,448(31)
	stw 7,484(31)
	fadds 13,13,12
	stw 10,252(31)
	stw 6,492(31)
	stw 11,184(31)
	stfs 13,404(31)
	stw 6,60(31)
	bc 4,2,.L136
	lis 9,M_CheckAttack@ha
	la 9,M_CheckAttack@l(9)
	stw 9,824(31)
.L136:
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
	bc 12,2,.L137
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,648(31)
	bc 4,2,.L137
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC33@ha
	lwz 6,44(30)
	la 3,.LC33@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L137:
	lwz 0,772(31)
	cmpwi 0,0,0
	bc 12,2,.L139
	bl rand
	lwz 10,772(31)
	lwz 11,0(10)
	lwz 9,4(10)
	subf 9,11,9
	addi 9,9,1
	divw 0,3,9
	mullw 0,0,9
	subf 3,0,3
	add 11,11,3
	stw 11,56(31)
.L139:
	li 3,1
.L140:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 monster_start,.Lfe5-monster_start
	.section	".rodata"
	.align 2
.LC36:
	.string	"point_combat"
	.align 2
.LC37:
	.string	"%s at %s has target with mixed types\n"
	.align 2
.LC38:
	.string	"%s at (%i %i %i) has a bad combattarget %s : %s at (%i %i %i)\n"
	.align 2
.LC39:
	.string	"%s can't find target %s at %s\n"
	.align 2
.LC41:
	.string	"path_corner"
	.align 2
.LC40:
	.long 0x4cbebc20
	.align 3
.LC42:
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
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L141
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L143
	li 30,0
	li 29,0
	li 27,0
	b .L144
.L146:
	lwz 3,280(30)
	lis 4,.LC36@ha
	la 4,.LC36@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L147
	lwz 0,296(31)
	li 27,1
	stw 0,320(31)
	b .L144
.L147:
	li 29,1
.L144:
	lwz 5,296(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L146
	cmpwi 0,29,0
	bc 12,2,.L150
	lwz 0,320(31)
	cmpwi 0,0,0
	bc 12,2,.L150
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L150:
	cmpwi 0,27,0
	bc 12,2,.L143
	li 0,0
	stw 0,296(31)
.L143:
	lwz 0,320(31)
	cmpwi 0,0,0
	bc 12,2,.L152
	lis 9,gi@ha
	li 30,0
	la 26,gi@l(9)
	lis 27,.LC36@ha
	lis 28,.LC38@ha
	b .L153
.L155:
	lwz 3,280(30)
	la 4,.LC36@l(27)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L153
	lfs 13,4(31)
	la 3,.LC38@l(28)
	lfs 0,8(31)
	mr 6,5
	mr 7,5
	lfs 12,12(31)
	mr 10,5
	mr 11,5
	lfs 11,4(30)
	mr 29,5
	lfs 10,8(30)
	lwz 9,280(30)
	fctiwz 9,13
	lwz 4,280(31)
	fctiwz 8,0
	lwz 8,320(31)
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
.L153:
	lwz 5,320(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L155
.L152:
	lwz 3,296(31)
	cmpwi 0,3,0
	bc 12,2,.L158
	bl G_PickTarget
	mr 30,3
	cmpwi 0,30,0
	stw 30,416(31)
	stw 30,412(31)
	bc 4,2,.L159
	lis 29,gi@ha
	lwz 27,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	lwz 28,296(31)
	bl vtos
	mr 6,3
	lwz 0,4(29)
	mr 4,27
	lis 3,.LC39@ha
	mr 5,28
	la 3,.LC39@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,788(31)
	lis 9,.LC40@ha
	mr 3,31
	lfs 0,.LC40@l(9)
	stw 30,296(31)
	mtlr 11
	b .L164
.L159:
	lwz 3,280(30)
	lis 4,.LC41@ha
	la 4,.LC41@l(4)
	bl strcmp
	mr. 30,3
	bc 4,2,.L161
	lwz 9,412(31)
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
	lwz 9,800(31)
	mr 3,31
	stfs 1,424(31)
	mtlr 9
	stfs 1,20(31)
	blrl
	stw 30,296(31)
	b .L163
.L161:
	lwz 11,788(31)
	lis 9,.LC40@ha
	mr 3,31
	lfs 0,.LC40@l(9)
	li 0,0
	mtlr 11
	stw 0,412(31)
	stw 0,416(31)
.L164:
	stfs 0,828(31)
	blrl
	b .L163
.L158:
	lwz 11,788(31)
	lis 9,.LC40@ha
	mr 3,31
	lfs 0,.LC40@l(9)
	mtlr 11
	stfs 0,828(31)
	blrl
.L163:
	lis 9,monster_think@ha
	lis 10,level+4@ha
	la 9,monster_think@l(9)
	lis 11,.LC42@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC42@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L141:
	lwz 0,68(1)
	mtlr 0
	lmw 26,40(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 monster_start_go,.Lfe6-monster_start_go
	.section	".rodata"
	.align 2
.LC43:
	.string	"%s in solid at %s\n"
	.section	".text"
	.align 2
	.globl monster_fire_bullet
	.type	 monster_fire_bullet,@function
monster_fire_bullet:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 28,3
	mr 27,4
	mr 26,10
	li 10,0
	bl fire_bullet
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 11,g_edicts@ha
	lis 0,0xc10c
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,38677
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,4
	blrl
	lwz 9,100(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 monster_fire_bullet,.Lfe7-monster_fire_bullet
	.align 2
	.globl monster_fire_shotgun
	.type	 monster_fire_shotgun,@function
monster_fire_shotgun:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	li 0,0
	mr 28,3
	lwz 26,56(1)
	mr 27,4
	stw 0,8(1)
	bl fire_shotgun
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 11,g_edicts@ha
	lis 0,0xc10c
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,38677
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,4
	blrl
	lwz 9,100(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 monster_fire_shotgun,.Lfe8-monster_fire_shotgun
	.align 2
	.globl monster_fire_blaster
	.type	 monster_fire_blaster,@function
monster_fire_blaster:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 26,8
	mr 28,3
	mr 8,9
	mr 27,4
	li 9,0
	bl fire_blaster
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 11,g_edicts@ha
	lis 0,0xc10c
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,38677
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,4
	blrl
	lwz 9,100(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 monster_fire_blaster,.Lfe9-monster_fire_blaster
	.section	".rodata"
	.align 3
.LC44:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC45:
	.long 0x40200000
	.section	".text"
	.align 2
	.globl monster_fire_grenade
	.type	 monster_fire_grenade,@function
monster_fire_grenade:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 9,6
	lis 0,0x4330
	addi 9,9,40
	mr 28,3
	xoris 9,9,0x8000
	mr 27,4
	stw 9,20(1)
	mr 26,8
	lis 9,.LC44@ha
	stw 0,16(1)
	la 9,.LC44@l(9)
	lfd 2,16(1)
	lfd 0,0(9)
	lis 9,.LC45@ha
	la 9,.LC45@l(9)
	fsub 2,2,0
	lfs 1,0(9)
	frsp 2,2
	bl fire_grenade
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 11,g_edicts@ha
	lis 0,0xc10c
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,38677
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,4
	blrl
	lwz 9,100(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 monster_fire_grenade,.Lfe10-monster_fire_grenade
	.section	".rodata"
	.align 3
.LC46:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl monster_fire_rocket
	.type	 monster_fire_rocket,@function
monster_fire_rocket:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 9,6
	lis 0,0x4330
	addi 9,9,20
	mr 28,3
	xoris 9,9,0x8000
	mr 27,4
	stw 9,20(1)
	mr 26,8
	lis 9,.LC46@ha
	stw 0,16(1)
	mr 8,6
	la 9,.LC46@l(9)
	lfd 1,16(1)
	lfd 0,0(9)
	fsub 1,1,0
	frsp 1,1
	bl fire_rocket
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 11,g_edicts@ha
	lis 0,0xc10c
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,38677
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,4
	blrl
	lwz 9,100(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 monster_fire_rocket,.Lfe11-monster_fire_rocket
	.align 2
	.globl monster_fire_railgun
	.type	 monster_fire_railgun,@function
monster_fire_railgun:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 28,3
	mr 27,4
	mr 26,8
	bl fire_rail
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 11,g_edicts@ha
	lis 0,0xc10c
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,38677
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,4
	blrl
	lwz 9,100(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 monster_fire_railgun,.Lfe12-monster_fire_railgun
	.align 2
	.globl monster_fire_bfg
	.type	 monster_fire_bfg,@function
monster_fire_bfg:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 28,3
	mr 27,4
	mr 26,9
	bl fire_bfg
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 11,g_edicts@ha
	lis 0,0xc10c
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,38677
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,4
	blrl
	lwz 9,100(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 monster_fire_bfg,.Lfe13-monster_fire_bfg
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
	stw 9,436(11)
	bl monster_start
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 walkmonster_start,.Lfe14-walkmonster_start
	.align 2
	.globl swimmonster_start
	.type	 swimmonster_start,@function
swimmonster_start:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 11,swimmonster_start_go@ha
	lwz 0,264(9)
	la 11,swimmonster_start_go@l(11)
	stw 11,436(9)
	ori 0,0,2
	stw 0,264(9)
	bl monster_start
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 swimmonster_start,.Lfe15-swimmonster_start
	.align 2
	.globl flymonster_start
	.type	 flymonster_start,@function
flymonster_start:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 11,flymonster_start_go@ha
	lwz 0,264(9)
	la 11,flymonster_start_go@l(11)
	stw 11,436(9)
	ori 0,0,1
	stw 0,264(9)
	bl monster_start
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 flymonster_start,.Lfe16-flymonster_start
	.align 2
	.globl AttackFinished
	.type	 AttackFinished,@function
AttackFinished:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,1
	stfs 0,832(3)
	blr
.Lfe17:
	.size	 AttackFinished,.Lfe17-AttackFinished
	.align 2
	.globl monster_death_use
	.type	 monster_death_use,@function
monster_death_use:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 4,648(31)
	lwz 0,264(31)
	lwz 9,776(31)
	cmpwi 0,4,0
	rlwinm 0,0,0,0,29
	rlwinm 9,9,0,23,23
	stw 0,264(31)
	stw 9,776(31)
	bc 12,2,.L129
	bl Drop_Item
	li 0,0
	stw 0,648(31)
.L129:
	lwz 0,316(31)
	cmpwi 0,0,0
	bc 12,2,.L130
	stw 0,296(31)
.L130:
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L128
	mr 3,31
	lwz 4,540(3)
	bl G_UseTargets
.L128:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe18:
	.size	 monster_death_use,.Lfe18-monster_death_use
	.section	".rodata"
	.align 2
.LC47:
	.long 0x3f800000
	.align 2
.LC48:
	.long 0x41d00000
	.align 2
.LC49:
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
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
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
	bc 4,2,.L26
	stw 0,608(31)
	b .L184
.L26:
	lis 9,.LC48@ha
	lfs 0,16(1)
	li 0,1
	la 9,.LC48@l(9)
	stw 3,608(31)
	stw 0,612(31)
	addi 3,1,8
	lfs 13,0(9)
	lwz 9,52(30)
	fadds 0,0,13
	mtlr 9
	stfs 0,16(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L25
	lis 9,.LC49@ha
	lfs 0,16(1)
	li 0,2
	la 9,.LC49@l(9)
	stw 0,612(31)
	addi 3,1,8
	lfs 13,0(9)
	lwz 0,52(30)
	fadds 0,0,13
	mtlr 0
	stfs 0,16(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L25
	li 0,3
.L184:
	stw 0,612(31)
.L25:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 M_CatagorizePosition,.Lfe19-M_CatagorizePosition
	.section	".rodata"
	.align 2
.LC50:
	.long 0x46fffe00
	.align 3
.LC51:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC52:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC53:
	.long 0x40a00000
	.align 2
.LC54:
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
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L16
	bl rand
	lis 30,0x4330
	lis 9,.LC51@ha
	rlwinm 3,3,0,17,31
	la 9,.LC51@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC50@ha
	lis 10,.LC52@ha
	lfs 30,.LC50@l(11)
	la 10,.LC52@l(10)
	stw 3,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	lfd 12,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 12,1,.L16
	lis 9,M_FliesOn@ha
	la 9,M_FliesOn@l(9)
	stw 9,436(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC53@ha
	stw 3,20(1)
	la 10,.LC53@l(10)
	lis 11,level+4@ha
	stw 30,16(1)
	lfd 0,16(1)
	lfs 12,0(10)
	lfs 13,level+4@l(11)
	lis 10,.LC54@ha
	fsub 0,0,31
	la 10,.LC54@l(10)
	lfs 11,0(10)
	fadds 13,13,12
	frsp 0,0
	fdivs 0,0,30
	fmadds 0,0,11,13
	stfs 0,428(31)
.L16:
	lwz 0,52(1)
	mtlr 0
	lmw 30,24(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 M_FlyCheck,.Lfe20-M_FlyCheck
	.section	".rodata"
	.align 3
.LC55:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC56:
	.long 0x42c80000
	.align 3
.LC57:
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
	lwz 0,264(31)
	andi. 0,0,3
	bc 4,2,.L20
	lis 9,.LC56@ha
	lfs 13,384(31)
	la 9,.LC56@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,1,.L185
	lfs 0,12(31)
	lis 9,.LC57@ha
	lis 11,gi+48@ha
	la 9,.LC57@l(9)
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
	lis 9,.LC55@ha
	lfd 13,.LC55@l(9)
	fcmpu 0,0,13
	bc 4,0,.L23
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L20
.L185:
	stw 0,552(31)
	b .L20
.L23:
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L20
	lwz 0,24(1)
	cmpwi 0,0,0
	bc 4,2,.L20
	lfs 0,36(1)
	li 11,0
	lfs 13,40(1)
	lfs 12,44(1)
	lwz 9,76(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	stw 9,552(31)
	lwz 0,92(9)
	stw 11,384(31)
	stw 0,556(31)
.L20:
	lwz 0,100(1)
	mtlr 0
	lwz 31,92(1)
	la 1,96(1)
	blr
.Lfe21:
	.size	 M_CheckGround,.Lfe21-M_CheckGround
	.section	".rodata"
	.align 2
.LC58:
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
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L14
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
	lis 10,.LC58@ha
	stw 3,76(31)
	la 9,M_FliesOff@l(9)
	lis 11,level+4@ha
	la 10,.LC58@l(10)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(31)
.L14:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe22:
	.size	 M_FliesOn,.Lfe22-M_FliesOn
	.align 2
	.globl M_SetEffects
	.type	 M_SetEffects,@function
M_SetEffects:
	lwz 0,776(3)
	lwz 9,64(3)
	lwz 11,68(3)
	andi. 10,0,16384
	rlwinm 0,9,0,24,21
	rlwinm 9,11,0,22,18
	stw 0,64(3)
	stw 9,68(3)
	bc 12,2,.L76
	ori 0,0,256
	ori 9,9,1024
	stw 0,64(3)
	stw 9,68(3)
.L76:
	lwz 0,480(3)
	cmpwi 0,0,0
	bclr 4,1
	lis 9,level+4@ha
	lfs 13,500(3)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bclr 4,1
	lwz 0,884(3)
	cmpwi 0,0,1
	bc 4,2,.L79
	lwz 0,64(3)
	ori 0,0,512
	stw 0,64(3)
	blr
.L79:
	cmpwi 0,0,2
	bclr 4,2
	lwz 0,64(3)
	lwz 9,68(3)
	ori 0,0,256
	ori 9,9,2048
	stw 0,64(3)
	stw 9,68(3)
	blr
.Lfe23:
	.size	 M_SetEffects,.Lfe23-M_SetEffects
	.align 2
	.globl monster_use
	.type	 monster_use,@function
monster_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,540(3)
	cmpwi 0,0,0
	bc 4,2,.L117
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L117
	lwz 0,264(5)
	andi. 9,0,32
	bc 4,2,.L117
	lwz 0,84(5)
	cmpwi 0,0,0
	bc 4,2,.L121
	lwz 0,776(5)
	andi. 9,0,256
	bc 12,2,.L117
.L121:
	stw 5,540(3)
	bl FoundTarget
.L117:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 monster_use,.Lfe24-monster_use
	.section	".rodata"
	.align 2
.LC59:
	.long 0x3f800000
	.align 2
.LC60:
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
	lis 9,.LC59@ha
	mr 31,3
	la 9,.LC59@l(9)
	lfs 0,12(31)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(31)
	bl KillBox
	lwz 9,184(31)
	li 11,5
	li 0,2
	lis 10,.LC60@ha
	stw 11,260(31)
	lis 8,level+4@ha
	rlwinm 9,9,0,0,30
	stw 0,248(31)
	la 10,.LC60@l(10)
	stw 9,184(31)
	mr 3,31
	lfs 13,0(10)
	lfs 0,level+4@l(8)
	lis 10,gi+72@ha
	fadds 0,0,13
	stfs 0,404(31)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	mr 3,31
	bl monster_start_go
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L123
	lwz 0,284(31)
	andi. 10,0,1
	bc 4,2,.L123
	lwz 0,264(9)
	andi. 11,0,32
	bc 4,2,.L123
	mr 3,31
	bl FoundTarget
	b .L124
.L123:
	li 0,0
	stw 0,540(31)
.L124:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 monster_triggered_spawn,.Lfe25-monster_triggered_spawn
	.section	".rodata"
	.align 3
.LC61:
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
	lis 11,.LC61@ha
	stw 9,436(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC61@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	lwz 0,84(5)
	cmpwi 0,0,0
	bc 12,2,.L126
	stw 5,540(3)
.L126:
	lis 9,monster_use@ha
	la 9,monster_use@l(9)
	stw 9,448(3)
	blr
.Lfe26:
	.size	 monster_triggered_spawn_use,.Lfe26-monster_triggered_spawn_use
	.align 2
	.globl monster_triggered_start
	.type	 monster_triggered_start,@function
monster_triggered_start:
	lwz 0,184(3)
	lis 9,monster_triggered_spawn_use@ha
	li 11,0
	la 9,monster_triggered_spawn_use@l(9)
	li 10,0
	stw 11,260(3)
	ori 0,0,1
	stw 9,448(3)
	stw 0,184(3)
	stw 10,428(3)
	stw 11,248(3)
	blr
.Lfe27:
	.size	 monster_triggered_start,.Lfe27-monster_triggered_start
	.section	".rodata"
	.align 2
.LC62:
	.long 0x3f800000
	.align 2
.LC63:
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
	lwz 0,284(31)
	andi. 9,0,2
	bc 4,2,.L166
	lis 11,.LC62@ha
	lis 9,level+4@ha
	la 11,.LC62@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,0,.L166
	bl M_droptofloor
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L166
	lis 9,.LC63@ha
	lis 11,.LC63@ha
	la 9,.LC63@l(9)
	la 11,.LC63@l(11)
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(11)
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L166
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC43@ha
	la 3,.LC43@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L166:
	lis 9,.LC63@ha
	lfs 0,420(31)
	la 9,.LC63@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L169
	lis 0,0x41a0
	stw 0,420(31)
.L169:
	li 0,25
	mr 3,31
	stw 0,508(31)
	bl monster_start_go
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L170
	lwz 0,184(31)
	lis 9,monster_triggered_spawn_use@ha
	li 11,0
	la 9,monster_triggered_spawn_use@l(9)
	stw 11,260(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
	stfs 31,428(31)
	stw 11,248(31)
.L170:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe28:
	.size	 walkmonster_start_go,.Lfe28-walkmonster_start_go
	.section	".rodata"
	.align 2
.LC64:
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
	lis 9,.LC64@ha
	mr 31,3
	la 9,.LC64@l(9)
	lfs 1,0(9)
	lis 9,.LC64@ha
	la 9,.LC64@l(9)
	lfs 2,0(9)
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L174
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC43@ha
	la 3,.LC43@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L174:
	lis 9,.LC64@ha
	lfs 0,420(31)
	la 9,.LC64@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L175
	lis 0,0x4120
	stw 0,420(31)
.L175:
	li 0,25
	mr 3,31
	stw 0,508(31)
	bl monster_start_go
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L176
	lwz 0,184(31)
	lis 9,monster_triggered_spawn_use@ha
	li 11,0
	la 9,monster_triggered_spawn_use@l(9)
	stw 11,260(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
	stfs 31,428(31)
	stw 11,248(31)
.L176:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 flymonster_start_go,.Lfe29-flymonster_start_go
	.section	".rodata"
	.align 2
.LC65:
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
	lis 9,.LC65@ha
	mr 31,3
	la 9,.LC65@l(9)
	lfs 0,420(31)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L180
	lis 0,0x4120
	stw 0,420(31)
.L180:
	li 0,10
	mr 3,31
	stw 0,508(31)
	bl monster_start_go
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L181
	lwz 0,184(31)
	lis 9,monster_triggered_spawn_use@ha
	li 11,0
	la 9,monster_triggered_spawn_use@l(9)
	stw 11,260(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
	stfs 31,428(31)
	stw 11,248(31)
.L181:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 swimmonster_start_go,.Lfe30-swimmonster_start_go
	.align 2
	.type	 M_FliesOff,@function
M_FliesOff:
	lwz 0,64(3)
	li 9,0
	stw 9,76(3)
	rlwinm 0,0,0,18,16
	stw 0,64(3)
	blr
.Lfe31:
	.size	 M_FliesOff,.Lfe31-M_FliesOff
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
