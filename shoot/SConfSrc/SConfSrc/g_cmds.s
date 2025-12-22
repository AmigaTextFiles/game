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
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L64
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
	addi 11,11,740
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
	addi 9,9,740
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
	addi 9,9,740
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
	addi 9,9,740
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
	addi 9,9,740
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
	lwz 0,4(29)
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	b .L116
.L108:
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 4,2,.L110
	lis 9,gi+4@ha
	lis 3,.LC12@ha
	lwz 0,gi+4@l(9)
	la 3,.LC12@l(3)
.L116:
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
	.string	"Item is not dropable.\n"
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
	li 9,0
	lwz 31,84(30)
	lwz 0,3816(31)
	stw 9,3508(31)
	cmpwi 0,0,3
	stw 9,3524(31)
	bc 4,2,.L139
	stw 9,3520(31)
	bl PMenu_Close
.L139:
	lwz 9,84(30)
	lwz 9,3516(9)
	cmpwi 0,9,0
	bc 12,2,.L140
	mr 3,30
	bl PMenu_Close
	lwz 9,84(30)
	li 0,1
	stw 0,3836(9)
	b .L138
.L140:
	lwz 0,3520(31)
	cmpwi 0,0,0
	bc 12,2,.L141
	stw 9,3520(31)
	b .L138
.L141:
	lwz 0,3428(31)
	cmpwi 0,0,0
	bc 4,2,.L142
	li 0,1
	mr 3,30
	stw 0,3816(31)
	bl CTFOpenJoinMenu
	b .L138
.L142:
	lwz 0,3816(31)
	cmpwi 0,0,2
	bc 4,2,.L143
	mr 3,30
	bl CTFOpenJoinMenu2
	b .L138
.L143:
	li 0,2
	li 11,1
	lis 9,gi@ha
	stw 0,3816(31)
	li 3,5
	la 9,gi@l(9)
	stw 11,3520(31)
	addi 29,31,1760
	lwz 0,100(9)
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L147:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,29
	bc 4,1,.L147
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L138:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 Cmd_Inven_f,.Lfe3-Cmd_Inven_f
	.section	".rodata"
	.align 2
.LC24:
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
	lwz 0,3516(8)
	cmpwi 0,0,0
	bc 12,2,.L150
	bl PMenu_Select
	b .L149
.L150:
	lwz 11,736(8)
	addi 10,8,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L152
	lwz 0,3832(8)
	cmpwi 0,0,0
	bc 12,2,.L155
	mr 3,31
	bl ChaseNext
	b .L152
.L167:
	stw 11,736(8)
	b .L152
.L155:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L168:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L161
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L161
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L167
.L161:
	addi 7,7,1
	bdnz .L168
	li 0,-1
	stw 0,736(8)
.L152:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L165
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC24@l(5)
	b .L169
.L165:
	mulli 0,0,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L166
	lis 9,gi+8@ha
	lis 5,.LC21@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC21@l(5)
.L169:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L149
.L166:
	mr 3,31
	mtlr 0
	blrl
.L149:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 Cmd_InvUse_f,.Lfe4-Cmd_InvUse_f
	.section	".rodata"
	.align 2
.LC25:
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
	cmpwi 0,0,0
	bc 12,2,.L198
	lwz 8,84(31)
	lwz 11,736(8)
	addi 10,8,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L201
	lwz 0,3516(8)
	cmpwi 0,0,0
	bc 12,2,.L202
	bl PMenu_Next
	b .L201
.L202:
	lwz 0,3832(8)
	cmpwi 0,0,0
	bc 12,2,.L204
	mr 3,31
	bl ChaseNext
	b .L201
.L216:
	stw 11,736(8)
	b .L201
.L204:
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
	mulli 0,11,72
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
.L201:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L214
	lis 9,gi+8@ha
	lis 5,.LC25@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC25@l(5)
	b .L218
.L214:
	mulli 0,0,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L215
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC23@l(5)
.L218:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L198
.L215:
	mr 3,31
	mtlr 0
	blrl
.L198:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_InvDrop_f,.Lfe5-Cmd_InvDrop_f
	.section	".rodata"
	.align 2
.LC26:
	.string	"%3i %s\n"
	.align 2
.LC27:
	.string	"...\n"
	.align 2
.LC28:
	.string	"%s\n%i players\n"
	.align 2
.LC29:
	.long 0x0
	.align 3
.LC30:
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
	lis 11,.LC29@ha
	lis 9,maxclients@ha
	la 11,.LC29@l(11)
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
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L231:
	lwz 0,0(11)
	addi 11,11,3888
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
	lis 26,.LC26@ha
	lis 25,.LC27@ha
.L237:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC26@l(26)
	addi 28,28,4
	mulli 7,7,3888
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
	la 4,.LC27@l(25)
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
	lis 5,.LC28@ha
	lwz 0,gi+8@l(9)
	mr 3,23
	la 5,.LC28@l(5)
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
.LC31:
	.string	"flipoff\n"
	.align 2
.LC32:
	.string	"makron/voice3.wav"
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
	.align 2
.LC37:
	.long 0x3f800000
	.align 2
