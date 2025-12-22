	.file	"g_phys.c"
gcc2_compiled.:
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
.L91:
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
	bc 12,2,.L94
	lwz 9,444(31)
	lwz 29,52(30)
	cmpwi 0,9,0
	bc 12,2,.L95
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L95
	mr 3,31
	mr 4,29
	lwz 6,44(30)
	mtlr 9
	addi 5,1,32
	blrl
.L95:
	lwz 9,444(29)
	cmpwi 0,9,0
	bc 12,2,.L97
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 12,2,.L97
	mr 3,29
	mr 4,31
	mtlr 9
	li 5,0
	li 6,0
	blrl
.L97:
	lwz 9,60(1)
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 4,2,.L94
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L94
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
	b .L91
.L94:
	lwz 9,88(31)
	lis 0,0x3f80
	stw 0,408(31)
	cmpwi 0,9,0
	bc 12,2,.L99
	mr 3,31
	bl G_TouchTriggers
.L99:
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
.L158:
	lfs 0,0(10)
	fmul 0,0,8
	frsp 0,0
	fcmpu 0,0,9
	bc 4,1,.L105
	fadd 0,0,12
	b .L159
.L105:
	fsub 0,0,12
.L159:
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
	bdnz .L158
	li 0,3
	mr 7,8
	mtctr 0
	mr 8,31
	addi 10,28,212
	addi 11,28,224
	li 9,0
.L157:
	lfsx 0,9,26
	lfsx 13,9,10
	lfsx 12,9,11
	fadds 13,13,0
	fadds 12,12,0
	stfsx 13,9,7
	stfsx 12,9,8
	addi 9,9,4
	bdnz .L157
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
	bc 12,2,.L113
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
.L113:
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
	addi 27,4,1084
	bc 4,0,.L115
	mr 23,31
	lis 24,pushed_p@ha
	addi 31,4,1088
.L117:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L116
	lwz 11,256(31)
	addi 0,11,-2
	subfic 8,11,0
	adde 9,8,11
	subfic 0,0,1
	li 0,0
	adde 0,0,0
	or. 30,0,9
	bc 4,2,.L116
	cmpwi 0,11,1
	bc 12,2,.L116
	lwz 0,92(31)
	cmpwi 0,0,0
	bc 12,2,.L116
	lwz 0,548(31)
	cmpw 0,0,28
	bc 12,2,.L122
	lfs 13,208(31)
	lfs 0,24(1)
	fcmpu 0,13,0
	cror 3,2,1
	bc 12,3,.L116
	lfs 13,212(31)
	lfs 0,28(1)
	fcmpu 0,13,0
	cror 3,2,1
	bc 12,3,.L116
	lfs 13,216(31)
	lfs 0,32(1)
	fcmpu 0,13,0
	cror 3,2,1
	bc 12,3,.L116
	lfs 13,220(31)
	lfs 0,8(1)
	fcmpu 0,13,0
	cror 3,2,0
	bc 12,3,.L116
	lfs 13,224(31)
	lfs 0,12(1)
	fcmpu 0,13,0
	cror 3,2,0
	bc 12,3,.L116
	lfs 13,228(31)
	lfs 0,16(1)
	fcmpu 0,13,0
	cror 3,2,0
	bc 12,3,.L116
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
	bc 12,2,.L116
.L122:
	lwz 0,260(28)
	cmpwi 0,0,2
	bc 12,2,.L131
	lwz 0,548(31)
	cmpw 0,0,28
	bc 4,2,.L130
.L131:
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
	bc 12,2,.L132
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
.L132:
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
	bc 12,2,.L133
	stw 30,548(31)
.L133:
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
	bc 4,2,.L138
	lwz 9,72(23)
	mr 3,27
	mtlr 9
	blrl
	b .L116
.L138:
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
	bc 4,2,.L130
	lwz 9,pushed_p@l(24)
	addi 9,9,-32
	stw 9,pushed_p@l(24)
	b .L116
.L130:
	lwz 11,pushed_p@l(20)
	la 0,pushed@l(19)
	lis 9,obstacle@ha
	stw 27,obstacle@l(9)
	addi 31,11,-32
	cmplw 0,31,0
	bc 12,0,.L145
	lis 9,gi@ha
	mr 29,0
	la 30,gi@l(9)
.L147:
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
	bc 12,2,.L148
	lfs 0,28(31)
	fctiwz 13,0
	stfd 13,208(1)
	lwz 9,212(1)
	sth 9,22(11)
.L148:
	lwz 9,72(30)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,-32
	blrl
	cmplw 0,31,29
	bc 4,0,.L147
.L145:
	li 3,0
	b .L156
.L116:
	la 9,globals@l(18)
	addi 22,22,1
	lwz 0,72(9)
	addi 31,31,1084
	addi 27,27,1084
	cmpw 0,22,0
	bc 12,0,.L117
.L115:
	lis 9,pushed_p@ha
	lis 11,pushed@ha
	lwz 10,pushed_p@l(9)
	la 11,pushed@l(11)
	addi 31,10,-32
	cmplw 0,31,11
	bc 12,0,.L152
	mr 30,11
.L154:
	lwz 3,0(31)
	addi 31,31,-32
	bl G_TouchTriggers
	cmplw 0,31,30
	bc 4,0,.L154
.L152:
	li 3,1
