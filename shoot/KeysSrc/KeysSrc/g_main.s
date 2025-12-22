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
	li 21,1352
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
	stwu 1,-384(1)
	mflr 0
	stmw 21,340(1)
	stw 0,388(1)
	bl EnitityListClean
	lis 9,level@ha
	addi 29,1,8
	la 31,level@l(9)
	li 5,304
	mr 4,31
	mr 3,29
	crxor 6,6,6
	bl memcpy
	lis 3,gi@ha
	mr 4,29
	la 3,gi@l(3)
	bl sl_GameEnd
	bl K2_CheckLevelCycle
	cmpwi 0,3,0
	bc 4,2,.L24
	lis 9,map_mod_@ha
	lwz 0,map_mod_@l(9)
	cmpwi 0,0,0
	bc 12,2,.L25
	bl map_mod_next_map
	mr. 4,3
	bc 12,2,.L25
	addi 3,31,136
	bl strcpy
.L25:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,328(1)
	lwz 11,332(1)
	andi. 0,11,32
	bc 12,2,.L27
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
	b .L23
.L27:
	lis 9,sv_maplist@ha
	lis 21,.LC2@ha
	lwz 11,sv_maplist@l(9)
	lwz 3,4(11)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L29
	bl strdup
	li 31,0
	lis 25,seps.24@ha
	lis 9,seps.24@ha
	mr 22,3
	lwz 4,seps.24@l(9)
	bl strtok
	mr. 28,3
	bc 12,2,.L31
	lis 29,level+72@ha
	la 26,.LC2@l(21)
	la 27,level+72@l(29)
	lis 30,.LC1@ha
	addi 23,27,64
	lis 24,level+136@ha
.L32:
	mr 3,28
	la 4,level+72@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L33
	lwz 4,seps.24@l(25)
	li 3,0
	bl strtok
	mr. 28,3
	bc 4,2,.L34
	cmpwi 0,31,0
	bc 4,2,.L35
	bl G_Spawn
	mr 29,3
	la 5,.LC1@l(30)
	addi 3,27,64
	stw 26,280(29)
	mr 6,27
	b .L48
.L35:
	bl G_Spawn
	mr 29,3
	la 5,.LC1@l(30)
	la 3,level+136@l(24)
	stw 26,280(29)
	mr 6,31
.L48:
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	stw 23,504(29)
	mr 3,29
	bl BeginIntermission
	b .L39
.L34:
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
.L39:
	mr 3,22
	bl free
	b .L23
.L33:
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
	bc 4,2,.L32
.L31:
	mr 3,22
	bl free
.L29:
	lis 9,level@ha
	la 28,level@l(9)
	lbz 0,136(28)
	cmpwi 0,0,0
	bc 12,2,.L43
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
	b .L24
.L43:
	lis 5,.LC2@ha
	li 3,0
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 3,3
	bc 4,2,.L46
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
	b .L23
.L46:
	bl BeginIntermission
.L24:
	bl WriteTrail
.L23:
	lwz 0,388(1)
	mtlr 0
	lmw 21,340(1)
	la 1,384(1)
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
	bc 4,2,.L51
	lwz 9,spectator_password@l(29)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L50
.L51:
	lis 9,spectator_password@ha
	li 10,0
	lwz 11,spectator_password@l(9)
	li 31,0
	stw 10,16(11)
	lwz 3,4(8)
	stw 10,16(8)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L52
	lis 4,.LC4@ha
	la 4,.LC4@l(4)
	bl Q_stricmp
	addic 0,3,-1
	subfe 31,0,3
.L52:
	lwz 9,spectator_password@l(29)
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L53
	lis 4,.LC4@ha
	la 4,.LC4@l(4)
	bl Q_stricmp
	addic 3,3,-1
	subfe 3,3,3
	ori 0,31,2
	andc 0,0,3
	and 3,31,3
	or 31,3,0
.L53:
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
.L50:
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
	stwu 1,-2096(1)
	mflr 0
	stmw 24,2064(1)
	stw 0,2100(1)
	lis 9,ctf@ha
	lis 7,.LC9@ha
	lwz 11,ctf@l(9)
	la 7,.LC9@l(7)
	li 24,0
	lfs 13,0(7)
	li 8,0
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L55
	lis 9,game@ha
	li 30,0
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,30,0
	bc 4,0,.L57
	lis 9,g_edicts@ha
	mr 27,11
	lwz 25,g_edicts@l(9)
	addi 26,1,1032
.L59:
	mulli 9,30,1352
	addi 28,30,1
	add 9,9,25
	lwz 0,1440(9)
	cmpwi 0,0,0
	bc 12,2,.L58
	lwz 0,1028(27)
	mulli 9,30,4088
	li 5,0
	addi 4,1,1032
	cmpw 0,5,8
	addi 3,1,8
	add 9,9,0
	addi 29,8,1
	lwz 12,3464(9)
	bc 4,0,.L62
	lwz 0,0(26)
	cmpw 0,12,0
	bc 12,1,.L62
	mr 9,4
.L63:
	addi 5,5,1
	cmpw 0,5,8
	bc 4,0,.L62
	lwzu 0,4(9)
	cmpw 0,12,0
	bc 4,1,.L63
.L62:
	cmpw 0,8,5
	mr 7,8
	slwi 31,5,2
	bc 4,1,.L68
	slwi 9,8,2
	mr 6,3
	mr 10,9
	mr 8,4
	addi 11,9,-4
.L70:
	lwzx 9,11,6
	addi 7,7,-1
	cmpw 0,7,5
	stwx 9,10,6
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L70
.L68:
	stwx 30,3,31
	mr 8,29
	stwx 12,4,31
.L58:
	lwz 0,1544(27)
	mr 30,28
	cmpw 0,30,0
	bc 12,0,.L59
.L57:
	li 30,0
	cmpw 0,30,8
	bc 4,0,.L55
	lis 9,game@ha
	addi 10,1,8
	la 7,game@l(9)
.L76:
	lwz 0,0(10)
	addi 11,30,1
	lwz 9,1028(7)
	mr 30,11
	addi 10,10,4
	mulli 0,0,4088
	cmpw 0,30,8
	add 9,9,0
	stw 11,4052(9)
	bc 12,0,.L76
.L55:
	lis 9,level@ha
	lis 11,.LC9@ha
	la 11,.LC9@l(11)
	la 10,level@l(9)
	lfs 13,0(11)
	lfs 0,200(10)
	fcmpu 0,0,13
	bc 4,2,.L54
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L54
	lis 9,timelimit@ha
	lwz 11,timelimit@l(9)
	lfs 11,20(11)
	fcmpu 0,11,13
	bc 12,2,.L80
	lis 28,.LC10@ha
	lfs 12,4(10)
	la 28,.LC10@l(28)
	lfs 9,0(28)
	fmuls 10,11,9
	fcmpu 0,12,10
	cror 3,2,1
	bc 4,3,.L81
	lis 4,.LC7@ha
	li 3,2
	la 4,.LC7@l(4)
	b .L97
.L96:
	lis 4,.LC8@ha
	li 3,2
	la 4,.LC8@l(4)
.L97:
	crxor 6,6,6
	bl my_bprintf
	bl EndDMLevel
	b .L54
.L81:
	fdivs 0,12,9
	lis 11,k2_timeleft@ha
	fsubs 0,11,0
	fsubs 12,10,12
	fcmpu 0,12,9
	fctiwz 13,0
	stfd 13,2056(1)
	lwz 9,2060(1)
	stw 9,k2_timeleft@l(11)
	bc 4,0,.L80
	fmr 0,12
	fctiwz 13,0
	stfd 13,2056(1)
	lwz 9,2060(1)
	stw 9,k2_timeleft@l(11)
.L80:
	lis 11,ctf@ha
	lis 7,.LC9@ha
	lwz 9,ctf@l(11)
	la 7,.LC9@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L83
	bl CTFCheckRules
	cmpwi 0,3,0
	bc 12,2,.L83
	bl EndDMLevel
.L83:
	lis 7,.LC9@ha
	lis 9,fraglimit@ha
	la 7,.LC9@l(7)
	lfs 13,0(7)
	lwz 7,fraglimit@l(9)
	lfs 0,20(7)
	fcmpu 0,0,13
	bc 12,2,.L54
	lis 11,maxclients@ha
	li 30,0
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L54
	lis 9,game+1028@ha
	lis 11,g_edicts@ha
	fmr 9,0
	lwz 8,game+1028@l(9)
	lis 28,.LC11@ha
	lis 10,ctf@ha
	lwz 9,g_edicts@l(11)
	la 28,.LC11@l(28)
	mr 5,7
	lis 11,.LC9@ha
	lfd 10,0(28)
	mr 31,5
	la 11,.LC9@l(11)
	lwz 3,ctf@l(10)
	addi 8,8,3464
	lfs 8,0(11)
	addi 10,9,1440
	lis 4,k2_fragsleft@ha
	lis 29,0x4330
.L89:
	lwz 0,0(10)
	addi 10,10,1352
	cmpwi 0,0,0
	bc 12,2,.L88
	lwz 11,0(8)
	lis 6,0x4330
	lis 7,.LC11@ha
	lfs 12,20(5)
	xoris 0,11,0x8000
	la 7,.LC11@l(7)
	stw 0,2060(1)
	stw 6,2056(1)
	lfd 11,0(7)
	lfd 0,2056(1)
	fsub 0,0,11
	frsp 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L96
	lfs 0,20(3)
	fcmpu 0,0,8
	bc 4,2,.L88
	cmpw 0,11,24
	lis 7,k2_fragsleft@ha
	bc 4,1,.L93
	fsubs 0,12,13
	mr 24,11
	fctiwz 13,0
	stfd 13,2056(1)
	lwz 9,2060(1)
	stw 9,k2_fragsleft@l(4)
