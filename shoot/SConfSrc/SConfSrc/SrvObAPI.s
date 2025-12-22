	.file	"SrvObAPI.c"
gcc2_compiled.:
	.section	".text"
	.align 2
	.globl ConvertMeansOfDeath
	.type	 ConvertMeansOfDeath,@function
ConvertMeansOfDeath:
	mr. 3,3
	bc 4,2,.L15
	li 3,0
	blr
.L15:
	cmpwi 0,3,1
	bc 4,2,.L17
	li 3,2
	blr
.L17:
	cmpwi 0,3,2
	bc 4,2,.L19
	li 3,3
	blr
.L19:
	cmpwi 0,3,3
	bc 4,2,.L21
	li 3,4
	blr
.L21:
	cmpwi 0,3,4
	bc 4,2,.L23
	li 3,5
	blr
.L23:
	cmpwi 0,3,5
	bc 4,2,.L25
	li 3,6
	blr
.L25:
	cmpwi 0,3,6
	bc 4,2,.L27
	li 3,7
	blr
.L27:
	cmpwi 0,3,7
	bc 4,2,.L29
	li 3,8
	blr
.L29:
	cmpwi 0,3,8
	bc 4,2,.L31
	li 3,12
	blr
.L31:
	cmpwi 0,3,9
	bc 4,2,.L33
	li 3,13
	blr
.L33:
	cmpwi 0,3,10
	bc 4,2,.L35
	li 3,14
	blr
.L35:
	cmpwi 0,3,11
	bc 4,2,.L37
	li 3,15
	blr
.L37:
	cmpwi 0,3,12
	bc 4,2,.L39
	li 3,16
	blr
.L39:
	cmpwi 0,3,13
	bc 4,2,.L41
	li 3,18
	blr
.L41:
	cmpwi 0,3,14
	bc 4,2,.L43
	li 3,17
	blr
.L43:
	cmpwi 0,3,15
	bc 4,2,.L45
	li 3,9
	blr
.L45:
	cmpwi 0,3,16
	bc 4,2,.L47
	li 3,10
	blr
.L47:
	cmpwi 0,3,17
	bc 4,2,.L49
	li 3,53
	blr
.L49:
	cmpwi 0,3,18
	bc 4,2,.L51
	li 3,52
	blr
.L51:
	cmpwi 0,3,19
	bc 4,2,.L53
	li 3,51
	blr
.L53:
	cmpwi 0,3,20
	bc 4,2,.L55
	li 3,55
	blr
.L55:
	cmpwi 0,3,21
	bc 4,2,.L57
	li 3,19
	blr
.L57:
	cmpwi 0,3,22
	bc 4,2,.L59
	li 3,54
	blr
.L59:
	cmpwi 0,3,23
	bc 4,2,.L61
	li 3,21
	blr
.L61:
	cmpwi 0,3,24
	bc 4,2,.L63
	li 3,11
	blr
.L63:
	cmpwi 0,3,25
	bc 4,2,.L65
.L84:
	li 3,56
	blr
.L65:
	cmpwi 0,3,26
	bc 12,2,.L84
	cmpwi 0,3,27
	bc 12,2,.L84
	cmpwi 0,3,28
	bc 4,2,.L71
	li 3,57
	blr
.L71:
	cmpwi 0,3,29
	bc 12,2,.L84
	cmpwi 0,3,30
	bc 4,2,.L75
	li 3,58
	blr
.L75:
	cmpwi 0,3,31
	bc 12,2,.L84
	cmpwi 0,3,32
	bc 12,2,.L79
	xori 3,3,33
	addic 3,3,-1
	subfe 3,3,3
	rlwinm 3,3,0,26,28
	blr
.L79:
	li 3,56
	blr
.Lfe1:
	.size	 ConvertMeansOfDeath,.Lfe1-ConvertMeansOfDeath
	.section	".rodata"
	.align 2
.LC0:
	.string	""
	.align 2
.LC1:
	.long 0x0
	.align 3
.LC2:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ServObitClientObituary
	.type	 ServObitClientObituary,@function
