	.file	"g_cmds.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
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
	lwz 9,84(3)
	mr 28,4
	cmpwi 0,9,0
	bc 12,2,.L11
	lwz 11,84(28)
	cmpwi 0,11,0
	bc 12,2,.L11
	lwz 9,3912(9)
	cmpwi 0,9,0
	bc 12,2,.L11
	lwz 0,3912(11)
	cmpw 0,9,0
	bc 4,2,.L11
	li 3,1
	b .L23
.L11:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 11,1044(1)
	andi. 0,11,192
	bc 4,2,.L13
	li 3,0
	b .L23
.L13:
	lis 9,value.6@ha
	li 30,0
	stb 30,value.6@l(9)
	la 31,value.6@l(9)
	lwz 3,84(3)
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
	lis 9,dmflags@ha
	lwz 11,dmflags@l(9)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 9,1044(1)
	andi. 0,9,128
	bc 12,2,.L17
	stb 30,0(3)
.L25:
	mr 3,31
	b .L15
.L17:
	addi 3,3,1
.L15:
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
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 11,1044(1)
	andi. 0,11,128
	bc 12,2,.L21
	stb 29,0(3)
.L27:
	mr 3,31
	b .L19
.L21:
	addi 3,3,1
.L19:
	mr 4,3
	mr 3,30
	bl strcpy
	mr 4,27
	addi 3,1,8
	bl strcmp
	subfic 0,3,0
	adde 3,0,3
.L23:
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
	.string	"You must run the server with '+set cheats 1' to enable this command.\n"
	.align 2
.LC2:
	.string	"all"
	.align 2
.LC3:
	.string	"health"
	.align 2
.LC4:
	.string	"weapons"
	.align 2
.LC5:
	.string	"BFG10K"
	.align 2
.LC6:
	.string	"Shotgun"
	.align 2
.LC7:
	.string	"Super Shotgun"
	.align 2
.LC8:
	.string	"Machinegun"
	.align 2
.LC9:
	.string	"Chaingun"
	.align 2
.LC10:
	.string	"Grenade Launcher"
	.align 2
.LC11:
	.string	"Rocket Launcher"
	.align 2
.LC12:
	.string	"Hyperblaster"
	.align 2
.LC13:
	.string	"Railgun"
	.align 2
.LC14:
	.string	"ammo"
	.align 2
.LC15:
	.string	"armor"
	.align 2
.LC16:
	.string	"Jacket Armor"
	.align 2
.LC17:
	.string	"Combat Armor"
	.align 2
.LC18:
	.string	"Body Armor"
	.align 2
.LC19:
	.string	"Power Shield"
	.align 2
.LC20:
	.string	"You can't have the Power Shield\n"
	.align 2
.LC21:
	.string	"Quad Damage"
	.align 2
.LC22:
	.string	"Invulnerability"
	.align 2
.LC23:
	.string	"unknown item\n"
	.align 2
.LC24:
	.string	"non-pickup item\n"
	.align 2
.LC25:
	.string	"You can't have the BFG\n"
	.align 2
.LC26:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Give_f
	.type	 Cmd_Give_f,@function
Cmd_Give_f:
	stwu 1,-80(1)
	mflr 0
	mfcr 12
	stfd 31,72(1)
	stmw 22,32(1)
	stw 0,84(1)
	stw 12,28(1)
	lis 9,deathmatch@ha
	lis 10,.LC26@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC26@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L67
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L67
	lis 5,.LC1@ha
	la 5,.LC1@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L66
.L67:
	lis 9,gi@ha
	la 28,gi@l(9)
	lwz 9,164(28)
	mtlr 9
	blrl
	mr 26,3
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	bl Q_stricmp
	subfic 0,3,0
	adde. 30,0,3
	mfcr 29
	bc 4,2,.L71
	lwz 9,160(28)
	li 3,1
	rlwinm 29,29,16,0xffffffff
	mtcrf 8,29
	rlwinm 29,29,16,0xffffffff
	mtlr 9
	blrl
	lis 4,.LC3@ha
	la 4,.LC3@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L70
.L71:
	lwz 9,156(28)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L72
	lwz 0,160(28)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	stw 3,480(31)
	b .L73
.L72:
	lwz 0,484(31)
	stw 0,480(31)
.L73:
	cmpwi 4,30,0
	bc 12,18,.L66
.L70:
	bc 4,18,.L76
	lis 4,.LC4@ha
	mr 3,26
	la 4,.LC4@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L75
.L76:
	lis 9,game+1556@ha
	li 28,0
	lwz 0,game+1556@l(9)
	lis 25,game@ha
	cmpw 0,28,0
	bc 4,0,.L78
	lis 10,.LC26@ha
	lis 9,itemlist@ha
	la 10,.LC26@l(10)
	la 30,itemlist@l(9)
	lfs 31,0(10)
	li 29,0
.L80:
	mr 27,30
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L79
	lwz 0,56(27)
	andi. 11,0,1
	bc 12,2,.L79
	lwz 3,40(27)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L83
	lis 9,nobfg@ha
	lwz 11,nobfg@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L79
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,8192
	bc 4,2,.L79
.L83:
	lwz 3,40(27)
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L86
	lis 9,noshotgun@ha
	lwz 11,noshotgun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L79
.L86:
	lwz 3,40(27)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L87
	lis 9,nosupershotgun@ha
	lwz 11,nosupershotgun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L79
.L87:
	lwz 3,40(27)
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L88
	lis 9,nomachinegun@ha
	lwz 11,nomachinegun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L79
.L88:
	lwz 3,40(27)
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L89
	lis 9,nochaingun@ha
	lwz 11,nochaingun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L79
.L89:
	lwz 3,40(27)
	lis 4,.LC10@ha
	la 4,.LC10@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L90
	lis 9,nogrenadelauncher@ha
	lwz 11,nogrenadelauncher@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L79
.L90:
	lwz 3,40(27)
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L91
	lis 9,norocketlauncher@ha
	lwz 11,norocketlauncher@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L79
.L91:
	lwz 3,40(27)
	lis 4,.LC12@ha
	la 4,.LC12@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L92
	lis 9,nohyperblaster@ha
	lwz 11,nohyperblaster@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L79
.L92:
	lwz 3,40(27)
	lis 4,.LC13@ha
	la 4,.LC13@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L93
	lis 9,norailgun@ha
	lwz 11,norailgun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L79
.L93:
	lwz 11,84(31)
	addi 11,11,740
	lwzx 9,11,29
	addi 9,9,1
	stwx 9,11,29
.L79:
	la 9,game@l(25)
	addi 28,28,1
	lwz 0,1556(9)
	addi 29,29,4
	addi 30,30,76
	cmpw 0,28,0
	bc 12,0,.L80
.L78:
	bc 12,18,.L66
.L75:
	bc 4,18,.L97
	lis 4,.LC14@ha
	mr 3,26
	la 4,.LC14@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L96
.L97:
	lis 9,game@ha
	li 28,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,28,0
	bc 4,0,.L99
	lis 9,itemlist@ha
	mr 30,11
	la 29,itemlist@l(9)
.L101:
	mr 27,29
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L100
	lwz 0,56(27)
	andi. 9,0,2
	bc 12,2,.L100
	mr 4,27
	mr 3,31
	li 5,1000
	bl Add_Ammo
.L100:
	lwz 0,1556(30)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L101
.L99:
	bc 12,18,.L66
.L96:
	bc 4,18,.L107
	lis 4,.LC15@ha
	mr 3,26
	la 4,.LC15@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L106
.L107:
	lis 3,.LC16@ha
	lis 28,0x286b
	la 3,.LC16@l(3)
	ori 28,28,51739
	bl FindItem
	li 27,0
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC17@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC17@l(11)
	rlwinm 0,0,0,0,29
	stwx 27,9,0
	bl FindItem
	subf 0,29,3
	lwz 9,84(31)
	mullw 0,0,28
	lis 3,.LC18@ha
	addi 9,9,740
	la 3,.LC18@l(3)
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
	bc 12,18,.L66
.L106:
	bc 4,18,.L110
	lis 4,.LC19@ha
	mr 3,26
	la 4,.LC19@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L109
.L110:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,2048
	bc 4,2,.L111
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	bl FindItem
	mr 27,3
	bl G_Spawn
	lwz 0,0(27)
	mr 29,3
	mr 4,27
	stw 0,280(29)
	bl SpawnItem
	mr 3,29
	mr 4,31
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L113
	mr 3,29
	bl G_FreeEdict
	b .L113
.L111:
	lis 9,gi+8@ha
	lis 5,.LC20@ha
	lwz 0,gi+8@l(9)
	la 5,.LC20@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L113:
	bc 12,18,.L66
.L109:
	bc 12,18,.L115
	lis 9,game@ha
	li 28,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,28,0
	bc 4,0,.L66
	lis 9,itemlist@ha
	mr 22,11
	la 29,itemlist@l(9)
	lis 23,.LC21@ha
	lis 9,.LC26@ha
	lis 24,noquad@ha
	la 9,.LC26@l(9)
	lis 25,.LC22@ha
	lfs 31,0(9)
	lis 26,noinvulnerability@ha
	li 30,1
	li 27,0
.L119:
	lwz 0,4(29)
	cmpwi 0,0,0
	bc 12,2,.L118
	lwz 0,56(29)
	andi. 10,0,7
	bc 4,2,.L118
	lwz 3,40(29)
	la 4,.LC21@l(23)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L122
	lwz 9,noquad@l(24)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 4,2,.L118
.L122:
	lwz 3,40(29)
	la 4,.LC22@l(25)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L123
	lwz 9,noinvulnerability@l(26)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 4,2,.L118
.L123:
	lwz 9,84(31)
	addi 9,9,740
	stwx 30,9,27
.L118:
	lwz 0,1556(22)
	addi 28,28,1
	addi 27,27,4
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L119
	b .L66
.L115:
	mr 3,26
	bl FindItem
	mr. 27,3
	bc 4,2,.L125
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	bl FindItem
	mr. 27,3
	bc 4,2,.L125
	lwz 0,8(29)
	lis 5,.LC23@ha
	mr 3,31
	la 5,.LC23@l(5)
	b .L146
.L125:
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 4,2,.L127
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC24@l(5)
	b .L146
.L127:
	lwz 3,40(27)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L128
	lis 9,.LC26@ha
	lis 11,nobfg@ha
	la 9,.LC26@l(9)
	lfs 13,0(9)
	lwz 9,nobfg@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L147
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,8192
	bc 12,2,.L128
.L147:
	lis 9,gi+8@ha
	lis 5,.LC25@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC25@l(5)
.L146:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L66
.L128:
	lwz 3,40(27)
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L131
	lis 9,.LC26@ha
	lis 11,noshotgun@ha
	la 9,.LC26@l(9)
	lfs 13,0(9)
	lwz 9,noshotgun@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L66
.L131:
	lwz 3,40(27)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L132
	lis 9,.LC26@ha
	lis 11,nosupershotgun@ha
	la 9,.LC26@l(9)
	lfs 13,0(9)
	lwz 9,nosupershotgun@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L66
.L132:
	lwz 3,40(27)
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L133
	lis 9,.LC26@ha
	lis 11,nomachinegun@ha
	la 9,.LC26@l(9)
	lfs 13,0(9)
	lwz 9,nomachinegun@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L66
.L133:
	lwz 3,40(27)
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L134
	lis 9,.LC26@ha
	lis 11,nochaingun@ha
	la 9,.LC26@l(9)
	lfs 13,0(9)
	lwz 9,nochaingun@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L66
.L134:
	lwz 3,40(27)
	lis 4,.LC10@ha
	la 4,.LC10@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L135
	lis 9,.LC26@ha
	lis 11,nogrenadelauncher@ha
	la 9,.LC26@l(9)
	lfs 13,0(9)
	lwz 9,nogrenadelauncher@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L66
.L135:
	lwz 3,40(27)
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L136
	lis 9,.LC26@ha
	lis 11,norocketlauncher@ha
	la 9,.LC26@l(9)
	lfs 13,0(9)
	lwz 9,norocketlauncher@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L66
.L136:
	lwz 3,40(27)
	lis 4,.LC12@ha
	la 4,.LC12@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L137
	lis 9,.LC26@ha
	lis 11,nohyperblaster@ha
	la 9,.LC26@l(9)
	lfs 13,0(9)
	lwz 9,nohyperblaster@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L66
.L137:
	lwz 3,40(27)
	lis 4,.LC13@ha
	la 4,.LC13@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L138
	lis 9,.LC26@ha
	lis 11,norailgun@ha
	la 9,.LC26@l(9)
	lfs 13,0(9)
	lwz 9,norailgun@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L66
.L138:
	lwz 3,40(27)
	lis 4,.LC21@ha
	la 4,.LC21@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L139
	lis 9,.LC26@ha
	lis 11,noquad@ha
	la 9,.LC26@l(9)
	lfs 13,0(9)
	lwz 9,noquad@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L66
.L139:
	lwz 3,40(27)
	lis 4,.LC22@ha
	la 4,.LC22@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L140
	lis 9,.LC26@ha
	lis 11,noinvulnerability@ha
	la 9,.LC26@l(9)
	lfs 13,0(9)
	lwz 9,noinvulnerability@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L66
.L140:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,56(27)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,27
	andi. 10,11,2
	mullw 9,9,0
	srawi 28,9,2
	bc 12,2,.L141
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L142
	lwz 0,160(29)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	slwi 0,28,2
	addi 9,9,740
	stwx 3,9,0
	b .L66
.L142:
	lwz 9,84(31)
	slwi 10,28,2
	lwz 11,48(27)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L66
.L141:
	bl G_Spawn
	lwz 0,0(27)
	mr 29,3
	mr 4,27
	stw 0,280(29)
	bl SpawnItem
	mr 4,31
	mr 3,29
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L66
	mr 3,29
	bl G_FreeEdict
.L66:
	lwz 0,84(1)
	lwz 12,28(1)
	mtlr 0
	lmw 22,32(1)
	lfd 31,72(1)
	mtcrf 8,12
	la 1,80(1)
	blr
.Lfe2:
	.size	 Cmd_Give_f,.Lfe2-Cmd_Give_f
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
	.string	"tech"
	.align 2
.LC37:
	.string	"key"
	.align 2
.LC38:
	.string	"This server does not allow dropping of keys\n"
	.align 2
.LC39:
	.string	"Item is not dropable.\n"
	.align 2
.LC40:
	.long 0x0
	.section	".text"
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
	lis 4,.LC36@ha
	la 4,.LC36@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L165
	mr 3,31
	bl CTFWhat_Tech
	mr. 10,3
	bc 12,2,.L165
	lwz 0,12(10)
	mr 3,31
	mr 4,10
	mtlr 0
	blrl
	b .L164
.L165:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 30,3
	lis 4,.LC37@ha
	la 4,.LC37@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L166
	lis 9,.LC40@ha
	lis 11,droppable@ha
	la 9,.LC40@l(9)
	lfs 13,0(9)
	lwz 9,droppable@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L167
	lis 5,.LC38@ha
	mr 3,31
	la 5,.LC38@l(5)
	b .L171
.L167:
	mr 3,31
	bl K2_DropKeyCommand
	mr 3,31
	bl K2_ResetClientKeyVars
	b .L164
.L166:
	mr 3,30
	bl FindItem
	mr. 10,3
	bc 4,2,.L168
	lis 5,.LC33@ha
	mr 3,31
	la 5,.LC33@l(5)
	b .L172
.L168:
	lwz 8,12(10)
	cmpwi 0,8,0
	bc 4,2,.L169
	lis 5,.LC39@ha
	mr 3,31
	la 5,.LC39@l(5)
