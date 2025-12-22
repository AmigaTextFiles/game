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
	lwz 9,3880(9)
	cmpwi 0,9,0
	bc 12,2,.L11
	lwz 0,3880(11)
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
	bc 12,2,.L67
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L67
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
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
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L78
	lis 9,itemlist@ha
	mr 7,11
	la 8,itemlist@l(9)
	li 10,0
.L80:
	mr 27,8
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L79
	lwz 0,56(27)
	andi. 9,0,1
	bc 12,2,.L79
	lwz 11,84(31)
	addi 11,11,740
	lwzx 9,11,10
	addi 9,9,1
	stwx 9,11,10
.L79:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 8,8,72
	cmpw 0,29,0
	bc 12,0,.L80
.L78:
	bc 12,18,.L66
.L75:
	bc 4,18,.L86
	lis 4,.LC5@ha
	mr 3,26
	la 4,.LC5@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L85
.L86:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L88
	lis 9,itemlist@ha
	mr 30,11
	la 28,itemlist@l(9)
.L90:
	mr 27,28
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L89
	lwz 0,56(27)
	andi. 9,0,2
	bc 12,2,.L89
	mr 4,27
	mr 3,31
	li 5,1000
	bl Add_Ammo
.L89:
	lwz 0,1556(30)
	addi 29,29,1
	addi 28,28,72
	cmpw 0,29,0
	bc 12,0,.L90
.L88:
	bc 12,18,.L66
.L85:
	bc 4,18,.L96
	lis 4,.LC6@ha
	mr 3,26
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L95
.L96:
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
	bc 12,18,.L66
.L95:
	bc 4,18,.L99
	lis 4,.LC10@ha
	mr 3,26
	la 4,.LC10@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L98
.L99:
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
	bc 12,2,.L100
	mr 3,29
	bl G_FreeEdict
.L100:
	bc 12,18,.L66
.L98:
	bc 12,18,.L102
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L66
	lis 9,itemlist@ha
	mr 7,11
	la 11,itemlist@l(9)
	li 8,1
	li 10,0
.L106:
	lwz 0,4(11)
	cmpwi 0,0,0
	bc 12,2,.L105
	lwz 0,56(11)
	andi. 9,0,7
	bc 4,2,.L105
	lwz 9,84(31)
	addi 9,9,740
	stwx 8,9,10
.L105:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 11,11,72
	cmpw 0,29,0
	bc 12,0,.L106
	b .L66
.L102:
	mr 3,26
	bl FindItem
	mr. 27,3
	bc 4,2,.L110
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	bl FindItem
	mr. 27,3
	bc 4,2,.L110
	lwz 0,4(29)
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	b .L118
.L110:
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 4,2,.L112
	lis 9,gi+4@ha
	lis 3,.LC12@ha
	lwz 0,gi+4@l(9)
	la 3,.LC12@l(3)
.L118:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L66
.L112:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,56(27)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,27
	andi. 10,11,2
	mullw 9,9,0
	srawi 28,9,3
	bc 12,2,.L113
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L114
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
.L114:
	lwz 9,84(31)
	slwi 10,28,2
	lwz 11,48(27)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L66
.L113:
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
	.string	"grappling hook"
	.align 2
.LC21:
	.string	"grapple"
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
	.long 0x0
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
	lis 11,.LC25@ha
	lis 9,niq_enable@ha
	la 11,.LC25@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L132
	lis 4,.LC20@ha
	la 4,.LC20@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L132
	lis 9,.LC21@ha
	la 31,.LC21@l(9)
.L132:
	mr 3,31
	bl FindItem
	mr. 4,3
	bc 4,2,.L134
	lis 9,gi+8@ha
	lis 5,.LC22@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC22@l(5)
	b .L137
.L134:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L135
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC23@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L131
.L135:
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
	bc 4,2,.L136
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC24@l(5)
.L137:
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L131
.L136:
	mr 3,30
	mtlr 10
	blrl
.L131:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 Cmd_Use_f,.Lfe3-Cmd_Use_f
	.section	".rodata"
	.align 2