ServObitClientObituary:
	stwu 1,-64(1)
	mflr 0
	stmw 23,28(1)
	stw 0,68(1)
	lis 11,.LC1@ha
	lis 9,deathmatch@ha
	la 11,.LC1@l(11)
	mr 30,3
	lfs 13,0(11)
	mr 31,5
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L99
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L128
.L99:
	lis 11,.LC1@ha
	lis 9,coop@ha
	la 11,.LC1@l(11)
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lis 9,meansOfDeath@ha
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L100
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L100
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L100:
	lis 9,meansOfDeath@ha
	lwz 11,84(30)
	mr 3,30
	lwz 0,meansOfDeath@l(9)
	addi 26,11,700
	rlwinm 23,0,0,4,4
	bl GetPlayerGender
	lis 9,ServObit+48@ha
	lwz 11,480(30)
	mr 27,3
	lwz 0,ServObit+48@l(9)
	cmpw 0,11,0
	bc 4,0,.L101
	li 24,3
	b .L102
.L101:
	cmpwi 7,11,-41
	mfcr 0
	rlwinm 0,0,30,1
	neg 0,0
	nor 9,0,0
	rlwinm 0,0,0,31,31
	rlwinm 9,9,0,30,30
	or 24,0,9
.L102:
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	rlwinm. 10,0,0,5,3
	bc 12,0,.L139
	lis 9,ServObit@ha
	lwz 0,ServObit@l(9)
	la 11,ServObit@l(9)
	cmpw 0,10,0
	bc 4,1,.L110
.L139:
	li 25,0
	b .L108
.L110:
	lwz 11,4(11)
	slwi 9,10,2
	lwzx 25,9,11
.L108:
	cmpwi 0,25,0
	li 3,0
	bc 12,2,.L138
	mr 3,25
	bl IsEnvironmentWeapon
	cmpwi 0,3,0
	bc 12,2,.L113
	lis 11,level@ha
	lwz 10,84(30)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC2@ha
	lfs 12,3728(10)
	xoris 0,0,0x8000
	la 11,.LC2@l(11)
	stw 0,20(1)
	stw 8,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	li 11,0
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L115
	li 11,1
.L115:
	addic 9,11,-1
	subfe 9,9,9
	mr 6,27
	rlwinm 9,9,0,30,31
	lis 4,.LC0@ha
	ori 9,9,2
	mr 10,24
	mr 3,26
	la 4,.LC0@l(4)
	mr 8,25
	li 5,4
	mr 7,6
	bl DisplayObituary
	lwz 10,84(30)
	lis 11,QWLOG@ha
	lwz 0,QWLOG@l(11)
	lwz 9,3424(10)
	cmpwi 0,0,1
	addi 9,9,-1
	stw 9,3424(10)
	bc 4,2,.L136
	lwz 3,84(30)
	addi 3,3,700
	mr 4,3
	b .L141
.L113:
	cmpw 0,31,30
	bc 4,2,.L120
	lis 11,level@ha
	lwz 10,84(30)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC2@ha
	lfs 12,3728(10)
	xoris 0,0,0x8000
	la 11,.LC2@l(11)
	stw 0,20(1)
	stw 8,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	li 11,0
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L122
	li 11,1
.L122:
	addic 9,11,-1
	subfe 9,9,9
	mr 3,26
	mr 6,27
	rlwinm 9,9,0,30,31
	ori 9,9,2
	mr 8,25
	mr 10,24
	mr 4,3
	li 5,2
	mr 7,6
	bl DisplayObituary
	lis 9,.LC1@ha
	lis 11,deathmatch@ha
	la 9,.LC1@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L126
	lwz 10,84(30)
	lis 11,QWLOG@ha
	lwz 0,QWLOG@l(11)
	lwz 9,3424(10)
	cmpwi 0,0,1
	addi 9,9,-1
	stw 9,3424(10)
	bc 4,2,.L126
	lwz 3,84(30)
	addi 3,3,700
	mr 4,3
	bl logFrag
.L126:
	li 0,0
	li 3,1
	stw 0,540(30)
	b .L138
.L120:
	cmpwi 0,31,0
	stw 31,540(30)
	bc 12,2,.L128
	lwz 4,84(31)
	cmpwi 0,4,0
	bc 12,2,.L128
	lis 11,level@ha
	lfs 12,3728(4)
	lwz 0,level@l(11)
	lis 10,0x4330
	addi 28,4,700
	lis 11,.LC2@ha
	xoris 0,0,0x8000
	la 11,.LC2@l(11)
	stw 0,20(1)
	stw 10,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	li 11,0
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L130
	li 11,1
