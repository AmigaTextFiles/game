	.file	"g_main.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"==== ShutdownGame ====\n"
	.section	".text"
	.align 2
	.globl GetGameAPI
	.type	 GetGameAPI,@function
GetGameAPI:
	stwu 1,-64(1)
	mflr 0
	stmw 20,16(1)
	stw 0,68(1)
	mr 4,3
	li 5,176
	lis 3,gi@ha
	la 3,gi@l(3)
	crxor 6,6,6
	bl memcpy
	lis 20,globals@ha
	lis 11,InitGame@ha
	la 9,globals@l(20)
	la 11,InitGame@l(11)
	lis 10,ShutdownGame@ha
	lis 8,SpawnEntities@ha
	stw 11,4(9)
	lis 7,WriteGame@ha
	lis 6,ReadGame@ha
	lis 5,WriteLevel@ha
	lis 4,ReadLevel@ha
	lis 29,ClientThink@ha
	lis 28,ClientConnect@ha
	lis 27,ClientUserinfoChanged@ha
	lis 26,ClientDisconnect@ha
	lis 25,ClientBegin@ha
	lis 24,ClientCommand@ha
	lis 23,G_RunFrame@ha
	lis 22,ServerCommand@ha
	li 0,3
	la 10,ShutdownGame@l(10)
	stw 0,globals@l(20)
	la 8,SpawnEntities@l(8)
	la 7,WriteGame@l(7)
	la 6,ReadGame@l(6)
	la 5,WriteLevel@l(5)
	stw 10,8(9)
	la 4,ReadLevel@l(4)
	la 29,ClientThink@l(29)
	stw 8,12(9)
	la 28,ClientConnect@l(28)
	la 27,ClientUserinfoChanged@l(27)
	stw 7,16(9)
	la 26,ClientDisconnect@l(26)
	la 25,ClientBegin@l(25)
	stw 6,20(9)
	la 24,ClientCommand@l(24)
	la 23,G_RunFrame@l(23)
	stw 5,24(9)
	la 22,ServerCommand@l(22)
	li 21,1076
	stw 4,28(9)
	mr 3,9
	stw 29,52(9)
	stw 28,32(9)
	stw 27,40(9)
	stw 26,44(9)
	stw 25,36(9)
	stw 24,48(9)
	stw 23,56(9)
	stw 22,60(9)
	stw 21,68(9)
	lwz 0,68(1)
	mtlr 0
	lmw 20,16(1)
	la 1,64(1)
	blr
.Lfe1:
	.size	 GetGameAPI,.Lfe1-GetGameAPI
	.section	".rodata"
	.align 2
.LC1:
	.string	"%s"
	.section	".text"
	.align 2
	.globl Sys_Error
	.type	 Sys_Error,@function
