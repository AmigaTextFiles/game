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
	mr 30,3
	mr 29,4
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
	li 28,0
	la 31,value.6@l(9)
	stb 28,value.6@l(9)
	mr 3,30
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L23
	lwz 3,84(30)
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	addi 3,3,188
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
	stb 28,0(3)
.L23:
	mr 3,31
	b .L13
.L15:
	addi 3,3,1
.L13:
	mr 4,3
	li 28,0
	addi 3,1,8
	bl strcpy
	lis 9,value.6@ha
	addi 30,1,520
	mr 3,29
	la 31,value.6@l(9)
	stb 28,value.6@l(9)
	bl G_ClientExists
	mr 27,30
	cmpwi 0,3,0
	bc 12,2,.L25
	lwz 3,84(29)
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	addi 3,3,188
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
	stb 28,0(3)
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
	lis 9,sv_cheats@ha
	lis 10,.LC13@ha
	lwz 11,sv_cheats@l(9)
	la 10,.LC13@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L59
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L58
.L59:
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
	bc 4,2,.L63
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
	bc 4,2,.L62
.L63:
	lwz 9,156(28)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L64
	lwz 0,160(28)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	stw 3,480(31)
	b .L65
.L64:
	lwz 0,484(31)
	stw 0,480(31)
.L65:
	cmpwi 4,27,0
	bc 12,18,.L58
.L62:
	bc 4,18,.L68
	lis 4,.LC4@ha
	mr 3,30
	la 4,.LC4@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L67
.L68:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L70
	lis 9,itemlist@ha
	mr 7,11
	la 8,itemlist@l(9)
	li 10,0
.L72:
	mr 27,8
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L71
	lwz 0,56(27)
	andi. 9,0,1
	bc 12,2,.L71
	lwz 11,84(31)
	addi 11,11,740
	lwzx 9,11,10
	addi 9,9,1
	stwx 9,11,10
.L71:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 8,8,76
	cmpw 0,29,0
	bc 12,0,.L72
.L70:
	bc 12,18,.L58
.L67:
	bc 4,18,.L78
	lis 4,.LC5@ha
	mr 3,30
	la 4,.LC5@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L77
.L78:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L80
	lis 9,itemlist@ha
	mr 26,11
	la 28,itemlist@l(9)
.L82:
	mr 27,28
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L81
	lwz 0,56(27)
	andi. 9,0,2
	bc 12,2,.L81
	mr 4,27
	mr 3,31
	li 5,1000
	bl Add_Ammo
.L81:
	lwz 0,1556(26)
	addi 29,29,1
	addi 28,28,76
	cmpw 0,29,0
	bc 12,0,.L82
.L80:
	bc 12,18,.L58
.L77:
	bc 4,18,.L88
	lis 4,.LC6@ha
	mr 3,30
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L87
.L88:
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
	bc 12,18,.L58
.L87:
	bc 4,18,.L91
	lis 4,.LC10@ha
	mr 3,30
	la 4,.LC10@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L90
.L91:
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
	bc 12,2,.L92
	mr 3,29
	bl G_FreeEdict
.L92:
	bc 12,18,.L58
.L90:
	bc 12,18,.L94
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L58
	lis 9,itemlist@ha
	mr 7,11
	la 11,itemlist@l(9)
	li 8,1
	li 10,0
.L98:
	lwz 0,4(11)
	cmpwi 0,0,0
	bc 12,2,.L97
	lwz 0,56(11)
	andi. 9,0,7
	bc 4,2,.L97
	lwz 9,84(31)
	addi 9,9,740
	stwx 8,9,10
.L97:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 11,11,76
	cmpw 0,29,0
	bc 12,0,.L98
	b .L58
.L94:
	mr 3,30
	bl FindItem
	mr. 27,3
	bc 4,2,.L102
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	bl FindItem
	mr. 27,3
	bc 4,2,.L102
	lwz 0,4(29)
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	b .L110
.L102:
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 4,2,.L104
	lis 9,gi+4@ha
	lis 3,.LC12@ha
	lwz 0,gi+4@l(9)
	la 3,.LC12@l(3)
.L110:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L58
.L104:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,56(27)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,27
	andi. 10,11,2
	mullw 9,9,0
	srawi 28,9,2
	bc 12,2,.L105
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L106
	lwz 0,160(29)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	slwi 0,28,2
	addi 9,9,740
	stwx 3,9,0
	b .L58
.L106:
	lwz 9,84(31)
	slwi 10,28,2
	lwz 11,48(27)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L58
.L105:
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
	bc 12,2,.L58
	mr 3,29
	bl G_FreeEdict
.L58:
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
	.string	"Grenades"
	.align 2
.LC21:
	.string	"grenades"
	.align 2
.LC22:
	.string	"Normal grenades\n"
	.align 2
.LC23:
	.string	"Special grenades\n"
	.align 2
.LC24:
	.string	"unknown item: %s\n"
	.align 2
.LC25:
	.string	"Item is not usable.\n"
	.align 2
.LC26:
	.string	"Out of item: %s\n"
	.align 2
.LC27:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Use_f
	.type	 Cmd_Use_f,@function
Cmd_Use_f:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 27,gi@l(9)
	lwz 9,164(27)
	mtlr 9
	blrl
	mr 28,3
	bl FindItem
	mr 30,3
	lwz 29,84(31)
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	bl FindItem
	lwz 0,1788(29)
	cmpw 0,0,3
	bc 4,2,.L124
	lis 4,.LC21@ha
	mr 3,28
	la 4,.LC21@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L124
	lwz 9,84(31)
	lis 11,.LC27@ha
	la 11,.LC27@l(11)
	lfs 13,0(11)
	lfs 0,2216(9)
	fcmpu 0,0,13
	bc 4,2,.L124
	lwz 0,892(31)
	cmpwi 0,0,0
	bc 12,2,.L124
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L124
	lwz 0,2260(9)
	cmpwi 0,0,1
	bc 4,2,.L126
	stw 3,2260(9)
	lis 5,.LC22@ha
	li 4,2
	lwz 0,8(27)
	mr 3,31
	la 5,.LC22@l(5)
	b .L131
.L126:
	li 0,1
	lis 5,.LC23@ha
	stw 0,2260(9)
	mr 3,31
	la 5,.LC23@l(5)
	lwz 0,8(27)
	b .L132
.L124:
	cmpwi 0,30,0
	bc 4,2,.L128
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC24@l(5)
	b .L133
.L128:
	lwz 10,8(30)
	cmpwi 0,10,0
	bc 4,2,.L129
	lis 9,gi+8@ha
	lis 5,.LC25@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC25@l(5)
.L132:
	li 4,2
.L131:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L123
.L129:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,30
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L130
	lis 9,gi+8@ha
	lis 5,.LC26@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC26@l(5)
.L133:
	mr 6,28
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L123
.L130:
	mr 3,31
	mr 4,30
	mtlr 10
	blrl
.L123:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 Cmd_Use_f,.Lfe3-Cmd_Use_f
	.section	".rodata"
	.align 2
.LC28:
	.string	"Item is not dropable.\n"
	.align 2
.LC29:
	.string	"No item to use.\n"
	.section	".text"
	.align 2
	.globl Cmd_InvUse_f
	.type	 Cmd_InvUse_f,@function
Cmd_InvUse_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 7,84(31)
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L150
	lwz 0,1932(7)
	cmpwi 0,0,0
	bc 12,2,.L151
	bl Menu_Dn
	b .L150
.L164:
	stw 11,736(7)
	b .L150
.L151:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L165:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L157
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L157
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L164
.L157:
	addi 8,8,1
	bdnz .L165
	li 0,-1
	stw 0,736(7)
.L150:
	lwz 9,84(31)
	lwz 30,1932(9)
	cmpwi 0,30,0
	bc 12,2,.L161
	mr 3,31
	bl Menu_Sel
	b .L148
.L161:
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L162
	lis 9,gi+8@ha
	lis 5,.LC29@ha
	lwz 0,gi+8@l(9)
	la 5,.LC29@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	stw 30,736(9)
	b .L148
.L162:
	mulli 0,0,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L163
	lis 9,gi+8@ha
	lis 5,.LC25@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC25@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L148
.L163:
	mr 3,31
	mtlr 0
	blrl
.L148:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 Cmd_InvUse_f,.Lfe4-Cmd_InvUse_f
	.section	".rodata"
	.align 2
.LC30:
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
	lwz 7,84(31)
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L196
	lwz 0,1932(7)
	cmpwi 0,0,0
	bc 12,2,.L197
	bl Menu_Dn
	b .L196
.L209:
	stw 11,736(7)
	b .L196
.L197:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L210:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L203
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L203
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L209
.L203:
	addi 8,8,1
	bdnz .L210
	li 0,-1
	stw 0,736(7)
.L196:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L207
	lis 9,gi+8@ha
	lis 5,.LC30@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC30@l(5)
	b .L211
.L207:
	mulli 0,0,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L208
	lis 9,gi+8@ha
	lis 5,.LC28@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC28@l(5)
.L211:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L194
.L208:
	mr 3,31
	mtlr 0
	blrl
.L194:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_InvDrop_f,.Lfe5-Cmd_InvDrop_f
	.section	".rodata"
	.align 2
.LC31:
	.string	"%s kicked for suiciding\n"
	.align 2
.LC32:
	.string	"disconnect\n"
	.align 2
.LC33:
	.string	"%3i %s\n"
	.align 2
.LC34:
	.string	"...\n"
	.align 2
.LC35:
	.string	"%s\n%i players\n"
	.align 2
.LC36:
	.long 0x0
	.align 3
.LC37:
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
	lis 11,.LC36@ha
	lis 9,maxclients@ha
	la 11,.LC36@l(11)
	mr 23,3
	lfs 13,0(11)
	li 27,0
	li 31,0
	lwz 11,maxclients@l(9)
	addi 29,1,1352
	addi 30,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L223
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L225:
	lwz 0,0(11)
	addi 11,11,2288
	cmpwi 0,0,0
	bc 12,2,.L224
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L224:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L225
.L223:
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
	bc 4,0,.L229
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC33@ha
	lis 25,.LC34@ha
