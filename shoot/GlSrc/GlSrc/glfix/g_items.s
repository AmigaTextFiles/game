	.file	"g_items.c"
gcc2_compiled.:
	.globl jacketarmor_info
	.section	".data"
	.align 2
	.type	 jacketarmor_info,@object
	.size	 jacketarmor_info,20
jacketarmor_info:
	.long 25
	.long 50
	.long 0x3e99999a
	.long 0x0
	.long 1
	.globl combatarmor_info
	.align 2
	.type	 combatarmor_info,@object
	.size	 combatarmor_info,20
combatarmor_info:
	.long 50
	.long 100
	.long 0x3f19999a
	.long 0x3e99999a
	.long 2
	.globl bodyarmor_info
	.align 2
	.type	 bodyarmor_info,@object
	.size	 bodyarmor_info,20
bodyarmor_info:
	.long 100
	.long 200
	.long 0x3f4ccccd
	.long 0x3f19999a
	.long 3
	.section	".rodata"
	.align 2
.LC0:
	.string	"Cells"
	.align 2
.LC1:
	.string	"You are not Gameleader, so you cannot create these\n"
	.section	".text"
	.align 2
	.globl Checktospawn
	.type	 Checktospawn,@function
Checktospawn:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,320(31)
	cmpwi 0,0,0
	bc 12,2,.L26
	lwz 0,68(4)
	cmpwi 0,0,501
	mr 9,0
	bc 4,2,.L27
	lis 5,.LC0@ha
	la 5,.LC0@l(5)
	li 4,5
	li 6,175
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_berserk2
	b .L25
.L27:
	cmpwi 0,9,502
	bc 4,2,.L29
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,10
	li 6,175
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_gunner2
	b .L25
.L29:
	cmpwi 0,9,503
	bc 4,2,.L31
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,10
	li 6,175
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_chick2
	b .L25
.L31:
	cmpwi 0,9,504
	bc 4,2,.L33
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,20
	li 6,175
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_gladiator2
	b .L25
.L33:
	cmpwi 0,9,505
	bc 4,2,.L35
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,25
	li 6,225
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	li 4,0
	bl SP_monster_tank2
	b .L25
.L35:
	cmpwi 0,9,506
	bc 4,2,.L37
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,35
	li 6,230
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	li 4,1
	bl SP_monster_tank2
	b .L25
.L37:
	cmpwi 0,9,507
	bc 4,2,.L39
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,8
	li 6,175
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_parasite2
	b .L25
.L39:
	cmpwi 0,9,508
	bc 4,2,.L41
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,50
	li 6,250
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_supertank2
	b .L25
.L41:
	cmpwi 0,9,509
	bc 4,2,.L43
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,4
	li 6,175
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_soldier_ss2
	b .L25
.L43:
	cmpwi 0,9,510
	bc 4,2,.L45
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,4
	li 6,175
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_soldier2
	b .L25
.L45:
	cmpwi 0,9,511
	bc 4,2,.L47
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,2
	li 6,175
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_soldier_light2
	b .L25
.L47:
	cmpwi 0,9,512
	bc 4,2,.L49
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,5
	li 6,175
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_infantry2
	b .L25
.L49:
	cmpwi 0,9,513
	bc 4,2,.L51
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,6
	li 6,175
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_flyer2
	b .L25
.L51:
	cmpwi 0,9,514
	bc 4,2,.L53
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,7
	li 6,175
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_floater2
	b .L25
.L53:
	cmpwi 0,9,515
	bc 4,2,.L55
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,20
	li 6,200
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_mutant2
	b .L25
.L55:
	cmpwi 0,9,516
	bc 4,2,.L57
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,8
	li 6,175
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_brain2
	b .L25
.L57:
	cmpwi 0,9,517
	bc 4,2,.L59
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,5
	li 6,175
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_flipper2
	b .L25
.L59:
	cmpwi 0,9,518
	bc 4,2,.L61
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,12
	li 6,175
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_hover2
	b .L25
.L61:
	cmpwi 0,9,519
	bc 4,2,.L63
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,130
	li 6,200
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_makron2
	b .L25
.L63:
	cmpwi 0,9,520
	bc 4,2,.L65
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,300
	li 6,225
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_jorg2
	b .L25
.L65:
	cmpwi 0,9,521
	bc 4,2,.L67
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,80
	li 6,225
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_boss02
	b .L25
.L67:
	cmpwi 0,9,522
	bc 4,2,.L69
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,15
	li 6,175
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_monster_medic2
	b .L25
.L69:
	cmpwi 0,9,523
	bc 4,2,.L71
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,2
	crxor 6,6,6
	bl EnoughStuff2
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	li 4,0
	crxor 6,6,6
	bl SP_minetrap
	b .L25
.L71:
	cmpwi 0,9,524
	bc 4,2,.L25
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	li 4,50
	li 6,300
	bl EnoughStuff
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	bl SP_func_DoomSpawngl
	b .L25
.L26:
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L25:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 Checktospawn,.Lfe1-Checktospawn
	.section	".rodata"
	.align 3
.LC2:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC3:
	.long 0x3f800000
	.align 2
.LC4:
	.long 0x40000000
	.align 2
.LC5:
	.long 0x0
	.align 3
.LC6:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Powerup
	.type	 Pickup_Powerup,@function
Pickup_Powerup:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	lis 11,skill@ha
	lis 9,itemlist@ha
	lwz 8,744(31)
	lis 0,0x286b
	lwz 10,skill@l(11)
	la 9,itemlist@l(9)
	lis 7,.LC3@ha
	ori 0,0,51739
	mr 30,4
	subf 9,9,8
	la 7,.LC3@l(7)
	lfs 13,20(10)
	mullw 9,9,0
	lwz 11,84(30)
	lfs 0,0(7)
	rlwinm 9,9,0,0,29
	addi 11,11,740
	lwzx 11,11,9
	fcmpu 7,13,0
	cmpwi 6,11,1
	mfcr 9
	rlwinm 0,9,26,1
	rlwinm 9,9,31,1
	and. 10,9,0
	bc 4,2,.L100
	lis 7,.LC4@ha
	srawi 0,11,31
	la 7,.LC4@l(7)
	subf 0,11,0
	lfs 0,0(7)
	srwi 10,0,31
	fcmpu 7,13,0
	cror 31,30,29
	mfcr 9
	rlwinm 9,9,0,1
	and. 0,9,10
	bc 4,2,.L100
	lis 11,coop@ha
	lis 7,.LC5@ha
	lwz 9,coop@l(11)
	la 7,.LC5@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L92
	lwz 0,56(8)
	rlwinm 0,0,29,31,31
	and. 9,0,10
	bc 12,2,.L92
.L100:
	li 3,0
	b .L99
