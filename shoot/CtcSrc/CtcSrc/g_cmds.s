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
	stmw 24,16(1)
	stw 0,52(1)
	stw 12,12(1)
	lis 9,deathmatch@ha
	lis 10,.LC13@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC13@l(10)
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
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L58
.L59:
	mr 3,31
	bl Chicken_Cheat
	cmpwi 0,3,0
	bc 12,2,.L58
	lis 9,gi@ha
	la 30,gi@l(9)
	lwz 9,164(30)
	mtlr 9
	blrl
	mr 26,3
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	bl Q_stricmp
	subfic 0,3,0
	adde. 28,0,3
	mfcr 29
	bc 4,2,.L64
	lwz 9,160(30)
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
	bc 4,2,.L63
.L64:
	lwz 9,156(30)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L65
	lwz 0,160(30)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	stw 3,480(31)
	b .L66
.L65:
	lwz 0,484(31)
	stw 0,480(31)
.L66:
	cmpwi 4,28,0
	bc 12,18,.L58
.L63:
	bc 4,18,.L69
	lis 4,.LC4@ha
	mr 3,26
	la 4,.LC4@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L68
.L69:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L71
	lis 9,itemlist@ha
	mr 24,11
	la 30,itemlist@l(9)
	lis 25,chickenItem@ha
	li 28,0
