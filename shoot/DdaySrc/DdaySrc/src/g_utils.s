	.file	"g_utils.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"G_PickTarget called with NULL targetname\n"
	.align 2
.LC1:
	.string	"G_PickTarget: target %s not found\n"
	.section	".text"
	.align 2
	.globl G_PickTarget
	.type	 G_PickTarget,@function
G_PickTarget:
	stwu 1,-80(1)
	mflr 0
	stmw 24,48(1)
	stw 0,84(1)
	mr. 26,3
	li 11,0
	li 29,0
	bc 4,2,.L47
	lis 9,gi+4@ha
	lis 3,.LC0@ha
	lwz 0,gi+4@l(9)
	la 3,.LC0@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L67
.L47:
	cmpwi 7,29,0
	lis 9,globals@ha
	la 24,globals@l(9)
	lis 28,g_edicts@ha
	addi 30,1,8
	lis 25,globals@ha
.L63:
	bc 4,30,.L51
	lwz 31,g_edicts@l(28)
	b .L52
.L66:
	mr 11,31
	b .L60
.L51:
	addi 31,11,1016
.L52:
	lwz 0,72(24)
	lwz 9,g_edicts@l(28)
	mulli 0,0,1016
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L61
	la 27,globals@l(25)
.L55:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L57
	lwz 3,304(31)
	cmpwi 0,3,0
	bc 12,2,.L57
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L66
.L57:
	lwz 9,72(27)
	addi 31,31,1016
	lwz 0,g_edicts@l(28)
	mulli 9,9,1016
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L55
.L61:
	li 11,0
.L60:
	cmpwi 0,11,0
	mcrf 7,0
	bc 12,2,.L49
	cmpwi 0,29,7
	stw 11,0(30)
	addi 30,30,4
	addi 29,29,1
	bc 4,2,.L63
.L49:
	cmpwi 0,29,0
	bc 12,2,.L64
	bl rand
	divw 0,3,29
	addi 9,1,8
	mullw 0,0,29
	subf 3,0,3
	slwi 3,3,2
	lwzx 3,9,3
	b .L65
.L64:
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mr 4,26
	mtlr 0
	crxor 6,6,6
	blrl
.L67:
	li 3,0
.L65:
	lwz 0,84(1)
	mtlr 0
	lmw 24,48(1)
	la 1,80(1)
	blr
.Lfe1:
	.size	 G_PickTarget,.Lfe1-G_PickTarget
	.section	".rodata"
	.align 2
.LC2:
	.string	"DelayedUse"
	.align 2
.LC3:
	.string	"Think_Delay with no activator\n"
	.align 2
.LC4:
	.string	"%s"
	.align 2
.LC5:
	.string	"misc/talk1.wav"
	.align 2
.LC6:
	.string	"entity was removed while using killtargets\n"
	.align 2
.LC7:
	.string	"func_areaportal"
	.align 2
.LC8:
	.string	"func_door"
	.align 2
.LC9:
	.string	"func_door_rotating"
	.align 2
.LC10:
	.string	"WARNING: Entity used itself.\n"
	.align 2
.LC11:
	.string	"entity was removed while using targets\n"
	.align 2
.LC12:
	.long 0x0
	.align 2
.LC13:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl G_UseTargets
	.type	 G_UseTargets,@function
G_UseTargets:
	stwu 1,-48(1)
	mflr 0
	stmw 22,8(1)
	stw 0,52(1)
	lis 9,.LC12@ha
	mr 30,3
	la 9,.LC12@l(9)
	lfs 0,604(30)
	mr 27,4
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L70
	bl G_Spawn
	lis 9,.LC2@ha
	mr 31,3
	la 9,.LC2@l(9)
	lis 11,level+4@ha
	stw 9,284(31)
	cmpwi 0,27,0
	lfs 0,level+4@l(11)
	lis 9,Think_Delay@ha
	lfs 13,604(30)
	la 9,Think_Delay@l(9)
	stw 9,440(31)
	stw 27,556(31)
	fadds 0,0,13
	stfs 0,432(31)
	bc 4,2,.L71
	lis 9,gi+4@ha
	lis 3,.LC3@ha
	lwz 0,gi+4@l(9)
	la 3,.LC3@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L71:
	lwz 0,280(30)
	stw 0,280(31)
	lwz 9,300(30)
	stw 9,300(31)
	lwz 0,308(30)
	stw 0,308(31)
	b .L69
.L70:
	lwz 5,280(30)
	cmpwi 0,5,0
	bc 12,2,.L72
	lwz 0,184(27)
	andi. 9,0,4
	bc 4,2,.L72
	lis 9,gi@ha
	lis 4,.LC4@ha
	la 31,gi@l(9)
	la 4,.LC4@l(4)
	lwz 9,12(31)
	mr 3,27
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 5,584(30)
	cmpwi 0,5,0
	bc 12,2,.L73
	lis 9,.LC13@ha
	lwz 0,16(31)
	mr 3,27
	la 9,.LC13@l(9)
	li 4,0
	lfs 1,0(9)
	mtlr 0
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 2,0(9)
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	lfs 3,0(9)
	blrl
	b .L72
