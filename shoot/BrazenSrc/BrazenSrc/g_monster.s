	.file	"g_monster.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"infantry/inflies1.wav"
	.align 3
.LC2:
	.long 0x3fe66666
	.long 0x66666666
	.align 3
.LC3:
	.long 0xbfe66666
	.long 0x66666666
	.align 2
.LC4:
	.long 0xc2c80000
	.align 3
.LC5:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC6:
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
	lfs 0,384(31)
	lis 9,.LC4@ha
	lfs 12,1056(31)
	la 9,.LC4@l(9)
	lfs 13,0(9)
	fmuls 0,0,12
	fcmpu 0,0,13
	bc 12,0,.L32
	lfs 13,12(31)
	lis 9,.LC5@ha
	fmr 0,12
	lis 11,gi+48@ha
	la 9,.LC5@l(9)
	lwz 0,gi+48@l(11)
	addi 3,1,24
	lfd 10,0(9)
	addi 4,31,4
	addi 5,31,188
	lis 9,0x202
	lfs 11,4(31)
	addi 6,31,200
	lfs 12,8(31)
	ori 9,9,3
	addi 7,1,8
	mtlr 0
	mr 8,31
	fmadd 0,0,10,13
	stfs 11,8(1)
	stfs 12,12(1)
	frsp 0,0
	stfs 0,16(1)
	blrl
	lis 9,.LC6@ha
	lfs 13,1056(31)
	la 9,.LC6@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L27
	lfs 0,56(1)
	lis 9,.LC2@ha
	lfd 13,.LC2@l(9)
	fcmpu 0,0,13
	bc 4,0,.L29
	b .L33
.L27:
	lfs 0,56(1)
	lis 9,.LC3@ha
	lfd 13,.LC3@l(9)
	fcmpu 0,0,13
	bc 4,1,.L29
.L33:
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L24
.L32:
	stw 0,552(31)
	b .L24
.L29:
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
.Lfe1:
	.size	 M_CheckGround,.Lfe1-M_CheckGround
	.section	".rodata"
	.align 2
.LC7:
	.string	"player/watr_out.wav"
	.align 2
.LC10:
	.string	"player/lava1.wav"
	.align 2
.LC11:
	.string	"player/lava2.wav"
	.align 2
.LC12:
	.string	"player/watr_in.wav"
	.align 3
.LC8:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC9:
	.long 0x46fffe00
	.align 2
.LC13:
	.long 0x41400000
	.align 3
.LC14:
	.long 0x40000000
	.long 0x0
	.align 2
.LC15:
	.long 0x3f800000
	.align 2
.LC16:
	.long 0x41100000
	.align 2
.LC17:
	.long 0x0
	.align 3
.LC18:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC19:
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
	bc 4,1,.L39
	lwz 0,264(31)
	andi. 9,0,2
	bc 4,2,.L40
	lwz 0,612(31)
	cmpwi 0,0,2
	bc 12,1,.L47
	lis 10,.LC13@ha
	lis 9,level+4@ha
	la 10,.LC13@l(10)
	b .L67
.L40:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,1,.L47
	lis 10,.LC16@ha
	lis 9,level+4@ha
	la 10,.LC16@l(10)
.L67:
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,404(31)
	b .L39
.L47:
	lis 9,level@ha
	lfs 13,404(31)
	la 29,level@l(9)
	lfs 1,4(29)
	fcmpu 0,13,1
	bc 4,0,.L39
	lfs 0,464(31)
	fcmpu 0,0,1
	bc 4,0,.L39
	fsubs 1,1,13
	bl floor
	lis 9,.LC14@ha
	fadd 1,1,1
	la 9,.LC14@l(9)
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
	lis 9,.LC15@ha
	lfs 0,4(29)
	la 9,.LC15@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,464(31)
.L39:
	lwz 8,612(31)
	cmpwi 0,8,0
	bc 4,2,.L52
	lwz 0,264(31)
	andi. 10,0,8
	bc 12,2,.L38
	lis 29,gi@ha
	lis 3,.LC7@ha
	la 29,gi@l(29)
	la 3,.LC7@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC15@ha
	lis 10,.LC15@ha
	lis 11,.LC17@ha
	mr 5,3
	la 9,.LC15@l(9)
	la 10,.LC15@l(10)
	mtlr 0
	la 11,.LC17@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	lwz 0,264(31)
	rlwinm 0,0,0,29,27
	b .L68
.L52:
	lwz 0,608(31)
	andi. 9,0,8
	bc 12,2,.L54
	lwz 0,264(31)
	andi. 7,0,128
	bc 4,2,.L54
	lis 9,level+4@ha
	lfs 0,468(31)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L54
	fmr 0,13
	lis 11,.LC8@ha
	lis 10,g_edicts@ha
	stw 7,8(1)
	lfd 13,.LC8@l(11)
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
.L54:
	lwz 0,608(31)
	andi. 9,0,16
	bc 12,2,.L56
	lwz 0,264(31)
	andi. 10,0,64
	bc 4,2,.L56
	lis 9,level+4@ha
	lfs 0,468(31)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L56
	lis 11,.LC15@ha
	lwz 9,612(31)
	lis 6,vec3_origin@ha
	la 11,.LC15@l(11)
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
.L56:
	lwz 0,264(31)
	andi. 9,0,8
	bc 4,2,.L38
	lwz 0,184(31)
	andi. 10,0,2
	bc 4,2,.L59
	lwz 0,608(31)
	andi. 11,0,8
	bc 12,2,.L60
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC18@ha
	lis 11,.LC9@ha
	la 10,.LC18@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC19@ha
	lfs 12,.LC9@l(11)
	la 10,.LC19@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,0
	bc 4,3,.L61
	lis 29,gi@ha
	lis 3,.LC10@ha
	la 29,gi@l(29)
	la 3,.LC10@l(3)
	b .L69
