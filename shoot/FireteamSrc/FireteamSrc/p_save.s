	.file	"p_save.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC1:
	.string	" "
	.align 2
.LC3:
	.string	"ip"
	.align 2
.LC2:
	.long 0x501502f9
	.align 2
.LC4:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl saveinfo
	.type	 saveinfo,@function
saveinfo:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	li 0,15
	lis 9,.LC2@ha
	lis 10,level+4@ha
	mtctr 0
	lis 11,saved_client@ha
	lfs 13,.LC2@l(9)
	lfs 12,level+4@l(10)
	la 11,saved_client@l(11)
	mr 7,3
	addi 11,11,48
	li 27,14
	li 3,0
.L32:
	lfs 0,0(11)
	addi 11,11,52
	fcmpu 0,12,0
	bc 4,1,.L27
	mr 31,3
	b .L28
.L27:
	fcmpu 0,0,13
	bc 4,0,.L30
	fmr 13,0
	mr 27,3
.L30:
	addi 3,3,1
	bdnz .L32
	mr 31,27
.L28:
	lwz 9,84(7)
	mulli 27,31,52
	lis 29,saved_client@ha
	lis 4,.LC3@ha
	la 29,saved_client@l(29)
	la 4,.LC3@l(4)
	lwz 0,1836(9)
	addi 11,29,12
	addi 10,29,4
	addi 8,29,8
	addi 28,29,16
	stwx 0,29,27
	add 28,27,28
	lwz 9,84(7)
	lwz 0,1888(9)
	stwx 0,11,27
	lwz 9,84(7)
	lwz 0,1884(9)
	stwx 0,10,27
	lwz 9,84(7)
	lwz 0,1840(9)
	stwx 0,8,27
	lwz 3,84(7)
	addi 3,3,188
	bl Info_ValueForKey
	mr 5,3
	li 4,30
	mr 3,28
	crxor 6,6,6
	bl Com_sprintf
	lis 11,.LC4@ha
	lis 9,level+4@ha
	la 11,.LC4@l(11)
	lfs 0,level+4@l(9)
	addi 29,29,48
	lfs 13,0(11)
	mr 3,31
	fadds 0,0,13
	stfsx 0,29,27
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 saveinfo,.Lfe1-saveinfo
	.align 2
	.globl make_empty
	.type	 make_empty,@function
make_empty:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mulli 28,3,52
	lis 29,saved_client@ha
	li 0,0
	la 29,saved_client@l(29)
	lis 5,.LC1@ha
	stwx 0,29,28
	addi 11,29,12
	addi 9,29,8
	stwx 0,11,28
	addi 10,29,4
	addi 3,29,16
	stwx 0,9,28
	add 3,28,3
	la 5,.LC1@l(5)
	stwx 0,10,28
	li 4,30
	crxor 6,6,6
	bl Com_sprintf
	addi 29,29,48
	li 0,0
	stwx 0,29,28
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 make_empty,.Lfe2-make_empty
	.align 2
	.globl getinfo
	.type	 getinfo,@function
getinfo:
	mulli 4,4,52
	lis 11,saved_client@ha
	lwz 8,84(3)
	la 11,saved_client@l(11)
	lwzx 9,11,4
	addi 10,11,12
	addi 7,11,4
	addi 11,11,8
	stw 9,1836(8)
	lwzx 0,10,4
	lwz 9,84(3)
	stw 0,1888(9)
	lwz 9,84(3)
	lwzx 10,7,4
	stw 10,1884(9)
	lwzx 0,11,4
	lwz 9,84(3)
	stw 0,1840(9)
	blr
.Lfe3:
	.size	 getinfo,.Lfe3-getinfo
	.comm	lights,4,4
	.align 2
	.globl find_saved
	.type	 find_saved,@function
find_saved:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,saved_client@ha
	lis 11,level@ha
	la 9,saved_client@l(9)
	la 27,level@l(11)
	mr 28,3
	addi 29,9,48
	li 31,0
	addi 30,9,16
.L18:
	lfs 13,0(29)
	lfs 0,4(27)
	addi 29,29,52
	fcmpu 0,0,13
	bc 4,0,.L17
	mr 3,30
	mr 4,28
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L17
	mr 3,31
	b .L34
.L17:
	addi 31,31,1
	addi 30,30,52
	cmpwi 0,31,14
	bc 4,1,.L18
	li 3,-1
.L34:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 find_saved,.Lfe4-find_saved
	.comm	saved_client,780,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_blaster,4,4
	.comm	item_shotgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_supershotgun,4,4
	.comm	item_chaingun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_railgun,4,4
	.comm	item_bfg,4,4
	.comm	item_jacketarmor,4,4
	.comm	item_combatarmor,4,4
	.comm	item_bodyarmor,4,4
	.comm	item_armorshard,4,4
	.comm	item_powerscreen,4,4
	.comm	item_powershield,4,4
	.comm	item_adrenaline,4,4
	.comm	item_health,4,4
	.comm	item_stimpak,4,4
	.comm	item_health_large,4,4
	.comm	item_health_mega,4,4
	.comm	item_quad,4,4
	.comm	item_invulnerability,4,4
	.comm	item_silencer,4,4
	.comm	item_breather,4,4
	.comm	item_enviro,4,4
	.comm	item_pack,4,4
	.comm	item_bandolier,4,4
	.comm	item_ancient_head,4,4
	.comm	key_data_cd,4,4
	.comm	key_power_cube,4,4
	.comm	key_pyramid,4,4
	.comm	key_data_spinner,4,4
	.comm	key_pass,4,4
	.comm	key_blue_key,4,4
	.comm	key_red_key,4,4
	.comm	key_commander_head,4,4
	.comm	key_airstrike_target,4,4
	.section	".rodata"
	.align 2
.LC5:
	.long 0x501502f9
	.section	".text"
	.align 2
	.globl empty_slot
	.type	 empty_slot,@function
empty_slot:
	lis 9,.LC5@ha
	lis 11,level+4@ha
	lfs 13,.LC5@l(9)
	lis 10,saved_client@ha
	li 0,14
	li 9,15
	lfs 12,level+4@l(11)
	la 10,saved_client@l(10)
	mtctr 9
	li 3,0
	addi 10,10,48
.L36:
	lfs 0,0(10)
	addi 10,10,52
	fcmpu 0,12,0
	bclr 12,1
	fcmpu 0,0,13
	bc 4,0,.L9
	fmr 13,0
	mr 0,3
.L9:
	addi 3,3,1
	bdnz .L36
	mr 3,0
	blr
.Lfe5:
	.size	 empty_slot,.Lfe5-empty_slot
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
