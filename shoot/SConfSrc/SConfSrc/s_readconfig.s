	.file	"s_readconfig.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Reading 'config.txt' file...\n"
	.align 2
.LC1:
	.string	""
	.align 2
.LC2:
	.string	"Complete.\n"
	.section	".text"
	.align 2
	.globl getKeys
	.type	 getKeys,@function
getKeys:
	stwu 1,-320(1)
	mflr 0
	stmw 27,300(1)
	stw 0,324(1)
	mr 31,3
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	crxor 6,6,6
	bl printf
	cmpwi 0,31,0
	bc 12,2,.L8
	addi 28,1,8
	addi 30,1,136
	li 27,0
.L9:
	li 29,0
	li 9,0
.L13:
	addi 0,9,1
	stbx 27,28,9
	rlwinm 9,0,0,0xff
	cmplwi 0,9,119
	bc 4,1,.L13
	mr 3,30
	mr 4,31
	bl strcpy
	lbz 11,136(1)
	xori 9,11,91
	xori 0,11,59
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L15
	cmpwi 0,11,10
	bc 12,2,.L16
	mr 4,30
	addi 3,1,8
	bl strcpy
	addi 29,1,264
	lis 4,.LC1@ha
	mr 3,29
	la 4,.LC1@l(4)
	bl strcmp
	cmpwi 0,3,0
	mr 3,29
	bc 12,2,.L16
	addi 4,1,8
	bl readPair
.L16:
	lwz 31,120(31)
	cmpwi 0,31,0
	bc 12,2,.L8
	mr 3,30
	mr 4,31
	bl strcpy
	b .L7
.L15:
	cmpwi 7,11,91
	addi 3,1,264
	mr 10,3
	li 9,0
	li 11,0
.L23:
	addi 0,9,1
	stbx 11,10,9
	rlwinm 9,0,0,0xff
	cmplwi 0,9,24
	bc 4,1,.L23
	bc 4,30,.L25
	li 9,1
	lbzx 0,30,9
	mr 11,0
	cmpwi 0,11,93
	bc 12,2,.L27
	mr 8,3
	mr 10,30
.L28:
	stbx 11,8,29
	addi 9,9,1
	lbzx 11,10,9
	addi 29,29,1
	cmpwi 0,11,93
	bc 4,2,.L28
.L27:
	stbx 27,3,29
.L25:
	lwz 31,120(31)
.L7:
	cmpwi 0,31,0
	bc 4,2,.L9
.L8:
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	crxor 6,6,6
	bl printf
	lwz 0,324(1)
	mtlr 0
	lmw 27,300(1)
	la 1,320(1)
	blr
.Lfe1:
	.size	 getKeys,.Lfe1-getKeys
	.section	".rodata"
	.align 2
.LC3:
	.string	"MOTD"
	.align 2
.LC4:
	.string	"Misc"
	.align 2
.LC5:
	.string	"Grapple"
	.align 2
.LC6:
	.string	"ServObits"
	.align 2
.LC7:
	.string	"BanWeapons"
	.align 2
.LC8:
	.string	"Rocket"
	.align 2
.LC9:
	.string	"GrenadeLauncher"
	.align 2
.LC10:
	.string	"Grenade"
	.align 2
.LC11:
	.string	"Blaster"
	.align 2
.LC12:
	.string	"Guns"
	.align 2
.LC13:
	.string	"Quad"
	.align 2
.LC14:
	.string	"LostQuad"
	.align 2
.LC15:
	.string	"LogOptions"
	.align 2
.LC16:
	.string	"StartWeapons"
	.align 2
.LC17:
	.string	"StartItems"
	.align 2
.LC18:
	.string	"StartAmmo"
	.align 2
.LC19:
	.string	"MaxAmmo"
	.align 2
.LC20:
	.string	"Health"
	.align 2
.LC21:
	.string	"LevelChange"
	.section	".text"
	.align 2
	.globl readPair
	.type	 readPair,@function
readPair:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lis 3,.LC3@ha
	mr 4,31
	la 3,.LC3@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L32
	mr 3,30
	bl parseMOTD
	b .L33
.L32:
	lis 3,.LC4@ha
	mr 4,31
	la 3,.LC4@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L34
	mr 3,30
	bl parseMisc
	b .L33
.L34:
	lis 3,.LC5@ha
	mr 4,31
	la 3,.LC5@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L36
	mr 3,30
	bl parseGrapple
	b .L33
.L36:
	lis 3,.LC6@ha
	mr 4,31
	la 3,.LC6@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L38
	mr 3,30
	bl parseServObits
	b .L33
.L38:
	lis 3,.LC7@ha
	mr 4,31
	la 3,.LC7@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L40
	mr 3,30
	bl parseBan
	b .L33
.L40:
	lis 3,.LC8@ha
	mr 4,31
	la 3,.LC8@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L42
	mr 3,30
	bl parseRocket
	b .L33
.L42:
	lis 3,.LC9@ha
	mr 4,31
	la 3,.LC9@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L44
	mr 3,30
	bl parseGLauncher
	b .L33
.L44:
	lis 3,.LC10@ha
	mr 4,31
	la 3,.LC10@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L46
	mr 3,30
	bl parseGrenade
	b .L33
.L46:
	lis 3,.LC11@ha
	mr 4,31
	la 3,.LC11@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L48
	mr 3,30
	bl parseBlaster
	b .L33
.L48:
	lis 3,.LC12@ha
	mr 4,31
	la 3,.LC12@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L50
	mr 3,30
	bl parseGuns
	b .L33
.L50:
	lis 3,.LC13@ha
	mr 4,31
	la 3,.LC13@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L52
	mr 3,30
	bl parseQuad
	b .L33
.L52:
	lis 3,.LC14@ha
	mr 4,31
	la 3,.LC14@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L54
	mr 3,30
	bl parseLostQuad
	b .L33
.L54:
	lis 3,.LC15@ha
	mr 4,31
	la 3,.LC15@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L56
	mr 3,30
	bl parseLogging
	b .L33
.L56:
	lis 3,.LC16@ha
	mr 4,31
	la 3,.LC16@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L58
	mr 3,30
	bl parseStartWeapons
	b .L33
.L58:
	lis 3,.LC17@ha
	mr 4,31
	la 3,.LC17@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L60
	mr 3,30
	bl parseStartItems
	b .L33
.L60:
	lis 3,.LC18@ha
	mr 4,31
	la 3,.LC18@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L62
	mr 3,30
	bl parseStartAmmo
	b .L33
.L62:
	lis 3,.LC19@ha
	mr 4,31
	la 3,.LC19@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L64
	mr 3,30
	bl parseMaxAmmo
	b .L33
.L64:
	lis 3,.LC20@ha
	mr 4,31
	la 3,.LC20@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L66
	mr 3,30
	bl parseHealth
	b .L33
.L66:
	lis 3,.LC21@ha
	mr 4,31
	la 3,.LC21@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L33
	mr 3,30
	bl parseLevelChange
.L33:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 readPair,.Lfe2-readPair
	.section	".rodata"
	.align 2
.LC22:
	.string	"ModelGenDir"
	.align 2
.LC23:
	.string	"obitsDir"
	.align 2
.LC24:
	.string	"EnableHook"
	.align 2
.LC25:
	.string	"HookTime"
	.align 2
.LC26:
	.string	"HookSpeed"
	.align 2
.LC27:
	.string	"HookDamage"
	.align 2
.LC28:
	.string	"PullSpeed"
	.align 2
.LC29:
	.string	"SkySolid"
	.align 2
.LC30:
	.string	"CloakGrapple"
	.align 2
.LC31:
	.string	"HookPathColor"
	.section	".text"
	.align 2
	.globl parseGrapple
	.type	 parseGrapple,@function
parseGrapple:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 30,3
	addi 28,1,40
	li 29,0
	bl strlen
	lbz 0,0(30)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L84
	mr 11,10
.L85:
	lbzx 0,30,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,30,9
	cmpwi 0,0,61
	bc 4,2,.L85
.L84:
	li 0,0
	addi 31,9,1
	stbx 0,10,9
	b .L87
.L90:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,28,29
	addi 29,29,1
