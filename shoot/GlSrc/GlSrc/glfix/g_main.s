	.file	"g_main.c"
gcc2_compiled.:
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
	.string	"play world/10_0.wav \n"
	.align 2
.LC1:
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
	bc 12,2,.L22
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
	li 21,992
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
	b .L23
.L22:
	li 3,0
.L23:
	lwz 0,68(1)
	mtlr 0
	lmw 21,20(1)
	la 1,64(1)
	blr
.Lfe1:
	.size	 GetGameAPI,.Lfe1-GetGameAPI
	.section	".rodata"
	.align 2
.LC2:
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
	bc 4,6,.L25
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L25:
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
	lis 4,.LC2@ha
	lwz 0,gi+28@l(9)
	la 4,.LC2@l(4)
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
	bc 4,6,.L27
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L27:
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
	lis 3,.LC2@ha
	lwz 0,gi+4@l(9)
	la 3,.LC2@l(3)
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
.LC3:
	.string	"target_changelevel"
	.align 2
.LC4:
	.string	" ,\n\r"
	.section	".sdata","aw"
	.align 2
	.type	 seps.30,@object
	.size	 seps.30,4
seps.30:
	.long .LC4
	.section	".rodata"
	.align 2
.LC5:
	.long 0x46fffe00
	.align 3
.LC6:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl EndDMLevel
	.type	 EndDMLevel,@function
EndDMLevel:
	stwu 1,-80(1)
	mflr 0
	stmw 21,36(1)
	stw 0,84(1)
	lis 11,dmflags@ha
	lwz 9,dmflags@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	andi. 9,0,32
	bc 12,2,.L38
	lis 29,level+92@ha
	la 29,level+92@l(29)
	bl G_Spawn
	lis 9,.LC3@ha
	mr 28,3
	la 9,.LC3@l(9)
	lis 5,.LC2@ha
	addi 3,29,64
	mr 6,29
	stw 9,280(28)
	la 5,.LC2@l(5)
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	addi 29,29,64
	mr 3,28
	stw 29,600(28)
	bl BeginIntermission
	b .L37
.L38:
	andis. 9,0,2
	bc 12,2,.L40
	lis 9,maplist@ha
	la 29,maplist@l(9)
	lbz 0,284(29)
	cmpwi 0,0,0
	bc 12,2,.L42
	cmpwi 0,0,1
	bc 12,2,.L43
	b .L44
.L42:
	lwz 9,288(29)
	lwz 11,24(29)
	addi 9,9,1
	divw 0,9,11
	mullw 0,0,11
	subf 28,0,9
	b .L41
.L43:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 0,24(29)
	xoris 3,3,0x8000
	lis 8,0x4330
	stw 3,28(1)
	lis 9,.LC6@ha
	lis 10,.LC5@ha
	la 9,.LC6@l(9)
	stw 8,24(1)
	xoris 0,0,0x8000
	lfd 12,0(9)
	mr 7,11
	lfd 0,24(1)
	mr 9,11
	lfs 10,.LC5@l(10)
	stw 0,28(1)
	fsub 0,0,12
	stw 8,24(1)
	lfd 13,24(1)
	frsp 0,0
	fsub 13,13,12
	fdivs 0,0,10
	frsp 13,13
	fmuls 0,0,13
	fmr 12,0
	fctiwz 11,12
	stfd 11,24(1)
	lwz 28,28(1)
	b .L41
.L44:
	li 28,0
.L41:
	lis 29,maplist@ha
	la 29,maplist@l(29)
	stw 28,288(29)
	bl G_Spawn
	slwi 0,28,4
	addi 29,29,28
	lis 9,.LC3@ha
	mr 11,3
	add 0,0,29
	la 9,.LC3@l(9)
	stw 9,280(11)
	stw 0,600(11)
	bl BeginIntermission
	b .L37
.L40:
	lis 9,sv_maplist@ha
	lis 21,.LC3@ha
	lwz 11,sv_maplist@l(9)
	lwz 3,4(11)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L47
	bl strdup
	li 31,0
	lis 25,seps.30@ha
	lis 9,seps.30@ha
	mr 22,3
	lwz 4,seps.30@l(9)
	bl strtok
	mr. 28,3
	bc 12,2,.L49
	lis 29,level+92@ha
	la 26,.LC3@l(21)
	la 27,level+92@l(29)
	lis 30,.LC2@ha
	addi 23,27,64
	lis 24,level+156@ha
