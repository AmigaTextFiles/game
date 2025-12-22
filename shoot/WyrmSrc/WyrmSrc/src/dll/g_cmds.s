	.file	"g_cmds.c"
gcc2_compiled.:
	.lcomm	value.6,512,4
	.section	".rodata"
	.align 2
.LC0:
	.string	"skin"
	.section	".text"
	.align 2
	.globl OnSameTeam
	.type	 OnSameTeam,@function
OnSameTeam:
	stwu 1,-1072(1)
	mflr 0
	stmw 27,1052(1)
	stw 0,1076(1)
	lis 11,dmflags@ha
	lwz 10,dmflags@l(11)
	mr 28,4
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 9,1044(1)
	andi. 0,9,192
	bc 4,2,.L11
	li 3,0
	b .L21
.L11:
	lis 9,value.6@ha
	li 30,0
	stb 30,value.6@l(9)
	la 31,value.6@l(9)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L23
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
	bc 12,2,.L23
	lis 9,dmflags@ha
	lwz 11,dmflags@l(9)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 9,1044(1)
	andi. 0,9,128
	bc 12,2,.L15
	stb 30,0(3)
.L23:
	mr 3,31
	b .L13
.L15:
	addi 3,3,1
.L13:
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
	bc 12,2,.L25
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
	bc 12,2,.L25
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 11,1044(1)
	andi. 0,11,128
	bc 12,2,.L19
	stb 29,0(3)
.L25:
	mr 3,31
	b .L17
.L19:
	addi 3,3,1
.L17:
	mr 4,3
	mr 3,30
	bl strcpy
	mr 4,27
	addi 3,1,8
	bl strcmp
	subfic 0,3,0
	adde 3,0,3
.L21:
	lwz 0,1076(1)
	mtlr 0
	lmw 27,1052(1)
	la 1,1072(1)
	blr
.Lfe1:
	.size	 OnSameTeam,.Lfe1-OnSameTeam
	.section	".rodata"
	.align 2
.LC1:
	.string	"%s is not a weapon!\n"
	.align 2
.LC2:
	.string	"Out of weapon: %s\n"
	.align 2
.LC3:
	.string	"No %s for %s.\n"
	.align 2
.LC4:
	.string	"Not enough %s for %s.\n"
	.align 2
.LC5:
	.long 0x0
	.section	".text"
	.align 2
	.type	 Can_Use,@function
Can_Use:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr. 31,4
	mr 29,3
	mr 28,5
	bc 12,2,.L81
	lwz 11,84(29)
	lwz 0,1788(11)
	cmpw 0,31,0
	bc 12,2,.L81
	lwz 0,8(31)
	lis 9,Use_Weapon@ha
	la 9,Use_Weapon@l(9)
	cmpw 0,0,9
	bc 12,2,.L67
	cmpwi 0,28,0
	bc 12,2,.L81
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 6,40(31)
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L84
.L67:
	lis 9,itemlist@ha
	lis 30,0x3cf3
	la 27,itemlist@l(9)
	ori 30,30,53053
	subf 0,27,31
	addi 11,11,740
	mullw 0,0,30
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L69
	cmpwi 0,28,0
	bc 12,2,.L81
	lis 9,gi+8@ha
	lis 5,.LC2@ha
	lwz 6,40(31)
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC2@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L84
.L69:
	mr 3,29
	bl GetInitialWeapon
	cmpw 0,31,3
	li 3,1
	bc 12,2,.L82
	lwz 3,52(31)
	cmpwi 0,3,0
	bc 12,2,.L72
	lis 9,.LC5@ha
	lis 11,g_select_empty@ha
	la 9,.LC5@l(9)
	lfs 13,0(9)
	lwz 9,g_select_empty@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L72
	lwz 0,56(31)
	andi. 9,0,2
	bc 4,2,.L72
	bl FindItem
	subf 0,27,3
	lwz 9,84(29)
	mullw 0,0,30
	addi 9,9,740
	rlwinm 0,0,0,0,29
	lwzx 9,9,0
	cmpwi 0,9,0
	bc 4,2,.L73
	cmpwi 0,28,0
	bc 12,2,.L81
	lis 9,gi+8@ha
	lis 5,.LC3@ha
	lwz 6,40(3)
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC3@l(5)
	b .L85
.L73:
	lwz 0,48(31)
	cmpw 0,9,0
	bc 12,0,.L86
.L72:
	lwz 3,80(31)
	cmpwi 0,3,0
	bc 12,2,.L77
	lis 9,.LC5@ha
	lis 11,g_select_empty@ha
	la 9,.LC5@l(9)
	lfs 13,0(9)
	lwz 9,g_select_empty@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L77
	lwz 0,56(31)
	andi. 9,0,2
	bc 4,2,.L77
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,3
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 9,11,9
	cmpwi 0,9,0
	bc 4,2,.L78
	cmpwi 0,28,0
	bc 12,2,.L81
	lis 9,gi+8@ha
	lis 5,.LC3@ha
	lwz 6,40(3)
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC3@l(5)
	b .L85
.L78:
	lwz 0,76(31)
	cmpw 0,9,0
	bc 4,0,.L77
.L86:
	cmpwi 0,28,0
	bc 12,2,.L81
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 6,40(3)
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC4@l(5)
.L85:
	lwz 7,40(31)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L84:
.L81:
	li 3,0
	b .L82
.L77:
	li 3,1
.L82:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Can_Use,.Lfe2-Can_Use
	.section	".rodata"
	.align 2
.LC6:
	.string	"Cycle around what weapons?\n"
	.align 2
.LC7:
	.string	"No weapon changed\n"
	.section	".text"
	.align 2
	.globl Cmd_Cycle_f
	.type	 Cmd_Cycle_f,@function
Cmd_Cycle_f:
	stwu 1,-304(1)
	mflr 0
	stmw 22,264(1)
	stw 0,308(1)
	lis 9,gi@ha
	mr 28,3
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L88
	lwz 0,8(29)
	lis 5,.LC6@ha
	mr 3,28
	la 5,.LC6@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L87
.L88:
	lwz 0,164(29)
	li 24,0
	li 26,0
	li 29,0
	mtlr 0
	blrl
	mr 27,3
	lwz 9,84(28)
	lbz 10,0(27)
	mr 23,27
	lwz 25,1788(9)
	cmpwi 0,10,0
	bc 12,2,.L90
	li 22,0
.L91:
	cmpwi 7,29,0
	rlwinm 11,10,0,0xff
	xori 9,11,123
	subfic 0,9,0
	adde 9,0,9
	mfcr 0
	rlwinm 0,0,31,1
	and. 9,9,0
	bc 12,2,.L92
	li 29,1
	addi 31,1,8
	stb 22,8(1)
	b .L93
.L92:
	xori 0,11,125
	subfic 8,0,0
	adde 0,8,0
	and. 11,0,29
	bc 12,2,.L94
	stb 9,0(31)
	addi 3,1,8
	li 29,0
	bl FindItem
	cmpwi 0,24,0
	mr 30,3
	bc 12,2,.L95
	mr 3,28
	mr 4,30
	li 5,1
	bl Can_Use
	cmpwi 0,3,0
	bc 12,2,.L93
	lwz 9,84(28)
	li 26,1
	stw 30,3624(9)
	b .L93
.L95:
	xor 24,30,25
	subfic 0,24,0
	adde 24,0,24
	b .L93
.L94:
	bc 12,30,.L93
	stb 10,0(31)
	addi 31,31,1
.L93:
	lbzu 10,1(27)
	subfic 8,26,0
	adde 9,8,26
	neg 0,10
	srwi 0,0,31
	and. 11,0,9
	bc 4,2,.L91
.L90:
	cmpwi 7,26,0
	bc 4,30,.L102
	mr 27,23
	li 29,0
	lbz 10,0(27)
	cmpwi 0,10,0
	bc 12,2,.L102
	li 24,0
.L105:
	cmpwi 7,29,0
	rlwinm 11,10,0,0xff
	xori 9,11,123
	subfic 0,9,0
	adde 9,0,9
	mfcr 0
	rlwinm 0,0,31,1
	and. 9,9,0
	bc 12,2,.L106
	li 29,1
	addi 31,1,8
	stb 24,8(1)
	b .L107
.L106:
	xori 0,11,125
	subfic 8,0,0
	adde 0,8,0
	and. 11,0,29
	bc 12,2,.L108
	stb 9,0(31)
	addi 3,1,8
	li 29,0
	bl FindItem
	mr 30,3
	li 5,1
	mr 3,28
	mr 4,30
	bl Can_Use
	cmpwi 0,3,0
	bc 12,2,.L109
	lwz 9,84(28)
	li 26,1
	stw 30,3624(9)