.LC26:
	.string	"tech"
	.align 2
.LC27:
	.string	"Item is not dropable.\n"
	.section	".text"
	.align 2
	.globl Cmd_Drop_f
	.type	 Cmd_Drop_f,@function
Cmd_Drop_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+164@ha
	mr 31,3
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	lis 4,.LC26@ha
	la 4,.LC26@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L139
	mr 3,31
	bl CTFWhat_Tech
	mr. 10,3
	bc 12,2,.L139
	lwz 0,12(10)
	mr 3,31
	mr 4,10
	mtlr 0
	blrl
	b .L138
.L139:
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 30,3
	bl FindItem
	mr. 10,3
	bc 4,2,.L140
	lwz 0,8(29)
	lis 5,.LC22@ha
	mr 3,31
	la 5,.LC22@l(5)
	b .L143
.L140:
	lwz 8,12(10)
	cmpwi 0,8,0
	bc 4,2,.L141
	lwz 0,8(29)
	lis 5,.LC27@ha
	mr 3,31
	la 5,.LC27@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L138
.L141:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L142
	lwz 0,8(29)
	lis 5,.LC24@ha
	mr 3,31
	la 5,.LC24@l(5)
.L143:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L138
.L142:
	mr 3,31
	mr 4,10
	mtlr 8
	blrl
.L138:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 Cmd_Drop_f,.Lfe4-Cmd_Drop_f
	.section	".rodata"
	.align 2
.LC28:
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
	lwz 0,3576(8)
	cmpwi 0,0,0
	bc 12,2,.L154
	bl PMenu_Select
	b .L153
.L154:
	lwz 11,736(8)
	addi 10,8,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L156
	lwz 0,3940(8)
	cmpwi 0,0,0
	bc 12,2,.L159
	mr 3,31
	bl ChaseNext
	b .L156
.L171:
	stw 11,736(8)
	b .L156
.L159:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L172:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L165
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L165
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L171
.L165:
	addi 7,7,1
	bdnz .L172
	li 0,-1
	stw 0,736(8)
.L156:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L169
	lis 9,gi+8@ha
	lis 5,.LC28@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC28@l(5)
	b .L173
.L169:
	mulli 0,0,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L170
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC23@l(5)
.L173:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L153
.L170:
	mr 3,31
	mtlr 0
	blrl
.L153:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_InvUse_f,.Lfe5-Cmd_InvUse_f
	.section	".rodata"
	.align 2
.LC29:
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
	bc 4,2,.L207
	lwz 0,3576(8)
	cmpwi 0,0,0
	bc 12,2,.L208
	bl PMenu_Next
	b .L207
.L208:
	lwz 0,3940(8)
	cmpwi 0,0,0
	bc 12,2,.L210
	mr 3,31
	bl ChaseNext
	b .L207
.L222:
	stw 11,736(8)
	b .L207
.L210:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L223:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L216
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L216
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L222
.L216:
	addi 7,7,1
	bdnz .L223
	li 0,-1
	stw 0,736(8)
.L207:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L220
	lis 9,gi+8@ha
	lis 5,.LC29@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC29@l(5)
	b .L224
.L220:
	mulli 0,0,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L221
	lis 9,gi+8@ha
	lis 5,.LC27@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC27@l(5)
.L224:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L205
.L221:
	mr 3,31
	mtlr 0
	blrl
.L205:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 Cmd_InvDrop_f,.Lfe6-Cmd_InvDrop_f
	.section	".rodata"
	.align 2
.LC30:
	.string	"%3i %s\n"
	.align 2
.LC31:
	.string	"...\n"
	.align 2
.LC32:
	.string	"%s\n%i players\n"
	.align 2
.LC33:
	.long 0x0
	.align 3
.LC34:
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
	lis 11,.LC33@ha
	lis 9,maxclients@ha
	la 11,.LC33@l(11)
	mr 23,3
	lfs 13,0(11)
	li 27,0
	li 31,0
	lwz 11,maxclients@l(9)
	addi 29,1,1352
	addi 30,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L236
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L238:
	lwz 0,0(11)
	addi 11,11,3968
	cmpwi 0,0,0
	bc 12,2,.L237
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L237:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L238
.L236:
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
	bc 4,0,.L242
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC30@ha
	lis 25,.LC31@ha
