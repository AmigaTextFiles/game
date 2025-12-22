	.file	"g_main.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 GlobalUserDLLList,@object
	.size	 GlobalUserDLLList,4
GlobalUserDLLList:
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
	li 21,1016
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
	bc 4,6,.L10
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L10:
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
	.long 0x46fffe00
	.align 3
.LC4:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl EndDMLevel
	.type	 EndDMLevel,@function
EndDMLevel:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,dmflags@ha
	lwz 9,dmflags@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	andi. 9,0,32
	bc 12,2,.L22
	bl G_Spawn
	lis 9,.LC2@ha
	lis 11,level+72@ha
	la 9,.LC2@l(9)
	la 11,level+72@l(11)
	stw 9,284(3)
	stw 11,508(3)
	b .L23
.L22:
	andis. 9,0,1
	bc 12,2,.L24
	lis 9,maplist@ha
	la 31,maplist@l(9)
	lbz 0,1052(31)
	cmpwi 0,0,0
	bc 12,2,.L26
	cmpwi 0,0,1
	bc 12,2,.L27
	b .L28
.L26:
	lwz 9,1056(31)
	lwz 11,24(31)
	addi 9,9,1
	divw 0,9,11
	mullw 0,0,11
	subf 31,0,9
	b .L25
.L27:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 0,24(31)
	xoris 3,3,0x8000
	lis 8,0x4330
	stw 3,28(1)
	lis 9,.LC4@ha
	lis 10,.LC3@ha
	la 9,.LC4@l(9)
	stw 8,24(1)
	xoris 0,0,0x8000
	lfd 12,0(9)
	mr 7,11
	lfd 0,24(1)
	mr 9,11
	lfs 10,.LC3@l(10)
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
	lwz 31,28(1)
	b .L25
.L28:
	li 31,0
.L25:
	lis 29,maplist@ha
	la 29,maplist@l(29)
	stw 31,1056(29)
	bl G_Spawn
	slwi 0,31,4
	addi 29,29,28
	lis 9,.LC2@ha
	add. 11,0,29
	la 9,.LC2@l(9)
	stw 9,284(3)
	bc 12,2,.L30
	lis 9,level+136@ha
	lbz 0,level+136@l(9)
	cmpwi 0,0,0
	bc 4,2,.L40
	stw 11,508(3)
	b .L23
.L30:
	lis 9,level@ha
	la 9,level@l(9)
	lbz 0,136(9)
	cmpwi 0,0,0
	bc 12,2,.L32
.L40:
	lis 9,level+136@ha
	la 9,level+136@l(9)
	b .L41
.L32:
	addi 0,9,72
	stw 0,508(3)
	b .L23
.L24:
	lis 31,Last_Team_Winner@ha
	lwz 0,Last_Team_Winner@l(31)
	cmpwi 0,0,1
	bc 12,1,.L35
	lis 9,team_list@ha
	slwi 0,0,2
	la 29,team_list@l(9)
	lwzx 9,29,0
	cmpwi 0,9,0
	bc 12,2,.L35
	lwz 0,228(9)
	cmpwi 0,0,0
	bc 12,2,.L35
	bl G_Spawn
	lwz 11,Last_Team_Winner@l(31)
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	stw 9,284(3)
	slwi 11,11,2
	lwzx 9,11,29
	lwz 0,228(9)
	stw 0,508(3)
	b .L23
.L35:
	lis 9,level@ha
	la 31,level@l(9)
	lbz 0,136(31)
	cmpwi 0,0,0
	bc 12,2,.L37
	bl G_Spawn
	lis 9,.LC2@ha
	addi 0,31,136
	la 9,.LC2@l(9)
	stw 0,508(3)
	stw 9,284(3)
	b .L23
.L37:
	lis 29,.LC2@ha
	li 3,0
	li 4,284
	la 5,.LC2@l(29)
	bl G_Find
	mr. 3,3
	bc 4,2,.L23
	bl G_Spawn
	la 0,.LC2@l(29)
	addi 9,31,72
	stw 0,284(3)
.L41:
	stw 9,508(3)
.L23:
	bl BeginIntermission
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 EndDMLevel,.Lfe4-EndDMLevel
	.section	".rodata"
	.align 2
.LC5:
	.string	"Team %s is victorious!\n"
	.align 2
.LC6:
	.string	"30 seconds left before team %s wins the battle!\n"
	.align 2
.LC7:
	.string	"1 minute left before team %s wins the battle!\n"
	.align 2
.LC8:
	.string	"5 minutes left before team %s wins the battle!\n"
	.align 2