.LC38:
	.long 0x40000000
	.align 2
.LC39:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Wave_f
	.type	 Cmd_Wave_f,@function
Cmd_Wave_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
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
	lwz 0,3716(9)
	cmpwi 0,0,1
	bc 12,1,.L240
	cmplwi 0,3,4
	li 0,1
	stw 0,3716(9)
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
	lis 29,gi@ha
	lis 5,.LC31@ha
	la 29,gi@l(29)
	la 5,.LC31@l(5)
	lwz 9,8(29)
	li 4,2
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC32@ha
	la 3,.LC32@l(3)
	mtlr 9
	blrl
	lis 9,.LC37@ha
	lwz 0,16(29)
	lis 11,.LC38@ha
	la 9,.LC37@l(9)
	la 11,.LC38@l(11)
	lfs 1,0(9)
	mr 5,3
	mtlr 0
	li 4,2
	lis 9,.LC39@ha
	lfs 2,0(11)
	mr 3,31
	la 9,.LC39@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,84(31)
	li 0,71
	li 9,83
	b .L251
.L245:
	lis 9,gi+8@ha
	lis 5,.LC33@ha
	lwz 0,gi+8@l(9)
	la 5,.LC33@l(5)
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
	lis 5,.LC34@ha
	lwz 0,gi+8@l(9)
	la 5,.LC34@l(5)
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
	lis 5,.LC35@ha
	lwz 0,gi+8@l(9)
	la 5,.LC35@l(5)
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
	lis 5,.LC36@ha
	lwz 0,gi+8@l(9)
	la 5,.LC36@l(5)
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
	stw 9,3712(11)
.L240:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 Cmd_Wave_f,.Lfe7-Cmd_Wave_f
	.section	".rodata"
	.align 2
.LC40:
	.string	"Motion Cloaking Enabled!\n"
	.align 2
.LC41:
	.string	"Motion Cloaking Disabled!\n"
	.align 2
.LC42:
	.string	"(%s): "
	.align 2
.LC43:
	.string	"%s: "
	.align 2
.LC44:
	.string	" "
	.align 2
.LC45:
	.string	"\n"
	.align 2
.LC46:
	.string	"You can't talk for %d more seconds\n"
	.align 2
.LC47:
	.string	"Flood protection:  You can't talk for %d seconds.\n"
	.align 2
.LC48:
	.string	"%s"
	.align 2
.LC49:
	.long 0x0
	.align 3
.LC50:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC51:
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
	bc 12,1,.L258
	cmpwi 0,31,0
	bc 12,2,.L257
.L258:
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
	bc 12,2,.L260
	lwz 6,84(28)
	lis 5,.LC42@ha
	addi 3,1,8
	la 5,.LC42@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L261
.L260:
	lwz 6,84(28)
	lis 5,.LC43@ha
	addi 3,1,8
	la 5,.LC43@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L261:
	cmpwi 0,31,0
	bc 12,2,.L262
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC44@ha
	addi 3,1,8
	la 4,.LC44@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L263
.L262:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L264
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
.L264:
	mr 4,29
	addi 3,1,8
	bl strcat
.L263:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L265
	li 0,0
	stb 0,158(1)
.L265:
	lis 4,.LC45@ha
	addi 3,1,8
	la 4,.LC45@l(4)
	bl strcat
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfs 8,0(9)
	lis 9,flood_msgs@ha
	lwz 11,flood_msgs@l(9)
	lfs 9,20(11)
	fcmpu 0,9,8
	bc 12,2,.L266
	lwz 7,84(28)
	lis 9,level+4@ha
	lfs 10,level+4@l(9)
	lfs 0,3764(7)
	fcmpu 0,10,0
	bc 4,0,.L267
	fsubs 0,0,10
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC46@ha
	mr 3,28
	la 5,.LC46@l(5)
	li 4,2
	mtlr 0
	fctiwz 13,0
	stfd 13,2064(1)
	b .L280
.L267:
	lwz 0,3808(7)
	lis 10,0x4330
	lis 11,.LC50@ha
	addi 8,7,3768
	mr 6,0
	la 11,.LC50@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,2068(1)
	lis 11,.LC51@ha
	stw 10,2064(1)
	la 11,.LC51@l(11)
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
	bc 12,2,.L269
	lis 11,flood_persecond@ha
	fsubs 13,10,0
	lwz 9,flood_persecond@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L269
	lis 9,flood_waitdelay@ha
	lis 10,gi+8@ha
	lwz 11,flood_waitdelay@l(9)
	lis 5,.LC47@ha
	mr 3,28
	la 5,.LC47@l(5)
	lfs 13,20(11)
	li 4,3
	fadds 13,10,13
	stfs 13,3764(7)
	lfs 0,20(11)
	lwz 0,gi+8@l(10)
	mtlr 0
	fctiwz 12,0
	stfd 12,2064(1)
.L280:
	lwz 6,2068(1)
	crxor 6,6,6
	blrl
	b .L257
.L269:
	lis 0,0xcccc
	addi 9,6,1
	ori 0,0,52429
	lis 11,level+4@ha
	mulhwu 0,9,0
	srwi 0,0,3
	mulli 0,0,10
	subf 9,0,9
	stw 9,3808(7)
	lfs 0,level+4@l(11)
	slwi 9,9,2
	stfsx 0,10,9
