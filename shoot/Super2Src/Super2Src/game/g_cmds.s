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
	lis 11,.LC1@ha
	lis 9,ctf@ha
	la 11,.LC1@l(11)
	mr 29,4
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L11
	bl CTFSameTeam
	b .L22
.L11:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 11,1044(1)
	andi. 0,11,192
	bc 4,2,.L12
	li 3,0
	b .L22
.L12:
	lis 9,value.6@ha
	li 30,0
	stb 30,value.6@l(9)
	la 31,value.6@l(9)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L24
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
	bc 12,2,.L24
	lis 9,dmflags@ha
	lwz 11,dmflags@l(9)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 9,1044(1)
	andi. 0,9,128
	bc 12,2,.L16
	stb 30,0(3)
.L24:
	mr 3,31
	b .L14
.L16:
	addi 3,3,1
.L14:
	mr 4,3
	li 28,0
	addi 3,1,8
	bl strcpy
	lis 9,value.6@ha
	addi 30,1,520
	stb 28,value.6@l(9)
	mr 27,30
	la 31,value.6@l(9)
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 12,2,.L26
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
	bc 12,2,.L26
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 11,1044(1)
	andi. 0,11,128
	bc 12,2,.L20
	stb 28,0(3)
.L26:
	mr 3,31
	b .L18
.L20:
	addi 3,3,1
.L18:
	mr 4,3
	mr 3,30
	bl strcpy
	mr 4,27
	addi 3,1,8
	bl strcmp
	subfic 0,3,0
	adde 3,0,3
.L22:
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
	bc 12,2,.L57
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L57
	lis 9,gi+8@ha
	lis 5,.LC2@ha
	lwz 0,gi+8@l(9)
	la 5,.LC2@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L56
.L57:
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
	bc 4,2,.L61
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
	bc 4,2,.L60
.L61:
	lwz 9,156(28)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L62
	lwz 0,160(28)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	stw 3,480(31)
	b .L63
.L62:
	lwz 0,484(31)
	stw 0,480(31)
.L63:
	cmpwi 4,30,0
	bc 12,18,.L56
.L60:
	bc 4,18,.L66
	lis 4,.LC5@ha
	mr 3,26
	la 4,.LC5@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L65
.L66:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L68
	lis 9,itemlist@ha
	mr 7,11
	la 8,itemlist@l(9)
	li 10,0
.L70:
	mr 27,8
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L69
	lwz 0,56(27)
	andi. 9,0,1
	bc 12,2,.L69
	lwz 11,84(31)
	addi 11,11,740
	lwzx 9,11,10
	addi 9,9,1
	stwx 9,11,10
.L69:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 8,8,72
	cmpw 0,29,0
	bc 12,0,.L70
.L68:
	bc 12,18,.L56
.L65:
	bc 4,18,.L76
	lis 4,.LC6@ha
	mr 3,26
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L75
.L76:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L78
	lis 9,itemlist@ha
	mr 30,11
	la 28,itemlist@l(9)
.L80:
	mr 27,28
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L79
	lwz 0,56(27)
	andi. 9,0,2
	bc 12,2,.L79
	mr 4,27
	mr 3,31
	li 5,1000
	bl Add_Ammo
.L79:
	lwz 0,1556(30)
	addi 29,29,1
	addi 28,28,72
	cmpw 0,29,0
	bc 12,0,.L80
.L78:
	bc 12,18,.L56
.L75:
	bc 4,18,.L86
	lis 4,.LC7@ha
	mr 3,26
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L85
.L86:
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
	addi 9,9,740
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
	addi 9,9,740
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
	addi 9,9,740
	lwz 0,4(11)
	srawi 29,29,3
	slwi 29,29,2
	stwx 0,9,29
	bc 12,18,.L56
.L85:
	bc 4,18,.L89
	lis 4,.LC11@ha
	mr 3,26
	la 4,.LC11@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L88
.L89:
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
	bc 12,2,.L90
	mr 3,29
	bl G_FreeEdict
.L90:
	bc 12,18,.L56
.L88:
	bc 12,18,.L92
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L56
	lis 9,itemlist@ha
	mr 7,11
	la 11,itemlist@l(9)
	li 8,1
	li 10,0
.L96:
	lwz 0,4(11)
	cmpwi 0,0,0
	bc 12,2,.L95
	lwz 0,56(11)
	andi. 9,0,7
	bc 4,2,.L95
	lwz 9,84(31)
	addi 9,9,740
	stwx 8,9,10
.L95:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 11,11,72
	cmpw 0,29,0
	bc 12,0,.L96
	b .L56
.L92:
	mr 3,26
	bl FindItem
	mr. 27,3
	bc 4,2,.L100
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	bl FindItem
	mr. 27,3
	bc 4,2,.L100
	lwz 0,4(29)
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	b .L108
.L100:
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 4,2,.L102
	lis 9,gi+4@ha
	lis 3,.LC13@ha
	lwz 0,gi+4@l(9)
	la 3,.LC13@l(3)
.L108:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L56
.L102:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,56(27)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,27
	andi. 10,11,2
	mullw 9,9,0
	srawi 28,9,3
	bc 12,2,.L103
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L104
	lwz 0,160(29)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	slwi 0,28,2
	addi 9,9,740
	stwx 3,9,0
	b .L56
.L104:
	lwz 9,84(31)
	slwi 10,28,2
	lwz 11,48(27)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L56
.L103:
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
	bc 12,2,.L56
	mr 3,29
	bl G_FreeEdict
.L56:
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
	.string	"unknown item: %s\n"
	.align 2
.LC22:
	.string	"Item is not usable.\n"
	.align 2
.LC23:
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
	mr 30,3
	mr 3,31
	mr 4,30
	bl SuperCommand
	cmpwi 0,3,0
	bc 4,2,.L121
	lwz 0,264(31)
	andi. 9,0,8192
	bc 4,2,.L121
	mr 3,30
	bl FindItem
	mr. 4,3
	bc 4,2,.L124
	lwz 0,8(29)
	lis 5,.LC21@ha
	mr 3,31
	la 5,.LC21@l(5)
	b .L127
.L124:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L125
	lwz 0,8(29)
	lis 5,.LC22@ha
	mr 3,31
	la 5,.LC22@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L121
.L125:
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
	bc 4,2,.L126
	lwz 0,8(29)
	lis 5,.LC23@ha
	mr 3,31
	la 5,.LC23@l(5)
.L127:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L121
.L126:
	mr 3,31
	mtlr 10
	blrl
.L121:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 Cmd_Use_f,.Lfe3-Cmd_Use_f
	.section	".rodata"
	.align 2
.LC24:
	.string	"Item is not dropable.\n"
	.align 2
.LC25:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Cmd_Drop_f
	.type	 Cmd_Drop_f,@function
Cmd_Drop_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,264(31)
	andi. 9,0,8192
	bc 4,2,.L128
	lis 9,level@ha
	lfs 13,928(31)
	la 28,level@l(9)
	lfs 0,4(28)
	fcmpu 0,13,0
	bc 12,1,.L128
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 30,3
	bl FindItem
	mr. 3,3
	bc 4,2,.L131
	lwz 0,8(29)
	lis 5,.LC21@ha
	mr 3,31
	la 5,.LC21@l(5)
	b .L134
.L131:
	lwz 10,12(3)
	cmpwi 0,10,0
	bc 4,2,.L132
	lwz 0,8(29)
	lis 5,.LC24@ha
	mr 3,31
	la 5,.LC24@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L128
.L132:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,3
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L133
	lwz 0,8(29)
	lis 5,.LC23@ha
	mr 3,31
	la 5,.LC23@l(5)
.L134:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L128
.L133:
	mr 4,3
	mtlr 10
	mr 3,31
	blrl
	lis 9,.LC25@ha
	lfs 0,4(28)
	la 9,.LC25@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,928(31)
.L128:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 Cmd_Drop_f,.Lfe4-Cmd_Drop_f
	.section	".rodata"
	.align 2
.LC26:
	.string	"No item to use.\n"
	.section	".text"
	.align 2
	.globl Cmd_InvUse_f
	.type	 Cmd_InvUse_f,@function
Cmd_InvUse_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,264(3)
	andi. 9,0,8192
	bc 4,2,.L142
	lwz 7,84(3)
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L145
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L158:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L150
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L150
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L157
.L150:
	addi 8,8,1
	bdnz .L158
	li 0,-1
	stw 0,736(7)
.L145:
	lwz 9,84(3)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L155
	lis 9,gi+8@ha
	lis 5,.LC26@ha
	lwz 0,gi+8@l(9)
	la 5,.LC26@l(5)
	b .L159
.L157:
	stw 11,736(7)
	b .L145
.L155:
	mulli 0,0,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L156
	lis 9,gi+8@ha
	lis 5,.LC22@ha
	lwz 0,gi+8@l(9)
	la 5,.LC22@l(5)
.L159:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L142
.L156:
	mtlr 0
	blrl
.L142:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_InvUse_f,.Lfe5-Cmd_InvUse_f
	.section	".rodata"
	.align 2
.LC27:
	.string	"No item to drop.\n"
	.align 2
.LC28:
	.long 0x40a00000
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
	lwz 0,264(31)
	andi. 9,0,8192
	bc 4,2,.L191
	lis 9,level+4@ha
	lfs 13,928(31)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 12,1,.L191
	lwz 7,84(31)
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L195
	mr 5,11
	lis 9,itemlist@ha
	li 11,256
	la 4,itemlist@l(9)
	mtctr 11
	mr 6,10
	li 8,1
.L208:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L200
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L200
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L207
.L200:
	addi 8,8,1
	bdnz .L208
	li 0,-1
	stw 0,736(7)
.L195:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L205
	lis 9,gi+8@ha
	lis 5,.LC27@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC27@l(5)
	b .L209
.L207:
	stw 11,736(7)
	b .L195
.L205:
	mulli 0,0,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L206
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC24@l(5)
.L209:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L191
.L206:
	mr 3,31
	mtlr 0
	blrl
	lis 11,.LC28@ha
	lis 9,level+4@ha
	la 11,.LC28@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,928(31)
.L191:
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
	bc 4,0,.L218
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L220:
	lwz 0,0(11)
	addi 11,11,3804
	cmpwi 0,0,0
	bc 12,2,.L219
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L219:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L220
.L218:
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
	bc 4,0,.L224
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC29@ha
	lis 25,.LC30@ha
.L226:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC29@l(26)
	addi 28,28,4
	mulli 7,7,3804
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
	bc 4,1,.L227
	la 4,.LC30@l(25)
	mr 3,30
	bl strcat
	b .L224
.L227:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L226
.L224:
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
.Lfe7:
	.size	 Cmd_Players_f,.Lfe7-Cmd_Players_f
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
	mr 31,3
	lwz 0,264(31)
	andi. 9,0,8192
	bc 4,2,.L229
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 11,0,1
	bc 4,2,.L229
	lwz 0,3752(9)
	cmpwi 0,0,1
	bc 12,1,.L229
	cmplwi 0,3,4
	li 0,1
	stw 0,3752(9)
	bc 12,1,.L239
	lis 11,.L240@ha
	slwi 10,3,2
	la 11,.L240@l(11)
	lis 9,.L240@ha
	lwzx 0,10,11
	la 9,.L240@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L240:
	.long .L234-.L240
	.long .L235-.L240
	.long .L236-.L240
	.long .L237-.L240
	.long .L239-.L240
.L234:
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
	b .L241
.L235:
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
	b .L241
.L236:
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
	b .L241
.L237:
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
	b .L241
.L239:
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
.L241:
	stw 0,56(31)
	stw 9,3748(11)
.L229:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 Cmd_Wave_f,.Lfe8-Cmd_Wave_f
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
	.string	"%s"
	.align 2
.LC44:
	.string	"the sun is a mass of incandescent gas"
	.align 2
.LC45:
	.string	"You already are The Sun!\n"
	.align 2
.LC46:
	.string	"You are the Sun!\n"
	.align 2
.LC47:
	.string	"models/super2/sun/sun.md2"
	.align 2
.LC48:
	.string	"powers/sun3.wav"
	.align 2
.LC49:
	.string	"You're not hot enough to be The Sun!\n"
	.align 2
.LC50:
	.long 0x0
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
	stmw 23,2076(1)
	stw 0,2116(1)
	stw 12,2072(1)
	lis 9,gi+156@ha
	mr 31,3
	lwz 0,gi+156@l(9)
	mr 30,4
	mr 29,5
	mtlr 0
	blrl
	cmpwi 0,3,1
	bc 12,1,.L243
	cmpwi 0,29,0
	bc 12,2,.L242
.L243:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,2064(1)
	lwz 11,2068(1)
	andi. 0,11,192
	bc 4,2,.L244
	lis 9,.LC50@ha
	lis 11,ctf@ha
	la 9,.LC50@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 7,0,13
	crnor 31,30,30
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	and 30,30,0
.L244:
	cmpwi 4,30,0
	bc 12,18,.L245
	lwz 6,84(31)
	lis 5,.LC39@ha
	addi 3,1,8
	la 5,.LC39@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L246
.L245:
	lwz 6,84(31)
	lis 5,.LC40@ha
	addi 3,1,8
	la 5,.LC40@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L246:
	cmpwi 0,29,0
	bc 12,2,.L247
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
	b .L248
.L247:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 27,3
	lbz 0,0(27)
	cmpwi 0,0,34
	bc 4,2,.L249
	addi 27,27,1
	mr 3,27
	bl strlen
	add 3,3,27
	stb 29,-1(3)
.L249:
	addi 3,1,8
	mr 4,27
	bl strcat
.L248:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L250
	li 0,0
	stb 0,158(1)
.L250:
	lis 4,.LC42@ha
	addi 3,1,8
	la 4,.LC42@l(4)
	bl strcat
	lis 9,.LC50@ha
	lis 11,dedicated@ha
	la 9,.LC50@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L251
	lis 9,gi+8@ha
	lis 5,.LC43@ha
	lwz 0,gi+8@l(9)
	la 5,.LC43@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L251:
	lis 9,game@ha
	li 30,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,30,0
	bc 12,1,.L253
	lis 9,gi@ha
	mr 23,11
	la 24,gi@l(9)
	lis 25,g_edicts@ha
	lis 26,.LC43@ha
	li 28,936
.L255:
	lwz 0,g_edicts@l(25)
	add 29,0,28
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L254
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L254
	bc 12,18,.L258
	mr 3,31
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L254
.L258:
	lwz 9,8(24)
	mr 3,29
	li 4,3
	la 5,.LC43@l(26)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L254:
	lwz 0,1544(23)
	addi 30,30,1
	addi 28,28,936
	cmpw 0,30,0
	bc 4,1,.L255
.L253:
	lis 4,.LC44@ha
	mr 3,27
	la 4,.LC44@l(4)
	li 5,37
	bl Q_strncasecmp
	mr. 30,3
	bc 4,2,.L242
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,11
	bc 4,2,.L262
	lis 9,gi+8@ha
	lis 5,.LC45@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC45@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L242