.L244:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC30@l(26)
	addi 28,28,4
	mulli 7,7,3968
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
	bc 4,1,.L245
	la 4,.LC31@l(25)
	mr 3,30
	bl strcat
	b .L242
.L245:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L244
.L242:
	lis 9,gi+8@ha
	lis 5,.LC32@ha
	lwz 0,gi+8@l(9)
	mr 3,23
	la 5,.LC32@l(5)
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
.LC35:
	.string	"flipoff\n"
	.align 2
.LC36:
	.string	"salute\n"
	.align 2
.LC37:
	.string	"taunt\n"
	.align 2
.LC38:
	.string	"wave\n"
	.align 2
.LC39:
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
	bc 4,2,.L247
	lwz 0,3776(9)
	cmpwi 0,0,1
	bc 12,1,.L247
	cmplwi 0,3,4
	li 0,1
	stw 0,3776(9)
	bc 12,1,.L256
	lis 11,.L257@ha
	slwi 10,3,2
	la 11,.L257@l(11)
	lis 9,.L257@ha
	lwzx 0,10,11
	la 9,.L257@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L257:
	.long .L251-.L257
	.long .L252-.L257
	.long .L253-.L257
	.long .L254-.L257
	.long .L256-.L257
.L251:
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
	li 0,71
	li 9,83
	b .L258
.L252:
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
	li 0,83
	li 9,94
	b .L258
.L253:
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
	li 0,94
	li 9,111
	b .L258
.L254:
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
	li 0,111
	li 9,122
	b .L258
.L256:
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
	li 0,122
	li 9,134
.L258:
	stw 0,56(31)
	stw 9,3772(11)
.L247:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 Cmd_Wave_f,.Lfe8-Cmd_Wave_f
	.section	".rodata"
	.align 2
.LC40:
	.string	"(%s): "
	.align 2
.LC41:
	.string	"%s: "
	.align 2
.LC42:
	.string	" "
	.align 2
.LC43:
	.string	"\n"
	.align 2
.LC44:
	.string	"%s"
	.align 2
.LC45:
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
	mr 30,4
	mr 31,5
	mtlr 0
	blrl
	cmpwi 0,3,1
	bc 12,1,.L260
	cmpwi 0,31,0
	bc 12,2,.L259
.L260:
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
	bc 12,2,.L262
	lwz 6,84(28)
	lis 5,.LC40@ha
	addi 3,1,8
	la 5,.LC40@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L263
.L262:
	lwz 6,84(28)
	lis 5,.LC41@ha
	addi 3,1,8
	la 5,.LC41@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L263:
	cmpwi 0,31,0
	bc 12,2,.L264
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC42@ha
	addi 3,1,8
	la 4,.LC42@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L265
.L264:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L266
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
.L266:
	mr 4,29
	addi 3,1,8
	bl strcat
.L265:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L267
	li 0,0
	stb 0,158(1)
.L267:
	lis 4,.LC43@ha
	addi 3,1,8
	la 4,.LC43@l(4)
	bl strcat
	lis 9,.LC45@ha
	lis 11,dedicated@ha
	la 9,.LC45@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L268
	lis 9,gi+8@ha
	lis 5,.LC44@ha
	lwz 0,gi+8@l(9)
	la 5,.LC44@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L268:
	lis 9,game@ha
	li 31,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,31,0
	bc 12,1,.L259
	cmpwi 4,30,0
	lis 9,gi@ha
	la 24,gi@l(9)
	mr 25,11
	lis 26,g_edicts@ha
	lis 27,.LC44@ha
	li 30,1332
