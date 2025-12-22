	.file	"g_spawn.c"
gcc2_compiled.:
	.globl spawns
	.section	".data"
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
	.long SP_func_plat
	.long .LC9
	.long SP_func_button
	.long .LC10
	.long SP_func_door
	.long .LC11
	.long SP_func_door_secret
	.long .LC12
	.long SP_func_door_rotating
	.long .LC13
	.long SP_func_rotating
	.long .LC14
	.long SP_func_train
	.long .LC15
	.long SP_func_water
	.long .LC16
	.long SP_func_conveyor
	.long .LC17
	.long SP_func_areaportal
	.long .LC18
	.long SP_func_clock
	.long .LC19
	.long SP_func_wall
	.long .LC20
	.long SP_func_object
	.long .LC21
	.long SP_func_timer
	.long .LC22
	.long SP_func_explosive
	.long .LC23
	.long SP_func_killbox
	.long .LC24
	.long SP_trigger_always
	.long .LC25
	.long SP_trigger_once
	.long .LC26
	.long SP_trigger_multiple
	.long .LC27
	.long SP_trigger_relay
	.long .LC28
	.long SP_trigger_push
	.long .LC29
	.long SP_trigger_hurt
	.long .LC30
	.long SP_trigger_key
	.long .LC31
	.long SP_trigger_counter
	.long .LC32
	.long SP_trigger_elevator
	.long .LC33
	.long SP_trigger_gravity
	.long .LC34
	.long SP_trigger_monsterjump
	.long .LC35
	.long SP_target_temp_entity
	.long .LC36
	.long SP_target_speaker
	.long .LC37
	.long SP_target_explosion
	.long .LC38
	.long SP_target_changelevel
	.long .LC39
	.long SP_target_secret
	.long .LC40
	.long SP_target_goal
	.long .LC41
	.long SP_target_splash
	.long .LC42
	.long SP_target_spawner
	.long .LC43
	.long SP_target_blaster
	.long .LC44
	.long SP_target_crosslevel_trigger
	.long .LC45
	.long SP_target_crosslevel_target
	.long .LC46
	.long SP_target_laser
	.long .LC47
	.long SP_target_help
	.long .LC48
	.long SP_target_actor
	.long .LC49
	.long SP_target_lightramp
	.long .LC50
	.long SP_target_earthquake
	.long .LC51
	.long SP_target_character
	.long .LC52
	.long SP_target_string
	.long .LC53
	.long SP_worldspawn
	.long .LC54
	.long SP_viewthing
	.long .LC55
	.long SP_light
	.long .LC56
	.long SP_light_mine1
	.long .LC57
	.long SP_light_mine2
	.long .LC58
	.long SP_info_null
	.long .LC59
	.long SP_info_null
	.long .LC60
	.long SP_info_notnull
	.long .LC61
	.long SP_path_corner
	.long .LC62
	.long SP_point_combat
	.long .LC63
	.long SP_misc_explobox
	.long .LC64
	.long SP_misc_banner
	.long .LC65
	.long SP_misc_satellite_dish
	.long .LC66
	.long SP_misc_actor
	.long .LC67
	.long SP_misc_gib_arm
	.long .LC68
	.long SP_misc_gib_leg
	.long .LC69
	.long SP_misc_gib_head
	.long .LC70
	.long SP_misc_insane
	.long .LC71
	.long SP_misc_deadsoldier
	.long .LC72
	.long SP_misc_viper
	.long .LC73
	.long SP_misc_viper_bomb
	.long .LC74
	.long SP_misc_bigviper
	.long .LC75
	.long SP_misc_strogg_ship
	.long .LC76
	.long SP_misc_teleporter
	.long .LC77
	.long SP_misc_teleporter_dest
	.long .LC78
	.long SP_misc_blackhole
	.long .LC79
	.long SP_misc_eastertank
	.long .LC80
	.long SP_misc_easterchick
	.long .LC81
	.long SP_misc_easterchick2
	.long .LC82
	.long SP_monster_berserk
	.long .LC83
	.long SP_monster_gladiator
	.long .LC84
	.long SP_monster_gunner
	.long .LC85
	.long SP_monster_infantry
	.long .LC86
	.long SP_monster_soldier_light
	.long .LC87
	.long SP_monster_soldier
	.long .LC88
	.long SP_monster_soldier_ss
	.long .LC89
	.long SP_monster_tank
	.long .LC90
	.long SP_monster_tank
	.long .LC91
	.long SP_monster_medic
	.long .LC92
	.long SP_monster_flipper
	.long .LC93
	.long SP_monster_chick
	.long .LC94
	.long SP_monster_parasite
	.long .LC95
	.long SP_monster_flyer
	.long .LC96
	.long SP_monster_brain
	.long .LC97
	.long SP_monster_floater
	.long .LC98
	.long SP_monster_hover
	.long .LC99
	.long SP_monster_mutant
	.long .LC100
	.long SP_monster_supertank
	.long .LC101
	.long SP_monster_boss2
	.long .LC102
	.long SP_monster_boss3_stand
	.long .LC103
	.long SP_monster_jorg
	.long .LC104
	.long SP_monster_commander_body
	.long .LC105
	.long SP_turret_breach
	.long .LC106
	.long SP_turret_base
	.long .LC107
	.long SP_turret_driver
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC107:
	.string	"turret_driver"
	.align 2
