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
	.string	"health"
	.align 2
.LC4:
	.string	"weapons"
	.align 2
.LC5:
	.string	"ammo"
	.align 2
.LC6:
	.string	"armor"
	.align 2
.LC7:
	.string	"Jacket Armor"
	.align 2
.LC8:
	.string	"Combat Armor"
	.align 2
.LC9:
	.string	"Body Armor"
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
	lis 10,.LC13@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC13@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L65
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L65
	lis 5,.LC1@ha
	la 5,.LC1@l(5)
	b .L116
.L65:
	lis 9,gi@ha
	la 28,gi@l(9)
	lwz 9,164(28)
	mtlr 9
	blrl
	mr 30,3
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	bl Q_stricmp
	subfic 0,3,0
	adde. 27,0,3
	mfcr 29
	bc 4,2,.L69
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
	bc 4,2,.L68
.L69:
	lwz 9,156(28)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L70
	lwz 0,160(28)
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
	cmpwi 4,27,0
	bc 12,18,.L64
.L68:
	bc 4,18,.L74
	lis 4,.LC4@ha
	mr 3,30
	la 4,.LC4@l(4)
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
	addi 8,8,76
	cmpw 0,29,0
	bc 12,0,.L78
.L76:
	bc 12,18,.L64
.L73:
	bc 4,18,.L84
	lis 4,.LC5@ha
	mr 3,30
	la 4,.LC5@l(4)
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
	addi 28,28,76
	cmpw 0,29,0
	bc 12,0,.L88
.L86:
	bc 12,18,.L64
.L83:
	bc 4,18,.L94
	lis 4,.LC6@ha
	mr 3,30
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L93
.L94:
	lis 3,.LC7@ha
	lis 28,0x286b
	la 3,.LC7@l(3)
	ori 28,28,51739
	bl FindItem
	li 27,0
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC8@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC8@l(11)
	rlwinm 0,0,0,0,29
	stwx 27,9,0
	bl FindItem
	subf 0,29,3
	lwz 9,84(31)
	mullw 0,0,28
	lis 3,.LC9@ha
	addi 9,9,740
	la 3,.LC9@l(3)
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
	bc 12,18,.L64
.L93:
	bc 4,18,.L97
	lis 4,.LC10@ha
	mr 3,30
	la 4,.LC10@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L96
.L97:
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
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
	bc 12,18,.L64
.L96:
	bc 12,18,.L100
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L64
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
	addi 11,11,76
	cmpw 0,29,0
	bc 12,0,.L104
	b .L64
.L100:
	mr 3,30
	bl FindItem
	mr. 27,3
	bc 4,2,.L108
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	bl FindItem
	mr. 27,3
	bc 4,2,.L108
	lis 5,.LC11@ha
	mr 3,31
	la 5,.LC11@l(5)
	b .L116
.L108:
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 4,2,.L110
	lis 5,.LC12@ha
	mr 3,31
	la 5,.LC12@l(5)
.L116:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L64
.L110:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,56(27)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,27
	andi. 10,11,2
	mullw 9,9,0
	srawi 28,9,2
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
	b .L64
.L112:
	lwz 9,84(31)
	slwi 10,28,2
	lwz 11,48(27)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L64
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
	bc 12,2,.L64
	mr 3,29
	bl G_FreeEdict
.L64:
	lwz 0,52(1)
	lwz 12,20(1)
	mtlr 0
	lmw 26,24(1)
	mtcrf 8,12
	la 1,48(1)
	blr
.Lfe2:
	.size	 Cmd_Give_f,.Lfe2-Cmd_Give_f
	.section	".rodata"
	.align 2
.LC14:
	.string	"godmode OFF\n"
	.align 2
.LC15:
	.string	"godmode ON\n"
	.align 2
.LC16:
	.string	"notarget OFF\n"
	.align 2
.LC17:
	.string	"notarget ON\n"
	.align 2
.LC18:
	.string	"noclip OFF\n"
	.align 2
.LC19:
	.string	"noclip ON\n"
	.align 2
.LC20:
	.string	"unknown item: %s\n"
	.align 2
.LC21:
	.string	"Item is not usable.\n"
	.align 2
.LC22:
	.string	"Out of item: %s\n"
	.align 2
.LC23:
	.string	"tech"
	.align 2
.LC24:
	.string	"Item is not dropable.\n"
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
	lis 4,.LC23@ha
	la 4,.LC23@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L134
	mr 3,31
	bl CTFWhat_Tech
	mr. 10,3
	bc 12,2,.L134
	lwz 0,12(10)
	mr 3,31
	mr 4,10
	mtlr 0
	blrl
	b .L133
