	.file	"z_coop.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl PutClientAtLatestRallyPoint
	.type	 PutClientAtLatestRallyPoint,@function
PutClientAtLatestRallyPoint:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lis 9,game+1544@ha
	li 8,0
	lwz 0,game+1544@l(9)
	cmpwi 0,0,0
	bc 4,1,.L8
	lis 11,g_edicts@ha
	mtctr 0
	lwz 9,g_edicts@l(11)
	addi 9,9,1084
.L10:
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L9
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L9
	lwz 11,412(9)
	cmpwi 0,11,0
	bc 12,2,.L9
	cmpwi 0,8,0
	bc 12,2,.L26
	lfs 13,992(8)
	lfs 0,992(11)
	fcmpu 0,13,0
	bc 4,0,.L9
.L26:
	mr 8,11
.L9:
	addi 9,9,1084
	bdnz .L10
.L8:
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0x451a
	lwz 10,game+1028@l(11)
	ori 9,9,45835
	cmpwi 0,8,0
	subf 0,10,0
	mullw 0,0,9
	srawi 0,0,5
	bc 12,2,.L18
	lfs 12,4(8)
	cmpwi 7,0,1
	stfs 12,8(1)
	lfs 13,8(8)
	stfs 13,12(1)
	lfs 0,12(8)
	stfs 0,16(1)
	bc 4,30,.L19
	lis 9,.LC0@ha
	la 9,.LC0@l(9)
	lfs 0,0(9)
	fadds 13,13,0
	fadds 0,12,0
	b .L27
.L19:
	cmpwi 0,0,2
	bc 4,2,.L21
	lis 9,.LC0@ha
	la 9,.LC0@l(9)
	lfs 0,0(9)
	fsubs 13,13,0
	fadds 0,12,0
	b .L27
.L21:
	bc 4,30,.L20
	lis 9,.LC0@ha
	la 9,.LC0@l(9)
	lfs 0,0(9)
	fsubs 13,13,0
	fsubs 0,12,0
.L27:
	stfs 13,12(1)
	stfs 0,8(1)
.L20:
	lis 9,.LC0@ha
	lfs 0,16(1)
	la 9,.LC0@l(9)
	lfs 11,8(1)
	lfs 13,0(9)
	lfs 12,12(1)
	stfs 11,1004(3)
	fadds 0,0,13
	stw 8,412(3)
	stfs 12,1008(3)
	stfs 0,1012(3)
	stfs 0,16(1)
.L18:
	bl PutClientInServer
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe1:
	.size	 PutClientAtLatestRallyPoint,.Lfe1-PutClientAtLatestRallyPoint
	.section	".rodata"
	.align 2
.LC1:
	.long 0x46fffe00
	.align 3
.LC2:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC3:
	.long 0x3f800000
	.align 3
.LC4:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC5:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC6:
	.long 0x40490000
	.long 0x0
	.align 3
.LC7:
	.long 0x40590000
	.long 0x0
	.section	".text"
	.align 2
	.globl TempQuakeThink
	.type	 TempQuakeThink,@function
TempQuakeThink:
	stwu 1,-96(1)
	mflr 0
	stfd 28,64(1)
	stfd 29,72(1)
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 24,32(1)
	stw 0,100(1)
	lis 9,maxclients@ha
	lis 10,.LC3@ha
	lwz 11,maxclients@l(9)
	la 10,.LC3@l(10)
	mr 29,3
	lfs 13,0(10)
	li 26,1
	lis 24,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L41
	lis 9,.LC1@ha
	lis 11,.LC4@ha
	lfs 28,.LC1@l(9)
	lis 10,.LC6@ha
	la 11,.LC4@l(11)
	lis 9,.LC5@ha
	la 10,.LC6@l(10)
	lfd 31,0(11)
	la 9,.LC5@l(9)
	lfd 30,0(10)
	lis 25,g_edicts@ha
	lfd 29,0(9)
	lis 28,0x4330
	li 27,1084