Sys_Error:
	stwu 1,-1184(1)
	mflr 0
	stmw 29,1172(1)
	stw 0,1188(1)
	lis 12,0x100
	addi 11,1,1192
	stw 4,12(1)
	addi 0,1,8
	stw 11,1156(1)
	stw 0,1160(1)
	stw 5,16(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	stw 12,1152(1)
	bc 4,6,.L9
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L9:
	addi 11,1,1152
	addi 9,1,112
	lwz 0,4(11)
	mr 4,3
	addi 29,1,128
	lwz 10,8(11)
	mr 5,9
	mr 3,29
	stw 12,112(1)
	stw 0,4(9)
	stw 10,8(9)
	bl vsprintf
	lis 9,gi+28@ha
	lis 4,.LC1@ha
	lwz 0,gi+28@l(9)
	la 4,.LC1@l(4)
	mr 5,29
	li 3,0
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,1188(1)
	mtlr 0
	lmw 29,1172(1)
	la 1,1184(1)
	blr
.Lfe2:
	.size	 Sys_Error,.Lfe2-Sys_Error
	.align 2
	.globl Com_Printf
	.type	 Com_Printf,@function
Com_Printf:
	stwu 1,-1184(1)
	mflr 0
	stmw 29,1172(1)
	stw 0,1188(1)
	lis 12,0x100
	addi 11,1,1192
	stw 4,12(1)
	addi 0,1,8
	stw 11,1156(1)
	stw 0,1160(1)
	stw 5,16(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	stw 12,1152(1)
	bc 4,6,.L11
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L11:
	addi 11,1,1152
	addi 9,1,112
	lwz 0,4(11)
	mr 4,3
	addi 29,1,128
	lwz 10,8(11)
	mr 5,9
	mr 3,29
	stw 12,112(1)
	stw 0,4(9)
	stw 10,8(9)
	bl vsprintf
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mr 4,29
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,1188(1)
	mtlr 0
	lmw 29,1172(1)
	la 1,1184(1)
	blr
.Lfe3:
	.size	 Com_Printf,.Lfe3-Com_Printf
	.section	".rodata"
	.align 2
.LC2:
	.string	"target_changelevel"
	.align 2
.LC3:
	.string	" ,\n\r"
	.section	".sdata","aw"
	.align 2
	.type	 seps.24,@object
	.size	 seps.24,4
seps.24:
	.long .LC3
	.section	".text"
	.align 2
	.globl EndDMLevel
	.type	 EndDMLevel,@function
EndDMLevel:
	stwu 1,-80(1)
	mflr 0
	stmw 21,36(1)
	stw 0,84(1)
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,32
	bc 12,2,.L22
	lis 29,level+72@ha
	la 29,level+72@l(29)
	bl G_Spawn
	lis 9,.LC2@ha
	mr 28,3
	la 9,.LC2@l(9)
	lis 5,.LC1@ha
	addi 3,29,64
	mr 6,29
	stw 9,280(28)
	la 5,.LC1@l(5)
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	addi 29,29,64
	mr 3,28
	stw 29,504(28)
	bl BeginIntermission
	b .L21
.L22:
	lis 9,sv_maplist@ha
	lis 21,.LC2@ha
	lwz 11,sv_maplist@l(9)
	lwz 3,4(11)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L24
	bl strdup
	li 31,0
	lis 25,seps.24@ha
	lis 9,seps.24@ha
	mr 22,3
	lwz 4,seps.24@l(9)
	bl strtok
	mr. 28,3
	bc 12,2,.L26
	lis 29,level+72@ha
	la 26,.LC2@l(21)
	la 27,level+72@l(29)
	lis 30,.LC1@ha
	addi 23,27,64
	lis 24,level+136@ha
.L27:
	mr 3,28
	la 4,level+72@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L28
	lwz 4,seps.24@l(25)
	li 3,0
	bl strtok
	mr. 28,3
	bc 4,2,.L29
	cmpwi 0,31,0
	bc 4,2,.L30
	bl G_Spawn
	mr 29,3
	la 5,.LC1@l(30)
	addi 3,27,64
	stw 26,280(29)
	mr 6,27
	b .L43
.L30:
	bl G_Spawn
	mr 29,3
	la 5,.LC1@l(30)
	la 3,level+136@l(24)
	stw 26,280(29)
	mr 6,31
.L43:
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	stw 23,504(29)
	mr 3,29
	bl BeginIntermission
	b .L34
.L29:
	bl G_Spawn
	mr 29,3
	la 5,.LC1@l(30)
	la 3,level+136@l(24)
	stw 26,280(29)
	mr 6,28
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	stw 23,504(29)
	mr 3,29
	bl BeginIntermission
.L34:
	mr 3,22
	bl free
	b .L21
.L28:
	srawi 9,31,31
	lwz 4,seps.24@l(25)
	li 3,0
	xor 0,9,31
	subf 0,0,9
	srawi 0,0,31
	andc 9,28,0
	and 0,31,0
	or 31,0,9
	bl strtok
	mr. 28,3
	bc 4,2,.L27
.L26:
	mr 3,22
	bl free
.L24:
	lis 9,level@ha
	la 28,level@l(9)
	lbz 0,136(28)
	cmpwi 0,0,0
	bc 12,2,.L38
	bl G_Spawn
	addi 28,28,136
	lis 9,.LC2@ha
	mr 29,3
	la 9,.LC2@l(9)
	lis 5,.LC1@ha
	mr 3,28
	stw 9,280(29)
	la 5,.LC1@l(5)
	li 4,64
	mr 6,28
	crxor 6,6,6
	bl Com_sprintf
	stw 28,504(29)
	mr 3,29
	bl BeginIntermission
	b .L21
.L38:
	lis 5,.LC2@ha
	li 3,0
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 3,3
	bc 4,2,.L41
	bl G_Spawn
	mr 29,3
	la 0,.LC2@l(21)
	lis 5,.LC1@ha
	stw 0,280(29)
	addi 3,28,136
	addi 6,28,72
	la 5,.LC1@l(5)
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	addi 0,28,136
	mr 3,29
	stw 0,504(29)
	bl BeginIntermission
	b .L21
.L41:
	bl BeginIntermission
.L21:
	lwz 0,84(1)
	mtlr 0
	lmw 21,36(1)
	la 1,80(1)
	blr
.Lfe4:
	.size	 EndDMLevel,.Lfe4-EndDMLevel
	.section	".rodata"
	.align 2
.LC4:
	.string	"none"
	.align 2
.LC5:
	.string	"needpass"
	.align 2
.LC6:
	.string	"%d"
	.section	".text"
	.align 2
	.globl CheckNeedPass
	.type	 CheckNeedPass,@function
CheckNeedPass:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,password@ha
	lis 29,spectator_password@ha
	lwz 8,password@l(9)
	lwz 0,16(8)
	cmpwi 0,0,0
	bc 4,2,.L46
	lwz 9,spectator_password@l(29)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L45
.L46:
	lis 9,spectator_password@ha
	li 10,0
	lwz 11,spectator_password@l(9)
	li 31,0
	stw 10,16(11)
	lwz 3,4(8)
	stw 10,16(8)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L47
	lis 4,.LC4@ha
	la 4,.LC4@l(4)
	bl Q_stricmp
	addic 0,3,-1
	subfe 31,0,3
.L47:
	lwz 9,spectator_password@l(29)
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L48
	lis 4,.LC4@ha
	la 4,.LC4@l(4)
	bl Q_stricmp
	addic 3,3,-1
	subfe 3,3,3
	ori 0,31,2
	andc 0,0,3
	and 3,31,3
	or 31,3,0
.L48:
	lis 29,gi@ha
	lis 3,.LC6@ha
	la 29,gi@l(29)
	mr 4,31
	la 3,.LC6@l(3)
	crxor 6,6,6
	bl va
	mr 4,3
	lwz 0,148(29)
	lis 3,.LC5@ha
	la 3,.LC5@l(3)
	mtlr 0
	blrl
.L45:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 CheckNeedPass,.Lfe5-CheckNeedPass
	.section	".rodata"
	.align 2
.LC7:
	.string	"Timelimit hit.\n"
	.align 2
.LC8:
	.string	"Fraglimit hit.\n"
	.align 2
.LC9:
	.long 0x0
	.align 2
.LC10:
	.long 0x42700000
	.align 3
.LC11:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CheckDMRules
	.type	 CheckDMRules,@function
CheckDMRules:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,level@ha
	lis 11,.LC9@ha
	la 11,.LC9@l(11)
	la 10,level@l(9)
	lfs 13,0(11)
	lfs 0,200(10)
	fcmpu 0,0,13
	bc 4,2,.L49
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L49
	lis 9,timelimit@ha
	lwz 11,timelimit@l(9)
	lfs 12,20(11)
	fcmpu 0,12,13
	bc 12,2,.L52
	lis 9,.LC10@ha
	lfs 13,4(10)
	la 9,.LC10@l(9)
	lfs 0,0(9)
	fmuls 0,12,0
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L52
	lis 4,.LC7@ha
	li 3,2
	la 4,.LC7@l(4)
	b .L65
.L64:
	lis 4,.LC8@ha
	li 3,2
	la 4,.LC8@l(4)
.L65:
	crxor 6,6,6
	bl safe_bprintf
	bl EndDMLevel
	b .L49
.L52:
	lis 11,.LC9@ha
	lis 9,fraglimit@ha
	la 11,.LC9@l(11)
	lfs 13,0(11)
	lwz 11,fraglimit@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L49
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L55
	bl CTFCheckRules
	cmpwi 0,3,0
	bc 12,2,.L55
	bl EndDMLevel
.L55:
	lis 11,.LC9@ha
	lis 9,maxclients@ha
	la 11,.LC9@l(11)
	li 7,0
	lfs 0,0(11)
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	bc 4,0,.L49
	lis 9,game+1028@ha
	lis 11,g_edicts@ha
	fmr 11,13
	lwz 8,game+1028@l(9)
	lis 10,fraglimit@ha
	lis 6,0x4330
	lwz 9,g_edicts@l(11)
	lis 11,.LC11@ha
	lwz 10,fraglimit@l(10)
	addi 8,8,4032
	la 11,.LC11@l(11)
	lfd 12,0(11)
	addi 11,9,1164
.L60:
	lwz 0,0(11)
	addi 11,11,1076
	cmpwi 0,0,0
	bc 12,2,.L59
	lwz 0,0(8)
	lfs 13,20(10)
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 12,3,.L64
.L59:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,4956
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,11
	bc 12,0,.L60
.L49:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 CheckDMRules,.Lfe6-CheckDMRules
	.section	".rodata"
	.align 2
.LC12:
	.string	"gamemap \"%s\"\n"
	.align 2
.LC13:
	.long 0x0
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ExitLevel
	.type	 ExitLevel,@function
ExitLevel:
	stwu 1,-320(1)
	mflr 0
	stfd 31,312(1)
	stmw 27,292(1)
	stw 0,324(1)
	lis 29,level@ha
	lis 5,.LC12@ha
	la 29,level@l(29)
	addi 3,1,8
	lwz 6,204(29)
	la 5,.LC12@l(5)
	li 4,256
	li 31,0
	lis 27,maxclients@ha
	crxor 6,6,6
	bl Com_sprintf
	lis 9,gi+168@ha
	addi 3,1,8
	lwz 0,gi+168@l(9)
	mtlr 0
	blrl
	lis 9,maxclients@ha
	li 0,0
	lwz 11,maxclients@l(9)
	lis 9,.LC13@ha
	stw 0,208(29)
	la 9,.LC13@l(9)
	stw 0,204(29)
	lfs 13,0(9)
	stfs 13,200(29)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L74
	lis 11,.LC14@ha
	lis 28,g_edicts@ha
	la 11,.LC14@l(11)
	lis 30,0x4330
	lfd 31,0(11)
	li 29,1076
.L69:
	lwz 0,g_edicts@l(28)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L72
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L72
	bl ClientEndServerFrame
.L72:
	addi 31,31,1
	lwz 11,maxclients@l(27)
	xoris 0,31,0x8000
	addi 29,29,1076
	stw 0,284(1)
	stw 30,280(1)
	lfd 0,280(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L69
.L74:
	lis 11,.LC13@ha
	lis 9,maxclients@ha
	la 11,.LC13@l(11)
	li 10,0
	lfs 13,0(11)
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L76
	lis 9,g_edicts@ha
	mr 8,11
	lwz 11,g_edicts@l(9)
	lis 7,0x4330
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	addi 11,11,1076
	lfd 12,0(9)
.L78:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L77
	lwz 9,84(11)
	lwz 0,480(11)
	lwz 9,728(9)
	cmpw 0,0,9
	bc 4,1,.L77
	stw 9,480(11)
.L77:
	addi 10,10,1
	lfs 13,20(8)
	xoris 0,10,0x8000
	addi 11,11,1076
	stw 0,284(1)
	stw 7,280(1)
	lfd 0,280(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L78
.L76:
	bl CTFInit
	lwz 0,324(1)
	mtlr 0
	lmw 27,292(1)
	lfd 31,312(1)
	la 1,320(1)
	blr
.Lfe7:
	.size	 ExitLevel,.Lfe7-ExitLevel
	.section	".rodata"
	.align 2
.LC15:
	.string	"\nsetting up SWTC AI tables v1.0.00\n"
	.align 2
.LC16:
	.string	"\nCreated by Legion\n"
	.align 2
.LC17:
	.string	"setup complete.\n"
	.align 3
.LC18:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC19:
	.long 0x42f00000
	.align 2
.LC20:
	.long 0x40e00000
	.align 2
.LC21:
	.long 0x40400000
	.align 2
.LC22:
	.long 0x0
	.align 3
.LC23:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl G_RunFrame
	.type	 G_RunFrame,@function
G_RunFrame:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 24,24(1)
	stw 0,68(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	la 31,level@l(9)
	cmpwi 0,0,0
	bc 4,2,.L83
	lis 29,gi@ha
	lis 3,.LC15@ha
	la 29,gi@l(29)
	la 3,.LC15@l(3)
	lwz 11,4(29)
	lis 9,num_players@ha
	stw 0,num_players@l(9)
	mtlr 11
	crxor 6,6,6
	blrl
	lwz 9,4(29)
	lis 3,.LC16@ha
	la 3,.LC16@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	bl initialize_tables
	lis 11,.LC20@ha
	lis 9,.LC19@ha
	lfs 13,4(31)
	la 11,.LC20@l(11)
	la 9,.LC19@l(9)
	lfs 0,0(11)
	lfs 12,0(9)
	lis 11,path_time@ha
	lis 9,path_not_time_yet@ha
	fadds 0,13,0
	fadds 13,13,12
	stfs 0,path_not_time_yet@l(9)
	stfs 13,path_time@l(11)
	bl allocate_trail_edicts
	bl cmd_Load_f
	lwz 0,4(29)
	lis 3,.LC17@ha
	la 3,.LC17@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L83:
	lis 9,.LC21@ha
	lfs 13,4(31)
	la 9,.LC21@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L84
	lis 9,.LC22@ha
	lis 11,deathmatch@ha
	la 9,.LC22@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L84
	bl setup_item_table
.L84:
	lis 10,level@ha
	lwz 9,level@l(10)
	lis 7,0x4330
	lis 11,.LC23@ha
	la 11,.LC23@l(11)
	la 30,level@l(10)
	addi 9,9,1
	lfd 12,0(11)
	xoris 0,9,0x8000
	lis 11,.LC18@ha
	stw 9,level@l(10)
	stw 0,20(1)
	stw 7,16(1)
	lfd 0,16(1)
	lfd 13,.LC18@l(11)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,4(30)
	bl AI_SetSightClient
	lwz 0,208(30)
	cmpwi 0,0,0
	bc 12,2,.L85
	bl ExitLevel
	b .L82
.L85:
	lis 9,globals@ha
	li 31,0
	la 9,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(9)
	lis 24,g_edicts@ha
	lis 28,maxclients@ha
	lwz 29,g_edicts@l(11)
	cmpw 0,31,0
	bc 4,0,.L87
	mr 26,9
	mr 25,30
	lis 9,.LC23@ha
	li 27,0
	la 9,.LC23@l(9)
	lis 30,0x4330
	lfd 31,0(9)
.L89:
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L88
	stw 29,292(25)
	lwz 9,552(29)
	lfs 0,4(29)
	lfs 12,8(29)
	cmpwi 0,9,0
	lfs 13,12(29)
	stfs 0,28(29)
	stfs 12,32(29)
	stfs 13,36(29)
	bc 12,2,.L91
	lwz 9,92(9)
	lwz 0,556(29)
	cmpw 0,9,0
	bc 12,2,.L91
	lwz 0,264(29)
	stw 27,552(29)
	andi. 11,0,3
	bc 4,2,.L91
	lwz 0,184(29)
	andi. 9,0,4
	bc 12,2,.L91
	mr 3,29
	bl M_CheckGround
.L91:
	cmpwi 0,31,0
	bc 4,1,.L93
	xoris 0,31,0x8000
	lwz 11,maxclients@l(28)
	stw 0,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L93
	mr 3,29
	bl ClientBeginServerFrame
.L93:
	mr 3,29
	bl G_RunEntity
.L88:
	lwz 0,72(26)
	addi 31,31,1
	addi 29,29,1076
	cmpw 0,31,0
	bc 12,0,.L89
.L87:
	bl CheckDMRules
	li 31,0
	bl CheckNeedPass
	lis 9,.LC22@ha
	lis 11,maxclients@ha
	la 9,.LC22@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L82
	lis 11,.LC23@ha
	lis 30,0x4330
	la 11,.LC23@l(11)
	li 29,1076
	lfd 31,0(11)
.L97:
	lwz 0,g_edicts@l(24)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L100
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L100
	bl ClientEndServerFrame
.L100:
	addi 31,31,1
	lwz 11,maxclients@l(28)
	xoris 0,31,0x8000
	addi 29,29,1076
	stw 0,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L97
.L82:
	lwz 0,68(1)
	mtlr 0
	lmw 24,24(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 G_RunFrame,.Lfe8-G_RunFrame
	.globl DLL_ExportSymbols
	.section	".data"
	.align 2
	.type	 DLL_ExportSymbols,@object
DLL_ExportSymbols:
	.long dllFindResource
	.long .LC24
	.long dllLoadResource
	.long .LC25
	.long dllFreeResource
	.long .LC26
	.long GetGameAPI
	.long .LC27
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC27:
	.string	"GetGameAPI"
	.align 2
.LC26:
	.string	"dllFreeResource"
	.align 2
.LC25:
	.string	"dllLoadResource"
	.align 2
.LC24:
	.string	"dllFindResource"
	.size	 DLL_ExportSymbols,40
	.globl DLL_ImportSymbols
	.section	".data"
	.align 2
	.type	 DLL_ImportSymbols,@object
DLL_ImportSymbols:
	.long 0
	.long 0
	.long 0
	.long 0
	.size	 DLL_ImportSymbols,16
	.comm	node_count,2,2
	.comm	path_not_time_yet,4,4
	.comm	game,1564,4
	.comm	level,304,4
	.comm	gi,176,4
	.comm	globals,80,4
	.comm	st,68,4
	.comm	sm_meat_index,4,4
	.comm	snd_fry,4,4
	.comm	meansOfDeath,4,4
	.comm	g_edicts,4,4
	.comm	maxentities,4,4
	.comm	deathmatch,4,4
	.comm	coop,4,4
	.comm	dmflags,4,4
	.comm	skill,4,4
	.comm	fraglimit,4,4
	.comm	timelimit,4,4
	.comm	password,4,4
	.comm	spectator_password,4,4
	.comm	needpass,4,4
	.comm	g_select_empty,4,4
	.comm	dedicated,4,4
	.comm	filterban,4,4
	.comm	sv_gravity,4,4
	.comm	sv_maxvelocity,4,4
	.comm	gun_x,4,4
	.comm	gun_y,4,4
	.comm	gun_z,4,4
	.comm	sv_rollspeed,4,4
	.comm	sv_rollangle,4,4
	.comm	run_pitch,4,4
	.comm	run_roll,4,4
	.comm	bob_up,4,4
	.comm	bob_pitch,4,4
	.comm	bob_roll,4,4
	.comm	sv_cheats,4,4
	.comm	maxclients,4,4
	.comm	maxspectators,4,4
	.comm	flood_msgs,4,4
	.comm	flood_persecond,4,4
	.comm	flood_waitdelay,4,4
	.comm	sv_maplist,4,4
	.comm	zoomall,4,4
	.comm	fog,4,4
	.comm	trailtime,4,4
	.comm	capturelimit,4,4
	.comm	sv_botskill,4,4
	.comm	saberonly,4,4
	.comm	theforce,4,4
	.comm	coolgrav,4,4
	.comm	p_weap,4,4
	.comm	mouse_s,4,4
	.comm	advanced,4,4
	.comm	conversation_content,7760,4
	.comm	highlighted,4,4
	.comm	yeah_you,4,4
	.comm	its_me,4,4
	.comm	holdthephone,4,4
	.comm	NoTouch,4,4
	.comm	showingit,4,4
	.comm	path_time,4,4
	.comm	print_time,4,4
	.section	".text"
	.align 2
	.globl DLL_Init
	.type	 DLL_Init,@function
DLL_Init:
	stwu 1,-160(1)
	lis 9,DOSBase@ha
	lis 11,PowerPCBase@ha
	lwz 10,DOSBase@l(9)
	li 0,0
	addi 4,1,8
	li 9,-492
	lwz 3,PowerPCBase@l(11)
	stw 9,12(1)
	stw 10,8(1)
	stw 0,16(1)
	stw 10,84(1)
	stw 0,20(1)
	stw 0,24(1)
	lwz 0,-298(3)
	
	stwu	1,-32(1)
	mflr	12
	stw	12,28(1)
	mfcr	12
	stw	12,24(1)
	mtlr	0
	blrl
	lwz	12,24(1)
	mtcr	12
	lwz	12,28(1)
	mtlr	12
	la	1,32(1)
	
	lwz 9,28(1)
	cmpwi 0,9,0
	bc 12,2,.L107
	lwz 0,60(9)
	li 3,1
	lis 9,SegList@ha
	stw 0,SegList@l(9)
	b .L109
.L107:
	li 3,0
.L109:
	la 1,160(1)
	blr
.Lfe9:
	.size	 DLL_Init,.Lfe9-DLL_Init
	.align 2
	.globl DLL_DeInit
	.type	 DLL_DeInit,@function
DLL_DeInit:
	blr
.Lfe10:
	.size	 DLL_DeInit,.Lfe10-DLL_DeInit
	.align 2
	.globl ShutdownGame
	.type	 ShutdownGame,@function
ShutdownGame:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 29,gi@ha
	lis 3,.LC0@ha
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	lwz 9,4(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,140(29)
	li 3,766
	mtlr 9
	blrl
	lwz 0,140(29)
	li 3,765
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 ShutdownGame,.Lfe11-ShutdownGame
	.section	".rodata"
	.align 2
.LC28:
	.long 0x0
	.align 3
.LC29:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ClientEndServerFrames
	.type	 ClientEndServerFrames,@function
ClientEndServerFrames:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	lis 11,.LC28@ha
	lis 9,maxclients@ha
	la 11,.LC28@l(11)
	li 30,0
	lfs 13,0(11)
	lis 27,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L14
	lis 9,.LC29@ha
	lis 28,g_edicts@ha
	la 9,.LC29@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,1076
.L16:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L15
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L15
	bl ClientEndServerFrame
.L15:
	addi 30,30,1
	lwz 11,maxclients@l(27)
	xoris 0,30,0x8000
	addi 31,31,1076
	stw 0,28(1)
	stw 29,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L16
.L14:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe12:
	.size	 ClientEndServerFrames,.Lfe12-ClientEndServerFrames
	.align 2
	.globl CreateTargetChangeLevel
	.type	 CreateTargetChangeLevel,@function
CreateTargetChangeLevel:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 27,3
	lis 28,level+136@ha
	bl G_Spawn
	lis 9,.LC2@ha
	mr 29,3
	la 9,.LC2@l(9)
	lis 5,.LC1@ha
	la 3,level+136@l(28)
	stw 9,280(29)
	la 5,.LC1@l(5)
	mr 6,27
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	la 28,level+136@l(28)
	mr 3,29
	stw 28,504(29)
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 CreateTargetChangeLevel,.Lfe13-CreateTargetChangeLevel
	.align 2
	.globl dllFindResource
	.type	 dllFindResource,@function
dllFindResource:
	li 3,0
	blr
.Lfe14:
	.size	 dllFindResource,.Lfe14-dllFindResource
	.align 2
	.globl dllLoadResource
	.type	 dllLoadResource,@function
dllLoadResource:
	li 3,0
	blr
.Lfe15:
	.size	 dllLoadResource,.Lfe15-dllLoadResource
	.align 2
	.globl dllFreeResource
	.type	 dllFreeResource,@function
dllFreeResource:
	blr
.Lfe16:
	.size	 dllFreeResource,.Lfe16-dllFreeResource
	.comm	SegList,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
