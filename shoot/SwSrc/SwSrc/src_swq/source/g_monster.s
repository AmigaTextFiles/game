	.file	"g_monster.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC1:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC2:
	.long 0x42c80000
	.align 2
.LC3:
	.long 0x0
	.align 2
.LC4:
	.long 0xc2b60000
	.align 2
.LC5:
	.long 0x3f800000
	.align 2
.LC6:
	.long 0x42b40000
	.align 2
.LC7:
	.long 0x43340000
	.align 2
.LC8:
	.long 0x42800000
	.align 3
.LC9:
	.long 0x3fd00000
	.long 0x0
	.section	".text"
	.align 2
	.globl M_CheckGround
	.type	 M_CheckGround,@function
M_CheckGround:
	stwu 1,-192(1)
	mflr 0
	stfd 31,184(1)
	stmw 26,160(1)
	stw 0,196(1)
	mr 31,3
	lwz 0,264(31)
	andi. 0,0,3
	bc 4,2,.L17
	lis 9,.LC2@ha
	lfs 13,384(31)
	la 9,.LC2@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L19
	lis 9,coolgrav@ha
	lwz 11,coolgrav@l(9)
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L29
.L19:
	lis 11,.LC3@ha
	lis 9,coolgrav@ha
	la 11,.LC3@l(11)
	lfs 31,0(11)
	lwz 11,coolgrav@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L20
	lwz 9,84(31)
	lis 11,.LC4@ha
	la 11,.LC4@l(11)
	lfs 0,0(11)
	lfs 13,4852(9)
	fcmpu 0,13,0
	bc 4,1,.L21
	lis 11,.LC5@ha
	la 11,.LC5@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L21
	lis 11,.LC6@ha
	lfs 0,4860(9)
	la 11,.LC6@l(11)
	lfs 13,0(11)
	fsubs 0,0,13
	stfs 0,88(1)
	lfs 13,4856(9)
	stfs 13,92(1)
	b .L22
.L21:
	lwz 9,84(31)
	lis 11,.LC7@ha
	la 11,.LC7@l(11)
	lfs 13,0(11)
	lfs 0,4256(9)
	fcmpu 0,0,13
	bc 4,1,.L23
	lfs 0,4856(9)
	fsubs 0,0,13
	b .L30
.L23:
	lfs 0,4856(9)
	fadds 0,0,13
.L30:
	stfs 0,92(1)
