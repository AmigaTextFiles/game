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
	lis 9,compmod+4@ha
	mr 29,4
	lwz 30,compmod+4@l(9)
	cmpwi 0,30,0
	bc 12,2,.L11
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L27
	lwz 4,84(29)
	cmpwi 0,4,0
	bc 12,2,.L27
	lwz 0,3472(3)
	lwz 3,3472(4)
	xor 3,0,3
	subfic 9,3,0
	adde 3,9,3
	b .L26
.L11:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 11,1044(1)
	andi. 0,11,192
	bc 4,2,.L16
.L27:
	li 3,0
	b .L26
.L16:
	lis 9,value.6@ha
	stb 30,value.6@l(9)
	la 31,value.6@l(9)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L29
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
	bc 12,2,.L29
	lis 9,dmflags@ha
	lwz 11,dmflags@l(9)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 9,1044(1)
	andi. 0,9,128
	bc 12,2,.L20
	stb 30,0(3)
.L29:
	mr 3,31
	b .L18
.L20:
	addi 3,3,1
.L18:
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
	bc 12,2,.L31
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
	bc 12,2,.L31
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 11,1044(1)
	andi. 0,11,128
	bc 12,2,.L24
	stb 28,0(3)
.L31:
	mr 3,31
	b .L22
.L24:
	addi 3,3,1
.L22:
	mr 4,3
	mr 3,30
	bl strcpy
	mr 4,27
	addi 3,1,8
	bl strcmp
	subfic 0,3,0
	adde 3,0,3
.L26:
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
	lis 9,compmod+4@ha
	mr 31,3
	lwz 0,compmod+4@l(9)
	cmpwi 0,0,1
	bc 4,2,.L62
	lis 9,.LC13@ha
	lis 11,fullweaprally@ha
	la 9,.LC13@l(9)
	lfs 13,0(9)
	lwz 9,fullweaprally@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L62
	li 3,1
	b .L63
.L62:
	lis 9,deathmatch@ha
	lis 10,.LC13@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC13@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L64
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L64
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L61
.L64:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 26,3
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	bl Q_stricmp
	subfic 0,3,0
	adde 3,0,3
.L63:
	cmpwi 4,3,0
	bc 4,18,.L68
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	lis 4,.LC3@ha
	la 4,.LC3@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L67
.L68:
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L69
	lwz 0,160(29)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	stw 3,480(31)
	b .L70
.L69:
	lwz 0,484(31)
	stw 0,480(31)
.L70:
	bc 12,18,.L61
.L67:
	bc 4,18,.L73
	lis 4,.LC4@ha
	mr 3,26
	la 4,.LC4@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L72
.L73:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L75
	lis 9,itemlist@ha
	mr 7,11
	la 8,itemlist@l(9)
	li 10,0
.L77:
	mr 27,8
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L76
	lwz 0,56(27)
	andi. 9,0,1
	bc 12,2,.L76
	lwz 11,84(31)
	addi 11,11,740
	lwzx 9,11,10
	addi 9,9,1
	stwx 9,11,10
.L76:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 8,8,72
	cmpw 0,29,0
	bc 12,0,.L77
.L75:
	bc 12,18,.L61
.L72:
	bc 4,18,.L83
	lis 4,.LC5@ha
	mr 3,26
	la 4,.LC5@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L82
.L83:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L85
	lis 9,itemlist@ha
	mr 30,11
	la 28,itemlist@l(9)
.L87:
	mr 27,28
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L86
	lwz 0,56(27)
	andi. 9,0,2
	bc 12,2,.L86
	mr 4,27
	mr 3,31
	li 5,1000
	bl Add_Ammo
.L86:
	lwz 0,1556(30)
	addi 29,29,1
	addi 28,28,72
	cmpw 0,29,0
	bc 12,0,.L87
.L85:
	bc 12,18,.L61
.L82:
	bc 4,18,.L93
	lis 4,.LC6@ha
	mr 3,26
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L92
.L93:
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
	bc 12,18,.L61
.L92:
	bc 4,18,.L96
	lis 4,.LC10@ha
	mr 3,26
	la 4,.LC10@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L95
.L96:
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
	bc 12,2,.L97
	mr 3,29
	bl G_FreeEdict
.L97:
	bc 12,18,.L61
.L95:
	bc 12,18,.L99
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
	addi 11,11,72
	cmpw 0,29,0
	bc 12,0,.L103
	b .L61
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
	lwz 0,4(29)
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	b .L115
.L107:
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 4,2,.L109
	lis 9,gi+4@ha
	lis 3,.LC12@ha
	lwz 0,gi+4@l(9)
	la 3,.LC12@l(3)
.L115:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L61
.L109:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,56(27)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,27
	andi. 10,11,2
	mullw 9,9,0
	srawi 28,9,3
	bc 12,2,.L110
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L111
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
.L111:
	lwz 9,84(31)
	slwi 10,28,2
	lwz 11,48(27)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L61
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
	bc 12,2,.L61
	mr 3,29
	bl G_FreeEdict
.L61:
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
	stw 0,20(1)
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
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	la 5,.LC24@l(5)
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
	lis 5,.LC21@ha
	lwz 0,gi+8@l(9)
	la 5,.LC21@l(5)
