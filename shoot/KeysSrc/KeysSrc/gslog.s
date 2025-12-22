	.file	"gslog.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.section	".sdata","aw"
	.align 2
	.type	 fWasAlreadyOpen,@object
	.size	 fWasAlreadyOpen,4
fWasAlreadyOpen:
	.long 0
	.align 2
	.type	 pPatch,@object
	.size	 pPatch,4
pPatch:
	.long 0
	.section	".rodata"
	.align 2
.LC0:
	.string	"dmflags"
	.align 2
.LC1:
	.string	"0"
	.align 2
.LC2:
	.string	"Suicide"
	.align 2
.LC3:
	.string	"Flames"
	.align 2
.LC4:
	.string	"Drunk Rocket"
	.align 2
.LC5:
	.string	"Fell"
	.align 2
.LC6:
	.string	"Crushed"
	.align 2
.LC7:
	.string	"Drowned"
	.align 2
.LC8:
	.string	"Melted"
	.align 2
.LC9:
	.string	"Lava"
	.align 2
.LC10:
	.string	"Explosion"
	.align 2
.LC11:
	.string	"Lasered"
	.align 2
.LC12:
	.string	"Blasted"
	.align 2
.LC13:
	.string	"Kill"
	.align 2
.LC14:
	.string	"Telefrag"
	.align 2
.LC15:
	.string	"Hook"
	.align 2
.LC16:
	.string	"Frozen"
	.align 2
.LC17:
	.string	"GibGun"
	.align 2
.LC18:
	.string	"Homing Blaster"
	.align 2
.LC19:
	.string	"Homing Hyperblaster"
	.align 2
.LC20:
	.string	"Homing Rocket"
	.align 2
.LC21:
	.string	"Flash Grenade"
	.align 2
.LC22:
	.string	"Reverse Telefrag"
	.align 2
.LC23:
	.string	""
	.align 2
.LC24:
	.string	"ERROR"
	.align 2
.LC25:
	.long 0x0
	.align 3
.LC26:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_WriteStdLogDeath
	.type	 sl_WriteStdLogDeath,@function
sl_WriteStdLogDeath:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 11,.LC25@ha
	lis 9,deathmatch@ha
	la 11,.LC25@l(11)
	mr 28,3
	lfs 13,0(11)
	mr 24,4
	mr 31,5
	lwz 11,deathmatch@l(9)
	mr 25,7
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L23
	lis 27,pPatch@ha
	lwz 30,pPatch@l(27)
	bl sl_OpenLogFile
	mr. 26,3
	bc 12,2,.L23
	lis 9,fWasAlreadyOpen@ha
	lwz 0,fWasAlreadyOpen@l(9)
	cmpwi 0,0,0
	bc 4,2,.L25
	lwz 9,144(28)
	lis 3,.LC0@ha
	lis 4,.LC1@ha
	li 5,4
	la 4,.LC1@l(4)
	mtlr 9
	la 3,.LC0@l(3)
	blrl
	mr 29,3
	mr 3,28
	bl sl_LogVers
	mr 4,30
	mr 3,28
	stw 30,pPatch@l(27)
	bl sl_LogPatch
	mr 3,28
	bl sl_LogDate
	mr 3,28
	bl sl_LogTime
	lfs 0,20(29)
	lis 9,.LC26@ha
	la 9,.LC26@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L26
	fctiwz 0,13
	stfd 0,8(1)
	lwz 4,12(1)
	b .L27
.L26:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 4,12(1)
	xoris 4,4,0x8000
.L27:
	mr 3,28
	bl sl_LogDeathFlags
	lis 9,fWasAlreadyOpen@ha
	stw 26,fWasAlreadyOpen@l(9)
.L25:
	cmpwi 0,26,0
	bc 12,2,.L23
	lis 9,meansOfDeath@ha
	cmpw 0,25,31
	lwz 0,meansOfDeath@l(9)
	li 4,0
	li 5,0
	li 6,0
	li 7,0
	rlwinm 30,0,0,5,3
	li 8,0
	li 29,0
	bc 4,2,.L29
	lwz 11,84(31)
	lis 9,.LC2@ha
	li 8,-1
	la 6,.LC2@l(9)
	lwz 9,1788(11)
	addi 4,11,700
	cmpwi 0,9,0
	bc 12,2,.L30
	lwz 7,40(9)