.L156:
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
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 28,40(1)
	stw 0,68(1)
	mr 29,3
	lwz 0,264(29)
	andi. 9,0,1024
	bc 4,2,.L160
	lis 9,pushed@ha
	mr. 31,29
	la 9,pushed@l(9)
	lis 11,pushed_p@ha
	stw 9,pushed_p@l(11)
	bc 12,2,.L163
	lis 11,.LC20@ha
	lis 28,.LC16@ha
	la 11,.LC20@l(11)
	addi 30,1,24
	lfs 31,0(11)
.L165:
	lfs 0,376(31)
	fcmpu 0,0,31
	bc 4,2,.L167
	lfs 0,380(31)
	fcmpu 0,0,31
	bc 4,2,.L167
	lfs 0,384(31)
	fcmpu 0,0,31
	bc 4,2,.L167
	lfs 0,388(31)
	fcmpu 0,0,31
	bc 4,2,.L167
	lfs 0,392(31)
	fcmpu 0,0,31
	bc 4,2,.L167
	lfs 0,396(31)
	fcmpu 0,0,31
	bc 12,2,.L164
.L167:
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
	bc 12,2,.L163
.L164:
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L165
.L163:
	lis 9,pushed_p@ha
	lis 11,pushed+32768@ha
	lwz 0,pushed_p@l(9)
	la 11,pushed+32768@l(11)
	cmplw 0,0,11
	bc 4,1,.L170
	lis 9,gi+28@ha
	lis 4,.LC17@ha
	lwz 0,gi+28@l(9)
	la 4,.LC17@l(4)
	li 3,0
	mtlr 0
	crxor 6,6,6
	blrl
.L170:
	cmpwi 0,31,0
	bc 12,2,.L171
	mr 3,29
	cmpwi 0,3,0
	bc 12,2,.L173
	lis 11,.LC20@ha
	lis 9,.LC18@ha
	la 11,.LC20@l(11)
	lfd 13,.LC18@l(9)
	lfs 12,0(11)
.L175:
	lfs 0,428(3)
	fcmpu 0,0,12
	bc 4,1,.L174
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
.L174:
	lwz 3,560(3)
	cmpwi 0,3,0
	bc 4,2,.L175
.L173:
	lwz 0,440(31)
	cmpwi 0,0,0
	bc 12,2,.L160
	lis 9,obstacle@ha
	mr 3,31
	mtlr 0
	lwz 4,obstacle@l(9)
	blrl
	b .L160
.L171:
	mr. 31,29
	bc 12,2,.L160
	lis 9,.LC19@ha
	lis 11,level@ha
	lfd 31,.LC19@l(9)
	la 28,level@l(11)
	lis 30,.LC1@ha
	lis 9,gi@ha
	la 29,gi@l(9)
.L183:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L182
	lis 9,.LC20@ha
	lfs 13,428(31)
	la 9,.LC20@l(9)
	lfs 12,0(9)
	fcmpu 0,13,12
	cror 3,2,0
	bc 12,3,.L182
	lfs 0,4(28)
	fadd 0,0,31
	fcmpu 0,13,0
	bc 12,1,.L182
	lwz 0,436(31)
	stfs 12,428(31)
	cmpwi 0,0,0
	bc 4,2,.L188
	lwz 9,28(29)
	la 3,.LC1@l(30)
	mtlr 9
	crxor 6,6,6
	blrl
.L188:
	lwz 9,436(31)
	mr 3,31
	mtlr 9
	blrl
.L182:
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L183
.L160:
	lwz 0,68(1)
	mtlr 0
	lmw 28,40(1)
	lfd 31,56(1)
	la 1,64(1)
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
	.align 3
.LC31:
	.long 0x0
	.long 0x0
	.align 2
.LC32:
	.long 0x3f800000
	.align 2
.LC33:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl SV_Physics_Toss
	.type	 SV_Physics_Toss,@function
SV_Physics_Toss:
	stwu 1,-144(1)
	mflr 0
	stmw 26,120(1)
	stw 0,148(1)
	lis 6,.LC30@ha
	mr 31,3
	la 6,.LC30@l(6)
	lfs 12,428(31)
	lfs 11,0(6)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L203
	lis 9,level+4@ha
	lis 11,.LC24@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC24@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L203
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L205
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L205:
	lwz 9,436(31)
	mr 3,31
	mtlr 9
	blrl
.L203:
	lwz 0,264(31)
	andi. 0,0,1024
	bc 4,2,.L201
	lis 6,.LC30@ha
	lfs 13,384(31)
	la 6,.LC30@l(6)
	lfs 0,0(6)
	fcmpu 0,13,0
	bc 4,1,.L207
	stw 0,552(31)
.L207:
	lwz 9,552(31)
	cmpwi 0,9,0
	bc 12,2,.L210
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 4,2,.L208
	stw 0,552(31)
.L208:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L210
	lfs 0,408(31)
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,1,.L201
.L210:
	li 0,3
	lfs 12,4(31)
	lis 9,sv_maxvelocity@ha
	lfs 13,8(31)
	mtctr 0
	addi 27,31,376
	addi 26,31,16
	lfs 0,12(31)
	mr 11,27
	addi 28,31,388
	lwz 10,sv_maxvelocity@l(9)
	addi 30,1,72
	li 9,0
	stfs 12,88(1)
	stfs 13,92(1)
	stfs 0,96(1)
.L251:
	lfsx 13,9,11
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 12,1,.L252
	fneg 0,0
	fcmpu 0,13,0
	bc 4,0,.L217