.L130:
	addic 29,11,-1
	subfe 29,29,29
	mr 3,31
	rlwinm 29,29,0,30,31
	ori 29,29,2
	bl GetPlayerGender
	mr 6,3
	mr 4,28
	mr 3,26
	mr 7,27
	mr 8,25
	mr 9,29
	mr 10,24
	li 5,3
	bl DisplayObituary
	cmpwi 0,23,0
	bc 12,2,.L134
	lwz 10,84(31)
	lis 11,QWLOG@ha
	lwz 0,QWLOG@l(11)
	lwz 9,3424(10)
	cmpwi 0,0,1
	addi 9,9,-1
	stw 9,3424(10)
	bc 4,2,.L136
	lwz 3,84(31)
	lwz 4,84(30)
	addi 3,3,700
	addi 4,4,700
	bl logFrag
	b .L136
.L134:
	lwz 10,84(31)
	lis 11,QWLOG@ha
	lwz 0,QWLOG@l(11)
	lwz 9,3424(10)
	cmpwi 0,0,1
	addi 9,9,1
	stw 9,3424(10)
	bc 4,2,.L136
	lwz 3,84(31)
	lwz 4,84(30)
	addi 3,3,700
	addi 4,4,700
.L141:
	bl logFrag
.L136:
	li 3,1
	b .L138
.L128:
	li 3,0
.L138:
	lwz 0,68(1)
	mtlr 0
	lmw 23,28(1)
	la 1,64(1)
	blr
.Lfe2:
	.size	 ServObitClientObituary,.Lfe2-ServObitClientObituary
	.section	".rodata"
	.align 2
.LC3:
	.string	"$N disconnected\n"
	.align 2
.LC4:
	.string	"%s\n"
	.comm	highscore,1080,4
	.comm	gamescore,540,4
	.section	".text"
	.align 2
	.globl ServObitInitGame
	.type	 ServObitInitGame,@function
ServObitInitGame:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	bl InitializeServObit
	lis 29,ServObit@ha
	li 30,0
	li 0,33
	li 3,136
	stw 0,ServObit@l(29)
	la 31,ServObit@l(29)
	bl malloc
	lwz 0,ServObit@l(29)
	stw 3,4(31)
	cmpw 0,30,0
	bc 4,0,.L162
	mr 28,31
	li 31,0
.L159:
	mr 3,30
	bl ConvertMeansOfDeath
	addi 30,30,1
	lwz 9,4(28)
	stwx 3,31,9
	lwz 0,ServObit@l(29)
	addi 31,31,4
	cmpw 0,30,0
	bc 12,0,.L159
.L162:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 ServObitInitGame,.Lfe3-ServObitInitGame
	.align 2
	.globl GetPlayerBodyState
	.type	 GetPlayerBodyState,@function
GetPlayerBodyState:
	lis 9,ServObit+48@ha
	lwz 11,480(3)
	lwz 0,ServObit+48@l(9)
	cmpw 0,11,0
	bc 12,0,.L7
	cmpwi 7,11,-40
	mfcr 3
	rlwinm 3,3,29,1
	neg 3,3
	addi 0,3,1
	rlwinm 3,3,0,30,30
	or 3,3,0
	blr
.L7:
	li 3,3
	blr
.Lfe4:
	.size	 GetPlayerBodyState,.Lfe4-GetPlayerBodyState
	.section	".rodata"
	.align 3
.LC5:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl PlayerHasQuadDamage
	.type	 PlayerHasQuadDamage,@function
PlayerHasQuadDamage:
	stwu 1,-16(1)
	lis 11,level@ha
	lwz 10,84(3)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC5@ha
	lfs 12,3728(10)
	xoris 0,0,0x8000
	la 11,.LC5@l(11)
	stw 0,12(1)
	stw 8,8(1)
	lfd 13,0(11)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 7,12,0
	mfcr 3
	rlwinm 3,3,30,1
	la 1,16(1)
	blr
