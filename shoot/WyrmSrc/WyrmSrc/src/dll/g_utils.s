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
	bc 4,2,.L36
	lis 9,gi+4@ha
	lis 3,.LC0@ha
	lwz 0,gi+4@l(9)
	la 3,.LC0@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L56
.L36:
	cmpwi 7,29,0
	lis 9,globals@ha
	la 24,globals@l(9)
	lis 28,g_edicts@ha
	addi 30,1,8
	lis 25,globals@ha
.L52:
	bc 4,30,.L40
	lwz 31,g_edicts@l(28)
	b .L41
.L55:
	mr 11,31
	b .L49
.L40:
	addi 31,11,1160
.L41:
	lwz 0,72(24)
	lwz 9,g_edicts@l(28)
	mulli 0,0,1160
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L50
	la 27,globals@l(25)
.L44:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L46
	lwz 3,300(31)
	cmpwi 0,3,0
	bc 12,2,.L46
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L55
.L46:
	lwz 9,72(27)
	addi 31,31,1160
	lwz 0,g_edicts@l(28)
	mulli 9,9,1160
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L44
.L50:
	li 11,0
.L49:
	cmpwi 0,11,0
	mcrf 7,0
	bc 12,2,.L38
	cmpwi 0,29,7
	stw 11,0(30)
	addi 30,30,4
	addi 29,29,1
	bc 4,2,.L52
.L38:
	cmpwi 0,29,0
	bc 12,2,.L53
	bl rand
	divw 0,3,29
	addi 9,1,8
	mullw 0,0,29
	subf 3,0,3
	slwi 3,3,2
	lwzx 3,9,3
	b .L54
.L53:
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mr 4,26
	mtlr 0
	crxor 6,6,6
	blrl
.L56:
	li 3,0
.L54:
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
	stmw 23,12(1)
	stw 0,52(1)
	lis 9,.LC12@ha
	mr 30,3
	la 9,.LC12@l(9)
	lfs 0,596(30)
	mr 27,4
	lfs 13,0(9)
	li 26,0
	fcmpu 0,0,13
	bc 12,2,.L59
	bl G_Spawn
	lis 9,.LC2@ha
	mr 31,3
	la 9,.LC2@l(9)
	lis 11,level+4@ha
	stw 9,280(31)
	cmpwi 0,27,0
	lfs 0,level+4@l(11)
	lis 9,Think_Delay@ha
	lfs 13,596(30)
	la 9,Think_Delay@l(9)
	stw 9,436(31)
	stw 27,548(31)
	fadds 0,0,13
	stfs 0,428(31)
	bc 4,2,.L60
	lis 9,gi+4@ha
	lis 3,.LC3@ha
	lwz 0,gi+4@l(9)
	la 3,.LC3@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L60:
	lwz 0,276(30)
	stw 0,276(31)
	lwz 9,296(30)
	stw 9,296(31)
	lwz 0,304(30)
	stw 0,304(31)
	b .L58
.L59:
	lwz 5,276(30)
	cmpwi 0,5,0
	bc 12,2,.L61
	lwz 0,184(27)
	andi. 9,0,4
	bc 4,2,.L61
	lis 9,gi@ha
	lis 4,.LC4@ha
	la 31,gi@l(9)
	la 4,.LC4@l(4)
	lwz 9,12(31)
	mr 3,27
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 5,576(30)
	cmpwi 0,5,0
	bc 12,2,.L62
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
	b .L61
.L62:
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
.L61:
	lwz 0,304(30)
	cmpwi 0,0,0
	bc 12,2,.L64
	lis 24,globals@ha
	lis 9,gi@ha
	la 23,gi@l(9)
	la 24,globals@l(24)
	li 31,0
	lis 25,g_edicts@ha
.L65:
	cmpwi 0,31,0
	lwz 29,304(30)
	bc 4,2,.L68
	lwz 31,g_edicts@l(25)
	b .L69
.L68:
	addi 31,31,1160
.L69:
	lwz 0,72(24)
	lwz 9,g_edicts@l(25)
	mulli 0,0,1160
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L78
	lis 9,globals@ha
	la 28,globals@l(9)
.L72:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L74
	lwz 3,300(31)
	cmpwi 0,3,0
	bc 12,2,.L74
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L77
.L74:
	lwz 9,72(28)
	addi 31,31,1160
	lwz 0,g_edicts@l(25)
	mulli 9,9,1160
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L72
.L78:
	li 31,0
