	.file	"g_spawn.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 stuff_light,@object
	.size	 stuff_light,4
stuff_light:
	.long 1
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
	.long SP_target_lightramp
	.long .LC49
	.long SP_target_earthquake
	.long .LC50
	.long SP_target_character
	.long .LC51
	.long SP_target_string
	.long .LC52
	.long SP_worldspawn
	.long .LC53
	.long SP_viewthing
	.long .LC54
	.long SP_light
	.long .LC55
	.long SP_light_mine1
	.long .LC56
	.long SP_light_mine2
	.long .LC57
	.long SP_info_null
	.long .LC58
	.long SP_info_null
	.long .LC59
	.long SP_info_notnull
	.long .LC60
	.long SP_path_corner
	.long .LC61
	.long SP_point_combat
	.long .LC62
	.long SP_misc_explobox
	.long .LC63
	.long SP_misc_banner
	.long .LC64
	.long SP_misc_satellite_dish
	.long .LC65
	.long SP_misc_gib_arm
	.long .LC66
	.long SP_misc_gib_leg
	.long .LC67
	.long SP_misc_gib_head
	.long .LC68
	.long SP_misc_deadsoldier
	.long .LC69
	.long SP_misc_viper
	.long .LC70
	.long SP_misc_viper_bomb
	.long .LC71
	.long SP_misc_bigviper
	.long .LC72
	.long SP_misc_strogg_ship
	.long .LC73
	.long SP_misc_teleporter
	.long .LC74
	.long SP_misc_teleporter_dest
	.long .LC75
	.long SP_misc_blackhole
	.long .LC76
	.long SP_misc_eastertank
	.long .LC77
	.long SP_misc_easterchick
	.long .LC78
	.long SP_misc_easterchick2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC78:
	.string	"misc_easterchick2"
	.align 2
.LC77:
	.string	"misc_easterchick"
	.align 2
.LC76:
	.string	"misc_eastertank"
	.align 2
.LC75:
	.string	"misc_blackhole"
	.align 2
.LC74:
	.string	"misc_teleporter_dest"
	.align 2
.LC73:
	.string	"misc_teleporter"
	.align 2
.LC72:
	.string	"misc_strogg_ship"
	.align 2
.LC71:
	.string	"misc_bigviper"
	.align 2
.LC70:
	.string	"misc_viper_bomb"
	.align 2
.LC69:
	.string	"misc_viper"
	.align 2
.LC68:
	.string	"misc_deadsoldier"
	.align 2
.LC67:
	.string	"misc_gib_head"
	.align 2
.LC66:
	.string	"misc_gib_leg"
	.align 2
.LC65:
	.string	"misc_gib_arm"
	.align 2
.LC64:
	.string	"misc_satellite_dish"
	.align 2
.LC63:
	.string	"misc_banner"
	.align 2
.LC62:
	.string	"misc_explobox"
	.align 2
.LC61:
	.string	"point_combat"
	.align 2
.LC60:
	.string	"path_corner"
	.align 2
.LC59:
	.string	"info_notnull"
	.align 2
.LC58:
	.string	"func_group"
	.align 2
.LC57:
	.string	"info_null"
	.align 2
.LC56:
	.string	"light_mine2"
	.align 2
.LC55:
	.string	"light_mine1"
	.align 2
.LC54:
	.string	"light"
	.align 2
.LC53:
	.string	"viewthing"
	.align 2
.LC52:
	.string	"worldspawn"
	.align 2
.LC51:
	.string	"target_string"
	.align 2
.LC50:
	.string	"target_character"
	.align 2
.LC49:
	.string	"target_earthquake"
	.align 2
.LC48:
	.string	"target_lightramp"
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
	.size	 spawns,640
	.align 2
.LC79:
	.string	"ED_CallSpawn: NULL classname\n"
	.align 2
.LC80:
	.string	"weapon_bfg"
	.align 2
.LC81:
	.string	"weapon_railgun"
	.align 2
.LC82:
	.string	"item_quad"
	.align 2
.LC83:
	.string	"item_armor_combat"
	.align 2
.LC84:
	.string	"item_invulnerability"
	.align 2
.LC85:
	.string	"monster"
	.align 2
.LC86:
	.string	"%s doesn't have a spawn function\n"
	.section	".text"
	.align 2
	.globl ED_CallSpawn
	.type	 ED_CallSpawn,@function
ED_CallSpawn:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 30,3
	lwz 0,280(30)
	cmpwi 0,0,0
	bc 4,2,.L7
	lis 9,gi+4@ha
	lis 3,.LC79@ha
	lwz 0,gi+4@l(9)
	la 3,.LC79@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L30:
.L31:
	mr 3,30
	mr 4,31
	bl SpawnItem
	b .L6
.L32:
	lwz 0,4(31)
	mr 3,30
	mtlr 0
	blrl
	b .L6
.L7:
	lis 9,game+1556@ha
	li 29,0
	lwz 0,game+1556@l(9)
	lis 11,itemlist@ha
	lis 26,game@ha
	la 31,itemlist@l(11)
	cmpw 0,29,0
	bc 4,0,.L9
	lis 28,.LC83@ha
	lis 27,.LC80@ha
.L11:
	lwz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L10
	lwz 3,280(30)
	la 4,.LC80@l(27)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L13
	lwz 3,0(31)
	lis 4,.LC81@ha
	la 4,.LC81@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L31
.L13:
	lwz 3,280(30)
	lis 4,.LC82@ha
	la 4,.LC82@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L15
	lwz 3,0(31)
	la 4,.LC83@l(28)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L15
	bl getIREffectTime
	cmpwi 0,3,0
	bc 12,2,.L31
.L15:
	lwz 3,280(30)
	lis 4,.LC84@ha
	la 4,.LC84@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L17
	lwz 3,0(31)
	la 4,.LC83@l(28)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L17
	bl getIREffectTime
	cmpwi 0,3,0
	bc 12,2,.L30
.L17:
	lwz 3,0(31)
	lwz 4,280(30)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L31
.L10:
	la 9,game@l(26)
	addi 29,29,1
	lwz 0,1556(9)
	addi 31,31,76
	cmpw 0,29,0
	bc 12,0,.L11
.L9:
	lis 9,spawns@ha
	lwz 0,spawns@l(9)
	la 31,spawns@l(9)
	cmpwi 0,0,0
	bc 12,2,.L22
.L24:
	lwz 3,0(31)
	lwz 4,280(30)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L32
	lwzu 0,8(31)
	cmpwi 0,0,0
	bc 4,2,.L24
.L22:
	lwz 3,280(30)
	lis 4,.LC85@ha
	li 5,7
	la 4,.LC85@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L6
	lwz 3,280(30)
	lis 4,.LC80@ha
	la 4,.LC80@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L6
	lis 9,gi+4@ha
	lis 3,.LC86@ha
	lwz 4,280(30)
	lwz 0,gi+4@l(9)
	la 3,.LC86@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L6:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 ED_CallSpawn,.Lfe1-ED_CallSpawn
	.section	".rodata"
	.align 2
.LC87:
	.string	"%f %f %f"
	.align 2
.LC88:
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
	bc 12,2,.L45
.L47:
	lwz 0,12(29)
	andi. 9,0,2
	bc 4,2,.L46
	lwz 3,0(29)
	mr 4,31
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L46
	lwz 0,12(29)
	andi. 9,0,1
	bc 12,2,.L49
	lis 9,st@ha
	la 27,st@l(9)
	b .L50
.L49:
	mr 27,28
.L50:
	lwz 10,8(29)
	cmplwi 0,10,11
	bc 12,1,.L43
	lis 11,.L68@ha
	slwi 10,10,2
	la 11,.L68@l(11)
	lis 9,.L68@ha
	lwzx 0,10,11
	la 9,.L68@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L68:
	.long .L64-.L68
	.long .L65-.L68
	.long .L52-.L68
	.long .L43-.L68
	.long .L63-.L68
	.long .L66-.L68
	.long .L43-.L68
	.long .L43-.L68
	.long .L43-.L68
	.long .L43-.L68
	.long .L43-.L68
	.long .L43-.L68
.L52:
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
	bc 4,0,.L61
	mr 3,31
	li 6,10
.L55:
	lbzx 0,30,10
	rlwinm 11,0,0,0xff
	mr 8,0
	cmpwi 0,11,92
	bc 4,2,.L56
	cmpw 0,10,3
	bc 4,0,.L56
	addi 10,10,1
	lbzx 0,30,10
	cmpwi 0,0,110
	bc 4,2,.L57
	stb 6,0(9)
	b .L71
.L57:
	stb 11,0(9)
	b .L71
.L56:
	stb 8,0(9)
.L71:
	addi 9,9,1
	addi 10,10,1
	cmpw 0,10,28
	bc 12,0,.L55
.L61:
	lwz 0,4(29)
	stwx 7,27,0
	b .L43
.L63:
	lis 4,.LC87@ha
	mr 3,30
	la 4,.LC87@l(4)
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
	b .L43