.L159:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L143
.L156:
	mtlr 0
	blrl
.L143:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 Cmd_InvUse_f,.Lfe3-Cmd_InvUse_f
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
	stw 0,20(1)
	lwz 7,84(3)
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L190
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L203:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L195
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L195
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L202
.L195:
	addi 8,8,1
	bdnz .L203
	li 0,-1
	stw 0,736(7)
.L190:
	lwz 9,84(3)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L200
	lis 9,gi+8@ha
	lis 5,.LC25@ha
	lwz 0,gi+8@l(9)
	la 5,.LC25@l(5)
	b .L204
.L202:
	stw 11,736(7)
	b .L190
.L200:
	mulli 0,0,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L201
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	la 5,.LC23@l(5)
.L204:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L188
.L201:
	mtlr 0
	blrl
.L188:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 Cmd_InvDrop_f,.Lfe4-Cmd_InvDrop_f
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
	bc 4,0,.L216
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L218:
	lwz 0,0(11)
	addi 11,11,3772
	cmpwi 0,0,0
	bc 12,2,.L217
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L217:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L218
.L216:
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
	bc 4,0,.L222
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC26@ha
	lis 25,.LC27@ha
.L224:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC26@l(26)
	addi 28,28,4
	mulli 7,7,3772
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
	bc 4,1,.L225
	la 4,.LC27@l(25)
	mr 3,30
	bl strcat
	b .L222
.L225:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L224
.L222:
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
.Lfe5:
	.size	 Cmd_Players_f,.Lfe5-Cmd_Players_f
	.section	".rodata"
	.align 2
.LC31:
	.string	"flipoff\n"
	.align 2
.LC32:
	.string	"salute\n"
	.align 2
.LC33:
	.string	"taunt\n"
	.align 2
.LC34:
	.string	"wave\n"
	.align 2
.LC35:
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
	bc 4,2,.L227
	lwz 0,3720(9)
	cmpwi 0,0,1
	bc 12,1,.L227
	cmplwi 0,3,4
	li 0,1
	stw 0,3720(9)
	bc 12,1,.L236
	lis 11,.L237@ha
	slwi 10,3,2
	la 11,.L237@l(11)
	lis 9,.L237@ha
	lwzx 0,10,11
	la 9,.L237@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L237:
	.long .L231-.L237
	.long .L232-.L237
	.long .L233-.L237
	.long .L234-.L237
	.long .L236-.L237
.L231:
	lis 9,gi+8@ha
	lis 5,.LC31@ha
	lwz 0,gi+8@l(9)
	la 5,.LC31@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,71
	li 9,83
	b .L238
.L232:
	lis 9,gi+8@ha
	lis 5,.LC32@ha
	lwz 0,gi+8@l(9)
	la 5,.LC32@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,83
	li 9,94
	b .L238
.L233:
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
	li 0,94
	li 9,111
	b .L238
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
	li 0,111
	li 9,122
	b .L238
.L236:
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
	li 0,122
	li 9,134
.L238:
	stw 0,56(31)
	stw 9,3716(11)
.L227:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 Cmd_Wave_f,.Lfe6-Cmd_Wave_f
	.section	".rodata"
	.align 2
.LC36:
	.string	"\nSILENCED - Only Admins can talk.\n"
	.align 2
.LC37:
	.string	"\nSILENCED - Spectators can't talk to all. Use 'say_team'.\n"
	.align 2
.LC38:
	.string	"(%s): "
	.align 2
.LC39:
	.string	"%s: "
	.align 2
.LC40:
	.string	" "
	.align 2
.LC41:
	.string	"\n"
	.align 2
.LC42:
	.string	"%s"
	.align 2
.LC43:
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
	lis 9,gi@ha
	mr 28,3
	la 29,gi@l(9)
	mr 31,4
	lwz 9,156(29)
	mr 30,5
	mtlr 9
	blrl
	cmpwi 0,3,1
	bc 12,1,.L240
	cmpwi 0,30,0
	bc 12,2,.L239
.L240:
	lis 9,.LC43@ha
	lis 11,dedicated@ha
	lwz 6,84(28)
	la 9,.LC43@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L241
	lis 9,compmod@ha
	la 9,compmod@l(9)
	lwz 11,4(9)
	cmpwi 0,11,0
	bc 12,2,.L263
	lwz 0,8(9)
	cmpwi 0,0,2
	bc 4,2,.L243
	lwz 0,3456(6)
	cmpwi 0,0,0
	bc 4,2,.L243
	cmpwi 0,11,2
	bc 12,2,.L243
	lwz 0,8(29)
	lis 5,.LC36@ha
	mr 3,28
	la 5,.LC36@l(5)
	b .L264
.L243:
	lis 9,compmod+8@ha
	lwz 0,compmod+8@l(9)
	cmpwi 0,0,1
	bc 4,2,.L241
	lwz 0,3456(6)
	cmpwi 0,0,0
	bc 4,2,.L241
	lwz 0,3472(6)
	subfic 11,31,0
	adde 9,11,31
	subfic 0,0,-1
	subfic 11,0,0
	adde 0,11,0
	and. 11,0,9
	bc 12,2,.L241
	lis 9,gi+8@ha
	lis 5,.LC37@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC37@l(5)