.L266:
	lis 9,.LC49@ha
	lis 11,dedicated@ha
	la 9,.LC49@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L270
	lis 9,gi+8@ha
	lis 5,.LC48@ha
	lwz 0,gi+8@l(9)
	la 5,.LC48@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L270:
	lis 9,game@ha
	li 31,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,31,0
	bc 12,1,.L257
	cmpwi 4,30,0
	lis 9,gi@ha
	la 24,gi@l(9)
	mr 25,11
	lis 26,g_edicts@ha
	lis 27,.LC48@ha
	li 30,892
.L274:
	lwz 0,g_edicts@l(26)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L273
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L273
	bc 12,18,.L277
	mr 3,28
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L273
.L277:
	lwz 9,8(24)
	mr 3,29
	li 4,3
	la 5,.LC48@l(27)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L273:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,892
	cmpw 0,31,0
	bc 4,1,.L274
.L257:
	lwz 0,2116(1)
	lwz 12,2076(1)
	mtlr 0
	lmw 24,2080(1)
	mtcrf 8,12
	la 1,2112(1)
	blr
.Lfe8:
	.size	 Cmd_Say_f,.Lfe8-Cmd_Say_f
	.align 2
	.globl Cmd_menume_f
	.type	 Cmd_menume_f,@function
Cmd_menume_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	li 9,0
	lwz 31,84(30)
	lwz 0,3816(31)
	stw 9,3508(31)
	cmpwi 0,0,3
	stw 9,3524(31)
	bc 4,2,.L282
	stw 9,3520(31)
	bl PMenu_Close
.L282:
	lwz 9,84(30)
	lwz 9,3516(9)
	cmpwi 0,9,0
	bc 12,2,.L283
	mr 3,30
	bl PMenu_Close
	lwz 9,84(30)
	li 0,1
	stw 0,3836(9)
	b .L281
.L283:
	lwz 0,3520(31)
	cmpwi 0,0,0
	bc 12,2,.L284
	stw 9,3520(31)
	b .L281
.L284:
	lwz 0,3428(31)
	cmpwi 0,0,0
	bc 4,2,.L285
	li 0,1
	mr 3,30
	stw 0,3816(31)
	bl CTFOpenJoinMenu
	b .L281
.L285:
	lwz 0,3816(31)
	cmpwi 0,0,2
	bc 4,2,.L286
	mr 3,30
	bl CTFOpenJoinMenu2
	b .L281
.L286:
	li 0,2
	li 11,1
	lis 9,gi@ha
	stw 0,3816(31)
	li 3,5
	la 9,gi@l(9)
	stw 11,3520(31)
	addi 29,31,1760
	lwz 0,100(9)
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L290:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,29
	bc 4,1,.L290
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L281:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 Cmd_menume_f,.Lfe9-Cmd_menume_f
	.section	".rodata"
	.align 2
.LC52:
	.string	"players"
	.align 2
.LC53:
	.string	"say"
	.align 2
.LC54:
	.string	"say_team"
	.align 2
.LC55:
	.string	"score"
	.align 2
.LC56:
	.string	"help"
	.align 2
.LC57:
	.string	"use"
	.align 2
.LC58:
	.string	"drop"
	.align 2
.LC59:
	.string	"give"
	.align 2
.LC60:
	.string	"god"
	.align 2
.LC61:
	.string	"notarget"
	.align 2
.LC62:
	.string	"noclip"
	.align 2
.LC63:
	.string	"inven"
	.align 2
.LC64:
	.string	"invnext"
	.align 2
.LC65:
	.string	"invprev"
	.align 2
.LC66:
	.string	"invnextw"
	.align 2
.LC67:
	.string	"invprevw"
	.align 2
.LC68:
	.string	"invnextp"
	.align 2
.LC69:
	.string	"invprevp"
	.align 2
.LC70:
	.string	"invuse"
	.align 2
.LC71:
	.string	"menu"
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
	.string	"!zbot"
	.align 2
.LC80:
	.string	"#zbot"
	.align 2
.LC81:
	.string	"id"
	.align 2
.LC82:
	.string	"cloak"
	.align 2
.LC83:
	.string	"Cloaking is not active on this server.\n"
	.align 2
.LC84:
	.long 0x0
	.align 2
.LC85:
	.long 0x40a00000
	.align 3
.LC86:
	.long 0x3ff80000
	.long 0x0
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
	bc 12,2,.L292
	lis 9,gi@ha
	li 3,0
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC52@ha
	la 4,.LC52@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L294
	mr 3,29
	bl Cmd_Players_f
	b .L292
.L294:
	lis 4,.LC53@ha
	mr 3,31
	la 4,.LC53@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L295
	mr 3,29
	li 4,0
	b .L499
.L295:
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L296
	mr 3,29
	li 4,1
.L499:
	li 5,0
	bl Cmd_Say_f
	b .L292
.L296:
	lis 4,.LC55@ha
	mr 3,31
	la 4,.LC55@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L297
	mr 3,29
	bl ServObit_Cmd_Score_f
	b .L292
