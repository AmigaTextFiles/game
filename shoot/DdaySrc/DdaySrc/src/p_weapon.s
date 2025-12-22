	.file	"p_weapon.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"player_noise"
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
	lwz 9,4368(11)
	cmpwi 0,9,0
	bc 12,2,.L11
	addi 0,9,-1
	stw 0,4368(11)
	b .L10
.L11:
	lwz 0,268(31)
	andi. 9,0,32
	bc 4,2,.L10
	lwz 0,576(31)
	cmpwi 0,0,0
	bc 4,2,.L14
	bl G_Spawn
	lis 28,0xc100
	lis 27,0x4100
	lis 29,.LC0@ha
	mr 10,3
	la 29,.LC0@l(29)
	li 26,1
	stw 28,188(10)
	stw 29,284(10)
	stw 28,192(10)
	stw 28,196(10)
	stw 27,200(10)
	stw 27,204(10)
	stw 27,208(10)
	stw 31,256(10)
	stw 26,184(10)
	stw 10,576(31)
	bl G_Spawn
	mr 10,3
	stw 29,284(10)
	stw 28,196(10)
	stw 27,208(10)
	stw 26,184(10)
	stw 28,188(10)
	stw 28,192(10)
	stw 27,200(10)
	stw 27,204(10)
	stw 31,256(10)
	stw 10,580(31)
.L14:
	cmplwi 0,25,1
	bc 12,1,.L15
	lis 9,level@ha
	lwz 10,576(31)
	lwz 0,level@l(9)
	la 9,level@l(9)
	stw 10,252(9)
	stw 0,256(9)
	b .L16
.L15:
	lis 9,level@ha
	lwz 10,580(31)
	lwz 0,level@l(9)
	la 9,level@l(9)
	stw 10,260(9)
	stw 0,264(9)
.L16:
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
	stfs 0,612(10)
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
.LC1:
	.string	"You can not carry anymore weapons!\n"
	.align 2
.LC2:
	.string	"colt45"
	.align 2
.LC3:
	.long 0x0
	.align 2
.LC4:
	.long 0x41f00000
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
	lwz 0,664(30)
	la 11,itemlist@l(11)
	lis 9,0xc4ec
	lfs 0,20(8)
	ori 9,9,20165
	mr 29,4
	subf 0,11,0
	mullw 0,0,9
	srawi 0,0,3
	fctiwz 13,0
	stfd 13,8(1)
	lwz 10,12(1)
	andi. 9,10,4
	bc 4,2,.L19
	lis 9,.LC3@ha
	lis 11,coop@ha
	lwz 8,84(29)
	la 9,.LC3@l(9)
	slwi 28,0,2
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L18
.L19:
	lwz 11,84(29)
	slwi 10,0,2
	mr 28,10
	addi 9,11,740
	mr 8,11
	lwzx 0,9,10
	cmpwi 0,0,0
	bc 12,2,.L18
	lwz 0,288(30)
	andis. 9,0,0x3
	bc 4,2,.L18
	li 3,0
	b .L33
.L18:
	addi 11,8,740
	mr 3,29
	lwzx 9,11,28
	addi 9,9,1
	stwx 9,11,28
	bl WeighPlayer
	cmpwi 0,3,0
	bc 4,2,.L21
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(29)
	li 3,0
	addi 11,11,740
	lwzx 9,11,28
	addi 9,9,-1
	stwx 9,11,28
	b .L33
.L21:
	lwz 0,288(30)
	andis. 9,0,1
	bc 4,2,.L22
	lwz 9,664(30)
	lwz 3,52(9)
	cmpwi 0,3,0
	bc 12,2,.L23
	bl FindItem
	lis 11,dmflags@ha
	lwz 10,dmflags@l(11)
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	andi. 0,9,8192
	bc 12,2,.L24
	mr 4,3
	li 5,1000
	mr 3,29
	bl Add_Ammo
	b .L23
.L24:
	mr 4,3
	lwz 5,48(4)
	mr 3,29
	bl Add_Ammo
.L23:
	lwz 0,288(30)
	andis. 9,0,2
	bc 4,2,.L22
	lis 9,.LC3@ha
	lis 11,deathmatch@ha
	la 9,.LC3@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L27
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,4
	bc 12,2,.L28
	lwz 0,268(30)
	oris 0,0,0x8000
	stw 0,268(30)
	b .L27
.L28:
	lis 9,.LC4@ha
	mr 3,30
	la 9,.LC4@l(9)
	lfs 1,0(9)
	bl SetRespawn
.L27:
	lis 9,.LC3@ha
	lis 11,coop@ha
	la 9,.LC3@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L22
	lwz 0,268(30)
	oris 0,0,0x8000
	stw 0,268(30)
.L22:
	lwz 31,84(29)
	lwz 9,664(30)
	lwz 0,1796(31)
	cmpw 0,0,9
	bc 12,2,.L31
	addi 9,31,740
	lwzx 0,9,28
	cmpwi 0,0,1
	bc 4,2,.L31
	lis 9,.LC3@ha
	lis 11,deathmatch@ha
	la 9,.LC3@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L32
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	bl FindItem
	lwz 0,1796(31)
	cmpw 0,0,3
	bc 4,2,.L31
.L32:
	lwz 9,84(29)
	lwz 0,664(30)
	stw 0,4148(9)
.L31:
	li 3,1
.L33:
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
	.string	"w_p38"
	.align 2
.LC6:
	.string	"w_m98k"
	.align 2
.LC7:
	.string	"w_mp40"
	.align 2
.LC8:
	.string	"w_mp43"
	.align 2
.LC9:
	.string	"w_mg42"
	.align 2
.LC10:
	.string	"w_panzer"
	.align 2
.LC11:
	.string	"w_m98ks"
	.align 2
.LC12:
	.string	"a_masher"
	.align 2
.LC13:
	.string	"w_colt45"
	.align 2
.LC14:
	.string	"w_m1"
	.align 2
.LC15:
	.string	"w_thompson"
	.align 2
.LC16:
	.string	"w_bar"
	.align 2
.LC17:
	.string	"w_bhmg"
	.align 2
.LC18:
	.string	"w_bazooka"
	.align 2
.LC19:
	.string	"w_m1903"
	.align 2
.LC20:
	.string	"a_grenade"
	.align 2
.LC21:
	.string	"w_flame"
	.align 2
.LC22:
	.string	"w_morphine"
	.align 2
.LC23:
	.string	"w_knife"
	.align 2
.LC24:
	.string	"w_binoc"
	.align 2
.LC25:
	.string	"w_tnt"
	.align 2
.LC26:
	.string	"players/%s/%s.md2"
	.section	".text"
	.align 2
	.globl ShowGun
	.type	 ShowGun,@function
ShowGun:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	lwz 9,84(30)
	lwz 3,1796(9)
	cmpwi 0,3,0
	bc 12,2,.L77
	lwz 31,36(3)
	lis 4,.LC5@ha
	li 29,0
	la 4,.LC5@l(4)
	mr 3,31
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L36
	li 29,1
	b .L37
.L36:
	lis 4,.LC6@ha
	mr 3,31
	la 4,.LC6@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L38
	li 29,2
	b .L37
.L38:
	lis 4,.LC7@ha
	mr 3,31
	la 4,.LC7@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L40
	li 29,3
	b .L37
.L40:
	lis 4,.LC8@ha
	mr 3,31
	la 4,.LC8@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L42
	li 29,4
	b .L37
.L42:
	lis 4,.LC9@ha
	mr 3,31
	la 4,.LC9@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L44
	li 29,5
	b .L37
.L44:
	lis 4,.LC10@ha
	mr 3,31
	la 4,.LC10@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L46
	li 29,6
	b .L37
.L46:
	lis 4,.LC11@ha
	mr 3,31
	la 4,.LC11@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L48
	li 29,7
	b .L37
.L48:
	lis 4,.LC12@ha
	mr 3,31
	la 4,.LC12@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L50
	li 29,8
	b .L37
.L50:
	lis 4,.LC13@ha
	mr 3,31
	la 4,.LC13@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L52
	li 29,9
	b .L37
.L52:
	lis 4,.LC14@ha
	mr 3,31
	la 4,.LC14@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L54
	li 29,10
	b .L37
.L54:
	lis 4,.LC15@ha
	mr 3,31
	la 4,.LC15@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L56
	li 29,11
	b .L37
.L56:
	lis 4,.LC16@ha
	mr 3,31
	la 4,.LC16@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L58
	li 29,12
	b .L37
.L58:
	lis 4,.LC17@ha
	mr 3,31
	la 4,.LC17@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L60
	li 29,13
	b .L37
.L60:
	lis 4,.LC18@ha
	mr 3,31
	la 4,.LC18@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L62
	li 29,14
	b .L37
.L62:
	lis 4,.LC19@ha
	mr 3,31
	la 4,.LC19@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L64
	li 29,15
	b .L37
.L64:
	lis 4,.LC20@ha
	mr 3,31
	la 4,.LC20@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L66
	li 29,16
	b .L37
.L66:
	lis 4,.LC21@ha
	mr 3,31
	la 4,.LC21@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L68
	li 29,17
	b .L37
.L68:
	lis 4,.LC22@ha
	mr 3,31
	la 4,.LC22@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L70
	li 29,18
	b .L37
.L70:
	lis 4,.LC23@ha
	mr 3,31
	la 4,.LC23@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L72
	li 29,19
	b .L37
.L72:
	lis 4,.LC24@ha
	mr 3,31
	la 4,.LC24@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L74
	li 29,20
	b .L37
.L74:
	lis 4,.LC25@ha
	mr 3,31
	la 4,.LC25@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	nor 9,0,0
	and 0,29,0
	andi. 9,9,21
	or 29,0,9
.L37:
	lbz 0,63(30)
	slwi 9,29,8
	lis 3,.LC26@ha
	lwz 11,84(30)
	lis 29,gi@ha
	mr 5,31
	or 0,0,9
	la 29,gi@l(29)
	stw 0,60(30)
	la 3,.LC26@l(3)
	lwz 4,3448(11)
	addi 4,4,164
	crxor 6,6,6
	bl va
	lwz 0,32(29)
	mtlr 0
	blrl
.L77:
	stw 3,44(30)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 ShowGun,.Lfe3-ShowGun
	.align 2
	.globl ChangeWeapon
	.type	 ChangeWeapon,@function
ChangeWeapon:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 11,4148(9)
	cmpwi 0,11,0
	bc 12,2,.L79
	lwz 0,4356(9)
	cmpwi 0,0,0
	bc 12,2,.L81
	lwz 0,68(11)
	cmpwi 0,0,12
	bc 12,2,.L81
	lwz 0,4360(9)
	cmpwi 0,0,0
	bc 12,2,.L78
.L81:
	lwz 9,84(31)
	lwz 0,4364(9)
	cmpwi 0,0,0
	bc 12,2,.L79
	lwz 9,4148(9)
	lwz 0,68(9)
	cmpwi 0,0,13
	bc 4,2,.L78
.L79:
	lwz 9,84(31)
	li 10,0
	lis 8,0x42aa
	lwz 0,1796(9)
	stw 0,1800(9)
	lwz 11,84(31)
	lwz 0,4148(11)
	stw 0,1796(11)
	lwz 9,84(31)
	stw 10,4148(9)
	lwz 11,84(31)
	stw 10,4320(11)
	lwz 9,84(31)
	stw 8,112(9)
	lwz 11,84(31)
	lwz 3,1796(11)
	cmpwi 0,3,0
	bc 12,2,.L82
	lwz 3,52(3)
	cmpwi 0,3,0
	bc 12,2,.L82
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 3,9,3
	mullw 3,3,0
	srawi 3,3,3
	stw 3,4128(11)
	b .L83
.L82:
	lwz 9,84(31)
	li 0,0
	stw 0,4128(9)
.L83:
	lwz 9,84(31)
	lwz 0,1796(9)
	cmpwi 0,0,0
	bc 12,2,.L85
	lwz 0,40(31)
	cmpwi 0,0,255
	bc 12,2,.L84
.L85:
	li 0,0
	stw 0,88(9)
	b .L78
.L84:
	li 0,0
	li 10,1
	stw 0,4496(9)
	lis 8,gi+32@ha
	lwz 9,84(31)
	stw 0,4500(9)
	lwz 11,84(31)
	stw 10,4192(11)
	lwz 9,84(31)
	stw 0,92(9)
	lwz 11,84(31)
	lwz 0,gi+32@l(8)
	lwz 9,1796(11)
	mtlr 0
	lwz 3,32(9)
	blrl
	lwz 11,84(31)
	li 0,3
	stw 3,88(11)
	lwz 9,84(31)
	stw 0,4328(9)
	lwz 0,672(31)
	cmpwi 0,0,1
	bc 4,2,.L86
	li 0,62
	lwz 11,84(31)
	li 9,65
	b .L91
