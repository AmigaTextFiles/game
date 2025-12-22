	.file	"g_spawn.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.globl spawns
	.align 2
	.type	 spawns,@object
spawns:
	.long .LC0
	.long SP_item_health
	.long .LC1
	.long SP_item_health_small
	.long .LC2
	.long SP_item_health_large
	.long .LC3
	.long SP_item_health_mega
	.long .LC4
	.long SP_info_player_start
	.long .LC5
	.long SP_info_player_deathmatch
	.long .LC6
	.long SP_info_player_coop
	.long .LC7
	.long SP_info_player_intermission
	.long .LC8
	.long SP_info_player_team1
	.long .LC9
	.long SP_info_player_team2
	.long .LC10
	.long SP_func_plat
	.long .LC11
	.long SP_func_button
	.long .LC12
	.long SP_func_door
	.long .LC13
	.long SP_func_door_secret
	.long .LC14
	.long SP_func_door_rotating
	.long .LC15
	.long SP_func_rotating
	.long .LC16
	.long SP_func_train
	.long .LC17
	.long SP_func_water
	.long .LC18
	.long SP_func_conveyor
	.long .LC19
	.long SP_func_areaportal
	.long .LC20
	.long SP_func_clock
	.long .LC21
	.long SP_func_wall
	.long .LC22
	.long SP_func_object
	.long .LC23
	.long SP_func_timer
	.long .LC24
	.long SP_func_explosive
	.long .LC25
	.long SP_func_killbox
	.long .LC26
	.long SP_trigger_always
	.long .LC27
	.long SP_trigger_once
	.long .LC28
	.long SP_trigger_multiple
	.long .LC29
	.long SP_trigger_relay
	.long .LC30
	.long SP_trigger_push
	.long .LC31
	.long SP_trigger_hurt
	.long .LC32
	.long SP_trigger_key
	.long .LC33
	.long SP_trigger_counter
	.long .LC34
	.long SP_trigger_elevator
	.long .LC35
	.long SP_trigger_gravity
	.long .LC36
	.long SP_trigger_monsterjump
	.long .LC37
	.long SP_target_temp_entity
	.long .LC38
	.long SP_target_speaker
	.long .LC39
	.long SP_target_explosion
	.long .LC40
	.long SP_target_changelevel
	.long .LC41
	.long SP_target_secret
	.long .LC42
	.long SP_target_goal
	.long .LC43
	.long SP_target_splash
	.long .LC44
	.long SP_target_spawner
	.long .LC45
	.long SP_target_blaster
	.long .LC46
	.long SP_target_crosslevel_trigger
	.long .LC47
	.long SP_target_crosslevel_target
	.long .LC48
	.long SP_target_laser
	.long .LC49
	.long SP_target_help
	.long .LC50
	.long SP_target_lightramp
	.long .LC51
	.long SP_target_earthquake
	.long .LC52
	.long SP_target_character
	.long .LC53
	.long SP_target_string
	.long .LC54
	.long SP_worldspawn
	.long .LC55
	.long SP_viewthing
	.long .LC56
	.long SP_light
	.long .LC57
	.long SP_light_mine1
	.long .LC58
	.long SP_light_mine2
	.long .LC59
	.long SP_info_null
	.long .LC60
	.long SP_info_null
	.long .LC61
	.long SP_info_notnull
	.long .LC62
	.long SP_path_corner
	.long .LC63
	.long SP_point_combat
	.long .LC64
	.long SP_misc_explobox
	.long .LC65
	.long SP_misc_banner
	.long .LC66
	.long SP_misc_ctf_banner
	.long .LC67
	.long SP_misc_ctf_small_banner
	.long .LC68
	.long SP_misc_satellite_dish
	.long .LC69
	.long SP_misc_gib_arm
	.long .LC70
	.long SP_misc_gib_leg
	.long .LC71
	.long SP_misc_gib_head
	.long .LC72
	.long SP_misc_deadsoldier
	.long .LC73
	.long SP_misc_viper
	.long .LC74
	.long SP_misc_viper_bomb
	.long .LC75
	.long SP_misc_bigviper
	.long .LC76
	.long SP_misc_strogg_ship
	.long .LC77
	.long SP_misc_teleporter
	.long .LC78
	.long SP_misc_teleporter_dest
	.long .LC79
	.long SP_trigger_teleport
	.long .LC80
	.long SP_info_teleport_destination
	.long .LC81
	.long SP_misc_blackhole
	.long .LC82
	.long SP_misc_eastertank
	.long .LC83
	.long SP_misc_easterchick
	.long .LC84
	.long SP_misc_easterchick2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC84:
	.string	"misc_easterchick2"
	.align 2
.LC83:
	.string	"misc_easterchick"
	.align 2
.LC82:
	.string	"misc_eastertank"
	.align 2
.LC81:
	.string	"misc_blackhole"
	.align 2
.LC80:
	.string	"info_teleport_destination"
	.align 2
.LC79:
	.string	"trigger_teleport"
	.align 2
.LC78:
	.string	"misc_teleporter_dest"
	.align 2
.LC77:
	.string	"misc_teleporter"
	.align 2
.LC76:
	.string	"misc_strogg_ship"
	.align 2
.LC75:
	.string	"misc_bigviper"
	.align 2
.LC74:
	.string	"misc_viper_bomb"
	.align 2
.LC73:
	.string	"misc_viper"
	.align 2
.LC72:
	.string	"misc_deadsoldier"
	.align 2
.LC71:
	.string	"misc_gib_head"
	.align 2
.LC70:
	.string	"misc_gib_leg"
	.align 2
.LC69:
	.string	"misc_gib_arm"
	.align 2
.LC68:
	.string	"misc_satellite_dish"
	.align 2
.LC67:
	.string	"misc_ctf_small_banner"
	.align 2
.LC66:
	.string	"misc_ctf_banner"
	.align 2
.LC65:
	.string	"misc_banner"
	.align 2
.LC64:
	.string	"misc_explobox"
	.align 2
.LC63:
	.string	"point_combat"
	.align 2
.LC62:
	.string	"path_corner"
	.align 2
.LC61:
	.string	"info_notnull"
	.align 2
.LC60:
	.string	"func_group"
	.align 2
.LC59:
	.string	"info_null"
	.align 2
.LC58:
	.string	"light_mine2"
	.align 2
.LC57:
	.string	"light_mine1"
	.align 2
.LC56:
	.string	"light"
	.align 2
.LC55:
	.string	"viewthing"
	.align 2
.LC54:
	.string	"worldspawn"
	.align 2
.LC53:
	.string	"target_string"
	.align 2
.LC52:
	.string	"target_character"
	.align 2
.LC51:
	.string	"target_earthquake"
	.align 2
.LC50:
	.string	"target_lightramp"
	.align 2
.LC49:
	.string	"target_help"
	.align 2
.LC48:
	.string	"target_laser"
	.align 2
