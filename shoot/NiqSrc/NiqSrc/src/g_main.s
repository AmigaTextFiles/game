	.file	"g_main.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.globl exe_found
	.section	".sdata","aw"
	.align 2
	.type	 exe_found,@object
	.size	 exe_found,4
exe_found:
	.long 0
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
	stmw 21,20(1)
	stw 0,68(1)
	mr 4,3
	li 5,176
	lis 3,gi@ha
	la 3,gi@l(3)
	crxor 6,6,6
	bl memcpy
	lis 9,exe_found@ha
	lwz 0,exe_found@l(9)
	cmpwi 0,0,0
	bc 12,2,.L9
	lis 3,globals@ha
	lis 11,InitGame@ha
	la 9,globals@l(3)
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
	stw 0,globals@l(3)
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
	li 21,1332
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
	b .L10
.L9:
	li 3,0
.L10:
	lwz 0,68(1)
	mtlr 0
	lmw 21,20(1)
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
	bc 4,6,.L12
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L12:
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
	bc 4,6,.L14
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L14:
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
	.string	"next map: %s\n"
	.align 2
.LC3:
	.string	"target_changelevel"
	.section	".text"
	.align 2
	.globl EndDMLevel
	.type	 EndDMLevel,@function
EndDMLevel:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	bl EnitityListClean
	lis 31,level+136@ha
	lis 9,map_mod_@ha
	lwz 0,map_mod_@l(9)
	cmpwi 0,0,0
	bc 12,2,.L24
	bl map_mod_next_map
	mr. 4,3
	bc 12,2,.L24
	la 3,level+136@l(31)
	bl strcpy
.L24:
	lis 9,gi+4@ha
	lis 3,.LC2@ha
	lwz 0,gi+4@l(9)
	lis 4,level+136@ha
	la 3,.LC2@l(3)
	la 4,level+136@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,32
	bc 12,2,.L26
	bl G_Spawn
	lis 9,.LC3@ha
	lis 11,level+72@ha
	la 9,.LC3@l(9)
	la 11,level+72@l(11)
	stw 9,280(3)
	stw 11,504(3)
	b .L27
.L26:
	lis 9,level@ha
	la 31,level@l(9)
	lbz 0,136(31)
	cmpwi 0,0,0
	bc 12,2,.L28
	bl G_Spawn
	lis 9,.LC3@ha
	addi 0,31,136
	la 9,.LC3@l(9)
	stw 0,504(3)
	stw 9,280(3)
	b .L27
.L28:
	lis 30,.LC3@ha
	li 3,0
	li 4,280
	la 5,.LC3@l(30)
	bl G_Find
	mr. 3,3
	bc 4,2,.L27
	bl G_Spawn
	la 0,.LC3@l(30)
	addi 9,31,72
	stw 0,280(3)
	stw 9,504(3)
.L27:
	bl BeginIntermission
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 EndDMLevel,.Lfe4-EndDMLevel
	.section	".rodata"
	.align 2
.LC4:
	.string	"Timelimit hit.\n"
	.align 2
.LC6:
	.string	"Fraglimit hit.\n"
	.align 3
.LC5:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC7:
	.long 0x0
	.align 2
.LC8:
	.long 0x42700000
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CheckDMRules
	.type	 CheckDMRules,@function
CheckDMRules:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,level@ha
	lis 11,.LC7@ha
	la 11,.LC7@l(11)
	la 10,level@l(9)
	lfs 13,0(11)
	lfs 0,200(10)
	fcmpu 0,0,13
	bc 4,2,.L31
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L31
	lis 9,timelimit@ha
	lwz 11,timelimit@l(9)
	lfs 12,20(11)
	fcmpu 0,12,13
	bc 12,2,.L34
	lis 9,.LC8@ha
	lfs 13,4(10)
	la 9,.LC8@l(9)
	lfs 0,0(9)
	fmuls 0,12,0
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L34
	lis 4,.LC4@ha
	li 3,2
	la 4,.LC4@l(4)
	b .L47