.L87:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L90
	li 0,0
	lis 4,.LC24@ha
	stbx 0,28,29
	la 4,.LC24@l(4)
	addi 3,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L92
	mr 3,28
	bl atoi
	cmpwi 0,3,1
	lis 9,allowgrapple@ha
	stw 3,allowgrapple@l(9)
	bc 4,1,.L94
	li 0,1
	stw 0,allowgrapple@l(9)
	b .L94
.L92:
	lis 4,.LC25@ha
	addi 3,1,8
	la 4,.LC25@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L95
	mr 3,28
	bl atoi
	lis 9,HOOK_TIME@ha
	stw 3,HOOK_TIME@l(9)
	b .L94
.L95:
	lis 4,.LC26@ha
	addi 3,1,8
	la 4,.LC26@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L97
	mr 3,28
	bl atoi
	lis 9,HOOK_SPEED@ha
	stw 3,HOOK_SPEED@l(9)
	b .L94
.L97:
	lis 4,.LC27@ha
	addi 3,1,8
	la 4,.LC27@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L99
	mr 3,28
	bl atoi
	lis 9,HOOK_DAMAGE@ha
	stw 3,HOOK_DAMAGE@l(9)
	b .L94
.L99:
	lis 4,.LC28@ha
	addi 3,1,8
	la 4,.LC28@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L101
	mr 3,28
	bl atoi
	lis 9,PULL_SPEED@ha
	stw 3,PULL_SPEED@l(9)
	b .L94
.L101:
	lis 4,.LC29@ha
	addi 3,1,8
	la 4,.LC29@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L103
	mr 3,28
	bl atoi
	lis 9,EXPERT_SKY_SOLID@ha
	stw 3,EXPERT_SKY_SOLID@l(9)
	b .L94
.L103:
	lis 4,.LC30@ha
	addi 3,1,8
	la 4,.LC30@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L105
	mr 3,28
	bl atoi
	cmpwi 0,3,1
	lis 9,cloakgrapple@ha
	stw 3,cloakgrapple@l(9)
	bc 4,1,.L94
	li 0,1
	stw 0,cloakgrapple@l(9)
	b .L94
.L105:
	lis 4,.LC31@ha
	addi 3,1,8
	la 4,.LC31@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L94
	mr 3,28
	bl atoi
	cmpwi 0,3,6
	lis 9,hookcolor@ha
	stw 3,hookcolor@l(9)
	bc 4,1,.L94
	li 0,4
	stw 0,hookcolor@l(9)
.L94:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe3:
	.size	 parseGrapple,.Lfe3-parseGrapple
	.section	".rodata"
	.align 2
.LC32:
	.string	"NameBanning"
	.align 2
.LC33:
	.string	"ClientLog"
	.align 2
.LC34:
	.string	"HighScoreDir"
	.align 2
.LC35:
	.string	"ClientLogFile"
	.align 2
.LC36:
	.string	"BanDirectory"
	.align 2
.LC37:
	.string	"MatchFullName"
	.align 2
.LC38:
	.string	"MaxClientRate"
	.align 2
.LC39:
	.string	"Cloaking"
	.align 2
.LC40:
	.string	"ChaseKeepScore"
	.align 2
.LC41:
	.string	"FastChangeWeapons"
	.align 2
.LC42:
	.string	"CloakingDrain"
	.align 2
.LC43:
	.string	"Scoreboard"
	.align 2
.LC44:
	.string	"timehud"
	.align 2
.LC45:
	.string	"rankhud"
	.align 2
.LC46:
	.string	"playershud"
	.section	".text"
	.align 2
	.globl parseMisc
	.type	 parseMisc,@function
parseMisc:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 30,3
	addi 29,1,40
	li 28,0
	bl strlen
	lbz 0,0(30)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L112
	mr 11,10
.L113:
	lbzx 0,30,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,30,9
	cmpwi 0,0,61
	bc 4,2,.L113
.L112:
	li 0,0
	addi 31,9,1
	stbx 0,10,9
	b .L115
.L118:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,29,28
	addi 28,28,1
.L115:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L118
	li 0,0
	lis 4,.LC32@ha
	stbx 0,29,28
	la 4,.LC32@l(4)
	addi 3,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L120
	mr 3,29
	bl atoi
	lis 9,namebanning@ha
	stw 3,namebanning@l(9)
	b .L121
.L120:
	lis 4,.LC33@ha
	addi 3,1,8
	la 4,.LC33@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L122
	mr 3,29
	bl atoi
	cmpwi 0,3,1
	lis 9,clientlog@ha
	stw 3,clientlog@l(9)
	bc 4,1,.L121
	li 0,1
	stw 0,clientlog@l(9)
	b .L121
.L122:
	lis 4,.LC34@ha
	addi 3,1,8
	la 4,.LC34@l(4)
	bl strcmp
	mr. 9,3
	bc 4,2,.L125
	addi 0,28,-1
	lis 3,HIGHSCORE_DIR@ha
	stbx 9,29,0
	la 3,HIGHSCORE_DIR@l(3)
	b .L172
.L125:
	lis 4,.LC35@ha
	addi 3,1,8
	la 4,.LC35@l(4)
	bl strcmp
	mr. 9,3
	bc 4,2,.L127
	addi 0,28,-1
	lis 3,PLAYERS_LOGFILE@ha
	stbx 9,29,0
	la 3,PLAYERS_LOGFILE@l(3)
	b .L172
.L127:
	lis 4,.LC36@ha
	addi 3,1,8
	la 4,.LC36@l(4)
	bl strcmp
	mr. 9,3
	bc 4,2,.L129
	addi 0,28,-1
	lis 3,bandirectory@ha
	stbx 9,29,0
	la 3,bandirectory@l(3)
.L172:
	mr 4,29
	bl strcpy
	b .L121
.L129:
	lis 4,.LC37@ha
	addi 3,1,8
	la 4,.LC37@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L131
	mr 3,29
	bl atoi
	cmpwi 0,3,1
	lis 9,matchfullnamevalue@ha
	stw 3,matchfullnamevalue@l(9)
	bc 4,1,.L121
	li 0,1
	stw 0,matchfullnamevalue@l(9)
	b .L121
.L131:
	lis 4,.LC38@ha
	addi 3,1,8
	la 4,.LC38@l(4)
	bl strcmp
	mr. 31,3
	bc 4,2,.L134
	mr 3,29
	bl atoi
	lis 9,MAX_CLIENT_RATE@ha
	addi 0,28,-1
	stw 3,MAX_CLIENT_RATE@l(9)
	mr 4,29
	lis 3,MAX_CLIENT_RATE_STRING@ha
	stbx 31,29,0
	la 3,MAX_CLIENT_RATE_STRING@l(3)
	bl strcpy
	b .L121
.L134:
	lis 4,.LC39@ha
	addi 3,1,8
	la 4,.LC39@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L136
	mr 3,29
	bl atoi
	lis 9,cloaking@ha
	stw 3,cloaking@l(9)
	b .L121
.L136:
	lis 4,.LC40@ha
	addi 3,1,8
	la 4,.LC40@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L138
	mr 3,29
	bl atoi
	lis 9,chasekeepscore@ha
	stw 3,chasekeepscore@l(9)
	b .L121
.L138:
	lis 4,.LC41@ha
	addi 3,1,8
	la 4,.LC41@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L140
	mr 3,29
	bl atoi
	lis 9,fastchange@ha
	stw 3,fastchange@l(9)
	b .L121
.L140:
	lis 4,.LC42@ha
	addi 3,1,8
	la 4,.LC42@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L142
	mr 3,29
	bl atoi
	mr. 3,3
	bc 4,2,.L143
	lis 9,CLOAK_DRAIN@ha
	stw 3,CLOAK_DRAIN@l(9)
	b .L121
.L143:
	cmpwi 0,3,1
	bc 4,2,.L145
	lis 9,CLOAK_DRAIN@ha
	li 0,20
	stw 0,CLOAK_DRAIN@l(9)
	b .L121
.L145:
	cmpwi 0,3,2
	bc 4,2,.L147
	lis 9,CLOAK_DRAIN@ha
	li 0,14
	stw 0,CLOAK_DRAIN@l(9)
	b .L121
