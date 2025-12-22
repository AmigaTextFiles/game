	.file	"ctc.c"
gcc2_compiled.:
	.globl playerModels
	.section	".data"
	.align 2
	.type	 playerModels,@object
playerModels:
	.long .LC0
	.long .LC1
	.long .LC0
	.long .LC2
	.long .LC3
	.long .LC4
	.long .LC5
	.long .LC6
	.long .LC5
	.long .LC7
	.long .LC8
	.long .LC9
	.long .LC10
	.long .LC11
	.long .LC0
	.long .LC12
	.long .LC13
	.long .LC14
	.section	".rodata"
	.align 2
.LC14:
	.string	"players/cyborg/w_egggun.md2"
	.align 2
.LC13:
	.string	"players/cyborg/w_chicken.md2"
	.align 2
.LC12:
	.string	"players/cyborg/tris.md2"
	.align 2
.LC11:
	.string	"Cyborg"
	.align 2
.LC10:
	.string	"cyborg"
	.align 2
.LC9:
	.string	"players/female/w_egggun.md2"
	.align 2
.LC8:
	.string	"players/female/w_chicken.md2"
	.align 2
.LC7:
	.string	"players/female/tris.md2"
	.align 2
.LC6:
	.string	"Female"
	.align 2
.LC5:
	.string	"female"
	.align 2
.LC4:
	.string	"players/male/w_egggun.md2"
	.align 2
.LC3:
	.string	"players/male/w_chicken.md2"
	.align 2
.LC2:
	.string	"players/male/tris.md2"
	.align 2
.LC1:
	.string	"Male"
	.align 2
.LC0:
	.string	"male"
	.size	 playerModels,72
	.globl respawnTime
	.section	".sdata","aw"
	.align 2
	.type	 respawnTime,@object
	.size	 respawnTime,4
respawnTime:
	.long 10
	.globl spawnDelay
	.align 2
	.type	 spawnDelay,@object
	.size	 spawnDelay,4
spawnDelay:
	.long 10
	.globl chickenGame
	.align 2
	.type	 chickenGame,@object
	.size	 chickenGame,4
chickenGame:
	.long 0
	.globl allowBigHealth
	.align 2
	.type	 allowBigHealth,@object
	.size	 allowBigHealth,4
allowBigHealth:
	.long 0
	.globl allowSmallHealth
	.align 2
	.type	 allowSmallHealth,@object
	.size	 allowSmallHealth,4
allowSmallHealth:
	.long 0
	.globl allowArmour
	.align 2
	.type	 allowArmour,@object
	.size	 allowArmour,4
allowArmour:
	.long 0
	.globl allowInvulnerable
	.align 2
	.type	 allowInvulnerable,@object
	.size	 allowInvulnerable,4
allowInvulnerable:
	.long 0
	.globl canDrop
	.align 2
	.type	 canDrop,@object
	.size	 canDrop,4
canDrop:
	.long 0
	.globl allowGlow
	.align 2
	.type	 allowGlow,@object
	.size	 allowGlow,4
allowGlow:
	.long 1
	.globl scoreOnDeath
	.align 2
	.type	 scoreOnDeath,@object
	.size	 scoreOnDeath,4
scoreOnDeath:
	.long 1
	.globl scorePeriod
	.align 2
	.type	 scorePeriod,@object
	.size	 scorePeriod,4
scorePeriod:
	.long 5
	.globl dropDelay
	.align 2
	.type	 dropDelay,@object
	.size	 dropDelay,4
dropDelay:
	.long 10
	.globl feathers
	.align 2
	.type	 feathers,@object
	.size	 feathers,4
feathers:
	.long 5
	.globl menuAllowed
	.align 2
	.type	 menuAllowed,@object
	.size	 menuAllowed,4
menuAllowed:
	.long 1
	.globl observerAllowed
	.align 2
	.type	 observerAllowed,@object
	.size	 observerAllowed,4
observerAllowed:
	.long 1
	.globl cameraAllowed
	.align 2
	.type	 cameraAllowed,@object
	.size	 cameraAllowed,4
cameraAllowed:
	.long 1
	.globl stdLogging
	.align 2
	.type	 stdLogging,@object
	.size	 stdLogging,4
stdLogging:
	.long 0
	.globl levelCycling
	.align 2
	.type	 levelCycling,@object
	.size	 levelCycling,4
levelCycling:
	.long 0
	.globl autoRespawn
	.align 2
	.type	 autoRespawn,@object
	.size	 autoRespawn,4
autoRespawn:
	.long 0
	.globl randomSpawn
	.align 2
	.type	 randomSpawn,@object
	.size	 randomSpawn,4
randomSpawn:
	.long 0
	.globl autorespawntime
	.align 2
	.type	 autorespawntime,@object
	.size	 autorespawntime,4
autorespawntime:
	.long 60
	.globl cantTouchDelay
	.align 2
	.type	 cantTouchDelay,@object
	.size	 cantTouchDelay,4
cantTouchDelay:
	.long 0
	.globl maxHoldScore
	.align 2
	.type	 maxHoldScore,@object
	.size	 maxHoldScore,4
maxHoldScore:
	.long 2
	.globl clientCount
	.align 2
	.type	 clientCount,@object
	.size	 clientCount,4
clientCount:
	.long 0
	.globl chickenItemIndex
	.align 2
	.type	 chickenItemIndex,@object
	.size	 chickenItemIndex,4
chickenItemIndex:
	.long 0
	.globl eggGunItemIndex
	.align 2
	.type	 eggGunItemIndex,@object
	.size	 eggGunItemIndex,4
eggGunItemIndex:
	.long 0
	.globl kickback
	.align 2
	.type	 kickback,@object
	.size	 kickback,4
kickback:
	.long 5
	.globl MOTDDuration
	.align 2
	.type	 MOTDDuration,@object
	.size	 MOTDDuration,4
MOTDDuration:
	.long 4
	.globl chickenItem
	.align 2
	.type	 chickenItem,@object
	.size	 chickenItem,4
chickenItem:
	.long 0
	.globl eggGunItem
	.align 2
	.type	 eggGunItem,@object
	.size	 eggGunItem,4
eggGunItem:
	.long 0
	.align 2
	.type	 wasInWater,@object
	.size	 wasInWater,4
wasInWater:
	.long 0
	.section	".data"
	.align 2
	.type	 gameStatusString,@object
	.size	 gameStatusString,24
gameStatusString:
	.string	"start game             "
	.globl option
	.align 2
	.type	 option,@object
option:
	.long .LC15
	.long allowBigHealth
	.long .LC16
	.long allowSmallHealth
	.long .LC17
	.long allowArmour
	.long .LC18
	.long allowInvulnerable
	.long .LC19
	.long allowGlow
	.long .LC20
	.long canDrop
	.long .LC21
	.long scoreOnDeath
	.long .LC22
	.long chickenGame
	.long .LC23
	.long scorePeriod
	.long .LC24
	.long dropDelay
	.long .LC25
	.long feathers
	.long .LC26
	.long spawnDelay
	.long .LC27
	.long stdLogging
	.long .LC28
	.long randomSpawn
	.long .LC29
	.long menuAllowed
	.long .LC30
	.long autoRespawn
	.long .LC31
	.long autorespawntime
	.long .LC32
	.long cameraAllowed
	.long .LC33
	.long observerAllowed
	.long .LC34
	.long levelCycling
	.long .LC35
	.long cantTouchDelay
	.long .LC36
	.long maxHoldScore
	.long .LC37
	.long kickback
	.long .LC38
	.long MOTDDuration
	.long .LC39
	.long teams
	.section	".rodata"
	.align 2
.LC39:
	.string	"teams"
	.align 2
.LC38:
	.string	"modduration"
	.align 2
.LC37:
	.string	"kickback"
	.align 2
.LC36:
	.string	"maxholdscore"
	.align 2
.LC35:
	.string	"notouchdelay"
	.align 2
.LC34:
	.string	"levelcycling"
	.align 2
.LC33:
	.string	"allowobserver"
	.align 2
.LC32:
	.string	"allowcamera"
	.align 2
.LC31:
	.string	"autorespawntime"
	.align 2
.LC30:
	.string	"autorespawn"
	.align 2
.LC29:
	.string	"allowmenu"
	.align 2
.LC28:
	.string	"randomspawn"
	.align 2
.LC27:
	.string	"stdlog"
	.align 2
.LC26:
	.string	"respawntime"
	.align 2
.LC25:
	.string	"feathers"
	.align 2
.LC24:
	.string	"droptime"
	.align 2
.LC23:
	.string	"scoretime"
	.align 2
.LC22:
	.string	"autostart"
	.align 2
.LC21:
	.string	"fragscore"
	.align 2
.LC20:
	.string	"droppable"
	.align 2
.LC19:
	.string	"glow"
	.align 2
.LC18:
	.string	"invuln"
	.align 2
.LC17:
	.string	"armor"
	.align 2
.LC16:
	.string	"smallhealth"
	.align 2
.LC15:
	.string	"bighealth"
	.size	 option,200
	.globl killedSelf
	.section	".data"
	.align 2
	.type	 killedSelf,@object
killedSelf:
	.long .LC40
	.section	".rodata"
	.align 2
.LC40:
	.string	"%s dies\n"
	.size	 killedSelf,4
	.globl killerKilled
	.section	".data"
	.align 2
	.type	 killerKilled,@object
killerKilled:
	.long .LC41
	.long .LC42
	.long .LC43
	.long .LC44
	.long .LC45
	.long .LC46
	.section	".rodata"
	.align 2
.LC46:
	.string	"%s plays mash the chicken with %s\n"
	.align 2
.LC45:
	.string	"%s roasts %s\n"
	.align 2
.LC44:
	.string	"%s has %s with 11 secret herbs and spices\n"
	.align 2
.LC43:
	.string	"%s turns %s into nuggets\n"
	.align 2
.LC42:
	.string	"%s plucks %s's chicken\n"
	.align 2
.LC41:
	.string	"%s kills %s the chicken rustler\n"
	.size	 killerKilled,24
	.globl killer
	.section	".data"
	.align 2
	.type	 killer,@object
killer:
	.long .LC47
	.long .LC48
	.long .LC49
	.long .LC50
	.long .LC51
	.long .LC52
	.long .LC53
	.long .LC54
	.section	".rodata"
	.align 2
.LC54:
	.string	"The chicken god smiles upon %s\n"
	.align 2
.LC53:
	.string	"%s is now fit to enter chicken heaven\n"
	.align 2
.LC52:
	.string	"%s skews some dinner\n"
	.align 2
.LC51:
	.string	"%s makes a sacrifice to the chicken god\n"
	.align 2
.LC50:
	.string	"%s administers a fatal plucking\n"
	.align 2
.LC49:
	.string	"%s forces release of the chicken\n"
	.align 2
.LC48:
	.string	"%s kills the chicken rustler\n"
	.align 2
.LC47:
	.string	"%s frees the chicken's soul\n"
	.size	 killer,32
	.globl killed
	.section	".data"
	.align 2
	.type	 killed,@object
killed:
	.long .LC55
	.long .LC56
	.long .LC57
	.section	".rodata"
	.align 2
.LC57:
	.string	"%s has been judged by the chicken god\n"
	.align 2
.LC56:
	.string	"%s dies for the chicken god\n"
	.align 2
.LC55:
	.string	"Mc %s Nugggets to go!\n"
	.size	 killed,12
	.globl levelList
	.section	".sdata","aw"
	.align 2
	.type	 levelList,@object
	.size	 levelList,4
levelList:
	.long 0
	.globl levelTail
	.align 2
	.type	 levelTail,@object
	.size	 levelTail,4
levelTail:
	.long 0
	.section	".rodata"
	.align 2
.LC58:
	.string	"if %d yb -24 xv 0 hnum xv 50 pic 0 endif "
	.align 2
.LC59:
	.string	"if %d if 2 xv 100 anum xv 150 pic 2 endif endif "
	.align 2
.LC60:
	.string	"if %d if 4 xv 200 rnum xv 250 pic 4 endif endif "
	.align 2
.LC61:
	.string	"if %d if 6 xv 296 pic 6 endif endif "
	.align 2
.LC62:
	.string	"if %d yb -50 if 7 xv 0 pic 7 xv 26 yb -42 stat_string 8 yb -50 endif endif "
	.align 2
.LC63:
	.string	"if %d if 9 xv 262 num 2 10 xv 296 pic 9 endif endif "
	.align 2
.LC64:
	.string	"if %d if 11 xv 148 pic 11 endif endif "
	.align 2
.LC65:
	.string	"if %d if %d yb -75 xr -24 pic %d xr -46 num 1 %d xr -62 num 1 %d xr -78 pic %d xr -110 num 2 %d endif endif "
	.align 2
.LC66:
	.string	"xr -50 yt 2 num 3 14 "
	.align 2
.LC67:
	.string	"if %d if %d xr -60 yt %d num 2 %d xr -24 pic %d endif endif "
	.align 2
.LC68:
	.string	"if %d xv %d yv %d pic %d endif "
	.align 2
.LC69:
	.string	"HOLY COW: Statusbar too big %d\n"
	.section	".text"
	.align 2
	.globl Chicken_CreateStatusBar
	.type	 Chicken_CreateStatusBar,@function
Chicken_CreateStatusBar:
	stwu 1,-320(1)
	mflr 0
	stmw 21,276(1)
	stw 0,324(1)
	lis 9,ctc_statusbar@ha
	li 4,0
	la 31,ctc_statusbar@l(9)
	li 5,2048
	mr 3,31
	lis 29,.LC60@ha
	crxor 6,6,6
	bl memset
	lis 21,ctc_statusbar@ha
	lis 22,teams@ha
	lis 4,.LC58@ha
	addi 3,1,16
	li 5,17
	la 4,.LC58@l(4)
	crxor 6,6,6
	bl sprintf
	addi 4,1,16
	mr 3,31
	bl strcat
	lis 4,.LC59@ha
	addi 3,1,16
	li 5,17
	la 4,.LC59@l(4)
	crxor 6,6,6
	bl sprintf
	addi 4,1,16
	mr 3,31
	bl strcat
	addi 3,1,16
	li 5,17
	la 4,.LC60@l(29)
	crxor 6,6,6
	bl sprintf
	addi 4,1,16
	mr 3,31
	bl strcat
	addi 3,1,16
	li 5,17
	la 4,.LC60@l(29)
	crxor 6,6,6
	bl sprintf
	addi 4,1,16
	mr 3,31
	bl strcat
	lis 4,.LC61@ha
	addi 3,1,16
	li 5,17
	la 4,.LC61@l(4)
	crxor 6,6,6
	bl sprintf
	addi 4,1,16
	mr 3,31
	bl strcat
	lis 4,.LC62@ha
	addi 3,1,16
	li 5,17
	la 4,.LC62@l(4)
	crxor 6,6,6
	bl sprintf
	addi 4,1,16
	mr 3,31
	bl strcat
	lis 4,.LC63@ha
	addi 3,1,16
	li 5,17
	la 4,.LC63@l(4)
	crxor 6,6,6
	bl sprintf
	addi 4,1,16
	mr 3,31
	bl strcat
	lis 4,.LC64@ha
	addi 3,1,16
	li 5,17
	la 4,.LC64@l(4)
	crxor 6,6,6
	bl sprintf
	addi 4,1,16
	mr 3,31
	bl strcat
	li 0,21
	lis 4,.LC65@ha
	stw 0,8(1)
	li 9,19
	li 10,20
	li 5,17
	la 4,.LC65@l(4)
	li 6,16
	li 7,22
	li 8,18
	addi 3,1,16
	crxor 6,6,6
	bl sprintf
	mr 3,31
	addi 4,1,16
	bl strcat
	lis 9,teams@ha
	lwz 0,teams@l(9)
	cmpwi 0,0,0
	bc 4,2,.L7
	lis 4,.LC66@ha
	addi 3,1,16
	la 4,.LC66@l(4)
	crxor 6,6,6
	bl sprintf
	mr 3,31
	addi 4,1,16
	bl strcat
	b .L8
.L7:
	li 31,0
	li 27,2
	li 30,0
	li 23,1
	lis 24,.LC67@ha
	lis 26,ctc_statusbar@ha
	lis 25,.LC68@ha
.L12:
	lwz 9,teams@l(22)
	slw 0,23,31
	and. 11,9,0
	bc 12,2,.L11
	addi 28,31,24
	mr 7,27
	mr 9,28
	li 6,17
	li 5,23
	addi 8,31,28
	addi 3,1,16
	la 4,.LC67@l(24)
	crxor 6,6,6
	bl sprintf
	addi 29,30,1
	addi 27,27,26
	addi 4,1,16
	la 3,ctc_statusbar@l(26)
	bl strcat
	andi. 0,29,1
	la 4,.LC68@l(25)
	cmpwi 7,30,1
	mr 8,28
	li 5,14
	addi 3,1,16
	mfcr 0
	rlwinm 0,0,3,1
	mr 30,29
	mfcr 7
	rlwinm 7,7,30,1
	neg 0,0
	neg 7,7
	nor 6,0,0
	nor 9,7,7
	andi. 0,0,168
	rlwinm 6,6,0,27,28
	andi. 7,7,119
	rlwinm 9,9,0,27,31
	or 6,0,6
	or 7,7,9
	crxor 6,6,6
	bl sprintf
	la 3,ctc_statusbar@l(26)
	addi 4,1,16
	bl strcat
.L11:
	addi 31,31,1
	cmpwi 0,31,3
	bc 4,1,.L12
.L8:
	lis 3,ctc_statusbar@ha
	la 3,ctc_statusbar@l(3)
	bl strlen
	cmplwi 0,3,1024
	bc 4,1,.L19
	lis 29,gi@ha
	la 3,ctc_statusbar@l(21)
	la 29,gi@l(29)
	bl strlen
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC69@ha
	mtlr 0
	la 3,.LC69@l(3)
	crxor 6,6,6
	blrl
	la 9,ctc_statusbar@l(21)
	li 0,0
	stb 0,1024(9)
.L19:
	lwz 0,324(1)
	mtlr 0
	lmw 21,276(1)
	la 1,320(1)
	blr
.Lfe1:
	.size	 Chicken_CreateStatusBar,.Lfe1-Chicken_CreateStatusBar
	.section	".rodata"
	.align 2
.LC70:
	.string	"item_chicken"
	.align 2
.LC71:
	.string	"feather"
	.align 2
.LC72:
	.string	"chicken_timer"
	.align 2
.LC73:
	.string	"start game"
	.align 2
.LC74:
	.string	"chicken/end.wav"
	.align 2
.LC75:
	.long 0x3f800000
	.align 2
.LC76:
	.long 0x0
	.section	".text"
	.align 2
	.type	 Chicken_EndIt,@function
Chicken_EndIt:
	stwu 1,-48(1)
	mflr 0
	stmw 23,12(1)
	stw 0,52(1)
	mr 23,3
	li 31,1
	bl Chicken_RemoveFromInventory
	lis 9,globals@ha
	lis 11,g_edicts@ha
	la 9,globals@l(9)
	lwz 10,g_edicts@l(11)
	lwz 0,72(9)
	addi 29,10,896
	cmpw 0,31,0
	bc 4,0,.L22
	mr 24,9
	li 30,0
	lis 25,.LC70@ha
	lis 26,.LC71@ha
	lis 27,.LC72@ha
	li 28,0
.L24:
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L23
	lwz 9,84(29)
	cmpwi 0,9,0
	bc 12,2,.L26
	stw 30,3728(9)
.L26:
	lwz 3,280(29)
	la 4,.LC70@l(25)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L28
	lwz 3,280(29)
	la 4,.LC71@l(26)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L28
	lwz 3,280(29)
	la 4,.LC72@l(27)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L23
.L28:
	stw 28,428(29)
	mr 3,29
	stw 30,480(29)
	bl G_FreeEdict
.L23:
	lwz 0,72(24)
	addi 31,31,1
	addi 29,29,896
	cmpw 0,31,0
	bc 12,0,.L24
