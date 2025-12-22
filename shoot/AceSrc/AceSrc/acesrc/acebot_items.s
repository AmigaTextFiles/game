	.file	"acebot_items.c"
gcc2_compiled.:
	.globl num_players
	.section	".sdata","aw"
	.align 2
	.type	 num_players,@object
	.size	 num_players,4
num_players:
	.long 0
	.globl num_items
	.align 2
	.type	 num_items,@object
	.size	 num_items,4
num_items:
	.long 0
	.section	".rodata"
	.align 2
.LC0:
	.string	"Jacket Armor"
	.align 2
.LC1:
	.string	"Combat Armor"
	.align 3
.LC2:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ACEIT_CanUseArmor
	.type	 ACEIT_CanUseArmor,@function
ACEIT_CanUseArmor:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 29,3
	mr 27,4
	lwz 28,64(29)
	mr 3,27
	bl ArmorIndex
	lwz 0,68(29)
	mr 31,3
	cmpwi 0,0,4
	li 3,1
	bc 12,2,.L41
	lis 3,.LC0@ha
	lis 29,0x286b
	la 3,.LC0@l(3)
	ori 29,29,51739
	bl FindItem
	lis 9,itemlist@ha
	la 30,itemlist@l(9)
	subf 3,30,3
	mullw 3,3,29
	srawi 3,3,2
	cmpw 0,31,3
	bc 4,2,.L34
	lis 9,jacketarmor_info@ha
	la 8,jacketarmor_info@l(9)
	b .L35
.L34:
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	bl FindItem
	subf 3,30,3
	mullw 3,3,29
	srawi 3,3,2
	cmpw 0,31,3
	bc 4,2,.L36
	lis 9,combatarmor_info@ha
	la 8,combatarmor_info@l(9)
	b .L35
.L36:
	lis 9,bodyarmor_info@ha
	la 8,bodyarmor_info@l(9)
.L35:
	lfs 0,8(28)
	lfs 13,8(8)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L38
	fdivs 13,0,13
	lwz 0,0(28)
	lis 6,0x4330
	lis 9,.LC2@ha
	lwz 11,84(27)
	slwi 7,31,2
	xoris 0,0,0x8000
	la 9,.LC2@l(9)
	lwz 8,4(8)
	stw 0,20(1)
	addi 11,11,740
	li 3,0
	stw 6,16(1)
	lfd 11,0(9)
	lfd 0,16(1)
	mr 9,10
	lwzx 6,11,7
	fsub 0,0,11
	frsp 0,0
	fmuls 13,13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 9,20(1)
	add 9,6,9
	cmpw 7,9,8
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 8,8,0
	and 9,9,0
	or 9,9,8
	cmpw 0,6,9
	bc 4,0,.L41
.L38:
	li 3,1
.L41:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 ACEIT_CanUseArmor,.Lfe1-ACEIT_CanUseArmor
	.section	".rodata"
	.align 2
.LC7:
	.string	"Body Armor"
	.align 2
.LC3:
	.long 0x3f19999a
	.align 2
.LC4:
	.long 0x3f333333
	.align 2
.LC5:
	.long 0x3ecccccd
	.align 2
.LC6:
	.long 0x3e99999a
	.align 2
.LC8:
	.long 0x0
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC10:
	.long 0x42c80000
	.align 3
.LC11:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC12:
	.long 0x3fc00000
	.align 2
.LC13:
	.long 0x3f000000
	.align 2
.LC14:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl ACEIT_ItemNeed
	.type	 ACEIT_ItemNeed,@function
