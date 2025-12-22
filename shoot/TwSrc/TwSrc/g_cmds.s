	.file	"g_cmds.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"detpipe"
	.align 2
.LC2:
	.string	"You must run the server with '+set cheats 1' to enable this command.\n"
	.align 2
.LC3:
	.string	"all"
	.align 2
.LC4:
	.string	"health"
	.align 2
.LC5:
	.string	"weapons"
	.align 2
.LC6:
	.string	"ammo"
	.align 2
.LC7:
	.string	"armor"
	.align 2
.LC8:
	.string	"Jacket Armor"
	.align 2
.LC9:
	.string	"Combat Armor"
	.align 2
.LC10:
	.string	"Body Armor"
	.align 2
.LC11:
	.string	"Power Shield"
	.align 2
.LC12:
	.string	"unknown item\n"
	.align 2
.LC13:
	.string	"non-pickup item\n"
	.align 2
.LC14:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Give_f
	.type	 Cmd_Give_f,@function
Cmd_Give_f:
	stwu 1,-48(1)
	mflr 0
	mfcr 12
	stmw 26,24(1)
	stw 0,52(1)
	stw 12,20(1)
	lis 9,deathmatch@ha
	lis 10,.LC14@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC14@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L46
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L46
	lis 9,gi+8@ha
	lis 5,.LC2@ha
	lwz 0,gi+8@l(9)
	la 5,.LC2@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L45
.L46:
	lis 9,gi@ha
	la 28,gi@l(9)
	lwz 9,164(28)
	mtlr 9
	blrl
	mr 26,3
	lis 4,.LC3@ha
	la 4,.LC3@l(4)
	bl Q_stricmp
	subfic 0,3,0
	adde. 30,0,3
	mfcr 29
	bc 4,2,.L50
	lwz 9,160(28)
	li 3,1
	rlwinm 29,29,16,0xffffffff
	mtcrf 8,29
	rlwinm 29,29,16,0xffffffff
	mtlr 9
	blrl
	lis 4,.LC4@ha
	la 4,.LC4@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L49
.L50:
	lwz 9,156(28)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L51
	lwz 0,160(28)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	stw 3,728(31)
	b .L52
.L51:
	lwz 0,756(31)
	stw 0,728(31)
.L52:
	cmpwi 4,30,0
	bc 12,18,.L45
.L49:
	bc 4,18,.L55
	lis 4,.LC5@ha
	mr 3,26
	la 4,.LC5@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L54
.L55:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L57
	lis 9,itemlist@ha
	mr 7,11
	la 8,itemlist@l(9)
	li 10,0
.L59:
	mr 27,8
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L58
	lwz 0,56(27)
	andi. 9,0,1
	bc 12,2,.L58
	lwz 11,84(31)
	addi 11,11,748
	lwzx 9,11,10
	addi 9,9,1
	stwx 9,11,10
.L58:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 8,8,72
	cmpw 0,29,0
	bc 12,0,.L59
.L57:
	bc 12,18,.L45
.L54:
	bc 4,18,.L65
	lis 4,.LC6@ha
	mr 3,26
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L64
.L65:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L67
	lis 9,itemlist@ha
	mr 30,11
	la 28,itemlist@l(9)
.L69:
	mr 27,28
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L68
	lwz 0,56(27)
	andi. 9,0,2
	bc 12,2,.L68
	mr 4,27
	mr 3,31
	li 5,1000
	bl Add_Ammo
.L68:
	lwz 0,1556(30)
	addi 29,29,1
	addi 28,28,72
	cmpw 0,29,0
	bc 12,0,.L69
.L67:
	bc 12,18,.L45
.L64:
	bc 4,18,.L75
	lis 4,.LC7@ha
	mr 3,26
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L74
.L75:
	lis 3,.LC8@ha
	lis 28,0x38e3
	la 3,.LC8@l(3)
	ori 28,28,36409
	bl FindItem
	li 27,0
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC9@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 9,9,748
	mullw 0,0,28
	la 3,.LC9@l(11)
	srawi 0,0,3
	slwi 0,0,2
	stwx 27,9,0
	bl FindItem
	subf 0,29,3
	lwz 9,84(31)
	mullw 0,0,28
	lis 3,.LC10@ha
	addi 9,9,748
	la 3,.LC10@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 27,9,0
	bl FindItem
	mr 27,3
	lwz 9,84(31)
	subf 29,29,27
	lwz 11,60(27)
	mullw 29,29,28
	addi 9,9,748
	lwz 0,4(11)
	srawi 29,29,3
	slwi 29,29,2
	stwx 0,9,29
	bc 12,18,.L45
.L74:
	bc 4,18,.L78
	lis 4,.LC11@ha
	mr 3,26
	la 4,.LC11@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L77
.L78:
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	bl FindItem
	mr 27,3
	bl G_Spawn
	lwz 0,0(27)
	mr 29,3
	mr 4,27
	stw 0,284(29)
	bl SpawnItem
	mr 3,29
	mr 4,31
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L79
	mr 3,29
	bl G_FreeEdict
.L79:
	bc 12,18,.L45
.L77:
	bc 12,18,.L81
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L45
	lis 9,itemlist@ha
	mr 7,11
	la 11,itemlist@l(9)
	li 8,1
	li 10,0
.L85:
	lwz 0,4(11)
	cmpwi 0,0,0
	bc 12,2,.L84
	lwz 0,56(11)
	andi. 9,0,7
	bc 4,2,.L84
	lwz 9,84(31)
	addi 9,9,748
	stwx 8,9,10
.L84:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 11,11,72
	cmpw 0,29,0
	bc 12,0,.L85
	b .L45
.L81:
	mr 3,26
	bl FindItem
	mr. 27,3
	bc 4,2,.L89
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	bl FindItem
	mr. 27,3
	bc 4,2,.L89
	lwz 0,4(29)
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	b .L97
.L89:
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 4,2,.L91
	lis 9,gi+4@ha
	lis 3,.LC13@ha
	lwz 0,gi+4@l(9)
	la 3,.LC13@l(3)
.L97:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L45
.L91:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,56(27)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,27
	andi. 10,11,2
	mullw 9,9,0
	srawi 28,9,3
	bc 12,2,.L92
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L93
	lwz 0,160(29)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	slwi 0,28,2
	addi 9,9,748
	stwx 3,9,0
	b .L45
.L93:
	lwz 9,84(31)
	slwi 10,28,2
	lwz 11,48(27)
	addi 9,9,748
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L45
.L92:
	bl G_Spawn
	lwz 0,0(27)
	mr 29,3
	mr 4,27
	stw 0,284(29)
	bl SpawnItem
	mr 4,31
	mr 3,29
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L45
	mr 3,29
	bl G_FreeEdict
.L45:
	lwz 0,52(1)
	lwz 12,20(1)
	mtlr 0
	lmw 26,24(1)
	mtcrf 8,12
	la 1,48(1)
	blr
.Lfe1:
	.size	 Cmd_Give_f,.Lfe1-Cmd_Give_f
	.section	".rodata"
	.align 2
.LC15:
	.string	"The airstrike has been called off!!\n"
	.align 2
.LC16:
	.string	"world/pilot1.wav"
	.align 2
.LC18:
	.string	"Airstrikes have to come from the sky!!!\n"
	.align 2
.LC19:
	.string	"Airstrike on it's way! Light on the target. ETA 15 seconds.\n"
	.align 2
.LC20:
	.string	"world/pilot3.wav"
	.align 2
.LC17:
	.long 0x3ecccccd
	.align 2
.LC21:
	.long 0x3f4ccccd
	.align 2
.LC22:
	.long 0x3f800000
	.align 2
.LC23:
	.long 0x0
	.align 3
.LC24:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC25:
	.long 0x46000000
	.align 2
.LC26:
	.long 0x41600000
	.section	".text"
	.align 2
	.globl Cmd_Airstrike_f
	.type	 Cmd_Airstrike_f,@function
Cmd_Airstrike_f:
	stwu 1,-160(1)
	mflr 0
	stmw 28,144(1)
	stw 0,164(1)
	mr 31,3
	lwz 11,84(31)
	lwz 0,3928(11)
	cmpwi 0,0,0
	bc 12,2,.L99
	li 28,0
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 28,3928(11)
	lis 5,.LC15@ha
	lwz 9,8(29)
	la 5,.LC15@l(5)
	li 4,2
	b .L103
.L99:
	lwz 0,1836(11)
	cmpwi 0,0,1
	bc 12,2,.L98
	li 0,1
	stw 0,1836(11)
	lis 10,.LC24@ha
	addi 29,1,24
	lwz 0,784(31)
	lis 11,0x4330
	la 10,.LC24@l(10)
	lfd 11,0(10)
	addi 28,1,56
	addi 30,1,72
	xoris 0,0,0x8000
	lfs 13,12(31)
	li 6,0
	stw 0,140(1)
	mr 4,29
	li 5,0
	stw 11,136(1)
	lfd 0,136(1)
	lfs 10,4(31)
	lfs 12,8(31)
	fsub 0,0,11
	lwz 3,84(31)
	stfs 10,8(1)
	stfs 12,12(1)
	addi 3,3,3752
	frsp 0,0
	fadds 13,13,0
	stfs 13,16(1)
	bl AngleVectors
	lis 9,.LC25@ha
	mr 4,29
	la 9,.LC25@l(9)
	addi 3,1,8
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 11,gi@ha
	lis 9,0x600
	la 29,gi@l(11)
	ori 9,9,27
	lwz 11,48(29)
	mr 3,30
	addi 4,1,8
	li 5,0
	li 6,0
	mr 7,28
	mr 8,31
	mtlr 11
	blrl
	lwz 9,116(1)
	cmpwi 0,9,0
	bc 12,2,.L101
	lwz 0,16(9)
	andi. 9,0,4
	bc 4,2,.L101
	lis 10,.LC25@ha
	lfs 12,84(1)
	li 0,0
	lfs 13,88(1)
	la 10,.LC25@l(10)
	lis 9,0x3f80
	lfs 0,92(1)
	addi 3,1,8
	addi 4,1,40
	lfs 1,0(10)
	mr 5,28
	stw 9,48(1)
	stfs 12,8(1)
	stfs 13,12(1)
	stfs 0,16(1)
	stw 0,44(1)
	stw 0,40(1)
	bl VectorMA
	lwz 11,48(29)
	lis 9,0x600
	mr 3,30
	ori 9,9,27
	mr 7,28
	addi 4,1,8
	li 5,0
	mtlr 11
	li 6,0
	mr 8,31
	blrl
	lwz 9,116(1)
	cmpwi 0,9,0
	bc 12,2,.L101
	lwz 0,16(9)
	andi. 28,0,4
	bc 4,2,.L101
	lwz 9,8(29)
	lis 5,.LC18@ha
	li 4,2
	la 5,.LC18@l(5)
	mr 3,31
.L103:
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC16@ha
	la 3,.LC16@l(3)
	mtlr 9
	blrl
	lis 9,.LC17@ha
	lwz 0,16(29)
	lis 10,.LC23@ha
	lfs 1,.LC17@l(9)
	mr 5,3
	la 10,.LC23@l(10)
	lis 9,.LC22@ha
	mr 3,31
	lfs 3,0(10)
	mtlr 0
	la 9,.LC22@l(9)
	li 4,3
	lfs 2,0(9)
	blrl
	lwz 9,84(31)
	stw 28,1836(9)
	b .L98
