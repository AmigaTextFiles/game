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
	.align 2
.LC10:
	.long 0x40400000
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
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L34
	lwz 0,264(31)
	andi. 11,0,2
	bc 4,2,.L35
	lwz 0,612(31)
	cmpwi 0,0,1
	bc 12,1,.L36
	lis 10,.LC9@ha
	lis 9,level+4@ha
	lwz 0,260(31)
	la 10,.LC9@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	cmpwi 0,0,12
	fadds 0,0,13
	stfs 0,404(31)
	bc 4,2,.L34
	li 0,0
	li 9,5
	stw 11,552(31)
	stw 9,260(31)
	stw 0,376(31)
	stw 0,384(31)
	stw 0,380(31)
	bl SV_AddGravity
	b .L34
.L36:
	lis 9,level@ha
	lis 10,.LC10@ha
	lfs 12,404(31)
	la 10,.LC10@l(10)
	la 29,level@l(9)
	lfs 13,0(10)
	lfs 0,4(29)
	fadds 0,0,13
	fcmpu 0,12,0
	bc 4,0,.L39
	li 0,12
	stw 0,260(31)
.L39:
	lfs 13,404(31)
	b .L64
.L35:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,1,.L44
	lis 10,.LC13@ha
	lis 9,level+4@ha
	la 10,.LC13@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,404(31)
	b .L34
.L44:
	lis 9,level@ha
	lfs 13,404(31)
	la 29,level@l(9)
.L64:
	lfs 1,4(29)
	fcmpu 0,13,1
	bc 4,0,.L34
	lfs 0,464(31)
	fcmpu 0,0,1
	bc 4,0,.L34
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
	stfs 0,464(31)
.L34:
	lwz 8,612(31)
	cmpwi 0,8,0
	bc 4,2,.L49
	lwz 0,264(31)
	andi. 10,0,8
	bc 12,2,.L33
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
	lwz 0,264(31)
	rlwinm 0,0,0,29,27
	b .L65
.L49:
	lwz 0,608(31)
	andi. 9,0,8
	bc 12,2,.L51
	lwz 0,264(31)
	andi. 7,0,128
	bc 4,2,.L51
	lis 9,level+4@ha
	lfs 0,468(31)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L51
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
.L51:
	lwz 0,608(31)
	andi. 9,0,16
	bc 12,2,.L53
	lwz 0,264(31)
	andi. 10,0,64
	bc 4,2,.L53
	lis 9,level+4@ha
	lfs 0,468(31)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L53
	lis 11,.LC12@ha
	lwz 9,612(31)
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
	stfs 0,468(31)
	bl T_Damage
.L53:
	lwz 0,264(31)
	andi. 9,0,8
	bc 4,2,.L33
	lwz 0,184(31)
	andi. 10,0,2
	bc 4,2,.L56
	lwz 0,608(31)
	andi. 11,0,8
	bc 12,2,.L57
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC15@ha
	lis 11,.LC5@ha
	la 10,.LC15@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC16@ha
	lfs 12,.LC5@l(11)
	la 10,.LC16@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,0
	bc 4,3,.L58
	lis 29,gi@ha
	lis 3,.LC6@ha
	la 29,gi@l(29)
	la 3,.LC6@l(3)
	b .L66
.L58:
	lis 29,gi@ha
	lis 3,.LC7@ha
	la 29,gi@l(29)
	la 3,.LC7@l(3)
	b .L66
.L57:
	andi. 9,0,16
	bc 12,2,.L61
	lis 29,gi@ha
	lis 3,.LC8@ha
	la 29,gi@l(29)
	la 3,.LC8@l(3)
.L66:
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
	b .L56
.L61:
	andi. 9,0,32
	bc 12,2,.L56
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
.L56:
	lwz 0,264(31)
	li 9,0
	stw 9,468(31)
	ori 0,0,8
.L65:
	stw 0,264(31)
.L33:
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
	bc 12,2,.L67
	lwz 0,24(1)
	cmpwi 0,0,0
	bc 4,2,.L67
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
	bc 4,2,.L71
	lis 9,.LC20@ha
	lfs 13,384(31)
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,1,.L79
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
	bc 4,0,.L73
	lwz 0,108(1)
	cmpwi 0,0,0
	bc 4,2,.L71
.L79:
	stw 0,552(31)
	b .L71
.L73:
	lwz 0,108(1)
	cmpwi 0,0,0
	bc 4,2,.L71
	lwz 0,104(1)
	cmpwi 0,0,0
	bc 4,2,.L71
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
.L71:
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
	bc 4,2,.L75
	stw 0,608(31)
	b .L80