.L147:
	cmpwi 0,3,3
	bc 4,2,.L149
	lis 9,CLOAK_DRAIN@ha
	li 0,8
	stw 0,CLOAK_DRAIN@l(9)
	b .L121
.L149:
	cmpwi 0,3,4
	bc 4,2,.L151
	lis 9,CLOAK_DRAIN@ha
	li 0,7
	stw 0,CLOAK_DRAIN@l(9)
	b .L121
.L151:
	cmpwi 0,3,5
	bc 4,2,.L153
	lis 9,CLOAK_DRAIN@ha
	li 0,6
	stw 0,CLOAK_DRAIN@l(9)
	b .L121
.L153:
	cmpwi 0,3,6
	bc 4,2,.L155
	lis 9,CLOAK_DRAIN@ha
	li 0,5
	stw 0,CLOAK_DRAIN@l(9)
	b .L121
.L155:
	cmpwi 0,3,7
	bc 4,2,.L157
	lis 9,CLOAK_DRAIN@ha
	li 0,4
	stw 0,CLOAK_DRAIN@l(9)
	b .L121
.L157:
	cmpwi 0,3,8
	bc 4,2,.L159
	lis 9,CLOAK_DRAIN@ha
	li 0,3
	stw 0,CLOAK_DRAIN@l(9)
	b .L121
.L159:
	cmpwi 0,3,9
	bc 4,2,.L161
	lis 9,CLOAK_DRAIN@ha
	li 0,2
	stw 0,CLOAK_DRAIN@l(9)
	b .L121
.L161:
	cmpwi 0,3,10
	bc 4,2,.L121
	lis 9,CLOAK_DRAIN@ha
	li 0,1
	stw 0,CLOAK_DRAIN@l(9)
	b .L121
.L142:
	lis 4,.LC43@ha
	addi 3,1,8
	la 4,.LC43@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L165
	mr 3,29
	bl atoi
	lis 9,scoreboard@ha
	stw 3,scoreboard@l(9)
	b .L121
.L165:
	lis 4,.LC44@ha
	addi 3,1,8
	la 4,.LC44@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L167
	mr 3,29
	bl atoi
	lis 9,timehud@ha
	stw 3,timehud@l(9)
	b .L121
.L167:
	lis 4,.LC45@ha
	addi 3,1,8
	la 4,.LC45@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L169
	mr 3,29
	bl atoi
	lis 9,rankhud@ha
	stw 3,rankhud@l(9)
	b .L121
.L169:
	lis 4,.LC46@ha
	addi 3,1,8
	la 4,.LC46@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L121
	mr 3,29
	bl atoi
	lis 9,playershud@ha
	stw 3,playershud@l(9)
.L121:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe4:
	.size	 parseMisc,.Lfe4-parseMisc
	.section	".rodata"
	.align 2
.LC47:
	.string	"line1"
	.align 2
.LC48:
	.string	"line2"
	.align 2
.LC49:
	.string	"line3"
	.align 2
.LC50:
	.string	"line4"
	.align 2
.LC51:
	.string	"line5"
	.align 2
.LC52:
	.string	"line6"
	.align 2
.LC53:
	.string	"line7"
	.align 2
.LC54:
	.string	"line8"
	.align 2
.LC55:
	.string	"line9"
	.align 2
.LC56:
	.string	"line10"
	.align 2
.LC57:
	.string	"line11"
	.align 2
.LC58:
	.string	"line12"
	.align 2
.LC59:
	.string	"line13"
	.align 2
.LC60:
	.string	"line14"
	.align 2
.LC61:
	.string	"line15"
	.section	".text"
	.align 2
	.globl parseMOTD
	.type	 parseMOTD,@function
parseMOTD:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 30,3
	addi 28,1,40
	li 29,0
	bl strlen
	lbz 0,0(30)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L175
	mr 11,10
.L176:
	lbzx 0,30,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,30,9
	cmpwi 0,0,61
	bc 4,2,.L176
.L175:
	li 0,0
	addi 31,9,1
	stbx 0,10,9
	b .L178
.L181:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,28,29
	addi 29,29,1
.L178:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L181
	addi 0,29,-1
	li 9,0
	lis 4,.LC47@ha
	stbx 9,28,0
	addi 3,1,8
	la 4,.LC47@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L183
	lis 3,somevar0@ha
	mr 4,28
	la 3,somevar0@l(3)
	bl strcpy
	b .L184
.L183:
	lis 4,.LC48@ha
	addi 3,1,8
	la 4,.LC48@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L185
	lis 3,somevar1@ha
	mr 4,28
	la 3,somevar1@l(3)
	bl strcpy
	b .L184
.L185:
	lis 4,.LC49@ha
	addi 3,1,8
	la 4,.LC49@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L187
	lis 3,somevar2@ha
	mr 4,28
	la 3,somevar2@l(3)
	bl strcpy
	b .L184
.L187:
	lis 4,.LC50@ha
	addi 3,1,8
	la 4,.LC50@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L189
	lis 3,somevar3@ha
	mr 4,28
	la 3,somevar3@l(3)
	bl strcpy
	b .L184
.L189:
	lis 4,.LC51@ha
	addi 3,1,8
	la 4,.LC51@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L191
	lis 3,somevar4@ha
	mr 4,28
	la 3,somevar4@l(3)
	bl strcpy
	b .L184
.L191:
	lis 4,.LC52@ha
	addi 3,1,8
	la 4,.LC52@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L193
	lis 3,somevar5@ha
	mr 4,28
	la 3,somevar5@l(3)
	bl strcpy
	b .L184
.L193:
	lis 4,.LC53@ha
	addi 3,1,8
	la 4,.LC53@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L195
	lis 3,somevar6@ha
	mr 4,28
	la 3,somevar6@l(3)
	bl strcpy
	b .L184
.L195:
	lis 4,.LC54@ha
	addi 3,1,8
	la 4,.LC54@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L197
	lis 3,somevar7@ha
	mr 4,28
	la 3,somevar7@l(3)
	bl strcpy
	b .L184
.L197:
	lis 4,.LC55@ha
	addi 3,1,8
	la 4,.LC55@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L199
	lis 3,somevar8@ha
	mr 4,28
	la 3,somevar8@l(3)
	bl strcpy
	b .L184
.L199:
	lis 4,.LC56@ha
	addi 3,1,8
	la 4,.LC56@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L201
	lis 3,somevar9@ha
	mr 4,28
	la 3,somevar9@l(3)
	bl strcpy
	b .L184
.L201:
	lis 4,.LC57@ha
	addi 3,1,8
	la 4,.LC57@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L203
	lis 3,somevar10@ha
	mr 4,28
	la 3,somevar10@l(3)
	bl strcpy
	b .L184
.L203:
	lis 4,.LC58@ha
	addi 3,1,8
	la 4,.LC58@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L205
	lis 3,somevar11@ha
	mr 4,28
	la 3,somevar11@l(3)
	bl strcpy
	b .L184
.L205:
	lis 4,.LC59@ha
	addi 3,1,8
	la 4,.LC59@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L207
	lis 3,somevar12@ha
	mr 4,28
	la 3,somevar12@l(3)
	bl strcpy
	b .L184
.L207:
	lis 4,.LC60@ha
	addi 3,1,8
	la 4,.LC60@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L209
	lis 3,somevar13@ha
	mr 4,28
	la 3,somevar13@l(3)
	bl strcpy
	b .L184
.L209:
	lis 4,.LC61@ha
	addi 3,1,8
	la 4,.LC61@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L184
	lis 3,somevar14@ha
	mr 4,28
	la 3,somevar14@l(3)
	bl strcpy
.L184:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe5:
	.size	 parseMOTD,.Lfe5-parseMOTD
	.section	".rodata"
	.align 2
.LC62:
	.string	"banShotgun"
	.align 2
.LC63:
	.string	"banSupershotgun"
	.align 2
.LC64:
	.string	"banMachinegun"
	.align 2
.LC65:
	.string	"banChaingun"
	.align 2
.LC66:
	.string	"banGrenadelauncher"
	.align 2
.LC67:
	.string	"banRocketlauncher"
	.align 2
.LC68:
	.string	"banHyperblaster"
	.align 2
.LC69:
	.string	"banRailgun"
	.align 2
