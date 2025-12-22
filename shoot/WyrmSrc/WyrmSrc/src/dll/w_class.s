	.file	"w_class.c"
gcc2_compiled.:
	.globl MODTable
	.section	".data"
	.align 2
	.type	 MODTable,@object
MODTable:
	.string	"mod_unknown"
	.space	20
	.long 0
	.string	"mod_blaster"
	.space	20
	.long 1
	.string	"mod_shotgun"
	.space	20
	.long 2
	.string	"mod_sshotgun"
	.space	19
	.long 3
	.string	"mod_machinegun"
	.space	17
	.long 4
	.string	"mod_chaingun"
	.space	19
	.long 5
	.string	"mod_grenade"
	.space	20
	.long 6
	.string	"mod_g_splash"
	.space	19
	.long 7
	.string	"mod_rocket"
	.space	21
	.long 8
	.string	"mod_r_splash"
	.space	19
	.long 9
	.string	"mod_hyperblaster"
	.space	15
	.long 10
	.string	"mod_railgun"
	.space	20
	.long 11
	.string	"mod_bfg_laser"
	.space	18
	.long 12
	.string	"mod_bfg_blast"
	.space	18
	.long 13
	.string	"mod_bfg_effect"
	.space	17
	.long 14
	.string	"mod_handgrenade"
	.space	16
	.long 15
	.string	"mod_hg_splash"
	.space	18
	.long 16
	.string	"mod_water"
	.space	22
	.long 17
	.string	"mod_slime"
	.space	22
	.long 18
	.string	"mod_lava"
	.space	23
	.long 19
	.string	"mod_crush"
	.space	22
	.long 20
	.string	"mod_falling"
	.space	20
	.long 22
	.string	"mod_held_grenade"
	.space	15
	.long 24
	.string	"mod_explosive"
	.space	18
	.long 25
	.string	"mod_barrel"
	.space	21
	.long 26
	.string	"mod_bomb"
	.space	23
	.long 27
	.string	"mod_exit"
	.space	23
	.long 28
	.string	"mod_splash"
	.space	21
	.long 29
	.string	"mod_target_laser"
	.space	15
	.long 30
	.string	"mod_trigger_hurt"
	.space	15
	.long 31
	.string	"mod_hit"
	.space	24
	.long 32
	.string	"mod_target_blaster"
	.space	13
	.long 33
	.string	"mod_freeze"
	.space	21
	.long 34
	.string	"mod_pistol"
	.space	21
	.long 35
	.string	"mod_flaregun"
	.space	19
	.long 36
	.string	"mod_airfist"
	.space	20
	.long 37
	.string	"mod_doubleimpact"
	.space	15
	.long 38
	.string	"mod_explosivemachinegun"
	.space	8
	.long 39
	.string	"mod_pulserifle"
	.space	17
	.long 40
	.string	"mod_firethrower"
	.space	16
	.long 41
	.string	"mod_streetsweeper"
	.space	14
	.long 42
	.string	"mod_clustergrenades"
	.space	12
	.long 43
	.string	"mod_railgrenades"
	.space	15
	.long 44
	.string	"mod_proxgrenades"
	.space	15
	.long 45
	.string	"mod_napalmgrenades"
	.space	13
	.long 46
	.string	"mod_stickinggrenades"
	.space	11
	.long 47
	.string	"mod_bfgrenades"
	.space	17
	.long 48
	.string	"mod_napalmrockets"
	.space	14
	.long 49
	.string	"mod_guidedrockets"
	.space	14
	.long 50
	.string	"mod_plasma"
	.space	21
	.long 51
	.string	"mod_disruptor"
	.space	18
	.long 52
	.string	"mod_antimatter"
	.space	17
	.long 53
	.string	"mod_positron"
	.space	19
	.long 54
	.string	"mod_tripbomb"
	.space	19
	.long 55
	.string	"mod_lasertripbomb"
	.space	14
	.long 56
	.string	"mod_grapple"
	.space	20
	.long 57
	.string	"mod_fire"
	.space	23
	.long 58
	.string	"mod_fire_splash"
	.space	16
	.long 59
	.string	"mod_on_fire"
	.space	20
	.long 60
	.string	"mod_fireball"
	.space	19
	.long 61
	.string	"mod_nail"
	.space	23
	.long 62
	.string	"mod_supernail"
	.space	18
	.long 63
	.string	"mod_vacuum"
	.space	21
	.long 64
	.string	"mod_vortex"
	.space	21
	.long 65
	.string	"mod_drainer"
	.space	20
	.long 66
	.string	"mod_bucky"
	.space	22
	.long 67
	.string	"mod_lightning"
	.space	18
	.long 68
	.string	"mod_discharge"
	.space	18
	.long 69
	.string	"mod_nuke"
	.space	23
	.long 72
	.string	"mod_perforator_splash"
	.space	10
	.long 71
	.string	"mod_perforator"
	.space	17
	.long 70
	.string	"mod_sentrybullet"
	.space	15
	.long 74
	.string	"mod_sentryexplode"
	.space	14
	.long 73
	.string	""
	.space	31
	.long -1
	.size	 MODTable,2664
	.globl basic_jacketarmor_info
	.align 2
	.type	 basic_jacketarmor_info,@object
	.size	 basic_jacketarmor_info,20
basic_jacketarmor_info:
	.long 25
	.long 50
	.long 0x3e99999a
	.long 0x0
	.long 1
	.globl basic_combatarmor_info
	.align 2
	.type	 basic_combatarmor_info,@object
	.size	 basic_combatarmor_info,20
basic_combatarmor_info:
	.long 50
	.long 100
	.long 0x3f19999a
	.long 0x3e99999a
	.long 2
	.globl basic_bodyarmor_info
	.align 2
	.type	 basic_bodyarmor_info,@object
	.size	 basic_bodyarmor_info,20
basic_bodyarmor_info:
	.long 100
	.long 200
	.long 0x3f4ccccd
	.long 0x3f19999a
	.long 3
	.section	".rodata"
	.align 2
.LC0:
	.string	"basedir"
	.align 2
.LC1:
	.string	"."
	.align 2
.LC2:
	.string	"gamedir"
	.align 2
.LC3:
	.string	"baseq2"
	.align 2
.LC4:
	.string	"%s/%s/%s"
	.align 2
.LC5:
	.string	"%s/%s/default.class"
	.align 2
.LC6:
	.string	"r"
	.align 2
.LC7:
	.string	"Blaster"
	.align 2
.LC8:
	.string	"name"
	.align 2
.LC9:
	.string	"%s"
	.align 2
.LC10:
	.string	"skin"
	.align 2
.LC11:
	.string	"keys"
	.align 2
.LC12:
	.string	"speed"
	.align 2
.LC13:
	.string	"power"
	.align 2
.LC14:
	.string	"resistance"
	.align 2
.LC15:
	.string	"jump"
	.align 2
.LC16:
	.string	"health"
	.align 2
.LC17:
	.string	"max_health"
	.align 2
.LC18:
	.string	"max_shells"
	.align 2
.LC19:
	.string	"max_bullets"
	.align 2
.LC20:
	.string	"max_rockets"
	.align 2
.LC21:
	.string	"max_grenades"
	.align 2
.LC22:
	.string	"max_slugs"
	.align 2
.LC23:
	.string	"max_cells"
	.align 2
.LC24:
	.string	"jacketarmor"
	.align 2
.LC25:
	.string	"combatarmor"
	.align 2
.LC26:
	.string	"bodyarmor"
	.align 2
.LC27:
	.string	"initial_weapon"
	.align 2
.LC28:
	.long 0x0
	.align 2
.LC29:
	.long 0x41200000
	.align 2
.LC30:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl ReadClass
	.type	 ReadClass,@function
ReadClass:
	stwu 1,-480(1)
	mflr 0
	stfd 30,464(1)
	stfd 31,472(1)
	stmw 14,392(1)
	stw 0,484(1)
	lis 29,gi@ha
	lis 3,.LC0@ha
	la 29,gi@l(29)
	lis 4,.LC1@ha
	lwz 9,144(29)
	la 4,.LC1@l(4)
	li 5,4
	la 3,.LC0@l(3)
	lis 31,classfile@ha
	mtlr 9
	li 17,0
	lis 30,actual_class@ha
	blrl
	lwz 0,144(29)
	mr 15,3
	lis 4,.LC3@ha
	lis 3,.LC2@ha
	la 4,.LC3@l(4)
	li 5,4
	mtlr 0
	la 3,.LC2@l(3)
	blrl
	lwz 11,classfile@l(31)
	mr 16,3
	lis 9,actual_class@ha
	stw 17,actual_class@l(9)
	lwz 3,4(11)
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L7
	lwz 9,classfile@l(31)
	lis 5,.LC4@ha
	addi 3,1,8
	lwz 6,4(15)
	la 5,.LC4@l(5)
	li 4,64
	lwz 8,4(9)
	lwz 7,4(16)
	crxor 6,6,6
	bl Com_sprintf
	b .L8
.L7:
	lis 5,.LC5@ha
	lwz 6,4(15)
	addi 3,1,8
	lwz 7,4(16)
	la 5,.LC5@l(5)
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
.L8:
	lis 4,.LC6@ha
	addi 3,1,8
	la 4,.LC6@l(4)
	bl fopen
	mr. 17,3
	bc 12,2,.L9
	addi 31,1,72
	b .L10
.L14:
	lbz 0,72(1)
	cmpwi 0,0,123
	bc 4,2,.L10
.L154:
	lis 20,actual_class@ha
	lis 29,classtbl@ha
	lwz 0,actual_class@l(20)
	la 29,classtbl@l(29)
	li 11,0
	lis 8,0x3f80
	addi 10,29,1200
	mulli 0,0,2924
	li 7,100
	addi 5,29,1184
	li 24,200
	li 6,50
	stbx 11,29,0
	add 9,0,29
	addi 21,29,1188
	stb 11,160(9)
	addi 22,29,1192
	addi 23,29,1196
	stb 11,32(9)
	addi 27,29,1208
	addi 26,29,1204
	stwx 8,10,0
	addi 9,29,1216
	addi 11,29,1228
	stwx 7,9,0
	addi 25,29,1212
	addi 28,29,1220
	stwx 8,5,0
	addi 9,29,1232
	addi 10,29,1224
	stwx 24,11,0
	addi 3,29,1236
	li 4,0
	stwx 6,9,0
	add 3,0,3
	li 5,1024
	stwx 8,21,0
	stwx 8,22,0
	stwx 8,23,0
	stwx 7,27,0
	stwx 7,26,0
	stwx 24,25,0
	stwx 6,28,0
	stwx 6,10,0
	crxor 6,6,6
	bl memset
	lwz 0,actual_class@l(20)
	li 9,75
	addi 29,29,2560
	mtctr 9
	lis 11,0x3f80
	mulli 0,0,2924
	add 9,0,29