.LC106:
	.string	"turret_base"
	.align 2
.LC105:
	.string	"turret_breach"
	.align 2
.LC104:
	.string	"monster_commander_body"
	.align 2
.LC103:
	.string	"monster_jorg"
	.align 2
.LC102:
	.string	"monster_boss3_stand"
	.align 2
.LC101:
	.string	"monster_boss2"
	.align 2
.LC100:
	.string	"monster_supertank"
	.align 2
.LC99:
	.string	"monster_mutant"
	.align 2
.LC98:
	.string	"monster_hover"
	.align 2
.LC97:
	.string	"monster_floater"
	.align 2
.LC96:
	.string	"monster_brain"
	.align 2
.LC95:
	.string	"monster_flyer"
	.align 2
.LC94:
	.string	"monster_parasite"
	.align 2
.LC93:
	.string	"monster_chick"
	.align 2
.LC92:
	.string	"monster_flipper"
	.align 2
.LC91:
	.string	"monster_medic"
	.align 2
.LC90:
	.string	"monster_tank_commander"
	.align 2
.LC89:
	.string	"monster_tank"
	.align 2
.LC88:
	.string	"monster_soldier_ss"
	.align 2
.LC87:
	.string	"monster_soldier"
	.align 2
.LC86:
	.string	"monster_soldier_light"
	.align 2
.LC85:
	.string	"monster_infantry"
	.align 2
.LC84:
	.string	"monster_gunner"
	.align 2
.LC83:
	.string	"monster_gladiator"
	.align 2
.LC82:
	.string	"monster_berserk"
	.align 2
.LC81:
	.string	"misc_easterchick2"
	.align 2
.LC80:
	.string	"misc_easterchick"
	.align 2
.LC79:
	.string	"misc_eastertank"
	.align 2
.LC78:
	.string	"misc_blackhole"
	.align 2
.LC77:
	.string	"misc_teleporter_dest"
	.align 2
.LC76:
	.string	"misc_teleporter"
	.align 2
.LC75:
	.string	"misc_strogg_ship"
	.align 2
.LC74:
	.string	"misc_bigviper"
	.align 2
.LC73:
	.string	"misc_viper_bomb"
	.align 2
.LC72:
	.string	"misc_viper"
	.align 2
.LC71:
	.string	"misc_deadsoldier"
	.align 2
.LC70:
	.string	"misc_insane"
	.align 2
.LC69:
	.string	"misc_gib_head"
	.align 2
.LC68:
	.string	"misc_gib_leg"
	.align 2
.LC67:
	.string	"misc_gib_arm"
	.align 2
.LC66:
	.string	"misc_actor"
	.align 2
.LC65:
	.string	"misc_satellite_dish"
	.align 2
.LC64:
	.string	"misc_banner"
	.align 2
.LC63:
	.string	"misc_explobox"
	.align 2
.LC62:
	.string	"point_combat"
	.align 2
.LC61:
	.string	"path_corner"
	.align 2
.LC60:
	.string	"info_notnull"
	.align 2
.LC59:
	.string	"func_group"
	.align 2
.LC58:
	.string	"info_null"
	.align 2
.LC57:
	.string	"light_mine2"
	.align 2
.LC56:
	.string	"light_mine1"
	.align 2
.LC55:
	.string	"light"
	.align 2
.LC54:
	.string	"viewthing"
	.align 2
.LC53:
	.string	"worldspawn"
	.align 2
.LC52:
	.string	"target_string"
	.align 2
.LC51:
	.string	"target_character"
	.align 2
.LC50:
	.string	"target_earthquake"
	.align 2
.LC49:
	.string	"target_lightramp"
	.align 2
.LC48:
	.string	"target_actor"
	.align 2
.LC47:
	.string	"target_help"
	.align 2
.LC46:
	.string	"target_laser"
	.align 2
.LC45:
	.string	"target_crosslevel_target"
	.align 2
.LC44:
	.string	"target_crosslevel_trigger"
	.align 2
.LC43:
	.string	"target_blaster"
	.align 2
.LC42:
	.string	"target_spawner"
	.align 2
.LC41:
	.string	"target_splash"
	.align 2
.LC40:
	.string	"target_goal"
	.align 2
.LC39:
	.string	"target_secret"
	.align 2
