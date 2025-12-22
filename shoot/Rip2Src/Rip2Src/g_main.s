	.file	"g_main.c"
gcc2_compiled.:
	.globl exe_found
	.section	".sdata","aw"
	.align 2
	.type	 exe_found,@object
	.size	 exe_found,4
exe_found:
	.long 0
	.globl ini_file
	.section	".data"
	.align 2
	.type	 ini_file,@object
	.size	 ini_file,36
ini_file:
	.long 0
	.long 0
	.byte 0
	.space	3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
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
	bc 12,2,.L8
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
	li 21,1116
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
	b .L9
.L8:
	li 3,0
.L9:
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
	bc 4,6,.L13
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L13:
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
	stwu 1,-64(1)
	mflr 0
	stmw 22,24(1)
	stw 0,68(1)
	lis 9,game@ha
	li 29,0
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,29,0
	bc 4,0,.L24
	mr 30,9
	lis 31,g_edicts@ha
	li 28,1116
.L26:
	lwz 0,g_edicts@l(31)
	add 3,0,28
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L25
	bl Menu_Close
.L25:
	lwz 0,1544(30)
	addi 29,29,1
	addi 28,28,1116
	cmpw 0,29,0
	bc 12,0,.L26
.L24:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,32
	bc 12,2,.L29
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
	b .L22
.L29:
	lis 9,sv_maplist@ha
	lwz 11,sv_maplist@l(9)
	lwz 3,4(11)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L31
	bl strdup
	li 31,0
	lis 24,seps.24@ha
	lis 9,seps.24@ha
	mr 23,3
	lwz 4,seps.24@l(9)
	bl strtok
	mr. 28,3
	bc 12,2,.L33
	lis 29,level+72@ha
	lis 9,.LC2@ha
	la 27,level+72@l(29)
	la 26,.LC2@l(9)
	addi 22,27,64
	lis 30,.LC1@ha
	lis 25,level+136@ha
.L34:
	mr 3,28
	la 4,level+72@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L35
	lwz 4,seps.24@l(24)
	li 3,0
	bl strtok
	mr. 28,3
	bc 4,2,.L36
	cmpwi 0,31,0
	bc 4,2,.L37
	bl G_Spawn
	mr 29,3
	la 5,.LC1@l(30)
	addi 3,27,64
	stw 26,280(29)
	mr 6,27
	b .L50
.L37:
	bl G_Spawn
	mr 29,3
	la 5,.LC1@l(30)
	la 3,level+136@l(25)
	stw 26,280(29)
	mr 6,31
.L50:
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	stw 22,504(29)
	mr 3,29
	bl BeginIntermission
	b .L41
.L36:
	bl G_Spawn
	mr 29,3
	la 5,.LC1@l(30)
	la 3,level+136@l(25)
	stw 26,280(29)
	mr 6,28
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	stw 22,504(29)
	mr 3,29
	bl BeginIntermission
.L41:
	mr 3,23
	bl free
	b .L22
.L35:
	srawi 9,31,31
	lwz 4,seps.24@l(24)
	li 3,0
	xor 0,9,31
	subf 0,0,9
	srawi 0,0,31
	andc 9,28,0
	and 0,31,0
	or 31,0,9
	bl strtok
	mr. 28,3
	bc 4,2,.L34
.L33:
	mr 3,23
	bl free
.L31:
	lis 9,level@ha
	la 28,level@l(9)
	lbz 0,136(28)
	cmpwi 0,0,0
	bc 12,2,.L45
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
	b .L22
.L45:
	lis 5,.LC2@ha
	li 3,0
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 3,3
	bc 4,2,.L48
	bl G_Spawn
	lis 9,.LC2@ha
	mr 29,3
	la 9,.LC2@l(9)
	lis 5,.LC1@ha
	addi 3,28,136
	addi 6,28,72
	stw 9,280(29)
	la 5,.LC1@l(5)
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	addi 0,28,136
	mr 3,29
	stw 0,504(29)
	bl BeginIntermission
	b .L22
.L48:
	bl BeginIntermission
.L22:
	lwz 0,68(1)
	mtlr 0
	lmw 22,24(1)
	la 1,64(1)
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
	bc 4,2,.L53
	lwz 9,spectator_password@l(29)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L52