.L101:
	lfs 0,84(1)
	lis 11,.LC26@ha
	li 0,1
	lwz 9,84(31)
	la 11,.LC26@l(11)
	lis 10,level+4@ha
	lfs 13,0(11)
	lis 29,gi@ha
	lis 5,.LC19@ha
	stfs 0,3932(9)
	la 29,gi@l(29)
	la 5,.LC19@l(5)
	lfs 0,88(1)
	li 4,2
	mr 3,31
	lwz 9,84(31)
	stfs 0,3936(9)
	lfs 0,92(1)
	lwz 11,84(31)
	stfs 0,3940(11)
	lwz 9,84(31)
	stw 0,3928(9)
	lfs 0,level+4@l(10)
	lwz 9,84(31)
	fadds 0,0,13
	stfs 0,3944(9)
	lwz 9,8(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	mtlr 9
	blrl
	lis 9,.LC21@ha
	lwz 0,16(29)
	lis 10,.LC23@ha
	lfs 1,.LC21@l(9)
	mr 5,3
	la 10,.LC23@l(10)
	lis 9,.LC22@ha
	mr 3,31
	lfs 3,0(10)
	mtlr 0
	la 9,.LC22@l(9)
	li 4,3
	lfs 2,0(9)
	blrl
.L98:
	lwz 0,164(1)
	mtlr 0
	lmw 28,144(1)
	la 1,160(1)
	blr
.Lfe2:
	.size	 Cmd_Airstrike_f,.Lfe2-Cmd_Airstrike_f
	.section	".rodata"
	.align 2
.LC27:
	.string	"godmode OFF\n"
	.align 2
.LC28:
	.string	"godmode ON\n"
	.align 2
.LC29:
	.string	"notarget OFF\n"
	.align 2
.LC30:
	.string	"notarget ON\n"
	.align 2
.LC31:
	.string	"noclip OFF\n"
	.align 2
.LC32:
	.string	"noclip ON\n"
	.align 2
.LC33:
	.string	"unknown item: %s\n"
	.align 2
.LC34:
	.string	"Item is not usable.\n"
	.align 2
.LC35:
	.string	"Out of item: %s\n"
	.align 2
.LC36:
	.string	"Item is not dropable.\n"
	.align 2
.LC37:
	.ascii	"You are now in Spectator mode, type one\nof following comman"
	.ascii	"ds to get out\nScout          = Spawn as scout\nAssasin     "
	.ascii	"   = Spawn as assasin\nSoldier "
	.string	"       = Spawn as soldier\nDemoman        = Spawn as Demolition man\nHwguy          = Spawn as Heavy Weapons Guy\nEnergyguy      = Spawn as Energy Trooper\nEngineer       = Spawn as Engineer\nCommando       = Spawn as Commando\nBerserk        = Spawn as Berserk\n"
	.align 2
.LC38:
	.string	"You are now Scout, your commands are:\n\nBoots = Toggle on/off antigrav boots\n\nGtype = Toggle between grenades\n\n Scanner = Toggle Scanner On/Off\n"
	.align 2
.LC39:
	.string	"You are now Assasin, your commands are:\n\nLaserSight = Toggle on/off LaserSight\n"
	.align 2
.LC40:
	.string	"You are now Soldier, your commands are:\n\nAirStrike = Call Airstrike\n\nGtype = Toggle Between grenade types"
	.align 2
.LC41:
	.string	"You are now Demoman, your commands are:\n\nGtype = Toggle between grenade types\n\nAirStrike = Call Airstrike\nDetpipe = Detonate PipeBombs\n"
	.align 2
.LC42:
	.string	"You are now Hwguy, your commands are:\n\nAirStrike = Call Airstrike\n"
	.align 2
.LC43:
	.string	"You are now EnergyTrooper, your commands are:\n\nPush = Push player\n\n Pull = Pull player\n"
	.align 2
.LC44:
	.string	"You are now Engineer, your commands are:\n\nLaser = Create Laser Trap\n\nDog = Create parasite"
	.align 2
.LC45:
	.string	"You are now Commando, your commands are:\n\nHook2 = Use Grappling hook\n"
	.align 2
.LC46:
	.string	"You are now Berserk, your commands are:\n\nSword = Activate Sword\n\nKamikaze = Blow Yourself to pieces\n\nCloak = Become invisible\n"
	.align 2
.LC47:
	.string	"You are now Spy, your commands are:\n\nSword = Activate Sword\n\nDisguise = Go to undercover\n\n Scanner = Toggle Scanner On/Off\n\n Gtype = Toggle between gas & normal grenades\n"
	.section	".text"
	.align 2
	.globl Cmd_Info_f
	.type	 Cmd_Info_f,@function
Cmd_Info_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,2,.L134
	lis 9,gi+12@ha
	lis 4,.LC37@ha
	lwz 0,gi+12@l(9)
	la 4,.LC37@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L134:
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,1
	bc 4,2,.L135
	lis 9,gi+12@ha
	lis 4,.LC38@ha
	lwz 0,gi+12@l(9)
	la 4,.LC38@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
.L135:
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,2
	bc 4,2,.L136
	lis 9,gi+12@ha
	lis 4,.LC39@ha
	lwz 0,gi+12@l(9)
	la 4,.LC39@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
.L136:
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,3
	bc 4,2,.L137
	lis 9,gi+12@ha
	lis 4,.LC40@ha
	lwz 0,gi+12@l(9)
	la 4,.LC40@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
.L137:
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,4
	bc 4,2,.L138
	lis 9,gi+12@ha
	lis 4,.LC41@ha
	lwz 0,gi+12@l(9)
	la 4,.LC41@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
.L138:
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,5
	bc 4,2,.L139
	lis 9,gi+12@ha
	lis 4,.LC42@ha
	lwz 0,gi+12@l(9)
	la 4,.LC42@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
.L139:
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,6
	bc 4,2,.L140
	lis 9,gi+12@ha
	lis 4,.LC43@ha
	lwz 0,gi+12@l(9)
	la 4,.LC43@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
.L140:
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,7
	bc 4,2,.L141
	lis 9,gi+12@ha
	lis 4,.LC44@ha
	lwz 0,gi+12@l(9)
	la 4,.LC44@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
.L141:
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,8
	bc 4,2,.L142
	lis 9,gi+12@ha
	lis 4,.LC45@ha
	lwz 0,gi+12@l(9)
	la 4,.LC45@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
.L142:
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,9
	bc 4,2,.L143
	lis 9,gi+12@ha
	lis 4,.LC46@ha
	lwz 0,gi+12@l(9)
	la 4,.LC46@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
.L143:
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,10
	bc 4,2,.L144
	lis 9,gi+12@ha
	lis 4,.LC47@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC47@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L144:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 Cmd_Info_f,.Lfe3-Cmd_Info_f
	.section	".rodata"
	.align 2
.LC48:
	.string	"No item to use.\n"
	.align 2
.LC49:
	.string	"Next time you will respawn as scout\n"
	.align 2
.LC50:
	.string	"Next time you will respawn as assasin\n"
	.align 2
.LC51:
	.string	"Next time you will respawn as soldier\n"
	.align 2
.LC52:
	.string	"Next time you will respawn as demolition man\n"
	.align 2
.LC53:
	.string	"Next time you will respawn as heavy weapons guy\n"
	.align 2
.LC54:
	.string	"Next time you will respawn as Energy Warrior\n"
	.align 2
.LC55:
	.string	"Next time you will respawn as engineer\n"
	.align 2
.LC56:
	.string	"Next time you will respawn as commando\n"
	.align 2
.LC57:
	.string	"Next time you will respawn as berserk\n"
	.align 2
.LC58:
	.string	"Next time you will respawn as spy\n"
	.section	".text"
	.align 2
	.globl Cmd_InvUse_f
	.type	 Cmd_InvUse_f,@function
Cmd_InvUse_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 8,84(31)
	lwz 0,1868(8)
	cmpwi 0,0,0
	bc 4,2,.L146
	lwz 11,744(8)
	addi 10,8,748
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L148
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L182:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L153
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L153
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L181
.L153:
	addi 7,7,1
	bdnz .L182
	li 0,-1
	stw 0,744(8)
.L148:
	lwz 9,84(31)
	lwz 0,744(9)
	cmpwi 0,0,-1
	bc 4,2,.L158
	lis 9,gi+8@ha
	lis 5,.LC48@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC48@l(5)
	b .L183
.L181:
	stw 11,744(8)
	b .L148
.L158:
	mulli 0,0,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L159
	lis 9,gi+8@ha
	lis 5,.LC34@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC34@l(5)
.L183:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L145
.L159:
	mr 3,31
	mtlr 0
	blrl
	b .L145
.L146:
	lwz 0,1816(8)
	cmpwi 0,0,1
	bc 4,2,.L161
	stw 0,1820(8)
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,2,.L162
	mr 3,31
	crxor 6,6,6
	bl Cmd_Spawn_f
.L162:
	lis 9,gi+8@ha
	lis 5,.LC49@ha
	lwz 0,gi+8@l(9)
	la 5,.LC49@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L161:
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,2
	bc 4,2,.L163
	stw 0,1820(9)
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,2,.L164
	mr 3,31
	crxor 6,6,6
	bl Cmd_Spawn_f
.L164:
	lis 9,gi+8@ha
	lis 5,.LC50@ha
	lwz 0,gi+8@l(9)
	la 5,.LC50@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L163:
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,3
	bc 4,2,.L165
	stw 0,1820(9)
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,2,.L166
	mr 3,31
	crxor 6,6,6
	bl Cmd_Spawn_f
.L166:
	lis 9,gi+8@ha
	lis 5,.LC51@ha
	lwz 0,gi+8@l(9)
	la 5,.LC51@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L165:
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,4
	bc 4,2,.L167
	stw 0,1820(9)
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,2,.L168
	mr 3,31
	crxor 6,6,6
	bl Cmd_Spawn_f
.L168:
	lis 9,gi+8@ha
	lis 5,.LC52@ha
	lwz 0,gi+8@l(9)
	la 5,.LC52@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L167:
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,5
	bc 4,2,.L169
	stw 0,1820(9)
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,2,.L170
	mr 3,31
	crxor 6,6,6
	bl Cmd_Spawn_f
.L170:
	lis 9,gi+8@ha
	lis 5,.LC53@ha
	lwz 0,gi+8@l(9)
	la 5,.LC53@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L169:
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,6
	bc 4,2,.L171
	stw 0,1820(9)
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,2,.L172
	mr 3,31
	crxor 6,6,6
	bl Cmd_Spawn_f
.L172:
	lis 9,gi+8@ha
	lis 5,.LC54@ha
	lwz 0,gi+8@l(9)
	la 5,.LC54@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L171:
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,7
	bc 4,2,.L173
	stw 0,1820(9)
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,2,.L174
	mr 3,31
	crxor 6,6,6
	bl Cmd_Spawn_f
.L174:
	lis 9,gi+8@ha
	lis 5,.LC55@ha
	lwz 0,gi+8@l(9)
	la 5,.LC55@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L173:
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,8
	bc 4,2,.L175
	stw 0,1820(9)
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,2,.L176
	mr 3,31
	crxor 6,6,6
	bl Cmd_Spawn_f
.L176:
	lis 9,gi+8@ha
	lis 5,.LC56@ha
	lwz 0,gi+8@l(9)
	la 5,.LC56@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L175:
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,9
	bc 4,2,.L177
	stw 0,1820(9)
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,2,.L178
	mr 3,31
	crxor 6,6,6
	bl Cmd_Spawn_f
.L178:
	lis 9,gi+8@ha
	lis 5,.LC57@ha
	lwz 0,gi+8@l(9)
	la 5,.LC57@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L177:
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,10
	bc 4,2,.L145
	stw 0,1820(9)
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,2,.L180
	mr 3,31
	crxor 6,6,6
	bl Cmd_Spawn_f
.L180:
	lis 9,gi+8@ha
	lis 5,.LC58@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC58@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L145:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 Cmd_InvUse_f,.Lfe4-Cmd_InvUse_f
	.section	".rodata"
	.align 2
.LC59:
	.string	"No item to drop.\n"
	.section	".text"
	.align 2
	.globl Cmd_InvDrop_f
	.type	 Cmd_InvDrop_f,@function
Cmd_InvDrop_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 7,84(3)
	lwz 11,744(7)
	addi 10,7,748
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L214
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L227:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L219
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L219
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L226
.L219:
	addi 8,8,1
	bdnz .L227
	li 0,-1
	stw 0,744(7)
.L214:
	lwz 9,84(3)
	lwz 0,744(9)
	cmpwi 0,0,-1
	bc 4,2,.L224
	lis 9,gi+8@ha
	lis 5,.LC59@ha
	lwz 0,gi+8@l(9)
	la 5,.LC59@l(5)
	b .L228
.L226:
	stw 11,744(7)
	b .L214
.L224:
	mulli 0,0,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L225
	lis 9,gi+8@ha
	lis 5,.LC36@ha
	lwz 0,gi+8@l(9)
	la 5,.LC36@l(5)
.L228:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L212
.L225:
	mtlr 0
	blrl
.L212:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_InvDrop_f,.Lfe5-Cmd_InvDrop_f
	.section	".rodata"
	.align 2
.LC60:
	.string	"You must first select your team, type:team 1 or team 2\n"
	.align 2
.LC61:
	.string	"Red Flag"
	.align 2
.LC62:
	.string	"Blue Flag"
	.align 2
.LC63:
	.string	"scout"
	.align 2
.LC64:
	.string	"You are now disguised as Scout\n"
	.align 2
.LC65:
	.string	"assasin"
	.align 2
.LC66:
	.string	"You are now disguised as Assasin\n"
	.align 2
.LC67:
	.string	"soldier"
	.align 2
.LC68:
	.string	"You are now disguised as Soldier\n"
	.align 2
.LC69:
	.string	"demoman"
	.align 2
.LC70:
	.string	"You are now disguised as Demoman\n"
	.align 2
.LC71:
	.string	"hwguy"
	.align 2
.LC72:
	.string	"You are now disguised as Hwguy\n"
	.align 2
.LC73:
	.string	"energyguy"
	.align 2
.LC74:
	.string	"You are now disguised as Energy Trooper\n"
	.align 2
.LC75:
	.string	"engineer"
	.align 2
.LC76:
	.string	"You are now disguised as Engineer\n"
	.align 2
.LC77:
	.string	"commando"
	.align 2
.LC78:
	.string	"You are now disguised as Commando\n"
	.align 2
.LC79:
	.string	"berserk"
	.align 2
.LC80:
	.string	"You are now disguised as Berserk\n"
	.align 2
.LC81:
	.string	"spy"
	.align 2
.LC82:
	.string	"You are now disguised as Spy\n"
	.align 2
.LC83:
	.string	"red"
	.align 2
.LC84:
	.string	"You are now disguised as red team\n"
	.align 2
.LC85:
	.string	"blue"
	.align 2
.LC86:
	.string	"You are now disguised as blue team\n"
	.align 2
.LC87:
	.string	"You have to give parameters, for exam: disguise red, disguise assasin\n"
	.align 2
.LC88:
	.string	"You can't disguise while glowing\n"
	.section	".text"
	.align 2
	.globl Cmd_Disguise_f
	.type	 Cmd_Disguise_f,@function
Cmd_Disguise_f:
	stwu 1,-544(1)
	mflr 0
	stmw 28,528(1)
	stw 0,548(1)
	lis 9,gi@ha
	mr 31,3
	la 30,gi@l(9)
	lwz 9,164(30)
	mtlr 9
	blrl
	lwz 0,908(31)
	mr 29,3
	cmpwi 0,0,1
	bc 4,2,.L243
	lis 9,.LC61@ha
	la 28,.LC61@l(9)
.L243:
	cmpwi 0,0,2
	bc 4,2,.L244
	lis 9,.LC62@ha
	la 28,.LC62@l(9)
.L244:
	mr 3,28
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 11,11,748
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,11,3
	cmpwi 0,0,0
	bc 4,2,.L245
	lis 4,.LC63@ha
	mr 3,29
	la 4,.LC63@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L246
	li 0,1
	lis 5,.LC64@ha
	stw 0,952(31)
	la 5,.LC64@l(5)
	mr 3,31
	lwz 0,8(30)
	b .L271
.L246:
	lis 4,.LC65@ha
	mr 3,29
	la 4,.LC65@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L248
	li 0,2
	lis 5,.LC66@ha
	stw 0,952(31)
	la 5,.LC66@l(5)
	mr 3,31
	lwz 0,8(30)
	b .L271
.L248:
	lis 4,.LC67@ha
	mr 3,29
	la 4,.LC67@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L250
	li 0,3
	lis 5,.LC68@ha
	stw 0,952(31)
	la 5,.LC68@l(5)
	mr 3,31
	lwz 0,8(30)
	b .L271
.L250:
	lis 4,.LC69@ha
	mr 3,29
	la 4,.LC69@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L252
	li 0,4
	lis 5,.LC70@ha
	stw 0,952(31)
	la 5,.LC70@l(5)
	mr 3,31
	lwz 0,8(30)
	b .L271
.L252:
	lis 4,.LC71@ha
	mr 3,29
	la 4,.LC71@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L254
	li 0,5
	lis 5,.LC72@ha
	stw 0,952(31)
	la 5,.LC72@l(5)
	mr 3,31
	lwz 0,8(30)
	b .L271
.L254:
	lis 4,.LC73@ha
	mr 3,29
	la 4,.LC73@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L256
	li 0,6
	lis 5,.LC74@ha
	stw 0,952(31)
	la 5,.LC74@l(5)
	mr 3,31
	lwz 0,8(30)
	b .L271
.L256:
	lis 4,.LC75@ha
	mr 3,29
	la 4,.LC75@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L258
	li 0,7
	lis 5,.LC76@ha
	stw 0,952(31)
	la 5,.LC76@l(5)
	mr 3,31
	lwz 0,8(30)
	b .L271
.L258:
	lis 4,.LC77@ha
	mr 3,29
	la 4,.LC77@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L260
	li 0,8
	lis 9,gi+8@ha
	stw 0,952(31)
	lis 5,.LC78@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	la 5,.LC78@l(5)
	b .L271
.L260:
	lis 4,.LC79@ha
	mr 3,29
	la 4,.LC79@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L262
	li 0,9
	lis 9,gi+8@ha
	stw 0,952(31)
	lis 5,.LC80@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	la 5,.LC80@l(5)
	b .L271
.L262:
	lis 4,.LC81@ha
	mr 3,29
	la 4,.LC81@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L264
	li 0,10
	lis 9,gi+8@ha
	stw 0,952(31)
	lis 5,.LC82@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	la 5,.LC82@l(5)
	b .L271
.L264:
	lis 4,.LC83@ha
	mr 3,29
	la 4,.LC83@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L266
	li 0,2
	lis 9,gi+8@ha
	stw 0,948(31)
	lis 5,.LC84@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	la 5,.LC84@l(5)
	b .L271
.L266:
	lis 4,.LC85@ha
	mr 3,29
	la 4,.LC85@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L268
	li 0,1
	lis 9,gi+8@ha
	stw 0,948(31)
	lis 5,.LC86@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	la 5,.LC86@l(5)
.L271:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L247
.L268:
	lis 9,gi+8@ha
	lis 5,.LC87@ha
	lwz 0,gi+8@l(9)
	la 5,.LC87@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L247:
	lwz 4,84(31)
	addi 29,1,8
	li 5,512
	mr 3,29
	addi 4,4,188
	crxor 6,6,6
	bl memcpy
	mr 3,31
	mr 4,29
	crxor 6,6,6
	bl ClientUserinfoChanged
	b .L270
.L245:
	lwz 0,8(30)
	lis 5,.LC88@ha
	mr 3,31
	la 5,.LC88@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L270:
	lwz 0,548(1)
	mtlr 0
	lmw 28,528(1)
	la 1,544(1)
	blr
.Lfe6:
	.size	 Cmd_Disguise_f,.Lfe6-Cmd_Disguise_f
	.section	".rodata"
	.align 2
.LC89:
	.string	"%3i %s\n"
	.align 2
.LC90:
	.string	"...\n"
	.align 2
.LC91:
	.string	"%s\n%i players\n"
	.align 2
.LC92:
	.long 0x0
	.align 3
.LC93:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_Players_f
	.type	 Cmd_Players_f,@function
Cmd_Players_f:
	stwu 1,-2432(1)
	mflr 0
	stmw 23,2396(1)
	stw 0,2436(1)
	lis 11,.LC92@ha
	lis 9,maxclients@ha
	la 11,.LC92@l(11)
	mr 23,3
	lfs 13,0(11)
	li 27,0
	li 31,0
	lwz 11,maxclients@l(9)
	addi 29,1,1352
	addi 30,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L274
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC93@ha
	la 9,.LC93@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L276:
	lwz 0,0(11)
	addi 11,11,3960
	cmpwi 0,0,0
	bc 12,2,.L275
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L275:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L276
.L274:
	lis 6,PlayerSort@ha
	mr 3,29
	la 6,PlayerSort@l(6)
	mr 4,27
	li 5,4
	li 31,0
	bl qsort
	cmpw 0,31,27
	li 0,0
	stb 0,72(1)
	bc 4,0,.L280
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC89@ha
	lis 25,.LC90@ha
.L282:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC89@l(26)
	addi 28,28,4
	mulli 7,7,3960
	add 7,7,0
	lha 6,148(7)
	addi 7,7,700
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,30
	bl strlen
	add 29,29,3
	cmplwi 0,29,1180
	bc 4,1,.L283
	la 4,.LC90@l(25)
	mr 3,30
	bl strcat
	b .L280
.L283:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L282
.L280:
	lis 9,gi+8@ha
	lis 5,.LC91@ha
	lwz 0,gi+8@l(9)
	mr 3,23
	la 5,.LC91@l(5)
	mr 6,30
	mr 7,27
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,2436(1)
	mtlr 0
	lmw 23,2396(1)
	la 1,2432(1)
	blr
.Lfe7:
	.size	 Cmd_Players_f,.Lfe7-Cmd_Players_f
	.section	".rodata"
	.align 2
.LC94:
	.string	"flipoff\n"
	.align 2
.LC95:
	.string	"salute\n"
	.align 2
.LC96:
	.string	"taunt\n"
	.align 2
.LC97:
	.string	"wave\n"
	.align 2
.LC98:
	.string	"point\n"
	.section	".text"
	.align 2
	.globl Cmd_Wave_f
	.type	 Cmd_Wave_f,@function
Cmd_Wave_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,gi+160@ha
	mr 31,3
	lwz 0,gi+160@l(9)
	li 3,1
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 11,0,1
	bc 4,2,.L285
	lwz 0,3864(9)
	cmpwi 0,0,1
	bc 12,1,.L285
	cmplwi 0,3,4
	li 0,1
	stw 0,3864(9)
	bc 12,1,.L294
	lis 11,.L295@ha
	slwi 10,3,2
	la 11,.L295@l(11)
	lis 9,.L295@ha
	lwzx 0,10,11
	la 9,.L295@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L295:
	.long .L289-.L295
	.long .L290-.L295
	.long .L291-.L295
	.long .L292-.L295
	.long .L294-.L295
.L289:
	lis 9,gi+8@ha
	lis 5,.LC94@ha
	lwz 0,gi+8@l(9)
	la 5,.LC94@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,71
	li 9,83
	b .L296
.L290:
	lis 9,gi+8@ha
	lis 5,.LC95@ha
	lwz 0,gi+8@l(9)
	la 5,.LC95@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,83
	li 9,94
	b .L296
.L291:
	lis 9,gi+8@ha
	lis 5,.LC96@ha
	lwz 0,gi+8@l(9)
	la 5,.LC96@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,94
	li 9,111
	b .L296
.L292:
	lis 9,gi+8@ha
	lis 5,.LC97@ha
	lwz 0,gi+8@l(9)
	la 5,.LC97@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,111
	li 9,122
	b .L296
.L294:
	lis 9,gi+8@ha
	lis 5,.LC98@ha
	lwz 0,gi+8@l(9)
	la 5,.LC98@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,122
	li 9,134
.L296:
	stw 0,56(31)
	stw 9,3860(11)
.L285:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 Cmd_Wave_f,.Lfe8-Cmd_Wave_f
	.section	".rodata"
	.align 2
.LC99:
	.string	"speech/watchit1.wav"
	.align 2
.LC100:
	.string	"speech/spy1.wav"
	.align 2
.LC101:
	.string	"speech/diedie.wav"
	.align 2
.LC102:
	.string	"speech/pathetic.wav"
	.align 2
.LC103:
	.string	"speech/problem.wav"
	.align 2
.LC104:
	.string	"Parameters:1 'Watchit!' 2 'there is a spy'\n3-5 insults\n"
	.align 2
.LC105:
	.long 0x3f800000
	.align 2
.LC106:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Yell_f
	.type	 Cmd_Yell_f,@function
Cmd_Yell_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi@ha
	mr 30,3
	la 31,gi@l(9)
	li 3,1
	lwz 9,160(31)
	mtlr 9
	blrl
	bl atoi
	cmpwi 0,3,1
	bc 4,2,.L298
	lwz 9,36(31)
	lis 3,.LC99@ha
	la 3,.LC99@l(3)
	b .L308
.L298:
	cmpwi 0,3,2
	bc 4,2,.L300
	lwz 9,36(31)
	lis 3,.LC100@ha
	la 3,.LC100@l(3)
	b .L308
.L300:
	cmpwi 0,3,3
	bc 4,2,.L302
	lwz 9,36(31)
	lis 3,.LC101@ha
	la 3,.LC101@l(3)
	b .L308
.L302:
	cmpwi 0,3,4
	bc 4,2,.L304
	lwz 9,36(31)
	lis 3,.LC102@ha
	la 3,.LC102@l(3)
	b .L308
.L304:
	cmpwi 0,3,5
	bc 4,2,.L306
	lwz 9,36(31)
	lis 3,.LC103@ha
	la 3,.LC103@l(3)
.L308:
	mtlr 9
	blrl
	lis 9,.LC105@ha
	lwz 0,16(31)
	mr 5,3
	la 9,.LC105@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC105@ha
	la 9,.LC105@l(9)
	lfs 2,0(9)
	lis 9,.LC106@ha
	la 9,.LC106@l(9)
	lfs 3,0(9)
	blrl
	b .L299
.L306:
	lwz 0,8(31)
	lis 5,.LC104@ha
	mr 3,30
	la 5,.LC104@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L299:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 Cmd_Yell_f,.Lfe9-Cmd_Yell_f
	.section	".rodata"
	.align 2
.LC107:
	.string	"(%s): "
	.align 2
.LC108:
	.string	"%s: "
	.align 2
.LC109:
	.string	" "
	.align 2
.LC110:
	.string	"\n"
	.align 2
.LC111:
	.string	"%s"
	.align 2
.LC112:
	.string	"You flooded too much, wait for while.\n"
	.align 2
.LC113:
	.long 0x0
	.align 3
.LC114:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC115:
	.long 0x40000000
	.align 2
.LC116:
	.long 0x41700000
	.align 2
.LC117:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl Cmd_Say_f
	.type	 Cmd_Say_f,@function
Cmd_Say_f:
	stwu 1,-2144(1)
	mflr 0
	mfcr 12
	stfd 28,2112(1)
	stfd 29,2120(1)
	stfd 30,2128(1)
	stfd 31,2136(1)
	stmw 23,2076(1)
	stw 0,2148(1)
	stw 12,2072(1)
	lis 9,gi+156@ha
	mr 31,3
	lwz 0,gi+156@l(9)
	mr 29,4
	mr 30,5
	lis 23,gi@ha
	mtlr 0
	blrl
	cmpwi 0,3,1
	bc 12,1,.L310
	cmpwi 0,30,0
	bc 12,2,.L309
.L310:
	cmpwi 4,29,0
	bc 12,18,.L311
	lwz 6,84(31)
	lis 5,.LC107@ha
	addi 3,1,8
	la 5,.LC107@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L312
.L311:
	lwz 6,84(31)
	lis 5,.LC108@ha
	addi 3,1,8
	la 5,.LC108@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L312:
	cmpwi 0,30,0
	bc 12,2,.L313
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC109@ha
	addi 3,1,8
	la 4,.LC109@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L314
.L336:
	lis 9,gi+8@ha
	lis 5,.LC112@ha
	lwz 0,gi+8@l(9)
	la 5,.LC112@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,1
	stw 0,900(31)
	b .L309
.L337:
	lis 9,gi+8@ha
	lis 5,.LC112@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC112@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L309
.L313:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L315
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 30,-1(3)
.L315:
	mr 4,29
	addi 3,1,8
	bl strcat
.L314:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L316
	li 0,0
	stb 0,158(1)
.L316:
	lis 4,.LC110@ha
	addi 3,1,8
	la 4,.LC110@l(4)
	bl strcat
	lis 9,.LC113@ha
	lis 11,dedicated@ha
	la 9,.LC113@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L317
	lis 9,gi+8@ha
	lis 5,.LC111@ha
	lwz 0,gi+8@l(9)
	la 5,.LC111@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L317:
	lis 9,game+1544@ha
	li 30,1
	lwz 0,game+1544@l(9)
	lis 24,game@ha
	cmpw 0,30,0
	bc 12,1,.L309
	lis 9,level@ha
	lis 25,g_edicts@ha
	la 27,level@l(9)
	lis 28,0x4330
	lis 9,.LC114@ha
	li 29,1268
	la 9,.LC114@l(9)
	li 26,0
	lfd 31,0(9)
	lis 9,.LC115@ha
	la 9,.LC115@l(9)
	lfs 28,0(9)
	lis 9,.LC116@ha
	la 9,.LC116@l(9)
	lfs 29,0(9)
	lis 9,.LC117@ha
	la 9,.LC117@l(9)
	lfs 30,0(9)
.L321:
	lwz 0,g_edicts@l(25)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L320
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L320
	bc 12,18,.L324
	lwz 9,908(31)
	lwz 0,908(3)
	cmpw 0,9,0
	bc 4,2,.L320
.L324:
	lwz 11,896(31)
	lfs 13,4(27)
	xoris 0,11,0x8000
	stw 0,2068(1)
	stw 28,2064(1)
	lfd 0,2064(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 4,0,.L329
	fadds 0,13,28
	fctiwz 13,0
	stfd 13,2064(1)
	lwz 9,2068(1)
	stw 9,896(31)
	b .L330
.L329:
	addi 0,11,2
	stw 0,896(31)
.L330:
	lwz 0,896(31)
	lfs 11,4(27)
	xoris 0,0,0x8000
	stw 0,2068(1)
	stw 28,2064(1)
	fadds 13,11,29
	lfd 0,2064(1)
	fsub 0,0,31
	frsp 12,0
	fcmpu 0,12,13
	bc 12,1,.L336
	lwz 0,900(31)
	cmpwi 0,0,1
	bc 4,2,.L332
	fadds 0,11,30
	fcmpu 0,12,0
	bc 12,1,.L337
	stw 26,900(31)
.L332:
	la 9,gi@l(23)
	lis 5,.LC111@ha
	lwz 0,8(9)
	la 5,.LC111@l(5)
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L320:
	la 9,game@l(24)
	addi 30,30,1
	lwz 0,1544(9)
	addi 29,29,1268
	cmpw 0,30,0
	bc 4,1,.L321
.L309:
	lwz 0,2148(1)
	lwz 12,2072(1)
	mtlr 0
	lmw 23,2076(1)
	lfd 28,2112(1)
	lfd 29,2120(1)
	lfd 30,2128(1)
	lfd 31,2136(1)
	mtcrf 8,12
	la 1,2144(1)
	blr
.Lfe10:
	.size	 Cmd_Say_f,.Lfe10-Cmd_Say_f
	.section	".rodata"
	.align 2
.LC118:
	.string	"Cells"
	.align 2
.LC119:
	.string	"You do not have enough cells, you need %i cells for it\n"
	.align 2
.LC120:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Say_Team_f
	.type	 Cmd_Say_Team_f,@function
Cmd_Say_Team_f:
	stwu 1,-2096(1)
	mflr 0
	stmw 25,2068(1)
	stw 0,2100(1)
	lis 9,gi@ha
	mr 29,3
	la 31,gi@l(9)
	mr 30,5
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,1
	bc 12,1,.L344
	cmpwi 0,30,0
	bc 12,2,.L343
.L344:
	lwz 6,84(29)
	lis 5,.LC107@ha
	addi 3,1,8
	la 5,.LC107@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	cmpwi 0,30,0
	bc 12,2,.L345
	lwz 9,160(31)
	li 3,0
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC109@ha
	addi 3,1,8
	la 4,.LC109@l(4)
	bl strcat
	lwz 0,164(31)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L346
.L345:
	lwz 0,164(31)
	mtlr 0
	blrl
	mr 31,3
	lbz 0,0(31)
	cmpwi 0,0,34
	bc 4,2,.L347
	addi 31,31,1
	mr 3,31
	bl strlen
	add 3,3,31
	stb 30,-1(3)
.L347:
	mr 4,31
	addi 3,1,8
	bl strcat
.L346:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L348
	li 0,0
	stb 0,158(1)
.L348:
	lis 4,.LC110@ha
	addi 3,1,8
	la 4,.LC110@l(4)
	bl strcat
	lis 9,.LC120@ha
	lis 11,dedicated@ha
	la 9,.LC120@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L349
	lis 9,gi+8@ha
	lis 5,.LC111@ha
	lwz 0,gi+8@l(9)
	la 5,.LC111@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L349:
	lis 9,game@ha
	li 31,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,31,0
	bc 12,1,.L343
	lis 9,gi@ha
	mr 25,11
	la 26,gi@l(9)
	lis 27,g_edicts@ha
	lis 28,.LC111@ha
	li 30,1268
.L353:
	lwz 0,g_edicts@l(27)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L352
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L352
	lwz 9,908(29)
	lwz 0,908(3)
	cmpw 0,9,0
	bc 4,2,.L352
	lwz 9,8(26)
	li 4,3
	la 5,.LC111@l(28)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L352:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,1268
	cmpw 0,31,0
	bc 4,1,.L353
.L343:
	lwz 0,2100(1)
	mtlr 0
	lmw 25,2068(1)
	la 1,2096(1)
	blr
.Lfe11:
	.size	 Cmd_Say_Team_f,.Lfe11-Cmd_Say_Team_f
	.section	".rodata"
	.align 2
.LC121:
	.string	"     NAME              RANGE          TEAM\n\n"
	.align 2
.LC122:
	.string	"%16s          %i                %i\n"
	.align 3
.LC123:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC124:
	.long 0x46000000
	.align 2
.LC125:
	.long 0x44000000
	.section	".text"
	.align 2
	.globl Cmd_id_f
	.type	 Cmd_id_f,@function
Cmd_id_f:
	stwu 1,-672(1)
	mflr 0
	stmw 27,652(1)
	stw 0,676(1)
	mr 31,3
	lis 4,.LC121@ha
	addi 3,1,8
	la 4,.LC121@l(4)
	crxor 6,6,6
	bl sprintf
	lwz 0,784(31)
	lis 11,0x4330
	lis 10,.LC123@ha
	lfs 13,12(31)
	mr 30,3
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	lfs 10,4(31)
	stw 0,644(1)
	addi 28,1,536
	addi 27,1,520
	stw 11,640(1)
	addi 29,1,552
	li 6,0
	lfd 0,640(1)
	mr 4,28
	li 5,0
	lfd 11,0(10)
	lfs 12,8(31)
	lwz 3,84(31)
	fsub 0,0,11
	stfs 10,520(1)
	stfs 12,524(1)
	addi 3,3,3752
	frsp 0,0
	fadds 13,13,0
	stfs 13,528(1)
	bl AngleVectors
	lis 9,.LC124@ha
	mr 4,28
	la 9,.LC124@l(9)
	mr 3,27
	lfs 1,0(9)
	mr 5,29
	bl VectorMA
	lis 11,gi@ha
	lis 9,0x600
	la 28,gi@l(11)
	li 5,0
	lwz 11,48(28)
	ori 9,9,27
	mr 4,27
	mr 7,29
	addi 3,1,568
	li 6,0
	mr 8,31
	mtlr 11
	blrl
	lwz 9,620(1)
	lwz 5,84(9)
	cmpwi 0,5,0
	bc 12,2,.L359
	lis 9,.LC125@ha
	lfs 0,576(1)
	la 9,.LC125@l(9)
	addi 29,1,8
	lfs 12,0(9)
	lis 4,.LC122@ha
	addi 5,5,700
	la 4,.LC122@l(4)
	add 3,29,30
	fmuls 0,0,12
	fctiwz 13,0
	stfd 13,640(1)
	lwz 6,644(1)
	crxor 6,6,6
	bl sprintf
	lwz 0,12(28)
	lis 4,.LC111@ha
	mr 3,31
	la 4,.LC111@l(4)
	mr 5,29
	mtlr 0
	crxor 6,6,6
	blrl
.L359:
	lwz 0,676(1)
	mtlr 0
	lmw 27,652(1)
	la 1,672(1)
	blr
.Lfe12:
	.size	 Cmd_id_f,.Lfe12-Cmd_id_f
	.section	".rodata"
	.align 2
.LC126:
	.long 0x459c4000
	.align 3
.LC127:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC128:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl Cmd_Push_f
	.type	 Cmd_Push_f,@function
Cmd_Push_f:
	stwu 1,-144(1)
	mflr 0
	stmw 28,128(1)
	stw 0,148(1)
	mr 29,3
	lwz 0,784(29)
	lis 11,0x4330
	lis 10,.LC127@ha
	la 10,.LC127@l(10)
	lfs 13,12(29)
	addi 31,1,24
	xoris 0,0,0x8000
	lfd 11,0(10)
	addi 28,1,40
	stw 0,124(1)
	li 6,0
	mr 4,31
	stw 11,120(1)
	li 5,0
	lfd 0,120(1)
	lfs 10,4(29)
	lfs 12,8(29)
	fsub 0,0,11
	lwz 3,84(29)
	stfs 10,8(1)
	stfs 12,12(1)
	addi 3,3,3752
	frsp 0,0
	fadds 13,13,0
	stfs 13,16(1)
	bl AngleVectors
	lis 9,.LC128@ha
	addi 3,1,8
	la 9,.LC128@l(9)
	mr 4,31
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mr 7,28
	mr 8,29
	addi 3,1,56
	addi 4,1,8
	li 5,0
	mtlr 0
	li 6,0
	blrl
	lwz 9,108(1)
	cmpwi 0,9,0
	bc 12,2,.L361
	lwz 0,184(9)
	andi. 10,0,4
	bc 4,2,.L362
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L361
.L362:
	lis 9,.LC126@ha
	mr 3,31
	lfs 1,.LC126@l(9)
	mr 4,3
	bl VectorScale
	lwz 9,108(1)
	lfs 0,24(1)
	lfs 13,620(9)
	fadds 0,0,13
	stfs 0,620(9)
	lwz 11,108(1)
	lfs 0,28(1)
	lfs 13,624(11)
	fadds 0,0,13
	stfs 0,624(11)
	lwz 9,108(1)
	lfs 0,32(1)
	lfs 13,628(9)
	fadds 0,0,13
	stfs 0,628(9)
.L361:
	lwz 0,148(1)
	mtlr 0
	lmw 28,128(1)
	la 1,144(1)
	blr
.Lfe13:
	.size	 Cmd_Push_f,.Lfe13-Cmd_Push_f
	.section	".rodata"
	.align 2
.LC129:
	.string	"You are now visible!\n"
	.align 2
.LC130:
	.string	"You are now cloaked!\n"
	.align 2
.LC131:
	.long 0xc59c4000
	.align 3
.LC132:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC133:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl Cmd_Pull_f
	.type	 Cmd_Pull_f,@function
Cmd_Pull_f:
	stwu 1,-144(1)
	mflr 0
	stmw 28,128(1)
	stw 0,148(1)
	mr 29,3
	lwz 0,784(29)
	lis 11,0x4330
	lis 10,.LC132@ha
	la 10,.LC132@l(10)
	lfs 13,12(29)
	addi 31,1,24
	xoris 0,0,0x8000
	lfd 11,0(10)
	addi 28,1,40
	stw 0,124(1)
	li 6,0
	mr 4,31
	stw 11,120(1)
	li 5,0
	lfd 0,120(1)
	lfs 10,4(29)
	lfs 12,8(29)
	fsub 0,0,11
	lwz 3,84(29)
	stfs 10,8(1)
	stfs 12,12(1)
	addi 3,3,3752
	frsp 0,0
	fadds 13,13,0
	stfs 13,16(1)
	bl AngleVectors
	lis 9,.LC133@ha
	addi 3,1,8
	la 9,.LC133@l(9)
	mr 4,31
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mr 7,28
	mr 8,29
	addi 3,1,56
	addi 4,1,8
	li 5,0
	mtlr 0
	li 6,0
	blrl
	lwz 9,108(1)
	cmpwi 0,9,0
	bc 12,2,.L370
	lwz 0,184(9)
	andi. 10,0,4
	bc 4,2,.L371
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L370
.L371:
	lis 9,.LC131@ha
	mr 3,31
	lfs 1,.LC131@l(9)
	mr 4,3
	bl VectorScale
	lwz 9,108(1)
	lfs 0,24(1)
	lfs 13,620(9)
	fadds 0,0,13
	stfs 0,620(9)
	lwz 11,108(1)
	lfs 0,28(1)
	lfs 13,624(11)
	fadds 0,0,13
	stfs 0,624(11)
	lwz 9,108(1)
	lfs 0,32(1)
	lfs 13,628(9)
	fadds 0,0,13
	stfs 0,628(9)
.L370:
	lwz 0,148(1)
	mtlr 0
	lmw 28,128(1)
	la 1,144(1)
	blr
.Lfe14:
	.size	 Cmd_Pull_f,.Lfe14-Cmd_Pull_f
	.section	".rodata"
	.align 2
.LC134:
	.string	"            Name      Health Range Class NO:\n=============================\n"
	.align 2
.LC135:
	.string	"%16s %6d %5.0f %6d\n"
	.section	".text"
	.align 2
	.globl Cmd_CheckStats_f
	.type	 Cmd_CheckStats_f,@function
Cmd_CheckStats_f:
	stwu 1,-576(1)
	mflr 0
	stmw 23,540(1)
	stw 0,580(1)
	mr 29,3
	lis 4,.LC134@ha
	la 4,.LC134@l(4)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	li 28,0
	lis 9,game@ha
	mr 30,3
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,28,0
	bc 12,1,.L374
	mr 23,9
	lis 24,g_edicts@ha
	addi 25,1,8
	lis 26,.LC135@ha
	li 27,1268
.L376:
	lwz 0,g_edicts@l(24)
	lwz 11,908(29)
	add 31,0,27
	lwz 9,908(31)
	cmpw 0,11,9
	bc 4,2,.L375
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L375
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L375
	lfs 0,4(31)
	addi 3,1,520
	lfs 13,4(29)
	lfs 12,8(29)
	lfs 11,12(29)
	fsubs 13,13,0
	stfs 13,520(1)
	lfs 0,8(31)
	fsubs 12,12,0
	stfs 12,524(1)
	lfs 0,12(31)
	fsubs 11,11,0
	stfs 11,528(1)
	bl VectorLength
	lwz 5,84(31)
	add 3,25,30
	la 4,.LC135@l(26)
	lwz 6,728(31)
	lwz 7,1804(5)
	addi 5,5,700
	creqv 6,6,6
	bl sprintf
	add 30,30,3
	cmpwi 0,30,450
	bc 12,1,.L374
.L375:
	lwz 0,1544(23)
	addi 28,28,1
	addi 27,27,1268
	cmpw 0,28,0
	bc 4,1,.L376
.L374:
	lis 9,gi+12@ha
	lis 4,.LC111@ha
	lwz 0,gi+12@l(9)
	mr 3,29
	la 4,.LC111@l(4)
	addi 5,1,8
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,580(1)
	mtlr 0
	lmw 23,540(1)
	la 1,576(1)
	blr
.Lfe15:
	.size	 Cmd_CheckStats_f,.Lfe15-Cmd_CheckStats_f
	.section	".rodata"
	.align 2
.LC136:
	.string	"players"
	.align 2
.LC137:
	.string	"say"
	.align 2
.LC138:
	.string	"say_team"
	.align 2
.LC139:
	.string	"score"
	.align 2
.LC140:
	.string	"help"
	.align 2
.LC141:
	.string	"use"
	.align 2
.LC142:
	.string	"drop"
	.align 2
.LC143:
	.string	"push"
	.align 2
.LC144:
	.string	"pull"
	.align 2
.LC145:
	.string	"give"
	.align 2
.LC146:
	.string	"god"
	.align 2
.LC147:
	.string	"notarget"
	.align 2
.LC148:
	.string	"yell"
	.align 2
.LC149:
	.string	"hook2"
	.align 2
.LC150:
	.string	"noclip"
	.align 2
.LC151:
	.string	"inven"
	.align 2
.LC152:
	.string	"team"
	.align 2
.LC153:
	.string	"Your Team is civilian\n"
	.align 2
.LC154:
	.string	"Your Team is BLUE\n"
	.align 2
.LC155:
	.string	"Your Team is RED\n"
	.align 2
.LC156:
	.string	"You have no team\n"
	.align 2
.LC157:
	.string	"You are now at BLUE team\n"
	.align 2
.LC158:
	.string	"You are now at RED team\n"
	.align 2
.LC159:
	.string	"helpme"
	.align 2
.LC160:
	.string	"invnext"
	.align 2
.LC161:
	.string	"invprev"
	.align 2
.LC162:
	.string	"invnextw"
	.align 2
.LC163:
	.string	"invprevw"
	.align 2
.LC164:
	.string	"invnextp"
	.align 2
.LC165:
	.string	"invprevp"
	.align 2
.LC166:
	.string	"invuse"
	.align 2
.LC167:
	.string	"invdrop"
	.align 2
.LC168:
	.string	"weapprev"
	.align 2
.LC169:
	.string	"weapnext"
	.align 2
.LC170:
	.string	"weaplast"
	.align 2
.LC171:
	.string	"kill"
	.align 2
.LC172:
	.string	"spawnme"
	.align 2
.LC173:
	.string	"putaway"
	.align 2
.LC174:
	.string	"bot"
	.align 2
.LC175:
	.string	"lasersight"
	.align 2
.LC176:
	.string	"airstrike"
	.align 2
.LC177:
	.string	"Commando"
	.align 2
.LC178:
	.string	"Next time you will respawn as Commando\n"
	.align 2
.LC179:
	.string	"wave"
	.align 2
.LC180:
	.string	"turret"
	.align 2
.LC182:
	.string	"cloak"
	.align 2
.LC183:
	.string	"Gtype"
	.align 2
.LC184:
	.string	"Normal Grenades Selected\n"
	.align 2
.LC185:
	.string	"Cluster Grenades Selected\n"
	.align 2
.LC186:
	.string	"MegaCluster Grenades Selected\n"
	.align 2
.LC187:
	.string	"Pipebombs Selected\n"
	.align 2
.LC188:
	.string	"Detpack Selected\n"
	.align 2
.LC189:
	.string	"Laser Grenades Selected\n"
	.align 2
.LC190:
	.string	"Guided Rockets Selected\n"
	.align 2
.LC191:
	.string	"Flares Selected\n"
	.align 2
.LC192:
	.string	"Gas grenades selected\n"
	.align 2
.LC193:
	.string	"Pulse Grenades Selected\n"
	.align 2
.LC194:
	.string	"Concussion Grenades Selected\n"
	.align 2
.LC195:
	.string	"Concussion Mines Selected\n"
	.align 2
.LC196:
	.string	"dog"
	.align 2
.LC197:
	.string	"gameversion"
	.align 2
.LC198:
	.string	"%s : %s\n"
	.align 2
.LC199:
	.string	"baseq2"
	.align 2
.LC200:
	.string	"Jan  1 2002"
	.align 2
.LC201:
	.string	"zoom"
	.align 2
.LC202:
	.string	"laser"
	.align 2
.LC203:
	.string	"atype"
	.align 2
.LC204:
	.string	"Normal Bombing Selected\n"
	.align 2
.LC205:
	.string	"Cluster Bombing Selected\n"
	.align 2
.LC206:
	.string	"Napalm Bombing Selected\n"
	.align 2
.LC207:
	.string	"boots"
	.align 2
.LC208:
	.string	"Anti Gravity Boots off\n"
	.align 2
.LC209:
	.string	"Anti Gravity Boots on\n"
	.align 2
.LC210:
	.string	"scanner"
	.align 2
.LC211:
	.string	"checkstats"
	.align 2
.LC212:
	.string	"id"
	.align 2
.LC213:
	.string	"disguise"
	.align 2
.LC214:
	.string	"classes2"
	.align 2
.LC215:
	.string	"classes"
	.align 2
.LC216:
	.string	"kamikaze"
	.align 3
.LC181:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC217:
	.long 0x0
	.align 2
.LC218:
	.long 0x40a00000
	.align 2
.LC219:
	.long 0x40000000
	.align 2
.LC220:
	.long 0x447a0000
	.align 2
.LC221:
	.long 0x42b40000
	.align 2
.LC222:
	.long 0x42200000
	.align 2
.LC223:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl ClientCommand
	.type	 ClientCommand,@function
ClientCommand:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	mr 30,3
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L381
	lis 9,gi@ha
	li 3,0
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC136@ha
	la 4,.LC136@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L383
	mr 3,30
	bl Cmd_Players_f
	b .L381
.L383:
	lis 4,.LC137@ha
	mr 3,31
	la 4,.LC137@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L384
	mr 3,30
	li 4,0
	li 5,0
	bl Cmd_Say_f
	b .L381
.L384:
	lis 4,.LC138@ha
	mr 3,31
	la 4,.LC138@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L385
	mr 3,30
	li 4,1
	li 5,0
	bl Cmd_Say_Team_f
	b .L381
.L385:
	lis 4,.LC139@ha
	mr 3,31
	la 4,.LC139@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L386
	mr 3,30
	bl Cmd_Score_f
	b .L381
.L386:
	lis 4,.LC140@ha
	mr 3,31
	la 4,.LC140@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L387
	mr 3,30
	bl Cmd_Help_f
	b .L381
.L387:
	lis 10,.LC217@ha
	lis 9,level+200@ha
	la 10,.LC217@l(10)
	lfs 0,level+200@l(9)
	lfs 31,0(10)
	fcmpu 0,0,31
	bc 4,2,.L381
	lis 4,.LC141@ha
	mr 3,31
	la 4,.LC141@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L389
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 31,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L390
	lwz 0,8(29)
	lis 5,.LC33@ha
	mr 3,30
	la 5,.LC33@l(5)
	b .L813
.L390:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L392
	lwz 0,8(29)
	lis 5,.LC34@ha
	mr 3,30
	la 5,.LC34@l(5)
	b .L814
.L392:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,4
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L815
	b .L399
.L389:
	lis 4,.LC142@ha
	mr 3,31
	la 4,.LC142@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L395
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 31,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L396
	lwz 0,8(29)
	lis 5,.LC33@ha
	mr 3,30
	la 5,.LC33@l(5)
	b .L813
.L396:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L398
	lwz 0,8(29)
	lis 5,.LC36@ha
	mr 3,30
	la 5,.LC36@l(5)
	b .L814
.L398:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,4
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L399
.L815:
	lwz 0,8(29)
	lis 5,.LC35@ha
	mr 3,30
	la 5,.LC35@l(5)
.L813:
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L381
.L399:
	mr 3,30
	mtlr 10
	blrl
	b .L381
.L395:
	lis 4,.LC143@ha
	mr 3,31
	la 4,.LC143@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L401
	lwz 9,84(30)
	lwz 0,1804(9)
	cmpwi 0,0,6
	bc 4,2,.L381
	mr 3,30
	bl Cmd_Push_f
	b .L381
.L401:
	lis 4,.LC144@ha
	mr 3,31
	la 4,.LC144@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L404
	lwz 9,84(30)
	lwz 0,1804(9)
	cmpwi 0,0,6
	bc 4,2,.L381
	mr 3,30
	bl Cmd_Pull_f
	b .L381
.L404:
	lis 4,.LC145@ha
	mr 3,31
	la 4,.LC145@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L407
	mr 3,30
	bl Cmd_Give_f
	b .L381
.L407:
	lis 4,.LC146@ha
	mr 3,31
	la 4,.LC146@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L409
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L410
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L410
	lis 9,gi+8@ha
	lis 5,.LC2@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC2@l(5)
	b .L814
.L410:
	lwz 0,268(30)
	xori 0,0,16
	andi. 9,0,16
	stw 0,268(30)
	bc 4,2,.L412
	lis 9,.LC27@ha
	la 5,.LC27@l(9)
	b .L413
.L412:
	lis 9,.LC28@ha
	la 5,.LC28@l(9)
.L413:
	lis 9,gi+8@ha
	mr 3,30
	lwz 0,gi+8@l(9)
	b .L814
.L409:
	lis 4,.LC147@ha
	mr 3,31
	la 4,.LC147@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L415
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L416
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L416
	lis 9,gi+8@ha
	lis 5,.LC2@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC2@l(5)
	b .L814
.L416:
	lwz 0,268(30)
	xori 0,0,32
	andi. 9,0,32
	stw 0,268(30)
	bc 4,2,.L418
	lis 9,.LC29@ha
	la 5,.LC29@l(9)
	b .L419
.L418:
	lis 9,.LC30@ha
	la 5,.LC30@l(9)
.L419:
	lis 9,gi+8@ha
	mr 3,30
	lwz 0,gi+8@l(9)
	b .L814
.L415:
	lis 4,.LC148@ha
	mr 3,31
	la 4,.LC148@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L421
	mr 3,30
	bl Cmd_Yell_f
	b .L381
.L421:
	lis 4,.LC149@ha
	mr 3,31
	la 4,.LC149@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L423
	lwz 9,84(30)
	lwz 0,1804(9)
	cmpwi 0,0,8
	bc 4,2,.L381
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	mr 4,3
	mr 3,30
	bl Cmd_Hook_f
	b .L381
.L423:
	lis 4,.LC150@ha
	mr 3,31
	la 4,.LC150@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L426
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L427
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L427
	lis 9,gi+8@ha
	lis 5,.LC2@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC2@l(5)
	b .L814
.L427:
	lwz 0,264(30)
	cmpwi 0,0,1
	bc 4,2,.L429
	li 0,4
	lis 9,.LC31@ha
	stw 0,264(30)
	la 5,.LC31@l(9)
	b .L430
.L429:
	li 0,1
	lis 9,.LC32@ha
	stw 0,264(30)
	la 5,.LC32@l(9)
.L430:
	lis 9,gi+8@ha
	mr 3,30
	lwz 0,gi+8@l(9)
	b .L814
.L426:
	lis 4,.LC151@ha
	mr 3,31
	la 4,.LC151@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L432
	lwz 29,84(30)
	lwz 0,3616(29)
	stw 3,3612(29)
	cmpwi 0,0,0
	stw 3,3620(29)
	bc 12,2,.L433
	stw 3,3616(29)
	b .L381
.L433:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3616(29)
	li 3,5
	lwz 0,100(9)
	mr 27,9
	addi 31,29,748
	addi 28,29,1768
	mtlr 0
	blrl
.L437:
	lwz 9,104(27)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,28
	bc 4,1,.L437
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	lwz 0,1864(29)
	andi. 9,0,1
	bc 12,2,.L440
	li 0,2
	stw 0,1864(29)
.L440:
	lwz 0,1868(29)
	andi. 10,0,1
	bc 12,2,.L381
	li 0,2
	stw 0,1868(29)
	b .L381
.L432:
	lis 4,.LC152@ha
	mr 3,31
	la 4,.LC152@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L443
	lis 9,gi@ha
	li 3,1
	la 31,gi@l(9)
	lwz 9,160(31)
	mtlr 9
	blrl
	bl atoi
	mr. 29,3
	bc 4,2,.L444
	lwz 0,908(30)
	cmpwi 0,0,3
	bc 4,2,.L445
	lwz 9,8(31)
	lis 5,.LC153@ha
	mr 3,30
	la 5,.LC153@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L445:
	lwz 0,908(30)
	cmpwi 0,0,1
	bc 4,2,.L446
	lwz 9,8(31)
	lis 5,.LC154@ha
	mr 3,30
	la 5,.LC154@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L446:
	lwz 0,908(30)
	cmpwi 0,0,2
	bc 4,2,.L447
	lwz 9,8(31)
	lis 5,.LC155@ha
	mr 3,30
	la 5,.LC155@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L447:
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 4,2,.L444
	lwz 0,8(31)
	lis 5,.LC156@ha
	mr 3,30
	la 5,.LC156@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L444:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 0,11,1
	bc 12,2,.L449
	cmpwi 0,29,1
	bc 4,2,.L449
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 4,2,.L449
	lis 9,gi+8@ha
	lis 5,.LC157@ha
	lwz 0,gi+8@l(9)
	la 5,.LC157@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,level@ha
	stw 29,908(30)
	la 11,level@l(11)
	lwz 9,352(11)
	addi 9,9,1
	stw 9,352(11)
.L449:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 0,11,1
	bc 12,2,.L381
	cmpwi 0,29,2
	bc 4,2,.L381
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 4,2,.L381
	lis 9,gi+8@ha
	lis 5,.LC158@ha
	lwz 0,gi+8@l(9)
	la 5,.LC158@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,level@ha
	stw 29,908(30)
	la 11,level@l(11)
	lwz 9,356(11)
	addi 9,9,1
	stw 9,356(11)
	b .L381
.L443:
	lis 4,.LC159@ha
	mr 3,31
	la 4,.LC159@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L456
	mr 3,30
	bl Cmd_Info_f
	b .L381
.L801:
	stw 11,744(8)
	b .L466
.L456:
	lis 4,.LC160@ha
	mr 3,31
	la 4,.LC160@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L458
	li 0,256
	lwz 8,84(30)
	lis 9,itemlist@ha
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	lwz 5,744(8)
	addi 6,8,748
.L812:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L463
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L463
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L801
.L463:
	addi 7,7,1
	bdnz .L812
	li 0,-1
	stw 0,744(8)
.L466:
	lwz 9,84(30)
	lwz 11,1816(9)
	addi 11,11,1
	stw 11,1816(9)
	lwz 3,84(30)
	lwz 0,1816(3)
	cmpwi 0,0,10
	bc 4,1,.L381
	li 0,1
	stw 0,1816(3)
	b .L381
.L802:
	stw 8,744(7)
	b .L478
.L458:
	lis 4,.LC161@ha
	mr 3,31
	la 4,.LC161@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L470
	lwz 7,84(30)
	lis 9,itemlist@ha
	li 0,256
	la 5,itemlist@l(9)
	mtctr 0
	lwz 9,744(7)
	addi 6,7,748
	addi 10,9,255
.L811:
	srawi 0,10,31
	srwi 0,0,24
	add 0,10,0
	rlwinm 0,0,0,0,23
	subf 8,0,10
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L475
	mulli 0,8,72
	add 11,0,5
	lwz 9,8(11)
	cmpwi 0,9,0
	bc 12,2,.L475
	lwz 0,56(11)
	cmpwi 0,0,0
	bc 4,2,.L802
.L475:
	addi 10,10,-1
	bdnz .L811
	li 0,-1
	stw 0,744(7)
.L478:
	lwz 9,84(30)
	lwz 11,1816(9)
	addi 11,11,-1
	stw 11,1816(9)
	lwz 3,84(30)
	lwz 0,1816(3)
	cmpwi 0,0,0
	bc 12,1,.L381
	li 0,10
	stw 0,1816(3)
	b .L381
.L470:
	lis 4,.LC162@ha
	mr 3,31
	la 4,.LC162@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L482
	li 0,256
	lwz 3,84(30)
	lis 9,itemlist@ha
	mtctr 0
	li 8,1
	la 5,itemlist@l(9)
	lwz 6,744(3)
	addi 7,3,748
.L810:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L487
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L487
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L805
.L487:
	addi 8,8,1
	bdnz .L810
	b .L816
.L482:
	lis 4,.LC163@ha
	mr 3,31
	la 4,.LC163@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L493
	lwz 3,84(30)
	lis 9,itemlist@ha
	li 0,256
	la 6,itemlist@l(9)
	mtctr 0
	lwz 9,744(3)
	addi 7,3,748
	addi 10,9,255
.L809:
	srawi 0,10,31
	srwi 0,0,24
	add 0,10,0
	rlwinm 0,0,0,0,23
	subf 8,0,10
	slwi 9,8,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L498
	mulli 0,8,72
	add 11,0,6
	lwz 9,8(11)
	cmpwi 0,9,0
	bc 12,2,.L498
	lwz 0,56(11)
	andi. 9,0,1
	bc 4,2,.L806
.L498:
	addi 10,10,-1
	bdnz .L809
	b .L816
.L493:
	lis 4,.LC164@ha
	mr 3,31
	la 4,.LC164@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L504
	li 0,256
	lwz 3,84(30)
	lis 9,itemlist@ha
	mtctr 0
	li 8,1
	la 5,itemlist@l(9)
	lwz 6,744(3)
	addi 7,3,748
.L808:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L509
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L509
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L805
.L509:
	addi 8,8,1
	bdnz .L808
	b .L816
.L504:
	lis 4,.LC165@ha
	mr 3,31
	la 4,.LC165@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L515
	lwz 3,84(30)
	lis 9,itemlist@ha
	li 0,256
	la 6,itemlist@l(9)
	mtctr 0
	lwz 9,744(3)
	addi 7,3,748
	addi 10,9,255
.L807:
	srawi 0,10,31
	srwi 0,0,24
	add 0,10,0
	rlwinm 0,0,0,0,23
	subf 8,0,10
	slwi 9,8,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L520
	mulli 0,8,72
	add 11,0,6
	lwz 9,8(11)
	cmpwi 0,9,0
	bc 12,2,.L520
	lwz 0,56(11)
	andi. 9,0,32
	bc 4,2,.L806
.L520:
	addi 10,10,-1
	bdnz .L807
.L816:
	li 0,-1
	stw 0,744(3)
	b .L381
.L515:
	lis 4,.LC166@ha
	mr 3,31
	la 4,.LC166@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L526
	mr 3,30
	bl Cmd_InvUse_f
	b .L381
.L526:
	lis 4,.LC167@ha
	mr 3,31
	la 4,.LC167@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L528
	mr 3,30
	bl Cmd_InvDrop_f
	b .L381
.L528:
	lis 4,.LC168@ha
	mr 3,31
	la 4,.LC168@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L530
	lwz 28,84(30)
	lwz 11,1848(28)
	cmpwi 0,11,0
	bc 12,2,.L381
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	mr 25,9
	li 29,1
	subf 9,9,11
	addi 26,28,748
	mullw 9,9,0
	srawi 27,9,3
.L535:
	add 11,27,29
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L537
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L537
	lwz 0,56(31)
	andi. 10,0,1
	bc 12,2,.L537
	mr 3,30
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1848(28)
	cmpw 0,0,31
	bc 12,2,.L381
.L537:
	addi 29,29,1
	cmpwi 0,29,256
	bc 4,1,.L535
	b .L381
.L530:
	lis 4,.LC169@ha
	mr 3,31
	la 4,.LC169@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L543
	lwz 28,84(30)
	lwz 11,1848(28)
	cmpwi 0,11,0
	bc 12,2,.L381
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	mr 25,9
	li 27,1
	subf 9,9,11
	addi 26,28,748
	mullw 9,9,0
	srawi 9,9,3
	addi 29,9,255
.L548:
	srawi 0,29,31
	srwi 0,0,24
	add 0,29,0
	rlwinm 0,0,0,0,23
	subf 11,0,29
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L550
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L550
	lwz 0,56(31)
	andi. 10,0,1
	bc 12,2,.L550
	mr 3,30
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1848(28)
	cmpw 0,0,31
	bc 12,2,.L381
.L550:
	addi 27,27,1
	addi 29,29,-1
	cmpwi 0,27,256
	bc 4,1,.L548
	b .L381
.L543:
	lis 4,.LC170@ha
	mr 3,31
	la 4,.LC170@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L556
	lwz 10,84(30)
	lwz 0,1848(10)
	cmpwi 0,0,0
	bc 12,2,.L381
	lwz 0,1852(10)
	cmpwi 0,0,0
	bc 12,2,.L381
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 4,itemlist@l(11)
	ori 9,9,36409
	subf 0,4,0
	addi 11,10,748
	mullw 0,0,9
	srawi 10,0,3
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L381
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L381
	lwz 0,56(4)
	andi. 10,0,1
	bc 12,2,.L381
	mr 3,30
	mtlr 9
	blrl
	b .L381
.L556:
	lis 4,.LC171@ha
	mr 3,31
	la 4,.LC171@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L564
	lwz 11,84(30)
	lwz 0,1804(11)
	cmpwi 0,0,0
	bc 4,1,.L381
	lis 9,level+4@ha
	lfs 13,3912(11)
	lis 10,.LC218@ha
	lfs 0,level+4@l(9)
	la 10,.LC218@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L381
	lwz 0,268(30)
	lis 11,meansOfDeath@ha
	li 9,23
	stw 3,728(30)
	lis 6,0x1
	lis 7,vec3_origin@ha
	rlwinm 0,0,0,28,26
	mr 3,30
	stw 0,268(30)
	la 7,vec3_origin@l(7)
	mr 4,30
	stw 9,meansOfDeath@l(11)
	mr 5,30
	ori 6,6,34464
	bl player_die
	li 0,2
	mr 3,30
	stw 0,764(30)
	bl respawn
	b .L381
.L564:
	lis 4,.LC172@ha
	mr 3,31
	la 4,.LC172@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L569
	lwz 8,84(30)
	lwz 7,1804(8)
	cmpwi 0,7,0
	bc 4,2,.L381
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 11,11,0x1
	bc 12,2,.L571
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 4,1,.L572
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L381
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 7,728(30)
	b .L817
.L572:
	lis 9,gi+8@ha
	lis 5,.LC60@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC60@l(5)
	b .L814
.L571:
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L381
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 11,728(30)
.L817:
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
	b .L381
.L569:
	lis 4,.LC173@ha
	mr 3,31
	la 4,.LC173@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L579
	lwz 9,84(30)
	stw 3,3612(9)
	lwz 11,84(30)
	stw 3,3620(11)
	lwz 9,84(30)
	stw 3,3616(9)
	b .L381
.L579:
	lis 4,.LC174@ha
	mr 3,31
	la 4,.LC174@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L582
	mr 3,30
	crxor 6,6,6
	bl OAK_Check_SP
	b .L381
.L582:
	lis 4,.LC175@ha
	mr 3,31
	la 4,.LC175@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L584
	lwz 9,84(30)
	lwz 0,1804(9)
	cmpwi 0,0,2
	bc 4,2,.L381
	mr 3,30
	bl SP_LaserSight
	b .L381
.L584:
	lis 4,.LC176@ha
	mr 3,31
	la 4,.LC176@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L587
	lwz 9,84(30)
	lwz 0,1804(9)
	cmpwi 0,0,3
	bc 4,2,.L588
	mr 3,30
	bl Cmd_Airstrike_f
.L588:
	lwz 9,84(30)
	lwz 0,1804(9)
	cmpwi 0,0,4
	bc 4,2,.L589
	mr 3,30
	bl Cmd_Airstrike_f
.L589:
	lwz 9,84(30)
	lwz 0,1804(9)
	cmpwi 0,0,5
	bc 4,2,.L381
	mr 3,30
	bl Cmd_Airstrike_f
	b .L381
.L587:
	lis 4,.LC63@ha
	mr 3,31
	la 4,.LC63@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L592
	lwz 9,84(30)
	li 0,1
	stw 0,1820(9)
	lwz 8,84(30)
	lwz 7,1804(8)
	cmpwi 0,7,0
	bc 4,2,.L593
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 11,11,0x1
	bc 12,2,.L594
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 4,1,.L595
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L593
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 7,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
	b .L593
.L595:
	lis 9,gi+8@ha
	lis 5,.LC60@ha
	lwz 0,gi+8@l(9)
	la 5,.LC60@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L593
.L594:
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L593
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 11,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
.L593:
	lis 9,gi+8@ha
	lis 5,.LC49@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC49@l(5)
	b .L814
.L592:
	lis 4,.LC65@ha
	mr 3,31
	la 4,.LC65@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L602
	lwz 9,84(30)
	li 6,2
	stw 6,1820(9)
	lwz 8,84(30)
	lwz 7,1804(8)
	cmpwi 0,7,0
	bc 4,2,.L603
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 11,11,0x1
	bc 12,2,.L604
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 4,1,.L605
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L603
	lwz 0,268(30)
	mr 3,30
	stw 7,728(30)
	rlwinm 0,0,0,28,26
	stw 6,764(30)
	stw 0,268(30)
	bl respawn
	b .L603
.L605:
	lis 9,gi+8@ha
	lis 5,.LC60@ha
	lwz 0,gi+8@l(9)
	la 5,.LC60@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L603
.L604:
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L603
	lwz 0,268(30)
	mr 3,30
	stw 11,728(30)
	rlwinm 0,0,0,28,26
	stw 6,764(30)
	stw 0,268(30)
	bl respawn
.L603:
	lis 9,gi+8@ha
	lis 5,.LC50@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC50@l(5)
	b .L814
.L602:
	lis 4,.LC67@ha
	mr 3,31
	la 4,.LC67@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L612
	lwz 9,84(30)
	li 0,3
	stw 0,1820(9)
	lwz 8,84(30)
	lwz 7,1804(8)
	cmpwi 0,7,0
	bc 4,2,.L613
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 11,11,0x1
	bc 12,2,.L614
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 4,1,.L615
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L613
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 7,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
	b .L613
.L615:
	lis 9,gi+8@ha
	lis 5,.LC60@ha
	lwz 0,gi+8@l(9)
	la 5,.LC60@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L613
.L614:
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L613
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 11,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
.L613:
	lis 9,gi+8@ha
	lis 5,.LC51@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC51@l(5)
	b .L814
.L612:
	lis 4,.LC69@ha
	mr 3,31
	la 4,.LC69@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L622
	lwz 9,84(30)
	li 0,4
	stw 0,1820(9)
	lwz 8,84(30)
	lwz 7,1804(8)
	cmpwi 0,7,0
	bc 4,2,.L623
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 11,11,0x1
	bc 12,2,.L624
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 4,1,.L625
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L623
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 7,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
	b .L623
.L625:
	lis 9,gi+8@ha
	lis 5,.LC60@ha
	lwz 0,gi+8@l(9)
	la 5,.LC60@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L623
.L624:
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L623
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 11,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
.L623:
	lis 9,gi+8@ha
	lis 5,.LC52@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC52@l(5)
	b .L814
.L622:
	lis 4,.LC71@ha
	mr 3,31
	la 4,.LC71@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L632
	lwz 9,84(30)
	li 0,5
	stw 0,1820(9)
	lwz 8,84(30)
	lwz 7,1804(8)
	cmpwi 0,7,0
	bc 4,2,.L633
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 11,11,0x1
	bc 12,2,.L634
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 4,1,.L635
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L633
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 7,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
	b .L633
.L635:
	lis 9,gi+8@ha
	lis 5,.LC60@ha
	lwz 0,gi+8@l(9)
	la 5,.LC60@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L633
.L634:
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L633
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 11,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
.L633:
	lis 9,gi+8@ha
	lis 5,.LC53@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC53@l(5)
	b .L814
.L632:
	lis 4,.LC73@ha
	mr 3,31
	la 4,.LC73@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L642
	lwz 9,84(30)
	li 0,6
	stw 0,1820(9)
	lwz 8,84(30)
	lwz 7,1804(8)
	cmpwi 0,7,0
	bc 4,2,.L643
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 11,11,0x1
	bc 12,2,.L644
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 4,1,.L645
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L643
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 7,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
	b .L643
.L645:
	lis 9,gi+8@ha
	lis 5,.LC60@ha
	lwz 0,gi+8@l(9)
	la 5,.LC60@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L643
.L644:
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L643
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 11,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
.L643:
	lis 9,gi+8@ha
	lis 5,.LC54@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC54@l(5)
	b .L814
.L642:
	lis 4,.LC75@ha
	mr 3,31
	la 4,.LC75@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L652
	lwz 9,84(30)
	li 0,7
	stw 0,1820(9)
	lwz 8,84(30)
	lwz 7,1804(8)
	cmpwi 0,7,0
	bc 4,2,.L653
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 11,11,0x1
	bc 12,2,.L654
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 4,1,.L655
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L653
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 7,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
	b .L653
.L655:
	lis 9,gi+8@ha
	lis 5,.LC60@ha
	lwz 0,gi+8@l(9)
	la 5,.LC60@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L653
.L654:
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L653
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 11,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
.L653:
	lis 9,gi+8@ha
	lis 5,.LC55@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC55@l(5)
	b .L814
.L652:
	lis 4,.LC177@ha
	mr 3,31
	la 4,.LC177@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L662
	lwz 9,84(30)
	li 0,8
	stw 0,1820(9)
	lwz 8,84(30)
	lwz 7,1804(8)
	cmpwi 0,7,0
	bc 4,2,.L663
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 11,11,0x1
	bc 12,2,.L664
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 4,1,.L665
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L663
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 7,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
	b .L663
.L665:
	lis 9,gi+8@ha
	lis 5,.LC60@ha
	lwz 0,gi+8@l(9)
	la 5,.LC60@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L663
.L664:
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L663
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 11,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
.L663:
	lis 9,gi+8@ha
	lis 5,.LC178@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC178@l(5)
	b .L814
.L662:
	lis 4,.LC79@ha
	mr 3,31
	la 4,.LC79@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L672
	lwz 9,84(30)
	li 0,9
	stw 0,1820(9)
	lwz 8,84(30)
	lwz 7,1804(8)
	cmpwi 0,7,0
	bc 4,2,.L673
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 11,11,0x1
	bc 12,2,.L674
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 4,1,.L675
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L673
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 7,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
	b .L673
.L675:
	lis 9,gi+8@ha
	lis 5,.LC60@ha
	lwz 0,gi+8@l(9)
	la 5,.LC60@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L673
.L674:
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L673
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 11,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
.L673:
	lis 9,gi+8@ha
	lis 5,.LC57@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC57@l(5)
	b .L814
.L672:
	lis 4,.LC81@ha
	mr 3,31
	la 4,.LC81@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L682
	lwz 9,84(30)
	li 0,10
	stw 0,1820(9)
	lwz 8,84(30)
	lwz 7,1804(8)
	cmpwi 0,7,0
	bc 4,2,.L683
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 11,11,0x1
	bc 12,2,.L684
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 4,1,.L685
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L683
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 7,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
	b .L683
.L685:
	lis 9,gi+8@ha
	lis 5,.LC60@ha
	lwz 0,gi+8@l(9)
	la 5,.LC60@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L683
.L684:
	lis 9,level+4@ha
	lfs 13,3912(8)
	lis 10,.LC219@ha
	lfs 0,level+4@l(9)
	la 10,.LC219@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L683
	lwz 0,268(30)
	li 9,2
	mr 3,30
	stw 11,728(30)
	rlwinm 0,0,0,28,26
	stw 9,764(30)
	stw 0,268(30)
	bl respawn
.L683:
	lis 9,gi+8@ha
	lis 5,.LC58@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC58@l(5)
	b .L814
.L682:
	lis 4,.LC179@ha
	mr 3,31
	la 4,.LC179@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L692
	mr 3,30
	bl Cmd_Wave_f
	b .L381
.L692:
	lis 4,.LC180@ha
	mr 3,31
	la 4,.LC180@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L694
	mr 3,30
	crxor 6,6,6
	bl Cmd_Turret_f
	b .L381
.L694:
	lis 4,.LC0@ha
	mr 3,31
	la 4,.LC0@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L696
	li 31,0
	addi 29,30,4
	b .L697
.L699:
	lwz 3,284(31)
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L697
	lwz 0,256(31)
	cmpw 0,0,30
	bc 4,2,.L697
	lis 9,Grenade_Explode@ha
	lis 10,level+4@ha
	la 9,Grenade_Explode@l(9)
	lis 11,.LC181@ha
	stw 9,680(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC181@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L697:
	lis 9,.LC220@ha
	mr 3,31
	la 9,.LC220@l(9)
	mr 4,29
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 4,2,.L699
	b .L381
.L696:
	lis 4,.LC182@ha
	mr 3,31
	la 4,.LC182@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L704
	lwz 9,84(30)
	lwz 0,1804(9)
	cmpwi 0,0,9
	bc 4,2,.L381
	lwz 0,728(30)
	cmpwi 0,0,0
	bc 4,1,.L381
	lwz 0,908(30)
	cmpwi 0,0,1
	bc 4,2,.L707
	lis 9,.LC61@ha
	la 28,.LC61@l(9)
.L707:
	cmpwi 0,0,2
	bc 4,2,.L708
	lis 9,.LC62@ha
	la 28,.LC62@l(9)
.L708:
	mr 3,28
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 11,11,748
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	lwzx 31,11,3
	cmpwi 0,31,0
	bc 4,2,.L381
	lwz 0,184(30)
	andi. 9,0,1
	bc 12,2,.L711
	lis 9,gi+8@ha
	lis 5,.LC129@ha
	lwz 0,gi+8@l(9)
	la 5,.LC129@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(30)
	stw 31,1812(11)
	lwz 9,184(30)
	addi 9,9,-1
	stw 9,184(30)
	b .L381
.L711:
	lis 9,gi+8@ha
	lis 5,.LC130@ha
	lwz 0,gi+8@l(9)
	la 5,.LC130@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(30)
	li 9,1
	stw 9,1812(11)
	lwz 0,184(30)
	ori 0,0,1
	stw 0,184(30)
	b .L381
.L704:
	lis 4,.LC183@ha
	mr 3,31
	la 4,.LC183@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L714
	lwz 11,84(30)
	lwz 0,1804(11)
	cmpwi 0,0,4
	bc 4,2,.L715
	lwz 9,1832(11)
	addi 9,9,1
	stw 9,1832(11)
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,4
	bc 4,1,.L716
	stw 3,1832(9)
.L716:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,0
	bc 4,2,.L717
	lis 9,gi+8@ha
	lis 5,.LC184@ha
	lwz 0,gi+8@l(9)
	la 5,.LC184@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L717:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,1
	bc 4,2,.L718
	lis 9,gi+8@ha
	lis 5,.LC185@ha
	lwz 0,gi+8@l(9)
	la 5,.LC185@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L718:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,2
	bc 4,2,.L719
	lis 9,gi+8@ha
	lis 5,.LC186@ha
	lwz 0,gi+8@l(9)
	la 5,.LC186@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L719:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,3
	bc 4,2,.L720
	lis 9,gi+8@ha
	lis 5,.LC187@ha
	lwz 0,gi+8@l(9)
	la 5,.LC187@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L720:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,4
	bc 4,2,.L715
	lis 9,gi+8@ha
	lis 5,.LC188@ha
	lwz 0,gi+8@l(9)
	la 5,.LC188@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L715:
	lwz 11,84(30)
	lwz 0,1804(11)
	cmpwi 0,0,3
	bc 4,2,.L722
	lwz 9,1832(11)
	addi 9,9,1
	stw 9,1832(11)
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,2
	bc 4,1,.L723
	li 0,0
	stw 0,1832(9)
.L723:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,0
	bc 4,2,.L724
	lis 9,gi+8@ha
	lis 5,.LC184@ha
	lwz 0,gi+8@l(9)
	la 5,.LC184@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L724:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,1
	bc 4,2,.L725
	lis 9,gi+8@ha
	lis 5,.LC189@ha
	lwz 0,gi+8@l(9)
	la 5,.LC189@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L725:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,2
	bc 4,2,.L722
	lis 9,gi+8@ha
	lis 5,.LC190@ha
	lwz 0,gi+8@l(9)
	la 5,.LC190@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L722:
	lwz 11,84(30)
	lwz 0,1804(11)
	cmpwi 0,0,2
	bc 4,2,.L727
	lwz 9,1832(11)
	addi 9,9,1
	stw 9,1832(11)
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,1
	bc 4,1,.L728
	li 0,0
	stw 0,1832(9)
.L728:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,0
	bc 4,2,.L729
	lis 9,gi+8@ha
	lis 5,.LC184@ha
	lwz 0,gi+8@l(9)
	la 5,.LC184@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L729:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,1
	bc 4,2,.L727
	lis 9,gi+8@ha
	lis 5,.LC191@ha
	lwz 0,gi+8@l(9)
	la 5,.LC191@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L727:
	lwz 11,84(30)
	lwz 0,1804(11)
	cmpwi 0,0,10
	bc 4,2,.L731
	lwz 9,1832(11)
	addi 9,9,1
	stw 9,1832(11)
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,1
	bc 4,1,.L732
	li 0,0
	stw 0,1832(9)
.L732:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,0
	bc 4,2,.L733
	lis 9,gi+8@ha
	lis 5,.LC184@ha
	lwz 0,gi+8@l(9)
	la 5,.LC184@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L733:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,1
	bc 4,2,.L731
	lis 9,gi+8@ha
	lis 5,.LC192@ha
	lwz 0,gi+8@l(9)
	la 5,.LC192@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L731:
	lwz 11,84(30)
	lwz 0,1804(11)
	cmpwi 0,0,7
	bc 4,2,.L735
	lwz 9,1832(11)
	addi 9,9,1
	stw 9,1832(11)
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,1
	bc 4,1,.L736
	li 0,0
	stw 0,1832(9)
.L736:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,0
	bc 4,2,.L737
	lis 9,gi+8@ha
	lis 5,.LC184@ha
	lwz 0,gi+8@l(9)
	la 5,.LC184@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L737:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,1
	bc 4,2,.L735
	lis 9,gi+8@ha
	lis 5,.LC193@ha
	lwz 0,gi+8@l(9)
	la 5,.LC193@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L735:
	lwz 11,84(30)
	lwz 0,1804(11)
	cmpwi 0,0,1
	bc 4,2,.L381
	lwz 9,1832(11)
	addi 9,9,1
	stw 9,1832(11)
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,2
	bc 4,1,.L740
	li 0,0
	stw 0,1832(9)
.L740:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,0
	bc 4,2,.L741
	lis 9,gi+8@ha
	lis 5,.LC184@ha
	lwz 0,gi+8@l(9)
	la 5,.LC184@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L741:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,1
	bc 4,2,.L742
	lis 9,gi+8@ha
	lis 5,.LC194@ha
	lwz 0,gi+8@l(9)
	la 5,.LC194@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L742:
	lwz 9,84(30)
	lwz 0,1832(9)
	cmpwi 0,0,2
	bc 4,2,.L381
	lis 9,gi+8@ha
	lis 5,.LC195@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC195@l(5)
	b .L814
.L714:
	lis 4,.LC196@ha
	mr 3,31
	la 4,.LC196@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L745
	lwz 9,84(30)
	lwz 0,1804(9)
	cmpwi 0,0,7
	bc 4,2,.L381
	lwz 0,932(30)
	cmpwi 0,0,1
	bc 12,1,.L381
	lis 28,.LC118@ha
	lis 31,0x38e3
	la 3,.LC118@l(28)
	ori 31,31,36409
	bl FindItem
	lis 9,itemlist@ha
	lwz 11,84(30)
	la 29,itemlist@l(9)
	subf 3,29,3
	mullw 3,3,31
	srawi 3,3,3
	stw 3,744(11)
	lwz 9,84(30)
	lwz 0,744(9)
	addi 9,9,748
	slwi 0,0,2
	lwzx 11,9,0
	addic. 0,11,-50
	bc 12,0,.L749
	la 3,.LC118@l(28)
	bl FindItem
	subf 3,29,3
	lwz 9,84(30)
	li 10,1
	mullw 3,3,31
	srawi 3,3,3
	stw 3,744(9)
	lwz 11,84(30)
	lwz 0,744(11)
	addi 11,11,748
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,-50
	stwx 9,11,0
	b .L751
.L749:
	lis 9,gi+8@ha
	lis 5,.LC119@ha
	lwz 0,gi+8@l(9)
	la 5,.LC119@l(5)
	mr 3,30
	li 4,2
	li 6,50
	mtlr 0
	crxor 6,6,6
	blrl
	li 10,0
.L751:
	cmpwi 0,10,0
	bc 12,2,.L381
	mr 3,30
	crxor 6,6,6
	bl SP_monster_parasite2
	b .L381
.L745:
	lis 4,.LC197@ha
	mr 3,31
	la 4,.LC197@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L754
	lis 9,gi+8@ha
	lis 5,.LC198@ha
	lwz 0,gi+8@l(9)
	lis 6,.LC199@ha
	lis 7,.LC200@ha
	mr 3,30
	la 5,.LC198@l(5)
	la 6,.LC199@l(6)
	la 7,.LC200@l(7)
	mtlr 0
	li 4,2
	crxor 6,6,6
	blrl
	b .L381
.L754:
	lis 4,.LC201@ha
	mr 3,31
	la 4,.LC201@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L756
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	bl atoi
	mr. 3,3
	bc 4,2,.L757
	lwz 9,84(30)
	lis 0,0x42b4
	stw 0,112(9)
	b .L381
.L757:
	cmpwi 0,3,1
	bc 4,2,.L381
	lwz 3,84(30)
	lis 9,.LC221@ha
	la 9,.LC221@l(9)
	lfs 12,0(9)
	lfs 13,112(3)
	fcmpu 0,13,12
	bc 4,2,.L760
	lis 0,0x4220
	stw 0,112(3)
	b .L381
.L760:
	lis 10,.LC222@ha
	la 10,.LC222@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,2,.L762
	lis 0,0x41a0
	stw 0,112(3)
	b .L381
.L762:
	lis 11,.LC223@ha
	la 11,.LC223@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L764
	lis 0,0x4120
	stw 0,112(3)
	b .L381
.L764:
	stfs 12,112(3)
	b .L381
.L756:
	lis 4,.LC202@ha
	mr 3,31
	la 4,.LC202@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L767
	lwz 9,84(30)
	lwz 0,1804(9)
	cmpwi 0,0,7
	bc 4,2,.L381
	mr 3,30
	crxor 6,6,6
	bl PlaceLaser
	b .L381
.L767:
	lis 4,.LC203@ha
	mr 3,31
	la 4,.LC203@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L771
	lwz 9,84(30)
	lwz 11,1840(9)
	addi 11,11,1
	stw 11,1840(9)
	lwz 9,84(30)
	lwz 0,1840(9)
	cmpwi 0,0,2
	bc 4,1,.L772
	stw 3,1840(9)
.L772:
	lwz 9,84(30)
	lwz 0,1840(9)
	cmpwi 0,0,0
	bc 4,2,.L773
	lis 9,gi+8@ha
	lis 5,.LC204@ha
	lwz 0,gi+8@l(9)
	la 5,.LC204@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L773:
	lwz 9,84(30)
	lwz 0,1840(9)
	cmpwi 0,0,1
	bc 4,2,.L774
	lis 9,gi+8@ha
	lis 5,.LC205@ha
	lwz 0,gi+8@l(9)
	la 5,.LC205@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L774:
	lwz 9,84(30)
	lwz 0,1840(9)
	cmpwi 0,0,2
	bc 4,2,.L381
	lis 9,gi+8@ha
	lis 5,.LC206@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC206@l(5)
.L814:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L381
.L771:
	lis 4,.LC207@ha
	mr 3,31
	la 4,.LC207@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L777
	lwz 9,84(30)
	lwz 0,1804(9)
	cmpwi 0,0,1
	bc 4,2,.L381
	lwz 0,268(30)
	andi. 9,0,8192
	bc 12,2,.L779
	lis 9,gi+8@ha
	lis 5,.LC208@ha
	lwz 0,gi+8@l(9)
	la 5,.LC208@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,268(30)
	addi 9,9,-8192
	stw 9,268(30)
	b .L381
.L779:
	lis 9,gi+8@ha
	lis 5,.LC209@ha
	lwz 0,gi+8@l(9)
	la 5,.LC209@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,268(30)
	ori 0,0,8192
	stw 0,268(30)
	b .L381
.L777:
	lis 4,.LC210@ha
	mr 3,31
	la 4,.LC210@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L782
	lwz 9,84(30)
	lwz 0,1804(9)
	cmpwi 0,0,1
	bc 12,2,.L818
	cmpwi 0,0,10
	bc 4,2,.L381
.L818:
	mr 3,30
	bl Toggle_Scanner
	b .L381
.L782:
	lis 4,.LC211@ha
	mr 3,31
	la 4,.LC211@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L787
	mr 3,30
	bl Cmd_CheckStats_f
	b .L381
.L787:
	lis 4,.LC212@ha
	mr 3,31
	la 4,.LC212@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L789
	mr 3,30
	bl Cmd_id_f
	b .L381
.L789:
	lis 4,.LC213@ha
	mr 3,31
	la 4,.LC213@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L791
	lwz 9,84(30)
	lwz 0,1804(9)
	cmpwi 0,0,10
	bc 4,2,.L381
	mr 3,30
	bl Cmd_Disguise_f
	b .L381
.L791:
	lis 4,.LC214@ha
	mr 3,31
	la 4,.LC214@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L794
	mr 3,30
	crxor 6,6,6
	bl ClassHelpMenu
	b .L381
.L794:
	lis 4,.LC215@ha
	mr 3,31
	la 4,.LC215@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L796
	mr 3,30
	crxor 6,6,6
	bl Toggle_Classes
	b .L381
.L796:
	lis 4,.LC216@ha
	mr 3,31
	la 4,.LC216@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L798
	lwz 9,84(30)
	lwz 0,1804(9)
	cmpwi 0,0,9
	bc 4,2,.L381
	mr 3,30
	crxor 6,6,6
	bl Start_Kamikaze_Mode
	b .L381
.L805:
	stw 11,744(3)
	b .L381
.L806:
	stw 8,744(3)
	b .L381
.L798:
	mr 3,30
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L381:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe16:
	.size	 ClientCommand,.Lfe16-ClientCommand
	.align 2
	.globl OnSameTeam
	.type	 OnSameTeam,@function
OnSameTeam:
	lwz 0,908(3)
	lwz 3,908(4)
	xor 3,0,3
	subfic 9,3,0
	adde 3,9,3
	blr
.Lfe17:
	.size	 OnSameTeam,.Lfe17-OnSameTeam
	.align 2
	.globl ValidateSelectedItem
	.type	 ValidateSelectedItem,@function
ValidateSelectedItem:
	lwz 8,84(3)
	lwz 11,744(8)
	addi 10,8,748
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bclr 4,2
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L820:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L34
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L34
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 12,2,.L34
	stw 11,744(8)
	blr
.L34:
	addi 7,7,1
	bdnz .L820
	li 0,-1
	stw 0,744(8)
	blr
.Lfe18:
	.size	 ValidateSelectedItem,.Lfe18-ValidateSelectedItem
	.align 2
	.globl ClientTeam
	.type	 ClientTeam,@function
ClientTeam:
	blr
.Lfe19:
	.size	 ClientTeam,.Lfe19-ClientTeam
	.align 2
	.globl SelectNextItem
	.type	 SelectNextItem,@function
SelectNextItem:
	li 0,256
	lwz 8,84(3)
	lis 9,itemlist@ha
	mtctr 0
	la 5,itemlist@l(9)
	li 7,1
	addi 6,8,748
.L821:
	lwz 11,744(8)
	add 11,11,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L13
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L13
	lwz 0,56(10)
	and. 9,0,4
	bc 12,2,.L13
	stw 11,744(8)
	blr
.L13:
	addi 7,7,1
	bdnz .L821
	li 0,-1
	stw 0,744(8)
	blr
.Lfe20:
	.size	 SelectNextItem,.Lfe20-SelectNextItem
	.align 2
	.globl SelectPrevItem
	.type	 SelectPrevItem,@function
SelectPrevItem:
	li 0,256
	lwz 8,84(3)
	lis 9,itemlist@ha
	mtctr 0
	la 5,itemlist@l(9)
	li 7,1
	addi 6,8,748
.L822:
	lwz 11,744(8)
	addi 9,7,-256
	subf 11,9,11
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L22
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L22
	lwz 0,56(10)
	and. 9,0,4
	bc 12,2,.L22
	stw 11,744(8)
	blr
.L22:
	addi 7,7,1
	bdnz .L822
	li 0,-1
	stw 0,744(8)
	blr
.Lfe21:
	.size	 SelectPrevItem,.Lfe21-SelectPrevItem
	.section	".rodata"
	.align 3
.LC224:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC225:
	.long 0x447a0000
	.section	".text"
	.align 2
	.globl Cmd_DetPipes_f
	.type	 Cmd_DetPipes_f,@function
Cmd_DetPipes_f:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	lis 9,.LC224@ha
	lis 11,Grenade_Explode@ha
	lfd 31,.LC224@l(9)
	la 27,Grenade_Explode@l(11)
	mr 30,3
	lis 9,level@ha
	li 31,0
	la 28,level@l(9)
	lis 29,.LC0@ha
	b .L40
.L42:
	lwz 3,284(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L40
	lwz 0,256(31)
	cmpw 0,0,30
	bc 4,2,.L40
	stw 27,680(31)
	lfs 0,4(28)
	fadd 0,0,31
	frsp 0,0
	stfs 0,672(31)
.L40:
	lis 9,.LC225@ha
	mr 3,31
	la 9,.LC225@l(9)
	addi 4,30,4
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	la 4,.LC0@l(29)
	bc 4,2,.L42
	lwz 0,52(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe22:
	.size	 Cmd_DetPipes_f,.Lfe22-Cmd_DetPipes_f
	.section	".rodata"
	.align 2
.LC226:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC226@ha
	lis 9,deathmatch@ha
	la 11,.LC226@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L105
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L105
	lis 9,gi+8@ha
	lis 5,.LC2@ha
	lwz 0,gi+8@l(9)
	la 5,.LC2@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L104
.L105:
	lwz 0,268(3)
	xori 0,0,16
	andi. 9,0,16
	stw 0,268(3)
	bc 4,2,.L106
	lis 9,.LC27@ha
	la 5,.LC27@l(9)
	b .L107
.L106:
	lis 9,.LC28@ha
	la 5,.LC28@l(9)
.L107:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L104:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 Cmd_God_f,.Lfe23-Cmd_God_f
	.section	".rodata"
	.align 2
.LC227:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC227@ha
	lis 9,deathmatch@ha
	la 11,.LC227@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L109
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L109
	lis 9,gi+8@ha
	lis 5,.LC2@ha
	lwz 0,gi+8@l(9)
	la 5,.LC2@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L108
.L109:
	lwz 0,268(3)
	xori 0,0,32
	andi. 9,0,32
	stw 0,268(3)
	bc 4,2,.L110
	lis 9,.LC29@ha
	la 5,.LC29@l(9)
	b .L111
.L110:
	lis 9,.LC30@ha
	la 5,.LC30@l(9)
.L111:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L108:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 Cmd_Notarget_f,.Lfe24-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC228:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC228@ha
	lis 9,deathmatch@ha
	la 11,.LC228@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L113
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L113
	lis 9,gi+8@ha
	lis 5,.LC2@ha
	lwz 0,gi+8@l(9)
	la 5,.LC2@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L112
.L113:
	lwz 0,264(3)
	cmpwi 0,0,1
	bc 4,2,.L114
	li 0,4
	lis 9,.LC31@ha
	stw 0,264(3)
	la 5,.LC31@l(9)
	b .L115
.L114:
	li 0,1
	lis 9,.LC32@ha
	stw 0,264(3)
	la 5,.LC32@l(9)
.L115:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L112:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe25:
	.size	 Cmd_Noclip_f,.Lfe25-Cmd_Noclip_f
	.align 2
	.globl Cmd_Use_f
	.type	 Cmd_Use_f,@function
Cmd_Use_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 30,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L117
	lwz 0,8(29)
	lis 5,.LC33@ha
	mr 3,31
	la 5,.LC33@l(5)
	b .L823
.L117:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L118
	lwz 0,8(29)
	lis 5,.LC34@ha
	mr 3,31
	la 5,.LC34@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L116
.L118:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,4
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L119
	lwz 0,8(29)
	lis 5,.LC35@ha
	mr 3,31
	la 5,.LC35@l(5)
.L823:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L116
.L119:
	mr 3,31
	mtlr 10
	blrl
.L116:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 Cmd_Use_f,.Lfe26-Cmd_Use_f
	.align 2
	.globl Cmd_Drop_f
	.type	 Cmd_Drop_f,@function
Cmd_Drop_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 30,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L121
	lwz 0,8(29)
	lis 5,.LC33@ha
	mr 3,31
	la 5,.LC33@l(5)
	b .L824
.L121:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L122
	lwz 0,8(29)
	lis 5,.LC36@ha
	mr 3,31
	la 5,.LC36@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L120
.L122:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,4
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L123
	lwz 0,8(29)
	lis 5,.LC35@ha
	mr 3,31
	la 5,.LC35@l(5)
.L824:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L120
.L123:
	mr 3,31
	mtlr 10
	blrl
.L120:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 Cmd_Drop_f,.Lfe27-Cmd_Drop_f
	.align 2
	.globl Cmd_Inven_f
	.type	 Cmd_Inven_f,@function
Cmd_Inven_f:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 27,3
	li 9,0
	lwz 30,84(27)
	lwz 0,3616(30)
	stw 9,3612(30)
	cmpwi 0,0,0
	stw 9,3620(30)
	bc 12,2,.L125
	stw 9,3616(30)
	b .L124
.L125:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3616(30)
	li 3,5
	lwz 0,100(9)
	mr 28,9
	addi 31,30,748
	addi 29,30,1768
	mtlr 0
	blrl
.L129:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,29
	bc 4,1,.L129
	lis 9,gi+92@ha
	mr 3,27
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	lwz 0,1864(30)
	andi. 9,0,1
	bc 12,2,.L131
	li 0,2
	stw 0,1864(30)
.L131:
	lwz 0,1868(30)
	andi. 9,0,1
	bc 12,2,.L124
	li 0,2
	stw 0,1868(30)
.L124:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe28:
	.size	 Cmd_Inven_f,.Lfe28-Cmd_Inven_f
	.align 2
	.globl Cmd_WeapPrev_f
	.type	 Cmd_WeapPrev_f,@function
Cmd_WeapPrev_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 28,3
	lwz 29,84(28)
	lwz 11,1848(29)
	cmpwi 0,11,0
	bc 12,2,.L184
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,29,748
	mullw 9,9,0
	srawi 27,9,3
.L189:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L188
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L188
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L188
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1848(29)
	cmpw 0,0,31
	bc 12,2,.L184
.L188:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L189
.L184:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe29:
	.size	 Cmd_WeapPrev_f,.Lfe29-Cmd_WeapPrev_f
	.align 2
	.globl Cmd_WeapNext_f
	.type	 Cmd_WeapNext_f,@function
Cmd_WeapNext_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 27,3
	lwz 29,84(27)
	lwz 11,1848(29)
	cmpwi 0,11,0
	bc 12,2,.L195
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	mr 25,9
	li 28,1
	subf 9,9,11
	addi 26,29,748
	mullw 9,9,0
	srawi 9,9,3
	addi 30,9,255
.L200:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L199
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L199
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L199
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1848(29)
	cmpw 0,0,31
	bc 12,2,.L195
.L199:
	addi 28,28,1
	addi 30,30,-1
	cmpwi 0,28,256
	bc 4,1,.L200
.L195:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe30:
	.size	 Cmd_WeapNext_f,.Lfe30-Cmd_WeapNext_f
	.align 2
	.globl Cmd_WeapLast_f
	.type	 Cmd_WeapLast_f,@function
Cmd_WeapLast_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 10,84(3)
	lwz 0,1848(10)
	cmpwi 0,0,0
	bc 12,2,.L206
	lwz 0,1852(10)
	cmpwi 0,0,0
	bc 12,2,.L206
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 4,itemlist@l(11)
	ori 9,9,36409
	subf 0,4,0
	addi 11,10,748
	mullw 0,0,9
	srawi 10,0,3
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L206
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L206
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L206
	mtlr 9
	blrl
.L206:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 Cmd_WeapLast_f,.Lfe31-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC229:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Cmd_Kill_f
	.type	 Cmd_Kill_f,@function
Cmd_Kill_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 9,level+4@ha
	lwz 11,84(31)
	lis 10,.LC229@ha
	lfs 0,level+4@l(9)
	la 10,.LC229@l(10)
	lfs 13,3912(11)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L229
	lwz 0,268(31)
	li 9,0
	lis 10,meansOfDeath@ha
	stw 9,728(31)
	li 11,23
	lis 6,0x1
	rlwinm 0,0,0,28,26
	lis 7,vec3_origin@ha
	stw 0,268(31)
	la 7,vec3_origin@l(7)
	stw 11,meansOfDeath@l(10)
	mr 4,31
	mr 5,31
	ori 6,6,34464
	bl player_die
	li 0,2
	mr 3,31
	stw 0,764(31)
	bl respawn
.L229:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe32:
	.size	 Cmd_Kill_f,.Lfe32-Cmd_Kill_f
	.section	".rodata"
	.align 2
.LC230:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl Cmd_Spawn_f
	.type	 Cmd_Spawn_f,@function
Cmd_Spawn_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	mr 10,3
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	andis. 8,9,0x1
	bc 12,2,.L232
	lwz 0,908(10)
	cmpwi 0,0,0
	bc 4,1,.L233
	lwz 11,84(10)
	lis 9,level+4@ha
	lis 7,.LC230@ha
	lfs 0,level+4@l(9)
	la 7,.LC230@l(7)
	lfs 13,3912(11)
	lfs 12,0(7)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L231
	lwz 0,268(10)
	li 9,0
	li 11,2
	stw 9,728(10)
	rlwinm 0,0,0,28,26
	stw 11,764(10)
	stw 0,268(10)
	bl respawn
	b .L231
.L233:
	lis 9,gi+8@ha
	lis 5,.LC60@ha
	lwz 0,gi+8@l(9)
	mr 3,10
	la 5,.LC60@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L231
.L232:
	lwz 11,84(10)
	lis 9,level+4@ha
	lis 7,.LC230@ha
	lfs 0,level+4@l(9)
	la 7,.LC230@l(7)
	lfs 13,3912(11)
	lfs 12,0(7)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L231
	lwz 0,268(10)
	li 9,2
	mr 3,10
	stw 8,728(10)
	rlwinm 0,0,0,28,26
	stw 9,764(10)
	stw 0,268(10)
	bl respawn
.L231:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe33:
	.size	 Cmd_Spawn_f,.Lfe33-Cmd_Spawn_f
	.align 2
	.globl Cmd_PutAway_f
	.type	 Cmd_PutAway_f,@function
Cmd_PutAway_f:
	lwz 9,84(3)
	li 0,0
	stw 0,3612(9)
	lwz 11,84(3)
	stw 0,3620(11)
	lwz 9,84(3)
	stw 0,3616(9)
	blr
.Lfe34:
	.size	 Cmd_PutAway_f,.Lfe34-Cmd_PutAway_f
	.align 2
	.globl PlayerSort
	.type	 PlayerSort,@function
PlayerSort:
	lwz 9,0(3)
	lis 11,game+1028@ha
	lwz 3,0(4)
	lwz 0,game+1028@l(11)
	mulli 9,9,3960
	mulli 11,3,3960
	add 9,9,0
	add 11,11,0
	lha 9,148(9)
	lha 3,148(11)
	cmpw 0,9,3
	li 3,-1
	bclr 12,0
	mfcr 3
	rlwinm 3,3,2,1
	blr
.Lfe35:
	.size	 PlayerSort,.Lfe35-PlayerSort
	.align 2
	.globl Cmd_Reduce_Cells
	.type	 Cmd_Reduce_Cells,@function
Cmd_Reduce_Cells:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	mr 28,4
	lis 3,.LC118@ha
	la 3,.LC118@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	mullw 3,3,0
	srawi 3,3,3
	stw 3,744(11)
	lwz 9,84(29)
	lwz 11,744(9)
	addi 9,9,748
	slwi 11,11,2
	lwzx 0,9,11
	subf 0,28,0
	stwx 0,9,11
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 Cmd_Reduce_Cells,.Lfe36-Cmd_Reduce_Cells
	.align 2
	.globl Reduce_Cells
	.type	 Reduce_Cells,@function
Reduce_Cells:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 30,3
	lis 27,.LC118@ha
	mr 29,4
	la 3,.LC118@l(27)
	bl FindItem
	lis 31,0x38e3
	lis 9,itemlist@ha
	ori 31,31,36409
	lwz 11,84(30)
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,31
	srawi 3,3,3
	stw 3,744(11)
	lwz 9,84(30)
	lwz 0,744(9)
	addi 9,9,748
	slwi 0,0,2
	lwzx 11,9,0
	subf. 0,29,11
	bc 4,0,.L340
	lis 9,gi+8@ha
	lis 5,.LC119@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC119@l(5)
	mr 6,29
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L826
.L340:
	la 3,.LC118@l(27)
	bl FindItem
	subf 0,28,3
	lwz 11,84(30)
	mullw 0,0,31
	li 3,1
	srawi 0,0,3
	stw 0,744(11)
	lwz 9,84(30)
	lwz 11,744(9)
	addi 9,9,748
	slwi 11,11,2
	lwzx 0,9,11
	subf 0,29,0
	stwx 0,9,11
.L826:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe37:
	.size	 Reduce_Cells,.Lfe37-Reduce_Cells
	.align 2
	.globl Cmd_Cloak_f
	.type	 Cmd_Cloak_f,@function
Cmd_Cloak_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,908(31)
	cmpwi 0,0,1
	bc 4,2,.L364
	lis 9,.LC61@ha
	la 9,.LC61@l(9)
.L364:
	cmpwi 0,0,2
	bc 4,2,.L365
	lis 9,.LC62@ha
	la 9,.LC62@l(9)
.L365:
	mr 3,9
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 11,11,748
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	lwzx 30,11,3
	cmpwi 0,30,0
	bc 4,2,.L363
	lwz 0,184(31)
	andi. 9,0,1
	bc 12,2,.L367
	lis 9,gi+8@ha
	lis 5,.LC129@ha
	lwz 0,gi+8@l(9)
	la 5,.LC129@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	stw 30,1812(11)
	lwz 9,184(31)
	addi 9,9,-1
	stw 9,184(31)
	b .L363
.L367:
	lis 9,gi+8@ha
	lis 5,.LC130@ha
	lwz 0,gi+8@l(9)
	la 5,.LC130@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 9,1
	stw 9,1812(11)
	lwz 0,184(31)
	ori 0,0,1
	stw 0,184(31)
.L363:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe38:
	.size	 Cmd_Cloak_f,.Lfe38-Cmd_Cloak_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