.L264:
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L239
.L241:
	lis 9,compmod+4@ha
	lwz 0,compmod+4@l(9)
	cmpwi 0,0,0
	bc 4,2,.L245
.L263:
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,2064(1)
	lwz 9,2068(1)
	rlwinm 9,9,0,24,25
	neg 9,9
	srawi 9,9,31
	and 31,31,9
.L245:
	cmpwi 4,31,0
	bc 12,18,.L247
	lis 5,.LC38@ha
	addi 6,6,700
	la 5,.LC38@l(5)
	addi 3,1,8
	li 4,2048
	crxor 6,6,6
	bl Com_sprintf
	b .L248
.L247:
	lis 5,.LC39@ha
	addi 6,6,700
	la 5,.LC39@l(5)
	addi 3,1,8
	li 4,2048
	crxor 6,6,6
	bl Com_sprintf
.L248:
	cmpwi 0,30,0
	bc 12,2,.L249
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC40@ha
	addi 3,1,8
	la 4,.LC40@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L250
.L249:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L251
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 30,-1(3)
.L251:
	mr 4,29
	addi 3,1,8
	bl strcat
.L250:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L252
	li 0,0
	stb 0,158(1)
.L252:
	lis 4,.LC41@ha
	addi 3,1,8
	la 4,.LC41@l(4)
	bl strcat
	lis 9,.LC43@ha
	lis 11,dedicated@ha
	la 9,.LC43@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L253
	lis 9,gi+8@ha
	lis 5,.LC42@ha
	lwz 0,gi+8@l(9)
	la 5,.LC42@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L253:
	lis 9,game@ha
	li 31,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,31,0
	bc 12,1,.L239
	lis 9,gi@ha
	mr 24,11
	la 25,gi@l(9)
	lis 26,g_edicts@ha
	lis 27,.LC42@ha
	li 30,892
.L257:
	lwz 0,g_edicts@l(26)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L256
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L256
	bc 12,18,.L260
	mr 3,28
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L256
.L260:
	lwz 9,8(25)
	mr 3,29
	li 4,3
	la 5,.LC42@l(27)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L256:
	lwz 0,1544(24)
	addi 31,31,1
	addi 30,30,892
	cmpw 0,31,0
	bc 4,1,.L257
.L239:
	lwz 0,2116(1)
	lwz 12,2076(1)
	mtlr 0
	lmw 24,2080(1)
	mtcrf 8,12
	la 1,2112(1)
	blr
.Lfe7:
	.size	 Cmd_Say_f,.Lfe7-Cmd_Say_f
	.section	".rodata"
	.align 2
.LC44:
	.string	"players"
	.align 2
.LC45:
	.string	"say"
	.align 2
.LC46:
	.string	"say_team"
	.align 2
.LC47:
	.string	"score"
	.align 2
.LC48:
	.string	"help"
	.align 2
.LC49:
	.string	"use"
	.align 2
.LC50:
	.string	"drop"
	.align 2
.LC51:
	.string	"give"
	.align 2
.LC52:
	.string	"god"
	.align 2
.LC53:
	.string	"notarget"
	.align 2
.LC54:
	.string	"noclip"
	.align 2
.LC55:
	.string	"inven"
	.align 2
.LC56:
	.string	"invnext"
	.align 2
.LC57:
	.string	"invprev"
	.align 2
.LC58:
	.string	"invnextw"
	.align 2
.LC59:
	.string	"invprevw"
	.align 2
.LC60:
	.string	"invnextp"
	.align 2
.LC61:
	.string	"invprevp"
	.align 2
.LC62:
	.string	"invuse"
	.align 2
.LC63:
	.string	"invdrop"
	.align 2
.LC64:
	.string	"weapprev"
	.align 2
.LC65:
	.string	"weapnext"
	.align 2
.LC66:
	.string	"weaplast"
	.align 2
.LC67:
	.string	"kill"
	.align 2
.LC68:
	.string	"putaway"
	.align 2
.LC69:
	.string	"wave"
	.align 2
.LC70:
	.string	"admin"
	.align 2
.LC71:
	.string	"clanscore"
	.align 2
.LC72:
	.string	"commands"
	.align 2
.LC73:
	.string	"contact"
	.align 2
.LC74:
	.string	"credits"
	.align 2
.LC75:
	.string	"disable"
	.align 2
.LC76:
	.string	"dropquad"
	.align 2
.LC77:
	.string	"elect"
	.align 2
.LC78:
	.string	"endmatch"
	.align 2
.LC79:
	.string	"ff"
	.align 2
.LC80:
	.string	"lockdown"
	.align 2
.LC81:
	.string	"matchfragset"
	.align 2
.LC82:
	.string	"matchtimeset"
	.align 2
.LC83:
	.string	"modeset"
	.align 2
.LC84:
	.string	"modstatus"
	.align 2
.LC85:
	.string	"motd"
	.align 2
.LC86:
	.string	"myscore"
	.align 2
.LC87:
	.string	"no"
	.align 2
.LC88:
	.string	"normal"
	.align 2
.LC89:
	.string	"notready"
	.align 2
.LC90:
	.string	"observer"
	.align 2
.LC91:
	.string	"player"
	.align 2
.LC92:
	.string	"playerlist"
	.align 2
