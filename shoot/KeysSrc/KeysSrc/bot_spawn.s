	.file	"bot_spawn.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.section	".rodata"
	.align 2
.LC2:
	.string	"Route-table not found!\n"
	.align 2
.LC3:
	.string	"No client spots available!\n"
	.align 2
.LC4:
	.string	"player"
	.align 3
.LC5:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC6:
	.long 0x3f19999a
	.align 2
.LC7:
	.long 0x0
	.align 2
.LC8:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl G_SpawnBot
	.type	 G_SpawnBot,@function
G_SpawnBot:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 11,.LC7@ha
	lis 9,deathmatch@ha
	la 11,.LC7@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L29
	lis 9,bot_calc_nodes@ha
	lwz 11,bot_calc_nodes@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L18
	lis 9,loaded_trail_flag@ha
	lwz 0,loaded_trail_flag@l(9)
	cmpwi 0,0,0
	bc 4,2,.L18
	lis 4,.LC2@ha
	li 3,2
	la 4,.LC2@l(4)
	crxor 6,6,6
	bl my_bprintf
	b .L29
.L18:
	lis 11,maxclients@ha
	lwz 10,maxclients@l(11)
	lis 9,level+4@ha
	lfs 12,level+4@l(9)
	lis 11,last_bot_spawn@ha
	lfs 0,20(10)
	stfs 12,last_bot_spawn@l(11)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 10,12(1)
	cmpwi 0,10,0
	bc 4,1,.L24
	lis 9,g_edicts@ha
	mulli 8,10,1352
	lwz 7,g_edicts@l(9)
	add 11,7,8
	addi 6,11,1352
	lwz 0,88(6)
	cmpwi 0,0,0
	bc 12,2,.L24
	addi 0,8,1352
	addi 9,8,1440
	add 11,0,7
	add 9,9,7
.L22:
	addic. 10,10,-1
	addi 11,11,-1352
	bc 4,1,.L24
	lwzu 0,-1352(9)
	mr 6,11
	cmpwi 0,0,0
	bc 4,2,.L22
.L24:
	lwz 0,88(6)
	addic 0,0,-1
	subfe 0,0,0
	and. 31,6,0
	bc 12,2,.L27
	lis 9,gi+132@ha
	li 4,765
	lwz 0,gi+132@l(9)
	li 3,32
	mtlr 0
	blrl
	lis 9,.LC4@ha
	lis 11,bot_pain@ha
	stw 3,1068(31)
	la 9,.LC4@l(9)
	lis 10,bot_die@ha
	stw 9,280(31)
	la 11,bot_pain@l(11)
	la 10,bot_die@l(10)
	lis 9,.LC8@ha
	li 0,4
	stw 11,452(31)
	la 9,.LC8@l(9)
	stw 10,456(31)
	lis 7,bot_run@ha
	lfs 12,0(9)
	li 8,0
	la 7,bot_run@l(7)
	stw 0,260(31)
	lis 29,0xc180
	lis 28,0x4180
	li 4,100
	li 9,2
	stw 29,192(31)
	li 10,1
	lis 11,0xc1c0
	stw 9,248(31)
	lis 0,0x4200
	li 5,200
	stw 10,512(31)
	lis 6,level@ha
	stw 11,196(31)
	lis 9,.LC5@ha
	stw 0,208(31)
	la 6,level@l(6)
	lis 27,num_players@ha
	stw 5,400(31)
	lis 11,players@ha
	lis 25,.LC6@ha
	stw 28,204(31)
	la 11,players@l(11)
	lis 10,botBlaster@ha
	stw 4,480(31)
	lis 24,0xbf80
	la 10,botBlaster@l(10)
	stw 7,812(31)
	li 5,22
	lis 26,0x4248
	stw 29,188(31)
	mr 3,31
	stw 28,200(31)
	stw 4,484(31)
	stfs 12,408(31)
	stw 8,892(31)
	stw 7,788(31)
	stw 7,800(31)
	stw 7,804(31)
	stw 8,816(31)
	stw 8,820(31)
	stfs 12,784(31)
	stw 8,416(31)
	stw 8,412(31)
	stw 8,540(31)
	lfs 0,4(6)
	lfd 13,.LC5@l(9)
	lwz 9,num_players@l(27)
	slwi 0,9,2
	stwx 31,11,0
	addi 9,9,1
	fadd 0,0,13
	stw 9,num_players@l(27)
	frsp 0,0
	stfs 0,976(31)
	lfs 13,.LC6@l(25)
	stw 10,980(31)
	stw 24,932(31)
	stfs 13,972(31)
	lfs 0,4(6)
	stw 5,508(31)
	stw 26,420(31)
	stfs 0,964(31)
	lfs 0,4(6)
	stw 8,1036(31)
	fadds 0,0,12
	stfs 0,1004(31)
	lfs 13,4(6)
	stfs 13,1088(31)
	b .L28