ACEIT_ItemNeed:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	cmplwi 0,4,100
	mr 31,3
	bc 12,1,.L107
	addi 10,4,-1
	cmplwi 0,10,53
	bc 12,1,.L109
	lis 11,.L110@ha
	slwi 10,10,2
	la 11,.L110@l(11)
	lis 9,.L110@ha
	lwzx 0,10,11
	la 9,.L110@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L110:
	.long .L86-.L110
	.long .L89-.L110
	.long .L92-.L110
	.long .L109-.L110
	.long .L96-.L110
	.long .L96-.L110
	.long .L109-.L110
	.long .L109-.L110
	.long .L65-.L110
	.long .L65-.L110
	.long .L65-.L110
	.long .L65-.L110
	.long .L83-.L110
	.long .L65-.L110
	.long .L65-.L110
	.long .L65-.L110
	.long .L65-.L110
	.long .L65-.L110
	.long .L74-.L110
	.long .L71-.L110
	.long .L77-.L110
	.long .L80-.L110
	.long .L68-.L110
	.long .L112-.L110
	.long .L112-.L110
	.long .L112-.L110
	.long .L109-.L110
	.long .L109-.L110
	.long .L109-.L110
	.long .L112-.L110
	.long .L112-.L110
	.long .L112-.L110
	.long .L109-.L110
	.long .L109-.L110
	.long .L109-.L110
	.long .L109-.L110
	.long .L109-.L110
	.long .L109-.L110
	.long .L109-.L110
	.long .L109-.L110
	.long .L109-.L110
	.long .L109-.L110
	.long .L97-.L110
	.long .L100-.L110
	.long .L106-.L110
	.long .L106-.L110
	.long .L106-.L110
	.long .L106-.L110
	.long .L48-.L110
	.long .L48-.L110
	.long .L48-.L110
	.long .L109-.L110
	.long .L109-.L110
	.long .L48-.L110
.L48:
	lwz 0,480(31)
	cmpwi 0,0,99
	bc 12,1,.L101
	xoris 0,0,0x8000
	lis 11,0x4330
	stw 0,20(1)
	lis 10,.LC9@ha
	la 10,.LC9@l(10)
	stw 11,16(1)
	lfd 13,0(10)
	lis 11,.LC10@ha
	lfd 0,16(1)
	la 11,.LC10@l(11)
	lis 10,.LC11@ha
	lfs 12,0(11)
	la 10,.LC11@l(10)
	lfd 1,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fsub 1,1,13
	frsp 1,1
	b .L111
.L65:
	lwz 9,84(31)
	slwi 11,4,2
	addi 9,9,740
	lwzx 0,9,11
	cmpwi 0,0,0
	bc 4,2,.L107
	lis 9,.LC4@ha
	lfs 1,.LC4@l(9)
	b .L111
.L68:
	lwz 9,84(31)
	lwz 11,1784(9)
	lwz 0,832(9)
	cmpw 0,0,11
	bc 12,0,.L113
	b .L109
.L71:
	lwz 9,84(31)
	lwz 11,1764(9)
	lwz 0,820(9)
	cmpw 0,0,11
	bc 12,0,.L114
	b .L101
.L74:
	lwz 9,84(31)
	lwz 11,1768(9)
	lwz 0,816(9)
	cmpw 0,0,11
	bc 12,0,.L114
	b .L107
.L77:
	lwz 9,84(31)
	lwz 11,1780(9)
	lwz 0,824(9)
	cmpw 0,0,11
	bc 12,0,.L114
	b .L109
.L80:
	lis 11,.LC12@ha
	lwz 9,84(31)
	la 11,.LC12@l(11)
	lfs 1,0(11)
	lwz 11,1772(9)
	lwz 0,828(9)
	cmpw 0,0,11
	bc 12,0,.L111
	b .L107
.L83:
	lwz 9,84(31)
	lwz 11,1776(9)
	lwz 0,792(9)
	cmpw 0,0,11
	bc 4,0,.L109
.L114:
	lis 9,.LC6@ha
	lfs 1,.LC6@l(9)
	b .L111
.L86:
	lis 3,.LC7@ha
	la 3,.LC7@l(3)
.L116:
	bl FindItem
	mr 4,31
	bl ACEIT_CanUseArmor
	cmpwi 0,3,0
	bc 4,2,.L112
	b .L107
.L89:
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	b .L116
.L92:
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	bl FindItem
	mr 4,31
	bl ACEIT_CanUseArmor
	cmpwi 0,3,0
	bc 12,2,.L107