.L109:
	xor 0,30,25
	srawi 8,0,31
	xor 9,8,0
	subf 9,9,8
	srawi 9,9,31
	addi 0,9,1
	and 9,26,9
	or 26,9,0
	b .L107
.L108:
	bc 12,30,.L107
	stb 10,0(31)
	addi 31,31,1
.L107:
	cmpwi 7,26,0
	lbzu 10,1(27)
	neg 0,10
	srwi 0,0,31
	mfcr 9
	rlwinm 9,9,31,1
	and. 11,0,9
	bc 4,2,.L105
.L102:
	mfcr 9
	rlwinm 9,9,31,1
	xor 0,30,25
	subfic 8,0,0
	adde 0,8,0
	or. 11,9,0
	bc 12,2,.L87
	lis 9,gi+8@ha
	lis 5,.LC7@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L87:
	lwz 0,308(1)
	mtlr 0
	lmw 22,264(1)
	la 1,304(1)
	blr
.Lfe3:
	.size	 Cmd_Cycle_f,.Lfe3-Cmd_Cycle_f
	.section	".rodata"
	.align 2
.LC8:
	.string	"You must run the server with '+set cheats 1' to enable this command.\n"
	.align 2
.LC9:
	.string	"Give what?\n"
	.align 2
.LC10:
	.string	"all"
	.align 2
.LC11:
	.string	"health"
	.align 2
.LC12:
	.string	"weapons"
	.align 2
.LC13:
	.string	"ammo"
	.align 2
.LC14:
	.string	"armor"
	.align 2
.LC15:
	.string	"Jacket Armor"
	.align 2
.LC16:
	.string	"Combat Armor"
	.align 2
.LC17:
	.string	"Body Armor"
	.align 2
.LC18:
	.string	"Power Shield"
	.align 2
.LC19:
	.string	"Power Screen"
	.align 2
.LC20:
	.string	"Red Flag"
	.align 2
.LC21:
	.string	"Blue Flag"
	.align 2
.LC22:
	.string	"Jetpack"
	.align 2
.LC23:
	.string	"unknown item\n"
	.align 2
.LC24:
	.string	"non-pickup item\n"
	.align 2
.LC25:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Give_f
	.type	 Cmd_Give_f,@function
Cmd_Give_f:
	stwu 1,-64(1)
	mflr 0
	mfcr 12
	stmw 21,20(1)
	stw 0,68(1)
	stw 12,16(1)
	lis 9,deathmatch@ha
	lis 10,.LC25@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC25@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L117
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L116
.L117:
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L116
	lis 9,gi+8@ha
	lis 5,.LC8@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC8@l(5)
	b .L177
.L116:
	lis 9,gi@ha
	la 28,gi@l(9)
	lwz 9,164(28)
	mtlr 9
	blrl
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L118
	lwz 0,8(28)
	lis 5,.LC9@ha
	mr 3,31
	la 5,.LC9@l(5)
	b .L177
.L118:
	lwz 9,164(28)
	mtlr 9
	blrl
	mr 30,3
	lis 4,.LC10@ha
	la 4,.LC10@l(4)
	bl Q_stricmp
	subfic 0,3,0
	adde. 27,0,3
	mfcr 29
	bc 4,2,.L122
	lwz 9,160(28)
	li 3,1
	rlwinm 29,29,16,0xffffffff
	mtcrf 8,29
	rlwinm 29,29,16,0xffffffff
	mtlr 9
	blrl
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L121
.L122:
	lwz 9,156(28)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L123
	lwz 0,160(28)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	stw 3,480(31)
	b .L124
.L123:
	lwz 0,484(31)
	stw 0,480(31)
.L124:
	cmpwi 4,27,0
	bc 12,18,.L115
.L121:
	bc 4,18,.L127
	lis 4,.LC12@ha
	mr 3,30
	la 4,.LC12@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L126
.L127:
	lis 9,game@ha
	li 28,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,28,0
	bc 4,0,.L129
	lis 9,itemlist@ha
	mr 7,11
	la 8,itemlist@l(9)
	li 10,0
.L131:
	mr 27,8
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L130
	lwz 0,56(27)
	andi. 9,0,1
	bc 12,2,.L130
	lwz 11,84(31)
	addi 11,11,740
	lwzx 9,11,10
	addi 9,9,1
	stwx 9,11,10
.L130:
	lwz 0,1556(7)
	addi 28,28,1
	addi 10,10,4
	addi 8,8,84
	cmpw 0,28,0
	bc 12,0,.L131
.L129:
	bc 12,18,.L115
.L126:
	bc 4,18,.L137
	lis 4,.LC13@ha
	mr 3,30
	la 4,.LC13@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L136
.L137:
	lis 9,game@ha
	li 28,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,28,0
	bc 4,0,.L139
	lis 9,itemlist@ha
	mr 26,11
	la 29,itemlist@l(9)
.L141:
	mr 27,29
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L140
	lwz 0,56(27)
	andi. 9,0,2
	bc 12,2,.L140
	mr 4,27
	mr 3,31
	li 5,1000
	bl Add_Ammo
.L140:
	lwz 0,1556(26)
	addi 28,28,1
	addi 29,29,84
	cmpw 0,28,0
	bc 12,0,.L141
.L139:
	bc 12,18,.L115
.L136:
	bc 4,18,.L147
	lis 4,.LC14@ha
	mr 3,30
	la 4,.LC14@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L146
.L147:
	lis 3,.LC15@ha
	lis 28,0x3cf3
	la 3,.LC15@l(3)
	ori 28,28,53053
	bl FindItem
	li 27,0
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC16@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC16@l(11)
	rlwinm 0,0,0,0,29
	stwx 27,9,0
	bl FindItem
	subf 0,29,3
	lwz 9,84(31)
	mullw 0,0,28
	lis 3,.LC17@ha
	addi 9,9,740
	la 3,.LC17@l(3)
	rlwinm 0,0,0,0,29
	stwx 27,9,0
	bl FindItem
	mr 27,3
	lwz 9,84(31)
	lwz 11,64(27)
	subf 29,29,27
	mullw 29,29,28
	addi 9,9,740
	lwz 0,4(11)
	rlwinm 29,29,0,0,29
	stwx 0,9,29
	bc 12,18,.L115
.L146:
	bc 4,18,.L150
	lis 4,.LC18@ha
	mr 3,30
	la 4,.LC18@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L149
.L150:
	lis 3,.LC18@ha
	la 3,.LC18@l(3)
	bl FindItem
	mr 27,3
	bl G_Spawn
	lwz 9,0(27)
	mr 29,3
	li 0,8192
	mr 4,27
	stw 0,284(29)
	stw 9,280(29)
	bl SpawnItem
	lis 0,0x1
	mr 3,29
	stw 0,284(29)
	mr 4,31
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L151
	mr 3,29
	bl G_FreeEdict
.L151:
	bc 12,18,.L115
.L149:
	bc 4,18,.L154
	lis 4,.LC19@ha
	mr 3,30
	la 4,.LC19@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L153
.L154:
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	bl FindItem
	mr 27,3
	bl G_Spawn
	lwz 9,0(27)
	mr 29,3
	li 0,8192
	mr 4,27
	stw 0,284(29)
	stw 9,280(29)
	bl SpawnItem
	lis 0,0x1
	mr 3,29
	stw 0,284(29)
	mr 4,31
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L155
	mr 3,29
	bl G_FreeEdict
.L155:
	bc 12,18,.L115
.L153:
	bc 12,18,.L157
	lis 9,game@ha
	li 28,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,28,0
	bc 4,0,.L115
	lis 9,itemlist@ha
	mr 21,11
	la 29,itemlist@l(9)
	lis 22,.LC20@ha
	lis 23,.LC21@ha
	lis 24,.LC22@ha
	li 25,800
	li 26,1
	li 30,0
	li 27,0
.L161:
	lwz 0,4(29)
	cmpwi 0,0,0
	bc 12,2,.L160
	lwz 0,56(29)
	andi. 9,0,71
	bc 4,2,.L160
	lwz 3,40(29)
	la 4,.LC20@l(22)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L160
	lwz 3,40(29)
	la 4,.LC21@l(23)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L160
	lwz 3,40(29)
	la 4,.LC22@l(24)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L166
	lwz 9,84(31)
	addi 9,9,740
	stwx 25,9,27
	b .L160
