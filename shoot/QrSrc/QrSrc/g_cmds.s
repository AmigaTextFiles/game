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
	.section	".text"
	.align 2
	.globl Cmd_Give_f
	.type	 Cmd_Give_f,@function
Cmd_Give_f:
	blr
.Lfe2:
	.size	 Cmd_Give_f,.Lfe2-Cmd_Give_f
	.section	".rodata"
	.align 2
.LC13:
	.string	"godmode OFF\n"
	.align 2
.LC14:
	.string	"godmode ON\n"
	.align 2
.LC15:
	.string	"notarget OFF\n"
	.align 2
.LC16:
	.string	"notarget ON\n"
	.align 2
.LC17:
	.string	"noclip OFF\n"
	.align 2
.LC18:
	.string	"noclip ON\n"
	.align 2
.LC19:
	.string	"unknown item: %s\n"
	.align 2
.LC20:
	.string	"Item is not usable.\n"
	.align 2
.LC21:
	.string	"Out of item: %s\n"
	.align 2
.LC22:
	.string	"Item is not dropable.\n"
	.align 2
.LC23:
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
	bc 4,2,.L136
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L149:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L141
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L141
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L148
.L141:
	addi 8,8,1
	bdnz .L149
	li 0,-1
	stw 0,736(7)
.L136:
	lwz 9,84(3)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L146
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	la 5,.LC23@l(5)
	b .L150
.L148:
	stw 11,736(7)
	b .L136
.L146:
	mulli 0,0,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L147
	lis 9,gi+8@ha
	lis 5,.LC20@ha
	lwz 0,gi+8@l(9)
	la 5,.LC20@l(5)
.L150:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L134
.L147:
	mtlr 0
	blrl
.L134:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 Cmd_InvUse_f,.Lfe3-Cmd_InvUse_f
	.section	".rodata"
	.align 2
.LC24:
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
	bc 4,2,.L181
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L194:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L186
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L186
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L193
.L186:
	addi 8,8,1
	bdnz .L194
	li 0,-1
	stw 0,736(7)
.L181:
	lwz 9,84(3)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L191
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	la 5,.LC24@l(5)
	b .L195
.L193:
	stw 11,736(7)
	b .L181
.L191:
	mulli 0,0,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L192
	lis 9,gi+8@ha
	lis 5,.LC22@ha
	lwz 0,gi+8@l(9)
	la 5,.LC22@l(5)
.L195:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L179
.L192:
	mtlr 0
	blrl
.L179:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 Cmd_InvDrop_f,.Lfe4-Cmd_InvDrop_f
	.section	".rodata"
	.align 2
.LC25:
	.string	"%3i %s\n"
	.align 2
.LC26:
	.string	"...\n"
	.align 2
.LC27:
	.string	"%s\n%i players\n"
	.align 2
.LC28:
	.long 0x0
	.align 3
.LC29:
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
	lis 11,.LC28@ha
	lis 9,maxclients@ha
	la 11,.LC28@l(11)
	mr 23,3
	lfs 13,0(11)
	li 27,0
	li 31,0
	lwz 11,maxclients@l(9)
	addi 29,1,1352
	addi 30,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L204
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L206:
	lwz 0,0(11)
	addi 11,11,4084
	cmpwi 0,0,0
	bc 12,2,.L205
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L205:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L206
.L204:
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
	bc 4,0,.L210
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC25@ha
	lis 25,.LC26@ha
.L212:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC25@l(26)
	addi 28,28,4
	mulli 7,7,4084
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
	bc 4,1,.L213
	la 4,.LC26@l(25)
	mr 3,30
	bl strcat
	b .L210
.L213:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L212
.L210:
	lis 9,gi+8@ha
	lis 5,.LC27@ha
	lwz 0,gi+8@l(9)
	mr 3,23
	la 5,.LC27@l(5)
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
.LC30:
	.string	"flipoff\n"
	.align 2
.LC31:
	.string	"salute\n"
	.align 2
.LC32:
	.string	"taunt\n"
	.align 2
.LC33:
	.string	"wave\n"
	.align 2
.LC34:
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
	bc 4,2,.L215
	lwz 0,3676(9)
	cmpwi 0,0,1
	bc 12,1,.L215
	cmplwi 0,3,4
	li 0,1
	stw 0,3676(9)
	bc 12,1,.L224
	lis 11,.L225@ha
	slwi 10,3,2
	la 11,.L225@l(11)
	lis 9,.L225@ha
	lwzx 0,10,11
	la 9,.L225@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L225:
	.long .L219-.L225
	.long .L220-.L225
	.long .L221-.L225
	.long .L222-.L225
	.long .L224-.L225
