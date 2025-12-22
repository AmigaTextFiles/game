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
	.string	"You must run the server with '+set cheats 1' to enable this command.\n"
	.align 2
.LC2:
	.string	"all"
	.align 2
.LC3:
	.string	"stamina"
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
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_Give_f
	.type	 Cmd_Give_f,@function
Cmd_Give_f:
	stwu 1,-64(1)
	mflr 0
	mfcr 12
	stmw 26,40(1)
	stw 0,68(1)
	stw 12,36(1)
	lis 9,deathmatch@ha
	lis 10,.LC14@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC14@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L62
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L62
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	b .L116
.L62:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 30,3
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	bl Q_stricmp
	subfic 0,3,0
	adde. 29,0,3
	mcrf 4,0
	bc 4,18,.L66
	lis 4,.LC3@ha
	mr 3,30
	la 4,.LC3@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L65
.L66:
	lwz 0,980(31)
	lis 11,0x4330
	lis 10,.LC15@ha
	xoris 0,0,0x8000
	la 10,.LC15@l(10)
	stw 0,28(1)
	stw 11,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,924(31)
	bc 12,18,.L61
.L65:
	cmpwi 4,29,0
	bc 4,18,.L69
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	lis 4,.LC4@ha
	la 4,.LC4@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L68
.L69:
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L70
	lwz 0,160(29)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	stw 3,480(31)
	b .L71
.L70:
	lwz 0,484(31)
	stw 0,480(31)
.L71:
	bc 12,18,.L61
.L68:
	bc 4,18,.L74
	lis 4,.LC5@ha
	mr 3,30
	la 4,.LC5@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L73
.L74:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L76
	lis 9,itemlist@ha
	mr 7,11
	la 8,itemlist@l(9)
	li 10,0
.L78:
	mr 27,8
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L77
	lwz 0,56(27)
	andi. 9,0,1
	bc 12,2,.L77
	lwz 11,84(31)
	addi 11,11,740
	lwzx 9,11,10
	addi 9,9,1
	stwx 9,11,10
.L77:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 8,8,80
	cmpw 0,29,0
	bc 12,0,.L78
.L76:
	bc 12,18,.L61
.L73:
	bc 4,18,.L84
	lis 4,.LC6@ha
	mr 3,30
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L83
.L84:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L86
	lis 9,itemlist@ha
	mr 26,11
	la 28,itemlist@l(9)
.L88:
	mr 27,28
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L87
	lwz 0,56(27)
	andi. 9,0,2
	bc 12,2,.L87
	mr 4,27
	mr 3,31
	li 5,1000
	bl Add_Ammo
.L87:
	lwz 0,1556(26)
	addi 29,29,1
	addi 28,28,80
	cmpw 0,29,0
	bc 12,0,.L88
.L86:
	bc 12,18,.L61
.L83:
	bc 4,18,.L94
	lis 4,.LC7@ha
	mr 3,30
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L93
.L94:
	lis 3,.LC8@ha
	lis 28,0xcccc
	la 3,.LC8@l(3)
	ori 28,28,52429
	bl FindItem
	li 27,0
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC9@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC9@l(11)
	srawi 0,0,4
	slwi 0,0,2
	stwx 27,9,0
	bl FindItem
	subf 0,29,3
	lwz 9,84(31)
	mullw 0,0,28
	lis 3,.LC10@ha
	addi 9,9,740
	la 3,.LC10@l(3)
	srawi 0,0,4
	slwi 0,0,2
	stwx 27,9,0
	bl FindItem
	mr 27,3
	lwz 9,84(31)
	subf 29,29,27
	lwz 11,64(27)
	mullw 29,29,28
	addi 9,9,740
	lwz 0,4(11)
	srawi 29,29,4
	slwi 29,29,2
	stwx 0,9,29
	bc 12,18,.L61
.L93:
	bc 4,18,.L97
	lis 4,.LC11@ha
	mr 3,30
	la 4,.LC11@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L96
.L97:
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
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
	bc 12,2,.L98
	mr 3,29
	bl G_FreeEdict
.L98:
	bc 12,18,.L61
.L96:
	bc 12,18,.L100
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L61
	lis 9,itemlist@ha
	mr 7,11
	la 11,itemlist@l(9)
	li 8,1
	li 10,0
.L104:
	lwz 0,4(11)
	cmpwi 0,0,0
	bc 12,2,.L103
	lwz 0,56(11)
	andi. 9,0,7
	bc 4,2,.L103
	lwz 9,84(31)
	addi 9,9,740
	stwx 8,9,10
.L103:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 11,11,80
	cmpw 0,29,0
	bc 12,0,.L104
	b .L61
.L100:
	mr 3,30
	bl FindItem
	mr. 27,3
	bc 4,2,.L108
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	bl FindItem
	mr. 27,3
	bc 4,2,.L108
	lwz 0,8(29)
	lis 5,.LC12@ha
	mr 3,31
	la 5,.LC12@l(5)
	b .L116
.L108:
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 4,2,.L110
	lis 9,gi+8@ha
	lis 5,.LC13@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC13@l(5)
.L116:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L61
.L110:
	lis 9,itemlist@ha
	lis 0,0xcccc
	lwz 11,56(27)
	la 9,itemlist@l(9)
	ori 0,0,52429
	subf 9,9,27
	andi. 10,11,2
	mullw 9,9,0
	srawi 28,9,4
	bc 12,2,.L111
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L112
	lwz 0,160(29)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	slwi 0,28,2
	addi 9,9,740
	stwx 3,9,0
	b .L61
.L112:
	lwz 9,84(31)
	slwi 10,28,2
	lwz 11,48(27)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L61
.L111:
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
	bc 12,2,.L61
	mr 3,29
	bl G_FreeEdict
.L61:
	lwz 0,68(1)
	lwz 12,36(1)
	mtlr 0
	lmw 26,40(1)
	mtcrf 8,12
	la 1,64(1)
	blr
