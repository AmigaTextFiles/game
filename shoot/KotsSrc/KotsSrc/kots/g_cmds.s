	.file	"g_cmds.c"
gcc2_compiled.:
	.lcomm	value.6,512,4
	.section	".rodata"
	.align 2
.LC0:
	.string	"skin"
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
	.string	"Power Cube"
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
	bc 12,2,.L59
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L59
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	b .L115
.L59:
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
	cmpwi 4,30,0
	bc 12,18,.L58
.L62:
	bc 4,18,.L68
	lis 4,.LC4@ha
	mr 3,26
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
	mr 3,26
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
	mr 30,11
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
	lwz 0,1556(30)
	addi 29,29,1
	addi 28,28,76
	cmpw 0,29,0
	bc 12,0,.L82
.L80:
	bc 12,18,.L58
.L77:
	bc 4,18,.L88
	lis 4,.LC6@ha
	mr 3,26
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
	mr 3,26
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
	bc 4,18,.L95
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L94
.L95:
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	bl FindItem
	lis 11,gi@ha
	lis 9,itemlist@ha
	la 28,gi@l(11)
	mr 27,3
	lwz 10,156(28)
	la 9,itemlist@l(9)
	lis 0,0x286b
	subf 9,9,27
	ori 0,0,51739
	mtlr 10
	mullw 9,9,0
	srawi 29,9,2
	blrl
	cmpwi 0,3,3
	bc 4,2,.L96
	lwz 0,160(28)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	slwi 0,29,2
	addi 9,9,740
	stwx 3,9,0
	b .L97
.L96:
	lwz 9,84(31)
	slwi 10,29,2
	lwz 11,48(27)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
.L97:
	bc 12,18,.L58
.L94:
	bc 12,18,.L99
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
.L103:
	lwz 0,4(11)
	cmpwi 0,0,0
	bc 12,2,.L102
	lwz 0,56(11)
	andi. 9,0,7
	bc 4,2,.L102
	lwz 9,84(31)
	addi 9,9,740
	stwx 8,9,10
.L102:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 11,11,76
	cmpw 0,29,0
	bc 12,0,.L103
	b .L58
.L99:
	mr 3,26
	bl FindItem
	mr. 27,3
	bc 4,2,.L107
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	bl FindItem
	mr. 27,3
	bc 4,2,.L107
	lwz 0,8(29)
	lis 5,.LC12@ha
	mr 3,31
	la 5,.LC12@l(5)
	b .L115
.L107:
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 4,2,.L109
	lis 9,gi+8@ha
	lis 5,.LC13@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC13@l(5)
.L115:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L58
.L109:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,56(27)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,27
	andi. 10,11,2
	mullw 9,9,0
	srawi 29,9,2
	bc 12,2,.L110
	lis 9,gi@ha
	la 28,gi@l(9)
	lwz 9,156(28)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L111
	lwz 0,160(28)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	slwi 0,29,2
	addi 9,9,740
	stwx 3,9,0
	b .L58
.L111:
	lwz 9,84(31)
	slwi 10,29,2
	lwz 11,48(27)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L58
.L110:
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
.Lfe1:
	.size	 Cmd_Give_f,.Lfe1-Cmd_Give_f
	.section	".rodata"
	.align 2
.LC15:
	.string	"godmode OFF\n"
	.align 2
.LC16:
	.string	"godmode ON\n"
	.align 2
.LC17:
	.string	"notarget OFF\n"
	.align 2
.LC18:
	.string	"notarget ON\n"
	.align 2
.LC19:
	.string	"noclip OFF\n"
	.align 2
.LC20:
	.string	"noclip ON\n"
	.align 2
.LC21:
	.string	"tball"
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
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+164@ha
	mr 31,3
	lwz 0,gi+164@l(9)
	lis 29,.LC21@ha
	mtlr 0
	blrl
	mr 30,3
	la 4,.LC21@l(29)
	li 5,5
	bl strncmp
	cmpwi 0,3,0
	mr 3,30
	bc 4,2,.L129
	la 3,.LC21@l(29)
.L129:
	bl FindItem
	mr 4,3
	cmpwi 0,4,0
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
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L128
.L132:
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
	b .L128
.L133:
	mr 3,31
	mtlr 10
	blrl
.L128:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Cmd_Use_f,.Lfe2-Cmd_Use_f
	.section	".rodata"
	.align 2
.LC25:
	.string	"special"
	.align 2
.LC26:
	.string	"Damage Amp"
	.align 2
.LC27:
	.string	"boomerang"
	.align 2
.LC28:
	.string	"resist"
	.align 2
.LC29:
	.string	"No special item to drop.\n"
	.align 2
.LC30:
	.string	"Item is not dropable.\n"
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
	mr 31,3
	la 28,gi@l(9)
	lwz 9,164(28)
	mtlr 9
	blrl
	mr 30,3
	lis 4,.LC25@ha
	la 4,.LC25@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L137
	lis 3,.LC26@ha
	lis 30,0x286b
	la 3,.LC26@l(3)
	ori 30,30,51739
	bl FindItem
	lis 9,itemlist@ha
	mr 10,3
	lwz 11,84(31)
	la 29,itemlist@l(9)
	subf 0,29,10
	addi 11,11,740
	mullw 0,0,30
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L141
	lis 3,.LC27@ha
	la 3,.LC27@l(3)
	bl FindItem
	mr 10,3
	lwz 11,84(31)
	subf 0,29,10
	mullw 0,0,30
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L141
	lis 3,.LC28@ha
	la 3,.LC28@l(3)
	bl FindItem
	mr 10,3
	lwz 11,84(31)
	subf 0,29,10
	mullw 0,0,30
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L141
	lwz 0,8(28)
	lis 5,.LC29@ha
	mr 3,31
	la 5,.LC29@l(5)
	b .L145