.L166:
	lwz 9,84(31)
	addi 9,9,740
	stwx 26,9,30
.L160:
	lwz 0,1556(21)
	addi 28,28,1
	addi 30,30,4
	addi 27,27,4
	addi 29,29,84
	cmpw 0,28,0
	bc 12,0,.L161
	b .L115
.L157:
	mr 3,30
	bl FindItem
	mr. 27,3
	bc 4,2,.L169
	lis 9,gi@ha
	li 3,1
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	bl FindItem
	mr. 27,3
	bc 4,2,.L169
	lwz 0,8(30)
	lis 5,.LC23@ha
	mr 3,31
	la 5,.LC23@l(5)
	b .L177
.L169:
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 4,2,.L171
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC24@l(5)
.L177:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L115
.L171:
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,56(27)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,27
	andi. 10,11,2
	mullw 9,9,0
	srawi 30,9,2
	bc 12,2,.L172
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L173
	lwz 0,160(29)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	slwi 0,30,2
	addi 9,9,740
	stwx 3,9,0
	b .L115
.L173:
	lwz 9,84(31)
	slwi 10,30,2
	lwz 11,48(27)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L115
.L172:
	bl G_Spawn
	lwz 9,0(27)
	mr 29,3
	li 0,8192
	mr 4,27
	stw 0,284(29)
	stw 9,280(29)
	bl SpawnItem
	lis 0,0x1
	mr 4,31
	stw 0,284(29)
	mr 3,29
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L115
	mr 3,29
	bl G_FreeEdict
.L115:
	lwz 0,68(1)
	lwz 12,16(1)
	mtlr 0
	lmw 21,20(1)
	mtcrf 8,12
	la 1,64(1)
	blr
.Lfe4:
	.size	 Cmd_Give_f,.Lfe4-Cmd_Give_f
	.section	".rodata"
	.align 2
.LC26:
	.string	"godmode OFF\n"
	.align 2
.LC27:
	.string	"godmode ON\n"
	.align 2
.LC28:
	.string	"notarget OFF\n"
	.align 2
.LC29:
	.string	"notarget ON\n"
	.align 2
.LC30:
	.string	"noclip OFF\n"
	.align 2
.LC31:
	.string	"noclip ON\n"
	.align 2
.LC32:
	.string	"Use what?\n"
	.align 2
.LC33:
	.string	"unknown item: %s\n"
	.align 2
.LC34:
	.string	"Item is not usable.\n"
	.align 2
.LC35:
	.string	"Out of item: %s\n"
	.section	".text"
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
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L194
	lwz 0,8(29)
	lis 5,.LC32@ha
	mr 3,31
	la 5,.LC32@l(5)
	b .L198
.L194:
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 30,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L195
	lwz 0,8(29)
	lis 5,.LC33@ha
	mr 3,31
	la 5,.LC33@l(5)
	b .L199
.L195:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L196
	lwz 0,8(29)
	lis 5,.LC34@ha
	mr 3,31
	la 5,.LC34@l(5)
.L198:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L193
.L196:
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L197
	lwz 0,8(29)
	lis 5,.LC35@ha
	mr 3,31
	la 5,.LC35@l(5)
.L199:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L193
.L197:
	mr 3,31
	mtlr 10
	blrl
.L193:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Cmd_Use_f,.Lfe5-Cmd_Use_f
	.section	".rodata"
	.align 2
.LC36:
	.string	"Sorry, items cannot be dropped (to allow it, set dropitems to 0).\n"
	.align 2
.LC37:
	.string	"Drop what?\n"
	.align 2
.LC38:
	.string	"tech"
	.align 2
.LC39:
	.string	"You don't have any Tech\n"
	.align 2
.LC40:
	.string	"%s is your initial weapon.\nYou can't drop it.\n"
	.align 2
.LC41:
	.string	"Item is not dropable.\n"
	.align 2
.LC42:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Drop_f
	.type	 Cmd_Drop_f,@function
Cmd_Drop_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC42@ha
	lis 9,dropitems@ha
	la 11,.LC42@l(11)
	mr 30,3
	lfs 13,0(11)
	lwz 11,dropitems@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L201
	lis 9,gi+8@ha
	lis 5,.LC36@ha
	lwz 0,gi+8@l(9)
	la 5,.LC36@l(5)
	b .L210
.L201:
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L202
	lwz 0,8(29)
	lis 5,.LC37@ha
	mr 3,30
	la 5,.LC37@l(5)
	b .L210
.L202:
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC38@ha
	la 4,.LC38@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L203
	mr 3,30
	bl CTFWhat_Tech
	mr. 31,3
	bc 12,2,.L204
	lwz 0,12(31)
	mr 3,30
	mr 4,31
	mtlr 0
	blrl
	b .L200
.L204:
	lwz 0,8(29)
	lis 5,.LC39@ha
	mr 3,30
	la 5,.LC39@l(5)
	b .L210
.L203:
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 28,3
	bl FindItem
	mr. 31,3
	bc 4,2,.L206
	lwz 0,8(29)
	lis 5,.LC33@ha
	mr 3,30
	la 5,.LC33@l(5)
	b .L211
.L206:
	mr 3,30
	bl GetInitialWeapon
	cmpw 0,31,3
	bc 4,2,.L207
	lwz 0,8(29)
	lis 5,.LC40@ha
	mr 3,30
	la 5,.LC40@l(5)
	b .L211
.L207:
	lwz 10,12(31)
	cmpwi 0,10,0
	bc 4,2,.L208
	lwz 0,8(29)
	lis 5,.LC41@ha
	mr 3,30
	la 5,.LC41@l(5)
.L210:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L200
.L208:
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,31
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L209
	lwz 0,8(29)
	lis 5,.LC35@ha
	mr 3,30
	la 5,.LC35@l(5)
.L211:
	mr 6,28
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L200
.L209:
	mr 3,30
	mr 4,31
	mtlr 10
	blrl
.L200:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 Cmd_Drop_f,.Lfe6-Cmd_Drop_f
	.section	".rodata"
	.align 2
.LC43:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Inven_f
	.type	 Cmd_Inven_f,@function
Cmd_Inven_f:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 29,3
	li 0,0
	lwz 30,84(29)
	stw 0,3592(30)
	stw 0,3576(30)
	lwz 9,84(29)
	lwz 9,3584(9)
	cmpwi 0,9,0
	bc 12,2,.L213
	bl PMenu_Close
	lwz 9,84(29)
	li 0,1
	stw 0,3892(9)
	b .L212
.L213:
	lwz 0,3588(30)
	cmpwi 0,0,0
	bc 12,2,.L214
	stw 9,3588(30)
	b .L212
.L214:
	lis 9,.LC43@ha
	lis 11,ctf@ha
	la 9,.LC43@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L215
	lwz 0,3500(30)
	cmpwi 0,0,0
	bc 4,2,.L215
	mr 3,29
	bl CTFOpenJoinMenu
	b .L212
.L215:
	lis 9,.LC43@ha
	lis 11,enableclass@ha
	la 9,.LC43@l(9)
	lfs 13,0(9)
	lwz 9,enableclass@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L216
	lwz 0,260(29)
	cmpwi 0,0,1
	bc 4,2,.L216
	mr 3,29
	bl ClassOpenJoinMenu
	b .L212
.L216:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3588(30)
	li 3,5
	lwz 0,100(9)
	mr 27,9
	addi 31,30,740
	addi 28,30,1760
	mtlr 0
	blrl
.L221:
	lwz 9,104(27)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,28
	bc 4,1,.L221
	lis 9,gi+92@ha
	mr 3,29
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	lwz 0,1820(30)
	andi. 9,0,1
	bc 12,2,.L212
	li 0,2
	stw 0,1820(30)
.L212:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 Cmd_Inven_f,.Lfe7-Cmd_Inven_f
	.section	".rodata"
	.align 2
.LC44:
	.string	"No item to use.\n"
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
	lwz 0,3584(8)
	cmpwi 0,0,0
	bc 12,2,.L225
	bl PMenu_Select
	b .L224
.L225:
	lwz 11,736(8)
	addi 10,8,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L227
	lwz 0,3888(8)
	cmpwi 0,0,0
	bc 12,2,.L230
	mr 3,31
	bl ChaseNext
	b .L227
.L242:
	stw 11,736(8)
	b .L227
.L230:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L243:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L236
	mulli 0,11,84
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L236
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L242
.L236:
	addi 7,7,1
	bdnz .L243
	li 0,-1
	stw 0,736(8)