.L171:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L164
.L169:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L170
	lis 5,.LC35@ha
	mr 3,31
	la 5,.LC35@l(5)
.L172:
	mr 6,30
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L164
.L170:
	mr 3,31
	mr 4,10
	mtlr 8
	blrl
.L164:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 Cmd_Drop_f,.Lfe3-Cmd_Drop_f
	.section	".rodata"
	.align 2
.LC41:
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
	lwz 31,84(30)
	lwz 9,3560(31)
	cmpwi 0,9,0
	bc 12,2,.L174
	bl PMenu_Close
	lwz 9,84(30)
	li 0,1
	stw 0,3976(9)
	b .L173
.L174:
	lwz 0,3564(31)
	cmpwi 0,0,0
	bc 12,2,.L175
	stw 9,3564(31)
	b .L173
.L175:
	lis 9,.LC41@ha
	lis 11,ctf@ha
	la 9,.LC41@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L176
	lwz 0,3468(31)
	cmpwi 0,0,0
	bc 4,2,.L176
	mr 3,30
	bl CTFOpenJoinMenu
	b .L173
.L176:
	lis 9,.LC41@ha
	lis 11,ctf@ha
	la 9,.LC41@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L177
	lwz 9,84(30)
	lwz 0,3520(9)
	cmpwi 0,0,0
	bc 4,2,.L177
	mr 3,30
	bl K2_OpenJoinMenu
	b .L173
.L177:
	li 0,1
	li 11,0
	lis 9,gi@ha
	stw 0,3564(31)
	li 3,5
	la 9,gi@l(9)
	stw 11,3552(31)
	addi 29,31,1760
	lwz 0,100(9)
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L181:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,29
	bc 4,1,.L181
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L173:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 Cmd_Inven_f,.Lfe4-Cmd_Inven_f
	.section	".rodata"
	.align 2
.LC42:
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
	lwz 0,3560(8)
	cmpwi 0,0,0
	bc 12,2,.L184
	bl PMenu_Select
	b .L183
.L184:
	lwz 11,736(8)
	addi 10,8,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L186
	lwz 0,3972(8)
	cmpwi 0,0,0
	bc 12,2,.L189
	mr 3,31
	bl ChaseNext
	b .L186
.L201:
	stw 11,736(8)
	b .L186
.L189:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L202:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L195
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L195
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L201
.L195:
	addi 7,7,1
	bdnz .L202
	li 0,-1
	stw 0,736(8)
.L186:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L199
	lis 5,.LC42@ha
	mr 3,31
	la 5,.LC42@l(5)
	b .L203
.L199:
	mulli 0,0,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L200
	lis 5,.LC34@ha
	mr 3,31
	la 5,.LC34@l(5)
.L203:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L183
.L200:
	mr 3,31
	mtlr 0
	blrl
.L183:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_InvUse_f,.Lfe5-Cmd_InvUse_f
	.section	".rodata"
	.align 2
.LC43:
	.string	"No item to drop.\n"
	.align 2
.LC44:
	.string	"Key"
	.align 2
.LC45:
	.string	"BFK"
	.align 2
.LC46:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_InvDrop_f
	.type	 Cmd_InvDrop_f,@function
Cmd_InvDrop_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	lwz 8,84(30)
	lwz 11,736(8)
	addi 10,8,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L237
	lwz 0,3560(8)
	cmpwi 0,0,0
	bc 12,2,.L238
	bl PMenu_Next
	b .L237
.L238:
	lwz 0,3972(8)
	cmpwi 0,0,0
	bc 12,2,.L240
	mr 3,30
	bl ChaseNext
	b .L237
.L266:
	stw 11,736(8)
	b .L237
.L240:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L269:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L246
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L246
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L266
.L246:
	addi 7,7,1
	bdnz .L269
	li 0,-1
	stw 0,736(8)
.L237:
	lwz 9,84(30)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L250
	lis 5,.LC43@ha
	mr 3,30
	la 5,.LC43@l(5)
	b .L270
.L250:
	lis 11,droppable@ha
	lis 9,.LC46@ha
	mulli 0,0,76
	lwz 10,droppable@l(11)
	la 9,.LC46@l(9)
	lfs 13,0(9)
	lfs 0,20(10)
	lis 9,itemlist@ha
	la 29,itemlist@l(9)
	add 31,0,29
	fcmpu 0,0,13
	bc 12,2,.L251
	lwz 3,40(31)
	lis 4,.LC44@ha
	la 4,.LC44@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L252
	lwz 3,40(31)
	lis 4,.LC45@ha
	la 4,.LC45@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L251
.L252:
	mr 3,30
	bl K2_DropKeyCommand
	mr 3,30
	bl K2_ResetClientKeyVars
	lwz 7,84(30)
	lwz 0,3560(7)
	cmpwi 0,0,0
	bc 12,2,.L253
	mr 3,30
	bl PMenu_Prev
	b .L235
.L253:
	lwz 0,3972(7)
	cmpwi 0,0,0
	bc 12,2,.L255
	mr 3,30
	bl ChasePrev
	b .L235
.L255:
	li 0,256
	lwz 9,736(7)
	mr 5,29
	mtctr 0
	addi 6,7,740
	addi 10,9,255
.L268:
	srawi 0,10,31
	srwi 0,0,24
	add 0,10,0
	rlwinm 0,0,0,0,23
	subf 8,0,10
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L261
	mulli 0,8,76
	add 11,0,5
	lwz 9,8(11)
	cmpwi 0,9,0
	bc 12,2,.L261
	lwz 0,56(11)
	andi. 9,0,32
	bc 4,2,.L267
.L261:
	addi 10,10,-1
	bdnz .L268
	li 0,-1
	stw 0,736(7)
	b .L235
.L251:
	lwz 0,12(31)
	cmpwi 0,0,0
	bc 4,2,.L265
	lis 5,.LC39@ha
	mr 3,30
	la 5,.LC39@l(5)
.L270:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L235
.L267:
	stw 8,736(7)
	b .L235
.L265:
	mr 3,30
	mr 4,31
	mtlr 0
	blrl
.L235:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 Cmd_InvDrop_f,.Lfe6-Cmd_InvDrop_f
	.section	".rodata"
	.align 2
.LC47:
	.string	"%3i %s\n"
	.align 2
.LC48:
	.string	"...\n"
	.align 2
.LC49:
	.string	"%s\n%i players\n"
	.align 2
.LC50:
	.long 0x0
	.align 3
.LC51:
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
	lis 11,.LC50@ha
	lis 9,maxclients@ha
	la 11,.LC50@l(11)
	mr 23,3
	lfs 13,0(11)
	li 27,0
	li 31,0
	lwz 11,maxclients@l(9)
	addi 29,1,1352
	addi 30,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L281
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L283:
	lwz 0,0(11)
	addi 11,11,4088
	cmpwi 0,0,0
	bc 12,2,.L282
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L282:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L283
.L281:
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
	bc 4,0,.L287
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC47@ha
	lis 25,.LC48@ha
.L289:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC47@l(26)
	addi 28,28,4
	mulli 7,7,4088
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
	bc 4,1,.L290
	la 4,.LC48@l(25)
	mr 3,30
	bl strcat
	b .L287
.L290:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L289
.L287:
	lis 5,.LC49@ha
	mr 3,23
	la 5,.LC49@l(5)
	mr 6,30
	mr 7,27
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 0,2436(1)
	mtlr 0
	lmw 23,2396(1)
	la 1,2432(1)
	blr
.Lfe7:
	.size	 Cmd_Players_f,.Lfe7-Cmd_Players_f
	.section	".rodata"
	.align 2
.LC52:
	.string	"flipoff\n"
	.align 2
.LC53:
	.string	"salute\n"
	.align 2
.LC54:
	.string	"taunt\n"
	.align 2
.LC55:
	.string	"wave\n"
	.align 2
.LC56:
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
	bc 4,2,.L292
	lwz 0,3760(9)
	cmpwi 0,0,1
	bc 12,1,.L292
	cmplwi 0,3,4
	li 0,1
	stw 0,3760(9)
	bc 12,1,.L301
	lis 11,.L302@ha
	slwi 10,3,2
	la 11,.L302@l(11)
	lis 9,.L302@ha
	lwzx 0,10,11
	la 9,.L302@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L302:
	.long .L296-.L302
	.long .L297-.L302
	.long .L298-.L302
	.long .L299-.L302
	.long .L301-.L302
.L296:
	lis 5,.LC52@ha
	mr 3,31
	la 5,.LC52@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 11,84(31)
	li 0,71
	li 9,83
	b .L303
.L297:
	lis 5,.LC53@ha
	mr 3,31
	la 5,.LC53@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 11,84(31)
	li 0,83
	li 9,94
	b .L303
.L298:
	lis 5,.LC54@ha
	mr 3,31
	la 5,.LC54@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 11,84(31)
	li 0,94
	li 9,111
	b .L303
.L299:
	lis 5,.LC55@ha
	mr 3,31
	la 5,.LC55@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 11,84(31)
	li 0,111
	li 9,122
	b .L303
.L301:
	lis 5,.LC56@ha
	mr 3,31
	la 5,.LC56@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 11,84(31)
	li 0,122
	li 9,134
.L303:
	stw 0,56(31)
	stw 9,3756(11)
.L292:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 Cmd_Wave_f,.Lfe8-Cmd_Wave_f
	.section	".rodata"
	.align 2
.LC57:
	.string	"You are in Spectator mode.\nType \"spectator 0\" at the console\nto rejoin the game"
	.align 2
.LC58:
	.string	"\nTeams not available in CTF mode.\nUse \"sv bluebots <name1> <name2> ..\" and \"sv bluebots <name1> <name2> ..\" to spawn groups of bots in CTF.\n"
	.align 2
.LC59:
	.string	"\nYou are already a member of a team.\nYou must disconnect to change teams.\n\n"
	.align 2
.LC60:
	.string	"Team \"%s\" does not exist.\n"
	.align 2
.LC61:
	.string	"Team \"%s\" is full.\n"
	.align 2
.LC62:
	.string	"%s has joined team %s\n"
	.align 2
.LC63:
	.long 0x0
	.align 3
.LC64:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_Join_f
	.type	 Cmd_Join_f,@function
Cmd_Join_f:
	stwu 1,-576(1)
	mflr 0
	stmw 25,548(1)
	stw 0,580(1)
	lis 11,.LC63@ha
	lis 9,ctf@ha
	la 11,.LC63@l(11)
	mr 29,3
	lfs 13,0(11)
	mr 27,4
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L305
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L305
	lwz 9,84(29)
	lwz 0,3520(9)
	cmpwi 0,0,0
	bc 4,2,.L306
	li 4,0
	bl K2EnterGame
	b .L304
.L306:
	lwz 0,3508(9)
	cmpwi 0,0,0
	bc 12,2,.L304
	lis 4,.LC57@ha
	mr 3,29
	la 4,.LC57@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L304
.L305:
	lis 9,.LC63@ha
	lis 11,ctf@ha
	la 9,.LC63@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L309
	lis 5,.LC58@ha
	mr 3,29
	la 5,.LC58@l(5)
	b .L324
.L309:
	lwz 9,84(29)
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 12,2,.L310
	lis 5,.LC59@ha
	mr 3,29
	la 5,.LC59@l(5)
.L324:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L304
.L322:
	lis 5,.LC60@ha
	mr 3,29
	la 5,.LC60@l(5)
	mr 6,27
	b .L325
.L323:
	lis 5,.LC61@ha
	lwz 6,0(6)
	mr 3,29
	la 5,.LC61@l(5)
.L325:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L304
.L310:
	lis 26,bot_teams@ha
	li 31,0
	la 28,bot_teams@l(26)
	lis 25,0x4330
	li 30,0
.L314:
	lwzx 3,30,28
	cmpwi 0,3,0
	bc 12,2,.L322
	lwz 0,140(3)
	cmpwi 0,0,0
	bc 4,2,.L316
	lis 9,.LC63@ha
	lis 11,dedicated@ha
	la 9,.LC63@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L313
.L316:
	lwz 3,0(3)
	mr 4,27
	bl strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L318
	lwzx 9,30,28
	mr 4,27
	lwz 3,4(9)
	bl strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L313
.L318:
	lwzx 6,30,28
	lis 9,.LC64@ha
	la 9,.LC64@l(9)
	lwz 0,148(6)
	lfd 12,0(9)
	xoris 0,0,0x8000
	lis 9,players_per_team@ha
	stw 0,540(1)
	stw 25,536(1)
	lfd 0,536(1)
	lwz 10,players_per_team@l(9)
	fsub 0,0,12
	lfs 13,20(10)
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L319
	lwz 0,152(6)
	cmpwi 0,0,0
	bc 12,2,.L323
.L319:
	la 31,bot_teams@l(26)
	lwzx 9,31,30
	lwz 11,148(9)
	addi 11,11,1
	stw 11,148(9)
	lwzx 10,31,30
	lwz 3,8(10)
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L320
	lwz 4,84(29)
	addi 3,1,8
	addi 4,4,188
	bl strcpy
	lwzx 9,31,30
	lis 4,.LC0@ha
	addi 3,1,8
	la 4,.LC0@l(4)
	lwz 5,8(9)
	bl Info_SetValueForKey
	mr 3,29
	addi 4,1,8
	bl ClientUserinfoChanged
.L320:
	lwz 11,84(29)
	li 10,1
	lis 4,.LC62@ha
	lwzx 0,31,30
	la 4,.LC62@l(4)
	li 3,2
	stw 0,3912(11)
	lwzx 9,31,30
	stw 10,140(9)
	lwzx 11,31,30
	lwz 5,84(29)
	lwz 6,0(11)
	addi 5,5,700
	crxor 6,6,6
	bl my_bprintf
	b .L304
.L313:
	addi 31,31,1
	addi 30,30,4
	cmpwi 0,31,63
	bc 4,1,.L314
.L304:
	lwz 0,580(1)
	mtlr 0
	lmw 25,548(1)
	la 1,576(1)
	blr
.Lfe9:
	.size	 Cmd_Join_f,.Lfe9-Cmd_Join_f
	.section	".rodata"
	.align 2
.LC65:
	.string	"Latency set to %i\n"
	.align 2
.LC66:
	.string	"lag must be lower than 1000\n"
	.align 2
.LC67:
	.string	"lag must be higher than 0\n"
	.align 2
.LC68:
	.string	"\nTeams not available in CTF mode.\nUse \"sv bluebots <name1> <name2> ..\" and \"sv redbots <name1> <name2> ..\" to spawn groups of bots in CTF.\n\n"
	.align 2
.LC69:
	.string	"\n=====================================\nAvailable teams:\n\n"
	.align 2
.LC70:
	.string	"%s "
	.align 2
.LC71:
	.string	"%s(%s)"
	.align 2
.LC72:
	.string	"%i plyrs"
	.align 2
.LC73:
	.string	" (%i bots)\n"
	.align 2
.LC74:
	.string	"\n"
	.align 2
.LC75:
	.string	"[none]\n"
	.align 2
.LC76:
	.string	"\n=====================================\n"
	.align 2
.LC77:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Teams_f
	.type	 Cmd_Teams_f,@function
Cmd_Teams_f:
	stwu 1,-320(1)
	mflr 0
	stmw 21,276(1)
	stw 0,324(1)
	lis 11,.LC77@ha
	lis 9,ctf@ha
	la 11,.LC77@l(11)
	mr 28,3
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L332
	lis 5,.LC68@ha
	la 5,.LC68@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L331
