	.file	"x_radio.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"1"
	.align 2
.LC1:
	.string	"Radio on.\n"
	.align 2
.LC2:
	.string	"Radio off.\n"
	.align 2
.LC3:
	.string	""
	.string	""
	.align 2
.LC4:
	.string	";"
	.align 2
.LC5:
	.string	"play radio/%s\n"
	.align 2
.LC6:
	.string	"ALL"
	.align 2
.LC7:
	.string	"TEAM"
	.align 2
.LC8:
	.long 0x0
	.align 2
.LC9:
	.long 0x3f800000
	.align 3
.LC10:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl X_Radio_f
	.type	 X_Radio_f,@function
X_Radio_f:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 23,36(1)
	stw 0,84(1)
	lis 11,.LC8@ha
	lis 9,deathmatch@ha
	la 11,.LC8@l(11)
	mr 28,3
	lfs 13,0(11)
	mr 30,4
	mr 31,5
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L10
	lis 9,.LC3@ha
	lis 4,.LC4@ha
	la 29,.LC3@l(9)
	la 4,.LC4@l(4)
	mr 3,31
	bl strstr
	mr. 3,3
	bc 12,2,.L12
	li 0,0
	stb 0,0(3)
.L12:
	lis 4,.LC5@ha
	mr 5,31
	la 4,.LC5@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	lis 4,.LC6@ha
	mr 3,30
	la 4,.LC6@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L13
	lis 11,.LC9@ha
	lis 9,maxclients@ha
	la 11,.LC9@l(11)
	li 30,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L10
	lis 9,.LC10@ha
	lis 27,g_edicts@ha
	la 9,.LC10@l(9)
	lis 28,0x4330
	lfd 31,0(9)
	li 31,976
.L17:
	lwz 0,g_edicts@l(27)
	add. 3,0,31
	bc 12,2,.L16
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L16
	lwz 9,84(3)
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 12,2,.L16
	mr 4,29
	bl stuffcmd
.L16:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,976
	stw 0,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L17
	b .L10
.L13:
	lis 4,.LC7@ha
	mr 3,30
	la 4,.LC7@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L10
	lis 11,.LC9@ha
	lis 9,maxclients@ha
	la 11,.LC9@l(11)
	li 30,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L10
	lis 9,.LC10@ha
	lis 23,g_edicts@ha
	la 9,.LC10@l(9)
	lis 24,ctf@ha
	lfd 31,0(9)
	lis 25,team_dm@ha
	lis 27,0x4330
	li 31,976
.L26:
	lwz 0,g_edicts@l(23)
	add. 3,0,31
	bc 12,2,.L25
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L25
	lwz 9,ctf@l(24)
	lis 11,.LC8@ha
	la 11,.LC8@l(11)
	lfs 13,0(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L28
	lwz 10,84(3)
	lwz 9,84(28)
	lwz 11,1840(10)
	lwz 0,1840(9)
	b .L38
.L28:
	lwz 9,team_dm@l(25)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L32
	lwz 10,84(3)
	lwz 9,84(28)
	lwz 11,1884(10)
	lwz 0,1884(9)
.L38:
	cmpw 0,11,0
	bc 4,2,.L25
	lwz 0,1812(10)
	cmpwi 0,0,0
	bc 12,2,.L25
	mr 4,29
	bl stuffcmd
	b .L25
.L32:
	lwz 9,84(3)
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 12,2,.L25
	mr 4,29
	bl stuffcmd
.L25:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,976
	stw 0,28(1)
	stw 27,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L26
.L10:
	lwz 0,84(1)
	mtlr 0
	lmw 23,36(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe1:
	.size	 X_Radio_f,.Lfe1-X_Radio_f
	.comm	lights,4,4
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
.LC11:
	.long 0x0
	.section	".text"
	.align 2
	.globl X_Radio_Power_f
	.type	 X_Radio_Power_f,@function
X_Radio_Power_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC11@ha
	lis 9,deathmatch@ha
	la 11,.LC11@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 3,4
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L6
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L8
	lwz 9,84(31)
	li 0,1
	lis 11,gi+8@ha
	lis 5,.LC1@ha
	mr 3,31
	stw 0,1812(9)
	la 5,.LC1@l(5)
	li 4,2
	lwz 0,gi+8@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L8:
	lwz 9,84(31)
	li 0,0
	lis 11,gi+8@ha
	lis 5,.LC2@ha
	mr 3,31
	stw 0,1812(9)
	la 5,.LC2@l(5)
	li 4,2
	lwz 0,gi+8@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
.L6:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 X_Radio_Power_f,.Lfe2-X_Radio_Power_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