.L134:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 30,3
	bl FindItem
	mr. 10,3
	bc 4,2,.L135
	lis 5,.LC20@ha
	mr 3,31
	la 5,.LC20@l(5)
	b .L138
.L135:
	lwz 8,12(10)
	cmpwi 0,8,0
	bc 4,2,.L136
	lis 5,.LC24@ha
	mr 3,31
	la 5,.LC24@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L133
.L136:
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
	bc 4,2,.L137
	lis 5,.LC22@ha
	mr 3,31
	la 5,.LC22@l(5)
.L138:
	mr 6,30
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L133
.L137:
	mr 3,31
	mr 4,10
	mtlr 8
	blrl
.L133:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 Cmd_Drop_f,.Lfe3-Cmd_Drop_f
	.section	".rodata"
	.align 2
.LC25:
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
	lwz 0,3532(8)
	cmpwi 0,0,0
	bc 12,2,.L149
	bl PMenu_Select
	b .L148
.L149:
	lwz 11,736(8)
	addi 10,8,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L151
	lwz 0,3856(8)
	cmpwi 0,0,0
	bc 12,2,.L154
	mr 3,31
	bl ChaseNext
	b .L151
.L166:
	stw 11,736(8)
	b .L151
.L154:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L167:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L160
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L160
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L166
.L160:
	addi 7,7,1
	bdnz .L167
	li 0,-1
	stw 0,736(8)
.L151:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L164
	lis 5,.LC25@ha
	mr 3,31
	la 5,.LC25@l(5)
	b .L168
.L164:
	mulli 0,0,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L165
	lis 5,.LC21@ha
	mr 3,31
	la 5,.LC21@l(5)
.L168:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L148
.L165:
	mr 3,31
	mtlr 0
	blrl
.L148:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 Cmd_InvUse_f,.Lfe4-Cmd_InvUse_f
	.section	".rodata"
	.align 2
.LC26:
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
	lwz 0,3532(8)
	cmpwi 0,0,0
	bc 12,2,.L203
	bl PMenu_Next
	b .L202
.L203:
	lwz 0,3856(8)
	cmpwi 0,0,0
	bc 12,2,.L205
	mr 3,31
	bl ChaseNext
	b .L202
.L217:
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
.L218:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L211
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L211
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L217
.L211:
	addi 7,7,1
	bdnz .L218
	li 0,-1
	stw 0,736(8)
.L202:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L215
	lis 5,.LC26@ha
	mr 3,31
	la 5,.LC26@l(5)
	b .L219
.L215:
	mulli 0,0,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L216
	lis 5,.LC24@ha
	mr 3,31
	la 5,.LC24@l(5)
.L219:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L200
.L216:
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
.LC27:
	.string	"%3i %s\n"
	.align 2
.LC28:
	.string	"...\n"
	.align 2
.LC29:
	.string	"%s\n%i players\n"
	.align 2
.LC30:
	.long 0x0
	.align 3
.LC31:
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
	lis 11,.LC30@ha
	lis 9,maxclients@ha
	la 11,.LC30@l(11)
	mr 23,3
	lfs 13,0(11)
	li 27,0
	li 31,0
	lwz 11,maxclients@l(9)
	addi 29,1,1352
	addi 30,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L230
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L232:
	lwz 0,0(11)
	addi 11,11,3864
	cmpwi 0,0,0
	bc 12,2,.L231
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L231:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L232
.L230:
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
	bc 4,0,.L236
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC27@ha
	lis 25,.LC28@ha
.L238:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC27@l(26)
	addi 28,28,4
	mulli 7,7,3864
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
	bc 4,1,.L239
	la 4,.LC28@l(25)
	mr 3,30
	bl strcat
	b .L236
.L239:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L238
.L236:
	lis 5,.LC29@ha
	mr 3,23
	la 5,.LC29@l(5)
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
.Lfe6:
	.size	 Cmd_Players_f,.Lfe6-Cmd_Players_f
	.section	".rodata"
	.align 2
.LC32:
	.string	"flipoff\n"
	.align 2
.LC33:
	.string	"salute\n"
	.align 2
.LC34:
	.string	"taunt\n"
	.align 2
.LC35:
	.string	"wave\n"
	.align 2
.LC36:
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
	bc 4,2,.L241
	lwz 0,3732(9)
	cmpwi 0,0,1
	bc 12,1,.L241
	cmplwi 0,3,4
	li 0,1
	stw 0,3732(9)
	bc 12,1,.L250
	lis 11,.L251@ha
	slwi 10,3,2
	la 11,.L251@l(11)
	lis 9,.L251@ha
	lwzx 0,10,11
	la 9,.L251@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L251:
	.long .L245-.L251
	.long .L246-.L251
	.long .L247-.L251
	.long .L248-.L251
	.long .L250-.L251
