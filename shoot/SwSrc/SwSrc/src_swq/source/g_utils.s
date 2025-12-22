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
	bc 4,2,.L41
	lis 9,gi+4@ha
	lis 3,.LC0@ha
	lwz 0,gi+4@l(9)
	la 3,.LC0@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L61
.L41:
	cmpwi 7,29,0
	lis 9,globals@ha
	la 24,globals@l(9)
	lis 28,g_edicts@ha
	addi 30,1,8
	lis 25,globals@ha
.L57:
	bc 4,30,.L45
	lwz 31,g_edicts@l(28)
	b .L46
.L60:
	mr 11,31
	b .L54
.L45:
	addi 31,11,1076
.L46:
	lwz 0,72(24)
	lwz 9,g_edicts@l(28)
	mulli 0,0,1076
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L55
	la 27,globals@l(25)
.L49:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L51
	lwz 3,300(31)
	cmpwi 0,3,0
	bc 12,2,.L51
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L60
.L51:
	lwz 9,72(27)
	addi 31,31,1076
	lwz 0,g_edicts@l(28)
	mulli 9,9,1076
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L49
.L55:
	li 11,0
.L54:
	cmpwi 0,11,0
	mcrf 7,0
	bc 12,2,.L43
	cmpwi 0,29,7
	stw 11,0(30)
	addi 30,30,4
	addi 29,29,1
	bc 4,2,.L57
.L43:
	cmpwi 0,29,0
	bc 12,2,.L58
	bl rand
	divw 0,3,29
	addi 9,1,8
	mullw 0,0,29
	subf 3,0,3
	slwi 3,3,2
	lwzx 3,9,3
	b .L59
.L58:
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mr 4,26
	mtlr 0
	crxor 6,6,6
	blrl
.L61:
	li 3,0
.L59:
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
	mr 31,3
	la 9,.LC12@l(9)
	lfs 0,596(31)
	mr 27,4
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L64
	bl G_Spawn
	lis 9,.LC2@ha
	mr 29,3
	la 9,.LC2@l(9)
	lis 11,level+4@ha
	stw 9,280(29)
	cmpwi 0,27,0
	lfs 0,level+4@l(11)
	lis 9,Think_Delay@ha
	lfs 13,596(31)
	la 9,Think_Delay@l(9)
	stw 9,436(29)
	stw 27,548(29)
	fadds 0,0,13
	stfs 0,428(29)
	bc 4,2,.L65
	lis 9,gi+4@ha
	lis 3,.LC3@ha
	lwz 0,gi+4@l(9)
	la 3,.LC3@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L65:
	lwz 0,276(31)
	stw 0,276(29)
	lwz 9,296(31)
	stw 9,296(29)
	lwz 0,304(31)
	stw 0,304(29)
	b .L63
.L64:
	lwz 5,276(31)
	cmpwi 0,5,0
	bc 12,2,.L66
	lwz 0,184(27)
	andi. 9,0,4
	bc 4,2,.L66
	lis 4,.LC4@ha
	mr 3,27
	la 4,.LC4@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	lwz 5,576(31)
	cmpwi 0,5,0
	bc 12,2,.L67
	lis 9,gi+16@ha
	mr 3,27
	lwz 0,gi+16@l(9)
	li 4,0
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 2,0(9)
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	lfs 3,0(9)
	blrl
	b .L66
.L67:
	lis 29,gi@ha
	lis 3,.LC5@ha
	la 29,gi@l(29)
	la 3,.LC5@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC13@ha
	lwz 0,16(29)
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
.L66:
	lwz 0,304(31)
	cmpwi 0,0,0
	bc 12,2,.L69
	lis 24,globals@ha
	lis 9,gi@ha
	la 22,globals@l(24)
	la 23,gi@l(9)
	li 29,0
	lis 26,g_edicts@ha
	lis 24,.LC6@ha
	lis 25,globals@ha
.L70:
	cmpwi 0,29,0
	lwz 30,304(31)
	bc 4,2,.L73
	lwz 29,g_edicts@l(26)
	b .L74
.L73:
	addi 29,29,1076