.L137:
	mr 3,30
	bl FindItem
	mr. 10,3
	bc 4,2,.L142
	lwz 0,8(28)
	lis 5,.LC22@ha
	mr 3,31
	la 5,.LC22@l(5)
	b .L146
.L142:
	lwz 0,12(10)
	cmpwi 0,0,0
	bc 4,2,.L143
	lwz 0,8(28)
	lis 5,.LC30@ha
	mr 3,31
	la 5,.LC30@l(5)
.L145:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L136
.L143:
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
	bc 4,2,.L141
	lwz 0,8(28)
	lis 5,.LC24@ha
	mr 3,31
	la 5,.LC24@l(5)
.L146:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L136
.L141:
	lwz 0,12(10)
	mr 3,31
	mr 4,10
	mtlr 0
	blrl
.L136:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 Cmd_Drop_f,.Lfe3-Cmd_Drop_f
	.section	".rodata"
	.align 2
.LC31:
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
	lwz 0,3932(7)
	cmpwi 0,0,0
	bc 12,2,.L157
	bl PMenu_Select
	b .L156
.L171:
	stw 11,736(7)
	b .L159
.L157:
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L159
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L172:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L164
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L164
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L171
.L164:
	addi 8,8,1
	bdnz .L172
	li 0,-1
	stw 0,736(7)
.L159:
	lwz 9,84(3)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L169
	lis 9,gi+8@ha
	lis 5,.LC31@ha
	lwz 0,gi+8@l(9)
	la 5,.LC31@l(5)
	b .L173
.L169:
	mulli 0,0,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L170
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	la 5,.LC23@l(5)
.L173:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L156
.L170:
	mtlr 0
	blrl
.L156:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 Cmd_InvUse_f,.Lfe4-Cmd_InvUse_f
	.section	".rodata"
	.align 2
.LC32:
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
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L204
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L217:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L209
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L209
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L216
.L209:
	addi 8,8,1
	bdnz .L217
	li 0,-1
	stw 0,736(7)
.L204:
	lwz 9,84(3)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L214
	lis 9,gi+8@ha
	lis 5,.LC32@ha
	lwz 0,gi+8@l(9)
	la 5,.LC32@l(5)
	b .L218
.L216:
	stw 11,736(7)
	b .L204
.L214:
	mulli 0,0,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L215
	lis 9,gi+8@ha
	lis 5,.LC30@ha
	lwz 0,gi+8@l(9)
	la 5,.LC30@l(5)
.L218:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L202
.L215:
	mtlr 0
	blrl
.L202:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_InvDrop_f,.Lfe5-Cmd_InvDrop_f
	.section	".rodata"
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
	bc 4,0,.L228
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L230:
	lwz 0,0(11)
	addi 11,11,3964
	cmpwi 0,0,0
	bc 12,2,.L229
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L229:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L230
.L228:
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
	bc 4,0,.L234
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC33@ha
	lis 25,.LC34@ha
.L236:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC33@l(26)
	addi 28,28,4
	mulli 7,7,3964
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
	bc 4,1,.L237
	la 4,.LC34@l(25)
	mr 3,30
	bl strcat
	b .L234
.L237:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L236
.L234:
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
	bc 4,2,.L239
	lwz 0,3820(9)
	cmpwi 0,0,1
	bc 12,1,.L239
	cmplwi 0,3,4
	li 0,1
	stw 0,3820(9)
	bc 12,1,.L248
	lis 11,.L249@ha
	slwi 10,3,2
	la 11,.L249@l(11)
	lis 9,.L249@ha
	lwzx 0,10,11
	la 9,.L249@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L249:
	.long .L243-.L249
	.long .L244-.L249
	.long .L245-.L249
	.long .L246-.L249
	.long .L248-.L249
.L243:
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
	b .L250
.L244:
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
	b .L250
.L245:
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
	b .L250
.L246:
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
	b .L250
.L248:
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
.L250:
	stw 0,56(31)
	stw 9,3816(11)
.L239:
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
	.string	"(%s): "
	.align 2
.LC44:
	.string	"%s: "
	.align 2
.LC45:
	.string	" "
	.align 2
.LC46:
	.string	"\n"
	.align 2
.LC47:
	.string	"You can't talk for %d more seconds\n"
	.align 2
.LC48:
	.string	"Flood protection:  You can't talk for %d seconds.\n"
	.align 2
.LC49:
	.string	"%s"
	.align 2
.LC50:
	.long 0x0
	.align 3
.LC51:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC52:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Cmd_Say_f
	.type	 Cmd_Say_f,@function
Cmd_Say_f:
	stwu 1,-3152(1)
	mflr 0
	mfcr 12
	stfd 31,3144(1)
	stmw 24,3112(1)
	stw 0,3156(1)
	stw 12,3108(1)
	lis 9,gi+156@ha
	mr 30,3
	lwz 0,gi+156@l(9)
	mr 29,4
	mr 31,5
	mtlr 0
	blrl
	cmpwi 0,3,1
	bc 12,1,.L252
	cmpwi 0,31,0
	bc 12,2,.L251