.L245:
	lis 5,.LC32@ha
	mr 3,31
	la 5,.LC32@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 11,84(31)
	li 0,71
	li 9,83
	b .L252
.L246:
	lis 5,.LC33@ha
	mr 3,31
	la 5,.LC33@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 11,84(31)
	li 0,83
	li 9,94
	b .L252
.L247:
	lis 5,.LC34@ha
	mr 3,31
	la 5,.LC34@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 11,84(31)
	li 0,94
	li 9,111
	b .L252
.L248:
	lis 5,.LC35@ha
	mr 3,31
	la 5,.LC35@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 11,84(31)
	li 0,111
	li 9,122
	b .L252
.L250:
	lis 5,.LC36@ha
	mr 3,31
	la 5,.LC36@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 11,84(31)
	li 0,122
	li 9,134
.L252:
	stw 0,56(31)
	stw 9,3728(11)
.L241:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 Cmd_Wave_f,.Lfe7-Cmd_Wave_f
	.section	".rodata"
	.align 2
.LC37:
	.string	"(%s): "
	.align 2
.LC38:
	.string	"%s: "
	.align 2
.LC39:
	.string	" "
	.align 2
.LC40:
	.string	"\n"
	.align 2
.LC41:
	.string	"You can't talk for %d more seconds\n"
	.align 2
.LC42:
	.string	"Flood protection:  You can't talk for %d seconds.\n"
	.align 2
.LC43:
	.string	"%s"
	.align 2
.LC44:
	.long 0x0
	.align 3
.LC45:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC46:
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
	bc 12,1,.L254
	cmpwi 0,31,0
	bc 12,2,.L253
.L254:
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
	bc 12,2,.L256
	lwz 6,84(28)
	lis 5,.LC37@ha
	addi 3,1,8
	la 5,.LC37@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L257
.L256:
	lwz 6,84(28)
	lis 5,.LC38@ha
	addi 3,1,8
	la 5,.LC38@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L257:
	cmpwi 0,31,0
	bc 12,2,.L258
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC39@ha
	addi 3,1,8
	la 4,.LC39@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L259
.L258:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L260
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
.L260:
	mr 4,29
	addi 3,1,8
	bl strcat
.L259:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L261
	li 0,0
	stb 0,158(1)
.L261:
	lis 4,.LC40@ha
	addi 3,1,8
	la 4,.LC40@l(4)
	bl strcat
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 8,0(9)
	lis 9,flood_msgs@ha
	lwz 11,flood_msgs@l(9)
	lfs 9,20(11)
	fcmpu 0,9,8
	bc 12,2,.L262
	lwz 7,84(28)
	lis 9,level+4@ha
	lfs 10,level+4@l(9)
	lfs 0,3780(7)
	fcmpu 0,10,0
	bc 4,0,.L263
	fsubs 0,0,10
	lis 5,.LC41@ha
	mr 3,28
	la 5,.LC41@l(5)
	li 4,2
	fctiwz 13,0
	stfd 13,2056(1)
	b .L276
.L263:
	lwz 0,3824(7)
	lis 10,0x4330
	lis 11,.LC45@ha
	addi 8,7,3784
	mr 6,0
	la 11,.LC45@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,2060(1)
	lis 11,.LC46@ha
	stw 10,2056(1)
	la 11,.LC46@l(11)
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
	bc 12,2,.L265
	lis 11,flood_persecond@ha
	fsubs 13,10,0
	lwz 9,flood_persecond@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L265
	lis 9,flood_waitdelay@ha
	lwz 11,flood_waitdelay@l(9)
	lis 5,.LC42@ha
	mr 3,28
	la 5,.LC42@l(5)
	li 4,3
	lfs 13,20(11)
	fadds 13,10,13
	stfs 13,3780(7)
	lfs 0,20(11)
	fctiwz 12,0
	stfd 12,2056(1)
.L276:
	lwz 6,2060(1)
	crxor 6,6,6
	bl safe_cprintf
	b .L253
.L265:
	lis 0,0xcccc
	addi 9,6,1
	ori 0,0,52429
	lis 11,level+4@ha
	mulhwu 0,9,0
	srwi 0,0,3
	mulli 0,0,10
	subf 9,0,9
	stw 9,3824(7)
	lfs 0,level+4@l(11)
	slwi 9,9,2
	stfsx 0,10,9
.L262:
	lis 9,.LC44@ha
	lis 11,dedicated@ha
	la 9,.LC44@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L266
	lis 5,.LC43@ha
	li 3,0
	la 5,.LC43@l(5)
	li 4,3
	addi 6,1,8
	crxor 6,6,6
	bl safe_cprintf