.L77:
	cmpwi 0,31,0
	bc 12,2,.L64
	lwz 0,264(31)
	andi. 9,0,1024
	bc 12,2,.L79
	lwz 0,564(31)
	cmpwi 0,0,0
	bc 12,2,.L79
	cmpwi 0,26,0
	mr 9,0
	bc 4,2,.L79
.L83:
	lwz 0,560(9)
	cmpw 0,0,31
	bc 4,2,.L84
	lwz 0,560(31)
	li 26,1
	stw 0,560(9)
.L84:
	cmpwi 0,26,0
	lwz 9,560(9)
	bc 12,2,.L83
.L79:
	mr 3,31
	bl G_FreeEdict
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 4,2,.L65
	lwz 0,4(23)
	lis 3,.LC6@ha
	la 3,.LC6@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L58
.L64:
	lwz 0,296(30)
	cmpwi 0,0,0
	bc 12,2,.L58
	lis 9,gi@ha
	li 31,0
	la 26,gi@l(9)
	lis 25,g_edicts@ha
	lis 24,globals@ha
.L90:
	cmpwi 0,31,0
	lwz 29,296(30)
	bc 4,2,.L93
	lwz 31,g_edicts@l(25)
	b .L94
.L93:
	addi 31,31,1160
.L94:
	la 11,globals@l(24)
	lwz 9,g_edicts@l(25)
	lwz 0,72(11)
	mulli 0,0,1160
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L103
	mr 28,11
.L97:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L99
	lwz 3,300(31)
	cmpwi 0,3,0
	bc 12,2,.L99
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L102
.L99:
	lwz 9,72(28)
	addi 31,31,1160
	lwz 0,g_edicts@l(25)
	mulli 9,9,1160
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L97
.L103:
	li 31,0
.L102:
	cmpwi 0,31,0
	bc 12,2,.L58
	lwz 3,280(31)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L104
	lwz 3,280(30)
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L90
	lwz 3,280(30)
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L90
.L104:
	cmpw 0,31,30
	bc 4,2,.L106
	lwz 9,4(26)
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L107
.L106:
	lwz 0,448(31)
	cmpwi 0,0,0
	bc 12,2,.L107
	mr 3,31
	mr 4,30
	mtlr 0
	mr 5,27
	blrl
.L107:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 4,2,.L90
	lwz 0,4(26)
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L58:
	lwz 0,52(1)
	mtlr 0
	lmw 23,12(1)
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
.LC19:
	.long 0x40668000
	.long 0x0
	.align 3
.LC20:
	.long 0x400921fb
	.long 0x54442d18
	.align 2
.LC21:
	.long 0x0
	.align 2
.LC22:
	.long 0x43870000
	.align 2
.LC23:
	.long 0x42b40000
	.align 3
.LC24:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC25:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl vectoangles
	.type	 vectoangles,@function
vectoangles:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 30,24(1)
	stw 0,52(1)
	lis 9,.LC21@ha
	mr 31,3
	la 9,.LC21@l(9)
	lfs 0,4(31)
	mr 30,4
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L136
	lfs 0,0(31)
	fcmpu 0,0,13
	bc 4,2,.L136
	lis 10,.LC21@ha
	lfs 0,8(31)
	lis 9,.LC22@ha
	la 10,.LC21@l(10)
	la 9,.LC22@l(9)
	lfs 31,0(10)
	lfs 13,0(9)
	fcmpu 0,0,31
	bc 4,1,.L139
	lis 10,.LC23@ha
	la 10,.LC23@l(10)
	lfs 13,0(10)
	b .L139
.L136:
	lis 9,.LC21@ha
	lfs 2,0(31)
	la 9,.LC21@l(9)
	lfs 13,0(9)
	fcmpu 0,2,13
	bc 12,2,.L140
	lfs 1,4(31)
	bl atan2
	lis 11,.LC19@ha
	lis 10,.LC20@ha
	lfd 12,.LC19@l(11)
	lis 0,0x4330
	lfd 13,.LC20@l(10)
	mr 11,9
	lis 10,.LC24@ha
	fmul 1,1,12
	la 10,.LC24@l(10)
	lfd 11,0(10)
	fdiv 1,1,13
	fctiwz 0,1
	stfd 0,16(1)
	lwz 9,20(1)
	xoris 9,9,0x8000
	stw 9,20(1)
	stw 0,16(1)
	lfd 0,16(1)
	fsub 0,0,11
	frsp 31,0
	b .L141