.L53:
	lis 9,spectator_password@ha
	li 10,0
	lwz 11,spectator_password@l(9)
	li 31,0
	stw 10,16(11)
	lwz 3,4(8)
	stw 10,16(8)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L54
	lis 4,.LC4@ha
	la 4,.LC4@l(4)
	bl Q_stricmp
	addic 0,3,-1
	subfe 31,0,3
.L54:
	lwz 9,spectator_password@l(29)
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L55
	lis 4,.LC4@ha
	la 4,.LC4@l(4)
	bl Q_stricmp
	addic 3,3,-1
	subfe 3,3,3
	ori 0,31,2
	andc 0,0,3
	and 3,31,3
	or 31,3,0
.L55:
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
.L52:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 CheckNeedPass,.Lfe5-CheckNeedPass
	.section	".sbss","aw",@nobits
	.align 2
hit.31:
	.space	4
	.size	 hit.31,4
	.section	".rodata"
	.align 2
.LC7:
	.string	"Tie. Starting extra time...\n"
	.align 2
.LC8:
	.string	"Timelimit hit.\n"
	.align 2
.LC9:
	.string	"Extra time hit.\n"
	.align 2
.LC10:
	.string	"Fraglimit hit.\n"
	.align 2
.LC11:
	.long 0x0
	.align 2
.LC12:
	.long 0x42700000
	.align 3
.LC13:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CheckDMRules
	.type	 CheckDMRules,@function
CheckDMRules:
	stwu 1,-48(1)
	mflr 0
	stmw 30,40(1)
	stw 0,52(1)
	lis 9,game@ha
	li 6,0
	la 11,game@l(9)
	li 0,0
	lwz 10,1544(11)
	addi 9,1,8
	stw 0,4(9)
	mr 30,9
	cmpw 0,6,10
	stw 0,8(1)
	bc 4,0,.L58
	lis 9,g_edicts@ha
	mr 12,11
	lwz 11,g_edicts@l(9)
	mr 31,10
	mr 3,30
	li 4,0
	li 5,0
	addi 7,11,1204
.L60:
	lwz 0,0(7)
	addi 7,7,1116
	cmpwi 0,0,0
	bc 12,2,.L59
	lwz 9,1028(12)
	mr 8,4
	add 9,5,9
	lwz 0,1820(9)
	cmpwi 0,0,2
	bc 4,2,.L62
	li 10,0
	b .L63
.L62:
	cmpwi 0,0,1
	bc 4,2,.L59
	li 10,1
.L63:
	lwz 9,1028(12)
	slwi 10,10,2
	lwzx 11,10,3
	add 9,8,9
	lwz 0,1816(9)
	add 11,11,0
	stwx 11,10,3
.L59:
	addi 6,6,1
	addi 4,4,2288
	cmpw 0,6,31
	addi 5,5,2288
	bc 12,0,.L60
.L58:
	lis 9,level@ha
	lis 11,.LC11@ha
	la 11,.LC11@l(11)
	la 8,level@l(9)
	lfs 11,0(11)
	lfs 0,200(8)
	fcmpu 0,0,11
	bc 4,2,.L56
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,11
	bc 12,2,.L56
	lis 11,timelimit@ha
	lis 10,extratime@ha
	lwz 9,timelimit@l(11)
	lfs 12,20(9)
	fcmpu 0,12,11
	bc 12,2,.L69
	lis 9,.LC12@ha
	lfs 13,4(8)
	la 9,.LC12@l(9)
	lfs 0,0(9)
	fmuls 0,12,0
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L69
	lwz 9,extratime@l(10)
	lfs 0,20(9)
	fcmpu 0,0,11
	bc 12,2,.L71
	lis 31,hit.31@ha
	lwz 0,hit.31@l(31)
	cmpwi 0,0,0
	bc 4,2,.L69
	lwz 9,4(30)
	lwz 0,8(1)
	cmpw 0,0,9
	bc 4,2,.L69
	lis 9,gi@ha
	lis 4,.LC7@ha
	lwz 0,gi@l(9)
	la 4,.LC7@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,1
	stw 0,hit.31@l(31)
	b .L56
