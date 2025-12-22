	.file	"matrix_items.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"item_quad"
	.align 2
.LC1:
	.string	"Damage Upgrade"
	.align 2
.LC2:
	.string	"item_invulnerability"
	.align 2
.LC3:
	.string	"Speed Upgrade"
	.align 2
.LC4:
	.string	"item_adrenaline"
	.align 2
.LC5:
	.string	"Stamina Upgrade"
	.align 2
.LC6:
	.string	"item_health_mega"
	.align 2
.LC7:
	.string	"Health Upgrade"
	.align 2
.LC8:
	.string	"item_power_shield"
	.align 2
.LC9:
	.string	"item_power_screen"
	.align 2
.LC10:
	.string	"item_silencer"
	.align 2
.LC11:
	.string	"item_breather"
	.align 2
.LC12:
	.string	"item_enviro"
	.align 2
.LC13:
	.string	"item_armor_shard"
	.align 2
.LC14:
	.string	"Bullets"
	.align 2
.LC15:
	.string	"ammo_grenades"
	.align 2
.LC16:
	.string	"ammo_cells"
	.align 2
.LC17:
	.string	"Medium Stamina"
	.align 2
.LC18:
	.string	"ammo_shells"
	.align 2
.LC19:
	.string	"Small Stamina"
	.align 2
.LC20:
	.string	"ammo_slugs"
	.align 2
.LC21:
	.string	"Large Stamina"
	.align 2
.LC22:
	.string	"ammo_rockets"
	.align 2
.LC23:
	.string	"item_pack"
	.align 2
.LC24:
	.string	"Bandolier"
	.align 2
.LC25:
	.string	"weapon_bfg"
	.align 2
.LC26:
	.string	"Desert Eagle Pistol"
	.align 2
.LC27:
	.string	"weapon_grenadelauncher"
	.align 2
.LC28:
	.string	"Grenades"
	.align 2
.LC29:
	.string	"weapon_chaingun"
	.align 2
.LC30:
	.string	"Semi Mobile Chaingun"
	.align 2
.LC31:
	.string	"weapon_hyperblaster"
	.align 2
.LC32:
	.string	"m4 assault rifle"
	.align 2
.LC33:
	.string	"weapon_railgun"
	.align 2
.LC34:
	.string	"Sniper Rifle"
	.align 2
.LC35:
	.string	"weapon_machinegun"
	.align 2
.LC36:
	.string	"mp5 machine gun"
	.align 2
.LC37:
	.string	"weapon_rocketlauncher"
	.align 2
.LC38:
	.string	"Surface to Surface Missile rack"
	.align 2
.LC39:
	.string	"weapon_shotgun"
	.align 2
.LC40:
	.string	"desert eagle pistol"
	.align 2
.LC41:
	.string	"weapon_supershotgun"
	.align 2
.LC42:
	.string	"Pump Action Shotgun"
	.align 2
.LC43:
	.long 0x0
	.section	".text"
	.align 2
	.globl MatrixReplaceItems
	.type	 MatrixReplaceItems,@function
MatrixReplaceItems:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC43@ha
	lis 9,weaponban@ha
	la 11,.LC43@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,weaponban@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L7
	lwz 9,648(31)
	lwz 0,56(9)
	andi. 9,0,1
	bc 12,2,.L7
	bl G_FreeEdict