.L30:
	cmpwi 0,30,35
	bc 4,2,.L32
	lis 9,.LC3@ha
	la 7,.LC3@l(9)
	b .L35
.L32:
	cmpwi 0,30,38
	bc 4,2,.L35
	lis 9,.LC4@ha
	la 7,.LC4@l(9)
	b .L35
.L29:
	addi 10,30,-17
	li 3,0
	cmplwi 0,10,16
	bc 12,1,.L36
	lis 11,.L51@ha
	slwi 10,10,2
	la 11,.L51@l(11)
	lis 9,.L51@ha
	lwzx 0,10,11
	la 9,.L51@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L51:
	.long .L39-.L51
	.long .L40-.L51
	.long .L41-.L51
	.long .L38-.L51
	.long .L36-.L51
	.long .L37-.L51
	.long .L50-.L51
	.long .L36-.L51
	.long .L44-.L51
	.long .L44-.L51
	.long .L44-.L51
	.long .L50-.L51
	.long .L50-.L51
	.long .L45-.L51
	.long .L50-.L51
	.long .L36-.L51
	.long .L46-.L51
.L37:
	lis 9,.LC5@ha
	li 3,1
	la 7,.LC5@l(9)
	b .L36
.L38:
	lis 9,.LC6@ha
	li 3,1
	la 7,.LC6@l(9)
	b .L36
.L39:
	lis 9,.LC7@ha
	li 3,1
	la 7,.LC7@l(9)
	b .L36
.L40:
	lis 9,.LC8@ha
	li 3,1
	la 7,.LC8@l(9)
	b .L36
.L41:
	lis 9,.LC9@ha
	li 3,1
	la 7,.LC9@l(9)
	b .L36
.L44:
	lis 9,.LC10@ha
	li 3,1
	la 7,.LC10@l(9)
	b .L36
.L45:
	lis 9,.LC11@ha
	li 3,1
	la 7,.LC11@l(9)
	b .L36
.L46:
	lis 9,.LC12@ha
	li 3,1
	la 7,.LC12@l(9)
	b .L36
.L50:
	li 3,1
.L36:
	cmpwi 0,3,0
	bc 12,2,.L35
	lwz 11,84(31)
	lis 9,.LC2@ha
	li 8,-1
	la 6,.LC2@l(9)
	addi 4,11,700
.L35:
	subfic 0,4,0
	adde 9,0,4
	subfic 11,6,0
	adde 0,11,6
	or. 11,9,0
	bc 12,2,.L54
	cmpwi 0,25,0
	bc 12,2,.L54
	lwz 0,84(25)
	cmpwi 0,0,0
	mr 3,0
	bc 12,2,.L54
	addi 0,30,-1
	lwz 29,184(3)
	cmplwi 0,0,65
	bc 12,1,.L74
	lis 11,.L90@ha
	slwi 10,0,2
	la 11,.L90@l(11)
	lis 9,.L90@ha
	lwzx 0,10,11
	la 9,.L90@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L90:
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L77-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L81-.L90
	.long .L79-.L90
	.long .L86-.L90
	.long .L87-.L90
	.long .L88-.L90
	.long .L89-.L90
	.long .L82-.L90
	.long .L83-.L90
	.long .L85-.L90
	.long .L84-.L90
	.long .L80-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L74-.L90
	.long .L78-.L90
.L74:
	lwz 10,1788(3)
	lis 9,.LC13@ha
	addi 4,3,700
	lwz 11,84(31)
	la 6,.LC13@l(9)
	li 8,1
	cmpwi 0,10,0
	li 7,0
	addi 5,11,700
	bc 12,2,.L54
	lwz 7,40(10)
	b .L54
.L77:
	lwz 9,84(31)
	lis 11,.LC13@ha
	lis 10,.LC14@ha
	addi 4,3,700
	la 6,.LC13@l(11)
	addi 5,9,700
	la 7,.LC14@l(10)
	b .L91
