	.file	"g_phys.c"
gcc2_compiled.:
	.section	".text"
	.align 2
	.globl SV_TestEntityPosition
	.type	 SV_TestEntityPosition,@function
SV_TestEntityPosition:
	stwu 1,-96(1)
	mflr 0
	stmw 30,88(1)
	stw 0,100(1)
	mr 31,3
	lis 9,transparent_list@ha
	lwz 11,252(31)
	lwz 10,transparent_list@l(9)
	addic 0,11,-1
	subfe 0,0,0
	andc 11,11,0
	cmpwi 0,10,0
	rlwinm 0,0,0,30,31
	or 30,0,11
	bc 12,2,.L9
	lis 10,teamplay@ha
	lwz 9,teamplay@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,80(1)
	lwz 11,84(1)
	cmpwi 0,11,0
	bc 12,2,.L9
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L9
	li 3,2
	bl TransparentListSet
.L9:
	lis 9,gi+48@ha
	addi 4,31,4
	lwz 0,gi+48@l(9)
	mr 8,31
	addi 3,1,8
	mr 9,30
	addi 5,31,188
	mtlr 0
	addi 6,31,200
	mr 7,4
	blrl
	lis 9,transparent_list@ha
	lwz 0,transparent_list@l(9)
	cmpwi 0,0,0
	bc 12,2,.L10
	lis 10,teamplay@ha
	lwz 9,teamplay@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,80(1)
	lwz 11,84(1)
	cmpwi 0,11,0
	bc 12,2,.L10
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L10
	li 3,1
	bl TransparentListSet
.L10:
	lwz 0,12(1)
	cmpwi 0,0,0
	bc 4,2,.L11
	li 3,0
	b .L12
.L11:
	lis 9,g_edicts@ha
	lwz 3,g_edicts@l(9)