.L86:
	cmpwi 0,0,2
	bc 4,2,.L88
	li 0,169
	lwz 11,84(31)
	li 9,172
	b .L91
.L88:
	cmpwi 0,0,4
	bc 4,2,.L87
	li 0,230
	lwz 11,84(31)
	li 9,233
.L91:
	stw 0,56(31)
	stw 9,4324(11)
.L87:
	mr 3,31
	bl ShowGun
	mr 3,31
	bl WeighPlayer
.L78:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 ChangeWeapon,.Lfe4-ChangeWeapon
	.section	".rodata"
	.align 2
.LC27:
	.string	"slugs"
	.align 2
.LC28:
	.string	"m1903"
	.align 2
.LC29:
	.string	"M1903"
	.align 2
.LC30:
	.string	"Bullets"
	.align 2
.LC31:
	.string	"Thompson"
	.align 2
.LC32:
	.string	"HMGAmmo"
	.align 2
.LC33:
	.string	"BHMG"
	.align 2
.LC34:
	.string	"BAR"
	.align 2
.LC35:
	.string	"M1 Garand"
	.section	".text"
	.align 2
	.globl NoAmmoWeaponChange
	.type	 NoAmmoWeaponChange,@function
NoAmmoWeaponChange:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 30,3
	lis 31,0xc4ec
	lis 3,.LC27@ha
	lwz 29,84(30)
	ori 31,31,20165
	la 3,.LC27@l(3)
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,31
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L93
	lis 3,.LC28@ha
	lwz 29,84(30)
	la 3,.LC28@l(3)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,31
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L93
	lis 3,.LC29@ha
	la 3,.LC29@l(3)
	b .L98
.L93:
	lis 3,.LC30@ha
	lwz 29,84(30)
	lis 31,0xc4ec
	la 3,.LC30@l(3)
	ori 31,31,20165
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,31
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L94
	lis 27,.LC31@ha
	lwz 29,84(30)
	la 3,.LC31@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,31
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L94
	la 3,.LC31@l(27)
	b .L98
.L94:
	lis 3,.LC32@ha
	lwz 29,84(30)
	lis 31,0xc4ec
	la 3,.LC32@l(3)
	ori 31,31,20165
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,31
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L95
	lis 27,.LC33@ha
	lwz 29,84(30)
	la 3,.LC33@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,31
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L95
	la 3,.LC33@l(27)
	b .L98
.L95:
	lis 3,.LC32@ha
	lwz 29,84(30)
	lis 31,0xc4ec
	la 3,.LC32@l(3)
	ori 31,31,20165
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,31
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L96
	lis 27,.LC34@ha
	lwz 29,84(30)
	la 3,.LC34@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,31
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L96
	la 3,.LC34@l(27)
	b .L98
.L96:
	lis 3,.LC27@ha
	lwz 29,84(30)
	lis 31,0xc4ec
	la 3,.LC27@l(3)
	ori 31,31,20165
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,31
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,1
	bc 4,1,.L97
	lis 27,.LC35@ha
	lwz 29,84(30)
	la 3,.LC35@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,31
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L97
	la 3,.LC35@l(27)
	b .L98
.L97:
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
.L98:
	bl FindItem
	lwz 9,84(30)
	stw 3,4148(9)
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 NoAmmoWeaponChange,.Lfe5-NoAmmoWeaponChange
	.section	".rodata"
	.align 2
.LC36:
	.string	"p38_mag"
	.align 2
.LC37:
	.string	"mauser98k_mag"
	.align 2
.LC38:
	.string	"mp40_mag"
	.align 2
.LC39:
	.string	"mp43_mag"
	.align 2
.LC40:
	.string	"mg42_mag"
	.align 2
.LC41:
	.string	"grm_rockets"
	.align 2
.LC42:
	.string	"colt45_mag"
	.align 2
.LC43:
	.string	"m1_mag"
	.align 2
.LC44:
	.string	"thompson_mag"
	.align 2
.LC45:
	.string	"bar_mag"
	.align 2
.LC46:
	.string	"hmg_mag"
	.align 2
.LC47:
	.string	"usa_rockets"
	.align 2
.LC48:
	.string	"m1903_mag"
	.align 2
.LC49:
	.string	"flame_mag"
	.align 2
.LC50:
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
	lwz 0,1796(9)
	cmpw 0,31,0
	bc 12,2,.L105
	lwz 3,52(31)
	cmpwi 0,3,0
	bc 12,2,.L107
	lis 9,.LC50@ha
	lis 11,g_select_empty@ha
	la 9,.LC50@l(9)
	lfs 13,0(9)
	lwz 9,g_select_empty@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L107
	lwz 0,56(31)
	andi. 9,0,2
	bc 4,2,.L107
	bl FindItem
	lwz 3,52(31)
	lis 4,.LC36@ha
	la 4,.LC36@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L107
	lwz 3,52(31)
	lis 4,.LC37@ha
	la 4,.LC37@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L107
	lwz 3,52(31)
	lis 4,.LC38@ha
	la 4,.LC38@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L107
	lwz 3,52(31)
	lis 4,.LC39@ha
	la 4,.LC39@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L107
	lwz 3,52(31)
	lis 4,.LC40@ha
	la 4,.LC40@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L107
	lwz 3,52(31)
	lis 4,.LC41@ha
	la 4,.LC41@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L107
	lwz 3,52(31)
	lis 4,.LC42@ha
	la 4,.LC42@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L107
	lwz 3,52(31)
	lis 4,.LC43@ha
	la 4,.LC43@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L107
	lwz 3,52(31)
	lis 4,.LC44@ha
	la 4,.LC44@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L107
	lwz 3,52(31)
	lis 4,.LC45@ha
	la 4,.LC45@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L107
	lwz 3,52(31)
	lis 4,.LC46@ha
	la 4,.LC46@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L107
	lwz 3,52(31)
	lis 4,.LC47@ha
	la 4,.LC47@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L107
	lwz 3,52(31)
	lis 4,.LC48@ha
	la 4,.LC48@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L107
	lis 4,.LC49@ha
	lwz 3,52(31)
	la 4,.LC49@l(4)
	bl strcmp
.L107:
	lwz 9,84(30)
	stw 31,4148(9)
.L105:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 Use_Weapon,.Lfe6-Use_Weapon
	.align 2
	.globl Drop_Weapon
	.type	 Drop_Weapon,@function
Drop_Weapon:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 11,dmflags@ha
	lwz 10,dmflags@l(11)
	mr 30,3
	mr 29,4
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,4
	bc 4,2,.L135
	lis 9,itemlist@ha
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 9,9,29
	cmpwi 0,29,0
	mullw 9,9,0
	srawi 9,9,3
	bc 12,2,.L135
	lwz 11,84(30)
	slwi 27,9,2
	lwz 0,4148(11)
	cmpw 0,29,0
	bc 4,2,.L137
	addi 9,11,740
	lwzx 0,9,27
	cmpwi 0,0,1
	bc 12,2,.L135
.L137:
	lwz 3,52(29)
	lis 4,.LC37@ha
	la 4,.LC37@l(4)
	bl strcmp
	mr. 3,3
	bc 4,2,.L139
	lwz 9,84(30)
	lwz 11,4464(9)
	lwz 0,4472(9)
	stw 3,4464(9)
	add 31,11,0
	stw 3,4472(9)
	b .L140
.L139:
	lis 28,team_list@ha
	lwz 3,88(29)
	la 9,team_list@l(28)
	lwz 4,4(9)
	addi 4,4,100
	bl strcmp
	mr. 3,3
	bc 4,2,.L141
	lwz 0,68(29)
	cmpwi 0,0,3
	bc 4,2,.L142
	lwz 9,84(30)
	lwz 31,4448(9)
	stw 3,4448(9)
	b .L140
.L142:
	cmpwi 0,0,4
	bc 4,2,.L144
	lwz 9,84(30)
	lwz 11,4464(9)
	lwz 0,4472(9)
	stw 3,4464(9)
	add 31,11,0
	b .L140
.L144:
	cmpwi 0,0,10
	bc 4,2,.L146
	lwz 9,84(30)
	lwz 11,4472(9)
	lwz 0,4464(9)
	stw 3,4472(9)
	add 31,11,0
	b .L140
.L146:
	cmpwi 0,0,5
	bc 4,2,.L148
	lwz 9,84(30)
	lwz 31,4456(9)
	stw 3,4456(9)
	b .L140
.L148:
	cmpwi 0,0,6
	bc 4,2,.L150
	lwz 9,84(30)
	lwz 31,4480(9)
	stw 3,4480(9)
	b .L140
.L150:
	cmpwi 0,0,7
	bc 4,2,.L152
	lwz 9,84(30)
	lwz 31,4488(9)
	stw 3,4488(9)
	b .L140
.L152:
	cmpwi 0,0,9
	bc 4,2,.L140
	lwz 9,84(30)
	lwz 31,4492(9)
	stw 3,4492(9)
	b .L140
.L141:
	lwz 4,team_list@l(28)
	lwz 3,88(29)
	addi 4,4,100
	bl strcmp
	mr. 3,3
	bc 4,2,.L156
	lwz 0,68(29)
	cmpwi 0,0,3
	bc 4,2,.L157
	lwz 9,84(30)
	lwz 31,4400(9)
	stw 3,4400(9)
	b .L140
.L157:
	cmpwi 0,0,5
	bc 4,2,.L159
	lwz 9,84(30)
	lwz 31,4408(9)
	stw 3,4408(9)
	b .L140
.L159:
	cmpwi 0,0,6
	bc 4,2,.L161
	lwz 9,84(30)
	lwz 31,4432(9)
	stw 3,4432(9)
	b .L140
.L161:
	cmpwi 0,0,7
	bc 4,2,.L163
	lwz 9,84(30)
	lwz 31,4440(9)
	stw 3,4440(9)
	b .L140
.L163:
	cmpwi 0,0,9
	bc 4,2,.L165
	lwz 9,84(30)
	lwz 31,4444(9)
	stw 3,4444(9)
	b .L140
.L165:
	cmpwi 0,0,10
	bc 4,2,.L167
	lwz 9,84(30)
	lwz 11,4424(9)
	lwz 0,4416(9)
	stw 3,4424(9)
	add 31,11,0
	b .L140
.L167:
	cmpwi 0,0,4
	bc 4,2,.L140
	lwz 9,84(30)
	lwz 11,4416(9)
	lwz 0,4424(9)
	stw 3,4416(9)
	add 31,11,0
	b .L140
.L156:
	lwz 3,52(29)
	lis 4,.LC49@ha
	la 4,.LC49@l(4)
	bl strcmp
	mr. 3,3
	bc 4,2,.L140
	lwz 9,84(30)
	lwz 31,4504(9)
	stw 3,4504(9)
.L140:
	lwz 9,96(29)
	cmpwi 0,9,0
	bc 12,2,.L172
	stw 31,112(9)
.L172:
	mr 4,29
	mr 3,30
	bl Drop_Item
	lwz 9,84(30)
	li 0,0
	addi 9,9,740
	stwx 0,9,27
.L135:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 Drop_Weapon,.Lfe7-Drop_Weapon
	.section	".rodata"
	.align 3
.LC51:
	.long 0x405638e3
	.long 0x8e38e38e
	.align 3
.LC53:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC54:
	.long 0x40060000
	.long 0x0
	.align 3
.LC55:
	.long 0x40790000
	.long 0x0
	.align 2
.LC56:
	.long 0x0
	.section	".text"
	.align 2
	.globl weapon_grenade_fire
	.type	 weapon_grenade_fire,@function
weapon_grenade_fire:
	stwu 1,-112(1)
	mflr 0
	stfd 31,104(1)
	stmw 30,96(1)
	stw 0,116(1)
	mr 31,3
	li 0,265
	lwz 9,512(31)
	xoris 0,0,0x8000
	stw 0,92(1)
	lis 8,0x4330
	mr 10,11
	stw 8,88(1)
	addi 9,9,-8
	lis 7,.LC53@ha
	lfd 13,88(1)
	xoris 9,9,0x8000
	la 7,.LC53@l(7)
	stw 9,92(1)
	lis 0,0x4100
	addi 4,1,24
	stw 8,88(1)
	addi 5,1,40
	mr 30,4
	lfd 12,0(7)
	li 6,0
	lfd 0,88(1)
	lwz 3,84(31)
	fsub 13,13,12
	stw 0,12(1)
	fsub 0,0,12
	addi 3,3,4264
	stw 0,8(1)
	frsp 31,13
	frsp 0,0
	stfs 0,16(1)
	bl AngleVectors
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
	bc 4,2,.L174
	fneg 0,13
	stfs 0,76(1)
	b .L175
.L174:
	cmpwi 0,0,2
	bc 4,2,.L175
	li 0,0
	stw 0,4(10)