.L22:
	li 0,0
	lis 9,chickenGame@ha
	lis 3,gameStatusString@ha
	lis 4,.LC73@ha
	stw 0,chickenGame@l(9)
	la 4,.LC73@l(4)
	la 3,gameStatusString@l(3)
	crxor 6,6,6
	bl sprintf
	lis 29,gi@ha
	lis 3,.LC74@ha
	la 29,gi@l(29)
	la 3,.LC74@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC75@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC75@l(9)
	li 4,8
	lfs 1,0(9)
	mr 3,23
	mtlr 0
	lis 9,.LC75@ha
	la 9,.LC75@l(9)
	lfs 2,0(9)
	lis 9,.LC76@ha
	la 9,.LC76@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 23,12(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Chicken_EndIt,.Lfe2-Chicken_EndIt
	.section	".rodata"
	.align 2
.LC77:
	.string	"You can't drop the chicken\n"
	.align 2
.LC78:
	.string	"Chicken_Drop NULL"
	.section	".sdata","aw"
	.align 2
	.type	 resetBob.18,@object
	.size	 resetBob.18,4
resetBob.18:
	.long 1
	.section	".rodata"
	.align 2
.LC79:
	.long 0x0
	.long 0x0
	.long 0x41300000
	.align 2
.LC81:
	.string	"Chicken_Float NULL"
	.align 2
.LC80:
	.long 0x46fffe00
	.align 2
.LC82:
	.long 0x40000000
	.align 3
.LC83:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC84:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC85:
	.long 0x40240000
	.long 0x0
	.section	".text"
	.align 2
	.type	 Chicken_Float,@function
Chicken_Float:
	stwu 1,-112(1)
	mflr 0
	stfd 28,80(1)
	stfd 29,88(1)
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 29,68(1)
	stw 0,116(1)
	mr. 31,3
	bc 12,2,.L44
	lwz 0,608(31)
	andi. 11,0,32
	bc 12,2,.L45
	lis 9,.LC79@ha
	addi 5,1,24
	lwz 7,.LC79@l(9)
	li 8,1
	lis 11,resetBob.18@ha
	la 9,.LC79@l(9)
	lis 4,wasInWater@ha
	lwz 6,8(9)
	li 0,0
	addi 3,1,8
	stw 7,24(1)
	stw 6,8(5)
	lwz 10,4(9)
	stw 8,resetBob.18@l(11)
	lis 9,gi@ha
	stw 10,4(5)
	la 30,gi@l(9)
	stw 8,wasInWater@l(4)
	stw 0,20(31)
	stw 0,16(31)
	lfs 13,4(31)
	lfs 0,24(1)
	lwz 9,52(30)
	lfs 12,28(1)
	fadds 13,13,0
	lfs 11,32(1)
	mtlr 9
	stfs 13,8(1)
	lfs 0,8(31)
	fadds 0,0,12
	stfs 0,12(1)
	lfs 13,12(31)
	fadds 13,13,11
	stfs 13,16(1)
	blrl
	andi. 0,3,3
	bc 4,2,.L52
	lis 9,.LC82@ha
	lfs 0,12(31)
	mr 3,31
	la 9,.LC82@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	b .L52
.L45:
	lis 9,wasInWater@ha
	lwz 0,wasInWater@l(9)
	cmpwi 0,0,0
	bc 12,2,.L48
	lis 30,resetBob.18@ha
	stw 11,260(31)
	lwz 0,resetBob.18@l(30)
	cmpwi 0,0,0
	bc 12,2,.L49
	li 0,0
	stw 0,20(31)
	stw 0,16(31)
	stw 11,resetBob.18@l(30)
	b .L52
.L49:
	bl rand
	lis 29,0x4330
	lis 9,.LC83@ha
	rlwinm 3,3,0,17,31
	lfs 12,16(31)
	la 9,.LC83@l(9)
	xoris 3,3,0x8000
	lfd 29,0(9)
	lis 11,.LC80@ha
	lis 10,.LC84@ha
	lfs 28,.LC80@l(11)
	la 10,.LC84@l(10)
	stw 3,60(1)
	stw 29,56(1)
	lfd 13,56(1)
	lfd 31,0(10)
	lis 10,.LC85@ha
	fsub 13,13,29
	la 10,.LC85@l(10)
	lfd 30,0(10)
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,30,12
	frsp 0,0
	stfs 0,16(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,20(31)
	xoris 3,3,0x8000
	li 0,1
	stw 3,60(1)
	stw 29,56(1)
	lfd 13,56(1)
	fsub 13,13,29
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,30,12
	frsp 0,0
	stfs 0,20(31)
	stw 0,resetBob.18@l(30)
	b .L52
.L48:
	lis 9,resetBob.18@ha
	li 0,1
	stw 0,resetBob.18@l(9)
	b .L52
.L44:
	lis 9,gi+4@ha
	lis 3,.LC81@ha
	lwz 0,gi+4@l(9)
	la 3,.LC81@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L52:
	lwz 0,116(1)
	mtlr 0
	lmw 29,68(1)
	lfd 28,80(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe3:
	.size	 Chicken_Float,.Lfe3-Chicken_Float
	.section	".sdata","aw"
	.align 2
	.type	 wasSwimming.22,@object
	.size	 wasSwimming.22,4
wasSwimming.22:
	.long 0
	.section	".rodata"
	.align 2
.LC86:
	.string	""
	.align 2
.LC88:
	.string	"chicken/peck.wav"
	.align 2
.LC87:
	.long 0x46fffe00
	.align 3
.LC89:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC90:
	.long 0x40340000
	.long 0x0
	.align 2
.LC91:
	.long 0x3f800000
	.align 2
.LC92:
	.long 0x0
	.align 2
.LC93:
	.long 0x41f00000
	.section	".text"
	.align 2
	.type	 Chicken_AdvanceFrame,@function
Chicken_AdvanceFrame:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,wasInWater@ha
	mr 31,3
	lwz 9,wasInWater@l(9)
	cmpwi 0,9,0
	bc 12,2,.L54
	lis 11,wasSwimming.22@ha
	lwz 0,wasSwimming.22@l(11)
	cmpwi 0,0,0
	bc 4,2,.L55
	li 0,1
	li 9,11
	stw 0,wasSwimming.22@l(11)
	b .L95
.L55:
	lwz 9,56(31)
	addi 9,9,1
.L95:
	stw 9,56(31)
	lwz 0,56(31)
	cmpwi 0,0,17
	bc 4,1,.L59
	li 0,11
	stw 0,56(31)
	b .L59
.L54:
	lis 11,wasSwimming.22@ha
	lwz 0,wasSwimming.22@l(11)
	cmpwi 0,0,1
	bc 4,2,.L60
	stw 9,wasSwimming.22@l(11)
	stw 9,56(31)
.L60:
	lwz 11,56(31)
	cmpwi 0,11,0
	bc 4,2,.L61
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC89@ha
	lis 11,.LC87@ha
	la 10,.LC89@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC90@ha
	lfs 11,.LC87@l(11)
	la 10,.LC90@l(10)
	lfd 10,0(10)
	fsub 0,0,13
	mr 10,9
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fmul 13,13,10
	fctiwz 12,13
	stfd 12,24(1)
	lwz 10,28(1)
	cmplwi 0,10,19
	bc 12,1,.L59
	lis 11,.L85@ha
	slwi 10,10,2
	la 11,.L85@l(11)
	lis 9,.L85@ha
	lwzx 0,10,11
	la 9,.L85@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L85:
	.long .L59-.L85
	.long .L59-.L85
	.long .L59-.L85
	.long .L59-.L85
	.long .L59-.L85
	.long .L59-.L85
	.long .L59-.L85
	.long .L96-.L85
	.long .L96-.L85
	.long .L96-.L85
	.long .L96-.L85
	.long .L96-.L85
	.long .L80-.L85
	.long .L80-.L85
	.long .L80-.L85
	.long .L80-.L85
	.long .L81-.L85
	.long .L82-.L85
	.long .L83-.L85
	.long .L84-.L85
.L80:
	li 0,66
	stw 0,56(31)
	b .L59
.L81:
	li 0,18
	stw 0,56(31)
	b .L59
.L82:
	li 0,41
	stw 0,56(31)
	b .L59
.L83:
	lis 9,.LC93@ha
	lfs 0,424(31)
	li 0,99
	la 9,.LC93@l(9)
	stw 0,56(31)
	lfs 13,0(9)
	lis 9,0x4040
	stw 9,420(31)
	fsubs 0,0,13
	stfs 0,424(31)
	b .L59
.L84:
	lis 10,.LC93@ha
	lfs 0,424(31)
	li 0,89
	la 10,.LC93@l(10)
	lis 9,0x4040
	stw 0,56(31)
	lfs 13,0(10)
	stw 9,420(31)
	fadds 0,0,13
	stfs 0,424(31)
	b .L59
.L61:
	xori 9,11,10
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,65
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 4,2,.L89
	cmpwi 0,11,88
	bc 12,2,.L89
	cmpwi 0,11,40
	bc 4,2,.L88
.L89:
	li 0,0
	stw 0,56(31)
	b .L59
.L88:
	xori 9,11,108
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,98
	subfic 10,0,0
	adde 0,10,0
	or. 11,0,9
	bc 12,2,.L91
.L96:
	lis 29,gi@ha
	lis 3,.LC88@ha
	la 29,gi@l(29)
	la 3,.LC88@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC91@ha
	lis 10,.LC91@ha
	lis 11,.LC92@ha
	mr 5,3
	la 9,.LC91@l(9)
	la 10,.LC91@l(10)
	mtlr 0
	la 11,.LC92@l(11)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	li 0,1
	stw 0,56(31)
	b .L59
.L91:
	mr 3,31
	bl M_ChangeYaw
	lwz 9,56(31)
	addi 9,9,1
	stw 9,56(31)
.L59:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 Chicken_AdvanceFrame,.Lfe4-Chicken_AdvanceFrame
	.section	".rodata"
	.align 2
.LC94:
	.string	"Chicken has auto respawned\n"
	.section	".sdata","aw"
	.align 2
	.type	 lastPlayedFrame.29,@object
	.size	 lastPlayedFrame.29,4
lastPlayedFrame.29:
	.long 0
	.section	".rodata"
	.align 2
.LC97:
	.string	"chicken/random1.wav"
	.align 2
.LC99:
	.string	"chicken/random2.wav"
	.align 2
.LC100:
	.string	"chicken/random3.wav"
	.align 2
.LC101:
	.string	"Chicken_RandomSound NULL"
	.align 2
.LC95:
	.long 0x46fffe00
	.align 3
.LC96:
	.long 0x3fe51eb8
	.long 0x51eb851f
	.align 3
.LC98:
	.long 0x3fea3d70
	.long 0xa3d70a3d
	.align 3
.LC102:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC103:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC104:
	.long 0x3f800000
	.align 2
.LC105:
	.long 0x0
	.section	".text"
	.align 2
	.type	 Chicken_RandomSound,@function
Chicken_RandomSound:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr. 30,3
	bc 12,2,.L100
	lis 11,lastPlayedFrame.29@ha
	lwz 9,lastPlayedFrame.29@l(11)
	cmpwi 0,9,49
	bc 4,1,.L101
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 11,.LC102@ha
	lis 10,.LC95@ha
	la 11,.LC102@l(11)
	stw 0,24(1)
	lfd 13,0(11)
	lfd 0,24(1)
	lis 11,.LC103@ha
	lfs 12,.LC95@l(10)
	la 11,.LC103@l(11)
	lfd 11,0(11)
	fsub 0,0,13
	lis 11,.LC86@ha
	la 31,.LC86@l(11)
	frsp 0,0
	fdivs 12,0,12
	fmr 13,12
	fcmpu 0,13,11
	bc 4,1,.L102
	lis 9,.LC96@ha
	lfd 0,.LC96@l(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L102
	lis 9,.LC97@ha
	la 31,.LC97@l(9)
	b .L103
.L102:
	lis 9,.LC96@ha
	fmr 0,12
	lfd 13,.LC96@l(9)
	fmr 12,0
	fcmpu 0,0,13
	bc 4,1,.L104
	lis 9,.LC98@ha
	lfd 0,.LC98@l(9)
	fcmpu 0,12,0
	cror 3,2,0
	bc 4,3,.L104
	lis 9,.LC99@ha
	la 31,.LC99@l(9)
	b .L103
.L104:
	lis 9,.LC98@ha
	lfd 0,.LC98@l(9)
	fcmpu 0,12,0
	bc 4,1,.L103
	lis 9,.LC100@ha
	la 31,.LC100@l(9)
.L103:
	mr 3,31
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L107
	lis 29,gi@ha
	mr 3,31
	la 29,gi@l(29)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC104@ha
	lwz 0,16(29)
	lis 11,.LC104@ha
	la 9,.LC104@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC104@l(11)
	li 4,0
	mtlr 0
	lis 9,.LC105@ha
	mr 3,30
	lfs 2,0(11)
	la 9,.LC105@l(9)
	lfs 3,0(9)
	blrl
.L107:
	lis 9,lastPlayedFrame.29@ha
	li 0,0
	stw 0,lastPlayedFrame.29@l(9)
	b .L109
.L101:
	addi 0,9,1
	stw 0,lastPlayedFrame.29@l(11)
	b .L109
.L100:
	lis 9,gi+4@ha
	lis 3,.LC101@ha
	lwz 0,gi+4@l(9)
	la 3,.LC101@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L109:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 Chicken_RandomSound,.Lfe5-Chicken_RandomSound
	.section	".rodata"
	.align 2
.LC106:
	.string	"Chicken Respawned out of danger\n"
	.align 2
.LC108:
	.string	"Chicken_Think NULL"
	.align 3
.LC107:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC109:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.type	 Chicken_Think,@function
Chicken_Think:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr. 31,3
	bc 12,2,.L111
	lis 9,autoRespawn@ha
	lwz 0,autoRespawn@l(9)
	cmpwi 0,0,0
	bc 12,2,.L113
	lwz 0,892(31)
	lis 10,0x4330
	lis 11,.LC109@ha
	xoris 0,0,0x8000
	la 11,.LC109@l(11)
	stw 0,28(1)
	stw 10,24(1)
	lfd 13,0(11)
	lfd 0,24(1)
	lis 11,level+4@ha
	lfs 12,level+4@l(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L113
	lis 9,clientCount@ha
	lwz 0,clientCount@l(9)
	cmpwi 0,0,0
	bc 4,1,.L113
	bl Chicken_Spawn
	lis 9,gi@ha
	lis 4,.LC94@ha
	lwz 0,gi@l(9)
	la 4,.LC94@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,1
	b .L114
.L113:
	li 0,0
.L114:
	cmpwi 0,0,0
	bc 4,2,.L110
	mr 3,31
	lis 30,gi@ha
	bl Chicken_RandomSound
	la 29,gi@l(30)
	mr 3,31
	bl Chicken_Float
	lwz 9,52(29)
	addi 3,31,4
	mtlr 9
	blrl
	andi. 0,3,24
	stw 3,608(31)
	bc 12,2,.L115
	bl Chicken_Spawn
	lwz 0,gi@l(30)
	lis 4,.LC106@ha
	li 3,2
	la 4,.LC106@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L115:
	mr 3,31
	bl Chicken_AdvanceFrame
	lis 9,level+4@ha
	lis 11,.LC107@ha
	lfs 0,level+4@l(9)
	mr 3,31
	lfd 13,.LC107@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	b .L110
.L111:
	lis 9,gi+4@ha
	lis 3,.LC108@ha
	lwz 0,gi+4@l(9)
	la 3,.LC108@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L110:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 Chicken_Think,.Lfe6-Chicken_Think
	.section	".rodata"
	.align 2
.LC110:
	.string	"models/items/chicken/tris.md2"
	.align 2
.LC112:
	.string	"Chicken_FlyThink NULL"
	.align 2
.LC113:
	.string	"Can't pickup chicken yet\n"
	.align 2
.LC114:
	.string	"chicken/fire.wav"
	.align 2
.LC115:
	.string	"models/objects/fly_chick/tris.md2"
	.align 2
.LC118:
	.string	"Chicken_Fire NULL"
	.align 2
.LC116:
	.long 0x46fffe00
	.align 3
.LC117:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC119:
	.long 0x3f800000
	.align 2
.LC120:
	.long 0x0
	.align 3
.LC121:
	.long 0x40000000
	.long 0x0
	.align 3
.LC122:
	.long 0x40590000
	.long 0x0
	.align 3
.LC123:
	.long 0x40790000
	.long 0x0
	.align 3
.LC124:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC125:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC126:
	.long 0x40240000
	.long 0x0
	.align 3
.LC127:
	.long 0x40690000
	.long 0x0
	.section	".text"
	.align 2
	.type	 Chicken_Fire,@function
Chicken_Fire:
	stwu 1,-176(1)
	mflr 0
	stfd 28,144(1)
	stfd 29,152(1)
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 22,104(1)
	stw 0,180(1)
	mr. 30,3
	bc 12,2,.L125
	lwz 0,84(30)
	cmpwi 0,0,0
	mr 8,0
	bc 12,2,.L125
	lis 9,teams@ha
	lwz 0,teams@l(9)
	cmpwi 0,0,0
	bc 4,2,.L126
	lis 9,canDrop@ha
	lwz 0,canDrop@l(9)
	cmpwi 0,0,0
	bc 4,2,.L126
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,96(1)
	lwz 11,100(1)
	andi. 31,11,192
	bc 4,2,.L131
	lwz 0,92(8)
	cmpwi 0,0,15
	bc 4,2,.L128
	lis 29,gi@ha
	lis 3,.LC114@ha
	la 29,gi@l(29)
	la 3,.LC114@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC119@ha
	lis 10,.LC119@ha
	lis 11,.LC120@ha
	mr 5,3
	la 9,.LC119@l(9)
	la 10,.LC119@l(10)
	mtlr 0
	la 11,.LC120@l(11)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L128:
	lwz 9,84(30)
	stw 31,3716(9)
	lwz 11,84(30)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L131
.L126:
	lis 9,level@ha
	lfs 0,3708(8)
	lis 10,.LC121@ha
	la 22,level@l(9)
	la 10,.LC121@l(10)
	lfs 10,4(22)
	lis 11,.LC122@ha
	lis 9,.LC123@ha
	lfd 13,0(10)
	la 11,.LC122@l(11)
	la 9,.LC123@l(9)
	lfd 11,0(9)
	fsubs 0,0,10
	lfd 9,0(11)
	fsub 13,13,0
	fmadd 13,13,9,11
	fctiwz 12,13
	stfd 12,96(1)
	lwz 23,100(1)
	bl G_Spawn
	mr. 31,3
	bc 12,2,.L131
	mr 4,30
	mr 3,31
	bl Chicken_Setup
	lis 27,0x4330
	addi 28,31,376
	lis 25,gi@ha
	lis 9,.LC124@ha
	la 25,gi@l(25)
	la 9,.LC124@l(9)
	lwz 11,44(25)
	lis 4,.LC115@ha
	mr 3,31
	lfd 31,0(9)
	la 4,.LC115@l(4)
	lis 10,.LC125@ha
	mtlr 11
	lis 9,.LC126@ha
	la 10,.LC125@l(10)
	la 9,.LC126@l(9)
	addi 29,1,24
	lfd 29,0(10)
	addi 26,1,40
	addi 24,1,72
	lfd 28,0(9)
	blrl
	lis 0,0x4100
	stw 0,12(1)
	mr 4,29
	mr 5,26
	stw 0,8(1)
	mr 6,24
	lwz 9,508(30)
	addi 9,9,-8
	xoris 9,9,0x8000
	stw 9,100(1)
	stw 27,96(1)
	lfd 0,96(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,16(1)
	lwz 3,84(30)
	addi 3,3,3616
	bl AngleVectors
	lwz 3,84(30)
	addi 5,1,8
	mr 7,26
	addi 8,1,56
	mr 6,29
	addi 4,30,4
	bl P_ProjectSource
	lfs 13,56(1)
	xoris 0,23,0x8000
	stw 0,100(1)
	mr 4,28
	mr 3,29
	stw 27,96(1)
	lfd 1,96(1)
	stfs 13,4(31)
	lfs 0,60(1)
	fsub 1,1,31
	stfs 0,8(31)
	lfs 13,64(1)
	frsp 1,1
	stfs 13,12(31)
	bl VectorScale
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC116@ha
	stw 3,100(1)
	lis 10,.LC127@ha
	mr 4,24
	stw 27,96(1)
	la 10,.LC127@l(10)
	mr 5,28
	lfd 0,96(1)
	mr 3,28
	lfs 30,.LC116@l(11)
	lfd 13,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 1,0
	fsub 1,1,29
	fadd 1,1,1
	fmadd 1,1,28,13
	frsp 1,1
	bl VectorMA
	bl rand
	rlwinm 0,3,0,17,31
	xoris 0,0,0x8000
	mr 3,28
	stw 0,100(1)
	mr 5,3
	mr 4,26
	stw 27,96(1)
	lfd 0,96(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 1,0
	fsub 1,1,29
	fadd 1,1,1
	fmul 1,1,28
	frsp 1,1
	bl VectorMA
	lfs 0,4(22)
	lis 11,.LC117@ha
	lis 9,Chicken_FlyThink@ha
	lfd 13,.LC117@l(11)
	la 9,Chicken_FlyThink@l(9)
	mr 3,31
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lfs 13,16(30)
	stfs 13,16(31)
	lfs 0,20(30)
	stfs 0,20(31)
	lfs 13,24(30)
	stfs 13,24(31)
	lwz 0,72(25)
	mtlr 0
	blrl
	lwz 9,84(30)
	li 0,1
	stw 0,3764(9)
	b .L131
.L125:
	lis 9,gi+4@ha
	lis 3,.LC118@ha
	lwz 0,gi+4@l(9)
	la 3,.LC118@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L131:
	lwz 0,180(1)
	mtlr 0
	lmw 22,104(1)
	lfd 28,144(1)
	lfd 29,152(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe7:
	.size	 Chicken_Fire,.Lfe7-Chicken_Fire
	.section	".data"
	.align 2
	.type	 pause_frames.45,@object
pause_frames.45:
	.long 32
	.long 0
	.align 2
	.type	 fire_frames.46,@object
fire_frames.46:
	.long 15
	.long 0
	.section	".sdata","aw"
	.align 2
	.type	 count.47,@object
	.size	 count.47,4
count.47:
	.long 1
	.align 2
	.type	 nextThrowFeather.48,@object
	.size	 nextThrowFeather.48,4
nextThrowFeather.48:
	.long 0
	.section	".rodata"
	.align 2
.LC128:
	.string	"Can't throw %d second%s left\n"
	.align 2
.LC129:
	.string	"s"
	.align 2
.LC130:
	.string	"You can't throw the chicken\n"
	.align 2
.LC132:
	.string	"models/weapons/v_throw/tris.md2"
	.align 3
.LC131:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC133:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC134:
	.long 0x3f800000
	.align 3
.LC135:
	.long 0x40100000
	.long 0x0
	.align 2
.LC136:
	.long 0x0
	.align 3
.LC137:
	.long 0x40000000
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_Weapon
	.type	 Chicken_Weapon,@function
Chicken_Weapon:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr. 31,3
	bc 12,2,.L132
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L132
	lwz 0,3780(9)
	cmpwi 0,0,1
	bc 12,2,.L132
	lis 30,count.47@ha
	lis 29,nextThrowFeather.48@ha
	lwz 9,count.47@l(30)
	lwz 0,nextThrowFeather.48@l(29)
	cmpw 0,9,0
	bc 12,0,.L134
	mr 3,31
	li 4,1
	bl Chicken_ThrowFeather
	lis 9,feathers@ha
	li 0,0
	lwz 11,feathers@l(9)
	stw 0,count.47@l(30)
	stw 11,nextThrowFeather.48@l(29)
.L134:
	lis 9,teams@ha
	lwz 11,count.47@l(30)
	lwz 0,teams@l(9)
	addi 11,11,1
	cmpwi 0,0,0
	stw 11,count.47@l(30)
	bc 4,2,.L135
	lis 9,canDrop@ha
	lwz 0,canDrop@l(9)
	cmpwi 0,0,0
	bc 4,2,.L135
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,192
	bc 4,2,.L132
	lis 8,pause_frames.45@ha
	lis 9,fire_frames.46@ha
	lis 10,Chicken_Fire@ha
	mr 3,31
	la 8,pause_frames.45@l(8)
	la 9,fire_frames.46@l(9)
	la 10,Chicken_Fire@l(10)
	li 4,14
	li 5,31
	li 6,60
	li 7,61
	bl Weapon_Generic
	mr 3,31
	bl Chicken_RandomSound
	b .L132
.L135:
	lwz 10,84(31)
	lwz 0,3548(10)
	cmpwi 0,0,1
	bc 4,2,.L138
	lwz 9,92(10)
	cmpwi 0,9,14
	bc 4,2,.L139
	li 0,0
	li 11,32
	stw 0,3548(10)
	lwz 9,84(31)
	stw 11,92(9)
	b .L132
.L139:
	addi 0,9,1
	stw 0,92(10)
	b .L132
.L138:
	cmpwi 0,0,0
	bc 4,2,.L141
	mr 3,31
	bl Chicken_RandomSound
	lwz 8,84(31)
	lwz 7,3504(8)
	lwz 0,3496(8)
	or 0,7,0
	andi. 6,0,1
	bc 12,2,.L142
	lwz 0,720(8)
	cmpwi 0,0,0
	bc 12,2,.L144
	lis 9,canDrop@ha
	lis 11,level@ha
	lwz 0,canDrop@l(9)
	cmpwi 0,0,0
	bc 12,2,.L143
	lwz 0,3740(8)
	lis 10,0x4330
	lis 6,.LC133@ha
	la 11,level@l(11)
	xoris 0,0,0x8000
	la 6,.LC133@l(6)
	lfs 12,4(11)
	stw 0,28(1)
	stw 10,24(1)
	lfd 13,0(6)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L143
.L144:
	rlwinm 0,7,0,0,30
	li 10,62
	stw 0,3504(8)
	lwz 9,84(31)
	li 8,3
	li 0,0
	stw 10,92(9)
	lwz 11,84(31)
	stw 8,3548(11)
	lwz 9,84(31)
	stw 0,3708(9)
	b .L132
.L143:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 10,level+4@l(9)
	lfs 0,3772(11)
	fcmpu 0,0,10
	bc 4,0,.L142
	lis 9,canDrop@ha
	lwz 0,canDrop@l(9)
	cmpwi 0,0,0
	bc 12,2,.L147
	lwz 0,3740(11)
	lis 10,0x4330
	lis 9,.LC133@ha
	la 9,.LC133@l(9)
	xoris 0,0,0x8000
	lfd 13,0(9)
	lis 6,.LC134@ha
	stw 0,28(1)
	la 6,.LC134@l(6)
	mr 8,11
	stw 10,24(1)
	lis 9,gi@ha
	lfd 0,24(1)
	la 10,gi@l(9)
	lfs 11,0(6)
	fsub 0,0,13
	frsp 0,0
	fsubs 0,0,10
	fadds 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,24(1)
	lwz 6,28(1)
	cmpwi 0,6,1
	bc 4,2,.L148
	lis 9,.LC86@ha
	la 7,.LC86@l(9)
	b .L149
.L148:
	lis 9,.LC129@ha
	la 7,.LC129@l(9)
.L149:
	lwz 0,8(10)
	lis 5,.LC128@ha
	mr 3,31
	la 5,.LC128@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L150
.L147:
	lis 9,gi+8@ha
	lis 5,.LC130@ha
	lwz 0,gi+8@l(9)
	la 5,.LC130@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L150:
	lis 9,level+4@ha
	lis 6,.LC135@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	la 6,.LC135@l(6)
	lfd 13,0(6)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3772(11)
.L142:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,32
	bc 4,2,.L151
	bl rand
	andi. 0,3,15
	bc 4,2,.L132
.L151:
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	cmpwi 0,9,60
	stw 9,92(11)
	bc 4,1,.L132
	lwz 9,84(31)
	li 0,32
	stw 0,92(9)
	b .L132
.L141:
	cmpwi 0,0,3
	bc 4,2,.L132
	lwz 0,92(10)
	cmpwi 0,0,63
	bc 4,2,.L154
	lis 6,.LC136@ha
	lfs 13,3708(10)
	lis 11,level@ha
	la 6,.LC136@l(6)
	lfs 0,0(6)
	fcmpu 0,13,0
	bc 4,2,.L155
	la 9,level@l(11)
	li 0,0
	lfs 0,4(9)
	lis 11,.LC137@ha
	la 11,.LC137@l(11)
	lfd 12,0(11)
	lis 11,.LC131@ha
	lfd 13,.LC131@l(11)
	fadd 0,0,12
	fadd 0,0,13
	frsp 0,0
	stfs 0,3708(10)
	lwz 9,84(31)
	stw 0,3716(9)
.L155:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3708(11)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L157
	lis 9,g_edicts@ha
	lis 6,vec3_origin@ha
	lwz 4,g_edicts@l(9)
	li 0,8
	la 6,vec3_origin@l(6)
	li 9,34
	stw 0,8(1)
	mr 3,31
	stw 9,12(1)
	addi 7,31,4
	mr 5,4
	mr 8,6
	li 9,2
	li 10,0
	bl T_Damage
	lwz 0,44(31)
	cmpwi 0,0,0
	bc 12,2,.L132
.L157:
	lwz 9,84(31)
	lwz 0,3496(9)
	andi. 6,0,1
	bc 4,2,.L132
	lis 11,chickenItem@ha
	lis 9,.LC132@ha
	lwz 10,chickenItem@l(11)
	la 9,.LC132@l(9)
	lis 8,gi+32@ha
	stw 9,32(10)
	lwz 11,84(31)
	lwz 0,gi+32@l(8)
	lwz 9,1788(11)
	mtlr 0
	lwz 3,32(9)
	blrl
	lwz 11,84(31)
	li 0,-1
	stw 3,88(11)
	lwz 9,84(31)
	stw 0,92(9)
.L154:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,4
	bc 4,2,.L161
	bl Chicken_RemoveFromInventory
	b .L132
.L161:
	cmpwi 0,0,1
	bc 4,2,.L162
	mr 3,31
	bl Chicken_Fire
.L162:
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
.L132:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 Chicken_Weapon,.Lfe8-Chicken_Weapon
	.section	".rodata"
	.align 2
.LC138:
	.string	"info_player_start"
	.align 2
.LC139:
	.string	"Couldn't find spawn point %s\n"
	.section	".text"
	.align 2
	.type	 Chicken_FindSpawnSpot,@function
Chicken_FindSpawnSpot:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,randomSpawn@ha
	lwz 0,randomSpawn@l(9)
	cmpwi 0,0,0
	bc 12,2,.L164
	bl SelectRandomDeathmatchSpawnPoint
	b .L177
.L164:
	bl SelectFarthestDeathmatchSpawnPoint
.L177:
	mr 31,3
	cmpwi 0,31,0
	bc 4,2,.L166
	lis 29,.LC138@ha
	lis 30,game@ha
.L173:
	mr 3,31
	li 4,280
	la 5,.LC138@l(29)
	bl G_Find
	mr. 31,3
	bc 12,2,.L176
	la 3,game@l(30)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L175
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L168
	b .L173
.L175:
	lwz 4,300(31)
	cmpwi 0,4,0
	bc 12,2,.L173
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L173
.L168:
	cmpwi 0,31,0
	bc 4,2,.L166
.L176:
	lis 9,game@ha
	la 30,game@l(9)
	lbz 0,1032(30)
	cmpwi 0,0,0
	bc 4,2,.L166
	lis 5,.LC138@ha
	li 3,0
	la 5,.LC138@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L166
	lis 9,gi+28@ha
	lis 3,.LC139@ha
	lwz 0,gi+28@l(9)
	la 3,.LC139@l(3)
	addi 4,30,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L166:
	mr 3,31
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 Chicken_FindSpawnSpot,.Lfe9-Chicken_FindSpawnSpot
	.section	".rodata"
	.align 3
.LC140:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.type	 Chicken_Setup,@function
Chicken_Setup:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 9,chickenItem@ha
	lis 11,teamWithChicken@ha
	lwz 10,chickenItem@l(9)
	li 0,-1
	mr 29,3
	stw 0,teamWithChicken@l(11)
	lis 9,0x2
	li 28,0
	lwz 0,0(10)
	lis 8,0xc0e0
	lis 7,0x40e0
	stw 9,284(29)
	lis 11,0xc170
	lis 6,gi+44@ha
	stw 10,648(29)
	li 9,0
	mr 27,4
	stw 0,280(29)
	lis 4,.LC110@ha
	lwz 0,28(10)
	la 4,.LC110@l(4)
	stw 8,192(29)
	stw 11,196(29)
	stw 7,204(29)
	stw 9,208(29)
	stw 8,188(29)
	stw 7,200(29)
	stw 0,64(29)
	stw 28,68(29)
	lwz 0,gi+44@l(6)
	mtlr 0
	blrl
	lis 9,autorespawntime@ha
	stw 28,540(29)
	lwz 0,autorespawntime@l(9)
	lis 4,0x4330
	li 10,5
	lis 9,.LC140@ha
	lis 6,level@ha
	stw 10,260(29)
	xoris 0,0,0x8000
	la 9,.LC140@l(9)
	stw 0,20(1)
	la 6,level@l(6)
	lis 5,cantTouchDelay@ha
	stw 4,16(1)
	mr 8,11
	mr 7,11
	lfd 11,0(9)
	lis 10,0x201
	lis 3,wasInWater@ha
	lfd 13,16(1)
	li 9,1
	ori 10,10,3
	stw 9,248(29)
	lis 11,Chicken_Think@ha
	lfs 0,4(6)
	lis 9,Chicken_Drop_Temp@ha
	la 11,Chicken_Think@l(11)
	fsub 13,13,11
	lwz 0,cantTouchDelay@l(5)
	la 9,Chicken_Drop_Temp@l(9)
	stw 9,444(29)
	xoris 0,0,0x8000
	stw 27,256(29)
	frsp 13,13
	stw 11,436(29)
	stw 28,56(29)
	fadds 0,0,13
	fctiwz 12,0
	stfd 12,16(1)
	lwz 8,20(1)
	stw 0,20(1)
	stw 4,16(1)
	lfd 0,16(1)
	stw 8,892(29)
	lfs 13,4(6)
	fsub 0,0,11
	stw 10,252(29)
	frsp 0,0
	fadds 13,13,0
	stfs 13,604(29)
	stw 28,wasInWater@l(3)
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 Chicken_Setup,.Lfe10-Chicken_Setup
	.section	".rodata"
	.align 2
.LC142:
	.string	"chicken/respawn.wav"
	.align 2
.LC143:
	.string	"end game"
	.align 2
.LC144:
	.string	"Respawn chicken failed."
	.align 3
.LC141:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC145:
	.long 0x0
	.align 2
.LC146:
	.long 0x40000000
	.align 2
.LC147:
	.long 0x3f800000
	.align 3
.LC148:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Chicken_Spawn
	.type	 Chicken_Spawn,@function
Chicken_Spawn:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 9,.LC145@ha
	lis 11,deathmatch@ha
	la 9,.LC145@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L179
	lis 9,globals@ha
	li 31,1
	la 10,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(10)
	lwz 9,g_edicts@l(11)
	cmpw 0,31,0
	addi 29,9,896
	bc 4,0,.L182
	mr 30,10
	lis 27,.LC70@ha
	li 28,0
.L184:
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L183
	lwz 3,280(29)
	la 4,.LC70@l(27)
	bl strcmp
	mr. 3,3
	bc 4,2,.L183
	stw 3,480(29)
	mr 3,29
	stw 28,428(29)
	bl G_FreeEdict
.L183:
	lwz 0,72(30)
	addi 31,31,1
	addi 29,29,896
	cmpw 0,31,0
	bc 12,0,.L184
.L182:
	bl Chicken_RemoveFromInventory
	bl G_Spawn
	mr. 31,3
	bc 12,2,.L188
	li 4,0
	mr 3,31
	bl Chicken_Setup
	li 27,0
	mr 3,31
	bl Chicken_FindSpawnSpot
	lis 28,level@ha
	lis 9,.LC141@ha
	la 28,level@l(28)
	lfd 13,.LC141@l(9)
	mr 11,3
	lfs 0,4(28)
	lis 9,.LC146@ha
	mr 3,31
	stw 27,56(31)
	la 9,.LC146@l(9)
	stw 27,256(31)
	lfs 11,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lfs 13,4(11)
	stfs 13,4(31)
	lfs 12,8(11)
	stfs 12,8(31)
	lfs 0,12(11)
	fadds 0,0,11
	stfs 0,12(31)
	lfs 13,16(11)
	stfs 13,16(31)
	lfs 0,20(11)
	stfs 0,20(31)
	lfs 13,24(11)
	stfs 13,24(31)
	bl M_droptofloor
	lis 29,gi@ha
	mr 3,31
	la 29,gi@l(29)
	lwz 9,72(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xb6db
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,28087
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,7
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 9,88(29)
	li 4,2
	addi 3,31,4
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC142@ha
	la 3,.LC142@l(3)
	mtlr 9
	blrl
	lis 9,.LC147@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC147@l(9)
	mr 3,31
	lfs 1,0(9)
	li 4,8
	mtlr 0
	lis 9,.LC145@ha
	la 9,.LC145@l(9)
	lfs 2,0(9)
	lis 9,.LC145@ha
	la 9,.LC145@l(9)
	lfs 3,0(9)
	blrl
	lis 9,spawnDelay@ha
	lfs 13,4(28)
	lwz 0,spawnDelay@l(9)
	lis 10,0x4330
	lis 6,chickenGame@ha
	lis 9,.LC148@ha
	li 7,1
	xoris 0,0,0x8000
	la 9,.LC148@l(9)
	stw 7,chickenGame@l(6)
	stw 0,20(1)
	lis 8,wasInWater@ha
	lis 5,respawnTime@ha
	stw 10,16(1)
	lis 3,gameStatusString@ha
	lis 4,.LC143@ha
	lfd 11,0(9)
	la 3,gameStatusString@l(3)
	la 4,.LC143@l(4)
	lfd 0,16(1)
	mr 9,11
	stw 27,wasInWater@l(8)
	fsub 0,0,11
	frsp 0,0
	fadds 13,13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 9,20(1)
	stw 9,respawnTime@l(5)
	crxor 6,6,6
	bl sprintf
	b .L179
.L188:
	lis 9,gi+4@ha
	lis 3,.LC144@ha
	lwz 0,gi+4@l(9)
	la 3,.LC144@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L179:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 Chicken_Spawn,.Lfe11-Chicken_Spawn
	.lcomm	model.61,128,4
	.section	".rodata"
	.align 2
.LC149:
	.string	"skin"
	.align 2
.LC150:
	.string	"#"
	.align 2
.LC151:
	.string	".md2"
	.align 2
.LC152:
	.string	"baseq2/players/"
	.align 2
.LC153:
	.string	"/w_chicken.md2"
	.align 2
.LC154:
	.string	"r"
	.align 2
.LC155:
	.string	"players/"
	.align 2
.LC156:
	.string	"/"
	.section	".text"
	.align 2
	.globl ShowGun
	.type	 ShowGun,@function
ShowGun:
	stwu 1,-416(1)
	mflr 0
	stmw 27,396(1)
	stw 0,420(1)
	mr 30,3
	lwz 11,84(30)
	lwz 0,1788(11)
	cmpwi 0,0,0
	bc 12,2,.L229
	li 0,255
	lis 9,.LC150@ha
	stw 0,44(30)
	addi 3,1,8
	lhz 0,.LC150@l(9)
	sth 0,8(1)
	lwz 9,1788(11)
	lwz 4,36(9)
	bl strcat
	lis 4,.LC151@ha
	addi 3,1,8
	la 4,.LC151@l(4)
	bl strcat
	lis 9,gi+32@ha
	addi 3,1,8
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
	lis 11,vwep_index@ha
	lis 10,chickenGame@ha
	lbz 0,63(30)
	lwz 9,vwep_index@l(11)
	lwz 8,chickenGame@l(10)
	subf 3,9,3
	slwi 3,3,8
	cmpwi 0,8,0
	or 0,0,3
	stw 0,60(30)
	bc 12,2,.L199
	lwz 3,84(30)
	lis 4,.LC149@ha
	addi 29,1,136
	la 4,.LC149@l(4)
	addi 28,1,8
	addi 3,3,188
	mr 31,29
	bl Info_ValueForKey
	mr 4,3
	mr 3,29
	bl strcpy
	lbz 0,0(29)
	li 9,0
	cmpwi 0,0,0
	bc 12,2,.L203
	cmpwi 0,0,47
	bc 4,2,.L204
	stbx 9,31,9
	b .L203
.L204:
	addi 9,9,1
	lbzx 0,31,9
	cmpwi 0,0,0
	bc 12,2,.L203
	cmpwi 0,0,47
	bc 4,2,.L204
	li 0,0
	stbx 0,31,9
.L203:
	lwz 9,84(30)
	lwz 0,3776(9)
	cmpwi 0,0,-1
	bc 4,2,.L208
	lis 9,.LC152@ha
	addi 29,1,264
	lwz 10,.LC152@l(9)
	mr 4,31
	mr 3,29
	la 9,.LC152@l(9)
	lwz 8,12(9)
	lwz 0,4(9)
	lwz 11,8(9)
	stw 10,264(1)
	stw 0,4(29)
	stw 11,8(29)
	stw 8,12(29)
	bl strcat
	lis 4,.LC153@ha
	mr 3,29
	la 4,.LC153@l(4)
	bl strcat
	lis 4,.LC154@ha
	mr 3,29
	la 4,.LC154@l(4)
	bl fopen
	mr. 3,3
	bc 12,2,.L209
	bl fclose
	lwz 9,84(30)
	li 0,1
	stw 0,3776(9)
	b .L208
.L209:
	lwz 9,84(30)
	stw 3,3776(9)
.L208:
	lis 9,.LC155@ha
	mr 4,31
	lwz 10,.LC155@l(9)
	mr 3,28
	la 9,.LC155@l(9)
	lwz 0,4(9)
	lbz 11,8(9)
	stw 10,8(1)
	stw 0,4(28)
	stb 11,8(28)
	bl strcat
	lis 4,.LC156@ha
	mr 3,28
	la 4,.LC156@l(4)
	bl strcat
	lwz 11,84(30)
	mr 3,28
	lwz 9,1788(11)
	lwz 4,36(9)
	bl strcat
	lis 4,.LC151@ha
	mr 3,28
	la 4,.LC151@l(4)
	bl strcat
	lis 9,chickenItemIndex@ha
	lwz 3,84(30)
	lwz 0,chickenItemIndex@l(9)
	addi 11,3,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,1,.L199
	lwz 0,3776(3)
	cmpwi 0,0,0
	bc 4,1,.L212
	lis 9,gi+32@ha
	mr 3,28
	b .L230
.L212:
	lis 4,.LC149@ha
	addi 3,3,188
	la 4,.LC149@l(4)
	li 31,0
	bl Info_ValueForKey
	lbz 0,0(3)
	li 11,0
	lis 9,model.61@ha
	cmpwi 0,0,0
	bc 12,2,.L220
	cmpwi 0,0,47
	bc 4,2,.L217
	la 9,model.61@l(9)
	stbx 31,9,31
	b .L220
.L217:
	lbzx 0,3,11
	lis 9,model.61@ha
	la 9,model.61@l(9)
	stbx 0,9,11
	addi 11,11,1
	lbzx 0,3,11
	cmpwi 0,0,0
	bc 12,2,.L220
	cmpwi 0,0,47
	bc 4,2,.L217
	li 0,0
	stbx 0,9,11
.L220:
	lis 9,playerModels@ha
	mulli 0,31,24
	lis 11,model.61@ha
	la 27,playerModels@l(9)
	la 28,model.61@l(11)
	add 29,0,27
.L226:
	lwz 4,0(29)
	mr 3,28
	addi 29,29,24
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L223
	addi 31,31,1
	cmpwi 0,31,2
	bc 4,1,.L226
.L223:
	cmpwi 7,31,3
	addi 11,27,16
	addi 3,1,8
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	and 31,31,0
	mulli 9,31,24
	lwzx 4,11,9
	bl strcpy
	lis 9,gi+32@ha
	addi 3,1,8
.L230:
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
	stw 3,44(30)
	lwz 0,44(30)
	cmpwi 0,0,0
	bc 4,2,.L199
	li 0,255
.L229:
	stw 0,44(30)
.L199:
	lwz 0,420(1)
	mtlr 0
	lmw 27,396(1)
	la 1,416(1)
	blr
.Lfe12:
	.size	 ShowGun,.Lfe12-ShowGun
	.section	".rodata"
	.align 2
.LC157:
	.string	"%s's picked up the Chicken\n"
	.align 2
.LC158:
	.string	"godmode OFF (Chickens don't like cheats)\n"
	.align 2
.LC159:
	.string	"chicken/pickup.wav"
	.align 2
.LC160:
	.string	"Chicken_Pickup NULL"
	.align 3
.LC161:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC162:
	.long 0x3f800000
	.align 2
.LC163:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_Pickup
	.type	 Chicken_Pickup,@function
Chicken_Pickup:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr. 30,3
	mr 31,4
	bc 12,2,.L232
	lwz 0,648(30)
	addic 9,31,-1
	subfe 11,9,31
	addic 10,0,-1
	subfe 9,10,0
	and. 0,9,11
	bc 12,2,.L232
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L232
	bl Chicken_RemoveFromInventory
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC157@ha
	lwz 0,gi@l(9)
	la 4,.LC157@l(4)
	li 3,2
	addi 5,5,700
	la 29,gi@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,264(31)
	andi. 9,0,16
	bc 12,2,.L233
	xori 0,0,16
	lis 5,.LC158@ha
	stw 0,264(31)
	la 5,.LC158@l(5)
	mr 3,31
	lwz 9,8(29)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L233:
	lis 10,chickenItemIndex@ha
	lwz 11,84(31)
	lis 9,chickenItem@ha
	lwz 0,chickenItemIndex@l(10)
	li 8,1
	lwz 10,chickenItem@l(9)
	addi 11,11,740
	slwi 0,0,2
	stwx 8,11,0
	lwz 9,84(31)
	stw 10,3512(9)
	stw 31,540(30)
	lwz 9,84(31)
	lwz 0,3492(9)
	cmpwi 0,0,0
	bc 12,2,.L234
	li 0,0
	stw 0,3492(9)
.L234:
	lis 9,dropDelay@ha
	lwz 7,84(31)
	lwz 0,dropDelay@l(9)
	lis 8,0x4330
	lis 11,level+4@ha
	lis 9,.LC161@ha
	lfs 13,level+4@l(11)
	mr 3,31
	xoris 0,0,0x8000
	la 9,.LC161@l(9)
	stw 0,28(1)
	stw 8,24(1)
	lfd 11,0(9)
	lfd 0,24(1)
	mr 9,10
	fsub 0,0,11
	frsp 0,0
	fadds 13,13,0
	fctiwz 12,13
	stfd 12,24(1)
	lwz 9,28(1)
	stw 9,3740(7)
	bl ShowGun
	mr 3,31
	bl Chicken_ClockStart
	lwz 9,36(29)
	lis 3,.LC159@ha
	la 3,.LC159@l(3)
	mtlr 9
	blrl
	lis 9,.LC162@ha
	lwz 0,16(29)
	lis 10,.LC162@ha
	la 9,.LC162@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC162@l(10)
	mtlr 0
	li 4,8
	lis 9,.LC163@ha
	mr 3,30
	lfs 2,0(10)
	la 9,.LC163@l(9)
	lfs 3,0(9)
	blrl
	lis 9,teams@ha
	lwz 0,teams@l(9)
	cmpwi 0,0,0
	bc 12,2,.L237
	lwz 9,84(31)
	lis 11,teamWithChicken@ha
	lwz 3,3760(9)
	stw 3,teamWithChicken@l(11)
	bl Chicken_TeamReadyEggGun
	b .L237
.L232:
	lis 9,gi+4@ha
	lis 3,.LC160@ha
	lwz 0,gi+4@l(9)
	la 3,.LC160@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L237:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 Chicken_Pickup,.Lfe13-Chicken_Pickup
	.section	".rodata"
	.align 2
.LC164:
	.string	"chicken/clock/bell.wav"
	.align 2
.LC165:
	.string	"chicken/clock/tick.wav"
	.align 2
.LC166:
	.long 0x3f800000
	.align 2
.LC167:
	.long 0x40400000
	.align 2
.LC168:
	.long 0x0
	.section	".text"
	.align 2
	.type	 Chicken_ClockThink,@function
Chicken_ClockThink:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr. 31,3
	li 27,0
	bc 12,2,.L239
	lwz 10,540(31)
	cmpwi 0,10,0
	bc 12,2,.L239
	lwz 30,84(10)
	cmpwi 0,30,0
	bc 12,2,.L239
	lis 9,chickenItemIndex@ha
	addi 11,30,740
	lwz 0,chickenItemIndex@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L239
	lwz 0,492(10)
	cmpwi 0,0,2
	bc 12,2,.L239
	lis 11,.LC166@ha
	lwz 9,480(31)
	lis 8,level+4@ha
	la 11,.LC166@l(11)
	lis 0,0x8888
	lfs 13,0(11)
	ori 0,0,34953
	srawi 7,9,31
	addi 11,9,1
	mulhw 0,9,0
	lis 10,0x6666
	stw 11,480(31)
	ori 10,10,26215
	lis 29,gi@ha
	lfs 0,level+4@l(8)
	add 0,0,9
	lis 11,0x2aaa
	lis 9,teams@ha
	srawi 0,0,5
	lwz 8,teams@l(9)
	subf 0,7,0
	ori 11,11,43691
	fadds 0,0,13
	cmpwi 0,8,0
	stfs 0,428(31)
	sth 0,162(30)
	lwz 9,480(31)
	addi 9,9,-1
	mulhw 0,9,10
	srawi 9,9,31
	srawi 0,0,2
	subf 0,9,0
	mulhw 11,0,11
	srawi 9,0,31
	subf 11,9,11
	mulli 11,11,6
	subf 0,11,0
	sth 0,158(30)
	lwz 9,480(31)
	addi 9,9,-1
	mulhw 10,9,10
	srawi 0,9,31
	srawi 10,10,2
	subf 10,0,10
	mulli 10,10,10
	subf 9,10,9
	sth 9,156(30)
	bc 12,2,.L243
	lis 9,scorePeriod@ha
	lis 10,maxHoldScore@ha
	lwz 8,scorePeriod@l(9)
	lwz 11,maxHoldScore@l(10)
	lwz 9,480(31)
	mullw 8,8,11
	addi 0,9,-1
	cmpw 0,8,0
	bc 4,2,.L244
	la 29,gi@l(29)
	lis 3,.LC164@ha
	lwz 28,540(31)
	lwz 9,36(29)
	la 3,.LC164@l(3)
	mtlr 9
	blrl
	lis 9,.LC166@ha
	lwz 0,16(29)
	lis 11,.LC167@ha
	la 9,.LC166@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC167@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC168@ha
	mr 3,28
	lfs 2,0(11)
	la 9,.LC168@l(9)
	lfs 3,0(9)
	blrl
	b .L243
.L244:
	addi 0,8,-4
	cmpw 0,0,9
	bc 12,1,.L243
	la 29,gi@l(29)
	lis 3,.LC165@ha
	lwz 28,540(31)
	lwz 9,36(29)
	la 3,.LC165@l(3)
	mtlr 9
	blrl
	lis 9,.LC166@ha
	lwz 0,16(29)
	lis 11,.LC167@ha
	la 9,.LC166@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC167@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC168@ha
	mr 3,28
	lfs 2,0(11)
	la 9,.LC168@l(9)
	lfs 3,0(9)
	blrl
.L243:
	lwz 8,480(31)
	lis 9,scorePeriod@ha
	lwz 11,scorePeriod@l(9)
	addi 10,8,-1
	divw 0,10,11
	mullw 0,0,11
	cmpw 0,10,0
	bc 4,2,.L247
	cmpwi 0,8,1
	bc 4,1,.L247
	lis 9,teams@ha
	lwz 0,teams@l(9)
	cmpwi 0,0,0
	bc 12,2,.L248
	lwz 10,3760(30)
	cmpwi 0,10,3
	bc 12,1,.L247
	lis 9,maxHoldScore@ha
	lwz 8,3768(30)
	lwz 7,maxHoldScore@l(9)
	cmpw 0,8,7
	bc 12,1,.L247
	lis 11,teamDetails@ha
	mulli 10,10,60
	addi 0,8,1
	la 11,teamDetails@l(11)
	stw 0,3768(30)
	addi 11,11,24
	lwzx 9,11,10
	addi 9,9,1
	stwx 9,11,10
	lwz 0,3768(30)
	xor 0,0,7
	srawi 11,0,31
	xor 9,11,0
	subf 9,9,11
	srawi 9,9,31
	addi 0,9,1
	and 9,27,9
	or 27,9,0
	b .L247
.L248:
	lwz 9,3424(30)
	addi 9,9,1
	stw 9,3424(30)
.L247:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	b .L253
.L239:
	li 27,1
.L253:
	cmpwi 0,27,0
	bc 12,2,.L254
	li 0,0
	li 9,0
	stw 0,428(31)
	mr 3,31
	stw 9,480(31)
	bl G_FreeEdict
.L254:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 Chicken_ClockThink,.Lfe14-Chicken_ClockThink
	.section	".rodata"
	.align 2
.LC169:
	.string	"Chicken_ClockStart NULL"
	.align 2
.LC170:
	.string	"models/weapons/v_chick/tris.md2"
	.align 2
.LC171:
	.string	"chicken/chickdie.wav"
	.align 2
.LC173:
	.string	"Chicken_Die NULL 1"
	.align 2
.LC174:
	.string	"Chicken_Die NULL 2"
	.align 2
.LC172:
	.long 0x46fffe00
	.align 2
.LC175:
	.long 0x3f800000
	.align 2
.LC176:
	.long 0x0
	.align 3
.LC177:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC178:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC179:
	.long 0x40c00000
	.align 2
.LC180:
	.long 0x41000000
	.align 2
.LC181:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl Chicken_PlayerDie
	.type	 Chicken_PlayerDie,@function
Chicken_PlayerDie:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 27,28(1)
	stw 0,68(1)
	lis 9,chickenGame@ha
	mr 31,3
	lwz 0,chickenGame@l(9)
	mr 29,5
	cmpwi 0,0,0
	bc 12,2,.L268
	lis 11,chickenItem@ha
	lis 9,.LC170@ha
	lwz 10,chickenItem@l(11)
	la 9,.LC170@l(9)
	lis 27,gi@ha
	la 30,gi@l(27)
	li 28,0
	stw 9,32(10)
	lwz 11,84(31)
	lwz 10,32(30)
	lwz 9,1788(11)
	mtlr 10
	lwz 3,32(9)
	blrl
	lwz 9,84(31)
	li 0,0
	lis 10,.LC171@ha
	stw 3,88(9)
	lwz 11,84(31)
	la 3,.LC171@l(10)
	stw 28,92(11)
	lwz 9,84(31)
	stw 0,3708(9)
	lwz 11,84(31)
	stw 28,3768(11)
	lwz 9,36(30)
	mtlr 9
	blrl
	lis 9,.LC175@ha
	lwz 11,16(30)
	lis 10,.LC175@ha
	la 9,.LC175@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC175@l(10)
	li 4,1
	mtlr 11
	lis 9,.LC176@ha
	mr 3,31
	lfs 2,0(10)
	la 9,.LC176@l(9)
	lfs 3,0(9)
	blrl
	cmpw 0,31,29
	bc 12,2,.L270
	cmpwi 0,31,0
	bc 12,2,.L271
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L271
	cmpwi 0,29,0
	stw 29,540(31)
	bc 12,2,.L272
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L272
	bl rand
	lis 28,0x4330
	lis 9,.LC177@ha
	rlwinm 3,3,0,17,31
	la 9,.LC177@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC172@ha
	lis 10,.LC178@ha
	lfs 30,.LC172@l(11)
	la 10,.LC178@l(10)
	stw 3,20(1)
	stw 28,16(1)
	lfd 0,16(1)
	lfd 12,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	mfcr 30
	bc 4,0,.L273
	bl rand
	rlwinm 3,3,0,17,31
	lwz 6,84(31)
	xoris 3,3,0x8000
	lis 9,.LC179@ha
	lwz 5,84(29)
	stw 3,20(1)
	la 9,.LC179@l(9)
	lis 10,killerKilled@ha
	stw 28,16(1)
	la 10,killerKilled@l(10)
	addi 5,5,700
	lfd 0,16(1)
	addi 6,6,700
	li 3,1
	lfs 11,0(9)
	mr 9,11
	fsub 0,0,31
	lwz 11,gi@l(27)
	mtlr 11
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 9,20(1)
	slwi 9,9,2
	lwzx 4,10,9
	crxor 6,6,6
	blrl
.L273:
	mtcrf 128,30
	cror 3,2,1
	bc 4,3,.L277
	bl rand
	rlwinm 3,3,0,17,31
	lwz 5,84(29)
	xoris 3,3,0x8000
	lis 9,.LC180@ha
	lwz 0,gi@l(27)
	stw 3,20(1)
	la 9,.LC180@l(9)
	lis 10,killer@ha
	stw 28,16(1)
	la 10,killer@l(10)
	addi 5,5,700
	mtlr 0
	lfd 0,16(1)
	li 3,1
	lfs 11,0(9)
	mr 9,11
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,11
	b .L282
.L272:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 5,84(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 9,.LC177@ha
	lis 8,.LC172@ha
	stw 0,16(1)
	la 9,.LC177@l(9)
	lis 10,.LC181@ha
	lfd 13,0(9)
	la 10,.LC181@l(10)
	addi 5,5,700
	lfd 0,16(1)
	mr 9,11
	li 3,1
	lfs 11,.LC172@l(8)
	lis 11,gi@ha
	lfs 10,0(10)
	fsub 0,0,13
	lis 10,killed@ha
	lwz 0,gi@l(11)
	la 10,killed@l(10)
	mtlr 0
	frsp 0,0
	fdivs 0,0,11
	fmuls 0,0,10
	b .L282
.L271:
	lis 9,gi+4@ha
	lis 3,.LC173@ha
	lwz 0,gi+4@l(9)
	la 3,.LC173@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L277
.L270:
	cmpwi 0,31,0
	bc 12,2,.L278
	bl rand
	rlwinm 3,3,0,17,31
	stw 28,540(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	lwz 5,84(31)
	stw 3,20(1)
	lis 9,.LC177@ha
	lis 8,.LC172@ha
	stw 0,16(1)
	la 9,.LC177@l(9)
	lis 10,killedSelf@ha
	lfd 13,0(9)
	la 10,killedSelf@l(10)
	addi 5,5,700
	lfd 0,16(1)
	mr 9,11
	li 3,1
	lfs 11,.LC172@l(8)
	lwz 0,gi@l(27)
	fsub 0,0,13
	mtlr 0
	frsp 0,0
	fdivs 0,0,11
.L282:
	fmr 13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 9,20(1)
	slwi 9,9,2
	lwzx 4,10,9
	crxor 6,6,6
	blrl
	b .L277
.L278:
	lwz 0,4(30)
	lis 3,.LC174@ha
	la 3,.LC174@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L277:
	li 3,1
	b .L281
.L268:
	li 3,0
.L281:
	lwz 0,68(1)
	mtlr 0
	lmw 27,28(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe15:
	.size	 Chicken_PlayerDie,.Lfe15-Chicken_PlayerDie
	.section	".rodata"
	.align 2
.LC182:
	.long 0x3f800000
	.align 2
.LC183:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_TakeDamage
	.type	 Chicken_TakeDamage,@function
Chicken_TakeDamage:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,g_edicts@ha
	mr 31,3
	lwz 0,g_edicts@l(9)
	cmpw 0,4,0
	bc 12,2,.L287
	cmpwi 0,4,0
	bc 12,2,.L284
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L287
.L284:
	lwz 10,84(31)
	cmpwi 0,10,0
	bc 12,2,.L301
	lis 9,chickenGame@ha
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L287
	cmpwi 0,31,0
	bc 12,2,.L299
	lis 9,chickenItemIndex@ha
	addi 11,10,740
	lwz 0,chickenItemIndex@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,1,.L288
	cmpwi 0,5,24
	bc 4,1,.L293
	addi 0,5,-25
	cmplwi 0,0,24
	bc 4,1,.L293
	addi 0,5,-50
	cmplwi 0,0,24
.L293:
	lis 9,.LC86@ha
	la 30,.LC86@l(9)
	cmpwi 0,30,0
	bc 12,2,.L287
	mr 3,30
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L287
	lis 29,gi@ha
	mr 3,30
	la 29,gi@l(29)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC182@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC182@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC182@ha
	la 9,.LC182@l(9)
	lfs 2,0(9)
	lis 9,.LC183@ha
	la 9,.LC183@l(9)
	lfs 3,0(9)
	blrl
	b .L287
.L288:
	lfs 0,40(10)
	lis 9,gi+52@ha
	addi 3,1,8
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fadds 13,13,0
	lwz 0,gi+52@l(9)
	mtlr 0
	stfs 13,8(1)
	lfs 0,44(10)
	fadds 12,12,0
	stfs 12,12(1)
	lfs 0,48(10)
	fadds 11,11,0
	stfs 11,16(1)
	blrl
	andi. 0,3,24
	bc 4,2,.L301
	lis 9,teams@ha
	lwz 0,teams@l(9)
	cmpwi 0,0,0
	bc 12,2,.L299
	lwz 10,84(31)
	lis 9,teamWithChicken@ha
	lwz 11,teamWithChicken@l(9)
	lwz 0,3760(10)
	cmpw 0,11,0
	bc 4,2,.L299
.L301:
.L287:
	li 3,1
	b .L300
.L299:
	li 3,0
.L300:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 Chicken_TakeDamage,.Lfe16-Chicken_TakeDamage
	.section	".rodata"
	.align 2
.LC185:
	.string	"models/objects/feather/tris.md2"
	.align 2
.LC184:
	.long 0x46fffe00
	.align 2
.LC186:
	.long 0x3dcccccd
	.align 3
.LC187:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC188:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC189:
	.long 0x40180000
	.long 0x0
	.align 2
.LC190:
	.long 0x43960000
	.align 2
.LC191:
	.long 0x3f000000
	.align 2
.LC192:
	.long 0x40000000
	.align 2
.LC193:
	.long 0x41000000
	.section	".text"
	.align 2
	.type	 Chicken_ThrowFeather,@function
Chicken_ThrowFeather:
	stwu 1,-144(1)
	mflr 0
	stfd 26,96(1)
	stfd 27,104(1)
	stfd 28,112(1)
	stfd 29,120(1)
	stfd 30,128(1)
	stfd 31,136(1)
	stmw 23,60(1)
	stw 0,148(1)
	mr. 28,4
	mr 29,3
	bc 4,1,.L304
	lis 9,.LC184@ha
	lis 11,.LC71@ha
	lfs 30,.LC184@l(9)
	la 23,.LC71@l(11)
	lis 8,.LC186@ha
	lis 9,G_FreeEdict@ha
	lis 11,level@ha
	lfs 26,.LC186@l(8)
	la 25,G_FreeEdict@l(9)
	la 24,level@l(11)
	lis 9,.LC187@ha
	lis 11,.LC188@ha
	la 9,.LC187@l(9)
	la 11,.LC188@l(11)
	lfd 31,0(9)
	lis 10,gi@ha
	lis 30,0x4330
	lfd 29,0(11)
	lis 9,.LC189@ha
	la 26,gi@l(10)
	lis 11,.LC190@ha
	la 9,.LC189@l(9)
	la 11,.LC190@l(11)
	lfd 28,0(9)
	li 27,0
	lfs 27,0(11)
.L305:
	bl G_Spawn
	mr. 31,3
	bc 12,2,.L306
	lis 9,.LC191@ha
	addi 4,1,24
	stw 23,280(31)
	la 9,.LC191@l(9)
	addi 3,29,236
	lfs 1,0(9)
	addi 28,28,-1
	bl VectorScale
	lfs 11,24(1)
	lfs 13,212(29)
	lfs 10,28(1)
	lfs 12,216(29)
	fadds 13,13,11
	lfs 0,220(29)
	lfs 11,32(1)
	fadds 12,12,10
	stfs 13,8(1)
	fadds 0,0,11
	stfs 12,12(1)
	stfs 0,16(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(1)
	xoris 3,3,0x8000
	lfs 12,24(1)
	stw 3,52(1)
	stw 30,48(1)
	lfd 13,48(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,30
	fmr 0,13
	fsub 0,0,29
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,4(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,12(1)
	xoris 3,3,0x8000
	lfs 12,28(1)
	stw 3,52(1)
	stw 30,48(1)
	lfd 13,48(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,30
	fmr 0,13
	fsub 0,0,29
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,8(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,16(1)
	xoris 3,3,0x8000
	lfs 12,32(1)
	lis 4,.LC185@ha
	stw 3,52(1)
	la 4,.LC185@l(4)
	stw 30,48(1)
	mr 3,31
	lfd 13,48(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,30
	fmr 0,13
	fsub 0,0,29
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,12(31)
	lwz 9,44(26)
	mtlr 9
	blrl
	lwz 9,264(31)
	li 0,6
	stw 0,260(31)
	ori 9,9,2048
	stw 27,248(31)
	stw 9,264(31)
	stw 27,64(31)
	stw 27,512(31)
	stw 27,456(31)
	stw 27,444(31)
	stfs 26,408(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,52(1)
	stw 30,48(1)
	lfd 13,48(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,30
	fmr 0,13
	fsub 0,0,29
	fadd 0,0,0
	fmul 0,0,28
	frsp 0,0
	stfs 0,376(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0xc0c0
	stw 3,52(1)
	stw 30,48(1)
	lfd 13,48(1)
	stw 0,384(31)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,30
	fmr 0,13
	fsub 0,0,29
	fadd 0,0,0
	fmul 0,0,28
	frsp 0,0
	stfs 0,380(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,52(1)
	stw 30,48(1)
	lfd 0,48(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,27
	stfs 0,388(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,52(1)
	stw 30,48(1)
	lfd 0,48(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,27
	stfs 0,392(31)
	bl rand
	rlwinm 3,3,0,17,31
	stw 25,436(31)
	xoris 3,3,0x8000
	stw 3,52(1)
	stw 30,48(1)
	lfd 0,48(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,27
	stfs 0,396(31)
	bl rand
	lis 11,.LC192@ha
	rlwinm 3,3,0,17,31
	lfs 13,4(24)
	la 11,.LC192@l(11)
	lfs 0,0(11)
	xoris 3,3,0x8000
	stw 3,52(1)
	lis 11,.LC193@ha
	stw 30,48(1)
	la 11,.LC193@l(11)
	mr 3,31
	fadds 13,13,0
	lfs 12,0(11)
	lfd 0,48(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmadds 0,0,12,13
	stfs 0,428(31)
	lwz 9,72(26)
	mtlr 9
	blrl
	b .L303
.L306:
	li 28,0
.L303:
	cmpwi 0,28,0
	bc 12,1,.L305
.L304:
	lwz 0,148(1)
	mtlr 0
	lmw 23,60(1)
	lfd 26,96(1)
	lfd 27,104(1)
	lfd 28,112(1)
	lfd 29,120(1)
	lfd 30,128(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe17:
	.size	 Chicken_ThrowFeather,.Lfe17-Chicken_ThrowFeather
	.align 2
	.type	 Chicken_RemoveFromInventory,@function
Chicken_RemoveFromInventory:
	stwu 1,-48(1)
	mflr 0
	stmw 23,12(1)
	stw 0,52(1)
	lis 9,globals+72@ha
	li 28,1
	lwz 0,globals+72@l(9)
	lis 11,g_edicts@ha
	lis 23,globals@ha
	lwz 9,g_edicts@l(11)
	cmpw 0,28,0
	addi 31,9,896
	bc 4,0,.L311
	lis 9,itemlist@ha
	lis 29,0x38e3
	la 26,itemlist@l(9)
	lis 11,.LC170@ha
	lis 9,gi@ha
	la 24,.LC170@l(11)
	la 25,gi@l(9)
	li 27,0
	ori 29,29,36409
.L313:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L312
	lwz 3,280(31)
	lis 4,.LC72@ha
	la 4,.LC72@l(4)
	bl strcmp
	mr. 3,3
	bc 4,2,.L315
	stw 3,480(31)
	mr 3,31
	stw 27,428(31)
	bl G_FreeEdict
.L315:
	lwz 11,84(31)
	cmpwi 0,11,0
	bc 12,2,.L312
	lis 9,eggGunItemIndex@ha
	addi 10,11,740
	lwz 0,eggGunItemIndex@l(9)
	slwi 11,0,2
	lwzx 9,10,11
	cmpwi 0,9,0
	bc 4,1,.L317
	li 0,0
	stwx 0,10,11
	lwz 9,44(31)
	cmpwi 0,9,0
	bc 12,2,.L317
	mr 3,31
	bl NoAmmoWeaponChange
	lwz 9,84(31)
	lwz 0,1788(9)
	subf 0,26,0
	mullw 0,0,29
	srawi 0,0,3
	stw 0,736(9)
.L317:
	lis 11,chickenItemIndex@ha
	lwz 9,84(31)
	lwz 10,chickenItemIndex@l(11)
	addi 9,9,740
	slwi 8,10,2
	lwzx 0,9,8
	cmpwi 0,0,0
	bc 4,1,.L312
	lis 9,chickenItem@ha
	li 30,0
	lwz 11,chickenItem@l(9)
	mr 3,31
	stw 24,32(11)
	lwz 9,84(31)
	stw 30,3764(9)
	lwz 11,84(31)
	stw 27,3708(11)
	lwz 10,84(31)
	stw 30,3768(10)
	lwz 9,84(31)
	addi 9,9,740
	stwx 30,9,8
	bl NoAmmoWeaponChange
	lwz 0,44(31)
	cmpwi 0,0,0
	bc 12,2,.L320
	mr 3,31
	bl ChangeWeapon
.L320:
	lwz 11,84(31)
	lwz 10,32(25)
	lwz 9,1788(11)
	mtlr 10
	lwz 3,32(9)
	blrl
	lwz 9,84(31)
	stw 3,88(9)
	lwz 11,84(31)
	stw 30,92(11)
	lwz 9,84(31)
	lwz 0,1788(9)
	subf 0,26,0
	mullw 0,0,29
	srawi 0,0,3
	stw 0,736(9)
.L312:
	la 9,globals@l(23)
	addi 28,28,1
	lwz 0,72(9)
	addi 31,31,896
	cmpw 0,28,0
	bc 12,0,.L313
.L311:
	lwz 0,52(1)
	mtlr 0
	lmw 23,12(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 Chicken_RemoveFromInventory,.Lfe18-Chicken_RemoveFromInventory
	.section	".rodata"
	.align 2
.LC194:
	.string	"%s ended Catch the Chicken\n"
	.align 2
.LC195:
	.string	"Catch the Chicken ended\n"
	.align 2
.LC196:
	.string	"%s started Catch the Chicken\n"
	.align 2
.LC197:
	.string	"Catch the Chicken started\n"
	.align 2
.LC198:
	.string	"chicken/start.wav"
	.align 2
.LC199:
	.string	"%s respawned Chicken\n"
	.align 2
.LC200:
	.string	"Chicken respawned by server\n"
	.align 2
.LC201:
	.string	"Chicken cannot be respawned yet\n"
	.align 2
.LC202:
	.string	"Catch the chicken not started\n"
	.align 3
.LC203:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC204:
	.long 0x3f800000
	.align 2
.LC205:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_Respawn
	.type	 Chicken_Respawn,@function
Chicken_Respawn:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,chickenGame@ha
	mr 31,3
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L331
	cmpwi 0,31,0
	mfcr 29
	bc 12,2,.L333
	lis 9,respawnTime@ha
	lwz 0,respawnTime@l(9)
	lis 10,0x4330
	lis 9,.LC203@ha
	xoris 0,0,0x8000
	la 9,.LC203@l(9)
	stw 0,28(1)
	stw 10,24(1)
	lfd 13,0(9)
	lfd 0,24(1)
	lis 9,level+4@ha
	lfs 12,level+4@l(9)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L332
.L333:
	bl Chicken_Spawn
	mtcrf 128,29
	bc 12,2,.L334
	lwz 5,84(31)
	cmpwi 0,5,0
	bc 12,2,.L334
	lis 9,gi@ha
	lis 4,.LC199@ha
	lwz 0,gi@l(9)
	la 4,.LC199@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L335
.L334:
	lis 9,gi@ha
	lis 4,.LC200@ha
	lwz 0,gi@l(9)
	la 4,.LC200@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L335:
	mtcrf 128,29
	bc 12,2,.L338
	lis 29,gi@ha
	lis 3,.LC142@ha
	la 29,gi@l(29)
	la 3,.LC142@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC204@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC204@l(9)
	li 4,8
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC204@ha
	la 9,.LC204@l(9)
	lfs 2,0(9)
	lis 9,.LC205@ha
	la 9,.LC205@l(9)
	lfs 3,0(9)
	blrl
	b .L338
.L332:
	lis 9,gi+8@ha
	lis 5,.LC201@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC201@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L338
.L331:
	lis 9,gi@ha
	lis 4,.LC202@ha
	lwz 0,gi@l(9)
	la 4,.LC202@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L338:
	li 3,0
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe19:
	.size	 Chicken_Respawn,.Lfe19-Chicken_Respawn
	.section	".sdata","aw"
	.align 2
	.type	 menuSetup.101,@object
	.size	 menuSetup.101,4
menuSetup.101:
	.long 0
	.section	".rodata"
	.align 2
.LC206:
	.string	"respawn chicken"
	.align 2
.LC207:
	.string	"allow small health"
	.align 2
.LC208:
	.string	"allow big health"
	.align 2
.LC209:
	.string	"allow armor"
	.align 2
.LC210:
	.string	"allow invulnerable"
	.align 2
.LC211:
	.string	"chicken glow"
	.align 2
.LC212:
	.string	"score on kills"
	.align 2
.LC213:
	.string	"scoring period (sec)"
	.align 2
.LC214:
	.string	"droppable chicken"
	.align 2
.LC215:
	.string	"drop delay (sec)"
	.align 2
.LC216:
	.string	" use [ and ] to move cursor"
	.align 2
.LC217:
	.string	"press enter to select"
	.align 2
.LC218:
	.string	"esc to exit menu"
	.align 2
.LC219:
	.string	"v2.0"
	.section	".text"
	.align 2
	.type	 Chicken_MenuCreate,@function
Chicken_MenuCreate:
	stwu 1,-112(1)
	mflr 0
	stmw 23,76(1)
	stw 0,116(1)
	lis 30,menuSetup.101@ha
	lwz 31,menuSetup.101@l(30)
	cmpwi 0,31,0
	bc 4,2,.L340
	lis 29,gameStatusString@ha
	lis 4,.LC73@ha
	la 4,.LC73@l(4)
	la 3,gameStatusString@l(29)
	crxor 6,6,6
	bl sprintf
	li 28,-1
	li 27,15
	li 3,1
	li 26,20
	bl Chicken_MenuInsert
	li 25,25
	li 24,30
	li 4,2
	li 5,0
	li 6,1
	li 7,1
	li 8,4
	li 3,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	li 23,1
	lis 9,Chicken_GameStatus@ha
	la 5,gameStatusString@l(29)
	la 9,Chicken_GameStatus@l(9)
	li 4,3
	li 6,0
	li 7,0
	li 8,2
	li 3,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC206@ha
	lis 9,Chicken_Respawn@ha
	la 9,Chicken_Respawn@l(9)
	la 5,.LC206@l(5)
	li 4,4
	li 6,0
	li 7,0
	li 8,2
	li 3,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	li 5,0
	li 4,5
	li 6,1
	li 7,1
	li 8,4
	li 3,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC207@ha
	lis 9,allowSmallHealth@ha
	la 5,.LC207@l(5)
	la 9,allowSmallHealth@l(9)
	li 4,6
	li 6,0
	li 7,0
	li 8,0
	li 10,0
	li 3,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC208@ha
	lis 9,allowBigHealth@ha
	la 5,.LC208@l(5)
	la 9,allowBigHealth@l(9)
	li 4,7
	li 6,0
	li 7,0
	li 8,0
	li 10,0
	li 3,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC209@ha
	lis 9,allowArmour@ha
	la 5,.LC209@l(5)
	la 9,allowArmour@l(9)
	li 4,8
	li 6,0
	li 7,0
	li 8,0
	li 10,0
	li 3,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC210@ha
	lis 9,allowInvulnerable@ha
	la 5,.LC210@l(5)
	la 9,allowInvulnerable@l(9)
	li 10,0
	li 4,9
	li 6,0
	li 7,0
	li 8,0
	li 3,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	li 10,4
	li 0,2
	stw 31,20(1)
	stw 10,16(1)
	li 11,3
	lis 5,.LC211@ha
	lis 9,allowGlow@ha
	stw 0,8(1)
	la 5,.LC211@l(5)
	stw 11,12(1)
	la 9,allowGlow@l(9)
	li 4,10
	stw 28,24(1)
	li 6,0
	li 7,0
	li 8,1
	li 10,1
	li 3,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC212@ha
	lis 9,scoreOnDeath@ha
	la 5,.LC212@l(5)
	la 9,scoreOnDeath@l(9)
	li 8,0
	li 10,0
	li 4,11
	li 6,0
	li 7,0
	li 3,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	li 0,35
	li 9,40
	stw 27,8(1)
	stw 0,24(1)
	li 10,50
	li 8,55
	stw 9,28(1)
	li 3,5
	li 11,45
	stw 10,36(1)
	li 0,60
	lis 5,.LC213@ha
	stw 8,40(1)
	lis 9,scorePeriod@ha
	la 5,.LC213@l(5)
	stw 3,48(1)
	la 9,scorePeriod@l(9)
	li 4,12
	stw 0,44(1)
	li 6,0
	li 7,0
	stw 11,32(1)
	li 8,1
	li 10,10
	stw 26,12(1)
	li 3,1
	stw 25,16(1)
	stw 24,20(1)
	stw 23,52(1)
	stw 28,56(1)
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC214@ha
	lis 9,canDrop@ha
	la 5,.LC214@l(5)
	la 9,canDrop@l(9)
	li 4,13
	li 6,0
	li 7,0
	li 8,0
	li 10,0
	li 3,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	li 0,10
	lis 5,.LC215@ha
	stw 27,12(1)
	lis 9,dropDelay@ha
	stw 0,8(1)
	li 10,5
	stw 26,16(1)
	la 9,dropDelay@l(9)
	la 5,.LC215@l(5)
	stw 25,20(1)
	li 4,14
	li 6,0
	stw 24,24(1)
	li 7,0
	li 8,1
	stw 31,28(1)
	li 3,1
	stw 28,32(1)
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	li 5,0
	li 4,15
	li 6,1
	li 7,1
	li 8,4
	li 3,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC216@ha
	li 4,16
	la 5,.LC216@l(5)
	li 6,1
	li 7,1
	li 8,4
	li 3,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC217@ha
	li 4,17
	la 5,.LC217@l(5)
	li 6,1
	li 7,1
	li 8,4
	li 3,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC218@ha
	li 4,18
	la 5,.LC218@l(5)
	li 6,1
	li 7,1
	li 8,4
	li 3,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC219@ha
	li 3,1
	la 5,.LC219@l(5)
	li 4,20
	li 6,1
	li 7,2
	li 8,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	stw 23,menuSetup.101@l(30)
.L340:
	lwz 0,116(1)
	mtlr 0
	lmw 23,76(1)
	la 1,112(1)
	blr
.Lfe20:
	.size	 Chicken_MenuCreate,.Lfe20-Chicken_MenuCreate
	.section	".sdata","aw"
	.align 2
	.type	 menuSetup.105,@object
	.size	 menuSetup.105,4
menuSetup.105:
	.long 0
	.section	".rodata"
	.align 2
.LC220:
	.string	"max hold score"
	.align 2
.LC221:
	.string	"egg gun kickback"
	.section	".text"
	.align 2
	.type	 Chicken_MenuTCTCCreate,@function
Chicken_MenuTCTCCreate:
	stwu 1,-128(1)
	mflr 0
	stmw 16,64(1)
	stw 0,132(1)
	lis 30,menuSetup.105@ha
	lwz 31,menuSetup.105@l(30)
	cmpwi 0,31,0
	bc 4,2,.L342
	lis 3,gameStatusString@ha
	lis 4,.LC73@ha
	la 4,.LC73@l(4)
	la 3,gameStatusString@l(3)
	crxor 6,6,6
	bl sprintf
	li 29,-1
	li 18,3
	li 3,4
	li 19,4
	bl Chicken_MenuInsert
	li 27,15
	li 26,20
	li 5,0
	li 4,2
	li 6,1
	li 7,1
	li 8,4
	li 3,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	li 25,1
	li 16,25
	lis 5,.LC206@ha
	lis 9,Chicken_Respawn@ha
	la 9,Chicken_Respawn@l(9)
	la 5,.LC206@l(5)
	li 4,3
	li 6,0
	li 7,0
	li 8,2
	li 3,4
	li 17,30
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	li 23,5
	li 28,10
	li 5,0
	li 4,4
	li 6,1
	li 7,1
	li 8,4
	li 3,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	li 21,6
	li 20,7
	lis 5,.LC207@ha
	lis 9,allowSmallHealth@ha
	la 5,.LC207@l(5)
	la 9,allowSmallHealth@l(9)
	li 4,5
	li 6,0
	li 7,0
	li 8,0
	li 10,0
	li 3,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	li 24,8
	li 22,9
	lis 5,.LC208@ha
	lis 9,allowBigHealth@ha
	la 5,.LC208@l(5)
	la 9,allowBigHealth@l(9)
	li 4,6
	li 6,0
	li 7,0
	li 8,0
	li 10,0
	li 3,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC209@ha
	lis 9,allowArmour@ha
	la 5,.LC209@l(5)
	la 9,allowArmour@l(9)
	li 4,7
	li 6,0
	li 7,0
	li 8,0
	li 10,0
	li 3,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC210@ha
	lis 9,allowInvulnerable@ha
	la 5,.LC210@l(5)
	la 9,allowInvulnerable@l(9)
	li 4,8
	li 6,0
	li 7,0
	li 8,0
	li 10,0
	li 3,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	li 0,2
	lis 5,.LC211@ha
	stw 18,12(1)
	lis 9,allowGlow@ha
	stw 0,8(1)
	la 5,.LC211@l(5)
	stw 19,16(1)
	la 9,allowGlow@l(9)
	li 4,9
	stw 31,20(1)
	li 6,0
	li 7,0
	stw 29,24(1)
	li 8,1
	li 10,1
	li 3,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC212@ha
	lis 9,scoreOnDeath@ha
	la 5,.LC212@l(5)
	la 9,scoreOnDeath@l(9)
	li 8,0
	li 10,0
	li 4,10
	li 6,0
	li 7,0
	li 3,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	li 0,35
	li 9,40
	stw 27,8(1)
	stw 0,24(1)
	li 10,50
	li 8,55
	stw 9,28(1)
	li 11,45
	li 0,60
	stw 10,36(1)
	lis 5,.LC213@ha
	lis 9,scorePeriod@ha
	stw 8,40(1)
	la 5,.LC213@l(5)
	la 9,scorePeriod@l(9)
	stw 11,32(1)
	li 4,11
	li 6,0
	stw 0,44(1)
	li 7,0
	li 8,1
	stw 26,12(1)
	li 10,10
	li 3,4
	stw 16,16(1)
	stw 17,20(1)
	stw 23,48(1)
	stw 25,52(1)
	stw 29,56(1)
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC220@ha
	lis 9,maxHoldScore@ha
	stw 18,8(1)
	stw 19,12(1)
	la 5,.LC220@l(5)
	la 9,maxHoldScore@l(9)
	stw 23,16(1)
	li 4,12
	li 6,0
	stw 21,20(1)
	li 7,0
	li 8,1
	stw 20,24(1)
	li 10,2
	li 3,4
	stw 24,28(1)
	stw 22,32(1)
	stw 28,36(1)
	stw 25,40(1)
	stw 29,44(1)
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC221@ha
	lis 9,kickback@ha
	stw 21,8(1)
	stw 20,12(1)
	la 5,.LC221@l(5)
	la 9,kickback@l(9)
	stw 24,16(1)
	li 4,13
	li 6,0
	stw 22,20(1)
	li 7,0
	li 8,1
	stw 28,24(1)
	li 10,5
	li 3,4
	stw 27,28(1)
	stw 26,32(1)
	stw 29,36(1)
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC215@ha
	lis 9,dropDelay@ha
	stw 28,8(1)
	stw 27,12(1)
	la 9,dropDelay@l(9)
	li 10,5
	stw 26,16(1)
	la 5,.LC215@l(5)
	li 4,14
	stw 16,20(1)
	li 6,0
	li 7,0
	stw 17,24(1)
	li 8,1
	li 3,4
	stw 31,28(1)
	stw 29,32(1)
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	li 5,0
	li 4,15
	li 6,1
	li 7,1
	li 8,4
	li 3,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC216@ha
	li 4,16
	la 5,.LC216@l(5)
	li 6,1
	li 7,1
	li 8,4
	li 3,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC217@ha
	li 4,17
	la 5,.LC217@l(5)
	li 6,1
	li 7,1
	li 8,4
	li 3,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC218@ha
	li 4,18
	la 5,.LC218@l(5)
	li 6,1
	li 7,1
	li 8,4
	li 3,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC219@ha
	li 3,4
	la 5,.LC219@l(5)
	li 4,20
	li 6,1
	li 7,2
	li 8,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	stw 25,menuSetup.105@l(30)
.L342:
	lwz 0,132(1)
	mtlr 0
	lmw 16,64(1)
	la 1,128(1)
	blr
.Lfe21:
	.size	 Chicken_MenuTCTCCreate,.Lfe21-Chicken_MenuTCTCCreate
	.align 2
	.globl Chicken_Stats
	.type	 Chicken_Stats,@function
Chicken_Stats:
	stwu 1,-64(1)
	mflr 0
	stmw 20,16(1)
	stw 0,68(1)
	lis 9,teams@ha
	mr 30,3
	lwz 0,teams@l(9)
	lis 23,teams@ha
	cmpwi 0,0,0
	bc 12,2,.L344
	lwz 11,84(30)
	lwz 0,3476(11)
	cmpwi 0,0,0
	bc 12,2,.L345
	li 0,1
	lis 9,teamDetails@ha
	sth 0,148(11)
	la 9,teamDetails@l(9)
	li 31,0
	lwz 10,84(30)
	li 0,0
	lis 11,gi@ha
	addi 29,9,16
	la 26,gi@l(11)
	sth 0,166(10)
	lis 25,teamWithChicken@ha
	li 27,48
	li 28,48
.L349:
	lwz 0,teams@l(23)
	sraw 0,0,31
	andi. 9,0,1
	bc 12,2,.L348
	lwz 0,teamWithChicken@l(25)
	cmpw 0,0,31
	bc 4,2,.L351
	lwz 9,40(26)
	lwz 3,4(29)
	mtlr 9
	blrl
	lwz 9,84(30)
	addi 9,9,120
	sthx 3,9,28
	b .L348
.L351:
	lwz 9,40(26)
	lwz 3,0(29)
	mtlr 9
	blrl
	lwz 9,84(30)
	addi 9,9,120
	sthx 3,9,27
.L348:
	addi 31,31,1
	addi 27,27,2
	cmpwi 0,31,3
	addi 29,29,60
	addi 28,28,2
	bc 4,1,.L349
	b .L344
.L345:
	sth 0,148(11)
	lis 9,gi@ha
	li 31,0
	lis 11,teamDetails+24@ha
	lwz 10,84(30)
	li 0,1
	la 11,teamDetails+24@l(11)
	la 24,gi@l(9)
	addi 20,11,-12
	addi 21,11,-16
	sth 0,166(10)
	addi 25,11,2
	lis 22,teamWithChicken@ha
	li 26,48
	li 27,48
	li 29,0
	li 28,56
.L358:
	lwz 0,teams@l(23)
	sraw 0,0,31
	andi. 9,0,1
	bc 12,2,.L357
	lwz 0,teamWithChicken@l(22)
	lwz 9,84(30)
	lhz 11,0(25)
	cmpw 0,0,31
	addi 9,9,120
	sthx 11,9,28
	bc 4,2,.L360
	lwz 9,40(24)
	lwzx 3,29,20
	mtlr 9
	blrl
	lwz 9,84(30)
	addi 9,9,120
	sthx 3,9,27
	b .L357
.L360:
	lwz 9,40(24)
	lwzx 3,21,29
	mtlr 9
	blrl
	lwz 9,84(30)
	addi 9,9,120
	sthx 3,9,26
.L357:
	addi 31,31,1
	addi 26,26,2
	cmpwi 0,31,3
	addi 27,27,2
	addi 25,25,60
	addi 29,29,60
	addi 28,28,2
	bc 4,1,.L358
.L344:
	lis 11,chickenItemIndex@ha
	lwz 9,84(30)
	lwz 0,chickenItemIndex@l(11)
	mr 10,9
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,1,.L363
	lwz 0,3764(10)
	cmpwi 0,0,0
	bc 4,2,.L363
	li 0,1
	sth 0,152(10)
	b .L364
.L363:
	li 0,0
	sth 0,152(10)
	lwz 9,84(30)
	sth 0,162(9)
	lwz 11,84(30)
	sth 0,158(11)
	lwz 9,84(30)
	sth 0,156(9)
.L364:
	lwz 0,68(1)
	mtlr 0
	lmw 20,16(1)
	la 1,64(1)
	blr
.Lfe22:
	.size	 Chicken_Stats,.Lfe22-Chicken_Stats
	.section	".rodata"
	.align 2
.LC222:
	.string	"Team %-6.6s %d Players"
	.align 2
.LC223:
	.string	"clock"
	.align 2
.LC224:
	.string	"num_colon"
	.section	".text"
	.align 2
	.globl Chicken_ShowMenu
	.type	 Chicken_ShowMenu,@function
Chicken_ShowMenu:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,teams@ha
	mr 31,3
	lwz 0,teams@l(9)
	li 30,1
	cmpwi 0,0,0
	bc 4,2,.L380
	lwz 9,84(31)
	lwz 0,3728(9)
	cmpwi 0,0,0
	bc 12,2,.L380
	lwz 0,3732(9)
	cmpwi 0,0,1
	bc 12,2,.L383
	li 4,1
	bl Chicken_MenuSelect
	lwz 9,84(31)
	stw 30,3732(9)
	b .L383
.L380:
	lis 9,chickenGame@ha
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L384
	lis 9,teams@ha
	lwz 0,teams@l(9)
	cmpwi 0,0,0
	bc 12,2,.L384
	lwz 9,84(31)
	lwz 0,3760(9)
	cmpwi 0,0,-1
	bc 4,2,.L385
	lwz 0,3732(9)
	cmpwi 0,0,2
	bc 12,2,.L383
	mr 3,31
	li 4,2
	bl Chicken_MenuSelect
	lwz 9,84(31)
	li 0,2
	stw 0,3732(9)
	b .L383
.L385:
	lwz 0,3736(9)
	cmpwi 0,0,0
	bc 4,2,.L389
	lwz 0,3732(9)
	cmpwi 0,0,3
	bc 12,2,.L391
	mr 3,31
	li 4,3
	bl Chicken_MenuSelect
	lwz 9,84(31)
	li 0,3
	stw 0,3732(9)
.L391:
	lwz 0,184(31)
	andi. 9,0,1
	bc 4,2,.L383
	mr 3,31
	bl Chicken_Observer
	b .L383
.L389:
	lwz 0,3728(9)
	cmpwi 0,0,0
	bc 12,2,.L394
	lwz 0,3732(9)
	cmpwi 0,0,4
	bc 12,2,.L383
	mr 3,31
	li 4,4
	bl Chicken_MenuSelect
	lwz 9,84(31)
	li 0,4
	stw 0,3732(9)
	b .L383
.L394:
.L384:
	li 30,0
.L383:
	cmpwi 0,30,0
	li 3,0
	bc 4,2,.L400
	lwz 9,84(31)
	lwz 0,3728(9)
	cmpwi 0,0,0
	bc 12,2,.L399
.L400:
	li 3,1
.L399:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe23:
	.size	 Chicken_ShowMenu,.Lfe23-Chicken_ShowMenu
	.align 2
	.type	 Chicken_Observer,@function
Chicken_Observer:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,chickenItemIndex@ha
	mr 31,3
	lwz 0,chickenItemIndex@l(9)
	lwz 10,84(31)
	slwi 0,0,2
	addi 11,10,740
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,1,.L402
	lwz 0,3764(10)
	cmpwi 0,0,0
	bc 4,2,.L402
	lis 9,chickenItem@ha
	addic 0,31,-1
	subfe 11,0,31
	lwz 4,chickenItem@l(9)
	addic 9,4,-1
	subfe 0,9,4
	and. 9,11,0
	bc 12,2,.L402
	cmpwi 0,10,0
	bc 12,2,.L402
	bl Drop_Item
	mr. 3,3
	bc 12,2,.L404
	mr 4,31
	bl Chicken_Setup
.L404:
	bl Chicken_RemoveFromInventory
.L402:
	lwz 9,84(31)
	li 30,0
	li 4,0
	li 5,1024
	stw 30,3728(9)
	lwz 3,84(31)
	addi 3,3,740
	crxor 6,6,6
	bl memset
	lwz 11,84(31)
	li 0,-1
	sth 30,154(11)
	lwz 9,84(31)
	stw 0,736(9)
	lwz 11,84(31)
	stw 30,3424(11)
	lwz 9,84(31)
	stw 30,88(9)
	lwz 9,84(31)
	lwz 0,3492(9)
	cmpwi 0,0,0
	bc 12,2,.L406
	stw 30,3492(9)
.L406:
	lwz 0,184(31)
	li 9,1
	lis 11,gi+72@ha
	stw 9,260(31)
	mr 3,31
	ori 0,0,1
	stw 30,248(31)
	stw 0,184(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe24:
	.size	 Chicken_Observer,.Lfe24-Chicken_Observer
	.section	".rodata"
	.align 2
.LC225:
	.string	"Observer mode not allowed\n"
	.align 2
.LC226:
	.string	"You are already an observer\n"
	.align 2
.LC227:
	.string	"You are already a camera\n"
	.align 2
.LC228:
	.string	"%s is now an observer\n"
	.align 2
.LC229:
	.string	"items/protect3.wav"
	.align 2
.LC230:
	.long 0x3f800000
	.align 2
.LC231:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_GoObserver
	.type	 Chicken_GoObserver,@function
Chicken_GoObserver:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,observerAllowed@ha
	mr 31,3
	lwz 0,observerAllowed@l(9)
	cmpwi 0,0,0
	bc 4,2,.L408
	lis 9,gi+8@ha
	lis 5,.LC225@ha
	lwz 0,gi+8@l(9)
	la 5,.LC225@l(5)
	b .L416
.L408:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 4,2,.L410
	lis 9,gi+8@ha
	lis 5,.LC226@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC226@l(5)
	b .L416
.L410:
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L409
	lwz 0,3780(9)
	cmpwi 0,0,0
	bc 12,2,.L412
	lis 9,gi+8@ha
	lis 5,.LC227@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC227@l(5)
.L416:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L409
.L412:
	mr 3,31
	bl Chicken_Observer
	lis 29,gi@ha
	lwz 5,84(31)
	lis 4,.LC228@ha
	lwz 9,gi@l(29)
	la 4,.LC228@l(4)
	li 3,2
	addi 5,5,700
	la 29,gi@l(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC229@ha
	la 3,.LC229@l(3)
	mtlr 9
	blrl
	lis 9,.LC230@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC230@l(9)
	li 4,8
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC230@ha
	la 9,.LC230@l(9)
	lfs 2,0(9)
	lis 9,.LC231@ha
	la 9,.LC231@l(9)
	lfs 3,0(9)
	blrl
.L409:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 Chicken_GoObserver,.Lfe25-Chicken_GoObserver
	.section	".rodata"
	.align 2
.LC232:
	.string	"%s is now a camera\n"
	.align 2
.LC233:
	.long 0x3f800000
	.align 2
.LC234:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_Camera
	.type	 Chicken_Camera,@function
Chicken_Camera:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,chickenItemIndex@ha
	mr 31,3
	lwz 0,chickenItemIndex@l(9)
	lwz 10,84(31)
	slwi 0,0,2
	addi 11,10,740
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,1,.L418
	lwz 0,3764(10)
	cmpwi 0,0,0
	bc 4,2,.L418
	lis 9,chickenItem@ha
	addic 0,31,-1
	subfe 11,0,31
	lwz 4,chickenItem@l(9)
	addic 9,4,-1
	subfe 0,9,4
	and. 9,11,0
	bc 12,2,.L418
	cmpwi 0,10,0
	bc 12,2,.L418
	bl Drop_Item
	mr. 3,3
	bc 12,2,.L420
	mr 4,31
	bl Chicken_Setup
.L420:
	bl Chicken_RemoveFromInventory
.L418:
	lwz 9,84(31)
	li 30,0
	li 4,0
	li 5,1024
	stw 30,3728(9)
	lwz 3,84(31)
	addi 3,3,740
	crxor 6,6,6
	bl memset
	lwz 9,84(31)
	li 0,-1
	lis 11,gi@ha
	lis 4,.LC232@ha
	li 3,2
	sth 30,154(9)
	la 4,.LC232@l(4)
	la 29,gi@l(11)
	lwz 9,84(31)
	stw 0,736(9)
	lwz 0,gi@l(11)
	lwz 5,84(31)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	stw 30,3424(9)
	lwz 11,84(31)
	stw 30,88(11)
	lwz 9,84(31)
	lwz 0,3492(9)
	cmpwi 0,0,0
	bc 12,2,.L422
	stw 30,3492(9)
.L422:
	lwz 0,184(31)
	mr 3,31
	ori 0,0,1
	stw 0,184(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC229@ha
	la 3,.LC229@l(3)
	mtlr 9
	blrl
	lis 9,.LC233@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC233@l(9)
	li 4,8
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC233@ha
	la 9,.LC233@l(9)
	lfs 2,0(9)
	lis 9,.LC234@ha
	la 9,.LC234@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 Chicken_Camera,.Lfe26-Chicken_Camera
	.section	".sdata","aw"
	.align 2
	.type	 firstTime.139,@object
	.size	 firstTime.139,4
firstTime.139:
	.long 1
	.section	".rodata"
	.align 2
.LC235:
	.string	"EggGun"
	.align 2
.LC236:
	.string	"Chicken"
	.section	".text"
	.align 2
	.globl Chicken_GameInit
	.type	 Chicken_GameInit,@function
Chicken_GameInit:
	stwu 1,-48(1)
	mflr 0
	stmw 23,12(1)
	stw 0,52(1)
	lis 31,firstTime.139@ha
	lwz 0,firstTime.139@l(31)
	cmpwi 0,0,0
	bc 12,2,.L425
	lis 27,.LC235@ha
	lis 29,eggGunItem@ha
	la 3,.LC235@l(27)
	lis 28,0x38e3
	bl FindItem
	ori 28,28,36409
	lis 26,.LC236@ha
	stw 3,eggGunItem@l(29)
	lis 25,eggGunItemIndex@ha
	lis 24,chickenItem@ha
	la 3,.LC235@l(27)
	lis 23,chickenItemIndex@ha
	bl FindItem
	lis 29,itemlist@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC236@l(26)
	srawi 0,0,3
	stw 0,eggGunItemIndex@l(25)
	bl FindItem
	stw 3,chickenItem@l(24)
	la 3,.LC236@l(26)
	bl FindItem
	subf 3,29,3
	mullw 3,3,28
	srawi 3,3,3
	stw 3,chickenItemIndex@l(23)
	bl Chicken_MenuCreate
	bl Chicken_ReadIni
	lis 9,levelCycling@ha
	lwz 0,levelCycling@l(9)
	cmpwi 0,0,0
	bc 12,2,.L426
	bl Chicken_ReadMapList
.L426:
	lis 9,MOTDDuration@ha
	lwz 0,MOTDDuration@l(9)
	cmpwi 0,0,0
	bc 12,2,.L427
	bl Chicken_MOTDLoad
.L427:
	lis 9,teams@ha
	lwz 0,teams@l(9)
	cmpwi 0,0,0
	bc 12,2,.L428
	bl Chicken_MenuTCTCCreate
	bl Chicken_TeamMenuCreate
	bl Chicken_PlayerSelectMenuCreate
.L428:
	bl Chicken_CreateStatusBar
	li 0,0
	stw 0,firstTime.139@l(31)
.L425:
	lwz 0,52(1)
	mtlr 0
	lmw 23,12(1)
	la 1,48(1)
	blr
.Lfe27:
	.size	 Chicken_GameInit,.Lfe27-Chicken_GameInit
	.section	".rodata"
	.align 2
.LC237:
	.string	"Catch The Chicken only playable in deathmatch\n"
	.align 2
.LC238:
	.string	"Menu access not allowed\n"
	.align 2
.LC239:
	.string	"Catch The Chicken must be started with teams\n"
	.align 2
.LC240:
	.string	"item_invulnerability"
	.align 2
.LC241:
	.string	"item_quad"
	.section	".sdata","aw"
	.align 2
	.type	 alreadyRead.149,@object
	.size	 alreadyRead.149,4
alreadyRead.149:
	.long 0
	.section	".rodata"
	.align 2
.LC242:
	.string	"game"
	.align 2
.LC243:
	.string	"./%s/%s"
	.align 2
.LC244:
	.string	"ctc.ini"
	.align 2
.LC245:
	.string	"%s/%s"
	.align 2
.LC246:
	.string	"Unable to read %s. Using defaults.\n"
	.align 2
.LC247:
	.string	"\nProcessing CTC %s.. \n"
	.align 2
.LC248:
	.string	" \t\n"
	.align 2
.LC249:
	.string	" \t\n#"
	.align 2
.LC250:
	.string	"Invalid option (%s) in %s on line %d\n"
	.align 2
.LC251:
	.string	"stdlogfile"
	.align 2
.LC252:
	.string	"kickback of %d is invalid using default\n"
	.align 2
.LC253:
	.string	"%d CTC Options processed\n"
	.section	".text"
	.align 2
	.type	 Chicken_ReadIni,@function
Chicken_ReadIni:
	stwu 1,-432(1)
	mflr 0
	stmw 22,392(1)
	stw 0,436(1)
	lis 9,alreadyRead.149@ha
	li 27,0
	lwz 0,alreadyRead.149@l(9)
	li 25,0
	cmpwi 0,0,0
	bc 4,2,.L440
	lis 9,gi@ha
	lis 3,.LC242@ha
	la 30,gi@l(9)
	lis 4,.LC86@ha
	lwz 9,144(30)
	la 4,.LC86@l(4)
	li 5,0
	la 3,.LC242@l(3)
	lis 31,.LC244@ha
	mtlr 9
	blrl
	mr 29,3
	lis 4,.LC243@ha
	lwz 5,4(29)
	la 4,.LC243@l(4)
	addi 3,1,8
	la 6,.LC244@l(31)
	crxor 6,6,6
	bl sprintf
	lwz 5,4(29)
	lis 4,.LC245@ha
	la 6,.LC244@l(31)
	la 4,.LC245@l(4)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	lis 4,.LC154@ha
	addi 3,1,8
	la 4,.LC154@l(4)
	bl fopen
	mr. 24,3
	bc 4,2,.L442
	lwz 0,4(30)
	lis 3,.LC246@ha
	la 4,.LC244@l(31)
	la 3,.LC246@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L440
.L442:
	lwz 0,4(30)
	lis 3,.LC247@ha
	la 4,.LC244@l(31)
	la 3,.LC247@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	addi 26,1,136
	lis 23,feathers@ha
	lis 22,kickback@ha
	b .L443
.L445:
	lbz 11,136(1)
	addi 25,25,1
	xori 9,11,9
	xori 0,11,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L443
	cmpwi 0,11,10
	bc 12,2,.L443
	cmpwi 0,11,35
	bc 12,2,.L443
	cmpwi 0,11,91
	bc 12,2,.L443
	lis 4,.LC248@ha
	mr 3,26
	la 4,.LC248@l(4)
	li 29,0
	bl strtok
	lis 9,option@ha
	lis 11,gi@ha
	mr 31,3
	la 30,option@l(9)
	la 28,gi@l(11)
.L449:
	lwz 4,0(30)
	mr 3,31
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L450
	lis 4,.LC249@ha
	li 3,0
	la 4,.LC249@l(4)
	addi 27,27,1
	bl strtok
	mr 29,3
	li 8,0
	cmpwi 0,29,0
	mr 10,29
	bc 12,2,.L452
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L452
	lis 9,_ctype_@ha
	lis 7,_ctype_@ha
	lwz 11,_ctype_@l(9)
	add 11,0,11
	lbz 0,1(11)
	b .L467
.L455:
	addic. 10,10,1
	bc 12,2,.L452
	lbz 0,0(10)
	cmpwi 0,0,0
	bc 12,2,.L452
	lwz 9,_ctype_@l(7)
	add 9,0,9
	lbz 0,1(9)
.L467:
	andi. 9,0,4
	bc 4,2,.L455
	li 8,1
.L452:
	cmpwi 0,8,0
	bc 12,2,.L457
	lwz 0,28(28)
	lis 3,.LC250@ha
	mr 4,29
	la 3,.LC250@l(3)
	mr 5,31
	mr 6,25
	mtlr 0
	crxor 6,6,6
	blrl
	b .L443
.L457:
	lis 4,.LC27@ha
	mr 3,31
	la 4,.LC27@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L459
	lwz 0,148(28)
	lis 3,.LC251@ha
	mr 4,29
	la 3,.LC251@l(3)
	mtlr 0
	blrl
	b .L443
.L459:
	mr 3,29
	bl atoi
	lwz 9,4(30)
	stw 3,0(9)
	b .L443
.L450:
	addi 29,29,1
	addi 30,30,8
	cmplwi 0,29,24
	bc 4,1,.L449
.L443:
	mr 3,26
	li 4,256
	mr 5,24
	bl fgets
	mr. 31,3
	bc 4,2,.L445
	lis 9,feathers@ha
	lwz 0,feathers@l(9)
	cmpwi 0,0,15
	bc 4,1,.L463
	li 0,15
	stw 0,feathers@l(23)
.L463:
	lwz 0,feathers@l(23)
	cmpwi 0,0,0
	bc 12,1,.L464
	li 0,1
	stw 0,feathers@l(23)
.L464:
	lis 9,kickback@ha
	lwz 4,kickback@l(9)
	cmplwi 0,4,20
	bc 4,1,.L465
	lis 9,gi+4@ha
	lis 3,.LC252@ha
	lwz 0,gi+4@l(9)
	la 3,.LC252@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,5
	stw 0,kickback@l(22)
.L465:
	lis 9,teams@ha
	lwz 0,teams@l(9)
	cmpwi 0,0,0
	bc 12,2,.L466
	li 0,1
	lis 9,chickenGame@ha
	lis 11,dropDelay@ha
	lis 10,canDrop@ha
	stw 0,chickenGame@l(9)
	stw 31,dropDelay@l(11)
	stw 0,canDrop@l(10)
.L466:
	lis 9,gi+4@ha
	lis 3,.LC253@ha
	lwz 0,gi+4@l(9)
	la 3,.LC253@l(3)
	mr 4,27
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,24
	bl fclose
	lis 9,alreadyRead.149@ha
	li 0,1
	stw 0,alreadyRead.149@l(9)
.L440:
	lwz 0,436(1)
	mtlr 0
	lmw 22,392(1)
	la 1,432(1)
	blr
.Lfe28:
	.size	 Chicken_ReadIni,.Lfe28-Chicken_ReadIni
	.section	".sdata","aw"
	.align 2
	.type	 lastModTime.153,@object
	.size	 lastModTime.153,4
lastModTime.153:
	.long 0
	.section	".rodata"
	.align 2
.LC254:
	.string	"maplist.ini"
	.align 2
.LC255:
	.string	"Reading map list %s.. \n"
	.align 2
.LC256:
	.string	"%d maps listed\n"
	.section	".text"
	.align 2
	.type	 Chicken_ReadMapList,@function
Chicken_ReadMapList:
	stwu 1,-512(1)
	mflr 0
	stmw 21,468(1)
	stw 0,516(1)
	lis 9,gi@ha
	lis 3,.LC242@ha
	la 30,gi@l(9)
	lis 4,.LC86@ha
	lwz 9,144(30)
	la 4,.LC86@l(4)
	li 5,0
	la 3,.LC242@l(3)
	li 25,0
	mtlr 9
	li 31,1
	lis 21,gi@ha
	blrl
	lwz 5,4(3)
	lis 4,.LC245@ha
	lis 6,.LC254@ha
	la 6,.LC254@l(6)
	la 4,.LC245@l(4)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	addi 3,1,8
	addi 4,1,392
	bl stat
	cmpwi 0,3,0
	bc 12,2,.L469
	lwz 0,4(30)
	lis 3,.LC246@ha
	lis 4,.LC254@ha
	la 4,.LC254@l(4)
	la 3,.LC246@l(3)
	mtlr 0
	li 31,0
	crxor 6,6,6
	blrl
	b .L470
.L469:
	lis 11,lastModTime.153@ha
	lwz 9,424(1)
	lwz 0,lastModTime.153@l(11)
	cmpw 0,9,0
	bc 12,2,.L471
	stw 9,lastModTime.153@l(11)
	b .L470
.L471:
	li 31,0
.L470:
	cmpwi 0,31,0
	bc 12,2,.L468
	lis 4,.LC154@ha
	addi 3,1,8
	la 4,.LC154@l(4)
	bl fopen
	mr. 26,3
	bc 4,2,.L474
	lis 9,gi+4@ha
	lis 3,.LC246@ha
	lwz 0,gi+4@l(9)
	lis 4,.LC254@ha
	la 3,.LC246@l(3)
	la 4,.LC254@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L468
.L474:
	lis 9,levelTail@ha
	lis 22,levelTail@ha
	lwz 10,levelTail@l(9)
	cmpwi 0,10,0
	bc 12,2,.L475
	lwz 0,4(10)
	lis 9,levelList@ha
	li 11,0
	lis 24,levelList@ha
	stw 0,levelList@l(9)
	stw 11,4(10)
	b .L476
.L475:
	lis 9,levelList@ha
	lis 24,levelList@ha
	stw 10,levelList@l(9)
.L476:
	lis 9,levelList@ha
	addi 28,1,136
	lwz 0,levelList@l(9)
	cmpwi 0,0,0
	bc 12,2,.L478
	lis 9,gi@ha
	lis 30,levelList@ha
	la 31,gi@l(9)
.L479:
	lwz 9,levelList@l(30)
	lwz 11,136(31)
	mr 3,9
	lwz 29,4(9)
	mtlr 11
	blrl
	cmpwi 0,29,0
	stw 29,levelList@l(30)
	bc 4,2,.L479
.L478:
	lis 9,gi+4@ha
	lis 3,.LC255@ha
	lwz 11,gi+4@l(9)
	lis 4,.LC254@ha
	la 3,.LC255@l(3)
	la 4,.LC254@l(4)
	lis 9,levelTail@ha
	mtlr 11
	li 0,0
	lis 27,levelTail@ha
	stw 0,levelTail@l(9)
	lis 23,.LC248@ha
	crxor 6,6,6
	blrl
	b .L481
.L483:
	lbz 11,136(1)
	xori 9,11,9
	xori 0,11,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L481
	cmpwi 0,11,10
	bc 12,2,.L481
	cmpwi 0,11,35
	bc 12,2,.L481
	cmpwi 0,11,91
	bc 12,2,.L481
	la 4,.LC248@l(23)
	mr 3,28
	bl strtok
	la 30,gi@l(21)
	lwz 9,132(30)
	mr 31,3
	li 4,765
	li 3,8
	mtlr 9
	blrl
	mr. 29,3
	bc 12,2,.L486
	mr 3,31
	bl strlen
	lwz 0,132(30)
	addi 3,3,1
	li 4,765
	mtlr 0
	blrl
	cmpwi 0,3,0
	stw 3,0(29)
	bc 4,2,.L485
.L486:
	li 3,-1
	bl exit
.L485:
	mr 4,31
	bl strcpy
	lwz 0,levelList@l(24)
	cmpwi 0,0,0
	bc 4,2,.L488
	stw 29,4(29)
	stw 29,levelTail@l(22)
	stw 29,levelList@l(24)
	b .L487
.L488:
	lwz 9,levelTail@l(27)
	lwz 0,4(9)
	stw 0,4(29)
	stw 29,4(9)
	stw 29,levelTail@l(27)
.L487:
	addi 25,25,1
.L481:
	mr 3,28
	li 4,256
	mr 5,26
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L483
	lis 9,gi+4@ha
	lis 3,.LC256@ha
	lwz 0,gi+4@l(9)
	la 3,.LC256@l(3)
	mr 4,25
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,26
	bl fclose
.L468:
	lwz 0,516(1)
	mtlr 0
	lmw 21,468(1)
	la 1,512(1)
	blr
.Lfe29:
	.size	 Chicken_ReadMapList,.Lfe29-Chicken_ReadMapList
	.section	".sdata","aw"
	.align 2
	.type	 lastModTime.157,@object
	.size	 lastModTime.157,4
lastModTime.157:
	.long 0
	.section	".rodata"
	.align 2
.LC257:
	.string	"motd.ini"
	.align 2
.LC258:
	.string	"\nReading New MOTD %s.. \n"
	.align 2
.LC259:
	.string	"%-30.30s"
	.section	".text"
	.align 2
	.type	 Chicken_MOTDLoad,@function
Chicken_MOTDLoad:
	stwu 1,-480(1)
	mflr 0
	stmw 27,460(1)
	stw 0,484(1)
	lis 9,gi+144@ha
	lis 3,.LC242@ha
	lwz 0,gi+144@l(9)
	lis 4,.LC86@ha
	li 5,0
	la 4,.LC86@l(4)
	la 3,.LC242@l(3)
	mtlr 0
	li 31,1
	blrl
	lwz 5,4(3)
	lis 4,.LC245@ha
	lis 6,.LC257@ha
	la 6,.LC257@l(6)
	la 4,.LC245@l(4)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	addi 3,1,8
	addi 4,1,392
	bl stat
	cmpwi 0,3,0
	bc 4,2,.L494
	lis 11,lastModTime.157@ha
	lwz 9,424(1)
	lwz 0,lastModTime.157@l(11)
	cmpw 0,9,0
	bc 12,2,.L494
	stw 9,lastModTime.157@l(11)
	b .L493
.L494:
	li 31,0
.L493:
	cmpwi 0,31,0
	bc 12,2,.L491
	lis 4,.LC154@ha
	addi 3,1,8
	la 4,.LC154@l(4)
	bl fopen
	mr. 28,3
	bc 12,2,.L491
	lis 9,gi+4@ha
	lis 3,.LC258@ha
	lwz 0,gi+4@l(9)
	lis 4,.LC257@ha
	la 3,.LC258@l(3)
	la 4,.LC257@l(4)
	addi 29,1,136
	mtlr 0
	li 31,0
	mr 30,29
	crxor 6,6,6
	blrl
	lis 9,motd1@ha
	lis 11,motd2@ha
	lis 10,motd3@ha
	lis 8,motd4@ha
	stb 31,motd1@l(9)
	la 27,motd1@l(9)
	stb 31,motd2@l(11)
	mr 3,29
	stb 31,motd3@l(10)
	li 4,256
	mr 5,28
	stb 31,motd4@l(8)
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L498
	mr 3,30
	li 4,10
	bl strchr
	mr. 3,3
	bc 12,2,.L499
	stb 31,0(3)
.L499:
	lis 4,.LC259@ha
	mr 3,27
	la 4,.LC259@l(4)
	mr 5,30
	crxor 6,6,6
	bl sprintf
.L498:
	mr 3,30
	li 4,256
	mr 5,28
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L500
	mr 3,30
	li 4,10
	bl strchr
	mr. 3,3
	bc 12,2,.L501
	li 0,0
	stb 0,0(3)
.L501:
	lis 3,motd2@ha
	lis 4,.LC259@ha
	la 3,motd2@l(3)
	la 4,.LC259@l(4)
	mr 5,30
	crxor 6,6,6
	bl sprintf
.L500:
	mr 3,30
	li 4,256
	mr 5,28
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L502
	mr 3,30
	li 4,10
	bl strchr
	mr. 3,3
	bc 12,2,.L503
	li 0,0
	stb 0,0(3)
.L503:
	lis 3,motd3@ha
	lis 4,.LC259@ha
	la 3,motd3@l(3)
	la 4,.LC259@l(4)
	mr 5,30
	crxor 6,6,6
	bl sprintf
.L502:
	mr 3,30
	li 4,256
	mr 5,28
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L504
	mr 3,30
	li 4,10
	bl strchr
	mr. 3,3
	bc 12,2,.L505
	li 0,0
	stb 0,0(3)
.L505:
	lis 3,motd4@ha
	lis 4,.LC259@ha
	la 3,motd4@l(3)
	la 4,.LC259@l(4)
	mr 5,30
	crxor 6,6,6
	bl sprintf
.L504:
	mr 3,28
	bl fclose
.L491:
	lwz 0,484(1)
	mtlr 0
	lmw 27,460(1)
	la 1,480(1)
	blr
.Lfe30:
	.size	 Chicken_MOTDLoad,.Lfe30-Chicken_MOTDLoad
	.section	".sdata","aw"
	.align 2
	.type	 checkNext.164,@object
	.size	 checkNext.164,4
checkNext.164:
	.long 0
	.section	".rodata"
	.align 2
.LC260:
	.string	"Sorry you couldnt score. Try now\n"
	.align 2
.LC261:
	.string	"Chicken had lost its way and was respawned\n"
	.align 2
.LC262:
	.long 0x0
	.align 3
.LC263:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC264:
	.long 0x41200000
	.section	".text"
	.align 2
	.type	 Chicken_EnsureExists,@function
Chicken_EnsureExists:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 9,.LC262@ha
	lis 11,deathmatch@ha
	la 9,.LC262@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L518
	lis 9,chickenGame@ha
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L518
	lis 8,checkNext.164@ha
	lwz 0,checkNext.164@l(8)
	lis 10,0x4330
	lis 9,.LC263@ha
	la 9,.LC263@l(9)
	xoris 0,0,0x8000
	lfd 13,0(9)
	stw 0,12(1)
	lis 9,level+4@ha
	stw 10,8(1)
	lfd 0,8(1)
	lfs 12,level+4@l(9)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L518
	lis 11,.LC264@ha
	lis 9,globals+72@ha
	la 11,.LC264@l(11)
	lwz 0,globals+72@l(9)
	li 28,1
	lfs 0,0(11)
	lis 9,g_edicts@ha
	li 29,0
	lwz 10,g_edicts@l(9)
	cmpw 0,28,0
	lis 9,clientCount@ha
	lis 24,globals@ha
	fadds 0,12,0
	stw 29,clientCount@l(9)
	addi 31,10,896
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	stw 11,checkNext.164@l(8)
	bc 4,0,.L521
	lis 9,gi@ha
	lis 25,clientCount@ha
	la 26,gi@l(9)
	lis 27,chickenItemIndex@ha
.L523:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L522
	lwz 8,84(31)
	cmpwi 0,8,0
	bc 12,2,.L526
	lwz 0,chickenItemIndex@l(27)
	addi 11,8,740
	lwz 9,clientCount@l(25)
	slwi 0,0,2
	lwzx 10,11,0
	addi 9,9,1
	stw 9,clientCount@l(25)
	cmpwi 0,10,0
	bc 4,1,.L526
	lwz 0,3764(8)
	srawi 11,0,31
	xor 9,11,0
	subf 9,9,11
	srawi 9,9,31
	addi 0,9,1
	and 9,29,9
	or 29,9,0
.L526:
	lwz 3,280(31)
	lis 4,.LC70@ha
	la 4,.LC70@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L527
	lwz 9,52(26)
	addi 3,31,4
	mtlr 9
	blrl
	rlwinm 3,3,0,30,31
	neg 3,3
	srawi 3,3,31
	addi 0,3,1
	and 3,29,3
	or 29,3,0
.L527:
	lis 9,teams@ha
	lwz 0,teams@l(9)
	cmpwi 0,0,0
	bc 12,2,.L522
	lwz 11,84(31)
	cmpwi 0,11,0
	bc 12,2,.L522
	lwz 0,chickenItemIndex@l(27)
	addi 9,11,740
	slwi 0,0,2
	lwzx 30,9,0
	cmpwi 0,30,0
	bc 4,2,.L522
	lwz 0,3768(11)
	cmpwi 0,0,0
	bc 12,2,.L522
	lwz 9,8(26)
	lis 5,.LC260@ha
	mr 3,31
	la 5,.LC260@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	stw 30,3768(9)
.L522:
	la 9,globals@l(24)
	addi 28,28,1
	lwz 0,72(9)
	addi 31,31,896
	cmpw 0,28,0
	bc 12,0,.L523
.L521:
	cmpwi 0,29,0
	bc 4,2,.L518
	bl Chicken_Spawn
	lis 9,gi@ha
	lis 4,.LC261@ha
	lwz 0,gi@l(9)
	la 4,.LC261@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L518:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe31:
	.size	 Chicken_EnsureExists,.Lfe31-Chicken_EnsureExists
	.section	".rodata"
	.align 2
.LC265:
	.string	"\001"
	.align 2
.LC266:
	.string	"\002"
	.align 2
.LC267:
	.string	"\003\n"
	.align 2
.LC268:
	.string	"%s\006     CATCH the CHICKEN %s     \004\n\006                                \004\n\006 %-30.30s \004\n\006 %-30.30s \004\n\006 %-30.30s \004\n\006 %-30.30s \004\n\006                                \004\n"
	.align 2
.LC269:
	.string	"\007"
	.align 2
.LC270:
	.string	"\b"
	.align 2
.LC271:
	.string	"\t"
	.align 2
.LC272:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl Chicken_MOTD
	.type	 Chicken_MOTD,@function
Chicken_MOTD:
	stwu 1,-2080(1)
	mflr 0
	stmw 27,2060(1)
	stw 0,2084(1)
	mr 28,3
	lwz 11,84(28)
	cmpwi 0,11,0
	bc 12,2,.L534
	lis 9,MOTDDuration@ha
	lwz 0,MOTDDuration@l(9)
	cmpwi 0,0,0
	bc 12,2,.L534
	lis 9,level+4@ha
	lfs 13,3744(11)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L534
	lis 3,motd1@ha
	lis 31,motd3@ha
	la 3,motd1@l(3)
	lis 30,motd4@ha
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L535
	lis 3,motd2@ha
	la 3,motd2@l(3)
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L535
	la 3,motd3@l(31)
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L535
	la 3,motd4@l(30)
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L534
.L535:
	addi 3,1,1032
	lis 4,.LC265@ha
	mr 30,3
	la 4,.LC265@l(4)
	lis 29,.LC266@ha
	crxor 6,6,6
	bl sprintf
	lis 27,.LC270@ha
	li 31,32
.L539:
	mr 3,30
	la 4,.LC266@l(29)
	bl strcat
	addic. 31,31,-1
	bc 4,2,.L539
	lis 4,.LC267@ha
	mr 3,30
	la 4,.LC267@l(4)
	li 31,32
	bl strcat
	lis 4,.LC268@ha
	lis 6,.LC219@ha
	lis 7,motd1@ha
	lis 8,motd2@ha
	lis 9,motd3@ha
	lis 10,motd4@ha
	la 4,.LC268@l(4)
	mr 5,30
	la 6,.LC219@l(6)
	la 7,motd1@l(7)
	la 8,motd2@l(8)
	la 9,motd3@l(9)
	la 10,motd4@l(10)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	lis 4,.LC269@ha
	addi 3,1,8
	la 4,.LC269@l(4)
	bl strcat
.L544:
	addi 3,1,8
	la 4,.LC270@l(27)
	bl strcat
	addic. 31,31,-1
	bc 4,2,.L544
	lis 4,.LC271@ha
	addi 3,1,8
	la 4,.LC271@l(4)
	bl strcat
	lis 9,gi+12@ha
	mr 3,28
	lwz 0,gi+12@l(9)
	addi 4,1,8
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,.LC272@ha
	lis 9,level+4@ha
	la 11,.LC272@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	lwz 11,84(28)
	fadds 0,0,13
	stfs 0,3744(11)
.L534:
	lwz 0,2084(1)
	mtlr 0
	lmw 27,2060(1)
	la 1,2080(1)
	blr
.Lfe32:
	.size	 Chicken_MOTD,.Lfe32-Chicken_MOTD
	.section	".rodata"
	.align 2
.LC273:
	.string	"Chicken droppable after %-3d "
	.align 2
.LC274:
	.string	"Chicken is not droppable    "
	.align 2
.LC275:
	.string	"Chicken respawns after %-3d  "
	.align 2
.LC276:
	.string	"Chicken does not respawn    "
	.align 2
.LC277:
	.ascii	"%s\006     CATCH the CHICKEN %s     \004\n\006              "
	.ascii	"                  \004\n\006 Game Settings                  "
	.ascii	"\004\n\006                                \004\n\006 - Chick"
	.ascii	"en score period"
	.string	" is %3d  \004\n\006 - %s \004\n\006 - %s \004\n\006 - Chicken respawns %s  \004\n\006 - Chicken player %s glow%s \004\n\006 - Menu access %s allowed%s   \004\n\006 - Camera mode %s allowed%s   \004\n\006 - Observer mode %s allowed%s \004\n\006 - Players %s score on death%s  \004\n\006                                \004\n"
	.align 2
.LC278:
	.string	"anywhere  "
	.align 2
.LC279:
	.string	"fartherest"
	.align 2
.LC280:
	.string	"does"
	.align 2
.LC281:
	.string	"does not"
	.align 2
.LC282:
	.string	"    "
	.align 2
.LC283:
	.string	"is"
	.align 2
.LC284:
	.string	"is not"
	.align 2
.LC285:
	.string	"do"
	.align 2
.LC286:
	.string	"dont"
	.align 2
.LC287:
	.string	"  "
	.align 2
.LC288:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl Chicken_Banner
	.type	 Chicken_Banner,@function
Chicken_Banner:
	stwu 1,-2384(1)
	mflr 0
	stmw 25,2356(1)
	stw 0,2388(1)
	mr 28,3
	lwz 11,84(28)
	cmpwi 0,11,0
	bc 12,2,.L547
	lis 9,level+4@ha
	lfs 13,3744(11)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L547
	lis 9,canDrop@ha
	lwz 0,canDrop@l(9)
	cmpwi 0,0,0
	bc 12,2,.L548
	lis 9,dropDelay@ha
	lis 4,.LC273@ha
	lwz 5,dropDelay@l(9)
	la 4,.LC273@l(4)
	addi 3,1,48
	crxor 6,6,6
	bl sprintf
	b .L549
.L548:
	lis 4,.LC274@ha
	addi 3,1,48
	la 4,.LC274@l(4)
	crxor 6,6,6
	bl sprintf
.L549:
	lis 9,autoRespawn@ha
	lwz 0,autoRespawn@l(9)
	cmpwi 0,0,0
	bc 12,2,.L550
	lis 9,autorespawntime@ha
	addi 0,1,176
	lis 4,.LC275@ha
	lwz 5,autorespawntime@l(9)
	mr 3,0
	la 4,.LC275@l(4)
	mr 25,0
	crxor 6,6,6
	bl sprintf
	b .L551
.L550:
	addi 29,1,176
	lis 4,.LC276@ha
	la 4,.LC276@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	mr 25,29
.L551:
	addi 3,1,1328
	lis 4,.LC265@ha
	mr 27,3
	la 4,.LC265@l(4)
	crxor 6,6,6
	bl sprintf
	lis 30,.LC266@ha
	lis 26,.LC270@ha
	addi 29,1,304
	li 31,32
.L555:
	mr 3,27
	la 4,.LC266@l(30)
	bl strcat
	addic. 31,31,-1
	bc 4,2,.L555
	lis 4,.LC267@ha
	mr 3,27
	la 4,.LC267@l(4)
	bl strcat
	lis 9,randomSpawn@ha
	lis 11,scorePeriod@ha
	lwz 0,randomSpawn@l(9)
	lwz 7,scorePeriod@l(11)
	cmpwi 0,0,0
	bc 12,2,.L557
	lis 9,.LC278@ha
	la 10,.LC278@l(9)
	b .L558
.L557:
	lis 9,.LC279@ha
	la 10,.LC279@l(9)
.L558:
	lis 9,allowGlow@ha
	lwz 0,allowGlow@l(9)
	cmpwi 0,0,0
	bc 12,2,.L559
	lis 9,.LC280@ha
	la 9,.LC280@l(9)
	b .L584
.L559:
	lis 9,.LC281@ha
	la 9,.LC281@l(9)
.L584:
	stw 9,8(1)
	lis 9,allowGlow@ha
	lwz 0,allowGlow@l(9)
	cmpwi 0,0,0
	bc 12,2,.L561
	lis 9,.LC282@ha
	la 9,.LC282@l(9)
	b .L585
.L561:
	lis 9,.LC86@ha
	la 9,.LC86@l(9)
.L585:
	stw 9,12(1)
	lis 9,menuAllowed@ha
	lwz 0,menuAllowed@l(9)
	cmpwi 0,0,0
	bc 12,2,.L563
	lis 9,.LC283@ha
	la 9,.LC283@l(9)
	b .L586
.L563:
	lis 9,.LC284@ha
	la 9,.LC284@l(9)
.L586:
	stw 9,16(1)
	lis 9,menuAllowed@ha
	lwz 0,menuAllowed@l(9)
	cmpwi 0,0,0
	bc 12,2,.L565
	lis 9,.LC282@ha
	la 9,.LC282@l(9)
	b .L587
.L565:
	lis 9,.LC86@ha
	la 9,.LC86@l(9)
.L587:
	stw 9,20(1)
	lis 9,cameraAllowed@ha
	lwz 0,cameraAllowed@l(9)
	cmpwi 0,0,0
	bc 12,2,.L567
	lis 9,.LC283@ha
	la 9,.LC283@l(9)
	b .L588
.L567:
	lis 9,.LC284@ha
	la 9,.LC284@l(9)
.L588:
	stw 9,24(1)
	lis 9,cameraAllowed@ha
	lwz 0,cameraAllowed@l(9)
	cmpwi 0,0,0
	bc 12,2,.L569
	lis 9,.LC282@ha
	la 9,.LC282@l(9)
	b .L589
.L569:
	lis 9,.LC86@ha
	la 9,.LC86@l(9)
.L589:
	stw 9,28(1)
	lis 9,observerAllowed@ha
	lwz 0,observerAllowed@l(9)
	cmpwi 0,0,0
	bc 12,2,.L571
	lis 9,.LC283@ha
	la 9,.LC283@l(9)
	b .L590
.L571:
	lis 9,.LC284@ha
	la 9,.LC284@l(9)
.L590:
	stw 9,32(1)
	lis 9,observerAllowed@ha
	lwz 0,observerAllowed@l(9)
	cmpwi 0,0,0
	bc 12,2,.L573
	lis 9,.LC282@ha
	la 9,.LC282@l(9)
	b .L591
.L573:
	lis 9,.LC86@ha
	la 9,.LC86@l(9)
.L591:
	stw 9,36(1)
	lis 9,scoreOnDeath@ha
	lwz 0,scoreOnDeath@l(9)
	cmpwi 0,0,0
	bc 12,2,.L575
	lis 9,.LC285@ha
	la 9,.LC285@l(9)
	b .L592
.L575:
	lis 9,.LC286@ha
	la 9,.LC286@l(9)
.L592:
	stw 9,40(1)
	lis 9,scoreOnDeath@ha
	lwz 0,scoreOnDeath@l(9)
	cmpwi 0,0,0
	bc 12,2,.L577
	lis 9,.LC287@ha
	la 9,.LC287@l(9)
	b .L593
.L577:
	lis 9,.LC86@ha
	la 9,.LC86@l(9)
.L593:
	stw 9,44(1)
	lis 4,.LC277@ha
	lis 6,.LC219@ha
	la 4,.LC277@l(4)
	la 6,.LC219@l(6)
	mr 5,27
	mr 9,25
	addi 8,1,48
	mr 3,29
	crxor 6,6,6
	bl sprintf
	li 31,32
	lis 4,.LC269@ha
	mr 3,29
	la 4,.LC269@l(4)
	bl strcat
.L582:
	mr 3,29
	la 4,.LC270@l(26)
	bl strcat
	addic. 31,31,-1
	bc 4,2,.L582
	lis 4,.LC271@ha
	mr 3,29
	la 4,.LC271@l(4)
	bl strcat
	lis 9,gi+12@ha
	mr 4,29
	lwz 0,gi+12@l(9)
	mr 3,28
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,.LC288@ha
	lis 9,level+4@ha
	la 11,.LC288@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	lwz 11,84(28)
	fadds 0,0,13
	stfs 0,3744(11)
.L547:
	lwz 0,2388(1)
	mtlr 0
	lmw 25,2356(1)
	la 1,2384(1)
	blr
.Lfe33:
	.size	 Chicken_Banner,.Lfe33-Chicken_Banner
	.section	".rodata"
	.align 2
.LC289:
	.string	"xv %d yv %d string \"%4d\" "
	.align 2
.LC290:
	.string	"xv %d "
	.align 2
.LC291:
	.string	"yv %d string \"%-8.8s\" "
	.align 2
.LC292:
	.string	"More ..."
	.align 2
.LC293:
	.string	"yv %d string2 \"%-12.12s %3d\" "
	.align 2
.LC294:
	.string	"yv %d string \"%-12.12s %3d\" "
	.section	".text"
	.align 2
	.globl Chicken_TCTCScoreboard
	.type	 Chicken_TCTCScoreboard,@function
Chicken_TCTCScoreboard:
	stwu 1,-1248(1)
	mflr 0
	stmw 14,1176(1)
	stw 0,1252(1)
	lis 9,chickenGame@ha
	li 31,0
	lwz 0,chickenGame@l(9)
	li 23,14
	cmpwi 0,0,0
	bc 12,2,.L595
	lis 9,teams@ha
	lwz 0,teams@l(9)
	cmpwi 0,0,0
	bc 12,2,.L595
	addi 3,1,8
	li 4,0
	li 5,1024
	li 25,0
	crxor 6,6,6
	bl memset
	li 10,4
	lis 9,teams@ha
	mtctr 10
	lwz 11,teams@l(9)
.L636:
	sraw 0,11,25
	addi 9,31,1
	andi. 10,0,1
	addi 25,25,1
	mfcr 0
	rlwinm 0,0,3,1
	neg 0,0
	andc 9,9,0
	and 0,31,0
	or 31,0,9
	bdnz .L636
	cmpwi 7,31,3
	li 11,0
	li 25,0
	addi 24,1,1032
	mfcr 9
	rlwinm 9,9,29,1
	neg 9,9
	nor 0,9,9
	and 9,23,9
	rlwinm 0,0,0,29,31
	or 23,9,0
.L606:
	lis 9,teams@ha
	addi 10,25,1
	lwz 0,teams@l(9)
	stw 10,1160(1)
	sraw 0,0,25
	andi. 9,0,1
	bc 12,2,.L605
	addi 0,11,1
	cmpwi 7,11,1
	mulli 9,25,60
	andi. 10,0,1
	mr 14,0
	lis 11,teamDetails+24@ha
	lis 4,.LC289@ha
	mfcr 0
	rlwinm 0,0,30,1
	la 11,teamDetails+24@l(11)
	mfcr 29
	rlwinm 29,29,3,1
	neg 30,0
	lwzx 7,11,9
	neg 29,29
	andi. 6,30,123
	nor 5,29,29
	andi. 0,29,261
	andi. 5,5,117
	ori 6,6,35
	or 5,0,5
	la 4,.LC289@l(4)
	mr 3,24
	li 19,0
	crxor 6,6,6
	bl sprintf
	li 27,0
	mr 20,24
	mr 4,24
	addi 3,1,8
	bl strcat
	nor 5,29,29
	lis 4,.LC290@ha
	rlwinm 5,5,0,27,28
	andi. 29,29,168
	or 5,29,5
	la 4,.LC290@l(4)
	mr 3,24
	crxor 6,6,6
	bl sprintf
	addi 3,1,8
	mr 4,24
	bl strcat
	lis 9,game@ha
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,19,0
	bc 4,0,.L615
	lis 9,game@ha
	slwi 18,23,3
	mr 29,30
	la 16,game@l(9)
	add 15,18,23
	mr 17,20
	li 21,0
	li 22,0
	li 28,47
	li 31,0
	li 26,47
	li 30,47
.L617:
	lis 11,g_edicts@ha
	lwz 0,1028(16)
	lwz 9,g_edicts@l(11)
	add 6,0,22
	add 9,21,9
	lwz 0,984(9)
	cmpwi 0,0,0
	bc 12,2,.L616
	lwz 0,3760(6)
	cmpw 0,0,25
	bc 4,2,.L619
	addi 0,23,-1
	cmpw 0,27,0
	bc 4,2,.L620
	addi 5,31,135
	andc 0,30,29
	and 5,5,29
	lis 4,.LC291@ha
	lis 6,.LC292@ha
	or 5,5,0
	la 4,.LC291@l(4)
	la 6,.LC292@l(6)
	mr 3,17
	addi 28,15,47
	crxor 6,6,6
	bl sprintf
	mr 30,28
	add 31,18,23
	addi 3,1,8
	mr 4,17
	bl strcat
	mr 26,30
	mr 27,23
	b .L619
.L620:
	lis 9,chickenItemIndex@ha
	addi 11,6,740
	lwz 0,chickenItemIndex@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,1,.L624
	lwz 0,3764(6)
	cmpwi 0,0,0
	bc 4,2,.L624
	lwz 9,184(6)
	addi 5,31,135
	andc 0,26,29
	and 5,5,29
	lis 4,.LC293@ha
	cmpwi 7,9,1000
	or 5,5,0
	la 4,.LC293@l(4)
	addi 6,6,700
	mr 3,20
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 7,0,0
	and 9,9,0
	andi. 7,7,999
	or 7,9,7
	crxor 6,6,6
	bl sprintf
	b .L628
.L624:
	lwz 9,184(6)
	addi 5,31,135
	andc 0,28,29
	and 5,5,29
	lis 4,.LC294@ha
	cmpwi 7,9,1000
	or 5,5,0
	la 4,.LC294@l(4)
	addi 6,6,700
	mr 3,20
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 7,0,0
	and 9,9,0
	andi. 7,7,999
	or 7,9,7
	crxor 6,6,6
	bl sprintf
.L628:
	addi 3,1,8
	mr 4,20
	bl strcat
	addi 28,28,9
	addi 31,31,9
	addi 26,26,9
	addi 30,30,9
	addi 27,27,1
.L619:
	cmpw 0,27,23
	bc 4,0,.L615
.L616:
	lwz 0,1544(16)
	addi 19,19,1
	addi 21,21,896
	addi 22,22,3832
	cmpw 0,19,0
	bc 12,0,.L617
.L615:
	mr 11,14
.L605:
	lwz 25,1160(1)
	cmpwi 0,25,3
	bc 4,1,.L606
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	addi 3,1,8
	mtlr 0
	blrl
	li 3,1
	b .L635
.L595:
	li 3,0
.L635:
	lwz 0,1252(1)
	mtlr 0
	lmw 14,1176(1)
	la 1,1248(1)
	blr
.Lfe34:
	.size	 Chicken_TCTCScoreboard,.Lfe34-Chicken_TCTCScoreboard
	.section	".rodata"
	.align 2
.LC295:
	.string	"You cannot cheat while holding the chicken\n"
	.align 2
.LC297:
	.string	"Catch the Chicken must be started with teamplay\n"
	.align 2
.LC298:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_CanPickupHealth
	.type	 Chicken_CanPickupHealth,@function
Chicken_CanPickupHealth:
	lwz 0,532(3)
	cmpwi 0,0,2
	bc 4,2,.L678
	lis 9,deathmatch@ha
	lis 11,.LC298@ha
	lwz 10,deathmatch@l(9)
	la 11,.LC298@l(11)
	li 7,1
	lfs 13,0(11)
	lfs 0,20(10)
	lis 11,allowSmallHealth@ha
	lwz 8,allowSmallHealth@l(11)
	fcmpu 0,0,13
	bc 12,2,.L680
	lis 9,chickenGame@ha
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L680
	lwz 4,84(4)
	cmpwi 0,4,0
	bc 12,2,.L680
	lis 9,chickenItemIndex@ha
	addi 11,4,740
	lwz 0,chickenItemIndex@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,1,.L680
	lwz 0,3764(4)
	subfic 11,8,0
	adde 9,11,8
	subfic 11,0,0
	adde 0,11,0
	and. 11,0,9
	mfcr 7
	rlwinm 7,7,3,1
.L680:
	cmpwi 0,7,0
	bc 4,2,.L682
	li 3,0
	blr
.L678:
	lis 9,deathmatch@ha
	lis 11,.LC298@ha
	lwz 10,deathmatch@l(9)
	la 11,.LC298@l(11)
	li 7,1
	lfs 13,0(11)
	lfs 0,20(10)
	lis 11,allowBigHealth@ha
	lwz 8,allowBigHealth@l(11)
	fcmpu 0,0,13
	bc 12,2,.L684
	lis 9,chickenGame@ha
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L684
	lwz 4,84(4)
	cmpwi 0,4,0
	bc 12,2,.L684
	lis 9,chickenItemIndex@ha
	addi 11,4,740
	lwz 0,chickenItemIndex@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,1,.L684
	lwz 0,3764(4)
	subfic 11,8,0
	adde 9,11,8
	subfic 11,0,0
	adde 0,11,0
	and. 11,0,9
	mfcr 7
	rlwinm 7,7,3,1
.L684:
	cmpwi 0,7,0
	li 3,0
	bclr 12,2
.L682:
	li 3,1
	blr
.Lfe35:
	.size	 Chicken_CanPickupHealth,.Lfe35-Chicken_CanPickupHealth
	.comm	ctc_statusbar,2048,4
	.section	".rodata"
	.align 3
.LC299:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC300:
	.long 0x40100000
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_Drop
	.type	 Chicken_Drop,@function
Chicken_Drop:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	addic 0,31,-1
	subfe 9,0,31
	addic 11,4,-1
	subfe 0,11,4
	and. 11,9,0
	bc 12,2,.L32
	lwz 9,84(31)
	lwz 0,720(9)
	mr 8,9
	cmpwi 0,0,0
	bc 12,2,.L34
	lis 9,canDrop@ha
	lwz 0,canDrop@l(9)
	cmpwi 0,0,0
	bc 12,2,.L33
	lwz 0,3740(8)
	lis 10,0x4330
	lis 9,.LC299@ha
	xoris 0,0,0x8000
	la 9,.LC299@l(9)
	stw 0,20(1)
	stw 10,16(1)
	lfd 13,0(9)
	lfd 0,16(1)
	lis 9,level@ha
	la 9,level@l(9)
	lfs 12,4(9)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L33
.L34:
	mr 3,31
	bl Chicken_Toss
	b .L39
.L33:
	lis 9,level@ha
	lfs 13,3772(8)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,13,0
	bc 4,0,.L39
	lis 9,canDrop@ha
	lwz 0,canDrop@l(9)
	cmpwi 0,0,0
	bc 4,2,.L38
	lis 9,gi+8@ha
	lis 5,.LC77@ha
	lwz 0,gi+8@l(9)
	la 5,.LC77@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L38:
	lfs 0,4(30)
	lis 9,.LC300@ha
	la 9,.LC300@l(9)
	lfd 13,0(9)
	lwz 9,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3772(9)
	b .L39
.L32:
	lis 9,gi+4@ha
	lis 3,.LC78@ha
	lwz 0,gi+4@l(9)
	la 3,.LC78@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L39:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 Chicken_Drop,.Lfe36-Chicken_Drop
	.align 2
	.globl Chicken_Toss
	.type	 Chicken_Toss,@function
Chicken_Toss:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	addic 0,31,-1
	subfe 9,0,31
	addic 11,4,-1
	subfe 0,11,4
	and. 11,9,0
	bc 12,2,.L41
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L41
	lwz 0,3764(9)
	cmpwi 0,0,0
	bc 4,2,.L41
	bl Drop_Item
	mr. 3,3
	bc 12,2,.L42
	mr 4,31
	bl Chicken_Setup
.L42:
	bl Chicken_RemoveFromInventory
.L41:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe37:
	.size	 Chicken_Toss,.Lfe37-Chicken_Toss
	.align 2
	.globl Chicken_ScoreCheck
	.type	 Chicken_ScoreCheck,@function
Chicken_ScoreCheck:
	lis 9,chickenGame@ha
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bclr 12,2
	lis 9,scoreOnDeath@ha
	lwz 0,scoreOnDeath@l(9)
	cmpwi 0,0,0
	bclr 12,2
	lis 9,chickenItemIndex@ha
	lwz 3,84(3)
	lwz 0,chickenItemIndex@l(9)
	addi 11,3,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bclr 4,1
	lwz 0,3764(3)
	cmpwi 0,0,0
	bclr 4,2
	lwz 11,84(5)
	lwz 9,3424(11)
	addi 9,9,1
	stw 9,3424(11)
	blr
.Lfe38:
	.size	 Chicken_ScoreCheck,.Lfe38-Chicken_ScoreCheck
	.align 2
	.globl Chicken_CheckInPlayer
	.type	 Chicken_CheckInPlayer,@function
Chicken_CheckInPlayer:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 31,3
	la 29,gi@l(29)
	lis 3,.LC223@ha
	lwz 9,40(29)
	la 3,.LC223@l(3)
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC224@ha
	sth 3,164(9)
	lwz 0,40(29)
	la 3,.LC224@l(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	li 0,0
	sth 3,160(9)
	lwz 11,84(31)
	mr 3,31
	stw 0,3764(11)
	bl Chicken_CheckPlayerModel
	lis 9,chickenGame@ha
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L369
	lis 9,teams@ha
	lwz 0,teams@l(9)
	cmpwi 0,0,0
	bc 12,2,.L369
	lwz 11,84(31)
	lwz 0,3760(11)
	cmpwi 0,0,-1
	bc 12,2,.L370
	lwz 0,3736(11)
	cmpwi 0,0,0
	bc 12,2,.L370
	lwz 0,184(31)
	li 9,1
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	sth 9,154(11)
	b .L372
.L370:
	mr 3,31
	bl Chicken_Observer
	b .L372
.L369:
	lwz 0,184(31)
	li 11,1
	lwz 9,84(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	sth 11,154(9)
.L372:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe39:
	.size	 Chicken_CheckInPlayer,.Lfe39-Chicken_CheckInPlayer
	.section	".rodata"
	.align 3
.LC301:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Chicken_ObserverEnd
	.type	 Chicken_ObserverEnd,@function
Chicken_ObserverEnd:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	lwz 0,184(29)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	bl PutClientInServer
	lis 9,MOTDDuration@ha
	lwz 10,84(29)
	lwz 0,MOTDDuration@l(9)
	lis 7,0x4330
	lis 8,level+4@ha
	lis 9,.LC301@ha
	mr 3,29
	xoris 0,0,0x8000
	la 9,.LC301@l(9)
	stw 0,28(1)
	stw 7,24(1)
	lfd 12,0(9)
	lfd 0,24(1)
	li 9,1
	sth 9,154(10)
	lfs 13,level+4@l(8)
	fsub 0,0,12
	lwz 9,84(29)
	frsp 0,0
	fadds 13,13,0
	stfs 13,3748(9)
	bl Chicken_MOTD
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe40:
	.size	 Chicken_ObserverEnd,.Lfe40-Chicken_ObserverEnd
	.section	".rodata"
	.align 2
.LC302:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_Command
	.type	 Chicken_Command,@function
Chicken_Command:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC302@ha
	lis 9,deathmatch@ha
	la 11,.LC302@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L430
	lis 9,gi+8@ha
	lis 5,.LC237@ha
	lwz 0,gi+8@l(9)
	la 5,.LC237@l(5)
	b .L691
.L430:
	lis 9,menuAllowed@ha
	lwz 0,menuAllowed@l(9)
	cmpwi 0,0,0
	bc 4,2,.L432
	lis 9,gi+8@ha
	lis 5,.LC238@ha
	lwz 0,gi+8@l(9)
	la 5,.LC238@l(5)
.L691:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L431
.L432:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,192
	bc 4,2,.L434
	lwz 9,84(3)
	li 0,1
	stw 0,3728(9)
	b .L431
.L434:
	lis 9,gi+8@ha
	lis 5,.LC239@ha
	lwz 0,gi+8@l(9)
	la 5,.LC239@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L431:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe41:
	.size	 Chicken_Command,.Lfe41-Chicken_Command
	.align 2
	.globl Chicken_AllowPowerUp
	.type	 Chicken_AllowPowerUp,@function
Chicken_AllowPowerUp:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,chickenGame@ha
	mr 31,3
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L437
	lwz 4,84(4)
	cmpwi 0,4,0
	bc 12,2,.L437
	lis 9,chickenItemIndex@ha
	addi 11,4,740
	lwz 0,chickenItemIndex@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,1,.L437
	lwz 0,3764(4)
	cmpwi 0,0,0
	bc 4,2,.L437
	lis 9,allowInvulnerable@ha
	lwz 0,allowInvulnerable@l(9)
	cmpwi 0,0,0
	bc 4,2,.L438
	lwz 9,648(31)
	lis 4,.LC240@ha
	la 4,.LC240@l(4)
	lwz 3,0(9)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L438
	li 3,0
	b .L692
.L438:
	lwz 9,648(31)
	lis 4,.LC241@ha
	la 4,.LC241@l(4)
	lwz 3,0(9)
	bl strcmp
	cmpwi 0,3,0
	li 3,0
	bc 12,2,.L692
.L437:
	li 3,1
.L692:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe42:
	.size	 Chicken_AllowPowerUp,.Lfe42-Chicken_AllowPowerUp
	.align 2
	.globl Chicken_NewPlayer
	.type	 Chicken_NewPlayer,@function
Chicken_NewPlayer:
	lwz 9,84(3)
	li 0,-1
	stw 0,3776(9)
	blr
.Lfe43:
	.size	 Chicken_NewPlayer,.Lfe43-Chicken_NewPlayer
	.section	".rodata"
	.align 2
.LC303:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_CheckGlow
	.type	 Chicken_CheckGlow,@function
Chicken_CheckGlow:
	lis 11,.LC303@ha
	lis 9,deathmatch@ha
	la 11,.LC303@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bclr 12,2
	lis 9,chickenGame@ha
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bclr 12,2
	lis 9,allowGlow@ha
	lwz 10,allowGlow@l(9)
	cmpwi 0,10,0
	bclr 12,2
	lis 9,chickenItemIndex@ha
	lwz 8,84(3)
	lwz 0,chickenItemIndex@l(9)
	addi 11,8,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bclr 4,1
	lwz 0,3764(8)
	cmpwi 0,0,0
	bclr 4,2
	cmpwi 0,10,3
	bc 12,2,.L672
	bc 12,1,.L676
	cmpwi 0,10,2
	bc 12,2,.L671
	b .L674
.L676:
	cmpwi 0,10,4
	bc 12,2,.L673
	b .L674
.L671:
	lwz 0,64(3)
	oris 0,0,0x4
	stw 0,64(3)
	blr
.L672:
	lwz 0,64(3)
	oris 0,0,0x8
	stw 0,64(3)
	blr
.L673:
	lwz 0,64(3)
	oris 0,0,0xc
	stw 0,64(3)
	blr
.L674:
	lwz 0,64(3)
	ori 0,0,64
	stw 0,64(3)
	blr
.Lfe44:
	.size	 Chicken_CheckGlow,.Lfe44-Chicken_CheckGlow
	.align 2
	.globl Chicken_Kill
	.type	 Chicken_Kill,@function
Chicken_Kill:
	lis 11,g_edicts@ha
	lis 0,0xb6db
	lwz 9,g_edicts@l(11)
	ori 0,0,28087
	li 8,2
	lwz 11,184(3)
	li 7,1
	li 10,0
	subf 9,9,3
	stw 8,248(3)
	mullw 9,9,0
	rlwinm 11,11,0,0,30
	stw 10,64(3)
	stw 11,184(3)
	srawi 9,9,7
	stw 7,492(3)
	addi 9,9,-1
	stw 9,60(3)
	blr
.Lfe45:
	.size	 Chicken_Kill,.Lfe45-Chicken_Kill
	.align 2
	.globl Chicken_RunFrameEnd
	.type	 Chicken_RunFrameEnd,@function
Chicken_RunFrameEnd:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	bl Chicken_EnsureExists
	lis 9,chickenGame@ha
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L655
	lis 9,teams@ha
	lwz 0,teams@l(9)
	cmpwi 0,0,0
	bc 4,2,.L655
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,192
	bc 12,2,.L655
	mr 3,31
	bl Chicken_EndIt
	lis 9,gi@ha
	lis 4,.LC297@ha
	lwz 0,gi@l(9)
	la 4,.LC297@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L655:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe46:
	.size	 Chicken_RunFrameEnd,.Lfe46-Chicken_RunFrameEnd
	.align 2
	.globl Chicken_CheckOutPlayer
	.type	 Chicken_CheckOutPlayer,@function
Chicken_CheckOutPlayer:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,teams@ha
	mr 31,3
	lwz 0,teams@l(9)
	cmpwi 0,0,0
	bc 12,2,.L367
	lwz 9,84(31)
	lwz 0,3760(9)
	cmpwi 0,0,-1
	bc 12,2,.L367
	lis 8,teamDetails@ha
	mulli 0,0,60
	lis 4,.LC222@ha
	la 8,teamDetails@l(8)
	la 4,.LC222@l(4)
	addi 10,8,28
	addi 3,8,32
	lwzx 9,10,0
	addi 9,9,-1
	stwx 9,10,0
	lwz 11,84(31)
	lwz 0,3760(11)
	mulli 0,0,60
	lwzx 6,10,0
	add 3,0,3
	lwzx 5,8,0
	crxor 6,6,6
	bl sprintf
	lwz 9,84(31)
	li 0,-1
	stw 0,3760(9)
.L367:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe47:
	.size	 Chicken_CheckOutPlayer,.Lfe47-Chicken_CheckOutPlayer
	.align 2
	.globl Chicken_GetModelName
	.type	 Chicken_GetModelName,@function
Chicken_GetModelName:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	lis 4,.LC149@ha
	la 4,.LC149@l(4)
	addi 3,3,188
	bl Info_ValueForKey
	li 11,0
	lis 9,model.61@ha
	lbzx 0,3,11
	cmpwi 0,0,0
	bc 12,2,.L193
	cmpwi 0,0,47
	bc 4,2,.L196
	la 9,model.61@l(9)
	stbx 11,9,11
	b .L193
.L196:
	lbzx 0,3,11
	lis 9,model.61@ha
	la 9,model.61@l(9)
	stbx 0,9,11
	addi 11,11,1
	lbzx 0,3,11
	cmpwi 0,0,0
	bc 12,2,.L193
	cmpwi 0,0,47
	bc 4,2,.L196
	li 0,0
	stbx 0,9,11
.L193:
	lis 3,model.61@ha
	la 3,model.61@l(3)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe48:
	.size	 Chicken_GetModelName,.Lfe48-Chicken_GetModelName
	.align 2
	.globl Chicken_ResetScoreboard
	.type	 Chicken_ResetScoreboard,@function
Chicken_ResetScoreboard:
	li 11,4
	lis 9,teamDetails@ha
	mtctr 11
	la 9,teamDetails@l(9)
	li 0,0
	addi 9,9,204
.L693:
	stw 0,0(9)
	addi 9,9,-60
	bdnz .L693
	blr
.Lfe49:
	.size	 Chicken_ResetScoreboard,.Lfe49-Chicken_ResetScoreboard
	.section	".rodata"
	.align 2
.LC304:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_ChangeMap
	.type	 Chicken_ChangeMap,@function
Chicken_ChangeMap:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC304@ha
	lis 9,deathmatch@ha
	la 11,.LC304@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L689
	lis 9,chickenGame@ha
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L689
	lis 9,levelCycling@ha
	lwz 0,levelCycling@l(9)
	cmpwi 0,0,0
	bc 12,2,.L689
	bl Chicken_ReadMapList
	bl Chicken_MOTDLoad
	lis 11,levelList@ha
	lwz 9,levelList@l(11)
	cmpwi 0,9,0
	bc 12,2,.L689
	lwz 9,4(9)
	lwz 0,0(9)
	stw 9,levelList@l(11)
	stw 0,504(31)
.L689:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe50:
	.size	 Chicken_ChangeMap,.Lfe50-Chicken_ChangeMap
	.section	".rodata"
	.align 2
.LC305:
	.long 0x0
	.align 3
.LC306:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Chicken_ClientBegin
	.type	 Chicken_ClientBegin,@function
Chicken_ClientBegin:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,chickenGame@ha
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L374
	lis 9,.LC305@ha
	lis 11,deathmatch@ha
	la 9,.LC305@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L374
	lis 9,teams@ha
	lwz 0,teams@l(9)
	cmpwi 0,0,0
	bc 12,2,.L375
	lwz 9,84(3)
	lwz 0,3760(9)
	cmpwi 0,0,-1
	bc 12,2,.L374
	lwz 0,3736(9)
	cmpwi 0,0,0
	bc 12,2,.L374
.L375:
	lis 9,MOTDDuration@ha
	lwz 11,MOTDDuration@l(9)
	cmpwi 0,11,0
	bc 12,2,.L374
	xoris 11,11,0x8000
	lwz 10,84(3)
	stw 11,12(1)
	lis 0,0x4330
	lis 11,.LC306@ha
	stw 0,8(1)
	la 11,.LC306@l(11)
	lfd 0,8(1)
	lfd 12,0(11)
	lis 11,level+4@ha
	lfs 13,level+4@l(11)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,3748(10)
	bl Chicken_MOTD
.L374:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe51:
	.size	 Chicken_ClientBegin,.Lfe51-Chicken_ClientBegin
	.section	".rodata"
	.align 2
.LC307:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_SelectNextItem
	.type	 Chicken_SelectNextItem,@function
Chicken_SelectNextItem:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC307@ha
	lis 9,deathmatch@ha
	la 11,.LC307@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L638
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L639
	bl Chicken_ShowMenu
	cmpwi 0,3,0
	bc 12,2,.L638
	mr 3,31
	bl Chicken_MenuItemNext
	li 3,0
	b .L694
.L638:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 12,2,.L639
	lis 9,eggGunItemIndex@ha
	addi 11,3,740
	lwz 0,eggGunItemIndex@l(9)
	li 3,0
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L694
.L639:
	li 3,1
.L694:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe52:
	.size	 Chicken_SelectNextItem,.Lfe52-Chicken_SelectNextItem
	.section	".rodata"
	.align 2
.LC308:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_SelectPrevItem
	.type	 Chicken_SelectPrevItem,@function
Chicken_SelectPrevItem:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC308@ha
	lis 9,deathmatch@ha
	la 11,.LC308@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L641
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L642
	bl Chicken_ShowMenu
	cmpwi 0,3,0
	bc 12,2,.L641
	mr 3,31
	bl Chicken_MenuItemPrev
	li 3,0
	b .L695
.L641:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 12,2,.L642
	lis 9,eggGunItemIndex@ha
	addi 11,3,740
	lwz 0,eggGunItemIndex@l(9)
	li 3,0
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L695
.L642:
	li 3,1
.L695:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe53:
	.size	 Chicken_SelectPrevItem,.Lfe53-Chicken_SelectPrevItem
	.section	".rodata"
	.align 2
.LC309:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_Cheat
	.type	 Chicken_Cheat,@function
Chicken_Cheat:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC309@ha
	lis 9,deathmatch@ha
	la 11,.LC309@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L644
	lis 9,chickenGame@ha
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L644
	lwz 10,84(3)
	cmpwi 0,10,0
	bc 12,2,.L644
	lis 9,chickenItemIndex@ha
	addi 11,10,740
	lwz 0,chickenItemIndex@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,1,.L644
	lwz 0,3764(10)
	cmpwi 0,0,0
	bc 4,2,.L644
	lis 9,gi+8@ha
	lis 5,.LC295@ha
	lwz 0,gi+8@l(9)
	la 5,.LC295@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L696
.L644:
	li 3,1
.L696:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe54:
	.size	 Chicken_Cheat,.Lfe54-Chicken_Cheat
	.section	".rodata"
	.align 2
.LC310:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_InvUse
	.type	 Chicken_InvUse,@function
Chicken_InvUse:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC310@ha
	lis 9,deathmatch@ha
	la 11,.LC310@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L646
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L646
	bl Chicken_ShowMenu
	cmpwi 0,3,0
	bc 12,2,.L646
	lwz 11,84(31)
	mr 3,31
	lwz 9,3756(11)
	lbz 4,0(9)
	bl Chicken_MenuItemSelect
	li 3,0
	b .L697
.L646:
	li 3,1
.L697:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe55:
	.size	 Chicken_InvUse,.Lfe55-Chicken_InvUse
	.section	".rodata"
	.align 2
.LC311:
	.long 0x3f800000
	.align 2
.LC312:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_ItemTouch
	.type	 Chicken_ItemTouch,@function
Chicken_ItemTouch:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,4
	mr 31,3
	lwz 3,280(31)
	lis 4,.LC70@ha
	la 4,.LC70@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L649
	li 3,0
	b .L698
.L649:
	lis 29,gi@ha
	lis 3,.LC159@ha
	la 29,gi@l(29)
	la 3,.LC159@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC311@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC311@l(9)
	mr 3,30
	lfs 1,0(9)
	li 4,11
	mtlr 0
	lis 9,.LC312@ha
	la 9,.LC312@l(9)
	lfs 2,0(9)
	lis 9,.LC312@ha
	la 9,.LC312@l(9)
	lfs 3,0(9)
	blrl
	mr 3,31
	bl G_FreeEdict
	li 3,1
.L698:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe56:
	.size	 Chicken_ItemTouch,.Lfe56-Chicken_ItemTouch
	.section	".rodata"
	.align 3
.LC313:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl Chicken_DropMakeTouchable
	.type	 Chicken_DropMakeTouchable,@function
Chicken_DropMakeTouchable:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 4,.LC70@ha
	lwz 3,280(31)
	la 4,.LC70@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L651
	li 3,0
	b .L699
.L651:
	lis 11,level+4@ha
	lis 10,.LC313@ha
	lfs 0,level+4@l(11)
	lis 9,Chicken_Think@ha
	li 3,1
	lfd 13,.LC313@l(10)
	la 9,Chicken_Think@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L699:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe57:
	.size	 Chicken_DropMakeTouchable,.Lfe57-Chicken_DropMakeTouchable
	.section	".rodata"
	.align 2
.LC314:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_CanPickup
	.type	 Chicken_CanPickup,@function
Chicken_CanPickup:
	lis 11,.LC314@ha
	lis 9,deathmatch@ha
	la 11,.LC314@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L653
	lis 9,chickenGame@ha
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L653
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L653
	lis 9,chickenItemIndex@ha
	addi 11,3,740
	lwz 0,chickenItemIndex@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,1,.L653
	lwz 0,3764(3)
	subfic 11,4,0
	adde 9,11,4
	li 3,0
	subfic 11,0,0
	adde 0,11,0
	and. 11,0,9
	bclr 4,2
.L653:
	li 3,1
	blr
.Lfe58:
	.size	 Chicken_CanPickup,.Lfe58-Chicken_CanPickup
	.align 2
	.globl Chicken_Ready
	.type	 Chicken_Ready,@function
Chicken_Ready:
	lis 9,chickenItemIndex@ha
	lwz 11,84(3)
	lwz 0,chickenItemIndex@l(9)
	addi 10,11,740
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,1,.L657
	lis 9,chickenItem@ha
	li 3,1
	lwz 0,chickenItem@l(9)
	stw 0,3512(11)
	blr
.L657:
	lis 9,eggGunItemIndex@ha
	lwz 0,eggGunItemIndex@l(9)
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,1,.L658
	li 3,0
	blr
.L658:
	lis 9,eggGunItem@ha
	li 3,1
	lwz 0,eggGunItem@l(9)
	stw 0,3512(11)
	blr
.Lfe59:
	.size	 Chicken_Ready,.Lfe59-Chicken_Ready
	.section	".rodata"
	.align 2
.LC315:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_InvDrop
	.type	 Chicken_InvDrop,@function
Chicken_InvDrop:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC315@ha
	lis 9,deathmatch@ha
	la 11,.LC315@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L660
	lwz 10,84(3)
	cmpwi 0,10,0
	bc 12,2,.L661
	lis 9,chickenItemIndex@ha
	addi 11,10,740
	lwz 0,chickenItemIndex@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,1,.L660
	lwz 0,3764(10)
	cmpwi 0,0,0
	bc 4,2,.L660
	lis 11,chickenItem@ha
	lwz 9,chickenItem@l(11)
	lwz 0,12(9)
	mr 4,9
	mtlr 0
	blrl
	li 3,1
	b .L702
.L660:
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L661
	lis 9,eggGunItemIndex@ha
	addi 11,3,740
	lwz 0,eggGunItemIndex@l(9)
	li 3,1
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L702
.L661:
	li 3,0
.L702:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe60:
	.size	 Chicken_InvDrop,.Lfe60-Chicken_InvDrop
	.section	".rodata"
	.align 2
.LC316:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_TossCheck
	.type	 Chicken_TossCheck,@function
Chicken_TossCheck:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC316@ha
	lis 9,deathmatch@ha
	la 11,.LC316@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L663
	lis 9,chickenGame@ha
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L663
	lwz 10,84(31)
	cmpwi 0,10,0
	bc 12,2,.L663
	lis 9,chickenItemIndex@ha
	addi 11,10,740
	lwz 0,chickenItemIndex@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,1,.L663
	lwz 0,3764(10)
	cmpwi 0,0,0
	bc 4,2,.L663
	lis 9,chickenItem@ha
	addic 0,31,-1
	subfe 11,0,31
	lwz 4,chickenItem@l(9)
	addic 9,4,-1
	subfe 0,9,4
	and. 9,11,0
	bc 12,2,.L664
	bl Drop_Item
	mr. 3,3
	bc 12,2,.L666
	mr 4,31
	bl Chicken_Setup
.L666:
	bl Chicken_RemoveFromInventory
.L664:
	li 3,1
	b .L703
.L663:
	li 3,0
.L703:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe61:
	.size	 Chicken_TossCheck,.Lfe61-Chicken_TossCheck
	.comm	motd1,31,4
	.comm	motd2,31,4
	.comm	motd3,31,4
	.comm	motd4,31,4
	.section	".rodata"
	.align 2
.LC317:
	.long 0x3f800000
	.section	".text"
	.align 2
	.type	 Chicken_ClockStart,@function
Chicken_ClockStart:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr. 31,3
	bc 12,2,.L262
	bl G_Spawn
	mr. 7,3
	bc 12,2,.L264
	li 10,0
	lis 9,.LC72@ha
	stw 31,540(7)
	stw 10,592(7)
	la 9,.LC72@l(9)
	lis 11,Chicken_ClockThink@ha
	stw 9,280(7)
	li 0,0
	la 11,Chicken_ClockThink@l(11)
	li 8,1
	lis 10,.LC317@ha
	stw 31,548(7)
	stw 0,480(7)
	la 10,.LC317@l(10)
	lis 9,level+4@ha
	stw 8,88(7)
	mr 3,7
	stw 11,436(7)
	lfs 13,0(10)
	lfs 0,level+4@l(9)
	lis 10,gi+72@ha
	fadds 0,0,13
	stfs 0,428(7)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	b .L264
.L262:
	lis 9,gi+4@ha
	lis 3,.LC169@ha
	lwz 0,gi+4@l(9)
	la 3,.LC169@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L264:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe62:
	.size	 Chicken_ClockStart,.Lfe62-Chicken_ClockStart
	.section	".rodata"
	.align 2
.LC318:
	.long 0x3f800000
	.align 2
.LC319:
	.long 0x0
	.section	".text"
	.align 2
	.type	 Chicken_GameStatus,@function
Chicken_GameStatus:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,chickenGame@ha
	mr 31,3
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L323
	bl Chicken_EndIt
	lwz 5,84(31)
	cmpwi 0,5,0
	bc 12,2,.L324
	lis 9,gi@ha
	lis 4,.LC194@ha
	lwz 0,gi@l(9)
	la 4,.LC194@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L326
.L324:
	lis 9,gi@ha
	lis 4,.LC195@ha
	lwz 0,gi@l(9)
	la 4,.LC195@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L326
.L323:
	bl Chicken_Spawn
	lwz 5,84(31)
	cmpwi 0,5,0
	bc 12,2,.L327
	lis 9,gi@ha
	lis 4,.LC196@ha
	lwz 0,gi@l(9)
	la 4,.LC196@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L328
.L327:
	lis 9,gi@ha
	lis 4,.LC197@ha
	lwz 0,gi@l(9)
	la 4,.LC197@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L328:
	lis 29,gi@ha
	lis 3,.LC198@ha
	la 29,gi@l(29)
	la 3,.LC198@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC318@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC318@l(9)
	li 4,8
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC318@ha
	la 9,.LC318@l(9)
	lfs 2,0(9)
	lis 9,.LC319@ha
	la 9,.LC319@l(9)
	lfs 3,0(9)
	blrl
.L326:
	lwz 9,84(31)
	li 0,0
	li 3,0
	stw 0,3728(9)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe63:
	.size	 Chicken_GameStatus,.Lfe63-Chicken_GameStatus
	.section	".rodata"
	.align 3
.LC320:
	.long 0x40100000
	.long 0x0
	.section	".text"
	.align 2
	.type	 Chicken_Drop_Temp,@function
Chicken_Drop_Temp:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,256(31)
	cmpw 0,4,0
	bc 4,2,.L122
	lis 9,level@ha
	lfs 0,604(31)
	la 30,level@l(9)
	lfs 13,4(30)
	fcmpu 0,0,13
	bc 4,1,.L122
	cmpwi 0,4,0
	bc 12,2,.L121
	lwz 9,84(4)
	cmpwi 0,9,0
	bc 12,2,.L121
	lfs 0,3772(9)
	fcmpu 0,0,13
	bc 4,0,.L121
	lis 9,gi+8@ha
	mr 3,4
	lwz 0,gi+8@l(9)
	lis 5,.LC113@ha
	li 4,2
	la 5,.LC113@l(5)
	mtlr 0
	crxor 6,6,6
	blrl
	lfs 0,4(30)
	lis 9,.LC320@ha
	la 9,.LC320@l(9)
	lfd 13,0(9)
	lwz 9,256(31)
	lwz 11,84(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3772(11)
	b .L121
.L122:
	mr 3,31
	bl Touch_Item
.L121:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe64:
	.size	 Chicken_Drop_Temp,.Lfe64-Chicken_Drop_Temp
	.section	".rodata"
	.align 3
.LC321:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 Chicken_FlyThink,@function
Chicken_FlyThink:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr. 31,3
	bc 12,2,.L118
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L119
	lis 9,gi+44@ha
	lis 4,.LC110@ha
	lwz 0,gi+44@l(9)
	la 4,.LC110@l(4)
	mr 3,31
	mtlr 0
	blrl
	lis 9,Chicken_Think@ha
	li 11,0
	la 9,Chicken_Think@l(9)
	li 0,0
	stw 11,56(31)
	stw 0,16(31)
	stw 9,436(31)
.L119:
	lis 9,level+4@ha
	lis 11,.LC321@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC321@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L120
.L118:
	lis 9,gi+4@ha
	lis 3,.LC112@ha
	lwz 0,gi+4@l(9)
	la 3,.LC112@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L120:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe65:
	.size	 Chicken_FlyThink,.Lfe65-Chicken_FlyThink
	.align 2
	.globl Chicken_Follow
	.type	 Chicken_Follow,@function
Chicken_Follow:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 9,chickenGame@ha
	li 29,0
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L507
	lis 9,globals@ha
	li 30,1
	la 10,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(10)
	lwz 9,g_edicts@l(11)
	cmpw 0,30,0
	addi 31,9,896
	bc 4,0,.L507
	mr 26,10
	lis 27,chickenItemIndex@ha
	lis 28,.LC70@ha
.L511:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L510
	lwz 10,84(31)
	cmpwi 0,10,0
	bc 12,2,.L515
	lwz 0,chickenItemIndex@l(27)
	addi 11,10,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,1,.L515
	lwz 0,3764(10)
	cmpwi 0,0,0
	bc 12,2,.L514
.L515:
	lwz 3,280(31)
	la 4,.LC70@l(28)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L510
.L514:
	mr 29,31
.L510:
	lwz 0,72(26)
	addi 30,30,1
	addi 31,31,896
	cmpw 0,30,0
	bc 12,0,.L511
.L507:
	mr 3,29
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe66:
	.size	 Chicken_Follow,.Lfe66-Chicken_Follow
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