.LC70:
	.string	"banBFG"
	.section	".text"
	.align 2
	.globl parseBan
	.type	 parseBan,@function
parseBan:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 30,3
	addi 28,1,40
	li 29,0
	bl strlen
	lbz 0,0(30)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L214
	mr 11,10
.L215:
	lbzx 0,30,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,30,9
	cmpwi 0,0,61
	bc 4,2,.L215
.L214:
	li 0,0
	addi 31,9,1
	stbx 0,10,9
	b .L217
.L220:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,28,29
	addi 29,29,1
.L217:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L220
	li 0,0
	lis 4,.LC62@ha
	stbx 0,28,29
	la 4,.LC62@l(4)
	addi 3,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L222
	mr 3,28
	bl atoi
	lis 9,ban_shotgun@ha
	stw 3,ban_shotgun@l(9)
	b .L223
.L222:
	lis 4,.LC63@ha
	addi 3,1,8
	la 4,.LC63@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L224
	mr 3,28
	bl atoi
	lis 9,ban_supershotgun@ha
	stw 3,ban_supershotgun@l(9)
	b .L223
.L224:
	lis 4,.LC64@ha
	addi 3,1,8
	la 4,.LC64@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L226
	mr 3,28
	bl atoi
	lis 9,ban_machinegun@ha
	stw 3,ban_machinegun@l(9)
	b .L223
.L226:
	lis 4,.LC65@ha
	addi 3,1,8
	la 4,.LC65@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L228
	mr 3,28
	bl atoi
	lis 9,ban_chaingun@ha
	stw 3,ban_chaingun@l(9)
	b .L223
.L228:
	lis 4,.LC66@ha
	addi 3,1,8
	la 4,.LC66@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L230
	mr 3,28
	bl atoi
	lis 9,ban_grenadelauncher@ha
	stw 3,ban_grenadelauncher@l(9)
	b .L223
.L230:
	lis 4,.LC67@ha
	addi 3,1,8
	la 4,.LC67@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L232
	mr 3,28
	bl atoi
	lis 9,ban_rocketlauncher@ha
	stw 3,ban_rocketlauncher@l(9)
	b .L223
.L232:
	lis 4,.LC68@ha
	addi 3,1,8
	la 4,.LC68@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L234
	mr 3,28
	bl atoi
	lis 9,ban_hyperblaster@ha
	stw 3,ban_hyperblaster@l(9)
	b .L223
.L234:
	lis 4,.LC69@ha
	addi 3,1,8
	la 4,.LC69@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L236
	mr 3,28
	bl atoi
	lis 9,ban_railgun@ha
	stw 3,ban_railgun@l(9)
	b .L223
.L236:
	lis 4,.LC70@ha
	addi 3,1,8
	la 4,.LC70@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L223
	mr 3,28
	bl atoi
	lis 9,ban_BFG@ha
	stw 3,ban_BFG@l(9)
.L223:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe6:
	.size	 parseBan,.Lfe6-parseBan
	.section	".rodata"
	.align 2
.LC71:
	.string	"LoseQuad"
	.align 2
.LC72:
	.string	"Fragee"
	.align 2
.LC73:
	.string	"StartHealth"
	.align 2
.LC74:
	.string	"MaxHealth"
	.align 2
.LC75:
	.string	"Bullets"
	.align 2
.LC76:
	.string	"Shells"
	.align 2
.LC77:
	.string	"Cells"
	.align 2
.LC78:
	.string	"Grenades"
	.align 2
.LC79:
	.string	"Rockets"
	.align 2
.LC80:
	.string	"Slugs"
	.section	".text"
	.align 2
	.globl parseMaxAmmo
	.type	 parseMaxAmmo,@function
parseMaxAmmo:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 30,3
	addi 28,1,40
	li 29,0
	bl strlen
	lbz 0,0(30)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L267
	mr 11,10
.L268:
	lbzx 0,30,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,30,9
	cmpwi 0,0,61
	bc 4,2,.L268
.L267:
	li 0,0
	addi 31,9,1
	stbx 0,10,9
	b .L270
.L273:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,28,29
	addi 29,29,1
.L270:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L273
	li 0,0
	lis 4,.LC75@ha
	stbx 0,28,29
	la 4,.LC75@l(4)
	addi 3,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L275
	mr 3,28
	bl atoi
	lis 9,MA_Bullets@ha
	stw 3,MA_Bullets@l(9)
	b .L276
.L275:
	lis 4,.LC76@ha
	addi 3,1,8
	la 4,.LC76@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L277
	mr 3,28
	bl atoi
	lis 9,MA_Shells@ha
	stw 3,MA_Shells@l(9)
	b .L276
.L277:
	lis 4,.LC77@ha
	addi 3,1,8
	la 4,.LC77@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L279
	mr 3,28
	bl atoi
	lis 9,MA_Cells@ha
	stw 3,MA_Cells@l(9)
	b .L276
.L279:
	lis 4,.LC78@ha
	addi 3,1,8
	la 4,.LC78@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L281
	mr 3,28
	bl atoi
	lis 9,MA_Grenades@ha
	stw 3,MA_Grenades@l(9)
	b .L276
.L281:
	lis 4,.LC79@ha
	addi 3,1,8
	la 4,.LC79@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L283
	mr 3,28
	bl atoi
	lis 9,MA_Rockets@ha
	stw 3,MA_Rockets@l(9)
	b .L276
.L283:
	lis 4,.LC80@ha
	addi 3,1,8
	la 4,.LC80@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L276
	mr 3,28
	bl atoi
	lis 9,MA_Slugs@ha
	stw 3,MA_Slugs@l(9)
.L276:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe7:
	.size	 parseMaxAmmo,.Lfe7-parseMaxAmmo
	.align 2
	.globl parseStartAmmo
	.type	 parseStartAmmo,@function
parseStartAmmo:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 30,3
	addi 28,1,40
	li 29,0
	bl strlen
	lbz 0,0(30)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L288
	mr 11,10
.L289:
	lbzx 0,30,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,30,9
	cmpwi 0,0,61
	bc 4,2,.L289
.L288:
	li 0,0
	addi 31,9,1
	stbx 0,10,9
	b .L291
.L294:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,28,29
	addi 29,29,1
.L291:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L294
	li 0,0
	lis 4,.LC75@ha
	stbx 0,28,29
	la 4,.LC75@l(4)
	addi 3,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L296
	mr 3,28
	bl atoi
	lis 9,SA_Bullets@ha
	stw 3,SA_Bullets@l(9)
	b .L297
.L296:
	lis 4,.LC76@ha
	addi 3,1,8
	la 4,.LC76@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L298
	mr 3,28
	bl atoi
	lis 9,SA_Shells@ha
	stw 3,SA_Shells@l(9)
	b .L297
.L298:
	lis 4,.LC77@ha
	addi 3,1,8
	la 4,.LC77@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L300
	mr 3,28
	bl atoi
	lis 9,SA_Cells@ha
	stw 3,SA_Cells@l(9)
	b .L297
.L300:
	lis 4,.LC78@ha
	addi 3,1,8
	la 4,.LC78@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L302
	mr 3,28
	bl atoi
	lis 9,SA_Grenades@ha
	stw 3,SA_Grenades@l(9)
	b .L297
.L302:
	lis 4,.LC79@ha
	addi 3,1,8
	la 4,.LC79@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L304
	mr 3,28
	bl atoi
	lis 9,SA_Rockets@ha
	stw 3,SA_Rockets@l(9)
	b .L297
.L304:
	lis 4,.LC80@ha
	addi 3,1,8
	la 4,.LC80@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L297
	mr 3,28
	bl atoi
	lis 9,SA_Slugs@ha
	stw 3,SA_Slugs@l(9)
.L297:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe8:
	.size	 parseStartAmmo,.Lfe8-parseStartAmmo
	.section	".rodata"
	.align 2
.LC81:
	.string	"QuadDamage"
	.align 2
.LC82:
	.string	"Invulnerability"
	.align 2
.LC83:
	.string	"Silencer"
	.align 2
.LC84:
	.string	"Rebreather"
	.align 2
.LC85:
	.string	"EnvironmentSuit"
	.align 2