.L112:
	lis 9,.LC3@ha
	lfs 1,.LC3@l(9)
	b .L111
.L96:
	lis 10,.LC13@ha
	la 10,.LC13@l(10)
	b .L115
.L97:
	lwz 3,84(31)
	slwi 0,4,2
	addi 9,3,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,2,.L107
	lwz 0,3452(3)
	lis 11,.LC14@ha
	la 11,.LC14@l(11)
	cmpwi 0,0,2
	lfs 1,0(11)
	bc 12,2,.L111
	b .L107
.L100:
	lwz 3,84(31)
	slwi 0,4,2
	addi 9,3,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,2,.L101
	lwz 0,3452(3)
	lis 10,.LC14@ha
	la 10,.LC14@l(10)
	cmpwi 0,0,1
	lfs 1,0(10)
	bc 12,2,.L111
.L101:
	lis 11,.LC8@ha
	la 11,.LC8@l(11)
	lfs 1,0(11)
	b .L111
.L106:
	lwz 3,84(31)
	lwz 0,920(3)
	cmpwi 0,0,0
	bc 4,2,.L107
	lwz 0,924(3)
	cmpwi 0,0,0
	bc 4,2,.L107
	lwz 0,928(3)
	cmpwi 0,0,0
	bc 4,2,.L107
	lwz 0,932(3)
	cmpwi 0,0,0
	bc 4,2,.L107
.L113:
	lis 9,.LC5@ha
	lfs 1,.LC5@l(9)
	b .L111
.L107:
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfs 1,0(9)
	b .L111
.L109:
	lis 10,.LC8@ha
	la 10,.LC8@l(10)
.L115:
	lfs 1,0(10)
.L111:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 ACEIT_ItemNeed,.Lfe2-ACEIT_ItemNeed
	.section	".rodata"
	.align 2
.LC15:
	.string	"item_armor_body"
	.align 2
.LC16:
	.string	"item_armor_combat"
	.align 2
.LC17:
	.string	"item_armor_jacket"
	.align 2
.LC18:
	.string	"item_armor_shard"
	.align 2
.LC19:
	.string	"item_power_screen"
	.align 2
.LC20:
	.string	"item_power_shield"
	.align 2
.LC21:
	.string	"weapon_grapple"
	.align 2
.LC22:
	.string	"weapon_blaster"
	.align 2
.LC23:
	.string	"weapon_shotgun"
	.align 2
.LC24:
	.string	"weapon_supershotgun"
	.align 2
.LC25:
	.string	"weapon_machinegun"
	.align 2
.LC26:
	.string	"weapon_chaingun"
	.align 2
.LC27:
	.string	"ammo_grenades"
	.align 2
.LC28:
	.string	"weapon_grenadelauncher"
	.align 2
.LC29:
	.string	"weapon_rocketlauncher"
	.align 2
.LC30:
	.string	"weapon_hyperblaster"
	.align 2
.LC31:
	.string	"weapon_railgun"
	.align 2
.LC32:
	.string	"weapon_bfg10k"
	.align 2
.LC33:
	.string	"ammo_shells"
	.align 2
.LC34:
	.string	"ammo_bullets"
	.align 2
.LC35:
	.string	"ammo_cells"
	.align 2
.LC36:
	.string	"ammo_rockets"
	.align 2
.LC37:
	.string	"ammo_slugs"
	.align 2
.LC38:
	.string	"item_quad"
	.align 2
.LC39:
	.string	"item_invunerability"
	.align 2
.LC40:
	.string	"item_silencer"
	.align 2
.LC41:
	.string	"item_rebreather"
	.align 2
.LC42:
	.string	"item_enviornmentsuit"
	.align 2
.LC43:
	.string	"item_ancienthead"
	.align 2
.LC44:
	.string	"item_adrenaline"
	.align 2
.LC45:
	.string	"item_bandolier"
	.align 2
.LC46:
	.string	"item_pack"
	.align 2
.LC47:
	.string	"item_datacd"
	.align 2
