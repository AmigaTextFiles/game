	.file	"tctc.c"
gcc2_compiled.:
	.globl teams
	.section	".sdata","aw"
	.align 2
	.type	 teams,@object
	.size	 teams,4
teams:
	.long 0
	.globl teamDetails
	.section	".data"
	.align 2
	.type	 teamDetails,@object
teamDetails:
	.long .LC0
	.long .LC1
	.long .LC2
	.long .LC3
	.long .LC4
	.long .LC5
	.long 0
	.long 0
	.string	""
	.space	26
	.space	1
	.long .LC6
	.long .LC7
	.long .LC8
	.long .LC9
	.long .LC10
	.long .LC11
	.long 0
	.long 0
	.string	""
	.space	26
	.space	1
	.long .LC12
	.long .LC13
	.long .LC14
	.long .LC15
	.long .LC16
	.long .LC17
	.long 0
	.long 0
	.string	""
	.space	26
	.space	1
	.long .LC18
	.long .LC19
	.long .LC20
	.long .LC21
	.long .LC22
	.long .LC23
	.long 0
	.long 0
	.string	""
	.space	26
	.space	1
	.section	".rodata"
	.align 2
.LC23:
	.string	"tag_green_c"
	.align 2
.LC22:
	.string	"tag_green"
	.align 2
.LC21:
	.string	"t_green_c"
	.align 2
.LC20:
	.string	"t_green"
	.align 2
.LC19:
	.string	"kw_green"
	.align 2
.LC18:
	.string	"Green"
	.align 2
.LC17:
	.string	"tag_yellow_c"
	.align 2
.LC16:
	.string	"tag_yellow"
	.align 2
.LC15:
	.string	"t_yellow_c"
	.align 2
.LC14:
	.string	"t_yellow"
	.align 2
.LC13:
	.string	"kw_yellow"
	.align 2
.LC12:
	.string	"Yellow"
	.align 2
.LC11:
	.string	"tag_blue_c"
	.align 2
.LC10:
	.string	"tag_blue"
	.align 2
.LC9:
	.string	"t_blue_c"
	.align 2
.LC8:
	.string	"t_blue"
	.align 2
.LC7:
	.string	"kw_blue"
	.align 2
.LC6:
	.string	"Blue"
	.align 2
.LC5:
	.string	"tag_red_c"
	.align 2
.LC4:
	.string	"tag_red"
	.align 2
.LC3:
	.string	"t_red_c"
	.align 2
.LC2:
	.string	"t_red"
	.align 2
.LC1:
	.string	"kw_red"
	.align 2
.LC0:
	.string	"Red"
	.size	 teamDetails,240
	.globl teamWithChicken
	.section	".sdata","aw"
	.align 2
	.type	 teamWithChicken,@object
	.size	 teamWithChicken,4
teamWithChicken:
	.long -1
	.section	".rodata"
	.align 2
.LC24:
	.string	""
	.align 2
.LC25:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_TeamReadyEggGun
	.type	 Chicken_TeamReadyEggGun,@function
Chicken_TeamReadyEggGun:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 18,16(1)
	stw 0,84(1)
	lis 9,teams@ha
	mr 26,3
	lwz 0,teams@l(9)
	lis 18,teams@ha
	cmpwi 0,0,0
	bc 12,2,.L10
	lis 9,game@ha
	li 30,0
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,30,0
	bc 4,0,.L10
	lis 9,itemlist@ha
	lis 29,0x38e3
	la 19,itemlist@l(9)
	mr 20,11
	lis 9,.LC25@ha
	lis 21,g_edicts@ha
	la 9,.LC25@l(9)
	lis 22,deathmatch@ha
	lfs 31,0(9)
	lis 23,chickenGame@ha
	lis 24,eggGunItemIndex@ha
	li 25,1
	li 28,896
	ori 29,29,36409
.L14:
	lwz 0,g_edicts@l(21)
	add 31,0,28
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L13
	lwz 9,deathmatch@l(22)
	li 27,0
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L13
	lwz 0,chickenGame@l(23)
	cmpwi 0,0,0
	bc 12,2,.L13
	lwz 0,teams@l(18)
	cmpwi 0,0,0
	bc 12,2,.L13
	lwz 9,84(31)
	lwz 0,3760(9)
	cmpw 0,0,26
	bc 4,2,.L13
	lwz 0,44(31)
	cmpwi 0,0,0
	bc 12,2,.L13
	lwz 0,eggGunItemIndex@l(24)
	addi 9,9,740
	mr 3,31
	slwi 0,0,2
	stwx 25,9,0
	bl Chicken_Ready
	lwz 11,84(31)
	lwz 0,1788(11)
	subf 0,19,0
	mullw 0,0,29
	srawi 0,0,3
	stw 0,736(11)
	lwz 9,84(31)
	stw 27,3492(9)
.L13:
	lwz 0,1544(20)
	addi 30,30,1
	addi 28,28,896
	cmpw 0,30,0
	bc 12,0,.L14