.LC9:
	.string	"Team %s is victorious (%i / %i kills)!\n"
	.align 2
.LC10:
	.string	"Team %s is victorious (%i / %i points)!\n"
	.align 2
.LC11:
	.string	"%s is victorius.\n"
	.align 2
.LC12:
	.string	"Timelimit hit.\n"
	.align 2
.LC13:
	.string	"Fraglimit hit.\n"
	.align 2
.LC14:
	.long 0x0
	.align 2
.LC15:
	.long 0x41f00000
	.align 2
.LC16:
	.long 0x42700000
	.align 2
.LC17:
	.long 0x43960000
	.align 3
.LC18:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CheckDMRules
	.type	 CheckDMRules,@function
CheckDMRules:
	stwu 1,-80(1)
	mflr 0
	mfcr 12
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 26,40(1)
	stw 0,84(1)
	stw 12,36(1)
	lis 9,level@ha
	lis 11,.LC14@ha
	la 11,.LC14@l(11)
	la 10,level@l(9)
	lfs 13,0(11)
	li 31,0
	li 27,0
	lfs 0,204(10)
	fcmpu 0,0,13
	bc 4,2,.L42
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L42
	lis 9,team_list@ha
	cmpwi 4,31,0
	lwz 0,team_list@l(9)
	cmpwi 0,0,0
	bc 12,2,.L46
	la 28,team_list@l(9)
	lis 11,.LC15@ha
	lis 9,.LC14@ha
	la 11,.LC15@l(11)
	la 9,.LC14@l(9)
	lfs 30,0(11)
	mr 26,10
	lfs 31,0(9)
	lis 29,gi@ha
	li 30,0
.L49:
	lwzx 5,30,28
	lfs 13,92(5)
	fcmpu 0,13,31
	bc 12,2,.L50
	lfs 0,4(26)
	fsubs 13,13,0
	fcmpu 0,13,31
	cror 3,2,0
	bc 12,3,.L78
	fcmpu 0,13,30
	bc 4,2,.L53
	lwz 9,gi@l(29)
	lis 4,.LC6@ha
	li 3,2
	lwz 5,0(5)
	la 4,.LC6@l(4)
	b .L82
.L53:
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L55
	lwz 9,gi@l(29)
	lis 4,.LC7@ha
	li 3,2
	lwz 5,0(5)
	la 4,.LC7@l(4)
.L82:
	mtlr 9
	crxor 6,6,6
	blrl
	b .L50
.L55:
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L50
	lwz 9,gi@l(29)
	lis 4,.LC8@ha
	li 3,2
	lwz 5,0(5)
	la 4,.LC8@l(4)
	mtlr 9
	crxor 6,6,6
	blrl
.L50:
	lwzx 5,30,28
	lwz 7,232(5)
	cmpwi 0,7,0
	bc 4,1,.L58
	lwz 6,76(5)
	cmpw 0,6,7
	bc 4,0,.L79
.L58:
	lwz 7,236(5)
	cmpwi 0,7,0
	bc 4,1,.L47
	lwz 6,88(5)
	cmpw 0,6,7
	bc 4,0,.L80
.L47:
	addi 31,31,1
	addi 30,30,4
	cmpwi 0,31,1
	bc 12,1,.L46
	lwzx 0,30,28
	cmpwi 0,0,0
	bc 4,2,.L49
.L46:
	bc 12,18,.L61
	lis 9,team_list@ha
	li 31,0
	la 11,team_list@l(9)
	lis 10,Last_Team_Winner@ha
.L65:
	lwz 9,0(11)
	addi 11,11,4
	lwz 0,88(9)
	cmpw 0,0,27
	bc 4,1,.L64
	mr 27,0
	stw 31,Last_Team_Winner@l(10)
.L64:
	addi 31,31,1
	cmpwi 0,31,1
	bc 4,1,.L65
	lis 9,Last_Team_Winner@ha
	lis 11,team_list@ha
	lwz 0,Last_Team_Winner@l(9)
	la 11,team_list@l(11)
	lis 4,.LC11@ha
	lis 9,gi@ha
	li 3,2
	lwz 10,gi@l(9)
	slwi 0,0,2
	la 4,.LC11@l(4)
	lwzx 9,11,0
	mtlr 10
	lwz 5,0(9)
	crxor 6,6,6
	blrl
	bl EndDMLevel
	b .L42
.L80:
	lis 9,gi@ha
	lis 4,.LC10@ha
	lwz 5,0(5)
	lwz 0,gi@l(9)
	la 4,.LC10@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L83
