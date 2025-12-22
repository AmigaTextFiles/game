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
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	b .L116
.L65:
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
	cmpwi 4,30,0
	bc 12,18,.L64
.L68:
	bc 4,18,.L74
	lis 4,.LC4@ha
	mr 3,26
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
	addi 11,11,744
	lwzx 9,11,10
	addi 9,9,1
	stwx 9,11,10
.L77:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 8,8,72
	cmpw 0,29,0
	bc 12,0,.L78
.L76:
	bc 12,18,.L64
.L73:
	bc 4,18,.L84
	lis 4,.LC5@ha
	mr 3,26
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
	mr 30,11
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
	lwz 0,1556(30)
	addi 29,29,1
	addi 28,28,72
	cmpw 0,29,0
	bc 12,0,.L88
.L86:
	bc 12,18,.L64
.L83:
	bc 4,18,.L94
	lis 4,.LC6@ha
	mr 3,26
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L93
.L94:
	lis 3,.LC7@ha
	lis 28,0x38e3
	la 3,.LC7@l(3)
	ori 28,28,36409
	bl FindItem
	li 27,0
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC8@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 9,9,744
	mullw 0,0,28
	la 3,.LC8@l(11)
	srawi 0,0,3
	slwi 0,0,2
	stwx 27,9,0
	bl FindItem
	subf 0,29,3
	lwz 9,84(31)
	mullw 0,0,28
	lis 3,.LC9@ha
	addi 9,9,744
	la 3,.LC9@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 27,9,0
	bl FindItem
	mr 27,3
	lwz 9,84(31)
	subf 29,29,27
	lwz 11,60(27)
	mullw 29,29,28
	addi 9,9,744
	lwz 0,4(11)
	srawi 29,29,3
	slwi 29,29,2
	stwx 0,9,29
	bc 12,18,.L64
.L93:
	bc 4,18,.L97
	lis 4,.LC10@ha
	mr 3,26
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
	addi 9,9,744
	stwx 8,9,10
.L103:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 11,11,72
	cmpw 0,29,0
	bc 12,0,.L104
	b .L64
.L100:
	mr 3,26
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
	lis 5,.LC11@ha
	mr 3,31
	la 5,.LC11@l(5)
	b .L116
.L108:
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 4,2,.L110
	lis 9,gi+8@ha
	lis 5,.LC12@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC12@l(5)
.L116:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L64
.L110:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,56(27)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,27
	andi. 10,11,2
	mullw 9,9,0
	srawi 28,9,3
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
	addi 9,9,744
	stwx 3,9,0
	b .L64
.L112:
	lwz 9,84(31)
	slwi 10,28,2
	lwz 11,48(27)
	addi 9,9,744
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
	.string	"grapple"
	.align 2
.LC21:
	.string	"To use the hook, bind a key to +hook\nFor example, type this at the console:\n         bind mouse2 +hook\nto bind the hook to your right mouse button\n"
	.align 2
.LC22:
	.string	"unknown item: %s\n"
	.align 2
.LC23:
	.string	"Item is not usable.\n"
	.align 2
.LC24:
	.string	"Out of item: %s\n"
	.section	".text"
	.align 2
	.globl Cmd_Use_f
	.type	 Cmd_Use_f,@function
Cmd_Use_f:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,gi@ha
	mr 31,3
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 11,sv_expflags@ha
	lwz 10,sv_expflags@l(11)
	mr 30,3
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	andi. 0,9,32
	bc 12,2,.L130
	lis 4,.LC20@ha
	la 4,.LC20@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L130
	lwz 0,8(29)
	lis 5,.LC21@ha
	mr 3,31
	la 5,.LC21@l(5)
	b .L134
.L130:
	mr 3,30
	bl FindItem
	mr. 4,3
	bc 4,2,.L131
	lis 9,gi+8@ha
	lis 5,.LC22@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC22@l(5)
	b .L135
.L131:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L132
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC23@l(5)
.L134:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L129
.L132:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,4
	addi 11,11,744
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L133
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC24@l(5)
.L135:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L129
.L133:
	mr 3,31
	mtlr 10
	blrl
.L129:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 Cmd_Use_f,.Lfe3-Cmd_Use_f
	.section	".rodata"
	.align 2
.LC25:
	.string	"Item is not dropable.\n"
	.align 2
.LC26:
	.string	"Can't drop ammo in infinite ammo mode\n"
	.section	".text"
	.align 2
	.globl Cmd_Drop_f
	.type	 Cmd_Drop_f,@function
Cmd_Drop_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 29,3
	la 28,gi@l(9)
	lwz 9,164(28)
	mtlr 9
	blrl
	mr 30,3
	bl FindItem
	mr. 31,3
	bc 4,2,.L137
	lwz 0,8(28)
	lis 5,.LC22@ha
	mr 3,29
	la 5,.LC22@l(5)
	b .L141
.L137:
	lwz 0,12(31)
	cmpwi 0,0,0
	bc 4,2,.L138
	lwz 0,8(28)
	lis 5,.LC25@ha
	mr 3,29
	la 5,.LC25@l(5)
	b .L142
.L138:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,31
	addi 11,11,744
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L139
	lwz 0,8(28)
	lis 5,.LC24@ha
	mr 3,29
	la 5,.LC24@l(5)
