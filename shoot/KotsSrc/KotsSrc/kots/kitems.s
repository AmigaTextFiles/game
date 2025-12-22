	.file	"kitems.cpp"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"KOTS Pack"
	.align 3
.LC1:
	.long 0x40368000
	.long 0x0
	.align 2
.LC2:
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSPlayerDie__FP5CUser
	.type	 KOTSPlayerDie__FP5CUser,@function
KOTSPlayerDie__FP5CUser:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	mr 30,3
	lwz 31,4(30)
	cmpwi 0,31,0
	bc 12,2,.L4
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L4
	lwz 11,84(31)
	lis 9,.LC1@ha
	mr 4,3
	lfd 31,.LC1@l(9)
	mr 3,31
	li 27,0
	lfs 0,3764(11)
	fadd 0,0,31
	frsp 0,0
	stfs 0,3764(11)
	bl Drop_Item
	lwz 11,84(31)
	lis 9,kotsdrop_make_touchable__FP7edict_s@ha
	mr 28,3
	la 9,kotsdrop_make_touchable__FP7edict_s@l(9)
	li 3,793
	lfs 0,3764(11)
	fsub 0,0,31
	frsp 0,0
	stfs 0,3764(11)
	stw 9,436(28)
	stw 27,256(28)
	bl __builtin_new
	mr 29,3
	lis 3,theApp+528@ha
	mr 4,29
	la 3,theApp+528@l(3)
	bl Add__10CNPtrArrayPv
	mr 3,30
	li 4,1
	stw 29,972(28)
	bl Uninit__5CUserb
	mr 3,29
	mr 4,30
	li 5,793
	crxor 6,6,6
	bl memcpy
	lis 9,.LC2@ha
	lis 11,kots_lives@ha
	stw 27,4(29)
	la 9,.LC2@l(9)
	lfs 13,0(9)
	lwz 9,kots_lives@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L7
	lwz 0,928(31)
	cmpwi 0,0,0
	bc 12,1,.L7
	lwz 3,4(30)
	bl KOTSLeave
	b .L4
.L7:
	lwz 0,900(31)
	cmpwi 0,0,11
	bc 4,1,.L4
	li 0,0
	lis 3,theApp@ha
	stw 0,900(31)
	la 3,theApp@l(3)
	bl GetDataDir__8CKotsApp
	mr 4,3
	mr 3,30
	bl GameSave__5CUserPCc