.L64:
	mr 3,30
	bl atoi
	lwz 0,4(29)
	stwx 3,27,0
	b .L43
.L65:
	mr 3,30
	bl atof
	frsp 1,1
	lwz 0,4(29)
	stfsx 1,27,0
	b .L43
.L66:
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
	b .L43
.L46:
	lwzu 0,16(29)
	cmpwi 0,0,0
	bc 4,2,.L47
.L45:
	lis 9,gi+4@ha
	lis 3,.LC88@ha
	lwz 0,gi+4@l(9)
	la 3,.LC88@l(3)
	mr 4,31
	mtlr 0
	crxor 6,6,6
	blrl
.L43:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 ED_ParseField,.Lfe2-ED_ParseField
	.section	".rodata"
	.align 2
.LC89:
	.string	"ED_ParseEntity: EOF without closing brace"
	.align 2
.LC90:
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
	b .L75
.L76:
	lwz 0,264(1)
	cmpwi 0,0,0
	bc 4,2,.L77
	lis 9,gi+28@ha
	lis 3,.LC89@ha
	lwz 0,gi+28@l(9)
	la 3,.LC89@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L77:
	mr 4,31
	li 5,255
	addi 3,1,8
	bl strncpy
	mr 3,30
	bl COM_Parse
	lwz 0,264(1)
	mr 31,3
	cmpwi 0,0,0
	bc 4,2,.L78
	lis 9,gi+28@ha
	lis 3,.LC89@ha
	lwz 0,gi+28@l(9)
	la 3,.LC89@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L78:
	lbz 0,0(31)
	cmpwi 0,0,125
	bc 4,2,.L79
	lis 9,gi+28@ha
	lis 3,.LC90@ha
	lwz 0,gi+28@l(9)
	la 3,.LC90@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L79:
	lbz 0,8(1)
	li 29,1
	cmpwi 0,0,95
	bc 12,2,.L75
	mr 4,31
	addi 3,1,8
	mr 5,28
	bl ED_ParseField
.L75:
	mr 3,30
	bl COM_Parse
	mr 31,3
	lbz 0,0(31)
	cmpwi 0,0,125
	bc 4,2,.L76
	cmpwi 0,29,0
	bc 4,2,.L82
	mr 3,28
	li 4,0
	li 5,952
	crxor 6,6,6
	bl memset
.L82:
	lwz 3,264(1)
	lwz 0,308(1)
	mtlr 0
	lmw 28,288(1)
	la 1,304(1)
	blr
.Lfe3:
	.size	 ED_ParseEdict,.Lfe3-ED_ParseEdict
	.section	".rodata"
	.align 2
.LC91:
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
	addi 30,9,952
	bc 4,0,.L85
	mr 23,8
	lis 21,globals@ha
.L87:
	lwz 0,88(30)
	addi 27,10,1
	addi 25,30,952
	cmpwi 0,0,0
	bc 12,2,.L86
	lwz 0,308(30)
	cmpwi 0,0,0
	bc 12,2,.L86
	lwz 0,264(30)
	andi. 9,0,1024
	bc 4,2,.L86
	stw 30,564(30)
	mr 28,30
	addi 22,22,1
	lwz 0,72(23)
	addi 26,26,1
	mr 29,27
	mr 31,25
	cmpw 0,27,0
	bc 4,0,.L86
	la 24,globals@l(21)
.L94:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L93
	lwz 4,308(31)
	cmpwi 0,4,0
	bc 12,2,.L93
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L93
	lwz 3,308(30)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L93
	stw 31,560(28)
	addi 26,26,1
	lwz 0,264(31)
	mr 28,31
	stw 30,564(31)
	ori 0,0,1024
	stw 0,264(31)
.L93:
	lwz 0,72(24)
	addi 29,29,1
	addi 31,31,952
	cmpw 0,29,0
	bc 12,0,.L94
.L86:
	lwz 0,72(23)
	mr 10,27
	mr 30,25
	cmpw 0,10,0
	bc 12,0,.L87
.L85:
	lis 9,gi+4@ha
	lis 3,.LC91@ha
	lwz 0,gi+4@l(9)
	la 3,.LC91@l(3)
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
.Lfe4:
	.size	 G_FindTeams,.Lfe4-G_FindTeams
	.section	".rodata"
	.align 2
.LC92:
	.string	"skill"
	.align 2
.LC93:
	.string	"%f"
	.align 2
.LC94:
	.string	"ED_LoadFromFile: found %s when expecting {"
	.align 2
.LC95:
	.string	"command"
	.align 2
.LC96:
	.string	"*27"
	.align 2