.L74:
	lwz 0,72(22)
	lwz 9,g_edicts@l(26)
	mulli 0,0,1076
	add 9,9,0
	cmplw 0,29,9
	bc 4,0,.L83
	la 28,globals@l(25)
.L77:
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L79
	lwz 3,300(29)
	cmpwi 0,3,0
	bc 12,2,.L79
	mr 4,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L82
.L79:
	lwz 9,72(28)
	addi 29,29,1076
	lwz 0,g_edicts@l(26)
	mulli 9,9,1076
	add 0,0,9
	cmplw 0,29,0
	bc 12,0,.L77
.L83:
	li 29,0
.L82:
	cmpwi 0,29,0
	bc 12,2,.L69
	mr 3,29
	bl G_FreeEdict
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L70
	lwz 0,4(23)
	la 3,.LC6@l(24)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L63
.L69:
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L63
	lis 9,gi@ha
	li 29,0
	la 25,gi@l(9)
	lis 26,g_edicts@ha
	lis 24,globals@ha
.L86:
	cmpwi 0,29,0
	lwz 30,296(31)
	bc 4,2,.L89
	lwz 29,g_edicts@l(26)
	b .L90
.L89:
	addi 29,29,1076
.L90:
	la 11,globals@l(24)
	lwz 9,g_edicts@l(26)
	lwz 0,72(11)
	mulli 0,0,1076
	add 9,9,0
	cmplw 0,29,9
	bc 4,0,.L99
	mr 28,11
.L93:
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L95
	lwz 3,300(29)
	cmpwi 0,3,0
	bc 12,2,.L95
	mr 4,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L98
.L95:
	lwz 9,72(28)
	addi 29,29,1076
	lwz 0,g_edicts@l(26)
	mulli 9,9,1076
	add 0,0,9
	cmplw 0,29,0
	bc 12,0,.L93
.L99:
	li 29,0
.L98:
	cmpwi 0,29,0
	bc 12,2,.L63
	lwz 3,280(29)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L100
	lwz 3,280(31)
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L86
	lwz 3,280(31)
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L86
.L100:
	cmpw 0,29,31
	bc 4,2,.L102
	lwz 9,4(25)
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L103
.L102:
	lwz 0,448(29)
	cmpwi 0,0,0
	bc 12,2,.L103
	mr 3,29
	mr 4,31
	mtlr 0
	mr 5,27
	blrl
.L103:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L86
	lwz 0,4(25)
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L63:
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
	.long 0xc2b40000
	.align 2
.LC24:
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
	lis 9,.LC19@ha
	mr 31,3
	la 9,.LC19@l(9)
	lfs 0,4(31)
	mr 30,4
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L123
	lfs 0,0(31)
	fcmpu 0,0,13
	bc 4,2,.L123
	lis 10,.LC19@ha
	lfs 0,8(31)
	lis 9,.LC20@ha
	la 10,.LC19@l(10)
	la 9,.LC20@l(9)
	lfs 31,0(10)
	lfs 13,0(9)
	fcmpu 0,0,31
	bc 4,1,.L126
	lis 10,.LC21@ha
	la 10,.LC21@l(10)
	lfs 13,0(10)
	b .L126
.L123:
	lis 9,.LC19@ha
	lfs 2,0(31)
	la 9,.LC19@l(9)
	lfs 13,0(9)
	fcmpu 0,2,13
	bc 12,2,.L127
	lfs 1,4(31)
	bl atan2
	lis 11,.LC17@ha
	lis 10,.LC18@ha
	lfd 12,.LC17@l(11)
	lis 0,0x4330
	lfd 13,.LC18@l(10)
	mr 11,9
	lis 10,.LC22@ha
	fmul 1,1,12
	la 10,.LC22@l(10)
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
	b .L128
.L127:
	lfs 0,4(31)
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 31,0(9)
	fcmpu 0,0,13
	bc 4,1,.L128
	lis 10,.LC21@ha
	la 10,.LC21@l(10)
	lfs 31,0(10)