.L332:
	lis 5,.LC69@ha
	mr 3,28
	la 5,.LC69@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	li 27,0
	lis 21,bot_teams@ha
	lis 9,bot_teams@ha
	la 9,bot_teams@l(9)
	lwzx 0,9,27
	cmpwi 0,0,0
	bc 12,2,.L334
	mr 24,9
	li 22,32
	li 23,0
.L337:
	slwi 9,27,2
	lwzx 6,24,9
	mr 29,9
	lwz 0,140(6)
	cmpwi 0,0,0
	bc 4,2,.L338
	lis 11,.LC77@ha
	lis 9,dedicated@ha
	la 11,.LC77@l(11)
	addi 26,27,1
	lfs 13,0(11)
	lwz 11,dedicated@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L335
.L338:
	lwz 6,0(6)
	lis 5,.LC70@ha
	mr 3,28
	la 5,.LC70@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	li 31,0
	addi 30,1,8
	addi 26,27,1
	lis 27,.LC71@ha
	b .L339
.L342:
	stbx 22,30,31
	addi 31,31,1
.L339:
	lwzx 9,24,29
	lwz 3,0(9)
	bl strlen
	subfic 3,3,15
	cmplw 0,31,3
	bc 12,0,.L342
	lwzx 9,24,29
	la 5,.LC71@l(27)
	mr 3,28
	stbx 23,30,31
	li 4,2
	mr 6,30
	lwz 7,4(9)
	li 31,0
	li 25,32
	crxor 6,6,6
	bl safe_cprintf
	lis 9,bot_teams@ha
	la 27,bot_teams@l(9)
	b .L344
.L347:
	stbx 25,30,31
	addi 31,31,1
.L344:
	lwzx 9,27,29
	lwz 3,4(9)
	bl strlen
	subfic 3,3,4
	cmplw 0,31,3
	bc 12,0,.L347
	stbx 23,30,31
	mr 5,30
	mr 3,28
	li 4,2
	la 31,bot_teams@l(21)
	crxor 6,6,6
	bl safe_cprintf
	lwzx 9,31,29
	lwz 0,140(9)
	cmpwi 0,0,0
	bc 12,2,.L349
	lwz 6,148(9)
	lis 5,.LC72@ha
	mr 3,28
	la 5,.LC72@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwzx 9,31,29
	lwz 6,152(9)
	cmpwi 0,6,0
	bc 12,2,.L350
	lis 5,.LC73@ha
	mr 3,28
	la 5,.LC73@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L350:
	lis 5,.LC74@ha
	mr 3,28
	la 5,.LC74@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L335
.L349:
	lis 5,.LC75@ha
	mr 3,28
	la 5,.LC75@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L335:
	cmpwi 0,26,63
	mr 27,26
	bc 12,1,.L334
	slwi 0,26,2
	lwzx 9,24,0
	cmpwi 0,9,0
	bc 4,2,.L337
.L334:
	lis 5,.LC76@ha
	mr 3,28
	la 5,.LC76@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L331:
	lwz 0,324(1)
	mtlr 0
	lmw 21,276(1)
	la 1,320(1)
	blr
.Lfe10:
	.size	 Cmd_Teams_f,.Lfe10-Cmd_Teams_f
	.section	".rodata"
	.align 2
.LC78:
	.ascii	"\n=================================\nSERVER ONLY COMMANDS:\n"
	.ascii	"\n \"bot_num <n>\" - sets the maximum number of bots at once"
	.ascii	" to <n>\n\n \"bot_name <name>\" - spawns a specific bot\n\n "
	.ascii	"\"bot_free_clients <n"
	.string	">\" - makes sure there are always <n> free client spots\n\n \"bot_calc_nodes 0/1\" - Enable/Disable dynamic node-table calculation\n\n \"bot_allow_client_commands <n>\" - set to 1 to allow clients to spawn bots via \"cmd bots <n>\"\n=================================\n\n"
	.align 2
.LC79:
	.string	"\nERASER TIPS:\n\n * Set \"skill 0-3\" to vary the difficulty of your opponents (1 is default)\n\n * You can create your own bots by editing the file BOTS.CFG in the Eraser directory\n\n * Set \"maxclients 32\" to allow play against more bots\n\n"
	.align 2
.LC80:
	.string	"Showing path for %s\n"
	.align 2
.LC81:
	.string	"(%s): "
	.align 2
.LC82:
	.string	"%s: "
	.align 2
.LC83:
	.string	" "
	.align 2
.LC84:
	.string	"You can't talk for %d more seconds\n"
	.align 2
.LC85:
	.string	"Flood protection:  You can't talk for %d seconds.\n"
	.align 2
.LC86:
	.string	"%s"
	.align 2
.LC87:
	.long 0x0
	.align 3
.LC88:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC89:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Cmd_Say_f
	.type	 Cmd_Say_f,@function
Cmd_Say_f:
	stwu 1,-2096(1)
	mflr 0
	mfcr 12
	stmw 25,2068(1)
	stw 0,2100(1)
	stw 12,2064(1)
	lis 9,gi+156@ha
	mr 28,3
	lwz 0,gi+156@l(9)
	mr 30,4
	mr 31,5
	mtlr 0
	blrl
	cmpwi 0,3,1
	bc 12,1,.L361
	cmpwi 0,31,0
	bc 12,2,.L360
.L361:
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,2056(1)
	lwz 9,2060(1)
	rlwinm 9,9,0,24,25
	neg 9,9
	srawi 9,9,31
	and. 30,30,9
	bc 12,2,.L363
	lwz 6,84(28)
	lis 5,.LC81@ha
	addi 3,1,8
	la 5,.LC81@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L364
.L363:
	lwz 6,84(28)
	lis 5,.LC82@ha
	addi 3,1,8
	la 5,.LC82@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L364:
	cmpwi 0,31,0
	bc 12,2,.L365
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC83@ha
	addi 3,1,8
	la 4,.LC83@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L366
.L365:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L367
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
.L367:
	mr 4,29
	addi 3,1,8
	bl strcat
.L366:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L368
	li 0,0
	stb 0,158(1)
.L368:
	lis 4,.LC74@ha
	addi 3,1,8
	la 4,.LC74@l(4)
	bl strcat
	lis 9,.LC87@ha
	la 9,.LC87@l(9)
	lfs 8,0(9)
	lis 9,flood_msgs@ha
	lwz 11,flood_msgs@l(9)
	lfs 9,20(11)
	fcmpu 0,9,8
	bc 12,2,.L369
	lwz 7,84(28)
	lis 9,level+4@ha
	lfs 10,level+4@l(9)
	lfs 0,3808(7)
	fcmpu 0,10,0
	bc 4,0,.L370
	fsubs 0,0,10
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC84@ha
	mr 3,28
	la 5,.LC84@l(5)
	li 4,2
	mtlr 0
	fctiwz 13,0
	stfd 13,2056(1)
	b .L384
.L370:
	lwz 0,3852(7)
	lis 10,0x4330
	lis 11,.LC88@ha
	addi 8,7,3812
	mr 6,0
	la 11,.LC88@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,2060(1)
	lis 11,.LC89@ha
	stw 10,2056(1)
	la 11,.LC89@l(11)
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
	bc 12,2,.L372
	lis 11,flood_persecond@ha
	fsubs 13,10,0
	lwz 9,flood_persecond@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L372
	lis 9,flood_waitdelay@ha
	lis 10,gi+8@ha
	lwz 11,flood_waitdelay@l(9)
	lis 5,.LC85@ha
	mr 3,28
	la 5,.LC85@l(5)
	lfs 13,20(11)
	li 4,3
	fadds 13,10,13
	stfs 13,3808(7)
	lfs 0,20(11)
	lwz 0,gi+8@l(10)
	mtlr 0
	fctiwz 12,0
	stfd 12,2056(1)
.L384:
	lwz 6,2060(1)
	crxor 6,6,6
	blrl
	b .L360
.L372:
	lis 0,0xcccc
	addi 9,6,1
	ori 0,0,52429
	lis 11,level+4@ha
	mulhwu 0,9,0
	srwi 0,0,3
	mulli 0,0,10
	subf 9,0,9
	stw 9,3852(7)
	lfs 0,level+4@l(11)
	slwi 9,9,2
	stfsx 0,10,9
.L369:
	lis 9,.LC87@ha
	lis 11,dedicated@ha
	la 9,.LC87@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L373
	lis 9,gi+8@ha
	lis 5,.LC86@ha
	lwz 0,gi+8@l(9)
	la 5,.LC86@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L373:
	lis 9,game@ha
	li 31,1
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,31,0
	bc 12,1,.L360
	cmpwi 4,30,0
	mr 25,9
	lis 26,g_edicts@ha
	lis 27,.LC86@ha
	li 30,1352
.L377:
	lwz 0,g_edicts@l(26)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L376
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L376
	lwz 0,968(29)
	cmpwi 0,0,0
	bc 4,2,.L376
	bc 12,18,.L381
	mr 3,28
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L376
.L381:
	mr 3,29
	li 4,3
	la 5,.LC86@l(27)
	addi 6,1,8
	crxor 6,6,6
	bl safe_cprintf
.L376:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,1352
	cmpw 0,31,0
	bc 4,1,.L377
.L360:
	lwz 0,2100(1)
	lwz 12,2064(1)
	mtlr 0
	lmw 25,2068(1)
	mtcrf 8,12
	la 1,2096(1)
	blr
.Lfe11:
	.size	 Cmd_Say_f,.Lfe11-Cmd_Say_f
	.section	".rodata"
	.align 2
.LC90:
	.string	"%02d:%02d %4d %3d %s%s\n"
	.align 2
.LC91:
	.string	" (spectator)"
	.align 2
.LC92:
	.string	""
	.align 2
.LC93:
	.string	"And more...\n"
	.align 2
.LC94:
	.long 0x0
	.align 3
.LC95:
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
	lis 9,.LC94@ha
	stb 0,96(1)
	li 28,0
	la 9,.LC94@l(9)
	lfs 0,20(11)
	lis 22,maxclients@ha
	lfs 13,0(9)
	addi 31,1,96
	lis 21,gi@ha
	lwz 9,g_edicts@l(10)
	lis 20,.LC86@ha
	fcmpu 0,13,0
	addi 30,9,1352
	bc 4,0,.L387
	lis 9,.LC91@ha
	lis 11,.LC92@ha
	la 23,.LC91@l(9)
	la 24,.LC92@l(11)
	lis 25,level@ha
	lis 26,0x4330
.L389:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L388
	lwz 10,84(30)
	lis 11,0x1b4e
	lis 8,0x6666
	lwz 9,level@l(25)
	ori 11,11,33205
	ori 8,8,26215
	lwz 0,3460(10)
	addi 29,10,700
	lwz 7,3508(10)
	subf 9,0,9
	lwz 3,184(10)
	mulhw 11,9,11
	lwz 4,3464(10)
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
	bc 12,2,.L391
	stw 23,8(1)
	b .L392
.L391:
	stw 24,8(1)
.L392:
	mr 8,3
	mr 9,4
	lis 5,.LC90@ha
	mr 10,29
	addi 3,1,16
	la 5,.LC90@l(5)
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
	bc 4,1,.L393
	mr 3,31
	bl strlen
	lis 4,.LC93@ha
	add 3,31,3
	la 4,.LC93@l(4)
	crxor 6,6,6
	bl sprintf
	la 9,gi@l(21)
	mr 3,27
	lwz 0,8(9)
	la 5,.LC86@l(20)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L385
.L393:
	mr 3,31
	addi 4,1,16
	bl strcat
