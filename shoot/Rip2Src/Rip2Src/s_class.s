	.file	"s_class.c"
gcc2_compiled.:
	.globl cla_names
	.section	".data"
	.align 2
	.type	 cla_names,@object
	.size	 cla_names,44
cla_names:
	.long 0
	.long .LC0
	.long .LC1
	.long .LC2
	.long .LC3
	.long .LC4
	.long .LC5
	.long .LC6
	.long .LC7
	.long .LC8
	.long 0
	.section	".rodata"
	.align 2
.LC8:
	.string	"ghost"
	.align 2
.LC7:
	.string	"trooper"
	.align 2
.LC6:
	.string	"flamer"
	.align 2
.LC5:
	.string	"scientist"
	.align 2
.LC4:
	.string	"miner"
	.align 2
.LC3:
	.string	"infantry"
	.align 2
.LC2:
	.string	"thief"
	.align 2
.LC1:
	.string	"necromancer"
	.align 2
.LC0:
	.string	"warrior"
	.align 2
.LC9:
	.string	"menu_speed\n"
	.align 2
.LC10:
	.string	"Select your equipment"
	.align 2
.LC11:
	.string	"Necromancer"
	.align 2
.LC12:
	.string	"Thief"
	.align 2
.LC13:
	.string	"Infantry"
	.align 2
.LC14:
	.string	"Miner"
	.align 2
.LC15:
	.string	"Scientist"
	.align 2
.LC16:
	.string	"Flamer"
	.align 2
.LC17:
	.string	"Trooper"
	.align 2
.LC18:
	.string	"Warrior"
	.align 2
.LC19:
	.string	"menu_armor\n"
	.align 2
.LC20:
	.string	"Select your speed"
	.align 2
.LC21:
	.string	"25  * x"
	.align 2
.LC22:
	.string	"50  * x"
	.align 2
.LC23:
	.string	"100 * x"
	.align 2
.LC24:
	.string	"150 * x"
	.align 2
.LC25:
	.string	"200 * x"
	.align 2
.LC26:
	.string	"Body Armor"
	.align 2
.LC27:
	.string	"menu_done\n"
	.align 2
.LC28:
	.string	"Jacket Armor"
	.align 2
.LC29:
	.string	"Combat Armor"
	.align 2
.LC30:
	.string	"Select your armor"
	.align 2
.LC31:
	.string	"Body Armor  "
	.align 2
.LC32:
	.string	"Done"
	.align 2
.LC33:
	.string	"%s %i\n"
	.align 2
.LC34:
	.string	"custom"
	.align 2
.LC35:
	.string	"WARRIOR\n\nWeapons:\nRocket Launcher, Machinegun.\nGrenades: Rail.\n\nArmor: Body, %i.\nSpeed: %i.\n"
	.align 2
.LC36:
	.string	"NECROMANCER\n\nWeapon:\nHyperblaster.\nGrenades: Leapfrog.\n\nArmor: Combat, %i.\nSpeed: %i.\n"
	.align 2
.LC37:
	.string	"THIEF\n\nWeapons:\nShotgun, Super Shotgun.\nGrenades: Bounce.\n\n\nArmor: Combat, %i.\nSpeed: %i.\n"
	.align 2
.LC38:
	.string	"INFANTRY\n\nWeapons:\nMachinegun, Chaingun.\nGrenades: Smoke.\n\nArmor: Jacket, %i.\nSpeed: %i.\n"
	.align 2
.LC39:
	.string	"MINER\n\nWeapons:\nPipe Launcher, Grenade Launcher.\nGrenades: Cluster.\n\nArmor: Jacket, %i.\nSpeed: %i.\n"
	.align 2
.LC40:
	.string	"SCIENTIST\n\nWeapon:\nShotgun, Plasma Rifle.\nGrenades: Concussion.\n\nArmor: Combat, %i.\nSpeed: %i.\n"
	.align 2
.LC41:
	.string	"FLAMER\n\nWeapons:\nFlame Launcher, Flamethrower.\nGrenades: Flame.\n\nArmor: Body, %i.\nSpeed: %i.\n"
	.align 2
.LC42:
	.string	"TROOPER\n\nWeapons:\nSuper Shotgun, BFG10k.\nGrenades: Plasma.\n\nArmor: Jacket, %i.\nSpeed: %i.\n"
	.align 2
.LC43:
	.string	"GHOST\n\nWeapons:\nHyperblaster (with more powerful cells).\nGrenades: Tag.\n\nArmor: None.\nSpeed: %i\n"
	.align 2
.LC44:
	.string	"CUSTOM\n\nArmor: %s, %i.\nSpeed: %i.\n"
	.section	".text"
	.align 2
	.globl Print_ClassProperties
	.type	 Print_ClassProperties,@function
Print_ClassProperties:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,892(31)
	addi 9,9,-1
	cmplwi 0,9,9
	bc 12,1,.L94
	lis 11,.L105@ha
	slwi 10,9,2
	la 11,.L105@l(11)
	lis 9,.L105@ha
	lwzx 0,10,11
	la 9,.L105@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L105:
	.long .L95-.L105
	.long .L96-.L105
	.long .L97-.L105
	.long .L98-.L105
	.long .L99-.L105
	.long .L100-.L105
	.long .L101-.L105
	.long .L102-.L105
	.long .L103-.L105
	.long .L104-.L105
.L95:
	lis 11,gi+12@ha
	lwz 9,84(31)
	mr 3,31
	lwz 0,gi+12@l(11)
	lis 4,.LC35@ha
	la 4,.LC35@l(4)
	b .L107
.L96:
	lis 11,gi+12@ha
	lwz 9,84(31)
	mr 3,31
	lwz 0,gi+12@l(11)
	lis 4,.LC36@ha
	la 4,.LC36@l(4)
	b .L107
.L97:
	lis 11,gi+12@ha
	lwz 9,84(31)
	mr 3,31
	lwz 0,gi+12@l(11)
	lis 4,.LC37@ha
	la 4,.LC37@l(4)
	b .L107
.L98:
	lis 11,gi+12@ha
	lwz 9,84(31)
	mr 3,31
	lwz 0,gi+12@l(11)
	lis 4,.LC38@ha
	la 4,.LC38@l(4)
	b .L107
.L99:
	lis 11,gi+12@ha
	lwz 9,84(31)
	mr 3,31
	lwz 0,gi+12@l(11)
	lis 4,.LC39@ha
	la 4,.LC39@l(4)
	b .L107
.L100:
	lis 11,gi+12@ha
	lwz 9,84(31)
	mr 3,31
	lwz 0,gi+12@l(11)
	lis 4,.LC40@ha
	la 4,.LC40@l(4)
	b .L107
.L101:
	lis 11,gi+12@ha
	lwz 9,84(31)
	mr 3,31
	lwz 0,gi+12@l(11)
	lis 4,.LC41@ha
	la 4,.LC41@l(4)
	b .L107
.L102:
	lis 11,gi+12@ha
	lwz 9,84(31)
	mr 3,31
	lwz 0,gi+12@l(11)
	lis 4,.LC42@ha
	la 4,.LC42@l(4)