.L272:
	lwz 0,g_edicts@l(26)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L271
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L271
	lwz 0,968(29)
	cmpwi 0,0,0
	bc 4,2,.L271
	bc 12,18,.L276
	mr 3,28
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L271
.L276:
	lwz 9,8(24)
	mr 3,29
	li 4,3
	la 5,.LC44@l(27)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L271:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,1332
	cmpw 0,31,0
	bc 4,1,.L272
.L259:
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
.LC46:
	.string	"players"
	.align 2
.LC47:
	.string	"say"
	.align 2
.LC48:
	.string	"say_team"
	.align 2
.LC49:
	.string	"steam"
	.align 2
.LC50:
	.string	"score"
	.align 2
.LC51:
	.string	"help"
	.align 2
.LC52:
	.string	"use"
	.align 2
.LC53:
	.string	"drop"
	.align 2
.LC54:
	.string	"give"
	.align 2
.LC55:
	.string	"god"
	.align 2
.LC56:
	.string	"notarget"
	.align 2
.LC57:
	.string	"noclip"
	.align 2
.LC58:
	.string	"inven"
	.align 2
.LC59:
	.string	"invnext"
	.align 2
.LC60:
	.string	"invprev"
	.align 2
.LC61:
	.string	"invnextw"
	.align 2
.LC62:
	.string	"invprevw"
	.align 2
.LC63:
	.string	"invnextp"
	.align 2
.LC64:
	.string	"invprevp"
	.align 2
.LC65:
	.string	"invuse"
	.align 2
.LC66:
	.string	"invdrop"
	.align 2
.LC67:
	.string	"weapprev"
	.align 2
.LC68:
	.string	"weapnext"
	.align 2
.LC69:
	.string	"weaplast"
	.align 2
.LC70:
	.string	"kill"
	.align 2
.LC71:
	.string	"putaway"
	.align 2
.LC72:
	.string	"wave"
	.align 2
.LC73:
	.string	"team"
	.align 2
.LC74:
	.string	"id"
	.align 2
.LC75:
	.string	"cam"
	.align 2
.LC76:
	.long 0x0
	.align 2
.LC77:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl ClientCommand
	.type	 ClientCommand,@function
ClientCommand:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 23,20(1)
	stw 0,68(1)
	mr 29,3
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L279
	lis 9,gi@ha
	li 3,0
	la 31,gi@l(9)
	lwz 9,160(31)
	mtlr 9
	blrl
	mr 26,3
	lis 4,.LC46@ha
	la 4,.LC46@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L281
	mr 3,29
	bl Cmd_Players_f
	b .L279
.L281:
	lis 4,.LC47@ha
	mr 3,26
	la 4,.LC47@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L282
	mr 3,29
	li 4,0
	b .L480
.L282:
	lis 4,.LC48@ha
	mr 3,26
	la 4,.LC48@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L284
	lis 4,.LC49@ha
	mr 3,26
	la 4,.LC49@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L283
.L284:
	lis 9,.LC76@ha
	lis 11,ctf@ha
	la 9,.LC76@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L285
	lwz 0,164(31)
	mtlr 0
	blrl
	mr 4,3
	mr 3,29
	bl CTFSay_Team
	b .L279
.L285:
	mr 3,29
	li 4,1
.L480:
	li 5,0
	bl Cmd_Say_f
	b .L279
.L283:
	lis 4,.LC50@ha
	mr 3,26
	la 4,.LC50@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L287
	mr 3,29
	bl Cmd_Score_f
	b .L279
.L287:
	lis 4,.LC51@ha
	mr 3,26
	la 4,.LC51@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L288
	mr 3,29
	bl Cmd_Help_f
	b .L279
.L288:
	lis 10,.LC76@ha
	lis 9,level+200@ha
	la 10,.LC76@l(10)
	lfs 0,level+200@l(9)
	lfs 31,0(10)
	fcmpu 0,0,31
	bc 4,2,.L279
	mr 3,29
	mr 4,26
	bl niq_clientcommand
	cmpwi 0,3,0
	bc 4,2,.L279
	lis 4,.LC52@ha
	mr 3,26
	la 4,.LC52@l(4)
	li 23,1
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L291
	mr 3,29
	bl Cmd_Use_f
	b .L292