.L92:
	lwz 0,744(31)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	lwz 10,84(30)
	subf 0,9,0
	lis 8,deathmatch@ha
	mullw 0,0,11
	addi 10,10,740
	lis 7,.LC5@ha
	lwz 11,deathmatch@l(8)
	la 7,.LC5@l(7)
	rlwinm 0,0,0,0,29
	lfs 13,0(7)
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L93
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L94
	lis 9,.LC6@ha
	lwz 11,744(31)
	la 9,.LC6@l(9)
	lis 7,0x4330
	lwz 0,264(31)
	lfd 12,0(9)
	lis 6,level+4@ha
	lis 10,DoRespawn@ha
	lwz 9,48(11)
	oris 0,0,0x8000
	la 10,DoRespawn@l(10)
	lwz 11,184(31)
	lis 5,gi+72@ha
	mr 3,31
	xoris 9,9,0x8000
	stw 0,264(31)
	stw 9,20(1)
	ori 11,11,1
	stw 7,16(1)
	lfd 0,16(1)
	stw 11,184(31)
	stw 4,248(31)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,532(31)
	frsp 0,0
	fadds 13,13,0
	stfs 13,524(31)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L94:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,16
	bc 4,2,.L97
	lwz 9,744(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L93
	lwz 0,284(31)
	andis. 7,0,2
	bc 12,2,.L93
.L97:
	lwz 9,744(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L98
	lwz 0,284(31)
	andis. 9,0,2
	bc 12,2,.L98
	lis 11,level+4@ha
	lfs 0,524(31)
	lis 10,.LC2@ha
	lfs 11,level+4@l(11)
	lfd 12,.LC2@l(10)
	lis 11,quad_drop_timeout_hack@ha
	fsubs 0,0,11
	fdiv 0,0,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	stw 9,quad_drop_timeout_hack@l(11)
.L98:
	lwz 9,744(31)
	mr 3,30
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L93:
	li 3,1
.L99:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Pickup_Powerup,.Lfe2-Pickup_Powerup
	.section	".rodata"
	.align 2
.LC7:
	.string	"Bullets"
	.align 2
.LC8:
	.string	"Shells"
	.align 2
.LC9:
	.long 0x0
	.align 3
.LC10:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Bandolier
	.type	 Pickup_Bandolier,@function
Pickup_Bandolier:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 29,4
	mr 28,3
	lwz 9,84(29)
	lwz 0,1764(9)
	cmpwi 0,0,249
	bc 12,1,.L111
	li 0,250
	stw 0,1764(9)
.L111:
	lwz 9,84(29)
	lwz 0,1768(9)
	cmpwi 0,0,149
	bc 12,1,.L112
	li 0,150
	stw 0,1768(9)
.L112:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,249
	bc 12,1,.L113
	li 0,250
	stw 0,1780(9)
.L113:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,74
	bc 12,1,.L114
	li 0,75
	stw 0,1784(9)
.L114:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC7@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC7@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L122
	mr 27,10
.L117:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L119
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L119
	mr 8,31
	b .L121
.L119:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L117
.L122:
	li 8,0
.L121:
	cmpwi 0,8,0
	bc 12,2,.L123
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1764(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L123
	stwx 11,9,8
.L123:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC8@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC8@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L132
	mr 27,10
.L127:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L129
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L129
	mr 8,31
	b .L131
.L129:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L127
.L132:
	li 8,0
.L131:
	cmpwi 0,8,0
	bc 12,2,.L133
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	addi 4,9,740
	lwz 11,1768(9)
	lwzx 0,4,8
	cmpw 0,0,11
	bc 4,1,.L133
	stwx 11,4,8
.L133:
	lwz 0,284(28)
	andis. 4,0,0x1
	bc 4,2,.L135
	lis 9,.LC9@ha
	lis 11,deathmatch@ha
	la 9,.LC9@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L135
	lis 9,.LC10@ha
	lwz 11,744(28)
	la 9,.LC10@l(9)
	lis 7,0x4330
	lwz 0,264(28)
	lfd 12,0(9)
	lis 6,level+4@ha
	lis 10,DoRespawn@ha
	lwz 9,48(11)
	oris 0,0,0x8000
	la 10,DoRespawn@l(10)
	lwz 11,184(28)
	lis 5,gi+72@ha
	mr 3,28
	xoris 9,9,0x8000
	stw 0,264(28)
	stw 9,20(1)
	ori 11,11,1
	stw 7,16(1)
	lfd 0,16(1)
	stw 11,184(28)
	stw 4,248(28)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,532(28)
	frsp 0,0
	fadds 13,13,0
	stfs 13,524(28)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L135:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 Pickup_Bandolier,.Lfe3-Pickup_Bandolier
	.section	".rodata"
	.align 2
.LC11:
	.string	"Grenades"
	.align 2
.LC12:
	.string	"Rockets"
	.align 2
.LC13:
	.string	"Slugs"
	.align 2
.LC14:
	.long 0x0
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Pack
	.type	 Pickup_Pack,@function
Pickup_Pack:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 29,4
	mr 27,3
	lwz 9,84(29)
	lwz 0,1764(9)
	cmpwi 0,0,299
	bc 12,1,.L138
	li 0,300
	stw 0,1764(9)
.L138:
	lwz 9,84(29)
	lwz 0,1768(9)
	cmpwi 0,0,199
	bc 12,1,.L139
	li 0,200
	stw 0,1768(9)
.L139:
	lwz 9,84(29)
	lwz 0,1772(9)
	cmpwi 0,0,99
	bc 12,1,.L140
	li 0,100
	stw 0,1772(9)
.L140:
	lwz 9,84(29)
	lwz 0,1776(9)
	cmpwi 0,0,99
	bc 12,1,.L141
	li 0,100
	stw 0,1776(9)
.L141:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,299
	bc 12,1,.L142
	li 0,300
	stw 0,1780(9)
.L142:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,99
	bc 12,1,.L143
	li 0,100
	stw 0,1784(9)
.L143:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC7@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC7@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L151
	mr 28,10
.L146:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L148
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L148
	mr 8,31
	b .L150
.L148:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L146
.L151:
	li 8,0
.L150:
	cmpwi 0,8,0
	bc 12,2,.L152
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1764(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L152
	stwx 11,9,8
.L152:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC8@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC8@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L161
	mr 28,10
.L156:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L158
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L158
	mr 8,31
	b .L160
.L158:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L156
.L161:
	li 8,0
.L160:
	cmpwi 0,8,0
	bc 12,2,.L162
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1768(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L162
	stwx 11,9,8
.L162:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC0@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC0@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L171
	mr 28,10
.L166:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L168
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L168
	mr 8,31
	b .L170
.L168:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L166
.L171:
	li 8,0
.L170:
	cmpwi 0,8,0
	bc 12,2,.L172
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1780(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L172
	stwx 11,9,8
.L172:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC11@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC11@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L181
	mr 28,10
.L176:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L178
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L178
	mr 8,31
	b .L180
.L178:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L176
.L181:
	li 8,0
.L180:
	cmpwi 0,8,0
	bc 12,2,.L182
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1776(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L182
	stwx 11,9,8
.L182:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC12@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC12@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L191
	mr 28,10
.L186:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L188
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L188
	mr 8,31
	b .L190
.L188:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L186
.L191:
	li 8,0
.L190:
	cmpwi 0,8,0
	bc 12,2,.L192
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1772(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L192
	stwx 11,9,8
.L192:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC13@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC13@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L201
	mr 28,10
.L196:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L198
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L198
	mr 8,31
	b .L200
.L198:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L196
.L201:
	li 8,0
.L200:
	cmpwi 0,8,0
	bc 12,2,.L202
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	addi 4,9,740
	lwz 11,1784(9)
	lwzx 0,4,8
	cmpw 0,0,11
	bc 4,1,.L202
	stwx 11,4,8
.L202:
	lwz 0,284(27)
	andis. 4,0,0x1
	bc 4,2,.L204
	lis 9,.LC14@ha
	lis 11,deathmatch@ha
	la 9,.LC14@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L204
	lis 9,.LC15@ha
	lwz 11,744(27)
	la 9,.LC15@l(9)
	lis 7,0x4330
	lwz 0,264(27)
	lfd 12,0(9)
	lis 6,level+4@ha
	lis 10,DoRespawn@ha
	lwz 9,48(11)
	oris 0,0,0x8000
	la 10,DoRespawn@l(10)
	lwz 11,184(27)
	lis 5,gi+72@ha
	mr 3,27
	xoris 9,9,0x8000
	stw 0,264(27)
	stw 9,20(1)
	ori 11,11,1
	stw 7,16(1)
	lfd 0,16(1)
	stw 11,184(27)
	stw 4,248(27)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,532(27)
	frsp 0,0
	fadds 13,13,0
	stfs 13,524(27)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L204:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 Pickup_Pack,.Lfe4-Pickup_Pack
	.section	".rodata"
	.align 2
.LC16:
	.string	"items/damage.wav"
	.align 3
.LC17:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC18:
	.long 0x3f800000
	.align 2
.LC19:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_Quad
	.type	 Use_Quad,@function
Use_Quad:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	mr 31,3
	subf 4,9,4
	ori 0,0,51739
	lwz 11,84(31)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 11,quad_drop_timeout_hack@ha
	lwz 9,quad_drop_timeout_hack@l(11)
	cmpwi 0,9,0
	bc 12,2,.L207
	li 0,0
	mr 10,9
	stw 0,quad_drop_timeout_hack@l(11)
	b .L208
.L207:
	li 10,300
.L208:
	lis 11,level@ha
	lwz 8,84(31)
	lwz 11,level@l(11)
	lis 7,0x4330
	lis 6,.LC17@ha
	la 6,.LC17@l(6)
	lfs 12,3708(8)
	xoris 0,11,0x8000
	lfd 13,0(6)
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L209
	xoris 0,10,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fadds 0,12,0
	b .L211
.L209:
	add 0,11,10
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
.L211:
	stfs 0,3708(8)
	lis 29,gi@ha
	lis 3,.LC16@ha
	la 29,gi@l(29)
	la 3,.LC16@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 6,.LC18@ha
	lwz 0,16(29)
	lis 9,.LC18@ha
	la 6,.LC18@l(6)
	mr 5,3
	lfs 1,0(6)
	la 9,.LC18@l(9)
	li 4,3
	mtlr 0
	lis 6,.LC19@ha
	mr 3,31
	lfs 2,0(9)
	la 6,.LC19@l(6)
	lfs 3,0(6)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 Use_Quad,.Lfe5-Use_Quad
	.section	".rodata"
	.align 2
.LC20:
	.string	"items/protect.wav"
	.align 3
.LC21:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC22:
	.long 0x43960000
	.align 2
.LC23:
	.long 0x3f800000
	.align 2
.LC24:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_Invulnerability
	.type	 Use_Invulnerability,@function
Use_Invulnerability:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	mr 31,3
	subf 4,9,4
	ori 0,0,51739
	lwz 11,84(31)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC21@ha
	lis 11,level@ha
	lwz 10,84(31)
	la 9,.LC21@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3712(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L219
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L221
.L219:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L221:
	stfs 0,3712(10)
	lis 29,gi@ha
	lis 3,.LC20@ha
	la 29,gi@l(29)
	la 3,.LC20@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC23@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC23@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 2,0(9)
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 Use_Invulnerability,.Lfe6-Use_Invulnerability
	.section	".rodata"
	.align 2
.LC25:
	.string	"key_power_cube"
	.align 2
.LC26:
	.long 0x0
	.section	".text"
	.align 2
	.globl Pickup_Key
	.type	 Pickup_Key,@function
Pickup_Key:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 11,.LC26@ha
	lis 9,coop@ha
	la 11,.LC26@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 30,4
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L224
	lwz 3,280(31)
	lis 4,.LC25@ha
	la 4,.LC25@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L225
	lwz 10,84(30)
	lbz 9,286(31)
	lwz 0,1796(10)
	and. 11,0,9
	bc 4,2,.L230
	lwz 0,744(31)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,0
	addi 10,10,740
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lwz 11,84(30)
	lbz 9,286(31)
	lwz 0,1796(11)
	or 0,0,9
	stw 0,1796(11)
	b .L227
.L225:
	lwz 11,744(31)
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,84(30)
	subf 11,9,11
	mullw 11,11,0
	addi 4,10,740
	rlwinm 3,11,0,0,29
	lwzx 0,4,3
	cmpwi 0,0,0
	bc 12,2,.L228
.L230:
	li 3,0
	b .L229
.L228:
	li 0,1
	stwx 0,4,3
.L227:
	li 3,1
	b .L229
.L224:
	lwz 0,744(31)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	lwz 10,84(30)
	subf 0,9,0
	li 3,1
	mullw 0,0,11
	addi 10,10,740
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
.L229:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 Pickup_Key,.Lfe7-Pickup_Key
	.align 2
	.globl Add_Ammo
	.type	 Add_Ammo,@function
Add_Ammo:
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 4,2,.L232
.L250:
	li 3,0
	blr
.L232:
	lwz 0,68(4)
	cmpwi 0,0,0
	mr 8,0
	bc 4,2,.L233
	lwz 10,1764(9)
	b .L234
.L233:
	cmpwi 0,8,1
	bc 4,2,.L235
	lwz 10,1768(9)
	b .L234
.L235:
	cmpwi 0,8,2
	bc 4,2,.L237
	lwz 10,1772(9)
	b .L234
.L237:
	cmpwi 0,8,3
	bc 4,2,.L239
	lwz 10,1776(9)
	b .L234
.L239:
	cmpwi 0,8,4
	bc 4,2,.L241
	lwz 10,1780(9)
	b .L234
.L241:
	cmpwi 0,8,5
	bc 4,2,.L250
	lwz 10,1784(9)
.L234:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(3)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	mr 7,11
	mullw 9,9,0
	addi 11,11,740
	srawi 4,9,2
	slwi 0,4,2
	lwzx 9,11,0
	cmpw 0,9,10
	bc 12,2,.L250
	cmpwi 0,8,4
	bc 4,2,.L246
	lwz 0,320(3)
	cmpwi 0,0,0
	bc 4,2,.L250
.L246:
	slwi 4,4,2
	addi 11,7,740
	lwzx 0,11,4
	add 0,0,5
	stwx 0,11,4
	lwz 9,84(3)
	addi 3,9,740
	lwzx 0,3,4
	cmpw 0,0,10
	bc 4,1,.L248
	stwx 10,3,4
.L248:
	li 3,1
	blr
.Lfe8:
	.size	 Add_Ammo,.Lfe8-Add_Ammo
	.section	".rodata"
	.align 2
.LC27:
	.string	"blaster"
	.align 2
.LC28:
	.long 0x0
	.align 2
.LC29:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Pickup_Ammo
	.type	 Pickup_Ammo,@function
Pickup_Ammo:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr 30,3
	mr 28,4
	lwz 4,744(30)
	lwz 0,56(4)
	andi. 29,0,1
	bc 12,2,.L252
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8192
	li 5,1000
	bc 4,2,.L253
.L252:
	lwz 5,628(30)
	cmpwi 0,5,0
	bc 12,2,.L254
	lwz 4,744(30)
	b .L253
.L254:
	lwz 9,744(30)
	lwz 5,48(9)
	mr 4,9
.L253:
	lis 10,itemlist@ha
	lis 9,0x286b
	lwz 11,84(28)
	la 27,itemlist@l(10)
	ori 9,9,51739
	subf 0,27,4
	addi 11,11,740
	mullw 0,0,9
	mr 3,28
	rlwinm 0,0,0,0,29
	lwzx 31,11,0
	bl Add_Ammo
	cmpwi 0,3,0
	bc 4,2,.L256
	li 3,0
	b .L270
.L271:
	mr 9,31
	b .L266
.L256:
	subfic 9,31,0
	adde 0,9,31
	and. 11,29,0
	bc 12,2,.L257
	lwz 25,84(28)
	lwz 9,744(30)
	lwz 0,1788(25)
	cmpw 0,0,9
	bc 12,2,.L257
	lis 9,.LC28@ha
	lis 11,deathmatch@ha
	la 9,.LC28@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L259
	lis 9,game@ha
	li 29,0
	la 9,game@l(9)
	lis 11,.LC27@ha
	lwz 0,1556(9)
	la 26,.LC27@l(11)
	mr 31,27
	cmpw 0,29,0
	bc 4,0,.L267
	mr 27,9
.L262:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L264
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L271
.L264:
	lwz 0,1556(27)
	addi 29,29,1
	addi 31,31,76
	cmpw 0,29,0
	bc 12,0,.L262
.L267:
	li 9,0
.L266:
	lwz 0,1788(25)
	cmpw 0,0,9
	bc 4,2,.L257
.L259:
	lwz 9,84(28)
	lwz 0,744(30)
	stw 0,3532(9)
.L257:
	lwz 0,284(30)
	andis. 7,0,0x3
	bc 4,2,.L268
	lis 9,.LC28@ha
	lis 11,deathmatch@ha
	la 9,.LC28@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L268
	lwz 9,264(30)
	lis 11,.LC29@ha
	lis 10,level+4@ha
	lwz 0,184(30)
	la 11,.LC29@l(11)
	lis 8,gi+72@ha
	oris 9,9,0x8000
	stw 7,248(30)
	mr 3,30
	ori 0,0,1
	stw 9,264(30)
	stw 0,184(30)
	lfs 0,level+4@l(10)
	lfs 13,0(11)
	lis 11,DoRespawn@ha
	la 11,DoRespawn@l(11)
	fadds 0,0,13
	stw 11,532(30)
	stfs 0,524(30)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
.L268:
	li 3,1
.L270:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe9:
	.size	 Pickup_Ammo,.Lfe9-Pickup_Ammo
	.section	".rodata"
	.align 2
.LC30:
	.string	"Can't drop current weapon\n"
	.align 2
.LC31:
	.long 0x40a00000
	.align 2
.LC32:
	.long 0x0
	.align 2
.LC33:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Pickup_Health
	.type	 Pickup_Health,@function
Pickup_Health:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 7,3
	lwz 0,740(7)
	andi. 8,0,1
	bc 4,2,.L282
	lwz 9,576(4)
	lwz 0,580(4)
	cmpw 0,9,0
	bc 12,0,.L282
	li 3,0
	b .L290
.L282:
	lwz 0,576(4)
	lwz 9,628(7)
	add 9,0,9
	stw 9,576(4)
	lwz 0,740(7)
	andi. 11,0,1
	bc 4,2,.L284
	lwz 0,580(4)
	cmpw 0,9,0
	bc 4,1,.L284
	stw 0,576(4)
.L284:
	lwz 0,740(7)
	andi. 8,0,2
	bc 12,2,.L286
	lis 9,MegaHealth_think@ha
	lis 8,.LC31@ha
	lwz 11,264(7)
	la 9,MegaHealth_think@l(9)
	lis 10,level+4@ha
	lwz 0,184(7)
	stw 9,532(7)
	la 8,.LC31@l(8)
	oris 11,11,0x8000
	lfs 0,level+4@l(10)
	li 9,0
	ori 0,0,1
	lfs 13,0(8)
	stw 9,248(7)
	stw 4,256(7)
	fadds 0,0,13
	stw 11,264(7)
	stw 0,184(7)
	stfs 0,524(7)
	b .L287
.L286:
	lwz 0,284(7)
	andis. 6,0,0x1
	bc 4,2,.L287
	lis 9,.LC32@ha
	lis 11,deathmatch@ha
	la 9,.LC32@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L287
	lwz 9,264(7)
	lis 11,.LC33@ha
	lis 10,level+4@ha
	lwz 0,184(7)
	la 11,.LC33@l(11)
	lis 8,gi+72@ha
	oris 9,9,0x8000
	stw 6,248(7)
	mr 3,7
	ori 0,0,1
	stw 9,264(7)
	stw 0,184(7)
	lfs 0,level+4@l(10)
	lfs 13,0(11)
	lis 11,DoRespawn@ha
	la 11,DoRespawn@l(11)
	fadds 0,0,13
	stw 11,532(7)
	stfs 0,524(7)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
.L287:
	li 3,1
.L290:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 Pickup_Health,.Lfe10-Pickup_Health
	.section	".rodata"
	.align 3
.LC34:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC35:
	.long 0x0
	.align 2
.LC36:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl Pickup_Armor
	.type	 Pickup_Armor,@function
Pickup_Armor:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 12,4
	mr 31,3
	lwz 11,84(12)
	lwz 9,744(31)
	cmpwi 0,11,0
	lwz 7,64(9)
	bc 4,2,.L297
	li 6,0
	b .L298
.L297:
	lis 9,jacket_armor_index@ha
	addi 8,11,740
	lwz 6,jacket_armor_index@l(9)
	slwi 0,6,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L298
	lis 9,combat_armor_index@ha
	lwz 6,combat_armor_index@l(9)
	slwi 0,6,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L298
	lis 9,body_armor_index@ha
	lwz 10,body_armor_index@l(9)
	slwi 11,10,2
	lwzx 9,8,11
	srawi 0,9,31
	subf 0,9,0
	srawi 0,0,31
	and 6,10,0
.L298:
	lwz 8,744(31)
	lwz 0,68(8)
	cmpwi 0,0,4
	bc 4,2,.L302
	cmpwi 0,6,0
	bc 4,2,.L303
	lis 11,jacket_armor_index@ha
	lwz 9,84(12)
	li 10,2
	lwz 0,jacket_armor_index@l(11)
	addi 9,9,740
	slwi 0,0,2
	stwx 10,9,0
	b .L305
.L303:
	lwz 9,84(12)
	slwi 0,6,2
	addi 9,9,740
	lwzx 11,9,0
	addi 11,11,2
	stwx 11,9,0
	b .L305
.L302:
	cmpwi 0,6,0
	bc 4,2,.L306
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(12)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,0(7)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	stwx 10,11,9
	b .L305
.L306:
	lis 9,jacket_armor_index@ha
	lwz 0,jacket_armor_index@l(9)
	cmpw 0,6,0
	bc 4,2,.L308
	lis 9,jacketarmor_info@ha
	la 11,jacketarmor_info@l(9)
	b .L309
.L308:
	lis 9,combat_armor_index@ha
	lwz 0,combat_armor_index@l(9)
	cmpw 0,6,0
	bc 4,2,.L310
	lis 9,combatarmor_info@ha
	la 11,combatarmor_info@l(9)
	b .L309
.L310:
	lis 9,bodyarmor_info@ha
	la 11,bodyarmor_info@l(9)
.L309:
	lfs 13,8(7)
	lfs 0,8(11)
	fcmpu 0,13,0
	bc 4,1,.L312
	fdivs 11,0,13
	lwz 9,84(12)
	slwi 6,6,2
	lis 4,0x4330
	lis 10,.LC34@ha
	lwz 3,0(7)
	addi 9,9,740
	la 10,.LC34@l(10)
	lwz 7,4(7)
	lwzx 11,9,6
	li 0,0
	mr 5,8
	lfd 13,0(10)
	xoris 11,11,0x8000
	stwx 0,9,6
	lis 10,itemlist@ha
	stw 11,20(1)
	la 10,itemlist@l(10)
	lis 0,0x286b
	stw 4,16(1)
	ori 0,0,51739
	lfd 0,16(1)
	lwz 9,744(31)
	lwz 11,84(12)
	subf 9,10,9
	mullw 9,9,0
	addi 11,11,740
	rlwinm 9,9,0,0,29
	fsub 0,0,13
	frsp 0,0
	fmuls 0,11,0
	fmr 13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 0,20(1)
	add 3,3,0
	cmpw 7,3,7
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 7,7,0
	and 0,3,0
	or 3,0,7
	stwx 3,11,9
	b .L305
.L312:
	fdivs 11,13,0
	lwz 0,0(7)
	lis 8,0x4330
	lis 10,.LC34@ha
	mr 7,9
	lwz 11,4(11)
	xoris 0,0,0x8000
	la 10,.LC34@l(10)
	stw 0,20(1)
	slwi 6,6,2
	stw 8,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lwz 10,84(12)
	addi 4,10,740
	lwzx 10,4,6
	fsub 0,0,13
	frsp 0,0
	fmuls 0,11,0
	fmr 13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 0,20(1)
	add 3,10,0
	cmpw 7,3,11
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 11,11,0
	and 0,3,0
	or 0,0,11
	cmpw 0,10,0
	bc 12,0,.L316
	li 3,0
	b .L319
.L316:
	stwx 0,4,6
.L305:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L317
	lis 9,.LC35@ha
	lis 11,deathmatch@ha
	la 9,.LC35@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L317
	lwz 9,264(31)
	lis 11,.LC36@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC36@l(11)
	lis 8,gi+72@ha
	oris 9,9,0x8000
	stw 7,248(31)
	mr 3,31
	ori 0,0,1
	stw 9,264(31)
	stw 0,184(31)
	lfs 0,level+4@l(10)
	lfs 13,0(11)
	lis 11,DoRespawn@ha
	la 11,DoRespawn@l(11)
	fadds 0,0,13
	stw 11,532(31)
	stfs 0,524(31)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
.L317:
	li 3,1
.L319:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 Pickup_Armor,.Lfe11-Pickup_Armor
	.section	".rodata"
	.align 2
.LC37:
	.string	"misc/power2.wav"
	.align 2
.LC38:
	.string	"cells"
	.align 2
.LC39:
	.string	"No cells for power armor.\n"
	.align 2
.LC40:
	.string	"misc/power1.wav"
	.align 2
.LC41:
	.long 0x3f800000
	.align 2
.LC42:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_PowerArmor
	.type	 Use_PowerArmor,@function
Use_PowerArmor:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 30,3
	lwz 0,264(30)
	andi. 9,0,4096
	bc 12,2,.L326
	rlwinm 0,0,0,20,18
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(30)
	lis 3,.LC37@ha
	lwz 9,36(29)
	la 3,.LC37@l(3)
	mtlr 9
	blrl
	lis 9,.LC41@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC41@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 2,0(9)
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 3,0(9)
	blrl
	b .L325
.L337:
	mr 10,29
	b .L334
.L326:
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lis 11,.LC38@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC38@l(11)
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L335
	mr 28,10
.L330:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L332
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L337
.L332:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,76
	cmpw 0,31,0
	bc 12,0,.L330
.L335:
	li 10,0
.L334:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L336
	lis 9,gi+8@ha
	lis 5,.LC39@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC39@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L325
.L336:
	lwz 0,264(30)
	lis 29,gi@ha
	lis 3,.LC40@ha
	la 29,gi@l(29)
	la 3,.LC40@l(3)
	ori 0,0,4096
	stw 0,264(30)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC41@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC41@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 2,0(9)
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 3,0(9)
	blrl
.L325:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 Use_PowerArmor,.Lfe12-Use_PowerArmor
	.section	".rodata"
	.align 2
.LC43:
	.long 0x0
	.align 3
.LC44:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_PowerArmor
	.type	 Pickup_PowerArmor,@function
Pickup_PowerArmor:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lis 11,itemlist@ha
	lwz 9,744(31)
	la 11,itemlist@l(11)
	lis 0,0x286b
	ori 0,0,51739
	mr 29,4
	subf 9,11,9
	lwz 10,84(29)
	mullw 9,9,0
	lis 11,deathmatch@ha
	addi 10,10,740
	lwz 8,deathmatch@l(11)
	rlwinm 9,9,0,0,29
	lis 11,.LC43@ha
	lwzx 30,10,9
	la 11,.LC43@l(11)
	lfs 13,0(11)
	addi 0,30,1
	stwx 0,10,9
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L339
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L340
	lis 9,.LC44@ha
	lwz 11,744(31)
	la 9,.LC44@l(9)
	lis 7,0x4330
	lwz 0,264(31)
	lfd 12,0(9)
	lis 6,level+4@ha
	lis 10,DoRespawn@ha
	lwz 9,48(11)
	oris 0,0,0x8000
	la 10,DoRespawn@l(10)
	lwz 11,184(31)
	lis 5,gi+72@ha
	xoris 9,9,0x8000
	stw 0,264(31)
	stw 9,28(1)
	ori 11,11,1
	stw 7,24(1)
	lfd 0,24(1)
	stw 11,184(31)
	stw 4,248(31)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,532(31)
	frsp 0,0
	fadds 13,13,0
	stfs 13,524(31)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L340:
	cmpwi 0,30,0
	bc 4,2,.L339
	lwz 9,744(31)
	mr 3,29
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L339:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 Pickup_PowerArmor,.Lfe13-Pickup_PowerArmor
	.section	".rodata"
	.align 2
.LC45:
	.string	"items/s_health.wav"
	.align 2
.LC46:
	.string	"items/n_health.wav"
	.align 2
.LC47:
	.string	"items/l_health.wav"
	.align 2
.LC48:
	.string	"items/m_health.wav"
	.align 3
.LC49:
	.long 0x40080000
	.long 0x0
	.align 2
.LC50:
	.long 0x3f800000
	.align 2
.LC51:
	.long 0x0
	.section	".text"
	.align 2
	.globl Touch_Item
	.type	 Touch_Item,@function
Touch_Item:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,4
	mr 30,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L346
	lwz 0,576(31)
	cmpwi 0,0,0
	bc 4,1,.L346
	lwz 9,744(30)
	lwz 9,4(9)
	cmpwi 0,9,0
	bc 12,2,.L346
	lwz 0,320(31)
	cmpwi 0,0,0
	bc 4,2,.L346
	mtlr 9
	blrl
	mr. 28,3
	bc 12,2,.L351
	lwz 11,84(31)
	lis 0,0x3e80
	lis 9,gi@ha
	la 29,gi@l(9)
	stw 0,3620(11)
	lwz 9,744(30)
	lwz 11,40(29)
	lwz 3,36(9)
	mtlr 11
	blrl
	lis 9,itemlist@ha
	lwz 11,84(31)
	lis 8,0x286b
	la 7,itemlist@l(9)
	ori 8,8,51739
	lis 9,.LC49@ha
	sth 3,134(11)
	lis 10,level+4@ha
	la 9,.LC49@l(9)
	lwz 11,84(31)
	lfd 13,0(9)
	lwz 9,744(30)
	subf 9,7,9
	mullw 9,9,8
	srawi 9,9,2
	addi 9,9,1056
	sth 9,136(11)
	lfs 0,level+4@l(10)
	lwz 9,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3740(9)
	lwz 9,744(30)
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 12,2,.L352
	subf 0,7,9
	lwz 11,84(31)
	mullw 0,0,8
	srawi 0,0,2
	extsh 9,0
	sth 0,144(11)
	stw 9,736(11)
.L352:
	lwz 3,744(30)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	lwz 0,4(3)
	cmpw 0,0,9
	bc 4,2,.L353
	lwz 0,628(30)
	cmpwi 0,0,2
	bc 4,2,.L354
	lwz 9,36(29)
	lis 3,.LC45@ha
	la 3,.LC45@l(3)
	b .L368
.L354:
	cmpwi 0,0,10
	bc 4,2,.L356
	lwz 9,36(29)
	lis 3,.LC46@ha
	la 3,.LC46@l(3)
	b .L368
.L356:
	cmpwi 0,0,25
	bc 4,2,.L358
	lwz 9,36(29)
	lis 3,.LC47@ha
	la 3,.LC47@l(3)
	b .L368
.L358:
	lwz 9,36(29)
	lis 3,.LC48@ha
	la 3,.LC48@l(3)
.L368:
	mtlr 9
	blrl
	lis 9,.LC50@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC50@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 2,0(9)
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 3,0(9)
	blrl
	b .L351
.L353:
	lwz 3,20(3)
	cmpwi 0,3,0
	bc 12,2,.L351
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC50@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC50@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 2,0(9)
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 3,0(9)
	blrl
.L351:
	lwz 0,284(30)
	andis. 9,0,4
	bc 4,2,.L362
	mr 4,31
	mr 3,30
	bl G_UseTargets
	lwz 0,284(30)
	oris 0,0,0x4
	stw 0,284(30)
.L362:
	cmpwi 0,28,0
	bc 12,2,.L346
	lis 9,.LC51@ha
	lis 11,coop@ha
	la 9,.LC51@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L365
	lwz 9,744(30)
	lwz 0,56(9)
	andi. 9,0,8
	bc 12,2,.L365
	lwz 0,284(30)
	andis. 9,0,0x3
	bc 12,2,.L346
.L365:
	lwz 0,264(30)
	cmpwi 0,0,0
	bc 4,0,.L366
	rlwinm 0,0,0,1,31
	stw 0,264(30)
	b .L346
.L366:
	mr 3,30
	bl G_FreeEdict
.L346:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 Touch_Item,.Lfe14-Touch_Item
	.section	".rodata"
	.align 2
.LC52:
	.long 0x42c80000
	.align 2
.LC53:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Drop_Item
	.type	 Drop_Item,@function
Drop_Item:
	stwu 1,-144(1)
	mflr 0
	stmw 26,120(1)
	stw 0,148(1)
	mr 29,4
	mr 30,3
	bl G_Spawn
	lwz 9,0(29)
	mr 31,3
	lis 0,0x1
	stw 0,284(31)
	lis 11,0xc170
	lis 10,0x4170
	stw 9,280(31)
	li 8,512
	stw 29,744(31)
	lis 9,gi@ha
	lwz 0,28(29)
	la 26,gi@l(9)
	stw 11,196(31)
	stw 0,64(31)
	stw 11,188(31)
	stw 11,192(31)
	stw 8,68(31)
	stw 10,208(31)
	stw 10,200(31)
	stw 10,204(31)
	lwz 9,44(26)
	lwz 4,24(29)
	mtlr 9
	blrl
	lis 9,drop_temp_touch@ha
	li 11,1
	stw 30,256(31)
	la 9,drop_temp_touch@l(9)
	li 0,7
	stw 11,248(31)
	stw 0,260(31)
	stw 9,540(31)
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 12,2,.L374
	addi 29,1,24
	addi 4,1,8
	addi 3,3,3636
	mr 5,29
	li 6,0
	addi 27,30,4
	bl AngleVectors
	addi 28,31,4
	lis 0,0x41c0
	li 9,0
	lis 11,0xc180
	stw 0,40(1)
	addi 4,1,40
	stw 9,44(1)
	addi 5,1,8
	mr 6,29
	mr 3,27
	stw 11,48(1)
	mr 7,28
	bl G_ProjectSource
	lwz 0,48(26)
	mr 4,27
	mr 7,28
	mr 8,30
	addi 3,1,56
	addi 5,31,188
	addi 6,31,200
	mtlr 0
	li 9,1
	blrl
	lfs 0,68(1)
	stfs 0,4(31)
	lfs 13,72(1)
	stfs 13,8(31)
	lfs 0,76(1)
	b .L376
.L374:
	addi 3,30,16
	addi 4,1,8
	addi 5,1,24
	li 6,0
	bl AngleVectors
	lfs 0,4(30)
	stfs 0,4(31)
	lfs 13,8(30)
	stfs 13,8(31)
	lfs 0,12(30)
.L376:
	stfs 0,12(31)
	lis 9,.LC52@ha
	addi 3,1,8
	la 9,.LC52@l(9)
	addi 4,31,472
	lfs 1,0(9)
	bl VectorScale
	lis 9,drop_make_touchable@ha
	lis 0,0x4396
	la 9,drop_make_touchable@l(9)
	stw 0,480(31)
	lis 11,level+4@ha
	stw 9,532(31)
	mr 3,31
	lis 9,.LC53@ha
	lfs 0,level+4@l(11)
	la 9,.LC53@l(9)
	lfs 13,0(9)
	lis 9,gi+72@ha
	fadds 0,0,13
	stfs 0,524(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	lwz 0,148(1)
	mtlr 0
	lmw 26,120(1)
	la 1,144(1)
	blr
.Lfe15:
	.size	 Drop_Item,.Lfe15-Drop_Item
	.section	".rodata"
	.align 2
.LC54:
	.string	"droptofloor: %s startsolid at %s\n"
	.align 3
.LC55:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC56:
	.long 0xc1700000
	.align 2
.LC57:
	.long 0x41700000
	.align 2
.LC58:
	.long 0x0
	.align 2
.LC59:
	.long 0xc3000000
	.section	".text"
	.align 2
	.globl droptofloor
	.type	 droptofloor,@function
droptofloor:
	stwu 1,-112(1)
	mflr 0
	stmw 29,100(1)
	stw 0,116(1)
	lis 9,.LC56@ha
	lis 11,.LC56@ha
	la 9,.LC56@l(9)
	la 11,.LC56@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC56@ha
	lfs 2,0(11)
	la 9,.LC56@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC57@ha
	lfs 13,0(11)
	la 9,.LC57@l(9)
	lfs 1,0(9)
	lis 9,.LC57@ha
	stfs 13,188(31)
	la 9,.LC57@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC57@ha
	stfs 0,192(31)
	la 9,.LC57@l(9)
	lfs 13,8(11)
	lfs 3,0(9)
	stfs 13,196(31)
	bl tv
	mr 11,3
	lwz 4,268(31)
	lfs 13,0(11)
	cmpwi 0,4,0
	stfs 13,200(31)
	lfs 0,4(11)
	stfs 0,204(31)
	lfs 13,8(11)
	stfs 13,208(31)
	bc 12,2,.L381
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L382
.L381:
	lis 9,gi+44@ha
	lwz 11,744(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L382:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC58@ha
	stw 9,540(31)
	addi 29,31,4
	la 11,.LC58@l(11)
	lis 9,.LC59@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC59@l(9)
	lis 11,.LC58@ha
	lfs 3,0(9)
	la 11,.LC58@l(11)
	lfs 2,0(11)
	bl tv
	mr 11,3
	lfs 11,4(31)
	lis 9,gi@ha
	lfs 0,0(11)
	la 30,gi@l(9)
	mr 8,31
	lfs 12,8(31)
	addi 3,1,8
	mr 4,29
	lfs 13,12(31)
	addi 5,31,188
	addi 6,31,200
	fadds 11,11,0
	lwz 10,48(30)
	addi 7,1,72
	li 9,3
	mtlr 10
	stfs 11,72(1)
	lfs 0,4(11)
	fadds 12,12,0
	stfs 12,76(1)
	lfs 0,8(11)
	fadds 13,13,0
	stfs 13,80(1)
	blrl
	lwz 8,12(1)
	cmpwi 0,8,0
	bc 12,2,.L383
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC54@ha
	la 3,.LC54@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L380
.L383:
	lwz 0,404(31)
	lfs 12,20(1)
	lfs 0,24(1)
	cmpwi 0,0,0
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L384
	lwz 11,660(31)
	lwz 0,264(31)
	lwz 9,184(31)
	cmpw 0,31,11
	lwz 10,656(31)
	rlwinm 0,0,0,22,20
	ori 9,9,1
	stw 0,264(31)
	stw 10,632(31)
	stw 9,184(31)
	stw 8,248(31)
	stw 8,656(31)
	bc 4,2,.L384
	lis 11,level+4@ha
	lis 10,.LC55@ha
	lfs 0,level+4@l(11)
	lis 9,DoRespawn@ha
	lfd 13,.LC55@l(10)
	la 9,DoRespawn@l(9)
	stw 9,532(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
.L384:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L386
	lwz 9,64(31)
	li 11,2
	li 10,0
	lwz 0,68(31)
	rlwinm 9,9,0,0,30
	stw 11,248(31)
	rlwinm 0,0,0,23,21
	stw 10,540(31)
	stw 9,64(31)
	stw 0,68(31)
.L386:
	lwz 0,284(31)
	andi. 11,0,1
	bc 12,2,.L387
	lwz 0,184(31)
	lis 9,Use_Item@ha
	li 11,0
	la 9,Use_Item@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,544(31)
	stw 0,184(31)
.L387:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L380:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe16:
	.size	 droptofloor,.Lfe16-droptofloor
	.section	".rodata"
	.align 2
.LC60:
	.string	"PrecacheItem: %s has bad precache string"
	.align 2
.LC61:
	.string	"md2"
	.align 2
.LC62:
	.string	"sp2"
	.align 2
.LC63:
	.string	"wav"
	.align 2
.LC64:
	.string	"pcx"
	.section	".text"
	.align 2
	.globl PrecacheItem
	.type	 PrecacheItem,@function
PrecacheItem:
	stwu 1,-112(1)
	mflr 0
	stmw 24,80(1)
	stw 0,116(1)
	mr. 26,3
	bc 12,2,.L388
	lwz 3,20(26)
	cmpwi 0,3,0
	bc 12,2,.L390
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L390:
	lwz 3,24(26)
	cmpwi 0,3,0
	bc 12,2,.L391
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L391:
	lwz 3,32(26)
	cmpwi 0,3,0
	bc 12,2,.L392
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L392:
	lwz 3,36(26)
	cmpwi 0,3,0
	bc 12,2,.L393
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
.L393:
	lwz 29,52(26)
	cmpwi 0,29,0
	bc 12,2,.L394
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L394
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L402
	mr 28,9
.L397:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L399
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L399
	mr 3,31
	b .L401
.L399:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L397
.L402:
	li 3,0
.L401:
	cmpw 0,3,26
	bc 12,2,.L394
	bl PrecacheItem
.L394:
	lwz 30,72(26)
	cmpwi 0,30,0
	bc 12,2,.L388
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 12,2,.L388
	lis 9,gi@ha
	addi 29,1,8
	la 27,gi@l(9)
	lis 24,.LC61@ha
	lis 25,.LC64@ha
.L408:
	rlwinm 9,0,0,0xff
	mr 31,30
	b .L422
.L411:
	lbzu 9,1(30)
.L422:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L411
	subf 28,31,30
	addi 0,28,-5
	cmplwi 0,0,58
	bc 4,1,.L413
	lwz 9,28(27)
	lis 3,.LC60@ha
	la 3,.LC60@l(3)
	lwz 4,0(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L413:
	mr 4,31
	mr 5,28
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 0,0
	addi 11,30,1
	stbx 0,29,28
	add 9,29,28
	la 4,.LC61@l(24)
	lbz 0,0(30)
	addi 31,9,-3
	mr 3,31
	addic 0,0,-1
	subfe 0,0,0
	andc 11,11,0
	and 0,30,0
	or 30,0,11
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L423
	lis 4,.LC62@ha
	mr 3,31
	la 4,.LC62@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L417
.L423:
	lwz 9,32(27)
	mr 3,29
	mtlr 9
	blrl
	b .L416
.L417:
	lis 4,.LC63@ha
	mr 3,31
	la 4,.LC63@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L416
	lwz 9,36(27)
	mr 3,29
	mtlr 9
	blrl
.L416:
	add 3,29,28
	la 4,.LC64@l(25)
	addi 3,3,-3
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L406
	lwz 9,40(27)
	mr 3,29
	mtlr 9
	blrl
.L406:
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L408
.L388:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe17:
	.size	 PrecacheItem,.Lfe17-PrecacheItem
	.section	".rodata"
	.align 2
.LC65:
	.string	"%s at %s has invalid spawnflags set\n"
	.align 2
.LC66:
	.string	"weapon_bfg"
	.align 3
.LC67:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC68:
	.long 0x0
	.section	".text"
	.align 2
	.globl SpawnItem
	.type	 SpawnItem,@function
SpawnItem:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	mr 3,30
	bl PrecacheItem
	lwz 0,284(31)
	cmpwi 0,0,0
	bc 12,2,.L425
	lwz 3,280(31)
	lis 4,.LC25@ha
	la 4,.LC25@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L425
	li 0,0
	lis 29,gi@ha
	lwz 28,280(31)
	la 29,gi@l(29)
	stw 0,284(31)
	addi 3,31,4
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC65@ha
	la 3,.LC65@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L425:
	lis 9,.LC68@ha
	lis 11,deathmatch@ha
	la 9,.LC68@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L427
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2048
	bc 12,2,.L428
	lwz 0,4(30)
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L438
	lis 9,Pickup_PowerArmor@ha
	la 9,Pickup_PowerArmor@l(9)
	cmpw 0,0,9
	bc 12,2,.L438
.L428:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 12,2,.L431
	lwz 0,4(30)
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L438
.L431:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 12,2,.L433
	lwz 0,4(30)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L438
	lis 9,Pickup_Adrenaline@ha
	la 9,Pickup_Adrenaline@l(9)
	cmpw 0,0,9
	bc 12,2,.L438
	lis 9,Pickup_AncientHead@ha
	la 9,Pickup_AncientHead@l(9)
	cmpw 0,0,9
	bc 12,2,.L438
.L433:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8192
	bc 12,2,.L427
	lwz 0,56(30)
	cmpwi 0,0,2
	bc 12,2,.L438
	lwz 3,280(31)
	lis 4,.LC66@ha
	la 4,.LC66@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L427
.L438:
	mr 3,31
	bl G_FreeEdict
	b .L424
.L427:
	lis 11,.LC68@ha
	lis 9,coop@ha
	la 11,.LC68@l(11)
	lis 29,level@ha
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L439
	lwz 3,280(31)
	lis 4,.LC25@ha
	la 4,.LC25@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L439
	la 10,level@l(29)
	lwz 11,284(31)
	li 0,1
	lwz 9,320(10)
	addi 9,9,8
	slw 0,0,9
	or 11,11,0
	stw 11,284(31)
	lwz 9,320(10)
	addi 9,9,1
	stw 9,320(10)
.L439:
	lis 9,.LC68@ha
	lis 11,coop@ha
	la 9,.LC68@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L440
	lwz 0,56(30)
	andi. 11,0,8
	bc 12,2,.L440
	li 0,0
	stw 0,12(30)
.L440:
	stw 30,744(31)
	lis 11,level+4@ha
	lis 10,.LC67@ha
	lfs 0,level+4@l(11)
	lis 9,droptofloor@ha
	lfd 13,.LC67@l(10)
	la 9,droptofloor@l(9)
	li 11,512
	lwz 3,268(31)
	stw 9,532(31)
	cmpwi 0,3,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
	lwz 0,28(30)
	stw 11,68(31)
	stw 0,64(31)
	bc 12,2,.L424
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L424:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 SpawnItem,.Lfe18-SpawnItem
	.globl itemlist
	.section	".data"
	.align 2
	.type	 itemlist,@object
itemlist:
	.long 0
	.space	72
	.long .LC69
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC71
	.long 1
	.long 0
	.long .LC72
	.long .LC73
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long bodyarmor_info
	.long 3
	.long .LC74
	.long .LC75
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC76
	.long 1
	.long 0
	.long .LC77
	.long .LC78
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long combatarmor_info
	.long 2
	.long .LC74
	.long .LC79
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC80
	.long 1
	.long 0
	.long .LC81
	.long .LC82
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long jacketarmor_info
	.long 1
	.long .LC74
	.long .LC83
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC84
	.long .LC85
	.long 1
	.long 0
	.long .LC81
	.long .LC86
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long 0
	.long 4
	.long .LC74
	.long .LC87
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC88
	.long .LC89
	.long 1
	.long 0
	.long .LC90
	.long .LC91
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long .LC92
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC88
	.long .LC93
	.long 1
	.long 0
	.long .LC94
	.long .LC95
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC96
	.long .LC97
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Blaster
	.long .LC98
	.long 0
	.long 0
	.long .LC99
	.long .LC100
	.long .LC101
	.long 0
	.long 0
	.long 0
	.long 9
	.long 1
	.long 0
	.long 0
	.long .LC102
	.long .LC103
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Shotgun
	.long .LC98
	.long .LC104
	.long 1
	.long .LC105
	.long .LC106
	.long .LC107
	.long 0
	.long 1
	.long .LC8
	.long 9
	.long 2
	.long 0
	.long 0
	.long .LC108
	.long .LC109
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_SuperShotgun
	.long .LC98
	.long .LC110
	.long 1
	.long .LC111
	.long .LC112
	.long .LC113
	.long 0
	.long 2
	.long .LC8
	.long 9
	.long 3
	.long 0
	.long 0
	.long .LC114
	.long .LC115
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Machinegun
	.long .LC98
	.long .LC116
	.long 1
	.long .LC117
	.long .LC118
	.long .LC119
	.long 0
	.long 1
	.long .LC7
	.long 9
	.long 4
	.long 0
	.long 0
	.long .LC120
	.long .LC121
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Chaingun
	.long .LC98
	.long .LC122
	.long 1
	.long .LC123
	.long .LC124
	.long .LC125
	.long 0
	.long 1
	.long .LC7
	.long 9
	.long 5
	.long 0
	.long 0
	.long .LC126
	.long .LC127
	.long Pickup_Ammo
	.long Use_Weapon
	.long Drop_Ammo
	.long Weapon_Grenade
	.long .LC128
	.long .LC129
	.long 0
	.long .LC130
	.long .LC131
	.long .LC11
	.long 3
	.long 5
	.long .LC132
	.long 3
	.long 6
	.long 0
	.long 3
	.long .LC133
	.long .LC134
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_GrenadeLauncher
	.long .LC98
	.long .LC135
	.long 1
	.long .LC136
	.long .LC137
	.long .LC138
	.long 0
	.long 1
	.long .LC11
	.long 9
	.long 7
	.long 0
	.long 0
	.long .LC139
	.long .LC140
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_RocketLauncher
	.long .LC98
	.long .LC141
	.long 1
	.long .LC142
	.long .LC143
	.long .LC144
	.long 0
	.long 1
	.long .LC12
	.long 9
	.long 8
	.long 0
	.long 0
	.long .LC145
	.long .LC146
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_HyperBlaster
	.long .LC98
	.long .LC147
	.long 1
	.long .LC148
	.long .LC149
	.long .LC150
	.long 0
	.long 1
	.long .LC0
	.long 9
	.long 9
	.long 0
	.long 0
	.long .LC151
	.long .LC152
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Railgun
	.long .LC98
	.long .LC153
	.long 1
	.long .LC154
	.long .LC155
	.long .LC156
	.long 0
	.long 1
	.long .LC13
	.long 9
	.long 10
	.long 0
	.long 0
	.long .LC157
	.long .LC66
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_BFG
	.long .LC98
	.long .LC158
	.long 1
	.long .LC159
	.long .LC160
	.long .LC161
	.long 0
	.long 50
	.long .LC0
	.long 9
	.long 11
	.long 0
	.long 0
	.long .LC162
	.long .LC163
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC128
	.long .LC164
	.long 0
	.long 0
	.long .LC165
	.long .LC8
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 1
	.long .LC74
	.long .LC166
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC128
	.long .LC167
	.long 0
	.long 0
	.long .LC168
	.long .LC7
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long .LC169
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC128
	.long .LC170
	.long 0
	.long 0
	.long .LC171
	.long .LC0
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long 4
	.long .LC74
	.long .LC172
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC128
	.long .LC173
	.long 0
	.long 0
	.long .LC174
	.long .LC12
	.long 3
	.long 5
	.long 0
	.long 2
	.long 0
	.long 0
	.long 2
	.long .LC74
	.long .LC175
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC128
	.long .LC176
	.long 0
	.long 0
	.long .LC177
	.long .LC13
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 5
	.long .LC74
	.long .LC178
	.long Pickup_Powerup
	.long Use_Quad
	.long Drop_General
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC182
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC183
	.long .LC184
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC184
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 511
	.long 0
	.long .LC185
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC185
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 523
	.long 0
	.long .LC186
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC186
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 510
	.long 0
	.long .LC187
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC187
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 509
	.long 0
	.long .LC188
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC188
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 512
	.long 0
	.long .LC189
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC189
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 501
	.long 0
	.long .LC190
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC190
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 517
	.long 0
	.long .LC191
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC191
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 513
	.long 0
	.long .LC192
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC192
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 514
	.long 0
	.long .LC193
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC193
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 507
	.long 0
	.long .LC194
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC194
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 516
	.long 0
	.long .LC195
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC195
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 502
	.long 0
	.long .LC196
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC196
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 503
	.long 0
	.long .LC197
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC197
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 515
	.long 0
	.long .LC198
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC198
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 518
	.long 0
	.long .LC199
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC199
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 522
	.long 0
	.long .LC200
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC200
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 504
	.long 0
	.long .LC201
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC201
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 505
	.long 0
	.long .LC202
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC202
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 506
	.long 0
	.long .LC203
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC203
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 508
	.long 0
	.long .LC204
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC204
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 524
	.long 0
	.long .LC205
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC205
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 521
	.long 0
	.long .LC206
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC206
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 519
	.long 0
	.long .LC207
	.long 0
	.long Checktospawn
	.long 0
	.long 0
	.long .LC179
	.long .LC180
	.long 1
	.long 0
	.long .LC181
	.long .LC207
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 520
	.long 0
	.long .LC208
	.long Pickup_Powerup
	.long Use_Invulnerability
	.long Drop_General
	.long 0
	.long .LC179
	.long .LC209
	.long 1
	.long 0
	.long .LC210
	.long .LC211
	.long 2
	.long 300
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC212
	.long .LC213
	.long Pickup_Powerup
	.long Use_Silencer
	.long Drop_General
	.long 0
	.long .LC179
	.long .LC214
	.long 1
	.long 0
	.long .LC215
	.long .LC216
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long .LC217
	.long Pickup_Powerup
	.long Use_Breather
	.long Drop_General
	.long 0
	.long .LC179
	.long .LC218
	.long 1
	.long 0
	.long .LC219
	.long .LC220
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long 0
	.long .LC221
	.long .LC222
	.long Pickup_Powerup
	.long Use_Envirosuit
	.long Drop_General
	.long 0
	.long .LC179
	.long .LC223
	.long 1
	.long 0
	.long .LC224
	.long .LC225
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long 0
	.long .LC221
	.long .LC226
	.long Pickup_AncientHead
	.long 0
	.long 0
	.long 0
	.long .LC179
	.long .LC227
	.long 1
	.long 0
	.long .LC228
	.long .LC229
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long .LC230
	.long Pickup_Adrenaline
	.long 0
	.long 0
	.long 0
	.long .LC179
	.long .LC231
	.long 1
	.long 0
	.long .LC232
	.long .LC233
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long .LC234
	.long Pickup_Bandolier
	.long 0
	.long 0
	.long 0
	.long .LC179
	.long .LC235
	.long 1
	.long 0
	.long .LC236
	.long .LC237
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long .LC238
	.long Pickup_Pack
	.long 0
	.long 0
	.long 0
	.long .LC179
	.long .LC239
	.long 1
	.long 0
	.long .LC240
	.long .LC241
	.long 2
	.long 180
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long .LC242
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC179
	.long .LC243
	.long 1
	.long 0
	.long .LC244
	.long .LC245
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long .LC25
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC179
	.long .LC246
	.long 1
	.long 0
	.long .LC247
	.long .LC248
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long .LC249
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC179
	.long .LC250
	.long 1
	.long 0
	.long .LC251
	.long .LC252
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long .LC253
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC179
	.long .LC254
	.long 1
	.long 0
	.long .LC255
	.long .LC256
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long .LC257
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC179
	.long .LC258
	.long 1
	.long 0
	.long .LC259
	.long .LC260
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long .LC261
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC179
	.long .LC262
	.long 1
	.long 0
	.long .LC263
	.long .LC264
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long .LC265
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC179
	.long .LC266
	.long 1
	.long 0
	.long .LC267
	.long .LC268
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long .LC269
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC179
	.long .LC270
	.long 2
	.long 0
	.long .LC271
	.long .LC272
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long .LC273
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC179
	.long .LC274
	.long 1
	.long 0
	.long .LC275
	.long .LC276
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long 0
	.long Pickup_Health
	.long 0
	.long 0
	.long 0
	.long .LC179
	.long 0
	.long 0
	.long 0
	.long .LC277
	.long .LC278
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC279
	.long 0
	.space	72
	.section	".rodata"
	.align 2
.LC279:
	.string	"items/s_health.wav items/n_health.wav items/l_health.wav items/m_health.wav"
	.align 2
.LC278:
	.string	"Health"
	.align 2
.LC277:
	.string	"i_health"
	.align 2
.LC276:
	.string	"Airstrike Marker"
	.align 2
.LC275:
	.string	"i_airstrike"
	.align 2
.LC274:
	.string	"models/items/keys/target/tris.md2"
	.align 2
.LC273:
	.string	"key_airstrike_target"
	.align 2
.LC272:
	.string	"Commander's Head"
	.align 2
.LC271:
	.string	"k_comhead"
	.align 2
.LC270:
	.string	"models/monsters/commandr/head/tris.md2"
	.align 2
.LC269:
	.string	"key_commander_head"
	.align 2
.LC268:
	.string	"Red Key"
	.align 2
.LC267:
	.string	"k_redkey"
	.align 2
.LC266:
	.string	"models/items/keys/red_key/tris.md2"
	.align 2
.LC265:
	.string	"key_red_key"
	.align 2
.LC264:
	.string	"Blue Key"
	.align 2
.LC263:
	.string	"k_bluekey"
	.align 2
.LC262:
	.string	"models/items/keys/key/tris.md2"
	.align 2
.LC261:
	.string	"key_blue_key"
	.align 2
.LC260:
	.string	"Security Pass"
	.align 2
.LC259:
	.string	"k_security"
	.align 2
.LC258:
	.string	"models/items/keys/pass/tris.md2"
	.align 2
.LC257:
	.string	"key_pass"
	.align 2
.LC256:
	.string	"Data Spinner"
	.align 2
.LC255:
	.string	"k_dataspin"
	.align 2
.LC254:
	.string	"models/items/keys/spinner/tris.md2"
	.align 2
.LC253:
	.string	"key_data_spinner"
	.align 2
.LC252:
	.string	"Pyramid Key"
	.align 2
.LC251:
	.string	"k_pyramid"
	.align 2
.LC250:
	.string	"models/items/keys/pyramid/tris.md2"
	.align 2
.LC249:
	.string	"key_pyramid"
	.align 2
.LC248:
	.string	"Power Cube"
	.align 2
.LC247:
	.string	"k_powercube"
	.align 2
.LC246:
	.string	"models/items/keys/power/tris.md2"
	.align 2
.LC245:
	.string	"Data CD"
	.align 2
.LC244:
	.string	"k_datacd"
	.align 2
.LC243:
	.string	"models/items/keys/data_cd/tris.md2"
	.align 2
.LC242:
	.string	"key_data_cd"
	.align 2
.LC241:
	.string	"Ammo Pack"
	.align 2
.LC240:
	.string	"i_pack"
	.align 2
.LC239:
	.string	"models/items/pack/tris.md2"
	.align 2
.LC238:
	.string	"item_pack"
	.align 2
.LC237:
	.string	"Bandolier"
	.align 2
.LC236:
	.string	"p_bandolier"
	.align 2
.LC235:
	.string	"models/items/band/tris.md2"
	.align 2
.LC234:
	.string	"item_bandolier"
	.align 2
.LC233:
	.string	"Adrenaline"
	.align 2
.LC232:
	.string	"p_adrenaline"
	.align 2
.LC231:
	.string	"models/items/adrenal/tris.md2"
	.align 2
.LC230:
	.string	"item_adrenaline"
	.align 2
.LC229:
	.string	"Ancient Head"
	.align 2
.LC228:
	.string	"i_fixme"
	.align 2
.LC227:
	.string	"models/items/c_head/tris.md2"
	.align 2
.LC226:
	.string	"item_ancient_head"
	.align 2
.LC225:
	.string	"Environment Suit"
	.align 2
.LC224:
	.string	"p_envirosuit"
	.align 2
.LC223:
	.string	"models/items/enviro/tris.md2"
	.align 2
.LC222:
	.string	"item_enviro"
	.align 2
.LC221:
	.string	"items/airout.wav"
	.align 2
.LC220:
	.string	"Rebreather"
	.align 2
.LC219:
	.string	"p_rebreather"
	.align 2
.LC218:
	.string	"models/items/breather/tris.md2"
	.align 2
.LC217:
	.string	"item_breather"
	.align 2
.LC216:
	.string	"Silencer"
	.align 2
.LC215:
	.string	"p_silencer"
	.align 2
.LC214:
	.string	"models/items/silencer/tris.md2"
	.align 2
.LC213:
	.string	"item_silencer"
	.align 2
.LC212:
	.string	"items/protect.wav items/protect2.wav items/protect4.wav"
	.align 2
.LC211:
	.string	"Invulnerability"
	.align 2
.LC210:
	.string	"p_invulnerability"
	.align 2
.LC209:
	.string	"models/items/invulner/tris.md2"
	.align 2
.LC208:
	.string	"item_invulnerability"
	.align 2
.LC207:
	.string	"Jorg"
	.align 2
.LC206:
	.string	"Makron"
	.align 2
.LC205:
	.string	"Flying Boss"
	.align 2
.LC204:
	.string	"Teleporter"
	.align 2
.LC203:
	.string	"Supertank"
	.align 2
.LC202:
	.string	"Tank Commander"
	.align 2
.LC201:
	.string	"Tank"
	.align 2
.LC200:
	.string	"Gladiator"
	.align 2
.LC199:
	.string	"Medic"
	.align 2
.LC198:
	.string	"Icarus"
	.align 2
.LC197:
	.string	"Mutant"
	.align 2
.LC196:
	.string	"Chick"
	.align 2
.LC195:
	.string	"Gunner"
	.align 2
.LC194:
	.string	"Brains"
	.align 2
.LC193:
	.string	"Parasite"
	.align 2
.LC192:
	.string	"Floater"
	.align 2
.LC191:
	.string	"Flyer"
	.align 2
.LC190:
	.string	"Fish"
	.align 2
.LC189:
	.string	"Berserk"
	.align 2
.LC188:
	.string	"Enforcer"
	.align 2
.LC187:
	.string	"Machinegunner"
	.align 2
.LC186:
	.string	"Soldier"
	.align 2
.LC185:
	.string	"Mine Trap"
	.align 2
.LC184:
	.string	"Light Soldier"
	.align 2
.LC183:
	.string	"items/damage.wav items/damage2.wav items/damage3.wav"
	.align 2
.LC182:
	.string	"Quad Damage"
	.align 2
.LC181:
	.string	"p_quad"
	.align 2
.LC180:
	.string	"models/items/quaddama/tris.md2"
	.align 2
.LC179:
	.string	"items/pkup.wav"
	.align 2
.LC178:
	.string	"item_quad"
	.align 2
.LC177:
	.string	"a_slugs"
	.align 2
.LC176:
	.string	"models/items/ammo/slugs/medium/tris.md2"
	.align 2
.LC175:
	.string	"ammo_slugs"
	.align 2
.LC174:
	.string	"a_rockets"
	.align 2
.LC173:
	.string	"models/items/ammo/rockets/medium/tris.md2"
	.align 2
.LC172:
	.string	"ammo_rockets"
	.align 2
.LC171:
	.string	"a_cells"
	.align 2
.LC170:
	.string	"models/items/ammo/cells/medium/tris.md2"
	.align 2
.LC169:
	.string	"ammo_cells"
	.align 2
.LC168:
	.string	"a_bullets"
	.align 2
.LC167:
	.string	"models/items/ammo/bullets/medium/tris.md2"
	.align 2
.LC166:
	.string	"ammo_bullets"
	.align 2
.LC165:
	.string	"a_shells"
	.align 2
.LC164:
	.string	"models/items/ammo/shells/medium/tris.md2"
	.align 2
.LC163:
	.string	"ammo_shells"
	.align 2
.LC162:
	.string	"sprites/s_bfg1.sp2 sprites/s_bfg2.sp2 sprites/s_bfg3.sp2 weapons/bfg__f1y.wav weapons/bfg__l1a.wav weapons/bfg__x1b.wav weapons/bfg_hum.wav"
	.align 2
.LC161:
	.string	"BFG10K"
	.align 2
.LC160:
	.string	"w_bfg"
	.align 2
.LC159:
	.string	"models/weapons/v_bfg/tris.md2"
	.align 2
.LC158:
	.string	"models/weapons/g_bfg/tris.md2"
	.align 2
.LC157:
	.string	"weapons/rg_hum.wav"
	.align 2
.LC156:
	.string	"Railgun"
	.align 2
.LC155:
	.string	"w_railgun"
	.align 2
.LC154:
	.string	"models/weapons/v_rail/tris.md2"
	.align 2
.LC153:
	.string	"models/weapons/g_rail/tris.md2"
	.align 2
.LC152:
	.string	"weapon_railgun"
	.align 2
.LC151:
	.string	"weapons/hyprbu1a.wav weapons/hyprbl1a.wav weapons/hyprbf1a.wav weapons/hyprbd1a.wav misc/lasfly.wav"
	.align 2
.LC150:
	.string	"HyperBlaster"
	.align 2
.LC149:
	.string	"w_hyperblaster"
	.align 2
.LC148:
	.string	"models/weapons/v_hyperb/tris.md2"
	.align 2
.LC147:
	.string	"models/weapons/g_hyperb/tris.md2"
	.align 2
.LC146:
	.string	"weapon_hyperblaster"
	.align 2
.LC145:
	.string	"models/objects/rocket/tris.md2 weapons/rockfly.wav weapons/rocklf1a.wav weapons/rocklr1b.wav models/objects/debris2/tris.md2"
	.align 2
.LC144:
	.string	"Rocket Launcher"
	.align 2
.LC143:
	.string	"w_rlauncher"
	.align 2
.LC142:
	.string	"models/weapons/v_rocket/tris.md2"
	.align 2
.LC141:
	.string	"models/weapons/g_rocket/tris.md2"
	.align 2
.LC140:
	.string	"weapon_rocketlauncher"
	.align 2
.LC139:
	.string	"models/objects/grenade/tris.md2 weapons/grenlf1a.wav weapons/grenlr1b.wav weapons/grenlb1b.wav"
	.align 2
.LC138:
	.string	"Grenade Launcher"
	.align 2
.LC137:
	.string	"w_glauncher"
	.align 2
.LC136:
	.string	"models/weapons/v_launch/tris.md2"
	.align 2
.LC135:
	.string	"models/weapons/g_launch/tris.md2"
	.align 2
.LC134:
	.string	"weapon_grenadelauncher"
	.align 2
.LC133:
	.string	"weapons/hgrent1a.wav weapons/hgrena1b.wav weapons/hgrenc1b.wav weapons/hgrenb1a.wav weapons/hgrenb2a.wav "
	.align 2
.LC132:
	.string	"grenades"
	.align 2
.LC131:
	.string	"a_grenades"
	.align 2
.LC130:
	.string	"models/weapons/v_handgr/tris.md2"
	.align 2
.LC129:
	.string	"models/items/ammo/grenades/medium/tris.md2"
	.align 2
.LC128:
	.string	"misc/am_pkup.wav"
	.align 2
.LC127:
	.string	"ammo_grenades"
	.align 2
.LC126:
	.string	"weapons/chngnu1a.wav weapons/chngnl1a.wav weapons/machgf3b.wav` weapons/chngnd1a.wav"
	.align 2
.LC125:
	.string	"Chaingun"
	.align 2
.LC124:
	.string	"w_chaingun"
	.align 2
.LC123:
	.string	"models/weapons/v_chain/tris.md2"
	.align 2
.LC122:
	.string	"models/weapons/g_chain/tris.md2"
	.align 2
.LC121:
	.string	"weapon_chaingun"
	.align 2
.LC120:
	.string	"weapons/machgf1b.wav weapons/machgf2b.wav weapons/machgf3b.wav weapons/machgf4b.wav weapons/machgf5b.wav"
	.align 2
.LC119:
	.string	"Machinegun"
	.align 2
.LC118:
	.string	"w_machinegun"
	.align 2
.LC117:
	.string	"models/weapons/v_machn/tris.md2"
	.align 2
.LC116:
	.string	"models/weapons/g_machn/tris.md2"
	.align 2
.LC115:
	.string	"weapon_machinegun"
	.align 2
.LC114:
	.string	"weapons/sshotf1b.wav"
	.align 2
.LC113:
	.string	"Super Shotgun"
	.align 2
.LC112:
	.string	"w_sshotgun"
	.align 2
.LC111:
	.string	"models/weapons/v_shotg2/tris.md2"
	.align 2
.LC110:
	.string	"models/weapons/g_shotg2/tris.md2"
	.align 2
.LC109:
	.string	"weapon_supershotgun"
	.align 2
.LC108:
	.string	"weapons/shotgf1b.wav weapons/shotgr1b.wav"
	.align 2
.LC107:
	.string	"Shotgun"
	.align 2
.LC106:
	.string	"w_shotgun"
	.align 2
.LC105:
	.string	"models/weapons/v_shotg/tris.md2"
	.align 2
.LC104:
	.string	"models/weapons/g_shotg/tris.md2"
	.align 2
.LC103:
	.string	"weapon_shotgun"
	.align 2
.LC102:
	.string	"weapons/blastf1a.wav misc/lasfly.wav"
	.align 2
.LC101:
	.string	"Blaster"
	.align 2
.LC100:
	.string	"w_blaster"
	.align 2
.LC99:
	.string	"models/weapons/v_blast/tris.md2"
	.align 2
.LC98:
	.string	"misc/w_pkup.wav"
	.align 2
.LC97:
	.string	"weapon_blaster"
	.align 2
.LC96:
	.string	"misc/power2.wav misc/power1.wav"
	.align 2
.LC95:
	.string	"Power Shield"
	.align 2
.LC94:
	.string	"i_powershield"
	.align 2
.LC93:
	.string	"models/items/armor/shield/tris.md2"
	.align 2
.LC92:
	.string	"item_power_shield"
	.align 2
.LC91:
	.string	"Power Screen"
	.align 2
.LC90:
	.string	"i_powerscreen"
	.align 2
.LC89:
	.string	"models/items/armor/screen/tris.md2"
	.align 2
.LC88:
	.string	"misc/ar3_pkup.wav"
	.align 2
.LC87:
	.string	"item_power_screen"
	.align 2
.LC86:
	.string	"Armor Shard"
	.align 2
.LC85:
	.string	"models/items/armor/shard/tris.md2"
	.align 2
.LC84:
	.string	"misc/ar2_pkup.wav"
	.align 2
.LC83:
	.string	"item_armor_shard"
	.align 2
.LC82:
	.string	"Jacket Armor"
	.align 2
.LC81:
	.string	"i_jacketarmor"
	.align 2
.LC80:
	.string	"models/items/armor/jacket/tris.md2"
	.align 2
.LC79:
	.string	"item_armor_jacket"
	.align 2
.LC78:
	.string	"Combat Armor"
	.align 2
.LC77:
	.string	"i_combatarmor"
	.align 2
.LC76:
	.string	"models/items/armor/combat/tris.md2"
	.align 2
.LC75:
	.string	"item_armor_combat"
	.align 2
.LC74:
	.string	""
	.align 2
.LC73:
	.string	"Body Armor"
	.align 2
.LC72:
	.string	"i_bodyarmor"
	.align 2
.LC71:
	.string	"models/items/armor/body/tris.md2"
	.align 2
.LC70:
	.string	"misc/ar1_pkup.wav"
	.align 2
.LC69:
	.string	"item_armor_body"
	.size	 itemlist,5092
	.align 2
.LC280:
	.string	"models/items/healing/medium/tris.md2"
	.align 2
.LC281:
	.string	"models/items/healing/stimpack/tris.md2"
	.align 2
.LC282:
	.string	"models/items/healing/large/tris.md2"
	.align 2
.LC283:
	.string	"models/items/mega_h/tris.md2"
	.section	".text"
	.align 2
	.globl SetItemNames
	.type	 SetItemNames,@function
SetItemNames:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lwz 0,1556(10)
	cmpw 0,31,0
	bc 4,0,.L485
	lis 11,itemlist@ha
	lis 9,gi@ha
	la 11,itemlist@l(11)
	la 28,gi@l(9)
	mr 29,10
	addi 30,11,40
.L487:
	lwz 9,24(28)
	addi 3,31,1056
	lwz 4,0(30)
	addi 31,31,1
	mtlr 9
	addi 30,30,76
	blrl
	lwz 0,1556(29)
	cmpw 0,31,0
	bc 12,0,.L487
.L485:
	lis 9,game@ha
	lis 11,jacket_armor_index@ha
	la 10,game@l(9)
	li 30,0
	lwz 0,1556(10)
	la 27,jacket_armor_index@l(11)
	lis 9,.LC82@ha
	lis 11,itemlist@ha
	la 28,.LC82@l(9)
	cmpw 0,30,0
	la 31,itemlist@l(11)
	bc 4,0,.L496
	mr 29,10
.L491:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L493
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L493
	mr 11,31
	b .L495
.L493:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L491
.L496:
	li 11,0
.L495:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x286b
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,51739
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,combat_armor_index@ha
	lis 10,.LC78@ha
	la 26,combat_armor_index@l(9)
	srawi 11,11,2
	la 28,.LC78@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L504
	mr 29,7
.L499:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L501
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L501
	mr 11,31
	b .L503
.L501:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L499
.L504:
	li 11,0
.L503:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x286b
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,51739
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,body_armor_index@ha
	lis 10,.LC73@ha
	la 27,body_armor_index@l(9)
	srawi 11,11,2
	la 28,.LC73@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L512
	mr 29,7
.L507:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L509
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L509
	mr 11,31
	b .L511
.L509:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L507
.L512:
	li 11,0
.L511:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x286b
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,51739
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,power_screen_index@ha
	lis 10,.LC91@ha
	la 26,power_screen_index@l(9)
	srawi 11,11,2
	la 28,.LC91@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L520
	mr 29,7
.L515:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L517
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L517
	mr 11,31
	b .L519
.L517:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L515
.L520:
	li 11,0
.L519:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x286b
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,51739
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,power_shield_index@ha
	lis 10,.LC95@ha
	la 27,power_shield_index@l(9)
	srawi 11,11,2
	la 28,.LC95@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L528
	mr 29,7
.L523:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L525
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L525
	mr 8,31
	b .L527
.L525:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L523
.L528:
	li 8,0
.L527:
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,8
	mullw 9,9,0
	srawi 9,9,2
	stw 9,0(27)
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 SetItemNames,.Lfe19-SetItemNames
	.comm	jacket_armor_index,4,4
	.comm	combat_armor_index,4,4
	.comm	body_armor_index,4,4
	.align 2
	.globl InitItems
	.type	 InitItems,@function
InitItems:
	lis 9,game+1556@ha
	li 0,66
	stw 0,game+1556@l(9)
	blr
.Lfe20:
	.size	 InitItems,.Lfe20-InitItems
	.align 2
	.globl FindItem
	.type	 FindItem,@function
FindItem:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	mr 29,3
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L19
	mr 28,9
.L21:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L20
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L20
	mr 3,31
	b .L529
.L20:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L21
.L19:
	li 3,0
.L529:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 FindItem,.Lfe21-FindItem
	.align 2
	.globl FindItemByClassname
	.type	 FindItemByClassname,@function
FindItemByClassname:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	mr 29,3
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L11
	mr 28,9
.L13:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L12
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L12
	mr 3,31
	b .L530
.L12:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L13
.L11:
	li 3,0
.L530:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 FindItemByClassname,.Lfe22-FindItemByClassname
	.align 2
	.globl SetRespawn
	.type	 SetRespawn,@function
SetRespawn:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	li 8,0
	lwz 11,264(9)
	lis 7,level+4@ha
	lis 10,DoRespawn@ha
	lwz 0,184(9)
	la 10,DoRespawn@l(10)
	lis 6,gi+72@ha
	oris 11,11,0x8000
	stw 8,248(9)
	ori 0,0,1
	stw 11,264(9)
	stw 0,184(9)
	lfs 0,level+4@l(7)
	stw 10,532(9)
	fadds 0,0,1
	stfs 0,524(9)
	lwz 0,gi+72@l(6)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 SetRespawn,.Lfe23-SetRespawn
	.align 2
	.globl ArmorIndex
	.type	 ArmorIndex,@function
ArmorIndex:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L292
	li 3,0
	blr
.L292:
	lis 9,jacket_armor_index@ha
	addi 10,11,740
	lwz 3,jacket_armor_index@l(9)
	slwi 0,3,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bclr 12,1
	lis 9,combat_armor_index@ha
	lwz 3,combat_armor_index@l(9)
	slwi 0,3,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bclr 12,1
	lis 9,body_armor_index@ha
	lwz 11,body_armor_index@l(9)
	slwi 0,11,2
	lwzx 9,10,0
	srawi 3,9,31
	subf 3,9,3
	srawi 3,3,31
	and 3,11,3
	blr
.Lfe24:
	.size	 ArmorIndex,.Lfe24-ArmorIndex
	.align 2
	.globl PowerArmorType
	.type	 PowerArmorType,@function
PowerArmorType:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L321
.L533:
	li 3,0
	blr
.L321:
	lwz 0,264(3)
	andi. 9,0,4096
	bc 12,2,.L533
	lis 9,power_shield_index@ha
	addi 11,11,740
	lwz 0,power_shield_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L323
	lis 9,power_screen_index@ha
	lwz 0,power_screen_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	srawi 3,9,31
	subf 3,9,3
	srwi 3,3,31
	blr
.L323:
	li 3,2
	blr
.Lfe25:
	.size	 PowerArmorType,.Lfe25-PowerArmorType
	.align 2
	.globl GetItemByIndex
	.type	 GetItemByIndex,@function
GetItemByIndex:
	mr. 3,3
	bc 12,2,.L8
	lis 9,game+1556@ha
	lwz 0,game+1556@l(9)
	cmpw 0,3,0
	bc 12,0,.L7
.L8:
	li 3,0
	blr
.L7:
	mulli 0,3,76
	lis 3,itemlist@ha
	la 3,itemlist@l(3)
	add 3,0,3
	blr
.Lfe26:
	.size	 GetItemByIndex,.Lfe26-GetItemByIndex
	.comm	maplist,292,4
	.comm	power_screen_index,4,4
	.comm	power_shield_index,4,4
	.section	".sbss","aw",@nobits
	.align 2
quad_drop_timeout_hack:
	.space	4
	.size	 quad_drop_timeout_hack,4
	.section	".text"
	.align 2
	.globl DoRespawn
	.type	 DoRespawn,@function
DoRespawn:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,404(31)
	cmpwi 0,0,0
	bc 12,2,.L77
	lwz 30,660(31)
	li 29,0
	mr. 31,30
	bc 12,2,.L79
.L80:
	lwz 31,632(31)
	addi 29,29,1
	cmpwi 0,31,0
	bc 4,2,.L80
.L79:
	bl rand
	mr 31,30
	divw 0,3,29
	mullw 0,0,29
	subf. 3,0,3
	bc 4,1,.L77
	mr 29,3
.L85:
	addic. 29,29,-1
	lwz 31,632(31)
	bc 4,2,.L85
.L77:
	lwz 0,184(31)
	li 29,1
	lis 9,gi+72@ha
	stw 29,248(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	stw 29,80(31)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 DoRespawn,.Lfe27-DoRespawn
	.align 2
	.globl Drop_General
	.type	 Drop_General,@function
Drop_General:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	mr 29,4
	bl Drop_Item
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(28)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 29,9,29
	addi 11,11,740
	mullw 29,29,0
	mr 3,28
	rlwinm 29,29,0,0,29
	lwzx 9,11,29
	addi 9,9,-1
	stwx 9,11,29
	bl ValidateSelectedItem
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe28:
	.size	 Drop_General,.Lfe28-Drop_General
	.section	".rodata"
	.align 2
.LC284:
	.long 0x0
	.align 3
.LC285:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Adrenaline
	.type	 Pickup_Adrenaline,@function
Pickup_Adrenaline:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC284@ha
	lis 11,deathmatch@ha
	la 9,.LC284@l(9)
	mr 12,3
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L103
	lwz 9,580(4)
	addi 9,9,1
	stw 9,580(4)
.L103:
	lwz 0,576(4)
	lwz 9,580(4)
	cmpw 0,0,9
	bc 4,0,.L104
	stw 9,576(4)
.L104:
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L105
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L105
	lis 9,.LC285@ha
	lwz 11,744(12)
	la 9,.LC285@l(9)
	lis 7,0x4330
	lwz 0,264(12)
	lfd 12,0(9)
	lis 6,level+4@ha
	lis 10,DoRespawn@ha
	lwz 9,48(11)
	oris 0,0,0x8000
	la 10,DoRespawn@l(10)
	lwz 11,184(12)
	lis 5,gi+72@ha
	mr 3,12
	xoris 9,9,0x8000
	stw 0,264(12)
	stw 9,12(1)
	ori 11,11,1
	stw 7,8(1)
	lfd 0,8(1)
	stw 11,184(12)
	stw 4,248(12)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,532(12)
	frsp 0,0
	fadds 13,13,0
	stfs 13,524(12)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L105:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 Pickup_Adrenaline,.Lfe29-Pickup_Adrenaline
	.section	".rodata"
	.align 2
.LC286:
	.long 0x0
	.align 3
.LC287:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_AncientHead
	.type	 Pickup_AncientHead,@function
Pickup_AncientHead:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,580(4)
	mr 12,3
	addi 9,9,2
	stw 9,580(4)
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L108
	lis 9,.LC286@ha
	lis 11,deathmatch@ha
	la 9,.LC286@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L108
	lis 9,.LC287@ha
	lwz 11,744(12)
	la 9,.LC287@l(9)
	lis 7,0x4330
	lwz 0,264(12)
	lfd 12,0(9)
	lis 6,level+4@ha
	lis 10,DoRespawn@ha
	lwz 9,48(11)
	oris 0,0,0x8000
	la 10,DoRespawn@l(10)
	lwz 11,184(12)
	lis 5,gi+72@ha
	xoris 9,9,0x8000
	stw 0,264(12)
	stw 9,12(1)
	ori 11,11,1
	stw 7,8(1)
	lfd 0,8(1)
	stw 11,184(12)
	stw 4,248(12)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,532(12)
	frsp 0,0
	fadds 13,13,0
	stfs 13,524(12)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L108:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 Pickup_AncientHead,.Lfe30-Pickup_AncientHead
	.section	".rodata"
	.align 3
.LC288:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC289:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl Use_Breather
	.type	 Use_Breather,@function
Use_Breather:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	mr 29,3
	subf 4,9,4
	ori 0,0,51739
	lwz 11,84(29)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC288@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC288@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3716(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L213
	lis 9,.LC289@ha
	la 9,.LC289@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L535
.L213:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L535:
	stfs 0,3716(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe31:
	.size	 Use_Breather,.Lfe31-Use_Breather
	.section	".rodata"
	.align 3
.LC290:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC291:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl Use_Envirosuit
	.type	 Use_Envirosuit,@function
Use_Envirosuit:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	mr 29,3
	subf 4,9,4
	ori 0,0,51739
	lwz 11,84(29)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC290@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC290@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3720(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L216
	lis 9,.LC291@ha
	la 9,.LC291@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L536
.L216:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L536:
	stfs 0,3720(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe32:
	.size	 Use_Envirosuit,.Lfe32-Use_Envirosuit
	.align 2
	.globl Use_Silencer
	.type	 Use_Silencer,@function
Use_Silencer:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	mr 29,3
	subf 4,9,4
	ori 0,0,51739
	lwz 11,84(29)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lwz 11,84(29)
	lwz 9,3732(11)
	addi 9,9,30
	stw 9,3732(11)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 Use_Silencer,.Lfe33-Use_Silencer
	.align 2
	.globl Drop_Ammo
	.type	 Drop_Ammo,@function
Drop_Ammo:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	mr 30,4
	la 9,itemlist@l(9)
	lis 0,0x286b
	ori 0,0,51739
	subf 9,9,30
	mullw 9,9,0
	mr 31,3
	srawi 28,9,2
	bl Drop_Item
	lwz 9,84(31)
	slwi 0,28,2
	mr 29,3
	lwz 11,48(30)
	addi 9,9,740
	lwzx 0,9,0
	cmpw 0,0,11
	bc 12,0,.L273
	stw 11,628(29)
	b .L274
.L273:
	stw 0,628(29)
.L274:
	lwz 9,84(31)
	slwi 11,28,2
	lwz 8,628(29)
	mr 10,9
	lwz 9,1788(9)
	cmpwi 0,9,0
	bc 12,2,.L275
	lwz 0,68(9)
	cmpwi 0,0,3
	bc 4,2,.L275
	lwz 0,68(30)
	cmpwi 0,0,3
	bc 4,2,.L275
	addi 9,10,740
	lwzx 0,9,11
	subf. 9,8,0
	bc 12,1,.L275
	lis 9,gi+8@ha
	lis 5,.LC30@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC30@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,29
	bl G_FreeEdict
	b .L272
.L275:
	addi 9,10,740
	mr 3,31
	lwzx 0,9,11
	subf 0,8,0
	stwx 0,9,11
	bl ValidateSelectedItem
.L272:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 Drop_Ammo,.Lfe34-Drop_Ammo
	.section	".rodata"
	.align 2
.LC292:
	.long 0x3f800000
	.align 2
.LC293:
	.long 0x0
	.align 2
.LC294:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl MegaHealth_think
	.type	 MegaHealth_think,@function
MegaHealth_think:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 7,3
	lwz 11,256(7)
	lwz 9,576(11)
	lwz 0,580(11)
	cmpw 0,9,0
	bc 4,1,.L277
	lis 10,.LC292@ha
	lis 9,level+4@ha
	la 10,.LC292@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,524(7)
	lwz 9,576(11)
	addi 9,9,-1
	stw 9,576(11)
	b .L276
.L277:
	lwz 0,284(7)
	andis. 6,0,0x1
	bc 4,2,.L278
	lis 9,.LC293@ha
	lis 11,deathmatch@ha
	la 9,.LC293@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L278
	lwz 9,264(7)
	lis 11,.LC294@ha
	lis 10,level+4@ha
	lwz 0,184(7)
	la 11,.LC294@l(11)
	lis 8,gi+72@ha
	oris 9,9,0x8000
	stw 6,248(7)
	mr 3,7
	ori 0,0,1
	stw 9,264(7)
	stw 0,184(7)
	lfs 0,level+4@l(10)
	lfs 13,0(11)
	lis 11,DoRespawn@ha
	la 11,DoRespawn@l(11)
	fadds 0,0,13
	stw 11,532(7)
	stfs 0,524(7)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	b .L276
.L278:
	mr 3,7
	bl G_FreeEdict
.L276:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe35:
	.size	 MegaHealth_think,.Lfe35-MegaHealth_think
	.align 2
	.globl Drop_PowerArmor
	.type	 Drop_PowerArmor,@function
Drop_PowerArmor:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 0,264(31)
	andi. 9,0,4096
	bc 12,2,.L344
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,30
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,1
	bc 4,2,.L344
	bl Use_PowerArmor
.L344:
	mr 3,31
	mr 4,30
	bl Drop_Item
	lis 11,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 11,11,30
	addi 10,10,740
	mullw 11,11,0
	mr 3,31
	rlwinm 11,11,0,0,29
	lwzx 9,10,11
	addi 9,9,-1
	stwx 9,10,11
	bl ValidateSelectedItem
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe36:
	.size	 Drop_PowerArmor,.Lfe36-Drop_PowerArmor
	.align 2
	.type	 drop_temp_touch,@function
drop_temp_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,256(3)
	cmpw 0,4,0
	bc 12,2,.L369
	bl Touch_Item
.L369:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 drop_temp_touch,.Lfe37-drop_temp_touch
	.section	".rodata"
	.align 2
.LC295:
	.long 0x0
	.align 2
.LC296:
	.long 0x41e80000
	.section	".text"
	.align 2
	.type	 drop_make_touchable,@function
drop_make_touchable:
	lis 9,Touch_Item@ha
	lis 11,deathmatch@ha
	la 9,Touch_Item@l(9)
	lwz 10,deathmatch@l(11)
	stw 9,540(3)
	lis 9,.LC295@ha
	lfs 0,20(10)
	la 9,.LC295@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bclr 12,2
	lis 9,.LC296@ha
	lis 11,level+4@ha
	la 9,.LC296@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,532(3)
	stfs 0,524(3)
	blr
.Lfe38:
	.size	 drop_make_touchable,.Lfe38-drop_make_touchable
	.align 2
	.globl Use_Item
	.type	 Use_Item,@function
Use_Item:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,284(3)
	li 11,0
	lwz 0,184(3)
	andi. 10,9,2
	stw 11,544(3)
	rlwinm 0,0,0,0,30
	stw 0,184(3)
	bc 12,2,.L378
	li 0,2
	stw 11,540(3)
	stw 0,248(3)
	b .L379
.L378:
	lis 9,Touch_Item@ha
	li 0,1
	la 9,Touch_Item@l(9)
	stw 0,248(3)
	stw 9,540(3)
.L379:
	lis 9,gi+72@ha
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe39:
	.size	 Use_Item,.Lfe39-Use_Item
	.section	".rodata"
	.align 2
.LC297:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_item_health
	.type	 SP_item_health,@function
SP_item_health:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 11,.LC297@ha
	lis 9,deathmatch@ha
	la 11,.LC297@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L443
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L443
	bl G_FreeEdict
	b .L442
.L537:
	mr 4,31
	b .L450
.L443:
	lis 9,.LC280@ha
	li 0,10
	la 9,.LC280@l(9)
	lis 11,game@ha
	stw 0,628(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC278@ha
	lis 11,itemlist@ha
	la 27,.LC278@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L451
	mr 28,10
.L446:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L448
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L537
.L448:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L446
.L451:
	li 4,0
.L450:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC46@ha
	lwz 0,gi+36@l(9)
	la 3,.LC46@l(3)
	mtlr 0
	blrl
.L442:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe40:
	.size	 SP_item_health,.Lfe40-SP_item_health
	.section	".rodata"
	.align 2
.LC298:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_item_health_small
	.type	 SP_item_health_small,@function
SP_item_health_small:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 11,.LC298@ha
	lis 9,deathmatch@ha
	la 11,.LC298@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L453
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L453
	bl G_FreeEdict
	b .L452
.L538:
	mr 4,31
	b .L460
.L453:
	lis 9,.LC281@ha
	li 0,2
	la 9,.LC281@l(9)
	lis 11,game@ha
	stw 0,628(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC278@ha
	lis 11,itemlist@ha
	la 27,.LC278@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L461
	mr 28,10
.L456:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L458
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L538
.L458:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L456
.L461:
	li 4,0
.L460:
	mr 3,29
	bl SpawnItem
	li 0,1
	lis 9,gi+36@ha
	stw 0,740(29)
	lis 3,.LC45@ha
	lwz 0,gi+36@l(9)
	la 3,.LC45@l(3)
	mtlr 0
	blrl
.L452:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe41:
	.size	 SP_item_health_small,.Lfe41-SP_item_health_small
	.section	".rodata"
	.align 2
.LC299:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_item_health_large
	.type	 SP_item_health_large,@function
SP_item_health_large:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 11,.LC299@ha
	lis 9,deathmatch@ha
	la 11,.LC299@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L463
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L463
	bl G_FreeEdict
	b .L462
.L539:
	mr 4,31
	b .L470
.L463:
	lis 9,.LC282@ha
	li 0,25
	la 9,.LC282@l(9)
	lis 11,game@ha
	stw 0,628(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC278@ha
	lis 11,itemlist@ha
	la 27,.LC278@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L471
	mr 28,10
.L466:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L468
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L539
.L468:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L466
.L471:
	li 4,0
.L470:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC47@ha
	lwz 0,gi+36@l(9)
	la 3,.LC47@l(3)
	mtlr 0
	blrl
.L462:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe42:
	.size	 SP_item_health_large,.Lfe42-SP_item_health_large
	.section	".rodata"
	.align 2
.LC300:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_item_health_mega
	.type	 SP_item_health_mega,@function
SP_item_health_mega:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 11,.LC300@ha
	lis 9,deathmatch@ha
	la 11,.LC300@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L473
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L473
	bl G_FreeEdict
	b .L472
.L540:
	mr 4,31
	b .L480
.L473:
	lis 9,.LC283@ha
	li 0,100
	la 9,.LC283@l(9)
	lis 11,game@ha
	stw 0,628(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC278@ha
	lis 11,itemlist@ha
	la 27,.LC278@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L481
	mr 28,10
.L476:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L478
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L540
.L478:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L476
.L481:
	li 4,0
.L480:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC48@ha
	lwz 0,gi+36@l(9)
	la 3,.LC48@l(3)
	mtlr 0
	blrl
	li 0,3
	stw 0,740(29)
.L472:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe43:
	.size	 SP_item_health_mega,.Lfe43-SP_item_health_mega
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