.L71:
	lis 9,gi@ha
	lis 4,.LC8@ha
	lwz 0,gi@l(9)
	la 4,.LC8@l(4)
	b .L88
.L69:
	lis 11,.LC11@ha
	lis 9,extratime@ha
	la 11,.LC11@l(11)
	lfs 0,0(11)
	lwz 11,extratime@l(9)
	lfs 11,20(11)
	fcmpu 0,11,0
	bc 12,2,.L75
	lis 9,hit.31@ha
	lwz 0,hit.31@l(9)
	cmpwi 0,0,0
	bc 12,2,.L75
	lis 11,timelimit@ha
	lis 9,.LC12@ha
	lwz 10,timelimit@l(11)
	la 9,.LC12@l(9)
	lfs 13,0(9)
	lfs 0,20(10)
	lis 9,level+4@ha
	lfs 12,level+4@l(9)
	fmuls 0,0,13
	fmadds 13,11,13,0
	fcmpu 0,12,13
	cror 3,2,1
	bc 4,3,.L75
	lis 9,gi@ha
	lis 4,.LC9@ha
	lwz 0,gi@l(9)
	la 4,.LC9@l(4)
	b .L88
.L75:
	lis 11,.LC11@ha
	lis 9,capturelimit@ha
	la 11,.LC11@l(11)
	lfs 13,0(11)
	lwz 11,capturelimit@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L77
	bl Captures_Reached
	b .L56
.L87:
	lis 9,gi@ha
	lis 4,.LC10@ha
	lwz 0,gi@l(9)
	la 4,.LC10@l(4)
.L88:
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	bl EndDMLevel
	b .L56
.L77:
	lis 9,fraglimit@ha
	lwz 8,fraglimit@l(9)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L56
	lis 11,maxclients@ha
	li 6,0
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L56
	lis 9,g_edicts@ha
	lis 11,game+1028@ha
	fmr 11,0
	lwz 10,g_edicts@l(9)
	mr 7,8
	lis 9,.LC13@ha
	lwz 11,game+1028@l(11)
	lis 8,0x4330
	la 9,.LC13@l(9)
	addi 10,10,1204
	lfd 12,0(9)