.LC48:
	.string	"item_powercube"
	.align 2
.LC49:
	.string	"item_pyramidkey"
	.align 2
.LC50:
	.string	"item_dataspinner"
	.align 2
.LC51:
	.string	"item_securitypass"
	.align 2
.LC52:
	.string	"item_bluekey"
	.align 2
.LC53:
	.string	"item_redkey"
	.align 2
.LC54:
	.string	"item_commandershead"
	.align 2
.LC55:
	.string	"item_airstrikemarker"
	.align 2
.LC56:
	.string	"item_health"
	.align 2
.LC57:
	.string	"item_flag_team1"
	.align 2
.LC58:
	.string	"item_flag_team2"
	.align 2
.LC59:
	.string	"item_tech1"
	.align 2
.LC60:
	.string	"item_tech2"
	.align 2
.LC61:
	.string	"item_tech3"
	.align 2
.LC62:
	.string	"item_tech4"
	.align 2
.LC63:
	.string	"item_health_small"
	.align 2
.LC64:
	.string	"item_health_medium"
	.align 2
.LC65:
	.string	"item_health_large"
	.align 2
.LC66:
	.string	"item_health_mega"
	.section	".text"
	.align 2
	.globl ACEIT_ClassnameToIndex
	.type	 ACEIT_ClassnameToIndex,@function