.L252:
	stfsx 0,9,27
.L217:
	addi 9,9,4
	bdnz .L251
	lwz 0,260(31)
	xori 10,0,8
	xori 0,0,6
	addic 6,0,-1
	subfe 11,6,0
	addic 0,10,-1
	subfe 9,0,10
	and. 6,11,9
	bc 12,2,.L220
	lis 9,.LC30@ha
	lfs 13,1056(31)
	la 9,.LC30@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L221
	lis 9,sv_gravity@ha
	lfs 1,408(31)
	lis 11,.LC25@ha
	lwz 10,sv_gravity@l(9)
	mr 3,27
	addi 4,31,1048
	lfd 13,.LC25@l(11)
	mr 5,27
	lfs 0,20(10)
	fmuls 1,1,0
	fmul 1,1,13
	frsp 1,1
	bl VectorMA
	b .L220
.L221:
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
.L220:
	lis 29,.LC26@ha
	mr 3,26
	lfs 1,.LC26@l(29)
	mr 5,3
	mr 4,28
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
	bc 12,2,.L201
	lis 6,.LC32@ha
	lfs 13,16(1)
	addi 30,31,4
	la 6,.LC32@l(6)
	lfs 0,0(6)
	fcmpu 0,13,0
	bc 4,0,.L225
	lwz 0,260(31)
	lis 7,0x3f80
	cmpwi 0,0,9
	bc 4,2,.L226
	lis 7,0x3fc0
.L226:
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
.L250:
	lfsx 0,10,8
	lfsx 13,10,27
	fmuls 0,0,12
	fsubs 13,13,0
	fmr 0,13
	stfsx 13,10,28
	fcmpu 0,0,10
	bc 4,1,.L234
	fcmpu 0,0,11
	bc 4,0,.L234
	stwx 0,10,28
.L234:
	addi 10,10,4
	bdnz .L250
	lfs 0,40(1)
	lis 9,.LC28@ha
	lfd 13,.LC28@l(9)
	fcmpu 0,0,13
	bc 4,1,.L225
	lis 6,.LC33@ha
	lfs 13,384(31)
	la 6,.LC33@l(6)
	lfs 0,0(6)
	fcmpu 0,13,0
	bc 12,0,.L239
	lwz 0,260(31)
	cmpwi 0,0,9
	bc 12,2,.L225
.L239:
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
.L225:
	lis 9,gi+52@ha
	mr 3,30
	lwz 0,608(31)
	lwz 9,gi+52@l(9)
	rlwinm 29,0,0,26,28
	mtlr 9
	blrl
	andi. 11,3,56
	stw 3,608(31)
	bc 12,2,.L240
	li 0,1
	stw 0,612(31)
	b .L241
.L240:
	stw 11,612(31)
.L241:
	neg 0,11
	subfic 6,29,0
	adde 9,6,29
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L242
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
	lis 9,.LC32@ha
	lis 10,.LC32@ha
	lis 11,.LC30@ha
	mr 6,3
	la 9,.LC32@l(9)
	la 10,.LC32@l(10)
	mtlr 0
	la 11,.LC30@l(11)
	mr 4,28
	lfs 1,0(9)
	mr 3,27
	li 5,0
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L243
.L242:
	neg 0,29
	subfic 6,11,0
	adde 9,6,11
	srwi 0,0,31
	and. 10,0,9
	bc 12,2,.L243
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
	lis 9,.LC32@ha
	lis 10,.LC32@ha
	lis 11,.LC30@ha
	mr 6,3
	la 9,.LC32@l(9)
	la 10,.LC32@l(10)
	mtlr 0
	la 11,.LC30@l(11)
	mr 4,28
	lfs 1,0(9)
	mr 3,30
	li 5,0
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L243:
	lwz 29,560(31)
	cmpwi 0,29,0
	bc 12,2,.L201
	lis 9,gi@ha
	la 28,gi@l(9)
.L248:
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
	bc 4,2,.L248
.L201:
	lwz 0,148(1)
	mtlr 0
	lmw 26,120(1)
	la 1,144(1)
	blr
.Lfe5:
	.size	 SV_Physics_Toss,.Lfe5-SV_Physics_Toss
	.section	".rodata"
	.align 2
.LC34:
	.long 0x3dcccccd
	.align 3
.LC35:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC36:
	.long 0x0
	.align 3
.LC37:
	.long 0x40180000
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
	lis 9,.LC34@ha
	mr 29,3
	addi 3,29,16
	lfs 1,.LC34@l(9)
	addi 29,29,388
	mr 5,3
	mr 4,29
	bl VectorMA
	lis 9,.LC36@ha
	lis 11,.LC35@ha
	la 9,.LC36@l(9)
	lfd 13,.LC35@l(11)
	li 0,3
	lfs 11,0(9)
	mtctr 0
	lis 9,sv_stopspeed@ha
	lwz 10,sv_stopspeed@l(9)
	lis 9,.LC37@ha
	lfs 0,20(10)
	la 9,.LC37@l(9)
	lfd 12,0(9)
	fmul 0,0,13
	fmul 0,0,12
	frsp 13,0
.L263:
	lfs 0,0(29)
	fcmpu 0,0,11
	bc 4,1,.L258
	fsubs 0,0,13
	fcmpu 0,0,11
	stfs 0,0(29)
	bc 4,0,.L256
	b .L264