.L291:
	lis 4,.LC53@ha
	mr 3,26
	la 4,.LC53@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L293
	mr 3,29
	bl Cmd_Drop_f
	b .L292
.L293:
	lis 4,.LC54@ha
	mr 3,26
	la 4,.LC54@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L295
	mr 3,29
	bl Cmd_Give_f
	b .L292
.L295:
	lis 4,.LC55@ha
	mr 3,26
	la 4,.LC55@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L297
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L298
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L298
	lwz 0,8(31)
	lis 5,.LC1@ha
	mr 3,29
	la 5,.LC1@l(5)
	b .L481
.L298:
	lwz 0,264(29)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(29)
	bc 4,2,.L300
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L313
.L300:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
	b .L313
.L297:
	lis 4,.LC56@ha
	mr 3,26
	la 4,.LC56@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L303
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L304
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L304
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	mr 3,29
	b .L481
.L304:
	lwz 0,264(29)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(29)
	bc 4,2,.L306
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L313
.L306:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
	b .L313
.L303:
	lis 4,.LC57@ha
	mr 3,26
	la 4,.LC57@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L309
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L310
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L310
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	mr 3,29
	b .L481
.L310:
	lwz 0,260(29)
	cmpwi 0,0,1
	bc 4,2,.L312
	li 0,4
	lis 9,.LC18@ha
	stw 0,260(29)
	la 5,.LC18@l(9)
	b .L313
.L312:
	li 0,1
	lis 9,.LC19@ha
	stw 0,260(29)
	la 5,.LC19@l(9)
.L313:
	lis 9,gi+8@ha
	mr 3,29
	lwz 0,gi+8@l(9)
.L481:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L292
.L309:
	lis 4,.LC58@ha
	mr 3,26
	la 4,.LC58@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L315
	lwz 31,84(29)
	lwz 9,3576(31)
	cmpwi 0,9,0
	bc 12,2,.L316
	mr 3,29
	bl PMenu_Close
	lwz 9,84(29)
	stw 23,3944(9)
	b .L292
.L316:
	lwz 0,3580(31)
	cmpwi 0,0,0
	bc 12,2,.L318
	stw 9,3580(31)
	b .L292
.L318:
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L319
	lwz 0,3464(31)
	cmpwi 0,0,0
	bc 4,2,.L319
	mr 3,29
	bl CTFOpenJoinMenu
	b .L292
.L319:
	li 0,1
	li 11,0
	lis 9,gi@ha
	stw 0,3580(31)
	li 3,5
	la 9,gi@l(9)
	stw 11,3568(31)
	addi 30,31,1760
	lwz 0,100(9)
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L322:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,30
	bc 4,1,.L322
	lis 9,gi+92@ha
	mr 3,29
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L292
.L315:
	lis 4,.LC59@ha
	mr 3,26
	la 4,.LC59@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L326
	lwz 8,84(29)
	lwz 0,3576(8)
	cmpwi 0,0,0
	bc 4,2,.L482
	lwz 0,3940(8)
	cmpwi 0,0,0
	bc 4,2,.L483
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L479:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L335
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L335
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L472
.L335:
	addi 7,7,1
	bdnz .L479
	b .L484
.L326:
	lis 4,.LC60@ha
	mr 3,26
	la 4,.LC60@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L340
	lwz 7,84(29)
	lwz 0,3576(7)
	cmpwi 0,0,0
	bc 4,2,.L485
	lwz 0,3940(7)
	cmpwi 0,0,0
	bc 4,2,.L486
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L478:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L349
	mulli 0,8,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L349
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L473
.L349:
	addi 11,11,-1
	bdnz .L478
	b .L487
.L340:
	lis 4,.LC61@ha
	mr 3,26
	la 4,.LC61@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L354
	lwz 8,84(29)
	lwz 0,3576(8)
	cmpwi 0,0,0
	bc 4,2,.L482
	lwz 0,3940(8)
	cmpwi 0,0,0
	bc 4,2,.L483
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L477:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L363
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L363
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L472
.L363:
	addi 7,7,1
	bdnz .L477
	b .L484