.L93:
	lwz 0,k2_fragsleft@l(4)
	subfic 28,24,0
	adde 11,28,24
	lfs 13,20(31)
	xoris 0,0,0x8000
	stw 0,2060(1)
	stw 6,2056(1)
	lfd 0,2056(1)
	fsub 0,0,11
	frsp 0,0
	fcmpu 7,0,13
	mfcr 0
	rlwinm 0,0,30,1
	or. 9,0,11
	bc 12,2,.L88
	fmr 0,13
	fctiwz 13,0
	stfd 13,2056(1)
	lwz 9,2060(1)
	stw 9,k2_fragsleft@l(7)
.L88:
	addi 30,30,1
	xoris 0,30,0x8000
	addi 8,8,4088
	stw 0,2060(1)
	stw 29,2056(1)
	lfd 0,2056(1)
	fsub 0,0,10
	frsp 0,0
	fcmpu 0,0,9
	bc 12,0,.L89
.L54:
	lwz 0,2100(1)
	mtlr 0
	lmw 24,2064(1)
	la 1,2096(1)
	blr
.Lfe6:
	.size	 CheckDMRules,.Lfe6-CheckDMRules
	.globl respawn_init
	.section	".sdata","aw"
	.align 2
	.type	 respawn_init,@object
	.size	 respawn_init,4
respawn_init:
	.long 0
	.globl respawn_flag
	.align 2
	.type	 respawn_flag,@object
	.size	 respawn_flag,4
respawn_flag:
	.long 0
	.section	".rodata"
	.align 2
.LC12:
	.string	"gamemap \"%s\"\n"
	.align 2
.LC13:
	.long 0x4b18967f
	.align 2
.LC14:
	.long 0x0
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ExitLevel
	.type	 ExitLevel,@function
ExitLevel:
	stwu 1,-336(1)
	mflr 0
	stfd 31,328(1)
	stmw 20,280(1)
	stw 0,340(1)
	lis 29,level@ha
	lis 5,.LC12@ha
	la 29,level@l(29)
	addi 3,1,8
	lwz 6,204(29)
	la 5,.LC12@l(5)
	li 4,256
	li 31,0
	lis 25,maxclients@ha
	crxor 6,6,6
	bl Com_sprintf
	lis 9,gi+168@ha
	addi 3,1,8
	lwz 0,gi+168@l(9)
	mtlr 0
	blrl
	lis 9,maxclients@ha
	li 0,0
	lwz 10,maxclients@l(9)
	lis 11,nextlevelstart@ha
	lis 9,.LC14@ha
	stw 0,208(29)
	la 9,.LC14@l(9)
	stw 0,204(29)
	lfs 12,0(9)
	lis 9,.LC13@ha
	lfs 13,.LC13@l(9)
	stfs 12,200(29)
	lfs 0,20(10)
	stfs 13,nextlevelstart@l(11)
	fcmpu 0,12,0
	bc 4,0,.L106
	lis 10,.LC15@ha
	lis 28,g_edicts@ha
	la 10,.LC15@l(10)
	lis 30,0x4330
	lfd 31,0(10)
	li 29,1352
.L101:
	lwz 0,g_edicts@l(28)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L104
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L104
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L104
	bl ClientEndServerFrame