.L219:
	lis 9,gi+8@ha
	lis 5,.LC30@ha
	lwz 0,gi+8@l(9)
	la 5,.LC30@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,71
	li 9,83
	b .L226
.L220:
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
	li 0,83
	li 9,94
	b .L226
.L221:
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
	li 0,94
	li 9,111
	b .L226
.L222:
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
	li 0,111
	li 9,122
	b .L226
.L224:
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
	li 0,122
	li 9,134
.L226:
	stw 0,56(31)
	stw 9,3672(11)
.L215:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 Cmd_Wave_f,.Lfe6-Cmd_Wave_f
	.section	".rodata"
	.align 2
.LC35:
	.string	"(%s): "
	.align 2
.LC36:
	.string	"%s: "
	.align 2
.LC37:
	.string	" "
	.align 2
.LC38:
	.string	"\n"
	.align 2
.LC39:
	.string	"%s"
	.align 2
.LC40:
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
	bc 12,1,.L228
	cmpwi 0,31,0
	bc 12,2,.L227
.L228:
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
	bc 12,2,.L230
	lwz 6,84(28)
	lis 5,.LC35@ha
	addi 3,1,8
	la 5,.LC35@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L231
.L230:
	lwz 6,84(28)
	lis 5,.LC36@ha
	addi 3,1,8
	la 5,.LC36@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L231:
	cmpwi 0,31,0
	bc 12,2,.L232
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC37@ha
	addi 3,1,8
	la 4,.LC37@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L233
.L232:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L234
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
.L234:
	mr 4,29
	addi 3,1,8
	bl strcat
.L233:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L235
	li 0,0
	stb 0,158(1)
.L235:
	lis 4,.LC38@ha
	addi 3,1,8
	la 4,.LC38@l(4)
	bl strcat
	lis 9,.LC40@ha
	lis 11,dedicated@ha
	la 9,.LC40@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L236
	lis 9,gi+8@ha
	lis 5,.LC39@ha
	lwz 0,gi+8@l(9)
	la 5,.LC39@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L236:
	lis 9,game@ha
	li 31,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,31,0
	bc 12,1,.L227
	cmpwi 4,30,0
	lis 9,gi@ha
	la 24,gi@l(9)
	mr 25,11
	lis 26,g_edicts@ha
	lis 27,.LC39@ha
	li 30,948
.L240:
	lwz 0,g_edicts@l(26)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L239
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L239
	bc 12,18,.L243
	mr 3,28
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L239
.L243:
	lwz 9,8(24)
	mr 3,29
	li 4,3
	la 5,.LC39@l(27)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L239:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,948
	cmpw 0,31,0
	bc 4,1,.L240
.L227:
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
.LC41:
	.string	"players"
	.align 2
.LC42:
	.string	"say"
	.align 2
.LC43:
	.string	"say_team"
	.align 2
.LC44:
	.string	"score"
	.align 2
.LC45:
	.string	"help"
	.align 2
.LC46:
	.string	"use"
	.align 2
.LC47:
	.string	"drop"
	.align 2
.LC48:
	.string	"give"
	.align 2
.LC49:
	.string	"god"
	.align 2
.LC50:
	.string	"notarget"
	.align 2
.LC51:
	.string	"noclip"
	.align 2
.LC52:
	.string	"inven"
	.align 2
.LC53:
	.string	"invnext"
	.align 2
.LC54:
	.string	"invprev"
	.align 2
.LC55:
	.string	"invnextw"
	.align 2
.LC56:
	.string	"invprevw"
	.align 2
.LC57:
	.string	"invnextp"
	.align 2
.LC58:
	.string	"invprevp"
	.align 2
.LC59:
	.string	"invuse"
	.align 2
.LC60:
	.string	"invdrop"
	.align 2
.LC61:
	.string	"weapprev"
	.align 2
.LC62:
	.string	"weapnext"
	.align 2
.LC63:
	.string	"weaplast"
	.align 2
.LC64:
	.string	"kill"
	.align 2
.LC65:
	.string	"putaway"
	.align 2
.LC66:
	.string	"wave"
	.align 2
.LC67:
	.string	"getincar"
	.align 2
.LC68:
	.string	"chasecam"
	.align 2
.LC69:
	.string	"toggletimer"
	.align 2
.LC70:
	.string	"handbrake"
	.align 2
.LC71:
	.string	"turnleft"
	.align 2
.LC72:
	.string	"turnright"
	.align 2
.LC73:
	.long 0x0
	.align 2