.L252:
	lis 11,.LC50@ha
	lis 9,kots_teamplay@ha
	la 11,.LC50@l(11)
	lis 24,kots_teamplay@ha
	lfs 13,0(11)
	lwz 11,kots_teamplay@l(9)
	lfs 0,20(11)
	fcmpu 7,0,13
	crnor 31,30,30
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	and. 28,29,0
	bc 12,2,.L254
	lwz 6,84(30)
	lis 5,.LC43@ha
	addi 3,1,8
	la 5,.LC43@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L255
.L254:
	lwz 6,84(30)
	lis 5,.LC44@ha
	addi 3,1,8
	la 5,.LC44@l(5)
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
	lis 4,.LC45@ha
	addi 3,1,8
	la 4,.LC45@l(4)
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
	lis 4,.LC46@ha
	addi 3,1,8
	la 4,.LC46@l(4)
	bl strcat
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 8,0(9)
	lis 9,flood_msgs@ha
	lwz 11,flood_msgs@l(9)
	lfs 9,20(11)
	fcmpu 0,9,8
	bc 12,2,.L260
	lwz 7,84(30)
	lis 9,level+4@ha
	lfs 10,level+4@l(9)
	lfs 0,3868(7)
	fcmpu 0,10,0
	bc 4,0,.L261
	fsubs 0,0,10
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC47@ha
	mr 3,30
	la 5,.LC47@l(5)
	li 4,2
	mtlr 0
	fctiwz 13,0
	stfd 13,3096(1)
	b .L279
.L261:
	lwz 0,3912(7)
	lis 10,0x4330
	lis 11,.LC51@ha
	addi 8,7,3872
	mr 6,0
	la 11,.LC51@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,3100(1)
	lis 11,.LC52@ha
	stw 10,3096(1)
	la 11,.LC52@l(11)
	lfd 0,3096(1)
	mr 10,8
	lfs 11,0(11)
	mr 11,9
	fsub 0,0,13
	frsp 0,0
	fsubs 0,0,9
	fadds 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,3096(1)
	lwz 11,3100(1)
	nor 0,11,11
	addi 9,11,10
	srawi 0,0,31
	andc 9,9,0
	and 11,11,0
	or 11,11,9
	slwi 11,11,2
	lfsx 0,8,11
	fcmpu 0,0,8
	bc 12,2,.L263
	lis 11,flood_persecond@ha
	fsubs 13,10,0
	lwz 9,flood_persecond@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L263
	lis 9,flood_waitdelay@ha
	lis 10,gi+8@ha
	lwz 11,flood_waitdelay@l(9)
	lis 5,.LC48@ha
	mr 3,30
	la 5,.LC48@l(5)
	lfs 13,20(11)
	li 4,3
	fadds 13,10,13
	stfs 13,3868(7)
	lfs 0,20(11)
	lwz 0,gi+8@l(10)
	mtlr 0
	fctiwz 12,0
	stfd 12,3096(1)
.L279:
	lwz 6,3100(1)
	crxor 6,6,6
	blrl
	b .L251
.L263:
	lis 0,0xcccc
	addi 9,6,1
	ori 0,0,52429
	lis 11,level+4@ha
	mulhwu 0,9,0
	srwi 0,0,3
	mulli 0,0,10
	subf 9,0,9
	stw 9,3912(7)
	lfs 0,level+4@l(11)
	slwi 9,9,2
	stfsx 0,10,9
.L260:
	lis 9,.LC50@ha
	lis 11,dedicated@ha
	la 9,.LC50@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L264
	lis 9,gi+8@ha
	lis 5,.LC49@ha
	lwz 0,gi+8@l(9)
	la 5,.LC49@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L264:
	lis 9,game@ha
	li 29,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,29,0
	bc 12,1,.L251
	lis 9,gi@ha
	cmpwi 4,28,0
	la 25,gi@l(9)
	mr 26,11
	lis 9,.LC50@ha
	lis 27,g_edicts@ha
	la 9,.LC50@l(9)
	lis 28,.LC49@ha
	lfs 31,0(9)
	li 31,976
.L268:
	lwz 0,g_edicts@l(27)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L267
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 12,2,.L267
	bc 12,18,.L271
	lwz 9,kots_teamplay@l(24)
	lfs 0,20(9)
	fcmpu 0,0,31
	li 9,0
	bc 12,2,.L274
	lwz 9,84(30)
	cmpwi 0,9,0
	bc 4,2,.L276
	li 9,0
	b .L274
.L276:
	lwz 9,3584(9)
	lwz 0,3584(11)
	xor 9,9,0
	subfic 11,9,0
	adde 9,11,9
.L274:
	cmpwi 0,9,0
	bc 12,2,.L267
.L271:
	lwz 9,8(25)
	li 4,3
	la 5,.LC49@l(28)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L267:
	lwz 0,1544(26)
	addi 29,29,1
	addi 31,31,976
	cmpw 0,29,0
	bc 4,1,.L268
.L251:
	lwz 0,3156(1)
	lwz 12,3108(1)
	mtlr 0
	lmw 24,3112(1)
	lfd 31,3144(1)
	mtcrf 8,12
	la 1,3152(1)
	blr
.Lfe8:
	.size	 Cmd_Say_f,.Lfe8-Cmd_Say_f
	.section	".rodata"
	.align 2
.LC53:
	.string	"%02d:%02d %4d %3d %s%s\n"
	.align 2
.LC54:
	.string	" (spectator)"
	.align 2
.LC55:
	.string	""
	.align 2