.L73:
	lwz 9,36(31)
	lis 3,.LC5@ha
	la 3,.LC5@l(3)
	mtlr 9
	blrl
	lis 9,.LC13@ha
	lwz 0,16(31)
	mr 5,3
	la 9,.LC13@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,27
	mtlr 0
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 2,0(9)
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	lfs 3,0(9)
	blrl
.L72:
	lwz 0,308(30)
	cmpwi 0,0,0
	bc 12,2,.L75
	lis 24,globals@ha
	lis 9,gi@ha
	la 22,globals@l(24)
	la 23,gi@l(9)
	li 31,0
	lis 26,g_edicts@ha
	lis 24,.LC6@ha
	lis 25,globals@ha
.L76:
	cmpwi 0,31,0
	lwz 29,308(30)
	bc 4,2,.L79
	lwz 31,g_edicts@l(26)
	b .L80
.L79:
	addi 31,31,1016
.L80:
	lwz 0,72(22)
	lwz 9,g_edicts@l(26)
	mulli 0,0,1016
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L89
	la 28,globals@l(25)
.L83:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L85
	lwz 3,304(31)
	cmpwi 0,3,0
	bc 12,2,.L85
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L88
.L85:
	lwz 9,72(28)
	addi 31,31,1016
	lwz 0,g_edicts@l(26)
	mulli 9,9,1016
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L83
.L89:
	li 31,0
.L88:
	cmpwi 0,31,0
	bc 12,2,.L75
	mr 3,31
	bl G_FreeEdict
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 4,2,.L76
	lwz 0,4(23)
	la 3,.LC6@l(24)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L69
.L75:
	lwz 0,300(30)
	cmpwi 0,0,0
	bc 12,2,.L69
	lis 9,gi@ha
	li 31,0
	la 25,gi@l(9)
	lis 26,g_edicts@ha
	lis 24,globals@ha
.L92:
	cmpwi 0,31,0
	lwz 29,300(30)
	bc 4,2,.L95
	lwz 31,g_edicts@l(26)
	b .L96
.L95:
	addi 31,31,1016
.L96:
	la 11,globals@l(24)
	lwz 9,g_edicts@l(26)
	lwz 0,72(11)
	mulli 0,0,1016
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L105
	mr 28,11
.L99:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L101
	lwz 3,304(31)
	cmpwi 0,3,0
	bc 12,2,.L101
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L104
.L101:
	lwz 9,72(28)
	addi 31,31,1016
	lwz 0,g_edicts@l(26)
	mulli 9,9,1016
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L99
.L105:
	li 31,0
.L104:
	cmpwi 0,31,0
	bc 12,2,.L69
	lwz 3,284(31)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L106
	lwz 3,284(30)
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L92
	lwz 3,284(30)
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L92
.L106:
	cmpw 0,31,30
	bc 4,2,.L108
	lwz 9,4(25)
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L109
.L108:
	lwz 0,452(31)
	cmpwi 0,0,0
	bc 12,2,.L109
	mr 3,31
	mr 4,30
	mtlr 0
	mr 5,27
	blrl