.L141:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L136
.L139:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8192
	bc 12,2,.L140
	lwz 3,0(31)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L140
	lwz 0,8(28)
	lis 5,.LC26@ha
	mr 3,29
	la 5,.LC26@l(5)
.L142:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L136
.L140:
	lwz 0,12(31)
	mr 3,29
	mr 4,31
	mtlr 0
	blrl
.L136:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 Cmd_Drop_f,.Lfe4-Cmd_Drop_f
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
	lwz 0,3736(8)
	cmpwi 0,0,0
	bc 12,2,.L152
	bl PMenu_Select
	b .L151
.L152:
	lwz 11,740(8)
	addi 10,8,744
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L154
	lwz 0,3988(8)
	cmpwi 0,0,0
	bc 12,2,.L157
	mr 3,31
	bl ChaseNext
	b .L154
.L169:
	stw 11,740(8)
	b .L154
.L157:
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
	mulli 0,11,72
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
	stw 0,740(8)
.L154:
	lwz 9,84(31)
	lwz 0,740(9)
	cmpwi 0,0,-1
	bc 4,2,.L167
	lis 9,gi+8@ha
	lis 5,.LC27@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC27@l(5)
	b .L171
.L167:
	mulli 0,0,72
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
	b .L151
.L168:
	mr 3,31
	mtlr 0
	blrl
.L151:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_InvUse_f,.Lfe5-Cmd_InvUse_f
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
	lwz 11,740(8)
	addi 10,8,744
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L205
	lwz 0,3736(8)
	cmpwi 0,0,0
	bc 12,2,.L206
	bl PMenu_Next
	b .L205
.L206:
	lwz 0,3988(8)
	cmpwi 0,0,0
	bc 12,2,.L208
	mr 3,31
	bl ChaseNext
	b .L205
.L220:
	stw 11,740(8)
	b .L205
.L208:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L221:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L214
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L214
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L220
.L214:
	addi 7,7,1
	bdnz .L221
	li 0,-1
	stw 0,740(8)
.L205:
	lwz 9,84(31)
	lwz 0,740(9)
	cmpwi 0,0,-1
	bc 4,2,.L218
	lis 9,gi+8@ha
	lis 5,.LC28@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC28@l(5)
	b .L222
.L218:
	mulli 0,0,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L219
	lis 9,gi+8@ha
	lis 5,.LC25@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC25@l(5)
.L222:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L203
.L219:
	mr 3,31
	mtlr 0
	blrl
.L203:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 Cmd_InvDrop_f,.Lfe6-Cmd_InvDrop_f
	.section	".rodata"
	.align 2
.LC29:
	.string	"Cannot commit suicide with no frags\n"
	.align 2
.LC30:
	.string	"menu_main;\n"
	.align 2
.LC31:
	.string	"%3i %s\n"
	.align 2
.LC32:
	.string	"...\n"
	.align 2
.LC33:
	.string	"%s\n%i players\n"
	.align 2
.LC34:
	.long 0x0
	.align 3
.LC35:
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
	lis 11,.LC34@ha
	lis 9,maxclients@ha
	la 11,.LC34@l(11)
	mr 23,3
	lfs 13,0(11)
	li 27,0
	li 31,0
	lwz 11,maxclients@l(9)
	addi 29,1,1352
	addi 30,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L238
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L240:
	lwz 0,0(11)
	addi 11,11,4596
	cmpwi 0,0,0
	bc 12,2,.L239
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L239:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L240
.L238:
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
	bc 4,0,.L244
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC31@ha
	lis 25,.LC32@ha
.L246:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC31@l(26)
	addi 28,28,4
	mulli 7,7,4596
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
	bc 4,1,.L247
	la 4,.LC32@l(25)
	mr 3,30
	bl strcat
	b .L244
.L247:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L246
.L244:
	lis 9,gi+8@ha
	lis 5,.LC33@ha
	lwz 0,gi+8@l(9)
	mr 3,23
	la 5,.LC33@l(5)
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
.LC36:
	.string	"(%s): "
	.align 2
.LC37:
	.string	"%s: "
	.align 2
.LC38:
	.string	" "
	.align 2
.LC39:
	.string	"\n"
	.align 2
.LC40:
	.string	"%s"
	.align 2
.LC41:
	.string	"TEAM "
	.align 2
.LC42:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Say_f
	.type	 Cmd_Say_f,@function
Cmd_Say_f:
	stwu 1,-2112(1)
	mflr 0
	mfcr 12
	stmw 23,2076(1)
	stw 0,2116(1)
	stw 12,2072(1)
	lis 9,gi+156@ha
	mr 28,3
	lwz 0,gi+156@l(9)
	mr 30,4
	mr 31,5
	mtlr 0
	blrl
	cmpwi 0,3,1
	bc 12,1,.L251
	cmpwi 0,31,0
	bc 12,2,.L250
.L251:
	mr 3,28
	bl floodProt
	cmpwi 0,3,0
	bc 4,2,.L250
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,2064(1)
	lwz 9,2068(1)
	rlwinm 9,9,0,24,25
	neg 9,9
	srawi 9,9,31
	and. 27,30,9
	bc 12,2,.L254
	lwz 6,84(28)
	lis 5,.LC36@ha
	addi 3,1,8
	la 5,.LC36@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L255
.L254:
	lwz 6,84(28)
	lis 5,.LC37@ha
	addi 3,1,8
	la 5,.LC37@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L255:
	cmpwi 0,31,0
	bc 12,2,.L256
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC38@ha
	addi 3,1,8
	la 4,.LC38@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L257