.L388:
	addi 28,28,1
	lwz 11,maxclients@l(22)
	xoris 0,28,0x8000
	lis 10,.LC95@ha
	stw 0,1516(1)
	la 10,.LC95@l(10)
	addi 30,30,1352
	stw 26,1512(1)
	lfd 13,0(10)
	lfd 0,1512(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L389
.L387:
	lis 9,gi+8@ha
	lis 5,.LC86@ha
	lwz 0,gi+8@l(9)
	mr 3,27
	la 5,.LC86@l(5)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L385:
	lwz 0,1572(1)
	mtlr 0
	lmw 20,1520(1)
	la 1,1568(1)
	blr
.Lfe12:
	.size	 Cmd_PlayerList_f,.Lfe12-Cmd_PlayerList_f
	.section	".rodata"
	.align 2
.LC96:
	.long 0x0
	.section	".text"
	.align 2
	.globl FlagPathTouch
	.type	 FlagPathTouch,@function
FlagPathTouch:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 26,8(1)
	stw 0,52(1)
	mr 30,4
	mr 29,3
	lwz 0,968(30)
	cmpwi 0,0,0
	bc 12,2,.L395
	lwz 9,892(29)
	cmpwi 0,9,0
	bc 4,2,.L397
	lwz 0,1168(30)
	cmpw 0,0,29
	bc 4,2,.L395
	stw 9,1168(30)
	b .L395
.L397:
	lwz 9,84(30)
	lwz 11,1076(29)
	lwz 0,3468(9)
	cmpw 0,0,11
	bc 4,2,.L395
	lwz 0,1168(30)
	cmpwi 0,0,0
	bc 4,2,.L395
	mr 3,30
	bl CarryingFlag
	cmpwi 0,3,0
	bc 12,2,.L395
	lwz 0,892(29)
	cmpwi 0,0,0
	bc 12,2,.L403
	lwz 0,1168(30)
	cmpwi 0,0,0
	bc 4,2,.L395
	lis 9,num_players@ha
	li 28,0
	lwz 0,num_players@l(9)
	lis 26,num_players@ha
	lis 9,.LC96@ha
	la 9,.LC96@l(9)
	cmpw 0,28,0
	lfs 30,0(9)
	lis 9,.LC96@ha
	la 9,.LC96@l(9)
	lfs 31,0(9)
	bc 4,0,.L406
	lis 9,players@ha
	li 31,0
	la 27,players@l(9)
.L408:
	lwzx 4,31,27
	lwz 9,84(4)
	lwz 11,3468(9)
	cmpwi 0,11,0
	bc 12,2,.L407
	lwz 9,84(30)
	lwz 0,3468(9)
	cmpw 0,11,0
	bc 12,2,.L407
	lwz 3,892(29)
	bl entdist
	lwz 3,324(29)
	fadds 31,31,1
	lwzx 4,31,27
	bl entdist
	fadds 30,30,1
.L407:
	lwz 0,num_players@l(26)
	addi 28,28,1
	addi 31,31,4
	cmpw 0,28,0
	bc 12,0,.L408
.L406:
	fcmpu 0,31,30
	bc 4,1,.L411
	lwz 0,892(29)
	b .L403
.L411:
	lwz 0,324(29)
.L403:
	stw 0,1168(30)
.L395:
	lwz 0,52(1)
	mtlr 0
	lmw 26,8(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 FlagPathTouch,.Lfe13-FlagPathTouch
	.globl flagpaths
	.section	".data"
	.align 2
	.type	 flagpaths,@object
	.size	 flagpaths,12
flagpaths:
	.long 0
	.long 0
	.long 0
	.section	".sdata","aw"
	.align 2
	.type	 flagpath_type.106,@object
	.size	 flagpath_type.106,4
flagpath_type.106:
	.long 0
	.section	".rodata"
	.align 2
.LC97:
	.string	"Incomplete FlagPath, starting a new path.\n"
	.align 2
.LC98:
	.string	"flag_path_src"
	.align 2
.LC99:
	.string	"Flagpath SOURCE dropped.\n"
	.align 2
.LC100:
	.string	"flag_path_dest"
	.align 2
.LC101:
	.string	"Flagpath DEST 1 dropped.\n"
	.align 2
.LC102:
	.string	"Flagpath DEST 2 dropped.\nSequence complete.\n\n"
	.section	".text"
	.align 2
	.globl FlagPath
	.type	 FlagPath,@function
FlagPath:
	stwu 1,-64(1)
	mflr 0
	stmw 21,20(1)
	stw 0,68(1)
	lis 9,flagpath_type.106@ha
	mr 28,3
	lwz 0,flagpath_type.106@l(9)
	mr 26,4
	lis 31,flagpath_type.106@ha
	cmpwi 0,0,0
	bc 4,2,.L415
	lis 9,flagpaths@ha
	la 31,flagpaths@l(9)
	lwzx 0,31,0
	cmpwi 0,0,0
	bc 12,2,.L416
	lwz 0,84(28)
	cmpwi 0,0,0
	bc 12,2,.L416
	lis 5,.LC97@ha
	la 5,.LC97@l(5)
	li 4,2
	mr 30,31
	crxor 6,6,6
	bl safe_cprintf
	li 27,0
	li 31,0
	li 29,3
.L421:
	lwzx 3,31,30
	bl G_FreeEdict
	addic. 29,29,-1
	stwx 27,31,30
	addi 31,31,4
	bc 4,2,.L421
.L416:
	bl G_Spawn
	lis 9,flagpath_type.106@ha
	lis 10,flagpaths@ha
	lwz 0,flagpath_type.106@l(9)
	la 10,flagpaths@l(10)
	li 8,0
	lis 9,.LC98@ha
	slwi 0,0,2
	la 9,.LC98@l(9)
	stwx 3,10,0
	stw 9,280(3)
	lfs 0,4(28)
	lwzx 11,10,0
	stfs 0,4(11)
	lfs 0,8(28)
	lwzx 9,10,0
	stfs 0,8(9)
	lfs 0,12(28)
	lwzx 11,10,0
	stfs 0,12(11)
	lwzx 9,10,0
	stw 8,892(9)
	lwzx 11,10,0
	stw 8,324(11)
	lwzx 9,10,0
	stw 26,1076(9)
	lwz 0,84(28)
	cmpwi 0,0,0
	bc 12,2,.L424
	lis 5,.LC99@ha
	mr 3,28
	la 5,.LC99@l(5)
	b .L435
.L415:
	cmpwi 0,0,1
	bc 4,2,.L425
	bl G_Spawn
	lwz 0,flagpath_type.106@l(31)
	lis 6,flagpaths@ha
	lis 9,.LC100@ha
	la 10,flagpaths@l(6)
	la 9,.LC100@l(9)
	slwi 0,0,2
	li 8,0
	stwx 3,10,0
	li 7,-1
	stw 9,280(3)
	lfs 0,4(28)
	lwzx 11,10,0
	stfs 0,4(11)
	lfs 0,8(28)
	lwzx 9,10,0
	stfs 0,8(9)
	lfs 0,12(28)
	lwzx 11,10,0
	stfs 0,12(11)
	lwzx 9,10,0
	stw 8,892(9)
	lwzx 11,10,0
	stw 8,324(11)
	lwzx 9,10,0
	stw 7,1176(9)
	lwzx 11,10,0
	lwz 9,flagpaths@l(6)
	stw 11,892(9)
	lwz 0,84(28)
	cmpwi 0,0,0
	bc 12,2,.L424
	lis 5,.LC101@ha
	mr 3,28
	la 5,.LC101@l(5)
.L435:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L424
.L425:
	cmpwi 0,0,2
	bc 4,2,.L424
	bl G_Spawn
	li 21,1
	lis 26,0xc180
	lwz 10,flagpath_type.106@l(31)
	lis 6,flagpaths@ha
	lis 9,.LC100@ha
	la 8,flagpaths@l(6)
	la 9,.LC100@l(9)
	slwi 10,10,2
	lis 11,gi@ha
	stwx 3,8,10
	la 23,gi@l(11)
	li 0,0
	stw 9,280(3)
	li 5,-1
	mr 30,8
	lfs 0,4(28)
	lis 9,FlagPathTouch@ha
	lis 27,0x4180
	lwzx 7,8,10
	la 22,FlagPathTouch@l(9)
	lis 24,0x4080
	li 25,0
	li 31,0
	stfs 0,4(7)
	li 29,3
	lfs 0,8(28)
	lwzx 9,8,10
	stfs 0,8(9)
	lfs 0,12(28)
	lwzx 11,8,10
	stfs 0,12(11)
	lwzx 9,8,10
	stw 0,892(9)
	lwzx 11,8,10
	stw 0,324(11)
	lwzx 9,8,10
	stw 5,1176(9)
	lwz 11,flagpaths@l(6)
	lwzx 0,8,10
	stw 0,324(11)
.L432:
	lwzx 9,31,30
	stw 21,248(9)
	lwzx 11,31,30
	stw 26,188(11)
	lwzx 9,31,30
	stw 26,192(9)
	lwzx 11,31,30
	stw 26,196(11)
	lwzx 9,31,30
	stw 27,200(9)
	lwzx 11,31,30
	stw 27,204(11)
	lwzx 9,31,30
	stw 24,208(9)
	lwzx 11,31,30
	stw 22,444(11)
	lwz 9,72(23)
	lwzx 3,31,30
	mtlr 9
	blrl
	addic. 29,29,-1
	stwx 25,31,30
	addi 31,31,4
	bc 4,2,.L432
	lwz 11,84(28)
	lis 9,flagpath_type.106@ha
	li 0,-1
	stw 0,flagpath_type.106@l(9)
	cmpwi 0,11,0
	bc 12,2,.L424
	lis 5,.LC102@ha
	mr 3,28
	la 5,.LC102@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lis 9,dropped_trail@ha
	li 0,1
	stw 0,dropped_trail@l(9)
.L424:
	lis 11,flagpath_type.106@ha
	lwz 9,flagpath_type.106@l(11)
	addi 9,9,1
	stw 9,flagpath_type.106@l(11)
	lwz 0,68(1)
	mtlr 0
	lmw 21,20(1)
	la 1,64(1)
	blr
.Lfe14:
	.size	 FlagPath,.Lfe14-FlagPath
	.section	".rodata"
	.align 2
.LC103:
	.string	"You need the Anti-Key to take someone's key\n"
	.align 2
.LC104:
	.string	"Feigning is not allowed\n"
	.align 2
.LC105:
	.string	"Grenades"
	.align 2
.LC106:
	.string	"No Grenades\n"
	.align 2
.LC107:
	.string	"Flash Grenades Selected\n"
	.align 2
.LC108:
	.string	"Standard Grenades Selected\n"
	.align 2
.LC109:
	.string	"Freeze Grenades Selected\n"
	.align 2
.LC110:
	.string	"You don't have the Rocket Launcher\n"
	.align 2
.LC111:
	.string	"You don't have the Grenade Launcher\n"
	.align 2
.LC112:
	.string	"Blaster"
	.align 2
.LC113:
	.string	"You don't have the Blaster\n"
	.align 2
.LC114:
	.string	"help"
	.align 2
.LC115:
	.string	"Now close the console to view the help menu...\n"
	.align 2
.LC116:
	.string	"Server has disabled bot commands\n"
	.align 2
.LC117:
	.string	"Usage: botnum <n> where n is the number of bots you want in the game."
	.align 2
.LC118:
	.string	"Only %i bots allowed in game\n"
	.align 2
.LC119:
	.string	"bot_num"
	.align 2
.LC120:
	.string	"Try this command again later\n"
	.align 2
.LC121:
	.long 0x0
	.align 2
.LC122:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl Cmd_Bot_f
	.type	 Cmd_Bot_f,@function
Cmd_Bot_f:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 11,.LC121@ha
	lis 9,bot_allow_client_commands@ha
	la 11,.LC121@l(11)
	mr 29,3
	lfs 12,0(11)
	lwz 11,bot_allow_client_commands@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 4,2,.L481
	lis 9,gi+8@ha
	lis 5,.LC116@ha
	lwz 0,gi+8@l(9)
	la 5,.LC116@l(5)
	b .L503
.L481:
	lwz 9,84(29)
	lfs 13,4080(9)
	fcmpu 0,13,12
	bc 12,2,.L483
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L482
.L483:
	lis 9,gi@ha
	li 3,1
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	lis 4,.LC92@ha
	la 4,.LC92@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L484
	lwz 0,8(30)
	lis 5,.LC117@ha
	mr 3,29
	la 5,.LC117@l(5)
.L503:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L480
.L484:
	lwz 9,160(30)
	li 3,1
	mtlr 9
	blrl
	bl atoi
	mr. 0,3
	bc 12,0,.L480
	lis 11,maxbots@ha
	lwz 9,maxbots@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 6,20(1)
	cmpw 0,0,6
	bc 4,1,.L486
	lwz 0,8(30)
	lis 5,.LC118@ha
	mr 3,29
	la 5,.LC118@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L480
.L486:
	lis 10,bot_num@ha
	lwz 8,160(30)
	lwz 11,bot_num@l(10)
	li 3,1
	mtlr 8
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	subf 31,0,9
	blrl
	mr 4,3
	lwz 0,148(30)
	lis 3,.LC119@ha
	la 3,.LC119@l(3)
	mtlr 0
	blrl
	cmpwi 0,31,0
	bc 4,1,.L487
	lis 26,bot_count@ha
	lis 27,num_players@ha
	lis 28,players@ha
	lis 30,num_players@ha
.L490:
	lwz 0,bot_count@l(26)
	addi 31,31,-1
	cmpwi 0,0,0
	bc 4,1,.L491
	lwz 0,num_players@l(27)
	li 3,0
	cmpw 0,3,0
	bc 4,0,.L493
	lwz 0,num_players@l(30)
	la 7,players@l(28)
	mtctr 0
.L495:
	lwz 8,0(7)
	addi 7,7,4
	lwz 0,968(8)
	cmpwi 0,0,0
	bc 12,2,.L494
	cmpwi 0,3,0
	bc 12,2,.L498
	lwz 9,84(8)
	lwz 11,84(3)
	lwz 10,3464(9)
	lwz 0,3464(11)
	cmpw 0,10,0
	bc 4,0,.L494
.L498:
	mr 3,8
.L494:
	bdnz .L495
.L493:
	cmpwi 0,3,0
	bc 12,2,.L491
	bl botDisconnect
.L491:
	mr. 31,31
	bc 12,1,.L490
.L487:
	lis 11,.LC122@ha
	lis 9,level+4@ha
	la 11,.LC122@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	lwz 11,84(29)
	fadds 0,0,13
	stfs 0,4080(11)
	b .L480
.L482:
	lis 9,gi+8@ha
	lis 5,.LC120@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC120@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L480:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 Cmd_Bot_f,.Lfe15-Cmd_Bot_f
	.section	".rodata"
	.align 2
.LC123:
	.string	"players"
	.align 2
.LC124:
	.string	"say"
	.align 2
.LC125:
	.string	"say_team"
	.align 2
.LC126:
	.string	"steam"
	.align 2
.LC127:
	.string	"score"
	.align 2
.LC128:
	.string	"use"
	.align 2
.LC129:
	.string	"drop"
	.align 2
.LC130:
	.string	"give"
	.align 2
.LC131:
	.string	"god"
	.align 2
.LC132:
	.string	"notarget"
	.align 2
.LC133:
	.string	"noclip"
	.align 2
.LC134:
	.string	"inven"
	.align 2
.LC135:
	.string	"invnext"
	.align 2
.LC136:
	.string	"invprev"
	.align 2
.LC137:
	.string	"invnextw"
	.align 2
.LC138:
	.string	"invprevw"
	.align 2
.LC139:
	.string	"invnextp"
	.align 2
.LC140:
	.string	"invprevp"
	.align 2
.LC141:
	.string	"invuse"
	.align 2
.LC142:
	.string	"invdrop"
	.align 2
.LC143:
	.string	"weapprev"
	.align 2
.LC144:
	.string	"weapnext"
	.align 2
.LC145:
	.string	"weaplast"
	.align 2
.LC146:
	.string	"kill"
	.align 2
.LC147:
	.string	"putaway"
	.align 2
.LC148:
	.string	"wave"
	.align 2
.LC149:
	.string	"playerlist"
	.align 2
.LC150:
	.string	"botname"
	.align 2
.LC151:
	.string	"\nThis command is not used anymore.\nUse botnum # to spawn some bots.\n\n"
	.align 2
.LC152:
	.string	"bots"
	.align 2
.LC153:
	.string	"\nThis command is not used anymore.\nUse bot_num # to spawn some bots.\n\n"
	.align 2
.LC154:
	.string	"servcmd"
	.align 2
.LC155:
	.string	"tips"
	.align 2
.LC156:
	.string	"addmd2skin"
	.align 2
.LC157:
	.string	"join"
	.align 2
.LC158:
	.string	"lag"
	.align 2
.LC159:
	.string	"teams"
	.align 2
.LC160:
	.string	"botpath"
	.align 2
.LC161:
	.string	"showpath"
	.align 2
.LC162:
	.string	"group"
	.align 2
.LC163:
	.string	"disperse"
	.align 2
.LC164:
	.string	"rushbase"
	.align 2
.LC165:
	.string	"Command only available during CTF play\n"
	.align 2
.LC166:
	.string	"All available units RUSH BASE!\n\n(Type \"freestyle\" to return to normal)\n"
	.align 2
.LC167:
	.string	"<%s> Rushing base!\n"
	.align 2
.LC168:
	.string	"defendbase"
	.align 2
.LC169:
	.string	"All available units DEFEND BASE!\n\n(Type \"freestyle\" to return to normal)\n"
	.align 2
.LC170:
	.string	"<%s> Defending base!\n"
	.align 2
.LC171:
	.string	"freestyle"
	.align 2
.LC172:
	.string	"Returning bots to Freestyle mode.\n"
	.align 2
.LC173:
	.string	"flagpath"
	.align 2
.LC174:
	.string	"clear_flagpaths"
	.align 2
.LC175:
	.string	"\nSuccessfully cleared all flagpaths\n\n"
	.align 2
.LC176:
	.string	"botpause"
	.align 2
.LC177:
	.string	"%s unpaused the game\n"
	.align 2
.LC178:
	.string	"redflag"
	.align 2
.LC179:
	.string	"blueflag"
	.align 2
.LC180:
	.string	"Dropped \"%s\" node\n"
	.align 2
.LC181:
	.string	"clearflags"
	.align 2
.LC182:
	.string	"Cleared user created CTF flags.\n"
	.align 2
.LC183:
	.string	"ctf_item"
	.align 2
.LC184:
	.string	"No classname specified, ignored.\n"
	.align 2
.LC185:
	.string	"Successfully placed %s at (%i %i %i)\nThis item will appear upon reloading the current map\n"
	.align 2
.LC186:
	.string	"clear_items"
	.align 2
.LC187:
	.string	"Cleared CTF_ITEM data\n"
	.align 2
.LC188:
	.string	"toggle_flagpaths"
	.align 2
.LC189:
	.string	"team"
	.align 2
.LC190:
	.string	"id"
	.align 2
.LC191:
	.string	"cam"
	.align 2
.LC192:
	.string	"feign"
	.align 2
.LC193:
	.string	"flash"
	.align 2
.LC194:
	.string	"freeze"
	.align 2
.LC195:
	.string	"gib"
	.align 2
.LC196:
	.string	"firerl"
	.align 2
.LC197:
	.string	"firegl"
	.align 2
.LC198:
	.string	"flashgl"
	.align 2
.LC199:
	.string	"freezegl"
	.align 2
.LC200:
	.string	"drunk"
	.align 2
.LC201:
	.string	"keys2"
	.align 2
.LC202:
	.string	"take"
	.align 2
.LC203:
	.string	"!zbot"
	.align 2
.LC204:
	.string	"#zbot"
	.align 2
.LC205:
	.string	"botnum"
	.align 2
.LC206:
	.long 0x0
	.align 2
.LC207:
	.long 0x40a00000
	.align 3
.LC208:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC209:
	.long 0x44160000
	.section	".text"
	.align 2
	.globl ClientCommand
	.type	 ClientCommand,@function
ClientCommand:
	stwu 1,-144(1)
	mflr 0
	stfd 31,136(1)
	stmw 25,108(1)
	stw 0,148(1)
	mr 30,3
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L504
	lis 9,gi@ha
	li 3,0
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC123@ha
	la 4,.LC123@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L506
	mr 3,30
	bl Cmd_Players_f
	b .L504
.L506:
	lis 4,.LC124@ha
	mr 3,31
	la 4,.LC124@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L507
	mr 3,30
	li 4,0
	b .L886
.L507:
	lis 4,.LC125@ha
	mr 3,31
	la 4,.LC125@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L509
	lis 4,.LC126@ha
	mr 3,31
	la 4,.LC126@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L508
.L509:
	lis 11,ctf@ha
	lis 8,.LC206@ha
	lwz 9,ctf@l(11)
	la 8,.LC206@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L510
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	mr 3,30
	bl CTFSay_Team
	b .L504
.L510:
	mr 3,30
	li 4,1
.L886:
	li 5,0
	bl Cmd_Say_f
	b .L504
.L508:
	lis 4,.LC127@ha
	mr 3,31
	la 4,.LC127@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L512
	mr 3,30
	bl Cmd_Score_f
	b .L504
.L512:
	lis 4,.LC114@ha
	mr 3,31
	la 4,.LC114@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L513
	mr 3,30
	bl Cmd_Help_f
	b .L504
.L513:
	lis 8,.LC206@ha
	lis 9,level+200@ha
	la 8,.LC206@l(8)
	lfs 0,level+200@l(9)
	lfs 31,0(8)
	fcmpu 0,0,31
	bc 4,2,.L504
	lis 4,.LC128@ha
	mr 3,31
	la 4,.LC128@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L515
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 31,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L516
	lis 5,.LC33@ha
	mr 3,30
	la 5,.LC33@l(5)
	b .L887
.L516:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L518
	lis 5,.LC34@ha
	mr 3,30
	la 5,.LC34@l(5)
	b .L888
.L518:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L519
	lis 5,.LC35@ha
	mr 3,30
	la 5,.LC35@l(5)
.L887:
	mr 6,31
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L504
.L519:
	mr 3,30
	mtlr 10
	blrl
	b .L504
.L515:
	lis 4,.LC129@ha
	mr 3,31
	la 4,.LC129@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L521
	mr 3,30
	bl Cmd_Drop_f
	b .L504
.L521:
	lis 4,.LC130@ha
	mr 3,31
	la 4,.LC130@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L523
	mr 3,30
	bl Cmd_Give_f
	b .L504
.L523:
	lis 4,.LC131@ha
	mr 3,31
	la 4,.LC131@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L525
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L526
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L526
	lis 5,.LC1@ha
	mr 3,30
	la 5,.LC1@l(5)
	b .L888
.L526:
	lwz 0,264(30)
	xori 0,0,16
	andi. 8,0,16
	stw 0,264(30)
	bc 4,2,.L528
	lis 9,.LC27@ha
	la 5,.LC27@l(9)
	b .L529
.L528:
	lis 9,.LC28@ha
	la 5,.LC28@l(9)
.L529:
	mr 3,30
	b .L888
.L525:
	lis 4,.LC132@ha
	mr 3,31
	la 4,.LC132@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L531
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L532
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L532
	lis 5,.LC1@ha
	mr 3,30
	la 5,.LC1@l(5)
	b .L888
.L532:
	lwz 0,264(30)
	xori 0,0,32
	andi. 8,0,32
	stw 0,264(30)
	bc 4,2,.L534
	lis 9,.LC29@ha
	la 5,.LC29@l(9)
	b .L535
.L534:
	lis 9,.LC30@ha
	la 5,.LC30@l(9)
.L535:
	mr 3,30
	b .L888
.L531:
	lis 4,.LC133@ha
	mr 3,31
	la 4,.LC133@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L537
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L538
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L538
	lis 5,.LC1@ha
	mr 3,30
	la 5,.LC1@l(5)
	b .L888
.L538:
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 4,2,.L540
	li 0,4
	lis 9,.LC31@ha
	stw 0,260(30)
	la 5,.LC31@l(9)
	b .L541
.L540:
	li 0,1
	lis 9,.LC32@ha
	stw 0,260(30)
	la 5,.LC32@l(9)
.L541:
	mr 3,30
	b .L888
.L537:
	lis 4,.LC134@ha
	mr 3,31
	la 4,.LC134@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L543
	mr 3,30
	bl Cmd_Inven_f
	b .L504
.L543:
	lis 4,.LC135@ha
	mr 3,31
	la 4,.LC135@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L545
	lwz 8,84(30)
	lwz 0,3560(8)
	cmpwi 0,0,0
	bc 4,2,.L889
	lwz 0,3972(8)
	cmpwi 0,0,0
	bc 4,2,.L890
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L885:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L554
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L554
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L878
.L554:
	addi 7,7,1
	bdnz .L885
	b .L891
.L545:
	lis 4,.LC136@ha
	mr 3,31
	la 4,.LC136@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L559
	lwz 7,84(30)
	lwz 0,3560(7)
	cmpwi 0,0,0
	bc 4,2,.L892
	lwz 0,3972(7)
	cmpwi 0,0,0
	bc 4,2,.L893
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L884:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L568
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L568
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L879
.L568:
	addi 11,11,-1
	bdnz .L884
	b .L894
.L559:
	lis 4,.LC137@ha
	mr 3,31
	la 4,.LC137@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L573
	lwz 8,84(30)
	lwz 0,3560(8)
	cmpwi 0,0,0
	bc 4,2,.L889
	lwz 0,3972(8)
	cmpwi 0,0,0
	bc 4,2,.L890
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L883:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L582
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L582
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L878
.L582:
	addi 7,7,1
	bdnz .L883
	b .L891
.L573:
	lis 4,.LC138@ha
	mr 3,31
	la 4,.LC138@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L587
	lwz 7,84(30)
	lwz 0,3560(7)
	cmpwi 0,0,0
	bc 4,2,.L892
	lwz 0,3972(7)
	cmpwi 0,0,0
	bc 4,2,.L893
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L882:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L596
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L596
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L879
.L596:
	addi 11,11,-1
	bdnz .L882
	b .L894
.L587:
	lis 4,.LC139@ha
	mr 3,31
	la 4,.LC139@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L601
	lwz 8,84(30)
	lwz 0,3560(8)
	cmpwi 0,0,0
	bc 12,2,.L602
.L889:
	mr 3,30
	bl PMenu_Next
	b .L504
.L602:
	lwz 0,3972(8)
	cmpwi 0,0,0
	bc 12,2,.L604
.L890:
	mr 3,30
	bl ChaseNext
	b .L504
.L604:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L881:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L610
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L610
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L878
.L610:
	addi 7,7,1
	bdnz .L881
.L891:
	li 0,-1
	stw 0,736(8)
	b .L504
.L601:
	lis 4,.LC140@ha
	mr 3,31
	la 4,.LC140@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L615
	lwz 7,84(30)
	lwz 0,3560(7)
	cmpwi 0,0,0
	bc 12,2,.L616
.L892:
	mr 3,30
	bl PMenu_Prev
	b .L504
.L616:
	lwz 0,3972(7)
	cmpwi 0,0,0
	bc 12,2,.L618
.L893:
	mr 3,30
	bl ChasePrev
	b .L504
.L618:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L880:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L624
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L624
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L879
.L624:
	addi 11,11,-1
	bdnz .L880
.L894:
	li 0,-1
	stw 0,736(7)
	b .L504
.L615:
	lis 4,.LC141@ha
	mr 3,31
	la 4,.LC141@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L629
	mr 3,30
	bl Cmd_InvUse_f
	b .L504
.L629:
	lis 4,.LC142@ha
	mr 3,31
	la 4,.LC142@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L631
	mr 3,30
	bl Cmd_InvDrop_f
	b .L504
.L631:
	lis 4,.LC143@ha
	mr 3,31
	la 4,.LC143@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L633
	lwz 28,84(30)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L504
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 31,1
	subf 9,9,11
	addi 26,28,740
	mullw 9,9,0
	srawi 27,9,2
.L638:
	add 11,27,31
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L640
	mulli 0,11,76
	add 29,0,25
	lwz 9,8(29)
	cmpwi 0,9,0
	bc 12,2,.L640
	lwz 0,56(29)
	andi. 8,0,1
	bc 12,2,.L640
	mr 3,30
	mr 4,29
	bl Cycle_Weapon
	lwz 0,1788(28)
	cmpw 0,0,29
	bc 12,2,.L504
.L640:
	addi 31,31,1
	cmpwi 0,31,256
	bc 4,1,.L638
	b .L504
.L633:
	lis 4,.LC144@ha
	mr 3,31
	la 4,.LC144@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L646
	lwz 31,84(30)
	lwz 11,1788(31)
	cmpwi 0,11,0
	bc 12,2,.L504
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 27,1
	subf 9,9,11
	addi 26,31,740
	mullw 9,9,0
	srawi 9,9,2
	addi 28,9,255
.L651:
	srawi 0,28,31
	srwi 0,0,24
	add 0,28,0
	rlwinm 0,0,0,0,23
	subf 11,0,28
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L653
	mulli 0,11,76
	add 29,0,25
	lwz 9,8(29)
	cmpwi 0,9,0
	bc 12,2,.L653
	lwz 0,56(29)
	andi. 8,0,1
	bc 12,2,.L653
	mr 3,30
	mr 4,29
	bl Cycle_Weapon
	lwz 0,1788(31)
	cmpw 0,0,29
	bc 12,2,.L504
.L653:
	addi 27,27,1
	addi 28,28,-1
	cmpwi 0,27,256
	bc 4,1,.L651
	b .L504
.L646:
	lis 4,.LC145@ha
	mr 3,31
	la 4,.LC145@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L659
	lwz 10,84(30)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L504
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L504
	lis 11,itemlist@ha
	lis 9,0x286b
	la 4,itemlist@l(11)
	ori 9,9,51739
	subf 0,4,0
	addi 11,10,740
	mullw 0,0,9
	srawi 10,0,2
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L504
	mulli 0,10,76
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L504
	lwz 0,56(4)
	andi. 8,0,1
	bc 12,2,.L504
	mr 3,30
	bl Cycle_Weapon
	b .L504
.L659:
	lis 4,.LC146@ha
	mr 3,31
	la 4,.LC146@l(4)
	bl Q_stricmp
	mr. 10,3
	bc 4,2,.L667
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 12,2,.L504
	lwz 11,84(30)
	lis 9,level+4@ha
	lis 8,.LC207@ha
	lfs 0,level+4@l(9)
	la 8,.LC207@l(8)
	lfs 13,3856(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L504
	lwz 0,264(30)
	mr 3,30
	lis 11,meansOfDeath@ha
	stw 10,480(30)
	li 9,23
	lis 6,0x1
	rlwinm 0,0,0,28,26
	lis 7,vec3_origin@ha
	stw 0,264(30)
	la 7,vec3_origin@l(7)
	mr 4,3
	stw 9,meansOfDeath@l(11)
	mr 5,3
	ori 6,6,34464
	bl player_die
	b .L504
.L667:
	lis 4,.LC147@ha
	mr 3,31
	la 4,.LC147@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L672
	lwz 9,84(30)
	stw 3,3552(9)
	lwz 11,84(30)
	stw 3,3568(11)
	lwz 9,84(30)
	stw 3,3564(9)
	lwz 11,84(30)
	lwz 0,3560(11)
	cmpwi 0,0,0
	bc 12,2,.L673
	mr 3,30
	bl PMenu_Close
.L673:
	lwz 9,84(30)
	li 0,1
	stw 0,3976(9)
	b .L504
.L672:
	lis 4,.LC148@ha
	mr 3,31
	la 4,.LC148@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L676
	mr 3,30
	bl Cmd_Wave_f
	b .L504
.L676:
	lis 4,.LC149@ha
	mr 3,31
	la 4,.LC149@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L678
	mr 3,30
	bl Cmd_PlayerList_f
	b .L504
.L678:
	lis 4,.LC150@ha
	mr 3,31
	la 4,.LC150@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L680
	lis 5,.LC151@ha
	mr 3,30
	la 5,.LC151@l(5)
	b .L888
.L680:
	lis 4,.LC152@ha
	mr 3,31
	la 4,.LC152@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L682
	lis 5,.LC153@ha
	mr 3,30
	la 5,.LC153@l(5)
	b .L888
.L682:
	lis 4,.LC154@ha
	mr 3,31
	la 4,.LC154@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L684
	lis 9,gi+4@ha
	lis 3,.LC78@ha
	lwz 0,gi+4@l(9)
	la 3,.LC78@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L504
.L684:
	lis 4,.LC155@ha
	mr 3,31
	la 4,.LC155@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L687
	lis 5,.LC79@ha
	mr 3,30
	la 5,.LC79@l(5)
	b .L888
.L687:
	lis 4,.LC156@ha
	mr 3,31
	la 4,.LC156@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L690
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	lwz 0,160(29)
	mr 28,3
	li 3,2
	mtlr 0
	blrl
	mr 4,3
	mr 3,28
	bl AddModelSkin
	b .L504
.L690:
	lis 4,.LC157@ha
	mr 3,31
	la 4,.LC157@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L692
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	mr 4,3
	mr 3,30
	bl Cmd_Join_f
	b .L504
.L692:
	lis 4,.LC158@ha
	mr 3,31
	la 4,.LC158@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L694
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	bl atoi
	mr. 6,3
	bc 4,1,.L695
	cmpwi 0,6,999
	bc 12,1,.L696
	xoris 0,6,0x8000
	lwz 10,84(30)
	stw 0,100(1)
	lis 9,0x4330
	lis 8,.LC208@ha
	la 8,.LC208@l(8)
	stw 9,96(1)
	lis 5,.LC65@ha
	lfd 13,0(8)
	mr 3,30
	la 5,.LC65@l(5)
	lfd 0,96(1)
	li 4,2
	fsub 0,0,13
	frsp 0,0
	stfs 0,3920(10)
	crxor 6,6,6
	bl safe_cprintf
	b .L504
.L696:
	lis 5,.LC66@ha
	mr 3,30
	la 5,.LC66@l(5)
	b .L888
.L695:
	lis 5,.LC67@ha
	mr 3,30
	la 5,.LC67@l(5)
	b .L888
.L694:
	lis 4,.LC159@ha
	mr 3,31
	la 4,.LC159@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L701
	mr 3,30
	bl Cmd_Teams_f
	b .L504
.L701:
	lis 4,.LC160@ha
	mr 3,31
	la 4,.LC160@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L703
	lwz 3,84(30)
	li 5,0
	addi 4,1,72
	li 6,0
	addi 3,3,3700
	bl AngleVectors
	lis 8,.LC209@ha
	addi 3,1,72
	la 8,.LC209@l(8)
	mr 4,3
	lfs 1,0(8)
	bl VectorScale
	lis 9,gi@ha
	mr 4,30
	lfs 13,8(30)
	lfsu 12,4(4)
	la 31,gi@l(9)
	lis 5,VEC_ORIGIN@ha
	lfs 0,12(30)
	la 5,VEC_ORIGIN@l(5)
	lis 9,0x201
	lfs 9,72(1)
	ori 9,9,3
	mr 8,30
	lfs 11,76(1)
	addi 3,1,8
	mr 6,5
	lfs 10,80(1)
	addi 7,1,72
	lwz 11,48(31)
	fadds 12,12,9
	fadds 13,13,11
	fadds 0,0,10
	mtlr 11
	stfs 12,72(1)
	stfs 13,76(1)
	stfs 0,80(1)
	blrl
	lwz 9,60(1)
	cmpwi 0,9,0
	bc 12,2,.L504
	lwz 0,968(9)
	cmpwi 0,0,0
	bc 12,2,.L504
	lwz 0,264(9)
	lis 3,.LC80@ha
	la 3,.LC80@l(3)
	ori 0,0,8192
	stw 0,264(9)
	lwz 9,60(1)
	lwz 0,4(31)
	lwz 4,84(9)
	mtlr 0
	addi 4,4,700
	crxor 6,6,6
	blrl
	b .L504
.L703:
	lis 4,.LC161@ha
	mr 3,31
	la 4,.LC161@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L707
	lwz 9,264(30)
	andi. 0,9,8192
	bc 12,2,.L708
	addi 0,9,-8192
	stw 0,264(30)
	b .L504
.L708:
	ori 0,9,8192
	stw 0,264(30)
	b .L504
.L707:
	lis 4,.LC162@ha
	mr 3,31
	la 4,.LC162@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L712
	mr 3,30
	bl TeamGroup
	b .L504
.L712:
	lis 4,.LC163@ha
	mr 3,31
	la 4,.LC163@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L714
	mr 3,30
	bl TeamDisperse
	b .L504
.L714:
	lis 4,.LC164@ha
	mr 3,31
	la 4,.LC164@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L716
	lis 9,ctf@ha
	lis 8,.LC206@ha
	lwz 11,ctf@l(9)
	la 8,.LC206@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L717
	lis 5,.LC165@ha
	mr 3,30
	la 5,.LC165@l(5)
	b .L888
.L717:
	lwz 9,84(30)
	lwz 0,3468(9)
	cmpwi 0,0,1
	bc 4,2,.L718
	lis 11,flag2_ent@ha
	lis 10,team1_rushbase_time@ha
	lis 0,0x4334
	lis 9,team1_defendbase_time@ha
	lwz 28,flag2_ent@l(11)
	stw 0,team1_rushbase_time@l(10)
	stfs 13,team1_defendbase_time@l(9)
	b .L719
.L718:
	lis 9,flag1_ent@ha
	lis 11,team2_rushbase_time@ha
	lwz 28,flag1_ent@l(9)
	lis 0,0x4334
	lis 9,team2_defendbase_time@ha
	stw 0,team2_rushbase_time@l(11)
	stfs 13,team2_defendbase_time@l(9)
.L719:
	lwz 5,84(30)
	lis 4,.LC166@ha
	mr 3,30
	la 4,.LC166@l(4)
	li 31,0
	addi 5,5,700
	lis 25,num_players@ha
	crxor 6,6,6
	bl safe_centerprintf
	lis 9,num_players@ha
	lwz 0,num_players@l(9)
	cmpw 0,31,0
	bc 4,0,.L504
	lis 9,players@ha
	li 26,99
	la 29,players@l(9)
	lis 27,.LC167@ha
.L723:
	lwz 3,0(29)
	lwz 6,84(30)
	addi 29,29,4
	lwz 9,84(3)
	lwz 11,3468(6)
	lwz 0,3468(9)
	cmpw 0,0,11
	bc 4,2,.L722
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 12,2,.L725
	stw 26,1032(3)
	stw 28,416(3)
	b .L722
.L725:
	cmpw 0,3,30
	bc 12,2,.L722
	addi 6,6,700
	li 4,3
	la 5,.LC167@l(27)
	crxor 6,6,6
	bl safe_cprintf
.L722:
	lwz 0,num_players@l(25)
	addi 31,31,1
	cmpw 0,31,0
	bc 12,0,.L723
	b .L504
.L716:
	lis 4,.LC168@ha
	mr 3,31
	la 4,.LC168@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L730
	lis 9,ctf@ha
	lis 8,.LC206@ha
	lwz 11,ctf@l(9)
	la 8,.LC206@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L731
	lis 5,.LC165@ha
	mr 3,30
	la 5,.LC165@l(5)
	b .L888
.L731:
	lwz 9,84(30)
	lwz 0,3468(9)
	cmpwi 0,0,1
	bc 4,2,.L732
	lis 10,flag1_ent@ha
	lis 9,team1_rushbase_time@ha
	lis 11,team1_defendbase_time@ha
	lis 0,0x4334
	stfs 13,team1_rushbase_time@l(9)
	stw 0,team1_defendbase_time@l(11)
	lwz 28,flag1_ent@l(10)
	b .L733
.L732:
	lis 9,flag2_ent@ha
	lis 10,team2_rushbase_time@ha
	lis 11,team2_defendbase_time@ha
	lis 0,0x4334
	lwz 28,flag2_ent@l(9)
	stfs 13,team2_rushbase_time@l(10)
	stw 0,team2_defendbase_time@l(11)
.L733:
	lwz 5,84(30)
	lis 4,.LC169@ha
	mr 3,30
	la 4,.LC169@l(4)
	li 31,0
	addi 5,5,700
	lis 25,num_players@ha
	crxor 6,6,6
	bl safe_centerprintf
	lis 9,num_players@ha
	lwz 0,num_players@l(9)
	cmpw 0,31,0
	bc 4,0,.L504
	lis 9,players@ha
	li 26,3
	la 29,players@l(9)
	lis 27,.LC170@ha
.L737:
	lwz 3,0(29)
	lwz 6,84(30)
	addi 29,29,4
	lwz 9,84(3)
	lwz 11,3468(6)
	lwz 0,3468(9)
	cmpw 0,0,11
	bc 4,2,.L736
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 12,2,.L739
	stw 26,1032(3)
	stw 28,416(3)
	stw 28,324(3)
	b .L736
.L739:
	cmpw 0,3,30
	bc 12,2,.L736
	addi 6,6,700
	li 4,3
	la 5,.LC170@l(27)
	crxor 6,6,6
	bl safe_cprintf
.L736:
	lwz 0,num_players@l(25)
	addi 31,31,1
	cmpw 0,31,0
	bc 12,0,.L737
	b .L504
.L730:
	lis 4,.LC171@ha
	mr 3,31
	la 4,.LC171@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L744
	lwz 9,84(30)
	lwz 0,3468(9)
	cmpwi 0,0,1
	bc 4,2,.L745
	li 0,0
	lis 9,team1_rushbase_time@ha
	lis 11,team1_defendbase_time@ha
	stw 0,team1_rushbase_time@l(9)
	stw 0,team1_defendbase_time@l(11)
	b .L746
.L745:
	li 0,0
	lis 9,team2_rushbase_time@ha
	lis 11,team2_defendbase_time@ha
	stw 0,team2_rushbase_time@l(9)
	stw 0,team2_defendbase_time@l(11)
.L746:
	lis 5,.LC172@ha
	mr 3,30
	la 5,.LC172@l(5)
	b .L888
.L744:
	lis 4,.LC173@ha
	mr 3,31
	la 4,.LC173@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L748
	lwz 9,84(30)
	mr 3,30
	lwz 4,3468(9)
	bl FlagPath
	b .L504
.L748:
	lis 4,.LC174@ha
	mr 3,31
	la 4,.LC174@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L750
	li 29,0
	li 31,0
	lis 28,.LC100@ha
	b .L751
.L753:
	mr 29,3
	addi 31,31,1
	bl G_FreeEdict
.L751:
	lis 5,.LC98@ha
	mr 3,29
	la 5,.LC98@l(5)
	li 4,280
	bl G_Find
	mr. 3,3
	bc 4,2,.L753
	li 29,0
	b .L755
.L757:
	mr 29,3
	addi 31,31,1
	bl G_FreeEdict
.L755:
	mr 3,29
	li 4,280
	la 5,.LC100@l(28)
	bl G_Find
	mr. 3,3
	bc 4,2,.L757
	cmpwi 0,31,0
	bc 12,2,.L504
	lis 5,.LC175@ha
	mr 3,30
	la 5,.LC175@l(5)
	b .L888
.L750:
	lis 4,.LC176@ha
	mr 3,31
	la 4,.LC176@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L761
	lis 9,paused@ha
	lwz 0,paused@l(9)
	subfic 8,0,0
	adde 0,8,0
	cmpwi 0,0,0
	stw 0,paused@l(9)
	bc 4,2,.L504
	lis 9,num_players@ha
	li 10,0
	lwz 0,num_players@l(9)
	cmpw 0,10,0
	bc 4,0,.L764
	lis 9,players@ha
	lis 7,num_players@ha
	la 8,players@l(9)
.L766:
	lwz 11,0(8)
	addi 8,8,4
	lwz 0,968(11)
	cmpwi 0,0,0
	bc 4,2,.L765
	lwz 9,84(30)
	lwz 0,3944(9)
	cmpwi 0,0,0
	bc 4,2,.L765
	lwz 9,84(11)
	lbz 0,16(9)
	andi. 0,0,191
	stb 0,16(9)
.L765:
	lwz 0,num_players@l(7)
	addi 10,10,1
	cmpw 0,10,0
	bc 12,0,.L766
.L764:
	lwz 5,84(30)
	lis 4,.LC177@ha
	li 3,2
	la 4,.LC177@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	b .L504
.L761:
	lis 4,.LC178@ha
	mr 3,31
	la 4,.LC178@l(4)
	lis 28,.LC178@ha
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L771
	lis 4,.LC179@ha
	mr 3,31
	la 4,.LC179@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L770
.L771:
	bl G_Spawn
	lis 9,gi+132@ha
	mr 29,3
	lwz 0,gi+132@l(9)
	li 4,766
	li 3,16
	mtlr 0
	blrl
	mr 0,3
	mr 4,31
	stw 0,280(29)
	bl strcpy
	lfs 0,4(30)
	lis 5,.LC180@ha
	mr 3,30
	la 5,.LC180@l(5)
	mr 6,31
	li 4,2
	stfs 0,4(29)
	lfs 0,8(30)
	stfs 0,8(29)
	lfs 13,12(30)
	stfs 13,12(29)
	lfs 0,16(30)
	stfs 0,16(29)
	lfs 13,20(30)
	stfs 13,20(29)
	lfs 0,24(30)
	stfs 0,24(29)
	crxor 6,6,6
	bl safe_cprintf
	b .L895
.L770:
	lis 4,.LC181@ha
	mr 3,31
	la 4,.LC181@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L773
	li 29,0
	b .L774
.L776:
	mr 3,29
	bl G_FreeEdict
.L774:
	lis 5,.LC179@ha
	mr 3,29
	la 5,.LC179@l(5)
	li 4,280
	bl G_Find
	mr. 29,3
	bc 4,2,.L776
	b .L778
.L780:
	mr 3,29
	bl G_FreeEdict
.L778:
	mr 3,29
	li 4,280
	la 5,.LC178@l(28)
	bl G_Find
	mr. 29,3
	bc 4,2,.L780
	lis 5,.LC182@ha
	mr 3,30
	la 5,.LC182@l(5)
	b .L888
.L773:
	lis 4,.LC183@ha
	mr 3,31
	la 4,.LC183@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L783
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L784
	lis 5,.LC184@ha
	mr 3,30
	la 5,.LC184@l(5)
	b .L888
.L784:
	lwz 0,132(29)
	li 4,766
	li 3,92
	lis 29,ctf_item_head@ha
	mtlr 0
	lwz 28,ctf_item_head@l(29)
	blrl
	mr 0,3
	li 5,92
	stw 0,ctf_item_head@l(29)
	li 4,0
	crxor 6,6,6
	bl memset
	lwz 3,ctf_item_head@l(29)
	mr 4,31
	bl strcpy
	lfs 0,4(30)
	lis 5,.LC185@ha
	lwz 11,ctf_item_head@l(29)
	mr 8,7
	mr 9,7
	mr 3,30
	la 5,.LC185@l(5)
	stfs 0,64(11)
	mr 6,31
	li 4,2
	lfs 13,8(30)
	stfs 13,68(11)
	lfs 0,12(30)
	stfs 0,72(11)
	lfs 13,16(30)
	stfs 13,76(11)
	lfs 0,20(30)
	stfs 0,80(11)
	lfs 12,24(30)
	stw 28,88(11)
	stfs 12,84(11)
	lfs 13,4(30)
	lfs 12,8(30)
	lfs 0,12(30)
	fctiwz 11,13
	fctiwz 10,12
	fctiwz 9,0
	stfd 11,96(1)
	lwz 7,100(1)
	stfd 10,96(1)
	lwz 8,100(1)
	stfd 9,96(1)
	lwz 9,100(1)
	crxor 6,6,6
	bl safe_cprintf
	b .L895
.L783:
	lis 4,.LC186@ha
	mr 3,31
	la 4,.LC186@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L786
	lis 9,ctf_item_head@ha
	lis 5,.LC187@ha
	stw 3,ctf_item_head@l(9)
	la 5,.LC187@l(5)
	li 4,2
	mr 3,30
	crxor 6,6,6
	bl safe_cprintf
.L895:
	lis 9,dropped_trail@ha
	li 0,1
	stw 0,dropped_trail@l(9)
	b .L504
.L786:
	lis 4,.LC188@ha
	mr 3,31
	la 4,.LC188@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L788
	lwz 0,264(30)
	andis. 8,0,1
	bc 12,2,.L789
	rlwinm 0,0,0,16,14
	li 3,0
	stw 0,264(30)
	b .L790
.L792:
	li 0,0
	stw 0,40(3)
.L790:
	lis 5,.LC98@ha
	li 4,280
	la 5,.LC98@l(5)
	bl G_Find
	mr. 3,3
	bc 4,2,.L792
	b .L504
.L789:
	oris 0,0,0x1
	stw 0,264(30)
	b .L504
.L788:
	lis 4,.LC189@ha
	mr 3,31
	la 4,.LC189@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L796
	mr 3,30
	bl CTFTeam_f
	b .L504
.L796:
	lis 4,.LC190@ha
	mr 3,31
	la 4,.LC190@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L798
	mr 3,30
	bl CTFID_f
	b .L504
.L798:
	lis 4,.LC191@ha
	mr 3,31
	la 4,.LC191@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L800
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	mr 4,3
	mr 3,30
	bl CameraCmd
	b .L504
.L800:
	lis 4,.LC192@ha
	mr 3,31
	la 4,.LC192@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L802
	lis 11,allowfeigning@ha
	lis 8,.LC206@ha
	lwz 9,allowfeigning@l(11)
	la 8,.LC206@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L803
	lwz 9,84(30)
	lwz 0,4012(9)
	cmpwi 0,0,0
	bc 12,2,.L804
	mr 3,30
	bl Client_EndFeign
	b .L504
.L804:
	mr 3,30
	bl Client_BeginFeign
	b .L504
.L803:
	lis 5,.LC104@ha
	mr 3,30
	la 5,.LC104@l(5)
	b .L888
.L802:
	lis 4,.LC193@ha
	mr 3,31
	la 4,.LC193@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L809
	lis 3,.LC105@ha
	la 3,.LC105@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 31,3
	lwz 10,84(30)
	la 9,itemlist@l(9)
	lis 0,0x286b
	ori 0,0,51739
	subf 9,9,31
	mullw 9,9,0
	addi 11,10,740
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L810
	lis 5,.LC106@ha
	mr 3,30
	la 5,.LC106@l(5)
	b .L888
.L810:
	lwz 0,4016(10)
	xori 9,0,3
	subfic 8,9,0
	adde 9,8,9
	subfic 11,0,0
	adde 0,11,0
	or. 0,0,9
	bc 12,2,.L812
	lis 11,flashgrenades@ha
	lis 8,.LC206@ha
	lwz 9,flashgrenades@l(11)
	la 8,.LC206@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L821
	li 0,1
	lis 4,.LC107@ha
	stw 0,4016(10)
	la 4,.LC107@l(4)
	b .L901
.L812:
	lis 4,.LC108@ha
	stw 0,4016(10)
	b .L903
.L809:
	lis 4,.LC194@ha
	mr 3,31
	la 4,.LC194@l(4)
	bl Q_stricmp
	mr. 29,3
	bc 4,2,.L816
	lis 3,.LC105@ha
	la 3,.LC105@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 31,3
	lwz 10,84(30)
	la 9,itemlist@l(9)
	lis 0,0x286b
	ori 0,0,51739
	subf 9,9,31
	mullw 9,9,0
	addi 11,10,740
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L817
	lis 5,.LC106@ha
	mr 3,30
	la 5,.LC106@l(5)
	b .L888
.L817:
	lwz 0,4016(10)
	cmplwi 0,0,1
	bc 12,1,.L819
	lis 11,freezegrenades@ha
	lis 8,.LC206@ha
	lwz 9,freezegrenades@l(11)
	la 8,.LC206@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L821
	li 0,3
	lis 4,.LC109@ha
	stw 0,4016(10)
	la 4,.LC109@l(4)
.L901:
	mr 3,30
	crxor 6,6,6
	bl safe_centerprintf
	b .L821
.L819:
	lis 4,.LC108@ha
	stw 29,4016(10)
.L903:
	mr 3,30
	la 4,.LC108@l(4)
	crxor 6,6,6
	bl safe_centerprintf
.L821:
	lwz 0,8(31)
	mr 3,30
	mr 4,31
	mtlr 0
	blrl
	b .L504
.L816:
	lis 4,.LC195@ha
	mr 3,31
	la 4,.LC195@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L823
	lis 31,.LC112@ha
	la 3,.LC112@l(31)
	bl FindItem
	mr. 4,3
	bc 4,2,.L824
	la 3,.LC112@l(31)
	bl FindItem
	mr. 4,3
	bc 12,2,.L896
.L824:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L827
	lis 4,.LC113@ha
	mr 3,30
	la 4,.LC113@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L504
.L827:
	li 0,1
	li 11,0
	stw 0,4076(10)
	mr 3,30
	lwz 9,84(30)
	stw 11,4044(9)
	crxor 6,6,6
	bl Use_Weapon
	b .L504
.L823:
	lis 4,.LC196@ha
	mr 3,31
	la 4,.LC196@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L829
	lis 31,.LC11@ha
	la 3,.LC11@l(31)
	bl FindItem
	mr. 4,3
	bc 4,2,.L830
	la 3,.LC11@l(31)
	bl FindItem
	mr. 4,3
	bc 12,2,.L896
.L830:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L897
	li 0,1
	li 11,0
	b .L898
.L829:
	lis 4,.LC197@ha
	mr 3,31
	la 4,.LC197@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L835
	lis 31,.LC10@ha
	la 3,.LC10@l(31)
	bl FindItem
	mr. 4,3
	bc 4,2,.L836
	la 3,.LC10@l(31)
	bl FindItem
	mr. 4,3
	bc 12,2,.L896
.L836:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L899
	li 0,1
	mr 3,30
	stw 0,4076(10)
	lwz 9,84(30)
	stw 0,4016(9)
	crxor 6,6,6
	bl Use_Weapon
	b .L504
.L835:
	lis 4,.LC198@ha
	mr 3,31
	la 4,.LC198@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L841
	lis 31,.LC10@ha
	la 3,.LC10@l(31)
	bl FindItem
	mr. 4,3
	bc 4,2,.L842
	la 3,.LC10@l(31)
	bl FindItem
	mr. 4,3
	bc 12,2,.L896
.L842:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L899
	li 0,1
	li 11,0
	b .L900
.L841:
	lis 4,.LC199@ha
	mr 3,31
	la 4,.LC199@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L847
	lis 31,.LC10@ha
	la 3,.LC10@l(31)
	bl FindItem
	mr. 4,3
	bc 4,2,.L848
	la 3,.LC10@l(31)
	bl FindItem
	mr. 4,3
	bc 12,2,.L896
.L848:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L851
.L899:
	lis 4,.LC111@ha
	mr 3,30
	la 4,.LC111@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L504
.L851:
	li 0,1
	li 11,2
.L900:
	stw 0,4076(10)
	mr 3,30
	lwz 9,84(30)
	stw 11,4016(9)
	crxor 6,6,6
	bl Use_Weapon
	b .L504
.L847:
	lis 4,.LC200@ha
	mr 3,31
	la 4,.LC200@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L853
	lis 31,.LC11@ha
	la 3,.LC11@l(31)
	bl FindItem
	mr. 4,3
	bc 4,2,.L854
	la 3,.LC11@l(31)
	bl FindItem
	mr. 4,3
	bc 4,2,.L854
.L896:
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC23@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L504
.L854:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L857
.L897:
	lis 4,.LC110@ha
	mr 3,30
	la 4,.LC110@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L504
.L857:
	li 0,1
	li 11,2
.L898:
	stw 0,4076(10)
	mr 3,30
	lwz 9,84(30)
	stw 11,4032(9)
	crxor 6,6,6
	bl Use_Weapon
	b .L504
.L853:
	lis 4,.LC201@ha
	mr 3,31
	la 4,.LC201@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L859
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	lis 4,.LC114@ha
	la 4,.LC114@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L504
	lis 5,.LC115@ha
	mr 3,30
	li 4,2
	la 5,.LC115@l(5)
	crxor 6,6,6
	bl safe_cprintf
	mr 3,30
	li 4,0
	bl K2_OpenHelpMenu
	b .L504
.L859:
	lis 4,.LC202@ha
	mr 3,31
	la 4,.LC202@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L863
	mr 3,30
	bl K2_IsAnti
	cmpwi 0,3,0
	bc 12,2,.L864
	mr 3,30
	bl K2_TakePlayerKey
	b .L504
.L864:
	lis 5,.LC103@ha
	mr 3,30
	la 5,.LC103@l(5)
.L888:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L504
.L863:
	lis 4,.LC203@ha
	mr 3,31
	la 4,.LC203@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L868
	lwz 9,84(30)
	stw 3,1820(9)
	b .L504
.L868:
	lis 4,.LC204@ha
	mr 3,31
	la 4,.LC204@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L870
	lwz 9,84(30)
	li 0,1
	stw 0,1828(9)
	b .L504
.L870:
	lis 4,.LC205@ha
	mr 3,31
	la 4,.LC205@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L872
	mr 3,30
	bl Cmd_Bot_f
	b .L504
.L878:
	stw 11,736(8)
	b .L504
.L879:
	stw 8,736(7)
	b .L504
.L872:
	mr 3,30
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L504:
	lwz 0,148(1)
	mtlr 0
	lmw 25,108(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe16:
	.size	 ClientCommand,.Lfe16-ClientCommand
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.comm	last_trail_time,4,4
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
	bc 4,2,.L52
	lwz 0,3560(8)
	cmpwi 0,0,0
	bc 12,2,.L54
	bl PMenu_Next
	b .L52
.L54:
	lwz 0,3972(8)
	cmpwi 0,0,0
	bc 12,2,.L56
	bl ChaseNext
	b .L52
.L904:
	stw 11,736(8)
	b .L52
.L56:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L905:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L62
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L62
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L904
.L62:
	addi 7,7,1
	bdnz .L905
	li 0,-1
	stw 0,736(8)
.L52:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 ValidateSelectedItem,.Lfe17-ValidateSelectedItem
	.comm	bot_frametime,8,8
	.comm	max_bots,4,4
	.comm	last_bot_spawn,4,4
	.comm	bot_male_names_used,4,4
	.comm	bot_female_names_used,4,4
	.comm	bot_count,4,4
	.comm	bot_teams,256,4
	.comm	total_teams,4,4
	.comm	the_client,4,4
	.comm	num_players,4,4
	.comm	players,1024,4
	.comm	weapons_head,4,4
	.comm	health_head,4,4
	.comm	bonus_head,4,4
	.comm	ammo_head,4,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_supershotgun,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	botinfo_list,4,4
	.comm	total_bots,4,4
	.comm	teambot_list,4,4
	.comm	paused,4,4
	.align 2
	.globl SelectPrevItem
	.type	 SelectPrevItem,@function
SelectPrevItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 7,84(3)
	lwz 0,3560(7)
	cmpwi 0,0,0
	bc 12,2,.L41
	bl PMenu_Prev
	b .L40
.L41:
	lwz 0,3972(7)
	cmpwi 0,0,0
	bc 12,2,.L42
	bl ChasePrev
	b .L40
.L906:
	stw 8,736(7)
	b .L40
.L42:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L907:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L46
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L46
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L906
.L46:
	addi 11,11,-1
	bdnz .L907
	li 0,-1
	stw 0,736(7)
.L40:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 SelectPrevItem,.Lfe18-SelectPrevItem
	.comm	spawn_bots,4,4
	.comm	roam_calls_this_frame,4,4
	.comm	bestdirection_callsthisframe,4,4
	.comm	bot_chat_text,2048,4
	.comm	bot_chat_count,32,4
	.comm	last_bot_chat,32,4
	.comm	num_view_weapons,4,4
	.comm	view_weapon_models,4096,1
	.comm	botdebug,4,4
	.comm	pTempFind,4,4
	.comm	PathToEnt_Node,4,4
	.comm	PathToEnt_TargetNode,4,4
	.comm	trail_head,4,4
	.comm	last_head,4,4
	.comm	dropped_trail,4,4
	.comm	last_optimize,4,4
	.comm	optimize_marker,4,4
	.comm	trail_portals,490000,4
	.comm	num_trail_portals,2500,4
	.comm	ctf_item_head,4,4
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
	bc 12,2,.L909
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
	bc 12,2,.L909
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L9
	addi 3,3,1
	b .L908
.L9:
	stb 30,0(3)
.L909:
	mr 3,31
.L908:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 ClientTeam,.Lfe19-ClientTeam
	.align 2
	.globl SelectNextItem
	.type	 SelectNextItem,@function
SelectNextItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 8,84(3)
	lwz 0,3560(8)
	cmpwi 0,0,0
	bc 12,2,.L29
	bl PMenu_Next
	b .L28
.L29:
	lwz 0,3972(8)
	cmpwi 0,0,0
	bc 12,2,.L30
	bl ChaseNext
	b .L28
.L910:
	stw 11,736(8)
	b .L28
.L30:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 3,itemlist@l(9)
	addi 6,8,740
.L911:
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
	mulli 0,11,76
	add 10,0,3
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L34
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L910
.L34:
	addi 7,7,1
	bdnz .L911
	li 0,-1
	stw 0,736(8)
.L28:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe20:
	.size	 SelectNextItem,.Lfe20-SelectNextItem
	.section	".rodata"
	.align 2
.LC210:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC210@ha
	lis 9,deathmatch@ha
	la 11,.LC210@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L149
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L149
	lis 5,.LC1@ha
	li 4,2
	la 5,.LC1@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L148
.L149:
	lwz 0,264(3)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(3)
	bc 4,2,.L150
	lis 9,.LC27@ha
	la 5,.LC27@l(9)
	b .L151
.L150:
	lis 9,.LC28@ha
	la 5,.LC28@l(9)
.L151:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L148:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 Cmd_God_f,.Lfe21-Cmd_God_f
	.section	".rodata"
	.align 2
.LC211:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC211@ha
	lis 9,deathmatch@ha
	la 11,.LC211@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L153
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L153
	lis 5,.LC1@ha
	li 4,2
	la 5,.LC1@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L152
.L153:
	lwz 0,264(3)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(3)
	bc 4,2,.L154
	lis 9,.LC29@ha
	la 5,.LC29@l(9)
	b .L155
.L154:
	lis 9,.LC30@ha
	la 5,.LC30@l(9)
.L155:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L152:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 Cmd_Notarget_f,.Lfe22-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC212:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC212@ha
	lis 9,deathmatch@ha
	la 11,.LC212@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L157
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L157
	lis 5,.LC1@ha
	li 4,2
	la 5,.LC1@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L156
.L157:
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 4,2,.L158
	li 0,4
	lis 9,.LC31@ha
	stw 0,260(3)
	la 5,.LC31@l(9)
	b .L159
.L158:
	li 0,1
	lis 9,.LC32@ha
	stw 0,260(3)
	la 5,.LC32@l(9)
.L159:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L156:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 Cmd_Noclip_f,.Lfe23-Cmd_Noclip_f
	.align 2
	.globl Cmd_Use_f
	.type	 Cmd_Use_f,@function
Cmd_Use_f:
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
	bl FindItem
	mr. 4,3
	bc 4,2,.L161
	lis 5,.LC33@ha
	mr 3,31
	la 5,.LC33@l(5)
	b .L912
.L161:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L162
	lis 5,.LC34@ha
	mr 3,31
	la 5,.LC34@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L160
.L162:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L163
	lis 5,.LC35@ha
	mr 3,31
	la 5,.LC35@l(5)
.L912:
	mr 6,30
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L160
.L163:
	mr 3,31
	mtlr 10
	blrl
.L160:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe24:
	.size	 Cmd_Use_f,.Lfe24-Cmd_Use_f
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
	bc 12,2,.L204
	lwz 9,1792(4)
	cmpwi 0,9,0
	bc 12,2,.L204
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L204:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe25:
	.size	 Cmd_LastWeap_f,.Lfe25-Cmd_LastWeap_f
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
	bc 12,2,.L207
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,29,740
	mullw 9,9,0
	srawi 27,9,2
.L212:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L211
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L211
	lwz 0,56(31)
	andi. 9,0,1
	bc 12,2,.L211
	mr 3,28
	mr 4,31
	bl Cycle_Weapon
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L207
.L211:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L212
.L207:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe26:
	.size	 Cmd_WeapPrev_f,.Lfe26-Cmd_WeapPrev_f
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
	bc 12,2,.L218
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 28,1
	subf 9,9,11
	addi 26,29,740
	mullw 9,9,0
	srawi 9,9,2
	addi 30,9,255
.L223:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L222
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L222
	lwz 0,56(31)
	andi. 9,0,1
	bc 12,2,.L222
	mr 3,27
	mr 4,31
	bl Cycle_Weapon
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L218
.L222:
	addi 28,28,1
	addi 30,30,-1
	cmpwi 0,28,256
	bc 4,1,.L223
.L218:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe27:
	.size	 Cmd_WeapNext_f,.Lfe27-Cmd_WeapNext_f
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
	bc 12,2,.L229
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L229
	lis 11,itemlist@ha
	lis 9,0x286b
	la 4,itemlist@l(11)
	ori 9,9,51739
	subf 0,4,0
	addi 11,10,740
	mullw 0,0,9
	srawi 10,0,2
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L229
	mulli 0,10,76
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L229
	lwz 0,56(4)
	andi. 9,0,1
	bc 12,2,.L229
	bl Cycle_Weapon
.L229:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 Cmd_WeapLast_f,.Lfe28-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC213:
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
	bc 12,2,.L271
	lwz 11,84(10)
	lis 9,level+4@ha
	lis 8,.LC213@ha
	lfs 0,level+4@l(9)
	la 8,.LC213@l(8)
	lfs 13,3856(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L271
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
.L271:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 Cmd_Kill_f,.Lfe29-Cmd_Kill_f
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
	stw 0,3552(9)
	lwz 11,84(31)
	stw 0,3568(11)
	lwz 9,84(31)
	stw 0,3564(9)
	lwz 11,84(31)
	lwz 0,3560(11)
	cmpwi 0,0,0
	bc 12,2,.L275
	bl PMenu_Close
.L275:
	lwz 9,84(31)
	li 0,1
	stw 0,3976(9)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe30:
	.size	 Cmd_PutAway_f,.Lfe30-Cmd_PutAway_f
	.align 2
	.globl PlayerSort
	.type	 PlayerSort,@function
PlayerSort:
	lwz 9,0(3)
	lis 11,game+1028@ha
	lwz 3,0(4)
	lwz 0,game+1028@l(11)
	mulli 9,9,4088
	mulli 11,3,4088
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
.Lfe31:
	.size	 PlayerSort,.Lfe31-PlayerSort
	.section	".rodata"
	.align 3
.LC214:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_Lag_f
	.type	 Cmd_Lag_f,@function
Cmd_Lag_f:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	mr 3,4
	bl atoi
	mr. 6,3
	bc 4,1,.L327
	cmpwi 0,6,999
	bc 12,1,.L328
	xoris 0,6,0x8000
	lwz 10,84(31)
	stw 0,20(1)
	lis 9,0x4330
	lis 8,.LC214@ha
	la 8,.LC214@l(8)
	stw 9,16(1)
	lis 5,.LC65@ha
	lfd 13,0(8)
	mr 3,31
	la 5,.LC65@l(5)
	lfd 0,16(1)
	li 4,2
	fsub 0,0,13
	frsp 0,0
	stfs 0,3920(10)
	crxor 6,6,6
	bl safe_cprintf
	b .L330
.L328:
	lis 5,.LC66@ha
	mr 3,31
	la 5,.LC66@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L330
.L327:
	lis 5,.LC67@ha
	mr 3,31
	la 5,.LC67@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L330:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe32:
	.size	 Cmd_Lag_f,.Lfe32-Cmd_Lag_f
	.align 2
	.globl Cmd_BotCommands_f
	.type	 Cmd_BotCommands_f,@function
Cmd_BotCommands_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+4@ha
	lis 3,.LC78@ha
	lwz 0,gi+4@l(9)
	la 3,.LC78@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe33:
	.size	 Cmd_BotCommands_f,.Lfe33-Cmd_BotCommands_f
	.align 2
	.globl Cmd_Tips_f
	.type	 Cmd_Tips_f,@function
Cmd_Tips_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 5,.LC79@ha
	li 4,2
	la 5,.LC79@l(5)
	crxor 6,6,6
	bl safe_cprintf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 Cmd_Tips_f,.Lfe34-Cmd_Tips_f
	.section	".rodata"
	.align 2
.LC215:
	.long 0x44160000
	.section	".text"
	.align 2
	.globl Cmd_Botpath_f
	.type	 Cmd_Botpath_f,@function
Cmd_Botpath_f:
	stwu 1,-112(1)
	mflr 0
	stmw 28,96(1)
	stw 0,116(1)
	mr 28,3
	addi 29,1,72
	lwz 3,84(28)
	li 5,0
	li 6,0
	mr 4,29
	addi 3,3,3700
	bl AngleVectors
	lis 9,.LC215@ha
	mr 3,29
	la 9,.LC215@l(9)
	mr 4,29
	lfs 1,0(9)
	bl VectorScale
	lis 9,gi@ha
	lfs 12,4(28)
	lis 5,VEC_ORIGIN@ha
	lfs 13,8(28)
	la 31,gi@l(9)
	la 5,VEC_ORIGIN@l(5)
	lfs 0,12(28)
	lis 9,0x201
	mr 7,29
	lfs 9,72(1)
	ori 9,9,3
	mr 8,28
	lfs 11,76(1)
	addi 3,1,8
	addi 4,28,4
	lfs 10,80(1)
	mr 6,5
	lwz 11,48(31)
	fadds 12,12,9
	fadds 13,13,11
	fadds 0,0,10
	mtlr 11
	stfs 12,72(1)
	stfs 13,76(1)
	stfs 0,80(1)
	blrl
	lwz 9,60(1)
	cmpwi 0,9,0
	bc 12,2,.L356
	lwz 0,968(9)
	cmpwi 0,0,0
	bc 12,2,.L356
	lwz 0,264(9)
	lis 3,.LC80@ha
	la 3,.LC80@l(3)
	ori 0,0,8192
	stw 0,264(9)
	lwz 9,60(1)
	lwz 0,4(31)
	lwz 4,84(9)
	mtlr 0
	addi 4,4,700
	crxor 6,6,6
	blrl
.L356:
	lwz 0,116(1)
	mtlr 0
	lmw 28,96(1)
	la 1,112(1)
	blr
.Lfe35:
	.size	 Cmd_Botpath_f,.Lfe35-Cmd_Botpath_f
	.align 2
	.globl Cmd_Showpath_f
	.type	 Cmd_Showpath_f,@function
Cmd_Showpath_f:
	lwz 9,264(3)
	andi. 0,9,8192
	bc 12,2,.L358
	addi 0,9,-8192
	stw 0,264(3)
	blr
.L358:
	ori 0,9,8192
	stw 0,264(3)
	blr
.Lfe36:
	.size	 Cmd_Showpath_f,.Lfe36-Cmd_Showpath_f
	.align 2
	.globl Cmd_TakeKey_f
	.type	 Cmd_TakeKey_f,@function
Cmd_TakeKey_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl K2_IsAnti
	cmpwi 0,3,0
	bc 12,2,.L437
	mr 3,31
	bl K2_TakePlayerKey
	b .L438
.L437:
	lis 5,.LC103@ha
	mr 3,31
	la 5,.LC103@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L438:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe37:
	.size	 Cmd_TakeKey_f,.Lfe37-Cmd_TakeKey_f
	.section	".rodata"
	.align 2
.LC216:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Feign_f
	.type	 Cmd_Feign_f,@function
Cmd_Feign_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC216@ha
	lis 9,allowfeigning@ha
	la 11,.LC216@l(11)
	lfs 13,0(11)
	lwz 11,allowfeigning@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L440
	lwz 9,84(3)
	lwz 0,4012(9)
	cmpwi 0,0,0
	bc 12,2,.L441
	bl Client_EndFeign
	b .L443
.L441:
	bl Client_BeginFeign
	b .L443
.L440:
	lis 5,.LC104@ha
	li 4,2
	la 5,.LC104@l(5)
	crxor 6,6,6
	bl safe_cprintf
.L443:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe38:
	.size	 Cmd_Feign_f,.Lfe38-Cmd_Feign_f
	.section	".rodata"
	.align 2
.LC217:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_FlashGrenade_f
	.type	 Cmd_FlashGrenade_f,@function
Cmd_FlashGrenade_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 3,.LC105@ha
	la 3,.LC105@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 30,3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	lis 0,0x286b
	ori 0,0,51739
	subf 9,9,30
	mullw 9,9,0
	addi 11,10,740
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L445
	lis 5,.LC106@ha
	mr 3,31
	la 5,.LC106@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L444
.L445:
	lwz 0,4016(10)
	xori 9,0,3
	subfic 11,9,0
	adde 9,11,9
	subfic 11,0,0
	adde 0,11,0
	or. 0,0,9
	bc 12,2,.L446
	lis 9,.LC217@ha
	lis 11,flashgrenades@ha
	la 9,.LC217@l(9)
	lfs 13,0(9)
	lwz 9,flashgrenades@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L448
	li 0,1
	lis 4,.LC107@ha
	stw 0,4016(10)
	la 4,.LC107@l(4)
	mr 3,31
	crxor 6,6,6
	bl safe_centerprintf
	b .L448
.L446:
	lis 4,.LC108@ha
	stw 0,4016(10)
	mr 3,31
	la 4,.LC108@l(4)
	crxor 6,6,6
	bl safe_centerprintf
.L448:
	lwz 0,8(30)
	mr 3,31
	mr 4,30
	mtlr 0
	blrl
.L444:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe39:
	.size	 Cmd_FlashGrenade_f,.Lfe39-Cmd_FlashGrenade_f
	.section	".rodata"
	.align 2
.LC218:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_FreezeGrenade_f
	.type	 Cmd_FreezeGrenade_f,@function
Cmd_FreezeGrenade_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 3,.LC105@ha
	la 3,.LC105@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 30,3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	lis 0,0x286b
	ori 0,0,51739
	subf 9,9,30
	mullw 9,9,0
	addi 11,10,740
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L450
	lis 5,.LC106@ha
	mr 3,31
	la 5,.LC106@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L449
.L450:
	lwz 0,4016(10)
	cmplwi 0,0,1
	bc 12,1,.L451
	lis 9,.LC218@ha
	lis 11,freezegrenades@ha
	la 9,.LC218@l(9)
	lfs 13,0(9)
	lwz 9,freezegrenades@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L453
	li 0,3
	lis 4,.LC109@ha
	stw 0,4016(10)
	la 4,.LC109@l(4)
	mr 3,31
	crxor 6,6,6
	bl safe_centerprintf
	b .L453
.L451:
	li 0,0
	lis 4,.LC108@ha
	stw 0,4016(10)
	la 4,.LC108@l(4)
	mr 3,31
	crxor 6,6,6
	bl safe_centerprintf
.L453:
	lwz 0,8(30)
	mr 3,31
	mr 4,30
	mtlr 0
	blrl
.L449:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe40:
	.size	 Cmd_FreezeGrenade_f,.Lfe40-Cmd_FreezeGrenade_f
	.align 2
	.globl Cmd_DrunkRocket_f
	.type	 Cmd_DrunkRocket_f,@function
Cmd_DrunkRocket_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 30,.LC11@ha
	la 3,.LC11@l(30)
	bl FindItem
	mr. 4,3
	bc 4,2,.L455
	la 3,.LC11@l(30)
	bl FindItem
	mr. 4,3
	bc 4,2,.L455
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC23@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L454
.L455:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L457
	lis 4,.LC110@ha
	mr 3,31
	la 4,.LC110@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L454
.L457:
	li 0,1
	li 11,2
	stw 0,4076(10)
	mr 3,31
	lwz 9,84(31)
	stw 11,4032(9)
	crxor 6,6,6
	bl Use_Weapon
.L454:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe41:
	.size	 Cmd_DrunkRocket_f,.Lfe41-Cmd_DrunkRocket_f
	.align 2
	.globl Cmd_FreezeGrenadeLauncher_f
	.type	 Cmd_FreezeGrenadeLauncher_f,@function
Cmd_FreezeGrenadeLauncher_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 30,.LC10@ha
	la 3,.LC10@l(30)
	bl FindItem
	mr. 4,3
	bc 4,2,.L459
	la 3,.LC10@l(30)
	bl FindItem
	mr. 4,3
	bc 4,2,.L459
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC23@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L458
.L459:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L461
	lis 4,.LC111@ha
	mr 3,31
	la 4,.LC111@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L458
.L461:
	li 0,1
	li 11,2
	stw 0,4076(10)
	mr 3,31
	lwz 9,84(31)
	stw 11,4016(9)
	crxor 6,6,6
	bl Use_Weapon
.L458:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe42:
	.size	 Cmd_FreezeGrenadeLauncher_f,.Lfe42-Cmd_FreezeGrenadeLauncher_f
	.align 2
	.globl Cmd_FlashGrenadeLauncher_f
	.type	 Cmd_FlashGrenadeLauncher_f,@function
Cmd_FlashGrenadeLauncher_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 30,.LC10@ha
	la 3,.LC10@l(30)
	bl FindItem
	mr. 4,3
	bc 4,2,.L463
	la 3,.LC10@l(30)
	bl FindItem
	mr. 4,3
	bc 4,2,.L463
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC23@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L462
.L463:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L465
	lis 4,.LC111@ha
	mr 3,31
	la 4,.LC111@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L462
.L465:
	li 0,1
	li 11,0
	stw 0,4076(10)
	mr 3,31
	lwz 9,84(31)
	stw 11,4016(9)
	crxor 6,6,6
	bl Use_Weapon
.L462:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe43:
	.size	 Cmd_FlashGrenadeLauncher_f,.Lfe43-Cmd_FlashGrenadeLauncher_f
	.align 2
	.globl Cmd_FireGrenadeLauncher_f
	.type	 Cmd_FireGrenadeLauncher_f,@function
Cmd_FireGrenadeLauncher_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 30,.LC10@ha
	la 3,.LC10@l(30)
	bl FindItem
	mr. 4,3
	bc 4,2,.L467
	la 3,.LC10@l(30)
	bl FindItem
	mr. 4,3
	bc 4,2,.L467
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC23@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L466
.L467:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L469
	lis 4,.LC111@ha
	mr 3,31
	la 4,.LC111@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L466
.L469:
	li 0,1
	mr 3,31
	stw 0,4076(10)
	lwz 9,84(31)
	stw 0,4016(9)
	crxor 6,6,6
	bl Use_Weapon
.L466:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe44:
	.size	 Cmd_FireGrenadeLauncher_f,.Lfe44-Cmd_FireGrenadeLauncher_f
	.align 2
	.globl Cmd_FireRocketLauncher_f
	.type	 Cmd_FireRocketLauncher_f,@function
Cmd_FireRocketLauncher_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 30,.LC11@ha
	la 3,.LC11@l(30)
	bl FindItem
	mr. 4,3
	bc 4,2,.L471
	la 3,.LC11@l(30)
	bl FindItem
	mr. 4,3
	bc 4,2,.L471
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC23@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L470
.L471:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L473
	lis 4,.LC110@ha
	mr 3,31
	la 4,.LC110@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L470
.L473:
	li 0,1
	li 11,0
	stw 0,4076(10)
	mr 3,31
	lwz 9,84(31)
	stw 11,4032(9)
	crxor 6,6,6
	bl Use_Weapon
.L470:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe45:
	.size	 Cmd_FireRocketLauncher_f,.Lfe45-Cmd_FireRocketLauncher_f
	.align 2
	.globl Cmd_GibGun_f
	.type	 Cmd_GibGun_f,@function
Cmd_GibGun_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 30,.LC112@ha
	la 3,.LC112@l(30)
	bl FindItem
	mr. 4,3
	bc 4,2,.L475
	la 3,.LC112@l(30)
	bl FindItem
	mr. 4,3
	bc 4,2,.L475
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC23@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L474
.L475:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L477
	lis 4,.LC113@ha
	mr 3,31
	la 4,.LC113@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L474
.L477:
	li 0,1
	li 11,0
	stw 0,4076(10)
	mr 3,31
	lwz 9,84(31)
	stw 11,4044(9)
	crxor 6,6,6
	bl Use_Weapon
.L474:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe46:
	.size	 Cmd_GibGun_f,.Lfe46-Cmd_GibGun_f
	.align 2
	.globl Cmd_Keys2_f
	.type	 Cmd_Keys2_f,@function
Cmd_Keys2_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,gi+164@ha
	mr 31,3
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	lis 4,.LC114@ha
	la 4,.LC114@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L479
	lis 5,.LC115@ha
	mr 3,31
	li 4,2
	la 5,.LC115@l(5)
	crxor 6,6,6
	bl safe_cprintf
	mr 3,31
	li 4,0
	bl K2_OpenHelpMenu
.L479:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe47:
	.size	 Cmd_Keys2_f,.Lfe47-Cmd_Keys2_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