.L258:
	fadds 0,0,13
	fcmpu 0,0,11
	stfs 0,0(29)
	bc 4,1,.L256
.L264:
	stfs 11,0(29)
.L256:
	addi 29,29,4
	bdnz .L263
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 SV_AddRotationalFriction,.Lfe6-SV_AddRotationalFriction
	.section	".rodata"
	.align 2
.LC41:
	.string	"world/land.wav"
	.align 3
.LC38:
	.long 0xbfb99999
	.long 0x9999999a
	.align 3
.LC39:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC40:
	.long 0x3dcccccd
	.align 3
.LC42:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC43:
	.long 0x0
	.align 3
.LC44:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC45:
	.long 0x0
	.long 0x0
	.align 3
.LC46:
	.long 0x40180000
	.long 0x0
	.align 2
.LC47:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SV_Physics_Step
	.type	 SV_Physics_Step,@function
SV_Physics_Step:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	li 28,0
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L266
	bl M_CheckGround
.L266:
	li 8,3
	lis 9,sv_maxvelocity@ha
	lwz 0,552(31)
	mtctr 8
	addi 30,31,376
	lwz 10,sv_maxvelocity@l(9)
	mr 11,30
	li 9,0
.L319:
	lfsx 13,9,11
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 12,1,.L320
	fneg 0,0
	fcmpu 0,13,0
	bc 4,0,.L273
.L320:
	stfsx 0,9,30
.L273:
	addi 9,9,4
	bdnz .L319
	lis 9,.LC43@ha
	lfs 0,388(31)
	addic 10,0,-1
	subfe 29,10,0
	la 9,.LC43@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L279
	lfs 0,392(31)
	fcmpu 0,0,13
	bc 4,2,.L279
	lfs 0,396(31)
	fcmpu 0,0,13
	bc 12,2,.L278
.L279:
	mr 3,31
	bl SV_AddRotationalFriction
.L278:
	cmpwi 0,29,0
	mfcr 29
	bc 4,2,.L280
	lwz 0,264(31)
	andi. 8,0,1
	bc 4,2,.L318
	andi. 9,0,2
	lwz 0,612(31)
	bc 12,2,.L283
	cmpwi 0,0,2
	bc 12,1,.L280
.L283:
	lis 9,sv_gravity@ha
	lfs 0,384(31)
	lis 10,.LC38@ha
	lwz 11,sv_gravity@l(9)
	lfd 13,.LC38@l(10)
	lfs 12,20(11)
	fmr 11,0
	fmr 0,12
	fmul 0,0,13
	fcmpu 0,11,0
	bc 4,0,.L284
	li 28,1
.L284:
	cmpwi 0,0,0
	bc 4,2,.L280
	lis 10,.LC43@ha
	lfs 13,1056(31)
	la 10,.LC43@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L286
	lfs 1,408(31)
	lis 9,.LC39@ha
	mr 3,30
	lfd 0,.LC39@l(9)
	addi 4,31,1048
	mr 5,30
	fmuls 1,1,12
	fmul 1,1,0
	frsp 1,1
	bl VectorMA
	b .L280
.L286:
	lfs 0,408(31)
	lis 9,.LC39@ha
	lfd 13,.LC39@l(9)
	fmuls 0,0,12
	fmul 0,0,13
	fsub 0,11,0
	frsp 0,0
	stfs 0,384(31)
.L280:
	lwz 0,264(31)
	andi. 8,0,1
	bc 12,2,.L289
.L318:
	lis 9,.LC43@ha
	lfs 11,384(31)
	la 9,.LC43@l(9)
	lfs 10,0(9)
	fcmpu 0,11,10
	bc 12,2,.L289
	lis 11,sv_stopspeed@ha
	fabs 1,11
	lwz 9,sv_stopspeed@l(11)
	lfs 13,20(9)
	fmr 0,1
	fcmpu 0,1,13
	bc 4,0,.L290
	fmr 0,13
.L290:
	lis 9,.LC39@ha
	lfd 12,.LC39@l(9)
	fmr 13,1
	fmul 0,0,12
	fadd 0,0,0
	fsub 13,13,0
	frsp 12,13
	fcmpu 0,12,10
	bc 4,0,.L292
	lis 10,.LC43@ha
	la 10,.LC43@l(10)
	lfs 12,0(10)
.L292:
	fdivs 12,12,1
	fmuls 0,11,12
	stfs 0,384(31)
.L289:
	lwz 0,264(31)
	andi. 11,0,2
	bc 12,2,.L293
	lis 8,.LC43@ha
	lfs 9,384(31)
	la 8,.LC43@l(8)
	lfs 8,0(8)
	fcmpu 0,9,8
	bc 12,2,.L293
	lis 11,sv_stopspeed@ha
	fabs 1,9
	lwz 9,sv_stopspeed@l(11)
	lfs 13,20(9)
	fmr 0,1
	fcmpu 0,1,13
	bc 4,0,.L294
	fmr 0,13
.L294:
	lwz 0,612(31)
	lis 10,0x4330
	fmr 13,0
	lis 8,.LC44@ha
	lis 11,.LC39@ha
	fmr 12,1
	xoris 0,0,0x8000
	la 8,.LC44@l(8)
	lfd 11,.LC39@l(11)
	stw 0,12(1)
	stw 10,8(1)
	lfd 10,0(8)
	fmul 13,13,11
	lfd 0,8(1)
	fsub 0,0,10
	fmul 13,13,0
	fsub 12,12,13
	frsp 12,12
	fcmpu 0,12,8
	bc 4,0,.L296
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 12,0(9)
.L296:
	fdivs 12,12,1
	fmuls 0,9,12
	stfs 0,384(31)