.L256:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L258
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
.L258:
	mr 4,29
	addi 3,1,8
	bl strcat
.L257:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L259
	li 0,0
	stb 0,158(1)
.L259:
	lis 4,.LC39@ha
	addi 3,1,8
	la 4,.LC39@l(4)
	bl strcat
	lis 9,.LC42@ha
	lis 11,dedicated@ha
	la 9,.LC42@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L260
	lis 9,gi+8@ha
	lis 5,.LC40@ha
	lwz 0,gi+8@l(9)
	la 5,.LC40@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L260:
	lis 9,game@ha
	li 30,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,30,0
	bc 12,1,.L250
	cmpwi 4,27,0
	lis 9,gi@ha
	la 31,gi@l(9)
	mr 23,11
	lis 24,g_edicts@ha
	lis 26,.LC40@ha
	li 27,916
	lis 25,.LC41@ha
.L264:
	lwz 0,g_edicts@l(24)
	add 29,0,27
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L263
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L263
	bc 12,18,.L267
	mr 3,28
	mr 4,29
	bl onSameTeam
	cmpwi 0,3,0
	bc 12,2,.L263
	b .L273
.L267:
	bl teamplayEnabled
	cmpwi 0,3,0
	bc 12,2,.L270
	mr 3,28
	mr 4,29
	bl onSameTeam
	cmpwi 0,3,0
	bc 12,2,.L270
	lwz 9,8(31)
	mr 3,29
	li 4,2
	la 5,.LC41@l(25)
	mtlr 9
	crxor 6,6,6
	blrl
.L273:
	lwz 9,8(31)
	mr 3,29
	li 4,3
	la 5,.LC40@l(26)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
	b .L263
.L270:
	lwz 9,8(31)
	mr 3,29
	li 4,3
	la 5,.LC40@l(26)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L263:
	lwz 0,1544(23)
	addi 30,30,1
	addi 27,27,916
	cmpw 0,30,0
	bc 4,1,.L264
.L250:
	lwz 0,2116(1)
	lwz 12,2072(1)
	mtlr 0
	lmw 23,2076(1)
	mtcrf 8,12
	la 1,2112(1)
	blr
.Lfe8:
	.size	 Cmd_Say_f,.Lfe8-Cmd_Say_f
	.section	".rodata"
	.align 2
.LC43:
	.string	" (spectator)"
	.align 2
.LC44:
	.string	""
	.align 2
.LC45:
	.string	"%02d:%02d %4d %3d %s%s\n"
	.align 2
.LC46:
	.string	"And more...\n"
	.align 2
.LC47:
	.long 0x0
	.align 3
.LC48:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_PlayerList_f
	.type	 Cmd_PlayerList_f,@function
Cmd_PlayerList_f:
	stwu 1,-1552(1)
	mflr 0
	stmw 22,1512(1)
	stw 0,1556(1)
	lis 9,maxclients@ha
	li 0,0
	lwz 11,maxclients@l(9)
	lis 10,g_edicts@ha
	mr 27,3
	lis 9,.LC47@ha
	stb 0,96(1)
	li 28,0
	la 9,.LC47@l(9)
	lfs 0,20(11)
	lis 24,maxclients@ha
	lfs 13,0(9)
	addi 30,1,96
	lis 23,gi@ha
	lwz 9,g_edicts@l(10)
	lis 22,.LC40@ha
	fcmpu 0,13,0
	addi 31,9,916
	bc 4,0,.L276
	lis 25,level@ha
	lis 26,0x4330
.L278:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L277
	mr 3,31
	bl IsObserver
	cmpwi 0,3,0
	bc 12,2,.L280
	lis 9,.LC43@ha
	la 12,.LC43@l(9)
	b .L281
.L280:
	lis 9,.LC44@ha
	la 12,.LC44@l(9)
.L281:
	lwz 3,84(31)
	lis 6,0x1b4e
	lis 11,0x6666
	lwz 7,level@l(25)
	ori 6,6,33205
	ori 11,11,26215
	lwz 0,3428(3)
	addi 10,3,700
	lis 5,.LC45@ha
	lwz 8,184(3)
	la 5,.LC45@l(5)
	li 4,80
	subf 7,0,7
	lwz 9,3432(3)
	mulhw 6,7,6
	srawi 29,7,31
	addi 3,1,16
	stw 12,8(1)
	srawi 6,6,6
	subf 6,29,6
	mulli 0,6,600
	subf 7,0,7
	mulhw 11,7,11
	srawi 7,7,31
	srawi 11,11,2
	subf 7,7,11
	crxor 6,6,6
	bl Com_sprintf
	mr 3,30
	bl strlen
	mr 29,3
	addi 3,1,16
	bl strlen
	add 29,29,3
	cmplwi 0,29,1350
	bc 4,1,.L282
	mr 3,30
	bl strlen
	lis 4,.LC46@ha
	add 3,30,3
	la 4,.LC46@l(4)
	crxor 6,6,6
	bl sprintf
	la 9,gi@l(23)
	mr 3,27
	lwz 0,8(9)
	la 5,.LC40@l(22)
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L274
.L282:
	mr 3,30
	addi 4,1,16
	bl strcat