ACEIT_ClassnameToIndex:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 4,.LC15@ha
	la 4,.LC15@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,1
	bc 12,2,.L171
	lis 4,.LC16@ha
	mr 3,31
	la 4,.LC16@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,2
	bc 12,2,.L171
	lis 4,.LC17@ha
	mr 3,31
	la 4,.LC17@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,3
	bc 12,2,.L171
	lis 4,.LC18@ha
	mr 3,31
	la 4,.LC18@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,4
	bc 12,2,.L171
	lis 4,.LC19@ha
	mr 3,31
	la 4,.LC19@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,5
	bc 12,2,.L171
	lis 4,.LC20@ha
	mr 3,31
	la 4,.LC20@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,6
	bc 12,2,.L171
	lis 4,.LC21@ha
	mr 3,31
	la 4,.LC21@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,7
	bc 12,2,.L171
	lis 4,.LC22@ha
	mr 3,31
	la 4,.LC22@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,8
	bc 12,2,.L171
	lis 4,.LC23@ha
	mr 3,31
	la 4,.LC23@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,9
	bc 12,2,.L171
	lis 4,.LC24@ha
	mr 3,31
	la 4,.LC24@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,10
	bc 12,2,.L171
	lis 4,.LC25@ha
	mr 3,31
	la 4,.LC25@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,11
	bc 12,2,.L171
	lis 30,.LC26@ha
	mr 3,31
	la 4,.LC26@l(30)
	bl strcmp
	cmpwi 0,3,0
	li 3,12
	bc 12,2,.L171
	la 4,.LC26@l(30)
	mr 3,31
	bl strcmp
	cmpwi 0,3,0
	li 3,12
	bc 12,2,.L171
	lis 4,.LC27@ha
	mr 3,31
	la 4,.LC27@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,13
	bc 12,2,.L171
	lis 4,.LC28@ha
	mr 3,31
	la 4,.LC28@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,14
	bc 12,2,.L171
	lis 4,.LC29@ha
	mr 3,31
	la 4,.LC29@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,15
	bc 12,2,.L171
	lis 4,.LC30@ha
	mr 3,31
	la 4,.LC30@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,16
	bc 12,2,.L171
	lis 4,.LC31@ha
	mr 3,31
	la 4,.LC31@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,17
	bc 12,2,.L171
	lis 4,.LC32@ha
	mr 3,31
	la 4,.LC32@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,18
	bc 12,2,.L171
	lis 4,.LC33@ha
	mr 3,31
	la 4,.LC33@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,19
	bc 12,2,.L171
	lis 4,.LC34@ha
	mr 3,31
	la 4,.LC34@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,20
	bc 12,2,.L171
	lis 4,.LC35@ha
	mr 3,31
	la 4,.LC35@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,21
	bc 12,2,.L171
	lis 4,.LC36@ha
	mr 3,31
	la 4,.LC36@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,22
	bc 12,2,.L171
	lis 4,.LC37@ha
	mr 3,31
	la 4,.LC37@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,23
	bc 12,2,.L171
	lis 4,.LC38@ha
	mr 3,31
	la 4,.LC38@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,24
	bc 12,2,.L171
	lis 4,.LC39@ha
	mr 3,31
	la 4,.LC39@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,25
	bc 12,2,.L171
	lis 4,.LC40@ha
	mr 3,31
	la 4,.LC40@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,26
	bc 12,2,.L171
	lis 4,.LC41@ha
	mr 3,31
	la 4,.LC41@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,27
	bc 12,2,.L171
	lis 4,.LC42@ha
	mr 3,31
	la 4,.LC42@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,28
	bc 12,2,.L171
	lis 4,.LC43@ha
	mr 3,31
	la 4,.LC43@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,29
	bc 12,2,.L171
	lis 4,.LC44@ha
	mr 3,31
	la 4,.LC44@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,30
	bc 12,2,.L171
	lis 4,.LC45@ha
	mr 3,31
	la 4,.LC45@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,31
	bc 12,2,.L171
	lis 4,.LC46@ha
	mr 3,31
	la 4,.LC46@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,32
	bc 12,2,.L171
	lis 4,.LC47@ha
	mr 3,31
	la 4,.LC47@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,33
	bc 12,2,.L171
	lis 4,.LC48@ha
	mr 3,31
	la 4,.LC48@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,34
	bc 12,2,.L171
	lis 4,.LC49@ha
	mr 3,31
	la 4,.LC49@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,35
	bc 12,2,.L171
	lis 4,.LC50@ha
	mr 3,31
	la 4,.LC50@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,36
	bc 12,2,.L171
	lis 4,.LC51@ha
	mr 3,31
	la 4,.LC51@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,37
	bc 12,2,.L171
	lis 4,.LC52@ha
	mr 3,31
	la 4,.LC52@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,38
	bc 12,2,.L171
	lis 4,.LC53@ha
	mr 3,31
	la 4,.LC53@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,39
	bc 12,2,.L171
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,40
	bc 12,2,.L171
	lis 4,.LC55@ha
	mr 3,31
	la 4,.LC55@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,41
	bc 12,2,.L171
	lis 4,.LC56@ha
	mr 3,31
	la 4,.LC56@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,42
	bc 12,2,.L171
	lis 4,.LC57@ha
	mr 3,31
	la 4,.LC57@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,43
	bc 12,2,.L171
	lis 4,.LC58@ha
	mr 3,31
	la 4,.LC58@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,44
	bc 12,2,.L171
	lis 4,.LC59@ha
	mr 3,31
	la 4,.LC59@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,45
	bc 12,2,.L171
	lis 4,.LC60@ha
	mr 3,31
	la 4,.LC60@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,46
	bc 12,2,.L171
	lis 4,.LC61@ha
	mr 3,31
	la 4,.LC61@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,47
	bc 12,2,.L171
	lis 4,.LC62@ha
	mr 3,31
	la 4,.LC62@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,48
	bc 12,2,.L171
	lis 4,.LC63@ha
	mr 3,31
	la 4,.LC63@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,49
	bc 12,2,.L171
	lis 4,.LC64@ha
	mr 3,31
	la 4,.LC64@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,50
	bc 12,2,.L171
	lis 4,.LC65@ha
	mr 3,31
	la 4,.LC65@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,51
	bc 12,2,.L171
	lis 4,.LC66@ha
	mr 3,31
	la 4,.LC66@l(4)
	bl strcmp
	srawi 0,3,31
	xor 3,0,3
	subf 3,3,0
	srawi 3,3,31
	ori 3,3,54
.L171:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 ACEIT_ClassnameToIndex,.Lfe3-ACEIT_ClassnameToIndex
	.section	".rodata"
	.align 2
