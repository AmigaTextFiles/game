	.file	"e_game.c"
gcc2_compiled.:
	.globl gProperties
	.section	".sdata","aw"
	.align 2
	.type	 gProperties,@object
	.size	 gProperties,4
gProperties:
	.long 0
	.globl e_bits
	.section	".data"
	.type	 e_bits,@object
	.size	 e_bits,475
e_bits:
	.string	"expert weapons"
	.space	10
	.string	"balanced items"
	.space	10
	.string	"free gear"
	.space	15
	.string	"powerups"
	.space	16
	.string	"no powerups"
	.space	13
	.string	"expert hook"
	.space	13
	.string	"no hacks"
	.space	16
	.string	"playerid"
	.space	16
	.string	"enforced teams"
	.space	10
	.string	"fair teams"
	.space	14
	.string	"no team switch"
	.space	10
	.string	"pogo"
	.space	20
	.string	"slow hook"
	.space	15
	.string	"sky solid"
	.space	15
	.string	"no plats"
	.space	16
	.string	"ctf team distribution"
	.space	3
	.string	"alternate restore"
	.space	7
	.string	"ammo regen"
	.space	14
	.space	25
	.section	".rodata"
	.align 2
.LC0:
	.string	"expflags"
	.align 2
.LC1:
	.string	"0"
	.align 2
.LC2:
	.string	"utilflags"
	.align 2
.LC3:
	.string	"arenaflags"
	.align 2
.LC4:
	.string	"lethality"
	.align 2
.LC5:
	.string	"1"
	.align 2
.LC6:
	.string	"pace"
	.align 2
.LC7:
	.string	"numteams"
	.align 2
.LC8:
	.string	"cycle"
	.align 2
.LC9:
	.string	""
	.align 2
.LC10:
	.string	"giblog"
	.align 2
.LC11:
	.string	"gibstats.log"
	.align 2
.LC12:
	.string	"botaction"
	.align 2
.LC13:
	.string	"kick"
	.align 2
.LC14:
	.string	"expert"
	.align 2
.LC15:
	.string	"3.2"
	.align 2
.LC16:
	.string	"mode"
	.align 2
.LC17:
	.string	"deathmatch"
	.align 2
.LC18:
	.string	"game"
	.align 2
.LC19:
	.string	"ctf"
	.align 2
.LC20:
	.string	"capturelimit"
	.align 2
.LC21:
	.string	"7"
	.align 2
.LC22:
	.string	"flagtrack"
	.align 2
.LC23:
	.string	"sv_paused"
	.align 2
.LC24:
	.string	"forwardAddress"
	.align 2
.LC25:
	.string	"127.0.0.1"
	.align 2
.LC26:
	.string	"forwardMessage"
	.align 2
.LC27:
	.string	"This server is full.  You are being forwarded to another server"
	.section	".text"
	.align 2
	.globl ExpertGameInits
	.type	 ExpertGameInits,@function
ExpertGameInits:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 29,gi@ha
	lis 28,.LC1@ha
	la 29,gi@l(29)
	lis 3,.LC0@ha
	lwz 9,144(29)
	la 4,.LC1@l(28)
	li 5,4
	la 3,.LC0@l(3)
	lis 27,.LC5@ha
	mtlr 9
	lis 26,.LC9@ha
	blrl
	lwz 10,144(29)
	lis 9,sv_expflags@ha
	lis 11,.LC2@ha
	stw 3,sv_expflags@l(9)
	la 4,.LC1@l(28)
	li 5,4
	mtlr 10
	la 3,.LC2@l(11)
	blrl
	lwz 10,144(29)
	lis 9,sv_utilflags@ha
	lis 11,.LC3@ha
	stw 3,sv_utilflags@l(9)
	la 4,.LC1@l(28)
	li 5,4
	mtlr 10
	la 3,.LC3@l(11)
	blrl
	lwz 10,144(29)
	lis 9,sv_arenaflags@ha
	lis 11,.LC4@ha
	stw 3,sv_arenaflags@l(9)
	la 4,.LC5@l(27)
	li 5,4
	mtlr 10
	la 3,.LC4@l(11)
	blrl
	lwz 10,144(29)
	lis 9,sv_lethality@ha
	lis 11,.LC6@ha
	stw 3,sv_lethality@l(9)
	la 4,.LC5@l(27)
	li 5,4
	mtlr 10
	la 3,.LC6@l(11)
	blrl
	lwz 10,144(29)
	lis 9,sv_pace@ha
	lis 11,.LC7@ha
	stw 3,sv_pace@l(9)
	la 4,.LC1@l(28)
	li 5,4
	mtlr 10
	la 3,.LC7@l(11)
	blrl
	lwz 10,144(29)
	lis 9,sv_numteams@ha
	lis 11,.LC8@ha
	stw 3,sv_numteams@l(9)
	la 4,.LC9@l(26)
	li 5,4
	mtlr 10
	la 3,.LC8@l(11)
	blrl
	lwz 10,144(29)
	lis 9,levelCycle@ha
	lis 11,.LC10@ha
	stw 3,levelCycle@l(9)
	lis 4,.LC11@ha
	li 5,0
	la 4,.LC11@l(4)
	mtlr 10
	la 3,.LC10@l(11)
	blrl
	lwz 10,144(29)
	lis 9,sv_giblog@ha
	lis 11,.LC12@ha
	stw 3,sv_giblog@l(9)
	lis 4,.LC13@ha
	li 5,0
	la 4,.LC13@l(4)
	mtlr 10
	la 3,.LC12@l(11)
	blrl
	lwz 10,144(29)
	lis 9,botaction@ha
	lis 11,.LC14@ha
	stw 3,botaction@l(9)
	lis 4,.LC15@ha
	li 5,12
	mtlr 10
	la 3,.LC14@l(11)
	la 4,.LC15@l(4)
	blrl
	lwz 9,144(29)
	lis 3,.LC16@ha
	lis 4,.LC17@ha
	la 4,.LC17@l(4)
	li 5,4
	mtlr 9
	la 3,.LC16@l(3)
	blrl
	lwz 9,144(29)
	lis 3,.LC18@ha
	la 4,.LC9@l(26)
	li 5,8
	la 3,.LC18@l(3)
	mtlr 9
	blrl
	lwz 10,144(29)
	lis 9,gamedir@ha
	lis 11,.LC19@ha
	stw 3,gamedir@l(9)
	la 4,.LC1@l(28)
	li 5,4
	mtlr 10
	la 3,.LC19@l(11)
	blrl
	lwz 10,144(29)
	lis 9,ctf@ha
	lis 11,.LC20@ha
	stw 3,ctf@l(9)
	lis 4,.LC21@ha
	li 5,4
	mtlr 10
	la 4,.LC21@l(4)
	la 3,.LC20@l(11)
	blrl
	lwz 10,144(29)
	lis 9,capturelimit@ha
	lis 11,.LC22@ha
	stw 3,capturelimit@l(9)
	la 4,.LC1@l(28)
	li 5,4
	mtlr 10
	la 3,.LC22@l(11)
	blrl
	lwz 10,144(29)
	lis 9,flagtrack@ha
	lis 11,.LC23@ha
	stw 3,flagtrack@l(9)
	la 4,.LC1@l(28)
	li 5,4
	mtlr 10
	la 3,.LC23@l(11)
	blrl
	lwz 10,144(29)
	lis 9,sv_paused@ha
	lis 11,.LC24@ha
	stw 3,sv_paused@l(9)
	lis 4,.LC25@ha
	li 5,0
	mtlr 10
	la 4,.LC25@l(4)
	la 3,.LC24@l(11)
	blrl
	lwz 0,144(29)
	lis 9,forwardAddress@ha
	lis 11,.LC26@ha
	stw 3,forwardAddress@l(9)
	lis 4,.LC27@ha
	li 5,0
	la 4,.LC27@l(4)
	la 3,.LC26@l(11)
	mtlr 0
	blrl
	lis 9,forwardMessage@ha
	stw 3,forwardMessage@l(9)
	bl newProps
	lis 9,gProperties@ha
	stw 3,gProperties@l(9)
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 ExpertGameInits,.Lfe1-ExpertGameInits
	.section	".rodata"
	.align 2
.LC28:
	.string	"exec %s/eachlev.cfg\n"
	.align 2
.LC29:
	.string	"\n"
	.align 2
.LC30:
	.string	"exec %s/%s.cfg\n"
	.align 2
.LC31:
	.string	"exec eachlev.cfg\n"
	.align 2
.LC32:
	.string	"exec %s.cfg\n"
	.section	".text"
	.align 2
	.globl ExpertLevelScripting
	.type	 ExpertLevelScripting,@function
ExpertLevelScripting:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 31,levelCycle@ha
	mr 30,3
	lwz 9,levelCycle@l(31)
	lwz 3,4(9)
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L8
	lwz 9,levelCycle@l(31)
	lis 29,gi@ha
	lis 3,.LC28@ha
	la 29,gi@l(29)
	la 3,.LC28@l(3)
	lwz 4,4(9)
	lis 28,.LC29@ha
	crxor 6,6,6
	bl va
	lwz 9,168(29)
	mtlr 9
	blrl
	lwz 9,168(29)
	la 3,.LC29@l(28)
	mtlr 9
	blrl
	lwz 9,levelCycle@l(31)
	lis 3,.LC30@ha
	mr 5,30
	la 3,.LC30@l(3)
	lwz 4,4(9)
	crxor 6,6,6
	bl va
	lwz 9,168(29)
	mtlr 9
	blrl
	lwz 0,168(29)
	la 3,.LC29@l(28)
	mtlr 0
	blrl
	b .L9