.L293:
	lis 10,.LC43@ha
	lfs 0,384(31)
	la 10,.LC43@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 4,2,.L298
	lfs 0,380(31)
	fcmpu 0,0,13
	bc 4,2,.L298
	lfs 0,376(31)
	fcmpu 0,0,13
	bc 12,2,.L297
.L298:
	mtcrf 128,29
	bc 4,2,.L300
	lwz 0,264(31)
	andi. 8,0,3
	bc 12,2,.L299
.L300:
	lwz 0,480(31)
	lis 11,0x4330
	lis 10,.LC44@ha
	lis 8,.LC45@ha
	xoris 0,0,0x8000
	la 10,.LC44@l(10)
	stw 0,12(1)
	la 8,.LC45@l(8)
	stw 11,8(1)
	lfd 13,0(10)
	lfd 0,8(1)
	lfd 12,0(8)
	fsub 0,0,13
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L302
	mr 3,31
	bl M_CheckBottom
	cmpwi 0,3,0
	bc 12,2,.L299
.L302:
	lfs 0,4(30)
	lfs 1,376(31)
	fmuls 0,0,0
	fmadds 1,1,1,0
	bl sqrt
	lis 8,.LC43@ha
	frsp 1,1
	la 8,.LC43@l(8)
	lfs 10,0(8)
	fcmpu 0,1,10
	bc 12,2,.L299
	lis 11,sv_stopspeed@ha
	fmr 0,1
	lwz 9,sv_stopspeed@l(11)
	lfs 13,20(9)
	fcmpu 0,1,13
	bc 4,0,.L304
	fmr 0,13
.L304:
	lis 9,.LC39@ha
	fmr 13,0
	lis 10,.LC46@ha
	lfd 12,.LC39@l(9)
	la 10,.LC46@l(10)
	fmr 0,1
	lfd 11,0(10)
	fmul 13,13,12
	fmul 13,13,11
	fsub 0,0,13
	frsp 12,0
	fcmpu 0,12,10
	bc 4,0,.L306
	lis 11,.LC43@ha
	la 11,.LC43@l(11)
	lfs 12,0(11)
.L306:
	fdivs 12,12,1
	lfs 13,0(30)
	lfs 0,4(30)
	fmuls 13,13,12
	fmuls 0,0,12
	stfs 13,0(30)
	stfs 0,4(30)
.L299:
	lwz 4,184(31)
	lis 9,.LC40@ha
	lis 0,0x202
	lfs 1,.LC40@l(9)
	ori 0,0,3
	mr 3,31
	rlwinm 4,4,0,29,29
	neg 4,4
	srawi 4,4,31
	and 4,4,0
	ori 4,4,3
	bl SV_FlyMove
	lis 9,gi@ha
	mr 3,31
	la 30,gi@l(9)
	lwz 9,72(30)
	mtlr 9
	blrl
	lis 0,0x3f80
	mr 3,31
	stw 0,408(31)
	bl G_TouchTriggers
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L265
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L297
	mtcrf 128,29
	bc 4,2,.L297
	cmpwi 0,28,0
	bc 12,2,.L297
	lwz 9,36(30)
	lis 3,.LC41@ha
	la 3,.LC41@l(3)
	mtlr 9
	blrl
	lwz 0,16(30)
	lis 8,.LC47@ha
	lis 9,.LC47@ha
	lis 10,.LC43@ha
	mr 5,3
	la 8,.LC47@l(8)
	la 9,.LC47@l(9)
	mtlr 0
	la 10,.LC43@l(10)
	li 4,0
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L297:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L265
	lis 8,.LC43@ha
	lfs 12,428(31)
	la 8,.LC43@l(8)
	lfs 11,0(8)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L265
	lis 9,level+4@ha
	lis 11,.LC42@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC42@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L265
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L317
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L317:
	lwz 0,436(31)
	mr 3,31
	mtlr 0
	blrl
.L265:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 SV_Physics_Step,.Lfe7-SV_Physics_Step
	.section	".rodata"
	.align 2
.LC50:
	.string	"SV_Physics: bad movetype %i"
	.align 3
.LC48:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC49:
	.long 0x3dcccccd
	.align 2
.LC51:
	.long 0x0
	.section	".text"
	.align 2
	.globl G_RunEntity
	.type	 G_RunEntity,@function
G_RunEntity:
	stwu 1,-112(1)
	mflr 0
	stmw 29,100(1)
	stw 0,116(1)
	mr 31,3
	lwz 0,260(31)
	cmpwi 0,0,5
	bc 4,2,.L322
	lfs 0,4(31)
	lfs 13,8(31)
	lfs 12,12(31)
	stfs 0,72(1)
	stfs 13,76(1)
	stfs 12,80(1)
.L322:
	lwz 0,432(31)
	cmpwi 0,0,0
	bc 12,2,.L323
	mr 3,31
	mtlr 0
	blrl