.L78:
	lwz 9,84(31)
	lis 11,.LC13@ha
	lis 10,.LC15@ha
	addi 4,3,700
	la 6,.LC13@l(11)
	addi 5,9,700
	la 7,.LC15@l(10)
	b .L91
.L79:
	lwz 9,84(31)
	lis 11,.LC13@ha
	lis 10,.LC3@ha
	addi 4,3,700
	la 6,.LC13@l(11)
	addi 5,9,700
	la 7,.LC3@l(10)
	b .L91
.L80:
	lwz 9,84(31)
	lis 11,.LC13@ha
	lis 10,.LC16@ha
	addi 4,3,700
	la 6,.LC13@l(11)
	addi 5,9,700
	la 7,.LC16@l(10)
	b .L91
.L81:
	lwz 9,84(31)
	lis 11,.LC13@ha
	lis 10,.LC17@ha
	addi 4,3,700
	la 6,.LC13@l(11)
	addi 5,9,700
	la 7,.LC17@l(10)
	b .L91
.L82:
	lwz 9,84(31)
	lis 11,.LC13@ha
	lis 10,.LC18@ha
	addi 4,3,700
	la 6,.LC13@l(11)
	addi 5,9,700
	la 7,.LC18@l(10)
	b .L91
.L83:
	lwz 9,84(31)
	lis 11,.LC13@ha
	lis 10,.LC19@ha
	addi 4,3,700
	la 6,.LC13@l(11)
	addi 5,9,700
	la 7,.LC19@l(10)
	b .L91
.L84:
	lwz 9,84(31)
	lis 11,.LC13@ha
	lis 10,.LC20@ha
	addi 4,3,700
	la 6,.LC13@l(11)
	addi 5,9,700
	la 7,.LC20@l(10)
	b .L91
.L85:
	lwz 9,84(31)
	lis 11,.LC13@ha
	lis 10,.LC20@ha
	addi 4,3,700
	la 6,.LC13@l(11)
	addi 5,9,700
	la 7,.LC20@l(10)
	b .L91
.L86:
	lwz 9,84(31)
	lis 11,.LC13@ha
	lis 10,.LC21@ha
	addi 4,3,700
	la 6,.LC13@l(11)
	addi 5,9,700
	la 7,.LC21@l(10)
	b .L91
.L87:
	lwz 9,84(31)
	lis 11,.LC13@ha
	lis 10,.LC4@ha
	addi 4,3,700
	la 6,.LC13@l(11)
	addi 5,9,700
	la 7,.LC4@l(10)
	b .L91
.L88:
	lwz 9,84(31)
	lis 11,.LC13@ha
	lis 10,.LC4@ha
	addi 4,3,700
	la 6,.LC13@l(11)
	addi 5,9,700
	la 7,.LC4@l(10)
	b .L91
.L89:
	lwz 9,84(31)
	lis 11,.LC13@ha
	lis 10,.LC22@ha
	addi 4,3,700
	la 6,.LC13@l(11)
	addi 5,9,700
	la 7,.LC22@l(10)
.L91:
	li 8,1
.L54:
	lfs 1,4(24)
	mr 3,28
	mr 9,29
	bl sl_LogScore
	b .L22
.L23:
	lis 4,.LC23@ha
	lfs 1,4(24)
	lis 6,.LC24@ha
	la 4,.LC23@l(4)
	mr 3,28
	mr 5,4
	la 6,.LC24@l(6)
	mr 7,5
	li 8,0
	li 9,0
	bl sl_LogScore
.L22:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 sl_WriteStdLogDeath,.Lfe1-sl_WriteStdLogDeath
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
	.section	".rodata"
	.align 3
.LC27:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_Logging
	.type	 sl_Logging,@function
