	.file	"g_phys.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 stuff_light,@object
	.size	 stuff_light,4
stuff_light:
	.long 1
	.section	".rodata"
	.align 2
.LC1:
	.string	"NULL ent->think"
	.align 3
.LC4:
	.long 0x3fe66666
	.long 0x66666666
	.align 3
.LC5:
	.long 0xbfb99999
	.long 0x9999999a
	.align 3
.LC6:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC7:
	.long 0x0
	.align 2
.LC8:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SV_FlyMove
	.type	 SV_FlyMove,@function
SV_FlyMove:
	stwu 1,-352(1)
	mflr 0
	stfd 29,328(1)
	stfd 30,336(1)
	stfd 31,344(1)
	stmw 14,256(1)
	stw 0,356(1)
	mr 29,3
	addi 9,1,200
	fmr 30,1
	lfs 0,376(29)
	addi 7,29,200
	addi 0,29,188
	stw 7,224(1)
	li 20,0
	addi 11,1,136
	stw 0,236(1)
	lis 7,.LC7@ha
	li 19,0
	lfs 13,380(29)
	la 7,.LC7@l(7)
	lis 16,vec3_origin@ha
	lfs 12,384(29)
	addi 14,29,4
	addi 15,29,376
	lfs 29,0(7)
	la 21,vec3_origin@l(16)
	stw 9,232(1)
	stfs 0,88(1)
	stfs 13,92(1)
	stw 4,216(1)
	stfs 12,96(1)
	stfs 0,104(1)
	stw 20,220(1)
	stw 11,228(1)
	stfs 13,108(1)
	stfs 12,112(1)
	stw 19,552(29)
.L39:
	li 11,3
	li 9,0
	mtctr 11
.L85:
	lfsx 0,9,15
	addi 7,1,200
	lfsx 13,9,14
	fmadds 0,30,0,13
	stfsx 0,9,7
	addi 9,9,4
	bdnz .L85
	lis 9,gi@ha
	lwz 3,228(1)
	mr 4,14
	la 9,gi@l(9)
	lwz 5,236(1)
	mr 8,29
	lwz 11,48(9)
	lwz 6,224(1)
	lwz 7,232(1)
	mtlr 11
	lwz 9,216(1)
	blrl
	lwz 0,136(1)
	cmpwi 0,0,0
	bc 12,2,.L45
	lfs 0,vec3_origin@l(16)
	li 3,3
	b .L86
.L45:
	lfs 0,144(1)
	fcmpu 0,0,29
	bc 4,1,.L46
	lfs 9,148(1)
	li 20,0
	lfs 0,152(1)
	lfs 13,156(1)
	lfs 12,376(29)
	lfs 11,380(29)
	lfs 10,384(29)
	stfs 9,4(29)
	stfs 0,8(29)
	stfs 13,12(29)
	stfs 12,104(1)
	stfs 11,108(1)
	stfs 10,112(1)
.L46:
	lis 7,.LC8@ha
	lfs 13,144(1)
	la 7,.LC8@l(7)
	lfs 0,0(7)
	fcmpu 0,13,0
	bc 12,2,.L37
	lfs 0,168(1)
	lis 9,.LC4@ha
	lfd 13,.LC4@l(9)
	lwz 9,188(1)
	fcmpu 0,0,13
	bc 4,1,.L48
	lwz 0,248(9)
	ori 19,19,1
	cmpwi 0,0,3
	bc 4,2,.L48
	stw 9,552(29)
	lwz 0,92(9)
	stw 0,556(29)
.L48:
	lfs 0,168(1)
	ori 9,19,2
	lwz 11,444(29)
	lwz 30,188(1)
	fcmpu 7,0,29
	cmpwi 0,11,0
	crnor 31,30,30
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,19,0
	or 19,0,9
	bc 12,2,.L51
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 12,2,.L51
	mr 3,29
	mr 4,30
	lwz 6,180(1)
	mtlr 11
	addi 5,1,160
	blrl
.L51:
	lwz 9,444(30)
	cmpwi 0,9,0
	bc 12,2,.L53
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 12,2,.L53
	mr 3,30
	mr 4,29
	mtlr 9
	li 5,0
	li 6,0
	blrl
.L53:
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L37
	lfs 0,144(1)
	cmpwi 0,20,4
	fmuls 0,30,0
	fsubs 30,30,0
	bc 4,1,.L55
	lfs 0,vec3_origin@l(16)
	li 3,3
	b .L86
.L55:
	lfs 0,160(1)
	mulli 0,20,12
	addi 9,1,24
	addi 11,1,28
	addi 20,20,1
	li 27,0
	mr 23,9
	cmpw 0,27,20
	stfsx 0,9,0
	mr 17,11
	lfs 13,164(1)
	addi 9,1,32
	mr 18,9
	stfsx 13,11,0
	lfs 0,168(1)
	stfsx 0,9,0
	bc 4,0,.L57
	addi 22,1,104
	addi 25,1,120
	li 24,0
.L59:
	mulli 10,27,12
	addi 0,1,8
	add 10,10,0
	addi 10,10,16
	lfs 10,8(10)
	lfs 11,4(10)
	li 7,3
	lis 9,.LC5@ha
	lfs 12,108(1)
	lis 11,.LC6@ha
	mtctr 7
	li 0,0
	lfs 0,104(1)
	li 8,0
	lfs 13,0(10)
	fmuls 12,12,11
	lfd 8,.LC5@l(9)
	lfs 11,112(1)
	lfd 9,.LC6@l(11)
	fmadds 0,0,13,12
	fmadds 12,11,10,0
.L84:
	lfsx 0,8,10
	lfsx 13,8,22
	fmuls 0,0,12
	fsubs 13,13,0
	fmr 0,13
	stfsx 13,8,25
	fcmpu 0,0,8
	bc 4,1,.L66
	fcmpu 0,0,9
	bc 4,0,.L66
	stwx 0,8,25
.L66:
	addi 8,8,4
	bdnz .L84
	li 28,0
	cmpw 0,28,20
	bc 4,0,.L70
	lis 9,.LC7@ha
	mr 26,23
	la 9,.LC7@l(9)
	mr 30,23
	lfs 31,0(9)
	li 31,0
.L72:
	cmpw 0,28,27
	bc 12,2,.L71
	add 3,26,24
	mr 4,30
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L71
	lfsx 0,31,17
	lfs 11,124(1)
	lfs 12,120(1)
	lfsx 10,31,23
	fmuls 11,11,0
	lfsx 13,31,18
	lfs 0,128(1)
	fmadds 12,12,10,11
	fmadds 0,0,13,12
	fcmpu 0,0,31
	bc 12,0,.L70
.L71:
	addi 28,28,1
	addi 30,30,12
	cmpw 0,28,20
	addi 31,31,12
	bc 12,0,.L72
.L70:
	cmpw 0,28,20
	bc 12,2,.L57
	addi 27,27,1
	addi 24,24,12
	cmpw 0,27,20
	bc 12,0,.L59
.L57:
	cmpw 0,27,20
	bc 12,2,.L78
	lfs 0,120(1)
	lfs 13,124(1)
	lfs 12,128(1)
	stfs 0,376(29)
	stfs 13,380(29)
	stfs 12,384(29)
	b .L79
.L78:
	cmpwi 0,20,2
	bc 12,2,.L80
	lfs 0,vec3_origin@l(16)
	li 3,7
	b .L86