.L323:
	lwz 10,260(31)
	cmplwi 0,10,10
	bc 12,1,.L346
	lis 11,.L347@ha
	slwi 10,10,2
	la 11,.L347@l(11)
	lis 9,.L347@ha
	lwzx 0,10,11
	la 9,.L347@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L347:
	.long .L327-.L347
	.long .L333-.L347
	.long .L326-.L347
	.long .L326-.L347
	.long .L346-.L347
	.long .L340-.L347
	.long .L344-.L347
	.long .L344-.L347
	.long .L344-.L347
	.long .L344-.L347
	.long .L345-.L347
.L326:
	mr 3,31
	bl SV_Physics_Pusher
	b .L324
.L327:
	lis 9,.LC51@ha
	lfs 12,428(31)
	la 9,.LC51@l(9)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L324
	lis 9,level+4@ha
	lis 11,.LC48@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC48@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L324
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L331
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L331:
	lwz 9,436(31)
	mr 3,31
	mtlr 9
	blrl
	b .L324
.L333:
	lis 9,.LC51@ha
	lfs 12,428(31)
	la 9,.LC51@l(9)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L352
	lis 9,level+4@ha
	lis 11,.LC48@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC48@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 4,1,.L336
.L352:
	li 0,1
	b .L335
.L336:
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L337
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L337:
	lwz 9,436(31)
	mr 3,31
	mtlr 9
	blrl
	li 0,0
.L335:
	cmpwi 0,0,0
	bc 12,2,.L324
	lis 29,.LC49@ha
	addi 3,31,16
	lfs 1,.LC49@l(29)
	mr 5,3
	addi 4,31,388
	bl VectorMA
	lfs 1,.LC49@l(29)
	addi 3,31,4
	addi 4,31,376
	mr 5,3
	bl VectorMA
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	b .L324
.L340:
	mr 3,31
	bl SV_Physics_Step
	b .L324
.L344:
	mr 3,31
	bl SV_Physics_Toss
	b .L324
.L345:
	mr 3,31
	bl SV_Physics_NewToss
	b .L324
.L346:
	lis 9,gi+28@ha
	lis 3,.LC50@ha
	lwz 4,260(31)
	lwz 0,gi+28@l(9)
	la 3,.LC50@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L324:
	lwz 0,260(31)
	cmpwi 0,0,5
	bc 4,2,.L348
	addi 30,1,72
	addi 29,31,4
	mr 3,29
	mr 4,30
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L348
	lis 11,gi+48@ha
	lis 9,0x202
	lwz 0,gi+48@l(11)
	mr 4,29
	mr 7,30
	addi 3,1,8
	addi 5,31,188
	mtlr 0
	addi 6,31,200
	mr 8,31
	ori 9,9,3
	blrl
	lwz 0,8(1)
	cmpwi 0,0,0
	bc 4,2,.L351
	lwz 0,12(1)
	cmpwi 0,0,0
	bc 12,2,.L348
.L351:
	lfs 0,72(1)
	lfs 12,76(1)
	lfs 13,80(1)
	stfs 0,4(31)
	stfs 12,8(31)
	stfs 13,12(31)
.L348:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe8:
	.size	 G_RunEntity,.Lfe8-G_RunEntity
	.section	".rodata"
	.align 3
.LC52:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 3
.LC53:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC54:
	.long 0x3dcccccd
	.align 2
.LC55:
	.long 0x0
	.align 3
.LC56:
	.long 0x3fd00000
	.long 0x0
	.align 3
.LC57:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC58:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC59:
	.long 0x40c00000
	.align 2
.LC60:
	.long 0x42100000
	.align 2
.LC61:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SV_Physics_NewToss
	.type	 SV_Physics_NewToss,@function
SV_Physics_NewToss:
	stwu 1,-144(1)
	mflr 0
	stmw 27,124(1)
	stw 0,148(1)
	lis 9,.LC55@ha
	mr 31,3
	la 9,.LC55@l(9)
	lfs 12,428(31)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L355
	lis 9,level+4@ha
	lis 11,.LC52@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC52@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L355
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L357
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L357:
	lwz 9,436(31)
	mr 3,31
	mtlr 9
	blrl
.L355:
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L353
	lfs 0,12(31)
	lis 10,.LC56@ha
	lis 11,gi+48@ha
	la 10,.LC56@l(10)
	lwz 0,gi+48@l(11)
	addi 4,31,4
	lfd 11,0(10)
	addi 3,1,8
	addi 5,31,188
	lwz 9,252(31)
	addi 6,31,200
	addi 7,1,72
	lfs 12,4(31)
	mr 8,31
	mtlr 0
	mr 27,4
	lfs 13,8(31)
	fsub 0,0,11
	stfs 12,72(1)
	stfs 13,76(1)
	frsp 0,0
	stfs 0,80(1)
	blrl
	lwz 9,552(31)
	cmpwi 0,9,0
	bc 12,2,.L361
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L361
	lwz 0,60(1)
	b .L396
.L361:
	li 0,0
.L396:
	stw 0,552(31)
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L363
	lfs 0,40(1)
	lis 9,.LC57@ha
	la 9,.LC57@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L363
	lis 10,.LC55@ha
	lfs 0,376(31)
	la 10,.LC55@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 4,2,.L363
	lfs 0,380(31)
	fcmpu 0,0,13
	bc 4,2,.L363
	lfs 0,384(31)
	fcmpu 0,0,13
	bc 12,2,.L353
