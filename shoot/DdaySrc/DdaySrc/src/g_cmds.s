	.file	"g_cmds.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Observer Mode is only available before you join a team.\n"
	.align 2
.LC1:
	.string	""
	.align 2
.LC2:
	.string	"Observer Mode Not Available\n"
	.align 2
.LC3:
	.string	"Observer Mode Password Incorrect\n"
	.align 2
.LC4:
	.string	"***** %s is no longer an Observer *****\n"
	.align 2
.LC5:
	.string	"***** %s is now an Observer *****\n"
	.section	".text"
	.align 2
	.globl Cmd_FlyingNunMode_f
	.type	 Cmd_FlyingNunMode_f,@function
Cmd_FlyingNunMode_f:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 27,gi@ha
	mr 31,3
	la 30,gi@l(27)
	lwz 9,164(30)
	mtlr 9
	blrl
	lwz 9,84(31)
	mr 28,3
	lwz 0,3472(9)
	cmpwi 0,0,0
	bc 12,2,.L7
	lwz 0,8(30)
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,2
	b .L13
.L7:
	lis 29,flyingnun_password@ha
	lis 4,.LC1@ha
	lwz 9,flyingnun_password@l(29)
	la 4,.LC1@l(4)
	lwz 3,4(9)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L8
	lwz 0,8(30)
	lis 5,.LC2@ha
	mr 3,31
	la 5,.LC2@l(5)
	li 4,2
	b .L13
.L8:
	lwz 9,flyingnun_password@l(29)
	mr 4,28
	lwz 3,4(9)
	bl Q_stricmp
	mr. 9,3
	bc 12,2,.L9
	lwz 0,8(30)
	lis 5,.LC3@ha
	mr 3,31
	la 5,.LC3@l(5)
	li 4,2
	b .L13
.L9:
	lwz 0,996(31)
	cmpwi 0,0,0
	bc 12,2,.L11
	stw 9,996(31)
	lis 4,.LC4@ha
	li 3,3
	lwz 5,84(31)
	la 4,.LC4@l(4)
	lwz 0,gi@l(27)
	addi 5,5,700
.L13:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L11:
	li 0,1
	lwz 5,84(31)
	lis 4,.LC5@ha
	stw 0,996(31)
	la 4,.LC5@l(4)
	li 3,3
	lwz 0,gi@l(27)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L6:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Cmd_FlyingNunMode_f,.Lfe1-Cmd_FlyingNunMode_f
	.section	".rodata"
	.align 2
.LC6:
	.string	"say Alicia Silverstone Is the Loveliest Actress In the Whole Universe!"
	.align 2
.LC7:
	.string	"%s\n"
	.align 2
.LC8:
	.string	"You have the Sex Pistols!"
	.globl id_GameCmds
	.section	".data"
	.align 2
	.type	 id_GameCmds,@object
	.size	 id_GameCmds,492
id_GameCmds:
	.long .LC9
	.long 1
	.long Cmd_Use_f
	.long .LC10
	.long 1
	.long Cmd_Drop_f
	.long .LC11
	.long 1
	.long Cmd_Give_f
	.long .LC12
	.long 1
	.long Cmd_God_f
	.long .LC13
	.long 1
	.long Cmd_Notarget_f
	.long .LC14
	.long 1
	.long Cmd_Noclip_f
	.long .LC15
	.long 1
	.long Cmd_Help_f
	.long .LC16
	.long 1
	.long Cmd_Help_f
	.long .LC17
	.long 1
	.long Cmd_Inven_f
	.long .LC18
	.long 2
	.long SelectNextItem
	.long .LC19
	.long 2
	.long SelectPrevItem
	.long .LC20
	.long 1
	.long Cmd_InvUse_f
	.long .LC21
	.long 1
	.long Cmd_WeapPrev_f
	.long .LC22
	.long 1
	.long Cmd_WeapNext_f
	.long .LC23
	.long 1
	.long Cmd_Kill_f
	.long .LC24
	.long 1
	.long Cmd_PutAway_f
	.long .LC25
	.long 1
	.long Cmd_Wave_f
	.long .LC26
	.long 1
	.long Cmd_GameVersion_f
	.long .LC27
	.long 1
	.long Cmd_Stance
	.long .LC28
	.long 1
	.long Cmd_Arty_f
	.long .LC29
	.long 1
	.long Cmd_Menu_Class_f
	.long .LC30
	.long 1
	.long Cmd_Menu_Team_f
	.long .LC31
	.long 1
	.long Cmd_Menu_Team_f
	.long .LC32
	.long 1
	.long Cmd_Menu_Main_f
	.long .LC33
	.long 1
	.long Cmd_List_team
	.long .LC34
	.long 1
	.long Cmd_Reload_f
	.long .LC35
	.long 2
	.long Cmd_Scope_f
	.long .LC36
	.long 3
	.long Cmd_Shout_f
	.long .LC37
	.long 1
	.long Cmd_AliciaMode_f
	.long .LC38
	.long 1
	.long Cmd_SexPistols_f
	.long .LC39
	.long 1
	.long Cmd_FlyingNunMode_f
	.long .LC40
	.long 1
	.long Cmd_DDHelp_f
	.long .LC41
	.long 1
	.long Cmd_DDebug_f
	.long .LC42
	.long 1
	.long Cmd_Maplist_f
	.long .LC43
	.long 1
	.long Cmd_AutoPickUp_f
	.long .LC44
	.long 1
	.long Cmd_PlayerID_f
	.long .LC45
	.long 1
	.long Cmd_Medic_Call_f
	.long .LC46
	.long 1
	.long Cmd_MOTD
	.long .LC47
	.long 1
	.long Cmd_Menu_Main_f
	.long .LC48
	.long 1
	.long Cmd_Menu_Team_f
	.long .LC49
	.long 1
	.long Cmd_Menu_Class_f
	.section	".rodata"
	.align 2
.LC49:
	.string	"dday_menu_class"
	.align 2
.LC48:
	.string	"dday_menu_team"
	.align 2
.LC47:
	.string	"dday_menu_main"
	.align 2
.LC46:
	.string	"motd"
	.align 2
.LC45:
	.string	"medic"
	.align 2
.LC44:
	.string	"id"
	.align 2
.LC43:
	.string	"autopickup"
	.align 2
.LC42:
	.string	"maplist"
	.align 2
.LC41:
	.string	"ddebug"
	.align 2
.LC40:
	.string	"binds"
	.align 2
.LC39:
	.string	"observer"
	.align 2
.LC38:
	.string	"iwannabeanarchy"
	.align 2
.LC37:
	.string	"aliciamode"
	.align 2
.LC36:
	.string	"shout"
	.align 2
.LC35:
	.string	"scope"
	.align 2
.LC34:
	.string	"reload"
	.align 2
.LC33:
	.string	"list_team"
	.align 2
.LC32:
	.string	"main"
	.align 2
.LC31:
	.string	"team"
	.align 2
.LC30:
	.string	"join_team"
	.align 2
.LC29:
	.string	"class"
	.align 2
.LC28:
	.string	"arty"
	.align 2
.LC27:
	.string	"stance"
	.align 2
.LC26:
	.string	"gameversion"
	.align 2
.LC25:
	.string	"wave"
	.align 2
.LC24:
	.string	"putaway"
	.align 2
.LC23:
	.string	"kill"
	.align 2
.LC22:
	.string	"weapnext"
	.align 2
.LC21:
	.string	"weapprev"
	.align 2
.LC20:
	.string	"invuse"
	.align 2
.LC19:
	.string	"invprev"
	.align 2
.LC18:
	.string	"invnext"
	.align 2
.LC17:
	.string	"inven"
	.align 2
.LC16:
	.string	"scoreboard"
	.align 2
.LC15:
	.string	"help"
	.align 2
.LC14:
	.string	"noclip"
	.align 2
.LC13:
	.string	"notarget"
	.align 2
.LC12:
	.string	"god"
	.align 2
.LC11:
	.string	"give"
	.align 2
.LC10:
	.string	"drop"
	.align 2
.LC9:
	.string	"use"
	.globl frame_output
	.section	".sdata","aw"
	.align 2
	.type	 frame_output,@object
	.size	 frame_output,4
frame_output:
	.long 0
	.section	".rodata"
	.align 2
.LC50:
	.string	"frames"
	.align 2
.LC51:
	.string	"limp"
	.align 2
.LC52:
	.string	"D-DAY DEBUG INFO: %s : %s\n"
	.align 2
.LC53:
	.string	"dday"
	.align 2
.LC54:
	.string	"Jul 24 2002"
	.align 2
.LC55:
	.string	"modelindex =  %i\nmodelindex2 = %i\nmodelindex3 = %i\nmodelindex4 = %i\n"
	.align 2
.LC56:
	.string	"skinnum = %i\n"
	.align 2
.LC57:
	.string	"cur playermodel = %s\ndef playermodel = %s\n"
	.align 2
.LC58:
	.string	"client->aim = %s\n"
	.align 2
.LC59:
	.string	"true"
	.align 2
.LC60:
	.string	"false"
	.align 2
.LC61:
	.string	"limbo mode = %s\n"
	.align 2
.LC62:
	.string	"changeteam = %s\n"
	.align 2
.LC63:
	.string	"teamname = %s\n"
	.align 2
.LC64:
	.string	"class = %s\n"
	.align 2
.LC65:
	.string	"team1->map: %s\nteam2->map: %s\n"
	.align 2
.LC66:
	.string	"waterlevel = %i\n"
	.align 2
.LC67:
	.string	"def speedmod = %f\n"
	.align 2
.LC68:
	.string	" norm weight = %f\n"
	.align 2
.LC69:
	.string	"  cur weight = %f\n"
	.align 2
.LC70:
	.string	"------------   ----------\n"
	.align 2
.LC71:
	.string	"cur speedmod = %f\n"
	.section	".text"
	.align 2
	.globl Cmd_DDebug_f
	.type	 Cmd_DDebug_f,@function
Cmd_DDebug_f:
	blr
.Lfe2:
	.size	 Cmd_DDebug_f,.Lfe2-Cmd_DDebug_f
	.section	".rodata"
	.align 2
.LC72:
	.ascii	"\n\n\n -- DDAY NORMANDY HELPFUL HINTS --\n\nUseful binds:\n "
	.ascii	"arty        -- Call for artillery (officer class only).\n au"
	.ascii	"topickup  -- Toggle if you pickup items.\n binds\t      -- Y"
	.ascii	"ou are here.\n drop ammo   -- Drop ammo for currently select"
	.ascii	"ed weapon.\n drop gun    -- Drop your current weapon ONLY.\n"
	.ascii	" drop weapon -- Drop your current weapon AND all of its ammo"
	.ascii	".\n id          -- Toggle player ID display.\n maplist     -"
	.ascii	"- Display the current maplist.\n medic       -- Call for a m"
	.ascii	"edic.\n motd\t      -- Show MOTD if there is one.\n reload  "
	.ascii	"    -- Reload your current weapon.\n scoreboard  -- Display "
	.ascii	"the scoreboard.\n shout xxx   -- Play xxx.wav "
	.string	"in your team shout directory.\n stance      -- Toggle crouch/crawl/stand\n use weapon  -- Secondary fire-sight mode.\n\n main        == Main  Menu\n team        == Team  Menu\n class       == Class Menu\n\nTo access the dialog again, type \"binds\" in the console.\n\n"
	.align 2
.LC73:
	.string	"%s : %s\n"
	.globl GlobalCommandList
	.section	".sdata","aw"
	.align 2
	.type	 GlobalCommandList,@object
	.size	 GlobalCommandList,4
GlobalCommandList:
	.long 0
	.lcomm	value.36,512,4
	.section	".rodata"
	.align 2
.LC74:
	.string	"skin"
	.align 2
.LC75:
	.string	"You must run the server with '+set cheats 1' to enable this command.\n"
	.align 2
.LC76:
	.string	"all"
	.align 2
.LC77:
	.string	"health"
	.align 2