.LC93:
	.string	"powerups"
	.align 2
.LC94:
	.string	"ready"
	.align 2
.LC95:
	.string	"restart"
	.align 2
.LC96:
	.string	"shutup"
	.align 2
.LC97:
	.string	"spectator"
	.align 2
.LC98:
	.string	"team"
	.align 2
.LC99:
	.string	"timerset"
	.align 2
.LC100:
	.string	"warp"
	.align 2
.LC101:
	.string	"yes"
	.align 2
.LC102:
	.string	"teamlist"
	.align 2
.LC103:
	.string	"usedclanlist"
	.align 2
.LC104:
	.long 0x0
	.align 2
.LC105:
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
	bc 12,2,.L265
	lis 9,gi@ha
	li 3,0
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC44@ha
	la 4,.LC44@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L267
	mr 3,29
	bl Cmd_Players_f
	b .L265
.L267:
	lis 4,.LC45@ha
	mr 3,31
	la 4,.LC45@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L268
	mr 3,29
	li 4,0
	b .L510
.L268:
	lis 4,.LC46@ha
	mr 3,31
	la 4,.LC46@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L269
	mr 3,29
	li 4,1
.L510:
	li 5,0
	bl Cmd_Say_f
	b .L265
.L269:
	lis 4,.LC47@ha
	mr 3,31
	la 4,.LC47@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L270
	mr 3,29
	bl Cmd_Score_f
	b .L265
.L270:
	lis 4,.LC48@ha
	mr 3,31
	la 4,.LC48@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L271
	mr 3,29
	bl Cmd_Help_f
	b .L265
.L271:
	lis 10,.LC104@ha
	lis 9,level+200@ha
	la 10,.LC104@l(10)
	lfs 0,level+200@l(9)
	lfs 31,0(10)
	fcmpu 0,0,31
	bc 4,2,.L265
	lis 4,.LC49@ha
	mr 3,31
	la 4,.LC49@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L273
	lwz 9,164(30)
	mtlr 9
	blrl
	mr 31,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L274
	lwz 0,8(30)
	lis 5,.LC20@ha
	mr 3,29
	la 5,.LC20@l(5)
	b .L511
.L274:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L276
	lwz 0,8(30)
	lis 5,.LC21@ha
	mr 3,29
	la 5,.LC21@l(5)
	b .L512
.L276:
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
	bc 12,2,.L513
	b .L283
.L273:
	lis 4,.LC50@ha
	mr 3,31
	la 4,.LC50@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L279
	lwz 9,164(30)
	mtlr 9
	blrl
	mr 31,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L280
	lwz 0,8(30)
	lis 5,.LC20@ha
	mr 3,29
	la 5,.LC20@l(5)
	b .L511
.L280:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L282
	lwz 0,8(30)
	lis 5,.LC23@ha
	mr 3,29
	la 5,.LC23@l(5)
	b .L512
.L282:
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
	bc 4,2,.L283
.L513:
	lwz 0,8(30)
	lis 5,.LC22@ha
	mr 3,29
	la 5,.LC22@l(5)
.L511:
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L265
.L283:
	mr 3,29
	mtlr 10
	blrl
	b .L265
.L279:
	lis 4,.LC51@ha
	mr 3,31
	la 4,.LC51@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L285
	mr 3,29
	bl Cmd_Give_f
	b .L265
.L285:
	lis 4,.LC52@ha
	mr 3,31
	la 4,.LC52@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L287
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L288
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L288
	lwz 0,8(30)
	lis 5,.LC1@ha
	mr 3,29
	la 5,.LC1@l(5)
	b .L512
.L288:
	lwz 0,264(29)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(29)
	bc 4,2,.L290
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L303
.L290:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
	b .L303
.L287:
	lis 4,.LC53@ha
	mr 3,31
	la 4,.LC53@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L293
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L294
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L294
	lwz 0,8(30)
	lis 5,.LC1@ha
	mr 3,29
	la 5,.LC1@l(5)
	b .L512
.L294:
	lwz 0,264(29)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(29)
	bc 4,2,.L296
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L303
.L296:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
	b .L303
.L293:
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L299
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L300
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L300
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC1@l(5)
	b .L512
.L300:
	lwz 0,260(29)
	cmpwi 0,0,1
	bc 4,2,.L302
	li 0,4
	lis 9,.LC18@ha
	stw 0,260(29)
	la 5,.LC18@l(9)
	b .L303
.L302:
	li 0,1
	lis 9,.LC19@ha
	stw 0,260(29)
	la 5,.LC19@l(9)
.L303:
	lis 9,gi+8@ha
	mr 3,29
	lwz 0,gi+8@l(9)
.L512:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L265
.L299:
	lis 4,.LC55@ha
	mr 3,31
	la 4,.LC55@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L305
	lwz 31,84(29)
	lwz 0,3524(31)
	stw 3,3520(31)
	cmpwi 0,0,0
	stw 3,3528(31)
	bc 12,2,.L306
	stw 3,3524(31)
	b .L265