.L8:
	lwz 9,levelCycle@l(31)
	lis 29,gi@ha
	lis 3,.LC31@ha
	la 29,gi@l(29)
	la 3,.LC31@l(3)
	lwz 4,4(9)
	lis 28,.LC29@ha
	crxor 6,6,6
	bl va
	lwz 9,168(29)
	mtlr 9
	blrl
	lwz 9,168(29)
	la 3,.LC29@l(28)
	mtlr 9
	blrl
	lwz 9,levelCycle@l(31)
	lis 3,.LC32@ha
	mr 5,30
	la 3,.LC32@l(3)
	lwz 4,4(9)
	crxor 6,6,6
	bl va
	lwz 9,168(29)
	mtlr 9
	blrl
	lwz 0,168(29)
	la 3,.LC29@l(28)
	mtlr 0
	blrl
.L9:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 ExpertLevelScripting,.Lfe2-ExpertLevelScripting
	.section	".rodata"
	.align 2
.LC33:
	.string	"Shells"
	.align 2
.LC34:
	.string	"Bullets"
	.align 2
.LC35:
	.string	"Grenades"
	.align 2
.LC36:
	.string	"Rockets"
	.align 2
.LC37:
	.string	"Slugs"
	.align 2
.LC38:
	.string	"Cells"
	.align 2
.LC39:
	.string	"arena"
	.align 2
.LC40:
	.string	"teamplay"
	.align 2
.LC41:
	.long 0x0
	.section	".text"
	.align 2
	.globl ExpertLevelInits
	.type	 ExpertLevelInits,@function
ExpertLevelInits:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 23,36(1)
	stw 0,84(1)
	lis 3,.LC33@ha
	lis 28,0x38e3
	la 3,.LC33@l(3)
	ori 28,28,36409
	bl FindItem
	lis 27,bullet_index@ha
	lis 26,grenade_index@ha
	lis 29,itemlist@ha
	lis 11,shell_index@ha
	la 29,itemlist@l(29)
	lis 9,.LC34@ha
	subf 0,29,3
	lis 25,rocket_index@ha
	mullw 0,0,28
	la 3,.LC34@l(9)
	lis 24,slug_index@ha
	lis 23,cell_index@ha
	srawi 0,0,3
	stw 0,shell_index@l(11)
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC35@ha
	la 3,.LC35@l(3)
	srawi 0,0,3
	stw 0,bullet_index@l(27)
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC36@ha
	la 3,.LC36@l(3)
	srawi 0,0,3
	stw 0,grenade_index@l(26)
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	srawi 0,0,3
	stw 0,rocket_index@l(25)
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC38@ha
	la 3,.LC38@l(3)
	srawi 0,0,3
	stw 0,slug_index@l(24)
	bl FindItem
	lis 11,.LC41@ha
	lis 9,ctf@ha
	la 11,.LC41@l(11)
	subf 3,29,3
	lfs 13,0(11)
	mullw 3,3,28
	lwz 11,ctf@l(9)
	srawi 3,3,3
	lfs 0,20(11)
	stw 3,cell_index@l(23)
	fcmpu 0,0,13
	bc 12,2,.L11
	lis 9,gametype@ha
	li 0,3
	b .L35
.L11:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,192
	bc 12,2,.L13
	lis 9,gametype@ha
	li 0,2
	b .L35
.L13:
	lis 9,gametype@ha
	li 0,1
.L35:
	stw 0,gametype@l(9)
	lis 9,gametype@ha
	lis 11,gi@ha
	lwz 0,gametype@l(9)
	la 11,gi@l(11)
	cmpwi 0,0,3
	bc 12,2,.L15
	cmpwi 0,0,2
	bc 12,2,.L17
	cmpwi 0,0,4
	bc 4,2,.L19
	lis 9,.LC39@ha
	la 4,.LC39@l(9)
	b .L16
.L19:
	lis 9,.LC17@ha
	la 4,.LC17@l(9)
	b .L16
.L17:
	lis 9,.LC40@ha
	la 4,.LC40@l(9)
	b .L16
.L15:
	lis 9,.LC19@ha
	la 4,.LC19@l(9)
.L16:
	lwz 0,148(11)
	lis 3,.LC16@ha
	lis 29,sv_utilflags@ha
	la 3,.LC16@l(3)
	mtlr 0
	blrl
	lis 9,game@ha
	li 10,0
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,10,0
	bc 4,0,.L23
	mr 8,9
	li 7,2
	li 11,0
.L25:
	lwz 9,1028(8)
	addi 10,10,1
	add 9,11,9
	stw 7,724(9)
	addi 11,11,4596
	lwz 0,1544(8)
	cmpw 0,10,0
	bc 12,0,.L25
.L23:
	lis 11,.LC41@ha
	lis 9,ctf@ha
	la 11,.LC41@l(11)
	lfs 31,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L27
	bl CTFInit
.L27:
	lis 9,flagtrack@ha
	lwz 11,flagtrack@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L28
	bl FlagTrackInit
.L28:
	lis 10,sv_arenaflags@ha
	lwz 9,sv_arenaflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1
	bc 12,2,.L29
	bl arenaInitLevel
.L29:
	bl teamplayEnabled
	cmpwi 0,3,0
	bc 12,2,.L30
	bl loadTeams
.L30:
	lis 10,sv_utilflags@ha
	lwz 9,sv_utilflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8
	bc 4,2,.L31
	bl InitMOTD
.L31:
	lwz 11,sv_utilflags@l(29)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	andi. 0,9,2
	bc 4,2,.L32
	bl InitExpertObituary
.L32:
	bl teamplayEnabled
	cmpwi 0,3,0
	bc 12,2,.L33
	bl InitTeamAudio
.L33:
	lwz 11,sv_utilflags@l(29)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	andi. 0,9,1
	bc 12,2,.L34
	bl gsStopLogging
	bl gsStartLogging
	bl gsLogLevelStart
	bl gsEnumConnectedClients