.LC47:
	.string	"target_crosslevel_target"
	.align 2
.LC46:
	.string	"target_crosslevel_trigger"
	.align 2
.LC45:
	.string	"target_blaster"
	.align 2
.LC44:
	.string	"target_spawner"
	.align 2
.LC43:
	.string	"target_splash"
	.align 2
.LC42:
	.string	"target_goal"
	.align 2
.LC41:
	.string	"target_secret"
	.align 2
.LC40:
	.string	"target_changelevel"
	.align 2
.LC39:
	.string	"target_explosion"
	.align 2
.LC38:
	.string	"target_speaker"
	.align 2
.LC37:
	.string	"target_temp_entity"
	.align 2
.LC36:
	.string	"trigger_monsterjump"
	.align 2
.LC35:
	.string	"trigger_gravity"
	.align 2
.LC34:
	.string	"trigger_elevator"
	.align 2
.LC33:
	.string	"trigger_counter"
	.align 2
.LC32:
	.string	"trigger_key"
	.align 2
.LC31:
	.string	"trigger_hurt"
	.align 2
.LC30:
	.string	"trigger_push"
	.align 2
.LC29:
	.string	"trigger_relay"
	.align 2
.LC28:
	.string	"trigger_multiple"
	.align 2
.LC27:
	.string	"trigger_once"
	.align 2
.LC26:
	.string	"trigger_always"
	.align 2
.LC25:
	.string	"func_killbox"
	.align 2
.LC24:
	.string	"func_explosive"
	.align 2
.LC23:
	.string	"func_timer"
	.align 2
.LC22:
	.string	"func_object"
	.align 2
.LC21:
	.string	"func_wall"
	.align 2
.LC20:
	.string	"func_clock"
	.align 2
.LC19:
	.string	"func_areaportal"
	.align 2
.LC18:
	.string	"func_conveyor"
	.align 2
.LC17:
	.string	"func_water"
	.align 2
.LC16:
	.string	"func_train"
	.align 2
.LC15:
	.string	"func_rotating"
	.align 2
.LC14:
	.string	"func_door_rotating"
	.align 2
.LC13:
	.string	"func_door_secret"
	.align 2
.LC12:
	.string	"func_door"
	.align 2
.LC11:
	.string	"func_button"
	.align 2
.LC10:
	.string	"func_plat"
	.align 2
.LC9:
	.string	"info_player_team2"
	.align 2
.LC8:
	.string	"info_player_team1"
	.align 2
.LC7:
	.string	"info_player_intermission"
	.align 2
.LC6:
	.string	"info_player_coop"
	.align 2
.LC5:
	.string	"info_player_deathmatch"
	.align 2
.LC4:
	.string	"info_player_start"
	.align 2
.LC3:
	.string	"item_health_mega"
	.align 2
.LC2:
	.string	"item_health_large"
	.align 2
.LC1:
	.string	"item_health_small"
	.align 2
.LC0:
	.string	"item_health"
	.size	 spawns,688
	.align 2
.LC85:
	.string	"ED_CallSpawn: NULL classname\n"
	.align 2
.LC86:
	.string	"%f %f %f"
	.align 2
.LC87:
	.string	"%s is not a field\n"
	.section	".text"
	.align 2
	.globl ED_ParseField
	.type	 ED_ParseField,@function
ED_ParseField:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 9,fields@ha
	mr 31,3
	lwz 0,fields@l(9)
	mr 30,4
	mr 29,5
	la 28,fields@l(9)
	cmpwi 0,0,0
	bc 12,2,.L33
.L35:
	lwz 3,0(28)
	mr 4,31
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L34
	lwz 0,12(28)
	andi. 9,0,1
	bc 12,2,.L37
	lis 9,st@ha
	la 27,st@l(9)
	b .L38
.L37:
	mr 27,29
.L38:
	lwz 10,8(28)
	cmplwi 0,10,9
	bc 12,1,.L31
	lis 11,.L56@ha
	slwi 10,10,2
	la 11,.L56@l(11)
	lis 9,.L56@ha
	lwzx 0,10,11
	la 9,.L56@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L56:
	.long .L52-.L56
	.long .L53-.L56
	.long .L40-.L56
	.long .L31-.L56
	.long .L51-.L56
	.long .L54-.L56
	.long .L31-.L56
	.long .L31-.L56
	.long .L31-.L56
	.long .L31-.L56
.L40:
	mr 3,30
	bl strlen
	lis 9,gi+132@ha
	mr 31,3
	lwz 0,gi+132@l(9)
	addi 29,31,1
	li 4,766
	mr 3,29
	mtlr 0
	blrl
	li 10,0
	mr 7,3
	cmpw 0,10,29
	mr 9,7
	bc 4,0,.L49
	mr 3,31
	li 6,10
.L43:
	lbzx 0,30,10
	rlwinm 11,0,0,0xff
	mr 8,0
	cmpwi 0,11,92
	bc 4,2,.L44
	cmpw 0,10,3
	bc 4,0,.L44
	addi 10,10,1
	lbzx 0,30,10
	cmpwi 0,0,110
	bc 4,2,.L45
	stb 6,0(9)
	b .L59
.L45:
	stb 11,0(9)
	b .L59
.L44:
	stb 8,0(9)
.L59:
	addi 9,9,1
	addi 10,10,1
	cmpw 0,10,29
	bc 12,0,.L43
.L49:
	lwz 0,4(28)
	stwx 7,27,0
	b .L31
.L51:
	lis 4,.LC86@ha
	mr 3,30
	la 4,.LC86@l(4)
	addi 5,1,8
	addi 6,1,12
	addi 7,1,16
	crxor 6,6,6
	bl sscanf
	lfs 0,8(1)
	lwz 0,4(28)
	stfsx 0,27,0
	lwz 9,4(28)
	lfs 0,12(1)
	add 9,27,9
	stfs 0,4(9)
	lwz 11,4(28)
	lfs 0,16(1)
	add 11,27,11
	stfs 0,8(11)
	b .L31
.L52:
	mr 3,30
	bl atoi
	lwz 0,4(28)
	stwx 3,27,0
	b .L31
.L53:
	mr 3,30
	bl atof
	frsp 1,1
	lwz 0,4(28)
	stfsx 1,27,0
	b .L31
.L54:
	mr 3,30
	bl atof
	lwz 0,4(28)
	li 10,0
	frsp 1,1
	stwx 10,27,0
	lwz 9,4(28)
	add 9,27,9
	stfs 1,4(9)
	lwz 11,4(28)
	add 11,27,11
	stw 10,8(11)
	b .L31
.L34:
	lwzu 0,16(28)
	cmpwi 0,0,0
	bc 4,2,.L35
.L33:
	lis 9,gi+4@ha
	lis 3,.LC87@ha
	lwz 0,gi+4@l(9)
	la 3,.LC87@l(3)
	mr 4,31
	mtlr 0
	crxor 6,6,6
	blrl