sl_Logging:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	bl sl_OpenLogFile
	mr. 28,3
	bc 12,2,.L7
	lis 9,fWasAlreadyOpen@ha
	lwz 0,fWasAlreadyOpen@l(9)
	cmpwi 0,0,0
	bc 4,2,.L7
	lwz 9,144(31)
	lis 3,.LC0@ha
	lis 4,.LC1@ha
	li 5,4
	la 4,.LC1@l(4)
	mtlr 9
	la 3,.LC0@l(3)
	blrl
	mr 29,3
	mr 3,31
	bl sl_LogVers
	lis 9,pPatch@ha
	mr 4,30
	stw 30,pPatch@l(9)
	mr 3,31
	bl sl_LogPatch
	mr 3,31
	bl sl_LogDate
	mr 3,31
	bl sl_LogTime
	lfs 0,20(29)
	lis 9,.LC27@ha
	la 9,.LC27@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L8
	fctiwz 0,13
	stfd 0,8(1)
	lwz 4,12(1)
	b .L9
.L8:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 4,12(1)
	xoris 4,4,0x8000
.L9:
	mr 3,31
	bl sl_LogDeathFlags
	lis 9,fWasAlreadyOpen@ha
	stw 28,fWasAlreadyOpen@l(9)
.L7:
	mr 3,28
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 sl_Logging,.Lfe2-sl_Logging
	.section	".rodata"
	.align 3
.LC28:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_GameStart
	.type	 sl_GameStart,@function
sl_GameStart:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 31,3
	lis 28,pPatch@ha
	lwz 30,pPatch@l(28)
	mr 26,4
	bl sl_OpenLogFile
	mr. 27,3
	bc 12,2,.L11
	lis 9,fWasAlreadyOpen@ha
	lwz 0,fWasAlreadyOpen@l(9)
	cmpwi 0,0,0
	bc 4,2,.L12
	lwz 9,144(31)
	lis 3,.LC0@ha
	lis 4,.LC1@ha
	li 5,4
	la 4,.LC1@l(4)
	mtlr 9
	la 3,.LC0@l(3)
	blrl
	mr 29,3
	mr 3,31
	bl sl_LogVers
	mr 4,30
	mr 3,31
	stw 30,pPatch@l(28)
	bl sl_LogPatch
	mr 3,31
	bl sl_LogDate
	mr 3,31
	bl sl_LogTime
	lfs 0,20(29)
	lis 9,.LC28@ha
	la 9,.LC28@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L13
	fctiwz 0,13
	stfd 0,16(1)
	lwz 4,20(1)
	b .L14
.L13:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 4,20(1)
	xoris 4,4,0x8000
.L14:
	mr 3,31
	bl sl_LogDeathFlags
	lis 9,fWasAlreadyOpen@ha
	stw 27,fWasAlreadyOpen@l(9)
.L12:
	cmpwi 0,27,0
	bc 12,2,.L11
	mr 3,31
	addi 4,26,8
	bl sl_LogMapName
	lfs 1,4(26)
	mr 3,31
	bl sl_LogGameStart
.L11:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 sl_GameStart,.Lfe3-sl_GameStart
	.section	".rodata"
	.align 3
.LC29:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_GameEnd
	.type	 sl_GameEnd,@function
sl_GameEnd:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 31,3
	lis 28,pPatch@ha
	lwz 30,pPatch@l(28)
	mr 26,4
	bl sl_OpenLogFile
	mr. 27,3
	bc 12,2,.L17
	lis 9,fWasAlreadyOpen@ha
	lwz 0,fWasAlreadyOpen@l(9)
	cmpwi 0,0,0
	bc 4,2,.L18
	lwz 9,144(31)
	lis 3,.LC0@ha
	lis 4,.LC1@ha
	li 5,4
	la 4,.LC1@l(4)
	mtlr 9
	la 3,.LC0@l(3)
	blrl
	mr 29,3
	mr 3,31
	bl sl_LogVers
	mr 4,30
	mr 3,31
	stw 30,pPatch@l(28)
	bl sl_LogPatch
	mr 3,31
	bl sl_LogDate
	mr 3,31
	bl sl_LogTime
	lfs 0,20(29)
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L19
	fctiwz 0,13
	stfd 0,16(1)
	lwz 4,20(1)
	b .L20
.L19:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 4,20(1)
	xoris 4,4,0x8000
.L20:
	mr 3,31
	bl sl_LogDeathFlags
	lis 9,fWasAlreadyOpen@ha
	stw 27,fWasAlreadyOpen@l(9)