.L266:
	lis 9,game@ha
	li 31,1
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,31,0
	bc 12,1,.L253
	cmpwi 4,30,0
	mr 25,9
	lis 26,g_edicts@ha
	lis 27,.LC43@ha
	li 30,952
.L270:
	lwz 0,g_edicts@l(26)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L269
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L269
	bc 12,18,.L273
	mr 3,28
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L269
.L273:
	mr 3,29
	li 4,3
	la 5,.LC43@l(27)
	addi 6,1,8
	crxor 6,6,6
	bl safe_cprintf
.L269:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,952
	cmpw 0,31,0
	bc 4,1,.L270
.L253:
	lwz 0,2100(1)
	lwz 12,2064(1)
	mtlr 0
	lmw 25,2068(1)
	mtcrf 8,12
	la 1,2096(1)
	blr
.Lfe8:
	.size	 Cmd_Say_f,.Lfe8-Cmd_Say_f
	.section	".rodata"
	.align 2
.LC47:
	.string	"%02d:%02d %4d %3d %s%s\n"
	.align 2
.LC48:
	.string	" (spectator)"
	.align 2
.LC49:
	.string	""
	.align 2
.LC50:
	.string	"And more...\n"
	.align 2
.LC51:
	.long 0x0
	.align 3
.LC52:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_PlayerList_f
	.type	 Cmd_PlayerList_f,@function
Cmd_PlayerList_f:
	stwu 1,-1568(1)
	mflr 0
	stmw 21,1524(1)
	stw 0,1572(1)
	lis 9,maxclients@ha
	li 0,0
	lwz 11,maxclients@l(9)
	lis 10,g_edicts@ha
	mr 28,3
	lis 9,.LC51@ha
	stb 0,96(1)
	li 27,0
	la 9,.LC51@l(9)
	lfs 0,20(11)
	lis 22,maxclients@ha
	lfs 13,0(9)
	addi 31,1,96
	lis 21,.LC43@ha
	lwz 9,g_edicts@l(10)
	fcmpu 0,13,0
	addi 30,9,952
	bc 4,0,.L279
	lis 9,.LC48@ha
	lis 11,.LC49@ha
	la 23,.LC48@l(9)
	la 24,.LC49@l(11)
	lis 25,level@ha
	lis 26,0x4330
.L281:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L280
	lwz 10,84(30)
	lis 11,0x1b4e
	lis 8,0x6666
	lwz 9,level@l(25)
	ori 11,11,33205
	ori 8,8,26215
	lwz 0,3444(10)
	addi 29,10,700
	lwz 7,3492(10)
	subf 9,0,9
	lwz 3,184(10)
	mulhw 11,9,11
	lwz 4,3448(10)
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
	bc 12,2,.L283
	stw 23,8(1)
	b .L284
.L283:
	stw 24,8(1)
.L284:
	mr 8,3
	mr 9,4
	lis 5,.LC47@ha
	mr 10,29
	addi 3,1,16
	la 5,.LC47@l(5)
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
	bc 4,1,.L285
	mr 3,31
	bl strlen
	lis 4,.LC50@ha
	add 3,31,3
	la 4,.LC50@l(4)
	crxor 6,6,6
	bl sprintf
	mr 3,28
	la 5,.LC43@l(21)
	mr 6,31
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L277
.L285:
	mr 3,31
	addi 4,1,16
	bl strcat