.L175:
	addi 4,1,72
	addi 5,1,24
	addi 6,1,40
	addi 7,1,56
	bl G_ProjectSource
	lwz 9,84(31)
	lwz 0,0(9)
	cmpwi 0,0,2
	bc 4,2,.L178
	li 7,5
	b .L179
.L178:
	lwz 8,4356(9)
	lis 11,level+4@ha
	lis 7,.LC54@ha
	lfs 7,level+4@l(11)
	la 7,.LC54@l(7)
	lfs 0,432(8)
	mr 10,9
	lis 0,0x4330
	lfd 9,0(7)
	lis 8,.LC53@ha
	lis 11,.LC51@ha
	la 8,.LC53@l(8)
	lis 7,.LC55@ha
	lfd 11,.LC51@l(11)
	fsubs 0,0,7
	lfd 8,0(8)
	la 7,.LC55@l(7)
	mr 8,9
	lfd 10,0(7)
	fneg 0,0
	fadd 0,0,9
	fctiwz 13,0
	stfd 13,88(1)
	lwz 9,92(1)
	xoris 9,9,0x8000
	stw 9,92(1)
	stw 0,88(1)
	lfd 0,88(1)
	fsub 0,0,8
	fmadd 0,0,11,10
	fctiwz 12,0
	stfd 12,88(1)
	lwz 7,92(1)