.LC86:
	.string	"PowerScreen"
	.align 2
.LC87:
	.string	"PowerShield"
	.align 2
.LC88:
	.string	"QuadDamageTime"
	.align 2
.LC89:
	.string	"RebreatherTime"
	.align 2
.LC90:
	.string	"EnvironmentSuitTime"
	.align 2
.LC91:
	.string	"InvulnerabilityTime"
	.align 2
.LC92:
	.string	"SilencerShots"
	.align 2
.LC93:
	.string	"RegenInvulnerability"
	.align 2
.LC94:
	.string	"RegenInvulnerabilityTime"
	.align 2
.LC95:
	.string	"AutoUseQuad"
	.align 2
.LC96:
	.string	"AutoUseInvulnerability"
	.section	".text"
	.align 2
	.globl parseStartItems
	.type	 parseStartItems,@function
parseStartItems:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 30,3
	addi 28,1,40
	li 29,0
	bl strlen
	lbz 0,0(30)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L309
	mr 11,10
.L310:
	lbzx 0,30,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,30,9
	cmpwi 0,0,61
	bc 4,2,.L310
.L309:
	li 0,0
	addi 31,9,1
	stbx 0,10,9
	b .L312
.L315:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,28,29
	addi 29,29,1
.L312:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L315
	li 0,0
	lis 4,.LC81@ha
	stbx 0,28,29
	la 4,.LC81@l(4)
	addi 3,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L317
	mr 3,28
	bl atoi
	lis 9,SI_QuadDamage@ha
	stw 3,SI_QuadDamage@l(9)
	b .L318
.L317:
	lis 4,.LC82@ha
	addi 3,1,8
	la 4,.LC82@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L319
	mr 3,28
	bl atoi
	lis 9,SI_Invulnerability@ha
	stw 3,SI_Invulnerability@l(9)
	b .L318
.L319:
	lis 4,.LC83@ha
	addi 3,1,8
	la 4,.LC83@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L321
	mr 3,28
	bl atoi
	lis 9,SI_Silencer@ha
	stw 3,SI_Silencer@l(9)
	b .L318
.L321:
	lis 4,.LC84@ha
	addi 3,1,8
	la 4,.LC84@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L323
	mr 3,28
	bl atoi
	lis 9,SI_Rebreather@ha
	stw 3,SI_Rebreather@l(9)
	b .L318
.L323:
	lis 4,.LC85@ha
	addi 3,1,8
	la 4,.LC85@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L325
	mr 3,28
	bl atoi
	lis 9,SI_EnvironmentSuit@ha
	stw 3,SI_EnvironmentSuit@l(9)
	b .L318
.L325:
	lis 4,.LC86@ha
	addi 3,1,8
	la 4,.LC86@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L327
	mr 3,28
	bl atoi
	lis 9,SI_PowerScreen@ha
	stw 3,SI_PowerScreen@l(9)
	b .L318
.L327:
	lis 4,.LC87@ha
	addi 3,1,8
	la 4,.LC87@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L329
	mr 3,28
	bl atoi
	lis 9,SI_PowerShield@ha
	stw 3,SI_PowerShield@l(9)
	b .L318
.L329:
	lis 4,.LC88@ha
	addi 3,1,8
	la 4,.LC88@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L331
	mr 3,28
	lis 31,QuadDamageTime@ha
	bl atoi
	mulli 3,3,10
	addi 0,3,-100
	stw 3,QuadDamageTime@l(31)
	cmplwi 0,0,1100
	bc 4,1,.L318
	li 0,300
	stw 0,QuadDamageTime@l(31)
	b .L318
.L331:
	lis 4,.LC89@ha
	addi 3,1,8
	la 4,.LC89@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L334
	mr 3,28
	lis 31,RebreatherTime@ha
	bl atoi
	mulli 3,3,10
	addi 0,3,-100
	stw 3,RebreatherTime@l(31)
	cmplwi 0,0,1100
	bc 4,1,.L318
	li 0,300
	stw 0,RebreatherTime@l(31)
	b .L318
.L334:
	lis 4,.LC90@ha
	addi 3,1,8
	la 4,.LC90@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L337
	mr 3,28
	lis 31,EnvironmentSuitTime@ha
	bl atoi
	mulli 3,3,10
	addi 0,3,-100
	stw 3,EnvironmentSuitTime@l(31)
	cmplwi 0,0,1100
	bc 4,1,.L318
	li 0,300
	stw 0,EnvironmentSuitTime@l(31)
	b .L318
.L337:
	lis 4,.LC91@ha
	addi 3,1,8
	la 4,.LC91@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L340
	mr 3,28
	lis 31,InvulnerabilityTime@ha
	bl atoi
	mulli 3,3,10
	addi 0,3,-100
	stw 3,InvulnerabilityTime@l(31)
	cmplwi 0,0,1100
	bc 4,1,.L318
	li 0,300
	stw 0,InvulnerabilityTime@l(31)
	b .L318
.L340:
	lis 4,.LC92@ha
	addi 3,1,8
	la 4,.LC92@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L343
	mr 3,28
	bl atoi
	addi 0,3,-10
	lis 9,SilencerShots@ha
	cmplwi 0,0,110
	stw 3,SilencerShots@l(9)
	bc 4,1,.L318
	li 0,30
	stw 0,SilencerShots@l(9)
	b .L318
.L343:
	lis 4,.LC93@ha
	addi 3,1,8
	la 4,.LC93@l(4)
	bl strcmp
	mr. 31,3
	bc 4,2,.L346
	mr 3,28
	bl atoi
	cmplwi 0,3,1
	lis 9,RegenInvulnerability@ha
	stw 3,RegenInvulnerability@l(9)
	bc 4,1,.L318
	stw 31,RegenInvulnerability@l(9)
	b .L318
.L346:
	lis 4,.LC94@ha
	addi 3,1,8
	la 4,.LC94@l(4)
	bl strcmp
	mr. 30,3
	bc 4,2,.L349
	mr 3,28
	lis 31,RegenInvulnerabilityTime@ha
	bl atoi
	mulli 3,3,10
	addi 0,3,-30
	stw 3,RegenInvulnerabilityTime@l(31)
	cmplwi 0,0,70
	bc 4,1,.L318
	stw 30,RegenInvulnerabilityTime@l(31)
	b .L318
.L349:
	lis 4,.LC95@ha
	addi 3,1,8
	la 4,.LC95@l(4)
	bl strcmp
	mr. 31,3
	bc 4,2,.L352
	mr 3,28
	bl atoi
	cmplwi 0,3,1
	lis 9,AutoUseQuad@ha
	stw 3,AutoUseQuad@l(9)
	bc 4,1,.L318
	stw 31,AutoUseQuad@l(9)
	b .L318
.L352:
	lis 4,.LC96@ha
	addi 3,1,8
	la 4,.LC96@l(4)
	bl strcmp
	mr. 31,3
	bc 4,2,.L318
	mr 3,28
	bl atoi
	cmplwi 0,3,1
	lis 9,AutoUseInvulnerability@ha
	stw 3,AutoUseInvulnerability@l(9)
	bc 4,1,.L318
	stw 31,AutoUseInvulnerability@l(9)
.L318:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe9:
	.size	 parseStartItems,.Lfe9-parseStartItems
	.section	".rodata"
	.align 2
.LC97:
	.string	"ShotGun"
	.align 2
.LC98:
	.string	"SuperShotGun"
	.align 2
.LC99:
	.string	"MachineGun"
	.align 2
.LC100:
	.string	"ChainGun"
	.align 2
.LC101:
	.string	"RocketLauncher"
	.align 2
.LC102:
	.string	"HyperBlaster"
	.align 2
.LC103:
	.string	"RailGun"
	.align 2
.LC104:
	.string	"BFG10K"
	.section	".text"
	.align 2
	.globl parseStartWeapons
	.type	 parseStartWeapons,@function
parseStartWeapons:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 30,3
	addi 28,1,40
	li 29,0
	bl strlen
	lbz 0,0(30)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L359
	mr 11,10
.L360:
	lbzx 0,30,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,30,9
	cmpwi 0,0,61
	bc 4,2,.L360
.L359:
	li 0,0
	addi 31,9,1
	stbx 0,10,9
	b .L362