.L262:
	lwz 0,3496(9)
	cmpwi 0,0,9
	bc 4,1,.L264
	lis 9,gi@ha
	lis 5,.LC46@ha
	la 29,gi@l(9)
	mr 3,31
	lwz 9,8(29)
	la 5,.LC46@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,-10
	li 10,11
	lis 3,.LC47@ha
	stw 0,1804(9)
	la 3,.LC47@l(3)
	lwz 9,84(31)
	stw 0,1808(9)
	lwz 11,84(31)
	stw 0,1812(11)
	lwz 9,84(31)
	stw 10,1816(9)
	lwz 11,84(31)
	stw 30,3496(11)
	lwz 0,264(31)
	rlwinm 0,0,0,9,5
	stw 0,264(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lwz 0,560(31)
	lis 9,sun_index@ha
	stw 3,sun_index@l(9)
	cmpwi 0,0,0
	bc 12,2,.L265
	mr 3,0
	crxor 6,6,6
	bl target_laser_off
	lwz 3,560(31)
	bl G_FreeEdict
	lwz 0,264(31)
	stw 30,560(31)
	rlwinm 0,0,0,16,14
	stw 0,264(31)
.L265:
	lwz 3,892(31)
	cmpwi 0,3,0
	bc 12,2,.L266
	bl G_FreeEdict
	stw 30,892(31)
.L266:
	mr 3,31
	bl PutClientInServer
	lwz 9,36(29)
	lis 3,.LC48@ha
	la 3,.LC48@l(3)
	mtlr 9
	blrl
	lis 9,.LC51@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC51@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 2,0(9)
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 3,0(9)
	blrl
	b .L242
.L264:
	lis 9,gi+8@ha
	lis 5,.LC49@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC49@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L242:
	lwz 0,2116(1)
	lwz 12,2072(1)
	mtlr 0
	lmw 23,2076(1)
	mtcrf 8,12
	la 1,2112(1)
	blr
.Lfe9:
	.size	 Cmd_Say_f,.Lfe9-Cmd_Say_f
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
	.string	"invdrop"
	.align 2
.LC72:
	.string	"weapprev"
	.align 2
.LC73:
	.string	"weapnext"
	.align 2
.LC74:
	.string	"weaplast"
	.align 2
.LC75:
	.string	"kill"
	.align 2
.LC76:
	.string	"putaway"
	.align 2
.LC77:
	.string	"wave"
	.align 2
.LC78:
	.string	"gameversion"
	.align 2
.LC79:
	.string	"%s : %s\n"
	.align 2
.LC80:
	.string	"Superheroes II, 1.00 CTF"
	.align 2
.LC81:
	.string	"Dec 25 2001"
	.align 2
.LC82:
	.string	"fov"
	.align 2
.LC83:
	.long 0x0
	.align 3
.LC84:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC85:
	.long 0x3f800000
	.align 2
.LC86:
	.long 0x43200000
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
	bc 12,2,.L268
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
	bc 4,2,.L270
	mr 3,29
	bl Cmd_Players_f
	b .L268
.L270:
	lis 4,.LC53@ha
	mr 3,31
	la 4,.LC53@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L271
	mr 3,29
	li 4,0
	b .L444
.L271:
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L272
	mr 3,29
	li 4,1
.L444:
	li 5,0
	bl Cmd_Say_f
	b .L268
.L272:
	lis 4,.LC55@ha
	mr 3,31
	la 4,.LC55@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L273
	mr 3,29
	bl Cmd_Score_f
	b .L268
.L273:
	lis 4,.LC56@ha
	mr 3,31
	la 4,.LC56@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L274
	mr 3,29
	bl Cmd_Help_f
	b .L268
.L274:
	lis 10,.LC83@ha
	lis 9,level+200@ha
	la 10,.LC83@l(10)
	lfs 0,level+200@l(9)
	lfs 31,0(10)
	fcmpu 0,0,31
	bc 4,2,.L268
	lis 4,.LC57@ha
	mr 3,31
	la 4,.LC57@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L276
	mr 3,29
	bl Cmd_Use_f
	b .L268
.L276:
	lis 4,.LC58@ha
	mr 3,31
	la 4,.LC58@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L278
	mr 3,29
	bl Cmd_Drop_f
	b .L268
.L278:
	lis 4,.LC59@ha
	mr 3,31
	la 4,.LC59@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L280
	mr 3,29
	bl Cmd_Give_f
	b .L268
.L280:
	lis 4,.LC60@ha
	mr 3,31
	la 4,.LC60@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L282
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L283
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L283
	lwz 0,8(30)
	lis 5,.LC2@ha
	mr 3,29
	la 5,.LC2@l(5)
	b .L445
.L283:
	lwz 0,264(29)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(29)
	bc 4,2,.L285
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
	b .L298
.L285:
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L298
.L282:
	lis 4,.LC61@ha
	mr 3,31
	la 4,.LC61@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L288
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L289
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L289
	lwz 0,8(30)
	lis 5,.LC2@ha
	mr 3,29
	la 5,.LC2@l(5)
	b .L445
.L289:
	lwz 0,264(29)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(29)
	bc 4,2,.L291
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
	b .L298
.L291:
	lis 9,.LC18@ha
	la 5,.LC18@l(9)
	b .L298
.L288:
	lis 4,.LC62@ha
	mr 3,31
	la 4,.LC62@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L294
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L295
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L295
	lis 9,gi+8@ha
	lis 5,.LC2@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC2@l(5)
	b .L445
.L295:
	lwz 0,260(29)
	cmpwi 0,0,1
	bc 4,2,.L297
	li 0,4
	lis 9,.LC19@ha
	stw 0,260(29)
	la 5,.LC19@l(9)
	b .L298
.L297:
	li 0,1
	lis 9,.LC20@ha
	stw 0,260(29)
	la 5,.LC20@l(9)
.L298:
	lis 9,gi+8@ha
	mr 3,29
	lwz 0,gi+8@l(9)
.L445:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L268
.L294:
	lis 4,.LC63@ha
	mr 3,31
	la 4,.LC63@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L300
	lwz 31,84(29)
	lwz 0,3556(31)
	stw 3,3552(31)
	cmpwi 0,0,0
	stw 3,3560(31)
	bc 12,2,.L301
	stw 3,3556(31)
	b .L268
.L301:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3556(31)
	li 3,5
	lwz 0,100(9)
	addi 30,31,1760
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L305:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,30
	bc 4,1,.L305
	lis 9,gi+92@ha
	mr 3,29
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L268
.L300:
	lis 4,.LC64@ha
	mr 3,31
	la 4,.LC64@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L309
	li 0,256
	lwz 3,84(29)
	lis 9,itemlist@ha
	mtctr 0
	li 8,1
	la 5,itemlist@l(9)
	lwz 6,736(3)
	addi 7,3,740
.L443:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L314
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L314
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L436
.L314:
	addi 8,8,1
	bdnz .L443
	b .L446
.L309:
	lis 4,.LC65@ha
	mr 3,31
	la 4,.LC65@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L320
	lwz 3,84(29)
	lis 9,itemlist@ha
	li 0,256
	la 6,itemlist@l(9)
	mtctr 0
	lwz 9,736(3)
	addi 7,3,740
	addi 10,9,255
.L442:
	srawi 0,10,31
	srwi 0,0,24
	add 0,10,0
	rlwinm 0,0,0,0,23
	subf 8,0,10
	slwi 9,8,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L325
	mulli 0,8,72
	add 11,0,6
	lwz 9,8(11)
	cmpwi 0,9,0
	bc 12,2,.L325
	lwz 0,56(11)
	cmpwi 0,0,0
	bc 4,2,.L437
.L325:
	addi 10,10,-1
	bdnz .L442
	b .L446
.L320:
	lis 4,.LC66@ha
	mr 3,31
	la 4,.LC66@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L331
	li 0,256
	lwz 3,84(29)
	lis 9,itemlist@ha
	mtctr 0
	li 8,1
	la 5,itemlist@l(9)
	lwz 6,736(3)
	addi 7,3,740
.L441:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L336
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L336
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L436
.L336:
	addi 8,8,1
	bdnz .L441
	b .L446
.L331:
	lis 4,.LC67@ha
	mr 3,31
	la 4,.LC67@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L342
	lwz 3,84(29)
	lis 9,itemlist@ha
	li 0,256
	la 6,itemlist@l(9)
	mtctr 0
	lwz 9,736(3)
	addi 7,3,740
	addi 10,9,255
.L440:
	srawi 0,10,31
	srwi 0,0,24
	add 0,10,0
	rlwinm 0,0,0,0,23
	subf 8,0,10
	slwi 9,8,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L347
	mulli 0,8,72
	add 11,0,6
	lwz 9,8(11)
	cmpwi 0,9,0
	bc 12,2,.L347
	lwz 0,56(11)
	andi. 9,0,1
	bc 4,2,.L437
.L347:
	addi 10,10,-1
	bdnz .L440
	b .L446
.L342:
	lis 4,.LC68@ha
	mr 3,31
	la 4,.LC68@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L353
	li 0,256
	lwz 3,84(29)
	lis 9,itemlist@ha
	mtctr 0
	li 8,1
	la 5,itemlist@l(9)
	lwz 6,736(3)
	addi 7,3,740
.L439:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L358
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L358
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L436
.L358:
	addi 8,8,1
	bdnz .L439
	b .L446
.L353:
	lis 4,.LC69@ha
	mr 3,31
	la 4,.LC69@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L364
	lwz 3,84(29)
	lis 9,itemlist@ha
	li 0,256
	la 6,itemlist@l(9)
	mtctr 0
	lwz 9,736(3)
	addi 7,3,740
	addi 10,9,255
.L438:
	srawi 0,10,31
	srwi 0,0,24
	add 0,10,0
	rlwinm 0,0,0,0,23
	subf 8,0,10
	slwi 9,8,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L369
	mulli 0,8,72
	add 11,0,6
	lwz 9,8(11)
	cmpwi 0,9,0
	bc 12,2,.L369
	lwz 0,56(11)
	andi. 9,0,32
	bc 4,2,.L437
.L369:
	addi 10,10,-1
	bdnz .L438
.L446:
	li 0,-1
	stw 0,736(3)
	b .L268
.L364:
	lis 4,.LC70@ha
	mr 3,31
	la 4,.LC70@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L375
	mr 3,29
	bl Cmd_InvUse_f
	b .L268
.L375:
	lis 4,.LC71@ha
	mr 3,31
	la 4,.LC71@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L377
	mr 3,29
	bl Cmd_InvDrop_f
	b .L268
.L377:
	lis 4,.LC72@ha
	mr 3,31
	la 4,.LC72@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L379
	lwz 0,264(29)
	andi. 9,0,8192
	bc 4,2,.L268
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L268
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
.L385:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L387
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L387
	lwz 0,56(31)
	andi. 10,0,1
	bc 12,2,.L387
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L268
.L387:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L385
	b .L268
.L379:
	lis 4,.LC73@ha
	mr 3,31
	la 4,.LC73@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L393
	lwz 0,264(29)
	andi. 9,0,8192
	bc 4,2,.L268
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L268
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
.L399:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L401
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L401
	lwz 0,56(31)
	andi. 10,0,1
	bc 12,2,.L401
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L268
.L401:
	addi 27,27,1
	addi 30,30,-1
	cmpwi 0,27,256
	bc 4,1,.L399
	b .L268
.L393:
	lis 4,.LC74@ha
	mr 3,31
	la 4,.LC74@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L407
	lwz 0,264(29)
	andi. 9,0,8192
	bc 4,2,.L268
	lwz 10,84(29)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L268
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L268
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
	bc 12,2,.L268
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L268
	lwz 0,56(4)
	andi. 10,0,1
	bc 12,2,.L268
	mr 3,29
	mtlr 9
	blrl
	b .L268
.L407:
	lis 4,.LC75@ha
	mr 3,31
	la 4,.LC75@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L416
	lwz 0,264(29)
	andi. 9,0,8192
	bc 4,2,.L268
	rlwinm 0,0,0,28,26
	stw 9,480(29)
	mr 3,29
	stw 0,264(29)
	lis 9,meansOfDeath@ha
	lis 6,0x1
	li 0,23
	lis 7,vec3_origin@ha
	stw 0,meansOfDeath@l(9)
	la 7,vec3_origin@l(7)
	mr 4,3
	mr 5,3
	ori 6,6,34464
	bl player_die
	b .L268
.L416:
	lis 4,.LC76@ha
	mr 3,31
	la 4,.LC76@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L420
	lwz 9,84(29)
	stw 3,3552(9)
	lwz 11,84(29)
	stw 3,3560(11)
	lwz 9,84(29)
	stw 3,3556(9)
	b .L268
.L420:
	lis 4,.LC77@ha
	mr 3,31
	la 4,.LC77@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L423
	mr 3,29
	bl Cmd_Wave_f
	b .L268
.L423:
	lis 4,.LC78@ha
	mr 3,31
	la 4,.LC78@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L425
	lis 9,gi+8@ha
	lis 5,.LC79@ha
	lwz 0,gi+8@l(9)
	lis 6,.LC80@ha
	lis 7,.LC81@ha
	mr 3,29
	la 5,.LC79@l(5)
	la 6,.LC80@l(6)
	la 7,.LC81@l(7)
	mtlr 0
	li 4,2
	crxor 6,6,6
	blrl
	b .L268
.L425:
	lis 4,.LC82@ha
	mr 3,31
	la 4,.LC82@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L427
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(29)
	stw 3,20(1)
	lis 0,0x4330
	lis 10,.LC84@ha
	la 10,.LC84@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC85@ha
	la 10,.LC85@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 3,84(29)
	lfs 0,112(3)
	fcmpu 0,0,12
	bc 4,0,.L428
	lis 0,0x42b4
	stw 0,112(3)
	b .L268
.L428:
	lis 11,.LC86@ha
	la 11,.LC86@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L268
	stfs 13,112(3)
	b .L268
.L436:
	stw 11,736(3)
	b .L268
.L437:
	stw 8,736(3)
	b .L268
.L427:
	mr 3,29
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L268:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe10:
	.size	 ClientCommand,.Lfe10-ClientCommand
	.section	".rodata"
	.align 2
.LC87:
	.string	"None"
	.align 2
.LC88:
	.string	"Mere Mortal"
	.align 2
.LC89:
	.string	"Killer Robot"
	.align 2
.LC90:
	.string	"Cripple w/ a Big Gun"
	.align 2
.LC91:
	.string	"Archmage"
	.align 2
.LC92:
	.string	"Punisher"
	.align 2
.LC93:
	.string	"Assassin"
	.align 2
.LC94:
	.string	"Taft"
	.align 2
.LC95:
	.string	"Flame Ball"
	.align 2
.LC96:
	.string	"Kinetic Throw"
	.align 2
.LC97:
	.string	"Freeze Grenades"
	.align 2
.LC98:
	.string	"Death Blow"
	.align 2
.LC99:
	.string	"Teleportation"
	.align 2
.LC100:
	.string	"Teleport Beacon"
	.align 2
.LC101:
	.string	"Kinetic Cards"
	.align 2
.LC102:
	.string	"Banshee Wail"
	.align 2
.LC103:
	.string	"Reverse Gravity"
	.align 2
.LC104:
	.string	"Ants in the Pants"
	.align 2
.LC105:
	.string	"Psionic Blast"
	.align 2
.LC106:
	.string	"Optic Blast"
	.align 2
.LC107:
	.string	"Lightsaber"
	.align 2
.LC108:
	.string	"Bionic Claw"
	.align 2
.LC109:
	.string	"Black Hole"
	.align 2
.LC110:
	.string	"Power Anchor"
	.align 2
.LC111:
	.string	"Grenade Swarm"
	.align 2
.LC112:
	.string	"Flame Cascade"
	.align 2
.LC113:
	.string	"Impulse 9"
	.align 2
.LC114:
	.string	"Proximity Mines"
	.align 2
.LC115:
	.string	"Power Word, Blind"
	.align 2
.LC116:
	.string	"Weird Bombs"
	.align 2
.LC117:
	.string	"The Sun"
	.align 2
.LC118:
	.string	"Jedi Knight"
	.align 2
.LC119:
	.string	"Random Active"
	.align 2
.LC120:
	.string	"???"
	.section	".text"
	.align 2
	.globl AName
	.type	 AName,@function
AName:
	mr. 3,3
	bc 4,2,.L448
	lis 3,.LC87@ha
	la 3,.LC87@l(3)
	blr
.L448:
	cmpwi 0,3,-1
	bc 4,2,.L450
	lis 3,.LC88@ha
	la 3,.LC88@l(3)
	blr
.L450:
	cmpwi 0,3,-4
	bc 4,2,.L452
	lis 3,.LC89@ha
	la 3,.LC89@l(3)
	blr
.L452:
	cmpwi 0,3,-3
	bc 4,2,.L454
	lis 3,.LC90@ha
	la 3,.LC90@l(3)
	blr
.L454:
	cmpwi 0,3,-2
	bc 4,2,.L456
	lis 3,.LC91@ha
	la 3,.LC91@l(3)
	blr
.L456:
	cmpwi 0,3,-5
	bc 4,2,.L458
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	blr
.L458:
	cmpwi 0,3,-6
	bc 4,2,.L460
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	blr
.L460:
	cmpwi 0,3,-7
	bc 4,2,.L462
	lis 3,.LC94@ha
	la 3,.LC94@l(3)
	blr
.L462:
	cmpwi 0,3,6
	bc 4,2,.L464
	lis 3,.LC95@ha
	la 3,.LC95@l(3)
	blr
.L464:
	cmpwi 0,3,12
	bc 4,2,.L466
	lis 3,.LC96@ha
	la 3,.LC96@l(3)
	blr
.L466:
	cmpwi 0,3,8
	bc 4,2,.L468
	lis 3,.LC97@ha
	la 3,.LC97@l(3)
	blr
.L468:
	cmpwi 0,3,5
	bc 4,2,.L470
	lis 3,.LC98@ha
	la 3,.LC98@l(3)
	blr
.L470:
	cmpwi 0,3,20
	bc 4,2,.L472
	lis 3,.LC99@ha
	la 3,.LC99@l(3)
	blr
.L472:
	cmpwi 0,3,21
	bc 4,2,.L474
	lis 3,.LC100@ha
	la 3,.LC100@l(3)
	blr
.L474:
	cmpwi 0,3,11
	bc 4,2,.L476
	lis 3,.LC101@ha
	la 3,.LC101@l(3)
	blr
.L476:
	cmpwi 0,3,2
	bc 4,2,.L478
	lis 3,.LC102@ha
	la 3,.LC102@l(3)
	blr
.L478:
	cmpwi 0,3,19
	bc 4,2,.L480
	lis 3,.LC103@ha
	la 3,.LC103@l(3)
	blr
.L480:
	cmpwi 0,3,1
	bc 4,2,.L482
	lis 3,.LC104@ha
	la 3,.LC104@l(3)
	blr
.L482:
	cmpwi 0,3,18
	bc 4,2,.L484
	lis 3,.LC105@ha
	la 3,.LC105@l(3)
	blr
.L484:
	cmpwi 0,3,14
	bc 4,2,.L486
	lis 3,.LC106@ha
	la 3,.LC106@l(3)
	blr
.L486:
	cmpwi 0,3,13
	bc 4,2,.L488
	lis 3,.LC107@ha
	la 3,.LC107@l(3)
	blr
.L488:
	cmpwi 0,3,3
	bc 4,2,.L490
	lis 3,.LC108@ha
	la 3,.LC108@l(3)
	blr
.L490:
	cmpwi 0,3,4
	bc 4,2,.L492
	lis 3,.LC109@ha
	la 3,.LC109@l(3)
	blr
.L492:
	cmpwi 0,3,15
	bc 4,2,.L494
	lis 3,.LC110@ha
	la 3,.LC110@l(3)
	blr
.L494:
	cmpwi 0,3,9
	bc 4,2,.L496
	lis 3,.LC111@ha
	la 3,.LC111@l(3)
	blr
.L496:
	cmpwi 0,3,7
	bc 4,2,.L498
	lis 3,.LC112@ha
	la 3,.LC112@l(3)
	blr
.L498:
	cmpwi 0,3,10
	bc 4,2,.L500
	lis 3,.LC113@ha
	la 3,.LC113@l(3)
	blr
.L500:
	cmpwi 0,3,17
	bc 4,2,.L502
	lis 3,.LC114@ha
	la 3,.LC114@l(3)
	blr
.L502:
	cmpwi 0,3,16
	bc 4,2,.L504
	lis 3,.LC115@ha
	la 3,.LC115@l(3)
	blr
.L504:
	cmpwi 0,3,22
	bc 4,2,.L506
	lis 3,.LC116@ha
	la 3,.LC116@l(3)
	blr
.L506:
	cmpwi 0,3,-10
	bc 4,2,.L508
	lis 3,.LC117@ha
	la 3,.LC117@l(3)
	blr
.L508:
	cmpwi 0,3,-8
	bc 4,2,.L510
	lis 3,.LC118@ha
	la 3,.LC118@l(3)
	blr
.L510:
	cmpwi 0,3,23
	bc 12,2,.L512
	lis 3,.LC120@ha
	la 3,.LC120@l(3)
	blr
.L512:
	lis 3,.LC119@ha
	la 3,.LC119@l(3)
	blr
.Lfe11:
	.size	 AName,.Lfe11-AName
	.section	".rodata"
	.align 2
.LC121:
	.string	"Boot to the Head"
	.align 2
.LC122:
	.string	"Elastic"
	.align 2
.LC123:
	.string	"Repulsion Field"
	.align 2
.LC124:
	.string	"Immune to Radius"
	.align 2
.LC125:
	.string	"Regeneration"
	.align 2
.LC126:
	.string	"Radioactive"
	.align 2
.LC127:
	.string	"Force Field"
	.align 2
.LC128:
	.string	"Invisibility"
	.align 2
.LC129:
	.string	"Energy Absorption"
	.align 2
.LC130:
	.string	"Bullet Proof"
	.align 2
.LC131:
	.string	"Prismatic Shell"
	.align 2
.LC132:
	.string	"Life Well"
	.align 2
.LC133:
	.string	"Metallic Form"
	.align 2
.LC134:
	.string	"Super Speed"
	.align 2
.LC135:
	.string	"Flight"
	.align 2
.LC136:
	.string	"Liquid Form"
	.align 2
.LC137:
	.string	"Hyper Density"
	.align 2
.LC138:
	.string	"Shining Radiance"
	.align 2
.LC139:
	.string	"Heightened Reflexes"
	.align 2
.LC140:
	.string	"Random Passive"
	.section	".text"
	.align 2
	.globl PName
	.type	 PName,@function
PName:
	mr. 3,3
	bc 4,2,.L516
	lis 3,.LC87@ha
	la 3,.LC87@l(3)
	blr
.L516:
	cmpwi 0,3,-1
	bc 4,2,.L518
	lis 3,.LC88@ha
	la 3,.LC88@l(3)
	blr
.L518:
	cmpwi 0,3,-4
	bc 4,2,.L520
	lis 3,.LC89@ha
	la 3,.LC89@l(3)
	blr
.L520:
	cmpwi 0,3,-3
	bc 4,2,.L522
	lis 3,.LC90@ha
	la 3,.LC90@l(3)
	blr
.L522:
	cmpwi 0,3,-2
	bc 4,2,.L524
	lis 3,.LC91@ha
	la 3,.LC91@l(3)
	blr
.L524:
	cmpwi 0,3,-5
	bc 4,2,.L526
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	blr
.L526:
	cmpwi 0,3,-6
	bc 4,2,.L528
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	blr
.L528:
	cmpwi 0,3,-7
	bc 4,2,.L530
	lis 3,.LC94@ha
	la 3,.LC94@l(3)
	blr
.L530:
	cmpwi 0,3,1
	bc 4,2,.L532
	lis 3,.LC121@ha
	la 3,.LC121@l(3)
	blr
.L532:
	cmpwi 0,3,3
	bc 4,2,.L534
	lis 3,.LC122@ha
	la 3,.LC122@l(3)
	blr
.L534:
	cmpwi 0,3,17
	bc 4,2,.L536
	lis 3,.LC123@ha
	la 3,.LC123@l(3)
	blr
.L536:
	cmpwi 0,3,9
	bc 4,2,.L538
	lis 3,.LC124@ha
	la 3,.LC124@l(3)
	blr
.L538:
	cmpwi 0,3,16
	bc 4,2,.L540
	lis 3,.LC125@ha
	la 3,.LC125@l(3)
	blr
.L540:
	cmpwi 0,3,15
	bc 4,2,.L542
	lis 3,.LC126@ha
	la 3,.LC126@l(3)
	blr
.L542:
	cmpwi 0,3,6
	bc 4,2,.L544
	lis 3,.LC127@ha
	la 3,.LC127@l(3)
	blr
.L544:
	cmpwi 0,3,10
	bc 4,2,.L546
	lis 3,.LC128@ha
	la 3,.LC128@l(3)
	blr
.L546:
	cmpwi 0,3,4
	bc 4,2,.L548
	lis 3,.LC129@ha
	la 3,.LC129@l(3)
	blr
.L548:
	cmpwi 0,3,2
	bc 4,2,.L550
	lis 3,.LC130@ha
	la 3,.LC130@l(3)
	blr
.L550:
	cmpwi 0,3,14
	bc 4,2,.L552
	lis 3,.LC131@ha
	la 3,.LC131@l(3)
	blr
.L552:
	cmpwi 0,3,11
	bc 4,2,.L554
	lis 3,.LC132@ha
	la 3,.LC132@l(3)
	blr
.L554:
	cmpwi 0,3,13
	bc 4,2,.L556
	lis 3,.LC133@ha
	la 3,.LC133@l(3)
	blr
.L556:
	cmpwi 0,3,18
	bc 4,2,.L558
	lis 3,.LC134@ha
	la 3,.LC134@l(3)
	blr
.L558:
	cmpwi 0,3,5
	bc 4,2,.L560
	lis 3,.LC135@ha
	la 3,.LC135@l(3)
	blr
.L560:
	cmpwi 0,3,12
	bc 4,2,.L562
	lis 3,.LC136@ha
	la 3,.LC136@l(3)
	blr
.L562:
	cmpwi 0,3,8
	bc 4,2,.L564
	lis 3,.LC137@ha
	la 3,.LC137@l(3)
	blr
.L564:
	cmpwi 0,3,20
	bc 4,2,.L566
	lis 3,.LC138@ha
	la 3,.LC138@l(3)
	blr
.L566:
	cmpwi 0,3,7
	bc 4,2,.L568
	lis 3,.LC139@ha
	la 3,.LC139@l(3)
	blr
.L568:
	cmpwi 0,3,-10
	bc 4,2,.L570
	lis 3,.LC117@ha
	la 3,.LC117@l(3)
	blr
.L570:
	cmpwi 0,3,-8
	bc 4,2,.L572
	lis 3,.LC118@ha
	la 3,.LC118@l(3)
	blr
.L572:
	cmpwi 0,3,19
	bc 12,2,.L574
	lis 3,.LC120@ha
	la 3,.LC120@l(3)
	blr
.L574:
	lis 3,.LC140@ha
	la 3,.LC140@l(3)
	blr
.Lfe12:
	.size	 PName,.Lfe12-PName
	.section	".rodata"
	.align 2
.LC141:
	.string	"Hasted Attacks"
	.align 2
.LC142:
	.string	"Super Jump"
	.align 2
.LC143:
	.string	"Invisible Shots"
	.align 2
.LC144:
	.string	"Fast Projectiles"
	.align 2
.LC145:
	.string	"Vampiric Attacks"
	.align 2
.LC146:
	.string	"Reduced Ammo Use"
	.align 2
.LC147:
	.string	"Armor Piercing"
	.align 2
.LC148:
	.string	"Electric Attacks"
	.align 2
.LC149:
	.string	"Sniper Shots"
	.align 2
.LC150:
	.string	"Aggravated Attacks"
	.align 2
.LC151:
	.string	"Berserker Rage"
	.align 2
.LC152:
	.string	"Angel of Death"
	.align 2
.LC153:
	.string	"Angel of Life"
	.align 2
.LC154:
	.string	"Angel of Mercy"
	.align 2
.LC155:
	.string	"Happy Fun Balls"
	.align 2
.LC156:
	.string	"Dark One's Luck"
	.align 2
.LC157:
	.string	"Super Strength"
	.align 2
.LC158:
	.string	"Funkagroovitalizer"
	.align 2
.LC159:
	.string	"Bop Gun"
	.align 2
.LC160:
	.string	"Random Special"
	.section	".text"
	.align 2
	.globl SName
	.type	 SName,@function
SName:
	mr. 3,3
	bc 4,2,.L578
	lis 3,.LC87@ha
	la 3,.LC87@l(3)
	blr
.L578:
	cmpwi 0,3,-1
	bc 4,2,.L580
	lis 3,.LC88@ha
	la 3,.LC88@l(3)
	blr
.L580:
	cmpwi 0,3,-4
	bc 4,2,.L582
	lis 3,.LC89@ha
	la 3,.LC89@l(3)
	blr
.L582:
	cmpwi 0,3,-3
	bc 4,2,.L584
	lis 3,.LC90@ha
	la 3,.LC90@l(3)
	blr
.L584:
	cmpwi 0,3,-2
	bc 4,2,.L586
	lis 3,.LC91@ha
	la 3,.LC91@l(3)
	blr
.L586:
	cmpwi 0,3,-5
	bc 4,2,.L588
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	blr
.L588:
	cmpwi 0,3,-6
	bc 4,2,.L590
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	blr
.L590:
	cmpwi 0,3,-7
	bc 4,2,.L592
	lis 3,.LC94@ha
	la 3,.LC94@l(3)
	blr
.L592:
	cmpwi 0,3,12
	bc 4,2,.L594
	lis 3,.LC141@ha
	la 3,.LC141@l(3)
	blr
.L594:
	cmpwi 0,3,16
	bc 4,2,.L596
	lis 3,.LC142@ha
	la 3,.LC142@l(3)
	blr
.L596:
	cmpwi 0,3,13
	bc 4,2,.L598
	lis 3,.LC143@ha
	la 3,.LC143@l(3)
	blr
.L598:
	cmpwi 0,3,9
	bc 4,2,.L600
	lis 3,.LC144@ha
	la 3,.LC144@l(3)
	blr
.L600:
	cmpwi 0,3,18
	bc 4,2,.L602
	lis 3,.LC145@ha
	la 3,.LC145@l(3)
	blr
.L602:
	cmpwi 0,3,14
	bc 4,2,.L604
	lis 3,.LC146@ha
	la 3,.LC146@l(3)
	blr
.L604:
	cmpwi 0,3,5
	bc 4,2,.L606
	lis 3,.LC147@ha
	la 3,.LC147@l(3)
	blr
.L606:
	cmpwi 0,3,8
	bc 4,2,.L608
	lis 3,.LC148@ha
	la 3,.LC148@l(3)
	blr
.L608:
	cmpwi 0,3,15
	bc 4,2,.L610
	lis 3,.LC149@ha
	la 3,.LC149@l(3)
	blr
.L610:
	cmpwi 0,3,1
	bc 4,2,.L612
	lis 3,.LC150@ha
	la 3,.LC150@l(3)
	blr
.L612:
	cmpwi 0,3,6
	bc 4,2,.L614
	lis 3,.LC151@ha
	la 3,.LC151@l(3)
	blr
.L614:
	cmpwi 0,3,2
	bc 4,2,.L616
	lis 3,.LC152@ha
	la 3,.LC152@l(3)
	blr
.L616:
	cmpwi 0,3,3
	bc 4,2,.L618
	lis 3,.LC153@ha
	la 3,.LC153@l(3)
	blr
.L618:
	cmpwi 0,3,4
	bc 4,2,.L620
	lis 3,.LC154@ha
	la 3,.LC154@l(3)
	blr
.L620:
	cmpwi 0,3,11
	bc 4,2,.L622
	lis 3,.LC155@ha
	la 3,.LC155@l(3)
	blr
.L622:
	cmpwi 0,3,7
	bc 4,2,.L624
	lis 3,.LC156@ha
	la 3,.LC156@l(3)
	blr
.L624:
	cmpwi 0,3,17
	bc 4,2,.L626
	lis 3,.LC157@ha
	la 3,.LC157@l(3)
	blr
.L626:
	cmpwi 0,3,10
	bc 4,2,.L628
	lis 3,.LC158@ha
	la 3,.LC158@l(3)
	blr
.L628:
	cmpwi 0,3,30
	bc 4,2,.L630
	lis 3,.LC159@ha
	la 3,.LC159@l(3)
	blr
.L630:
	cmpwi 0,3,-10
	bc 4,2,.L632
	lis 3,.LC117@ha
	la 3,.LC117@l(3)
	blr
.L632:
	cmpwi 0,3,-8
	bc 4,2,.L634
	lis 3,.LC118@ha
	la 3,.LC118@l(3)
	blr
.L634:
	cmpwi 0,3,19
	bc 12,2,.L636
	lis 3,.LC120@ha
	la 3,.LC120@l(3)
	blr
.L636:
	lis 3,.LC160@ha
	la 3,.LC160@l(3)
	blr
.Lfe13:
	.size	 SName,.Lfe13-SName
	.section	".rodata"
	.align 2
.LC161:
	.string	"Powers ========="
	.align 2
.LC162:
	.string	"Mere Mortal ===="
	.align 2
.LC163:
	.string	"Killer Robot ==="
	.align 2
.LC164:
	.string	"Cripple ========"
	.align 2
.LC165:
	.string	"Archmage ======="
	.align 2
.LC166:
	.string	"Punisher ======="
	.align 2
.LC167:
	.string	"Assassin ======="
	.align 2
.LC168:
	.string	"Taft ==========="
	.align 2
.LC169:
	.string	"Jedi Knight ===="
	.align 2
.LC170:
	.string	"Bionic Commando "
	.align 2
.LC171:
	.string	"E.M.B.W.B.M. ==="
	.align 2
.LC172:
	.string	"The Sun ========"
	.section	".text"
	.align 2
	.globl CName
	.type	 CName,@function
CName:
	mr. 3,3
	bc 4,2,.L640
	lis 3,.LC161@ha
	la 3,.LC161@l(3)
	blr
.L640:
	cmpwi 0,3,1
	bc 4,2,.L642
	lis 3,.LC162@ha
	la 3,.LC162@l(3)
	blr
.L642:
	cmpwi 0,3,6
	bc 4,2,.L644
	lis 3,.LC163@ha
	la 3,.LC163@l(3)
	blr
.L644:
	cmpwi 0,3,4
	bc 4,2,.L646
	lis 3,.LC164@ha
	la 3,.LC164@l(3)
	blr
.L646:
	cmpwi 0,3,2
	bc 4,2,.L648
	lis 3,.LC165@ha
	la 3,.LC165@l(3)
	blr
.L648:
	cmpwi 0,3,7
	bc 4,2,.L650
	lis 3,.LC166@ha
	la 3,.LC166@l(3)
	blr
.L650:
	cmpwi 0,3,3
	bc 4,2,.L652
	lis 3,.LC167@ha
	la 3,.LC167@l(3)
	blr
.L652:
	cmpwi 0,3,8
	bc 4,2,.L654
	lis 3,.LC168@ha
	la 3,.LC168@l(3)
	blr
.L654:
	cmpwi 0,3,111
	bc 4,2,.L656
.L667:
	lis 3,.LC169@ha
	la 3,.LC169@l(3)
	blr
.L656:
	cmpwi 0,3,119
	bc 4,2,.L658
	lis 3,.LC170@ha
	la 3,.LC170@l(3)
	blr
.L658:
	cmpwi 0,3,110
	bc 4,2,.L660
	lis 3,.LC171@ha
	la 3,.LC171@l(3)
	blr
.L660:
	cmpwi 0,3,5
	bc 12,2,.L667
	cmpwi 0,3,11
	bc 12,2,.L664
	lis 3,.LC120@ha
	la 3,.LC120@l(3)
	blr
.L664:
	lis 3,.LC172@ha
	la 3,.LC172@l(3)
	blr
.Lfe14:
	.size	 CName,.Lfe14-CName
	.section	".rodata"
	.align 2
.LC173:
	.long 0x42a00000
	.long 0x0
	.long 0xc2200000
	.align 2
.LC174:
	.string	"Power Screen"
	.section	".text"
	.align 2
	.globl needitem
	.type	 needitem,@function
needitem:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 27,4
	lis 9,itemlist@ha
	lwz 10,648(27)
	la 9,itemlist@l(9)
	lis 0,0x38e3
	ori 0,0,36409
	lwz 11,184(27)
	mr 31,3
	subf 9,9,10
	mullw 9,9,0
	andi. 0,11,1
	srawi 8,9,3
	bc 4,2,.L701
	lwz 0,4(10)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 4,2,.L674
	lwz 9,480(31)
	lwz 0,484(31)
	cmpw 0,9,0
	bc 12,0,.L713
	lwz 0,644(27)
	andi. 9,0,1
	bc 4,2,.L713
.L674:
	lwz 11,648(27)
	lis 9,Pickup_Weapon@ha
	la 9,Pickup_Weapon@l(9)
	lwz 0,4(11)
	mr 7,11
	cmpw 0,0,9
	bc 4,2,.L676
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,4
	bc 12,2,.L677
	lwz 9,84(31)
	slwi 11,8,2
	addi 9,9,740
	lwzx 0,9,11
	cmpwi 0,0,0
	bc 4,2,.L701
.L677:
	lwz 0,444(27)
	lis 9,drop_temp_touch@ha
	la 9,drop_temp_touch@l(9)
	cmpw 0,0,9
	bc 12,2,.L701
	lwz 0,284(27)
	andis. 9,0,0x3
	mfcr 3
	rlwinm 3,3,3,1
	b .L712
.L676:
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L701
	lis 9,Pickup_Adrenaline@ha
	la 9,Pickup_Adrenaline@l(9)
	cmpw 0,0,9
	bc 12,2,.L713
	lis 9,Pickup_AncientHead@ha
	la 9,Pickup_AncientHead@l(9)
	cmpw 0,0,9
	bc 12,2,.L713
	lis 9,Pickup_Bandolier@ha
	la 9,Pickup_Bandolier@l(9)
	cmpw 0,0,9
	bc 12,2,.L713
	lis 9,Pickup_Pack@ha
	la 9,Pickup_Pack@l(9)
	cmpw 0,0,9
	bc 12,2,.L713
	lis 9,Pickup_Key@ha
	la 9,Pickup_Key@l(9)
	cmpw 0,0,9
	bc 12,2,.L713
	lis 9,Pickup_Ammo@ha
	la 9,Pickup_Ammo@l(9)
	cmpw 0,0,9
	bc 4,2,.L686
	lwz 9,64(7)
	cmpwi 0,9,0
	bc 4,2,.L687
	lwz 9,84(31)
	mr 3,9
	lwz 10,1764(9)
	b .L688
.L687:
	cmpwi 0,9,1
	bc 4,2,.L689
	lwz 9,84(31)
	mr 3,9
	lwz 10,1768(9)
	b .L688
.L689:
	mr 0,9
	cmpwi 0,0,2
	bc 4,2,.L691
	lwz 9,84(31)
	mr 3,9
	lwz 10,1772(9)
	b .L688
.L691:
	cmpwi 0,0,3
	bc 4,2,.L693
	lwz 9,84(31)
	mr 3,9
	lwz 10,1776(9)
	b .L688
.L693:
	cmpwi 0,0,4
	bc 4,2,.L695
	lwz 9,84(31)
	mr 3,9
	lwz 10,1780(9)
	b .L688
.L695:
	cmpwi 0,9,5
	bc 4,2,.L701
	lwz 9,84(31)
	lwz 10,1784(9)
	mr 3,9
.L688:
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,7
	addi 11,3,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpw 0,0,10
	bc 4,0,.L701
	lwz 0,284(27)
	andis. 9,0,1
	mfcr 3
	rlwinm 3,3,3,1
	b .L712
.L686:
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 4,2,.L701
	mr 3,31
	lis 28,0x38e3
	bl ArmorIndex
	ori 28,28,36409
	mr 30,3
	lis 3,.LC8@ha
	la 3,.LC8@l(3)
	bl FindItem
	lis 29,itemlist@ha
	lis 9,.LC9@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC9@l(9)
	srawi 26,0,3
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
	srawi 29,0,3
	bl FindItem
	lis 3,.LC174@ha
	la 3,.LC174@l(3)
	bl FindItem
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	bl FindItem
	lwz 4,648(27)
	lwz 0,64(4)
	cmpwi 0,0,4
	bc 12,2,.L713
	cmpwi 0,30,0
	bc 12,2,.L713
	cmpw 0,30,26
	lwz 4,60(4)
	bc 4,2,.L706
	lis 9,jacketarmor_info@ha
	la 10,jacketarmor_info@l(9)
	b .L707
.L706:
	cmpw 0,30,29
	bc 4,2,.L708
	lis 9,combatarmor_info@ha
	la 10,combatarmor_info@l(9)
	b .L707
.L708:
	lis 9,bodyarmor_info@ha
	la 10,bodyarmor_info@l(9)
.L707:
	lfs 13,8(4)
	lfs 0,8(10)
	fcmpu 0,13,0
	bc 4,1,.L710
.L713:
	li 3,1
	b .L712
.L710:
	lwz 9,84(31)
	slwi 11,30,2
	lwz 10,4(10)
	addi 9,9,740
	lwzx 0,9,11
	cmpw 7,0,10
	mfcr 3
	rlwinm 3,3,29,1
	b .L712
.L701:
	li 3,0
.L712:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 needitem,.Lfe15-needitem
	.section	".rodata"
	.align 2
.LC175:
	.string	"grenade"
	.align 2
.LC176:
	.string	"rocket"
	.align 2
.LC177:
	.string	"robo rocket"
	.align 2
.LC178:
	.string	"bfg blast"
	.align 2
.LC179:
	.string	"bolt"
	.align 2
.LC180:
	.string	"super shot"
	.section	".text"
	.align 2
	.globl aom_valid
	.type	 aom_valid,@function
aom_valid:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 4,.LC175@ha
	lwz 3,280(31)
	la 4,.LC175@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,1
	bc 12,2,.L722
	lwz 3,280(31)
	lis 4,.LC176@ha
	la 4,.LC176@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,1
	bc 12,2,.L722
	lwz 3,280(31)
	lis 4,.LC177@ha
	la 4,.LC177@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,1
	bc 12,2,.L722
	lwz 3,280(31)
	lis 4,.LC178@ha
	la 4,.LC178@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,1
	bc 12,2,.L722
	lwz 3,280(31)
	lis 4,.LC179@ha
	la 4,.LC179@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,1
	bc 12,2,.L722
	lwz 3,280(31)
	lis 4,.LC180@ha
	la 4,.LC180@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L720
	lwz 0,436(31)
	lis 3,target_laser_think@ha
	la 3,target_laser_think@l(3)
	xor 3,0,3
	subfic 9,3,0
	adde 3,9,3
	b .L722
.L720:
	li 3,1
.L722:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe16:
	.size	 aom_valid,.Lfe16-aom_valid
	.section	".rodata"
	.align 3
.LC181:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC182:
	.long 0x0
	.align 3
.LC183:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC184:
	.long 0x43960000
	.align 3
.LC185:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC186:
	.long 0x41200000
	.align 2
.LC187:
	.long 0x40e00000
	.align 2
.LC188:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl aol_think
	.type	 aol_think,@function
aol_think:
	stwu 1,-4320(1)
	mflr 0
	stfd 31,4312(1)
	stmw 27,4292(1)
	stw 0,4324(1)
	mr 31,3
	li 9,0
	lwz 11,256(31)
	stw 9,552(31)
	lwz 0,892(11)
	cmpw 0,0,31
	bc 4,2,.L741
	lwz 9,84(11)
	lwz 0,1812(9)
	cmpwi 0,0,3
	bc 12,2,.L740
.L741:
	mr 3,31
	bl G_FreeEdict
	b .L739
.L773:
	stw 29,412(31)
	b .L745
.L740:
	addi 3,31,376
	addi 4,31,16
	bl vectoangles
	lis 11,gi+48@ha
	lwz 7,256(31)
	lis 9,0x600
	lwz 0,gi+48@l(11)
	addi 4,31,4
	ori 9,9,3
	addi 3,1,40
	addi 7,7,4
	mtlr 0
	li 5,0
	li 6,0
	li 8,0
	mr 27,4
	blrl
	lwz 9,256(31)
	lwz 0,92(1)
	cmpw 0,0,9
	bc 12,2,.L742
	lfs 12,4(9)
	lfs 0,616(31)
	lfs 11,620(31)
	lfs 10,624(31)
	fadds 12,12,0
	stfs 12,8(1)
	lfs 13,8(9)
	fadds 13,13,11
	stfs 13,12(1)
	lfs 0,12(9)
	stfs 12,4(31)
	stfs 13,8(31)
	fadds 0,0,10
	stfs 0,12(31)
	stfs 0,16(1)
.L742:
	bl rand
	lis 0,0x6666
	srawi 9,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,2
	subf 0,9,0
	mulli 0,0,10
	subf. 9,0,3
	bc 4,1,.L744
	lis 10,.LC182@ha
	lfs 13,616(31)
	la 10,.LC182@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,2,.L743
.L744:
	lis 29,0x51eb
	bl rand
	lis 28,0x4330
	ori 29,29,34079
	srawi 11,3,31
	mulhw 0,3,29
	lis 10,.LC183@ha
	la 10,.LC183@l(10)
	srawi 0,0,5
	lfd 31,0(10)
	subf 0,11,0
	mulli 0,0,100
	subf 3,0,3
	addi 3,3,-50
	xoris 3,3,0x8000
	stw 3,4284(1)
	stw 28,4280(1)
	lfd 0,4280(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,8(1)
	bl rand
	mulhw 0,3,29
	srawi 9,3,31
	srawi 0,0,5
	subf 0,9,0
	mulli 0,0,100
	subf 3,0,3
	addi 3,3,-50
	xoris 3,3,0x8000
	stw 3,4284(1)
	stw 28,4280(1)
	lfd 0,4280(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,12(1)
	bl rand
	mulhw 29,3,29
	srawi 0,3,31
	lfs 0,12(1)
	lfs 13,8(1)
	srawi 29,29,4
	subf 29,0,29
	stfs 0,620(31)
	mulli 29,29,50
	stfs 13,616(31)
	subf 3,29,3
	xoris 3,3,0x8000
	stw 3,4284(1)
	stw 28,4280(1)
	lfd 0,4280(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,624(31)
	stfs 0,16(1)
.L743:
	lwz 0,412(31)
	cmpwi 0,0,0
	bc 4,2,.L772
	lwz 4,256(31)
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L745
	lis 9,g_edicts@ha
	addi 4,4,4
	lwz 3,g_edicts@l(9)
	lis 9,.LC184@ha
	la 9,.LC184@l(9)
	lfs 1,0(9)
	bl findradius
	mr. 29,3
	bc 12,2,.L745
	lis 10,.LC185@ha
	lis 9,gi@ha
	la 10,.LC185@l(10)
	la 30,gi@l(9)
	lfd 31,0(10)
.L748:
	lwz 0,648(29)
	cmpwi 0,0,0
	bc 12,2,.L749
	lwz 0,540(31)
	cmpw 0,29,0
	bc 12,2,.L749
	lwz 3,256(31)
	mr 4,29
	bl needitem
	cmpwi 0,3,0
	bc 12,2,.L749
	lwz 11,48(30)
	addi 3,1,104
	addi 4,29,4
	addi 5,31,188
	addi 6,31,200
	mr 7,27
	mr 8,31
	mtlr 11
	li 9,3
	blrl
	lfs 0,112(1)
	fcmpu 0,0,31
	bc 12,2,.L773
.L749:
	lis 9,.LC184@ha
	lwz 4,256(31)
	mr 3,29
	la 9,.LC184@l(9)
	lfs 1,0(9)
	addi 4,4,4
	bl findradius
	mr. 29,3
	bc 4,2,.L748
.L745:
	lwz 0,412(31)
	lwz 11,256(31)
	cmpwi 0,0,0
	bc 12,2,.L771
.L772:
	lwz 9,256(31)
	lwz 0,480(9)
	mr 11,9
	cmpwi 0,0,0
	bc 4,1,.L753
	lwz 9,412(31)
	lfs 0,4(11)
	lfs 13,4(9)
	fsubs 0,0,13
	stfs 0,8(1)
	lfs 0,8(9)
	lfs 13,8(11)
	fsubs 13,13,0
	stfs 13,12(1)
	lfs 0,12(11)
	lfs 13,12(9)
	fsubs 0,0,13
	stfs 0,16(1)
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 4,2,.L754
	stw 0,412(31)
	b .L753
.L754:
	addi 3,1,8
	bl VectorLength
	lis 9,.LC184@ha
	la 9,.LC184@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,1,.L774
	lwz 9,412(31)
	lwz 0,184(9)
	andi. 10,0,1
	bc 12,2,.L758
.L774:
	li 0,0
	stw 0,412(31)
	b .L753
.L758:
	lfs 13,4(9)
	addi 3,1,104
	addi 30,1,24
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 0,0,13
	stfs 0,104(1)
	lfs 13,8(9)
	fsubs 12,12,13
	stfs 12,108(1)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,112(1)
	bl VectorLength
	lis 9,.LC186@ha
	la 9,.LC186@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L760
	lis 9,gi+80@ha
	addi 29,1,168
	lwz 0,gi+80@l(9)
	addi 3,31,212
	addi 4,31,224
	mr 5,29
	li 6,1024
	mtlr 0
	li 7,2
	blrl
	mr. 0,3
	mtctr 0
	bc 4,1,.L762
	mr 28,29
	mfctr 29
.L764:
	lwz 3,0(28)
	lwz 0,412(31)
	addi 28,28,4
	cmpw 0,3,0
	bc 4,2,.L763
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L763
	lwz 9,444(3)
	cmpwi 0,9,0
	bc 12,2,.L763
	lwz 4,256(31)
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L763
	li 5,0
	li 6,0
	mtlr 9
	blrl
.L763:
	addic. 29,29,-1
	bc 4,2,.L764
.L762:
	li 0,0
	stw 0,540(31)
	stw 0,412(31)
.L760:
	lwz 9,412(31)
	lis 10,.LC187@ha
	mr 3,30
	lfs 0,4(31)
	la 10,.LC187@l(10)
	mr 4,3
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	lfs 1,0(10)
	stfs 13,24(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,28(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,32(1)
	bl VectorScale
	lfs 0,24(1)
	lfs 13,28(1)
	lfs 12,32(1)
	stfs 0,376(31)
	stfs 13,380(31)
	stfs 12,384(31)
.L753:
	lwz 0,412(31)
	lwz 11,256(31)
	cmpwi 0,0,0
	bc 12,2,.L771
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 12,1,.L770
.L771:
	lfs 0,616(31)
	lis 9,.LC188@ha
	addi 3,1,24
	lfs 11,4(11)
	la 9,.LC188@l(9)
	mr 4,3
	lfs 9,620(31)
	lfs 10,8(31)
	fadds 11,11,0
	lfs 8,624(31)
	lfs 0,4(31)
	lfs 1,0(9)
	stfs 11,8(1)
	lfs 13,8(11)
	fsubs 11,11,0
	lfs 12,12(31)
	fadds 13,13,9
	stfs 13,12(1)
	lfs 0,12(11)
	fsubs 13,13,10
	stfs 11,24(1)
	fadds 0,0,8
	stfs 13,28(1)
	fsubs 12,0,12
	stfs 0,16(1)
	stfs 12,32(1)
	bl VectorScale
	lfs 0,24(1)
	lfs 13,28(1)
	lfs 12,32(1)
	lfs 11,376(31)
	lfs 10,380(31)
	lfs 9,384(31)
	fadds 0,0,11
	fadds 13,13,10
	fadds 12,12,9
	stfs 0,376(31)
	stfs 13,380(31)
	stfs 12,384(31)
.L770:
	lis 9,level+4@ha
	lis 11,.LC181@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC181@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L739:
	lwz 0,4324(1)
	mtlr 0
	lmw 27,4292(1)
	lfd 31,4312(1)
	la 1,4320(1)
	blr
.Lfe17:
	.size	 aol_think,.Lfe17-aol_think
	.section	".rodata"
	.align 3
.LC189:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC190:
	.long 0x0
	.align 3
.LC191:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC192:
	.long 0x42c80000
	.align 3
.LC193:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC194:
	.long 0x3f800000
	.align 2
.LC195:
	.long 0x41200000
	.align 2
.LC196:
	.long 0x40600000
	.section	".text"
	.align 2
	.globl aom_think
	.type	 aom_think,@function
aom_think:
	stwu 1,-208(1)
	mflr 0
	stfd 31,200(1)
	stmw 28,184(1)
	stw 0,212(1)
	mr 31,3
	li 9,0
	lwz 11,256(31)
	stw 9,552(31)
	lwz 0,892(11)
	cmpw 0,0,31
	bc 4,2,.L777
	lwz 9,84(11)
	lwz 0,1812(9)
	xoris 11,0,0xffff
	xori 0,0,4
	xori 11,11,65534
	addic 9,0,-1
	subfe 10,9,0
	addic 0,11,-1
	subfe 9,0,11
	and. 11,10,9
	bc 12,2,.L776
.L777:
	mr 3,31
	bl G_FreeEdict
	b .L775
.L797:
	stw 29,412(31)
	b .L781
.L776:
	addi 3,31,376
	addi 4,31,16
	bl vectoangles
	lis 11,gi+48@ha
	lwz 7,256(31)
	lis 9,0x600
	lwz 0,gi+48@l(11)
	addi 4,31,4
	ori 9,9,3
	addi 3,1,40
	addi 7,7,4
	mtlr 0
	li 5,0
	li 6,0
	li 8,0
	mr 30,4
	blrl
	lwz 9,256(31)
	lwz 0,92(1)
	cmpw 0,0,9
	bc 12,2,.L778
	lfs 12,4(9)
	lfs 0,616(31)
	lfs 11,620(31)
	lfs 10,624(31)
	fadds 12,12,0
	stfs 12,8(1)
	lfs 13,8(9)
	fadds 13,13,11
	stfs 13,12(1)
	lfs 0,12(9)
	stfs 12,4(31)
	stfs 13,8(31)
	fadds 0,0,10
	stfs 0,12(31)
	stfs 0,16(1)
.L778:
	bl rand
	lis 0,0x6666
	srawi 9,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,2
	subf 0,9,0
	mulli 0,0,10
	subf. 9,0,3
	bc 4,1,.L780
	lis 10,.LC190@ha
	lfs 13,616(31)
	la 10,.LC190@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,2,.L779
.L780:
	lis 29,0xea0e
	bl rand
	lis 28,0x4330
	ori 29,29,41195
	srawi 11,3,31
	mulhw 0,3,29
	lis 10,.LC191@ha
	la 10,.LC191@l(10)
	add 0,0,3
	lfd 31,0(10)
	srawi 0,0,6
	subf 0,11,0
	mulli 0,0,70
	subf 3,0,3
	addi 3,3,-35
	xoris 3,3,0x8000
	stw 3,180(1)
	stw 28,176(1)
	lfd 0,176(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,8(1)
	bl rand
	mulhw 0,3,29
	srawi 11,3,31
	add 0,0,3
	srawi 0,0,6
	subf 0,11,0
	mulli 0,0,70
	subf 3,0,3
	addi 3,3,-35
	xoris 3,3,0x8000
	stw 3,180(1)
	stw 28,176(1)
	lfd 0,176(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,12(1)
	bl rand
	mulhw 29,3,29
	srawi 0,3,31
	lfs 0,12(1)
	lfs 13,8(1)
	add 29,29,3
	srawi 29,29,5
	stfs 0,620(31)
	subf 29,0,29
	stfs 13,616(31)
	mulli 29,29,35
	subf 3,29,3
	xoris 3,3,0x8000
	stw 3,180(1)
	stw 28,176(1)
	lfd 0,176(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,624(31)
	stfs 0,16(1)
.L779:
	lwz 0,412(31)
	cmpwi 0,0,0
	mr 11,0
	bc 4,2,.L795
	lis 10,.LC192@ha
	lwz 4,256(31)
	lis 9,g_edicts@ha
	la 10,.LC192@l(10)
	lwz 3,g_edicts@l(9)
	lfs 1,0(10)
	addi 4,4,4
	bl findradius
	mr. 29,3
	bc 12,2,.L781
	lis 10,.LC193@ha
	lis 9,gi@ha
	la 10,.LC193@l(10)
	la 28,gi@l(9)
	lfd 31,0(10)
.L784:
	mr 3,29
	bl aom_valid
	cmpwi 0,3,0
	bc 12,2,.L785
	lwz 9,256(29)
	lwz 0,256(31)
	cmpw 0,9,0
	bc 12,2,.L785
	lwz 0,40(29)
	cmpwi 0,0,0
	bc 12,2,.L785
	lwz 11,48(28)
	addi 3,1,104
	addi 4,29,4
	addi 5,31,188
	addi 6,31,200
	mr 7,30
	mr 8,31
	mtlr 11
	li 9,3
	blrl
	lfs 0,112(1)
	fcmpu 0,0,31
	bc 12,2,.L797
.L785:
	lis 9,.LC192@ha
	lwz 4,256(31)
	mr 3,29
	la 9,.LC192@l(9)
	lfs 1,0(9)
	addi 4,4,4
	bl findradius
	mr. 29,3
	bc 4,2,.L784
.L781:
	lwz 0,412(31)
	cmpwi 0,0,0
	mr 11,0
	bc 12,2,.L796
.L795:
	lwz 9,256(31)
	addi 3,1,8
	lfs 13,4(11)
	lfs 0,4(9)
	fsubs 0,0,13
	stfs 0,8(1)
	lfs 13,8(9)
	lfs 0,8(11)
	fsubs 13,13,0
	stfs 13,12(1)
	lfs 0,12(9)
	lfs 13,12(11)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	lis 9,.LC192@ha
	la 9,.LC192@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,1,.L798
	lis 10,.LC194@ha
	lwz 9,412(31)
	addi 3,1,104
	la 10,.LC194@l(10)
	lfs 0,0(10)
	stfs 0,104(1)
	stfs 0,108(1)
	stfs 0,112(1)
	lfs 13,4(9)
	fadds 13,13,0
	stfs 13,104(1)
	lfs 12,8(9)
	fadds 12,12,0
	stfs 12,108(1)
	lfs 11,12(9)
	stfs 13,4(31)
	stfs 12,8(31)
	fadds 11,11,0
	stfs 11,112(1)
	stfs 11,12(31)
	lfs 0,4(9)
	fsubs 13,13,0
	stfs 13,104(1)
	lfs 0,8(9)
	fsubs 12,12,0
	stfs 12,108(1)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,112(1)
	bl VectorLength
	lis 9,.LC195@ha
	la 9,.LC195@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L793
	lwz 4,412(31)
	li 3,9
	li 6,100
	addi 4,4,4
	mr 5,4
	bl SpawnDamage
	lwz 3,412(31)
	bl G_FreeEdict
.L798:
	li 0,0
	stw 0,412(31)
	b .L793
.L796:
	lwz 9,256(31)
	lis 10,.LC196@ha
	addi 3,1,24
	lfs 0,616(31)
	la 10,.LC196@l(10)
	mr 4,3
	lfs 12,4(9)
	lfs 9,620(31)
	lfs 10,8(31)
	fadds 12,12,0
	lfs 8,624(31)
	lfs 0,4(31)
	lfs 1,0(10)
	stfs 12,8(1)
	lfs 13,8(9)
	fsubs 12,12,0
	lfs 11,12(31)
	fadds 13,13,9
	stfs 13,12(1)
	lfs 0,12(9)
	fsubs 13,13,10
	stfs 12,24(1)
	fadds 0,0,8
	stfs 13,28(1)
	fsubs 11,0,11
	stfs 0,16(1)
	stfs 11,32(1)
	bl VectorScale
	lfs 0,24(1)
	lfs 13,28(1)
	lfs 12,32(1)
	lfs 11,376(31)
	lfs 10,380(31)
	lfs 9,384(31)
	fadds 0,0,11
	fadds 13,13,10
	fadds 12,12,9
	stfs 0,376(31)
	stfs 13,380(31)
	stfs 12,384(31)
.L793:
	lis 9,level+4@ha
	lis 11,.LC189@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC189@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L775:
	lwz 0,212(1)
	mtlr 0
	lmw 28,184(1)
	lfd 31,200(1)
	la 1,208(1)
	blr
.Lfe18:
	.size	 aom_think,.Lfe18-aom_think
	.section	".rodata"
	.align 3
.LC197:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC198:
	.long 0x0
	.align 3
.LC199:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC200:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl aod_think
	.type	 aod_think,@function
aod_think:
	stwu 1,-144(1)
	mflr 0
	stfd 31,136(1)
	stmw 28,120(1)
	stw 0,148(1)
	mr 31,3
	li 9,0
	lwz 10,256(31)
	stw 9,552(31)
	lwz 0,892(10)
	cmpw 0,0,31
	bc 4,2,.L801
	lwz 9,84(10)
	lwz 0,1812(9)
	cmpwi 0,0,2
	bc 12,2,.L800
.L801:
	mr 3,31
	bl G_FreeEdict
	b .L799
.L800:
	lfs 0,16(10)
	lis 11,gi+48@ha
	lis 9,0x600
	ori 9,9,3
	addi 7,10,4
	addi 3,1,40
	addi 4,31,4
	stfs 0,16(31)
	li 5,0
	li 6,0
	lfs 13,20(10)
	li 8,0
	stfs 13,20(31)
	lfs 0,24(10)
	stfs 0,24(31)
	lwz 0,gi+48@l(11)
	mtlr 0
	blrl
	lwz 9,256(31)
	lwz 0,92(1)
	cmpw 0,0,9
	bc 12,2,.L802
	lfs 12,4(9)
	lfs 0,616(31)
	lfs 11,620(31)
	lfs 10,624(31)
	fadds 12,12,0
	stfs 12,8(1)
	lfs 13,8(9)
	fadds 13,13,11
	stfs 13,12(1)
	lfs 0,12(9)
	stfs 12,4(31)
	stfs 13,8(31)
	fadds 0,0,10
	stfs 0,12(31)
	stfs 0,16(1)
.L802:
	bl rand
	lis 0,0x6666
	srawi 9,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,2
	subf 0,9,0
	mulli 0,0,10
	subf. 9,0,3
	bc 4,1,.L804
	lis 10,.LC198@ha
	lfs 13,616(31)
	la 10,.LC198@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,2,.L803
.L804:
	lis 29,0x51eb
	bl rand
	lis 28,0x4330
	ori 29,29,34079
	srawi 11,3,31
	mulhw 0,3,29
	lis 10,.LC199@ha
	la 10,.LC199@l(10)
	srawi 0,0,4
	lfd 31,0(10)
	subf 0,11,0
	mulli 0,0,50
	subf 3,0,3
	addi 3,3,-25
	xoris 3,3,0x8000
	stw 3,116(1)
	stw 28,112(1)
	lfd 0,112(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,8(1)
	bl rand
	mulhw 0,3,29
	srawi 9,3,31
	srawi 0,0,4
	subf 0,9,0
	mulli 0,0,50
	subf 3,0,3
	addi 3,3,-25
	xoris 3,3,0x8000
	stw 3,116(1)
	stw 28,112(1)
	lfd 0,112(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,12(1)
	bl rand
	mulhw 29,3,29
	srawi 0,3,31
	lfs 0,12(1)
	lfs 13,8(1)
	srawi 29,29,3
	subf 29,0,29
	stfs 0,620(31)
	mulli 29,29,25
	stfs 13,616(31)
	subf 3,29,3
	xoris 3,3,0x8000
	stw 3,116(1)
	stw 28,112(1)
	lfd 0,112(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,624(31)
	stfs 0,16(1)
.L803:
	lwz 9,256(31)
	lis 10,.LC200@ha
	addi 3,1,24
	lfs 0,616(31)
	la 10,.LC200@l(10)
	mr 4,3
	lfs 12,4(9)
	lfs 9,620(31)
	lfs 10,8(31)
	fadds 12,12,0
	lfs 8,624(31)
	lfs 0,4(31)
	lfs 1,0(10)
	stfs 12,8(1)
	lfs 13,8(9)
	fsubs 12,12,0
	lfs 11,12(31)
	fadds 13,13,9
	stfs 13,12(1)
	lfs 0,12(9)
	fsubs 13,13,10
	stfs 12,24(1)
	fadds 0,0,8
	stfs 13,28(1)
	fsubs 11,0,11
	stfs 0,16(1)
	stfs 11,32(1)
	bl VectorScale
	lfs 0,24(1)
	lis 11,level+4@ha
	lis 9,.LC197@ha
	lfs 13,28(1)
	lfs 12,32(1)
	lfs 11,376(31)
	lfs 10,380(31)
	lfs 9,384(31)
	fadds 0,0,11
	fadds 13,13,10
	lfd 11,.LC197@l(9)
	fadds 12,12,9
	stfs 0,376(31)
	stfs 13,380(31)
	stfs 12,384(31)
	lfs 0,level+4@l(11)
	fadd 0,0,11
	frsp 0,0
	stfs 0,428(31)
.L799:
	lwz 0,148(1)
	mtlr 0
	lmw 28,120(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe19:
	.size	 aod_think,.Lfe19-aod_think
	.section	".rodata"
	.align 2
.LC202:
	.string	"angel of death"
	.align 2
.LC203:
	.string	"world/amb19.wav"
	.align 2
.LC204:
	.string	"models/super2/aodeath/tris.md2"
	.align 2
.LC205:
	.string	"angel of life"
	.align 2
.LC206:
	.string	"world/comp_hum2.wav"
	.align 2
.LC207:
	.string	"models/super2/aolife/tris.md2"
	.align 2
.LC208:
	.string	"angel of mercy"
	.align 2
.LC209:
	.string	"models/super2/aomercy/tris.md2"
	.align 2
.LC210:
	.string	"familiar"
	.align 3
.LC201:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl spawn_angel
	.type	 spawn_angel,@function
spawn_angel:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl G_Spawn
	mr 31,3
	lis 11,angel_touch@ha
	stw 29,256(31)
	li 0,0
	la 11,angel_touch@l(11)
	lfs 13,4(29)
	li 10,6
	li 8,2
	stw 31,892(29)
	lis 7,level+4@ha
	lis 9,.LC201@ha
	lfd 12,.LC201@l(9)
	stfs 13,4(31)
	lfs 0,8(29)
	stfs 0,8(31)
	lfs 13,12(29)
	stw 10,260(31)
	stw 8,248(31)
	stfs 13,12(31)
	stw 11,444(31)
	stw 0,200(31)
	stw 0,196(31)
	stw 0,192(31)
	stw 0,188(31)
	stw 0,208(31)
	stw 0,204(31)
	lfs 0,level+4@l(7)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(31)
	lwz 9,84(29)
	lwz 0,1812(9)
	cmpwi 0,0,2
	bc 4,2,.L806
	lis 9,aod_think@ha
	lis 11,.LC202@ha
	la 9,aod_think@l(9)
	la 11,.LC202@l(11)
	lis 29,gi@ha
	stw 11,280(31)
	lis 3,.LC203@ha
	la 29,gi@l(29)
	stw 9,436(31)
	la 3,.LC203@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,76(31)
	lwz 0,32(29)
	lis 3,.LC204@ha
	la 3,.LC204@l(3)
	b .L814
.L806:
	cmpwi 0,0,3
	bc 4,2,.L808
	lis 9,aol_think@ha
	lis 11,.LC205@ha
	la 9,aol_think@l(9)
	la 11,.LC205@l(11)
	lis 29,gi@ha
	stw 11,280(31)
	lis 3,.LC206@ha
	la 29,gi@l(29)
	stw 9,436(31)
	la 3,.LC206@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,76(31)
	lwz 0,32(29)
	lis 3,.LC207@ha
	la 3,.LC207@l(3)
	b .L814
.L808:
	cmpwi 0,0,4
	bc 4,2,.L810
	lis 9,aom_think@ha
	lis 11,.LC208@ha
	la 9,aom_think@l(9)
	la 11,.LC208@l(11)
	lis 29,gi@ha
	stw 11,280(31)
	lis 3,.LC206@ha
	la 29,gi@l(29)
	stw 9,436(31)
	la 3,.LC206@l(3)
	b .L815
.L810:
	cmpwi 0,0,-2
	bc 4,2,.L812
	lis 9,aom_think@ha
	lis 11,.LC210@ha
	la 9,aom_think@l(9)
	la 11,.LC210@l(11)
	lis 29,gi@ha
	stw 11,280(31)
	lis 3,.LC203@ha
	la 29,gi@l(29)
	stw 9,436(31)
	la 3,.LC203@l(3)
.L815:
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,76(31)
	lwz 0,32(29)
	lis 3,.LC209@ha
	la 3,.LC209@l(3)
.L814:
	mtlr 0
	blrl
	stw 3,40(31)
	b .L807
.L812:
	li 0,0
	mr 3,31
	stw 0,892(29)
	bl G_FreeEdict
	b .L805
.L807:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L805:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 spawn_angel,.Lfe20-spawn_angel
	.section	".rodata"
	.align 3
.LC211:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC212:
	.long 0x43fa0000
	.align 2
.LC213:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl blossom_think
	.type	 blossom_think,@function
blossom_think:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 30,3
	lis 9,g_edicts@ha
	lwz 11,612(30)
	lwz 31,g_edicts@l(9)
	cmpwi 0,11,0
	bc 12,2,.L817
	bl G_FreeEdict
	b .L816
.L817:
	lwz 0,444(30)
	cmpwi 0,0,0
	bc 4,2,.L818
	lis 9,rocket_touch@ha
	la 9,rocket_touch@l(9)
	stw 9,444(30)
.L818:
	lwz 9,540(30)
	cmpwi 0,9,0
	bc 12,2,.L831
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 12,1,.L819
	stw 11,540(30)
.L819:
	lwz 0,540(30)
	addi 28,30,376
	addi 27,30,16
	cmpwi 0,0,0
	mr 9,0
	bc 4,2,.L832
.L831:
	cmpwi 0,31,0
	addi 28,30,376
	addi 27,30,16
	bc 12,2,.L820
.L823:
	lwz 0,256(30)
	cmpw 0,31,0
	bc 12,2,.L826
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L826
	lwz 0,264(31)
	andi. 9,0,8192
	bc 12,2,.L825
.L826:
	lwz 0,184(31)
	andi. 9,0,4
	bc 12,2,.L824
.L825:
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L824
	bl rand
	mr 29,3
	bl clientcount
	divw 0,29,3
	mullw 0,0,3
	cmpw 0,29,0
	bc 4,2,.L824
	stw 31,540(30)
.L824:
	lis 9,.LC212@ha
	mr 3,31
	la 9,.LC212@l(9)
	addi 4,30,4
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 4,2,.L823
.L820:
	lwz 0,540(30)
	cmpwi 0,0,0
	mr 9,0
	bc 12,2,.L829
.L832:
	lfs 13,4(9)
	lfs 0,4(30)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,376(30)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,380(30)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,384(30)
.L829:
	mr 3,28
	bl VectorLength
	lis 9,.LC213@ha
	la 9,.LC213@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,2,.L830
	mr 3,28
	mr 4,28
	bl VectorNormalize2
	lis 9,.LC213@ha
	mr 3,28
	la 9,.LC213@l(9)
	mr 4,28
	lfs 1,0(9)
	bl VectorScale
.L830:
	mr 3,28
	mr 4,27
	bl vectoangles
	lis 9,level+4@ha
	lis 11,.LC211@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC211@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
.L816:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 blossom_think,.Lfe21-blossom_think
	.section	".rodata"
	.align 2
.LC214:
	.string	"powers/deathblossom.wav"
	.align 2
.LC215:
	.string	"models/super2/blossom/db.md2"
	.align 2
.LC217:
	.string	"weapons/rockfly.wav"
	.align 3
.LC216:
	.long 0x3fd99999
	.long 0x9999999a
	.align 2
.LC218:
	.long 0x3f800000
	.align 2
.LC219:
	.long 0x0
	.align 2
.LC220:
	.long 0x41c80000
	.align 3
.LC221:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl death_blossom
	.type	 death_blossom,@function
death_blossom:
	stwu 1,-128(1)
	mflr 0
	stmw 15,60(1)
	stw 0,132(1)
	mr 31,3
	mr 28,4
	lwz 0,260(31)
	li 30,0
	li 15,200
	cmpwi 0,0,7
	bc 12,2,.L833
	cmpw 0,28,31
	bc 12,2,.L833
	lis 29,gi@ha
	lis 3,.LC214@ha
	la 29,gi@l(29)
	la 3,.LC214@l(3)
	lwz 9,36(29)
	mr 25,29
	lis 16,.LC180@ha
	lis 17,.LC215@ha
	lis 18,level@ha
	mtlr 9
	lis 19,.LC216@ha
	lis 20,blossom_think@ha
	lis 21,.LC217@ha
	lis 22,0x4330
	lis 26,0xc040
	lis 27,0x4040
	li 24,0
	blrl
	lis 9,.LC218@ha
	lwz 0,16(29)
	lis 11,.LC218@ha
	la 9,.LC218@l(9)
	la 11,.LC218@l(11)
	lfs 1,0(9)
	mr 5,3
	mtlr 0
	li 4,0
	lis 9,.LC219@ha
	lfs 2,0(11)
	mr 3,31
	la 9,.LC219@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC220@ha
	lfs 13,12(31)
	xor 0,28,31
	la 9,.LC220@l(9)
	lfs 11,4(31)
	addic 11,0,-1
	subfe 23,11,0
	lfs 12,0(9)
	lfs 0,8(31)
	stfs 11,24(1)
	fadds 13,13,12
	stfs 0,28(1)
	stfs 13,32(1)
.L839:
	addi 3,1,8
	bl avrandom
	bl G_Spawn
	lfs 13,24(1)
	mr 29,3
	addi 3,1,8
	addi 4,29,16
	stfs 13,4(29)
	lfs 0,28(1)
	stfs 0,8(29)
	lfs 13,32(1)
	stfs 13,12(29)
	lfs 0,8(1)
	stfs 0,340(29)
	lfs 13,12(1)
	stfs 13,344(29)
	lfs 0,16(1)
	stfs 0,348(29)
	bl vectoangles
	xoris 0,15,0x8000
	stw 0,52(1)
	lis 11,.LC221@ha
	addi 3,1,8
	stw 22,48(1)
	la 11,.LC221@l(11)
	addi 4,29,376
	lfd 0,0(11)
	lfd 1,48(1)
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	lis 0,0x600
	li 10,2
	stw 26,188(29)
	ori 0,0,3
	la 11,.LC180@l(16)
	stw 10,248(29)
	li 9,8
	stw 0,252(29)
	la 3,.LC215@l(17)
	stw 11,280(29)
	stw 9,260(29)
	stw 26,192(29)
	stw 26,196(29)
	stw 27,200(29)
	stw 27,204(29)
	stw 27,208(29)
	lwz 9,32(25)
	mtlr 9
	blrl
	stw 3,40(29)
	la 9,level@l(18)
	li 0,100
	stw 31,256(29)
	la 10,blossom_think@l(20)
	lis 11,0x42c8
	stw 24,444(29)
	la 3,.LC217@l(21)
	lfs 0,4(9)
	lfd 13,.LC216@l(19)
	stw 0,520(29)
	stw 10,436(29)
	stw 11,524(29)
	stw 24,516(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 9,36(25)
	mtlr 9
	blrl
	addi 0,30,-1
	stw 3,76(29)
	or 0,30,0
	srwi 0,0,31
	and. 9,0,23
	bc 12,2,.L840
	stw 28,540(29)
.L840:
	lwz 9,72(25)
	mr 3,29
	addi 30,30,1
	mtlr 9
	blrl
	cmpwi 0,30,3
	bc 4,1,.L839
.L833:
	lwz 0,132(1)
	mtlr 0
	lmw 15,60(1)
	la 1,128(1)
	blr
.Lfe22:
	.size	 death_blossom,.Lfe22-death_blossom
	.section	".rodata"
	.align 2
.LC223:
	.string	"models/objects/debris2/tris.md2"
	.align 2
.LC222:
	.long 0xbca3d70a
	.align 2
.LC224:
	.long 0x0
	.align 2
.LC225:
	.long 0x40000000
	.align 3
.LC226:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl fball_touch
	.type	 fball_touch,@function
fball_touch:
	stwu 1,-80(1)
	mflr 0
	mfcr 12
	stmw 26,56(1)
	stw 0,84(1)
	stw 12,52(1)
	mr 30,3
	mr 27,4
	lwz 0,256(30)
	mr 26,5
	mr 31,6
	cmpw 0,27,0
	bc 12,2,.L842
	cmpwi 4,31,0
	bc 12,18,.L844
	lwz 0,16(31)
	andi. 9,0,4
	bc 12,2,.L844
	bl G_FreeEdict
	b .L842
.L844:
	lwz 3,256(30)
	addi 29,30,4
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L845
	mr 4,29
	li 5,2
	bl PlayerNoise
.L845:
	lis 9,.LC222@ha
	addi 28,30,376
	lfs 1,.LC222@l(9)
	mr 3,29
	mr 4,28
	addi 5,1,16
	bl VectorMA
	lwz 0,512(27)
	cmpwi 0,0,0
	bc 12,2,.L846
	lwz 0,540(30)
	cmpw 0,27,0
	bc 12,2,.L846
	lwz 5,256(30)
	li 0,0
	li 11,36
	lwz 9,516(30)
	mr 6,28
	mr 7,29
	stw 0,8(1)
	mr 8,26
	mr 3,27
	stw 11,12(1)
	mr 4,30
	li 10,0
	bl T_Damage
	stw 27,540(30)
	b .L847
.L846:
	lis 9,.LC224@ha
	lis 11,deathmatch@ha
	la 9,.LC224@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L848
	bc 12,18,.L848
	lwz 0,16(31)
	andi. 10,0,120
	bc 4,2,.L848
	bl rand
	lis 0,0x6666
	srawi 11,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,1
	subf 31,11,0
	slwi 9,31,2
	add 9,9,31
	subf 31,9,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L848
	lis 28,.LC223@ha
.L852:
	lis 9,.LC225@ha
	mr 3,30
	la 9,.LC225@l(9)
	la 4,.LC223@l(28)
	lfs 1,0(9)
	mr 5,29
	bl ThrowDebris
	cmpwi 0,31,0
	addi 31,31,-1
	bc 4,2,.L852
.L848:
	li 0,0
	stw 0,540(30)
.L847:
	lwz 0,520(30)
	lis 11,0x4330
	lis 10,.LC226@ha
	mr 3,30
	xoris 0,0,0x8000
	la 10,.LC226@l(10)
	lfs 2,524(3)
	stw 0,44(1)
	mr 5,27
	li 6,0
	stw 11,40(1)
	li 7,36
	lfd 0,0(10)
	lfd 1,40(1)
	lwz 4,256(3)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
.L842:
	lwz 0,84(1)
	lwz 12,52(1)
	mtlr 0
	lmw 26,56(1)
	mtcrf 8,12
	la 1,80(1)
	blr
.Lfe23:
	.size	 fball_touch,.Lfe23-fball_touch
	.section	".rodata"
	.align 2
.LC227:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC228:
	.string	"func_button"
	.align 2
.LC229:
	.long 0x44fa0000
	.align 3
.LC230:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC231:
	.long 0x3f800000
	.align 2
.LC232:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl kin_throw
	.type	 kin_throw,@function
kin_throw:
	stwu 1,-208(1)
	mflr 0
	stfd 31,200(1)
	stmw 27,180(1)
	stw 0,212(1)
	mr 31,3
	addi 29,1,96
	bl MV
	lis 9,.LC229@ha
	lis 4,v_forward@ha
	la 9,.LC229@l(9)
	mr 5,29
	lfs 1,0(9)
	la 4,v_forward@l(4)
	addi 3,31,4
	bl VectorMA
	lwz 11,508(31)
	lis 0,0x4330
	lis 9,.LC230@ha
	lfs 11,12(31)
	mr 7,29
	addi 11,11,-8
	la 9,.LC230@l(9)
	lfs 10,104(1)
	xoris 11,11,0x8000
	lfd 9,0(9)
	lis 8,gi+48@ha
	stw 11,172(1)
	lis 9,0x600
	addi 4,1,112
	stw 0,168(1)
	addi 3,1,16
	ori 9,9,3
	lfd 0,168(1)
	addi 5,1,128
	addi 6,1,144
	lwz 29,gi+48@l(8)
	lis 0,0xc120
	lis 11,0x4120
	lfs 12,4(31)
	mr 8,31
	fsub 0,0,9
	lfs 13,8(31)
	mtlr 29
	stw 0,136(1)
	stfs 12,112(1)
	frsp 0,0
	stfs 13,116(1)
	stw 11,152(1)
	stw 0,128(1)
	fadds 10,10,0
	stw 0,132(1)
	fadds 11,11,0
	stw 11,144(1)
	stw 11,148(1)
	stfs 10,104(1)
	stfs 11,120(1)
	blrl
	lwz 9,68(1)
	lis 4,.LC228@ha
	la 4,.LC228@l(4)
	lwz 3,280(9)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L856
	lwz 3,68(1)
	mr 5,31
	li 4,0
	bl button_use
	b .L860
.L856:
	lwz 3,68(1)
	mr 4,31
	bl OnSameTeam
	cmpwi 0,3,0
	bc 4,2,.L858
	lwz 11,68(1)
	cmpw 0,11,31
	bc 12,2,.L858
	lwz 0,512(11)
	cmpwi 0,0,0
	bc 12,2,.L858
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,11,0
	bc 12,2,.L858
	lwz 9,84(11)
	cmpwi 0,9,0
	bc 12,2,.L857
	lwz 0,1808(9)
	cmpwi 0,0,8
	bc 4,2,.L857
.L858:
	li 3,0
	b .L859
.L857:
	lis 29,0x1062
	bl rand
	lis 28,0x4330
	ori 29,29,19923
	srawi 11,3,31
	mulhw 0,3,29
	lis 10,.LC230@ha
	la 10,.LC230@l(10)
	addi 27,1,80
	srawi 0,0,7
	lfd 31,0(10)
	subf 0,11,0
	mulli 0,0,2000
	subf 3,0,3
	addi 3,3,-1000
	xoris 3,3,0x8000
	stw 3,172(1)
	stw 28,168(1)
	lfd 0,168(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,80(1)
	bl rand
	mulhw 0,3,29
	srawi 9,3,31
	srawi 0,0,7
	subf 0,9,0
	mulli 0,0,2000
	subf 3,0,3
	addi 3,3,-1000
	xoris 3,3,0x8000
	stw 3,172(1)
	stw 28,168(1)
	lfd 0,168(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,84(1)
	bl rand
	mr 9,3
	mulhw 29,9,29
	srawi 0,9,31
	lis 10,.LC231@ha
	lwz 3,68(1)
	la 10,.LC231@l(10)
	mr 4,27
	srawi 29,29,5
	lfs 1,0(10)
	addi 3,3,376
	subf 29,0,29
	mr 5,3
	mulli 29,29,500
	subf 9,29,9
	addi 9,9,100
	xoris 9,9,0x8000
	stw 9,172(1)
	stw 28,168(1)
	lfd 0,168(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,88(1)
	bl VectorMA
	mr 3,27
	bl VectorLength
	lis 9,.LC232@ha
	lwz 3,68(1)
	mr 4,31
	la 9,.LC232@l(9)
	li 11,34
	lfs 13,0(9)
	li 0,37
	addi 7,3,4
	stw 11,8(1)
	mr 6,27
	stw 0,12(1)
	mr 5,4
	addi 8,1,40
	fdivs 1,1,13
	li 10,0
	fctiwz 0,1
	stfd 0,168(1)
	lwz 9,172(1)
	bl T_Damage
.L860:
	li 3,1
.L859:
	lwz 0,212(1)
	mtlr 0
	lmw 27,180(1)
	lfd 31,200(1)
	la 1,208(1)
	blr
.Lfe24:
	.size	 kin_throw,.Lfe24-kin_throw
	.section	".rodata"
	.align 2
.LC234:
	.string	"kcard"
	.align 2
.LC235:
	.string	"models/super2/cards/tris.md2"
	.align 2
.LC236:
	.string	"misc/lasfly.wav"
	.align 3
.LC237:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC238:
	.long 0x40400000
	.align 2
.LC239:
	.long 0x41200000
	.align 2
.LC240:
	.long 0x41a00000
	.align 2
.LC241:
	.long 0x3f800000
	.align 2
.LC242:
	.long 0x43480000
	.align 2
.LC243:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl card_fire
	.type	 card_fire,@function
card_fire:
	stwu 1,-128(1)
	mflr 0
	stfd 29,104(1)
	stfd 30,112(1)
	stfd 31,120(1)
	stmw 22,64(1)
	stw 0,132(1)
	xoris 4,4,0x8000
	fmr 29,1
	stw 4,60(1)
	lis 25,0x4330
	lis 10,.LC237@ha
	stw 25,56(1)
	la 10,.LC237@l(10)
	lis 11,.LC238@ha
	lfd 31,56(1)
	la 11,.LC238@l(11)
	mr 24,3
	lfd 30,0(10)
	addi 28,1,24
	addi 27,1,40
	lfs 0,0(11)
	lis 10,.LC239@ha
	mr 22,7
	la 10,.LC239@l(10)
	mr 26,6
	fsub 31,31,30
	lfs 13,0(10)
	mr 23,5
	lis 29,v_forward@ha
	frsp 31,31
	fsubs 31,31,0
	fdivs 31,31,13
	bl MV
	lis 9,.LC240@ha
	mr 4,28
	la 9,.LC240@l(9)
	la 3,v_forward@l(29)
	lfs 1,0(9)
	bl VectorScale
	lis 4,v_right@ha
	la 3,v_forward@l(29)
	la 4,v_right@l(4)
	mr 5,27
	fmr 1,31
	bl VectorMA
	lis 9,.LC241@ha
	mr 3,28
	la 9,.LC241@l(9)
	mr 5,3
	lfs 1,0(9)
	addi 4,24,4
	bl VectorMA
	lwz 9,508(24)
	lfs 13,32(1)
	addi 9,9,-8
	xoris 9,9,0x8000
	stw 9,60(1)
	stw 25,56(1)
	lfd 0,56(1)
	fsub 0,0,30
	frsp 0,0
	fadds 13,13,0
	stfs 13,32(1)
	bl G_Spawn
	mr 29,3
	addi 3,1,8
	bl vrandom
	lis 9,.LC242@ha
	addi 3,1,8
	la 9,.LC242@l(9)
	addi 4,29,388
	lfs 1,0(9)
	bl VectorScale
	lfs 13,24(1)
	mr 3,27
	addi 4,29,16
	stfs 13,4(29)
	lfs 0,28(1)
	stfs 0,8(29)
	lfs 13,32(1)
	stfs 13,12(29)
	lfs 0,40(1)
	stfs 0,340(29)
	lfs 13,44(1)
	stfs 13,344(29)
	lfs 0,48(1)
	stfs 0,348(29)
	bl vectoangles
	xoris 26,26,0x8000
	stw 26,60(1)
	addi 4,29,376
	mr 3,27
	stw 25,56(1)
	lfd 1,56(1)
	fsub 1,1,30
	frsp 1,1
	bl VectorScale
	lis 11,0x600
	lis 9,.LC234@ha
	li 0,0
	ori 11,11,3
	li 10,6
	li 8,2
	stw 11,252(29)
	la 9,.LC234@l(9)
	lis 28,gi@ha
	stw 10,260(29)
	la 28,gi@l(28)
	stw 8,248(29)
	lis 3,.LC235@ha
	stw 0,200(29)
	la 3,.LC235@l(3)
	stw 0,196(29)
	stw 0,192(29)
	stw 0,188(29)
	stw 0,208(29)
	stw 0,204(29)
	stw 9,280(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	bl rand
	lis 9,0x6666
	mr 8,3
	stw 24,256(29)
	ori 9,9,26215
	srawi 0,8,31
	mulhw 9,8,9
	lis 11,card_touch@ha
	lis 10,.LC243@ha
	la 11,card_touch@l(11)
	lis 7,level+4@ha
	srawi 9,9,1
	stw 11,444(29)
	la 10,.LC243@l(10)
	subf 9,0,9
	lfs 13,0(10)
	lis 3,.LC236@ha
	slwi 0,9,2
	lis 10,G_FreeEdict@ha
	add 0,0,9
	la 10,G_FreeEdict@l(10)
	subf 8,0,8
	la 3,.LC236@l(3)
	stw 8,60(29)
	lfs 0,level+4@l(7)
	stw 10,436(29)
	stw 23,516(29)
	fadds 0,0,13
	stw 22,520(29)
	stfs 29,524(29)
	stfs 0,428(29)
	lwz 9,36(28)
	mtlr 9
	blrl
	stw 3,76(29)
	lwz 0,72(28)
	mr 3,29
	mtlr 0
	blrl
	lwz 0,132(1)
	mtlr 0
	lmw 22,64(1)
	lfd 29,104(1)
	lfd 30,112(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe25:
	.size	 card_fire,.Lfe25-card_fire
	.section	".rodata"
	.align 3
.LC244:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC245:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC246:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl grav_think
	.type	 grav_think,@function
grav_think:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 25,44(1)
	stw 0,84(1)
	mr 30,3
	lwz 0,480(30)
	lis 10,0x4330
	lis 9,.LC245@ha
	la 9,.LC245@l(9)
	xoris 0,0,0x8000
	lfd 13,0(9)
	stw 0,36(1)
	lis 9,level+4@ha
	stw 10,32(1)
	lfd 0,32(1)
	lfs 12,level+4@l(9)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L875
	bl G_FreeEdict
	b .L874
.L875:
	lis 9,.LC244@ha
	fmr 0,12
	lis 11,g_edicts@ha
	lfd 31,.LC244@l(9)
	addi 4,30,4
	lis 29,g_edicts@ha
	lis 9,.LC246@ha
	lwz 3,g_edicts@l(11)
	mr 27,4
	la 9,.LC246@l(9)
	fadd 0,0,31
	lfs 1,0(9)
	frsp 0,0
	stfs 0,428(30)
	bl findradius
	mr. 31,3
	bc 12,2,.L874
	lwz 0,g_edicts@l(29)
	cmpw 0,31,0
	bc 12,2,.L874
	li 28,0
	lis 25,0x3f80
	lis 26,sv_gravity@ha
.L879:
	cmpw 0,31,30
	bc 12,2,.L880
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L880
	lwz 0,g_edicts@l(29)
	cmpw 0,31,0
	bc 12,2,.L880
	lwz 3,256(30)
	cmpw 0,31,3
	bc 12,2,.L880
	mr 4,31
	bl OnSameTeam
	mr. 3,3
	bc 4,2,.L880
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L881
	lwz 0,1808(9)
	cmpwi 0,0,8
	bc 12,2,.L880
.L881:
	stw 28,8(1)
	stw 28,12(1)
	stw 25,16(1)
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L882
	stw 3,552(31)
.L882:
	lwz 9,sv_gravity@l(26)
	addi 3,31,376
	addi 4,1,8
	mr 5,3
	lfs 1,20(9)
	fadds 1,1,1
	fmul 1,1,31
	frsp 1,1
	bl VectorMA
.L880:
	lis 9,.LC246@ha
	mr 3,31
	la 9,.LC246@l(9)
	mr 4,27
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 12,2,.L874
	lwz 0,g_edicts@l(29)
	cmpw 0,31,0
	bc 4,2,.L879
.L874:
	lwz 0,84(1)
	mtlr 0
	lmw 25,44(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe26:
	.size	 grav_think,.Lfe26-grav_think
	.section	".rodata"
	.align 2
.LC249:
	.string	"powers/bionichit.wav"
	.align 3
.LC250:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC251:
	.long 0x3f800000
	.align 2
.LC252:
	.long 0x0
	.align 2
.LC253:
	.long 0xbf800000
	.align 2
.LC254:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl grap_touch
	.type	 grap_touch,@function
grap_touch:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 30,5
	lwz 11,256(31)
	mr 3,4
	cmpw 0,3,11
	bc 12,2,.L890
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,3,0
	bc 12,2,.L892
	lwz 9,84(11)
	lbz 0,16(9)
	andi. 0,0,191
	stb 0,16(9)
	lwz 11,512(3)
	cmpwi 0,11,0
	bc 12,2,.L893
	lwz 9,516(31)
	li 11,39
	li 0,0
	lwz 5,256(31)
	li 10,1000
	mr 8,30
	stw 11,12(1)
	mr 4,31
	addi 6,31,376
	stw 0,8(1)
	addi 7,31,4
	bl T_Damage
	lis 11,level+4@ha
	lis 9,.LC250@ha
	lfs 0,level+4@l(11)
	la 9,.LC250@l(9)
	lfd 13,0(9)
	lwz 9,256(31)
	lwz 10,84(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,1828(10)
.L893:
	lwz 9,256(31)
	li 0,0
	mr 3,31
	stw 0,560(9)
	bl G_FreeEdict
	b .L890
.L892:
	lis 29,gi@ha
	lis 3,.LC249@ha
	la 29,gi@l(29)
	la 3,.LC249@l(3)
	lwz 9,36(29)
	li 28,0
	mtlr 9
	blrl
	lis 9,.LC251@ha
	lwz 11,16(29)
	lis 10,.LC252@ha
	la 9,.LC251@l(9)
	mr 5,3
	lfs 2,0(9)
	la 10,.LC252@l(10)
	mtlr 11
	li 4,0
	lis 9,.LC251@ha
	lfs 3,0(10)
	mr 3,31
	la 9,.LC251@l(9)
	lfs 1,0(9)
	blrl
	lis 10,.LC253@ha
	lwz 9,264(31)
	li 11,0
	la 10,.LC253@l(10)
	li 0,1
	stw 11,388(31)
	lfs 1,0(10)
	oris 9,9,0x1
	mr 3,30
	stw 0,56(31)
	addi 4,31,340
	stw 9,264(31)
	stw 11,396(31)
	stw 11,392(31)
	stw 28,76(31)
	bl VectorScale
	lis 9,.LC254@ha
	addi 3,31,4
	la 9,.LC254@l(9)
	mr 5,3
	lfs 1,0(9)
	mr 4,30
	bl VectorMA
	stw 28,248(31)
	mr 3,31
	lwz 0,72(29)
	mtlr 0
	blrl
.L890:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 grap_touch,.Lfe27-grap_touch
	.section	".rodata"
	.align 2
.LC255:
	.long 0x3dcccccd
	.align 3
.LC256:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl grap_think
	.type	 grap_think,@function
grap_think:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	lwz 9,256(31)
	lwz 0,492(9)
	andi. 11,0,2
	bc 4,2,.L896
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L896
	lwz 0,264(9)
	andi. 9,0,8192
	bc 12,2,.L895
.L896:
	lwz 9,256(31)
	lwz 0,560(9)
	cmpw 0,0,31
	bc 4,2,.L897
	li 0,0
	stw 0,560(9)
.L897:
	mr 3,31
	bl G_FreeEdict
	b .L894
.L895:
	addi 3,31,340
	addi 4,31,16
	bl vectoangles
	lwz 0,264(31)
	andis. 0,0,0x1
	bc 12,2,.L898
	lwz 9,256(31)
	addi 3,1,8
	lfs 13,4(31)
	mr 4,3
	lfs 0,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorNormalize2
	lwz 3,256(31)
	addi 4,1,8
	lfs 1,592(31)
	addi 3,3,376
	mr 5,3
	bl VectorMA
	li 0,0
	stw 0,376(31)
	stw 0,384(31)
	stw 0,380(31)
	b .L899
.L898:
	mr 3,31
	stw 0,552(31)
	bl G_TouchTriggers
	lis 9,.LC255@ha
	addi 3,31,376
	lfs 1,.LC255@l(9)
	mr 4,3
	mr 5,3
	bl VectorMA
.L899:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,31,4
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,19
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xdcfd
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,53213
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lwz 9,120(29)
	lwz 3,256(31)
	mtlr 9
	addi 3,3,4
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC256@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC256@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L894:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe28:
	.size	 grap_think,.Lfe28-grap_think
	.section	".rodata"
	.align 3
.LC257:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC258:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC259:
	.long 0x43480000
	.align 2
.LC260:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl anchor_think
	.type	 anchor_think,@function
anchor_think:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,484(31)
	lis 10,0x4330
	lis 9,.LC258@ha
	la 9,.LC258@l(9)
	xoris 0,0,0x8000
	lfd 12,0(9)
	stw 0,28(1)
	lis 9,level@ha
	stw 10,24(1)
	la 30,level@l(9)
	lfd 0,24(1)
	lfs 13,4(30)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L902
	lwz 9,540(31)
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L902
	lwz 0,264(9)
	andi. 11,0,8192
	bc 12,2,.L901
.L902:
	mr 3,31
	bl G_FreeEdict
	b .L900
.L901:
	lfs 13,4(9)
	addi 3,1,8
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 0,0,13
	stfs 0,8(1)
	lfs 13,8(9)
	fsubs 12,12,13
	stfs 12,12(1)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	lis 9,.LC259@ha
	la 9,.LC259@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,1,.L903
	lis 11,.LC260@ha
	lwz 3,540(31)
	addi 4,1,8
	la 11,.LC260@l(11)
	lfs 1,0(11)
	addi 3,3,376
	mr 5,3
	bl VectorMA
.L903:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,31,4
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,19
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xdcfd
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,53213
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lwz 9,120(29)
	lwz 3,540(31)
	mtlr 9
	addi 3,3,4
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	lfs 0,4(30)
	lis 9,.LC257@ha
	lfd 13,.LC257@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L900:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe29:
	.size	 anchor_think,.Lfe29-anchor_think
	.section	".rodata"
	.align 2
.LC261:
	.string	"anchor"
	.align 2
.LC262:
	.string	"models/super2/anchor/tris.md2"
	.align 2
.LC264:
	.string	"powers/poweranchor.wav"
	.align 3
.LC263:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC265:
	.long 0x447a0000
	.align 3
.LC266:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC267:
	.long 0x0
	.align 2
.LC268:
	.long 0x40400000
	.align 2
.LC269:
	.long 0x41200000
	.align 2
.LC270:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl anchor
	.type	 anchor,@function
anchor:
	stwu 1,-144(1)
	mflr 0
	stfd 31,136(1)
	stmw 29,124(1)
	stw 0,148(1)
	mr 30,3
	addi 29,1,72
	bl MV
	lis 9,.LC265@ha
	lis 4,v_forward@ha
	la 9,.LC265@l(9)
	addi 3,30,4
	lfs 1,0(9)
	la 4,v_forward@l(4)
	mr 5,29
	bl VectorMA
	lwz 11,508(30)
	lis 0,0x4330
	lis 9,.LC266@ha
	lfs 11,12(30)
	lis 8,gi+48@ha
	addi 11,11,-8
	la 9,.LC266@l(9)
	lfs 10,80(1)
	xoris 11,11,0x8000
	lfd 9,0(9)
	addi 3,1,8
	stw 11,116(1)
	lis 9,0x600
	mr 7,29
	stw 0,112(1)
	addi 4,1,88
	li 5,0
	lfd 0,112(1)
	li 6,0
	ori 9,9,3
	lwz 31,gi+48@l(8)
	lfs 13,4(30)
	mr 8,30
	fsub 0,0,9
	lfs 12,8(30)
	mtlr 31
	stfs 13,88(1)
	frsp 0,0
	stfs 12,92(1)
	fadds 10,10,0
	fadds 11,11,0
	stfs 10,80(1)
	stfs 11,96(1)
	blrl
	lwz 3,60(1)
	cmpw 0,3,30
	bc 12,2,.L906
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L906
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,3,0
	bc 12,2,.L906
	mr 4,30
	bl OnSameTeam
	cmpwi 0,3,0
	bc 4,2,.L906
	lwz 9,60(1)
	lwz 0,184(9)
	andi. 11,0,4
	bc 4,2,.L907
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L906
.L907:
	lwz 9,84(9)
	cmpwi 0,9,0
	bc 12,2,.L905
	lwz 0,1808(9)
	cmpwi 0,0,8
	bc 4,2,.L905
.L906:
	li 3,0
	b .L910
.L905:
	bl G_Spawn
	lis 9,.LC267@ha
	mr 31,3
	la 9,.LC267@l(9)
	lis 0,0x600
	lfs 31,0(9)
	lis 11,.LC261@ha
	li 10,0
	lwz 9,60(1)
	la 11,.LC261@l(11)
	ori 0,0,3
	lis 8,gi+32@ha
	lis 3,.LC262@ha
	lfs 0,4(9)
	la 3,.LC262@l(3)
	stfs 0,4(31)
	lwz 9,60(1)
	lfs 0,8(9)
	stfs 0,8(31)
	lwz 9,60(1)
	lfs 0,12(9)
	stw 10,248(31)
	stw 11,280(31)
	stfs 0,12(31)
	stw 10,260(31)
	stw 0,252(31)
	stfs 31,196(31)
	stfs 31,192(31)
	stfs 31,188(31)
	stfs 31,208(31)
	stfs 31,204(31)
	stfs 31,200(31)
	lwz 0,gi+32@l(8)
	mtlr 0
	blrl
	stw 3,40(31)
	lis 8,0x4348
	lis 9,level@ha
	stw 30,256(31)
	la 9,level@l(9)
	lis 11,.LC263@ha
	lwz 0,60(1)
	lis 10,ctf@ha
	stw 8,524(31)
	stw 0,540(31)
	lfs 0,4(9)
	lfd 13,.LC263@l(11)
	lwz 11,ctf@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lfs 0,20(11)
	lfs 12,4(9)
	fcmpu 0,0,31
	bc 12,2,.L908
	lis 9,.LC268@ha
	la 9,.LC268@l(9)
	lfs 0,0(9)
	b .L911
.L908:
	lis 11,.LC269@ha
	la 11,.LC269@l(11)
	lfs 0,0(11)
.L911:
	fadds 0,12,0
	fctiwz 13,0
	stfd 13,112(1)
	lwz 0,116(1)
	lis 9,anchor_think@ha
	lis 29,gi@ha
	stw 0,484(31)
	la 9,anchor_think@l(9)
	la 29,gi@l(29)
	stw 9,436(31)
	mr 3,31
	lwz 9,72(29)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC264@ha
	la 3,.LC264@l(3)
	mtlr 9
	blrl
	lis 9,.LC270@ha
	lwz 0,16(29)
	lis 11,.LC270@ha
	la 9,.LC270@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC270@l(11)
	mr 3,30
	mtlr 0
	lis 9,.LC267@ha
	li 4,0
	lfs 2,0(11)
	la 9,.LC267@l(9)
	lfs 3,0(9)
	blrl
	li 3,1
.L910:
	lwz 0,148(1)
	mtlr 0
	lmw 29,124(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe30:
	.size	 anchor,.Lfe30-anchor
	.section	".rodata"
	.align 3
.LC271:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC272:
	.long 0x42480000
	.align 3
.LC273:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC274:
	.long 0x43fa0000
	.align 2
.LC275:
	.long 0x447a0000
	.align 2
.LC276:
	.long 0x42f00000
	.align 2
.LC277:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl cascade_think
	.type	 cascade_think,@function
cascade_think:
	stwu 1,-128(1)
	mflr 0
	stmw 27,108(1)
	stw 0,132(1)
	mr 31,3
	addi 29,31,376
	mr 3,29
	bl VectorLength
	lis 9,.LC272@ha
	la 9,.LC272@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L914
	lwz 0,484(31)
	lis 10,0x4330
	lis 11,.LC273@ha
	xoris 0,0,0x8000
	la 11,.LC273@l(11)
	stw 0,100(1)
	stw 10,96(1)
	lfd 12,0(11)
	lfd 0,96(1)
	lis 11,level@ha
	la 30,level@l(11)
	lfs 13,4(30)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L913
.L914:
	mr 3,31
	bl G_FreeEdict
	b .L912
.L913:
	mr 3,29
	mr 4,29
	bl VectorNormalize2
	lis 9,.LC274@ha
	mr 3,29
	la 9,.LC274@l(9)
	mr 4,3
	lfs 1,0(9)
	bl VectorScale
	lis 9,.LC275@ha
	lfs 13,12(31)
	lis 28,gi@ha
	la 9,.LC275@l(9)
	la 28,gi@l(28)
	lfs 0,0(9)
	mr 4,31
	addi 7,1,72
	lwz 11,48(28)
	lis 9,0x600
	mr 8,31
	lfsu 12,4(4)
	ori 9,9,3
	addi 3,1,8
	fsubs 13,13,0
	mtlr 11
	li 5,0
	li 6,0
	lfs 0,8(31)
	stfs 12,72(1)
	stfs 13,80(1)
	stfs 0,76(1)
	blrl
	bl G_Spawn
	lfs 13,20(1)
	mr 29,3
	addi 27,29,4
	stfs 13,4(29)
	lfs 0,24(1)
	stfs 0,8(29)
	lfs 13,28(1)
	stfs 13,12(29)
	lwz 9,72(28)
	mtlr 9
	blrl
	lis 9,.LC276@ha
	lis 11,.LC277@ha
	lwz 4,256(31)
	la 11,.LC277@l(11)
	la 9,.LC276@l(9)
	lfs 2,0(9)
	mr 5,4
	li 6,0
	lfs 1,0(11)
	li 7,40
	mr 3,29
	bl T_RadiusDamage
	lwz 9,100(28)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(28)
	li 3,7
	mtlr 9
	blrl
	lwz 9,120(28)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(28)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	mr 3,29
	bl G_FreeEdict
	lfs 0,4(30)
	lis 9,.LC271@ha
	lfd 13,.LC271@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L912:
	lwz 0,132(1)
	mtlr 0
	lmw 27,108(1)
	la 1,128(1)
	blr
.Lfe31:
	.size	 cascade_think,.Lfe31-cascade_think
	.section	".rodata"
	.align 2
.LC279:
	.string	"cascade"
	.align 3
.LC278:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC280:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC281:
	.long 0x43fa0000
	.align 2
.LC282:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl fire_cascade
	.type	 fire_cascade,@function
fire_cascade:
	stwu 1,-64(1)
	mflr 0
	stmw 27,44(1)
	stw 0,68(1)
	mr 27,3
	lfs 12,4(27)
	lfs 0,8(27)
	lfs 13,12(27)
	stfs 12,8(1)
	stfs 0,12(1)
	stfs 13,16(1)
	bl MV
	lwz 0,508(27)
	lis 11,0x4330
	lis 10,.LC280@ha
	lfs 13,16(1)
	xoris 0,0,0x8000
	la 10,.LC280@l(10)
	stw 0,36(1)
	stw 11,32(1)
	lfd 12,0(10)
	lfd 0,32(1)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,16(1)
	bl G_Spawn
	lfs 0,8(1)
	mr 29,3
	lis 9,v_forward@ha
	la 28,v_forward@l(9)
	addi 4,29,16
	mr 3,28
	stfs 0,4(29)
	lfs 0,12(1)
	stfs 0,8(29)
	lfs 13,16(1)
	stfs 13,12(29)
	lfs 0,v_forward@l(9)
	stfs 0,340(29)
	lfs 13,4(28)
	stfs 13,344(29)
	lfs 0,8(28)
	stfs 0,348(29)
	bl vectoangles
	lis 9,.LC281@ha
	mr 3,28
	la 9,.LC281@l(9)
	addi 4,29,376
	lfs 1,0(9)
	bl VectorScale
	li 10,0
	li 9,0
	stw 10,248(29)
	li 0,8
	li 11,3
	li 8,100
	lis 6,level@ha
	stw 0,260(29)
	lis 10,.LC282@ha
	stw 11,252(29)
	la 6,level@l(6)
	stw 8,516(29)
	la 10,.LC282@l(10)
	lis 11,G_FreeEdict@ha
	stw 9,200(29)
	la 11,G_FreeEdict@l(11)
	lis 5,.LC278@ha
	stw 9,196(29)
	lis 8,cascade_think@ha
	lis 7,.LC279@ha
	stw 9,192(29)
	la 8,cascade_think@l(8)
	la 7,.LC279@l(7)
	stw 9,188(29)
	lis 28,gi@ha
	lis 3,.LC217@ha
	stw 9,208(29)
	la 28,gi@l(28)
	la 3,.LC217@l(3)
	stw 9,204(29)
	lfs 0,4(6)
	lfs 12,0(10)
	stw 27,256(29)
	stw 11,444(29)
	fadds 0,0,12
	lfd 12,.LC278@l(5)
	fctiwz 13,0
	stfd 13,32(1)
	lwz 10,36(1)
	stw 10,484(29)
	lfs 0,4(6)
	stw 8,436(29)
	stw 7,280(29)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(29)
	lwz 9,36(28)
	mtlr 9
	blrl
	stw 3,76(29)
	lwz 0,72(28)
	mr 3,29
	mtlr 0
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 27,44(1)
	la 1,64(1)
	blr
.Lfe32:
	.size	 fire_cascade,.Lfe32-fire_cascade
	.section	".rodata"
	.align 2
.LC283:
	.string	"You get full life!\n"
	.align 2
.LC284:
	.string	"items/pkup.wav"
	.align 2
.LC285:
	.string	"You get +50 life!\n"
	.align 2
.LC286:
	.string	"items/l_health.wav"
	.align 2
.LC287:
	.string	"You get +25 life!\n"
	.align 2
.LC288:
	.string	"You get the rocket launcher!\n"
	.align 2
.LC289:
	.string	"rocket launcher"
	.align 2
.LC290:
	.string	"rockets"
	.align 2
.LC291:
	.string	"misc/w_pkup.wav"
	.align 2
.LC292:
	.string	"You get the hyperblaster!\n"
	.align 2
.LC293:
	.string	"hyperblaster"
	.align 2
.LC294:
	.string	"cells"
	.align 2
.LC295:
	.string	"You get the chaingun!\n"
	.align 2
.LC296:
	.string	"chaingun"
	.align 2
.LC297:
	.string	"bullets"
	.align 2
.LC298:
	.string	"You get the railgun!\n"
	.align 2
.LC299:
	.string	"railgun"
	.align 2
.LC300:
	.string	"slugs"
	.align 2
.LC301:
	.string	"You get the BFG!\n"
	.align 2
.LC302:
	.string	"bfg10k"
	.align 2
.LC303:
	.string	"You get body armor!\n"
	.align 2
.LC304:
	.string	"misc/ar1_pkup.wav"
	.align 2
.LC305:
	.long 0x3f800000
	.align 2
.LC306:
	.long 0x0
	.section	".text"
	.align 2
	.globl give_random
	.type	 give_random,@function
give_random:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	bl rand
	lis 0,0x6666
	srawi 11,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,2
	subf 0,11,0
	mulli 9,0,10
	subf. 0,9,3
	bc 4,2,.L917
	lis 9,gi+8@ha
	lis 5,.LC283@ha
	lwz 0,gi+8@l(9)
	la 5,.LC283@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,480(31)
	cmpwi 0,9,99
	li 0,100
	bc 4,1,.L940
	addi 0,9,25
.L940:
	stw 0,480(31)
	lis 9,.LC284@ha
	la 28,.LC284@l(9)
	b .L920
.L917:
	cmpwi 0,0,1
	bc 4,2,.L921
	lis 9,gi+8@ha
	lis 5,.LC285@ha
	lwz 0,gi+8@l(9)
	la 5,.LC285@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,480(31)
	lis 11,.LC286@ha
	la 28,.LC286@l(11)
	addi 9,9,50
	stw 9,480(31)
	b .L920
.L921:
	cmpwi 0,0,2
	bc 4,2,.L923
	lis 9,gi+8@ha
	lis 5,.LC287@ha
	lwz 0,gi+8@l(9)
	la 5,.LC287@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,480(31)
	lis 11,.LC286@ha
	la 28,.LC286@l(11)
	addi 9,9,25
	stw 9,480(31)
	b .L920
.L923:
	cmpwi 0,0,3
	bc 4,2,.L925
	lis 9,gi+8@ha
	lis 5,.LC288@ha
	lwz 0,gi+8@l(9)
	la 5,.LC288@l(5)
	li 4,2
	mr 3,31
	lis 27,.LC289@ha
	mtlr 0
	lis 28,0x38e3
	ori 28,28,36409
	crxor 6,6,6
	blrl
	la 3,.LC289@l(27)
	bl FindItem
	lis 29,itemlist@ha
	lwz 11,84(31)
	lis 9,.LC290@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 11,11,740
	mullw 0,0,28
	la 3,.LC290@l(9)
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,1
	stwx 9,11,0
	bl FindItem
	subf 0,29,3
	lwz 11,84(31)
	mullw 0,0,28
	la 3,.LC289@l(27)
	addi 11,11,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,15
	b .L941
.L925:
	cmpwi 0,0,4
	bc 4,2,.L927
	lis 9,gi+8@ha
	lis 5,.LC292@ha
	lwz 0,gi+8@l(9)
	la 5,.LC292@l(5)
	li 4,2
	mr 3,31
	lis 27,.LC293@ha
	mtlr 0
	lis 28,0x38e3
	ori 28,28,36409
	crxor 6,6,6
	blrl
	la 3,.LC293@l(27)
	bl FindItem
	lis 29,itemlist@ha
	lwz 11,84(31)
	lis 9,.LC294@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 11,11,740
	mullw 0,0,28
	la 3,.LC294@l(9)
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,1
	stwx 9,11,0
	bl FindItem
	subf 0,29,3
	lwz 11,84(31)
	mullw 0,0,28
	la 3,.LC293@l(27)
	b .L942
.L927:
	cmpwi 0,0,5
	bc 4,2,.L929
	lis 9,gi+8@ha
	lis 5,.LC295@ha
	lwz 0,gi+8@l(9)
	la 5,.LC295@l(5)
	li 4,2
	mr 3,31
	lis 27,.LC296@ha
	mtlr 0
	lis 28,0x38e3
	ori 28,28,36409
	crxor 6,6,6
	blrl
	la 3,.LC296@l(27)
	bl FindItem
	lis 29,itemlist@ha
	lwz 11,84(31)
	lis 9,.LC297@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 11,11,740
	mullw 0,0,28
	la 3,.LC297@l(9)
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,1
	stwx 9,11,0
	bl FindItem
	subf 0,29,3
	lwz 11,84(31)
	mullw 0,0,28
	la 3,.LC296@l(27)
	addi 11,11,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,100
	b .L941
.L929:
	cmpwi 0,0,6
	bc 4,2,.L931
	lis 9,gi+8@ha
	lis 5,.LC298@ha
	lwz 0,gi+8@l(9)
	la 5,.LC298@l(5)
	li 4,2
	mr 3,31
	lis 27,.LC299@ha
	mtlr 0
	lis 28,0x38e3
	ori 28,28,36409
	crxor 6,6,6
	blrl
	la 3,.LC299@l(27)
	bl FindItem
	lis 29,itemlist@ha
	lwz 11,84(31)
	lis 9,.LC300@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 11,11,740
	mullw 0,0,28
	la 3,.LC300@l(9)
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,1
	stwx 9,11,0
	bl FindItem
	subf 0,29,3
	lwz 11,84(31)
	mullw 0,0,28
	la 3,.LC299@l(27)
	addi 11,11,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,20
	b .L941
.L931:
	cmpwi 0,0,7
	bc 4,2,.L933
	lis 9,gi+8@ha
	lis 5,.LC301@ha
	lwz 0,gi+8@l(9)
	la 5,.LC301@l(5)
	li 4,2
	mr 3,31
	lis 27,.LC302@ha
	mtlr 0
	lis 28,0x38e3
	ori 28,28,36409
	crxor 6,6,6
	blrl
	la 3,.LC302@l(27)
	bl FindItem
	lis 29,itemlist@ha
	lwz 11,84(31)
	lis 9,.LC294@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 11,11,740
	mullw 0,0,28
	la 3,.LC294@l(9)
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,1
	stwx 9,11,0
	bl FindItem
	subf 0,29,3
	lwz 11,84(31)
	mullw 0,0,28
	la 3,.LC302@l(27)
.L942:
	addi 11,11,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,50
.L941:
	stwx 9,11,0
	bl FindItem
	lwz 9,84(31)
	stw 3,3588(9)
	mr 3,31
	bl ChangeWeapon
	lis 9,.LC291@ha
	la 28,.LC291@l(9)
	b .L920
.L933:
	bc 4,1,.L920
	lis 9,gi@ha
	lis 5,.LC303@ha
	la 9,gi@l(9)
	la 5,.LC303@l(5)
	lwz 0,8(9)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl ArmorIndex
	lis 9,body_armor_index@ha
	lwz 0,body_armor_index@l(9)
	cmpw 0,3,0
	bc 12,2,.L936
	mr 3,31
	bl ArmorIndex
	lwz 9,84(31)
	slwi 3,3,2
	li 0,0
	addi 9,9,740
	stwx 0,9,3
.L936:
	lis 30,.LC10@ha
	lis 28,0x38e3
	la 3,.LC10@l(30)
	ori 28,28,36409
	bl FindItem
	lis 9,itemlist@ha
	lwz 11,84(31)
	la 27,itemlist@l(9)
	subf 0,27,3
	addi 11,11,740
	mullw 0,0,28
	la 3,.LC10@l(30)
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,100
	stwx 9,11,0
	lwz 29,84(31)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,28
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,200
	bc 4,1,.L937
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,13
	bc 12,2,.L937
	la 3,.LC10@l(30)
	bl FindItem
	subf 3,27,3
	lwz 9,84(31)
	li 0,200
	mullw 3,3,28
	addi 9,9,740
	srawi 3,3,3
	slwi 3,3,2
	stwx 0,9,3
.L937:
	lis 9,.LC304@ha
	la 28,.LC304@l(9)
.L920:
	mr 3,31
	bl BoundAmmo
	lwz 0,480(31)
	lwz 11,484(31)
	cmpw 0,0,11
	bc 4,1,.L938
	cmpwi 0,0,200
	bc 4,1,.L938
	cmpwi 7,11,199
	mfcr 0
	rlwinm 0,0,30,1
	neg 0,0
	nor 9,0,0
	and 0,11,0
	andi. 9,9,200
	or 0,0,9
	stw 0,480(31)
.L938:
	lis 29,gi@ha
	mr 3,28
	la 29,gi@l(29)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC305@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC305@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC305@ha
	la 9,.LC305@l(9)
	lfs 2,0(9)
	lis 9,.LC306@ha
	la 9,.LC306@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 give_random,.Lfe33-give_random
	.section	".rodata"
	.align 2
.LC308:
	.string	"shells"
	.align 2
.LC309:
	.string	"grenades"
	.align 3
.LC307:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC310:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC311:
	.long 0x43480000
	.align 2
.LC312:
	.long 0x43160000
	.align 3
.LC313:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC314:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl weird_think
	.type	 weird_think,@function
weird_think:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 24,24(1)
	stw 0,68(1)
	lis 9,level@ha
	mr 27,3
	la 31,level@l(9)
	lfs 13,592(27)
	lfs 0,4(31)
	fcmpu 0,13,0
	bc 4,0,.L944
	lwz 3,560(27)
	cmpwi 0,3,0
	bc 12,2,.L945
	bl G_FreeEdict
.L945:
	mr 3,27
	bl G_FreeEdict
	b .L943
.L944:
	lwz 9,56(27)
	addi 9,9,1
	cmpwi 0,9,31
	stw 9,56(27)
	bc 4,1,.L946
	li 0,0
	stw 0,56(27)
.L946:
	lwz 0,644(27)
	cmpwi 0,0,0
	bc 4,2,.L947
	lis 9,g_edicts@ha
	addi 0,27,4
	lwz 3,g_edicts@l(9)
	mr 4,0
	mr 25,0
	lis 9,.LC311@ha
	lis 24,g_edicts@ha
	la 9,.LC311@l(9)
	lfs 1,0(9)
	bl findradius
	mr. 29,3
	bc 12,2,.L956
.L950:
	cmpw 7,29,27
	lwz 0,g_edicts@l(24)
	xor 0,29,0
	subfic 9,0,0
	adde 0,9,0
	mfcr 9
	rlwinm 9,9,31,1
	or. 11,0,9
	bc 4,2,.L952
	bc 12,30,.L952
	lwz 0,256(27)
	cmpw 0,29,0
	mr 4,0
	bc 12,2,.L952
	lwz 0,512(29)
	cmpwi 0,0,0
	bc 4,2,.L953
	lwz 0,260(29)
	cmpwi 0,0,9
	bc 12,2,.L953
	cmpwi 0,0,8
	bc 4,2,.L952
.L953:
	lwz 0,g_edicts@l(24)
	cmpw 0,29,0
	bc 12,2,.L952
	lwz 0,248(29)
	cmpwi 0,0,3
	bc 12,2,.L952
	lwz 0,264(29)
	andi. 9,0,8192
	bc 4,2,.L952
	mr 3,29
	bl CTFSameTeam
	mr. 31,3
	bc 4,2,.L952
	lfs 0,4(27)
	addi 3,1,8
	lfs 13,4(29)
	mr 4,3
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(29)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(29)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorNormalize2
	lwz 0,552(29)
	cmpwi 0,0,0
	bc 12,2,.L954
	stw 31,552(29)
.L954:
	lis 9,.LC312@ha
	addi 3,29,376
	la 9,.LC312@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
.L952:
	lis 9,.LC311@ha
	mr 3,29
	la 9,.LC311@l(9)
	mr 4,25
	lfs 1,0(9)
	bl findradius
	mr 29,3
	cmpwi 0,29,0
	bc 4,2,.L950
	b .L956
.L947:
	cmpwi 0,0,1
	bc 4,2,.L957
	lis 9,g_edicts@ha
	addi 0,27,4
	lwz 3,g_edicts@l(9)
	mr 4,0
	mr 25,0
	lis 9,.LC311@ha
	lis 24,g_edicts@ha
	la 9,.LC311@l(9)
	lfs 1,0(9)
	bl findradius
	mr. 29,3
	bc 12,2,.L956
	lis 9,.LC307@ha
	lfd 31,.LC307@l(9)
.L960:
	lwz 0,g_edicts@l(24)
	xor 9,29,27
	subfic 11,9,0
	adde 9,11,9
	xor 0,29,0
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L961
	lis 9,.LC311@ha
	mr 3,29
	la 9,.LC311@l(9)
	mr 4,25
	lfs 1,0(9)
	b .L983
.L961:
	xor 0,29,27
	lwz 10,84(29)
	addic 9,0,-1
	subfe 11,9,0
	addic 0,10,-1
	subfe 9,0,10
	and. 0,9,11
	bc 12,2,.L962
	lwz 0,256(27)
	cmpw 0,29,0
	mr 4,0
	bc 12,2,.L962
	lwz 0,512(29)
	cmpwi 0,0,0
	bc 4,2,.L963
	lwz 0,260(29)
	cmpwi 0,0,9
	bc 12,2,.L963
	cmpwi 0,0,8
	bc 4,2,.L962
.L963:
	lwz 0,g_edicts@l(24)
	cmpw 0,29,0
	bc 12,2,.L962
	lwz 0,248(29)
	cmpwi 0,0,3
	bc 12,2,.L962
	lwz 0,264(29)
	andi. 9,0,8192
	bc 4,2,.L962
	mr 3,29
	bl CTFSameTeam
	cmpwi 0,3,0
	bc 4,2,.L962
	lfs 0,916(29)
	lfs 13,4(31)
	fcmpu 0,0,13
	bc 4,0,.L964
	lis 9,.LC313@ha
	fmr 0,13
	la 9,.LC313@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,916(29)
.L964:
	lfs 0,916(29)
	fadd 0,0,31
	frsp 0,0
	stfs 0,916(29)
.L962:
	lis 11,.LC311@ha
	mr 3,29
	la 11,.LC311@l(11)
	mr 4,25
	lfs 1,0(11)
.L983:
	bl findradius
	mr 29,3
	cmpwi 0,29,0
	bc 4,2,.L960
	b .L956
.L957:
	cmpwi 0,0,2
	bc 4,2,.L967
	lis 9,.LC314@ha
	lis 11,.LC311@ha
	lwz 4,256(27)
	la 9,.LC314@l(9)
	la 11,.LC311@l(11)
	lfs 1,0(9)
	mr 3,27
	li 6,128
	lfs 2,0(11)
	li 7,41
	mr 5,4
	bl T_RadiusDamage
	b .L956
.L967:
	cmpwi 0,0,3
	bc 4,2,.L956
	lis 9,g_edicts@ha
	addi 0,27,4
	lwz 3,g_edicts@l(9)
	mr 4,0
	mr 25,0
	lis 9,.LC311@ha
	lis 24,g_edicts@ha
	la 9,.LC311@l(9)
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 12,2,.L956
.L972:
	lwz 0,g_edicts@l(24)
	xor 9,31,27
	subfic 11,9,0
	adde 9,11,9
	xor 0,31,0
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L974
	xor 0,31,27
	lwz 10,84(31)
	addic 9,0,-1
	subfe 11,9,0
	addic 0,10,-1
	subfe 9,0,10
	and. 0,9,11
	bc 12,2,.L974
	lwz 0,256(27)
	cmpw 0,31,0
	mr 4,0
	bc 12,2,.L974
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 4,2,.L975
	lwz 0,260(31)
	cmpwi 0,0,9
	bc 12,2,.L975
	cmpwi 0,0,8
	bc 4,2,.L974
.L975:
	lwz 0,g_edicts@l(24)
	cmpw 0,31,0
	bc 12,2,.L974
	lwz 0,248(31)
	cmpwi 0,0,3
	bc 12,2,.L974
	lwz 0,264(31)
	andi. 9,0,8192
	bc 4,2,.L974
	mr 3,31
	bl CTFSameTeam
	cmpwi 0,3,0
	bc 4,2,.L974
	lis 28,.LC297@ha
	lwz 29,84(31)
	lis 30,0x38e3
	la 3,.LC297@l(28)
	ori 30,30,36409
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,1,.L976
	la 3,.LC297@l(28)
	bl FindItem
	lwz 9,256(27)
	subf 0,26,3
	mullw 0,0,30
	la 3,.LC297@l(28)
	lwz 11,84(9)
	srawi 0,0,3
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,1
	stwx 9,11,0
	bl FindItem
	subf 3,26,3
	lwz 11,84(31)
	mullw 3,3,30
	addi 11,11,740
	srawi 3,3,3
	slwi 3,3,2
	lwzx 9,11,3
	addi 9,9,-1
	stwx 9,11,3
.L976:
	lis 28,.LC300@ha
	lwz 29,84(31)
	la 3,.LC300@l(28)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,1,.L977
	la 3,.LC300@l(28)
	bl FindItem
	lwz 9,256(27)
	subf 0,26,3
	mullw 0,0,30
	la 3,.LC300@l(28)
	lwz 11,84(9)
	srawi 0,0,3
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,1
	stwx 9,11,0
	bl FindItem
	subf 3,26,3
	lwz 11,84(31)
	mullw 3,3,30
	addi 11,11,740
	srawi 3,3,3
	slwi 3,3,2
	lwzx 9,11,3
	addi 9,9,-1
	stwx 9,11,3
.L977:
	lis 28,.LC308@ha
	lwz 29,84(31)
	la 3,.LC308@l(28)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,1,.L978
	la 3,.LC308@l(28)
	bl FindItem
	lwz 9,256(27)
	subf 0,26,3
	mullw 0,0,30
	la 3,.LC308@l(28)
	lwz 11,84(9)
	srawi 0,0,3
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,1
	stwx 9,11,0
	bl FindItem
	subf 3,26,3
	lwz 11,84(31)
	mullw 3,3,30
	addi 11,11,740
	srawi 3,3,3
	slwi 3,3,2
	lwzx 9,11,3
	addi 9,9,-1
	stwx 9,11,3
.L978:
	lis 28,.LC294@ha
	lwz 29,84(31)
	la 3,.LC294@l(28)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,1,.L979
	la 3,.LC294@l(28)
	bl FindItem
	lwz 9,256(27)
	subf 0,26,3
	mullw 0,0,30
	la 3,.LC294@l(28)
	lwz 11,84(9)
	srawi 0,0,3
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,1
	stwx 9,11,0
	bl FindItem
	subf 3,26,3
	lwz 11,84(31)
	mullw 3,3,30
	addi 11,11,740
	srawi 3,3,3
	slwi 3,3,2
	lwzx 9,11,3
	addi 9,9,-1
	stwx 9,11,3
.L979:
	lis 28,.LC309@ha
	lwz 29,84(31)
	la 3,.LC309@l(28)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,1,.L980
	la 3,.LC309@l(28)
	bl FindItem
	lwz 9,256(27)
	subf 0,26,3
	mullw 0,0,30
	la 3,.LC309@l(28)
	lwz 11,84(9)
	srawi 0,0,3
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,1
	stwx 9,11,0
	bl FindItem
	subf 3,26,3
	lwz 11,84(31)
	mullw 3,3,30
	addi 11,11,740
	srawi 3,3,3
	slwi 3,3,2
	lwzx 9,11,3
	addi 9,9,-1
	stwx 9,11,3
.L980:
	lis 28,.LC290@ha
	lwz 29,84(31)
	la 3,.LC290@l(28)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,1,.L981
	la 3,.LC290@l(28)
	bl FindItem
	lwz 9,256(27)
	subf 0,26,3
	mullw 0,0,30
	la 3,.LC290@l(28)
	lwz 11,84(9)
	srawi 0,0,3
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,1
	stwx 9,11,0
	bl FindItem
	subf 3,26,3
	lwz 11,84(31)
	mullw 3,3,30
	addi 11,11,740
	srawi 3,3,3
	slwi 3,3,2
	lwzx 9,11,3
	addi 9,9,-1
	stwx 9,11,3
.L981:
	lwz 3,256(27)
	bl BoundAmmo
.L974:
	lis 9,.LC311@ha
	mr 3,31
	la 9,.LC311@l(9)
	mr 4,25
	lfs 1,0(9)
	bl findradius
	mr 31,3
	cmpwi 0,31,0
	bc 4,2,.L972
.L956:
	lis 9,level+4@ha
	lis 11,.LC310@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC310@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(27)
.L943:
	lwz 0,68(1)
	mtlr 0
	lmw 24,24(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe34:
	.size	 weird_think,.Lfe34-weird_think
	.section	".rodata"
	.align 2
.LC315:
	.string	"No active power!\n"
	.align 2
.LC316:
	.string	"misc/power1.wav"
	.align 2
.LC317:
	.string	"player"
	.align 2
.LC318:
	.string	"misc/tele1.wav"
	.align 2
.LC319:
	.string	"powers/taft.wav"
	.align 2
.LC320:
	.string	"powers/flare.wav"
	.align 2
.LC322:
	.string	"Death Blow deactivated\n"
	.align 2
.LC323:
	.string	"powers/deathblow2.wav"
	.align 2
.LC324:
	.string	"Death Blow activated\n"
	.align 2
.LC325:
	.string	"powers/deathblow.wav"
	.align 2
.LC326:
	.string	"Beacon occupied!\n"
	.align 2
.LC327:
	.string	"Beacon removed\n"
	.align 2
.LC328:
	.string	"Beacon set\n"
	.align 2
.LC329:
	.string	"misc/spawn1.wav"
	.align 2
.LC331:
	.string	"powers/banshee.wav"
	.align 2
.LC333:
	.string	"powers/reversegrav.wav"
	.align 2
.LC334:
	.string	"powers/psionic.wav"
	.align 2
.LC336:
	.string	"models/super2/claw/tris.md2"
	.align 2
.LC337:
	.string	"grapple"
	.align 2
.LC338:
	.string	"misc/ar2_pkup.wav"
	.align 2
.LC339:
	.string	"powers/bionicfire.wav"
	.align 2
.LC341:
	.string	"powers/blackhole.wav"
	.align 2
.LC343:
	.string	"powers/blind.wav"
	.align 2
.LC344:
	.string	"models/super2/weird/tris.md2"
	.align 2
.LC345:
	.string	"Repulsion\n"
	.align 2
.LC346:
	.string	"Hallucinogen\n"
	.align 2
.LC347:
	.string	"Radioactive\n"
	.align 2
.LC348:
	.string	"Ammo Vacuum\n"
	.align 2
.LC349:
	.string	"NO ACTIVE POWER %i\n"
	.align 2
.LC321:
	.long 0x3e4ccccd
	.align 3
.LC330:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC332:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC335:
	.long 0x3fe33333
	.long 0x33333333
	.align 2
.LC340:
	.long 0x44a28000
	.align 3
.LC342:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC350:
	.long 0x3f800000
	.align 2
.LC351:
	.long 0x0
	.align 3
.LC352:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC353:
	.long 0x41100000
	.align 2
.LC354:
	.long 0xc3160000
	.align 2
.LC355:
	.long 0x42480000
	.align 2
.LC356:
	.long 0x43160000
	.align 2
.LC357:
	.long 0x41c80000
	.align 2
.LC358:
	.long 0x47800000
	.align 2
.LC359:
	.long 0x43b40000
	.align 2
.LC360:
	.long 0x40a00000
	.align 2
.LC361:
	.long 0x41200000
	.align 2
.LC362:
	.long 0x41700000
	.align 2
.LC363:
	.long 0x43fa0000
	.align 2
.LC364:
	.long 0x43480000
	.align 2
.LC365:
	.long 0xc47a0000
	.align 3
.LC366:
	.long 0x3ff80000
	.long 0x0
	.align 2
.LC367:
	.long 0x40400000
	.align 2
.LC368:
	.long 0x42200000
	.align 2
.LC369:
	.long 0x447a0000
	.align 2
.LC370:
	.long 0x41000000
	.align 3
.LC371:
	.long 0x400c0000
	.long 0x0
	.align 2
.LC372:
	.long 0x40000000
	.align 2
.LC373:
	.long 0xc0000000
	.align 2
.LC374:
	.long 0x40200000
	.align 3
.LC375:
	.long 0x40040000
	.long 0x0
	.align 2
.LC376:
	.long 0x40800000
	.align 2
.LC377:
	.long 0x44fa0000
	.align 2
.LC378:
	.long 0x42960000
	.align 2
.LC379:
	.long 0x42a00000
	.align 2
.LC380:
	.long 0x40e00000
	.align 3
.LC381:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC382:
	.long 0x430c0000
	.align 2
.LC383:
	.long 0x40c00000
	.section	".text"
	.align 2
	.globl CallActive
	.type	 CallActive,@function
CallActive:
	stwu 1,-512(1)
	mflr 0
	stfd 29,488(1)
	stfd 30,496(1)
	stfd 31,504(1)
	stmw 22,448(1)
	stw 0,516(1)
	mr 31,3
	li 22,0
	lwz 0,264(31)
	lwz 3,84(31)
	andis. 8,0,64
	lwz 27,1804(3)
	bc 4,2,.L984
	lis 9,level@ha
	lfs 13,896(31)
	la 26,level@l(9)
	lfs 0,4(26)
	fcmpu 0,13,0
	bc 12,1,.L984
	lwz 0,0(3)
	cmpwi 0,0,4
	bc 12,2,.L984
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L984
	addi 29,1,40
	addi 28,1,24
	addi 4,1,8
	mr 5,28
	mr 6,29
	addi 3,3,3692
	bl AngleVectors
	mr 25,29
	addi 3,1,8
	mr 4,3
	bl VectorNormalize2
	mr 3,28
	mr 4,3
	bl VectorNormalize2
	mr 3,29
	mr 4,29
	bl VectorNormalize2
	lwz 0,264(31)
	andi. 8,0,8192
	bc 12,2,.L989
	mr 3,31
	bl relocate
	lis 8,.LC350@ha
	lfs 0,4(26)
	la 8,.LC350@l(8)
	lwz 9,84(31)
	lfs 13,0(8)
	fadds 0,0,13
	stfs 0,1828(9)
	b .L984
.L989:
	cmpwi 0,27,0
	bc 4,2,.L990
	lis 9,gi+8@ha
	lis 5,.LC315@ha
	lwz 0,gi+8@l(9)
	la 5,.LC315@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L991
.L990:
	cmpwi 0,27,-4
	bc 4,2,.L992
	oris 0,0,0x1
	lis 8,.LC350@ha
	lwz 9,84(31)
	stw 0,264(31)
	la 8,.LC350@l(8)
	lfs 0,4(26)
	b .L1138
.L992:
	cmpwi 0,27,-3
	bc 4,2,.L994
	lis 29,gi@ha
	lis 3,.LC316@ha
	la 29,gi@l(29)
	la 3,.LC316@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC350@ha
	lis 9,.LC350@ha
	lis 10,.LC351@ha
	la 8,.LC350@l(8)
	la 9,.LC350@l(9)
	la 10,.LC351@l(10)
	lfs 1,0(8)
	mtlr 0
	mr 5,3
	lfs 2,0(9)
	li 4,3
	lfs 3,0(10)
	mr 3,31
	blrl
	lis 9,level@ha
	lwz 11,level@l(9)
	lis 0,0x4330
	lis 8,.LC352@ha
	la 8,.LC352@l(8)
	lwz 9,84(31)
	addi 11,11,40
	lfd 13,0(8)
	xoris 11,11,0x8000
	lis 8,.LC353@ha
	stw 11,444(1)
	la 8,.LC353@l(8)
	stw 0,440(1)
	lfd 0,440(1)
	lfs 12,0(8)
	fsub 0,0,13
	frsp 0,0
	stfs 0,3768(9)
	lfs 13,4(26)
	lwz 9,84(31)
	fadds 13,13,12
	stfs 13,1828(9)
	b .L991
.L994:
	cmpwi 0,27,-2
	bc 4,2,.L996
	lis 9,g_edicts@ha
	lis 5,.LC317@ha
	lwz 3,g_edicts@l(9)
	la 5,.LC317@l(5)
	li 4,280
	mr 26,31
	lis 23,.LC317@ha
	bl G_Find
	mr. 28,3
	bc 12,2,.L998
	lis 9,v_forward@ha
	lis 11,gi@ha
	la 24,v_forward@l(9)
	la 30,gi@l(11)
.L999:
	cmpw 0,28,31
	bc 12,2,.L1000
	lwz 0,264(28)
	andi. 8,0,8192
	bc 4,2,.L1000
	mr 3,31
	mr 4,28
	bl OnSameTeam
	cmpwi 0,3,0
	bc 4,2,.L1000
	lfs 12,4(31)
	addi 25,1,136
	addi 27,1,120
	lfs 13,4(28)
	mr 3,25
	lfs 11,8(31)
	lfs 10,12(31)
	fsubs 13,12,13
	stfs 13,136(1)
	lfs 0,8(28)
	fsubs 0,11,0
	stfs 0,140(1)
	lfs 13,12(28)
	fsubs 13,10,13
	stfs 13,144(1)
	lfs 0,4(26)
	fsubs 12,12,0
	stfs 12,120(1)
	lfs 0,8(26)
	fsubs 11,11,0
	stfs 11,124(1)
	lfs 0,12(26)
	fsubs 10,10,0
	stfs 10,128(1)
	bl VectorLength
	fmr 31,1
	mr 3,27
	bl VectorLength
	fcmpu 0,31,1
	bc 12,0,.L1002
	cmpw 0,26,31
	bc 4,2,.L1000
.L1002:
	mr 3,28
	addi 29,28,4
	bl MV
	lis 8,.LC354@ha
	li 0,0
	la 8,.LC354@l(8)
	stw 0,8(24)
	mr 3,29
	lfs 1,0(8)
	mr 4,24
	mr 5,27
	bl VectorMA
	lwz 11,48(30)
	lis 9,0x600
	addi 3,1,56
	mr 8,28
	mr 4,29
	mr 7,27
	li 5,0
	mtlr 11
	li 6,0
	ori 9,9,3
	blrl
	lfs 0,4(28)
	mr 3,25
	lfs 13,68(1)
	lfs 12,72(1)
	lfs 11,76(1)
	fsubs 13,13,0
	stfs 13,136(1)
	lfs 0,8(28)
	fsubs 12,12,0
	stfs 12,140(1)
	lfs 0,12(28)
	fsubs 11,11,0
	stfs 11,144(1)
	bl VectorLength
	lis 8,.LC355@ha
	la 8,.LC355@l(8)
	lfs 0,0(8)
	fcmpu 0,1,0
	bc 4,1,.L1000
	mr 26,28
.L1000:
	mr 3,28
	li 4,280
	la 5,.LC317@l(23)
	bl G_Find
	mr. 28,3
	bc 4,2,.L999
.L998:
	cmpwi 0,26,0
	bc 12,2,.L984
	lwz 0,264(26)
	xor 9,26,31
	subfic 8,9,0
	adde 9,8,9
	rlwinm 0,0,19,31,31
	or. 10,0,9
	bc 4,2,.L984
	mr 3,26
	bl MV
	lis 9,v_forward@ha
	li 0,0
	la 27,v_forward@l(9)
	stw 0,8(27)
	bl rand
	lis 0,0x6666
	srawi 9,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,2
	subf 0,9,0
	mulli 0,0,10
	cmpw 0,3,0
	bc 4,2,.L1007
	lis 8,.LC356@ha
	addi 28,1,120
	la 8,.LC356@l(8)
	b .L1139
.L1007:
	lis 8,.LC354@ha
	addi 28,1,120
	la 8,.LC354@l(8)
.L1139:
	addi 29,26,4
	lfs 1,0(8)
	mr 4,27
	mr 3,29
	mr 5,28
	mr 25,29
	bl VectorMA
	mr 7,28
	lis 11,gi@ha
	lis 9,0x600
	la 27,gi@l(11)
	addi 3,1,56
	lwz 11,48(27)
	mr 8,26
	mr 4,25
	li 5,0
	li 6,0
	ori 9,9,3
	mtlr 11
	addi 28,1,136
	blrl
	lfs 13,4(26)
	mr 3,28
	lfs 0,68(1)
	lfs 12,72(1)
	lfs 11,76(1)
	fsubs 0,0,13
	stfs 0,136(1)
	lfs 13,8(26)
	fsubs 12,12,13
	stfs 12,140(1)
	lfs 0,12(26)
	fsubs 11,11,0
	stfs 11,144(1)
	bl VectorLength
	lis 8,.LC355@ha
	fmr 31,1
	la 8,.LC355@l(8)
	lfs 0,0(8)
	fcmpu 0,31,0
	bc 4,1,.L991
	lwz 0,264(31)
	andis. 9,0,4096
	bc 4,2,.L984
	mr 3,31
	addi 29,31,4
	bl CTFDrop_Flag
	lis 8,.LC357@ha
	mr 3,28
	la 8,.LC357@l(8)
	mr 4,28
	lfs 0,0(8)
	fsubs 31,31,0
	bl VectorNormalize2
	mr 4,28
	mr 3,28
	fmr 1,31
	bl VectorScale
	lwz 9,100(27)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(27)
	li 3,20
	mtlr 9
	blrl
	lwz 9,120(27)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,88(27)
	li 4,2
	mr 3,29
	mtlr 9
	blrl
	lwz 9,36(27)
	lis 3,.LC318@ha
	la 3,.LC318@l(3)
	mtlr 9
	blrl
	lwz 0,16(27)
	lis 8,.LC350@ha
	lis 9,.LC350@ha
	lis 10,.LC351@ha
	la 9,.LC350@l(9)
	mr 5,3
	la 8,.LC350@l(8)
	lfs 2,0(9)
	mtlr 0
	la 10,.LC351@l(10)
	lfs 1,0(8)
	li 4,0
	mr 3,31
	lfs 3,0(10)
	blrl
	lis 8,.LC350@ha
	mr 3,25
	la 8,.LC350@l(8)
	mr 4,28
	lfs 1,0(8)
	mr 5,29
	bl VectorMA
	lis 8,.LC358@ha
	lis 9,.LC359@ha
	la 8,.LC358@l(8)
	la 9,.LC359@l(9)
	lfs 10,0(8)
	addi 3,26,16
	li 7,0
	lfs 11,0(9)
	li 6,0
.L1014:
	lwz 10,84(31)
	add 0,7,7
	lfsx 0,6,3
	addi 7,7,1
	addi 9,10,3500
	cmpwi 0,7,1
	lfsx 12,9,6
	addi 10,10,20
	addi 6,6,4
	fsubs 0,0,12
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 13,0
	stfd 13,440(1)
	lwz 11,444(1)
	sthx 11,10,0
	bc 4,1,.L1014
	lwz 11,84(31)
	li 0,0
	lis 10,gi+72@ha
	stw 0,20(31)
	mr 3,31
	stw 0,24(31)
	stw 0,16(31)
	stw 0,28(11)
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,32(9)
	lfs 0,24(31)
	lwz 11,84(31)
	stfs 0,36(11)
	lfs 0,16(31)
	lwz 9,84(31)
	stfs 0,3692(9)
	lfs 0,20(31)
	lwz 11,84(31)
	stfs 0,3696(11)
	lfs 0,24(31)
	lwz 9,84(31)
	stfs 0,3700(9)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lis 8,.LC360@ha
	lis 9,level+4@ha
	lwz 11,84(31)
	la 8,.LC360@l(8)
	lfs 0,level+4@l(9)
	lfs 13,0(8)
	fadds 0,0,13
	stfs 0,1828(11)
	b .L984
.L996:
	cmpwi 0,27,-5
	bc 4,2,.L1017
	mr 3,31
	bl give_random
	lis 8,.LC361@ha
	lfs 0,4(26)
	la 8,.LC361@l(8)
	b .L1140
.L1017:
	cmpwi 0,27,-6
	bc 4,2,.L1019
	andis. 9,0,4096
	bc 4,2,.L984
	mr 3,31
	bl CTFDrop_Flag
	mr 3,31
	bl ArmorIndex
	lwz 11,84(31)
	slwi 29,3,2
	lis 9,.LC352@ha
	la 9,.LC352@l(9)
	addi 11,11,740
	lfd 0,0(9)
	lis 8,0x4330
	lwzx 0,11,29
	srwi 9,0,31
	add 0,0,9
	srawi 0,0,1
	xoris 0,0,0x8000
	stw 0,444(1)
	stw 8,440(1)
	lfd 1,440(1)
	fsub 1,1,0
	bl ceil
	fctiwz 0,1
	lwz 11,84(31)
	mr 3,31
	addi 11,11,740
	stfd 0,440(1)
	lwz 9,444(1)
	stwx 9,11,29
	bl make_tele
	mr 3,31
	bl relocate
	mr 3,31
	bl make_tele
	lis 8,.LC362@ha
	lfs 0,4(26)
	la 8,.LC362@l(8)
.L1140:
	lwz 9,84(31)
.L1138:
	lfs 13,0(8)
	fadds 0,0,13
	stfs 0,1828(9)
	b .L991
.L1019:
	cmpwi 0,27,-7
	bc 4,2,.L1022
	lis 9,g_edicts@ha
	addi 0,31,4
	lwz 3,g_edicts@l(9)
	mr 4,0
	mr 27,0
	lis 9,.LC363@ha
	la 9,.LC363@l(9)
	lfs 1,0(9)
	bl findradius
	mr. 29,3
	bc 12,2,.L1024
	lis 8,.LC364@ha
	addi 28,1,56
	la 8,.LC364@l(8)
	li 26,0
	lfs 31,0(8)
.L1025:
	lwz 10,84(29)
	cmpwi 0,10,0
	bc 12,2,.L1028
	lwz 0,264(29)
	xor 9,29,31
	addic 8,9,-1
	subfe 11,8,9
	xori 0,0,8192
	rlwinm 0,0,19,31,31
	and. 9,0,11
	bc 12,2,.L1028
	lwz 0,1808(10)
	cmpwi 0,0,8
	bc 12,2,.L1028
	mr 3,31
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L1027
.L1028:
	lwz 0,184(29)
	andi. 8,0,4
	bc 12,2,.L1026
.L1027:
	lfs 0,4(29)
	mr 3,28
	mr 4,28
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,56(1)
	lfs 0,8(29)
	fsubs 12,12,0
	stfs 12,60(1)
	lfs 0,12(29)
	fsubs 11,11,0
	stfs 11,64(1)
	bl VectorNormalize2
	lis 8,.LC365@ha
	mr 3,28
	la 8,.LC365@l(8)
	mr 4,28
	lfs 1,0(8)
	bl VectorScale
	lfs 0,64(1)
	lfs 13,56(1)
	fadds 0,0,31
	stfs 0,64(1)
	stfs 13,376(29)
	lfs 0,60(1)
	stfs 0,380(29)
	lfs 13,64(1)
	stw 26,552(29)
	stfs 13,384(29)
.L1026:
	lis 8,.LC363@ha
	mr 3,29
	la 8,.LC363@l(8)
	mr 4,27
	lfs 1,0(8)
	bl findradius
	mr. 29,3
	bc 4,2,.L1025
.L1024:
	lis 29,gi@ha
	lis 3,.LC319@ha
	la 29,gi@l(29)
	la 3,.LC319@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC350@ha
	lis 9,.LC350@ha
	lis 10,.LC351@ha
	la 8,.LC350@l(8)
	la 9,.LC350@l(9)
	mr 5,3
	lfs 1,0(8)
	mtlr 0
	la 10,.LC351@l(10)
	lfs 2,0(9)
	li 4,0
	mr 3,31
	lfs 3,0(10)
	blrl
	lis 8,.LC360@ha
	lis 9,level+4@ha
	lwz 11,84(31)
	la 8,.LC360@l(8)
	b .L1141
.L1022:
	cmpwi 0,27,-8
	bc 4,2,.L1031
	mr 3,31
	bl kin_throw
	cmpwi 0,3,1
	bc 4,2,.L991
	lfs 0,4(26)
	lis 8,.LC366@ha
	li 22,1
	la 8,.LC366@l(8)
	lwz 9,84(31)
	lfd 13,0(8)
	b .L1142
.L1031:
	cmpwi 0,27,-10
	bc 4,2,.L1034
	lis 9,g_edicts@ha
	addi 0,31,4
	lwz 3,g_edicts@l(9)
	mr 4,0
	mr 27,0
	lis 9,.LC363@ha
	la 9,.LC363@l(9)
	lfs 1,0(9)
	bl findradius
	mr. 29,3
	bc 12,2,.L1036
	lis 8,.LC367@ha
	mr 28,26
	la 8,.LC367@l(8)
	lfs 31,0(8)
.L1037:
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L1040
	lwz 0,264(29)
	xor 9,29,31
	addic 10,9,-1
	subfe 11,10,9
	xori 0,0,8192
	rlwinm 0,0,19,31,31
	and. 8,0,11
	bc 12,2,.L1040
	mr 3,31
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L1039
.L1040:
	lwz 0,184(29)
	andi. 8,0,4
	bc 12,2,.L1038
.L1039:
	lfs 0,4(28)
	fadds 0,0,31
	stfs 0,912(29)
.L1038:
	lis 9,.LC363@ha
	mr 3,29
	la 9,.LC363@l(9)
	mr 4,27
	lfs 1,0(9)
	bl findradius
	mr. 29,3
	bc 4,2,.L1037
.L1036:
	lis 8,.LC368@ha
	lis 9,.LC369@ha
	la 8,.LC368@l(8)
	la 9,.LC369@l(9)
	lfs 1,0(8)
	mr 4,31
	mr 5,31
	lfs 2,0(9)
	li 6,128
	li 7,54
	mr 3,31
	li 22,1
	bl T_RadiusDamage
	lis 29,gi@ha
	lis 3,.LC320@ha
	la 29,gi@l(29)
	la 3,.LC320@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC350@ha
	lis 9,.LC350@ha
	lis 10,.LC351@ha
	la 8,.LC350@l(8)
	la 9,.LC350@l(9)
	mr 5,3
	lfs 1,0(8)
	mtlr 0
	la 10,.LC351@l(10)
	lfs 2,0(9)
	li 4,0
	mr 3,31
	lfs 3,0(10)
	blrl
	lis 8,.LC370@ha
	lis 9,level+4@ha
	lwz 11,84(31)
	la 8,.LC370@l(8)
	b .L1141
.L1034:
	cmpwi 0,27,6
	bc 4,2,.L1043
	lis 9,.LC362@ha
	addi 29,1,72
	la 9,.LC362@l(9)
	addi 3,1,8
	lfs 1,0(9)
	mr 4,29
	li 26,0
	li 24,0
	li 22,1
	bl VectorScale
	lis 9,.LC321@ha
	addi 28,1,8
	lfs 1,.LC321@l(9)
	mr 3,28
	mr 4,25
	mr 5,3
	li 25,160
	bl VectorMA
	lis 8,.LC350@ha
	mr 3,29
	la 8,.LC350@l(8)
	mr 5,3
	lfs 1,0(8)
	addi 4,31,4
	bl VectorMA
	lwz 9,508(31)
	lis 0,0x4330
	lis 8,.LC352@ha
	lfs 13,80(1)
	addi 9,9,-8
	la 8,.LC352@l(8)
	xoris 9,9,0x8000
	lfd 12,0(8)
	stw 9,444(1)
	stw 0,440(1)
	lfd 0,440(1)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,80(1)
	bl G_Spawn
	lfs 13,72(1)
	mr 29,3
	mr 3,28
	addi 4,29,16
	stfs 13,4(29)
	lfs 0,76(1)
	stfs 0,8(29)
	lfs 13,80(1)
	stfs 13,12(29)
	lfs 0,8(1)
	stfs 0,340(29)
	lfs 13,4(28)
	stfs 13,344(29)
	lfs 0,8(28)
	stfs 0,348(29)
	bl vectoangles
	lis 8,.LC369@ha
	mr 3,28
	la 8,.LC369@l(8)
	addi 4,29,376
	lfs 1,0(8)
	bl VectorScale
	lis 0,0x600
	lwz 8,64(29)
	lis 9,.LC180@ha
	ori 0,0,3
	li 11,9
	stw 26,196(29)
	stw 0,252(29)
	li 10,2
	la 9,.LC180@l(9)
	li 0,23
	ori 8,8,16
	stw 11,260(29)
	lis 27,gi@ha
	stw 10,248(29)
	lis 3,.LC227@ha
	la 27,gi@l(27)
	stw 0,644(29)
	la 3,.LC227@l(3)
	stw 8,64(29)
	stw 9,280(29)
	stw 26,192(29)
	stw 26,188(29)
	stw 26,208(29)
	stw 26,204(29)
	stw 26,200(29)
	lwz 9,32(27)
	mtlr 9
	blrl
	lis 9,fball_touch@ha
	lis 28,level@ha
	stw 3,40(29)
	la 9,fball_touch@l(9)
	lis 8,.LC360@ha
	stw 31,256(29)
	stw 9,444(29)
	la 8,.LC360@l(8)
	la 28,level@l(28)
	lfs 0,4(28)
	lis 9,G_FreeEdict@ha
	lis 3,.LC217@ha
	lfs 13,0(8)
	la 9,G_FreeEdict@l(9)
	la 3,.LC217@l(3)
	stw 9,436(29)
	stw 25,516(29)
	fadds 0,0,13
	stw 24,520(29)
	stw 26,524(29)
	stfs 0,428(29)
	lwz 9,36(27)
	mtlr 9
	blrl
	stw 3,76(29)
	lwz 0,72(27)
	mr 3,29
	mtlr 0
	blrl
	lfs 0,4(28)
	lis 8,.LC371@ha
	la 8,.LC371@l(8)
	lwz 9,84(31)
	lfd 13,0(8)
	b .L1142
.L1043:
	cmpwi 0,27,12
	bc 4,2,.L1046
	mr 3,31
	bl kin_throw
	cmpwi 0,3,1
	bc 4,2,.L991
	lis 8,.LC372@ha
	lis 9,level+4@ha
	lwz 11,84(31)
	la 8,.LC372@l(8)
	lfs 0,level+4@l(9)
	li 22,1
	b .L1143
.L1046:
	cmpwi 0,27,8
	bc 4,2,.L1049
	lwz 9,508(31)
	lis 10,0x4330
	lis 8,.LC352@ha
	lwz 3,84(31)
	addi 29,1,152
	addi 9,9,-8
	la 8,.LC352@l(8)
	xoris 9,9,0x8000
	lfd 13,0(8)
	addi 28,1,168
	stw 9,444(1)
	lis 0,0x4100
	addi 27,1,184
	stw 10,440(1)
	mr 4,29
	addi 3,3,3692
	lfd 0,440(1)
	mr 5,28
	li 6,0
	stw 0,92(1)
	addi 26,31,4
	li 22,1
	stw 0,88(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,96(1)
	bl AngleVectors
	lwz 3,84(31)
	addi 5,1,88
	mr 6,29
	mr 8,27
	mr 7,28
	mr 4,26
	bl P_ProjectSource
	lis 8,.LC373@ha
	lwz 4,84(31)
	mr 3,29
	la 8,.LC373@l(8)
	lfs 1,0(8)
	addi 4,4,3640
	bl VectorScale
	lwz 9,84(31)
	lis 0,0xbf80
	lis 8,.LC374@ha
	la 8,.LC374@l(8)
	mr 5,29
	stw 0,3628(9)
	li 6,120
	li 7,600
	lis 9,.LC356@ha
	lfs 1,0(8)
	mr 4,27
	la 9,.LC356@l(9)
	li 8,1
	b .L1144
.L1049:
	cmpwi 0,27,5
	bc 4,2,.L1051
	lwz 0,264(31)
	andi. 9,0,16384
	bc 12,2,.L1052
	rlwinm 0,0,0,18,16
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(31)
	lis 5,.LC322@ha
	lwz 9,8(29)
	la 5,.LC322@l(5)
	li 4,2
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC323@ha
	la 3,.LC323@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC350@ha
	lis 9,.LC350@ha
	lis 10,.LC351@ha
	mr 5,3
	la 8,.LC350@l(8)
	la 9,.LC350@l(9)
	mtlr 0
	la 10,.LC351@l(10)
	li 4,0
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	b .L1151
.L1052:
	ori 0,0,16384
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(31)
	lis 5,.LC324@ha
	lwz 9,8(29)
	la 5,.LC324@l(5)
	li 4,2
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC325@ha
	la 3,.LC325@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC350@ha
	lis 9,.LC350@ha
	lis 10,.LC351@ha
	mr 5,3
	la 8,.LC350@l(8)
	la 9,.LC350@l(9)
	mtlr 0
	la 10,.LC351@l(10)
	li 4,0
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L1145
.L1051:
	cmpwi 0,27,20
	bc 4,2,.L1055
	lwz 0,264(31)
	andis. 9,0,4096
	bc 4,2,.L984
	addi 28,1,264
	mr 3,31
	bl CTFDrop_Flag
	addi 27,31,4
	mr 3,31
	bl make_tele
	lis 8,.LC377@ha
	addi 4,1,8
	la 8,.LC377@l(8)
	mr 3,27
	lfs 1,0(8)
	mr 5,28
	bl VectorMA
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	addi 3,1,200
	ori 9,9,3
	mr 4,27
	li 5,0
	li 6,0
	mr 7,28
	mtlr 0
	mr 8,31
	blrl
	lfs 11,4(31)
	mr 3,28
	lfs 12,212(1)
	lfs 10,8(31)
	lfs 13,216(1)
	fsubs 12,12,11
	lfs 0,220(1)
	lfs 11,12(31)
	fsubs 13,13,10
	stfs 12,264(1)
	fsubs 0,0,11
	stfs 13,268(1)
	stfs 0,272(1)
	bl VectorLength
	fctiwz 0,1
	stfd 0,440(1)
	lwz 29,444(1)
	cmpwi 0,29,49
	bc 4,1,.L984
	mr 3,28
	mr 4,28
	bl VectorNormalize2
	addi 29,29,-25
	xoris 0,29,0x8000
	stw 0,444(1)
	lis 11,0x4330
	lis 8,.LC352@ha
	stw 11,440(1)
	la 8,.LC352@l(8)
	mr 3,28
	lfd 0,0(8)
	mr 4,28
	lfd 1,440(1)
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	lis 8,.LC350@ha
	mr 3,27
	la 8,.LC350@l(8)
	mr 5,3
	lfs 1,0(8)
	mr 4,28
	bl VectorMA
	mr 3,31
	bl make_tele
	lis 8,.LC372@ha
	lis 9,level+4@ha
	lwz 11,84(31)
	la 8,.LC372@l(8)
	b .L1141
.L1055:
	cmpwi 0,27,21
	bc 4,2,.L1060
	lwz 3,412(31)
	cmpwi 0,3,0
	bc 12,2,.L1061
	lis 9,gi@ha
	addi 3,3,4
	la 29,gi@l(9)
	lwz 9,52(29)
	mtlr 9
	blrl
	lis 0,0x1
	cmpw 0,3,0
	bc 4,2,.L1062
	lwz 0,8(29)
	lis 5,.LC326@ha
	mr 3,31
	la 5,.LC326@l(5)
	b .L1146
.L1062:
	lwz 0,264(31)
	andis. 28,0,0x1000
	bc 4,2,.L984
	mr 3,31
	bl CTFDrop_Flag
	mr 3,31
	bl make_tele
	lwz 9,412(31)
	mr 3,31
	lfs 0,4(9)
	stfs 0,4(31)
	lfs 13,8(9)
	stfs 13,8(31)
	lfs 0,12(9)
	stfs 0,12(31)
	bl make_tele
	lwz 3,412(31)
	bl G_FreeEdict
	stw 28,412(31)
	mr 3,31
	bl KillBox
	lwz 0,8(29)
	lis 5,.LC327@ha
	mr 3,31
	la 5,.LC327@l(5)
.L1146:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1065
.L1061:
	bl G_Spawn
	lfs 13,4(31)
	mr 29,3
	lis 28,gi@ha
	la 28,gi@l(28)
	stfs 13,4(29)
	lfs 0,8(31)
	stfs 0,8(29)
	lfs 13,12(31)
	stfs 13,12(29)
	lwz 9,72(28)
	mtlr 9
	blrl
	stw 29,412(31)
	lis 5,.LC328@ha
	li 4,2
	lwz 9,8(28)
	la 5,.LC328@l(5)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(28)
	lis 3,.LC329@ha
	la 3,.LC329@l(3)
	mtlr 9
	blrl
	lwz 0,16(28)
	lis 8,.LC350@ha
	lis 9,.LC350@ha
	lis 10,.LC351@ha
	mr 5,3
	la 8,.LC350@l(8)
	la 9,.LC350@l(9)
	mtlr 0
	la 10,.LC351@l(10)
	li 4,0
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L1065:
	lis 8,.LC350@ha
	lis 9,level+4@ha
	lwz 11,84(31)
	la 8,.LC350@l(8)
	b .L1141
.L1060:
	cmpwi 0,27,11
	bc 4,2,.L1067
	li 0,5
	lis 11,level+4@ha
	lwz 10,84(31)
	stw 0,924(31)
	lis 9,.LC330@ha
	li 22,1
	lfs 0,level+4@l(11)
	lfd 13,.LC330@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,1828(10)
	b .L991
.L1067:
	cmpwi 0,27,2
	bc 4,2,.L1069
	lis 29,gi@ha
	lis 3,.LC331@ha
	la 29,gi@l(29)
	la 3,.LC331@l(3)
	lwz 9,36(29)
	li 22,1
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC350@ha
	lis 9,.LC350@ha
	lis 10,.LC351@ha
	mr 5,3
	la 8,.LC350@l(8)
	la 9,.LC350@l(9)
	mtlr 0
	la 10,.LC351@l(10)
	lfs 1,0(8)
	li 4,0
	lfs 2,0(9)
	mr 3,31
	lfs 3,0(10)
	blrl
	lis 8,.LC356@ha
	lis 9,.LC364@ha
	la 8,.LC356@l(8)
	la 9,.LC364@l(9)
	lfs 1,0(8)
	mr 3,31
	mr 4,31
	lfs 2,0(9)
	mr 5,31
	li 6,0
	li 7,42
	bl T_RadiusDamage
	lis 8,.LC360@ha
	lis 9,level+4@ha
	lwz 11,84(31)
	la 8,.LC360@l(8)
	b .L1141
.L1069:
	cmpwi 0,27,19
	bc 4,2,.L1071
	bl G_Spawn
	lfs 0,4(31)
	mr 29,3
	lis 9,0x600
	li 0,0
	li 11,0
	ori 9,9,3
	lis 27,level@ha
	stfs 0,4(29)
	la 27,level@l(27)
	lis 7,.LC332@ha
	lfs 0,8(31)
	lis 10,grav_think@ha
	lis 8,.LC370@ha
	la 10,grav_think@l(10)
	la 8,.LC370@l(8)
	lfs 31,0(8)
	lis 28,gi@ha
	lis 3,.LC217@ha
	stfs 0,8(29)
	la 28,gi@l(28)
	lfs 0,12(31)
	la 3,.LC217@l(3)
	stw 0,200(29)
	stw 11,40(29)
	stw 11,260(29)
	stw 11,248(29)
	stw 0,196(29)
	stw 0,192(29)
	stw 0,188(29)
	stw 0,208(29)
	stw 0,204(29)
	stw 9,252(29)
	stfs 0,12(29)
	stw 31,256(29)
	lfs 0,4(27)
	lfd 13,.LC332@l(7)
	stw 10,436(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lfs 13,4(27)
	fadds 13,13,31
	fctiwz 12,13
	stfd 12,440(1)
	lwz 8,444(1)
	stw 8,480(29)
	lwz 9,36(28)
	mtlr 9
	blrl
	stw 3,76(29)
	lwz 9,72(28)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,36(28)
	lis 3,.LC333@ha
	la 3,.LC333@l(3)
	mtlr 9
	blrl
	lwz 0,16(28)
	lis 8,.LC350@ha
	lis 9,.LC350@ha
	lis 10,.LC351@ha
	la 9,.LC350@l(9)
	mr 5,3
	la 8,.LC350@l(8)
	lfs 2,0(9)
	mtlr 0
	la 10,.LC351@l(10)
	li 4,0
	lfs 1,0(8)
	mr 3,31
	lfs 3,0(10)
	blrl
	lfs 0,4(27)
	lwz 9,84(31)
	fadds 0,0,31
	stfs 0,1828(9)
	b .L991
.L1071:
	cmpwi 0,27,1
	bc 4,2,.L1074
	lis 8,.LC377@ha
	addi 29,1,280
	la 8,.LC377@l(8)
	addi 4,1,8
	lfs 1,0(8)
	addi 3,31,4
	mr 5,29
	bl VectorMA
	lwz 11,508(31)
	lis 0,0x4330
	lis 8,.LC352@ha
	lfs 11,12(31)
	lis 9,0x600
	addi 11,11,-8
	la 8,.LC352@l(8)
	lfs 10,288(1)
	xoris 11,11,0x8000
	lfd 9,0(8)
	addi 3,1,200
	stw 11,444(1)
	lis 8,gi+48@ha
	mr 7,29
	stw 0,440(1)
	addi 4,1,296
	li 5,0
	lfd 0,440(1)
	li 6,0
	ori 9,9,3
	lwz 30,gi+48@l(8)
	lfs 13,4(31)
	mr 8,31
	fsub 0,0,9
	lfs 12,8(31)
	mtlr 30
	stfs 13,296(1)
	frsp 0,0
	stfs 12,300(1)
	fadds 10,10,0
	fadds 11,11,0
	stfs 10,288(1)
	stfs 11,304(1)
	blrl
	lwz 3,252(1)
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L991
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L991
	mr 4,31
	bl OnSameTeam
	cmpwi 0,3,0
	bc 4,2,.L991
	lwz 11,252(1)
	lwz 9,84(11)
	lwz 0,1808(9)
	cmpwi 0,0,8
	bc 12,2,.L991
	lis 9,level@ha
	lis 8,.LC361@ha
	la 9,level@l(9)
	la 8,.LC361@l(8)
	lfs 0,4(9)
	lis 10,.LC360@ha
	lfs 13,0(8)
	la 10,.LC360@l(10)
	lfs 12,0(10)
	fadds 0,0,13
	stfs 0,908(11)
	lfs 13,4(9)
	lwz 11,84(31)
	fadds 13,13,12
	stfs 13,1828(11)
	b .L991
.L1074:
	cmpwi 0,27,18
	bc 4,2,.L1077
	lwz 9,508(31)
	lis 0,0x4330
	lis 8,.LC352@ha
	lfs 13,12(31)
	lis 10,.LC377@ha
	addi 9,9,-8
	la 8,.LC352@l(8)
	lfs 10,4(31)
	xoris 9,9,0x8000
	lfd 12,0(8)
	la 10,.LC377@l(10)
	stw 9,444(1)
	addi 28,1,328
	addi 29,1,312
	stw 0,440(1)
	addi 4,1,8
	mr 3,28
	lfd 0,440(1)
	mr 5,29
	lfs 11,8(31)
	lfs 1,0(10)
	fsub 0,0,12
	stfs 10,328(1)
	stfs 11,332(1)
	frsp 0,0
	fadds 13,13,0
	stfs 13,336(1)
	bl VectorMA
	lis 11,gi@ha
	lis 9,0x600
	la 27,gi@l(11)
	mr 4,28
	lwz 11,48(27)
	mr 7,29
	mr 8,31
	ori 9,9,3
	li 5,0
	mtlr 11
	li 6,0
	addi 3,1,200
	blrl
	bl G_Spawn
	lfs 0,212(1)
	mr 28,3
	lis 9,0x600
	li 0,0
	ori 9,9,3
	li 10,0
	lis 7,level+4@ha
	stfs 0,4(28)
	lis 8,.LC332@ha
	lis 11,G_FreeEdict@ha
	lfs 13,216(1)
	la 11,G_FreeEdict@l(11)
	stfs 13,8(28)
	lfs 0,220(1)
	stw 0,200(28)
	stw 0,196(28)
	stw 0,192(28)
	stw 0,188(28)
	stw 0,208(28)
	stw 0,204(28)
	stw 10,260(28)
	stfs 0,12(28)
	stw 9,252(28)
	stw 31,256(28)
	lfs 0,level+4@l(7)
	lfd 13,.LC332@l(8)
	stw 11,436(28)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(28)
	lwz 9,72(27)
	mtlr 9
	blrl
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L1078
	mr 3,31
	addi 4,1,212
	li 5,2
	bl PlayerNoise
.L1078:
	lis 8,.LC378@ha
	lis 9,.LC379@ha
	la 8,.LC378@l(8)
	la 9,.LC379@l(9)
	lfs 2,0(9)
	mr 3,28
	mr 4,31
	lfs 1,0(8)
	mr 5,31
	li 6,128
	li 7,34
	bl T_RadiusDamage
	lwz 9,100(27)
	li 3,3
	mtlr 9
	blrl
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L1080
	lwz 0,100(27)
	li 3,17
	mtlr 0
	blrl
	b .L1081
.L1080:
	lwz 0,100(27)
	li 3,7
	mtlr 0
	blrl
.L1081:
	lis 29,gi@ha
	addi 28,28,4
	la 29,gi@l(29)
	mr 3,28
	lwz 9,120(29)
	li 22,1
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,28
	li 4,2
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC334@ha
	la 3,.LC334@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC350@ha
	lis 9,.LC350@ha
	lis 10,.LC351@ha
	la 8,.LC350@l(8)
	la 9,.LC350@l(9)
	mr 5,3
	lfs 1,0(8)
	mtlr 0
	la 10,.LC351@l(10)
	lfs 2,0(9)
	li 4,0
	mr 3,31
	lfs 3,0(10)
	blrl
	lis 9,level+4@ha
	lis 8,.LC366@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	la 8,.LC366@l(8)
	b .L1147
.L1077:
	cmpwi 0,27,14
	bc 4,2,.L1084
	lwz 0,264(31)
	lis 10,.LC367@ha
	lis 9,level+4@ha
	la 10,.LC367@l(10)
	lwz 11,84(31)
	li 22,1
	oris 0,0,0x1
	lfs 13,0(10)
	stw 0,264(31)
	lfs 0,level+4@l(9)
	b .L1148
.L1084:
	cmpwi 0,27,13
	bc 4,2,.L1086
	lwz 0,264(31)
	lis 11,level+4@ha
	lis 9,.LC335@ha
	lfd 13,.LC335@l(9)
	oris 0,0,0x1
	lwz 9,84(31)
	stw 0,264(31)
	lfs 0,level+4@l(11)
.L1142:
	fadd 0,0,13
	frsp 0,0
	stfs 0,1828(9)
	b .L991
.L1086:
	cmpwi 0,27,3
	bc 4,2,.L1088
	lwz 3,560(31)
	cmpwi 0,3,0
	bc 4,2,.L1089
	lis 11,.LC362@ha
	addi 29,1,344
	la 11,.LC362@l(11)
	addi 3,1,8
	lfs 1,0(11)
	mr 4,29
	bl VectorScale
	lis 8,.LC350@ha
	mr 3,29
	la 8,.LC350@l(8)
	mr 5,3
	lfs 1,0(8)
	addi 4,31,4
	bl VectorMA
	lwz 9,508(31)
	lis 0,0x4330
	lis 8,.LC352@ha
	lfs 13,352(1)
	addi 9,9,-8
	la 8,.LC352@l(8)
	xoris 9,9,0x8000
	lfd 12,0(8)
	stw 9,444(1)
	stw 0,440(1)
	lfd 0,440(1)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,352(1)
	bl G_Spawn
	mr 29,3
	lis 0,0xc0a0
	lis 9,0x40a0
	stw 0,196(29)
	addi 3,1,8
	stw 9,208(29)
	addi 4,29,16
	stw 0,188(29)
	stw 0,192(29)
	stw 9,200(29)
	stw 9,204(29)
	lfs 0,344(1)
	stfs 0,4(29)
	lfs 13,348(1)
	stfs 13,8(29)
	lfs 0,352(1)
	stfs 0,12(29)
	lfs 13,8(1)
	stfs 13,340(29)
	lfs 0,12(1)
	stfs 0,344(29)
	lfs 13,16(1)
	stfs 13,348(29)
	bl vectoangles
	lis 8,.LC369@ha
	addi 3,1,8
	la 8,.LC369@l(8)
	addi 4,29,376
	lfs 1,0(8)
	bl VectorScale
	lis 9,0x4396
	lis 0,0x201
	stw 9,396(29)
	li 7,0
	ori 0,0,3
	li 11,8
	li 10,2
	stw 7,392(29)
	li 8,40
	lis 9,0x4366
	stw 11,260(29)
	lis 28,gi@ha
	stw 0,252(29)
	lis 3,.LC336@ha
	la 28,gi@l(28)
	stw 10,248(29)
	la 3,.LC336@l(3)
	stw 8,516(29)
	stw 7,388(29)
	stw 9,592(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	lis 10,grap_touch@ha
	lis 0,0x3f80
	stw 31,256(29)
	la 10,grap_touch@l(10)
	lis 7,level+4@ha
	stw 31,564(29)
	lis 8,.LC332@ha
	lis 11,grap_think@ha
	stw 29,560(31)
	lis 9,.LC337@ha
	la 11,grap_think@l(11)
	stw 10,444(29)
	la 9,.LC337@l(9)
	lis 3,.LC338@ha
	stw 0,596(29)
	la 3,.LC338@l(3)
	lfs 0,level+4@l(7)
	lfd 13,.LC332@l(8)
	stw 11,436(29)
	stw 9,280(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 9,36(28)
	mtlr 9
	blrl
	stw 3,76(29)
	lwz 9,72(28)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 3,.LC339@ha
	la 3,.LC339@l(3)
	lbz 0,16(9)
	ori 0,0,64
	stb 0,16(9)
	lwz 9,36(28)
	mtlr 9
	blrl
	lwz 0,16(28)
	lis 8,.LC350@ha
	lis 9,.LC350@ha
	lis 10,.LC351@ha
	mr 5,3
	la 8,.LC350@l(8)
	la 9,.LC350@l(9)
	mtlr 0
	la 10,.LC351@l(10)
	li 4,0
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L991
.L1089:
	bl G_FreeEdict
	lwz 11,84(31)
	li 9,0
	stw 9,560(31)
	lbz 0,16(11)
	andi. 0,0,191
	stb 0,16(11)
	b .L991
.L1088:
	cmpwi 0,27,4
	bc 4,2,.L1092
	lis 8,.LC363@ha
	lis 9,g_edicts@ha
	la 8,.LC363@l(8)
	addi 0,31,4
	lwz 3,g_edicts@l(9)
	lfs 1,0(8)
	mr 4,0
	mr 27,0
	bl findradius
	mr. 29,3
	bc 12,2,.L1094
	lis 8,.LC364@ha
	addi 28,1,344
	la 8,.LC364@l(8)
	lis 26,.LC340@ha
	lfs 31,0(8)
.L1095:
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L1098
	lwz 0,264(29)
	xor 9,29,31
	addic 10,9,-1
	subfe 11,10,9
	xori 0,0,8192
	rlwinm 0,0,19,31,31
	and. 8,0,11
	bc 12,2,.L1098
	mr 3,31
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 4,2,.L1098
	lwz 9,84(29)
	lwz 0,1808(9)
	cmpwi 0,0,8
	bc 4,2,.L1097
.L1098:
	lwz 0,184(29)
	andi. 8,0,4
	bc 12,2,.L1096
.L1097:
	lfs 0,4(29)
	mr 3,28
	mr 4,28
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,344(1)
	lfs 0,8(29)
	fsubs 12,12,0
	stfs 12,348(1)
	lfs 0,12(29)
	fsubs 11,11,0
	stfs 11,352(1)
	bl VectorNormalize2
	lfs 1,.LC340@l(26)
	mr 3,28
	mr 4,28
	bl VectorScale
	lfs 0,352(1)
	li 0,0
	lfs 13,344(1)
	fadds 0,0,31
	stfs 0,352(1)
	stfs 13,376(29)
	lfs 0,348(1)
	stfs 0,380(29)
	lfs 13,352(1)
	stw 0,552(29)
	stfs 13,384(29)
.L1096:
	lis 8,.LC363@ha
	mr 3,29
	la 8,.LC363@l(8)
	mr 4,27
	lfs 1,0(8)
	bl findradius
	mr. 29,3
	bc 4,2,.L1095
.L1094:
	lis 29,gi@ha
	lis 3,.LC341@ha
	la 29,gi@l(29)
	la 3,.LC341@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC350@ha
	lis 9,.LC350@ha
	lis 10,.LC351@ha
	la 8,.LC350@l(8)
	la 9,.LC350@l(9)
	mr 5,3
	lfs 1,0(8)
	mtlr 0
	la 10,.LC351@l(10)
	lfs 2,0(9)
	li 4,0
	mr 3,31
	lfs 3,0(10)
	blrl
	mr 4,27
	li 3,1
	li 5,0
	bl make_ball
	lis 8,.LC372@ha
	lis 9,level+4@ha
	lwz 11,84(31)
	la 8,.LC372@l(8)
	b .L1141
.L1092:
	cmpwi 0,27,15
	bc 4,2,.L1101
	mr 3,31
	bl anchor
	cmpwi 0,3,1
	bc 4,2,.L991
	lis 8,.LC380@ha
	lis 9,level+4@ha
	lwz 11,84(31)
	la 8,.LC380@l(8)
	b .L1141
.L1101:
	cmpwi 0,27,9
	bc 4,2,.L1104
	lis 9,.LC342@ha
	lis 10,.LC381@ha
	lfd 29,.LC342@l(9)
	la 10,.LC381@l(10)
	lis 26,0x1b4e
	lis 9,.LC352@ha
	lfd 31,0(10)
	li 29,0
	la 9,.LC352@l(9)
	addi 27,31,4
	lfd 30,0(9)
	addi 28,1,360
	ori 26,26,33205
	lis 25,0x4330
.L1108:
	mr 3,28
	bl vrandom
	bl rand
	xoris 0,29,0x8000
	stw 0,444(1)
	mr 7,3
	lis 8,.LC382@ha
	stw 25,440(1)
	mulhw 0,7,26
	srawi 11,7,31
	la 8,.LC382@l(8)
	lfd 0,440(1)
	mr 4,27
	mr 3,31
	srawi 0,0,5
	lfs 2,0(8)
	mr 5,28
	subf 0,11,0
	li 6,100
	fsub 0,0,30
	mulli 0,0,300
	li 8,0
	addi 29,29,1
	subf 7,0,7
	frsp 0,0
	addi 7,7,300
	fmr 1,0
	fmadd 1,1,29,31
	frsp 1,1
	bl fire_grenade
	cmpwi 0,29,9
	bc 4,1,.L1108
	lis 8,.LC383@ha
	lis 9,level+4@ha
	lwz 11,84(31)
	la 8,.LC383@l(8)
	lfs 0,level+4@l(9)
	li 22,1
	b .L1143
.L1104:
	cmpwi 0,27,7
	bc 4,2,.L1111
	mr 3,31
	li 22,1
	bl fire_cascade
	b .L1145
.L1111:
	cmpwi 0,27,10
	bc 4,2,.L1113
	mr 3,31
	bl give_random
	lis 8,.LC361@ha
	lis 9,level+4@ha
	lwz 11,84(31)
	la 8,.LC361@l(8)
	b .L1141
.L1113:
	cmpwi 0,27,17
	bc 4,2,.L1115
	lwz 9,508(31)
	lis 10,0x4330
	lis 8,.LC352@ha
	lwz 3,84(31)
	addi 29,1,392
	addi 9,9,-8
	la 8,.LC352@l(8)
	xoris 9,9,0x8000
	lfd 13,0(8)
	addi 28,1,408
	stw 9,444(1)
	lis 0,0x4100
	addi 27,1,424
	stw 10,440(1)
	mr 4,29
	addi 3,3,3692
	lfd 0,440(1)
	mr 5,28
	li 6,0
	stw 0,380(1)
	addi 26,31,4
	stw 0,376(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,384(1)
	bl AngleVectors
	lwz 3,84(31)
	addi 5,1,376
	mr 6,29
	mr 8,27
	mr 7,28
	mr 4,26
	bl P_ProjectSource
	lis 8,.LC373@ha
	lwz 4,84(31)
	mr 3,29
	la 8,.LC373@l(8)
	lfs 1,0(8)
	addi 4,4,3640
	bl VectorScale
	lwz 9,84(31)
	lis 0,0xbf80
	lis 8,.LC361@ha
	la 8,.LC361@l(8)
	mr 5,29
	stw 0,3628(9)
	li 6,180
	li 7,600
	lis 9,.LC356@ha
	lfs 1,0(8)
	mr 4,27
	la 9,.LC356@l(9)
	li 8,2
.L1144:
	lfs 2,0(9)
	mr 3,31
	bl fire_grenade
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xdcfd
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,53213
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lwz 9,100(29)
	li 3,8
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
	mr 4,27
	mr 3,31
	li 5,1
	bl PlayerNoise
	lis 9,level+4@ha
	lis 8,.LC375@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	la 8,.LC375@l(8)
.L1147:
	lfd 13,0(8)
	fadd 0,0,13
	frsp 0,0
	stfs 0,1828(11)
	b .L991
.L1115:
	cmpwi 0,27,16
	bc 4,2,.L1117
	lis 9,g_edicts@ha
	addi 0,31,4
	lwz 3,g_edicts@l(9)
	mr 4,0
	mr 27,0
	lis 9,.LC364@ha
	la 9,.LC364@l(9)
	lfs 1,0(9)
	bl findradius
	mr. 29,3
	bc 12,2,.L1119
	lis 8,.LC360@ha
	lis 9,level@ha
	la 8,.LC360@l(8)
	la 28,level@l(9)
	lfs 31,0(8)
.L1120:
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L1123
	lwz 0,264(29)
	xor 9,29,31
	addic 10,9,-1
	subfe 11,10,9
	xori 0,0,8192
	rlwinm 0,0,19,31,31
	and. 8,0,11
	bc 12,2,.L1123
	mr 3,31
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L1122
.L1123:
	lwz 0,184(29)
	andi. 8,0,4
	bc 12,2,.L1121
.L1122:
	lfs 0,4(28)
	fadds 0,0,31
	stfs 0,912(29)
.L1121:
	lis 9,.LC364@ha
	mr 3,29
	la 9,.LC364@l(9)
	mr 4,27
	lfs 1,0(9)
	bl findradius
	mr. 29,3
	bc 4,2,.L1120
.L1119:
	lis 29,gi@ha
	lis 3,.LC343@ha
	la 29,gi@l(29)
	la 3,.LC343@l(3)
	lwz 9,36(29)
	li 22,1
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC350@ha
	lis 9,.LC350@ha
	lis 10,.LC351@ha
	la 8,.LC350@l(8)
	la 9,.LC350@l(9)
	mr 5,3
	lfs 1,0(8)
	mtlr 0
	la 10,.LC351@l(10)
	lfs 2,0(9)
	li 4,0
	mr 3,31
	lfs 3,0(10)
	blrl
	lis 8,.LC370@ha
	lis 9,level+4@ha
	lwz 11,84(31)
	la 8,.LC370@l(8)
	b .L1141
.L1117:
	cmpwi 0,27,22
	bc 4,2,.L1126
	bl G_Spawn
	li 28,2
	lfs 0,4(31)
	mr 29,3
	lis 8,weird_think@ha
	la 8,weird_think@l(8)
	li 0,0
	lis 10,level@ha
	lis 11,.LC332@ha
	stfs 0,4(29)
	la 10,level@l(10)
	lis 9,.LC362@ha
	lfs 0,8(31)
	la 9,.LC362@l(9)
	lis 3,.LC344@ha
	lfd 13,.LC332@l(11)
	la 3,.LC344@l(3)
	lfs 12,0(9)
	stfs 0,8(29)
	lis 9,gi@ha
	lfs 0,12(31)
	la 27,gi@l(9)
	stw 0,260(29)
	stw 8,436(29)
	stfs 0,12(29)
	stw 28,248(29)
	lfs 0,4(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lfs 13,4(10)
	fadds 13,13,12
	stfs 13,592(29)
	lwz 9,32(27)
	mtlr 9
	blrl
	stw 3,40(29)
	bl rand
	mr 11,3
	lis 9,BecomeExplosion1@ha
	stw 28,512(29)
	srawi 0,11,31
	la 9,BecomeExplosion1@l(9)
	stw 31,256(29)
	srwi 0,0,30
	stw 9,456(29)
	lis 8,0xc040
	add 0,11,0
	lis 9,0x4040
	stw 8,196(29)
	rlwinm 0,0,0,0,29
	li 10,100
	stw 9,208(29)
	subf 11,0,11
	stw 10,480(29)
	mr 3,29
	stw 11,644(29)
	stw 8,188(29)
	stw 8,192(29)
	stw 9,200(29)
	stw 9,204(29)
	lwz 9,72(27)
	mtlr 9
	blrl
	lwz 0,644(29)
	cmpwi 0,0,0
	bc 4,2,.L1127
	lwz 0,8(27)
	lis 5,.LC345@ha
	mr 3,31
	la 5,.LC345@l(5)
	b .L1149
.L1127:
	cmpwi 0,0,1
	bc 4,2,.L1129
	lwz 0,8(27)
	lis 5,.LC346@ha
	mr 3,31
	la 5,.LC346@l(5)
	b .L1149
.L1129:
	cmpwi 0,0,2
	bc 4,2,.L1131
	lwz 0,8(27)
	lis 5,.LC347@ha
	mr 3,31
	la 5,.LC347@l(5)
.L1149:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1128
.L1131:
	cmpwi 0,0,3
	bc 4,2,.L1128
	lwz 0,8(27)
	lis 5,.LC348@ha
	mr 3,31
	la 5,.LC348@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L1128:
	lis 29,gi@ha
	lis 3,.LC329@ha
	la 29,gi@l(29)
	la 3,.LC329@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC350@ha
	lis 9,.LC350@ha
	lis 10,.LC351@ha
	la 8,.LC350@l(8)
	la 9,.LC350@l(9)
	mr 5,3
	lfs 1,0(8)
	mtlr 0
	la 10,.LC351@l(10)
	lfs 2,0(9)
	li 4,0
	mr 3,31
.L1151:
	lfs 3,0(10)
	blrl
.L1145:
	lis 8,.LC376@ha
	lis 9,level+4@ha
	lwz 11,84(31)
	la 8,.LC376@l(8)
.L1141:
	lfs 0,level+4@l(9)
.L1143:
	lfs 13,0(8)
.L1148:
	fadds 0,0,13
	stfs 0,1828(11)
	b .L991
.L1126:
	lis 9,gi+8@ha
	lis 5,.LC349@ha
	lwz 0,gi+8@l(9)
	la 5,.LC349@l(5)
	mr 6,27
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L991:
	lis 9,invis_index@ha
	lwz 0,40(31)
	lwz 11,invis_index@l(9)
	xor 0,0,11
	subfic 8,0,0
	adde 0,8,0
	and. 9,0,22
	bc 12,2,.L984
	lwz 3,84(31)
	lwz 0,1816(3)
	cmpwi 0,0,5
	bc 4,2,.L1136
	lis 10,.LC360@ha
	lis 9,level+4@ha
	la 10,.LC360@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	b .L1150
.L1136:
	lis 11,.LC367@ha
	lis 9,level+4@ha
	la 11,.LC367@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
.L1150:
	fadds 0,0,13
	stfs 0,1832(3)
.L984:
	lwz 0,516(1)
	mtlr 0
	lmw 22,448(1)
	lfd 29,488(1)
	lfd 30,496(1)
	lfd 31,504(1)
	la 1,512(1)
	blr
.Lfe35:
	.size	 CallActive,.Lfe35-CallActive
	.align 2
	.globl ComboPowers
	.type	 ComboPowers,@function
ComboPowers:
	lwz 9,84(3)
	li 10,0
	lwz 0,1816(9)
	cmpwi 0,0,0
	bc 4,2,.L1153
	mr 11,10
	mr 0,10
	b .L1154
.L1153:
	cmpwi 0,0,1
	bc 4,2,.L1155
	li 11,-1
	li 0,-1
	li 10,-1
	b .L1154
.L1155:
	cmpwi 0,0,6
	bc 4,2,.L1157
	li 11,-4
	li 0,-4
	li 10,-4
	b .L1154
.L1157:
	cmpwi 0,0,4
	bc 4,2,.L1159
	li 11,-3
	li 0,-3
	li 10,-3
	b .L1154
.L1159:
	cmpwi 0,0,2
	bc 4,2,.L1161
	li 11,-2
	li 0,-2
	li 10,-2
	b .L1154
.L1161:
	cmpwi 0,0,7
	bc 4,2,.L1163
	li 11,-5
	li 0,-5
	li 10,-5
	b .L1154
.L1163:
	cmpwi 0,0,3
	bc 4,2,.L1165
	li 11,-6
	li 0,-6
	li 10,-6
	b .L1154
.L1165:
	cmpwi 0,0,8
	bc 4,2,.L1167
	li 11,-7
	li 0,-7
	li 10,-7
	b .L1154
.L1167:
	cmpwi 0,0,111
	bc 4,2,.L1169
	li 11,13
	li 0,10
	li 10,16
	b .L1154
.L1169:
	cmpwi 0,0,119
	bc 4,2,.L1171
	li 11,3
	li 0,13
	li 10,5
	b .L1154
.L1171:
	cmpwi 0,0,110
	bc 4,2,.L1173
	li 11,9
	li 0,9
	li 10,13
	b .L1154
.L1173:
	cmpwi 0,0,11
	bc 4,2,.L1175
	li 11,-10
	li 0,-10
	li 10,-10
	b .L1154
.L1175:
	cmpwi 0,0,5
	bc 4,2,.L1177
	li 11,-8
	li 0,-8
	li 10,-8
	b .L1154
.L1177:
	li 11,0
	li 0,0
	li 10,0
.L1154:
	lwz 9,84(3)
	stw 11,1804(9)
	lwz 11,84(3)
	stw 0,1808(11)
	lwz 9,84(3)
	stw 10,1812(9)
	blr
.Lfe36:
	.size	 ComboPowers,.Lfe36-ComboPowers
	.section	".rodata"
	.align 2
.LC384:
	.string	"admin"
	.align 2
.LC385:
	.string	"%s is no longer an admin.\n"
	.align 2
.LC386:
	.string	"%s is an admin.\n"
	.align 2
.LC387:
	.string	"%s entered an incorrect admin password.\n"
	.align 2
.LC388:
	.string	"disconnect\n"
	.align 2
.LC389:
	.string	"warp"
	.align 2
.LC390:
	.string	"map "
	.align 2
.LC391:
	.string	"Only admins can change levels.\n"
	.align 2
.LC392:
	.string	"lock"
	.align 2
.LC393:
	.string	"playerlock "
	.align 2
.LC394:
	.string	"Only admins can lock players.\n"
	.align 2
.LC395:
	.string	"allobs"
	.align 2
.LC396:
	.string	"sv forceobs\n"
	.align 2
.LC397:
	.string	"Only admins can force observers.\n"
	.align 2
.LC398:
	.string	"loc"
	.align 2
.LC399:
	.string	"location: %f %f %f\n"
	.align 2
.LC400:
	.string	"a_inc"
	.align 2
.LC401:
	.string	"a_dec"
	.align 2
.LC402:
	.string	"p_inc"
	.align 2
.LC403:
	.string	"p_dec"
	.align 2
.LC404:
	.string	"s_inc"
	.align 2
.LC405:
	.string	"s_dec"
	.align 2
.LC406:
	.string	"c_inc"
	.align 2
.LC407:
	.string	"c_dec"
	.align 2
.LC408:
	.string	"s_obs"
	.align 2
.LC409:
	.string	"You have the flag!\n"
	.align 2
.LC410:
	.string	"You already are an observer!\n"
	.align 2
.LC411:
	.string	"s_play"
	.align 2
.LC412:
	.string	"s_pwr"
	.align 2
.LC413:
	.string	"pnum"
	.align 2
.LC414:
	.string	"pnums: %i, %i, %i\n"
	.align 2
.LC415:
	.string	"setp"
	.align 2
.LC416:
	.string	"active"
	.align 2
.LC417:
	.string	"rebind"
	.align 2
.LC418:
	.string	"bind ins  \"use a_inc\"\n"
	.align 2
.LC419:
	.string	"bind del  \"use a_dec\"\n"
	.align 2
.LC420:
	.string	"bind home \"use p_inc\"\n"
	.align 2
.LC421:
	.string	"bind end  \"use p_dec\"\n"
	.align 2
.LC422:
	.string	"bind pgup \"use s_inc\"\n"
	.align 2
.LC423:
	.string	"bind pgdn \"use s_dec\"\n"
	.align 2
.LC424:
	.string	"bind ] \"use c_inc\"\n"
	.align 2
.LC425:
	.string	"bind [ \"use c_dec\"\n"
	.align 2
.LC426:
	.string	"bind o \"use s_obs\"\n"
	.align 2
.LC427:
	.string	"bind p \"use s_pwr\"\n"
	.align 2
.LC428:
	.string	"Keys rebound.\n"
	.align 2
.LC429:
	.string	"team"
	.align 2
.LC430:
	.string	"You're not playing CTF!\n"
	.align 2
.LC431:
	.string	"You are on the Good Team!\n"
	.align 2
.LC432:
	.string	"You are on the Evil Team!\n"
	.align 2
.LC433:
	.string	"You're not on a team yet!\n"
	.align 2
.LC434:
	.string	"Good: %i, Players: %i\n"
	.align 2
.LC435:
	.string	"Evil: %i, Players: %i\n"
	.align 2
.LC436:
	.string	"good"
	.align 2
.LC437:
	.string	"*** ctf_force is 1, cannot change teams\n"
	.align 2
.LC438:
	.string	"*** Already on the Good team!\n"
	.align 2
.LC439:
	.string	"evil"
	.align 2
.LC440:
	.string	"*** Already on the Evil team!\n"
	.align 2
.LC441:
	.string	"luck"
	.align 2
.LC442:
	.string	"Your lucky number is: %i\n"
	.align 2
.LC443:
	.string	"Your max health is: %i, pers->%i\n"
	.align 2
.LC444:
	.string	"%c%.16s====================\n"
	.align 2
.LC445:
	.string	"Active :%c%s\n"
	.align 2
.LC446:
	.string	"Passive:%c%s\n"
	.align 2
.LC447:
	.string	"Special:%c%s\n"
	.align 2
.LC448:
	.string	"You can only change powers\nWhile in observer mode!\nHit 'o' to become an observer."
	.align 2
.LC449:
	.long 0x0
	.align 2
.LC450:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SuperCommand
	.type	 SuperCommand,@function
SuperCommand:
	stwu 1,-80(1)
	mflr 0
	stmw 25,52(1)
	stw 0,84(1)
	addi 30,1,8
	mr 29,4
	mr 31,3
	li 4,0
	li 5,20
	mr 3,30
	crxor 6,6,6
	bl memset
	li 25,0
	lis 26,gi@ha
	lis 9,gi@ha
	li 3,1
	la 27,gi@l(9)
	lwz 9,160(27)
	mtlr 9
	blrl
	lwz 9,160(27)
	li 3,2
	mtlr 9
	blrl
	lwz 9,160(27)
	mr 28,3
	li 3,3
	mtlr 9
	blrl
	lis 4,.LC384@ha
	mr 3,29
	la 4,.LC384@l(4)
	li 5,5
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1180
	lis 4,admin@ha
	mr 3,28
	la 4,admin@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L1181
	lwz 9,84(31)
	lwz 0,1820(9)
	cmpwi 0,0,5
	bc 4,2,.L1182
	stw 25,1820(9)
	lwz 3,84(31)
	addi 3,3,700
	bl Green1
	lwz 0,gi@l(26)
	mr 5,3
	lis 4,.LC385@ha
	la 4,.LC385@l(4)
	li 3,2
	b .L1320
.L1182:
	li 0,5
	stw 0,1820(9)
	lwz 3,84(31)
	addi 3,3,700
	bl Green1
	lwz 0,gi@l(26)
	mr 5,3
	lis 4,.LC386@ha
	la 4,.LC386@l(4)
	li 3,2
	b .L1320
.L1181:
	lwz 3,84(31)
	addi 3,3,700
	bl Green1
	lwz 0,gi@l(26)
	mr 5,3
	lis 4,.LC387@ha
	la 4,.LC387@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 10,84(31)
	lwz 9,1820(10)
	addi 9,9,1
	stw 9,1820(10)
	lwz 11,84(31)
	lwz 0,1820(11)
	cmpwi 0,0,2
	bc 4,1,.L1186
	lis 4,.LC388@ha
	mr 3,31
	la 4,.LC388@l(4)
	bl stuffcmd
	b .L1186
.L1180:
	lis 4,.LC389@ha
	mr 3,29
	la 4,.LC389@l(4)
	li 5,4
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1187
	lwz 9,84(31)
	lwz 0,1820(9)
	cmpwi 0,0,5
	bc 4,2,.L1188
	lis 9,.LC390@ha
	mr 4,28
	lwz 11,.LC390@l(9)
	mr 3,30
	la 9,.LC390@l(9)
	lbz 0,4(9)
	stw 11,8(1)
	stb 0,4(30)
	bl strcat
	lwz 0,168(27)
	mr 3,30
	b .L1321
.L1188:
	lwz 0,8(27)
	lis 5,.LC391@ha
	mr 3,31
	la 5,.LC391@l(5)
	b .L1322
.L1187:
	lis 4,.LC392@ha
	mr 3,29
	la 4,.LC392@l(4)
	li 5,4
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1191
	lwz 9,84(31)
	lwz 0,1820(9)
	cmpwi 0,0,5
	bc 4,2,.L1192
	lis 9,.LC393@ha
	mr 4,28
	lwz 10,.LC393@l(9)
	mr 3,30
	la 9,.LC393@l(9)
	lwz 0,4(9)
	lwz 11,8(9)
	stw 10,8(1)
	stw 0,4(30)
	stw 11,8(30)
	bl strcat
	lwz 0,168(27)
	mr 3,30
	b .L1321
.L1192:
	lwz 0,8(27)
	lis 5,.LC394@ha
	mr 3,31
	la 5,.LC394@l(5)
	b .L1322
.L1191:
	lis 4,.LC395@ha
	mr 3,29
	la 4,.LC395@l(4)
	li 5,4
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1195
	lwz 9,84(31)
	lwz 0,1820(9)
	cmpwi 0,0,5
	bc 4,2,.L1196
	lwz 0,168(27)
	lis 3,.LC396@ha
	la 3,.LC396@l(3)
.L1321:
	mtlr 0
	blrl
	b .L1186
.L1196:
	lwz 0,8(27)
	lis 5,.LC397@ha
	mr 3,31
	la 5,.LC397@l(5)
	b .L1322
.L1195:
	lis 4,.LC398@ha
	mr 3,29
	la 4,.LC398@l(4)
	li 5,3
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1199
	lfs 1,4(31)
	lis 5,.LC399@ha
	mr 3,31
	lfs 2,8(31)
	la 5,.LC399@l(5)
	li 4,2
	lfs 3,12(31)
	lwz 0,8(27)
	mtlr 0
	creqv 6,6,6
	blrl
	b .L1186
.L1199:
	lis 4,.LC400@ha
	mr 3,29
	la 4,.LC400@l(4)
	li 5,5
	bl Q_strncasecmp
	mr. 3,3
	bc 4,2,.L1201
	lwz 0,264(31)
	andi. 9,0,8192
	bc 12,2,.L1255
	lwz 9,84(31)
	stw 25,1816(9)
	lwz 11,84(31)
	li 25,1
	lwz 9,1804(11)
	addi 9,9,1
	stw 9,1804(11)
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,23
	bc 4,1,.L1186
	stw 3,1804(9)
	b .L1186
.L1201:
	lis 4,.LC401@ha
	mr 3,29
	la 4,.LC401@l(4)
	li 5,5
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1206
	lwz 0,264(31)
	andi. 9,0,8192
	bc 12,2,.L1255
	lwz 9,84(31)
	stw 25,1816(9)
	lwz 11,84(31)
	li 25,1
	lwz 9,1804(11)
	addi 9,9,-1
	stw 9,1804(11)
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,0,.L1186
	li 0,23
	stw 0,1804(9)
	b .L1186
.L1206:
	lis 4,.LC402@ha
	mr 3,29
	la 4,.LC402@l(4)
	li 5,5
	bl Q_strncasecmp
	mr. 3,3
	bc 4,2,.L1211
	lwz 0,264(31)
	andi. 9,0,8192
	bc 12,2,.L1255
	lwz 9,84(31)
	stw 25,1816(9)
	lwz 11,84(31)
	li 25,1
	lwz 9,1808(11)
	addi 9,9,1
	stw 9,1808(11)
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,19
	bc 4,1,.L1186
	stw 3,1808(9)
	b .L1186
.L1211:
	lis 4,.LC403@ha
	mr 3,29
	la 4,.LC403@l(4)
	li 5,5
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1216
	lwz 0,264(31)
	andi. 9,0,8192
	bc 12,2,.L1255
	lwz 9,84(31)
	stw 25,1816(9)
	lwz 11,84(31)
	li 25,1
	lwz 9,1808(11)
	addi 9,9,-1
	stw 9,1808(11)
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,0
	bc 4,0,.L1186
	li 0,19
	stw 0,1808(9)
	b .L1186
.L1216:
	lis 4,.LC404@ha
	mr 3,29
	la 4,.LC404@l(4)
	li 5,5
	bl Q_strncasecmp
	mr. 3,3
	bc 4,2,.L1221
	lwz 0,264(31)
	andi. 9,0,8192
	bc 12,2,.L1255
	lwz 9,84(31)
	stw 25,1816(9)
	lwz 11,84(31)
	li 25,1
	lwz 9,1812(11)
	addi 9,9,1
	stw 9,1812(11)
	lwz 9,84(31)
	lwz 0,1812(9)
	cmpwi 0,0,19
	bc 4,1,.L1186
	stw 3,1812(9)
	b .L1186
.L1221:
	lis 4,.LC405@ha
	mr 3,29
	la 4,.LC405@l(4)
	li 5,5
	bl Q_strncasecmp
	mr. 3,3
	bc 4,2,.L1226
	lwz 0,264(31)
	andi. 9,0,8192
	bc 12,2,.L1255
	lwz 9,84(31)
	li 25,1
	stw 3,1816(9)
	lwz 11,84(31)
	lwz 9,1812(11)
	addi 9,9,-1
	stw 9,1812(11)
	lwz 9,84(31)
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 4,0,.L1186
	li 0,19
	stw 0,1812(9)
	b .L1186
.L1226:
	lis 4,.LC406@ha
	mr 3,29
	la 4,.LC406@l(4)
	li 5,5
	bl Q_strncasecmp
	mr. 3,3
	bc 4,2,.L1231
	lwz 0,264(31)
	andi. 9,0,8192
	bc 12,2,.L1255
	lwz 9,84(31)
	li 25,1
	lwz 11,1816(9)
	addi 11,11,1
	stw 11,1816(9)
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,8
	bc 4,1,.L1238
	stw 3,1816(9)
	b .L1238
.L1231:
	lis 4,.LC407@ha
	mr 3,29
	la 4,.LC407@l(4)
	li 5,5
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1236
	lwz 0,264(31)
	andi. 9,0,8192
	bc 12,2,.L1255
	lwz 9,84(31)
	li 25,1
	lwz 11,1816(9)
	addi 11,11,-1
	stw 11,1816(9)
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,0
	bc 4,0,.L1238
	li 0,8
	stw 0,1816(9)
.L1238:
	mr 3,31
	bl ComboPowers
	b .L1186
.L1236:
	lis 4,.LC408@ha
	mr 3,29
	la 4,.LC408@l(4)
	li 5,5
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1241
	lwz 9,264(31)
	lis 0,0x1000
	ori 0,0,8192
	and. 10,9,0
	bc 4,2,.L1242
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L1243
	lwz 11,84(31)
	lwz 9,3496(11)
	addi 9,9,-1
	stw 9,3496(11)
.L1243:
	mr 3,31
	bl MakeObserver
	b .L1186
.L1242:
	andis. 0,9,4096
	bc 12,2,.L1245
	lis 9,gi+12@ha
	lis 4,.LC409@ha
	lwz 0,gi+12@l(9)
	la 4,.LC409@l(4)
	b .L1323
.L1245:
	lis 9,gi+12@ha
	lis 4,.LC410@ha
	lwz 0,gi+12@l(9)
	la 4,.LC410@l(4)
.L1323:
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1186
.L1241:
	lis 4,.LC411@ha
	mr 3,29
	la 4,.LC411@l(4)
	li 5,6
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1248
	mr 3,31
	bl MakePlayer
	b .L1186
.L1248:
	lis 4,.LC412@ha
	mr 3,29
	la 4,.LC412@l(4)
	li 5,5
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1250
	li 25,3
	b .L1186
.L1250:
	lis 4,.LC413@ha
	mr 3,29
	la 4,.LC413@l(4)
	li 5,4
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1252
	lis 11,gi+8@ha
	lwz 9,84(31)
	lis 5,.LC414@ha
	lwz 0,gi+8@l(11)
	la 5,.LC414@l(5)
	mr 3,31
	lwz 8,1812(9)
	li 4,2
	lwz 6,1804(9)
	mtlr 0
	lwz 7,1808(9)
	crxor 6,6,6
	blrl
	b .L1186
.L1252:
	lis 4,.LC415@ha
	mr 3,29
	la 4,.LC415@l(4)
	li 5,4
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1254
	lwz 0,264(31)
	andi. 9,0,8192
	bc 12,2,.L1255
	lis 29,gi@ha
	la 29,gi@l(29)
	lwz 9,164(29)
	mtlr 9
	blrl
	lwz 9,156(29)
	mtlr 9
	blrl
	lwz 9,160(29)
	li 3,2
	mtlr 9
	blrl
	bl atoi
	lwz 9,160(29)
	mr 28,3
	li 3,3
	mtlr 9
	blrl
	bl atoi
	lwz 0,160(29)
	mr 30,3
	li 3,4
	mtlr 0
	blrl
	bl atoi
	cmpwi 6,28,24
	cmpwi 7,30,20
	cmpwi 1,3,20
	mfcr 9
	rlwinm 0,9,25,1
	rlwinm 9,9,29,1
	neg 0,0
	neg 9,9
	and 28,28,0
	and 30,30,9
	srwi 11,28,31
	srwi 9,30,31
	mfcr 0
	rlwinm 0,0,5,1
	or. 10,11,9
	neg 0,0
	and 3,3,0
	bc 4,2,.L1260
	cmpwi 0,3,0
	bc 4,0,.L1259
.L1260:
	li 28,0
	li 30,0
	li 3,0
.L1259:
	lwz 11,84(31)
	li 0,0
	li 25,1
	stw 28,1804(11)
	lwz 9,84(31)
	stw 30,1808(9)
	lwz 11,84(31)
	stw 3,1812(11)
	lwz 9,84(31)
	stw 0,1816(9)
	b .L1186
.L1255:
	li 25,2
	b .L1186
.L1254:
	lis 4,.LC416@ha
	mr 3,29
	la 4,.LC416@l(4)
	li 5,6
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1263
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,1828(11)
	fcmpu 0,0,13
	bc 4,0,.L1186
	mr 3,31
	bl CallActive
	b .L1186
.L1263:
	lis 4,.LC417@ha
	mr 3,29
	la 4,.LC417@l(4)
	li 5,6
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1266
	lis 4,.LC418@ha
	mr 3,31
	la 4,.LC418@l(4)
	bl stuffcmd
	lis 4,.LC419@ha
	mr 3,31
	la 4,.LC419@l(4)
	bl stuffcmd
	lis 4,.LC420@ha
	mr 3,31
	la 4,.LC420@l(4)
	bl stuffcmd
	lis 4,.LC421@ha
	mr 3,31
	la 4,.LC421@l(4)
	bl stuffcmd
	lis 4,.LC422@ha
	mr 3,31
	la 4,.LC422@l(4)
	bl stuffcmd
	lis 4,.LC423@ha
	mr 3,31
	la 4,.LC423@l(4)
	bl stuffcmd
	lis 4,.LC424@ha
	mr 3,31
	la 4,.LC424@l(4)
	bl stuffcmd
	lis 4,.LC425@ha
	mr 3,31
	la 4,.LC425@l(4)
	bl stuffcmd
	lis 4,.LC426@ha
	mr 3,31
	la 4,.LC426@l(4)
	bl stuffcmd
	lis 4,.LC427@ha
	mr 3,31
	la 4,.LC427@l(4)
	bl stuffcmd
	lis 9,gi+8@ha
	lis 5,.LC428@ha
	lwz 0,gi+8@l(9)
	la 5,.LC428@l(5)
	b .L1324
.L1266:
	lis 4,.LC429@ha
	mr 3,29
	la 4,.LC429@l(4)
	li 5,4
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1268
	lis 9,.LC449@ha
	lis 11,ctf@ha
	la 9,.LC449@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L1269
	lis 9,gi+8@ha
	lis 5,.LC430@ha
	lwz 0,gi+8@l(9)
	la 5,.LC430@l(5)
	b .L1324
.L1269:
	lwz 0,264(31)
	andis. 9,0,1024
	bc 12,2,.L1271
	lis 9,gi+8@ha
	lis 5,.LC431@ha
	lwz 0,gi+8@l(9)
	la 5,.LC431@l(5)
	b .L1324
.L1271:
	andis. 9,0,2048
	bc 12,2,.L1273
	lis 9,gi+8@ha
	lis 5,.LC432@ha
	lwz 0,gi+8@l(9)
	la 5,.LC432@l(5)
	b .L1324
.L1273:
	lis 9,gi+8@ha
	lis 5,.LC433@ha
	lwz 0,gi+8@l(9)
	la 5,.LC433@l(5)
	b .L1324
.L1268:
	lis 4,.LC55@ha
	mr 3,29
	la 4,.LC55@l(4)
	li 5,5
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1276
	lis 3,0x400
	bl CTFTeamScore
	mr 30,3
	li 4,0
	lis 3,0x400
	bl CTFTeamCount
	lis 29,gi@ha
	mr 7,3
	la 29,gi@l(29)
	lis 5,.LC434@ha
	lwz 9,8(29)
	mr 6,30
	la 5,.LC434@l(5)
	li 4,2
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lis 3,0x800
	bl CTFTeamScore
	mr 30,3
	li 4,0
	lis 3,0x800
	bl CTFTeamCount
	lwz 0,8(29)
	lis 5,.LC435@ha
	mr 7,3
	la 5,.LC435@l(5)
	mr 6,30
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1186
.L1276:
	lis 4,.LC436@ha
	mr 3,29
	la 4,.LC436@l(4)
	li 5,4
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1278
	lis 9,.LC449@ha
	lis 11,ctf@ha
	la 9,.LC449@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L1279
	lis 9,gi+8@ha
	lis 5,.LC430@ha
	lwz 0,gi+8@l(9)
	la 5,.LC430@l(5)
	b .L1324
.L1279:
	lis 9,.LC450@ha
	lis 11,ctf_force@ha
	la 9,.LC450@l(9)
	lfs 13,0(9)
	lwz 9,ctf_force@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L1281
	lis 9,gi+8@ha
	lis 5,.LC437@ha
	lwz 0,gi+8@l(9)
	la 5,.LC437@l(5)
	b .L1324
.L1281:
	lwz 0,264(31)
	andis. 30,0,0x400
	bc 12,2,.L1283
	lis 9,gi+8@ha
	lis 5,.LC438@ha
	lwz 0,gi+8@l(9)
	la 5,.LC438@l(5)
	b .L1324
.L1283:
	mr 3,31
	bl MakeObserver
	lwz 9,84(31)
	li 3,1
	stw 30,3496(9)
	lwz 0,264(31)
	rlwinm 0,0,0,5,3
	oris 0,0,0x400
	stw 0,264(31)
	b .L1319
.L1278:
	lis 4,.LC439@ha
	mr 3,29
	la 4,.LC439@l(4)
	li 5,4
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1286
	lis 9,.LC449@ha
	lis 11,ctf@ha
	la 9,.LC449@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L1287
	lis 9,gi+8@ha
	lis 5,.LC430@ha
	lwz 0,gi+8@l(9)
	la 5,.LC430@l(5)
	b .L1324
.L1287:
	lis 9,.LC450@ha
	lis 11,ctf_force@ha
	la 9,.LC450@l(9)
	lfs 13,0(9)
	lwz 9,ctf_force@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L1289
	lis 9,gi+8@ha
	lis 5,.LC437@ha
	lwz 0,gi+8@l(9)
	la 5,.LC437@l(5)
	b .L1324
.L1289:
	lwz 0,264(31)
	andis. 30,0,0x800
	bc 12,2,.L1291
	lis 9,gi+8@ha
	lis 5,.LC440@ha
	lwz 0,gi+8@l(9)
	la 5,.LC440@l(5)
.L1324:
	mr 3,31
.L1322:
	li 4,2
.L1320:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1186
.L1291:
	mr 3,31
	bl MakeObserver
	lwz 9,84(31)
	li 3,1
	stw 30,3496(9)
	lwz 0,264(31)
	rlwinm 0,0,0,6,4
	oris 0,0,0x800
	stw 0,264(31)
	b .L1319
.L1286:
	lis 4,.LC441@ha
	mr 3,29
	la 4,.LC441@l(4)
	li 5,4
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L1294
	lis 11,gi+8@ha
	lwz 9,84(31)
	lis 5,.LC442@ha
	lwz 0,gi+8@l(11)
	la 5,.LC442@l(5)
	mr 3,31
	lwz 6,1824(9)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1186
.L1294:
	lis 4,.LC4@ha
	mr 3,29
	la 4,.LC4@l(4)
	li 5,6
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 12,2,.L1296
	li 3,0
	b .L1319
.L1296:
	lis 11,gi+8@ha
	lwz 9,84(31)
	lis 5,.LC443@ha
	lwz 0,gi+8@l(11)
	la 5,.LC443@l(5)
	mr 3,31
	lwz 7,728(9)
	li 4,2
	lwz 6,484(31)
	mtlr 0
	crxor 6,6,6
	blrl
.L1186:
	cmpwi 0,25,3
	bc 4,2,.L1298
	lwz 9,84(31)
	lwz 11,1816(9)
	cmpwi 0,11,0
	bc 4,2,.L1299
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,0,.L1300
	stw 11,1804(9)
.L1300:
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,0
	bc 4,0,.L1301
	stw 11,1808(9)
.L1301:
	lwz 9,84(31)
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 4,0,.L1299
	stw 11,1812(9)
.L1299:
	lwz 10,84(31)
	lis 9,game@ha
	lis 11,gi@ha
	la 30,game@l(9)
	la 28,gi@l(11)
	lwz 3,1816(10)
	addi 11,30,1808
	li 27,32
	slwi 9,3,2
	lwzx 0,11,9
	srawi 9,0,31
	xor 29,9,0
	subf 29,29,9
	srawi 29,29,31
	andi. 29,29,42
	ori 29,29,32
	bl CName
	lwz 9,8(28)
	mr 7,3
	lis 5,.LC444@ha
	mr 3,31
	la 5,.LC444@l(5)
	mtlr 9
	mr 6,29
	li 4,2
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	addi 11,30,1564
	lwz 3,1804(9)
	slwi 0,3,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L1305
	srawi 0,3,31
	subf 0,3,0
	srawi 0,0,31
	andi. 0,0,42
	ori 27,0,32
.L1305:
	bl AName
	li 29,32
	lwz 9,8(28)
	mr 7,3
	lis 5,.LC445@ha
	mr 3,31
	la 5,.LC445@l(5)
	mtlr 9
	mr 6,27
	li 4,2
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	addi 11,30,1656
	lwz 3,1808(9)
	slwi 0,3,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L1307
	srawi 0,3,31
	subf 0,3,0
	srawi 0,0,31
	andi. 0,0,42
	ori 29,0,32
.L1307:
	bl PName
	li 27,32
	lwz 9,8(28)
	mr 7,3
	lis 5,.LC446@ha
	mr 3,31
	la 5,.LC446@l(5)
	mtlr 9
	mr 6,29
	li 4,2
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	addi 11,30,1732
	lwz 3,1812(9)
	slwi 0,3,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L1309
	srawi 0,3,31
	subf 0,3,0
	srawi 0,0,31
	andi. 0,0,42
	ori 27,0,32
.L1309:
	bl SName
	lwz 0,8(28)
	mr 7,3
	lis 5,.LC447@ha
	mr 3,31
	la 5,.LC447@l(5)
	mr 6,27
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1311
.L1298:
	cmpwi 0,25,2
	bc 4,2,.L1312
	lis 9,gi+12@ha
	lis 4,.LC448@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC448@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1311
.L1312:
	cmpwi 0,25,1
	bc 4,2,.L1311
	lwz 9,84(31)
	lwz 11,1816(9)
	cmpwi 0,11,0
	bc 4,2,.L1311
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,0,.L1316
	stw 11,1804(9)
.L1316:
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,0
	bc 4,0,.L1317
	stw 11,1808(9)
.L1317:
	lwz 3,84(31)
	lwz 0,1812(3)
	cmpwi 0,0,0
	bc 4,0,.L1311
	stw 11,1812(3)
.L1311:
	li 3,1
.L1319:
	lwz 0,84(1)
	mtlr 0
	lmw 25,52(1)
	la 1,80(1)
	blr
.Lfe37:
	.size	 SuperCommand,.Lfe37-SuperCommand
	.section	".rodata"
	.align 2
.LC451:
	.string	"%s becomes an observer\n"
	.align 2
.LC452:
	.string	"Player lock is on!\n"
	.align 2
.LC453:
	.string	"To be a Mere Mortal,\nYou must select Mere Mortal for\nall of your powers!"
	.align 2
.LC454:
	.string	"To be a Killer Robot,\nYou must select Killer Robot for\nall of your powers!"
	.align 2
.LC455:
	.string	"To be a Cripple,\nYou must select Cripple for\nall of your powers!"
	.align 2
.LC456:
	.string	"To be an Archmage,\nYou must select Archmage for\nall of your powers!"
	.align 2
.LC457:
	.string	"To be a Punisher,\nYou must select Punisher for\nall of your powers!"
	.align 2
.LC458:
	.string	"To be an Assassin,\nYou must select Assassin for\nall of your powers!"
	.align 2
.LC459:
	.string	"To use a triple power,\nYou must select that power for\nall of your powers!"
	.align 2
.LC460:
	.string	"You have selected powers\nThat have been banned on\nThis server!\nThey are marked with a *\n"
	.align 2
.LC461:
	.string	"You have selected a combo\nThat has been banned on\nThis server!\nIt is marked with a *\n"
	.align 2
.LC462:
	.string	"%s becomes a player\n"
	.align 2
.LC463:
	.string	"You are already a player!\n"
	.align 2
.LC464:
	.string	"You must select your powers first!\nUse INS DEL HOME END PGUP PGDN\nto cycle through the powers.\n"
	.align 2
.LC465:
	.long 0x3f800000
	.align 2
.LC466:
	.long 0x0
	.section	".text"
	.align 2
	.globl MakePlayer
	.type	 MakePlayer,@function
MakePlayer:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,playerlock@ha
	lis 7,.LC465@ha
	lwz 11,playerlock@l(9)
	la 7,.LC465@l(7)
	mr 31,3
	lfs 13,0(7)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L1332
	lis 9,gi+8@ha
	lis 5,.LC452@ha
	lwz 0,gi+8@l(9)
	la 5,.LC452@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1331
.L1332:
	lwz 9,84(31)
	lwz 8,1804(9)
	mr 11,9
	cmpwi 0,8,0
	bc 12,2,.L1334
	lwz 9,1808(11)
	cmpwi 0,9,0
	bc 12,2,.L1334
	lwz 10,1812(11)
	cmpwi 0,10,0
	bc 12,2,.L1334
	lwz 0,264(31)
	andi. 7,0,8192
	bc 12,2,.L1372
	cmpwi 0,8,-1
	bc 12,2,.L1373
	cmpwi 0,9,-1
	bc 12,2,.L1337
	cmpwi 0,10,-1
	bc 4,2,.L1335
	b .L1337
.L1373:
	cmpwi 0,9,-1
	bc 4,2,.L1337
	cmpwi 0,10,-1
	bc 12,2,.L1335
.L1337:
	lis 9,gi+12@ha
	lis 4,.LC453@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC453@l(4)
	b .L1379
.L1335:
	lwz 0,1804(11)
	cmpwi 0,0,-4
	bc 12,2,.L1374
	lwz 0,1808(11)
	cmpwi 0,0,-4
	bc 12,2,.L1340
	lwz 0,1812(11)
	cmpwi 0,0,-4
	bc 4,2,.L1338
	b .L1340
.L1374:
	lwz 0,1808(11)
	cmpwi 0,0,-4
	bc 4,2,.L1340
	lwz 0,1812(11)
	cmpwi 0,0,-4
	bc 12,2,.L1338
.L1340:
	lis 9,gi+12@ha
	lis 4,.LC454@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC454@l(4)
	b .L1379
.L1338:
	lwz 0,1804(11)
	cmpwi 0,0,-3
	bc 12,2,.L1375
	lwz 0,1808(11)
	cmpwi 0,0,-3
	bc 12,2,.L1343
	lwz 0,1812(11)
	cmpwi 0,0,-3
	bc 4,2,.L1341
	b .L1343
.L1375:
	lwz 0,1808(11)
	cmpwi 0,0,-3
	bc 4,2,.L1343
	lwz 0,1812(11)
	cmpwi 0,0,-3
	bc 12,2,.L1341
.L1343:
	lis 9,gi+12@ha
	lis 4,.LC455@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC455@l(4)
	b .L1379
.L1341:
	lwz 0,1804(11)
	cmpwi 0,0,-2
	bc 12,2,.L1376
	lwz 0,1808(11)
	cmpwi 0,0,-2
	bc 12,2,.L1346
	lwz 0,1812(11)
	cmpwi 0,0,-2
	bc 4,2,.L1344
	b .L1346
.L1376:
	lwz 0,1808(11)
	cmpwi 0,0,-2
	bc 4,2,.L1346
	lwz 0,1812(11)
	cmpwi 0,0,-2
	bc 12,2,.L1344
.L1346:
	lis 9,gi+12@ha
	lis 4,.LC456@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC456@l(4)
	b .L1379
.L1344:
	lwz 0,1804(11)
	cmpwi 0,0,-5
	bc 12,2,.L1377
	lwz 0,1808(11)
	cmpwi 0,0,-5
	bc 12,2,.L1349
	lwz 0,1812(11)
	cmpwi 0,0,-5
	bc 4,2,.L1347
	b .L1349
.L1377:
	lwz 0,1808(11)
	cmpwi 0,0,-5
	bc 4,2,.L1349
	lwz 0,1812(11)
	cmpwi 0,0,-5
	bc 12,2,.L1347
.L1349:
	lis 9,gi+12@ha
	lis 4,.LC457@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC457@l(4)
	b .L1379
.L1347:
	lwz 0,1804(11)
	cmpwi 0,0,-6
	bc 12,2,.L1378
	lwz 0,1808(11)
	cmpwi 0,0,-6
	bc 12,2,.L1352
	lwz 0,1812(11)
	cmpwi 0,0,-6
	bc 4,2,.L1350
	b .L1352
.L1378:
	lwz 0,1808(11)
	cmpwi 0,0,-6
	bc 4,2,.L1352
	lwz 0,1812(11)
	cmpwi 0,0,-6
	bc 12,2,.L1350
.L1352:
	lis 9,gi+12@ha
	lis 4,.LC458@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC458@l(4)
	b .L1379
.L1350:
	lwz 10,1804(11)
	cmpwi 0,10,0
	bc 12,0,.L1354
	lwz 7,1808(11)
	cmpwi 0,7,0
	bc 12,0,.L1354
	lwz 6,1812(11)
	cmpwi 0,6,0
	bc 4,0,.L1353
.L1354:
	lwz 0,1816(11)
	cmpwi 0,0,0
	bc 4,2,.L1355
	lis 9,gi+12@ha
	lis 4,.LC459@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC459@l(4)
	b .L1379
.L1353:
	lwz 0,1816(11)
	cmpwi 0,0,0
	bc 4,2,.L1355
	lis 11,game@ha
	slwi 10,10,2
	la 8,game@l(11)
	addi 9,8,1564
	lwzx 0,9,10
	cmpwi 0,0,1
	bc 12,2,.L1357
	slwi 0,7,2
	addi 9,8,1656
	lwzx 11,9,0
	cmpwi 0,11,1
	bc 12,2,.L1357
	slwi 0,6,2
	addi 9,8,1732
	lwzx 11,9,0
	cmpwi 0,11,1
	bc 4,2,.L1358
.L1357:
	lis 9,gi+12@ha
	lis 4,.LC460@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC460@l(4)
	b .L1379
.L1355:
	lwz 0,1816(11)
	lis 9,game@ha
	la 9,game@l(9)
	slwi 0,0,2
	addi 9,9,1808
	lwzx 11,9,0
	cmpwi 0,11,1
	bc 4,2,.L1358
	lis 9,gi+12@ha
	lis 4,.LC461@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC461@l(4)
	b .L1379
.L1358:
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,23
	bc 4,2,.L1360
	lwz 0,264(31)
	oris 0,0,0x80
	b .L1380
.L1360:
	lwz 0,264(31)
	rlwinm 0,0,0,9,7
.L1380:
	stw 0,264(31)
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,19
	bc 4,2,.L1362
	lwz 0,264(31)
	oris 0,0,0x100
	b .L1381
.L1362:
	lwz 0,264(31)
	rlwinm 0,0,0,8,6
.L1381:
	stw 0,264(31)
	lwz 9,84(31)
	lwz 0,1812(9)
	cmpwi 0,0,19
	bc 4,2,.L1364
	lwz 0,264(31)
	oris 0,0,0x200
	b .L1382
.L1364:
	lwz 0,264(31)
	rlwinm 0,0,0,7,5
.L1382:
	stw 0,264(31)
	lwz 0,264(31)
	andis. 7,0,0xc00
	bc 4,2,.L1366
	lis 9,.LC466@ha
	lis 11,ctf@ha
	la 9,.LC466@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L1366
	mr 3,31
	bl CTFSetTeam
.L1366:
	lwz 0,264(31)
	lis 9,gi@ha
	lis 4,.LC462@ha
	lwz 5,84(31)
	la 4,.LC462@l(4)
	li 3,2
	rlwinm 0,0,0,19,17
	rlwinm 0,0,0,27,25
	addi 5,5,700
	stw 0,264(31)
	lwz 0,gi@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl PutClientInServer
	lwz 9,84(31)
	lwz 11,1812(9)
	addi 0,11,-2
	cmplwi 0,0,1
	bc 4,1,.L1368
	lwz 0,1808(9)
	cmpwi 0,0,-2
	bc 12,2,.L1368
	cmpwi 0,11,4
	bc 4,2,.L1331
.L1368:
	mr 3,31
	bl spawn_angel
	b .L1331
.L1334:
	lwz 0,264(31)
	andi. 7,0,8192
	bc 4,2,.L1370
.L1372:
	lis 9,gi+12@ha
	lis 4,.LC463@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC463@l(4)
.L1379:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1331
.L1370:
	lis 9,gi+12@ha
	lis 4,.LC464@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC464@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L1331:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe38:
	.size	 MakePlayer,.Lfe38-MakePlayer
	.section	".rodata"
	.align 2
.LC467:
	.string	"Judgment Day"
	.align 2
.LC468:
	.string	"Terror from the Deep"
	.align 2
.LC469:
	.string	"Tides of Darkness"
	.align 2
.LC470:
	.string	"First Blood Part II"
	.align 2
.LC471:
	.string	"Battle at Antares"
	.align 2
.LC472:
	.string	"The Wrath of Khan"
	.align 2
.LC473:
	.string	"Freddy's Revenge"
	.align 2
.LC474:
	.string	"The Second Story"
	.align 2
.LC475:
	.string	"The Empire Strikes Back"
	.align 2
.LC476:
	.string	"On The Rocks"
	.align 2
.LC477:
	.string	"Electric Boogaloo"
	.align 2
.LC478:
	.string	"Die Harder"
	.align 2
.LC479:
	.string	"The New Batch"
	.align 2
.LC480:
	.string	"Lost in New York"
	.align 2
.LC481:
	.string	"The Road Warrior"
	.align 2
.LC482:
	.string	"The Smell of Fear"
	.align 2
.LC483:
	.string	"Back in the Habit"
	.align 2
.LC484:
	.string	"Their First Assignment"
	.align 2
.LC485:
	.string	"When Nature Calls"
	.align 2
.LC486:
	.string	"Dead By Dawn"
	.align 2
.LC487:
	.string	"Vengeance of the Kilrathi"
	.align 2
.LC488:
	.string	"Jews in Space"
	.align 2
.LC489:
	.string	"The Search for More Money"
	.section	".text"
	.align 2
	.globl GetSub
	.type	 GetSub,@function
GetSub:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 3,0
	bl time
	bl srand
	bl rand
	lis 0,0xb216
	srawi 11,3,31
	ori 0,0,17097
	mulhw 0,3,0
	add 0,0,3
	srawi 0,0,4
	subf 0,11,0
	mulli 9,0,23
	subf. 0,9,3
	bc 4,2,.L1384
	lis 3,.LC467@ha
	la 3,.LC467@l(3)
	b .L1383
.L1384:
	cmpwi 0,0,1
	bc 4,2,.L1386
	lis 3,.LC468@ha
	la 3,.LC468@l(3)
	b .L1383
.L1386:
	cmpwi 0,0,2
	bc 4,2,.L1388
	lis 3,.LC469@ha
	la 3,.LC469@l(3)
	b .L1383
.L1388:
	cmpwi 0,0,3
	bc 4,2,.L1390
	lis 3,.LC470@ha
	la 3,.LC470@l(3)
	b .L1383
.L1390:
	cmpwi 0,0,4
	bc 4,2,.L1392
	lis 3,.LC471@ha
	la 3,.LC471@l(3)
	b .L1383
.L1392:
	cmpwi 0,0,5
	bc 4,2,.L1394
	lis 3,.LC472@ha
	la 3,.LC472@l(3)
	b .L1383
.L1394:
	cmpwi 0,0,6
	bc 4,2,.L1396
	lis 3,.LC473@ha
	la 3,.LC473@l(3)
	b .L1383
.L1396:
	cmpwi 0,0,7
	bc 4,2,.L1398
	lis 3,.LC474@ha
	la 3,.LC474@l(3)
	b .L1383
.L1398:
	cmpwi 0,0,8
	bc 4,2,.L1400
	lis 3,.LC475@ha
	la 3,.LC475@l(3)
	b .L1383
.L1400:
	cmpwi 0,0,9
	bc 4,2,.L1402
	lis 3,.LC476@ha
	la 3,.LC476@l(3)
	b .L1383
.L1402:
	cmpwi 0,0,10
	bc 4,2,.L1404
	lis 3,.LC477@ha
	la 3,.LC477@l(3)
	b .L1383
.L1404:
	cmpwi 0,0,11
	bc 4,2,.L1406
	lis 3,.LC478@ha
	la 3,.LC478@l(3)
	b .L1383
.L1406:
	cmpwi 0,0,12
	bc 4,2,.L1408
	lis 3,.LC479@ha
	la 3,.LC479@l(3)
	b .L1383
.L1408:
	cmpwi 0,0,13
	bc 4,2,.L1410
	lis 3,.LC480@ha
	la 3,.LC480@l(3)
	b .L1383
.L1410:
	cmpwi 0,0,14
	bc 4,2,.L1412
	lis 3,.LC481@ha
	la 3,.LC481@l(3)
	b .L1383
.L1412:
	cmpwi 0,0,15
	bc 4,2,.L1414
	lis 3,.LC482@ha
	la 3,.LC482@l(3)
	b .L1383
.L1414:
	cmpwi 0,0,16
	bc 4,2,.L1416
	lis 3,.LC483@ha
	la 3,.LC483@l(3)
	b .L1383
.L1416:
	cmpwi 0,0,17
	bc 4,2,.L1418
	lis 3,.LC484@ha
	la 3,.LC484@l(3)
	b .L1383
.L1418:
	cmpwi 0,0,18
	bc 4,2,.L1420
	lis 3,.LC485@ha
	la 3,.LC485@l(3)
	b .L1383
.L1420:
	cmpwi 0,0,19
	bc 4,2,.L1422
	lis 3,.LC486@ha
	la 3,.LC486@l(3)
	b .L1383
.L1422:
	cmpwi 0,0,20
	bc 4,2,.L1424
	lis 3,.LC487@ha
	la 3,.LC487@l(3)
	b .L1383
.L1424:
	cmpwi 0,0,21
	bc 4,2,.L1426
	lis 3,.LC488@ha
	la 3,.LC488@l(3)
	b .L1383
.L1426:
	cmpwi 0,0,22
	bc 4,2,.L1383
	lis 3,.LC489@ha
	la 3,.LC489@l(3)
.L1383:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe39:
	.size	 GetSub,.Lfe39-GetSub
	.section	".rodata"
	.align 2
.LC490:
	.string	"i_fixme"
	.align 2
.LC491:
	.string	"tp_mortal"
	.align 2
.LC492:
	.string	"tp_robot"
	.align 2
.LC493:
	.string	"tp_cripple"
	.align 2
.LC494:
	.string	"tp_archmage"
	.align 2
.LC495:
	.string	"tp_punisher"
	.align 2
.LC496:
	.string	"tp_assassin"
	.align 2
.LC497:
	.string	"tp_taft"
	.align 2
.LC498:
	.string	"tp_jedi2"
	.align 2
.LC499:
	.string	"tp_jedi1"
	.align 2
.LC500:
	.string	"tp_sun"
	.align 2
.LC501:
	.string	"ap_flameball"
	.align 2
.LC502:
	.string	"ap_kineticthrow"
	.align 2
.LC503:
	.string	"ap_freeze"
	.align 2
.LC504:
	.string	"ap_deathblow"
	.align 2
.LC505:
	.string	"ap_teleport"
	.align 2
.LC506:
	.string	"ap_beacon"
	.align 2
.LC507:
	.string	"ap_cards"
	.align 2
.LC508:
	.string	"ap_banshee"
	.align 2
.LC509:
	.string	"ap_gravity"
	.align 2
.LC510:
	.string	"ap_ants"
	.align 2
.LC511:
	.string	"ap_psionic"
	.align 2
.LC512:
	.string	"ap_optic"
	.align 2
.LC513:
	.string	"ap_lightsaber"
	.align 2
.LC514:
	.string	"ap_claw"
	.align 2
.LC515:
	.string	"ap_poweranchor"
	.align 2
.LC516:
	.string	"ap_blackhole"
	.align 2
.LC517:
	.string	"ap_flamecascade"
	.align 2
.LC518:
	.string	"ap_grenswarm"
	.align 2
.LC519:
	.string	"ap_impulse9"
	.align 2
.LC520:
	.string	"ap_prox"
	.align 2
.LC521:
	.string	"ap_blind"
	.align 2
.LC522:
	.string	"ap_weird"
	.align 2
.LC523:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl active_icon
	.type	 active_icon,@function
active_icon:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,2,.L1431
	lis 9,gi+40@ha
	lis 3,.LC490@ha
	lwz 0,gi+40@l(9)
	la 3,.LC490@l(3)
	b .L1499
.L1431:
	cmpwi 0,0,-1
	bc 4,2,.L1433
	lis 9,gi+40@ha
	lis 3,.LC491@ha
	lwz 0,gi+40@l(9)
	la 3,.LC491@l(3)
	b .L1499
.L1433:
	cmpwi 0,0,-4
	bc 4,2,.L1435
	lis 9,gi+40@ha
	lis 3,.LC492@ha
	lwz 0,gi+40@l(9)
	la 3,.LC492@l(3)
	b .L1499
.L1435:
	cmpwi 0,0,-3
	bc 4,2,.L1437
	lis 9,gi+40@ha
	lis 3,.LC493@ha
	lwz 0,gi+40@l(9)
	la 3,.LC493@l(3)
	b .L1499
.L1437:
	cmpwi 0,0,-2
	bc 4,2,.L1439
	lis 9,gi+40@ha
	lis 3,.LC494@ha
	lwz 0,gi+40@l(9)
	la 3,.LC494@l(3)
	b .L1499
.L1439:
	cmpwi 0,0,-5
	bc 4,2,.L1441
	lis 9,gi+40@ha
	lis 3,.LC495@ha
	lwz 0,gi+40@l(9)
	la 3,.LC495@l(3)
	b .L1499
.L1441:
	cmpwi 0,0,-6
	bc 4,2,.L1443
	lis 9,gi+40@ha
	lis 3,.LC496@ha
	lwz 0,gi+40@l(9)
	la 3,.LC496@l(3)
	b .L1499
.L1443:
	cmpwi 0,0,-7
	bc 4,2,.L1445
	lis 9,gi+40@ha
	lis 3,.LC497@ha
	lwz 0,gi+40@l(9)
	la 3,.LC497@l(3)
	b .L1499
.L1445:
	cmpwi 0,0,-8
	bc 4,2,.L1449
	lis 9,.LC523@ha
	lfs 13,592(3)
	la 9,.LC523@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L1447
	lis 9,gi+40@ha
	lis 3,.LC498@ha
	lwz 0,gi+40@l(9)
	la 3,.LC498@l(3)
	b .L1499
.L1447:
	lis 9,gi+40@ha
	lis 3,.LC499@ha
	lwz 0,gi+40@l(9)
	la 3,.LC499@l(3)
	b .L1499
.L1449:
	cmpwi 0,0,-10
	bc 4,2,.L1451
	lis 9,gi+40@ha
	lis 3,.LC500@ha
	lwz 0,gi+40@l(9)
	la 3,.LC500@l(3)
	b .L1499
.L1451:
	cmpwi 0,0,6
	bc 4,2,.L1453
	lis 9,gi+40@ha
	lis 3,.LC501@ha
	lwz 0,gi+40@l(9)
	la 3,.LC501@l(3)
	b .L1499
.L1453:
	cmpwi 0,0,12
	bc 4,2,.L1455
	lis 9,gi+40@ha
	lis 3,.LC502@ha
	lwz 0,gi+40@l(9)
	la 3,.LC502@l(3)
	b .L1499
.L1455:
	cmpwi 0,0,8
	bc 4,2,.L1457
	lis 9,gi+40@ha
	lis 3,.LC503@ha
	lwz 0,gi+40@l(9)
	la 3,.LC503@l(3)
	b .L1499
.L1457:
	cmpwi 0,0,5
	bc 4,2,.L1459
	lis 9,gi+40@ha
	lis 3,.LC504@ha
	lwz 0,gi+40@l(9)
	la 3,.LC504@l(3)
	b .L1499
.L1459:
	cmpwi 0,0,20
	bc 4,2,.L1461
	lis 9,gi+40@ha
	lis 3,.LC505@ha
	lwz 0,gi+40@l(9)
	la 3,.LC505@l(3)
	b .L1499
.L1461:
	cmpwi 0,0,21
	bc 4,2,.L1463
	lis 9,gi+40@ha
	lis 3,.LC506@ha
	lwz 0,gi+40@l(9)
	la 3,.LC506@l(3)
	b .L1499
.L1463:
	cmpwi 0,0,11
	bc 4,2,.L1465
	lis 9,gi+40@ha
	lis 3,.LC507@ha
	lwz 0,gi+40@l(9)
	la 3,.LC507@l(3)
	b .L1499
.L1465:
	cmpwi 0,0,2
	bc 4,2,.L1467
	lis 9,gi+40@ha
	lis 3,.LC508@ha
	lwz 0,gi+40@l(9)
	la 3,.LC508@l(3)
	b .L1499
.L1467:
	cmpwi 0,0,19
	bc 4,2,.L1469
	lis 9,gi+40@ha
	lis 3,.LC509@ha
	lwz 0,gi+40@l(9)
	la 3,.LC509@l(3)
	b .L1499
.L1469:
	cmpwi 0,0,1
	bc 4,2,.L1471
	lis 9,gi+40@ha
	lis 3,.LC510@ha
	lwz 0,gi+40@l(9)
	la 3,.LC510@l(3)
	b .L1499
.L1471:
	cmpwi 0,0,18
	bc 4,2,.L1473
	lis 9,gi+40@ha
	lis 3,.LC511@ha
	lwz 0,gi+40@l(9)
	la 3,.LC511@l(3)
	b .L1499
.L1473:
	cmpwi 0,0,14
	bc 4,2,.L1475
	lis 9,gi+40@ha
	lis 3,.LC512@ha
	lwz 0,gi+40@l(9)
	la 3,.LC512@l(3)
	b .L1499
.L1475:
	cmpwi 0,0,13
	bc 4,2,.L1477
	lis 9,gi+40@ha
	lis 3,.LC513@ha
	lwz 0,gi+40@l(9)
	la 3,.LC513@l(3)
	b .L1499
.L1477:
	cmpwi 0,0,3
	bc 4,2,.L1479
	lis 9,gi+40@ha
	lis 3,.LC514@ha
	lwz 0,gi+40@l(9)
	la 3,.LC514@l(3)
	b .L1499
.L1479:
	cmpwi 0,0,15
	bc 4,2,.L1481
	lis 9,gi+40@ha
	lis 3,.LC515@ha
	lwz 0,gi+40@l(9)
	la 3,.LC515@l(3)
	b .L1499
.L1481:
	cmpwi 0,0,4
	bc 4,2,.L1483
	lis 9,gi+40@ha
	lis 3,.LC516@ha
	lwz 0,gi+40@l(9)
	la 3,.LC516@l(3)
	b .L1499
.L1483:
	cmpwi 0,0,7
	bc 4,2,.L1485
	lis 9,gi+40@ha
	lis 3,.LC517@ha
	lwz 0,gi+40@l(9)
	la 3,.LC517@l(3)
	b .L1499
.L1485:
	cmpwi 0,0,9
	bc 4,2,.L1487
	lis 9,gi+40@ha
	lis 3,.LC518@ha
	lwz 0,gi+40@l(9)
	la 3,.LC518@l(3)
	b .L1499
.L1487:
	cmpwi 0,0,10
	bc 4,2,.L1489
	lis 9,gi+40@ha
	lis 3,.LC519@ha
	lwz 0,gi+40@l(9)
	la 3,.LC519@l(3)
	b .L1499
.L1489:
	cmpwi 0,0,17
	bc 4,2,.L1491
	lis 9,gi+40@ha
	lis 3,.LC520@ha
	lwz 0,gi+40@l(9)
	la 3,.LC520@l(3)
	b .L1499
.L1491:
	cmpwi 0,0,16
	bc 4,2,.L1493
	lis 9,gi+40@ha
	lis 3,.LC521@ha
	lwz 0,gi+40@l(9)
	la 3,.LC521@l(3)
	b .L1499
.L1493:
	cmpwi 0,0,22
	bc 12,2,.L1495
	lis 9,gi+40@ha
	lis 3,.LC490@ha
	lwz 0,gi+40@l(9)
	la 3,.LC490@l(3)
	b .L1499
.L1495:
	lis 9,gi+40@ha
	lis 3,.LC522@ha
	lwz 0,gi+40@l(9)
	la 3,.LC522@l(3)
.L1499:
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe40:
	.size	 active_icon,.Lfe40-active_icon
	.section	".rodata"
	.align 2
.LC524:
	.string	"tiny"
	.align 2
.LC525:
	.string	"pp_boot"
	.align 2
.LC526:
	.string	"pp_elastic"
	.align 2
.LC527:
	.string	"pp_repulsion"
	.align 2
.LC528:
	.string	"pp_immune"
	.align 2
.LC529:
	.string	"pp_regen"
	.align 2
.LC530:
	.string	"pp_radio"
	.align 2
.LC531:
	.string	"pp_forcefield"
	.align 2
.LC532:
	.string	"pp_invis"
	.align 2
.LC533:
	.string	"pp_energy"
	.align 2
.LC534:
	.string	"pp_bullet"
	.align 2
.LC535:
	.string	"pp_prism"
	.align 2
.LC536:
	.string	"pp_lifewell"
	.align 2
.LC537:
	.string	"pp_metalform"
	.align 2
.LC538:
	.string	"pp_superspeed"
	.align 2
.LC539:
	.string	"pp_flying"
	.align 2
.LC540:
	.string	"pp_liquid"
	.align 2
.LC541:
	.string	"pp_hdense"
	.align 2
.LC542:
	.string	"pp_radiance"
	.align 2
.LC543:
	.string	"pp_connect"
	.section	".text"
	.align 2
	.globl passive_icon
	.type	 passive_icon,@function
passive_icon:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,1808(9)
	cmpwi 0,0,0
	bc 4,2,.L1533
	lis 9,gi+40@ha
	lis 3,.LC490@ha
	lwz 0,gi+40@l(9)
	la 3,.LC490@l(3)
	b .L1593
.L1533:
	cmpwi 0,0,-1
	bc 4,2,.L1535
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1593
.L1535:
	cmpwi 0,0,-4
	bc 4,2,.L1537
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1593
.L1537:
	cmpwi 0,0,-3
	bc 4,2,.L1539
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1593
.L1539:
	cmpwi 0,0,-2
	bc 4,2,.L1541
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1593
.L1541:
	cmpwi 0,0,-5
	bc 4,2,.L1543
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1593
.L1543:
	cmpwi 0,0,-6
	bc 4,2,.L1545
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1593
.L1545:
	cmpwi 0,0,-7
	bc 4,2,.L1547
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1593
.L1547:
	cmpwi 0,0,-8
	bc 4,2,.L1549
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1593
.L1549:
	cmpwi 0,0,-10
	bc 4,2,.L1551
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1593
.L1551:
	cmpwi 0,0,1
	bc 4,2,.L1553
	lis 9,gi+40@ha
	lis 3,.LC525@ha
	lwz 0,gi+40@l(9)
	la 3,.LC525@l(3)
	b .L1593
.L1553:
	cmpwi 0,0,3
	bc 4,2,.L1555
	lis 9,gi+40@ha
	lis 3,.LC526@ha
	lwz 0,gi+40@l(9)
	la 3,.LC526@l(3)
	b .L1593
.L1555:
	cmpwi 0,0,17
	bc 4,2,.L1557
	lis 9,gi+40@ha
	lis 3,.LC527@ha
	lwz 0,gi+40@l(9)
	la 3,.LC527@l(3)
	b .L1593
.L1557:
	cmpwi 0,0,9
	bc 4,2,.L1559
	lis 9,gi+40@ha
	lis 3,.LC528@ha
	lwz 0,gi+40@l(9)
	la 3,.LC528@l(3)
	b .L1593
.L1559:
	cmpwi 0,0,16
	bc 4,2,.L1561
	lis 9,gi+40@ha
	lis 3,.LC529@ha
	lwz 0,gi+40@l(9)
	la 3,.LC529@l(3)
	b .L1593
.L1561:
	cmpwi 0,0,15
	bc 4,2,.L1563
	lis 9,gi+40@ha
	lis 3,.LC530@ha
	lwz 0,gi+40@l(9)
	la 3,.LC530@l(3)
	b .L1593
.L1563:
	cmpwi 0,0,6
	bc 4,2,.L1565
	lis 9,gi+40@ha
	lis 3,.LC531@ha
	lwz 0,gi+40@l(9)
	la 3,.LC531@l(3)
	b .L1593
.L1565:
	cmpwi 0,0,10
	bc 4,2,.L1567
	lis 9,gi+40@ha
	lis 3,.LC532@ha
	lwz 0,gi+40@l(9)
	la 3,.LC532@l(3)
	b .L1593
.L1567:
	cmpwi 0,0,4
	bc 4,2,.L1569
	lis 9,gi+40@ha
	lis 3,.LC533@ha
	lwz 0,gi+40@l(9)
	la 3,.LC533@l(3)
	b .L1593
.L1569:
	cmpwi 0,0,2
	bc 4,2,.L1571
	lis 9,gi+40@ha
	lis 3,.LC534@ha
	lwz 0,gi+40@l(9)
	la 3,.LC534@l(3)
	b .L1593
.L1571:
	cmpwi 0,0,14
	bc 4,2,.L1573
	lis 9,gi+40@ha
	lis 3,.LC535@ha
	lwz 0,gi+40@l(9)
	la 3,.LC535@l(3)
	b .L1593
.L1573:
	cmpwi 0,0,11
	bc 4,2,.L1575
	lis 9,gi+40@ha
	lis 3,.LC536@ha
	lwz 0,gi+40@l(9)
	la 3,.LC536@l(3)
	b .L1593
.L1575:
	cmpwi 0,0,13
	bc 4,2,.L1577
	lis 9,gi+40@ha
	lis 3,.LC537@ha
	lwz 0,gi+40@l(9)
	la 3,.LC537@l(3)
	b .L1593
.L1577:
	cmpwi 0,0,18
	bc 4,2,.L1579
	lis 9,gi+40@ha
	lis 3,.LC538@ha
	lwz 0,gi+40@l(9)
	la 3,.LC538@l(3)
	b .L1593
.L1579:
	cmpwi 0,0,5
	bc 4,2,.L1581
	lis 9,gi+40@ha
	lis 3,.LC539@ha
	lwz 0,gi+40@l(9)
	la 3,.LC539@l(3)
	b .L1593
.L1581:
	cmpwi 0,0,12
	bc 4,2,.L1583
	lis 9,gi+40@ha
	lis 3,.LC540@ha
	lwz 0,gi+40@l(9)
	la 3,.LC540@l(3)
	b .L1593
.L1583:
	cmpwi 0,0,8
	bc 4,2,.L1585
	lis 9,gi+40@ha
	lis 3,.LC541@ha
	lwz 0,gi+40@l(9)
	la 3,.LC541@l(3)
	b .L1593
.L1585:
	cmpwi 0,0,20
	bc 4,2,.L1587
	lis 9,gi+40@ha
	lis 3,.LC542@ha
	lwz 0,gi+40@l(9)
	la 3,.LC542@l(3)
	b .L1593
.L1587:
	cmpwi 0,0,7
	bc 12,2,.L1589
	lis 9,gi+40@ha
	lis 3,.LC490@ha
	lwz 0,gi+40@l(9)
	la 3,.LC490@l(3)
	b .L1593
.L1589:
	lis 9,gi+40@ha
	lis 3,.LC543@ha
	lwz 0,gi+40@l(9)
	la 3,.LC543@l(3)
.L1593:
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe41:
	.size	 passive_icon,.Lfe41-passive_icon
	.section	".rodata"
	.align 2
.LC544:
	.string	"sp_haste"
	.align 2
.LC545:
	.string	"sp_superjump"
	.align 2
.LC546:
	.string	"sp_invisshots"
	.align 2
.LC547:
	.string	"sp_fastproj"
	.align 2
.LC548:
	.string	"sp_vampiric"
	.align 2
.LC549:
	.string	"sp_ammouse"
	.align 2
.LC550:
	.string	"sp_piercing"
	.align 2
.LC551:
	.string	"sp_electric"
	.align 2
.LC552:
	.string	"sp_sniper"
	.align 2
.LC553:
	.string	"sp_aggravated"
	.align 2
.LC554:
	.string	"sp_rage"
	.align 2
.LC555:
	.string	"sp_angeldeath"
	.align 2
.LC556:
	.string	"sp_angellife"
	.align 2
.LC557:
	.string	"sp_angelmercy"
	.align 2
.LC558:
	.string	"sp_deathblossom"
	.align 2
.LC559:
	.string	"sp_luck"
	.align 2
.LC560:
	.string	"sp_strength"
	.align 2
.LC561:
	.string	"sp_funk"
	.section	".text"
	.align 2
	.globl special_icon
	.type	 special_icon,@function
special_icon:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 4,2,.L1623
	lis 9,gi+40@ha
	lis 3,.LC490@ha
	lwz 0,gi+40@l(9)
	la 3,.LC490@l(3)
	b .L1681
.L1623:
	cmpwi 0,0,-1
	bc 4,2,.L1625
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1681
.L1625:
	cmpwi 0,0,-4
	bc 4,2,.L1627
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1681
.L1627:
	cmpwi 0,0,-3
	bc 4,2,.L1629
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1681
.L1629:
	cmpwi 0,0,-2
	bc 4,2,.L1631
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1681
.L1631:
	cmpwi 0,0,-5
	bc 4,2,.L1633
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1681
.L1633:
	cmpwi 0,0,-6
	bc 4,2,.L1635
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1681
.L1635:
	cmpwi 0,0,-7
	bc 4,2,.L1637
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1681
.L1637:
	cmpwi 0,0,-8
	bc 4,2,.L1639
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1681
.L1639:
	cmpwi 0,0,-10
	bc 4,2,.L1641
	lis 9,gi+40@ha
	lis 3,.LC524@ha
	lwz 0,gi+40@l(9)
	la 3,.LC524@l(3)
	b .L1681
.L1641:
	cmpwi 0,0,12
	bc 4,2,.L1643
	lis 9,gi+40@ha
	lis 3,.LC544@ha
	lwz 0,gi+40@l(9)
	la 3,.LC544@l(3)
	b .L1681
.L1643:
	cmpwi 0,0,16
	bc 4,2,.L1645
	lis 9,gi+40@ha
	lis 3,.LC545@ha
	lwz 0,gi+40@l(9)
	la 3,.LC545@l(3)
	b .L1681
.L1645:
	cmpwi 0,0,13
	bc 4,2,.L1647
	lis 9,gi+40@ha
	lis 3,.LC546@ha
	lwz 0,gi+40@l(9)
	la 3,.LC546@l(3)
	b .L1681
.L1647:
	cmpwi 0,0,9
	bc 4,2,.L1649
	lis 9,gi+40@ha
	lis 3,.LC547@ha
	lwz 0,gi+40@l(9)
	la 3,.LC547@l(3)
	b .L1681
.L1649:
	cmpwi 0,0,18
	bc 4,2,.L1651
	lis 9,gi+40@ha
	lis 3,.LC548@ha
	lwz 0,gi+40@l(9)
	la 3,.LC548@l(3)
	b .L1681
.L1651:
	cmpwi 0,0,14
	bc 4,2,.L1653
	lis 9,gi+40@ha
	lis 3,.LC549@ha
	lwz 0,gi+40@l(9)
	la 3,.LC549@l(3)
	b .L1681
.L1653:
	cmpwi 0,0,5
	bc 4,2,.L1655
	lis 9,gi+40@ha
	lis 3,.LC550@ha
	lwz 0,gi+40@l(9)
	la 3,.LC550@l(3)
	b .L1681
.L1655:
	cmpwi 0,0,8
	bc 4,2,.L1657
	lis 9,gi+40@ha
	lis 3,.LC551@ha
	lwz 0,gi+40@l(9)
	la 3,.LC551@l(3)
	b .L1681
.L1657:
	cmpwi 0,0,15
	bc 4,2,.L1659
	lis 9,gi+40@ha
	lis 3,.LC552@ha
	lwz 0,gi+40@l(9)
	la 3,.LC552@l(3)
	b .L1681
.L1659:
	cmpwi 0,0,1
	bc 4,2,.L1661
	lis 9,gi+40@ha
	lis 3,.LC553@ha
	lwz 0,gi+40@l(9)
	la 3,.LC553@l(3)
	b .L1681
.L1661:
	cmpwi 0,0,6
	bc 4,2,.L1663
	lis 9,gi+40@ha
	lis 3,.LC554@ha
	lwz 0,gi+40@l(9)
	la 3,.LC554@l(3)
	b .L1681
.L1663:
	cmpwi 0,0,2
	bc 4,2,.L1665
	lis 9,gi+40@ha
	lis 3,.LC555@ha
	lwz 0,gi+40@l(9)
	la 3,.LC555@l(3)
	b .L1681
.L1665:
	cmpwi 0,0,3
	bc 4,2,.L1667
	lis 9,gi+40@ha
	lis 3,.LC556@ha
	lwz 0,gi+40@l(9)
	la 3,.LC556@l(3)
	b .L1681
.L1667:
	cmpwi 0,0,4
	bc 4,2,.L1669
	lis 9,gi+40@ha
	lis 3,.LC557@ha
	lwz 0,gi+40@l(9)
	la 3,.LC557@l(3)
	b .L1681
.L1669:
	cmpwi 0,0,11
	bc 4,2,.L1671
	lis 9,gi+40@ha
	lis 3,.LC558@ha
	lwz 0,gi+40@l(9)
	la 3,.LC558@l(3)
	b .L1681
.L1671:
	cmpwi 0,0,7
	bc 4,2,.L1673
	lis 9,gi+40@ha
	lis 3,.LC559@ha
	lwz 0,gi+40@l(9)
	la 3,.LC559@l(3)
	b .L1681
.L1673:
	cmpwi 0,0,17
	bc 4,2,.L1675
	lis 9,gi+40@ha
	lis 3,.LC560@ha
	lwz 0,gi+40@l(9)
	la 3,.LC560@l(3)
	b .L1681
.L1675:
	cmpwi 0,0,10
	bc 12,2,.L1677
	lis 9,gi+40@ha
	lis 3,.LC490@ha
	lwz 0,gi+40@l(9)
	la 3,.LC490@l(3)
	b .L1681
.L1677:
	lis 9,gi+40@ha
	lis 3,.LC561@ha
	lwz 0,gi+40@l(9)
	la 3,.LC561@l(3)
.L1681:
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe42:
	.size	 special_icon,.Lfe42-special_icon
	.comm	v_forward,12,4
	.comm	v_right,12,4
	.comm	v_up,12,4
	.comm	invis_index,4,4
	.comm	cripple_index,4,4
	.comm	robot_index,4,4
	.comm	sun_index,4,4
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
.L1709:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L51
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L51
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 12,2,.L51
	stw 11,736(8)
	blr
.L51:
	addi 7,7,1
	bdnz .L1709
	li 0,-1
	stw 0,736(8)
	blr
.Lfe43:
	.size	 ValidateSelectedItem,.Lfe43-ValidateSelectedItem
	.align 2
	.globl MakeObserver
	.type	 MakeObserver,@function
MakeObserver:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 9,gi@ha
	lwz 0,264(31)
	lis 4,.LC451@ha
	li 3,2
	lwz 5,84(31)
	la 4,.LC451@l(4)
	ori 0,0,8224
	stw 0,264(31)
	addi 5,5,700
	lwz 0,gi@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl CTFDrop_Flag
	lwz 3,560(31)
	cmpwi 0,3,0
	bc 12,2,.L1326
	bl G_FreeEdict
	li 0,0
	stw 0,560(31)
.L1326:
	lwz 3,892(31)
	cmpwi 0,3,0
	bc 12,2,.L1327
	bl G_FreeEdict
	li 0,0
	stw 0,892(31)
.L1327:
	lwz 0,264(31)
	andis. 9,0,128
	bc 12,2,.L1328
	lwz 11,84(31)
	li 9,23
	stw 9,1804(11)
	lwz 0,264(31)
	rlwinm 0,0,0,9,7
	stw 0,264(31)
.L1328:
	lwz 0,264(31)
	andis. 9,0,256
	bc 12,2,.L1329
	lwz 11,84(31)
	li 9,19
	stw 9,1808(11)
	lwz 0,264(31)
	rlwinm 0,0,0,8,6
	stw 0,264(31)
.L1329:
	lwz 0,264(31)
	andis. 9,0,512
	bc 12,2,.L1330
	lwz 11,84(31)
	li 9,19
	stw 9,1812(11)
	lwz 0,264(31)
	rlwinm 0,0,0,7,5
	stw 0,264(31)
.L1330:
	mr 3,31
	bl PutClientInServer
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe44:
	.size	 MakeObserver,.Lfe44-MakeObserver
	.section	".rodata"
	.align 3
.LC562:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC563:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC564:
	.long 0x42a00000
	.section	".text"
	.align 2
	.globl blast_fire
	.type	 blast_fire,@function
blast_fire:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 29,4
	mr 31,3
	mr 26,5
	mr 27,6
	bl G_Spawn
	lfs 0,0(29)
	mr 28,3
	lis 11,0x600
	li 0,0
	ori 11,11,3
	li 8,0
	lis 7,level+4@ha
	stfs 0,4(28)
	lis 9,.LC562@ha
	lis 10,G_FreeEdict@ha
	lfs 0,4(29)
	la 10,G_FreeEdict@l(10)
	lfd 13,.LC562@l(9)
	lis 9,gi@ha
	stfs 0,8(28)
	la 30,gi@l(9)
	lfs 0,8(29)
	stw 0,200(28)
	stw 0,196(28)
	stw 0,192(28)
	stw 0,188(28)
	stw 0,208(28)
	stw 0,204(28)
	stw 8,260(28)
	stfs 0,12(28)
	stw 11,252(28)
	stw 31,256(28)
	lfs 0,level+4@l(7)
	stw 10,436(28)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(28)
	lwz 9,72(30)
	mtlr 9
	blrl
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L886
	mr 4,29
	mr 3,31
	li 5,2
	bl PlayerNoise
.L886:
	xoris 0,26,0x8000
	stw 0,20(1)
	lis 11,0x4330
	lis 10,.LC563@ha
	stw 11,16(1)
	la 10,.LC563@l(10)
	mr 3,28
	lfd 1,16(1)
	mr 4,31
	mr 5,31
	lfd 0,0(10)
	lis 9,.LC564@ha
	li 6,128
	la 9,.LC564@l(9)
	mr 7,27
	lfs 2,0(9)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
	cmpwi 0,27,34
	bc 4,2,.L887
	lwz 9,100(30)
	li 3,3
	mtlr 9
	blrl
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L888
	lwz 0,100(30)
	li 3,17
	mtlr 0
	blrl
	b .L889
.L888:
	lwz 0,100(30)
	li 3,7
	mtlr 0
	blrl
.L889:
	lis 29,gi@ha
	addi 28,28,4
	la 29,gi@l(29)
	mr 3,28
	lwz 9,120(29)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
.L887:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe45:
	.size	 blast_fire,.Lfe45-blast_fire
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
	bc 12,2,.L1711
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
	bc 12,2,.L1711
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L9
	addi 3,3,1
	b .L1710
.L9:
	stb 30,0(3)
.L1711:
	mr 3,31
.L1710:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe46:
	.size	 ClientTeam,.Lfe46-ClientTeam
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
.L1712:
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
	bc 12,2,.L30
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L30
	lwz 0,56(10)
	and. 9,0,4
	bc 12,2,.L30
	stw 11,736(8)
	blr
.L30:
	addi 7,7,1
	bdnz .L1712
	li 0,-1
	stw 0,736(8)
	blr
.Lfe47:
	.size	 SelectNextItem,.Lfe47-SelectNextItem
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
	addi 6,8,740
.L1713:
	lwz 11,736(8)
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
	bc 12,2,.L39
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L39
	lwz 0,56(10)
	and. 9,0,4
	bc 12,2,.L39
	stw 11,736(8)
	blr
.L39:
	addi 7,7,1
	bdnz .L1713
	li 0,-1
	stw 0,736(8)
	blr
.Lfe48:
	.size	 SelectPrevItem,.Lfe48-SelectPrevItem
	.section	".rodata"
	.align 2
.LC565:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC565@ha
	lis 9,deathmatch@ha
	la 11,.LC565@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L110
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L110
	lis 9,gi+8@ha
	lis 5,.LC2@ha
	lwz 0,gi+8@l(9)
	la 5,.LC2@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L109
.L110:
	lwz 0,264(3)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(3)
	bc 4,2,.L111
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
	b .L112
.L111:
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
.L112:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L109:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe49:
	.size	 Cmd_God_f,.Lfe49-Cmd_God_f
	.section	".rodata"
	.align 2
.LC566:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC566@ha
	lis 9,deathmatch@ha
	la 11,.LC566@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L114
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L114
	lis 9,gi+8@ha
	lis 5,.LC2@ha
	lwz 0,gi+8@l(9)
	la 5,.LC2@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L113
.L114:
	lwz 0,264(3)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(3)
	bc 4,2,.L115
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
	b .L116
.L115:
	lis 9,.LC18@ha
	la 5,.LC18@l(9)
.L116:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L113:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe50:
	.size	 Cmd_Notarget_f,.Lfe50-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC567:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC567@ha
	lis 9,deathmatch@ha
	la 11,.LC567@l(11)
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
	lis 5,.LC2@ha
	lwz 0,gi+8@l(9)
	la 5,.LC2@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L117
.L118:
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 4,2,.L119
	li 0,4
	lis 9,.LC19@ha
	stw 0,260(3)
	la 5,.LC19@l(9)
	b .L120
.L119:
	li 0,1
	lis 9,.LC20@ha
	stw 0,260(3)
	la 5,.LC20@l(9)
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
.Lfe51:
	.size	 Cmd_Noclip_f,.Lfe51-Cmd_Noclip_f
	.align 2
	.globl Cmd_Inven_f
	.type	 Cmd_Inven_f,@function
Cmd_Inven_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	li 9,0
	lwz 31,84(28)
	lwz 0,3556(31)
	stw 9,3552(31)
	cmpwi 0,0,0
	stw 9,3560(31)
	bc 12,2,.L136
	stw 9,3556(31)
	b .L135
.L136:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3556(31)
	li 3,5
	lwz 0,100(9)
	addi 30,31,1760
	mr 29,9
	addi 31,31,740
	mtlr 0
	blrl
.L140:
	lwz 9,104(29)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,30
	bc 4,1,.L140
	lis 9,gi+92@ha
	mr 3,28
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L135:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe52:
	.size	 Cmd_Inven_f,.Lfe52-Cmd_Inven_f
	.align 2
	.globl Cmd_WeapPrev_f
	.type	 Cmd_WeapPrev_f,@function
Cmd_WeapPrev_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 28,3
	lwz 0,264(28)
	andi. 9,0,8192
	bc 4,2,.L160
	lwz 29,84(28)
	lwz 11,1788(29)
	cmpwi 0,11,0
	bc 12,2,.L160
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
.L166:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L165
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L165
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L165
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L160
.L165:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L166
.L160:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe53:
	.size	 Cmd_WeapPrev_f,.Lfe53-Cmd_WeapPrev_f
	.align 2
	.globl Cmd_WeapNext_f
	.type	 Cmd_WeapNext_f,@function
Cmd_WeapNext_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 27,3
	lwz 0,264(27)
	andi. 9,0,8192
	bc 4,2,.L172
	lwz 29,84(27)
	lwz 11,1788(29)
	cmpwi 0,11,0
	bc 12,2,.L172
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
.L178:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L177
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L177
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L177
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L172
.L177:
	addi 28,28,1
	addi 30,30,-1
	cmpwi 0,28,256
	bc 4,1,.L178
.L172:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe54:
	.size	 Cmd_WeapNext_f,.Lfe54-Cmd_WeapNext_f
	.align 2
	.globl Cmd_WeapLast_f
	.type	 Cmd_WeapLast_f,@function
Cmd_WeapLast_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,264(3)
	andi. 9,0,8192
	bc 4,2,.L184
	lwz 10,84(3)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L184
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L184
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
	bc 12,2,.L184
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L184
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L184
	mtlr 9
	blrl
.L184:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe55:
	.size	 Cmd_WeapLast_f,.Lfe55-Cmd_WeapLast_f
	.align 2
	.globl Cmd_Kill_f
	.type	 Cmd_Kill_f,@function
Cmd_Kill_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lwz 0,264(9)
	andi. 11,0,8192
	bc 4,2,.L210
	rlwinm 0,0,0,28,26
	stw 11,480(9)
	stw 0,264(9)
	lis 6,0x1
	lis 7,vec3_origin@ha
	lis 9,meansOfDeath@ha
	li 0,23
	stw 0,meansOfDeath@l(9)
	la 7,vec3_origin@l(7)
	mr 4,3
	mr 5,3
	ori 6,6,34464
	bl player_die
.L210:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe56:
	.size	 Cmd_Kill_f,.Lfe56-Cmd_Kill_f
	.align 2
	.globl Cmd_PutAway_f
	.type	 Cmd_PutAway_f,@function
Cmd_PutAway_f:
	lwz 9,84(3)
	li 0,0
	stw 0,3552(9)
	lwz 11,84(3)
	stw 0,3560(11)
	lwz 9,84(3)
	stw 0,3556(9)
	blr
.Lfe57:
	.size	 Cmd_PutAway_f,.Lfe57-Cmd_PutAway_f
	.align 2
	.globl PlayerSort
	.type	 PlayerSort,@function
PlayerSort:
	lwz 9,0(3)
	lis 11,game+1028@ha
	lwz 3,0(4)
	lwz 0,game+1028@l(11)
	mulli 9,9,3804
	mulli 11,3,3804
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
.Lfe58:
	.size	 PlayerSort,.Lfe58-PlayerSort
	.align 2
	.globl boot
	.type	 boot,@function
boot:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lwz 5,84(3)
	lis 9,.LC173@ha
	addi 8,1,8
	la 11,.LC173@l(9)
	lwz 10,.LC173@l(9)
	lwz 9,8(11)
	cmpwi 0,5,0
	lwz 0,4(11)
	stw 10,8(1)
	stw 9,8(8)
	stw 0,4(8)
	bc 12,2,.L670
	lwz 0,1808(5)
	cmpwi 0,0,1
	bc 4,2,.L669
	li 7,52
	li 6,500
	b .L670
.L669:
	cmpwi 0,0,-3
	bc 4,2,.L670
	li 7,53
	li 6,50
.L670:
	fmr 0,1
	stw 4,540(3)
	addi 4,1,8
	fctiwz 13,0
	stfd 13,24(1)
	lwz 5,28(1)
	bl fire_hit
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe59:
	.size	 boot,.Lfe59-boot
	.section	".rodata"
	.align 2
.LC568:
	.long 0x43960000
	.align 3
.LC569:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl aol_finditem
	.type	 aol_finditem,@function
aol_finditem:
	stwu 1,-96(1)
	mflr 0
	stfd 31,88(1)
	stmw 29,76(1)
	stw 0,100(1)
	lis 11,.LC568@ha
	mr 31,3
	la 11,.LC568@l(11)
	lis 9,g_edicts@ha
	lwz 4,256(31)
	lfs 1,0(11)
	lwz 3,g_edicts@l(9)
	addi 4,4,4
	bl findradius
	mr. 30,3
	bc 12,2,.L723
	lis 11,.LC569@ha
	lis 9,gi@ha
	la 11,.LC569@l(11)
	la 29,gi@l(9)
	lfd 31,0(11)
.L726:
	lwz 0,648(30)
	cmpwi 0,0,0
	bc 12,2,.L727
	lwz 0,540(31)
	cmpw 0,30,0
	bc 12,2,.L727
	lwz 3,256(31)
	mr 4,30
	bl needitem
	cmpwi 0,3,0
	bc 12,2,.L727
	lwz 11,48(29)
	addi 3,1,8
	addi 4,30,4
	addi 5,31,188
	addi 6,31,200
	addi 7,31,4
	mr 8,31
	mtlr 11
	li 9,3
	blrl
	lfs 0,16(1)
	fcmpu 0,0,31
	bc 4,2,.L727
	stw 30,412(31)
	b .L723
.L727:
	lis 9,.LC568@ha
	lwz 4,256(31)
	mr 3,30
	la 9,.LC568@l(9)
	lfs 1,0(9)
	addi 4,4,4
	bl findradius
	mr. 30,3
	bc 4,2,.L726
.L723:
	lwz 0,100(1)
	mtlr 0
	lmw 29,76(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe60:
	.size	 aol_finditem,.Lfe60-aol_finditem
	.section	".rodata"
	.align 2
.LC570:
	.long 0x42c80000
	.align 3
.LC571:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl aom_findtarg
	.type	 aom_findtarg,@function
aom_findtarg:
	stwu 1,-96(1)
	mflr 0
	stfd 31,88(1)
	stmw 29,76(1)
	stw 0,100(1)
	lis 11,.LC570@ha
	mr 31,3
	la 11,.LC570@l(11)
	lis 9,g_edicts@ha
	lwz 4,256(31)
	lfs 1,0(11)
	lwz 3,g_edicts@l(9)
	addi 4,4,4
	bl findradius
	mr. 30,3
	bc 12,2,.L730
	lis 11,.LC571@ha
	lis 9,gi@ha
	la 11,.LC571@l(11)
	la 29,gi@l(9)
	lfd 31,0(11)
.L733:
	mr 3,30
	bl aom_valid
	cmpwi 0,3,0
	bc 12,2,.L734
	lwz 9,256(30)
	lwz 0,256(31)
	cmpw 0,9,0
	bc 12,2,.L734
	lwz 0,40(30)
	cmpwi 0,0,0
	bc 12,2,.L734
	lwz 11,48(29)
	addi 3,1,8
	addi 4,30,4
	addi 5,31,188
	addi 6,31,200
	addi 7,31,4
	mr 8,31
	mtlr 11
	li 9,3
	blrl
	lfs 0,16(1)
	fcmpu 0,0,31
	bc 4,2,.L734
	stw 30,412(31)
	b .L730
.L734:
	lis 9,.LC570@ha
	lwz 4,256(31)
	mr 3,30
	la 9,.LC570@l(9)
	lfs 1,0(9)
	addi 4,4,4
	bl findradius
	mr. 30,3
	bc 4,2,.L733
.L730:
	lwz 0,100(1)
	mtlr 0
	lmw 29,76(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe61:
	.size	 aom_findtarg,.Lfe61-aom_findtarg
	.align 2
	.globl angel_touch
	.type	 angel_touch,@function
angel_touch:
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,4,0
	bclr 4,2
	lwz 9,412(3)
	li 0,0
	stw 0,412(3)
	stw 9,540(3)
	blr
.Lfe62:
	.size	 angel_touch,.Lfe62-angel_touch
	.section	".rodata"
	.align 3
.LC572:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC573:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl fball_fire
	.type	 fball_fire,@function
fball_fire:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 23,36(1)
	stw 0,84(1)
	mr 27,5
	mr 26,7
	fmr 31,1
	mr 24,8
	mr 23,6
	mr 28,4
	mr 25,3
	bl G_Spawn
	lfs 13,0(28)
	mr 29,3
	mr 3,27
	addi 4,29,16
	stfs 13,4(29)
	lfs 0,4(28)
	stfs 0,8(29)
	lfs 13,8(28)
	stfs 13,12(29)
	lfs 0,0(27)
	stfs 0,340(29)
	lfs 13,4(27)
	stfs 13,344(29)
	lfs 0,8(27)
	stfs 0,348(29)
	bl vectoangles
	xoris 26,26,0x8000
	stw 26,28(1)
	lis 0,0x4330
	lis 11,.LC572@ha
	stw 0,24(1)
	la 11,.LC572@l(11)
	mr 3,27
	lfd 0,0(11)
	addi 4,29,376
	lfd 1,24(1)
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	lis 9,.LC180@ha
	lwz 10,64(29)
	lis 0,0x600
	la 9,.LC180@l(9)
	li 11,0
	stw 9,280(29)
	ori 0,0,3
	ori 10,10,16
	li 8,9
	li 7,23
	stw 0,252(29)
	li 9,2
	lis 28,gi@ha
	stw 8,260(29)
	la 28,gi@l(28)
	stw 7,644(29)
	lis 3,.LC227@ha
	stw 10,64(29)
	la 3,.LC227@l(3)
	stw 11,200(29)
	stw 11,196(29)
	stw 11,192(29)
	stw 11,188(29)
	stw 11,208(29)
	stw 11,204(29)
	stw 9,248(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 11,fball_touch@ha
	lis 9,.LC573@ha
	stw 3,40(29)
	la 11,fball_touch@l(11)
	stw 25,256(29)
	lis 10,level+4@ha
	stw 11,444(29)
	la 9,.LC573@l(9)
	lis 3,.LC217@ha
	lfs 0,level+4@l(10)
	la 3,.LC217@l(3)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	stw 23,516(29)
	la 9,G_FreeEdict@l(9)
	stw 24,520(29)
	fadds 0,0,13
	stw 9,436(29)
	stfs 31,524(29)
	stfs 0,428(29)
	lwz 9,36(28)
	mtlr 9
	blrl
	stw 3,76(29)
	lwz 0,72(28)
	mr 3,29
	mtlr 0
	blrl
	lwz 0,84(1)
	mtlr 0
	lmw 23,36(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe63:
	.size	 fball_fire,.Lfe63-fball_fire
	.section	".rodata"
	.align 2
.LC574:
	.long 0xbca3d70a
	.align 2
.LC575:
	.long 0x0
	.align 2
.LC576:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl card_touch
	.type	 card_touch,@function
card_touch:
	stwu 1,-64(1)
	mflr 0
	mfcr 12
	stmw 26,40(1)
	stw 0,68(1)
	stw 12,36(1)
	mr 30,3
	mr 31,4
	lwz 0,256(30)
	mr 26,5
	mr 29,6
	cmpw 0,31,0
	bc 12,2,.L861
	cmpwi 4,29,0
	bc 12,18,.L863
	lwz 0,16(29)
	andi. 9,0,4
	bc 12,2,.L863
	bl G_FreeEdict
	b .L861
.L863:
	lwz 3,256(30)
	addi 27,30,4
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L864
	mr 4,27
	li 5,2
	bl PlayerNoise
.L864:
	lis 9,.LC574@ha
	addi 28,30,376
	lfs 1,.LC574@l(9)
	mr 3,27
	mr 4,28
	addi 5,1,16
	bl VectorMA
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L865
	lwz 5,256(30)
	li 0,34
	li 11,38
	lwz 9,516(30)
	mr 3,31
	mr 6,28
	stw 0,8(1)
	mr 7,27
	mr 8,26
	stw 11,12(1)
	mr 4,30
	li 10,0
	bl T_Damage
	b .L866
.L865:
	lis 9,.LC575@ha
	lis 11,deathmatch@ha
	la 9,.LC575@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L866
	bc 12,18,.L866
	lwz 0,16(29)
	andi. 9,0,120
	bc 4,2,.L866
	bl rand
	lis 0,0x6666
	srawi 11,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,1
	subf 31,11,0
	slwi 9,31,2
	add 9,9,31
	subf 31,9,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L866
	lis 29,.LC223@ha
.L871:
	lis 9,.LC576@ha
	mr 3,30
	la 9,.LC576@l(9)
	la 4,.LC223@l(29)
	lfs 1,0(9)
	mr 5,27
	bl ThrowDebris
	cmpwi 0,31,0
	addi 31,31,-1
	bc 4,2,.L871
.L866:
	mr 3,30
	bl G_FreeEdict
.L861:
	lwz 0,68(1)
	lwz 12,36(1)
	mtlr 0
	lmw 26,40(1)
	mtcrf 8,12
	la 1,64(1)
	blr
.Lfe64:
	.size	 card_touch,.Lfe64-card_touch
	.section	".rodata"
	.align 3
.LC577:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC578:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl grav_place
	.type	 grav_place,@function
grav_place:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 28,3
	bl G_Spawn
	lfs 0,4(28)
	mr 29,3
	lis 11,0x600
	li 0,0
	li 8,0
	ori 11,11,3
	lis 7,level@ha
	stfs 0,4(29)
	la 7,level@l(7)
	lis 9,.LC577@ha
	lfs 0,8(28)
	lis 10,grav_think@ha
	lis 27,gi@ha
	lfd 13,.LC577@l(9)
	la 10,grav_think@l(10)
	la 27,gi@l(27)
	lis 9,.LC578@ha
	lis 3,.LC217@ha
	stfs 0,8(29)
	la 9,.LC578@l(9)
	la 3,.LC217@l(3)
	lfs 0,12(28)
	stw 0,200(29)
	stw 0,196(29)
	stw 0,192(29)
	stw 0,188(29)
	stw 0,208(29)
	stw 0,204(29)
	stw 11,252(29)
	stfs 0,12(29)
	stw 8,40(29)
	stw 28,256(29)
	stw 8,260(29)
	stw 8,248(29)
	lfs 0,4(7)
	stw 10,436(29)
	lfs 11,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lfs 13,4(7)
	fadds 13,13,11
	fctiwz 12,13
	stfd 12,16(1)
	lwz 9,20(1)
	stw 9,480(29)
	lwz 9,36(27)
	mtlr 9
	blrl
	stw 3,76(29)
	lwz 0,72(27)
	mr 3,29
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe65:
	.size	 grav_place,.Lfe65-grav_place
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
