	.file	"g_main.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 stuff_light,@object
	.size	 stuff_light,4
stuff_light:
	.long 1
	.globl exe_found
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
	li 21,952
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
	.section	".rodata"
	.align 2
.LC4:
	.long 0x4479c000
	.align 2
.LC5:
	.long 0x0
	.align 3
.LC6:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl EndDMLevel
	.type	 EndDMLevel,@function
EndDMLevel:
	stwu 1,-160(1)
	mflr 0
	stmw 18,104(1)
	stw 0,164(1)
	lis 9,last_beat@ha
	li 31,0
	lwz 0,last_beat@l(9)
	li 21,1
	cmpwi 0,0,0
	bc 12,2,.L24
	stw 31,last_beat@l(9)
	b .L25
.L24:
	stw 21,last_beat@l(9)
.L25:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,96(1)
	lwz 11,100(1)
	andi. 0,11,32
	bc 12,2,.L26
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
.L26:
	lis 9,maxclients@ha
	lis 11,.LC5@ha
	lwz 10,maxclients@l(9)
	la 11,.LC5@l(11)
	li 7,0
	lfs 0,0(11)
	lfs 13,20(10)
	lis 11,g_edicts@ha
	lwz 9,g_edicts@l(11)
	fcmpu 0,0,13
	addi 8,9,952
	bc 4,0,.L29
	lis 9,.LC6@ha
	fmr 12,13
	lis 6,0x4330
	la 9,.LC6@l(9)
	lfd 13,0(9)
.L31:
	addi 7,7,1
	lwz 0,88(8)
	xoris 9,7,0x8000
	addi 11,31,1
	stw 9,100(1)
	addic 0,0,-1
	subfe 0,0,0
	addi 8,8,952
	stw 6,96(1)
	andc 11,11,0
	lfd 0,96(1)
	and 0,31,0
	or 31,0,11
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L31
.L29:
	lis 9,sv_maplist@ha
	lwz 11,sv_maplist@l(9)
	lwz 10,4(11)
	lbz 0,0(10)
	cmpwi 0,0,0
	bc 12,2,.L34
	lis 9,sv_maplist2@ha
	lwz 11,sv_maplist2@l(9)
	lwz 10,4(11)
	lbz 0,0(10)
	cmpwi 0,0,0
	bc 4,2,.L35
	lis 11,.LC4@ha
	lis 9,sv_maplist_small_max@ha
	lfs 0,.LC4@l(11)
	lwz 10,sv_maplist_small_max@l(9)
	stfs 0,20(10)
.L35:
	lis 9,sv_maplist3@ha
	lwz 11,sv_maplist3@l(9)
	lwz 10,4(11)
	lbz 0,0(10)
	cmpwi 0,0,0
	bc 4,2,.L36
	lis 11,.LC4@ha
	lis 9,sv_maplist_medium_max@ha
	lfs 0,.LC4@l(11)
	lwz 10,sv_maplist_medium_max@l(9)
	stfs 0,20(10)
.L36:
	lis 3,maplist_lastmap@ha
	lis 18,maplist_lastmap@ha
	la 3,maplist_lastmap@l(3)
	lis 23,seps.24@ha
	bl strlen
	lis 20,maplist2_lastmap@ha
	lis 19,maplist3_lastmap@ha
	cmpwi 0,3,0
	bc 4,2,.L37
	lis 9,sv_maplist@ha
	addi 29,1,72
	lwz 11,sv_maplist@l(9)
	mr 30,29
	lwz 3,4(11)
	bl strdup
	stw 3,72(1)
	lwz 4,seps.24@l(23)
	mr 3,29
	b .L80
.L40:
	lwz 4,seps.24@l(23)
	mr 3,30
.L80:
	bl strsep
	mr 4,3
	la 3,maplist_lastmap@l(18)
	bl strcpy
	lwz 0,72(1)
	cmpwi 0,0,0
	bc 4,2,.L40
.L37:
	lis 3,maplist2_lastmap@ha
	la 3,maplist2_lastmap@l(3)
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L42
	lis 9,sv_maplist2@ha
	addi 29,1,72
	lwz 11,sv_maplist2@l(9)
	mr 30,29
	lwz 3,4(11)
	bl strdup
	lis 9,seps.24@ha
	stw 3,72(1)
	lwz 4,seps.24@l(9)
	mr 3,29
	b .L81
.L45:
	lwz 4,seps.24@l(23)
	mr 3,30
.L81:
	bl strsep
	mr 4,3
	la 3,maplist2_lastmap@l(20)
	bl strcpy
	lwz 0,72(1)
	cmpwi 0,0,0
	bc 4,2,.L45