.L140:
	lfs 0,4(31)
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 31,0(9)
	fcmpu 0,0,13
	bc 4,1,.L141
	lis 10,.LC23@ha
	la 10,.LC23@l(10)
	lfs 31,0(10)
.L141:
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 30,0(9)
	fcmpu 0,31,30
	bc 4,0,.L144
	lis 10,.LC25@ha
	la 10,.LC25@l(10)
	lfs 0,0(10)
	fadds 31,31,0
.L144:
	lfs 0,4(31)
	lfs 1,0(31)
	fmuls 0,0,0
	fmadds 1,1,1,0
	bl sqrt
	frsp 2,1
	lfs 1,8(31)
	bl atan2
	lis 11,.LC19@ha
	lis 10,.LC20@ha
	lfd 12,.LC19@l(11)
	lis 0,0x4330
	lfd 13,.LC20@l(10)
	mr 11,9
	lis 10,.LC24@ha
	fmul 1,1,12
	la 10,.LC24@l(10)
	lfd 11,0(10)
	fdiv 1,1,13
	fctiwz 0,1
	stfd 0,16(1)
	lwz 9,20(1)
	xoris 9,9,0x8000
	stw 9,20(1)
	stw 0,16(1)
	lfd 0,16(1)
	fsub 0,0,11
	frsp 13,0
	fcmpu 0,13,30
	bc 4,0,.L139
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfs 0,0(9)
	fadds 13,13,0