.L231:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC33@l(26)
	addi 28,28,4
	mulli 7,7,2288
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
	bc 4,1,.L232
	la 4,.LC34@l(25)
	mr 3,30
	bl strcat
	b .L229
.L232:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L231
.L229:
	lis 9,gi+8@ha
	lis 5,.LC35@ha
	lwz 0,gi+8@l(9)
	mr 3,23
	la 5,.LC35@l(5)
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
.LC38:
	.string	"flipoff\n"
	.align 2
.LC39:
	.string	"salute\n"
	.align 2
.LC40:
	.string	"taunt\n"
	.align 2
.LC41:
	.string	"wave\n"
	.align 2
.LC42:
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
	bc 4,2,.L234
	lwz 0,2184(9)
	cmpwi 0,0,1
	bc 12,1,.L234
	cmplwi 0,3,4
	li 0,1
	stw 0,2184(9)
	bc 12,1,.L243
	lis 11,.L244@ha
	slwi 10,3,2
	la 11,.L244@l(11)
	lis 9,.L244@ha
	lwzx 0,10,11
	la 9,.L244@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L244:
	.long .L238-.L244
	.long .L239-.L244
	.long .L240-.L244
	.long .L241-.L244
	.long .L243-.L244
.L238:
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
	li 0,71
	li 9,83
	b .L245
.L239:
	lis 9,gi+8@ha
	lis 5,.LC39@ha
	lwz 0,gi+8@l(9)
	la 5,.LC39@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,83
	li 9,94
	b .L245
.L240:
	lis 9,gi+8@ha
	lis 5,.LC40@ha
	lwz 0,gi+8@l(9)
	la 5,.LC40@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,94
	li 9,111
	b .L245
.L241:
	lis 9,gi+8@ha
	lis 5,.LC41@ha
	lwz 0,gi+8@l(9)
	la 5,.LC41@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,111
	li 9,122
	b .L245
.L243:
	lis 9,gi+8@ha
	lis 5,.LC42@ha
	lwz 0,gi+8@l(9)
	la 5,.LC42@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,122
	li 9,134
.L245:
	stw 0,56(31)
	stw 9,2180(11)
.L234:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 Cmd_Wave_f,.Lfe7-Cmd_Wave_f
	.section	".rodata"
	.align 2
.LC43:
	.string	"xv 32 yv 8 picn inventory "
	.align 2
.LC44:
	.string	"xv 52 yv 36 string2 Name:\n"
	.align 2
.LC45:
	.string	"xv 52 yv 54 %16s\n"
	.align 2
.LC46:
	.string	"xv 52 yv 66 string2 Class:\n"
	.align 2
.LC47:
	.string	"xv 52 yv 75 friendly %16s\n"
	.align 3
.LC48:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC49:
	.long 0x46000000
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
	lwz 0,508(31)
	lis 11,0x4330
	lis 10,.LC48@ha
	la 10,.LC48@l(10)
	lfs 13,12(31)
	addi 28,1,536
	xoris 0,0,0x8000
	lfd 11,0(10)
	addi 27,1,520
	stw 0,644(1)
	addi 29,1,552
	li 6,0
	stw 11,640(1)
	mr 4,28
	li 5,0
	lfd 0,640(1)
	lfs 10,4(31)
	lfs 12,8(31)
	fsub 0,0,11
	lwz 3,84(31)
	stfs 10,520(1)
	stfs 12,524(1)
	addi 3,3,2124
	frsp 0,0
	fadds 13,13,0
	stfs 13,528(1)
	bl AngleVectors
	lis 9,.LC49@ha
	mr 4,28
	la 9,.LC49@l(9)
	mr 3,27
	lfs 1,0(9)
	mr 5,29
	bl VectorMA
	lis 11,gi@ha
	lis 9,0x600
	la 30,gi@l(11)
	ori 9,9,27
	lwz 11,48(30)
	mr 4,27
	mr 7,29
	addi 3,1,568
	li 5,0
	li 6,0
	mr 8,31
	mtlr 11
	blrl
	lwz 9,620(1)
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L247
	lis 9,.LC43@ha
	addi 29,1,8
	lwz 5,.LC43@l(9)
	lis 4,.LC44@ha
	mr 3,29
	la 9,.LC43@l(9)
	la 4,.LC44@l(4)
	lwz 0,4(9)
	lwz 11,8(9)
	lwz 10,12(9)
	lwz 8,16(9)
	lwz 7,20(9)
	lhz 6,24(9)
	lbz 28,26(9)
	stw 5,8(1)
	stw 0,4(29)
	stw 11,8(29)
	stw 10,12(29)
	stw 8,16(29)
	stw 7,20(29)
	sth 6,24(29)
	stb 28,26(29)
	crxor 6,6,6
	bl strcat_
	lwz 9,620(1)
	lis 4,.LC45@ha
	mr 3,29
	la 4,.LC45@l(4)
	lwz 5,84(9)
	addi 5,5,700
	crxor 6,6,6
	bl strcat_
	lwz 9,620(1)
	lis 4,.LC46@ha
	mr 3,29
	la 4,.LC46@l(4)
	lwz 5,84(9)
	addi 5,5,700
	crxor 6,6,6
	bl strcat_
	lwz 9,620(1)
	lis 4,.LC47@ha
	mr 3,29
	la 4,.LC47@l(4)
	lwz 5,1084(9)
	crxor 6,6,6
	bl strcat_
.L247:
	lwz 11,84(31)
	li 0,1
	li 10,0
	li 3,4
	stw 0,1936(11)
	lwz 9,84(31)
	stw 10,1920(9)
	lwz 9,100(30)
	mtlr 9
	blrl
	lwz 9,116(30)
	addi 3,1,8
	mtlr 9
	blrl
	lwz 0,92(30)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	lwz 0,676(1)
	mtlr 0
	lmw 27,652(1)
	la 1,672(1)
	blr
.Lfe8:
	.size	 Cmd_id_f,.Lfe8-Cmd_id_f
	.section	".rodata"
	.align 2
.LC50:
	.string	"You can't talk for %i more seconds..\n"
	.align 2
.LC51:
	.string	"(%s): "
	.align 2
.LC52:
	.string	"%s: "
	.align 2
.LC53:
	.string	" "
	.align 2
.LC54:
	.string	"\n"
	.align 2
.LC55:
	.string	"%s"
	.align 2
.LC56:
	.long 0x3f800000
	.align 2
.LC57:
	.long 0x41f00000
	.align 2
.LC58:
	.long 0x0
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
	mr 29,4
	mr 30,5
	li 31,0
	mtlr 0
	blrl
	cmpwi 0,3,1
	bc 12,1,.L249
	cmpwi 0,30,0
	bc 12,2,.L248
.L249:
	lwz 0,928(28)
	andi. 9,0,8
	bc 4,2,.L248
	lwz 0,492(28)
	cmpwi 0,0,2
	bc 12,2,.L248
	lwz 11,84(28)
	lis 9,level@ha
	la 9,level@l(9)
	lfs 12,4(9)
	lfs 0,2248(11)
	fcmpu 0,0,12
	bc 12,1,.L252
	lwz 0,2252(11)
	cmpwi 0,0,2
	bc 4,1,.L252
	lis 10,.LC56@ha
	lfs 0,2256(11)
	la 10,.LC56@l(10)
	lfs 13,0(10)
	fadds 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L252
	lis 10,.LC57@ha
	la 10,.LC57@l(10)
	lfs 0,0(10)
	fadds 0,12,0
	stfs 0,2248(11)
	lfs 13,4(9)
	lwz 9,84(28)
	stfs 13,2256(9)
	lwz 11,84(28)
	stw 31,2252(11)
.L252:
	lwz 6,84(28)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,2248(6)
	fcmpu 0,0,13
	bc 4,1,.L254
	fsubs 0,0,13
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC50@ha
	mr 3,28
	la 5,.LC50@l(5)
	li 4,2
	mtlr 0
	fctiwz 13,0
	stfd 13,2064(1)
	lwz 31,2068(1)
	mr 6,31
	crxor 6,6,6
	blrl
	b .L248
.L254:
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,2064(1)
	lwz 9,2068(1)
	rlwinm 9,9,0,24,25
	neg 9,9
	srawi 9,9,31
	and. 27,29,9
	bc 12,2,.L256
	lis 5,.LC51@ha
	addi 6,6,700
	la 5,.LC51@l(5)
	addi 3,1,8
	li 4,2048
	crxor 6,6,6
	bl Com_sprintf
	b .L257
.L256:
	lis 5,.LC52@ha
	addi 6,6,700
	la 5,.LC52@l(5)
	addi 3,1,8
	li 4,2048
	crxor 6,6,6
	bl Com_sprintf
.L257:
	cmpwi 0,30,0
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
	lis 4,.LC53@ha
	addi 3,1,8
	la 4,.LC53@l(4)
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
	stb 30,-1(3)
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
	lis 4,.LC54@ha
	addi 3,1,8
	la 4,.LC54@l(4)
	bl strcat
	lis 9,.LC58@ha
	lis 11,dedicated@ha
	la 9,.LC58@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L262
	lis 9,gi+8@ha
	lis 5,.LC55@ha
	lwz 0,gi+8@l(9)
	la 5,.LC55@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L262:
	lis 9,game@ha
	li 31,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,31,0
	bc 12,1,.L264
	cmpwi 4,27,0
	lis 9,gi@ha
	la 24,gi@l(9)
	mr 25,11
	lis 26,g_edicts@ha
	lis 27,.LC55@ha
	li 30,1116
.L266:
	lwz 0,g_edicts@l(26)
	add 29,0,30
	mr 3,29
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L265
	bc 12,18,.L268
	mr 3,28
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L265
.L268:
	lwz 9,8(24)
	mr 3,29
	li 4,3
	la 5,.LC55@l(27)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L265:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,1116
	cmpw 0,31,0
	bc 4,1,.L266