.L297:
	lis 4,.LC56@ha
	mr 3,31
	la 4,.LC56@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L298
	mr 3,29
	bl ServObit_Cmd_Help_f
	b .L292
.L298:
	lis 10,.LC84@ha
	lis 9,level+200@ha
	la 10,.LC84@l(10)
	lfs 0,level+200@l(9)
	lfs 31,0(10)
	fcmpu 0,0,31
	bc 4,2,.L292
	lis 4,.LC57@ha
	mr 3,31
	la 4,.LC57@l(4)
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
	lis 5,.LC20@ha
	mr 3,29
	la 5,.LC20@l(5)
	b .L500
.L301:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L303
	lwz 0,8(30)
	lis 5,.LC21@ha
	mr 3,29
	la 5,.LC21@l(5)
	b .L501
.L303:
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
	bc 12,2,.L502
	b .L311
.L300:
	lis 4,.LC58@ha
	mr 3,31
	la 4,.LC58@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L306
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 12,2,.L292
	lwz 9,164(30)
	mtlr 9
	blrl
	mr 31,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L308
	lwz 0,8(30)
	lis 5,.LC20@ha
	mr 3,29
	la 5,.LC20@l(5)
	b .L500
.L308:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L310
	lwz 0,8(30)
	lis 5,.LC23@ha
	mr 3,29
	la 5,.LC23@l(5)
	b .L501
.L310:
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
	bc 4,2,.L311
.L502:
	lwz 0,8(30)
	lis 5,.LC22@ha
	mr 3,29
	la 5,.LC22@l(5)
.L500:
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L292
.L311:
	mr 3,29
	mtlr 10
	blrl
	b .L292
.L306:
	lis 4,.LC59@ha
	mr 3,31
	la 4,.LC59@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L313
	mr 3,29
	bl Cmd_Give_f
	b .L292
.L313:
	lis 4,.LC60@ha
	mr 3,31
	la 4,.LC60@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L315
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L316
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L316
	lwz 0,8(30)
	lis 5,.LC1@ha
	mr 3,29
	la 5,.LC1@l(5)
	b .L501
.L316:
	lwz 0,264(29)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(29)
	bc 4,2,.L318
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L331
.L318:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
	b .L331
.L315:
	lis 4,.LC61@ha
	mr 3,31
	la 4,.LC61@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L321
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L322
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L322
	lwz 0,8(30)
	lis 5,.LC1@ha
	mr 3,29
	la 5,.LC1@l(5)
	b .L501
.L322:
	lwz 0,264(29)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(29)
	bc 4,2,.L324
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L331
.L324:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
	b .L331
.L321:
	lis 4,.LC62@ha
	mr 3,31
	la 4,.LC62@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L327
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L328
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L328
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC1@l(5)
	b .L501
.L328:
	lwz 0,260(29)
	cmpwi 0,0,1
	bc 4,2,.L330
	li 0,4
	lis 9,.LC18@ha
	stw 0,260(29)
	la 5,.LC18@l(9)
	b .L331
.L330:
	li 0,1
	lis 9,.LC19@ha
	stw 0,260(29)
	la 5,.LC19@l(9)
.L331:
	lis 9,gi+8@ha
	mr 3,29
	lwz 0,gi+8@l(9)
.L501:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L292
.L327:
	lis 4,.LC63@ha
	mr 3,31
	la 4,.LC63@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L333
	mr 3,29
	bl ServObit_Cmd_Inven_f
	b .L292
.L333:
	lis 4,.LC64@ha
	mr 3,31
	la 4,.LC64@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L335
	lwz 8,84(29)
	lwz 0,3516(8)
	cmpwi 0,0,0
	bc 4,2,.L503
	lwz 0,3832(8)
	cmpwi 0,0,0
	bc 4,2,.L504
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L498:
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
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L344
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L491
.L344:
	addi 7,7,1
	bdnz .L498
	b .L505
.L335:
	lis 4,.LC65@ha
	mr 3,31
	la 4,.LC65@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L349
	lwz 7,84(29)
	lwz 0,3516(7)
	cmpwi 0,0,0
	bc 4,2,.L506
	lwz 0,3832(7)
	cmpwi 0,0,0
	bc 4,2,.L507
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L497:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L358
	mulli 0,8,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L358
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L492
.L358:
	addi 11,11,-1
	bdnz .L497
	b .L508
.L349:
	lis 4,.LC66@ha
	mr 3,31
	la 4,.LC66@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L363
	lwz 8,84(29)
	lwz 0,3516(8)
	cmpwi 0,0,0
	bc 4,2,.L503
	lwz 0,3832(8)
	cmpwi 0,0,0
	bc 4,2,.L504
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
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
	bc 12,2,.L372
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L372
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L491
.L372:
	addi 7,7,1
	bdnz .L496
	b .L505
.L363:
	lis 4,.LC67@ha
	mr 3,31
	la 4,.LC67@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L377
	lwz 7,84(29)
	lwz 0,3516(7)
	cmpwi 0,0,0
	bc 4,2,.L506
	lwz 0,3832(7)
	cmpwi 0,0,0
	bc 4,2,.L507
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L495:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L386
	mulli 0,8,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L386
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L492
.L386:
	addi 11,11,-1
	bdnz .L495
	b .L508