.LC67:
	.string	"func_plat"
	.align 2
.LC68:
	.string	"misc_teleporter_dest"
	.align 2
.LC69:
	.string	"misc_teleporter"
	.align 2
.LC70:
	.long 0x41800000
	.align 2
.LC71:
	.long 0x42000000
	.align 2
.LC72:
	.long 0x3f000000
	.align 2
.LC73:
	.long 0x42800000
	.section	".text"
	.align 2
	.globl ACEIT_BuildItemNodeTable
	.type	 ACEIT_BuildItemNodeTable,@function
ACEIT_BuildItemNodeTable:
	stwu 1,-96(1)
	mflr 0
	mfcr 12
	stmw 24,64(1)
	stw 0,100(1)
	stw 12,60(1)
	lis 9,globals+72@ha
	lis 11,g_edicts@ha
	lwz 0,globals+72@l(9)
	lis 10,num_items@ha
	lis 27,num_items@ha
	lwz 31,g_edicts@l(11)
	li 9,0
	lis 24,g_edicts@ha
	mulli 0,0,952
	stw 9,num_items@l(10)
	lis 25,globals@ha
	add 0,31,0
	cmplw 0,31,0
	bc 4,0,.L174
	cmpwi 4,3,0
	lis 26,numnodes@ha
.L176:
	lwz 0,248(31)
	addi 28,31,952
	cmpwi 0,0,0
	bc 12,2,.L175
	lwz 3,280(31)
	cmpwi 0,3,0
	bc 12,2,.L175
	bl ACEIT_ClassnameToIndex
	mr 30,3
	lis 4,.LC67@ha
	lwz 3,280(31)
	la 4,.LC67@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L179
	bc 4,18,.L180
	mr 3,31
	li 4,2
	bl ACEND_AddNode
.L180:
	li 30,99
.L179:
	lwz 3,280(31)
	lis 4,.LC68@ha
	la 4,.LC68@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L182
	lwz 3,280(31)
	lis 4,.LC69@ha
	la 4,.LC69@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L181
.L182:
	bc 4,18,.L183
	mr 3,31
	li 4,3
	bl ACEND_AddNode
.L183:
	li 30,99
.L181:
	cmpwi 0,30,-1
	addi 28,31,952
	bc 12,2,.L175
	lwz 0,num_items@l(27)
	lis 9,item_table@ha
	la 29,item_table@l(9)
	slwi 0,0,4
	addi 9,29,8
	stwx 30,29,0
	stwx 31,9,0
	bc 4,18,.L185
	mr 3,31
	li 4,4
	bl ACEND_AddNode
	lwz 9,num_items@l(27)
	addi 11,29,12
	addi 0,9,1
	slwi 9,9,4
	stwx 3,11,9
	stw 0,num_items@l(27)
	b .L175
.L185:
	lwz 0,numnodes@l(26)
	li 6,0
	cmpw 0,6,0
	bc 4,0,.L175
	lis 9,nodes@ha
	lis 3,.LC70@ha
	la 8,nodes@l(9)
	la 3,.LC70@l(3)
	lis 9,.LC71@ha
	lfs 6,0(3)
	lis 4,num_items@ha
	la 9,.LC71@l(9)
	lis 3,.LC72@ha
	lwz 7,num_items@l(4)
	lfs 7,0(9)
	la 3,.LC72@l(3)
	addi 11,29,12
	lis 9,.LC73@ha
	lfs 9,0(3)
	mr 5,0
	la 9,.LC73@l(9)
	lfs 8,0(9)
.L190:
	lwz 10,12(8)
	cmpwi 7,10,4
	xori 9,10,2
	subfic 0,9,0
	adde 9,0,9
	mfcr 0
	rlwinm 0,0,31,1
	or. 3,0,9
	bc 4,2,.L192
	cmpwi 0,10,3
	bc 4,2,.L189