.L43:
	lwz 0,g_edicts@l(25)
	add 31,0,27
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L42
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L42
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L42
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 4,2,.L42
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L42
	lwz 30,5184(9)
	cmpwi 0,30,0
	bc 4,2,.L42
	lfs 0,4(29)
	addi 3,1,8
	lfs 13,4(31)
	lfs 12,8(29)
	lfs 11,12(29)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(31)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(31)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	lfs 0,592(29)
	fcmpu 0,1,0
	bc 12,1,.L42
	stw 30,552(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,376(31)
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 28,24(1)
	lfd 13,24(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,29
	fadd 0,0,0
	fmadd 0,0,30,12
	frsp 0,0
	stfs 0,376(31)
	bl rand
	rlwinm 3,3,0,17,31
	lwz 0,400(31)
	xoris 3,3,0x8000
	mr 11,9
	lfs 11,380(31)
	stw 3,28(1)
	xoris 0,0,0x8000
	lis 10,.LC7@ha
	stw 28,24(1)
	la 10,.LC7@l(10)
	lfd 13,24(1)
	stw 0,28(1)
	stw 28,24(1)
	fsub 13,13,31
	lfd 12,24(1)
	lfd 10,0(10)
	frsp 13,13
	fsub 12,12,31
	fdivs 13,13,28
	fdiv 10,10,12
	fmr 0,13
	fsub 0,0,29
	fadd 0,0,0
	fmadd 0,0,30,11
	frsp 0,0
	stfs 0,380(31)
	lfs 13,328(29)
	fmul 13,13,10
	frsp 13,13
	stfs 13,384(31)
.L42:
	addi 26,26,1
	lwz 11,maxclients@l(24)
	xoris 0,26,0x8000
	addi 27,27,1084
	stw 0,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L43
.L41:
	lis 9,level+4@ha
	lfs 0,288(29)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L52
	fmr 0,13
	lis 9,.LC2@ha
	lfd 13,.LC2@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	b .L53
.L52:
	mr 3,29
	bl G_FreeEdict
.L53:
	lwz 0,100(1)
	mtlr 0
	lmw 24,32(1)
	lfd 28,64(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe2:
	.size	 TempQuakeThink,.Lfe2-TempQuakeThink
	.section	".rodata"
	.align 2
.LC8:
	.string	"temp_quake"
	.align 2
.LC9:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl CheckCoopAllDead
	.type	 CheckCoopAllDead,@function
CheckCoopAllDead:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	lis 9,game+1544@ha
	li 29,0
	lwz 0,game+1544@l(9)
	lis 25,game@ha
	cmpwi 0,0,0
	bc 4,1,.L72
	lis 11,g_edicts@ha
	mr 30,0
	lwz 9,g_edicts@l(11)
	addi 9,9,1084
.L74:
	mr 31,9
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L73
	lwz 0,84(31)
	cmpwi 0,0,0
	mr 11,0
	bc 12,2,.L73
	lwz 3,412(31)
	cmpwi 0,3,0
	bc 12,2,.L77
	cmpwi 0,29,0
	bc 12,2,.L103
	lfs 13,992(29)
	lfs 0,992(3)
	fcmpu 0,13,0
	bc 4,0,.L77
.L103:
	mr 29,3
.L77:
	lwz 0,1812(11)
	cmpwi 0,0,0
.L73:
	addic. 30,30,-1
	addi 9,9,1084
	bc 4,2,.L74
.L72:
	lis 9,game+1544@ha
	li 30,1
	lwz 0,game+1544@l(9)
	cmpw 0,30,0
	bc 12,1,.L86
	lis 9,level@ha
	lis 26,g_edicts@ha
	la 27,level@l(9)
	li 28,1084
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 31,0(9)
.L88:
	lwz 0,g_edicts@l(26)
	add 31,0,28
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L87
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L87
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 4,2,.L87
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 4,2,.L87
	lwz 0,5184(9)
	cmpwi 0,0,0
	bc 12,2,.L87
	cmpwi 0,29,0
	bc 12,2,.L94
	lfs 12,4(29)
	cmpwi 7,30,1
	stfs 12,8(1)
	lfs 13,8(29)
	stfs 13,12(1)
	lfs 0,12(29)
	stfs 0,16(1)
	bc 4,30,.L95
	fadds 0,12,31
	fadds 13,13,31
	b .L104
.L95:
	cmpwi 0,30,2
	bc 4,2,.L97
	fadds 0,12,31
	b .L105
.L97:
	bc 4,30,.L96
	fsubs 0,12,31
.L105:
	fsubs 13,13,31
.L104:
	stfs 0,8(1)
	stfs 13,12(1)
.L96:
	lfs 0,16(1)
	lfs 13,8(1)
	fadds 0,0,31
	stfs 0,16(1)
	stfs 13,1004(31)
	lfs 0,12(1)
	stfs 0,1008(31)
	lfs 13,16(1)
	stw 29,412(31)
	stfs 13,1012(31)
.L94:
	lwz 0,184(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	lwz 8,84(31)
	li 0,6
	li 11,32
	stw 0,80(31)
	li 10,14
	stb 11,16(8)
	lwz 9,84(31)
	stb 10,17(9)
	lfs 0,4(27)
	lwz 11,84(31)
	stfs 0,4888(11)
.L87:
	la 9,game@l(25)
	addi 30,30,1
	lwz 0,1544(9)
	addi 28,28,1084
	cmpw 0,30,0
	bc 4,1,.L88
.L86:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 CheckCoopAllDead,.Lfe3-CheckCoopAllDead
	.section	".rodata"
	.align 3
.LC11:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC12:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl rally_point_touch
	.type	 rally_point_touch,@function
rally_point_touch:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	lwz 0,84(4)
	mr 30,3
	cmpwi 0,0,0
	bc 12,2,.L107
	stw 30,412(4)
	lis 9,level@ha
	lis 25,level@ha
	la 7,level@l(9)
	lwz 0,532(30)
	lfs 0,4(7)
	cmpwi 0,0,1
	stfs 0,992(30)
	bc 12,2,.L109
	li 0,1
	lis 11,.LC11@ha
	stw 0,60(30)
	lis 9,rally_point_think@ha
	li 10,512
	stw 0,532(30)
	la 9,rally_point_think@l(9)
	lis 8,gi+72@ha
	lfs 0,4(7)
	lfd 13,.LC11@l(11)
	stw 9,436(30)
	stw 10,68(30)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	b .L107
.L109:
	lis 9,game+1544@ha
	li 29,1
	lwz 0,game+1544@l(9)
	lis 26,game@ha
	cmpw 0,29,0
	bc 12,1,.L107
	lis 9,.LC12@ha
	lis 27,g_edicts@ha
	la 9,.LC12@l(9)
	li 28,1084
	lfs 31,0(9)
.L113:
	lwz 0,g_edicts@l(27)
	add 31,0,28
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L112
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L112
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 4,2,.L112
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 4,2,.L112
	lwz 0,5184(9)
	cmpwi 0,0,0
	bc 12,2,.L112
	lfs 12,4(30)
	cmpwi 7,29,1
	lfs 13,8(30)
	lfs 0,12(30)
	stfs 12,8(1)
	stfs 13,12(1)
	stfs 0,16(1)
	bc 4,30,.L119
	fadds 0,12,31
	fadds 13,13,31
	b .L127
.L119:
	cmpwi 0,29,2
	bc 4,2,.L121
	fadds 0,12,31
	b .L128
.L121:
	bc 4,30,.L120
	fsubs 0,12,31
.L128:
	fsubs 13,13,31
.L127:
	stfs 0,8(1)
	stfs 13,12(1)
.L120:
	lfs 0,16(1)
	mr 3,31
	lfs 13,8(1)
	fadds 0,0,31
	stfs 0,16(1)
	stfs 13,1004(31)
	lfs 0,12(1)
	lwz 0,184(31)
	stfs 0,1008(31)
	rlwinm 0,0,0,0,30
	lfs 13,16(1)
	stw 0,184(31)
	stfs 13,1012(31)
	bl PutClientInServer
	lwz 7,84(31)
	li 0,6
	li 11,32
	stw 0,80(31)
	li 10,14
	la 8,level@l(25)
	stb 11,16(7)
	lwz 9,84(31)
	stb 10,17(9)
	lfs 0,4(8)
	lwz 9,84(31)
	stfs 0,4888(9)
	stw 30,412(31)
.L112:
	la 9,game@l(26)
	addi 29,29,1
	lwz 0,1544(9)
	addi 28,28,1084
	cmpw 0,29,0
	bc 4,1,.L113
.L107:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 rally_point_touch,.Lfe4-rally_point_touch
	.section	".rodata"
	.align 2
.LC13:
	.string	"models/flags/coop/tris.md2"
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl G_RunEditFrame
	.type	 G_RunEditFrame,@function
G_RunEditFrame:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 24,24(1)
	stw 0,68(1)
	lis 9,level@ha
	la 10,level@l(9)
	lwz 0,208(10)
	cmpwi 0,0,0
	bc 12,2,.L131
	bl ExitLevel
	b .L130
.L131:
	lis 9,globals@ha
	li 30,0
	la 9,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(9)
	lwz 31,g_edicts@l(11)
	cmpw 0,30,0
	bc 4,0,.L133
	mr 25,9
	mr 24,10
	lis 9,.LC14@ha
	li 26,0
	la 9,.LC14@l(9)
	lis 27,0x4330
	lfd 31,0(9)
	lis 28,maxclients@ha
	lis 29,0xbf80
.L135:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L134
	stw 31,292(24)
	lwz 9,552(31)
	lfs 0,4(31)
	lfs 12,8(31)
	cmpwi 0,9,0
	lfs 13,12(31)
	stfs 0,28(31)
	stfs 12,32(31)
	stfs 13,36(31)
	bc 12,2,.L137
	lwz 9,92(9)
	lwz 0,556(31)
	cmpw 0,9,0
	bc 12,2,.L137
	lwz 0,264(31)
	stw 26,552(31)
	andi. 9,0,3
	bc 4,2,.L137
	lwz 0,184(31)
	andi. 9,0,4
	bc 12,2,.L137
	mr 3,31
	bl M_CheckGround
.L137:
	cmpwi 0,30,0
	bc 4,1,.L139
	xoris 0,30,0x8000
	lwz 11,maxclients@l(28)
	stw 0,20(1)
	stw 27,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L139
	mr 3,31
	bl ClientBeginServerFrame
	b .L134
.L139:
	lwz 0,1016(31)
	cmpwi 0,0,0
	bc 4,2,.L140
	stw 29,428(31)
.L140:
	mr 3,31
	bl G_RunEntity
.L134:
	lwz 0,72(25)
	addi 30,30,1
	addi 31,31,1084
	cmpw 0,30,0
	bc 12,0,.L135
.L133:
	bl CheckDMRules
	bl CheckNeedPass
	bl ClientEndServerFrames
.L130:
	lwz 0,68(1)
	mtlr 0
	lmw 24,24(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 G_RunEditFrame,.Lfe5-G_RunEditFrame
	.section	".rodata"
	.align 2
.LC15:
	.string	"models/items/c_head/tris.md2"
	.align 2
.LC16:
	.string	"target_secret"
	.align 2
.LC17:
	.string	"trigger_"
	.align 2
.LC18:
	.long 0x43000000
	.align 2
.LC19:
	.long 0x3f000000
	.align 2
.LC20:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl CmdGotoSecret
	.type	 CmdGotoSecret,@function
CmdGotoSecret:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 24,24(1)
	stw 0,68(1)
	lis 9,.LC18@ha
	li 28,0
	la 9,.LC18@l(9)
	mr 30,3
	lfs 31,0(9)
	li 27,0
	mr 31,28
	lis 24,.LC16@ha
	lis 25,g_edicts@ha
	b .L144
.L146:
	lfs 0,4(30)
	addi 3,1,8
	lfs 13,4(31)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(31)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(31)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L144
	fmr 31,1
	mr 27,31
.L144:
	lis 5,.LC16@ha
	mr 3,31
	la 5,.LC16@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L146
	srawi 9,27,31
	lis 10,g_edicts@ha
	xor 0,9,27
	lis 11,0xa27a
	subf 0,0,9
	ori 11,11,52719
	srawi 0,0,31
	lwz 9,g_edicts@l(10)
	andc 10,30,0
	and 0,27,0
	or 27,0,10
	subf 9,9,27
	lis 10,globals@ha
	mullw 9,9,11
	la 26,globals@l(10)
	srawi 29,9,2
.L156:
	lwz 0,72(26)
	addi 29,29,1
	lwz 10,g_edicts@l(25)
	cmpw 7,29,0
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	neg 9,9
	addi 11,9,1
	and 9,29,9
	or 29,9,11
	mulli 0,29,1084
	add 31,10,0
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L152
	lwz 3,280(31)
	la 4,.LC16@l(24)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L160
.L152:
	cmpw 0,31,27
	bc 4,2,.L156
.L151:
	cmpwi 0,28,0
	bc 12,2,.L143
	lwz 3,280(28)
	lis 4,.LC17@ha
	la 4,.LC17@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L158
	lfs 0,224(28)
	lis 9,.LC19@ha
	addi 3,1,8
	lfs 13,212(28)
	la 9,.LC19@l(9)
	mr 4,3
	lfs 1,0(9)
	fadds 13,13,0
	stfs 13,8(1)
	lfs 13,228(28)
	lfs 0,216(28)
	fadds 0,0,13
	stfs 0,12(1)
	lfs 13,232(28)
	lfs 0,220(28)
	fadds 0,0,13
	stfs 0,16(1)
	bl VectorScale
	b .L159
.L160:
	mr 28,31
	b .L151
.L158:
	lfs 0,4(28)
	stfs 0,8(1)
	lfs 13,8(28)
	stfs 13,12(1)
	lfs 0,12(28)
	stfs 0,16(1)
.L159:
	lis 29,gi@ha
	mr 3,30
	la 29,gi@l(29)
	lwz 9,76(29)
	mtlr 9
	blrl
	lis 9,.LC20@ha
	lfs 11,16(1)
	li 0,0
	la 9,.LC20@l(9)
	lfs 12,8(1)
	li 10,20
	lfs 0,0(9)
	li 8,6
	mr 3,30
	lfs 13,12(1)
	lwz 11,84(30)
	fadds 0,11,0
	stfs 12,28(30)
	stfs 13,32(30)
	stw 0,376(30)
	stfs 0,12(30)
	stfs 12,4(30)
	stfs 13,8(30)
	stfs 11,36(30)
	stw 0,384(30)
	stw 0,380(30)
	stb 10,17(11)
	lwz 9,84(30)
	lbz 0,16(9)
	ori 0,0,32
	stb 0,16(9)
	stw 8,80(30)
	lwz 0,72(29)
	mtlr 0
	blrl
.L143:
	lwz 0,68(1)
	mtlr 0
	lmw 24,24(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 CmdGotoSecret,.Lfe6-CmdGotoSecret
	.section	".rodata"
	.align 2
.LC21:
	.string	"func_"
	.align 2
.LC22:
	.string	"func_areaportal"
	.align 2
.LC23:
	.string	"path_corner"
	.align 2
.LC24:
	.long 0x0
	.align 3
.LC25:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl StepShake
	.type	 StepShake,@function
StepShake:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	mr 30,3
	fmr 31,1
	bl G_Spawn
	mr. 31,3
	bc 12,2,.L54
	lis 9,.LC8@ha
	lis 10,.LC24@ha
	lfs 12,328(31)
	la 9,.LC8@l(9)
	la 10,.LC24@l(10)
	stw 9,280(31)
	lfs 0,0(30)
	lfs 13,0(10)
	stfs 0,4(31)
	fcmpu 0,12,13
	lfs 13,4(30)
	stfs 13,8(31)
	lfs 0,8(30)
	stfs 31,592(31)
	stfs 0,12(31)
	bc 4,2,.L56
	lis 0,0x4248
	stw 0,328(31)
.L56:
	lwz 0,184(31)
	lis 11,TempQuakeThink@ha
	lis 9,level+4@ha
	la 11,TempQuakeThink@l(11)
	lis 10,.LC25@ha
	ori 0,0,1
	stw 11,436(31)
	la 10,.LC25@l(10)
	mtlr 11
	stw 0,184(31)
	mr 3,31
	lfs 0,level+4@l(9)
	lfd 13,0(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,288(31)
	blrl
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L54:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 StepShake,.Lfe7-StepShake
	.section	".rodata"
	.align 2
.LC26:
	.long 0x43160000
	.align 2
.LC27:
	.long 0x41800000
	.align 2
.LC28:
	.long 0x41400000
	.align 2
.LC29:
	.long 0x41000000
	.align 3
.LC30:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC31:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl MonsterDropItem
	.type	 MonsterDropItem,@function
MonsterDropItem:
	stwu 1,-160(1)
	mflr 0
	stmw 22,120(1)
	stw 0,164(1)
	mr 28,3
	addi 26,1,24
	lfs 13,20(28)
	li 0,0
	mr 23,4
	lfs 0,24(28)
	mr 30,5
	mr 22,6
	addi 25,1,56
	addi 4,1,8
	stw 0,24(1)
	stfs 13,28(1)
	mr 31,7
	li 5,0
	stfs 0,32(1)
	li 6,0
	mr 3,26
	bl AngleVectors
	lis 9,.LC26@ha
	addi 3,1,8
	la 9,.LC26@l(9)
	addi 29,1,40
	lfs 1,0(9)
	addi 24,1,72
	addi 27,1,88
	mr 4,3
	bl VectorScale
	mr 6,27
	mr 3,26
	mr 4,25
	mr 5,24
	bl AngleVectors
	lis 9,.LC27@ha
	lfs 12,4(28)
	mr 4,27
	lfs 13,8(28)
	la 9,.LC27@l(9)
	mr 3,29
	lfs 0,12(28)
	mr 5,29
	lfs 1,0(9)
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
	bl VectorMA
	lis 9,.LC28@ha
	mr 4,25
	la 9,.LC28@l(9)
	mr 3,29
	lfs 1,0(9)
	mr 5,29
	bl VectorMA
	lis 9,.LC29@ha
	mr 4,24
	la 9,.LC29@l(9)
	mr 3,29
	lfs 1,0(9)
	mr 5,29
	bl VectorMA
	mr 3,28
	mr 4,23
	mr 5,29
	addi 6,1,8
	bl LaunchItem
	mr. 8,3
	bc 12,2,.L29
	xoris 0,31,0x8000
	stw 0,116(1)
	lis 11,0x4330
	lis 10,.LC30@ha
	la 10,.LC30@l(10)
	stw 11,112(1)
	mr 3,8
	lfd 12,0(10)
	lis 11,.LC31@ha
	lfd 0,112(1)
	la 11,.LC31@l(11)
	lis 10,level+4@ha
	lfs 13,level+4@l(10)
	lfs 11,0(11)
	fsub 0,0,12
	lis 11,gi+72@ha
	stw 30,532(8)
	stw 22,508(8)
	fadds 13,13,11
	frsp 0,0
	stfs 13,428(8)
	stfs 0,992(8)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L29:
	lwz 0,164(1)
	mtlr 0
	lmw 22,120(1)
	la 1,160(1)
	blr
.Lfe8:
	.size	 MonsterDropItem,.Lfe8-MonsterDropItem
	.align 2
	.globl G_TouchDeadBodies
	.type	 G_TouchDeadBodies,@function
G_TouchDeadBodies:
	stwu 1,-96(1)
	mflr 0
	stmw 28,80(1)
	stw 0,100(1)
	mr 31,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L30
	mr 8,31
	lis 9,gi@ha
	la 28,gi@l(9)
	addi 30,8,4
	li 29,0
	b .L32
.L36:
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L37
	lwz 0,184(3)
	andi. 9,0,2
	bc 12,2,.L37
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L37
	mr 4,31
	li 5,0
	mtlr 0
	li 6,0
	blrl
	b .L30
.L37:
	lwz 8,60(1)
	addi 29,29,1
.L32:
	cmpwi 0,29,7
	bc 12,1,.L30
	lwz 11,48(28)
	lis 9,0x600
	addi 3,1,8
	mr 4,30
	addi 5,31,188
	addi 6,31,200
	mr 7,30
	mtlr 11
	ori 9,9,3
	blrl
	lwz 3,60(1)
	cmpwi 0,3,0
	bc 4,2,.L36
.L30:
	lwz 0,100(1)
	mtlr 0
	lmw 28,80(1)
	la 1,96(1)
	blr
.Lfe9:
	.size	 G_TouchDeadBodies,.Lfe9-G_TouchDeadBodies
	.section	".rodata"
	.align 2
.LC32:
	.long 0x3f800000
	.align 2
.LC33:
	.long 0x42800000
	.align 3
.LC34:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CheckBox
	.type	 CheckBox,@function
CheckBox:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 26,40(1)
	stw 0,84(1)
	lis 11,.LC32@ha
	lis 9,maxclients@ha
	la 11,.LC32@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L59
	lis 9,.LC33@ha
	lis 11,.LC34@ha
	la 9,.LC33@l(9)
	la 11,.LC34@l(11)
	lfs 30,0(9)
	lis 27,g_edicts@ha
	lis 28,0x4330
	lfd 31,0(11)
	li 30,1084
.L61:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L60
	lwz 9,84(11)
	cmpwi 0,9,0
	bc 12,2,.L60
	cmpw 0,11,31
	bc 12,2,.L60
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 4,2,.L60
	lwz 0,260(11)
	cmpwi 0,0,1
	bc 12,2,.L60
	lwz 0,5184(9)
	cmpwi 0,0,0
	bc 4,2,.L60
	lfs 0,4(31)
	addi 3,1,8
	lfs 13,4(11)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(11)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(11)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	fcmpu 0,1,30
	bc 4,0,.L60
	li 3,1
	b .L181
.L60:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,1084
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L61
.L59:
	li 3,0
.L181:
	lwz 0,84(1)
	mtlr 0
	lmw 26,40(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe10:
	.size	 CheckBox,.Lfe10-CheckBox
	.section	".rodata"
	.align 3
.LC35:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 rally_point_think,@function
rally_point_think:
	lwz 9,56(3)
	lis 10,level+4@ha
	lis 11,.LC35@ha
	lfd 13,.LC35@l(11)
	addi 9,9,1
	srawi 0,9,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	addi 9,9,1
	stw 9,56(3)
	lfs 0,level+4@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe11:
	.size	 rally_point_think,.Lfe11-rally_point_think
	.section	".rodata"
	.align 2
.LC36:
	.long 0x43000000
	.section	".text"
	.align 2
	.globl SP_info_player_rally_point
	.type	 SP_info_player_rally_point,@function
SP_info_player_rally_point:
	stwu 1,-112(1)
	mflr 0
	stmw 27,92(1)
	stw 0,116(1)
	mr 29,3
	lis 0,0x41c0
	lis 9,0xc1c0
	lis 11,0xc180
	stw 0,208(29)
	lis 28,gi@ha
	stw 11,196(29)
	lis 4,.LC13@ha
	la 28,gi@l(28)
	stw 0,200(29)
	la 4,.LC13@l(4)
	stw 0,204(29)
	li 27,0
	stw 9,192(29)
	stw 9,188(29)
	lwz 9,44(28)
	mtlr 9
	blrl
	lis 10,.LC36@ha
	lis 11,rally_point_touch@ha
	lfs 13,12(29)
	la 10,.LC36@l(10)
	la 11,rally_point_touch@l(11)
	stw 27,60(29)
	li 0,1
	lfs 0,0(10)
	addi 3,1,8
	stw 0,248(29)
	li 5,0
	li 6,0
	stw 27,260(29)
	addi 7,1,72
	mr 8,29
	stw 11,444(29)
	fsubs 13,13,0
	li 9,3
	addi 4,29,4
	lwz 11,48(28)
	lfs 12,4(29)
	lfs 0,8(29)
	mtlr 11
	stfs 13,80(1)
	stfs 12,72(1)
	stfs 0,76(1)
	blrl
	lfs 0,28(1)
	mr 3,29
	lfs 13,208(29)
	lfs 11,20(1)
	lfs 12,24(1)
	fadds 0,0,13
	stw 27,532(29)
	stfs 11,4(29)
	stfs 12,8(29)
	stfs 0,12(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,116(1)
	mtlr 0
	lmw 27,92(1)
	la 1,112(1)
	blr
.Lfe12:
	.size	 SP_info_player_rally_point,.Lfe12-SP_info_player_rally_point
	.section	".rodata"
	.align 2
.LC37:
	.long 0x43000000
	.section	".text"
	.align 2
	.globl SP_temp_thing
	.type	 SP_temp_thing,@function
SP_temp_thing:
	stwu 1,-112(1)
	mflr 0
	stmw 28,96(1)
	stw 0,116(1)
	mr 29,3
	lis 0,0x41c0
	lis 9,0xc1c0
	lis 11,0xc180
	stw 0,208(29)
	lis 28,gi@ha
	stw 11,196(29)
	lis 4,.LC15@ha
	la 28,gi@l(28)
	stw 0,200(29)
	la 4,.LC15@l(4)
	stw 0,204(29)
	stw 9,192(29)
	stw 9,188(29)
	lwz 9,44(28)
	mtlr 9
	blrl
	li 11,2
	lwz 0,184(29)
	li 10,0
	stw 11,248(29)
	addi 3,1,8
	li 5,0
	lis 11,.LC37@ha
	lfs 13,12(29)
	ori 0,0,2
	la 11,.LC37@l(11)
	stw 0,184(29)
	li 6,0
	lfs 0,0(11)
	addi 7,1,72
	mr 8,29
	stw 10,260(29)
	li 9,3
	addi 4,29,4
	lwz 11,48(28)
	fsubs 13,13,0
	lfs 12,4(29)
	lfs 0,8(29)
	mtlr 11
	stfs 12,72(1)
	stfs 0,76(1)
	stfs 13,80(1)
	blrl
	lfs 13,28(1)
	mr 3,29
	lfs 0,208(29)
	lfs 12,20(1)
	lwz 0,64(29)
	fadds 13,13,0
	lfs 0,24(1)
	oris 0,0,0x4
	stfs 12,4(29)
	stfs 13,12(29)
	stfs 0,8(29)
	stw 0,64(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,116(1)
	mtlr 0
	lmw 28,96(1)
	la 1,112(1)
	blr
.Lfe13:
	.size	 SP_temp_thing,.Lfe13-SP_temp_thing
	.align 2
	.globl SVEdit_FixAreaPortals
	.type	 SVEdit_FixAreaPortals,@function
SVEdit_FixAreaPortals:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 9,globals@ha
	li 10,1
	la 8,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(8)
	lwz 9,g_edicts@l(11)
	cmpw 0,10,0
	addi 31,9,1084
	bc 4,0,.L163
	mr 25,8
	lis 26,.LC21@ha
.L165:
	lwz 0,88(31)
	addi 28,10,1
	addi 27,31,1084
	cmpwi 0,0,0
	bc 12,2,.L164
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L164
	lwz 3,280(31)
	la 4,.LC21@l(26)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L164
	li 30,0
	lis 29,.LC22@ha
.L172:
	lwz 5,296(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 12,2,.L164
	lwz 3,280(30)
	la 4,.LC22@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L172
	lwz 0,64(31)
	rlwinm 0,0,0,4,2
	stw 0,64(31)
.L164:
	lwz 0,72(25)
	mr 10,28
	mr 31,27
	cmpw 0,10,0
	bc 12,0,.L165
.L163:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe14:
	.size	 SVEdit_FixAreaPortals,.Lfe14-SVEdit_FixAreaPortals
	.align 2
	.globl SVEdit_DrawPaths
	.type	 SVEdit_DrawPaths,@function
SVEdit_DrawPaths:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	li 31,0
	b .L175
.L179:
	lfs 13,4(31)
	li 9,33
	li 11,1
	mr 3,10
	stfs 13,4(10)
	lfs 0,8(31)
	stfs 0,8(10)
	lfs 13,12(31)
	stfs 13,12(10)
	lwz 0,296(31)
	stw 9,284(10)
	stw 0,296(10)
	stw 11,1016(10)
	crxor 6,6,6
	bl SP_target_laser
.L175:
	lis 5,.LC23@ha
	mr 3,31
	la 5,.LC23@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 12,2,.L176
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L175
	bl G_Spawn
	mr. 10,3
	bc 4,2,.L179
.L176:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe15:
	.size	 SVEdit_DrawPaths,.Lfe15-SVEdit_DrawPaths
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