.L377:
	lis 4,.LC68@ha
	mr 3,31
	la 4,.LC68@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L391
	lwz 8,84(29)
	lwz 0,3516(8)
	cmpwi 0,0,0
	bc 12,2,.L392
.L503:
	mr 3,29
	bl PMenu_Next
	b .L292
.L392:
	lwz 0,3832(8)
	cmpwi 0,0,0
	bc 12,2,.L394
.L504:
	mr 3,29
	bl ChaseNext
	b .L292
.L394:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L494:
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
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L400
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L491
.L400:
	addi 7,7,1
	bdnz .L494
.L505:
	li 0,-1
	stw 0,736(8)
	b .L292
.L391:
	lis 4,.LC69@ha
	mr 3,31
	la 4,.LC69@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L405
	lwz 7,84(29)
	lwz 0,3516(7)
	cmpwi 0,0,0
	bc 12,2,.L406
.L506:
	mr 3,29
	bl PMenu_Prev
	b .L292
.L406:
	lwz 0,3832(7)
	cmpwi 0,0,0
	bc 12,2,.L408
.L507:
	mr 3,29
	bl ChasePrev
	b .L292
.L408:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L493:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L414
	mulli 0,8,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L414
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L492
.L414:
	addi 11,11,-1
	bdnz .L493
.L508:
	li 0,-1
	stw 0,736(7)
	b .L292
.L405:
	lis 4,.LC70@ha
	mr 3,31
	la 4,.LC70@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L419
	mr 3,29
	bl Cmd_InvUse_f
	b .L292
.L419:
	lis 4,.LC71@ha
	mr 3,31
	la 4,.LC71@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L421
	mr 3,29
	bl Cmd_menume_f
	b .L292
.L421:
	lis 4,.LC72@ha
	mr 3,31
	la 4,.LC72@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L423
	mr 3,29
	bl Cmd_InvDrop_f
	b .L292
.L423:
	lis 4,.LC73@ha
	mr 3,31
	la 4,.LC73@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L425
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L292
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
.L430:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L432
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L432
	lwz 0,56(31)
	andi. 10,0,1
	bc 12,2,.L432
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L292
.L432:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L430
	b .L292
.L425:
	lis 4,.LC74@ha
	mr 3,31
	la 4,.LC74@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L438
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L292
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
.L443:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L445
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L445
	lwz 0,56(31)
	andi. 10,0,1
	bc 12,2,.L445
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L292
.L445:
	addi 27,27,1
	addi 30,30,-1
	cmpwi 0,27,256
	bc 4,1,.L443
	b .L292
.L438:
	lis 4,.LC75@ha
	mr 3,31
	la 4,.LC75@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L451
	lwz 10,84(29)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L292
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L292
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
	bc 12,2,.L292
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L292
	lwz 0,56(4)
	andi. 10,0,1
	bc 12,2,.L292
	mr 3,29
	mtlr 9
	blrl
	b .L292
.L451:
	lis 4,.LC76@ha
	mr 3,31
	la 4,.LC76@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L459
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 12,2,.L292
	lwz 11,84(29)
	lis 9,level+4@ha
	lis 10,.LC85@ha
	lfs 0,level+4@l(9)
	la 10,.LC85@l(10)
	lfs 13,3812(11)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L292
	lwz 0,264(29)
	lis 11,meansOfDeath@ha
	li 9,23
	stw 3,480(29)
	lis 6,0x1
	lis 7,vec3_origin@ha
	rlwinm 0,0,0,28,26
	mr 3,29
	stw 0,264(29)
	la 7,vec3_origin@l(7)
	mr 4,29
	stw 9,meansOfDeath@l(11)
	mr 5,29
	ori 6,6,34464
	bl player_die
	li 0,2
	mr 3,29
	stw 0,492(29)
	bl respawn
	b .L292
.L459:
	lis 4,.LC77@ha
	mr 3,31
	la 4,.LC77@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L464
	lwz 9,84(29)
	stw 3,3508(9)
	lwz 11,84(29)
	stw 3,3524(11)
	lwz 9,84(29)
	stw 3,3520(9)
	lwz 11,84(29)
	lwz 0,3516(11)
	cmpwi 0,0,0
	bc 12,2,.L465
	mr 3,29
	bl PMenu_Close
.L465:
	lwz 9,84(29)
	li 0,1
	stw 0,3836(9)
	b .L292
.L464:
	lis 4,.LC78@ha
	mr 3,31
	la 4,.LC78@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L468
	mr 3,29
	bl Cmd_Wave_f
	b .L292
.L468:
	lis 4,.LC79@ha
	mr 3,31
	la 4,.LC79@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L470
	lwz 9,84(29)
	stw 3,3468(9)
	b .L292
.L470:
	lis 4,.LC80@ha
	mr 3,31
	la 4,.LC80@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L472
	lwz 9,84(29)
	li 0,1
	stw 0,3476(9)
	b .L292