.L42:
	lis 3,maplist3_lastmap@ha
	la 3,maplist3_lastmap@l(3)
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L47
	lis 9,sv_maplist3@ha
	addi 29,1,72
	lwz 11,sv_maplist3@l(9)
	mr 30,29
	lwz 3,4(11)
	bl strdup
	lis 9,seps.24@ha
	stw 3,72(1)
	lwz 4,seps.24@l(9)
	mr 3,29
	b .L82
.L50:
	lwz 4,seps.24@l(23)
	mr 3,30
.L82:
	bl strsep
	mr 4,3
	la 3,maplist3_lastmap@l(19)
	bl strcpy
	lwz 0,72(1)
	cmpwi 0,0,0
	bc 4,2,.L50
.L47:
	bl getMaplistSmallMax
	cmpw 0,31,3
	bc 12,1,.L52
	lis 9,sv_maplist@ha
	lwz 11,sv_maplist@l(9)
	lwz 3,4(11)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L52
	bl strdup
	li 21,1
	mr 22,3
	lis 4,maplist_lastmap@ha
	la 4,maplist_lastmap@l(4)
	addi 3,1,8
	bl strcpy
.L52:
	bl getMaplistSmallMax
	cmpw 0,31,3
	bc 4,1,.L53
	bl getMaplistMediumMax
	cmpw 0,31,3
	bc 12,1,.L53
	lis 9,sv_maplist2@ha
	lwz 11,sv_maplist2@l(9)
	lwz 3,4(11)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L53
	bl strdup
	li 21,2
	mr 22,3
	lis 4,maplist2_lastmap@ha
	la 4,maplist2_lastmap@l(4)
	addi 3,1,8
	bl strcpy
.L53:
	bl getMaplistMediumMax
	cmpw 0,31,3
	bc 4,1,.L54
	lis 9,sv_maplist3@ha
	lwz 11,sv_maplist3@l(9)
	lwz 3,4(11)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L54
	bl strdup
	li 21,3
	mr 22,3
	lis 4,maplist3_lastmap@ha
	la 4,maplist3_lastmap@l(4)
	addi 3,1,8
	bl strcpy
.L54:
	lis 9,seps.24@ha
	mr 3,22
	lwz 4,seps.24@l(9)
	li 31,0
	bl strtok
	mr. 28,3
	bc 12,2,.L56
	lis 29,level+72@ha
	lis 9,.LC2@ha
	la 30,level+72@l(29)
	la 26,.LC2@l(9)
	addi 24,30,64
	lis 27,.LC1@ha
	lis 25,level+136@ha
.L57:
	addi 3,1,8
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L60
	mr 3,28
	addi 4,1,8
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L59
.L60:
	mr 3,28
	la 4,level+72@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L58
.L59:
	lwz 4,seps.24@l(23)
	li 3,0
	bl strtok
	mr. 28,3
	bc 4,2,.L61
	cmpwi 0,31,0
	bc 4,2,.L62
	bl G_Spawn
	mr 29,3
	li 4,64
	la 5,.LC1@l(27)
	addi 3,30,64
	stw 26,280(29)
	mr 6,30
	crxor 6,6,6
	bl Com_sprintf
	mr 3,29
	stw 24,504(29)
	bl BeginIntermission
	mr 4,30
	b .L83
.L62:
	bl G_Spawn
	mr 29,3
	li 4,64
	la 5,.LC1@l(27)
	la 3,level+136@l(25)
	stw 26,280(29)
	mr 6,31
	crxor 6,6,6
	bl Com_sprintf
	mr 3,29
	stw 24,504(29)
	bl BeginIntermission
	mr 4,31
.L83:
	addi 3,1,8
	bl strcpy
	b .L66
.L61:
	bl G_Spawn
	mr 29,3
	li 4,64
	la 5,.LC1@l(27)
	la 3,level+136@l(25)
	stw 26,280(29)
	mr 6,28
	crxor 6,6,6
	bl Com_sprintf
	mr 3,29
	stw 24,504(29)
	bl BeginIntermission
	mr 4,28
	addi 3,1,8
	bl strcpy
.L66:
	cmpwi 0,21,1
	bc 4,2,.L68
	la 3,maplist_lastmap@l(18)
	b .L84
.L68:
	cmpwi 0,21,2
	bc 4,2,.L70
	la 3,maplist2_lastmap@l(20)
.L84:
	addi 4,1,8
	bl strcpy
	b .L69
