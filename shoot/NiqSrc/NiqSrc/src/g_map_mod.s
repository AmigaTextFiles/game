	.file	"g_map_mod.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.globl map_mod_
	.section	".sdata","aw"
	.align 2
	.type	 map_mod_,@object
	.size	 map_mod_,4
map_mod_:
	.long 0
	.globl map_mod_current_level_
	.align 2
	.type	 map_mod_current_level_,@object
	.size	 map_mod_current_level_,4
map_mod_current_level_:
	.long -1
	.globl map_mod_n_levels_
	.align 2
	.type	 map_mod_n_levels_,@object
	.size	 map_mod_n_levels_,4
map_mod_n_levels_:
	.long 0
	.globl unused_maps
	.align 2
	.type	 unused_maps,@object
	.size	 unused_maps,4
unused_maps:
	.long 0
	.section	".rodata"
	.align 2
.LC0:
	.string	"mapmod_random"
	.align 2
.LC1:
	.string	"0"
	.align 2
.LC2:
	.string	"game"
	.align 2
.LC3:
	.string	""
	.align 2
.LC4:
	.string	"basedir"
	.align 2
.LC5:
	.string	"."
	.align 2
.LC6:
	.string	"%s\\%s\\maps.txt"
	.align 2
.LC7:
	.string	"r"
	.align 2
.LC8:
	.string	"\n==== Map Mod v1.01 set up ====\n"
	.align 2
.LC9:
	.string	"Adding maps to cycle: "
	.align 2
.LC10:
	.string	", "
	.align 2
.LC11:
	.string	"%s"
	.align 2
.LC12:
	.string	"\nMAPMOD_MAXLEVELS exceeded\nUnable to add more levels.\n"
	.align 2
.LC13:
	.string	"\n\n"
	.align 2
.LC14:
	.string	"==== Map Mod v1.01 - missing maps.txt file ====\n"
	.section	".text"
	.align 2
	.globl map_mod_set_up
	.type	 map_mod_set_up,@function
map_mod_set_up:
	stwu 1,-320(1)
	mflr 0
	stmw 21,276(1)
	stw 0,324(1)
	lis 9,gi@ha
	lis 3,.LC0@ha
	la 31,gi@l(9)
	lis 4,.LC1@ha
	lwz 9,144(31)
	la 4,.LC1@l(4)
	li 5,1
	la 3,.LC0@l(3)
	lis 21,gi@ha
	mtlr 9
	lis 23,map_mod_n_levels_@ha
	blrl
	lwz 10,144(31)
	lis 9,mapmod_random@ha
	lis 11,.LC2@ha
	stw 3,mapmod_random@l(9)
	lis 4,.LC3@ha
	li 5,0
	mtlr 10
	la 3,.LC2@l(11)
	la 4,.LC3@l(4)
	blrl
	lwz 9,144(31)
	mr 29,3
	lis 4,.LC5@ha
	lis 3,.LC4@ha
	la 4,.LC5@l(4)
	mtlr 9
	li 5,0
	la 3,.LC4@l(3)
	blrl
	lwz 5,4(3)
	lis 4,.LC6@ha
	lwz 6,4(29)
	la 4,.LC6@l(4)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	lis 4,.LC7@ha
	addi 3,1,8
	la 4,.LC7@l(4)
	bl fopen
	mr. 25,3
	li 8,0
	lis 11,map_mod_@ha
	lis 10,map_mod_current_level_@ha
	li 0,-1
	lis 9,map_mod_n_levels_@ha
	stw 8,map_mod_@l(11)
	stw 0,map_mod_current_level_@l(10)
	stw 8,map_mod_n_levels_@l(9)
	bc 12,2,.L7
	lhz 0,12(25)
	li 30,0
	li 26,0
	li 27,0
	andi. 8,0,32
	bc 4,2,.L9
.L10:
	mr 3,25
	addi 27,27,1
	bl fgetc
	lhz 0,12(25)
	andi. 8,0,32
	bc 12,2,.L10