.L472:
	lis 4,.LC81@ha
	mr 3,31
	la 4,.LC81@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L474
	mr 3,29
	bl CTFID_f
	b .L292
.L474:
	lis 4,.LC82@ha
	mr 3,31
	la 4,.LC82@l(4)
	bl Q_stricmp
	mr. 28,3
	bc 4,2,.L476
	lis 9,cloaking@ha
	lwz 30,cloaking@l(9)
	cmpwi 0,30,1
	bc 4,2,.L477
	lwz 0,260(29)
	cmpwi 0,0,1
	bc 12,2,.L292
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 12,2,.L292
	lwz 9,84(29)
	lwz 0,3840(9)
	xori 31,0,1
	cmpwi 0,31,0
	stw 31,3840(9)
	bc 12,2,.L481
	lis 9,gi+12@ha
	lis 4,.LC40@ha
	lwz 0,gi+12@l(9)
	la 4,.LC40@l(4)
	mr 3,29
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(29)
	lis 11,level+4@ha
	lis 10,.LC86@ha
	la 10,.LC86@l(10)
	stw 30,3848(9)
	lfs 0,level+4@l(11)
	lfd 13,0(10)
	lwz 10,84(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3852(10)
	lwz 9,84(29)
	stw 30,3844(9)
	lwz 11,84(29)
	stw 28,3856(11)
	b .L292
.L481:
	lis 9,gi+12@ha
	lis 4,.LC41@ha
	lwz 0,gi+12@l(9)
	la 4,.LC41@l(4)
	mr 3,29
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(29)
	stw 31,3848(9)
	lwz 0,184(29)
	lwz 9,84(29)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	stw 31,3844(9)
	b .L292
.L477:
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 12,2,.L292
	lis 9,gi+12@ha
	lis 4,.LC83@ha
	lwz 0,gi+12@l(9)
	mr 3,29
	la 4,.LC83@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L292
.L491:
	stw 11,736(8)
	b .L292
.L492:
	stw 8,736(7)
	b .L292
.L476:
	mr 3,29
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L292:
	lwz 0,52(1)
	mtlr 0
	lmw 25,12(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 ClientCommand,.Lfe10-ClientCommand
	.comm	highscore,1080,4
	.comm	gamescore,540,4
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
	lwz 0,3516(8)
	cmpwi 0,0,0
	bc 12,2,.L52
	bl PMenu_Next
	b .L50
.L52:
	lwz 0,3832(8)
	cmpwi 0,0,0
	bc 12,2,.L54
	bl ChaseNext
	b .L50
.L509:
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
	bc 12,2,.L60
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L60
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L509
.L60:
	addi 7,7,1
	bdnz .L510
	li 0,-1
	stw 0,736(8)
.L50:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 ValidateSelectedItem,.Lfe11-ValidateSelectedItem
	.comm	configloc,50,4
	.comm	cycleloc,50,4
	.comm	scoreboard,4,4
	.comm	GlobalFragLimit,5,4
	.comm	GlobalTimeLimit,5,4
	.comm	GlobalGravity,5,4
	.comm	QWLOG,4,4
	.comm	directory,40,4
	.comm	recordLOG,2,4
	.comm	ModelGenDir,50,4
	.comm	obitsDir,50,4
	.comm	HIGHSCORE_DIR,50,4
	.comm	PLAYERS_LOGFILE,50,4
	.comm	MAX_CLIENT_RATE_STRING,10,4
	.comm	MAX_CLIENT_RATE,4,4
	.comm	clientlog,4,4
	.comm	showed,4,4
	.comm	rankhud,4,4
	.comm	playershud,4,4
	.comm	timehud,4,4
	.comm	cloakgrapple,4,4
	.comm	hookcolor,4,4
	.comm	allowgrapple,4,4
	.comm	HOOK_TIME,4,4
	.comm	HOOK_SPEED,4,4
	.comm	EXPERT_SKY_SOLID,4,4
	.comm	HOOK_DAMAGE,4,4
	.comm	PULL_SPEED,4,4
	.comm	LoseQ,4,4
	.comm	LoseQ_Fragee,4,4
	.comm	ConfigRD,4,4
	.comm	CRD,4,4
	.comm	rocketSpeed,4,4
	.comm	Q_Killer,4,4
	.comm	Q_Killee,4,4
	.comm	CF_StartHealth,4,4
	.comm	CF_MaxHealth,4,4
	.comm	MA_Bullets,4,4
	.comm	MA_Shells,4,4
	.comm	MA_Cells,4,4
	.comm	MA_Grenades,4,4
	.comm	MA_Rockets,4,4
	.comm	MA_Slugs,4,4
	.comm	SA_Bullets,4,4
	.comm	SA_Shells,4,4
	.comm	SA_Cells,4,4
	.comm	SA_Grenades,4,4
	.comm	SA_Rockets,4,4
	.comm	SA_Slugs,4,4
	.comm	SI_QuadDamage,4,4
	.comm	SI_Invulnerability,4,4
	.comm	SI_Silencer,4,4
	.comm	SI_Rebreather,4,4
	.comm	SI_EnvironmentSuit,4,4
	.comm	SI_PowerScreen,4,4
	.comm	SI_PowerShield,4,4
	.comm	QuadDamageTime,4,4
	.comm	RebreatherTime,4,4
	.comm	EnvironmentSuitTime,4,4
	.comm	InvulnerabilityTime,4,4
	.comm	SilencerShots,4,4
	.comm	RegenInvulnerability,4,4
	.comm	RegenInvulnerabilityTime,4,4
	.comm	AutoUseQuad,4,4
	.comm	AutoUseInvulnerability,4,4
	.comm	SW_Blaster,4,4
	.comm	SW_ShotGun,4,4
	.comm	SW_SuperShotGun,4,4
	.comm	SW_MachineGun,4,4
	.comm	SW_ChainGun,4,4
	.comm	SW_GrenadeLauncher,4,4
	.comm	SW_RocketLauncher,4,4
	.comm	SW_HyperBlaster,4,4
	.comm	SW_RailGun,4,4
	.comm	SW_BFG10K,4,4
	.comm	rocketspeed,4,4
	.comm	RadiusDamage,4,4
	.comm	DamageRadius,4,4
	.comm	GLauncherTimer,4,4
	.comm	GLauncherFireDistance,4,4
	.comm	GLauncherDamage,4,4
	.comm	GLauncherRadius,4,4
	.comm	GRENADE_TIMER,4,4
	.comm	GRENADE_MINSPEED,4,4
	.comm	GRENADE_MAXSPEED,4,4
	.comm	GrenadeTimer,4,4
	.comm	GrenadeMinSpeed,4,4
	.comm	GrenadeMaxSpeed,4,4
	.comm	GrenadeDamage,4,4
	.comm	GrenadeRadius,4,4
	.comm	HyperBlasterDamage,4,4
	.comm	BlasterProjectileSpeed,4,4
	.comm	BlasterDamage,4,4
	.comm	MachinegunDamage,4,4
	.comm	MachinegunKick,4,4
	.comm	ChaingunDamage,4,4
	.comm	ChaingunKick,4,4
	.comm	ShotgunDamage,4,4
	.comm	ShotgunKick,4,4
	.comm	SuperShotgunDamage,4,4
	.comm	SuperShotgunKick,4,4
	.comm	RailgunDamage,4,4
	.comm	RailgunKick,4,4
	.comm	BFGDamage,4,4
	.comm	BFGDamageRadius,4,4
	.comm	BFGProjectileSpeed,4,4
	.comm	namebanning,4,4
	.comm	bandirectory,50,4
	.comm	ingamenamebanningstate,4,4
	.comm	wasbot,4,4
	.comm	ban_BFG,4,4
	.comm	ban_hyperblaster,4,4
	.comm	ban_rocketlauncher,4,4
	.comm	ban_railgun,4,4
	.comm	ban_chaingun,4,4
	.comm	ban_machinegun,4,4
	.comm	ban_shotgun,4,4
	.comm	ban_supershotgun,4,4
	.comm	ban_grenadelauncher,4,4
	.comm	matchfullnamevalue,4,4
	.comm	fullnamevalue,4,4
	.comm	fastrailgun,4,4
	.comm	fastrocketfire,4,4
	.comm	cloaking,4,4
	.comm	CLOAK_DRAIN,4,4
	.comm	chasekeepscore,4,4
	.comm	fastchange,4,4
	.comm	fraghit,4,4
	.comm	somevar0,30,4
	.comm	somevar1,30,4
	.comm	somevar2,30,4
	.comm	somevar3,30,4
	.comm	somevar4,30,4
	.comm	somevar5,30,4
	.comm	somevar6,30,4
	.comm	somevar7,30,4
	.comm	somevar8,30,4
	.comm	somevar9,30,4
	.comm	somevar10,30,4
	.comm	somevar11,30,4
	.comm	somevar12,30,4
	.comm	somevar13,30,4
	.comm	somevar14,30,4
	.comm	totalrank,4,4
	.comm	hi_head1,60,4
	.comm	hi_head2,60,4
	.comm	hi_line1,60,4
	.comm	hi_line2,60,4
	.comm	hi_line3,60,4
	.comm	hi_line4,60,4
	.comm	hi_line5,60,4
	.comm	hi_line6,60,4
	.comm	hi_line7,60,4
	.comm	hi_line8,60,4
	.comm	hi_line9,60,4
	.comm	hi_line10,60,4
	.comm	hi_line11,60,4
	.comm	hi_line12,60,4
	.comm	hi_line13,60,4
	.comm	hi_line14,60,4
	.comm	hi_line15,60,4
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
	bc 12,2,.L512
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
	bc 12,2,.L512
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L9
	addi 3,3,1
	b .L511
.L9:
	stb 30,0(3)
.L512:
	mr 3,31
.L511:
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
	lwz 0,3516(8)
	cmpwi 0,0,0
	bc 12,2,.L27
	bl PMenu_Next
	b .L26
.L27:
	lwz 0,3832(8)
	cmpwi 0,0,0
	bc 12,2,.L28
	bl ChaseNext
	b .L26
.L513:
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
.L514:
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
	bc 4,2,.L513
.L32:
	addi 7,7,1
	bdnz .L514
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
	lwz 0,3516(7)
	cmpwi 0,0,0
	bc 12,2,.L39
	bl PMenu_Prev
	b .L38
.L39:
	lwz 0,3832(7)
	cmpwi 0,0,0
	bc 12,2,.L40
	bl ChasePrev
	b .L38
.L515:
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
.L516:
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
	bc 4,2,.L515
.L44:
	addi 11,11,-1
	bdnz .L516
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
.LC87:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC87@ha
	lis 9,deathmatch@ha
	la 11,.LC87@l(11)
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
.LC88:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC88@ha
	lis 9,deathmatch@ha
	la 11,.LC88@l(11)
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
.LC89:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC89@ha
	lis 9,deathmatch@ha
	la 11,.LC89@l(11)
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
	lis 5,.LC20@ha
	mr 3,31
	la 5,.LC20@l(5)
	b .L517
.L130:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L131
	lwz 0,8(29)
	lis 5,.LC21@ha
	mr 3,31
	la 5,.LC21@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L129
.L131:
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
	bc 4,2,.L132
	lwz 0,8(29)
	lis 5,.LC22@ha
	mr 3,31
	la 5,.LC22@l(5)
.L517:
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
	mr 31,3
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L133
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 30,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L135
	lwz 0,8(29)
	lis 5,.LC20@ha
	mr 3,31
	la 5,.LC20@l(5)
	b .L518
.L135:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L136
	lwz 0,8(29)
	lis 5,.LC23@ha
	mr 3,31
	la 5,.LC23@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L133
.L136:
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
	bc 4,2,.L137
	lwz 0,8(29)
	lis 5,.LC22@ha
	mr 3,31
	la 5,.LC22@l(5)
.L518:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L133
.L137:
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
	bc 12,2,.L170
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,29,740
	mullw 9,9,0
	srawi 27,9,3
.L175:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L174
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L174
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L174
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L170
.L174:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L175
.L170:
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
	bc 12,2,.L181
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	mr 25,9
	li 28,1
	subf 9,9,11
	addi 26,29,740
	mullw 9,9,0
	srawi 9,9,3
	addi 30,9,255
.L186:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L185
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L185
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L185
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L181
.L185:
	addi 28,28,1
	addi 30,30,-1
	cmpwi 0,28,256
	bc 4,1,.L186
.L181:
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
	bc 12,2,.L192
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L192
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
	bc 12,2,.L192
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L192
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L192
	mtlr 9
	blrl
.L192:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 Cmd_WeapLast_f,.Lfe22-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC90:
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
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L219
	lwz 11,84(31)
	lis 9,level+4@ha
	lis 10,.LC90@ha
	lfs 0,level+4@l(9)
	la 10,.LC90@l(10)
	lfs 13,3812(11)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L219
	lwz 0,264(31)
	li 9,0
	lis 10,meansOfDeath@ha
	stw 9,480(31)
	li 11,23
	lis 6,0x1
	rlwinm 0,0,0,28,26
	lis 7,vec3_origin@ha
	stw 0,264(31)
	la 7,vec3_origin@l(7)
	stw 11,meansOfDeath@l(10)
	mr 4,31
	mr 5,31
	ori 6,6,34464
	bl player_die
	li 0,2
	mr 3,31
	stw 0,492(31)
	bl respawn
.L219:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
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
	li 0,0
	lwz 9,84(31)
	stw 0,3508(9)
	lwz 11,84(31)
	stw 0,3524(11)
	lwz 9,84(31)
	stw 0,3520(9)
	lwz 11,84(31)
	lwz 0,3516(11)
	cmpwi 0,0,0
	bc 12,2,.L223
	bl PMenu_Close
.L223:
	lwz 9,84(31)
	li 0,1
	stw 0,3836(9)
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
	mulli 9,9,3888
	mulli 11,3,3888
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
	.section	".rodata"
	.align 3
.LC91:
	.long 0x3ff80000
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Cloak_f
	.type	 Cmd_Cloak_f,@function
Cmd_Cloak_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L252
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L252
	lwz 9,84(31)
	lwz 0,3840(9)
	xori 30,0,1
	cmpwi 0,30,0
	stw 30,3840(9)
	bc 12,2,.L255
	lis 9,gi+12@ha
	lis 4,.LC40@ha
	lwz 0,gi+12@l(9)
	la 4,.LC40@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,1
	lis 9,level+4@ha
	lis 10,.LC91@ha
	stw 0,3848(11)
	la 10,.LC91@l(10)
	lfs 0,level+4@l(9)
	lfd 13,0(10)
	lwz 11,84(31)
	li 10,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,3852(11)
	lwz 9,84(31)
	stw 0,3844(9)
	lwz 11,84(31)
	stw 10,3856(11)
	b .L252
.L255:
	lis 9,gi+12@ha
	lis 4,.LC41@ha
	lwz 0,gi+12@l(9)
	la 4,.LC41@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	stw 30,3848(9)
	lwz 0,184(31)
	lwz 9,84(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	stw 30,3844(9)
.L252:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe26:
	.size	 Cmd_Cloak_f,.Lfe26-Cmd_Cloak_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