.L156:
	stw 11,-300(9)
	stw 11,0(9)
	addi 9,9,4
	bdnz .L156
	lis 10,.LC28@ha
	lis 3,.LC7@ha
	la 10,.LC28@l(10)
	la 3,.LC7@l(3)
	lfs 31,0(10)
	li 20,0
	lis 22,0x3f80
	bl FindItem
	li 23,100
	lis 9,.LC29@ha
	lis 8,classtbl@ha
	la 9,.LC29@l(9)
	la 8,classtbl@l(8)
	lfs 30,0(9)
	addi 11,8,2864
	lis 10,basic_combatarmor_info@ha
	lis 9,actual_class@ha
	lis 27,basic_bodyarmor_info@ha
	lwz 5,actual_class@l(9)
	mr 24,8
	addi 21,1,200
	lis 9,basic_jacketarmor_info@ha
	lwz 0,basic_jacketarmor_info@l(9)
	mulli 5,5,2924
	la 9,basic_jacketarmor_info@l(9)
	lwz 7,16(9)
	lwz 4,4(9)
	lwz 29,8(9)
	lwz 28,12(9)
	addi 9,8,2860
	stwx 3,9,5
	stwx 0,5,11
	lis 9,MODTable+32@ha
	addi 3,8,2884
	lwz 26,basic_combatarmor_info@l(10)
	add 11,5,11
	la 19,MODTable+32@l(9)
	stw 7,16(11)
	la 10,basic_combatarmor_info@l(10)
	add 6,5,3
	stw 4,4(11)
	addi 8,8,2904
	addi 18,19,-32
	stw 29,8(11)
	la 4,basic_bodyarmor_info@l(27)
	add 7,5,8
	stw 28,12(11)
	mr 14,8
	lwz 11,4(10)
	lwz 0,8(10)
	lwz 9,12(10)
	lwz 28,16(10)
	stwx 26,5,3
	lwz 29,basic_bodyarmor_info@l(27)
	stw 28,16(6)
	stw 11,4(6)
	stw 0,8(6)
	stw 9,12(6)
	lwz 0,16(4)
	lwz 9,4(4)
	lwz 11,8(4)
	lwz 10,12(4)
	stwx 29,5,8
	stw 0,16(7)
	stw 9,4(7)
	stw 11,8(7)
	stw 10,12(7)
	b .L20
.L22:
	lbz 0,72(1)
	cmpwi 0,0,125
	bc 4,2,.L24
	li 20,1
	b .L20
.L24:
	cmpwi 0,0,47
	bc 12,2,.L20
	mr 3,31
	li 4,10
	bl strchr
	mr. 28,3
	bc 12,2,.L26
	stb 20,0(28)
.L26:
	mr 3,31
	li 4,32
	bl strchr
	mr. 28,3
	bc 12,2,.L20
	lis 4,.LC8@ha
	stb 20,0(28)
	mr 3,31
	la 4,.LC8@l(4)
	addi 28,28,1
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L29
	lwz 3,actual_class@l(30)
	lis 5,.LC9@ha
	mr 6,28
	la 5,.LC9@l(5)
	li 4,32
	mulli 3,3,2924
	add 3,3,24
	crxor 6,6,6
	bl Com_sprintf
	b .L20
.L29:
	lis 4,.LC10@ha
	mr 3,31
	la 4,.LC10@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L31
	lwz 0,actual_class@l(30)
	lis 3,classtbl+32@ha
	lis 5,.LC9@ha
	la 3,classtbl+32@l(3)
	la 5,.LC9@l(5)
	mulli 0,0,2924
	mr 6,28
	li 4,128
	add 3,0,3
	crxor 6,6,6
	bl Com_sprintf
	b .L20
.L31:
	lis 4,.LC11@ha
	mr 3,31
	la 4,.LC11@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L33
	lwz 0,actual_class@l(30)
	lis 9,classtbl+160@ha
	mr 8,28
	la 9,classtbl+160@l(9)
	lwz 6,4(15)
	lis 5,.LC4@ha
	mulli 0,0,2924
	lwz 7,4(16)
	la 5,.LC4@l(5)
	mr 3,21
	li 4,64
	add 28,0,9
	crxor 6,6,6
	bl Com_sprintf
	lis 9,.LC6@ha
	mr 3,21
	la 4,.LC6@l(9)
	bl fopen
	mr. 27,3
	bc 12,2,.L20
	addi 29,1,264
	b .L35
.L37:
	mr 3,28
	mr 4,29
	bl strcpy
	mr 3,29
	bl strlen
	add 28,28,3
.L35:
	mr 3,29
	li 4,128
	mr 5,27
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L37
	mr 3,27
	bl fclose
	b .L20
.L33:
	lis 4,.LC12@ha
	mr 3,31
	la 4,.LC12@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L40
	mr 3,28
	bl atof
	frsp 1,1
	lwz 0,actual_class@l(30)
	addi 9,24,1184
	b .L160
.L40:
	lis 4,.LC13@ha
	mr 3,31
	la 4,.LC13@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L44
	mr 3,28
	bl atof
	frsp 1,1
	lwz 0,actual_class@l(30)
	addi 9,24,1188
	b .L160
.L44:
	lis 29,.LC14@ha
	mr 3,31
	la 4,.LC14@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L48
	mr 3,28
	bl atof
	frsp 1,1
	lwz 0,actual_class@l(30)
	addi 9,24,1192
	b .L160
.L48:
	lis 4,.LC15@ha
	mr 3,31
	la 4,.LC15@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L52
	mr 3,28
	bl atof
	frsp 1,1
	lwz 0,actual_class@l(30)
	addi 9,24,1196
	b .L160
.L52:
	la 4,.LC14@l(29)
	mr 3,31
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L56
	mr 3,28
	bl atof
	frsp 1,1
	lwz 0,actual_class@l(30)
	addi 9,24,1200
.L160:
	mulli 0,0,2924
	fcmpu 0,1,31
	stfsx 1,9,0
	bc 12,0,.L58
	fcmpu 0,1,30
	bc 4,1,.L20
.L58:
	stwx 22,9,0
	b .L20
.L56:
	lis 4,.LC16@ha
	mr 3,31
	la 4,.LC16@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L60
	mr 3,28
	bl atoi
	lwz 0,actual_class@l(30)
	cmplwi 0,3,999
	addi 9,24,1208
	b .L157
.L60:
	lis 4,.LC17@ha
	mr 3,31
	la 4,.LC17@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L63
	mr 3,28
	bl atoi
	lwz 0,actual_class@l(30)
	cmplwi 0,3,999
	addi 9,24,1204
	b .L157
.L63:
	lis 4,.LC18@ha
	mr 3,31
	la 4,.LC18@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L66
	mr 3,28
	bl atoi
	lwz 0,actual_class@l(30)
	cmplwi 0,3,999
	addi 9,24,1216
	b .L157
.L66:
	lis 4,.LC19@ha
	mr 3,31
	la 4,.LC19@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L69
	mr 3,28
	bl atoi
	lwz 0,actual_class@l(30)
	cmplwi 0,3,999
	addi 9,24,1212
	b .L157
.L69:
	lis 4,.LC20@ha
	mr 3,31
	la 4,.LC20@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L72
	mr 3,28
	bl atoi
	lwz 0,actual_class@l(30)
	cmplwi 0,3,999
	addi 9,24,1220
	b .L157
.L72:
	lis 4,.LC21@ha
	mr 3,31
	la 4,.LC21@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L75
	mr 3,28
	bl atoi
	lwz 0,actual_class@l(30)
	cmplwi 0,3,999
	addi 9,24,1224
	b .L157
.L75:
	lis 4,.LC22@ha
	mr 3,31
	la 4,.LC22@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L78
	mr 3,28
	bl atoi
	lwz 0,actual_class@l(30)
	cmplwi 0,3,999
	addi 9,24,1232
	b .L157
.L78:
	lis 4,.LC23@ha
	mr 3,31
	la 4,.LC23@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L81
	mr 3,28
	bl atoi
	lwz 0,actual_class@l(30)
	cmplwi 0,3,999
	addi 9,24,1228
.L157:
	mulli 0,0,2924
	stwx 3,9,0
	bc 4,1,.L20
	stwx 23,9,0
	b .L20
.L81:
	lis 4,.LC24@ha
	mr 3,31
	la 4,.LC24@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L84
	lbz 0,0(28)
	cmpwi 0,0,32
	bc 4,2,.L86
.L87:
	lbzu 0,1(28)
	cmpwi 0,0,32
	bc 12,2,.L87
.L86:
	lbz 11,0(28)
	xori 9,11,98
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,66
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 12,2,.L89
	addi 3,28,1
	bl atoi
	lwz 0,actual_class@l(30)
	lis 9,classtbl+2864@ha
	la 9,classtbl+2864@l(9)
	b .L158
.L89:
	xori 9,11,109
	subfic 10,9,0
	adde 9,10,9
	xori 0,11,77
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 12,2,.L91
	addi 3,28,1
	bl atoi
	lwz 0,actual_class@l(30)
	lis 9,classtbl+2868@ha
	la 9,classtbl+2868@l(9)
	b .L158
.L91:
	xori 9,11,110
	subfic 10,9,0
	adde 9,10,9
	xori 0,11,78
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 12,2,.L93
	addi 3,28,1
	bl atof
	lwz 0,actual_class@l(30)
	frsp 1,1
	lis 9,classtbl+2872@ha
	la 9,classtbl+2872@l(9)
	b .L159