.Lfe5:
	.size	 PlayerHasQuadDamage,.Lfe5-PlayerHasQuadDamage
	.align 2
	.globl ServObitPrintWelcome
	.type	 ServObitPrintWelcome,@function
ServObitPrintWelcome:
	blr
.Lfe6:
	.size	 ServObitPrintWelcome,.Lfe6-ServObitPrintWelcome
	.align 2
	.globl ServObitAnnounceConnect
	.type	 ServObitAnnounceConnect,@function
ServObitAnnounceConnect:
	blr
.Lfe7:
	.size	 ServObitAnnounceConnect,.Lfe7-ServObitAnnounceConnect
	.align 2
	.globl ServObitAnnounceDisconnect
	.type	 ServObitAnnounceDisconnect,@function
ServObitAnnounceDisconnect:
	stwu 1,-2080(1)
	mflr 0
	stmw 28,2064(1)
	stw 0,2084(1)
	lis 9,ServObit@ha
	mr 28,3
	la 29,ServObit@l(9)
	lwz 0,40(29)
	cmpwi 0,0,0
	bc 4,1,.L145
	bl rand
	lwz 11,40(29)
	mr 9,3
	lwz 10,32(29)
	addi 3,1,8
	divw 0,9,11
	mullw 0,0,11
	subf 9,0,9
	slwi 9,9,2
	lwzx 4,9,10
	bl strcpy
	b .L146
.L145:
	lis 9,.LC3@ha
	addi 11,1,8
	lwz 6,.LC3@l(9)
	la 9,.LC3@l(9)
	lbz 0,16(9)
	lwz 10,4(9)
	lwz 8,8(9)
	lwz 7,12(9)
	stw 6,8(1)
	stb 0,16(11)
	stw 10,4(11)
	stw 8,8(11)
	stw 7,12(11)
.L146:
	lwz 29,84(28)
	mr 3,28
	addi 28,1,1032
	addi 29,29,700
	bl GetPlayerGender
	mr 6,3
	mr 4,28
	mr 5,29
	addi 3,1,8
	bl FormatConnectMessage
	lis 9,gi@ha
	lis 4,.LC4@ha
	lwz 0,gi@l(9)
	la 4,.LC4@l(4)
	mr 5,28
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,2084(1)
	mtlr 0
	lmw 28,2064(1)
	la 1,2080(1)
	blr
.Lfe8:
	.size	 ServObitAnnounceDisconnect,.Lfe8-ServObitAnnounceDisconnect
	.align 2
	.globl StripMeansOfDeath
	.type	 StripMeansOfDeath,@function
StripMeansOfDeath:
	rlwinm 3,3,0,5,3
	blr
.Lfe9:
	.size	 StripMeansOfDeath,.Lfe9-StripMeansOfDeath
	.align 2
	.globl MeansOfDeathToServObitDeath
	.type	 MeansOfDeathToServObitDeath,@function
MeansOfDeathToServObitDeath:
	rlwinm. 3,3,0,5,3
	bc 4,0,.L88
	li 3,0
	blr
.L88:
	lis 9,ServObit@ha
	lwz 0,ServObit@l(9)
	la 11,ServObit@l(9)
	cmpw 0,3,0
	bc 12,1,.L90
	lwz 11,4(11)
	slwi 9,3,2
	lwzx 3,9,11
	blr
.L90:
	li 3,0
	blr
.Lfe10:
	.size	 MeansOfDeathToServObitDeath,.Lfe10-MeansOfDeathToServObitDeath
	.align 2
	.globl InitServObitMeansOfDeathMap
	.type	 InitServObitMeansOfDeathMap,@function
InitServObitMeansOfDeathMap:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 29,ServObit@ha
	li 0,33
	stw 0,ServObit@l(29)
	li 3,136
	li 31,0
	bl malloc
	la 30,ServObit@l(29)
	lwz 0,ServObit@l(29)
	stw 3,4(30)
	cmpw 0,31,0
	bc 4,0,.L94
	mr 28,30
	li 30,0
.L96:
	mr 3,31
	bl ConvertMeansOfDeath
	addi 31,31,1
	lwz 9,4(28)
	stwx 3,30,9
	lwz 0,ServObit@l(29)
	addi 30,30,4
	cmpw 0,31,0
	bc 12,0,.L96
