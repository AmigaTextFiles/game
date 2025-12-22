	.file	"p_weapon.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"player_noise"
	.align 2
.LC1:
	.long 0x0
	.section	".text"
	.align 2
	.globl PlayerNoise
	.type	 PlayerNoise,@function
PlayerNoise:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 25,5
	mr 31,3
	cmpwi 0,25,1
	mr 30,4
	bc 4,2,.L11
	lwz 11,84(31)
	lwz 9,3764(11)
	cmpwi 0,9,0
	bc 12,2,.L11
	addi 0,9,-1
	stw 0,3764(11)
	b .L10
.L11:
	lis 9,.LC1@ha
	lis 11,deathmatch@ha
	la 9,.LC1@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L10
	lwz 0,264(31)
	andi. 9,0,32
	bc 4,2,.L10
	lwz 0,568(31)
	cmpwi 0,0,0
	bc 4,2,.L15
	bl G_Spawn
	lis 28,0xc100
	lis 27,0x4100
	lis 29,.LC0@ha
	mr 10,3
	la 29,.LC0@l(29)
	li 26,1
	stw 28,188(10)
	stw 29,280(10)
	stw 28,192(10)
	stw 28,196(10)
	stw 27,200(10)
	stw 27,204(10)
	stw 27,208(10)
	stw 31,256(10)
	stw 26,184(10)
	stw 10,568(31)
	bl G_Spawn
	mr 10,3
	stw 29,280(10)
	stw 28,196(10)
	stw 27,208(10)
	stw 26,184(10)
	stw 28,188(10)
	stw 28,192(10)
	stw 27,200(10)
	stw 27,204(10)
	stw 31,256(10)
	stw 10,572(31)
.L15:
	cmplwi 0,25,1
	bc 12,1,.L16
	lis 9,level@ha
	lwz 10,568(31)
	lwz 0,level@l(9)
	la 9,level@l(9)
	stw 10,248(9)
	stw 0,252(9)
	b .L17
.L16:
	lis 9,level@ha
	lwz 10,572(31)
	lwz 0,level@l(9)
	la 9,level@l(9)
	stw 10,256(9)
	stw 0,260(9)
.L17:
	lfs 13,0(30)
	lis 9,level+4@ha
	lis 11,gi+72@ha
	lfs 10,200(10)
	mr 3,10
	lfs 12,204(10)
	stfs 13,4(10)
	lfs 0,4(30)
	lfs 11,208(10)
	stfs 0,8(10)
	lfs 13,8(30)
	stfs 13,12(10)
	lfs 0,0(30)
	fsubs 0,0,10
	stfs 0,212(10)
	lfs 13,4(30)
	fsubs 13,13,12
	stfs 13,216(10)
	lfs 0,8(30)
	fsubs 0,0,11
	stfs 0,220(10)
	lfs 13,0(30)
	fadds 13,13,10
	stfs 13,224(10)
	lfs 0,4(30)
	fadds 0,0,12
	stfs 0,228(10)
	lfs 13,8(30)
	fadds 13,13,11
	stfs 13,232(10)
	lfs 0,level+4@l(9)
	stfs 0,604(10)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L10:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 PlayerNoise,.Lfe1-PlayerNoise
	.section	".rodata"
	.align 2
.LC2:
	.string	"blaster"
	.align 2
.LC3:
	.long 0x0
	.align 3
.LC4:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Weapon
	.type	 Pickup_Weapon,@function
Pickup_Weapon:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,dmflags@ha
	mr 30,3
	lwz 8,dmflags@l(9)
	lis 11,itemlist@ha
	lwz 0,648(30)
	la 11,itemlist@l(11)
	lis 9,0xcccc
	lfs 0,20(8)
	ori 9,9,52429
	mr 29,4
	subf 0,11,0
	mullw 0,0,9
	srawi 0,0,4
	fctiwz 13,0
	stfd 13,8(1)
	lwz 10,12(1)
	andi. 9,10,4
	bc 4,2,.L20
	lis 11,.LC3@ha
	lis 9,coop@ha
	la 11,.LC3@l(11)
	slwi 28,0,2
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L19
.L20:
	lwz 9,84(29)
	slwi 11,0,2
	mr 28,11
	addi 9,9,740
	lwzx 0,9,11
	cmpwi 0,0,0
	bc 12,2,.L19
	lwz 0,284(30)
	andis. 9,0,0x3
	bc 4,2,.L19
	li 3,0
	b .L32
.L19:
	lwz 9,84(29)
	addi 9,9,740
	lwzx 11,9,28
	addi 11,11,2
	stwx 11,9,28
	lwz 0,284(30)
	andis. 11,0,1
	bc 4,2,.L22
	lwz 9,648(30)
	lwz 3,52(9)
	bl FindItem
	lis 11,dmflags@ha
	lwz 10,dmflags@l(11)
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	andi. 0,9,8192
	bc 12,2,.L23
	mr 4,3
	li 5,1000
	mr 3,29
	bl Add_Ammo
	b .L24
.L23:
	mr 4,3
	lwz 5,48(4)
	mr 3,29
	bl Add_Ammo
.L24:
	lwz 0,284(30)
	andis. 9,0,2
	bc 4,2,.L22
	lis 9,.LC3@ha
	lis 11,deathmatch@ha
	la 9,.LC3@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L26
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,4
	bc 12,2,.L27
	lwz 0,264(30)
	oris 0,0,0x8000
	stw 0,264(30)
	b .L26
.L27:
	lis 11,weaponrespawntime@ha
	lwz 8,weaponrespawntime@l(11)
	mr 10,9
	lis 0,0x4330
	lis 11,.LC4@ha
	mr 3,30
	lfs 0,20(8)
	la 11,.LC4@l(11)
	lfd 12,0(11)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	xoris 9,9,0x8000
	stw 9,12(1)
	stw 0,8(1)
	lfd 1,8(1)
	fsub 1,1,12
	frsp 1,1
	bl SetRespawn
.L26:
	lis 9,.LC3@ha
	lis 11,coop@ha
	la 9,.LC3@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L22
	lwz 0,264(30)
	oris 0,0,0x8000
	stw 0,264(30)
.L22:
	lwz 31,84(29)
	lwz 9,648(30)
	lwz 0,1788(31)
	cmpw 0,0,9
	bc 12,2,.L30
	addi 9,31,740
	lwzx 0,9,28
	cmpwi 0,0,1
	bc 4,2,.L30
	lis 9,.LC3@ha
	lis 11,deathmatch@ha
	la 9,.LC3@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L31
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	bl FindItem
	lwz 0,1788(31)
	cmpw 0,0,3
	bc 4,2,.L30
.L31:
	lwz 9,84(29)
	lwz 0,648(30)
	stw 0,3564(9)
.L30:
	li 3,1
.L32:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Pickup_Weapon,.Lfe2-Pickup_Weapon
	.section	".rodata"
	.align 2
.LC5:
	.long 0x0
	.section	".text"
	.align 2
	.globl ChangeWeapon
	.type	 ChangeWeapon,@function
ChangeWeapon:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 9,.LC5@ha
	lwz 11,84(31)
	la 9,.LC5@l(9)
	lfs 13,0(9)
	lfs 0,3760(11)
	fcmpu 0,0,13
	bc 12,2,.L34
	lis 9,level+4@ha
	li 0,0
	lfs 0,level+4@l(9)
	stfs 0,3760(11)
	lwz 9,84(31)
	stw 0,3768(9)
	lwz 11,84(31)
	stfs 13,3760(11)
.L34:
	lwz 11,84(31)
	lis 0,0x42b4
	li 10,0
	stw 0,112(11)
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
	bc 4,2,.L35
	lwz 9,84(31)
	lwz 9,1788(9)
	cmpwi 0,9,0
	bc 12,2,.L36
	lbz 0,63(9)
	slwi 10,0,8
	b .L37
.L36:
	li 10,0
.L37:
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
.L35:
	lwz 9,84(31)
	lwz 3,1788(9)
	cmpwi 0,3,0
	bc 12,2,.L38
	lwz 3,52(3)
	cmpwi 0,3,0
	bc 12,2,.L38
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
	b .L39
.L38:
	lwz 9,84(31)
	li 0,0
	stw 0,3544(9)
.L39:
	lwz 9,84(31)
	lwz 0,1788(9)
	cmpwi 0,0,0
	bc 4,2,.L40
	stw 0,88(9)
	b .L33
.L40:
	li 0,1
	li 11,0
	stw 0,3600(9)
	lwz 9,84(31)
	stw 11,92(9)
	lwz 9,84(31)
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 12,2,.L41
	lis 11,gi+32@ha
	lwz 9,1788(9)
	lwz 0,gi+32@l(11)
	lwz 3,76(9)
	b .L46
.L41:
	lis 11,gi+32@ha
	lwz 9,1788(9)
	lwz 0,gi+32@l(11)
	lwz 3,32(9)
.L46:
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 3,88(9)
	lwz 9,84(31)
	lwz 0,3836(9)
	cmpwi 0,0,0
	bc 12,2,.L43
	li 0,0
	stw 0,88(9)
.L43:
	lwz 9,84(31)
	li 0,3
	stw 0,3728(9)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L44
	li 0,169
	li 9,172
	b .L47
.L44:
	li 0,62
	li 9,65
.L47:
	stw 0,56(31)
	stw 9,3724(11)
.L33:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 ChangeWeapon,.Lfe3-ChangeWeapon
	.section	".rodata"
	.align 2
.LC6:
	.string	"bullets"
	.align 2
.LC7:
	.string	"surface to surface missile rack"
	.align 2
.LC8:
	.string	"m4 assault rifle"
	.align 2
.LC9:
	.string	"grenades"
	.align 2
.LC10:
	.string	"pump action shotgun"
	.align 2
.LC11:
	.string	"desert eagle pistol"
	.align 2
.LC12:
	.string	"mk 23 pistol"
	.align 2
.LC13:
	.string	"mp5 machine gun"
	.align 2
.LC14:
	.string	"Fists of Fury"
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl NoAmmoWeaponChange
	.type	 NoAmmoWeaponChange,@function
NoAmmoWeaponChange:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 31,3
	lis 30,0xcccc
	lis 3,.LC6@ha
	lwz 29,84(31)
	ori 30,30,52429
	la 3,.LC6@l(3)
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,30
	srawi 3,3,4
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L49
	lis 27,.LC7@ha
	lwz 29,84(31)
	la 3,.LC7@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,4
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,1,.L49
	lis 9,.LC15@ha
	lwz 11,84(31)
	la 9,.LC15@l(9)
	lis 6,0x4330
	lfd 13,0(9)
	lis 10,ammo_rack@ha
	lwz 9,3544(11)
	addi 11,11,740
	lwz 8,ammo_rack@l(10)
	slwi 9,9,2
	lwzx 0,11,9
	lfs 12,20(8)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L49
	la 3,.LC7@l(27)
	bl FindItem
	lwz 9,84(31)
	li 0,0
	b .L56
.L49:
	lis 3,.LC6@ha
	lwz 29,84(31)
	lis 30,0xcccc
	la 3,.LC6@l(3)
	ori 30,30,52429
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,30
	srawi 3,3,4
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L50
	lis 27,.LC8@ha
	lwz 29,84(31)
	la 3,.LC8@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,4
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,1,.L50
	lis 9,.LC15@ha
	lwz 11,84(31)
	la 9,.LC15@l(9)
	lis 6,0x4330
	lfd 13,0(9)
	lis 10,ammo_m4@ha
	lwz 9,3544(11)
	addi 11,11,740
	lwz 8,ammo_m4@l(10)
	slwi 9,9,2
	lwzx 0,11,9
	lfs 12,20(8)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L50
	la 3,.LC8@l(27)
	b .L57
.L50:
	lis 3,.LC6@ha
	lwz 29,84(31)
	lis 30,0xcccc
	la 3,.LC6@l(3)
	ori 30,30,52429
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,30
	srawi 3,3,4
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L51
	lis 27,.LC9@ha
	lwz 29,84(31)
	la 3,.LC9@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,4
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,1,.L51
	lis 9,.LC15@ha
	lwz 11,84(31)
	la 9,.LC15@l(9)
	lis 6,0x4330
	lfd 13,0(9)
	lis 10,ammo_grenade@ha
	lwz 9,3544(11)
	addi 11,11,740
	lwz 8,ammo_grenade@l(10)
	slwi 9,9,2
	lwzx 0,11,9
	lfs 12,20(8)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L51
	la 3,.LC9@l(27)
	bl FindItem
	lwz 9,84(31)
	li 0,0
	b .L56
.L51:
	lis 3,.LC6@ha
	lwz 29,84(31)
	lis 30,0xcccc
	la 3,.LC6@l(3)
	ori 30,30,52429
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,30
	srawi 3,3,4
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L52
	lis 27,.LC10@ha
	lwz 29,84(31)
	la 3,.LC10@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,4
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,1,.L52
	lis 9,.LC15@ha
	lwz 11,84(31)
	la 9,.LC15@l(9)
	lis 6,0x4330
	lfd 13,0(9)
	lis 10,ammo_pumps@ha
	lwz 9,3544(11)
	addi 11,11,740
	lwz 8,ammo_pumps@l(10)
	slwi 9,9,2
	lwzx 0,11,9
	lfs 12,20(8)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L52
	la 3,.LC10@l(27)
	b .L57
.L52:
	lis 3,.LC6@ha
	lwz 29,84(31)
	lis 30,0xcccc
	la 3,.LC6@l(3)
	ori 30,30,52429
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,30
	srawi 3,3,4
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L53
	lis 27,.LC11@ha
	lwz 29,84(31)
	la 3,.LC11@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,4
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,1,.L53
	lis 9,.LC15@ha
	lwz 11,84(31)
	la 9,.LC15@l(9)
	lis 6,0x4330
	lfd 13,0(9)
	lis 10,ammo_deserts@ha
	lwz 9,3544(11)
	addi 11,11,740
	lwz 8,ammo_deserts@l(10)
	slwi 9,9,2
	lwzx 0,11,9
	lfs 12,20(8)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L53
	la 3,.LC11@l(27)
	b .L57
.L53:
	lis 3,.LC6@ha
	lwz 29,84(31)
	lis 30,0xcccc
	la 3,.LC6@l(3)
	ori 30,30,52429
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,30
	srawi 3,3,4
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L54
	lis 27,.LC12@ha
	lwz 29,84(31)
	la 3,.LC12@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,4
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,1,.L54
	lis 9,.LC15@ha
	lwz 11,84(31)
	la 9,.LC15@l(9)
	lis 6,0x4330
	lfd 13,0(9)
	lis 10,ammo_mk23@ha
	lwz 9,3544(11)
	addi 11,11,740
	lwz 8,ammo_mk23@l(10)
	slwi 9,9,2
	lwzx 0,11,9
	lfs 12,20(8)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L54
	la 3,.LC12@l(27)
	b .L57
