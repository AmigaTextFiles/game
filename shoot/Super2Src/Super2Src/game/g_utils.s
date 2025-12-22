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
	addi 31,11,936
.L40:
	lwz 0,72(24)
	lwz 9,g_edicts@l(28)
	mulli 0,0,936
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
	addi 31,31,936
	lwz 0,g_edicts@l(28)
	mulli 9,9,936
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
	addi 31,31,936
.L68:
	lwz 0,72(22)
	lwz 9,g_edicts@l(26)
	mulli 0,0,936
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
	addi 31,31,936
	lwz 0,g_edicts@l(26)
	mulli 9,9,936
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
	addi 31,31,936
.L84:
	la 11,globals@l(24)
	lwz 9,g_edicts@l(26)
	lwz 0,72(11)
	mulli 0,0,936
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
	addi 31,31,936
	lwz 0,g_edicts@l(26)
	mulli 9,9,936
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
	bc 4,2,.L114
	lfs 0,0(31)
	fcmpu 0,0,13
	bc 4,2,.L114
	lis 9,.LC19@ha
	lfs 0,8(31)
	la 9,.LC19@l(9)
	lfs 31,0(9)
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	fcmpu 0,0,31
	lfs 13,0(9)
	bc 4,1,.L117
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 13,0(9)
	b .L117