.L93:
	xori 9,11,69
	subfic 10,9,0
	adde 9,10,9
	xori 0,11,101
	subfic 10,0,0
	adde 0,10,0
	or. 11,0,9
	bc 12,2,.L20
	addi 3,28,1
	bl atof
	lwz 0,actual_class@l(30)
	frsp 1,1
	lis 9,classtbl+2876@ha
	la 9,classtbl+2876@l(9)
	b .L159
.L84:
	lis 4,.LC25@ha
	mr 3,31
	la 4,.LC25@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L97
	lbz 0,0(28)
	cmpwi 0,0,32
	bc 4,2,.L99
.L100:
	lbzu 0,1(28)
	cmpwi 0,0,32
	bc 12,2,.L100
.L99:
	lbz 11,0(28)
	xori 9,11,98
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,66
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 12,2,.L102
	addi 3,28,1
	bl atoi
	lwz 0,actual_class@l(30)
	lis 9,classtbl+2884@ha
	la 9,classtbl+2884@l(9)
	b .L158
.L102:
	xori 9,11,109
	subfic 10,9,0
	adde 9,10,9
	xori 0,11,77
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 12,2,.L104
	addi 3,28,1
	bl atoi
	lwz 0,actual_class@l(30)
	lis 9,classtbl+2888@ha
	la 9,classtbl+2888@l(9)
	b .L158
.L104:
	xori 9,11,110
	subfic 10,9,0
	adde 9,10,9
	xori 0,11,78
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 12,2,.L106
	addi 3,28,1
	bl atof
	lwz 0,actual_class@l(30)
	frsp 1,1
	lis 9,classtbl+2892@ha
	la 9,classtbl+2892@l(9)
	b .L159
.L106:
	xori 9,11,69
	subfic 10,9,0
	adde 9,10,9
	xori 0,11,101
	subfic 10,0,0
	adde 0,10,0
	or. 11,0,9
	bc 12,2,.L20
	addi 3,28,1
	bl atof
	lwz 0,actual_class@l(30)
	frsp 1,1
	lis 9,classtbl+2896@ha
	la 9,classtbl+2896@l(9)
	b .L159
.L97:
	lis 4,.LC26@ha
	mr 3,31
	la 4,.LC26@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L110
	lbz 0,0(28)
	cmpwi 0,0,32
	bc 4,2,.L112
.L113:
	lbzu 0,1(28)
	cmpwi 0,0,32
	bc 12,2,.L113
.L112:
	lbz 11,0(28)
	xori 9,11,98
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,66
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 12,2,.L115
	addi 3,28,1
	bl atoi
	lwz 0,actual_class@l(30)
	mulli 0,0,2924
	stwx 3,14,0
	b .L20
.L115:
	xori 9,11,109
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,77
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 12,2,.L117
	addi 3,28,1
	bl atoi
	lwz 0,actual_class@l(30)
	lis 9,classtbl+2908@ha
	la 9,classtbl+2908@l(9)
	b .L158
.L117:
	xori 9,11,110
	subfic 10,9,0
	adde 9,10,9
	xori 0,11,78
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 12,2,.L119
	addi 3,28,1
	bl atof
	lwz 0,actual_class@l(30)
	frsp 1,1
	lis 9,classtbl+2912@ha
	la 9,classtbl+2912@l(9)
	b .L159
.L119:
	xori 9,11,69
	subfic 10,9,0
	adde 9,10,9
	xori 0,11,101
	subfic 10,0,0
	adde 0,10,0
	or. 11,0,9
	bc 12,2,.L20
	addi 3,28,1
	bl atof
	lwz 0,actual_class@l(30)
	frsp 1,1
	lis 9,classtbl+2916@ha
	la 9,classtbl+2916@l(9)
.L159:
	mulli 0,0,2924
	stfsx 1,9,0
	b .L20
.L110:
	lis 4,.LC27@ha
	mr 3,31
	la 4,.LC27@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L123
	mr 3,28
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L20
	lwz 0,actual_class@l(30)
	lis 9,classtbl+2860@ha
	la 9,classtbl+2860@l(9)
.L158:
	mulli 0,0,2924
	stwx 3,9,0
	b .L20
.L123:
	mr 3,31
	bl FindItemByClassname
	mr. 29,3
	bc 12,2,.L126
	mr 3,28
	bl atoi
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,actual_class@l(30)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,29
	mulli 11,11,2924
	lis 10,classtbl+1236@ha
	mullw 9,9,0
	la 10,classtbl+1236@l(10)
	rlwinm 9,9,0,0,29
	add 9,9,11
	mr 11,10
	stwx 3,11,9
	b .L20
.L126:
	lbz 0,0(18)
	li 25,0
	li 26,0
	cmpwi 0,0,0
	bc 12,2,.L129
	mr 29,18
	mr 27,29
.L130:
	mr 3,31
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L131
	li 25,1
	b .L128
.L131:
	addi 29,29,36
	addi 27,27,36
	addi 26,26,1
.L128:
	lbz 0,0(29)
	xori 9,25,1
	neg 0,0
	srwi 0,0,31
	and. 10,0,9
	bc 4,2,.L130
.L129:
	cmpwi 0,25,0
	bc 12,2,.L20
	lbz 0,0(28)
	cmpwi 0,0,32
	bc 4,2,.L136
.L137:
	lbzu 0,1(28)
	cmpwi 0,0,32
	bc 12,2,.L137
.L136:
	lbz 11,0(28)
	xori 9,11,105
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,73
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 12,2,.L139
	addi 3,28,1
	bl atof
	frsp 1,1
	mulli 11,26,36
	lwz 9,actual_class@l(30)
	addi 10,24,2260
	lwzx 0,19,11
	mulli 9,9,2924
	fcmpu 0,1,31
	slwi 0,0,2
	add 0,0,9
	stfsx 1,10,0
	bc 12,0,.L145
	fcmpu 0,1,30
	b .L161
.L139:
	xori 9,11,82
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,114
	subfic 10,0,0
	adde 0,10,0
	or. 11,0,9
	bc 12,2,.L20
	addi 3,28,1
	bl atof
	frsp 1,1
	mulli 11,26,36
	lwz 9,actual_class@l(30)
	addi 10,24,2560
	lwzx 0,19,11
	mulli 9,9,2924
	fcmpu 0,1,31
	slwi 0,0,2
	add 0,0,9
	stfsx 1,10,0
	bc 12,0,.L145
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
.L161:
	bc 4,1,.L20
.L145:
	stwx 22,10,0
.L20:
	mr 3,31
	li 4,128
	mr 5,17
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L21
	cmpwi 0,20,0
	bc 12,2,.L22
.L21:
	lis 11,actual_class@ha
	lbz 0,72(1)
	lwz 9,actual_class@l(11)
	cmpwi 0,0,123
	addi 9,9,1
	stw 9,actual_class@l(11)
	bc 12,2,.L154
.L10:
	mr 3,31
	li 4,128
	mr 5,17
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L11
	lis 9,actual_class@ha
	lwz 0,actual_class@l(9)
	cmpwi 0,0,31
	bc 4,1,.L14
.L11:
	mr 3,17
	bl fclose
.L9:
	lis 31,actual_class@ha
	lwz 20,actual_class@l(31)
	cmpwi 0,20,0
	bc 4,2,.L149
	lis 29,classtbl@ha
	lis 0,0x3f80
	la 29,classtbl@l(29)
	li 8,100
	stbx 20,29,20
	addi 11,29,1184
	addi 9,29,1200
	stb 20,32(29)
	addi 6,29,1188
	addi 10,29,1216
	stb 20,160(29)
	li 23,200
	li 7,50
	stwx 0,11,20
	addi 22,29,1192
	addi 21,29,1196
	stwx 0,9,20
	addi 11,29,1232
	addi 24,29,1208
	stwx 0,6,20
	addi 9,29,1228
	addi 26,29,1204
	stwx 8,10,20
	addi 25,29,1212
	addi 27,29,1220
	stwx 23,9,20
	addi 28,29,1224
	addi 3,29,1236
	stwx 7,11,20
	li 4,0
	li 5,1024
	stwx 0,22,20
	stwx 0,21,20
	stwx 8,24,20
	stwx 8,26,20
	stwx 23,25,20
	stwx 7,27,20
	stwx 7,28,20
	crxor 6,6,6
	bl memset
	lwz 0,actual_class@l(31)
	li 9,75
	addi 29,29,2560
	mtctr 9
	lis 11,0x3f80
	mulli 0,0,2924
	add 9,0,29
.L155:
	stw 11,-300(9)
	stw 11,0(9)
	addi 9,9,4
	bdnz .L155
	lis 3,.LC7@ha
	la 3,.LC7@l(3)
	bl FindItem
	lis 22,actual_class@ha
	lis 9,basic_jacketarmor_info@ha
	lwz 0,actual_class@l(22)
	lis 10,classtbl@ha
	lis 28,basic_combatarmor_info@ha
	lwz 29,basic_jacketarmor_info@l(9)
	la 10,classtbl@l(10)
	la 8,basic_combatarmor_info@l(28)
	mulli 0,0,2924
	la 9,basic_jacketarmor_info@l(9)
	addi 7,10,2860
	lwz 24,16(9)
	addi 5,10,2864
	addi 26,10,2884
	lwz 25,4(9)
	add 11,0,5
	lis 27,basic_bodyarmor_info@ha
	stwx 3,7,0
	la 6,basic_bodyarmor_info@l(27)
	addi 10,10,2904
	lwz 3,8(9)
	add 7,0,26
	li 23,1
	lwz 4,12(9)
	stwx 29,5,0
	add 9,0,10
	lwz 29,basic_combatarmor_info@l(28)
	stw 24,16(11)
	stw 25,4(11)
	stw 3,8(11)
	stw 4,12(11)
	lwz 5,16(8)
	lwz 11,4(8)
	lwz 4,8(8)
	lwz 3,12(8)
	stwx 29,26,0
	lwz 28,basic_bodyarmor_info@l(27)
	stw 5,16(7)
	stw 11,4(7)
	stw 4,8(7)
	stw 3,12(7)
	lwz 11,16(6)
	lwz 8,4(6)
	lwz 7,8(6)
	lwz 5,12(6)
	stwx 28,10,0
	stw 11,16(9)
	stw 23,actual_class@l(22)
	stw 8,4(9)
	stw 7,8(9)
	stw 5,12(9)