.LC38:
	.string	"target_changelevel"
	.align 2
.LC37:
	.string	"target_explosion"
	.align 2
.LC36:
	.string	"target_speaker"
	.align 2
.LC35:
	.string	"target_temp_entity"
	.align 2
.LC34:
	.string	"trigger_monsterjump"
	.align 2
.LC33:
	.string	"trigger_gravity"
	.align 2
.LC32:
	.string	"trigger_elevator"
	.align 2
.LC31:
	.string	"trigger_counter"
	.align 2
.LC30:
	.string	"trigger_key"
	.align 2
.LC29:
	.string	"trigger_hurt"
	.align 2
.LC28:
	.string	"trigger_push"
	.align 2
.LC27:
	.string	"trigger_relay"
	.align 2
.LC26:
	.string	"trigger_multiple"
	.align 2
.LC25:
	.string	"trigger_once"
	.align 2
.LC24:
	.string	"trigger_always"
	.align 2
.LC23:
	.string	"func_killbox"
	.align 2
.LC22:
	.string	"func_explosive"
	.align 2
.LC21:
	.string	"func_timer"
	.align 2
.LC20:
	.string	"func_object"
	.align 2
.LC19:
	.string	"func_wall"
	.align 2
.LC18:
	.string	"func_clock"
	.align 2
.LC17:
	.string	"func_areaportal"
	.align 2
.LC16:
	.string	"func_conveyor"
	.align 2
.LC15:
	.string	"func_water"
	.align 2
.LC14:
	.string	"func_train"
	.align 2
.LC13:
	.string	"func_rotating"
	.align 2
.LC12:
	.string	"func_door_rotating"
	.align 2
.LC11:
	.string	"func_door_secret"
	.align 2
.LC10:
	.string	"func_door"
	.align 2
.LC9:
	.string	"func_button"
	.align 2
.LC8:
	.string	"func_plat"
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
	.size	 spawns,872
	.align 2
.LC108:
	.string	"ED_CallSpawn: NULL classname\n"
	.align 2
.LC109:
	.string	"%s doesn't have a spawn function\n"
	.align 2
.LC110:
	.string	"%f %f %f"
	.align 2
.LC111:
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
	mr 28,5
	la 29,fields@l(9)
	cmpwi 0,0,0
	bc 12,2,.L33
.L35:
	lwz 0,12(29)
	andi. 9,0,2
	bc 4,2,.L34
	lwz 3,0(29)
	mr 4,31
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L34
	lwz 0,12(29)
	andi. 9,0,1
	bc 12,2,.L37
	lis 9,st@ha
	la 27,st@l(9)
	b .L38
.L37:
	mr 27,28
.L38:
	lwz 10,8(29)
	cmplwi 0,10,11
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
	.long .L31-.L56
	.long .L31-.L56
.L40:
	mr 3,30
	bl strlen
	lis 9,gi+132@ha
	mr 31,3
	lwz 0,gi+132@l(9)
	addi 28,31,1
	li 4,766
	mr 3,28
	mtlr 0
	blrl
	li 10,0
	mr 7,3
	cmpw 0,10,28
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
	cmpw 0,10,28
	bc 12,0,.L43
.L49:
	lwz 0,4(29)
	stwx 7,27,0
	b .L31
.L51:
	lis 4,.LC110@ha
	mr 3,30
	la 4,.LC110@l(4)
	addi 5,1,8
	addi 6,1,12
	addi 7,1,16
	crxor 6,6,6
	bl sscanf
	lfs 0,8(1)
	lwz 0,4(29)
	stfsx 0,27,0
	lwz 9,4(29)
	lfs 0,12(1)
	add 9,27,9
	stfs 0,4(9)
	lwz 11,4(29)
	lfs 0,16(1)
	add 11,27,11
	stfs 0,8(11)
	b .L31
.L52:
	mr 3,30
	bl atoi
	lwz 0,4(29)
	stwx 3,27,0
	b .L31
.L53:
	mr 3,30
	bl atof
	frsp 1,1
	lwz 0,4(29)
	stfsx 1,27,0
	b .L31
.L54:
	mr 3,30
	bl atof
	lwz 0,4(29)
	li 10,0
	frsp 1,1
	stwx 10,27,0
	lwz 9,4(29)
	add 9,27,9
	stfs 1,4(9)
	lwz 11,4(29)
	add 11,27,11
	stw 10,8(11)
	b .L31
.L34:
	lwzu 0,16(29)
	cmpwi 0,0,0
	bc 4,2,.L35
.L33:
	lis 9,gi+4@ha
	lis 3,.LC111@ha
	lwz 0,gi+4@l(9)
	la 3,.LC111@l(3)
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
.LC112:
	.string	"ED_ParseEntity: EOF without closing brace"
	.align 2