.L94:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 InitServObitMeansOfDeathMap,.Lfe11-InitServObitMeansOfDeathMap
	.align 2
	.globl ServObit_Cmd_Help_f
	.type	 ServObit_Cmd_Help_f,@function
ServObit_Cmd_Help_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl GetTimedMessage
	cmpwi 0,3,0
	bc 12,2,.L148
	mr 3,31
	bl StopTimedMessage
	b .L149
.L148:
	mr 3,31
	bl Cmd_Help_f
.L149:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 ServObit_Cmd_Help_f,.Lfe12-ServObit_Cmd_Help_f
	.align 2
	.globl ServObit_Cmd_Score_f
	.type	 ServObit_Cmd_Score_f,@function
ServObit_Cmd_Score_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl GetTimedMessage
	cmpwi 0,3,0
	bc 12,2,.L151
	mr 3,31
	bl StopTimedMessage
	b .L152
.L151:
	mr 3,31
	bl Cmd_Score_f
.L152:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe13:
	.size	 ServObit_Cmd_Score_f,.Lfe13-ServObit_Cmd_Score_f
	.align 2
	.globl ServObit_Cmd_Inven_f
	.type	 ServObit_Cmd_Inven_f,@function
ServObit_Cmd_Inven_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl GetTimedMessage
	cmpwi 0,3,0
	bc 12,2,.L154
	mr 3,31
	bl StopTimedMessage
	b .L155
.L154:
	mr 3,31
	bl Cmd_Inven_f