.L104:
	addi 31,31,1
	lwz 11,maxclients@l(25)
	xoris 0,31,0x8000
	addi 29,29,1352
	stw 0,276(1)
	stw 30,272(1)
	lfd 0,272(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L101
.L106:
	lis 9,respawn_bots@ha
	li 4,0
	la 30,respawn_bots@l(9)
	li 5,16384
	mr 3,30
	li 26,0
	crxor 6,6,6
	bl memset
	lis 9,respawn_bot_teams@ha
	li 4,0
	la 31,respawn_bot_teams@l(9)
	li 5,256
	mr 3,31
	crxor 6,6,6
	bl memset
	lis 9,.LC14@ha
	lis 11,maxclients@ha
	la 9,.LC14@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L108
	lis 10,.LC14@ha
	lis 9,respawn_ctf_teams@ha
	la 10,.LC14@l(10)
	mr 27,31
	lfs 31,0(10)
	mr 20,30
	la 28,respawn_ctf_teams@l(9)
	lis 21,g_edicts@ha
	lis 22,0x4330
	li 30,1352
	li 31,0
	lis 23,teamplay@ha
	lis 24,ctf@ha
.L110:
	lwz 0,g_edicts@l(21)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L109
	lwz 9,84(29)
	lwz 0,480(29)
	lwz 9,728(9)
	cmpw 0,0,9
	bc 4,1,.L112
	stw 9,480(29)
.L112:
	lwz 0,968(29)
	cmpwi 0,0,0
	bc 12,2,.L109
	lwz 5,84(29)
	add 3,31,20
	li 4,256
	addi 5,5,700
	crxor 6,6,6
	bl Com_sprintf
	lis 9,.LC14@ha
	lis 11,ctf@ha
	la 9,.LC14@l(9)
	lfs 13,0(9)
	lwz 9,teamplay@l(23)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L115
	lwz 9,ctf@l(24)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L114
.L115:
	lwz 9,84(29)
	lwz 0,3912(9)
	stw 0,0(27)
.L114:
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L116
	lwz 9,84(29)
	lwz 0,3468(9)
	stw 0,0(28)
.L116:
	addi 28,28,4
	addi 27,27,4
	addi 31,31,256
.L109:
	addi 26,26,1
	lwz 11,maxclients@l(25)
	xoris 0,26,0x8000
	lis 10,.LC15@ha
	stw 0,276(1)
	la 10,.LC15@l(10)
	addi 30,30,1352
	stw 22,272(1)
	lfd 13,0(10)
	lfd 0,272(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L110
.L108:
	lis 9,respawn_flag@ha
	li 0,1
	stw 0,respawn_flag@l(9)
	bl CTFInit
	lwz 0,340(1)
	mtlr 0
	lmw 20,280(1)
	lfd 31,328(1)
	la 1,336(1)
	blr
.Lfe7:
	.size	 ExitLevel,.Lfe7-ExitLevel
	.section	".rodata"
	.align 2
.LC16:
	.string	"bot_calc_nodes"
	.align 2
.LC17:
	.string	"0"
	.align 2
.LC18:
	.string	"Dynamic node calculation DISABLED\n"
	.align 2
.LC19:
	.long 0x41700000
	.section	".text"
	.align 2
	.globl CheckNodeCalcDisable
	.type	 CheckNodeCalcDisable,@function
CheckNodeCalcDisable:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,weapons_head@ha
	mr 31,3
	lwz 11,weapons_head@l(9)
	cmpwi 0,11,0
	bc 12,2,.L131
	lis 9,RemoveDroppedItem@ha
	la 9,RemoveDroppedItem@l(9)
.L128:
	lwz 0,416(11)
	cmpwi 0,0,0
	bc 4,2,.L129
	lwz 0,436(11)
	cmpw 0,0,9
	bc 4,2,.L154
.L129:
	lwz 11,936(11)
	cmpwi 0,11,0
	bc 4,2,.L128
.L131:
	li 0,1
.L130:
	cmpwi 0,0,0
	bc 12,2,.L132
	lis 9,health_head@ha
	lwz 11,health_head@l(9)
	cmpwi 0,11,0
	bc 12,2,.L139
	lis 9,RemoveDroppedItem@ha
	la 9,RemoveDroppedItem@l(9)
.L136:
	lwz 0,416(11)
	cmpwi 0,0,0
	bc 4,2,.L137
	lwz 0,436(11)
	cmpw 0,0,9
	bc 4,2,.L155
.L137:
	lwz 11,936(11)
	cmpwi 0,11,0
	bc 4,2,.L136
.L139:
	li 0,1
.L138:
	cmpwi 0,0,0
	bc 12,2,.L132
	lis 9,bonus_head@ha
	lwz 11,bonus_head@l(9)
	cmpwi 0,11,0
	bc 12,2,.L146
	lis 9,RemoveDroppedItem@ha
	la 9,RemoveDroppedItem@l(9)
.L143:
	lwz 0,416(11)
	cmpwi 0,0,0
	bc 4,2,.L144
	lwz 0,436(11)
	cmpw 0,0,9
	bc 4,2,.L156
.L144:
	lwz 11,936(11)
	cmpwi 0,11,0
	bc 4,2,.L143
.L146:
	li 0,1
.L145:
	cmpwi 0,0,0
	bc 12,2,.L132
	lis 9,ammo_head@ha
	lwz 11,ammo_head@l(9)
	cmpwi 0,11,0
	bc 12,2,.L153
	lis 9,RemoveDroppedItem@ha
	la 9,RemoveDroppedItem@l(9)
.L150:
	lwz 0,416(11)
	cmpwi 0,0,0
	bc 4,2,.L151
	lwz 0,436(11)
	cmpw 0,0,9
	bc 4,2,.L157
.L151:
	lwz 11,936(11)
	cmpwi 0,11,0
	bc 4,2,.L150
.L153:
	li 0,1
.L152:
	cmpwi 0,0,0
	bc 12,2,.L132
	lis 29,gi@ha
	lis 3,.LC16@ha
	la 29,gi@l(29)
	lis 4,.LC17@ha
	lwz 9,148(29)
	la 4,.LC17@l(4)
	la 3,.LC16@l(3)
	mtlr 9
	blrl
	lwz 0,4(29)
	lis 3,.LC18@ha
	la 3,.LC18@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L124
.L157:
	li 0,0
	b .L152
.L156:
	li 0,0
	b .L145
.L155:
	li 0,0
	b .L138
.L154:
	li 0,0
	b .L130
.L132:
	lis 11,.LC19@ha
	lis 9,level+4@ha
	la 11,.LC19@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,428(31)
.L124:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 CheckNodeCalcDisable,.Lfe8-CheckNodeCalcDisable
	.section	".sdata","aw"
	.align 2
	.type	 s_iLastTime.46,@object
	.size	 s_iLastTime.46,4
s_iLastTime.46:
	.long 0x0
	.section	".rodata"
	.align 2
.LC20:
	.long 0x0
	.align 2
.LC21:
	.long 0x3f800000
	.align 3
.LC22:
	.long 0x41e00000
	.long 0x0
	.align 3
.LC23:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC24:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC25:
	.long 0x40000000
	.long 0x0
	.section	".text"
	.align 2
	.type	 enforce_ctf_special_teams,@function
enforce_ctf_special_teams:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 9,level+4@ha
	lis 11,s_iLastTime.46@ha
	lfs 12,level+4@l(9)
	li 26,0
	lis 10,s_iLastTime.46@ha
	lfs 0,s_iLastTime.46@l(11)
	fcmpu 0,12,0
	bc 4,0,.L172
	li 0,0
	stw 0,s_iLastTime.46@l(10)
.L172:
	lis 11,.LC20@ha
	lis 9,ctf@ha
	la 11,.LC20@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L173
	lis 9,ctf_special_teams@ha
	lwz 11,ctf_special_teams@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L173
	lis 9,.LC21@ha
	lfs 13,s_iLastTime.46@l(10)
	li 26,1
	la 9,.LC21@l(9)
	lfs 0,0(9)
	fsubs 0,12,0
	fcmpu 0,13,0
	bc 4,0,.L173
	lis 11,.LC22@ha
	lis 9,ctf_humanonly_teams@ha
	la 11,.LC22@l(11)
	lfd 12,0(11)
	lwz 11,ctf_humanonly_teams@l(9)
	lfs 0,20(11)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L175
	fctiwz 0,13
	stfd 0,16(1)
	lwz 4,20(1)
	b .L176
.L175:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 4,20(1)
	xoris 4,4,0x8000
.L176:
	lis 11,maxclients@ha
	lis 9,num_players@ha
	lwz 10,maxclients@l(11)
	lis 8,ctf_special_teams@ha
	li 29,0
	lwz 0,num_players@l(9)
	li 12,0
	lfs 0,20(10)
	li 30,0
	li 5,0
	lwz 9,ctf_special_teams@l(8)
	cmpw 0,29,0
	li 6,0
	li 28,0
	lis 27,num_players@ha
	lfs 13,20(9)
	fctiwz 12,0
	fmr 11,13
	stfd 12,16(1)
	lwz 3,20(1)
	bc 4,0,.L178
	lis 9,players@ha
	mr 8,0
	la 7,players@l(9)
.L180:
	lwz 10,0(7)
	addi 7,7,4
	lwz 11,84(10)
	lwz 0,3468(11)
	cmpwi 0,0,1
	bc 4,2,.L181
	lwz 0,968(10)
	addi 12,12,1
	cmpwi 0,0,0
	bc 12,2,.L182
	cmpwi 0,28,0
	bc 12,2,.L184
	lwz 9,84(28)
	lwz 11,3464(11)
	lwz 0,3464(9)
	cmpw 0,11,0
	bc 4,0,.L179
.L184:
	mr 28,10
	b .L179
.L182:
	addi 5,5,1
	b .L179
.L181:
	cmpwi 0,0,2
	bc 4,2,.L179
	lwz 0,968(10)
	addi 30,30,1
	cmpwi 0,0,0
	bc 12,2,.L188
	cmpwi 0,29,0
	bc 12,2,.L190
	lwz 9,84(29)
	lwz 11,3464(11)
	lwz 0,3464(9)
	cmpw 0,11,0
	bc 4,0,.L179
.L190:
	mr 29,10
	b .L179
.L188:
	addi 6,6,1
.L179:
	addic. 8,8,-1
	bc 4,2,.L180
.L178:
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfd 0,0(9)
	fcmpu 0,11,0
	bc 4,0,.L193
	lis 11,.LC23@ha
	la 11,.LC23@l(11)
	lfd 11,0(11)
.L193:
	cmpw 0,12,30
	bc 4,1,.L194
	mr 31,12
	mr 7,31
	b .L195
.L194:
	mr 31,30
	mr 7,30
.L195:
	srawi 9,5,31
	srawi 0,6,31
	subf 9,5,9
	subf 0,6,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 12,2,.L196
	cmpwi 0,4,0
	bc 12,2,.L207
	lis 9,force_team@ha
	lis 10,force_team@ha
	lwz 0,force_team@l(9)
	cmpwi 0,0,0
	bc 12,2,.L207
	lis 9,num_players@ha
	li 8,0
	lwz 0,num_players@l(9)
	cmpw 0,8,0
	bc 4,0,.L207
	lis 9,players@ha
	la 11,players@l(9)
.L201:
	lwz 3,0(11)
	addi 11,11,4
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L200
	lwz 9,84(3)
	lwz 0,force_team@l(10)
	lwz 9,3468(9)
	cmpw 0,9,0
	bc 4,2,.L200
	cmpwi 0,9,1
	bc 4,2,.L204
	li 4,2
	bl CTFJoinTeam
	b .L205
.L204:
	li 4,1
	bl CTFJoinTeam
.L205:
	li 3,1
	b .L227
.L200:
	lwz 0,num_players@l(27)
	addi 8,8,1
	cmpw 0,8,0
	bc 12,0,.L201
	b .L207
.L196:
	cmpwi 7,5,0
	subfic 0,6,0
	adde 9,0,6
	mfcr 0
	rlwinm 0,0,31,1
	and. 11,0,9
	bc 12,2,.L208
	li 31,0
	lis 9,force_team@ha
	stw 31,force_team@l(9)
	li 7,0
	b .L207
.L208:
	or. 11,0,9
	bc 12,2,.L207
	bc 4,30,.L211
	xoris 11,6,0x8000
	stw 11,20(1)
	lis 0,0x4330
	mr 8,9
	lis 11,.LC24@ha
	stw 0,16(1)
	la 11,.LC24@l(11)
	lfd 0,16(1)
	addic 0,4,-1
	subfe 0,0,0
	lfd 12,0(11)
	andc 10,30,0
	li 9,1
	lis 11,force_team@ha
	and 0,31,0
	stw 9,force_team@l(11)
	or 31,0,10
	fsub 0,0,12
	fmul 0,0,11
	fctiwz 13,0
	stfd 13,16(1)
	lwz 7,20(1)
	cmpwi 0,7,1
	bc 4,2,.L213
	lis 9,.LC23@ha
	lis 11,.LC25@ha
	la 9,.LC23@l(9)
	la 11,.LC25@l(11)
	lfd 13,0(9)
	lfd 0,0(11)
	fcmpu 6,11,13
	fcmpu 7,11,0
	mfcr 9
	rlwinm 0,9,26,1
	rlwinm 9,9,29,1
	and 0,0,9
	addic 0,0,-1
	subfe 0,0,0
	nor 9,0,0
	rlwinm 0,0,0,31,31
	rlwinm 9,9,0,30,30
	or 7,0,9
.L213:
	add 11,7,30
	subf 9,30,3
	cmpw 7,11,3
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,7,0
	or 7,0,9
	b .L207
.L211:
	xoris 11,5,0x8000
	stw 11,20(1)
	lis 0,0x4330
	mr 8,9
	lis 11,.LC24@ha
	stw 0,16(1)
	la 11,.LC24@l(11)
	lfd 0,16(1)
	addic 0,4,-1
	subfe 0,0,0
	lfd 12,0(11)
	andc 10,12,0
	li 9,2
	lis 11,force_team@ha
	and 0,7,0
	stw 9,force_team@l(11)
	or 7,0,10
	fsub 0,0,12
	fmul 0,0,11
	fctiwz 13,0
	stfd 13,16(1)
	lwz 31,20(1)
	cmpwi 0,31,1
	bc 4,2,.L217
	lis 9,.LC23@ha
	lis 11,.LC25@ha
	la 9,.LC23@l(9)
	la 11,.LC25@l(11)
	lfd 13,0(9)
	lfd 0,0(11)
	fcmpu 6,11,13
	fcmpu 7,11,0
	mfcr 9
	rlwinm 0,9,26,1
	rlwinm 9,9,29,1
	and 0,0,9
	addic 0,0,-1
	subfe 0,0,0
	nor 9,0,0
	rlwinm 0,0,0,31,31
	rlwinm 9,9,0,30,30
	or 31,0,9
.L217:
	add 11,31,12
	subf 9,12,3
	cmpw 7,11,3
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,31,0
	or 31,0,9
.L207:
	cmpw 0,12,7
	bc 12,2,.L219
	bc 4,1,.L220
	cmpwi 0,28,0
	bc 12,2,.L219
	mr 3,28
	bl botDisconnect
	b .L219
.L220:
	li 3,0
	bl spawn_bot
.L219:
	cmpw 0,30,31
	bc 12,2,.L223
	bc 4,1,.L224
	cmpwi 0,29,0
	bc 12,2,.L223
	mr 3,29
	bl botDisconnect
	b .L223
.L224:
	li 3,0
	bl spawn_bot
.L223:
	lis 9,level+4@ha
	lis 11,s_iLastTime.46@ha
	lfs 0,level+4@l(9)
	stfs 0,s_iLastTime.46@l(11)
.L173:
	mr 3,26
.L227:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 enforce_ctf_special_teams,.Lfe9-enforce_ctf_special_teams
	.globl execed_launcher_cfg
	.section	".sdata","aw"
	.align 2
	.type	 execed_launcher_cfg,@object
	.size	 execed_launcher_cfg,4
execed_launcher_cfg:
	.long 0
	.align 2
	.type	 last_ctf_teams.50,@object
	.size	 last_ctf_teams.50,4
last_ctf_teams.50:
	.long 0x0
	.section	".rodata"
	.align 2
.LC27:
	.string	"exec launcher.cfg\n"
	.section	".sdata","aw"
	.align 2
	.type	 last_spawn.51,@object
	.size	 last_spawn.51,4
last_spawn.51:
	.long 0x0
	.section	".rodata"
	.align 2
.LC29:
	.string	"Cannot spawn bot: not enough free client spaces (bot_free_clients = %i)\n"
	.align 2
.LC30:
	.string	"bot_name"
	.align 2
.LC31:
	.string	""
	.align 2
.LC32:
	.string	"Team \"%s\" does not exist.\n"
	.align 2
.LC33:
	.string	"addteam"
	.align 2
.LC34:
	.string	"%i"
	.align 2
.LC35:
	.string	"players_per_team"
	.align 2
.LC36:
	.string	"MAX_PLAYERS_PER_TEAM = %i\n"
	.align 2
.LC37:
	.string	"["
	.align 2
.LC38:
	.string	"]"
	.align 2
.LC39:
	.string	"name"
	.align 2
.LC40:
	.string	"bot_drop"
	.align 3
.LC26:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC28:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC41:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC42:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC43:
	.long 0x0
	.align 2
.LC44:
	.long 0x43960000
	.align 2
.LC45:
	.long 0x3f800000
	.align 2
.LC46:
	.long 0x41000000
	.align 3
.LC47:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC48:
	.long 0x42000000
	.align 2
.LC49:
	.long 0x41700000
	.align 2
.LC50:
	.long 0x43c80000
	.align 2
.LC51:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl G_RunFrame
	.type	 G_RunFrame,@function
G_RunFrame:
	stwu 1,-768(1)
	mflr 0
	stfd 30,752(1)
	stfd 31,760(1)
	stmw 17,692(1)
	stw 0,772(1)
	lis 9,paused@ha
	lwz 0,paused@l(9)
	cmpwi 0,0,0
	bc 4,2,.L228
	lis 9,level@ha
	lis 11,last_ctf_teams.50@ha
	la 30,level@l(9)
	lfs 13,last_ctf_teams.50@l(11)
	lis 6,level@ha
	lfs 0,4(30)
	fcmpu 0,0,13
	bc 4,0,.L230
	li 0,0
	lis 9,last_ctf_teams.50@ha
	stw 0,last_ctf_teams.50@l(9)
.L230:
	lwz 10,level@l(6)
	lis 7,0x4330
	lis 9,.LC42@ha
	lis 11,bot_calc_nodes@ha
	addi 10,10,1
	la 9,.LC42@l(9)
	xoris 0,10,0x8000
	lfd 13,0(9)
	stw 0,684(1)
	lis 9,.LC26@ha
	stw 7,680(1)
	lfd 0,680(1)
	lfd 31,.LC26@l(9)
	lwz 9,bot_calc_nodes@l(11)
	fsub 0,0,13
	stw 10,level@l(6)
	lis 11,.LC43@ha
	la 11,.LC43@l(11)
	lfs 12,0(11)
	fmul 0,0,31
	frsp 13,0
	stfs 13,4(30)
	lfs 0,20(9)
	fcmpu 0,0,12
	bc 12,2,.L231
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L231
	lis 31,check_nodes_done@ha
	lwz 0,check_nodes_done@l(31)
	cmpwi 0,0,0
	bc 4,2,.L231
	bl G_Spawn
	lis 9,CheckNodeCalcDisable@ha
	stw 3,check_nodes_done@l(31)
	la 9,CheckNodeCalcDisable@l(9)
	stw 9,436(3)
	lfs 0,4(30)
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(3)
.L231:
	lis 31,execed_launcher_cfg@ha
	lwz 0,execed_launcher_cfg@l(31)
	cmpwi 0,0,0
	bc 4,2,.L232
	lis 10,.LC45@ha
	lis 9,level+4@ha
	la 10,.LC45@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 4,1,.L232
	lis 9,gi+168@ha
	lis 3,.LC27@ha
	lwz 0,gi+168@l(9)
	la 3,.LC27@l(3)
	mtlr 0
	blrl
	li 0,1
	stw 0,execed_launcher_cfg@l(31)
.L232:
	lis 9,level+4@ha
	lis 11,last_bot_spawn@ha
	lfs 11,level+4@l(9)
	li 0,0
	lis 10,roam_calls_this_frame@ha
	lfs 0,last_bot_spawn@l(11)
	lis 9,bestdirection_callsthisframe@ha
	stw 0,bestdirection_callsthisframe@l(9)
	stw 0,roam_calls_this_frame@l(10)
	fcmpu 0,11,0
	bc 4,0,.L233
	lis 9,last_bot_spawn@ha
	stw 0,last_bot_spawn@l(9)
.L233:
	lis 9,.LC46@ha
	fmr 13,11
	lis 17,num_players@ha
	la 9,.LC46@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L234
	lis 31,respawn_init@ha
	lwz 0,respawn_init@l(31)
	cmpwi 0,0,0
	bc 4,2,.L235
	lis 3,respawn_bots@ha
	li 4,0
	la 3,respawn_bots@l(3)
	li 5,16384
	crxor 6,6,6
	bl memset
	li 0,1
	stw 0,respawn_init@l(31)
	b .L236
.L235:
	lis 9,respawn_flag@ha
	lwz 0,respawn_flag@l(9)
	cmpwi 0,0,0
	bc 12,2,.L236
	lis 10,last_spawn.51@ha
	li 23,0
	lfs 0,last_spawn.51@l(10)
	fcmpu 0,13,0
	bc 4,0,.L238
	li 0,0
	stw 0,last_spawn.51@l(10)
.L238:
	lis 9,.LC28@ha
	fmr 13,11
	lfs 0,last_spawn.51@l(10)
	lfd 12,.LC28@l(9)
	fsub 13,13,12
	fcmpu 0,0,13
	bc 12,1,.L240
	lis 9,respawn_bots@ha
	lis 11,respawn_ctf_teams@ha
	stfs 11,last_spawn.51@l(10)
	la 25,respawn_bots@l(9)
	la 21,respawn_ctf_teams@l(11)
	lis 9,respawn_bot_teams@ha
	li 30,0
	la 22,respawn_bot_teams@l(9)
	lis 24,force_team@ha
	li 26,0
	mr 27,25
	li 28,0
	li 31,0
.L244:
	lbzx 0,31,25
	cmpwi 0,0,0
	bc 12,2,.L243
	lwzx 0,28,21
	mr 3,27
	stw 0,force_team@l(24)
	bl spawn_bot
	mr. 29,3
	stw 26,force_team@l(24)
	bc 12,2,.L247
	lwzx 0,28,22
	cmpwi 0,0,0
	bc 12,2,.L246
	lwz 9,84(29)
	stw 0,3912(9)
.L246:
	lwz 3,84(29)
	mr 4,27
	addi 3,3,700
	bl strcpy
.L247:
	addi 23,23,1
	stbx 26,31,25
	cmpwi 0,23,2
	bc 12,1,.L240
.L243:
	addi 30,30,1
	addi 27,27,256
	cmpwi 0,30,63
	addi 28,28,4
	addi 31,31,256
	bc 4,1,.L244
	lis 9,respawn_flag@ha
	li 0,0
	stw 0,respawn_flag@l(9)
	b .L240
.L236:
	lis 9,ctf@ha
	lis 10,.LC43@ha
	lwz 11,ctf@l(9)
	la 10,.LC43@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L250
	lis 9,ctf_auto_teams@ha
	lwz 11,ctf_auto_teams@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L250
	lis 11,.LC45@ha
	lis 9,level+4@ha
	la 11,.LC45@l(11)
	lfs 0,level+4@l(9)
	lis 17,num_players@ha
	lfs 12,0(11)
	lis 18,players_per_team@ha
	lis 11,last_ctf_teams.50@ha
	lfs 13,last_ctf_teams.50@l(11)
	fsubs 0,0,12
	fcmpu 0,13,0
	bc 4,0,.L284
	lwz 0,num_players@l(17)
	li 8,0
	li 6,0
	li 3,0
	li 31,0
	cmpwi 0,0,0
	bc 4,1,.L253
	lis 9,players@ha
	mr 30,0
	la 7,players@l(9)
.L255:
	lwz 10,0(7)
	addi 7,7,4
	lwz 11,84(10)
	lwz 0,3468(11)
	cmpwi 0,0,1
	bc 4,2,.L256
	lwz 0,968(10)
	addi 8,8,1
	cmpwi 0,0,0
	bc 12,2,.L254
	cmpwi 0,3,0
	bc 12,2,.L259
	lwz 9,84(3)
	lwz 11,3464(11)
	lwz 0,3464(9)
	cmpw 0,11,0
	bc 4,0,.L254
.L259:
	mr 3,10
	b .L254
.L256:
	cmpwi 0,0,2
	bc 4,2,.L254
	lwz 0,968(10)
	addi 6,6,1
	cmpwi 0,0,0
	bc 12,2,.L254
	cmpwi 0,31,0
	bc 12,2,.L264
	lwz 9,84(31)
	lwz 11,3464(11)
	lwz 0,3464(9)
	cmpw 0,11,0
	bc 4,0,.L254
.L264:
	mr 31,10
.L254:
	addic. 30,30,-1
	bc 4,2,.L255
.L253:
	cmpw 0,8,6
	bc 12,2,.L266
	bc 4,1,.L267
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,684(1)
	lis 10,.LC42@ha
	la 10,.LC42@l(10)
	stw 11,680(1)
	lfd 12,0(10)
	lfd 0,680(1)
	lis 10,ctf_auto_teams@ha
	lwz 11,ctf_auto_teams@l(10)
	fsub 0,0,12
	lfs 13,20(11)
	frsp 0,0
	fcmpu 0,0,13
	bc 4,1,.L268
	cmpwi 0,3,0
	bc 12,2,.L412
	bl botDisconnect
	b .L284
.L268:
	bc 4,0,.L284
	b .L412
.L267:
	xoris 0,6,0x8000
	lis 11,0x4330
	stw 0,684(1)
	lis 10,.LC42@ha
	la 10,.LC42@l(10)
	stw 11,680(1)
	lfd 12,0(10)
	lfd 0,680(1)
	lis 10,ctf_auto_teams@ha
	lwz 11,ctf_auto_teams@l(10)
	fsub 0,0,12
	lfs 13,20(11)
	frsp 0,0
	fcmpu 0,0,13
	bc 4,1,.L274
	cmpwi 0,31,0
	bc 4,2,.L413
	b .L412
.L274:
	bc 4,0,.L284
	b .L412
.L266:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,684(1)
	lis 10,.LC42@ha
	la 10,.LC42@l(10)
	stw 11,680(1)
	lfd 12,0(10)
	lfd 0,680(1)
	lis 10,ctf_auto_teams@ha
	lwz 11,ctf_auto_teams@l(10)
	fsub 0,0,12
	lfs 13,20(11)
	frsp 0,0
	fcmpu 0,0,13
	bc 4,1,.L280
	addic 11,3,-1
	subfe 9,11,3
	addic 10,31,-1
	subfe 0,10,31
	and. 11,9,0
	bc 12,2,.L284
	bl botDisconnect
.L413:
	mr 3,31
	bl botDisconnect
	b .L284
.L280:
	bc 4,0,.L284
	li 3,0
	bl spawn_bot
.L412:
	li 3,0
	bl spawn_bot
	b .L284
.L250:
	lis 31,spawn_bots@ha
	lwz 0,spawn_bots@l(31)
	cmpwi 0,0,0
	bc 12,1,.L286
	lis 9,bot_count@ha
	lwz 0,bot_count@l(9)
	lis 8,0x4330
	lis 9,.LC42@ha
	xoris 0,0,0x8000
	la 9,.LC42@l(9)
	stw 0,684(1)
	stw 8,680(1)
	lfd 12,0(9)
	lfd 0,680(1)
	lis 9,bot_num@ha
	lwz 10,bot_num@l(9)
	fsub 0,0,12
	lfs 13,20(10)
	frsp 0,0
	fcmpu 0,0,13
	bc 4,0,.L285
.L286:
	lis 9,level+4@ha
	lis 10,.LC47@ha
	lfs 0,level+4@l(9)
	lis 11,last_bot_spawn@ha
	la 10,.LC47@l(10)
	lfd 12,0(10)
	lfs 13,last_bot_spawn@l(11)
	fsub 0,0,12
	fcmpu 0,13,0
	bc 4,0,.L285
	lis 9,num_players@ha
	lwz 0,num_players@l(9)
	lis 7,0x4330
	lis 10,bot_free_clients@ha
	lis 9,maxclients@ha
	lis 17,num_players@ha
	lwz 8,maxclients@l(9)
	xoris 0,0,0x8000
	lis 9,.LC42@ha
	stw 0,684(1)
	la 9,.LC42@l(9)
	stw 7,680(1)
	lfd 11,0(9)
	lfd 0,680(1)
	lwz 9,bot_free_clients@l(10)
	lfs 13,20(8)
	lfs 12,20(9)
	fsub 0,0,11
	fsubs 13,13,12
	frsp 0,0
	fcmpu 0,0,13
	bc 4,0,.L288
	li 3,0
	bl spawn_bot
.L288:
	lwz 9,spawn_bots@l(31)
	lis 18,players_per_team@ha
	cmpwi 0,9,0
	bc 4,1,.L284
	addi 0,9,-1
	stw 0,spawn_bots@l(31)
	b .L284
.L285:
	lis 31,bot_name@ha
	lis 17,num_players@ha
	lwz 9,bot_name@l(31)
	lis 18,players_per_team@ha
	lwz 3,4(9)
	bl strlen
	cmplwi 0,3,1
	bc 4,1,.L284
	lwz 0,num_players@l(17)
	lis 9,maxclients@ha
	lwz 10,maxclients@l(9)
	lis 8,0x4330
	lis 7,bot_free_clients@ha
	xoris 0,0,0x8000
	lis 9,.LC42@ha
	stw 0,684(1)
	la 9,.LC42@l(9)
	stw 8,680(1)
	lfd 12,0(9)
	lfd 0,680(1)
	lwz 9,bot_free_clients@l(7)
	lfs 13,20(10)
	lfs 11,20(9)
	fsub 0,0,12
	fsubs 13,13,11
	frsp 0,0
	fcmpu 0,0,13
	bc 4,0,.L292
	lwz 9,bot_name@l(31)
	lwz 3,4(9)
	bl spawn_bot
	b .L293
.L292:
	fmr 13,11
	lis 9,gi+4@ha
	lwz 0,gi+4@l(9)
	lis 3,.LC29@ha
	la 3,.LC29@l(3)
	fctiwz 0,13
	mtlr 0
	stfd 0,680(1)
	lwz 4,684(1)
	crxor 6,6,6
	blrl
.L293:
	lis 9,gi+148@ha
	lis 3,.LC30@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC31@ha
	la 3,.LC30@l(3)
	la 4,.LC31@l(4)
	lis 18,players_per_team@ha
	mtlr 0
	blrl
.L284:
	lis 9,ctf@ha
	lis 10,.LC43@ha
	lwz 11,ctf@l(9)
	la 10,.LC43@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L294
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L294
	lis 11,addteam@ha
	lis 28,addteam@ha
	lwz 9,addteam@l(11)
	lwz 3,4(9)
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L294
	lis 9,bot_teams@ha
	li 30,0
	la 9,bot_teams@l(9)
	lwzx 0,9,30
	cmpwi 0,0,0
	bc 12,2,.L296
	mr 29,9
	li 27,1
	li 31,0
.L298:
	lwzx 9,31,29
	lwz 11,addteam@l(28)
	lwz 3,0(9)
	lwz 4,4(11)
	bl strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L300
	lwzx 9,31,29
	lwz 11,addteam@l(28)
	lwz 3,4(9)
	lwz 4,4(11)
	bl strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L299
.L300:
	lwzx 9,31,29
	stw 27,140(9)
	b .L296
.L299:
	addi 30,30,1
	addi 31,31,4
	cmpwi 0,30,63
	bc 12,1,.L296
	lwzx 0,31,29
	cmpwi 0,0,0
	bc 4,2,.L298
.L296:
	cmpwi 0,30,64
	bc 4,2,.L302
	lis 9,addteam@ha
	lis 11,gi+4@ha
	lwz 10,addteam@l(9)
	lis 3,.LC32@ha
	lwz 0,gi+4@l(11)
	la 3,.LC32@l(3)
	lwz 4,4(10)
	mtlr 0
	crxor 6,6,6
	blrl
.L302:
	lis 9,gi+148@ha
	lis 3,.LC33@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC31@ha
	la 3,.LC33@l(3)
	la 4,.LC31@l(4)
	mtlr 0
	blrl
.L294:
	lis 9,.LC48@ha
	lis 11,players_per_team@ha
	la 9,.LC48@l(9)
	lfs 13,0(9)
	lwz 9,players_per_team@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,1,.L303
	lis 4,.LC34@ha
	li 5,32
	la 4,.LC34@l(4)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	lis 29,gi@ha
	lis 3,.LC35@ha
	la 29,gi@l(29)
	addi 4,1,8
	lwz 9,148(29)
	la 3,.LC35@l(3)
	mtlr 9
	blrl
	lwz 0,4(29)
	lis 3,.LC36@ha
	li 4,32
	la 3,.LC36@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L303:
	lis 9,ctf@ha
	lis 10,.LC43@ha
	lwz 11,ctf@l(9)
	la 10,.LC43@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L234
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L234
	lis 9,bot_teams@ha
	li 30,0
	la 9,bot_teams@l(9)
	lis 19,bot_teams@ha
	lwzx 0,9,30
	cmpwi 0,0,0
	bc 12,2,.L234
	mr 21,9
.L309:
	slwi 9,30,2
	addi 20,30,1
	mr 28,9
	lwzx 9,21,9
	lwz 0,140(9)
	cmpwi 0,0,0
	bc 12,2,.L307
	lwz 0,148(9)
	lis 11,0x4330
	lis 10,.LC42@ha
	la 10,.LC42@l(10)
	xoris 0,0,0x8000
	lfd 13,0(10)
	stw 0,684(1)
	stw 11,680(1)
	lfd 0,680(1)
	lwz 10,players_per_team@l(18)
	fsub 0,0,13
	lfs 12,20(10)
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L307
	lis 11,.LC43@ha
	li 23,0
	la 11,.LC43@l(11)
	lfs 0,0(11)
	fcmpu 0,0,12
	bc 4,0,.L307
	lis 9,.LC42@ha
	addi 24,1,152
	la 9,.LC42@l(9)
	lis 22,0x4330
	lfd 31,0(9)
	li 25,0
.L315:
	lwzx 9,21,28
	addi 9,9,12
	lwzx 4,9,25
	cmpwi 0,4,0
	bc 12,2,.L314
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L314
	lwz 0,num_players@l(17)
	li 31,0
	addi 29,1,24
	lwz 27,4(4)
	cmpw 0,31,0
	bc 4,0,.L331
	lis 9,players@ha
	li 26,0
	la 30,players@l(9)
.L321:
	lwz 9,0(30)
	addi 3,1,24
	addi 30,30,4
	lwz 4,84(9)
	addi 4,4,700
	bl strcpy
	lbz 0,0(29)
	li 9,0
	cmpwi 0,0,0
	bc 12,2,.L327
	cmpwi 0,0,91
	bc 4,2,.L325
	stbx 9,29,9
	b .L327
.L325:
	addi 9,9,1
	lbzx 0,29,9
	cmpwi 0,0,0
	bc 12,2,.L327
	cmpwi 0,0,91
	bc 4,2,.L325
	stbx 26,29,9
.L327:
	addi 3,1,24
	mr 4,27
	bl strcasecmp
	cmpwi 0,3,0
	li 0,1
	bc 12,2,.L329
	lwz 0,num_players@l(17)
	addi 31,31,1
	cmpw 0,31,0
	bc 12,0,.L321
.L331:
	li 0,0
.L329:
	cmpwi 0,0,0
	bc 4,2,.L314
	la 31,bot_teams@l(19)
	lwzx 9,31,28
	lwz 3,8(9)
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L332
	lwzx 9,31,28
	addi 10,9,12
	lwz 4,8(9)
	lwzx 11,10,25
	lwz 3,8(11)
	bl strcpy
.L332:
	lwzx 9,31,28
	addi 9,9,12
	lwzx 11,9,25
	lwz 3,4(11)
	bl spawn_bot
	mr. 29,3
	bc 12,2,.L314
	lwzx 10,31,28
	lis 4,.LC37@ha
	la 4,.LC37@l(4)
	lwz 9,148(10)
	addi 9,9,1
	stw 9,148(10)
	lwzx 11,31,28
	lwz 9,152(11)
	addi 9,9,1
	stw 9,152(11)
	lwz 10,84(29)
	lwzx 0,31,28
	stw 0,3912(10)
	lwz 3,84(29)
	addi 3,3,700
	bl strcat
	lwzx 9,31,28
	lwz 3,84(29)
	lwz 4,4(9)
	addi 3,3,700
	bl strcat
	lwz 3,84(29)
	lis 4,.LC38@ha
	la 4,.LC38@l(4)
	addi 3,3,700
	bl strcat
	lwz 4,84(29)
	mr 3,24
	addi 4,4,188
	bl strcpy
	lwz 5,84(29)
	lis 4,.LC39@ha
	mr 3,24
	la 4,.LC39@l(4)
	addi 5,5,700
	bl Info_SetValueForKey
	mr 3,29
	mr 4,24
	bl ClientUserinfoChanged
	lwzx 10,31,28
	lwz 9,players_per_team@l(18)
	lwz 0,148(10)
	lfs 13,20(9)
	xoris 0,0,0x8000
	stw 0,684(1)
	stw 22,680(1)
	lfd 0,680(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,2,.L307
.L314:
	addi 23,23,1
	lwz 11,players_per_team@l(18)
	xoris 0,23,0x8000
	addi 25,25,4
	stw 0,684(1)
	stw 22,680(1)
	lfd 0,680(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L315
.L307:
	mr 30,20
	cmpwi 0,30,63
	bc 12,1,.L234
	slwi 0,30,2
	lwzx 9,21,0
	cmpwi 0,9,0
	bc 4,2,.L309
.L234:
	lis 9,bot_count@ha
	lis 19,bot_drop@ha
	lwz 0,bot_count@l(9)
	cmpwi 0,0,0
	bc 4,1,.L337
	lis 9,num_players@ha
	lwz 6,num_players@l(9)
	lis 7,0x4330
	lis 10,bot_free_clients@ha
	lis 9,maxclients@ha
	lwz 8,maxclients@l(9)
	xoris 0,6,0x8000
	lis 9,.LC42@ha
	stw 0,684(1)
	la 9,.LC42@l(9)
	stw 7,680(1)
	lfd 11,0(9)
	lfd 0,680(1)
	lwz 9,bot_free_clients@l(10)
	lfs 13,20(8)
	lfs 12,20(9)
	fsub 0,0,11
	fsubs 13,13,12
	frsp 0,0
	fcmpu 0,0,13
	bc 4,1,.L337
	li 3,0
	cmpw 0,3,6
	bc 4,0,.L339
	mtctr 6
	lis 9,players@ha
	la 7,players@l(9)
.L341:
	lwz 8,0(7)
	addi 7,7,4
	lwz 0,968(8)
	cmpwi 0,0,0
	bc 12,2,.L340
	cmpwi 0,3,0
	bc 12,2,.L344
	lwz 9,84(8)
	lwz 11,84(3)
	lwz 10,3464(9)
	lwz 0,3464(11)
	cmpw 0,10,0
	bc 4,0,.L340
.L344:
	mr 3,8
.L340:
	bdnz .L341
.L339:
	cmpwi 0,3,0
	bc 12,2,.L337
	bl botDisconnect
.L337:
	lis 9,ctf@ha
	lis 10,.LC43@ha
	lwz 11,ctf@l(9)
	la 10,.LC43@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L347
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L347
	lis 9,bot_teams@ha
	li 11,0
	la 10,bot_teams@l(9)
	lwzx 0,10,11
	cmpwi 0,0,0
	bc 12,2,.L347
	lis 9,level@ha
	mr 23,10
	la 20,level@l(9)
	lis 21,players@ha
	lis 22,bot_teams@ha
.L352:
	slwi 9,11,2
	addi 27,11,1
	mr 28,9
	lwzx 9,23,9
	lwz 0,140(9)
	cmpwi 0,0,0
	bc 12,2,.L350
	lwz 0,148(9)
	lis 8,0x4330
	lis 9,.LC42@ha
	xoris 0,0,0x8000
	la 9,.LC42@l(9)
	stw 0,684(1)
	stw 8,680(1)
	lfd 12,0(9)
	lfd 0,680(1)
	lis 9,players_per_team@ha
	lwz 10,players_per_team@l(9)
	fsub 0,0,12
	lfs 13,20(10)
	frsp 0,0
	fcmpu 0,0,13
	bc 4,1,.L354
	lwz 0,num_players@l(17)
	li 3,0
	cmpwi 0,0,0
	bc 4,1,.L356
	lis 9,num_players@ha
	la 6,bot_teams@l(22)
	lwz 30,num_players@l(9)
	mr 7,28
	la 8,players@l(21)
.L358:
	lwz 10,0(8)
	addi 8,8,4
	lwz 0,968(10)
	cmpwi 0,0,0
	bc 12,2,.L357
	lwz 11,84(10)
	lwzx 9,6,7
	lwz 0,3912(11)
	cmpw 0,0,9
	bc 4,2,.L357
	cmpwi 0,3,0
	bc 12,2,.L362
	lwz 9,84(3)
	lwz 11,3464(11)
	lwz 0,3464(9)
	cmpw 0,11,0
	bc 4,0,.L357
.L362:
	mr 3,10
.L357:
	addic. 30,30,-1
	bc 4,2,.L358
.L356:
	cmpwi 0,3,0
	bc 12,2,.L354
	bl botDisconnect
.L354:
	lfs 1,4(20)
	bl floor
	lfs 13,4(20)
	frsp 1,1
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 0,0(9)
	fsubs 1,13,1
	fcmpu 0,1,0
	bc 4,2,.L350
	lis 10,.LC49@ha
	lwzx 9,23,28
	la 10,.LC49@l(10)
	lfs 0,0(10)
	fsubs 0,13,0
	lfs 13,156(9)
	fcmpu 0,13,0
	bc 4,0,.L350
	lwz 0,num_players@l(17)
	li 30,0
	cmpw 0,30,0
	bc 4,0,.L350
	lis 11,botShotgun@ha
	lis 9,botBlaster@ha
	la 25,botShotgun@l(11)
	la 24,botBlaster@l(9)
	lis 11,.LC50@ha
	la 29,players@l(21)
	la 11,.LC50@l(11)
	la 26,bot_teams@l(22)
	lfs 31,0(11)
	li 31,0
.L370:
	lwzx 3,31,29
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 12,2,.L369
	lwz 9,84(3)
	lwzx 11,26,28
	lwz 0,3912(9)
	cmpw 0,0,11
	bc 4,2,.L369
	lwz 0,480(3)
	cmpwi 0,0,80
	bc 4,1,.L369
	lwz 0,612(3)
	cmpwi 0,0,0
	bc 4,2,.L369
	lwz 0,980(3)
	cmpw 0,0,24
	bc 12,2,.L369
	cmpw 0,0,25
	bc 12,2,.L369
	lwz 0,324(3)
	cmpwi 0,0,0
	bc 4,2,.L369
	lwz 0,540(3)
	cmpwi 0,0,0
	bc 4,2,.L369
	lwz 4,416(3)
	cmpwi 0,4,0
	bc 12,2,.L372
	bl entdist
	fcmpu 0,1,31
	bc 4,1,.L369
.L372:
	lwzx 3,31,29
	bl TeamGroup
	b .L350
.L369:
	lwz 0,num_players@l(17)
	addi 30,30,1
	addi 31,31,4
	cmpw 0,30,0
	bc 12,0,.L370
.L350:
	cmpwi 0,27,63
	mr 11,27
	bc 12,1,.L347
	slwi 0,27,2
	lwzx 9,23,0
	cmpwi 0,9,0
	bc 4,2,.L352
.L347:
	lis 9,bot_drop@ha
	lwz 11,bot_drop@l(9)
	lwz 3,4(11)
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L240
	lis 9,num_players@ha
	li 31,0
	lwz 0,num_players@l(9)
	cmpw 0,31,0
	bc 4,0,.L377
	lis 9,players@ha
	la 30,players@l(9)
.L379:
	lwz 29,0(30)
	addi 30,30,4
	lwz 0,968(29)
	cmpwi 0,0,0
	bc 12,2,.L378
	lwz 9,bot_drop@l(19)
	lwz 3,84(29)
	lwz 4,4(9)
	addi 3,3,700
	bl strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L378
	mr 3,29
	bl botDisconnect
.L378:
	lwz 0,num_players@l(17)
	addi 31,31,1
	cmpw 0,31,0
	bc 12,0,.L379
.L377:
	lis 9,gi+148@ha
	lis 3,.LC40@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC31@ha
	la 3,.LC40@l(3)
	la 4,.LC31@l(4)
	mtlr 0
	blrl
.L240:
	lis 9,num_players@ha
	lwz 0,num_players@l(9)
	cmpwi 0,0,0
	bc 4,1,.L383
	li 30,0
	cmpw 0,30,0
	bc 4,0,.L383
	lis 9,.LC41@ha
	lis 10,.LC26@ha
	lfd 30,.LC41@l(9)
	lis 11,players@ha
	li 31,0
	lfd 31,.LC26@l(10)
	lis 9,level@ha
	la 29,players@l(11)
	la 28,level@l(9)
.L387:
	lwzx 3,31,29
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 12,2,.L386
	bl bot_AnimateFrames
	lfs 0,4(28)
	lwzx 9,31,29
	fmr 12,0
	lfs 13,428(9)
	fsub 0,12,30
	fcmpu 0,13,0
	bc 4,0,.L386
	fadd 0,12,31
	frsp 0,0
	stfs 0,428(9)
.L386:
	lwz 0,num_players@l(17)
	addi 30,30,1
	addi 31,31,4
	cmpw 0,30,0
	bc 12,0,.L387
.L383:
	lis 9,level@ha
	lis 10,.LC43@ha
	la 10,.LC43@l(10)
	la 9,level@l(9)
	lfs 0,0(10)
	lfs 12,200(9)
	fcmpu 0,12,0
	bc 12,2,.L391
	lis 11,.LC51@ha
	lfs 0,4(9)
	la 11,.LC51@l(11)
	lfs 13,0(11)
	fsubs 0,0,13
	fcmpu 0,12,0
	bc 4,0,.L391
	li 0,1
	stw 0,208(9)
.L391:
	lis 9,level@ha
	la 10,level@l(9)
	lwz 0,208(10)
	cmpwi 0,0,0
	bc 4,2,.L414
	lis 9,nextlevelstart@ha
	lfs 13,4(10)
	lfs 0,nextlevelstart@l(9)
	fcmpu 0,0,13
	bc 4,0,.L393
.L414:
	bl ExitLevel
	b .L228
.L393:
	lis 9,globals@ha
	li 30,0
	la 9,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(9)
	lis 28,maxclients@ha
	lis 24,g_edicts@ha
	lwz 29,g_edicts@l(11)
	cmpw 0,30,0
	bc 4,0,.L395
	mr 26,9
	mr 25,10
	lis 9,.LC42@ha
	li 27,0
	la 9,.LC42@l(9)
	lis 31,0x4330
	lfd 31,0(9)
.L397:
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L396
	stw 29,292(25)
	lwz 9,552(29)
	lfs 0,4(29)
	lfs 12,8(29)
	cmpwi 0,9,0
	lfs 13,12(29)
	stfs 0,28(29)
	stfs 12,32(29)
	stfs 13,36(29)
	bc 12,2,.L399
	lwz 9,92(9)
	lwz 0,556(29)
	cmpw 0,9,0
	bc 12,2,.L399
	lwz 0,264(29)
	stw 27,552(29)
	andi. 10,0,3
	bc 4,2,.L399
	lwz 0,184(29)
	andi. 11,0,4
	bc 12,2,.L399
	mr 3,29
	bl M_CheckGround
.L399:
	cmpwi 0,30,0
	bc 4,1,.L401
	xoris 0,30,0x8000
	lwz 11,maxclients@l(28)
	stw 0,684(1)
	stw 31,680(1)
	lfd 0,680(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L401
	lwz 0,968(29)
	cmpwi 0,0,0
	bc 4,2,.L401
	mr 3,29
	bl ClientBeginServerFrame
	b .L396
.L401:
	mr 3,29
	bl G_RunEntity
.L396:
	lwz 0,72(26)
	addi 30,30,1
	addi 29,29,1352
	cmpw 0,30,0
	bc 12,0,.L397
.L395:
	bl CheckDMRules
	li 30,0
	bl CheckNeedPass
	lis 9,.LC43@ha
	lis 11,maxclients@ha
	la 9,.LC43@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L410
	lis 10,.LC42@ha
	lis 29,0x4330
	la 10,.LC42@l(10)
	li 31,1352
	lfd 31,0(10)
.L405:
	lwz 0,g_edicts@l(24)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L408
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L408
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L408
	bl ClientEndServerFrame
.L408:
	addi 30,30,1
	lwz 11,maxclients@l(28)
	xoris 0,30,0x8000
	addi 31,31,1352
	stw 0,684(1)
	stw 29,680(1)
	lfd 0,680(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L405
.L410:
	lis 9,.LC43@ha
	lis 11,dedicated@ha
	la 9,.LC43@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L228
	bl OptimizeRouteCache
.L228:
	lwz 0,772(1)
	mtlr 0
	lmw 17,692(1)
	lfd 30,752(1)
	lfd 31,760(1)
	la 1,768(1)
	blr
.Lfe10:
	.size	 G_RunFrame,.Lfe10-G_RunFrame
	.globl DLL_ExportSymbols
	.section	".data"
	.align 2
	.type	 DLL_ExportSymbols,@object
DLL_ExportSymbols:
	.long dllFindResource
	.long .LC52
	.long dllLoadResource
	.long .LC53
	.long dllFreeResource
	.long .LC54
	.long GetGameAPI
	.long .LC55
	.long SetExeName
	.long .LC56
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC56:
	.string	"SetExeName"
	.align 2
.LC55:
	.string	"GetGameAPI"
	.align 2
.LC54:
	.string	"dllFreeResource"
	.align 2
.LC53:
	.string	"dllLoadResource"
	.align 2
.LC52:
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
	.comm	bot_num,4,4
	.comm	bot_name,4,4
	.comm	bot_allow_client_commands,4,4
	.comm	bot_free_clients,4,4
	.comm	bot_debug,4,4
	.comm	bot_show_connect_info,4,4
	.comm	bot_calc_nodes,4,4
	.comm	bot_debug_nodes,4,4
	.comm	bot_auto_skill,4,4
	.comm	bot_drop,4,4
	.comm	bot_chat,4,4
	.comm	bot_optimize,4,4
	.comm	bot_tarzan,4,4
	.comm	players_per_team,4,4
	.comm	addteam,4,4
	.comm	teamplay,4,4
	.comm	ctf_auto_teams,4,4
	.comm	grapple,4,4
	.comm	ctf_special_teams,4,4
	.comm	ctf_humanonly_teams,4,4
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
	.comm	giveshotgun,4,4
	.comm	givesupershotgun,4,4
	.comm	givemachinegun,4,4
	.comm	givechaingun,4,4
	.comm	givegrenadelauncher,4,4
	.comm	giverocketlauncher,4,4
	.comm	giverailgun,4,4
	.comm	givehyperblaster,4,4
	.comm	givebfg,4,4
	.comm	nobfg,4,4
	.comm	noshotgun,4,4
	.comm	nosupershotgun,4,4
	.comm	nomachinegun,4,4
	.comm	nochaingun,4,4
	.comm	nogrenadelauncher,4,4
	.comm	norocketlauncher,4,4
	.comm	nohyperblaster,4,4
	.comm	norailgun,4,4
	.comm	nomegahealth,4,4
	.comm	noquad,4,4
	.comm	noinvulnerability,4,4
	.comm	swaat,4,4
	.comm	startinghealth,4,4
	.comm	startingshells,4,4
	.comm	startingbullets,4,4
	.comm	startinggrenades,4,4
	.comm	startingrockets,4,4
	.comm	startingslugs,4,4
	.comm	startingcells,4,4
	.comm	maxhealth,4,4
	.comm	maxshells,4,4
	.comm	maxbullets,4,4
	.comm	maxgrenades,4,4
	.comm	maxrockets,4,4
	.comm	maxslugs,4,4
	.comm	maxcells,4,4
	.comm	startingweapon,4,4
	.comm	startingarmorcount,4,4
	.comm	startingarmortype,4,4
	.comm	hook_time,4,4
	.comm	hook_speed,4,4
	.comm	hook_damage,4,4
	.comm	pull_speed,4,4
	.comm	skyhook,4,4
	.comm	protecttime,4,4
	.comm	gibtime,4,4
	.comm	burntime,4,4
	.comm	blindtime,4,4
	.comm	freezetime,4,4
	.comm	flash_radius,4,4
	.comm	freeze_radius,4,4
	.comm	pickuptime,4,4
	.comm	gibdamage,4,4
	.comm	burndamage,4,4
	.comm	regentime,4,4
	.comm	hastetime,4,4
	.comm	futilitytime,4,4
	.comm	inflictiontime,4,4
	.comm	bfktime,4,4
	.comm	stealthtime,4,4
	.comm	homingtime,4,4
	.comm	antitime,4,4
	.comm	regeneration,4,4
	.comm	haste,4,4
	.comm	futility,4,4
	.comm	infliction,4,4
	.comm	bfk,4,4
	.comm	stealth,4,4
	.comm	antikey,4,4
	.comm	homing,4,4
	.comm	droppable,4,4
	.comm	playershells,4,4
	.comm	keyshells,4,4
	.comm	respawntime,4,4
	.comm	qwfraglog,4,4
	.comm	levelcycle,4,4
	.comm	resetlevels,4,4
	.comm	pickupannounce,4,4
	.comm	gibgun,4,4
	.comm	flashgrenades,4,4
	.comm	freezegrenades,4,4
	.comm	firegrenades,4,4
	.comm	firerockets,4,4
	.comm	drunkrockets,4,4
	.comm	hominghyperblaster,4,4
	.comm	allowfeigning,4,4
	.comm	usevwep,4,4
	.comm	damagemultiply,4,4
	.comm	motd1,4,4
	.comm	motd2,4,4
	.comm	motd3,4,4
	.comm	motd4,4,4
	.comm	motd5,4,4
	.comm	motd6,4,4
	.comm	motd7,4,4
	.comm	nextleveldelay,4,4
	.comm	bfgdamage,4,4
	.comm	raildamage,4,4
	.comm	supershotgundamage,4,4
	.comm	shotgundamage,4,4
	.comm	chaingundamage,4,4
	.comm	machinegundamage,4,4
	.comm	hyperdamage,4,4
	.comm	blasterdamage,4,4
	.comm	rocketdamage,4,4
	.comm	rocketradiusdamage,4,4
	.comm	rocketdamageradius,4,4
	.comm	grenadelauncherdamage,4,4
	.comm	handgrenadedamage,4,4
	.comm	totalstealth,4,4
	.comm	nozbots,4,4
	.comm	maxbots,4,4
	.comm	botfraglogging,4,4
	.comm	connectlogging,4,4
	.comm	k2_keyframes,4,4
	.comm	k2_timeleft,4,4
	.comm	k2_fragsleft,4,4
	.comm	nextlevelstart,4,4
	.comm	k2_capsleft,4,4
	.comm	qversion,4,4
	.comm	QWLogFile,4,4
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
	bc 12,2,.L420
	lwz 0,60(9)
	li 3,1
	lis 9,SegList@ha
	stw 0,SegList@l(9)
	b .L422
.L420:
	li 3,0
.L422:
	la 1,160(1)
	blr
.Lfe11:
	.size	 DLL_Init,.Lfe11-DLL_Init
	.align 2
	.globl DLL_DeInit
	.type	 DLL_DeInit,@function
DLL_DeInit:
	blr
.Lfe12:
	.size	 DLL_DeInit,.Lfe12-DLL_DeInit
	.comm	spawn_bots,4,4
	.comm	roam_calls_this_frame,4,4
	.comm	bestdirection_callsthisframe,4,4
	.comm	bot_chat_text,2048,4
	.comm	bot_chat_count,32,4
	.comm	last_bot_chat,32,4
	.comm	num_view_weapons,4,4
	.comm	view_weapon_models,4096,1
	.comm	botdebug,4,4
	.comm	respawn_bots,16384,1
	.comm	PathToEnt_Node,4,4
	.comm	PathToEnt_TargetNode,4,4
	.comm	trail_head,4,4
	.comm	last_head,4,4
	.comm	dropped_trail,4,4
	.comm	last_optimize,4,4
	.comm	optimize_marker,4,4
	.comm	trail_portals,490000,4
	.comm	num_trail_portals,2500,4
	.comm	ctf_item_head,4,4
	.comm	pTempFind,4,4
	.align 2
	.globl ShutdownGame
	.type	 ShutdownGame,@function
ShutdownGame:
	stwu 1,-336(1)
	mflr 0
	stmw 27,316(1)
	stw 0,340(1)
	bl WriteTrail
	lis 27,gi@ha
	addi 28,1,8
	lis 4,level@ha
	li 5,304
	la 4,level@l(4)
	mr 3,28
	la 29,gi@l(27)
	crxor 6,6,6
	bl memcpy
	mr 4,28
	mr 3,29
	bl sl_GameEnd
	lwz 9,4(29)
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
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
	lmw 27,316(1)
	la 1,336(1)
	blr
.Lfe13:
	.size	 ShutdownGame,.Lfe13-ShutdownGame
	.section	".rodata"
	.align 2
.LC57:
	.long 0x0
	.align 3
.LC58:
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
	lis 11,.LC57@ha
	lis 9,maxclients@ha
	la 11,.LC57@l(11)
	li 30,0
	lfs 13,0(11)
	lis 27,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L16
	lis 9,.LC58@ha
	lis 28,g_edicts@ha
	la 9,.LC58@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,1352
.L18:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L17
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L17
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L17
	bl ClientEndServerFrame
.L17:
	addi 30,30,1
	lwz 11,maxclients@l(27)
	xoris 0,30,0x8000
	addi 31,31,1352
	stw 0,28(1)
	stw 29,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L18
.L16:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe14:
	.size	 ClientEndServerFrames,.Lfe14-ClientEndServerFrames
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
.Lfe15:
	.size	 CreateTargetChangeLevel,.Lfe15-CreateTargetChangeLevel
	.comm	respawn_bot_teams,256,4
	.comm	respawn_ctf_teams,256,4
	.align 2
	.globl AllItemsHaveMovetarget
	.type	 AllItemsHaveMovetarget,@function
AllItemsHaveMovetarget:
	mr. 3,3
	bc 12,2,.L120
	lis 9,RemoveDroppedItem@ha
	la 9,RemoveDroppedItem@l(9)
.L121:
	lwz 0,416(3)
	cmpwi 0,0,0
	bc 4,2,.L122
	lwz 0,436(3)
	cmpw 0,0,9
	bc 12,2,.L122
	li 3,0
	blr
.L122:
	lwz 3,936(3)
	cmpwi 0,3,0
	bc 4,2,.L121
.L120:
	li 3,1
	blr
.Lfe16:
	.size	 AllItemsHaveMovetarget,.Lfe16-AllItemsHaveMovetarget
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
	bc 4,0,.L160
	lis 9,players@ha
	addi 31,1,8
	la 29,players@l(9)
	li 28,0
.L162:
	lwz 9,0(29)
	addi 3,1,8
	addi 29,29,4
	lwz 4,84(9)
	addi 4,4,700
	bl strcpy
	lbz 0,0(31)
	li 9,0
	cmpwi 0,0,0
	bc 12,2,.L164
	cmpwi 0,0,91
	bc 4,2,.L165
	stbx 9,31,9
	b .L164
.L165:
	addi 9,9,1
	lbzx 0,31,9
	cmpwi 0,0,0
	bc 12,2,.L164
	cmpwi 0,0,91
	bc 4,2,.L165
	stbx 28,31,9
.L164:
	addi 3,1,8
	mr 4,27
	bl strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L161
	li 3,1
	b .L424
.L161:
	lwz 0,num_players@l(26)
	addi 30,30,1
	cmpw 0,30,0
	bc 12,0,.L162
.L160:
	li 3,0
.L424:
	lwz 0,164(1)
	mtlr 0
	lmw 26,136(1)
	la 1,160(1)
	blr
.Lfe17:
	.size	 PlayerNameExists,.Lfe17-PlayerNameExists
	.align 2
	.globl SetExeName
	.type	 SetExeName,@function
SetExeName:
	lis 9,exe_found@ha
	li 0,1
	stw 0,exe_found@l(9)
	blr
.Lfe18:
	.size	 SetExeName,.Lfe18-SetExeName
	.align 2
	.globl dllFindResource
	.type	 dllFindResource,@function
dllFindResource:
	li 3,0
	blr
.Lfe19:
	.size	 dllFindResource,.Lfe19-dllFindResource
	.align 2
	.globl dllLoadResource
	.type	 dllLoadResource,@function
dllLoadResource:
	li 3,0
	blr
.Lfe20:
	.size	 dllLoadResource,.Lfe20-dllLoadResource
	.align 2
	.globl dllFreeResource
	.type	 dllFreeResource,@function
dllFreeResource:
	blr
.Lfe21:
	.size	 dllFreeResource,.Lfe21-dllFreeResource
	.comm	SegList,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