.LC113:
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
	lis 3,.LC112@ha
	lwz 0,gi+28@l(9)
	la 3,.LC112@l(3)
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
	lis 3,.LC112@ha
	lwz 0,gi+28@l(9)
	la 3,.LC112@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L66:
	lbz 0,0(31)
	cmpwi 0,0,125
	bc 4,2,.L67
	lis 9,gi+28@ha
	lis 3,.LC113@ha
	lwz 0,gi+28@l(9)
	la 3,.LC113@l(3)
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
	li 5,900
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
.LC114:
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
	addi 30,9,900
	bc 4,0,.L73
	mr 23,8
	lis 21,globals@ha
.L75:
	lwz 0,88(30)
	addi 27,10,1
	addi 25,30,900
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
	addi 31,31,900
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
	lis 3,.LC114@ha
	lwz 0,gi+4@l(9)
	la 3,.LC114@l(3)
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
.LC115:
	.string	"skill"
	.align 2
.LC116:
	.string	"%f"
	.align 2
.LC117:
	.string	"ED_LoadFromFile: found %s when expecting {"
	.align 2
.LC118:
	.string	"command"
	.align 2
.LC119:
	.string	"*27"
	.align 2
.LC120:
	.string	"%i entities inhibited\n"
	.align 2
.LC121:
	.long 0x0
	.align 2
.LC122:
	.long 0x40400000
	.align 2
.LC123:
	.long 0x3f800000
	.align 2
.LC124:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl SpawnEntities
	.type	 SpawnEntities,@function
SpawnEntities:
	stwu 1,-64(1)
	mflr 0
	stmw 22,24(1)
	stw 0,68(1)
	lis 9,skill@ha
	stw 4,8(1)
	mr 28,3
	lwz 11,skill@l(9)
	mr 27,5
	lis 24,skill@ha
	lfs 1,20(11)
	bl floor
	lis 9,.LC121@ha
	frsp 1,1
	la 9,.LC121@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L90
	lis 11,.LC121@ha
	la 11,.LC121@l(11)
	lfs 1,0(11)
.L90:
	lis 9,.LC122@ha
	la 9,.LC122@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,1,.L91
	lis 11,.LC122@ha
	la 11,.LC122@l(11)
	lfs 1,0(11)
.L91:
	lwz 9,skill@l(24)
	lfs 0,20(9)
	fcmpu 0,0,1
	bc 12,2,.L92
	lis 3,.LC116@ha
	lis 29,gi@ha
	la 29,gi@l(29)
	la 3,.LC116@l(3)
	creqv 6,6,6
	bl va
	mr 4,3
	lwz 0,152(29)
	lis 3,.LC115@ha
	la 3,.LC115@l(3)
	mtlr 0
	blrl
.L92:
	bl SaveClientData
	lis 22,game@ha
	lis 25,g_edicts@ha
	lis 9,gi+140@ha
	li 3,766
	lwz 0,gi+140@l(9)
	addi 23,1,8
	mtlr 0
	blrl
	lis 29,level@ha
	li 5,304
	la 29,level@l(29)
	li 4,0
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 9,game@ha
	lis 11,g_edicts@ha
	la 30,game@l(9)
	lwz 3,g_edicts@l(11)
	li 4,0
	lwz 5,1548(30)
	mulli 5,5,900
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
	bc 4,0,.L94
	lwz 9,g_edicts@l(25)
	mr 3,30
	li 10,0
	addi 9,9,984
.L96:
	lwz 0,1028(3)
	addi 11,11,1
	add 0,0,10
	stw 0,0(9)
	addi 10,10,3844
	lwz 0,1544(3)
	addi 9,9,900
	cmpw 0,11,0
	bc 12,0,.L96
.L94:
	lis 9,gi@ha
	li 30,0
	la 26,gi@l(9)
	li 27,0
	b .L100
.L101:
	lbz 0,0(4)
	cmpwi 0,0,123
	bc 12,2,.L102
	lwz 9,28(26)
	lis 3,.LC117@ha
	la 3,.LC117@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
.L102:
	cmpwi 0,30,0
	bc 4,2,.L103
	lwz 30,g_edicts@l(25)
	b .L104
.L103:
	bl G_Spawn
	mr 30,3
.L104:
	lwz 3,8(1)
	mr 4,30
	bl ED_ParseEdict
	stw 3,8(1)
	lis 4,.LC118@ha
	lis 3,level+72@ha
	la 4,.LC118@l(4)
	la 3,level+72@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L105
	lwz 3,280(30)
	lis 4,.LC25@ha
	la 4,.LC25@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L105
	lwz 3,268(30)
	lis 4,.LC119@ha
	la 4,.LC119@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L105
	lwz 0,284(30)
	rlwinm 0,0,0,22,20
	stw 0,284(30)