.L79:
	lis 9,gi@ha
	lis 4,.LC9@ha
	lwz 5,0(5)
	lwz 0,gi@l(9)
	la 4,.LC9@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L83
.L78:
	lis 9,gi@ha
	lis 4,.LC5@ha
	lwz 5,0(5)
	lwz 0,gi@l(9)
	la 4,.LC5@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L83:
	lis 9,Last_Team_Winner@ha
	stw 31,Last_Team_Winner@l(9)
	bl EndDMLevel
	b .L46
.L61:
	lis 11,.LC14@ha
	lis 9,timelimit@ha
	la 11,.LC14@l(11)
	lfs 0,0(11)
	lwz 11,timelimit@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L68
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 0,0(9)
	lis 9,level+4@ha
	fmuls 0,13,0
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L68
	lis 9,gi@ha
	lis 4,.LC12@ha
	lwz 0,gi@l(9)
	la 4,.LC12@l(4)
	b .L84
.L81:
	lis 9,gi@ha
	lis 4,.LC13@ha
	lwz 0,gi@l(9)
	la 4,.LC13@l(4)
.L84:
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	bl EndDMLevel
	b .L42
.L68:
	lis 9,fraglimit@ha
	lis 11,.LC14@ha
	lwz 8,fraglimit@l(9)
	la 11,.LC14@l(11)
	lfs 13,0(11)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L42
	lis 11,maxclients@ha
	li 31,0
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L42
	lis 9,game+1028@ha
	lis 11,g_edicts@ha
	fmr 11,0
	lwz 10,game+1028@l(9)
	mr 7,8
	lwz 9,g_edicts@l(11)
	lis 8,0x4330
	lis 11,.LC18@ha
	addi 10,10,3424
	la 11,.LC18@l(11)
	lfd 12,0(11)
	addi 11,9,1104
.L74:
	lwz 0,0(11)
	addi 11,11,1016
	cmpwi 0,0,0
	bc 12,2,.L73
	lwz 0,0(10)
	lfs 13,20(7)
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 12,3,.L81
.L73:
	addi 31,31,1
	xoris 0,31,0x8000
	addi 10,10,4732
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,11
	bc 12,0,.L74
.L42:
	lwz 0,84(1)
	lwz 12,36(1)
	mtlr 0
	lmw 26,40(1)
	lfd 30,64(1)
	lfd 31,72(1)
	mtcrf 8,12
	la 1,80(1)
	blr
.Lfe5:
	.size	 CheckDMRules,.Lfe5-CheckDMRules
	.section	".rodata"
	.align 2
.LC19:
	.string	"gamemap \"%s\"\n"
	.align 2
.LC20:
	.long 0x0
	.align 3
.LC21:
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
	lis 5,.LC19@ha
	la 29,level@l(29)
	addi 3,1,8
	lwz 6,208(29)
	la 5,.LC19@l(5)
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
	lis 9,.LC20@ha
	stw 0,212(29)
	la 9,.LC20@l(9)
	stw 0,208(29)
	lfs 13,0(9)
	stfs 13,204(29)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L93
	lis 11,.LC21@ha
	lis 28,g_edicts@ha
	la 11,.LC21@l(11)
	lis 30,0x4330
	lfd 31,0(11)
	li 29,1016
.L88:
	lwz 0,g_edicts@l(28)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L91
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L91
	bl ClientEndServerFrame
