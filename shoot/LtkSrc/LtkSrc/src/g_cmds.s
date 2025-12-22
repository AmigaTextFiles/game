	.file	"g_cmds.c"
gcc2_compiled.:
	.lcomm	value.6,512,4
	.section	".rodata"
	.align 2
.LC0:
	.string	"skin"
	.align 2
.LC1:
	.long 0x0
	.section	".text"
	.align 2
	.globl OnSameTeam
	.type	 OnSameTeam,@function
OnSameTeam:
	stwu 1,-1072(1)
	mflr 0
	stmw 27,1052(1)
	stw 0,1076(1)
	lwz 8,84(3)
	mr 28,4
	cmpwi 0,8,0
	bc 12,2,.L25
	lwz 10,84(28)
	cmpwi 0,10,0
	bc 12,2,.L25
	lis 9,.LC1@ha
	lis 11,teamplay@ha
	la 9,.LC1@l(9)
	lfs 13,0(9)
	lwz 9,teamplay@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L13
	lwz 0,3488(8)
	lwz 3,3488(10)
	xor 3,0,3
	subfic 9,3,0
	adde 3,9,3
	b .L24
.L13:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 11,1044(1)
	andi. 0,11,192
	bc 4,2,.L14
.L25:
	li 3,0
	b .L24
.L14:
	lis 9,value.6@ha
	li 30,0
	stb 30,value.6@l(9)
	la 31,value.6@l(9)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC0@ha
	addi 3,3,188
	la 4,.LC0@l(4)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L27
	lis 9,dmflags@ha
	lwz 11,dmflags@l(9)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 9,1044(1)
	andi. 0,9,128
	bc 12,2,.L18
	stb 30,0(3)
.L27:
	mr 3,31
	b .L16
.L18:
	addi 3,3,1
.L16:
	mr 4,3
	li 29,0
	addi 3,1,8
	bl strcpy
	lis 9,value.6@ha
	addi 30,1,520
	stb 29,value.6@l(9)
	mr 27,30
	la 31,value.6@l(9)
	lwz 3,84(28)
	cmpwi 0,3,0
	bc 12,2,.L29
	lis 4,.LC0@ha
	addi 3,3,188
	la 4,.LC0@l(4)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L29
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 11,1044(1)
	andi. 0,11,128
	bc 12,2,.L22
	stb 29,0(3)
.L29:
	mr 3,31
	b .L20
.L22:
	addi 3,3,1
.L20:
	mr 4,3
	mr 3,30
	bl strcpy
	mr 4,27
	addi 3,1,8
	bl strcmp
	subfic 0,3,0
	adde 3,0,3
.L24:
	lwz 0,1076(1)
	mtlr 0
	lmw 27,1052(1)
	la 1,1072(1)
	blr
.Lfe1:
	.size	 OnSameTeam,.Lfe1-OnSameTeam
	.section	".rodata"
	.align 2
.LC2:
	.string	"You must run the server with '+set cheats 1' to enable this command.\n"
	.align 2
.LC3:
	.string	"This command can't be used by spectators.\n"
	.align 2
.LC4:
	.string	"all"
	.align 2
.LC5:
	.string	"health"
	.align 2
.LC6:
	.string	"weapons"
	.align 2
.LC7:
	.string	"items"
	.align 2
.LC8:
	.string	"ammo"
	.align 2
.LC9:
	.string	"armor"
	.align 2
.LC10:
	.string	"Power Shield"
	.align 2
.LC11:
	.string	"unknown item\n"
	.align 2
.LC12:
	.string	"non-pickup item\n"
	.align 2
.LC13:
	.long 0x0
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC15:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Cmd_Give_f
	.type	 Cmd_Give_f,@function
Cmd_Give_f:
	stwu 1,-1088(1)
	mflr 0
	mfcr 12
	stfd 30,1072(1)
	stfd 31,1080(1)
	stmw 24,1040(1)
	stw 0,1092(1)
	stw 12,1036(1)
	lis 9,deathmatch@ha
	lis 10,.LC13@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC13@l(10)
	mr 28,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L66
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L66
	lis 5,.LC2@ha
	la 5,.LC2@l(5)
	b .L116
.L66:
	lwz 0,248(28)
	cmpwi 0,0,0
	bc 4,2,.L67
	lis 5,.LC3@ha
	mr 3,28
	la 5,.LC3@l(5)
.L116:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L65
.L67:
	lis 29,gi@ha
	la 29,gi@l(29)
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 27,3
	lis 4,.LC4@ha
	la 4,.LC4@l(4)
	bl Q_stricmp
	subfic 0,3,0
	adde 31,0,3
	lwz 0,160(29)
	li 3,1
	mtlr 0
	blrl
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L65
	cmpwi 4,31,0
	bc 4,18,.L72
	lis 4,.LC6@ha
	mr 3,27
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L71
.L72:
	lis 9,game@ha
	li 31,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,31,0
	bc 4,0,.L74
	lis 9,itemlist@ha
	mr 7,11
	la 8,itemlist@l(9)
	li 10,0
.L76:
	mr 29,8
	lwz 0,4(29)
	cmpwi 0,0,0
	bc 12,2,.L75
	lwz 0,56(29)
	andi. 9,0,1
	bc 12,2,.L75
	lwz 11,84(28)
	addi 11,11,740
	lwzx 9,11,10
	addi 9,9,1
	stwx 9,11,10
.L75:
	lwz 0,1556(7)
	addi 31,31,1
	addi 10,10,4
	addi 8,8,72
	cmpw 0,31,0
	bc 12,0,.L76
.L74:
	bc 12,18,.L65
.L71:
	bc 4,18,.L82
	lis 4,.LC7@ha
	mr 3,27
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L81
.L82:
	lis 9,game@ha
	li 31,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,31,0
	bc 4,0,.L84
	lis 9,itemlist@ha
	lis 10,.LC15@ha
	la 30,itemlist@l(9)
	la 10,.LC15@l(10)
	lis 9,.LC14@ha
	lfs 30,0(10)
	mr 24,11
	la 9,.LC14@l(9)
	lis 25,0x4330
	lfd 31,0(9)
	lis 26,unique_items@ha