.L354:
	lis 4,.LC62@ha
	mr 3,26
	la 4,.LC62@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L368
	lwz 7,84(29)
	lwz 0,3576(7)
	cmpwi 0,0,0
	bc 4,2,.L485
	lwz 0,3940(7)
	cmpwi 0,0,0
	bc 4,2,.L486
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L476:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L377
	mulli 0,8,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L377
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L473
.L377:
	addi 11,11,-1
	bdnz .L476
	b .L487
.L368:
	lis 4,.LC63@ha
	mr 3,26
	la 4,.LC63@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L382
	lwz 8,84(29)
	lwz 0,3576(8)
	cmpwi 0,0,0
	bc 12,2,.L383
.L482:
	mr 3,29
	bl PMenu_Next
	b .L292
.L383:
	lwz 0,3940(8)
	cmpwi 0,0,0
	bc 12,2,.L385
.L483:
	mr 3,29
	bl ChaseNext
	b .L292
.L385:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L475:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L391
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L391
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L472
.L391:
	addi 7,7,1
	bdnz .L475
.L484:
	li 0,-1
	stw 0,736(8)
	b .L292
.L382:
	lis 4,.LC64@ha
	mr 3,26
	la 4,.LC64@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L396
	lwz 7,84(29)
	lwz 0,3576(7)
	cmpwi 0,0,0
	bc 12,2,.L397
.L485:
	mr 3,29
	bl PMenu_Prev
	b .L292
.L397:
	lwz 0,3940(7)
	cmpwi 0,0,0
	bc 12,2,.L399
.L486:
	mr 3,29
	bl ChasePrev
	b .L292
.L399:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L474:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L405
	mulli 0,8,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L405
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L473
.L405:
	addi 11,11,-1
	bdnz .L474
.L487:
	li 0,-1
	stw 0,736(7)
	b .L292
.L396:
	lis 4,.LC65@ha
	mr 3,26
	la 4,.LC65@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L410
	mr 3,29
	bl Cmd_InvUse_f
	b .L292
.L410:
	lis 4,.LC66@ha
	mr 3,26
	la 4,.LC66@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L412
	mr 3,29
	bl Cmd_InvDrop_f
	b .L292
.L412:
	lis 4,.LC67@ha
	mr 3,26
	la 4,.LC67@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L414
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L292
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	mr 24,9
	li 30,1
	subf 9,9,11
	addi 25,28,740
	mullw 9,9,0
	srawi 27,9,3
.L419:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,25,9
	cmpwi 0,0,0
	bc 12,2,.L421
	mulli 0,11,72
	add 31,0,24
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L421
	lwz 0,56(31)
	andi. 10,0,1
	bc 12,2,.L421
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L292
.L421:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L419
	b .L292
.L414:
	lis 4,.LC68@ha
	mr 3,26
	la 4,.LC68@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L427
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L292
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	mr 24,9
	li 27,1
	subf 9,9,11
	addi 25,28,740
	mullw 9,9,0
	srawi 9,9,3
	addi 30,9,255
.L432:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,25,9
	cmpwi 0,0,0
	bc 12,2,.L434
	mulli 0,11,72
	add 31,0,24
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L434
	lwz 0,56(31)
	andi. 10,0,1
	bc 12,2,.L434
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L292
.L434:
	addi 27,27,1
	addi 30,30,-1
	cmpwi 0,27,256
	bc 4,1,.L432
	b .L292
.L427:
	lis 4,.LC69@ha
	mr 3,26
	la 4,.LC69@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L440
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
.L440:
	lis 4,.LC70@ha
	mr 3,26
	la 4,.LC70@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L448
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 12,2,.L292
	lwz 11,84(29)
	lis 9,level+4@ha
	lis 10,.LC77@ha
	lfs 0,level+4@l(9)
	la 10,.LC77@l(10)
	lfs 13,3824(11)
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
.L448:
	lis 4,.LC71@ha
	mr 3,26
	la 4,.LC71@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L453
	lwz 9,84(29)
	stw 3,3568(9)
	lwz 11,84(29)
	stw 3,3584(11)
	lwz 9,84(29)
	stw 3,3580(9)
	lwz 11,84(29)
	lwz 0,3576(11)
	cmpwi 0,0,0
	bc 12,2,.L454
	mr 3,29
	bl PMenu_Close