.L61:
	lis 29,gi@ha
	lis 3,.LC11@ha
	la 29,gi@l(29)
	la 3,.LC11@l(3)
	b .L69
.L60:
	andi. 9,0,16
	bc 12,2,.L64
	lis 29,gi@ha
	lis 3,.LC12@ha
	la 29,gi@l(29)
	la 3,.LC12@l(3)
.L69:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC15@ha
	lis 10,.LC15@ha
	lis 11,.LC17@ha
	mr 5,3
	la 9,.LC15@l(9)
	la 10,.LC15@l(10)
	mtlr 0
	la 11,.LC17@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L59
.L64:
	andi. 9,0,32
	bc 12,2,.L59
	lis 29,gi@ha
	lis 3,.LC12@ha
	la 29,gi@l(29)
	la 3,.LC12@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC15@ha
	lis 10,.LC15@ha
	lis 11,.LC17@ha
	mr 5,3
	la 9,.LC15@l(9)
	la 10,.LC15@l(10)
	mtlr 0
	la 11,.LC17@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L59:
	lwz 0,264(31)
	li 9,0
	stw 9,468(31)
	ori 0,0,8
.L68:
	stw 0,264(31)
.L38:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 M_WorldEffects,.Lfe2-M_WorldEffects
	.section	".rodata"
	.align 2
.LC20:
	.long 0x0
	.align 2
.LC21:
	.long 0x3f800000
	.align 2
.LC22:
	.long 0x43800000
	.align 2
.LC23:
	.long 0x41d00000
	.align 2