.L227:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L240
	lis 9,gi+8@ha
	lis 5,.LC44@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC44@l(5)
	b .L244
.L240:
	mulli 0,0,84
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L241
	lis 9,gi+8@ha
	lis 5,.LC34@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC34@l(5)
.L244:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L224
.L241:
	mr 3,31
	mtlr 0
	blrl
.L224:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 Cmd_InvUse_f,.Lfe8-Cmd_InvUse_f
	.section	".rodata"
	.align 2
.LC45:
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
	lwz 8,84(31)
	lwz 11,736(8)
	addi 10,8,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L278
	lwz 0,3584(8)
	cmpwi 0,0,0
	bc 12,2,.L279
	bl PMenu_Next
	b .L278
.L279:
	lwz 0,3888(8)
	cmpwi 0,0,0
	bc 12,2,.L281
	mr 3,31
	bl ChaseNext
	b .L278
.L293:
	stw 11,736(8)
	b .L278
.L281:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L294:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L287
	mulli 0,11,84
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L287
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L293
.L287:
	addi 7,7,1
	bdnz .L294
	li 0,-1
	stw 0,736(8)
.L278:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L291
	lis 9,gi+8@ha
	lis 5,.LC45@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC45@l(5)
	b .L295
.L291:
	mulli 0,0,84
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L292
	lis 9,gi+8@ha
	lis 5,.LC41@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC41@l(5)
.L295:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L276
.L292:
	mr 3,31
	mtlr 0
	blrl
.L276:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 Cmd_InvDrop_f,.Lfe9-Cmd_InvDrop_f
	.section	".rodata"
	.align 2
.LC46:
	.string	"%3i %s\n"
	.align 2
.LC47:
	.string	"...\n"
	.align 2
.LC48:
	.string	"%s\n%i players\n"
	.align 2
.LC49:
	.long 0x0
	.align 3
.LC50:
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
	lis 11,.LC49@ha
	lis 9,maxclients@ha
	la 11,.LC49@l(11)
	mr 23,3
	lfs 13,0(11)
	li 27,0
	li 31,0
	lwz 11,maxclients@l(9)
	addi 29,1,1352
	addi 30,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L305
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L307:
	lwz 0,0(11)
	addi 11,11,4016
	cmpwi 0,0,0
	bc 12,2,.L306
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L306:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L307
.L305:
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
	bc 4,0,.L311
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC46@ha
	lis 25,.LC47@ha
.L313:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC46@l(26)
	addi 28,28,4
	mulli 7,7,4016
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
	bc 4,1,.L314
	la 4,.LC47@l(25)
	mr 3,30
	bl strcat
	b .L311
.L314:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L313
.L311:
	lis 9,gi+8@ha
	lis 5,.LC48@ha
	lwz 0,gi+8@l(9)
	mr 3,23
	la 5,.LC48@l(5)
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
.Lfe10:
	.size	 Cmd_Players_f,.Lfe10-Cmd_Players_f
	.section	".rodata"
	.align 2
.LC51:
	.string	"flipoff\n"
	.align 2
.LC52:
	.string	"salute\n"
	.align 2
.LC53:
	.string	"taunt\n"
	.align 2
.LC54:
	.string	"wave\n"
	.align 2
.LC55:
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
	bc 4,2,.L316
	lwz 0,3788(9)
	cmpwi 0,0,1
	bc 12,1,.L316
	cmplwi 0,3,4
	li 0,1
	stw 0,3788(9)
	bc 12,1,.L325
	lis 11,.L326@ha
	slwi 10,3,2
	la 11,.L326@l(11)
	lis 9,.L326@ha
	lwzx 0,10,11
	la 9,.L326@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L326:
	.long .L320-.L326
	.long .L321-.L326
	.long .L322-.L326
	.long .L323-.L326
	.long .L325-.L326
.L320:
	lis 9,gi+8@ha
	lis 5,.LC51@ha
	lwz 0,gi+8@l(9)
	la 5,.LC51@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,71
	li 9,83
	b .L327
.L321:
	lis 9,gi+8@ha
	lis 5,.LC52@ha
	lwz 0,gi+8@l(9)
	la 5,.LC52@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,83
	li 9,94
	b .L327
.L322:
	lis 9,gi+8@ha
	lis 5,.LC53@ha
	lwz 0,gi+8@l(9)
	la 5,.LC53@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,94
	li 9,111
	b .L327
.L323:
	lis 9,gi+8@ha
	lis 5,.LC54@ha
	lwz 0,gi+8@l(9)
	la 5,.LC54@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,111
	li 9,122
	b .L327
.L325:
	lis 9,gi+8@ha
	lis 5,.LC55@ha
	lwz 0,gi+8@l(9)
	la 5,.LC55@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,122
	li 9,134
.L327:
	stw 0,56(31)
	stw 9,3784(11)
.L316:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 Cmd_Wave_f,.Lfe11-Cmd_Wave_f
	.section	".rodata"
	.align 2
.LC56:
	.string	"(%s): "
	.align 2
.LC57:
	.string	"%s: "
	.align 2
.LC58:
	.string	" "
	.align 2
.LC59:
	.string	"\n"
	.align 2
.LC60:
	.string	"You can't talk for %d more seconds\n"
	.align 2
.LC61:
	.string	"Flood protection:  You can't talk for %d seconds.\n"
	.align 2
.LC62:
	.string	"%s"
	.align 2
.LC63:
	.long 0x0
	.align 3
.LC64:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC65:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Cmd_Say_f
	.type	 Cmd_Say_f,@function
Cmd_Say_f:
	stwu 1,-2112(1)
	mflr 0
	mfcr 12
	stmw 24,2080(1)
	stw 0,2116(1)
	stw 12,2076(1)
	lis 9,gi+156@ha
	mr 28,3
	lwz 0,gi+156@l(9)
	mr 30,4
	mr 31,5
	mtlr 0
	blrl
	cmpwi 0,3,1
	bc 12,1,.L329
	cmpwi 0,31,0
	bc 12,2,.L328
.L329:
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,2064(1)
	lwz 9,2068(1)
	rlwinm 9,9,0,24,25
	neg 9,9
	srawi 9,9,31
	and. 30,30,9
	bc 12,2,.L331
	lwz 6,84(28)
	lis 5,.LC56@ha
	addi 3,1,8
	la 5,.LC56@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L332
.L331:
	lwz 6,84(28)
	lis 5,.LC57@ha
	addi 3,1,8
	la 5,.LC57@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L332:
	cmpwi 0,31,0
	bc 12,2,.L333
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC58@ha
	addi 3,1,8
	la 4,.LC58@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L334
.L333:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L335
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
.L335:
	mr 4,29
	addi 3,1,8
	bl strcat
.L334:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L336
	li 0,0
	stb 0,158(1)
.L336:
	lis 4,.LC59@ha
	addi 3,1,8
	la 4,.LC59@l(4)
	bl strcat
	lis 9,.LC63@ha
	la 9,.LC63@l(9)
	lfs 8,0(9)
	lis 9,flood_msgs@ha
	lwz 11,flood_msgs@l(9)
	lfs 9,20(11)
	fcmpu 0,9,8
	bc 12,2,.L337
	lwz 7,84(28)
	lis 9,level+4@ha
	lfs 10,level+4@l(9)
	lfs 0,3836(7)
	fcmpu 0,10,0
	bc 4,0,.L338
	fsubs 0,0,10
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC60@ha
	mr 3,28
	la 5,.LC60@l(5)
	li 4,2
	mtlr 0
	fctiwz 13,0
	stfd 13,2064(1)
	b .L351
.L338:
	lwz 0,3880(7)
	lis 10,0x4330
	lis 11,.LC64@ha
	addi 8,7,3840
	mr 6,0
	la 11,.LC64@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,2068(1)
	lis 11,.LC65@ha
	stw 10,2064(1)
	la 11,.LC65@l(11)
	lfd 0,2064(1)
	mr 10,8
	lfs 11,0(11)
	mr 11,9
	fsub 0,0,13
	frsp 0,0
	fsubs 0,0,9
	fadds 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,2064(1)
	lwz 11,2068(1)
	nor 0,11,11
	addi 9,11,10
	srawi 0,0,31
	andc 9,9,0
	and 11,11,0
	or 11,11,9
	slwi 11,11,2
	lfsx 0,8,11
	fcmpu 0,0,8
	bc 12,2,.L340
	lis 11,flood_persecond@ha
	fsubs 13,10,0
	lwz 9,flood_persecond@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L340
	lis 9,flood_waitdelay@ha
	lis 10,gi+8@ha
	lwz 11,flood_waitdelay@l(9)
	lis 5,.LC61@ha
	mr 3,28
	la 5,.LC61@l(5)
	lfs 13,20(11)
	li 4,3
	fadds 13,10,13
	stfs 13,3836(7)
	lfs 0,20(11)
	lwz 0,gi+8@l(10)
	mtlr 0
	fctiwz 12,0
	stfd 12,2064(1)