.L280:
	addi 27,27,1
	lwz 11,maxclients@l(22)
	xoris 0,27,0x8000
	lis 10,.LC52@ha
	stw 0,1516(1)
	la 10,.LC52@l(10)
	addi 30,30,952
	stw 26,1512(1)
	lfd 13,0(10)
	lfd 0,1512(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L281
.L279:
	lis 5,.LC43@ha
	mr 3,28
	la 5,.LC43@l(5)
	mr 6,31
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L277:
	lwz 0,1572(1)
	mtlr 0
	lmw 21,1524(1)
	la 1,1568(1)
	blr
.Lfe9:
	.size	 Cmd_PlayerList_f,.Lfe9-Cmd_PlayerList_f
	.section	".rodata"
	.align 2
.LC53:
	.string	"players"
	.align 2
.LC54:
	.string	"say"
	.align 2
.LC55:
	.string	"say_team"
	.align 2
.LC56:
	.string	"score"
	.align 2
.LC57:
	.string	"help"
	.align 2
.LC58:
	.string	"use"
	.align 2
.LC59:
	.string	"drop"
	.align 2
.LC60:
	.string	"give"
	.align 2
.LC61:
	.string	"god"
	.align 2
.LC62:
	.string	"notarget"
	.align 2
.LC63:
	.string	"noclip"
	.align 2
.LC64:
	.string	"inven"
	.align 2
.LC65:
	.string	"invnext"
	.align 2
.LC66:
	.string	"invprev"
	.align 2
.LC67:
	.string	"invnextw"
	.align 2
.LC68:
	.string	"invprevw"
	.align 2
.LC69:
	.string	"invnextp"
	.align 2
.LC70:
	.string	"invprevp"
	.align 2
.LC71:
	.string	"invuse"
	.align 2
.LC72:
	.string	"invdrop"
	.align 2
.LC73:
	.string	"weapprev"
	.align 2
.LC74:
	.string	"weapnext"
	.align 2
.LC75:
	.string	"weaplast"
	.align 2
.LC76:
	.string	"kill"
	.align 2
.LC77:
	.string	"putaway"
	.align 2
.LC78:
	.string	"wave"
	.align 2
.LC79:
	.string	"team"
	.align 2
.LC80:
	.string	"id"
	.align 2
.LC81:
	.string	"playerlist"
	.align 2
.LC82:
	.long 0x0
	.align 2
.LC83:
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
	bc 12,2,.L287
	bl ACECM_Commands
	cmpwi 0,3,0
	bc 4,2,.L287
	lis 9,gi@ha
	li 3,0
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC53@ha
	la 4,.LC53@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L290
	mr 3,29
	bl Cmd_Players_f
	b .L287
.L290:
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L291
	mr 3,29
	li 4,0
	b .L486
.L291:
	lis 4,.LC55@ha
	mr 3,31
	la 4,.LC55@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L292
	mr 3,29
	li 4,1
.L486:
	li 5,0
	bl Cmd_Say_f
	b .L287
.L292:
	lis 4,.LC56@ha
	mr 3,31
	la 4,.LC56@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L293
	mr 3,29
	bl Cmd_Score_f
	b .L287
.L293:
	lis 4,.LC57@ha
	mr 3,31
	la 4,.LC57@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L294
	mr 3,29
	bl Cmd_Help_f
	b .L287
.L294:
	lis 8,.LC82@ha
	lis 9,level+200@ha
	la 8,.LC82@l(8)
	lfs 0,level+200@l(9)
	lfs 31,0(8)
	fcmpu 0,0,31
	bc 4,2,.L287
	lis 4,.LC58@ha
	mr 3,31
	la 4,.LC58@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L296
	lwz 0,164(30)
	mtlr 0
	blrl
	mr 31,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L297
	lis 5,.LC20@ha
	mr 3,29
	la 5,.LC20@l(5)
	b .L487
.L297:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L299
	lis 5,.LC21@ha
	mr 3,29
	la 5,.LC21@l(5)
	b .L488
.L299:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L300
	lis 5,.LC22@ha
	mr 3,29
	la 5,.LC22@l(5)
.L487:
	mr 6,31
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L287
.L300:
	mr 3,29
	mtlr 10
	blrl
	b .L287
.L296:
	lis 4,.LC59@ha
	mr 3,31
	la 4,.LC59@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L302
	mr 3,29
	bl Cmd_Drop_f
	b .L287
.L302:
	lis 4,.LC60@ha
	mr 3,31
	la 4,.LC60@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L304
	mr 3,29
	bl Cmd_Give_f
	b .L287
.L304:
	lis 4,.LC61@ha
	mr 3,31
	la 4,.LC61@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L306
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L307
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L307
	lis 5,.LC1@ha
	mr 3,29
	la 5,.LC1@l(5)
	b .L488
.L307:
	lwz 0,264(29)
	xori 0,0,16
	andi. 8,0,16
	stw 0,264(29)
	bc 4,2,.L309
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L322
.L309:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
	b .L322
.L306:
	lis 4,.LC62@ha
	mr 3,31
	la 4,.LC62@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L312
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L313
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L313
	lis 5,.LC1@ha
	mr 3,29
	la 5,.LC1@l(5)
	b .L488
.L313:
	lwz 0,264(29)
	xori 0,0,32
	andi. 8,0,32
	stw 0,264(29)
	bc 4,2,.L315
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L322
.L315:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
	b .L322
.L312:
	lis 4,.LC63@ha
	mr 3,31
	la 4,.LC63@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L318
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L319
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L319
	lis 5,.LC1@ha
	mr 3,29
	la 5,.LC1@l(5)
	b .L488
.L319:
	lwz 0,260(29)
	cmpwi 0,0,1
	bc 4,2,.L321
	li 0,4
	lis 9,.LC18@ha
	stw 0,260(29)
	la 5,.LC18@l(9)
	b .L322
.L321:
	li 0,1
	lis 9,.LC19@ha
	stw 0,260(29)
	la 5,.LC19@l(9)
.L322:
	mr 3,29
.L488:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L287
.L318:
	lis 4,.LC64@ha
	mr 3,31
	la 4,.LC64@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L324
	lwz 31,84(29)
	stw 3,3540(31)
	stw 3,3524(31)
	lwz 9,84(29)
	lwz 9,3532(9)
	cmpwi 0,9,0
	bc 12,2,.L325
	mr 3,29
	bl PMenu_Close
	b .L463
.L325:
	lwz 0,3536(31)
	cmpwi 0,0,0
	bc 12,2,.L327
	stw 9,3536(31)
	b .L287
.L327:
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L328
	lwz 0,3452(31)
	cmpwi 0,0,0
	bc 4,2,.L328
	mr 3,29
	bl CTFOpenJoinMenu
	b .L287
.L328:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3536(31)
	li 3,5
	lwz 0,100(9)
	addi 30,31,1760
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L331:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,30
	bc 4,1,.L331
	lis 9,gi+92@ha
	mr 3,29
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L287
.L324:
	lis 4,.LC65@ha
	mr 3,31
	la 4,.LC65@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L335
	lwz 8,84(29)
	lwz 0,3532(8)
	cmpwi 0,0,0
	bc 4,2,.L489
	lwz 0,3856(8)
	cmpwi 0,0,0
	bc 4,2,.L490
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L485:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L344
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L344
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L478
.L344:
	addi 7,7,1
	bdnz .L485
	b .L491
.L335:
	lis 4,.LC66@ha
	mr 3,31
	la 4,.LC66@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L349
	lwz 7,84(29)
	lwz 0,3532(7)
	cmpwi 0,0,0
	bc 4,2,.L492
	lwz 0,3856(7)
	cmpwi 0,0,0
	bc 4,2,.L493
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L484:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L358
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L358
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L479
.L358:
	addi 11,11,-1
	bdnz .L484
	b .L494
.L349:
	lis 4,.LC67@ha
	mr 3,31
	la 4,.LC67@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L363
	lwz 8,84(29)
	lwz 0,3532(8)
	cmpwi 0,0,0
	bc 4,2,.L489
	lwz 0,3856(8)
	cmpwi 0,0,0
	bc 4,2,.L490
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L483:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L372
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L372
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L478
.L372:
	addi 7,7,1
	bdnz .L483
	b .L491
.L363:
	lis 4,.LC68@ha
	mr 3,31
	la 4,.LC68@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L377
	lwz 7,84(29)
	lwz 0,3532(7)
	cmpwi 0,0,0
	bc 4,2,.L492
	lwz 0,3856(7)
	cmpwi 0,0,0
	bc 4,2,.L493
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L482:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L386
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L386
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L479
.L386:
	addi 11,11,-1
	bdnz .L482
	b .L494
.L377:
	lis 4,.LC69@ha
	mr 3,31
	la 4,.LC69@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L391
	lwz 8,84(29)
	lwz 0,3532(8)
	cmpwi 0,0,0
	bc 12,2,.L392
.L489:
	mr 3,29
	bl PMenu_Next
	b .L287
.L392:
	lwz 0,3856(8)
	cmpwi 0,0,0
	bc 12,2,.L394
.L490:
	mr 3,29
	bl ChaseNext
	b .L287
.L394:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L481:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L400
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L400
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L478
.L400:
	addi 7,7,1
	bdnz .L481
.L491:
	li 0,-1
	stw 0,736(8)
	b .L287
.L391:
	lis 4,.LC70@ha
	mr 3,31
	la 4,.LC70@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L405
	lwz 7,84(29)
	lwz 0,3532(7)
	cmpwi 0,0,0
	bc 12,2,.L406
.L492:
	mr 3,29
	bl PMenu_Prev
	b .L287
.L406:
	lwz 0,3856(7)
	cmpwi 0,0,0
	bc 12,2,.L408
.L493:
	mr 3,29
	bl ChasePrev
	b .L287
.L408:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L480:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L414
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L414
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L479
.L414:
	addi 11,11,-1
	bdnz .L480
.L494:
	li 0,-1
	stw 0,736(7)
	b .L287
.L405:
	lis 4,.LC71@ha
	mr 3,31
	la 4,.LC71@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L419
	mr 3,29
	bl Cmd_InvUse_f
	b .L287
.L419:
	lis 4,.LC72@ha
	mr 3,31
	la 4,.LC72@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L421
	mr 3,29
	bl Cmd_InvDrop_f
	b .L287
.L421:
	lis 4,.LC73@ha
	mr 3,31
	la 4,.LC73@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L423
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L287
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,28,740
	mullw 9,9,0
	srawi 27,9,2
.L428:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L430
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L430
	lwz 0,56(31)
	andi. 8,0,1
	bc 12,2,.L430
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L287
.L430:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L428
	b .L287
.L423:
	lis 4,.LC74@ha
	mr 3,31
	la 4,.LC74@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L436
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L287
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 27,1
	subf 9,9,11
	addi 26,28,740
	mullw 9,9,0
	srawi 9,9,2
	addi 30,9,255
.L441:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L443
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L443
	lwz 0,56(31)
	andi. 8,0,1
	bc 12,2,.L443
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L287
.L443:
	addi 27,27,1
	addi 30,30,-1
	cmpwi 0,27,256
	bc 4,1,.L441
	b .L287
.L436:
	lis 4,.LC75@ha
	mr 3,31
	la 4,.LC75@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L449
	lwz 10,84(29)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L287
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L287
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
	bc 12,2,.L287
	mulli 0,10,76
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L287
	lwz 0,56(4)
	andi. 8,0,1
	bc 12,2,.L287
	mr 3,29
	mtlr 9
	blrl
	b .L287
.L449:
	lis 4,.LC76@ha
	mr 3,31
	la 4,.LC76@l(4)
	bl Q_stricmp
	mr. 10,3
	bc 4,2,.L457
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 12,2,.L287
	lwz 11,84(29)
	lis 9,level+4@ha
	lis 8,.LC83@ha
	lfs 0,level+4@l(9)
	la 8,.LC83@l(8)
	lfs 13,3828(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L287
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
	b .L287
.L457:
	lis 4,.LC77@ha
	mr 3,31
	la 4,.LC77@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L462
	lwz 9,84(29)
	stw 3,3524(9)
	lwz 11,84(29)
	stw 3,3540(11)
	lwz 9,84(29)
	stw 3,3536(9)
	lwz 11,84(29)
	lwz 0,3532(11)
	cmpwi 0,0,0
	bc 12,2,.L463
	mr 3,29
	bl PMenu_Close
.L463:
	lwz 9,84(29)
	li 0,1
	stw 0,3860(9)
	b .L287
.L462:
	lis 4,.LC78@ha
	mr 3,31
	la 4,.LC78@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L466
	mr 3,29
	bl Cmd_Wave_f
	b .L287
.L466:
	lis 4,.LC79@ha
	mr 3,31
	la 4,.LC79@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L468
	mr 3,29
	bl CTFTeam_f
	b .L287
.L468:
	lis 4,.LC80@ha
	mr 3,31
	la 4,.LC80@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L470
	mr 3,29
	bl CTFID_f
	b .L287
.L470:
	lis 4,.LC81@ha
	mr 3,31
	la 4,.LC81@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L472
	mr 3,29
	bl Cmd_PlayerList_f
	b .L287
.L478:
	stw 11,736(8)
	b .L287
.L479:
	stw 8,736(7)
	b .L287
.L472:
	mr 3,29
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L287:
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
	bc 4,2,.L50
	lwz 0,3532(8)
	cmpwi 0,0,0
	bc 12,2,.L52
	bl PMenu_Next
	b .L50
.L52:
	lwz 0,3856(8)
	cmpwi 0,0,0
	bc 12,2,.L54
	bl ChaseNext
	b .L50
.L495:
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
.L496:
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
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L60
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L495
.L60:
	addi 7,7,1
	bdnz .L496
	li 0,-1
	stw 0,736(8)
.L50:
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
	bc 12,2,.L498
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
	bc 12,2,.L498
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L9
	addi 3,3,1
	b .L497
.L9:
	stb 30,0(3)
.L498:
	mr 3,31
.L497:
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
	lwz 0,3532(8)
	cmpwi 0,0,0
	bc 12,2,.L27
	bl PMenu_Next
	b .L26
.L27:
	lwz 0,3856(8)
	cmpwi 0,0,0
	bc 12,2,.L28
	bl ChaseNext
	b .L26
.L499:
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
.L500:
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
	mulli 0,11,76
	add 10,0,3
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L32
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L499
.L32:
	addi 7,7,1
	bdnz .L500
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
	lwz 0,3532(7)
	cmpwi 0,0,0
	bc 12,2,.L39
	bl PMenu_Prev
	b .L38
.L39:
	lwz 0,3856(7)
	cmpwi 0,0,0
	bc 12,2,.L40
	bl ChasePrev
	b .L38
.L501:
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
.L502:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L44
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L44
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L501
.L44:
	addi 11,11,-1
	bdnz .L502
	li 0,-1
	stw 0,736(7)
.L38:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 SelectPrevItem,.Lfe14-SelectPrevItem
	.section	".rodata"
	.align 2
.LC84:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC84@ha
	lis 9,deathmatch@ha
	la 11,.LC84@l(11)
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
	lis 5,.LC1@ha
	li 4,2
	la 5,.LC1@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L117
.L118:
	lwz 0,264(3)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(3)
	bc 4,2,.L119
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L120
.L119:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
.L120:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L117:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 Cmd_God_f,.Lfe15-Cmd_God_f
	.section	".rodata"
	.align 2
.LC85:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC85@ha
	lis 9,deathmatch@ha
	la 11,.LC85@l(11)
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
	lis 5,.LC1@ha
	li 4,2
	la 5,.LC1@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L121
.L122:
	lwz 0,264(3)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(3)
	bc 4,2,.L123
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L124
.L123:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
.L124:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L121:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 Cmd_Notarget_f,.Lfe16-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC86:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC86@ha
	lis 9,deathmatch@ha
	la 11,.LC86@l(11)
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
	lis 5,.LC1@ha
	li 4,2
	la 5,.LC1@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L125
.L126:
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 4,2,.L127
	li 0,4
	lis 9,.LC18@ha
	stw 0,260(3)
	la 5,.LC18@l(9)
	b .L128
.L127:
	li 0,1
	lis 9,.LC19@ha
	stw 0,260(3)
	la 5,.LC19@l(9)
.L128:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
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
	bc 4,2,.L130
	lis 5,.LC20@ha
	mr 3,31
	la 5,.LC20@l(5)
	b .L503
.L130:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L131
	lis 5,.LC21@ha
	mr 3,31
	la 5,.LC21@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L129
.L131:
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
	bc 4,2,.L132
	lis 5,.LC22@ha
	mr 3,31
	la 5,.LC22@l(5)
.L503:
	mr 6,30
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L129
.L132:
	mr 3,31
	mtlr 10
	blrl
.L129:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe18:
	.size	 Cmd_Use_f,.Lfe18-Cmd_Use_f
	.section	".rodata"
	.align 2
.LC87:
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
	stw 0,3540(31)
	stw 0,3524(31)
	lwz 9,84(30)
	lwz 9,3532(9)
	cmpwi 0,9,0
	bc 12,2,.L140
	bl PMenu_Close
	lwz 9,84(30)
	li 0,1
	stw 0,3860(9)
	b .L139
.L140:
	lwz 0,3536(31)
	cmpwi 0,0,0
	bc 12,2,.L141
	stw 9,3536(31)
	b .L139
.L141:
	lis 9,.LC87@ha
	lis 11,ctf@ha
	la 9,.LC87@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L142
	lwz 0,3452(31)
	cmpwi 0,0,0
	bc 4,2,.L142
	mr 3,30
	bl CTFOpenJoinMenu
	b .L139
.L142:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3536(31)
	li 3,5
	lwz 0,100(9)
	addi 29,31,1760
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L146:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,29
	bc 4,1,.L146
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L139:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 Cmd_Inven_f,.Lfe19-Cmd_Inven_f
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
	bc 12,2,.L169
	lwz 9,1792(4)
	cmpwi 0,9,0
	bc 12,2,.L169
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L169:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe20:
	.size	 Cmd_LastWeap_f,.Lfe20-Cmd_LastWeap_f
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
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,29,740
	mullw 9,9,0
	srawi 27,9,2
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
	mulli 0,11,76
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
.Lfe21:
	.size	 Cmd_WeapPrev_f,.Lfe21-Cmd_WeapPrev_f
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
	mulli 0,11,76
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
.Lfe22:
	.size	 Cmd_WeapNext_f,.Lfe22-Cmd_WeapNext_f
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
	bc 12,2,.L194
	mulli 0,10,76
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
.Lfe23:
	.size	 Cmd_WeapLast_f,.Lfe23-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC88:
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
	bc 12,2,.L220
	lwz 11,84(10)
	lis 9,level+4@ha
	lis 8,.LC88@ha
	lfs 0,level+4@l(9)
	la 8,.LC88@l(8)
	lfs 13,3828(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L220
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
.L220:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 Cmd_Kill_f,.Lfe24-Cmd_Kill_f
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
	stw 0,3524(9)
	lwz 11,84(31)
	stw 0,3540(11)
	lwz 9,84(31)
	stw 0,3536(9)
	lwz 11,84(31)
	lwz 0,3532(11)
	cmpwi 0,0,0
	bc 12,2,.L224
	bl PMenu_Close
.L224:
	lwz 9,84(31)
	li 0,1
	stw 0,3860(9)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 Cmd_PutAway_f,.Lfe25-Cmd_PutAway_f
	.align 2
	.globl PlayerSort
	.type	 PlayerSort,@function
PlayerSort:
	lwz 9,0(3)
	lis 11,game+1028@ha
	lwz 3,0(4)
	lwz 0,game+1028@l(11)
	mulli 9,9,3864
	mulli 11,3,3864
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
.Lfe26:
	.size	 PlayerSort,.Lfe26-PlayerSort
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