.L80:
	mr 3,23
	addi 4,1,36
	addi 5,1,8
	bl CrossProduct
	lfs 0,380(29)
	addi 3,1,8
	mr 4,15
	lfs 13,12(1)
	lfs 1,8(1)
	lfs 12,376(29)
	fmuls 13,13,0
	lfs 11,16(1)
	lfs 0,384(29)
	fmadds 1,1,12,13
	fmadds 1,11,0,1
	bl VectorScale
.L79:
	lfs 0,92(1)
	lfs 11,380(29)
	lfs 13,376(29)
	lfs 10,88(1)
	fmuls 11,11,0
	lfs 12,96(1)
	lfs 0,384(29)
	fmadds 13,13,10,11
	fmadds 0,0,12,13
	fcmpu 0,0,29
	cror 3,2,0
	bc 4,3,.L38
	lfs 0,vec3_origin@l(16)
	mr 3,19
.L86:
	stfs 0,376(29)
	lfs 13,4(21)
	stfs 13,380(29)
	lfs 0,8(21)
	stfs 0,384(29)
	b .L83
.L38:
	lwz 7,220(1)
	addi 7,7,1
	cmpwi 0,7,4
	stw 7,220(1)
	bc 12,0,.L39
.L37:
	mr 3,19
.L83:
	lwz 0,356(1)
	mtlr 0
	lmw 14,256(1)
	lfd 29,328(1)
	lfd 30,336(1)
	lfd 31,344(1)
	la 1,352(1)
	blr
.Lfe1:
	.size	 SV_FlyMove,.Lfe1-SV_FlyMove
	.section	".rodata"
	.align 3
.LC10:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl SV_PushEntity
	.type	 SV_PushEntity,@function
SV_PushEntity:
	stwu 1,-128(1)
	mflr 0
	stmw 26,104(1)
	stw 0,132(1)
	mr 31,4
	lfs 12,8(5)
	mr 28,3
	lfs 10,4(31)
	addi 26,1,72
	addi 27,1,88
	lfs 11,8(31)
	addi 30,1,8
	lfs 9,12(31)
	lfs 0,0(5)
	lfs 13,4(5)
	fadds 12,9,12
	stfs 10,72(1)
	fadds 0,10,0
	stfs 11,76(1)
	fadds 13,11,13
	stfs 9,80(1)
	stfs 12,96(1)
	stfs 0,88(1)
	stfs 13,92(1)