.L306:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3524(31)
	li 3,5
	lwz 0,100(9)
	addi 30,31,1760
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L310:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,30
	bc 4,1,.L310
	lis 9,gi+92@ha
	mr 3,29
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L265
.L305:
	lis 4,.LC56@ha
	mr 3,31
	la 4,.LC56@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L314
	li 0,256
	lwz 3,84(29)
	lis 9,itemlist@ha
	mtctr 0
	li 8,1
	la 5,itemlist@l(9)
	lwz 6,736(3)
	addi 7,3,740
.L509:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L319
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L319
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L502
.L319:
	addi 8,8,1
	bdnz .L509
	b .L514
.L314:
	lis 4,.LC57@ha
	mr 3,31
	la 4,.LC57@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L325
	lwz 3,84(29)
	lis 9,itemlist@ha
	li 0,256
	la 6,itemlist@l(9)
	mtctr 0
	lwz 9,736(3)
	addi 7,3,740
	addi 10,9,255
.L508:
	srawi 0,10,31
	srwi 0,0,24
	add 0,10,0
	rlwinm 0,0,0,0,23
	subf 8,0,10
	slwi 9,8,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L330
	mulli 0,8,72
	add 11,0,6
	lwz 9,8(11)
	cmpwi 0,9,0
	bc 12,2,.L330
	lwz 0,56(11)
	cmpwi 0,0,0
	bc 4,2,.L503
.L330:
	addi 10,10,-1
	bdnz .L508
	b .L514
.L325:
	lis 4,.LC58@ha
	mr 3,31
	la 4,.LC58@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L336
	li 0,256
	lwz 3,84(29)
	lis 9,itemlist@ha
	mtctr 0
	li 8,1
	la 5,itemlist@l(9)
	lwz 6,736(3)
	addi 7,3,740
.L507:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L341
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L341
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L502
.L341:
	addi 8,8,1
	bdnz .L507
	b .L514
.L336:
	lis 4,.LC59@ha
	mr 3,31
	la 4,.LC59@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L347
	lwz 3,84(29)
	lis 9,itemlist@ha
	li 0,256
	la 6,itemlist@l(9)
	mtctr 0
	lwz 9,736(3)
	addi 7,3,740
	addi 10,9,255
.L506:
	srawi 0,10,31
	srwi 0,0,24
	add 0,10,0
	rlwinm 0,0,0,0,23
	subf 8,0,10
	slwi 9,8,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L352
	mulli 0,8,72
	add 11,0,6
	lwz 9,8(11)
	cmpwi 0,9,0
	bc 12,2,.L352
	lwz 0,56(11)
	andi. 9,0,1
	bc 4,2,.L503
.L352:
	addi 10,10,-1
	bdnz .L506
	b .L514
.L347:
	lis 4,.LC60@ha
	mr 3,31
	la 4,.LC60@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L358
	li 0,256
	lwz 3,84(29)
	lis 9,itemlist@ha
	mtctr 0
	li 8,1
	la 5,itemlist@l(9)
	lwz 6,736(3)
	addi 7,3,740
.L505:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L363
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L363
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L502
.L363:
	addi 8,8,1
	bdnz .L505
	b .L514
.L358:
	lis 4,.LC61@ha
	mr 3,31
	la 4,.LC61@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L369
	lwz 3,84(29)
	lis 9,itemlist@ha
	li 0,256
	la 6,itemlist@l(9)
	mtctr 0
	lwz 9,736(3)
	addi 7,3,740
	addi 10,9,255
.L504:
	srawi 0,10,31
	srwi 0,0,24
	add 0,10,0
	rlwinm 0,0,0,0,23
	subf 8,0,10
	slwi 9,8,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L374
	mulli 0,8,72
	add 11,0,6
	lwz 9,8(11)
	cmpwi 0,9,0
	bc 12,2,.L374
	lwz 0,56(11)
	andi. 9,0,32
	bc 4,2,.L503
.L374:
	addi 10,10,-1
	bdnz .L504
.L514:
	li 0,-1
	stw 0,736(3)
	b .L265
.L369:
	lis 4,.LC62@ha
	mr 3,31
	la 4,.LC62@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L380
	mr 3,29
	bl Cmd_InvUse_f
	b .L265
.L380:
	lis 4,.LC63@ha
	mr 3,31
	la 4,.LC63@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L382
	mr 3,29
	bl Cmd_InvDrop_f
	b .L265
.L382:
	lis 4,.LC64@ha
	mr 3,31
	la 4,.LC64@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L384
	lwz 28,84(29)
	lwz 11,1792(28)
	cmpwi 0,11,0
	bc 12,2,.L265
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
.L389:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L391
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L391
	lwz 0,56(31)
	andi. 10,0,1
	bc 12,2,.L391
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1792(28)
	cmpw 0,0,31
	bc 12,2,.L265
.L391:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L389
	b .L265
.L384:
	lis 4,.LC65@ha
	mr 3,31
	la 4,.LC65@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L397
	lwz 28,84(29)
	lwz 11,1792(28)
	cmpwi 0,11,0
	bc 12,2,.L265
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
.L402:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L404
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L404
	lwz 0,56(31)
	andi. 10,0,1
	bc 12,2,.L404
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1792(28)
	cmpw 0,0,31
	bc 12,2,.L265
.L404:
	addi 27,27,1
	addi 30,30,-1
	cmpwi 0,27,256
	bc 4,1,.L402
	b .L265