.L50:
	mr 3,28
	la 4,level+92@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L51
	lwz 4,seps.30@l(25)
	li 3,0
	bl strtok
	mr. 28,3
	bc 4,2,.L52
	cmpwi 0,31,0
	bc 4,2,.L53
	bl G_Spawn
	mr 29,3
	la 5,.LC2@l(30)
	addi 3,27,64
	stw 26,280(29)
	mr 6,27
	b .L66
.L53:
	bl G_Spawn
	mr 29,3
	la 5,.LC2@l(30)
	la 3,level+156@l(24)
	stw 26,280(29)
	mr 6,31
.L66:
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	stw 23,600(29)
	mr 3,29
	bl BeginIntermission
	b .L57
.L52:
	bl G_Spawn
	mr 29,3
	la 5,.LC2@l(30)
	la 3,level+156@l(24)
	stw 26,280(29)
	mr 6,28
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	stw 23,600(29)
	mr 3,29
	bl BeginIntermission
.L57:
	mr 3,22
	bl free
	b .L37
.L51:
	srawi 9,31,31
	lwz 4,seps.30@l(25)
	li 3,0
	xor 0,9,31
	subf 0,0,9
	srawi 0,0,31
	andc 9,28,0
	and 0,31,0
	or 31,0,9
	bl strtok
	mr. 28,3
	bc 4,2,.L50
.L49:
	mr 3,22
	bl free
.L47:
	lis 9,level@ha
	la 28,level@l(9)
	lbz 0,156(28)
	cmpwi 0,0,0
	bc 12,2,.L61
	bl G_Spawn
	addi 28,28,156
	lis 9,.LC3@ha
	mr 29,3
	la 9,.LC3@l(9)
	lis 5,.LC2@ha
	mr 3,28
	stw 9,280(29)
	la 5,.LC2@l(5)
	li 4,64
	mr 6,28
	crxor 6,6,6
	bl Com_sprintf
	stw 28,600(29)
	mr 3,29
	bl BeginIntermission
	b .L37
.L61:
	lis 5,.LC3@ha
	li 3,0
	la 5,.LC3@l(5)
	li 4,280
	bl G_Find
	mr. 11,3
	bc 4,2,.L64
	bl G_Spawn
	mr 29,3
	la 0,.LC3@l(21)
	lis 5,.LC2@ha
	stw 0,280(29)
	addi 3,28,156
	addi 6,28,92
	la 5,.LC2@l(5)
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	addi 0,28,156
	mr 3,29
	stw 0,600(29)
	bl BeginIntermission
	b .L37
.L64:
	mr 3,11
	bl BeginIntermission
.L37:
	lwz 0,84(1)
	mtlr 0
	lmw 21,36(1)
	la 1,80(1)
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
	bc 4,2,.L69
	lwz 9,spectator_password@l(29)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L68
.L69:
	lis 9,spectator_password@ha
	li 10,0
	lwz 11,spectator_password@l(9)
	li 31,0
	stw 10,16(11)
	lwz 3,4(8)
	stw 10,16(8)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L70
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl Q_stricmp
	addic 0,3,-1
	subfe 31,0,3
.L70:
	lwz 9,spectator_password@l(29)
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L71
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl Q_stricmp
	addic 3,3,-1
	subfe 3,3,3
	ori 0,31,2
	andc 0,0,3
	and 3,31,3
	or 31,3,0
.L71:
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
.L68:
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
	.string	"Timelimit hit, Gameleader wins.\n"
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
	lfs 0,220(10)
	fcmpu 0,0,13
	bc 4,2,.L72
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L72
	lis 9,timelimit@ha
	lwz 11,timelimit@l(9)
	lfs 12,20(11)
	fcmpu 0,12,13
	bc 12,2,.L75
	lis 9,.LC13@ha
	lfs 13,4(10)
	la 9,.LC13@l(9)
	lfs 0,0(9)
	fmuls 0,12,0
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L75
	lis 9,gi@ha
	lis 4,.LC10@ha
	lwz 0,gi@l(9)
	la 4,.LC10@l(4)
	b .L86
.L85:
	lis 9,gi@ha
	lis 4,.LC11@ha
	lwz 0,gi@l(9)
	la 4,.LC11@l(4)
.L86:
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	bl EndDMLevel
	b .L72