.L149:
	lwz 0,484(1)
	mtlr 0
	lmw 14,392(1)
	lfd 30,464(1)
	lfd 31,472(1)
	la 1,480(1)
	blr
.Lfe1:
	.size	 ReadClass,.Lfe1-ReadClass
	.align 2
	.globl ClassInitPersistant
	.type	 ClassInitPersistant,@function
ClassInitPersistant:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 29,classtbl@ha
	mulli 27,4,2924
	mr 28,3
	la 29,classtbl@l(29)
	addi 24,28,740
	addi 9,29,1208
	addi 11,29,1204
	lwzx 0,9,27
	addi 10,29,1212
	addi 8,29,1216
	addi 7,29,1220
	addi 6,29,1224
	stw 0,724(28)
	addi 26,29,1228
	addi 25,29,1232
	lwzx 9,11,27
	addi 4,29,1236
	mr 3,24
	add 4,27,4
	li 5,1024
	stw 9,728(28)
	lwzx 0,10,27
	stw 0,1764(28)
	lwzx 9,8,27
	stw 9,1768(28)
	lwzx 0,7,27
	stw 0,1772(28)
	lwzx 9,6,27
	stw 9,1776(28)
	lwzx 0,26,27
	stw 0,1780(28)
	lwzx 9,25,27
	stw 9,1784(28)
	crxor 6,6,6
	bl memcpy
	li 0,0
	addi 29,29,2860
	sth 0,126(28)
	lis 9,itemlist@ha
	li 10,1
	lwzx 11,29,27
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,11
	mullw 9,9,0
	srawi 9,9,2
	slwi 0,9,2
	stw 9,736(28)
	stwx 10,24,0
	stw 11,1792(28)
	stw 11,1788(28)
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 ClassInitPersistant,.Lfe2-ClassInitPersistant
	.section	".rodata"
	.align 2
.LC31:
	.string	"Keys has been already binded\n"
	.align 2
.LC32:
	.string	"Sorry, this class has no bindings defined\n"
	.globl classmenu
	.section	".data"
	.align 2
	.type	 classmenu,@object
classmenu:
	.long .LC33
	.long 1
	.long 0
	.long 0
	.long .LC34
	.long 1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 1
	.long 0
	.long 0
	.long 1
	.long 2
	.long 0
	.long 0
	.long 1
	.long 3
	.long 0
	.long 0
	.long 1
	.long 4
	.long 0
	.long 0
	.long 1
	.long 5
	.long 0
	.long 0
	.long 1
	.long 6
	.long 0
	.long 0
	.long 1
	.long 7
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC35
	.long 1
	.long 0
	.long LastClassPage
	.long .LC36
	.long 1
	.long 0
	.long NextClassPage
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC37
	.long 0
	.long 0
	.long EnterInfoClassMenu
	.long .LC38
	.long 0
	.long 0
	.long ReturnToMain
	.section	".rodata"
	.align 2
.LC38:
	.string	"Return to Main Menu"
	.align 2
.LC37:
	.string	"View Class Info"
	.align 2
.LC36:
	.string	"Next..."
	.align 2
.LC35:
	.string	"Last..."
	.align 2
.LC34:
	.string	"*Class Selection"
	.align 2
.LC33:
	.string	"*Wyrm II"
	.size	 classmenu,288
	.align 2
.LC39:
	.string	"Unnamed"
	.section	".text"
	.align 2
	.globl ClassMenu
	.type	 ClassMenu,@function
ClassMenu:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	mr 30,3
	lis 9,actual_class@ha
	lwz 10,84(30)
	lwz 11,actual_class@l(9)
	lwz 0,3532(10)
	cmpw 0,0,11
	bc 4,1,.L192
	li 0,0
	stw 0,3532(10)
.L192:
	lwz 11,84(30)
	lwz 9,3532(11)
	srawi 0,9,31
	srwi 0,0,29
	add 9,9,0
	srawi 10,9,3
	slwi 7,10,3
	addi 12,7,8
	mr 28,7
	cmpw 0,7,12
	bc 4,0,.L194
	lis 9,classmenu@ha
	lis 11,actual_class@ha
	mulli 5,7,2924
	addi 0,7,-3
	la 31,classmenu@l(9)
	lwz 29,actual_class@l(11)
	mulli 0,0,-16
	slwi 11,10,7
	lis 9,ClassSelect@ha
	la 24,ClassSelect@l(9)
	addi 3,31,12
	add 6,11,0
	lis 25,classmenu@ha
	lis 26,classtbl@ha
	lis 27,.LC39@ha
	li 4,0
.L195:
	cmpw 0,7,29
	bc 4,0,.L196
	la 9,classtbl@l(26)
	la 10,.LC39@l(27)
	lbzx 0,9,5
	addi 11,28,-3
	la 8,classmenu@l(25)
	add 9,5,9
	subf 11,11,7
	neg 0,0
	slwi 11,11,4
	srawi 0,0,31
	andc 10,10,0
	and 9,9,0
	or 9,9,10
	stwx 9,8,6
	stwx 24,3,11
	b .L199
.L196:
	stwx 4,6,31
	stwx 4,6,3
.L199:
	addi 7,7,1
	addi 5,5,2924
	cmpw 0,7,12
	addi 6,6,16
	bc 12,0,.L195
.L194:
	lis 9,classmenu@ha
	lis 8,.LC35@ha
	la 31,classmenu@l(9)
	lis 11,LastClassPage@ha
	lis 9,.LC36@ha
	lis 10,NextClassPage@ha
	la 9,.LC36@l(9)
	la 8,.LC35@l(8)
	la 11,LastClassPage@l(11)
	la 10,NextClassPage@l(10)
	stw 8,208(31)
	stw 11,220(31)
	stw 9,224(31)
	stw 10,236(31)
	lwz 9,84(30)
	lwz 0,3532(9)
	cmpwi 0,0,7
	bc 12,1,.L201
	li 0,0
	stw 0,220(31)
	stw 0,208(31)
.L201:
	lis 9,actual_class@ha
	lwz 0,actual_class@l(9)
	cmpw 0,0,12
	bc 4,0,.L202
	li 0,0
	stw 0,236(31)
	stw 0,224(31)
.L202:
	mr 3,30
	bl PMenu_Close
	lwz 9,84(30)
	mr 3,30
	mr 4,31
	li 6,18
	lwz 5,3532(9)
	srawi 0,5,31
	srwi 0,0,29
	add 0,5,0
	rlwinm 0,0,0,0,28
	subf 5,0,5
	addi 5,5,3
	bl PMenu_Open
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 ClassMenu,.Lfe3-ClassMenu
	.globl infoclassmenu
	.section	".data"
	.align 2
	.type	 infoclassmenu,@object
infoclassmenu:
	.long .LC33
	.long 1
	.long 0
	.long 0
	.long .LC40
	.long 1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 1
	.long 0
	.long 0
	.long 1
	.long 2
	.long 0
	.long 0
	.long 1
	.long 3
	.long 0
	.long 0
	.long 1
	.long 4
	.long 0
	.long 0
	.long 1
	.long 5
	.long 0
	.long 0
	.long 1
	.long 6
	.long 0
	.long 0
	.long 1
	.long 7
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC35
	.long 1
	.long 0
	.long LastInfoClassPage
	.long .LC36
	.long 1
	.long 0
	.long NextInfoClassPage
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC41
	.long 0
	.long 0
	.long EnterClassMenu
	.long .LC38
	.long 0
	.long 0
	.long ReturnToMain
	.section	".rodata"
	.align 2
.LC41:
	.string	"Return to Class Selection"
	.align 2
.LC40:
	.string	"*Class Information"
	.size	 infoclassmenu,288
	.section	".text"
	.align 2
	.globl InfoClassMenu
	.type	 InfoClassMenu,@function
InfoClassMenu:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	mr 30,3
	lis 9,actual_class@ha
	lwz 10,84(30)
	lwz 11,actual_class@l(9)
	lwz 0,3532(10)
	cmpw 0,0,11
	bc 4,1,.L211
	li 0,0
	stw 0,3532(10)
.L211:
	lwz 11,84(30)
	lwz 9,3532(11)
	srawi 0,9,31
	srwi 0,0,29
	add 9,9,0
	srawi 10,9,3
	slwi 7,10,3
	addi 12,7,8
	mr 28,7
	cmpw 0,7,12
	bc 4,0,.L213
	lis 9,infoclassmenu@ha
	lis 11,actual_class@ha
	mulli 5,7,2924
	addi 0,7,-3
	la 31,infoclassmenu@l(9)
	lwz 29,actual_class@l(11)
	mulli 0,0,-16
	slwi 11,10,7
	lis 9,InfoClassSelect@ha
	la 24,InfoClassSelect@l(9)
	addi 3,31,12
	add 6,11,0
	lis 25,infoclassmenu@ha
	lis 26,classtbl@ha
	lis 27,.LC39@ha
	li 4,0
.L214:
	cmpw 0,7,29
	bc 4,0,.L215
	la 9,classtbl@l(26)
	la 10,.LC39@l(27)
	lbzx 0,9,5
	addi 11,28,-3
	la 8,infoclassmenu@l(25)
	add 9,5,9
	subf 11,11,7
	neg 0,0
	slwi 11,11,4
	srawi 0,0,31
	andc 10,10,0
	and 9,9,0
	or 9,9,10
	stwx 9,8,6
	stwx 24,3,11
	b .L218
.L215:
	stwx 4,6,31
	stwx 4,6,3
.L218:
	addi 7,7,1
	addi 5,5,2924
	cmpw 0,7,12
	addi 6,6,16
	bc 12,0,.L214
.L213:
	lis 9,infoclassmenu@ha
	lis 8,.LC35@ha
	la 31,infoclassmenu@l(9)
	lis 11,LastInfoClassPage@ha
	lis 9,.LC36@ha
	lis 10,NextInfoClassPage@ha
	la 9,.LC36@l(9)
	la 8,.LC35@l(8)
	la 11,LastInfoClassPage@l(11)
	la 10,NextInfoClassPage@l(10)
	stw 8,208(31)
	stw 11,220(31)
	stw 9,224(31)
	stw 10,236(31)
	lwz 9,84(30)
	lwz 0,3532(9)
	cmpwi 0,0,7
	bc 12,1,.L220
	li 0,0
	stw 0,220(31)
	stw 0,208(31)