.LC74:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl ClientCommand
	.type	 ClientCommand,@function
ClientCommand:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 29,3
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L246
	lis 9,gi@ha
	li 3,0
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC41@ha
	la 4,.LC41@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L248
	mr 3,29
	bl Cmd_Players_f
	b .L246
.L248:
	lis 4,.LC42@ha
	mr 3,31
	la 4,.LC42@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L249
	mr 3,29
	li 4,0
	b .L432
.L249:
	lis 4,.LC43@ha
	mr 3,31
	la 4,.LC43@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L250
	mr 3,29
	li 4,1
.L432:
	li 5,0
	bl Cmd_Say_f
	b .L246
.L250:
	lis 4,.LC44@ha
	mr 3,31
	la 4,.LC44@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L251
	mr 3,29
	bl Cmd_Score_f
	b .L246
.L251:
	lis 4,.LC45@ha
	mr 3,31
	la 4,.LC45@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L252
	mr 3,29
	bl Cmd_Help_f
	b .L246
.L252:
	lis 10,.LC73@ha
	lis 9,level+200@ha
	la 10,.LC73@l(10)
	lfs 0,level+200@l(9)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 4,2,.L246
	lis 4,.LC46@ha
	mr 3,31
	la 4,.LC46@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L254
	lwz 9,164(30)
	mtlr 9
	blrl
	mr 31,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L255
	lwz 0,8(30)
	lis 5,.LC19@ha
	mr 3,29
	la 5,.LC19@l(5)
	b .L433
.L255:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L257
	lwz 0,8(30)
	lis 5,.LC20@ha
	mr 3,29
	la 5,.LC20@l(5)
	b .L434
.L257:
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
	bc 12,2,.L435
	b .L264
.L254:
	lis 4,.LC47@ha
	mr 3,31
	la 4,.LC47@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L260
	lwz 9,164(30)
	mtlr 9
	blrl
	mr 31,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L261
	lwz 0,8(30)
	lis 5,.LC19@ha
	mr 3,29
	la 5,.LC19@l(5)
	b .L433
.L261:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L263
	lwz 0,8(30)
	lis 5,.LC22@ha
	mr 3,29
	la 5,.LC22@l(5)
.L434:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L246
.L263:
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
	bc 4,2,.L264
.L435:
	lwz 0,8(30)
	lis 5,.LC21@ha
	mr 3,29
	la 5,.LC21@l(5)
.L433:
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L246
.L264:
	mr 3,29
	mtlr 10
	blrl
	b .L246
.L260:
	lis 4,.LC48@ha
	mr 3,31
	la 4,.LC48@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L266
	mr 3,29
	bl Cmd_Give_f
	b .L246
.L266:
	lis 4,.LC49@ha
	mr 3,31
	la 4,.LC49@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L246
	lis 4,.LC50@ha
	mr 3,31
	la 4,.LC50@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L246
	lis 4,.LC51@ha
	mr 3,31
	la 4,.LC51@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L246
	lis 4,.LC52@ha
	mr 3,31
	la 4,.LC52@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L246
	lis 4,.LC53@ha
	mr 3,31
	la 4,.LC53@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L295
	li 0,256
	lwz 3,84(29)
	lis 9,itemlist@ha
	mtctr 0
	li 8,1
	la 5,itemlist@l(9)
	lwz 6,736(3)
	addi 7,3,740
.L431:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L300
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L300
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L424
.L300:
	addi 8,8,1
	bdnz .L431
	b .L436
.L295:
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L306
	lwz 3,84(29)
	lis 9,itemlist@ha
	li 0,256
	la 6,itemlist@l(9)
	mtctr 0
	lwz 9,736(3)
	addi 7,3,740
	addi 10,9,255
.L430:
	srawi 0,10,31
	srwi 0,0,24
	add 0,10,0
	rlwinm 0,0,0,0,23
	subf 8,0,10
	slwi 9,8,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L311
	mulli 0,8,72
	add 11,0,6
	lwz 9,8(11)
	cmpwi 0,9,0
	bc 12,2,.L311
	lwz 0,56(11)
	cmpwi 0,0,0
	bc 4,2,.L425
.L311:
	addi 10,10,-1
	bdnz .L430
	b .L436
.L306:
	lis 4,.LC55@ha
	mr 3,31
	la 4,.LC55@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L317
	li 0,256
	lwz 3,84(29)
	lis 9,itemlist@ha
	mtctr 0
	li 8,1
	la 5,itemlist@l(9)
	lwz 6,736(3)
	addi 7,3,740