.L277:
	addi 28,28,1
	lwz 11,maxclients@l(24)
	xoris 0,28,0x8000
	lis 10,.LC48@ha
	stw 0,1508(1)
	la 10,.LC48@l(10)
	addi 31,31,916
	stw 26,1504(1)
	lfd 13,0(10)
	lfd 0,1504(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L278
.L276:
	lis 9,gi+8@ha
	lis 5,.LC40@ha
	lwz 0,gi+8@l(9)
	mr 3,27
	la 5,.LC40@l(5)
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L274:
	lwz 0,1556(1)
	mtlr 0
	lmw 22,1512(1)
	la 1,1552(1)
	blr
.Lfe9:
	.size	 Cmd_PlayerList_f,.Lfe9-Cmd_PlayerList_f
	.section	".rodata"
	.align 2
.LC49:
	.string	"You are at position (%d %d %d)\n"
	.align 2
.LC50:
	.string	"players"
	.align 2
.LC51:
	.string	"say"
	.align 2
.LC52:
	.string	"say_team"
	.align 2
.LC53:
	.string	"steam"
	.align 2
.LC54:
	.string	"score"
	.align 2
.LC55:
	.string	"help"
	.align 2
.LC56:
	.string	"ta"
	.align 2
.LC57:
	.string	"speech"
	.align 2
.LC58:
	.string	"play_team"
	.align 2
.LC59:
	.string	"teamaudio"
	.align 2
.LC60:
	.string	"sw"
	.align 2
.LC61:
	.string	"switchfire"
	.align 2
.LC62:
	.string	"use"
	.align 2
.LC63:
	.string	"drop"
	.align 2
.LC64:
	.string	"give"
	.align 2
.LC65:
	.string	"god"
	.align 2
.LC66:
	.string	"notarget"
	.align 2
.LC67:
	.string	"noclip"
	.align 2
.LC68:
	.string	"inven"
	.align 2
.LC69:
	.string	"invnext"
	.align 2
.LC70:
	.string	"invprev"
	.align 2
.LC71:
	.string	"invnextw"
	.align 2
.LC72:
	.string	"invprevw"
	.align 2
.LC73:
	.string	"invnextp"
	.align 2
.LC74:
	.string	"invprevp"
	.align 2
.LC75:
	.string	"invuse"
	.align 2
.LC76:
	.string	"invdrop"
	.align 2
.LC77:
	.string	"weapprev"
	.align 2
.LC78:
	.string	"weapnext"
	.align 2
.LC79:
	.string	"weaplast"
	.align 2
.LC80:
	.string	"kill"
	.align 2
.LC81:
	.string	"putaway"
	.align 2
.LC82:
	.string	"wave"
	.align 2
.LC83:
	.string	"playerlist"
	.align 2
.LC84:
	.string	"team"
	.align 2
.LC85:
	.string	"id"
	.align 2
.LC86:
	.string	"motd"
	.align 2
.LC87:
	.string	"flagdrop"
	.align 2
.LC88:
	.string	"settings"
	.align 2
.LC89:
	.string	"!"
	.align 2
.LC90:
	.string	"gteams"
	.align 2
.LC91:
	.string	"observer"
	.align 2
.LC92:
	.string	"observe"
	.align 2
.LC93:
	.string	"chase"
	.align 2
.LC94:
	.string	"camera"
	.align 2
.LC95:
	.string	"chasecam"
	.align 2
.LC96:
	.string	"showpos"
	.align 2
.LC97:
	.long 0x0
	.align 2
.LC98:
	.long 0x40a00000
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
	mr 29,3
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L285
	lis 9,gi@ha
	li 3,0
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC50@ha
	la 4,.LC50@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L287
	mr 3,29
	bl Cmd_Players_f
	b .L285
.L287:
	lis 4,.LC51@ha
	mr 3,31
	la 4,.LC51@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L288
	mr 3,29
	li 4,0
	li 5,0
	bl Cmd_Say_f
	b .L285
.L288:
	lis 4,.LC52@ha
	mr 3,31
	la 4,.LC52@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L290
	lis 4,.LC53@ha
	mr 3,31
	la 4,.LC53@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L289
.L290:
	lwz 0,164(30)
	mtlr 0
	blrl
	mr 4,3
	mr 3,29
	bl CTFSay_Team
	b .L285
.L289:
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L291
	mr 3,29
	bl Cmd_Score_f
	b .L285
.L291:
	lis 4,.LC55@ha
	mr 3,31
	la 4,.LC55@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L292
	mr 3,29
	bl Cmd_Help_f
	b .L285
.L292:
	lis 11,.LC97@ha
	lis 9,level+200@ha
	la 11,.LC97@l(11)
	lfs 0,level+200@l(9)
	lfs 31,0(11)
	fcmpu 0,0,31
	bc 4,2,.L285
	lis 4,.LC56@ha
	mr 3,31
	la 4,.LC56@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L295
	lis 4,.LC57@ha
	mr 3,31
	la 4,.LC57@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L295
	lis 4,.LC58@ha
	mr 3,31
	la 4,.LC58@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L295
	lis 4,.LC59@ha
	mr 3,31
	la 4,.LC59@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L294
.L295:
	mr 3,29
	bl Cmd_TeamAudio_f
	b .L285
.L294:
	lis 4,.LC60@ha
	mr 3,31
	la 4,.LC60@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L298
	lis 4,.LC61@ha
	mr 3,31
	la 4,.LC61@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L297
.L298:
	mr 3,29
	bl Cmd_SwitchFire_f
	b .L285
.L297:
	lis 4,.LC62@ha
	mr 3,31
	la 4,.LC62@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L300
	mr 3,29
	bl Cmd_Use_f
	b .L285
.L300:
	lis 4,.LC63@ha
	mr 3,31
	la 4,.LC63@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L302
	mr 3,29
	bl Cmd_Drop_f
	b .L285
.L302:
	lis 4,.LC64@ha
	mr 3,31
	la 4,.LC64@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L304
	mr 3,29
	bl Cmd_Give_f
	b .L285
.L304:
	lis 4,.LC65@ha
	mr 3,31
	la 4,.LC65@l(4)
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
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC1@l(5)
	b .L509
.L307:
	lwz 0,264(29)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(29)
	bc 4,2,.L309
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L310
.L309:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
.L310:
	lis 9,gi+8@ha
	mr 3,29
	lwz 0,gi+8@l(9)
	b .L509
.L306:
	lis 4,.LC66@ha
	mr 3,31
	la 4,.LC66@l(4)
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
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC1@l(5)
	b .L509
.L313:
	lwz 0,264(29)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(29)
	bc 4,2,.L315
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L316
.L315:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
.L316:
	lis 9,gi+8@ha
	mr 3,29
	lwz 0,gi+8@l(9)
	b .L509
.L312:
	lis 4,.LC67@ha
	mr 3,31
	la 4,.LC67@l(4)
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
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC1@l(5)
	b .L509
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
	lis 9,gi+8@ha
	mr 3,29
	lwz 0,gi+8@l(9)
	b .L509
.L318:
	lis 4,.LC68@ha
	mr 3,31
	la 4,.LC68@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L324
	lwz 31,84(29)
	stw 3,3744(31)
	stw 3,3728(31)
	lwz 9,84(29)
	lwz 9,3736(9)
	cmpwi 0,9,0
	bc 4,2,.L510
	lwz 0,3740(31)
	cmpwi 0,0,0
	bc 12,2,.L327
	stw 9,3740(31)
	mr 3,29
	bl OverlayUpdate
	b .L285
.L327:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3740(31)
	li 3,5
	lwz 0,100(9)
	addi 30,31,1764
	mr 28,9
	addi 31,31,744
	mtlr 0
	blrl
.L330:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,30
	bc 4,1,.L330
	lis 9,gi+92@ha
	mr 3,29
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L285
.L324:
	lis 4,.LC69@ha
	mr 3,31
	la 4,.LC69@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L334
	lwz 8,84(29)
	lwz 0,3736(8)
	cmpwi 0,0,0
	bc 4,2,.L511
	lwz 0,3988(8)
	cmpwi 0,0,0
	bc 4,2,.L512
	li 0,256
	lis 9,itemlist@ha
	lwz 5,740(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,744
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
	bc 12,2,.L343
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L343
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L501
.L343:
	addi 7,7,1
	bdnz .L508
	b .L513
.L334:
	lis 4,.LC70@ha
	mr 3,31
	la 4,.LC70@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L348
	lwz 7,84(29)
	lwz 0,3736(7)
	cmpwi 0,0,0
	bc 4,2,.L514
	lwz 0,3988(7)
	cmpwi 0,0,0
	bc 4,2,.L515
	li 0,256
	lwz 11,740(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,744
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
	bc 12,2,.L357
	mulli 0,8,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L357
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L502
.L357:
	addi 11,11,-1
	bdnz .L507
	b .L516
.L348:
	lis 4,.LC71@ha
	mr 3,31
	la 4,.LC71@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L362
	lwz 8,84(29)
	lwz 0,3736(8)
	cmpwi 0,0,0
	bc 4,2,.L511
	lwz 0,3988(8)
	cmpwi 0,0,0
	bc 4,2,.L512
	li 0,256
	lis 9,itemlist@ha
	lwz 5,740(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,744
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
	bc 12,2,.L371
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L371
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L501
.L371:
	addi 7,7,1
	bdnz .L506
	b .L513
.L362:
	lis 4,.LC72@ha
	mr 3,31
	la 4,.LC72@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L376
	lwz 7,84(29)
	lwz 0,3736(7)
	cmpwi 0,0,0
	bc 4,2,.L514
	lwz 0,3988(7)
	cmpwi 0,0,0
	bc 4,2,.L515
	li 0,256
	lwz 11,740(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,744
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
	bc 12,2,.L385
	mulli 0,8,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L385
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L502
.L385:
	addi 11,11,-1
	bdnz .L505
	b .L516
.L376:
	lis 4,.LC73@ha
	mr 3,31
	la 4,.LC73@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L390
	lwz 8,84(29)
	lwz 0,3736(8)
	cmpwi 0,0,0
	bc 12,2,.L391
.L511:
	mr 3,29
	bl PMenu_Next
	b .L285
.L391:
	lwz 0,3988(8)
	cmpwi 0,0,0
	bc 12,2,.L393
.L512:
	mr 3,29
	bl ChaseNext
	b .L285
.L393:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,740(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,744
.L504:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L399
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L399
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L501
.L399:
	addi 7,7,1
	bdnz .L504
.L513:
	li 0,-1
	stw 0,740(8)
	b .L285
.L390:
	lis 4,.LC74@ha
	mr 3,31
	la 4,.LC74@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L404
	lwz 7,84(29)
	lwz 0,3736(7)
	cmpwi 0,0,0
	bc 12,2,.L405
.L514:
	mr 3,29
	bl PMenu_Prev
	b .L285
.L405:
	lwz 0,3988(7)
	cmpwi 0,0,0
	bc 12,2,.L407
.L515:
	mr 3,29
	bl ChasePrev
	b .L285
.L407:
	li 0,256
	lwz 11,740(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,744
	la 5,itemlist@l(9)
	addi 11,11,255
.L503:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L413
	mulli 0,8,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L413
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L502
.L413:
	addi 11,11,-1
	bdnz .L503
.L516:
	li 0,-1
	stw 0,740(7)
	b .L285
.L404:
	lis 4,.LC75@ha
	mr 3,31
	la 4,.LC75@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L418
	mr 3,29
	bl Cmd_InvUse_f
	b .L285
.L418:
	lis 4,.LC76@ha
	mr 3,31
	la 4,.LC76@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L420
	mr 3,29
	bl Cmd_InvDrop_f
	b .L285
.L420:
	lis 4,.LC77@ha
	mr 3,31
	la 4,.LC77@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L422
	lwz 28,84(29)
	lwz 11,1792(28)
	cmpwi 0,11,0
	bc 12,2,.L285
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,28,744
	mullw 9,9,0
	srawi 27,9,3
.L427:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L429
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L429
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L429
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1792(28)
	cmpw 0,0,31
	bc 12,2,.L285
.L429:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L427
	b .L285
.L422:
	lis 4,.LC78@ha
	mr 3,31
	la 4,.LC78@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L435
	lwz 28,84(29)
	lwz 11,1792(28)
	cmpwi 0,11,0
	bc 12,2,.L285
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	mr 25,9
	li 27,1
	subf 9,9,11
	addi 26,28,744
	mullw 9,9,0
	srawi 9,9,3
	addi 30,9,255
.L440:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L442
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L442
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L442
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1792(28)
	cmpw 0,0,31
	bc 12,2,.L285
.L442:
	addi 27,27,1
	addi 30,30,-1
	cmpwi 0,27,256
	bc 4,1,.L440
	b .L285
.L435:
	lis 4,.LC79@ha
	mr 3,31
	la 4,.LC79@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L448
	lwz 10,84(29)
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L285
	lwz 0,1796(10)
	cmpwi 0,0,0
	bc 12,2,.L285
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 4,itemlist@l(11)
	ori 9,9,36409
	subf 0,4,0
	addi 11,10,744
	mullw 0,0,9
	srawi 10,0,3
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L285
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L285
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L285
	mr 3,29
	mtlr 9
	blrl
	b .L285
.L448:
	lis 4,.LC80@ha
	mr 3,31
	la 4,.LC80@l(4)
	bl Q_stricmp
	mr. 10,3
	bc 4,2,.L456
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 12,2,.L285
	lwz 11,84(29)
	lwz 0,3432(11)
	cmpwi 0,0,0
	bc 12,1,.L459
	lis 9,gi+8@ha
	lis 5,.LC29@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC29@l(5)
.L509:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L285
.L459:
	lis 9,level+4@ha
	lfs 13,3984(11)
	lfs 0,level+4@l(9)
	lis 11,.LC98@ha
	la 11,.LC98@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L285
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
	b .L285
.L456:
	lis 4,.LC81@ha
	mr 3,31
	la 4,.LC81@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L462
	lwz 9,84(29)
	lwz 0,3728(9)
	mr 10,9
	cmpwi 0,0,0
	bc 4,2,.L463
	lwz 0,3744(9)
	cmpwi 0,0,0
	bc 4,2,.L463
	lwz 0,3740(9)
	cmpwi 0,0,0
	bc 12,2,.L464
.L463:
	li 0,0
	li 11,1
	stw 0,3728(10)
	stw 0,3740(10)
	stw 0,3744(10)
	lwz 9,84(29)
	stw 11,3992(9)
	b .L285
.L464:
	lwz 0,3736(9)
	cmpwi 0,0,0
	bc 12,2,.L466
.L510:
	mr 3,29
	bl PMenu_Close
	lwz 9,84(29)
	li 0,1
	stw 0,3992(9)
	b .L285
.L466:
	lis 4,.LC30@ha
	mr 3,29
	la 4,.LC30@l(4)
	bl StuffCmd
	b .L285
.L462:
	lis 4,.LC82@ha
	mr 3,31
	la 4,.LC82@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L470
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	bl atoi
	mr 4,3
	mr 3,29
	bl wave
	b .L285
.L470:
	lis 4,.LC83@ha
	mr 3,31
	la 4,.LC83@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L473
	mr 3,29
	bl Cmd_PlayerList_f
	b .L285
.L473:
	lis 4,.LC84@ha
	mr 3,31
	la 4,.LC84@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L475
	mr 3,29
	bl Cmd_Team_f
	b .L285
.L475:
	lis 4,.LC85@ha
	mr 3,31
	la 4,.LC85@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L477
	mr 3,29
	bl Cmd_ID_f
	b .L285
.L477:
	lis 4,.LC86@ha
	mr 3,31
	la 4,.LC86@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L479
	lis 10,sv_utilflags@ha
	lwz 9,sv_utilflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,8
	bc 4,2,.L479
	mr 3,29
	bl DisplayMOTD
	b .L285
.L479:
	lis 4,.LC87@ha
	mr 3,31
	la 4,.LC87@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L481
	lis 9,.LC97@ha
	lis 11,flagtrack@ha
	la 9,.LC97@l(9)
	lfs 13,0(9)
	lwz 9,flagtrack@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L481
	mr 3,29
	bl Cmd_Drop_Flag
	b .L285
.L481:
	lis 4,.LC88@ha
	mr 3,31
	la 4,.LC88@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L483
	mr 3,29
	bl DisplaySettings
	b .L285
.L483:
	mr 3,29
	bl ValidOverlayCommand
	cmpwi 0,3,0
	bc 4,2,.L285
	lis 4,.LC89@ha
	mr 3,31
	la 4,.LC89@l(4)
	li 5,1
	bl strncmp
	cmpwi 0,3,0
	bc 4,2,.L487
	lwz 9,84(29)
	lwz 0,3600(9)
	ori 0,0,1
	stw 0,3600(9)
	b .L285
.L487:
	lis 4,.LC90@ha
	mr 3,31
	la 4,.LC90@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L489
	mr 3,29
	bl Cmd_Examine_Teams
	b .L285
.L489:
	lis 4,.LC91@ha
	mr 3,31
	la 4,.LC91@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L492
	lis 4,.LC92@ha
	mr 3,31
	la 4,.LC92@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L492
	lis 4,.LC93@ha
	mr 3,31
	la 4,.LC93@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L492
	lis 4,.LC94@ha
	mr 3,31
	la 4,.LC94@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L492
	lis 4,.LC95@ha
	mr 3,31
	la 4,.LC95@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L491
.L492:
	mr 3,29
	bl Cmd_Observe
	b .L285
.L491:
	lis 4,.LC96@ha
	mr 3,31
	la 4,.LC96@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L494
	lfs 12,4(29)
	lis 9,gi+8@ha
	lfs 13,8(29)
	mr 7,6
	mr 8,6
	lfs 0,12(29)
	lis 5,.LC49@ha
	mr 3,29
	lwz 0,gi+8@l(9)
	la 5,.LC49@l(5)
	li 4,2
	mtlr 0
	fctiwz 11,12
	fctiwz 10,13
	fctiwz 9,0
	stfd 11,16(1)
	lwz 6,20(1)
	stfd 10,16(1)
	lwz 7,20(1)
	stfd 9,16(1)
	lwz 8,20(1)
	crxor 6,6,6
	blrl
	b .L285
.L501:
	stw 11,740(8)
	b .L285
.L502:
	stw 8,740(7)
	b .L285
.L494:
	mr 3,29
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L285:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
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
	lwz 11,740(8)
	addi 10,8,744
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L50
	lwz 0,3736(8)
	cmpwi 0,0,0
	bc 12,2,.L52
	bl PMenu_Next
	b .L50
.L52:
	lwz 0,3988(8)
	cmpwi 0,0,0
	bc 12,2,.L54
	bl ChaseNext
	b .L50
.L517:
	stw 11,740(8)
	b .L50
.L54:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L518:
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
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L60
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L517
.L60:
	addi 7,7,1
	bdnz .L518
	li 0,-1
	stw 0,740(8)
.L50:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 ValidateSelectedItem,.Lfe11-ValidateSelectedItem
	.comm	gametype,4,4
	.comm	flags,4,4
	.comm	gCauseTable,4,4
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
	bc 12,2,.L520
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
	bc 12,2,.L520
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L9
	addi 3,3,1
	b .L519
.L9:
	stb 30,0(3)
.L520:
	mr 3,31
.L519:
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
	lwz 0,3736(8)
	cmpwi 0,0,0
	bc 12,2,.L27
	bl PMenu_Next
	b .L26
.L27:
	lwz 0,3988(8)
	cmpwi 0,0,0
	bc 12,2,.L28
	bl ChaseNext
	b .L26
.L521:
	stw 11,740(8)
	b .L26
.L28:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,740(8)
	mtctr 0
	li 7,1
	la 3,itemlist@l(9)
	addi 6,8,744
.L522:
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
	mulli 0,11,72
	add 10,0,3
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L32
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L521
.L32:
	addi 7,7,1
	bdnz .L522
	li 0,-1
	stw 0,740(8)
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
	lwz 0,3736(7)
	cmpwi 0,0,0
	bc 12,2,.L39
	bl PMenu_Prev
	b .L38
.L39:
	lwz 0,3988(7)
	cmpwi 0,0,0
	bc 12,2,.L40
	bl ChasePrev
	b .L38
.L523:
	stw 8,740(7)
	b .L38
.L40:
	li 0,256
	lwz 11,740(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,744
	la 5,itemlist@l(9)
	addi 11,11,255
.L524:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L44
	mulli 0,8,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L44
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L523
.L44:
	addi 11,11,-1
	bdnz .L524
	li 0,-1
	stw 0,740(7)
.L38:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 SelectPrevItem,.Lfe14-SelectPrevItem
	.section	".rodata"
	.align 2
.LC99:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC99@ha
	lis 9,deathmatch@ha
	la 11,.LC99@l(11)
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
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L120
.L119:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
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
.LC100:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC100@ha
	lis 9,deathmatch@ha
	la 11,.LC100@l(11)
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
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L124
.L123:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
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
.LC101:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC101@ha
	lis 9,deathmatch@ha
	la 11,.LC101@l(11)
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
	stw 0,3744(31)
	stw 0,3728(31)
	lwz 9,84(30)
	lwz 9,3736(9)
	cmpwi 0,9,0
	bc 12,2,.L144
	bl PMenu_Close
	lwz 9,84(30)
	li 0,1
	stw 0,3992(9)
	b .L143
.L144:
	lwz 0,3740(31)
	cmpwi 0,0,0
	bc 12,2,.L145
	stw 9,3740(31)
	mr 3,30
	bl OverlayUpdate
	b .L143
.L145:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3740(31)
	li 3,5
	lwz 0,100(9)
	addi 29,31,1764
	mr 28,9
	addi 31,31,744
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
.L143:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 Cmd_Inven_f,.Lfe18-Cmd_Inven_f
	.align 2
	.globl Cmd_LastWeap_f
	.type	 Cmd_LastWeap_f,@function
Cmd_LastWeap_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 4,84(3)
	lwz 0,1792(4)
	cmpwi 0,0,0
	bc 12,2,.L172
	lwz 9,1796(4)
	cmpwi 0,9,0
	bc 12,2,.L172
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L172:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 Cmd_LastWeap_f,.Lfe19-Cmd_LastWeap_f
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
	lwz 11,1792(29)
	cmpwi 0,11,0
	bc 12,2,.L175
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,29,744
	mullw 9,9,0
	srawi 27,9,3
.L180:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L179
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L179
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L179
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1792(29)
	cmpw 0,0,31
	bc 12,2,.L175
.L179:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L180
.L175:
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
	lwz 11,1792(29)
	cmpwi 0,11,0
	bc 12,2,.L186
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	mr 25,9
	li 28,1
	subf 9,9,11
	addi 26,29,744
	mullw 9,9,0
	srawi 9,9,3
	addi 30,9,255
.L191:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L190
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L190
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L190
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1792(29)
	cmpw 0,0,31
	bc 12,2,.L186
.L190:
	addi 28,28,1
	addi 30,30,-1
	cmpwi 0,28,256
	bc 4,1,.L191
.L186:
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
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L197
	lwz 0,1796(10)
	cmpwi 0,0,0
	bc 12,2,.L197
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 4,itemlist@l(11)
	ori 9,9,36409
	subf 0,4,0
	addi 11,10,744
	mullw 0,0,9
	srawi 10,0,3
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L197
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L197
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L197
	mtlr 9
	blrl
.L197:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 Cmd_WeapLast_f,.Lfe22-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC102:
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
	bc 12,2,.L223
	lwz 11,84(10)
	lwz 0,3432(11)
	cmpwi 0,0,0
	bc 12,1,.L225
	lis 9,gi+8@ha
	lis 5,.LC29@ha
	lwz 0,gi+8@l(9)
	la 5,.LC29@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L223
.L225:
	lis 9,level+4@ha
	lfs 13,3984(11)
	lfs 0,level+4@l(9)
	lis 11,.LC102@ha
	la 11,.LC102@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L223
	lwz 0,264(10)
	li 9,0
	mr 3,10
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
.L223:
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
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3728(9)
	cmpwi 0,0,0
	bc 4,2,.L229
	lwz 0,3744(9)
	cmpwi 0,0,0
	bc 4,2,.L229
	lwz 0,3740(9)
	cmpwi 0,0,0
	bc 12,2,.L228
.L229:
	lwz 11,84(31)
	li 0,0
	li 10,1
	stw 0,3728(11)
	stw 0,3740(11)
	stw 0,3744(11)
	lwz 9,84(31)
	stw 10,3992(9)
	b .L230
.L228:
	lwz 0,3736(9)
	cmpwi 0,0,0
	bc 12,2,.L231
	mr 3,31
	bl PMenu_Close
	lwz 9,84(31)
	li 0,1
	stw 0,3992(9)
	b .L230
.L231:
	lis 4,.LC30@ha
	mr 3,31
	la 4,.LC30@l(4)
	bl StuffCmd
.L230:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
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
	mulli 9,9,4596
	mulli 11,3,4596
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
	.align 2
	.globl Cmd_Wave_f
	.type	 Cmd_Wave_f,@function
Cmd_Wave_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+160@ha
	mr 29,3
	lwz 0,gi+160@l(9)
	li 3,1
	mtlr 0
	blrl
	bl atoi
	mr 4,3
	mr 3,29
	bl wave
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 Cmd_Wave_f,.Lfe26-Cmd_Wave_f
	.align 2
	.globl Cmd_ShowPos
	.type	 Cmd_ShowPos,@function
Cmd_ShowPos:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lfs 12,4(3)
	lis 9,gi+8@ha
	lfs 13,8(3)
	mr 7,6
	mr 8,6
	lfs 0,12(3)
	lis 5,.LC49@ha
	li 4,2
	lwz 0,gi+8@l(9)
	la 5,.LC49@l(5)
	mtlr 0
	fctiwz 11,12
	fctiwz 10,13
	fctiwz 9,0
	stfd 11,8(1)
	lwz 6,12(1)
	stfd 10,8(1)
	lwz 7,12(1)
	stfd 9,8(1)
	lwz 8,12(1)
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe27:
	.size	 Cmd_ShowPos,.Lfe27-Cmd_ShowPos
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