.L75:
	lis 9,fraglimit@ha
	lis 11,.LC12@ha
	lwz 8,fraglimit@l(9)
	la 11,.LC12@l(11)
	lfs 13,0(11)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L72
	lis 11,maxclients@ha
	li 7,0
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L72
	lis 9,game+1028@ha
	lis 11,g_edicts@ha
	fmr 11,0
	lwz 10,game+1028@l(9)
	mr 6,8
	lwz 9,g_edicts@l(11)
	lis 8,0x4330
	lis 11,.LC14@ha
	addi 10,10,3448
	la 11,.LC14@l(11)
	lfd 12,0(11)
	addi 11,9,1080
.L81:
	lwz 0,0(11)
	addi 11,11,992
	cmpwi 0,0,0
	bc 12,2,.L80
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
	bc 12,3,.L85
.L80:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,3804
	stw 0,12(1)
	stw 8,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,11
	bc 12,0,.L81
.L72:
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
	lwz 6,224(29)
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
	stw 0,228(29)
	la 9,.LC16@l(9)
	stw 0,224(29)
	lfs 13,0(9)
	stfs 13,220(29)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L95
	lis 11,.LC17@ha
	lis 28,g_edicts@ha
	la 11,.LC17@l(11)
	lis 30,0x4330
	lfd 31,0(11)
	li 29,992
.L90:
	lwz 0,g_edicts@l(28)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L93
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L93
	bl ClientEndServerFrame