.L73:
	mr 27,30
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L72
	lwz 0,56(27)
	andi. 9,0,1
	bc 12,2,.L72
	lwz 9,chickenItem@l(25)
	lwz 3,0(27)
	lwz 4,0(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L72
	lwz 11,84(31)
	addi 11,11,740
	lwzx 9,11,28
	addi 9,9,1
	stwx 9,11,28
.L72:
	lwz 0,1556(24)
	addi 29,29,1
	addi 28,28,4
	addi 30,30,72
	cmpw 0,29,0
	bc 12,0,.L73
.L71:
	bc 12,18,.L58
.L68:
	bc 4,18,.L80
	lis 4,.LC5@ha
	mr 3,26
	la 4,.LC5@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L79
.L80:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L82
	lis 9,itemlist@ha
	mr 30,11
	la 28,itemlist@l(9)
.L84:
	mr 27,28
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L83
	lwz 0,56(27)
	andi. 9,0,2
	bc 12,2,.L83
	mr 4,27
	mr 3,31
	li 5,1000
	bl Add_Ammo
.L83:
	lwz 0,1556(30)
	addi 29,29,1
	addi 28,28,72
	cmpw 0,29,0
	bc 12,0,.L84
.L82:
	bc 12,18,.L58
.L79:
	bc 4,18,.L90
	lis 4,.LC6@ha
	mr 3,26
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L89
.L90:
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
	bc 12,18,.L58
.L89:
	bc 4,18,.L93
	lis 4,.LC10@ha
	mr 3,26
	la 4,.LC10@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L92
.L93:
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
	bc 12,2,.L94
	mr 3,29
	bl G_FreeEdict
.L94:
	bc 12,18,.L58
.L92:
	bc 12,18,.L96
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
.L100:
	lwz 0,4(11)
	cmpwi 0,0,0
	bc 12,2,.L99
	lwz 0,56(11)
	andi. 9,0,7
	bc 4,2,.L99
	lwz 9,84(31)
	addi 9,9,740
	stwx 8,9,10
.L99:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 11,11,72
	cmpw 0,29,0
	bc 12,0,.L100
	b .L58
.L96:
	mr 3,26
	bl FindItem
	mr. 27,3
	bc 4,2,.L104
	lis 9,gi@ha
	li 3,1
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	bl FindItem
	mr. 27,3
	bc 4,2,.L104
	lwz 0,4(30)
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	b .L112
.L104:
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 4,2,.L106
	lis 9,gi+4@ha
	lis 3,.LC12@ha
	lwz 0,gi+4@l(9)
	la 3,.LC12@l(3)
.L112:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L58
.L106:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,56(27)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,27
	andi. 10,11,2
	mullw 9,9,0
	srawi 29,9,3
	bc 12,2,.L107
	lis 9,gi@ha
	la 30,gi@l(9)
	lwz 9,156(30)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L108
	lwz 0,160(30)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	slwi 0,29,2
	addi 9,9,740
	stwx 3,9,0
	b .L58
.L108:
	lwz 9,84(31)
	slwi 10,29,2
	lwz 11,48(27)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L58
.L107:
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
	lwz 12,12(1)
	mtlr 0
	lmw 24,16(1)
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
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	bl Chicken_InvUse
	cmpwi 0,3,0
	bc 12,2,.L143
	lwz 30,84(31)
	lwz 0,736(30)
	addi 29,30,740
	slwi 0,0,2
	lwzx 9,29,0
	cmpwi 0,9,0
	bc 4,2,.L146
	mr 3,31
	bl Chicken_SelectNextItem
	cmpwi 0,3,0
	bc 12,2,.L146
	li 0,256
	lis 9,itemlist@ha
	lwz 6,736(30)
	mtctr 0
	mr 7,29
	la 5,itemlist@l(9)
	li 8,1
.L160:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L153
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L153
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L159
.L153:
	addi 8,8,1
	bdnz .L160
	li 0,-1
	stw 0,736(30)
.L146:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L157
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC24@l(5)
	b .L161
.L159:
	stw 11,736(30)
	b .L146
.L157:
	mulli 0,0,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L158
	lis 9,gi+8@ha
	lis 5,.LC21@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC21@l(5)
.L161:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L143
.L158:
	mr 3,31
	mtlr 0
	blrl
.L143:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
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
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	bl Chicken_InvDrop
	cmpwi 0,3,0
	bc 4,2,.L193
	lwz 30,84(31)
	lwz 0,736(30)
	addi 29,30,740
	slwi 0,0,2
	lwzx 9,29,0
	cmpwi 0,9,0
	bc 4,2,.L196
	mr 3,31
	bl Chicken_SelectNextItem
	cmpwi 0,3,0
	bc 12,2,.L196
	li 0,256
	lis 9,itemlist@ha
	lwz 6,736(30)
	mtctr 0
	mr 7,29
	la 5,itemlist@l(9)
	li 8,1
.L210:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L203
	mulli 0,11,72
	add 10,0,5
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
	stw 0,736(30)
.L196:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L207
	lis 9,gi+8@ha
	lis 5,.LC25@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC25@l(5)
	b .L211
.L209:
	stw 11,736(30)
	b .L196
.L207:
	mulli 0,0,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L208
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC23@l(5)
.L211:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L193
.L208:
	mr 3,31
	mtlr 0
	blrl
.L193:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
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
	stmw 22,2392(1)
	stw 0,2436(1)
	lis 11,.LC29@ha
	lis 9,maxclients@ha
	la 11,.LC29@l(11)
	mr 22,3
	lfs 13,0(11)
	li 26,0
	li 31,0
	lwz 11,maxclients@l(9)
	addi 30,1,1352
	addi 28,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L220
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,30
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L222:
	lwz 0,0(11)
	addi 11,11,3832
	cmpwi 0,0,0
	bc 12,2,.L221
	stw 31,0(10)
	addi 26,26,1
	addi 10,10,4
.L221:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L222
.L220:
	lis 6,PlayerSort@ha
	mr 3,30
	la 6,PlayerSort@l(6)
	mr 4,26
	li 5,4
	li 31,0
	bl qsort
	cmpw 0,31,26
	li 0,0
	stb 0,72(1)
	bc 4,0,.L226
	lis 9,game@ha
	lis 23,teams@ha
	la 27,game@l(9)
	lis 25,.LC26@ha
	lis 24,.LC27@ha
.L228:
	lwz 0,teams@l(23)
	cmpwi 0,0,0
	bc 12,2,.L229
	lwz 9,0(30)
	lwz 0,1028(27)
	mulli 9,9,3832
	add 9,9,0
	lwz 6,184(9)
	b .L230
.L229:
	lwz 9,0(30)
	lwz 0,1028(27)
	mulli 9,9,3832
	add 9,9,0
	lha 6,148(9)
.L230:
	lwz 0,0(30)
	addi 3,1,8
	li 4,64
	lwz 7,1028(27)
	la 5,.LC26@l(25)
	mulli 0,0,3832
	add 7,7,0
	addi 7,7,700
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,28
	bl strlen
	add 29,29,3
	cmplwi 0,29,1180
	bc 4,1,.L231
	la 4,.LC27@l(24)
	mr 3,28
	bl strcat
	b .L226
.L231:
	mr 3,28
	addi 4,1,8
	bl strcat
	addi 31,31,1
	addi 30,30,4
	cmpw 0,31,26
	bc 12,0,.L228
.L226:
	lis 9,gi+8@ha
	lis 5,.LC28@ha
	lwz 0,gi+8@l(9)
	mr 3,22
	la 5,.LC28@l(5)
	mr 6,28
	mr 7,26
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,2436(1)
	mtlr 0
	lmw 22,2392(1)
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
	bc 4,2,.L233
	lwz 0,3676(9)
	cmpwi 0,0,1
	bc 12,1,.L233
	cmplwi 0,3,4
	li 0,1
	stw 0,3676(9)
	bc 12,1,.L242
	lis 11,.L243@ha
	slwi 10,3,2
	la 11,.L243@l(11)
	lis 9,.L243@ha
	lwzx 0,10,11
	la 9,.L243@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L243:
	.long .L237-.L243
	.long .L238-.L243
	.long .L239-.L243
	.long .L240-.L243
	.long .L242-.L243
.L237:
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
	b .L244
.L238:
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
	b .L244
.L239:
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
	b .L244
.L240:
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
	b .L244
.L242:
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
.L244:
	stw 0,56(31)
	stw 9,3672(11)
.L233:
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
	bc 12,1,.L246
	cmpwi 0,31,0
	bc 12,2,.L245
.L246:
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
	bc 12,2,.L248
	lwz 6,84(28)
	lis 5,.LC36@ha
	addi 3,1,8
	la 5,.LC36@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L249
.L248:
	lwz 6,84(28)
	lis 5,.LC37@ha
	addi 3,1,8
	la 5,.LC37@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L249:
	cmpwi 0,31,0
	bc 12,2,.L250
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
	b .L251
.L250:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L252
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
.L252:
	mr 4,29
	addi 3,1,8
	bl strcat
.L251:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L253
	li 0,0
	stb 0,158(1)
.L253:
	lis 4,.LC39@ha
	addi 3,1,8
	la 4,.LC39@l(4)
	bl strcat
	lis 9,.LC41@ha
	lis 11,dedicated@ha
	la 9,.LC41@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L254
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
.L254:
	lis 9,game@ha
	li 31,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,31,0
	bc 12,1,.L245
	cmpwi 4,30,0
	lis 9,gi@ha
	la 24,gi@l(9)
	mr 25,11
	lis 26,g_edicts@ha
	lis 27,.LC40@ha
	li 30,896
.L258:
	lwz 0,g_edicts@l(26)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L257
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L257
	bc 12,18,.L261
	mr 3,28
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L257
.L261:
	lwz 9,8(24)
	mr 3,29
	li 4,3
	la 5,.LC40@l(27)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L257:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,896
	cmpw 0,31,0
	bc 4,1,.L258
.L245:
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
.LC42:
	.string	"players"
	.align 2
.LC43:
	.string	"say"
	.align 2
.LC44:
	.string	"say_team"
	.align 2
.LC45:
	.string	"score"
	.align 2
.LC46:
	.string	"help"
	.align 2
.LC47:
	.string	"use"
	.align 2
.LC48:
	.string	"drop"
	.align 2
.LC49:
	.string	"give"
	.align 2
.LC50:
	.string	"god"
	.align 2
.LC51:
	.string	"notarget"
	.align 2
.LC52:
	.string	"noclip"
	.align 2
.LC53:
	.string	"inven"
	.align 2
.LC54:
	.string	"invnext"
	.align 2
.LC55:
	.string	"invprev"
	.align 2
.LC56:
	.string	"invnextw"
	.align 2
.LC57:
	.string	"invprevw"
	.align 2
.LC58:
	.string	"invnextp"
	.align 2
.LC59:
	.string	"invprevp"
	.align 2
.LC60:
	.string	"invuse"
	.align 2
.LC61:
	.string	"invdrop"
	.align 2
.LC62:
	.string	"weapprev"
	.align 2
.LC63:
	.string	"weapnext"
	.align 2
.LC64:
	.string	"weaplast"
	.align 2
.LC65:
	.string	"kill"
	.align 2
.LC66:
	.string	"putaway"
	.align 2
.LC67:
	.string	"wave"
	.align 2
.LC68:
	.string	"observer"
	.align 2
.LC69:
	.string	"chicken"
	.align 2
.LC70:
	.string	"options"
	.align 2
.LC71:
	.string	"cam"
	.align 2
.LC72:
	.long 0x0
	.align 2
.LC73:
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
	bc 12,2,.L264
	lis 9,gi@ha
	li 3,0
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC42@ha
	la 4,.LC42@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L266
	mr 3,29
	bl Cmd_Players_f
	b .L264
.L266:
	lis 4,.LC43@ha
	mr 3,31
	la 4,.LC43@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L267
	mr 3,29
	li 4,0
	b .L458
.L267:
	lis 4,.LC44@ha
	mr 3,31
	la 4,.LC44@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L268
	mr 3,29
	li 4,1
.L458:
	li 5,0
	bl Cmd_Say_f
	b .L264
.L268:
	lis 4,.LC45@ha
	mr 3,31
	la 4,.LC45@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L269
	mr 3,29
	bl Cmd_Score_f
	b .L264
.L269:
	lis 4,.LC46@ha
	mr 3,31
	la 4,.LC46@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L270
	mr 3,29
	bl Cmd_Help_f
	b .L264
.L270:
	lis 10,.LC72@ha
	lis 9,level+200@ha
	la 10,.LC72@l(10)
	lfs 0,level+200@l(9)
	lfs 31,0(10)
	fcmpu 0,0,31
	bc 4,2,.L264
	lis 4,.LC47@ha
	mr 3,31
	la 4,.LC47@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L272
	lwz 9,164(30)
	mtlr 9
	blrl
	mr 31,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L273
	lwz 0,8(30)
	lis 5,.LC20@ha
	mr 3,29
	la 5,.LC20@l(5)
	b .L459
.L273:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L275
	lwz 0,8(30)
	lis 5,.LC21@ha
	mr 3,29
	la 5,.LC21@l(5)
	b .L460
.L275:
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
	bc 12,2,.L461
	b .L282
.L272:
	lis 4,.LC48@ha
	mr 3,31
	la 4,.LC48@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L278
	lwz 9,164(30)
	mtlr 9
	blrl
	mr 31,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L279
	lwz 0,8(30)
	lis 5,.LC20@ha
	mr 3,29
	la 5,.LC20@l(5)
	b .L459
.L279:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L281
	lwz 0,8(30)
	lis 5,.LC23@ha
	mr 3,29
	la 5,.LC23@l(5)
	b .L460
.L281:
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
	bc 4,2,.L282
.L461:
	lwz 0,8(30)
	lis 5,.LC22@ha
	mr 3,29
	la 5,.LC22@l(5)
.L459:
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L264
.L282:
	mr 3,29
	mtlr 10
	blrl
	b .L264
.L278:
	lis 4,.LC49@ha
	mr 3,31
	la 4,.LC49@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L284
	mr 3,29
	bl Cmd_Give_f
	b .L264
.L284:
	lis 4,.LC50@ha
	mr 3,31
	la 4,.LC50@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L286
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L287
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L287
	lwz 0,8(30)
	lis 5,.LC1@ha
	mr 3,29
	la 5,.LC1@l(5)
	b .L460
.L287:
	mr 3,29
	bl Chicken_Cheat
	cmpwi 0,3,0
	bc 12,2,.L264
	lwz 0,264(29)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(29)
	bc 4,2,.L290
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L305
.L290:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
	b .L305
.L286:
	lis 4,.LC51@ha
	mr 3,31
	la 4,.LC51@l(4)
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
	b .L460
.L294:
	mr 3,29
	bl Chicken_Cheat
	cmpwi 0,3,0
	bc 12,2,.L264
	lwz 0,264(29)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(29)
	bc 4,2,.L297
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L305
.L297:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
	b .L305
.L293:
	lis 4,.LC52@ha
	mr 3,31
	la 4,.LC52@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L300
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L301
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L301
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC1@l(5)
	b .L460
.L301:
	mr 3,29
	bl Chicken_Cheat
	cmpwi 0,3,0
	bc 12,2,.L264
	lwz 0,260(29)
	cmpwi 0,0,1
	bc 4,2,.L304
	li 0,4
	lis 9,.LC18@ha
	stw 0,260(29)
	la 5,.LC18@l(9)
	b .L305
.L304:
	li 0,1
	lis 9,.LC19@ha
	stw 0,260(29)
	la 5,.LC19@l(9)
.L305:
	lis 9,gi+8@ha
	mr 3,29
	lwz 0,gi+8@l(9)
.L460:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L264
.L300:
	lis 4,.LC53@ha
	mr 3,31
	la 4,.LC53@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L307
	lwz 31,84(29)
	lwz 0,3480(31)
	stw 3,3476(31)
	cmpwi 0,0,0
	stw 3,3484(31)
	stw 3,3728(31)
	bc 12,2,.L308
	stw 3,3480(31)
	b .L264
.L308:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3480(31)
	li 3,5
	lwz 0,100(9)
	addi 30,31,1760
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L312:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,30
	bc 4,1,.L312
	lis 9,gi+92@ha
	mr 3,29
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L264
.L307:
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L316
	mr 3,29
	lwz 31,84(29)
	bl Chicken_SelectNextItem
	cmpwi 0,3,0
	bc 12,2,.L264
	li 0,256
	lis 9,itemlist@ha
	lwz 6,736(31)
	mtctr 0
	li 8,1
	la 5,itemlist@l(9)
	addi 7,31,740
.L457:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L323
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L323
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L450
.L323:
	addi 8,8,1
	bdnz .L457
	b .L462
.L316:
	lis 4,.LC55@ha
	mr 3,31
	la 4,.LC55@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L328
	mr 3,29
	bl Chicken_SelectPrevItem
	cmpwi 0,3,0
	bc 12,2,.L264
	lwz 3,84(29)
	lis 9,itemlist@ha
	li 0,256
	la 6,itemlist@l(9)
	mtctr 0
	lwz 9,736(3)
	addi 7,3,740
	addi 10,9,255
.L456:
	srawi 0,10,31
	srwi 0,0,24
	add 0,10,0
	rlwinm 0,0,0,0,23
	subf 8,0,10
	slwi 9,8,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L335
	mulli 0,8,72
	add 11,0,6
	lwz 9,8(11)
	cmpwi 0,9,0
	bc 12,2,.L335
	lwz 0,56(11)
	cmpwi 0,0,0
	bc 4,2,.L451
.L335:
	addi 10,10,-1
	bdnz .L456
	b .L463
.L328:
	lis 4,.LC56@ha
	mr 3,31
	la 4,.LC56@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L340
	mr 3,29
	lwz 31,84(29)
	bl Chicken_SelectNextItem
	cmpwi 0,3,0
	bc 12,2,.L264
	li 0,256
	lis 9,itemlist@ha
	lwz 6,736(31)
	mtctr 0
	li 8,1
	la 5,itemlist@l(9)
	addi 7,31,740
.L455:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L347
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L347
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L450
.L347:
	addi 8,8,1
	bdnz .L455
	b .L462
.L340:
	lis 4,.LC57@ha
	mr 3,31
	la 4,.LC57@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L352
	mr 3,29
	bl Chicken_SelectPrevItem
	cmpwi 0,3,0
	bc 12,2,.L264
	lwz 3,84(29)
	lis 9,itemlist@ha
	li 0,256
	la 6,itemlist@l(9)
	mtctr 0
	lwz 9,736(3)
	addi 7,3,740
	addi 10,9,255
.L454:
	srawi 0,10,31
	srwi 0,0,24
	add 0,10,0
	rlwinm 0,0,0,0,23
	subf 8,0,10
	slwi 9,8,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L359
	mulli 0,8,72
	add 11,0,6
	lwz 9,8(11)
	cmpwi 0,9,0
	bc 12,2,.L359
	lwz 0,56(11)
	andi. 9,0,1
	bc 4,2,.L451
.L359:
	addi 10,10,-1
	bdnz .L454
	b .L463
.L352:
	lis 4,.LC58@ha
	mr 3,31
	la 4,.LC58@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L364
	mr 3,29
	lwz 31,84(29)
	bl Chicken_SelectNextItem
	cmpwi 0,3,0
	bc 12,2,.L264
	li 0,256
	lis 9,itemlist@ha
	lwz 6,736(31)
	mtctr 0
	li 8,1
	la 5,itemlist@l(9)
	addi 7,31,740
.L453:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L371
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L371
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L450
.L371:
	addi 8,8,1
	bdnz .L453
.L462:
	li 0,-1
	stw 0,736(31)
	b .L264
.L364:
	lis 4,.LC59@ha
	mr 3,31
	la 4,.LC59@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L376
	mr 3,29
	bl Chicken_SelectPrevItem
	cmpwi 0,3,0
	bc 12,2,.L264
	lwz 3,84(29)
	lis 9,itemlist@ha
	li 0,256
	la 6,itemlist@l(9)
	mtctr 0
	lwz 9,736(3)
	addi 7,3,740
	addi 10,9,255
.L452:
	srawi 0,10,31
	srwi 0,0,24
	add 0,10,0
	rlwinm 0,0,0,0,23
	subf 8,0,10
	slwi 9,8,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L383
	mulli 0,8,72
	add 11,0,6
	lwz 9,8(11)
	cmpwi 0,9,0
	bc 12,2,.L383
	lwz 0,56(11)
	andi. 9,0,32
	bc 4,2,.L451
.L383:
	addi 10,10,-1
	bdnz .L452
.L463:
	li 0,-1
	stw 0,736(3)
	b .L264
.L376:
	lis 4,.LC60@ha
	mr 3,31
	la 4,.LC60@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L388
	mr 3,29
	bl Cmd_InvUse_f
	b .L264
.L388:
	lis 4,.LC61@ha
	mr 3,31
	la 4,.LC61@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L390
	mr 3,29
	bl Cmd_InvDrop_f
	b .L264
.L390:
	lis 4,.LC62@ha
	mr 3,31
	la 4,.LC62@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L392
	lwz 28,84(29)
	lwz 0,1788(28)
	cmpwi 0,0,0
	bc 12,2,.L264
	mr 3,29
	bl Chicken_SelectNextItem
	cmpwi 0,3,0
	bc 12,2,.L264
	lwz 0,1788(28)
	lis 9,itemlist@ha
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	subf 0,9,0
	mr 25,9
	mullw 0,0,11
	li 30,1
	addi 26,28,740
	srawi 27,0,3
.L398:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L400
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L400
	lwz 0,56(31)
	andi. 10,0,1
	bc 12,2,.L400
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L264
.L400:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L398
	b .L264
.L392:
	lis 4,.LC63@ha
	mr 3,31
	la 4,.LC63@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L406
	lwz 28,84(29)
	lwz 0,1788(28)
	cmpwi 0,0,0
	bc 12,2,.L264
	mr 3,29
	bl Chicken_SelectNextItem
	cmpwi 0,3,0
	bc 12,2,.L264
	lwz 9,1788(28)
	lis 11,itemlist@ha
	lis 0,0x38e3
	la 11,itemlist@l(11)
	ori 0,0,36409
	subf 9,11,9
	mr 25,11
	mullw 9,9,0
	li 27,1
	addi 26,28,740
	srawi 9,9,3
	addi 30,9,255
.L412:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L414
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L414
	lwz 0,56(31)
	andi. 10,0,1
	bc 12,2,.L414
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L264
.L414:
	addi 27,27,1
	addi 30,30,-1
	cmpwi 0,27,256
	bc 4,1,.L412
	b .L264
.L406:
	lis 4,.LC64@ha
	mr 3,31
	la 4,.LC64@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L420
	lwz 31,84(29)
	lwz 0,1788(31)
	cmpwi 0,0,0
	bc 12,2,.L264
	lwz 0,1792(31)
	cmpwi 0,0,0
	bc 12,2,.L264
	mr 3,29
	bl Chicken_SelectPrevItem
	cmpwi 0,3,0
	bc 12,2,.L264
	lis 11,itemlist@ha
	lwz 9,1792(31)
	lis 0,0x38e3
	la 4,itemlist@l(11)
	ori 0,0,36409
	subf 9,4,9
	addi 11,31,740
	mullw 9,9,0
	srawi 10,9,3
	slwi 0,10,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L264
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L264
	lwz 0,56(4)
	andi. 10,0,1
	bc 12,2,.L264
	mr 3,29
	mtlr 9
	blrl
	b .L264
.L420:
	lis 4,.LC65@ha
	mr 3,31
	la 4,.LC65@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L429
	lwz 11,84(29)
	lis 9,level+4@ha
	lis 10,.LC73@ha
	lfs 0,level+4@l(9)
	la 10,.LC73@l(10)
	lfs 13,3724(11)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L264
	lwz 0,264(29)
	lis 11,meansOfDeath@ha
	li 9,23
	stw 3,480(29)
	lis 6,0x1
	lis 7,vec3_origin@ha
	rlwinm 0,0,0,28,26
	la 7,vec3_origin@l(7)
	stw 0,264(29)
	mr 3,29
	mr 4,29
	stw 9,meansOfDeath@l(11)
	mr 5,29
	ori 6,6,34464
	bl player_die
	mr 3,29
	bl Chicken_Kill
	mr 3,29
	bl respawn
	b .L264
.L429:
	lis 4,.LC66@ha
	mr 3,31
	la 4,.LC66@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L433
	lwz 9,84(29)
	stw 3,3476(9)
	lwz 11,84(29)
	stw 3,3484(11)
	lwz 9,84(29)
	stw 3,3480(9)
	lwz 11,84(29)
	stw 3,3728(11)
	b .L264
.L433:
	lis 4,.LC67@ha
	mr 3,31
	la 4,.LC67@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L436
	mr 3,29
	bl Cmd_Wave_f
	b .L264
.L436:
	lis 4,.LC68@ha
	mr 3,31
	la 4,.LC68@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L438
	mr 3,29
	bl Chicken_GoObserver
	b .L264
.L438:
	lis 4,.LC69@ha
	mr 3,31
	la 4,.LC69@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L440
	mr 3,29
	bl Chicken_Command
	b .L264
.L440:
	lis 4,.LC70@ha
	mr 3,31
	la 4,.LC70@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L442
	mr 3,29
	bl Chicken_Banner
	b .L264
.L442:
	lis 4,.LC71@ha
	mr 3,31
	la 4,.LC71@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L444
	mr 3,29
	crxor 6,6,6
	bl CameraCmd
	b .L264
.L450:
	stw 11,736(31)
	b .L264
.L451:
	stw 8,736(3)
	b .L264
.L444:
	mr 3,29
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L264:
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
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lwz 31,84(3)
	lwz 0,736(31)
	addi 30,31,740
	slwi 0,0,2
	lwzx 9,30,0
	cmpwi 0,9,0
	bc 4,2,.L46
	bl Chicken_SelectNextItem
	cmpwi 0,3,0
	bc 12,2,.L46
	li 0,256
	lis 9,itemlist@ha
	lwz 6,736(31)
	mtctr 0
	mr 7,30
	la 5,itemlist@l(9)
	li 8,1
.L464:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L54
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L54
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 12,2,.L54
	stw 11,736(31)
	b .L46
.L54:
	addi 8,8,1
	bdnz .L464
	li 0,-1
	stw 0,736(31)
.L46:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 ValidateSelectedItem,.Lfe9-ValidateSelectedItem
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
	bc 12,2,.L466
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
	bc 12,2,.L466
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L9
	addi 3,3,1
	b .L465
.L9:
	stb 30,0(3)
.L466:
	mr 3,31
.L465:
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
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,4
	lwz 31,84(3)
	bl Chicken_SelectNextItem
	cmpwi 0,3,0
	bc 12,2,.L26
	li 0,256
	lis 9,itemlist@ha
	lwz 6,736(31)
	mtctr 0
	li 8,1
	la 5,itemlist@l(9)
	addi 7,31,740
.L467:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L30
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L30
	lwz 0,56(10)
	and. 9,0,30
	bc 12,2,.L30
	stw 11,736(31)
	b .L26
.L30:
	addi 8,8,1
	bdnz .L467
	li 0,-1
	stw 0,736(31)
.L26:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 SelectNextItem,.Lfe11-SelectNextItem
	.align 2
	.globl SelectPrevItem
	.type	 SelectPrevItem,@function
SelectPrevItem:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	bl Chicken_SelectPrevItem
	cmpwi 0,3,0
	bc 12,2,.L36
	li 0,256
	lwz 3,84(31)
	lis 9,itemlist@ha
	mtctr 0
	li 8,1
	la 6,itemlist@l(9)
	addi 7,3,740
.L468:
	lwz 11,736(3)
	addi 9,8,-256
	subf 11,9,11
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L40
	mulli 0,11,72
	add 10,0,6
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L40
	lwz 0,56(10)
	and. 9,0,30
	bc 12,2,.L40
	stw 11,736(3)
	b .L36
.L40:
	addi 8,8,1
	bdnz .L468
	li 0,-1
	stw 0,736(3)
.L36:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 SelectPrevItem,.Lfe12-SelectPrevItem
	.section	".rodata"
	.align 2
.LC74:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC74@ha
	lis 9,deathmatch@ha
	la 11,.LC74@l(11)
	mr 31,3
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
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L113
.L114:
	mr 3,31
	bl Chicken_Cheat
	cmpwi 0,3,0
	bc 12,2,.L113
	lwz 0,264(31)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(31)
	bc 4,2,.L116
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L117
.L116:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
.L117:
	lis 9,gi+8@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L113:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe13:
	.size	 Cmd_God_f,.Lfe13-Cmd_God_f
	.section	".rodata"
	.align 2
.LC75:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC75@ha
	lis 9,deathmatch@ha
	la 11,.LC75@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L119
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L119
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L118
.L119:
	mr 3,31
	bl Chicken_Cheat
	cmpwi 0,3,0
	bc 12,2,.L118
	lwz 0,264(31)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(31)
	bc 4,2,.L121
	lis 9,.LC16@ha
	la 5,.LC16@l(9)
	b .L122
.L121:
	lis 9,.LC17@ha
	la 5,.LC17@l(9)
.L122:
	lis 9,gi+8@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L118:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 Cmd_Notarget_f,.Lfe14-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC76:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC76@ha
	lis 9,deathmatch@ha
	la 11,.LC76@l(11)
	mr 31,3
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
	mr 3,31
	bl Chicken_Cheat
	cmpwi 0,3,0
	bc 12,2,.L123
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 4,2,.L126
	li 0,4
	lis 9,.LC18@ha
	stw 0,260(31)
	la 5,.LC18@l(9)
	b .L127
.L126:
	li 0,1
	lis 9,.LC19@ha
	stw 0,260(31)
	la 5,.LC19@l(9)
.L127:
	lis 9,gi+8@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L123:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
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
	b .L469
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
.L469:
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
	b .L470
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
.L470:
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
	lwz 0,3480(31)
	stw 9,3476(31)
	cmpwi 0,0,0
	stw 9,3484(31)
	stw 9,3728(31)
	bc 12,2,.L137
	stw 9,3480(31)
	b .L136
.L137:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3480(31)
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
	lwz 0,1788(29)
	cmpwi 0,0,0
	bc 12,2,.L162
	bl Chicken_SelectNextItem
	cmpwi 0,3,0
	bc 12,2,.L162
	lwz 0,1788(29)
	lis 9,itemlist@ha
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	subf 0,9,0
	mr 25,9
	mullw 0,0,11
	li 30,1
	addi 26,29,740
	srawi 27,0,3
.L168:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L167
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L167
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L167
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L162
.L167:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L168
.L162:
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
	lwz 0,1788(29)
	cmpwi 0,0,0
	bc 12,2,.L174
	bl Chicken_SelectNextItem
	cmpwi 0,3,0
	bc 12,2,.L174
	lwz 9,1788(29)
	lis 11,itemlist@ha
	lis 0,0x38e3
	la 11,itemlist@l(11)
	ori 0,0,36409
	subf 9,11,9
	mr 25,11
	mullw 9,9,0
	li 28,1
	addi 26,29,740
	srawi 9,9,3
	addi 30,9,255
.L180:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
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
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L174
.L179:
	addi 28,28,1
	addi 30,30,-1
	cmpwi 0,28,256
	bc 4,1,.L180
.L174:
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
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,3
	lwz 31,84(30)
	lwz 0,1788(31)
	cmpwi 0,0,0
	bc 12,2,.L186
	lwz 0,1792(31)
	cmpwi 0,0,0
	bc 12,2,.L186
	bl Chicken_SelectPrevItem
	cmpwi 0,3,0
	bc 12,2,.L186
	lis 11,itemlist@ha
	lwz 9,1792(31)
	lis 0,0x38e3
	la 4,itemlist@l(11)
	ori 0,0,36409
	subf 9,4,9
	addi 11,31,740
	mullw 9,9,0
	srawi 10,9,3
	slwi 0,10,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L186
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L186
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L186
	mr 3,30
	mtlr 9
	blrl
.L186:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe21:
	.size	 Cmd_WeapLast_f,.Lfe21-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC77:
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
	lis 10,.LC77@ha
	lfs 0,level+4@l(9)
	la 10,.LC77@l(10)
	lfs 13,3724(11)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L212
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
	mr 3,31
	bl Chicken_Kill
	mr 3,31
	bl respawn
.L212:
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
	stw 0,3476(9)
	lwz 11,84(3)
	stw 0,3484(11)
	lwz 9,84(3)
	stw 0,3480(9)
	lwz 11,84(3)
	stw 0,3728(11)
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
	mulli 9,9,3832
	mulli 11,3,3832
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