.L4:
	lwz 0,52(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 KOTSPlayerDie__FP5CUser,.Lfe1-KOTSPlayerDie__FP5CUser
	.section	".rodata"
	.align 2
.LC3:
	.string	"Bullets"
	.align 2
.LC4:
	.string	"Shells"
	.align 2
.LC5:
	.string	"Cells"
	.align 2
.LC6:
	.string	"Grenades"
	.align 2
.LC7:
	.string	"Rockets"
	.align 2
.LC8:
	.string	"Slugs"
	.align 2
.LC9:
	.string	"Blaster"
	.align 2
.LC10:
	.string	"Shotgun"
	.align 2
.LC11:
	.string	"Super Shotgun"
	.align 2
.LC12:
	.string	"Machinegun"
	.align 2
.LC13:
	.string	"Chaingun"
	.align 2
.LC14:
	.string	"Grenade Launcher"
	.align 2
.LC15:
	.string	"Rocket Launcher"
	.align 2
.LC16:
	.string	"HyperBlaster"
	.align 2
.LC17:
	.string	"Railgun"
	.align 2
.LC18:
	.string	"BFG10K"
	.section	".text"
	.align 2
	.globl KOTSPickup_KOTSPack
	.type	 KOTSPickup_KOTSPack,@function
KOTSPickup_KOTSPack:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lwz 28,972(3)
	mr 29,4
	mr 3,29
	bl KOTSGetUser__FP7edict_s
	subfic 0,3,0
	adde 3,0,3
	subfic 8,28,0
	adde 0,8,28
	or. 9,0,3
	bc 4,2,.L105
	li 31,0
	lis 30,theApp+528@ha
	b .L17
.L19:
	addi 31,31,1
.L17:
	lis 3,theApp+528@ha
	la 3,theApp+528@l(3)
	bl GetSize__C10CNPtrArray
	cmpw 0,31,3
	bc 4,0,.L18
	la 3,theApp+528@l(30)
	mr 4,31
	bl __vc__10CNPtrArrayi
	lwz 0,0(3)
	cmpw 0,28,0
	bc 4,2,.L19
	la 3,theApp+528@l(30)
	mr 4,31
	li 5,1
	bl RemoveAt__10CNPtrArrayii
.L18:
	lwz 9,84(29)
	lis 3,.LC3@ha
	la 3,.LC3@l(3)
	lwz 31,108(28)
	lwz 30,1764(9)
	bl FindItem
	mr. 3,3
	bc 12,2,.L26
	lis 9,itemlist@ha
	srawi 10,30,31
	srawi 0,31,31
	la 9,itemlist@l(9)
	subf 10,30,10
	subf 0,31,0
	lis 11,0x286b
	subf 9,9,3
	srwi 10,10,31
	srwi 0,0,31
	ori 11,11,51739
	and. 8,10,0
	mullw 9,9,11
	srawi 3,9,2
	bc 12,2,.L24
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L24:
	lwz 9,84(29)
	slwi 3,3,2
	addi 9,9,740
	lwzx 0,9,3
	cmpw 0,0,30
	bc 4,1,.L26
	stwx 30,9,3
.L26:
	lwz 9,84(29)
	lis 3,.LC4@ha
	la 3,.LC4@l(3)
	lwz 31,112(28)
	lwz 30,1768(9)
	bl FindItem
	mr. 3,3
	bc 12,2,.L31
	lis 9,itemlist@ha
	srawi 10,30,31
	srawi 0,31,31
	la 9,itemlist@l(9)
	subf 10,30,10
	subf 0,31,0
	lis 11,0x286b
	subf 9,9,3
	srwi 10,10,31
	srwi 0,0,31
	ori 11,11,51739
	and. 8,10,0
	mullw 9,9,11
	srawi 3,9,2
	bc 12,2,.L29
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L29:
	lwz 9,84(29)
	slwi 3,3,2
	addi 9,9,740
	lwzx 0,9,3
	cmpw 0,0,30
	bc 4,1,.L31
	stwx 30,9,3
.L31:
	lwz 9,84(29)
	lis 3,.LC5@ha
	la 3,.LC5@l(3)
	lwz 31,116(28)
	lwz 30,1780(9)
	bl FindItem
	mr. 3,3
	bc 12,2,.L36
	lis 9,itemlist@ha
	srawi 10,30,31
	srawi 0,31,31
	la 9,itemlist@l(9)
	subf 10,30,10
	subf 0,31,0
	lis 11,0x286b
	subf 9,9,3
	srwi 10,10,31
	srwi 0,0,31
	ori 11,11,51739
	and. 8,10,0
	mullw 9,9,11
	srawi 3,9,2
	bc 12,2,.L34
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L34:
	lwz 9,84(29)
	slwi 3,3,2
	addi 9,9,740
	lwzx 0,9,3
	cmpw 0,0,30
	bc 4,1,.L36
	stwx 30,9,3
.L36:
	lwz 9,84(29)
	lis 3,.LC6@ha
	la 3,.LC6@l(3)
	lwz 31,120(28)
	lwz 30,1776(9)
	bl FindItem
	mr. 3,3
	bc 12,2,.L41
	lis 9,itemlist@ha
	srawi 10,30,31
	srawi 0,31,31
	la 9,itemlist@l(9)
	subf 10,30,10
	subf 0,31,0
	lis 11,0x286b
	subf 9,9,3
	srwi 10,10,31
	srwi 0,0,31
	ori 11,11,51739
	and. 8,10,0
	mullw 9,9,11
	srawi 3,9,2
	bc 12,2,.L39
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L39:
	lwz 9,84(29)
	slwi 3,3,2
	addi 9,9,740
	lwzx 0,9,3
	cmpw 0,0,30
	bc 4,1,.L41
	stwx 30,9,3
.L41:
	lwz 9,84(29)
	lis 3,.LC7@ha
	la 3,.LC7@l(3)
	lwz 31,124(28)
	lwz 30,1772(9)
	bl FindItem
	mr. 3,3
	bc 12,2,.L46
	lis 9,itemlist@ha
	srawi 10,30,31
	srawi 0,31,31
	la 9,itemlist@l(9)
	subf 10,30,10
	subf 0,31,0
	lis 11,0x286b
	subf 9,9,3
	srwi 10,10,31
	srwi 0,0,31
	ori 11,11,51739
	and. 8,10,0
	mullw 9,9,11
	srawi 3,9,2
	bc 12,2,.L44
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L44:
	lwz 9,84(29)
	slwi 3,3,2
	addi 9,9,740
	lwzx 0,9,3
	cmpw 0,0,30
	bc 4,1,.L46
	stwx 30,9,3
.L46:
	lwz 9,84(29)
	lis 3,.LC8@ha
	la 3,.LC8@l(3)
	lwz 31,128(28)
	lwz 30,1784(9)
	bl FindItem
	mr. 3,3
	bc 12,2,.L51
	lis 9,itemlist@ha
	srawi 10,30,31
	srawi 0,31,31
	la 9,itemlist@l(9)
	subf 10,30,10
	subf 0,31,0
	lis 11,0x286b
	subf 9,9,3
	srwi 10,10,31
	srwi 0,0,31
	ori 11,11,51739
	and. 8,10,0
	mullw 9,9,11
	srawi 3,9,2
	bc 12,2,.L49
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L49:
	lwz 9,84(29)
	slwi 3,3,2
	addi 9,9,740
	lwzx 0,9,3
	cmpw 0,0,30
	bc 4,1,.L51
	stwx 30,9,3
.L51:
	lis 3,.LC9@ha
	lwz 31,38(28)
	la 3,.LC9@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L56
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	cmpwi 0,31,0
	mullw 9,9,0
	srawi 3,9,2
	bc 4,1,.L54
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L54:
	lwz 9,84(29)
	slwi 3,3,2
	addi 9,9,740
	lwzx 0,9,3
	cmpwi 0,0,1
	bc 4,1,.L56
	li 0,1
	stwx 0,9,3
.L56:
	lis 3,.LC10@ha
	lwz 31,42(28)
	la 3,.LC10@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L61
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	cmpwi 0,31,0
	mullw 9,9,0
	srawi 3,9,2
	bc 4,1,.L59
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L59:
	lwz 9,84(29)
	slwi 3,3,2
	addi 9,9,740
	lwzx 0,9,3
	cmpwi 0,0,1
	bc 4,1,.L61
	li 0,1
	stwx 0,9,3
.L61:
	lis 3,.LC11@ha
	lwz 31,46(28)
	la 3,.LC11@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L66
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	cmpwi 0,31,0
	mullw 9,9,0
	srawi 3,9,2
	bc 4,1,.L64
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L64:
	lwz 9,84(29)
	slwi 3,3,2
	addi 9,9,740
	lwzx 0,9,3
	cmpwi 0,0,1
	bc 4,1,.L66
	li 0,1
	stwx 0,9,3
.L66:
	lis 3,.LC12@ha
	lwz 31,50(28)
	la 3,.LC12@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L71
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	cmpwi 0,31,0
	mullw 9,9,0
	srawi 3,9,2
	bc 4,1,.L69
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L69:
	lwz 9,84(29)
	slwi 3,3,2
	addi 9,9,740
	lwzx 0,9,3
	cmpwi 0,0,1
	bc 4,1,.L71
	li 0,1
	stwx 0,9,3
.L71:
	lis 3,.LC13@ha
	lwz 31,54(28)
	la 3,.LC13@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L76
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	cmpwi 0,31,0
	mullw 9,9,0
	srawi 3,9,2
	bc 4,1,.L74
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L74:
	lwz 9,84(29)
	slwi 3,3,2
	addi 9,9,740
	lwzx 0,9,3
	cmpwi 0,0,1
	bc 4,1,.L76
	li 0,1
	stwx 0,9,3
.L76:
	lis 3,.LC14@ha
	lwz 31,58(28)
	la 3,.LC14@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L81
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	cmpwi 0,31,0
	mullw 9,9,0
	srawi 3,9,2
	bc 4,1,.L79
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L79:
	lwz 9,84(29)
	slwi 3,3,2
	addi 9,9,740
	lwzx 0,9,3
	cmpwi 0,0,1
	bc 4,1,.L81
	li 0,1
	stwx 0,9,3
.L81:
	lis 3,.LC15@ha
	lwz 31,62(28)
	la 3,.LC15@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L86
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	cmpwi 0,31,0
	mullw 9,9,0
	srawi 3,9,2
	bc 4,1,.L84
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L84:
	lwz 9,84(29)
	slwi 3,3,2
	addi 9,9,740
	lwzx 0,9,3
	cmpwi 0,0,1
	bc 4,1,.L86
	li 0,1
	stwx 0,9,3
.L86:
	lis 3,.LC16@ha
	lwz 31,66(28)
	la 3,.LC16@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L91
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	cmpwi 0,31,0
	mullw 9,9,0
	srawi 3,9,2
	bc 4,1,.L89
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L89:
	lwz 9,84(29)
	slwi 3,3,2
	addi 9,9,740
	lwzx 0,9,3
	cmpwi 0,0,1
	bc 4,1,.L91
	li 0,1
	stwx 0,9,3
.L91:
	lis 3,.LC17@ha
	lwz 31,70(28)
	la 3,.LC17@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L96
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	cmpwi 0,31,0
	mullw 9,9,0
	srawi 3,9,2
	bc 4,1,.L94
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L94:
	lwz 9,84(29)
	slwi 3,3,2
	addi 9,9,740
	lwzx 0,9,3
	cmpwi 0,0,1
	bc 4,1,.L96
	li 0,1
	stwx 0,9,3
.L96:
	lis 3,.LC18@ha
	lwz 31,74(28)
	la 3,.LC18@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L101
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	cmpwi 0,31,0
	mullw 9,9,0
	srawi 3,9,2
	bc 4,1,.L99
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L99:
	lwz 9,84(29)
	slwi 11,3,2
	addi 3,9,740
	lwzx 0,3,11
	cmpwi 0,0,1
	bc 4,1,.L101
	li 0,1
	stwx 0,3,11
.L101:
	mr 3,28
	bl __builtin_delete
.L105:
	li 3,1
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 KOTSPickup_KOTSPack,.Lfe2-KOTSPickup_KOTSPack
	.section	".rodata"
	.align 2
.LC19:
	.string	"tball"
	.align 2
.LC20:
	.string	"Power Cube"
	.align 2
.LC21:
	.string	"Body Armor"
	.align 2
.LC22:
	.long 0x0
	.align 2
.LC23:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl KOTSPickup_Armor
	.type	 KOTSPickup_Armor,@function
KOTSPickup_Armor:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 30,4
	mr 27,3
	mr 3,30
	bl KOTSGetUser__FP7edict_s
	mr. 29,3
	bc 12,2,.L124
	lwz 9,648(27)
	mr 3,30
	lwz 26,64(9)
	bl ArmorIndex
	mr 28,3
	lis 3,.LC21@ha
	la 3,.LC21@l(3)
	bl FindItem
	lwz 10,648(27)
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 11,68(10)
	subf 3,9,3
	mullw 3,3,0
	cmpwi 0,11,4
	srawi 31,3,2
	bc 4,2,.L112
	mr 3,30
	bl KOTSModKarma
	cmpwi 0,28,0
	slwi 3,3,1
	bc 4,2,.L113
	lwz 9,84(30)
	slwi 0,31,2
	addi 9,9,740
	stwx 3,9,0
	b .L114
.L113:
	lwz 9,84(30)
	slwi 11,31,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,3
	stwx 0,9,11
.L114:
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L116
	lis 11,itemlist@ha
	lis 0,0x286b
	lwz 10,84(30)
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 11,11,3
	addi 10,10,740
	mullw 11,11,0
	rlwinm 11,11,0,0,29
	lwzx 9,10,11
	addi 9,9,5
	stwx 9,10,11
	b .L116
.L112:
	cmpwi 0,28,0
	bc 4,2,.L117
	lwz 9,84(30)
	slwi 11,31,2
	lwz 0,0(26)
	addi 9,9,740
	stwx 0,9,11
	b .L116
.L117:
	lwz 9,84(30)
	slwi 28,31,2
	mr 3,29
	addi 9,9,740
	lwzx 31,9,28
	bl GetMaxArmor__5CUser
	cmpw 0,31,3
	bc 12,0,.L119
.L124:
	li 3,0
	b .L123
.L119:
	lwz 0,0(26)
	mr 3,29
	add 31,31,0
	bl GetMaxArmor__5CUser
	cmpw 0,31,3
	bc 4,1,.L120
	mr 3,29
	bl GetMaxArmor__5CUser
	mr 31,3
.L120:
	lwz 9,84(30)
	addi 9,9,740
	stwx 31,9,28
.L116:
	lwz 0,284(27)
	andis. 9,0,1
	bc 4,2,.L121
	lis 9,.LC22@ha
	lis 11,deathmatch@ha
	la 9,.LC22@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L121
	lis 9,.LC23@ha
	mr 3,27
	la 9,.LC23@l(9)
	lfs 1,0(9)
	bl SetRespawn
.L121:
	li 3,1
.L123:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 KOTSPickup_Armor,.Lfe3-KOTSPickup_Armor
	.section	".rodata"
	.align 2
.LC24:
	.long 0x41700000
	.section	".text"
	.align 2
	.type	 kotsdrop_make_touchable__FP7edict_s,@function
kotsdrop_make_touchable__FP7edict_s:
	lis 9,Touch_Item@ha
	lis 11,level+4@ha
	la 9,Touch_Item@l(9)
	stw 9,444(3)
	lis 9,.LC24@ha
	lfs 0,level+4@l(11)
	la 9,.LC24@l(9)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,436(3)
	stfs 0,428(3)
	blr
.Lfe4:
	.size	 kotsdrop_make_touchable__FP7edict_s,.Lfe4-kotsdrop_make_touchable__FP7edict_s
	.align 2
	.globl KOTS_SetItem__FPcP7edict_sii
	.type	 KOTS_SetItem__FPcP7edict_sii,@function
KOTS_SetItem__FPcP7edict_sii:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,4
	mr 31,5
	mr 30,6
	bl FindItem
	mr. 3,3
	bc 12,2,.L11
	lis 9,itemlist@ha
	srawi 10,30,31
	srawi 0,31,31
	la 9,itemlist@l(9)
	subf 10,30,10
	subf 0,31,0
	lis 11,0x286b
	subf 9,9,3
	srwi 10,10,31
	srwi 0,0,31
	ori 11,11,51739
	and. 8,10,0
	mullw 9,9,11
	srawi 3,9,2
	bc 12,2,.L12
	lwz 9,84(29)
	slwi 11,3,2
	addi 9,9,740
	lwzx 0,9,11
	add 0,0,31
	stwx 0,9,11
.L12:
	lwz 9,84(29)
	slwi 3,3,2
	addi 9,9,740
	lwzx 0,9,3
	cmpw 0,0,30
	bc 4,1,.L13
	stwx 30,9,3
.L13:
	lwz 9,84(29)
	addi 9,9,740
	lwzx 3,9,3
	b .L131
.L11:
	li 3,0
.L131:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 KOTS_SetItem__FPcP7edict_sii,.Lfe5-KOTS_SetItem__FPcP7edict_sii
	.align 2
	.globl KOTSPickup_Pack
	.type	 KOTSPickup_Pack,@function
KOTSPickup_Pack:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L107
	lis 11,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 11,11,3
	addi 10,10,740
	mullw 11,11,0
	rlwinm 11,11,0,0,29
	lwzx 9,10,11
	addi 9,9,4
	stwx 9,10,11
.L107:
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L109
	lis 11,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 11,11,3
	addi 10,10,740
	mullw 11,11,0
	rlwinm 11,11,0,0,29
	lwzx 9,10,11
	addi 9,9,20
	stwx 9,10,11
.L109:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 KOTSPickup_Pack,.Lfe6-KOTSPickup_Pack
	.section	".rodata"
	.align 2
.LC25:
	.long 0x43340000
	.section	".text"
	.align 2
	.globl KOTSPickup_PowerArmor
	.type	 KOTSPickup_PowerArmor,@function
KOTSPickup_PowerArmor:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,4
	mr 29,3
	mr 3,31
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L126
	bl GetMaxArmor__5CUser
	mr 30,3
	lis 3,.LC21@ha
	la 3,.LC21@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L126
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	addi 4,11,740
	mullw 9,9,0
	rlwinm 3,9,0,0,29
	lwzx 0,4,3
	cmpw 0,0,30
	bc 4,0,.L126
	stwx 30,4,3
	lwz 0,284(29)
	andis. 9,0,1
	bc 4,2,.L129
	lis 9,.LC25@ha
	mr 3,29
	la 9,.LC25@l(9)
	lfs 1,0(9)
	bl SetRespawn
.L129:
	li 3,1
	b .L132
.L126:
	li 3,0
.L132:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 KOTSPickup_PowerArmor,.Lfe7-KOTSPickup_PowerArmor
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