.LC56:
	.string	"And more...\n"
	.align 2
.LC57:
	.long 0x0
	.align 3
.LC58:
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
	lis 9,.LC57@ha
	stb 0,96(1)
	li 28,0
	la 9,.LC57@l(9)
	lfs 0,20(11)
	lis 22,maxclients@ha
	lfs 13,0(9)
	addi 31,1,96
	lis 21,gi@ha
	lwz 9,g_edicts@l(10)
	lis 20,.LC49@ha
	fcmpu 0,13,0
	addi 30,9,976
	bc 4,0,.L282
	lis 9,.LC54@ha
	lis 11,.LC55@ha
	la 23,.LC54@l(9)
	la 24,.LC55@l(11)
	lis 25,level@ha
	lis 26,0x4330
.L284:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L283
	lwz 10,84(30)
	lis 11,0x1b4e
	lis 8,0x6666
	lwz 9,level@l(25)
	ori 11,11,33205
	ori 8,8,26215
	lwz 0,3556(10)
	addi 29,10,700
	lwz 7,3576(10)
	subf 9,0,9
	lwz 3,184(10)
	mulhw 11,9,11
	lwz 4,3560(10)
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
	bc 12,2,.L286
	stw 23,8(1)
	b .L287
.L286:
	stw 24,8(1)
.L287:
	mr 8,3
	mr 9,4
	lis 5,.LC53@ha
	mr 10,29
	addi 3,1,16
	la 5,.LC53@l(5)
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
	bc 4,1,.L288
	mr 3,31
	bl strlen
	lis 4,.LC56@ha
	add 3,31,3
	la 4,.LC56@l(4)
	crxor 6,6,6
	bl sprintf
	la 9,gi@l(21)
	mr 3,27
	lwz 0,8(9)
	la 5,.LC49@l(20)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L280
.L288:
	mr 3,31
	addi 4,1,16
	bl strcat