.L75:
	lis 9,.LC22@ha
	lfs 0,96(1)
	li 0,1
	la 9,.LC22@l(9)
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
	bc 12,2,.L67
	lis 9,.LC23@ha
	lfs 0,96(1)
	li 0,2
	la 9,.LC23@l(9)
	stw 0,612(31)
	addi 3,1,88
	lfs 13,0(9)
	lwz 0,52(30)
	fadds 0,0,13
	mtlr 0
	stfs 0,96(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L67
	li 0,3
.L80:
	stw 0,612(31)
.L67:
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
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl M_SetEffects
	.type	 M_SetEffects,@function
M_SetEffects:
	stwu 1,-16(1)
	lwz 10,64(3)
	lis 9,0xf7fe
	lis 0,0xfffe
	lwz 8,776(3)
	ori 9,9,31999
	ori 0,0,58367
	lwz 11,68(3)
	and 10,10,9
	andi. 7,8,16384
	stw 10,64(3)
	and 9,11,0
	stw 9,68(3)
	bc 12,2,.L82
	ori 0,10,256
	ori 9,9,1024
	stw 0,64(3)
	stw 9,68(3)
.L82:
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L81
	lis 9,level+4@ha
	lfs 13,500(3)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,1,.L84
	lwz 0,884(3)
	cmpwi 0,0,1
	bc 4,2,.L85
	lwz 0,64(3)
	ori 0,0,512
	stw 0,64(3)
	b .L84
.L85:
	cmpwi 0,0,2
	bc 4,2,.L84
	lwz 0,64(3)
	lwz 9,68(3)
	ori 0,0,256
	ori 9,9,2048
	stw 0,64(3)
	stw 9,68(3)
.L84:
	lis 11,level@ha
	lfs 12,980(3)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC24@ha
	xoris 0,0,0x8000
	la 11,.LC24@l(11)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(11)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L88
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,8(1)
	lwz 0,12(1)
	cmpwi 0,0,30
	bc 12,1,.L90
	andi. 7,0,4
	bc 12,2,.L91
.L90:
	lwz 0,64(3)
	ori 0,0,32768
	b .L101
.L88:
	lwz 0,64(3)
	rlwinm 0,0,0,17,15
.L101:
	stw 0,64(3)
.L91:
	lis 11,level@ha
	lfs 12,988(3)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC24@ha
	xoris 0,0,0x8000
	la 11,.LC24@l(11)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(11)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L92
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,8(1)
	lwz 0,12(1)
	cmpwi 0,0,30
	bc 12,1,.L94
	andi. 7,0,4
	bc 12,2,.L95
.L94:
	lwz 0,64(3)
	oris 0,0,0x800
	b .L102
.L92:
	lwz 0,64(3)
	rlwinm 0,0,0,5,3
.L102:
	stw 0,64(3)
.L95:
	lis 11,level@ha
	lfs 12,984(3)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC24@ha
	xoris 0,0,0x8000
	la 11,.LC24@l(11)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(11)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L96
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,8(1)
	lwz 0,12(1)
	cmpwi 0,0,30
	bc 12,1,.L98
	andi. 7,0,4
	bc 12,2,.L99
.L98:
	lwz 0,64(3)
	oris 0,0,0x1
	b .L103
.L96:
	lwz 0,64(3)
	rlwinm 0,0,0,16,14
.L103:
	stw 0,64(3)
.L99:
	lwz 0,264(3)
	andi. 9,0,16384
	bc 12,2,.L81
	lwz 0,64(3)
	lwz 9,68(3)
	ori 0,0,256
	ori 9,9,7168
	stw 0,64(3)
	stw 9,68(3)
.L81:
	la 1,16(1)
	blr
.Lfe3:
	.size	 M_SetEffects,.Lfe3-M_SetEffects
	.section	".rodata"
	.align 3
.LC25:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC26:
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
	lis 11,.LC25@ha
	lfs 0,level+4@l(9)
	mr 31,3
	lfd 13,.LC25@l(11)
	lwz 9,780(31)
	lwz 30,772(31)
	cmpwi 0,9,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 12,2,.L105
	lwz 0,0(30)
	cmpw 0,9,0
	bc 12,0,.L105
	lwz 0,4(30)
	cmpw 0,9,0
	bc 12,1,.L105
	li 0,0
	stw 9,56(31)
	stw 0,780(31)
	b .L106
.L105:
	lwz 9,56(31)
	lwz 0,4(30)
	cmpw 0,9,0
	bc 4,2,.L107
	lwz 0,12(30)
	cmpwi 0,0,0
	bc 12,2,.L107
	mtlr 0
	mr 3,31
	blrl
	lwz 0,184(31)
	lwz 30,772(31)
	andi. 9,0,2
	bc 4,2,.L104
.L107:
	lwz 9,56(31)
	lwz 0,0(30)
	cmpw 0,9,0
	bc 12,0,.L111
	lwz 0,4(30)
	cmpw 0,9,0
	bc 4,1,.L110
.L111:
	lwz 0,776(31)
	rlwinm 0,0,0,25,23
	stw 0,776(31)
	lwz 9,0(30)
	stw 9,56(31)
	b .L106
.L110:
	lwz 0,776(31)
	andi. 11,0,128
	bc 4,2,.L106
	addi 9,9,1
	stw 9,56(31)
	lwz 0,4(30)
	cmpw 0,9,0
	bc 4,1,.L106
	lwz 0,0(30)
	stw 0,56(31)
.L106:
	lwz 10,56(31)
	lwz 0,0(30)
	lwz 11,8(30)
	subf 29,0,10
	mulli 9,29,12
	lwzx 10,9,11
	add 9,9,11
	cmpwi 0,10,0
	bc 12,2,.L115
	lwz 0,776(31)
	andi. 11,0,128
	bc 4,2,.L116
	lfs 0,4(9)
	mr 3,31
	mtlr 10
	lfs 1,784(31)
	fmuls 1,0,1
	blrl
	b .L115
.L116:
	lis 9,.LC26@ha
	mr 3,31
	mtlr 10
	la 9,.LC26@l(9)
	lfs 1,0(9)
	blrl
.L115:
	lwz 0,8(30)
	mulli 9,29,12
	add 9,9,0
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 12,2,.L104
	mr 3,31
	mtlr 0
	blrl
.L104:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 M_MoveFrame,.Lfe4-M_MoveFrame
	.section	".rodata"
	.align 3
.LC27:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC28:
	.long 0x42c80000
	.align 3
.LC29:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC30:
	.long 0x3f800000
	.align 2
.LC31:
	.long 0x41d00000
	.align 2
.LC32:
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
	bc 12,2,.L120
	lwz 0,264(31)
	stw 9,880(31)
	andi. 0,0,3
	bc 4,2,.L120
	lis 9,.LC28@ha
	lfs 13,384(31)
	la 9,.LC28@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,1,.L130
	lfs 0,12(31)
	lis 9,.LC29@ha
	la 11,gi@l(11)
	la 9,.LC29@l(9)
	lwz 0,48(11)
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
	lis 9,.LC27@ha
	lfd 13,.LC27@l(9)
	fcmpu 0,0,13
	bc 4,0,.L124
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L120
.L130:
	stw 0,552(31)
	b .L120
.L124:
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L120
	lwz 0,24(1)
	cmpwi 0,0,0
	bc 4,2,.L120
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
.L120:
	lfs 12,196(31)
	lis 11,.LC30@ha
	lis 9,gi@ha
	lfs 13,12(31)
	la 11,.LC30@l(11)
	la 30,gi@l(9)
	lfs 11,0(11)
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
	bc 4,2,.L126
	stw 0,608(31)
	b .L131
.L126:
	lis 9,.LC31@ha
	lfs 0,16(1)
	li 0,1
	la 9,.LC31@l(9)
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
	bc 12,2,.L127
	lis 9,.LC32@ha
	lfs 0,16(1)
	li 0,2
	la 9,.LC32@l(9)
	stw 0,612(31)
	addi 3,1,8
	lfs 13,0(9)
	lwz 0,52(30)
	fadds 0,0,13
	mtlr 0
	stfs 0,16(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L127
	li 0,3
.L131:
	stw 0,612(31)
.L127:
	mr 3,31
	bl M_WorldEffects
	mr 3,31
	bl M_SetEffects
	lwz 0,100(1)
	mtlr 0
	lmw 30,88(1)
	la 1,96(1)
	blr
.Lfe5:
	.size	 monster_think,.Lfe5-monster_think
	.section	".rodata"
	.align 2
.LC35:
	.string	"%s at %s has bad item: %s\n"
	.align 3
.LC34:
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
	bc 12,2,.L148
	bl G_FreeEdict
	li 3,0
	b .L155
.L148:
	lwz 9,284(31)
	andi. 0,9,4
	bc 12,2,.L149
	lwz 0,776(31)
	andi. 11,0,256
	bc 4,2,.L149
	rlwinm 0,9,0,30,28
	ori 0,0,1
	stw 0,284(31)
.L149:
	lwz 9,776(31)
	lis 0,0x40
	ori 0,0,256
	and. 11,9,0
	bc 4,2,.L150
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,284(11)
	addi 9,9,1
	stw 9,284(11)
.L150:
	lis 8,level@ha
	lis 9,.LC34@ha
	lwz 11,184(31)
	la 8,level@l(8)
	lfd 13,.LC34@l(9)
	li 7,2
	lfs 0,4(8)
	ori 11,11,4
	lis 9,.LC37@ha
	lwz 0,68(31)
	la 9,.LC37@l(9)
	lis 10,0x202
	stw 11,184(31)
	li 6,0
	ori 10,10,3
	ori 0,0,64
	stw 7,512(31)
	rlwinm 11,11,0,31,29
	stw 0,68(31)
	li 5,5120
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
	stw 5,1136(31)
	stw 6,60(31)
	bc 4,2,.L151
	lis 9,M_CheckAttack@ha
	la 9,M_CheckAttack@l(9)
	stw 9,824(31)
.L151:
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
	bc 12,2,.L152
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,648(31)
	bc 4,2,.L152
	lis 29,gi@ha
	lwz 28,280(31)
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
.L152:
	lwz 0,772(31)
	cmpwi 0,0,0
	bc 12,2,.L154
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
.L154:
	lfs 0,208(31)
	li 0,0
	li 3,1
	stw 0,984(31)
	stw 0,980(31)
	stfs 0,932(31)
	stw 0,988(31)
.L155:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 monster_start,.Lfe6-monster_start
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
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L156
	lwz 0,996(31)
	cmpwi 0,0,0
	bc 4,2,.L158
	lfs 0,4(31)
	lfs 13,8(31)
	lfs 12,12(31)
	lfs 11,16(31)
	lfs 10,20(31)
	lfs 9,24(31)
	stfs 0,1000(31)
	stfs 13,1004(31)
	stfs 12,1008(31)
	stfs 11,1012(31)
	stfs 10,1016(31)
	stfs 9,1020(31)
.L158:
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L159
	li 30,0
	li 29,0
	li 27,0
	b .L160
.L162:
	lwz 3,280(30)
	lis 4,.LC38@ha
	la 4,.LC38@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L163
	lwz 0,296(31)
	li 27,1
	stw 0,320(31)
	b .L160
.L163:
	li 29,1
.L160:
	lwz 5,296(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L162
	cmpwi 0,29,0
	bc 12,2,.L166
	lwz 0,320(31)
	cmpwi 0,0,0
	bc 12,2,.L166
	lis 29,gi@ha
	lwz 28,280(31)
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
.L166:
	cmpwi 0,27,0
	bc 12,2,.L159
	li 0,0
	stw 0,296(31)
.L159:
	lwz 0,320(31)
	cmpwi 0,0,0
	bc 12,2,.L168
	lis 9,gi@ha
	li 30,0
	la 26,gi@l(9)
	lis 27,.LC38@ha
	lis 28,.LC40@ha
	b .L169
.L171:
	lwz 3,280(30)
	la 4,.LC38@l(27)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L169
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
.L169:
	lwz 5,320(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L171
.L168:
	lwz 3,296(31)
	cmpwi 0,3,0
	bc 12,2,.L174
	bl G_PickTarget
	mr 30,3
	cmpwi 0,30,0
	stw 30,416(31)
	stw 30,412(31)
	bc 4,2,.L175
	lis 29,gi@ha
	lwz 27,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	lwz 28,296(31)
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
	lwz 11,788(31)
	lis 9,.LC42@ha
	mr 3,31
	lfs 0,.LC42@l(9)
	stw 30,296(31)
	mtlr 11
	b .L180
.L175:
	lwz 3,280(30)
	lis 4,.LC43@ha
	la 4,.LC43@l(4)
	bl strcmp
	mr. 30,3
	bc 4,2,.L177
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
	b .L179
.L177:
	lwz 11,788(31)
	lis 9,.LC42@ha
	mr 3,31
	lfs 0,.LC42@l(9)
	li 0,0
	mtlr 11
	stw 0,412(31)
	stw 0,416(31)
.L180:
	stfs 0,828(31)
	blrl
	b .L179
.L174:
	lwz 11,788(31)
	lis 9,.LC42@ha
	mr 3,31
	lfs 0,.LC42@l(9)
	mtlr 11
	stfs 0,828(31)
	blrl
.L179:
	lis 9,monster_think@ha
	lis 10,level+4@ha
	la 9,monster_think@l(9)
	lis 11,.LC44@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC44@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L156:
	lwz 0,68(1)
	mtlr 0
	lmw 26,40(1)
	la 1,64(1)
	blr
.Lfe7:
	.size	 monster_start_go,.Lfe7-monster_start_go
	.section	".rodata"
	.align 2
.LC45:
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
	lis 0,0xfe3
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,49265
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,3
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
.Lfe8:
	.size	 monster_fire_bullet,.Lfe8-monster_fire_bullet
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
	lis 0,0xfe3
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,49265
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,3
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
	.size	 monster_fire_shotgun,.Lfe9-monster_fire_shotgun
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
	lis 0,0xfe3
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,49265
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,3
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
.Lfe10:
	.size	 monster_fire_blaster,.Lfe10-monster_fire_blaster
	.section	".rodata"
	.align 3
.LC48:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC49:
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
	lis 9,.LC48@ha
	stw 0,16(1)
	la 9,.LC48@l(9)
	lfd 2,16(1)
	lfd 0,0(9)
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
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
	lis 0,0xfe3
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,49265
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,3
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
	.size	 monster_fire_grenade,.Lfe11-monster_fire_grenade
	.section	".rodata"
	.align 3
.LC50:
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
	lis 9,.LC50@ha
	stw 0,16(1)
	mr 8,6
	la 9,.LC50@l(9)
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
	lis 0,0xfe3
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,49265
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,3
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
.Lfe12:
	.size	 monster_fire_rocket,.Lfe12-monster_fire_rocket
	.section	".rodata"
	.align 3
.LC51:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl monster_fire_flamerocket
	.type	 monster_fire_flamerocket,@function
monster_fire_flamerocket:
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
	lis 9,.LC51@ha
	stw 0,16(1)
	mr 8,6
	la 9,.LC51@l(9)
	lfd 1,16(1)
	lfd 0,0(9)
	fsub 1,1,0
	frsp 1,1
	bl fire_flamerocket
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 11,g_edicts@ha
	lis 0,0xfe3
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,49265
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,3
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
.Lfe13:
	.size	 monster_fire_flamerocket,.Lfe13-monster_fire_flamerocket
	.section	".rodata"
	.align 3
.LC52:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl monster_fire_homingrocket
	.type	 monster_fire_homingrocket,@function
monster_fire_homingrocket:
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
	lis 9,.LC52@ha
	stw 0,16(1)
	mr 8,6
	la 9,.LC52@l(9)
	lfd 1,16(1)
	lfd 0,0(9)
	fsub 1,1,0
	frsp 1,1
	bl fire_homing
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 11,g_edicts@ha
	lis 0,0xfe3
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,49265
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,3
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
.Lfe14:
	.size	 monster_fire_homingrocket,.Lfe14-monster_fire_homingrocket
	.section	".rodata"
	.align 3
.LC53:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl monster_fire_perforator
	.type	 monster_fire_perforator,@function
monster_fire_perforator:
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
	lis 9,.LC53@ha
	stw 0,16(1)
	mr 8,6
	la 9,.LC53@l(9)
	lfd 1,16(1)
	lfd 0,0(9)
	fsub 1,1,0
	frsp 1,1
	bl fire_perforator
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 11,g_edicts@ha
	lis 0,0xfe3
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,49265
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,3
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
.Lfe15:
	.size	 monster_fire_perforator,.Lfe15-monster_fire_perforator
	.align 2
	.globl monster_fire_railgun
	.type	 monster_fire_railgun,@function
monster_fire_railgun:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 9,gi@ha
	mr 28,4
	la 27,gi@l(9)
	mr 26,3
	lwz 9,52(27)
	mr 3,28
	mr 31,5
	mr 30,6
	mr 29,7
	mtlr 9
	mr 25,8
	blrl
	andi. 0,3,3
	bc 4,2,.L15
	mr 5,31
	mr 6,30
	mr 7,29
	mr 3,26
	mr 4,28
	bl fire_rail
.L15:
	lwz 9,100(27)
	li 3,2
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xfe3
	lwz 10,104(27)
	lwz 3,g_edicts@l(9)
	ori 0,0,49265
	mtlr 10
	subf 3,3,26
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lwz 9,100(27)
	mr 3,25
	mtlr 9
	blrl
	lwz 0,88(27)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 monster_fire_railgun,.Lfe16-monster_fire_railgun
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
	lis 0,0xfe3
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,49265
	mtlr 10
	subf 28,9,28
	mullw 28,28,0
	srawi 3,28,3
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
.Lfe17:
	.size	 monster_fire_bfg,.Lfe17-monster_fire_bfg
	.align 2
	.globl stationarymonster_start
	.type	 stationarymonster_start,@function
stationarymonster_start:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,stationarymonster_start_go@ha
	mr 11,3
	la 9,stationarymonster_start_go@l(9)
	stw 9,436(11)
	bl monster_start
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 stationarymonster_start,.Lfe18-stationarymonster_start
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
.Lfe19:
	.size	 walkmonster_start,.Lfe19-walkmonster_start
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
.Lfe20:
	.size	 swimmonster_start,.Lfe20-swimmonster_start
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
.Lfe21:
	.size	 flymonster_start,.Lfe21-flymonster_start
	.align 2
	.globl AttackFinished
	.type	 AttackFinished,@function
AttackFinished:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,1
	stfs 0,832(3)
	blr
.Lfe22:
	.size	 AttackFinished,.Lfe22-AttackFinished
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
	bc 12,2,.L144
	bl Drop_Item
	li 0,0
	stw 0,648(31)
.L144:
	lwz 0,316(31)
	cmpwi 0,0,0
	bc 12,2,.L145
	stw 0,296(31)
.L145:
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L143
	mr 3,31
	lwz 4,540(3)
	bl G_UseTargets
.L143:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe23:
	.size	 monster_death_use,.Lfe23-monster_death_use
	.section	".rodata"
	.align 2
.LC54:
	.long 0x3f800000
	.align 2
.LC55:
	.long 0x41d00000
	.align 2
.LC56:
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
	lis 9,.LC54@ha
	la 9,.LC54@l(9)
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
	bc 4,2,.L30
	stw 0,608(31)
	b .L218
.L30:
	lis 9,.LC55@ha
	lfs 0,16(1)
	li 0,1
	la 9,.LC55@l(9)
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
	bc 12,2,.L29
	lis 9,.LC56@ha
	lfs 0,16(1)
	li 0,2
	la 9,.LC56@l(9)
	stw 0,612(31)
	addi 3,1,8
	lfs 13,0(9)
	lwz 0,52(30)
	fadds 0,0,13
	mtlr 0
	stfs 0,16(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L29
	li 0,3
.L218:
	stw 0,612(31)
.L29:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 M_CatagorizePosition,.Lfe24-M_CatagorizePosition
	.section	".rodata"
	.align 2
.LC57:
	.long 0x46fffe00
	.align 3
.LC58:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC59:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC60:
	.long 0x40a00000
	.align 2
.LC61:
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
	bc 4,2,.L20
	bl rand
	lis 30,0x4330
	lis 9,.LC58@ha
	rlwinm 3,3,0,17,31
	la 9,.LC58@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC57@ha
	lis 10,.LC59@ha
	lfs 30,.LC57@l(11)
	la 10,.LC59@l(10)
	stw 3,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	lfd 12,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 12,1,.L20
	lis 9,M_FliesOn@ha
	la 9,M_FliesOn@l(9)
	stw 9,436(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC60@ha
	stw 3,20(1)
	la 10,.LC60@l(10)
	lis 11,level+4@ha
	stw 30,16(1)
	lfd 0,16(1)
	lfs 12,0(10)
	lfs 13,level+4@l(11)
	lis 10,.LC61@ha
	fsub 0,0,31
	la 10,.LC61@l(10)
	lfs 11,0(10)
	fadds 13,13,12
	frsp 0,0
	fdivs 0,0,30
	fmadds 0,0,11,13
	stfs 0,428(31)
.L20:
	lwz 0,52(1)
	mtlr 0
	lmw 30,24(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe25:
	.size	 M_FlyCheck,.Lfe25-M_FlyCheck
	.section	".rodata"
	.align 3
.LC62:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC63:
	.long 0x42c80000
	.align 3
.LC64:
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
	bc 4,2,.L24
	lis 9,.LC63@ha
	lfs 13,384(31)
	la 9,.LC63@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,1,.L219
	lfs 0,12(31)
	lis 9,.LC64@ha
	lis 11,gi+48@ha
	la 9,.LC64@l(9)
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
	lis 9,.LC62@ha
	lfd 13,.LC62@l(9)
	fcmpu 0,0,13
	bc 4,0,.L27
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L24
.L219:
	stw 0,552(31)
	b .L24
.L27:
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L24
	lwz 0,24(1)
	cmpwi 0,0,0
	bc 4,2,.L24
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
.L24:
	lwz 0,100(1)
	mtlr 0
	lwz 31,92(1)
	la 1,96(1)
	blr
.Lfe26:
	.size	 M_CheckGround,.Lfe26-M_CheckGround
	.align 2
	.globl monster_done_dodge
	.type	 monster_done_dodge,@function
monster_done_dodge:
	lwz 0,776(3)
	rlwinm 0,0,0,14,12
	stw 0,776(3)
	blr
.Lfe27:
	.size	 monster_done_dodge,.Lfe27-monster_done_dodge
	.section	".rodata"
	.align 2
.LC65:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl MonsterRespawn
	.type	 MonsterRespawn,@function
MonsterRespawn:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC65@ha
	lis 9,skill@ha
	la 11,.LC65@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,skill@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,0,.L214
	lwz 11,992(31)
	cmpwi 0,11,0
	bc 4,2,.L213
.L214:
	lwz 0,64(31)
	andi. 9,0,2
	bc 12,2,.L212
	mr 3,31
	bl G_FreeEdict
	b .L212
.L213:
	li 28,0
	lfs 9,1000(31)
	mtlr 11
	mr 3,31
	lfs 0,1004(31)
	li 9,0
	lfs 13,1008(31)
	lfs 12,1012(31)
	lfs 11,1016(31)
	lfs 10,1020(31)
	lwz 0,184(31)
	stw 28,776(31)
	rlwinm 0,0,0,0,30
	stfs 9,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	stfs 12,16(31)
	stfs 11,20(31)
	stfs 10,24(31)
	stw 9,1140(31)
	stw 0,184(31)
	blrl
	lwz 0,64(31)
	li 9,1
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 9,996(31)
	mr 3,31
	rlwinm 0,0,0,31,29
	stw 28,412(31)
	stw 0,64(31)
	stw 28,296(31)
	stw 28,320(31)
	stw 28,416(31)
	stw 28,540(31)
	lwz 9,76(29)
	mtlr 9
	blrl
	mr 3,31
	bl KillBox
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
	li 0,6
	stw 0,80(31)
.L212:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe28:
	.size	 MonsterRespawn,.Lfe28-MonsterRespawn
	.section	".rodata"
	.align 2
.LC66:
	.long 0x46fffe00
	.align 3
.LC67:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC68:
	.long 0x41200000
	.align 2
.LC69:
	.long 0x42a00000
	.section	".text"
	.align 2
	.globl SetMonsterRespawn
	.type	 SetMonsterRespawn,@function
SetMonsterRespawn:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lis 9,MonsterRespawn@ha
	lwz 11,992(31)
	la 9,MonsterRespawn@l(9)
	li 0,0
	stw 0,76(31)
	cmpwi 0,11,0
	stw 9,436(31)
	bc 12,2,.L217
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 8,.LC67@ha
	lis 10,.LC66@ha
	la 8,.LC67@l(8)
	stw 0,16(1)
	lis 11,level+4@ha
	lfd 12,0(8)
	lfd 0,16(1)
	lis 8,.LC68@ha
	lfs 11,.LC66@l(10)
	la 8,.LC68@l(8)
	lis 9,.LC69@ha
	lfs 13,level+4@l(11)
	la 9,.LC69@l(9)
	fsub 0,0,12
	lfs 10,0(8)
	lfs 9,0(9)
	frsp 0,0
	fadds 13,13,10
	fdivs 0,0,11
	fmadds 0,0,9,13
	stfs 0,428(31)
.L217:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 SetMonsterRespawn,.Lfe29-SetMonsterRespawn
	.align 2
	.globl M_FliesOff
	.type	 M_FliesOff,@function
M_FliesOff:
	lwz 0,64(3)
	li 9,0
	stw 9,76(3)
	rlwinm 0,0,0,18,16
	stw 0,64(3)
	blr
.Lfe30:
	.size	 M_FliesOff,.Lfe30-M_FliesOff
	.section	".rodata"
	.align 2
.LC70:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl M_FliesOn
	.type	 M_FliesOn,@function
M_FliesOn:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L18
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
	lis 10,.LC70@ha
	stw 3,76(31)
	la 9,M_FliesOff@l(9)
	lis 11,level+4@ha
	la 10,.LC70@l(10)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(31)
.L18:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe31:
	.size	 M_FliesOn,.Lfe31-M_FliesOn
	.align 2
	.globl monster_use
	.type	 monster_use,@function
monster_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,540(3)
	cmpwi 0,0,0
	bc 4,2,.L132
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L132
	lwz 0,264(5)
	andi. 9,0,32
	bc 4,2,.L132
	lwz 0,84(5)
	cmpwi 0,0,0
	bc 4,2,.L136
	lwz 0,776(5)
	andi. 9,0,256
	bc 12,2,.L132
.L136:
	stw 5,540(3)
	bl FoundTarget
.L132:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe32:
	.size	 monster_use,.Lfe32-monster_use
	.section	".rodata"
	.align 2
.LC71:
	.long 0x3f800000
	.align 2
.LC72:
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
	lis 9,.LC71@ha
	mr 31,3
	la 9,.LC71@l(9)
	lfs 0,12(31)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(31)
	bl KillBox
	lwz 9,184(31)
	li 11,5
	li 0,2
	lis 10,.LC72@ha
	stw 11,260(31)
	lis 8,level+4@ha
	rlwinm 9,9,0,0,30
	stw 0,248(31)
	la 10,.LC72@l(10)
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
	bc 12,2,.L138
	lwz 0,284(31)
	andi. 10,0,1
	bc 4,2,.L138
	lwz 0,264(9)
	andi. 11,0,32
	bc 4,2,.L138
	mr 3,31
	bl FoundTarget
	b .L139
.L138:
	li 0,0
	stw 0,540(31)
.L139:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe33:
	.size	 monster_triggered_spawn,.Lfe33-monster_triggered_spawn
	.section	".rodata"
	.align 3
.LC73:
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
	lis 11,.LC73@ha
	stw 9,436(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC73@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	lwz 0,84(5)
	cmpwi 0,0,0
	bc 12,2,.L141
	stw 5,540(3)
.L141:
	lis 9,monster_use@ha
	la 9,monster_use@l(9)
	stw 9,448(3)
	blr
.Lfe34:
	.size	 monster_triggered_spawn_use,.Lfe34-monster_triggered_spawn_use
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
.Lfe35:
	.size	 monster_triggered_start,.Lfe35-monster_triggered_start
	.section	".rodata"
	.align 2
.LC74:
	.long 0x3f800000
	.align 2
.LC75:
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
	bc 4,2,.L182
	lis 11,.LC74@ha
	lis 9,level+4@ha
	la 11,.LC74@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,0,.L182
	bl M_droptofloor
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L182
	lis 9,.LC75@ha
	lis 11,.LC75@ha
	la 9,.LC75@l(9)
	la 11,.LC75@l(11)
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(11)
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L182
	lis 29,gi@ha
	lwz 28,280(31)
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
.L182:
	lis 9,.LC75@ha
	lfs 0,420(31)
	la 9,.LC75@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L185
	lis 0,0x41a0
	stw 0,420(31)
.L185:
	li 0,25
	mr 3,31
	stw 0,508(31)
	bl monster_start_go
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L186
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
.L186:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 walkmonster_start_go,.Lfe36-walkmonster_start_go
	.section	".rodata"
	.align 2
.LC76:
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
	lis 9,.LC76@ha
	mr 31,3
	la 9,.LC76@l(9)
	lfs 1,0(9)
	lis 9,.LC76@ha
	la 9,.LC76@l(9)
	lfs 2,0(9)
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L190
	lis 29,gi@ha
	lwz 28,280(31)
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
.L190:
	lis 9,.LC76@ha
	lfs 0,420(31)
	la 9,.LC76@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L191
	lis 0,0x4120
	stw 0,420(31)
.L191:
	li 0,25
	mr 3,31
	stw 0,508(31)
	bl monster_start_go
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L192
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
.L192:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe37:
	.size	 flymonster_start_go,.Lfe37-flymonster_start_go
	.section	".rodata"
	.align 2
.LC77:
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
	lis 9,.LC77@ha
	mr 31,3
	la 9,.LC77@l(9)
	lfs 0,420(31)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L196
	lis 0,0x4120
	stw 0,420(31)
.L196:
	li 0,10
	mr 3,31
	stw 0,508(31)
	bl monster_start_go
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L197
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
.L197:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe38:
	.size	 swimmonster_start_go,.Lfe38-swimmonster_start_go
	.section	".rodata"
	.align 2
.LC78:
	.long 0x0
	.section	".text"
	.align 2
	.globl stationarymonster_start_go
	.type	 stationarymonster_start_go,@function
stationarymonster_start_go:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 31,20(1)
	stw 0,36(1)
	lis 9,.LC78@ha
	mr 31,3
	la 9,.LC78@l(9)
	lfs 0,420(31)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L207
	lis 0,0x41a0
	stw 0,420(31)
.L207:
	mr 3,31
	bl monster_start_go
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L208
	lwz 0,184(31)
	lis 9,stationarymonster_triggered_spawn_use@ha
	li 11,0
	la 9,stationarymonster_triggered_spawn_use@l(9)
	stw 11,260(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
	stfs 31,428(31)
	stw 11,248(31)
.L208:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe39:
	.size	 stationarymonster_start_go,.Lfe39-stationarymonster_start_go
	.section	".rodata"
	.align 2
.LC79:
	.long 0x41400000
	.section	".text"
	.align 2
	.globl stationarymonster_triggered_spawn
	.type	 stationarymonster_triggered_spawn,@function
stationarymonster_triggered_spawn:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl KillBox
	lwz 9,184(31)
	li 11,0
	li 0,2
	lis 10,.LC79@ha
	stw 11,260(31)
	lis 8,level+4@ha
	rlwinm 9,9,0,0,30
	stw 0,248(31)
	la 10,.LC79@l(10)
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
	lwz 0,284(31)
	mr 3,31
	rlwinm 0,0,0,31,29
	stw 0,284(31)
	bl stationarymonster_start_go
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L201
	lwz 0,284(31)
	andi. 10,0,1
	bc 4,2,.L201
	lwz 0,264(9)
	andi. 11,0,32
	bc 4,2,.L201
	mr 3,31
	bl FoundTarget
	b .L202
.L201:
	li 0,0
	stw 0,540(31)
.L202:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe40:
	.size	 stationarymonster_triggered_spawn,.Lfe40-stationarymonster_triggered_spawn
	.section	".rodata"
	.align 3
.LC80:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl stationarymonster_triggered_spawn_use
	.type	 stationarymonster_triggered_spawn_use,@function
stationarymonster_triggered_spawn_use:
	lis 9,stationarymonster_triggered_spawn@ha
	lis 10,level+4@ha
	la 9,stationarymonster_triggered_spawn@l(9)
	lis 11,.LC80@ha
	stw 9,436(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC80@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	lwz 0,84(5)
	cmpwi 0,0,0
	bc 12,2,.L204
	stw 5,540(3)
.L204:
	lis 9,monster_use@ha
	la 9,monster_use@l(9)
	stw 9,448(3)
	blr
.Lfe41:
	.size	 stationarymonster_triggered_spawn_use,.Lfe41-stationarymonster_triggered_spawn_use
	.align 2
	.globl stationarymonster_triggered_start
	.type	 stationarymonster_triggered_start,@function
stationarymonster_triggered_start:
	lwz 0,184(3)
	lis 9,stationarymonster_triggered_spawn_use@ha
	li 11,0
	la 9,stationarymonster_triggered_spawn_use@l(9)
	li 10,0
	stw 11,260(3)
	ori 0,0,1
	stw 9,448(3)
	stw 0,184(3)
	stw 10,428(3)
	stw 11,248(3)
	blr
.Lfe42:
	.size	 stationarymonster_triggered_start,.Lfe42-stationarymonster_triggered_start
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