.L31:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 ED_ParseField,.Lfe1-ED_ParseField
	.section	".rodata"
	.align 2
.LC88:
	.string	"ED_ParseEntity: EOF without closing brace"
	.align 2
.LC89:
	.string	"ED_ParseEntity: closing brace without data"
	.section	".text"
	.align 2
	.globl ED_ParseEdict
	.type	 ED_ParseEdict,@function
ED_ParseEdict:
	stwu 1,-304(1)
	mflr 0
	stmw 28,288(1)
	stw 0,308(1)
	stw 3,264(1)
	mr 28,4
	li 5,68
	lis 3,st@ha
	li 4,0
	la 3,st@l(3)
	li 29,0
	crxor 6,6,6
	bl memset
	addi 30,1,264
	b .L63
.L64:
	lwz 0,264(1)
	cmpwi 0,0,0
	bc 4,2,.L65
	lis 9,gi+28@ha
	lis 3,.LC88@ha
	lwz 0,gi+28@l(9)
	la 3,.LC88@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L65:
	mr 4,31
	li 5,255
	addi 3,1,8
	bl strncpy
	mr 3,30
	bl COM_Parse
	lwz 0,264(1)
	mr 31,3
	cmpwi 0,0,0
	bc 4,2,.L66
	lis 9,gi+28@ha
	lis 3,.LC88@ha
	lwz 0,gi+28@l(9)
	la 3,.LC88@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L66:
	lbz 0,0(31)
	cmpwi 0,0,125
	bc 4,2,.L67
	lis 9,gi+28@ha
	lis 3,.LC89@ha
	lwz 0,gi+28@l(9)
	la 3,.LC89@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L67:
	lbz 0,8(1)
	li 29,1
	cmpwi 0,0,95
	bc 12,2,.L63
	mr 4,31
	addi 3,1,8
	mr 5,28
	bl ED_ParseField
.L63:
	mr 3,30
	bl COM_Parse
	mr 31,3
	lbz 0,0(31)
	cmpwi 0,0,125
	bc 4,2,.L64
	cmpwi 0,29,0
	bc 4,2,.L70
	mr 3,28
	li 4,0
	li 5,1332
	crxor 6,6,6
	bl memset
.L70:
	lwz 3,264(1)
	lwz 0,308(1)
	mtlr 0
	lmw 28,288(1)
	la 1,304(1)
	blr
.Lfe2:
	.size	 ED_ParseEdict,.Lfe2-ED_ParseEdict
	.section	".rodata"
	.align 2
.LC90:
	.string	"%i teams with %i entities\n"
	.section	".text"
	.align 2
	.globl G_FindTeams
	.type	 G_FindTeams,@function
G_FindTeams:
	stwu 1,-64(1)
	mflr 0
	stmw 21,20(1)
	stw 0,68(1)
	lis 9,globals@ha
	li 10,1
	la 8,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(8)
	li 22,0
	li 26,0
	lwz 9,g_edicts@l(11)
	cmpw 0,10,0
	addi 30,9,1332
	bc 4,0,.L73
	mr 23,8
	lis 21,globals@ha
.L75:
	lwz 0,88(30)
	addi 27,10,1
	addi 25,30,1332
	cmpwi 0,0,0
	bc 12,2,.L74
	lwz 0,308(30)
	cmpwi 0,0,0
	bc 12,2,.L74
	lwz 0,264(30)
	andi. 9,0,1024
	bc 4,2,.L74
	stw 30,564(30)
	mr 28,30
	addi 22,22,1
	lwz 0,72(23)
	addi 26,26,1
	mr 29,27
	mr 31,25
	cmpw 0,27,0
	bc 4,0,.L74
	la 24,globals@l(21)
.L82:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L81
	lwz 4,308(31)
	cmpwi 0,4,0
	bc 12,2,.L81
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L81
	lwz 3,308(30)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L81
	stw 31,560(28)
	addi 26,26,1
	lwz 0,264(31)
	mr 28,31
	stw 30,564(31)
	ori 0,0,1024
	stw 0,264(31)
.L81:
	lwz 0,72(24)
	addi 29,29,1
	addi 31,31,1332
	cmpw 0,29,0
	bc 12,0,.L82
.L74:
	lwz 0,72(23)
	mr 10,27
	mr 30,25
	cmpw 0,10,0
	bc 12,0,.L75