.L105:
	lwz 0,g_edicts@l(25)
	cmpw 0,30,0
	bc 12,2,.L106
	lis 11,.LC121@ha
	lis 9,deathmatch@ha
	la 11,.LC121@l(11)
	lfs 12,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L107
	lwz 0,284(30)
	andi. 9,0,2048
	b .L133
.L107:
	lwz 9,skill@l(24)
	lwz 0,284(30)
	lfs 13,20(9)
	fcmpu 0,13,12
	bc 4,2,.L112
	andi. 9,0,256
	bc 4,2,.L111
.L112:
	lis 11,.LC123@ha
	la 11,.LC123@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L113
	andi. 9,0,512
	bc 4,2,.L111
.L113:
	lis 11,.LC124@ha
	la 11,.LC124@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 12,2,.L114
	lis 9,.LC122@ha
	la 9,.LC122@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L109
.L114:
	andi. 11,0,1024
.L133:
	bc 12,2,.L109
.L111:
	mr 3,30
	addi 27,27,1
	bl G_FreeEdict
	b .L100
.L109:
	rlwinm 0,0,0,24,18
	stw 0,284(30)
.L106:
	lwz 0,280(30)
	cmpwi 0,0,0
	mr 4,0
	bc 4,2,.L115
	lwz 9,4(26)
	lis 3,.LC108@ha
	la 3,.LC108@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L100
.L131:
	mr 4,29
	mr 3,30
	bl SpawnItem
	b .L100
.L132:
	lwz 0,4(29)
	mr 3,30
	mtlr 0
	blrl
	b .L100
.L115:
	la 11,game@l(22)
	li 31,0
	lwz 0,1556(11)
	lis 9,itemlist@ha
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L123
	mr 28,11
.L119:
	lwz 3,0(29)
	cmpwi 0,3,0
	bc 12,2,.L121
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L131
.L121:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,76
	lwz 4,280(30)
	cmpw 0,31,0
	bc 12,0,.L119
.L123:
	lis 9,spawns@ha
	lwz 0,spawns@l(9)
	la 29,spawns@l(9)
	cmpwi 0,0,0
	bc 12,2,.L129
.L126:
	lwz 3,0(29)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L132
	lwzu 0,8(29)
	lwz 4,280(30)
	cmpwi 0,0,0
	bc 4,2,.L126
.L129:
	lwz 9,4(26)
	lis 3,.LC109@ha
	la 3,.LC109@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