.L114:
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
	bc 4,0,.L118
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fadds 31,31,0
.L118:
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
	bc 4,0,.L117
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fadds 13,13,0
.L117:
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
	mulli 9,9,936
	cmpw 0,8,0
	addi 9,9,936
	add 31,10,9
	bc 4,0,.L124
	lis 7,.LC27@ha
	lis 11,0xdcfd
	la 7,.LC27@l(7)
	lis 0,0x2302
	lfs 11,0(7)
	ori 11,11,53213
	ori 0,0,12323
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
.L126:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L125
	lfs 13,272(31)
	fcmpu 0,13,11
	bc 12,0,.L128
	lfs 0,4(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L125
.L128:
	srawi 0,11,3
	stw 7,88(31)
	mr 3,31
	stw 9,280(31)
	stw 5,408(31)
	b .L134
.L125:
	lwz 0,72(6)
	addi 8,8,1
	addi 11,11,8
	addi 31,31,936
	cmpw 0,8,0
	bc 12,0,.L126
.L124:
	lis 9,game+1548@ha
	lwz 0,game+1548@l(9)
	cmpw 0,8,0
	bc 4,2,.L131
	lis 9,gi+28@ha
	lis 3,.LC25@ha
	lwz 0,gi+28@l(9)
	la 3,.LC25@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L131:
	lis 9,g_edicts@ha
	lis 10,globals@ha
	lwz 0,g_edicts@l(9)
	la 10,globals@l(10)
	lis 8,.LC24@ha
	lis 9,0xdcfd
	lwz 11,72(10)
	la 8,.LC24@l(8)
	ori 9,9,53213
	subf 0,0,31
	mullw 0,0,9
	addi 11,11,1
	lis 7,0x3f80
	stw 11,72(10)
	li 9,1
	mr 3,31
	srawi 0,0,3
	stw 9,88(31)
	stw 8,280(31)
	stw 7,408(31)
.L134:
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
	.align 2
.LC30:
	.string	"grapple"
	.align 2
.LC31:
	.string	"angel of life"
	.section	".text"
	.align 2
	.globl G_TouchTriggers
	.type	 G_TouchTriggers,@function
G_TouchTriggers:
	stwu 1,-4128(1)
	mflr 0
	stmw 29,4116(1)
	stw 0,4132(1)
	mr 31,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L139
	lwz 0,184(31)
	andi. 9,0,4
	bc 12,2,.L138
.L139:
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L137
.L138:
	lis 9,gi+80@ha
	addi 4,31,224
	lwz 0,gi+80@l(9)
	addi 5,1,8
	li 6,1024
	li 7,2
	addi 3,31,212
	mtlr 0
	blrl
	mr 30,3
	lis 4,.LC30@ha
	lwz 3,280(31)
	la 4,.LC30@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L140
	cmpwi 0,30,0
	bc 12,1,.L150
.L140:
	lwz 3,280(31)
	lis 4,.LC31@ha
	la 4,.LC31@l(4)
	bl strcmp
	mr. 3,3
	bc 4,2,.L141
	cmpwi 0,30,0
	bc 4,1,.L141
	stw 3,540(31)
	stw 3,412(31)
.L150:
	lwz 31,256(31)
.L141:
	cmpwi 0,30,0
	bc 4,1,.L137
	mr 29,30
	addi 30,1,8
.L146:
	lwz 3,0(30)
	addi 30,30,4
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L145
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L145
	mr 4,31
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L145:
	addic. 29,29,-1
	bc 4,2,.L146
.L137:
	lwz 0,4132(1)
	mtlr 0
	lmw 29,4116(1)
	la 1,4128(1)
	blr
.Lfe5:
	.size	 G_TouchTriggers,.Lfe5-G_TouchTriggers
	.section	".rodata"
	.align 3
.LC32:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC33:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl KillBox
	.type	 KillBox,@function
KillBox:
	stwu 1,-112(1)
	mflr 0
	stmw 29,100(1)
	stw 0,116(1)
	mr 31,3
	b .L163
.L164:
	lwz 0,184(31)
	andi. 11,0,4
	bc 12,2,.L165
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 4,2,.L166
	lwz 0,184(9)
	andi. 11,0,4
	bc 12,2,.L165
.L166:
	cmpw 0,9,31
	bc 12,2,.L165
	lwz 0,76(30)
	mr 3,31
	lis 30,level@ha
	mtlr 0
	blrl
	lis 9,g_edicts@ha
	lis 11,0xdcfd
	lwz 0,g_edicts@l(9)
	ori 11,11,53213
	lis 9,maxclients@ha
	lis 7,0x4330
	subf 0,0,31
	lwz 10,maxclients@l(9)
	mullw 0,0,11
	lis 9,.LC32@ha
	lis 11,.LC33@ha
	lfs 13,20(10)
	la 9,.LC32@l(9)
	la 11,.LC33@l(11)
	srawi 0,0,3
	lfd 12,0(9)
	lfs 0,0(11)
	xoris 0,0,0x8000
	stw 0,92(1)
	stw 7,88(1)
	fadds 13,13,0
	lfd 0,88(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L168
	mr 3,31
	li 4,0
	li 5,936
	crxor 6,6,6
	bl memset
	lis 9,.LC29@ha
	la 11,level@l(30)
	la 9,.LC29@l(9)
	li 0,0
	stw 9,280(31)
	lfs 0,4(11)
	stw 0,88(31)
	stfs 0,272(31)
.L168:
	lis 11,level@ha
	li 3,0
	la 11,level@l(11)
	lwz 9,284(11)
	addi 9,9,-1
	stw 9,284(11)
	b .L178
.L165:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L169
	lis 9,g_edicts@ha
	lis 6,vec3_origin@ha
	lwz 3,68(1)
	lwz 5,g_edicts@l(9)
	la 6,vec3_origin@l(6)
	li 0,32
	li 11,21
	lis 9,0x1
	stw 0,8(1)
	stw 11,12(1)
	mr 4,31
	mr 8,6
	ori 9,9,34464
	li 10,0
	bl T_Damage
.L169:
	lwz 0,184(31)
	andi. 9,0,4
	bc 12,2,.L171
	lis 9,g_edicts@ha
	lwz 11,68(1)
	lwz 0,g_edicts@l(9)
	cmpw 0,11,0
	bc 4,2,.L163
	li 0,1
	li 3,1
	stw 0,88(31)
	b .L178
.L171:
	lwz 9,68(1)
	lwz 0,248(9)
	cmpwi 0,0,0
	bc 12,2,.L163
	li 3,0
	b .L178
.L163:
	lis 9,gi@ha
	addi 29,31,4
	la 30,gi@l(9)
	mr 7,29
	lwz 11,48(30)
	lis 9,0x201
	addi 3,1,16
	ori 9,9,3
	mr 4,29
	addi 5,31,188
	addi 6,31,200
	mtlr 11
	li 8,0
	blrl
	lwz 9,68(1)
	mr 7,29
	cmpwi 0,9,0
	bc 4,2,.L164
	lwz 0,264(31)
	andi. 9,0,4
	bc 12,2,.L177
	li 0,1
	stw 0,88(31)
.L177:
	li 3,1
.L178:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe6:
	.size	 KillBox,.Lfe6-KillBox
	.section	".rodata"
	.align 2
.LC36:
	.string	"player"
	.align 2
.LC37:
	.string	"misc/tele1.wav"
	.section	".text"
	.align 2
	.globl offsetset
	.type	 offsetset,@function
offsetset:
	mr. 4,4
	bc 4,2,.L225
	li 9,0
	lis 0,0x42c8
.L250:
	stw 9,8(3)
	stw 0,0(3)
	stw 9,4(3)
	blr
.L225:
	cmpwi 0,4,1
	bc 4,2,.L227
	lis 0,0x4284
.L249:
	lis 11,0x4204
.L248:
	li 9,0
	stw 0,0(3)
	stw 9,8(3)
	stw 11,4(3)
	blr
.L227:
	cmpwi 0,4,2
	bc 4,2,.L229
	lis 0,0x4204
	lis 11,0x4284
	b .L248
.L229:
	cmpwi 0,4,3
	bc 4,2,.L231
	li 9,0
	lis 0,0x42c8
.L251:
	stw 9,8(3)
	stw 0,4(3)
	stw 9,0(3)
	blr
.L231:
	cmpwi 0,4,4
	bc 4,2,.L233
	lis 0,0xc204
	lis 11,0x4284
	b .L248
.L233:
	cmpwi 0,4,5
	bc 4,2,.L235
	lis 0,0xc284
	b .L249
.L235:
	cmpwi 0,4,6
	bc 4,2,.L237
	li 9,0
	lis 0,0xc2c8
	b .L250
.L237:
	cmpwi 0,4,7
	bc 4,2,.L239
	lis 0,0xc284
	lis 11,0xc204
	b .L248
.L239:
	cmpwi 0,4,8
	bc 4,2,.L241
	lis 0,0xc204
	lis 11,0xc284
	b .L248
.L241:
	cmpwi 0,4,9
	bc 4,2,.L243
	li 9,0
	lis 0,0xc2c8
	b .L251
.L243:
	cmpwi 0,4,10
	bc 4,2,.L245
	lis 0,0x4204
	lis 11,0xc284
	b .L248
.L245:
	cmpwi 0,4,11
	bclr 4,2
	lis 0,0x4284
	lis 11,0xc204
	b .L248
.Lfe7:
	.size	 offsetset,.Lfe7-offsetset
	.section	".rodata"
	.align 2
.LC38:
	.long 0x3f800000
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC40:
	.long 0x41000000
	.align 2
.LC41:
	.long 0x0
	.section	".text"
	.align 2
	.globl AddMonster
	.type	 AddMonster,@function
AddMonster:
	stwu 1,-128(1)
	mflr 0
	stmw 26,104(1)
	stw 0,132(1)
	mr 27,3
	mr 30,4
	mr 28,5
	bl rand
	lis 0,0x6666
	srawi 11,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,2
	subf 29,11,0
	mulli 9,29,10
	subf 29,9,3
	bl G_Spawn
	cmpwi 0,27,0
	mr 31,3
	bc 4,2,.L253
	addi 4,1,8
	addi 5,1,24
	bl SelectSpawnPoint
	b .L254
.L253:
	lfs 10,8(30)
	lfs 9,8(28)
	lfs 0,0(30)
	lfs 13,4(30)
	lfs 12,0(28)
	lfs 11,4(28)
	stfs 0,8(1)
	stfs 13,12(1)
	stfs 10,16(1)
	stfs 12,24(1)
	stfs 11,28(1)
	stfs 9,32(1)
.L254:
	lfs 13,8(1)
	lis 9,.LC38@ha
	cmpwi 0,29,0
	la 9,.LC38@l(9)
	lfs 11,0(9)
	stfs 13,4(31)
	lfs 0,12(1)
	stfs 0,8(31)
	lfs 12,16(1)
	stfs 12,12(31)
	lfs 0,24(1)
	fadds 12,12,11
	stfs 0,16(31)
	lfs 13,28(1)
	stfs 13,20(31)
	lfs 0,32(1)
	stfs 12,12(31)
	stfs 0,24(31)
	bc 4,2,.L255
	mr 3,31
	bl SP_monster_gladiator
	b .L256
.L255:
	cmpwi 0,29,1
	bc 4,2,.L257
	mr 3,31
	bl SP_monster_flyer
	b .L256
.L257:
	cmpwi 0,29,2
	bc 4,2,.L259
	mr 3,31
	bl SP_monster_soldier_ss
	b .L256
.L259:
	cmpwi 0,29,3
	bc 4,2,.L261
	mr 3,31
	bl SP_monster_gunner
	b .L256
.L261:
	cmpwi 0,29,4
	bc 4,2,.L263
	mr 3,31
	bl SP_monster_infantry
	b .L256
.L263:
	cmpwi 0,29,5
	bc 4,2,.L265
	mr 3,31
	bl SP_monster_tank
	b .L256
.L265:
	cmpwi 0,29,6
	bc 4,2,.L267
	mr 3,31
	bl SP_monster_mutant
	b .L256
.L267:
	cmpwi 0,29,7
	bc 4,2,.L269
	mr 3,31
	bl SP_monster_floater
	b .L256
.L269:
	cmpwi 0,29,8
	bc 4,2,.L271
	mr 3,31
	bl SP_monster_berserk
	b .L256
.L271:
	cmpwi 0,29,9
	bc 4,2,.L256
	mr 3,31
	bl SP_monster_parasite
.L256:
	lis 8,0xc180
	lis 7,0x4180
	lis 0,0xc1c0
	lis 11,0x4200
	stw 8,192(31)
	li 10,0
	lis 9,gi@ha
	stw 0,196(31)
	stw 7,204(31)
	la 30,gi@l(9)
	mr 3,31
	stw 11,208(31)
	lis 26,gi@ha
	stw 10,552(31)
	stw 8,188(31)
	stw 7,200(31)
	lwz 9,76(30)
	mtlr 9
	blrl
	lwz 0,184(31)
	mr 3,31
	ori 0,0,4
	stw 0,184(31)
	bl KillBox
	mr. 29,3
	bc 4,2,.L274
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L275
	lwz 0,76(30)
	mr 3,31
	mtlr 0
	blrl
	lis 9,g_edicts@ha
	lis 11,0xdcfd
	lwz 0,g_edicts@l(9)
	ori 11,11,53213
	lis 9,maxclients@ha
	lis 7,0x4330
	lwz 8,maxclients@l(9)
	subf 0,0,31
	lis 9,.LC39@ha
	mullw 0,0,11
	la 9,.LC39@l(9)
	lfs 13,20(8)
	lfd 12,0(9)
	srawi 0,0,3
	lis 9,.LC40@ha
	xoris 0,0,0x8000
	la 9,.LC40@l(9)
	stw 0,100(1)
	lfs 0,0(9)
	stw 7,96(1)
	fadds 13,13,0
	lfd 0,96(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L275
	mr 3,31
	li 4,0
	li 5,936
	crxor 6,6,6
	bl memset
	lis 9,.LC29@ha
	lis 11,level+4@ha
	la 9,.LC29@l(9)
	stw 9,280(31)
	lfs 0,level+4@l(11)
	stw 29,88(31)
	stfs 0,272(31)
.L275:
	li 3,0
	b .L288
.L274:
	lwz 9,72(30)
	mr 3,31
	addi 29,31,4
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,20
	mtlr 9
	blrl
	lwz 9,120(30)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,88(30)
	mr 3,29
	li 4,2
	mtlr 9
	blrl
	lwz 9,36(30)
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	mtlr 9
	blrl
	lis 9,.LC38@ha
	lwz 0,16(30)
	mr 5,3
	la 9,.LC38@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 2,0(9)
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 3,0(9)
	blrl
	cmpwi 0,27,0
	bc 4,2,.L279
	bl rand
	li 28,0
	lis 0,0x6666
	srawi 11,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,1
	subf 29,11,0
	slwi 9,29,2
	add 9,9,29
	subf 29,9,3
	cmpwi 7,29,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	and 29,29,0
.L284:
	cmpwi 0,29,0
	bc 4,2,.L285
	li 28,12
	b .L283
.L285:
	addi 30,1,72
	mr 4,28
	mr 3,30
	la 27,gi@l(26)
	bl offsetset
	lfs 12,72(1)
	addi 3,1,40
	lfs 11,76(1)
	lfs 10,80(1)
	lfs 0,8(1)
	lfs 13,12(1)
	lfs 9,16(1)
	fadds 12,12,0
	lwz 9,52(27)
	fadds 11,11,13
	fadds 10,10,9
	mtlr 9
	stfs 12,40(1)
	stfs 11,44(1)
	stfs 10,48(1)
	stfs 12,56(1)
	stfs 11,60(1)
	stfs 10,64(1)
	stfs 12,72(1)
	stfs 11,76(1)
	stfs 10,80(1)
	lfs 0,188(31)
	fadds 0,12,0
	stfs 0,40(1)
	lfs 13,192(31)
	fadds 13,11,13
	stfs 13,44(1)
	lfs 0,196(31)
	fadds 0,10,0
	stfs 0,48(1)
	lfs 13,200(31)
	fadds 12,12,13
	stfs 12,56(1)
	lfs 0,204(31)
	fadds 11,11,0
	stfs 11,60(1)
	lfs 0,208(31)
	fadds 10,10,0
	stfs 10,64(1)
	blrl
	andi. 0,3,3
	bc 4,2,.L283
	lwz 0,52(27)
	addi 3,1,56
	mtlr 0
	blrl
	andi. 0,3,3
	bc 4,2,.L283
	mr 4,30
	li 3,1
	addi 5,1,24
	addi 29,29,-1
	bl AddMonster
.L283:
	addi 28,28,1
	cmpwi 0,28,11
	bc 4,1,.L284
.L279:
	li 3,1
.L288:
	lwz 0,132(1)
	mtlr 0
	lmw 26,104(1)
	la 1,128(1)
	blr
.Lfe8:
	.size	 AddMonster,.Lfe8-AddMonster
	.section	".rodata"
	.align 2
.LC42:
	.long 0x3f800000
	.align 2
.LC43:
	.long 0x0
	.align 3
.LC44:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC45:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl tele_remove
	.type	 tele_remove,@function
tele_remove:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 31,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	addi 28,31,4
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,20
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,28
	li 4,2
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	mtlr 9
	blrl
	lis 9,.LC42@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC42@l(9)
	mr 3,31
	lfs 1,0(9)
	mtlr 11
	li 4,0
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 2,0(9)
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,76(29)
	mr 3,31
	mtlr 0
	blrl
	lis 9,g_edicts@ha
	lis 11,0xdcfd
	lwz 0,g_edicts@l(9)
	ori 11,11,53213
	lis 9,maxclients@ha
	lis 7,0x4330
	lwz 8,maxclients@l(9)
	subf 0,0,31
	lis 9,.LC44@ha
	mullw 0,0,11
	la 9,.LC44@l(9)
	lfs 13,20(8)
	lfd 12,0(9)
	srawi 0,0,3
	lis 9,.LC45@ha
	xoris 0,0,0x8000
	la 9,.LC45@l(9)
	stw 0,12(1)
	lfs 0,0(9)
	stw 7,8(1)
	fadds 13,13,0
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L291
	mr 3,31
	li 4,0
	li 5,936
	crxor 6,6,6
	bl memset
	lis 9,.LC29@ha
	lis 11,level+4@ha
	la 9,.LC29@l(9)
	li 0,0
	stw 9,280(31)
	lfs 0,level+4@l(11)
	stw 0,88(31)
	stfs 0,272(31)
.L291:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 tele_remove,.Lfe9-tele_remove
	.section	".rodata"
	.align 2
.LC46:
	.string	"powers/llaser1.wav"
	.align 2
.LC47:
	.string	"powers/llaser2.wav"
	.align 2
.LC48:
	.string	"powers/llaser3.wav"
	.align 2
.LC49:
	.string	"powers/mlaser1.wav"
	.align 2
.LC50:
	.string	"powers/mlaser2.wav"
	.align 2
.LC51:
	.string	"powers/hlaser1.wav"
	.align 2
.LC52:
	.string	"powers/hlaser2.wav"
	.align 2
.LC53:
	.string	"powers/hlaser3.wav"
	.align 2
.LC54:
	.string	"powers/glaser1.wav"
	.align 2
.LC55:
	.string	"powers/glaser2.wav"
	.align 2
.LC56:
	.string	"powers/ls_sw1.wav"
	.align 2
.LC57:
	.string	"powers/ls_sw2.wav"
	.align 2
.LC58:
	.string	"powers/ls_sw3.wav"
	.align 2
.LC59:
	.string	"powers/ls_hit1.wav"
	.align 2
.LC60:
	.string	"powers/ls_hit2.wav"
	.align 2
.LC61:
	.string	"powers/ls_hit3.wav"
	.section	".text"
	.align 2
	.globl rand_laser
	.type	 rand_laser,@function
rand_laser:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr. 30,3
	li 31,0
	bc 4,2,.L293
	bl rand
	lis 9,0x5555
	srawi 11,3,31
	ori 9,9,21846
	mulhw 9,3,9
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf. 9,0,3
	bc 4,2,.L294
	lis 9,gi+36@ha
	lis 3,.LC46@ha
	lwz 0,gi+36@l(9)
	la 3,.LC46@l(3)
	b .L325
.L294:
	cmpwi 0,9,1
	bc 4,2,.L296
	lis 9,gi+36@ha
	lis 3,.LC47@ha
	lwz 0,gi+36@l(9)
	la 3,.LC47@l(3)
	b .L325
.L296:
	cmpwi 0,9,2
	bc 4,2,.L293
	lis 9,gi+36@ha
	lis 3,.LC48@ha
	lwz 0,gi+36@l(9)
	la 3,.LC48@l(3)
.L325:
	mtlr 0
	blrl
	mr 31,3
.L293:
	cmpwi 0,30,1
	bc 4,2,.L299
	bl rand
	srwi 0,3,31
	add 0,3,0
	rlwinm 0,0,0,0,30
	subf. 9,0,3
	bc 4,2,.L300
	lis 9,gi+36@ha
	lis 3,.LC49@ha
	lwz 0,gi+36@l(9)
	la 3,.LC49@l(3)
	b .L326
.L300:
	cmpwi 0,9,1
	bc 4,2,.L299
	lis 9,gi+36@ha
	lis 3,.LC50@ha
	lwz 0,gi+36@l(9)
	la 3,.LC50@l(3)
.L326:
	mtlr 0
	blrl
	mr 31,3
.L299:
	cmpwi 0,30,2
	bc 4,2,.L303
	bl rand
	lis 9,0x5555
	srawi 11,3,31
	ori 9,9,21846
	mulhw 9,3,9
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf. 9,0,3
	bc 4,2,.L304
	lis 9,gi+36@ha
	lis 3,.LC51@ha
	lwz 0,gi+36@l(9)
	la 3,.LC51@l(3)
	b .L327
.L304:
	cmpwi 0,9,1
	bc 4,2,.L306
	lis 9,gi+36@ha
	lis 3,.LC52@ha
	lwz 0,gi+36@l(9)
	la 3,.LC52@l(3)
	b .L327
.L306:
	cmpwi 0,9,2
	bc 4,2,.L303
	lis 9,gi+36@ha
	lis 3,.LC53@ha
	lwz 0,gi+36@l(9)
	la 3,.LC53@l(3)
.L327:
	mtlr 0
	blrl
	mr 31,3
.L303:
	cmpwi 0,30,3
	bc 4,2,.L309
	bl rand
	srwi 0,3,31
	add 0,3,0
	rlwinm 0,0,0,0,30
	subf. 9,0,3
	bc 4,2,.L310
	lis 9,gi+36@ha
	lis 3,.LC54@ha
	lwz 0,gi+36@l(9)
	la 3,.LC54@l(3)
	b .L328
.L310:
	cmpwi 0,9,1
	bc 4,2,.L309
	lis 9,gi+36@ha
	lis 3,.LC55@ha
	lwz 0,gi+36@l(9)
	la 3,.LC55@l(3)
.L328:
	mtlr 0
	blrl
	mr 31,3
.L309:
	cmpwi 0,30,4
	bc 4,2,.L313
	bl rand
	lis 9,0x5555
	srawi 11,3,31
	ori 9,9,21846
	mulhw 9,3,9
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf. 9,0,3
	bc 4,2,.L314
	lis 9,gi+36@ha
	lis 3,.LC56@ha
	lwz 0,gi+36@l(9)
	la 3,.LC56@l(3)
	b .L329
.L314:
	cmpwi 0,9,1
	bc 4,2,.L316
	lis 9,gi+36@ha
	lis 3,.LC57@ha
	lwz 0,gi+36@l(9)
	la 3,.LC57@l(3)
	b .L329
.L316:
	cmpwi 0,9,2
	bc 4,2,.L313
	lis 9,gi+36@ha
	lis 3,.LC58@ha
	lwz 0,gi+36@l(9)
	la 3,.LC58@l(3)
.L329:
	mtlr 0
	blrl
	mr 31,3
.L313:
	cmpwi 0,30,5
	bc 4,2,.L319
	bl rand
	lis 9,0x5555
	srawi 11,3,31
	ori 9,9,21846
	mulhw 9,3,9
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf. 9,0,3
	bc 4,2,.L320
	lis 9,gi+36@ha
	lis 3,.LC59@ha
	lwz 0,gi+36@l(9)
	la 3,.LC59@l(3)
	b .L330
.L320:
	cmpwi 0,9,1
	bc 4,2,.L322
	lis 9,gi+36@ha
	lis 3,.LC60@ha
	lwz 0,gi+36@l(9)
	la 3,.LC60@l(3)
	b .L330
.L322:
	cmpwi 0,9,2
	bc 4,2,.L319
	lis 9,gi+36@ha
	lis 3,.LC61@ha
	lwz 0,gi+36@l(9)
	la 3,.LC61@l(3)
.L330:
	mtlr 0
	blrl
	mr 31,3
.L319:
	mr 3,31
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 rand_laser,.Lfe10-rand_laser
	.section	".rodata"
	.align 2
.LC63:
	.string	"models/super2/blackhole/tris.md2"
	.align 2
.LC66:
	.string	"models/super2/freeze/tris.md2"
	.align 3
.LC64:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC65:
	.long 0x46fffe00
	.align 3
.LC67:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC68:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC69:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl make_ball
	.type	 make_ball,@function
make_ball:
	stwu 1,-80(1)
	mflr 0
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 28,40(1)
	stw 0,84(1)
	mr. 5,5
	mr 28,3
	mr 29,4
	bc 4,2,.L336
	bl G_Spawn
	lfs 0,0(29)
	mr 31,3
	stfs 0,4(31)
	lfs 13,4(29)
	stfs 13,8(31)
	lfs 0,8(29)
	stfs 0,12(31)
	b .L337
.L336:
	mr 31,5
.L337:
	lfs 0,0(29)
	cmpwi 0,28,1
	stfs 0,4(31)
	lfs 13,4(29)
	stfs 13,8(31)
	lfs 0,8(29)
	stfs 0,12(31)
	bc 4,2,.L338
	lis 9,gi+32@ha
	lis 3,.LC63@ha
	lwz 0,gi+32@l(9)
	la 3,.LC63@l(3)
	mtlr 0
	blrl
	lis 9,b_blackhole_think@ha
	stw 3,40(31)
	lis 10,level+4@ha
	la 9,b_blackhole_think@l(9)
	lis 11,.LC64@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC64@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L339
.L338:
	cmpwi 0,28,2
	bc 4,2,.L339
	bl rand
	lis 28,0x4330
	lis 9,.LC67@ha
	rlwinm 3,3,0,17,31
	la 9,.LC67@l(9)
	xoris 3,3,0x8000
	lfd 29,0(9)
	lis 11,.LC65@ha
	lis 10,.LC68@ha
	lfs 30,.LC65@l(11)
	la 10,.LC68@l(10)
	stw 3,36(1)
	addi 29,1,8
	stw 28,32(1)
	lfd 13,32(1)
	lfd 31,0(10)
	fsub 13,13,29
	frsp 13,13
	fdivs 13,13,30
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	frsp 0,0
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,36(1)
	stw 28,32(1)
	lfd 13,32(1)
	fsub 13,13,29
	frsp 13,13
	fdivs 13,13,30
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	frsp 0,0
	stfs 0,4(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	mr 4,29
	stw 3,36(1)
	stw 28,32(1)
	mr 3,29
	lfd 13,32(1)
	fsub 13,13,29
	frsp 13,13
	fdivs 13,13,30
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	frsp 0,0
	stfs 0,8(29)
	bl VectorNormalize2
	lis 9,gi@ha
	lis 3,.LC66@ha
	la 9,gi@l(9)
	la 3,.LC66@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lis 9,G_FreeEdict@ha
	lis 11,.LC69@ha
	stw 3,40(31)
	la 9,G_FreeEdict@l(9)
	lis 10,level+4@ha
	lwz 0,68(31)
	stw 9,436(31)
	la 11,.LC69@l(11)
	lfs 0,level+4@l(10)
	li 9,0
	ori 0,0,8
	lfs 13,0(11)
	li 11,0
	stw 9,260(31)
	stw 0,68(31)
	fadds 0,0,13
	stw 11,376(31)
	stw 11,384(31)
	stw 11,380(31)
	stfs 0,428(31)
	bl rand
	lis 0,0x51eb
	mr 9,3
	ori 0,0,34079
	srawi 10,9,31
	mulhw 0,9,0
	mr 3,29
	addi 4,31,388
	srawi 0,0,5
	subf 0,10,0
	mulli 0,0,100
	subf 9,0,9
	addi 9,9,50
	xoris 9,9,0x8000
	stw 9,36(1)
	stw 28,32(1)
	lfd 1,32(1)
	fsub 1,1,29
	frsp 1,1
	bl VectorScale
.L339:
	li 0,0
	lis 9,gi+72@ha
	stw 0,56(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,84(1)
	mtlr 0
	lmw 28,40(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe11:
	.size	 make_ball,.Lfe11-make_ball
	.section	".data"
	.align 2
	.type	 out.112,@object
	.size	 out.112,50
out.112:
	.byte 0
	.space	49
	.align 2
	.type	 out.116,@object
	.size	 out.116,50
out.116:
	.byte 0
	.space	49
	.section	".rodata"
	.align 2
.LC71:
	.long 0x47800000
	.align 2
.LC72:
	.long 0x43b40000
	.align 2
.LC73:
	.long 0x41000000
	.align 2
.LC74:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl relocate
	.type	 relocate,@function
relocate:
	stwu 1,-80(1)
	mflr 0
	stmw 29,68(1)
	stw 0,84(1)
	mr 31,3
	addi 29,1,24
	addi 4,1,8
	mr 5,29
	li 30,0
	bl SelectSpawnPoint
	lis 7,.LC71@ha
	lfs 0,8(1)
	lis 9,.LC72@ha
	la 7,.LC71@l(7)
	la 9,.LC72@l(9)
	lwz 8,84(31)
	lfs 7,0(7)
	li 0,3
	lis 7,.LC73@ha
	lfs 8,0(9)
	mtctr 0
	la 7,.LC73@l(7)
	lfs 10,0(7)
	mr 11,9
	mr 10,9
	lis 7,.LC74@ha
	la 7,.LC74@l(7)
	fmuls 0,0,10
	lfs 9,0(7)
	li 7,0
	fctiwz 13,0
	stfd 13,56(1)
	lwz 9,60(1)
	sth 9,4(8)
	lfs 0,12(1)
	lwz 9,84(31)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,56(1)
	lwz 11,60(1)
	sth 11,6(9)
	lfs 0,16(1)
	lwz 9,84(31)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,56(1)
	lwz 10,60(1)
	sth 10,8(9)
	lfs 0,16(1)
	lfs 12,8(1)
	lfs 13,12(1)
	fadds 0,0,9
	stfs 12,4(31)
	stfs 13,8(31)
	stfs 0,12(31)
.L375:
	lwz 10,84(31)
	add 0,30,30
	lfsx 0,7,29
	addi 30,30,1
	addi 9,10,3500
	lfsx 13,9,7
	addi 10,10,20
	addi 7,7,4
	fsubs 0,0,13
	fmuls 0,0,7
	fdivs 0,0,8
	fctiwz 12,0
	stfd 12,56(1)
	lwz 11,60(1)
	sthx 11,10,0
	bdnz .L375
	lfs 0,28(1)
	li 0,0
	lwz 11,84(31)
	stw 0,24(31)
	stfs 0,20(31)
	stw 0,16(31)
	stw 0,28(11)
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,32(9)
	lfs 0,24(31)
	lwz 11,84(31)
	stfs 0,36(11)
	lfs 0,16(31)
	lwz 9,84(31)
	stfs 0,3692(9)
	lfs 0,20(31)
	lwz 11,84(31)
	stfs 0,3696(11)
	lfs 13,24(31)
	lwz 9,84(31)
	stfs 13,3700(9)
	lwz 0,84(1)
	mtlr 0
	lmw 29,68(1)
	la 1,80(1)
	blr
.Lfe12:
	.size	 relocate,.Lfe12-relocate
	.comm	v_forward,12,4
	.comm	v_right,12,4
	.comm	v_up,12,4
	.comm	invis_index,4,4
	.comm	cripple_index,4,4
	.comm	robot_index,4,4
	.comm	sun_index,4,4
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
.Lfe13:
	.size	 G_ProjectSource,.Lfe13-G_ProjectSource
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
.L385:
	mr 3,31
	b .L384
.L8:
	addi 31,31,936
	lis 27,g_edicts@ha
.L9:
	lis 11,globals@ha
	lis 10,g_edicts@ha
	la 11,globals@l(11)
	lwz 9,g_edicts@l(10)
	lwz 0,72(11)
	mulli 0,0,936
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
	bc 12,2,.L385
.L12:
	lwz 9,72(28)
	addi 31,31,936
	lwz 0,g_edicts@l(27)
	mulli 9,9,936
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L13
.L11:
	li 3,0
.L384:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 G_Find,.Lfe14-G_Find
	.section	".rodata"
	.align 3
.LC75:
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
.L387:
	mr 3,30
	b .L386
.L19:
	addi 30,30,936
	lis 26,g_edicts@ha
.L20:
	lis 11,globals@ha
	lis 10,g_edicts@ha
	la 11,globals@l(11)
	lwz 9,g_edicts@l(10)
	lwz 0,72(11)
	mulli 0,0,936
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
	lis 9,.LC75@ha
	mtctr 0
	la 9,.LC75@l(9)
	mr 7,31
	lfd 10,0(9)
	mr 8,28
	mr 10,29
	addi 11,1,8
	li 9,0
.L388:
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
	bdnz .L388
	addi 3,1,8
	bl VectorLength
	fcmpu 0,1,31
	bc 4,1,.L387
.L23:
	lwz 9,72(25)
	addi 30,30,936
	addi 28,28,936
	lwz 0,g_edicts@l(26)
	addi 31,31,936
	addi 29,29,936
	mulli 9,9,936
	add 0,0,9
	cmplw 0,30,0
	bc 12,0,.L24
.L22:
	li 3,0
.L386:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe15:
	.size	 findradius,.Lfe15-findradius
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
	b .L389
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
.L389:
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
.Lfe16:
	.size	 G_SetMovedir,.Lfe16-G_SetMovedir
	.align 2
	.globl G_InitEdict
	.type	 G_InitEdict,@function
G_InitEdict:
	lis 9,g_edicts@ha
	lis 11,0xdcfd
	lwz 0,g_edicts@l(9)
	ori 11,11,53213
	li 10,1
	lis 9,.LC24@ha
	stw 10,88(3)
	subf 0,0,3
	la 9,.LC24@l(9)
	mullw 0,0,11
	stw 9,280(3)
	lis 9,0x3f80
	srawi 0,0,3
	stw 9,408(3)
	stw 0,0(3)
	blr
.Lfe17:
	.size	 G_InitEdict,.Lfe17-G_InitEdict
	.section	".rodata"
	.align 3
.LC76:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC77:
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
	lis 11,0xdcfd
	lwz 0,g_edicts@l(9)
	ori 11,11,53213
	lis 9,maxclients@ha
	lis 7,0x4330
	lwz 8,maxclients@l(9)
	subf 0,0,31
	lis 9,.LC76@ha
	mullw 0,0,11
	la 9,.LC76@l(9)
	lfs 13,20(8)
	lfd 12,0(9)
	srawi 0,0,3
	lis 9,.LC77@ha
	xoris 0,0,0x8000
	la 9,.LC77@l(9)
	stw 0,20(1)
	lfs 0,0(9)
	stw 7,16(1)
	fadds 13,13,0
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L135
	mr 3,31
	li 4,0
	li 5,936
	crxor 6,6,6
	bl memset
	lis 9,.LC29@ha
	lis 11,level+4@ha
	la 9,.LC29@l(9)
	li 0,0
	stw 9,280(31)
	lfs 0,level+4@l(11)
	stw 0,88(31)
	stfs 0,272(31)
.L135:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 G_FreeEdict,.Lfe18-G_FreeEdict
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
	b .L152
.L154:
	addi 30,30,4
	addi 29,29,1
.L152:
	cmpw 0,29,28
	bc 4,0,.L153
	lwz 3,0(30)
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L154
	lwz 0,444(31)
	cmpwi 0,0,0
	bc 12,2,.L157
	mr 4,31
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L157:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L154
.L153:
	lwz 0,4132(1)
	mtlr 0
	lmw 28,4112(1)
	la 1,4128(1)
	blr
.Lfe19:
	.size	 G_TouchSolids,.Lfe19-G_TouchSolids
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
.Lfe20:
	.size	 G_CopyString,.Lfe20-G_CopyString
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
.Lfe21:
	.size	 tv,.Lfe21-tv
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
.Lfe22:
	.size	 vtos,.Lfe22-vtos
	.section	".rodata"
	.align 3
.LC78:
	.long 0x40668000
	.long 0x0
	.align 3
.LC79:
	.long 0x400921fb
	.long 0x54442d18
	.align 2
.LC80:
	.long 0x0
	.align 3
.LC81:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC82:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl vectoyaw
	.type	 vectoyaw,@function
vectoyaw:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC80@ha
	lfs 0,4(3)
	la 9,.LC80@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L110
	lfs 0,0(3)
	fcmpu 0,0,13
	bc 4,2,.L110
	lis 10,.LC80@ha
	la 10,.LC80@l(10)
	lfs 1,0(10)
	b .L111
.L110:
	lfs 2,0(3)
	lfs 1,4(3)
	bl atan2
	lis 11,.LC78@ha
	lis 10,.LC79@ha
	lfd 12,.LC78@l(11)
	lis 0,0x4330
	lfd 13,.LC79@l(10)
	mr 11,9
	lis 10,.LC81@ha
	fmul 1,1,12
	la 10,.LC81@l(10)
	lfd 11,0(10)
	lis 10,.LC80@ha
	fdiv 1,1,13
	la 10,.LC80@l(10)
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
	bc 4,0,.L111
	lis 9,.LC82@ha
	la 9,.LC82@l(9)
	lfs 0,0(9)
	fadds 1,1,0
.L111:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 vectoyaw,.Lfe23-vectoyaw
	.align 2
	.globl MV
	.type	 MV,@function
MV:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	lis 4,v_forward@ha
	lis 5,v_right@ha
	lis 6,v_up@ha
	la 4,v_forward@l(4)
	addi 3,3,3692
	la 5,v_right@l(5)
	la 6,v_up@l(6)
	bl AngleVectors
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 MV,.Lfe24-MV
	.section	".rodata"
	.align 2
.LC83:
	.long 0x46fffe00
	.align 3
.LC84:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC85:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC86:
	.long 0x0
	.section	".text"
	.align 2
	.globl avrandom
	.type	 avrandom,@function
avrandom:
	stwu 1,-64(1)
	mflr 0
	stfd 29,40(1)
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 29,28(1)
	stw 0,68(1)
	mr 31,3
	lis 29,0x4330
	bl rand
	lis 9,.LC84@ha
	rlwinm 3,3,0,17,31
	la 9,.LC84@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC85@ha
	la 11,.LC85@l(11)
	stw 3,20(1)
	stw 29,16(1)
	lfd 13,16(1)
	lfd 30,0(11)
	lis 11,.LC83@ha
	fsub 13,13,31
	lfs 29,.LC83@l(11)
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	frsp 0,0
	stfs 0,0(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,20(1)
	stw 29,16(1)
	lfd 13,16(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	frsp 0,0
	stfs 0,4(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC86@ha
	stw 3,20(1)
	la 11,.LC86@l(11)
	stw 29,16(1)
	lfd 0,16(1)
	lfs 12,0(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fsub 13,13,30
	fadd 13,13,13
	frsp 0,13
	fcmpu 0,0,12
	stfs 0,8(31)
	bc 4,0,.L191
	fneg 0,0
	stfs 0,8(31)
.L191:
	mr 3,31
	mr 4,3
	bl VectorNormalize2
	lwz 0,68(1)
	mtlr 0
	lmw 29,28(1)
	lfd 29,40(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe25:
	.size	 avrandom,.Lfe25-avrandom
	.section	".rodata"
	.align 2
.LC87:
	.long 0x46fffe00
	.align 3
.LC88:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC89:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl vrandom
	.type	 vrandom,@function
vrandom:
	stwu 1,-64(1)
	mflr 0
	stfd 29,40(1)
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 28,24(1)
	stw 0,68(1)
	mr 29,3
	lis 28,0x4330
	bl rand
	lis 9,.LC88@ha
	rlwinm 3,3,0,17,31
	la 9,.LC88@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC87@ha
	lis 9,.LC89@ha
	lfs 29,.LC87@l(11)
	la 9,.LC89@l(9)
	lfd 30,0(9)
	stw 3,20(1)
	stw 28,16(1)
	lfd 13,16(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	frsp 0,0
	stfs 0,0(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,20(1)
	stw 28,16(1)
	lfd 13,16(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	frsp 0,0
	stfs 0,4(29)
	bl rand
	rlwinm 0,3,0,17,31
	xoris 0,0,0x8000
	mr 3,29
	stw 0,20(1)
	mr 4,3
	stw 28,16(1)
	lfd 13,16(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	frsp 0,0
	stfs 0,8(29)
	bl VectorNormalize2
	lwz 0,68(1)
	mtlr 0
	lmw 28,24(1)
	lfd 29,40(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe26:
	.size	 vrandom,.Lfe26-vrandom
	.align 2
	.globl stuffcmd
	.type	 stuffcmd,@function
stuffcmd:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,11
	lwz 9,100(29)
	mr 28,4
	mtlr 9
	blrl
	lwz 9,116(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,27
	li 4,1
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 stuffcmd,.Lfe27-stuffcmd
	.align 2
	.globl clientcount
	.type	 clientcount,@function
clientcount:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 9,g_edicts@ha
	li 28,-1
	lwz 10,g_edicts@l(9)
	lis 30,g_edicts@ha
	cmpwi 0,10,0
	bc 12,2,.L194
	lis 9,.LC36@ha
	lis 11,globals@ha
	la 27,.LC36@l(9)
	la 25,globals@l(11)
	lis 26,globals@ha
.L195:
	cmpwi 0,10,0
	addi 28,28,1
	bc 4,2,.L196
	lwz 31,g_edicts@l(30)
	b .L197
.L390:
	mr 10,31
	b .L193
.L196:
	addi 31,10,936
.L197:
	lwz 0,72(25)
	lwz 9,g_edicts@l(30)
	mulli 0,0,936
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L206
	la 29,globals@l(26)
.L200:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L202
	lwz 3,280(31)
	cmpwi 0,3,0
	bc 12,2,.L202
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L390
.L202:
	lwz 9,72(29)
	addi 31,31,936
	lwz 0,g_edicts@l(30)
	mulli 9,9,936
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L200
.L206:
	li 10,0
.L193:
	cmpwi 0,10,0
	bc 4,2,.L195
.L194:
	srawi 3,28,31
	subf 3,28,3
	srawi 3,3,31
	addi 0,3,1
	and 3,28,3
	or 3,3,0
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe28:
	.size	 clientcount,.Lfe28-clientcount
	.section	".rodata"
	.align 2
.LC90:
	.long 0x3f800000
	.align 2
.LC91:
	.long 0x0
	.section	".text"
	.align 2
	.globl make_tele
	.type	 make_tele,@function
make_tele:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	addi 28,27,4
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,20
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,28
	li 4,2
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	mtlr 9
	blrl
	lis 9,.LC90@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC90@l(9)
	li 4,0
	lfs 1,0(9)
	mtlr 0
	mr 3,27
	lis 9,.LC90@ha
	la 9,.LC90@l(9)
	lfs 2,0(9)
	lis 9,.LC91@ha
	la 9,.LC91@l(9)
	lfs 3,0(9)
	blrl
	li 0,6
	stw 0,80(27)
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 make_tele,.Lfe29-make_tele
	.align 2
	.globl Green1
	.type	 Green1,@function
Green1:
	li 8,50
	lis 9,out.112@ha
	mtctr 8
	la 9,out.112@l(9)
	li 0,0
	addi 9,9,49
.L391:
	stb 0,0(9)
	addi 9,9,-1
	bdnz .L391
	lis 9,out.112@ha
	li 11,-1
	la 10,out.112@l(9)
.L355:
	addi 11,11,1
	lbzx 9,3,11
	rlwinm 0,9,0,0xff
	cmpwi 0,0,0
	bc 4,2,.L354
	stbx 0,10,11
	b .L352
.L354:
	ori 9,9,128
	cmpwi 7,11,49
	stbx 9,10,11
	lbzx 0,3,11
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	neg 0,0
	srwi 0,0,31
	and. 8,0,9
	bc 4,2,.L355
.L352:
	lis 3,out.112@ha
	la 3,out.112@l(3)
	blr
.Lfe30:
	.size	 Green1,.Lfe30-Green1
	.align 2
	.globl Green2
	.type	 Green2,@function
Green2:
	li 8,50
	lis 9,out.116@ha
	mtctr 8
	la 9,out.116@l(9)
	li 0,0
	addi 9,9,49
.L392:
	stb 0,0(9)
	addi 9,9,-1
	bdnz .L392
	lis 9,out.116@ha
	li 11,-1
	la 10,out.116@l(9)
.L366:
	addi 11,11,1
	lbzx 9,3,11
	rlwinm 0,9,0,0xff
	cmpwi 0,0,0
	bc 4,2,.L365
	stbx 0,10,11
	b .L363
.L365:
	ori 9,9,128
	cmpwi 7,11,49
	stbx 9,10,11
	lbzx 0,3,11
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	neg 0,0
	srwi 0,0,31
	and. 8,0,9
	bc 4,2,.L366
.L363:
	lis 3,out.116@ha
	la 3,out.116@l(3)
	blr
.Lfe31:
	.size	 Green2,.Lfe31-Green2
	.section	".rodata"
	.align 3
.LC92:
	.long 0x3fd33333
	.long 0x33333333
	.section	".text"
	.align 2
	.globl fromback
	.type	 fromback,@function
fromback:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	mr 29,4
	addi 3,3,16
	addi 4,1,8
	li 5,0
	li 6,0
	bl AngleVectors
	addi 3,29,16
	addi 4,1,24
	li 5,0
	li 6,0
	bl AngleVectors
	lfs 0,28(1)
	lis 9,.LC92@ha
	lfs 11,12(1)
	lfs 12,8(1)
	lfs 10,24(1)
	fmuls 11,11,0
	lfs 9,32(1)
	lfs 0,16(1)
	lfd 13,.LC92@l(9)
	fmadds 12,12,10,11
	fmadds 0,0,9,12
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,30,1
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe32:
	.size	 fromback,.Lfe32-fromback
	.align 2
	.globl MakeInvis
	.type	 MakeInvis,@function
MakeInvis:
	lwz 0,264(3)
	lis 9,invis_index@ha
	li 11,0
	lwz 10,invis_index@l(9)
	ori 0,0,32
	stw 11,60(3)
	stw 0,264(3)
	stw 10,40(3)
	stw 11,44(3)
	blr
.Lfe33:
	.size	 MakeInvis,.Lfe33-MakeInvis
	.align 2
	.globl MakeVis
	.type	 MakeVis,@function
MakeVis:
	lis 11,g_edicts@ha
	lis 0,0xdcfd
	lwz 9,g_edicts@l(11)
	ori 0,0,53213
	li 10,255
	lwz 11,264(3)
	subf 9,9,3
	stw 10,44(3)
	mullw 9,9,0
	rlwinm 11,11,0,27,25
	stw 10,40(3)
	stw 11,264(3)
	srawi 9,9,3
	addi 9,9,-1
	stw 9,60(3)
	blr
.Lfe34:
	.size	 MakeVis,.Lfe34-MakeVis
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
.Lfe35:
	.size	 Think_Delay,.Lfe35-Think_Delay
	.align 2
	.globl nextent
	.type	 nextent,@function
nextent:
	mr. 3,3
	bc 4,2,.L180
	lis 9,g_edicts@ha
	lwz 3,g_edicts@l(9)
	blr
.L180:
	lis 11,game+1548@ha
	lis 10,g_edicts@ha
	lwz 9,game+1548@l(11)
	addi 3,3,936
	lwz 0,g_edicts@l(10)
	mulli 9,9,936
	addi 9,9,-936
	add 0,0,9
	cmpw 0,3,0
	bc 12,2,.L182
	mr 9,0
.L184:
	lwz 0,88(3)
	cmpwi 0,0,0
	bclr 4,2
	addi 3,3,936
	cmpw 0,3,9
	bc 4,2,.L184
.L182:
	li 3,0
	blr
.Lfe36:
	.size	 nextent,.Lfe36-nextent
	.section	".rodata"
	.align 3
.LC93:
	.long 0x43300000
	.long 0x0
	.align 2
.LC94:
	.long 0x447a0000
	.section	".text"
	.align 2
	.globl framerate
	.type	 framerate,@function
framerate:
	stwu 1,-16(1)
	lbz 11,0(3)
	lis 0,0x4330
	lis 10,.LC93@ha
	stw 11,12(1)
	la 10,.LC93@l(10)
	stw 0,8(1)
	lfd 0,0(10)
	lfd 1,8(1)
	lis 10,.LC94@ha
	la 10,.LC94@l(10)
	lfs 13,0(10)
	fsub 1,1,0
	frsp 1,1
	fdivs 1,1,13
	la 1,16(1)
	blr
.Lfe37:
	.size	 framerate,.Lfe37-framerate
	.align 2
	.globl monstercount
	.type	 monstercount,@function
monstercount:
	lis 9,g_edicts@ha
	li 3,0
	lwz 10,g_edicts@l(9)
	cmpwi 0,10,0
	bclr 12,2
	lis 9,game@ha
	lis 4,g_edicts@ha
	la 8,game@l(9)
	mr 6,10
	mr 5,8
	mr 7,10
.L212:
	lwz 11,184(10)
	addi 9,3,1
	cmpwi 7,10,0
	andi. 0,11,4
	mfcr 0
	rlwinm 0,0,3,1
	neg 0,0
	andc 9,9,0
	and 0,3,0
	or 3,0,9
	bc 4,30,.L214
	lwz 10,g_edicts@l(4)
	b .L210
.L396:
	mr 10,11
	b .L210
.L214:
	lwz 9,1548(8)
	addi 11,10,936
	mulli 9,9,936
	addi 9,9,-936
	add 9,6,9
	cmpw 0,11,9
	bc 12,2,.L221
	lwz 9,1548(5)
	mulli 9,9,936
	addi 9,9,-936
	add 9,7,9
.L218:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 4,2,.L396
	addi 11,11,936
	cmpw 0,11,9
	bc 4,2,.L218
.L221:
	li 10,0
.L210:
	cmpwi 0,10,0
	bc 4,2,.L212
	blr
.Lfe38:
	.size	 monstercount,.Lfe38-monstercount
	.section	".rodata"
	.align 2
.LC95:
	.long 0x3f800000
	.align 2
.LC96:
	.long 0x0
	.section	".text"
	.align 2
	.globl tele_insert
	.type	 tele_insert,@function
tele_insert:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	addi 28,27,4
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,20
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,28
	li 4,2
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	mtlr 9
	blrl
	lis 9,.LC95@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC95@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,27
	mtlr 0
	lis 9,.LC95@ha
	la 9,.LC95@l(9)
	lfs 2,0(9)
	lis 9,.LC96@ha
	la 9,.LC96@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe39:
	.size	 tele_insert,.Lfe39-tele_insert
	.section	".rodata"
	.align 3
.LC97:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC98:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC99:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl b_blackhole_think
	.type	 b_blackhole_think,@function
b_blackhole_think:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,56(31)
	addi 9,9,1
	cmpwi 0,9,11
	stw 9,56(31)
	bc 4,2,.L332
	lis 9,gi+76@ha
	lwz 0,gi+76@l(9)
	mtlr 0
	blrl
	lis 9,g_edicts@ha
	lis 11,0xdcfd
	lwz 0,g_edicts@l(9)
	ori 11,11,53213
	lis 9,maxclients@ha
	lis 7,0x4330
	lwz 8,maxclients@l(9)
	subf 0,0,31
	lis 9,.LC98@ha
	mullw 0,0,11
	la 9,.LC98@l(9)
	lfs 13,20(8)
	lfd 12,0(9)
	srawi 0,0,3
	lis 9,.LC99@ha
	xoris 0,0,0x8000
	la 9,.LC99@l(9)
	stw 0,20(1)
	lfs 0,0(9)
	stw 7,16(1)
	fadds 13,13,0
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L331
	mr 3,31
	li 4,0
	li 5,936
	crxor 6,6,6
	bl memset
	lis 9,.LC29@ha
	lis 11,level+4@ha
	la 9,.LC29@l(9)
	li 0,0
	stw 9,280(31)
	lfs 0,level+4@l(11)
	stw 0,88(31)
	stfs 0,272(31)
	b .L331
.L332:
	lis 9,level+4@ha
	lis 11,.LC97@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC97@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L331:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe40:
	.size	 b_blackhole_think,.Lfe40-b_blackhole_think
	.section	".rodata"
	.align 2
.LC100:
	.long 0x0
	.align 3
.LC101:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl randplayer
	.type	 randplayer,@function
randplayer:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	lis 11,.LC100@ha
	lis 9,maxclients@ha
	la 11,.LC100@l(11)
	mr 30,3
	lfs 13,0(11)
	li 29,0
	lis 28,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L379
	lis 9,.LC101@ha
	lis 26,g_edicts@ha
	la 9,.LC101@l(9)
	lis 27,0x4330
	lfd 31,0(9)
.L381:
	bl rand
	lwz 11,maxclients@l(28)
	lwz 8,g_edicts@l(26)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	divw 0,3,9
	mullw 0,0,9
	subf 3,0,3
	mulli 3,3,936
	add 31,8,3
	xor 0,31,30
	lwz 10,88(31)
	addic 9,0,-1
	subfe 11,9,0
	addic 0,10,-1
	subfe 9,0,10
	and. 0,9,11
	bc 12,2,.L380
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L380
	lwz 0,264(31)
	andi. 9,0,8192
	bc 4,2,.L380
	mr 3,31
	mr 4,30
	bl OnSameTeam
	cmpwi 0,3,0
	bc 4,2,.L380
	mr 3,31
	b .L397
.L380:
	addi 29,29,1
	lwz 11,maxclients@l(28)
	xoris 0,29,0x8000
	stw 0,12(1)
	stw 27,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L381
.L379:
	li 3,0
.L397:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe41:
	.size	 randplayer,.Lfe41-randplayer
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