.L365:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,28,29
	addi 29,29,1
.L362:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L365
	li 0,0
	lis 4,.LC11@ha
	stbx 0,28,29
	la 4,.LC11@l(4)
	addi 3,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L367
	mr 3,28
	bl atoi
	lis 9,SW_Blaster@ha
	stw 3,SW_Blaster@l(9)
	b .L368
.L367:
	lis 4,.LC97@ha
	addi 3,1,8
	la 4,.LC97@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L369
	mr 3,28
	bl atoi
	lis 9,SW_ShotGun@ha
	stw 3,SW_ShotGun@l(9)
	b .L368
.L369:
	lis 4,.LC98@ha
	addi 3,1,8
	la 4,.LC98@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L371
	mr 3,28
	bl atoi
	lis 9,SW_SuperShotGun@ha
	stw 3,SW_SuperShotGun@l(9)
	b .L368
.L371:
	lis 4,.LC99@ha
	addi 3,1,8
	la 4,.LC99@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L373
	mr 3,28
	bl atoi
	lis 9,SW_MachineGun@ha
	stw 3,SW_MachineGun@l(9)
	b .L368
.L373:
	lis 4,.LC100@ha
	addi 3,1,8
	la 4,.LC100@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L375
	mr 3,28
	bl atoi
	lis 9,SW_ChainGun@ha
	stw 3,SW_ChainGun@l(9)
	b .L368
.L375:
	lis 4,.LC9@ha
	addi 3,1,8
	la 4,.LC9@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L377
	mr 3,28
	bl atoi
	lis 9,SW_GrenadeLauncher@ha
	stw 3,SW_GrenadeLauncher@l(9)
	b .L368
.L377:
	lis 4,.LC101@ha
	addi 3,1,8
	la 4,.LC101@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L379
	mr 3,28
	bl atoi
	lis 9,SW_RocketLauncher@ha
	stw 3,SW_RocketLauncher@l(9)
	b .L368
.L379:
	lis 4,.LC102@ha
	addi 3,1,8
	la 4,.LC102@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L381
	mr 3,28
	bl atoi
	lis 9,SW_HyperBlaster@ha
	stw 3,SW_HyperBlaster@l(9)
	b .L368
.L381:
	lis 4,.LC103@ha
	addi 3,1,8
	la 4,.LC103@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L383
	mr 3,28
	bl atoi
	lis 9,SW_RailGun@ha
	stw 3,SW_RailGun@l(9)
	b .L368
.L383:
	lis 4,.LC104@ha
	addi 3,1,8
	la 4,.LC104@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L368
	mr 3,28
	bl atoi
	lis 9,SW_BFG10K@ha
	stw 3,SW_BFG10K@l(9)
.L368:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe10:
	.size	 parseStartWeapons,.Lfe10-parseStartWeapons
	.section	".rodata"
	.align 2
.LC105:
	.string	"Killer"
	.align 2
.LC106:
	.string	"Killee"
	.align 2
.LC107:
	.string	"Damage"
	.align 2
.LC108:
	.string	"FastRocketFire"
	.align 2
.LC109:
	.string	"RocketVelocity"
	.align 2
.LC110:
	.string	"RadiusDamage"
	.align 2
.LC111:
	.string	"DamageRadius"
	.section	".text"
	.align 2
	.globl parseRocket
	.type	 parseRocket,@function
parseRocket:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 30,3
	addi 28,1,40
	li 29,0
	bl strlen
	lbz 0,0(30)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L401
	mr 11,10
.L402:
	lbzx 0,30,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,30,9
	cmpwi 0,0,61
	bc 4,2,.L402
.L401:
	li 0,0
	addi 31,9,1
	stbx 0,10,9
	b .L404
.L407:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,28,29
	addi 29,29,1
.L404:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L407
	li 0,0
	lis 4,.LC107@ha
	stbx 0,28,29
	la 4,.LC107@l(4)
	addi 3,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L409
	mr 3,28
	bl atoi
	lis 9,ConfigRD@ha
	stw 3,ConfigRD@l(9)
	b .L410
.L409:
	lis 4,.LC108@ha
	addi 3,1,8
	la 4,.LC108@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L411
	mr 3,28
	bl atoi
	lis 9,fastrocketfire@ha
	stw 3,fastrocketfire@l(9)
	b .L410
.L411:
	lis 4,.LC109@ha
	addi 3,1,8
	la 4,.LC109@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L413
	mr 3,28
	bl atoi
	lis 9,rocketspeed@ha
	stw 3,rocketspeed@l(9)
	b .L410
.L413:
	lis 4,.LC110@ha
	addi 3,1,8
	la 4,.LC110@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L415
	mr 3,28
	bl atoi
	lis 9,RadiusDamage@ha
	stw 3,RadiusDamage@l(9)
	b .L410
.L415:
	lis 4,.LC111@ha
	addi 3,1,8
	la 4,.LC111@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L410
	mr 3,28
	bl atoi
	lis 9,DamageRadius@ha
	stw 3,DamageRadius@l(9)
.L410:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe11:
	.size	 parseRocket,.Lfe11-parseRocket
	.section	".rodata"
	.align 2
.LC112:
	.string	"Timer"
	.align 2
.LC113:
	.string	"FireDistance"
	.align 2
.LC114:
	.string	"Radius"
	.section	".text"
	.align 2
	.globl parseGLauncher
	.type	 parseGLauncher,@function
parseGLauncher:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 31,3
	addi 28,1,40
	li 30,0
	bl strlen
	lbz 0,0(31)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L420
	mr 11,10
.L421:
	lbzx 0,31,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,31,9
	cmpwi 0,0,61
	bc 4,2,.L421
.L420:
	li 0,0
	addi 29,9,1
	stbx 0,10,9
	b .L423
.L426:
	lbzx 0,31,29
	addi 29,29,1
	stbx 0,28,30
	addi 30,30,1
.L423:
	mr 3,31
	bl strlen
	cmplw 0,29,3
	bc 12,0,.L426
	li 0,0
	lis 4,.LC112@ha
	stbx 0,28,30
	la 4,.LC112@l(4)
	addi 3,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L428
	mr 3,28
	lis 29,GLauncherTimer@ha
	bl atof
	frsp 1,1
	stfs 1,GLauncherTimer@l(29)
	b .L429
.L428:
	lis 4,.LC113@ha
	addi 3,1,8
	la 4,.LC113@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L430
	mr 3,28
	bl atoi
	lis 9,GLauncherFireDistance@ha
	stw 3,GLauncherFireDistance@l(9)
	b .L429
.L430:
	lis 4,.LC107@ha
	addi 3,1,8
	la 4,.LC107@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L432
	mr 3,28
	bl atoi
	lis 9,GLauncherDamage@ha
	stw 3,GLauncherDamage@l(9)
	b .L429
.L432:
	lis 4,.LC114@ha
	addi 3,1,8
	la 4,.LC114@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L429
	mr 3,28
	bl atoi
	lis 9,GLauncherRadius@ha
	stw 3,GLauncherRadius@l(9)
.L429:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe12:
	.size	 parseGLauncher,.Lfe12-parseGLauncher
	.section	".rodata"
	.align 2
.LC115:
	.string	"MinSpeed"
	.align 2
.LC116:
	.string	"MaxSpeed"
	.section	".text"
	.align 2
	.globl parseGrenade
	.type	 parseGrenade,@function
parseGrenade:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 31,3
	addi 28,1,40
	li 30,0
	bl strlen
	lbz 0,0(31)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L437
	mr 11,10
.L438:
	lbzx 0,31,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,31,9
	cmpwi 0,0,61
	bc 4,2,.L438
.L437:
	li 0,0
	addi 29,9,1
	stbx 0,10,9
	b .L440
.L443:
	lbzx 0,31,29
	addi 29,29,1
	stbx 0,28,30
	addi 30,30,1
.L440:
	mr 3,31
	bl strlen
	cmplw 0,29,3
	bc 12,0,.L443
	li 0,0
	lis 4,.LC112@ha
	stbx 0,28,30
	la 4,.LC112@l(4)
	addi 3,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L445
	mr 3,28
	lis 29,GrenadeTimer@ha
	bl atof
	frsp 1,1
	stfs 1,GrenadeTimer@l(29)
	b .L446