.L12:
	lwz 0,100(1)
	mtlr 0
	lmw 30,88(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 SV_TestEntityPosition,.Lfe1-SV_TestEntityPosition
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
	mr 28,3
	addi 9,1,200
	fmr 30,1
	lfs 0,376(28)
	addi 7,28,200
	addi 0,28,188
	stw 7,236(1)
	li 20,0
	addi 11,1,136
	stw 0,232(1)
	lis 7,.LC7@ha
	li 18,0
	lfs 13,380(28)
	la 7,.LC7@l(7)
	lis 16,vec3_origin@ha
	lfs 12,384(28)
	addi 14,28,4
	addi 15,28,376
	lfs 29,0(7)
	la 21,vec3_origin@l(16)
	stw 9,228(1)
	stfs 0,88(1)
	stfs 13,92(1)
	stw 4,216(1)
	stfs 12,96(1)
	stfs 0,104(1)
	stw 20,220(1)
	stfs 13,108(1)
	stw 11,224(1)
	stfs 12,112(1)
	stw 18,552(28)
.L42:
	li 11,3
	li 9,0
	mtctr 11
.L90:
	lfsx 0,9,15
	addi 7,1,200
	lfsx 13,9,14
	fmadds 0,30,0,13
	stfsx 0,9,7
	addi 9,9,4
	bdnz .L90
	lis 9,transparent_list@ha
	lwz 0,transparent_list@l(9)
	cmpwi 0,0,0
	bc 12,2,.L48
	lis 10,teamplay@ha
	lwz 9,teamplay@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,248(1)
	lwz 11,252(1)
	cmpwi 0,11,0
	bc 12,2,.L48
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L48
	li 3,2
	bl TransparentListSet
.L48:
	lis 7,gi@ha
	lwz 3,224(1)
	mr 4,14
	la 7,gi@l(7)
	lwz 5,232(1)
	mr 8,28
	lwz 11,48(7)
	lwz 7,228(1)
	lwz 6,236(1)
	mtlr 11
	lwz 9,216(1)
	blrl
	lis 7,transparent_list@ha
	lwz 0,transparent_list@l(7)
	cmpwi 0,0,0
	bc 12,2,.L49
	lis 10,teamplay@ha
	lwz 9,teamplay@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,248(1)
	lwz 11,252(1)
	cmpwi 0,11,0
	bc 12,2,.L49
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L49
	li 3,1
	bl TransparentListSet
.L49:
	lwz 0,136(1)
	cmpwi 0,0,0
	bc 12,2,.L50
	lfs 0,vec3_origin@l(16)
	li 3,3
	b .L91
.L50:
	lfs 0,144(1)
	fcmpu 0,0,29
	bc 4,1,.L51
	lfs 9,148(1)
	li 20,0
	lfs 0,152(1)
	lfs 13,156(1)
	lfs 12,376(28)
	lfs 11,380(28)
	lfs 10,384(28)
	stfs 9,4(28)
	stfs 0,8(28)
	stfs 13,12(28)
	stfs 12,104(1)
	stfs 11,108(1)
	stfs 10,112(1)
.L51:
	lis 7,.LC8@ha
	lfs 13,144(1)
	la 7,.LC8@l(7)
	lfs 0,0(7)
	fcmpu 0,13,0
	bc 12,2,.L40
	lfs 0,168(1)
	lis 9,.LC4@ha
	lfd 13,.LC4@l(9)
	lwz 9,188(1)
	fcmpu 0,0,13
	bc 4,1,.L53
	lwz 0,248(9)
	ori 18,18,1
	cmpwi 0,0,3
	bc 4,2,.L53
	stw 9,552(28)
	lwz 0,92(9)
	stw 0,556(28)
.L53:
	lfs 0,168(1)
	ori 9,18,2
	lwz 11,444(28)
	lwz 30,188(1)
	fcmpu 7,0,29
	cmpwi 0,11,0
	crnor 31,30,30
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,18,0
	or 18,0,9
	bc 12,2,.L56
	lwz 0,248(28)
	cmpwi 0,0,0
	bc 12,2,.L56
	mr 3,28
	mr 4,30
	lwz 6,180(1)
	mtlr 11
	addi 5,1,160
	blrl
.L56:
	lwz 9,444(30)
	cmpwi 0,9,0
	bc 12,2,.L58
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 12,2,.L58
	mr 3,30
	mr 4,28
	mtlr 9
	li 5,0
	li 6,0
	blrl
.L58:
	lwz 0,88(28)
	cmpwi 0,0,0
	bc 12,2,.L40
	lfs 0,144(1)
	cmpwi 0,20,4
	fmuls 0,30,0
	fsubs 30,30,0
	bc 4,1,.L60
	lfs 0,vec3_origin@l(16)
	li 3,3
	b .L91
.L60:
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
	mr 19,9
	stfsx 13,11,0
	lfs 0,168(1)
	stfsx 0,9,0
	bc 4,0,.L62
	addi 22,1,104
	addi 25,1,120
	li 24,0
.L64:
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
.L89:
	lfsx 0,8,10
	lfsx 13,8,22
	fmuls 0,0,12
	fsubs 13,13,0
	fmr 0,13
	stfsx 13,8,25
	fcmpu 0,0,8
	bc 4,1,.L71
	fcmpu 0,0,9
	bc 4,0,.L71
	stwx 0,8,25
.L71:
	addi 8,8,4
	bdnz .L89
	li 29,0
	cmpw 0,29,20
	bc 4,0,.L75
	lis 9,.LC7@ha
	mr 26,23
	la 9,.LC7@l(9)
	mr 30,23
	lfs 31,0(9)
	li 31,0
.L77:
	cmpw 0,29,27
	bc 12,2,.L76
	add 3,26,24
	mr 4,30
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L76
	lfsx 0,31,17
	lfs 11,124(1)
	lfs 12,120(1)
	lfsx 10,31,23
	fmuls 11,11,0
	lfsx 13,31,19
	lfs 0,128(1)
	fmadds 12,12,10,11
	fmadds 0,0,13,12
	fcmpu 0,0,31
	bc 12,0,.L75
.L76:
	addi 29,29,1
	addi 30,30,12
	cmpw 0,29,20
	addi 31,31,12
	bc 12,0,.L77
.L75:
	cmpw 0,29,20
	bc 12,2,.L62
	addi 27,27,1
	addi 24,24,12
	cmpw 0,27,20
	bc 12,0,.L64
.L62:
	cmpw 0,27,20
	bc 12,2,.L83
	lfs 0,120(1)
	lfs 13,124(1)
	lfs 12,128(1)
	stfs 0,376(28)
	stfs 13,380(28)
	stfs 12,384(28)
	b .L84
.L83:
	cmpwi 0,20,2
	bc 12,2,.L85
	lfs 0,vec3_origin@l(16)
	li 3,7
	b .L91
.L85:
	mr 3,23
	addi 4,1,36
	addi 5,1,8
	bl CrossProduct
	lfs 0,380(28)
	addi 3,1,8
	mr 4,15
	lfs 13,12(1)
	lfs 1,8(1)
	lfs 12,376(28)
	fmuls 13,13,0
	lfs 11,16(1)
	lfs 0,384(28)
	fmadds 1,1,12,13
	fmadds 1,11,0,1
	bl VectorScale
.L84:
	lfs 0,92(1)
	lfs 11,380(28)
	lfs 13,376(28)
	lfs 10,88(1)
	fmuls 11,11,0
	lfs 12,96(1)
	lfs 0,384(28)
	fmadds 13,13,10,11
	fmadds 0,0,12,13
	fcmpu 0,0,29
	cror 3,2,0
	bc 4,3,.L41
	lfs 0,vec3_origin@l(16)
	mr 3,18
.L91:
	stfs 0,376(28)
	lfs 13,4(21)
	stfs 13,380(28)
	lfs 0,8(21)
	stfs 0,384(28)
	b .L88
.L41:
	lwz 7,220(1)
	addi 7,7,1
	cmpwi 0,7,4
	stw 7,220(1)
	bc 12,0,.L42
.L40:
	mr 3,18
.L88:
	lwz 0,356(1)
	mtlr 0
	lmw 14,256(1)
	lfd 29,328(1)
	lfd 30,336(1)
	lfd 31,344(1)
	la 1,352(1)
	blr
.Lfe2:
	.size	 SV_FlyMove,.Lfe2-SV_FlyMove
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
	stwu 1,-144(1)
	mflr 0
	stmw 26,120(1)
	stw 0,148(1)
	mr 31,4
	lfs 12,8(5)
	mr 28,3
	lfs 10,4(31)
	addi 26,1,72
	addi 27,1,88
	lfs 11,8(31)
	addi 29,1,8
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
.L94:
	lwz 9,252(31)
	lis 11,transparent_list@ha
	lwz 10,transparent_list@l(11)
	addic 0,9,-1
	subfe 0,0,0
	andc 9,9,0
	cmpwi 0,10,0
	rlwinm 0,0,0,30,31
	or 30,0,9
	bc 12,2,.L97
	lis 10,teamplay@ha
	lwz 9,teamplay@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,112(1)
	lwz 11,116(1)
	cmpwi 0,11,0
	bc 12,2,.L97
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L97
	li 3,2
	bl TransparentListSet
.L97:
	lis 11,gi+48@ha
	mr 9,30
	lwz 0,gi+48@l(11)
	addi 3,1,8
	mr 4,26
	addi 5,31,188
	addi 6,31,200
	mtlr 0
	mr 7,27
	mr 8,31
	blrl
	lis 9,transparent_list@ha
	lwz 0,transparent_list@l(9)
	cmpwi 0,0,0
	bc 12,2,.L98
	lis 10,teamplay@ha
	lwz 9,teamplay@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,112(1)
	lwz 11,116(1)
	cmpwi 0,11,0
	bc 12,2,.L98
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L98
	li 3,1
	bl TransparentListSet
.L98:
	lfs 0,24(1)
	lis 9,gi+72@ha
	mr 3,31
	lfs 13,28(1)
	lfs 12,20(1)
	stfs 0,8(31)
	stfs 13,12(31)
	stfs 12,4(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lfs 0,16(1)
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L99
	lwz 9,444(31)
	lwz 30,52(29)
	cmpwi 0,9,0
	bc 12,2,.L100
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L100
	mr 3,31
	mr 4,30
	lwz 6,44(29)
	mtlr 9
	addi 5,1,32
	blrl
.L100:
	lwz 9,444(30)
	cmpwi 0,9,0
	bc 12,2,.L102
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 12,2,.L102
	mr 3,30
	mr 4,31
	mtlr 9
	li 5,0
	li 6,0
	blrl
.L102:
	lwz 9,60(1)
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 4,2,.L99
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L104
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
	b .L94
.L99:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L104
	mr 3,31
	bl G_TouchTriggers
.L104:
	mr 4,29
	mr 3,28
	li 5,56
	crxor 6,6,6
	bl memcpy
	mr 3,28
	lwz 0,148(1)
	mtlr 0
	lmw 26,120(1)
	la 1,144(1)
	blr
.Lfe3:
	.size	 SV_PushEntity,.Lfe3-SV_PushEntity
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
	stwu 1,-208(1)
	mflr 0
	stmw 21,164(1)
	stw 0,212(1)
	lis 9,.LC11@ha
	lis 11,.LC13@ha
	la 9,.LC11@l(9)
	la 11,.LC13@l(11)
	lis 10,.LC12@ha
	lfd 8,0(9)
	mr 29,4
	la 10,.LC12@l(10)
	lfd 12,0(11)
	lis 9,.LC14@ha
	lfd 9,0(10)
	li 11,3
	la 9,.LC14@l(9)
	lis 10,.LC15@ha
	mtctr 11
	lfd 10,0(9)
	mr 30,3
	la 10,.LC15@l(10)
	mr 28,5
	lfd 11,0(10)
	addi 8,1,8
	addi 31,1,24
	addi 3,1,40
	addi 4,1,88
	addi 5,1,104
	addi 6,1,120
	lis 25,pushed_p@ha
	lis 23,gi@ha
	lis 21,globals@ha
	lis 22,pushed@ha
	lis 0,0x4330
	mr 10,29
.L151:
	lfs 0,0(10)
	fmul 0,0,8
	frsp 0,0
	fcmpu 0,0,9
	bc 4,1,.L110
	fadd 0,0,12
	b .L152
.L110:
	fsub 0,0,12
.L152:
	frsp 0,0
	fmr 13,0
	mr 11,9
	fctiwz 0,13
	stfd 0,152(1)
	lwz 9,156(1)
	xoris 9,9,0x8000
	stw 9,156(1)
	stw 0,152(1)
	lfd 0,152(1)
	fsub 0,0,10
	fmul 0,0,11
	frsp 0,0
	stfs 0,0(10)
	addi 10,10,4
	bdnz .L151
	li 0,3
	mr 7,8
	mtctr 0
	mr 8,31
	addi 10,30,212
	addi 11,30,224
	li 9,0
.L150:
	lfsx 0,9,29
	lfsx 13,9,10
	lfsx 12,9,11
	fadds 13,13,0
	fadds 12,12,0
	stfsx 13,9,7
	stfsx 12,9,8
	addi 9,9,4
	bdnz .L150
	lis 9,vec3_origin@ha
	lfs 10,0(28)
	lfs 12,vec3_origin@l(9)
	la 11,vec3_origin@l(9)
	lfs 13,4(28)
	lfs 11,8(11)
	fsubs 12,12,10
	lfs 0,4(11)
	lfs 10,8(28)
	fsubs 0,0,13
	stfs 12,40(1)
	fsubs 11,11,10
	stfs 0,44(1)
	stfs 11,48(1)
	bl AngleVectors
	lis 9,pushed_p@ha
	lwz 10,pushed_p@l(9)
	stw 30,0(10)
	lfs 0,4(30)
	stfs 0,4(10)
	lfs 13,8(30)
	stfs 13,8(10)
	lfs 0,12(30)
	stfs 0,12(10)
	lfs 13,16(30)
	stfs 13,16(10)
	lfs 0,20(30)
	stfs 0,20(10)
	lfs 13,24(30)
	stfs 13,24(10)
	lwz 9,84(30)
	cmpwi 0,9,0
	bc 12,2,.L118
	lha 0,22(9)
	lis 11,0x4330
	lis 8,.LC14@ha
	la 8,.LC14@l(8)
	xoris 0,0,0x8000
	lfd 13,0(8)
	stw 0,156(1)
	stw 11,152(1)
	lfd 0,152(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,28(10)
.L118:
	lwz 9,pushed_p@l(25)
	lis 11,gi+72@ha
	mr 3,30
	lfs 13,4(30)
	li 26,1
	lfs 12,8(30)
	addi 9,9,32
	stw 9,pushed_p@l(25)
	lfs 0,0(29)
	lfs 11,12(30)
	lfs 10,16(30)
	fadds 13,13,0
	lfs 9,20(30)
	lfs 8,24(30)
	stfs 13,4(30)
	lfs 0,4(29)
	fadds 12,12,0
	stfs 12,8(30)
	lfs 0,8(29)
	fadds 11,11,0
	stfs 11,12(30)
	lfs 0,0(28)
	fadds 10,10,0
	stfs 10,16(30)
	lfs 0,4(28)
	fadds 9,9,0
	stfs 9,20(30)
	lfs 0,8(28)
	fadds 8,8,0
	stfs 8,24(30)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lis 9,globals+72@ha
	lis 11,g_edicts@ha
	lwz 0,globals+72@l(9)
	lwz 10,g_edicts@l(11)
	cmpw 0,26,0
	addi 31,10,996
	bc 4,0,.L120
	lis 24,pushed_p@ha
.L122:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L121
	lwz 11,260(31)
	addi 0,11,-2
	subfic 8,11,0
	adde 9,8,11
	subfic 0,0,1
	li 0,0
	adde 0,0,0
	or. 27,0,9
	bc 4,2,.L121
	cmpwi 0,11,1
	bc 12,2,.L121
	lwz 0,96(31)
	cmpwi 0,0,0
	bc 12,2,.L121
	lwz 0,552(31)
	cmpw 0,0,30
	bc 12,2,.L127
	lfs 13,212(31)
	lfs 0,24(1)
	fcmpu 0,13,0
	cror 3,2,1
	bc 12,3,.L121
	lfs 13,216(31)
	lfs 0,28(1)
	fcmpu 0,13,0
	cror 3,2,1
	bc 12,3,.L121
	lfs 13,220(31)
	lfs 0,32(1)
	fcmpu 0,13,0
	cror 3,2,1
	bc 12,3,.L121
	lfs 13,224(31)
	lfs 0,8(1)
	fcmpu 0,13,0
	cror 3,2,0
	bc 12,3,.L121
	lfs 13,228(31)
	lfs 0,12(1)
	fcmpu 0,13,0
	cror 3,2,0
	bc 12,3,.L121
	lfs 13,232(31)
	lfs 0,16(1)
	fcmpu 0,13,0
	cror 3,2,0
	bc 12,3,.L121
	mr 3,31
	bl SV_TestEntityPosition
	cmpwi 0,3,0
	bc 12,2,.L121
.L127:
	lwz 0,260(30)
	cmpwi 0,0,2
	bc 12,2,.L132
	lwz 0,552(31)
	cmpw 0,0,30
	bc 4,2,.L131
.L132:
	lwz 9,pushed_p@l(24)
	stw 31,0(9)
	addi 0,9,32
	lfs 0,4(31)
	stfs 0,4(9)
	lfs 13,8(31)
	stfs 13,8(9)
	lfs 0,12(31)
	stfs 0,12(9)
	lfs 13,16(31)
	stfs 13,16(9)
	lfs 0,20(31)
	stfs 0,20(9)
	lfs 13,24(31)
	stfs 13,24(9)
	lwz 8,84(31)
	stw 0,pushed_p@l(24)
	lfs 0,0(29)
	cmpwi 0,8,0
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fadds 13,13,0
	stfs 13,4(31)
	lfs 0,4(29)
	fadds 12,12,0
	stfs 12,8(31)
	lfs 0,8(29)
	fadds 11,11,0
	stfs 11,12(31)
	bc 12,2,.L133
	lha 0,22(8)
	lis 10,0x4330
	lis 11,.LC14@ha
	lfs 11,4(28)
	xoris 0,0,0x8000
	la 11,.LC14@l(11)
	stw 0,156(1)
	stw 10,152(1)
	lfd 13,0(11)
	lfd 0,152(1)
	mr 11,9
	fsub 0,0,13
	frsp 0,0
	fadds 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,152(1)
	lwz 11,156(1)
	sth 11,22(8)
.L133:
	lfs 0,4(30)
	lfs 9,4(31)
	lfs 13,8(30)
	lfs 5,92(1)
	fsubs 9,9,0
	lfs 4,108(1)
	lfs 3,124(1)
	lfs 8,88(1)
	stfs 9,40(1)
	lfs 0,8(31)
	lfs 10,12(30)
	lfs 7,104(1)
	fsubs 0,0,13
	lfs 6,120(1)
	lfs 12,96(1)
	lfs 11,112(1)
	stfs 0,44(1)
	fmuls 5,0,5
	lfs 13,12(31)
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
	lfs 0,4(31)
	lfs 13,8(31)
	lfs 12,12(31)
	fadds 0,0,9
	lwz 0,552(31)
	cmpw 0,0,30
	stfs 0,4(31)
	lfs 0,76(1)
	fadds 13,13,0
	stfs 13,8(31)
	lfs 0,80(1)
	fadds 12,12,0
	stfs 12,12(31)
	bc 12,2,.L134
	stw 27,552(31)
.L134:
	mr 3,31
	bl SV_TestEntityPosition
	cmpwi 0,3,0
	bc 4,2,.L135
	la 9,gi@l(23)
	mr 3,31
	lwz 0,72(9)
	mtlr 0
	blrl
	b .L121
.L135:
	lfs 0,0(29)
	mr 3,31
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,4(31)
	lfs 0,4(29)
	fsubs 12,12,0
	stfs 12,8(31)
	lfs 0,8(29)
	fsubs 11,11,0
	stfs 11,12(31)
	bl SV_TestEntityPosition
	cmpwi 0,3,0
	bc 4,2,.L131
	lwz 9,pushed_p@l(25)
	addi 9,9,-32
	stw 9,pushed_p@l(25)
	b .L121
.L131:
	lwz 11,pushed_p@l(25)
	lis 9,obstacle@ha
	la 0,pushed@l(22)
	stw 31,obstacle@l(9)
	addi 31,11,-32
	cmplw 0,31,0
	bc 12,0,.L138
	lis 9,gi@ha
	mr 29,0
	la 30,gi@l(9)
.L140:
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
	bc 12,2,.L141
	lfs 0,28(31)
	fctiwz 13,0
	stfd 13,152(1)
	lwz 9,156(1)
	sth 9,22(11)
.L141:
	lwz 9,72(30)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,-32
	blrl
	cmplw 0,31,29
	bc 4,0,.L140
.L138:
	li 3,0
	b .L149
.L121:
	la 9,globals@l(21)
	addi 26,26,1
	lwz 0,72(9)
	addi 31,31,996
	cmpw 0,26,0
	bc 12,0,.L122
.L120:
	lis 9,pushed_p@ha
	lis 11,pushed@ha
	lwz 10,pushed_p@l(9)
	la 11,pushed@l(11)
	addi 31,10,-32
	cmplw 0,31,11
	bc 12,0,.L145
	mr 30,11
.L147:
	lwz 3,0(31)
	addi 31,31,-32
	bl G_TouchTriggers
	cmplw 0,31,30
	bc 4,0,.L147
.L145:
	li 3,1
.L149:
	lwz 0,212(1)
	mtlr 0
	lmw 21,164(1)
	la 1,208(1)
	blr
.Lfe4:
	.size	 SV_Push,.Lfe4-SV_Push
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
	bc 4,2,.L153
	lis 9,pushed@ha
	mr. 31,29
	la 9,pushed@l(9)
	lis 11,pushed_p@ha
	stw 9,pushed_p@l(11)
	bc 12,2,.L156
	lis 11,.LC20@ha
	lis 28,.LC16@ha
	la 11,.LC20@l(11)
	addi 30,1,24
	lfs 31,0(11)
.L158:
	lfs 0,376(31)
	fcmpu 0,0,31
	bc 4,2,.L160
	lfs 0,380(31)
	fcmpu 0,0,31
	bc 4,2,.L160
	lfs 0,384(31)
	fcmpu 0,0,31
	bc 4,2,.L160
	lfs 0,388(31)
	fcmpu 0,0,31
	bc 4,2,.L160
	lfs 0,392(31)
	fcmpu 0,0,31
	bc 4,2,.L160
	lfs 0,396(31)
	fcmpu 0,0,31
	bc 12,2,.L157
.L160:
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
	bc 12,2,.L156
.L157:
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L158
.L156:
	lis 9,pushed_p@ha
	lis 11,pushed+32768@ha
	lwz 0,pushed_p@l(9)
	la 11,pushed+32768@l(11)
	cmplw 0,0,11
	bc 4,1,.L163
	lis 9,gi+28@ha
	lis 4,.LC17@ha
	lwz 0,gi+28@l(9)
	la 4,.LC17@l(4)
	li 3,0
	mtlr 0
	crxor 6,6,6
	blrl
.L163:
	cmpwi 0,31,0
	bc 12,2,.L164
	mr 3,29
	cmpwi 0,3,0
	bc 12,2,.L166
	lis 11,.LC20@ha
	lis 9,.LC18@ha
	la 11,.LC20@l(11)
	lfd 13,.LC18@l(9)
	lfs 12,0(11)
.L168:
	lfs 0,428(3)
	fcmpu 0,0,12
	bc 4,1,.L167
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
.L167:
	lwz 3,560(3)
	cmpwi 0,3,0
	bc 4,2,.L168
.L166:
	lwz 0,440(31)
	cmpwi 0,0,0
	bc 12,2,.L153
	lis 9,obstacle@ha
	mr 3,31
	mtlr 0
	lwz 4,obstacle@l(9)
	blrl
	b .L153
.L164:
	mr. 31,29
	bc 12,2,.L153
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
.L176:
	lfs 13,428(31)
	fcmpu 0,13,31
	cror 3,2,0
	bc 12,3,.L175
	lfs 0,4(28)
	fadd 0,0,30
	fcmpu 0,13,0
	bc 12,1,.L175
	lwz 0,436(31)
	stfs 31,428(31)
	cmpwi 0,0,0
	bc 4,2,.L180
	lwz 9,28(29)
	la 3,.LC1@l(30)
	mtlr 9
	crxor 6,6,6
	blrl
.L180:
	lwz 9,436(31)
	mr 3,31
	mtlr 9
	blrl
.L175:
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L176
.L153:
	lwz 0,84(1)
	mtlr 0
	lmw 28,48(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe5:
	.size	 SV_Physics_Pusher,.Lfe5-SV_Physics_Pusher
	.section	".rodata"
	.align 2
.LC29:
	.string	"misc/h2ohit1.wav"
	.align 3
.LC24:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC25:
	.long 0x3dcccccd
	.align 3
.LC26:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC27:
	.long 0xbf19999a
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
	.long 0x3f400000
	.align 2
.LC33:
	.long 0x41a00000
	.align 3
.LC34:
	.long 0x3ff80000
	.long 0x0
	.align 3
.LC35:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl SV_Physics_Bounce
	.type	 SV_Physics_Bounce,@function
SV_Physics_Bounce:
	stwu 1,-208(1)
	mflr 0
	stfd 29,184(1)
	stfd 30,192(1)
	stfd 31,200(1)
	stmw 24,152(1)
	stw 0,212(1)
	lis 9,.LC30@ha
	mr 31,3
	la 9,.LC30@l(9)
	lfs 12,428(31)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L195
	lis 9,level+4@ha
	lis 11,.LC24@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC24@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L195
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
.L195:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L193
	lwz 0,264(31)
	andi. 0,0,1024
	bc 4,2,.L193
	lis 9,.LC30@ha
	lfs 13,384(31)
	la 9,.LC30@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L200
	stw 0,552(31)
.L200:
	lwz 9,552(31)
	cmpwi 0,9,0
	bc 12,2,.L231
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 4,2,.L201
	stw 0,552(31)
.L201:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L193
.L231:
	li 0,3
	lfs 12,4(31)
	lis 9,sv_maxvelocity@ha
	lfs 13,8(31)
	mtctr 0
	addi 28,31,376
	addi 3,31,16
	lfs 0,12(31)
	mr 11,28
	addi 4,31,388
	lwz 10,sv_maxvelocity@l(9)
	lis 24,sv_gravity@ha
	lis 25,.LC26@ha
	addi 30,1,72
	stfs 12,136(1)
	li 9,0
	stfs 13,140(1)
	stfs 0,144(1)
.L233:
	lfsx 13,9,11
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 12,1,.L234
	fneg 0,0
	fcmpu 0,13,0
	bc 4,0,.L210
.L234:
	stfsx 0,9,28
.L210:
	addi 9,9,4
	bdnz .L233
	lis 29,.LC25@ha
	lis 9,.LC30@ha
	lfs 1,.LC25@l(29)
	la 9,.LC30@l(9)
	mr 26,30
	lfs 30,0(9)
	mr 5,3
	addi 30,1,104
	addi 27,1,88
	bl VectorMA
	lis 9,sv_gravity@ha
	lfs 13,408(31)
	lis 11,.LC26@ha
	lwz 10,sv_gravity@l(9)
	lis 8,.LC28@ha
	lfs 0,384(31)
	lfs 12,20(10)
	lfd 11,.LC26@l(11)
	lfd 29,.LC28@l(8)
	fmuls 13,13,12
	lfs 31,.LC25@l(29)
	fmul 13,13,11
	fsub 0,0,13
	frsp 0,0
	stfs 0,384(31)
.L215:
	fmr 1,31
	mr 3,28
	mr 4,26
	bl VectorScale
	addi 3,1,8
	mr 4,31
	mr 5,26
	bl SV_PushEntity
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L193
	lis 9,.LC31@ha
	lfs 13,16(1)
	la 9,.LC31@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L217
	lfs 13,36(1)
	addi 3,1,32
	mr 4,30
	lfs 0,380(31)
	lfs 1,32(1)
	lfs 12,376(31)
	fmuls 13,13,0
	lfs 11,40(1)
	lfs 0,384(31)
	fmadds 1,1,12,13
	fmadds 1,11,0,1
	bl VectorScale
	lfs 11,376(31)
	lis 9,.LC32@ha
	mr 3,27
	lfs 12,104(1)
	la 9,.LC32@l(9)
	mr 4,27
	lfs 13,380(31)
	lfs 0,384(31)
	fsubs 11,11,12
	lfs 10,108(1)
	lfs 12,112(1)
	lfs 1,0(9)
	fsubs 13,13,10
	stfs 11,88(1)
	fsubs 0,0,12
	stfs 13,92(1)
	stfs 0,96(1)
	bl VectorScale
	lis 9,.LC27@ha
	mr 3,27
	lfs 1,.LC27@l(9)
	mr 4,30
	mr 5,28
	bl VectorMA
	lfs 0,40(1)
	fcmpu 0,0,29
	bc 4,1,.L217
	lfs 0,380(31)
	addi 3,1,120
	lfs 13,376(31)
	stfs 30,128(1)
	stfs 0,124(1)
	stfs 13,120(1)
	bl VectorLength
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L217
	lwz 9,sv_gravity@l(24)
	lis 10,.LC34@ha
	lfs 0,408(31)
	la 10,.LC34@l(10)
	lfs 12,20(9)
	lfd 11,.LC26@l(25)
	lfd 10,0(10)
	fmuls 0,0,12
	lfs 13,384(31)
	fmul 0,0,11
	fmul 0,0,10
	fcmpu 0,13,0
	bc 12,0,.L232
.L217:
	lfs 0,16(1)
	lis 11,.LC35@ha
	fmr 12,31
	la 11,.LC35@l(11)
	lfd 13,0(11)
	fsub 13,13,0
	fmul 12,12,13
	frsp 31,12
	fcmpu 0,31,30
	bc 12,1,.L215
.L214:
	lis 9,gi+52@ha
	addi 3,31,4
	lwz 0,608(31)
	lwz 9,gi+52@l(9)
	mr 30,3
	rlwinm 29,0,0,26,28
	mtlr 9
	blrl
	andi. 11,3,56
	stw 3,608(31)
	bc 12,2,.L221
	li 0,1
	stw 0,612(31)
	b .L222
.L232:
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
	b .L214
.L221:
	stw 11,612(31)
.L222:
	neg 0,11
	subfic 10,29,0
	adde 9,10,29
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L223
	lis 29,gi@ha
	lis 3,.LC29@ha
	la 29,gi@l(29)
	la 3,.LC29@l(3)
	lwz 11,36(29)
	lis 9,g_edicts@ha
	addi 27,1,136
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
	b .L224
.L223:
	neg 0,29
	subfic 10,11,0
	adde 9,10,11
	srwi 0,0,31
	and. 11,0,9
	bc 12,2,.L224
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
.L224:
	lwz 29,560(31)
	cmpwi 0,29,0
	bc 12,2,.L193
	lis 9,gi@ha
	la 28,gi@l(9)
.L229:
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
	bc 4,2,.L229
.L193:
	lwz 0,212(1)
	mtlr 0
	lmw 24,152(1)
	lfd 29,184(1)
	lfd 30,192(1)
	lfd 31,200(1)
	la 1,208(1)
	blr
.Lfe6:
	.size	 SV_Physics_Bounce,.Lfe6-SV_Physics_Bounce
	.section	".rodata"
	.align 3
.LC36:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 3
.LC37:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC38:
	.long 0x3dcccccd
	.align 2
.LC39:
	.long 0x3fb33333
	.align 3
.LC40:
	.long 0xbfb99999
	.long 0x9999999a
	.align 3
.LC41:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC42:
	.long 0x0
	.align 2
.LC43:
	.long 0x3f800000
	.align 2
.LC44:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl SV_Physics_Toss
	.type	 SV_Physics_Toss,@function
SV_Physics_Toss:
	stwu 1,-128(1)
	mflr 0
	stmw 27,108(1)
	stw 0,132(1)
	lis 7,.LC42@ha
	mr 31,3
	la 7,.LC42@l(7)
	lfs 12,428(31)
	lfs 11,0(7)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L237
	lis 9,level+4@ha
	lis 11,.LC36@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC36@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L237
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L239
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L239:
	lwz 9,436(31)
	mr 3,31
	mtlr 9
	blrl
.L237:
	lwz 0,264(31)
	andi. 0,0,1024
	bc 4,2,.L235
	lis 7,.LC42@ha
	lfs 13,384(31)
	la 7,.LC42@l(7)
	lfs 0,0(7)
	fcmpu 0,13,0
	bc 4,1,.L241
	stw 0,552(31)
.L241:
	lwz 9,552(31)
	cmpwi 0,9,0
	bc 12,2,.L284
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 4,2,.L242
	stw 0,552(31)
.L242:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L235
.L284:
	li 0,3
	lfs 12,4(31)
	lis 9,sv_maxvelocity@ha
	lfs 13,8(31)
	mtctr 0
	addi 28,31,376
	addi 3,31,16
	lfs 0,12(31)
	mr 11,28
	addi 4,31,388
	lwz 10,sv_maxvelocity@l(9)
	addi 27,1,72
	li 9,0
	stfs 12,88(1)
	stfs 13,92(1)
	stfs 0,96(1)
.L286:
	lfsx 13,9,11
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 12,1,.L287
	fneg 0,0
	fcmpu 0,13,0
	bc 4,0,.L251
.L287:
	stfsx 0,9,28
.L251:
	addi 9,9,4
	bdnz .L286
	lwz 0,260(31)
	xori 10,0,8
	xori 0,0,6
	addic 7,0,-1
	subfe 11,7,0
	addic 0,10,-1
	subfe 9,0,10
	and. 7,11,9
	bc 12,2,.L254
	lis 10,sv_gravity@ha
	lfs 13,408(31)
	lis 9,.LC37@ha
	lwz 11,sv_gravity@l(10)
	lfd 11,.LC37@l(9)
	lfs 12,20(11)
	lfs 0,384(31)
	fmuls 13,13,12
	fmul 13,13,11
	fsub 0,0,13
	frsp 0,0
	stfs 0,384(31)
.L254:
	lis 29,.LC38@ha
	mr 5,3
	lfs 1,.LC38@l(29)
	bl VectorMA
	lfs 1,.LC38@l(29)
	mr 3,28
	mr 4,27
	bl VectorScale
	mr 5,27
	addi 3,1,8
	mr 4,31
	bl SV_PushEntity
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L235
	lis 7,.LC43@ha
	lfs 0,16(1)
	la 7,.LC43@l(7)
	lfs 13,0(7)
	fmr 12,0
	fcmpu 0,0,13
	bc 4,0,.L257
	lwz 0,260(31)
	cmpwi 0,0,10
	bc 4,2,.L257
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 4,2,.L235
	lwz 3,256(31)
	addi 4,31,4
	addi 5,1,8
	bl AddSplat
	li 0,1
	stw 0,896(31)
	b .L235
.L257:
	lis 7,.LC43@ha
	addi 27,31,4
	la 7,.LC43@l(7)
	lfs 0,0(7)
	fcmpu 0,12,0
	bc 4,0,.L259
	lwz 0,260(31)
	cmpwi 0,0,9
	bc 4,2,.L260
	lis 9,.LC39@ha
	lfs 8,.LC39@l(9)
	b .L261
.L260:
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 8,0(9)
.L261:
	lfs 9,40(1)
	addi 8,1,32
	lfs 0,36(1)
	li 7,3
	lis 9,.LC40@ha
	lfs 11,4(28)
	lis 11,.LC37@ha
	mtctr 7
	addi 27,31,4
	lfs 12,32(1)
	li 0,0
	li 10,0
	lfs 13,376(31)
	fmuls 11,11,0
	lfd 10,.LC40@l(9)
	lfs 0,8(28)
	fmadds 13,13,12,11
	lfd 11,.LC37@l(11)
	fmadds 0,0,9,13
	fmuls 12,0,8
.L285:
	lfsx 0,10,8
	lfsx 13,10,28
	fmuls 0,0,12
	fsubs 13,13,0
	fmr 0,13
	stfsx 13,10,28
	fcmpu 0,0,10
	bc 4,1,.L268
	fcmpu 0,0,11
	bc 4,0,.L268
	stwx 0,10,28
.L268:
	addi 10,10,4
	bdnz .L285
	lfs 0,40(1)
	lis 9,.LC41@ha
	lfd 13,.LC41@l(9)
	fcmpu 0,0,13
	bc 4,1,.L259
	lis 9,.LC44@ha
	lfs 13,384(31)
	la 9,.LC44@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L273
	lwz 0,260(31)
	cmpwi 0,0,9
	bc 12,2,.L259
.L273:
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
.L259:
	lis 9,gi+52@ha
	mr 3,27
	lwz 0,608(31)
	lwz 9,gi+52@l(9)
	rlwinm 29,0,0,26,28
	mtlr 9
	blrl
	andi. 11,3,56
	stw 3,608(31)
	bc 12,2,.L274
	li 0,1
	stw 0,612(31)
	b .L275
.L274:
	stw 11,612(31)
.L275:
	neg 0,11
	subfic 7,29,0
	adde 9,7,29
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L276
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
	lis 7,.LC43@ha
	lis 9,.LC43@ha
	lis 10,.LC42@ha
	mr 6,3
	la 7,.LC43@l(7)
	la 9,.LC43@l(9)
	mtlr 0
	la 10,.LC42@l(10)
	mr 4,28
	lfs 1,0(7)
	mr 3,27
	li 5,0
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L277
.L276:
	neg 0,29
	subfic 7,11,0
	adde 9,7,11
	srwi 0,0,31
	and. 10,0,9
	bc 12,2,.L277
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
	lis 7,.LC43@ha
	lis 9,.LC43@ha
	lis 10,.LC42@ha
	mr 6,3
	la 7,.LC43@l(7)
	la 9,.LC43@l(9)
	mtlr 0
	la 10,.LC42@l(10)
	mr 4,28
	lfs 1,0(7)
	mr 3,27
	li 5,0
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L277:
	lwz 29,560(31)
	cmpwi 0,29,0
	bc 12,2,.L235
	lis 9,gi@ha
	la 28,gi@l(9)
.L282:
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
	bc 4,2,.L282
.L235:
	lwz 0,132(1)
	mtlr 0
	lmw 27,108(1)
	la 1,128(1)
	blr
.Lfe7:
	.size	 SV_Physics_Toss,.Lfe7-SV_Physics_Toss
	.section	".rodata"
	.align 2
.LC49:
	.string	"world/land.wav"
	.align 2
.LC46:
	.long 0x3dcccccd
	.align 3
.LC47:
	.long 0xbfb99999
	.long 0x9999999a
	.align 3
.LC48:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC50:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC51:
	.long 0x0
	.align 2
.LC52:
	.long 0x42700000
	.align 2
.LC53:
	.long 0x42c80000
	.align 3
.LC54:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC55:
	.long 0x0
	.long 0x0
	.align 3
.LC56:
	.long 0x40180000
	.long 0x0
	.align 2
.LC57:
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
	bc 4,2,.L299
	bl M_CheckGround
.L299:
	li 8,3
	lis 9,sv_maxvelocity@ha
	lwz 0,552(31)
	mtctr 8
	addi 28,31,376
	lwz 10,sv_maxvelocity@l(9)
	mr 11,28
	li 9,0
.L360:
	lfsx 13,9,11
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 12,1,.L361
	fneg 0,0
	fcmpu 0,13,0
	bc 4,0,.L306
.L361:
	stfsx 0,9,28
.L306:
	addi 9,9,4
	bdnz .L360
	lis 9,.LC51@ha
	lfs 0,388(31)
	addic 10,0,-1
	subfe 30,10,0
	la 9,.LC51@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L312
	lfs 0,392(31)
	fcmpu 0,0,13
	bc 4,2,.L312
	lfs 0,396(31)
	cmpwi 4,30,0
	fcmpu 0,0,13
	bc 12,2,.L311
.L312:
	lis 9,.LC46@ha
	addi 3,31,16
	lfs 1,.LC46@l(9)
	addi 29,31,388
	mr 5,3
	mr 4,29
	cmpwi 4,30,0
	bl VectorMA
	lis 8,.LC52@ha
	li 10,3
	la 8,.LC52@l(8)
	lis 9,.LC51@ha
	mtctr 10
	la 9,.LC51@l(9)
	lfs 12,0(8)
	mr 11,29
	lfs 13,0(9)
	li 9,0
.L359:
	lfsx 0,9,11
	fcmpu 0,0,13
	bc 4,1,.L316
	fsubs 0,0,12
	fcmpu 0,0,13
	stfsx 0,9,29
	bc 4,0,.L320
	b .L362
.L316:
	fadds 0,0,12
	fcmpu 0,0,13
	stfsx 0,9,29
	bc 4,1,.L320
.L362:
	stfsx 13,9,29
.L320:
	addi 9,9,4
	bdnz .L359
.L311:
	bc 4,18,.L323
	lwz 0,264(31)
	andi. 11,0,1
	bc 4,2,.L358
	andi. 8,0,2
	lwz 0,612(31)
	bc 12,2,.L326
	cmpwi 0,0,2
	bc 12,1,.L323
.L326:
	lis 9,sv_gravity@ha
	lfs 0,384(31)
	lis 10,.LC47@ha
	lwz 11,sv_gravity@l(9)
	lfd 13,.LC47@l(10)
	lfs 11,20(11)
	fmr 12,0
	fmr 0,11
	fmul 0,0,13
	fcmpu 0,12,0
	bc 4,0,.L327
	li 27,1
.L327:
	cmpwi 0,0,0
	bc 4,2,.L323
	lfs 0,408(31)
	lis 9,.LC48@ha
	lfd 13,.LC48@l(9)
	fmuls 0,0,11
	fmul 0,0,13
	fsub 0,12,0
	frsp 0,0
	stfs 0,384(31)
.L323:
	lwz 0,264(31)
	andi. 9,0,1
	bc 12,2,.L330
.L358:
	lis 10,.LC51@ha
	lfs 11,384(31)
	la 10,.LC51@l(10)
	lfs 10,0(10)
	fcmpu 0,11,10
	bc 12,2,.L330
	lis 11,.LC53@ha
	fabs 1,11
	la 11,.LC53@l(11)
	lfs 0,0(11)
	fmr 13,1
	fcmpu 0,1,0
	bc 4,0,.L331
	lis 8,.LC53@ha
	la 8,.LC53@l(8)
	lfs 13,0(8)
.L331:
	lis 9,.LC48@ha
	fmr 0,13
	lfd 12,.LC48@l(9)
	fmr 13,1
	fmul 0,0,12
	fadd 0,0,0
	fsub 13,13,0
	frsp 12,13
	fcmpu 0,12,10
	bc 4,0,.L333
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 12,0(9)
.L333:
	fdivs 12,12,1
	fmuls 0,11,12
	stfs 0,384(31)
.L330:
	lwz 0,264(31)
	andi. 10,0,2
	bc 12,2,.L334
	lis 11,.LC51@ha
	lfs 9,384(31)
	la 11,.LC51@l(11)
	lfs 8,0(11)
	fcmpu 0,9,8
	bc 12,2,.L334
	lis 8,.LC53@ha
	fabs 1,9
	la 8,.LC53@l(8)
	lfs 0,0(8)
	fmr 13,1
	fcmpu 0,1,0
	bc 4,0,.L335
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	lfs 13,0(9)
.L335:
	lwz 0,612(31)
	lis 10,0x4330
	lis 8,.LC54@ha
	lis 11,.LC48@ha
	fmr 12,1
	xoris 0,0,0x8000
	la 8,.LC54@l(8)
	lfd 11,.LC48@l(11)
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
	bc 4,0,.L337
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 12,0(9)
.L337:
	fdivs 12,12,1
	fmuls 0,9,12
	stfs 0,384(31)
.L334:
	lis 10,.LC51@ha
	lfs 0,384(31)
	la 10,.LC51@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 4,2,.L339
	lfs 0,380(31)
	fcmpu 0,0,13
	bc 4,2,.L339
	lfs 0,376(31)
	fcmpu 0,0,13
	bc 12,2,.L338
.L339:
	bc 4,18,.L341
	lwz 0,264(31)
	andi. 11,0,3
	bc 12,2,.L340
.L341:
	lwz 0,480(31)
	lis 11,0x4330
	lis 8,.LC54@ha
	lis 10,.LC55@ha
	xoris 0,0,0x8000
	la 8,.LC54@l(8)
	stw 0,20(1)
	la 10,.LC55@l(10)
	stw 11,16(1)
	lfd 13,0(8)
	lfd 0,16(1)
	lfd 12,0(10)
	fsub 0,0,13
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L343
	mr 3,31
	bl M_CheckBottom
	cmpwi 0,3,0
	bc 12,2,.L340
.L343:
	lfs 0,4(28)
	lfs 1,376(31)
	fmuls 0,0,0
	fmadds 1,1,1,0
	bl sqrt
	lis 8,.LC51@ha
	frsp 1,1
	la 8,.LC51@l(8)
	lfs 10,0(8)
	fcmpu 0,1,10
	bc 12,2,.L340
	lis 9,.LC53@ha
	fmr 13,1
	la 9,.LC53@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L345
	lis 10,.LC53@ha
	la 10,.LC53@l(10)
	lfs 13,0(10)
.L345:
	lis 9,.LC48@ha
	lis 11,.LC56@ha
	lfd 12,.LC48@l(9)
	la 11,.LC56@l(11)
	fmr 0,1
	lfd 11,0(11)
	fmul 13,13,12
	fmul 13,13,11
	fsub 0,0,13
	frsp 12,0
	fcmpu 0,12,10
	bc 4,0,.L347
	lis 8,.LC51@ha
	la 8,.LC51@l(8)
	lfs 12,0(8)
.L347:
	fdivs 12,12,1
	lfs 0,376(31)
	fmuls 0,0,12
	stfs 0,376(31)
	lfs 13,4(28)
	fmuls 13,13,12
	stfs 13,4(28)
.L340:
	lwz 4,184(31)
	lis 9,.LC46@ha
	lis 0,0x202
	ori 0,0,3
	lfs 1,.LC46@l(9)
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
	bc 12,2,.L298
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L338
	bc 4,18,.L338
	cmpwi 0,27,0
	bc 12,2,.L338
	lwz 9,36(29)
	lis 3,.LC49@ha
	la 3,.LC49@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC57@ha
	lis 9,.LC57@ha
	lis 10,.LC51@ha
	mr 5,3
	la 8,.LC57@l(8)
	la 9,.LC57@l(9)
	mtlr 0
	la 10,.LC51@l(10)
	li 4,0
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L338:
	lis 8,.LC51@ha
	lfs 12,428(31)
	la 8,.LC51@l(8)
	lfs 11,0(8)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L298
	lis 9,level+4@ha
	lis 11,.LC50@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC50@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L298
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
	lwz 0,436(31)
	mr 3,31
	mtlr 0
	blrl
.L298:
	lwz 0,52(1)
	lwz 12,24(1)
	mtlr 0
	lmw 27,28(1)
	mtcrf 8,12
	la 1,48(1)
	blr
.Lfe8:
	.size	 SV_Physics_Step,.Lfe8-SV_Physics_Step
	.section	".rodata"
	.align 2
.LC60:
	.string	"SV_Physics: bad movetype %i"
	.align 3
.LC58:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC59:
	.long 0x3dcccccd
	.align 2
.LC61:
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
	bc 12,2,.L364
	mtlr 0
	blrl
.L364:
	lwz 4,260(31)
	cmplwi 0,4,10
	bc 12,1,.L392
	lis 11,.L393@ha
	slwi 10,4,2
	la 11,.L393@l(11)
	lis 9,.L393@ha
	lwzx 0,10,11
	la 9,.L393@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L393:
	.long .L373-.L393
	.long .L379-.L393
	.long .L372-.L393
	.long .L372-.L393
	.long .L366-.L393
	.long .L386-.L393
	.long .L391-.L393
	.long .L391-.L393
	.long .L391-.L393
	.long .L387-.L393
	.long .L391-.L393
.L366:
	lis 9,.LC61@ha
	lfs 12,428(31)
	la 9,.LC61@l(9)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L365
	lis 9,level+4@ha
	lis 11,.LC58@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC58@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L365
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L370
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L370:
	lwz 0,436(31)
	mr 3,31
	b .L394
.L372:
	mr 3,31
	bl SV_Physics_Pusher
	b .L365
.L373:
	lis 9,.LC61@ha
	lfs 12,428(31)
	la 9,.LC61@l(9)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L365
	lis 9,level+4@ha
	lis 11,.LC58@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC58@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L365
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L377
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L377:
	lwz 0,436(31)
	mr 3,31
	b .L394
.L379:
	lis 9,.LC61@ha
	lfs 12,428(31)
	la 9,.LC61@l(9)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L395
	lis 9,level+4@ha
	lis 11,.LC58@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC58@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 4,1,.L382
.L395:
	li 0,1
	b .L381
.L382:
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L383
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L383:
	lwz 9,436(31)
	mr 3,31
	mtlr 9
	blrl
	li 0,0
.L381:
	cmpwi 0,0,0
	bc 12,2,.L365
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
.L394:
	mtlr 0
	blrl
	b .L365
.L386:
	mr 3,31
	bl SV_Physics_Step
	b .L365
.L387:
	mr 3,31
	bl SV_Physics_Bounce
	b .L365
.L391:
	mr 3,31
	bl SV_Physics_Toss
	b .L365
.L392:
	lis 9,gi+28@ha
	lis 3,.LC60@ha
	lwz 0,gi+28@l(9)
	la 3,.LC60@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L365:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 G_RunEntity,.Lfe9-G_RunEntity
	.align 2
	.globl SV_CheckVelocity
	.type	 SV_CheckVelocity,@function
SV_CheckVelocity:
	li 0,3
	lis 9,sv_maxvelocity@ha
	mtctr 0
	lwz 9,sv_maxvelocity@l(9)
	addi 3,3,376
.L396:
	lfs 13,0(3)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 12,1,.L397
	fneg 0,0
	fcmpu 0,13,0
	bc 4,0,.L16
.L397:
	stfs 0,0(3)
.L16:
	addi 3,3,4
	bdnz .L396
	blr
.Lfe10:
	.size	 SV_CheckVelocity,.Lfe10-SV_CheckVelocity
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
	bc 12,3,.L399
	lis 9,level+4@ha
	lis 11,.LC62@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC62@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 4,1,.L24
.L399:
	li 3,1
	b .L398
.L24:
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L25
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L25:
	lwz 0,436(31)
	mr 3,31
	mtlr 0
	blrl
	li 3,0
.L398:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 SV_RunThink,.Lfe11-SV_RunThink
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
	bc 12,2,.L27
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 12,2,.L27
	lwz 6,44(5)
	mr 4,31
	mtlr 9
	addi 5,5,24
	blrl
.L27:
	lwz 9,444(31)
	cmpwi 0,9,0
	bc 12,2,.L28
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L28
	mr 3,31
	mr 4,30
	mtlr 9
	li 5,0
	li 6,0
	blrl
.L28:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 SV_Impact,.Lfe12-SV_Impact
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
	bc 4,1,.L30
	li 8,1
.L30:
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
.L400:
	lfsx 0,9,4
	lfsx 13,9,3
	fmuls 0,0,1
	fsubs 13,13,0
	fmr 0,13
	stfsx 13,9,5
	fcmpu 0,0,10
	bc 4,1,.L34
	fcmpu 0,0,12
	bc 4,0,.L34
	stwx 7,9,5
.L34:
	addi 9,9,4
	bdnz .L400
	mr 3,8
	blr
.Lfe13:
	.size	 ClipVelocity,.Lfe13-ClipVelocity
	.section	".rodata"
	.align 3
.LC67:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SV_AddGravity
	.type	 SV_AddGravity,@function
SV_AddGravity:
	lis 9,sv_gravity@ha
	lfs 13,408(3)
	lis 10,.LC67@ha
	lwz 11,sv_gravity@l(9)
	lfs 0,384(3)
	lfs 12,20(11)
	lfd 11,.LC67@l(10)
	fmuls 13,13,12
	fmul 13,13,11
	fsub 0,0,13
	frsp 0,0
	stfs 0,384(3)
	blr
.Lfe14:
	.size	 SV_AddGravity,.Lfe14-SV_AddGravity
	.comm	pushed,32768,4
	.comm	pushed_p,4,4
	.comm	obstacle,4,4
	.section	".rodata"
	.align 3
.LC68:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC69:
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
	lis 9,.LC69@ha
	mr 31,3
	la 9,.LC69@l(9)
	lfs 12,428(31)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L184
	lis 9,level+4@ha
	lis 11,.LC68@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC68@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L184
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L186
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L186:
	lwz 0,436(31)
	mr 3,31
	mtlr 0
	blrl
.L184:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe15:
	.size	 SV_Physics_None,.Lfe15-SV_Physics_None
	.section	".rodata"
	.align 3
.LC70:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC71:
	.long 0x3dcccccd
	.align 2
.LC72:
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
	lis 9,.LC72@ha
	mr 31,3
	la 9,.LC72@l(9)
	lfs 12,428(31)
	lfs 11,0(9)
	fcmpu 0,12,11
	cror 3,2,0
	bc 12,3,.L401
	lis 9,level+4@ha
	lis 11,.LC70@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC70@l(11)
	fadd 0,0,13
	fcmpu 0,12,0
	bc 4,1,.L191
.L401:
	li 0,1
	b .L190
.L191:
	lwz 0,436(31)
	stfs 11,428(31)
	cmpwi 0,0,0
	bc 4,2,.L192
	lis 9,gi+28@ha
	lis 3,.LC1@ha
	lwz 0,gi+28@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L192:
	lwz 9,436(31)
	mr 3,31
	mtlr 9
	blrl
	li 0,0
.L190:
	cmpwi 0,0,0
	bc 12,2,.L187
	lis 29,.LC71@ha
	addi 3,31,16
	lfs 1,.LC71@l(29)
	mr 5,3
	addi 4,31,388
	bl VectorMA
	lfs 1,.LC71@l(29)
	addi 3,31,4
	addi 4,31,376
	mr 5,3
	bl VectorMA
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L187:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 SV_Physics_Noclip,.Lfe16-SV_Physics_Noclip
	.section	".rodata"
	.align 2
.LC73:
	.long 0x3dcccccd
	.align 2
.LC74:
	.long 0x42700000
	.align 2
.LC75:
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
	lis 9,.LC73@ha
	mr 29,3
	addi 3,29,16
	lfs 1,.LC73@l(9)
	addi 29,29,388
	mr 5,3
	mr 4,29
	bl VectorMA
	lis 9,.LC74@ha
	li 0,3
	la 9,.LC74@l(9)
	mtctr 0
	lfs 12,0(9)
	lis 9,.LC75@ha
	la 9,.LC75@l(9)
	lfs 13,0(9)
.L402:
	lfs 0,0(29)
	fcmpu 0,0,13
	bc 4,1,.L293
	fsubs 0,0,12
	fcmpu 0,0,13
	stfs 0,0(29)
	bc 4,0,.L291
	b .L403
.L293:
	fadds 0,0,12
	fcmpu 0,0,13
	stfs 0,0(29)
	bc 4,1,.L291
.L403:
	stfs 13,0(29)
.L291:
	addi 29,29,4
	bdnz .L402
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 SV_AddRotationalFriction,.Lfe17-SV_AddRotationalFriction
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