.Lfe2:
	.size	 Cmd_Give_f,.Lfe2-Cmd_Give_f
	.section	".rodata"
	.align 2
.LC16:
	.string	"\"The One\" mode OFF\n"
	.align 2
.LC17:
	.string	"\"The One\" mode ON\n"
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
	.string	"unknown item: %s\n"
	.align 2
.LC23:
	.string	"Item is not usable.\n"
	.align 2
.LC24:
	.string	"Out of item: %s\n"
	.align 2
.LC25:
	.string	"Item is not dropable.\n"
	.align 2
.LC26:
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
	stw 0,3536(31)
	stw 0,3528(31)
	lwz 10,84(30)
	lwz 0,3488(10)
	cmpwi 0,0,0
	bc 12,2,.L139
	lwz 0,3860(31)
	cmpwi 0,0,0
	bc 12,2,.L138
	bl PMenu_Close
	b .L137
.L138:
	mr 3,30
	bl PMenu_Close
	mr 3,30
	crxor 6,6,6
	bl MatrixOpenTankMenu
	b .L137
.L139:
	lis 9,.LC26@ha
	lis 11,teamplay@ha
	la 9,.LC26@l(9)
	lfs 13,0(9)
	lwz 9,teamplay@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L140
	lwz 0,3484(10)
	cmpwi 0,0,0
	bc 4,2,.L140
	lwz 0,3860(31)
	cmpwi 0,0,0
	bc 12,2,.L140
	mr 3,30
	bl PMenu_Close
	b .L137
.L140:
	lis 9,.LC26@ha
	lis 11,teamplay@ha
	la 9,.LC26@l(9)
	lfs 13,0(9)
	lwz 9,teamplay@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L141
	lwz 9,84(30)
	lwz 0,3484(9)
	cmpwi 0,0,0
	bc 4,2,.L141
	lwz 0,3860(31)
	cmpwi 0,0,0
	bc 4,2,.L141
	mr 3,30
	bl PMenu_Close
	mr 3,30
	crxor 6,6,6
	bl Cmd_JoinMenu_f
	b .L137
.L141:
	lwz 0,3532(31)
	cmpwi 0,0,0
	bc 12,2,.L142
	mr 3,30
	bl PMenu_Close
	li 0,0
	b .L151
.L142:
	lwz 29,3860(31)
	cmpwi 0,29,0
	bc 4,2,.L144
	mr 3,30
	crxor 6,6,6
	bl MatrixOpenMenu
	stw 29,3532(31)
	b .L143
.L144:
	mr 3,30
	bl PMenu_Close
	li 0,1
.L151:
	stw 0,3532(31)
.L143:
	lis 9,gi@ha
	li 3,5
	la 9,gi@l(9)
	addi 29,31,1760
	lwz 0,100(9)
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L149:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,29
	bc 4,1,.L149
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L137:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 Cmd_Inven_f,.Lfe3-Cmd_Inven_f
	.section	".rodata"
	.align 2
.LC27:
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
	lwz 0,3860(8)
	cmpwi 0,0,0
	bc 12,2,.L153
	bl PMenu_Select
	b .L152
.L153:
	lwz 11,736(8)
	addi 10,8,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L155
	lwz 0,3828(8)
	cmpwi 0,0,0
	bc 12,2,.L158
	mr 3,31
	bl ChaseNext
	b .L155
.L169:
	stw 11,736(8)
	b .L155
.L158:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L170:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L163
	mulli 0,11,80
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L163
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L169
.L163:
	addi 7,7,1
	bdnz .L170
	li 0,-1
	stw 0,736(8)
.L155:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L167
	lis 9,gi+8@ha
	lis 5,.LC27@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC27@l(5)
	b .L171
.L167:
	mulli 0,0,80
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L168
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC23@l(5)
.L171:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L152
.L168:
	mr 3,31
	mtlr 0
	blrl
.L152:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 Cmd_InvUse_f,.Lfe4-Cmd_InvUse_f
	.section	".rodata"
	.align 2
.LC28:
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
	bc 4,2,.L202
	lwz 0,3860(8)
	cmpwi 0,0,0
	bc 12,2,.L203
	bl PMenu_Next
	b .L202
.L203:
	lwz 0,3828(8)
	cmpwi 0,0,0
	bc 12,2,.L205
	mr 3,31
	bl ChaseNext
	b .L202
.L216:
	stw 11,736(8)
	b .L202
.L205:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L217:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L210
	mulli 0,11,80
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L210
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L216
.L210:
	addi 7,7,1
	bdnz .L217
	li 0,-1
	stw 0,736(8)
.L202:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L214
	lis 9,gi+8@ha
	lis 5,.LC28@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC28@l(5)
	b .L218
.L214:
	mulli 0,0,80
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L215
	lis 9,gi+8@ha
	lis 5,.LC25@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC25@l(5)
.L218:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L200
.L215:
	mr 3,31
	mtlr 0
	blrl
.L200:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_InvDrop_f,.Lfe5-Cmd_InvDrop_f
	.section	".rodata"
	.align 2
.LC29:
	.string	"%3i %s\n"
	.align 2
.LC30:
	.string	"...\n"
	.align 2
.LC31:
	.string	"%s\n%i players\n"
	.align 2
.LC32:
	.long 0x0
	.align 3
.LC33:
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
	lis 11,.LC32@ha
	lis 9,maxclients@ha
	la 11,.LC32@l(11)
	mr 23,3
	lfs 13,0(11)
	li 27,0
	li 31,0
	lwz 11,maxclients@l(9)
	addi 29,1,1352
	addi 30,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L229
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L231:
	lwz 0,0(11)
	addi 11,11,3916
	cmpwi 0,0,0
	bc 12,2,.L230
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L230:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L231
.L229:
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
	bc 4,0,.L235
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC29@ha
	lis 25,.LC30@ha