.L70:
	cmpwi 0,21,3
	bc 4,2,.L69
	la 3,maplist3_lastmap@l(19)
	addi 4,1,8
	bl strcpy
.L69:
	mr 3,22
	bl free
	b .L23
.L58:
	srawi 9,31,31
	lwz 4,seps.24@l(23)
	li 3,0
	xor 0,9,31
	subf 0,0,9
	srawi 0,0,31
	andc 9,28,0
	and 0,31,0
	or 31,0,9
	bl strtok
	mr. 28,3
	bc 4,2,.L57
.L56:
	mr 3,22
	bl free
.L34:
	lis 9,level@ha
	la 28,level@l(9)
	lbz 0,136(28)
	cmpwi 0,0,0
	bc 12,2,.L75
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
	b .L23
.L75:
	lis 5,.LC2@ha
	li 3,0
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 3,3
	bc 4,2,.L78
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
	b .L23
.L78:
	bl BeginIntermission
.L23:
	lwz 0,164(1)
	mtlr 0
	lmw 18,104(1)
	la 1,160(1)
	blr
.Lfe4:
	.size	 EndDMLevel,.Lfe4-EndDMLevel
	.section	".rodata"
	.align 2
.LC7:
	.string	"none"
	.align 2
.LC8:
	.string	"needpass"
	.align 2
.LC9:
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
	bc 4,2,.L87
	lwz 9,spectator_password@l(29)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L86
.L87:
	lis 9,spectator_password@ha
	li 10,0
	lwz 11,spectator_password@l(9)
	li 31,0
	stw 10,16(11)
	lwz 3,4(8)
	stw 10,16(8)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L88
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl Q_stricmp
	addic 0,3,-1
	subfe 31,0,3
.L88:
	lwz 9,spectator_password@l(29)
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L89
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl Q_stricmp
	addic 3,3,-1
	subfe 3,3,3
	ori 0,31,2
	andc 0,0,3
	and 3,31,3
	or 31,3,0
.L89:
	lis 29,gi@ha
	lis 3,.LC9@ha
	la 29,gi@l(29)
	mr 4,31
	la 3,.LC9@l(3)
	crxor 6,6,6
	bl va
	mr 4,3
	lwz 0,148(29)
	lis 3,.LC8@ha
	la 3,.LC8@l(3)
	mtlr 0
	blrl
.L86:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 CheckNeedPass,.Lfe5-CheckNeedPass
	.section	".rodata"
	.align 2
.LC10:
	.string	"Timelimit hit.\n"
	.align 2
.LC11:
	.string	"Fraglimit hit.\n"
	.align 2
.LC12:
	.long 0x0
	.align 2
.LC13:
	.long 0x42700000
	.align 3
.LC14:
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
	lis 11,.LC12@ha
	la 11,.LC12@l(11)
	la 10,level@l(9)
	lfs 13,0(11)
	lfs 0,200(10)
	fcmpu 0,0,13
	bc 4,2,.L90
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L90
	lis 9,timelimit@ha
	lwz 11,timelimit@l(9)
	lfs 12,20(11)
	fcmpu 0,12,13
	bc 12,2,.L93
	lis 9,.LC13@ha
	lfs 13,4(10)
	la 9,.LC13@l(9)
	lfs 0,0(9)
	fmuls 0,12,0
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L93
	lis 9,gi@ha
	lis 4,.LC10@ha
	lwz 0,gi@l(9)
	la 4,.LC10@l(4)
	b .L104
.L103:
	lis 9,gi@ha
	lis 4,.LC11@ha
	lwz 0,gi@l(9)
	la 4,.LC11@l(4)
.L104:
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	bl EndDMLevel
	b .L90
.L93:
	lis 9,fraglimit@ha
	lis 11,.LC12@ha
	lwz 8,fraglimit@l(9)
	la 11,.LC12@l(11)
	lfs 13,0(11)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L90
	lis 11,maxclients@ha
	li 7,0
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L90
	lis 9,game+1028@ha
	lis 11,g_edicts@ha
	fmr 11,0
	lwz 10,game+1028@l(9)
	mr 6,8
	lwz 9,g_edicts@l(11)
	lis 8,0x4330
	lis 11,.LC14@ha
	addi 10,10,3464
	la 11,.LC14@l(11)
	lfd 12,0(11)
	addi 11,9,1040
.L99:
	lwz 0,0(11)
	addi 11,11,952
	cmpwi 0,0,0
	bc 12,2,.L98
	lwz 0,0(10)
	lfs 13,20(6)
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 8,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 12,3,.L103
.L98:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,3868
	stw 0,12(1)
	stw 8,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,11
	bc 12,0,.L99