.L7:
	lwz 3,280(31)
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L8
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L8:
	lwz 3,280(31)
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L9
	lis 3,.LC3@ha
	la 3,.LC3@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L9:
	lwz 3,280(31)
	lis 4,.LC4@ha
	la 4,.LC4@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L10
	lis 3,.LC5@ha
	la 3,.LC5@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L10:
	lwz 3,280(31)
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L11
	lis 3,.LC7@ha
	la 3,.LC7@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L11:
	lwz 3,280(31)
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L12
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L12:
	lwz 3,280(31)
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L13
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L13:
	lwz 3,280(31)
	lis 4,.LC10@ha
	la 4,.LC10@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L14
	lis 3,.LC5@ha
	la 3,.LC5@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L14:
	lwz 3,280(31)
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L15
	lis 3,.LC5@ha
	la 3,.LC5@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L15:
	lwz 3,280(31)
	lis 4,.LC12@ha
	la 4,.LC12@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L16
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L16:
	lwz 3,280(31)
	lis 4,.LC13@ha
	la 4,.LC13@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L17
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L17:
	lwz 3,280(31)
	lis 4,.LC15@ha
	la 4,.LC15@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L18
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L18:
	lwz 3,280(31)
	lis 4,.LC16@ha
	la 4,.LC16@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L19
	lis 3,.LC17@ha
	la 3,.LC17@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L19:
	lwz 3,280(31)
	lis 4,.LC18@ha
	la 4,.LC18@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L20
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L20:
	lwz 3,280(31)
	lis 4,.LC20@ha
	la 4,.LC20@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L21
	lis 3,.LC21@ha
	la 3,.LC21@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L21:
	lwz 3,280(31)
	lis 4,.LC22@ha
	la 4,.LC22@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L22
	lis 3,.LC17@ha
	la 3,.LC17@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L22:
	lwz 3,280(31)
	lis 4,.LC23@ha
	la 4,.LC23@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L23
	lis 3,.LC24@ha
	la 3,.LC24@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L23:
	lwz 3,280(31)
	lis 4,.LC25@ha
	la 4,.LC25@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L24
	lis 3,.LC26@ha
	la 3,.LC26@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L24:
	lwz 3,280(31)
	lis 4,.LC27@ha
	la 4,.LC27@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L25
	lis 3,.LC28@ha
	la 3,.LC28@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L25:
	lwz 3,280(31)
	lis 4,.LC29@ha
	la 4,.LC29@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L26
	lis 3,.LC30@ha
	la 3,.LC30@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L26:
	lwz 3,280(31)
	lis 4,.LC31@ha
	la 4,.LC31@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L27
	lis 3,.LC32@ha
	la 3,.LC32@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L27:
	lwz 3,280(31)
	lis 4,.LC33@ha
	la 4,.LC33@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L28
	lis 3,.LC34@ha
	la 3,.LC34@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L28:
	lwz 3,280(31)
	lis 4,.LC35@ha
	la 4,.LC35@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L29
	lis 3,.LC36@ha
	la 3,.LC36@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L29:
	lwz 3,280(31)
	lis 4,.LC37@ha
	la 4,.LC37@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L30
	lis 3,.LC38@ha
	la 3,.LC38@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L30:
	lwz 3,280(31)
	lis 4,.LC39@ha
	la 4,.LC39@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L31
	lis 3,.LC40@ha
	la 3,.LC40@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L31:
	lwz 3,280(31)
	lis 4,.LC41@ha
	la 4,.LC41@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L32
	lis 3,.LC42@ha
	la 3,.LC42@l(3)
	bl FindItem
	lwz 0,0(3)
	stw 0,280(31)
.L32:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 MatrixReplaceItems,.Lfe1-MatrixReplaceItems
	.section	".rodata"
	.align 2
.LC44:
	.string	"item_matrix_damageup"
	.align 2
.LC45:
	.string	"item_matrix_healthup"
	.align 2
.LC46:
	.string	"item_matrix_staminaup"
	.align 2
.LC47:
	.string	"item_matrix_speedup"
	.align 2
.LC48:
	.string	"weapon_knives"
	.align 2
.LC49:
	.string	"weapon_fists"
	.align 2
.LC50:
	.long 0x0
	.align 3
.LC51:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_MatrixPack
	.type	 Pickup_MatrixPack,@function