.L10:
	lwz 0,84(1)
	mtlr 0
	lmw 18,16(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe1:
	.size	 Chicken_TeamReadyEggGun,.Lfe1-Chicken_TeamReadyEggGun
	.section	".rodata"
	.align 2
.LC26:
	.string	"Team %-6.6s %d Players"
	.align 2
.LC27:
	.string	"%s has joined %s team\n"
	.section	".text"
	.align 2
	.type	 Chicken_SelectTeam,@function
Chicken_SelectTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,teams@ha
	mr 31,3
	lwz 0,teams@l(9)
	addi 4,4,-3
	li 27,0
	b .L35
.L32:
	addi 4,4,-1
.L29:
	addi 27,27,1
	cmpwi 0,27,3
	bc 12,1,.L28
	lis 9,teams@ha
	lwz 0,teams@l(9)
	sraw 0,0,27
.L35:
	andi. 9,0,1
	bc 12,2,.L29
	cmpwi 0,4,0
	bc 4,2,.L32
.L28:
	lis 29,teamDetails@ha
	mulli 28,27,60
	lis 4,.LC26@ha
	la 29,teamDetails@l(29)
	la 4,.LC26@l(4)
	addi 11,29,28
	lwzx 5,29,28
	addi 3,29,32
	lwzx 9,11,28
	add 3,28,3
	addi 9,9,1
	mr 6,9
	stwx 9,11,28
	crxor 6,6,6
	bl sprintf
	lwz 11,84(31)
	lis 9,gi@ha
	lis 4,.LC27@ha
	la 4,.LC27@l(4)
	li 3,2
	stw 27,3760(11)
	lwz 0,gi@l(9)
	la 27,gi@l(9)
	lwz 5,84(31)
	mtlr 0
	lwzx 6,29,28
	addi 5,5,700
	crxor 6,6,6
	blrl
	lis 9,level+4@ha
	lwz 4,84(31)
	mr 3,27
	lfs 1,level+4@l(9)
	lwzx 5,29,28
	addi 4,4,700
	creqv 6,6,6
	bl sl_LogPlayerTeamChange
	lwz 9,84(31)
	lwz 0,3736(9)
	cmpwi 0,0,0
	bc 12,2,.L34
	mr 3,31
	bl Chicken_SetPlayerSkin
	mr 3,31
	bl NoAmmoWeaponChange
	mr 3,31
	bl ChangeWeapon
	mr 3,31
	bl Chicken_ObserverEnd
.L34:
	li 3,0
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Chicken_SelectTeam,.Lfe2-Chicken_SelectTeam
	.section	".rodata"
	.align 2
.LC28:
	.string	"/\\\n"
	.string	""
	.align 2
.LC29:
	.string	"skin"
	.align 2
.LC30:
	.string	"\\%s"
	.align 2
.LC31:
	.string	"\\skin\\%s/%s"
	.align 2
.LC32:
	.string	"/"
	.align 2
.LC33:
	.string	"\\"
	.section	".text"
	.align 2
	.type	 Chicken_SetPlayerSkin,@function
Chicken_SetPlayerSkin:
	stwu 1,-1584(1)
	mflr 0
	stmw 22,1544(1)
	stw 0,1588(1)
	mr 31,3
	li 4,0
	addi 3,1,8
	li 5,512
	crxor 6,6,6
	bl memset
	lis 22,.LC28@ha
	addi 28,1,520
	li 4,0
	li 5,512
	mr 3,28
	crxor 6,6,6
	bl memset
	lwz 29,84(31)
	addi 29,29,188
	mr 3,29
	bl strlen
	mr 5,3
	mr 4,29
	mr 3,28
	crxor 6,6,6
	bl memcpy
	lis 4,.LC28@ha
	mr 3,28
	la 4,.LC28@l(4)
	bl strtok
	mr. 29,3
	bc 12,2,.L38
	lis 9,teamDetails+4@ha
	lis 23,.LC29@ha
	la 24,teamDetails+4@l(9)
	lis 25,.LC30@ha
	addi 28,1,1032
	lis 26,.LC32@ha
	lis 27,.LC31@ha
	lis 30,.LC33@ha
.L39:
	mr 3,29
	la 4,.LC29@l(23)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L40
	la 4,.LC30@l(25)
	mr 5,29
	addi 3,1,1032
	crxor 6,6,6
	bl sprintf
	addi 4,1,1032
	b .L41
.L40:
	la 4,.LC32@l(26)
	li 3,0
	bl strtok
	lwz 9,84(31)
	mr 5,3
	la 4,.LC31@l(27)
	mr 3,28
	lwz 0,3760(9)
	mulli 0,0,60
	lwzx 6,24,0
	crxor 6,6,6
	bl sprintf
	la 4,.LC33@l(30)
	li 3,0
	bl strtok
	mr 4,28
.L41:
	addi 3,1,8
	bl strcat
	li 3,0
	la 4,.LC28@l(22)
	bl strtok
	mr. 29,3
	bc 4,2,.L39
.L38:
	mr 3,31
	addi 4,1,8
	bl ClientUserinfoChanged
	li 3,0
	lwz 0,1588(1)
	mtlr 0
	lmw 22,1544(1)
	la 1,1584(1)
	blr
.Lfe3:
	.size	 Chicken_SetPlayerSkin,.Lfe3-Chicken_SetPlayerSkin
	.section	".rodata"
	.align 2
.LC34:
	.string	"gender"
	.align 2
.LC35:
	.string	"\\gender\\%s"
	.section	".text"
	.align 2
	.type	 Chicken_SetPlayerModel,@function
Chicken_SetPlayerModel:
	stwu 1,-1600(1)
	mflr 0
	stmw 19,1548(1)
	stw 0,1604(1)
	mr 31,3
	addi 26,4,-10
	addi 28,1,520
	addi 3,1,8
	li 4,0
	li 5,512
	crxor 6,6,6
	bl memset
	lis 19,.LC28@ha
	li 4,0
	li 5,512
	mr 3,28
	crxor 6,6,6
	bl memset
	lwz 29,84(31)
	addi 29,29,188
	mr 3,29
	bl strlen
	mr 5,3
	mr 4,29
	mr 3,28
	crxor 6,6,6
	bl memcpy
	lis 4,.LC28@ha
	mr 3,28
	la 4,.LC28@l(4)
	bl strtok
	mr. 29,3
	bc 12,2,.L45
	lis 9,playerModels@ha
	lis 11,teamDetails+4@ha
	mulli 28,26,24
	la 27,playerModels@l(9)
	la 20,teamDetails+4@l(11)
	addi 21,27,8
	lis 30,.LC33@ha
	lis 22,.LC29@ha
	lis 23,.LC34@ha
	lis 24,.LC30@ha
	lis 25,.LC35@ha
.L46:
	mr 3,29
	la 4,.LC29@l(22)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L47
	mr 3,29
	la 4,.LC34@l(23)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L48
	la 4,.LC30@l(24)
	mr 5,29
	addi 3,1,1032
	crxor 6,6,6
	bl sprintf
	b .L52
.L48:
	lwzx 5,21,28
	la 4,.LC35@l(25)
	addi 3,1,1032
	crxor 6,6,6
	bl sprintf
	b .L53
.L47:
	lwz 9,84(31)
	lis 4,.LC31@ha
	addi 3,1,1032
	lwzx 5,27,28
	la 4,.LC31@l(4)
	lwz 0,3760(9)
	mulli 0,0,60
	lwzx 6,20,0
	crxor 6,6,6
	bl sprintf
	lis 4,.LC32@ha
	li 3,0
	la 4,.LC32@l(4)
	bl strtok
.L53:
	la 4,.LC33@l(30)
	li 3,0
	bl strtok
.L52:
	addi 4,1,1032
	addi 3,1,8
	bl strcat
	li 3,0
	la 4,.LC28@l(19)
	bl strtok
	mr. 29,3
	bc 4,2,.L46
.L45:
	lis 9,playerModels@ha
	lis 11,gi+32@ha
	mulli 0,26,24
	lwz 11,gi+32@l(11)
	la 9,playerModels@l(9)
	addi 9,9,12
	lwzx 3,9,0
	mtlr 11
	blrl
	stw 3,44(31)
	addi 4,1,8
	mr 3,31
	bl ClientUserinfoChanged
	mr 3,31
	bl Chicken_ObserverEnd
	li 3,0
	lwz 0,1604(1)
	mtlr 0
	lmw 19,1548(1)
	la 1,1600(1)
	blr
.Lfe4:
	.size	 Chicken_SetPlayerModel,.Lfe4-Chicken_SetPlayerModel
	.section	".sdata","aw"
	.align 2
	.type	 menuSetup.24,@object
	.size	 menuSetup.24,4
menuSetup.24:
	.long 0
	.section	".rodata"
	.align 2
.LC36:
	.string	"The model you are using"
	.align 2
.LC37:
	.string	"is not supported"
	.align 2
.LC38:
	.string	"Please select new model"
	.align 2
.LC39:
	.string	"%s"
	.align 2
.LC40:
	.string	" use [ and ] to move cursor"
	.align 2
.LC41:
	.string	"press enter to select"
	.align 2
.LC42:
	.string	"                "
	.align 2
.LC43:
	.string	"v2.0"
	.section	".text"
	.align 2
	.globl Chicken_PlayerSelectMenuCreate
	.type	 Chicken_PlayerSelectMenuCreate,@function
Chicken_PlayerSelectMenuCreate:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,menuSetup.24@ha
	lwz 0,menuSetup.24@l(9)
	cmpwi 0,0,0
	bc 4,2,.L55
	li 3,3
	li 29,0
	bl Chicken_MenuInsert
	lis 27,.LC39@ha
	lis 28,Chicken_SetPlayerModel@ha
	lis 5,.LC36@ha
	li 4,3
	la 5,.LC36@l(5)
	li 6,1
	li 7,1
	li 8,4
	li 3,3
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC37@ha
	li 4,4
	la 5,.LC37@l(5)
	li 6,1
	li 7,1
	li 8,4
	li 3,3
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	li 5,0
	li 4,5
	li 6,1
	li 7,1
	li 8,4
	li 3,3
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC38@ha
	li 4,6
	la 5,.LC38@l(5)
	li 6,1
	li 7,1
	li 8,4
	li 3,3
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	li 3,3
	li 4,7
	li 5,0
	li 6,1
	li 7,1
	li 8,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 9,playerModels@ha
	lis 11,teamPlayerMenuLine@ha
	la 9,playerModels@l(9)
	la 31,teamPlayerMenuLine@l(11)
	addi 30,9,4
.L59:
	lwz 5,0(30)
	mr 3,31
	la 4,.LC39@l(27)
	addi 30,30,24
	crxor 6,6,6
	bl sprintf
	addi 4,29,10
	mr 5,31
	li 3,3
	li 6,0
	li 7,0
	li 8,2
	la 9,Chicken_SetPlayerModel@l(28)
	addi 29,29,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	addi 31,31,27
	cmpwi 0,29,2
	bc 4,1,.L59
	lis 5,.LC40@ha
	li 4,16
	la 5,.LC40@l(5)
	li 6,1
	li 7,1
	li 8,4
	li 3,3
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC41@ha
	li 4,17
	la 5,.LC41@l(5)
	li 6,1
	li 7,1
	li 8,4
	li 3,3
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC42@ha
	li 4,18
	la 5,.LC42@l(5)
	li 6,1
	li 7,1
	li 8,4
	li 3,3
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC43@ha
	li 3,3
	la 5,.LC43@l(5)
	li 4,20
	li 6,1
	li 7,2
	li 8,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 9,menuSetup.24@ha
	li 0,1
	stw 0,menuSetup.24@l(9)
.L55:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Chicken_PlayerSelectMenuCreate,.Lfe5-Chicken_PlayerSelectMenuCreate
	.section	".sdata","aw"
	.align 2
	.type	 menuSetup.28,@object
	.size	 menuSetup.28,4
menuSetup.28:
	.long 0
	.section	".text"
	.align 2
	.globl Chicken_TeamMenuCreate
	.type	 Chicken_TeamMenuCreate,@function
Chicken_TeamMenuCreate:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 9,menuSetup.28@ha
	li 29,0
	lwz 0,menuSetup.28@l(9)
	cmpwi 0,0,0
	bc 4,2,.L62
	li 3,2
	li 30,0
	bl Chicken_MenuInsert
	lis 25,teams@ha
	li 26,1
	lis 9,teamDetails+32@ha
	lis 27,.LC26@ha
	la 31,teamDetails+32@l(9)
	lis 28,Chicken_SelectTeam@ha
.L66:
	lwz 9,teams@l(25)
	slw 0,26,30
	and. 11,9,0
	bc 12,2,.L65
	lwz 5,-32(31)
	la 4,.LC26@l(27)
	mr 3,31
	lwz 6,-4(31)
	crxor 6,6,6
	bl sprintf
	addi 4,29,3
	li 3,2
	mr 5,31
	li 6,0
	li 7,1
	li 8,2
	la 9,Chicken_SelectTeam@l(28)
	addi 29,29,1
	crxor 6,6,6
	bl Chicken_MenuItemInsert
.L65:
	addi 30,30,1
	addi 31,31,60
	cmpwi 0,30,3
	bc 4,1,.L66
	lis 5,.LC40@ha
	li 4,16
	la 5,.LC40@l(5)
	li 6,1
	li 7,1
	li 8,4
	li 3,2
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC41@ha
	li 4,17
	la 5,.LC41@l(5)
	li 6,1
	li 7,1
	li 8,4
	li 3,2
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC42@ha
	li 4,18
	la 5,.LC42@l(5)
	li 6,1
	li 7,1
	li 8,4
	li 3,2
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 5,.LC43@ha
	li 3,2
	la 5,.LC43@l(5)
	li 4,20
	li 6,1
	li 7,2
	li 8,4
	crxor 6,6,6
	bl Chicken_MenuItemInsert
	lis 9,menuSetup.28@ha
	li 0,1
	stw 0,menuSetup.28@l(9)
.L62:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 Chicken_TeamMenuCreate,.Lfe6-Chicken_TeamMenuCreate
	.section	".rodata"
	.align 2
.LC45:
	.string	"debris"
	.align 2
.LC44:
	.long 0x46fffe00
	.align 3
.LC46:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC47:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC48:
	.long 0x40690000
	.long 0x0
	.align 2
.LC49:
	.long 0x44160000
	.align 2
.LC50:
	.long 0x40400000
	.align 2
.LC51:
	.long 0x40800000
	.section	".text"
	.align 2
	.type	 Chicken_ThrowEggShell,@function
Chicken_ThrowEggShell:
	stwu 1,-112(1)
	mflr 0
	stfd 26,64(1)
	stfd 27,72(1)
	stfd 28,80(1)
	stfd 29,88(1)
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 20,16(1)
	stw 0,116(1)
	mr. 28,6
	mr 24,3
	fmr 26,1
	mr 25,4
	mr 29,5
	bc 12,2,.L71
	lis 9,.LC44@ha
	lis 11,gi@ha
	lfs 30,.LC44@l(9)
	la 26,gi@l(11)
	lis 30,0x4330
	lis 9,G_FreeEdict@ha
	lis 11,level@ha
	la 20,G_FreeEdict@l(9)
	la 21,level@l(11)
	lis 9,.LC45@ha
	lis 11,debris_die@ha
	la 22,.LC45@l(9)
	la 23,debris_die@l(11)
	lis 9,.LC46@ha
	lis 11,.LC47@ha
	la 9,.LC46@l(9)
	la 11,.LC47@l(11)
	lfd 31,0(9)
	li 27,0
	lfd 28,0(11)
	lis 9,.LC48@ha
	lis 11,.LC49@ha
	la 9,.LC48@l(9)
	la 11,.LC49@l(11)
	lfd 29,0(9)
	lfs 27,0(11)
.L72:
	bl G_Spawn
	mr. 31,3
	bc 12,2,.L71
	lfs 13,0(29)
	mr 3,31
	mr 4,25
	stfs 13,4(31)
	lfs 0,4(29)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	lwz 9,44(26)
	mtlr 9
	blrl
	fmr 1,26
	addi 4,31,376
	addi 3,24,376
	bl VectorScale
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,376(31)
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 30,8(1)
	lfd 13,8(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,30
	fmr 0,13
	fsub 0,0,28
	fadd 0,0,0
	fmadd 0,0,29,12
	frsp 0,0
	stfs 0,376(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,380(31)
	xoris 3,3,0x8000
	li 0,9
	stw 27,248(31)
	stw 3,12(1)
	stw 30,8(1)
	lfd 13,8(1)
	stw 0,260(31)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,30
	fmr 0,13
	fsub 0,0,28
	fadd 0,0,0
	fmadd 0,0,29,12
	frsp 0,0
	stfs 0,380(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 30,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,27
	stfs 0,388(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 30,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,27
	stfs 0,392(31)
	bl rand
	rlwinm 3,3,0,17,31
	stw 20,436(31)
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 30,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,27
	stfs 0,396(31)
	bl rand
	lis 11,.LC50@ha
	lfs 13,4(21)
	rlwinm 3,3,0,17,31
	la 11,.LC50@l(11)
	stw 27,56(31)
	lfs 0,0(11)
	xoris 3,3,0x8000
	li 0,1
	stw 3,12(1)
	lis 11,.LC51@ha
	stw 30,8(1)
	la 11,.LC51@l(11)
	mr 3,31
	fadds 13,13,0
	lfs 12,0(11)
	lfd 0,8(1)
	stw 0,512(31)
	stw 27,264(31)
	fsub 0,0,31
	stw 22,280(31)
	stw 23,456(31)
	frsp 0,0
	fdivs 0,0,30
	fmadds 0,0,12,13
	stfs 0,428(31)
	lwz 9,72(26)
	mtlr 9
	blrl
	addic. 28,28,-1
	bc 4,2,.L72
.L71:
	lwz 0,116(1)
	mtlr 0
	lmw 20,16(1)
	lfd 26,64(1)
	lfd 27,72(1)
	lfd 28,80(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe7:
	.size	 Chicken_ThrowEggShell,.Lfe7-Chicken_ThrowEggShell
	.section	".rodata"
	.align 2
.LC52:
	.string	"models/objects/eggsplat/tris.md2"
	.align 2
.LC55:
	.string	"eggsplat"
	.align 2
.LC56:
	.string	"chicken/splat.wav"
	.align 2
.LC53:
	.long 0x3e4ccccd
	.align 2
.LC54:
	.long 0x46fffe00
	.align 2
.LC57:
	.long 0x42b40000
	.align 3
.LC58:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC59:
	.long 0x40400000
	.align 2
.LC60:
	.long 0x40800000
	.align 2
.LC61:
	.long 0x3f800000
	.align 2
.LC62:
	.long 0x0
	.section	".text"
	.align 2
	.type	 Chicken_EggSplat,@function
Chicken_EggSplat:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 27,5
	mr 28,4
	mr 26,3
	bl G_Spawn
	lfs 13,0(28)
	mr 29,3
	addi 4,29,16
	mr 3,27
	stfs 13,4(29)
	lfs 0,4(28)
	stfs 0,8(29)
	lfs 13,8(28)
	stfs 13,12(29)
	bl vectoangles
	lis 9,.LC57@ha
	lfs 0,16(29)
	li 0,0
	la 9,.LC57@l(9)
	lis 28,gi@ha
	stw 0,200(29)
	lfs 13,0(9)
	la 28,gi@l(28)
	lis 3,.LC52@ha
	stw 0,196(29)
	la 3,.LC52@l(3)
	stw 0,192(29)
	fadds 0,0,13
	stw 0,188(29)
	stw 0,208(29)
	stw 0,204(29)
	stfs 0,16(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 8,.LC53@ha
	lis 9,g_edicts@ha
	stw 3,40(29)
	lfs 0,.LC53@l(8)
	lis 11,Chicken_EggSplatTouch@ha
	li 10,7
	lwz 7,g_edicts@l(9)
	la 11,Chicken_EggSplatTouch@l(11)
	li 0,2
	li 9,0
	stw 10,260(29)
	stw 7,256(29)
	stw 0,248(29)
	stfs 0,408(29)
	stw 9,64(29)
	stw 11,444(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC58@ha
	lis 10,.LC54@ha
	stw 0,16(1)
	la 11,.LC58@l(11)
	lis 8,level+4@ha
	lfd 12,0(11)
	mr 3,29
	lfd 0,16(1)
	lis 11,.LC59@ha
	lfs 11,.LC54@l(10)
	la 11,.LC59@l(11)
	lis 9,.LC60@ha
	lfs 13,level+4@l(8)
	la 9,.LC60@l(9)
	fsub 0,0,12
	lfs 10,0(11)
	lfs 9,0(9)
	lis 11,.LC55@ha
	lis 9,G_FreeEdict@ha
	la 11,.LC55@l(11)
	frsp 0,0
	la 9,G_FreeEdict@l(9)
	stw 11,280(29)
	fadds 13,13,10
	stw 9,436(29)
	fdivs 0,0,11
	fmadds 0,0,9,13
	stfs 0,428(29)
	lwz 9,72(28)
	mtlr 9
	blrl
	lwz 9,36(28)
	lis 3,.LC56@ha
	la 3,.LC56@l(3)
	mtlr 9
	blrl
	lis 9,.LC61@ha
	lwz 0,16(28)
	lis 11,.LC61@ha
	la 9,.LC61@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC61@l(11)
	li 4,0
	mtlr 0
	lis 9,.LC62@ha
	mr 3,26
	lfs 2,0(11)
	la 9,.LC62@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 Chicken_EggSplat,.Lfe8-Chicken_EggSplat
	.section	".rodata"
	.align 2
.LC63:
	.string	"models/objects/debris2/tris.md2"
	.align 2
.LC64:
	.long 0x3ecccccd
	.align 3
.LC65:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC66:
	.long 0x40240000
	.long 0x0
	.align 2
.LC67:
	.long 0x40800000
	.align 3
.LC68:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC69:
	.long 0x43960000
	.section	".text"
	.align 2
	.type	 Chicken_EggTouch,@function
Chicken_EggTouch:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 30,3
	mr 31,4
	lwz 0,256(30)
	mr 28,5
	cmpw 0,31,0
	bc 12,2,.L82
	cmpwi 0,6,0
	bc 12,2,.L84
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L84
	bl G_FreeEdict
	b .L82
.L84:
	lis 9,.LC64@ha
	addi 29,30,4
	lfs 1,.LC64@l(9)
	lis 4,.LC63@ha
	mr 3,30
	la 4,.LC63@l(4)
	mr 5,29
	li 6,3
	bl Chicken_ThrowEggShell
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L85
	lwz 6,84(31)
	cmpwi 0,6,0
	bc 4,2,.L86
	lwz 5,256(30)
	li 0,4
	mr 3,31
	stw 6,12(1)
	mr 7,29
	mr 8,28
	stw 0,8(1)
	mr 4,30
	addi 6,30,376
	li 9,10
	li 10,1
	bl T_Damage
	b .L94
.L86:
	lis 11,kickback@ha
	lwz 7,256(30)
	lwz 0,kickback@l(11)
	lis 5,0x4330
	lis 11,.LC65@ha
	cmpwi 0,7,0
	xoris 0,0,0x8000
	la 11,.LC65@l(11)
	stw 0,28(1)
	stw 5,24(1)
	lfd 12,0(11)
	lfd 0,24(1)
	lis 11,.LC66@ha
	la 11,.LC66@l(11)
	lfd 13,0(11)
	fsub 0,0,12
	fdiv 0,0,13
	frsp 1,0
	bc 12,2,.L89
	lis 10,level@ha
	lwz 11,540(30)
	lwz 0,level@l(10)
	lwz 8,84(11)
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 5,24(1)
	lfd 0,24(1)
	lfs 13,3688(8)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L88
	lis 9,.LC67@ha
	la 9,.LC67@l(9)
	lfs 0,0(9)
	fmuls 1,1,0
.L88:
	lwz 9,84(7)
	lwz 11,3760(6)
	lwz 0,3760(9)
	cmpw 0,0,11
	bc 4,2,.L89
	lis 11,.LC68@ha
	fmr 0,1
	la 11,.LC68@l(11)
	lfd 13,0(11)
	fmul 0,0,13
	frsp 1,0
.L89:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L90
	lfs 12,376(30)
	lis 9,.LC69@ha
	lfs 0,376(31)
	la 9,.LC69@l(9)
	lfs 10,380(31)
	lfs 13,384(31)
	fmadds 12,12,1,0
	lfs 11,0(9)
	stfs 12,376(31)
	fadds 13,13,11
	lfs 0,380(30)
	stfs 13,384(31)
	fmadds 0,0,1,10
	stfs 0,380(31)
	b .L94
.L90:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L92
	addi 3,31,376
	addi 4,30,376
	mr 5,3
	bl VectorMA
	b .L94
.L92:
	lfs 13,376(30)
	lfs 0,376(31)
	lfs 12,380(31)
	fmadds 13,13,1,0
	stfs 13,376(31)
	lfs 0,380(30)
	fmadds 0,0,1,12
	stfs 0,380(31)
	b .L94
.L85:
	cmpwi 0,28,0
	bc 4,2,.L95
	lis 5,vec3_origin@ha
	mr 4,29
	la 5,vec3_origin@l(5)
	mr 3,30
	bl Chicken_EggSplat
	b .L94
.L95:
	mr 4,29
	mr 5,28
	mr 3,30
	bl Chicken_EggSplat
.L94:
	mr 3,30
	bl G_FreeEdict
.L82:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 Chicken_EggTouch,.Lfe9-Chicken_EggTouch
	.section	".rodata"
	.align 2
.LC72:
	.string	"models/objects/egg/tris.md2"
	.align 2
.LC73:
	.string	"egg"
	.align 2
.LC74:
	.string	"chicken/egggun.wav"
	.align 2
.LC70:
	.long 0x46fffe00
	.align 3
.LC71:
	.long 0x4062c000
	.long 0x0
	.align 3
.LC75:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC76:
	.long 0xc0000000
	.align 3
.LC77:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC78:
	.long 0x40240000
	.long 0x0
	.align 2
.LC79:
	.long 0x447a0000
	.align 3
.LC80:
	.long 0x40040000
	.long 0x0
	.align 2
.LC81:
	.long 0x3f800000
	.align 2
.LC82:
	.long 0x0
	.section	".text"
	.align 2
	.type	 Chicken_EggGunFire,@function
Chicken_EggGunFire:
	stwu 1,-192(1)
	mflr 0
	stfd 28,160(1)
	stfd 29,168(1)
	stfd 30,176(1)
	stfd 31,184(1)
	stmw 25,132(1)
	stw 0,196(1)
	mr 27,3
	lwz 9,508(27)
	lis 25,0x4330
	lis 10,.LC75@ha
	la 10,.LC75@l(10)
	lwz 3,84(27)
	addi 30,1,24
	addi 9,9,-8
	lfd 28,0(10)
	lis 0,0x4100
	xoris 9,9,0x8000
	addi 26,1,40
	stw 0,76(1)
	stw 9,124(1)
	addi 3,3,3616
	mr 4,30
	stw 25,120(1)
	mr 5,26
	li 6,0
	lfd 0,120(1)
	stw 0,72(1)
	fsub 0,0,28
	frsp 0,0
	stfs 0,80(1)
	bl AngleVectors
	lwz 3,84(27)
	mr 7,26
	addi 8,1,88
	addi 5,1,72
	mr 6,30
	addi 4,27,4
	bl P_ProjectSource
	lis 9,.LC76@ha
	lwz 4,84(27)
	mr 3,30
	la 9,.LC76@l(9)
	lfs 1,0(9)
	addi 4,4,3564
	bl VectorScale
	lwz 9,84(27)
	lis 0,0xbf80
	stw 0,3552(9)
	bl G_Spawn
	mr. 31,3
	bc 12,2,.L98
	addi 4,1,8
	mr 3,30
	bl vectoangles
	addi 29,31,376
	addi 28,1,56
	addi 3,1,8
	mr 6,28
	mr 5,26
	mr 4,30
	bl AngleVectors
	lfs 13,88(1)
	lis 9,.LC77@ha
	lis 10,.LC78@ha
	la 9,.LC77@l(9)
	la 10,.LC78@l(10)
	lfd 30,0(9)
	mr 4,29
	mr 3,30
	stfs 13,4(31)
	lis 9,.LC79@ha
	lfs 0,92(1)
	la 9,.LC79@l(9)
	lfs 1,0(9)
	lfd 29,0(10)
	stfs 0,8(31)
	lfs 13,96(1)
	stfs 13,12(31)
	bl VectorScale
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC70@ha
	stw 3,124(1)
	lis 11,.LC71@ha
	mr 5,29
	stw 25,120(1)
	mr 4,28
	mr 3,29
	lfd 0,120(1)
	lfs 31,.LC70@l(10)
	lfd 13,.LC71@l(11)
	fsub 0,0,28
	frsp 0,0
	fdivs 0,0,31
	fmr 1,0
	fsub 1,1,30
	fadd 1,1,1
	fmadd 1,1,29,13
	frsp 1,1
	bl VectorMA
	bl rand
	rlwinm 0,3,0,17,31
	xoris 0,0,0x8000
	mr 3,29
	stw 0,124(1)
	mr 5,3
	mr 4,26
	stw 25,120(1)
	lfd 0,120(1)
	fsub 0,0,28
	frsp 0,0
	fdivs 0,0,31
	fmr 1,0
	fsub 1,1,30
	fadd 1,1,1
	fmul 1,1,29
	frsp 1,1
	bl VectorMA
	lis 0,0x4396
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,396(31)
	lis 3,.LC72@ha
	stw 0,388(31)
	la 3,.LC72@l(3)
	stw 0,392(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,0x600
	lis 10,Chicken_EggTouch@ha
	stw 3,40(31)
	lis 8,0xc080
	lis 7,0x4080
	stw 27,256(31)
	li 5,0
	la 10,Chicken_EggTouch@l(10)
	stw 8,196(31)
	ori 9,9,3
	li 6,2
	stw 5,64(31)
	li 0,7
	stw 7,208(31)
	lis 4,level+4@ha
	stw 0,260(31)
	lis 11,.LC73@ha
	mr 3,31
	stw 9,252(31)
	li 0,0
	la 11,.LC73@l(11)
	stw 6,248(31)
	lis 9,.LC80@ha
	stw 10,444(31)
	la 9,.LC80@l(9)
	stw 8,188(31)
	lis 10,0x3f40
	stw 8,192(31)
	stw 7,200(31)
	stw 7,204(31)
	lfs 0,level+4@l(4)
	lfd 13,0(9)
	lis 9,G_FreeEdict@ha
	stw 5,516(31)
	la 9,G_FreeEdict@l(9)
	stw 0,524(31)
	stw 10,408(31)
	stw 11,280(31)
	fadd 0,0,13
	stw 9,436(31)
	stw 27,540(31)
	frsp 0,0
	stfs 0,428(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	lwz 11,84(27)
	lis 3,.LC74@ha
	la 3,.LC74@l(3)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC81@ha
	lwz 0,16(29)
	lis 10,.LC81@ha
	la 9,.LC81@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC81@l(10)
	li 4,0
	mtlr 0
	lis 9,.LC82@ha
	mr 3,27
	lfs 2,0(10)
	la 9,.LC82@l(9)
	lfs 3,0(9)
	blrl
.L98:
	lwz 0,196(1)
	mtlr 0
	lmw 25,132(1)
	lfd 28,160(1)
	lfd 29,168(1)
	lfd 30,176(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe10:
	.size	 Chicken_EggGunFire,.Lfe10-Chicken_EggGunFire
	.section	".data"
	.align 2
	.type	 pause_frames.47,@object
pause_frames.47:
	.long 5
	.long 25
	.long 34
	.long 44
	.long 0
	.align 2
	.type	 fire_frames.48,@object
fire_frames.48:
	.long 7
	.long 0
	.comm	teamPlayerMenuLine,108,1
	.section	".rodata"
	.align 2
.LC83:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chicken_PlayerReadyEggGun
	.type	 Chicken_PlayerReadyEggGun,@function
Chicken_PlayerReadyEggGun:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 11,.LC83@ha
	lis 9,deathmatch@ha
	la 11,.LC83@l(11)
	mr 31,3
	lfs 13,0(11)
	li 30,0
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L7
	lis 9,chickenGame@ha
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L7
	lis 9,teams@ha
	lwz 0,teams@l(9)
	cmpwi 0,0,0
	bc 12,2,.L7
	lwz 10,84(31)
	lwz 0,3760(10)
	cmpw 0,0,4
	bc 4,2,.L7
	lwz 0,44(31)
	cmpwi 0,0,0
	bc 12,2,.L7
	lis 9,eggGunItemIndex@ha
	addi 10,10,740
	lwz 0,eggGunItemIndex@l(9)
	li 11,1
	slwi 0,0,2
	stwx 11,10,0
	bl Chicken_Ready
	lwz 10,84(31)
	lis 9,itemlist@ha
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	lwz 0,1788(10)
	subf 0,9,0
	mullw 0,0,11
	srawi 0,0,3
	stw 0,736(10)
	lwz 9,84(31)
	stw 30,3492(9)
	li 30,1
.L7:
	mr 3,30
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 Chicken_PlayerReadyEggGun,.Lfe11-Chicken_PlayerReadyEggGun
	.align 2
	.globl Weapon_Egggun
	.type	 Weapon_Egggun,@function
Weapon_Egggun:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 8,pause_frames.47@ha
	lis 9,fire_frames.48@ha
	lis 10,Chicken_EggGunFire@ha
	la 8,pause_frames.47@l(8)
	la 9,fire_frames.48@l(9)
	la 10,Chicken_EggGunFire@l(10)
	li 4,5
	li 5,13
	li 6,50
	li 7,55
	bl Weapon_Generic
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe12:
	.size	 Weapon_Egggun,.Lfe12-Weapon_Egggun
	.align 2
	.globl Chicken_CheckPlayerModel
	.type	 Chicken_CheckPlayerModel,@function
Chicken_CheckPlayerModel:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 28,3
	li 30,0
	bl Chicken_GetModelName
	lis 9,playerModels@ha
	mr 29,3
	la 31,playerModels@l(9)
	addi 27,31,48
.L25:
	lwz 4,0(31)
	mr 3,29
	addi 31,31,24
	bl strcmp
	srawi 0,3,31
	cmpw 7,31,27
	xor 9,0,3
	subf 9,9,0
	srawi 9,9,31
	cror 31,30,28
	mfcr 11
	rlwinm 11,11,0,1
	addi 0,9,1
	and 9,30,9
	or. 30,9,0
	mfcr 0
	rlwinm 0,0,3,1
	and. 9,0,11
	bc 4,2,.L25
	lwz 9,84(28)
	mr 3,30
	stw 30,3736(9)
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 Chicken_CheckPlayerModel,.Lfe13-Chicken_CheckPlayerModel
	.section	".rodata"
	.align 2
.LC84:
	.long 0x42b40000
	.section	".text"
	.align 2
	.type	 Chicken_EggSplatTouch,@function
Chicken_EggSplatTouch:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr. 6,6
	mr 31,3
	mr 3,5
	bc 12,2,.L79
	lwz 0,16(6)
	andi. 9,0,4
	bc 4,2,.L78
.L79:
	cmpwi 0,3,0
	bc 4,2,.L77
.L78:
	mr 3,31
	bl G_FreeEdict
	b .L76
.L77:
	addi 4,31,16
	bl vectoangles
	lis 9,.LC84@ha
	lfs 0,16(31)
	la 9,.LC84@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,16(31)
.L76:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 Chicken_EggSplatTouch,.Lfe14-Chicken_EggSplatTouch
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