.L27:
	lis 9,gi+4@ha
	lis 3,.LC3@ha
	lwz 0,gi+4@l(9)
	la 3,.LC3@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L29:
	li 3,0
.L28:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 G_SpawnBot,.Lfe1-G_SpawnBot
	.section	".rodata"
	.align 2
.LC9:
	.string	"Unable to find bot, or no bots left\n"
	.align 2
.LC10:
	.string	"Unable to spawn bot: cannot create entity\n"
	.align 2
.LC11:
	.string	"name"
	.align 2
.LC12:
	.string	"skin"
	.align 2
.LC13:
	.string	"hand"
	.align 2
.LC14:
	.string	"2"
	.align 2
.LC15:
	.string	"%s joined the %s team.\n"
	.align 2
.LC16:
	.string	"%s entered the game"
	.align 2
.LC17:
	.string	"\n"
	.align 2
.LC18:
	.long 0x46fffe00
	.align 3
.LC19:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC20:
	.long 0x0
	.align 3
.LC21:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC22:
	.long 0x41000000
	.align 3
.LC23:
	.long 0x3ff80000
	.long 0x0
	.section	".text"
	.align 2
	.globl spawn_bot
	.type	 spawn_bot,@function
spawn_bot:
	stwu 1,-880(1)
	mflr 0
	stfd 30,864(1)
	stfd 31,872(1)
	stmw 25,836(1)
	stw 0,884(1)
	bl GetBotData
	mr. 30,3
	bc 4,2,.L31
	lis 9,gi+4@ha
	lis 3,.LC9@ha
	lwz 0,gi+4@l(9)
	la 3,.LC9@l(3)
	b .L37
.L31:
	bl G_SpawnBot
	mr. 31,3
	bc 4,2,.L32
	lis 9,gi+4@ha
	lis 3,.LC10@ha
	lwz 0,gi+4@l(9)
	la 3,.LC10@l(3)
.L37:
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L36
.L32:
	lis 27,g_edicts@ha
	lis 28,0xfb74
	lwz 9,g_edicts@l(27)
	ori 28,28,41881
	li 26,1
	lis 11,game+1028@ha
	stw 26,968(31)
	lis 10,.LC20@ha
	subf 9,9,31
	lwz 0,game+1028@l(11)
	la 10,.LC20@l(10)
	mullw 9,9,28
	addi 29,1,264
	lfs 31,0(10)
	li 5,4088
	li 4,0
	srawi 9,9,3
	mulli 9,9,4088
	addi 9,9,-4088
	add 0,0,9
	mr 3,0
	stw 0,84(31)
	crxor 6,6,6
	bl memset
	lwz 9,12(30)
	addi 3,1,8
	addi 9,9,1
	stw 9,12(30)
	stw 30,1072(31)
	lwz 4,8(30)
	bl strcpy
	li 4,0
	li 5,512
	mr 3,29
	crxor 6,6,6
	bl memset
	lwz 5,4(30)
	lis 4,.LC11@ha
	mr 3,29
	la 4,.LC11@l(4)
	bl Info_SetValueForKey
	lis 4,.LC12@ha
	addi 5,1,8
	la 4,.LC12@l(4)
	mr 3,29
	bl Info_SetValueForKey
	lis 4,.LC13@ha
	lis 5,.LC14@ha
	la 4,.LC13@l(4)
	la 5,.LC14@l(5)
	mr 3,29
	bl Info_SetValueForKey
	mr 3,31
	bl EntityListAdd
	mr 4,29
	mr 3,31
	li 5,0
	bl ClientConnect
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L33
	lwz 29,84(31)
	lwz 3,3468(29)
	addi 29,29,700
	bl CTFTeamName
	mr 6,3
	lis 4,.LC15@ha
	la 4,.LC15@l(4)
	mr 5,29
	li 3,2
	crxor 6,6,6
	bl my_bprintf