.L128:
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfs 30,0(9)
	fcmpu 0,31,30
	bc 4,0,.L131
	lis 10,.LC24@ha
	la 10,.LC24@l(10)
	lfs 0,0(10)
	fadds 31,31,0
.L131:
	lfs 0,4(31)
	lfs 1,0(31)
	fmuls 0,0,0
	fmadds 1,1,1,0
	bl sqrt
	frsp 2,1
	lfs 1,8(31)
	bl atan2
	lis 11,.LC17@ha
	lis 10,.LC18@ha
	lfd 12,.LC17@l(11)
	lis 0,0x4330
	lfd 13,.LC18@l(10)
	mr 11,9
	lis 10,.LC22@ha
	fmul 1,1,12
	la 10,.LC22@l(10)
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
	bc 4,0,.L126
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 0,0(9)
	fadds 13,13,0
.L126:
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
	.align 2
.LC25:
	.string	"noclass"
	.align 2
.LC26:
	.string	"ED_Alloc: no free edicts"
	.align 2
.LC27:
	.long 0x3f800000
	.align 2
.LC28:
	.long 0x40000000
	.align 3
.LC29:
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
	lis 7,.LC27@ha
	lwz 10,maxclients@l(11)
	la 7,.LC27@l(7)
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
	mulli 9,9,1076
	cmpw 0,8,0
	addi 9,9,1076
	add 31,10,9
	bc 4,0,.L137
	lis 7,.LC28@ha
	lis 11,0x6205
	la 7,.LC28@l(7)
	lis 0,0x9dfa
	lfs 11,0(7)
	ori 11,11,46533
	ori 0,0,19003
	lis 7,.LC29@ha
	mullw 0,10,0
	lis 9,.LC25@ha
	la 7,.LC29@l(7)
	mullw 11,31,11
	lis 10,level@ha
	lfd 12,0(7)
	la 9,.LC25@l(9)
	la 10,level@l(10)
	add 11,11,0
	li 7,1
	lis 5,0x3f80