.L82:
	lwz 0,0(10)
	addi 10,10,1116
	cmpwi 0,0,0
	bc 12,2,.L81
	lwz 0,1816(11)
	lfs 13,20(7)
	xoris 0,0,0x8000
	stw 0,36(1)
	stw 8,32(1)
	lfd 0,32(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L81
	lwz 0,1808(11)
	cmpwi 0,0,0
	bc 12,2,.L87
.L81:
	addi 6,6,1
	xoris 0,6,0x8000
	addi 11,11,2288
	stw 0,36(1)
	stw 8,32(1)
	lfd 0,32(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,11
	bc 12,0,.L82
.L56:
	lwz 0,52(1)
	mtlr 0
	lmw 30,40(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 CheckDMRules,.Lfe6-CheckDMRules
	.section	".rodata"
	.align 2
.LC14:
	.string	"gamemap \"%s\"\n"
	.align 2
.LC15:
	.long 0x0
	.align 3
.LC16:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ExitLevel
	.type	 ExitLevel,@function
ExitLevel:
	stwu 1,-304(1)
	mflr 0
	stfd 31,296(1)
	stmw 26,272(1)
	stw 0,308(1)
	lis 29,level@ha
	lis 5,.LC14@ha
	la 29,level@l(29)
	addi 3,1,8
	lwz 6,204(29)
	la 5,.LC14@l(5)
	li 4,256
	li 28,0
	li 31,0
	crxor 6,6,6
	bl Com_sprintf
	lis 26,maxclients@ha
	lis 9,gi+168@ha
	addi 3,1,8
	lwz 0,gi+168@l(9)
	mtlr 0
	blrl
	stw 28,204(29)
	bl PBM_KillAllFires
	lis 9,.LC15@ha
	lis 11,maxclients@ha
	stw 28,208(29)
	la 9,.LC15@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	stfs 13,200(29)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L96
	lis 11,.LC16@ha
	lis 27,g_edicts@ha
	la 11,.LC16@l(11)
	lis 30,0x4330
	lfd 31,0(11)
	li 28,1116
.L92:
	lwz 0,g_edicts@l(27)
	add 29,0,28
	mr 3,29
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L94
	mr 3,29
	bl ClientEndServerFrame
.L94:
	addi 31,31,1
	lwz 11,maxclients@l(26)
	xoris 0,31,0x8000
	addi 28,28,1116
	stw 0,268(1)
	stw 30,264(1)
	lfd 0,264(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L92
.L96:
	lis 11,.LC15@ha
	lis 9,maxclients@ha
	la 11,.LC15@l(11)
	li 10,0
	lfs 0,0(11)
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	bc 4,0,.L98
	lis 9,.LC16@ha
	fmr 12,13
	lis 11,0x4330
	la 9,.LC16@l(9)
	lfd 13,0(9)
.L100:
	addi 10,10,1
	xoris 0,10,0x8000
	stw 0,268(1)
	stw 11,264(1)
	lfd 0,264(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L100
.L98:
	bl CTFInit
	lwz 0,308(1)
	mtlr 0
	lmw 26,272(1)
	lfd 31,296(1)
	la 1,304(1)
	blr
.Lfe7:
	.size	 ExitLevel,.Lfe7-ExitLevel
	.section	".rodata"
	.align 3
.LC17:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC18:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC19:
	.long 0x0
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
	lis 10,level@ha
	lwz 9,level@l(10)
	lis 7,0x4330
	lis 11,.LC18@ha
	la 11,.LC18@l(11)
	la 29,level@l(10)
	addi 9,9,1
	lfd 12,0(11)
	xoris 0,9,0x8000
	lis 11,.LC17@ha
	stw 9,level@l(10)
	stw 0,20(1)
	stw 7,16(1)
	lfd 0,16(1)
	lfd 13,.LC17@l(11)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,4(29)
	bl AI_SetSightClient
	lwz 0,208(29)
	cmpwi 0,0,0
	bc 12,2,.L104
	bl ExitLevel
	b .L103
.L104:
	lis 9,globals@ha
	li 30,0
	la 9,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(9)
	lis 24,g_edicts@ha
	lis 27,maxclients@ha
	lwz 31,g_edicts@l(11)
	cmpw 0,30,0
	bc 4,0,.L106
	mr 26,9
	mr 25,29
	lis 9,.LC18@ha
	li 28,0
	la 9,.LC18@l(9)
	lis 29,0x4330
	lfd 31,0(9)
.L108:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L107
	stw 31,292(25)
	lwz 9,552(31)
	lfs 0,4(31)
	lfs 12,8(31)
	cmpwi 0,9,0
	lfs 13,12(31)
	stfs 0,28(31)
	stfs 12,32(31)
	stfs 13,36(31)
	bc 12,2,.L110
	lwz 9,92(9)
	lwz 0,556(31)
	cmpw 0,9,0
	bc 12,2,.L110
	lwz 0,264(31)
	stw 28,552(31)
	andi. 11,0,3
	bc 4,2,.L110
	lwz 0,184(31)
	andi. 9,0,4
	bc 12,2,.L110
	mr 3,31
	bl M_CheckGround
.L110:
	cmpwi 0,30,0
	bc 4,1,.L112
	xoris 0,30,0x8000
	lwz 11,maxclients@l(27)
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L112
	mr 3,31
	bl ClientBeginServerFrame
	b .L107
.L112:
	mr 3,31
	bl G_RunEntity
.L107:
	lwz 0,72(26)
	addi 30,30,1
	addi 31,31,1116
	cmpw 0,30,0
	bc 12,0,.L108
.L106:
	bl CheckDMRules
	li 29,0
	bl CheckNeedPass
	lis 9,.LC19@ha
	lis 11,maxclients@ha
	la 9,.LC19@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L103
	lis 11,.LC18@ha
	lis 28,0x4330
	la 11,.LC18@l(11)
	li 30,1116
	lfd 31,0(11)
.L116:
	lwz 0,g_edicts@l(24)
	add 31,0,30
	mr 3,31
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L118
	mr 3,31
	bl ClientEndServerFrame
.L118:
	addi 29,29,1
	lwz 11,maxclients@l(27)
	xoris 0,29,0x8000
	addi 30,30,1116
	stw 0,20(1)
	stw 28,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L116
.L103:
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
	.long .LC20
	.long dllLoadResource
	.long .LC21
	.long dllFreeResource
	.long .LC22
	.long GetGameAPI
	.long .LC23
	.long SetExeName
	.long .LC24
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC24:
	.string	"SetExeName"
	.align 2
.LC23:
	.string	"GetGameAPI"
	.align 2
.LC22:
	.string	"dllFreeResource"
	.align 2
.LC21:
	.string	"dllLoadResource"
	.align 2
.LC20:
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
	.comm	game,1564,4
	.comm	level,964,4
	.comm	gi,176,4
	.comm	globals,80,4
	.comm	st,68,4
	.comm	sm_meat_index,4,4
	.comm	snd_fry,4,4
	.comm	meansOfDeath,4,4
	.comm	g_edicts,4,4
	.comm	maxentities,4,4
	.comm	deathmatch,4,4
	.comm	teamplay,4,4
	.comm	dmflags,4,4
	.comm	skill,4,4
	.comm	fraglimit,4,4
	.comm	timelimit,4,4
	.comm	password,4,4
	.comm	g_select_empty,4,4
	.comm	dedicated,4,4
	.comm	sv_gravity,4,4
	.comm	sv_maxvelocity,4,4
	.comm	gun_x,4,4
	.comm	gun_y,4,4
	.comm	gun_z,4,4
	.comm	sv_rollspeed,4,4
	.comm	sv_rollangle,4,4
	.comm	filterban,4,4
	.comm	extratime,4,4
	.comm	spectator_password,4,4
	.comm	run_pitch,4,4
	.comm	run_roll,4,4
	.comm	bob_up,4,4
	.comm	bob_pitch,4,4
	.comm	bob_roll,4,4
	.comm	sv_cheats,4,4
	.comm	maxclients,4,4
	.comm	maxspectators,4,4
	.comm	ripflags,4,4
	.comm	capturelimit,4,4
	.comm	bhole_life,4,4
	.comm	eject,4,4
	.comm	sv_maplist,4,4
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.section	".text"
	.align 2
	.globl DLL_Init
	.type	 DLL_Init,@function
DLL_Init:
	li 3,1
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
	lis 3,ini_file@ha
	la 3,ini_file@l(3)
	bl Ini_FreeIniFile
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
.LC25:
	.long 0x0
	.align 3
.LC26:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ClientEndServerFrames
	.type	 ClientEndServerFrames,@function
ClientEndServerFrames:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	lis 11,.LC25@ha
	lis 9,maxclients@ha
	la 11,.LC25@l(11)
	li 29,0
	lfs 13,0(11)
	lis 26,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L16
	lis 9,.LC26@ha
	lis 27,g_edicts@ha
	la 9,.LC26@l(9)
	lis 28,0x4330
	lfd 31,0(9)
	li 30,1116
.L18:
	lwz 0,g_edicts@l(27)
	add 31,0,30
	mr 3,31
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L17
	mr 3,31
	bl ClientEndServerFrame
.L17:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,1116
	stw 0,12(1)
	stw 28,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L18
.L16:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
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
	.globl SetExeName
	.type	 SetExeName,@function
SetExeName:
	lis 9,exe_found@ha
	li 0,1
	stw 0,exe_found@l(9)
	blr
.Lfe14:
	.size	 SetExeName,.Lfe14-SetExeName
	.align 2
	.globl dllFindResource
	.type	 dllFindResource,@function
dllFindResource:
	li 3,0
	blr
.Lfe15:
	.size	 dllFindResource,.Lfe15-dllFindResource
	.align 2
	.globl dllLoadResource
	.type	 dllLoadResource,@function
dllLoadResource:
	li 3,0
	blr
.Lfe16:
	.size	 dllLoadResource,.Lfe16-dllLoadResource
	.align 2
	.globl dllFreeResource
	.type	 dllFreeResource,@function
dllFreeResource:
	blr
.Lfe17:
	.size	 dllFreeResource,.Lfe17-dllFreeResource
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