.L34:
	lwz 0,84(1)
	mtlr 0
	lmw 23,36(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe3:
	.size	 ExpertLevelInits,.Lfe3-ExpertLevelInits
	.section	".rodata"
	.align 2
.LC42:
	.string	"alias help \"cmd motd\";alias settings \"cmd settings\";\n"
	.align 2
.LC43:
	.string	"alias motd \"cmd motd\";alias serverhelp \"cmd motd\";\n"
	.align 2
.LC44:
	.string	"alias back \"-attack;cmd weaplast\";\n"
	.align 2
.LC45:
	.string	"alias +sg \"use shotgun;+attack\";alias -sg back;\n"
	.align 2
.LC46:
	.string	"alias +ssg \"use super shotgun;+attack\";alias -ssg back;\n"
	.align 2
.LC47:
	.string	"alias +mg \"use machinegun;+attack\";alias -mg back;\n"
	.align 2
.LC48:
	.string	"alias +cg \"use chaingun;+attack\";alias -cg back;\n"
	.align 2
.LC49:
	.string	"alias +gl \"use grenade launcher;+attack\";alias -gl back;\n"
	.align 2
.LC50:
	.string	"alias +rl \"use rocket launcher;+attack\";alias -rl back;\n"
	.align 2
.LC51:
	.string	"alias +hb \"use hyperblaster;+attack\";alias -hb back;\n"
	.align 2
.LC52:
	.string	"alias +rg \"use railgun;+attack\";alias -rg back;\n"
	.align 2
.LC53:
	.string	"alias +bfg \"use bfg10k;+attack\";alias -bfg back;\n"
	.align 2
.LC54:
	.string	"alias +hg \"use grenades;+attack\";alias -hg back;\n"
	.align 2
.LC55:
	.string	"exec expauto.cfg\n"
	.align 2
.LC56:
	.string	"%s\nConnecting you to %s\n"
	.align 2
.LC57:
	.string	"\nconnect %s\n"
	.align 2
.LC58:
	.string	"alias +hook +use; alias -hook -use;\n"
	.align 2
.LC59:
	.string	"alias +pogo +use; alias -pogo -use;\n"
	.section	".text"
	.align 2
	.globl ExpertPlayerLevelInits
	.type	 ExpertPlayerLevelInits,@function
ExpertPlayerLevelInits:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	li 0,1
	lwz 11,84(31)
	li 10,0
	stw 0,724(11)
	lwz 9,84(31)
	stw 0,3588(9)
	lwz 11,84(31)
	stw 10,3600(11)
	bl clearFloodSamples
	lis 10,sv_utilflags@ha
	lwz 9,sv_utilflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8
	bc 4,2,.L40
	mr 3,31
	bl DisplayMOTD
.L40:
	lis 9,sv_utilflags@ha
	lwz 11,sv_utilflags@l(9)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	andi. 0,9,64
	bc 12,2,.L41
	lwz 9,84(31)
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 12,2,.L41
	lis 9,forwardMessage@ha
	lis 10,gi+8@ha
	lwz 11,forwardMessage@l(9)
	lis 29,forwardAddress@ha
	lis 5,.LC56@ha
	lwz 9,forwardAddress@l(29)
	mr 3,31
	la 5,.LC56@l(5)
	lwz 0,gi+8@l(10)
	li 4,2
	lwz 7,4(9)
	lwz 6,4(11)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,forwardAddress@l(29)
	lis 3,.LC57@ha
	la 3,.LC57@l(3)
	lwz 4,4(9)
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,31
	bl StuffCmd
	b .L42
.L41:
	lis 4,.LC58@ha
	mr 3,31
	la 4,.LC58@l(4)
	bl StuffCmd
	lis 4,.LC59@ha
	mr 3,31
	la 4,.LC59@l(4)
	bl StuffCmd
.L42:
	bl teamplayEnabled
	cmpwi 0,3,0
	bc 12,2,.L43
	mr 3,31
	bl assignTeam
.L43:
	lis 10,sv_utilflags@ha
	lwz 9,sv_utilflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1
	bc 12,2,.L44
	mr 3,31
	bl gsLogClientConnect
.L44:
	lis 10,sv_arenaflags@ha
	lwz 9,sv_arenaflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1
	bc 12,2,.L45
	mr 3,31
	bl arenaConnect
.L45:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 ExpertPlayerLevelInits,.Lfe4-ExpertPlayerLevelInits
	.section	".rodata"
	.align 2
.LC60:
	.string	"weapon"
	.align 2
.LC61:
	.string	"ammo"
	.align 2
.LC62:
	.string	"item_power"
	.align 2
.LC63:
	.string	"item_quad"
	.align 2
.LC64:
	.string	"item_invulnerability"
	.align 2
.LC65:
	.string	"item_armor"
	.align 2
.LC66:
	.string	"item_health"
	.align 2
.LC67:
	.string	"item_ancient_head"
	.align 2
.LC68:
	.string	"item_adrenaline"
	.align 2
.LC69:
	.string	"func_plat"
	.align 2
.LC70:
	.string	"weapon_bfg"
	.align 2
.LC71:
	.string	"weapon_supershotgun"
	.align 2
.LC72:
	.string	"info_player_red"
	.align 2
.LC73:
	.string	"info_player_team1"
	.align 2
.LC74:
	.string	"info_player_blue"
	.align 2
.LC75:
	.string	"info_player_team2"
	.align 2
.LC76:
	.string	"info_flag_red"
	.align 2
.LC77:
	.string	"info_flag_team1"
	.align 2
.LC78:
	.string	"info_flag_blue"
	.align 2
.LC79:
	.string	"info_flag_team2"
	.section	".text"
	.align 2
	.globl ExpertInhibit
	.type	 ExpertInhibit,@function
ExpertInhibit:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 3,280(31)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L59
	lis 9,gProperties@ha
	lwz 4,40(3)
	lwz 3,gProperties@l(9)
	bl getProp
	cmpwi 0,3,0
	bc 4,2,.L77
.L59:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,4
	bc 12,2,.L60
	lwz 3,280(31)
	lis 4,.LC60@ha
	la 4,.LC60@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L77
.L60:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 0,11,2
	bc 12,2,.L61
	lwz 3,280(31)
	lis 4,.LC61@ha
	la 4,.LC61@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L77
.L61:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,16
	bc 12,2,.L62
	lwz 3,280(31)
	lis 4,.LC62@ha
	la 4,.LC62@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L77
	lwz 3,280(31)
	lis 4,.LC63@ha
	la 4,.LC63@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L77
	lwz 3,280(31)
	lis 4,.LC64@ha
	la 4,.LC64@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L77
.L62:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 0,11,1
	bc 12,2,.L64
	lwz 3,280(31)
	lis 4,.LC65@ha
	la 4,.LC65@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L77
	lwz 3,280(31)
	lis 4,.LC66@ha
	la 4,.LC66@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L77
	lwz 3,280(31)
	lis 4,.LC67@ha
	la 4,.LC67@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L77
	lwz 3,280(31)
	lis 4,.LC68@ha
	la 4,.LC68@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L77
.L64:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,16384
	bc 12,2,.L66
	lwz 3,280(31)
	lis 4,.LC69@ha
	la 4,.LC69@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L66
.L77:
	li 3,1
	b .L76
.L66:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L67
	lwz 3,280(31)
	lis 4,.LC70@ha
	la 4,.LC70@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L67
	lis 9,.LC71@ha
	la 9,.LC71@l(9)
	stw 9,280(31)
.L67:
	lwz 3,280(31)
	lis 4,.LC72@ha
	la 4,.LC72@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L69
	lis 9,.LC73@ha
	la 9,.LC73@l(9)
	b .L78
.L69:
	lwz 3,280(31)
	lis 4,.LC74@ha
	la 4,.LC74@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L71
	lis 9,.LC75@ha
	la 9,.LC75@l(9)
	b .L78
.L71:
	lwz 3,280(31)
	lis 4,.LC76@ha
	la 4,.LC76@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L73
	lis 9,.LC77@ha
	la 9,.LC77@l(9)
	b .L78
.L73:
	lwz 3,280(31)
	lis 4,.LC78@ha
	la 4,.LC78@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L70
	lis 9,.LC79@ha
	la 9,.LC79@l(9)
.L78:
	stw 9,280(31)
.L70:
	li 3,0
.L76:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 ExpertInhibit,.Lfe5-ExpertInhibit
	.section	".rodata"
	.align 2
.LC80:
	.string	"Vampirism"
	.align 2
.LC81:
	.string	"Mutant Jump"
	.align 2
.LC82:
	.string	"item_power_shield"
	.align 2
.LC83:
	.string	"Inertial Screen"
	.align 2
.LC84:
	.string	"Body Armor"
	.align 2
.LC85:
	.string	"Combat Armor"
	.align 2
.LC86:
	.string	"Jacket Armor"
	.section	".text"
	.align 2
	.globl ExpertItemListChanges
	.type	 ExpertItemListChanges,@function
ExpertItemListChanges:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 31,sv_expflags@ha
	lwz 9,sv_expflags@l(31)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8
	bc 12,2,.L80
	lis 3,.LC63@ha
	la 3,.LC63@l(3)
	bl FindItemByClassname
	lis 9,.LC80@ha
	lis 11,.LC64@ha
	la 9,.LC80@l(9)
	lis 29,itemlist@ha
	stw 9,40(3)
	la 29,itemlist@l(29)
	la 3,.LC64@l(11)
	addi 28,29,40
	bl FindItemByClassname
	lis 9,.LC81@ha
	subf 3,29,3
	la 9,.LC81@l(9)
	stwx 9,28,3
.L80:
	lwz 11,sv_expflags@l(31)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	andi. 0,9,2
	bc 12,2,.L81
	lis 3,.LC82@ha
	la 3,.LC82@l(3)
	bl FindItemByClassname
	lis 9,.LC83@ha
	la 9,.LC83@l(9)
	stw 9,40(3)
.L81:
	lwz 11,sv_expflags@l(31)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	andi. 0,9,2
	bc 12,2,.L82
	lis 3,.LC84@ha
	la 3,.LC84@l(3)
	bl FindItem
	lis 9,balanced_bodyarmor_info@ha
	lis 11,.LC85@ha
	la 9,balanced_bodyarmor_info@l(9)
	lis 29,itemlist@ha
	stw 9,60(3)
	la 29,itemlist@l(29)
	la 3,.LC85@l(11)
	addi 28,29,60
	bl FindItem
	subf 0,29,3
	lis 9,balanced_combatarmor_info@ha
	la 9,balanced_combatarmor_info@l(9)
	lis 3,.LC86@ha
	stwx 9,28,0
	la 3,.LC86@l(3)
	bl FindItem
	lis 9,balanced_jacketarmor_info@ha
	subf 3,29,3
	la 9,balanced_jacketarmor_info@l(9)
	stwx 9,28,3
.L82:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 ExpertItemListChanges,.Lfe6-ExpertItemListChanges
	.section	".rodata"
	.align 2
.LC87:
	.string	"!%d"
	.align 2
.LC89:
	.string	"Proxy bots not allowed."
	.align 2
.LC90:
	.string	"Appears to be using a bot"
	.align 2
.LC91:
	.string	"WARNING: Client %s appears to be using a bot;\n did not pass through stuffcmd prefixed with ! character\nIP is %s\n"
	.align 2
.LC92:
	.string	"ip"
	.align 2
.LC93:
	.long 0x46fffe00
	.align 3
.LC94:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC95:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl ExpertBotDetect
	.type	 ExpertBotDetect,@function
ExpertBotDetect:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 26,24(1)
	stw 0,68(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3600(9)
	andi. 11,0,1
	bc 4,2,.L85
	lwz 0,3596(9)
	cmpwi 0,0,4
	bc 4,1,.L87
	lis 4,.LC89@ha
	lis 5,.LC90@ha
	la 5,.LC90@l(5)
	la 4,.LC89@l(4)
	bl BootPlayer
	lwz 28,84(31)
	lis 29,gi@ha
	lis 4,.LC92@ha
	la 29,gi@l(29)
	la 4,.LC92@l(4)
	addi 3,28,188
	addi 28,28,700
	bl Info_ValueForKey
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC91@ha
	la 3,.LC91@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L87:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3592(11)
	fcmpu 0,13,0
	bc 12,0,.L85
	li 3,1
	li 29,0
	bl numberOfBitsSet
	mr 28,3
	cmplw 0,29,28
	bc 4,0,.L90
	lis 9,.LC93@ha
	li 26,1
	lfs 30,.LC93@l(9)
	lis 27,0x4330
	lis 30,.LC87@ha
	lis 9,.LC94@ha
	la 9,.LC94@l(9)
	lfd 31,0(9)
.L92:
	lwz 9,84(31)
	slw 11,26,29
	lwz 0,3600(9)
	and. 9,11,0
	bc 4,2,.L91
	cmpwi 0,11,1
	bc 4,2,.L91
	bl rand
	rlwinm 0,3,0,17,31
	xoris 0,0,0x8000
	la 3,.LC87@l(30)
	stw 0,20(1)
	stw 27,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 1,0
	creqv 6,6,6
	bl va
	mr 4,3
	mr 3,31
	bl StuffCmd
.L91:
	addi 29,29,1
	cmplw 0,29,28
	bc 12,0,.L92
.L90:
	lis 11,.LC95@ha
	lis 9,level+4@ha
	lwz 10,84(31)
	la 11,.LC95@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,3592(10)
	lwz 11,84(31)
	lwz 9,3596(11)
	addi 9,9,1
	stw 9,3596(11)
.L85:
	lwz 0,68(1)
	mtlr 0
	lmw 26,24(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe7:
	.size	 ExpertBotDetect,.Lfe7-ExpertBotDetect
	.section	".rodata"
	.align 2
.LC96:
	.string	"w_blaster"
	.align 2
.LC97:
	.string	"w_shotgun"
	.align 2
.LC98:
	.string	"w_sshotgun"
	.align 2
.LC99:
	.string	"w_machinegun"
	.align 2
.LC100:
	.string	"w_chaingun"
	.align 2
.LC101:
	.string	"a_grenades"
	.align 2
.LC102:
	.string	"w_glauncher"
	.align 2
.LC103:
	.string	"w_rlauncher"
	.align 2
.LC104:
	.string	"w_hyperblaster"
	.align 2
.LC105:
	.string	"w_railgun"
	.align 2
.LC106:
	.string	"w_bfg"
	.align 2
.LC107:
	.string	"w_grapple"
	.section	".text"
	.align 2
	.globl ShowGun
	.type	 ShowGun,@function
ShowGun:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 9,84(29)
	lwz 3,1792(9)
	cmpwi 0,3,0
	bc 4,2,.L98
	stw 3,44(29)
	b .L97
.L98:
	lwz 31,36(3)
	lis 4,.LC96@ha
	li 30,0
	la 4,.LC96@l(4)
	mr 3,31
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L99
	li 30,1
	b .L100
.L99:
	lis 4,.LC97@ha
	mr 3,31
	la 4,.LC97@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L101
	li 30,2
	b .L100
.L101:
	lis 4,.LC98@ha
	mr 3,31
	la 4,.LC98@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L103
	li 30,3
	b .L100
.L103:
	lis 4,.LC99@ha
	mr 3,31
	la 4,.LC99@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L105
	li 30,4
	b .L100
.L105:
	lis 4,.LC100@ha
	mr 3,31
	la 4,.LC100@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L107
	li 30,5
	b .L100
.L107:
	lis 4,.LC101@ha
	mr 3,31
	la 4,.LC101@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L109
	li 30,6
	b .L100
.L109:
	lis 4,.LC102@ha
	mr 3,31
	la 4,.LC102@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L111
	li 30,7
	b .L100
.L111:
	lis 4,.LC103@ha
	mr 3,31
	la 4,.LC103@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L113
	li 30,8
	b .L100
.L113:
	lis 4,.LC104@ha
	mr 3,31
	la 4,.LC104@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L115
	li 30,9
	b .L100
.L115:
	lis 4,.LC105@ha
	mr 3,31
	la 4,.LC105@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L117
	li 30,10
	b .L100
.L117:
	lis 4,.LC106@ha
	mr 3,31
	la 4,.LC106@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L119
	li 30,11
	b .L100
.L119:
	lis 4,.LC107@ha
	mr 3,31
	la 4,.LC107@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	nor 9,0,0
	and 0,30,0
	rlwinm 9,9,0,28,29
	or 30,0,9
.L100:
	lbz 0,63(29)
	slwi 11,30,8
	li 9,255
	stw 9,44(29)
	or 0,0,11
	stw 0,60(29)
.L97:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 ShowGun,.Lfe8-ShowGun
	.section	".rodata"
	.align 2
.LC108:
	.string	"Bad armor given to ShardPoints\n"
	.align 2
.LC110:
	.string	"Shotgun"
	.align 2
.LC111:
	.string	"Super Shotgun"
	.align 2
.LC112:
	.string	"Machinegun"
	.align 2
.LC113:
	.string	"Chaingun"
	.align 2
.LC114:
	.string	"Grenade Launcher"
	.align 2
.LC115:
	.string	"Rocket Launcher"
	.align 2
.LC116:
	.string	"HyperBlaster"
	.align 2
.LC117:
	.string	"Railgun"
	.section	".text"
	.align 2
	.globl giveFreeGear
	.type	 giveFreeGear,@function
giveFreeGear:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	lis 29,gProperties@ha
	lwz 3,gProperties@l(29)
	lis 31,.LC110@ha
	la 4,.LC110@l(31)
	bl getProp
	cmpwi 0,3,0
	bc 4,2,.L128
	la 3,.LC110@l(31)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	mullw 3,3,0
	addi 9,30,744
	li 0,1
	srawi 3,3,3
	slwi 3,3,2
	stwx 0,9,3
.L128:
	lwz 3,gProperties@l(29)
	lis 31,.LC111@ha
	addi 30,30,744
	la 4,.LC111@l(31)
	bl getProp
	cmpwi 0,3,0
	bc 4,2,.L129
	la 3,.LC111@l(31)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	li 11,1
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	stwx 11,30,3
.L129:
	lwz 3,gProperties@l(29)
	lis 31,.LC112@ha
	la 4,.LC112@l(31)
	bl getProp
	cmpwi 0,3,0
	bc 4,2,.L130
	la 3,.LC112@l(31)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	li 11,1
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	stwx 11,30,3
.L130:
	lwz 3,gProperties@l(29)
	lis 31,.LC113@ha
	la 4,.LC113@l(31)
	bl getProp
	cmpwi 0,3,0
	bc 4,2,.L131
	la 3,.LC113@l(31)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	li 11,1
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	stwx 11,30,3
.L131:
	lwz 3,gProperties@l(29)
	lis 31,.LC114@ha
	la 4,.LC114@l(31)
	bl getProp
	cmpwi 0,3,0
	bc 4,2,.L132
	la 3,.LC114@l(31)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	li 11,1
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	stwx 11,30,3
.L132:
	lwz 3,gProperties@l(29)
	lis 4,.LC115@ha
	la 4,.LC115@l(4)
	bl getProp
	cmpwi 0,3,0
	bc 4,2,.L133
	lis 3,.LC115@ha
	la 3,.LC115@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	li 11,1
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	stwx 11,30,3
.L133:
	lwz 3,gProperties@l(29)
	lis 31,.LC116@ha
	la 4,.LC116@l(31)
	bl getProp
	cmpwi 0,3,0
	bc 4,2,.L134
	la 3,.LC116@l(31)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	li 11,1
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	stwx 11,30,3
.L134:
	lwz 3,gProperties@l(29)
	lis 31,.LC117@ha
	la 4,.LC117@l(31)
	bl getProp
	cmpwi 0,3,0
	bc 4,2,.L135
	la 3,.LC117@l(31)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	li 11,1
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	stwx 11,30,3
.L135:
	lis 3,.LC33@ha
	lis 31,0x38e3
	la 3,.LC33@l(3)
	ori 31,31,36409
	bl FindItem
	li 28,5
	lis 9,itemlist@ha
	li 10,25
	la 29,itemlist@l(9)
	lis 11,.LC34@ha
	subf 0,29,3
	mullw 0,0,31
	la 3,.LC34@l(11)
	srawi 0,0,3
	slwi 0,0,2
	stwx 10,30,0
	bl FindItem
	subf 0,29,3
	li 9,100
	mullw 0,0,31
	lis 3,.LC38@ha
	la 3,.LC38@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 9,30,0
	bl FindItem
	subf 0,29,3
	li 9,40
	mullw 0,0,31
	lis 3,.LC35@ha
	la 3,.LC35@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 9,30,0
	bl FindItem
	subf 0,29,3
	mullw 0,0,31
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 28,30,0
	bl FindItem
	lis 11,sv_expflags@ha
	lwz 10,sv_expflags@l(11)
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	andi. 0,9,1
	bc 12,2,.L136
	subf 0,29,3
	li 9,15
	mullw 0,0,31
	srawi 0,0,3
	slwi 0,0,2
	stwx 9,30,0
	b .L137
.L136:
	subf 0,29,3
	mullw 0,0,31
	srawi 0,0,3
	slwi 0,0,2
	stwx 28,30,0
.L137:
	lis 3,.LC36@ha
	la 3,.LC36@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	subf 0,9,3
	li 10,10
	mullw 0,0,11
	lis 3,.LC115@ha
	la 3,.LC115@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 10,30,0
	bl FindItem
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 giveFreeGear,.Lfe9-giveFreeGear
	.section	".rodata"
	.align 3
.LC118:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC119:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl damageRestore
	.type	 damageRestore,@function
damageRestore:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	lwz 9,480(4)
	mr 31,3
	mr 29,5
	lwz 11,84(31)
	nor 0,9,9
	srawi 0,0,31
	subf 9,9,29
	andc 9,9,0
	cmpwi 0,11,0
	and 0,29,0
	or 30,0,9
	bc 12,2,.L143
	lwz 0,84(4)
	xor 9,31,4
	subfic 11,9,0
	adde 9,11,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L143
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L143
	bl onSameTeam
	cmpwi 0,3,0
	bc 4,2,.L143
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 0,11,1
	bc 12,2,.L147
	lwz 9,480(31)
	lwz 0,484(31)
	cmpw 0,9,0
	bc 4,0,.L147
	xoris 0,29,0x8000
	stw 0,20(1)
	lis 29,0x4330
	lis 11,.LC119@ha
	stw 29,16(1)
	la 11,.LC119@l(11)
	lfd 31,0(11)
	lfd 1,16(1)
	lis 11,.LC118@ha
	lfd 0,.LC118@l(11)
	fsub 1,1,31
	fmul 1,1,0
	bl ceil
	lwz 0,480(31)
	mr 11,9
	lwz 10,484(31)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	fadd 0,0,1
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	cmpw 0,11,10
	stw 11,480(31)
	bc 4,1,.L147
	stw 10,480(31)
.L147:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC119@ha
	lfs 12,3948(10)
	xoris 0,0,0x8000
	la 11,.LC119@l(11)
	stw 0,20(1)
	stw 8,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L143
	mr 10,9
	lis 11,sv_expflags@ha
	lwz 9,sv_expflags@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	andi. 9,0,8
	bc 12,2,.L143
	andis. 11,0,1
	bc 12,2,.L151
	lis 0,0x5555
	lwz 9,480(31)
	srawi 11,30,31
	ori 0,0,21846
	mulhw 0,30,0
	subf 0,11,0
	add 9,9,0
	cmpwi 0,9,210
	stw 9,480(31)
	bc 4,1,.L143
	li 0,210
	b .L155
.L151:
	srwi 0,30,31
	lwz 9,480(31)
	add 0,30,0
	srawi 0,0,1
	add 9,9,0
	cmpwi 0,9,180
	stw 9,480(31)
	bc 4,1,.L143
	li 0,180
.L155:
	stw 0,480(31)
.L143:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 damageRestore,.Lfe10-damageRestore
	.align 2
	.globl giveAmmo
	.type	 giveAmmo,@function
giveAmmo:
	stwu 1,-16(1)
	lis 9,shell_index@ha
	lwz 7,84(3)
	lwz 0,shell_index@l(9)
	addi 8,7,744
	slwi 11,0,2
	lwzx 9,8,11
	addi 9,9,2
	cmpwi 0,9,20
	stwx 9,8,11
	bc 4,1,.L157
	li 0,20
	stwx 0,8,11
.L157:
	lis 9,bullet_index@ha
	lwz 0,bullet_index@l(9)
	slwi 11,0,2
	lwzx 9,8,11
	addi 9,9,20
	cmpwi 0,9,200
	stwx 9,8,11
	bc 4,1,.L158
	li 0,200
	stwx 0,8,11
.L158:
	lis 9,grenade_index@ha
	lwz 0,grenade_index@l(9)
	slwi 11,0,2
	lwzx 9,8,11
	addi 9,9,1
	cmpwi 0,9,4
	stwx 9,8,11
	bc 4,1,.L159
	li 0,4
	stwx 0,8,11
.L159:
	lis 9,rocket_index@ha
	lwz 0,rocket_index@l(9)
	slwi 11,0,2
	lwzx 9,8,11
	addi 9,9,1
	cmpwi 0,9,12
	stwx 9,8,11
	bc 4,1,.L160
	li 0,12
	stwx 0,8,11
.L160:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 12,2,.L161
	lis 9,slug_index@ha
	lwz 0,slug_index@l(9)
	slwi 11,0,2
	lwzx 9,8,11
	addi 9,9,3
	cmpwi 0,9,18
	stwx 9,8,11
	bc 4,1,.L163
	li 0,18
	b .L166
.L161:
	lis 9,slug_index@ha
	lwz 0,slug_index@l(9)
	slwi 11,0,2
	lwzx 9,8,11
	addi 9,9,1
	cmpwi 0,9,6
	stwx 9,8,11
	bc 4,1,.L163
	li 0,6
.L166:
	stwx 0,8,11
.L163:
	lis 9,cell_index@ha
	addi 10,7,744
	lwz 0,cell_index@l(9)
	slwi 11,0,2
	lwzx 9,10,11
	addi 9,9,7
	cmpwi 0,9,80
	stwx 9,10,11
	bc 4,1,.L165
	li 0,80
	stwx 0,10,11
.L165:
	la 1,16(1)
	blr
.Lfe11:
	.size	 giveAmmo,.Lfe11-giveAmmo
	.section	".rodata"
	.align 2
.LC120:
	.string	"items/n_health.wav"
	.align 3
.LC121:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC122:
	.long 0x40400000
	.align 2
.LC123:
	.long 0x40000000
	.align 3
.LC124:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC125:
	.long 0x0
	.align 2
.LC126:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl regen
	.type	 regen,@function
regen:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L167
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andis. 0,11,2
	bc 12,2,.L169
	lwz 10,84(31)
	lis 8,0x4330
	lis 9,.LC121@ha
	lwz 0,4012(10)
	la 9,.LC121@l(9)
	lfd 12,0(9)
	lis 10,.LC122@ha
	xoris 0,0,0x8000
	lis 9,level@ha
	stw 0,12(1)
	la 30,level@l(9)
	la 10,.LC122@l(10)
	stw 8,8(1)
	lfd 0,8(1)
	lfs 13,4(30)
	lfs 11,0(10)
	fsub 0,0,12
	frsp 0,0
	fsubs 13,13,0
	fcmpu 0,13,11
	bc 4,1,.L169
	bl giveAmmo
	lfs 0,4(30)
	lwz 11,84(31)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	stw 9,4012(11)
.L169:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andis. 0,11,1
	bc 12,2,.L167
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 12,0,.L167
	lwz 11,84(31)
	lis 9,level+4@ha
	lis 8,.LC123@ha
	lfs 0,level+4@l(9)
	la 8,.LC123@l(8)
	lfs 13,4052(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L167
	lwz 11,484(31)
	cmpw 0,0,11
	bc 4,0,.L167
	xoris 0,0,0x8000
	stw 0,12(1)
	lis 10,0x4330
	lis 8,.LC121@ha
	stw 10,8(1)
	xoris 0,11,0x8000
	la 8,.LC121@l(8)
	mr 11,9
	lfd 13,8(1)
	stw 0,12(1)
	lis 9,.LC124@ha
	stw 10,8(1)
	la 9,.LC124@l(9)
	lfd 12,0(8)
	lfd 0,8(1)
	lis 8,.LC125@ha
	lfd 11,0(9)
	la 8,.LC125@l(8)
	fsub 13,13,12
	lfs 10,0(8)
	fsub 0,0,12
	frsp 13,13
	frsp 0,0
	fdivs 13,13,0
	fmr 12,13
	fsub 11,11,12
	frsp 31,11
	fcmpu 0,31,10
	cror 3,2,0
	bc 12,3,.L167
	lis 9,.LC126@ha
	la 9,.LC126@l(9)
	lfs 1,0(9)
	fmuls 1,31,1
	bl ceil
	lwz 10,480(31)
	fctiwz 0,1
	lwz 11,484(31)
	cmpw 0,10,11
	stfd 0,8(1)
	lwz 0,12(1)
	bc 4,0,.L174
	add 0,10,0
	cmpw 0,0,11
	stw 0,480(31)
	bc 4,1,.L175
	stw 11,480(31)
.L175:
	lis 9,gi+36@ha
	lis 3,.LC120@ha
	lwz 0,gi+36@l(9)
	la 3,.LC120@l(3)
	mtlr 0
	blrl
	fmr 1,31
	mr 4,3
	mr 3,31
	bl unicastSound
.L174:
	lis 9,level+4@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	stfs 0,4052(11)
.L167:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 regen,.Lfe12-regen
	.section	".rodata"
	.align 3
.LC127:
	.long 0x3fe33333
	.long 0x33333333
	.align 2
.LC128:
	.long 0x41800000
	.section	".text"
	.align 2
	.globl giveShard
	.type	 giveShard,@function
giveShard:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	bl ArmorIndex
	mr. 30,3
	bc 4,2,.L190
	lis 9,jacket_armor_index@ha
	lwz 30,jacket_armor_index@l(9)
.L190:
	lis 11,itemlist@ha
	mulli 0,30,72
	la 11,itemlist@l(11)
	addi 9,11,60
	lwzx 31,9,0
	cmpwi 0,31,0
	bc 12,2,.L191
	addi 9,11,56
	lwzx 0,9,0
	andi. 9,0,4
	bc 4,2,.L192
.L191:
	lis 9,gi+28@ha
	lis 3,.LC108@ha
	lwz 0,gi+28@l(9)
	la 3,.LC108@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L194
.L192:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,2
	bc 12,2,.L194
	lis 9,.LC128@ha
	lfs 11,8(31)
	la 9,.LC128@l(9)
	lfs 0,0(9)
	lis 9,.LC127@ha
	lfd 12,.LC127@l(9)
	fdivs 0,0,11
	fadd 0,0,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	b .L193
.L194:
	li 11,2
.L193:
	lwz 9,84(29)
	slwi 3,30,2
	addi 9,9,744
	lwzx 0,9,3
	add 0,0,11
	stwx 0,9,3
	lwz 9,84(29)
	lwz 11,4(31)
	addi 9,9,744
	lwzx 0,9,3
	cmpw 0,0,11
	bc 4,1,.L196
	stwx 11,9,3
.L196:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 giveShard,.Lfe13-giveShard
	.section	".rodata"
	.align 2
.LC129:
	.string	"You got the Vampire Artifact!\n\nYou receive as life\npoints half the health\ndamage you do!\n"
	.align 2
.LC130:
	.string	"You got the Mutant Jump!\n\nNow you can jump like a Mutant!\nYou are also invulnerable to slime,\nlava, and falling!"
	.align 3
.LC131:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ExpertPickupDroppedWeapon
	.type	 ExpertPickupDroppedWeapon,@function
ExpertPickupDroppedWeapon:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	lis 9,sv_expflags@ha
	lwz 11,sv_expflags@l(9)
	mr 29,3
	mr 31,4
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,2
	bc 12,2,.L198
	lwz 9,480(31)
	lwz 0,484(31)
	cmpw 0,9,0
	bc 4,0,.L199
	andis. 7,11,1
	bc 12,2,.L200
	addi 0,9,20
	b .L211
.L200:
	addi 0,9,30
.L211:
	stw 0,480(31)
	lwz 0,480(31)
	lwz 9,484(31)
	cmpw 0,0,9
	bc 4,1,.L199
	stw 9,480(31)
.L199:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 0,11,1
	bc 4,2,.L203
	mr 3,31
	bl giveShard
.L203:
	lis 9,sv_expflags@ha
	lwz 11,sv_expflags@l(9)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,8
	bc 12,2,.L198
	lis 9,level@ha
	lwz 11,892(29)
	lwz 10,level@l(9)
	cmpw 0,11,10
	bc 4,1,.L205
	xoris 0,11,0x8000
	lwz 8,84(31)
	stw 0,20(1)
	lis 30,0x4330
	lis 7,.LC131@ha
	la 7,.LC131@l(7)
	stw 30,16(1)
	lfd 31,0(7)
	lfd 0,16(1)
	lfs 13,3948(8)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,0,.L206
	lis 9,gi+12@ha
	lis 4,.LC129@ha
	lwz 0,gi+12@l(9)
	la 4,.LC129@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,892(29)
	lwz 11,84(31)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,3948(11)
	b .L205
.L206:
	subf 0,10,11
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fadds 0,13,0
	stfs 0,3948(8)
.L205:
	lis 9,level@ha
	lwz 11,896(29)
	lwz 10,level@l(9)
	cmpw 0,11,10
	bc 4,1,.L198
	xoris 0,11,0x8000
	lwz 8,84(31)
	stw 0,20(1)
	lis 30,0x4330
	lis 7,.LC131@ha
	la 7,.LC131@l(7)
	stw 30,16(1)
	lfd 31,0(7)
	lfd 0,16(1)
	lfs 13,3952(8)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,0,.L209
	lis 9,gi+12@ha
	lis 4,.LC130@ha
	lwz 0,gi+12@l(9)
	la 4,.LC130@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,896(29)
	lwz 11,84(31)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,3952(11)
	b .L198
.L209:
	subf 0,10,11
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fadds 0,13,0
	stfs 0,3952(8)
.L198:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe14:
	.size	 ExpertPickupDroppedWeapon,.Lfe14-ExpertPickupDroppedWeapon
	.section	".rodata"
	.align 3
.LC132:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC133:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl ItemEffects
	.type	 ItemEffects,@function
ItemEffects:
	stwu 1,-16(1)
	lwz 10,64(3)
	cmpwi 0,10,0
	bc 4,0,.L219
	lis 9,level@ha
	lwz 11,892(3)
	lwz 0,level@l(9)
	cmpw 0,11,0
	bc 12,1,.L219
	rlwinm 0,10,0,1,31
	stw 0,64(3)
.L219:
	lwz 10,64(3)
	andis. 0,10,1
	bc 12,2,.L220
	lis 9,level@ha
	lwz 11,896(3)
	lwz 0,level@l(9)
	cmpw 0,11,0
	bc 12,1,.L220
	rlwinm 0,10,0,16,14
	stw 0,64(3)
.L220:
	lwz 0,64(3)
	andis. 8,0,0x8001
	bc 12,2,.L221
	cmpwi 0,0,0
	bc 4,0,.L222
	lwz 0,892(3)
	lis 9,0x6666
	ori 9,9,26215
	lis 10,0x4330
	mulhw 9,0,9
	lis 8,.LC132@ha
	srawi 0,0,31
	la 8,.LC132@l(8)
	srawi 9,9,2
	lfd 13,0(8)
	subf 9,0,9
	addi 9,9,1
	xoris 9,9,0x8000
	stw 9,12(1)
	stw 10,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,428(3)
.L222:
	lwz 0,64(3)
	andis. 9,0,1
	bc 12,2,.L225
	lwz 0,896(3)
	lis 9,0x6666
	ori 9,9,26215
	lis 10,0x4330
	lfs 12,428(3)
	mulhw 9,0,9
	lis 8,.LC132@ha
	srawi 0,0,31
	la 8,.LC132@l(8)
	srawi 9,9,2
	lfd 13,0(8)
	subf 9,0,9
	addi 9,9,1
	xoris 9,9,0x8000
	stw 9,12(1)
	stw 10,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L225
	b .L226
.L221:
	lis 9,.LC133@ha
	lfs 0,900(3)
	la 9,.LC133@l(9)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,436(3)
.L226:
	stfs 0,428(3)
.L225:
	la 1,16(1)
	blr
.Lfe15:
	.size	 ItemEffects,.Lfe15-ItemEffects
	.section	".rodata"
	.align 2
.LC134:
	.string	"blaster"
	.align 2
.LC135:
	.string	"shotgun"
	.align 2
.LC136:
	.string	"super shotgun"
	.align 2
.LC137:
	.string	"machinegun"
	.align 2
.LC138:
	.string	"chaingun"
	.align 2
.LC139:
	.string	"grenade launcher"
	.align 2
.LC140:
	.string	"rocket launcher"
	.align 2
.LC141:
	.string	"hyperblaster"
	.align 2
.LC142:
	.string	"railgun"
	.align 2
.LC143:
	.string	"bfg10k"
	.section	".text"
	.align 2
	.globl weaponForNumber
	.type	 weaponForNumber,@function
weaponForNumber:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	addi 3,3,-1
	cmplwi 0,3,9
	bc 12,1,.L227
	lis 11,.L239@ha
	slwi 10,3,2
	la 11,.L239@l(11)
	lis 9,.L239@ha
	lwzx 0,10,11
	la 9,.L239@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L239:
	.long .L229-.L239
	.long .L230-.L239
	.long .L231-.L239
	.long .L232-.L239
	.long .L233-.L239
	.long .L234-.L239
	.long .L235-.L239
	.long .L236-.L239
	.long .L237-.L239
	.long .L238-.L239
.L229:
	lis 3,.LC134@ha
	la 3,.LC134@l(3)
	bl FindItem
	b .L242
.L230:
	lis 3,.LC135@ha
	la 3,.LC135@l(3)
	bl FindItem
	b .L242
.L231:
	lis 3,.LC136@ha
	la 3,.LC136@l(3)
	bl FindItem
	b .L242
.L232:
	lis 3,.LC137@ha
	la 3,.LC137@l(3)
	bl FindItem
	b .L242
.L233:
	lis 3,.LC138@ha
	la 3,.LC138@l(3)
	bl FindItem
	b .L242
.L234:
	lis 3,.LC139@ha
	la 3,.LC139@l(3)
	bl FindItem
	b .L242
.L235:
	lis 3,.LC140@ha
	la 3,.LC140@l(3)
	bl FindItem
	b .L242
.L236:
	lis 3,.LC141@ha
	la 3,.LC141@l(3)
	bl FindItem
	b .L242
.L237:
	lis 3,.LC142@ha
	la 3,.LC142@l(3)
	bl FindItem
	b .L242
.L238:
	lis 3,.LC143@ha
	la 3,.LC143@l(3)
	bl FindItem
.L242:
.L227:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 weaponForNumber,.Lfe16-weaponForNumber
	.section	".rodata"
	.align 2
.LC144:
	.string	"Expert Weapons must be enabled for SwitchFire to be used\n"
	.align 2
.LC145:
	.string	"Usage: sw [weapon] ([weapon] [weapon] ...)\n"
	.align 2
.LC146:
	.string	"Invalid weapon number specified as weapon %d in chain.  Weapons are numbered from 1 (blaster) to 10 (bfg)\n"
	.align 2
.LC147:
	.string	"You don't have the %s\n"
	.align 2
.LC148:
	.string	"No %s for the %s\n"
	.section	".text"
	.align 2
	.globl Cmd_SwitchFire_f
	.type	 Cmd_SwitchFire_f,@function
Cmd_SwitchFire_f:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 11,sv_expflags@ha
	lwz 10,sv_expflags@l(11)
	mr 28,3
	li 26,1
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	cmpwi 0,9,0
	bc 4,2,.L244
	lis 9,gi+8@ha
	lis 5,.LC144@ha
	lwz 0,gi+8@l(9)
	la 5,.LC144@l(5)
	b .L253
.L244:
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,1
	bc 12,1,.L245
	lwz 0,8(31)
	lis 5,.LC145@ha
	mr 3,28
	la 5,.LC145@l(5)
.L253:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L243
.L245:
	mr 24,31
	b .L246
.L248:
	lwz 9,160(24)
	mr 3,26
	mtlr 9
	blrl
	bl atoi
	mr 29,3
	addi 0,29,-1
	cmplwi 0,0,9
	bc 4,1,.L249
	lwz 9,8(24)
	lis 5,.LC146@ha
	mr 6,26
	la 5,.LC146@l(5)
	mr 3,28
	b .L254
.L249:
	mr 3,29
	lis 31,0x38e3
	bl weaponForNumber
	ori 31,31,36409
	lis 9,itemlist@ha
	mr 30,3
	lwz 11,84(28)
	la 25,itemlist@l(9)
	subf 0,25,30
	addi 27,11,744
	mullw 0,0,31
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,27,0
	cmpwi 0,9,0
	bc 4,2,.L250
	lwz 9,8(24)
	lis 5,.LC147@ha
	mr 3,28
	lwz 6,40(30)
	la 5,.LC147@l(5)
.L254:
	li 4,2
	mtlr 9
	addi 26,26,1
	crxor 6,6,6
	blrl
	b .L246
.L250:
	cmpwi 0,29,1
	bc 12,2,.L251
	lwz 3,52(30)
	bl FindItem
	subf 3,25,3
	mullw 3,3,31
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,27,3
	cmpwi 0,0,0
	bc 4,2,.L251
	lwz 9,8(24)
	lis 5,.LC148@ha
	mr 3,28
	lwz 7,40(30)
	la 5,.LC148@l(5)
	li 4,2
	lwz 6,52(30)
	mtlr 9
	addi 26,26,1
	crxor 6,6,6
	blrl
	b .L246
.L251:
	lwz 9,84(28)
	mr 3,28
	stw 30,3772(9)
	bl ChangeWeapon
	lwz 11,84(28)
	li 0,0
	stw 0,3808(11)
	lwz 9,84(28)
	lwz 3,1792(9)
	bl firstIdleFrameForWeapon
	lwz 9,84(28)
	li 0,1
	stw 3,92(9)
	lwz 11,84(28)
	mr 3,28
	stw 0,4056(11)
	lwz 9,84(28)
	lwz 11,1792(9)
	lwz 0,16(11)
	mtlr 0
	blrl
	b .L243
.L246:
	lwz 9,156(24)
	mtlr 9
	blrl
	cmpw 0,26,3
	bc 12,0,.L248
.L243:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 Cmd_SwitchFire_f,.Lfe17-Cmd_SwitchFire_f
	.section	".rodata"
	.align 2
.LC149:
	.string	"flipoff\n"
	.align 2
.LC150:
	.string	"salute\n"
	.align 2
.LC151:
	.string	"taunt\n"
	.align 2
.LC152:
	.string	"wave\n"
	.align 2
.LC153:
	.string	"point\n"
	.section	".text"
	.align 2
	.globl wave
	.type	 wave,@function
wave:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 11,0,1
	bc 4,2,.L255
	lwz 0,3936(9)
	cmpwi 0,0,1
	bc 12,1,.L255
	cmplwi 0,4,4
	li 0,1
	stw 0,3936(9)
	bc 12,1,.L264
	lis 11,.L265@ha
	slwi 10,4,2
	la 11,.L265@l(11)
	lis 9,.L265@ha
	lwzx 0,10,11
	la 9,.L265@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L265:
	.long .L259-.L265
	.long .L260-.L265
	.long .L261-.L265
	.long .L262-.L265
	.long .L264-.L265
.L259:
	lis 9,gi+8@ha
	lis 5,.LC149@ha
	lwz 0,gi+8@l(9)
	la 5,.LC149@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,71
	li 9,83
	b .L266
.L260:
	lis 9,gi+8@ha
	lis 5,.LC150@ha
	lwz 0,gi+8@l(9)
	la 5,.LC150@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,83
	li 9,94
	b .L266
.L261:
	lis 9,gi+8@ha
	lis 5,.LC151@ha
	lwz 0,gi+8@l(9)
	la 5,.LC151@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,94
	li 9,111
	b .L266
.L262:
	lis 9,gi+8@ha
	lis 5,.LC152@ha
	lwz 0,gi+8@l(9)
	la 5,.LC152@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,111
	li 9,122
	b .L266
.L264:
	lis 9,gi+8@ha
	lis 5,.LC153@ha
	lwz 0,gi+8@l(9)
	la 5,.LC153@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,122
	li 9,134
.L266:
	stw 0,56(31)
	stw 9,3932(11)
.L255:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe18:
	.size	 wave,.Lfe18-wave
	.section	".rodata"
	.align 2
.LC154:
	.string	"/maps/"
	.align 2
.LC155:
	.string	".ent"
	.align 2
.LC156:
	.string	"r"
	.align 2
.LC157:
	.string	"Loading entmap from %s...\n"
	.align 2
.LC158:
	.string	"Error - can't allocate memory for entmap, releasing memory..\n"
	.align 2
.LC159:
	.string	"Error on fread: %s\n"
	.section	".text"
	.align 2
	.globl LoadCustomEntmap
	.type	 LoadCustomEntmap,@function
LoadCustomEntmap:
	stwu 1,-10352(1)
	mflr 0
	stmw 25,10324(1)
	stw 0,10356(1)
	addi 31,1,8
	mr 29,3
	mr 25,4
	li 5,64
	li 4,0
	mr 3,31
	crxor 6,6,6
	bl memset
	li 27,0
	li 26,0
	lis 9,gamedir@ha
	mr 3,31
	lwz 11,gamedir@l(9)
	li 28,0
	lwz 4,4(11)
	bl strcat
	lis 4,.LC154@ha
	mr 3,31
	la 4,.LC154@l(4)
	bl strcat
	mr 4,29
	mr 3,31
	bl strcat
	lis 4,.LC155@ha
	mr 3,31
	la 4,.LC155@l(4)
	bl strcat
	lis 4,.LC156@ha
	mr 3,31
	la 4,.LC156@l(4)
	bl fopen
	mr. 30,3
	bc 12,2,.L267
	lis 9,gi+8@ha
	lis 5,.LC157@ha
	lwz 0,gi+8@l(9)
	la 5,.LC157@l(5)
	mr 6,31
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	addi 31,1,72
	b .L269
.L271:
	addi 0,26,1
	addi 11,28,30720
	add 26,0,3
	cmpwi 0,27,0
	cmpw 7,26,28
	li 9,0
	stbx 9,31,3
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 11,11,0
	and 0,28,0
	or 28,0,11
	bc 4,2,.L273
	mr 3,28
	li 4,1
	bl calloc
	mr. 29,3
	bc 4,2,.L275
	lis 9,gi+4@ha
	lis 3,.LC158@ha
	lwz 0,gi+4@l(9)
	la 3,.LC158@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L282
.L273:
	mr 3,27
	mr 4,28
	bl realloc
	mr. 29,3
	bc 12,2,.L281
.L275:
	mr 27,29
	mr 4,31
	mr 3,27
	bl strcat
.L269:
	mr 3,31
	li 4,1
	li 5,10239
	mr 6,30
	bl fread
	mr. 3,3
	bc 4,2,.L271
	lhz 4,12(30)
	andi. 0,4,32
	bc 4,2,.L278
	lis 9,gi+4@ha
	lis 3,.LC159@ha
	lwz 0,gi+4@l(9)
	la 3,.LC159@l(3)
	rlwinm 4,4,26,31,31
	mtlr 0
	crxor 6,6,6
	blrl
.L278:
	mr 3,30
	bl fclose
	cmpwi 0,27,0
	bc 12,2,.L267
	lis 9,gi@ha
	mr 3,26
	la 31,gi@l(9)
	li 4,766
	lwz 9,132(31)
	mtlr 9
	blrl
	mr. 29,3
	bc 4,2,.L280
	lwz 0,4(31)
	lis 3,.LC158@ha
	la 3,.LC158@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,27
	bl free
	b .L267
.L281:
	lis 9,gi+4@ha
	lis 3,.LC158@ha
	lwz 0,gi+4@l(9)
	la 3,.LC158@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,27
.L282:
	bl free
	mr 3,30
	bl fclose
	b .L267
.L280:
	mr 4,27
	mr 3,29
	bl strcpy
	mr 3,27
	bl free
	stw 29,0(25)
.L267:
	lwz 0,10356(1)
	mtlr 0
	lmw 25,10324(1)
	la 1,10352(1)
	blr
.Lfe19:
	.size	 LoadCustomEntmap,.Lfe19-LoadCustomEntmap
	.comm	gametype,4,4
	.comm	version,4,4
	.comm	gamedir,4,4
	.comm	ctf,4,4
	.comm	flagtrack,4,4
	.comm	sv_expflags,4,4
	.comm	sv_utilflags,4,4
	.comm	sv_arenaflags,4,4
	.comm	capturelimit,4,4
	.comm	levelCycle,4,4
	.comm	sv_numteams,4,4
	.comm	sv_pace,4,4
	.comm	sv_lethality,4,4
	.comm	sv_giblog,4,4
	.comm	botaction,4,4
	.comm	sv_paused,4,4
	.comm	forwardAddress,4,4
	.comm	forwardMessage,4,4
	.align 2
	.globl ExpertPlayerDelayedInits
	.type	 ExpertPlayerDelayedInits,@function
ExpertPlayerDelayedInits:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 4,.LC42@ha
	la 4,.LC42@l(4)
	bl StuffCmd
	lis 4,.LC43@ha
	mr 3,29
	la 4,.LC43@l(4)
	bl StuffCmd
	lis 4,.LC44@ha
	mr 3,29
	la 4,.LC44@l(4)
	bl StuffCmd
	lis 4,.LC45@ha
	mr 3,29
	la 4,.LC45@l(4)
	bl StuffCmd
	lis 4,.LC46@ha
	mr 3,29
	la 4,.LC46@l(4)
	bl StuffCmd
	lis 4,.LC47@ha
	mr 3,29
	la 4,.LC47@l(4)
	bl StuffCmd
	lis 4,.LC48@ha
	mr 3,29
	la 4,.LC48@l(4)
	bl StuffCmd
	lis 4,.LC49@ha
	mr 3,29
	la 4,.LC49@l(4)
	bl StuffCmd
	lis 4,.LC50@ha
	mr 3,29
	la 4,.LC50@l(4)
	bl StuffCmd
	lis 4,.LC51@ha
	mr 3,29
	la 4,.LC51@l(4)
	bl StuffCmd
	lis 4,.LC52@ha
	mr 3,29
	la 4,.LC52@l(4)
	bl StuffCmd
	lis 4,.LC53@ha
	mr 3,29
	la 4,.LC53@l(4)
	bl StuffCmd
	lis 4,.LC54@ha
	mr 3,29
	la 4,.LC54@l(4)
	bl StuffCmd
	lis 4,.LC55@ha
	mr 3,29
	la 4,.LC55@l(4)
	bl StuffCmd
	lwz 9,84(29)
	li 0,1
	stw 0,3564(9)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 ExpertPlayerDelayedInits,.Lfe20-ExpertPlayerDelayedInits
	.align 2
	.globl InitCmds
	.type	 InitCmds,@function
InitCmds:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 10,sv_utilflags@ha
	lwz 11,sv_utilflags@l(10)
	mr 31,3
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	andi. 0,9,64
	bc 12,2,.L38
	lwz 9,84(31)
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 12,2,.L38
	lis 9,forwardMessage@ha
	lis 10,gi+8@ha
	lwz 11,forwardMessage@l(9)
	lis 29,forwardAddress@ha
	lis 5,.LC56@ha
	lwz 9,forwardAddress@l(29)
	la 5,.LC56@l(5)
	lwz 0,gi+8@l(10)
	li 4,2
	lwz 7,4(9)
	lwz 6,4(11)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,forwardAddress@l(29)
	lis 3,.LC57@ha
	la 3,.LC57@l(3)
	lwz 4,4(9)
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,31
	bl StuffCmd
	b .L37
.L38:
	lis 4,.LC58@ha
	mr 3,31
	la 4,.LC58@l(4)
	bl StuffCmd
	lis 4,.LC59@ha
	mr 3,31
	la 4,.LC59@l(4)
	bl StuffCmd
.L37:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe21:
	.size	 InitCmds,.Lfe21-InitCmds
	.section	".rodata"
	.align 2
.LC160:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientLeavePlay
	.type	 ClientLeavePlay,@function
ClientLeavePlay:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stw 31,36(1)
	stw 0,52(1)
	lis 10,sv_arenaflags@ha
	lwz 11,sv_arenaflags@l(10)
	mr 31,3
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	andi. 0,9,1
	bc 12,2,.L47
	bl arenaDisconnect
.L47:
	lis 11,.LC160@ha
	lis 9,ctf@ha
	la 11,.LC160@l(11)
	lfs 31,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L48
	mr 3,31
	bl CTFDeadDropFlag
.L48:
	lis 9,flagtrack@ha
	lwz 11,flagtrack@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L49
	mr 3,31
	bl tossFlag
.L49:
	bl teamplayEnabled
	cmpwi 0,3,0
	bc 12,2,.L50
	mr 3,31
	bl teamDisconnect
.L50:
	lwz 0,52(1)
	mtlr 0
	lwz 31,36(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe22:
	.size	 ClientLeavePlay,.Lfe22-ClientLeavePlay
	.section	".rodata"
	.align 2
.LC161:
	.long 0x0
	.section	".text"
	.align 2
	.globl ExpertPlayerDisconnect
	.type	 ExpertPlayerDisconnect,@function
ExpertPlayerDisconnect:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stw 31,36(1)
	stw 0,52(1)
	lis 10,sv_arenaflags@ha
	lwz 11,sv_arenaflags@l(10)
	mr 31,3
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	andi. 0,9,1
	bc 12,2,.L52
	bl arenaDisconnect
.L52:
	lis 11,.LC161@ha
	lis 9,ctf@ha
	la 11,.LC161@l(11)
	lfs 31,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L53
	mr 3,31
	bl CTFDeadDropFlag
.L53:
	lis 9,flagtrack@ha
	lwz 11,flagtrack@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L54
	mr 3,31
	bl tossFlag
.L54:
	bl teamplayEnabled
	cmpwi 0,3,0
	bc 12,2,.L56
	mr 3,31
	bl teamDisconnect
.L56:
	lis 10,sv_utilflags@ha
	lwz 9,sv_utilflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1
	bc 12,2,.L57
	mr 3,31
	bl gsLogClientDisconnect
.L57:
	mr 3,31
	bl markNotObserver
	lwz 0,52(1)
	mtlr 0
	lwz 31,36(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe23:
	.size	 ExpertPlayerDisconnect,.Lfe23-ExpertPlayerDisconnect
	.align 2
	.globl canPickupArkOfLife
	.type	 canPickupArkOfLife,@function
canPickupArkOfLife:
	lwz 9,480(3)
	lwz 0,484(3)
	cmpw 0,9,0
	bclr 12,0
	lis 9,jacket_armor_index@ha
	lwz 11,84(3)
	lwz 0,jacket_armor_index@l(9)
	addi 3,11,744
	slwi 0,0,2
	lwzx 9,3,0
	cmpwi 0,9,159
	bc 12,1,.L215
	lis 9,combat_armor_index@ha
	lwz 0,combat_armor_index@l(9)
	slwi 0,0,2
	lwzx 9,3,0
	cmpwi 0,9,95
	bc 12,1,.L215
	lis 9,body_armor_index@ha
	lwz 0,body_armor_index@l(9)
	slwi 0,0,2
	lwzx 9,3,0
	cmpwi 0,9,79
	bclr 4,1
.L215:
	li 3,0
	blr
.Lfe24:
	.size	 canPickupArkOfLife,.Lfe24-canPickupArkOfLife
	.section	".rodata"
	.align 2
.LC162:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl pickupArkOfLife
	.type	 pickupArkOfLife,@function
pickupArkOfLife:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lwz 9,480(4)
	mr 31,3
	lwz 0,484(4)
	addi 9,9,30
	cmpw 0,9,0
	stw 9,480(4)
	bc 4,1,.L217
	stw 0,480(4)
.L217:
	mr 3,4
	bl giveShard
	lis 9,.LC162@ha
	mr 3,31
	la 9,.LC162@l(9)
	lfs 1,0(9)
	bl SetRespawn
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 pickupArkOfLife,.Lfe25-pickupArkOfLife
	.section	".rodata"
	.align 3
.LC163:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ExpertAddToDroppedWeapon
	.type	 ExpertAddToDroppedWeapon,@function
ExpertAddToDroppedWeapon:
	stwu 1,-16(1)
	lis 11,sv_expflags@ha
	lwz 10,sv_expflags@l(11)
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	andi. 9,9,10
	cmpwi 0,9,10
	bc 4,2,.L185
	li 0,0
	lis 10,level@ha
	stw 0,892(3)
	lis 8,0x4330
	stw 0,896(3)
	lis 11,.LC163@ha
	lwz 0,level@l(10)
	la 11,.LC163@l(11)
	lfd 12,0(11)
	xoris 0,0,0x8000
	lwz 11,84(4)
	stw 0,12(1)
	stw 8,8(1)
	lfd 0,8(1)
	lfs 13,3948(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L186
	lwz 0,64(3)
	oris 0,0,0x8000
	fctiwz 0,13
	stw 0,64(3)
	stfd 0,8(1)
	lwz 9,12(1)
	stw 9,892(3)
.L186:
	lwz 0,level@l(10)
	lwz 11,84(4)
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 8,8(1)
	lfd 0,8(1)
	lfs 13,3952(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L185
	lwz 0,64(3)
	oris 0,0,0x1
	fctiwz 0,13
	stw 0,64(3)
	stfd 0,8(1)
	lwz 9,12(1)
	stw 9,896(3)
.L185:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,64
	bc 12,2,.L188
	lwz 0,64(3)
	rlwinm 0,0,0,0,30
	stw 0,64(3)
.L188:
	la 1,16(1)
	blr
.Lfe26:
	.size	 ExpertAddToDroppedWeapon,.Lfe26-ExpertAddToDroppedWeapon
	.align 2
	.globl alternateRestoreKill
	.type	 alternateRestoreKill,@function
alternateRestoreKill:
	cmpw 0,3,4
	bclr 12,2
	lwz 0,492(3)
	cmpwi 0,0,0
	bclr 4,2
	lwz 11,480(3)
	lwz 9,484(3)
	cmpw 0,11,9
	bclr 4,0
	addi 0,11,25
	cmpw 0,0,9
	stw 0,480(3)
	bclr 4,1
	stw 9,480(3)
	blr
.Lfe27:
	.size	 alternateRestoreKill,.Lfe27-alternateRestoreKill
	.section	".rodata"
	.align 3
.LC164:
	.long 0x3fe33333
	.long 0x33333333
	.align 2
.LC165:
	.long 0x41800000
	.section	".text"
	.align 2
	.globl ShardPoints
	.type	 ShardPoints,@function
ShardPoints:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,itemlist@ha
	mulli 3,3,72
	la 11,itemlist@l(11)
	addi 9,11,60
	lwzx 8,9,3
	cmpwi 0,8,0
	bc 12,2,.L124
	addi 9,11,56
	lwzx 0,9,3
	andi. 9,0,4
	bc 4,2,.L123
.L124:
	lis 9,gi+28@ha
	lis 3,.LC108@ha
	lwz 0,gi+28@l(9)
	la 3,.LC108@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,2
	b .L283
.L123:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 4,2,.L125
	li 3,2
	b .L283
.L125:
	lis 9,.LC165@ha
	lfs 11,8(8)
	la 9,.LC165@l(9)
	lfs 0,0(9)
	lis 9,.LC164@ha
	lfd 12,.LC164@l(9)
	fdivs 0,0,11
	fadd 0,0,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
.L283:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 ShardPoints,.Lfe28-ShardPoints
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.comm	shell_index,4,4
	.comm	bullet_index,4,4
	.comm	grenade_index,4,4
	.comm	rocket_index,4,4
	.comm	slug_index,4,4
	.comm	cell_index,4,4
	.section	".rodata"
	.align 2
.LC166:
	.long 0x46fffe00
	.align 3
.LC167:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl sendBotCheck
	.type	 sendBotCheck,@function
sendBotCheck:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	cmpwi 0,4,1
	mr 31,3
	bc 4,2,.L84
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC167@ha
	la 11,.LC167@l(11)
	stw 0,16(1)
	lis 3,.LC87@ha
	lfd 12,0(11)
	la 3,.LC87@l(3)
	lfd 0,16(1)
	lis 11,.LC166@ha
	lfs 13,.LC166@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,13
	fmr 1,0
	creqv 6,6,6
	bl va
	mr 4,3
	mr 3,31
	bl StuffCmd
.L84:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 sendBotCheck,.Lfe29-sendBotCheck
	.align 2
	.globl indexForArmor
	.type	 indexForArmor,@function
indexForArmor:
	cmpwi 0,3,2
	bc 12,2,.L179
	bc 12,1,.L183
	cmpwi 0,3,1
	bc 12,2,.L178
	b .L181
.L183:
	cmpwi 0,3,3
	bc 12,2,.L180
	b .L181
.L178:
	lis 9,jacket_armor_index@ha
	lwz 3,jacket_armor_index@l(9)
	blr
.L179:
	lis 9,combat_armor_index@ha
	lwz 3,combat_armor_index@l(9)
	blr
.L180:
	lis 9,body_armor_index@ha
	lwz 3,body_armor_index@l(9)
	blr
.L181:
	lis 9,jacket_armor_index@ha
	lwz 3,jacket_armor_index@l(9)
	blr
.Lfe30:
	.size	 indexForArmor,.Lfe30-indexForArmor
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