.L351:
	lwz 6,2068(1)
	crxor 6,6,6
	blrl
	b .L328
.L340:
	lis 0,0xcccc
	addi 9,6,1
	ori 0,0,52429
	lis 11,level+4@ha
	mulhwu 0,9,0
	srwi 0,0,3
	mulli 0,0,10
	subf 9,0,9
	stw 9,3880(7)
	lfs 0,level+4@l(11)
	slwi 9,9,2
	stfsx 0,10,9
.L337:
	lis 9,.LC63@ha
	lis 11,dedicated@ha
	la 9,.LC63@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L341
	lis 9,gi+8@ha
	lis 5,.LC62@ha
	lwz 0,gi+8@l(9)
	la 5,.LC62@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L341:
	lis 9,game@ha
	li 31,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,31,0
	bc 12,1,.L328
	cmpwi 4,30,0
	lis 9,gi@ha
	la 24,gi@l(9)
	mr 25,11
	lis 26,g_edicts@ha
	lis 27,.LC62@ha
	li 30,1160
.L345:
	lwz 0,g_edicts@l(26)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L344
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L344
	bc 12,18,.L348
	mr 3,28
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L344
.L348:
	lwz 9,8(24)
	mr 3,29
	li 4,3
	la 5,.LC62@l(27)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L344:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,1160
	cmpw 0,31,0
	bc 4,1,.L345
.L328:
	lwz 0,2116(1)
	lwz 12,2076(1)
	mtlr 0
	lmw 24,2080(1)
	mtcrf 8,12
	la 1,2112(1)
	blr
.Lfe12:
	.size	 Cmd_Say_f,.Lfe12-Cmd_Say_f
	.section	".rodata"
	.align 2
.LC66:
	.string	"%02d:%02d %4d %3d %s%s\n"
	.align 2
.LC67:
	.string	" (spectator)"
	.align 2
.LC68:
	.string	""
	.align 2
.LC69:
	.string	"And more...\n"
	.align 2
.LC70:
	.long 0x0
	.align 3
.LC71:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_PlayerList_f
	.type	 Cmd_PlayerList_f,@function
Cmd_PlayerList_f:
	stwu 1,-1568(1)
	mflr 0
	stmw 20,1520(1)
	stw 0,1572(1)
	lis 9,maxclients@ha
	li 0,0
	lwz 11,maxclients@l(9)
	lis 10,g_edicts@ha
	mr 27,3
	lis 9,.LC70@ha
	stb 0,96(1)
	li 28,0
	la 9,.LC70@l(9)
	lfs 0,20(11)
	lis 22,maxclients@ha
	lfs 13,0(9)
	addi 31,1,96
	lis 21,gi@ha
	lwz 9,g_edicts@l(10)
	lis 20,.LC62@ha
	fcmpu 0,13,0
	addi 30,9,1160
	bc 4,0,.L354
	lis 9,.LC67@ha
	lis 11,.LC68@ha
	la 23,.LC67@l(9)
	la 24,.LC68@l(11)
	lis 25,level@ha
	lis 26,0x4330
.L356:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L355
	lwz 10,84(30)
	lis 11,0x1b4e
	lis 8,0x6666
	lwz 9,level@l(25)
	ori 11,11,33205
	ori 8,8,26215
	lwz 0,3476(10)
	addi 29,10,700
	lwz 7,3496(10)
	subf 9,0,9
	lwz 3,184(10)
	mulhw 11,9,11
	lwz 4,3480(10)
	cmpwi 0,7,0
	srawi 10,9,31
	srawi 11,11,6
	subf 6,10,11
	mulli 0,6,600
	subf 9,0,9
	mulhw 8,9,8
	srawi 9,9,31
	srawi 8,8,2
	subf 7,9,8
	bc 12,2,.L358
	stw 23,8(1)
	b .L359
.L358:
	stw 24,8(1)
.L359:
	mr 8,3
	mr 9,4
	lis 5,.LC66@ha
	mr 10,29
	addi 3,1,16
	la 5,.LC66@l(5)
	li 4,80
	crxor 6,6,6
	bl Com_sprintf
	mr 3,31
	bl strlen
	mr 29,3
	addi 3,1,16
	bl strlen
	add 29,29,3
	cmplwi 0,29,1350
	bc 4,1,.L360
	mr 3,31
	bl strlen
	lis 4,.LC69@ha
	add 3,31,3
	la 4,.LC69@l(4)
	crxor 6,6,6
	bl sprintf
	la 9,gi@l(21)
	mr 3,27
	lwz 0,8(9)
	la 5,.LC62@l(20)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L352
.L360:
	mr 3,31
	addi 4,1,16
	bl strcat