.L429:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L322
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L322
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L424
.L322:
	addi 8,8,1
	bdnz .L429
	b .L436
.L317:
	lis 4,.LC56@ha
	mr 3,31
	la 4,.LC56@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L328
	lwz 3,84(29)
	lis 9,itemlist@ha
	li 0,256
	la 6,itemlist@l(9)
	mtctr 0
	lwz 9,736(3)
	addi 7,3,740
	addi 10,9,255
.L428:
	srawi 0,10,31
	srwi 0,0,24
	add 0,10,0
	rlwinm 0,0,0,0,23
	subf 8,0,10
	slwi 9,8,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L333
	mulli 0,8,72
	add 11,0,6
	lwz 9,8(11)
	cmpwi 0,9,0
	bc 12,2,.L333
	lwz 0,56(11)
	andi. 9,0,1
	bc 4,2,.L425
.L333:
	addi 10,10,-1
	bdnz .L428
	b .L436
.L328:
	lis 4,.LC57@ha
	mr 3,31
	la 4,.LC57@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L339
	li 0,256
	lwz 3,84(29)
	lis 9,itemlist@ha
	mtctr 0
	li 8,1
	la 5,itemlist@l(9)
	lwz 6,736(3)
	addi 7,3,740
.L427:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L344
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L344
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L424
.L344:
	addi 8,8,1
	bdnz .L427
	b .L436
.L339:
	lis 4,.LC58@ha
	mr 3,31
	la 4,.LC58@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L350
	lwz 3,84(29)
	lis 9,itemlist@ha
	li 0,256
	la 6,itemlist@l(9)
	mtctr 0
	lwz 9,736(3)
	addi 7,3,740
	addi 10,9,255
.L426:
	srawi 0,10,31
	srwi 0,0,24
	add 0,10,0
	rlwinm 0,0,0,0,23
	subf 8,0,10
	slwi 9,8,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 12,2,.L355
	mulli 0,8,72
	add 11,0,6
	lwz 9,8(11)
	cmpwi 0,9,0
	bc 12,2,.L355
	lwz 0,56(11)
	andi. 9,0,32
	bc 4,2,.L425
.L355:
	addi 10,10,-1
	bdnz .L426
.L436:
	li 0,-1
	stw 0,736(3)
	b .L246
.L350:
	lis 4,.LC59@ha
	mr 3,31
	la 4,.LC59@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L361
	mr 3,29
	bl Cmd_InvUse_f
	b .L246
.L361:
	lis 4,.LC60@ha
	mr 3,31
	la 4,.LC60@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L363
	mr 3,29
	bl Cmd_InvDrop_f
	b .L246
.L363:
	lis 4,.LC61@ha
	mr 3,31
	la 4,.LC61@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L365
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L246
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
.L370:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L372
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L372
	lwz 0,56(31)
	andi. 10,0,1
	bc 12,2,.L372
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L246
.L372:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L370
	b .L246
.L365:
	lis 4,.LC62@ha
	mr 3,31
	la 4,.LC62@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L378
	lwz 28,84(29)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L246
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
.L383:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L385
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L385
	lwz 0,56(31)
	andi. 10,0,1
	bc 12,2,.L385
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,31
	bc 12,2,.L246
.L385:
	addi 27,27,1
	addi 30,30,-1
	cmpwi 0,27,256
	bc 4,1,.L383
	b .L246
.L378:
	lis 4,.LC63@ha
	mr 3,31
	la 4,.LC63@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L391
	lwz 10,84(29)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L246
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L246
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
	bc 12,2,.L246
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L246
	lwz 0,56(4)
	andi. 10,0,1
	bc 12,2,.L246
	mr 3,29
	mtlr 9
	blrl
	b .L246
.L391:
	lis 4,.LC64@ha
	mr 3,31
	la 4,.LC64@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L399
	lwz 11,84(29)
	lis 9,level+4@ha
	lis 10,.LC74@ha
	lfs 0,level+4@l(9)
	la 10,.LC74@l(10)
	lfs 13,3724(11)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L246
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
	b .L246
.L399:
	lis 4,.LC65@ha
	mr 3,31
	la 4,.LC65@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L403
	lwz 9,84(29)
	stw 3,3476(9)
	lwz 11,84(29)
	stw 3,3484(11)
	lwz 9,84(29)
	stw 3,3480(9)
	b .L246
.L403:
	lis 4,.LC66@ha
	mr 3,31
	la 4,.LC66@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L406
	mr 3,29
	bl Cmd_Wave_f
	b .L246