.LC78:
	.string	"weapons"
	.align 2
.LC79:
	.string	"ammo"
	.align 2
.LC80:
	.string	"unknown item\n"
	.align 2
.LC81:
	.string	"non-pickup item\n"
	.align 2
.LC82:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Give_f
	.type	 Cmd_Give_f,@function
Cmd_Give_f:
	stwu 1,-48(1)
	mflr 0
	mfcr 12
	stmw 26,24(1)
	stw 0,52(1)
	stw 12,20(1)
	lis 9,deathmatch@ha
	lis 10,.LC82@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC82@l(10)
	mr 28,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L94
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L94
	lis 9,gi+8@ha
	lis 5,.LC75@ha
	lwz 0,gi+8@l(9)
	la 5,.LC75@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L93
.L94:
	lis 9,gi@ha
	la 30,gi@l(9)
	lwz 9,164(30)
	mtlr 9
	blrl
	mr 27,3
	lis 4,.LC76@ha
	la 4,.LC76@l(4)
	bl Q_stricmp
	subfic 0,3,0
	adde. 29,0,3
	mfcr 31
	bc 4,2,.L98
	lwz 9,160(30)
	li 3,1
	rlwinm 31,31,16,0xffffffff
	mtcrf 8,31
	rlwinm 31,31,16,0xffffffff
	mtlr 9
	blrl
	lis 4,.LC77@ha
	la 4,.LC77@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L97
.L98:
	lwz 9,156(30)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L99
	lwz 0,160(30)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	stw 3,484(28)
	b .L100
.L99:
	lwz 0,488(28)
	stw 0,484(28)
.L100:
	cmpwi 4,29,0
	bc 12,18,.L93
.L97:
	bc 4,18,.L103
	lis 4,.LC78@ha
	mr 3,27
	la 4,.LC78@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L102
.L103:
	lis 9,game@ha
	li 30,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,30,0
	bc 4,0,.L105
	lis 9,itemlist@ha
	mr 7,11
	la 8,itemlist@l(9)
	li 10,0
.L107:
	mr 31,8
	lwz 0,4(31)
	cmpwi 0,0,0
	bc 12,2,.L106
	lwz 0,56(31)
	andi. 9,0,1
	bc 12,2,.L106
	lwz 11,84(28)
	addi 11,11,740
	lwzx 9,11,10
	addi 9,9,1
	stwx 9,11,10
.L106:
	lwz 0,1556(7)
	addi 30,30,1
	addi 10,10,4
	addi 8,8,104
	cmpw 0,30,0
	bc 12,0,.L107
.L105:
	bc 12,18,.L93
.L102:
	bc 4,18,.L113
	lis 4,.LC79@ha
	mr 3,27
	la 4,.LC79@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L112
.L113:
	lis 9,game@ha
	li 30,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,30,0
	bc 4,0,.L115
	lis 9,itemlist@ha
	mr 26,11
	la 29,itemlist@l(9)
.L117:
	mr 31,29
	lwz 0,4(31)
	cmpwi 0,0,0
	bc 12,2,.L116
	lwz 0,56(31)
	andi. 9,0,2
	bc 12,2,.L116
	mr 4,31
	mr 3,28
	li 5,1000
	bl Add_Ammo
.L116:
	lwz 0,1556(26)
	addi 30,30,1
	addi 29,29,104
	cmpw 0,30,0
	bc 12,0,.L117
.L115:
	bc 12,18,.L93
.L112:
	bc 12,18,.L122
	lis 9,game@ha
	li 30,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,30,0
	bc 4,0,.L93
	lis 9,itemlist@ha
	mr 7,11
	la 11,itemlist@l(9)
	li 8,1
	li 10,0
.L126:
	lwz 0,4(11)
	cmpwi 0,0,0
	bc 12,2,.L125
	lwz 0,56(11)
	andi. 9,0,7
	bc 4,2,.L125
	lwz 9,84(28)
	addi 9,9,740
	stwx 8,9,10
.L125:
	lwz 0,1556(7)
	addi 30,30,1
	addi 10,10,4
	addi 11,11,104
	cmpw 0,30,0
	bc 12,0,.L126
	b .L93
.L122:
	mr 3,27
	bl FindItem
	mr. 31,3
	bc 4,2,.L130
	lis 9,gi@ha
	li 3,1
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	bl FindItem
	mr. 31,3
	bc 4,2,.L130
	lwz 0,4(30)
	lis 3,.LC80@ha
	la 3,.LC80@l(3)
	b .L138
.L130:
	lwz 0,4(31)
	cmpwi 0,0,0
	bc 4,2,.L132
	lis 9,gi+4@ha
	lis 3,.LC81@ha
	lwz 0,gi+4@l(9)
	la 3,.LC81@l(3)
.L138:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L93
.L132:
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,56(31)
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 9,9,31
	andi. 10,11,2
	mullw 9,9,0
	srawi 29,9,3
	bc 12,2,.L133
	lis 9,gi@ha
	la 30,gi@l(9)
	lwz 9,156(30)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L134
	lwz 0,160(30)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(28)
	slwi 0,29,2
	addi 9,9,740
	stwx 3,9,0
	b .L93
.L134:
	lwz 9,84(28)
	slwi 10,29,2
	lwz 11,48(31)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L93
.L133:
	bl G_Spawn
	lwz 0,0(31)
	mr 30,3
	mr 4,31
	stw 0,284(30)
	bl SpawnItem
	mr 4,28
	mr 3,30
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L93
	mr 3,30
	bl G_FreeEdict
.L93:
	lwz 0,52(1)
	lwz 12,20(1)
	mtlr 0
	lmw 26,24(1)
	mtcrf 8,12
	la 1,48(1)
	blr
.Lfe3:
	.size	 Cmd_Give_f,.Lfe3-Cmd_Give_f
	.section	".rodata"
	.align 2
.LC83:
	.string	"godmode OFF\n"
	.align 2
.LC84:
	.string	"godmode ON\n"
	.align 2
.LC85:
	.string	"notarget OFF\n"
	.align 2
.LC86:
	.string	"notarget ON\n"
	.align 2
.LC87:
	.string	"noclip OFF\n"
	.align 2
.LC88:
	.string	"noclip ON\n"
	.align 2
.LC89:
	.string	"Knife"
	.align 2
.LC90:
	.string	"Fists"
	.align 2
.LC91:
	.string	"Helmet"
	.section	".text"
	.align 2
	.globl FindNextPickup
	.type	 FindNextPickup,@function
FindNextPickup:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 30,3
	lis 9,itemlist@ha
	lwz 11,84(30)
	la 9,itemlist@l(9)
	lis 0,0xc4ec
	ori 0,0,20165
	mr 27,4
	lwz 31,1796(11)
	li 28,0
	lis 26,itemlist@ha
	subf 9,9,31
	cmpwi 0,31,0
	mullw 9,9,0
	srawi 29,9,3
	bc 12,2,.L153
.L154:
	srawi 9,28,31
	cmpwi 0,29,255
	xor 0,9,28
	subf 0,0,9
	srawi 0,0,31
	andc 9,31,0
	and 0,28,0
	or 28,0,9
	bc 4,1,.L156
	la 31,itemlist@l(26)
	b .L157
.L156:
	addi 31,31,104
.L157:
	la 9,itemlist@l(26)
	lis 0,0xc4ec
	subf 9,9,31
	ori 0,0,20165
	mullw 9,9,0
	cmpwi 0,31,0
	srawi 29,9,3
	bc 12,2,.L152
	lwz 0,40(31)
	cmpwi 0,0,0
	bc 12,2,.L152
	cmpwi 0,27,0
	bc 12,2,.L176
	lwz 0,68(31)
	cmpw 0,0,27
	b .L177
.L176:
	lwz 11,84(30)
	lwz 10,3448(11)
	lwz 9,3464(11)
	lwz 8,96(10)
	slwi 9,9,2
	lwzx 11,9,8
	lwz 3,8(11)
	bl FindItem
	cmpw 0,31,3
	bc 12,2,.L152
	lwz 11,84(30)
	lwz 10,3448(11)
	lwz 9,3464(11)
	lwz 8,96(10)
	slwi 9,9,2
	lwzx 11,9,8
	lwz 3,16(11)
	bl FindItem
	cmpw 0,31,3
	bc 12,2,.L152
	lwz 11,84(30)
	lwz 10,3448(11)
	lwz 9,3464(11)
	lwz 8,96(10)
	slwi 9,9,2
	lwzx 11,9,8
	lwz 3,24(11)
	bl FindItem
	cmpw 0,31,3
	bc 12,2,.L152
	lwz 11,84(30)
	lwz 10,3448(11)
	lwz 9,3464(11)
	lwz 8,96(10)
	slwi 9,9,2
	lwzx 11,9,8
	lwz 3,32(11)
	bl FindItem
	cmpw 0,31,3
	bc 12,2,.L152
	lis 3,.LC89@ha
	la 3,.LC89@l(3)
	bl FindItem
	cmpw 0,31,3
	bc 12,2,.L152
	lis 3,.LC90@ha
	la 3,.LC90@l(3)
	bl FindItem
	cmpw 0,31,3
	bc 12,2,.L152
	lis 3,.LC91@ha
	la 3,.LC91@l(3)
	bl FindItem
	cmpw 0,31,3
	bc 12,2,.L152
	lwz 0,56(31)
	andi. 9,0,1
	bc 4,2,.L172
	lwz 0,68(31)
	cmpwi 0,0,12
.L177:
	bc 4,2,.L152
.L172:
	lwz 9,84(30)
	slwi 11,29,2
	addi 9,9,740
	lwzx 0,9,11
	cmpwi 0,0,0
	bc 12,2,.L152
	mr 3,31
	b .L175
.L152:
	cmpw 0,31,28
	bc 4,2,.L154
.L153:
	mr 3,28
.L175:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 FindNextPickup,.Lfe4-FindNextPickup
	.section	".rodata"
	.align 2
.LC92:
	.string	"gibmachine"
	.align 2
.LC93:
	.string	"You've got the gib machine!.\n"
	.align 2
.LC94:
	.string	"Goodbye gib machine!.\n"
	.align 2
.LC95:
	.string	"weapon"
	.align 2
.LC96:
	.string	"weapon1"
	.align 2
.LC97:
	.string	"weapon2"
	.align 2
.LC98:
	.string	"special"
	.align 2
.LC99:
	.string	"grenades"
	.align 2
.LC100:
	.string	"melee"
	.align 2
.LC101:
	.string	"pickup"
	.align 2
.LC102:
	.string	"Unknown item: %s\n"
	.align 2
.LC103:
	.string	"Item %s is not usable.\n"
	.align 2
.LC104:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Use_f
	.type	 Cmd_Use_f,@function
Cmd_Use_f:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 29,3
	la 27,gi@l(9)
	lwz 9,164(27)
	mtlr 9
	blrl
	mr 30,3
	bl FindItem
	lwz 9,84(29)
	mr 31,3
	lwz 0,4396(9)
	cmpwi 0,0,0
	bc 4,2,.L178
	lwz 0,496(29)
	cmpwi 0,0,0
	bc 4,2,.L178
	mr 3,29
	bl IsValidPlayer
	cmpwi 0,3,0
	bc 12,2,.L178
	lis 4,.LC92@ha
	mr 3,30
	la 4,.LC92@l(4)
	bl Q_stricmp
	mr. 28,3
	bc 4,2,.L182
	lis 9,.LC104@ha
	lis 11,easter_egg@ha
	la 9,.LC104@l(9)
	lfs 13,0(9)
	lwz 9,easter_egg@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L178
	lwz 9,84(29)
	lwz 0,4388(9)
	cmpwi 0,0,0
	bc 4,2,.L184
	lwz 0,8(27)
	lis 5,.LC93@ha
	mr 3,29
	la 5,.LC93@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(29)
	li 0,1
	stw 0,4388(9)
	b .L178