.L397:
	lis 4,.LC66@ha
	mr 3,31
	la 4,.LC66@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L410
	lwz 10,84(29)
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L265
	lwz 0,1796(10)
	cmpwi 0,0,0
	bc 12,2,.L265
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
	bc 12,2,.L265
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L265
	lwz 0,56(4)
	andi. 10,0,1
	bc 12,2,.L265
	mr 3,29
	mtlr 9
	blrl
	b .L265
.L410:
	lis 4,.LC67@ha
	mr 3,31
	la 4,.LC67@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L418
	lwz 11,84(29)
	lis 9,level+4@ha
	lis 10,.LC105@ha
	lfs 0,level+4@l(9)
	la 10,.LC105@l(10)
	lfs 13,3768(11)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L265
	lwz 0,3472(11)
	cmpwi 0,0,-1
	bc 12,2,.L265
	lwz 9,264(29)
	lis 11,compmod+4@ha
	stw 3,480(29)
	rlwinm 9,9,0,28,26
	stw 9,264(29)
	lwz 0,compmod+4@l(11)
	xori 9,0,3
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,1
	subfic 10,0,0
	adde 0,10,0
	or. 11,0,9
	bc 12,2,.L422
	lis 9,meansOfDeath@ha
	li 0,34
	b .L515
.L422:
	lis 9,meansOfDeath@ha
	li 0,23
.L515:
	stw 0,meansOfDeath@l(9)
	lis 6,0x1
	lis 7,vec3_origin@ha
	mr 3,29
	la 7,vec3_origin@l(7)
	mr 4,29
	mr 5,29
	ori 6,6,34464
	bl player_die
	li 0,2
	mr 3,29
	stw 0,492(29)
	bl respawn
	b .L265
.L418:
	lis 4,.LC68@ha
	mr 3,31
	la 4,.LC68@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L425
	lwz 9,84(29)
	stw 3,3520(9)
	lwz 11,84(29)
	stw 3,3528(11)
	lwz 9,84(29)
	stw 3,3524(9)
	b .L265
.L425:
	lis 4,.LC69@ha
	mr 3,31
	la 4,.LC69@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L428
	mr 3,29
	bl Cmd_Wave_f
	b .L265
.L428:
	lis 4,.LC70@ha
	mr 3,31
	la 4,.LC70@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L430
	mr 3,29
	bl Cmd_Admin_f
	b .L265
.L430:
	lis 4,.LC71@ha
	mr 3,31
	la 4,.LC71@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L432
	mr 3,29
	bl DumpClanScore
	b .L265
.L432:
	lis 4,.LC72@ha
	mr 3,31
	la 4,.LC72@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L434
	mr 3,29
	bl Cmd_Commands_f
	b .L265
.L434:
	lis 4,.LC73@ha
	mr 3,31
	la 4,.LC73@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L436
	mr 3,29
	bl Cmd_Contact_f
	b .L265
.L436:
	lis 4,.LC74@ha
	mr 3,31
	la 4,.LC74@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L438
	mr 3,29
	bl Cmd_Credits_f
	b .L265
.L438:
	lis 4,.LC75@ha
	mr 3,31
	la 4,.LC75@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L440
	mr 3,29
	bl Cmd_Disable_f
	b .L265
.L440:
	lis 4,.LC76@ha
	mr 3,31
	la 4,.LC76@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L442
	mr 3,29
	bl Cmd_DropQuad_f
	b .L265
.L442:
	lis 4,.LC77@ha
	mr 3,31
	la 4,.LC77@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L444
	mr 3,29
	bl Cmd_Elect_f
	b .L265
.L444:
	lis 4,.LC78@ha
	mr 3,31
	la 4,.LC78@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L446
	mr 3,29
	bl Cmd_Endmatch_f
	b .L265
.L446:
	lis 4,.LC79@ha
	mr 3,31
	la 4,.LC79@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L448
	mr 3,29
	bl Cmd_FriendlyFire_f
	b .L265
.L448:
	lis 4,.LC80@ha
	mr 3,31
	la 4,.LC80@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L450
	mr 3,29
	bl Cmd_Lockdown_f
	b .L265
.L450:
	lis 4,.LC81@ha
	mr 3,31
	la 4,.LC81@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L452
	mr 3,29
	bl Cmd_MatchFragSet_f
	b .L265
.L452:
	lis 4,.LC82@ha
	mr 3,31
	la 4,.LC82@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L454
	mr 3,29
	bl Cmd_MatchTimeSet_f
	b .L265
.L454:
	lis 4,.LC83@ha
	mr 3,31
	la 4,.LC83@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L456
	mr 3,29
	bl Cmd_ModeSet_f
	b .L265
.L456:
	lis 4,.LC84@ha
	mr 3,31
	la 4,.LC84@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L458
	mr 3,29
	bl Cmd_DisplayModMode_f
	b .L265
.L458:
	lis 4,.LC85@ha
	mr 3,31
	la 4,.LC85@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L460
	mr 3,29
	bl DisplayMOTD
	b .L265
.L460:
	lis 4,.LC86@ha
	mr 3,31
	la 4,.LC86@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L462
	mr 3,29
	bl DumpPlayerScore
	b .L265