.L155:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 ServObit_Cmd_Inven_f,.Lfe14-ServObit_Cmd_Inven_f
	.comm	configloc,50,4
	.comm	cycleloc,50,4
	.comm	scoreboard,4,4
	.comm	GlobalFragLimit,5,4
	.comm	GlobalTimeLimit,5,4
	.comm	GlobalGravity,5,4
	.comm	QWLOG,4,4
	.comm	directory,40,4
	.comm	recordLOG,2,4
	.comm	ModelGenDir,50,4
	.comm	obitsDir,50,4
	.comm	HIGHSCORE_DIR,50,4
	.comm	PLAYERS_LOGFILE,50,4
	.comm	MAX_CLIENT_RATE_STRING,10,4
	.comm	MAX_CLIENT_RATE,4,4
	.comm	clientlog,4,4
	.comm	showed,4,4
	.comm	rankhud,4,4
	.comm	playershud,4,4
	.comm	timehud,4,4
	.comm	cloakgrapple,4,4
	.comm	hookcolor,4,4
	.comm	allowgrapple,4,4
	.comm	HOOK_TIME,4,4
	.comm	HOOK_SPEED,4,4
	.comm	EXPERT_SKY_SOLID,4,4
	.comm	HOOK_DAMAGE,4,4
	.comm	PULL_SPEED,4,4
	.comm	LoseQ,4,4
	.comm	LoseQ_Fragee,4,4
	.comm	ConfigRD,4,4
	.comm	CRD,4,4
	.comm	rocketSpeed,4,4
	.comm	Q_Killer,4,4
	.comm	Q_Killee,4,4
	.comm	CF_StartHealth,4,4
	.comm	CF_MaxHealth,4,4
	.comm	MA_Bullets,4,4
	.comm	MA_Shells,4,4
	.comm	MA_Cells,4,4
	.comm	MA_Grenades,4,4
	.comm	MA_Rockets,4,4
	.comm	MA_Slugs,4,4
	.comm	SA_Bullets,4,4
	.comm	SA_Shells,4,4
	.comm	SA_Cells,4,4
	.comm	SA_Grenades,4,4
	.comm	SA_Rockets,4,4
	.comm	SA_Slugs,4,4
	.comm	SI_QuadDamage,4,4
	.comm	SI_Invulnerability,4,4
	.comm	SI_Silencer,4,4
	.comm	SI_Rebreather,4,4
	.comm	SI_EnvironmentSuit,4,4
	.comm	SI_PowerScreen,4,4
	.comm	SI_PowerShield,4,4
	.comm	QuadDamageTime,4,4
	.comm	RebreatherTime,4,4
	.comm	EnvironmentSuitTime,4,4
	.comm	InvulnerabilityTime,4,4
	.comm	SilencerShots,4,4
	.comm	RegenInvulnerability,4,4
	.comm	RegenInvulnerabilityTime,4,4
	.comm	AutoUseQuad,4,4
	.comm	AutoUseInvulnerability,4,4
	.comm	SW_Blaster,4,4
	.comm	SW_ShotGun,4,4
	.comm	SW_SuperShotGun,4,4
	.comm	SW_MachineGun,4,4
	.comm	SW_ChainGun,4,4
	.comm	SW_GrenadeLauncher,4,4
	.comm	SW_RocketLauncher,4,4
	.comm	SW_HyperBlaster,4,4
	.comm	SW_RailGun,4,4
	.comm	SW_BFG10K,4,4
	.comm	rocketspeed,4,4
	.comm	RadiusDamage,4,4
	.comm	DamageRadius,4,4
	.comm	GLauncherTimer,4,4
	.comm	GLauncherFireDistance,4,4
	.comm	GLauncherDamage,4,4
	.comm	GLauncherRadius,4,4
	.comm	GRENADE_TIMER,4,4
	.comm	GRENADE_MINSPEED,4,4
	.comm	GRENADE_MAXSPEED,4,4
	.comm	GrenadeTimer,4,4
	.comm	GrenadeMinSpeed,4,4
	.comm	GrenadeMaxSpeed,4,4
	.comm	GrenadeDamage,4,4
	.comm	GrenadeRadius,4,4
	.comm	HyperBlasterDamage,4,4
	.comm	BlasterProjectileSpeed,4,4
	.comm	BlasterDamage,4,4
	.comm	MachinegunDamage,4,4
	.comm	MachinegunKick,4,4
	.comm	ChaingunDamage,4,4
	.comm	ChaingunKick,4,4
	.comm	ShotgunDamage,4,4
	.comm	ShotgunKick,4,4
	.comm	SuperShotgunDamage,4,4
	.comm	SuperShotgunKick,4,4
	.comm	RailgunDamage,4,4
	.comm	RailgunKick,4,4
	.comm	BFGDamage,4,4
	.comm	BFGDamageRadius,4,4
	.comm	BFGProjectileSpeed,4,4
	.comm	namebanning,4,4
	.comm	bandirectory,50,4
	.comm	ingamenamebanningstate,4,4
	.comm	wasbot,4,4
	.comm	ban_BFG,4,4
	.comm	ban_hyperblaster,4,4
	.comm	ban_rocketlauncher,4,4
	.comm	ban_railgun,4,4
	.comm	ban_chaingun,4,4
	.comm	ban_machinegun,4,4
	.comm	ban_shotgun,4,4
	.comm	ban_supershotgun,4,4
	.comm	ban_grenadelauncher,4,4
	.comm	matchfullnamevalue,4,4
	.comm	fullnamevalue,4,4
	.comm	fastrailgun,4,4
	.comm	fastrocketfire,4,4
	.comm	cloaking,4,4
	.comm	CLOAK_DRAIN,4,4
	.comm	chasekeepscore,4,4
	.comm	fastchange,4,4
	.comm	fraghit,4,4
	.comm	somevar0,30,4
	.comm	somevar1,30,4
	.comm	somevar2,30,4
	.comm	somevar3,30,4
	.comm	somevar4,30,4
	.comm	somevar5,30,4
	.comm	somevar6,30,4
	.comm	somevar7,30,4
	.comm	somevar8,30,4
	.comm	somevar9,30,4
	.comm	somevar10,30,4
	.comm	somevar11,30,4
	.comm	somevar12,30,4
	.comm	somevar13,30,4
	.comm	somevar14,30,4
	.comm	totalrank,4,4
	.comm	hi_head1,60,4
	.comm	hi_head2,60,4
	.comm	hi_line1,60,4
	.comm	hi_line2,60,4
	.comm	hi_line3,60,4
	.comm	hi_line4,60,4
	.comm	hi_line5,60,4
	.comm	hi_line6,60,4
	.comm	hi_line7,60,4
	.comm	hi_line8,60,4
	.comm	hi_line9,60,4
	.comm	hi_line10,60,4
	.comm	hi_line11,60,4
	.comm	hi_line12,60,4
	.comm	hi_line13,60,4
	.comm	hi_line14,60,4
	.comm	hi_line15,60,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