.L192:
	lfs 0,4(31)
	stfs 0,8(1)
	lfs 13,8(31)
	stfs 13,12(1)
	lfs 0,12(31)
	stfs 0,16(1)
	bc 4,30,.L193
	fadds 0,0,6
	stfs 0,16(1)
.L193:
	lwz 0,12(8)
	cmpwi 0,0,3
	bc 4,2,.L194
	lfs 0,16(1)
	fadds 0,0,7
	stfs 0,16(1)
.L194:
	lwz 0,12(8)
	cmpwi 0,0,2
	bc 4,2,.L195
	lfs 10,200(31)
	stfs 10,24(1)
	lfs 11,204(31)
	stfs 11,28(1)
	lfs 0,208(31)
	stfs 0,32(1)
	lfs 13,188(31)
	stfs 13,40(1)
	fsubs 10,10,13
	lfs 0,192(31)
	fmadds 10,10,9,13
	fsubs 11,11,0
	stfs 0,44(1)
	lfs 12,196(31)
	stfs 10,8(1)
	fmadds 11,11,9,0
	stfs 12,48(1)
	stfs 11,12(1)
	lfs 0,196(31)
	fadds 0,0,8
	stfs 0,16(1)
.L195:
	lfs 13,8(1)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,2,.L189
	lfs 13,12(1)
	lfs 0,4(8)
	fcmpu 0,13,0
	bc 4,2,.L189
	lfs 13,16(1)
	lfs 0,8(8)
	fcmpu 0,13,0
	bc 4,2,.L189
	slwi 0,7,4
	stwx 6,11,0
	addi 7,7,1
.L189:
	addi 6,6,1
	addi 8,8,16
	cmpw 0,6,5
	bc 12,0,.L190
	stw 7,num_items@l(4)
.L175:
	la 11,globals@l(25)
	lwz 9,g_edicts@l(24)
	mr 31,28
	lwz 0,72(11)
	mulli 0,0,952
	add 9,9,0
	cmplw 0,31,9
	bc 12,0,.L176
.L174:
	lwz 0,100(1)
	lwz 12,60(1)
	mtlr 0
	lmw 24,64(1)
	mtcrf 8,12
	la 1,96(1)
	blr
.Lfe4:
	.size	 ACEIT_BuildItemNodeTable,.Lfe4-ACEIT_BuildItemNodeTable
	.comm	players,1024,4
	.comm	item_table,16384,4
	.align 2
	.globl ACEIT_PlayerAdded
	.type	 ACEIT_PlayerAdded,@function
ACEIT_PlayerAdded:
	lis 10,num_players@ha
	lis 11,players@ha
	lwz 9,num_players@l(10)
	la 11,players@l(11)
	slwi 0,9,2
	addi 9,9,1
	stwx 3,11,0
	stw 9,num_players@l(10)
	blr
.Lfe5:
	.size	 ACEIT_PlayerAdded,.Lfe5-ACEIT_PlayerAdded
	.align 2
	.globl ACEIT_PlayerRemoved
	.type	 ACEIT_PlayerRemoved,@function
ACEIT_PlayerRemoved:
	lis 9,num_players@ha
	lwz 0,num_players@l(9)
	cmpwi 0,0,0
	bclr 12,2
	cmpwi 0,0,1
	bc 4,2,.L9
	li 0,0
	stw 0,num_players@l(9)
	blr
.L9:
	li 10,0
	cmpw 0,10,0
	bc 4,0,.L11
	lis 9,players@ha
	mr 7,0
	la 11,players@l(9)
.L13:
	lwz 0,0(11)
	addi 11,11,4
	xor 0,3,0
	srawi 6,0,31
	xor 9,6,0
	subf 9,9,6
	srawi 9,9,31
	andc 0,10,9
	addi 10,10,1
	and 9,8,9
	cmpw 0,10,7
	or 8,9,0
	bc 12,0,.L13
.L11:
	lis 11,num_players@ha
	mr 10,8
	lwz 9,num_players@l(11)
	addi 11,9,-1
	cmpw 0,10,11
	bc 4,0,.L17
	lis 9,players@ha
	slwi 0,10,2
	la 9,players@l(9)
	add 9,0,9