.L462:
	lis 4,.LC87@ha
	mr 3,31
	la 4,.LC87@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L464
	mr 3,29
	li 4,0
	bl Cmd_Vote_f
	b .L265
.L464:
	lis 4,.LC88@ha
	mr 3,31
	la 4,.LC88@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L466
	mr 3,29
	bl Cmd_Normal_f
	b .L265
.L466:
	lis 4,.LC89@ha
	mr 3,31
	la 4,.LC89@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L468
	mr 3,29
	bl Cmd_NotReady_f
	b .L265
.L468:
	lis 4,.LC90@ha
	mr 3,31
	la 4,.LC90@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L516
	lis 4,.LC91@ha
	mr 3,31
	la 4,.LC91@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L472
	mr 3,29
	bl Cmd_BecomePlayer_f
	b .L265
.L472:
	lis 4,.LC92@ha
	mr 3,31
	la 4,.LC92@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L474
	mr 3,29
	bl Cmd_PlayerList_f
	b .L265
.L474:
	lis 4,.LC93@ha
	mr 3,31
	la 4,.LC93@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L476
	mr 3,29
	bl Cmd_Powerups_f
	b .L265
.L476:
	lis 4,.LC94@ha
	mr 3,31
	la 4,.LC94@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L478
	mr 3,29
	bl Cmd_Ready_f
	b .L265
.L478:
	lis 4,.LC95@ha
	mr 3,31
	la 4,.LC95@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L480
	mr 3,29
	bl Cmd_Restart_f
	b .L265
.L480:
	lis 4,.LC96@ha
	mr 3,31
	la 4,.LC96@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L482
	mr 3,29
	bl Cmd_ShutUp_f
	b .L265
.L482:
	lis 4,.LC97@ha
	mr 3,31
	la 4,.LC97@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L484
.L516:
	mr 3,29
	bl Cmd_BecomeSpectator_f
	b .L265
.L484:
	lis 4,.LC98@ha
	mr 3,31
	la 4,.LC98@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L486
	mr 3,29
	bl Cmd_Team_f
	b .L265
.L486:
	lis 4,.LC99@ha
	mr 3,31
	la 4,.LC99@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L488
	mr 3,29
	bl Cmd_TimerSet_f
	b .L265
.L488:
	lis 4,.LC100@ha
	mr 3,31
	la 4,.LC100@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L490
	mr 3,29
	bl Cmd_Warp_f
	b .L265
.L490:
	lis 4,.LC101@ha
	mr 3,31
	la 4,.LC101@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L492
	mr 3,29
	li 4,1
	bl Cmd_Vote_f
	b .L265
.L492:
	lis 4,.LC102@ha
	mr 3,31
	la 4,.LC102@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L494
	mr 3,29
	li 4,0
	bl Cmd_ClanList_f
	b .L265
.L494:
	lis 4,.LC103@ha
	mr 3,31
	la 4,.LC103@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L496
	mr 3,29
	li 4,1
	bl Cmd_ClanList_f
	b .L265
.L502:
	stw 11,736(3)
	b .L265
.L503:
	stw 8,736(3)
	b .L265