.L363:
	li 0,3
	lfs 12,4(31)
	lis 9,sv_maxvelocity@ha
	lfs 13,8(31)
	mtctr 0
	addi 29,31,376
	lfs 0,12(31)
	mr 11,29
	lwz 10,sv_maxvelocity@l(9)
	li 9,0
	stfs 12,88(1)
	stfs 13,92(1)
	stfs 0,96(1)
.L395:
	lfsx 13,9,11
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 12,1,.L397
	fneg 0,0
	fcmpu 0,13,0
	bc 4,0,.L370
.L397:
	stfsx 0,9,29
.L370:
	addi 9,9,4
	bdnz .L395
	lis 9,.LC55@ha
	lfs 13,1056(31)
	la 9,.LC55@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L373
	lis 9,sv_gravity@ha
	lfs 1,408(31)
	lis 11,.LC53@ha
	lwz 10,sv_gravity@l(9)
	mr 3,29
	addi 4,31,1048
	lfd 13,.LC53@l(11)
	mr 5,29
	lfs 0,20(10)
	fmuls 1,1,0
	fmul 1,1,13
	frsp 1,1
	bl VectorMA
	b .L375
.L373:
	lis 10,sv_gravity@ha
	lfs 13,408(31)
	lis 9,.LC53@ha
	lwz 11,sv_gravity@l(10)
	lfd 11,.LC53@l(9)
	lfs 12,20(11)
	lfs 0,384(31)
	fmuls 13,13,12
	fmul 13,13,11
	fsub 0,0,13
	frsp 0,0
	stfs 0,384(31)
.L375:
	lis 9,.LC55@ha
	lfs 0,388(31)
	la 9,.LC55@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L377
	lfs 0,392(31)
	fcmpu 0,0,13
	bc 4,2,.L377
	lfs 0,396(31)
	fcmpu 0,0,13
	bc 12,2,.L376
.L377:
	mr 3,31
	bl SV_AddRotationalFriction
.L376:
	mr 3,29
	bl VectorLength
	lwz 0,612(31)
	fmr 11,1
	cmpwi 0,0,0
	bc 12,2,.L378
	mulli 0,0,6
	lis 11,0x4330
	lis 10,.LC58@ha
	xoris 0,0,0x8000
	la 10,.LC58@l(10)
	stw 0,116(1)
	stw 11,112(1)
	lfd 13,0(10)
	lfd 0,112(1)
	lis 10,.LC55@ha
	la 10,.LC55@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	fsubs 1,11,0
	fcmpu 0,1,12
	b .L398
.L378:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L381
	lis 9,.LC59@ha
	lis 10,.LC55@ha
	la 9,.LC59@l(9)
	la 10,.LC55@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fsubs 1,11,0
	fcmpu 0,1,13
.L398:
	bc 4,0,.L382
	lis 11,.LC55@ha
	la 11,.LC55@l(11)
	lfs 1,0(11)
.L382:
	fdivs 1,1,11
	mr 3,29
	mr 4,3
	bl VectorScale
	b .L380
.L381:
	lis 9,.LC60@ha
	lis 10,.LC55@ha
	la 9,.LC60@l(9)
	la 10,.LC55@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fsubs 1,11,0
	fcmpu 0,1,13
	bc 4,0,.L384
	lis 11,.LC55@ha
	la 11,.LC55@l(11)
	lfs 1,0(11)
.L384:
	fdivs 1,1,11
	mr 3,29
	mr 4,3
	bl VectorScale
.L380:
	lis 9,.LC54@ha
	lwz 4,252(31)
	mr 3,31
	lfs 1,.LC54@l(9)
	bl SV_FlyMove
	lis 29,gi@ha
	mr 3,31
	la 29,gi@l(29)
	lwz 9,72(29)
	mtlr 9
	blrl
	mr 3,31
	bl G_TouchTriggers
	lwz 9,52(29)
	mr 3,27
	lwz 0,608(31)
	mtlr 9
	rlwinm 29,0,0,26,28
	blrl
	andi. 11,3,56
	stw 3,608(31)
	bc 12,2,.L385
	li 0,1
	stw 0,612(31)
	b .L386
.L385:
	stw 11,612(31)
.L386:
	neg 0,11
	subfic 10,29,0
	adde 9,10,29
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L387
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
	lis 9,.LC61@ha
	lis 10,.LC61@ha
	lis 11,.LC55@ha
	mr 6,3
	la 9,.LC61@l(9)
	la 10,.LC61@l(10)
	mtlr 0
	la 11,.LC55@l(11)
	mr 4,28
	lfs 1,0(9)
	mr 3,27
	li 5,0
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L388
.L387:
	neg 0,29
	subfic 10,11,0
	adde 9,10,11
	srwi 0,0,31
	and. 11,0,9
	bc 12,2,.L388
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
	lis 9,.LC61@ha
	lis 10,.LC61@ha
	lis 11,.LC55@ha
	mr 6,3
	la 9,.LC61@l(9)
	la 10,.LC61@l(10)
	mtlr 0
	la 11,.LC55@l(11)
	mr 4,28
	lfs 1,0(9)
	mr 3,27
	li 5,0
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L388:
	lwz 29,560(31)
	cmpwi 0,29,0
	bc 12,2,.L353
	lis 9,gi@ha
	la 28,gi@l(9)
.L393:
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
	bc 4,2,.L393
.L353:
	lwz 0,148(1)
	mtlr 0
	lmw 27,124(1)
	la 1,144(1)
	blr
.Lfe9:
	.size	 SV_Physics_NewToss,.Lfe9-SV_Physics_NewToss
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
	b .L399