.L91:
	addi 31,31,1
	lwz 11,maxclients@l(27)
	xoris 0,31,0x8000
	addi 29,29,1016
	stw 0,284(1)
	stw 30,280(1)
	lfd 0,280(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L88
.L93:
	bl PBM_KillAllFires
	lis 11,.LC20@ha
	lis 9,maxclients@ha
	la 11,.LC20@l(11)
	li 10,0
	lfs 13,0(11)
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L95
	lis 9,g_edicts@ha
	mr 8,11
	lwz 11,g_edicts@l(9)
	lis 7,0x4330
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	addi 11,11,1016
	lfd 12,0(9)
.L97:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L96
	lwz 9,84(11)
	lwz 0,484(11)
	lwz 9,728(9)
	cmpw 0,0,9
	bc 4,1,.L96
	stw 9,484(11)
.L96:
	addi 10,10,1
	lfs 13,20(8)
	xoris 0,10,0x8000
	addi 11,11,1016
	stw 0,284(1)
	stw 7,280(1)
	lfd 0,280(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L97
.L95:
	bl LevelExitUserDLLs
	lwz 0,324(1)
	mtlr 0
	lmw 27,292(1)
	lfd 31,312(1)
	la 1,320(1)
	blr
.Lfe6:
	.size	 ExitLevel,.Lfe6-ExitLevel
	.section	".rodata"
	.align 3
.LC22:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC23:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC24:
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
	lis 11,level@ha
	lwz 9,level@l(11)
	lis 6,0x4330
	lis 10,.LC23@ha
	la 10,.LC23@l(10)
	la 5,level@l(11)
	addi 9,9,1
	lfd 12,0(10)
	xoris 0,9,0x8000
	lis 10,.LC22@ha
	lwz 7,212(5)
	stw 0,20(1)
	stw 6,16(1)
	cmpwi 0,7,0
	lfd 0,16(1)
	lfd 13,.LC22@l(10)
	stw 9,level@l(11)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,4(5)
	bc 12,2,.L102
	bl ExitLevel
	b .L101
.L102:
	lis 9,globals@ha
	li 30,0
	la 9,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(9)
	lis 25,g_edicts@ha
	lis 29,maxclients@ha
	lwz 31,g_edicts@l(11)
	cmpw 0,30,0
	bc 4,0,.L104
	mr 27,9
	mr 26,5
	lis 9,.LC23@ha
	lis 28,0x4330
	la 9,.LC23@l(9)
	lfd 31,0(9)
.L106:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L105
	stw 31,296(26)
	cmpwi 0,30,0
	lfs 0,4(31)
	lfs 13,8(31)
	lfs 12,12(31)
	stfs 0,28(31)
	stfs 13,32(31)
	stfs 12,36(31)
	bc 4,1,.L108
	xoris 0,30,0x8000
	lwz 11,maxclients@l(29)
	stw 0,20(1)
	stw 28,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L108
	mr 3,31
	bl ClientBeginServerFrame
	b .L105
.L108:
	mr 3,31
	bl G_RunEntity
.L105:
	lwz 0,72(27)
	addi 30,30,1
	addi 31,31,1016
	cmpw 0,30,0
	bc 12,0,.L106
.L104:
	bl CheckDMRules
	li 30,0
	lis 9,.LC24@ha
	lis 11,maxclients@ha
	la 9,.LC24@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L101
	lis 10,.LC23@ha
	lis 28,0x4330
	la 10,.LC23@l(10)
	li 31,1016
	lfd 31,0(10)
.L112:
	lwz 0,g_edicts@l(25)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L115
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L115
	bl ClientEndServerFrame
.L115:
	addi 30,30,1
	lwz 11,maxclients@l(29)
	xoris 0,30,0x8000
	addi 31,31,1016
	stw 0,20(1)
	stw 28,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L112
.L101:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe7:
	.size	 G_RunFrame,.Lfe7-G_RunFrame
	.comm	game,1564,4
	.comm	level,308,4
	.comm	gi,176,4
	.comm	globals,80,4
	.comm	st,72,4
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
	.comm	flyingnun_password,4,4
	.comm	RI,4,4
	.comm	team_kill,4,4
	.comm	class_limits,4,4
	.comm	spawn_camp_check,4,4
	.comm	spawn_camp_time,4,4
	.comm	invuln_medic,4,4
	.comm	death_msg,4,4
	.comm	level_wait,4,4
	.comm	invuln_spawn,4,4
	.comm	arty_delay,4,4
	.comm	arty_time,4,4
	.comm	arty_max,4,4
	.comm	easter_egg,4,4
	.comm	flood_msgs,4,4
	.comm	flood_persecond,4,4
	.comm	flood_waitdelay,4,4
	.comm	is_silenced,1,1
	.comm	maplist,1060,4
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
.Lfe8:
	.size	 stuffcmd,.Lfe8-stuffcmd
	.comm	team_list,8,4
	.comm	id_GameCmds,492,4
	.lcomm	UserDLLImports,48,4
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
	bl CleanUpCmds
	bl ClearUserDLLs
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
.Lfe9:
	.size	 ShutdownGame,.Lfe9-ShutdownGame
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
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	lis 11,.LC25@ha
	lis 9,maxclients@ha
	la 11,.LC25@l(11)
	li 30,0
	lfs 13,0(11)
	lis 27,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L15
	lis 9,.LC26@ha
	lis 28,g_edicts@ha
	la 9,.LC26@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,1016
.L17:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L16
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L16
	bl ClientEndServerFrame
.L16:
	addi 30,30,1
	lwz 11,maxclients@l(27)
	xoris 0,30,0x8000
	addi 31,31,1016
	stw 0,28(1)
	stw 29,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L17
.L15:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe10:
	.size	 ClientEndServerFrames,.Lfe10-ClientEndServerFrames
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