.L496:
	mr 3,29
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L265:
	lwz 0,52(1)
	mtlr 0
	lmw 25,12(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 ClientCommand,.Lfe8-ClientCommand
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
.L517:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L56
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L56
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 12,2,.L56
	stw 11,736(8)
	blr
.L56:
	addi 7,7,1
	bdnz .L517
	li 0,-1
	stw 0,736(8)
	blr
.Lfe9:
	.size	 ValidateSelectedItem,.Lfe9-ValidateSelectedItem
	.comm	compmod,284,4
	.comm	team,221,1
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
	bc 12,2,.L519
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
	bc 12,2,.L519
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L9
	addi 3,3,1
	b .L518
.L9:
	stb 30,0(3)
.L519:
	mr 3,31
.L518:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 ClientTeam,.Lfe10-ClientTeam
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
.L520:
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
	bc 12,2,.L35
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L35
	lwz 0,56(10)
	and. 9,0,4
	bc 12,2,.L35
	stw 11,736(8)
	blr
.L35:
	addi 7,7,1
	bdnz .L520
	li 0,-1
	stw 0,736(8)
	blr
.Lfe11:
	.size	 SelectNextItem,.Lfe11-SelectNextItem
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
.L521:
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
	bc 12,2,.L44
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L44
	lwz 0,56(10)
	and. 9,0,4
	bc 12,2,.L44
	stw 11,736(8)
	blr
.L44:
	addi 7,7,1
	bdnz .L521
	li 0,-1
	stw 0,736(8)
	blr
.Lfe12:
	.size	 SelectPrevItem,.Lfe12-SelectPrevItem
	.section	".rodata"
	.align 2
.LC106:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC106@ha
	lis 9,deathmatch@ha
	la 11,.LC106@l(11)
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
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L119
.L118:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
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
.Lfe13:
	.size	 Cmd_God_f,.Lfe13-Cmd_God_f
	.section	".rodata"
	.align 2
.LC107:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
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
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L123
.L122:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
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
.Lfe14:
	.size	 Cmd_Notarget_f,.Lfe14-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC108:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
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
	lis 9,.LC18@ha
	stw 0,260(3)
	la 5,.LC18@l(9)
	b .L127
.L126:
	li 0,1
	lis 9,.LC19@ha
	stw 0,260(3)
	la 5,.LC19@l(9)
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
.Lfe15:
	.size	 Cmd_Noclip_f,.Lfe15-Cmd_Noclip_f
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
	bc 4,2,.L129
	lwz 0,8(29)
	lis 5,.LC20@ha
	mr 3,31
	la 5,.LC20@l(5)
	b .L522
.L129:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L130
	lwz 0,8(29)
	lis 5,.LC21@ha
	mr 3,31
	la 5,.LC21@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L128
.L130:
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
	bc 4,2,.L131
	lwz 0,8(29)
	lis 5,.LC22@ha
	mr 3,31
	la 5,.LC22@l(5)
.L522:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L128
.L131:
	mr 3,31
	mtlr 10
	blrl
.L128:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 Cmd_Use_f,.Lfe16-Cmd_Use_f
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
	bc 4,2,.L133
	lwz 0,8(29)
	lis 5,.LC20@ha
	mr 3,31
	la 5,.LC20@l(5)
	b .L523
.L133:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L134
	lwz 0,8(29)
	lis 5,.LC23@ha
	mr 3,31
	la 5,.LC23@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L132
.L134:
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
	bc 4,2,.L135
	lwz 0,8(29)
	lis 5,.LC22@ha
	mr 3,31
	la 5,.LC22@l(5)
.L523:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L132
.L135:
	mr 3,31
	mtlr 10
	blrl
.L132:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 Cmd_Drop_f,.Lfe17-Cmd_Drop_f
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
	lwz 0,3524(31)
	stw 9,3520(31)
	cmpwi 0,0,0
	stw 9,3528(31)
	bc 12,2,.L137
	stw 9,3524(31)
	b .L136
.L137:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3524(31)
	li 3,5
	lwz 0,100(9)
	addi 30,31,1760
	mr 29,9
	addi 31,31,740
	mtlr 0
	blrl
.L141:
	lwz 9,104(29)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,30
	bc 4,1,.L141
	lis 9,gi+92@ha
	mr 3,28
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L136:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 Cmd_Inven_f,.Lfe18-Cmd_Inven_f
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
.L165:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L164
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L164
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L164
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1792(29)
	cmpw 0,0,31
	bc 12,2,.L160
.L164:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L165
.L160:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe19:
	.size	 Cmd_WeapPrev_f,.Lfe19-Cmd_WeapPrev_f
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
	bc 12,2,.L171
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
.L176:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L175
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L175
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L175
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1792(29)
	cmpw 0,0,31
	bc 12,2,.L171
.L175:
	addi 28,28,1
	addi 30,30,-1
	cmpwi 0,28,256
	bc 4,1,.L176
.L171:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 Cmd_WeapNext_f,.Lfe20-Cmd_WeapNext_f
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
	bc 12,2,.L182
	lwz 0,1796(10)
	cmpwi 0,0,0
	bc 12,2,.L182
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
	bc 12,2,.L182
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L182
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L182
	mtlr 9
	blrl
.L182:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 Cmd_WeapLast_f,.Lfe21-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC109:
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
	lis 9,level+4@ha
	lwz 11,84(31)
	lis 10,.LC109@ha
	lfs 0,level+4@l(9)
	la 10,.LC109@l(10)
	lfs 13,3768(11)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L205
	lwz 0,3472(11)
	cmpwi 0,0,-1
	bc 12,2,.L205
	lwz 9,264(31)
	li 0,0
	lis 11,compmod+4@ha
	stw 0,480(31)
	rlwinm 9,9,0,28,26
	stw 9,264(31)
	lwz 0,compmod+4@l(11)
	xori 9,0,3
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,1
	subfic 10,0,0
	adde 0,10,0
	or. 11,0,9
	bc 12,2,.L208
	lis 9,meansOfDeath@ha
	li 0,34
	b .L524
.L208:
	lis 9,meansOfDeath@ha
	li 0,23
.L524:
	stw 0,meansOfDeath@l(9)
	lis 6,0x1
	lis 7,vec3_origin@ha
	mr 3,31
	la 7,vec3_origin@l(7)
	mr 4,31
	mr 5,31
	ori 6,6,34464
	bl player_die
	li 0,2
	mr 3,31
	stw 0,492(31)
	bl respawn
.L205:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe22:
	.size	 Cmd_Kill_f,.Lfe22-Cmd_Kill_f
	.align 2
	.globl Cmd_PutAway_f
	.type	 Cmd_PutAway_f,@function
Cmd_PutAway_f:
	lwz 9,84(3)
	li 0,0
	stw 0,3520(9)
	lwz 11,84(3)
	stw 0,3528(11)
	lwz 9,84(3)
	stw 0,3524(9)
	blr
.Lfe23:
	.size	 Cmd_PutAway_f,.Lfe23-Cmd_PutAway_f
	.align 2
	.globl PlayerSort
	.type	 PlayerSort,@function
PlayerSort:
	lwz 9,0(3)
	lis 11,game+1028@ha
	lwz 3,0(4)
	lwz 0,game+1028@l(11)
	mulli 9,9,3772
	mulli 11,3,3772
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
.Lfe24:
	.size	 PlayerSort,.Lfe24-PlayerSort
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