.L54:
	lis 3,.LC6@ha
	lwz 29,84(31)
	lis 30,0xcccc
	la 3,.LC6@l(3)
	ori 30,30,52429
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,30
	srawi 3,3,4
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L55
	lis 27,.LC13@ha
	lwz 29,84(31)
	la 3,.LC13@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,4
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,1,.L55
	lis 9,.LC15@ha
	lwz 11,84(31)
	la 9,.LC15@l(9)
	lis 6,0x4330
	lfd 13,0(9)
	lis 10,ammo_mp5@ha
	lwz 9,3544(11)
	addi 11,11,740
	lwz 8,ammo_mp5@l(10)
	slwi 9,9,2
	lwzx 0,11,9
	lfs 12,20(8)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L55
	la 3,.LC13@l(27)
.L57:
	bl FindItem
	lwz 9,84(31)
	li 0,1
.L56:
	stw 3,3564(9)
	lwz 11,84(31)
	stw 0,3912(11)
	b .L48
.L55:
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	bl FindItem
	lwz 11,84(31)
	li 0,0
	stw 3,3564(11)
	lwz 9,84(31)
	stw 0,3912(9)
.L48:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 NoAmmoWeaponChange,.Lfe4-NoAmmoWeaponChange
	.section	".rodata"
	.align 2
.LC16:
	.string	"No %s for %s.\n"
	.align 2
.LC17:
	.string	"Not enough %s for %s.\n"
	.align 2
.LC18:
	.string	"Can't drop current weapon\n"
	.align 2
.LC19:
	.string	"weapon_knives"
	.align 2
.LC20:
	.string	"weapons/noammo.wav"
	.align 2
.LC21:
	.string	"items/damage3.wav"
	.align 2
.LC22:
	.string	"weapon_fists"
	.align 2
.LC23:
	.long 0x3f800000
	.align 2
.LC24:
	.long 0x0
	.align 3
.LC25:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Weapon_Generic
	.type	 Weapon_Generic,@function
Weapon_Generic:
	stwu 1,-80(1)
	mflr 0
	stmw 21,36(1)
	stw 0,84(1)
	mr 31,3
	mr 28,7
	lwz 11,84(31)
	mr 23,4
	mr 25,5
	lis 4,.LC19@ha
	mr 26,6
	lwz 7,1788(11)
	mr 27,8
	mr 24,9
	mr 21,10
	la 4,.LC19@l(4)
	lwz 3,0(7)
	li 22,0
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L73
	li 22,1
.L73:
	lwz 29,84(31)
	lis 9,gi@ha
	la 30,gi@l(9)
	lwz 11,1788(29)
	lwz 9,32(30)
	lwz 3,76(11)
	mtlr 9
	blrl
	lwz 0,88(29)
	cmpw 0,0,3
	bc 4,2,.L74
	lwz 9,84(31)
	lwz 0,32(30)
	lwz 11,1788(9)
	mtlr 0
	lwz 3,32(11)
	blrl
	lwz 9,84(31)
	stw 3,88(9)
.L74:
	lwz 8,492(31)
	cmpwi 0,8,0
	bc 4,2,.L72
	lwz 0,40(31)
	cmpwi 0,0,255
	bc 4,2,.L72
	lwz 9,84(31)
	lwz 11,3600(9)
	mr 10,9
	cmpwi 0,11,2
	bc 4,2,.L77
	lwz 0,92(10)
	cmpw 0,0,28
	bc 4,2,.L78
	mr 3,31
	bl ChangeWeapon
	b .L72
.L78:
	subf 0,0,28
	cmpwi 0,0,4
	bc 4,2,.L79
	li 0,6
	stw 0,3728(10)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L81
	li 0,173
	li 9,169
	b .L124
.L81:
	li 0,66
	li 9,62
.L124:
	stw 0,56(31)
	stw 9,3724(11)
.L79:
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L72
.L77:
	cmpwi 0,11,1
	bc 4,2,.L83
	lwz 9,92(10)
	cmpw 0,9,23
	bc 4,2,.L84
	stw 8,3600(10)
	addi 0,25,1
	lwz 9,84(31)
	stw 0,92(9)
	b .L72
.L84:
	addi 0,9,1
	stw 0,92(10)
	b .L72
.L83:
	lwz 0,3564(10)
	cmpwi 0,0,0
	bc 12,2,.L85
	cmpwi 0,11,3
	bc 12,2,.L85
	li 0,2
	addi 11,28,-1
	stw 0,3600(10)
	subf 11,26,11
	lwz 9,84(31)
	cmpwi 0,11,3
	addi 0,26,1
	stw 0,92(9)
	bc 12,1,.L72
	lwz 9,84(31)
	li 0,6
	stw 0,3728(9)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L87
	li 0,173
	li 9,169
	b .L125
.L87:
	li 0,66
	li 9,62
.L125:
	stw 0,56(31)
	stw 9,3724(11)
	b .L72
.L85:
	lwz 0,3600(10)
	cmpwi 0,0,0
	bc 4,2,.L89
	lwz 9,3556(10)
	lwz 0,3548(10)
	or 0,9,0
	andi. 11,0,1
	bc 4,2,.L91
	lwz 0,1064(31)
	cmpwi 0,0,0
	bc 12,2,.L90
.L91:
	rlwinm 0,9,0,0,30
	stw 0,3556(10)
	lwz 8,84(31)
	lwz 11,3544(8)
	cmpwi 0,11,0
	bc 12,2,.L93
	slwi 11,11,2
	addi 9,8,740
	lwz 0,88(1)
	lwzx 10,9,11
	cmpw 0,10,0
	bc 12,0,.L92
.L93:
	lwz 0,1064(31)
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,22
	li 0,103
	bc 4,2,.L126
	addi 0,23,1
.L126:
	stw 0,92(8)
	lwz 11,84(31)
	li 0,3
	li 10,4
	stw 0,3600(11)
	lwz 9,84(31)
	stw 10,3728(9)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L96
	li 0,159
	li 9,168
	b .L127
.L96:
	li 0,45
	li 9,53
.L127:
	stw 0,56(31)
	stw 9,3724(11)
	b .L89
.L92:
	lis 9,level@ha
	lfs 13,464(31)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L99
	lis 29,gi@ha
	lis 3,.LC20@ha
	la 29,gi@l(29)
	la 3,.LC20@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC23@ha
	lwz 0,16(29)
	lis 11,.LC23@ha
	la 9,.LC23@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC23@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC24@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC24@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC23@ha
	lfs 0,4(30)
	la 9,.LC23@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,464(31)
.L99:
	mr 3,31
	bl NoAmmoWeaponChange
	b .L89
.L90:
	lwz 0,92(10)
	cmpw 0,0,26
	bc 4,2,.L101
	addi 0,25,1
	stw 0,92(10)
	b .L72
.L101:
	cmpwi 0,27,0
	bc 12,2,.L102
	lwz 0,0(27)
	cmpwi 0,0,0
	bc 12,2,.L102
	mr 29,27
.L106:
	lwz 9,92(10)
	lwz 0,0(29)
	cmpw 0,9,0
	bc 4,2,.L105
	bl rand
	andi. 0,3,15
	bc 4,2,.L72
.L105:
	lwzu 0,4(29)
	lwz 10,84(31)
	cmpwi 0,0,0
	bc 4,2,.L106
.L102:
	lwz 9,92(10)
	addi 9,9,1
	stw 9,92(10)
	b .L72
.L89:
	lwz 9,84(31)
	lwz 0,3600(9)
	mr 10,9
	cmpwi 0,0,3
	bc 4,2,.L72
	lwz 0,0(24)
	addi 28,25,2
	li 30,0
	cmpwi 0,0,0
	bc 12,2,.L123
	lis 9,gi@ha
	lis 8,level@ha
	la 29,gi@l(9)
	lis 7,0x4330
	lis 9,.LC25@ha
	lis 3,.LC21@ha
	la 9,.LC25@l(9)
	mr 11,24
	lfd 12,0(9)
.L114:
	lwz 9,92(10)
	lwz 0,0(11)
	cmpw 0,9,0
	bc 4,2,.L113
	lwz 0,level@l(8)
	lfs 13,3740(10)
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L116
	lwz 9,36(29)
	la 3,.LC21@l(3)
	mtlr 9
	blrl
	lis 9,.LC23@ha
	lwz 0,16(29)
	lis 11,.LC23@ha
	la 9,.LC23@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC23@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC24@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC24@l(9)
	lfs 3,0(9)
	blrl
.L116:
	mr 3,31
	mtlr 21
	blrl
	b .L112
.L113:
	lwzu 0,4(11)
	addi 30,30,1
	cmpwi 0,0,0
	bc 4,2,.L114
.L112:
	slwi 0,30,2
	lwzx 9,24,0
	cmpwi 0,9,0
	bc 4,2,.L118
.L123:
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
.L118:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpw 0,0,28
	bc 4,2,.L119
	li 0,0
	stw 0,3600(9)
.L119:
	lwz 9,84(31)
	lis 4,.LC22@ha
	la 4,.LC22@l(4)
	lwz 11,1788(9)
	lwz 3,0(11)
	bl strcmp
	mr. 3,3
	bc 4,2,.L120
	lwz 0,1064(31)
	cmpwi 0,0,0
	bc 12,2,.L120
	lwz 11,84(31)
	addi 9,23,4
	lwz 0,92(11)
	cmpw 0,0,9
	bc 4,2,.L120
	stw 28,92(11)
	lwz 9,84(31)
	stw 3,3600(9)
.L120:
	lwz 11,84(31)
	lwz 0,92(11)
	cmpwi 7,0,106
	mfcr 9
	rlwinm 9,9,30,1
	and. 0,9,22
	bc 12,2,.L72
	stw 28,92(11)
	li 0,0
	lwz 9,84(31)
	stw 0,3600(9)
.L72:
	lwz 0,84(1)
	mtlr 0
	lmw 21,36(1)
	la 1,80(1)
	blr
.Lfe5:
	.size	 Weapon_Generic,.Lfe5-Weapon_Generic
	.section	".rodata"
	.align 3
.LC26:
	.long 0x4060aaaa
	.long 0xaaaaaaab
	.align 3
.LC27:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC28:
	.long 0x40080000
	.long 0x0
	.align 3
.LC29:
	.long 0x40790000
	.long 0x0
	.align 3
.LC30:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl weapon_grenade_firex
	.type	 weapon_grenade_firex,@function
weapon_grenade_firex:
	stwu 1,-144(1)
	mflr 0
	stfd 31,136(1)
	stmw 27,116(1)
	stw 0,148(1)
	lis 11,radiusdamage_grenade@ha
	mr 31,3
	lwz 10,radiusdamage_grenade@l(11)
	lis 3,0x4330
	lis 11,.LC27@ha
	mr 6,9
	lwz 12,84(31)
	lfs 0,20(10)
	la 11,.LC27@l(11)
	lis 8,is_quad@ha
	lfd 12,0(11)
	lis 7,damageradius_grenade@ha
	lis 5,0x4100
	lwz 11,508(31)
	mr 28,4
	lwz 0,is_quad@l(8)
	addi 11,11,-8
	lwz 10,damageradius_grenade@l(7)
	xoris 11,11,0x8000
	addic 0,0,-1
	subfe 0,0,0
	fctiwz 13,0
	lfs 31,20(10)
	stw 5,12(1)
	stw 5,8(1)
	stfd 13,104(1)
	lwz 9,108(1)
	stw 11,108(1)
	stw 3,104(1)
	slwi 11,9,2
	lfd 0,104(1)
	and 9,9,0
	andc 0,11,0
	or 30,9,0
	fsub 0,0,12
	frsp 0,0
	stfs 0,16(1)
	lwz 0,3848(12)
	cmpwi 0,0,0
	bc 12,2,.L130
	lwz 3,3844(12)
	addi 0,1,24
	addi 5,1,40
	mr 4,0
	li 6,0
	addi 3,3,16
	mr 27,0
	bl AngleVectors
	b .L131
.L130:
	addi 0,1,24
	addi 3,12,3668
	mr 4,0
	addi 5,1,40
	li 6,0
	mr 27,0
	bl AngleVectors
.L131:
	lfs 0,8(1)
	addi 9,1,8
	addi 10,1,72
	lwz 11,84(31)
	addi 3,31,4
	stfs 0,72(1)
	lfs 13,4(9)
	stfs 13,76(1)
	lfs 0,8(9)
	stfs 0,80(1)
	lwz 0,716(11)
	cmpwi 0,0,1
	bc 4,2,.L132
	fneg 0,13
	stfs 0,76(1)
	b .L133
.L132:
	cmpwi 0,0,2
	bc 4,2,.L133
	li 0,0
	stw 0,4(10)
.L133:
	addi 4,1,72
	addi 5,1,24
	addi 6,1,40
	addi 7,1,56
	bl G_ProjectSource
	lwz 11,84(31)
	lis 9,level@ha
	lis 10,.LC28@ha
	fmr 2,31
	la 29,level@l(9)
	la 10,.LC28@l(10)
	lfs 1,3760(11)
	mr 5,27
	lfs 0,4(29)
	lis 11,.LC29@ha
	mr 6,30
	lfd 13,0(10)
	la 11,.LC29@l(11)
	mr 8,28
	lis 10,.LC26@ha
	lfd 10,0(11)
	mr 3,31
	fsubs 1,1,0
	lfd 11,.LC26@l(10)
	addi 4,1,56
	fmr 0,1
	fsub 13,13,0
	fmadd 13,13,11,10
	fctiwz 12,13
	stfd 12,104(1)
	lwz 7,108(1)
	bl fire_grenade2
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,104(1)
	lwz 11,108(1)
	andi. 0,11,8192
	bc 4,2,.L136
	lwz 7,84(31)
	lis 5,0x4330
	lis 9,.LC27@ha
	lis 6,ammo_grenade@ha
	lwz 10,3544(7)
	la 9,.LC27@l(9)
	mr 11,8
	addi 7,7,740
	lfd 13,0(9)
	slwi 10,10,2
	lwz 9,ammo_grenade@l(6)
	lwzx 0,7,10
	lfs 11,20(9)
	xoris 0,0,0x8000
	stw 0,108(1)
	stw 5,104(1)
	lfd 0,104(1)
	fsub 0,0,13
	frsp 0,0
	fsubs 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,104(1)
	lwz 11,108(1)
	stwx 11,7,10