.LC97:
	.string	"%i entities inhibited\n"
	.align 2
.LC98:
	.long 0x0
	.align 2
.LC99:
	.long 0x40400000
	.align 2
.LC100:
	.long 0x3f800000
	.align 2
.LC101:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl SpawnEntities
	.type	 SpawnEntities,@function
SpawnEntities:
	stwu 1,-64(1)
	mflr 0
	stmw 24,32(1)
	stw 0,68(1)
	lis 9,skill@ha
	stw 4,8(1)
	mr 28,3
	lwz 11,skill@l(9)
	mr 27,5
	lis 26,skill@ha
	lfs 1,20(11)
	bl floor
	lis 9,.LC98@ha
	frsp 1,1
	la 9,.LC98@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L102
	lis 11,.LC98@ha
	la 11,.LC98@l(11)
	lfs 1,0(11)
.L102:
	lis 9,.LC99@ha
	la 9,.LC99@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,1,.L103
	lis 11,.LC99@ha
	la 11,.LC99@l(11)
	lfs 1,0(11)
.L103:
	lwz 9,skill@l(26)
	lis 24,gi@ha
	lfs 0,20(9)
	fcmpu 0,0,1
	bc 12,2,.L104
	lis 3,.LC93@ha
	la 29,gi@l(24)
	la 3,.LC93@l(3)
	creqv 6,6,6
	bl va
	mr 4,3
	lwz 0,152(29)
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	mtlr 0
	blrl
.L104:
	bl SaveClientData
	lis 30,g_edicts@ha
	lis 9,gi+140@ha
	li 3,766
	lwz 0,gi+140@l(9)
	addi 25,1,8
	mtlr 0
	blrl
	lis 29,level@ha
	li 5,348
	la 29,level@l(29)
	li 4,0
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 9,game@ha
	lis 11,g_edicts@ha
	la 31,game@l(9)
	lwz 3,g_edicts@l(11)
	li 4,0
	lwz 5,1548(31)
	mulli 5,5,952
	bl memset
	mr 4,28
	li 5,63
	addi 3,29,72
	bl strncpy
	mr 4,27
	addi 3,31,1032
	li 5,511
	bl strncpy
	lwz 0,1544(31)
	li 11,0
	cmpw 0,11,0
	bc 4,0,.L106
	lwz 9,g_edicts@l(30)
	mr 3,31
	li 10,0
	addi 9,9,1036
.L108:
	lwz 0,1028(3)
	addi 11,11,1
	add 0,0,10
	stw 0,0(9)
	addi 10,10,3868
	lwz 0,1544(3)
	addi 9,9,952
	cmpw 0,11,0
	bc 12,0,.L108
.L106:
	li 29,0
	li 31,0
	b .L112
.L113:
	lbz 0,0(4)
	cmpwi 0,0,123
	bc 12,2,.L114
	la 9,gi@l(24)
	lis 3,.LC94@ha
	lwz 0,28(9)
	la 3,.LC94@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L114:
	cmpwi 0,29,0
	bc 4,2,.L115
	lwz 29,g_edicts@l(30)
	b .L116
.L115:
	bl G_Spawn
	mr 29,3
.L116:
	lwz 3,8(1)
	mr 4,29
	bl ED_ParseEdict
	stw 3,8(1)
	lis 4,.LC95@ha
	lis 3,level+72@ha
	la 4,.LC95@l(4)
	la 3,level+72@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L117
	lwz 3,280(29)
	lis 4,.LC25@ha
	la 4,.LC25@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L117
	lwz 3,268(29)
	lis 4,.LC96@ha
	la 4,.LC96@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L117
	lwz 0,284(29)
	rlwinm 0,0,0,22,20
	stw 0,284(29)
.L117:
	lwz 0,g_edicts@l(30)
	cmpw 0,29,0
	bc 12,2,.L118
	lis 11,.LC98@ha
	lis 9,deathmatch@ha
	la 11,.LC98@l(11)
	lfs 12,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L119
	lwz 0,284(29)
	andi. 9,0,2048
	b .L128
.L119:
	lwz 9,skill@l(26)
	lwz 0,284(29)
	lfs 13,20(9)
	fcmpu 0,13,12
	bc 4,2,.L124
	andi. 9,0,256
	bc 4,2,.L123
.L124:
	lis 11,.LC100@ha
	la 11,.LC100@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L125
	andi. 9,0,512
	bc 4,2,.L123
.L125:
	lis 11,.LC101@ha
	la 11,.LC101@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 12,2,.L126
	lis 9,.LC99@ha
	la 9,.LC99@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L121
