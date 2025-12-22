	.file	"acebot_spawn.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"joined"
	.align 2
.LC1:
	.string	"changed to"
	.align 2
.LC2:
	.string	"skin"
	.align 2
.LC3:
	.string	"%s %s %s.\n"
	.align 2
.LC4:
	.string	"game"
	.align 2
.LC5:
	.string	""
	.align 2
.LC6:
	.string	"/bots/"
	.align 2
.LC7:
	.string	".cfg"
	.align 2
.LC8:
	.string	"rb"
	.align 2
.LC9:
	.string	"/bots/botdata.cfg"
	.align 2
.LC10:
	.string	"Bot Config file is out of date!\n"
	.section	".text"
	.align 2
	.globl ACESP_LoadBotConfig
	.type	 ACESP_LoadBotConfig,@function
ACESP_LoadBotConfig:
	stwu 1,-320(1)
	mflr 0
	stmw 25,292(1)
	stw 0,324(1)
	lis 9,gi+144@ha
	lis 3,.LC4@ha
	lwz 0,gi+144@l(9)
	lis 4,.LC5@ha
	li 5,0
	la 4,.LC5@l(4)
	la 3,.LC4@l(3)
	mtlr 0
	lis 29,.LC8@ha
	li 25,0
	blrl
	mr 31,3
	lwz 4,4(31)
	addi 3,1,8
	bl strcpy
	lis 4,.LC6@ha
	addi 3,1,8
	la 4,.LC6@l(4)
	bl strcat
	lis 4,level+72@ha
	addi 3,1,8
	la 4,level+72@l(4)
	bl strcat
	lis 4,.LC7@ha
	addi 3,1,8
	la 4,.LC7@l(4)
	bl strcat
	addi 3,1,8
	la 4,.LC8@l(29)
	bl fopen
	mr. 30,3
	bc 4,2,.L26
	lwz 4,4(31)
	addi 3,1,8
	bl strcpy
	lis 4,.LC9@ha
	addi 3,1,8
	la 4,.LC9@l(4)
	bl strcat
	la 4,.LC8@l(29)
	addi 3,1,8
	bl fopen
	mr. 30,3
	bc 12,2,.L25
.L26:
	addi 29,1,72
	addi 31,1,168
	li 4,80
	mr 5,30
	mr 3,29
	mr 26,29
	bl fgets
	li 0,255
	addi 28,1,264
	stw 29,264(1)
	addi 27,1,268
	stw 0,268(1)
	mr 3,28
	mr 4,31
	mr 5,27
	bl scanner
	lwz 0,268(1)
	cmpwi 0,0,19
	bc 4,2,.L31
	mr 3,28
	mr 5,27
	mr 4,31
	bl scanner
	lwz 0,268(1)
	cmpwi 0,0,2
	bc 4,2,.L29
	mr 3,31
	bl atoi
	mr 25,3
.L29:
	cmpwi 0,25,1
	bc 12,2,.L31
	lis 4,.LC10@ha
	li 3,2
	la 4,.LC10@l(4)
	crxor 6,6,6
	bl safe_bprintf
	mr 3,30
	bl fclose
	b .L25
.L33:
	mr 3,26
	bl ACESP_SpawnBotFromConfig
.L31:
	mr 3,26
	li 4,80
	mr 5,30
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L33
	mr 3,30
	bl fclose
.L25:
	lwz 0,324(1)
	mtlr 0
	lmw 25,292(1)
	la 1,320(1)
	blr
.Lfe1:
	.size	 ACESP_LoadBotConfig,.Lfe1-ACESP_LoadBotConfig
	.section	".rodata"
	.align 2
.LC11:
	.string	"Server is full, increase Maxclients.\n"
	.align 2
.LC12:
	.string	"name"
	.align 2
.LC13:
	.string	"hand"
	.align 2
.LC14:
	.string	"2"
	.align 2
.LC15:
	.string	"spectator"
	.align 2
.LC16:
	.string	"0"
	.align 2
.LC17:
	.long 0x46fffe00
	.align 3
.LC18:
	.long 0x3fd51eb8
	.long 0x51eb851f
	.align 2
.LC19:
	.long 0x0
	.align 2
.LC20:
	.long 0x3f800000
	.align 3
.LC21:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ACESP_SpawnBotFromConfig
	.type	 ACESP_SpawnBotFromConfig,@function
ACESP_SpawnBotFromConfig:
	stwu 1,-1200(1)
	mflr 0
	stfd 31,1192(1)
	stmw 24,1160(1)
	stw 0,1204(1)
	li 0,255
	stw 3,1128(1)
	li 31,1
	stw 0,1132(1)
	li 28,0
	li 27,0
	li 26,0
	addi 29,1,632
.L38:
	mr 4,29
	addi 3,1,1128
	addi 5,1,1132
	bl scanner
	lwz 11,1132(1)
	xori 9,11,18
	subfic 0,9,0
	adde 9,0,9
	subfic 4,11,0
	adde 0,4,11
	or. 10,9,0
	bc 4,2,.L35
	xori 9,11,7
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,20
	subfic 4,0,0
	adde 0,4,0
	or. 10,9,0
	bc 4,2,.L36
	cmpwi 0,11,9
	bc 4,2,.L41
	addi 31,31,1
	b .L36
.L41:
	cmpwi 0,31,1
	bc 4,2,.L42
	cmpwi 0,11,4
	bc 4,2,.L42
	addi 3,1,520
	b .L78
.L42:
	cmpwi 0,31,2
	lwz 0,1132(1)
	bc 4,2,.L43
	cmpwi 0,0,4
	bc 4,2,.L43
	addi 3,1,552
.L78:
	mr 4,29
	bl strcpy
	b .L36
.L43:
	cmpwi 0,31,3
	bc 4,2,.L44
	cmpwi 0,0,2
	bc 4,2,.L44
	mr 3,29
	bl atoi
	mr 28,3
	b .L36
.L44:
	cmpwi 0,31,4
	bc 4,2,.L45
	cmpwi 0,0,2
	bc 4,2,.L45
	mr 3,29
	bl atoi
	mr 27,3
	b .L36
.L45:
	cmpwi 0,31,5
	bc 4,2,.L36
	lwz 0,1132(1)
	cmpwi 0,0,2
	bc 4,2,.L36
	mr 3,29
	bl atoi
	mr 26,3
.L36:
	lwz 0,1132(1)
	cmpwi 0,0,20
	bc 4,2,.L38
	bl ACESP_FindFreeClient
	mr. 30,3
	bc 4,2,.L48
	lis 4,.LC11@ha
	li 3,1
	la 4,.LC11@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L35
.L48:
	addi 29,1,8
	li 9,1
	lis 0,0x42c8
	stw 9,904(30)
	li 4,0
	stw 9,88(30)
	li 5,512
	mr 3,29
	stw 0,420(30)
	lis 24,teamplay@ha
	crxor 6,6,6
	bl memset
	lis 4,.LC12@ha
	addi 5,1,520
	la 4,.LC12@l(4)
	mr 3,29
	bl Info_SetValueForKey
	lis 4,.LC2@ha
	addi 5,1,552
	la 4,.LC2@l(4)
	mr 3,29
	bl Info_SetValueForKey
	lis 4,.LC13@ha
	lis 5,.LC14@ha
	la 4,.LC13@l(4)
	la 5,.LC14@l(5)
	mr 3,29
	bl Info_SetValueForKey
	lis 4,.LC15@ha
	lis 5,.LC16@ha
	la 5,.LC16@l(5)
	la 4,.LC15@l(4)
	mr 3,29
	bl Info_SetValueForKey
	mr 4,29
	mr 3,30
	bl ClientConnect
	mr 3,30
	bl G_InitEdict
	lis 11,teamplay@ha
	lis 4,.LC19@ha
	lwz 9,teamplay@l(11)
	la 4,.LC19@l(4)
	lfs 13,0(4)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L49
	cmpwi 0,28,0
	bc 4,2,.L49
	lis 9,maxclients@ha
	lis 10,.LC20@ha
	lwz 11,maxclients@l(9)
	la 10,.LC20@l(10)
	li 6,0
	lfs 13,0(10)
	li 8,0
	li 7,1
	lfs 0,20(11)
	fadds 0,0,13
	fcmpu 0,13,0
	bc 4,0,.L61
	lis 4,.LC21@ha
	lis 9,g_edicts@ha
	fmr 12,0
	la 4,.LC21@l(4)
	lwz 11,g_edicts@l(9)
	lis 5,0x4330
	lfd 13,0(4)
	addi 10,11,996