.L136:
	lfs 0,4(29)
	lis 10,.LC30@ha
	la 10,.LC30@l(10)
	lwz 9,84(31)
	lfd 13,0(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3760(9)
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L128
	lwz 0,40(31)
	cmpwi 0,0,255
	bc 4,2,.L128
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L128
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 11,0,1
	bc 12,2,.L140
	li 0,4
	li 10,159
	stw 0,3728(9)
	li 11,162
	b .L142
.L140:
	li 0,6
	li 10,119
	stw 0,3728(9)
	li 11,112
.L142:
	lwz 9,84(31)
	stw 10,56(31)
	stw 11,3724(9)
.L128:
	lwz 0,148(1)
	mtlr 0
	lmw 27,116(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe6:
	.size	 weapon_grenade_firex,.Lfe6-weapon_grenade_firex
	.section	".rodata"
	.align 2
.LC31:
	.string	"weapons/hgrena1b.wav"
	.align 2
.LC33:
	.string	"weapons/hgrenc1b.wav"
	.align 3
.LC32:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC34:
	.long 0x3f800000
	.align 2
.LC35:
	.long 0x0
	.align 3
.LC36:
	.long 0x40080000
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_Grenadex
	.type	 Weapon_Grenadex,@function
Weapon_Grenadex:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3564(9)
	cmpwi 0,0,0
	bc 12,2,.L144
	lwz 0,3600(9)
	cmpwi 0,0,0
	bc 4,2,.L144
	bl ChangeWeapon
	b .L143
.L144:
	lwz 9,84(31)
	lwz 0,3600(9)
	cmpwi 0,0,1
	bc 4,2,.L145
	li 0,0
	li 11,16
	stw 0,3600(9)
	lwz 9,84(31)
	stw 11,92(9)
	b .L143
.L145:
	cmpwi 0,0,0
	bc 4,2,.L146
	lwz 11,3556(9)
	lwz 0,3548(9)
	or 0,11,0
	andi. 10,0,1
	bc 4,2,.L148
	lwz 0,1064(31)
	cmpwi 0,0,0
	bc 12,2,.L147
.L148:
	rlwinm 0,11,0,0,30
	stw 0,3556(9)
	lwz 8,84(31)
	lwz 0,3544(8)
	addi 11,8,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L149
	li 0,1
	li 10,3
	stw 0,92(8)
	lwz 9,84(31)
	li 8,0
	stw 10,3600(9)
	lwz 11,84(31)
	stw 8,3760(11)
	b .L143
.L149:
	lis 9,level@ha
	lfs 13,464(31)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L151
	lis 29,gi@ha
	lis 3,.LC20@ha
	la 29,gi@l(29)
	la 3,.LC20@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC34@ha
	lis 10,.LC34@ha
	lis 11,.LC35@ha
	la 9,.LC34@l(9)
	mr 5,3
	la 10,.LC34@l(10)
	lfs 1,0(9)
	mtlr 0
	la 11,.LC35@l(11)
	li 4,2
	lfs 2,0(10)
	mr 3,31
	lfs 3,0(11)
	blrl
	lis 9,.LC34@ha
	lfs 0,4(30)
	la 9,.LC34@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,464(31)
.L151:
	mr 3,31
	bl NoAmmoWeaponChange
	b .L143
.L147:
	lwz 11,92(9)
	xori 9,11,29
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,34
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 4,2,.L153
	cmpwi 0,11,39
	bc 12,2,.L153
	cmpwi 0,11,48
	bc 4,2,.L152
.L153:
	bl rand
	andi. 0,3,15
	bc 4,2,.L143
.L152:
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	cmpwi 0,9,48
	stw 9,92(11)
	bc 4,1,.L143
	lwz 9,84(31)
	li 0,16
	stw 0,92(9)
	b .L143
.L146:
	cmpwi 0,0,3
	bc 4,2,.L143
	lwz 0,92(9)
	cmpwi 0,0,5
	bc 4,2,.L157
	lis 29,gi@ha
	lis 3,.LC31@ha
	la 29,gi@l(29)
	la 3,.LC31@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC34@ha
	lis 10,.LC34@ha
	lis 11,.LC35@ha
	mr 5,3
	la 9,.LC34@l(9)
	la 10,.LC34@l(10)
	mtlr 0
	la 11,.LC35@l(11)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L157:
	lwz 10,84(31)
	lwz 0,92(10)
	cmpwi 0,0,11
	bc 4,2,.L158
	lis 9,.LC35@ha
	lfs 13,3760(10)
	la 9,.LC35@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L159
	lis 9,level+4@ha
	lis 11,.LC36@ha
	lfs 0,level+4@l(9)
	la 11,.LC36@l(11)
	lis 3,.LC33@ha
	lfd 12,0(11)
	lis 9,gi+36@ha
	la 3,.LC33@l(3)
	lis 11,.LC32@ha
	lfd 13,.LC32@l(11)
	fadd 0,0,12
	fadd 0,0,13
	frsp 0,0
	stfs 0,3760(10)
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 3,3768(9)
.L159:
	lwz 11,84(31)
	lwz 0,3756(11)
	cmpwi 0,0,0
	bc 4,2,.L160
	lis 9,level+4@ha
	lfs 13,3760(11)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L160
	stw 0,3768(11)
	mr 3,31
	li 4,1
	crxor 6,6,6
	bl weapon_grenade_fire
	lwz 9,84(31)
	li 0,1
	stw 0,3756(9)
.L160:
	lwz 11,84(31)
	lwz 0,3548(11)
	andi. 10,0,1
	bc 4,2,.L143
	lwz 0,3756(11)
	cmpwi 0,0,0
	bc 12,2,.L158
	lis 9,level+4@ha
	lfs 13,3760(11)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L143
	li 0,15
	stw 0,92(11)
	lwz 9,84(31)
	stw 10,3756(9)
.L158:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,12
	bc 4,2,.L165
	li 0,0
	mr 3,31
	stw 0,3768(9)
	li 4,0
	crxor 6,6,6
	bl weapon_grenade_fire
.L165:
	lwz 11,84(31)
	lwz 10,92(11)
	cmpwi 0,10,15
	bc 4,2,.L166
	lis 9,level+4@ha
	lfs 13,3760(11)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 12,0,.L143
.L166:
	addi 0,10,1
	stw 0,92(11)
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,16
	bc 4,2,.L143
	li 0,0
	li 11,0
	stw 0,3760(9)
	lwz 9,84(31)
	stw 11,3600(9)
.L143:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 Weapon_Grenadex,.Lfe7-Weapon_Grenadex
	.section	".rodata"
	.align 3
.LC37:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC38:
	.long 0xc0000000
	.align 2
.LC39:
	.long 0x43200000
	.align 2
.LC40:
	.long 0x40200000
	.section	".text"
	.align 2
	.globl weapon_grenadelauncher_fire
	.type	 weapon_grenadelauncher_fire,@function
weapon_grenadelauncher_fire:
	stwu 1,-128(1)
	mflr 0
	stmw 26,104(1)
	stw 0,132(1)
	mr 31,3
	lwz 11,508(31)
	lis 7,0x4330
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lwz 3,84(31)
	lis 0,0x4100
	addi 11,11,-8
	lfd 13,0(9)
	xoris 11,11,0x8000
	lis 9,is_quad@ha
	stw 0,12(1)
	stw 11,100(1)
	stw 7,96(1)
	lfd 0,96(1)
	lwz 10,is_quad@l(9)
	stw 0,8(1)
	fsub 0,0,13
	addic 10,10,-1
	subfe 10,10,10
	nor 0,10,10
	rlwinm 0,0,0,23,26
	rlwinm 10,10,0,25,28
	frsp 0,0
	or 28,10,0
	stfs 0,16(1)
	lwz 0,3848(3)
	cmpwi 0,0,0
	bc 12,2,.L170
	lwz 3,3844(3)
	addi 0,1,24
	addi 5,1,40
	mr 4,0
	li 6,0
	addi 3,3,16
	mr 30,0
	bl AngleVectors
	b .L171
.L170:
	addi 0,1,24
	addi 3,3,3668
	mr 4,0
	addi 5,1,40
	li 6,0
	mr 30,0
	bl AngleVectors
.L171:
	lfs 0,8(1)
	addi 9,1,8
	addi 3,31,4
	lwz 11,84(31)
	mr 27,3
	addi 10,1,72
	stfs 0,72(1)
	lfs 13,4(9)
	stfs 13,76(1)
	lfs 0,8(9)
	stfs 0,80(1)
	lwz 0,716(11)
	cmpwi 0,0,1
	bc 4,2,.L172
	fneg 0,13
	stfs 0,76(1)
	b .L173
.L172:
	cmpwi 0,0,2
	bc 4,2,.L173
	li 0,0
	stw 0,4(10)
.L173:
	addi 7,1,56
	addi 4,1,72
	mr 29,7
	addi 5,1,24
	addi 6,1,40
	mr 26,29
	bl G_ProjectSource
	lis 9,.LC38@ha
	lwz 4,84(31)
	mr 3,30
	la 9,.LC38@l(9)
	lfs 1,0(9)
	addi 4,4,3616
	bl VectorScale
	lis 9,.LC39@ha
	lis 0,0xbf80
	la 9,.LC39@l(9)
	mr 4,29
	lfs 2,0(9)
	mr 5,30
	mr 6,28
	lwz 9,84(31)
	mr 3,31
	li 7,600
	stw 0,3604(9)
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 1,0(9)
	bl fire_grenade
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,84(31)
	lwz 11,3844(9)
	cmpwi 0,11,0
	bc 12,2,.L176
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 10
	subf 3,3,11
	mullw 3,3,0
	srawi 3,3,2
	blrl
	b .L177
.L176:
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 11,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 11
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
.L177:
	lis 9,gi@ha
	lis 11,is_silenced@ha
	la 29,gi@l(9)
	lbz 3,is_silenced@l(11)
	lwz 9,100(29)
	ori 3,3,8
	mtlr 9
	blrl
	lwz 9,84(31)
	lwz 3,3844(9)
	cmpwi 0,3,0
	bc 12,2,.L178
	lwz 0,88(29)
	addi 3,3,4
	li 4,2
	mtlr 0
	blrl
	b .L179
.L178:
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
.L179:
	lwz 11,84(31)
	mr 4,26
	mr 3,31
	li 5,1
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	bl PlayerNoise
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,96(1)
	lwz 11,100(1)
	andi. 0,11,8192
	bc 4,2,.L180
	lwz 9,84(31)
	lwz 0,3544(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	addi 11,11,-1
	stwx 11,9,0
.L180:
	lwz 0,132(1)
	mtlr 0
	lmw 26,104(1)
	la 1,128(1)
	blr
.Lfe8:
	.size	 weapon_grenadelauncher_fire,.Lfe8-weapon_grenadelauncher_fire
	.section	".data"
	.align 2
	.type	 pause_frames.42,@object
pause_frames.42:
	.long 34
	.long 51
	.long 59
	.long 0
	.align 2
	.type	 fire_frames.43,@object
fire_frames.43:
	.long 6
	.long 0
	.section	".rodata"
	.align 2
.LC41:
	.long 0x46fffe00
	.align 3
.LC42:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC43:
	.long 0x40340000
	.long 0x0
	.align 2
.LC44:
	.long 0xc0000000
	.align 2
.LC45:
	.long 0x42f00000
	.section	".text"
	.align 2
	.globl Weapon_RocketLauncher_Fire
	.type	 Weapon_RocketLauncher_Fire,@function
Weapon_RocketLauncher_Fire:
	stwu 1,-144(1)
	mflr 0
	stmw 25,116(1)
	stw 0,148(1)
	mr 31,3
	li 25,120
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,108(1)
	lis 9,.LC42@ha
	lis 8,.LC41@ha
	stw 0,104(1)
	la 9,.LC42@l(9)
	lis 10,.LC43@ha
	lfd 0,0(9)
	la 10,.LC43@l(10)
	lfd 13,104(1)
	mr 9,11
	lfs 11,.LC41@l(8)
	lfd 10,0(10)
	fsub 13,13,0
	lis 10,is_quad@ha
	lwz 0,is_quad@l(10)
	frsp 13,13
	cmpwi 0,0,0
	fdivs 13,13,11
	fmr 0,13
	fmul 0,0,10
	fctiwz 12,0
	stfd 12,104(1)
	lwz 9,108(1)
	addi 30,9,100
	bc 12,2,.L183
	slwi 30,30,2
	li 25,480
.L183:
	lwz 3,84(31)
	lwz 0,3848(3)
	cmpwi 0,0,0
	bc 12,2,.L184
	lwz 3,3844(3)
	addi 0,1,40
	addi 5,1,56
	mr 4,0
	li 6,0
	addi 3,3,16
	mr 28,0
	bl AngleVectors
	b .L185
.L184:
	addi 0,1,40
	addi 3,3,3668
	mr 4,0
	addi 5,1,56
	li 6,0
	mr 28,0
	bl AngleVectors
.L185:
	lis 9,.LC44@ha
	lwz 4,84(31)
	mr 3,28
	la 9,.LC44@l(9)
	lfs 1,0(9)
	addi 4,4,3616
	bl VectorScale
	lwz 9,84(31)
	lis 0,0xbf80
	lis 8,0x4330
	lis 10,.LC42@ha
	stw 0,3604(9)
	la 10,.LC42@l(10)
	addi 3,31,4
	lwz 9,508(31)
	lis 0,0x4100
	addi 7,1,72
	lfd 13,0(10)
	mr 27,3
	addi 9,9,-8
	stw 0,72(1)
	addi 10,1,8
	xoris 9,9,0x8000
	stw 0,8(1)
	stw 9,108(1)
	stw 8,104(1)
	lfd 0,104(1)
	stw 0,12(1)
	lwz 9,84(31)
	fsub 0,0,13
	frsp 0,0
	stfs 0,16(1)
	lfs 13,4(10)
	stfs 13,76(1)
	lfs 0,8(10)
	stfs 0,80(1)
	lwz 0,716(9)
	cmpwi 0,0,1
	bc 4,2,.L186
	fneg 0,13
	stfs 0,76(1)
	b .L187
.L186:
	cmpwi 0,0,2
	bc 4,2,.L187
	li 0,0
	stw 0,4(7)
.L187:
	addi 7,1,24
	addi 4,1,72
	mr 29,7
	addi 5,1,40
	addi 6,1,56
	mr 26,29
	bl G_ProjectSource
	lis 9,.LC45@ha
	mr 4,29
	la 9,.LC45@l(9)
	mr 8,25
	lfs 1,0(9)
	mr 5,28
	mr 6,30
	mr 3,31
	li 7,650
	bl fire_rocket
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,84(31)
	lwz 11,3844(9)
	cmpwi 0,11,0
	bc 12,2,.L190
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 10
	subf 3,3,11
	mullw 3,3,0
	srawi 3,3,2
	blrl
	b .L191
.L190:
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 11,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 11
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
.L191:
	lis 9,gi@ha
	lis 11,is_silenced@ha
	la 29,gi@l(9)
	lbz 3,is_silenced@l(11)
	lwz 9,100(29)
	ori 3,3,7
	mtlr 9
	blrl
	lwz 9,84(31)
	lwz 3,3844(9)
	cmpwi 0,3,0
	bc 12,2,.L192
	lwz 0,88(29)
	addi 3,3,4
	li 4,2
	mtlr 0
	blrl
	b .L193
.L192:
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
.L193:
	lwz 11,84(31)
	mr 4,26
	mr 3,31
	li 5,1
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	bl PlayerNoise
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,104(1)
	lwz 11,108(1)
	andi. 0,11,8192
	bc 4,2,.L194
	lwz 9,84(31)
	lwz 0,3544(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	addi 11,11,-1
	stwx 11,9,0
.L194:
	lwz 0,148(1)
	mtlr 0
	lmw 25,116(1)
	la 1,144(1)
	blr
.Lfe9:
	.size	 Weapon_RocketLauncher_Fire,.Lfe9-Weapon_RocketLauncher_Fire
	.section	".data"
	.align 2
	.type	 pause_frames.50,@object
pause_frames.50:
	.long 25
	.long 33
	.long 42
	.long 50
	.long 0
	.align 2
	.type	 fire_frames.51,@object
fire_frames.51:
	.long 5
	.long 0
	.section	".rodata"
	.align 3
.LC46:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC47:
	.long 0x41c00000
	.align 2
.LC48:
	.long 0x41000000
	.align 2
.LC49:
	.long 0xc0000000
	.section	".text"
	.align 2
	.globl Blaster_Fire
	.type	 Blaster_Fire,@function
Blaster_Fire:
	stwu 1,-144(1)
	mflr 0
	stmw 25,116(1)
	stw 0,148(1)
	mr 31,3
	lis 11,is_quad@ha
	lwz 3,84(31)
	slwi 9,5,2
	mr 29,4
	lwz 0,is_quad@l(11)
	mr 27,6
	mr 28,7
	lwz 11,3848(3)
	addic 0,0,-1
	subfe 0,0,0
	cmpwi 0,11,0
	andc 9,9,0
	and 5,5,0
	or 30,5,9
	bc 12,2,.L198
	lwz 3,3844(3)
	addi 4,1,8
	addi 5,1,24
	li 6,0
	addi 3,3,16
	bl AngleVectors
	b .L199
.L198:
	addi 3,3,3668
	addi 4,1,8
	addi 5,1,24
	li 6,0
	bl AngleVectors
.L199:
	lis 10,.LC46@ha
	lwz 9,508(31)
	la 10,.LC46@l(10)
	lfs 13,0(29)
	lis 0,0x4330
	lfd 10,0(10)
	addi 9,9,-8
	addi 3,31,4
	lis 10,.LC47@ha
	lfs 0,4(29)
	xoris 9,9,0x8000
	la 10,.LC47@l(10)
	stw 9,108(1)
	mr 26,3
	lfs 12,0(10)
	addi 5,1,8
	lis 10,.LC48@ha
	stw 0,104(1)
	la 10,.LC48@l(10)
	lfs 9,8(29)
	lfs 11,0(10)
	fadds 13,13,12
	lwz 9,84(31)
	addi 10,1,72
	fadds 12,0,11
	stfs 13,72(1)
	lfd 0,104(1)
	stfs 13,56(1)
	stfs 12,60(1)
	fsub 0,0,10
	stfs 12,76(1)
	frsp 0,0
	fadds 0,0,9
	stfs 0,80(1)
	stfs 0,64(1)
	lwz 0,716(9)
	cmpwi 0,0,1
	bc 4,2,.L200
	fneg 0,12
	stfs 0,76(1)
	b .L201
.L200:
	cmpwi 0,0,2
	bc 4,2,.L201
	li 0,0
	stw 0,4(10)
.L201:
	addi 7,1,40
	addi 4,1,72
	mr 29,7
	addi 6,1,24
	bl G_ProjectSource
	mr 25,29
	lis 9,.LC49@ha
	lwz 4,84(31)
	addi 3,1,8
	la 9,.LC49@l(9)
	lfs 1,0(9)
	addi 4,4,3616
	bl VectorScale
	lwz 11,84(31)
	lis 0,0xbf80
	mr 9,27
	mr 4,29
	mr 8,28
	stw 0,3604(11)
	mr 6,30
	mr 3,31
	addi 5,1,8
	li 7,1000
	bl fire_blaster
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,84(31)
	lwz 11,3844(9)
	cmpwi 0,11,0
	bc 12,2,.L204
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 10
	subf 3,3,11
	mullw 3,3,0
	srawi 3,3,2
	blrl
	b .L205
.L204:
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 11,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 11
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
.L205:
	cmpwi 0,27,0
	bc 12,2,.L206
	lis 9,is_silenced@ha
	lis 11,gi+100@ha
	lbz 3,is_silenced@l(9)
	lwz 0,gi+100@l(11)
	ori 3,3,14
	mtlr 0
	blrl
	b .L207
.L206:
	lis 9,gi+100@ha
	lis 11,is_silenced@ha
	lwz 0,gi+100@l(9)
	lbz 3,is_silenced@l(11)
	mtlr 0
	blrl
.L207:
	lwz 9,84(31)
	lwz 3,3844(9)
	cmpwi 0,3,0
	bc 12,2,.L208
	lis 9,gi+88@ha
	addi 3,3,4
	lwz 0,gi+88@l(9)
	li 4,2
	mtlr 0
	blrl
	b .L209
.L208:
	lis 9,gi+88@ha
	mr 3,26
	lwz 0,gi+88@l(9)
	li 4,2
	mtlr 0
	blrl
.L209:
	mr 3,31
	mr 4,25
	li 5,1
	bl PlayerNoise
	lwz 0,148(1)
	mtlr 0
	lmw 25,116(1)
	la 1,144(1)
	blr
.Lfe10:
	.size	 Blaster_Fire,.Lfe10-Blaster_Fire
	.section	".data"
	.align 2
	.type	 pause_frames.61,@object
pause_frames.61:
	.long 19
	.long 32
	.long 0
	.align 2
	.type	 fire_frames.62,@object
fire_frames.62:
	.long 5
	.long 0
	.section	".rodata"
	.align 2
.LC50:
	.string	"weapons/hyprbl1a.wav"
	.align 2
.LC52:
	.string	"weapons/hyprbd1a.wav"
	.align 3
.LC51:
	.long 0x400921fb
	.long 0x54442d18
	.align 2
.LC53:
	.long 0x3f800000
	.align 2
.LC54:
	.long 0x0
	.align 3
.LC55:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC56:
	.long 0x40180000
	.long 0x0
	.align 3
.LC57:
	.long 0xc0100000
	.long 0x0
	.align 3
.LC58:
	.long 0x40100000
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_HyperBlaster_Fire
	.type	 Weapon_HyperBlaster_Fire,@function
Weapon_HyperBlaster_Fire:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 29,52(1)
	stw 0,84(1)
	lis 9,gi@ha
	mr 31,3
	la 29,gi@l(9)
	lis 3,.LC50@ha
	lwz 9,36(29)
	la 3,.LC50@l(3)
	mtlr 9
	blrl
	lwz 9,84(31)
	stw 3,3768(9)
	lwz 10,84(31)
	lwz 0,3548(10)
	andi. 9,0,1
	bc 4,2,.L215
	lwz 9,92(10)
	addi 9,9,1
	stw 9,92(10)
	b .L216
.L215:
	lwz 0,3544(10)
	addi 11,10,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L217
	lis 9,level@ha
	lfs 13,464(31)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L218
	lwz 9,36(29)
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	mtlr 9
	blrl
	lis 9,.LC53@ha
	lwz 0,16(29)
	lis 11,.LC53@ha
	la 9,.LC53@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC53@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC54@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC54@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC53@ha
	lfs 0,4(30)
	la 9,.LC53@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,464(31)
.L218:
	mr 3,31
	bl NoAmmoWeaponChange
	b .L219
.L217:
	lwz 9,92(10)
	lis 0,0x4330
	lis 11,.LC55@ha
	la 11,.LC55@l(11)
	addi 9,9,-5
	lfd 11,0(11)
	add 9,9,9
	lis 11,.LC51@ha
	xoris 9,9,0x8000
	lfd 13,.LC51@l(11)
	stw 9,44(1)
	lis 11,.LC56@ha
	stw 0,40(1)
	la 11,.LC56@l(11)
	lfd 0,40(1)
	lfd 12,0(11)
	lis 11,.LC54@ha
	fsub 0,0,11
	la 11,.LC54@l(11)
	lfs 30,0(11)
	fmul 0,0,13
	fdiv 0,0,12
	frsp 0,0
	fmr 31,0
	fmr 1,31
	bl sin
	lis 9,.LC57@ha
	stfs 30,12(1)
	la 9,.LC57@l(9)
	lfd 13,0(9)
	fmul 0,1,13
	fmr 1,31
	frsp 0,0
	stfs 0,8(1)
	bl cos
	lis 9,.LC58@ha
	lwz 10,84(31)
	mr 3,31
	la 9,.LC58@l(9)
	addi 4,1,8
	lfd 0,0(9)
	li 6,1
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,16(1)
	lfs 0,20(11)
	lwz 7,92(10)
	fcmpu 7,0,30
	xori 0,7,9
	subfic 11,0,0
	adde 0,11,0
	xori 7,7,6
	subfic 9,7,0
	adde 7,9,7
	or 7,7,0
	slwi 7,7,6
	mfcr 5
	rlwinm 5,5,31,1
	neg 5,5
	nor 0,5,5
	andi. 5,5,20
	rlwinm 0,0,0,28,31
	or 5,5,0
	bl Blaster_Fire
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,40(1)
	lwz 11,44(1)
	andi. 0,11,8192
	bc 4,2,.L224
	lwz 9,84(31)
	lwz 0,3544(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	addi 11,11,-1
	stwx 11,9,0
.L224:
	lwz 9,84(31)
	li 0,4
	stw 0,3728(9)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L225
	li 0,159
	li 9,168
	b .L229
.L225:
	li 0,45
	li 9,53
.L229:
	stw 0,56(31)
	stw 9,3724(11)
.L219:
	lwz 9,84(31)
	lwz 11,92(9)
	addi 11,11,1
	stw 11,92(9)
	lwz 10,84(31)
	lwz 0,92(10)
	cmpwi 0,0,12
	bc 4,2,.L228
	lwz 0,3544(10)
	addi 11,10,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L216
	li 0,6
	stw 0,92(10)
.L216:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,12
	bc 4,2,.L228
	lis 29,gi@ha
	lis 3,.LC52@ha
	la 29,gi@l(29)
	la 3,.LC52@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC53@ha
	lwz 0,16(29)
	lis 11,.LC53@ha
	la 9,.LC53@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC53@l(11)
	mtlr 0
	li 4,0
	lis 9,.LC54@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC54@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,84(31)
	li 0,0
	stw 0,3768(9)
.L228:
	lwz 0,84(1)
	mtlr 0
	lmw 29,52(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe11:
	.size	 Weapon_HyperBlaster_Fire,.Lfe11-Weapon_HyperBlaster_Fire
	.section	".data"
	.align 2
	.type	 pause_frames.69,@object
pause_frames.69:
	.long 0
	.align 2
	.type	 fire_frames.70,@object
fire_frames.70:
	.long 6
	.long 7
	.long 8
	.long 9
	.long 10
	.long 11
	.long 0
	.section	".rodata"
	.align 2
.LC59:
	.long 0x46fffe00
	.align 3
.LC60:
	.long 0x3fd66666
	.long 0x66666666
	.align 3
.LC61:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC62:
	.long 0x3f800000
	.align 2
.LC63:
	.long 0x0
	.align 3
.LC64:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC65:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC66:
	.long 0xbff80000
	.long 0x0
	.align 3
.LC67:
	.long 0x3fd00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Machinegun_Fire
	.type	 Machinegun_Fire,@function
Machinegun_Fire:
	stwu 1,-208(1)
	mflr 0
	stfd 27,168(1)
	stfd 28,176(1)
	stfd 29,184(1)
	stfd 30,192(1)
	stfd 31,200(1)
	stmw 21,124(1)
	stw 0,212(1)
	mr 31,3
	li 27,8
	lwz 9,84(31)
	lwz 0,3548(9)
	andi. 0,0,1
	bc 4,2,.L232
	stw 0,3720(9)
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L231
.L232:
	lwz 0,92(9)
	cmpwi 0,0,5
	li 0,5
	bc 4,2,.L233
	li 0,4
.L233:
	stw 0,92(9)
	lwz 10,84(31)
	lwz 0,3544(10)
	addi 11,10,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L235
	li 0,6
	lis 9,level@ha
	stw 0,92(10)
	la 30,level@l(9)
	lfs 13,4(30)
	lfs 0,464(31)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L236
	lis 29,gi@ha
	lis 3,.LC20@ha
	la 29,gi@l(29)
	la 3,.LC20@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC62@ha
	lis 9,.LC62@ha
	lis 10,.LC63@ha
	la 8,.LC62@l(8)
	mr 5,3
	la 9,.LC62@l(9)
	lfs 1,0(8)
	mtlr 0
	la 10,.LC63@l(10)
	li 4,2
	lfs 2,0(9)
	mr 3,31
	lfs 3,0(10)
	blrl
	lis 8,.LC62@ha
	lfs 0,4(30)
	la 8,.LC62@l(8)
	lfs 13,0(8)
	fadds 0,0,13
	stfs 0,464(31)
.L236:
	mr 3,31
	bl NoAmmoWeaponChange
	b .L231
.L235:
	lis 9,is_quad@ha
	lwz 0,is_quad@l(9)
	cmpwi 0,0,0
	bc 12,2,.L237
	slwi 27,27,2
.L237:
	lis 9,.LC59@ha
	lis 8,.LC64@ha
	lfs 29,.LC59@l(9)
	lis 11,.LC60@ha
	lis 10,.LC61@ha
	lis 9,.LC65@ha
	la 8,.LC64@l(8)
	lfd 27,.LC60@l(11)
	la 9,.LC65@l(9)
	lfd 28,.LC61@l(10)
	addi 24,1,56
	lfd 30,0(8)
	addi 26,1,24
	addi 25,1,40
	lfd 31,0(9)
	addi 22,1,88
	addi 23,31,4
	addi 21,1,8
	lis 28,0x4330
	li 29,4
	li 30,2
.L241:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,84(31)
	xoris 3,3,0x8000
	stw 3,116(1)
	addi 11,11,3616
	stw 28,112(1)
	lfd 13,112(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmul 0,0,27
	frsp 0,0
	stfsx 0,11,29
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,84(31)
	xoris 3,3,0x8000
	addic. 30,30,-1
	stw 3,116(1)
	addi 11,11,3604
	stw 28,112(1)
	lfd 13,112(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmul 0,0,28
	frsp 0,0
	stfsx 0,11,29
	addi 29,29,4
	bc 4,2,.L241
	bl rand
	rlwinm 3,3,0,17,31
	lwz 6,84(31)
	xoris 3,3,0x8000
	lis 7,0x4330
	stw 3,116(1)
	lis 8,.LC64@ha
	lis 10,.LC59@ha
	stw 7,112(1)
	la 8,.LC64@l(8)
	lis 11,.LC65@ha
	lfd 9,0(8)
	la 11,.LC65@l(11)
	lfd 13,112(1)
	lis 8,.LC60@ha
	lfs 10,.LC59@l(10)
	lfd 11,0(11)
	lis 10,.LC63@ha
	fsub 13,13,9
	lfd 12,.LC60@l(8)
	mr 11,9
	la 10,.LC63@l(10)
	lis 9,.LC66@ha
	lfs 7,0(10)
	la 9,.LC66@l(9)
	frsp 13,13
	lfd 8,0(9)
	lis 9,deathmatch@ha
	lwz 10,deathmatch@l(9)
	fdivs 13,13,10
	fmr 0,13
	fsub 0,0,11
	fadd 0,0,0
	fmul 0,0,12
	frsp 0,0
	stfs 0,3616(6)
	lwz 9,84(31)
	lwz 0,3720(9)
	xoris 0,0,0x8000
	stw 0,116(1)
	stw 7,112(1)
	lfd 0,112(1)
	fsub 0,0,9
	fmul 0,0,8
	frsp 0,0
	stfs 0,3604(9)
	lfs 13,20(10)
	fcmpu 0,13,7
	bc 4,2,.L243
	lwz 9,84(31)
	lwz 11,3720(9)
	addi 11,11,1
	stw 11,3720(9)
	lwz 9,84(31)
	lwz 0,3720(9)
	cmpwi 0,0,9
	bc 4,1,.L243
	li 0,9
	stw 0,3720(9)
.L243:
	lwz 11,84(31)
	lwz 0,3848(11)
	cmpwi 0,0,0
	bc 12,2,.L245
	lwz 9,3844(11)
	lfs 13,3604(11)
	lfs 0,16(9)
	fadds 0,0,13
	stfs 0,56(1)
	lwz 9,3844(11)
	lfs 13,3608(11)
	lfs 0,20(9)
	fadds 0,0,13
	stfs 0,60(1)
	lwz 9,3844(11)
	lfs 13,3612(11)
	lfs 0,24(9)
	fadds 0,0,13
	b .L259
.L245:
	lfs 13,3604(11)
	lfs 0,3668(11)
	fadds 0,0,13
	stfs 0,56(1)
	lfs 0,3608(11)
	lfs 13,3672(11)
	fadds 13,13,0
	stfs 13,60(1)
	lfs 12,3612(11)
	lfs 0,3676(11)
	fadds 0,0,12
.L259:
	stfs 0,64(1)
	mr 3,24
	mr 5,25
	mr 4,26
	li 6,0
	bl AngleVectors
	lwz 9,508(31)
	lis 10,0x4330
	lis 8,.LC64@ha
	lis 0,0x4100
	addi 9,9,-8
	la 8,.LC64@l(8)
	xoris 9,9,0x8000
	lfd 13,0(8)
	li 7,0
	stw 9,116(1)
	stw 10,112(1)
	lfd 0,112(1)
	lwz 8,84(31)
	stw 7,72(1)
	fsub 0,0,13
	stw 0,92(1)
	stw 0,76(1)
	stw 7,88(1)
	frsp 0,0
	stfs 0,96(1)
	stfs 0,80(1)
	lwz 0,716(8)
	cmpwi 0,0,1
	bc 4,2,.L247
	lis 0,0xc100
	stw 0,92(1)
	b .L248
.L247:
	cmpwi 0,0,2
	bc 4,2,.L248
	stw 7,4(22)
.L248:
	addi 4,1,88
	addi 5,1,24
	addi 6,1,40
	mr 7,21
	mr 3,23
	bl G_ProjectSource
	li 9,69
	li 8,500
	mr 5,26
	mr 6,27
	addi 4,1,8
	li 7,300
	mr 3,31
	crxor 6,6,6
	bl fire_matrix_bullet
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,84(31)
	lwz 11,3844(9)
	cmpwi 0,11,0
	bc 12,2,.L251
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 10
	subf 3,3,11
	mullw 3,3,0
	srawi 3,3,2
	blrl
	b .L252
.L251:
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 11,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 11
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
.L252:
	lis 9,gi@ha
	lis 11,is_silenced@ha
	la 29,gi@l(9)
	lbz 3,is_silenced@l(11)
	lwz 9,100(29)
	ori 3,3,1
	mtlr 9
	blrl
	lwz 9,84(31)
	lwz 3,3844(9)
	cmpwi 0,3,0
	bc 12,2,.L253
	lwz 0,88(29)
	addi 3,3,4
	li 4,2
	mtlr 0
	blrl
	b .L254
.L253:
	lwz 0,88(29)
	mr 3,23
	li 4,2
	mtlr 0
	blrl
.L254:
	mr 3,31
	addi 4,1,8
	li 5,1
	bl PlayerNoise
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,112(1)
	lwz 11,116(1)
	andi. 0,11,8192
	bc 4,2,.L255
	lwz 9,84(31)
	lwz 0,3544(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	addi 11,11,-1
	stwx 11,9,0
.L255:
	lwz 11,84(31)
	li 0,4
	stw 0,3728(11)
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 8,0,1
	bc 12,2,.L256
	bl rand
	rlwinm 3,3,0,17,31
	lwz 8,84(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,116(1)
	lis 9,.LC64@ha
	lis 10,.LC59@ha
	stw 0,112(1)
	la 9,.LC64@l(9)
	lfd 13,0(9)
	li 0,168
	lfd 0,112(1)
	lis 9,.LC67@ha
	lfs 11,.LC59@l(10)
	la 9,.LC67@l(9)
	lfd 10,0(9)
	fsub 0,0,13
	mr 9,11
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fadd 13,13,10
	fctiwz 12,13
	stfd 12,112(1)
	lwz 9,116(1)
	subfic 9,9,160
	b .L260
.L256:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 8,84(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,116(1)
	lis 9,.LC64@ha
	lis 10,.LC59@ha
	stw 0,112(1)
	la 9,.LC64@l(9)
	lfd 13,0(9)
	li 0,53
	lfd 0,112(1)
	lis 9,.LC67@ha
	lfs 11,.LC59@l(10)
	la 9,.LC67@l(9)
	lfd 10,0(9)
	fsub 0,0,13
	mr 9,11
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fadd 13,13,10
	fctiwz 12,13
	stfd 12,112(1)
	lwz 9,116(1)
	subfic 9,9,46
.L260:
	stw 9,56(31)
	stw 0,3724(8)
.L231:
	lwz 0,212(1)
	mtlr 0
	lmw 21,124(1)
	lfd 27,168(1)
	lfd 28,176(1)
	lfd 29,184(1)
	lfd 30,192(1)
	lfd 31,200(1)
	la 1,208(1)
	blr
.Lfe12:
	.size	 Machinegun_Fire,.Lfe12-Machinegun_Fire
	.section	".data"
	.align 2
	.type	 pause_frames.77,@object
pause_frames.77:
	.long 23
	.long 45
	.long 0
	.align 2
	.type	 fire_frames.78,@object
fire_frames.78:
	.long 4
	.long 5
	.long 0
	.section	".rodata"
	.align 2
.LC68:
	.long 0x46fffe00
	.align 2
.LC69:
	.long 0x0
	.align 2
.LC70:
	.long 0xc0000000
	.align 3
.LC71:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC72:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC73:
	.long 0x40200000
	.long 0x0
	.align 2
.LC74:
	.long 0x447a0000
	.section	".text"
	.align 2
	.globl L33T_weapon_bfg_fire
	.type	 L33T_weapon_bfg_fire,@function
L33T_weapon_bfg_fire:
	stwu 1,-112(1)
	mflr 0
	stmw 28,96(1)
	stw 0,116(1)
	lis 9,deathmatch@ha
	lis 10,.LC69@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC69@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	lwz 3,84(31)
	fcmpu 7,0,13
	lwz 10,92(3)
	cmpwi 6,10,9
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	nor 9,0,0
	andi. 0,0,500
	andi. 9,9,200
	or 8,0,9
	bc 4,26,.L265
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,84(31)
	lwz 11,3844(9)
	cmpwi 0,11,0
	bc 12,2,.L266
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 10
	subf 3,3,11
	mullw 3,3,0
	srawi 3,3,2
	blrl
	b .L267
.L266:
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 11,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 11
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
.L267:
	lis 9,gi@ha
	lis 11,is_silenced@ha
	la 29,gi@l(9)
	lbz 3,is_silenced@l(11)
	lwz 9,100(29)
	ori 3,3,12
	mtlr 9
	blrl
	lwz 9,84(31)
	lwz 3,3844(9)
	cmpwi 0,3,0
	bc 12,2,.L268
	lwz 0,88(29)
	addi 3,3,4
	li 4,2
	mtlr 0
	blrl
	b .L269
.L268:
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
.L269:
	lwz 11,84(31)
	mr 3,31
	addi 4,1,24
	li 5,1
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	bl PlayerNoise
	b .L262
.L265:
	lwz 0,3544(3)
	addi 11,3,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,49
	bc 12,1,.L270
	addi 0,10,1
	stw 0,92(3)
	b .L262
.L270:
	lis 11,is_quad@ha
	lwz 10,3848(3)
	slwi 9,8,2
	lwz 0,is_quad@l(11)
	cmpwi 0,10,0
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 28,0,9
	bc 12,2,.L272
	lwz 3,3844(3)
	addi 0,1,40
	addi 5,1,56
	mr 4,0
	li 6,0
	addi 3,3,16
	mr 30,0
	bl AngleVectors
	b .L273
.L272:
	addi 0,1,40
	addi 3,3,3668
	mr 4,0
	addi 5,1,56
	li 6,0
	mr 30,0
	bl AngleVectors
.L273:
	lis 9,.LC70@ha
	lwz 4,84(31)
	mr 3,30
	la 9,.LC70@l(9)
	lfs 1,0(9)
	addi 4,4,3616
	bl VectorScale
	lwz 9,84(31)
	lis 0,0xc220
	stw 0,3632(9)
	bl rand
	rlwinm 3,3,0,17,31
	lwz 5,84(31)
	xoris 3,3,0x8000
	lis 6,0x4330
	stw 3,92(1)
	lis 10,.LC71@ha
	lis 11,.LC68@ha
	stw 6,88(1)
	la 10,.LC71@l(10)
	lis 8,level+4@ha
	lfd 9,0(10)
	lis 0,0x4100
	addi 7,1,8
	lfd 13,88(1)
	lis 10,.LC72@ha
	addi 4,1,72
	lfs 12,.LC68@l(11)
	la 10,.LC72@l(10)
	addi 29,31,4
	lfd 10,0(10)
	fsub 13,13,9
	lis 10,.LC73@ha
	la 10,.LC73@l(10)
	lfd 11,0(10)
	frsp 13,13
	mr 10,9
	fdivs 13,13,12
	fmr 0,13
	fsub 0,0,10
	fadd 0,0,0
	fmul 0,0,11
	frsp 0,0
	stfs 0,3628(5)
	lfs 13,level+4@l(8)
	lwz 11,84(31)
	fadd 13,13,10
	frsp 13,13
	stfs 13,3636(11)
	lwz 9,508(31)
	stw 0,72(1)
	addi 9,9,-8
	stw 0,8(1)
	xoris 9,9,0x8000
	stw 0,12(1)
	stw 9,92(1)
	stw 6,88(1)
	lfd 0,88(1)
	lwz 9,84(31)
	fsub 0,0,9
	frsp 0,0
	stfs 0,16(1)
	lfs 13,4(7)
	stfs 13,76(1)
	lfs 0,8(7)
	stfs 0,80(1)
	lwz 0,716(9)
	cmpwi 0,0,1
	bc 4,2,.L274
	fneg 0,13
	stfs 0,76(1)
	b .L275
.L274:
	cmpwi 0,0,2
	bc 4,2,.L275
	li 0,0
	stw 0,4(4)
.L275:
	addi 7,1,24
	mr 3,29
	addi 4,1,72
	addi 5,1,40
	addi 6,1,56
	mr 29,7
	bl G_ProjectSource
	lis 9,.LC74@ha
	mr 5,30
	la 9,.LC74@l(9)
	mr 6,28
	lfs 1,0(9)
	mr 3,31
	mr 4,29
	li 7,400
	bl fire_bfg
	lwz 11,84(31)
	mr 4,29
	mr 3,31
	li 5,1
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	bl PlayerNoise
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,88(1)
	lwz 11,92(1)
	andi. 0,11,8192
	bc 4,2,.L262
	lwz 9,84(31)
	lwz 0,3544(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	addi 11,11,-1
	stwx 11,9,0
.L262:
	lwz 0,116(1)
	mtlr 0
	lmw 28,96(1)
	la 1,112(1)
	blr
.Lfe13:
	.size	 L33T_weapon_bfg_fire,.Lfe13-L33T_weapon_bfg_fire
	.section	".rodata"
	.align 2
.LC75:
	.string	"weapons/chngnu1a.wav"
	.align 2
.LC76:
	.string	"weapons/chngnd1a.wav"
	.align 2
.LC77:
	.string	"weapons/chngnl1a.wav"
	.align 2
.LC78:
	.long 0x46fffe00
	.align 3
.LC79:
	.long 0x3fd66666
	.long 0x66666666
	.align 3
.LC80:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC81:
	.long 0x0
	.align 2
.LC82:
	.long 0x3f800000
	.align 2
.LC83:
	.long 0x40000000
	.align 3
.LC84:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC85:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC86:
	.long 0x40100000
	.long 0x0
	.align 3
.LC87:
	.long 0x401c0000
	.long 0x0
	.align 2
.LC88:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl Chaingun_Fire
	.type	 Chaingun_Fire,@function
Chaingun_Fire:
	stwu 1,-192(1)
	mflr 0
	stfd 27,152(1)
	stfd 28,160(1)
	stfd 29,168(1)
	stfd 30,176(1)
	stfd 31,184(1)
	stmw 25,124(1)
	stw 0,196(1)
	lis 9,deathmatch@ha
	lis 4,.LC81@ha
	lwz 10,deathmatch@l(9)
	la 4,.LC81@l(4)
	mr 31,3
	lfs 13,0(4)
	lfs 0,20(10)
	lwz 9,84(31)
	fcmpu 7,0,13
	lwz 11,92(9)
	cmpwi 0,11,5
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	nor 9,0,0
	rlwinm 0,0,0,28,28
	rlwinm 9,9,0,29,30
	or 26,0,9
	bc 4,2,.L282
	lis 29,gi@ha
	lis 3,.LC75@ha
	la 29,gi@l(29)
	la 3,.LC75@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC82@ha
	lwz 0,16(29)
	lis 11,.LC83@ha
	la 9,.LC82@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC83@l(11)
	li 4,0
	mtlr 0
	lis 9,.LC81@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC81@l(9)
	lfs 3,0(9)
	blrl
.L282:
	lwz 9,84(31)
	lwz 0,92(9)
	mr 10,9
	cmpwi 0,0,14
	bc 4,2,.L283
	lwz 0,3548(10)
	andi. 11,0,1
	bc 4,2,.L283
	li 0,32
	stw 0,92(10)
	lwz 9,84(31)
	stw 11,3768(9)
	b .L279
.L283:
	lwz 0,92(10)
	cmpwi 0,0,21
	bc 4,2,.L285
	lwz 0,3548(10)
	andi. 4,0,1
	bc 12,2,.L285
	lwz 0,3544(10)
	addi 11,10,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L285
	li 0,15
	stw 0,92(10)
	b .L284
.L285:
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
.L284:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,22
	bc 4,2,.L287
	li 0,0
	lis 29,gi@ha
	stw 0,3768(9)
	la 29,gi@l(29)
	lis 3,.LC76@ha
	lwz 9,36(29)
	la 3,.LC76@l(3)
	mtlr 9
	blrl
	lis 9,.LC82@ha
	lwz 0,16(29)
	lis 11,.LC83@ha
	la 9,.LC82@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC83@l(11)
	li 4,0
	mtlr 0
	lis 9,.LC81@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC81@l(9)
	lfs 3,0(9)
	blrl
	b .L288
.L287:
	lis 9,gi+36@ha
	lis 3,.LC77@ha
	lwz 0,gi+36@l(9)
	la 3,.LC77@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 3,3768(9)
.L288:
	lwz 9,84(31)
	li 0,4
	stw 0,3728(9)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 4,0,1
	bc 12,2,.L289
	lwz 0,92(11)
	li 9,168
	rlwinm 0,0,0,31,31
	subfic 0,0,160
	b .L322
.L289:
	lwz 0,92(11)
	li 9,53
	rlwinm 0,0,0,31,31
	subfic 0,0,46
.L322:
	stw 0,56(31)
	stw 9,3724(11)
	lwz 9,84(31)
	lwz 0,92(9)
	mr 10,9
	cmpwi 0,0,9
	bc 12,1,.L291
	li 8,1
	b .L292
.L291:
	cmpwi 0,0,14
	bc 12,1,.L293
	lwz 0,3548(10)
	andi. 9,0,1
	mfcr 9
	rlwinm 9,9,3,1
	neg 9,9
	nor 0,9,9
	rlwinm 9,9,0,31,31
	rlwinm 0,0,0,30,30
	or 8,9,0
	b .L292
.L293:
	li 8,3
.L292:
	lwz 0,3544(10)
	addi 11,10,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpw 7,9,8
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,8,0
	or. 27,0,9
	bc 4,2,.L298
	lis 9,level@ha
	lfs 13,464(31)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L299
	lis 29,gi@ha
	lis 3,.LC20@ha
	la 29,gi@l(29)
	la 3,.LC20@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC82@ha
	lwz 0,16(29)
	lis 11,.LC82@ha
	la 9,.LC82@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC82@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC81@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC81@l(9)
	lfs 3,0(9)
	blrl
	lis 4,.LC82@ha
	lfs 0,4(30)
	la 4,.LC82@l(4)
	lfs 13,0(4)
	fadds 0,0,13
	stfs 0,464(31)
.L299:
	mr 3,31
	bl NoAmmoWeaponChange
	b .L279
.L298:
	lis 9,is_quad@ha
	lwz 0,is_quad@l(9)
	cmpwi 0,0,0
	bc 12,2,.L300
	slwi 26,26,2
.L300:
	lis 9,.LC78@ha
	lis 4,.LC84@ha
	lfs 29,.LC78@l(9)
	lis 11,.LC79@ha
	lis 10,.LC80@ha
	lis 9,.LC85@ha
	la 4,.LC84@l(4)
	lfd 27,.LC79@l(11)
	la 9,.LC85@l(9)
	lfd 30,0(4)
	addi 25,27,2
	lfd 28,.LC80@l(10)
	lis 28,0x4330
	li 29,0
	lfd 31,0(9)
	li 30,3
.L304:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,84(31)
	xoris 3,3,0x8000
	stw 3,116(1)
	addi 11,11,3616
	stw 28,112(1)
	lfd 13,112(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmul 0,0,27
	frsp 0,0
	stfsx 0,11,29
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,84(31)
	xoris 3,3,0x8000
	addic. 30,30,-1
	stw 3,116(1)
	addi 11,11,3604
	stw 28,112(1)
	lfd 13,112(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmul 0,0,28
	frsp 0,0
	stfsx 0,11,29
	addi 29,29,4
	bc 4,2,.L304
	cmpwi 0,27,0
	bc 4,1,.L307
	lis 9,.LC78@ha
	lis 4,.LC84@ha
	lfs 27,.LC78@l(9)
	lis 11,.LC86@ha
	la 4,.LC84@l(4)
	lis 9,.LC85@ha
	la 11,.LC86@l(11)
	lfd 30,0(4)
	la 9,.LC85@l(9)
	lfd 29,0(11)
	lis 29,0x4330
	lfd 28,0(9)
	mr 30,27
.L309:
	lwz 3,84(31)
	lwz 0,3848(3)
	cmpwi 0,0,0
	bc 12,2,.L310
	lwz 3,3844(3)
	addi 4,1,24
	addi 5,1,40
	li 6,0
	mr 28,4
	addi 3,3,16
	bl AngleVectors
	b .L311
.L310:
	addi 3,3,3668
	addi 4,1,24
	addi 5,1,40
	addi 6,1,56
	bl AngleVectors
	addi 28,1,24
.L311:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 4,.LC87@ha
	stw 3,116(1)
	la 4,.LC87@l(4)
	stw 29,112(1)
	lfd 13,112(1)
	lfd 12,0(4)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,27
	fmr 0,13
	fsub 0,0,28
	fadd 0,0,0
	fmadd 0,0,29,12
	frsp 31,0
	bl rand
	rlwinm 3,3,0,17,31
	lwz 0,508(31)
	xoris 3,3,0x8000
	mr 9,11
	lwz 10,84(31)
	stw 3,116(1)
	xoris 0,0,0x8000
	lis 4,.LC88@ha
	stw 29,112(1)
	la 4,.LC88@l(4)
	li 8,0
	lfd 13,112(1)
	addi 6,1,88
	addi 5,31,4
	stw 0,116(1)
	addi 7,1,8
	stw 29,112(1)
	fsub 13,13,30
	lfd 12,112(1)
	lfs 11,0(4)
	stw 8,72(1)
	frsp 13,13
	stfs 31,76(1)
	fsub 12,12,30
	stw 8,88(1)
	stfs 31,92(1)
	fdivs 13,13,27
	fmr 0,13
	frsp 12,12
	fsub 0,0,28
	fadd 0,0,0
	fmul 0,0,29
	frsp 0,0
	fadds 0,0,12
	fsubs 0,0,11
	stfs 0,96(1)
	stfs 0,80(1)
	lwz 0,716(10)
	cmpwi 0,0,1
	bc 4,2,.L312
	fneg 0,31
	stfs 0,92(1)
	b .L313
.L312:
	cmpwi 0,0,2
	bc 4,2,.L313
	stw 8,4(6)
.L313:
	mr 3,5
	addi 4,1,88
	addi 5,1,24
	addi 6,1,40
	bl G_ProjectSource
	mr 5,28
	mr 3,31
	addi 4,1,8
	mr 6,26
	li 7,300
	li 8,500
	li 9,60
	crxor 6,6,6
	bl fire_matrix_bullet
	addic. 30,30,-1
	bc 4,2,.L309
.L307:
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,84(31)
	lwz 11,3844(9)
	cmpwi 0,11,0
	bc 12,2,.L317
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 10
	subf 3,3,11
	mullw 3,3,0
	srawi 3,3,2
	blrl
	b .L318
.L317:
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 11,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 11
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
.L318:
	lis 9,gi@ha
	lis 11,is_silenced@ha
	la 29,gi@l(9)
	lbz 3,is_silenced@l(11)
	lwz 9,100(29)
	or 3,25,3
	mtlr 9
	blrl
	lwz 9,84(31)
	lwz 3,3844(9)
	cmpwi 0,3,0
	bc 12,2,.L319
	lwz 0,88(29)
	addi 3,3,4
	li 4,2
	mtlr 0
	blrl
	b .L320
.L319:
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
.L320:
	mr 3,31
	addi 4,1,8
	li 5,1
	bl PlayerNoise
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,112(1)
	lwz 11,116(1)
	andi. 0,11,8192
	bc 4,2,.L279
	lwz 9,84(31)
	lwz 11,3544(9)
	addi 9,9,740
	slwi 11,11,2
	lwzx 0,9,11
	subf 0,27,0
	stwx 0,9,11
.L279:
	lwz 0,196(1)
	mtlr 0
	lmw 25,124(1)
	lfd 27,152(1)
	lfd 28,160(1)
	lfd 29,168(1)
	lfd 30,176(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe14:
	.size	 Chaingun_Fire,.Lfe14-Chaingun_Fire
	.section	".data"
	.align 2
	.type	 pause_frames.88,@object
pause_frames.88:
	.long 38
	.long 43
	.long 51
	.long 61
	.long 0
	.align 2
	.type	 fire_frames.89,@object
fire_frames.89:
	.long 5
	.long 6
	.long 7
	.long 8
	.long 9
	.long 10
	.long 11
	.long 12
	.long 13
	.long 14
	.long 15
	.long 16
	.long 17
	.long 18
	.long 19
	.long 20
	.long 21
	.long 0
	.section	".rodata"
	.align 2
.LC89:
	.long 0xc0000000
	.align 3
.LC90:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC91:
	.long 0x0
	.section	".text"
	.align 2
	.globl weapon_shotgun_fire
	.type	 weapon_shotgun_fire,@function
weapon_shotgun_fire:
	stwu 1,-144(1)
	mflr 0
	stmw 27,124(1)
	stw 0,148(1)
	mr 30,3
	li 31,4
	lwz 3,84(30)
	li 29,8
	lwz 0,92(3)
	cmpwi 0,0,9
	bc 4,2,.L325
	li 0,10
	stw 0,92(3)
	b .L324
.L325:
	lwz 0,3848(3)
	cmpwi 0,0,0
	bc 12,2,.L326
	lwz 3,3844(3)
	addi 0,1,32
	addi 5,1,48
	mr 4,0
	li 6,0
	addi 3,3,16
	mr 28,0
	bl AngleVectors
	b .L327
.L326:
	addi 0,1,32
	addi 3,3,3668
	mr 4,0
	addi 5,1,48
	li 6,0
	mr 28,0
	bl AngleVectors
.L327:
	lis 8,.LC89@ha
	lwz 4,84(30)
	mr 3,28
	la 8,.LC89@l(8)
	lfs 1,0(8)
	addi 4,4,3616
	bl VectorScale
	lwz 9,84(30)
	lis 0,0xc000
	lis 10,0x4330
	lis 8,.LC90@ha
	stw 0,3604(9)
	la 8,.LC90@l(8)
	li 6,0
	lwz 9,508(30)
	lis 0,0x4100
	addi 3,30,4
	lfd 13,0(8)
	addi 5,1,80
	addi 7,1,16
	addi 9,9,-8
	lwz 8,84(30)
	mr 27,3
	xoris 9,9,0x8000
	stw 0,84(1)
	stw 9,116(1)
	stw 10,112(1)
	lfd 0,112(1)
	stw 6,64(1)
	stw 0,68(1)
	fsub 0,0,13
	stw 6,80(1)
	frsp 0,0
	stfs 0,88(1)
	stfs 0,72(1)
	lwz 0,716(8)
	cmpwi 0,0,1
	bc 4,2,.L328
	lis 0,0xc100
	stw 0,84(1)
	b .L329
.L328:
	cmpwi 0,0,2
	bc 4,2,.L329
	stw 6,4(5)
.L329:
	addi 4,1,80
	addi 5,1,32
	addi 6,1,48
	bl G_ProjectSource
	lis 9,is_quad@ha
	lwz 0,is_quad@l(9)
	cmpwi 0,0,0
	bc 12,2,.L332
	slwi 31,31,2
	slwi 29,29,2
.L332:
	lis 11,deathmatch@ha
	lis 8,.LC91@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC91@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L333
	li 0,33
	mr 5,28
	stw 0,8(1)
	mr 6,31
	mr 7,29
	mr 3,30
	addi 4,1,16
	li 8,500
	li 9,500
	li 10,12
	bl fire_shotgun
	b .L334
.L333:
	li 0,33
	mr 5,28
	stw 0,8(1)
	mr 6,31
	mr 7,29
	mr 3,30
	addi 4,1,16
	li 8,500
	li 9,500
	li 10,12
	bl fire_shotgun
.L334:
	lis 9,gi@ha
	li 3,1
	la 31,gi@l(9)
	lwz 9,100(31)
	mtlr 9
	blrl
	lwz 9,84(30)
	lwz 11,3844(9)
	cmpwi 0,11,0
	bc 12,2,.L335
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 10,104(31)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 10
	subf 3,3,11
	mullw 3,3,0
	srawi 3,3,2
	blrl
	b .L336
.L335:
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 11,104(31)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 11
	subf 3,3,30
	mullw 3,3,0
	srawi 3,3,2
	blrl
.L336:
	lis 9,gi@ha
	lis 11,is_silenced@ha
	la 31,gi@l(9)
	lbz 3,is_silenced@l(11)
	lwz 9,100(31)
	ori 3,3,2
	mtlr 9
	blrl
	lwz 9,84(30)
	lwz 3,3844(9)
	cmpwi 0,3,0
	bc 12,2,.L337
	lwz 0,88(31)
	addi 3,3,4
	li 4,2
	mtlr 0
	blrl
	b .L338
.L337:
	lwz 0,88(31)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
.L338:
	lwz 11,84(30)
	mr 3,30
	addi 4,1,16
	li 5,1
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	bl PlayerNoise
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,112(1)
	lwz 11,116(1)
	andi. 0,11,8192
	bc 4,2,.L324
	lwz 9,84(30)
	lwz 0,3544(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	addi 11,11,-1
	stwx 11,9,0
.L324:
	lwz 0,148(1)
	mtlr 0
	lmw 27,124(1)
	la 1,144(1)
	blr
.Lfe15:
	.size	 weapon_shotgun_fire,.Lfe15-weapon_shotgun_fire
	.section	".data"
	.align 2
	.type	 pause_frames.96,@object
pause_frames.96:
	.long 22
	.long 28
	.long 34
	.long 0
	.align 2
	.type	 fire_frames.97,@object
fire_frames.97:
	.long 8
	.long 9
	.long 0
	.section	".rodata"
	.align 2
.LC92:
	.long 0xc0000000
	.align 3
.LC93:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC94:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl weapon_supershotgun_fire
	.type	 weapon_supershotgun_fire,@function
weapon_supershotgun_fire:
	stwu 1,-144(1)
	mflr 0
	stmw 26,120(1)
	stw 0,148(1)
	mr 31,3
	li 28,6
	lwz 3,84(31)
	li 30,12
	lwz 0,3848(3)
	cmpwi 0,0,0
	bc 12,2,.L342
	lwz 3,3844(3)
	addi 0,1,32
	addi 5,1,48
	mr 4,0
	li 6,0
	addi 3,3,16
	mr 27,0
	bl AngleVectors
	b .L343
.L342:
	addi 0,1,32
	addi 3,3,3668
	mr 4,0
	addi 5,1,48
	li 6,0
	mr 27,0
	bl AngleVectors
.L343:
	lis 8,.LC92@ha
	lwz 4,84(31)
	mr 3,27
	la 8,.LC92@l(8)
	lfs 1,0(8)
	addi 4,4,3616
	bl VectorScale
	lwz 9,84(31)
	lis 0,0xc000
	lis 10,0x4330
	lis 8,.LC93@ha
	stw 0,3604(9)
	la 8,.LC93@l(8)
	li 6,0
	lwz 9,508(31)
	lis 0,0x4100
	addi 3,31,4
	lfd 13,0(8)
	addi 5,1,96
	addi 7,1,16
	addi 9,9,-8
	lwz 8,84(31)
	mr 26,3
	xoris 9,9,0x8000
	stw 0,100(1)
	stw 9,116(1)
	stw 10,112(1)
	lfd 0,112(1)
	stw 6,64(1)
	stw 0,68(1)
	fsub 0,0,13
	stw 6,96(1)
	frsp 0,0
	stfs 0,104(1)
	stfs 0,72(1)
	lwz 0,716(8)
	cmpwi 0,0,1
	bc 4,2,.L344
	lis 0,0xc100
	stw 0,100(1)
	b .L345
.L344:
	cmpwi 0,0,2
	bc 4,2,.L345
	stw 6,4(5)
.L345:
	addi 4,1,96
	addi 5,1,32
	addi 6,1,48
	bl G_ProjectSource
	lis 9,is_quad@ha
	lwz 0,is_quad@l(9)
	cmpwi 0,0,0
	bc 12,2,.L348
	slwi 28,28,2
	slwi 30,30,2
.L348:
	lwz 11,84(31)
	lwz 0,3848(11)
	cmpwi 0,0,0
	bc 12,2,.L349
	lwz 9,3844(11)
	lis 8,.LC94@ha
	la 8,.LC94@l(8)
	lfs 0,16(9)
	lfs 13,0(8)
	stfs 0,80(1)
	lwz 9,3844(11)
	lfs 0,20(9)
	fsubs 0,0,13
	stfs 0,84(1)
	lwz 9,3844(11)
	lfs 0,24(9)
	stfs 0,88(1)
	b .L350
.L349:
	lfs 13,3668(11)
	lis 9,.LC94@ha
	la 9,.LC94@l(9)
	lfs 12,0(9)
	stfs 13,80(1)
	lfs 0,3672(11)
	fsubs 0,0,12
	stfs 0,84(1)
	lfs 13,3676(11)
	stfs 13,88(1)
.L350:
	addi 29,1,80
	mr 4,27
	mr 3,29
	li 5,0
	li 6,0
	bl AngleVectors
	li 0,42
	mr 3,31
	stw 0,8(1)
	li 9,500
	addi 4,1,16
	mr 5,27
	mr 6,28
	mr 7,30
	li 8,1000
	li 10,10
	bl fire_shotgun
	lwz 9,84(31)
	mr 3,29
	lwz 0,3848(9)
	cmpwi 0,0,0
	bc 12,2,.L351
	lwz 9,3844(9)
	lis 8,.LC94@ha
	la 8,.LC94@l(8)
	lfs 0,20(9)
	lfs 13,0(8)
	b .L358
.L351:
	lfs 0,3672(9)
	lis 9,.LC94@ha
	la 9,.LC94@l(9)
	lfs 13,0(9)
.L358:
	fadds 0,0,13
	stfs 0,84(1)
	mr 4,27
	li 5,0
	li 6,0
	bl AngleVectors
	li 0,42
	li 9,500
	mr 5,27
	stw 0,8(1)
	mr 6,28
	mr 7,30
	mr 3,31
	addi 4,1,16
	li 8,1000
	li 10,10
	bl fire_shotgun
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,84(31)
	lwz 11,3844(9)
	cmpwi 0,11,0
	bc 12,2,.L353
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 10
	subf 3,3,11
	mullw 3,3,0
	srawi 3,3,2
	blrl
	b .L354
.L353:
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 11,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 11
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
.L354:
	lis 9,gi@ha
	lis 11,is_silenced@ha
	la 29,gi@l(9)
	lbz 3,is_silenced@l(11)
	lwz 9,100(29)
	ori 3,3,13
	mtlr 9
	blrl
	lwz 9,84(31)
	lwz 3,3844(9)
	cmpwi 0,3,0
	bc 12,2,.L355
	lwz 0,88(29)
	addi 3,3,4
	li 4,2
	mtlr 0
	blrl
	b .L356
.L355:
	lwz 0,88(29)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
.L356:
	lwz 11,84(31)
	mr 3,31
	addi 4,1,16
	li 5,1
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	bl PlayerNoise
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,112(1)
	lwz 11,116(1)
	andi. 0,11,8192
	bc 4,2,.L357
	lwz 9,84(31)
	lwz 0,3544(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	addi 11,11,-2
	stwx 11,9,0
.L357:
	lwz 0,148(1)
	mtlr 0
	lmw 26,120(1)
	la 1,144(1)
	blr
.Lfe16:
	.size	 weapon_supershotgun_fire,.Lfe16-weapon_supershotgun_fire
	.section	".data"
	.align 2
	.type	 pause_frames.104,@object
pause_frames.104:
	.long 29
	.long 42
	.long 57
	.long 0
	.align 2
	.type	 fire_frames.105,@object
fire_frames.105:
	.long 7
	.long 0
	.section	".rodata"
	.align 2
.LC95:
	.long 0x0
	.align 2
.LC96:
	.long 0xc0400000
	.align 3
.LC97:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl weapon_railgun_fire
	.type	 weapon_railgun_fire,@function
weapon_railgun_fire:
	stwu 1,-128(1)
	mflr 0
	stmw 27,108(1)
	stw 0,132(1)
	lis 9,deathmatch@ha
	lis 8,.LC95@ha
	lwz 11,deathmatch@l(9)
	la 8,.LC95@l(8)
	mr 30,3
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L361
	li 29,100
	li 31,200
	b .L362
.L361:
	li 29,150
	li 31,250
.L362:
	lis 9,is_quad@ha
	lwz 0,is_quad@l(9)
	cmpwi 0,0,0
	bc 12,2,.L363
	slwi 29,29,2
	slwi 31,31,2
.L363:
	lwz 3,84(30)
	lwz 0,3848(3)
	cmpwi 0,0,0
	bc 12,2,.L364
	lwz 3,3844(3)
	addi 0,1,24
	addi 5,1,40
	mr 4,0
	li 6,0
	addi 3,3,16
	mr 28,0
	bl AngleVectors
	b .L365
.L364:
	addi 0,1,24
	addi 3,3,3668
	mr 4,0
	addi 5,1,40
	li 6,0
	mr 28,0
	bl AngleVectors
.L365:
	lis 8,.LC96@ha
	lwz 4,84(30)
	mr 3,28
	la 8,.LC96@l(8)
	lfs 1,0(8)
	addi 4,4,3616
	bl VectorScale
	lwz 9,84(30)
	lis 0,0xc040
	lis 10,0x4330
	lis 8,.LC97@ha
	stw 0,3604(9)
	la 8,.LC97@l(8)
	li 6,0
	lwz 9,508(30)
	lis 0,0x40e0
	addi 3,30,4
	lfd 13,0(8)
	addi 5,1,72
	addi 7,1,8
	addi 9,9,-8
	lwz 8,84(30)
	mr 27,3
	xoris 9,9,0x8000
	stw 0,76(1)
	stw 9,100(1)
	stw 10,96(1)
	lfd 0,96(1)
	stw 6,56(1)
	stw 0,60(1)
	fsub 0,0,13
	stw 6,72(1)
	frsp 0,0
	stfs 0,80(1)
	stfs 0,64(1)
	lwz 0,716(8)
	cmpwi 0,0,1
	bc 4,2,.L366
	lis 0,0xc0e0
	stw 0,76(1)
	b .L367
.L366:
	cmpwi 0,0,2
	bc 4,2,.L367
	stw 6,4(5)
.L367:
	addi 4,1,72
	addi 5,1,24
	addi 6,1,40
	bl G_ProjectSource
	mr 7,31
	mr 5,28
	mr 6,29
	mr 3,30
	addi 4,1,8
	bl fire_rail
	lis 9,gi@ha
	li 3,1
	la 31,gi@l(9)
	lwz 9,100(31)
	mtlr 9
	blrl
	lwz 11,84(30)
	lwz 0,3848(11)
	cmpwi 0,0,0
	bc 12,2,.L370
	lis 9,g_edicts@ha
	lwz 3,3844(11)
	lis 0,0xbfc5
	lwz 11,g_edicts@l(9)
	ori 0,0,18087
	lwz 9,104(31)
	subf 3,11,3
	mullw 3,3,0
	mtlr 9
	srawi 3,3,2
	blrl
	b .L371
.L370:
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 11,104(31)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 11
	subf 3,3,30
	mullw 3,3,0
	srawi 3,3,2
	blrl
.L371:
	lis 9,gi@ha
	lis 11,is_silenced@ha
	la 31,gi@l(9)
	lbz 3,is_silenced@l(11)
	lwz 9,100(31)
	ori 3,3,6
	mtlr 9
	blrl
	lwz 9,84(30)
	lwz 0,3848(9)
	cmpwi 0,0,0
	bc 12,2,.L372
	lwz 3,3844(9)
	li 4,2
	lwz 0,88(31)
	addi 3,3,4
	mtlr 0
	blrl
	b .L373
.L372:
	lwz 0,88(31)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
.L373:
	lwz 11,84(30)
	mr 3,30
	addi 4,1,8
	li 5,1
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	bl PlayerNoise
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,96(1)
	lwz 11,100(1)
	andi. 0,11,8192
	bc 4,2,.L374
	lwz 9,84(30)
	lwz 0,3544(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	addi 11,11,-1
	stwx 11,9,0
.L374:
	lwz 0,132(1)
	mtlr 0
	lmw 27,108(1)
	la 1,128(1)
	blr
.Lfe17:
	.size	 weapon_railgun_fire,.Lfe17-weapon_railgun_fire
	.section	".data"
	.align 2
	.type	 pause_frames.112,@object
pause_frames.112:
	.long 56
	.long 0
	.align 2
	.type	 fire_frames.113,@object
fire_frames.113:
	.long 4
	.long 0
	.section	".rodata"
	.align 2
.LC98:
	.long 0x46fffe00
	.align 2
.LC99:
	.long 0x0
	.align 2
.LC100:
	.long 0xc0000000
	.align 3
.LC101:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC102:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC103:
	.long 0x40200000
	.long 0x0
	.align 2
.LC104:
	.long 0x447a0000
	.section	".text"
	.align 2
	.globl weapon_bfg_fire
	.type	 weapon_bfg_fire,@function
weapon_bfg_fire:
	stwu 1,-112(1)
	mflr 0
	stmw 28,96(1)
	stw 0,116(1)
	lis 9,deathmatch@ha
	lis 10,.LC99@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC99@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	lwz 3,84(31)
	fcmpu 7,0,13
	lwz 10,92(3)
	cmpwi 6,10,9
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	nor 9,0,0
	andi. 0,0,500
	andi. 9,9,200
	or 8,0,9
	bc 4,26,.L379
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,84(31)
	lwz 11,3844(9)
	cmpwi 0,11,0
	bc 12,2,.L380
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 10
	subf 3,3,11
	mullw 3,3,0
	srawi 3,3,2
	blrl
	b .L381
.L380:
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 11,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 11
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
.L381:
	lis 9,gi@ha
	lis 11,is_silenced@ha
	la 29,gi@l(9)
	lbz 3,is_silenced@l(11)
	lwz 9,100(29)
	ori 3,3,12
	mtlr 9
	blrl
	lwz 9,84(31)
	lwz 3,3844(9)
	cmpwi 0,3,0
	bc 12,2,.L382
	lwz 0,88(29)
	addi 3,3,4
	li 4,2
	mtlr 0
	blrl
	b .L383
.L382:
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
.L383:
	lwz 11,84(31)
	mr 3,31
	addi 4,1,24
	li 5,1
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	bl PlayerNoise
	b .L376
.L379:
	lwz 0,3544(3)
	addi 11,3,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,49
	bc 12,1,.L384
	addi 0,10,1
	stw 0,92(3)
	b .L376
.L384:
	lis 11,is_quad@ha
	lwz 10,3848(3)
	slwi 9,8,2
	lwz 0,is_quad@l(11)
	cmpwi 0,10,0
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 28,0,9
	bc 12,2,.L386
	lwz 3,3844(3)
	addi 0,1,40
	addi 5,1,56
	mr 4,0
	li 6,0
	addi 3,3,16
	mr 30,0
	bl AngleVectors
	b .L387
.L386:
	addi 0,1,40
	addi 3,3,3668
	mr 4,0
	addi 5,1,56
	li 6,0
	mr 30,0
	bl AngleVectors
.L387:
	lis 9,.LC100@ha
	lwz 4,84(31)
	mr 3,30
	la 9,.LC100@l(9)
	lfs 1,0(9)
	addi 4,4,3616
	bl VectorScale
	lwz 9,84(31)
	lis 0,0xc220
	stw 0,3632(9)
	bl rand
	rlwinm 3,3,0,17,31
	lwz 5,84(31)
	xoris 3,3,0x8000
	lis 6,0x4330
	stw 3,92(1)
	lis 10,.LC101@ha
	lis 11,.LC98@ha
	stw 6,88(1)
	la 10,.LC101@l(10)
	lis 8,level+4@ha
	lfd 9,0(10)
	lis 0,0x4100
	addi 7,1,8
	lfd 13,88(1)
	lis 10,.LC102@ha
	addi 4,1,72
	lfs 12,.LC98@l(11)
	la 10,.LC102@l(10)
	addi 29,31,4
	lfd 10,0(10)
	fsub 13,13,9
	lis 10,.LC103@ha
	la 10,.LC103@l(10)
	lfd 11,0(10)
	frsp 13,13
	mr 10,9
	fdivs 13,13,12
	fmr 0,13
	fsub 0,0,10
	fadd 0,0,0
	fmul 0,0,11
	frsp 0,0
	stfs 0,3628(5)
	lfs 13,level+4@l(8)
	lwz 11,84(31)
	fadd 13,13,10
	frsp 13,13
	stfs 13,3636(11)
	lwz 9,508(31)
	stw 0,72(1)
	addi 9,9,-8
	stw 0,8(1)
	xoris 9,9,0x8000
	stw 0,12(1)
	stw 9,92(1)
	stw 6,88(1)
	lfd 0,88(1)
	lwz 9,84(31)
	fsub 0,0,9
	frsp 0,0
	stfs 0,16(1)
	lfs 13,4(7)
	stfs 13,76(1)
	lfs 0,8(7)
	stfs 0,80(1)
	lwz 0,716(9)
	cmpwi 0,0,1
	bc 4,2,.L388
	fneg 0,13
	stfs 0,76(1)
	b .L389
.L388:
	cmpwi 0,0,2
	bc 4,2,.L389
	li 0,0
	stw 0,4(4)
.L389:
	addi 7,1,24
	mr 3,29
	addi 4,1,72
	addi 5,1,40
	addi 6,1,56
	mr 29,7
	bl G_ProjectSource
	lis 9,.LC104@ha
	mr 5,30
	la 9,.LC104@l(9)
	mr 6,28
	lfs 1,0(9)
	mr 3,31
	mr 4,29
	li 7,400
	bl fire_bfg
	lwz 11,84(31)
	mr 4,29
	mr 3,31
	li 5,1
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	bl PlayerNoise
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,88(1)
	lwz 11,92(1)
	andi. 0,11,8192
	bc 4,2,.L376
	lwz 9,84(31)
	lwz 0,3544(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	addi 11,11,-50
	stwx 11,9,0
.L376:
	lwz 0,116(1)
	mtlr 0
	lmw 28,96(1)
	la 1,112(1)
	blr
.Lfe18:
	.size	 weapon_bfg_fire,.Lfe18-weapon_bfg_fire
	.section	".data"
	.align 2
	.type	 pause_frames.120,@object
pause_frames.120:
	.long 39
	.long 45
	.long 50
	.long 55
	.long 0
	.align 2
	.type	 fire_frames.121,@object
fire_frames.121:
	.long 9
	.long 17
	.long 0
	.section	".rodata"
	.align 3
.LC105:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Think_Weapon
	.type	 Think_Weapon,@function
Think_Weapon:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 12,1,.L59
	lwz 9,84(31)
	li 0,0
	stw 0,3564(9)
	bl ChangeWeapon
.L59:
	lwz 8,84(31)
	lwz 9,1788(8)
	cmpwi 0,9,0
	bc 12,2,.L60
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L60
	lis 11,level@ha
	lfs 12,3740(8)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC105@ha
	lwz 8,3764(8)
	xoris 0,0,0x8000
	la 11,.LC105@l(11)
	stw 0,20(1)
	cmpwi 0,8,0
	stw 10,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,is_quad@ha
	fsub 0,0,13
	frsp 0,0
	fcmpu 7,12,0
	mfcr 0
	rlwinm 0,0,30,1
	stw 0,is_quad@l(11)
	bc 12,2,.L61
	lis 9,is_silenced@ha
	li 0,128
	stb 0,is_silenced@l(9)
	b .L62
.L61:
	lis 9,is_silenced@ha
	stb 8,is_silenced@l(9)
.L62:
	lwz 11,84(31)
	mr 3,31
	lwz 9,1788(11)
	lwz 0,16(9)
	mtlr 0
	blrl
.L60:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 Think_Weapon,.Lfe19-Think_Weapon
	.section	".sbss","aw",@nobits
	.align 2
is_quad:
	.space	4
	.size	 is_quad,4
is_silenced:
	.space	1
	.size	 is_silenced,1
	.section	".rodata"
	.align 2
.LC106:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_Weapon
	.type	 Use_Weapon,@function
Use_Weapon:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,3
	mr 31,4
	lwz 9,84(30)
	lwz 0,1788(9)
	cmpw 0,31,0
	bc 12,2,.L63
	lwz 3,52(31)
	cmpwi 0,3,0
	bc 12,2,.L65
	lis 9,.LC106@ha
	lis 11,g_select_empty@ha
	la 9,.LC106@l(9)
	lfs 13,0(9)
	lwz 9,g_select_empty@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L65
	lwz 0,56(31)
	andi. 9,0,2
	bc 4,2,.L65
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0xcccc
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,52429
	subf 9,9,3
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,4
	slwi 9,9,2
	lwzx 9,11,9
	cmpwi 0,9,0
	bc 4,2,.L66
	lis 9,gi+8@ha
	lis 5,.LC16@ha
	lwz 6,40(3)
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC16@l(5)
	b .L394
.L66:
	lwz 0,48(31)
	cmpw 0,9,0
	bc 4,0,.L65
	lis 9,gi+8@ha
	lis 5,.LC17@ha
	lwz 6,40(3)
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC17@l(5)
.L394:
	lwz 7,40(31)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L63
.L65:
	lwz 9,84(30)
	stw 31,3564(9)
.L63:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe20:
	.size	 Use_Weapon,.Lfe20-Use_Weapon
	.align 2
	.globl Drop_Weapon
	.type	 Drop_Weapon,@function
Drop_Weapon:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 11,dmflags@ha
	lwz 10,dmflags@l(11)
	mr 30,3
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,4
	bc 4,2,.L68
	lwz 10,84(30)
	lis 9,itemlist@ha
	lis 0,0xcccc
	la 9,itemlist@l(9)
	ori 0,0,52429
	lwz 11,1788(10)
	subf 9,9,4
	mullw 9,9,0
	cmpw 0,4,11
	srawi 9,9,4
	bc 12,2,.L71
	lwz 0,3564(10)
	slwi 31,9,2
	cmpw 0,4,0
	bc 4,2,.L70
.L71:
	slwi 0,9,2
	addi 9,10,740
	mr 31,0
	lwzx 11,9,0
	cmpwi 0,11,1
	bc 4,2,.L70
	lis 9,gi+8@ha
	lis 5,.LC18@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC18@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L68
.L70:
	mr 3,30
	bl Drop_Item
	lwz 11,84(30)
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-1
	stwx 9,11,31
.L68:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 Drop_Weapon,.Lfe21-Drop_Weapon
	.align 2
	.globl Weapon_GrenadeLauncher
	.type	 Weapon_GrenadeLauncher,@function
Weapon_GrenadeLauncher:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lis 8,pause_frames.42@ha
	lis 9,fire_frames.43@ha
	lis 10,weapon_grenadelauncher_fire@ha
	la 8,pause_frames.42@l(8)
	lwz 7,1788(11)
	la 9,fire_frames.43@l(9)
	la 10,weapon_grenadelauncher_fire@l(10)
	li 4,5
	li 5,16
	lwz 0,48(7)
	li 6,59
	li 7,64
	stw 0,8(1)
	bl Weapon_Generic
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 Weapon_GrenadeLauncher,.Lfe22-Weapon_GrenadeLauncher
	.align 2
	.globl Weapon_RocketLauncher
	.type	 Weapon_RocketLauncher,@function
Weapon_RocketLauncher:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lis 8,pause_frames.50@ha
	lis 9,fire_frames.51@ha
	lis 10,Weapon_RocketLauncher_Fire@ha
	la 8,pause_frames.50@l(8)
	lwz 7,1788(11)
	la 9,fire_frames.51@l(9)
	la 10,Weapon_RocketLauncher_Fire@l(10)
	li 4,4
	li 5,12
	lwz 0,48(7)
	li 6,50
	li 7,54
	stw 0,8(1)
	bl Weapon_Generic
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 Weapon_RocketLauncher,.Lfe23-Weapon_RocketLauncher
	.section	".rodata"
	.align 2
.LC107:
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_Blaster_Fire
	.type	 Weapon_Blaster_Fire,@function
Weapon_Blaster_Fire:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 11,.LC107@ha
	lis 9,deathmatch@ha
	la 11,.LC107@l(11)
	mr 29,3
	lfs 13,0(11)
	lis 4,vec3_origin@ha
	lwz 11,deathmatch@l(9)
	la 4,vec3_origin@l(4)
	li 6,0
	li 7,8
	lfs 0,20(11)
	fcmpu 7,0,13
	crnor 31,30,30
	mfcr 5
	rlwinm 5,5,0,1
	neg 5,5
	rlwinm 5,5,0,28,31
	ori 5,5,10
	bl Blaster_Fire
	lwz 11,84(29)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 Weapon_Blaster_Fire,.Lfe24-Weapon_Blaster_Fire
	.align 2
	.globl Weapon_Blaster
	.type	 Weapon_Blaster,@function
Weapon_Blaster:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lis 8,pause_frames.61@ha
	lis 9,fire_frames.62@ha
	lis 10,Weapon_Blaster_Fire@ha
	la 8,pause_frames.61@l(8)
	lwz 7,1788(11)
	la 9,fire_frames.62@l(9)
	la 10,Weapon_Blaster_Fire@l(10)
	li 4,4
	li 5,8
	lwz 0,48(7)
	li 6,52
	li 7,55
	stw 0,8(1)
	bl Weapon_Generic
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe25:
	.size	 Weapon_Blaster,.Lfe25-Weapon_Blaster
	.align 2
	.globl Weapon_HyperBlaster
	.type	 Weapon_HyperBlaster,@function
Weapon_HyperBlaster:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lis 8,pause_frames.69@ha
	lis 9,fire_frames.70@ha
	lis 10,Weapon_HyperBlaster_Fire@ha
	la 8,pause_frames.69@l(8)
	lwz 7,1788(11)
	la 9,fire_frames.70@l(9)
	la 10,Weapon_HyperBlaster_Fire@l(10)
	li 4,5
	li 5,20
	lwz 0,48(7)
	li 6,49
	li 7,53
	stw 0,8(1)
	bl Weapon_Generic
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe26:
	.size	 Weapon_HyperBlaster,.Lfe26-Weapon_HyperBlaster
	.align 2
	.globl Weapon_Machinegun
	.type	 Weapon_Machinegun,@function
Weapon_Machinegun:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lis 8,pause_frames.77@ha
	lis 9,fire_frames.78@ha
	lis 10,Machinegun_Fire@ha
	la 8,pause_frames.77@l(8)
	lwz 7,1788(11)
	la 9,fire_frames.78@l(9)
	la 10,Machinegun_Fire@l(10)
	li 4,3
	li 5,5
	lwz 0,48(7)
	li 6,45
	li 7,49
	stw 0,8(1)
	bl Weapon_Generic
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe27:
	.size	 Weapon_Machinegun,.Lfe27-Weapon_Machinegun
	.align 2
	.globl Weapon_Chaingun
	.type	 Weapon_Chaingun,@function
Weapon_Chaingun:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lis 8,pause_frames.88@ha
	lis 9,fire_frames.89@ha
	lis 10,Chaingun_Fire@ha
	la 8,pause_frames.88@l(8)
	lwz 7,1788(11)
	la 9,fire_frames.89@l(9)
	la 10,Chaingun_Fire@l(10)
	li 4,4
	li 5,31
	lwz 0,48(7)
	li 6,61
	li 7,64
	stw 0,8(1)
	bl Weapon_Generic
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 Weapon_Chaingun,.Lfe28-Weapon_Chaingun
	.align 2
	.globl Weapon_Shotgun
	.type	 Weapon_Shotgun,@function
Weapon_Shotgun:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lis 8,pause_frames.96@ha
	lis 9,fire_frames.97@ha
	lis 10,weapon_shotgun_fire@ha
	la 8,pause_frames.96@l(8)
	lwz 7,1788(11)
	la 9,fire_frames.97@l(9)
	la 10,weapon_shotgun_fire@l(10)
	li 4,7
	li 5,18
	lwz 0,48(7)
	li 6,36
	li 7,39
	stw 0,8(1)
	bl Weapon_Generic
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 Weapon_Shotgun,.Lfe29-Weapon_Shotgun
	.align 2
	.globl Weapon_SuperShotgun
	.type	 Weapon_SuperShotgun,@function
Weapon_SuperShotgun:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lis 8,pause_frames.104@ha
	lis 9,fire_frames.105@ha
	lis 10,weapon_supershotgun_fire@ha
	la 8,pause_frames.104@l(8)
	lwz 7,1788(11)
	la 9,fire_frames.105@l(9)
	la 10,weapon_supershotgun_fire@l(10)
	li 4,6
	li 5,17
	lwz 0,48(7)
	li 6,57
	li 7,61
	stw 0,8(1)
	bl Weapon_Generic
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 Weapon_SuperShotgun,.Lfe30-Weapon_SuperShotgun
	.align 2
	.globl Weapon_Railgun
	.type	 Weapon_Railgun,@function
Weapon_Railgun:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lis 8,pause_frames.112@ha
	lis 9,fire_frames.113@ha
	lis 10,weapon_railgun_fire@ha
	la 8,pause_frames.112@l(8)
	lwz 7,1788(11)
	la 9,fire_frames.113@l(9)
	la 10,weapon_railgun_fire@l(10)
	li 4,3
	li 5,18
	lwz 0,48(7)
	li 6,56
	li 7,61
	stw 0,8(1)
	bl Weapon_Generic
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 Weapon_Railgun,.Lfe31-Weapon_Railgun
	.align 2
	.globl Weapon_BFG
	.type	 Weapon_BFG,@function
Weapon_BFG:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lis 8,pause_frames.120@ha
	lis 9,fire_frames.121@ha
	lis 10,weapon_bfg_fire@ha
	la 8,pause_frames.120@l(8)
	lwz 7,1788(11)
	la 9,fire_frames.121@l(9)
	la 10,weapon_bfg_fire@l(10)
	li 4,8
	li 5,32
	lwz 0,48(7)
	li 6,55
	li 7,58
	stw 0,8(1)
	bl Weapon_Generic
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe32:
	.size	 Weapon_BFG,.Lfe32-Weapon_BFG
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