Pickup_MatrixPack:
	stwu 1,-64(1)
	mflr 0
	stmw 23,28(1)
	stw 0,68(1)
	lis 9,game@ha
	li 28,0
	la 11,game@l(9)
	mr 25,3
	lwz 0,1556(11)
	mr 26,4
	cmpw 0,28,0
	bc 4,0,.L59
	lis 9,itemlist@ha
	lis 27,0xcccc
	mr 23,11
	la 31,itemlist@l(9)
	lis 24,.LC25@ha
	ori 27,27,52429
	li 30,0
.L61:
	lwz 0,56(31)
	andi. 8,0,1
	bc 12,2,.L60
	lwz 0,52(31)
	cmpwi 0,0,0
	bc 12,2,.L60
	lwz 3,0(31)
	la 4,.LC25@l(24)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L60
	mullw 0,30,27
	lwz 11,84(26)
	srawi 0,0,4
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,1
	stwx 9,11,0
	lwz 3,52(31)
	bl FindItem
	mr 29,3
	lwz 3,52(31)
	bl FindItem
	lwz 5,48(3)
	mr 4,29
	mr 3,26
	bl Add_Ammo
.L60:
	lwz 0,1556(23)
	addi 28,28,1
	addi 30,30,80
	addi 31,31,80
	cmpw 0,28,0
	bc 12,0,.L61
.L59:
	lwz 0,284(25)
	andis. 8,0,1
	bc 4,2,.L65
	lis 9,.LC50@ha
	lis 11,deathmatch@ha
	la 9,.LC50@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L65
	lwz 11,648(25)
	lis 10,0x4330
	lis 8,.LC51@ha
	mr 3,25
	lwz 0,48(11)
	la 8,.LC51@l(8)
	lfd 0,0(8)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 10,16(1)
	lfd 1,16(1)
	fsub 1,1,0
	frsp 1,1
	bl SetRespawn
.L65:
	li 3,1
	lwz 0,68(1)
	mtlr 0
	lmw 23,28(1)
	la 1,64(1)
	blr
.Lfe2:
	.size	 Pickup_MatrixPack,.Lfe2-Pickup_MatrixPack
	.align 2
	.globl AkimboChangeWeapon
	.type	 AkimboChangeWeapon,@function
AkimboChangeWeapon:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 10,0
	lwz 9,84(31)
	lwz 0,1788(9)
	stw 0,1792(9)
	lwz 11,84(31)
	lwz 0,3564(11)
	stw 0,1788(11)
	lwz 9,84(31)
	stw 10,3564(9)
	lwz 11,84(31)
	stw 10,3720(11)
	lwz 0,40(31)
	cmpwi 0,0,255
	bc 4,2,.L67
	lwz 9,84(31)
	lwz 9,1788(9)
	cmpwi 0,9,0
	bc 12,2,.L68
	lbz 0,63(9)
	slwi 10,0,8
	b .L69
.L68:
	li 10,0
.L69:
	lis 11,g_edicts@ha
	lis 0,0xbfc5
	lwz 9,g_edicts@l(11)
	ori 0,0,18087
	subf 9,9,31
	mullw 9,9,0
	srawi 9,9,2
	addi 9,9,-1
	or 9,9,10
	stw 9,60(31)
.L67:
	lwz 9,84(31)
	lwz 3,1788(9)
	cmpwi 0,3,0
	bc 12,2,.L70
	lwz 3,52(3)
	cmpwi 0,3,0
	bc 12,2,.L70
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0xcccc
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,52429
	subf 3,9,3
	mullw 3,3,0
	srawi 3,3,4
	stw 3,3544(11)
	b .L71
.L70:
	lwz 9,84(31)
	li 0,0
	stw 0,3544(9)
.L71:
	lwz 11,84(31)
	lwz 9,1788(11)
	lwz 0,76(9)
	cmpwi 0,0,0
	bc 12,2,.L72
	li 0,1
	stw 0,3912(11)
.L72:
	lwz 9,84(31)
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 12,2,.L73
	lis 11,gi+32@ha
	lwz 9,1788(9)
	lwz 0,gi+32@l(11)
	lwz 3,76(9)
	b .L79