.L55:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L60
	lwz 9,84(10)
	lwz 11,3488(9)
	cmpwi 0,11,1
	bc 4,2,.L57
	addi 6,6,1
	b .L60
.L57:
	xori 11,11,2
	addi 9,8,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L60:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,996
	stw 0,1156(1)
	stw 5,1152(1)
	lfd 0,1152(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L55
.L61:
	cmpw 0,6,8
	li 28,1
	bc 4,1,.L62
	li 28,2
.L62:
.L49:
	lwz 3,84(30)
	stw 27,984(30)
	stw 26,988(30)
	bl InitClientResp
	lis 11,teamplay@ha
	lis 4,.LC19@ha
	lwz 9,teamplay@l(11)
	la 4,.LC19@l(4)
	lfs 13,0(4)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L65
	mr 5,28
	mr 3,30
	li 4,1
	bl ACESP_PutClientInServer
	b .L66
.L65:
	mr 3,30
	li 4,1
	li 5,0
	bl ACESP_PutClientInServer
.L66:
	mr 3,30
	bl ClientEndServerFrame
	mr 3,30
	bl ACEIT_PlayerAdded
	mr 3,30
	bl ACEAI_PickLongRangeGoal
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,1156(1)
	lis 4,.LC21@ha
	lis 10,.LC17@ha
	la 4,.LC21@l(4)
	stw 0,1152(1)
	lis 11,.LC18@ha
	lfd 13,0(4)
	lfd 0,1152(1)
	lfs 11,.LC17@l(10)
	lfd 12,.LC18@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L35
	lis 9,num_players@ha
	li 28,0
	lwz 0,num_players@l(9)
	li 27,0
	lis 25,num_players@ha
	cmpw 0,28,0
	bc 12,1,.L69
	lis 10,.LC19@ha
	lis 9,players@ha
	la 10,.LC19@l(10)
	la 26,players@l(9)
	lfs 31,0(10)
	li 31,0
	addi 29,1,728
.L71:
	lwzx 4,31,26
	cmpwi 0,4,0
	bc 12,2,.L70
	cmpw 0,4,30
	bc 12,2,.L70
	lwz 0,248(4)
	cmpwi 0,0,0
	bc 12,2,.L70
	lwz 9,teamplay@l(24)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L74
	mr 3,30
	bl OnSameTeam
	cmpwi 0,3,0
	bc 4,2,.L70
.L74:
	lwzx 0,31,26
	addi 28,28,1
	stw 0,0(29)
	addi 29,29,4
.L70:
	lwz 0,num_players@l(25)
	addi 27,27,1
	addi 31,31,4
	cmpw 0,27,0
	bc 4,1,.L71
.L69:
	cmpwi 0,28,0
	bc 4,1,.L35
	lis 11,ltk_chat@ha
	lis 4,.LC19@ha
	lwz 9,ltk_chat@l(11)
	la 4,.LC19@l(4)
	lfs 13,0(4)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L35
	bl rand
	mr 0,3
	addi 11,1,728
	divw 9,0,28
	mr 3,30
	li 5,0
	mullw 9,9,28
	subf 0,9,0
	slwi 0,0,2
	lwzx 4,11,0
	bl LTK_Chat
.L35:
	lwz 0,1204(1)
	mtlr 0
	lmw 24,1160(1)
	lfd 31,1192(1)
	la 1,1200(1)
	blr
.Lfe2:
	.size	 ACESP_SpawnBotFromConfig,.Lfe2-ACESP_SpawnBotFromConfig
	.section	".rodata"
	.align 2
.LC23:
	.string	"%s entered the game\n"
	.align 2
.LC24:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC25:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC26:
	.string	"bot"
	.align 2
.LC27:
	.string	"players/male/tris.md2"
	.align 2
.LC28:
	.string	"fov"
	.align 2
.LC31:
	.string	"MP5/10 Submachinegun"
	.align 2
.LC32:
	.string	"M4 Assault Rifle"
	.align 2
.LC33:
	.string	"M3 Super 90 Assault Shotgun"
	.align 2
.LC34:
	.string	"Handcannon"
	.align 2
.LC35:
	.string	"Sniper Rifle"
	.align 2
.LC36:
	.string	"Silencer"
	.align 2
.LC37:
	.string	"Stealth Slippers"
	.align 2
.LC38:
	.string	"Bandolier"
	.align 2
.LC39:
	.string	"Kevlar Vest"
	.align 2
.LC40:
	.string	"Lasersight"
	.align 3
.LC29:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC30:
	.long 0x46fffe00
	.align 2
.LC41:
	.long 0x0
	.align 2
.LC42:
	.long 0x41400000
	.align 2
.LC43:
	.long 0x41000000
	.align 3
.LC44:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC45:
	.long 0x3f800000
	.align 2
.LC46:
	.long 0x43200000
	.align 2
.LC47:
	.long 0x47800000
	.align 2
.LC48:
	.long 0x43b40000
	.align 3
.LC49:
	.long 0x402e0000
	.long 0x0
	.align 3
.LC50:
	.long 0x40080000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACESP_PutClientInServer
	.type	 ACESP_PutClientInServer,@function
ACESP_PutClientInServer:
	stwu 1,-4384(1)
	mflr 0
	stfd 30,4368(1)
	stfd 31,4376(1)
	stmw 21,4324(1)
	stw 0,4388(1)
	lis 9,.LC24@ha
	lis 11,.LC25@ha
	lwz 0,.LC24@l(9)
	la 6,.LC25@l(11)
	addi 7,1,8
	la 9,.LC24@l(9)
	lwz 8,.LC25@l(11)
	mr 21,5
	lwz 29,8(9)
	addi 10,1,24
	mr 31,3
	lwz 28,4(9)
	addi 5,1,56
	mr 23,4
	stw 0,8(1)
	mr 22,5
	stw 29,8(7)
	addi 4,1,40
	stw 28,4(7)
	lwz 0,8(6)
	lwz 9,4(6)
	stw 8,24(1)
	stw 0,8(10)
	stw 9,4(10)
	bl SelectSpawnPoint
	lis 9,deathmatch@ha
	lis 5,.LC41@ha
	lwz 30,84(31)
	lwz 10,deathmatch@l(9)
	la 5,.LC41@l(5)
	lis 11,g_edicts@ha
	lfs 13,0(5)
	lis 0,0xe64
	lfs 0,20(10)
	ori 0,0,49481
	lwz 9,g_edicts@l(11)
	fcmpu 0,0,13
	subf 9,9,31
	mullw 9,9,0
	srawi 9,9,2
	addi 25,9,-1
	bc 12,2,.L82
	addi 28,1,1704
	addi 27,30,1812
	addi 26,1,3784
	mr 4,27
	li 5,2072
	mr 3,28
	crxor 6,6,6
	bl memcpy
	addi 29,30,188
	mr 24,28
	mr 4,29
	li 5,512
	mr 3,26
	mr 28,29
	crxor 6,6,6
	bl memcpy
	mr 3,30
	bl InitClientPersistant
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	b .L83
.L82:
	addi 29,1,1704
	li 4,0
	mr 3,29
	li 5,2072
	crxor 6,6,6
	bl memset
	mr 24,29
	addi 27,30,1812
	addi 28,30,188
.L83:
	addi 29,1,72
	mr 4,28
	li 5,1624
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,4564
	mr 3,30
	crxor 6,6,6
	bl memset
	mr 4,29
	li 5,1624
	mr 3,28
	crxor 6,6,6
	bl memcpy
	mr 4,24
	li 5,2072
	mr 3,27
	crxor 6,6,6
	bl memcpy
	mr 3,31
	bl FetchClientEntData
	li 7,0
	lis 11,game+1028@ha
	mulli 6,25,4564
	lwz 27,184(31)
	stw 7,552(31)
	lis 9,.LC26@ha
	li 5,2
	lwz 10,game+1028@l(11)
	la 9,.LC26@l(9)
	li 0,4
	stw 9,280(31)
	li 11,24
	li 8,200
	add 29,10,6
	lis 9,.LC42@ha
	stw 0,260(31)
	stw 11,508(31)
	la 9,.LC42@l(9)
	lis 3,level+4@ha
	stw 8,400(31)
	lis 4,teamplay@ha
	lis 10,0x201
	stw 5,248(31)
	lis 8,player_pain@ha
	lis 11,player_die@ha
	stw 5,512(31)
	la 8,player_pain@l(8)
	la 11,player_die@l(11)
	stw 29,84(31)
	lis 5,.LC41@ha
	ori 10,10,3
	stw 7,492(31)
	la 5,.LC41@l(5)
	rlwinm 6,27,0,31,29
	lfs 0,level+4@l(3)
	lfs 12,0(9)
	lfs 13,0(5)
	lis 9,.LC27@ha
	lwz 0,264(31)
	la 9,.LC27@l(9)
	fadds 0,0,12
	lwz 5,teamplay@l(4)
	rlwinm 4,0,0,21,19
	stw 10,252(31)
	stw 9,268(31)
	stfs 0,404(31)
	stw 8,452(31)
	stw 11,456(31)
	stw 6,184(31)
	stw 7,908(31)
	stw 7,612(31)
	stw 7,608(31)
	stw 4,264(31)
	lfs 0,20(5)
	fcmpu 0,0,13
	bc 12,2,.L85
	lwz 0,3488(29)
	cmpwi 0,0,0
	bc 12,2,.L84
.L85:
	rlwinm 0,4,0,28,26
	rlwinm 9,27,0,0,29
	stw 0,264(31)
	stw 9,184(31)
.L84:
	lis 9,.LC41@ha
	lfs 10,12(1)
	li 5,184
	la 9,.LC41@l(9)
	lfs 0,16(1)
	li 4,0
	lfs 13,24(1)
	lfs 12,28(1)
	lfs 11,32(1)
	lfs 9,8(1)
	lfs 31,0(9)
	lwz 3,84(31)
	stfs 10,192(31)
	stfs 0,196(31)
	stfs 13,200(31)
	stfs 12,204(31)
	stfs 11,208(31)
	stfs 9,188(31)
	stfs 31,384(31)
	stfs 31,380(31)
	stfs 31,376(31)
	crxor 6,6,6
	bl memset
	lis 5,.LC43@ha
	lfs 0,40(1)
	la 5,.LC43@l(5)
	mr 10,11
	lfs 10,0(5)
	mr 8,11
	lis 9,deathmatch@ha
	lwz 7,deathmatch@l(9)
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,4312(1)
	lwz 11,4316(1)
	sth 11,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,4312(1)
	lwz 10,4316(1)
	sth 10,6(30)
	lfs 0,48(1)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,4312(1)
	lwz 8,4316(1)
	sth 8,8(30)
	lfs 0,20(7)
	fcmpu 0,0,31
	bc 12,2,.L86
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,4312(1)
	lwz 11,4316(1)
	andi. 9,11,32768
	bc 4,2,.L134
.L86:
	lis 4,.LC28@ha
	mr 3,28
	la 4,.LC28@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,4316(1)
	lis 0,0x4330
	lis 5,.LC44@ha
	la 5,.LC44@l(5)
	stw 0,4312(1)
	lis 10,.LC45@ha
	lfd 13,0(5)
	la 10,.LC45@l(10)
	lfd 0,4312(1)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(30)
	bc 4,0,.L88
.L134:
	lis 0,0x42b4
	stw 0,112(30)
	b .L87
.L88:
	lis 11,.LC46@ha
	la 11,.LC46@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L87
	stfs 13,112(30)
.L87:
	lis 9,gi+32@ha
	lwz 11,1788(30)
	cmpwi 0,23,0
	lwz 0,gi+32@l(9)
	li 29,0
	lwz 3,32(11)
	mtlr 0
	mfcr 28
	blrl
	lis 10,g_edicts@ha
	lis 11,0xe64
	stw 3,88(30)
	lwz 9,g_edicts@l(10)
	ori 11,11,49481
	li 0,255
	stw 0,40(31)
	mr 3,31
	subf 9,9,31
	stw 29,64(31)
	mullw 9,9,11
	srawi 9,9,2
	addi 9,9,-1
	stw 9,60(31)
	bl ShowGun
	lis 11,.LC45@ha
	lfs 13,48(1)
	lis 9,.LC47@ha
	la 11,.LC45@l(11)
	li 0,3
	lfs 11,40(1)
	lfs 0,0(11)
	la 9,.LC47@l(9)
	lis 10,.LC48@ha
	mtctr 0
	lfs 12,44(1)
	la 10,.LC48@l(10)
	mr 5,22
	lfs 9,0(9)
	addi 8,30,3444
	li 11,0
	fadds 13,13,0
	lfs 10,0(10)
	addi 10,30,20
	stw 29,56(31)
	stfs 11,28(31)
	stfs 12,32(31)
	stfs 13,36(31)
	stfs 11,4(31)
	stfs 12,8(31)
	stfs 13,12(31)
.L133:
	lfsx 0,11,5
	lfsx 12,11,8
	addi 11,11,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,4312(1)
	lwz 9,4316(1)
	sth 9,0(10)
	addi 10,10,2
	bdnz .L133
	lis 5,.LC41@ha
	lfs 0,60(1)
	mr 3,31
	la 5,.LC41@l(5)
	lfs 31,0(5)
	stfs 0,20(31)
	stfs 31,24(31)
	stfs 31,16(31)
	stfs 31,28(30)
	lfs 13,20(31)
	lwz 0,1788(30)
	stfs 13,32(30)
	lfs 0,24(31)
	stfs 0,36(30)
	lfs 13,16(31)
	stfs 13,4060(30)
	lfs 0,20(31)
	stfs 0,4064(30)
	lfs 13,24(31)
	stw 0,3956(30)
	stfs 13,4068(30)
	bl ChangeWeapon
	lis 9,teamplay@ha
	li 0,0
	lwz 11,teamplay@l(9)
	stw 0,416(31)
	stw 0,540(31)
	lfs 0,20(11)
	fcmpu 0,0,31
	li 0,5
	bc 4,2,.L96
	li 0,1
.L96:
	stw 0,992(31)
	li 5,99
	mr 3,31
	li 4,96
	bl ACEND_FindClosestReachableNode
	lis 9,level@ha
	stw 3,968(31)
	lis 5,.LC49@ha
	la 29,level@l(9)
	stw 3,960(31)
	la 5,.LC49@l(5)
	stw 3,964(31)
	mtcrf 128,28
	lfs 13,4(29)
	lfd 12,0(5)
	stfs 13,924(31)
	lfs 0,4(29)
	fadd 0,0,12
	frsp 0,0
	stfs 0,932(31)
	bc 4,2,.L98
	lis 9,ACESP_HoldSpawn@ha
	lis 11,.LC29@ha
	la 9,ACESP_HoldSpawn@l(9)
	lfd 13,.LC29@l(11)
	stw 9,436(31)
	lfs 0,4(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,4(29)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,4316(1)
	lis 5,.LC44@ha
	lis 11,.LC30@ha
	la 5,.LC44@l(5)
	stw 0,4312(1)
	lis 10,.LC50@ha
	lfd 13,0(5)
	la 10,.LC50@l(10)
	lfd 0,4312(1)
	lfs 11,.LC30@l(11)
	lfd 10,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fmadd 13,13,10,12
	frsp 13,13
	stfs 13,428(31)
	b .L81
.L98:
	lis 11,teamplay@ha
	lis 5,.LC41@ha
	lwz 9,teamplay@l(11)
	la 5,.LC41@l(5)
	lfs 13,0(5)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L100
	mr 3,31
	bl StartClient
	b .L101
.L100:
	lwz 10,84(31)
	lwz 3,1804(10)
	cmpwi 0,3,0
	bc 12,2,.L132
	lwz 9,184(31)
	li 11,0
	li 0,1
	stw 0,260(31)
	ori 9,9,1
	stw 11,248(31)
	stw 9,184(31)
	stw 11,3488(10)
	lwz 9,84(31)
	stw 11,88(9)
.L101:
	cmpwi 0,3,0
	mfcr 29
	bc 4,2,.L103
.L132:
	lis 9,teamplay@ha
	lis 5,.LC41@ha
	lwz 11,teamplay@l(9)
	cmpwi 0,3,0
	la 5,.LC41@l(5)
	lfs 13,0(5)
	lfs 0,20(11)
	mfcr 29
	fcmpu 0,0,13
	bc 4,2,.L103
	mr 3,31
	bl KillBox
.L103:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,ACEAI_Think@ha
	lis 11,level+4@ha
	la 9,ACEAI_Think@l(9)
	lis 8,.LC29@ha
	stw 9,436(31)
	li 10,12
	li 5,24
	lfs 0,level+4@l(11)
	li 6,2
	li 7,30
	lfd 13,.LC29@l(8)
	li 9,7
	li 11,6
	li 8,10
	li 0,0
	lis 3,0x42b4
	li 4,90
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	stw 7,4252(30)
	stw 9,4236(30)
	stw 11,4244(30)
	stw 5,4228(30)
	stw 10,4232(30)
	stw 8,4276(30)
	stw 6,4280(30)
	stw 10,4220(30)
	stw 5,4260(30)
	stw 6,4268(30)
	stw 10,4224(30)
	stw 0,892(31)
	stw 4,4304(30)
	stw 3,112(30)
	stw 0,4392(30)
	stw 0,4328(30)
	stw 0,4332(30)
	stw 0,4340(30)
	stw 0,4336(30)
	stw 0,4300(30)
	stw 0,4316(30)
	stw 0,4324(30)
	stw 0,4320(30)
	stw 0,4396(30)
	lwz 3,984(31)
	cmpwi 0,3,0
	bc 4,2,.L104
	bl rand
	lis 0,0x6666
	srawi 11,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,1
	subf 0,11,0
	slwi 9,0,2
	add 9,9,0
	subf 0,9,3
	b .L105
.L104:
	addi 0,3,-1
.L105:
	cmplwi 0,0,4
	bc 12,1,.L112
	lis 11,.L113@ha
	slwi 10,0,2
	la 11,.L113@l(11)
	lis 9,.L113@ha
	lwzx 0,10,11
	la 9,.L113@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L113:
	.long .L107-.L113
	.long .L108-.L113
	.long .L109-.L113
	.long .L110-.L113
	.long .L111-.L113
.L107:
	lis 4,.LC31@ha
	mr 3,31
	la 4,.LC31@l(4)
	bl ACEAI_Cmd_Choose
	b .L106
.L108:
	lis 4,.LC32@ha
	mr 3,31
	la 4,.LC32@l(4)
	bl ACEAI_Cmd_Choose
	b .L106
.L109:
	lis 4,.LC33@ha
	mr 3,31
	la 4,.LC33@l(4)
	bl ACEAI_Cmd_Choose
	b .L106
.L110:
	lis 4,.LC34@ha
	mr 3,31
	la 4,.LC34@l(4)
	bl ACEAI_Cmd_Choose
	b .L106
.L111:
	lis 4,.LC35@ha
	mr 3,31
	la 4,.LC35@l(4)
	bl ACEAI_Cmd_Choose
	b .L106
.L112:
	lis 4,.LC33@ha
	mr 3,31
	la 4,.LC33@l(4)
	bl ACEAI_Cmd_Choose
.L106:
	lwz 3,988(31)
	cmpwi 0,3,0
	bc 4,2,.L114
	bl rand
	lis 0,0x6666
	srawi 11,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,1
	subf 0,11,0
	slwi 9,0,2
	add 9,9,0
	subf 0,9,3
	b .L115
.L114:
	addi 0,3,-1
.L115:
	cmplwi 0,0,4
	bc 12,1,.L122
	lis 11,.L123@ha
	slwi 10,0,2
	la 11,.L123@l(11)
	lis 9,.L123@ha
	lwzx 0,10,11
	la 9,.L123@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L123:
	.long .L117-.L123
	.long .L118-.L123
	.long .L119-.L123
	.long .L120-.L123
	.long .L121-.L123
.L117:
	lis 4,.LC36@ha
	mr 3,31
	la 4,.LC36@l(4)
	bl ACEAI_Cmd_Choose
	b .L116
.L118:
	lis 4,.LC37@ha
	mr 3,31
	la 4,.LC37@l(4)
	bl ACEAI_Cmd_Choose
	b .L116
.L119:
	lis 4,.LC38@ha
	mr 3,31
	la 4,.LC38@l(4)
	bl ACEAI_Cmd_Choose
	b .L116
.L120:
	lis 4,.LC39@ha
	mr 3,31
	la 4,.LC39@l(4)
	bl ACEAI_Cmd_Choose
	b .L116
.L121:
	lis 4,.LC40@ha
	mr 3,31
	la 4,.LC40@l(4)
	bl ACEAI_Cmd_Choose
	b .L116
.L122:
	lis 4,.LC39@ha
	mr 3,31
	la 4,.LC39@l(4)
	bl ACEAI_Cmd_Choose
.L116:
	mtcrf 128,29
	bc 4,2,.L124
	lis 9,allitem@ha
	lis 5,.LC41@ha
	lwz 11,allitem@l(9)
	la 5,.LC41@l(5)
	lfs 31,0(5)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L125
	mr 3,31
	bl AllItems
.L125:
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L126
	mr 3,31
	bl EquipClient
.L126:
	lwz 9,84(31)
	lwz 0,4432(9)
	cmpwi 0,0,0
	bc 12,2,.L127
	mr 3,31
	bl PMenu_Close
	b .L81
.L127:
	lis 9,allweapon@ha
	lwz 11,allweapon@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L128
	mr 3,31
	bl AllWeapons
.L128:
	lwz 0,1788(30)
	mr 3,31
	stw 0,3956(30)
	bl ChangeWeapon
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L124
	li 0,1
	lis 9,gi+72@ha
	stw 0,248(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L124:
	lis 9,teamplay@ha
	lis 5,.LC41@ha
	lwz 11,teamplay@l(9)
	la 5,.LC41@l(5)
	lfs 30,0(5)
	lfs 0,20(11)
	fcmpu 0,0,30
	bc 12,2,.L130
	lwz 9,84(31)
	lis 10,.LC44@ha
	lis 4,.LC2@ha
	la 10,.LC44@l(10)
	la 4,.LC2@l(4)
	stw 21,3488(9)
	lis 29,0x4330
	lwz 3,84(31)
	lfd 31,0(10)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl AssignSkin
	bl rand
	lis 0,0x9249
	srawi 10,3,31
	ori 0,0,9363
	lis 9,level+4@ha
	mulhw 0,3,0
	lfs 13,level+4@l(9)
	lis 5,.LC50@ha
	la 5,.LC50@l(5)
	add 0,0,3
	lfd 0,0(5)
	srawi 0,0,2
	subf 0,10,0
	slwi 9,0,3
	subf 9,0,9
	fadd 13,13,0
	subf 3,9,3
	xoris 3,3,0x8000
	stw 3,4316(1)
	stw 29,4312(1)
	lfd 0,4312(1)
	fsub 0,0,31
	fadd 13,13,0
	frsp 13,13
	stfs 13,940(31)
	bl rand
	lis 9,num_players@ha
	lfs 9,4(31)
	lwz 0,num_players@l(9)
	rlwinm 3,3,0,17,31
	mr 10,8
	xoris 3,3,0x8000
	lis 11,.LC30@ha
	lfs 10,8(31)
	xoris 0,0,0x8000
	lfs 12,.LC30@l(11)
	mr 9,8
	stw 0,4316(1)
	lis 11,nodes@ha
	stw 29,4312(1)
	la 11,nodes@l(11)
	lfd 13,4312(1)
	addi 7,11,4
	stw 3,4316(1)
	stw 29,4312(1)
	lfd 0,4312(1)
	fsub 13,13,31
	fsub 0,0,31
	frsp 13,13
	frsp 0,0
	fdivs 0,0,12
	fmuls 13,13,0
	fmr 12,13
	fctiwz 11,12
	stfd 11,4312(1)
	lwz 9,4316(1)
	mulli 9,9,116
	lfsx 0,11,9
	fsubs 0,0,9
	stfs 0,912(31)
	lfsx 13,7,9
	stfs 30,920(31)
	fsubs 13,13,10
	stfs 13,916(31)
	b .L131
.L130:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,940(31)
.L131:
	addi 3,31,944
	li 4,0
	li 5,8
	crxor 6,6,6
	bl memset
	li 0,0
	stw 0,944(31)
	stw 0,948(31)
.L81:
	lwz 0,4388(1)
	mtlr 0
	lmw 21,4324(1)
	lfd 30,4368(1)
	lfd 31,4376(1)
	la 1,4384(1)
	blr
.Lfe3:
	.size	 ACESP_PutClientInServer,.Lfe3-ACESP_PutClientInServer
	.section	".rodata"
	.align 2
.LC51:
	.long 0x46fffe00
	.align 3
.LC52:
	.long 0x3fc33333
	.long 0x33333333
	.align 2
.LC53:
	.long 0x0
	.align 3
.LC54:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ACESP_Respawn
	.type	 ACESP_Respawn,@function
ACESP_Respawn:
	stwu 1,-464(1)
	mflr 0
	stfd 31,456(1)
	stmw 24,424(1)
	stw 0,468(1)
	mr 31,3
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L138
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 4,2,.L137
.L138:
	mr 3,31
	bl CopyToBodyQue
.L137:
	lis 11,.LC53@ha
	lis 9,teamplay@ha
	la 11,.LC53@l(11)
	lis 24,teamplay@ha
	lfs 13,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L139
	lwz 9,84(31)
	mr 3,31
	li 4,1
	lwz 5,3488(9)
	bl ACESP_PutClientInServer
	b .L140
.L139:
	mr 3,31
	li 4,1
	li 5,0
	bl ACESP_PutClientInServer
.L140:
	lwz 0,184(31)
	lis 9,level+4@ha
	lwz 11,84(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lfs 0,level+4@l(9)
	stfs 0,4216(11)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,420(1)
	lis 11,.LC54@ha
	lis 10,.LC51@ha
	la 11,.LC54@l(11)
	stw 0,416(1)
	lfd 13,0(11)
	lfd 0,416(1)
	lis 11,.LC52@ha
	lfs 11,.LC51@l(10)
	lfd 12,.LC52@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L141
	lwz 4,956(31)
	li 28,0
	cmpwi 0,4,0
	bc 12,2,.L142
	lis 9,.LC53@ha
	lis 11,ltk_chat@ha
	la 9,.LC53@l(9)
	lfs 13,0(9)
	lwz 9,ltk_chat@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L143
	mr 3,31
	li 5,1
	bl LTK_Chat
.L143:
	stw 28,956(31)
	b .L141
.L142:
	lis 9,num_players@ha
	li 27,0
	lwz 0,num_players@l(9)
	lis 25,num_players@ha
	cmpw 0,28,0
	bc 12,1,.L146
	lis 11,.LC53@ha
	lis 9,players@ha
	la 11,.LC53@l(11)
	la 26,players@l(9)
	lfs 31,0(11)
	li 29,0
	addi 30,1,8
.L148:
	lwzx 4,29,26
	cmpwi 0,4,0
	bc 12,2,.L147
	cmpw 0,4,31
	bc 12,2,.L147
	lwz 0,248(4)
	cmpwi 0,0,0
	bc 12,2,.L147
	lwz 9,teamplay@l(24)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L151
	mr 3,31
	bl OnSameTeam
	cmpwi 0,3,0
	bc 4,2,.L147
.L151:
	lwzx 0,29,26
	addi 28,28,1
	stw 0,0(30)
	addi 30,30,4
.L147:
	lwz 0,num_players@l(25)
	addi 27,27,1
	addi 29,29,4
	cmpw 0,27,0
	bc 4,1,.L148
.L146:
	cmpwi 0,28,0
	bc 4,1,.L141
	lis 9,.LC53@ha
	lis 11,ltk_chat@ha
	la 9,.LC53@l(9)
	lfs 13,0(9)
	lwz 9,ltk_chat@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L141
	bl rand
	mr 0,3
	addi 11,1,8
	divw 9,0,28
	mr 3,31
	li 5,2
	mullw 9,9,28
	subf 0,9,0
	slwi 0,0,2
	lwzx 4,11,0
	bl LTK_Chat
.L141:
	lwz 0,468(1)
	mtlr 0
	lmw 24,424(1)
	lfd 31,456(1)
	la 1,464(1)
	blr
.Lfe4:
	.size	 ACESP_Respawn,.Lfe4-ACESP_Respawn
	.section	".rodata"
	.align 2
.LC57:
	.string	"male/bluebeard"
	.align 2
.LC59:
	.string	"female/brianna"
	.align 2
.LC61:
	.string	"male/blues"
	.align 2
.LC63:
	.string	"female/ensign"
	.align 2
.LC64:
	.string	"female/jezebel"
	.align 2
.LC66:
	.string	"female/jungle"
	.align 2
.LC68:
	.string	"sas/sasurban"
	.align 2
.LC70:
	.string	"terror/urbanterr"
	.align 2
.LC72:
	.string	"female/venus"
	.align 2
.LC73:
	.string	"sydney/sydney"
	.align 2
.LC75:
	.string	"male/cajin"
	.align 2
.LC77:
	.string	"male/commando"
	.align 2
.LC79:
	.string	"male/grunt"
	.align 2
.LC81:
	.string	"male/mclaine"
	.align 2
.LC82:
	.string	"male/robber"
	.align 2
.LC84:
	.string	"male/snowcamo"
	.align 2
.LC86:
	.string	"terror/swat"
	.align 2
.LC88:
	.string	"terror/jungleterr"
	.align 2
.LC90:
	.string	"sas/saspolice"
	.align 2
.LC91:
	.string	"sas/sasuc"
	.align 2
.LC55:
	.long 0x46fffe00
	.align 3
.LC56:
	.long 0x3fa99999
	.long 0x9999999a
	.align 3
.LC58:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC60:
	.long 0x3fc33333
	.long 0x33333333
	.align 3
.LC62:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC65:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC67:
	.long 0x3fd66666
	.long 0x66666666
	.align 3
.LC69:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC71:
	.long 0x3fdccccc
	.long 0xcccccccd
	.align 3
.LC74:
	.long 0x3fe19999
	.long 0x9999999a
	.align 3
.LC76:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC78:
	.long 0x3fe4cccc
	.long 0xcccccccd
	.align 3
.LC80:
	.long 0x3fe66666
	.long 0x66666666
	.align 3
.LC83:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC85:
	.long 0x3feb3333
	.long 0x33333333
	.align 3
.LC87:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 3
.LC89:
	.long 0x3fee6666
	.long 0x66666666
	.align 3
.LC92:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC93:
	.long 0x3fd00000
	.long 0x0
	.align 3
.LC94:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC95:
	.long 0x3fe80000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACESP_SetName
	.type	 ACESP_SetName,@function
ACESP_SetName:
	stwu 1,-1568(1)
	mflr 0
	stmw 28,1552(1)
	stw 0,1572(1)
	mr 29,4
	mr 30,3
	mr 31,5
	mr 3,29
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L170
	addi 0,1,1032
	mr 3,0
	mr 28,0
	bl LTKsetBotName
	b .L171
.L170:
	addi 0,1,1032
	mr 4,29
	mr 3,0
	mr 28,0
	bl strcpy
.L171:
	mr 3,31
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L172
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,1548(1)
	lis 11,.LC92@ha
	lis 10,.LC55@ha
	la 11,.LC92@l(11)
	stw 0,1544(1)
	lfd 12,0(11)
	lfd 0,1544(1)
	lis 11,.LC56@ha
	lfs 11,.LC55@l(10)
	lfd 13,.LC56@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 11,0,11
	fmr 12,11
	fcmpu 0,12,13
	bc 4,0,.L173
	addi 29,1,520
	lis 4,.LC57@ha
	la 4,.LC57@l(4)
	b .L212
.L173:
	lis 9,.LC58@ha
	lfd 0,.LC58@l(9)
	fcmpu 0,12,0
	bc 4,0,.L175
	addi 29,1,520
	lis 4,.LC59@ha
	la 4,.LC59@l(4)
	b .L212
.L175:
	lis 9,.LC60@ha
	lfd 0,.LC60@l(9)
	fcmpu 0,12,0
	bc 4,0,.L177
	addi 29,1,520
	lis 4,.LC61@ha
	la 4,.LC61@l(4)
	b .L212
.L177:
	lis 9,.LC62@ha
	lfd 0,.LC62@l(9)
	fcmpu 0,12,0
	bc 4,0,.L179
	addi 29,1,520
	lis 4,.LC63@ha
	la 4,.LC63@l(4)
	b .L212
.L179:
	lis 9,.LC93@ha
	la 9,.LC93@l(9)
	lfd 0,0(9)
	fcmpu 0,12,0
	bc 4,0,.L181
	addi 29,1,520
	lis 4,.LC64@ha
	la 4,.LC64@l(4)
	b .L212
.L181:
	lis 9,.LC65@ha
	lfd 0,.LC65@l(9)
	fcmpu 0,12,0
	bc 4,0,.L183
	addi 29,1,520
	lis 4,.LC66@ha
	la 4,.LC66@l(4)
	b .L212
.L183:
	lis 9,.LC67@ha
	lfd 0,.LC67@l(9)
	fcmpu 0,12,0
	bc 4,0,.L185
	addi 29,1,520
	lis 4,.LC68@ha
	la 4,.LC68@l(4)
	b .L212
.L185:
	lis 9,.LC69@ha
	lfd 0,.LC69@l(9)
	fcmpu 0,12,0
	bc 4,0,.L187
	addi 29,1,520
	lis 4,.LC70@ha
	la 4,.LC70@l(4)
	b .L212
.L187:
	lis 9,.LC71@ha
	lfd 0,.LC71@l(9)
	fcmpu 0,12,0
	bc 4,0,.L189
	addi 29,1,520
	lis 4,.LC72@ha
	la 4,.LC72@l(4)
	b .L212
.L189:
	lis 9,.LC94@ha
	fmr 13,11
	la 9,.LC94@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L191
	addi 29,1,520
	lis 4,.LC73@ha
	la 4,.LC73@l(4)
	b .L212
.L191:
	lis 9,.LC74@ha
	lfd 0,.LC74@l(9)
	fcmpu 0,13,0
	bc 4,0,.L193
	addi 29,1,520
	lis 4,.LC75@ha
	la 4,.LC75@l(4)
	b .L212
.L193:
	lis 9,.LC76@ha
	lfd 0,.LC76@l(9)
	fcmpu 0,13,0
	bc 4,0,.L195
	addi 29,1,520
	lis 4,.LC77@ha
	la 4,.LC77@l(4)
	b .L212
.L195:
	lis 9,.LC78@ha
	lfd 0,.LC78@l(9)
	fcmpu 0,13,0
	bc 4,0,.L197
	addi 29,1,520
	lis 4,.LC79@ha
	la 4,.LC79@l(4)
	b .L212
.L197:
	lis 9,.LC80@ha
	lfd 0,.LC80@l(9)
	fcmpu 0,13,0
	bc 4,0,.L199
	addi 29,1,520
	lis 4,.LC81@ha
	la 4,.LC81@l(4)
	b .L212
.L199:
	lis 9,.LC95@ha
	la 9,.LC95@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L201
	addi 29,1,520
	lis 4,.LC82@ha
	la 4,.LC82@l(4)
	b .L212
.L201:
	lis 9,.LC83@ha
	lfd 0,.LC83@l(9)
	fcmpu 0,13,0
	bc 4,0,.L203
	addi 29,1,520
	lis 4,.LC84@ha
	la 4,.LC84@l(4)
	b .L212
.L203:
	lis 9,.LC85@ha
	lfd 0,.LC85@l(9)
	fcmpu 0,13,0
	bc 4,0,.L205
	addi 29,1,520
	lis 4,.LC86@ha
	la 4,.LC86@l(4)
	b .L212
.L205:
	lis 9,.LC87@ha
	lfd 0,.LC87@l(9)
	fcmpu 0,13,0
	bc 4,0,.L207
	addi 29,1,520
	lis 4,.LC88@ha
	la 4,.LC88@l(4)
	b .L212
.L207:
	lis 9,.LC89@ha
	lfd 0,.LC89@l(9)
	fcmpu 0,13,0
	bc 4,0,.L209
	addi 29,1,520
	lis 4,.LC90@ha
	la 4,.LC90@l(4)
	b .L212
.L209:
	addi 29,1,520
	lis 4,.LC91@ha
	la 4,.LC91@l(4)
.L212:
	mr 3,29
	crxor 6,6,6
	bl sprintf
	mr 31,29
	b .L211
.L172:
	addi 0,1,520
	mr 4,31
	mr 3,0
	mr 31,0
	bl strcpy
.L211:
	addi 29,1,8
	li 4,0
	li 5,512
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 4,.LC12@ha
	mr 5,28
	la 4,.LC12@l(4)
	mr 3,29
	bl Info_SetValueForKey
	lis 4,.LC2@ha
	mr 5,31
	la 4,.LC2@l(4)
	mr 3,29
	bl Info_SetValueForKey
	lis 4,.LC13@ha
	lis 5,.LC14@ha
	la 4,.LC13@l(4)
	la 5,.LC14@l(5)
	mr 3,29
	bl Info_SetValueForKey
	lis 4,.LC15@ha
	lis 5,.LC16@ha
	la 4,.LC15@l(4)
	mr 3,29
	la 5,.LC16@l(5)
	bl Info_SetValueForKey
	mr 3,30
	mr 4,29
	bl ClientConnect
	lwz 0,1572(1)
	mtlr 0
	lmw 28,1552(1)
	la 1,1568(1)
	blr
.Lfe5:
	.size	 ACESP_SetName,.Lfe5-ACESP_SetName
	.globl LocalTeamNames
	.section	".data"
	.align 2
	.type	 LocalTeamNames,@object
	.size	 LocalTeamNames,12
LocalTeamNames:
	.long .LC15
	.long .LC96
	.long .LC14
	.section	".rodata"
	.align 2
.LC96:
	.string	"1"
	.align 2
.LC97:
	.string	"Assigned to team 1\n"
	.align 2
.LC98:
	.string	"Assigned to team 2\n"
	.align 2
.LC99:
	.long 0x46fffe00
	.align 3
.LC100:
	.long 0x3fd51eb8
	.long 0x51eb851f
	.align 2
.LC101:
	.long 0x0
	.align 2
.LC102:
	.long 0x3f800000
	.align 3
.LC103:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ACESP_SpawnBot
	.type	 ACESP_SpawnBot,@function
ACESP_SpawnBot:
	stwu 1,-464(1)
	mflr 0
	stfd 31,456(1)
	stmw 24,424(1)
	stw 0,468(1)
	lis 9,maxclients@ha
	lwz 11,maxclients@l(9)
	mr 31,3
	mr 30,4
	mr 4,6
	li 3,0
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,416(1)
	lwz 8,420(1)
	cmpwi 0,8,0
	bc 4,1,.L219
	mulli 11,8,996
	lis 9,g_edicts@ha
	lwz 10,g_edicts@l(9)
	addi 0,11,996
	addi 11,11,1528
	add 7,0,10
	add 11,11,10
.L216:
	lwz 9,0(11)
	addic. 8,8,-1
	mr 12,7
	addi 11,11,-996
	addi 7,12,-996
	cmpw 7,9,3
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,3,0
	or 3,0,9
	bc 12,1,.L216
.L219:
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	addi 3,3,1
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,416(1)
	lwz 8,420(1)
	cmpwi 0,8,0
	bc 4,1,.L225
	lis 9,g_edicts@ha
	mulli 10,8,996
	lwz 7,g_edicts@l(9)
	add 11,7,10
	addi 12,11,996
	lwz 0,88(12)
	cmpwi 0,0,0
	bc 12,2,.L225
	addi 0,10,996
	addi 9,10,1084
	add 11,0,7
	add 9,9,7
.L223:
	addic. 8,8,-1
	addi 11,11,-996
	bc 4,1,.L225
	lwzu 0,-996(9)
	mr 12,11
	cmpwi 0,0,0
	bc 4,2,.L223
.L225:
	lwz 0,88(12)
	stw 3,532(12)
	addic 0,0,-1
	subfe 0,0,0
	and. 29,12,0
	bc 4,2,.L228
	lis 4,.LC11@ha
	li 3,1
	la 4,.LC11@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L213
.L228:
	cmpwi 0,4,0
	li 9,1
	lis 0,0x42c8
	stw 9,904(29)
	stw 0,420(29)
	stw 9,88(29)
	bc 4,2,.L229
	mr 4,30
	mr 3,29
	mr 6,31
	bl ACESP_SetName
	b .L230
.L229:
	mr 3,29
	bl ClientConnect
.L230:
	lis 4,.LC101@ha
	mr 3,29
	la 4,.LC101@l(4)
	lis 24,teamplay@ha
	lfs 31,0(4)
	bl G_InitEdict
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L231
	cmpwi 0,31,0
	bc 12,2,.L233
	mr 3,31
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L231
.L233:
	lwz 9,teamplay@l(24)
	li 6,0
	li 8,0
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 4,2,.L235
	li 0,0
	b .L236
.L235:
	lis 9,maxclients@ha
	lis 4,.LC102@ha
	lwz 11,maxclients@l(9)
	la 4,.LC102@l(4)
	li 7,1
	lfs 13,0(4)
	lfs 0,20(11)
	fadds 0,0,13
	fcmpu 0,13,0
	bc 4,0,.L245
	lis 9,g_edicts@ha
	fmr 12,0
	lis 5,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC103@ha
	la 9,.LC103@l(9)
	addi 10,11,996
	lfd 13,0(9)
.L239:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L244
	lwz 9,84(10)
	lwz 11,3488(9)
	cmpwi 0,11,1
	bc 4,2,.L241
	addi 6,6,1
	b .L244
.L241:
	xori 11,11,2
	addi 9,8,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L244:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,996
	stw 0,420(1)
	stw 5,416(1)
	lfd 0,416(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L239
.L245:
	cmpw 0,6,8
	li 0,1
	bc 4,1,.L246
	li 0,2
.L246:
.L236:
	cmpwi 0,0,1
	bc 4,2,.L234
	lis 9,gi@ha
	lis 4,.LC97@ha
	lwz 0,gi@l(9)
	la 4,.LC97@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,LocalTeamNames+4@ha
	lwz 31,LocalTeamNames+4@l(9)
	b .L231
.L234:
	lis 9,gi@ha
	lis 4,.LC98@ha
	lwz 0,gi@l(9)
	la 4,.LC98@l(4)
	li 3,2
	lis 9,LocalTeamNames+8@ha
	mtlr 0
	lwz 31,LocalTeamNames+8@l(9)
	crxor 6,6,6
	blrl
.L231:
	lwz 3,84(29)
	bl InitClientResp
	lis 9,teamplay@ha
	li 0,0
	lwz 11,teamplay@l(9)
	lis 4,.LC101@ha
	la 4,.LC101@l(4)
	stw 0,988(29)
	stw 0,984(29)
	lfs 13,0(4)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L250
	cmpwi 0,31,0
	bc 12,2,.L251
	lis 4,.LC96@ha
	mr 3,31
	la 4,.LC96@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L251
	mr 3,29
	li 4,1
	li 5,1
	bl ACESP_PutClientInServer
	b .L253
.L251:
	mr 3,29
	li 4,1
	li 5,2
	bl ACESP_PutClientInServer
	b .L253
.L250:
	mr 3,29
	li 4,1
	li 5,0
	bl ACESP_PutClientInServer
.L253:
	mr 3,29
	bl ClientEndServerFrame
	mr 3,29
	bl ACEIT_PlayerAdded
	mr 3,29
	bl ACEAI_PickLongRangeGoal
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,420(1)
	lis 4,.LC103@ha
	lis 10,.LC99@ha
	la 4,.LC103@l(4)
	stw 0,416(1)
	lis 11,.LC100@ha
	lfd 13,0(4)
	lfd 0,416(1)
	lfs 11,.LC99@l(10)
	lfd 12,.LC100@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L213
	lis 9,num_players@ha
	li 28,0
	lwz 0,num_players@l(9)
	li 27,0
	lis 25,num_players@ha
	cmpw 0,28,0
	bc 12,1,.L256
	lis 11,.LC101@ha
	lis 9,players@ha
	la 11,.LC101@l(11)
	la 26,players@l(9)
	lfs 31,0(11)
	li 30,0
	addi 31,1,8
.L258:
	lwzx 4,30,26
	cmpwi 0,4,0
	bc 12,2,.L257
	cmpw 0,4,29
	bc 12,2,.L257
	lwz 0,248(4)
	cmpwi 0,0,0
	bc 12,2,.L257
	lwz 9,teamplay@l(24)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L261
	mr 3,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 4,2,.L257
.L261:
	lwzx 0,30,26
	addi 28,28,1
	stw 0,0(31)
	addi 31,31,4
.L257:
	lwz 0,num_players@l(25)
	addi 27,27,1
	addi 30,30,4
	cmpw 0,27,0
	bc 4,1,.L258
.L256:
	cmpwi 0,28,0
	bc 4,1,.L213
	lis 11,ltk_chat@ha
	lis 4,.LC101@ha
	lwz 9,ltk_chat@l(11)
	la 4,.LC101@l(4)
	lfs 13,0(4)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L213
	bl rand
	mr 0,3
	addi 11,1,8
	divw 9,0,28
	mr 3,29
	li 5,0
	mullw 9,9,28
	subf 0,9,0
	slwi 0,0,2
	lwzx 4,11,0
	bl LTK_Chat
.L213:
	lwz 0,468(1)
	mtlr 0
	lmw 24,424(1)
	lfd 31,456(1)
	la 1,464(1)
	blr
.Lfe6:
	.size	 ACESP_SpawnBot,.Lfe6-ACESP_SpawnBot
	.section	".rodata"
	.align 2
.LC104:
	.string	"all"
	.align 2
.LC105:
	.string	"%s not found\n"
	.globl names1
	.section	".data"
	.align 2
	.type	 names1,@object
	.size	 names1,40
names1:
	.long .LC106
	.long .LC107
	.long .LC108
	.long .LC109
	.long .LC110
	.long .LC111
	.long .LC112
	.long .LC113
	.long .LC114
	.long .LC115
	.section	".rodata"
	.align 2
.LC115:
	.string	"Red"
	.align 2
.LC114:
	.string	"Angel"
	.align 2
.LC113:
	.string	"Hard"
	.align 2
.LC112:
	.string	"kw1k"
	.align 2
.LC111:
	.string	"l3thal"
	.align 2
.LC110:
	.string	"mAx"
	.align 2
.LC109:
	.string	"Fasst"
	.align 2
.LC108:
	.string	"L33t"
	.align 2
.LC107:
	.string	"d3th"
	.align 2
.LC106:
	.string	"Bad"
	.globl names2
	.section	".data"
	.align 2
	.type	 names2,@object
	.size	 names2,40
names2:
	.long .LC116
	.long .LC117
	.long .LC118
	.long .LC119
	.long .LC120
	.long .LC121
	.long .LC122
	.long .LC123
	.long .LC124
	.long .LC125
	.section	".rodata"
	.align 2
.LC125:
	.string	"akimbo"
	.align 2
.LC124:
	.string	"frags"
	.align 2
.LC123:
	.string	"joos"
	.align 2
.LC122:
	.string	"sodja"
	.align 2
.LC121:
	.string	"dog"
	.align 2
.LC120:
	.string	"killa"
	.align 2
.LC119:
	.string	"d00d"
	.align 2
.LC118:
	.string	"wakko"
	.align 2
.LC117:
	.string	"eevil"
	.align 2
.LC116:
	.string	"Moon"
	.globl names3
	.section	".data"
	.align 2
	.type	 names3,@object
	.size	 names3,40
names3:
	.long .LC126
	.long .LC127
	.long .LC128
	.long .LC129
	.long .LC130
	.long .LC131
	.long .LC132
	.long .LC133
	.long .LC134
	.long .LC135
	.section	".rodata"
	.align 2
.LC135:
	.string	"Per"
	.align 2
.LC134:
	.string	"Mal"
	.align 2
.LC133:
	.string	"Lin"
	.align 2
.LC132:
	.string	"Hal"
	.align 2
.LC131:
	.string	"Gil"
	.align 2
.LC130:
	.string	"Fan"
	.align 2
.LC129:
	.string	"Cor"
	.align 2
.LC128:
	.string	"Calen"
	.align 2
.LC127:
	.string	"Bal"
	.align 2
.LC126:
	.string	"An"
	.globl names4
	.section	".data"
	.align 2
	.type	 names4,@object
	.size	 names4,40
names4:
	.long .LC136
	.long .LC137
	.long .LC138
	.long .LC139
	.long .LC140
	.long .LC141
	.long .LC142
	.long .LC143
	.long .LC144
	.long .LC145
	.section	".rodata"
	.align 2
.LC145:
	.string	"riel"
	.align 2
.LC144:
	.string	"orch"
	.align 2
.LC143:
	.string	"loss"
	.align 2
.LC142:
	.string	"iel"
	.align 2
.LC141:
	.string	"galad"
	.align 2
.LC140:
	.string	"fing"
	.align 2
.LC139:
	.string	"dor"
	.align 2
.LC138:
	.string	"born"
	.align 2
.LC137:
	.string	"rog"
	.align 2
.LC136:
	.string	"adan"
	.align 2
.LC146:
	.long 0x46fffe00
	.align 3
.LC147:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC148:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl LTKsetBotName
	.type	 LTKsetBotName,@function
LTKsetBotName:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 9,nameused@ha
	lis 30,0x6666
	la 27,nameused@l(9)
	mr 28,3
	ori 30,30,26215
.L279:
	bl rand
	mulhw 0,3,30
	srawi 11,3,31
	srawi 0,0,2
	subf 31,11,0
	mulli 9,31,10
	subf 31,9,3
	bl rand
	mulhw 0,3,30
	srawi 11,3,31
	mulli 10,31,40
	srawi 0,0,2
	subf 0,11,0
	mulli 9,0,10
	subf 0,9,3
	slwi 29,0,2
	add 11,29,10
	lwzx 0,27,11
	cmpwi 0,0,0
	bc 4,2,.L279
	lis 9,nameused@ha
	li 0,1
	la 9,nameused@l(9)
	mr 30,29
	stwx 0,9,11
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC147@ha
	lis 11,.LC146@ha
	la 10,.LC147@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC148@ha
	lfs 12,.LC146@l(11)
	la 10,.LC148@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L280
	lis 9,names1@ha
	slwi 0,31,2
	la 9,names1@l(9)
	mr 3,28
	lwzx 4,9,0
	bl strcpy
	lis 9,names2@ha
	mr 3,28
	la 9,names2@l(9)
	lwzx 4,9,30
	bl strcat
	b .L281
.L280:
	lis 9,names3@ha
	slwi 0,31,2
	la 9,names3@l(9)
	mr 3,28
	lwzx 4,9,0
	bl strcpy
	lis 9,names4@ha
	mr 3,28
	la 9,names4@l(9)
	lwzx 4,9,29
	bl strcat
.L281:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 LTKsetBotName,.Lfe7-LTKsetBotName
	.section	".rodata"
	.align 3
.LC149:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl ACESP_HoldSpawn
	.type	 ACESP_HoldSpawn,@function
ACESP_HoldSpawn:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	bl KillBox
	lis 29,gi@ha
	mr 3,28
	la 29,gi@l(29)
	lwz 9,72(29)
	mtlr 9
	blrl
	lis 9,ACEAI_Think@ha
	lis 10,level+4@ha
	la 9,ACEAI_Think@l(9)
	lis 11,.LC149@ha
	stw 9,436(28)
	li 3,1
	lfs 0,level+4@l(10)
	lfd 13,.LC149@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(28)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xe64
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49481
	mtlr 10
	subf 3,3,28
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 0,88(29)
	li 4,2
	addi 3,28,4
	mtlr 0
	blrl
	lwz 5,84(28)
	lis 4,.LC23@ha
	li 3,1
	la 4,.LC23@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 ACESP_HoldSpawn,.Lfe8-ACESP_HoldSpawn
	.align 2
	.globl ACESP_FindFreeClient
	.type	 ACESP_FindFreeClient,@function
ACESP_FindFreeClient:
	stwu 1,-16(1)
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	li 5,0
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 8,12(1)
	cmpwi 0,8,0
	bc 4,1,.L157
	mulli 11,8,996
	lis 9,g_edicts@ha
	lwz 10,g_edicts@l(9)
	addi 0,11,996
	addi 11,11,1528
	add 7,0,10
	add 11,11,10
.L159:
	lwz 9,0(11)
	addic. 8,8,-1
	mr 6,7
	addi 11,11,-996
	addi 7,6,-996
	cmpw 7,9,5
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,5,0
	or 5,0,9
	bc 12,1,.L159
.L157:
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	addi 5,5,1
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 8,12(1)
	cmpwi 0,8,0
	bc 4,1,.L163
	lis 9,g_edicts@ha
	mulli 10,8,996
	lwz 7,g_edicts@l(9)
	add 11,7,10
	addi 6,11,996
	lwz 0,88(6)
	cmpwi 0,0,0
	bc 12,2,.L163
	addi 0,10,996
	addi 9,10,1084
	add 11,0,7
	add 9,9,7
.L164:
	addic. 8,8,-1
	addi 11,11,-996
	bc 4,1,.L163
	lwzu 0,-996(9)
	mr 6,11
	cmpwi 0,0,0
	bc 4,2,.L164
.L163:
	lwz 3,88(6)
	stw 5,532(6)
	addic 3,3,-1
	subfe 3,3,3
	and 3,6,3
	la 1,16(1)
	blr
.Lfe9:
	.size	 ACESP_FindFreeClient,.Lfe9-ACESP_FindFreeClient
	.section	".rodata"
	.align 2
.LC150:
	.long 0x0
	.align 3
.LC151:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ACESP_RemoveBot
	.type	 ACESP_RemoveBot,@function
ACESP_RemoveBot:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 21,28(1)
	stw 0,84(1)
	lis 11,.LC150@ha
	lis 9,maxclients@ha
	la 11,.LC150@l(11)
	mr 30,3
	lfs 13,0(11)
	li 27,0
	li 28,0
	lwz 11,maxclients@l(9)
	lis 21,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L267
	lis 9,.LC151@ha
	lis 22,g_edicts@ha
	la 9,.LC151@l(9)
	lis 23,.LC104@ha
	lfd 31,0(9)
	li 24,0
	lis 25,vec3_origin@ha
	lis 26,0x4330
	li 29,0
.L269:
	lwz 9,g_edicts@l(22)
	add 9,9,29
	addi 31,9,996
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L268
	lwz 0,904(31)
	cmpwi 0,0,0
	bc 12,2,.L268
	lwz 3,84(31)
	mr 4,30
	addi 3,3,700
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L272
	mr 3,30
	la 4,.LC104@l(23)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L268
.L272:
	lis 6,0x1
	mr 3,31
	stw 24,480(31)
	mr 4,31
	mr 5,31
	ori 6,6,34464
	la 7,vec3_origin@l(25)
	bl player_die
	li 27,1
	mr 3,31
	bl ClientDisconnect
.L268:
	addi 28,28,1
	lwz 11,maxclients@l(21)
	xoris 0,28,0x8000
	addi 29,29,996
	stw 0,20(1)
	stw 26,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L269
.L267:
	cmpwi 0,27,0
	bc 4,2,.L274
	lis 4,.LC105@ha
	mr 5,30
	la 4,.LC105@l(4)
	li 3,1
	crxor 6,6,6
	bl safe_bprintf
.L274:
	lwz 0,84(1)
	mtlr 0
	lmw 21,28(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe10:
	.size	 ACESP_RemoveBot,.Lfe10-ACESP_RemoveBot
	.section	".rodata"
	.align 2
.LC152:
	.long 0x0
	.align 2
.LC153:
	.long 0x3f800000
	.align 3
.LC154:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl GetNextTeamNumber
	.type	 GetNextTeamNumber,@function
GetNextTeamNumber:
	stwu 1,-16(1)
	lis 9,teamplay@ha
	lis 4,.LC152@ha
	lwz 11,teamplay@l(9)
	la 4,.LC152@l(4)
	li 6,0
	lfs 13,0(4)
	li 8,0
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L7
	li 3,0
	b .L282
.L7:
	lis 11,.LC153@ha
	lis 9,maxclients@ha
	la 11,.LC153@l(11)
	li 7,1
	lfs 13,0(11)
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fadds 0,0,13
	fcmpu 0,13,0
	bc 4,0,.L9
	lis 4,.LC154@ha
	lis 9,g_edicts@ha
	fmr 12,0
	la 4,.LC154@l(4)
	lwz 11,g_edicts@l(9)
	lis 5,0x4330
	lfd 13,0(4)
	addi 10,11,996
.L11:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L10
	lwz 9,84(10)
	lwz 11,3488(9)
	cmpwi 0,11,1
	bc 4,2,.L13
	addi 6,6,1
	b .L10
.L13:
	xori 11,11,2
	addi 9,8,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L10:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,996
	stw 0,12(1)
	stw 5,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L11
.L9:
	cmpw 0,6,8
	li 3,2
	bc 12,1,.L17
	li 3,1
.L17:
.L282:
	la 1,16(1)
	blr
.Lfe11:
	.size	 GetNextTeamNumber,.Lfe11-GetNextTeamNumber
	.align 2
	.globl ACESP_JoinTeam
	.type	 ACESP_JoinTeam,@function
ACESP_JoinTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 9,84(31)
	lwz 0,3488(9)
	cmpw 0,0,30
	bc 12,2,.L20
	cmpwi 0,0,0
	bc 4,2,.L22
	lis 9,.LC0@ha
	la 28,.LC0@l(9)
	b .L23
.L22:
	lis 9,.LC1@ha
	la 28,.LC1@l(9)
.L23:
	lwz 9,84(31)
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	stw 30,3488(9)
	lwz 3,84(31)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl AssignSkin
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L24
	li 0,0
	lis 6,0x1
	lis 7,vec3_origin@ha
	stw 0,480(31)
	mr 3,31
	la 7,vec3_origin@l(7)
	mr 4,31
	mr 5,31
	ori 6,6,34464
	bl player_die
	li 0,2
	stw 0,492(31)
.L24:
	lwz 29,84(31)
	mr 3,30
	addi 29,29,700
	bl TeamName
	mr 7,3
	lis 4,.LC3@ha
	la 4,.LC3@l(4)
	mr 5,29
	mr 6,28
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
	lis 9,level@ha
	lwz 11,84(31)
	lwz 0,level@l(9)
	stw 0,3492(11)
	bl CheckForUnevenTeams
.L20:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 ACESP_JoinTeam,.Lfe12-ACESP_JoinTeam
	.comm	nameused,400,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