.L100:
	mr 3,23
	bl COM_Parse
	lwz 0,8(1)
	mr 4,3
	cmpwi 0,0,0
	bc 4,2,.L101
	lis 9,gi+4@ha
	lis 3,.LC120@ha
	lwz 0,gi+4@l(9)
	la 3,.LC120@l(3)
	mr 4,27
	mtlr 0
	crxor 6,6,6
	blrl
	bl G_FindTeams
	bl PlayerTrail_Init
	lwz 0,68(1)
	mtlr 0
	lmw 22,24(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 SpawnEntities,.Lfe4-SpawnEntities
	.globl single_statusbar
	.section	".rodata"
	.align 2
.LC125:
	.ascii	"yb\t-24 xv\t0 hnum xv\t"
	.string	"50 pic 0 if 2 \txv\t100 \tanum \txv\t150 \tpic 2 endif if 4 \txv\t200 \trnum \txv\t250 \tpic 4 endif if 6 \txv\t296 \tpic 6 endif yb\t-50 if 7 \txv\t0 \tpic 7 \txv\t26 \tyb\t-42 \tstat_string 8 \tyb\t-50 endif if 9 \txv\t262 \tnum\t2\t10 \txv\t296 \tpic\t9 endif if 11 \txv\t148 \tpic\t11 endif "
	.section	".sdata","aw"
	.align 2
	.type	 single_statusbar,@object
	.size	 single_statusbar,4
single_statusbar:
	.long .LC125
	.globl dm_statusbar
	.section	".rodata"
	.align 2
.LC126:
	.ascii	"yb\t-24 xv\t0 hnum xv\t50 pic 0 if 2 \txv\t100 \tanum \txv\t"
	.ascii	"150 \tpic 2 endif if 4 \txv\t200 \trnum \txv\t250 \tpic 4 en"
	.ascii	"dif if 6 \txv\t296 \tpic 6 endif yb\t-50 if 7 \txv\t0 \tpic "
	.ascii	"7 \txv\t26 \tyb\t-4"
	.string	"2 \tstat_string 8 \tyb\t-50 endif if 9 \txv\t246 \tnum\t2\t10 \txv\t296 \tpic\t9 endif if 11 \txv\t148 \tpic\t11 endif xr\t-50 yt 2 num 3 14 if 17 xv 0 yb -58 string2 \"SPECTATOR MODE\" endif if 16 xv 0 yb -68 string \"Chasing\" xv 64 stat_string 16 endif xr -150 yt 2 num 2 18"
	.section	".sdata","aw"
	.align 2
	.type	 dm_statusbar,@object
	.size	 dm_statusbar,4
dm_statusbar:
	.long .LC126
	.section	".rodata"
	.align 2
.LC127:
	.string	"unit1_"
	.align 2
.LC128:
	.string	"%i"
	.align 2
.LC129:
	.string	"i_help"
	.align 2
.LC130:
	.string	"i_health"
	.align 2
.LC131:
	.string	"help"
	.align 2
.LC132:
	.string	"field_3"
	.align 2
.LC133:
	.string	"sv_gravity"
	.align 2
.LC134:
	.string	"800"
	.align 2
.LC135:
	.string	"player/fry.wav"
	.align 2
.LC136:
	.string	"Blaster"
	.align 2
.LC137:
	.string	"player/lava1.wav"
	.align 2
.LC138:
	.string	"player/lava2.wav"
	.align 2
.LC139:
	.string	"misc/pc_up.wav"
	.align 2
.LC140:
	.string	"misc/talk1.wav"
	.align 2
.LC141:
	.string	"misc/udeath.wav"
	.align 2
.LC142:
	.string	"items/respawn1.wav"
	.align 2
.LC143:
	.string	"*death1.wav"
	.align 2
.LC144:
	.string	"*death2.wav"
	.align 2
.LC145:
	.string	"*death3.wav"
	.align 2
.LC146:
	.string	"*death4.wav"
	.align 2
.LC147:
	.string	"*fall1.wav"
	.align 2
.LC148:
	.string	"*fall2.wav"
	.align 2
.LC149:
	.string	"*gurp1.wav"
	.align 2
.LC150:
	.string	"*gurp2.wav"
	.align 2
.LC151:
	.string	"*jump1.wav"
	.align 2
.LC152:
	.string	"*pain25_1.wav"
	.align 2
.LC153:
	.string	"*pain25_2.wav"
	.align 2
.LC154:
	.string	"*pain50_1.wav"
	.align 2
.LC155:
	.string	"*pain50_2.wav"
	.align 2
.LC156:
	.string	"*pain75_1.wav"
	.align 2
.LC157:
	.string	"*pain75_2.wav"
	.align 2
.LC158:
	.string	"*pain100_1.wav"
	.align 2
.LC159:
	.string	"*pain100_2.wav"
	.align 2
.LC160:
	.string	"#w_blaster.md2"
	.align 2
.LC161:
	.string	"#w_shotgun.md2"
	.align 2
.LC162:
	.string	"#w_sshotgun.md2"
	.align 2
.LC163:
	.string	"#w_machinegun.md2"
	.align 2
.LC164:
	.string	"#w_chaingun.md2"
	.align 2
.LC165:
	.string	"#a_grenades.md2"
	.align 2
.LC166:
	.string	"#w_glauncher.md2"
	.align 2
.LC167:
	.string	"#w_rlauncher.md2"
	.align 2
.LC168:
	.string	"#w_hyperblaster.md2"
	.align 2
.LC169:
	.string	"#w_railgun.md2"
	.align 2
.LC170:
	.string	"#w_bfg.md2"
	.align 2
.LC171:
	.string	"player/gasp1.wav"
	.align 2
.LC172:
	.string	"player/gasp2.wav"
	.align 2
.LC173:
	.string	"player/watr_in.wav"
	.align 2
.LC174:
	.string	"player/watr_out.wav"
	.align 2
.LC175:
	.string	"player/watr_un.wav"
	.align 2
.LC176:
	.string	"player/u_breath1.wav"
	.align 2
.LC177:
	.string	"player/u_breath2.wav"
	.align 2
.LC178:
	.string	"items/pkup.wav"
	.align 2
.LC179:
	.string	"world/land.wav"
	.align 2
.LC180:
	.string	"misc/h2ohit1.wav"
	.align 2
.LC181:
	.string	"items/damage.wav"
	.align 2
.LC182:
	.string	"items/protect.wav"
	.align 2
.LC183:
	.string	"items/protect4.wav"
	.align 2
.LC184:
	.string	"weapons/noammo.wav"
	.align 2
.LC185:
	.string	"infantry/inflies1.wav"
	.align 2
.LC186:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC187:
	.string	"models/objects/gibs/arm/tris.md2"
	.align 2
.LC188:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC189:
	.string	"models/objects/gibs/bone2/tris.md2"
	.align 2
.LC190:
	.string	"models/objects/gibs/chest/tris.md2"
	.align 2
.LC191:
	.string	"models/objects/gibs/skull/tris.md2"
	.align 2
.LC192:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC193:
	.string	"m"
	.align 2
.LC194:
	.string	"mmnmmommommnonmmonqnmmo"
	.align 2
.LC195:
	.string	"abcdefghijklmnopqrstuvwxyzyxwvutsrqponmlkjihgfedcba"
	.align 2
.LC196:
	.string	"mmmmmaaaaammmmmaaaaaabcdefgabcdefg"
	.align 2
.LC197:
	.string	"mamamamamama"
	.align 2
.LC198:
	.string	"jklmnopqrstuvwxyzyxwvutsrqponmlkj"
	.align 2
.LC199:
	.string	"nmonqnmomnmomomno"
	.align 2
.LC200:
	.string	"mmmaaaabcdefgmmmmaaaammmaamm"
	.align 2
.LC201:
	.string	"mmmaaammmaaammmabcdefaaaammmmabcdefmmmaaaa"
	.align 2
.LC202:
	.string	"aaaaaaaazzzzzzzz"
	.align 2
.LC203:
	.string	"mmamammmmammamamaaamammma"
	.align 2
.LC204:
	.string	"abcdefghijklmnopqrrqponmlkjihgfedcba"
	.align 2
.LC205:
	.string	"a"
	.align 2
.LC206:
	.long 0x41200000
	.align 2
.LC207:
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
	lis 9,Check@ha
	mr 31,3
	la 9,Check@l(9)
	li 8,1
	li 0,2
	li 10,3
	stw 9,436(31)
	lis 11,level@ha
	lis 7,.LC206@ha
	stw 8,40(31)
	stw 0,260(31)
	la 7,.LC206@l(7)
	la 29,level@l(11)
	stw 10,248(31)
	stw 8,88(31)
	lfs 13,0(7)
	lfs 0,4(29)
	fadds 0,0,13
	stfs 0,428(31)
	bl InitBodyQue
	bl SetItemNames
	lis 9,st+20@ha
	lwz 4,st+20@l(9)
	cmpwi 0,4,0
	bc 12,2,.L135
	addi 3,29,136
	bl strcpy
.L135:
	lwz 4,276(31)
	cmpwi 0,4,0
	bc 12,2,.L136
	lbz 0,0(4)
	cmpwi 0,0,0
	bc 12,2,.L136
	lis 9,gi+24@ha
	li 3,0
	lwz 0,gi+24@l(9)
	mtlr 0
	blrl
	lwz 4,276(31)
	addi 3,29,8
	li 5,64
	bl strncpy
	b .L137
.L136:
	lis 3,level+8@ha
	li 5,64
	la 3,level+8@l(3)
	addi 4,3,64
	bl strncpy
.L137:
	lis 9,st@ha
	lwz 4,st@l(9)
	cmpwi 0,4,0
	bc 12,2,.L138
	lbz 0,0(4)
	cmpwi 0,0,0
	bc 12,2,.L138
	lis 9,gi+24@ha
	li 3,2
	lwz 0,gi+24@l(9)
	mtlr 0
	blrl
	b .L139
.L138:
	lis 9,gi+24@ha
	lis 4,.LC127@ha
	lwz 0,gi+24@l(9)
	la 4,.LC127@l(4)
	li 3,2
	mtlr 0
	blrl
.L139:
	lis 29,st@ha
	lis 9,gi@ha
	la 29,st@l(29)
	lis 3,.LC116@ha
	lfs 1,4(29)
	la 30,gi@l(9)
	la 3,.LC116@l(3)
	lis 28,.LC128@ha
	creqv 6,6,6
	bl va
	lwz 9,24(30)
	mr 4,3
	li 3,4
	mtlr 9
	blrl
	lfs 3,16(29)
	lis 3,.LC110@ha
	lfs 1,8(29)
	la 3,.LC110@l(3)
	lfs 2,12(29)
	creqv 6,6,6
	bl va
	lwz 9,24(30)
	mr 4,3
	li 3,3
	mtlr 9
	blrl
	lwz 4,528(31)
	la 3,.LC128@l(28)
	crxor 6,6,6
	bl va
	lwz 9,24(30)
	mr 4,3
	li 3,1
	mtlr 9
	blrl
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	la 3,.LC128@l(28)
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
	lis 11,deathmatch@ha
	lis 7,.LC207@ha
	lwz 9,deathmatch@l(11)
	la 7,.LC207@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L140
	lwz 0,24(30)
	lis 9,dm_statusbar@ha
	li 3,5
	lwz 4,dm_statusbar@l(9)
	mtlr 0
	blrl
	b .L141
.L140:
	lwz 0,24(30)
	lis 9,single_statusbar@ha
	li 3,5
	lwz 4,single_statusbar@l(9)
	mtlr 0
	blrl
.L141:
	lis 9,gi@ha
	lis 3,.LC129@ha
	la 31,gi@l(9)
	la 3,.LC129@l(3)
	lwz 9,40(31)
	mtlr 9
	blrl
	lwz 9,40(31)
	lis 3,.LC130@ha
	la 3,.LC130@l(3)
	mtlr 9
	blrl
	lwz 10,40(31)
	lis 9,level+264@ha
	lis 11,.LC131@ha
	stw 3,level+264@l(9)
	mtlr 10
	la 3,.LC131@l(11)
	blrl
	lwz 9,40(31)
	lis 3,.LC132@ha
	la 3,.LC132@l(3)
	mtlr 9
	blrl
	lis 9,st+48@ha
	lwz 4,st+48@l(9)
	cmpwi 0,4,0
	bc 4,2,.L142
	lwz 0,148(31)
	lis 3,.LC133@ha
	lis 4,.LC134@ha
	la 3,.LC133@l(3)
	la 4,.LC134@l(4)
	mtlr 0
	blrl
	b .L143
.L142:
	lwz 0,148(31)
	lis 3,.LC133@ha
	la 3,.LC133@l(3)
	mtlr 0
	blrl
.L143:
	lis 29,gi@ha
	lis 3,.LC135@ha
	la 29,gi@l(29)
	la 3,.LC135@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,snd_fry@ha
	lis 11,.LC136@ha
	stw 3,snd_fry@l(9)
	la 3,.LC136@l(11)
	bl FindItem
	bl PrecacheItem
	lwz 9,36(29)
	lis 3,.LC137@ha
	la 3,.LC137@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC138@ha
	la 3,.LC138@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC139@ha
	la 3,.LC139@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC140@ha
	la 3,.LC140@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC141@ha
	la 3,.LC141@l(3)
	mtlr 9
	blrl
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
	lwz 9,32(29)
	lis 3,.LC160@ha
	la 3,.LC160@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC161@ha
	la 3,.LC161@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC162@ha
	la 3,.LC162@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC163@ha
	la 3,.LC163@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC164@ha
	la 3,.LC164@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC165@ha
	la 3,.LC165@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC166@ha
	la 3,.LC166@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC167@ha
	la 3,.LC167@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC168@ha
	la 3,.LC168@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC169@ha
	la 3,.LC169@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
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
	lwz 9,32(29)
	lis 3,.LC186@ha
	la 3,.LC186@l(3)
	mtlr 9
	blrl
	lwz 10,32(29)
	lis 9,sm_meat_index@ha
	lis 11,.LC187@ha
	stw 3,sm_meat_index@l(9)
	mtlr 10
	la 3,.LC187@l(11)
	blrl
	lwz 9,32(29)
	lis 3,.LC188@ha
	la 3,.LC188@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC189@ha
	la 3,.LC189@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC190@ha
	la 3,.LC190@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC191@ha
	la 3,.LC191@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC192@ha
	la 3,.LC192@l(3)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC193@ha
	li 3,800
	la 4,.LC193@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC194@ha
	li 3,801
	la 4,.LC194@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC195@ha
	li 3,802
	la 4,.LC195@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC196@ha
	li 3,803
	la 4,.LC196@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC197@ha
	li 3,804
	la 4,.LC197@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC198@ha
	li 3,805
	la 4,.LC198@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC199@ha
	li 3,806
	la 4,.LC199@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC200@ha
	li 3,807
	la 4,.LC200@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC201@ha
	li 3,808
	la 4,.LC201@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC202@ha
	li 3,809
	la 4,.LC202@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC203@ha
	li 3,810
	la 4,.LC203@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC204@ha
	li 3,811
	la 4,.LC204@l(4)
	mtlr 9
	blrl
	lwz 0,24(29)
	lis 4,.LC205@ha
	li 3,863
	la 4,.LC205@l(4)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 SP_worldspawn,.Lfe5-SP_worldspawn
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
	lis 3,.LC108@ha
	lwz 0,gi+4@l(9)
	la 3,.LC108@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L144:
	mr 3,30
	mr 4,31
	bl SpawnItem
	b .L6
.L145:
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
	bc 12,2,.L144
.L10:
	lwz 0,1556(28)
	addi 29,29,1
	addi 31,31,76
	cmpw 0,29,0
	bc 12,0,.L11
.L9:
	lis 9,spawns@ha
	lwz 0,spawns@l(9)
	la 31,spawns@l(9)
	cmpwi 0,0,0
	bc 12,2,.L16
.L18:
	lwz 3,0(31)
	lwz 4,280(30)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L145
	lwzu 0,8(31)
	cmpwi 0,0,0
	bc 4,2,.L18
.L16:
	lis 9,gi+4@ha
	lis 3,.LC109@ha
	lwz 4,280(30)
	lwz 0,gi+4@l(9)
	la 3,.LC109@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
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
	b .L146
.L27:
	stb 10,0(9)
	b .L146
.L26:
	stb 8,0(9)
.L146:
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