.L109:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 4,2,.L92
	lwz 0,4(25)
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L69:
	lwz 0,52(1)
	mtlr 0
	lmw 22,8(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 G_UseTargets,.Lfe2-G_UseTargets
	.section	".sbss","aw",@nobits
	.align 2
index.27:
	.space	4
	.size	 index.27,4
	.lcomm	vecs.28,96,4
	.align 2
index.32:
	.space	4
	.size	 index.32,4
	.lcomm	str.33,256,1
	.section	".rodata"
	.align 2
.LC14:
	.string	"(%i %i %i)"
	.globl VEC_UP
	.section	".data"
	.align 2
	.type	 VEC_UP,@object
	.size	 VEC_UP,12
VEC_UP:
	.long 0x0
	.long 0xbf800000
	.long 0x0
	.globl MOVEDIR_UP
	.align 2
	.type	 MOVEDIR_UP,@object
	.size	 MOVEDIR_UP,12
MOVEDIR_UP:
	.long 0x0
	.long 0x0
	.long 0x3f800000
	.globl VEC_DOWN
	.align 2
	.type	 VEC_DOWN,@object
	.size	 VEC_DOWN,12
VEC_DOWN:
	.long 0x0
	.long 0xc0000000
	.long 0x0
	.globl MOVEDIR_DOWN
	.align 2
	.type	 MOVEDIR_DOWN,@object
	.size	 MOVEDIR_DOWN,12
MOVEDIR_DOWN:
	.long 0x0
	.long 0x0
	.long 0xbf800000
	.section	".rodata"
	.align 3
.LC17:
	.long 0x40668000
	.long 0x0
	.align 3
.LC18:
	.long 0x400921fb
	.long 0x54442d18
	.align 2
.LC19:
	.long 0x0
	.align 2
.LC20:
	.long 0x43870000
	.align 2
.LC21:
	.long 0x42b40000
	.align 3
.LC22:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC23:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl vectoangles
	.type	 vectoangles,@function
vectoangles:
	stwu 1,-80(1)
	mflr 0
	stfd 27,40(1)
	stfd 28,48(1)
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 29,28(1)
	stw 0,84(1)
	lis 9,.LC19@ha
	mr 31,3
	la 9,.LC19@l(9)
	lfs 0,4(31)
	mr 30,4
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L126
	lfs 0,0(31)
	fcmpu 0,0,13
	bc 4,2,.L126
	lis 9,.LC19@ha
	lfs 0,8(31)
	la 9,.LC19@l(9)
	lfs 31,0(9)
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	fcmpu 0,0,31
	lfs 13,0(9)
	bc 4,1,.L129
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 13,0(9)
	b .L129
.L126:
	lfs 1,4(31)
	lis 9,.LC22@ha
	lis 29,0x4330
	lfs 2,0(31)
	la 9,.LC22@l(9)
	lfd 28,0(9)
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfs 27,0(9)
	bl atan2
	lis 11,.LC17@ha
	lis 10,.LC18@ha
	lfd 30,.LC17@l(11)
	lfd 29,.LC18@l(10)
	mr 11,9
	fmul 1,1,30
	fdiv 1,1,29
	fctiwz 0,1
	stfd 0,16(1)
	lwz 9,20(1)
	xoris 9,9,0x8000
	stw 9,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	fsub 0,0,28
	frsp 31,0
	fcmpu 0,31,27
	bc 4,0,.L130
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fadds 31,31,0
.L130:
	lfs 0,4(31)
	lfs 1,0(31)
	fmuls 0,0,0
	fmadds 1,1,1,0
	bl sqrt
	frsp 2,1
	lfs 1,8(31)
	bl atan2
	fmul 1,1,30
	mr 11,9
	fdiv 1,1,29
	fctiwz 0,1
	stfd 0,16(1)
	lwz 9,20(1)
	xoris 9,9,0x8000
	stw 9,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	fsub 0,0,28
	frsp 13,0
	fcmpu 0,13,27
	bc 4,0,.L129
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fadds 13,13,0
.L129:
	fneg 0,13
	li 0,0
	stfs 31,4(30)
	stw 0,8(30)
	stfs 0,0(30)
	lwz 0,84(1)
	mtlr 0
	lmw 29,28(1)
	lfd 27,40(1)
	lfd 28,48(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe3:
	.size	 vectoangles,.Lfe3-vectoangles
	.section	".rodata"
	.align 2
.LC24:
	.string	"noclass"
	.align 2
.LC25:
	.string	"ED_Alloc: no free edicts"
	.align 2
.LC26:
	.long 0x3f800000
	.align 2
.LC27:
	.long 0x40000000
	.align 3
.LC28:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl G_Spawn
	.type	 G_Spawn,@function
G_Spawn:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 11,maxclients@ha
	lis 7,.LC26@ha
	lwz 10,maxclients@l(11)
	la 7,.LC26@l(7)
	lfs 13,0(7)
	lis 8,g_edicts@ha
	lis 11,globals@ha
	lfs 0,20(10)
	mr 7,9
	la 6,globals@l(11)
	lwz 10,g_edicts@l(8)
	lwz 0,72(6)
	fadds 13,0,13
	fctiwz 12,0
	fctiwz 11,13
	stfd 12,16(1)
	lwz 9,20(1)
	stfd 11,16(1)
	lwz 8,20(1)
	mulli 9,9,1016
	cmpw 0,8,0
	addi 9,9,1016
	add 31,10,9
	bc 4,0,.L136
	lis 7,.LC27@ha
	lis 11,0xefdf
	la 7,.LC27@l(7)
	lis 0,0x1020
	lfs 11,0(7)
	ori 11,11,49023
	ori 0,0,16513
	lis 7,.LC28@ha
	mullw 0,10,0
	lis 9,.LC24@ha
	la 7,.LC28@l(7)
	mullw 11,31,11
	lis 10,level@ha
	lfd 12,0(7)
	la 9,.LC24@l(9)
	la 10,level@l(10)
	add 11,11,0
	li 7,1
	lis 5,0x3f80
.L138:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L137
	lfs 13,276(31)
	fcmpu 0,13,11
	bc 12,0,.L140
	lfs 0,4(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L137
.L140:
	srawi 0,11,3
	stw 7,88(31)
	mr 3,31
	stw 9,284(31)
	stw 5,412(31)
	b .L146
.L137:
	lwz 0,72(6)
	addi 8,8,1
	addi 11,11,8
	addi 31,31,1016
	cmpw 0,8,0
	bc 12,0,.L138
.L136:
	lis 9,game+1548@ha
	lwz 0,game+1548@l(9)
	cmpw 0,8,0
	bc 4,2,.L143
	lis 9,gi+28@ha
	lis 3,.LC25@ha
	lwz 0,gi+28@l(9)
	la 3,.LC25@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L143:
	lis 9,g_edicts@ha
	lis 10,globals@ha
	lwz 0,g_edicts@l(9)
	la 10,globals@l(10)
	lis 8,.LC24@ha
	lis 9,0xefdf
	lwz 11,72(10)
	la 8,.LC24@l(8)
	ori 9,9,49023
	subf 0,0,31
	mullw 0,0,9
	addi 11,11,1
	lis 7,0x3f80
	stw 11,72(10)
	li 9,1
	mr 3,31
	srawi 0,0,3
	stw 9,88(31)
	stw 8,284(31)
	stw 7,412(31)
.L146:
	stw 0,0(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 G_Spawn,.Lfe4-G_Spawn
	.section	".rodata"
	.align 2
.LC29:
	.string	"freed"
	.align 3
.LC30:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC31:
	.long 0x3fdccccc
	.long 0xcccccccd
	.align 3
.LC32:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 3
.LC33:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC34:
	.long 0x0
	.align 3
.LC35:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC36:
	.long 0x3fe80000
	.long 0x0
	.align 3
.LC37:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl WeighPlayer
	.type	 WeighPlayer,@function
WeighPlayer:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC34@ha
	mr. 3,3
	la 9,.LC34@l(9)
	lfs 10,0(9)
	bc 12,2,.L183
	lwz 10,84(3)
	cmpwi 0,10,0
	bc 12,2,.L183
	lwz 0,184(10)
	cmpwi 0,0,998
	bc 12,1,.L183
	lwz 11,3448(10)
	cmpwi 0,11,0
	bc 12,2,.L183
	lwz 9,3464(10)
	cmpwi 0,9,0
	bc 12,2,.L183
	lwz 0,4396(10)
	cmpwi 0,0,0
	bc 4,2,.L183
	lwz 11,96(11)
	slwi 9,9,2
	lwzx 9,9,11
	cmpwi 0,9,0
	bc 4,2,.L182
.L183:
	li 3,0
	b .L202
.L182:
	lfs 0,56(9)
	lis 11,.LC35@ha
	li 0,256
	lis 9,itemlist@ha
	la 11,.LC35@l(11)
	mtctr 0
	la 9,itemlist@l(9)
	lfd 11,0(11)
	lis 5,0x4330
	stfs 0,4508(10)
	addi 6,9,76
	lwz 9,84(3)
	lwz 8,3448(9)
	addi 7,9,740
	lwz 11,3464(9)
	lwz 10,96(8)
	slwi 11,11,2
	lwzx 9,11,10
	lfs 12,48(9)
.L203:
	lwz 0,0(7)
	addi 7,7,4
	cmpwi 0,0,0
	bc 12,2,.L186
	xoris 0,0,0x8000
	lfs 13,0(6)
	stw 0,12(1)
	stw 5,8(1)
	lfd 0,8(1)
	fsub 0,0,11
	frsp 0,0
	fmadds 10,13,0,10
.L186:
	addi 6,6,104
	bdnz .L203
	fsubs 10,10,12
	lwz 9,84(3)
	lfs 13,4508(9)
	fcmpu 0,10,12
	bc 4,1,.L190
	fdivs 0,12,10
	b .L204
.L190:
	fdivs 0,12,12
.L204:
	fmuls 0,13,0
	stfs 0,4508(9)
	lwz 0,672(3)
	cmpwi 0,0,2
	bc 4,2,.L192
	lwz 11,84(3)
	lis 9,.LC30@ha
	lfd 13,.LC30@l(9)
	lfs 0,4508(11)
	fmul 0,0,13
	frsp 0,0
	stfs 0,4508(11)
.L192:
	lwz 0,672(3)
	cmpwi 0,0,4
	bc 4,2,.L193
	lwz 11,84(3)
	lis 9,.LC31@ha
	lfd 13,.LC31@l(9)
	lfs 0,4508(11)
	fmul 0,0,13
	frsp 0,0
	stfs 0,4508(11)
.L193:
	lwz 0,688(3)
	andi. 9,0,1
	bc 12,2,.L194
	lwz 9,84(3)
	lis 11,.LC36@ha
	la 11,.LC36@l(11)
	lfs 0,4508(9)
	lfd 13,0(11)
	fmul 0,0,13
	frsp 0,0
	stfs 0,4508(9)
.L194:
	lwz 0,620(3)
	cmpwi 0,0,0
	bc 12,2,.L195
	cmpwi 0,0,1
	bc 4,2,.L196
	lwz 11,84(3)
	lis 9,.LC32@ha
	lfd 13,.LC32@l(9)
	b .L205
.L196:
	cmpwi 0,0,2
	bc 4,2,.L198
	lwz 11,84(3)
	lis 9,.LC33@ha
	lfd 13,.LC33@l(9)
	b .L205
.L198:
	cmpwi 0,0,3
	bc 4,2,.L195
	lwz 11,84(3)
	lis 9,.LC31@ha
	lfd 13,.LC31@l(9)
.L205:
	lfs 0,4508(11)
	fmul 0,0,13
	frsp 0,0
	stfs 0,4508(11)
.L195:
	lwz 8,84(3)
	lwz 11,3448(8)
	lwz 9,3464(8)
	lwz 10,96(11)
	slwi 9,9,2
	lwzx 11,9,10
	lfs 0,52(11)
	fcmpu 0,10,0
	bc 12,1,.L201
	li 4,1
	bl ClientSetMaxSpeed
	li 3,1
	b .L202
.L201:
	lfs 0,4508(8)
	lis 9,.LC37@ha
	li 3,0
	la 9,.LC37@l(9)
	lfd 13,0(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,4508(8)
.L202:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe5:
	.size	 WeighPlayer,.Lfe5-WeighPlayer
	.section	".rodata"
	.align 2
.LC38:
	.string	"centerprintall: overflow of %i in %i\n"
	.section	".text"
	.align 2
	.globl centerprintall
	.type	 centerprintall,@function
centerprintall:
	mr 12,1
	lis 0,0xfffd
	ori 0,0,65360
	stwux 1,1,0
	mflr 0
	stmw 26,-24(12)
	stw 0,4(12)
	lis 11,0x2
	lis 0,0x2
	ori 11,11,184
	ori 0,0,112
	add 29,1,11
	add 12,1,0
	lis 30,0x100
	addi 11,1,8
	stw 29,20(12)
	stw 11,24(12)
	stw 30,16(12)
	stw 4,12(1)
	stw 5,16(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	bc 4,6,.L207
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L207:
	addi 11,12,16
	addi 9,1,112
	lwz 10,8(11)
	mr 4,3
	addi 31,1,128
	lwz 0,4(11)
	mr 5,9
	mr 3,31
	stw 30,112(1)
	lis 29,0x1
	stw 0,4(9)
	stw 10,8(9)
	bl vsprintf
	mr 4,3
	cmpw 0,4,29
	bc 12,0,.L208
	lis 3,.LC38@ha
	lis 5,0x1
	la 3,.LC38@l(3)
	crxor 6,6,6
	bl Com_Printf
.L208:
	lis 0,0x1
	mr 4,31
	ori 0,0,112
	li 5,0
	add 31,1,0
	ori 5,5,65535
	addi 3,31,16
	li 29,1
	bl strncpy
	lis 9,game@ha
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,29,0
	bc 12,1,.L210
	lis 9,gi@ha
	mr 30,31
	la 26,gi@l(9)
	mr 27,11
	lis 28,g_edicts@ha
	li 31,1016
.L212:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L211
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L211
	lwz 9,12(26)
	addi 4,30,16
	mtlr 9
	crxor 6,6,6
	blrl
.L211:
	lwz 0,1544(27)
	addi 29,29,1
	addi 31,31,1016
	cmpw 0,29,0
	bc 4,1,.L212
.L210:
	lwz 11,0(1)
	lwz 0,4(11)
	mtlr 0
	lmw 26,-24(11)
	mr 1,11
	blr
.Lfe6:
	.size	 centerprintall,.Lfe6-centerprintall
	.comm	is_silenced,1,1
	.align 2
	.globl OnSameTeam
	.type	 OnSameTeam,@function
OnSameTeam:
	subfic 0,3,0
	adde 9,0,3
	subfic 11,4,0
	adde 0,11,4
	or. 11,9,0
	bc 4,2,.L178
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L178
	lwz 4,84(4)
	cmpwi 0,4,0
	bc 12,2,.L178
	lwz 11,3448(3)
	cmpwi 0,11,0
	bc 12,2,.L178
	lwz 9,3448(4)
	cmpwi 0,9,0
	bc 12,2,.L178
	lwz 0,3464(3)
	cmpwi 0,0,0
	bc 12,2,.L178
	lwz 0,3464(4)
	cmpwi 0,0,0
	bc 4,2,.L177
.L178:
	li 3,0
	blr
.L177:
	lwz 0,84(11)
	lwz 3,84(9)
	xor 3,0,3
	subfic 9,3,0
	adde 3,9,3
	blr
.Lfe7:
	.size	 OnSameTeam,.Lfe7-OnSameTeam
	.align 2
	.globl KillBox
	.type	 KillBox,@function
KillBox:
	stwu 1,-96(1)
	mflr 0
	stmw 30,88(1)
	stw 0,100(1)
	mr 30,3
	b .L172
.L173:
	lis 6,vec3_origin@ha
	li 0,32
	la 6,vec3_origin@l(6)
	li 11,21
	stw 0,8(1)
	lis 9,0x1
	stw 11,12(1)
	mr 7,31
	ori 9,9,34464
	mr 4,30
	mr 5,30
	mr 8,6
	li 10,0
	bl T_Damage
	lwz 9,68(1)
	lwz 0,248(9)
	cmpwi 0,0,0
	bc 12,2,.L172
	li 3,0
	b .L220
.L172:
	lis 11,gi+48@ha
	addi 31,30,4
	lwz 0,gi+48@l(11)
	lis 9,0x201
	addi 3,1,16
	mr 4,31
	addi 5,30,188
	addi 6,30,200
	mr 7,31
	mtlr 0
	li 8,0
	ori 9,9,3
	blrl
	lwz 3,68(1)
	cmpwi 0,3,0
	bc 4,2,.L173
	li 3,1
.L220:
	lwz 0,100(1)
	mtlr 0
	lmw 30,88(1)
	la 1,96(1)
	blr
.Lfe8:
	.size	 KillBox,.Lfe8-KillBox
	.align 2
	.globl G_ProjectSource
	.type	 G_ProjectSource,@function
G_ProjectSource:
	lfs 10,0(4)
	lfs 11,0(3)
	lfs 12,0(5)
	lfs 13,4(4)
	lfs 0,0(6)
	fmadds 12,12,10,11
	fmadds 0,0,13,12
	stfs 0,0(7)
	lfs 10,0(4)
	lfs 11,4(3)
	lfs 12,4(5)
	lfs 13,4(4)
	lfs 0,4(6)
	fmadds 12,12,10,11
	fmadds 0,0,13,12
	stfs 0,4(7)
	lfs 12,0(4)
	lfs 13,8(5)
	lfs 10,8(3)
	lfs 0,8(6)
	lfs 11,4(4)
	fmadds 13,13,12,10
	lfs 12,8(4)
	fmadds 0,0,11,13
	fadds 0,0,12
	stfs 0,8(7)
	blr
.Lfe9:
	.size	 G_ProjectSource,.Lfe9-G_ProjectSource
	.align 2
	.globl G_Find
	.type	 G_Find,@function
G_Find:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr. 31,3
	mr 29,4
	mr 30,5
	bc 4,2,.L8
	lis 9,g_edicts@ha
	lis 27,g_edicts@ha
	lwz 31,g_edicts@l(9)
	b .L9
.L222:
	mr 3,31
	b .L221
.L8:
	addi 31,31,1016
	lis 27,g_edicts@ha
.L9:
	lis 11,globals@ha
	lis 10,g_edicts@ha
	la 11,globals@l(11)
	lwz 9,g_edicts@l(10)
	lwz 0,72(11)
	mulli 0,0,1016
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L11
	mr 28,11
.L13:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L12
	lwzx 3,31,29
	cmpwi 0,3,0
	bc 12,2,.L12
	mr 4,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L222
.L12:
	lwz 9,72(28)
	addi 31,31,1016
	lwz 0,g_edicts@l(27)
	mulli 9,9,1016
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L13
.L11:
	li 3,0
.L221:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 G_Find,.Lfe10-G_Find
	.align 2
	.globl G_Find_Team
	.type	 G_Find_Team,@function
G_Find_Team:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr. 31,3
	mr 28,4
	mr 29,5
	mr 30,6
	bc 4,2,.L19
	lis 9,g_edicts@ha
	lis 26,g_edicts@ha
	lwz 31,g_edicts@l(9)
	b .L20
.L224:
	mr 3,31
	b .L223
.L19:
	addi 31,31,1016
	lis 26,g_edicts@ha
.L20:
	lis 11,globals@ha
	lis 10,g_edicts@ha
	la 11,globals@l(11)
	lwz 9,g_edicts@l(10)
	lwz 0,72(11)
	mulli 0,0,1016
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L22
	mr 27,11
.L24:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L23
	lwzx 3,31,28
	cmpwi 0,3,0
	bc 12,2,.L23
	lwz 0,952(31)
	cmpw 0,0,30
	bc 4,2,.L23
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L224
.L23:
	lwz 9,72(27)
	addi 31,31,1016
	lwz 0,g_edicts@l(26)
	mulli 9,9,1016
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L24
.L22:
	li 3,0
.L223:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 G_Find_Team,.Lfe11-G_Find_Team
	.section	".rodata"
	.align 3
.LC39:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl findradius
	.type	 findradius,@function
findradius:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	mr. 30,3
	mr 27,4
	fmr 31,1
	bc 4,2,.L31
	lis 9,g_edicts@ha
	lis 26,g_edicts@ha
	lwz 30,g_edicts@l(9)
	b .L32
.L226:
	mr 3,30
	b .L225
.L31:
	addi 30,30,1016
	lis 26,g_edicts@ha
.L32:
	lis 11,globals@ha
	lis 10,g_edicts@ha
	la 11,globals@l(11)
	lwz 9,g_edicts@l(10)
	lwz 0,72(11)
	mulli 0,0,1016
	add 9,9,0
	cmplw 0,30,9
	bc 4,0,.L34
	mr 25,11
	addi 28,30,188
	addi 31,30,4
	addi 29,30,200
.L36:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L35
	lwz 0,244(31)
	cmpwi 0,0,0
	bc 12,2,.L35
	li 0,3
	lis 9,.LC39@ha
	mtctr 0
	la 9,.LC39@l(9)
	mr 7,31
	lfd 10,0(9)
	mr 8,28
	mr 10,29
	addi 11,1,8
	li 9,0
.L227:
	lfsx 13,9,8
	lfsx 11,9,10
	lfsx 12,9,7
	lfsx 0,9,27
	fadds 13,13,11
	fmadd 13,13,10,12
	fsub 0,0,13
	frsp 0,0
	stfsx 0,9,11
	addi 9,9,4
	bdnz .L227
	addi 3,1,8
	bl VectorLength
	fcmpu 0,1,31
	bc 4,1,.L226
.L35:
	lwz 9,72(25)
	addi 30,30,1016
	addi 28,28,1016
	lwz 0,g_edicts@l(26)
	addi 31,31,1016
	addi 29,29,1016
	mulli 9,9,1016
	add 0,0,9
	cmplw 0,30,0
	bc 12,0,.L36
.L34:
	li 3,0
.L225:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe12:
	.size	 findradius,.Lfe12-findradius
	.align 2
	.globl G_SetMovedir
	.type	 G_SetMovedir,@function
G_SetMovedir:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,4
	mr 30,3
	lis 4,VEC_UP@ha
	la 4,VEC_UP@l(4)
	bl VectorCompare
	cmpwi 0,3,0
	bc 12,2,.L117
	lis 9,MOVEDIR_UP@ha
	lfs 13,MOVEDIR_UP@l(9)
	la 9,MOVEDIR_UP@l(9)
	b .L228
.L117:
	lis 4,VEC_DOWN@ha
	mr 3,30
	la 4,VEC_DOWN@l(4)
	bl VectorCompare
	cmpwi 0,3,0
	bc 12,2,.L119
	lis 9,MOVEDIR_DOWN@ha
	lfs 13,MOVEDIR_DOWN@l(9)
	la 9,MOVEDIR_DOWN@l(9)
.L228:
	stfs 13,0(31)
	lfs 0,4(9)
	stfs 0,4(31)
	lfs 13,8(9)
	stfs 13,8(31)
	b .L118
.L119:
	mr 4,31
	mr 3,30
	li 5,0
	li 6,0
	bl AngleVectors
.L118:
	li 0,0
	stw 0,0(30)
	stw 0,8(30)
	stw 0,4(30)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe13:
	.size	 G_SetMovedir,.Lfe13-G_SetMovedir
	.align 2
	.globl G_InitEdict
	.type	 G_InitEdict,@function
G_InitEdict:
	lis 9,g_edicts@ha
	lis 11,0xefdf
	lwz 0,g_edicts@l(9)
	ori 11,11,49023
	li 10,1
	lis 9,.LC24@ha
	stw 10,88(3)
	subf 0,0,3
	la 9,.LC24@l(9)
	mullw 0,0,11
	stw 9,284(3)
	lis 9,0x3f80
	srawi 0,0,3
	stw 9,412(3)
	stw 0,0(3)
	blr
.Lfe14:
	.size	 G_InitEdict,.Lfe14-G_InitEdict
	.section	".rodata"
	.align 3
.LC40:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC41:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl G_FreeEdict
	.type	 G_FreeEdict,@function
G_FreeEdict:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,gi+76@ha
	mr 31,3
	lwz 0,gi+76@l(9)
	mtlr 0
	blrl
	lis 9,g_edicts@ha
	lis 11,0xefdf
	lwz 0,g_edicts@l(9)
	ori 11,11,49023
	lis 9,maxclients@ha
	lis 7,0x4330
	lwz 8,maxclients@l(9)
	subf 0,0,31
	lis 9,.LC40@ha
	mullw 0,0,11
	la 9,.LC40@l(9)
	lfs 13,20(8)
	lfd 12,0(9)
	srawi 0,0,3
	lis 9,.LC41@ha
	xoris 0,0,0x8000
	la 9,.LC41@l(9)
	stw 0,20(1)
	lfs 0,0(9)
	stw 7,16(1)
	fadds 13,13,0
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L147
	mr 3,31
	li 4,0
	li 5,1016
	crxor 6,6,6
	bl memset
	lis 9,.LC29@ha
	lis 11,level+4@ha
	la 9,.LC29@l(9)
	li 0,0
	stw 9,284(31)
	lfs 0,level+4@l(11)
	stw 0,88(31)
	stfs 0,276(31)
.L147:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 G_FreeEdict,.Lfe15-G_FreeEdict
	.align 2
	.globl G_TouchTriggers
	.type	 G_TouchTriggers,@function
G_TouchTriggers:
	stwu 1,-4128(1)
	mflr 0
	stmw 29,4116(1)
	stw 0,4132(1)
	mr 30,3
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 4,2,.L151
	lwz 0,184(30)
	andi. 9,0,4
	bc 12,2,.L150
.L151:
	lwz 0,484(30)
	cmpwi 0,0,0
	bc 4,1,.L149
.L150:
	lis 9,gi+80@ha
	addi 3,30,212
	lwz 0,gi+80@l(9)
	addi 4,30,224
	addi 5,1,8
	li 6,1024
	li 7,2
	mtlr 0
	blrl
	mr. 0,3
	mtctr 0
	bc 4,1,.L149
	mfctr 31
	addi 29,1,8
.L155:
	lwz 3,0(29)
	addi 29,29,4
	cmpwi 0,3,0
	bc 12,2,.L154
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L154
	lwz 0,448(3)
	cmpwi 0,0,0
	bc 12,2,.L154
	mr 4,30
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L154:
	addic. 31,31,-1
	bc 4,2,.L155
.L149:
	lwz 0,4132(1)
	mtlr 0
	lmw 29,4116(1)
	la 1,4128(1)
	blr
.Lfe16:
	.size	 G_TouchTriggers,.Lfe16-G_TouchTriggers
	.align 2
	.globl G_TouchSolids
	.type	 G_TouchSolids,@function
G_TouchSolids:
	stwu 1,-4128(1)
	mflr 0
	stmw 28,4112(1)
	stw 0,4132(1)
	lis 9,gi+80@ha
	mr 31,3
	lwz 0,gi+80@l(9)
	addi 5,1,8
	addi 3,31,212
	addi 4,31,224
	li 6,1024
	li 7,1
	mtlr 0
	mr 30,5
	li 29,0
	blrl
	mr 28,3
	b .L161
.L163:
	addi 30,30,4
	addi 29,29,1
.L161:
	cmpw 0,29,28
	bc 4,0,.L162
	lwz 3,0(30)
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L163
	lwz 0,448(31)
	cmpwi 0,0,0
	bc 12,2,.L166
	mr 4,31
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L166:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L163
.L162:
	lwz 0,4132(1)
	mtlr 0
	lmw 28,4112(1)
	la 1,4128(1)
	blr
.Lfe17:
	.size	 G_TouchSolids,.Lfe17-G_TouchSolids
	.align 2
	.globl G_CopyString
	.type	 G_CopyString,@function
G_CopyString:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	lis 28,gi@ha
	la 28,gi@l(28)
	bl strlen
	lwz 0,132(28)
	li 4,766
	addi 3,3,1
	mtlr 0
	blrl
	mr 28,3
	mr 4,29
	bl strcpy
	mr 3,28
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 G_CopyString,.Lfe18-G_CopyString
	.align 2
	.globl tv
	.type	 tv,@function
tv:
	lis 8,index.27@ha
	lis 10,vecs.28@ha
	lwz 9,index.27@l(8)
	la 10,vecs.28@l(10)
	mulli 11,9,12
	addi 9,9,1
	stfsx 1,11,10
	rlwinm 9,9,0,29,31
	add 11,11,10
	stw 9,index.27@l(8)
	mr 3,11
	stfs 2,4(11)
	stfs 3,8(11)
	blr
.Lfe19:
	.size	 tv,.Lfe19-tv
	.align 2
	.globl vtos
	.type	 vtos,@function
vtos:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 10,index.32@ha
	mr 11,3
	lwz 29,index.32@l(10)
	lis 9,str.33@ha
	mr 7,6
	mr 8,6
	addi 0,29,1
	la 9,str.33@l(9)
	rlwinm 0,0,0,29,31
	slwi 29,29,5
	stw 0,index.32@l(10)
	add 29,29,9
	lis 5,.LC14@ha
	lfs 12,0(11)
	mr 3,29
	la 5,.LC14@l(5)
	lfs 13,4(11)
	li 4,32
	lfs 0,8(11)
	fctiwz 11,12
	fctiwz 10,13
	fctiwz 9,0
	stfd 11,24(1)
	lwz 6,28(1)
	stfd 10,24(1)
	lwz 7,28(1)
	stfd 9,24(1)
	lwz 8,28(1)
	crxor 6,6,6
	bl Com_sprintf
	mr 3,29
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 vtos,.Lfe20-vtos
	.section	".rodata"
	.align 3
.LC42:
	.long 0x40668000
	.long 0x0
	.align 3
.LC43:
	.long 0x400921fb
	.long 0x54442d18
	.align 2
.LC44:
	.long 0x0
	.align 3
.LC45:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC46:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl vectoyaw
	.type	 vectoyaw,@function
vectoyaw:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC44@ha
	lfs 0,4(3)
	la 9,.LC44@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L122
	lfs 0,0(3)
	fcmpu 0,0,13
	bc 4,2,.L122
	lis 10,.LC44@ha
	la 10,.LC44@l(10)
	lfs 1,0(10)
	b .L123
.L122:
	lfs 2,0(3)
	lfs 1,4(3)
	bl atan2
	lis 11,.LC42@ha
	lis 10,.LC43@ha
	lfd 12,.LC42@l(11)
	lis 0,0x4330
	lfd 13,.LC43@l(10)
	mr 11,9
	lis 10,.LC45@ha
	fmul 1,1,12
	la 10,.LC45@l(10)
	lfd 11,0(10)
	lis 10,.LC44@ha
	fdiv 1,1,13
	la 10,.LC44@l(10)
	lfs 10,0(10)
	fctiwz 0,1
	stfd 0,8(1)
	lwz 9,12(1)
	xoris 9,9,0x8000
	stw 9,12(1)
	stw 0,8(1)
	lfd 0,8(1)
	fsub 0,0,11
	frsp 1,0
	fcmpu 0,1,10
	bc 4,0,.L123
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 0,0(9)
	fadds 1,1,0
.L123:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 vectoyaw,.Lfe21-vectoyaw
	.align 2
	.globl IsValidPlayer
	.type	 IsValidPlayer,@function
IsValidPlayer:
	mr. 3,3
	bc 12,2,.L217
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L217
	lwz 0,3448(3)
	cmpwi 0,0,0
	bc 12,2,.L217
	lwz 0,3464(3)
	li 3,1
	cmpwi 0,0,0
	bclr 4,2
.L217:
	li 3,0
	blr
.Lfe22:
	.size	 IsValidPlayer,.Lfe22-IsValidPlayer
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.align 2
	.globl Think_Delay
	.type	 Think_Delay,@function
Think_Delay:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 4,556(29)
	bl G_UseTargets
	mr 3,29
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 Think_Delay,.Lfe23-Think_Delay
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