.L237:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC29@l(26)
	addi 28,28,4
	mulli 7,7,3916
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
	bc 4,1,.L238
	la 4,.LC30@l(25)
	mr 3,30
	bl strcat
	b .L235
.L238:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L237
.L235:
	lis 9,gi+8@ha
	lis 5,.LC31@ha
	lwz 0,gi+8@l(9)
	mr 3,23
	la 5,.LC31@l(5)
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
.Lfe6:
	.size	 Cmd_Players_f,.Lfe6-Cmd_Players_f
	.section	".rodata"
	.align 2
.LC34:
	.string	"flipoff\n"
	.align 2
.LC35:
	.string	"salute\n"
	.align 2
.LC36:
	.string	"taunt\n"
	.align 2
.LC37:
	.string	"wave\n"
	.align 2
.LC38:
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
	bc 4,2,.L240
	lwz 0,3728(9)
	cmpwi 0,0,1
	bc 12,1,.L240
	cmplwi 0,3,4
	li 0,1
	stw 0,3728(9)
	bc 12,1,.L249
	lis 11,.L250@ha
	slwi 10,3,2
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
	.long .L244-.L250
	.long .L245-.L250
	.long .L246-.L250
	.long .L247-.L250
	.long .L249-.L250
.L244:
	lis 9,gi+8@ha
	lis 5,.LC34@ha
	lwz 0,gi+8@l(9)
	la 5,.LC34@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,71
	li 9,83
	b .L251
.L245:
	lis 9,gi+8@ha
	lis 5,.LC35@ha
	lwz 0,gi+8@l(9)
	la 5,.LC35@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,83
	li 9,94
	b .L251
.L246:
	lis 9,gi+8@ha
	lis 5,.LC36@ha
	lwz 0,gi+8@l(9)
	la 5,.LC36@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,94
	li 9,111
	b .L251
.L247:
	lis 9,gi+8@ha
	lis 5,.LC37@ha
	lwz 0,gi+8@l(9)
	la 5,.LC37@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,111
	li 9,122
	b .L251
.L249:
	lis 9,gi+8@ha
	lis 5,.LC38@ha
	lwz 0,gi+8@l(9)
	la 5,.LC38@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,122
	li 9,134
.L251:
	stw 0,56(31)
	stw 9,3724(11)
.L240:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 Cmd_Wave_f,.Lfe7-Cmd_Wave_f
	.section	".rodata"
	.align 2
.LC39:
	.string	"(%s): "
	.align 2
.LC40:
	.string	"%s: "
	.align 2
.LC41:
	.string	" "
	.align 2
.LC42:
	.string	"\n"
	.align 2
.LC43:
	.string	"You can't talk for %d more seconds\n"
	.align 2
.LC44:
	.string	"Flood protection:  You can't talk for %d seconds.\n"
	.align 2
.LC45:
	.string	"%s"
	.align 2
.LC46:
	.long 0x0
	.align 3
.LC47:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC48:
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
	bc 12,1,.L253
	cmpwi 0,31,0
	bc 12,2,.L252
.L253:
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
	bc 12,2,.L255
	lwz 6,84(28)
	lis 5,.LC39@ha
	addi 3,1,8
	la 5,.LC39@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L256
.L255:
	lwz 6,84(28)
	lis 5,.LC40@ha
	addi 3,1,8
	la 5,.LC40@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L256:
	cmpwi 0,31,0
	bc 12,2,.L257
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC41@ha
	addi 3,1,8
	la 4,.LC41@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L258
.L257:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L259
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
.L259:
	mr 4,29
	addi 3,1,8
	bl strcat
.L258:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L260
	li 0,0
	stb 0,158(1)
.L260:
	lis 4,.LC42@ha
	addi 3,1,8
	la 4,.LC42@l(4)
	bl strcat
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 8,0(9)
	lis 9,flood_msgs@ha
	lwz 11,flood_msgs@l(9)
	lfs 9,20(11)
	fcmpu 0,9,8
	bc 12,2,.L261
	lwz 7,84(28)
	lis 9,level+4@ha
	lfs 10,level+4@l(9)
	lfs 0,3776(7)
	fcmpu 0,10,0
	bc 4,0,.L262
	fsubs 0,0,10
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC43@ha
	mr 3,28
	la 5,.LC43@l(5)
	li 4,2
	mtlr 0
	fctiwz 13,0
	stfd 13,2064(1)
	b .L275
.L262:
	lwz 0,3820(7)
	lis 10,0x4330
	lis 11,.LC47@ha
	addi 8,7,3780
	mr 6,0
	la 11,.LC47@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,2068(1)
	lis 11,.LC48@ha
	stw 10,2064(1)
	la 11,.LC48@l(11)
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
	bc 12,2,.L264
	lis 11,flood_persecond@ha
	fsubs 13,10,0
	lwz 9,flood_persecond@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L264
	lis 9,flood_waitdelay@ha
	lis 10,gi+8@ha
	lwz 11,flood_waitdelay@l(9)
	lis 5,.LC44@ha
	mr 3,28
	la 5,.LC44@l(5)
	lfs 13,20(11)
	li 4,3
	fadds 13,10,13
	stfs 13,3776(7)
	lfs 0,20(11)
	lwz 0,gi+8@l(10)
	mtlr 0
	fctiwz 12,0
	stfd 12,2064(1)
.L275:
	lwz 6,2068(1)
	crxor 6,6,6
	blrl
	b .L252
.L264:
	lis 0,0xcccc
	addi 9,6,1
	ori 0,0,52429
	lis 11,level+4@ha
	mulhwu 0,9,0
	srwi 0,0,3
	mulli 0,0,10
	subf 9,0,9
	stw 9,3820(7)
	lfs 0,level+4@l(11)
	slwi 9,9,2
	stfsx 0,10,9