.L73:
	lis 11,gi+32@ha
	lwz 9,1788(9)
	lwz 0,gi+32@l(11)
	lwz 3,32(9)
.L79:
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 3,88(9)
	lwz 9,84(31)
	lwz 0,1788(9)
	cmpwi 0,0,0
	bc 4,2,.L75
	stw 0,88(9)
	b .L66
.L75:
	lwz 0,3836(9)
	cmpwi 0,0,0
	bc 12,2,.L76
	li 0,0
	stw 0,88(9)
.L76:
	lwz 9,84(31)
	li 0,3
	stw 0,3728(9)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L77
	li 0,169
	li 9,172
	b .L80
.L77:
	li 0,62
	li 9,65
.L80:
	stw 0,56(31)
	stw 9,3724(11)
.L66:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 AkimboChangeWeapon,.Lfe3-AkimboChangeWeapon
	.section	".rodata"
	.align 2
.LC52:
	.string	"No %s for %s.\n"
	.align 2
.LC53:
	.string	"Not enough %s for %s.\n"
	.align 2
.LC54:
	.long 0x0
	.section	".text"
	.align 2
	.globl Matrix_Use_Weapon
	.type	 Matrix_Use_Weapon,@function
Matrix_Use_Weapon:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 9,84(31)
	lwz 0,1788(9)
	cmpw 0,30,0
	bc 4,2,.L91
	lwz 0,76(30)
	cmpwi 0,0,0
	bc 12,2,.L81
	lwz 10,3912(9)
	cmpwi 0,10,0
	bc 12,2,.L84
	li 8,0
	li 0,1
	stw 8,3912(9)
	lis 7,gi+32@ha
	lwz 9,84(31)
	stw 0,3600(9)
	lwz 11,84(31)
	stw 8,92(11)
	lwz 10,84(31)
	lwz 0,gi+32@l(7)
	lwz 9,1788(10)
	mtlr 0
	lwz 3,32(9)
	b .L92
.L84:
	li 0,1
	lis 8,gi+32@ha
	stw 0,3912(9)
	lwz 9,84(31)
	stw 0,3600(9)
	lwz 11,84(31)
	stw 10,92(11)
	lwz 10,84(31)
	lwz 0,gi+32@l(8)
	lwz 9,1788(10)
	mtlr 0
	lwz 3,76(9)
.L92:
	blrl
	lwz 9,84(31)
	stw 3,88(9)
	b .L81
.L91:
	lwz 3,52(30)
	cmpwi 0,3,0
	bc 12,2,.L87
	lis 9,.LC54@ha
	lis 11,g_select_empty@ha
	la 9,.LC54@l(9)
	lfs 13,0(9)
	lwz 9,g_select_empty@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L87
	lwz 0,56(30)
	andi. 9,0,2
	bc 4,2,.L87
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0xcccc
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,52429
	subf 9,9,3
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,4
	slwi 9,9,2
	lwzx 9,11,9
	cmpwi 0,9,0
	bc 4,2,.L88
	lis 9,gi+8@ha
	lis 5,.LC52@ha
	lwz 6,40(3)
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC52@l(5)
	b .L93
.L88:
	lwz 0,48(30)
	cmpw 0,9,0
	bc 4,0,.L87
	lis 9,gi+8@ha
	lis 5,.LC53@ha
	lwz 6,40(3)
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC53@l(5)
.L93:
	lwz 7,40(30)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L81
.L87:
	lwz 0,76(30)
	cmpwi 0,0,0
	bc 12,2,.L90
	lwz 9,84(31)
	li 0,1
	stw 0,3912(9)
.L90:
	lwz 9,84(31)
	stw 30,3564(9)
.L81:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 Matrix_Use_Weapon,.Lfe4-Matrix_Use_Weapon
	.align 2
	.globl MatrixSetupItems
	.type	 MatrixSetupItems,@function