.L139:
	fneg 0,13
	li 0,0
	stfs 31,4(30)
	stw 0,8(30)
	stfs 0,0(30)
	lwz 0,52(1)
	mtlr 0
	lmw 30,24(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 vectoangles,.Lfe3-vectoangles
	.section	".rodata"
	.align 3
.LC26:
	.long 0x40668000
	.long 0x0
	.align 3
.LC27:
	.long 0x400921fb
	.long 0x54442d18
	.align 2
.LC28:
	.long 0x0
	.align 2
.LC29:
	.long 0x43870000
	.align 2
.LC30:
	.long 0x42b40000
	.align 2
.LC31:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl vectoangles2
	.type	 vectoangles2,@function
vectoangles2:
	stwu 1,-32(1)
	mflr 0
	stfd 30,16(1)
	stfd 31,24(1)
	stmw 30,8(1)
	stw 0,36(1)
	lis 9,.LC28@ha
	mr 31,3
	la 9,.LC28@l(9)
	lfs 0,4(31)
	mr 30,4
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L147
	lfs 0,0(31)
	fcmpu 0,0,13
	bc 4,2,.L147
	lis 9,.LC28@ha
	lfs 0,8(31)
	la 9,.LC28@l(9)
	lfs 31,0(9)
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	fcmpu 0,0,31
	lfs 1,0(9)
	bc 4,1,.L150
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 1,0(9)
	b .L150
.L147:
	lis 9,.LC28@ha
	lfs 2,0(31)
	la 9,.LC28@l(9)
	lfs 13,0(9)
	fcmpu 0,2,13
	bc 12,2,.L151
	lfs 1,4(31)
	bl atan2
	lis 9,.LC26@ha
	lis 11,.LC27@ha
	lfd 0,.LC26@l(9)
	lfd 13,.LC27@l(11)
	fmul 1,1,0
	fdiv 1,1,13
	frsp 31,1
	b .L152
.L151:
	lfs 0,4(31)
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	lfs 31,0(9)
	fcmpu 0,0,13
	bc 4,1,.L152
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 31,0(9)
.L152:
	lis 9,.LC28@ha
	la 9,.LC28@l(9)
	lfs 30,0(9)
	fcmpu 0,31,30
	bc 4,0,.L155
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfs 0,0(9)
	fadds 31,31,0
.L155:
	lfs 0,4(31)
	lfs 1,0(31)
	fmuls 0,0,0
	fmadds 1,1,1,0
	bl sqrt
	frsp 2,1
	lfs 1,8(31)
	bl atan2
	lis 9,.LC26@ha
	lis 11,.LC27@ha
	lfd 0,.LC26@l(9)
	lfd 13,.LC27@l(11)
	fmul 1,1,0
	fdiv 1,1,13
	frsp 1,1
	fcmpu 0,1,30
	bc 4,0,.L150
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfs 0,0(9)
	fadds 1,1,0
.L150:
	fneg 0,1
	li 0,0
	stfs 31,4(30)
	stw 0,8(30)
	stfs 0,0(30)
	lwz 0,36(1)
	mtlr 0
	lmw 30,8(1)
	lfd 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 vectoangles2,.Lfe4-vectoangles2
	.section	".rodata"
	.align 2
.LC32:
	.string	"noclass"
	.align 2
.LC33:
	.string	"ED_Alloc: no free edicts"
	.align 2
.LC34:
	.long 0x3f800000
	.align 2
.LC35:
	.long 0x40000000
	.align 3
.LC36:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC37:
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
	lis 6,.LC34@ha
	lwz 10,maxclients@l(11)
	la 6,.LC34@l(6)
	lfs 13,0(6)
	mr 7,9
	lis 8,g_edicts@ha
	lfs 0,20(10)
	lis 11,globals@ha
	lwz 10,g_edicts@l(8)
	la 6,globals@l(11)
	lwz 0,72(6)
	fadds 13,0,13
	fctiwz 12,0
	fctiwz 11,13
	stfd 12,16(1)
	lwz 9,20(1)
	stfd 11,16(1)
	lwz 8,20(1)
	mulli 9,9,1160
	cmpw 0,8,0
	addi 9,9,1160
	add 31,10,9
	bc 4,0,.L162
	mr 7,6
	lis 11,0xfe3
	lis 6,.LC35@ha
	lis 0,0xf01c
	la 6,.LC35@l(6)
	ori 11,11,49265
	lfs 11,0(6)
	ori 0,0,16271
	mullw 11,31,11
	lis 9,.LC32@ha
	lis 6,.LC36@ha
	mullw 0,10,0
	la 9,.LC32@l(9)
	la 6,.LC36@l(6)
	lis 10,level@ha
	lfd 12,0(6)
	la 10,level@l(10)
	add 11,11,0
	li 6,1
	lis 5,0x3f80
.L164:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L163
	lfs 13,272(31)
	fcmpu 0,13,11
	bc 12,0,.L166
	lfs 0,4(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L163
.L166:
	lis 10,.LC37@ha
	lfs 0,428(31)
	la 10,.LC37@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,2,.L167
	stfs 13,428(31)
.L167:
	srawi 0,11,3
	stw 6,88(31)
	mr 3,31
	stw 9,280(31)
	stw 5,408(31)
	b .L174
.L163:
	lwz 0,72(7)
	addi 8,8,1
	addi 11,11,8
	addi 31,31,1160
	cmpw 0,8,0
	bc 12,0,.L164
.L162:
	lis 9,game+1548@ha
	lwz 0,game+1548@l(9)
	cmpw 0,8,0
	bc 4,2,.L170
	lis 9,gi+28@ha
	lis 3,.LC33@ha
	lwz 0,gi+28@l(9)
	la 3,.LC33@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L170:
	lis 9,globals@ha
	lis 6,.LC37@ha
	la 9,globals@l(9)
	la 6,.LC37@l(6)
	lwz 11,72(9)
	lfs 13,0(6)
	addi 11,11,1
	stw 11,72(9)
	lfs 0,428(31)
	fcmpu 0,0,13
	bc 12,2,.L171
	stfs 13,428(31)
.L171:
	lis 9,g_edicts@ha
	lis 11,0xfe3
	lwz 0,g_edicts@l(9)
	ori 11,11,49265
	li 10,1
	lis 9,.LC32@ha
	lis 8,0x3f80
	stw 10,88(31)
	subf 0,0,31
	la 9,.LC32@l(9)
	stw 8,408(31)
	mullw 0,0,11
	stw 9,280(31)
	mr 3,31
	srawi 0,0,3
.L174:
	stw 0,0(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 G_Spawn,.Lfe5-G_Spawn
	.section	".rodata"
	.align 2
.LC38:
	.string	"freed"
	.section	".text"
	.align 2
	.globl KillBox
	.type	 KillBox,@function
KillBox:
	stwu 1,-96(1)
	mflr 0
	stmw 30,88(1)
	stw 0,100(1)
	mr 30,3
	b .L199
.L200:
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
	bc 12,2,.L199
	li 3,0
	b .L203
.L199:
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
	bc 4,2,.L200
	li 3,1
.L203:
	lwz 0,100(1)
	mtlr 0
	lmw 30,88(1)
	la 1,96(1)
	blr
.Lfe6:
	.size	 KillBox,.Lfe6-KillBox
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
.Lfe7:
	.size	 G_ProjectSource,.Lfe7-G_ProjectSource
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
	bc 4,2,.L9
	lis 9,g_edicts@ha
	lis 27,g_edicts@ha
	lwz 31,g_edicts@l(9)
	b .L10
.L205:
	mr 3,31
	b .L204
.L9:
	addi 31,31,1160
	lis 27,g_edicts@ha
.L10:
	lis 11,globals@ha
	lis 10,g_edicts@ha
	la 11,globals@l(11)
	lwz 9,g_edicts@l(10)
	lwz 0,72(11)
	mulli 0,0,1160
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L12
	mr 28,11
.L14:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L13
	lwzx 3,31,29
	cmpwi 0,3,0
	bc 12,2,.L13
	mr 4,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L205
.L13:
	lwz 9,72(28)
	addi 31,31,1160
	lwz 0,g_edicts@l(27)
	mulli 9,9,1160
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L14
.L12:
	li 3,0
.L204:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 G_Find,.Lfe8-G_Find
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
	bc 4,2,.L20
	lis 9,g_edicts@ha
	lis 26,g_edicts@ha
	lwz 30,g_edicts@l(9)
	b .L21
.L207:
	mr 3,30
	b .L206
.L20:
	addi 30,30,1160
	lis 26,g_edicts@ha
.L21:
	lis 11,globals@ha
	lis 10,g_edicts@ha
	la 11,globals@l(11)
	lwz 9,g_edicts@l(10)
	lwz 0,72(11)
	mulli 0,0,1160
	add 9,9,0
	cmplw 0,30,9
	bc 4,0,.L23
	mr 25,11
	addi 28,30,188
	addi 31,30,4
	addi 29,30,200
.L25:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L24
	lwz 0,244(31)
	cmpwi 0,0,0
	bc 12,2,.L24
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
.L208:
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
	bdnz .L208
	addi 3,1,8
	bl VectorLength
	fcmpu 0,1,31
	bc 4,1,.L207
.L24:
	lwz 9,72(25)
	addi 30,30,1160
	addi 28,28,1160
	lwz 0,g_edicts@l(26)
	addi 31,31,1160
	addi 29,29,1160
	mulli 9,9,1160
	add 0,0,9
	cmplw 0,30,0
	bc 12,0,.L25
.L23:
	li 3,0
.L206:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe9:
	.size	 findradius,.Lfe9-findradius
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
	bc 12,2,.L115
	lis 9,MOVEDIR_UP@ha
	lfs 13,MOVEDIR_UP@l(9)
	la 9,MOVEDIR_UP@l(9)
	b .L209
.L115:
	lis 4,VEC_DOWN@ha
	mr 3,30
	la 4,VEC_DOWN@l(4)
	bl VectorCompare
	cmpwi 0,3,0
	bc 12,2,.L117
	lis 9,MOVEDIR_DOWN@ha
	lfs 13,MOVEDIR_DOWN@l(9)
	la 9,MOVEDIR_DOWN@l(9)
.L209:
	stfs 13,0(31)
	lfs 0,4(9)
	stfs 0,4(31)
	lfs 13,8(9)
	stfs 13,8(31)
	b .L116
.L117:
	mr 4,31
	mr 3,30
	li 5,0
	li 6,0
	bl AngleVectors
.L116:
	li 0,0
	stw 0,0(30)
	stw 0,8(30)
	stw 0,4(30)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 G_SetMovedir,.Lfe10-G_SetMovedir
	.section	".rodata"
	.align 2
.LC40:
	.long 0x0
	.section	".text"
	.align 2
	.globl G_InitEdict
	.type	 G_InitEdict,@function
G_InitEdict:
	lis 9,.LC40@ha
	lfs 0,428(3)
	la 9,.LC40@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L159
	stfs 13,428(3)
.L159:
	lis 9,g_edicts@ha
	lis 11,0xfe3
	lwz 0,g_edicts@l(9)
	ori 11,11,49265
	li 10,1
	lis 9,.LC32@ha
	lis 8,0x3f80
	stw 10,88(3)
	subf 0,0,3
	la 9,.LC32@l(9)
	stw 8,408(3)
	mullw 0,0,11
	stw 9,280(3)
	srawi 0,0,3
	stw 0,0(3)
	blr
.Lfe11:
	.size	 G_InitEdict,.Lfe11-G_InitEdict
	.section	".rodata"
	.align 3
.LC41:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC42:
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
	lis 11,0xfe3
	lwz 0,g_edicts@l(9)
	ori 11,11,49265
	lis 9,maxclients@ha
	lis 7,0x4330
	lwz 8,maxclients@l(9)
	subf 0,0,31
	lis 9,.LC41@ha
	mullw 0,0,11
	la 9,.LC41@l(9)
	lfs 13,20(8)
	lfd 12,0(9)
	srawi 0,0,3
	lis 9,.LC42@ha
	xoris 0,0,0x8000
	la 9,.LC42@l(9)
	stw 0,20(1)
	lfs 0,0(9)
	stw 7,16(1)
	fadds 13,13,0
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L175
	mr 3,31
	li 4,0
	li 5,1160
	crxor 6,6,6
	bl memset
	lis 9,.LC38@ha
	lis 11,level+4@ha
	la 9,.LC38@l(9)
	li 0,0
	stw 9,280(31)
	lfs 0,level+4@l(11)
	stw 0,88(31)
	stfs 0,272(31)
.L175:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 G_FreeEdict,.Lfe12-G_FreeEdict
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
	bc 4,2,.L179
	lwz 0,184(30)
	andi. 9,0,4
	bc 12,2,.L178
.L179:
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L177
.L178:
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
	bc 4,1,.L177
	mfctr 31
	addi 29,1,8
.L183:
	lwz 3,0(29)
	addi 29,29,4
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L182
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L182
	mr 4,30
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L182:
	addic. 31,31,-1
	bc 4,2,.L183
.L177:
	lwz 0,4132(1)
	mtlr 0
	lmw 29,4116(1)
	la 1,4128(1)
	blr
.Lfe13:
	.size	 G_TouchTriggers,.Lfe13-G_TouchTriggers
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
	b .L188
.L190:
	addi 30,30,4
	addi 29,29,1
.L188:
	cmpw 0,29,28
	bc 4,0,.L189
	lwz 3,0(30)
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L190
	lwz 0,444(31)
	cmpwi 0,0,0
	bc 12,2,.L193
	mr 4,31
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L193:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L190
.L189:
	lwz 0,4132(1)
	mtlr 0
	lmw 28,4112(1)
	la 1,4128(1)
	blr
.Lfe14:
	.size	 G_TouchSolids,.Lfe14-G_TouchSolids
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
.Lfe15:
	.size	 G_CopyString,.Lfe15-G_CopyString
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
.Lfe16:
	.size	 tv,.Lfe16-tv
	.align 2
	.globl vtos
	.type	 vtos,@function
vtos:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,index.32@ha
	lfs 12,4(3)
	lwz 29,index.32@l(11)
	mr 7,6
	mr 8,6
	lfs 13,8(3)
	lis 9,str.33@ha
	lis 5,.LC14@ha
	addi 0,29,1
	la 9,str.33@l(9)
	rlwinm 0,0,0,29,31
	slwi 29,29,5
	stw 0,index.32@l(11)
	add 29,29,9
	la 5,.LC14@l(5)
	lfs 0,0(3)
	fctiwz 10,12
	li 4,32
	mr 3,29
	fctiwz 9,13
	fctiwz 11,0
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
.Lfe17:
	.size	 vtos,.Lfe17-vtos
	.section	".rodata"
	.align 3
.LC43:
	.long 0x40668000
	.long 0x0
	.align 3
.LC44:
	.long 0x400921fb
	.long 0x54442d18
	.align 2
.LC45:
	.long 0x0
	.align 2
.LC46:
	.long 0x43870000
	.align 2
.LC47:
	.long 0x42b40000
	.align 3
.LC48:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC49:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl vectoyaw
	.type	 vectoyaw,@function
vectoyaw:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 0,36(1)
	lis 9,.LC45@ha
	lfs 2,0(3)
	la 9,.LC45@l(9)
	lfs 31,0(9)
	fcmpu 0,2,31
	bc 4,2,.L120
	lfs 0,4(3)
	lis 10,.LC45@ha
	la 10,.LC45@l(10)
	lfs 1,0(10)
	fcmpu 0,0,31
	bc 12,2,.L125
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 1,0(9)
	bc 4,1,.L125
	lis 10,.LC47@ha
	la 10,.LC47@l(10)
	lfs 1,0(10)
	b .L125
.L120:
	lfs 1,4(3)
	bl atan2
	lis 11,.LC43@ha
	lis 10,.LC44@ha
	lfd 12,.LC43@l(11)
	lis 0,0x4330
	lfd 13,.LC44@l(10)
	mr 11,9
	lis 10,.LC48@ha
	fmul 1,1,12
	la 10,.LC48@l(10)
	lfd 11,0(10)
	fdiv 1,1,13
	fctiwz 0,1
	stfd 0,16(1)
	lwz 9,20(1)
	xoris 9,9,0x8000
	stw 9,20(1)
	stw 0,16(1)
	lfd 0,16(1)
	fsub 0,0,11
	frsp 1,0
	fcmpu 0,1,31
	bc 4,0,.L125
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfs 0,0(9)
	fadds 1,1,0
.L125:
	lwz 0,36(1)
	mtlr 0
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 vectoyaw,.Lfe18-vectoyaw
	.align 2
	.globl G_ProjectSource2
	.type	 G_ProjectSource2,@function
G_ProjectSource2:
	lfs 12,0(4)
	lfs 0,0(3)
	lfs 11,0(5)
	lfs 10,4(4)
	lfs 13,0(6)
	fmadds 11,11,12,0
	lfs 12,8(4)
	lfs 0,0(7)
	fmadds 13,13,10,11
	fmadds 0,0,12,13
	stfs 0,0(8)
	lfs 11,0(4)
	lfs 0,4(3)
	lfs 12,4(5)
	lfs 10,4(4)
	lfs 13,4(6)
	fmadds 12,12,11,0
	lfs 11,8(4)
	lfs 0,4(7)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,4(8)
	lfs 11,8(3)
	lfs 0,0(4)
	lfs 12,8(5)
	lfs 13,8(6)
	lfs 10,4(4)
	fmadds 12,12,0,11
	lfs 0,8(7)
	lfs 11,8(4)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,8(8)
	blr
.Lfe19:
	.size	 G_ProjectSource2,.Lfe19-G_ProjectSource2
	.align 2
	.globl Think_Delay
	.type	 Think_Delay,@function
Think_Delay:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 4,548(29)
	bl G_UseTargets
	mr 3,29
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 Think_Delay,.Lfe20-Think_Delay
	.section	".rodata"
	.align 3
.LC50:
	.long 0x40668000
	.long 0x0
	.align 3
.LC51:
	.long 0x400921fb
	.long 0x54442d18
	.align 2
.LC52:
	.long 0x0
	.align 2
.LC53:
	.long 0x43870000
	.align 2
.LC54:
	.long 0x42b40000
	.align 2
.LC55:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl vectoyaw2
	.type	 vectoyaw2,@function
vectoyaw2:
	stwu 1,-16(1)
	mflr 0
	stfd 31,8(1)
	stw 0,20(1)
	lis 9,.LC52@ha
	lfs 2,0(3)
	la 9,.LC52@l(9)
	lfs 31,0(9)
	fcmpu 0,2,31
	bc 4,2,.L128
	lfs 0,4(3)
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 1,0(9)
	fcmpu 0,0,31
	bc 12,2,.L133
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	lfs 1,0(9)
	bc 4,1,.L133
	lis 9,.LC54@ha
	la 9,.LC54@l(9)
	lfs 1,0(9)
	b .L133
.L128:
	lfs 1,4(3)
	bl atan2
	lis 9,.LC50@ha
	lis 11,.LC51@ha
	lfd 0,.LC50@l(9)
	lfd 13,.LC51@l(11)
	fmul 1,1,0
	fdiv 1,1,13
	frsp 1,1
	fcmpu 0,1,31
	bc 4,0,.L133
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 0,0(9)
	fadds 1,1,0
.L133:
	lwz 0,20(1)
	mtlr 0
	lfd 31,8(1)
	la 1,16(1)
	blr
.Lfe21:
	.size	 vectoyaw2,.Lfe21-vectoyaw2
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