.L93:
	addi 31,31,1
	lwz 11,maxclients@l(27)
	xoris 0,31,0x8000
	addi 29,29,992
	stw 0,284(1)
	stw 30,280(1)
	lfd 0,280(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L90
.L95:
	lis 11,.LC16@ha
	lis 9,maxclients@ha
	la 11,.LC16@l(11)
	li 10,0
	lfs 13,0(11)
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L97
	lis 9,g_edicts@ha
	mr 8,11
	lwz 11,g_edicts@l(9)
	lis 7,0x4330
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	addi 11,11,992
	lfd 12,0(9)
.L99:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L98
	lwz 9,84(11)
	lwz 0,576(11)
	lwz 9,728(9)
	cmpw 0,0,9
	bc 4,1,.L98
	stw 9,576(11)
.L98:
	addi 10,10,1
	lfs 13,20(8)
	xoris 0,10,0x8000
	addi 11,11,992
	stw 0,284(1)
	stw 7,280(1)
	lfd 0,280(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L99
.L97:
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
	.string	"---<<< HIDDEN PLACEMENT >>>---\n"
	.align 2
.LC20:
	.string	"---<<< GO! >>>---\n"
	.align 2
.LC22:
	.string	"You are now GAMELEADER, happy hunting...\n\r"
	.align 2
.LC23:
	.string	"gameleader is now: %s \n"
	.align 3
.LC18:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC21:
	.long 0x46fffe00
	.align 3
.LC24:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC25:
	.long 0x0
	.align 2
.LC26:
	.long 0x41a00000
	.align 2
.LC27:
	.long 0x42340000
	.align 2
.LC28:
	.long 0x41300000
	.align 2
.LC29:
	.long 0x3f800000
	.align 2
.LC30:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl G_RunFrame
	.type	 G_RunFrame,@function
G_RunFrame:
	stwu 1,-624(1)
	mflr 0
	stfd 29,600(1)
	stfd 30,608(1)
	stfd 31,616(1)
	stmw 14,528(1)
	stw 0,628(1)
	lis 8,level@ha
	lwz 11,level@l(8)
	lis 5,0x4330
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lis 7,dmflags@ha
	addi 11,11,1
	lfd 11,0(9)
	la 4,level@l(8)
	xoris 0,11,0x8000
	lis 9,.LC18@ha
	lwz 6,dmflags@l(7)
	stw 0,524(1)
	lis 14,level@ha
	stw 5,520(1)
	lfd 0,520(1)
	lfd 13,.LC18@l(9)
	stw 11,level@l(8)
	mr 9,10
	fsub 0,0,11
	fmul 0,0,13
	frsp 0,0
	stfs 0,4(4)
	lfs 13,20(6)
	fctiwz 12,13
	stfd 12,520(1)
	lwz 0,524(1)
	andis. 10,0,4
	bc 12,2,.L104
	andis. 11,0,2
	bc 4,2,.L104
	bl Svcmd_Maplist2_f
.L104:
	lis 9,level+20@ha
	lwz 0,level+20@l(9)
	cmpwi 0,0,0
	bc 4,2,.L107
	lis 9,maxclients@ha
	lis 8,.LC25@ha
	lwz 11,maxclients@l(9)
	la 8,.LC25@l(8)
	li 27,0
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L107
	lis 9,g_edicts@ha
	mr 10,11
	lwz 11,g_edicts@l(9)
	li 7,0
	lis 8,0x4330
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	addi 11,11,992
	lfd 12,0(9)
.L111:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L110
	lwz 0,320(11)
	cmpwi 0,0,1
	bc 4,2,.L110
	stw 7,320(11)
.L110:
	addi 27,27,1
	lfs 13,20(10)
	xoris 0,27,0x8000
	addi 11,11,992
	stw 0,524(1)
	stw 8,520(1)
	lfd 0,520(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L111
.L107:
	lis 9,level@ha
	la 11,level@l(9)
	lwz 0,20(11)
	cmpwi 0,0,1
	bc 4,1,.L115
	lis 10,.LC25@ha
	lis 9,maxclients@ha
	la 10,.LC25@l(10)
	li 27,0
	lfs 13,0(10)
	lwz 10,maxclients@l(9)
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 4,0,.L117
	lis 9,g_edicts@ha
	mr 8,11
	lwz 11,g_edicts@l(9)
	li 6,0
	lis 7,0x4330
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	addi 11,11,992
	lfd 12,0(9)
.L119:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L118
	lwz 0,320(11)
	cmpwi 0,0,1
	bc 4,2,.L118
	lwz 9,20(8)
	addi 9,9,-1
	stw 9,20(8)
	stw 6,320(11)
.L118:
	addi 27,27,1
	lfs 13,20(10)
	xoris 0,27,0x8000
	addi 11,11,992
	stw 0,524(1)
	stw 7,520(1)
	lfd 0,520(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L119
.L117:
	lis 9,maxclients@ha
	lis 10,.LC25@ha
	lwz 8,maxclients@l(9)
	la 10,.LC25@l(10)
	li 27,0
	lfs 13,0(10)
	lfs 0,20(8)
	fcmpu 0,13,0
	bc 4,0,.L115
	lis 9,g_edicts@ha
	lis 11,level@ha
	lwz 10,g_edicts@l(9)
	la 11,level@l(11)
	lis 7,0x4330
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	addi 10,10,992
	lfd 12,0(9)
.L126:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L125
	lwz 0,320(10)
	cmpwi 0,0,1
	bc 4,2,.L125
	lwz 9,20(11)
	addi 9,9,1
	stw 9,20(11)
.L125:
	addi 27,27,1
	lfs 13,20(8)
	xoris 0,27,0x8000
	addi 10,10,992
	stw 0,524(1)
	stw 7,520(1)
	lfd 0,520(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L126
.L115:
	lis 9,level@ha
	la 8,level@l(9)
	lwz 0,24(8)
	cmpwi 0,0,1
	bc 12,2,.L130
	lwz 0,8(8)
	cmpwi 0,0,0
	bc 4,2,.L131
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,520(1)
	lwz 11,524(1)
	andis. 10,11,1
	bc 4,2,.L131
	lwz 0,12(8)
	lis 11,0x4330
	lis 10,.LC24@ha
	lfs 12,4(8)
	xoris 0,0,0x8000
	la 10,.LC24@l(10)
	stw 0,524(1)
	stw 11,520(1)
	lfd 13,0(10)
	lfd 0,520(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L131
	lwz 0,20(8)
	cmpwi 0,0,0
	bc 4,2,.L131
	lis 11,.LC26@ha
	li 0,1
	la 11,.LC26@l(11)
	stw 0,8(8)
	lfs 0,0(11)
	fadds 0,12,0
	fctiwz 13,0
	stfd 13,520(1)
	lwz 9,524(1)
	stw 9,12(8)
.L131:
	lis 9,level@ha
	la 10,level@l(9)
	lwz 0,8(10)
	cmpwi 0,0,1
	bc 4,2,.L134
	lwz 0,12(10)
	lis 11,0x4330
	lis 8,.LC24@ha
	lfs 12,4(10)
	xoris 0,0,0x8000
	la 8,.LC24@l(8)
	stw 0,524(1)
	stw 11,520(1)
	lfd 13,0(8)
	lfd 0,520(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L134
	lis 9,.LC27@ha
	li 0,2
	la 9,.LC27@l(9)
	lis 3,.LC19@ha
	stw 0,8(10)
	lfs 0,0(9)
	la 3,.LC19@l(3)
	fadds 0,12,0
	fctiwz 13,0
	stfd 13,520(1)
	lwz 9,524(1)
	stw 9,16(10)
	bl centerprint_all
.L134:
	lis 9,level@ha
	la 9,level@l(9)
	lis 10,0x4330
	lwz 0,16(9)
	lis 8,.LC24@ha
	la 8,.LC24@l(8)
	lfs 12,4(9)
	xoris 0,0,0x8000
	lfd 13,0(8)
	stw 0,524(1)
	stw 10,520(1)
	lfd 0,520(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L135
	lwz 0,8(9)
	cmpwi 0,0,2
	bc 4,2,.L135
	li 0,3
	lis 3,.LC20@ha
	stw 0,8(9)
	la 3,.LC20@l(3)
	bl centerprint_all
.L135:
	lis 8,.LC25@ha
	lis 9,maxclients@ha
	la 8,.LC25@l(8)
	li 27,0
	lfs 13,0(8)
	lis 20,maxclients@ha
	lwz 8,maxclients@l(9)
	lfs 0,20(8)
	fcmpu 0,13,0
	bc 4,0,.L137
	lis 9,g_edicts@ha
	lis 11,level@ha
	lwz 10,g_edicts@l(9)
	la 11,level@l(11)
	mr 6,8
	lis 9,.LC24@ha
	lis 7,0x4330
	la 9,.LC24@l(9)
	addi 10,10,992
	lfd 12,0(9)
.L139:
	mr 31,10
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L138
	lwz 8,320(31)
	cmpwi 0,8,1
	bc 4,2,.L138
	lwz 0,372(31)
	lfs 13,4(11)
	xoris 0,0,0x8000
	stw 0,524(1)
	stw 7,520(1)
	lfd 0,520(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 4,0,.L138
	stw 8,260(31)
.L138:
	addi 27,27,1
	lfs 13,20(6)
	xoris 0,27,0x8000
	addi 10,10,992
	stw 0,524(1)
	stw 7,520(1)
	lfd 0,520(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L139
.L137:
	lis 8,.LC24@ha
	lis 9,level@ha
	la 8,.LC24@l(8)
	la 9,level@l(9)
	lfd 12,0(8)
	lis 10,0x4330
	lis 8,.LC28@ha
	lwz 0,16(9)
	la 8,.LC28@l(8)
	lfs 13,4(9)
	lfs 0,0(8)
	xoris 0,0,0x8000
	stw 0,524(1)
	stw 10,520(1)
	fadds 13,13,0
	lfd 0,520(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 4,2,.L144
	lwz 0,8(9)
	cmpwi 0,0,2
	bc 4,2,.L144
	lis 9,maxclients@ha
	lis 10,.LC29@ha
	lwz 11,maxclients@l(9)
	la 10,.LC29@l(10)
	li 30,1
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L144
	lis 11,.LC24@ha
	lis 27,g_edicts@ha
	la 11,.LC24@l(11)
	lis 28,.LC0@ha
	lfd 31,0(11)
	lis 29,0x4330
	li 31,992
.L147:
	lwz 0,g_edicts@l(27)
	add. 3,0,31
	bc 12,2,.L149
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L149
	la 4,.LC0@l(28)
	bl stuffcmd
.L149:
	addi 30,30,1
	lwz 11,maxclients@l(20)
	xoris 0,30,0x8000
	addi 31,31,992
	stw 0,524(1)
	stw 29,520(1)
	lfd 0,520(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L147
.L144:
	lis 9,maxclients@ha
	lis 8,.LC25@ha
	lwz 11,maxclients@l(9)
	la 8,.LC25@l(8)
	li 27,0
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L172
	lis 9,.LC21@ha
	lis 11,gi@ha
	lfs 29,.LC21@l(9)
	la 22,gi@l(11)
	lis 15,g_edicts@ha
	lis 9,level@ha
	lis 16,g_edicts@ha
	la 17,level@l(9)
	li 23,0
	addi 21,1,8
	li 18,992
	li 19,0
.L155:
	lwz 0,g_edicts@l(15)
	add 11,19,0
	add 31,0,18
	lwz 9,1080(11)
	cmpwi 0,9,0
	bc 12,2,.L154
	lwz 9,84(31)
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 4,2,.L154
	lwz 0,380(31)
	cmpwi 0,0,1
	bc 12,2,.L154
	la 29,level@l(14)
	lwz 0,20(29)
	cmpwi 0,0,0
	bc 4,2,.L154
	lis 9,dmflags@ha
	lwz 11,dmflags@l(9)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,520(1)
	lwz 9,524(1)
	andis. 28,9,0x1
	bc 4,2,.L154
	lwz 0,12(29)
	lis 30,0x4330
	lis 10,.LC24@ha
	lfs 13,4(29)
	xoris 0,0,0x8000
	la 10,.LC24@l(10)
	stw 0,524(1)
	stw 30,520(1)
	lfd 31,0(10)
	lfd 0,520(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 4,0,.L154
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,maxclients@l(20)
	xoris 3,3,0x8000
	lis 10,.LC29@ha
	stw 3,524(1)
	la 10,.LC29@l(10)
	lis 8,.LC25@ha
	stw 30,520(1)
	la 8,.LC25@l(8)
	lfd 0,520(1)
	lfs 13,0(10)
	lfs 12,20(11)
	mr 10,9
	fsub 0,0,31
	lfs 30,0(8)
	fsubs 12,12,13
	frsp 0,0
	fdivs 0,0,29
	fmadds 0,0,12,30
	fmr 13,0
	fctiwz 11,13
	stfd 11,520(1)
	lwz 30,524(1)
	cmpwi 0,30,1
	bc 4,2,.L154
	lwz 9,8(22)
	lis 5,.LC22@ha
	mr 3,31
	la 5,.LC22@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,184(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,20(29)
	addi 9,9,1
	stw 9,20(29)
	lwz 3,988(31)
	lwz 0,64(31)
	cmpwi 0,3,0
	stw 30,320(31)
	oris 0,0,0x2
	stw 0,64(31)
	bc 4,2,.L191
	lwz 10,maxclients@l(20)
	lis 9,.LC23@ha
	li 29,0
	lwz 11,84(31)
	la 24,.LC23@l(9)
	lfs 0,20(10)
	addi 28,11,700
	fcmpu 0,30,0
	bc 4,0,.L169
	lis 8,.LC24@ha
	lis 9,gi@ha
	la 8,.LC24@l(8)
	lis 25,0x4330
	lfd 31,0(8)
	la 26,gi@l(9)
	li 30,992
.L165:
	lwz 0,g_edicts@l(16)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L167
	lwz 9,8(26)
	li 4,2
	mr 5,24
	mr 6,28
	mtlr 9
	crxor 6,6,6
	blrl
.L167:
	addi 29,29,1
	lwz 11,maxclients@l(20)
	xoris 0,29,0x8000
	addi 30,30,992
	stw 0,524(1)
	stw 25,520(1)
	lfd 0,520(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L165
.L169:
	lwz 0,292(31)
	cmpwi 0,0,1
	bc 4,2,.L154
	lwz 9,84(31)
	li 5,512
	mr 3,21
	stw 23,3448(9)
	stw 23,1800(9)
	lwz 0,184(31)
	lwz 4,84(31)
	rlwinm 0,0,0,0,30
	stw 23,292(31)
	stw 0,184(31)
	addi 4,4,188
	crxor 6,6,6
	bl memcpy
	lwz 3,84(31)
	mr 4,31
	bl InitClientPersistant
	mr 4,21
	mr 3,31
	bl ClientUserinfoChanged
	li 0,4
	lis 8,.LC30@ha
	stw 23,248(31)
	la 8,.LC30@l(8)
	stw 0,260(31)
	lfs 12,0(8)
	li 3,1
	lfs 0,4(17)
	lwz 11,84(31)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,520(1)
	lwz 9,524(1)
	stw 9,372(31)
	stw 23,88(11)
	lwz 9,100(22)
	mtlr 9
	blrl
	lwz 3,g_edicts@l(16)
	lis 0,0xbdef
	ori 0,0,31711
	lwz 11,104(22)
	subf 3,3,31
	mullw 3,3,0
	mtlr 11
	srawi 3,3,5
	blrl
	lwz 9,100(22)
	li 3,9
	mtlr 9
	blrl
	lwz 9,88(22)
	addi 3,31,4
	li 4,2
	mtlr 9
	blrl
	lwz 11,84(31)
	li 0,32
	li 10,14
	stb 0,16(11)
	lwz 9,84(31)
	stb 10,17(9)
	lfs 0,4(17)
	lwz 11,84(31)
	stfs 0,3792(11)
.L154:
	addi 27,27,1
	lwz 10,maxclients@l(20)
	xoris 0,27,0x8000
	lis 11,0x4330
	stw 0,524(1)
	lis 8,.LC24@ha
	addi 18,18,992
	la 8,.LC24@l(8)
	stw 11,520(1)
	addi 19,19,992
	lfd 13,0(8)
	lfd 0,520(1)
	lfs 12,20(10)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L155
	b .L172
.L130:
	stw 0,20(8)
.L172:
	bl AI_SetSightClient
	lis 9,level@ha
	la 10,level@l(9)
	lwz 0,228(10)
	cmpwi 0,0,0
	bc 12,2,.L173
	bl ExitLevel
	b .L103
.L191:
	bl G_FreeEdict
	stw 28,988(31)
	b .L103
.L173:
	lis 9,globals@ha
	li 27,0
	la 9,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(9)
	lis 20,maxclients@ha
	lis 16,g_edicts@ha
	lwz 31,g_edicts@l(11)
	cmpw 0,27,0
	bc 4,0,.L175
	lis 8,.LC24@ha
	mr 26,10
	la 8,.LC24@l(8)
	mr 28,9
	lfd 31,0(8)
	li 29,0
	lis 30,0x4330
.L177:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L176
	stw 31,312(26)
	lwz 9,648(31)
	lfs 0,4(31)
	lfs 12,8(31)
	cmpwi 0,9,0
	lfs 13,12(31)
	stfs 0,28(31)
	stfs 12,32(31)
	stfs 13,36(31)
	bc 12,2,.L179
	lwz 9,92(9)
	lwz 0,652(31)
	cmpw 0,9,0
	bc 12,2,.L179
	lwz 0,264(31)
	stw 29,648(31)
	andi. 9,0,3
	bc 4,2,.L179
	lwz 0,184(31)
	andi. 10,0,4
	bc 12,2,.L179
	mr 3,31
	bl M_CheckGround
.L179:
	cmpwi 0,27,0
	bc 4,1,.L181
	xoris 0,27,0x8000
	lwz 11,maxclients@l(20)
	stw 0,524(1)
	stw 30,520(1)
	lfd 0,520(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L181
	mr 3,31
	bl ClientBeginServerFrame
	b .L176
.L181:
	mr 3,31
	bl G_RunEntity
.L176:
	lwz 0,72(28)
	addi 27,27,1
	addi 31,31,992
	cmpw 0,27,0
	bc 12,0,.L177
.L175:
	bl CheckDMRules
	li 30,0
	bl CheckNeedPass
	lis 11,maxclients@ha
	lis 8,.LC25@ha
	lwz 9,maxclients@l(11)
	la 8,.LC25@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L103
	lis 9,.LC24@ha
	lis 29,0x4330
	la 9,.LC24@l(9)
	li 31,992
	lfd 31,0(9)
.L185:
	lwz 0,g_edicts@l(16)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L188
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L188
	bl ClientEndServerFrame
.L188:
	addi 30,30,1
	lwz 11,maxclients@l(20)
	xoris 0,30,0x8000
	addi 31,31,992
	stw 0,524(1)
	stw 29,520(1)
	lfd 0,520(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L185
.L103:
	lwz 0,628(1)
	mtlr 0
	lmw 14,528(1)
	lfd 29,600(1)
	lfd 30,608(1)
	lfd 31,616(1)
	la 1,624(1)
	blr
.Lfe8:
	.size	 G_RunFrame,.Lfe8-G_RunFrame
	.globl DLL_ExportSymbols
	.section	".data"
	.align 2
	.type	 DLL_ExportSymbols,@object
DLL_ExportSymbols:
	.long dllFindResource
	.long .LC31
	.long dllLoadResource
	.long .LC32
	.long dllFreeResource
	.long .LC33
	.long GetGameAPI
	.long .LC34
	.long SetExeName
	.long .LC35
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC35:
	.string	"SetExeName"
	.align 2
.LC34:
	.string	"GetGameAPI"
	.align 2
.LC33:
	.string	"dllFreeResource"
	.align 2
.LC32:
	.string	"dllLoadResource"
	.align 2
.LC31:
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
	.comm	level,324,4
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
	.comm	maplist,292,4
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
	bc 12,2,.L197
	lwz 0,60(9)
	li 3,1
	lis 9,SegList@ha
	stw 0,SegList@l(9)
	b .L199
.L197:
	li 3,0
.L199:
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
	.section	".rodata"
	.align 2
.LC36:
	.long 0x0
	.align 3
.LC37:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Broadcast_Message
	.type	 Broadcast_Message,@function
Broadcast_Message:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 24,24(1)
	stw 0,68(1)
	lis 11,.LC36@ha
	lis 9,maxclients@ha
	la 11,.LC36@l(11)
	mr 28,3
	lfs 13,0(11)
	mr 29,4
	li 30,0
	lwz 11,maxclients@l(9)
	lis 24,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L8
	lis 9,gi@ha
	lis 25,g_edicts@ha
	la 26,gi@l(9)
	lis 27,0x4330
	lis 9,.LC37@ha
	li 31,992
	la 9,.LC37@l(9)
	lfd 31,0(9)
.L10:
	lwz 0,g_edicts@l(25)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L9
	lwz 9,8(26)
	li 4,2
	mr 5,28
	mr 6,29
	mtlr 9
	crxor 6,6,6
	blrl
.L9:
	addi 30,30,1
	lwz 11,maxclients@l(24)
	xoris 0,30,0x8000
	addi 31,31,992
	stw 0,20(1)
	stw 27,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L10
.L8:
	lwz 0,68(1)
	mtlr 0
	lmw 24,24(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe11:
	.size	 Broadcast_Message,.Lfe11-Broadcast_Message
	.section	".rodata"
	.align 2
.LC38:
	.long 0x3f800000
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl timer_all
	.type	 timer_all,@function
timer_all:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	lis 11,.LC38@ha
	lis 9,maxclients@ha
	la 11,.LC38@l(11)
	li 30,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L15
	lis 9,.LC39@ha
	lis 27,g_edicts@ha
	la 9,.LC39@l(9)
	lis 28,.LC0@ha
	lfd 31,0(9)
	lis 29,0x4330
	li 31,992
.L17:
	lwz 0,g_edicts@l(27)
	add. 3,0,31
	bc 12,2,.L16
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L16
	la 4,.LC0@l(28)
	bl stuffcmd
.L16:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,992
	stw 0,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L17
.L15:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 timer_all,.Lfe12-timer_all
	.align 2
	.globl ShutdownGame
	.type	 ShutdownGame,@function
ShutdownGame:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 29,gi@ha
	lis 3,.LC1@ha
	la 29,gi@l(29)
	la 3,.LC1@l(3)
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
.Lfe13:
	.size	 ShutdownGame,.Lfe13-ShutdownGame
	.section	".rodata"
	.align 2
.LC40:
	.long 0x0
	.align 3
.LC41:
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
	lis 11,.LC40@ha
	lis 9,maxclients@ha
	la 11,.LC40@l(11)
	li 30,0
	lfs 13,0(11)
	lis 27,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L30
	lis 9,.LC41@ha
	lis 28,g_edicts@ha
	la 9,.LC41@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,992
.L32:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L31
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L31
	bl ClientEndServerFrame
.L31:
	addi 30,30,1
	lwz 11,maxclients@l(27)
	xoris 0,30,0x8000
	addi 31,31,992
	stw 0,28(1)
	stw 29,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L32
.L30:
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
	lis 28,level+156@ha
	bl G_Spawn
	lis 9,.LC3@ha
	mr 29,3
	la 9,.LC3@l(9)
	lis 5,.LC2@ha
	la 3,level+156@l(28)
	stw 9,280(29)
	la 5,.LC2@l(5)
	mr 6,27
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	la 28,level+156@l(28)
	mr 3,29
	stw 28,600(29)
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 CreateTargetChangeLevel,.Lfe15-CreateTargetChangeLevel
	.align 2
	.globl SetExeName
	.type	 SetExeName,@function
SetExeName:
	lis 9,exe_found@ha
	li 0,1
	stw 0,exe_found@l(9)
	blr
.Lfe16:
	.size	 SetExeName,.Lfe16-SetExeName
	.align 2
	.globl dllFindResource
	.type	 dllFindResource,@function
dllFindResource:
	li 3,0
	blr
.Lfe17:
	.size	 dllFindResource,.Lfe17-dllFindResource
	.align 2
	.globl dllLoadResource
	.type	 dllLoadResource,@function
dllLoadResource:
	li 3,0
	blr
.Lfe18:
	.size	 dllLoadResource,.Lfe18-dllLoadResource
	.align 2
	.globl dllFreeResource
	.type	 dllFreeResource,@function
dllFreeResource:
	blr
.Lfe19:
	.size	 dllFreeResource,.Lfe19-dllFreeResource
	.comm	SegList,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