.L126:
	andi. 11,0,1024
.L128:
	bc 12,2,.L121
.L123:
	mr 3,29
	addi 31,31,1
	bl G_FreeEdict
	b .L112
.L121:
	rlwinm 0,0,0,24,18
	stw 0,284(29)
.L118:
	mr 3,29
	bl ED_CallSpawn
.L112:
	mr 3,25
	bl COM_Parse
	lwz 0,8(1)
	mr 4,3
	cmpwi 0,0,0
	bc 4,2,.L113
	lis 9,gi+4@ha
	lis 3,.LC97@ha
	lwz 0,gi+4@l(9)
	la 3,.LC97@l(3)
	mr 4,31
	mtlr 0
	crxor 6,6,6
	blrl
	bl G_FindTeams
	bl PlayerTrail_Init
	lwz 0,68(1)
	mtlr 0
	lmw 24,32(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 SpawnEntities,.Lfe5-SpawnEntities
	.globl single_statusbar
	.section	".rodata"
	.align 2
.LC102:
	.ascii	"yb\t-24 xv\t0 hnum xv\t"
	.string	"50 pic 0 if 2 \txv\t100 \tanum \txv\t150 \tpic 2 endif if 4 \txv\t200 \trnum \txv\t250 \tpic 4 endif if 6 \txv\t296 \tpic 6 endif yb\t-50 if 7 \txv\t0 \tpic 7 \txv\t26 \tyb\t-42 \tstat_string 8 \tyb\t-50 endif if 9 \txv\t262 \tnum\t2\t10 \txv\t296 \tpic\t9 endif if 11 \txv\t148 \tpic\t11 endif "
	.section	".sdata","aw"
	.align 2
	.type	 single_statusbar,@object
	.size	 single_statusbar,4
single_statusbar:
	.long .LC102
	.globl nh_statusbar
	.section	".rodata"
	.align 2
.LC103:
	.ascii	"yb -24 xv\t0 hnum xv\t50 pic 0 if 2 \txv\t100 \tanum \txv\t1"
	.ascii	"50 \tpic 2 endif if 4 \txv\t200 \trnum \txv\t250 \tpic 4 end"
	.ascii	"if if 6 \txv\t296 \tpic 6 endif yb -50 if 7 \txv\t0 \tpic 7 "
	.ascii	"\txv\t26 \tyb\t-42 \tstat_string 8 \tyb\t-50 endif if 9 \txv"
	.ascii	"\t246 \tnum\t2\t10 \txv\t296 \tpic\t9 endif if 11 \txv\t120 "
	.ascii	"\tpic\t11 endif xr\t-50 yt 2 num 3 14 if 17 xv 0 yb -58 stri"
	.ascii	"ng2 \"SPECTATOR MODE\" endif if 16 xv 0 yb -68 string \"Chas"
	.ascii	"ing\" xv 64 stat_string 16 endif if 18 \txr\t-35        yt "
	.string	"     92 \tnum\t2 18 endif if 19 \tyt 28 \txr -30 \tpic 19 endif if 20 xr -50        yt 65        num 3 20 endif if 21 xv 148 yb -50 \tpic 21 endif if 22 xv 180 yb -24 \tpic 22 endif if 23 xv 0 yb -48 string2 \"SAFETY MODE\" endif if 24 xv 120 yv 100 num 2 25 endif "
	.section	".sdata","aw"
	.align 2
	.type	 nh_statusbar,@object
	.size	 nh_statusbar,4
nh_statusbar:
	.long .LC103
	.section	".rodata"
	.align 2
.LC104:
	.string	"unit1_"
	.align 2
.LC105:
	.string	"%i"
	.align 2
.LC106:
	.string	"i_help"
	.align 2
.LC107:
	.string	"i_health"
	.align 2
.LC108:
	.string	"help"
	.align 2
.LC109:
	.string	"field_3"
	.align 2
.LC110:
	.string	"sv_gravity"
	.align 2
.LC111:
	.string	"800"
	.align 2
.LC112:
	.string	"player/fry.wav"
	.align 2
.LC113:
	.string	"Blaster"
	.align 2
.LC114:
	.string	"player/lava1.wav"
	.align 2
.LC115:
	.string	"player/lava2.wav"
	.align 2
.LC116:
	.string	"misc/pc_up.wav"
	.align 2
.LC117:
	.string	"misc/talk1.wav"
	.align 2
.LC118:
	.string	"misc/udeath.wav"
	.align 2
.LC119:
	.string	"items/respawn1.wav"
	.align 2
.LC120:
	.string	"*death1.wav"
	.align 2
.LC121:
	.string	"*death2.wav"
	.align 2
.LC122:
	.string	"*death3.wav"
	.align 2
.LC123:
	.string	"*death4.wav"
	.align 2
.LC124:
	.string	"*fall1.wav"
	.align 2
.LC125:
	.string	"*fall2.wav"
	.align 2
.LC126:
	.string	"*gurp1.wav"
	.align 2
.LC127:
	.string	"*gurp2.wav"
	.align 2
.LC128:
	.string	"*jump1.wav"
	.align 2
.LC129:
	.string	"*pain25_1.wav"
	.align 2
.LC130:
	.string	"*pain25_2.wav"
	.align 2
.LC131:
	.string	"*pain50_1.wav"
	.align 2
.LC132:
	.string	"*pain50_2.wav"
	.align 2
.LC133:
	.string	"*pain75_1.wav"
	.align 2
.LC134:
	.string	"*pain75_2.wav"
	.align 2
.LC135:
	.string	"*pain100_1.wav"
	.align 2
.LC136:
	.string	"*pain100_2.wav"
	.align 2
.LC137:
	.string	"#w_blaster.md2"
	.align 2
.LC138:
	.string	"#w_shotgun.md2"
	.align 2
.LC139:
	.string	"#w_sshotgun.md2"
	.align 2
.LC140:
	.string	"#w_machinegun.md2"
	.align 2
.LC141:
	.string	"#w_chaingun.md2"
	.align 2
.LC142:
	.string	"#a_grenades.md2"
	.align 2
.LC143:
	.string	"#w_glauncher.md2"
	.align 2
.LC144:
	.string	"#w_rlauncher.md2"
	.align 2
.LC145:
	.string	"#w_hyperblaster.md2"
	.align 2
.LC146:
	.string	"#w_railgun.md2"
	.align 2
.LC147:
	.string	"#w_bfg.md2"
	.align 2
.LC148:
	.string	"players/guncock.wav"
	.align 2
.LC149:
	.string	"misc/predscore.wav"
	.align 2
.LC150:
	.string	"misc/beat1.wav"
	.align 2
.LC151:
	.string	"misc/beat2.wav"
	.align 2
.LC152:
	.string	"misc/newpred.wav"
	.align 2
.LC153:
	.string	"predator/boom.wav"
	.align 2
.LC154:
	.string	"predator/growl_100.wav"
	.align 2
.LC155:
	.string	"predator/growl_75.wav"
	.align 2
.LC156:
	.string	"predator/growl_50.wav"
	.align 2
.LC157:
	.string	"predator/growl_25.wav"
	.align 2
.LC158:
	.string	"predator/growl2.wav"
	.align 2
.LC159:
	.string	"predator/growl1.wav"
	.align 2
.LC160:
	.string	"predator/shortboom.wav"
	.align 2
.LC161:
	.string	"predator/rg_hum.wav"
	.align 2
.LC162:
	.string	"nhflash"
	.align 2
.LC163:
	.string	"h_pred"
	.align 2
.LC164:
	.string	"h_marine"
	.align 2
.LC165:
	.string	"nhir"
	.align 2
.LC166:
	.string	"h_over"
	.align 2
.LC167:
	.string	"h_flare"
	.align 2
.LC168:
	.string	"models/items/nhir/tris.md2"
	.align 2
.LC169:
	.string	"models/weapons/v_nhflare/tris.md2"
	.align 2
.LC170:
	.string	"player/gasp1.wav"
	.align 2
.LC171:
	.string	"player/gasp2.wav"
	.align 2
.LC172:
	.string	"player/watr_in.wav"
	.align 2
.LC173:
	.string	"player/watr_out.wav"
	.align 2
.LC174:
	.string	"player/watr_un.wav"
	.align 2
.LC175:
	.string	"player/u_breath1.wav"
	.align 2
.LC176:
	.string	"player/u_breath2.wav"
	.align 2
.LC177:
	.string	"items/pkup.wav"
	.align 2
.LC178:
	.string	"world/land.wav"
	.align 2
.LC179:
	.string	"misc/h2ohit1.wav"
	.align 2
.LC180:
	.string	"items/damage.wav"
	.align 2
.LC181:
	.string	"items/protect.wav"
	.align 2
.LC182:
	.string	"items/protect4.wav"
	.align 2
.LC183:
	.string	"weapons/noammo.wav"
	.align 2
.LC184:
	.string	"infantry/inflies1.wav"
	.align 2
.LC185:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC186:
	.string	"models/objects/gibs/arm/tris.md2"
	.align 2
.LC187:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC188:
	.string	"models/objects/gibs/bone2/tris.md2"
	.align 2
.LC189:
	.string	"models/objects/gibs/chest/tris.md2"
	.align 2
.LC190:
	.string	"models/objects/gibs/skull/tris.md2"
	.align 2
.LC191:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC192:
	.string	"a"
	.align 2
.LC193:
	.string	"z"
	.align 2
.LC194:
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
	li 11,1
	li 9,3
	li 0,2
	stw 11,40(31)
	stw 9,248(31)
	stw 0,260(31)
	stw 11,88(31)
	bl InitBodyQue
	bl SetItemNames
	lis 9,st+20@ha
	lwz 4,st+20@l(9)
	cmpwi 0,4,0
	bc 12,2,.L130
	lis 3,level+136@ha
	la 3,level+136@l(3)
	bl strcpy
.L130:
	lwz 4,276(31)
	cmpwi 0,4,0
	bc 12,2,.L131
	lbz 0,0(4)
	cmpwi 0,0,0
	bc 12,2,.L131
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
	b .L132
.L131:
	lis 3,level+8@ha
	li 5,64
	la 3,level+8@l(3)
	addi 4,3,64
	bl strncpy
.L132:
	lis 9,st@ha
	lwz 4,st@l(9)
	cmpwi 0,4,0
	bc 12,2,.L133
	lbz 0,0(4)
	cmpwi 0,0,0
	bc 12,2,.L133
	lis 9,gi+24@ha
	li 3,2
	lwz 0,gi+24@l(9)
	mtlr 0
	blrl
	b .L134
.L133:
	lis 9,gi+24@ha
	lis 4,.LC104@ha
	lwz 0,gi+24@l(9)
	la 4,.LC104@l(4)
	li 3,2
	mtlr 0
	blrl
.L134:
	lis 29,st@ha
	lis 9,gi@ha
	la 29,st@l(29)
	lis 3,.LC93@ha
	lfs 1,4(29)
	la 30,gi@l(9)
	la 3,.LC93@l(3)
	lis 28,.LC105@ha
	creqv 6,6,6
	bl va
	lwz 9,24(30)
	mr 4,3
	li 3,4
	mtlr 9
	blrl
	lfs 3,16(29)
	lis 3,.LC87@ha
	lfs 1,8(29)
	la 3,.LC87@l(3)
	lfs 2,12(29)
	creqv 6,6,6
	bl va
	lwz 9,24(30)
	mr 4,3
	li 3,3
	mtlr 9
	blrl
	lwz 4,528(31)
	la 3,.LC105@l(28)
	crxor 6,6,6
	bl va
	lwz 9,24(30)
	mr 4,3
	li 3,1
	mtlr 9
	blrl
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	la 3,.LC105@l(28)
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
	lis 9,.LC194@ha
	lis 11,deathmatch@ha
	la 9,.LC194@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L135
	lwz 0,24(30)
	lis 9,nh_statusbar@ha
	li 3,5
	lwz 4,nh_statusbar@l(9)
	mtlr 0
	blrl
	b .L136
.L135:
	lwz 0,24(30)
	lis 9,single_statusbar@ha
	li 3,5
	lwz 4,single_statusbar@l(9)
	mtlr 0
	blrl
.L136:
	lis 9,gi@ha
	lis 3,.LC106@ha
	la 31,gi@l(9)
	la 3,.LC106@l(3)
	lwz 9,40(31)
	mtlr 9
	blrl
	lwz 9,40(31)
	lis 3,.LC107@ha
	la 3,.LC107@l(3)
	mtlr 9
	blrl
	lwz 10,40(31)
	lis 9,level+264@ha
	lis 11,.LC108@ha
	stw 3,level+264@l(9)
	mtlr 10
	la 3,.LC108@l(11)
	blrl
	lwz 9,40(31)
	lis 3,.LC109@ha
	la 3,.LC109@l(3)
	mtlr 9
	blrl
	lis 9,st+48@ha
	lwz 4,st+48@l(9)
	cmpwi 0,4,0
	bc 4,2,.L137
	lwz 0,148(31)
	lis 3,.LC110@ha
	lis 4,.LC111@ha
	la 3,.LC110@l(3)
	la 4,.LC111@l(4)
	mtlr 0
	blrl
	b .L138
.L137:
	lwz 0,148(31)
	lis 3,.LC110@ha
	la 3,.LC110@l(3)
	mtlr 0
	blrl
.L138:
	lis 29,gi@ha
	lis 3,.LC112@ha
	la 29,gi@l(29)
	la 3,.LC112@l(3)
	lwz 9,36(29)
	lis 28,.LC192@ha
	mtlr 9
	blrl
	lis 9,snd_fry@ha
	lis 11,.LC113@ha
	stw 3,snd_fry@l(9)
	la 3,.LC113@l(11)
	bl FindItem
	bl PrecacheItem
	lwz 9,36(29)
	lis 3,.LC114@ha
	la 3,.LC114@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC115@ha
	la 3,.LC115@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC116@ha
	la 3,.LC116@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC117@ha
	la 3,.LC117@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC118@ha
	la 3,.LC118@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC119@ha
	la 3,.LC119@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC120@ha
	la 3,.LC120@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC121@ha
	la 3,.LC121@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC122@ha
	la 3,.LC122@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC123@ha
	la 3,.LC123@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC124@ha
	la 3,.LC124@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC125@ha
	la 3,.LC125@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC126@ha
	la 3,.LC126@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC127@ha
	la 3,.LC127@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC128@ha
	la 3,.LC128@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC129@ha
	la 3,.LC129@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC130@ha
	la 3,.LC130@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC131@ha
	la 3,.LC131@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC132@ha
	la 3,.LC132@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC133@ha
	la 3,.LC133@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC134@ha
	la 3,.LC134@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC135@ha
	la 3,.LC135@l(3)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC136@ha
	la 3,.LC136@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC137@ha
	la 3,.LC137@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC138@ha
	la 3,.LC138@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC139@ha
	la 3,.LC139@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC140@ha
	la 3,.LC140@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC141@ha
	la 3,.LC141@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC142@ha
	la 3,.LC142@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC143@ha
	la 3,.LC143@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC144@ha
	la 3,.LC144@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC145@ha
	la 3,.LC145@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC146@ha
	la 3,.LC146@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
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
	lwz 9,40(29)
	lis 3,.LC162@ha
	la 3,.LC162@l(3)
	mtlr 9
	blrl
	lwz 9,40(29)
	lis 3,.LC163@ha
	la 3,.LC163@l(3)
	mtlr 9
	blrl
	lwz 9,40(29)
	lis 3,.LC164@ha
	la 3,.LC164@l(3)
	mtlr 9
	blrl
	lwz 9,40(29)
	lis 3,.LC165@ha
	la 3,.LC165@l(3)
	mtlr 9
	blrl
	lwz 9,40(29)
	lis 3,.LC166@ha
	la 3,.LC166@l(3)
	mtlr 9
	blrl
	lwz 9,40(29)
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
	lwz 9,32(29)
	lis 3,.LC185@ha
	la 3,.LC185@l(3)
	mtlr 9
	blrl
	lwz 10,32(29)
	lis 9,sm_meat_index@ha
	lis 11,.LC186@ha
	stw 3,sm_meat_index@l(9)
	mtlr 10
	la 3,.LC186@l(11)
	blrl
	lwz 9,32(29)
	lis 3,.LC187@ha
	la 3,.LC187@l(3)
	mtlr 9
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
	lwz 9,24(29)
	li 3,800
	la 4,.LC192@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,801
	la 4,.LC192@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,802
	la 4,.LC192@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,803
	la 4,.LC192@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,804
	la 4,.LC192@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,805
	la 4,.LC192@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,806
	la 4,.LC192@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,807
	la 4,.LC192@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,808
	la 4,.LC192@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,809
	la 4,.LC192@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,810
	la 4,.LC192@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	la 4,.LC192@l(28)
	li 3,811
	mtlr 9
	blrl
	lwz 0,24(29)
	lis 4,.LC193@ha
	li 3,863
	la 4,.LC193@l(4)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 SP_worldspawn,.Lfe6-SP_worldspawn
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
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
	bc 4,0,.L35
	mr 3,29
	li 6,10
.L37:
	lbzx 0,31,11
	rlwinm 10,0,0,0xff
	mr 8,0
	cmpwi 0,10,92
	bc 4,2,.L38
	cmpw 0,11,3
	bc 4,0,.L38
	addi 11,11,1
	lbzx 0,31,11
	cmpwi 0,0,110
	bc 4,2,.L39
	stb 6,0(9)
	b .L139
.L39:
	stb 10,0(9)
	b .L139
.L38:
	stb 8,0(9)
.L139:
	addi 9,9,1
	addi 11,11,1
	cmpw 0,11,30
	bc 12,0,.L37
.L35:
	mr 3,7
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 ED_NewString,.Lfe7-ED_NewString
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