.L179:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,88(1)
	lwz 11,92(1)
	andi. 8,11,8192
	bc 4,2,.L180
	lwz 9,84(31)
	lwz 0,4128(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	addi 11,11,-1
	stwx 11,9,0
.L180:
	lis 9,.LC56@ha
	fmr 2,31
	mr 3,31
	la 9,.LC56@l(9)
	mr 5,30
	lfs 1,0(9)
	addi 4,1,56
	li 6,225
	li 8,0
	bl fire_grenade2
	lwz 0,116(1)
	mtlr 0
	lmw 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe8:
	.size	 weapon_grenade_fire,.Lfe8-weapon_grenade_fire
	.section	".rodata"
	.align 2
.LC58:
	.string	"hgrenade"
	.align 2
.LC59:
	.string	"%s"
	.align 2
.LC60:
	.string	"Potato Masher"
	.align 2
.LC61:
	.string	"USA Grenade"
	.align 2
.LC57:
	.long 0x46fffe00
	.align 3
.LC63:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC64:
	.long 0x40120000
	.long 0x0
	.align 3
.LC65:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl weapon_grenade_prime
	.type	 weapon_grenade_prime,@function
weapon_grenade_prime:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 28,16(1)
	stw 0,52(1)
	mr 30,3
	mr 28,4
	bl rand
	li 29,255
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 5,0x4330
	stw 3,12(1)
	lis 8,.LC63@ha
	lis 6,.LC57@ha
	stw 5,8(1)
	la 8,.LC63@l(8)
	lis 10,level+4@ha
	lfd 11,0(8)
	mr 11,9
	mr 7,9
	lfd 13,8(1)
	li 8,295
	lfs 10,.LC57@l(6)
	xoris 8,8,0x8000
	lfs 31,level+4@l(10)
	fsub 13,13,11
	lis 10,.LC64@ha
	la 10,.LC64@l(10)
	lfd 0,0(10)
	frsp 13,13
	fadd 31,31,0
	fdivs 13,13,10
	fmr 0,13
	fctiwz 12,0
	stfd 12,8(1)
	lwz 11,12(1)
	srawi 10,11,31
	xor 0,10,11
	subf 0,10,0
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 5,8(1)
	lfd 0,8(1)
	stw 8,12(1)
	stw 5,8(1)
	lfd 30,8(1)
	fsub 0,0,11
	fsub 30,30,11
	fadd 31,31,0
	frsp 30,30
	frsp 31,31
	bl G_Spawn
	lis 9,0x600
	lis 10,.LC58@ha
	mr 31,3
	li 0,0
	ori 9,9,3
	la 10,.LC58@l(10)
	stfs 31,432(31)
	li 8,9
	li 11,1
	stw 0,200(31)
	stw 8,264(31)
	stw 9,252(31)
	stw 11,248(31)
	stw 29,520(31)
	stfs 30,528(31)
	stw 10,284(31)
	stw 0,196(31)
	stw 0,192(31)
	stw 0,188(31)
	stw 0,208(31)
	stw 0,204(31)
	stw 30,256(31)
	stw 28,952(31)
	lwz 9,84(30)
	lwz 9,1796(9)
	cmpwi 0,9,0
	bc 12,2,.L182
	lwz 0,68(9)
	cmpwi 0,0,12
	bc 4,2,.L182
	stw 9,664(31)
	b .L183
.L182:
	cmpwi 0,28,0
	bc 12,2,.L184
	lis 9,.LC60@ha
	la 4,.LC60@l(9)
	b .L185
.L184:
	lis 9,.LC61@ha
	la 4,.LC61@l(9)
.L185:
	lis 3,.LC59@ha
	la 3,.LC59@l(3)
	crxor 6,6,6
	bl va
	bl FindItem
	stw 3,664(31)
.L183:
	bl rand
	lis 0,0x51eb
	srawi 11,3,31
	ori 0,0,34079
	mulhw 0,3,0
	lis 10,0x4330
	lis 8,.LC63@ha
	la 8,.LC63@l(8)
	srawi 0,0,5
	lfd 13,0(8)
	subf 0,11,0
	lis 8,.LC65@ha
	mulli 0,0,100
	la 8,.LC65@l(8)
	lfd 12,0(8)
	subf 3,0,3
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 10,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L186
	lis 9,Shrapnel_Explode@ha
	la 9,Shrapnel_Explode@l(9)
	stw 9,440(31)
	b .L187
.L186:
	lwz 0,664(31)
	lis 9,itemlist@ha
	lis 10,0xc4ec
	la 9,itemlist@l(9)
	ori 10,10,20165
	lwz 8,84(30)
	subf 0,9,0
	lis 11,Shrapnel_Dud@ha
	mullw 0,0,10
	la 11,Shrapnel_Dud@l(11)
	srawi 0,0,3
	stw 0,4360(8)
	stw 11,440(31)
.L187:
	li 0,1
	lis 9,gi+72@ha
	stw 0,288(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 9,84(30)
	stw 31,4356(9)
	lwz 0,52(1)
	mtlr 0
	lmw 28,16(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 weapon_grenade_prime,.Lfe9-weapon_grenade_prime
	.section	".rodata"
	.align 2
.LC66:
	.string	"%i / %i - %s\n"
	.align 2
.LC67:
	.string	"weapons/noammo.wav"
	.align 2
.LC68:
	.string	"weapons/hgrena1b.wav"
	.align 2
.LC69:
	.string	"weapons/throw.wav"
	.align 2
.LC70:
	.long 0x3f800000
	.align 2
.LC71:
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_Grenade
	.type	 Weapon_Grenade,@function
Weapon_Grenade:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 10,84(31)
	lwz 0,4360(10)
	cmpwi 0,0,0
	bc 4,2,.L223
	lwz 0,4128(10)
	addi 11,10,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L190
	b .L189
.L223:
	slwi 0,0,2
	addi 9,10,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,2,.L189
	lwz 0,4192(10)
	cmpwi 0,0,3
	bc 12,2,.L189
.L190:
	lwz 29,84(31)
	lwz 11,3448(29)
	lwz 9,3464(29)
	lwz 10,96(11)
	slwi 9,9,2
	lwzx 11,9,10
	lwz 3,8(11)
	cmpwi 0,3,0
	bc 12,2,.L192
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 3,9,3
	addi 11,29,740
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,11,3
	cmpwi 0,0,0
	bc 12,2,.L192
	lwz 11,84(31)
	lwz 10,3448(11)
	lwz 9,3464(11)
	lwz 8,96(10)
	slwi 9,9,2
	lwzx 11,9,8
	lwz 3,8(11)
	bl FindItem
	lwz 9,84(31)
	stw 3,4148(9)
	mr 3,31
	bl ChangeWeapon
	b .L193
.L192:
	mr 3,31
	bl Cmd_WeapNext_f
.L193:
	lwz 9,84(31)
	li 0,0
	stw 0,4360(9)
.L189:
	lwz 11,84(31)
	lwz 6,1796(11)
	cmpwi 0,6,0
	bc 12,2,.L194
	lwz 6,40(6)
	cmpwi 0,6,0
	bc 12,2,.L194
	lis 9,frame_output@ha
	lwz 0,frame_output@l(9)
	cmpwi 0,0,0
	bc 12,2,.L194
	lis 9,gi+4@ha
	lis 3,.LC66@ha
	lwz 5,92(11)
	lwz 0,gi+4@l(9)
	la 3,.LC66@l(3)
	lwz 4,4192(11)
	mtlr 0
	crxor 6,6,6
	blrl
.L194:
	lwz 9,84(31)
	li 11,0
	stw 11,4528(9)
	lwz 9,84(31)
	lwz 0,4392(9)
	cmpwi 0,0,0
	bc 12,2,.L195
	stw 11,4392(9)
.L195:
	lwz 9,84(31)
	lwz 0,4148(9)
	cmpwi 0,0,0
	bc 12,2,.L196
	lwz 0,4192(9)
	cmpwi 0,0,0
	bc 4,2,.L196
	mr 3,31
	bl ChangeWeapon
	b .L188
.L196:
	lwz 11,84(31)
	lwz 9,4192(11)
	addi 9,9,-6
	cmplwi 0,9,1
	bc 12,1,.L197
	li 0,0
	stw 0,4192(11)
	lwz 11,84(31)
	lwz 0,4356(11)
	addic 0,0,-1
	subfe 0,0,0
	nor 9,0,0
	andi. 0,0,18
	andi. 9,9,10
	or 0,0,9
	stw 0,92(11)
.L197:
	lwz 9,84(31)
	lwz 0,4192(9)
	cmpwi 0,0,1
	bc 4,2,.L200
	li 0,0
	stw 0,4192(9)
	lwz 11,84(31)
	lwz 0,4356(11)
	addic 0,0,-1
	subfe 0,0,0
	nor 9,0,0
	andi. 0,0,18
	andi. 9,9,10
	or 0,0,9
	stw 0,92(11)
	b .L188
.L200:
	cmpwi 0,0,0
	bc 4,2,.L203
	lwz 11,4140(9)
	lwz 0,4132(9)
	or 0,11,0
	andi. 8,0,1
	bc 12,2,.L204
	rlwinm 0,11,0,0,30
	stw 0,4140(9)
	lwz 10,84(31)
	lwz 0,4128(10)
	addi 11,10,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L205
	lwz 9,4356(10)
	li 11,3
	srawi 8,9,31
	xor 0,8,9
	subf 0,0,8
	srawi 0,0,31
	andi. 0,0,11
	ori 0,0,1
	stw 0,92(10)
	lwz 9,84(31)
	stw 11,4192(9)
	b .L188
.L205:
	lis 9,level@ha
	lfs 13,468(31)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L188
	lis 29,gi@ha
	lis 3,.LC67@ha
	la 29,gi@l(29)
	la 3,.LC67@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC70@ha
	lis 9,.LC70@ha
	lis 10,.LC71@ha
	la 8,.LC70@l(8)
	mr 5,3
	la 9,.LC70@l(9)
	lfs 1,0(8)
	mtlr 0
	la 10,.LC71@l(10)
	li 4,2
	lfs 2,0(9)
	mr 3,31
	lfs 3,0(10)
	blrl
	lis 8,.LC70@ha
	lfs 0,4(30)
	la 8,.LC70@l(8)
	lfs 13,0(8)
	fadds 0,0,13
	stfs 0,468(31)
	b .L188
.L204:
	lwz 0,4356(9)
	cmpwi 0,0,0
	bc 12,2,.L210
	li 0,10
	stw 0,92(9)
	b .L188
.L210:
	lwz 11,92(9)
	xori 9,11,29
	subfic 10,9,0
	adde 9,10,9
	xori 0,11,41
	subfic 8,0,0
	adde 0,8,0
	or. 10,9,0
	bc 4,2,.L213
	cmpwi 0,11,19
	bc 12,2,.L213
	cmpwi 0,11,48
	bc 4,2,.L212
.L213:
	bl rand
	andi. 0,3,15
	bc 4,2,.L188
.L212:
	lwz 9,84(31)
	lwz 11,92(9)
	addi 11,11,1
	stw 11,92(9)
	lwz 3,84(31)
	lwz 0,92(3)
	cmpwi 0,0,50
	bc 4,1,.L188
	li 0,18
	b .L224
.L203:
	cmpwi 0,0,3
	bc 4,2,.L188
	lwz 0,92(9)
	cmpwi 0,0,5
	bc 4,2,.L217
	lwz 0,4356(9)
	cmpwi 0,0,0
	bc 4,2,.L217
	lis 29,gi@ha
	lis 3,.LC68@ha
	la 29,gi@l(29)
	la 3,.LC68@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC70@ha
	lis 9,.LC70@ha
	lis 10,.LC71@ha
	la 9,.LC70@l(9)
	mr 5,3
	la 8,.LC70@l(8)
	lfs 2,0(9)
	mtlr 0
	la 10,.LC71@l(10)
	li 4,1
	lfs 1,0(8)
	mr 3,31
	lfs 3,0(10)
	blrl
	lwz 11,84(31)
	mr 3,31
	lwz 9,3448(11)
	lwz 4,84(9)
	bl weapon_grenade_prime
.L217:
	lwz 11,84(31)
	lwz 10,92(11)
	cmpwi 0,10,13
	bc 4,2,.L218
	lwz 9,4132(11)
	lwz 0,4140(11)
	or 0,0,9
	andi. 8,0,1
	bc 4,2,.L188
.L218:
	cmpwi 0,10,14
	bc 4,2,.L220
	mr 3,31
	bl weapon_grenade_fire
.L220:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,15
	bc 4,2,.L221
	lis 29,gi@ha
	lis 3,.LC69@ha
	la 29,gi@l(29)
	la 3,.LC69@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC70@ha
	lis 9,.LC70@ha
	lis 10,.LC71@ha
	mr 5,3
	la 8,.LC70@l(8)
	la 9,.LC70@l(9)
	mtlr 0
	la 10,.LC71@l(10)
	li 4,1
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L221:
	lwz 3,84(31)
	lwz 9,92(3)
	cmpwi 0,9,16
	bc 4,1,.L222
	li 0,0
	stw 0,4192(3)
	b .L188
.L222:
	addi 0,9,1
.L224:
	stw 0,92(3)
.L188:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 Weapon_Grenade,.Lfe10-Weapon_Grenade
	.section	".rodata"
	.align 3
.LC72:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC73:
	.long 0xc0000000
	.section	".text"
	.align 2
	.globl weapon_grenadelauncher_fire
	.type	 weapon_grenadelauncher_fire,@function
weapon_grenadelauncher_fire:
	stwu 1,-128(1)
	mflr 0
	stmw 29,116(1)
	stw 0,132(1)
	mr 31,3
	lwz 9,512(31)
	lis 10,0x4330
	lis 8,.LC72@ha
	la 8,.LC72@l(8)
	lwz 3,84(31)
	lis 0,0x4100
	addi 9,9,-8
	lfd 13,0(8)
	addi 4,1,24
	xoris 9,9,0x8000
	stw 0,12(1)
	addi 3,3,4264
	stw 9,108(1)
	mr 29,4
	addi 5,1,40
	stw 10,104(1)
	li 6,0
	lfd 0,104(1)
	stw 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,16(1)
	bl AngleVectors
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
	bc 4,2,.L226
	fneg 0,13
	stfs 0,76(1)
	b .L227
.L226:
	cmpwi 0,0,2
	bc 4,2,.L227
	li 0,0
	stw 0,4(10)
.L227:
	addi 4,1,72
	addi 5,1,24
	addi 6,1,40
	addi 7,1,56
	bl G_ProjectSource
	lis 8,.LC73@ha
	lwz 4,84(31)
	mr 3,29
	la 8,.LC73@l(8)
	lfs 1,0(8)
	addi 4,4,4212
	bl VectorScale
	lwz 9,84(31)
	lis 0,0xbf80
	lis 29,gi@ha
	la 29,gi@l(29)
	li 3,1
	stw 0,4200(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xefdf
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49023
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lis 9,is_silenced@ha
	lwz 11,100(29)
	lbz 3,is_silenced@l(9)
	mtlr 11
	ori 3,3,8
	blrl
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
	lwz 11,84(31)
	mr 3,31
	addi 4,1,56
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
	bc 4,2,.L230
	lwz 9,84(31)
	lwz 0,4128(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	addi 11,11,-1
	stwx 11,9,0
.L230:
	lwz 0,132(1)
	mtlr 0
	lmw 29,116(1)
	la 1,128(1)
	blr
.Lfe11:
	.size	 weapon_grenadelauncher_fire,.Lfe11-weapon_grenadelauncher_fire
	.section	".data"
	.align 2
	.type	 pause_frames.45,@object
pause_frames.45:
	.long 34
	.long 51
	.long 59
	.long 0
	.align 2
	.type	 fire_frames.46,@object
fire_frames.46:
	.long 6
	.long 0
	.section	".rodata"
	.align 2
.LC74:
	.string	"brain/melee3.wav"
	.align 2
.LC75:
	.long 0x41a00000
	.align 3
.LC76:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC77:
	.long 0x3f800000
	.align 2
.LC78:
	.long 0x0
	.section	".text"
	.align 2
	.globl fire_Knife
	.type	 fire_Knife,@function
fire_Knife:
	stwu 1,-128(1)
	mflr 0
	stmw 24,96(1)
	stw 0,132(1)
	mr 28,9
	mr 30,3
	lis 9,.LC75@ha
	addi 29,1,80
	la 9,.LC75@l(9)
	mr 3,4
	lfs 1,0(9)
	mr 27,5
	mr 25,6
	mr 24,7
	mr 26,8
	mr 4,27
	mr 5,29
	bl VectorMA
	lis 11,gi@ha
	lis 9,0x600
	la 31,gi@l(11)
	ori 9,9,3
	lwz 11,48(31)
	mr 7,29
	addi 3,1,16
	addi 4,30,4
	li 5,0
	li 6,0
	mr 8,30
	mtlr 11
	blrl
	lwz 9,60(1)
	cmpwi 0,9,0
	bc 12,2,.L234
	lwz 0,16(9)
	andi. 9,0,4
	bc 4,2,.L232
.L234:
	lfs 0,24(1)
	lis 9,.LC76@ha
	la 9,.LC76@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L232
	lwz 3,68(1)
	lwz 0,516(3)
	cmpwi 0,0,0
	bc 12,2,.L236
	cmpwi 0,28,0
	li 0,8
	stw 0,8(1)
	addi 7,1,28
	addi 8,1,40
	mfcr 29
	li 0,36
	bc 12,2,.L237
	li 0,37
.L237:
	stw 0,12(1)
	mr 9,25
	mr 6,27
	mr 10,24
	mr 4,30
	mr 5,30
	bl T_Damage
	lis 9,gi@ha
	mtcrf 128,29
	la 31,gi@l(9)
	bc 12,2,.L239
	mr 3,26
	b .L240
.L239:
	lis 9,.LC74@ha
	la 3,.LC74@l(9)
.L240:
	lwz 9,36(31)
	mtlr 9
	blrl
	lis 9,.LC77@ha
	lwz 0,16(31)
	mr 5,3
	la 9,.LC77@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC77@ha
	la 9,.LC77@l(9)
	lfs 2,0(9)
	lis 9,.LC78@ha
	la 9,.LC78@l(9)
	lfs 3,0(9)
	blrl
	b .L232
.L236:
	lwz 9,100(31)
	li 3,3
	addi 29,1,28
	mtlr 9
	blrl
	lwz 9,100(31)
	li 3,9
	mtlr 9
	blrl
	lwz 9,120(31)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,124(31)
	addi 3,1,40
	mtlr 9
	blrl
	lwz 9,88(31)
	li 4,2
	mr 3,29
	mtlr 9
	blrl
	lwz 9,36(31)
	mr 3,26
	mtlr 9
	blrl
	lis 9,.LC77@ha
	lwz 0,16(31)
	mr 5,3
	la 9,.LC77@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC77@ha
	la 9,.LC77@l(9)
	lfs 2,0(9)
	lis 9,.LC78@ha
	la 9,.LC78@l(9)
	lfs 3,0(9)
	blrl
.L232:
	lwz 0,132(1)
	mtlr 0
	lmw 24,96(1)
	la 1,128(1)
	blr
.Lfe12:
	.size	 fire_Knife,.Lfe12-fire_Knife
	.section	".rodata"
	.align 2
.LC79:
	.string	"blade"
	.align 2
.LC80:
	.string	"Helmet"
	.align 2
.LC81:
	.string	"Knife"
	.align 2
.LC82:
	.string	"knife/hit.wav"
	.align 2
.LC83:
	.long 0x42f00000
	.align 2
.LC84:
	.long 0x3f800000
	.align 2
.LC85:
	.long 0x0
	.section	".text"
	.align 2
	.globl Blade_touch
	.type	 Blade_touch,@function
Blade_touch:
	stwu 1,-80(1)
	mflr 0
	stmw 26,56(1)
	stw 0,84(1)
	mr 27,4
	mr 31,3
	lwz 3,284(31)
	lis 4,.LC79@ha
	mr 26,5
	mr 30,6
	la 4,.LC79@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L244
	lis 3,.LC80@ha
	la 3,.LC80@l(3)
	b .L253
.L244:
	lis 3,.LC81@ha
	la 3,.LC81@l(3)
.L253:
	bl FindItem
	mr 28,3
	lwz 0,256(31)
	cmpw 0,27,0
	mr 3,0
	bc 12,2,.L243
	cmpwi 0,30,0
	bc 12,2,.L247
	lwz 0,16(30)
	andi. 9,0,4
	bc 12,2,.L247
	mr 4,28
	mr 3,31
	bl Drop_Item
	mr 3,31
	bl G_FreeEdict
	b .L243
.L247:
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L248
	addi 4,31,4
	li 5,2
	bl PlayerNoise
.L248:
	lwz 0,516(27)
	cmpwi 0,0,0
	bc 12,2,.L249
	lwz 5,256(31)
	li 0,4
	li 11,36
	lwz 9,520(31)
	mr 8,26
	mr 3,27
	stw 0,8(1)
	mr 4,31
	addi 6,31,380
	stw 11,12(1)
	addi 7,31,4
	li 10,1
	bl T_Damage
	b .L250
.L249:
	bl G_Spawn
	lwz 9,0(28)
	mr 29,3
	lis 0,0x1
	stw 0,288(29)
	li 8,512
	lis 11,0xc170
	stw 9,284(29)
	lis 10,0x4170
	stw 28,664(29)
	lis 9,gi@ha
	lwz 0,28(28)
	la 30,gi@l(9)
	stw 8,68(29)
	stw 0,64(29)
	stw 11,196(29)
	stw 10,208(29)
	stw 11,188(29)
	stw 11,192(29)
	stw 10,200(29)
	stw 10,204(29)
	lwz 9,44(30)
	lwz 4,24(28)
	mtlr 9
	blrl
	lis 9,Touch_Item@ha
	li 0,7
	stw 31,256(29)
	li 10,0
	li 11,1
	stw 0,264(29)
	la 9,Touch_Item@l(9)
	addi 4,1,16
	stw 10,412(29)
	addi 3,31,380
	stw 11,248(29)
	stw 9,448(29)
	bl vectoangles
	lfs 0,4(31)
	lis 9,.LC83@ha
	lis 11,level+4@ha
	la 9,.LC83@l(9)
	lis 3,.LC82@ha
	lfs 11,0(9)
	la 3,.LC82@l(3)
	stfs 0,4(29)
	lis 9,G_FreeEdict@ha
	lfs 0,8(31)
	la 9,G_FreeEdict@l(9)
	stfs 0,8(29)
	lfs 13,12(31)
	stfs 13,12(29)
	lfs 0,16(1)
	stfs 0,16(29)
	lfs 13,20(1)
	stfs 13,20(29)
	lfs 12,24(1)
	stfs 12,24(29)
	lfs 0,level+4@l(11)
	stw 9,440(29)
	fadds 0,0,11
	stfs 0,432(29)
	lwz 9,36(30)
	mtlr 9
	blrl
	lis 9,.LC84@ha
	lwz 11,16(30)
	mr 5,3
	la 9,.LC84@l(9)
	mr 3,29
	lfs 1,0(9)
	mtlr 11
	li 4,1
	lis 9,.LC84@ha
	la 9,.LC84@l(9)
	lfs 2,0(9)
	lis 9,.LC85@ha
	la 9,.LC85@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,72(30)
	mr 3,29
	mtlr 9
	blrl
	lwz 0,620(31)
	cmpwi 0,0,0
	bc 4,2,.L250
	lwz 9,100(30)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,9
	mtlr 9
	blrl
	lwz 9,120(30)
	addi 3,1,32
	mtlr 9
	blrl
	lwz 9,124(30)
	mr 3,26
	mtlr 9
	blrl
	lwz 0,88(30)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
.L250:
	lwz 3,84(27)
	cmpwi 0,3,0
	bc 12,2,.L252
	lis 11,itemlist@ha
	lis 0,0xc4ec
	la 11,itemlist@l(11)
	ori 0,0,20165
	subf 11,11,28
	addi 10,3,740
	mullw 11,11,0
	mr 3,31
	srawi 11,11,3
	slwi 11,11,2
	lwzx 9,10,11
	addi 9,9,1
	stwx 9,10,11
	bl G_FreeEdict
	b .L243
.L252:
	mr 3,31
	bl G_FreeEdict
.L243:
	lwz 0,84(1)
	mtlr 0
	lmw 26,56(1)
	la 1,80(1)
	blr
.Lfe13:
	.size	 Blade_touch,.Lfe13-Blade_touch
	.section	".rodata"
	.align 2
.LC87:
	.string	"models/weapons/g_helmet/tris.md2"
	.align 2
.LC88:
	.string	"models/weapons/g_knife/tris.md2"
	.align 2
.LC89:
	.string	"fists"
	.align 2
.LC86:
	.long 0x446d8000
	.align 2
.LC90:
	.long 0x44160000
	.align 2
.LC91:
	.long 0x40000000
	.align 3
.LC92:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC93:
	.long 0xc1200000
	.section	".text"
	.align 2
	.globl Knife_Throw
	.type	 Knife_Throw,@function
Knife_Throw:
	stwu 1,-96(1)
	mflr 0
	stmw 26,72(1)
	stw 0,100(1)
	mr 27,3
	mr 29,4
	lwz 11,84(27)
	lis 4,.LC81@ha
	mr 28,5
	mr 26,6
	la 4,.LC81@l(4)
	lwz 9,1796(11)
	lwz 3,40(9)
	bl Q_stricmp
	mr 30,3
	mr 3,28
	bl VectorNormalize
	bl G_Spawn
	lfs 13,0(29)
	mr 31,3
	mr 3,28
	addi 4,31,16
	stfs 13,4(31)
	lfs 0,4(29)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	lfs 0,0(29)
	stfs 0,28(31)
	lfs 13,4(29)
	stfs 13,32(31)
	lfs 0,8(29)
	stfs 0,36(31)
	bl vectoangles
	cmpwi 0,30,0
	bc 12,2,.L255
	lis 9,.LC90@ha
	la 9,.LC90@l(9)
	lfs 1,0(9)
	b .L256
.L255:
	lis 9,.LC86@ha
	lfs 1,.LC86@l(9)
.L256:
	cmpwi 0,30,0
	mr 3,28
	addi 4,31,380
	mfcr 30
	bl VectorScale
	lwz 11,64(31)
	lis 0,0x600
	li 9,0
	li 8,7
	ori 0,0,3
	stw 9,200(31)
	ori 11,11,1024
	li 10,2
	stw 8,264(31)
	stw 0,252(31)
	mtcrf 128,30
	stw 10,248(31)
	stw 11,64(31)
	stw 9,196(31)
	stw 9,192(31)
	stw 9,188(31)
	stw 9,208(31)
	stw 9,204(31)
	bc 12,2,.L257
	lis 9,gi+32@ha
	lis 3,.LC87@ha
	lwz 0,gi+32@l(9)
	la 3,.LC87@l(3)
	b .L262
.L257:
	lis 9,gi+32@ha
	lis 3,.LC88@ha
	lwz 0,gi+32@l(9)
	la 3,.LC88@l(3)
.L262:
	mtlr 0
	blrl
	stw 3,40(31)
	lis 11,Blade_touch@ha
	lis 9,.LC91@ha
	stw 27,256(31)
	la 11,Blade_touch@l(11)
	la 9,.LC91@l(9)
	lis 10,level+4@ha
	stw 11,448(31)
	li 0,0
	lfs 0,level+4@l(10)
	mtcrf 128,30
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	stw 26,520(31)
	la 9,G_FreeEdict@l(9)
	stw 0,56(31)
	fadds 0,0,13
	stw 9,440(31)
	stfs 0,432(31)
	bc 12,2,.L259
	lis 9,.LC89@ha
	la 9,.LC89@l(9)
	b .L263
.L259:
	lis 9,.LC79@ha
	la 9,.LC79@l(9)
.L263:
	stw 9,284(31)
	li 0,1
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,288(31)
	mr 3,31
	lwz 9,72(29)
	addi 30,31,4
	mtlr 9
	blrl
	lwz 0,48(29)
	lis 9,0x600
	addi 4,27,4
	ori 9,9,3
	addi 3,1,8
	li 5,0
	li 6,0
	mtlr 0
	mr 7,30
	mr 8,31
	blrl
	lfs 0,16(1)
	lis 9,.LC92@ha
	la 9,.LC92@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L261
	lis 9,.LC93@ha
	mr 3,30
	la 9,.LC93@l(9)
	mr 5,3
	lfs 1,0(9)
	mr 4,28
	bl VectorMA
	lwz 0,448(31)
	mr 3,31
	li 5,0
	lwz 4,60(1)
	li 6,0
	mtlr 0
	blrl
.L261:
	lwz 0,100(1)
	mtlr 0
	lmw 26,72(1)
	la 1,96(1)
	blr
.Lfe14:
	.size	 Knife_Throw,.Lfe14-Knife_Throw
	.section	".rodata"
	.align 2
.LC94:
	.string	"fists/hit.wav"
	.align 2
.LC95:
	.string	"fists/fire.wav"
	.align 2
.LC96:
	.string	"knife/fire.wav"
	.align 3
.LC97:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC98:
	.long 0x41c00000
	.align 2
.LC99:
	.long 0x41000000
	.align 2
.LC100:
	.long 0xc0000000
	.section	".text"
	.align 2
	.globl Weapon_Knife_Fire
	.type	 Weapon_Knife_Fire,@function
Weapon_Knife_Fire:
	stwu 1,-144(1)
	mflr 0
	mfcr 12
	stmw 28,128(1)
	stw 0,148(1)
	stw 12,124(1)
	mr 30,3
	lis 31,.LC81@ha
	lwz 11,84(30)
	la 4,.LC81@l(31)
	lwz 9,1796(11)
	lwz 3,40(9)
	bl Q_stricmp
	mr. 29,3
	bc 12,2,.L265
	lis 3,.LC80@ha
	la 3,.LC80@l(3)
	b .L285
.L265:
	la 3,.LC81@l(31)
.L285:
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 3,9,3
	mullw 3,3,0
	srawi 31,3,3
	cmpwi 4,29,0
	bc 4,18,.L267
	lwz 10,84(30)
	slwi 0,31,2
	addi 9,10,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,2,.L267
	lwz 9,1796(10)
	lwz 9,96(9)
	cmpwi 0,9,0
	bc 12,2,.L268
	lwz 0,32(9)
	stw 0,92(10)
.L268:
	lwz 9,84(30)
	stw 29,4392(9)
	b .L264
.L267:
	lis 9,vec3_origin@ha
	lwz 3,84(30)
	addi 4,1,8
	la 11,vec3_origin@l(9)
	lfs 13,vec3_origin@l(9)
	addi 5,1,24
	lfs 12,8(11)
	addi 3,3,4264
	li 6,0
	lfs 0,4(11)
	stfs 13,72(1)
	stfs 12,80(1)
	stfs 0,76(1)
	bl AngleVectors
	lwz 9,512(30)
	lis 0,0x4330
	lfs 11,72(1)
	addi 3,30,4
	addi 10,1,88
	addi 9,9,-8
	lfs 9,76(1)
	mr 28,3
	xoris 9,9,0x8000
	lfs 8,80(1)
	stw 9,116(1)
	lis 9,.LC97@ha
	stw 0,112(1)
	la 9,.LC97@l(9)
	lfd 0,112(1)
	lfd 10,0(9)
	lis 9,.LC98@ha
	la 9,.LC98@l(9)
	lfs 13,0(9)
	fsub 0,0,10
	lis 9,.LC99@ha
	la 9,.LC99@l(9)
	lfs 12,0(9)
	frsp 0,0
	fadds 11,11,13
	lwz 9,84(30)
	fadds 9,9,12
	fadds 0,0,8
	stfs 11,88(1)
	stfs 11,56(1)
	stfs 9,60(1)
	stfs 9,92(1)
	stfs 0,96(1)
	stfs 0,64(1)
	lwz 0,716(9)
	cmpwi 0,0,1
	bc 4,2,.L269
	fneg 0,9
	stfs 0,92(1)
	b .L270
.L269:
	cmpwi 0,0,2
	bc 4,2,.L270
	li 0,0
	stw 0,4(10)
.L270:
	addi 4,1,88
	addi 5,1,8
	addi 6,1,24
	addi 7,1,40
	bl G_ProjectSource
	lis 9,.LC100@ha
	lwz 4,84(30)
	addi 3,1,8
	la 9,.LC100@l(9)
	lfs 1,0(9)
	addi 4,4,4212
	bl VectorScale
	lwz 9,84(30)
	lis 0,0xbf80
	stw 0,4200(9)
	lwz 9,84(30)
	lwz 0,4392(9)
	cmpwi 0,0,0
	bc 12,2,.L273
	slwi 31,31,2
	addi 9,9,740
	lwzx 0,9,31
	cmpwi 0,0,0
	bc 12,2,.L274
	mfcr 0
	rlwinm 0,0,19,1
	mr 3,30
	neg 0,0
	addi 4,1,40
	nor 6,0,0
	addi 5,1,8
	rlwinm 0,0,0,27,30
	andi. 6,6,5
	or 6,0,6
	bl Knife_Throw
	lwz 11,84(30)
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-1
	stwx 9,11,31
.L274:
	lwz 11,84(30)
	addi 9,11,740
	lwzx 0,9,31
	cmpwi 0,0,0
	bc 4,2,.L278
	stw 0,4392(11)
	lis 3,.LC89@ha
	lwz 9,84(30)
	li 0,7
	la 3,.LC89@l(3)
	stw 0,4192(9)
	bl FindItem
	mr 4,3
	mr 3,30
	bl Use_Weapon
	b .L278
.L273:
	mfcr 0
	rlwinm 0,0,19,1
	neg 0,0
	rlwinm 0,0,0,27,30
	ori 6,0,10
	bc 12,18,.L281
	lis 9,.LC94@ha
	la 8,.LC94@l(9)
	b .L282
.L281:
	lis 9,.LC82@ha
	la 8,.LC82@l(9)
.L282:
	addi 4,1,40
	mr 9,29
	mr 3,30
	addi 5,1,8
	li 7,500
	bl fire_Knife
.L278:
	lwz 11,84(30)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	bc 12,18,.L283
	lis 9,.LC95@ha
	la 4,.LC95@l(9)
	b .L284
.L283:
	lis 9,.LC96@ha
	la 4,.LC96@l(9)
.L284:
	mr 3,30
	bl Play_WepSound
	mr 3,30
	mr 4,28
	li 5,0
	bl PlayerNoise
.L264:
	lwz 0,148(1)
	lwz 12,124(1)
	mtlr 0
	lmw 28,128(1)
	mtcrf 8,12
	la 1,144(1)
	blr
.Lfe15:
	.size	 Weapon_Knife_Fire,.Lfe15-Weapon_Knife_Fire
	.section	".data"
	.align 2
	.type	 pause_frames.62,@object
pause_frames.62:
	.long 0
	.section	".rodata"
	.align 2
.LC101:
	.long 7
	.long 9
	.align 2
.LC102:
	.string	"knife/pullout.wav"
	.section	".text"
	.align 2
	.globl Weapon_Knife
	.type	 Weapon_Knife,@function
Weapon_Knife:
	stwu 1,-64(1)
	mflr 0
	stmw 30,56(1)
	stw 0,68(1)
	lis 9,.LC101@ha
	mr 31,3
	la 9,.LC101@l(9)
	lwz 11,84(31)
	lis 4,.LC81@ha
	lfd 0,0(9)
	la 4,.LC81@l(4)
	stfd 0,32(1)
	lwz 9,1796(11)
	lwz 3,40(9)
	bl Q_stricmp
	lwz 9,84(31)
	li 10,0
	mr. 3,3
	stw 10,4528(9)
	lwz 11,84(31)
	mcrf 7,0
	stw 10,4496(11)
	lwz 11,84(31)
	lwz 0,4392(11)
	addic 0,0,-1
	subfe 0,0,0
	nor 9,0,0
	rlwinm 0,0,0,29,31
	andi. 9,9,54
	or 0,0,9
	stw 0,32(1)
	bc 12,30,.L289
	addi 9,1,32
	stw 10,4(9)
	mr 30,9
	b .L290
.L289:
	lwz 0,4392(11)
	addi 9,1,32
	mr 30,9
	addic 0,0,-1
	subfe 0,0,0
	andi. 0,0,9
	stw 0,4(9)
.L290:
	cmpwi 0,3,0
	bc 4,2,.L293
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,1
	bc 4,2,.L293
	lis 4,.LC102@ha
	mr 3,31
	la 4,.LC102@l(4)
	bl Play_WepSound
.L293:
	lis 9,pause_frames.62@ha
	li 10,71
	stw 30,20(1)
	la 9,pause_frames.62@l(9)
	lis 11,Weapon_Knife_Fire@ha
	stw 10,12(1)
	la 11,Weapon_Knife_Fire@l(11)
	li 0,59
	stw 9,16(1)
	stw 0,8(1)
	mr 3,31
	li 4,3
	li 5,10
	li 6,45
	stw 11,24(1)
	li 7,45
	li 8,45
	li 9,49
	li 10,53
	bl Weapon_Generic
	lwz 0,68(1)
	mtlr 0
	lmw 30,56(1)
	la 1,64(1)
	blr
.Lfe16:
	.size	 Weapon_Knife,.Lfe16-Weapon_Knife
	.section	".data"
	.align 2
	.type	 pause_frames.69,@object
pause_frames.69:
	.long 19
	.long 32
	.long 0
	.align 2
	.type	 fire_frames.70,@object
fire_frames.70:
	.long 6
	.align 2
	.type	 pause_frames.77,@object
pause_frames.77:
	.long 19
	.long 32
	.long 0
	.align 2
	.type	 fire_frames.78,@object
fire_frames.78:
	.long 6
	.section	".rodata"
	.align 2
.LC104:
	.string	"You have been fully recovered by %s.\n"
	.align 2
.LC105:
	.string	"You have fully recovered %s.\n"
	.align 2
.LC106:
	.string	"You were patched up by %s.\n"
	.align 2
.LC107:
	.string	"You patched up %s.\n"
	.align 2
.LC108:
	.string	"items/morphine1.wav"
	.align 2
.LC109:
	.string	"items/morphine2.wav"
	.align 2
.LC110:
	.string	"items/morphine3.wav"
	.align 2
.LC111:
	.string	"items/l_health.wav"
	.align 2
.LC103:
	.long 0x46fffe00
	.align 3
.LC112:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC113:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC114:
	.long 0x401c0000
	.long 0x0
	.align 2
.LC115:
	.long 0x0
	.align 2
.LC116:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Weapon_Morphine_Use
	.type	 Weapon_Morphine_Use,@function
Weapon_Morphine_Use:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 30,3
	lwz 10,84(30)
	lwz 9,92(10)
	addi 9,9,1
	stw 9,92(10)
	lwz 11,84(30)
	lwz 0,4392(11)
	cmpwi 0,0,0
	bc 12,2,.L302
	mr 31,30
	b .L303
.L302:
	mr 3,30
	bl ApplyFirstAid
	mr. 31,3
	bc 12,2,.L301
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L301
.L303:
	lis 9,level+4@ha
	lfs 13,988(31)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 12,1,.L301
	lwz 0,620(31)
	cmpwi 0,0,3
	bc 12,2,.L301
	lwz 11,484(31)
	li 0,0
	stw 0,692(31)
	addi 9,11,-1
	stw 0,688(31)
	cmplwi 0,9,98
	bc 12,1,.L301
	cmpw 0,31,30
	bc 4,2,.L309
	bl rand
	lwz 0,484(30)
	lis 8,0x4330
	rlwinm 3,3,0,17,31
	mr 11,9
	xoris 0,0,0x8000
	xoris 3,3,0x8000
	stw 0,28(1)
	lis 10,.LC112@ha
	lis 7,.LC103@ha
	stw 8,24(1)
	la 10,.LC112@l(10)
	lfd 12,24(1)
	stw 3,28(1)
	stw 8,24(1)
	lfd 0,0(10)
	lfd 13,24(1)
	lis 10,.LC113@ha
	lfs 11,.LC103@l(7)
	la 10,.LC113@l(10)
	fsub 12,12,0
	lfd 9,0(10)
	fsub 13,13,0
	lis 10,.LC114@ha
	la 10,.LC114@l(10)
	lfd 8,0(10)
	frsp 13,13
	mr 10,9
	fdivs 13,13,11
	fmr 0,13
	fsub 0,0,9
	fadd 0,0,0
	fadd 0,0,8
	fadd 12,12,0
	fctiwz 10,12
	stfd 10,24(1)
	lwz 10,28(1)
	stw 10,484(30)
	b .L310
.L309:
	subfic 9,11,100
	cmpwi 7,9,49
	mfcr 9
	rlwinm. 9,9,30,1
	li 0,100
	bc 4,2,.L311
	addi 0,11,50
.L311:
	stw 0,484(31)
	xor 0,31,30
	addic 10,9,-1
	subfe 11,10,9
	addic 10,0,-1
	subfe 9,10,0
	and. 0,11,9
	bc 12,2,.L313
	lis 9,invuln_medic@ha
	lis 10,.LC115@ha
	lwz 11,invuln_medic@l(9)
	la 10,.LC115@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L313
	lis 9,team_kill@ha
	lwz 11,team_kill@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L313
	lwz 0,688(31)
	cmpwi 0,0,0
	bc 12,2,.L313
	lis 29,gi@ha
	lwz 6,84(30)
	lis 5,.LC104@ha
	la 29,gi@l(29)
	la 5,.LC104@l(5)
	lwz 9,8(29)
	li 4,2
	addi 6,6,700
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,12(29)
	lis 4,.LC105@ha
	mr 3,30
	lwz 5,84(31)
	la 4,.LC105@l(4)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	lwz 11,84(30)
	lwz 9,3424(11)
	addi 9,9,1
	stw 9,3424(11)
	lwz 10,84(31)
	lwz 9,84(30)
	lwz 11,3448(10)
	lwz 0,3448(9)
	cmpw 0,11,0
	bc 4,2,.L310
	lwz 0,84(11)
	lis 11,team_list@ha
	addic 0,0,-1
	subfe 0,0,0
	la 11,team_list@l(11)
	rlwinm 0,0,0,29,29
	lwzx 10,11,0
	lwz 9,76(10)
	addi 9,9,-1
	stw 9,76(10)
	b .L310
.L313:
	lis 29,gi@ha
	lwz 6,84(30)
	lis 5,.LC106@ha
	la 29,gi@l(29)
	la 5,.LC106@l(5)
	lwz 9,8(29)
	addi 6,6,700
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 6,84(31)
	lis 5,.LC107@ha
	mr 3,30
	lwz 0,8(29)
	la 5,.LC107@l(5)
	li 4,2
	addi 6,6,700
	mtlr 0
	crxor 6,6,6
	blrl
.L310:
	bl rand
	bl srand
	bl rand
	lis 0,0x51eb
	srawi 11,3,31
	ori 0,0,34079
	mulhw 0,3,0
	srawi 0,0,5
	subf 9,11,0
	mulli 9,9,100
	subf 9,9,3
	addi 0,9,-1
	cmplwi 0,0,31
	bc 12,1,.L322
	lis 29,gi@ha
	lis 3,.LC108@ha
	la 29,gi@l(29)
	la 3,.LC108@l(3)
	b .L330
.L322:
	addi 0,9,-34
	cmplwi 0,0,31
	bc 12,1,.L324
	lis 29,gi@ha
	lis 3,.LC109@ha
	la 29,gi@l(29)
	la 3,.LC109@l(3)
	b .L330
.L324:
	addi 0,9,-67
	cmplwi 0,0,32
	bc 12,1,.L326
	lis 29,gi@ha
	lis 3,.LC110@ha
	la 29,gi@l(29)
	la 3,.LC110@l(3)
.L330:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC116@ha
	lis 10,.LC116@ha
	lis 11,.LC115@ha
	mr 5,3
	la 9,.LC116@l(9)
	la 10,.LC116@l(10)
	mtlr 0
	la 11,.LC115@l(11)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L323
.L326:
	lis 29,gi@ha
	lis 3,.LC111@ha
	la 29,gi@l(29)
	la 3,.LC111@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC116@ha
	lis 10,.LC116@ha
	lis 11,.LC115@ha
	mr 5,3
	la 9,.LC116@l(9)
	la 10,.LC116@l(10)
	mtlr 0
	la 11,.LC115@l(11)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L323:
	lwz 0,484(31)
	cmpwi 0,0,100
	bc 4,1,.L328
	li 0,100
	stw 0,484(31)
.L328:
	mr 3,30
	bl WeighPlayer
.L301:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 Weapon_Morphine_Use,.Lfe17-Weapon_Morphine_Use
	.section	".data"
	.align 2
	.type	 pause_frames.85,@object
pause_frames.85:
	.long 0
	.section	".sbss","aw",@nobits
	.align 2
fire_frames.86:
	.space	4
	.size	 fire_frames.86,4
	.section	".rodata"
	.align 2
.LC117:
	.string	"Bandage"
	.align 2
.LC118:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl Weapon_Bandage_Use
	.type	 Weapon_Bandage_Use,@function
Weapon_Bandage_Use:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 30,3
	lwz 11,84(30)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	bl ApplyFirstAid
	mr. 31,3
	bc 12,2,.L334
	lwz 0,688(31)
	andi. 9,0,6
	bc 12,2,.L336
	lwz 9,692(31)
	cmpwi 0,9,0
	bc 12,2,.L337
	addi 0,9,360
	stw 0,692(31)
	b .L338
.L337:
	lis 9,.LC118@ha
	lis 11,level+4@ha
	la 9,.LC118@l(9)
	lfs 0,level+4@l(11)
	lfs 12,0(9)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	stw 9,692(31)
.L338:
	lwz 0,688(31)
	lis 3,.LC117@ha
	la 3,.LC117@l(3)
	rlwinm 0,0,0,31,28
	stw 0,688(31)
	bl FindItem
	lis 9,itemlist@ha
	lis 11,0xc4ec
	lwz 10,84(30)
	la 9,itemlist@l(9)
	ori 11,11,20165
	subf 0,9,3
	addi 10,10,740
	mullw 0,0,11
	mr 3,31
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	addi 9,9,-1
	stwx 9,10,0
	bl WeighPlayer
	b .L334
.L336:
	lis 27,.LC117@ha
	lis 28,0xc4ec
	la 3,.LC117@l(27)
	ori 28,28,20165
	bl FindItem
	lis 29,itemlist@ha
	lwz 11,84(30)
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 11,11,740
	mullw 0,0,28
	la 3,.LC117@l(27)
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	bl FindItem
	subf 3,29,3
	lwz 11,84(31)
	mullw 3,3,28
	addi 11,11,740
	srawi 3,3,3
	slwi 3,3,2
	lwzx 9,11,3
	addi 9,9,1
	stwx 9,11,3
.L334:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 Weapon_Bandage_Use,.Lfe18-Weapon_Bandage_Use
	.section	".data"
	.align 2
	.type	 pause_frames.93,@object
pause_frames.93:
	.long 19
	.long 32
	.long 0
	.align 2
	.type	 fire_frames.94,@object
fire_frames.94:
	.long 6
	.section	".rodata"
	.align 2
.LC119:
	.long 0x3f800000
	.long 0x3f800000
	.long 0x3f800000
	.align 2
.LC120:
	.long 0x40a00000
	.long 0x40a00000
	.long 0x0
	.align 2
.LC121:
	.string	"weapons/flamer/fire.wav"
	.align 2
.LC122:
	.long 0x3f800000
	.align 2
.LC123:
	.long 0x0
	.align 3
.LC124:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC125:
	.long 0xc0000000
	.section	".text"
	.align 2
	.globl weapon_flame_fire
	.type	 weapon_flame_fire,@function
weapon_flame_fire:
	stwu 1,-192(1)
	mflr 0
	stmw 24,160(1)
	stw 0,196(1)
	lis 9,.LC119@ha
	addi 10,1,80
	lwz 5,.LC119@l(9)
	addi 11,1,96
	lis 7,.LC120@ha
	la 9,.LC119@l(9)
	la 6,.LC120@l(7)
	lwz 8,.LC120@l(7)
	lwz 0,4(9)
	mr 24,10
	mr 31,3
	lwz 4,8(9)
	mr 25,11
	stw 5,80(1)
	addi 9,1,112
	stw 0,4(10)
	mr 26,9
	stw 4,8(10)
	stw 5,96(1)
	stw 0,4(11)
	stw 4,8(11)
	lwz 3,84(31)
	lwz 0,4(6)
	lwz 10,8(6)
	stw 8,112(1)
	stw 0,4(9)
	stw 10,8(9)
	lwz 0,4140(3)
	lwz 9,4132(3)
	or 0,0,9
	andi. 0,0,1
	bc 4,2,.L342
	stw 0,4320(3)
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L341
.L342:
	lwz 0,4504(3)
	cmpwi 0,0,0
	bc 4,2,.L343
	li 0,6
	lis 9,level@ha
	stw 0,92(3)
	la 30,level@l(9)
	lfs 13,4(30)
	lfs 0,468(31)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L341
	lis 29,gi@ha
	lis 3,.LC67@ha
	la 29,gi@l(29)
	la 3,.LC67@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC122@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC122@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC122@ha
	la 9,.LC122@l(9)
	lfs 2,0(9)
	lis 9,.LC123@ha
	la 9,.LC123@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC122@ha
	lfs 0,4(30)
	la 9,.LC122@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,468(31)
	b .L341
.L343:
	addi 3,3,4264
	addi 4,1,16
	addi 5,1,32
	li 6,0
	bl AngleVectors
	lwz 9,512(31)
	lis 0,0x4330
	lwz 8,84(31)
	lis 10,0x4240
	addi 3,31,4
	addi 9,9,-8
	stw 10,128(1)
	addi 7,1,128
	xoris 9,9,0x8000
	stw 10,64(1)
	mr 27,3
	stw 9,156(1)
	lis 9,.LC124@ha
	stw 0,152(1)
	la 9,.LC124@l(9)
	lfd 0,152(1)
	lfd 13,0(9)
	lis 9,0x4100
	stw 9,132(1)
	fsub 0,0,13
	stw 9,68(1)
	frsp 0,0
	stfs 0,136(1)
	stfs 0,72(1)
	lwz 0,716(8)
	cmpwi 0,0,1
	bc 4,2,.L345
	lis 0,0xc100
	stw 0,132(1)
	b .L346
.L345:
	cmpwi 0,0,2
	bc 4,2,.L346
	li 0,0
	stw 0,4(7)
.L346:
	addi 4,1,128
	addi 5,1,16
	addi 6,1,32
	addi 7,1,48
	bl G_ProjectSource
	lis 9,.LC125@ha
	lwz 4,84(31)
	addi 3,1,16
	la 9,.LC125@l(9)
	lfs 1,0(9)
	addi 4,4,4212
	bl VectorScale
	lwz 9,84(31)
	lis 0,0xbf80
	stw 0,4200(9)
	lwz 11,84(31)
	lwz 10,4320(11)
	mulli 9,10,150
	addi 30,9,250
	cmpwi 0,30,199
	bc 4,1,.L349
	li 0,0
	li 30,200
	b .L351
.L349:
	addi 0,10,1
.L351:
	stw 0,4320(11)
	lis 29,gi@ha
	lis 3,.LC121@ha
	la 29,gi@l(29)
	la 3,.LC121@l(3)
	lwz 9,36(29)
	addi 28,1,48
	mtlr 9
	blrl
	lis 9,.LC122@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC122@l(9)
	mr 3,31
	lfs 1,0(9)
	mtlr 11
	li 4,0
	lis 9,.LC122@ha
	la 9,.LC122@l(9)
	lfs 2,0(9)
	lis 9,.LC123@ha
	la 9,.LC123@l(9)
	lfs 3,0(9)
	blrl
	li 0,0
	mr 9,25
	li 10,10
	mr 5,26
	stw 0,8(1)
	mr 8,24
	mr 7,30
	mr 4,28
	addi 6,1,16
	mr 3,31
	bl PBM_FireFlameThrower
	lwz 11,84(31)
	li 3,1
	lwz 9,4504(11)
	addi 9,9,-1
	stw 9,4504(11)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xefdf
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49023
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lwz 9,100(29)
	li 3,45
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	mr 3,31
	mr 4,28
	li 5,1
	bl PlayerNoise
.L341:
	lwz 0,196(1)
	mtlr 0
	lmw 24,160(1)
	la 1,192(1)
	blr
.Lfe19:
	.size	 weapon_flame_fire,.Lfe19-weapon_flame_fire
	.section	".data"
	.align 2
	.type	 pause_frames.101,@object
pause_frames.101:
	.long 0
	.align 2
	.type	 fire_frames.102,@object
fire_frames.102:
	.long 4
	.long 5
	.section	".rodata"
	.align 3
.LC126:
	.long 0x403aaaaa
	.long 0xaaaaaaab
	.align 3
.LC128:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC129:
	.long 0x40060000
	.long 0x0
	.align 3
.LC130:
	.long 0x40790000
	.long 0x0
	.align 2
.LC131:
	.long 0x0
	.section	".text"
	.align 2
	.globl weapon_tnt_fire
	.type	 weapon_tnt_fire,@function
weapon_tnt_fire:
	stwu 1,-112(1)
	mflr 0
	stfd 31,104(1)
	stmw 30,96(1)
	stw 0,116(1)
	mr 31,3
	li 0,265
	lwz 9,512(31)
	xoris 0,0,0x8000
	stw 0,92(1)
	lis 8,0x4330
	mr 10,11
	stw 8,88(1)
	addi 9,9,-8
	lis 7,.LC128@ha
	lfd 13,88(1)
	xoris 9,9,0x8000
	la 7,.LC128@l(7)
	stw 9,92(1)
	lis 0,0x4180
	addi 4,1,24
	stw 8,88(1)
	lis 9,0xc180
	mr 30,4
	lfd 12,0(7)
	addi 5,1,40
	li 6,0
	lfd 0,88(1)
	lwz 3,84(31)
	fsub 13,13,12
	stw 0,8(1)
	fsub 0,0,12
	stw 9,12(1)
	addi 3,3,4264
	frsp 31,13
	frsp 0,0
	stfs 0,16(1)
	bl AngleVectors
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
	bc 4,2,.L354
	fneg 0,13
	stfs 0,76(1)
	b .L355
.L354:
	cmpwi 0,0,2
	bc 4,2,.L355
	li 0,0
	stw 0,4(10)
.L355:
	addi 4,1,72
	addi 5,1,24
	addi 6,1,40
	addi 7,1,56
	bl G_ProjectSource
	lwz 9,84(31)
	lwz 0,0(9)
	cmpwi 0,0,2
	bc 4,2,.L358
	li 7,5
	b .L359
.L358:
	lwz 8,4364(9)
	lis 11,level+4@ha
	lis 7,.LC129@ha
	lfs 7,level+4@l(11)
	la 7,.LC129@l(7)
	lfs 0,432(8)
	mr 10,9
	lis 0,0x4330
	lfd 9,0(7)
	lis 8,.LC128@ha
	lis 11,.LC126@ha
	la 8,.LC128@l(8)
	lis 7,.LC130@ha
	lfd 11,.LC126@l(11)
	fsubs 0,0,7
	lfd 8,0(8)
	la 7,.LC130@l(7)
	mr 8,9
	lfd 10,0(7)
	fneg 0,0
	fadd 0,0,9
	fctiwz 13,0
	stfd 13,88(1)
	lwz 9,92(1)
	xoris 9,9,0x8000
	stw 9,92(1)
	stw 0,88(1)
	lfd 0,88(1)
	fsub 0,0,8
	fmadd 0,0,11,10
	fctiwz 12,0
	stfd 12,88(1)
	lwz 7,92(1)
.L359:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,88(1)
	lwz 11,92(1)
	andi. 8,11,8192
	bc 4,2,.L360
	lwz 9,84(31)
	lwz 0,4128(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	addi 11,11,-1
	stwx 11,9,0
.L360:
	lis 9,.LC131@ha
	fmr 2,31
	mr 3,31
	la 9,.LC131@l(9)
	mr 5,30
	lfs 1,0(9)
	addi 4,1,56
	li 6,225
	li 8,0
	bl fire_tnt
	lwz 0,116(1)
	mtlr 0
	lmw 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe20:
	.size	 weapon_tnt_fire,.Lfe20-weapon_tnt_fire
	.section	".rodata"
	.align 2
.LC135:
	.string	"tnt"
	.align 2
.LC136:
	.string	"weapons/tnt/fizz.wav"
	.align 2
.LC133:
	.long 0x44098000
	.align 3
.LC134:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC137:
	.long 0x41700000
	.section	".text"
	.align 2
	.globl weapon_tnt_prime
	.type	 weapon_tnt_prime,@function
weapon_tnt_prime:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 23,20(1)
	stw 0,68(1)
	mr 23,4
	mr 25,3
	bl rand
	li 26,1
	li 24,1500
	lis 9,.LC133@ha
	lis 27,level@ha
	la 27,level@l(27)
	lfs 31,.LC133@l(9)
	bl G_Spawn
	lis 0,0x600
	mr 29,3
	li 9,0
	ori 0,0,3
	stw 26,248(29)
	li 11,9
	stw 0,252(29)
	lis 8,.LC134@ha
	stw 11,264(29)
	lis 10,TNT_Think@ha
	lis 28,gi@ha
	stw 9,200(29)
	la 10,TNT_Think@l(10)
	lis 11,.LC137@ha
	stw 9,196(29)
	la 11,.LC137@l(11)
	la 28,gi@l(28)
	stw 9,192(29)
	lis 3,.LC136@ha
	stw 9,188(29)
	la 3,.LC136@l(3)
	stw 9,208(29)
	stw 9,204(29)
	stw 25,256(29)
	lfs 0,4(27)
	lfd 13,.LC134@l(8)
	stw 10,440(29)
	lfs 12,0(11)
	lis 11,.LC135@ha
	la 11,.LC135@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lfs 13,4(27)
	stw 11,284(29)
	stw 24,520(29)
	fadds 13,13,12
	stfs 31,528(29)
	stw 23,952(29)
	stfs 13,604(29)
	lwz 9,36(28)
	mtlr 9
	blrl
	stw 3,76(29)
	stw 26,288(29)
	mr 3,29
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 9,84(25)
	stw 29,4364(9)
	lwz 0,68(1)
	mtlr 0
	lmw 23,20(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe21:
	.size	 weapon_tnt_prime,.Lfe21-weapon_tnt_prime
	.section	".rodata"
	.align 2
.LC138:
	.string	"weapons/tnt/pullout.wav"
	.align 2
.LC139:
	.string	"weapons/tnt/light.wav"
	.align 2
.LC140:
	.string	"weapons/tnt/toss.wav"
	.align 2
.LC141:
	.long 0x3f800000
	.align 2
.LC142:
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_TNT
	.type	 Weapon_TNT,@function
Weapon_TNT:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4128(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,2,.L363
	bl Cmd_WeapNext_f
.L363:
	lwz 9,84(31)
	li 11,0
	stw 11,4528(9)
	lwz 9,84(31)
	lwz 0,4392(9)
	cmpwi 0,0,0
	bc 12,2,.L364
	stw 11,4392(9)
.L364:
	lwz 11,84(31)
	lwz 6,1796(11)
	cmpwi 0,6,0
	bc 12,2,.L365
	lwz 6,40(6)
	cmpwi 0,6,0
	bc 12,2,.L365
	lis 9,frame_output@ha
	lwz 0,frame_output@l(9)
	cmpwi 0,0,0
	bc 12,2,.L365
	lis 9,gi+4@ha
	lis 3,.LC66@ha
	lwz 5,92(11)
	lwz 0,gi+4@l(9)
	la 3,.LC66@l(3)
	lwz 4,4192(11)
	mtlr 0
	crxor 6,6,6
	blrl
.L365:
	lwz 9,84(31)
	lwz 0,4148(9)
	cmpwi 0,0,0
	bc 12,2,.L366
	lwz 0,4192(9)
	cmpwi 0,0,0
	bc 4,2,.L366
	mr 3,31
	bl ChangeWeapon
	b .L362
.L366:
	lwz 11,84(31)
	lwz 9,4192(11)
	addi 9,9,-6
	cmplwi 0,9,1
	bc 12,1,.L367
	li 0,0
	stw 0,4192(11)
	lwz 11,84(31)
	lwz 0,4364(11)
	addic 0,0,-1
	subfe 0,0,0
	nor 9,0,0
	andi. 0,0,18
	andi. 9,9,10
	or 0,0,9
	stw 0,92(11)
.L367:
	lwz 9,84(31)
	lwz 30,4192(9)
	cmpwi 0,30,1
	bc 4,2,.L370
	lis 29,gi@ha
	lis 3,.LC138@ha
	la 29,gi@l(29)
	la 3,.LC138@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC141@ha
	lis 9,.LC141@ha
	lis 10,.LC142@ha
	la 9,.LC141@l(9)
	la 10,.LC142@l(10)
	mr 5,3
	lfs 2,0(9)
	mtlr 0
	la 8,.LC141@l(8)
	lfs 3,0(10)
	li 4,1
	mr 3,31
	lfs 1,0(8)
	blrl
	lwz 11,84(31)
	li 0,0
	li 10,52
	stw 30,92(11)
	lwz 9,84(31)
	stw 0,4192(9)
	lwz 11,84(31)
	stw 10,92(11)
	b .L362
.L370:
	cmpwi 0,30,0
	bc 4,2,.L371
	lwz 11,4140(9)
	lwz 0,4132(9)
	or 0,11,0
	andi. 8,0,1
	bc 12,2,.L372
	rlwinm 0,11,0,0,30
	stw 0,4140(9)
	lwz 10,84(31)
	lwz 0,4128(10)
	addi 11,10,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L373
	lwz 9,4364(10)
	li 11,3
	srawi 8,9,31
	xor 0,8,9
	subf 0,0,8
	srawi 0,0,31
	andi. 0,0,11
	ori 0,0,1
	stw 0,92(10)
	lwz 9,84(31)
	stw 11,4192(9)
	b .L362
.L373:
	lis 9,level@ha
	lfs 13,468(31)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L362
	lis 29,gi@ha
	lis 3,.LC67@ha
	la 29,gi@l(29)
	la 3,.LC67@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC141@ha
	lis 9,.LC141@ha
	lis 10,.LC142@ha
	la 8,.LC141@l(8)
	mr 5,3
	la 9,.LC141@l(9)
	lfs 1,0(8)
	mtlr 0
	la 10,.LC142@l(10)
	li 4,1
	lfs 2,0(9)
	mr 3,31
	lfs 3,0(10)
	blrl
	lis 8,.LC141@ha
	lfs 0,4(30)
	la 8,.LC141@l(8)
	lfs 13,0(8)
	fadds 0,0,13
	stfs 0,468(31)
	b .L362
.L372:
	lwz 0,4364(9)
	cmpwi 0,0,0
	bc 12,2,.L378
	li 0,10
	stw 0,92(9)
	b .L371
.L378:
	lwz 11,92(9)
	xori 9,11,29
	subfic 10,9,0
	adde 9,10,9
	xori 0,11,41
	subfic 8,0,0
	adde 0,8,0
	or. 10,9,0
	bc 4,2,.L381
	cmpwi 0,11,19
	bc 12,2,.L381
	cmpwi 0,11,48
	bc 4,2,.L380
.L381:
	bl rand
	andi. 0,3,15
	bc 4,2,.L362
.L380:
	lwz 9,84(31)
	lwz 11,92(9)
	addi 11,11,1
	stw 11,92(9)
	lwz 3,84(31)
	lwz 0,92(3)
	cmpwi 0,0,50
	bc 4,1,.L362
	li 0,18
	b .L392
.L371:
	lwz 9,84(31)
	lwz 0,4192(9)
	cmpwi 0,0,3
	bc 4,2,.L362
	lwz 0,92(9)
	cmpwi 0,0,1
	bc 4,2,.L385
	lis 29,gi@ha
	lis 3,.LC139@ha
	la 29,gi@l(29)
	la 3,.LC139@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC141@ha
	lis 9,.LC141@ha
	lis 10,.LC142@ha
	mr 5,3
	la 8,.LC141@l(8)
	la 9,.LC141@l(9)
	mtlr 0
	la 10,.LC142@l(10)
	li 4,1
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L385:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,10
	bc 4,2,.L386
	lwz 0,4364(9)
	cmpwi 0,0,0
	bc 4,2,.L386
	lwz 9,3448(9)
	mr 3,31
	lwz 4,84(9)
	bl weapon_tnt_prime
.L386:
	lwz 9,84(31)
	lwz 11,92(9)
	cmpwi 0,11,13
	bc 4,2,.L387
	lwz 0,4132(9)
	andi. 8,0,1
	bc 4,2,.L362
.L387:
	cmpwi 0,11,14
	bc 4,2,.L389
	mr 3,31
	bl weapon_tnt_fire
.L389:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,15
	bc 4,2,.L390
	lis 29,gi@ha
	lis 3,.LC140@ha
	la 29,gi@l(29)
	la 3,.LC140@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC141@ha
	lis 9,.LC141@ha
	lis 10,.LC142@ha
	mr 5,3
	la 8,.LC141@l(8)
	la 9,.LC141@l(9)
	mtlr 0
	la 10,.LC142@l(10)
	li 4,1
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L390:
	lwz 3,84(31)
	lwz 9,92(3)
	cmpwi 0,9,16
	bc 4,1,.L391
	li 0,0
	stw 0,4192(3)
	b .L362
.L391:
	addi 0,9,1
.L392:
	stw 0,92(3)
.L362:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 Weapon_TNT,.Lfe22-Weapon_TNT
	.comm	is_silenced,1,1
	.align 2
	.globl Think_Weapon
	.type	 Think_Weapon,@function
Think_Weapon:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 11,84(31)
	lwz 9,4396(11)
	cmpwi 0,9,0
	bc 4,2,.L99
	lwz 0,484(31)
	cmpwi 0,0,0
	bc 12,1,.L101
	stw 9,4148(11)
	bl ChangeWeapon
.L101:
	lwz 11,84(31)
	lwz 9,1796(11)
	cmpwi 0,9,0
	bc 12,2,.L99
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L99
	lwz 0,4368(11)
	cmpwi 0,0,0
	bc 12,2,.L103
	lis 9,is_silenced@ha
	li 0,128
	b .L394
.L103:
	lis 9,is_silenced@ha
.L394:
	stb 0,is_silenced@l(9)
	lwz 11,84(31)
	mr 3,31
	lwz 9,1796(11)
	lwz 0,16(9)
	mtlr 0
	blrl
.L99:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe23:
	.size	 Think_Weapon,.Lfe23-Think_Weapon
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.align 2
	.globl P_ProjectSource
	.type	 P_ProjectSource,@function
P_ProjectSource:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lfs 12,4(5)
	mr 9,7
	lfs 13,8(5)
	mr 7,8
	lfs 0,0(5)
	stfs 12,12(1)
	stfs 13,16(1)
	stfs 0,8(1)
	lwz 0,716(3)
	cmpwi 0,0,1
	bc 4,2,.L7
	fneg 0,12
	stfs 0,12(1)
	b .L8
.L7:
	cmpwi 0,0,2
	bc 4,2,.L8
	li 0,0
	stw 0,12(1)
.L8:
	mr 3,4
	mr 5,6
	mr 6,9
	addi 4,1,8
	bl G_ProjectSource
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe24:
	.size	 P_ProjectSource,.Lfe24-P_ProjectSource
	.align 2
	.globl Weapon_Mine
	.type	 Weapon_Mine,@function
Weapon_Mine:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lis 9,pause_frames.45@ha
	lis 10,weapon_grenadelauncher_fire@ha
	la 9,pause_frames.45@l(9)
	la 10,weapon_grenadelauncher_fire@l(10)
	lis 11,fire_frames.46@ha
	li 0,0
	stw 9,16(1)
	la 11,fire_frames.46@l(11)
	stw 10,24(1)
	li 4,5
	stw 11,20(1)
	li 5,16
	li 6,59
	stw 0,12(1)
	li 7,64
	li 8,0
	stw 0,8(1)
	li 9,0
	li 10,0
	bl Weapon_Generic
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe25:
	.size	 Weapon_Mine,.Lfe25-Weapon_Mine
	.section	".rodata"
	.align 2
.LC143:
	.long 0x41c80000
	.section	".text"
	.align 2
	.globl Weapon_Binoculars_Look
	.type	 Weapon_Binoculars_Look,@function
Weapon_Binoculars_Look:
	lwz 9,84(3)
	lwz 0,4132(9)
	andi. 11,0,1
	bc 4,2,.L295
	li 0,7
	lis 11,0x42aa
	stw 0,92(9)
	lwz 9,84(3)
	stw 11,112(9)
	blr
.L295:
	li 0,1
	stw 0,4528(9)
	lwz 9,84(3)
	lwz 0,92(9)
	cmpwi 0,0,6
	bc 4,1,.L296
	li 0,6
	stw 0,92(9)
.L296:
	lwz 3,84(3)
	lis 9,.LC143@ha
	la 9,.LC143@l(9)
	lfs 13,0(9)
	lfs 0,112(3)
	fcmpu 0,0,13
	bclr 12,2
	stfs 13,112(3)
	blr
.Lfe26:
	.size	 Weapon_Binoculars_Look,.Lfe26-Weapon_Binoculars_Look
	.align 2
	.globl Weapon_Binoculars
	.type	 Weapon_Binoculars,@function
Weapon_Binoculars:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	lwz 9,84(3)
	li 0,0
	lis 11,pause_frames.69@ha
	lis 29,fire_frames.70@ha
	lis 28,Weapon_Binoculars_Look@ha
	stw 0,4392(9)
	la 11,pause_frames.69@l(11)
	la 29,fire_frames.70@l(29)
	lwz 9,84(3)
	la 28,Weapon_Binoculars_Look@l(28)
	li 4,3
	li 5,8
	li 6,48
	stw 0,4528(9)
	li 7,48
	li 8,48
	stw 0,12(1)
	li 9,51
	li 10,0
	stw 11,16(1)
	stw 29,20(1)
	stw 28,24(1)
	stw 0,8(1)
	bl Weapon_Generic
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe27:
	.size	 Weapon_Binoculars,.Lfe27-Weapon_Binoculars
	.align 2
	.globl Weapon_Antidote_Use
	.type	 Weapon_Antidote_Use,@function
Weapon_Antidote_Use:
	blr
.Lfe28:
	.size	 Weapon_Antidote_Use,.Lfe28-Weapon_Antidote_Use
	.align 2
	.globl Weapon_Antidote
	.type	 Weapon_Antidote,@function
Weapon_Antidote:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lis 9,pause_frames.77@ha
	lis 10,Weapon_Antidote_Use@ha
	la 9,pause_frames.77@l(9)
	la 10,Weapon_Antidote_Use@l(10)
	lis 11,fire_frames.78@ha
	li 0,0
	stw 9,16(1)
	la 11,fire_frames.78@l(11)
	stw 10,24(1)
	li 4,3
	stw 11,20(1)
	li 5,8
	li 6,48
	stw 0,12(1)
	li 7,52
	li 8,48
	stw 0,8(1)
	li 9,48
	li 10,0
	bl Weapon_Generic
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe29:
	.size	 Weapon_Antidote,.Lfe29-Weapon_Antidote
	.align 2
	.globl Weapon_Morphine
	.type	 Weapon_Morphine,@function
Weapon_Morphine:
	stwu 1,-64(1)
	mflr 0
	stmw 24,32(1)
	stw 0,68(1)
	mr 10,3
	lis 8,fire_frames.86@ha
	lwz 9,84(10)
	li 24,1
	lis 29,pause_frames.85@ha
	lis 28,Weapon_Morphine_Use@ha
	la 25,fire_frames.86@l(8)
	lwz 11,4392(9)
	la 29,pause_frames.85@l(29)
	la 28,Weapon_Morphine_Use@l(28)
	li 27,55
	li 26,66
	srawi 9,11,31
	xor 0,9,11
	li 4,3
	subf 0,0,9
	li 5,10
	srawi 0,0,31
	li 6,45
	andi. 0,0,53
	li 7,45
	ori 0,0,4
	li 9,49
	stw 0,fire_frames.86@l(8)
	lwz 11,84(10)
	li 8,45
	li 10,52
	stw 24,4528(11)
	stw 27,8(1)
	stw 26,12(1)
	stw 29,16(1)
	stw 25,20(1)
	stw 28,24(1)
	bl Weapon_Generic
	lwz 0,68(1)
	mtlr 0
	lmw 24,32(1)
	la 1,64(1)
	blr
.Lfe30:
	.size	 Weapon_Morphine,.Lfe30-Weapon_Morphine
	.align 2
	.globl Weapon_Bandage
	.type	 Weapon_Bandage,@function
Weapon_Bandage:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lis 9,pause_frames.93@ha
	lis 10,Weapon_Bandage_Use@ha
	la 9,pause_frames.93@l(9)
	la 10,Weapon_Bandage_Use@l(10)
	lis 11,fire_frames.94@ha
	li 0,0
	stw 9,16(1)
	la 11,fire_frames.94@l(11)
	stw 10,24(1)
	li 4,3
	stw 11,20(1)
	li 5,8
	li 6,48
	stw 0,12(1)
	li 7,52
	li 8,48
	stw 0,8(1)
	li 9,48
	li 10,0
	bl Weapon_Generic
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe31:
	.size	 Weapon_Bandage,.Lfe31-Weapon_Bandage
	.align 2
	.globl Weapon_Flamethrower
	.type	 Weapon_Flamethrower,@function
Weapon_Flamethrower:
	stwu 1,-64(1)
	mflr 0
	stmw 26,40(1)
	stw 0,68(1)
	mr 10,3
	li 29,0
	lwz 9,84(10)
	lis 28,pause_frames.101@ha
	lis 27,fire_frames.102@ha
	lis 26,weapon_flame_fire@ha
	la 28,pause_frames.101@l(28)
	stw 29,4392(9)
	la 27,fire_frames.102@l(27)
	la 26,weapon_flame_fire@l(26)
	lwz 9,84(10)
	li 4,3
	li 5,5
	li 6,28
	addi 0,9,4504
	li 7,37
	stw 0,4496(9)
	li 8,37
	lwz 11,84(10)
	li 9,46
	li 10,0
	stw 29,4528(11)
	stw 29,12(1)
	stw 28,16(1)
	stw 27,20(1)
	stw 26,24(1)
	stw 29,8(1)
	bl Weapon_Generic
	lwz 0,68(1)
	mtlr 0
	lmw 26,40(1)
	la 1,64(1)
	blr
.Lfe32:
	.size	 Weapon_Flamethrower,.Lfe32-Weapon_Flamethrower
	.align 2
	.globl nevergethere
	.type	 nevergethere,@function
nevergethere:
	blr
.Lfe33:
	.size	 nevergethere,.Lfe33-nevergethere
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