.L406:
	lis 4,.LC67@ha
	mr 3,31
	la 4,.LC67@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L408
	mr 3,29
	bl Cmd_GetInCar_f
	b .L246
.L408:
	lis 4,.LC68@ha
	mr 3,31
	la 4,.LC68@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L410
	mr 3,29
	bl ToggleChase
	b .L246
.L410:
	lis 4,.LC69@ha
	mr 3,31
	la 4,.LC69@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L412
	mr 3,29
	bl ToggleTimer
	b .L246
.L412:
	lis 4,.LC70@ha
	mr 3,31
	la 4,.LC70@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L414
	mr 3,29
	bl Handbrake
	b .L246
.L414:
	lis 4,.LC71@ha
	mr 3,31
	la 4,.LC71@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L416
	mr 3,29
	bl Turnleft
	b .L246
.L416:
	lis 4,.LC72@ha
	mr 3,31
	la 4,.LC72@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L418
	mr 3,29
	bl Turnright
	b .L246
.L424:
	stw 11,736(3)
	b .L246
.L425:
	stw 8,736(3)
	b .L246
.L418:
	mr 3,29
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L246:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
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
.L437:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L50
	mulli 0,11,72
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L50
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 12,2,.L50
	stw 11,736(8)
	blr
.L50:
	addi 7,7,1
	bdnz .L437
	li 0,-1
	stw 0,736(8)
	blr
.Lfe9:
	.size	 ValidateSelectedItem,.Lfe9-ValidateSelectedItem
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
	bc 12,2,.L439
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
	bc 12,2,.L439
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L9
	addi 3,3,1
	b .L438
.L9:
	stb 30,0(3)
.L439:
	mr 3,31
.L438:
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
.L440:
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
	bc 12,2,.L29
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L29
	lwz 0,56(10)
	and. 9,0,4
	bc 12,2,.L29
	stw 11,736(8)
	blr
.L29:
	addi 7,7,1
	bdnz .L440
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
.L441:
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
	bc 12,2,.L38
	mulli 0,11,72
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L38
	lwz 0,56(10)
	and. 9,0,4
	bc 12,2,.L38
	stw 11,736(8)
	blr
.L38:
	addi 7,7,1
	bdnz .L441
	li 0,-1
	stw 0,736(8)
	blr
.Lfe12:
	.size	 SelectPrevItem,.Lfe12-SelectPrevItem
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	blr
.Lfe13:
	.size	 Cmd_God_f,.Lfe13-Cmd_God_f
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	blr
.Lfe14:
	.size	 Cmd_Notarget_f,.Lfe14-Cmd_Notarget_f
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
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
	bc 4,2,.L120
	lwz 0,8(29)
	lis 5,.LC19@ha
	mr 3,31
	la 5,.LC19@l(5)
	b .L442
.L120:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L121
	lwz 0,8(29)
	lis 5,.LC20@ha
	mr 3,31
	la 5,.LC20@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L119
.L121:
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
	bc 4,2,.L122
	lwz 0,8(29)
	lis 5,.LC21@ha
	mr 3,31
	la 5,.LC21@l(5)
.L442:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L119
.L122:
	mr 3,31
	mtlr 10
	blrl
.L119:
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
	bc 4,2,.L124
	lwz 0,8(29)
	lis 5,.LC19@ha
	mr 3,31
	la 5,.LC19@l(5)
	b .L443
.L124:
	lwz 10,12(4)
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
	b .L123
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
	lis 5,.LC21@ha
	mr 3,31
	la 5,.LC21@l(5)
.L443:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L123
.L126:
	mr 3,31
	mtlr 10
	blrl
.L123:
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
	lwz 11,1788(29)
	cmpwi 0,11,0
	bc 12,2,.L151
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
.L156:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L155
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L155
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L155
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L151
.L155:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L156
.L151:
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
	lwz 11,1788(29)
	cmpwi 0,11,0
	bc 12,2,.L162
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
.L167:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L166
	mulli 0,11,72
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L166
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L166
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L162
.L166:
	addi 28,28,1
	addi 30,30,-1
	cmpwi 0,28,256
	bc 4,1,.L167
.L162:
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
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L173
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L173
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
	bc 12,2,.L173
	mulli 0,10,72
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L173
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L173
	mtlr 9
	blrl
.L173:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 Cmd_WeapLast_f,.Lfe21-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC75:
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
	lis 10,.LC75@ha
	lfs 0,level+4@l(9)
	la 10,.LC75@l(10)
	lfs 13,3724(11)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L196
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
.L196:
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
	mulli 9,9,4084
	mulli 11,3,4084
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