.L18:
	cmpwi 0,27,0
	bc 12,2,.L17
	lfs 1,4(26)
	mr 3,31
	bl sl_LogGameEnd
	bl sl_CloseLogFile
	lis 9,fWasAlreadyOpen@ha
	li 0,0
	stw 0,fWasAlreadyOpen@l(9)
.L17:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 sl_GameEnd,.Lfe4-sl_GameEnd
	.section	".rodata"
	.align 3
.LC30:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_WriteStdLogPlayerEntered
	.type	 sl_WriteStdLogPlayerEntered,@function
sl_WriteStdLogPlayerEntered:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr 31,3
	lis 28,pPatch@ha
	lwz 30,pPatch@l(28)
	mr 25,4
	mr 26,5
	bl sl_OpenLogFile
	mr. 27,3
	bc 12,2,.L93
	lis 9,fWasAlreadyOpen@ha
	lwz 0,fWasAlreadyOpen@l(9)
	cmpwi 0,0,0
	bc 4,2,.L94
	lwz 9,144(31)
	lis 3,.LC0@ha
	lis 4,.LC1@ha
	li 5,4
	la 4,.LC1@l(4)
	mtlr 9
	la 3,.LC0@l(3)
	blrl
	mr 29,3
	mr 3,31
	bl sl_LogVers
	mr 4,30
	mr 3,31
	stw 30,pPatch@l(28)
	bl sl_LogPatch
	mr 3,31
	bl sl_LogDate
	mr 3,31
	bl sl_LogTime
	lfs 0,20(29)
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L95
	fctiwz 0,13
	stfd 0,24(1)
	lwz 4,28(1)
	b .L96
.L95:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 4,28(1)
	xoris 4,4,0x8000
.L96:
	mr 3,31
	bl sl_LogDeathFlags
	lis 9,fWasAlreadyOpen@ha
	stw 27,fWasAlreadyOpen@l(9)
.L94:
	cmpwi 0,27,0
	bc 12,2,.L93
	lwz 4,84(26)
	mr 3,31
	li 5,0
	lfs 1,4(25)
	addi 4,4,700
	bl sl_LogPlayerConnect
.L93:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 sl_WriteStdLogPlayerEntered,.Lfe5-sl_WriteStdLogPlayerEntered
	.section	".rodata"
	.align 3
.LC31:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_LogPlayerDisconnect
	.type	 sl_LogPlayerDisconnect,@function
sl_LogPlayerDisconnect:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr 31,3
	lis 28,pPatch@ha
	lwz 30,pPatch@l(28)
	mr 25,4
	mr 26,5
	bl sl_OpenLogFile
	mr. 27,3
	bc 12,2,.L99
	lis 9,fWasAlreadyOpen@ha
	lwz 0,fWasAlreadyOpen@l(9)
	cmpwi 0,0,0
	bc 4,2,.L100
	lwz 9,144(31)
	lis 3,.LC0@ha
	lis 4,.LC1@ha
	li 5,4
	la 4,.LC1@l(4)
	mtlr 9
	la 3,.LC0@l(3)
	blrl
	mr 29,3
	mr 3,31
	bl sl_LogVers
	mr 4,30
	mr 3,31
	stw 30,pPatch@l(28)
	bl sl_LogPatch
	mr 3,31
	bl sl_LogDate
	mr 3,31
	bl sl_LogTime
	lfs 0,20(29)
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L101
	fctiwz 0,13
	stfd 0,24(1)
	lwz 4,28(1)
	b .L102
.L101:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 4,28(1)
	xoris 4,4,0x8000
.L102:
	mr 3,31
	bl sl_LogDeathFlags
	lis 9,fWasAlreadyOpen@ha
	stw 27,fWasAlreadyOpen@l(9)
.L100:
	cmpwi 0,27,0
	bc 12,2,.L99
	lwz 4,84(26)
	mr 3,31
	lfs 1,4(25)
	addi 4,4,700
	bl sl_LogPlayerLeft
.L99:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 sl_LogPlayerDisconnect,.Lfe6-sl_LogPlayerDisconnect
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