.L9:
	mr 3,25
	lis 22,map_mod_n_levels_@ha
	bl rewind
	mr 3,27
	bl malloc
	mr 24,3
	li 4,0
	mr 5,27
	bl memset
	mr 31,24
	li 4,1
	mr 5,27
	mr 6,25
	mr 3,24
	bl fread
	lis 29,gi@ha
	lis 3,.LC8@ha
	la 29,gi@l(29)
	la 3,.LC8@l(3)
	lwz 9,4(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,4(29)
	lis 3,.LC9@ha
	la 3,.LC9@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L36:
	lbz 0,0(31)
	cmpwi 0,0,35
	bc 4,2,.L22
	cmpw 0,30,27
	bc 4,0,.L21
.L18:
	lbzu 0,1(31)
	addi 30,30,1
	xori 9,0,13
	xori 0,0,10
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,0,9
	bc 12,2,.L21
	cmpw 0,30,27
	bc 12,0,.L18
	b .L21
.L26:
	cmpw 0,30,27
	bc 4,0,.L21
	addi 26,26,1
	addi 30,30,1
	addi 31,31,1
.L22:
	lbz 10,0(31)
	rlwinm 11,10,0,0xff
	addi 9,11,-97
	addi 0,11,-65
	subfic 9,9,25
	li 9,0
	adde 9,9,9
	subfic 0,0,25
	li 0,0
	adde 0,0,0
	or. 8,9,0
	bc 4,2,.L26
	addi 0,10,-48
	cmplwi 0,0,9
	bc 4,1,.L26
	cmpwi 0,11,95
	bc 12,2,.L26
	cmpwi 0,11,45
	bc 12,2,.L26
	cmpwi 0,11,47
	bc 12,2,.L26
	cmpwi 0,11,92
	bc 12,2,.L26
.L21:
	cmpwi 0,26,0
	bc 12,2,.L41
	lwz 3,map_mod_n_levels_@l(22)
	lis 9,map_mod_names_@ha
	subf 4,26,31
	la 29,map_mod_names_@l(9)
	mr 5,26
	slwi 3,3,6
	add 3,3,29
	crxor 6,6,6
	bl memcpy
	lwz 0,map_mod_n_levels_@l(22)
	li 9,0
	cmpwi 0,0,0
	slwi 0,0,6
	add 0,0,26
	stbx 9,29,0
	bc 4,1,.L29
	la 9,gi@l(21)
	lis 3,.LC10@ha
	lwz 0,4(9)
	la 3,.LC10@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L29:
	lwz 4,map_mod_n_levels_@l(23)
	la 28,gi@l(21)
	lis 3,.LC11@ha
	lwz 9,4(28)
	la 3,.LC11@l(3)
	li 26,0
	slwi 4,4,6
	mtlr 9
	add 4,4,29
	crxor 6,6,6
	blrl
	lwz 9,map_mod_n_levels_@l(23)
	addi 9,9,1
	cmpwi 0,9,255
	stw 9,map_mod_n_levels_@l(23)
	bc 12,1,.L40
	b .L41
.L35:
	cmpwi 0,11,45
	bc 12,2,.L14
	cmpwi 0,11,47
	bc 12,2,.L14
	xori 0,10,92
	mfcr 9
	rlwinm 9,9,29,1
	neg 0,0
	srwi 0,0,31
	and. 8,0,9
	bc 12,2,.L14
.L41:
	addi 30,30,1
	addi 31,31,1
	lbz 10,0(31)
	cmpw 7,30,27
	rlwinm 11,10,0,0xff
	xori 0,11,35
	addi 9,11,-97
	neg 0,0
	subfic 9,9,25
	subfe 9,9,9
	neg 9,9
	srwi 0,0,31
	and. 8,0,9
	bc 12,2,.L14
	addi 0,10,-65
	cmplwi 0,0,25
	bc 4,1,.L14
	addi 0,10,-48
	cmplwi 0,0,9
	bc 4,1,.L14
	cmpwi 0,11,95
	bc 4,2,.L35
.L14:
	bc 12,28,.L36
.L13:
	lis 9,gi+4@ha
	lis 3,.LC13@ha
	lwz 0,gi+4@l(9)
	la 3,.LC13@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,24
	bl free
	mr 3,25
	bl fclose
	lis 9,map_mod_n_levels_@ha
	lwz 0,map_mod_n_levels_@l(9)
	cmpwi 0,0,0
	bc 12,2,.L38
	lis 9,map_mod_@ha
	li 0,1
	stw 0,map_mod_@l(9)
	b .L38
.L40:
	lwz 0,4(28)
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L13
.L7:
	lwz 0,4(31)
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L38:
	lis 9,unused_maps@ha
	li 0,0
	stw 0,unused_maps@l(9)
	lwz 0,324(1)
	mtlr 0
	lmw 21,276(1)
	la 1,320(1)
	blr
.Lfe1:
	.size	 map_mod_set_up,.Lfe1-map_mod_set_up
	.section	".rodata"
	.align 2
.LC15:
	.long 0x46fffe00
	.align 2
.LC16:
	.long 0x0
	.align 3
.LC17:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl map_mod_next_map
	.type	 map_mod_next_map,@function
map_mod_next_map:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 9,map_mod_@ha
	lwz 0,map_mod_@l(9)
	cmpwi 0,0,0
	bc 12,2,.L43
	lis 9,mapmod_random@ha
	lis 7,.LC16@ha
	lwz 11,mapmod_random@l(9)
	la 7,.LC16@l(7)
	lfs 13,0(7)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L44
	lis 9,niq_allmaps@ha
	lis 28,map_mod_n_levels_@ha
	lwz 11,niq_allmaps@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L45
	lwz 11,map_mod_n_levels_@l(28)
	cmpwi 0,11,1
	bc 4,1,.L45
	lis 9,unused_maps@ha
	lis 10,map_used@ha
	lwz 0,unused_maps@l(9)
	lis 27,map_mod_current_level_@ha
	cmpwi 0,0,0
	bc 4,2,.L46
	cmpwi 0,11,0
	bc 4,1,.L48
	mr 6,11
	la 9,map_used@l(10)
	li 0,0
.L50:
	addic. 6,6,-1
	stw 0,0(9)
	addi 9,9,4
	bc 4,2,.L50
.L48:
	lis 9,map_mod_current_level_@ha
	lwz 0,map_mod_current_level_@l(9)
	cmpwi 0,0,-1
	bc 4,2,.L89
	lis 9,level+72@ha
	lis 29,level+72@ha
	la 9,level+72@l(9)
	cmpwi 0,9,0
	bc 12,2,.L52
	lis 9,map_mod_n_levels_@ha
	li 31,0
	lwz 0,map_mod_n_levels_@l(9)
	cmpw 0,31,0
	bc 4,0,.L52
	lis 9,map_mod_names_@ha
	la 30,map_mod_names_@l(9)
.L56:
	la 3,level+72@l(29)
	mr 4,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L55
	stw 31,map_mod_current_level_@l(27)
.L55:
	lwz 0,map_mod_n_levels_@l(28)
	addi 31,31,1
	addi 30,30,64
	cmpw 0,31,0
	bc 4,0,.L52
	lwz 0,map_mod_current_level_@l(27)
	cmpwi 0,0,-1
	bc 12,2,.L56
.L52:
	lis 9,map_mod_current_level_@ha
	lwz 0,map_mod_current_level_@l(9)
	cmpwi 0,0,-1
	bc 12,2,.L60
.L89:
	lis 9,map_mod_current_level_@ha
	lis 10,map_mod_n_levels_@ha
	lwz 0,map_mod_current_level_@l(9)
	lis 11,map_used@ha
	li 8,1
	lwz 9,map_mod_n_levels_@l(10)
	la 11,map_used@l(11)
	slwi 0,0,2
	lis 10,unused_maps@ha
	addi 9,9,-1
	stwx 8,11,0
	stw 9,unused_maps@l(10)
	b .L46
.L60:
	lis 9,map_mod_n_levels_@ha
	lis 11,unused_maps@ha
	lwz 0,map_mod_n_levels_@l(9)
	stw 0,unused_maps@l(11)
.L46:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 7,0x4330
	stw 3,20(1)
	lis 11,.LC17@ha
	lis 8,.LC15@ha
	stw 7,16(1)
	la 11,.LC17@l(11)
	lis 10,unused_maps@ha
	lfd 12,0(11)
	lfd 13,16(1)
	mr 11,9
	lfs 11,.LC15@l(8)
	lwz 0,unused_maps@l(10)
	fsub 13,13,12
	xoris 0,0,0x8000
	stw 0,20(1)
	frsp 13,13
	stw 7,16(1)
	lfd 0,16(1)
	fdivs 13,13,11
	fsub 0,0,12
	frsp 0,0
	fmuls 13,13,0
	fmr 1,13
	bl floor
	lis 9,map_used@ha
	li 6,0
	fctiwz 0,1
	la 11,map_used@l(9)
	lwzx 0,11,6
	stfd 0,16(1)
	cmpwi 0,0,0
	lwz 31,20(1)
	bc 12,2,.L63
	mr 9,11
.L64:
	lwzu 0,4(9)
	addi 6,6,1
	cmpwi 0,0,0
	bc 4,2,.L64
.L63:
	li 8,0
	cmpw 0,8,31
	bc 4,0,.L67
	lis 9,map_used@ha
	slwi 0,6,2
	la 9,map_used@l(9)
	add 10,0,9
.L68:
	lwz 11,0(10)
	addi 9,8,1
	addi 6,6,1
	addi 10,10,4
	srawi 7,11,31
	xor 0,7,11
	subf 0,0,7
	srawi 0,0,31
	andc 9,9,0
	and 0,8,0
	or 8,0,9
	cmpw 0,8,31
	bc 12,0,.L68
.L67:
	lis 9,map_used@ha
	slwi 11,6,2
	la 9,map_used@l(9)
	lwzx 0,9,11
	cmpwi 0,0,0
	bc 12,2,.L88
	add 9,11,9
.L73:
	lwzu 0,4(9)
	addi 6,6,1
	cmpwi 0,0,0
	bc 4,2,.L73
.L88:
	lis 7,unused_maps@ha
	lis 9,map_used@ha
	lwz 11,unused_maps@l(7)
	la 9,map_used@l(9)
	slwi 10,6,2
	li 0,1
	lis 8,map_mod_current_level_@ha
	stwx 0,9,10
	addi 11,11,-1
	stw 11,unused_maps@l(7)
	stw 6,map_mod_current_level_@l(8)
	b .L78
.L45:
	lis 9,map_mod_current_level_@ha
	li 0,-1
	stw 0,map_mod_current_level_@l(9)
	lis 27,map_mod_current_level_@ha
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 7,0x4330
	stw 3,20(1)
	lis 11,.LC17@ha
	lis 8,.LC15@ha
	stw 7,16(1)
	la 11,.LC17@l(11)
	lis 10,map_mod_n_levels_@ha
	lfd 12,0(11)
	lfd 13,16(1)
	mr 11,9
	lfs 11,.LC15@l(8)
	lwz 0,map_mod_n_levels_@l(10)
	fsub 13,13,12
	xoris 0,0,0x8000
	stw 0,20(1)
	frsp 13,13
	stw 7,16(1)
	lfd 0,16(1)
	fdivs 13,13,11
	fsub 0,0,12
	frsp 0,0
	fmuls 13,13,0
	fmr 1,13
	bl floor
	fctiwz 0,1
	lis 9,map_mod_names_@ha
	la 9,map_mod_names_@l(9)
	lis 3,level+72@ha
	la 3,level+72@l(3)
	stfd 0,16(1)
	lwz 31,20(1)
	slwi 4,31,6
	add 4,4,9
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L76
	lwz 9,map_mod_n_levels_@l(28)
	addi 31,31,1
	cmpw 7,31,9
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	and 31,31,0
.L76:
	stw 31,map_mod_current_level_@l(27)
	b .L78
.L44:
	lis 9,map_mod_n_levels_@ha
	li 31,0
	lwz 10,map_mod_n_levels_@l(9)
	lis 11,map_mod_current_level_@ha
	li 0,-1
	stw 0,map_mod_current_level_@l(11)
	lis 28,map_mod_n_levels_@ha
	lis 27,map_mod_current_level_@ha
	cmpw 0,31,10
	bc 4,0,.L78
	lis 9,map_mod_names_@ha
	lis 29,level+72@ha
	la 30,map_mod_names_@l(9)
.L82:
	slwi 4,31,6
	la 3,level+72@l(29)
	add 4,4,30
	bl Q_stricmp
	cmpwi 0,3,0
	addi 4,31,1
	bc 4,2,.L81
	stw 4,map_mod_current_level_@l(27)
.L81:
	lwz 0,map_mod_n_levels_@l(28)
	mr 31,4
	cmpw 0,31,0
	bc 12,0,.L82
.L78:
	lis 9,map_mod_current_level_@ha
	lis 11,map_mod_n_levels_@ha
	lwz 10,map_mod_current_level_@l(9)
	lwz 0,map_mod_n_levels_@l(11)
	cmpw 0,10,0
	bc 12,0,.L85
	li 0,0
	stw 0,map_mod_current_level_@l(27)
.L85:
	lwz 0,map_mod_current_level_@l(27)
	cmpwi 0,0,-1
	bc 4,1,.L43
	lis 3,map_mod_names_@ha
	slwi 0,0,6
	la 3,map_mod_names_@l(3)
	add 3,0,3
	b .L87
.L43:
	li 3,0
.L87:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 map_mod_next_map,.Lfe2-map_mod_next_map
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
	.comm	mapmod_random,4,4
	.comm	map_mod_names_,16384,1
	.comm	map_used,1024,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