.L184:
	lwz 0,8(27)
	lis 5,.LC94@ha
	mr 3,29
	la 5,.LC94@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(29)
	stw 28,4388(9)
	b .L178
.L182:
	cmpwi 0,31,0
	bc 4,2,.L186
	lis 4,.LC95@ha
	mr 3,30
	la 4,.LC95@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L187
	lwz 9,84(29)
	mr 10,9
	lwz 9,1796(9)
	cmpwi 0,9,0
	bc 12,2,.L178
	lwz 0,68(9)
	cmpwi 0,0,12
	bc 12,2,.L178
	cmpwi 0,0,13
	bc 12,2,.L178
	cmpwi 0,0,10
	bc 4,2,.L191
	lwz 9,4496(10)
	cmpwi 0,9,0
	bc 12,2,.L191
	lwz 0,0(9)
	cmpwi 0,0,0
	bc 12,2,.L178
.L191:
	lwz 9,4192(10)
	addi 9,9,-5
	cmplwi 0,9,1
	bc 4,1,.L192
	lwz 8,4392(10)
	cmpwi 0,8,0
	bc 12,2,.L193
	li 0,0
	li 11,7
	stw 0,4392(10)
	lwz 9,84(29)
	stw 11,4192(9)
	b .L192
.L193:
	li 0,1
	li 11,6
	stw 0,4392(10)
	lwz 9,84(29)
	stw 11,4192(9)
	lwz 11,84(29)
	lwz 9,1796(11)
	lwz 0,68(9)
	cmpwi 0,0,10
	bc 4,2,.L192
	stw 8,3460(11)
.L192:
	mr 3,29
	bl WeighPlayer
	b .L178
.L187:
	lis 4,.LC96@ha
	mr 3,30
	la 4,.LC96@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L197
	lwz 11,84(29)
	lwz 10,3448(11)
	lwz 9,3464(11)
	lwz 8,96(10)
	slwi 9,9,2
	lwzx 11,9,8
	lwz 3,8(11)
	bl FindItem
	mr. 31,3
	bc 12,2,.L206
	lwz 11,84(29)
	mr 3,30
	lwz 10,3448(11)
	lwz 9,3464(11)
	lwz 8,96(10)
	slwi 9,9,2
	lwzx 11,9,8
	lwz 4,8(11)
	bl strcpy
	b .L186
.L197:
	lis 4,.LC97@ha
	mr 3,30
	la 4,.LC97@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L201
	lwz 11,84(29)
	lwz 10,3448(11)
	lwz 9,3464(11)
	lwz 8,96(10)
	slwi 9,9,2
	lwzx 11,9,8
	lwz 3,16(11)
	bl FindItem
	mr. 31,3
	bc 12,2,.L206
	lwz 11,84(29)
	mr 3,30
	lwz 10,3448(11)
	lwz 9,3464(11)
	lwz 8,96(10)
	slwi 9,9,2
	lwzx 11,9,8
	lwz 4,16(11)
	bl strcpy
	b .L186
.L201:
	lis 4,.LC98@ha
	mr 3,30
	la 4,.LC98@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L205
	lwz 11,84(29)
	lwz 10,3448(11)
	lwz 9,3464(11)
	lwz 8,96(10)
	slwi 9,9,2
	lwzx 11,9,8
	lwz 3,32(11)
	bl FindItem
	mr. 31,3
	bc 12,2,.L206
	lwz 11,84(29)
	mr 3,30
	lwz 10,3448(11)
	lwz 9,3464(11)
	lwz 8,96(10)
	slwi 9,9,2
	lwzx 11,9,8
	lwz 4,32(11)
	bl strcpy
	b .L186
.L206:
	lwz 9,84(29)
	lwz 31,1796(9)
	b .L186
.L205:
	lis 4,.LC99@ha
	mr 3,30
	la 4,.LC99@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	li 4,12
	bc 12,2,.L217
	lis 4,.LC100@ha
	mr 3,30
	la 4,.LC100@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L211
	li 4,1
.L217:
	mr 3,29
	bl FindNextPickup
	mr 31,3
	lwz 4,40(31)
	mr 3,30
	bl strcpy
	b .L186
.L211:
	lis 4,.LC101@ha
	mr 3,30
	la 4,.LC101@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L213
	lwz 0,8(27)
	lis 5,.LC102@ha
	mr 3,29
	la 5,.LC102@l(5)
	mr 6,30
	b .L218
.L213:
	li 4,0
	mr 3,29
	bl FindNextPickup
	mr 31,3
	lwz 4,40(31)
	mr 3,30
	bl strcpy
.L186:
	lwz 10,8(31)
	cmpwi 0,10,0
	bc 4,2,.L215
	lis 9,gi+8@ha
	lis 5,.LC103@ha
	lwz 6,40(31)
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC103@l(5)
.L218:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L178
.L215:
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 9,9,31
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L178
	mr 3,29
	mr 4,31
	mtlr 10
	blrl
.L178:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Cmd_Use_f,.Lfe5-Cmd_Use_f
	.section	".rodata"
	.align 2
.LC105:
	.string	"gun"
	.align 2
.LC106:
	.string	"weapon_fists"
	.align 2
.LC107:
	.string	"GerbilsAreTheGreatestInTheWorld"
	.align 2
.LC108:
	.string	"***NOTICE*** Species loves Gerbil Pr0n\n"
	.align 2
.LC109:
	.string	"unknown item: %s\n"
	.align 2
.LC110:
	.string	"Item is not dropable.\n"
	.align 2
.LC111:
	.string	"Out of item: %s\n"
	.align 2
.LC112:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Drop_f
	.type	 Cmd_Drop_f,@function
Cmd_Drop_f:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4396(9)
	cmpwi 0,0,0
	bc 4,2,.L219
	lwz 0,496(31)
	cmpwi 0,0,2
	bc 12,2,.L219
	lwz 0,3448(9)
	cmpwi 0,0,0
	bc 12,2,.L219
	lwz 0,3464(9)
	cmpwi 0,0,0
	bc 12,2,.L219
	lwz 0,4356(9)
	cmpwi 0,0,0
	bc 4,2,.L219
	lwz 0,4360(9)
	cmpwi 0,0,0
	bc 4,2,.L219
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	bl FindItem
	mr 30,3
	lis 4,.LC105@ha
	la 4,.LC105@l(4)
	mr 3,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L225
	lwz 9,84(31)
	addic 0,30,-1
	subfe 11,0,30
	lwz 9,1796(9)
	addic 10,9,-1
	subfe 0,10,9
	and. 10,0,11
	bc 12,2,.L224
	cmpw 0,9,30
	bc 4,2,.L224
.L225:
	lwz 11,84(31)
	lis 9,itemlist@ha
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
	lwz 30,1796(11)
	subf 9,9,30
	cmpwi 0,30,0
	mullw 9,9,0
	srawi 0,9,3
	bc 12,2,.L219
	slwi 0,0,2
	addi 9,11,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 12,2,.L219
	lwz 3,0(30)
	lis 4,.LC106@ha
	la 4,.LC106@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L219
	lwz 11,84(31)
	lwz 9,1796(11)
	lwz 0,68(9)
	cmpwi 0,0,8
	bc 12,2,.L219
	cmpwi 0,0,11
	bc 12,2,.L219
	cmpwi 0,0,13
	bc 12,2,.L219
	lwz 8,4356(11)
	cmpwi 0,8,0
	bc 4,2,.L219
	lwz 0,12(30)
	cmpwi 0,0,0
	bc 12,2,.L219
	lwz 0,4132(11)
	li 10,1
	mr 3,31
	ori 0,0,1
	stw 0,4132(11)
	lwz 9,84(31)
	stw 8,4192(9)
	lwz 11,84(31)
	stw 10,4720(11)
	b .L258
.L224:
	lis 4,.LC79@ha
	mr 3,29
	la 4,.LC79@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L228
	lwz 9,84(31)
	lwz 9,1796(9)
	cmpwi 0,9,0
	bc 12,2,.L219
	lwz 0,68(9)
	cmpwi 0,0,1
	bc 12,2,.L219
	cmpwi 0,0,13
	bc 12,2,.L219
	cmpwi 0,0,8
	bc 12,2,.L219
	lwz 3,52(9)
	bl FindItem
	lis 9,itemlist@ha
	mr 30,3
	lwz 11,84(31)
	la 28,itemlist@l(9)
	lis 0,0xc4ec
	ori 0,0,20165
	subf 9,28,30
	mullw 9,9,0
	addi 11,11,740
	srawi 9,9,3
	slwi 29,9,2
	lwzx 0,11,29
	cmpwi 0,0,0
	bc 12,2,.L219
	lwz 0,12(30)
	cmpwi 0,0,0
	bc 12,2,.L219
	mr 3,31
	mr 4,30
	bl Drop_Item
	li 0,1
	lwz 9,664(3)
	stw 0,536(3)
	lwz 0,48(30)
	stw 0,48(9)
	lwz 11,84(31)
	addi 11,11,740
	lwzx 9,11,29
	addi 9,9,-1
	stwx 9,11,29
	lwz 7,84(31)
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L259
	lwz 0,3548(7)
	cmpwi 0,0,0
	bc 12,2,.L235
	mr 3,31
	bl PMenu_Next
	b .L259
.L256:
	stw 11,736(7)
	b .L259
.L235:
	li 0,256
	mr 5,11
	mtctr 0
	mr 6,10
	mr 4,28
	li 8,1
.L257:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L241
	mulli 0,11,104
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L241
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L256
.L241:
	addi 8,8,1
	bdnz .L257
	li 0,-1
	stw 0,736(7)
	b .L259
.L228:
	lis 4,.LC95@ha
	mr 3,29
	la 4,.LC95@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L245
	lwz 11,84(31)
	lis 9,itemlist@ha
	lis 28,0xc4ec
	la 26,itemlist@l(9)
	ori 28,28,20165
	lwz 30,1796(11)
	subf 0,26,30
	cmpwi 0,30,0
	mullw 0,0,28
	srawi 0,0,3
	bc 12,2,.L219
	slwi 0,0,2
	addi 9,11,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 12,2,.L219
	lwz 3,0(30)
	lis 4,.LC106@ha
	la 4,.LC106@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L219
	lwz 11,84(31)
	lwz 9,1796(11)
	lwz 0,68(9)
	cmpwi 0,0,8
	bc 12,2,.L219
	cmpwi 0,0,11
	bc 12,2,.L219
	cmpwi 0,0,13
	bc 12,2,.L219
	lwz 27,4356(11)
	cmpwi 0,27,0
	bc 4,2,.L219
	lwz 0,12(30)
	cmpwi 0,0,0
	bc 12,2,.L219
	lwz 0,4132(11)
	ori 0,0,1
	stw 0,4132(11)
	lwz 9,84(31)
	stw 27,4192(9)
	lwz 3,52(30)
	cmpwi 0,3,0
	bc 12,2,.L248
	lwz 0,68(30)
	cmpwi 0,0,0
	bc 12,2,.L248
	cmpwi 0,0,1
	bc 12,2,.L248
	cmpwi 0,0,12
	bc 12,2,.L248
	cmpwi 0,0,13
	bc 12,2,.L248
	cmpwi 0,0,8
	bc 12,2,.L248
	bl FindItem
	mr 29,3
	lwz 9,84(31)
	subf 0,26,29
	mullw 0,0,28
	addi 9,9,740
	srawi 0,0,3
	slwi 28,0,2
	lwzx 11,9,28
	cmpwi 0,11,0
	bc 12,2,.L248
	lwz 0,12(29)
	cmpwi 0,0,0
	bc 12,2,.L219
	mr 3,31
	mr 4,29
	bl Drop_Item
	lwz 9,84(31)
	lwz 10,664(3)
	addi 9,9,740
	lwzx 0,9,28
	stw 0,536(3)
	lwz 11,48(29)
	stw 11,48(10)
	lwz 9,84(31)
	addi 9,9,740
	stwx 27,9,28