.L90:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 CheckDMRules,.Lfe6-CheckDMRules
	.section	".rodata"
	.align 2
.LC15:
	.string	"gamemap \"%s\"\n"
	.align 2
.LC16:
	.long 0x0
	.align 3
.LC17:
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
	lis 5,.LC15@ha
	la 29,level@l(29)
	addi 3,1,8
	lwz 6,204(29)
	la 5,.LC15@l(5)
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
	lis 9,.LC16@ha
	stw 0,208(29)
	la 9,.LC16@l(9)
	stw 0,204(29)
	lfs 13,0(9)
	stfs 13,200(29)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L113
	lis 11,.LC17@ha
	lis 28,g_edicts@ha
	la 11,.LC17@l(11)
	lis 30,0x4330
	lfd 31,0(11)
	li 29,952
.L108:
	lwz 0,g_edicts@l(28)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L111
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L111
	bl ClientEndServerFrame
.L111:
	addi 31,31,1
	lwz 11,maxclients@l(27)
	xoris 0,31,0x8000
	addi 29,29,952
	stw 0,284(1)
	stw 30,280(1)
	lfd 0,280(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L108
.L113:
	lis 11,.LC16@ha
	lis 9,maxclients@ha
	la 11,.LC16@l(11)
	li 10,0
	lfs 13,0(11)
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L115
	lis 9,g_edicts@ha
	mr 8,11
	lwz 11,g_edicts@l(9)
	lis 7,0x4330
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	addi 11,11,952
	lfd 12,0(9)
.L117:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L116
	lwz 9,84(11)
	lwz 0,480(11)
	lwz 9,728(9)
	cmpw 0,0,9
	bc 4,1,.L116
	stw 9,480(11)
.L116:
	addi 10,10,1
	lfs 13,20(8)
	xoris 0,10,0x8000
	addi 11,11,952
	stw 0,284(1)
	stw 7,280(1)
	lfd 0,280(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L117
.L115:
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
.LC19:
	.string	"set gl_dynamic 1;set sw_drawflat 0\n"
	.align 3
.LC18:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC20:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC21:
	.long 0x0
	.align 2
.LC22:
	.long 0x3f800000
	.align 2
.LC23:
	.long 0x40a00000
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
	lis 11,.LC20@ha
	la 11,.LC20@l(11)
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
	bc 12,2,.L122
	bl ExitLevel
	b .L121
.L122:
	lis 9,globals@ha
	li 29,0
	la 9,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(9)
	lis 25,g_edicts@ha
	lis 26,maxclients@ha
	lwz 31,g_edicts@l(11)
	cmpw 0,29,0
	bc 4,0,.L124
	lis 8,.LC20@ha
	mr 24,30
	la 8,.LC20@l(8)
	mr 27,9
	lfd 31,0(8)
	li 28,0
	lis 30,0x4330
.L126:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L125
	stw 31,292(24)
	lwz 9,552(31)
	lfs 0,4(31)
	lfs 12,8(31)
	cmpwi 0,9,0
	lfs 13,12(31)
	stfs 0,28(31)
	stfs 12,32(31)
	stfs 13,36(31)
	bc 12,2,.L128
	lwz 9,92(9)
	lwz 0,556(31)
	cmpw 0,9,0
	bc 12,2,.L128
	lwz 0,264(31)
	stw 28,552(31)
	andi. 9,0,3
	bc 4,2,.L128
	lwz 0,184(31)
	andi. 11,0,4
	bc 12,2,.L128
	mr 3,31
	bl M_CheckGround
.L128:
	cmpwi 0,29,0
	bc 4,1,.L130
	xoris 0,29,0x8000
	lwz 11,maxclients@l(26)
	stw 0,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L130
	mr 3,31
	bl ClientBeginServerFrame
	b .L125
.L130:
	mr 3,31
	bl G_RunEntity
.L125:
	lwz 0,72(27)
	addi 29,29,1
	addi 31,31,952
	cmpw 0,29,0
	bc 12,0,.L126
.L124:
	bl CheckDMRules
	li 30,0
	bl CheckNeedPass
	lis 11,maxclients@ha
	lis 8,.LC21@ha
	lwz 9,maxclients@l(11)
	la 8,.LC21@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L139
	lis 9,.LC20@ha
	lis 29,0x4330
	la 9,.LC20@l(9)
	li 31,952
	lfd 31,0(9)
.L134:
	lwz 0,g_edicts@l(25)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L137
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L137
	bl ClientEndServerFrame
.L137:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,952
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L134
.L139:
	lis 9,level@ha
	la 9,level@l(9)
	lis 10,0x4330
	lwz 0,308(9)
	lis 8,.LC20@ha
	la 8,.LC20@l(8)
	lfs 12,4(9)
	xoris 0,0,0x8000
	lfd 13,0(8)
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	cror 3,2,1
	bc 4,3,.L140
	li 3,0
	bl lookForPredator
	bl stuffLight
	cmpwi 0,3,0
	bc 12,2,.L141
	lis 9,maxclients@ha
	lis 8,.LC22@ha
	lwz 11,maxclients@l(9)
	la 8,.LC22@l(8)
	li 29,1
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L141
	lis 9,.LC20@ha
	lis 27,.LC19@ha
	la 9,.LC20@l(9)
	lis 28,0x4330
	lfd 31,0(9)
	li 30,952
.L145:
	lwz 0,g_edicts@l(25)
	add. 31,0,30
	bc 12,2,.L144
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L144
	mr 3,31
	la 4,.LC19@l(27)
	bl stuffcmd
.L144:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,952
	stw 0,20(1)
	stw 28,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L145
.L141:
	lis 11,level@ha
	lis 8,.LC23@ha
	la 11,level@l(11)
	la 8,.LC23@l(8)
	lfs 12,0(8)
	lfs 0,4(11)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	stw 9,308(11)
.L140:
	lis 9,.LC21@ha
	lis 11,enable_light_show@ha
	la 9,.LC21@l(9)
	lfs 13,0(9)
	lwz 9,enable_light_show@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L121
	lis 9,level@ha
	la 11,level@l(9)
	lwz 0,332(11)
	cmpwi 0,0,0
	bc 4,2,.L121
	lfs 0,4(11)
	lwz 0,340(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpw 0,0,9
	bc 4,0,.L121
	bl Lightning_Off
.L121:
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
	.long SetExeName
	.long .LC28
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC28:
	.string	"SetExeName"
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
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.comm	game,1564,4
	.comm	level,348,4
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
	.comm	sv_maplist2,4,4
	.comm	sv_maplist3,4,4
	.comm	sv_maplist_small_max,4,4
	.comm	sv_maplist_medium_max,4,4
	.comm	maxmarinekill,4,4
	.comm	penalty_threshold,4,4
	.comm	maxtime,4,4
	.comm	minscore,4,4
	.comm	max_flares,4,4
	.comm	flare_bright_time,4,4
	.comm	flare_dim_time,4,4
	.comm	flare_die_time,4,4
	.comm	flare_health,4,4
	.comm	flare_damage,4,4
	.comm	flare_damage_radius,4,4
	.comm	max_teleport_shots,4,4
	.comm	teleport_health,4,4
	.comm	teleport_panic_time,4,4
	.comm	IR_marine_fov,4,4
	.comm	IR_effect_time,4,4
	.comm	use_NH_scoreboard,4,4
	.comm	init_marine_weapon,4,4
	.comm	enable_predator_overload,4,4
	.comm	predator_overload_cost,4,4
	.comm	maxrate,4,4
	.comm	marine_safety_time,4,4
	.comm	predator_safety_time,4,4
	.comm	enable_marine_safety,4,4
	.comm	enable_predator_safety,4,4
	.comm	predator_model,4,4
	.comm	predator_skin,4,4
	.comm	marine_allow_custom,4,4
	.comm	marine_model,4,4
	.comm	marine_skin,4,4
	.comm	motd_time,4,4
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.comm	predator_max_rockets,4,4
	.comm	predator_max_slugs,4,4
	.comm	predator_start_rockets,4,4
	.comm	predator_start_slugs,4,4
	.comm	predator_start_health,4,4
	.comm	enable_light_show,4,4
	.comm	light_show_interval,4,4
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
	bc 12,2,.L154
	lwz 0,60(9)
	li 3,1
	lis 9,SegList@ha
	stw 0,SegList@l(9)
	b .L156
.L154:
	li 3,0
.L156:
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
.LC29:
	.long 0x0
	.align 3
.LC30:
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
	lis 11,.LC29@ha
	lis 9,maxclients@ha
	la 11,.LC29@l(11)
	li 30,0
	lfs 13,0(11)
	lis 27,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L16
	lis 9,.LC30@ha
	lis 28,g_edicts@ha
	la 9,.LC30@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,952
.L18:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L17
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L17
	bl ClientEndServerFrame
.L17:
	addi 30,30,1
	lwz 11,maxclients@l(27)
	xoris 0,30,0x8000
	addi 31,31,952
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
	.comm	SegList,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