.L33:
	addi 4,1,776
	addi 5,1,792
	mr 3,31
	lis 25,0x4330
	bl SelectSpawnPoint
	lfs 13,776(1)
	lis 9,.LC21@ha
	li 5,184
	la 9,.LC21@l(9)
	li 4,0
	lfd 30,0(9)
	stfs 13,4(31)
	lfs 0,780(1)
	lwz 9,84(31)
	stfs 0,8(31)
	lfs 13,784(1)
	stfs 13,12(31)
	lfs 0,792(1)
	stfs 0,16(31)
	lfs 13,796(1)
	stfs 13,20(31)
	lfs 0,800(1)
	stfs 0,24(31)
	stfs 31,3628(9)
	lwz 3,84(31)
	crxor 6,6,6
	bl memset
	lis 9,.LC22@ha
	lfs 0,4(31)
	lis 0,0x42b4
	la 9,.LC22@l(9)
	lwz 8,84(31)
	lis 29,gi@ha
	lfs 10,0(9)
	la 29,gi@l(29)
	li 3,1
	mr 11,9
	mr 10,9
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,824(1)
	lwz 9,828(1)
	sth 9,4(8)
	lfs 0,8(31)
	lwz 9,84(31)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,824(1)
	lwz 11,828(1)
	sth 11,6(9)
	lfs 0,12(31)
	lwz 11,84(31)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,824(1)
	lwz 10,828(1)
	sth 10,8(11)
	lwz 9,84(31)
	stw 0,112(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 3,g_edicts@l(27)
	lwz 9,104(29)
	subf 3,3,31
	mullw 3,3,28
	mtlr 9
	srawi 3,3,3
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
	addi 11,30,16
	lwz 5,16(30)
	lis 8,skill@ha
	lwz 7,4(11)
	mr 3,31
	lwz 0,8(11)
	lwz 10,12(11)
	lwz 9,1068(31)
	lwz 4,skill@l(8)
	stw 5,0(9)
	stw 7,4(9)
	stw 0,8(9)
	stw 10,12(9)
	lwz 10,16(11)
	lwz 8,20(11)
	lwz 7,24(11)
	lwz 0,28(11)
	stw 10,16(9)
	stw 8,20(9)
	stw 7,24(9)
	stw 0,28(9)
	lfs 0,20(4)
	fctiwz 13,0
	stfd 13,824(1)
	lwz 6,828(1)
	stw 6,1076(31)
	bl AdjustRatingsToSkill
	lwz 9,g_edicts@l(27)
	li 0,255
	stw 0,44(31)
	subf 9,9,31
	stw 0,40(31)
	mullw 9,9,28
	srawi 9,9,3
	addi 9,9,-1
	stw 9,60(31)
	lwz 3,4(30)
	bl G_CopyString
	stw 3,504(31)
	lwz 3,84(31)
	lwz 4,4(30)
	addi 3,3,700
	bl strcpy
	lwz 5,84(31)
	lis 4,.LC16@ha
	li 3,2
	la 4,.LC16@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl my_bprintf
	lis 4,.LC17@ha
	li 3,2
	la 4,.LC17@l(4)
	crxor 6,6,6
	bl my_bprintf
	lis 11,bot_count@ha
	mr 3,31
	lwz 9,bot_count@l(11)
	addi 9,9,1
	stw 9,bot_count@l(11)
	bl K2_InitClientVars
	mr 3,31
	bl K2_ResetClientKeyVars
	mr 3,31
	bl KillBox
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
	li 0,22
	mr 3,31
	stw 26,88(31)
	stw 0,508(31)
	bl walkmonster_start
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC18@ha
	stw 3,828(1)
	lis 11,.LC19@ha
	stw 25,824(1)
	lfd 0,824(1)
	lfs 31,.LC18@l(10)
	lfd 12,.LC19@l(11)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,31
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L35
	bl G_Spawn
	lis 9,BotGreeting@ha
	mr 29,3
	la 9,BotGreeting@l(9)
	stw 31,256(29)
	stw 9,436(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,level+4@ha
	stw 3,828(1)
	lis 10,.LC23@ha
	stw 25,824(1)
	la 10,.LC23@l(10)
	lfd 0,824(1)
	lfs 13,level+4@l(11)
	lfd 12,0(10)
	fsub 0,0,30
	frsp 0,0
	fadd 13,13,12
	fdivs 0,0,31
	fmr 12,0
	fadd 13,13,12
	frsp 13,13
	stfs 13,428(29)
.L35:
	lwz 9,84(31)
	mr 3,31
	stw 26,3520(9)
.L36:
	lwz 0,884(1)
	mtlr 0
	lmw 25,836(1)
	lfd 30,864(1)
	lfd 31,872(1)
	la 1,880(1)
	blr
.Lfe2:
	.size	 spawn_bot,.Lfe2-spawn_bot
	.section	".rodata"
	.align 2
.LC24:
	.string	"WARNING: Unable to remove player from player[] array, problems will arise.\n"
	.section	".text"
	.align 2
	.globl botRemovePlayer
	.type	 botRemovePlayer,@function
botRemovePlayer:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,num_players@ha
	li 10,0
	lwz 11,num_players@l(9)
	li 0,0
	stw 0,480(3)
	cmpw 0,10,11
	bc 4,0,.L41
	lis 9,players@ha
	lwz 0,players@l(9)
	la 8,players@l(9)
	cmpw 0,0,3
	bc 12,2,.L41
	mr 9,8
.L42:
	addi 10,10,1
	cmpw 0,10,11
	bc 4,0,.L41
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L42
.L41:
	lis 9,num_players@ha
	lwz 0,num_players@l(9)
	cmpw 0,10,0
	bc 4,2,.L46
	lis 9,gi+4@ha
	lis 3,.LC24@ha
	lwz 0,gi+4@l(9)
	la 3,.LC24@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L39
.L46:
	addi 10,10,1
	cmpw 0,10,0
	bc 4,0,.L48
	mr 11,0
	lis 9,players@ha
	slwi 0,10,2
	la 9,players@l(9)
	add 9,0,9
	subf 10,10,11
.L50:
	lwz 0,0(9)
	addic. 10,10,-1
	stw 0,-4(9)
	addi 9,9,4
	bc 4,2,.L50
	mr 10,11
.L48:
	lis 9,players@ha
	slwi 0,10,2
	la 9,players@l(9)
	li 8,0
	stwx 8,9,0
	lwz 11,84(3)
	lwz 11,3912(11)
	cmpwi 0,11,0
	bc 12,2,.L52
	lwz 9,148(11)
	addi 9,9,-1
	stw 9,148(11)
	lwz 11,84(3)
	lwz 10,3912(11)
	lwz 9,152(10)
	addi 9,9,-1
	stw 9,152(10)
	lwz 11,84(3)
	stw 8,3912(11)
.L52:
	lwz 11,84(3)
	lis 10,num_players@ha
	lwz 9,num_players@l(10)
	stw 8,3468(11)
	lwz 0,968(3)
	addi 9,9,-1
	stw 9,num_players@l(10)
	cmpwi 0,0,0
	bc 12,2,.L53
	lwz 8,1072(3)
	lis 10,bot_count@ha
	lwz 9,bot_count@l(10)
	lwz 11,12(8)
	addi 9,9,-1
	stw 9,bot_count@l(10)
	addi 11,11,-1
	stw 11,12(8)
	b .L54
.L53:
	lis 11,num_clients@ha
	lwz 9,num_clients@l(11)
	addi 9,9,-1
	stw 9,num_clients@l(11)
.L54:
	lis 9,num_players@ha
	lwz 0,num_players@l(9)
	cmpwi 0,0,0
	bc 4,1,.L39
	lis 9,players@ha
	mr 10,0
	la 9,players@l(9)
	li 8,0
.L58:
	lwz 11,0(9)
	addi 9,9,4
	lwz 0,540(11)
	cmpw 0,0,3
	bc 4,2,.L57
	stw 8,540(11)
	stw 8,412(11)
.L57:
	addic. 10,10,-1
	bc 4,2,.L58
.L39:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 botRemovePlayer,.Lfe3-botRemovePlayer
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
	.comm	spawn_bots,4,4
	.comm	roam_calls_this_frame,4,4
	.comm	bestdirection_callsthisframe,4,4
	.comm	bot_chat_text,2048,4
	.comm	bot_chat_count,32,4
	.comm	last_bot_chat,32,4
	.comm	num_view_weapons,4,4
	.comm	view_weapon_models,4096,1
	.section	".rodata"
	.align 3
.LC25:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC26:
	.long 0x3f19999a
	.align 2
.LC27:
	.long 0x0
	.align 2
.LC28:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl respawn_bot
	.type	 respawn_bot,@function
respawn_bot:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	lis 9,level@ha
	lis 6,.LC27@ha
	la 6,.LC27@l(6)
	la 30,level@l(9)
	lfs 31,0(6)
	mr 31,3
	lfs 0,200(30)
	fcmpu 0,0,31
	bc 4,2,.L14
	li 0,6
	stw 0,80(31)
	bl PutClientInServer
	li 11,0
	li 0,22
	lwz 7,84(31)
	stw 0,508(31)
	lis 10,.LC25@ha
	lis 8,.LC26@ha
	stw 11,892(31)
	lis 9,botBlaster@ha
	lis 0,0xbf80
	stw 11,416(31)
	la 9,botBlaster@l(9)
	lis 6,.LC28@ha
	stw 11,412(31)
	la 6,.LC28@l(6)
	mr 3,31
	stw 11,540(31)
	lfs 0,4(30)
	lfd 12,.LC25@l(10)
	lfs 13,.LC26@l(8)
	stw 9,980(31)
	stw 0,932(31)
	stfs 13,972(31)
	fadd 0,0,12
	lfs 11,0(6)
	frsp 0,0
	stfs 0,976(31)
	lfs 13,4(30)
	stfs 13,964(31)
	lfs 0,4(30)
	fadds 0,0,11
	stfs 0,1004(31)
	stfs 31,3628(7)
	stw 11,1168(31)
	stw 11,1036(31)
	lfs 0,4(30)
	stfs 0,1088(31)
	bl walkmonster_start
.L14:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 respawn_bot,.Lfe4-respawn_bot
	.comm	botdebug,4,4
	.align 2
	.globl botDisconnect
	.type	 botDisconnect,@function
botDisconnect:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl ClientDisconnect
	li 0,0
	stw 0,1068(29)
	stw 0,968(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 botDisconnect,.Lfe5-botDisconnect
	.comm	pTempFind,4,4
	.align 2
	.globl bot_GetLastFreeClient
	.type	 bot_GetLastFreeClient,@function
bot_GetLastFreeClient:
	stwu 1,-16(1)
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 10,12(1)
	cmpwi 0,10,0
	bc 4,1,.L8
	lis 9,g_edicts@ha
	mulli 8,10,1352
	lwz 7,g_edicts@l(9)
	add 11,7,8
	addi 6,11,1352
	lwz 0,88(6)
	cmpwi 0,0,0
	bc 12,2,.L8
	addi 0,8,1352
	addi 9,8,1440
	add 11,0,7
	add 9,9,7
.L9:
	addic. 10,10,-1
	addi 11,11,-1352
	bc 4,1,.L8
	lwzu 0,-1352(9)
	mr 6,11
	cmpwi 0,0,0
	bc 4,2,.L9
.L8:
	lwz 3,88(6)
	addic 3,3,-1
	subfe 3,3,3
	and 3,6,3
	la 1,16(1)
	blr
.Lfe6:
	.size	 bot_GetLastFreeClient,.Lfe6-bot_GetLastFreeClient
	.align 2
	.globl botAddPlayer
	.type	 botAddPlayer,@function
botAddPlayer:
	lis 8,num_players@ha
	lis 7,num_clients@ha
	lwz 9,num_players@l(8)
	lis 11,players@ha
	lwz 10,num_clients@l(7)
	la 11,players@l(11)
	addi 0,9,1
	slwi 9,9,2
	addi 10,10,1
	stwx 3,11,9
	stw 0,num_players@l(8)
	stw 10,num_clients@l(7)
	blr
.Lfe7:
	.size	 botAddPlayer,.Lfe7-botAddPlayer
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