.L139:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L138
	lfs 13,272(31)
	fcmpu 0,13,11
	bc 12,0,.L141
	lfs 0,4(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L138
.L141:
	srawi 0,11,2
	stw 7,88(31)
	mr 3,31
	stw 9,280(31)
	stw 5,408(31)
	b .L147
.L138:
	lwz 0,72(6)
	addi 8,8,1
	addi 11,11,4
	addi 31,31,1076
	cmpw 0,8,0
	bc 12,0,.L139
.L137:
	lis 9,game+1548@ha
	lwz 0,game+1548@l(9)
	cmpw 0,8,0
	bc 4,2,.L144
	lis 9,gi+28@ha
	lis 3,.LC26@ha
	lwz 0,gi+28@l(9)
	la 3,.LC26@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L144:
	lis 9,g_edicts@ha
	lis 10,globals@ha
	lwz 0,g_edicts@l(9)
	la 10,globals@l(10)
	lis 8,.LC25@ha
	lis 9,0x6205
	lwz 11,72(10)
	la 8,.LC25@l(8)
	ori 9,9,46533
	subf 0,0,31
	mullw 0,0,9
	addi 11,11,1
	lis 7,0x3f80
	stw 11,72(10)
	li 9,1
	mr 3,31
	srawi 0,0,2
	stw 9,88(31)
	stw 8,280(31)
	stw 7,408(31)
.L147:
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
.LC30:
	.string	"freed"
	.comm	node_count,2,2
	.comm	path_not_time_yet,4,4
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
.LC31:
	.long 0x0
	.section	".text"
	.align 2
	.globl VectorLengthSquared
	.type	 VectorLengthSquared,@function
VectorLengthSquared:
	lis 9,.LC31@ha
	li 0,3
	la 9,.LC31@l(9)
	mtctr 0
	lfs 1,0(9)
.L176:
	lfs 0,0(3)
	addi 3,3,4
	fmadds 1,0,0,1
	bdnz .L176
	blr
.Lfe5:
	.size	 VectorLengthSquared,.Lfe5-VectorLengthSquared
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
.Lfe6:
	.size	 G_ProjectSource,.Lfe6-G_ProjectSource
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
	bc 4,2,.L14
	lis 9,g_edicts@ha
	lis 27,g_edicts@ha
	lwz 31,g_edicts@l(9)
	b .L15
.L178:
	mr 3,31
	b .L177
.L14:
	addi 31,31,1076
	lis 27,g_edicts@ha
.L15:
	lis 11,globals@ha
	lis 10,g_edicts@ha
	la 11,globals@l(11)
	lwz 9,g_edicts@l(10)
	lwz 0,72(11)
	mulli 0,0,1076
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L17
	mr 28,11
.L19:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L18
	lwzx 3,31,29
	cmpwi 0,3,0
	bc 12,2,.L18
	mr 4,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L178
.L18:
	lwz 9,72(28)
	addi 31,31,1076
	lwz 0,g_edicts@l(27)
	mulli 9,9,1076
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L19
.L17:
	li 3,0
.L177:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 G_Find,.Lfe7-G_Find
	.section	".rodata"
	.align 3
.LC32:
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
	bc 4,2,.L25
	lis 9,g_edicts@ha
	lis 26,g_edicts@ha
	lwz 30,g_edicts@l(9)
	b .L26
.L180:
	mr 3,30
	b .L179
.L25:
	addi 30,30,1076
	lis 26,g_edicts@ha
.L26:
	lis 11,globals@ha
	lis 10,g_edicts@ha
	la 11,globals@l(11)
	lwz 9,g_edicts@l(10)
	lwz 0,72(11)
	mulli 0,0,1076
	add 9,9,0
	cmplw 0,30,9
	bc 4,0,.L28
	mr 25,11
	addi 28,30,188
	addi 31,30,4
	addi 29,30,200
.L30:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L29
	lwz 0,244(31)
	cmpwi 0,0,0
	bc 12,2,.L29
	li 0,3
	lis 9,.LC32@ha
	mtctr 0
	la 9,.LC32@l(9)
	mr 7,31
	lfd 10,0(9)
	mr 8,28
	mr 10,29
	addi 11,1,8
	li 9,0
.L181:
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
	bdnz .L181
	addi 3,1,8
	bl VectorLength
	fcmpu 0,1,31
	bc 4,1,.L180
.L29:
	lwz 9,72(25)
	addi 30,30,1076
	addi 28,28,1076
	lwz 0,g_edicts@l(26)
	addi 31,31,1076
	addi 29,29,1076
	mulli 9,9,1076
	add 0,0,9
	cmplw 0,30,0
	bc 12,0,.L30
.L28:
	li 3,0
.L179:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 findradius,.Lfe8-findradius
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
.Lfe9:
	.size	 Think_Delay,.Lfe9-Think_Delay
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
.Lfe10:
	.size	 tv,.Lfe10-tv
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
.Lfe11:
	.size	 vtos,.Lfe11-vtos
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
	bc 12,2,.L111
	lis 9,MOVEDIR_UP@ha
	lfs 13,MOVEDIR_UP@l(9)
	la 9,MOVEDIR_UP@l(9)
	b .L182
.L111:
	lis 4,VEC_DOWN@ha
	mr 3,30
	la 4,VEC_DOWN@l(4)
	bl VectorCompare
	cmpwi 0,3,0
	bc 12,2,.L113
	lis 9,MOVEDIR_DOWN@ha
	lfs 13,MOVEDIR_DOWN@l(9)
	la 9,MOVEDIR_DOWN@l(9)
.L182:
	stfs 13,0(31)
	lfs 0,4(9)
	stfs 0,4(31)
	lfs 13,8(9)
	stfs 13,8(31)
	b .L112
.L113:
	mr 4,31
	mr 3,30
	li 5,0
	li 6,0
	bl AngleVectors
.L112:
	li 0,0
	stw 0,0(30)
	stw 0,8(30)
	stw 0,4(30)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 G_SetMovedir,.Lfe12-G_SetMovedir
	.section	".rodata"
	.align 3
.LC33:
	.long 0x40668000
	.long 0x0
	.align 3
.LC34:
	.long 0x400921fb
	.long 0x54442d18
	.align 2
.LC35:
	.long 0x0
	.align 2
.LC36:
	.long 0x42b40000
	.align 2
.LC37:
	.long 0xc2b40000
	.align 3
.LC38:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC39:
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
	lis 9,.LC35@ha
	lfs 2,0(3)
	la 9,.LC35@l(9)
	lfs 31,0(9)
	fcmpu 0,2,31
	bc 4,2,.L116
	lis 10,.LC35@ha
	lfs 0,4(3)
	la 10,.LC35@l(10)
	lfs 1,0(10)
	fcmpu 0,0,1
	bc 4,1,.L117
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 1,0(9)
	b .L120
.L117:
	bc 4,0,.L120
	lis 10,.LC37@ha
	la 10,.LC37@l(10)
	lfs 1,0(10)
	b .L120
.L116:
	lfs 1,4(3)
	bl atan2
	lis 11,.LC33@ha
	lis 10,.LC34@ha
	lfd 12,.LC33@l(11)
	lis 0,0x4330
	lfd 13,.LC34@l(10)
	mr 11,9
	lis 10,.LC38@ha
	fmul 1,1,12
	la 10,.LC38@l(10)
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
	bc 4,0,.L120
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 0,0(9)
	fadds 1,1,0
.L120:
	lwz 0,36(1)
	mtlr 0
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 vectoyaw,.Lfe13-vectoyaw
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
.Lfe14:
	.size	 G_CopyString,.Lfe14-G_CopyString
	.align 2
	.globl G_InitEdict
	.type	 G_InitEdict,@function
G_InitEdict:
	lis 9,g_edicts@ha
	lis 11,0x6205
	lwz 0,g_edicts@l(9)
	ori 11,11,46533
	li 10,1
	lis 9,.LC25@ha
	stw 10,88(3)
	subf 0,0,3
	la 9,.LC25@l(9)
	mullw 0,0,11
	stw 9,280(3)
	lis 9,0x3f80
	srawi 0,0,2
	stw 9,408(3)
	stw 0,0(3)
	blr
.Lfe15:
	.size	 G_InitEdict,.Lfe15-G_InitEdict
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
	lis 11,0x6205
	lwz 0,g_edicts@l(9)
	ori 11,11,46533
	lis 9,maxclients@ha
	lis 7,0x4330
	lwz 8,maxclients@l(9)
	subf 0,0,31
	lis 9,.LC40@ha
	mullw 0,0,11
	la 9,.LC40@l(9)
	lfs 13,20(8)
	lfd 12,0(9)
	srawi 0,0,2
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
	bc 12,3,.L148
	mr 3,31
	li 4,0
	li 5,1076
	crxor 6,6,6
	bl memset
	lis 9,.LC30@ha
	lis 11,level+4@ha
	la 9,.LC30@l(9)
	li 0,0
	stw 9,280(31)
	lfs 0,level+4@l(11)
	stw 0,88(31)
	stfs 0,272(31)
.L148:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 G_FreeEdict,.Lfe16-G_FreeEdict
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
	bc 4,2,.L152
	lwz 0,184(30)
	andi. 9,0,4
	bc 12,2,.L151
.L152:
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L150
.L151:
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
	bc 4,1,.L150
	mfctr 31
	addi 29,1,8
.L156:
	lwz 3,0(29)
	addi 29,29,4
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L155
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L155
	mr 4,30
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L155:
	addic. 31,31,-1
	bc 4,2,.L156
.L150:
	lwz 0,4132(1)
	mtlr 0
	lmw 29,4116(1)
	la 1,4128(1)
	blr
.Lfe17:
	.size	 G_TouchTriggers,.Lfe17-G_TouchTriggers
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
	lwz 0,444(31)
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
.Lfe18:
	.size	 G_TouchSolids,.Lfe18-G_TouchSolids
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
	b .L183
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
.L183:
	lwz 0,100(1)
	mtlr 0
	lmw 30,88(1)
	la 1,96(1)
	blr
.Lfe19:
	.size	 KillBox,.Lfe19-KillBox
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