.L107:
	lwz 5,1864(9)
	lwz 6,944(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L94
.L103:
	lis 9,gi+12@ha
	mr 3,31
	lwz 0,gi+12@l(9)
	lis 4,.LC43@ha
	la 4,.LC43@l(4)
	lwz 5,944(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L94
.L104:
	lwz 29,84(31)
	lis 28,gi@ha
	mr 3,31
	la 28,gi@l(28)
	lwz 27,1864(29)
	bl ArmorIndex
	lwz 9,84(31)
	slwi 3,3,2
	addi 29,29,740
	lwz 0,12(28)
	lis 4,.LC44@ha
	mr 5,27
	lwz 7,1876(9)
	la 4,.LC44@l(4)
	lwzx 6,29,3
	mtlr 0
	mr 3,31
	mulli 7,7,50
	crxor 6,6,6
	blrl
.L94:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Print_ClassProperties,.Lfe1-Print_ClassProperties
	.section	".rodata"
	.align 2
.LC45:
	.string	"Blaster"
	.align 2
.LC46:
	.string	"Grenades"
	.align 2
.LC47:
	.string	"Machinegun"
	.align 2
.LC48:
	.string	"Rocket Launcher"
	.align 2
.LC49:
	.string	"rockets"
	.align 2
.LC50:
	.string	"bullets"
	.align 2
.LC51:
	.string	"Magic"
	.align 2
.LC52:
	.string	"Hyperblaster"
	.align 2
.LC53:
	.string	"cells"
	.align 2
.LC54:
	.string	"Shotgun"
	.align 2
.LC55:
	.string	"Super Shotgun"
	.align 2
.LC56:
	.string	"shells"
	.align 2
.LC57:
	.string	"Chaingun"
	.align 2
.LC58:
	.string	"Railgun"
	.align 2
.LC59:
	.string	"slugs"
	.align 2
.LC60:
	.string	"Pipebomb Launcher"
	.align 2
.LC61:
	.string	"Grenade Launcher"
	.align 2
.LC62:
	.string	"pipebombs"
	.align 2
.LC63:
	.string	"Plasma Rifle"
	.align 2
.LC64:
	.string	"Flame Launcher"
	.align 2
.LC65:
	.string	"Flamethrower"
	.align 2
.LC66:
	.string	"BFG10k"
	.section	".text"
	.align 2
	.globl Set_ClassEquipment
	.type	 Set_ClassEquipment,@function
Set_ClassEquipment:
	stwu 1,-48(1)
	mflr 0
	stmw 22,8(1)
	stw 0,52(1)
	mr 31,3
	mr 30,4
	addi 3,31,188
	li 4,0
	li 5,1624
	crxor 6,6,6
	bl memset
	addi 10,30,-1
	li 9,0
	cmplwi 0,10,8
	li 0,0
	stw 9,2248(31)
	stw 0,2252(31)
	stw 9,2256(31)
	bc 12,1,.L122
	lis 11,.L133@ha
	slwi 10,10,2
	la 11,.L133@l(11)
	lis 9,.L133@ha
	lwzx 0,10,11
	la 9,.L133@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L133:
	.long .L123-.L133
	.long .L124-.L133
	.long .L125-.L133
	.long .L126-.L133
	.long .L127-.L133
	.long .L128-.L133
	.long .L129-.L133
	.long .L130-.L133
	.long .L131-.L133
.L123:
	li 10,90
	li 11,0
	li 9,100
	li 0,50
	stw 10,724(31)
	li 25,5
	lis 3,.LC45@ha
	stw 10,728(31)
	stw 11,1784(31)
	la 3,.LC45@l(3)
	lis 28,0x286b
	stw 11,1768(31)
	ori 28,28,51739
	addi 27,31,740
	stw 11,1780(31)
	li 26,1
	stw 9,1764(31)
	stw 0,1772(31)
	stw 25,1776(31)
	bl FindItem
	lis 29,itemlist@ha
	lis 9,.LC46@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC46@l(9)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC47@ha
	la 3,.LC47@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 25,27,9
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC48@ha
	mullw 0,0,28
	la 3,.LC48@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	stw 11,1792(31)
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC49@ha
	mullw 0,0,28
	la 3,.LC49@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	stw 11,1788(31)
	bl FindItem
	subf 9,29,3
	lwz 10,1772(31)
	mullw 9,9,28
	lis 3,.LC50@ha
	la 3,.LC50@l(3)
	srawi 9,9,2
	slwi 11,9,2
	stw 9,736(31)
	lwzx 0,27,11
	add 0,0,10
	stwx 0,27,11
	bl FindItem
	subf 3,29,3
	lwz 8,1764(31)
	lis 11,.LC26@ha
	mullw 3,3,28
	la 11,.LC26@l(11)
	li 10,200
	b .L135
.L124:
	li 9,0
	li 11,90
	li 0,100
	li 25,10
	stw 11,724(31)
	lis 3,.LC45@ha
	stw 11,728(31)
	lis 28,0x286b
	stw 0,1780(31)
	la 3,.LC45@l(3)
	ori 28,28,51739
	stw 9,1784(31)
	addi 27,31,740
	li 26,1
	stw 9,1764(31)
	stw 9,1768(31)
	stw 9,1772(31)
	stw 25,1776(31)
	bl FindItem
	lis 29,itemlist@ha
	lis 9,.LC46@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC46@l(9)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC51@ha
	la 3,.LC51@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 25,27,9
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC52@ha
	mullw 0,0,28
	la 3,.LC52@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	stw 11,1792(31)
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC53@ha
	mullw 0,0,28
	la 3,.LC53@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	stw 11,1788(31)
	bl FindItem
	subf 3,29,3
	lwz 8,1780(31)
	lis 11,.LC29@ha
	mullw 3,3,28
	la 11,.LC29@l(11)
	li 10,50
	b .L135
.L125:
	li 10,110
	li 0,0
	li 11,5
	li 9,100
	stw 10,724(31)
	lis 3,.LC45@ha
	stw 10,728(31)
	lis 28,0x286b
	stw 11,1776(31)
	la 3,.LC45@l(3)
	ori 28,28,51739
	stw 9,1768(31)
	addi 27,31,740
	li 26,1
	stw 0,1784(31)
	stw 0,1764(31)
	stw 0,1772(31)
	stw 0,1780(31)
	bl FindItem
	lis 29,itemlist@ha
	lis 9,.LC46@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC46@l(9)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	bl FindItem
	subf 0,29,3
	li 11,10
	mullw 0,0,28
	lis 3,.LC54@ha
	la 3,.LC54@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 11,27,9
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC55@ha
	mullw 0,0,28
	la 3,.LC55@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	stw 11,1792(31)
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC56@ha
	mullw 0,0,28
	la 3,.LC56@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	stw 11,1788(31)
	bl FindItem
	subf 3,29,3
	lwz 8,1768(31)
	lis 11,.LC29@ha
	mullw 3,3,28
	la 11,.LC29@l(11)
	b .L136
.L126:
	li 10,60
	li 9,0
	li 11,30
	li 0,200
	stw 10,724(31)
	li 25,5
	lis 3,.LC46@ha
	stw 10,728(31)
	stw 11,1784(31)
	la 3,.LC46@l(3)
	lis 28,0x286b
	stw 0,1764(31)
	ori 28,28,51739
	addi 27,31,740
	stw 9,1780(31)
	li 26,1
	stw 9,1768(31)
	stw 9,1772(31)
	stw 25,1776(31)
	bl FindItem
	lis 29,itemlist@ha
	lis 9,.LC45@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC45@l(9)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 25,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC57@ha
	la 3,.LC57@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC58@ha
	mullw 0,0,28
	la 3,.LC58@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	stw 11,1792(31)
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC50@ha
	mullw 0,0,28
	la 3,.LC50@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	stw 11,1788(31)
	bl FindItem
	subf 9,29,3
	lwz 10,1764(31)
	mullw 9,9,28
	lis 3,.LC59@ha
	la 3,.LC59@l(3)
	srawi 9,9,2
	slwi 11,9,2
	stw 9,736(31)
	lwzx 0,27,11
	add 0,0,10
	stwx 0,27,11
	bl FindItem
	subf 3,29,3
	lwz 8,1784(31)
	lis 11,.LC28@ha
	mullw 3,3,28
	la 11,.LC28@l(11)
.L136:
	li 10,40
.L135:
	srawi 3,3,2
	slwi 9,3,2
	stw 3,736(31)
	lwzx 0,27,9
	add 0,0,8
	stwx 0,27,9
	stw 10,1864(31)
	stw 11,1868(31)
	b .L122
.L127:
	li 0,0
	li 25,80
	li 9,70
	lis 3,.LC45@ha
	stw 0,1784(31)
	stw 9,1776(31)
	la 3,.LC45@l(3)
	lis 28,0x286b
	stw 0,1764(31)
	ori 28,28,51739
	addi 27,31,740
	stw 0,1768(31)
	li 26,1
	stw 0,1772(31)
	stw 0,1780(31)
	stw 25,728(31)
	stw 25,724(31)
	bl FindItem
	lis 29,itemlist@ha
	lis 9,.LC46@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC46@l(9)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	bl FindItem
	subf 9,29,3
	lwz 10,1776(31)
	mullw 9,9,28
	lis 3,.LC60@ha
	la 3,.LC60@l(3)
	srawi 9,9,2
	slwi 11,9,2
	stw 9,736(31)
	lwzx 0,27,11
	add 0,0,10
	stwx 0,27,11
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC61@ha
	mullw 0,0,28
	la 3,.LC61@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	stw 11,1792(31)
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC62@ha
	mullw 0,0,28
	la 3,.LC62@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	stw 11,1788(31)
	bl FindItem
	subf 3,29,3
	lis 11,.LC28@ha
	mullw 3,3,28
	la 11,.LC28@l(11)
	srawi 3,3,2
	slwi 0,3,2
	stw 3,736(31)
	lwzx 9,27,0
	addi 9,9,5
	stwx 9,27,0
	stw 25,1864(31)
	stw 11,1868(31)
	b .L122
.L128:
	li 9,150
	li 26,50
	li 25,10
	li 0,5
	stw 9,724(31)
	li 23,70
	li 22,30
	stw 0,1776(31)
	lis 3,.LC46@ha
	stw 9,728(31)
	lis 28,0x286b
	stw 26,1764(31)
	la 3,.LC46@l(3)
	ori 28,28,51739
	stw 26,1768(31)
	addi 27,31,740
	li 24,1
	stw 25,1772(31)
	stw 23,1780(31)
	stw 22,1784(31)
	bl FindItem
	lis 29,itemlist@ha
	lis 9,.LC45@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC45@l(9)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 25,27,9
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC63@ha
	mullw 0,0,28
	la 3,.LC63@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 24,27,9
	stw 11,1792(31)
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC56@ha
	mullw 0,0,28
	la 3,.LC56@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 24,27,9
	stw 11,1788(31)
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC53@ha
	la 3,.LC53@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC59@ha
	la 3,.LC59@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 23,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC49@ha
	la 3,.LC49@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 22,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC50@ha
	la 3,.LC50@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 25,27,9
	bl FindItem
	subf 3,29,3
	li 10,20
	mullw 3,3,28
	lis 9,.LC29@ha
	li 11,80
	la 9,.LC29@l(9)
	srawi 3,3,2
	slwi 0,3,2
	stw 3,736(31)
	stwx 10,27,0
	b .L137
.L129:
	li 0,0
	li 9,90
	li 25,50
	lis 3,.LC45@ha
	stw 9,724(31)
	stw 0,1784(31)
	la 3,.LC45@l(3)
	lis 28,0x286b
	stw 9,728(31)
	ori 28,28,51739
	addi 27,31,740
	stw 0,1764(31)
	li 26,1
	stw 0,1768(31)
	stw 0,1772(31)
	stw 0,1776(31)
	stw 25,1780(31)
	bl FindItem
	lis 29,itemlist@ha
	lis 9,.LC46@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC46@l(9)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	bl FindItem
	subf 0,29,3
	li 11,15
	mullw 0,0,28
	lis 3,.LC64@ha
	la 3,.LC64@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 11,27,9
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC65@ha
	mullw 0,0,28
	la 3,.LC65@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	stw 11,1792(31)
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC53@ha
	mullw 0,0,28
	la 3,.LC53@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	stw 11,1788(31)
	bl FindItem
	subf 3,29,3
	lis 9,.LC26@ha
	mullw 3,3,28
	la 9,.LC26@l(9)
	li 11,20
	b .L138
.L130:
	li 0,0
	li 25,50
	li 9,80
	li 24,10
	stw 0,1784(31)
	lis 3,.LC45@ha
	stw 9,724(31)
	lis 28,0x286b
	stw 9,728(31)
	la 3,.LC45@l(3)
	ori 28,28,51739
	stw 0,1764(31)
	addi 27,31,740
	li 26,1
	stw 0,1772(31)
	stw 25,1768(31)
	stw 24,1776(31)
	stw 25,1780(31)
	bl FindItem
	lis 29,itemlist@ha
	lis 9,.LC46@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC46@l(9)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC55@ha
	la 3,.LC55@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 24,27,9
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC66@ha
	mullw 0,0,28
	la 3,.LC66@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	stw 11,1792(31)
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC53@ha
	mullw 0,0,28
	la 3,.LC53@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	stw 11,1788(31)
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC56@ha
	la 3,.LC56@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 25,27,9
	bl FindItem
	subf 3,29,3
	lis 9,.LC28@ha
	mullw 3,3,28
	la 9,.LC28@l(9)
	li 11,60
.L138:
	srawi 3,3,2
	slwi 0,3,2
	stw 3,736(31)
	stwx 25,27,0
.L137:
	stw 11,1864(31)
	stw 9,1868(31)
	b .L122
.L131:
	li 9,0
	li 11,110
	li 0,100
	li 25,15
	stw 11,724(31)
	lis 3,.LC45@ha
	stw 0,1780(31)
	lis 28,0x286b
	stw 9,1784(31)
	la 3,.LC45@l(3)
	ori 28,28,51739
	stw 11,728(31)
	addi 27,31,740
	li 26,1
	stw 9,1764(31)
	stw 9,1768(31)
	stw 9,1772(31)
	stw 25,1776(31)
	bl FindItem
	lis 29,itemlist@ha
	mr 11,3
	la 29,itemlist@l(29)
	lis 3,.LC46@ha
	subf 0,29,11
	la 3,.LC46@l(3)
	mullw 0,0,28
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 26,27,9
	stw 11,1792(31)
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC52@ha
	la 3,.LC52@l(3)
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 25,27,9
	bl FindItem
	mr 11,3
	subf 29,29,11
	mullw 29,29,28
	srawi 29,29,2
	slwi 0,29,2
	stw 29,736(31)
	stwx 26,27,0
	stw 11,1788(31)
.L122:
	xori 9,30,9
	lwz 0,1872(31)
	addic 10,9,-1
	subfe 11,10,9
	subfic 9,0,0
	adde 0,9,0
	and. 10,0,11
	bc 12,2,.L134
	lwz 3,1868(31)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,1864(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,31,740
	mullw 3,3,0
	srawi 3,3,2
	slwi 0,3,2
	stw 3,736(31)
	stwx 10,11,0
.L134:
	li 0,1
	stw 0,720(31)
	lwz 0,52(1)
	mtlr 0
	lmw 22,8(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Set_ClassEquipment,.Lfe2-Set_ClassEquipment
	.section	".rodata"
	.align 2
.LC67:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC68:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC69:
	.string	"players/male/tris.md2"
	.align 2
.LC70:
	.string	"%s's class is %s\n"
	.align 2
.LC71:
	.string	"exec_class"
	.align 2
.LC72:
	.string	"exec cl_cfg/"
	.align 2
.LC73:
	.string	".cfg\n"
	.align 2
.LC74:
	.long 0x40e00000
	.align 2
.LC75:
	.long 0x47800000
	.align 2
.LC76:
	.long 0x43b40000
	.align 2
.LC77:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl ClassFunction
	.type	 ClassFunction,@function
ClassFunction:
	stwu 1,-2352(1)
	mflr 0
	mfcr 12
	stmw 24,2320(1)
	stw 0,2356(1)
	stw 12,2316(1)
	lis 9,.LC67@ha
	lis 11,.LC68@ha
	lwz 0,.LC67@l(9)
	la 27,.LC68@l(11)
	addi 10,1,2264
	la 9,.LC67@l(9)
	lwz 8,.LC68@l(11)
	addi 7,1,2280
	lwz 6,8(9)
	addi 5,1,24
	mr 31,3
	lwz 28,4(9)
	mr 30,4
	addi 29,1,1672
	stw 0,2264(1)
	addi 4,1,8
	stw 6,8(10)
	mr 24,5
	mr 25,29
	stw 28,4(10)
	lwz 0,8(27)
	lwz 9,4(27)
	stw 8,2280(1)
	stw 0,8(7)
	stw 9,4(7)
	bl SelectSpawnPoint
	lwz 4,84(31)
	mr 3,29
	li 5,76
	addi 4,4,1812
	crxor 6,6,6
	bl memcpy
	cmpwi 0,30,9
	bc 12,1,.L140
	lwz 9,84(31)
	li 0,0
	stw 0,1872(9)
.L140:
	lwz 4,84(31)
	addi 3,1,1752
	cmpwi 4,30,10
	mr 26,3
	li 5,512
	addi 4,4,188
	crxor 6,6,6
	bl memcpy
	bc 4,18,.L141
	lwz 29,84(31)
	lwz 4,1872(29)
	mr 3,29
	lwz 28,1868(29)
	lwz 27,1864(29)
	bl Set_ClassEquipment
	mr 3,28
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	stwx 27,29,3
	b .L143
.L141:
	lwz 3,84(31)
	mr 4,30
	bl Set_ClassEquipment
.L143:
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	lwz 4,84(31)
	addi 29,1,40
	li 5,1624
	mr 3,29
	addi 4,4,188
	crxor 6,6,6
	bl memcpy
	lwz 3,84(31)
	li 4,0
	li 5,2288
	crxor 6,6,6
	bl memset
	lwz 3,84(31)
	mr 4,29
	li 5,1624
	addi 3,3,188
	crxor 6,6,6
	bl memcpy
	lwz 3,84(31)
	mr 4,25
	li 5,76
	addi 3,3,1812
	crxor 6,6,6
	bl memcpy
	lwz 27,84(31)
	lwz 0,724(27)
	cmpwi 0,0,0
	bc 12,1,.L144
	bc 4,18,.L145
	lwz 4,1872(27)
	mr 3,27
	lwz 29,1868(27)
	lwz 28,1864(27)
	bl Set_ClassEquipment
	mr 3,29
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,27,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	stwx 28,11,3
	b .L144
.L145:
	mr 3,27
	mr 4,30
	bl Set_ClassEquipment
.L144:
	mr 3,31
	li 28,0
	bl FetchClientEntData
	li 29,0
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 6,264(31)
	lwz 11,g_edicts@l(9)
	ori 0,0,18087
	lis 10,game+1028@ha
	lis 9,.LC69@ha
	li 5,1
	lwz 27,892(31)
	subf 11,11,31
	la 9,.LC69@l(9)
	mullw 11,11,0
	stw 9,268(31)
	li 4,2
	lis 3,level+4@ha
	lwz 7,game+1028@l(10)
	li 9,22
	li 0,4
	srawi 11,11,2
	stw 9,508(31)
	lis 8,player_pain@ha
	mulli 11,11,2288
	lis 9,.LC74@ha
	stw 0,260(31)
	lis 10,player_die@ha
	stw 4,248(31)
	la 9,.LC74@l(9)
	la 8,player_pain@l(8)
	addi 11,11,-2288
	stw 28,56(31)
	la 10,player_die@l(10)
	add 7,7,11
	stw 29,948(31)
	rlwinm 6,6,0,21,19
	stw 5,644(31)
	stw 7,84(31)
	stw 28,552(31)
	stw 4,512(31)
	stw 5,88(31)
	stw 28,492(31)
	lfs 0,level+4@l(3)
	lfs 13,0(9)
	lwz 0,184(31)
	lis 9,0x201
	ori 9,9,3
	stw 30,896(31)
	fadds 0,0,13
	rlwinm 0,0,0,0,29
	stw 9,252(31)
	stw 0,184(31)
	stw 8,452(31)
	stw 10,456(31)
	stfs 0,404(31)
	stw 6,264(31)
	stw 28,612(31)
	stw 28,608(31)
	stw 29,952(31)
	stw 5,2260(7)
	lfs 0,2264(1)
	lwz 0,896(31)
	lfs 13,2268(1)
	stw 0,892(31)
	stfs 0,188(31)
	stfs 13,192(31)
	lwz 3,1096(31)
	lfs 12,2272(1)
	lfs 11,2280(1)
	cmpwi 0,3,0
	lfs 0,2284(1)
	lfs 13,2288(1)
	stfs 12,196(31)
	stfs 11,200(31)
	stfs 0,204(31)
	stfs 13,208(31)
	stw 29,384(31)
	stw 29,380(31)
	stw 29,376(31)
	bc 12,2,.L148
	bl G_FreeEdict
.L148:
	lwz 3,84(31)
	li 4,0
	li 5,184
	cmpw 4,27,30
	crxor 6,6,6
	bl memset
	lwz 11,84(31)
	lis 10,gi+32@ha
	stw 29,2236(11)
	lwz 9,84(31)
	stw 29,2232(9)
	lwz 11,84(31)
	lwz 0,gi+32@l(10)
	lwz 9,1788(11)
	mtlr 0
	lwz 3,32(9)
	blrl
	lis 9,.LC75@ha
	lis 0,0x42b4
	la 9,.LC75@l(9)
	lis 11,.LC76@ha
	lfs 8,0(9)
	la 11,.LC76@l(11)
	li 7,255
	lwz 9,84(31)
	mr 5,24
	li 4,0
	lfs 9,0(11)
	li 6,0
	stw 3,88(9)
	lwz 10,84(31)
	lis 9,.LC77@ha
	la 9,.LC77@l(9)
	stw 0,112(10)
	lfs 0,8(1)
	li 0,3
	lfs 10,0(9)
	mtctr 0
	lwz 10,84(31)
	mr 11,9
	mr 8,9
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,2304(1)
	lwz 9,2308(1)
	sth 9,4(10)
	lfs 0,12(1)
	lwz 9,84(31)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,2304(1)
	lwz 11,2308(1)
	sth 11,6(9)
	lfs 0,16(1)
	lwz 9,84(31)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,2304(1)
	lwz 8,2308(1)
	sth 8,8(9)
	lfs 0,8(1)
	lfs 13,12(1)
	lfs 12,16(1)
	stw 28,64(31)
	stw 7,44(31)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	stw 7,40(31)
.L213:
	lwz 10,84(31)
	add 0,4,4
	lfsx 0,6,5
	addi 4,4,1
	addi 9,10,1824
	lfsx 13,9,6
	addi 10,10,20
	addi 6,6,4
	fsubs 0,0,13
	fmuls 0,0,8
	fdivs 0,0,9
	fctiwz 12,0
	stfd 12,2304(1)
	lwz 11,2308(1)
	sthx 11,10,0
	bdnz .L213
	lfs 0,28(1)
	li 0,0
	mr 3,31
	lwz 11,84(31)
	stw 0,24(31)
	stfs 0,20(31)
	stw 0,16(31)
	stw 0,28(11)
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,32(9)
	lfs 0,24(31)
	lwz 11,84(31)
	stfs 0,36(11)
	lfs 0,16(31)
	lwz 9,84(31)
	stfs 0,2124(9)
	lfs 0,20(31)
	lwz 11,84(31)
	stfs 0,2128(11)
	lfs 0,24(31)
	lwz 9,84(31)
	stfs 0,2132(9)
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	bl Rip_SetSpeed
	mr 3,31
	bl Rip_SetSkin
	lwz 9,892(31)
	lwz 8,84(31)
	addi 9,9,-1
	cmplwi 0,9,8
	bc 12,1,.L155
	lis 11,.L156@ha
	slwi 10,9,2
	la 11,.L156@l(11)
	lis 9,.L156@ha
	lwzx 0,10,11
	la 9,.L156@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L156:
	.long .L157-.L156
	.long .L158-.L156
	.long .L159-.L156
	.long .L160-.L156
	.long .L161-.L156
	.long .L162-.L156
	.long .L163-.L156
	.long .L164-.L156
	.long .L165-.L156
.L157:
	li 9,3
	li 0,40
	b .L214
.L158:
	li 9,2
	li 0,50
	b .L214
.L159:
	li 9,2
	li 0,40
	b .L214
.L160:
	li 9,1
	li 0,40
	b .L214
.L161:
	li 9,1
	li 0,80
	b .L214
.L162:
	li 9,2
	li 0,80
	b .L214
.L163:
	li 9,3
	li 0,20
	b .L214
.L164:
	li 9,1
	li 0,60
.L214:
	stw 0,1864(8)
	stw 9,1884(8)
	b .L167
.L165:
	li 0,0
	stw 0,1864(8)
	b .L215
.L155:
	li 0,-1
.L215:
	stw 0,1884(8)
.L167:
	bc 12,18,.L168
	lwz 9,892(31)
	addi 9,9,-1
	cmplwi 0,9,9
	bc 12,1,.L182
	lis 11,.L170@ha
	slwi 10,9,2
	la 11,.L170@l(11)
	lis 9,.L170@ha
	lwzx 0,10,11
	la 9,.L170@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L170:
	.long .L171-.L170
	.long .L172-.L170
	.long .L179-.L170
	.long .L174-.L170
	.long .L175-.L170
	.long .L179-.L170
	.long .L177-.L170
	.long .L178-.L170
	.long .L179-.L170
	.long .L180-.L170
.L171:
	li 0,500
	b .L216
.L172:
	li 0,200
	b .L216
.L174:
	li 0,202
	b .L216
.L175:
	li 0,300
	b .L216
.L177:
	li 0,300
	b .L216
.L178:
	li 0,200
	b .L216
.L180:
	li 0,200
	b .L216
.L179:
	li 0,100
.L216:
	stw 0,400(31)
.L182:
	lwz 9,892(31)
	addi 9,9,-1
	cmplwi 0,9,9
	bc 12,1,.L196
	lis 11,.L184@ha
	slwi 10,9,2
	la 11,.L184@l(11)
	lis 9,.L184@ha
	lwzx 0,10,11
	la 9,.L184@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L184:
	.long .L185-.L184
	.long .L186-.L184
	.long .L187-.L184
	.long .L188-.L184
	.long .L189-.L184
	.long .L190-.L184
	.long .L191-.L184
	.long .L192-.L184
	.long .L193-.L184
	.long .L194-.L184
.L185:
	lis 9,.LC0@ha
	la 9,.LC0@l(9)
	b .L217
.L186:
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	b .L217
.L187:
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	b .L217
.L188:
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	b .L217
.L189:
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	b .L217
.L190:
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	b .L217
.L191:
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	b .L217
.L192:
	lis 9,.LC7@ha
	la 9,.LC7@l(9)
	b .L217
.L193:
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	b .L217
.L194:
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
.L217:
	stw 9,1084(31)
.L196:
	lwz 8,84(31)
	lis 7,.LC70@ha
	mr 4,31
	lwz 9,1084(31)
	la 7,.LC70@l(7)
	li 5,1
	addi 8,8,700
	li 6,2
	mr 3,31
	crxor 6,6,6
	bl tprintf
	mr 3,31
	bl PrintOtherClass
	mr 3,31
	bl Print_ClassProperties
	lwz 9,892(31)
	addi 9,9,-1
	cmplwi 0,9,9
	bc 12,1,.L210
	lis 11,.L198@ha
	slwi 10,9,2
	la 11,.L198@l(11)
	lis 9,.L198@ha
	lwzx 0,10,11
	la 9,.L198@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L198:
	.long .L199-.L198
	.long .L200-.L198
	.long .L201-.L198
	.long .L202-.L198
	.long .L208-.L198
	.long .L204-.L198
	.long .L205-.L198
	.long .L206-.L198
	.long .L207-.L198
	.long .L208-.L198
.L199:
	li 0,1
	b .L218
.L200:
	li 0,2
	b .L218
.L201:
	li 0,2
	b .L218
.L202:
	li 0,2
	b .L218
.L204:
	li 0,1
	b .L218
.L205:
	li 0,2
	b .L218
.L206:
	li 0,2
	b .L218
.L207:
.L208:
	li 0,3
.L218:
	stw 0,928(31)
.L210:
	lwz 3,84(31)
	lis 4,.LC71@ha
	la 4,.LC71@l(4)
	addi 3,3,188
	bl Info_ValueForKey
	bl atoi
	cmpwi 0,3,0
	bc 4,1,.L168
	lis 4,.LC72@ha
	mr 3,31
	la 4,.LC72@l(4)
	bl stuffcmd
	lwz 4,1084(31)
	mr 3,31
	bl stuffcmd
	lis 4,.LC73@ha
	mr 3,31
	la 4,.LC73@l(4)
	bl stuffcmd
.L168:
	lwz 9,84(31)
	mr 3,31
	lwz 0,1788(9)
	stw 0,2020(9)
	bl ChangeWeapon
	lwz 9,892(31)
	li 0,6
	stw 0,80(31)
	cmpwi 0,9,9
	bc 4,2,.L212
	mr 3,31
	bl Cell_VicMake
.L212:
	lwz 0,2356(1)
	lwz 12,2316(1)
	mtlr 0
	lmw 24,2320(1)
	mtcrf 8,12
	la 1,2352(1)
	blr
.Lfe3:
	.size	 ClassFunction,.Lfe3-ClassFunction
	.section	".rodata"
	.align 2
.LC78:
	.string	"male/"
	.align 2
.LC79:
	.string	"necro/"
	.align 2
.LC80:
	.string	"female/"
	.align 2
.LC81:
	.string	"waste/"
	.align 2
.LC82:
	.string	"cyborg/"
	.align 2
.LC83:
	.string	"4"
	.align 2
.LC84:
	.string	"13"
	.align 2
.LC85:
	.string	"skin "
	.align 2
.LC86:
	.string	"\n"
	.align 2
.LC87:
	.string	"skin"
	.section	".text"
	.align 2
	.globl Rip_SetSkin
	.type	 Rip_SetSkin,@function
Rip_SetSkin:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 11,892(31)
	xori 9,11,1
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,5
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 4,2,.L221
	cmpwi 0,11,7
	bc 4,2,.L220
.L221:
	lis 9,.LC78@ha
	addi 11,31,956
	lwz 10,.LC78@l(9)
	mr 30,11
	la 9,.LC78@l(9)
	lhz 0,4(9)
	stw 10,956(31)
	sth 0,4(11)
	b .L222
.L220:
	cmpwi 0,11,2
	bc 4,2,.L223
	lis 9,.LC79@ha
	addi 11,31,956
	lwz 8,.LC79@l(9)
	mr 30,11
	la 9,.LC79@l(9)
	b .L233
.L223:
	cmpwi 0,11,3
	bc 4,2,.L225
	lis 9,.LC80@ha
	addi 11,31,956
	lwz 10,.LC80@l(9)
	mr 30,11
	la 9,.LC80@l(9)
	b .L234
.L225:
	cmpwi 0,11,6
	bc 4,2,.L227
	lis 9,.LC81@ha
	addi 11,31,956
	lwz 8,.LC81@l(9)
	mr 30,11
	la 9,.LC81@l(9)
.L233:
	lbz 10,6(9)
	lhz 0,4(9)
	stw 8,956(31)
	sth 0,4(11)
	stb 10,6(11)
	b .L222
.L227:
	lis 9,.LC82@ha
	addi 11,31,956
	lwz 10,.LC82@l(9)
	mr 30,11
	la 9,.LC82@l(9)
.L234:
	lwz 0,4(9)
	stw 10,956(31)
	stw 0,4(11)
.L222:
	lwz 9,84(31)
	lwz 0,1820(9)
	cmpwi 0,0,2
	bc 4,2,.L229
	lis 4,.LC83@ha
	mr 3,30
	la 4,.LC83@l(4)
	bl strcat
	b .L230
.L229:
	cmpwi 0,0,1
	bc 4,2,.L230
	lis 4,.LC84@ha
	mr 3,30
	la 4,.LC84@l(4)
	bl strcat
.L230:
	lis 4,.LC85@ha
	mr 3,31
	la 4,.LC85@l(4)
	bl stuffcmd
	mr 4,30
	mr 3,31
	bl stuffcmd
	lis 4,.LC86@ha
	mr 3,31
	la 4,.LC86@l(4)
	bl stuffcmd
	lwz 3,84(31)
	lis 4,.LC87@ha
	mr 5,30
	la 4,.LC87@l(4)
	addi 3,3,188
	bl Info_SetValueForKey
	mr 3,31
	bl Rip_SkinHim
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,908(31)
	andi. 9,0,2
	bc 4,2,.L232
	ori 0,0,2
	stw 0,908(31)
.L232:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 Rip_SetSkin,.Lfe4-Rip_SetSkin
	.section	".rodata"
	.align 2
.LC88:
	.string	"%s\\%s"
	.align 2
.LC89:
	.string	"cl_forwardspeed "
	.align 2
.LC90:
	.string	"cl_sidespeed "
	.align 2
.LC91:
	.string	"%i"
	.section	".text"
	.align 2
	.globl Rip_SetSpeed
	.type	 Rip_SetSpeed,@function
Rip_SetSpeed:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 10,892(31)
	cmplwi 0,10,10
	bc 12,1,.L238
	lis 11,.L250@ha
	slwi 10,10,2
	la 11,.L250@l(11)
	lis 9,.L250@ha
	lwzx 0,10,11
	la 9,.L250@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L250:
	.long .L239-.L250
	.long .L240-.L250
	.long .L241-.L250
	.long .L242-.L250
	.long .L243-.L250
	.long .L244-.L250
	.long .L245-.L250
	.long .L246-.L250
	.long .L247-.L250
	.long .L248-.L250
	.long .L249-.L250
.L239:
	li 0,225
	b .L255
.L240:
	li 0,175
	b .L255
.L241:
	li 0,225
	b .L255
.L242:
	li 0,320
	b .L255
.L243:
	li 0,150
	b .L255
.L244:
	li 0,180
	b .L255
.L245:
	li 0,315
	b .L255
.L246:
	li 0,225
	b .L255
.L247:
	li 0,240
	b .L255
.L248:
	li 0,150
	b .L255
.L249:
	lwz 9,84(31)
	lwz 0,1876(9)
	mulli 0,0,45
.L255:
	stw 0,944(31)
.L238:
	lwz 0,908(31)
	andi. 9,0,1
	bc 12,2,.L252
	lwz 0,944(31)
	srwi 9,0,31
	add 0,0,9
	srawi 0,0,1
	stw 0,944(31)
.L252:
	addi 3,1,8
	lwz 5,944(31)
	lis 4,.LC91@ha
	mr 29,3
	la 4,.LC91@l(4)
	crxor 6,6,6
	bl strcpy_
	lis 30,.LC86@ha
	lis 4,.LC89@ha
	mr 3,31
	la 4,.LC89@l(4)
	bl stuffcmd
	mr 3,31
	mr 4,29
	bl stuffcmd
	la 4,.LC86@l(30)
	mr 3,31
	bl stuffcmd
	lis 4,.LC90@ha
	mr 3,31
	la 4,.LC90@l(4)
	bl stuffcmd
	mr 4,29
	mr 3,31
	bl stuffcmd
	mr 3,31
	la 4,.LC86@l(30)
	bl stuffcmd
	lwz 0,908(31)
	andi. 9,0,2
	bc 12,2,.L254
	lis 4,.LC85@ha
	mr 3,31
	la 4,.LC85@l(4)
	addi 29,31,956
	bl stuffcmd
	mr 3,31
	mr 4,29
	bl stuffcmd
	la 4,.LC86@l(30)
	mr 3,31
	bl stuffcmd
	lwz 3,84(31)
	lis 4,.LC87@ha
	mr 5,29
	la 4,.LC87@l(4)
	addi 3,3,188
	bl Info_SetValueForKey
.L254:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 Rip_SetSpeed,.Lfe5-Rip_SetSpeed
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.align 2
	.globl SetCustomEquipment
	.type	 SetCustomEquipment,@function
SetCustomEquipment:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 29,3
	lwz 4,1872(29)
	lwz 28,1868(29)
	lwz 27,1864(29)
	bl Set_ClassEquipment
	mr 3,28
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	stwx 27,29,3
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 SetCustomEquipment,.Lfe6-SetCustomEquipment
	.align 2
	.globl Rip_SkinHim
	.type	 Rip_SkinHim,@function
Rip_SkinHim:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,g_edicts@ha
	mr 29,3
	lwz 11,g_edicts@l(9)
	addi 5,29,956
	lis 0,0xbfc5
	lwz 4,84(29)
	ori 0,0,18087
	lis 28,gi@ha
	subf 29,11,29
	lis 3,.LC88@ha
	mullw 29,29,0
	la 28,gi@l(28)
	addi 4,4,700
	la 3,.LC88@l(3)
	srawi 29,29,2
	addi 29,29,1311
	crxor 6,6,6
	bl va
	lwz 0,24(28)
	mr 4,3
	mr 3,29
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 Rip_SkinHim,.Lfe7-Rip_SkinHim
	.align 2
	.globl sparks
	.type	 sparks,@function
sparks:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,9
	bl muzzleflash
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 sparks,.Lfe8-sparks
	.align 2
	.globl MyCustom_Sel
	.type	 MyCustom_Sel,@function
MyCustom_Sel:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	cmplwi 0,4,7
	bc 12,1,.L9
	lis 11,.L18@ha
	slwi 10,4,2
	la 11,.L18@l(11)
	lis 9,.L18@ha
	lwzx 0,10,11
	la 9,.L18@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L18:
	.long .L10-.L18
	.long .L11-.L18
	.long .L12-.L18
	.long .L13-.L18
	.long .L14-.L18
	.long .L15-.L18
	.long .L16-.L18
	.long .L17-.L18
.L10:
	lwz 9,84(3)
	li 0,1
	b .L256
.L11:
	lwz 9,84(3)
	li 0,2
	b .L256
.L12:
	lwz 9,84(3)
	li 0,3
	b .L256
.L13:
	lwz 9,84(3)
	li 0,4
	b .L256
.L14:
	lwz 9,84(3)
	li 0,5
	b .L256
.L15:
	lwz 9,84(3)
	li 0,6
	b .L256
.L16:
	lwz 9,84(3)
	li 0,7
.L256:
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	stw 0,1872(9)
	bl stuffcmd
	b .L9
.L17:
	lwz 9,84(3)
	li 0,8
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	stw 0,1872(9)
	bl stuffcmd
.L9:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 MyCustom_Sel,.Lfe9-MyCustom_Sel
	.align 2
	.globl Cmd_Custom_f
	.type	 Cmd_Custom_f,@function
Cmd_Custom_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,1916(9)
	cmpwi 0,0,0
	bc 4,2,.L20
	lwz 0,1920(9)
	cmpwi 0,0,0
	bc 4,2,.L20
	lwz 0,1932(9)
	cmpwi 0,0,0
	bc 4,2,.L20
	lwz 0,1936(9)
	cmpwi 0,0,0
	bc 4,2,.L20
	lis 4,.LC10@ha
	la 4,.LC10@l(4)
	bl Menu_Title
	lis 4,.LC11@ha
	mr 3,31
	la 4,.LC11@l(4)
	bl Menu_Add
	lis 4,.LC12@ha
	mr 3,31
	la 4,.LC12@l(4)
	bl Menu_Add
	lis 4,.LC13@ha
	mr 3,31
	la 4,.LC13@l(4)
	bl Menu_Add
	lis 4,.LC14@ha
	mr 3,31
	la 4,.LC14@l(4)
	bl Menu_Add
	lis 4,.LC15@ha
	mr 3,31
	la 4,.LC15@l(4)
	bl Menu_Add
	lis 4,.LC16@ha
	mr 3,31
	la 4,.LC16@l(4)
	bl Menu_Add
	lis 4,.LC17@ha
	mr 3,31
	la 4,.LC17@l(4)
	bl Menu_Add
	lis 4,.LC18@ha
	mr 3,31
	la 4,.LC18@l(4)
	bl Menu_Add
	lwz 11,84(31)
	lis 9,MyCustom_Sel@ha
	mr 3,31
	la 9,MyCustom_Sel@l(9)
	stw 9,1996(11)
	bl Menu_Open
.L20:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 Cmd_Custom_f,.Lfe10-Cmd_Custom_f
	.align 2
	.globl MySpeed_Sel
	.type	 MySpeed_Sel,@function
MySpeed_Sel:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	cmplwi 0,4,4
	bc 12,1,.L24
	lis 11,.L30@ha
	slwi 10,4,2
	la 11,.L30@l(11)
	lis 9,.L30@ha
	lwzx 0,10,11
	la 9,.L30@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L30:
	.long .L25-.L30
	.long .L26-.L30
	.long .L27-.L30
	.long .L28-.L30
	.long .L29-.L30
.L25:
	lwz 9,84(3)
	li 0,4
	b .L257
.L26:
	lwz 9,84(3)
	li 0,2
	b .L257
.L27:
	lwz 9,84(3)
	li 0,5
	b .L257
.L28:
	lwz 9,84(3)
	li 0,3
.L257:
	lis 4,.LC19@ha
	la 4,.LC19@l(4)
	stw 0,1876(9)
	bl stuffcmd
	b .L24
.L29:
	lwz 9,84(3)
	li 0,4
	lis 4,.LC19@ha
	la 4,.LC19@l(4)
	stw 0,1876(9)
	bl stuffcmd
.L24:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 MySpeed_Sel,.Lfe11-MySpeed_Sel
	.align 2
	.globl Cmd_Speed_f
	.type	 Cmd_Speed_f,@function
Cmd_Speed_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,1916(9)
	cmpwi 0,0,0
	bc 4,2,.L32
	lwz 0,1920(9)
	cmpwi 0,0,0
	bc 4,2,.L32
	lwz 0,1932(9)
	cmpwi 0,0,0
	bc 4,2,.L32
	lwz 0,1936(9)
	cmpwi 0,0,0
	bc 4,2,.L32
	lis 4,.LC20@ha
	la 4,.LC20@l(4)
	bl Menu_Title
	lis 4,.LC21@ha
	mr 3,31
	la 4,.LC21@l(4)
	bl Menu_Add
	lis 4,.LC22@ha
	mr 3,31
	la 4,.LC22@l(4)
	bl Menu_Add
	lis 4,.LC23@ha
	mr 3,31
	la 4,.LC23@l(4)
	bl Menu_Add
	lis 4,.LC24@ha
	mr 3,31
	la 4,.LC24@l(4)
	bl Menu_Add
	lis 4,.LC25@ha
	mr 3,31
	la 4,.LC25@l(4)
	bl Menu_Add
	lwz 11,84(31)
	lis 9,MySpeed_Sel@ha
	mr 3,31
	la 9,MySpeed_Sel@l(9)
	stw 9,1996(11)
	bl Menu_Open
.L32:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 Cmd_Speed_f,.Lfe12-Cmd_Speed_f
	.align 2
	.globl MyArmor_Sel
	.type	 MyArmor_Sel,@function
MyArmor_Sel:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	cmpwi 0,4,1
	mr 8,3
	bc 12,2,.L38
	bc 12,1,.L42
	cmpwi 0,4,0
	bc 12,2,.L37
	b .L36
.L42:
	cmpwi 0,4,2
	bc 12,2,.L39
	b .L36
.L37:
	lwz 10,84(8)
	lis 9,.LC26@ha
	li 11,250
	la 9,.LC26@l(9)
	b .L258
.L38:
	lwz 10,84(8)
	lis 9,.LC28@ha
	li 11,650
	la 9,.LC28@l(9)
.L258:
	lis 4,.LC27@ha
	stw 9,1868(10)
	mr 3,8
	la 4,.LC27@l(4)
	lwz 9,84(8)
	lwz 0,1876(9)
	divw 11,11,0
	stw 11,1864(9)
	bl stuffcmd
	b .L36
.L39:
	lwz 10,84(8)
	lis 9,.LC29@ha
	li 11,325
	la 9,.LC29@l(9)
	lis 4,.LC27@ha
	stw 9,1868(10)
	mr 3,8
	la 4,.LC27@l(4)
	lwz 9,84(8)
	lwz 0,1876(9)
	divw 11,11,0
	stw 11,1864(9)
	bl stuffcmd
.L36:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 MyArmor_Sel,.Lfe13-MyArmor_Sel
	.align 2
	.globl Cmd_Armor_f
	.type	 Cmd_Armor_f,@function
Cmd_Armor_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,1916(9)
	cmpwi 0,0,0
	bc 4,2,.L43
	lwz 0,1920(9)
	cmpwi 0,0,0
	bc 4,2,.L43
	lwz 0,1932(9)
	cmpwi 0,0,0
	bc 4,2,.L43
	lwz 0,1936(9)
	cmpwi 0,0,0
	bc 4,2,.L43
	lis 4,.LC30@ha
	la 4,.LC30@l(4)
	bl Menu_Title
	lis 4,.LC28@ha
	mr 3,31
	la 4,.LC28@l(4)
	bl Menu_Add
	lis 4,.LC29@ha
	mr 3,31
	la 4,.LC29@l(4)
	bl Menu_Add
	lis 4,.LC31@ha
	mr 3,31
	la 4,.LC31@l(4)
	bl Menu_Add
	lwz 11,84(31)
	lis 9,MyArmor_Sel@ha
	mr 3,31
	la 9,MyArmor_Sel@l(9)
	stw 9,1996(11)
	bl Menu_Open
.L43:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 Cmd_Armor_f,.Lfe14-Cmd_Armor_f
	.align 2
	.globl MyDone_Sel
	.type	 MyDone_Sel,@function
MyDone_Sel:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,10
	bl ClassFunction
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 MyDone_Sel,.Lfe15-MyDone_Sel
	.align 2
	.globl Cmd_Done_f
	.type	 Cmd_Done_f,@function
Cmd_Done_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,892(31)
	cmpwi 0,0,0
	bc 12,1,.L47
	lwz 9,84(31)
	lwz 0,1916(9)
	cmpwi 0,0,0
	bc 4,2,.L47
	lwz 0,1920(9)
	cmpwi 0,0,0
	bc 4,2,.L47
	lwz 0,1932(9)
	cmpwi 0,0,0
	bc 4,2,.L47
	lwz 0,1936(9)
	cmpwi 0,0,0
	bc 4,2,.L47
	lis 29,.LC32@ha
	la 4,.LC32@l(29)
	bl Menu_Title
	mr 3,31
	la 4,.LC32@l(29)
	bl Menu_Add
	lis 9,gi+4@ha
	lwz 11,84(31)
	lis 3,.LC33@ha
	lwz 0,gi+4@l(9)
	la 3,.LC33@l(3)
	lwz 5,1864(11)
	lwz 4,1868(11)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	lis 9,MyDone_Sel@ha
	mr 3,31
	la 9,MyDone_Sel@l(9)
	stw 9,1996(11)
	bl Menu_Open
.L47:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 Cmd_Done_f,.Lfe16-Cmd_Done_f
	.align 2
	.globl SetClassName
	.type	 SetClassName,@function
SetClassName:
	lwz 9,892(3)
	addi 9,9,-1
	cmplwi 0,9,9
	bclr 12,1
	lis 11,.L63@ha
	slwi 10,9,2
	la 11,.L63@l(11)
	lis 9,.L63@ha
	lwzx 0,10,11
	la 9,.L63@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L63:
	.long .L53-.L63
	.long .L54-.L63
	.long .L55-.L63
	.long .L56-.L63
	.long .L57-.L63
	.long .L58-.L63
	.long .L59-.L63
	.long .L60-.L63
	.long .L61-.L63
	.long .L62-.L63
.L53:
	lis 9,.LC0@ha
	la 9,.LC0@l(9)
	stw 9,1084(3)
	blr
.L54:
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	stw 9,1084(3)
	blr
.L55:
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	stw 9,1084(3)
	blr
.L56:
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	stw 9,1084(3)
	blr
.L57:
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	stw 9,1084(3)
	blr
.L58:
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	stw 9,1084(3)
	blr
.L59:
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	stw 9,1084(3)
	blr
.L60:
	lis 9,.LC7@ha
	la 9,.LC7@l(9)
	stw 9,1084(3)
	blr
.L61:
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	stw 9,1084(3)
	blr
.L62:
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	stw 9,1084(3)
	blr
.Lfe17:
	.size	 SetClassName,.Lfe17-SetClassName
	.align 2
	.globl SetClassMass
	.type	 SetClassMass,@function
SetClassMass:
	lwz 9,892(3)
	addi 9,9,-1
	cmplwi 0,9,9
	bclr 12,1
	lis 11,.L77@ha
	slwi 10,9,2
	la 11,.L77@l(11)
	lis 9,.L77@ha
	lwzx 0,10,11
	la 9,.L77@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L77:
	.long .L67-.L77
	.long .L68-.L77
	.long .L69-.L77
	.long .L70-.L77
	.long .L71-.L77
	.long .L69-.L77
	.long .L71-.L77
	.long .L68-.L77
	.long .L69-.L77
	.long .L68-.L77
.L67:
	li 0,500
	stw 0,400(3)
	blr
.L68:
	li 0,200
	stw 0,400(3)
	blr
.L69:
	li 0,100
	stw 0,400(3)
	blr
.L70:
	li 0,202
	stw 0,400(3)
	blr
.L71:
	li 0,300
	stw 0,400(3)
	blr
.Lfe18:
	.size	 SetClassMass,.Lfe18-SetClassMass
	.align 2
	.globl SetTeamState
	.type	 SetTeamState,@function
SetTeamState:
	lwz 9,892(3)
	addi 9,9,-1
	cmplwi 0,9,9
	bclr 12,1
	lis 11,.L91@ha
	slwi 10,9,2
	la 11,.L91@l(11)
	lis 9,.L91@ha
	lwzx 0,10,11
	la 9,.L91@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L91:
	.long .L81-.L91
	.long .L82-.L91
	.long .L82-.L91
	.long .L82-.L91
	.long .L85-.L91
	.long .L81-.L91
	.long .L82-.L91
	.long .L82-.L91
	.long .L85-.L91
	.long .L85-.L91
.L81:
	li 0,1
	stw 0,928(3)
	blr
.L82:
	li 0,2
	stw 0,928(3)
	blr
.L85:
	li 0,3
	stw 0,928(3)
	blr
.Lfe19:
	.size	 SetTeamState,.Lfe19-SetTeamState
	.align 2
	.globl Set_ClassArmor
	.type	 Set_ClassArmor,@function
Set_ClassArmor:
	addi 4,4,-1
	cmplwi 0,4,8
	bc 12,1,.L119
	lis 11,.L120@ha
	slwi 10,4,2
	la 11,.L120@l(11)
	lis 9,.L120@ha
	lwzx 0,10,11
	la 9,.L120@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L120:
	.long .L110-.L120
	.long .L111-.L120
	.long .L112-.L120
	.long .L113-.L120
	.long .L114-.L120
	.long .L115-.L120
	.long .L116-.L120
	.long .L117-.L120
	.long .L118-.L120
.L110:
	li 9,3
.L260:
	li 0,40
.L259:
	stw 0,1864(3)
	stw 9,1884(3)
	blr
.L111:
	li 9,2
	li 0,50
	b .L259
.L112:
	li 9,2
	b .L260
.L113:
	li 9,1
	b .L260
.L114:
	li 9,1
	li 0,80
	b .L259
.L115:
	li 9,2
	li 0,80
	b .L259
.L116:
	li 9,3
	li 0,20
	b .L259
.L117:
	li 9,1
	li 0,60
	b .L259
.L118:
	li 0,0
	stw 0,1864(3)
	stw 0,1884(3)
	blr
.L119:
	li 0,-1
	stw 0,1884(3)
	blr
.Lfe20:
	.size	 Set_ClassArmor,.Lfe20-Set_ClassArmor
	.align 2
	.globl stuffcmd_speed
	.type	 stuffcmd_speed,@function
stuffcmd_speed:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 28,4
	mr 29,3
	lis 4,.LC89@ha
	la 4,.LC89@l(4)
	lis 27,.LC86@ha
	bl stuffcmd
	mr 3,29
	mr 4,28
	bl stuffcmd
	la 4,.LC86@l(27)
	mr 3,29
	bl stuffcmd
	lis 4,.LC90@ha
	mr 3,29
	la 4,.LC90@l(4)
	bl stuffcmd
	mr 4,28
	mr 3,29
	bl stuffcmd
	mr 3,29
	la 4,.LC86@l(27)
	bl stuffcmd
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 stuffcmd_speed,.Lfe21-stuffcmd_speed
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