MatrixSetupItems:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 4,.LC44@ha
	lwz 3,280(31)
	la 4,.LC44@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L34
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,4096
	oris 0,0,0x40
	stw 9,68(31)
	stw 0,64(31)
.L34:
	lwz 3,280(31)
	lis 4,.LC45@ha
	la 4,.LC45@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L35
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,384
	ori 9,9,2048
	stw 0,64(31)
	stw 9,68(31)
.L35:
	lwz 3,280(31)
	lis 4,.LC46@ha
	la 4,.LC46@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L36
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,1024
	oris 0,0,0x1
	stw 9,68(31)
	stw 0,64(31)
.L36:
	lwz 3,280(31)
	lis 4,.LC47@ha
	la 4,.LC47@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L37
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,320
	ori 9,9,3072
	stw 0,64(31)
	stw 9,68(31)
.L37:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 MatrixSetupItems,.Lfe5-MatrixSetupItems
	.section	".rodata"
	.align 3
.LC55:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC56:
	.long 0x0
	.section	".text"
	.align 2
	.globl Pickup_MatrixDamageUp
	.type	 Pickup_MatrixDamageUp,@function
Pickup_MatrixDamageUp:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC55@ha
	lwz 0,988(4)
	la 9,.LC55@l(9)
	lwz 7,992(4)
	lis 6,0x4330
	lfd 12,0(9)
	lis 11,sv_maxlevel@ha
	lwz 9,984(4)
	lwz 10,sv_maxlevel@l(11)
	add 0,0,9
	add 0,0,7
	lfs 13,20(10)
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L39
	li 3,0
	b .L94
.L39:
	addi 0,7,1
	stw 0,992(4)
	lwz 9,284(3)
	andis. 0,9,1
	bc 4,2,.L40
	lis 9,.LC56@ha
	lis 11,deathmatch@ha
	la 9,.LC56@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L40
	lwz 11,648(3)
	lwz 0,48(11)
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 6,8(1)
	lfd 1,8(1)
	fsub 1,1,12
	frsp 1,1
	bl SetRespawn
.L40:
	li 3,1
.L94:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 Pickup_MatrixDamageUp,.Lfe6-Pickup_MatrixDamageUp
	.section	".rodata"
	.align 3
.LC57:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC58:
	.long 0x0
	.section	".text"
	.align 2
	.globl Pickup_MatrixSpeedUp
	.type	 Pickup_MatrixSpeedUp,@function