.L248:
	lwz 9,84(31)
	li 0,1
	mr 3,31
	stw 0,4720(9)
.L258:
	bl Cmd_WeapNext_f
	lwz 0,12(30)
	mr 3,31
	mr 4,30
	mtlr 0
	blrl
.L259:
	mr 3,31
	bl WeighPlayer
	b .L219
.L245:
	lis 4,.LC107@ha
	mr 3,29
	la 4,.LC107@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L251
	lis 9,.LC112@ha
	lis 11,easter_egg@ha
	la 9,.LC112@l(9)
	lfs 13,0(9)
	lwz 9,easter_egg@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L219
	lis 9,gi@ha
	lis 4,.LC108@ha
	lwz 0,gi@l(9)
	la 4,.LC108@l(4)
	li 3,3
	mtlr 0
	crxor 6,6,6
	blrl
	b .L219
.L251:
	cmpwi 0,30,0
	bc 4,2,.L253
	lis 9,gi+8@ha
	lis 5,.LC109@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC109@l(5)
	b .L260
.L253:
	lwz 10,12(30)
	cmpwi 0,10,0
	bc 4,2,.L254
	lis 9,gi+8@ha
	lis 5,.LC110@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC110@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L219
.L254:
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 9,9,30
	addi 11,11,740
	mullw 9,9,0
	srawi 0,9,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L255
	lis 9,gi+8@ha
	lis 5,.LC111@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC111@l(5)
.L260:
	mr 6,29
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L219
.L255:
	mr 3,31
	mr 4,30
	mtlr 10
	blrl
	mr 3,31
	bl WeighPlayer
.L219:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 Cmd_Drop_f,.Lfe6-Cmd_Drop_f
	.section	".rodata"
	.align 2
.LC113:
	.string	"No item to use.\n"
	.align 2
.LC114:
	.string	"Item is not usable.\n"
	.section	".text"
	.align 2
	.globl Cmd_InvUse_f
	.type	 Cmd_InvUse_f,@function
Cmd_InvUse_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 7,84(3)
	lwz 0,3548(7)
	cmpwi 0,0,0
	bc 12,2,.L270
	bl PMenu_Select
	b .L269
.L285:
	stw 11,736(7)
	b .L272
.L270:
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L272
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L286:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L279
	mulli 0,11,104
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L279
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L285
.L279:
	addi 8,8,1
	bdnz .L286
	li 0,-1
	stw 0,736(7)
.L272:
	lwz 9,84(3)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L283
	lis 9,gi+8@ha
	lis 5,.LC113@ha
	lwz 0,gi+8@l(9)
	la 5,.LC113@l(5)
	b .L287
.L283:
	mulli 0,0,104
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L284
	lis 9,gi+8@ha
	lis 5,.LC114@ha
	lwz 0,gi+8@l(9)
	la 5,.LC114@l(5)
.L287:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L269
.L284:
	mtlr 0
	blrl
.L269:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 Cmd_InvUse_f,.Lfe7-Cmd_InvUse_f
	.align 2
	.globl Cmd_WeapNext_f
	.type	 Cmd_WeapNext_f,@function
Cmd_WeapNext_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 27,3
	lwz 28,84(27)
	lwz 0,4396(28)
	cmpwi 0,0,0
	bc 4,2,.L300
	lwz 0,496(27)
	cmpwi 0,0,0
	bc 4,2,.L300
	lwz 11,1796(28)
	lis 0,0x42aa
	stw 0,112(28)
	cmpwi 0,11,0
	bc 12,2,.L303
	lis 9,itemlist@ha
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 9,9,11
	mullw 9,9,0
	srawi 3,9,3
	b .L304
.L303:
	lis 3,.LC89@ha
	la 3,.LC89@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 3,9,3
	mullw 3,3,0
	srawi 3,3,3
.L304:
	lis 9,itemlist@ha
	addi 30,3,255
	la 25,itemlist@l(9)
	li 29,1
	addi 26,28,740
.L308:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L307
	mulli 0,11,104
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L307
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L307
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1796(28)
	cmpw 0,0,31
	bc 12,2,.L300
.L307:
	addi 29,29,1
	addi 30,30,-1
	cmpwi 0,29,256
	bc 4,1,.L308
.L300:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 Cmd_WeapNext_f,.Lfe8-Cmd_WeapNext_f
	.section	".rodata"
	.align 2
.LC115:
	.string	"No item to drop.\n"
	.section	".text"
	.align 2
	.globl Cmd_InvDrop_f
	.type	 Cmd_InvDrop_f,@function
Cmd_InvDrop_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3548(9)
	cmpwi 0,0,0
	bc 12,2,.L322
	bl PMenu_Close
.L322:
	lwz 7,84(31)
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L324
	lwz 0,3548(7)
	cmpwi 0,0,0
	bc 12,2,.L325
	mr 3,31
	bl PMenu_Next
	b .L324
.L338:
	stw 11,736(7)
	b .L324
.L325:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L339:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L331
	mulli 0,11,104
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L331
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L338
.L331:
	addi 8,8,1
	bdnz .L339
	li 0,-1
	stw 0,736(7)
.L324:
	lwz 9,84(31)
	lwz 0,4396(9)
	cmpwi 0,0,0
	bc 4,2,.L321
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L336
	lis 9,gi+8@ha
	lis 5,.LC115@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC115@l(5)
	b .L340
.L336:
	mulli 0,0,104
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L337
	lis 9,gi+8@ha
	lis 5,.LC110@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC110@l(5)
.L340:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L321
.L337:
	mr 3,31
	mtlr 0
	blrl
	mr 3,31
	bl WeighPlayer
.L321:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 Cmd_InvDrop_f,.Lfe9-Cmd_InvDrop_f
	.section	".rodata"
	.align 2
.LC116:
	.string	"Kill who? ME? HAHAHAHAhahaha....\n"
	.align 2
.LC117:
	.string	"%3i %s\n"
	.align 2
.LC118:
	.string	"...\n"
	.align 2
.LC119:
	.string	"%s\n%i players\n"
	.align 2
.LC120:
	.long 0x0
	.align 3
.LC121:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_Players_f
	.type	 Cmd_Players_f,@function
Cmd_Players_f:
	stwu 1,-2432(1)
	mflr 0
	stmw 23,2396(1)
	stw 0,2436(1)
	lis 11,.LC120@ha
	lis 9,maxclients@ha
	la 11,.LC120@l(11)
	mr 23,3
	lfs 13,0(11)
	li 27,0
	li 31,0
	lwz 11,maxclients@l(9)
	addi 29,1,1352
	addi 30,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L348
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC121@ha
	la 9,.LC121@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L350:
	lwz 0,0(11)
	addi 11,11,4732
	cmpwi 0,0,0
	bc 12,2,.L349
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L349:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L350
.L348:
	lis 6,PlayerSort@ha
	mr 3,29
	la 6,PlayerSort@l(6)
	mr 4,27
	li 5,4
	li 31,0
	bl qsort
	cmpw 0,31,27
	li 0,0
	stb 0,72(1)
	bc 4,0,.L354
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC117@ha
	lis 25,.LC118@ha
.L356:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC117@l(26)
	addi 28,28,4
	mulli 7,7,4732
	add 7,7,0
	lha 6,148(7)
	addi 7,7,700
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,30
	bl strlen
	add 29,29,3
	cmplwi 0,29,1180
	bc 4,1,.L357
	la 4,.LC118@l(25)
	mr 3,30
	bl strcat
	b .L354
.L357:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L356
.L354:
	lis 9,gi+8@ha
	lis 5,.LC119@ha
	lwz 0,gi+8@l(9)
	mr 3,23
	la 5,.LC119@l(5)
	mr 6,30
	mr 7,27
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,2436(1)
	mtlr 0
	lmw 23,2396(1)
	la 1,2432(1)
	blr
.Lfe10:
	.size	 Cmd_Players_f,.Lfe10-Cmd_Players_f
	.section	".rodata"
	.align 2
.LC122:
	.string	"flipoff\n"
	.align 2
.LC123:
	.string	"salute\n"
	.align 2
.LC124:
	.string	"taunt\n"
	.align 2
.LC125:
	.string	"wave\n"
	.align 2
.LC126:
	.string	"point\n"
	.section	".text"
	.align 2
	.globl Cmd_Wave_f
	.type	 Cmd_Wave_f,@function
Cmd_Wave_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,gi+160@ha
	mr 31,3
	lwz 0,gi+160@l(9)
	li 3,1
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 11,0,1
	bc 4,2,.L359
	lwz 0,4328(9)
	cmpwi 0,0,1
	bc 12,1,.L359
	cmplwi 0,3,4
	li 0,1
	stw 0,4328(9)
	bc 12,1,.L368
	lis 11,.L369@ha
	slwi 10,3,2
	la 11,.L369@l(11)
	lis 9,.L369@ha
	lwzx 0,10,11
	la 9,.L369@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L369:
	.long .L363-.L369
	.long .L364-.L369
	.long .L365-.L369
	.long .L366-.L369
	.long .L368-.L369
.L363:
	lis 9,gi+8@ha
	lis 5,.LC122@ha
	lwz 0,gi+8@l(9)
	la 5,.LC122@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,71
	li 9,83
	b .L370
.L364:
	lis 9,gi+8@ha
	lis 5,.LC123@ha
	lwz 0,gi+8@l(9)
	la 5,.LC123@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,83
	li 9,94
	b .L370
.L365:
	lis 9,gi+8@ha
	lis 5,.LC124@ha
	lwz 0,gi+8@l(9)
	la 5,.LC124@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,94
	li 9,111
	b .L370
.L366:
	lis 9,gi+8@ha
	lis 5,.LC125@ha
	lwz 0,gi+8@l(9)
	la 5,.LC125@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,111
	li 9,122
	b .L370
.L368:
	lis 9,gi+8@ha
	lis 5,.LC126@ha
	lwz 0,gi+8@l(9)
	la 5,.LC126@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,122
	li 9,134
.L370:
	stw 0,56(31)
	stw 9,4324(11)
.L359:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 Cmd_Wave_f,.Lfe11-Cmd_Wave_f
	.section	".rodata"
	.align 2
.LC127:
	.string	"(Team)%s: "
	.align 2
.LC128:
	.string	"%s: "
	.align 2
.LC129:
	.string	"\n"
	.align 2
.LC130:
	.string	"You can't talk for %d more seconds\n"
	.align 2
.LC131:
	.string	"Flood protection:  You can't talk for %d seconds.\n"
	.align 2
.LC132:
	.string	"You aren't on a team!\n"
	.align 2
.LC133:
	.string	"%s"
	.align 2
.LC134:
	.long 0x0
	.align 3
.LC135:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC136:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Cmd_Say_f
	.type	 Cmd_Say_f,@function
Cmd_Say_f:
	stwu 1,-2112(1)
	mflr 0
	stmw 25,2084(1)
	stw 0,2116(1)
	lis 9,gi+156@ha
	mr 30,3
	lwz 0,gi+156@l(9)
	mr 31,4
	mr 29,5
	mtlr 0
	blrl
	cmpwi 0,3,1
	bc 12,1,.L372
	cmpwi 0,29,0
	bc 12,2,.L371
.L372:
	cmpwi 0,31,0
	mfcr 31
	bc 12,2,.L373
	lwz 6,84(30)
	lis 5,.LC127@ha
	addi 3,1,8
	la 5,.LC127@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L374
.L373:
	lwz 6,84(30)
	lis 5,.LC128@ha
	addi 3,1,8
	la 5,.LC128@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L374:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L375
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	li 0,0
	stb 0,-1(3)
.L375:
	mr 4,29
	addi 3,1,8
	bl strcat
	mtcrf 128,31
	bc 4,2,.L376
	addi 3,1,8
	bl strlen
	lwz 9,84(30)
	mr 29,3
	addi 3,9,700
	bl strlen
	subf 29,3,29
	cmpwi 0,29,2
	b .L407
