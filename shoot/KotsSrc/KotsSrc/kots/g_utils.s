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
	bc 4,2,.L35
	lis 9,gi+4@ha
	lis 3,.LC0@ha
	lwz 0,gi+4@l(9)
	la 3,.LC0@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L55
.L35:
	cmpwi 7,29,0
	lis 9,globals@ha
	la 24,globals@l(9)
	lis 28,g_edicts@ha
	addi 30,1,8
	lis 25,globals@ha
.L51:
	bc 4,30,.L39
	lwz 31,g_edicts@l(28)
	b .L40
.L54:
	mr 11,31
	b .L48
.L39:
	addi 31,11,976
.L40:
	lwz 0,72(24)
	lwz 9,g_edicts@l(28)
	mulli 0,0,976
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L49
	la 27,globals@l(25)
.L43:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L45
	lwz 3,300(31)
	cmpwi 0,3,0
	bc 12,2,.L45
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L54
.L45:
	lwz 9,72(27)
	addi 31,31,976
	lwz 0,g_edicts@l(28)
	mulli 9,9,976
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L43
.L49:
	li 11,0
.L48:
	cmpwi 0,11,0
	mcrf 7,0
	bc 12,2,.L37
	cmpwi 0,29,7
	stw 11,0(30)
	addi 30,30,4
	addi 29,29,1
	bc 4,2,.L51
.L37:
	cmpwi 0,29,0
	bc 12,2,.L52
	bl rand
	divw 0,3,29
	addi 9,1,8
	mullw 0,0,29
	subf 3,0,3
	slwi 3,3,2
	lwzx 3,9,3
	b .L53
.L52:
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mr 4,26
	mtlr 0
	crxor 6,6,6
	blrl
.L55:
	li 3,0
.L53:
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
	lfs 0,596(30)
	mr 27,4
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L58
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
	bc 4,2,.L59
	lis 9,gi+4@ha
	lis 3,.LC3@ha
	lwz 0,gi+4@l(9)
	la 3,.LC3@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L59:
	lwz 0,276(30)
	stw 0,276(31)
	lwz 9,296(30)
	stw 9,296(31)
	lwz 0,304(30)
	stw 0,304(31)
	b .L57
.L58:
	lwz 5,276(30)
	cmpwi 0,5,0
	bc 12,2,.L60
	lwz 0,184(27)
	andi. 9,0,4
	bc 4,2,.L60
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
	bc 12,2,.L61
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
	b .L60
.L61:
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
.L60:
	lwz 0,304(30)
	cmpwi 0,0,0
	bc 12,2,.L63
	lis 24,globals@ha
	lis 9,gi@ha
	la 22,globals@l(24)
	la 23,gi@l(9)
	li 31,0
	lis 26,g_edicts@ha
	lis 24,.LC6@ha
	lis 25,globals@ha
.L64:
	cmpwi 0,31,0
	lwz 29,304(30)
	bc 4,2,.L67
	lwz 31,g_edicts@l(26)
	b .L68
.L67:
	addi 31,31,976
.L68:
	lwz 0,72(22)
	lwz 9,g_edicts@l(26)
	mulli 0,0,976
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L77
	la 28,globals@l(25)
.L71:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L73
	lwz 3,300(31)
	cmpwi 0,3,0
	bc 12,2,.L73
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L76
.L73:
	lwz 9,72(28)
	addi 31,31,976
	lwz 0,g_edicts@l(26)
	mulli 9,9,976
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L71
.L77:
	li 31,0
.L76:
	cmpwi 0,31,0
	bc 12,2,.L63
	mr 3,31
	bl G_FreeEdict
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 4,2,.L64
	lwz 0,4(23)
	la 3,.LC6@l(24)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L57
.L63:
	lwz 0,296(30)
	cmpwi 0,0,0
	bc 12,2,.L57
	lis 9,gi@ha
	li 31,0
	la 25,gi@l(9)
	lis 26,g_edicts@ha
	lis 24,globals@ha
.L80:
	cmpwi 0,31,0
	lwz 29,296(30)
	bc 4,2,.L83
	lwz 31,g_edicts@l(26)
	b .L84
.L83:
	addi 31,31,976
.L84:
	la 11,globals@l(24)
	lwz 9,g_edicts@l(26)
	lwz 0,72(11)
	mulli 0,0,976
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L93
	mr 28,11
.L87:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L89
	lwz 3,300(31)
	cmpwi 0,3,0
	bc 12,2,.L89
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L92
.L89:
	lwz 9,72(28)
	addi 31,31,976
	lwz 0,g_edicts@l(26)
	mulli 9,9,976
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L87
.L93:
	li 31,0