.L445:
	lis 4,.LC114@ha
	addi 3,1,8
	la 4,.LC114@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L447
	mr 3,28
	bl atoi
	lis 9,GrenadeRadius@ha
	stw 3,GrenadeRadius@l(9)
	b .L446
.L447:
	lis 4,.LC107@ha
	addi 3,1,8
	la 4,.LC107@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L449
	mr 3,28
	bl atoi
	lis 9,GrenadeDamage@ha
	stw 3,GrenadeDamage@l(9)
	b .L446
.L449:
	lis 4,.LC115@ha
	addi 3,1,8
	la 4,.LC115@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L451
	mr 3,28
	bl atoi
	lis 9,GrenadeMinSpeed@ha
	stw 3,GrenadeMinSpeed@l(9)
	b .L446
.L451:
	lis 4,.LC116@ha
	addi 3,1,8
	la 4,.LC116@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L446
	mr 3,28
	bl atoi
	lis 9,GrenadeMaxSpeed@ha
	stw 3,GrenadeMaxSpeed@l(9)
.L446:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe13:
	.size	 parseGrenade,.Lfe13-parseGrenade
	.section	".rodata"
	.align 2
.LC117:
	.string	"HyperBlasterDamage"
	.align 2
.LC118:
	.string	"ProjectileSpeed"
	.align 2
.LC119:
	.string	"BlasterDamage"
	.section	".text"
	.align 2
	.globl parseBlaster
	.type	 parseBlaster,@function
parseBlaster:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 30,3
	addi 28,1,40
	li 29,0
	bl strlen
	lbz 0,0(30)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L456
	mr 11,10
.L457:
	lbzx 0,30,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,30,9
	cmpwi 0,0,61
	bc 4,2,.L457
.L456:
	li 0,0
	addi 31,9,1
	stbx 0,10,9
	b .L459
.L462:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,28,29
	addi 29,29,1
.L459:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L462
	li 0,0
	lis 4,.LC117@ha
	stbx 0,28,29
	la 4,.LC117@l(4)
	addi 3,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L464
	mr 3,28
	bl atoi
	lis 9,HyperBlasterDamage@ha
	stw 3,HyperBlasterDamage@l(9)
	b .L465
.L464:
	lis 4,.LC118@ha
	addi 3,1,8
	la 4,.LC118@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L466
	mr 3,28
	bl atoi
	lis 9,BlasterProjectileSpeed@ha
	stw 3,BlasterProjectileSpeed@l(9)
	b .L465
.L466:
	lis 4,.LC119@ha
	addi 3,1,8
	la 4,.LC119@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L465
	mr 3,28
	bl atoi
	lis 9,BlasterDamage@ha
	stw 3,BlasterDamage@l(9)
.L465:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe14:
	.size	 parseBlaster,.Lfe14-parseBlaster
	.section	".rodata"
	.align 2
.LC120:
	.string	"MachinegunDamage"
	.align 2
.LC121:
	.string	"MachinegunKick"
	.align 2
.LC122:
	.string	"ChaingunDamage"
	.align 2
.LC123:
	.string	"ChaingunKick"
	.align 2
.LC124:
	.string	"ShotgunDamage"
	.align 2
.LC125:
	.string	"ShotgunKick"
	.align 2
.LC126:
	.string	"SuperShotgunDamage"
	.align 2
.LC127:
	.string	"SuperShotgunKick"
	.align 2
.LC128:
	.string	"FastRailgun"
	.align 2
.LC129:
	.string	"RailgunDamage"
	.align 2
.LC130:
	.string	"RailgunKick"
	.align 2
.LC131:
	.string	"BFGDamage"
	.align 2
.LC132:
	.string	"BFGDamageRadius"
	.align 2
.LC133:
	.string	"BFGProjectileSpeed"
	.section	".text"
	.align 2
	.globl parseGuns
	.type	 parseGuns,@function
parseGuns:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 31,3
	addi 28,1,40
	li 30,0
	bl strlen
	lbz 0,0(31)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L471
	mr 11,10
.L472:
	lbzx 0,31,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,31,9
	cmpwi 0,0,61
	bc 4,2,.L472
.L471:
	li 0,0
	addi 29,9,1
	stbx 0,10,9
	b .L474
.L477:
	lbzx 0,31,29
	addi 29,29,1
	stbx 0,28,30
	addi 30,30,1
.L474:
	mr 3,31
	bl strlen
	cmplw 0,29,3
	bc 12,0,.L477
	li 0,0
	lis 4,.LC120@ha
	stbx 0,28,30
	la 4,.LC120@l(4)
	addi 3,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L479
	mr 3,28
	bl atoi
	lis 9,MachinegunDamage@ha
	stw 3,MachinegunDamage@l(9)
	b .L480
.L479:
	lis 4,.LC121@ha
	addi 3,1,8
	la 4,.LC121@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L481
	mr 3,28
	bl atoi
	lis 9,MachinegunKick@ha
	stw 3,MachinegunKick@l(9)
	b .L480
.L481:
	lis 4,.LC122@ha
	addi 3,1,8
	la 4,.LC122@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L483
	mr 3,28
	bl atoi
	lis 9,ChaingunDamage@ha
	stw 3,ChaingunDamage@l(9)
	b .L480
.L483:
	lis 4,.LC123@ha
	addi 3,1,8
	la 4,.LC123@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L485
	mr 3,28
	bl atoi
	lis 9,ChaingunKick@ha
	stw 3,ChaingunKick@l(9)
	b .L480
.L485:
	lis 4,.LC124@ha
	addi 3,1,8
	la 4,.LC124@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L487
	mr 3,28
	bl atoi
	lis 9,ShotgunDamage@ha
	stw 3,ShotgunDamage@l(9)
	b .L480
.L487:
	lis 4,.LC125@ha
	addi 3,1,8
	la 4,.LC125@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L489
	mr 3,28
	bl atoi
	lis 9,ShotgunKick@ha
	stw 3,ShotgunKick@l(9)
	b .L480
.L489:
	lis 4,.LC126@ha
	addi 3,1,8
	la 4,.LC126@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L491
	mr 3,28
	bl atoi
	lis 9,SuperShotgunDamage@ha
	stw 3,SuperShotgunDamage@l(9)
	b .L480
.L491:
	lis 4,.LC127@ha
	addi 3,1,8
	la 4,.LC127@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L493
	mr 3,28
	bl atoi
	lis 9,SuperShotgunKick@ha
	stw 3,SuperShotgunKick@l(9)
	b .L480
.L493:
	lis 4,.LC128@ha
	addi 3,1,8
	la 4,.LC128@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L495
	mr 3,28
	bl atoi
	lis 9,fastrailgun@ha
	stw 3,fastrailgun@l(9)
	b .L480
.L495:
	lis 4,.LC129@ha
	addi 3,1,8
	la 4,.LC129@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L497
	mr 3,28
	bl atoi
	lis 9,RailgunDamage@ha
	stw 3,RailgunDamage@l(9)
	b .L480
.L497:
	lis 4,.LC130@ha
	addi 3,1,8
	la 4,.LC130@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L499
	mr 3,28
	bl atoi
	lis 9,RailgunKick@ha
	stw 3,RailgunKick@l(9)
	b .L480
.L499:
	lis 4,.LC131@ha
	addi 3,1,8
	la 4,.LC131@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L501
	mr 3,28
	bl atoi
	lis 9,BFGDamage@ha
	stw 3,BFGDamage@l(9)
	b .L480
.L501:
	lis 4,.LC132@ha
	addi 3,1,8
	la 4,.LC132@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L503
	mr 3,28
	lis 29,BFGDamageRadius@ha
	bl atof
	frsp 1,1
	stfs 1,BFGDamageRadius@l(29)
	b .L480
.L503:
	lis 4,.LC133@ha
	addi 3,1,8
	la 4,.LC133@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L480
	mr 3,28
	bl atoi
	lis 9,BFGProjectileSpeed@ha
	stw 3,BFGProjectileSpeed@l(9)
.L480:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe15:
	.size	 parseGuns,.Lfe15-parseGuns
	.section	".rodata"
	.align 2