.L220:
	lis 9,actual_class@ha
	lwz 0,actual_class@l(9)
	cmpw 0,0,12
	bc 4,0,.L221
	li 0,0
	stw 0,236(31)
	stw 0,224(31)
.L221:
	mr 3,30
	bl PMenu_Close
	lwz 9,84(30)
	mr 3,30
	mr 4,31
	li 6,18
	lwz 5,3532(9)
	srawi 0,5,31
	srwi 0,0,29
	add 0,5,0
	rlwinm 0,0,0,0,28
	subf 5,0,5
	addi 5,5,3
	bl PMenu_Open
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 InfoClassMenu,.Lfe4-InfoClassMenu
	.globl infoclasspage
	.section	".data"
	.align 2
	.type	 infoclasspage,@object
infoclasspage:
	.long .LC33
	.long 1
	.long 0
	.long 0
	.long .LC40
	.long 1
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
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 1
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
	.long .LC42
	.long 2
	.long 0
	.long ShowClassPage2
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC43
	.long 0
	.long 0
	.long InfoClassMenu
	.long .LC38
	.long 0
	.long 0
	.long ReturnToMain
	.section	".rodata"
	.align 2
.LC43:
	.string	"Return to Class Info"
	.align 2
.LC42:
	.string	"More..."
	.size	 infoclasspage,288
	.lcomm	classname.57,32,4
	.lcomm	skinname.58,32,4
	.lcomm	speedstring.59,32,4
	.lcomm	powerstring.60,32,4
	.lcomm	resistancestring.61,32,4
	.lcomm	jumpstring.62,32,4
	.lcomm	knockbackstring.63,32,4
	.lcomm	healthstring.64,32,4
	.lcomm	maxhealthstring.65,32,4
	.align 2
.LC44:
	.string	"Name: %s"
	.align 2
.LC45:
	.string	"Skin: %s"
	.align 2
.LC46:
	.string	"Speed:      %f"
	.align 2
.LC47:
	.string	"Power:      %f"
	.align 2
.LC48:
	.string	"Resistance: %f"
	.align 2
.LC49:
	.string	"Jump:       %f"
	.align 2
.LC50:
	.string	"Knockback:  %f"
	.align 2
.LC51:
	.string	"Health:     %3d"
	.align 2
.LC52:
	.string	"Max Health: %3d"
	.align 2
.LC53:
	.string	"This class has key bindings"
	.align 2
.LC54:
	.long 0x0
	.section	".text"
	.align 2
	.globl ShowClassPage
	.type	 ShowClassPage,@function
ShowClassPage:
	stwu 1,-64(1)
	mflr 0
	stmw 21,20(1)
	stw 0,68(1)
	mr 31,3
	lis 9,classtbl@ha
	lwz 11,84(31)
	la 24,classtbl@l(9)
	lis 28,classname.57@ha
	lis 4,.LC44@ha
	la 3,classname.57@l(28)
	lwz 25,3532(11)
	la 4,.LC44@l(4)
	mulli 26,25,2924
	add 29,26,24
	mr 5,29
	crxor 6,6,6
	bl sprintf
	lbz 11,32(29)
	lis 9,infoclasspage@ha
	la 28,classname.57@l(28)
	la 27,infoclasspage@l(9)
	li 0,0
	cmpwi 0,11,0
	stw 28,32(27)
	stw 0,48(27)
	bc 12,2,.L224
	lis 9,.LC54@ha
	lis 11,setclassskin@ha
	la 9,.LC54@l(9)
	lfs 13,0(9)
	lwz 9,setclassskin@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L224
	lis 29,skinname.58@ha
	addi 5,24,32
	lis 4,.LC45@ha
	la 3,skinname.58@l(29)
	add 5,26,5
	la 4,.LC45@l(4)
	crxor 6,6,6
	bl sprintf
	la 29,skinname.58@l(29)
	stw 29,48(27)
.L224:
	lis 29,classtbl@ha
	mulli 28,25,2924
	lis 21,speedstring.59@ha
	la 29,classtbl@l(29)
	lis 4,.LC46@ha
	addi 9,29,1184
	la 4,.LC46@l(4)
	lfsx 1,9,28
	la 3,speedstring.59@l(21)
	lis 24,powerstring.60@ha
	lis 23,resistancestring.61@ha
	lis 22,jumpstring.62@ha
	lis 25,knockbackstring.63@ha
	lis 27,healthstring.64@ha
	lis 26,maxhealthstring.65@ha
	creqv 6,6,6
	bl sprintf
	addi 9,29,1188
	lis 4,.LC47@ha
	lfsx 1,9,28
	la 4,.LC47@l(4)
	la 3,powerstring.60@l(24)
	creqv 6,6,6
	bl sprintf
	addi 9,29,1192
	lis 4,.LC48@ha
	lfsx 1,9,28
	la 4,.LC48@l(4)
	la 3,resistancestring.61@l(23)
	creqv 6,6,6
	bl sprintf
	addi 9,29,1196
	lis 4,.LC49@ha
	lfsx 1,9,28
	la 4,.LC49@l(4)
	la 3,jumpstring.62@l(22)
	creqv 6,6,6
	bl sprintf
	addi 9,29,1200
	lis 4,.LC50@ha
	lfsx 1,9,28
	la 4,.LC50@l(4)
	la 3,knockbackstring.63@l(25)
	creqv 6,6,6
	bl sprintf
	addi 9,29,1208
	lis 4,.LC51@ha
	lwzx 5,9,28
	la 4,.LC51@l(4)
	la 3,healthstring.64@l(27)
	crxor 6,6,6
	bl sprintf
	addi 9,29,1204
	lis 4,.LC52@ha
	lwzx 5,9,28
	la 3,maxhealthstring.65@l(26)
	la 4,.LC52@l(4)
	crxor 6,6,6
	bl sprintf
	add 28,28,29
	lis 9,infoclasspage@ha
	lbz 28,160(28)
	la 11,infoclasspage@l(9)
	la 27,healthstring.64@l(27)
	la 26,maxhealthstring.65@l(26)
	la 21,speedstring.59@l(21)
	stw 27,64(11)
	cmpwi 0,28,0
	la 24,powerstring.60@l(24)
	stw 26,80(11)
	la 23,resistancestring.61@l(23)
	la 22,jumpstring.62@l(22)
	stw 21,96(11)
	la 25,knockbackstring.63@l(25)
	stw 24,112(11)
	stw 23,128(11)
	stw 22,144(11)
	stw 25,160(11)
	bc 12,2,.L225
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	stw 9,176(11)
	b .L226
.L225:
	stw 28,176(11)