.L92:
	cmpwi 0,31,0
	bc 12,2,.L57
	lwz 3,280(31)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L94
	lwz 3,280(30)
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L80
	lwz 3,280(30)
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L80
.L94:
	cmpw 0,31,30
	bc 4,2,.L96
	lwz 9,4(25)
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L97
.L96:
	lwz 0,448(31)
	cmpwi 0,0,0
	bc 12,2,.L97
	mr 3,31
	mr 4,30
	mtlr 0
	mr 5,27
	blrl
.L97:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 4,2,.L80
	lwz 0,4(25)
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L57:
	lwz 0,52(1)
	mtlr 0
	lmw 22,8(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 G_UseTargets,.Lfe2-G_UseTargets
	.section	".sbss","aw",@nobits
	.align 2
index.24:
	.space	4
	.size	 index.24,4
	.lcomm	vecs.25,96,4
	.align 2
index.29:
	.space	4
	.size	 index.29,4
	.lcomm	str.30,256,1
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
	bc 4,2,.L117
	lfs 0,0(31)
	fcmpu 0,0,13
	bc 4,2,.L117
	lis 10,.LC19@ha
	lfs 0,8(31)
	lis 9,.LC20@ha
	la 10,.LC19@l(10)
	la 9,.LC20@l(9)
	lfs 31,0(10)
	lfs 13,0(9)
	fcmpu 0,0,31
	bc 4,1,.L120
	lis 10,.LC21@ha
	la 10,.LC21@l(10)
	lfs 13,0(10)
	b .L120
.L117:
	lis 9,.LC19@ha
	lfs 2,0(31)
	la 9,.LC19@l(9)
	lfs 13,0(9)
	fcmpu 0,2,13
	bc 12,2,.L121
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
	b .L122
.L121:
	lfs 0,4(31)
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 31,0(9)
	fcmpu 0,0,13
	bc 4,1,.L122
	lis 10,.LC21@ha
	la 10,.LC21@l(10)
	lfs 31,0(10)
.L122:
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfs 30,0(9)
	fcmpu 0,31,30
	bc 4,0,.L125
	lis 10,.LC24@ha
	la 10,.LC24@l(10)
	lfs 0,0(10)
	fadds 31,31,0
.L125:
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
	bc 4,0,.L120
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 0,0(9)
	fadds 13,13,0
.L120:
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
	mulli 9,9,976
	cmpw 0,8,0
	addi 9,9,976
	add 31,10,9
	bc 4,0,.L131
	lis 7,.LC28@ha
	lis 11,0xc10c
	la 7,.LC28@l(7)
	lis 0,0x3ef3
	lfs 11,0(7)
	ori 11,11,38677
	ori 0,0,26859
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
.L133:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L132
	lfs 13,272(31)
	fcmpu 0,13,11
	bc 12,0,.L135
	lfs 0,4(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L132
.L135:
	srawi 0,11,4
	stw 7,88(31)
	mr 3,31
	stw 9,280(31)
	stw 5,408(31)
	b .L141
.L132:
	lwz 0,72(6)
	addi 8,8,1
	addi 11,11,16
	addi 31,31,976
	cmpw 0,8,0
	bc 12,0,.L133
.L131:
	lis 9,game+1548@ha
	lwz 0,game+1548@l(9)
	cmpw 0,8,0
	bc 4,2,.L138
	lis 9,gi+28@ha
	lis 3,.LC26@ha
	lwz 0,gi+28@l(9)
	la 3,.LC26@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L138:
	lis 9,g_edicts@ha
	lis 10,globals@ha
	lwz 0,g_edicts@l(9)
	la 10,globals@l(10)
	lis 8,.LC25@ha
	lis 9,0xc10c
	lwz 11,72(10)
	la 8,.LC25@l(8)
	ori 9,9,38677
	subf 0,0,31
	mullw 0,0,9
	addi 11,11,1
	lis 7,0x3f80
	stw 11,72(10)
	li 9,1
	mr 3,31
	srawi 0,0,4
	stw 9,88(31)
	stw 8,280(31)
	stw 7,408(31)
.L141:
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
	.string	"grenade"
	.align 2
.LC31:
	.string	"freed"
	.section	".text"
	.align 2
	.globl KillBox
	.type	 KillBox,@function
KillBox:
	stwu 1,-80(1)
	mflr 0
	stw 0,84(1)
	bl KOTSSpawnKick
	li 3,1
	lwz 0,84(1)
	mtlr 0
	la 1,80(1)
	blr
.Lfe5:
	.size	 KillBox,.Lfe5-KillBox
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
	bc 4,2,.L8
	lis 9,g_edicts@ha
	lis 27,g_edicts@ha
	lwz 31,g_edicts@l(9)
	b .L9
.L166:
	mr 3,31
	b .L165
.L8:
	addi 31,31,976
	lis 27,g_edicts@ha
.L9:
	lis 11,globals@ha
	lis 10,g_edicts@ha
	la 11,globals@l(11)
	lwz 9,g_edicts@l(10)
	lwz 0,72(11)
	mulli 0,0,976
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
	bc 12,2,.L166
.L12:
	lwz 9,72(28)
	addi 31,31,976
	lwz 0,g_edicts@l(27)
	mulli 9,9,976
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L13
.L11:
	li 3,0
.L165:
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
	bc 4,2,.L19
	lis 9,g_edicts@ha
	lis 26,g_edicts@ha
	lwz 30,g_edicts@l(9)
	b .L20
.L168:
	mr 3,30
	b .L167
.L19:
	addi 30,30,976
	lis 26,g_edicts@ha
.L20:
	lis 11,globals@ha
	lis 10,g_edicts@ha
	la 11,globals@l(11)
	lwz 9,g_edicts@l(10)
	lwz 0,72(11)
	mulli 0,0,976
	add 9,9,0
	cmplw 0,30,9
	bc 4,0,.L22
	mr 25,11
	addi 28,30,188
	addi 31,30,4
	addi 29,30,200
.L24:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L23
	lwz 0,244(31)
	cmpwi 0,0,0
	bc 12,2,.L23
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
.L169:
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
	bdnz .L169
	addi 3,1,8
	bl VectorLength
	fcmpu 0,1,31
	bc 4,1,.L168
.L23:
	lwz 9,72(25)
	addi 30,30,976
	addi 28,28,976
	lwz 0,g_edicts@l(26)
	addi 31,31,976
	addi 29,29,976
	mulli 9,9,976
	add 0,0,9
	cmplw 0,30,0
	bc 12,0,.L24
.L22:
	li 3,0
.L167:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 findradius,.Lfe8-findradius
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
	bc 12,2,.L105
	lis 9,MOVEDIR_UP@ha
	lfs 13,MOVEDIR_UP@l(9)
	la 9,MOVEDIR_UP@l(9)
	b .L170
.L105:
	lis 4,VEC_DOWN@ha
	mr 3,30
	la 4,VEC_DOWN@l(4)
	bl VectorCompare
	cmpwi 0,3,0
	bc 12,2,.L107
	lis 9,MOVEDIR_DOWN@ha
	lfs 13,MOVEDIR_DOWN@l(9)
	la 9,MOVEDIR_DOWN@l(9)
.L170:
	stfs 13,0(31)
	lfs 0,4(9)
	stfs 0,4(31)
	lfs 13,8(9)
	stfs 13,8(31)
	b .L106
.L107:
	mr 4,31
	mr 3,30
	li 5,0
	li 6,0
	bl AngleVectors
.L106:
	li 0,0
	stw 0,0(30)
	stw 0,8(30)
	stw 0,4(30)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 G_SetMovedir,.Lfe9-G_SetMovedir
	.align 2
	.globl G_InitEdict
	.type	 G_InitEdict,@function
G_InitEdict:
	lis 9,g_edicts@ha
	lis 11,0xc10c
	lwz 0,g_edicts@l(9)
	ori 11,11,38677
	li 10,1
	lis 9,.LC25@ha
	stw 10,88(3)
	subf 0,0,3
	la 9,.LC25@l(9)
	mullw 0,0,11
	stw 9,280(3)
	lis 9,0x3f80
	srawi 0,0,4
	stw 9,408(3)
	stw 0,0(3)
	blr
.Lfe10:
	.size	 G_InitEdict,.Lfe10-G_InitEdict
	.section	".rodata"
	.align 3
.LC33:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC34:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl G_FreeEdict
	.type	 G_FreeEdict,@function
G_FreeEdict:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	lis 30,.LC30@ha
	lwz 3,280(31)
	la 4,.LC30@l(30)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L143
	la 0,.LC30@l(30)
	stw 0,280(31)
.L143:
	lis 9,gi+76@ha
	mr 3,31
	lwz 0,gi+76@l(9)
	mtlr 0
	blrl
	lis 9,g_edicts@ha
	lis 11,0xc10c
	lwz 0,g_edicts@l(9)
	ori 11,11,38677
	lis 9,maxclients@ha
	lis 7,0x4330
	lwz 8,maxclients@l(9)
	subf 0,0,31
	lis 9,.LC33@ha
	mullw 0,0,11
	la 9,.LC33@l(9)
	lfs 13,20(8)
	lfd 12,0(9)
	srawi 0,0,4
	lis 9,.LC34@ha
	xoris 0,0,0x8000
	la 9,.LC34@l(9)
	stw 0,20(1)
	lfs 0,0(9)
	stw 7,16(1)
	fadds 13,13,0
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L142
	mr 3,31
	li 4,0
	li 5,976
	crxor 6,6,6
	bl memset
	lis 9,.LC31@ha
	lis 11,level+4@ha
	la 9,.LC31@l(9)
	li 0,0
	stw 9,280(31)
	lfs 0,level+4@l(11)
	stw 0,88(31)
	stfs 0,272(31)
.L142:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 G_FreeEdict,.Lfe11-G_FreeEdict
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
	bc 4,2,.L147
	lwz 0,184(30)
	andi. 9,0,4
	bc 12,2,.L146
.L147:
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L145
.L146:
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
	bc 4,1,.L145
	mfctr 31
	addi 29,1,8
.L151:
	lwz 3,0(29)
	addi 29,29,4
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L150
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L150
	mr 4,30
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L150:
	addic. 31,31,-1
	bc 4,2,.L151
.L145:
	lwz 0,4132(1)
	mtlr 0
	lmw 29,4116(1)
	la 1,4128(1)
	blr
.Lfe12:
	.size	 G_TouchTriggers,.Lfe12-G_TouchTriggers
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
	b .L156
.L158:
	addi 30,30,4
	addi 29,29,1
.L156:
	cmpw 0,29,28
	bc 4,0,.L157
	lwz 3,0(30)
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L158
	lwz 0,444(31)
	cmpwi 0,0,0
	bc 12,2,.L161
	mr 4,31
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L161:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L158
.L157:
	lwz 0,4132(1)
	mtlr 0
	lmw 28,4112(1)
	la 1,4128(1)
	blr
.Lfe13:
	.size	 G_TouchSolids,.Lfe13-G_TouchSolids
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
	.globl tv
	.type	 tv,@function
tv:
	lis 8,index.24@ha
	lis 10,vecs.25@ha
	lwz 9,index.24@l(8)
	la 10,vecs.25@l(10)
	mulli 11,9,12
	addi 9,9,1
	stfsx 1,11,10
	rlwinm 9,9,0,29,31
	add 11,11,10
	stw 9,index.24@l(8)
	mr 3,11
	stfs 2,4(11)
	stfs 3,8(11)
	blr
.Lfe15:
	.size	 tv,.Lfe15-tv
	.align 2
	.globl vtos
	.type	 vtos,@function
vtos:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,index.29@ha
	lfs 12,4(3)
	lwz 29,index.29@l(11)
	mr 7,6
	mr 8,6
	lfs 13,8(3)
	lis 9,str.30@ha
	lis 5,.LC14@ha
	addi 0,29,1
	la 9,str.30@l(9)
	rlwinm 0,0,0,29,31
	slwi 29,29,5
	stw 0,index.29@l(11)
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
.Lfe16:
	.size	 vtos,.Lfe16-vtos
	.section	".rodata"
	.align 3
.LC35:
	.long 0x40668000
	.long 0x0
	.align 3
.LC36:
	.long 0x400921fb
	.long 0x54442d18
	.align 2
.LC37:
	.long 0x0
	.align 2
.LC38:
	.long 0x42b40000
	.align 2
.LC39:
	.long 0xc2b40000
	.align 3
.LC40:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC41:
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
	lis 9,.LC37@ha
	lfs 2,0(3)
	la 9,.LC37@l(9)
	lfs 31,0(9)
	fcmpu 0,2,31
	bc 4,2,.L110
	lis 10,.LC37@ha
	lfs 0,4(3)
	la 10,.LC37@l(10)
	lfs 1,0(10)
	fcmpu 0,0,1
	bc 4,1,.L111
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 1,0(9)
	b .L114
.L111:
	bc 4,0,.L114
	lis 10,.LC39@ha
	la 10,.LC39@l(10)
	lfs 1,0(10)
	b .L114
.L110:
	lfs 1,4(3)
	bl atan2
	lis 11,.LC35@ha
	lis 10,.LC36@ha
	lfd 12,.LC35@l(11)
	lis 0,0x4330
	lfd 13,.LC36@l(10)
	mr 11,9
	lis 10,.LC40@ha
	fmul 1,1,12
	la 10,.LC40@l(10)
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
	bc 4,0,.L114
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 0,0(9)
	fadds 1,1,0
.L114:
	lwz 0,36(1)
	mtlr 0
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 vectoyaw,.Lfe17-vectoyaw
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
.Lfe18:
	.size	 Think_Delay,.Lfe18-Think_Delay
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