.L264:
	lis 9,.LC56@ha
	lwz 11,84(28)
	lis 10,level+4@ha
	la 9,.LC56@l(9)
	lfs 13,0(9)
	lwz 9,2252(11)
	addi 9,9,1
	stw 9,2252(11)
	lwz 3,84(28)
	lfs 12,level+4@l(10)
	lfs 0,2256(3)
	fadds 0,0,13
	fcmpu 0,0,12
	bc 4,0,.L248
	stfs 12,2256(3)
.L248:
	lwz 0,2116(1)
	lwz 12,2076(1)
	mtlr 0
	lmw 24,2080(1)
	mtcrf 8,12
	la 1,2112(1)
	blr
.Lfe9:
	.size	 Cmd_Say_f,.Lfe9-Cmd_Say_f
	.section	".rodata"
	.align 2
.LC59:
	.string	"menu_class\n"
	.align 2
.LC60:
	.string	"spectator 1\n"
	.lcomm	st.82,100,4
	.section	".text"
	.align 2
	.globl strcpy_
	.type	 strcpy_,@function
strcpy_:
	stwu 1,-160(1)
	mflr 0
	stmw 29,148(1)
	stw 0,164(1)
	lis 12,0x200
	addi 0,1,168
	stw 5,16(1)
	addi 11,1,8
	stw 0,132(1)
	mr 31,3
	stw 11,136(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	stw 12,128(1)
	bc 4,6,.L279
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L279:
	addi 11,1,128
	addi 9,1,112
	lwz 10,8(11)
	lis 29,st.82@ha
	mr 5,9
	lwz 0,4(11)
	la 3,st.82@l(29)
	stw 12,112(1)
	stw 0,4(9)
	stw 10,8(9)
	bl vsprintf
	mr 3,31
	la 4,st.82@l(29)
	bl strcpy
	lwz 0,164(1)
	mtlr 0
	lmw 29,148(1)
	la 1,160(1)
	blr
.Lfe10:
	.size	 strcpy_,.Lfe10-strcpy_
	.section	".sbss","aw",@nobits
	.align 2
num1.86:
	.space	4
	.size	 num1.86,4
	.align 2
num2.87:
	.space	4
	.size	 num2.87,4
	.align 2
i.88:
	.space	4
	.size	 i.88,4
	.lcomm	team1.89,32,4
	.lcomm	team2.90,32,4
	.section	".rodata"
	.align 2
.LC61:
	.string	"Select your team"
	.align 2
.LC62:
	.string	"Red Team  (%d players)"
	.align 2
.LC63:
	.string	"Blue Team (%d players)"
	.align 2
.LC64:
	.string	"Chase camera"
	.align 2
.LC65:
	.long 0x0
	.align 3
.LC66:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_Team_f
	.type	 Cmd_Team_f,@function
Cmd_Team_f:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 23,36(1)
	stw 0,84(1)
	mr 31,3
	li 10,0
	lwz 8,84(31)
	lis 9,num1.86@ha
	lis 11,num2.87@ha
	stw 10,num1.86@l(9)
	lwz 0,1820(8)
	stw 10,num2.87@l(11)
	cmpwi 0,0,0
	bc 12,1,.L280
	lwz 0,1916(8)
	cmpwi 0,0,0
	bc 4,2,.L280
	lwz 0,1920(8)
	cmpwi 0,0,0
	bc 4,2,.L280
	lwz 0,1932(8)
	cmpwi 0,0,0
	bc 4,2,.L280
	lwz 0,1936(8)
	cmpwi 0,0,0
	bc 4,2,.L280
	lis 9,maxclients@ha
	lis 11,.LC65@ha
	lwz 10,maxclients@l(9)
	la 11,.LC65@l(11)
	lis 23,i.88@ha
	lfs 13,0(11)
	lis 24,maxclients@ha
	lfs 0,20(10)
	lis 11,i.88@ha
	stw 0,i.88@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L285
	lis 9,.LC66@ha
	lis 25,g_edicts@ha
	la 9,.LC66@l(9)
	lis 27,num1.86@ha
	lfd 31,0(9)
	lis 30,num2.87@ha
	lis 28,i.88@ha
	lis 26,0x4330
.L287:
	lwz 0,i.88@l(23)
	lwz 9,g_edicts@l(25)
	mulli 0,0,1116
	add 29,9,0
	mr 3,29
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L286
	lwz 9,84(29)
	lwz 3,1820(9)
	cmpwi 0,3,1
	bc 4,2,.L289
	lwz 9,num1.86@l(27)
	addi 9,9,1
	stw 9,num1.86@l(27)
	b .L286
.L289:
	cmpwi 0,3,2
	bc 4,2,.L286
	lwz 9,num2.87@l(30)
	addi 9,9,1
	stw 9,num2.87@l(30)
.L286:
	lwz 11,i.88@l(28)
	lwz 10,maxclients@l(24)
	addi 11,11,1
	xoris 0,11,0x8000
	lfs 13,20(10)
	stw 0,28(1)
	stw 26,24(1)
	lfd 0,24(1)
	stw 11,i.88@l(28)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L287
.L285:
	lis 10,ripflags@ha
	lwz 9,ripflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,4
	bc 12,2,.L293
	lis 9,num1.86@ha
	lis 11,num2.87@ha
	lwz 9,num1.86@l(9)
	lwz 0,num2.87@l(11)
	cmpw 0,9,0
	bc 4,1,.L294
	li 4,2
	b .L297
.L294:
	cmpw 0,0,9
	bc 4,1,.L293
	li 4,1
.L297:
	mr 3,31
	bl JoinTeam
	lis 4,.LC59@ha
	mr 3,31
	la 4,.LC59@l(4)
	bl stuffcmd
	b .L280
.L293:
	lis 4,.LC61@ha
	mr 3,31
	la 4,.LC61@l(4)
	lis 29,team1.89@ha
	bl Menu_Title
	lis 28,team2.90@ha
	lis 9,num1.86@ha
	lis 4,.LC62@ha
	lwz 5,num1.86@l(9)
	la 4,.LC62@l(4)
	la 3,team1.89@l(29)
	crxor 6,6,6
	bl strcpy_
	lis 9,num2.87@ha
	lis 4,.LC63@ha
	lwz 5,num2.87@l(9)
	la 4,.LC63@l(4)
	la 3,team2.90@l(28)
	crxor 6,6,6
	bl strcpy_
	la 4,team1.89@l(29)
	mr 3,31
	bl Menu_Add
	la 4,team2.90@l(28)
	mr 3,31
	bl Menu_Add
	lis 4,.LC64@ha
	mr 3,31
	la 4,.LC64@l(4)
	bl Menu_Add
	lwz 11,84(31)
	lis 9,MyTeam_Sel@ha
	mr 3,31
	la 9,MyTeam_Sel@l(9)
	stw 9,1996(11)
	bl Menu_Open
.L280:
	lwz 0,84(1)
	mtlr 0
	lmw 23,36(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe11:
	.size	 Cmd_Team_f,.Lfe11-Cmd_Team_f
	.section	".rodata"
	.align 2
.LC67:
	.string	"warrior\n"
	.align 2
.LC68:
	.string	"mage\n"
	.align 2
.LC69:
	.string	"thief\n"
	.align 2
.LC70:
	.string	"infantry\n"
	.align 2
.LC71:
	.string	"miner\n"
	.align 2
.LC72:
	.string	"scientist\n"
	.align 2
.LC73:
	.string	"flamer\n"
	.align 2
.LC74:
	.string	"trooper\n"
	.align 2
.LC75:
	.string	"ghost\n"
	.align 2
.LC76:
	.string	"custom\n"
	.section	".text"
	.align 2
	.globl MyClass_Sel
	.type	 MyClass_Sel,@function
MyClass_Sel:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	cmpwi 0,4,1
	bc 4,2,.L300
	lwz 0,892(3)
	cmpwi 0,0,0
	bc 4,2,.L301
	li 4,1
	bl ClassFunction
	b .L303
.L301:
	lis 4,.LC67@ha
	la 4,.LC67@l(4)
	bl stuffcmd
	b .L303
.L300:
	cmpwi 0,4,2
	bc 4,2,.L304
	lwz 0,892(3)
	cmpwi 0,0,0
	bc 4,2,.L305
	li 4,2
	bl ClassFunction
	b .L303
.L305:
	lis 4,.LC68@ha
	la 4,.LC68@l(4)
	bl stuffcmd
	b .L303
.L304:
	cmpwi 0,4,3
	bc 4,2,.L308
	lwz 0,892(3)
	cmpwi 0,0,0
	bc 4,2,.L309
	li 4,3
	bl ClassFunction
	b .L303
.L309:
	lis 4,.LC69@ha
	la 4,.LC69@l(4)
	bl stuffcmd
	b .L303
.L308:
	cmpwi 0,4,4
	bc 4,2,.L312
	lwz 0,892(3)
	cmpwi 0,0,0
	bc 4,2,.L313
	li 4,4
	bl ClassFunction
	b .L303
.L313:
	lis 4,.LC70@ha
	la 4,.LC70@l(4)
	bl stuffcmd
	b .L303
.L312:
	cmpwi 0,4,5
	bc 4,2,.L316
	lwz 0,892(3)
	cmpwi 0,0,0
	bc 4,2,.L317
	li 4,5
	bl ClassFunction
	b .L303
.L317:
	lis 4,.LC71@ha
	la 4,.LC71@l(4)
	bl stuffcmd
	b .L303
.L316:
	cmpwi 0,4,6
	bc 4,2,.L320
	lwz 0,892(3)
	cmpwi 0,0,0
	bc 4,2,.L321
	li 4,6
	bl ClassFunction
	b .L303
.L321:
	lis 4,.LC72@ha
	la 4,.LC72@l(4)
	bl stuffcmd
	b .L303
.L320:
	cmpwi 0,4,7
	bc 4,2,.L324
	lwz 0,892(3)
	cmpwi 0,0,0
	bc 4,2,.L325
	li 4,7
	bl ClassFunction
	b .L303
.L325:
	lis 4,.LC73@ha
	la 4,.LC73@l(4)
	bl stuffcmd
	b .L303
.L324:
	cmpwi 0,4,8
	bc 4,2,.L328
	lwz 0,892(3)
	cmpwi 0,0,0
	bc 4,2,.L329
	li 4,8
	bl ClassFunction
	b .L303
.L329:
	lis 4,.LC74@ha
	la 4,.LC74@l(4)
	bl stuffcmd
	b .L303
.L328:
	cmpwi 0,4,9
	bc 4,2,.L332
	lwz 0,892(3)
	cmpwi 0,0,0
	bc 4,2,.L333
	li 4,9
	bl ClassFunction
	b .L303
.L333:
	lis 4,.LC75@ha
	la 4,.LC75@l(4)
	bl stuffcmd
	b .L303
.L332:
	cmpwi 0,4,0
	bc 4,2,.L303
	lis 4,.LC76@ha
	la 4,.LC76@l(4)
	bl stuffcmd
.L303:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe12:
	.size	 MyClass_Sel,.Lfe12-MyClass_Sel
	.section	".rodata"
	.align 2
.LC77:
	.string	"Select your class"
	.align 2
.LC78:
	.string	"Warrior      "
	.align 2
.LC79:
	.string	"Necromancer  "
	.align 2
.LC80:
	.string	"Thief        "
	.align 2
.LC81:
	.string	"Infantry     "
	.align 2
.LC82:
	.string	"Miner        "
	.align 2
.LC83:
	.string	"Scientist    "
	.align 2
.LC84:
	.string	"Flamer       "
	.align 2
.LC85:
	.string	"Trooper      "
	.align 2
.LC86:
	.string	"Ghost        "
	.align 2
.LC87:
	.string	"Build        "
	.align 2
.LC88:
	.string	"You can't feign while chasing yourself.\n"
	.align 2
.LC89:
	.string	"You can feign on the top of another spy\n"
	.align 2
.LC90:
	.string	"You can't get up while someone\nis standing on you.\n\n"
	.align 2
.LC91:
	.string	"Something stands on you.\n"
	.align 2
.LC92:
	.string	"Somebody stands on you.\n"
	.align 2
.LC93:
	.long 0x42800000
	.align 2
.LC94:
	.long 0x41800000
	.align 2
.LC95:
	.long 0x41a00000
	.align 2
.LC96:
	.long 0x0
	.section	".text"
	.align 2
	.globl check_stand
	.type	 check_stand,@function
check_stand:
	stwu 1,-128(1)
	mflr 0
	stmw 28,112(1)
	stw 0,132(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,2264(9)
	cmpwi 0,0,0
	bc 12,2,.L355
	lis 9,gi+8@ha
	lis 5,.LC88@ha
	lwz 0,gi+8@l(9)
	la 5,.LC88@l(5)
	b .L369
.L355:
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 4,2,.L356
.L371:
	li 3,0
	b .L368
.L356:
	lwz 0,908(31)
	andi. 9,0,64
	bc 4,2,.L357
	lis 11,.LC93@ha
	li 3,0
	la 11,.LC93@l(11)
	addi 4,31,4
	lfs 1,0(11)
	bl findradius
	mr. 3,3
	bc 12,2,.L363
	cmpw 0,3,31
	bc 12,2,.L363
	lis 9,gi+8@ha
	lis 5,.LC89@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC89@l(5)
.L369:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L371
.L357:
	lis 9,gi@ha
	lis 11,.LC94@ha
	lfs 12,4(31)
	la 30,gi@l(9)
	la 11,.LC94@l(11)
	lfs 13,12(31)
	lis 9,.LC95@ha
	lfs 11,0(11)
	addi 28,1,40
	la 9,.LC95@l(9)
	lwz 11,48(30)
	addi 29,31,4
	lfs 0,0(9)
	mr 3,28
	mr 4,29
	fsubs 10,12,11
	lis 9,0x600
	li 5,0
	mtlr 11
	fadds 12,12,11
	ori 9,9,3
	li 6,0
	fadds 13,13,0
	addi 7,1,8
	mr 8,31
	lfs 0,8(31)
	stfs 10,24(1)
	stfs 13,32(1)
	stfs 0,28(1)
	stfs 0,12(1)
	stfs 13,16(1)
	stfs 12,8(1)
	blrl
	lis 9,.LC96@ha
	lfs 13,48(1)
	mr 4,29
	la 9,.LC96@l(9)
	mr 3,28
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L360
	lwz 9,92(1)
	cmpwi 0,9,0
	bc 12,2,.L360
	lwz 0,552(9)
	cmpwi 0,0,0
	bc 12,2,.L360
	lwz 0,400(9)
	cmpwi 0,0,0
	bc 12,2,.L371
	lwz 0,492(9)
	cmpwi 0,0,2
	bc 12,2,.L371
	lwz 0,8(30)
	lis 5,.LC90@ha
	mr 3,31
	la 5,.LC90@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L371
.L360:
	lis 11,gi@ha
	lis 9,0x600
	la 30,gi@l(11)
	ori 9,9,3
	lwz 11,48(30)
	li 5,0
	li 6,0
	addi 7,1,24
	mr 8,31
	mtlr 11
	blrl
	lis 9,.LC96@ha
	lfs 13,48(1)
	la 9,.LC96@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L363
	lwz 9,92(1)
	cmpwi 0,9,0
	bc 12,2,.L363
	lwz 0,552(9)
	cmpwi 0,0,0
	bc 12,2,.L363
	lwz 0,400(9)
	cmpwi 0,0,0
	bc 12,2,.L371
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 4,2,.L366
	lwz 0,8(30)
	lis 5,.LC91@ha
	mr 3,31
	la 5,.LC91@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L371
.L366:
	lwz 0,8(30)
	lis 5,.LC92@ha
	mr 3,31
	la 5,.LC92@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L371
.L363:
	li 3,1
.L368:
	lwz 0,132(1)
	mtlr 0
	lmw 28,112(1)
	la 1,128(1)
	blr
.Lfe13:
	.size	 check_stand,.Lfe13-check_stand
	.section	".sbss","aw",@nobits
	.align 2
i.109:
	.space	4
	.size	 i.109,4
	.section	".rodata"
	.align 2
.LC97:
	.string	"*death%i.wav"
	.align 2
.LC98:
	.long 0x3f800000
	.align 2
.LC99:
	.long 0x0
	.section	".text"
	.align 2
	.globl Feign
	.type	 Feign,@function
Feign:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	bl check_stand
	cmpwi 0,3,0
	bc 12,2,.L373
	lis 8,i.109@ha
	lwz 0,908(31)
	lis 9,0x5555
	lwz 10,i.109@l(8)
	ori 9,9,21846
	andi. 11,0,64
	addi 10,10,1
	mulhw 9,10,9
	srawi 11,10,31
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf 10,0,10
	stw 10,i.109@l(8)
	bc 4,2,.L375
	lwz 9,84(31)
	cmpwi 0,10,1
	li 0,5
	stw 0,2184(9)
	bc 12,2,.L378
	bc 12,1,.L382
	cmpwi 0,10,0
	bc 12,2,.L377
	b .L376
.L382:
	cmpwi 0,10,2
	bc 12,2,.L379
	b .L376
.L377:
	li 0,177
	lwz 11,84(31)
	li 9,183
	b .L384
.L378:
	li 0,183
	lwz 11,84(31)
	li 9,189
	b .L384
.L379:
	li 0,189
	lwz 11,84(31)
	li 9,197
.L384:
	stw 0,56(31)
	stw 9,2180(11)
.L376:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC97@ha
	srwi 0,0,30
	la 3,.LC97@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC98@ha
	lis 11,.LC98@ha
	la 9,.LC98@l(9)
	la 11,.LC98@l(11)
	lfs 1,0(9)
	mr 5,3
	li 4,2
	lfs 2,0(11)
	lis 9,.LC99@ha
	mr 3,31
	lwz 11,16(29)
	la 9,.LC99@l(9)
	lfs 3,0(9)
	mtlr 11
	blrl
	mr 3,31
	bl CTFDeadDropFlag
	li 0,0
	li 11,7
	lwz 10,84(31)
	stw 0,44(31)
	li 9,2
	mr 3,31
	stw 11,260(31)
	stw 9,0(10)
	lwz 0,908(31)
	rlwinm 0,0,0,26,24
	stw 0,908(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	b .L373
.L375:
	lwz 11,84(31)
	li 0,0
	lis 10,gi+32@ha
	stw 0,2184(11)
	lwz 9,84(31)
	stw 0,0(9)
	lwz 11,84(31)
	lwz 0,gi+32@l(10)
	lwz 9,1788(11)
	mtlr 0
	lwz 3,32(9)
	blrl
	lwz 9,84(31)
	stw 3,88(9)
	lwz 0,908(31)
	ori 0,0,64
	stw 0,908(31)
.L373:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 Feign,.Lfe14-Feign
	.section	".rodata"
	.align 2
.LC100:
	.string	"%02d:%02d %4d %3d %s%s\n"
	.align 2
.LC101:
	.string	" (spectator)"
	.align 2
.LC102:
	.string	""
	.align 2
.LC103:
	.string	"And more...\n"
	.align 2
.LC104:
	.long 0x0
	.align 3
.LC105:
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
	lis 9,.LC104@ha
	stb 0,96(1)
	li 28,0
	la 9,.LC104@l(9)
	lfs 0,20(11)
	lis 22,maxclients@ha
	lfs 13,0(9)
	addi 31,1,96
	lis 21,gi@ha
	lwz 9,g_edicts@l(10)
	lis 20,.LC55@ha
	fcmpu 0,13,0
	addi 30,9,1116
	bc 4,0,.L387
	lis 9,.LC101@ha
	lis 11,.LC102@ha
	la 23,.LC101@l(9)
	la 24,.LC102@l(11)
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
	lwz 0,1812(10)
	addi 29,10,700
	lwz 7,1880(10)
	subf 9,0,9
	lwz 3,184(10)
	mulhw 11,9,11
	lwz 4,1816(10)
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
	lis 5,.LC100@ha
	mr 10,29
	addi 3,1,16
	la 5,.LC100@l(5)
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
	lis 4,.LC103@ha
	add 3,31,3
	la 4,.LC103@l(4)
	crxor 6,6,6
	bl sprintf
	la 9,gi@l(21)
	mr 3,27
	lwz 0,8(9)
	la 5,.LC55@l(20)
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
	lis 10,.LC105@ha
	stw 0,1516(1)
	la 10,.LC105@l(10)
	addi 30,30,1116
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
	lis 5,.LC55@ha
	lwz 0,gi+8@l(9)
	mr 3,27
	la 5,.LC55@l(5)
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
.Lfe15:
	.size	 Cmd_PlayerList_f,.Lfe15-Cmd_PlayerList_f
	.section	".rodata"
	.align 2
.LC106:
	.string	"Cloaking field deactivated.\n"
	.align 2
.LC107:
	.string	"Cells"
	.align 2
.LC108:
	.string	"Not enough energy.\n"
	.align 2
.LC109:
	.string	"Cloaking field activated.\n"
	.section	".text"
	.align 2
	.globl Cmd_Cloak_f
	.type	 Cmd_Cloak_f,@function
Cmd_Cloak_f:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,892(31)
	cmpwi 0,0,9
	bc 4,2,.L395
	lwz 9,908(31)
	andi. 0,9,32
	bc 12,2,.L397
	lwz 0,184(31)
	rlwinm 9,9,0,27,25
	lwz 11,84(31)
	rlwinm 0,0,0,0,30
	stw 9,908(31)
	stw 0,184(31)
	lwz 9,2264(11)
	cmpwi 0,9,0
	bc 12,2,.L398
	lwz 9,2272(11)
	lwz 0,184(9)
	rlwinm 0,0,0,0,30
	stw 0,184(9)
.L398:
	lis 9,gi+8@ha
	lis 5,.LC106@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC106@l(5)
	b .L401
.L397:
	lis 27,.LC107@ha
	lwz 29,84(31)
	lis 30,0x286b
	la 3,.LC107@l(27)
	ori 30,30,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,24
	bc 12,1,.L399
	lis 9,gi+8@ha
	lis 5,.LC108@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC108@l(5)
.L401:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L395
.L399:
	la 3,.LC107@l(27)
	bl FindItem
	subf 3,28,3
	lwz 11,84(31)
	mullw 3,3,30
	addi 11,11,740
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,-25
	stwx 9,11,3
	lwz 0,908(31)
	lwz 9,184(31)
	ori 0,0,32
	lwz 11,84(31)
	ori 9,9,1
	stw 0,908(31)
	stw 9,184(31)
	lwz 0,2264(11)
	cmpwi 0,0,0
	bc 12,2,.L400
	lwz 9,2272(11)
	lwz 0,184(9)
	ori 0,0,1
	stw 0,184(9)
.L400:
	lis 9,gi+8@ha
	lis 5,.LC109@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC109@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L395:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 Cmd_Cloak_f,.Lfe16-Cmd_Cloak_f
	.section	".rodata"
	.align 2
.LC110:
	.string	"players"
	.align 2
.LC111:
	.string	"say"
	.align 2
.LC112:
	.string	"say_team"
	.align 2
.LC113:
	.string	"score"
	.align 2
.LC114:
	.string	"help"
	.align 2
.LC115:
	.string	"use"
	.align 2
.LC116:
	.string	"drop"
	.align 2
.LC117:
	.string	"give"
	.align 2
.LC118:
	.string	"god"
	.align 2
.LC119:
	.string	"notarget"
	.align 2
.LC120:
	.string	"noclip"
	.align 2
.LC121:
	.string	"inven"
	.align 2
.LC122:
	.string	"invnext"
	.align 2
.LC123:
	.string	"invprev"
	.align 2
.LC124:
	.string	"invnextw"
	.align 2
.LC125:
	.string	"invprevw"
	.align 2
.LC126:
	.string	"invnextp"
	.align 2
.LC127:
	.string	"invprevp"
	.align 2
.LC128:
	.string	"invuse"
	.align 2
.LC129:
	.string	"invdrop"
	.align 2
.LC130:
	.string	"feign"
	.align 2
.LC131:
	.string	"weapprev"
	.align 2
.LC132:
	.string	"weapnext"
	.align 2
.LC133:
	.string	"weaplast"
	.align 2
.LC134:
	.string	"kill"
	.align 2
.LC135:
	.string	"putaway"
	.align 2
.LC136:
	.string	"wave"
	.align 2
.LC137:
	.string	"maphelp"
	.align 2
.LC138:
	.string	"flaginfo"
	.align 2
.LC139:
	.string	"radio_power"
	.align 2
.LC140:
	.string	"radio_team"
	.align 2
.LC141:
	.string	"TEAM"
	.align 2
.LC142:
	.string	"radio_player"
	.align 2
.LC143:
	.string	"custom"
	.align 2
.LC144:
	.string	"main"
	.align 2
.LC145:
	.string	"menu_speed"
	.align 2
.LC146:
	.string	"menu_class"
	.align 2
.LC147:
	.string	"menu_team\n"
	.align 2
.LC148:
	.string	"menu_team"
	.align 2
.LC149:
	.string	"menu_armor"
	.align 2
.LC150:
	.string	"menu_done"
	.align 2
.LC151:
	.string	"id"
	.align 2
.LC152:
	.string	"build"
	.align 2
.LC153:
	.string	"origin"
	.align 2
.LC154:
	.string	"cloak"
	.align 2
.LC155:
	.string	"jumpf"
	.align 2
.LC156:
	.string	"jumpb"
	.align 2
.LC157:
	.string	"reset"
	.align 2
.LC158:
	.string	"radio_off"
	.align 2
.LC159:
	.string	"kick_team"
	.align 2
.LC160:
	.string	"shut_up"
	.align 2
.LC161:
	.string	"playerlist"
	.align 2
.LC162:
	.string	"chasecam"
	.align 2
.LC163:
	.string	"riplist"
	.align 2
.LC164:
	.string	"feign\nmaphelp\ncam\nflaginfo\nradio_power\nradio_team\nradio_player\nmain\nid\nbuild\norigin\njumpf\njumpb\nreset\nradio_off\nkick_team\nshut_up\nplayerlist\nwarrior\nnecromancer\nthief\ninfantry\nminer\nscientist\nflamer\ntrooper\nchasecam\nriplist\n"
	.align 2
.LC165:
	.string	"warrior"
	.align 2
.LC166:
	.string	"necromancer"
	.align 2
.LC167:
	.string	"thief"
	.align 2
.LC168:
	.string	"infantry"
	.align 2
.LC169:
	.string	"miner"
	.align 2
.LC170:
	.string	"scientist"
	.align 2
.LC171:
	.string	"flamer"
	.align 2
.LC172:
	.string	"trooper"
	.align 2
.LC173:
	.string	"ghost"
	.align 2
.LC174:
	.string	"After death you will respawn as a %s\n"
	.align 2
.LC175:
	.string	"You will respawn as a %s\n"
	.align 2
.LC176:
	.long 0x0
	.align 2
.LC177:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl ClientCommand
	.type	 ClientCommand,@function
ClientCommand:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 24,24(1)
	stw 0,68(1)
	mr 31,3
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L402
	lis 11,.LC176@ha
	lis 9,level+200@ha
	la 11,.LC176@l(11)
	lfs 0,level+200@l(9)
	lfs 31,0(11)
	fcmpu 0,0,31
	bc 4,2,.L402
	lis 9,gi@ha
	li 3,0
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 28,3
	lis 4,.LC110@ha
	la 4,.LC110@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L405
	mr 3,31
	bl Cmd_Players_f
	b .L402
.L405:
	lis 4,.LC111@ha
	mr 3,28
	la 4,.LC111@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L406
	mr 3,31
	li 4,0
	li 5,0
	bl Cmd_Say_f
	b .L402
.L406:
	lis 4,.LC112@ha
	mr 3,28
	la 4,.LC112@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L407
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	mr 3,31
	bl CTFSay_Team
	b .L402
.L407:
	lis 4,.LC113@ha
	mr 3,28
	la 4,.LC113@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L408
	mr 3,31
	bl Cmd_Score_f
	b .L402
.L408:
	lis 4,.LC114@ha
	mr 3,28
	la 4,.LC114@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L409
	mr 3,31
	bl Cmd_Help_f
	b .L402
.L409:
	lis 4,.LC115@ha
	mr 3,28
	la 4,.LC115@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L411
	mr 3,31
	bl Cmd_Use_f
	b .L402
.L411:
	lis 4,.LC116@ha
	mr 3,28
	la 4,.LC116@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L413
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 30,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L414
	lwz 0,8(29)
	lis 5,.LC24@ha
	mr 3,31
	la 5,.LC24@l(5)
	b .L670
.L414:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L416
	lwz 0,8(29)
	lis 5,.LC28@ha
	mr 3,31
	la 5,.LC28@l(5)
	b .L671
.L416:
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
	bc 4,2,.L417
	lwz 0,8(29)
	lis 5,.LC26@ha
	mr 3,31
	la 5,.LC26@l(5)
.L670:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L402
.L417:
	mr 3,31
	mtlr 10
	blrl
	b .L402
.L413:
	lis 4,.LC117@ha
	mr 3,28
	la 4,.LC117@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L419
	mr 3,31
	bl Cmd_Give_f
	b .L402
.L419:
	lis 4,.LC118@ha
	mr 3,28
	la 4,.LC118@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L421
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L422
	lwz 0,8(29)
	lis 5,.LC1@ha
	mr 3,31
	la 5,.LC1@l(5)
	b .L671
.L422:
	lwz 0,264(31)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(31)
	bc 4,2,.L424
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L425
.L424:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
.L425:
	lis 9,gi+8@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	b .L671
.L421:
	lis 4,.LC119@ha
	mr 3,28
	la 4,.LC119@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L427
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L428
	lwz 0,8(29)
	lis 5,.LC1@ha
	mr 3,31
	la 5,.LC1@l(5)
	b .L671
.L428:
	lwz 0,264(31)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(31)
	bc 4,2,.L430
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L431
.L430:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
.L431:
	lis 9,gi+8@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	b .L671
.L427:
	lis 4,.LC120@ha
	mr 3,28
	la 4,.LC120@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L433
	lis 9,.LC176@ha
	lis 11,sv_cheats@ha
	la 9,.LC176@l(9)
	lfs 13,0(9)
	lwz 9,sv_cheats@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L434
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC1@l(5)
	b .L671
.L434:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 4,2,.L436
	li 0,4
	lis 9,.LC18@ha
	stw 0,260(31)
	la 5,.LC18@l(9)
	b .L437
.L436:
	li 0,1
	lis 9,.LC19@ha
	stw 0,260(31)
	la 5,.LC19@l(9)
.L437:
	lis 9,gi+8@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	b .L671
.L433:
	lis 4,.LC121@ha
	mr 3,28
	la 4,.LC121@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L439
	lwz 29,84(31)
	lwz 0,1820(29)
	cmpwi 0,0,0
	bc 12,2,.L672
	lwz 0,892(31)
	cmpwi 0,0,0
	bc 4,2,.L442
	mr 3,31
	bl Cmd_Class_f
	b .L402
.L442:
	lwz 0,1920(29)
	stw 3,1916(29)
	cmpwi 0,0,0
	stw 3,1924(29)
	bc 12,2,.L444
	stw 3,1920(29)
	b .L402
.L444:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,1920(29)
	li 3,5
	lwz 0,100(9)
	addi 30,29,1760
	mr 28,9
	addi 29,29,740
	mtlr 0
	blrl
.L447:
	lwz 9,104(28)
	lwz 3,0(29)
	mtlr 9
	addi 29,29,4
	blrl
	cmpw 0,29,30
	bc 4,1,.L447
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L402
.L439:
	lis 4,.LC122@ha
	mr 3,28
	la 4,.LC122@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L451
	lwz 8,84(31)
	lwz 0,1932(8)
	cmpwi 0,0,0
	bc 4,2,.L673
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L669:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L458
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L458
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L662
.L458:
	addi 7,7,1
	bdnz .L669
	b .L674
.L451:
	lis 4,.LC123@ha
	mr 3,28
	la 4,.LC123@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L463
	lwz 7,84(31)
	lwz 0,1932(7)
	cmpwi 0,0,0
	bc 4,2,.L675
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L668:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L470
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L470
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L663
.L470:
	addi 11,11,-1
	bdnz .L668
	b .L676
.L463:
	lis 4,.LC124@ha
	mr 3,28
	la 4,.LC124@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L475
	lwz 8,84(31)
	lwz 0,1932(8)
	cmpwi 0,0,0
	bc 4,2,.L673
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L667:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L482
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L482
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L662
.L482:
	addi 7,7,1
	bdnz .L667
	b .L674
.L475:
	lis 4,.LC125@ha
	mr 3,28
	la 4,.LC125@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L487
	lwz 7,84(31)
	lwz 0,1932(7)
	cmpwi 0,0,0
	bc 4,2,.L675
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L666:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L494
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L494
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L663
.L494:
	addi 11,11,-1
	bdnz .L666
	b .L676
.L487:
	lis 4,.LC126@ha
	mr 3,28
	la 4,.LC126@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L499
	lwz 8,84(31)
	lwz 0,1932(8)
	cmpwi 0,0,0
	bc 12,2,.L500
.L673:
	mr 3,31
	bl Menu_Dn
	b .L402
.L500:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L665:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L506
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L506
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L662
.L506:
	addi 7,7,1
	bdnz .L665
.L674:
	li 0,-1
	stw 0,736(8)
	b .L402
.L499:
	lis 4,.LC127@ha
	mr 3,28
	la 4,.LC127@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L511
	lwz 7,84(31)
	lwz 0,1932(7)
	cmpwi 0,0,0
	bc 12,2,.L512
.L675:
	mr 3,31
	bl Menu_Up
	b .L402
.L512:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L664:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L518
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L518
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L663
.L518:
	addi 11,11,-1
	bdnz .L664
.L676:
	li 0,-1
	stw 0,736(7)
	b .L402
.L511:
	lis 4,.LC128@ha
	mr 3,28
	la 4,.LC128@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L523
	mr 3,31
	bl Cmd_InvUse_f
	b .L402
.L523:
	lis 4,.LC129@ha
	mr 3,28
	la 4,.LC129@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L525
	mr 3,31
	bl Cmd_InvDrop_f
	b .L402
.L525:
	lis 4,.LC130@ha
	mr 3,28
	la 4,.LC130@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L527
	mr 3,31
	bl Feign
	b .L402
.L527:
	lis 4,.LC131@ha
	mr 3,28
	la 4,.LC131@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L529
	lwz 28,84(31)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L402
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
.L534:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L536
	mulli 0,11,76
	add 29,0,25
	lwz 9,8(29)
	cmpwi 0,9,0
	bc 12,2,.L536
	lwz 0,56(29)
	andi. 11,0,1
	bc 12,2,.L536
	mr 3,31
	mr 4,29
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,29
	bc 12,2,.L402
.L536:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L534
	b .L402
.L529:
	lis 4,.LC132@ha
	mr 3,28
	la 4,.LC132@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L542
	lwz 30,84(31)
	lwz 11,1788(30)
	cmpwi 0,11,0
	bc 12,2,.L402
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 27,1
	subf 9,9,11
	addi 26,30,740
	mullw 9,9,0
	srawi 9,9,2
	addi 28,9,255
.L547:
	srawi 0,28,31
	srwi 0,0,24
	add 0,28,0
	rlwinm 0,0,0,0,23
	subf 11,0,28
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L549
	mulli 0,11,76
	add 29,0,25
	lwz 9,8(29)
	cmpwi 0,9,0
	bc 12,2,.L549
	lwz 0,56(29)
	andi. 11,0,1
	bc 12,2,.L549
	mr 3,31
	mr 4,29
	mtlr 9
	blrl
	lwz 0,1788(30)
	cmpw 0,0,29
	bc 12,2,.L402
.L549:
	addi 27,27,1
	addi 28,28,-1
	cmpwi 0,27,256
	bc 4,1,.L547
	b .L402
.L542:
	lis 4,.LC133@ha
	mr 3,28
	la 4,.LC133@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L555
	lwz 10,84(31)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L402
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L402
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
	bc 12,2,.L402
	mulli 0,10,76
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L402
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L402
	mr 3,31
	mtlr 9
	blrl
	b .L402
.L555:
	lis 4,.LC134@ha
	mr 3,28
	la 4,.LC134@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L563
	lwz 5,84(31)
	lis 9,level+4@ha
	lis 11,.LC177@ha
	lfs 0,level+4@l(9)
	la 11,.LC177@l(11)
	lfs 13,2228(5)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L402
	lwz 0,892(31)
	cmpwi 0,0,0
	bc 12,2,.L402
	lis 10,ripflags@ha
	lwz 9,ripflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,1
	bc 12,2,.L567
	lis 9,gi@ha
	lis 4,.LC31@ha
	lwz 0,gi@l(9)
	la 4,.LC31@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 4,.LC32@ha
	mr 3,31
	la 4,.LC32@l(4)
	bl stuffcmd
	b .L402
.L567:
	lwz 0,264(31)
	lis 11,meansOfDeath@ha
	li 9,23
	stw 10,480(31)
	lis 7,vec3_origin@ha
	mr 3,31
	rlwinm 0,0,0,28,26
	la 7,vec3_origin@l(7)
	stw 0,264(31)
	mr 4,31
	mr 5,31
	stw 9,meansOfDeath@l(11)
	li 6,500
	bl player_die
	li 0,2
	mr 3,31
	stw 0,492(31)
	bl respawn
	b .L402
.L563:
	lis 4,.LC135@ha
	mr 3,28
	la 4,.LC135@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L569
	lwz 9,84(31)
	stw 3,1916(9)
	lwz 11,84(31)
	stw 3,1924(11)
	lwz 9,84(31)
	stw 3,1920(9)
	lwz 11,84(31)
	lwz 0,1932(11)
	cmpwi 0,0,0
	bc 12,2,.L402
	mr 3,31
	bl Menu_Close
	b .L402
.L569:
	lis 4,.LC136@ha
	mr 3,28
	la 4,.LC136@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L573
	mr 3,31
	bl Cmd_Wave_f
	b .L402
.L573:
	lis 4,.LC137@ha
	mr 3,28
	la 4,.LC137@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L575
	lis 9,level+884@ha
	la 30,level+884@l(9)
	cmpwi 0,30,0
	bc 12,2,.L402
	mr 3,30
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L402
	mr 3,31
	mr 4,30
	bl Print_Msg
	b .L402
.L575:
	lis 4,.LC138@ha
	mr 3,28
	la 4,.LC138@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L579
	mr 3,31
	bl Flag_StatusReport
	b .L402
.L579:
	lis 4,.LC139@ha
	mr 3,28
	la 4,.LC139@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L581
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	mr 4,3
	mr 3,31
	bl X_Radio_Power_f
	b .L402
.L581:
	lis 4,.LC140@ha
	mr 3,28
	la 4,.LC140@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L583
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	mr 5,3
	lis 4,.LC141@ha
	mr 3,31
	la 4,.LC141@l(4)
	bl X_Radio_f
	b .L402
.L583:
	lis 4,.LC142@ha
	mr 3,28
	la 4,.LC142@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L585
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	bl ent_by_name
	lwz 0,160(29)
	mr 28,3
	li 3,2
	mtlr 0
	blrl
	mr 5,3
	mr 4,28
	mr 3,31
	bl Radio_Player
	b .L402
.L585:
	lis 4,.LC143@ha
	mr 3,28
	la 4,.LC143@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L587
	mr 3,31
	bl Cmd_Custom_f
	b .L402
.L587:
	lis 4,.LC144@ha
	mr 3,28
	la 4,.LC144@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L589
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	lwz 11,892(31)
	mr 4,3
	cmpwi 0,11,0
	bc 12,2,.L402
	cmpwi 0,11,4
	bc 12,2,.L592
	lwz 9,84(31)
	lwz 0,1872(9)
	cmpwi 0,0,4
	bc 4,2,.L593
.L592:
	mr 3,31
	bl SP_LaserSight
	b .L402
.L593:
	cmpwi 0,11,5
	bc 12,2,.L595
	cmpwi 0,0,5
	bc 4,2,.L596
.L595:
	mr 3,31
	bl Cmd_DetPipes_f
	b .L402
.L596:
	cmpwi 0,11,2
	bc 12,2,.L598
	cmpwi 0,0,2
	bc 4,2,.L599
.L598:
	mr 3,31
	bl Cmd_Spell_f
	b .L402
.L599:
	cmpwi 0,11,6
	bc 12,2,.L677
	cmpwi 0,0,6
	bc 4,2,.L402
	b .L677
.L589:
	lis 4,.LC145@ha
	mr 3,28
	la 4,.LC145@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L604
	mr 3,31
	bl Cmd_Speed_f
	b .L402
.L604:
	lis 4,.LC146@ha
	mr 3,28
	la 4,.LC146@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L606
	lwz 9,84(31)
	lwz 0,1820(9)
	cmpwi 0,0,0
	bc 4,2,.L607
	lis 4,.LC147@ha
	mr 3,31
	la 4,.LC147@l(4)
	bl stuffcmd
	b .L402
.L607:
	lwz 0,1916(9)
	cmpwi 0,0,0
	bc 4,2,.L402
	lwz 0,1920(9)
	cmpwi 0,0,0
	bc 4,2,.L402
	lwz 0,1932(9)
	cmpwi 0,0,0
	bc 4,2,.L402
	lwz 0,1936(9)
	cmpwi 0,0,0
	bc 4,2,.L402
	lis 4,.LC77@ha
	mr 3,31
	la 4,.LC77@l(4)
	bl Menu_Title
	lis 4,.LC78@ha
	mr 3,31
	la 4,.LC78@l(4)
	bl Menu_Add
	lis 4,.LC79@ha
	mr 3,31
	la 4,.LC79@l(4)
	bl Menu_Add
	lis 4,.LC80@ha
	mr 3,31
	la 4,.LC80@l(4)
	bl Menu_Add
	lis 4,.LC81@ha
	mr 3,31
	la 4,.LC81@l(4)
	bl Menu_Add
	lis 4,.LC82@ha
	mr 3,31
	la 4,.LC82@l(4)
	bl Menu_Add
	lis 4,.LC83@ha
	mr 3,31
	la 4,.LC83@l(4)
	bl Menu_Add
	lis 4,.LC84@ha
	mr 3,31
	la 4,.LC84@l(4)
	bl Menu_Add
	lis 4,.LC85@ha
	mr 3,31
	la 4,.LC85@l(4)
	bl Menu_Add
	lis 4,.LC86@ha
	mr 3,31
	la 4,.LC86@l(4)
	bl Menu_Add
	lis 4,.LC87@ha
	mr 3,31
	la 4,.LC87@l(4)
	bl Menu_Add
	lwz 11,84(31)
	lis 9,MyClass_Sel@ha
	mr 3,31
	la 9,MyClass_Sel@l(9)
	stw 9,1996(11)
	bl Menu_Open
	b .L402
.L606:
	lis 4,.LC148@ha
	mr 3,28
	la 4,.LC148@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L613
.L672:
	mr 3,31
	bl Cmd_Team_f
	b .L402
.L613:
	lis 4,.LC149@ha
	mr 3,28
	la 4,.LC149@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L615
	mr 3,31
	bl Cmd_Armor_f
	b .L402
.L615:
	lis 4,.LC150@ha
	mr 3,28
	la 4,.LC150@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L617
	mr 3,31
	bl Cmd_Done_f
	b .L402
.L617:
	lis 4,.LC151@ha
	mr 3,28
	la 4,.LC151@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L619
	mr 3,31
	bl Cmd_id_f
	b .L402
.L619:
	lis 4,.LC152@ha
	mr 3,28
	la 4,.LC152@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L621
.L677:
	mr 3,31
	bl Cmd_Build_f
	b .L402
.L621:
	lis 4,.LC153@ha
	mr 3,28
	la 4,.LC153@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L623
	mr 3,31
	bl Self_Origin
	b .L402
.L623:
	lis 4,.LC154@ha
	mr 3,28
	la 4,.LC154@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L625
	mr 3,31
	bl Cmd_Cloak_f
	b .L402
.L625:
	lis 4,.LC155@ha
	mr 3,28
	la 4,.LC155@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L627
	mr 3,31
	bl MageJump2
	b .L402
.L627:
	lis 4,.LC156@ha
	mr 3,28
	la 4,.LC156@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L629
	mr 3,31
	bl MageJump1
	b .L402
.L629:
	lis 4,.LC157@ha
	mr 3,28
	la 4,.LC157@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L631
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl stuffcmd
	b .L402
.L631:
	lis 4,.LC158@ha
	mr 3,28
	la 4,.LC158@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L633
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	mr 4,3
	mr 3,31
	bl TeamMasterCanOffPlayersRadio
	b .L402
.L633:
	lis 4,.LC159@ha
	mr 3,28
	la 4,.LC159@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L635
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	mr 4,3
	mr 3,31
	bl TeamMasterCanKickPlayer
	b .L402
.L635:
	lis 4,.LC160@ha
	mr 3,28
	la 4,.LC160@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L637
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	mr 4,3
	mr 3,31
	bl TeamMasterCanShutUpPlayer
	b .L402
.L637:
	lis 4,.LC161@ha
	mr 3,28
	la 4,.LC161@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L639
	mr 3,31
	bl Cmd_PlayerList_f
	b .L402
.L639:
	lis 4,.LC162@ha
	mr 3,28
	la 4,.LC162@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L641
	mr 3,31
	bl Cmd_Chasecam_Toggle
	b .L402
.L641:
	lis 4,.LC163@ha
	mr 3,28
	la 4,.LC163@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L643
	lis 9,gi+8@ha
	lis 5,.LC164@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC164@l(5)
.L671:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L402
.L643:
	lis 4,.LC165@ha
	mr 3,28
	la 4,.LC165@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L646
	lis 4,.LC166@ha
	mr 3,28
	la 4,.LC166@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L646
	lis 4,.LC167@ha
	mr 3,28
	la 4,.LC167@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L646
	lis 4,.LC168@ha
	mr 3,28
	la 4,.LC168@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L646
	lis 4,.LC169@ha
	mr 3,28
	la 4,.LC169@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L646
	lis 4,.LC170@ha
	mr 3,28
	la 4,.LC170@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L646
	lis 4,.LC171@ha
	mr 3,28
	la 4,.LC171@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L646
	lis 4,.LC172@ha
	mr 3,28
	la 4,.LC172@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L646
	lis 4,.LC173@ha
	mr 3,28
	la 4,.LC173@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L402
.L646:
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,0
	bc 4,2,.L647
	lis 9,cla_names@ha
	li 27,1
	la 11,cla_names@l(9)
	lwz 0,4(11)
	cmpwi 0,0,0
	bc 12,2,.L402
	lis 9,gi@ha
	mr 30,11
	la 26,gi@l(9)
	lis 24,.LC174@ha
	lis 25,.LC175@ha
	li 29,4
.L651:
	lwzx 4,29,30
	mr 3,28
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L650
	lwz 0,896(31)
	cmpw 0,0,27
	bc 12,2,.L653
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L654
	lwz 0,8(26)
	la 5,.LC174@l(24)
	mr 3,31
	lwzx 6,29,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L653
.L654:
	lwz 0,8(26)
	la 5,.LC175@l(25)
	mr 3,31
	lwzx 6,29,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L653:
	stw 27,896(31)
	b .L402
.L650:
	addi 29,29,4
	addi 27,27,1
	lwzx 0,29,30
	cmpwi 0,0,0
	bc 4,2,.L651
	b .L402
.L662:
	stw 11,736(8)
	b .L402
.L663:
	stw 8,736(7)
	b .L402
.L647:
	mr 3,31
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L402:
	lwz 0,68(1)
	mtlr 0
	lmw 24,24(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe17:
	.size	 ClientCommand,.Lfe17-ClientCommand
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
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
	bc 4,2,.L46
	lwz 0,1932(7)
	cmpwi 0,0,0
	bc 12,2,.L48
	bl Menu_Dn
	b .L46
.L678:
	stw 11,736(7)
	b .L46
.L48:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L679:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L54
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L54
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L678
.L54:
	addi 8,8,1
	bdnz .L679
	li 0,-1
	stw 0,736(7)
.L46:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 ValidateSelectedItem,.Lfe18-ValidateSelectedItem
	.align 2
	.globl Cmd_Class_f
	.type	 Cmd_Class_f,@function
Cmd_Class_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,1916(9)
	cmpwi 0,0,0
	bc 4,2,.L338
	lwz 0,1920(9)
	cmpwi 0,0,0
	bc 4,2,.L338
	lwz 0,1932(9)
	cmpwi 0,0,0
	bc 4,2,.L338
	lwz 0,1936(9)
	cmpwi 0,0,0
	bc 4,2,.L338
	lis 4,.LC77@ha
	la 4,.LC77@l(4)
	bl Menu_Title
	lis 4,.LC78@ha
	mr 3,31
	la 4,.LC78@l(4)
	bl Menu_Add
	lis 4,.LC79@ha
	mr 3,31
	la 4,.LC79@l(4)
	bl Menu_Add
	lis 4,.LC80@ha
	mr 3,31
	la 4,.LC80@l(4)
	bl Menu_Add
	lis 4,.LC81@ha
	mr 3,31
	la 4,.LC81@l(4)
	bl Menu_Add
	lis 4,.LC82@ha
	mr 3,31
	la 4,.LC82@l(4)
	bl Menu_Add
	lis 4,.LC83@ha
	mr 3,31
	la 4,.LC83@l(4)
	bl Menu_Add
	lis 4,.LC84@ha
	mr 3,31
	la 4,.LC84@l(4)
	bl Menu_Add
	lis 4,.LC85@ha
	mr 3,31
	la 4,.LC85@l(4)
	bl Menu_Add
	lis 4,.LC86@ha
	mr 3,31
	la 4,.LC86@l(4)
	bl Menu_Add
	lis 4,.LC87@ha
	mr 3,31
	la 4,.LC87@l(4)
	bl Menu_Add
	lwz 11,84(31)
	lis 9,MyClass_Sel@ha
	mr 3,31
	la 9,MyClass_Sel@l(9)
	stw 9,1996(11)
	bl Menu_Open
.L338:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe19:
	.size	 Cmd_Class_f,.Lfe19-Cmd_Class_f
	.align 2
	.globl ClientTeam
	.type	 ClientTeam,@function
ClientTeam:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,value.6@ha
	mr 31,3
	li 29,0
	la 30,value.6@l(9)
	stb 29,value.6@l(9)
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L681
	lwz 3,84(31)
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,30
	bl strcpy
	mr 3,30
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L681
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,128
	bc 4,2,.L9
	addi 3,3,1
	b .L680
.L9:
	stb 29,0(3)
.L681:
	mr 3,30
.L680:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 ClientTeam,.Lfe20-ClientTeam
	.align 2
	.globl SelectNextItem
	.type	 SelectNextItem,@function
SelectNextItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 8,84(3)
	lwz 0,1932(8)
	cmpwi 0,0,0
	bc 12,2,.L27
	bl Menu_Dn
	b .L26
.L682:
	stw 11,736(8)
	b .L26
.L27:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 3,itemlist@l(9)
	addi 6,8,740
.L683:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L30
	mulli 0,11,76
	add 10,0,3
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L30
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L682
.L30:
	addi 7,7,1
	bdnz .L683
	li 0,-1
	stw 0,736(8)
.L26:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 SelectNextItem,.Lfe21-SelectNextItem
	.align 2
	.globl SelectPrevItem
	.type	 SelectPrevItem,@function
SelectPrevItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 7,84(3)
	lwz 0,1932(7)
	cmpwi 0,0,0
	bc 12,2,.L37
	bl Menu_Up
	b .L36
.L684:
	stw 8,736(7)
	b .L36
.L37:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L685:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L40
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L40
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L684
.L40:
	addi 11,11,-1
	bdnz .L685
	li 0,-1
	stw 0,736(7)
.L36:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 SelectPrevItem,.Lfe22-SelectPrevItem
	.section	".rodata"
	.align 2
.LC178:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC178@ha
	lis 9,sv_cheats@ha
	la 11,.LC178@l(11)
	lfs 13,0(11)
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L112
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L111
.L112:
	lwz 0,264(3)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(3)
	bc 4,2,.L113
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L114
.L113:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
.L114:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L111:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 Cmd_God_f,.Lfe23-Cmd_God_f
	.section	".rodata"
	.align 2
.LC179:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC179@ha
	lis 9,sv_cheats@ha
	la 11,.LC179@l(11)
	lfs 13,0(11)
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L116
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L115
.L116:
	lwz 0,264(3)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(3)
	bc 4,2,.L117
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L118
.L117:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
.L118:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L115:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 Cmd_Notarget_f,.Lfe24-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC180:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC180@ha
	lis 9,sv_cheats@ha
	la 11,.LC180@l(11)
	lfs 13,0(11)
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L120
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L119
.L120:
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 4,2,.L121
	li 0,4
	lis 9,.LC18@ha
	stw 0,260(3)
	la 5,.LC18@l(9)
	b .L122
.L121:
	li 0,1
	lis 9,.LC19@ha
	stw 0,260(3)
	la 5,.LC19@l(9)
.L122:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L119:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe25:
	.size	 Cmd_Noclip_f,.Lfe25-Cmd_Noclip_f
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
	bc 4,2,.L135
	lwz 0,8(29)
	lis 5,.LC24@ha
	mr 3,31
	la 5,.LC24@l(5)
	b .L686
.L135:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L136
	lwz 0,8(29)
	lis 5,.LC28@ha
	mr 3,31
	la 5,.LC28@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L134
.L136:
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
	bc 4,2,.L137
	lwz 0,8(29)
	lis 5,.LC26@ha
	mr 3,31
	la 5,.LC26@l(5)
.L686:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L134
.L137:
	mr 3,31
	mtlr 10
	blrl
.L134:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 Cmd_Drop_f,.Lfe26-Cmd_Drop_f
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
	lwz 0,1820(31)
	cmpwi 0,0,0
	bc 4,2,.L139
	bl Cmd_Team_f
	b .L138
.L139:
	lwz 0,892(30)
	cmpwi 0,0,0
	bc 4,2,.L140
	mr 3,30
	bl Cmd_Class_f
	b .L138
.L140:
	lwz 0,1920(31)
	li 9,0
	stw 9,1916(31)
	cmpwi 0,0,0
	stw 9,1924(31)
	bc 12,2,.L142
	stw 9,1920(31)
	b .L138
.L142:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,1920(31)
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
.L138:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 Cmd_Inven_f,.Lfe27-Cmd_Inven_f
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
	bc 12,2,.L166
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
.L171:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L170
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L170
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L170
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L166
.L170:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L171
.L166:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe28:
	.size	 Cmd_WeapPrev_f,.Lfe28-Cmd_WeapPrev_f
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
	bc 12,2,.L177
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
.L182:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L181
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L181
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L181
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L177
.L181:
	addi 28,28,1
	addi 30,30,-1
	cmpwi 0,28,256
	bc 4,1,.L182
.L177:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe29:
	.size	 Cmd_WeapNext_f,.Lfe29-Cmd_WeapNext_f
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
	bc 12,2,.L188
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L188
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
	bc 12,2,.L188
	mulli 0,10,76
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L188
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L188
	mtlr 9
	blrl
.L188:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 Cmd_WeapLast_f,.Lfe30-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC181:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Cmd_Kill_f
	.type	 Cmd_Kill_f,@function
Cmd_Kill_f:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lis 9,level+4@ha
	lwz 5,84(31)
	lis 11,.LC181@ha
	lfs 0,level+4@l(9)
	la 11,.LC181@l(11)
	lfs 13,2228(5)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L212
	lwz 0,892(31)
	cmpwi 0,0,0
	bc 12,2,.L212
	lis 10,ripflags@ha
	lwz 9,ripflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,1
	bc 12,2,.L215
	lis 9,gi@ha
	lis 4,.LC31@ha
	lwz 0,gi@l(9)
	la 4,.LC31@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 4,.LC32@ha
	mr 3,31
	la 4,.LC32@l(4)
	bl stuffcmd
	b .L212
.L215:
	lwz 0,264(31)
	lis 11,meansOfDeath@ha
	li 9,23
	stw 10,480(31)
	lis 7,vec3_origin@ha
	mr 3,31
	rlwinm 0,0,0,28,26
	la 7,vec3_origin@l(7)
	stw 0,264(31)
	mr 4,31
	mr 5,31
	stw 9,meansOfDeath@l(11)
	li 6,500
	bl player_die
	li 0,2
	mr 3,31
	stw 0,492(31)
	bl respawn
.L212:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 Cmd_Kill_f,.Lfe31-Cmd_Kill_f
	.align 2
	.globl Cmd_PutAway_f
	.type	 Cmd_PutAway_f,@function
Cmd_PutAway_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	li 0,0
	stw 0,1916(9)
	lwz 11,84(3)
	stw 0,1924(11)
	lwz 9,84(3)
	stw 0,1920(9)
	lwz 11,84(3)
	lwz 0,1932(11)
	cmpwi 0,0,0
	bc 12,2,.L217
	bl Menu_Close
.L217:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe32:
	.size	 Cmd_PutAway_f,.Lfe32-Cmd_PutAway_f
	.align 2
	.globl PlayerSort
	.type	 PlayerSort,@function
PlayerSort:
	lwz 9,0(3)
	lis 11,game+1028@ha
	lwz 3,0(4)
	lwz 0,game+1028@l(11)
	mulli 9,9,2288
	mulli 11,3,2288
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
.Lfe33:
	.size	 PlayerSort,.Lfe33-PlayerSort
	.align 2
	.globl MyTeam_Sel
	.type	 MyTeam_Sel,@function
MyTeam_Sel:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	cmpwi 0,4,1
	mr 31,3
	bc 12,2,.L274
	cmpwi 0,4,2
	bc 12,2,.L275
	b .L276
.L274:
	li 4,1
	b .L688
.L275:
	li 4,2
.L688:
	mr 3,31
	bl JoinTeam
	lis 4,.LC59@ha
	mr 3,31
	la 4,.LC59@l(4)
	bl stuffcmd
	b .L273
.L276:
	lis 4,.LC60@ha
	mr 3,31
	la 4,.LC60@l(4)
	bl stuffcmd
.L273:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe34:
	.size	 MyTeam_Sel,.Lfe34-MyTeam_Sel
	.align 2
	.globl nothing
	.type	 nothing,@function
nothing:
	blr
.Lfe35:
	.size	 nothing,.Lfe35-nothing
	.align 2
	.globl Cmd_Main_f
	.type	 Cmd_Main_f,@function
Cmd_Main_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,892(3)
	cmpwi 0,11,0
	bc 12,2,.L341
	cmpwi 0,11,4
	bc 12,2,.L344
	lwz 9,84(3)
	lwz 0,1872(9)
	cmpwi 0,0,4
	bc 4,2,.L343
.L344:
	bl SP_LaserSight
	b .L341
.L343:
	cmpwi 0,11,5
	bc 12,2,.L347
	cmpwi 0,0,5
	bc 4,2,.L346
.L347:
	bl Cmd_DetPipes_f
	b .L341
.L346:
	cmpwi 0,11,2
	bc 12,2,.L350
	cmpwi 0,0,2
	bc 4,2,.L349
.L350:
	bl Cmd_Spell_f
	b .L341
.L349:
	cmpwi 0,11,6
	bc 12,2,.L353
	cmpwi 0,0,6
	bc 4,2,.L341
.L353:
	bl Cmd_Build_f
.L341:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe36:
	.size	 Cmd_Main_f,.Lfe36-Cmd_Main_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