.L226:
	mr 3,31
	bl PMenu_Close
	lis 4,infoclasspage@ha
	mr 3,31
	la 4,infoclasspage@l(4)
	li 5,14
	li 6,18
	bl PMenu_Open
	lwz 0,68(1)
	mtlr 0
	lmw 21,20(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 ShowClassPage,.Lfe5-ShowClassPage
	.globl infoclasspage2
	.section	".data"
	.align 2
	.type	 infoclasspage2,@object
infoclasspage2:
	.long .LC33
	.long 1
	.long 0
	.long 0
	.long .LC40
	.long 1
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
	.long 0
	.long 0
	.long .LC55
	.long 0
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC42
	.long 2
	.long 0
	.long EnterShowClassPage3
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC43
	.long 0
	.long 0
	.long InfoClassMenu
	.long .LC38
	.long 0
	.long 0
	.long ReturnToMain
	.section	".rodata"
	.align 2
.LC55:
	.string	"Initial Weapon:"
	.size	 infoclasspage2,288
	.lcomm	maxshellsstring.69,32,4
	.lcomm	maxbulletsstring.70,32,4
	.lcomm	maxgrenadesstring.71,32,4
	.lcomm	maxrocketsstring.72,32,4
	.lcomm	maxslugsstring.73,32,4
	.lcomm	maxcellsstring.74,32,4
	.lcomm	initialweaponstring.75,64,4
	.align 2
.LC56:
	.string	"Max Shells:   %d"
	.align 2
.LC57:
	.string	"Max Bullets:  %d"
	.align 2
.LC58:
	.string	"Max Grenades: %d"
	.align 2
.LC59:
	.string	"Max Rockets:  %d"
	.align 2
.LC60:
	.string	"Max Slugs:    %d"
	.align 2
.LC61:
	.string	"Max Cells:    %d"
	.align 2
.LC62:
	.string	">%s<"
	.section	".text"
	.align 2
	.globl ShowClassPage2
	.type	 ShowClassPage2,@function
ShowClassPage2:
	stwu 1,-64(1)
	mflr 0
	stmw 20,16(1)
	stw 0,68(1)
	mr 20,3
	lis 29,classtbl@ha
	lwz 9,84(20)
	la 29,classtbl@l(29)
	lis 21,maxshellsstring.69@ha
	addi 11,29,1216
	lis 4,.LC56@ha
	lwz 28,3532(9)
	la 4,.LC56@l(4)
	la 3,maxshellsstring.69@l(21)
	lis 27,maxbulletsstring.70@ha
	lis 26,maxgrenadesstring.71@ha
	mulli 28,28,2924
	lis 25,maxrocketsstring.72@ha
	lis 24,maxslugsstring.73@ha
	lis 23,maxcellsstring.74@ha
	lis 22,initialweaponstring.75@ha
	lwzx 5,11,28
	crxor 6,6,6
	bl sprintf
	addi 9,29,1212
	lis 4,.LC57@ha
	lwzx 5,9,28
	la 4,.LC57@l(4)
	la 3,maxbulletsstring.70@l(27)
	crxor 6,6,6
	bl sprintf
	addi 9,29,1224
	lis 4,.LC58@ha
	lwzx 5,9,28
	la 4,.LC58@l(4)
	la 3,maxgrenadesstring.71@l(26)
	crxor 6,6,6
	bl sprintf
	addi 9,29,1220
	lis 4,.LC59@ha
	lwzx 5,9,28
	la 4,.LC59@l(4)
	la 3,maxrocketsstring.72@l(25)
	crxor 6,6,6
	bl sprintf
	addi 9,29,1232
	lis 4,.LC60@ha
	lwzx 5,9,28
	la 4,.LC60@l(4)
	la 3,maxslugsstring.73@l(24)
	crxor 6,6,6
	bl sprintf
	addi 9,29,1228
	lis 4,.LC61@ha
	lwzx 5,9,28
	la 4,.LC61@l(4)
	la 3,maxcellsstring.74@l(23)
	crxor 6,6,6
	bl sprintf
	addi 29,29,2860
	lis 4,.LC62@ha
	lwzx 9,29,28
	la 4,.LC62@l(4)
	la 3,initialweaponstring.75@l(22)
	lwz 5,40(9)
	crxor 6,6,6
	bl sprintf
	lis 29,infoclasspage2@ha
	la 21,maxshellsstring.69@l(21)
	la 29,infoclasspage2@l(29)
	la 27,maxbulletsstring.70@l(27)
	la 26,maxgrenadesstring.71@l(26)
	la 25,maxrocketsstring.72@l(25)
	stw 21,48(29)
	la 24,maxslugsstring.73@l(24)
	la 23,maxcellsstring.74@l(23)
	stw 27,64(29)
	la 22,initialweaponstring.75@l(22)
	mr 3,20
	stw 26,80(29)
	stw 25,96(29)
	stw 24,112(29)
	stw 23,128(29)
	stw 22,176(29)
	bl PMenu_Close
	mr 3,20
	mr 4,29
	li 5,14
	li 6,18
	bl PMenu_Open
	lwz 0,68(1)
	mtlr 0
	lmw 20,16(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 ShowClassPage2,.Lfe6-ShowClassPage2
	.globl infoclasspage3
	.section	".data"
	.align 2
	.type	 infoclasspage3,@object
infoclasspage3:
	.long .LC33
	.long 1
	.long 0
	.long 0
	.long .LC40
	.long 1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC63
	.long 1
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
	.long .LC42
	.long 2
	.long 0
	.long CheckShowClassPage
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC43
	.long 0
	.long 0
	.long InfoClassMenu
	.long .LC38
	.long 0
	.long 0
	.long ReturnToMain
	.section	".rodata"
	.align 2
.LC63:
	.string	"Initial Inventory:"
	.size	 infoclasspage3,288
	.lcomm	invstring.82,288,1
	.align 2
.LC64:
	.string	"%-20s %3d"
	.section	".text"
	.align 2
	.globl ShowClassPage3
	.type	 ShowClassPage3,@function
ShowClassPage3:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 27,3
	lis 9,itemlist@ha
	lwz 11,84(27)
	la 28,itemlist@l(9)
	li 30,0
	li 25,1
	li 31,0
	lwz 26,3532(11)
	lwz 29,3536(11)
	b .L232
.L238:
	lis 3,invstring.82@ha
	slwi 0,30,5
	lwz 5,40(28)
	la 3,invstring.82@l(3)
	lis 4,.LC64@ha
	add 3,0,3
	la 4,.LC64@l(4)
	addi 30,30,1
	crxor 6,6,6
	bl sprintf
.L234:
	addi 31,31,1
	addi 28,28,84
.L232:
	lis 9,game+1556@ha
	lwz 0,game+1556@l(9)
	cmpw 0,31,0
	bc 4,0,.L233
	lis 9,classtbl@ha
	mulli 11,26,2924
	slwi 0,31,2
	la 9,classtbl@l(9)
	add 0,0,11
	addi 9,9,1236
	lwzx 6,9,0
	cmpwi 0,6,0
	bc 12,2,.L234
	cmpwi 0,29,0
	bc 12,2,.L237
	addi 29,29,-1
	b .L234
.L237:
	cmpwi 0,30,8
	bc 4,1,.L238
	li 30,10
.L233:
	cmpwi 0,30,10
	bc 4,2,.L240
	li 25,0
	li 30,9
.L240:
	li 10,9
	lis 9,infoclasspage3@ha
	mtctr 10
	cmpwi 7,25,0
	la 9,infoclasspage3@l(9)
	lis 11,invstring.82@ha
	addi 9,9,64
	la 11,invstring.82@l(11)
	li 31,0
	li 0,0
.L250:
	cmpw 0,31,30
	bc 4,0,.L245
	stw 11,0(9)
	b .L243
.L245:
	stw 0,0(9)
.L243:
	addi 9,9,16
	addi 11,11,32
	addi 31,31,1
	bdnz .L250
	bc 12,30,.L248
	lwz 9,84(27)
	li 0,-1
	b .L251
.L248:
	lwz 9,84(27)
	lwz 0,3536(9)
	add 0,0,30
.L251:
	stw 0,3536(9)
	mr 3,27
	bl PMenu_Close
	lis 4,infoclasspage3@ha
	mr 3,27
	la 4,infoclasspage3@l(4)
	li 5,14
	li 6,18
	bl PMenu_Open
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 ShowClassPage3,.Lfe7-ShowClassPage3
	.section	".rodata"
	.align 2
.LC65:
	.string	"%s joined the game as %s.\n"
	.align 2
.LC66:
	.string	"%s joined the game.\n"
	.globl classjoinmenu
	.section	".data"
	.align 2
	.type	 classjoinmenu,@object
classjoinmenu:
	.long .LC33
	.long 1
	.long 0
	.long 0
	.long .LC67
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC68
	.long 0
	.long 0
	.long EnterClassMenu
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC69
	.long 0
	.long 0
	.long BindClassKeys
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long 0
	.long 0
	.long ClassJoinGame
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC71
	.long 0
	.long 0
	.long CTFChaseCam
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC72
	.long 0
	.long 0
	.long 0
	.long .LC73
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long 0
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC75:
	.string	"(TAB to Return)"
	.align 2
.LC74:
	.string	"ESC to Exit Menu"
	.align 2
.LC73:
	.string	"ENTER to select"
	.align 2
.LC72:
	.string	"Use [ and ] to move cursor"
	.align 2
.LC71:
	.string	"Chase Camera"
	.align 2
.LC70:
	.string	"Join Game"
	.align 2
.LC69:
	.string	"Bind Class Keys"
	.align 2
.LC68:
	.string	"Select Class"
	.align 2
.LC67:
	.string	"*World of Destruction"
	.size	 classjoinmenu,272
	.lcomm	levelname.92,32,4
	.align 2
.LC76:
	.string	"Leave Chase Camera"
	.align 2
.LC77:
	.string	"Sorry, but classes aren't activated.\n"
	.align 2
.LC78:
	.string	"You're using the %s Class.\n"
	.align 2
.LC79:
	.string	"You're using the class number %d.\n"
	.align 2
.LC80:
	.string	"Info about what class?\n"
	.align 2
.LC81:
	.string	"--------------------------------------\n"
	.align 2
.LC82:
	.string	"Name: %s\n"
	.align 2
.LC83:
	.string	"Skin: %s\n"
	.align 2
.LC84:
	.string	"This class has key bindings included\n"
	.align 2
.LC85:
	.string	"Speed: %f\n"
	.align 2
.LC86:
	.string	"Power: %f\n"
	.align 2
.LC87:
	.string	"Resistance: %f\n"
	.align 2
.LC88:
	.string	"Jump: %f\n"
	.align 2
.LC89:
	.string	"Knockback: %f\n"
	.align 2
.LC90:
	.string	"Health:       %3d    Max Health:  %3d\n"
	.align 2
.LC91:
	.string	"Max Bullets:  %3d    Max Shells:  %3d\n"
	.align 2
.LC92:
	.string	"Max Grenades: %3d    Max Rockets: %3d\n"
	.align 2
.LC93:
	.string	"Max Slugs:    %3d    Max Cells:   %3d\n"
	.align 2
.LC94:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_InfoClass
	.type	 Cmd_InfoClass,@function
Cmd_InfoClass:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 30,3
	la 31,gi@l(9)
	lwz 9,164(31)
	mtlr 9
	blrl
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L289
	lwz 0,8(31)
	lis 5,.LC80@ha
	mr 3,30
	la 5,.LC80@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L288
.L289:
	lwz 0,164(31)
	li 29,0
	mtlr 0
	blrl
	mr 31,3
	lis 28,actual_class@ha
	b .L290
.L292:
	addi 29,29,1
.L290:
	mulli 0,29,2924
	lis 4,classtbl@ha
	mr 3,31
	la 4,classtbl@l(4)
	add 4,0,4
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L291
	lis 9,actual_class@ha
	lwz 0,actual_class@l(9)
	cmpw 0,29,0
	bc 12,0,.L292
.L291:
	lis 9,actual_class@ha
	lwz 0,actual_class@l(9)
	cmpw 0,29,0
	bc 4,2,.L295
	mr 3,31
	bl atoi
	mr 29,3
.L295:
	cmpwi 0,29,0
	bc 12,0,.L297
	lwz 0,actual_class@l(28)
	cmpw 0,29,0
	bc 12,0,.L296
.L297:
	li 29,0
.L296:
	lis 9,gi@ha
	lis 5,.LC81@ha
	mulli 29,29,2924
	la 28,gi@l(9)
	la 5,.LC81@l(5)
	lwz 9,8(28)
	mr 3,30
	li 4,2
	mr 31,29
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,classtbl@ha
	lwz 11,8(28)
	lis 5,.LC82@ha
	la 27,classtbl@l(9)
	la 5,.LC82@l(5)
	add 29,29,27
	mr 3,30
	mtlr 11
	li 4,2
	mr 6,29
	crxor 6,6,6
	blrl
	lbz 0,32(29)
	cmpwi 0,0,0
	bc 12,2,.L298
	lis 9,.LC94@ha
	lis 11,setclassskin@ha
	la 9,.LC94@l(9)
	lfs 13,0(9)
	lwz 9,setclassskin@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L298
	lwz 0,8(28)
	addi 6,27,32
	lis 5,.LC83@ha
	la 5,.LC83@l(5)
	add 6,31,6
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L298:
	lis 9,classtbl@ha
	la 28,classtbl@l(9)
	add 11,31,28
	lbz 0,160(11)
	cmpwi 0,0,0
	bc 12,2,.L299
	lis 9,gi+8@ha
	lis 5,.LC84@ha
	lwz 0,gi+8@l(9)
	la 5,.LC84@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L299:
	addi 9,28,1184
	lis 29,gi@ha
	la 29,gi@l(29)
	lfsx 1,9,31
	lis 5,.LC85@ha
	lwz 9,8(29)
	la 5,.LC85@l(5)
	mr 3,30
	li 4,2
	mtlr 9
	creqv 6,6,6
	blrl
	addi 9,28,1188
	lwz 11,8(29)
	lis 5,.LC86@ha
	lfsx 1,9,31
	la 5,.LC86@l(5)
	mr 3,30
	mtlr 11
	li 4,2
	creqv 6,6,6
	blrl
	addi 9,28,1192
	lwz 11,8(29)
	lis 5,.LC87@ha
	lfsx 1,9,31
	la 5,.LC87@l(5)
	mr 3,30
	mtlr 11
	li 4,2
	creqv 6,6,6
	blrl
	addi 9,28,1196
	lwz 11,8(29)
	lis 5,.LC88@ha
	lfsx 1,9,31
	la 5,.LC88@l(5)
	mr 3,30
	mtlr 11
	li 4,2
	creqv 6,6,6
	blrl
	addi 9,28,1200
	lwz 11,8(29)
	lis 5,.LC89@ha
	lfsx 1,9,31
	la 5,.LC89@l(5)
	mr 3,30
	mtlr 11
	li 4,2
	creqv 6,6,6
	blrl
	lwz 10,8(29)
	addi 9,28,1208
	addi 11,28,1204
	lis 5,.LC90@ha
	lwzx 6,9,31
	mr 3,30
	la 5,.LC90@l(5)
	lwzx 7,11,31
	mtlr 10
	li 4,2
	crxor 6,6,6
	blrl
	lwz 10,8(29)
	addi 9,28,1212
	addi 11,28,1216
	lis 5,.LC91@ha
	lwzx 6,9,31
	mr 3,30
	la 5,.LC91@l(5)
	lwzx 7,11,31
	mtlr 10
	li 4,2
	crxor 6,6,6
	blrl
	lwz 10,8(29)
	addi 9,28,1224
	addi 11,28,1220
	lis 5,.LC92@ha
	lwzx 6,9,31
	mr 3,30
	la 5,.LC92@l(5)
	lwzx 7,11,31
	mtlr 10
	li 4,2
	crxor 6,6,6
	blrl
	lwz 10,8(29)
	addi 9,28,1228
	addi 11,28,1232
	lis 5,.LC93@ha
	mr 3,30
	lwzx 7,9,31
	la 5,.LC93@l(5)
	li 4,2
	mtlr 10
	lwzx 6,11,31
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC81@ha
	mr 3,30
	la 5,.LC81@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L288:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 Cmd_InfoClass,.Lfe8-Cmd_InfoClass
	.align 2
	.globl ClassOpenJoinMenu
	.type	 ClassOpenJoinMenu,@function
ClassOpenJoinMenu:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3888(9)
	cmpwi 0,0,0
	bc 12,2,.L270
	lis 9,.LC76@ha
	lis 11,classjoinmenu+160@ha
	la 9,.LC76@l(9)
	b .L303
.L270:
	lis 9,.LC71@ha
	lis 11,classjoinmenu+160@ha
	la 9,.LC71@l(9)
.L303:
	stw 9,classjoinmenu+160@l(11)
	lis 9,g_edicts@ha
	lis 11,levelname.92@ha
	lwz 10,g_edicts@l(9)
	li 0,42
	la 3,levelname.92@l(11)
	stb 0,levelname.92@l(11)
	lwz 4,276(10)
	cmpwi 0,4,0
	bc 12,2,.L272
	addi 3,3,1
	li 5,30
	bl strncpy
	b .L273
.L272:
	lis 4,level+72@ha
	addi 3,3,1
	la 4,level+72@l(4)
	li 5,30
	bl strncpy
.L273:
	lis 9,levelname.92@ha
	lis 4,classjoinmenu@ha
	la 9,levelname.92@l(9)
	la 4,classjoinmenu@l(4)
	stw 9,32(4)
	li 0,0
	mr 3,31
	stb 0,31(9)
	li 6,17
	lwz 9,84(31)
	lwz 5,3888(9)
	addic 5,5,-1
	subfe 5,5,5
	nor 0,5,5
	rlwinm 5,5,0,30,31
	andi. 0,0,10
	or 5,5,0
	bl PMenu_Open
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 ClassOpenJoinMenu,.Lfe9-ClassOpenJoinMenu
	.align 2
	.globl GetInitialWeapon
	.type	 GetInitialWeapon,@function
GetInitialWeapon:
	mr. 3,3
	bc 4,2,.L301
	li 3,0
	blr
.L301:
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L302
	lwz 0,3528(3)
	lis 9,classtbl@ha
	la 9,classtbl@l(9)
	mulli 0,0,2924
	addi 9,9,2860
	lwzx 3,9,0
	blr
.L302:
	li 3,0
	blr
.Lfe10:
	.size	 GetInitialWeapon,.Lfe10-GetInitialWeapon
	.comm	classtbl,93568,4
	.comm	actual_class,4,4
	.align 2
	.globl ParseClass
	.type	 ParseClass,@function
ParseClass:
	mr. 0,3
	bc 4,0,.L163
	li 3,0
	blr
.L163:
	lis 9,actual_class@ha
	lwz 3,actual_class@l(9)
	cmpw 0,0,3
	bc 4,0,.L164
	mr 3,0
	blr
.L164:
	addi 3,3,-1
	blr
.Lfe11:
	.size	 ParseClass,.Lfe11-ParseClass
	.section	".rodata"
	.align 2
.LC95:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClassSkin
	.type	 ClassSkin,@function
ClassSkin:
	lis 11,.LC95@ha
	lis 9,setclassskin@ha
	la 11,.LC95@l(11)
	mr 10,3
	lfs 13,0(11)
	lwz 11,setclassskin@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bclr 12,2
	mulli 4,4,2924
	lis 9,classtbl@ha
	la 3,classtbl@l(9)
	add 11,4,3
	lbz 0,32(11)
	cmpwi 0,0,0
	bc 12,2,.L167
	addi 3,3,32
	add 3,4,3
	blr
.L167:
	mr 3,10
	blr
.Lfe12:
	.size	 ClassSkin,.Lfe12-ClassSkin
	.align 2
	.globl SetClassAttributes
	.type	 SetClassAttributes,@function
SetClassAttributes:
	lis 9,classtbl@ha
	mulli 4,4,2924
	la 9,classtbl@l(9)
	addi 11,9,1184
	addi 10,9,1188
	lfsx 13,11,4
	addi 8,9,1192
	addi 11,9,1196
	addi 9,9,1200
	stfs 13,3932(3)
	lfsx 0,10,4
	stfs 0,3936(3)
	lfsx 13,8,4
	stfs 13,3940(3)
	lfsx 0,11,4
	stfs 0,3944(3)
	lfsx 13,9,4
	stfs 13,3948(3)
	blr
.Lfe13:
	.size	 SetClassAttributes,.Lfe13-SetClassAttributes
	.section	".rodata"
	.align 2
.LC96:
	.long 0x0
	.section	".text"
	.align 2
	.globl BindClassKeys
	.type	 BindClassKeys,@function
BindClassKeys:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 10,84(31)
	lwz 0,3544(10)
	cmpwi 0,0,5
	bc 4,1,.L171
	lis 9,gi+8@ha
	lis 5,.LC31@ha
	lwz 0,gi+8@l(9)
	la 5,.LC31@l(5)
	b .L307
.L171:
	lis 9,.LC96@ha
	lis 11,enableclass@ha
	la 9,.LC96@l(9)
	lfs 13,0(9)
	lwz 9,enableclass@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L172
	lwz 0,3528(10)
	lis 9,classtbl@ha
	la 4,classtbl@l(9)
	mulli 11,0,2924
	add 9,11,4
	lbz 0,160(9)
	cmpwi 0,0,0
	bc 12,2,.L173
	addi 4,4,160
	mr 3,31
	add 4,11,4
	bl stuffcmd
	b .L175
.L173:
	lis 9,gi+8@ha
	lis 5,.LC32@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC32@l(5)
.L307:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L170
.L172:
	lis 9,classtbl@ha
	la 4,classtbl@l(9)
	lbz 0,160(4)
	cmpwi 0,0,0
	bc 12,2,.L175
	addi 4,4,160
	mr 3,31
	bl stuffcmd
.L175:
	lwz 9,84(31)
	li 0,6
	stw 0,3544(9)
.L170:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 BindClassKeys,.Lfe14-BindClassKeys
	.align 2
	.globl ClassReturnToMain
	.type	 ClassReturnToMain,@function
ClassReturnToMain:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl PMenu_Close
	lwz 9,84(31)
	lwz 0,3888(9)
	cmpwi 0,0,0
	bc 12,2,.L277
	lis 9,.LC76@ha
	lis 11,classjoinmenu+160@ha
	la 9,.LC76@l(9)
	b .L308
.L277:
	lis 9,.LC71@ha
	lis 11,classjoinmenu+160@ha
	la 9,.LC71@l(9)
.L308:
	stw 9,classjoinmenu+160@l(11)
	lis 9,g_edicts@ha
	lis 11,levelname.92@ha
	lwz 10,g_edicts@l(9)
	li 0,42
	la 3,levelname.92@l(11)
	stb 0,levelname.92@l(11)
	lwz 4,276(10)
	cmpwi 0,4,0
	bc 12,2,.L279
	addi 3,3,1
	li 5,30
	bl strncpy
	b .L280
.L279:
	lis 4,level+72@ha
	addi 3,3,1
	la 4,level+72@l(4)
	li 5,30
	bl strncpy
.L280:
	lis 9,levelname.92@ha
	lis 4,classjoinmenu@ha
	la 9,levelname.92@l(9)
	la 4,classjoinmenu@l(4)
	stw 9,32(4)
	li 0,0
	mr 3,31
	stb 0,31(9)
	li 6,17
	lwz 9,84(31)
	lwz 5,3888(9)
	addic 5,5,-1
	subfe 5,5,5
	nor 0,5,5
	rlwinm 5,5,0,30,31
	andi. 0,0,10
	or 5,5,0
	bl PMenu_Open
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe15:
	.size	 ClassReturnToMain,.Lfe15-ClassReturnToMain
	.align 2
	.globl LastClassPage
	.type	 LastClassPage,@function
LastClassPage:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lwz 9,3532(11)
	srawi 0,9,31
	srwi 0,0,29
	add 9,9,0
	srawi. 9,9,3
	bc 12,2,.L180
	addi 9,9,-1
	slwi 0,9,3
	stw 0,3532(11)
	bl ClassMenu
.L180:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 LastClassPage,.Lfe16-LastClassPage
	.align 2
	.globl NextClassPage
	.type	 NextClassPage,@function
NextClassPage:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 8,84(3)
	lis 11,actual_class@ha
	lwz 10,actual_class@l(11)
	lwz 9,3532(8)
	srawi 0,9,31
	srwi 0,0,29
	add 9,9,0
	rlwinm 9,9,0,0,28
	addi 9,9,8
	cmpw 0,9,10
	bc 4,0,.L182
	stw 9,3532(8)
	bl ClassMenu
.L182:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 NextClassPage,.Lfe17-NextClassPage
	.section	".rodata"
	.align 2
.LC97:
	.long 0x0
	.section	".text"
	.align 2
	.globl ReturnToMain
	.type	 ReturnToMain,@function
ReturnToMain:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC97@ha
	lis 9,ctf@ha
	la 11,.LC97@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L178
	bl CTFReturnToMain
	b .L179
.L178:
	bl ClassReturnToMain
.L179:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 ReturnToMain,.Lfe18-ReturnToMain
	.align 2
	.globl EnterInfoClassMenu
	.type	 EnterInfoClassMenu,@function
EnterInfoClassMenu:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,3528(9)
	stw 0,3532(9)
	bl InfoClassMenu
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 EnterInfoClassMenu,.Lfe19-EnterInfoClassMenu
	.section	".rodata"
	.align 2
.LC98:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClassSelect
	.type	 ClassSelect,@function
ClassSelect:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 7,84(31)
	lis 11,actual_class@ha
	lwz 8,8(30)
	lwz 9,3532(7)
	lwz 10,actual_class@l(11)
	srawi 0,9,31
	srwi 0,0,29
	add 9,9,0
	rlwinm 9,9,0,0,28
	add 8,8,9
	cmpw 0,8,10
	bc 12,0,.L185
	li 0,0
	stw 0,3528(7)
	b .L186
.L185:
	stw 8,3528(7)
.L186:
	lis 9,enableclass@ha
	lwz 10,84(31)
	li 0,0
	lwz 11,enableclass@l(9)
	lis 9,.LC98@ha
	stw 0,3544(10)
	la 9,.LC98@l(9)
	lfs 0,20(11)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 12,2,.L187
	lwz 3,84(31)
	lwz 4,3528(3)
	bl ClassInitPersistant
.L187:
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L188
	mr 3,31
	mr 4,30
	bl CTFReturnToMain
	b .L190
.L188:
	mr 3,31
	mr 4,30
	bl ClassReturnToMain
.L190:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 ClassSelect,.Lfe20-ClassSelect
	.align 2
	.globl EnterClassMenu
	.type	 EnterClassMenu,@function
EnterClassMenu:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,3528(9)
	stw 0,3532(9)
	bl ClassMenu
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 EnterClassMenu,.Lfe21-EnterClassMenu
	.align 2
	.globl LastInfoClassPage
	.type	 LastInfoClassPage,@function
LastInfoClassPage:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lwz 9,3532(11)
	srawi 0,9,31
	srwi 0,0,29
	add 9,9,0
	srawi. 9,9,3
	bc 12,2,.L204
	addi 9,9,-1
	slwi 0,9,3
	stw 0,3532(11)
	bl InfoClassMenu
.L204:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 LastInfoClassPage,.Lfe22-LastInfoClassPage
	.align 2
	.globl NextInfoClassPage
	.type	 NextInfoClassPage,@function
NextInfoClassPage:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 8,84(3)
	lis 11,actual_class@ha
	lwz 10,actual_class@l(11)
	lwz 9,3532(8)
	srawi 0,9,31
	srwi 0,0,29
	add 9,9,0
	rlwinm 9,9,0,0,28
	addi 9,9,8
	cmpw 0,9,10
	bc 4,0,.L206
	stw 9,3532(8)
	bl InfoClassMenu
.L206:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 NextInfoClassPage,.Lfe23-NextInfoClassPage
	.align 2
	.globl InfoClassSelect
	.type	 InfoClassSelect,@function
InfoClassSelect:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 7,84(3)
	lis 10,actual_class@ha
	lwz 11,8(4)
	lwz 9,3532(7)
	lwz 8,actual_class@l(10)
	srawi 0,9,31
	srwi 0,0,29
	add 9,9,0
	rlwinm 9,9,0,0,28
	add 11,11,9
	cmpw 7,11,8
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	and 11,11,0
	stw 11,3532(7)
	bl ShowClassPage
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 InfoClassSelect,.Lfe24-InfoClassSelect
	.align 2
	.globl EnterShowClassPage3
	.type	 EnterShowClassPage3,@function
EnterShowClassPage3:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,game+1556@ha
	li 8,0
	lwz 0,game+1556@l(9)
	li 10,0
	lwz 9,84(3)
	cmpw 0,8,0
	lwz 11,3532(9)
	bc 4,0,.L254
	lis 9,classtbl@ha
	mulli 11,11,2924
	la 9,classtbl@l(9)
	addi 9,9,1236
	mr 7,11
	b .L309
.L255:
	lis 9,game+1556@ha
	addi 10,10,1
	lwz 0,game+1556@l(9)
	cmpw 0,10,0
	bc 4,0,.L254
	lis 9,classtbl@ha
	slwi 11,10,2
	la 9,classtbl@l(9)
	add 11,11,7
	addi 9,9,1236
.L309:
	lwzx 0,9,11
	cmpwi 0,0,0
	bc 12,2,.L255
	li 8,1
.L254:
	cmpwi 0,8,0
	bc 12,2,.L259
	lwz 9,84(3)
	li 0,0
	stw 0,3536(9)
	bl ShowClassPage3
	b .L260
.L259:
	bl ShowClassPage
.L260:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe25:
	.size	 EnterShowClassPage3,.Lfe25-EnterShowClassPage3
	.align 2
	.globl CheckShowClassPage
	.type	 CheckShowClassPage,@function
CheckShowClassPage:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 12,0,.L229
	bl ShowClassPage3
	b .L230
.L229:
	bl ShowClassPage
.L230:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe26:
	.size	 CheckShowClassPage,.Lfe26-CheckShowClassPage
	.align 2
	.globl ClassJoinGame
	.type	 ClassJoinGame,@function
ClassJoinGame:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lwz 9,184(29)
	li 10,0
	li 8,1
	lwz 0,264(29)
	mr 3,29
	lwz 11,84(29)
	rlwinm 9,9,0,0,30
	rlwinm 0,0,0,27,25
	stw 9,184(29)
	stw 0,264(29)
	stw 10,3504(11)
	lwz 9,84(29)
	stw 8,3540(9)
	lwz 4,84(29)
	addi 4,4,188
	bl ClientUserinfoChanged
	mr 3,29
	bl PutClientInServer
	lwz 8,84(29)
	li 0,6
	li 9,32
	stw 0,80(29)
	li 10,14
	lis 11,classtbl@ha
	stb 9,16(8)
	la 11,classtbl@l(11)
	lwz 9,84(29)
	stb 10,17(9)
	lwz 5,84(29)
	lwz 0,3528(5)
	mulli 0,0,2924
	lbzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L262
	lis 9,gi@ha
	add 6,0,11
	lwz 0,gi@l(9)
	lis 4,.LC65@ha
	addi 5,5,700
	la 4,.LC65@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L263
.L262:
	lis 9,gi@ha
	lis 4,.LC66@ha
	lwz 0,gi@l(9)
	la 4,.LC66@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L263:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 ClassJoinGame,.Lfe27-ClassJoinGame
	.align 2
	.globl ClassUpdateJoinMenu
	.type	 ClassUpdateJoinMenu,@function
ClassUpdateJoinMenu:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,3888(9)
	cmpwi 0,0,0
	bc 12,2,.L265
	lis 9,.LC76@ha
	lis 11,classjoinmenu+160@ha
	la 9,.LC76@l(9)
	b .L310
.L265:
	lis 9,.LC71@ha
	lis 11,classjoinmenu+160@ha
	la 9,.LC71@l(9)
.L310:
	stw 9,classjoinmenu+160@l(11)
	lis 9,g_edicts@ha
	lis 11,levelname.92@ha
	lwz 10,g_edicts@l(9)
	li 0,42
	la 3,levelname.92@l(11)
	stb 0,levelname.92@l(11)
	lwz 4,276(10)
	cmpwi 0,4,0
	bc 12,2,.L267
	addi 3,3,1
	li 5,30
	bl strncpy
	b .L268
.L267:
	lis 4,level+72@ha
	addi 3,3,1
	la 4,level+72@l(4)
	li 5,30
	bl strncpy
.L268:
	lis 9,levelname.92@ha
	lis 11,classjoinmenu+32@ha
	la 9,levelname.92@l(9)
	li 0,0
	stw 9,classjoinmenu+32@l(11)
	stb 0,31(9)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 ClassUpdateJoinMenu,.Lfe28-ClassUpdateJoinMenu
	.section	".rodata"
	.align 2
.LC99:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_ShowClass
	.type	 Cmd_ShowClass,@function
Cmd_ShowClass:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC99@ha
	lis 9,enableclass@ha
	la 11,.LC99@l(11)
	lfs 13,0(11)
	lwz 11,enableclass@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L285
	lis 9,gi+8@ha
	lis 5,.LC77@ha
	lwz 0,gi+8@l(9)
	la 5,.LC77@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L284
.L285:
	lwz 9,84(3)
	lis 11,classtbl@ha
	la 11,classtbl@l(11)
	lwz 10,3528(9)
	mulli 6,10,2924
	lbzx 0,11,6
	cmpwi 0,0,0
	bc 12,2,.L286
	lis 9,gi+8@ha
	lis 5,.LC78@ha
	lwz 0,gi+8@l(9)
	add 6,6,11
	la 5,.LC78@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L284
.L286:
	lis 9,gi+8@ha
	lis 5,.LC79@ha
	lwz 0,gi+8@l(9)
	la 5,.LC79@l(5)
	mr 6,10
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L284:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 Cmd_ShowClass,.Lfe29-Cmd_ShowClass
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