.L376:
	addi 3,1,8
	bl strlen
	lwz 9,84(30)
	mr 29,3
	addi 3,9,700
	bl strlen
	subf 29,3,29
	cmpwi 0,29,8
.L407:
	bc 12,2,.L371
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L380
	li 0,0
	stb 0,158(1)
.L380:
	lis 4,.LC129@ha
	addi 3,1,8
	la 4,.LC129@l(4)
	bl strcat
	lis 9,.LC134@ha
	la 9,.LC134@l(9)
	lfs 8,0(9)
	lis 9,flood_msgs@ha
	lwz 11,flood_msgs@l(9)
	lfs 9,20(11)
	fcmpu 0,9,8
	bc 12,2,.L381
	lwz 7,84(30)
	lis 9,level+4@ha
	lfs 10,level+4@l(9)
	lfs 0,4560(7)
	fcmpu 0,10,0
	bc 4,0,.L382
	fsubs 0,0,10
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC130@ha
	mr 3,30
	la 5,.LC130@l(5)
	li 4,2
	mtlr 0
	fctiwz 13,0
	stfd 13,2072(1)
	b .L408
.L382:
	lwz 0,4604(7)
	lis 10,0x4330
	lis 11,.LC135@ha
	addi 8,7,4564
	mr 6,0
	la 11,.LC135@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,2076(1)
	lis 11,.LC136@ha
	stw 10,2072(1)
	la 11,.LC136@l(11)
	lfd 0,2072(1)
	mr 10,8
	lfs 11,0(11)
	mr 11,9
	fsub 0,0,13
	frsp 0,0
	fsubs 0,0,9
	fadds 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,2072(1)
	lwz 11,2076(1)
	nor 0,11,11
	addi 9,11,10
	srawi 0,0,31
	andc 9,9,0
	and 11,11,0
	or 11,11,9
	slwi 11,11,2
	lfsx 0,8,11
	fcmpu 0,0,8
	bc 12,2,.L384
	lis 11,flood_persecond@ha
	fsubs 13,10,0
	lwz 9,flood_persecond@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L384
	lis 9,flood_waitdelay@ha
	lis 10,gi+8@ha
	lwz 11,flood_waitdelay@l(9)
	lis 5,.LC131@ha
	mr 3,30
	la 5,.LC131@l(5)
	lfs 13,20(11)
	li 4,3
	fadds 13,10,13
	stfs 13,4560(7)
	lfs 0,20(11)
	lwz 0,gi+8@l(10)
	mtlr 0
	fctiwz 12,0
	stfd 12,2072(1)
.L408:
	lwz 6,2076(1)
	crxor 6,6,6
	blrl
	b .L371
.L384:
	lis 0,0xcccc
	addi 9,6,1
	ori 0,0,52429
	lis 11,level+4@ha
	mulhwu 0,9,0
	srwi 0,0,3
	mulli 0,0,10
	subf 9,0,9
	stw 9,4604(7)
	lfs 0,level+4@l(11)
	slwi 9,9,2
	stfsx 0,10,9
.L381:
	mtcrf 128,31
	bc 12,2,.L385
	lwz 9,84(30)
	lwz 0,3448(9)
	cmpwi 0,0,0
	bc 12,2,.L387
	lwz 0,3464(9)
	cmpwi 0,0,0
	bc 4,2,.L386
.L387:
	lis 9,gi+8@ha
	lis 5,.LC132@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC132@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L371
.L386:
	lwz 0,496(30)
	cmpwi 0,0,0
	bc 4,2,.L371
	lwz 0,4396(9)
	cmpwi 0,0,0
	bc 4,2,.L371
	lis 9,game@ha
	li 29,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,29,0
	bc 12,1,.L371
	lis 9,gi@ha
	mr 25,11
	la 26,gi@l(9)
	lis 27,g_edicts@ha
	lis 28,.LC133@ha
	li 31,1016
.L393:
	lwz 0,g_edicts@l(27)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L392
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L392
	lwz 11,3448(9)
	cmpwi 0,11,0
	bc 12,2,.L392
	lwz 0,3464(9)
	cmpwi 0,0,0
	bc 12,2,.L392
	lwz 9,84(30)
	lwz 0,3448(9)
	cmpw 0,11,0
	bc 4,2,.L392
	lwz 9,8(26)
	li 4,3
	la 5,.LC133@l(28)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L392:
	lwz 0,1544(25)
	addi 29,29,1
	addi 31,31,1016
	cmpw 0,29,0
	bc 4,1,.L393
	b .L371
.L385:
	lis 9,.LC134@ha
	lis 11,dedicated@ha
	la 9,.LC134@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L399
	lis 9,gi+8@ha
	lis 5,.LC133@ha
	lwz 0,gi+8@l(9)
	la 5,.LC133@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L399:
	lis 9,game@ha
	li 29,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,29,0
	bc 12,1,.L371
	lis 9,gi@ha
	mr 26,11
	la 27,gi@l(9)
	lis 28,g_edicts@ha
	lis 30,.LC133@ha
	li 31,1016
.L403:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L402
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L402
	lwz 9,8(27)
	li 4,3
	la 5,.LC133@l(30)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L402:
	lwz 0,1544(26)
	addi 29,29,1
	addi 31,31,1016
	cmpw 0,29,0
	bc 4,1,.L403
.L371:
	lwz 0,2116(1)
	mtlr 0
	lmw 25,2084(1)
	la 1,2112(1)
	blr
.Lfe12:
	.size	 Cmd_Say_f,.Lfe12-Cmd_Say_f
	.section	".rodata"
	.align 2
.LC137:
	.long 0x0
	.long 0x0
	.long 0x41800000
	.align 2
.LC138:
	.string	"There is a soldier on top of you!\nYou can not get up!\n"
	.align 2
.LC139:
	.string	"misc/prone2.wav"
	.align 2
.LC140:
	.long 0x3ecccccd
	.align 2
.LC141:
	.long 0x3f800000
	.align 2
.LC142:
	.long 0x0
	.section	".text"
	.align 2
	.globl change_stance
	.type	 change_stance,@function
change_stance:
	stwu 1,-128(1)
	mflr 0
	stmw 29,116(1)
	stw 0,132(1)
	mr 31,3
	lis 9,.LC137@ha
	lwz 7,672(31)
	la 11,.LC137@l(9)
	mr 30,4
	lwz 8,.LC137@l(9)
	addi 10,1,24
	lwz 9,8(11)
	cmpw 0,7,30
	lwz 0,4(11)
	stw 8,24(1)
	stw 9,8(10)
	stw 0,4(10)
	bc 12,2,.L409
	lwz 9,84(31)
	lis 11,gi@ha
	lwz 0,4396(9)
	cmpwi 0,0,0
	bc 4,2,.L411
	lwz 0,496(31)
	cmpwi 0,0,0
	bc 4,2,.L411
	cmpwi 0,7,1
	bc 12,2,.L411
	lfs 10,4(31)
	la 29,gi@l(11)
	lis 9,0x201
	lfs 11,8(31)
	ori 9,9,3
	addi 3,1,40
	lfs 0,12(31)
	addi 4,31,4
	addi 5,31,188
	lfs 9,24(1)
	addi 6,31,200
	addi 7,1,8
	lfs 13,28(1)
	mr 8,31
	lfs 12,32(1)
	lwz 11,48(29)
	fadds 10,10,9
	fadds 11,11,13
	fadds 0,0,12
	mtlr 11
	stfs 10,8(1)
	stfs 11,12(1)
	stfs 0,16(1)
	blrl
	lwz 9,92(1)
	cmpwi 0,9,0
	bc 12,2,.L411
	cmpw 0,9,31
	bc 12,2,.L411
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L411
	lwz 0,12(29)
	lis 4,.LC138@ha
	mr 3,31
	la 4,.LC138@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L409
.L411:
	cmpwi 0,30,2
	bc 4,2,.L414
	li 0,-2
	li 9,16
	b .L419
.L414:
	cmpwi 0,30,4
	bc 4,2,.L416
	lwz 0,620(31)
	li 9,-14
	li 11,-8
	stw 9,684(31)
	cmpwi 0,0,0
	stw 11,676(31)
	bc 4,2,.L415
	lis 29,gi@ha
	lis 3,.LC139@ha
	la 29,gi@l(29)
	la 3,.LC139@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC140@ha
	lwz 0,16(29)
	mr 5,3
	lfs 1,.LC140@l(9)
	mr 3,31
	li 4,4
	lis 9,.LC141@ha
	mtlr 0
	la 9,.LC141@l(9)
	lfs 2,0(9)
	lis 9,.LC142@ha
	la 9,.LC142@l(9)
	lfs 3,0(9)
	blrl
	b .L415
.L416:
	li 0,22
	li 9,32
.L419:
	stw 0,684(31)
	stw 9,676(31)
.L415:
	stw 30,672(31)
	mr 3,31
	bl WeighPlayer
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L409:
	lwz 0,132(1)
	mtlr 0
	lmw 29,116(1)
	la 1,128(1)
	blr
.Lfe13:
	.size	 change_stance,.Lfe13-change_stance
	.section	".rodata"
	.align 2
.LC143:
	.string	"\n\n"
	.align 2
.LC144:
	.string	"Team: %s\n"
	.align 2
.LC145:
	.string	"    %s\n"
	.section	".text"
	.align 2
	.globl Cmd_List_team
	.type	 Cmd_List_team,@function
Cmd_List_team:
	stwu 1,-64(1)
	mflr 0
	stmw 18,8(1)
	stw 0,68(1)
	lis 9,gi@ha
	mr 29,3
	la 9,gi@l(9)
	lis 5,.LC143@ha
	lwz 0,8(9)
	la 5,.LC143@l(5)
	li 4,2
	mr 22,9
	mtlr 0
	lis 18,.LC144@ha
	lis 19,team_list@ha
	lis 20,gi@ha
	crxor 6,6,6
	blrl
	lis 9,team_list@ha
	li 11,0
	la 21,team_list@l(9)
.L424:
	slwi 0,11,2
	addi 24,11,1
	lwzx 6,21,0
	mr 28,0
	cmpwi 0,6,0
	bc 12,2,.L423
	lwz 9,8(22)
	mr 3,29
	li 4,2
	lwz 6,0(6)
	la 5,.LC144@l(18)
	lis 23,.LC129@ha
	mtlr 9
	la 25,team_list@l(19)
	la 26,gi@l(20)
	lis 27,.LC145@ha
	li 30,0
	li 31,16
	crxor 6,6,6
	blrl