.L454:
	lis 9,niq_enable@ha
	lwz 10,84(29)
	li 0,1
	lwz 11,niq_enable@l(9)
	lis 9,.LC76@ha
	stw 0,3944(10)
	la 9,.LC76@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L292
	mr 3,29
	bl niq_updatescreen
	b .L292
.L453:
	lis 4,.LC72@ha
	mr 3,26
	la 4,.LC72@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L458
	mr 3,29
	bl Cmd_Wave_f
	b .L292
.L472:
	stw 11,736(8)
	b .L292
.L473:
	stw 8,736(7)
	b .L292
.L458:
	li 23,0
.L292:
	cmpwi 0,23,0
	bc 4,2,.L279
	lis 4,.LC73@ha
	mr 3,26
	la 4,.LC73@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L462
	mr 3,29
	bl CTFTeam_f
	b .L279
.L462:
	lis 9,.LC76@ha
	lis 11,niq_playerid@ha
	la 9,.LC76@l(9)
	lfs 13,0(9)
	lwz 9,niq_playerid@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L464
	lis 4,.LC74@ha
	mr 3,26
	la 4,.LC74@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L464
	mr 3,29
	bl CTFID_f
	b .L279
.L464:
	lis 4,.LC75@ha
	mr 3,26
	la 4,.LC75@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L466
	mr 3,29
	crxor 6,6,6
	bl CameraCmd
	b .L279