.LC24:
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
	lis 9,.LC20@ha
	mr 31,3
	la 9,.LC20@l(9)
	lfs 0,1056(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L71
	lis 11,.LC21@ha
	lfs 0,12(31)
	lis 9,.LC22@ha
	la 11,.LC21@l(11)
	la 9,.LC22@l(9)
	lfs 10,4(31)
	lfs 11,0(11)
	lfs 13,0(9)
	lfs 12,8(31)
	fadds 0,0,11
	stfs 10,8(1)
	stfs 12,12(1)
	fsubs 13,0,13
	b .L79
.L71:
	lis 11,.LC21@ha
	lfs 0,12(31)
	lis 9,.LC22@ha
	la 11,.LC21@l(11)
	la 9,.LC22@l(9)
	lfs 10,4(31)
	lfs 11,0(11)
	lfs 13,0(9)
	lfs 12,8(31)
	fsubs 0,0,11
	stfs 10,8(1)
	stfs 12,12(1)
	fadds 13,0,13
.L79:
	stfs 0,12(31)
	stfs 13,16(1)
	lis 11,gi@ha
	lis 9,0x202
	la 30,gi@l(11)
	addi 3,1,24
	lwz 10,48(30)
	addi 4,31,4
	addi 5,31,188
	addi 6,31,200
	addi 7,1,8
	mr 8,31
	ori 9,9,3
	mtlr 10
	lis 11,.LC21@ha
	la 11,.LC21@l(11)
	lfs 31,0(11)
	blrl
	lfs 0,32(1)
	fcmpu 0,0,31
	bc 12,2,.L70
	lwz 0,24(1)
	cmpwi 0,0,0
	bc 4,2,.L70
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
	bc 4,2,.L75
	stw 0,608(31)
	b .L80
.L75:
	lis 9,.LC23@ha
	lfs 0,96(1)
	li 0,1
	la 9,.LC23@l(9)
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
	bc 12,2,.L70
	lis 9,.LC24@ha
	lfs 0,96(1)
	li 0,2
	la 9,.LC24@l(9)
	stw 0,612(31)
	addi 3,1,88
	lfs 13,0(9)
	lwz 0,52(30)
	fadds 0,0,13
	mtlr 0
	stfs 0,96(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L70
	li 0,3
.L80:
	stw 0,612(31)
.L70:
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
.LC25:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC26:
	.long 0x0
	.section	".text"
	.align 2
	.globl M_SetEffects
	.type	 M_SetEffects,@function
M_SetEffects:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lis 9,0xf7fe
	lwz 10,64(31)
	ori 9,9,31999
	lis 0,0xfffe
	lwz 8,776(31)
	ori 0,0,58367
	lwz 11,68(31)
	and 10,10,9
	andi. 7,8,16384
	stw 10,64(31)
	and 9,11,0
	stw 9,68(31)
	bc 12,2,.L82
	ori 0,10,256
	ori 9,9,1024
	stw 0,64(31)
	stw 9,68(31)
.L82:
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L81
	lis 9,level+4@ha
	lfs 13,500(31)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,1,.L84
	lwz 0,884(31)
	cmpwi 0,0,1
	bc 4,2,.L85
	lwz 0,64(31)
	ori 0,0,512
	stw 0,64(31)
	b .L84
.L85:
	cmpwi 0,0,2
	bc 4,2,.L84
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,2048
	stw 0,64(31)
	stw 9,68(31)
.L84:
	lis 11,level@ha
	lfs 12,980(31)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC25@ha
	xoris 0,0,0x8000
	la 11,.LC25@l(11)
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
	lwz 30,12(1)
	cmpwi 0,30,30
	bc 12,1,.L90
	andi. 0,30,4
	bc 12,2,.L91
.L90:
	lwz 0,64(31)
	ori 0,0,32768
	b .L103
.L88:
	lwz 0,64(31)
	rlwinm 0,0,0,17,15
.L103:
	stw 0,64(31)
.L91:
	lis 11,level@ha
	lfs 12,988(31)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 7,.LC25@ha
	la 7,.LC25@l(7)
	xoris 0,0,0x8000
	lfd 13,0(7)
	stw 0,12(1)
	stw 10,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L92
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,8(1)
	lwz 30,12(1)
	cmpwi 0,30,30
	bc 12,1,.L94
	andi. 9,30,4
	bc 12,2,.L95
.L94:
	lwz 0,64(31)
	oris 0,0,0x800
	b .L104
.L92:
	lwz 0,64(31)
	rlwinm 0,0,0,5,3
.L104:
	stw 0,64(31)
.L95:
	lis 11,level@ha
	lfs 12,1028(31)
	lwz 0,level@l(11)
	la 8,level@l(11)
	lis 10,0x4330
	lis 11,.LC25@ha
	xoris 0,0,0x8000
	la 11,.LC25@l(11)
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
	lwz 30,12(1)
	andi. 0,30,8
	bc 12,2,.L97
	lwz 9,452(31)
	lis 7,.LC26@ha
	mr 4,31
	la 7,.LC26@l(7)
	lfs 0,4(8)
	li 5,999
	lfs 1,0(7)
	mtlr 9
	mr 3,31
	addi 28,31,4
	stfs 0,464(31)
	blrl
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,48
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
.L97:
	andi. 0,30,4
	bc 12,2,.L96
	lwz 0,64(31)
	ori 0,0,32768
	stw 0,64(31)
.L96:
	lis 11,level@ha
	lfs 12,984(31)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 7,.LC25@ha
	la 7,.LC25@l(7)
	xoris 0,0,0x8000
	lfd 13,0(7)
	stw 0,12(1)
	stw 10,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L99
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,8(1)
	lwz 30,12(1)
	cmpwi 0,30,30
	bc 12,1,.L101
	andi. 9,30,4
	bc 12,2,.L81
.L101:
	lwz 0,64(31)
	oris 0,0,0x1
	b .L105
.L99:
	lwz 0,64(31)
	rlwinm 0,0,0,16,14
.L105:
	stw 0,64(31)
.L81:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 M_SetEffects,.Lfe4-M_SetEffects
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
	bc 12,2,.L107
	lwz 0,0(30)
	cmpw 0,9,0
	bc 12,0,.L107
	lwz 0,4(30)
	cmpw 0,9,0
	bc 12,1,.L107
	li 0,0
	stw 9,56(31)
	stw 0,780(31)
	b .L108
.L107:
	lwz 9,56(31)
	lwz 0,4(30)
	cmpw 0,9,0
	bc 4,2,.L109
	lwz 0,12(30)
	cmpwi 0,0,0
	bc 12,2,.L109
	mtlr 0
	mr 3,31
	blrl
	lwz 0,184(31)
	lwz 30,772(31)
	andi. 9,0,2
	bc 4,2,.L106
.L109:
	lwz 9,56(31)
	lwz 0,0(30)
	cmpw 0,9,0
	bc 12,0,.L113
	lwz 0,4(30)
	cmpw 0,9,0
	bc 4,1,.L112
.L113:
	lwz 0,776(31)
	rlwinm 0,0,0,25,23
	stw 0,776(31)
	lwz 9,0(30)
	stw 9,56(31)
	b .L108
.L112:
	lwz 0,776(31)
	andi. 11,0,128
	bc 4,2,.L108
	addi 9,9,1
	stw 9,56(31)
	lwz 0,4(30)
	cmpw 0,9,0
	bc 4,1,.L108
	lwz 0,0(30)
	stw 0,56(31)
.L108:
	lwz 10,56(31)
	lwz 0,0(30)
	lwz 11,8(30)
	subf 29,0,10
	mulli 9,29,12
	lwzx 10,9,11
	add 9,9,11
	cmpwi 0,10,0
	bc 12,2,.L117
	lwz 0,776(31)
	andi. 11,0,128
	bc 4,2,.L118
	lfs 0,4(9)
	mr 3,31
	mtlr 10
	lfs 1,784(31)
	fmuls 1,0,1
	blrl
	b .L117
.L118:
	lis 9,.LC28@ha
	mr 3,31
	mtlr 10
	la 9,.LC28@l(9)
	lfs 1,0(9)
	blrl
.L117:
	lwz 0,8(30)
	mulli 9,29,12
	add 9,9,0
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 12,2,.L106
	mr 3,31
	mtlr 0
	blrl
.L106:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 M_MoveFrame,.Lfe5-M_MoveFrame
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
	bc 12,2,.L122
	stw 9,880(31)
	mr 3,31
	bl M_CheckGround
.L122:
	lfs 12,196(31)
	lis 11,.LC29@ha
	lis 9,gi@ha
	lfs 13,12(31)
	la 11,.LC29@l(11)
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
	bc 4,2,.L123
	stw 0,608(31)
	b .L127
.L123:
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
	bc 12,2,.L124
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
	bc 12,2,.L124
	li 0,3
.L127:
	stw 0,612(31)
.L124:
	mr 3,31
	bl M_WorldEffects
	mr 3,31
	bl M_SetEffects
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 monster_think,.Lfe6-monster_think
	.section	".rodata"
	.align 2
.LC33:
	.long 0x43160000
	.align 2
.LC34:
	.long 0x41800000
	.align 2
.LC35:
	.long 0x41400000
	.align 2
.LC36:
	.long 0x41000000
	.align 2
.LC37:
	.long 0x41f00000
	.align 3
.LC38:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl monster_death_use
	.type	 monster_death_use,@function
monster_death_use:
	stwu 1,-160(1)
	mflr 0
	stmw 25,132(1)
	stw 0,164(1)
	mr 31,3
	lwz 0,648(31)
	lwz 9,264(31)
	lwz 11,776(31)
	cmpwi 0,0,0
	rlwinm 9,9,0,0,29
	rlwinm 11,11,0,23,23
	stw 9,264(31)
	stw 11,776(31)
	bc 12,2,.L144
	lfs 0,20(31)
	addi 27,1,24
	li 0,0
	lfs 13,24(31)
	addi 29,1,40
	addi 26,1,56
	addi 25,1,72
	addi 28,1,88
	stw 0,24(1)
	stfs 0,28(1)
	addi 4,1,8
	li 5,0
	stfs 13,32(1)
	li 6,0
	mr 3,27
	bl AngleVectors
	lis 8,.LC33@ha
	addi 3,1,8
	la 8,.LC33@l(8)
	mr 4,3
	lfs 1,0(8)
	bl VectorScale
	mr 6,28
	mr 3,27
	mr 4,26
	mr 5,25
	bl AngleVectors
	lis 8,.LC34@ha
	lfs 12,4(31)
	mr 4,28
	lfs 13,8(31)
	la 8,.LC34@l(8)
	mr 3,29
	lfs 0,12(31)
	mr 5,29
	lfs 1,0(8)
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
	bl VectorMA
	lis 8,.LC35@ha
	mr 4,26
	la 8,.LC35@l(8)
	mr 3,29
	lfs 1,0(8)
	mr 5,29
	bl VectorMA
	lis 8,.LC36@ha
	mr 4,25
	la 8,.LC36@l(8)
	mr 3,29
	lfs 1,0(8)
	mr 5,29
	bl VectorMA
	lwz 4,648(31)
	mr 5,29
	mr 3,31
	addi 6,1,8
	bl LaunchItem
	mr. 7,3
	bc 12,2,.L145
	lis 8,.LC37@ha
	lis 9,level+4@ha
	lwz 11,648(7)
	la 8,.LC37@l(8)
	lfs 0,level+4@l(9)
	lfs 13,0(8)
	fadds 0,0,13
	stfs 0,428(7)
	lwz 0,24(11)
	stw 0,532(7)
	lwz 9,20(11)
	cmpwi 0,9,12
	bc 4,2,.L146
	lwz 0,508(7)
	ori 0,0,15
	stw 0,508(7)
.L146:
	lwz 11,648(7)
	lis 10,0x4330
	lis 8,.LC38@ha
	mr 3,7
	lwz 0,28(11)
	la 8,.LC38@l(8)
	lfd 13,0(8)
	xoris 0,0,0x8000
	lis 8,gi+72@ha
	stw 0,124(1)
	stw 10,120(1)
	lfd 0,120(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,992(7)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
.L145:
	li 0,0
	stw 0,648(31)
.L144:
	lwz 0,316(31)
	cmpwi 0,0,0
	bc 12,2,.L147
	stw 0,296(31)
.L147:
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L143
	mr 3,31
	lwz 4,540(3)
	bl G_UseTargets
.L143:
	lwz 0,164(1)
	mtlr 0
	lmw 25,132(1)
	la 1,160(1)
	blr
.Lfe7:
	.size	 monster_death_use,.Lfe7-monster_death_use
	.section	".rodata"
	.align 2
.LC40:
	.string	"weapon_machinegun"
	.align 2
.LC41:
	.string	"weapon_submach"
	.align 2
.LC42:
	.string	"ammo_bullets"
	.align 2
.LC43:
	.string	"ammo_submachclip"
	.align 2
.LC44:
	.string	"ammo_shells"
	.align 2
.LC45:
	.string	"ammo_shotgunclip"
	.align 2
.LC46:
	.string	"ammo_rockets"
	.align 2
.LC47:
	.string	"ammo_grenades"
	.align 2
.LC48:
	.string	"weapon_supershotgun"
	.align 2
.LC49:
	.string	"weapon_shotgun"
	.align 2
.LC50:
	.string	"weapon_hyperblaster"
	.align 2
.LC51:
	.string	"weapon_arifle"
	.align 2
.LC52:
	.string	"ammo_cells"
	.align 2
.LC53:
	.string	"ammo_arifleclip"
	.align 2
.LC54:
	.string	"%s at %s has bad item: %s\n"
	.align 3
.LC39:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC55:
	.long 0x0
	.align 2
.LC56:
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
	lis 11,.LC55@ha
	lis 9,deathmatch@ha
	la 11,.LC55@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L150
	bl G_FreeEdict
	li 3,0
	b .L164
.L150:
	lwz 9,284(31)
	andi. 0,9,4
	bc 12,2,.L151
	lwz 0,776(31)
	andi. 11,0,256
	bc 4,2,.L151
	rlwinm 0,9,0,30,28
	ori 0,0,1
	stw 0,284(31)
.L151:
	lwz 9,776(31)
	lis 0,0x40
	ori 0,0,256
	and. 11,9,0
	bc 4,2,.L152
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,284(11)
	addi 9,9,1
	stw 9,284(11)
.L152:
	lis 8,level@ha
	lis 9,.LC39@ha
	lwz 11,184(31)
	la 8,level@l(8)
	lfd 13,.LC39@l(9)
	li 7,2
	lfs 0,4(8)
	ori 11,11,4
	lis 9,.LC56@ha
	lwz 0,68(31)
	la 9,.LC56@l(9)
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
	bc 4,2,.L153
	lis 9,M_CheckAttack@ha
	la 9,M_CheckAttack@l(9)
	stw 9,824(31)
.L153:
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
	bc 12,2,.L154
	lis 4,.LC40@ha
	la 4,.LC40@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L155
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	stw 9,44(30)
.L155:
	lwz 3,44(30)
	lis 4,.LC42@ha
	la 4,.LC42@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L156
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	stw 9,44(30)
.L156:
	lwz 3,44(30)
	lis 4,.LC44@ha
	la 4,.LC44@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L157
	lis 9,.LC45@ha
	la 9,.LC45@l(9)
	stw 9,44(30)
.L157:
	lwz 3,44(30)
	lis 4,.LC46@ha
	la 4,.LC46@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L158
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	stw 9,44(30)
.L158:
	lwz 3,44(30)
	lis 4,.LC48@ha
	la 4,.LC48@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L159
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	stw 9,44(30)
.L159:
	lwz 3,44(30)
	lis 4,.LC50@ha
	la 4,.LC50@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L160
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	stw 9,44(30)
.L160:
	lwz 3,44(30)
	lis 4,.LC52@ha
	la 4,.LC52@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L161
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	stw 9,44(30)
.L161:
	lwz 3,44(30)
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,648(31)
	bc 4,2,.L154
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC54@ha
	lwz 6,44(30)
	la 3,.LC54@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L154:
	lwz 0,772(31)
	cmpwi 0,0,0
	bc 12,2,.L163
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
.L163:
	lfs 0,208(31)
	li 0,0
	li 3,1
	stw 0,984(31)
	stw 0,980(31)
	stfs 0,932(31)
	stw 0,988(31)
.L164:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 monster_start,.Lfe8-monster_start
	.section	".rodata"
	.align 2
.LC57:
	.string	"point_combat"
	.align 2
.LC58:
	.string	"%s at %s has target with mixed types\n"
	.align 2
.LC59:
	.string	"%s can't find killtarget %s at %s\n"
	.align 2
.LC60:
	.string	"%s at (%i %i %i) has a bad combattarget %s : %s at (%i %i %i)\n"
	.align 2
.LC61:
	.string	"%s can't find target %s at %s\n"
	.align 2
.LC63:
	.string	"path_corner"
	.align 2
.LC62:
	.long 0x4cbebc20
	.align 3
.LC64:
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
	bc 4,1,.L165
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L167
	li 30,0
	li 29,0
	li 27,0
	b .L168
.L170:
	lwz 3,280(30)
	lis 4,.LC57@ha
	la 4,.LC57@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L171
	lwz 0,296(31)
	li 27,1
	stw 0,320(31)
	b .L168
.L171:
	li 29,1
.L168:
	lwz 5,296(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L170
	cmpwi 0,29,0
	bc 12,2,.L174
	lwz 0,320(31)
	cmpwi 0,0,0
	bc 12,2,.L174
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC58@ha
	la 3,.LC58@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L174:
	cmpwi 0,27,0
	bc 12,2,.L167
	li 0,0
	stw 0,296(31)
.L167:
	lwz 3,304(31)
	cmpwi 0,3,0
	bc 12,2,.L176
	bl G_PickTarget
	mr 30,3
	cmpwi 0,30,0
	stw 30,416(31)
	bc 4,2,.L177
	lis 29,gi@ha
	lwz 27,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	lwz 28,304(31)
	bl vtos
	mr 6,3
	lwz 0,4(29)
	mr 4,27
	lis 3,.LC59@ha
	mr 5,28
	la 3,.LC59@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	stw 30,296(31)
.L177:
	li 0,0
	stw 0,416(31)
.L176:
	lwz 0,320(31)
	cmpwi 0,0,0
	bc 12,2,.L178
	lis 9,gi@ha
	li 30,0
	la 26,gi@l(9)
	lis 27,.LC57@ha
	lis 28,.LC60@ha
	b .L179
.L181:
	lwz 3,280(30)
	la 4,.LC57@l(27)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L179
	lfs 13,4(31)
	la 3,.LC60@l(28)
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
.L179:
	lwz 5,320(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L181
.L178:
	lwz 3,296(31)
	cmpwi 0,3,0
	bc 12,2,.L184
	bl G_PickTarget
	mr 30,3
	cmpwi 0,30,0
	stw 30,416(31)
	stw 30,412(31)
	bc 4,2,.L185
	lis 29,gi@ha
	lwz 27,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	lwz 28,296(31)
	bl vtos
	mr 6,3
	lwz 0,4(29)
	mr 4,27
	lis 3,.LC61@ha
	mr 5,28
	la 3,.LC61@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,788(31)
	lis 9,.LC62@ha
	mr 3,31
	lfs 0,.LC62@l(9)
	stw 30,296(31)
	mtlr 11
	b .L190
.L185:
	lwz 3,280(30)
	lis 4,.LC63@ha
	la 4,.LC63@l(4)
	bl strcmp
	mr. 30,3
	bc 4,2,.L187
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
	b .L189
.L187:
	lwz 11,788(31)
	lis 9,.LC62@ha
	mr 3,31
	lfs 0,.LC62@l(9)
	li 0,0
	mtlr 11
	stw 0,412(31)
	stw 0,416(31)
.L190:
	stfs 0,828(31)
	blrl
	b .L189
.L184:
	lwz 11,788(31)
	lis 9,.LC62@ha
	mr 3,31
	lfs 0,.LC62@l(9)
	mtlr 11
	stfs 0,828(31)
	blrl
.L189:
	lis 9,monster_think@ha
	lis 10,level+4@ha
	la 9,monster_think@l(9)
	lis 11,.LC64@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC64@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L165:
	lwz 0,68(1)
	mtlr 0
	lmw 26,40(1)
	la 1,64(1)
	blr
.Lfe9:
	.size	 monster_start_go,.Lfe9-monster_start_go
	.section	".rodata"
	.align 2
.LC65:
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
	li 10,5
	bl fire_bullet
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 11,g_edicts@ha
	lis 0,0xa27a
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,52719
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
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 monster_fire_bullet,.Lfe10-monster_fire_bullet
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
	lis 0,0xa27a
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,52719
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
.Lfe11:
	.size	 monster_fire_shotgun,.Lfe11-monster_fire_shotgun
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
	lis 0,0xa27a
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,52719
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
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 monster_fire_blaster,.Lfe12-monster_fire_blaster
	.section	".rodata"
	.align 3
.LC67:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC68:
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
	lis 9,.LC67@ha
	stw 0,16(1)
	li 8,28
	la 9,.LC67@l(9)
	lfd 2,16(1)
	lfd 0,0(9)
	lis 9,.LC68@ha
	la 9,.LC68@l(9)
	fsub 2,2,0
	lfs 1,0(9)
	frsp 2,2
	bl fire_cgrenade
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 11,g_edicts@ha
	lis 0,0xa27a
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,52719
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
.Lfe13:
	.size	 monster_fire_grenade,.Lfe13-monster_fire_grenade
	.section	".rodata"
	.align 3
.LC69:
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
	lis 9,.LC69@ha
	stw 0,16(1)
	mr 8,6
	la 9,.LC69@l(9)
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
	lis 0,0xa27a
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,52719
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
.Lfe14:
	.size	 monster_fire_rocket,.Lfe14-monster_fire_rocket
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
	lis 0,0xa27a
	lwz 10,104(27)
	lwz 3,g_edicts@l(9)
	ori 0,0,52719
	mtlr 10
	subf 3,3,26
	mullw 3,3,0
	srawi 3,3,2
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
.Lfe15:
	.size	 monster_fire_railgun,.Lfe15-monster_fire_railgun
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
	lis 0,0xa27a
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,52719
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
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 monster_fire_bfg,.Lfe16-monster_fire_bfg
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
.Lfe17:
	.size	 walkmonster_start,.Lfe17-walkmonster_start
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
.Lfe18:
	.size	 swimmonster_start,.Lfe18-swimmonster_start
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
.Lfe19:
	.size	 flymonster_start,.Lfe19-flymonster_start
	.align 2
	.globl AttackFinished
	.type	 AttackFinished,@function
AttackFinished:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,1
	stfs 0,832(3)
	blr
.Lfe20:
	.size	 AttackFinished,.Lfe20-AttackFinished
	.section	".rodata"
	.align 2
.LC70:
	.long 0x3f800000
	.align 2
.LC71:
	.long 0x41d00000
	.align 2
.LC72:
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
	lis 9,.LC70@ha
	la 9,.LC70@l(9)
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
	bc 4,2,.L35
	stw 0,608(31)
	b .L224
.L35:
	lis 9,.LC71@ha
	lfs 0,16(1)
	li 0,1
	la 9,.LC71@l(9)
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
	bc 12,2,.L34
	lis 9,.LC72@ha
	lfs 0,16(1)
	li 0,2
	la 9,.LC72@l(9)
	stw 0,612(31)
	addi 3,1,8
	lfs 13,0(9)
	lwz 0,52(30)
	fadds 0,0,13
	mtlr 0
	stfs 0,16(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L34
	li 0,3
.L224:
	stw 0,612(31)
.L34:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 M_CatagorizePosition,.Lfe21-M_CatagorizePosition
	.section	".rodata"
	.align 2
.LC73:
	.long 0x46fffe00
	.align 3
.LC74:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC75:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC76:
	.long 0x40a00000
	.align 2
.LC77:
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
	lis 9,.LC74@ha
	rlwinm 3,3,0,17,31
	la 9,.LC74@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC73@ha
	lis 10,.LC75@ha
	lfs 30,.LC73@l(11)
	la 10,.LC75@l(10)
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
	lis 10,.LC76@ha
	stw 3,20(1)
	la 10,.LC76@l(10)
	lis 11,level+4@ha
	stw 30,16(1)
	lfd 0,16(1)
	lfs 12,0(10)
	lfs 13,level+4@l(11)
	lis 10,.LC77@ha
	fsub 0,0,31
	la 10,.LC77@l(10)
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
.Lfe22:
	.size	 M_FlyCheck,.Lfe22-M_FlyCheck
	.align 2
	.globl monster_fire_blaster2
	.type	 monster_fire_blaster2,@function
monster_fire_blaster2:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 26,8
	mr 28,3
	mr 8,9
	mr 27,4
	li 9,0
	bl fire_blaster2
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 11,g_edicts@ha
	lis 0,0xa27a
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,52719
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
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 monster_fire_blaster2,.Lfe23-monster_fire_blaster2
	.align 2
	.globl monster_fire_tracker
	.type	 monster_fire_tracker,@function
monster_fire_tracker:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 28,3
	mr 27,4
	mr 26,9
	bl fire_tracker
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 11,g_edicts@ha
	lis 0,0xa27a
	lwz 10,104(29)
	lwz 9,g_edicts@l(11)
	ori 0,0,52719
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
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 monster_fire_tracker,.Lfe24-monster_fire_tracker
	.align 2
	.globl monster_fire_heat
	.type	 monster_fire_heat,@function
monster_fire_heat:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 28,gi@ha
	mr 29,3
	la 28,gi@l(28)
	li 3,2
	lwz 11,100(28)
	mr 26,4
	mr 27,9
	mtlr 11
	blrl
	lis 11,g_edicts@ha
	lis 0,0xa27a
	lwz 10,104(28)
	lwz 9,g_edicts@l(11)
	ori 0,0,52719
	mtlr 10
	subf 29,9,29
	mullw 29,29,0
	srawi 3,29,2
	blrl
	lwz 9,100(28)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(28)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 monster_fire_heat,.Lfe25-monster_fire_heat
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
.Lfe26:
	.size	 stationarymonster_start,.Lfe26-stationarymonster_start
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
.Lfe28:
	.size	 M_FliesOff,.Lfe28-M_FliesOff
	.section	".rodata"
	.align 2
.LC78:
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
	lis 10,.LC78@ha
	stw 3,76(31)
	la 9,M_FliesOff@l(9)
	lis 11,level+4@ha
	la 10,.LC78@l(10)
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
.Lfe29:
	.size	 M_FliesOn,.Lfe29-M_FliesOn
	.align 2
	.globl monster_use
	.type	 monster_use,@function
monster_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,540(3)
	cmpwi 0,0,0
	bc 4,2,.L128
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L128
	lwz 9,264(5)
	andi. 0,9,32
	bc 4,2,.L128
	lwz 0,84(5)
	cmpwi 0,0,0
	bc 4,2,.L132
	lwz 0,776(5)
	andi. 11,0,256
	bc 12,2,.L128
.L132:
	andi. 0,9,32768
	bc 4,2,.L128
	stw 5,540(3)
	bl FoundTarget
.L128:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 monster_use,.Lfe30-monster_use
	.section	".rodata"
	.align 2
.LC79:
	.long 0x3f800000
	.align 2
.LC80:
	.long 0x0
	.align 2
.LC81:
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
	lis 9,.LC79@ha
	mr 31,3
	la 9,.LC79@l(9)
	lfs 0,12(31)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(31)
	bl KillBox
	lis 9,sv_edit@ha
	li 0,2
	lwz 11,sv_edit@l(9)
	lis 9,.LC80@ha
	stw 0,248(31)
	la 9,.LC80@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L135
	lwz 0,184(31)
	ori 0,0,2
	stw 0,184(31)
.L135:
	lwz 0,184(31)
	li 9,5
	lis 11,level+4@ha
	stw 9,260(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	lis 9,.LC81@ha
	stw 0,184(31)
	la 9,.LC81@l(9)
	lfs 13,0(9)
	lfs 0,level+4@l(11)
	lis 9,gi+72@ha
	fadds 0,0,13
	stfs 0,404(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	bl monster_start_go
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L136
	lwz 0,284(31)
	andi. 11,0,1
	bc 4,2,.L136
	lwz 0,264(9)
	andi. 9,0,32
	bc 4,2,.L136
	andi. 11,0,32768
	bc 4,2,.L137
	mr 3,31
	bl FoundTarget
	b .L139
.L137:
	stw 9,540(31)
	b .L139
.L136:
	li 0,0
	stw 0,540(31)
.L139:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe31:
	.size	 monster_triggered_spawn,.Lfe31-monster_triggered_spawn
	.section	".rodata"
	.align 3
.LC82:
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
	lis 11,.LC82@ha
	stw 9,436(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC82@l(11)
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
.Lfe32:
	.size	 monster_triggered_spawn_use,.Lfe32-monster_triggered_spawn_use
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
.Lfe33:
	.size	 monster_triggered_start,.Lfe33-monster_triggered_start
	.section	".rodata"
	.align 2
.LC83:
	.long 0x3f800000
	.align 2
.LC84:
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
	bc 4,2,.L192
	lis 11,.LC83@ha
	lis 9,level+4@ha
	la 11,.LC83@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,0,.L192
	bl M_droptofloor
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L192
	lis 9,.LC84@ha
	lis 11,.LC84@ha
	la 9,.LC84@l(9)
	la 11,.LC84@l(11)
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(11)
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L192
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC65@ha
	la 3,.LC65@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L192:
	lis 9,.LC84@ha
	lfs 0,420(31)
	la 9,.LC84@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L195
	lis 0,0x41a0
	stw 0,420(31)
.L195:
	li 0,25
	mr 3,31
	stw 0,508(31)
	bl monster_start_go
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L196
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
.L196:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 walkmonster_start_go,.Lfe34-walkmonster_start_go
	.section	".rodata"
	.align 2
.LC85:
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
	lis 9,.LC85@ha
	mr 31,3
	la 9,.LC85@l(9)
	lfs 1,0(9)
	lis 9,.LC85@ha
	la 9,.LC85@l(9)
	lfs 2,0(9)
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L200
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC65@ha
	la 3,.LC65@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L200:
	lis 9,.LC85@ha
	lfs 0,420(31)
	la 9,.LC85@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L201
	lis 0,0x4120
	stw 0,420(31)
.L201:
	li 0,25
	mr 3,31
	stw 0,508(31)
	bl monster_start_go
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L202
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
.L202:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 flymonster_start_go,.Lfe35-flymonster_start_go
	.section	".rodata"
	.align 2
.LC86:
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
	lis 9,.LC86@ha
	mr 31,3
	la 9,.LC86@l(9)
	lfs 0,420(31)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L206
	lis 0,0x4120
	stw 0,420(31)
.L206:
	li 0,10
	mr 3,31
	stw 0,508(31)
	bl monster_start_go
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L207
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
.L207:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 swimmonster_start_go,.Lfe36-swimmonster_start_go
	.section	".rodata"
	.align 2
.LC87:
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
	lis 9,.LC87@ha
	mr 31,3
	la 9,.LC87@l(9)
	lfs 0,420(31)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L219
	lis 0,0x41a0
	stw 0,420(31)
.L219:
	mr 3,31
	bl monster_start_go
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L220
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
.L220:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe37:
	.size	 stationarymonster_start_go,.Lfe37-stationarymonster_start_go
	.section	".rodata"
	.align 2
.LC88:
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
	lis 10,.LC88@ha
	stw 11,260(31)
	lis 8,level+4@ha
	rlwinm 9,9,0,0,30
	stw 0,248(31)
	la 10,.LC88@l(10)
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
	bc 12,2,.L211
	lwz 0,284(31)
	andi. 10,0,1
	bc 4,2,.L211
	lwz 0,264(9)
	andi. 9,0,32
	bc 4,2,.L211
	andi. 11,0,32768
	bc 4,2,.L212
	mr 3,31
	bl FoundTarget
	b .L214
.L212:
	stw 9,540(31)
	b .L214
.L211:
	li 0,0
	stw 0,540(31)
.L214:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe38:
	.size	 stationarymonster_triggered_spawn,.Lfe38-stationarymonster_triggered_spawn
	.section	".rodata"
	.align 3
.LC89:
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
	lis 11,.LC89@ha
	stw 9,436(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC89@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	lwz 0,84(5)
	cmpwi 0,0,0
	bc 12,2,.L216
	stw 5,540(3)
.L216:
	lis 9,monster_use@ha
	la 9,monster_use@l(9)
	stw 9,448(3)
	blr
.Lfe39:
	.size	 stationarymonster_triggered_spawn_use,.Lfe39-stationarymonster_triggered_spawn_use
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
.Lfe40:
	.size	 stationarymonster_triggered_start,.Lfe40-stationarymonster_triggered_start
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