.L429:
	lwzx 9,28,25
	addi 9,9,8
	lwzx 9,9,30
	addi 30,30,4
	cmpwi 0,9,0
	bc 12,2,.L428
	lwz 9,84(9)
	mr 3,29
	li 4,2
	la 5,.LC145@l(27)
	cmpwi 0,9,0
	addi 6,9,700
	bc 12,2,.L428
	lwz 9,8(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L428:
	addic. 31,31,-1
	bc 4,2,.L429
	lwz 9,8(22)
	la 5,.LC129@l(23)
	mr 3,29
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L423:
	mr 11,24
	cmpwi 0,11,1
	bc 4,1,.L424
	lwz 0,68(1)
	mtlr 0
	lmw 18,8(1)
	la 1,64(1)
	blr
.Lfe14:
	.size	 Cmd_List_team,.Lfe14-Cmd_List_team
	.section	".rodata"
	.align 2
.LC146:
	.string	"%s already loaded!\n"
	.align 2
.LC147:
	.string	"You can't top off the %s!\n"
	.align 2
.LC148:
	.string	"You still have a full magazine left!\n"
	.align 2
.LC149:
	.string	"Last Rocket!\n"
	.align 2
.LC150:
	.string	"Last Clip!\n"
	.align 2
.LC151:
	.string	"Last Fuel Tank!\n"
	.align 2
.LC152:
	.string	"Last Magazine!\n"
	.align 2
.LC153:
	.string	"You're out of ammo!\n"
	.section	".text"
	.align 2
	.globl Cmd_Reload_f
	.type	 Cmd_Reload_f,@function
Cmd_Reload_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr. 31,3
	bc 12,2,.L454
	lwz 10,84(31)
	cmpwi 0,10,0
	bc 12,2,.L454
	lwz 3,1796(10)
	cmpwi 0,3,0
	bc 12,2,.L454
	lwz 9,4128(10)
	cmpwi 0,9,0
	bc 12,2,.L454
	lwz 0,4496(10)
	cmpwi 0,0,0
	bc 12,2,.L454
	slwi 0,9,2
	addi 9,10,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 12,2,.L454
	lwz 0,4396(10)
	cmpwi 0,0,0
	bc 4,2,.L454
	lwz 0,496(31)
	cmpwi 0,0,2
	bc 12,2,.L454
	lwz 3,52(3)
	cmpwi 0,3,0
	bc 12,2,.L436
	bl FindItem
	lis 9,itemlist@ha
	mr 30,3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	lis 0,0xc4ec
	subf 9,9,30
	ori 0,0,20165
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	addi 9,9,740
	add 28,11,9
.L436:
	lwz 9,84(31)
	lwz 11,1796(9)
	lwz 0,72(11)
	cmpwi 0,0,0
	bc 12,2,.L454
	cmpwi 0,0,3
	bc 4,2,.L438
	lwz 9,4496(9)
	cmpwi 0,9,0
	bc 12,2,.L438
	lwz 0,0(9)
	cmpwi 0,0,0
	bc 12,2,.L438
	lwz 0,68(11)
	cmpwi 0,0,9
	bc 4,2,.L439
	lis 9,gi+8@ha
	lis 5,.LC146@ha
	lwz 6,40(11)
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC146@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L454
.L439:
	lis 9,gi+8@ha
	lis 5,.LC147@ha
	lwz 6,40(11)
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC147@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L454
.L438:
	lwz 29,84(31)
	lwz 9,1796(29)
	lwz 3,52(9)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	lwzx 29,29,3
	lwz 0,0(28)
	cmpwi 0,0,0
	bc 12,2,.L442
	lwz 11,84(31)
	lwz 10,48(30)
	lwz 9,4496(11)
	lwz 0,0(9)
	cmpw 0,0,10
	bc 4,2,.L442
	lis 9,gi+8@ha
	lis 5,.LC148@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC148@l(5)
	li 4,2
	b .L455
.L442:
	mr 3,31
	bl WeighPlayer
	cmpwi 0,29,0
	bc 12,2,.L443
	lwz 10,84(31)
	xori 0,29,1
	subfic 8,0,0
	adde 0,8,0
	lwz 9,4192(10)
	xori 9,9,4
	addic 8,9,-1
	subfe 11,8,9
	and. 11,11,0
	bc 12,2,.L444
	lwz 9,1796(10)
	lwz 0,68(9)
	cmpwi 0,0,9
	bc 4,2,.L445
	lis 9,gi+8@ha
	lis 5,.LC149@ha
	lwz 0,gi+8@l(9)
	la 5,.LC149@l(5)
	b .L456
.L445:
	cmpwi 0,0,3
	bc 4,2,.L447
	lis 9,gi+8@ha
	lis 5,.LC150@ha
	lwz 0,gi+8@l(9)
	la 5,.LC150@l(5)
	b .L456
.L447:
	cmpwi 0,0,11
	bc 4,2,.L449
	lis 9,gi+8@ha
	lis 5,.LC151@ha
	lwz 0,gi+8@l(9)
	la 5,.LC151@l(5)
.L456:
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L446
.L449:
	lis 9,gi+8@ha
	lis 5,.LC152@ha
	lwz 0,gi+8@l(9)
	la 5,.LC152@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L446:
	lwz 11,84(31)
	li 0,5
	li 10,0
	mr 3,31
	stw 0,4192(11)
	lwz 9,84(31)
	stw 10,4392(9)
	b .L457
.L444:
	li 0,5
	mr 3,31
	stw 0,4192(10)
	lwz 9,84(31)
	stw 11,4392(9)
.L457:
	bl WeighPlayer
	li 3,1
	b .L453
.L443:
	lwz 9,84(31)
	lis 11,gi+8@ha
	lis 5,.LC153@ha
	mr 3,31
	la 5,.LC153@l(5)
	stw 29,4192(9)
	li 4,2
	lwz 0,gi+8@l(11)
.L455:
	mtlr 0
	crxor 6,6,6
	blrl
.L454:
	li 3,0
.L453:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 Cmd_Reload_f,.Lfe15-Cmd_Reload_f
	.section	".rodata"
	.align 2
.LC155:
	.string	"Usage: shout wavefile (no \".wav\")\n"
	.align 2
.LC156:
	.string	"Filename must be less than %i characters long.\n"
	.align 2
.LC157:
	.string	".wav"
	.string	""
	.align 2
.LC158:
	.string	"%s/shout/"
	.align 2
.LC159:
	.long 0x3f800000
	.align 2
.LC160:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Shout_f
	.type	 Cmd_Shout_f,@function
Cmd_Shout_f:
	stwu 1,-128(1)
	mflr 0
	stmw 29,116(1)
	stw 0,132(1)
	mr 30,3
	lwz 9,84(30)
	lwz 0,3448(9)
	cmpwi 0,0,0
	bc 12,2,.L469
	lwz 0,3464(9)
	cmpwi 0,0,0
	bc 12,2,.L469
	lwz 0,496(30)
	cmpwi 0,0,2
	bc 12,2,.L469
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,1,.L472
	lwz 0,8(31)
	lis 5,.LC155@ha
	mr 3,30
	la 5,.LC155@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L469
.L472:
	lwz 9,160(31)
	li 3,1
	mtlr 9
	blrl
	bl strlen
	cmplwi 0,3,14
	bc 4,1,.L473
	lwz 0,8(31)
	lis 5,.LC156@ha
	mr 3,30
	la 5,.LC156@l(5)
	li 4,2
	li 6,14
	mtlr 0
	crxor 6,6,6
	blrl
	b .L469
.L473:
	lwz 9,160(31)
	li 3,1
	addi 29,1,40
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcpy
	lis 4,.LC157@ha
	addi 3,1,8
	la 4,.LC157@l(4)
	bl strcat
	lwz 9,84(30)
	lis 3,.LC158@ha
	la 3,.LC158@l(3)
	lwz 4,3448(9)
	addi 4,4,100
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl strcpy
	addi 4,1,8
	mr 3,29
	bl strcat
	lwz 9,36(31)
	mr 3,29
	mtlr 9
	blrl
	lis 9,.LC159@ha
	lwz 0,16(31)
	mr 5,3
	la 9,.LC159@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC159@ha
	la 9,.LC159@l(9)
	lfs 2,0(9)
	lis 9,.LC160@ha
	la 9,.LC160@l(9)
	lfs 3,0(9)
	blrl
.L469:
	lwz 0,132(1)
	mtlr 0
	lmw 29,116(1)
	la 1,128(1)
	blr
.Lfe16:
	.size	 Cmd_Shout_f,.Lfe16-Cmd_Shout_f
	.section	".rodata"
	.align 2
.LC161:
	.string	"Invulnerable medics can't pick up weapons!\n"
	.align 2
.LC162:
	.string	"Auto Item pickup enabled.\n"
	.align 2
.LC163:
	.string	"Auto Item pickup disabled.\n"
	.align 2
.LC164:
	.string	"player id enabled\n"
	.align 2
.LC165:
	.string	"player id disabled\n"
	.align 2
.LC166:
	.string	"dday/motd.txt"
	.align 2
.LC167:
	.string	"r"
	.align 2
.LC168:
	.string	"processing %s commands\n"
	.align 2
.LC169:
	.string	"printing <%s> commands:\n"
	.align 2
.LC170:
	.string	"%s has %d args.\n"
	.align 2
.LC171:
	.string	"%i\n"
	.section	".text"
	.align 2
	.globl FindCommand
	.type	 FindCommand,@function
FindCommand:
	stwu 1,-96(1)
	mflr 0
	mfcr 12
	stmw 28,80(1)
	stw 0,100(1)
	stw 12,76(1)
	li 0,0
	mr 28,3
	stb 0,8(1)
	mr 11,28
	li 10,0
	lbz 0,0(28)
	li 29,0
	cmpwi 0,0,0
	bc 12,2,.L514
	addi 8,1,8
.L515:
	lbz 0,0(11)
	cmpwi 0,0,46
	bc 4,2,.L517
	li 10,1
	b .L513
.L517:
	stbx 0,8,29
	addi 11,11,1
	addi 29,29,1
.L513:
	lbz 0,0(11)
	cmpwi 7,29,31
	neg 0,0
	srwi 0,0,31
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and. 7,0,9
	bc 12,2,.L514
	cmpwi 0,10,0
	bc 12,2,.L515
.L514:
	cmpwi 3,10,0
	bc 12,14,.L520
	li 0,0
	addi 9,1,8
	stbx 0,9,29
	addi 28,11,1
	b .L521
.L538:
	mr 3,30
	b .L536
.L520:
	stb 10,8(1)
.L521:
	lis 9,GlobalCommandList@ha
	lwz 31,GlobalCommandList@l(9)
	cmpwi 0,31,0
	bc 12,2,.L523
.L524:
	bc 12,14,.L525
	addi 3,1,8
	mr 4,31
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L528
.L525:
	lwz 0,52(31)
	li 29,0
	lwz 3,48(31)
	cmpw 0,29,0
	bc 4,0,.L528
	cmpwi 4,28,0
	mr 30,3
.L530:
	bc 12,18,.L523
	lwz 4,0(30)
	cmpwi 0,4,0
	bc 12,2,.L523
	mr 3,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L538
	lwz 0,52(31)
	addi 29,29,1
	addi 30,30,12
	cmpw 0,29,0
	bc 12,0,.L530
.L528:
	lwz 31,44(31)
	cmpwi 0,31,0
	bc 4,2,.L524
.L523:
	li 3,0
.L536:
	lwz 0,100(1)
	lwz 12,76(1)
	mtlr 0
	lmw 28,80(1)
	mtcrf 24,12
	la 1,96(1)
	blr
.Lfe17:
	.size	 FindCommand,.Lfe17-FindCommand
	.section	".rodata"
	.align 2
.LC172:
	.string	"say"
	.align 2
.LC173:
	.string	"say_team"
	.align 2
.LC174:
	.string	"Invalid Command: %s!\n"
	.section	".text"
	.align 2
	.globl ClientCommand
	.type	 ClientCommand,@function
ClientCommand:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L539
	lis 9,gi@ha
	li 3,0
	la 28,gi@l(9)
	lwz 9,160(28)
	mtlr 9
	blrl
	mr 29,3
	lis 4,.LC172@ha
	la 4,.LC172@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L541
	mr 3,31
	li 4,0
	b .L554
.L541:
	lis 4,.LC173@ha
	mr 3,29
	la 4,.LC173@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L542
	mr 3,31
	li 4,1
.L554:
	li 5,0
	bl Cmd_Say_f
	b .L539
.L542:
	mr 3,29
	bl FindCommand
	mr. 30,3
	bc 12,2,.L544
	lwz 10,4(30)
	cmplwi 0,10,4
	bc 12,1,.L539
	lis 11,.L551@ha
	slwi 10,10,2
	la 11,.L551@l(11)
	lis 9,.L551@ha
	lwzx 0,10,11
	la 9,.L551@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L551:
	.long .L546-.L551
	.long .L547-.L551
	.long .L548-.L551
	.long .L549-.L551
	.long .L550-.L551
.L546:
	lwz 0,8(30)
	mtlr 0
	blrl
	b .L539
.L547:
	lwz 0,8(30)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
	b .L539
.L548:
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	lwz 0,8(30)
	mr 4,3
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
	b .L539
.L549:
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	lwz 0,160(29)
	mr 28,3
	li 3,2
	mtlr 0
	blrl
	lwz 0,8(30)
	mr 5,3
	mr 4,28
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
	b .L539
.L550:
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	lwz 9,160(29)
	mr 27,3
	li 3,2
	mtlr 9
	blrl
	lwz 0,160(29)
	mr 28,3
	li 3,3
	mtlr 0
	blrl
	lwz 0,8(30)
	mr 6,3
	mr 4,27
	mr 3,31
	mr 5,28
	mtlr 0
	crxor 6,6,6
	blrl
	b .L539
.L544:
	lwz 0,8(28)
	lis 5,.LC174@ha
	mr 3,31
	la 5,.LC174@l(5)
	mr 6,29
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L539:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 ClientCommand,.Lfe18-ClientCommand
	.comm	is_silenced,1,1
	.align 2
	.globl ValidateSelectedItem
	.type	 ValidateSelectedItem,@function
ValidateSelectedItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 7,84(3)
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L81
	lwz 0,3548(7)
	cmpwi 0,0,0
	bc 12,2,.L83
	bl PMenu_Next
	b .L81
.L555:
	stw 11,736(7)
	b .L81
.L83:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L556:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L89
	mulli 0,11,104
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L89
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L555
.L89:
	addi 8,8,1
	bdnz .L556
	li 0,-1
	stw 0,736(7)
.L81:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 ValidateSelectedItem,.Lfe19-ValidateSelectedItem
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.align 2
	.globl InsertCmds
	.type	 InsertCmds,@function
InsertCmds:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,gi+4@ha
	mr 28,3
	lwz 0,gi+4@l(9)
	mr 30,5
	mr 27,4
	lis 3,.LC168@ha
	mr 4,30
	mtlr 0
	la 3,.LC168@l(3)
	crxor 6,6,6
	blrl
	lis 9,GlobalCommandList@ha
	lwz 0,GlobalCommandList@l(9)
	la 31,GlobalCommandList@l(9)
	cmpwi 0,0,0
	bc 12,2,.L494
.L495:
	lwz 9,0(31)
	lwz 0,44(9)
	addi 31,9,44
	cmpwi 0,0,0
	bc 4,2,.L495
.L494:
	lis 9,gi+132@ha
	li 4,765
	lwz 0,gi+132@l(9)
	li 3,56
	mtlr 0
	blrl
	mr 29,3
	mr 4,30
	stw 28,48(29)
	li 5,32
	stw 27,52(29)
	bl strncpy
	li 0,0
	stw 0,44(29)
	stw 29,0(31)
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 InsertCmds,.Lfe20-InsertCmds
	.align 2
	.globl CleanUpCmds
	.type	 CleanUpCmds,@function
CleanUpCmds:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,GlobalCommandList@ha
	lwz 29,GlobalCommandList@l(9)
	cmpwi 0,29,0
	bc 12,2,.L509
	lis 9,gi@ha
	la 31,gi@l(9)
.L510:
	lwz 9,136(31)
	mr 3,29
	lwz 29,44(29)
	mtlr 9
	blrl
	mr. 29,29
	bc 4,2,.L510
.L509:
	lis 9,GlobalCommandList@ha
	li 0,0
	stw 0,GlobalCommandList@l(9)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 CleanUpCmds,.Lfe21-CleanUpCmds
	.align 2
	.globl PrintCmds
	.type	 PrintCmds,@function
PrintCmds:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 9,GlobalCommandList@ha
	lwz 30,GlobalCommandList@l(9)
	cmpwi 0,30,0
	bc 12,2,.L499
	lis 9,gi@ha
	lis 25,.LC169@ha
	la 24,gi@l(9)
	lis 26,gi@ha
.L500:
	lwz 9,4(24)
	la 3,.LC169@l(25)
	mr 4,30
	li 29,0
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,52(30)
	lwz 31,48(30)
	cmpw 0,29,0
	bc 4,0,.L502
	la 27,gi@l(26)
	lis 28,.LC170@ha
.L504:
	lwz 9,4(27)
	la 3,.LC170@l(28)
	addi 29,29,1
	lwz 4,0(31)
	lwz 5,4(31)
	mtlr 9
	addi 31,31,12
	crxor 6,6,6
	blrl
	lwz 0,52(30)
	cmpw 0,29,0
	bc 12,0,.L504
.L502:
	lwz 30,44(30)
	cmpwi 0,30,0
	bc 4,2,.L500
.L499:
	lis 9,gi+4@ha
	lis 11,game+1556@ha
	lwz 0,gi+4@l(9)
	lis 3,.LC171@ha
	la 3,.LC171@l(3)
	lwz 4,game+1556@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe22:
	.size	 PrintCmds,.Lfe22-PrintCmds
	.align 2
	.globl Cmd_GameVersion_f
	.type	 Cmd_GameVersion_f,@function
Cmd_GameVersion_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+8@ha
	lis 5,.LC73@ha
	lwz 0,gi+8@l(9)
	lis 6,.LC53@ha
	lis 7,.LC54@ha
	la 5,.LC73@l(5)
	la 6,.LC53@l(6)
	la 7,.LC54@l(7)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 Cmd_GameVersion_f,.Lfe23-Cmd_GameVersion_f
	.align 2
	.globl SelectNextItem
	.type	 SelectNextItem,@function
SelectNextItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 8,84(3)
	lwz 0,3548(8)
	cmpwi 0,0,0
	bc 12,2,.L62
	bl PMenu_Next
	b .L61
.L557:
	stw 11,736(8)
	b .L61
.L62:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 3,itemlist@l(9)
	addi 6,8,740
.L558:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L65
	mulli 0,11,104
	add 10,0,3
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L65
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L557
.L65:
	addi 7,7,1
	bdnz .L558
	li 0,-1
	stw 0,736(8)
.L61:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 SelectNextItem,.Lfe24-SelectNextItem
	.align 2
	.globl SelectPrevItem
	.type	 SelectPrevItem,@function
SelectPrevItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 7,84(3)
	lwz 0,3548(7)
	cmpwi 0,0,0
	bc 12,2,.L72
	bl PMenu_Prev
	b .L71
.L559:
	stw 8,736(7)
	b .L71
.L72:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L560:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L75
	mulli 0,8,104
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L75
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L559
.L75:
	addi 11,11,-1
	bdnz .L560
	li 0,-1
	stw 0,736(7)
.L71:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe25:
	.size	 SelectPrevItem,.Lfe25-SelectPrevItem
	.section	".rodata"
	.align 2
.LC175:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC175@ha
	lis 9,deathmatch@ha
	la 11,.LC175@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L140
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L140
	lis 9,gi+8@ha
	lis 5,.LC75@ha
	lwz 0,gi+8@l(9)
	la 5,.LC75@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L139
.L140:
	lwz 0,268(3)
	xori 0,0,16
	andi. 9,0,16
	stw 0,268(3)
	bc 4,2,.L141
	lis 9,.LC83@ha
	la 5,.LC83@l(9)
	b .L142
.L141:
	lis 9,.LC84@ha
	la 5,.LC84@l(9)
.L142:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L139:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe26:
	.size	 Cmd_God_f,.Lfe26-Cmd_God_f
	.section	".rodata"
	.align 2
.LC176:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC176@ha
	lis 9,deathmatch@ha
	la 11,.LC176@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L144
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L144
	lis 9,gi+8@ha
	lis 5,.LC75@ha
	lwz 0,gi+8@l(9)
	la 5,.LC75@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L143
.L144:
	lwz 0,268(3)
	xori 0,0,32
	andi. 9,0,32
	stw 0,268(3)
	bc 4,2,.L145
	lis 9,.LC85@ha
	la 5,.LC85@l(9)
	b .L146
.L145:
	lis 9,.LC86@ha
	la 5,.LC86@l(9)
.L146:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L143:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe27:
	.size	 Cmd_Notarget_f,.Lfe27-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC177:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC177@ha
	lis 9,deathmatch@ha
	la 11,.LC177@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L148
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L148
	lis 9,gi+8@ha
	lis 5,.LC75@ha
	lwz 0,gi+8@l(9)
	la 5,.LC75@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L147
.L148:
	lwz 0,264(3)
	cmpwi 0,0,1
	bc 4,2,.L149
	li 0,4
	lis 9,.LC87@ha
	stw 0,264(3)
	la 5,.LC87@l(9)
	b .L150
.L149:
	li 0,1
	lis 9,.LC88@ha
	stw 0,264(3)
	la 5,.LC88@l(9)
.L150:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L147:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 Cmd_Noclip_f,.Lfe28-Cmd_Noclip_f
	.align 2
	.globl Cmd_Inven_f
	.type	 Cmd_Inven_f,@function
Cmd_Inven_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	li 0,0
	lwz 31,84(30)
	stw 0,3536(31)
	stw 0,3524(31)
	lwz 9,84(30)
	lwz 9,3548(9)
	cmpwi 0,9,0
	bc 12,2,.L262
	bl PMenu_Close
	b .L261
.L262:
	lwz 0,3528(31)
	cmpwi 0,0,0
	bc 12,2,.L263
	stw 9,3528(31)
	b .L261
.L263:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3528(31)
	li 3,5
	lwz 0,100(9)
	addi 29,31,1760
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L267:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,29
	bc 4,1,.L267
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L261:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 Cmd_Inven_f,.Lfe29-Cmd_Inven_f
	.align 2
	.globl Cmd_WeapPrev_f
	.type	 Cmd_WeapPrev_f,@function
Cmd_WeapPrev_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 28,3
	lis 0,0x42aa
	lwz 29,84(28)
	lwz 11,1796(29)
	stw 0,112(29)
	cmpwi 0,11,0
	bc 12,2,.L288
	lwz 0,4396(29)
	cmpwi 0,0,0
	bc 4,2,.L288
	lis 9,itemlist@ha
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,29,740
	mullw 9,9,0
	srawi 27,9,3
.L294:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L293
	mulli 0,11,104
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L293
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L293
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1796(29)
	cmpw 0,0,31
	bc 12,2,.L288
.L293:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L294
.L288:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe30:
	.size	 Cmd_WeapPrev_f,.Lfe30-Cmd_WeapPrev_f
	.align 2
	.globl Cmd_Kill_f
	.type	 Cmd_Kill_f,@function
Cmd_Kill_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+8@ha
	lis 5,.LC116@ha
	lwz 0,gi+8@l(9)
	la 5,.LC116@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 Cmd_Kill_f,.Lfe31-Cmd_Kill_f
	.align 2
	.globl Cmd_PutAway_f
	.type	 Cmd_PutAway_f,@function
Cmd_PutAway_f:
	lwz 9,84(3)
	li 0,0
	stw 0,3524(9)
	lwz 11,84(3)
	stw 0,3536(11)
	lwz 9,84(3)
	stw 0,3528(9)
	blr
.Lfe32:
	.size	 Cmd_PutAway_f,.Lfe32-Cmd_PutAway_f
	.section	".rodata"
	.align 3
.LC178:
	.long 0x3fd33333
	.long 0x33333333
	.section	".text"
	.align 2
	.globl Cmd_Stance
	.type	 Cmd_Stance,@function
Cmd_Stance:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3472(9)
	cmpwi 0,0,0
	bc 12,2,.L458
	lwz 0,496(31)
	cmpwi 0,0,0
	bc 4,2,.L458
	lwz 0,620(31)
	cmpwi 0,0,1
	bc 12,1,.L458
	lwz 0,4396(9)
	cmpwi 0,0,0
	bc 12,2,.L462
	lis 9,level+4@ha
	lis 11,.LC178@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC178@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,936(31)
	b .L463
.L462:
	lwz 0,672(31)
	cmpwi 0,0,1
	bc 4,2,.L464
	mr 3,31
	li 4,2
	bl change_stance
	b .L463
.L464:
	cmpwi 0,0,2
	bc 4,2,.L466
	mr 3,31
	li 4,4
	bl change_stance
	b .L463
.L466:
	cmpwi 0,0,4
	bc 4,2,.L463
	mr 3,31
	li 4,1
	bl change_stance
.L463:
	mr 3,31
	bl WeighPlayer
.L458:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe33:
	.size	 Cmd_Stance,.Lfe33-Cmd_Stance
	.align 2
	.globl Cmd_DDHelp_f
	.type	 Cmd_DDHelp_f,@function
Cmd_DDHelp_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+8@ha
	lis 5,.LC72@ha
	lwz 0,gi+8@l(9)
	la 5,.LC72@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 Cmd_DDHelp_f,.Lfe34-Cmd_DDHelp_f
	.section	".rodata"
	.align 2
.LC179:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Cmd_AutoPickUp_f
	.type	 Cmd_AutoPickUp_f,@function
Cmd_AutoPickUp_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3472(9)
	cmpwi 0,0,0
	bc 12,2,.L474
	lwz 0,3464(9)
	cmpwi 0,0,8
	bc 4,2,.L476
	lis 9,.LC179@ha
	lis 11,invuln_medic@ha
	la 9,.LC179@l(9)
	lfs 13,0(9)
	lwz 9,invuln_medic@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L476
	lis 9,gi+8@ha
	lis 5,.LC161@ha
	lwz 0,gi+8@l(9)
	la 5,.LC161@l(5)
	b .L561
.L476:
	lwz 9,84(31)
	lwz 0,3476(9)
	cmpwi 0,0,0
	bc 4,2,.L477
	lis 9,gi+8@ha
	lis 5,.LC162@ha
	lwz 0,gi+8@l(9)
	la 5,.LC162@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,1
	b .L562
.L477:
	lis 9,gi+8@ha
	lis 5,.LC163@ha
	lwz 0,gi+8@l(9)
	la 5,.LC163@l(5)
	mr 3,31
.L561:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,0
.L562:
	stw 0,3476(9)
.L474:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe35:
	.size	 Cmd_AutoPickUp_f,.Lfe35-Cmd_AutoPickUp_f
	.align 2
	.globl Cmd_Menu_Main_f
	.type	 Cmd_Menu_Main_f,@function
Cmd_Menu_Main_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,4524(9)
	cmpwi 0,0,0
	bc 4,2,.L26
	lis 10,level_wait@ha
	lwz 8,level_wait@l(10)
	lis 9,level@ha
	lwz 0,level@l(9)
	lfs 0,20(8)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	mulli 11,11,10
	cmpw 0,0,11
	bc 4,1,.L26
	bl MainMenu
.L26:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe36:
	.size	 Cmd_Menu_Main_f,.Lfe36-Cmd_Menu_Main_f
	.align 2
	.globl Cmd_Menu_Team_f
	.type	 Cmd_Menu_Team_f,@function
Cmd_Menu_Team_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,4524(9)
	cmpwi 0,0,0
	bc 4,2,.L28
	lis 10,level_wait@ha
	lwz 8,level_wait@l(10)
	lis 9,level@ha
	lwz 0,level@l(9)
	lfs 0,20(8)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	mulli 11,11,10
	cmpw 0,0,11
	bc 4,1,.L28
	bl ChooseTeam
.L28:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 Cmd_Menu_Team_f,.Lfe37-Cmd_Menu_Team_f
	.align 2
	.globl Cmd_Menu_Class_f
	.type	 Cmd_Menu_Class_f,@function
Cmd_Menu_Class_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,4524(9)
	cmpwi 0,0,0
	bc 4,2,.L30
	lis 10,level_wait@ha
	lwz 8,level_wait@l(10)
	lis 9,level@ha
	lwz 0,level@l(9)
	lfs 0,20(8)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	mulli 11,11,10
	cmpw 0,0,11
	bc 4,1,.L30
	bl M_ChooseMOS
.L30:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe38:
	.size	 Cmd_Menu_Class_f,.Lfe38-Cmd_Menu_Class_f
	.align 2
	.globl Cmd_PlayerID_f
	.type	 Cmd_PlayerID_f,@function
Cmd_PlayerID_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3472(9)
	cmpwi 0,0,0
	bc 12,2,.L479
	lwz 0,3480(9)
	cmpwi 0,0,0
	bc 4,2,.L481
	lis 9,gi+8@ha
	lis 5,.LC164@ha
	lwz 0,gi+8@l(9)
	la 5,.LC164@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,1
	b .L563
.L481:
	lis 9,gi+8@ha
	lis 5,.LC165@ha
	lwz 0,gi+8@l(9)
	la 5,.LC165@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,0
.L563:
	stw 0,3480(9)
.L479:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe39:
	.size	 Cmd_PlayerID_f,.Lfe39-Cmd_PlayerID_f
	.section	".rodata"
	.align 3
.LC180:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_Medic_Call_f
	.type	 Cmd_Medic_Call_f,@function
Cmd_Medic_Call_f:
	stwu 1,-16(1)
	lis 11,level@ha
	lwz 10,84(3)
	lwz 11,level@l(11)
	lis 8,0x4330
	lis 7,.LC180@ha
	la 7,.LC180@l(7)
	lfs 13,4552(10)
	xoris 0,11,0x8000
	lfd 12,0(7)
	stw 0,12(1)
	stw 8,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,0,.L484
	addi 0,11,30
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 8,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	stfs 0,4552(10)
.L484:
	la 1,16(1)
	blr
.Lfe40:
	.size	 Cmd_Medic_Call_f,.Lfe40-Cmd_Medic_Call_f
	.align 2
	.globl Cmd_MOTD
	.type	 Cmd_MOTD,@function
Cmd_MOTD:
	stwu 1,-1152(1)
	mflr 0
	stmw 29,1140(1)
	stw 0,1156(1)
	mr 29,3
	lis 4,.LC167@ha
	lis 3,.LC166@ha
	la 4,.LC167@l(4)
	la 3,.LC166@l(3)
	bl fopen
	mr. 30,3
	bc 12,2,.L486
	addi 3,1,8
	li 4,900
	mr 5,30
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L487
	addi 31,1,1016
	b .L488
.L490:
	addi 3,1,8
	mr 4,31
	bl strcat
.L488:
	mr 3,31
	li 4,100
	mr 5,30
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L490
	lis 9,gi+12@ha
	mr 3,29
	lwz 0,gi+12@l(9)
	addi 4,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L487:
	mr 3,30
	bl fclose
.L486:
	lwz 0,1156(1)
	mtlr 0
	lmw 29,1140(1)
	la 1,1152(1)
	blr
.Lfe41:
	.size	 Cmd_MOTD,.Lfe41-Cmd_MOTD
	.align 2
	.globl Cmd_Scope_f
	.type	 Cmd_Scope_f,@function
Cmd_Scope_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lwz 9,1796(11)
	cmpwi 0,9,0
	bc 12,2,.L49
	lwz 0,68(9)
	cmpwi 0,0,12
	bc 12,2,.L49
	cmpwi 0,0,13
	bc 12,2,.L49
	cmpwi 0,0,10
	bc 4,2,.L52
	lwz 9,4496(11)
	cmpwi 0,9,0
	bc 12,2,.L52
	lwz 0,0(9)
	cmpwi 0,0,0
	bc 12,2,.L49
.L52:
	lwz 10,84(3)
	lwz 9,4192(10)
	addi 9,9,-5
	cmplwi 0,9,1
	bc 4,1,.L53
	lwz 8,4392(10)
	cmpwi 0,8,0
	bc 12,2,.L54
	li 0,0
	li 11,7
	stw 0,4392(10)
	lwz 9,84(3)
	stw 11,4192(9)
	b .L53
.L54:
	li 0,1
	li 11,6
	stw 0,4392(10)
	lwz 9,84(3)
	stw 11,4192(9)
	lwz 11,84(3)
	lwz 9,1796(11)
	lwz 0,68(9)
	cmpwi 0,0,10
	bc 4,2,.L53
	stw 8,3460(11)
.L53:
	bl WeighPlayer
.L49:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe42:
	.size	 Cmd_Scope_f,.Lfe42-Cmd_Scope_f
	.section	".rodata"
	.align 2
.LC181:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_AliciaMode_f
	.type	 Cmd_AliciaMode_f,@function
Cmd_AliciaMode_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,.LC181@ha
	lis 11,easter_egg@ha
	la 9,.LC181@l(9)
	lfs 13,0(9)
	lwz 9,easter_egg@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L14
	lis 9,game@ha
	li 30,0
	la 8,game@l(9)
	lis 11,GlobalAliciaModeVariable@ha
	lwz 10,1548(8)
	li 0,1
	lis 9,g_edicts@ha
	stw 0,GlobalAliciaModeVariable@l(11)
	cmpw 0,30,10
	lwz 31,g_edicts@l(9)
	bc 4,0,.L14
	mr 28,8
	lis 29,.LC6@ha
.L19:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L18
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L18
	mr 3,31
	la 4,.LC6@l(29)
	bl stuffcmd
.L18:
	lwz 0,1548(28)
	addi 30,30,1
	addi 31,31,1016
	cmpw 0,30,0
	bc 12,0,.L19
.L14:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe43:
	.size	 Cmd_AliciaMode_f,.Lfe43-Cmd_AliciaMode_f
	.section	".rodata"
	.align 2
.LC182:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_SexPistols_f
	.type	 Cmd_SexPistols_f,@function
Cmd_SexPistols_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC182@ha
	lis 9,easter_egg@ha
	la 11,.LC182@l(11)
	lfs 13,0(11)
	lwz 11,easter_egg@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L22
	lwz 0,1000(3)
	subfic 9,0,0
	adde 0,9,0
	cmpwi 0,0,0
	stw 0,1000(3)
	bc 12,2,.L22
	lis 9,gi+8@ha
	lis 5,.LC7@ha
	lwz 0,gi+8@l(9)
	lis 6,.LC8@ha
	la 5,.LC7@l(5)
	la 6,.LC8@l(6)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L22:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe44:
	.size	 Cmd_SexPistols_f,.Lfe44-Cmd_SexPistols_f
	.align 2
	.globl ClientTeam
	.type	 ClientTeam,@function
ClientTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 9,value.36@ha
	li 30,0
	stb 30,value.36@l(9)
	la 31,value.36@l(9)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L565
	lis 4,.LC74@ha
	addi 3,3,188
	la 4,.LC74@l(4)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L565
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L60
	addi 3,3,1
	b .L564
.L60:
	stb 30,0(3)
.L565:
	mr 3,31
.L564:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe45:
	.size	 ClientTeam,.Lfe45-ClientTeam
	.align 2
	.globl Cmd_WeapLast_f
	.type	 Cmd_WeapLast_f,@function
Cmd_WeapLast_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 10,84(3)
	lis 9,0x42aa
	lwz 0,1796(10)
	stw 9,112(10)
	cmpwi 0,0,0
	bc 12,2,.L314
	lwz 8,1800(10)
	cmpwi 0,8,0
	bc 12,2,.L314
	lwz 0,4396(10)
	cmpwi 0,0,0
	bc 4,2,.L314
	lis 11,itemlist@ha
	lis 9,0xc4ec
	la 4,itemlist@l(11)
	ori 9,9,20165
	subf 0,4,8
	addi 11,10,740
	mullw 0,0,9
	srawi 10,0,3
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L314
	mulli 0,10,104
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L314
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L314
	mtlr 9
	blrl
.L314:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe46:
	.size	 Cmd_WeapLast_f,.Lfe46-Cmd_WeapLast_f
	.align 2
	.globl PlayerSort
	.type	 PlayerSort,@function
PlayerSort:
	lwz 9,0(3)
	lis 11,game+1028@ha
	lwz 3,0(4)
	lwz 0,game+1028@l(11)
	mulli 9,9,4732
	mulli 11,3,4732
	add 9,9,0
	add 11,11,0
	lha 9,148(9)
	lha 3,148(11)
	cmpw 0,9,3
	li 3,-1
	bclr 12,0
	mfcr 3
	rlwinm 3,3,2,1
	blr
.Lfe47:
	.size	 PlayerSort,.Lfe47-PlayerSort
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