.L283:
	addi 28,28,1
	lwz 11,maxclients@l(22)
	xoris 0,28,0x8000
	lis 10,.LC58@ha
	stw 0,1516(1)
	la 10,.LC58@l(10)
	addi 30,30,976
	stw 26,1512(1)
	lfd 13,0(10)
	lfd 0,1512(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L284
.L282:
	lis 9,gi+8@ha
	lis 5,.LC49@ha
	lwz 0,gi+8@l(9)
	mr 3,27
	la 5,.LC49@l(5)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L280:
	lwz 0,1572(1)
	mtlr 0
	lmw 20,1520(1)
	la 1,1568(1)
	blr
.Lfe9:
	.size	 Cmd_PlayerList_f,.Lfe9-Cmd_PlayerList_f
	.section	".rodata"
	.align 2
.LC59:
	.string	"players"
	.align 2
.LC60:
	.string	"say"
	.align 2
.LC61:
	.string	"say_team"
	.align 2
.LC62:
	.string	"score"
	.align 2
.LC63:
	.string	"help"
	.align 2
.LC64:
	.string	"use"
	.align 2
.LC65:
	.string	"drop"
	.align 2
.LC66:
	.string	"give"
	.align 2
.LC67:
	.string	"god"
	.align 2
.LC68:
	.string	"notarget"
	.align 2
.LC69:
	.string	"noclip"
	.align 2
.LC70:
	.string	"inven"
	.align 2
.LC71:
	.string	"invnext"
	.align 2
.LC72:
	.string	"invprev"
	.align 2
.LC73:
	.string	"invnextw"
	.align 2
.LC74:
	.string	"invprevw"
	.align 2
.LC75:
	.string	"invnextp"
	.align 2
.LC76:
	.string	"invprevp"
	.align 2
.LC77:
	.string	"invuse"
	.align 2
.LC78:
	.string	"invdrop"
	.align 2
.LC79:
	.string	"weapprev"
	.align 2
.LC80:
	.string	"weapnext"
	.align 2
.LC81:
	.string	"weaplast"
	.align 2
.LC82:
	.string	"kill"
	.align 2
.LC83:
	.string	"putaway"
	.align 2
.LC84:
	.string	"wave"
	.align 2
.LC85:
	.string	"playerlist"
	.align 2
.LC86:
	.string	"cloak"
	.align 2
.LC87:
	.string	"fly"
	.align 2
.LC88:
	.string	"menu"
	.align 2
.LC89:
	.string	"kotsinfo"
	.align 2
.LC90:
	.string	"vote"
	.align 2
.LC91:
	.string	"kotslaser"
	.align 2
.LC92:
	.string	"hook"
	.align 2
.LC93:
	.string	"kotshealth"
	.align 2
.LC94:
	.string	"kotshelp"
	.align 2
.LC95:
	.string	"kotskick"
	.align 2
.LC96:
	.string	"kotstball"
	.align 2
.LC97:
	.string	"kotsnotball"
	.align 2
.LC98:
	.string	"kotsstoptball"
	.align 2
.LC99:
	.string	"kotsbfgball"
	.align 2
.LC100:
	.string	"kotsboomerang"
	.align 2
.LC101:
	.string	"kotsflash"
	.align 2
.LC102:
	.string	"kotsexpack"
	.align 2
.LC103:
	.string	"kotschange"
	.align 2
.LC104:
	.string	"kotsteam"
	.align 2
.LC105:
	.string	"kotshelmet"
	.align 2
.LC106:
	.string	"type \"use tball\" to use a tball.\n"
	.align 2
.LC107:
	.long 0x0
	.align 2
.LC108:
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
	bc 12,2,.L290
	lis 9,gi@ha
	li 3,0
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC59@ha
	la 4,.LC59@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L292
	mr 3,29
	bl Cmd_Players_f
	b .L290
.L292:
	lis 4,.LC60@ha
	mr 3,31
	la 4,.LC60@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L293
	mr 3,29
	li 4,0
	b .L527
.L293:
	lis 4,.LC61@ha
	mr 3,31
	la 4,.LC61@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L294
	mr 3,29
	li 4,1
.L527:
	li 5,0
	bl Cmd_Say_f
	b .L290
.L294:
	lis 4,.LC62@ha
	mr 3,31
	la 4,.LC62@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L295
	mr 3,29
	bl Cmd_Score_f
	b .L290
.L295:
	lis 4,.LC63@ha
	mr 3,31
	la 4,.LC63@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L296
	mr 3,29
	bl Cmd_Help_f
	b .L290
.L296:
	lis 8,.LC107@ha
	lis 9,level+200@ha
	la 8,.LC107@l(8)
	lfs 0,level+200@l(9)
	lfs 31,0(8)
	fcmpu 0,0,31
	bc 4,2,.L290
	lis 4,.LC64@ha
	mr 3,31
	la 4,.LC64@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L298
	mr 3,29
	bl Cmd_Use_f
	b .L290
.L298:
	lis 4,.LC65@ha
	mr 3,31
	la 4,.LC65@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L300
	mr 3,29
	bl Cmd_Drop_f
	b .L290
.L300:
	lis 4,.LC66@ha
	mr 3,31
	la 4,.LC66@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L302
	mr 3,29
	bl Cmd_Give_f
	b .L290
.L302:
	lis 4,.LC67@ha
	mr 3,31
	la 4,.LC67@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L304
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L305
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L305
	lwz 0,8(30)
	lis 5,.LC1@ha
	mr 3,29
	la 5,.LC1@l(5)
	b .L528
.L305:
	lwz 0,264(29)
	xori 0,0,16
	andi. 8,0,16
	stw 0,264(29)
	bc 4,2,.L307
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
	b .L320
.L307:
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L320
.L304:
	lis 4,.LC68@ha
	mr 3,31
	la 4,.LC68@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L310
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L311
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L311
	lwz 0,8(30)
	lis 5,.LC1@ha
	mr 3,29
	la 5,.LC1@l(5)
	b .L528
.L311:
	lwz 0,264(29)
	xori 0,0,32
	andi. 8,0,32
	stw 0,264(29)
	bc 4,2,.L313
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
	b .L320
.L313:
	lis 9,.LC18@ha
	la 5,.LC18@l(9)
	b .L320
.L310:
	lis 4,.LC69@ha
	mr 3,31
	la 4,.LC69@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L316
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L317
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L317
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC1@l(5)
	b .L528
.L317:
	lwz 0,260(29)
	cmpwi 0,0,1
	bc 4,2,.L319
	li 0,4
	lis 9,.LC19@ha
	stw 0,260(29)
	la 5,.LC19@l(9)
	b .L320
.L319:
	li 0,1
	lis 9,.LC20@ha
	stw 0,260(29)
	la 5,.LC20@l(9)
.L320:
	lis 9,gi+8@ha
	mr 3,29
	lwz 0,gi+8@l(9)
.L528:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L290
.L316:
	lis 4,.LC70@ha
	mr 3,31
	la 4,.LC70@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L322
	lwz 31,84(29)
	stw 3,3628(31)
	stw 3,3620(31)
	lwz 11,84(29)
	lwz 9,3932(11)
	cmpwi 0,9,0
	bc 4,2,.L529
	lwz 0,3624(31)
	cmpwi 0,0,0
	bc 4,2,.L530
	lwz 0,1868(11)
	cmpwi 0,0,0
	bc 4,2,.L531
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3624(31)
	li 3,5
	lwz 0,100(9)
	addi 30,31,1760
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L329:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,30
	bc 4,1,.L329
	b .L532
.L322:
	lis 4,.LC71@ha
	mr 3,31
	la 4,.LC71@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L333
	lwz 8,84(29)
	lwz 0,3932(8)
	cmpwi 0,0,0
	bc 4,2,.L533
	lwz 0,3920(8)
	cmpwi 0,0,0
	bc 4,2,.L534
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L526:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L341
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L341
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L519
.L341:
	addi 7,7,1
	bdnz .L526
	b .L535
.L333:
	lis 4,.LC72@ha
	mr 3,31
	la 4,.LC72@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L347
	lwz 7,84(29)
	lwz 0,3932(7)
	cmpwi 0,0,0
	bc 4,2,.L536
	lwz 0,3920(7)
	cmpwi 0,0,0
	bc 4,2,.L537
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L525:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L355
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L355
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L520
.L355:
	addi 11,11,-1
	bdnz .L525
	b .L538
.L347:
	lis 4,.LC73@ha
	mr 3,31
	la 4,.LC73@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L360
	lwz 8,84(29)
	lwz 0,3932(8)
	cmpwi 0,0,0
	bc 4,2,.L533
	lwz 0,3920(8)
	cmpwi 0,0,0
	bc 4,2,.L534
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L524:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L368
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L368
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L519
.L368:
	addi 7,7,1
	bdnz .L524
	b .L535
.L360:
	lis 4,.LC74@ha
	mr 3,31
	la 4,.LC74@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L374
	lwz 7,84(29)
	lwz 0,3932(7)
	cmpwi 0,0,0
	bc 4,2,.L536
	lwz 0,3920(7)
	cmpwi 0,0,0
	bc 4,2,.L537
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L523:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L382
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L382
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L520
.L382:
	addi 11,11,-1
	bdnz .L523
	b .L538
.L374:
	lis 4,.LC75@ha
	mr 3,31
	la 4,.LC75@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L387
	lwz 8,84(29)
	lwz 0,3932(8)
	cmpwi 0,0,0
	bc 12,2,.L388
.L533:
	mr 3,29
	bl PMenu_Next
	b .L290
.L388:
	lwz 0,3920(8)
	cmpwi 0,0,0
	bc 12,2,.L390
.L534:
	mr 3,29
	bl ChaseNext
	b .L290
.L390:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
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
	bc 12,2,.L395
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L395
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L519
.L395:
	addi 7,7,1
	bdnz .L522
.L535:
	li 0,-1
	stw 0,736(8)
	b .L290
.L387:
	lis 4,.LC76@ha
	mr 3,31
	la 4,.LC76@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L401
	lwz 7,84(29)
	lwz 0,3932(7)
	cmpwi 0,0,0
	bc 12,2,.L402
.L536:
	mr 3,29
	bl PMenu_Prev
	b .L290
.L402:
	lwz 0,3920(7)
	cmpwi 0,0,0
	bc 12,2,.L404
.L537:
	mr 3,29
	bl ChasePrev
	b .L290
.L404:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L521:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L409
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L409
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L520
.L409:
	addi 11,11,-1
	bdnz .L521
.L538:
	li 0,-1
	stw 0,736(7)
	b .L290
.L401:
	lis 4,.LC77@ha
	mr 3,31
	la 4,.LC77@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L414
	mr 3,29
	bl Cmd_InvUse_f
	b .L290
.L414:
	lis 4,.LC78@ha
	mr 3,31
	la 4,.LC78@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L416
	mr 3,29
	bl Cmd_InvDrop_f
	b .L290
.L416:
	lis 4,.LC79@ha
	mr 3,31
	la 4,.LC79@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L418
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L290
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
.L423:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L425
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L425
	lwz 0,56(31)
	andi. 8,0,1
	bc 12,2,.L425
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L290
.L425:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L423
	b .L290
.L418:
	lis 4,.LC80@ha
	mr 3,31
	la 4,.LC80@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L431
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L290
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
.L436:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L438
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L438
	lwz 0,56(31)
	andi. 8,0,1
	bc 12,2,.L438
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L290
.L438:
	addi 27,27,1
	addi 30,30,-1
	cmpwi 0,27,256
	bc 4,1,.L436
	b .L290
.L431:
	lis 4,.LC81@ha
	mr 3,31
	la 4,.LC81@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L444
	lwz 10,84(29)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L290
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L290
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
	bc 12,2,.L290
	mulli 0,10,76
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L290
	lwz 0,56(4)
	andi. 8,0,1
	bc 12,2,.L290
	mr 3,29
	mtlr 9
	blrl
	b .L290
.L444:
	lis 4,.LC82@ha
	mr 3,31
	la 4,.LC82@l(4)
	bl Q_stricmp
	mr. 10,3
	bc 4,2,.L452
	lwz 11,84(29)
	lis 9,level+4@ha
	lis 8,.LC108@ha
	lfs 0,level+4@l(9)
	la 8,.LC108@l(8)
	lfs 13,3916(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L290
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
	b .L290
.L452:
	lis 4,.LC83@ha
	mr 3,31
	la 4,.LC83@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L456
	lwz 9,84(29)
	stw 3,3620(9)
	lwz 11,84(29)
	stw 3,3628(11)
	lwz 9,84(29)
	stw 3,3624(9)
	lwz 11,84(29)
	lwz 0,3932(11)
	cmpwi 0,0,0
	bc 12,2,.L539
	mr 3,29
	bl PMenu_Close
	b .L539
.L456:
	lis 4,.LC84@ha
	mr 3,31
	la 4,.LC84@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L460
	mr 3,29
	bl Cmd_Wave_f
	b .L290
.L460:
	lis 4,.LC85@ha
	mr 3,31
	la 4,.LC85@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L462
	mr 3,29
	bl Cmd_PlayerList_f
	b .L290
.L462:
	lis 4,.LC86@ha
	mr 3,31
	la 4,.LC86@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L464
	mr 3,29
	bl KOTSCmd_Cloak
	b .L290
.L464:
	lis 4,.LC87@ha
	mr 3,31
	la 4,.LC87@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L466
	mr 3,29
	bl KOTSCmd_Fly
	b .L290
.L466:
	lis 4,.LC88@ha
	mr 3,31
	la 4,.LC88@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L468
	lwz 31,84(29)
	stw 3,3628(31)
	stw 3,3620(31)
	lwz 11,84(29)
	lwz 9,3932(11)
	cmpwi 0,9,0
	bc 12,2,.L469
.L529:
	mr 3,29
	bl PMenu_Close
.L539:
	lwz 9,84(29)
	li 0,1
	stw 0,3924(9)
	b .L290
.L469:
	lwz 0,3624(31)
	cmpwi 0,0,0
	bc 12,2,.L471
.L530:
	stw 9,3624(31)
	b .L290
.L471:
	lwz 0,1868(11)
	cmpwi 0,0,0
	bc 12,2,.L472
.L531:
	mr 3,29
	bl KOTSOpenJoinMenu
	b .L290
.L472:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3624(31)
	li 3,5
	lwz 0,100(9)
	addi 30,31,1760
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L475:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,30
	bc 4,1,.L475
.L532:
	lis 9,gi+92@ha
	mr 3,29
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L290
.L468:
	lis 4,.LC89@ha
	mr 3,31
	la 4,.LC89@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L479
	mr 3,29
	bl KOTSCmd_Info_f
	b .L290
.L479:
	lis 4,.LC90@ha
	mr 3,31
	la 4,.LC90@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L481
	mr 3,29
	bl KOTSCmd_Vote_f
	b .L290
.L481:
	lis 4,.LC91@ha
	mr 3,31
	la 4,.LC91@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L483
	mr 3,29
	bl KOTSCmd_Laser
	b .L290
.L483:
	lis 4,.LC92@ha
	mr 3,31
	la 4,.LC92@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L485
	mr 3,29
	bl KOTSCmd_Hook
	b .L290
.L485:
	lis 4,.LC93@ha
	mr 3,31
	la 4,.LC93@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L487
	mr 3,29
	bl KOTSCmd_MakeMega
	b .L290
.L487:
	lis 4,.LC94@ha
	mr 3,31
	la 4,.LC94@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L489
	mr 3,29
	bl KOTSCmd_Help
	b .L290
.L489:
	lis 4,.LC95@ha
	mr 3,31
	la 4,.LC95@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L491
	mr 3,29
	bl KOTSCmd_Kick
	b .L290
.L491:
	lis 4,.LC96@ha
	mr 3,31
	la 4,.LC96@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L493
	mr 3,29
	bl KOTSCmd_TBall
	b .L290
.L493:
	lis 4,.LC97@ha
	mr 3,31
	la 4,.LC97@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L495
	mr 3,29
	bl KOTSCmd_NoTBall
	b .L290
.L495:
	lis 4,.LC98@ha
	mr 3,31
	la 4,.LC98@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L497
	mr 3,29
	bl KOTSCmd_StopTBall
	b .L290
.L497:
	lis 4,.LC99@ha
	mr 3,31
	la 4,.LC99@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L499
	mr 3,29
	bl KOTSCmd_BFGBall
	b .L290
.L499:
	lis 4,.LC100@ha
	mr 3,31
	la 4,.LC100@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L501
	mr 3,29
	bl KOTSCmd_Boomerang
	b .L290
.L501:
	lis 4,.LC101@ha
	mr 3,31
	la 4,.LC101@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L503
	mr 3,29
	bl KOTSCmd_Flash
	b .L290
.L503:
	lis 4,.LC102@ha
	mr 3,31
	la 4,.LC102@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L505
	mr 3,29
	bl KOTSCmd_EXPack
	b .L290
.L505:
	lis 4,.LC103@ha
	mr 3,31
	la 4,.LC103@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L507
	mr 3,29
	bl KOTSCmd_ChangeTeams
	b .L290
.L507:
	lis 4,.LC104@ha
	mr 3,31
	la 4,.LC104@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L509
	mr 3,29
	bl KOTSCmd_Team
	b .L290
.L509:
	lis 4,.LC105@ha
	mr 3,31
	la 4,.LC105@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L511
	mr 3,29
	bl KOTSCmd_Helmet
	b .L290
.L511:
	lis 4,.LC21@ha
	mr 3,31
	la 4,.LC21@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L513
	lis 9,gi+12@ha
	lis 4,.LC106@ha
	lwz 0,gi+12@l(9)
	mr 3,29
	la 4,.LC106@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L290
.L519:
	stw 11,736(8)
	b .L290
.L520:
	stw 8,736(7)
	b .L290
.L513:
	mr 3,29
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L290:
	lwz 0,52(1)
	mtlr 0
	lmw 25,12(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 ClientCommand,.Lfe10-ClientCommand
	.section	".rodata"
	.align 2
.LC109:
	.long 0x0
	.section	".text"
	.align 2
	.globl OnSameTeam
	.type	 OnSameTeam,@function
OnSameTeam:
	stwu 1,-1040(1)
	lis 11,.LC109@ha
	lis 9,kots_teamplay@ha
	la 11,.LC109@l(11)
	lfs 13,0(11)
	lwz 11,kots_teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L13
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L13
	lwz 4,84(4)
	cmpwi 0,4,0
	bc 4,2,.L12
.L13:
	li 3,0
	b .L540
.L12:
	lwz 0,3584(3)
	lwz 3,3584(4)
	xor 3,0,3
	subfic 9,3,0
	adde 3,9,3
.L540:
	la 1,1040(1)
	blr
.Lfe11:
	.size	 OnSameTeam,.Lfe11-OnSameTeam
	.align 2
	.globl ValidateSelectedItem
	.type	 ValidateSelectedItem,@function
ValidateSelectedItem:
	lwz 8,84(3)
	lwz 11,736(8)
	addi 10,8,740
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
.L541:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L53
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L53
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 12,2,.L53
	stw 11,736(8)
	blr
.L53:
	addi 7,7,1
	bdnz .L541
	li 0,-1
	stw 0,736(8)
	blr
.Lfe12:
	.size	 ValidateSelectedItem,.Lfe12-ValidateSelectedItem
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
	bc 12,2,.L543
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
	bc 12,2,.L543
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L9
	addi 3,3,1
	b .L542
.L9:
	stb 30,0(3)
.L543:
	mr 3,31
.L542:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 ClientTeam,.Lfe13-ClientTeam
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
	addi 6,8,740
.L544:
	lwz 11,736(8)
	add 11,11,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L18
	mulli 0,11,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L18
	lwz 0,56(10)
	and. 9,0,4
	bc 12,2,.L18
	stw 11,736(8)
	blr
.L18:
	addi 7,7,1
	bdnz .L544
	li 0,-1
	stw 0,736(8)
	blr
.Lfe14:
	.size	 SelectNextItem,.Lfe14-SelectNextItem
	.align 2
	.globl CmdSelectNextItem
	.type	 CmdSelectNextItem,@function
CmdSelectNextItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 8,84(3)
	lwz 0,3932(8)
	cmpwi 0,0,0
	bc 12,2,.L25
	bl PMenu_Next
	b .L24
.L25:
	lwz 0,3920(8)
	cmpwi 0,0,0
	bc 12,2,.L26
	bl ChaseNext
	b .L24
.L545:
	stw 11,736(8)
	b .L24
.L26:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 3,itemlist@l(9)
	addi 6,8,740
.L546:
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
	mulli 0,11,76
	add 10,0,3
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L31
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L545
.L31:
	addi 7,7,1
	bdnz .L546
	li 0,-1
	stw 0,736(8)
.L24:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 CmdSelectNextItem,.Lfe15-CmdSelectNextItem
	.align 2
	.globl SelectPrevItem
	.type	 SelectPrevItem,@function
SelectPrevItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 7,84(3)
	lwz 0,3932(7)
	cmpwi 0,0,0
	bc 12,2,.L37
	bl PMenu_Prev
	b .L36
.L37:
	lwz 0,3920(7)
	cmpwi 0,0,0
	bc 12,2,.L38
	bl ChasePrev
	b .L36
.L547:
	stw 8,736(7)
	b .L36
.L38:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L548:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L41
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L41
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L547
.L41:
	addi 11,11,-1
	bdnz .L548
	li 0,-1
	stw 0,736(7)
.L36:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 SelectPrevItem,.Lfe16-SelectPrevItem
	.section	".rodata"
	.align 2
.LC110:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC110@ha
	lis 9,deathmatch@ha
	la 11,.LC110@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L117
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L117
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L116
.L117:
	lwz 0,264(3)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(3)
	bc 4,2,.L118
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
	b .L119
.L118:
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
.L119:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L116:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 Cmd_God_f,.Lfe17-Cmd_God_f
	.section	".rodata"
	.align 2
.LC111:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC111@ha
	lis 9,deathmatch@ha
	la 11,.LC111@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L121
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L121
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L120
.L121:
	lwz 0,264(3)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(3)
	bc 4,2,.L122
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
	b .L123
.L122:
	lis 9,.LC18@ha
	la 5,.LC18@l(9)
.L123:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L120:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 Cmd_Notarget_f,.Lfe18-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC112:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC112@ha
	lis 9,deathmatch@ha
	la 11,.LC112@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L125
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L125
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L124
.L125:
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 4,2,.L126
	li 0,4
	lis 9,.LC19@ha
	stw 0,260(3)
	la 5,.LC19@l(9)
	b .L127
.L126:
	li 0,1
	lis 9,.LC20@ha
	stw 0,260(3)
	la 5,.LC20@l(9)
.L127:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L124:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 Cmd_Noclip_f,.Lfe19-Cmd_Noclip_f
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
	stw 0,3628(31)
	stw 0,3620(31)
	lwz 11,84(30)
	lwz 9,3932(11)
	cmpwi 0,9,0
	bc 12,2,.L148
	bl PMenu_Close
	lwz 9,84(30)
	li 0,1
	stw 0,3924(9)
	b .L147
.L148:
	lwz 0,3624(31)
	cmpwi 0,0,0
	bc 12,2,.L149
	stw 9,3624(31)
	b .L147
.L149:
	lwz 0,1868(11)
	cmpwi 0,0,0
	bc 12,2,.L150
	mr 3,30
	bl KOTSOpenJoinMenu
	b .L147
.L150:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3624(31)
	li 3,5
	lwz 0,100(9)
	addi 29,31,1760
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L154:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,29
	bc 4,1,.L154
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L147:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 Cmd_Inven_f,.Lfe20-Cmd_Inven_f
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
	bc 12,2,.L174
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
.L179:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L178
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L178
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L178
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L174
.L178:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L179
.L174:
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
	bc 12,2,.L185
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
.L190:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L189
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L189
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L189
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L185
.L189:
	addi 28,28,1
	addi 30,30,-1
	cmpwi 0,28,256
	bc 4,1,.L190
.L185:
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
	bc 12,2,.L196
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L196
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
	bc 12,2,.L196
	mulli 0,10,76
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L196
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L196
	mtlr 9
	blrl
.L196:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 Cmd_WeapLast_f,.Lfe23-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC113:
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
	lis 8,.LC113@ha
	lfs 0,level+4@l(9)
	la 8,.LC113@l(8)
	lfs 13,3916(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L219
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
.L219:
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
	stw 0,3620(9)
	lwz 11,84(31)
	stw 0,3628(11)
	lwz 9,84(31)
	stw 0,3624(9)
	lwz 11,84(31)
	lwz 0,3932(11)
	cmpwi 0,0,0
	bc 12,2,.L222
	bl PMenu_Close
.L222:
	lwz 9,84(31)
	li 0,1
	stw 0,3924(9)
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
	mulli 9,9,3964
	mulli 11,3,3964
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