.L261:
	lis 9,.LC46@ha
	lis 11,dedicated@ha
	la 9,.LC46@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L265
	lis 9,gi+8@ha
	lis 5,.LC45@ha
	lwz 0,gi+8@l(9)
	la 5,.LC45@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L265:
	lis 9,game@ha
	li 31,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,31,0
	bc 12,1,.L252
	cmpwi 4,30,0
	lis 9,gi@ha
	la 24,gi@l(9)
	mr 25,11
	lis 26,g_edicts@ha
	lis 27,.LC45@ha
	li 30,1116
.L269:
	lwz 0,g_edicts@l(26)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L268
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L268
	bc 12,18,.L272
	mr 3,28
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L268
.L272:
	lwz 9,8(24)
	mr 3,29
	li 4,3
	la 5,.LC45@l(27)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L268:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,1116
	cmpw 0,31,0
	bc 4,1,.L269
.L252:
	lwz 0,2116(1)
	lwz 12,2076(1)
	mtlr 0
	lmw 24,2080(1)
	mtcrf 8,12
	la 1,2112(1)
	blr
.Lfe8:
	.size	 Cmd_Say_f,.Lfe8-Cmd_Say_f
	.section	".rodata"
	.align 2
.LC49:
	.string	"%02d:%02d %4d %3d %s%s\n"
	.align 2
.LC50:
	.string	" (spectator)"
	.align 2
.LC51:
	.string	""
	.align 2
.LC52:
	.string	"And more...\n"
	.align 2
.LC53:
	.long 0x0
	.align 3
.LC54:
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
	lis 9,.LC53@ha
	stb 0,96(1)
	li 28,0
	la 9,.LC53@l(9)
	lfs 0,20(11)
	lis 22,maxclients@ha
	lfs 13,0(9)
	addi 31,1,96
	lis 21,gi@ha
	lwz 9,g_edicts@l(10)
	lis 20,.LC45@ha
	fcmpu 0,13,0
	addi 30,9,1116
	bc 4,0,.L278
	lis 9,.LC50@ha
	lis 11,.LC51@ha
	la 23,.LC50@l(9)
	la 24,.LC51@l(11)
	lis 25,level@ha
	lis 26,0x4330
.L280:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L279
	lwz 10,84(30)
	lis 11,0x1b4e
	lis 8,0x6666
	lwz 9,level@l(25)
	ori 11,11,33205
	ori 8,8,26215
	lwz 0,3460(10)
	addi 29,10,700
	lwz 7,3480(10)
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
	bc 12,2,.L282
	stw 23,8(1)
	b .L283
.L282:
	stw 24,8(1)
.L283:
	mr 8,3
	mr 9,4
	lis 5,.LC49@ha
	mr 10,29
	addi 3,1,16
	la 5,.LC49@l(5)
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
	bc 4,1,.L284
	mr 3,31
	bl strlen
	lis 4,.LC52@ha
	add 3,31,3
	la 4,.LC52@l(4)
	crxor 6,6,6
	bl sprintf
	la 9,gi@l(21)
	mr 3,27
	lwz 0,8(9)
	la 5,.LC45@l(20)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L276
.L284:
	mr 3,31
	addi 4,1,16
	bl strcat