.L466:
	mr 3,29
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L279:
	lwz 0,68(1)
	mtlr 0
	lmw 23,20(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe10:
	.size	 ClientCommand,.Lfe10-ClientCommand
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
	lwz 0,3576(8)
	cmpwi 0,0,0
	bc 12,2,.L54
	bl PMenu_Next
	b .L52
.L54:
	lwz 0,3940(8)
	cmpwi 0,0,0
	bc 12,2,.L56
	bl ChaseNext
	b .L52
.L488:
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
.L489:
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
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L62
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L488
.L62:
	addi 7,7,1
	bdnz .L489
	li 0,-1
	stw 0,736(8)
.L52:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 ValidateSelectedItem,.Lfe11-ValidateSelectedItem
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
	.comm	pTempFind,4,4
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
	bc 12,2,.L491
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
	bc 12,2,.L491
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L9
	addi 3,3,1
	b .L490
.L9:
	stb 30,0(3)
.L491:
	mr 3,31
.L490:
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
	lwz 0,3576(8)
	cmpwi 0,0,0
	bc 12,2,.L29
	bl PMenu_Next
	b .L28
.L29:
	lwz 0,3940(8)
	cmpwi 0,0,0
	bc 12,2,.L30
	bl ChaseNext
	b .L28
.L492:
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
.L493:
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
	mulli 0,11,72
	add 10,0,3
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L34
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L492
.L34:
	addi 7,7,1
	bdnz .L493
	li 0,-1
	stw 0,736(8)
.L28:
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
	lwz 0,3576(7)
	cmpwi 0,0,0
	bc 12,2,.L41
	bl PMenu_Prev
	b .L40
.L41:
	lwz 0,3940(7)
	cmpwi 0,0,0
	bc 12,2,.L42
	bl ChasePrev
	b .L40
.L494:
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
.L495:
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
	bc 4,2,.L494
.L46:
	addi 11,11,-1
	bdnz .L495
	li 0,-1
	stw 0,736(7)
.L40:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 SelectPrevItem,.Lfe14-SelectPrevItem
	.section	".rodata"
	.align 2
.LC78:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC78@ha
	lis 9,deathmatch@ha
	la 11,.LC78@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L120
	lis 9,sv_cheats@ha
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
	lwz 0,264(3)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(3)
	bc 4,2,.L121
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L122
.L121:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
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
.Lfe15:
	.size	 Cmd_God_f,.Lfe15-Cmd_God_f
	.section	".rodata"
	.align 2
.LC79:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC79@ha
	lis 9,deathmatch@ha
	la 11,.LC79@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L124
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L124
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L123
.L124:
	lwz 0,264(3)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(3)
	bc 4,2,.L125
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L126
.L125:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
.L126:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L123:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 Cmd_Notarget_f,.Lfe16-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC80:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC80@ha
	lis 9,deathmatch@ha
	la 11,.LC80@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L128
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L128
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L127
.L128:
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 4,2,.L129
	li 0,4
	lis 9,.LC18@ha
	stw 0,260(3)
	la 5,.LC18@l(9)
	b .L130
.L129:
	li 0,1
	lis 9,.LC19@ha
	stw 0,260(3)
	la 5,.LC19@l(9)
.L130:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L127:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 Cmd_Noclip_f,.Lfe17-Cmd_Noclip_f
	.section	".rodata"
	.align 2
.LC81:
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
	lwz 9,3576(31)
	cmpwi 0,9,0
	bc 12,2,.L145
	bl PMenu_Close
	lwz 9,84(30)
	li 0,1
	stw 0,3944(9)
	b .L144
.L145:
	lwz 0,3580(31)
	cmpwi 0,0,0
	bc 12,2,.L146
	stw 9,3580(31)
	b .L144
.L146:
	lis 9,.LC81@ha
	lis 11,ctf@ha
	la 9,.LC81@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L147
	lwz 0,3464(31)
	cmpwi 0,0,0
	bc 4,2,.L147
	mr 3,30
	bl CTFOpenJoinMenu
	b .L144
.L147:
	li 0,1
	li 11,0
	lis 9,gi@ha
	stw 0,3580(31)
	li 3,5
	la 9,gi@l(9)
	stw 11,3568(31)
	addi 29,31,1760
	lwz 0,100(9)
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L151:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,29
	bc 4,1,.L151
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L144:
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
	lwz 0,1788(4)
	cmpwi 0,0,0
	bc 12,2,.L174
	lwz 9,1792(4)
	cmpwi 0,9,0
	bc 12,2,.L174
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L174:
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
	lwz 11,1788(29)
	cmpwi 0,11,0
	bc 12,2,.L177
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
.L182:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L181
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L181
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L181
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L177
.L181:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L182
.L177:
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
	bc 12,2,.L188
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
.L193:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L192
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L192
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L192
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L188
.L192:
	addi 28,28,1
	addi 30,30,-1
	cmpwi 0,28,256
	bc 4,1,.L193
.L188:
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
	bc 12,2,.L199
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L199
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
	bc 12,2,.L199
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L199
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L199
	mtlr 9
	blrl
.L199:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 Cmd_WeapLast_f,.Lfe22-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC82:
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
	bc 12,2,.L225
	lwz 11,84(31)
	lis 9,level+4@ha
	lis 10,.LC82@ha
	lfs 0,level+4@l(9)
	la 10,.LC82@l(10)
	lfs 13,3824(11)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L225
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
.L225:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe23:
	.size	 Cmd_Kill_f,.Lfe23-Cmd_Kill_f
	.section	".rodata"
	.align 2
.LC83:
	.long 0x0
	.section	".text"
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
	stw 0,3568(9)
	lwz 11,84(31)
	stw 0,3584(11)
	lwz 9,84(31)
	stw 0,3580(9)
	lwz 11,84(31)
	lwz 0,3576(11)
	cmpwi 0,0,0
	bc 12,2,.L229
	bl PMenu_Close
.L229:
	lis 9,niq_enable@ha
	lwz 10,84(31)
	li 0,1
	lwz 11,niq_enable@l(9)
	lis 9,.LC83@ha
	stw 0,3944(10)
	la 9,.LC83@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L230
	mr 3,31
	bl niq_updatescreen
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
	mulli 9,9,3968
	mulli 11,3,3968
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