.L9:
	lis 9,g_edicts@ha
	lwz 3,g_edicts@l(9)
.L399:
	lwz 0,84(1)
	mtlr 0
	la 1,80(1)
	blr
.Lfe10:
	.size	 SV_TestEntityPosition,.Lfe10-SV_TestEntityPosition
	.align 2
	.globl SV_CheckVelocity
	.type	 SV_CheckVelocity,@function
SV_CheckVelocity:
	li 0,3
	lis 9,sv_maxvelocity@ha
	mtctr 0
	lwz 9,sv_maxvelocity@l(9)
	addi 3,3,376
.L400:
	lfs 13,0(3)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 12,1,.L401
	fneg 0,0
	fcmpu 0,13,0
	bc 4,0,.L13
.L401:
	stfs 0,0(3)
.L13:
	addi 3,3,4
	bdnz .L400
	blr
.Lfe11:
	.size	 SV_CheckVelocity,.Lfe11-SV_CheckVelocity
	.section	".rodata"
	.align 3
.LC62:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC63:
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
	lis 9,.LC63@ha
	mr 31,3
	la 9,.LC63@l(9)
	lfs 12,428(31)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L403
	lis 9,level+4@ha
	lis 11,.LC62@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC62@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 4,1,.L21
.L403:
	li 3,1
	b .L402
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
.L402:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 SV_RunThink,.Lfe12-SV_RunThink
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
.Lfe13:
	.size	 SV_Impact,.Lfe13-SV_Impact
	.section	".rodata"
	.align 3
.LC64:
	.long 0xbfb99999
	.long 0x9999999a
	.align 3
.LC65:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC66:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClipVelocity
	.type	 ClipVelocity,@function
ClipVelocity:
	lis 9,.LC66@ha
	lfs 9,8(4)
	li 8,0
	la 9,.LC66@l(9)
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
	lis 11,.LC64@ha
	lfs 13,0(3)
	andc 9,9,0
	lis 10,.LC65@ha
	lfs 11,0(4)
	and 0,8,0
	li 7,0
	fmuls 12,12,0
	or 8,0,9
	lfd 10,.LC64@l(11)
	lfs 0,8(3)
	li 0,3
	li 9,0
	mtctr 0
	fmadds 13,13,11,12
	lfd 12,.LC65@l(10)
	fmadds 0,0,9,13
	fmuls 1,0,1
.L404:
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
	bdnz .L404
	mr 3,8
	blr
.Lfe14:
	.size	 ClipVelocity,.Lfe14-ClipVelocity
	.section	".rodata"
	.align 3
.LC67:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC68:
	.long 0x0
	.section	".text"
	.align 2
	.globl SV_AddGravity
	.type	 SV_AddGravity,@function
SV_AddGravity:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC68@ha
	mr 4,3
	la 9,.LC68@l(9)
	lfs 0,1056(4)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L88
	lis 9,sv_gravity@ha
	lfs 1,408(4)
	lis 11,.LC67@ha
	lwz 10,sv_gravity@l(9)
	addi 3,4,376
	lfd 13,.LC67@l(11)
	addi 4,4,1048
	mr 5,3
	lfs 0,20(10)
	fmuls 1,1,0
	fmul 1,1,13
	frsp 1,1
	bl VectorMA
	b .L89
.L88:
	lis 10,sv_gravity@ha
	lfs 13,408(4)
	lis 9,.LC67@ha
	lwz 11,sv_gravity@l(10)
	lfs 0,384(4)
	lfs 12,20(11)
	lfd 11,.LC67@l(9)
	fmuls 13,13,12
	fmul 13,13,11
	fsub 0,0,13
	frsp 0,0
	stfs 0,384(4)
.L89:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 SV_AddGravity,.Lfe15-SV_AddGravity
	.comm	pushed,32768,4
	.comm	pushed_p,4,4
	.comm	obstacle,4,4
	.section	".rodata"
	.align 3
.LC69:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC70:
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
	lis 9,.LC70@ha
	mr 31,3
	la 9,.LC70@l(9)
	lfs 12,428(31)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L192
	lis 9,level+4@ha
	lis 11,.LC69@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC69@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L192
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L194
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L194:
	lwz 0,436(31)
	mr 3,31
	mtlr 0
	blrl
.L192:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe16:
	.size	 SV_Physics_None,.Lfe16-SV_Physics_None
	.section	".rodata"
	.align 3
.LC71:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC72:
	.long 0x3dcccccd
	.align 2
.LC73:
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
	lis 9,.LC73@ha
	mr 31,3
	la 9,.LC73@l(9)
	lfs 12,428(31)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L405
	lis 9,level+4@ha
	lis 11,.LC71@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC71@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 4,1,.L199
.L405:
	li 0,1
	b .L198
.L199:
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L200
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L200:
	lwz 9,436(31)
	mr 3,31
	mtlr 9
	blrl
	li 0,0
.L198:
	cmpwi 0,0,0
	bc 12,2,.L195
	lis 29,.LC72@ha
	addi 3,31,16
	lfs 1,.LC72@l(29)
	mr 5,3
	addi 4,31,388
	bl VectorMA
	lfs 1,.LC72@l(29)
	addi 3,31,4
	addi 4,31,376
	mr 5,3
	bl VectorMA
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L195:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 SV_Physics_Noclip,.Lfe17-SV_Physics_Noclip
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