.L279:
	addi 28,28,1
	lwz 11,maxclients@l(22)
	xoris 0,28,0x8000
	lis 10,.LC54@ha
	stw 0,1516(1)
	la 10,.LC54@l(10)
	addi 30,30,1116
	stw 26,1512(1)
	lfd 13,0(10)
	lfd 0,1512(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L280
.L278:
	lis 9,gi+8@ha
	lis 5,.LC45@ha
	lwz 0,gi+8@l(9)
	mr 3,27
	la 5,.LC45@l(5)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L276:
	lwz 0,1572(1)
	mtlr 0
	lmw 20,1520(1)
	la 1,1568(1)
	blr
.Lfe9:
	.size	 Cmd_PlayerList_f,.Lfe9-Cmd_PlayerList_f
	.section	".rodata"
	.align 2
.LC55:
	.string	"players"
	.align 2
.LC56:
	.string	"say"
	.align 2
.LC57:
	.string	"say_team"
	.align 2
.LC58:
	.string	"score"
	.align 2
.LC59:
	.string	"help"
	.align 2
.LC60:
	.string	"use"
	.align 2
.LC61:
	.string	"drop"
	.align 2
.LC62:
	.string	"give"
	.align 2
.LC63:
	.string	"god"
	.align 2
.LC64:
	.string	"notarget"
	.align 2
.LC65:
	.string	"noclip"
	.align 2
.LC66:
	.string	"inven"
	.align 2
.LC67:
	.string	"invnext"
	.align 2
.LC68:
	.string	"invprev"
	.align 2
.LC69:
	.string	"invnextw"
	.align 2
.LC70:
	.string	"invprevw"
	.align 2
.LC71:
	.string	"invnextp"
	.align 2
.LC72:
	.string	"invprevp"
	.align 2
.LC73:
	.string	"invuse"
	.align 2
.LC74:
	.string	"invdrop"
	.align 2
.LC75:
	.string	"weapprev"
	.align 2
.LC76:
	.string	"weapnext"
	.align 2
.LC77:
	.string	"weaplast"
	.align 2
.LC78:
	.string	"kill"
	.align 2
.LC79:
	.string	"putaway"
	.align 2
.LC80:
	.string	"wave"
	.align 2
.LC81:
	.string	"playerlist"
	.align 2
.LC82:
	.string	"thirdperson"
	.align 2
.LC83:
	.string	"hud"
	.align 2
.LC84:
	.string	"booton"
	.align 2
.LC85:
	.string	"bootoff"
	.align 2
.LC86:
	.string	"dodgeon"
	.align 2
.LC87:
	.string	"dodgeoff"
	.align 2
.LC88:
	.string	"up_speed"
	.align 2
.LC89:
	.string	"speed"
	.align 2
.LC90:
	.string	"change"
	.align 2
.LC91:
	.string	"posses"
	.align 2
.LC92:
	.string	"stopbullets"
	.align 2
.LC93:
	.string	"irvision"
	.align 2
.LC94:
	.string	"cloak"
	.align 2
.LC95:
	.string	"matrixjump"
	.align 2
.LC96:
	.string	"autobuy"
	.align 2
.LC97:
	.string	"screen tilt"
	.align 2
.LC98:
	.string	"screentilt"
	.align 2
.LC99:
	.string	"tiltscreen"
	.align 2
.LC100:
	.string	"lights"
	.align 2
.LC101:
	.string	"whostheman"
	.align 2
.LC102:
	.string	"BLASTERMASTER!"
	.align 2
.LC103:
	.string	"whosyourdaddy"
	.align 2
.LC104:
	.string	"VARLI3!"
	.align 2
.LC105:
	.long 0x0
	.align 2
.LC106:
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
	bc 12,2,.L286
	lis 9,gi@ha
	li 3,0
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC55@ha
	la 4,.LC55@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L288
	mr 3,29
	bl Cmd_Players_f
	b .L286
.L288:
	lis 4,.LC56@ha
	mr 3,31
	la 4,.LC56@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L289
	mr 3,29
	li 4,0
	b .L511
.L289:
	lis 4,.LC57@ha
	mr 3,31
	la 4,.LC57@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L290
	mr 3,29
	li 4,1
.L511:
	li 5,0
	bl Cmd_Say_f
	b .L286
.L290:
	lis 4,.LC58@ha
	mr 3,31
	la 4,.LC58@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L291
	mr 3,29
	bl Cmd_Score_f
	b .L286
.L291:
	lis 4,.LC59@ha
	mr 3,31
	la 4,.LC59@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L292
	mr 3,29
	bl Cmd_Help_f
	b .L286
.L292:
	lis 10,.LC105@ha
	lis 9,level+200@ha
	la 10,.LC105@l(10)
	lfs 0,level+200@l(9)
	lfs 31,0(10)
	fcmpu 0,0,31
	bc 4,2,.L286
	lis 4,.LC60@ha
	mr 3,31
	la 4,.LC60@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L294
	lwz 9,164(30)
	mtlr 9
	blrl
	mr 31,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L295
	lwz 0,8(30)
	lis 5,.LC22@ha
	mr 3,29
	la 5,.LC22@l(5)
	b .L512
.L295:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L297
	lwz 0,8(30)
	lis 5,.LC23@ha
	mr 3,29
	la 5,.LC23@l(5)
	b .L513
.L297:
	lis 9,itemlist@ha
	lis 0,0xcccc
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,52429
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,4
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L514
	b .L304
.L294:
	lis 4,.LC61@ha
	mr 3,31
	la 4,.LC61@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L300
	lwz 9,164(30)
	mtlr 9
	blrl
	mr 31,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L301
	lwz 0,8(30)
	lis 5,.LC22@ha
	mr 3,29
	la 5,.LC22@l(5)
	b .L512
.L301:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L303
	lwz 0,8(30)
	lis 5,.LC25@ha
	mr 3,29
	la 5,.LC25@l(5)
	b .L513
.L303:
	lis 9,itemlist@ha
	lis 0,0xcccc
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,52429
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,4
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L304
.L514:
	lwz 0,8(30)
	lis 5,.LC24@ha
	mr 3,29
	la 5,.LC24@l(5)
.L512:
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L286
.L304:
	mr 3,29
	mtlr 10
	blrl
	b .L286
.L300:
	lis 4,.LC62@ha
	mr 3,31
	la 4,.LC62@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L306
	mr 3,29
	bl Cmd_Give_f
	b .L286
.L306:
	lis 4,.LC63@ha
	mr 3,31
	la 4,.LC63@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L308
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L309
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L309
	lwz 0,8(30)
	lis 5,.LC1@ha
	mr 3,29
	la 5,.LC1@l(5)
	b .L513
.L309:
	lwz 0,264(29)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(29)
	bc 4,2,.L311
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L312
.L311:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
.L312:
	lis 9,gi+8@ha
	mr 3,29
	lwz 0,gi+8@l(9)
	b .L513
.L308:
	lis 4,.LC64@ha
	mr 3,31
	la 4,.LC64@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L314
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L315
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L315
	lwz 0,8(30)
	lis 5,.LC1@ha
	mr 3,29
	la 5,.LC1@l(5)
	b .L513
.L315:
	lwz 0,264(29)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(29)
	bc 4,2,.L317
	lis 9,.LC18@ha
	la 5,.LC18@l(9)
	b .L318
.L317:
	lis 9,.LC19@ha
	la 5,.LC19@l(9)
.L318:
	lis 9,gi+8@ha
	mr 3,29
	lwz 0,gi+8@l(9)
	b .L513
.L314:
	lis 4,.LC65@ha
	mr 3,31
	la 4,.LC65@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L320
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L321
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L321
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC1@l(5)
	b .L513
.L321:
	lwz 0,260(29)
	cmpwi 0,0,1
	bc 4,2,.L323
	li 0,4
	lis 9,.LC20@ha
	stw 0,260(29)
	la 5,.LC20@l(9)
	b .L324
.L323:
	li 0,1
	lis 9,.LC21@ha
	stw 0,260(29)
	la 5,.LC21@l(9)
.L324:
	lis 9,gi+8@ha
	mr 3,29
	lwz 0,gi+8@l(9)
	b .L513
.L320:
	lis 4,.LC66@ha
	mr 3,31
	la 4,.LC66@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L326
	mr 3,29
	bl Cmd_Inven_f
	b .L286
.L326:
	lis 4,.LC67@ha
	mr 3,31
	la 4,.LC67@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L328
	lwz 8,84(29)
	lwz 0,3860(8)
	cmpwi 0,0,0
	bc 4,2,.L515
	lwz 0,3828(8)
	cmpwi 0,0,0
	bc 4,2,.L516
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L510:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L336
	mulli 0,11,80
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L336
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L503
.L336:
	addi 7,7,1
	bdnz .L510
	b .L517
.L328:
	lis 4,.LC68@ha
	mr 3,31
	la 4,.LC68@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L341
	lwz 7,84(29)
	lwz 0,3860(7)
	cmpwi 0,0,0
	bc 4,2,.L518
	lwz 0,3828(7)
	cmpwi 0,0,0
	bc 4,2,.L519
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L509:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L349
	mulli 0,8,80
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L349
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L504
.L349:
	addi 11,11,-1
	bdnz .L509
	b .L520
.L341:
	lis 4,.LC69@ha
	mr 3,31
	la 4,.LC69@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L354
	lwz 8,84(29)
	lwz 0,3860(8)
	cmpwi 0,0,0
	bc 4,2,.L515
	lwz 0,3828(8)
	cmpwi 0,0,0
	bc 4,2,.L516
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L508:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L362
	mulli 0,11,80
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L362
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L503
.L362:
	addi 7,7,1
	bdnz .L508
	b .L517
.L354:
	lis 4,.LC70@ha
	mr 3,31
	la 4,.LC70@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L367
	lwz 7,84(29)
	lwz 0,3860(7)
	cmpwi 0,0,0
	bc 4,2,.L518
	lwz 0,3828(7)
	cmpwi 0,0,0
	bc 4,2,.L519
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L507:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L375
	mulli 0,8,80
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L375
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L504
.L375:
	addi 11,11,-1
	bdnz .L507
	b .L520
.L367:
	lis 4,.LC71@ha
	mr 3,31
	la 4,.LC71@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L380
	lwz 8,84(29)
	lwz 0,3860(8)
	cmpwi 0,0,0
	bc 12,2,.L381
.L515:
	mr 3,29
	bl PMenu_Next
	b .L286
.L381:
	lwz 0,3828(8)
	cmpwi 0,0,0
	bc 12,2,.L383
.L516:
	mr 3,29
	bl ChaseNext
	b .L286
.L383:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L506:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L388
	mulli 0,11,80
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L388
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L503
.L388:
	addi 7,7,1
	bdnz .L506
.L517:
	li 0,-1
	stw 0,736(8)
	b .L286
.L380:
	lis 4,.LC72@ha
	mr 3,31
	la 4,.LC72@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L393
	lwz 7,84(29)
	lwz 0,3860(7)
	cmpwi 0,0,0
	bc 12,2,.L394
.L518:
	mr 3,29
	bl PMenu_Prev
	b .L286
.L394:
	lwz 0,3828(7)
	cmpwi 0,0,0
	bc 12,2,.L396
.L519:
	mr 3,29
	bl ChasePrev
	b .L286
.L396:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L505:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L401
	mulli 0,8,80
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L401
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L504
.L401:
	addi 11,11,-1
	bdnz .L505
.L520:
	li 0,-1
	stw 0,736(7)
	b .L286
.L393:
	lis 4,.LC73@ha
	mr 3,31
	la 4,.LC73@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L406
	mr 3,29
	bl Cmd_InvUse_f
	b .L286
.L406:
	lis 4,.LC74@ha
	mr 3,31
	la 4,.LC74@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L408
	mr 3,29
	bl Cmd_InvDrop_f
	b .L286
.L408:
	lis 4,.LC75@ha
	mr 3,31
	la 4,.LC75@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L410
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L286
	lis 9,itemlist@ha
	lis 0,0xcccc
	la 9,itemlist@l(9)
	ori 0,0,52429
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,28,740
	mullw 9,9,0
	srawi 27,9,4
.L415:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L417
	mulli 0,11,80
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L417
	lwz 0,56(31)
	andi. 10,0,1
	bc 12,2,.L417
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L286
.L417:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L415
	b .L286
.L410:
	lis 4,.LC76@ha
	mr 3,31
	la 4,.LC76@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L423
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L286
	lis 9,itemlist@ha
	lis 0,0xcccc
	la 9,itemlist@l(9)
	ori 0,0,52429
	mr 25,9
	li 27,1
	subf 9,9,11
	addi 26,28,740
	mullw 9,9,0
	srawi 9,9,4
	addi 30,9,255
.L428:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L430
	mulli 0,11,80
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L430
	lwz 0,56(31)
	andi. 10,0,1
	bc 12,2,.L430
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L286
.L430:
	addi 27,27,1
	addi 30,30,-1
	cmpwi 0,27,256
	bc 4,1,.L428
	b .L286
.L423:
	lis 4,.LC77@ha
	mr 3,31
	la 4,.LC77@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L436
	lwz 10,84(29)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L286
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L286
	lis 11,itemlist@ha
	lis 9,0xcccc
	la 4,itemlist@l(11)
	ori 9,9,52429
	subf 0,4,0
	addi 11,10,740
	mullw 0,0,9
	srawi 10,0,4
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L286
	mulli 0,10,80
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L286
	lwz 0,56(4)
	andi. 10,0,1
	bc 12,2,.L286
	mr 3,29
	mtlr 9
	blrl
	b .L286
.L436:
	lis 4,.LC78@ha
	mr 3,31
	la 4,.LC78@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L444
	lwz 11,84(29)
	lis 9,level+4@ha
	lis 10,.LC106@ha
	lfs 0,level+4@l(9)
	la 10,.LC106@l(10)
	lfs 13,3824(11)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L286
	lwz 0,264(29)
	cmpwi 0,11,0
	li 9,13
	lis 11,meansOfDeath@ha
	stw 3,480(29)
	rlwinm 0,0,0,28,26
	stw 0,264(29)
	stw 9,meansOfDeath@l(11)
	bc 12,2,.L447
	mr 3,29
	mr 4,3
	bl MatrixRespawn
	b .L286
.L447:
	mr 3,29
	lis 6,0x1
	lis 7,vec3_origin@ha
	mr 4,3
	la 7,vec3_origin@l(7)
	mr 5,3
	ori 6,6,34464
	bl player_die
	b .L286
.L444:
	lis 4,.LC79@ha
	mr 3,31
	la 4,.LC79@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L450
	lwz 9,84(29)
	stw 3,3528(9)
	lwz 11,84(29)
	stw 3,3536(11)
	lwz 9,84(29)
	stw 3,3532(9)
	b .L286
.L450:
	lis 4,.LC80@ha
	mr 3,31
	la 4,.LC80@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L453
	mr 3,29
	bl Cmd_Wave_f
	b .L286
.L453:
	lis 4,.LC81@ha
	mr 3,31
	la 4,.LC81@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L455
	mr 3,29
	bl Cmd_PlayerList_f
	b .L286
.L455:
	lis 4,.LC82@ha
	mr 3,31
	la 4,.LC82@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L457
	mr 3,29
	bl Cmd_Chasecam_Toggle
	b .L286
.L457:
	lis 4,.LC83@ha
	mr 3,31
	la 4,.LC83@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L459
	mr 3,29
	crxor 6,6,6
	bl Cmd_ToggleHud
	b .L286
.L459:
	lis 4,.LC84@ha
	mr 3,31
	la 4,.LC84@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L461
	li 0,1
	stw 0,1064(29)
	b .L286
.L461:
	lis 4,.LC85@ha
	mr 3,31
	la 4,.LC85@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L463
	stw 3,1064(29)
	b .L286
.L463:
	lis 4,.LC86@ha
	mr 3,31
	la 4,.LC86@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L465
	li 0,1
	mr 3,29
	stw 0,1068(29)
	crxor 6,6,6
	bl cmd_dodgebullets_f
	b .L286
.L465:
	lis 4,.LC87@ha
	mr 3,31
	la 4,.LC87@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L467
	stw 3,1068(29)
	b .L286
.L467:
	lis 4,.LC88@ha
	mr 3,31
	la 4,.LC88@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L521
	lis 4,.LC89@ha
	mr 3,31
	la 4,.LC89@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L471
.L521:
	mr 3,29
	crxor 6,6,6
	bl Cmd_BuySpeed_f
	b .L286
.L471:
	lis 4,.LC90@ha
	mr 3,31
	la 4,.LC90@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L522
	lis 4,.LC91@ha
	mr 3,31
	la 4,.LC91@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L475
.L522:
	mr 3,29
	crxor 6,6,6
	bl MatrixStartSwap
	b .L286
.L475:
	lis 4,.LC92@ha
	mr 3,31
	la 4,.LC92@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L477
	mr 3,29
	crxor 6,6,6
	bl Cmd_StopBullets_f
	b .L286
.L477:
	lis 4,.LC93@ha
	mr 3,31
	la 4,.LC93@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L479
	mr 3,29
	crxor 6,6,6
	bl Cmd_Infrared_f
	b .L286
.L479:
	lis 4,.LC94@ha
	mr 3,31
	la 4,.LC94@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L481
	mr 3,29
	crxor 6,6,6
	bl Cmd_Cloak_f
	b .L286
.L481:
	lis 4,.LC95@ha
	mr 3,31
	la 4,.LC95@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L483
	mr 3,29
	bl SuperJump
	b .L286
.L483:
	lis 4,.LC96@ha
	mr 3,31
	la 4,.LC96@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L485
	mr 3,29
	crxor 6,6,6
	bl Cmd_AutoBuy_f
	b .L286
.L485:
	lis 4,.LC97@ha
	mr 3,31
	la 4,.LC97@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L523
	lis 4,.LC98@ha
	mr 3,31
	la 4,.LC98@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L523
	lis 4,.LC99@ha
	mr 3,31
	la 4,.LC99@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L491
.L523:
	mr 3,29
	bl Cmd_ScreenTilt_f
	b .L286
.L491:
	lis 4,.LC100@ha
	mr 3,31
	la 4,.LC100@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L493
	mr 3,29
	crxor 6,6,6
	bl Cmd_Lights_f
	b .L286
.L493:
	lis 4,.LC101@ha
	mr 3,31
	la 4,.LC101@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L495
	lis 9,gi+8@ha
	lis 5,.LC102@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC102@l(5)
	b .L513
.L495:
	lis 4,.LC103@ha
	mr 3,31
	la 4,.LC103@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L497
	lis 9,gi+8@ha
	lis 5,.LC104@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC104@l(5)
.L513:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L286
.L503:
	stw 11,736(8)
	b .L286
.L504:
	stw 8,736(7)
	b .L286
.L497:
	mr 3,29
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L286:
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
	lwz 8,84(3)
	lwz 11,736(8)
	addi 10,8,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L48
	lwz 0,3860(8)
	cmpwi 0,0,0
	bc 12,2,.L50
	bl PMenu_Next
	b .L48
.L50:
	lwz 0,3828(8)
	cmpwi 0,0,0
	bc 12,2,.L52
	bl ChaseNext
	b .L48
.L524:
	stw 11,736(8)
	b .L48
.L52:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L525:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L57
	mulli 0,11,80
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L57
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L524
.L57:
	addi 7,7,1
	bdnz .L525
	li 0,-1
	stw 0,736(8)
.L48:
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
	bc 12,2,.L527
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
	bc 12,2,.L527
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L9
	addi 3,3,1
	b .L526
.L9:
	stb 30,0(3)
.L527:
	mr 3,31
.L526:
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
	lwz 0,3860(8)
	cmpwi 0,0,0
	bc 12,2,.L27
	bl PMenu_Next
	b .L26
.L27:
	lwz 0,3828(8)
	cmpwi 0,0,0
	bc 12,2,.L28
	bl ChaseNext
	b .L26
.L528:
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
.L529:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L31
	mulli 0,11,80
	add 10,0,3
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L31
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L528
.L31:
	addi 7,7,1
	bdnz .L529
	li 0,-1
	stw 0,736(8)
.L26:
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
	lwz 0,3860(7)
	cmpwi 0,0,0
	bc 12,2,.L38
	bl PMenu_Prev
	b .L37
.L38:
	lwz 0,3828(7)
	cmpwi 0,0,0
	bc 12,2,.L39
	bl ChasePrev
	b .L37
.L530:
	stw 8,736(7)
	b .L37
.L39:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L531:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L42
	mulli 0,8,80
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L42
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L530
.L42:
	addi 11,11,-1
	bdnz .L531
	li 0,-1
	stw 0,736(7)
.L37:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 SelectPrevItem,.Lfe14-SelectPrevItem
	.section	".rodata"
	.align 2
.LC107:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC107@ha
	lis 9,deathmatch@ha
	la 11,.LC107@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L118
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L118
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L117
.L118:
	lwz 0,264(3)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(3)
	bc 4,2,.L119
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L120
.L119:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
.L120:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L117:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 Cmd_God_f,.Lfe15-Cmd_God_f
	.section	".rodata"
	.align 2
.LC108:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC108@ha
	lis 9,deathmatch@ha
	la 11,.LC108@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L122
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L122
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L121
.L122:
	lwz 0,264(3)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(3)
	bc 4,2,.L123
	lis 9,.LC18@ha
	la 5,.LC18@l(9)
	b .L124
.L123:
	lis 9,.LC19@ha
	la 5,.LC19@l(9)
.L124:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L121:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 Cmd_Notarget_f,.Lfe16-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC109:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC109@ha
	lis 9,deathmatch@ha
	la 11,.LC109@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L126
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L126
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L125
.L126:
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 4,2,.L127
	li 0,4
	lis 9,.LC20@ha
	stw 0,260(3)
	la 5,.LC20@l(9)
	b .L128
.L127:
	li 0,1
	lis 9,.LC21@ha
	stw 0,260(3)
	la 5,.LC21@l(9)
.L128:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L125:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 Cmd_Noclip_f,.Lfe17-Cmd_Noclip_f
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
	bc 4,2,.L130
	lwz 0,8(29)
	lis 5,.LC22@ha
	mr 3,31
	la 5,.LC22@l(5)
	b .L532
.L130:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L131
	lwz 0,8(29)
	lis 5,.LC23@ha
	mr 3,31
	la 5,.LC23@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L129
.L131:
	lis 9,itemlist@ha
	lis 0,0xcccc
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,52429
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,4
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L132
	lwz 0,8(29)
	lis 5,.LC24@ha
	mr 3,31
	la 5,.LC24@l(5)
.L532:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L129
.L132:
	mr 3,31
	mtlr 10
	blrl
.L129:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 Cmd_Use_f,.Lfe18-Cmd_Use_f
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
	bc 4,2,.L134
	lwz 0,8(29)
	lis 5,.LC22@ha
	mr 3,31
	la 5,.LC22@l(5)
	b .L533
.L134:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L135
	lwz 0,8(29)
	lis 5,.LC25@ha
	mr 3,31
	la 5,.LC25@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L133
.L135:
	lis 9,itemlist@ha
	lis 0,0xcccc
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,52429
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,4
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L136
	lwz 0,8(29)
	lis 5,.LC24@ha
	mr 3,31
	la 5,.LC24@l(5)
.L533:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L133
.L136:
	mr 3,31
	mtlr 10
	blrl
.L133:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 Cmd_Drop_f,.Lfe19-Cmd_Drop_f
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
	bc 12,2,.L172
	lis 9,itemlist@ha
	lis 0,0xcccc
	la 9,itemlist@l(9)
	ori 0,0,52429
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,29,740
	mullw 9,9,0
	srawi 27,9,4
.L177:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L176
	mulli 0,11,80
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L176
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L176
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L172
.L176:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L177
.L172:
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
	mr 27,3
	lwz 29,84(27)
	lwz 11,1788(29)
	cmpwi 0,11,0
	bc 12,2,.L183
	lis 9,itemlist@ha
	lis 0,0xcccc
	la 9,itemlist@l(9)
	ori 0,0,52429
	mr 25,9
	li 28,1
	subf 9,9,11
	addi 26,29,740
	mullw 9,9,0
	srawi 9,9,4
	addi 30,9,255
.L188:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L187
	mulli 0,11,80
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L187
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L187
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L183
.L187:
	addi 28,28,1
	addi 30,30,-1
	cmpwi 0,28,256
	bc 4,1,.L188
.L183:
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
	lwz 10,84(3)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L194
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L194
	lis 11,itemlist@ha
	lis 9,0xcccc
	la 4,itemlist@l(11)
	ori 9,9,52429
	subf 0,4,0
	addi 11,10,740
	mullw 0,0,9
	srawi 10,0,4
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L194
	mulli 0,10,80
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L194
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L194
	mtlr 9
	blrl
.L194:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 Cmd_WeapLast_f,.Lfe22-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC110:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Cmd_Kill_f
	.type	 Cmd_Kill_f,@function
Cmd_Kill_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lis 9,level+4@ha
	lis 10,.LC110@ha
	lfs 0,level+4@l(9)
	la 10,.LC110@l(10)
	lfs 13,3824(11)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L219
	lwz 9,264(3)
	li 0,0
	cmpwi 0,11,0
	stw 0,480(3)
	lis 11,meansOfDeath@ha
	rlwinm 9,9,0,28,26
	li 0,13
	stw 9,264(3)
	stw 0,meansOfDeath@l(11)
	bc 12,2,.L221
	mr 4,3
	bl MatrixRespawn
	b .L219
.L221:
	lis 6,0x1
	lis 7,vec3_origin@ha
	mr 4,3
	la 7,vec3_origin@l(7)
	mr 5,3
	ori 6,6,34464
	bl player_die
.L219:
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
	lwz 9,84(3)
	li 0,0
	stw 0,3528(9)
	lwz 11,84(3)
	stw 0,3536(11)
	lwz 9,84(3)
	stw 0,3532(9)
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
	mulli 9,9,3916
	mulli 11,3,3916
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