.LC134:
	.string	"GlobalFragLimit"
	.align 2
.LC135:
	.string	"GlobalTimeLimit"
	.align 2
.LC136:
	.string	"GlobalGravity"
	.section	".text"
	.align 2
	.globl parseLevelChange
	.type	 parseLevelChange,@function
parseLevelChange:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 30,3
	addi 28,1,40
	li 29,0
	bl strlen
	lbz 0,0(30)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L508
	mr 11,10
.L509:
	lbzx 0,30,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,30,9
	cmpwi 0,0,61
	bc 4,2,.L509
.L508:
	li 0,0
	addi 31,9,1
	stbx 0,10,9
	b .L511
.L514:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,28,29
	addi 29,29,1
.L511:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L514
	addi 0,29,-1
	li 9,0
	lis 4,.LC134@ha
	stbx 9,28,0
	addi 3,1,8
	la 4,.LC134@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L516
	lis 3,GlobalFragLimit@ha
	mr 4,28
	la 3,GlobalFragLimit@l(3)
	bl strcpy
	b .L517
.L516:
	lis 4,.LC135@ha
	addi 3,1,8
	la 4,.LC135@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L518
	lis 3,GlobalTimeLimit@ha
	mr 4,28
	la 3,GlobalTimeLimit@l(3)
	bl strcpy
	b .L517
.L518:
	lis 4,.LC136@ha
	addi 3,1,8
	la 4,.LC136@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L517
	lis 3,GlobalGravity@ha
	mr 4,28
	la 3,GlobalGravity@l(3)
	bl strcpy
.L517:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe16:
	.size	 parseLevelChange,.Lfe16-parseLevelChange
	.section	".rodata"
	.align 2
.LC137:
	.string	"QWStyleLogging"
	.align 2
.LC138:
	.string	"Dir"
	.section	".text"
	.align 2
	.globl parseLogging
	.type	 parseLogging,@function
parseLogging:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 30,3
	addi 28,1,40
	li 29,0
	bl strlen
	lbz 0,0(30)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L523
	mr 11,10
.L524:
	lbzx 0,30,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,30,9
	cmpwi 0,0,61
	bc 4,2,.L524
.L523:
	li 0,0
	addi 31,9,1
	stbx 0,10,9
	b .L526
.L529:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,28,29
	addi 29,29,1
.L526:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L529
	addi 0,29,-1
	li 9,0
	lis 4,.LC137@ha
	stbx 9,28,0
	addi 3,1,8
	la 4,.LC137@l(4)
	bl strcmp
	mr. 31,3
	bc 4,2,.L531
	mr 3,28
	bl atoi
	cmpwi 0,3,0
	lis 9,QWLOG@ha
	stw 3,QWLOG@l(9)
	bc 12,2,.L532
	lis 3,recordLOG@ha
	mr 4,28
	la 3,recordLOG@l(3)
	bl strcpy
.L532:
	lis 9,recordLOG+1@ha
	stb 31,recordLOG+1@l(9)
	b .L533
.L531:
	lis 4,.LC138@ha
	addi 3,1,8
	la 4,.LC138@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L533
	lis 3,directory@ha
	mr 4,28
	la 3,directory@l(3)
	bl strcpy
.L533:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe17:
	.size	 parseLogging,.Lfe17-parseLogging
	.align 2
	.globl parseServObits
	.type	 parseServObits,@function
parseServObits:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 30,3
	addi 28,1,40
	li 29,0
	bl strlen
	lbz 0,0(30)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L71
	mr 11,10
.L72:
	lbzx 0,30,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,30,9
	cmpwi 0,0,61
	bc 4,2,.L72
.L71:
	li 0,0
	addi 31,9,1
	stbx 0,10,9
	b .L74
.L77:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,28,29
	addi 29,29,1
.L74:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L77
	addi 0,29,-1
	li 9,0
	lis 4,.LC22@ha
	stbx 9,28,0
	addi 3,1,8
	la 4,.LC22@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L79
	lis 3,ModelGenDir@ha
	mr 4,28
	la 3,ModelGenDir@l(3)
	bl strcpy
	b .L80
.L79:
	lis 4,.LC23@ha
	addi 3,1,8
	la 4,.LC23@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L80
	lis 3,obitsDir@ha
	mr 4,28
	la 3,obitsDir@l(3)
	bl strcpy
.L80:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe18:
	.size	 parseServObits,.Lfe18-parseServObits
	.align 2
	.globl parseHealth
	.type	 parseHealth,@function
parseHealth:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 30,3
	addi 28,1,40
	li 29,0
	bl strlen
	lbz 0,0(30)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L254
	mr 11,10
.L255:
	lbzx 0,30,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,30,9
	cmpwi 0,0,61
	bc 4,2,.L255
.L254:
	li 0,0
	addi 31,9,1
	stbx 0,10,9
	b .L257
.L260:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,28,29
	addi 29,29,1
.L257:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L260
	li 0,0
	lis 4,.LC73@ha
	stbx 0,28,29
	la 4,.LC73@l(4)
	addi 3,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L262
	mr 3,28
	bl atoi
	lis 9,CF_StartHealth@ha
	stw 3,CF_StartHealth@l(9)
	b .L263
.L262:
	lis 4,.LC74@ha
	addi 3,1,8
	la 4,.LC74@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L263
	mr 3,28
	bl atoi
	lis 9,CF_MaxHealth@ha
	stw 3,CF_MaxHealth@l(9)
.L263:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe19:
	.size	 parseHealth,.Lfe19-parseHealth
	.align 2
	.globl parseQuad
	.type	 parseQuad,@function
parseQuad:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 30,3
	addi 28,1,40
	li 29,0
	bl strlen
	lbz 0,0(30)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L388
	mr 11,10
.L389:
	lbzx 0,30,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,30,9
	cmpwi 0,0,61
	bc 4,2,.L389
.L388:
	li 0,0
	addi 31,9,1
	stbx 0,10,9
	b .L391
.L394:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,28,29
	addi 29,29,1
.L391:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L394
	li 0,0
	lis 4,.LC105@ha
	stbx 0,28,29
	la 4,.LC105@l(4)
	addi 3,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L396
	mr 3,28
	bl atoi
	lis 9,Q_Killer@ha
	stw 3,Q_Killer@l(9)
	b .L397
.L396:
	lis 4,.LC106@ha
	addi 3,1,8
	la 4,.LC106@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L397
	mr 3,28
	bl atoi
	lis 9,Q_Killee@ha
	stw 3,Q_Killee@l(9)
.L397:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe20:
	.size	 parseQuad,.Lfe20-parseQuad
	.align 2
	.globl parseLostQuad
	.type	 parseLostQuad,@function
parseLostQuad:
	stwu 1,-192(1)
	mflr 0
	stmw 28,176(1)
	stw 0,196(1)
	mr 30,3
	addi 28,1,40
	li 29,0
	bl strlen
	lbz 0,0(30)
	addi 10,1,8
	li 9,0
	cmpwi 0,0,61
	bc 12,2,.L241
	mr 11,10
.L242:
	lbzx 0,30,9
	stbx 0,11,9
	addi 9,9,1
	lbzx 0,30,9
	cmpwi 0,0,61
	bc 4,2,.L242
.L241:
	li 0,0
	addi 31,9,1
	stbx 0,10,9
	b .L244
.L247:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,28,29
	addi 29,29,1
.L244:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L247
	li 0,0
	lis 4,.LC71@ha
	stbx 0,28,29
	la 4,.LC71@l(4)
	addi 3,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L249
	mr 3,28
	bl atoi
	lis 9,LoseQ@ha
	stw 3,LoseQ@l(9)
	b .L250
.L249:
	lis 4,.LC72@ha
	addi 3,1,8
	la 4,.LC72@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L250
	mr 3,28
	bl atoi
	lis 9,LoseQ_Fragee@ha
	stw 3,LoseQ_Fragee@l(9)
.L250:
	lwz 0,196(1)
	mtlr 0
	lmw 28,176(1)
	la 1,192(1)
	blr
.Lfe21:
	.size	 parseLostQuad,.Lfe21-parseLostQuad
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
	.comm	highscore,1080,4
	.comm	gamescore,540,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