.L73:
	lis 9,gi+4@ha
	lis 3,.LC90@ha
	lwz 0,gi+4@l(9)
	la 3,.LC90@l(3)
	mr 4,22
	mr 5,26
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 21,20(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 G_FindTeams,.Lfe3-G_FindTeams
	.section	".rodata"
	.align 2
.LC91:
	.string	"skill"
	.align 2
.LC92:
	.string	"%f"
	.align 2
.LC93:
	.string	"ED_LoadFromFile: found %s when expecting {"
	.align 2
.LC94:
	.string	"command"
	.align 2
.LC95:
	.string	"*27"
	.align 2
.LC96:
	.string	"%i entities inhibited\n"
	.align 2
.LC97:
	.string	"item_flag_team1"
	.align 2
.LC98:
	.string	"ctf"
	.align 2
.LC99:
	.string	"0"
	.align 2
.LC100:
	.string	"1"
	.align 2
.LC101:
	.string	"grapple"
	.align 2
.LC102:
	.string	"sbctf1"
	.align 2
.LC103:
	.string	"sbctf2"
	.align 2
.LC104:
	.string	"i_ctf1"
	.align 2
.LC105:
	.string	"i_ctf2"
	.align 2
.LC106:
	.string	"i_ctf1d"
	.align 2
.LC107:
	.string	"i_ctf2d"
	.align 2
.LC108:
	.string	"i_ctf1t"
	.align 2
.LC109:
	.string	"i_ctf2t"
	.align 2
.LC110:
	.string	"i_ctfj"
	.align 2
.LC111:
	.long 0x0
	.align 2
.LC112:
	.long 0x40400000
	.align 2
.LC113:
	.long 0x3f800000
	.align 2
.LC114:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl SpawnEntities
	.type	 SpawnEntities,@function
SpawnEntities:
	stwu 1,-384(1)
	mflr 0
	stfd 31,376(1)
	stmw 22,336(1)
	stw 0,388(1)
	lis 9,skill@ha
	stw 4,312(1)
	mr 28,3
	lwz 11,skill@l(9)
	mr 27,5
	lis 24,skill@ha
	lis 9,.LC111@ha
	lfs 1,20(11)
	la 9,.LC111@l(9)
	lfs 31,0(9)
	bl floor
	frsp 1,1
	fcmpu 0,1,31
	bc 4,0,.L90
	lis 9,.LC111@ha
	la 9,.LC111@l(9)
	lfs 1,0(9)
.L90:
	lis 11,.LC112@ha
	la 11,.LC112@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,1,.L91
	lis 9,.LC112@ha
	la 9,.LC112@l(9)
	lfs 1,0(9)
.L91:
	lwz 9,skill@l(24)
	lfs 0,20(9)
	fcmpu 0,0,1
	bc 12,2,.L92
	lis 3,.LC92@ha
	lis 29,gi@ha
	la 29,gi@l(29)
	la 3,.LC92@l(3)
	creqv 6,6,6
	bl va
	mr 4,3
	lwz 0,152(29)
	lis 3,.LC91@ha
	la 3,.LC91@l(3)
	mtlr 0
	blrl
.L92:
	bl SaveClientData
	lis 9,gi+140@ha
	li 3,766
	lwz 0,gi+140@l(9)
	mtlr 0
	blrl
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L93
	bl niq_setweapontimer
.L93:
	lis 29,level@ha
	li 5,304
	la 29,level@l(29)
	li 4,0
	mr 3,29
	lis 22,game@ha
	crxor 6,6,6
	bl memset
	lis 25,g_edicts@ha
	lis 9,game@ha
	lis 11,g_edicts@ha
	la 30,game@l(9)
	lwz 3,g_edicts@l(11)
	addi 23,1,312
	lwz 5,1548(30)
	li 4,0
	mulli 5,5,1332
	bl memset
	mr 4,28
	li 5,63
	addi 3,29,72
	bl strncpy
	mr 4,27
	addi 3,30,1032
	li 5,511
	bl strncpy
	lwz 0,1544(30)
	li 11,0
	cmpw 0,11,0
	bc 4,0,.L95
	lwz 9,g_edicts@l(25)
	mr 3,30
	li 10,0
	addi 9,9,1416
.L97:
	lwz 0,1028(3)
	addi 11,11,1
	add 0,0,10
	stw 0,0(9)
	addi 10,10,3968
	lwz 0,1544(3)
	addi 9,9,1332
	cmpw 0,11,0
	bc 12,0,.L97
.L95:
	lis 9,gi@ha
	li 30,0
	la 26,gi@l(9)
	li 27,0
	b .L101
.L102:
	lbz 0,0(4)
	cmpwi 0,0,123
	bc 12,2,.L103
	lwz 9,28(26)
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
.L103:
	cmpwi 0,30,0
	bc 4,2,.L104
	lwz 30,g_edicts@l(25)
	b .L105
.L104:
	bl G_Spawn
	mr 30,3
.L105:
	lwz 3,312(1)
	mr 4,30
	bl ED_ParseEdict
	stw 3,312(1)
	lis 4,.LC94@ha
	lis 3,level+72@ha
	la 4,.LC94@l(4)
	la 3,level+72@l(3)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L106
	lwz 3,280(30)
	lis 4,.LC27@ha
	la 4,.LC27@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L106
	lwz 3,268(30)
	lis 4,.LC95@ha
	la 4,.LC95@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L106
	lwz 0,284(30)
	rlwinm 0,0,0,22,20
	stw 0,284(30)
.L106:
	lwz 0,g_edicts@l(25)
	cmpw 0,30,0
	bc 12,2,.L107
	lis 11,.LC111@ha
	lis 9,deathmatch@ha
	la 11,.LC111@l(11)
	lfs 12,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L108
	lwz 0,284(30)
	andi. 9,0,2048
	b .L140
.L108:
	lwz 9,skill@l(24)
	lwz 0,284(30)
	lfs 13,20(9)
	fcmpu 0,13,12
	bc 4,2,.L113
	andi. 9,0,256
	bc 4,2,.L112
.L113:
	lis 11,.LC113@ha
	la 11,.LC113@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L114
	andi. 9,0,512
	bc 4,2,.L112
.L114:
	lis 11,.LC114@ha
	la 11,.LC114@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 12,2,.L115
	lis 9,.LC112@ha
	la 9,.LC112@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L110
.L115:
	andi. 11,0,1024
.L140:
	bc 12,2,.L110
.L112:
	mr 3,30
	addi 27,27,1
	bl G_FreeEdict
	b .L101
.L110:
	rlwinm 0,0,0,24,18
	stw 0,284(30)
.L107:
	lwz 0,280(30)
	cmpwi 0,0,0
	bc 4,2,.L116
	lwz 9,4(26)
	lis 3,.LC85@ha
	la 3,.LC85@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L101
.L138:
	mr 4,29
	mr 3,30
	bl SpawnItem
	b .L101
.L139:
	lwz 0,4(29)
	mr 3,30
	mtlr 0
	blrl
	b .L101
.L116:
	la 11,game@l(22)
	li 31,0
	lwz 0,1556(11)
	lis 9,itemlist@ha
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L124
	mr 28,11
.L120:
	lwz 3,0(29)
	cmpwi 0,3,0
	bc 12,2,.L122
	lwz 4,280(30)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L138
.L122:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,72
	cmpw 0,31,0
	bc 12,0,.L120
.L124:
	lis 9,spawns@ha
	lwz 0,spawns@l(9)
	la 29,spawns@l(9)
	cmpwi 0,0,0
	bc 12,2,.L101
.L127:
	lwz 3,0(29)
	lwz 4,280(30)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L139
	lwzu 0,8(29)
	cmpwi 0,0,0
	bc 4,2,.L127
.L101:
	mr 3,23
	bl COM_Parse
	lwz 0,312(1)
	mr 4,3
	cmpwi 0,0,0
	bc 4,2,.L102
	lis 9,gi@ha
	lis 3,.LC96@ha
	la 31,gi@l(9)
	la 3,.LC96@l(3)
	lwz 9,4(31)
	mr 4,27
	mtlr 9
	crxor 6,6,6
	blrl
	bl G_FindTeams
	lis 5,.LC97@ha
	li 3,0
	la 5,.LC97@l(5)
	li 4,280
	bl G_Find
	cmpwi 0,3,0
	bc 4,2,.L132
	lwz 0,152(31)
	lis 3,.LC98@ha
	lis 4,.LC99@ha
	la 3,.LC98@l(3)
	la 4,.LC99@l(4)
	mtlr 0
	blrl
	b .L133
.L132:
	lwz 9,152(31)
	lis 29,.LC100@ha
	lis 3,.LC98@ha
	la 4,.LC100@l(29)
	la 3,.LC98@l(3)
	mtlr 9
	blrl
	lwz 9,152(31)
	lis 3,.LC101@ha
	la 4,.LC100@l(29)
	la 3,.LC101@l(3)
	mtlr 9
	blrl
	lis 9,.LC111@ha
	la 9,.LC111@l(9)
	lfs 13,0(9)
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L133
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L135
	lwz 0,24(31)
	lis 9,niq_ctf_statusbar@ha
	li 3,5
	lwz 4,niq_ctf_statusbar@l(9)
	mtlr 0
	blrl
	b .L136
.L135:
	lwz 0,24(31)
	lis 9,ctf_statusbar@ha
	li 3,5
	lwz 4,ctf_statusbar@l(9)
	mtlr 0
	blrl
.L136:
	lis 29,gi@ha
	lis 3,.LC102@ha
	la 29,gi@l(29)
	la 3,.LC102@l(3)
	lwz 9,40(29)
	mtlr 9
	blrl
	lwz 9,40(29)
	lis 3,.LC103@ha
	la 3,.LC103@l(3)
	mtlr 9
	blrl
	lwz 9,40(29)
	lis 3,.LC104@ha
	la 3,.LC104@l(3)
	mtlr 9
	blrl
	lwz 9,40(29)
	lis 3,.LC105@ha
	la 3,.LC105@l(3)
	mtlr 9
	blrl
	lwz 9,40(29)
	lis 3,.LC106@ha
	la 3,.LC106@l(3)
	mtlr 9
	blrl
	lwz 9,40(29)
	lis 3,.LC107@ha
	la 3,.LC107@l(3)
	mtlr 9
	blrl
	lwz 9,40(29)
	lis 3,.LC108@ha
	la 3,.LC108@l(3)
	mtlr 9
	blrl
	lwz 9,40(29)
	lis 3,.LC109@ha
	la 3,.LC109@l(3)
	mtlr 9
	blrl
	lwz 0,40(29)
	lis 3,.LC110@ha
	la 3,.LC110@l(3)
	mtlr 0
	blrl
.L133:
	bl CTFSetupTechSpawn
	lis 9,.LC111@ha
	la 9,.LC111@l(9)
	lfs 13,0(9)
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L137
	lis 9,niq_logfile@ha
	lwz 11,niq_logfile@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L137
	addi 29,1,8
	lis 4,level@ha
	la 4,level@l(4)
	mr 3,29
	li 5,304
	crxor 6,6,6
	bl memcpy
	lis 3,gi@ha
	mr 4,29
	la 3,gi@l(3)
	bl sl_GameStart
.L137:
	lwz 0,388(1)
	mtlr 0
	lmw 22,336(1)
	lfd 31,376(1)
	la 1,384(1)
	blr
.Lfe4:
	.size	 SpawnEntities,.Lfe4-SpawnEntities
	.globl dm_statusbar
	.section	".rodata"
	.align 2
.LC115:
	.ascii	"yb\t-24 xv\t0 hnum xv\t50 pic 0 if 2 \txv\t100 \tanum \txv\t"
	.ascii	"150 \tpic 2 endif if 4 \txv\t2"
	.string	"00 \trnum \txv\t250 \tpic 4 endif if 6 \txv\t296 \tpic 6 endif yb\t-50 if 7 \txv\t0 \tpic 7 \txv\t26 \tyb\t-42 \tstat_string 8 \tyb\t-50 endif if 9 \txv\t246 \tnum\t2\t10 \txv\t296 \tpic\t9 endif if 11 \txv\t148 \tpic\t11 endif xr\t-50 yt 2 num 3 14if 27 xv 0 yb -58 stat_string 27 endif "
	.section	".sdata","aw"
	.align 2
	.type	 dm_statusbar,@object
	.size	 dm_statusbar,4
dm_statusbar:
	.long .LC115
	.section	".rodata"
	.align 2
.LC116:
	.string	"unit1_"
	.align 2
.LC117:
	.string	"%i"
	.align 2
.LC118:
	.string	"shells"
	.align 2
.LC119:
	.string	"cells"
	.align 2
.LC120:
	.string	"bullets"
	.align 2
.LC121:
	.string	"rockets"
	.align 2
.LC122:
	.string	"slugs"
	.align 2
.LC123:
	.string	"grenades"
	.align 2
.LC124:
	.string	"blaster"
	.align 2
.LC125:
	.string	"shotgun"
	.align 2
.LC126:
	.string	"super shotgun"
	.align 2
.LC127:
	.string	"machinegun"
	.align 2
.LC128:
	.string	"chaingun"
	.align 2
.LC129:
	.string	"grenade launcher"
	.align 2
.LC130:
	.string	"rocket launcher"
	.align 2
.LC131:
	.string	"railgun"
	.align 2
.LC132:
	.string	"hyperblaster"
	.align 2
.LC133:
	.string	"bfg10k"
	.align 2
.LC134:
	.string	"i_help"
	.align 2
.LC135:
	.string	"i_health"
	.align 2
.LC136:
	.string	"help"
	.align 2
.LC137:
	.string	"field_3"
	.align 2
.LC138:
	.string	"sv_gravity"
	.align 2
.LC139:
	.string	"800"
	.align 2
.LC140:
	.string	"player/fry.wav"
	.align 2
.LC141:
	.string	"Blaster"
	.align 2
.LC142:
	.string	"player/lava1.wav"
	.align 2
.LC143:
	.string	"player/lava2.wav"
	.align 2
.LC144:
	.string	"misc/pc_up.wav"
	.align 2
.LC145:
	.string	"misc/talk1.wav"
	.align 2
.LC146:
	.string	"misc/udeath.wav"
	.align 2
.LC147:
	.string	"items/respawn1.wav"
	.align 2
.LC148:
	.string	"*death1.wav"
	.align 2
.LC149:
	.string	"*death2.wav"
	.align 2
.LC150:
	.string	"*death3.wav"
	.align 2
.LC151:
	.string	"*death4.wav"
	.align 2
.LC152:
	.string	"*fall1.wav"
	.align 2
.LC153:
	.string	"*fall2.wav"
	.align 2
.LC154:
	.string	"*gurp1.wav"
	.align 2
.LC155:
	.string	"*gurp2.wav"
	.align 2
.LC156:
	.string	"*jump1.wav"
	.align 2
.LC157:
	.string	"*pain25_1.wav"
	.align 2
.LC158:
	.string	"*pain25_2.wav"
	.align 2
.LC159:
	.string	"*pain50_1.wav"
	.align 2
.LC160:
	.string	"*pain50_2.wav"
	.align 2
.LC161:
	.string	"*pain75_1.wav"
	.align 2
.LC162:
	.string	"*pain75_2.wav"
	.align 2
.LC163:
	.string	"*pain100_1.wav"
	.align 2
.LC164:
	.string	"*pain100_2.wav"
	.align 2
.LC165:
	.string	"player/female/death1.wav"
	.align 2
.LC166:
	.string	"player/female/death2.wav"
	.align 2
.LC167:
	.string	"player/female/death3.wav"
	.align 2
.LC168:
	.string	"player/female/death4.wav"
	.align 2
.LC169:
	.string	"player/female/fall1.wav"
	.align 2
.LC170:
	.string	"player/female/fall2.wav"
	.align 2
.LC171:
	.string	"player/female/gurp1.wav"
	.align 2
.LC172:
	.string	"player/female/gurp2.wav"
	.align 2
.LC173:
	.string	"player/female/jump1.wav"
	.align 2
.LC174:
	.string	"player/female/pain25_1.wav"
	.align 2
.LC175:
	.string	"player/female/pain25_2.wav"
	.align 2
.LC176:
	.string	"player/female/pain50_1.wav"
	.align 2
.LC177:
	.string	"player/female/pain50_2.wav"
	.align 2
.LC178:
	.string	"player/female/pain75_1.wav"
	.align 2
.LC179:
	.string	"player/female/pain75_2.wav"
	.align 2
.LC180:
	.string	"player/female/pain100_1.wav"
	.align 2
.LC181:
	.string	"player/female/pain100_2.wav"
	.align 2
.LC182:
	.string	"player/gasp1.wav"
	.align 2
.LC183:
	.string	"player/gasp2.wav"
	.align 2
.LC184:
	.string	"player/watr_in.wav"
	.align 2
.LC185:
	.string	"player/watr_out.wav"
	.align 2
.LC186:
	.string	"player/watr_un.wav"
	.align 2
.LC187:
	.string	"player/u_breath1.wav"
	.align 2
.LC188:
	.string	"player/u_breath2.wav"
	.align 2
.LC189:
	.string	"items/pkup.wav"
	.align 2
.LC190:
	.string	"world/land.wav"
	.align 2
.LC191:
	.string	"misc/h2ohit1.wav"
	.align 2
.LC192:
	.string	"items/damage.wav"
	.align 2
.LC193:
	.string	"items/protect.wav"
	.align 2
.LC194:
	.string	"items/protect4.wav"
	.align 2
.LC195:
	.string	"weapons/noammo.wav"
	.align 2
.LC196:
	.string	"infantry/inflies1.wav"
	.align 2
.LC197:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC198:
	.string	"models/objects/gibs/arm/tris.md2"
	.align 2
.LC199:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC200:
	.string	"models/objects/gibs/bone2/tris.md2"
	.align 2
.LC201:
	.string	"models/objects/gibs/chest/tris.md2"
	.align 2
.LC202:
	.string	"models/objects/gibs/skull/tris.md2"
	.align 2
.LC203:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC204:
	.string	"players/male/a_grenades.md2"
	.align 2
.LC205:
	.string	"players/male/w_bfg.md2"
	.align 2
.LC206:
	.string	"players/male/w_blaster.md2"
	.align 2
.LC207:
	.string	"players/male/w_chaingun.md2"
	.align 2
.LC208:
	.string	"players/male/w_glauncher.md2"
	.align 2
.LC209:
	.string	"players/male/w_grapple.md2"
	.align 2
.LC210:
	.string	"players/male/w_hyperblaster.md2"
	.align 2
.LC211:
	.string	"players/male/w_machinegun.md2"
	.align 2
.LC212:
	.string	"players/male/w_railgun.md2"
	.align 2
.LC213:
	.string	"players/male/w_rlauncher.md2"
	.align 2
.LC214:
	.string	"players/male/w_shotgun.md2"
	.align 2
.LC215:
	.string	"players/male/w_sshotgun.md2"
	.align 2
.LC216:
	.string	"players/female/a_grenades.md2"
	.align 2
.LC217:
	.string	"players/female/w_bfg.md2"
	.align 2
.LC218:
	.string	"players/female/w_blaster.md2"
	.align 2
.LC219:
	.string	"players/female/w_chaingun.md2"
	.align 2
.LC220:
	.string	"players/female/w_glauncher.md2"
	.align 2
.LC221:
	.string	"players/female/w_grapple.md2"
	.align 2
.LC222:
	.string	"players/female/w_hyperblaster.md2"
	.align 2
.LC223:
	.string	"players/female/w_machinegun.md2"
	.align 2
.LC224:
	.string	"players/female/w_railgun.md2"
	.align 2
.LC225:
	.string	"players/female/w_rlauncher.md2"
	.align 2
.LC226:
	.string	"players/female/w_shotgun.md2"
	.align 2
.LC227:
	.string	"players/female/w_sshotgun.md2"
	.align 2
.LC228:
	.string	"m"
	.align 2
.LC229:
	.string	"mmnmmommommnonmmonqnmmo"
	.align 2
.LC230:
	.string	"abcdefghijklmnopqrstuvwxyzyxwvutsrqponmlkjihgfedcba"
	.align 2
.LC231:
	.string	"mmmmmaaaaammmmmaaaaaabcdefgabcdefg"
	.align 2
.LC232:
	.string	"mamamamamama"
	.align 2
.LC233:
	.string	"jklmnopqrstuvwxyzyxwvutsrqponmlkj"
	.align 2
.LC234:
	.string	"nmonqnmomnmomomno"
	.align 2
.LC235:
	.string	"mmmaaaabcdefgmmmmaaaammmaamm"
	.align 2
.LC236:
	.string	"mmmaaammmaaammmabcdefaaaammmmabcdefmmmaaaa"
	.align 2
.LC237:
	.string	"aaaaaaaazzzzzzzz"
	.align 2
.LC238:
	.string	"mmamammmmammamamaaamammma"
	.align 2
.LC239:
	.string	"abcdefghijklmnopqrrqponmlkjihgfedcba"
	.align 2
.LC240:
	.string	"a"
	.align 2
.LC241:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_worldspawn
	.type	 SP_worldspawn,@function
SP_worldspawn:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	li 0,2
	li 10,1
	li 11,3
	stw 0,260(31)
	lis 9,num_dm_spots@ha
	stw 10,40(31)
	li 0,0
	stw 11,248(31)
	stw 10,88(31)
	stw 0,num_dm_spots@l(9)
	bl InitBodyQue
	bl SetItemNames
	lis 9,st+20@ha
	lwz 4,st+20@l(9)
	cmpwi 0,4,0
	bc 12,2,.L142
	lis 3,level+136@ha
	la 3,level+136@l(3)
	bl strcpy
.L142:
	lwz 4,276(31)
	cmpwi 0,4,0
	bc 12,2,.L143
	lbz 0,0(4)
	cmpwi 0,0,0
	bc 12,2,.L143
	lis 9,gi+24@ha
	li 3,0
	lwz 0,gi+24@l(9)
	mtlr 0
	blrl
	lis 3,level+8@ha
	lwz 4,276(31)
	li 5,64
	la 3,level+8@l(3)
	bl strncpy
	b .L144
.L143:
	lis 3,level+8@ha
	li 5,64
	la 3,level+8@l(3)
	addi 4,3,64
	bl strncpy
.L144:
	lis 9,st@ha
	lwz 4,st@l(9)
	cmpwi 0,4,0
	bc 12,2,.L145
	lbz 0,0(4)
	cmpwi 0,0,0
	bc 12,2,.L145
	lis 9,gi+24@ha
	li 3,2
	lwz 0,gi+24@l(9)
	mtlr 0
	blrl
	b .L146
.L145:
	lis 9,gi+24@ha
	lis 4,.LC116@ha
	lwz 0,gi+24@l(9)
	la 4,.LC116@l(4)
	li 3,2
	mtlr 0
	blrl
.L146:
	lis 29,st@ha
	lis 9,gi@ha
	la 29,st@l(29)
	lis 3,.LC92@ha
	lfs 1,4(29)
	la 30,gi@l(9)
	la 3,.LC92@l(3)
	lis 28,.LC117@ha
	creqv 6,6,6
	bl va
	lwz 9,24(30)
	mr 4,3
	li 3,4
	mtlr 9
	blrl
	lfs 3,16(29)
	lis 3,.LC86@ha
	lfs 1,8(29)
	la 3,.LC86@l(3)
	lfs 2,12(29)
	creqv 6,6,6
	bl va
	lwz 9,24(30)
	mr 4,3
	li 3,3
	mtlr 9
	blrl
	lwz 4,528(31)
	la 3,.LC117@l(28)
	crxor 6,6,6
	bl va
	lwz 9,24(30)
	mr 4,3
	li 3,1
	mtlr 9
	blrl
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	la 3,.LC117@l(28)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 4,12(1)
	crxor 6,6,6
	bl va
	lwz 9,24(30)
	mr 4,3
	li 3,30
	mtlr 9
	blrl
	lis 9,.LC241@ha
	la 9,.LC241@l(9)
	lfs 13,0(9)
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L147
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L149
	lwz 0,24(30)
	lis 9,niq_dm_statusbar@ha
	li 3,5
	lwz 4,niq_dm_statusbar@l(9)
	mtlr 0
	blrl
	b .L149
.L147:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L149
	lwz 0,24(30)
	lis 9,dm_statusbar@ha
	li 3,5
	lwz 4,dm_statusbar@l(9)
	mtlr 0
	blrl
.L149:
	lis 3,.LC118@ha
	la 3,.LC118@l(3)
	bl FindItem
	lis 9,item_shells@ha
	lis 11,.LC119@ha
	stw 3,item_shells@l(9)
	la 3,.LC119@l(11)
	bl FindItem
	lis 9,item_cells@ha
	lis 11,.LC120@ha
	stw 3,item_cells@l(9)
	la 3,.LC120@l(11)
	bl FindItem
	lis 9,item_bullets@ha
	lis 11,.LC121@ha
	stw 3,item_bullets@l(9)
	la 3,.LC121@l(11)
	bl FindItem
	lis 9,item_rockets@ha
	lis 11,.LC122@ha
	stw 3,item_rockets@l(9)
	la 3,.LC122@l(11)
	bl FindItem
	lis 9,item_slugs@ha
	lis 11,.LC123@ha
	stw 3,item_slugs@l(9)
	la 3,.LC123@l(11)
	bl FindItem
	lis 9,item_grenades@ha
	lis 11,.LC124@ha
	stw 3,item_grenades@l(9)
	la 3,.LC124@l(11)
	bl FindItem
	lis 9,item_blaster@ha
	lis 11,.LC125@ha
	stw 3,item_blaster@l(9)
	la 3,.LC125@l(11)
	bl FindItem
	lis 9,item_shotgun@ha
	lis 11,.LC126@ha
	stw 3,item_shotgun@l(9)
	la 3,.LC126@l(11)
	bl FindItem
	lis 9,item_supershotgun@ha
	lis 11,.LC127@ha
	stw 3,item_supershotgun@l(9)
	la 3,.LC127@l(11)
	bl FindItem
	lis 9,item_machinegun@ha
	lis 11,.LC128@ha
	stw 3,item_machinegun@l(9)
	la 3,.LC128@l(11)
	bl FindItem
	lis 9,item_chaingun@ha
	lis 11,.LC129@ha
	stw 3,item_chaingun@l(9)
	la 3,.LC129@l(11)
	bl FindItem
	lis 9,item_grenadelauncher@ha
	lis 11,.LC130@ha
	stw 3,item_grenadelauncher@l(9)
	la 3,.LC130@l(11)
	bl FindItem
	lis 9,item_rocketlauncher@ha
	lis 11,.LC131@ha
	stw 3,item_rocketlauncher@l(9)
	la 3,.LC131@l(11)
	bl FindItem
	lis 9,item_railgun@ha
	lis 11,.LC132@ha
	stw 3,item_railgun@l(9)
	la 3,.LC132@l(11)
	bl FindItem
	lis 9,item_hyperblaster@ha
	lis 11,.LC133@ha
	stw 3,item_hyperblaster@l(9)
	la 3,.LC133@l(11)
	bl FindItem
	lis 9,gi@ha
	lis 11,item_bfg10k@ha
	la 31,gi@l(9)
	stw 3,item_bfg10k@l(11)
	lwz 9,40(31)
	lis 3,.LC134@ha
	la 3,.LC134@l(3)
	mtlr 9
	blrl
	lwz 9,40(31)
	lis 3,.LC135@ha
	la 3,.LC135@l(3)
	mtlr 9
	blrl
	lwz 10,40(31)
	lis 9,level+264@ha
	lis 11,.LC136@ha
	stw 3,level+264@l(9)
	mtlr 10
	la 3,.LC136@l(11)
	blrl
	lwz 9,40(31)
	lis 3,.LC137@ha
	la 3,.LC137@l(3)
	mtlr 9
	blrl
	lis 9,st+48@ha
	lwz 4,st+48@l(9)
	cmpwi 0,4,0
	bc 4,2,.L151
	lwz 0,148(31)
	lis 3,.LC138@ha
	lis 4,.LC139@ha
	la 3,.LC138@l(3)
	la 4,.LC139@l(4)
	mtlr 0
	blrl
	b .L152
.L151:
	lwz 0,148(31)
	lis 3,.LC138@ha
	la 3,.LC138@l(3)
	mtlr 0
	blrl
.L152:
	lis 9,gi@ha
	lis 3,.LC140@ha
	la 29,gi@l(9)
	la 3,.LC140@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,snd_fry@ha
	lis 11,.LC141@ha
	stw 3,snd_fry@l(9)
	la 3,.LC141@l(11)
	bl FindItem
	bl PrecacheItem
	lwz 9,36(29)
	lis 3,.LC142@ha
	la 3,.LC142@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC143@ha
	la 3,.LC143@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC144@ha
	la 3,.LC144@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC145@ha
	la 3,.LC145@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC146@ha
	la 3,.LC146@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC147@ha
	la 3,.LC147@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC148@ha
	la 3,.LC148@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC149@ha
	la 3,.LC149@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC150@ha
	la 3,.LC150@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC151@ha
	la 3,.LC151@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC152@ha
	la 3,.LC152@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC153@ha
	la 3,.LC153@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC154@ha
	la 3,.LC154@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC155@ha
	la 3,.LC155@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC156@ha
	la 3,.LC156@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC157@ha
	la 3,.LC157@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC158@ha
	la 3,.LC158@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC159@ha
	la 3,.LC159@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC160@ha
	la 3,.LC160@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC161@ha
	la 3,.LC161@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC162@ha
	la 3,.LC162@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC163@ha
	la 3,.LC163@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC164@ha
	la 3,.LC164@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC165@ha
	la 3,.LC165@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC166@ha
	la 3,.LC166@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC167@ha
	la 3,.LC167@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC168@ha
	la 3,.LC168@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC169@ha
	la 3,.LC169@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC170@ha
	la 3,.LC170@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC171@ha
	la 3,.LC171@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC172@ha
	la 3,.LC172@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC173@ha
	la 3,.LC173@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC174@ha
	la 3,.LC174@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC175@ha
	la 3,.LC175@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC176@ha
	la 3,.LC176@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC177@ha
	la 3,.LC177@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC178@ha
	la 3,.LC178@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC179@ha
	la 3,.LC179@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC180@ha
	la 3,.LC180@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC181@ha
	la 3,.LC181@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC182@ha
	la 3,.LC182@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC183@ha
	la 3,.LC183@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC184@ha
	la 3,.LC184@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC185@ha
	la 3,.LC185@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC186@ha
	la 3,.LC186@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC187@ha
	la 3,.LC187@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC188@ha
	la 3,.LC188@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC189@ha
	la 3,.LC189@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC190@ha
	la 3,.LC190@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC191@ha
	la 3,.LC191@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC192@ha
	la 3,.LC192@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC193@ha
	la 3,.LC193@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC194@ha
	la 3,.LC194@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC195@ha
	la 3,.LC195@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC196@ha
	la 3,.LC196@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC197@ha
	la 3,.LC197@l(3)
	mtlr 9
	blrl
	lwz 10,32(29)
	lis 9,sm_meat_index@ha
	lis 11,.LC198@ha
	stw 3,sm_meat_index@l(9)
	la 3,.LC198@l(11)
	mtlr 10
	blrl
	lwz 9,32(29)
	lis 3,.LC199@ha
	la 3,.LC199@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC200@ha
	la 3,.LC200@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC201@ha
	la 3,.LC201@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC202@ha
	la 3,.LC202@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC203@ha
	la 3,.LC203@l(3)
	mtlr 9
	blrl
	lis 9,.LC241@ha
	lis 11,view_weapons@ha
	la 9,.LC241@l(9)
	lfs 13,0(9)
	lwz 9,view_weapons@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L153
	lwz 9,32(29)
	lis 3,.LC204@ha
	la 3,.LC204@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC205@ha
	la 3,.LC205@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC206@ha
	la 3,.LC206@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC207@ha
	la 3,.LC207@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC208@ha
	la 3,.LC208@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC209@ha
	la 3,.LC209@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC210@ha
	la 3,.LC210@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC211@ha
	la 3,.LC211@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC212@ha
	la 3,.LC212@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC213@ha
	la 3,.LC213@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC214@ha
	la 3,.LC214@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC215@ha
	la 3,.LC215@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC216@ha
	la 3,.LC216@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC217@ha
	la 3,.LC217@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC218@ha
	la 3,.LC218@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC219@ha
	la 3,.LC219@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC220@ha
	la 3,.LC220@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC221@ha
	la 3,.LC221@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC222@ha
	la 3,.LC222@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC223@ha
	la 3,.LC223@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC224@ha
	la 3,.LC224@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC225@ha
	la 3,.LC225@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC226@ha
	la 3,.LC226@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC227@ha
	la 3,.LC227@l(3)
	mtlr 9
	blrl
.L153:
	lwz 9,24(29)
	lis 4,.LC228@ha
	li 3,800
	la 4,.LC228@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC229@ha
	li 3,801
	la 4,.LC229@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC230@ha
	li 3,802
	la 4,.LC230@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC231@ha
	li 3,803
	la 4,.LC231@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC232@ha
	li 3,804
	la 4,.LC232@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC233@ha
	li 3,805
	la 4,.LC233@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC234@ha
	li 3,806
	la 4,.LC234@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC235@ha
	li 3,807
	la 4,.LC235@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC236@ha
	li 3,808
	la 4,.LC236@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC237@ha
	li 3,809
	la 4,.LC237@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC238@ha
	li 3,810
	la 4,.LC238@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC239@ha
	li 3,811
	la 4,.LC239@l(4)
	mtlr 9
	blrl
	lwz 0,24(29)
	lis 4,.LC240@ha
	li 3,863
	la 4,.LC240@l(4)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 SP_worldspawn,.Lfe5-SP_worldspawn
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
	.align 2
	.globl ED_CallSpawn
	.type	 ED_CallSpawn,@function
ED_CallSpawn:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	lwz 0,280(30)
	cmpwi 0,0,0
	bc 4,2,.L7
	lis 9,gi+4@ha
	lis 3,.LC85@ha
	lwz 0,gi+4@l(9)
	la 3,.LC85@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L154:
	mr 3,30
	mr 4,31
	bl SpawnItem
	b .L6
.L155:
	lwz 0,4(31)
	mr 3,30
	mtlr 0
	blrl
	b .L6
.L7:
	lis 9,game@ha
	li 29,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,29,0
	bc 4,0,.L9
	mr 28,9
.L11:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L10
	lwz 4,280(30)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L154
.L10:
	lwz 0,1556(28)
	addi 29,29,1
	addi 31,31,72
	cmpw 0,29,0
	bc 12,0,.L11
.L9:
	lis 9,spawns@ha
	lwz 0,spawns@l(9)
	la 31,spawns@l(9)
	cmpwi 0,0,0
	bc 12,2,.L6
.L18:
	lwz 3,0(31)
	lwz 4,280(30)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L155
	lwzu 0,8(31)
	cmpwi 0,0,0
	bc 4,2,.L18
.L6:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 ED_CallSpawn,.Lfe6-ED_CallSpawn
	.align 2
	.globl ED_NewString
	.type	 ED_NewString,@function
ED_NewString:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	bl strlen
	lis 9,gi+132@ha
	mr 29,3
	lwz 0,gi+132@l(9)
	addi 30,29,1
	li 4,766
	mr 3,30
	mtlr 0
	blrl
	li 11,0
	mr 7,3
	cmpw 0,11,30
	mr 9,7
	bc 4,0,.L23
	mr 3,29
	li 6,10
.L25:
	lbzx 0,31,11
	rlwinm 10,0,0,0xff
	mr 8,0
	cmpwi 0,10,92
	bc 4,2,.L26
	cmpw 0,11,3
	bc 4,0,.L26
	addi 11,11,1
	lbzx 0,31,11
	cmpwi 0,0,110
	bc 4,2,.L27
	stb 6,0(9)
	b .L156
.L27:
	stb 10,0(9)
	b .L156
.L26:
	stb 8,0(9)
.L156:
	addi 9,9,1
	addi 11,11,1
	cmpw 0,11,30
	bc 12,0,.L25
.L23:
	mr 3,7
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 ED_NewString,.Lfe7-ED_NewString
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