Pickup_MatrixSpeedUp:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,4
	mr 30,3
	lwz 9,84(31)
	lis 4,.LC48@ha
	la 4,.LC48@l(4)
	lwz 11,1788(9)
	lwz 3,0(11)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L43
	lwz 9,84(31)
	lis 4,.LC49@ha
	la 4,.LC49@l(4)
	lwz 11,1788(9)
	lwz 3,0(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L42
.L43:
	lis 10,level@ha
	lwz 8,84(31)
	lwz 9,level@l(10)
	lis 7,.LC57@ha
	lis 10,0x4330
	la 7,.LC57@l(7)
	addi 9,9,150
	lfd 12,0(7)
	xoris 9,9,0x8000
	stw 9,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	stfs 0,3876(8)
	lwz 0,284(30)
	andis. 9,0,1
	bc 4,2,.L44
	lis 11,deathmatch@ha
	lis 7,.LC58@ha
	lwz 9,deathmatch@l(11)
	la 7,.LC58@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L44
	lwz 11,648(30)
	mr 3,30
	lwz 0,48(11)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 10,16(1)
	lfd 1,16(1)
	fsub 1,1,12
	frsp 1,1
	bl SetRespawn
.L44:
	li 3,1
	b .L95
.L42:
	li 3,0
.L95:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 Pickup_MatrixSpeedUp,.Lfe7-Pickup_MatrixSpeedUp
	.section	".rodata"
	.align 3
.LC59:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC60:
	.long 0x0
	.section	".text"
	.align 2
	.globl Pickup_MatrixStaminaUp
	.type	 Pickup_MatrixStaminaUp,@function
Pickup_MatrixStaminaUp:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC59@ha
	lwz 7,984(4)
	la 9,.LC59@l(9)
	lwz 0,988(4)
	lis 6,0x4330
	lfd 12,0(9)
	lis 8,sv_maxlevel@ha
	lwz 9,992(4)
	add 0,0,7
	lwz 11,sv_maxlevel@l(8)
	add 0,0,9
	xoris 0,0,0x8000
	lfs 13,20(11)
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L47
	li 3,0
	b .L96
.L47:
	addi 0,7,1
	stw 0,984(4)
	lwz 9,284(3)
	andis. 0,9,1
	bc 4,2,.L48
	lis 9,.LC60@ha
	lis 11,deathmatch@ha
	la 9,.LC60@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L48
	lwz 11,648(3)
	lwz 0,48(11)
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 6,8(1)
	lfd 1,8(1)
	fsub 1,1,12
	frsp 1,1
	bl SetRespawn
.L48:
	li 3,1
.L96:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 Pickup_MatrixStaminaUp,.Lfe8-Pickup_MatrixStaminaUp
	.section	".rodata"
	.align 3
.LC61:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC62:
	.long 0x0
	.section	".text"
	.align 2
	.globl Pickup_MatrixHealthUp
	.type	 Pickup_MatrixHealthUp,@function
Pickup_MatrixHealthUp:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC61@ha
	lwz 7,988(4)
	la 9,.LC61@l(9)
	lwz 0,984(4)
	lis 6,0x4330
	lfd 12,0(9)
	lis 8,sv_maxlevel@ha
	lwz 9,992(4)
	add 0,7,0
	lwz 11,sv_maxlevel@l(8)
	add 0,0,9
	xoris 0,0,0x8000
	lfs 13,20(11)
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L50
	li 3,0
	b .L97
.L50:
	addi 0,7,1
	stw 0,988(4)
	lwz 9,284(3)
	andis. 0,9,1
	bc 4,2,.L51
	lis 9,.LC62@ha
	lis 11,deathmatch@ha
	la 9,.LC62@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L51
	lwz 11,648(3)
	lwz 0,48(11)
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 6,8(1)
	lfd 1,8(1)
	fsub 1,1,12
	frsp 1,1
	bl SetRespawn
.L51:
	li 3,1
.L97:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 Pickup_MatrixHealthUp,.Lfe9-Pickup_MatrixHealthUp
	.section	".rodata"
	.align 3
.LC63:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC64:
	.long 0x0
	.align 2
.LC65:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Pickup_MatrixStamina
	.type	 Pickup_MatrixStamina,@function
Pickup_MatrixStamina:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,980(4)
	lis 10,0x4330
	lis 11,.LC63@ha
	lfs 11,924(4)
	xoris 0,0,0x8000
	la 11,.LC63@l(11)
	stw 0,12(1)
	stw 10,8(1)
	lfd 12,0(11)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 13,0
	fcmpu 0,11,13
	bc 4,0,.L53
	lwz 11,648(3)
	lwz 0,48(11)
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 10,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fadds 0,11,0
	fcmpu 0,0,13
	stfs 0,924(4)
	bc 4,1,.L54
	stfs 13,924(4)
.L54:
	lwz 0,284(3)
	andis. 9,0,1
	bc 4,2,.L55
	lis 9,.LC64@ha
	lis 11,deathmatch@ha
	la 9,.LC64@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L55
	lis 11,.LC65@ha
	la 11,.LC65@l(11)
	lfs 1,0(11)
	bl SetRespawn
.L55:
	li 3,1
	b .L98
.L53:
	li 3,0
.L98:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 Pickup_MatrixStamina,.Lfe10-Pickup_MatrixStamina
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