.L86:
	mr 29,30
	lwz 0,4(29)
	cmpwi 0,0,0
	bc 12,2,.L85
	lwz 0,56(29)
	andi. 11,0,64
	bc 12,2,.L85
	lwz 10,84(28)
	stw 29,656(1)
	lwz 0,4312(10)
	lwz 11,unique_items@l(26)
	xoris 0,0,0x8000
	stw 0,1028(1)
	stw 25,1024(1)
	lfd 0,1024(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L89
	fsubs 0,13,30
	fctiwz 13,0
	stfd 13,1024(1)
	lwz 9,1028(1)
	stw 9,4312(10)
.L89:
	addi 3,1,8
	mr 4,28
	bl Pickup_Special
.L85:
	lwz 0,1556(24)
	addi 31,31,1
	addi 30,30,72
	cmpw 0,31,0
	bc 12,0,.L86
.L84:
	bc 12,18,.L65
.L81:
	bc 4,18,.L93
	lis 4,.LC8@ha
	mr 3,27
	la 4,.LC8@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L92
.L93:
	lwz 11,84(28)
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lwz 0,4220(11)
	stw 0,4224(11)
	lwz 9,84(28)
	lwz 0,4228(9)
	stw 0,4232(9)
	lwz 11,84(28)
	lwz 0,4252(11)
	stw 0,4256(11)
	lwz 9,84(28)
	lwz 0,4260(9)
	stw 0,4264(9)
	lwz 11,84(28)
	lwz 0,4236(11)
	stw 0,4240(11)
	lwz 9,84(28)
	lwz 0,4244(9)
	stw 0,4248(9)
	lwz 11,84(28)
	lwz 0,4268(11)
	stw 0,4272(11)
	lwz 9,1556(10)
	cmpw 0,31,9
	bc 4,0,.L95
	lis 9,itemlist@ha
	mr 26,10
	la 30,itemlist@l(9)
.L97:
	mr 29,30
	lwz 0,4(29)
	cmpwi 0,0,0
	bc 12,2,.L96
	lwz 0,56(29)
	andi. 9,0,2
	bc 12,2,.L96
	mr 4,29
	mr 3,28
	li 5,1000
	bl Add_Ammo
.L96:
	lwz 0,1556(26)
	addi 31,31,1
	addi 30,30,72
	cmpw 0,31,0
	bc 12,0,.L97
.L95:
	bc 12,18,.L65
.L92:
	lis 4,.LC9@ha
	mr 3,27
	la 4,.LC9@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L65
	lis 4,.LC10@ha
	mr 3,27
	la 4,.LC10@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L65
	bc 4,18,.L65
	mr 3,27
	bl FindItem
	mr. 29,3
	bc 4,2,.L105
	lis 9,gi@ha
	li 3,1
	la 31,gi@l(9)
	lwz 9,160(31)
	mtlr 9
	blrl
	bl FindItem
	mr. 29,3
	bc 4,2,.L106
	lwz 0,4(31)
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	b .L117
.L106:
	lwz 0,56(29)
	andi. 9,0,67
	bc 12,2,.L65
.L105:
	lwz 11,56(29)
	andi. 10,11,67
	bc 12,2,.L65
	lwz 0,4(29)
	cmpwi 0,0,0
	bc 4,2,.L109
	lis 9,gi+4@ha
	lis 3,.LC12@ha
	lwz 0,gi+4@l(9)
	la 3,.LC12@l(3)
.L117:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L65
.L109:
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,29
	andi. 10,11,2
	mullw 9,9,0
	srawi 10,9,3
	bc 12,2,.L110
	lwz 9,84(28)
	slwi 10,10,2
	lwz 11,48(29)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L65
.L110:
	andi. 0,11,64
	bc 12,2,.L112
	lwz 7,84(28)
	lis 8,0x4330
	stw 29,656(1)
	lis 9,.LC14@ha
	lwz 0,4312(7)
	la 9,.LC14@l(9)
	lfd 13,0(9)
	xoris 0,0,0x8000
	lis 9,unique_items@ha
	stw 0,1028(1)
	stw 8,1024(1)
	lfd 0,1024(1)
	lwz 10,unique_items@l(9)
	fsub 0,0,13
	lfs 12,20(10)
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L113
	lis 10,.LC15@ha
	mr 9,11
	la 10,.LC15@l(10)
	lfs 0,0(10)
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,1024(1)
	lwz 9,1028(1)
	stw 9,4312(7)
.L113:
	mr 4,28
	addi 3,1,8
	bl Pickup_Special
	b .L65
.L112:
	bl G_Spawn
	lwz 0,0(29)
	mr 31,3
	mr 4,29
	stw 0,280(31)
	bl SpawnItem
	mr 4,28
	mr 3,31
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L65
	mr 3,31
	bl G_FreeEdict
.L65:
	lwz 0,1092(1)
	lwz 12,1036(1)
	mtlr 0
	lmw 24,1040(1)
	lfd 30,1072(1)
	lfd 31,1080(1)
	mtcrf 8,12
	la 1,1088(1)
	blr
.Lfe2:
	.size	 Cmd_Give_f,.Lfe2-Cmd_Give_f
	.section	".rodata"
	.align 2
.LC16:
	.string	"godmode OFF\n"
	.align 2
.LC17:
	.string	"godmode ON\n"
	.align 2
.LC18:
	.string	"notarget OFF\n"
	.align 2
.LC19:
	.string	"notarget ON\n"
	.align 2
.LC20:
	.string	"noclip OFF\n"
	.align 2
.LC21:
	.string	"noclip ON\n"
	.align 2
.LC22:
	.string	"special"
	.align 2
.LC23:
	.string	"blaster"
	.align 2
.LC24:
	.string	"mark 23 pistol"
	.align 2
.LC25:
	.string	"MK23 Pistol"
	.align 2
.LC26:
	.string	"A 2nd pistol"
	.align 2
.LC27:
	.string	"railgun"
	.align 2
.LC28:
	.string	"Dual MK23 Pistols"
	.align 2
.LC29:
	.string	"shotgun"
	.align 2
.LC30:
	.string	"M3 Super 90 Assault Shotgun"
	.align 2
.LC31:
	.string	"machinegun"
	.align 2
.LC32:
	.string	"Handcannon"
	.align 2
.LC33:
	.string	"super shotgun"
	.align 2
.LC34:
	.string	"MP5/10 Submachinegun"
	.align 2
.LC35:
	.string	"chaingun"
	.align 2
.LC36:
	.string	"Sniper Rifle"
	.align 2
.LC37:
	.string	"bfg10k"
	.align 2
.LC38:
	.string	"Combat Knife"
	.align 2
.LC39:
	.string	"throwing combat knife"
	.align 2
.LC40:
	.string	"slashing combat knife"
	.align 2
.LC41:
	.string	"grenade launcher"
	.align 2
.LC42:
	.string	"M4 Assault Rifle"
	.align 2
.LC43:
	.string	"grenades"
	.align 2
.LC44:
	.string	"M26 Fragmentation Grenade"
	.align 2
.LC45:
	.string	"Unknown item: %s\n"
	.align 2
.LC46:
	.string	"Item is not usable.\n"
	.align 2
.LC47:
	.string	"Out of item: %s\n"
	.section	".text"
	.align 2
	.globl Cmd_Use_f
	.type	 Cmd_Use_f,@function
Cmd_Use_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi+164@ha
	mr 30,3
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 31,3
	lis 4,.LC22@ha
	la 4,.LC22@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L131
	mr 3,30
	bl ReadySpecialWeapon
	b .L130
.L131:
	lis 4,.LC23@ha
	mr 3,31
	la 4,.LC23@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L133
	lis 4,.LC24@ha
	mr 3,31
	la 4,.LC24@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L132
.L133:
	lis 9,.LC25@ha
	la 31,.LC25@l(9)
.L132:
	lis 4,.LC26@ha
	mr 3,31
	la 4,.LC26@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L135
	lis 4,.LC27@ha
	mr 3,31
	la 4,.LC27@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L134
.L135:
	lis 9,.LC28@ha
	la 31,.LC28@l(9)
.L134:
	lis 4,.LC29@ha
	mr 3,31
	la 4,.LC29@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L136
	lis 9,.LC30@ha
	la 31,.LC30@l(9)
.L136:
	lis 4,.LC31@ha
	mr 3,31
	la 4,.LC31@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L137
	lis 9,.LC32@ha
	la 31,.LC32@l(9)
.L137:
	lis 4,.LC33@ha
	mr 3,31
	la 4,.LC33@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L138
	lis 9,.LC34@ha
	la 31,.LC34@l(9)
.L138:
	lis 4,.LC35@ha
	mr 3,31
	la 4,.LC35@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L139
	lis 9,.LC36@ha
	la 31,.LC36@l(9)
.L139:
	lis 4,.LC37@ha
	mr 3,31
	la 4,.LC37@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L140
	lis 9,.LC38@ha
	la 31,.LC38@l(9)
.L140:
	lis 4,.LC39@ha
	mr 3,31
	la 4,.LC39@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L141
	lwz 9,84(30)
	lwz 0,4284(9)
	cmpwi 0,0,7
	bc 12,2,.L142
	li 0,1
	stw 0,3856(9)
	b .L143
.L142:
	mr 3,30
	bl Cmd_New_Weapon_f
.L143:
	lis 9,.LC38@ha
	la 31,.LC38@l(9)
.L141:
	lis 4,.LC40@ha
	mr 3,31
	la 4,.LC40@l(4)
	bl stricmp
	mr. 3,3
	bc 4,2,.L144
	lwz 9,84(30)
	lwz 0,4284(9)
	cmpwi 0,0,7
	bc 12,2,.L145
	stw 3,3856(9)
	b .L146
.L145:
	mr 3,30
	bl Cmd_New_Weapon_f
.L146:
	lis 9,.LC38@ha
	la 31,.LC38@l(9)
.L144:
	lis 4,.LC41@ha
	mr 3,31
	la 4,.LC41@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L147
	lis 9,.LC42@ha
	la 31,.LC42@l(9)
.L147:
	lis 4,.LC43@ha
	mr 3,31
	la 4,.LC43@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L148
	lis 9,.LC44@ha
	la 31,.LC44@l(9)
.L148:
	mr 3,31
	bl FindItem
	mr. 4,3
	bc 12,2,.L150
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 4,2,.L149
	lwz 0,492(30)
	cmpwi 0,0,2
	bc 12,2,.L149
.L150:
	lis 5,.LC45@ha
	mr 3,30
	la 5,.LC45@l(5)
	b .L153
.L149:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L151
	lis 5,.LC46@ha
	mr 3,30
	la 5,.LC46@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L130
.L151:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L152
	lis 5,.LC47@ha
	mr 3,30
	la 5,.LC47@l(5)
.L153:
	mr 6,31
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L130
.L152:
	mr 3,30
	mtlr 10
	blrl
.L130:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 Cmd_Use_f,.Lfe3-Cmd_Use_f
	.section	".rodata"
	.align 2
.LC48:
	.string	"weapon"
	.align 2
.LC49:
	.string	"item"
	.align 2
.LC50:
	.string	"unknown item: %s\n"
	.align 2
.LC51:
	.string	"Item is not dropable.\n"
	.align 2
.LC52:
	.string	"No item to use.\n"
	.section	".text"
	.align 2
	.globl Cmd_InvUse_f
	.type	 Cmd_InvUse_f,@function
Cmd_InvUse_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 7,84(3)
	lwz 0,4432(7)
	cmpwi 0,0,0
	bc 12,2,.L172
	bl PMenu_Select
	b .L171
.L189:
	stw 11,736(7)
	b .L175
.L172:
	lwz 0,248(3)
	cmpwi 7,0,0
	bc 4,30,.L173
	lwz 0,492(3)
	cmpwi 0,0,2
	bc 4,2,.L171
.L173:
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L175
	bc 4,30,.L178
	lwz 0,492(3)
	cmpwi 0,0,2
	bc 4,2,.L175
.L178:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L190:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L183
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L183
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L189
.L183:
	addi 8,8,1
	bdnz .L190
	li 0,-1
	stw 0,736(7)
.L175:
	lwz 9,84(3)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L187
	lis 5,.LC52@ha
	li 4,2
	la 5,.LC52@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L171
.L187:
	mulli 0,0,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L188
	lis 5,.LC46@ha
	li 4,2
	la 5,.LC46@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L171
.L188:
	mtlr 0
	blrl
.L171:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 Cmd_InvUse_f,.Lfe4-Cmd_InvUse_f
	.section	".rodata"
	.align 2
.LC53:
	.string	"No item to drop.\n"
	.section	".text"
	.align 2
	.globl Cmd_InvDrop_f
	.type	 Cmd_InvDrop_f,@function
Cmd_InvDrop_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,248(31)
	cmpwi 7,0,0
	bc 4,30,.L223
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 4,2,.L222
.L223:
	lwz 7,84(31)
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L225
	lwz 0,4432(7)
	cmpwi 0,0,0
	bc 12,2,.L226
	mr 3,31
	bl PMenu_Next
	b .L225
.L239:
	stw 11,736(7)
	b .L225
.L226:
	bc 4,30,.L228
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 4,2,.L225
.L228:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L240:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L233
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L233
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L239
.L233:
	addi 8,8,1
	bdnz .L240
	li 0,-1
	stw 0,736(7)
.L225:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L237
	lis 5,.LC53@ha
	mr 3,31
	la 5,.LC53@l(5)
	b .L241
.L237:
	mulli 0,0,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L238
	lis 5,.LC51@ha
	mr 3,31
	la 5,.LC51@l(5)
.L241:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L222
.L238:
	mr 3,31
	mtlr 0
	blrl
.L222:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_InvDrop_f,.Lfe5-Cmd_InvDrop_f
	.section	".rodata"
	.align 2
.LC54:
	.string	"%3i %s\n"
	.align 2
.LC55:
	.string	"%s\n"
	.align 2
.LC56:
	.string	"...\n"
	.align 2
.LC57:
	.string	"%s\n%i players\n"
	.align 2
.LC58:
	.long 0x0
	.align 3
.LC59:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_Players_f
	.type	 Cmd_Players_f,@function
Cmd_Players_f:
	stwu 1,-2448(1)
	mflr 0
	stfd 31,2440(1)
	stmw 20,2392(1)
	stw 0,2452(1)
	lis 11,.LC58@ha
	lis 9,maxclients@ha
	la 11,.LC58@l(11)
	mr 21,3
	lfs 13,0(11)
	li 27,0
	li 30,0
	lwz 11,maxclients@l(9)
	lis 20,teamplay@ha
	addi 28,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L253
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	addi 10,1,1352
	lis 9,.LC59@ha
	la 9,.LC59@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L255:
	lwz 0,0(11)
	addi 11,11,4564
	cmpwi 0,0,0
	bc 12,2,.L254
	stw 30,0(10)
	addi 27,27,1
	addi 10,10,4
.L254:
	addi 30,30,1
	lfs 13,20(8)
	xoris 0,30,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L255
.L253:
	lis 11,.LC58@ha
	lis 9,teamplay@ha
	la 11,.LC58@l(11)
	lfs 13,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L259
	lis 9,noscore@ha
	lwz 11,noscore@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L258
.L259:
	lis 6,PlayerSort@ha
	addi 3,1,1352
	la 6,PlayerSort@l(6)
	mr 4,27
	li 5,4
	bl qsort
.L258:
	li 30,0
	li 0,0
	cmpw 0,30,27
	stb 0,72(1)
	bc 4,0,.L261
	lis 11,.LC58@ha
	lis 9,game@ha
	la 11,.LC58@l(11)
	la 26,game@l(9)
	lfs 31,0(11)
	lis 22,noscore@ha
	addi 31,1,1352
	lis 23,.LC54@ha
	lis 25,.LC55@ha
	lis 24,.LC56@ha
.L263:
	lwz 9,teamplay@l(20)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L265
	lwz 9,noscore@l(22)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 4,2,.L264
.L265:
	lwz 7,0(31)
	addi 3,1,8
	li 4,64
	lwz 0,1028(26)
	la 5,.LC54@l(23)
	mulli 7,7,4564
	add 7,7,0
	lha 6,148(7)
	addi 7,7,700
	crxor 6,6,6
	bl Com_sprintf
	b .L266
.L264:
	lwz 0,0(31)
	addi 3,1,8
	li 4,64
	lwz 6,1028(26)
	la 5,.LC55@l(25)
	mulli 0,0,4564
	add 6,6,0
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L266:
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,28
	bl strlen
	add 29,29,3
	cmplwi 0,29,1180
	bc 4,1,.L267
	la 4,.LC56@l(24)
	mr 3,28
	bl strcat
	b .L261
.L267:
	mr 3,28
	addi 4,1,8
	bl strcat
	addi 30,30,1
	addi 31,31,4
	cmpw 0,30,27
	bc 12,0,.L263
.L261:
	lis 5,.LC57@ha
	mr 3,21
	la 5,.LC57@l(5)
	mr 6,28
	mr 7,27
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 0,2452(1)
	mtlr 0
	lmw 20,2392(1)
	lfd 31,2440(1)
	la 1,2448(1)
	blr
.Lfe6:
	.size	 Cmd_Players_f,.Lfe6-Cmd_Players_f
	.section	".rodata"
	.align 2
.LC60:
	.string	"flipoff\n"
	.align 2
.LC61:
	.string	"salute\n"
	.align 2
.LC62:
	.string	"taunt\n"
	.align 2
.LC63:
	.string	"wave\n"
	.align 2
.LC64:
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
	bc 4,2,.L269
	lwz 0,4120(9)
	cmpwi 0,0,1
	bc 12,1,.L269
	cmplwi 0,3,4
	li 0,1
	stw 0,4120(9)
	bc 12,1,.L278
	lis 11,.L279@ha
	slwi 10,3,2
	la 11,.L279@l(11)
	lis 9,.L279@ha
	lwzx 0,10,11
	la 9,.L279@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L279:
	.long .L273-.L279
	.long .L274-.L279
	.long .L275-.L279
	.long .L276-.L279
	.long .L278-.L279
.L273:
	lis 5,.LC60@ha
	mr 3,31
	la 5,.LC60@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 11,84(31)
	li 0,71
	li 9,83
	b .L280
.L274:
	lis 5,.LC61@ha
	mr 3,31
	la 5,.LC61@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 11,84(31)
	li 0,83
	li 9,94
	b .L280
.L275:
	lis 5,.LC62@ha
	mr 3,31
	la 5,.LC62@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 11,84(31)
	li 0,94
	li 9,111
	b .L280
.L276:
	lis 5,.LC63@ha
	mr 3,31
	la 5,.LC63@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 11,84(31)
	li 0,111
	li 9,122
	b .L280
.L278:
	lis 5,.LC64@ha
	mr 3,31
	la 5,.LC64@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 11,84(31)
	li 0,122
	li 9,134
.L280:
	stw 0,56(31)
	stw 9,4116(11)
.L269:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 Cmd_Wave_f,.Lfe7-Cmd_Wave_f
	.section	".rodata"
	.align 2
.LC65:
	.string	"You're not on a team.\n"
	.align 2
.LC66:
	.string	"%s(%s): "
	.align 2
.LC67:
	.string	"[DEAD] "
	.align 2
.LC68:
	.string	""
	.align 2
.LC69:
	.string	"You don't have a partner.\n"
	.align 2
.LC70:
	.string	"[%sPARTNER] %s: "
	.align 2
.LC71:
	.string	"DEAD "
	.align 2
.LC72:
	.string	"%s%s: "
	.align 2
.LC73:
	.string	" "
	.align 2
.LC74:
	.string	"\n"
	.align 2
.LC75:
	.string	"You can't talk for %d more seconds.\n"
	.align 2
.LC76:
	.string	"You can't talk for %d seconds.\n"
	.align 2
.LC77:
	.string	"%s"
	.align 2
.LC78:
	.long 0x0
	.align 3
.LC79:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC80:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Cmd_Say_f
	.type	 Cmd_Say_f,@function
Cmd_Say_f:
	stwu 1,-2112(1)
	mflr 0
	mfcr 12
	stfd 31,2104(1)
	stmw 23,2068(1)
	stw 0,2116(1)
	stw 12,2064(1)
	lis 9,gi+156@ha
	mr 31,3
	lwz 0,gi+156@l(9)
	mr 29,4
	mr 30,5
	mr 27,6
	mtlr 0
	blrl
	cmpwi 0,3,1
	bc 12,1,.L282
	cmpwi 0,30,0
	bc 12,2,.L281
.L282:
	lis 11,.LC78@ha
	lis 9,teamplay@ha
	la 11,.LC78@l(11)
	lis 23,teamplay@ha
	lfs 13,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 7,0,13
	bc 4,30,.L283
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,2056(1)
	lwz 9,2060(1)
	rlwinm 9,9,0,24,25
	neg 9,9
	srawi 9,9,31
	and 29,29,9
.L283:
	cmpwi 3,29,0
	bc 12,14,.L285
	lwz 9,84(31)
	lwz 0,3488(9)
	mr 7,9
	cmpwi 0,0,0
	bc 4,2,.L286
	lis 5,.LC65@ha
	mr 3,31
	la 5,.LC65@l(5)
	b .L324
.L286:
	bc 12,30,.L287
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L289
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 4,2,.L287
.L289:
	lis 9,.LC67@ha
	la 6,.LC67@l(9)
	b .L288
.L287:
	lis 9,.LC68@ha
	la 6,.LC68@l(9)
.L288:
	lis 5,.LC66@ha
	addi 7,7,700
	la 5,.LC66@l(5)
	b .L325
.L285:
	cmpwi 0,27,0
	bc 12,2,.L291
	lwz 9,84(31)
	lwz 0,3816(9)
	mr 7,9
	cmpwi 0,0,0
	bc 4,2,.L292
	lis 5,.LC69@ha
	mr 3,31
	la 5,.LC69@l(5)
.L324:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L281
.L292:
	bc 12,30,.L293
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L295
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 4,2,.L293
.L295:
	lis 9,.LC71@ha
	la 6,.LC71@l(9)
	b .L294
.L293:
	lis 9,.LC68@ha
	la 6,.LC68@l(9)
.L294:
	lis 5,.LC70@ha
	addi 7,7,700
	la 5,.LC70@l(5)
.L325:
	addi 3,1,8
	li 4,2048
	crxor 6,6,6
	bl Com_sprintf
	b .L290
.L291:
	bc 12,30,.L297
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L299
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 4,2,.L297
.L299:
	lis 9,.LC67@ha
	la 6,.LC67@l(9)
	b .L298
.L297:
	lis 9,.LC68@ha
	la 6,.LC68@l(9)
.L298:
	lwz 7,84(31)
	lis 5,.LC72@ha
	addi 3,1,8
	la 5,.LC72@l(5)
	li 4,2048
	addi 7,7,700
	crxor 6,6,6
	bl Com_sprintf
.L290:
	addi 3,1,8
	bl strlen
	cmpwi 0,30,0
	mr 28,3
	bc 12,2,.L300
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC73@ha
	addi 3,1,8
	la 4,.LC73@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L301
.L300:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L302
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 30,-1(3)
.L302:
	mr 4,29
	addi 3,1,8
	bl strcat
.L301:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,300
	bc 4,1,.L303
	li 0,0
	stb 0,308(1)
.L303:
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L304
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L304
	addi 4,1,8
	mr 3,31
	add 4,4,28
	bl ParseSayText
.L304:
	lis 4,.LC74@ha
	addi 3,1,8
	la 4,.LC74@l(4)
	bl strcat
	lis 9,.LC78@ha
	la 9,.LC78@l(9)
	lfs 8,0(9)
	lis 9,flood_msgs@ha
	lwz 11,flood_msgs@l(9)
	lfs 9,20(11)
	fcmpu 0,9,8
	bc 12,2,.L305
	lwz 7,84(31)
	lis 9,level+4@ha
	lfs 10,level+4@l(9)
	lfs 0,4168(7)
	fcmpu 0,10,0
	bc 4,0,.L306
	fsubs 0,0,10
	lis 5,.LC75@ha
	mr 3,31
	la 5,.LC75@l(5)
	li 4,2
	fctiwz 13,0
	stfd 13,2056(1)
	b .L326
.L306:
	lwz 0,4212(7)
	lis 10,0x4330
	lis 11,.LC79@ha
	addi 8,7,4172
	mr 6,0
	la 11,.LC79@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,2060(1)
	lis 11,.LC80@ha
	stw 10,2056(1)
	la 11,.LC80@l(11)
	lfd 0,2056(1)
	mr 10,8
	lfs 11,0(11)
	mr 11,9
	fsub 0,0,13
	frsp 0,0
	fsubs 0,0,9
	fadds 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,2056(1)
	lwz 11,2060(1)
	nor 0,11,11
	addi 9,11,10
	srawi 0,0,31
	andc 9,9,0
	and 11,11,0
	or 11,11,9
	slwi 11,11,2
	lfsx 0,8,11
	fcmpu 0,0,8
	bc 12,2,.L308
	lis 11,flood_persecond@ha
	fsubs 13,10,0
	lwz 9,flood_persecond@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L308
	lis 9,flood_waitdelay@ha
	lwz 11,flood_waitdelay@l(9)
	lis 5,.LC76@ha
	mr 3,31
	la 5,.LC76@l(5)
	li 4,2
	lfs 13,20(11)
	fadds 13,10,13
	stfs 13,4168(7)
	lfs 0,20(11)
	fctiwz 12,0
	stfd 12,2056(1)
.L326:
	lwz 6,2060(1)
	crxor 6,6,6
	bl safe_cprintf
	b .L281
.L308:
	lis 0,0xcccc
	addi 9,6,1
	ori 0,0,52429
	lis 11,level+4@ha
	mulhwu 0,9,0
	srwi 0,0,3
	mulli 0,0,10
	subf 9,0,9
	stw 9,4212(7)
	lfs 0,level+4@l(11)
	slwi 9,9,2
	stfsx 0,10,9
.L305:
	lis 9,.LC78@ha
	lis 11,dedicated@ha
	la 9,.LC78@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L309
	lis 5,.LC77@ha
	li 3,0
	la 5,.LC77@l(5)
	li 4,3
	addi 6,1,8
	crxor 6,6,6
	bl safe_cprintf
.L309:
	lis 9,game+1544@ha
	li 30,1
	lwz 0,game+1544@l(9)
	lis 24,game@ha
	cmpw 0,30,0
	bc 12,1,.L281
	lis 9,.LC78@ha
	cmpwi 4,27,0
	la 9,.LC78@l(9)
	lis 25,g_edicts@ha
	lfs 31,0(9)
	li 28,996
	lis 26,team_round_going@ha
	lis 27,.LC77@ha
.L313:
	lwz 0,g_edicts@l(25)
	add 29,0,28
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L312
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L312
	bc 12,14,.L316
	mr 3,31
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L312
.L316:
	bc 12,18,.L318
	lwz 11,84(31)
	xor 9,29,31
	addic 0,9,-1
	subfe 10,0,9
	lwz 0,3816(11)
	xor 0,29,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 4,2,.L312
.L318:
	lwz 9,teamplay@l(23)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L320
	lwz 0,team_round_going@l(26)
	cmpwi 0,0,0
	bc 12,2,.L320
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L322
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 4,2,.L320
.L322:
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 12,2,.L320
	lwz 0,492(29)
	cmpwi 0,0,2
	bc 4,2,.L312
.L320:
	mr 3,29
	li 4,3
	la 5,.LC77@l(27)
	addi 6,1,8
	crxor 6,6,6
	bl safe_cprintf
.L312:
	la 9,game@l(24)
	addi 30,30,1
	lwz 0,1544(9)
	addi 28,28,996
	cmpw 0,30,0
	bc 4,1,.L313
.L281:
	lwz 0,2116(1)
	lwz 12,2064(1)
	mtlr 0
	lmw 23,2068(1)
	lfd 31,2104(1)
	mtcrf 24,12
	la 1,2112(1)
	blr
.Lfe8:
	.size	 Cmd_Say_f,.Lfe8-Cmd_Say_f
	.section	".rodata"
	.align 2
.LC81:
	.string	"%02d:%02d %4d %3d %s%s\n"
	.align 2
.LC82:
	.string	" (spectator)"
	.align 2
.LC83:
	.string	"%02d:%02d %4d %s%s\n"
	.align 2
.LC84:
	.long 0x0
	.align 3
.LC85:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_PlayerList_f
	.type	 Cmd_PlayerList_f,@function
Cmd_PlayerList_f:
	stwu 1,-1456(1)
	mflr 0
	stmw 17,1396(1)
	stw 0,1460(1)
	lis 9,maxclients@ha
	li 0,0
	lwz 11,maxclients@l(9)
	lis 10,g_edicts@ha
	mr 26,3
	lis 9,.LC84@ha
	stb 0,96(1)
	li 25,0
	la 9,.LC84@l(9)
	lfs 0,20(11)
	lis 18,maxclients@ha
	lfs 13,0(9)
	addi 30,1,96
	lis 17,.LC77@ha
	lwz 9,g_edicts@l(10)
	fcmpu 0,13,0
	addi 31,9,996
	bc 4,0,.L329
	lis 27,0x1b4e
	lis 28,0x6666
	lis 22,.LC82@ha
	lis 23,.LC68@ha
	la 19,.LC82@l(22)
	la 20,.LC68@l(23)
	lis 24,level@ha
	ori 27,27,33205
	ori 28,28,26215
	lis 21,0x4330
.L331:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L330
	lis 9,teamplay@ha
	lis 10,.LC84@ha
	lwz 11,teamplay@l(9)
	la 10,.LC84@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L334
	lis 9,noscore@ha
	lwz 11,noscore@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L333
.L334:
	lwz 9,84(31)
	lwz 11,level@l(24)
	lwz 0,3436(9)
	addi 29,9,700
	lwz 4,184(9)
	subf 11,0,11
	lwz 3,3440(9)
	mulhw 9,11,27
	srawi 10,11,31
	lwz 8,248(31)
	srawi 9,9,6
	cmpwi 0,8,0
	subf 6,10,9
	mulli 0,6,600
	subf 11,0,11
	mulhw 9,11,28
	srawi 11,11,31
	srawi 9,9,2
	subf 7,11,9
	bc 4,2,.L335
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L335
	stw 19,8(1)
	b .L336
.L335:
	stw 20,8(1)
.L336:
	lis 5,.LC81@ha
	mr 8,4
	mr 9,3
	la 5,.LC81@l(5)
	mr 10,29
	addi 3,1,16
	li 4,80
	crxor 6,6,6
	bl Com_sprintf
	b .L337
.L333:
	lwz 9,84(31)
	lwz 11,level@l(24)
	lwz 0,3436(9)
	addi 3,9,700
	lwz 4,184(9)
	subf 11,0,11
	lwz 8,248(31)
	mulhw 9,11,27
	srawi 10,11,31
	cmpwi 0,8,0
	srawi 9,9,6
	subf 6,10,9
	mulli 0,6,600
	subf 11,0,11
	mulhw 9,11,28
	srawi 11,11,31
	srawi 9,9,2
	subf 7,11,9
	bc 4,2,.L338
	lwz 0,492(31)
	cmpwi 0,0,2
	la 10,.LC82@l(22)
	bc 4,2,.L339
.L338:
	la 10,.LC68@l(23)
.L339:
	lis 5,.LC83@ha
	mr 8,4
	mr 9,3
	la 5,.LC83@l(5)
	addi 3,1,16
	li 4,80
	crxor 6,6,6
	bl Com_sprintf
.L337:
	mr 3,30
	bl strlen
	mr 29,3
	addi 3,1,16
	bl strlen
	add 29,29,3
	cmplwi 0,29,1180
	bc 4,1,.L340
	mr 3,30
	bl strlen
	lis 4,.LC56@ha
	add 3,30,3
	la 4,.LC56@l(4)
	crxor 6,6,6
	bl sprintf
	mr 3,26
	la 5,.LC77@l(17)
	mr 6,30
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L327
.L340:
	mr 3,30
	addi 4,1,16
	bl strcat
.L330:
	addi 25,25,1
	lwz 11,maxclients@l(18)
	xoris 0,25,0x8000
	lis 10,.LC85@ha
	stw 0,1388(1)
	la 10,.LC85@l(10)
	addi 31,31,996
	stw 21,1384(1)
	lfd 13,0(10)
	lfd 0,1384(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L331
.L329:
	lis 5,.LC77@ha
	mr 3,26
	la 5,.LC77@l(5)
	mr 6,30
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L327:
	lwz 0,1460(1)
	mtlr 0
	lmw 17,1396(1)
	la 1,1456(1)
	blr
.Lfe9:
	.size	 Cmd_PlayerList_f,.Lfe9-Cmd_PlayerList_f
	.section	".rodata"
	.align 2
.LC86:
	.string	"players"
	.align 2
.LC87:
	.string	"say"
	.align 2
.LC88:
	.string	"say_team"
	.align 2
.LC89:
	.string	"score"
	.align 2
.LC90:
	.string	"help"
	.align 2
.LC91:
	.string	"use"
	.align 2
.LC92:
	.string	"drop"
	.align 2
.LC93:
	.string	"give"
	.align 2
.LC94:
	.string	"god"
	.align 2
.LC95:
	.string	"notarget"
	.align 2
.LC96:
	.string	"noclip"
	.align 2
.LC97:
	.string	"inven"
	.align 2
.LC98:
	.string	"invnext"
	.align 2
.LC99:
	.string	"invprev"
	.align 2
.LC100:
	.string	"invnextw"
	.align 2
.LC101:
	.string	"invprevw"
	.align 2
.LC102:
	.string	"invnextp"
	.align 2
.LC103:
	.string	"invprevp"
	.align 2
.LC104:
	.string	"invuse"
	.align 2
.LC105:
	.string	"invdrop"
	.align 2
.LC106:
	.string	"weapprev"
	.align 2
.LC107:
	.string	"weapnext"
	.align 2
.LC108:
	.string	"weaplast"
	.align 2
.LC109:
	.string	"kill"
	.align 2
.LC110:
	.string	"putaway"
	.align 2
.LC111:
	.string	"wave"
	.align 2
.LC112:
	.string	"reload"
	.align 2
.LC113:
	.string	"opendoor"
	.align 2
.LC114:
	.string	"bandage"
	.align 2
.LC115:
	.string	"id"
	.align 2
.LC116:
	.string	"irvision"
	.align 2
.LC117:
	.string	"playerlist"
	.align 2
.LC118:
	.string	"team"
	.align 2
.LC119:
	.string	"radio"
	.align 2
.LC120:
	.string	"radiogender"
	.align 2
.LC121:
	.string	"radio_power"
	.align 2
.LC122:
	.string	"radiopartner"
	.align 2
.LC123:
	.string	"radioteam"
	.align 2
.LC124:
	.string	"channel"
	.align 2
.LC125:
	.string	"say_partner"
	.align 2
.LC126:
	.string	"partner"
	.align 2
.LC127:
	.string	"unpartner"
	.align 2
.LC128:
	.string	"motd"
	.align 2
.LC129:
	.string	"deny"
	.align 2
.LC130:
	.string	"choose"
	.align 2
.LC131:
	.long 0x0
	.align 2
.LC132:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl ClientCommand
	.type	 ClientCommand,@function
ClientCommand:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 25,12(1)
	stw 0,52(1)
	mr 29,3
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L342
	bl ACECM_Commands
	cmpwi 0,3,0
	bc 4,2,.L342
	lis 9,gi@ha
	li 3,0
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC86@ha
	la 4,.LC86@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L345
	mr 3,29
	bl Cmd_Players_f
	b .L342
.L345:
	lis 4,.LC87@ha
	mr 3,31
	la 4,.LC87@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L346
	mr 3,29
	li 4,0
	b .L577
.L346:
	lis 4,.LC88@ha
	mr 3,31
	la 4,.LC88@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L347
	mr 3,29
	li 4,1
.L577:
	li 5,0
	li 6,0
	bl Cmd_Say_f
	b .L342
.L347:
	lis 4,.LC89@ha
	mr 3,31
	la 4,.LC89@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L348
	mr 3,29
	bl Cmd_Score_f
	b .L342
.L348:
	lis 4,.LC90@ha
	mr 3,31
	la 4,.LC90@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L349
	mr 3,29
	bl Cmd_Help_f
	b .L342
.L349:
	lis 8,.LC131@ha
	lis 9,level+200@ha
	la 8,.LC131@l(8)
	lfs 0,level+200@l(9)
	lfs 31,0(8)
	fcmpu 0,0,31
	bc 4,2,.L342
	lis 4,.LC91@ha
	mr 3,31
	la 4,.LC91@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L351
	mr 3,29
	bl Cmd_Use_f
	b .L342
.L351:
	lis 4,.LC92@ha
	mr 3,31
	la 4,.LC92@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L353
	lwz 0,164(30)
	mtlr 0
	blrl
	mr 31,3
	lis 4,.LC48@ha
	la 4,.LC48@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L354
	mr 3,29
	bl DropSpecialWeapon
	b .L342
.L354:
	lis 4,.LC49@ha
	mr 3,31
	la 4,.LC49@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L356
	mr 3,29
	bl DropSpecialItem
	b .L342
.L356:
	mr 3,31
	bl FindItem
	mr. 4,3
	bc 4,2,.L357
	lis 5,.LC50@ha
	mr 3,29
	la 5,.LC50@l(5)
	b .L578
.L357:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L358
	lis 5,.LC51@ha
	mr 3,29
	la 5,.LC51@l(5)
	b .L579
.L358:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L359
	lis 5,.LC47@ha
	mr 3,29
	la 5,.LC47@l(5)
.L578:
	mr 6,31
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L342
.L359:
	mr 3,29
	mtlr 10
	blrl
	b .L342
.L353:
	lis 4,.LC93@ha
	mr 3,31
	la 4,.LC93@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L361
	mr 3,29
	bl Cmd_Give_f
	b .L342
.L361:
	lis 4,.LC94@ha
	mr 3,31
	la 4,.LC94@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L363
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L364
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L364
	lis 5,.LC2@ha
	mr 3,29
	la 5,.LC2@l(5)
	b .L579
.L364:
	lwz 0,264(29)
	xori 0,0,16
	andi. 8,0,16
	stw 0,264(29)
	bc 4,2,.L366
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L379
.L366:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
	b .L379
.L363:
	lis 4,.LC95@ha
	mr 3,31
	la 4,.LC95@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L369
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L370
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L370
	lis 5,.LC2@ha
	mr 3,29
	la 5,.LC2@l(5)
	b .L579
.L370:
	lwz 0,264(29)
	xori 0,0,32
	andi. 8,0,32
	stw 0,264(29)
	bc 4,2,.L372
	lis 9,.LC18@ha
	la 5,.LC18@l(9)
	b .L379
.L372:
	lis 9,.LC19@ha
	la 5,.LC19@l(9)
	b .L379
.L369:
	lis 4,.LC96@ha
	mr 3,31
	la 4,.LC96@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L375
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L376
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L376
	lis 5,.LC2@ha
	mr 3,29
	la 5,.LC2@l(5)
	b .L579
.L376:
	lwz 0,260(29)
	cmpwi 0,0,1
	bc 4,2,.L378
	li 0,4
	lis 9,.LC20@ha
	stw 0,260(29)
	la 5,.LC20@l(9)
	b .L379
.L378:
	li 0,1
	lis 9,.LC21@ha
	stw 0,260(29)
	la 5,.LC21@l(9)
.L379:
	mr 3,29
.L579:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L342
.L375:
	lis 4,.LC97@ha
	mr 3,31
	la 4,.LC97@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L381
	lwz 31,84(29)
	stw 3,3928(31)
	stw 3,3912(31)
	lwz 10,84(29)
	lwz 9,4432(10)
	cmpwi 0,9,0
	bc 4,2,.L580
	lwz 0,3924(31)
	cmpwi 0,0,0
	bc 12,2,.L384
	stw 9,3924(31)
	b .L342
.L384:
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L385
	lwz 0,3488(10)
	cmpwi 0,0,0
	bc 4,2,.L386
	mr 3,29
	bl OpenJoinMenu
	b .L342
.L386:
	mr 3,29
	bl OpenWeaponMenu
	b .L342
.L385:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3924(31)
	li 3,5
	lwz 0,100(9)
	addi 30,31,1760
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L390:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,30
	bc 4,1,.L390
	lis 9,gi+92@ha
	mr 3,29
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L342
.L381:
	lis 4,.LC98@ha
	mr 3,31
	la 4,.LC98@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L394
	lwz 8,84(29)
	lwz 0,4432(8)
	cmpwi 0,0,0
	bc 4,2,.L581
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 4,2,.L397
	lwz 0,492(29)
	cmpwi 0,0,2
	bc 4,2,.L342
.L397:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L576:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L402
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L402
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L569
.L402:
	addi 7,7,1
	bdnz .L576
	b .L582
.L394:
	lis 4,.LC99@ha
	mr 3,31
	la 4,.LC99@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L407
	lwz 7,84(29)
	lwz 0,4432(7)
	cmpwi 0,0,0
	bc 4,2,.L583
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 4,2,.L410
	lwz 0,492(29)
	cmpwi 0,0,2
	bc 4,2,.L342
.L410:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L575:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L415
	mulli 0,8,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L415
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L570
.L415:
	addi 11,11,-1
	bdnz .L575
	b .L584
.L407:
	lis 4,.LC100@ha
	mr 3,31
	la 4,.LC100@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L420
	lwz 8,84(29)
	lwz 0,4432(8)
	cmpwi 0,0,0
	bc 4,2,.L581
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 4,2,.L423
	lwz 0,492(29)
	cmpwi 0,0,2
	bc 4,2,.L342
.L423:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L574:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L428
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L428
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L569
.L428:
	addi 7,7,1
	bdnz .L574
	b .L582
.L420:
	lis 4,.LC101@ha
	mr 3,31
	la 4,.LC101@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L433
	lwz 7,84(29)
	lwz 0,4432(7)
	cmpwi 0,0,0
	bc 4,2,.L583
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 4,2,.L436
	lwz 0,492(29)
	cmpwi 0,0,2
	bc 4,2,.L342
.L436:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L573:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L441
	mulli 0,8,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L441
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L570
.L441:
	addi 11,11,-1
	bdnz .L573
	b .L584
.L433:
	lis 4,.LC102@ha
	mr 3,31
	la 4,.LC102@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L446
	lwz 8,84(29)
	lwz 0,4432(8)
	cmpwi 0,0,0
	bc 12,2,.L447
.L581:
	mr 3,29
	bl PMenu_Next
	b .L342
.L447:
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 4,2,.L449
	lwz 0,492(29)
	cmpwi 0,0,2
	bc 4,2,.L342
.L449:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L572:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L454
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L454
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L569
.L454:
	addi 7,7,1
	bdnz .L572
.L582:
	li 0,-1
	stw 0,736(8)
	b .L342
.L446:
	lis 4,.LC103@ha
	mr 3,31
	la 4,.LC103@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L459
	lwz 7,84(29)
	lwz 0,4432(7)
	cmpwi 0,0,0
	bc 12,2,.L460
.L583:
	mr 3,29
	bl PMenu_Prev
	b .L342
.L460:
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 4,2,.L462
	lwz 0,492(29)
	cmpwi 0,0,2
	bc 4,2,.L342
.L462:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L571:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L467
	mulli 0,8,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L467
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L570
.L467:
	addi 11,11,-1
	bdnz .L571
.L584:
	li 0,-1
	stw 0,736(7)
	b .L342
.L459:
	lis 4,.LC104@ha
	mr 3,31
	la 4,.LC104@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L472
	mr 3,29
	bl Cmd_InvUse_f
	b .L342
.L472:
	lis 4,.LC105@ha
	mr 3,31
	la 4,.LC105@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L474
	mr 3,29
	bl Cmd_InvDrop_f
	b .L342
.L474:
	lis 4,.LC106@ha
	mr 3,31
	la 4,.LC106@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L476
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 4,2,.L477
	lwz 0,492(29)
	cmpwi 0,0,2
	bc 4,2,.L342
.L477:
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L342
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,28,740
	mullw 9,9,0
	srawi 27,9,3
.L482:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L484
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L484
	lwz 0,56(31)
	andi. 8,0,1
	bc 12,2,.L484
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L342
.L484:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L482
	b .L342
.L476:
	lis 4,.LC107@ha
	mr 3,31
	la 4,.LC107@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L490
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 4,2,.L491
	lwz 0,492(29)
	cmpwi 0,0,2
	bc 4,2,.L342
.L491:
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L342
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	mr 25,9
	li 27,1
	subf 9,9,11
	addi 26,28,740
	mullw 9,9,0
	srawi 9,9,3
	addi 30,9,255
.L496:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L498
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L498
	lwz 0,56(31)
	andi. 8,0,1
	bc 12,2,.L498
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L342
.L498:
	addi 27,27,1
	addi 30,30,-1
	cmpwi 0,27,256
	bc 4,1,.L496
	b .L342
.L490:
	lis 4,.LC108@ha
	mr 3,31
	la 4,.LC108@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L504
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 4,2,.L505
	lwz 0,492(29)
	cmpwi 0,0,2
	bc 4,2,.L342
.L505:
	lwz 10,84(29)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L342
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L342
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 4,itemlist@l(11)
	ori 9,9,36409
	subf 0,4,0
	addi 11,10,740
	mullw 0,0,9
	srawi 10,0,3
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L342
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L342
	lwz 0,56(4)
	andi. 8,0,1
	bc 12,2,.L342
	mr 3,29
	mtlr 9
	blrl
	b .L342
.L504:
	lis 4,.LC109@ha
	mr 3,31
	la 4,.LC109@l(4)
	bl Q_stricmp
	mr. 10,3
	bc 4,2,.L513
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 12,2,.L342
	lwz 0,492(29)
	cmpwi 0,0,2
	bc 12,2,.L342
	lwz 11,84(29)
	lis 9,level+4@ha
	lis 8,.LC132@ha
	lfs 0,level+4@l(9)
	la 8,.LC132@l(8)
	lfs 13,4216(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L342
	lwz 0,264(29)
	mr 3,29
	lis 11,meansOfDeath@ha
	stw 10,480(29)
	li 9,23
	lis 6,0x1
	rlwinm 0,0,0,28,26
	lis 7,vec3_origin@ha
	stw 0,264(29)
	la 7,vec3_origin@l(7)
	mr 4,3
	stw 9,meansOfDeath@l(11)
	mr 5,3
	ori 6,6,34464
	bl player_die
	b .L342
.L513:
	lis 4,.LC110@ha
	mr 3,31
	la 4,.LC110@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L519
	lwz 9,84(29)
	stw 3,3912(9)
	lwz 11,84(29)
	stw 3,3928(11)
	lwz 9,84(29)
	stw 3,3924(9)
	lwz 11,84(29)
	lwz 0,4432(11)
	cmpwi 0,0,0
	bc 12,2,.L342
.L580:
	mr 3,29
	bl PMenu_Close
	b .L342
.L519:
	lis 4,.LC111@ha
	mr 3,31
	la 4,.LC111@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L523
	mr 3,29
	bl Cmd_Wave_f
	b .L342
.L523:
	lis 4,.LC112@ha
	mr 3,31
	la 4,.LC112@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L525
	mr 3,29
	bl Cmd_New_Reload_f
	b .L342
.L525:
	lis 4,.LC48@ha
	mr 3,31
	la 4,.LC48@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L527
	mr 3,29
	bl Cmd_New_Weapon_f
	b .L342
.L527:
	lis 4,.LC113@ha
	mr 3,31
	la 4,.LC113@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L529
	mr 3,29
	bl Cmd_OpenDoor_f
	b .L342
.L529:
	lis 4,.LC114@ha
	mr 3,31
	la 4,.LC114@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L531
	mr 3,29
	bl Cmd_Bandage_f
	b .L342
.L531:
	lis 4,.LC115@ha
	mr 3,31
	la 4,.LC115@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L533
	mr 3,29
	bl Cmd_ID_f
	b .L342
.L533:
	lis 4,.LC116@ha
	mr 3,31
	la 4,.LC116@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L535
	mr 3,29
	bl Cmd_IR_f
	b .L342
.L535:
	lis 4,.LC117@ha
	mr 3,31
	la 4,.LC117@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L537
	mr 3,29
	bl Cmd_PlayerList_f
	b .L342
.L537:
	lis 4,.LC118@ha
	mr 3,31
	la 4,.LC118@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L539
	lis 11,teamplay@ha
	lis 8,.LC131@ha
	lwz 9,teamplay@l(11)
	la 8,.LC131@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L539
	mr 3,29
	bl Team_f
	b .L342
.L539:
	lis 4,.LC119@ha
	mr 3,31
	la 4,.LC119@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L541
	mr 3,29
	bl Cmd_Radio_f
	b .L342
.L541:
	lis 4,.LC120@ha
	mr 3,31
	la 4,.LC120@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L543
	mr 3,29
	bl Cmd_Radiogender_f
	b .L342
.L543:
	lis 4,.LC121@ha
	mr 3,31
	la 4,.LC121@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L545
	mr 3,29
	bl Cmd_Radio_power_f
	b .L342
.L545:
	lis 4,.LC122@ha
	mr 3,31
	la 4,.LC122@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L547
	mr 3,29
	bl Cmd_Radiopartner_f
	b .L342
.L547:
	lis 4,.LC123@ha
	mr 3,31
	la 4,.LC123@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L549
	mr 3,29
	bl Cmd_Radioteam_f
	b .L342
.L549:
	lis 4,.LC124@ha
	mr 3,31
	la 4,.LC124@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L551
	mr 3,29
	bl Cmd_Channel_f
	b .L342
.L551:
	lis 4,.LC125@ha
	mr 3,31
	la 4,.LC125@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L553
	mr 3,29
	bl Cmd_Say_partner_f
	b .L342
.L553:
	lis 4,.LC126@ha
	mr 3,31
	la 4,.LC126@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L555
	mr 3,29
	bl Cmd_Partner_f
	b .L342
.L555:
	lis 4,.LC127@ha
	mr 3,31
	la 4,.LC127@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L557
	mr 3,29
	bl Cmd_Unpartner_f
	b .L342
.L557:
	lis 4,.LC128@ha
	mr 3,31
	la 4,.LC128@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L559
	mr 3,29
	bl PrintMOTD
	b .L342
.L559:
	lis 4,.LC129@ha
	mr 3,31
	la 4,.LC129@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L561
	mr 3,29
	bl Cmd_Deny_f
	b .L342
.L561:
	lis 4,.LC130@ha
	mr 3,31
	la 4,.LC130@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L563
	mr 3,29
	bl Cmd_Choose_f
	b .L342
.L569:
	stw 11,736(8)
	b .L342
.L570:
	stw 8,736(7)
	b .L342
.L563:
	mr 3,29
	li 4,0
	li 5,1
	li 6,0
	bl Cmd_Say_f
.L342:
	lwz 0,52(1)
	mtlr 0
	lmw 25,12(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 ClientCommand,.Lfe10-ClientCommand
	.align 2
	.globl ValidateSelectedItem
	.type	 ValidateSelectedItem,@function
ValidateSelectedItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 7,84(3)
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L52
	lwz 0,4432(7)
	cmpwi 0,0,0
	bc 12,2,.L54
	bl PMenu_Next
	b .L52
.L585:
	stw 11,736(7)
	b .L52
.L54:
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L56
	lwz 0,492(3)
	cmpwi 0,0,2
	bc 4,2,.L52
.L56:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L586:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L61
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L61
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L585
.L61:
	addi 8,8,1
	bdnz .L586
	li 0,-1
	stw 0,736(7)
.L52:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 ValidateSelectedItem,.Lfe11-ValidateSelectedItem
	.align 2
	.globl ClientTeam
	.type	 ClientTeam,@function
ClientTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 9,value.6@ha
	li 30,0
	stb 30,value.6@l(9)
	la 31,value.6@l(9)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L588
	lis 4,.LC0@ha
	addi 3,3,188
	la 4,.LC0@l(4)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L588
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L9
	addi 3,3,1
	b .L587
.L9:
	stb 30,0(3)
.L588:
	mr 3,31
.L587:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 ClientTeam,.Lfe12-ClientTeam
	.align 2
	.globl SelectNextItem
	.type	 SelectNextItem,@function
SelectNextItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 8,84(3)
	lwz 0,4432(8)
	cmpwi 0,0,0
	bc 12,2,.L31
	bl PMenu_Next
	b .L30
.L589:
	stw 11,736(8)
	b .L30
.L31:
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L32
	lwz 0,492(3)
	cmpwi 0,0,2
	bc 4,2,.L30
.L32:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 3,itemlist@l(9)
	addi 6,8,740
.L590:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L35
	mulli 0,11,72
	add 10,0,3
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L35
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L589
.L35:
	addi 7,7,1
	bdnz .L590
	li 0,-1
	stw 0,736(8)
.L30:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 SelectNextItem,.Lfe13-SelectNextItem
	.align 2
	.globl SelectPrevItem
	.type	 SelectPrevItem,@function
SelectPrevItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 7,84(3)
	lwz 0,4432(7)
	cmpwi 0,0,0
	bc 12,2,.L42
	bl PMenu_Prev
	b .L41
.L591:
	stw 8,736(7)
	b .L41
.L42:
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L43
	lwz 0,492(3)
	cmpwi 0,0,2
	bc 4,2,.L41
.L43:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L592:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L46
	mulli 0,8,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L46
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L591
.L46:
	addi 11,11,-1
	bdnz .L592
	li 0,-1
	stw 0,736(7)
.L41:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 SelectPrevItem,.Lfe14-SelectPrevItem
	.section	".rodata"
	.align 2
.LC133:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC133@ha
	lis 9,deathmatch@ha
	la 11,.LC133@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L119
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L119
	lis 5,.LC2@ha
	li 4,2
	la 5,.LC2@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L118
.L119:
	lwz 0,264(3)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(3)
	bc 4,2,.L120
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L121
.L120:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
.L121:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L118:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 Cmd_God_f,.Lfe15-Cmd_God_f
	.section	".rodata"
	.align 2
.LC134:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC134@ha
	lis 9,deathmatch@ha
	la 11,.LC134@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L123
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L123
	lis 5,.LC2@ha
	li 4,2
	la 5,.LC2@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L122
.L123:
	lwz 0,264(3)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(3)
	bc 4,2,.L124
	lis 9,.LC18@ha
	la 5,.LC18@l(9)
	b .L125
.L124:
	lis 9,.LC19@ha
	la 5,.LC19@l(9)
.L125:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L122:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 Cmd_Notarget_f,.Lfe16-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC135:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC135@ha
	lis 9,deathmatch@ha
	la 11,.LC135@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L127
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L127
	lis 5,.LC2@ha
	li 4,2
	la 5,.LC2@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L126
.L127:
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 4,2,.L128
	li 0,4
	lis 9,.LC20@ha
	stw 0,260(3)
	la 5,.LC20@l(9)
	b .L129
.L128:
	li 0,1
	lis 9,.LC21@ha
	stw 0,260(3)
	la 5,.LC21@l(9)
.L129:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L126:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 Cmd_Noclip_f,.Lfe17-Cmd_Noclip_f
	.align 2
	.globl Cmd_Drop_f
	.type	 Cmd_Drop_f,@function
Cmd_Drop_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi+164@ha
	mr 31,3
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 30,3
	lis 4,.LC48@ha
	la 4,.LC48@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L155
	mr 3,31
	bl DropSpecialWeapon
	b .L154
.L155:
	lis 4,.LC49@ha
	mr 3,30
	la 4,.LC49@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L156
	mr 3,31
	bl DropSpecialItem
	b .L154
.L156:
	mr 3,30
	bl FindItem
	mr. 4,3
	bc 4,2,.L157
	lis 5,.LC50@ha
	mr 3,31
	la 5,.LC50@l(5)
	b .L593
.L157:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L158
	lis 5,.LC51@ha
	mr 3,31
	la 5,.LC51@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L154
.L158:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L159
	lis 5,.LC47@ha
	mr 3,31
	la 5,.LC47@l(5)
.L593:
	mr 6,30
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L154
.L159:
	mr 3,31
	mtlr 10
	blrl
.L154:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe18:
	.size	 Cmd_Drop_f,.Lfe18-Cmd_Drop_f
	.section	".rodata"
	.align 2
.LC136:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Inven_f
	.type	 Cmd_Inven_f,@function
Cmd_Inven_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	li 0,0
	lwz 31,84(30)
	stw 0,3928(31)
	stw 0,3912(31)
	lwz 10,84(30)
	lwz 9,4432(10)
	cmpwi 0,9,0
	bc 12,2,.L161
	bl PMenu_Close
	b .L160
.L161:
	lwz 0,3924(31)
	cmpwi 0,0,0
	bc 12,2,.L162
	stw 9,3924(31)
	b .L160
.L162:
	lis 9,.LC136@ha
	lis 11,teamplay@ha
	la 9,.LC136@l(9)
	lfs 13,0(9)
	lwz 9,teamplay@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L163
	lwz 0,3488(10)
	cmpwi 0,0,0
	bc 4,2,.L164
	mr 3,30
	bl OpenJoinMenu
	b .L160
.L164:
	mr 3,30
	bl OpenWeaponMenu
	b .L160
.L163:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3924(31)
	li 3,5
	lwz 0,100(9)
	addi 29,31,1760
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L169:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,29
	bc 4,1,.L169
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L160:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 Cmd_Inven_f,.Lfe19-Cmd_Inven_f
	.align 2
	.globl Cmd_WeapPrev_f
	.type	 Cmd_WeapPrev_f,@function
Cmd_WeapPrev_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 29,3
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 4,2,.L192
	lwz 0,492(29)
	cmpwi 0,0,2
	bc 4,2,.L191
.L192:
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L191
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,28,740
	mullw 9,9,0
	srawi 27,9,3
.L197:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L196
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L196
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L196
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L191
.L196:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L197
.L191:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 Cmd_WeapPrev_f,.Lfe20-Cmd_WeapPrev_f
	.align 2
	.globl Cmd_WeapNext_f
	.type	 Cmd_WeapNext_f,@function
Cmd_WeapNext_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 29,3
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 4,2,.L204
	lwz 0,492(29)
	cmpwi 0,0,2
	bc 4,2,.L203
.L204:
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L203
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	mr 25,9
	li 27,1
	subf 9,9,11
	addi 26,28,740
	mullw 9,9,0
	srawi 9,9,3
	addi 30,9,255
.L209:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L208
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L208
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L208
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L203
.L208:
	addi 27,27,1
	addi 30,30,-1
	cmpwi 0,27,256
	bc 4,1,.L209
.L203:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe21:
	.size	 Cmd_WeapNext_f,.Lfe21-Cmd_WeapNext_f
	.align 2
	.globl Cmd_WeapLast_f
	.type	 Cmd_WeapLast_f,@function
Cmd_WeapLast_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L216
	lwz 0,492(3)
	cmpwi 0,0,2
	bc 4,2,.L215
.L216:
	lwz 10,84(3)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L215
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L215
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 4,itemlist@l(11)
	ori 9,9,36409
	subf 0,4,0
	addi 11,10,740
	mullw 0,0,9
	srawi 10,0,3
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L215
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L215
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L215
	mtlr 9
	blrl
.L215:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 Cmd_WeapLast_f,.Lfe22-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC137:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Cmd_Kill_f
	.type	 Cmd_Kill_f,@function
Cmd_Kill_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	lwz 0,248(10)
	cmpwi 0,0,0
	bc 12,2,.L242
	lwz 0,492(10)
	cmpwi 0,0,2
	bc 12,2,.L242
	lwz 11,84(10)
	lis 9,level+4@ha
	lis 8,.LC137@ha
	lfs 0,level+4@l(9)
	la 8,.LC137@l(8)
	lfs 13,4216(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L242
	lwz 0,264(10)
	li 9,0
	stw 9,480(10)
	lis 11,meansOfDeath@ha
	lis 6,0x1
	rlwinm 0,0,0,28,26
	li 9,23
	stw 0,264(10)
	lis 7,vec3_origin@ha
	mr 4,3
	stw 9,meansOfDeath@l(11)
	la 7,vec3_origin@l(7)
	mr 5,3
	ori 6,6,34464
	bl player_die
.L242:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 Cmd_Kill_f,.Lfe23-Cmd_Kill_f
	.align 2
	.globl Cmd_PutAway_f
	.type	 Cmd_PutAway_f,@function
Cmd_PutAway_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	li 0,0
	stw 0,3912(9)
	lwz 11,84(3)
	stw 0,3928(11)
	lwz 9,84(3)
	stw 0,3924(9)
	lwz 11,84(3)
	lwz 0,4432(11)
	cmpwi 0,0,0
	bc 12,2,.L247
	bl PMenu_Close
.L247:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 Cmd_PutAway_f,.Lfe24-Cmd_PutAway_f
	.align 2
	.globl PlayerSort
	.type	 PlayerSort,@function
PlayerSort:
	lwz 9,0(3)
	lis 11,game+1028@ha
	lwz 3,0(4)
	lwz 0,game+1028@l(11)
	mulli 9,9,4564
	mulli 11,3,4564
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
.Lfe25:
	.size	 PlayerSort,.Lfe25-PlayerSort
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
