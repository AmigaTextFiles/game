	.file	"trond_skin.c"
gcc2_compiled.:
	.globl skinmenu
	.section	".data"
	.align 2
	.type	 skinmenu,@object
skinmenu:
	.long .LC0
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC1
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC2
	.long 0
	.long 0
	.long ChangeSkin1
	.long .LC3
	.long 0
	.long 0
	.long ChangeSkin2
	.long .LC4
	.long 0
	.long 0
	.long ChangeSkin3
	.long .LC5
	.long 0
	.long 0
	.long ChangeSkin4
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC6
	.long 0
	.long 0
	.long 0
	.long .LC7
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC7:
	.string	"ENTER to select"
	.align 2
.LC6:
	.string	"Use [ and ] to move cursor"
	.align 2
.LC5:
	.string	"Police Woman"
	.align 2
.LC4:
	.string	"SWAT"
	.align 2
.LC3:
	.string	"Terminator"
	.align 2
.LC2:
	.string	"Terrorist"
	.align 2
.LC1:
	.string	"*What do you wanna play as?"
	.align 2
.LC0:
	.string	"*SLAT Software`s Terror Quake"
	.size	 skinmenu,272
	.lcomm	levelname.18,32,4
	.lcomm	team1players.19,32,4
	.lcomm	team2players.20,32,4
	.align 2
.LC8:
	.string	"  (%d Terrorist(s))"
	.align 2
.LC9:
	.string	"  (%d Police guy(s))"
	.align 2
.LC10:
	.long 0x0
	.align 3
.LC11:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFUpdateSkinMenu
	.type	 CTFUpdateSkinMenu,@function
CTFUpdateSkinMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 11,skinmenu@ha
	lis 9,.LC2@ha
	lis 8,g_edicts@ha
	la 11,skinmenu@l(11)
	lwz 5,g_edicts@l(8)
	la 9,.LC2@l(9)
	lis 10,.LC3@ha
	lis 7,.LC5@ha
	stw 9,64(11)
	la 10,.LC3@l(10)
	la 7,.LC5@l(7)
	lis 9,levelname.18@ha
	stw 10,80(11)
	stw 7,112(11)
	lis 6,.LC4@ha
	li 0,42
	stb 0,levelname.18@l(9)
	la 6,.LC4@l(6)
	la 3,levelname.18@l(9)
	stw 6,96(11)
	lwz 4,276(5)
	cmpwi 0,4,0
	bc 12,2,.L15
	addi 3,3,1
	li 5,30
	bl strncpy
	b .L16
.L15:
	lis 4,level+72@ha
	addi 3,3,1
	la 4,level+72@l(4)
	li 5,30
	bl strncpy
.L16:
	lis 9,maxclients@ha
	lis 11,levelname.18+31@ha
	lwz 10,maxclients@l(9)
	li 0,0
	lis 4,.LC10@ha
	la 4,.LC10@l(4)
	stb 0,levelname.18+31@l(11)
	li 31,0
	lfs 0,0(4)
	li 30,0
	li 7,0
	lfs 13,20(10)
	fcmpu 0,0,13
	bc 4,0,.L18
	lis 9,g_edicts@ha
	fmr 12,13
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	la 5,game@l(11)
	lis 6,0x4330
	lis 9,.LC11@ha
	li 8,0
	la 9,.LC11@l(9)
	addi 10,10,1016
	lfd 13,0(9)
.L20:
	lwz 0,0(10)
	addi 10,10,928
	cmpwi 0,0,0
	bc 12,2,.L19
	lwz 9,1028(5)
	add 9,8,9
	lwz 11,3532(9)
	cmpwi 0,11,1
	bc 4,2,.L22
	addi 30,30,1
	b .L19
.L22:
	xori 11,11,2
	addi 9,31,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,31,0
	or 31,0,9
.L19:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,4080
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L20
.L18:
	lis 3,team1players.19@ha
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	mr 5,30
	la 3,team1players.19@l(3)
	crxor 6,6,6
	bl sprintf
	lis 3,team2players.20@ha
	lis 4,.LC9@ha
	la 3,team2players.20@l(3)
	la 4,.LC9@l(4)
	mr 5,31
	crxor 6,6,6
	bl sprintf
	cmpw 0,30,31
	bc 12,1,.L32
	cmpw 0,31,30
	bc 4,1,.L27
.L32:
	li 3,1
	b .L31
.L27:
	bl rand
	andi. 0,3,1
	mfcr 3
	rlwinm 3,3,3,1
	neg 3,3
	addi 0,3,1
	rlwinm 3,3,0,30,30
	or 3,3,0
.L31:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 CTFUpdateSkinMenu,.Lfe1-CTFUpdateSkinMenu
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_UZIclip,4,4
	.comm	item_9mm,4,4
	.comm	item_1911rounds,4,4
	.comm	item_50cal,4,4
	.comm	item_MARINERrounds,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_sshotgun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	ctfgame,24,4
	.comm	enemies,4,4
	.comm	spawned,4,4
	.comm	lms_round,4,4
	.comm	terror_l,4,4
	.comm	swat_l,4,4
	.comm	lms_delay,4,4
	.comm	lms_delay2,4,4
	.comm	lms_players,4,4
	.comm	lms_dead_players,4,4
	.comm	lms_alive_players,4,4
	.comm	lms_round_over,4,4
	.align 2
	.globl ChangeSkin1
	.type	 ChangeSkin1,@function
ChangeSkin1:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L6
	li 0,1
	stw 0,3580(9)
	bl painskin
.L6:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe2:
	.size	 ChangeSkin1,.Lfe2-ChangeSkin1
	.align 2
	.globl ChangeSkin2
	.type	 ChangeSkin2,@function
ChangeSkin2:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L8
	li 0,2
	stw 0,3580(9)
	bl painskin
.L8:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 ChangeSkin2,.Lfe3-ChangeSkin2
	.align 2
	.globl ChangeSkin3
	.type	 ChangeSkin3,@function
ChangeSkin3:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L10
	li 0,3
	stw 0,3580(9)
	bl painskin
.L10:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 ChangeSkin3,.Lfe4-ChangeSkin3
	.align 2
	.globl ChangeSkin4
	.type	 ChangeSkin4,@function
ChangeSkin4:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L12
	li 0,4
	stw 0,3580(9)
	bl painskin
.L12:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe5:
	.size	 ChangeSkin4,.Lfe5-ChangeSkin4
	.align 2
	.globl CTFOpenSkinMenu
	.type	 CTFOpenSkinMenu,@function
CTFOpenSkinMenu:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 0,1
	lwz 9,84(31)
	stw 0,3576(9)
	bl CTFUpdateSkinMenu
	lwz 9,84(31)
	mr 5,3
	lwz 0,3924(9)
	cmpwi 0,0,0
	bc 12,2,.L34
	li 5,8
	b .L35
.L34:
	xori 9,5,1
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	rlwinm 0,0,0,29,30
	ori 5,0,4
.L35:
	lis 4,skinmenu@ha
	mr 3,31
	la 4,skinmenu@l(4)
	li 6,17
	bl PMenu_Open
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 CTFOpenSkinMenu,.Lfe6-CTFOpenSkinMenu
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