.L89:
	lwz 0,252(31)
	lis 29,gi@ha
	addi 3,1,8
	la 29,gi@l(29)
	mr 4,26
	addic 9,0,-1
	subfe 9,9,9
	lwz 10,48(29)
	addi 5,31,188
	andc 0,0,9
	addi 6,31,200
	rlwinm 9,9,0,30,31
	mtlr 10
	mr 7,27
	or 9,9,0
	mr 8,31
	blrl
	lfs 0,24(1)
	mr 3,31
	lfs 13,28(1)
	lfs 12,20(1)
	stfs 0,8(31)
	stfs 13,12(31)
	stfs 12,4(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lfs 0,16(1)
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L92
	lwz 9,444(31)
	lwz 29,52(30)
	cmpwi 0,9,0
	bc 12,2,.L93
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L93
	mr 3,31
	mr 4,29
	lwz 6,44(30)
	mtlr 9
	addi 5,1,32
	blrl
.L93:
	lwz 9,444(29)
	cmpwi 0,9,0
	bc 12,2,.L95
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 12,2,.L95
	mr 3,29
	mr 4,31
	mtlr 9
	li 5,0
	li 6,0
	blrl
.L95:
	lwz 9,60(1)
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 4,2,.L92
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L97
	lfs 12,72(1)
	lis 9,gi+72@ha
	mr 3,31
	lfs 0,76(1)
	lfs 13,80(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	b .L89
.L92:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L97
	mr 3,31
	bl G_TouchTriggers
.L97:
	mr 4,30
	mr 3,28
	li 5,56
	crxor 6,6,6
	bl memcpy
	mr 3,28
	lwz 0,132(1)
	mtlr 0
	lmw 26,104(1)
	la 1,128(1)
	blr
.Lfe2:
	.size	 SV_PushEntity,.Lfe2-SV_PushEntity
	.section	".rodata"
	.align 3
.LC11:
	.long 0x40200000
	.long 0x0
	.align 3
.LC12:
	.long 0x0
	.long 0x0
	.align 3
.LC13:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC15:
	.long 0x3fc00000
	.long 0x0
	.section	".text"
	.align 2
	.globl SV_Push
	.type	 SV_Push,@function
SV_Push:
	stwu 1,-272(1)
	mflr 0
	stmw 18,216(1)
	stw 0,276(1)
	lis 9,.LC11@ha
	lis 11,.LC13@ha
	la 9,.LC11@l(9)
	la 11,.LC13@l(11)
	lis 10,.LC12@ha
	lfd 8,0(9)
	mr 26,4
	la 10,.LC12@l(10)
	lfd 12,0(11)
	lis 9,.LC14@ha
	lfd 9,0(10)
	li 11,3
	la 9,.LC14@l(9)
	lis 10,.LC15@ha
	mtctr 11
	lfd 10,0(9)
	mr 28,3
	la 10,.LC15@l(10)
	mr 25,5
	lfd 11,0(10)
	addi 8,1,8
	addi 31,1,24
	addi 3,1,40
	addi 4,1,88
	addi 5,1,104
	addi 6,1,120
	lis 20,pushed_p@ha
	lis 21,g_edicts@ha
	lis 18,globals@ha
	lis 19,pushed@ha
	lis 0,0x4330
	mr 10,26
.L156:
	lfs 0,0(10)
	fmul 0,0,8
	frsp 0,0
	fcmpu 0,0,9
	bc 4,1,.L103
	fadd 0,0,12
	b .L157
.L103:
	fsub 0,0,12
.L157:
	frsp 0,0
	fmr 13,0
	mr 11,9
	fctiwz 0,13
	stfd 0,208(1)
	lwz 9,212(1)
	xoris 9,9,0x8000
	stw 9,212(1)
	stw 0,208(1)
	lfd 0,208(1)
	fsub 0,0,10
	fmul 0,0,11
	frsp 0,0
	stfs 0,0(10)
	addi 10,10,4
	bdnz .L156
	li 0,3
	mr 7,8
	mtctr 0
	mr 8,31
	addi 10,28,212
	addi 11,28,224
	li 9,0
.L155:
	lfsx 0,9,26
	lfsx 13,9,10
	lfsx 12,9,11
	fadds 13,13,0
	fadds 12,12,0
	stfsx 13,9,7
	stfsx 12,9,8
	addi 9,9,4
	bdnz .L155
	lis 9,vec3_origin@ha
	lfs 10,0(25)
	lfs 12,vec3_origin@l(9)
	la 11,vec3_origin@l(9)
	lfs 13,4(25)
	lfs 11,8(11)
	fsubs 12,12,10
	lfs 0,4(11)
	lfs 10,8(25)
	fsubs 0,0,13
	stfs 12,40(1)
	fsubs 11,11,10
	stfs 0,44(1)
	stfs 11,48(1)
	bl AngleVectors
	lis 9,pushed_p@ha
	lwz 10,pushed_p@l(9)
	stw 28,0(10)
	lfs 0,4(28)
	stfs 0,4(10)
	lfs 13,8(28)
	stfs 13,8(10)
	lfs 0,12(28)
	stfs 0,12(10)
	lfs 13,16(28)
	stfs 13,16(10)
	lfs 0,20(28)
	stfs 0,20(10)
	lfs 13,24(28)
	stfs 13,24(10)
	lwz 9,84(28)
	cmpwi 0,9,0
	bc 12,2,.L111
	lha 0,22(9)
	lis 11,0x4330
	lis 8,.LC14@ha
	la 8,.LC14@l(8)
	xoris 0,0,0x8000
	lfd 13,0(8)
	stw 0,212(1)
	stw 11,208(1)
	lfd 0,208(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,28(10)
.L111:
	lwz 9,pushed_p@l(20)
	lis 11,gi@ha
	mr 3,28
	lfs 11,4(28)
	la 31,gi@l(11)
	li 22,1
	lfs 13,8(28)
	addi 9,9,32
	stw 9,pushed_p@l(20)
	lfs 0,0(26)
	lfs 12,12(28)
	lfs 10,16(28)
	fadds 11,11,0
	lfs 9,20(28)
	lfs 8,24(28)
	stfs 11,4(28)
	lfs 0,4(26)
	fadds 13,13,0
	stfs 13,8(28)
	lfs 0,8(26)
	fadds 12,12,0
	stfs 12,12(28)
	lfs 0,0(25)
	fadds 10,10,0
	stfs 10,16(28)
	lfs 0,4(25)
	fadds 9,9,0
	stfs 9,20(28)
	lfs 0,8(25)
	fadds 8,8,0
	stfs 8,24(28)
	lwz 9,72(31)
	mtlr 9
	blrl
	lis 9,globals+72@ha
	lis 11,g_edicts@ha
	lwz 0,globals+72@l(9)
	lwz 4,g_edicts@l(11)
	cmpw 0,22,0
	addi 27,4,952
	bc 4,0,.L113
	mr 23,31
	lis 24,pushed_p@ha
	addi 31,4,956
.L115:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L114
	lwz 11,256(31)
	addi 0,11,-2
	subfic 8,11,0
	adde 9,8,11
	subfic 0,0,1
	li 0,0
	adde 0,0,0
	or. 30,0,9
	bc 4,2,.L114
	cmpwi 0,11,1
	bc 12,2,.L114
	lwz 0,92(31)
	cmpwi 0,0,0
	bc 12,2,.L114
	lwz 0,548(31)
	cmpw 0,0,28
	bc 12,2,.L120
	lfs 13,208(31)
	lfs 0,24(1)
	fcmpu 0,13,0
	cror 3,2,1
	bc 12,3,.L114
	lfs 13,212(31)
	lfs 0,28(1)
	fcmpu 0,13,0
	cror 3,2,1
	bc 12,3,.L114
	lfs 13,216(31)
	lfs 0,32(1)
	fcmpu 0,13,0
	cror 3,2,1
	bc 12,3,.L114
	lfs 13,220(31)
	lfs 0,8(1)
	fcmpu 0,13,0
	cror 3,2,0
	bc 12,3,.L114
	lfs 13,224(31)
	lfs 0,12(1)
	fcmpu 0,13,0
	cror 3,2,0
	bc 12,3,.L114
	lfs 13,228(31)
	lfs 0,16(1)
	fcmpu 0,13,0
	cror 3,2,0
	bc 12,3,.L114
	lwz 0,248(31)
	mr 8,27
	addi 3,1,136
	lwz 11,48(23)
	mr 4,31
	addi 5,27,188
	addic 9,0,-1
	subfe 9,9,9
	addi 6,27,200
	andc 0,0,9
	mtlr 11
	mr 7,31
	rlwinm 9,9,0,30,31
	or 9,9,0
	blrl
	lwz 9,140(1)
	lwz 11,g_edicts@l(21)
	srawi 8,9,31
	xor 0,8,9
	subf 0,0,8
	srawi 0,0,31
	and. 9,11,0
	bc 12,2,.L114
.L120:
	lwz 0,260(28)
	cmpwi 0,0,2
	bc 12,2,.L129
	lwz 0,548(31)
	cmpw 0,0,28
	bc 4,2,.L128
.L129:
	lwz 9,pushed_p@l(24)
	stw 27,0(9)
	addi 0,9,32
	lfs 0,0(31)
	stfs 0,4(9)
	lfs 13,4(31)
	stfs 13,8(9)
	lfs 0,8(31)
	stfs 0,12(9)
	lfs 13,12(31)
	stfs 13,16(9)
	lfs 0,16(31)
	stfs 0,20(9)
	lfs 13,20(31)
	stfs 13,24(9)
	lwz 8,80(31)
	stw 0,pushed_p@l(24)
	lfs 0,0(26)
	cmpwi 0,8,0
	lfs 13,0(31)
	lfs 12,4(31)
	lfs 11,8(31)
	fadds 13,13,0
	stfs 13,0(31)
	lfs 0,4(26)
	fadds 12,12,0
	stfs 12,4(31)
	lfs 0,8(26)
	fadds 11,11,0
	stfs 11,8(31)
	bc 12,2,.L130
	lha 0,22(8)
	lis 10,0x4330
	lis 11,.LC14@ha
	lfs 11,4(25)
	xoris 0,0,0x8000
	la 11,.LC14@l(11)
	stw 0,212(1)
	stw 10,208(1)
	lfd 13,0(11)
	lfd 0,208(1)
	mr 11,9
	fsub 0,0,13
	frsp 0,0
	fadds 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,208(1)
	lwz 11,212(1)
	sth 11,22(8)
.L130:
	lfs 0,4(28)
	lfs 9,0(31)
	lfs 13,8(28)
	lfs 5,92(1)
	fsubs 9,9,0
	lfs 4,108(1)
	lfs 3,124(1)
	lfs 8,88(1)
	stfs 9,40(1)
	lfs 0,4(31)
	lfs 10,12(28)
	lfs 7,104(1)
	fsubs 0,0,13
	lfs 6,120(1)
	lfs 12,96(1)
	lfs 11,112(1)
	stfs 0,44(1)
	fmuls 5,0,5
	lfs 13,8(31)
	fmuls 4,0,4
	fmuls 3,0,3
	fmadds 8,9,8,5
	fsubs 13,13,10
	lfs 10,128(1)
	fmadds 7,9,7,4
	fmadds 6,9,6,3
	fmadds 12,13,12,8
	stfs 13,48(1)
	fnmadds 11,13,11,7
	fmadds 10,13,10,6
	fsubs 9,12,9
	stfs 12,56(1)
	fsubs 0,11,0
	stfs 11,60(1)
	fsubs 13,10,13
	stfs 10,64(1)
	stfs 9,72(1)
	stfs 0,76(1)
	stfs 13,80(1)
	lfs 0,0(31)
	lfs 13,4(31)
	lfs 12,8(31)
	fadds 0,0,9
	lwz 0,548(31)
	cmpw 0,0,28
	stfs 0,0(31)
	lfs 0,76(1)
	fadds 13,13,0
	stfs 13,4(31)
	lfs 0,80(1)
	fadds 12,12,0
	stfs 12,8(31)
	bc 12,2,.L131
	stw 30,548(31)
.L131:
	lwz 0,248(31)
	addi 30,27,188
	addi 29,27,200
	lwz 11,48(23)
	mr 8,27
	addi 3,1,136
	addic 9,0,-1
	subfe 9,9,9
	mr 4,31
	andc 0,0,9
	mtlr 11
	mr 5,30
	rlwinm 9,9,0,30,31
	mr 6,29
	or 9,9,0
	mr 7,31
	blrl
	lwz 9,140(1)
	lwz 11,g_edicts@l(21)
	srawi 8,9,31
	xor 0,8,9
	subf 0,0,8
	srawi 0,0,31
	and. 9,11,0
	bc 4,2,.L136
	lwz 9,72(23)
	mr 3,27
	mtlr 9
	blrl
	b .L114
.L136:
	lfs 11,0(26)
	mr 8,27
	mr 5,30
	lfs 0,0(31)
	mr 6,29
	addi 3,1,136
	lfs 12,4(31)
	mr 4,31
	mr 7,31
	lfs 13,8(31)
	fsubs 0,0,11
	lwz 0,248(31)
	addic 9,0,-1
	subfe 9,9,9
	stfs 0,0(31)
	andc 0,0,9
	lfs 0,4(26)
	rlwinm 9,9,0,30,31
	or 9,9,0
	fsubs 12,12,0
	stfs 12,4(31)
	lfs 0,8(26)
	fsubs 13,13,0
	stfs 13,8(31)
	lwz 11,48(23)
	mtlr 11
	blrl
	lwz 9,140(1)
	lwz 11,g_edicts@l(21)
	srawi 8,9,31
	xor 0,8,9
	subf 0,0,8
	srawi 0,0,31
	and. 9,11,0
	bc 4,2,.L128
	lwz 9,pushed_p@l(24)
	addi 9,9,-32
	stw 9,pushed_p@l(24)
	b .L114
.L128:
	lwz 11,pushed_p@l(20)
	la 0,pushed@l(19)
	lis 9,obstacle@ha
	stw 27,obstacle@l(9)
	addi 31,11,-32
	cmplw 0,31,0
	bc 12,0,.L143
	lis 9,gi@ha
	mr 29,0
	la 30,gi@l(9)
.L145:
	lfs 0,4(31)
	lwz 9,0(31)
	stfs 0,4(9)
	lfs 0,8(31)
	lwz 11,0(31)
	stfs 0,8(11)
	lfs 0,12(31)
	lwz 9,0(31)
	stfs 0,12(9)
	lfs 0,16(31)
	lwz 11,0(31)
	stfs 0,16(11)
	lfs 0,20(31)
	lwz 9,0(31)
	stfs 0,20(9)
	lfs 0,24(31)
	lwz 11,0(31)
	stfs 0,24(11)
	lwz 9,0(31)
	lwz 11,84(9)
	cmpwi 0,11,0
	bc 12,2,.L146
	lfs 0,28(31)
	fctiwz 13,0
	stfd 13,208(1)
	lwz 9,212(1)
	sth 9,22(11)
.L146:
	lwz 9,72(30)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,-32
	blrl
	cmplw 0,31,29
	bc 4,0,.L145
.L143:
	li 3,0
	b .L154
.L114:
	la 9,globals@l(18)
	addi 22,22,1
	lwz 0,72(9)
	addi 31,31,952
	addi 27,27,952
	cmpw 0,22,0
	bc 12,0,.L115
.L113:
	lis 9,pushed_p@ha
	lis 11,pushed@ha
	lwz 10,pushed_p@l(9)
	la 11,pushed@l(11)
	addi 31,10,-32
	cmplw 0,31,11
	bc 12,0,.L150
	mr 30,11
.L152:
	lwz 3,0(31)
	addi 31,31,-32
	bl G_TouchTriggers
	cmplw 0,31,30
	bc 4,0,.L152
.L150:
	li 3,1
.L154:
	lwz 0,276(1)
	mtlr 0
	lmw 18,216(1)
	la 1,272(1)
	blr
.Lfe3:
	.size	 SV_Push,.Lfe3-SV_Push
	.section	".rodata"
	.align 2
.LC17:
	.string	"pushed_p > &pushed[MAX_EDICTS], memory corrupted"
	.align 2
.LC16:
	.long 0x3dcccccd
	.align 3
.LC18:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC19:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC20:
	.long 0x0
	.section	".text"
	.align 2
	.globl SV_Physics_Pusher
	.type	 SV_Physics_Pusher,@function
SV_Physics_Pusher:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 28,48(1)
	stw 0,84(1)
	mr 29,3
	lwz 0,264(29)
	andi. 9,0,1024
	bc 4,2,.L158
	lis 9,pushed@ha
	mr. 31,29
	la 9,pushed@l(9)
	lis 11,pushed_p@ha
	stw 9,pushed_p@l(11)
	bc 12,2,.L161
	lis 11,.LC20@ha
	lis 28,.LC16@ha
	la 11,.LC20@l(11)
	addi 30,1,24
	lfs 31,0(11)
.L163:
	lfs 0,376(31)
	fcmpu 0,0,31
	bc 4,2,.L165
	lfs 0,380(31)
	fcmpu 0,0,31
	bc 4,2,.L165
	lfs 0,384(31)
	fcmpu 0,0,31
	bc 4,2,.L165
	lfs 0,388(31)
	fcmpu 0,0,31
	bc 4,2,.L165
	lfs 0,392(31)
	fcmpu 0,0,31
	bc 4,2,.L165
	lfs 0,396(31)
	fcmpu 0,0,31
	bc 12,2,.L162
.L165:
	lfs 1,.LC16@l(28)
	addi 4,1,8
	addi 3,31,376
	bl VectorScale
	lfs 1,.LC16@l(28)
	addi 3,31,388
	mr 4,30
	bl VectorScale
	mr 3,31
	addi 4,1,8
	mr 5,30
	bl SV_Push
	cmpwi 0,3,0
	bc 12,2,.L161
.L162:
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L163
.L161:
	lis 9,pushed_p@ha
	lis 11,pushed+32768@ha
	lwz 0,pushed_p@l(9)
	la 11,pushed+32768@l(11)
	cmplw 0,0,11
	bc 4,1,.L168
	lis 9,gi+28@ha
	lis 4,.LC17@ha
	lwz 0,gi+28@l(9)
	la 4,.LC17@l(4)
	li 3,0
	mtlr 0
	crxor 6,6,6
	blrl
.L168:
	cmpwi 0,31,0
	bc 12,2,.L169
	mr 3,29
	cmpwi 0,3,0
	bc 12,2,.L171
	lis 11,.LC20@ha
	lis 9,.LC18@ha
	la 11,.LC20@l(11)
	lfd 13,.LC18@l(9)
	lfs 12,0(11)
.L173:
	lfs 0,428(3)
	fcmpu 0,0,12
	bc 4,1,.L172
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
.L172:
	lwz 3,560(3)
	cmpwi 0,3,0
	bc 4,2,.L173
.L171:
	lwz 0,440(31)
	cmpwi 0,0,0
	bc 12,2,.L158
	lis 9,obstacle@ha
	mr 3,31
	mtlr 0
	lwz 4,obstacle@l(9)
	blrl
	b .L158
.L169:
	mr. 31,29
	bc 12,2,.L158
	lis 9,.LC19@ha
	lis 11,level@ha
	lfd 30,.LC19@l(9)
	la 28,level@l(11)
	lis 30,.LC1@ha
	lis 9,gi@ha
	la 29,gi@l(9)
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 31,0(9)
.L181:
	lfs 13,428(31)
	fcmpu 0,13,31
	cror 3,2,0
	bc 12,3,.L180
	lfs 0,4(28)
	fadd 0,0,30
	fcmpu 0,13,0
	bc 12,1,.L180
	lwz 0,436(31)
	stfs 31,428(31)
	cmpwi 0,0,0
	bc 4,2,.L185
	lwz 9,28(29)
	la 3,.LC1@l(30)
	mtlr 9
	crxor 6,6,6
	blrl
.L185:
	lwz 9,436(31)
	mr 3,31
	mtlr 9
	blrl
.L180:
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L181
.L158:
	lwz 0,84(1)
	mtlr 0
	lmw 28,48(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe4:
	.size	 SV_Physics_Pusher,.Lfe4-SV_Physics_Pusher
	.section	".rodata"
	.align 2
.LC29:
	.string	"misc/h2ohit1.wav"
	.align 3
.LC24:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 3
.LC25:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC26:
	.long 0x3dcccccd
	.align 3
.LC27:
	.long 0xbfb99999
	.long 0x9999999a
	.align 3
.LC28:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC30:
	.long 0x0
	.align 2
.LC31:
	.long 0x3f800000
	.align 2
.LC32:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl SV_Physics_Toss
	.type	 SV_Physics_Toss,@function
SV_Physics_Toss:
	stwu 1,-144(1)
	mflr 0
	stmw 27,124(1)
	stw 0,148(1)
	lis 6,.LC30@ha
	mr 31,3
	la 6,.LC30@l(6)
	lfs 12,428(31)
	lfs 11,0(6)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L200
	lis 9,level+4@ha
	lis 11,.LC24@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC24@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L200
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L202
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L202:
	lwz 9,436(31)
	mr 3,31
	mtlr 9
	blrl
.L200:
	lwz 0,264(31)
	andi. 0,0,1024
	bc 4,2,.L198
	lis 6,.LC30@ha
	lfs 13,384(31)
	la 6,.LC30@l(6)
	lfs 0,0(6)
	fcmpu 0,13,0
	bc 4,1,.L204
	stw 0,552(31)
.L204:
	lwz 9,552(31)
	cmpwi 0,9,0
	bc 12,2,.L245
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 4,2,.L205
	stw 0,552(31)
.L205:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L198
.L245:
	li 0,3
	lfs 12,4(31)
	lis 9,sv_maxvelocity@ha
	lfs 13,8(31)
	mtctr 0
	addi 27,31,376
	addi 3,31,16
	lfs 0,12(31)
	mr 11,27
	addi 4,31,388
	lwz 10,sv_maxvelocity@l(9)
	addi 30,1,72
	li 9,0
	stfs 12,88(1)
	stfs 13,92(1)
	stfs 0,96(1)
.L247:
	lfsx 13,9,11
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 12,1,.L248
	fneg 0,0
	fcmpu 0,13,0
	bc 4,0,.L214
.L248:
	stfsx 0,9,27
.L214:
	addi 9,9,4
	bdnz .L247
	lwz 0,260(31)
	xori 10,0,8
	xori 0,0,6
	addic 6,0,-1
	subfe 11,6,0
	addic 0,10,-1
	subfe 9,0,10
	and. 6,11,9
	bc 12,2,.L217
	lis 10,sv_gravity@ha
	lfs 13,408(31)
	lis 9,.LC25@ha
	lwz 11,sv_gravity@l(10)
	lfd 11,.LC25@l(9)
	lfs 12,20(11)
	lfs 0,384(31)
	fmuls 13,13,12
	fmul 13,13,11
	fsub 0,0,13
	frsp 0,0
	stfs 0,384(31)
.L217:
	lis 29,.LC26@ha
	mr 5,3
	lfs 1,.LC26@l(29)
	mr 28,27
	bl VectorMA
	lfs 1,.LC26@l(29)
	mr 3,28
	mr 4,30
	bl VectorScale
	mr 5,30
	addi 3,1,8
	mr 4,31
	bl SV_PushEntity
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L198
	lis 6,.LC31@ha
	lfs 13,16(1)
	addi 30,31,4
	la 6,.LC31@l(6)
	lfs 0,0(6)
	fcmpu 0,13,0
	bc 4,0,.L220
	lwz 0,260(31)
	lis 7,0x3f80
	cmpwi 0,0,9
	bc 4,2,.L221
	lis 7,0x3fc0
.L221:
	lfs 9,40(1)
	addi 8,1,32
	lfs 12,4(28)
	li 6,3
	lis 9,.LC27@ha
	lfs 0,36(1)
	lis 11,.LC25@ha
	mtctr 6
	li 0,0
	lfs 13,376(31)
	li 10,0
	lfs 11,32(1)
	fmuls 12,12,0
	lfd 10,.LC27@l(9)
	lfs 0,8(28)
	stw 7,104(1)
	fmadds 13,13,11,12
	lfd 11,.LC25@l(11)
	fmadds 0,0,9,13
	lfs 13,104(1)
	fmuls 12,0,13
.L246:
	lfsx 0,10,8
	lfsx 13,10,27
	fmuls 0,0,12
	fsubs 13,13,0
	fmr 0,13
	stfsx 13,10,28
	fcmpu 0,0,10
	bc 4,1,.L229
	fcmpu 0,0,11
	bc 4,0,.L229
	stwx 0,10,28
.L229:
	addi 10,10,4
	bdnz .L246
	lfs 0,40(1)
	lis 9,.LC28@ha
	lfd 13,.LC28@l(9)
	fcmpu 0,0,13
	bc 4,1,.L220
	lis 6,.LC32@ha
	lfs 13,384(31)
	la 6,.LC32@l(6)
	lfs 0,0(6)
	fcmpu 0,13,0
	bc 12,0,.L234
	lwz 0,260(31)
	cmpwi 0,0,9
	bc 12,2,.L220
.L234:
	lwz 9,60(1)
	lis 11,vec3_origin@ha
	la 10,vec3_origin@l(11)
	stw 9,552(31)
	lwz 0,92(9)
	stw 0,556(31)
	lfs 0,vec3_origin@l(11)
	stfs 0,376(31)
	lfs 13,4(10)
	stfs 13,380(31)
	lfs 0,8(10)
	stfs 0,384(31)
	lfs 13,vec3_origin@l(11)
	stfs 13,388(31)
	lfs 0,4(10)
	stfs 0,392(31)
	lfs 13,8(10)
	stfs 13,396(31)
.L220:
	lis 9,gi+52@ha
	mr 3,30
	lwz 0,608(31)
	lwz 9,gi+52@l(9)
	rlwinm 29,0,0,26,28
	mtlr 9
	blrl
	andi. 11,3,56
	stw 3,608(31)
	bc 12,2,.L235
	li 0,1
	stw 0,612(31)
	b .L236
.L235:
	stw 11,612(31)
.L236:
	neg 0,11
	subfic 6,29,0
	adde 9,6,29
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L237
	lis 29,gi@ha
	lis 3,.LC29@ha
	la 29,gi@l(29)
	la 3,.LC29@l(3)
	lwz 11,36(29)
	lis 9,g_edicts@ha
	addi 27,1,88
	lwz 28,g_edicts@l(9)
	mtlr 11
	blrl
	lwz 0,20(29)
	lis 9,.LC31@ha
	lis 10,.LC31@ha
	lis 11,.LC30@ha
	mr 6,3
	la 9,.LC31@l(9)
	la 10,.LC31@l(10)
	mtlr 0
	la 11,.LC30@l(11)
	mr 4,28
	lfs 1,0(9)
	mr 3,27
	li 5,0
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L238
.L237:
	neg 0,29
	subfic 6,11,0
	adde 9,6,11
	srwi 0,0,31
	and. 10,0,9
	bc 12,2,.L238
	lis 29,gi@ha
	lis 3,.LC29@ha
	la 29,gi@l(29)
	la 3,.LC29@l(3)
	lwz 11,36(29)
	lis 9,g_edicts@ha
	lwz 28,g_edicts@l(9)
	mtlr 11
	blrl
	lwz 0,20(29)
	lis 9,.LC31@ha
	lis 10,.LC31@ha
	lis 11,.LC30@ha
	mr 6,3
	la 9,.LC31@l(9)
	la 10,.LC31@l(10)
	mtlr 0
	la 11,.LC30@l(11)
	mr 4,28
	lfs 1,0(9)
	mr 3,30
	li 5,0
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L238:
	lwz 29,560(31)
	cmpwi 0,29,0
	bc 12,2,.L198
	lis 9,gi@ha
	la 28,gi@l(9)
.L243:
	lfs 0,4(31)
	mr 3,29
	stfs 0,4(29)
	lfs 13,8(31)
	stfs 13,8(29)
	lfs 0,12(31)
	stfs 0,12(29)
	lwz 9,72(28)
	mtlr 9
	blrl
	lwz 29,560(29)
	cmpwi 0,29,0
	bc 4,2,.L243
.L198:
	lwz 0,148(1)
	mtlr 0
	lmw 27,124(1)
	la 1,144(1)
	blr
.Lfe5:
	.size	 SV_Physics_Toss,.Lfe5-SV_Physics_Toss
	.section	".rodata"
	.align 2
.LC37:
	.string	"world/land.wav"
	.align 2
.LC34:
	.long 0x3dcccccd
	.align 3
.LC35:
	.long 0xbfb99999
	.long 0x9999999a
	.align 3
.LC36:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC38:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC39:
	.long 0x0
	.align 2
.LC40:
	.long 0x42700000
	.align 2
.LC41:
	.long 0x42c80000
	.align 3
.LC42:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC43:
	.long 0x0
	.long 0x0
	.align 3
.LC44:
	.long 0x40180000
	.long 0x0
	.align 2
.LC45:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SV_Physics_Step
	.type	 SV_Physics_Step,@function
SV_Physics_Step:
	stwu 1,-48(1)
	mflr 0
	mfcr 12
	stmw 27,28(1)
	stw 0,52(1)
	stw 12,24(1)
	mr 31,3
	li 27,0
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L260
	bl M_CheckGround
.L260:
	li 8,3
	lis 9,sv_maxvelocity@ha
	lwz 0,552(31)
	mtctr 8
	addi 28,31,376
	lwz 10,sv_maxvelocity@l(9)
	mr 11,28
	li 9,0
.L321:
	lfsx 13,9,11
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 12,1,.L322
	fneg 0,0
	fcmpu 0,13,0
	bc 4,0,.L267
.L322:
	stfsx 0,9,28
.L267:
	addi 9,9,4
	bdnz .L321
	lis 9,.LC39@ha
	lfs 0,388(31)
	addic 10,0,-1
	subfe 30,10,0
	la 9,.LC39@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L273
	lfs 0,392(31)
	fcmpu 0,0,13
	bc 4,2,.L273
	lfs 0,396(31)
	cmpwi 4,30,0
	fcmpu 0,0,13
	bc 12,2,.L272
.L273:
	lis 9,.LC34@ha
	addi 3,31,16
	lfs 1,.LC34@l(9)
	addi 29,31,388
	mr 5,3
	mr 4,29
	cmpwi 4,30,0
	bl VectorMA
	lis 8,.LC40@ha
	li 10,3
	la 8,.LC40@l(8)
	lis 9,.LC39@ha
	mtctr 10
	la 9,.LC39@l(9)
	lfs 12,0(8)
	mr 11,29
	lfs 13,0(9)
	li 9,0
.L320:
	lfsx 0,9,11
	fcmpu 0,0,13
	bc 4,1,.L277
	fsubs 0,0,12
	fcmpu 0,0,13
	stfsx 0,9,29
	bc 4,0,.L281
	b .L323
.L277:
	fadds 0,0,12
	fcmpu 0,0,13
	stfsx 0,9,29
	bc 4,1,.L281
.L323:
	stfsx 13,9,29
.L281:
	addi 9,9,4
	bdnz .L320
.L272:
	bc 4,18,.L284
	lwz 0,264(31)
	andi. 11,0,1
	bc 4,2,.L319
	andi. 8,0,2
	lwz 0,612(31)
	bc 12,2,.L287
	cmpwi 0,0,2
	bc 12,1,.L284
.L287:
	lis 9,sv_gravity@ha
	lfs 0,384(31)
	lis 10,.LC35@ha
	lwz 11,sv_gravity@l(9)
	lfd 13,.LC35@l(10)
	lfs 11,20(11)
	fmr 12,0
	fmr 0,11
	fmul 0,0,13
	fcmpu 0,12,0
	bc 4,0,.L288
	li 27,1
.L288:
	cmpwi 0,0,0
	bc 4,2,.L284
	lfs 0,408(31)
	lis 9,.LC36@ha
	lfd 13,.LC36@l(9)
	fmuls 0,0,11
	fmul 0,0,13
	fsub 0,12,0
	frsp 0,0
	stfs 0,384(31)
.L284:
	lwz 0,264(31)
	andi. 9,0,1
	bc 12,2,.L291
.L319:
	lis 10,.LC39@ha
	lfs 11,384(31)
	la 10,.LC39@l(10)
	lfs 10,0(10)
	fcmpu 0,11,10
	bc 12,2,.L291
	lis 11,.LC41@ha
	fabs 1,11
	la 11,.LC41@l(11)
	lfs 0,0(11)
	fmr 13,1
	fcmpu 0,1,0
	bc 4,0,.L292
	lis 8,.LC41@ha
	la 8,.LC41@l(8)
	lfs 13,0(8)
.L292:
	lis 9,.LC36@ha
	fmr 0,13
	lfd 12,.LC36@l(9)
	fmr 13,1
	fmul 0,0,12
	fadd 0,0,0
	fsub 13,13,0
	frsp 12,13
	fcmpu 0,12,10
	bc 4,0,.L294
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 12,0(9)
.L294:
	fdivs 12,12,1
	fmuls 0,11,12
	stfs 0,384(31)
.L291:
	lwz 0,264(31)
	andi. 10,0,2
	bc 12,2,.L295
	lis 11,.LC39@ha
	lfs 9,384(31)
	la 11,.LC39@l(11)
	lfs 8,0(11)
	fcmpu 0,9,8
	bc 12,2,.L295
	lis 8,.LC41@ha
	fabs 1,9
	la 8,.LC41@l(8)
	lfs 0,0(8)
	fmr 13,1
	fcmpu 0,1,0
	bc 4,0,.L296
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 13,0(9)
.L296:
	lwz 0,612(31)
	lis 10,0x4330
	lis 8,.LC42@ha
	lis 11,.LC36@ha
	fmr 12,1
	xoris 0,0,0x8000
	la 8,.LC42@l(8)
	lfd 11,.LC36@l(11)
	stw 0,20(1)
	stw 10,16(1)
	lfd 10,0(8)
	fmul 13,13,11
	lfd 0,16(1)
	fsub 0,0,10
	fmul 13,13,0
	fsub 12,12,13
	frsp 12,12
	fcmpu 0,12,8
	bc 4,0,.L298
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 12,0(9)
.L298:
	fdivs 12,12,1
	fmuls 0,9,12
	stfs 0,384(31)
.L295:
	lis 10,.LC39@ha
	lfs 0,384(31)
	la 10,.LC39@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 4,2,.L300
	lfs 0,380(31)
	fcmpu 0,0,13
	bc 4,2,.L300
	lfs 0,376(31)
	fcmpu 0,0,13
	bc 12,2,.L299
.L300:
	bc 4,18,.L302
	lwz 0,264(31)
	andi. 11,0,3
	bc 12,2,.L301
.L302:
	lwz 0,480(31)
	lis 11,0x4330
	lis 8,.LC42@ha
	lis 10,.LC43@ha
	xoris 0,0,0x8000
	la 8,.LC42@l(8)
	stw 0,20(1)
	la 10,.LC43@l(10)
	stw 11,16(1)
	lfd 13,0(8)
	lfd 0,16(1)
	lfd 12,0(10)
	fsub 0,0,13
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L304
	mr 3,31
	bl M_CheckBottom
	cmpwi 0,3,0
	bc 12,2,.L301
.L304:
	lfs 0,4(28)
	lfs 1,376(31)
	fmuls 0,0,0
	fmadds 1,1,1,0
	bl sqrt
	lis 8,.LC39@ha
	frsp 1,1
	la 8,.LC39@l(8)
	lfs 10,0(8)
	fcmpu 0,1,10
	bc 12,2,.L301
	lis 9,.LC41@ha
	fmr 13,1
	la 9,.LC41@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L306
	lis 10,.LC41@ha
	la 10,.LC41@l(10)
	lfs 13,0(10)
.L306:
	lis 9,.LC36@ha
	lis 11,.LC44@ha
	lfd 12,.LC36@l(9)
	la 11,.LC44@l(11)
	fmr 0,1
	lfd 11,0(11)
	fmul 13,13,12
	fmul 13,13,11
	fsub 0,0,13
	frsp 12,0
	fcmpu 0,12,10
	bc 4,0,.L308
	lis 8,.LC39@ha
	la 8,.LC39@l(8)
	lfs 12,0(8)
.L308:
	fdivs 12,12,1
	lfs 0,376(31)
	fmuls 0,0,12
	stfs 0,376(31)
	lfs 13,4(28)
	fmuls 13,13,12
	stfs 13,4(28)
.L301:
	lwz 4,184(31)
	lis 9,.LC34@ha
	lis 0,0x202
	ori 0,0,3
	lfs 1,.LC34@l(9)
	mr 3,31
	rlwinm 4,4,0,29,29
	neg 4,4
	srawi 4,4,31
	and 4,4,0
	ori 4,4,3
	bl SV_FlyMove
	lis 9,gi@ha
	mr 3,31
	la 29,gi@l(9)
	lwz 9,72(29)
	mtlr 9
	blrl
	mr 3,31
	bl G_TouchTriggers
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L259
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L299
	bc 4,18,.L299
	cmpwi 0,27,0
	bc 12,2,.L299
	lwz 9,36(29)
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC45@ha
	lis 9,.LC45@ha
	lis 10,.LC39@ha
	mr 5,3
	la 8,.LC45@l(8)
	la 9,.LC45@l(9)
	mtlr 0
	la 10,.LC39@l(10)
	li 4,0
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L299:
	lis 8,.LC39@ha
	lfs 12,428(31)
	la 8,.LC39@l(8)
	lfs 11,0(8)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L259
	lis 9,level+4@ha
	lis 11,.LC38@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC38@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L259
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L318
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L318:
	lwz 0,436(31)
	mr 3,31
	mtlr 0
	blrl
.L259:
	lwz 0,52(1)
	lwz 12,24(1)
	mtlr 0
	lmw 27,28(1)
	mtcrf 8,12
	la 1,48(1)
	blr
.Lfe6:
	.size	 SV_Physics_Step,.Lfe6-SV_Physics_Step
	.section	".rodata"
	.align 2
.LC48:
	.string	"SV_Physics: bad movetype %i"
	.align 3
.LC46:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC47:
	.long 0x3dcccccd
	.align 2
.LC49:
	.long 0x0
	.section	".text"
	.align 2
	.globl G_RunEntity
	.type	 G_RunEntity,@function
G_RunEntity:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,432(31)
	cmpwi 0,0,0
	bc 12,2,.L325
	mtlr 0
	blrl
.L325:
	lwz 0,260(31)
	cmplwi 0,0,9
	mr 4,0
	bc 12,1,.L347
	lis 11,.L348@ha
	slwi 10,4,2
	la 11,.L348@l(11)
	lis 9,.L348@ha
	lwzx 0,10,11
	la 9,.L348@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L348:
	.long .L329-.L348
	.long .L335-.L348
	.long .L328-.L348
	.long .L328-.L348
	.long .L347-.L348
	.long .L342-.L348
	.long .L346-.L348
	.long .L346-.L348
	.long .L346-.L348
	.long .L346-.L348
.L328:
	mr 3,31
	bl SV_Physics_Pusher
	b .L326
.L329:
	lis 9,.LC49@ha
	lfs 12,428(31)
	la 9,.LC49@l(9)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L326
	lis 9,level+4@ha
	lis 11,.LC46@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC46@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L326
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L333
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L333:
	lwz 0,436(31)
	mr 3,31
	b .L349
.L335:
	lis 9,.LC49@ha
	lfs 12,428(31)
	la 9,.LC49@l(9)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L350
	lis 9,level+4@ha
	lis 11,.LC46@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC46@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 4,1,.L338
.L350:
	li 0,1
	b .L337
.L338:
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L339
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L339:
	lwz 9,436(31)
	mr 3,31
	mtlr 9
	blrl
	li 0,0
.L337:
	cmpwi 0,0,0
	bc 12,2,.L326
	lis 29,.LC47@ha
	addi 3,31,16
	lfs 1,.LC47@l(29)
	mr 5,3
	addi 4,31,388
	bl VectorMA
	lfs 1,.LC47@l(29)
	addi 3,31,4
	addi 4,31,376
	mr 5,3
	bl VectorMA
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
.L349:
	mtlr 0
	blrl
	b .L326
.L342:
	mr 3,31
	bl SV_Physics_Step
	b .L326
.L346:
	mr 3,31
	bl SV_Physics_Toss
	b .L326
.L347:
	lis 9,gi+28@ha
	lis 3,.LC48@ha
	lwz 0,gi+28@l(9)
	la 3,.LC48@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L326:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 G_RunEntity,.Lfe7-G_RunEntity
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.align 2
	.globl SV_TestEntityPosition
	.type	 SV_TestEntityPosition,@function
SV_TestEntityPosition:
	stwu 1,-80(1)
	mflr 0
	stw 0,84(1)
	mr 6,3
	lis 9,gi+48@ha
	lwz 0,252(6)
	addi 4,6,4
	mr 8,6
	lwz 11,gi+48@l(9)
	addi 5,6,188
	addi 3,1,8
	addic 9,0,-1
	subfe 9,9,9
	addi 6,6,200
	andc 0,0,9
	mr 7,4
	mtlr 11
	rlwinm 9,9,0,30,31
	or 9,9,0
	blrl
	lwz 0,12(1)
	cmpwi 0,0,0
	bc 4,2,.L9
	li 3,0
	b .L351
.L9:
	lis 9,g_edicts@ha
	lwz 3,g_edicts@l(9)
.L351:
	lwz 0,84(1)
	mtlr 0
	la 1,80(1)
	blr
.Lfe8:
	.size	 SV_TestEntityPosition,.Lfe8-SV_TestEntityPosition
	.align 2
	.globl SV_CheckVelocity
	.type	 SV_CheckVelocity,@function
SV_CheckVelocity:
	li 0,3
	lis 9,sv_maxvelocity@ha
	mtctr 0
	lwz 9,sv_maxvelocity@l(9)
	addi 3,3,376
.L352:
	lfs 13,0(3)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 12,1,.L353
	fneg 0,0
	fcmpu 0,13,0
	bc 4,0,.L13
.L353:
	stfs 0,0(3)
.L13:
	addi 3,3,4
	bdnz .L352
	blr
.Lfe9:
	.size	 SV_CheckVelocity,.Lfe9-SV_CheckVelocity
	.section	".rodata"
	.align 3
.LC50:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC51:
	.long 0x0
	.section	".text"
	.align 2
	.globl SV_RunThink
	.type	 SV_RunThink,@function
SV_RunThink:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,.LC51@ha
	mr 31,3
	la 9,.LC51@l(9)
	lfs 12,428(31)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L355
	lis 9,level+4@ha
	lis 11,.LC50@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC50@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 4,1,.L21
.L355:
	li 3,1
	b .L354
.L21:
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L22
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L22:
	lwz 0,436(31)
	mr 3,31
	mtlr 0
	blrl
	li 3,0
.L354:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 SV_RunThink,.Lfe10-SV_RunThink
	.align 2
	.globl SV_Impact
	.type	 SV_Impact,@function
SV_Impact:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,3
	mr 5,4
	lwz 9,444(30)
	lwz 31,52(5)
	cmpwi 0,9,0
	bc 12,2,.L24
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 12,2,.L24
	lwz 6,44(5)
	mr 4,31
	mtlr 9
	addi 5,5,24
	blrl
.L24:
	lwz 9,444(31)
	cmpwi 0,9,0
	bc 12,2,.L25
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L25
	mr 3,31
	mr 4,30
	mtlr 9
	li 5,0
	li 6,0
	blrl
.L25:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 SV_Impact,.Lfe11-SV_Impact
	.section	".rodata"
	.align 3
.LC52:
	.long 0xbfb99999
	.long 0x9999999a
	.align 3
.LC53:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC54:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClipVelocity
	.type	 ClipVelocity,@function
ClipVelocity:
	lis 9,.LC54@ha
	lfs 9,8(4)
	li 8,0
	la 9,.LC54@l(9)
	lfs 0,0(9)
	fcmpu 0,9,0
	bc 4,1,.L27
	li 8,1
.L27:
	lfs 0,4(4)
	crnor 3,2,2
	mfcr 0
	rlwinm 0,0,4,1
	ori 9,8,2
	lfs 12,4(3)
	neg 0,0
	lis 11,.LC52@ha
	lfs 13,0(3)
	andc 9,9,0
	lis 10,.LC53@ha
	lfs 11,0(4)
	and 0,8,0
	li 7,0
	fmuls 12,12,0
	or 8,0,9
	lfd 10,.LC52@l(11)
	lfs 0,8(3)
	li 0,3
	li 9,0
	mtctr 0
	fmadds 13,13,11,12
	lfd 12,.LC53@l(10)
	fmadds 0,0,9,13
	fmuls 1,0,1
.L356:
	lfsx 0,9,4
	lfsx 13,9,3
	fmuls 0,0,1
	fsubs 13,13,0
	fmr 0,13
	stfsx 13,9,5
	fcmpu 0,0,10
	bc 4,1,.L31
	fcmpu 0,0,12
	bc 4,0,.L31
	stwx 7,9,5
.L31:
	addi 9,9,4
	bdnz .L356
	mr 3,8
	blr
.Lfe12:
	.size	 ClipVelocity,.Lfe12-ClipVelocity
	.section	".rodata"
	.align 3
.LC55:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SV_AddGravity
	.type	 SV_AddGravity,@function
SV_AddGravity:
	lis 9,sv_gravity@ha
	lfs 13,408(3)
	lis 10,.LC55@ha
	lwz 11,sv_gravity@l(9)
	lfs 0,384(3)
	lfs 12,20(11)
	lfd 11,.LC55@l(10)
	fmuls 13,13,12
	fmul 13,13,11
	fsub 0,0,13
	frsp 0,0
	stfs 0,384(3)
	blr
.Lfe13:
	.size	 SV_AddGravity,.Lfe13-SV_AddGravity
	.comm	pushed,32768,4
	.comm	pushed_p,4,4
	.comm	obstacle,4,4
	.section	".rodata"
	.align 3
.LC56:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC57:
	.long 0x0
	.section	".text"
	.align 2
	.globl SV_Physics_None
	.type	 SV_Physics_None,@function
SV_Physics_None:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,.LC57@ha
	mr 31,3
	la 9,.LC57@l(9)
	lfs 12,428(31)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L189
	lis 9,level+4@ha
	lis 11,.LC56@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC56@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L189
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L191
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L191:
	lwz 0,436(31)
	mr 3,31
	mtlr 0
	blrl
.L189:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 SV_Physics_None,.Lfe14-SV_Physics_None
	.section	".rodata"
	.align 3
.LC58:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC59:
	.long 0x3dcccccd
	.align 2
.LC60:
	.long 0x0
	.section	".text"
	.align 2
	.globl SV_Physics_Noclip
	.type	 SV_Physics_Noclip,@function
SV_Physics_Noclip:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,.LC60@ha
	mr 31,3
	la 9,.LC60@l(9)
	lfs 12,428(31)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L357
	lis 9,level+4@ha
	lis 11,.LC58@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC58@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 4,1,.L196
.L357:
	li 0,1
	b .L195
.L196:
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L197
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L197:
	lwz 9,436(31)
	mr 3,31
	mtlr 9
	blrl
	li 0,0
.L195:
	cmpwi 0,0,0
	bc 12,2,.L192
	lis 29,.LC59@ha
	addi 3,31,16
	lfs 1,.LC59@l(29)
	mr 5,3
	addi 4,31,388
	bl VectorMA
	lfs 1,.LC59@l(29)
	addi 3,31,4
	addi 4,31,376
	mr 5,3
	bl VectorMA
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L192:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 SV_Physics_Noclip,.Lfe15-SV_Physics_Noclip
	.section	".rodata"
	.align 2
.LC61:
	.long 0x3dcccccd
	.align 2
.LC62:
	.long 0x42700000
	.align 2
.LC63:
	.long 0x0
	.section	".text"
	.align 2
	.globl SV_AddRotationalFriction
	.type	 SV_AddRotationalFriction,@function
SV_AddRotationalFriction:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,.LC61@ha
	mr 29,3
	addi 3,29,16
	lfs 1,.LC61@l(9)
	addi 29,29,388
	mr 5,3
	mr 4,29
	bl VectorMA
	lis 9,.LC62@ha
	li 0,3
	la 9,.LC62@l(9)
	mtctr 0
	lfs 12,0(9)
	lis 9,.LC63@ha
	la 9,.LC63@l(9)
	lfs 13,0(9)
.L358:
	lfs 0,0(29)
	fcmpu 0,0,13
	bc 4,1,.L254
	fsubs 0,0,12
	fcmpu 0,0,13
	stfs 0,0(29)
	bc 4,0,.L252
	b .L359
.L254:
	fadds 0,0,12
	fcmpu 0,0,13
	stfs 0,0(29)
	bc 4,1,.L252
.L359:
	stfs 13,0(29)
.L252:
	addi 29,29,4
	bdnz .L358
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 SV_AddRotationalFriction,.Lfe16-SV_AddRotationalFriction
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