.L19:
	lwz 0,4(9)
	addi 10,10,1
	cmpw 0,10,11
	stw 0,0(9)
	addi 9,9,4
	bc 12,0,.L19
.L17:
	lis 11,num_players@ha
	lwz 9,num_players@l(11)
	addi 9,9,-1
	stw 9,num_players@l(11)
	blr
.Lfe6:
	.size	 ACEIT_PlayerRemoved,.Lfe6-ACEIT_PlayerRemoved
	.section	".rodata"
	.align 3
.LC74:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEIT_IsVisible
	.type	 ACEIT_IsVisible,@function
ACEIT_IsVisible:
	stwu 1,-80(1)
	mflr 0
	stw 0,84(1)
	lis 9,gi+48@ha
	lis 5,vec3_origin@ha
	lwz 0,gi+48@l(9)
	mr 11,3
	mr 7,4
	la 5,vec3_origin@l(5)
	addi 3,1,8
	li 9,25
	mr 8,11
	mtlr 0
	addi 4,11,4
	mr 6,5
	blrl
	lfs 0,16(1)
	lis 9,.LC74@ha
	la 9,.LC74@l(9)
	lfd 13,0(9)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,31,1
	lwz 0,84(1)
	mtlr 0
	la 1,80(1)
	blr
.Lfe7:
	.size	 ACEIT_IsVisible,.Lfe7-ACEIT_IsVisible
	.section	".rodata"
	.align 2
.LC75:
	.long 0x41900000
	.align 3
.LC76:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEIT_IsReachable
	.type	 ACEIT_IsReachable,@function
ACEIT_IsReachable:
	stwu 1,-96(1)
	mflr 0
	stw 0,100(1)
	lis 9,.LC75@ha
	mr 11,3
	la 9,.LC75@l(9)
	lfs 13,196(11)
	mr 7,4
	lfs 0,0(9)
	addi 3,1,8
	mr 8,11
	lis 9,gi+48@ha
	lfs 12,188(11)
	addi 4,11,4
	lwz 0,gi+48@l(9)
	addi 5,1,72
	addi 6,11,200
	fadds 13,13,0
	li 9,25
	lfs 0,192(11)
	mtlr 0
	stfs 12,72(1)
	stfs 13,80(1)
	stfs 0,76(1)
	blrl
	lfs 0,16(1)
	lis 9,.LC76@ha
	la 9,.LC76@l(9)
	lfd 13,0(9)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,31,1
	lwz 0,100(1)
	mtlr 0
	la 1,96(1)
	blr
.Lfe8:
	.size	 ACEIT_IsReachable,.Lfe8-ACEIT_IsReachable
	.section	".rodata"
	.align 2
.LC77:
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEIT_ChangeWeapon
	.type	 ACEIT_ChangeWeapon,@function
ACEIT_ChangeWeapon:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	mr 30,4
	lwz 11,84(29)
	lwz 0,1788(11)
	cmpw 0,30,0
	bc 4,2,.L28
	li 3,1
	b .L202
.L28:
	lis 9,itemlist@ha
	lis 31,0x286b
	la 28,itemlist@l(9)
	ori 31,31,51739
	subf 0,28,30
	addi 11,11,740
	mullw 0,0,31
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	li 3,0
	bc 12,2,.L202
	lwz 3,52(30)
	cmpwi 0,3,0
	bc 12,2,.L30
	bl FindItem
	subf 3,28,3
	lwz 9,84(29)
	mullw 3,3,31
	addi 9,9,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	bc 4,2,.L30
	lis 9,.LC77@ha
	lis 11,g_select_empty@ha
	la 9,.LC77@l(9)
	lfs 13,0(9)
	lwz 9,g_select_empty@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L30
	li 3,0
	b .L202
.L30:
	lwz 9,84(29)
	li 3,1
	stw 30,3568(9)
.L202:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 ACEIT_ChangeWeapon,.Lfe9-ACEIT_ChangeWeapon
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