.L355:
	addi 28,28,1
	lwz 11,maxclients@l(22)
	xoris 0,28,0x8000
	lis 10,.LC71@ha
	stw 0,1516(1)
	la 10,.LC71@l(10)
	addi 30,30,1160
	stw 26,1512(1)
	lfd 13,0(10)
	lfd 0,1512(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L356
.L354:
	lis 9,gi+8@ha
	lis 5,.LC62@ha
	lwz 0,gi+8@l(9)
	mr 3,27
	la 5,.LC62@l(5)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L352:
	lwz 0,1572(1)
	mtlr 0
	lmw 20,1520(1)
	la 1,1568(1)
	blr
.Lfe13:
	.size	 Cmd_PlayerList_f,.Lfe13-Cmd_PlayerList_f
	.section	".rodata"
	.align 2
.LC72:
	.string	"players"
	.align 2
.LC73:
	.string	"say"
	.align 2
.LC74:
	.string	"say_team"
	.align 2
.LC75:
	.string	"score"
	.align 2
.LC76:
	.string	"help"
	.align 2
.LC77:
	.string	"use"
	.align 2
.LC78:
	.string	"drop"
	.align 2
.LC79:
	.string	"give"
	.align 2
.LC80:
	.string	"god"
	.align 2
.LC81:
	.string	"notarget"
	.align 2
.LC82:
	.string	"noclip"
	.align 2
.LC83:
	.string	"inven"
	.align 2
.LC84:
	.string	"invnext"
	.align 2
.LC85:
	.string	"invprev"
	.align 2
.LC86:
	.string	"invnextw"
	.align 2
.LC87:
	.string	"invprevw"
	.align 2
.LC88:
	.string	"invnextp"
	.align 2
.LC89:
	.string	"invprevp"
	.align 2
.LC90:
	.string	"invuse"
	.align 2
.LC91:
	.string	"invdrop"
	.align 2
.LC92:
	.string	"weaplast"
	.align 2
.LC93:
	.string	"weapprev"
	.align 2
.LC94:
	.string	"weapnext"
	.align 2
.LC95:
	.string	"kill"
	.align 2
.LC96:
	.string	"putaway"
	.align 2
.LC97:
	.string	"wave"
	.align 2
.LC98:
	.string	"playerlist"
	.align 2
.LC99:
	.string	"chasecam"
	.align 2
.LC100:
	.string	"cycle"
	.align 2
.LC101:
	.string	"team"
	.align 2
.LC102:
	.string	"id"
	.align 2
.LC103:
	.string	"myclass"
	.align 2
.LC104:
	.string	"infoclass"
	.align 2
.LC105:
	.string	"hud"
	.align 2
.LC106:
	.string	"bindkeys"
	.align 2
.LC107:
	.string	"grapple"
	.align 2
.LC108:
	.string	"hook"
	.align 2
.LC109:
	.string	"ungrapple"
	.align 2
.LC110:
	.string	"unhook"
	.align 2
.LC111:
	.string	"cam_maxdistance"
	.align 2
.LC112:
	.string	"josep"
	.align 2
.LC113:
	.string	"Power: %f\n"
	.align 2
.LC114:
	.string	"Resistance: %f\n"
	.align 2
.LC115:
	.string	"Speed: %f\n"
	.align 2
.LC116:
	.long 0x0
	.align 2
.LC117:
	.long 0x40a00000
	.align 2
.LC118:
	.long 0x3f800000
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
	mr 30,3
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L366
	lis 9,gi+160@ha
	li 3,0
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	mr 31,3
	lis 4,.LC72@ha
	la 4,.LC72@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L368
	mr 3,30
	bl Cmd_Players_f
	b .L366
.L368:
	lis 4,.LC73@ha
	mr 3,31
	la 4,.LC73@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L369
	mr 3,30
	li 4,0
	b .L595
.L369:
	lis 4,.LC74@ha
	mr 3,31
	la 4,.LC74@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L370
	mr 3,30
	li 4,1
.L595:
	li 5,0
	bl Cmd_Say_f
	b .L366
.L370:
	lis 4,.LC75@ha
	mr 3,31
	la 4,.LC75@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L371
	mr 3,30
	bl Cmd_Score_f
	b .L366
.L371:
	lis 4,.LC76@ha
	mr 3,31
	la 4,.LC76@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L372
	mr 3,30
	bl Cmd_Help_f
	b .L366
.L372:
	lis 10,.LC116@ha
	lis 9,level+200@ha
	la 10,.LC116@l(10)
	lfs 0,level+200@l(9)
	lfs 31,0(10)
	fcmpu 0,0,31
	bc 4,2,.L366
	lis 4,.LC77@ha
	mr 3,31
	la 4,.LC77@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L374
	mr 3,30
	bl Cmd_Use_f
	b .L366
.L374:
	lis 4,.LC78@ha
	mr 3,31
	la 4,.LC78@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L376
	mr 3,30
	bl Cmd_Drop_f
	b .L366
.L376:
	lis 4,.LC79@ha
	mr 3,31
	la 4,.LC79@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L378
	mr 3,30
	bl Cmd_Give_f
	b .L366
.L378:
	lis 4,.LC80@ha
	mr 3,31
	la 4,.LC80@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L380
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L381
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L382
.L381:
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L382
	lis 9,gi+8@ha
	lis 5,.LC8@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC8@l(5)
	b .L596
.L382:
	lwz 0,264(30)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(30)
	bc 4,2,.L384
	lis 9,.LC26@ha
	la 5,.LC26@l(9)
	b .L399
.L384:
	lis 9,.LC27@ha
	la 5,.LC27@l(9)
	b .L399
.L380:
	lis 4,.LC81@ha
	mr 3,31
	la 4,.LC81@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L387
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L388
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L389
.L388:
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L389
	lis 9,gi+8@ha
	lis 5,.LC8@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC8@l(5)
	b .L596
.L389:
	lwz 0,264(30)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(30)
	bc 4,2,.L391
	lis 9,.LC28@ha
	la 5,.LC28@l(9)
	b .L399
.L391:
	lis 9,.LC29@ha
	la 5,.LC29@l(9)
	b .L399
.L387:
	lis 4,.LC82@ha
	mr 3,31
	la 4,.LC82@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L394
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L395
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L396
.L395:
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L396
	lis 9,gi+8@ha
	lis 5,.LC8@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC8@l(5)
	b .L596
.L396:
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 4,2,.L398
	li 0,4
	lis 9,.LC30@ha
	stw 0,260(30)
	la 5,.LC30@l(9)
	b .L399
.L398:
	li 0,1
	lis 9,.LC31@ha
	stw 0,260(30)
	la 5,.LC31@l(9)
.L399:
	lis 9,gi+8@ha
	mr 3,30
	lwz 0,gi+8@l(9)
.L596:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L366
.L394:
	lis 4,.LC83@ha
	mr 3,31
	la 4,.LC83@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L401
	mr 3,30
	bl Cmd_Inven_f
	b .L366
.L401:
	lis 4,.LC84@ha
	mr 3,31
	la 4,.LC84@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L403
	lwz 8,84(30)
	lwz 0,3584(8)
	cmpwi 0,0,0
	bc 4,2,.L597
	lwz 0,3888(8)
	cmpwi 0,0,0
	bc 4,2,.L598
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L594:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L412
	mulli 0,11,84
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L412
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L587
.L412:
	addi 7,7,1
	bdnz .L594
	b .L599
.L403:
	lis 4,.LC85@ha
	mr 3,31
	la 4,.LC85@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L417
	lwz 7,84(30)
	lwz 0,3584(7)
	cmpwi 0,0,0
	bc 4,2,.L600
	lwz 0,3888(7)
	cmpwi 0,0,0
	bc 4,2,.L601
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L593:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L426
	mulli 0,8,84
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L426
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L588
.L426:
	addi 11,11,-1
	bdnz .L593
	b .L602
.L417:
	lis 4,.LC86@ha
	mr 3,31
	la 4,.LC86@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L431
	lwz 8,84(30)
	lwz 0,3584(8)
	cmpwi 0,0,0
	bc 4,2,.L597
	lwz 0,3888(8)
	cmpwi 0,0,0
	bc 4,2,.L598
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L592:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L440
	mulli 0,11,84
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L440
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L587
.L440:
	addi 7,7,1
	bdnz .L592
	b .L599
.L431:
	lis 4,.LC87@ha
	mr 3,31
	la 4,.LC87@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L445
	lwz 7,84(30)
	lwz 0,3584(7)
	cmpwi 0,0,0
	bc 4,2,.L600
	lwz 0,3888(7)
	cmpwi 0,0,0
	bc 4,2,.L601
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L591:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L454
	mulli 0,8,84
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L454
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L588
.L454:
	addi 11,11,-1
	bdnz .L591
	b .L602
.L445:
	lis 4,.LC88@ha
	mr 3,31
	la 4,.LC88@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L459
	lwz 8,84(30)
	lwz 0,3584(8)
	cmpwi 0,0,0
	bc 12,2,.L460
.L597:
	mr 3,30
	bl PMenu_Next
	b .L366
.L460:
	lwz 0,3888(8)
	cmpwi 0,0,0
	bc 12,2,.L462
.L598:
	mr 3,30
	bl ChaseNext
	b .L366
.L462:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
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
	bc 12,2,.L468
	mulli 0,11,84
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L468
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L587
.L468:
	addi 7,7,1
	bdnz .L590
.L599:
	li 0,-1
	stw 0,736(8)
	b .L366
.L459:
	lis 4,.LC89@ha
	mr 3,31
	la 4,.LC89@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L473
	lwz 7,84(30)
	lwz 0,3584(7)
	cmpwi 0,0,0
	bc 12,2,.L474
.L600:
	mr 3,30
	bl PMenu_Prev
	b .L366
.L474:
	lwz 0,3888(7)
	cmpwi 0,0,0
	bc 12,2,.L476
.L601:
	mr 3,30
	bl ChasePrev
	b .L366
.L476:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L589:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L482
	mulli 0,8,84
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L482
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L588
.L482:
	addi 11,11,-1
	bdnz .L589
.L602:
	li 0,-1
	stw 0,736(7)
	b .L366
.L473:
	lis 4,.LC90@ha
	mr 3,31
	la 4,.LC90@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L487
	mr 3,30
	bl Cmd_InvUse_f
	b .L366
.L487:
	lis 4,.LC91@ha
	mr 3,31
	la 4,.LC91@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L489
	mr 3,30
	bl Cmd_InvDrop_f
	b .L366
.L489:
	lis 29,.LC92@ha
	mr 3,31
	la 4,.LC92@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L603
	lis 4,.LC93@ha
	mr 3,31
	la 4,.LC93@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L499
	lwz 28,84(30)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L366
	lis 9,itemlist@ha
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	ori 0,0,53053
	mr 25,9
	li 31,1
	subf 9,9,11
	addi 26,28,740
	mullw 9,9,0
	srawi 27,9,2
.L504:
	add 11,27,31
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L506
	mulli 0,11,84
	add 29,0,25
	lwz 9,8(29)
	cmpwi 0,9,0
	bc 12,2,.L506
	lwz 0,56(29)
	andi. 10,0,1
	bc 12,2,.L506
	mr 3,30
	mr 4,29
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,29
	bc 12,2,.L366
.L506:
	addi 31,31,1
	cmpwi 0,31,256
	bc 4,1,.L504
	b .L366
.L499:
	lis 4,.LC94@ha
	mr 3,31
	la 4,.LC94@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L512
	lwz 28,84(30)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L366
	lis 9,itemlist@ha
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	ori 0,0,53053
	mr 25,9
	li 27,1
	subf 9,9,11
	addi 26,28,740
	mullw 9,9,0
	srawi 9,9,2
	addi 31,9,255
.L517:
	srawi 0,31,31
	srwi 0,0,24
	add 0,31,0
	rlwinm 0,0,0,0,23
	subf 11,0,31
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L519
	mulli 0,11,84
	add 29,0,25
	lwz 9,8(29)
	cmpwi 0,9,0
	bc 12,2,.L519
	lwz 0,56(29)
	andi. 10,0,1
	bc 12,2,.L519
	mr 3,30
	mr 4,29
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,29
	bc 12,2,.L366
.L519:
	addi 27,27,1
	addi 31,31,-1
	cmpwi 0,27,256
	bc 4,1,.L517
	b .L366
.L512:
	la 4,.LC92@l(29)
	mr 3,31
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L525
.L603:
	lwz 10,84(30)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L366
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L366
	lis 11,itemlist@ha
	lis 9,0x3cf3
	la 4,itemlist@l(11)
	ori 9,9,53053
	subf 0,4,0
	addi 11,10,740
	mullw 0,0,9
	srawi 10,0,2
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L366
	mulli 0,10,84
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L366
	lwz 0,56(4)
	andi. 10,0,1
	bc 12,2,.L366
	mr 3,30
	mtlr 9
	blrl
	b .L366
.L525:
	lis 4,.LC95@ha
	mr 3,31
	la 4,.LC95@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L533
	lwz 11,84(30)
	lis 9,level+4@ha
	lis 10,.LC117@ha
	lfs 0,level+4@l(9)
	la 10,.LC117@l(10)
	lfs 13,3884(11)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L366
	lwz 0,264(30)
	li 9,-41
	mr 3,30
	stw 9,480(30)
	lis 11,meansOfDeath@ha
	lis 6,0x1
	rlwinm 0,0,0,28,26
	li 9,23
	stw 0,264(30)
	lis 7,vec3_origin@ha
	mr 4,3
	stw 9,meansOfDeath@l(11)
	la 7,vec3_origin@l(7)
	mr 5,3
	ori 6,6,34464
	bl player_die
	b .L366
.L533:
	lis 4,.LC96@ha
	mr 3,31
	la 4,.LC96@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L537
	lwz 9,84(30)
	stw 3,3576(9)
	lwz 11,84(30)
	stw 3,3592(11)
	lwz 9,84(30)
	stw 3,3588(9)
	lwz 3,84(30)
	bl ClearScanner
	lwz 9,84(30)
	lwz 0,3584(9)
	cmpwi 0,0,0
	bc 12,2,.L366
	mr 3,30
	bl PMenu_Close
	b .L366
.L537:
	lis 4,.LC97@ha
	mr 3,31
	la 4,.LC97@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L541
	mr 3,30
	bl Cmd_Wave_f
	b .L366
.L541:
	lis 4,.LC98@ha
	mr 3,31
	la 4,.LC98@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L543
	mr 3,30
	bl Cmd_PlayerList_f
	b .L366
.L543:
	lis 4,.LC99@ha
	mr 3,31
	la 4,.LC99@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L545
	mr 3,30
	bl Cmd_Chasecam_Toggle
	b .L366
.L545:
	lis 4,.LC100@ha
	mr 3,31
	la 4,.LC100@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L547
	mr 3,30
	bl Cmd_Cycle_f
	b .L366
.L547:
	lis 4,.LC101@ha
	mr 3,31
	la 4,.LC101@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L549
	mr 3,30
	bl CTFTeam_f
	b .L366
.L549:
	lis 4,.LC102@ha
	mr 3,31
	la 4,.LC102@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L551
	mr 3,30
	bl CTFID_f
	b .L366
.L551:
	lis 4,.LC103@ha
	mr 3,31
	la 4,.LC103@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L553
	mr 3,30
	bl Cmd_ShowClass
	b .L366
.L553:
	lis 4,.LC104@ha
	mr 3,31
	la 4,.LC104@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L555
	mr 3,30
	bl Cmd_InfoClass
	b .L366
.L555:
	lis 4,.LC105@ha
	mr 3,31
	la 4,.LC105@l(4)
	bl Q_stricmp
	mr. 29,3
	bc 4,2,.L557
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,164(31)
	mtlr 9
	blrl
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L558
	lwz 8,84(30)
	lis 9,0x5555
	ori 9,9,21846
	lwz 11,1816(8)
	addi 11,11,1
	mulhw 9,11,9
	srawi 10,11,31
	subf 9,10,9
	slwi 0,9,1
	add 0,0,9
	subf 11,0,11
	stw 11,1816(8)
	b .L366
.L558:
	lwz 0,164(31)
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(30)
	stw 3,1816(9)
	lwz 3,84(30)
	lwz 0,1816(3)
	cmplwi 0,0,2
	bc 4,1,.L366
	stw 29,1816(3)
	b .L366
.L557:
	lis 4,.LC106@ha
	mr 3,31
	la 4,.LC106@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L562
	mr 3,30
	li 4,0
	bl BindClassKeys
	b .L366
.L562:
	lis 4,.LC107@ha
	mr 3,31
	la 4,.LC107@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L566
	lis 4,.LC108@ha
	mr 3,31
	la 4,.LC108@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L565
.L566:
	lis 9,.LC116@ha
	lis 11,offhandgrapple@ha
	la 9,.LC116@l(9)
	lfs 12,0(9)
	lwz 9,offhandgrapple@l(11)
	lfs 13,20(9)
	fcmpu 0,13,12
	bc 12,2,.L569
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 4,2,.L568
.L569:
	lis 10,.LC118@ha
	la 10,.LC118@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L366
.L568:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L366
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L366
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 12,2,.L366
	lis 4,vec3_origin@ha
	mr 3,30
	la 4,vec3_origin@l(4)
	li 5,10
	li 6,0
	bl CTFGrappleFire
	b .L366
.L565:
	lis 4,.LC109@ha
	mr 3,31
	la 4,.LC109@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L573
	lis 4,.LC110@ha
	mr 3,31
	la 4,.LC110@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L572
.L573:
	lis 9,.LC116@ha
	lis 11,offhandgrapple@ha
	la 9,.LC116@l(9)
	lfs 12,0(9)
	lwz 9,offhandgrapple@l(11)
	lfs 13,20(9)
	fcmpu 0,13,12
	bc 12,2,.L576
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 4,2,.L575
.L576:
	lis 10,.LC118@ha
	la 10,.LC118@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L366
.L575:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L366
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L366
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 12,2,.L366
	mr 3,30
	bl CTFPlayerResetGrapple
	b .L366
.L572:
	lis 4,.LC111@ha
	mr 3,31
	la 4,.LC111@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L579
	mr 3,30
	bl Cmd_CamMaxDistance
	b .L366
.L579:
	lis 4,.LC112@ha
	mr 3,31
	la 4,.LC112@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L581
	lwz 9,84(30)
	lis 29,gi@ha
	lis 4,.LC113@ha
	lwz 11,gi@l(29)
	la 4,.LC113@l(4)
	li 3,1
	lfs 1,3936(9)
	mtlr 11
	creqv 6,6,6
	blrl
	lwz 9,84(30)
	lis 4,.LC114@ha
	li 3,1
	lwz 11,gi@l(29)
	la 4,.LC114@l(4)
	lfs 1,3940(9)
	mtlr 11
	creqv 6,6,6
	blrl
	lwz 9,84(30)
	lis 4,.LC115@ha
	li 3,1
	lwz 0,gi@l(29)
	la 4,.LC115@l(4)
	lfs 1,3932(9)
	mtlr 0
	creqv 6,6,6
	blrl
	b .L366
.L587:
	stw 11,736(8)
	b .L366
.L588:
	stw 8,736(7)
	b .L366
.L581:
	mr 3,30
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L366:
	lwz 0,52(1)
	mtlr 0
	lmw 25,12(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe14:
	.size	 ClientCommand,.Lfe14-ClientCommand
	.align 2
	.globl ValidateSelectedItem
	.type	 ValidateSelectedItem,@function
ValidateSelectedItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 8,84(3)
	lwz 11,736(8)
	addi 10,8,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L50
	lwz 0,3584(8)
	cmpwi 0,0,0
	bc 12,2,.L52
	bl PMenu_Next
	b .L50
.L52:
	lwz 0,3888(8)
	cmpwi 0,0,0
	bc 12,2,.L54
	bl ChaseNext
	b .L50
.L604:
	stw 11,736(8)
	b .L50
.L54:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L605:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L60
	mulli 0,11,84
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L60
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L604
.L60:
	addi 7,7,1
	bdnz .L605
	li 0,-1
	stw 0,736(8)
.L50:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 ValidateSelectedItem,.Lfe15-ValidateSelectedItem
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
	bc 12,2,.L607
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
	bc 12,2,.L607
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L9
	addi 3,3,1
	b .L606
.L9:
	stb 30,0(3)
.L607:
	mr 3,31
.L606:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 ClientTeam,.Lfe16-ClientTeam
	.align 2
	.globl SelectNextItem
	.type	 SelectNextItem,@function
SelectNextItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 8,84(3)
	lwz 0,3584(8)
	cmpwi 0,0,0
	bc 12,2,.L27
	bl PMenu_Next
	b .L26
.L27:
	lwz 0,3888(8)
	cmpwi 0,0,0
	bc 12,2,.L28
	bl ChaseNext
	b .L26
.L608:
	stw 11,736(8)
	b .L26
.L28:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 3,itemlist@l(9)
	addi 6,8,740
.L609:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L32
	mulli 0,11,84
	add 10,0,3
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L32
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L608
.L32:
	addi 7,7,1
	bdnz .L609
	li 0,-1
	stw 0,736(8)
.L26:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 SelectNextItem,.Lfe17-SelectNextItem
	.align 2
	.globl SelectPrevItem
	.type	 SelectPrevItem,@function
SelectPrevItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 7,84(3)
	lwz 0,3584(7)
	cmpwi 0,0,0
	bc 12,2,.L39
	bl PMenu_Prev
	b .L38
.L39:
	lwz 0,3888(7)
	cmpwi 0,0,0
	bc 12,2,.L40
	bl ChasePrev
	b .L38
.L610:
	stw 8,736(7)
	b .L38
.L40:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L611:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L44
	mulli 0,8,84
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L44
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L610
.L44:
	addi 11,11,-1
	bdnz .L611
	li 0,-1
	stw 0,736(7)
.L38:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 SelectPrevItem,.Lfe18-SelectPrevItem
	.section	".rodata"
	.align 2
.LC119:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC119@ha
	lis 9,deathmatch@ha
	la 11,.LC119@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L180
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L179
.L180:
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L179
	lis 9,gi+8@ha
	lis 5,.LC8@ha
	lwz 0,gi+8@l(9)
	la 5,.LC8@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L178
.L179:
	lwz 0,264(3)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(3)
	bc 4,2,.L181
	lis 9,.LC26@ha
	la 5,.LC26@l(9)
	b .L182
.L181:
	lis 9,.LC27@ha
	la 5,.LC27@l(9)
.L182:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L178:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 Cmd_God_f,.Lfe19-Cmd_God_f
	.section	".rodata"
	.align 2
.LC120:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC120@ha
	lis 9,deathmatch@ha
	la 11,.LC120@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L185
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L184
.L185:
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L184
	lis 9,gi+8@ha
	lis 5,.LC8@ha
	lwz 0,gi+8@l(9)
	la 5,.LC8@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L183
.L184:
	lwz 0,264(3)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(3)
	bc 4,2,.L186
	lis 9,.LC28@ha
	la 5,.LC28@l(9)
	b .L187
.L186:
	lis 9,.LC29@ha
	la 5,.LC29@l(9)
.L187:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L183:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe20:
	.size	 Cmd_Notarget_f,.Lfe20-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC121:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC121@ha
	lis 9,deathmatch@ha
	la 11,.LC121@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L190
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L189
.L190:
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L189
	lis 9,gi+8@ha
	lis 5,.LC8@ha
	lwz 0,gi+8@l(9)
	la 5,.LC8@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L188
.L189:
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 4,2,.L191
	li 0,4
	lis 9,.LC30@ha
	stw 0,260(3)
	la 5,.LC30@l(9)
	b .L192
.L191:
	li 0,1
	lis 9,.LC31@ha
	stw 0,260(3)
	la 5,.LC31@l(9)
.L192:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L188:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 Cmd_Noclip_f,.Lfe21-Cmd_Noclip_f
	.align 2
	.globl Cmd_LastWeap_f
	.type	 Cmd_LastWeap_f,@function
Cmd_LastWeap_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 4,84(3)
	lwz 0,1788(4)
	cmpwi 0,0,0
	bc 12,2,.L245
	lwz 9,1792(4)
	cmpwi 0,9,0
	bc 12,2,.L245
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L245:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 Cmd_LastWeap_f,.Lfe22-Cmd_LastWeap_f
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
	lwz 11,1788(29)
	cmpwi 0,11,0
	bc 12,2,.L248
	lis 9,itemlist@ha
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	ori 0,0,53053
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,29,740
	mullw 9,9,0
	srawi 27,9,2
.L253:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L252
	mulli 0,11,84
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L252
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L252
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L248
.L252:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L253
.L248:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe23:
	.size	 Cmd_WeapPrev_f,.Lfe23-Cmd_WeapPrev_f
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
	lwz 11,1788(29)
	cmpwi 0,11,0
	bc 12,2,.L259
	lis 9,itemlist@ha
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	ori 0,0,53053
	mr 25,9
	li 28,1
	subf 9,9,11
	addi 26,29,740
	mullw 9,9,0
	srawi 9,9,2
	addi 30,9,255
.L264:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L263
	mulli 0,11,84
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L263
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L263
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L259
.L263:
	addi 28,28,1
	addi 30,30,-1
	cmpwi 0,28,256
	bc 4,1,.L264
.L259:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe24:
	.size	 Cmd_WeapNext_f,.Lfe24-Cmd_WeapNext_f
	.align 2
	.globl Cmd_WeapLast_f
	.type	 Cmd_WeapLast_f,@function
Cmd_WeapLast_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 10,84(3)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L270
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L270
	lis 11,itemlist@ha
	lis 9,0x3cf3
	la 4,itemlist@l(11)
	ori 9,9,53053
	subf 0,4,0
	addi 11,10,740
	mullw 0,0,9
	srawi 10,0,2
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L270
	mulli 0,10,84
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L270
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L270
	mtlr 9
	blrl
.L270:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe25:
	.size	 Cmd_WeapLast_f,.Lfe25-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC122:
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
	lis 9,level+4@ha
	lwz 11,84(10)
	lis 8,.LC122@ha
	lfs 0,level+4@l(9)
	la 8,.LC122@l(8)
	lfs 13,3884(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L296
	lwz 0,264(10)
	li 9,-41
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
.L296:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe26:
	.size	 Cmd_Kill_f,.Lfe26-Cmd_Kill_f
	.align 2
	.globl Cmd_PutAway_f
	.type	 Cmd_PutAway_f,@function
Cmd_PutAway_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 0,0
	lwz 9,84(31)
	stw 0,3576(9)
	lwz 11,84(31)
	stw 0,3592(11)
	lwz 9,84(31)
	stw 0,3588(9)
	lwz 3,84(31)
	bl ClearScanner
	lwz 9,84(31)
	lwz 0,3584(9)
	cmpwi 0,0,0
	bc 12,2,.L299
	mr 3,31
	bl PMenu_Close
.L299:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe27:
	.size	 Cmd_PutAway_f,.Lfe27-Cmd_PutAway_f
	.align 2
	.globl PlayerSort
	.type	 PlayerSort,@function
PlayerSort:
	lwz 9,0(3)
	lis 11,game+1028@ha
	lwz 3,0(4)
	lwz 0,game+1028@l(11)
	mulli 9,9,4016
	mulli 11,3,4016
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
.Lfe28:
	.size	 PlayerSort,.Lfe28-PlayerSort
	.align 2
	.globl Cmd_Hud
	.type	 Cmd_Hud,@function
Cmd_Hud:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi@ha
	mr 31,3
	la 30,gi@l(9)
	lwz 9,164(30)
	mtlr 9
	blrl
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L363
	lwz 8,84(31)
	lis 9,0x5555
	ori 9,9,21846
	lwz 11,1816(8)
	addi 11,11,1
	mulhw 9,11,9
	srawi 10,11,31
	subf 9,10,9
	slwi 0,9,1
	add 0,0,9
	subf 11,0,11
	stw 11,1816(8)
	b .L362
.L363:
	lwz 0,164(30)
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	stw 3,1816(9)
	lwz 3,84(31)
	lwz 0,1816(3)
	cmplwi 0,0,2
	bc 4,1,.L362
	li 0,0
	stw 0,1816(3)
.L362:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe29:
	.size	 Cmd_Hud,.Lfe29-Cmd_Hud
	.align 2
	.globl Cmd_BindKeys
	.type	 Cmd_BindKeys,@function
Cmd_BindKeys:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,0
	bl BindClassKeys
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 Cmd_BindKeys,.Lfe30-Cmd_BindKeys
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