.L22:
	lwz 9,84(31)
	addi 27,1,136
	addi 28,1,104
	lfs 11,4(31)
	addi 29,1,120
	addi 26,1,24
	lfs 12,4860(9)
	addi 3,1,88
	li 6,0
	lfs 13,8(31)
	mr 4,27
	li 5,0
	lfs 0,12(31)
	stfs 12,96(1)
	stfs 11,104(1)
	stfs 13,108(1)
	stfs 0,112(1)
	bl AngleVectors
	lis 9,.LC8@ha
	mr 4,27
	la 9,.LC8@l(9)
	mr 3,28
	lfs 1,0(9)
	mr 5,29
	bl VectorMA
	lis 11,gi+48@ha
	lis 9,0x202
	lwz 0,gi+48@l(11)
	mr 3,26
	mr 4,28
	mr 7,29
	li 5,0
	mtlr 0
	li 6,0
	mr 8,31
	ori 9,9,3
	blrl
	lwz 3,84(31)
	mr 4,26
	li 5,56
	addi 3,3,4900
	crxor 6,6,6
	bl memcpy
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L17
	lwz 0,24(1)
	cmpwi 0,0,0
	bc 4,2,.L17
	lfs 0,36(1)
	lfs 13,40(1)
	lfs 12,44(1)
	lwz 9,76(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	stw 9,552(31)
	lwz 0,92(9)
	b .L31
.L20:
	lfs 0,12(31)
	lis 9,.LC9@ha
	lis 11,gi+48@ha
	la 9,.LC9@l(9)
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
	lis 9,.LC1@ha
	lfd 13,.LC1@l(9)
	fcmpu 0,0,13
	bc 4,0,.L27
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L17
.L29:
	stw 0,552(31)
	b .L17
.L27:
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L17
	lwz 0,24(1)
	cmpwi 0,0,0
	bc 4,2,.L17
	lfs 0,36(1)
	lfs 13,40(1)
	lfs 12,44(1)
	lwz 9,76(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	stw 9,552(31)
	lwz 0,92(9)
	stfs 31,384(31)
.L31:
	stw 0,556(31)
.L17:
	lwz 0,196(1)
	mtlr 0
	lmw 26,160(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe1:
	.size	 M_CheckGround,.Lfe1-M_CheckGround
	.section	".rodata"
	.align 2
.LC10:
	.string	"player/watr_out.wav"
	.align 2
.LC13:
	.string	"player/lava1.wav"
	.align 2
.LC14:
	.string	"player/lava2.wav"
	.align 2
.LC15:
	.string	"player/watr_in.wav"
	.align 3
.LC11:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC12:
	.long 0x46fffe00
	.align 2
.LC16:
	.long 0x41400000
	.align 3
.LC17:
	.long 0x40000000
	.long 0x0
	.align 2
.LC18:
	.long 0x3f800000
	.align 2
.LC19:
	.long 0x41100000
	.align 2
.LC20:
	.long 0x0
	.align 3
.LC21:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC22:
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
	bc 4,1,.L37
	lwz 0,264(31)
	andi. 9,0,2
	bc 4,2,.L38
	lwz 0,612(31)
	cmpwi 0,0,2
	bc 12,1,.L45
	lis 10,.LC16@ha
	lis 9,level+4@ha
	la 10,.LC16@l(10)
	b .L65
.L38:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,1,.L45
	lis 10,.LC19@ha
	lis 9,level+4@ha
	la 10,.LC19@l(10)
.L65:
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,404(31)
	b .L37
.L45:
	lis 9,level@ha
	lfs 13,404(31)
	la 29,level@l(9)
	lfs 1,4(29)
	fcmpu 0,13,1
	bc 4,0,.L37
	lfs 0,464(31)
	fcmpu 0,0,1
	bc 4,0,.L37
	fsubs 1,1,13
	bl floor
	lis 9,.LC17@ha
	fadd 1,1,1
	la 9,.LC17@l(9)
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
	lis 9,.LC18@ha
	lfs 0,4(29)
	la 9,.LC18@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,464(31)
.L37:
	lwz 8,612(31)
	cmpwi 0,8,0
	bc 4,2,.L50
	lwz 0,264(31)
	andi. 10,0,8
	bc 12,2,.L36
	lis 29,gi@ha
	lis 3,.LC10@ha
	la 29,gi@l(29)
	la 3,.LC10@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC18@ha
	lis 10,.LC18@ha
	lis 11,.LC20@ha
	mr 5,3
	la 9,.LC18@l(9)
	la 10,.LC18@l(10)
	mtlr 0
	la 11,.LC20@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	lwz 0,264(31)
	rlwinm 0,0,0,29,27
	b .L66
.L50:
	lwz 0,608(31)
	andi. 9,0,8
	bc 12,2,.L52
	lwz 0,264(31)
	andi. 7,0,128
	bc 4,2,.L52
	lis 9,level+4@ha
	lfs 0,468(31)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L52
	fmr 0,13
	lis 11,.LC11@ha
	lis 10,g_edicts@ha
	stw 7,8(1)
	lfd 13,.LC11@l(11)
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
.L52:
	lwz 0,608(31)
	andi. 9,0,16
	bc 12,2,.L54
	lwz 0,264(31)
	andi. 10,0,64
	bc 4,2,.L54
	lis 9,level+4@ha
	lfs 0,468(31)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L54
	lis 11,.LC18@ha
	lwz 9,612(31)
	lis 6,vec3_origin@ha
	la 11,.LC18@l(11)
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
.L54:
	lwz 0,264(31)
	andi. 9,0,8
	bc 4,2,.L36
	lwz 0,184(31)
	andi. 10,0,2
	bc 4,2,.L57
	lwz 0,608(31)
	andi. 11,0,8
	bc 12,2,.L58
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC21@ha
	lis 11,.LC12@ha
	la 10,.LC21@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC22@ha
	lfs 12,.LC12@l(11)
	la 10,.LC22@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,0
	bc 4,3,.L59
	lis 29,gi@ha
	lis 3,.LC13@ha
	la 29,gi@l(29)
	la 3,.LC13@l(3)
	b .L67
.L59:
	lis 29,gi@ha
	lis 3,.LC14@ha
	la 29,gi@l(29)
	la 3,.LC14@l(3)
	b .L67
.L58:
	andi. 9,0,16
	bc 12,2,.L62
	lis 29,gi@ha
	lis 3,.LC15@ha
	la 29,gi@l(29)
	la 3,.LC15@l(3)
.L67:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC18@ha
	lis 10,.LC18@ha
	lis 11,.LC20@ha
	mr 5,3
	la 9,.LC18@l(9)
	la 10,.LC18@l(10)
	mtlr 0
	la 11,.LC20@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L57
.L62:
	andi. 9,0,32
	bc 12,2,.L57
	lis 29,gi@ha
	lis 3,.LC15@ha
	la 29,gi@l(29)
	la 3,.LC15@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC18@ha
	lis 10,.LC18@ha
	lis 11,.LC20@ha
	mr 5,3
	la 9,.LC18@l(9)
	la 10,.LC18@l(10)
	mtlr 0
	la 11,.LC20@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L57:
	lwz 0,264(31)
	li 9,0
	stw 9,468(31)
	ori 0,0,8
.L66:
	stw 0,264(31)
.L36:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 M_WorldEffects,.Lfe2-M_WorldEffects
	.section	".rodata"
	.align 2
.LC23:
	.long 0x3f800000
	.align 2
.LC24:
	.long 0x43800000
	.align 2
.LC25:
	.long 0x41d00000
	.align 2
.LC26:
	.long 0x41b00000
	.section	".text"
	.align 2
	.globl M_droptofloor
	.type	 M_droptofloor,@function
M_droptofloor:
	stwu 1,-128(1)
	mflr 0
	stfd 31,120(1)
	stmw 30,112(1)
	stw 0,132(1)
	lis 9,.LC23@ha
	mr 31,3
	la 9,.LC23@l(9)
	lfs 0,12(31)
	mr 4,31
	lfs 31,0(9)
	lis 11,.LC24@ha
	addi 3,1,24
	lfsu 12,4(4)
	lis 9,gi@ha
	la 11,.LC24@l(11)
	lfs 13,8(31)
	la 30,gi@l(9)
	addi 5,31,188
	fadds 0,0,31
	lfs 11,0(11)
	lis 9,0x202
	addi 6,31,200
	stfs 12,8(1)
	addi 7,1,8
	mr 8,31
	stfs 13,12(1)
	ori 9,9,3
	stfs 0,12(31)
	lwz 11,48(30)
	fsubs 0,0,11
	mtlr 11
	stfs 0,16(1)
	blrl
	lfs 0,32(1)
	fcmpu 0,0,31
	bc 12,2,.L68
	lwz 0,24(1)
	cmpwi 0,0,0
	bc 4,2,.L68
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
	mr 3,31
	bl M_CheckGround
	lfs 13,196(31)
	addi 3,1,88
	lfs 0,12(31)
	lwz 9,52(30)
	lfs 12,4(31)
	fadds 0,0,13
	mtlr 9
	lfs 13,8(31)
	stfs 12,88(1)
	fadds 0,0,31
	stfs 13,92(1)
	stfs 0,96(1)
	blrl
	andi. 0,3,56
	bc 4,2,.L71
	stw 0,608(31)
	b .L75
.L71:
	lis 9,.LC25@ha
	lfs 0,96(1)
	li 0,1
	la 9,.LC25@l(9)
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
	bc 12,2,.L68
	lis 9,.LC26@ha
	lfs 0,96(1)
	li 0,2
	la 9,.LC26@l(9)
	stw 0,612(31)
	addi 3,1,88
	lfs 13,0(9)
	lwz 0,52(30)
	fadds 0,0,13
	mtlr 0
	stfs 0,96(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L68
	li 0,3
.L75:
	stw 0,612(31)
.L68:
	lwz 0,132(1)
	mtlr 0
	lmw 30,112(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe3:
	.size	 M_droptofloor,.Lfe3-M_droptofloor
	.section	".rodata"
	.align 3
.LC27:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC28:
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
	lis 11,.LC27@ha
	lfs 0,level+4@l(9)
	mr 31,3
	lfd 13,.LC27@l(11)
	lwz 9,780(31)
	lwz 30,772(31)
	cmpwi 0,9,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 12,2,.L80
	lwz 0,0(30)
	cmpw 0,9,0
	bc 12,0,.L80
	lwz 0,4(30)
	cmpw 0,9,0
	bc 12,1,.L80
	li 0,0
	stw 9,56(31)
	stw 0,780(31)
	b .L81
.L80:
	lwz 9,56(31)
	lwz 0,4(30)
	cmpw 0,9,0
	bc 4,2,.L82
	lwz 0,12(30)
	cmpwi 0,0,0
	bc 12,2,.L82
	mtlr 0
	mr 3,31
	blrl
	lwz 0,184(31)
	lwz 30,772(31)
	andi. 9,0,2
	bc 4,2,.L79
.L82:
	lwz 9,56(31)
	lwz 0,0(30)
	cmpw 0,9,0
	bc 12,0,.L86
	lwz 0,4(30)
	cmpw 0,9,0
	bc 4,1,.L85
.L86:
	lwz 0,776(31)
	rlwinm 0,0,0,25,23
	stw 0,776(31)
	lwz 9,0(30)
	stw 9,56(31)
	b .L81
.L85:
	lwz 0,776(31)
	andi. 11,0,128
	bc 4,2,.L81
	addi 9,9,1
	stw 9,56(31)
	lwz 0,4(30)
	cmpw 0,9,0
	bc 4,1,.L81
	lwz 0,0(30)
	stw 0,56(31)
.L81:
	lwz 10,56(31)
	lwz 0,0(30)
	lwz 11,8(30)
	subf 29,0,10
	mulli 9,29,12
	lwzx 10,9,11
	add 9,9,11
	cmpwi 0,10,0
	bc 12,2,.L90
	lwz 0,776(31)
	andi. 11,0,128
	bc 4,2,.L91
	lfs 0,4(9)
	mr 3,31
	mtlr 10
	lfs 1,784(31)
	fmuls 1,0,1
	blrl
	b .L90
.L91:
	lis 9,.LC28@ha
	mr 3,31
	mtlr 10
	la 9,.LC28@l(9)
	lfs 1,0(9)
	blrl
.L90:
	lwz 0,8(30)
	mulli 9,29,12
	add 9,9,0
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 12,2,.L79
	mr 3,31
	mtlr 0
	blrl
.L79:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 M_MoveFrame,.Lfe4-M_MoveFrame
	.section	".rodata"
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
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	bl M_MoveFrame
	lwz 9,92(31)
	lwz 0,880(31)
	cmpw 0,9,0
	bc 12,2,.L95
	stw 9,880(31)
	mr 3,31
	bl M_CheckGround
.L95:
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
	bc 4,2,.L96
	stw 0,608(31)
	b .L103
.L96:
	lis 9,.LC30@ha
	lfs 0,16(1)
	li 0,1
	la 9,.LC30@l(9)
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
	bc 12,2,.L97
	lis 9,.LC31@ha
	lfs 0,16(1)
	li 0,2
	la 9,.LC31@l(9)
	stw 0,612(31)
	addi 3,1,8
	lfs 13,0(9)
	lwz 0,52(30)
	fadds 0,0,13
	mtlr 0
	stfs 0,16(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L97
	li 0,3
.L103:
	stw 0,612(31)
.L97:
	mr 3,31
	bl M_WorldEffects
	lwz 0,776(31)
	lwz 9,64(31)
	lwz 11,68(31)
	andi. 10,0,16384
	rlwinm 9,9,0,24,21
	rlwinm 0,11,0,22,18
	stw 9,64(31)
	stw 0,68(31)
	bc 12,2,.L100
	ori 9,9,256
	ori 0,0,1024
	stw 0,68(31)
	stw 9,64(31)
.L100:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 monster_think,.Lfe5-monster_think
	.section	".rodata"
	.align 2
.LC34:
	.string	"%s at %s has bad item: %s\n"
	.align 3
.LC33:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC35:
	.long 0x0
	.align 2
.LC36:
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
	lis 11,.LC35@ha
	lis 9,deathmatch@ha
	la 11,.LC35@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L120
	bl G_FreeEdict
	li 3,0
	b .L127
.L120:
	lwz 9,284(31)
	andi. 0,9,4
	bc 12,2,.L121
	lwz 0,776(31)
	andi. 11,0,256
	bc 4,2,.L122
	rlwinm 0,9,0,30,28
	ori 0,0,1
	stw 0,284(31)
.L121:
	lwz 0,776(31)
	andi. 9,0,256
	bc 4,2,.L122
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,284(11)
	addi 9,9,1
	stw 9,284(11)
.L122:
	lis 8,level@ha
	lis 9,.LC33@ha
	lwz 11,184(31)
	la 8,level@l(8)
	lfd 13,.LC33@l(9)
	li 7,2
	lfs 0,4(8)
	ori 11,11,4
	lis 9,.LC36@ha
	lwz 0,68(31)
	la 9,.LC36@l(9)
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
	bc 4,2,.L123
	lis 9,M_CheckAttack@ha
	la 9,M_CheckAttack@l(9)
	stw 9,824(31)
.L123:
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
	bc 12,2,.L124
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,648(31)
	bc 4,2,.L124
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC34@ha
	lwz 6,44(30)
	la 3,.LC34@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L124:
	lwz 0,772(31)
	cmpwi 0,0,0
	bc 12,2,.L126
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
.L126:
	li 3,1
.L127:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 monster_start,.Lfe6-monster_start
	.section	".rodata"
	.align 2
.LC37:
	.string	"point_combat"
	.align 2
.LC38:
	.string	"%s at %s has target with mixed types\n"
	.align 2
.LC39:
	.string	"%s at (%i %i %i) has a bad combattarget %s : %s at (%i %i %i)\n"
	.align 2
.LC40:
	.string	"%s can't find target %s at %s\n"
	.align 2
.LC42:
	.string	"path_corner"
	.align 2
.LC41:
	.long 0x4cbebc20
	.align 3
.LC43:
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
	bc 4,1,.L128
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L130
	li 30,0
	li 29,0
	li 27,0
	b .L131
.L133:
	lwz 3,280(30)
	lis 4,.LC37@ha
	la 4,.LC37@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L134
	lwz 0,296(31)
	li 27,1
	stw 0,320(31)
	b .L131
.L134:
	li 29,1
.L131:
	lwz 5,296(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L133
	cmpwi 0,29,0
	bc 12,2,.L137
	lwz 0,320(31)
	cmpwi 0,0,0
	bc 12,2,.L137
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC38@ha
	la 3,.LC38@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L137:
	cmpwi 0,27,0
	bc 12,2,.L130
	li 0,0
	stw 0,296(31)
.L130:
	lwz 0,320(31)
	cmpwi 0,0,0
	bc 12,2,.L139
	lis 9,gi@ha
	li 30,0
	la 26,gi@l(9)
	lis 27,.LC37@ha
	lis 28,.LC39@ha
	b .L140
.L142:
	lwz 3,280(30)
	la 4,.LC37@l(27)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L140
	lfs 13,4(31)
	la 3,.LC39@l(28)
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
.L140:
	lwz 5,320(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L142
.L139:
	lwz 3,296(31)
	cmpwi 0,3,0
	bc 12,2,.L145
	bl G_PickTarget
	mr 30,3
	cmpwi 0,30,0
	stw 30,416(31)
	stw 30,412(31)
	bc 4,2,.L146
	lis 29,gi@ha
	lwz 27,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	lwz 28,296(31)
	bl vtos
	mr 6,3
	lwz 0,4(29)
	mr 4,27
	lis 3,.LC40@ha
	mr 5,28
	la 3,.LC40@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,788(31)
	lis 9,.LC41@ha
	mr 3,31
	lfs 0,.LC41@l(9)
	stw 30,296(31)
	mtlr 11
	b .L151
.L146:
	lwz 3,280(30)
	lis 4,.LC42@ha
	la 4,.LC42@l(4)
	bl strcmp
	mr. 30,3
	bc 4,2,.L148
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
	b .L150
.L148:
	lwz 11,788(31)
	lis 9,.LC41@ha
	mr 3,31
	lfs 0,.LC41@l(9)
	li 0,0
	mtlr 11
	stw 0,412(31)
	stw 0,416(31)
.L151:
	stfs 0,828(31)
	blrl
	b .L150
.L145:
	lwz 11,788(31)
	lis 9,.LC41@ha
	mr 3,31
	lfs 0,.LC41@l(9)
	mtlr 11
	stfs 0,828(31)
	blrl
.L150:
	lis 9,monster_think@ha
	lis 10,level+4@ha
	la 9,monster_think@l(9)
	lis 11,.LC43@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC43@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L128:
	lwz 0,68(1)
	mtlr 0
	lmw 26,40(1)
	la 1,64(1)
	blr
.Lfe7:
	.size	 monster_start_go,.Lfe7-monster_start_go
	.section	".rodata"
	.align 2
.LC44:
	.string	"%s in solid at %s\n"
	.comm	node_count,2,2
	.comm	path_not_time_yet,4,4
	.section	".text"
	.align 2
	.globl monster_fire_blaster
	.type	 monster_fire_blaster,@function
monster_fire_blaster:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 8,0
	bl fire_blaster
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 monster_fire_blaster,.Lfe8-monster_fire_blaster
	.section	".rodata"
	.align 3
.LC45:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC46:
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
	lis 9,.LC45@ha
	stw 0,16(1)
	li 8,0
	la 9,.LC45@l(9)
	lfd 2,16(1)
	lfd 0,0(9)
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	fsub 2,2,0
	lfs 1,0(9)
	li 9,0
	frsp 2,2
	bl fire_thermal
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 11,g_edicts@ha
	lis 0,0x6205
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,46533
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,2
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
.Lfe9:
	.size	 monster_fire_grenade,.Lfe9-monster_fire_grenade
	.section	".rodata"
	.align 3
.LC47:
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
	lis 9,.LC47@ha
	stw 0,16(1)
	mr 8,6
	la 9,.LC47@l(9)
	lfd 1,16(1)
	lfd 0,0(9)
	fsub 1,1,0
	frsp 1,1
	bl fire_missile
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 11,g_edicts@ha
	lis 0,0x6205
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,46533
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,2
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
	.size	 monster_fire_rocket,.Lfe10-monster_fire_rocket
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
.Lfe11:
	.size	 walkmonster_start,.Lfe11-walkmonster_start
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
.Lfe12:
	.size	 swimmonster_start,.Lfe12-swimmonster_start
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
.Lfe13:
	.size	 flymonster_start,.Lfe13-flymonster_start
	.align 2
	.globl AttackFinished
	.type	 AttackFinished,@function
AttackFinished:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,1
	stfs 0,832(3)
	blr
.Lfe14:
	.size	 AttackFinished,.Lfe14-AttackFinished
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
	bc 12,2,.L116
	bl Drop_Item
	li 0,0
	stw 0,648(31)
.L116:
	lwz 0,316(31)
	cmpwi 0,0,0
	bc 12,2,.L117
	stw 0,296(31)
.L117:
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L115
	mr 3,31
	lwz 4,540(3)
	bl G_UseTargets
.L115:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe15:
	.size	 monster_death_use,.Lfe15-monster_death_use
	.section	".rodata"
	.align 2
.LC48:
	.long 0x3f800000
	.align 2
.LC49:
	.long 0x41d00000
	.align 2
.LC50:
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
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
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
	bc 4,2,.L33
	stw 0,608(31)
	b .L171
.L33:
	lis 9,.LC49@ha
	lfs 0,16(1)
	li 0,1
	la 9,.LC49@l(9)
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
	bc 12,2,.L32
	lis 9,.LC50@ha
	lfs 0,16(1)
	li 0,2
	la 9,.LC50@l(9)
	stw 0,612(31)
	addi 3,1,8
	lfs 13,0(9)
	lwz 0,52(30)
	fadds 0,0,13
	mtlr 0
	stfs 0,16(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L32
	li 0,3
.L171:
	stw 0,612(31)
.L32:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 M_CatagorizePosition,.Lfe16-M_CatagorizePosition
	.section	".rodata"
	.align 2
.LC51:
	.long 0x46fffe00
	.align 3
.LC52:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC53:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC54:
	.long 0x40a00000
	.align 2
.LC55:
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
	bc 4,2,.L13
	bl rand
	lis 30,0x4330
	lis 9,.LC52@ha
	rlwinm 3,3,0,17,31
	la 9,.LC52@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC51@ha
	lis 10,.LC53@ha
	lfs 30,.LC51@l(11)
	la 10,.LC53@l(10)
	stw 3,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	lfd 12,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 12,1,.L13
	lis 9,M_FliesOn@ha
	la 9,M_FliesOn@l(9)
	stw 9,436(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC54@ha
	stw 3,20(1)
	la 10,.LC54@l(10)
	lis 11,level+4@ha
	stw 30,16(1)
	lfd 0,16(1)
	lfs 12,0(10)
	lfs 13,level+4@l(11)
	lis 10,.LC55@ha
	fsub 0,0,31
	la 10,.LC55@l(10)
	lfs 11,0(10)
	fadds 13,13,12
	frsp 0,0
	fdivs 0,0,30
	fmadds 0,0,11,13
	stfs 0,428(31)
.L13:
	lwz 0,52(1)
	mtlr 0
	lmw 30,24(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 M_FlyCheck,.Lfe17-M_FlyCheck
	.comm	conversation_content,7760,4
	.comm	highlighted,4,4
	.comm	yeah_you,4,4
	.comm	its_me,4,4
	.comm	holdthephone,4,4
	.comm	NoTouch,4,4
	.comm	showingit,4,4
	.comm	path_time,4,4
	.comm	print_time,4,4
	.align 2
	.globl monster_fire_rifle
	.type	 monster_fire_rifle,@function
monster_fire_rifle:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 8,1
	bl fire_blaster
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 monster_fire_rifle,.Lfe18-monster_fire_rifle
	.align 2
	.globl M_SetEffects
	.type	 M_SetEffects,@function
M_SetEffects:
	lwz 0,776(3)
	lwz 9,64(3)
	lwz 11,68(3)
	andi. 10,0,16384
	rlwinm 9,9,0,24,21
	rlwinm 0,11,0,22,18
	stw 9,64(3)
	stw 0,68(3)
	bclr 12,2
	ori 9,9,256
	ori 0,0,1024
	stw 0,68(3)
	stw 9,64(3)
	blr
.Lfe19:
	.size	 M_SetEffects,.Lfe19-M_SetEffects
	.align 2
	.globl monster_use
	.type	 monster_use,@function
monster_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,540(3)
	cmpwi 0,0,0
	bc 4,2,.L104
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L104
	lwz 0,264(5)
	andi. 9,0,32
	bc 4,2,.L104
	lwz 0,84(5)
	cmpwi 0,0,0
	bc 4,2,.L108
	lwz 0,776(5)
	andi. 9,0,256
	bc 12,2,.L104
.L108:
	stw 5,540(3)
	bl FoundTarget
.L104:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe20:
	.size	 monster_use,.Lfe20-monster_use
	.section	".rodata"
	.align 2
.LC56:
	.long 0x3f800000
	.align 2
.LC57:
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
	lis 9,.LC56@ha
	mr 31,3
	la 9,.LC56@l(9)
	lfs 0,12(31)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(31)
	bl KillBox
	lwz 9,184(31)
	li 11,5
	li 0,2
	lis 10,.LC57@ha
	stw 11,260(31)
	lis 8,level+4@ha
	rlwinm 9,9,0,0,30
	stw 0,248(31)
	la 10,.LC57@l(10)
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
	bc 12,2,.L110
	lwz 0,284(31)
	andi. 10,0,1
	bc 4,2,.L110
	lwz 0,264(9)
	andi. 11,0,32
	bc 4,2,.L110
	mr 3,31
	bl FoundTarget
	b .L111
.L110:
	li 0,0
	stw 0,540(31)
.L111:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe21:
	.size	 monster_triggered_spawn,.Lfe21-monster_triggered_spawn
	.section	".rodata"
	.align 3
.LC58:
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
	lis 11,.LC58@ha
	stw 9,436(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC58@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	lwz 0,84(5)
	cmpwi 0,0,0
	bc 12,2,.L113
	stw 5,540(3)
.L113:
	lis 9,monster_use@ha
	la 9,monster_use@l(9)
	stw 9,448(3)
	blr
.Lfe22:
	.size	 monster_triggered_spawn_use,.Lfe22-monster_triggered_spawn_use
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
.Lfe23:
	.size	 monster_triggered_start,.Lfe23-monster_triggered_start
	.section	".rodata"
	.align 2
.LC59:
	.long 0x3f800000
	.align 2
.LC60:
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
	bc 4,2,.L153
	lis 11,.LC59@ha
	lis 9,level+4@ha
	la 11,.LC59@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,0,.L153
	bl M_droptofloor
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L153
	lis 9,.LC60@ha
	lis 11,.LC60@ha
	la 9,.LC60@l(9)
	la 11,.LC60@l(11)
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(11)
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L153
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC44@ha
	la 3,.LC44@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L153:
	lis 9,.LC60@ha
	lfs 0,420(31)
	la 9,.LC60@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L156
	lis 0,0x41a0
	stw 0,420(31)
.L156:
	li 0,25
	mr 3,31
	stw 0,508(31)
	bl monster_start_go
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L157
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
.L157:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 walkmonster_start_go,.Lfe24-walkmonster_start_go
	.section	".rodata"
	.align 2
.LC61:
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
	lis 9,.LC61@ha
	mr 31,3
	la 9,.LC61@l(9)
	lfs 1,0(9)
	lis 9,.LC61@ha
	la 9,.LC61@l(9)
	lfs 2,0(9)
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L161
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC44@ha
	la 3,.LC44@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L161:
	lis 9,.LC61@ha
	lfs 0,420(31)
	la 9,.LC61@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L162
	lis 0,0x4120
	stw 0,420(31)
.L162:
	li 0,25
	mr 3,31
	stw 0,508(31)
	bl monster_start_go
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L163
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
.L163:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 flymonster_start_go,.Lfe25-flymonster_start_go
	.section	".rodata"
	.align 2
.LC62:
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
	lis 9,.LC62@ha
	mr 31,3
	la 9,.LC62@l(9)
	lfs 0,420(31)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L167
	lis 0,0x4120
	stw 0,420(31)
.L167:
	li 0,10
	mr 3,31
	stw 0,508(31)
	bl monster_start_go
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L168
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
.L168:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 swimmonster_start_go,.Lfe26-swimmonster_start_go
	.section	".rodata"
	.align 2
.LC63:
	.long 0x42700000
	.section	".text"
	.align 2
	.type	 M_FliesOn,@function
M_FliesOn:
	lwz 0,612(3)
	cmpwi 0,0,0
	bclr 4,2
	lwz 0,64(3)
	lis 9,M_FliesOff@ha
	lis 10,.LC63@ha
	la 9,M_FliesOff@l(9)
	lis 11,level+4@ha
	ori 0,0,16384
	la 10,.LC63@l(10)
	stw 9,436(3)
	stw 0,64(3)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(3)
	blr
.Lfe27:
	.size	 M_FliesOn,.Lfe27-M_FliesOn
	.align 2
	.type	 M_FliesOff,@function
M_FliesOff:
	lwz 0,64(3)
	li 9,0
	stw 9,76(3)
	rlwinm 0,0,0,18,16
	stw 0,64(3)
	blr
.Lfe28:
	.size	 M_FliesOff,.Lfe28-M_FliesOff
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