.L34:
	lis 11,.LC7@ha
	lis 9,fraglimit@ha
	la 11,.LC7@l(11)
	lis 31,fraglimit@ha
	lfs 13,0(11)
	lwz 11,fraglimit@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L31
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L37
	bl CTFCheckRules
	cmpwi 0,3,0
	bc 12,2,.L37
	bl EndDMLevel
.L37:
	lis 11,.LC7@ha
	lis 9,maxclients@ha
	la 11,.LC7@l(11)
	li 7,0
	lfs 13,0(11)
	lis 12,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L31
	lis 9,.LC5@ha
	lis 11,game@ha
	lfd 11,.LC5@l(9)
	la 3,game@l(11)
	lis 5,g_edicts@ha
	lis 9,.LC9@ha
	lis 4,.LC6@ha
	la 9,.LC9@l(9)
	lis 6,0x4330
	lfd 12,0(9)
	li 8,0
	li 10,0
.L42:
	lwz 9,g_edicts@l(5)
	lwz 11,1028(3)
	add 9,8,9
	lwz 0,1420(9)
	add 11,11,10
	cmpwi 0,0,0
	bc 12,2,.L41
	lwz 9,fraglimit@l(31)
	lfs 13,3512(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 12,3,.L45
	fsubs 0,0,13
	fcmpu 0,0,11
	cror 3,2,0
	bc 4,3,.L41
.L45:
	la 4,.LC6@l(4)
	li 3,2
.L47:
	crxor 6,6,6
	bl my_bprintf
	bl EndDMLevel
	b .L31
.L41:
	addi 7,7,1
	lwz 11,maxclients@l(12)
	xoris 0,7,0x8000
	addi 8,8,1332
	stw 0,20(1)
	addi 10,10,3968
	stw 6,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L42
.L31:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 CheckDMRules,.Lfe5-CheckDMRules
	.section	".rodata"
	.align 2
.LC10:
	.string	"gamemap \"%s\"\n"
	.align 2
.LC11:
	.long 0x0
	.align 3
.LC12:
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
	lis 5,.LC10@ha
	la 29,level@l(29)
	addi 3,1,8
	lwz 6,204(29)
	la 5,.LC10@l(5)
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
	lis 9,.LC11@ha
	stw 0,208(29)
	la 9,.LC11@l(9)
	stw 0,204(29)
	lfs 13,0(9)
	stfs 13,200(29)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L56
	lis 11,.LC12@ha
	lis 28,g_edicts@ha
	la 11,.LC12@l(11)
	lis 30,0x4330
	lfd 31,0(11)
	li 29,1332
.L51:
	lwz 0,g_edicts@l(28)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L54
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L54
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L54
	bl ClientEndServerFrame
.L54:
	addi 31,31,1
	lwz 11,maxclients@l(27)
	xoris 0,31,0x8000
	addi 29,29,1332
	stw 0,284(1)
	stw 30,280(1)
	lfd 0,280(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L51
.L56:
	lis 11,.LC11@ha
	lis 9,maxclients@ha
	la 11,.LC11@l(11)
	li 10,0
	lfs 13,0(11)
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L58
	lis 9,g_edicts@ha
	mr 8,11
	lwz 11,g_edicts@l(9)
	lis 7,0x4330
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	addi 11,11,1332
	lfd 12,0(9)
.L60:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L59
	lwz 9,84(11)
	lwz 0,480(11)
	lwz 9,728(9)
	cmpw 0,0,9
	bc 4,1,.L59
	stw 9,480(11)
.L59:
	addi 10,10,1
	lfs 13,20(8)
	xoris 0,10,0x8000
	addi 11,11,1332
	stw 0,284(1)
	stw 7,280(1)
	lfd 0,280(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L60
.L58:
	bl CTFInit
	lwz 0,324(1)
	mtlr 0
	lmw 27,292(1)
	lfd 31,312(1)
	la 1,320(1)
	blr
.Lfe6:
	.size	 ExitLevel,.Lfe6-ExitLevel
	.globl execed_launcher_cfg
	.section	".sdata","aw"
	.align 2
	.type	 execed_launcher_cfg,@object
	.size	 execed_launcher_cfg,4
execed_launcher_cfg:
	.long 0
	.align 2
	.type	 last_ctf_teams.33,@object
	.size	 last_ctf_teams.33,4
last_ctf_teams.33:
	.long 0x0
	.section	".rodata"
	.align 3
.LC13:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC15:
	.long 0x0
	.section	".text"
	.align 2
	.globl G_RunFrame
	.type	 G_RunFrame,@function
G_RunFrame:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	lis 9,paused@ha
	lwz 0,paused@l(9)
	cmpwi 0,0,0
	bc 4,2,.L77
	lis 9,level@ha
	lis 11,last_ctf_teams.33@ha
	la 7,level@l(9)
	lfs 13,last_ctf_teams.33@l(11)
	lis 29,level@ha
	lfs 0,4(7)
	fcmpu 0,0,13
	bc 4,0,.L79
	li 0,0
	stw 0,last_ctf_teams.33@l(11)
.L79:
	lwz 9,level@l(29)
	lis 8,0x4330
	lis 11,.LC14@ha
	lfs 11,200(7)
	addi 9,9,1
	la 11,.LC14@l(11)
	xoris 0,9,0x8000
	lfd 12,0(11)
	stw 0,20(1)
	lis 11,.LC13@ha
	stw 8,16(1)
	lfd 0,16(1)
	lfd 13,.LC13@l(11)
	lis 11,.LC15@ha
	stw 9,level@l(29)
	fsub 0,0,12
	la 11,.LC15@l(11)
	lfs 10,0(11)
	fmul 0,0,13
	fcmpu 0,11,10
	frsp 13,0
	stfs 13,4(7)
	bc 12,2,.L80
	lis 9,niq_inttime@ha
	lwz 11,niq_inttime@l(9)
	lfs 0,20(11)
	fcmpu 0,0,10
	bc 12,2,.L80
	fadds 0,11,0
	fcmpu 0,13,0
	bc 4,1,.L80
	li 0,1
	stw 0,208(7)
.L80:
	lis 9,level+208@ha
	lwz 0,level+208@l(9)
	cmpwi 0,0,0
	bc 12,2,.L81
	bl ExitLevel
	b .L77
.L81:
	lis 9,globals+72@ha
	li 30,0
	lwz 0,globals+72@l(9)
	lis 11,g_edicts@ha
	lis 25,g_edicts@ha
	lwz 31,g_edicts@l(11)
	lis 26,globals@ha
	lis 28,maxclients@ha
	cmpw 0,30,0
	bc 4,0,.L83
	lis 27,0x4330
.L85:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L84
	la 9,level@l(29)
	lis 10,.LC15@ha
	la 10,.LC15@l(10)
	stw 31,292(9)
	lfs 13,0(10)
	lfs 0,28(31)
	fcmpu 0,0,13
	bc 4,2,.L87
	lfs 0,32(31)
	fcmpu 0,0,13
	bc 4,2,.L87
	lfs 0,36(31)
	fcmpu 0,0,13
	bc 4,2,.L87
	lfs 0,4(31)
	lfs 13,8(31)
	lfs 12,12(31)
	stfs 0,28(31)
	stfs 13,32(31)
	stfs 12,36(31)
.L87:
	lwz 9,552(31)
	cmpwi 0,9,0
	bc 12,2,.L88
	lwz 9,92(9)
	lwz 0,556(31)
	cmpw 0,9,0
	bc 12,2,.L88
	lwz 9,264(31)
	li 0,0
	stw 0,552(31)
	andi. 11,9,3
	bc 4,2,.L88
	lwz 0,184(31)
	andi. 9,0,4
	bc 12,2,.L88
	mr 3,31
	bl M_CheckGround
.L88:
	cmpwi 0,30,0
	bc 4,1,.L90
	xoris 0,30,0x8000
	lwz 11,maxclients@l(28)
	stw 0,20(1)
	lis 10,.LC14@ha
	la 10,.LC14@l(10)
	stw 27,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L90
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L90
	mr 3,31
	bl ClientBeginServerFrame
	lfs 0,4(31)
	lfs 13,8(31)
	lfs 12,12(31)
	stfs 0,28(31)
	stfs 13,32(31)
	stfs 12,36(31)
	b .L84
.L90:
	lfs 0,4(31)
	mr 3,31
	lfs 13,8(31)
	lfs 12,12(31)
	stfs 0,28(31)
	stfs 13,32(31)
	stfs 12,36(31)
	bl G_RunEntity
.L84:
	la 9,globals@l(26)
	addi 30,30,1
	lwz 0,72(9)
	addi 31,31,1332
	cmpw 0,30,0
	bc 12,0,.L85
.L83:
	bl CheckDMRules
	li 30,0
	lis 9,.LC15@ha
	lis 11,maxclients@ha
	la 9,.LC15@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L99
	lis 10,.LC14@ha
	lis 29,0x4330
	la 10,.LC14@l(10)
	li 31,1332
	lfd 31,0(10)
.L94:
	lwz 0,g_edicts@l(25)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L97
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L97
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L97
	bl ClientEndServerFrame
.L97:
	addi 30,30,1
	lwz 11,maxclients@l(28)
	xoris 0,30,0x8000
	addi 31,31,1332
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L94
.L99:
	lis 9,.LC15@ha
	lis 11,niq_enable@ha
	la 9,.LC15@l(9)
	lfs 13,0(9)
	lwz 9,niq_enable@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L77
	bl niq_checkiftimetochangeweapon
.L77:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe7:
	.size	 G_RunFrame,.Lfe7-G_RunFrame
	.globl DLL_ExportSymbols
	.section	".data"
	.align 2
	.type	 DLL_ExportSymbols,@object
DLL_ExportSymbols:
	.long dllFindResource
	.long .LC16
	.long dllLoadResource
	.long .LC17
	.long dllFreeResource
	.long .LC18
	.long GetGameAPI
	.long .LC19
	.long SetExeName
	.long .LC20
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC20:
	.string	"SetExeName"
	.align 2
.LC19:
	.string	"GetGameAPI"
	.align 2
.LC18:
	.string	"dllFreeResource"
	.align 2
.LC17:
	.string	"dllLoadResource"
	.align 2
.LC16:
	.string	"dllFindResource"
	.size	 DLL_ExportSymbols,48
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
	.comm	game,2392,4
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
	.comm	capturelimit,4,4
	.comm	passwd,4,4
	.comm	g_select_empty,4,4
	.comm	dedicated,4,4
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
	.comm	grapple,4,4
	.comm	view_weapons,4,4
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.comm	last_trail_time,4,4
	.comm	bot_frametime,8,8
	.comm	max_bots,4,4
	.comm	last_bot_spawn,4,4
	.comm	bot_male_names_used,4,4
	.comm	bot_female_names_used,4,4
	.comm	bot_count,4,4
	.comm	bot_teams,256,4
	.comm	total_teams,4,4
	.comm	the_client,4,4
	.comm	num_players,4,4
	.comm	players,1024,4
	.comm	weapons_head,4,4
	.comm	health_head,4,4
	.comm	bonus_head,4,4
	.comm	ammo_head,4,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_supershotgun,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	botinfo_list,4,4
	.comm	total_bots,4,4
	.comm	teambot_list,4,4
	.comm	paused,4,4
	.section	".text"
	.align 2
	.globl DLL_Init
	.type	 DLL_Init,@function
DLL_Init:
	li 3,1
	blr
.Lfe8:
	.size	 DLL_Init,.Lfe8-DLL_Init
	.align 2
	.globl DLL_DeInit
	.type	 DLL_DeInit,@function
DLL_DeInit:
	blr
.Lfe9:
	.size	 DLL_DeInit,.Lfe9-DLL_DeInit
	.comm	pTempFind,4,4
	.section	".rodata"
	.align 2
.LC21:
	.long 0x0
	.section	".text"
	.align 2
	.globl ShutdownGame
	.type	 ShutdownGame,@function
ShutdownGame:
	stwu 1,-336(1)
	mflr 0
	stmw 29,324(1)
	stw 0,340(1)
	lis 11,.LC21@ha
	lis 9,niq_enable@ha
	la 11,.LC21@l(11)
	lis 31,gi@ha
	lfs 13,0(11)
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L7
	lis 9,niq_logfile@ha
	lwz 11,niq_logfile@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L7
	addi 29,1,8
	lis 4,level@ha
	la 4,level@l(4)
	mr 3,29
	li 5,304
	crxor 6,6,6
	bl memcpy
	la 3,gi@l(31)
	mr 4,29
	bl sl_GameEnd
.L7:
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
	lwz 0,340(1)
	mtlr 0
	lmw 29,324(1)
	la 1,336(1)
	blr
.Lfe10:
	.size	 ShutdownGame,.Lfe10-ShutdownGame
	.section	".rodata"
	.align 2
.LC22:
	.long 0x0
	.align 3
.LC23:
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
	lis 11,.LC22@ha
	lis 9,maxclients@ha
	la 11,.LC22@l(11)
	li 30,0
	lfs 13,0(11)
	lis 27,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L17
	lis 9,.LC23@ha
	lis 28,g_edicts@ha
	la 9,.LC23@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,1332
.L19:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L18
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L18
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L18
	bl ClientEndServerFrame
.L18:
	addi 30,30,1
	lwz 11,maxclients@l(27)
	xoris 0,30,0x8000
	addi 31,31,1332
	stw 0,28(1)
	stw 29,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L19
.L17:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe11:
	.size	 ClientEndServerFrames,.Lfe11-ClientEndServerFrames
	.align 2
	.globl PlayerNameExists
	.type	 PlayerNameExists,@function
PlayerNameExists:
	stwu 1,-160(1)
	mflr 0
	stmw 26,136(1)
	stw 0,164(1)
	lis 9,num_players@ha
	li 30,0
	lwz 0,num_players@l(9)
	mr 27,3
	lis 26,num_players@ha
	cmpw 0,30,0
	bc 4,0,.L66
	lis 9,players@ha
	addi 31,1,8
	la 29,players@l(9)
	li 28,0
.L68:
	lwz 9,0(29)
	addi 3,1,8
	addi 29,29,4
	lwz 4,84(9)
	addi 4,4,700
	bl strcpy
	lbz 0,0(31)
	li 9,0
	cmpwi 0,0,0
	bc 12,2,.L70
	cmpwi 0,0,91
	bc 4,2,.L71
	stbx 9,31,9
	b .L70
.L71:
	addi 9,9,1
	lbzx 0,31,9
	cmpwi 0,0,0
	bc 12,2,.L70
	cmpwi 0,0,91
	bc 4,2,.L71
	stbx 28,31,9
.L70:
	addi 3,1,8
	mr 4,27
	bl strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L67
	li 3,1
	b .L107
.L67:
	lwz 0,num_players@l(26)
	addi 30,30,1
	cmpw 0,30,0
	bc 12,0,.L68
.L66:
	li 3,0
.L107:
	lwz 0,164(1)
	mtlr 0
	lmw 26,136(1)
	la 1,160(1)
	blr
.Lfe12:
	.size	 PlayerNameExists,.Lfe12-PlayerNameExists
	.align 2
	.globl SetExeName
	.type	 SetExeName,@function
SetExeName:
	lis 9,exe_found@ha
	li 0,1
	stw 0,exe_found@l(9)
	blr
.Lfe13:
	.size	 SetExeName,.Lfe13-SetExeName
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
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
