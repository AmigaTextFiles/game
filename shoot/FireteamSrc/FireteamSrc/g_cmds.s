	.file	"g_cmds.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x0
	.section	".text"
	.align 2
	.globl OnSameTeam
	.type	 OnSameTeam,@function
OnSameTeam:
	lis 11,.LC0@ha
	lis 9,ctf@ha
	la 11,.LC0@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 7,0,13
	bc 4,30,.L15
	lis 9,team_dm@ha
	lwz 11,team_dm@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L14
.L15:
	lwz 10,84(3)
	cmpwi 0,10,0
	bc 12,2,.L17
	lwz 0,84(4)
	cmpwi 0,0,0
	mr 8,0
	bc 4,2,.L16
.L17:
	li 3,0
	blr
.L16:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L23
	lis 9,team_dm@ha
	lwz 11,team_dm@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L21
	lwz 3,1884(10)
	addi 0,3,-1
	cmplwi 0,0,3
	bc 12,1,.L23
	b .L20
.L21:
	bc 12,30,.L23
	lwz 3,1840(10)
	cmpwi 0,3,1
	bc 12,1,.L23
	lwz 0,1884(10)
	cmpwi 0,0,0
	bc 12,1,.L20
.L23:
	li 3,0
.L20:
	lis 11,.LC0@ha
	lis 9,deathmatch@ha
	la 11,.LC0@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	li 9,0
	bc 12,2,.L27
	lis 9,team_dm@ha
	lwz 11,team_dm@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L28
	lwz 9,1884(8)
	addi 0,9,-1
	cmplwi 0,0,3
	bc 12,1,.L30
	b .L27
.L28:
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L30
	lwz 9,1840(8)
	cmpwi 0,9,1
	bc 12,1,.L30
	lwz 0,1884(8)
	cmpwi 0,0,0
	bc 12,1,.L27
.L30:
	li 9,0
.L27:
	xor 3,3,9
	subfic 0,3,0
	adde 3,0,3
	blr
.L14:
	li 3,0
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
	.string	"Power Shield"
	.align 2
.LC8:
	.string	"unknown item\n"
	.align 2
.LC9:
	.string	"non-pickup item\n"
	.align 2
.LC10:
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
	lis 10,.LC10@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC10@l(10)
	mr 28,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L71
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L71
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	b .L122
.L71:
	lis 9,gi@ha
	la 30,gi@l(9)
	lwz 9,164(30)
	mtlr 9
	blrl
	mr 27,3
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	bl Q_strcasecmp
	subfic 0,3,0
	adde. 29,0,3
	mfcr 31
	bc 4,2,.L75
	lwz 9,160(30)
	li 3,1
	rlwinm 31,31,16,0xffffffff
	mtcrf 8,31
	rlwinm 31,31,16,0xffffffff
	mtlr 9
	blrl
	lis 4,.LC3@ha
	la 4,.LC3@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L74
.L75:
	lwz 9,156(30)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L76
	lwz 0,160(30)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	stw 3,480(28)
	b .L77
.L76:
	lwz 0,484(28)
	stw 0,480(28)
.L77:
	cmpwi 4,29,0
	bc 12,18,.L70
.L74:
	bc 4,18,.L80
	lis 4,.LC4@ha
	mr 3,27
	la 4,.LC4@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L79
.L80:
	lis 9,game@ha
	li 30,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,30,0
	bc 4,0,.L82
	lis 9,itemlist@ha
	mr 7,11
	la 8,itemlist@l(9)
	li 10,0
.L84:
	mr 31,8
	lwz 0,4(31)
	cmpwi 0,0,0
	bc 12,2,.L83
	lwz 0,56(31)
	andi. 9,0,1
	bc 12,2,.L83
	lwz 11,84(28)
	addi 11,11,744
	lwzx 9,11,10
	addi 9,9,1
	stwx 9,11,10
.L83:
	lwz 0,1556(7)
	addi 30,30,1
	addi 10,10,4
	addi 8,8,76
	cmpw 0,30,0
	bc 12,0,.L84
.L82:
	bc 12,18,.L70
.L79:
	bc 4,18,.L90
	lis 4,.LC5@ha
	mr 3,27
	la 4,.LC5@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L89
.L90:
	lis 9,game@ha
	li 30,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,30,0
	bc 4,0,.L92
	lis 9,itemlist@ha
	mr 26,11
	la 29,itemlist@l(9)
.L94:
	mr 31,29
	lwz 0,4(31)
	cmpwi 0,0,0
	bc 12,2,.L93
	lwz 0,56(31)
	andi. 9,0,2
	bc 12,2,.L93
	mr 4,31
	mr 3,28
	li 5,1000
	bl Add_Ammo
.L93:
	lwz 0,1556(26)
	addi 30,30,1
	addi 29,29,76
	cmpw 0,30,0
	bc 12,0,.L94
.L92:
	bc 12,18,.L70
.L89:
	bc 4,18,.L100
	lis 4,.LC6@ha
	mr 3,27
	la 4,.LC6@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L99
.L100:
	lis 9,item_jacketarmor@ha
	lis 11,itemlist@ha
	lwz 10,84(28)
	lwz 31,item_jacketarmor@l(9)
	la 11,itemlist@l(11)
	lis 8,0x286b
	ori 8,8,51739
	lis 7,item_combatarmor@ha
	subf 9,11,31
	addi 10,10,744
	mullw 9,9,8
	lwz 31,item_combatarmor@l(7)
	li 6,0
	lis 7,item_bodyarmor@ha
	rlwinm 9,9,0,0,29
	subf 0,11,31
	stwx 6,10,9
	mullw 0,0,8
	lwz 9,84(28)
	lwz 31,item_bodyarmor@l(7)
	rlwinm 0,0,0,0,29
	addi 9,9,744
	stwx 6,9,0
	subf 11,11,31
	lwz 10,64(31)
	mullw 11,11,8
	lwz 9,84(28)
	lwz 0,4(10)
	rlwinm 11,11,0,0,29
	addi 9,9,744
	stwx 0,9,11
	bc 12,18,.L70
.L99:
	bc 4,18,.L103
	lis 4,.LC7@ha
	mr 3,27
	la 4,.LC7@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L102
.L103:
	lis 9,item_powershield@ha
	lwz 31,item_powershield@l(9)
	bl G_Spawn
	lwz 0,0(31)
	mr 30,3
	mr 4,31
	stw 0,280(30)
	bl SpawnItem
	mr 3,30
	mr 4,28
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L104
	mr 3,30
	bl G_FreeEdict
.L104:
	bc 12,18,.L70
.L102:
	bc 12,18,.L106
	lis 9,game@ha
	li 30,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,30,0
	bc 4,0,.L70
	lis 9,itemlist@ha
	mr 7,11
	la 11,itemlist@l(9)
	li 8,1
	li 10,0
.L110:
	lwz 0,4(11)
	cmpwi 0,0,0
	bc 12,2,.L109
	lwz 0,56(11)
	andi. 9,0,7
	bc 4,2,.L109
	lwz 9,84(28)
	addi 9,9,744
	stwx 8,9,10
.L109:
	lwz 0,1556(7)
	addi 30,30,1
	addi 10,10,4
	addi 11,11,76
	cmpw 0,30,0
	bc 12,0,.L110
	b .L70
.L106:
	mr 3,27
	bl FindItem
	mr. 31,3
	bc 4,2,.L114
	lis 9,gi@ha
	li 3,1
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	bl FindItem
	mr. 31,3
	bc 4,2,.L114
	lwz 0,8(30)
	lis 5,.LC8@ha
	mr 3,28
	la 5,.LC8@l(5)
	b .L122
.L114:
	lwz 0,4(31)
	cmpwi 0,0,0
	bc 4,2,.L116
	lis 9,gi+8@ha
	lis 5,.LC9@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC9@l(5)
.L122:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L70
.L116:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,56(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,31
	andi. 10,11,2
	mullw 9,9,0
	srawi 29,9,2
	bc 12,2,.L117
	lis 9,gi@ha
	la 30,gi@l(9)
	lwz 9,156(30)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L118
	lwz 0,160(30)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(28)
	slwi 0,29,2
	addi 9,9,744
	stwx 3,9,0
	b .L70
.L118:
	lwz 9,84(28)
	slwi 10,29,2
	lwz 11,48(31)
	addi 9,9,744
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L70
.L117:
	bl G_Spawn
	lwz 0,0(31)
	mr 30,3
	mr 4,31
	stw 0,280(30)
	bl SpawnItem
	mr 4,28
	mr 3,30
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L70
	mr 3,30
	bl G_FreeEdict
.L70:
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
.LC11:
	.string	"godmode OFF\n"
	.align 2
.LC12:
	.string	"godmode ON\n"
	.align 2
.LC13:
	.string	"notarget OFF\n"
	.align 2
.LC14:
	.string	"notarget ON\n"
	.align 2
.LC15:
	.string	"noclip OFF\n"
	.align 2
.LC16:
	.string	"noclip ON\n"
	.align 2
.LC17:
	.string	"unknown item: %s\n"
	.align 2
.LC18:
	.string	"Item is not usable.\n"
	.align 2
.LC19:
	.string	"Out of item: %s\n"
	.align 2
.LC20:
	.string	"Machinegun"
	.align 2
.LC21:
	.string	"Burst Fire.\n"
	.align 2
.LC22:
	.string	"Fully Auto.\n"
	.align 2
.LC23:
	.string	"grenades"
	.align 2
.LC24:
	.string	"Shrapnel Grenades Selected.\n"
	.align 2
.LC25:
	.string	"Hand Grenades Selected.\n"
	.align 2
.LC26:
	.string	"Concussion Grenades Selected.\n"
	.align 2
.LC27:
	.string	"Pipebombs Selected.\n"
	.align 2
.LC28:
	.string	"machinegun"
	.align 2
.LC29:
	.string	"Dual Machineguns"
	.align 2
.LC30:
	.string	"Flash Grenades Selected.\n"
	.align 2
.LC31:
	.string	"Gas Grenades Selected.\n"
	.align 2
.LC32:
	.string	"rocket launcher"
	.align 2
.LC33:
	.string	"Guided Missiles Selected.\n"
	.align 2
.LC34:
	.string	"Homing Missiles Selected.\n"
	.align 2
.LC35:
	.string	"Rockets Selected.\n"
	.align 2
.LC36:
	.string	"Teleport Grenades Selected.\n"
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
	mr 29,3
	la 28,gi@l(9)
	lwz 9,164(28)
	mtlr 9
	blrl
	mr 30,3
	bl FindItem
	mr. 27,3
	bc 4,2,.L136
	lwz 0,8(28)
	lis 5,.LC17@ha
	mr 3,29
	la 5,.LC17@l(5)
	b .L187
.L136:
	lwz 0,8(27)
	cmpwi 0,0,0
	bc 4,2,.L137
	lwz 0,8(28)
	lis 5,.LC18@ha
	mr 3,29
	la 5,.LC18@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L135
.L137:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,27
	addi 11,10,744
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L138
	lwz 0,8(28)
	lis 5,.LC19@ha
	mr 3,29
	la 5,.LC19@l(5)
.L187:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L135
.L138:
	lwz 9,1792(10)
	mr 3,30
	lwz 4,40(9)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L140
	lwz 9,84(29)
	lwz 31,1888(9)
	cmpwi 0,31,3
	bc 4,2,.L141
	lis 4,.LC20@ha
	mr 3,30
	la 4,.LC20@l(4)
	bl Q_strcasecmp
	mr. 3,3
	bc 4,2,.L142
	lwz 9,84(29)
	lwz 0,1816(9)
	cmpwi 0,0,0
	bc 4,2,.L143
	li 0,1
	lis 5,.LC21@ha
	stw 0,1816(9)
	la 5,.LC21@l(5)
	mr 3,29
	lwz 0,8(28)
	b .L188
.L143:
	stw 3,1816(9)
	lis 5,.LC22@ha
	li 4,2
	lwz 0,8(28)
	mr 3,29
	la 5,.LC22@l(5)
	b .L189
.L142:
	lis 4,.LC23@ha
	mr 3,30
	la 4,.LC23@l(4)
	bl Q_strcasecmp
	mr. 3,3
	bc 4,2,.L139
	lwz 9,84(29)
	lwz 0,2348(9)
	cmpwi 0,0,0
	bc 4,2,.L147
	li 0,1
	lis 5,.LC24@ha
	stw 0,2348(9)
	la 5,.LC24@l(5)
	mr 3,29
	lwz 0,8(28)
	b .L188
.L147:
	stw 3,2348(9)
	lis 5,.LC25@ha
	li 4,2
	lwz 0,8(28)
	mr 3,29
	la 5,.LC25@l(5)
	b .L189
.L141:
	cmpwi 0,31,1
	bc 4,2,.L150
	lis 4,.LC23@ha
	mr 3,30
	la 4,.LC23@l(4)
	bl Q_strcasecmp
	mr. 3,3
	bc 4,2,.L139
	lwz 9,84(29)
	lwz 0,2340(9)
	cmpwi 0,0,0
	bc 4,2,.L152
	stw 31,2340(9)
	lis 5,.LC26@ha
	mr 3,29
	lwz 0,8(28)
	la 5,.LC26@l(5)
	b .L188
.L152:
	stw 3,2340(9)
	lis 5,.LC25@ha
	li 4,2
	lwz 0,8(28)
	mr 3,29
	la 5,.LC25@l(5)
	b .L189
.L150:
	cmpwi 0,31,4
	bc 4,2,.L155
	lis 4,.LC23@ha
	mr 3,30
	la 4,.LC23@l(4)
	bl Q_strcasecmp
	mr. 3,3
	bc 4,2,.L139
	lwz 9,84(29)
	lwz 0,2344(9)
	cmpwi 0,0,0
	bc 4,2,.L157
	li 0,1
	lis 5,.LC27@ha
	stw 0,2344(9)
	la 5,.LC27@l(5)
	mr 3,29
	lwz 0,8(28)
	b .L188
.L157:
	stw 3,2344(9)
	lis 5,.LC25@ha
	li 4,2
	lwz 0,8(28)
	mr 3,29
	la 5,.LC25@l(5)
	b .L189
.L155:
	cmpwi 0,31,5
	bc 4,2,.L160
	lis 4,.LC28@ha
	mr 3,30
	la 4,.LC28@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L139
	lis 3,.LC29@ha
	la 3,.LC29@l(3)
	bl FindItem
	mr 27,3
	b .L139
.L160:
	cmpwi 0,31,2
	bc 4,2,.L163
	lis 4,.LC23@ha
	mr 3,30
	la 4,.LC23@l(4)
	bl Q_strcasecmp
	mr. 3,3
	bc 4,2,.L139
	lwz 9,84(29)
	lwz 0,2352(9)
	cmpwi 0,0,0
	bc 4,2,.L165
	li 0,1
	lis 5,.LC30@ha
	stw 0,2352(9)
	la 5,.LC30@l(5)
	mr 3,29
	lwz 0,8(28)
	b .L188
.L165:
	cmpwi 0,0,1
	bc 4,2,.L167
	stw 31,2352(9)
	lis 5,.LC31@ha
	mr 3,29
	lis 9,gi+8@ha
	la 5,.LC31@l(5)
	lwz 0,gi+8@l(9)
	b .L188
.L167:
	stw 3,2352(9)
	lis 5,.LC25@ha
	li 4,2
	lis 9,gi+8@ha
	la 5,.LC25@l(5)
	lwz 0,gi+8@l(9)
	mr 3,29
	b .L189
.L163:
	cmpwi 0,31,8
	bc 4,2,.L170
	lis 4,.LC32@ha
	mr 3,30
	la 4,.LC32@l(4)
	bl Q_strcasecmp
	mr. 3,3
	bc 4,2,.L139
	lwz 11,84(29)
	lwz 0,2356(11)
	cmpwi 0,0,0
	bc 4,2,.L172
	li 0,1
	lis 5,.LC33@ha
	stw 0,2356(11)
	la 5,.LC33@l(5)
	mr 3,29
	lwz 0,8(28)
	b .L188
.L172:
	cmpwi 0,0,1
	bc 4,2,.L174
	li 0,2
	lis 9,gi+8@ha
	stw 0,2356(11)
	lis 5,.LC34@ha
	mr 3,29
	lwz 0,gi+8@l(9)
	la 5,.LC34@l(5)
	b .L188
.L174:
	stw 3,2356(11)
	lis 9,gi+8@ha
	lis 5,.LC35@ha
	lwz 0,gi+8@l(9)
	la 5,.LC35@l(5)
	b .L190
.L170:
	cmpwi 0,31,9
	bc 4,2,.L139
	lis 4,.LC23@ha
	mr 3,30
	la 4,.LC23@l(4)
	bl Q_strcasecmp
	mr. 3,3
	bc 4,2,.L139
	lwz 11,84(29)
	lwz 0,2360(11)
	cmpwi 0,0,0
	bc 4,2,.L179
	li 0,1
	lis 9,gi+8@ha
	stw 0,2360(11)
	lis 5,.LC36@ha
	mr 3,29
	lwz 0,gi+8@l(9)
	la 5,.LC36@l(5)
	b .L188
.L179:
	stw 3,2360(11)
	lis 9,gi+8@ha
	lis 5,.LC25@ha
	lwz 0,gi+8@l(9)
	la 5,.LC25@l(5)
.L190:
	mr 3,29
.L188:
	li 4,2
.L189:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L139
.L140:
	lis 4,.LC20@ha
	mr 3,30
	la 4,.LC20@l(4)
	bl Q_strcasecmp
	mr. 3,3
	bc 4,2,.L182
	lwz 9,84(29)
	stw 3,1816(9)
	b .L139
.L182:
	lis 4,.LC23@ha
	mr 3,30
	la 4,.LC23@l(4)
	bl Q_strcasecmp
	mr. 3,3
	bc 4,2,.L184
	lwz 9,84(29)
	stw 3,2340(9)
	lwz 11,84(29)
	stw 3,2344(11)
	lwz 9,84(29)
	stw 3,2348(9)
	lwz 11,84(29)
	stw 3,2360(11)
	b .L139
.L184:
	lis 4,.LC32@ha
	mr 3,30
	la 4,.LC32@l(4)
	bl Q_strcasecmp
	mr. 3,3
	bc 4,2,.L139
	lwz 9,84(29)
	stw 3,2356(9)
.L139:
	lwz 0,8(27)
	mr 3,29
	mr 4,27
	mtlr 0
	blrl
.L135:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 Cmd_Use_f,.Lfe3-Cmd_Use_f
	.section	".rodata"
	.align 2
.LC37:
	.string	"Item is not dropable.\n"
	.align 2
.LC38:
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
	lwz 0,1928(8)
	cmpwi 0,0,0
	bc 12,2,.L205
	bl PMenu_Select
	b .L204
.L205:
	lwz 11,740(8)
	addi 10,8,744
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L207
	lwz 0,2236(8)
	cmpwi 0,0,0
	bc 12,2,.L210
	mr 3,31
	bl ChaseNext
	b .L207
.L221:
	stw 11,740(8)
	b .L207
.L210:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L222:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L215
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L215
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L221
.L215:
	addi 7,7,1
	bdnz .L222
	li 0,-1
	stw 0,740(8)
.L207:
	lwz 9,84(31)
	lwz 0,740(9)
	cmpwi 0,0,-1
	bc 4,2,.L219
	lis 9,gi+8@ha
	lis 5,.LC38@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC38@l(5)
	b .L223
.L219:
	mulli 0,0,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L220
	lis 9,gi+8@ha
	lis 5,.LC18@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC18@l(5)
.L223:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L204
.L220:
	mr 3,31
	mtlr 0
	blrl
.L204:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 Cmd_InvUse_f,.Lfe4-Cmd_InvUse_f
	.section	".rodata"
	.align 2
.LC39:
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
	bc 4,2,.L254
	lwz 0,1928(8)
	cmpwi 0,0,0
	bc 12,2,.L255
	bl PMenu_Next
	b .L254
.L255:
	lwz 0,2236(8)
	cmpwi 0,0,0
	bc 12,2,.L257
	mr 3,31
	bl ChaseNext
	b .L254
.L268:
	stw 11,740(8)
	b .L254
.L257:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L269:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L262
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L262
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L268
.L262:
	addi 7,7,1
	bdnz .L269
	li 0,-1
	stw 0,740(8)
.L254:
	lwz 9,84(31)
	lwz 0,740(9)
	cmpwi 0,0,-1
	bc 4,2,.L266
	lis 9,gi+8@ha
	lis 5,.LC39@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC39@l(5)
	b .L270
.L266:
	mulli 0,0,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L267
	lis 9,gi+8@ha
	lis 5,.LC37@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC37@l(5)
.L270:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L252
.L267:
	mr 3,31
	mtlr 0
	blrl
.L252:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_InvDrop_f,.Lfe5-Cmd_InvDrop_f
	.section	".rodata"
	.align 2
.LC40:
	.string	"%3i %s\n"
	.align 2
.LC41:
	.string	"...\n"
	.align 2
.LC42:
	.string	"%s\n%i players\n"
	.align 2
.LC43:
	.long 0x0
	.align 3
.LC44:
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
	lis 11,.LC43@ha
	lis 9,maxclients@ha
	la 11,.LC43@l(11)
	mr 23,3
	lfs 13,0(11)
	li 27,0
	li 31,0
	lwz 11,maxclients@l(9)
	addi 29,1,1352
	addi 30,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L281
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L283:
	lwz 0,0(11)
	addi 11,11,2384
	cmpwi 0,0,0
	bc 12,2,.L282
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L282:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L283
.L281:
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
	bc 4,0,.L287
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC40@ha
	lis 25,.LC41@ha
.L289:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC40@l(26)
	addi 28,28,4
	mulli 7,7,2384
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
	bc 4,1,.L290
	la 4,.LC41@l(25)
	mr 3,30
	bl strcat
	b .L287
.L290:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L289
.L287:
	lis 9,gi+8@ha
	lis 5,.LC42@ha
	lwz 0,gi+8@l(9)
	mr 3,23
	la 5,.LC42@l(5)
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
.LC45:
	.string	"flipoff\n"
	.align 2
.LC46:
	.string	"salute\n"
	.align 2
.LC47:
	.string	"taunt\n"
	.align 2
.LC48:
	.string	"wave\n"
	.align 2
.LC49:
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
	bc 4,2,.L292
	lwz 0,2136(9)
	cmpwi 0,0,1
	bc 12,1,.L292
	cmplwi 0,3,4
	li 0,1
	stw 0,2136(9)
	bc 12,1,.L301
	lis 11,.L302@ha
	slwi 10,3,2
	la 11,.L302@l(11)
	lis 9,.L302@ha
	lwzx 0,10,11
	la 9,.L302@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L302:
	.long .L296-.L302
	.long .L297-.L302
	.long .L298-.L302
	.long .L299-.L302
	.long .L301-.L302
.L296:
	lis 9,gi+8@ha
	lis 5,.LC45@ha
	lwz 0,gi+8@l(9)
	la 5,.LC45@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,71
	li 9,83
	b .L303
.L297:
	lis 9,gi+8@ha
	lis 5,.LC46@ha
	lwz 0,gi+8@l(9)
	la 5,.LC46@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,83
	li 9,94
	b .L303
.L298:
	lis 9,gi+8@ha
	lis 5,.LC47@ha
	lwz 0,gi+8@l(9)
	la 5,.LC47@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,94
	li 9,111
	b .L303
.L299:
	lis 9,gi+8@ha
	lis 5,.LC48@ha
	lwz 0,gi+8@l(9)
	la 5,.LC48@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,111
	li 9,122
	b .L303
.L301:
	lis 9,gi+8@ha
	lis 5,.LC49@ha
	lwz 0,gi+8@l(9)
	la 5,.LC49@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,122
	li 9,134
.L303:
	stw 0,56(31)
	stw 9,2132(11)
.L292:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 Cmd_Wave_f,.Lfe7-Cmd_Wave_f
	.section	".rodata"
	.align 2
.LC50:
	.string	"(%s): "
	.align 2
.LC51:
	.string	"%s: "
	.align 2
.LC52:
	.string	" "
	.align 2
.LC53:
	.string	"\n"
	.align 2
.LC54:
	.string	"You can't talk for %d more seconds\n"
	.align 2
.LC55:
	.string	"Flood protection:  You can't talk for %d seconds.\n"
	.align 2
.LC56:
	.string	"%s"
	.align 2
.LC57:
	.long 0x0
	.align 3
.LC58:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC59:
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
	bc 12,1,.L305
	cmpwi 0,31,0
	bc 12,2,.L304
.L305:
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
	bc 12,2,.L307
	lwz 6,84(28)
	lis 5,.LC50@ha
	addi 3,1,8
	la 5,.LC50@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L308
.L307:
	lwz 6,84(28)
	lis 5,.LC51@ha
	addi 3,1,8
	la 5,.LC51@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L308:
	cmpwi 0,31,0
	bc 12,2,.L309
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC52@ha
	addi 3,1,8
	la 4,.LC52@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L310
.L309:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L311
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
.L311:
	mr 4,29
	addi 3,1,8
	bl strcat
.L310:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L312
	li 0,0
	stb 0,158(1)
.L312:
	lis 4,.LC53@ha
	addi 3,1,8
	la 4,.LC53@l(4)
	bl strcat
	lis 9,.LC57@ha
	la 9,.LC57@l(9)
	lfs 8,0(9)
	lis 9,flood_msgs@ha
	lwz 11,flood_msgs@l(9)
	lfs 9,20(11)
	fcmpu 0,9,8
	bc 12,2,.L313
	lwz 7,84(28)
	lis 9,level+4@ha
	lfs 10,level+4@l(9)
	lfs 0,2184(7)
	fcmpu 0,10,0
	bc 4,0,.L314
	fsubs 0,0,10
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC54@ha
	mr 3,28
	la 5,.LC54@l(5)
	li 4,2
	mtlr 0
	fctiwz 13,0
	stfd 13,2064(1)
	b .L327
.L314:
	lwz 0,2228(7)
	lis 10,0x4330
	lis 11,.LC58@ha
	addi 8,7,2188
	mr 6,0
	la 11,.LC58@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,2068(1)
	lis 11,.LC59@ha
	stw 10,2064(1)
	la 11,.LC59@l(11)
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
	bc 12,2,.L316
	lis 11,flood_persecond@ha
	fsubs 13,10,0
	lwz 9,flood_persecond@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L316
	lis 9,flood_waitdelay@ha
	lis 10,gi+8@ha
	lwz 11,flood_waitdelay@l(9)
	lis 5,.LC55@ha
	mr 3,28
	la 5,.LC55@l(5)
	lfs 13,20(11)
	li 4,3
	fadds 13,10,13
	stfs 13,2184(7)
	lfs 0,20(11)
	lwz 0,gi+8@l(10)
	mtlr 0
	fctiwz 12,0
	stfd 12,2064(1)
.L327:
	lwz 6,2068(1)
	crxor 6,6,6
	blrl
	b .L304
.L316:
	lis 0,0xcccc
	addi 9,6,1
	ori 0,0,52429
	lis 11,level+4@ha
	mulhwu 0,9,0
	srwi 0,0,3
	mulli 0,0,10
	subf 9,0,9
	stw 9,2228(7)
	lfs 0,level+4@l(11)
	slwi 9,9,2
	stfsx 0,10,9
.L313:
	lis 9,.LC57@ha
	lis 11,dedicated@ha
	la 9,.LC57@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L317
	lis 9,gi+8@ha
	lis 5,.LC56@ha
	lwz 0,gi+8@l(9)
	la 5,.LC56@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L317:
	lis 9,game@ha
	li 31,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,31,0
	bc 12,1,.L304
	cmpwi 4,30,0
	lis 9,gi@ha
	la 24,gi@l(9)
	mr 25,11
	lis 26,g_edicts@ha
	lis 27,.LC56@ha
	li 30,976
.L321:
	lwz 0,g_edicts@l(26)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L320
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L320
	bc 12,18,.L324
	mr 3,28
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L320
.L324:
	lwz 9,8(24)
	mr 3,29
	li 4,3
	la 5,.LC56@l(27)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L320:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,976
	cmpw 0,31,0
	bc 4,1,.L321
.L304:
	lwz 0,2116(1)
	lwz 12,2076(1)
	mtlr 0
	lmw 24,2080(1)
	mtcrf 8,12
	la 1,2112(1)
	blr
.Lfe8:
	.size	 Cmd_Say_f,.Lfe8-Cmd_Say_f
	.section	".rodata"
	.align 2
.LC60:
	.string	"%02d:%02d %4d %3d %s%s\n"
	.align 2
.LC61:
	.string	" (spectator)"
	.align 2
.LC62:
	.string	""
	.align 2
.LC63:
	.string	"And more...\n"
	.align 2
.LC64:
	.long 0x0
	.align 3
.LC65:
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
	lis 9,.LC64@ha
	stb 0,96(1)
	li 28,0
	la 9,.LC64@l(9)
	lfs 0,20(11)
	lis 22,maxclients@ha
	lfs 13,0(9)
	addi 31,1,96
	lis 21,gi@ha
	lwz 9,g_edicts@l(10)
	lis 20,.LC56@ha
	fcmpu 0,13,0
	addi 30,9,976
	bc 4,0,.L330
	lis 9,.LC61@ha
	lis 11,.LC62@ha
	la 23,.LC61@l(9)
	la 24,.LC62@l(11)
	lis 25,level@ha
	lis 26,0x4330
.L332:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L331
	lwz 10,84(30)
	lis 11,0x1b4e
	lis 8,0x6666
	lwz 9,level@l(25)
	ori 11,11,33205
	ori 8,8,26215
	lwz 0,1832(10)
	addi 29,10,700
	lwz 7,1880(10)
	subf 9,0,9
	lwz 3,184(10)
	mulhw 11,9,11
	lwz 4,1836(10)
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
	bc 12,2,.L334
	stw 23,8(1)
	b .L335
.L334:
	stw 24,8(1)
.L335:
	mr 8,3
	mr 9,4
	lis 5,.LC60@ha
	mr 10,29
	addi 3,1,16
	la 5,.LC60@l(5)
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
	bc 4,1,.L336
	mr 3,31
	bl strlen
	lis 4,.LC63@ha
	add 3,31,3
	la 4,.LC63@l(4)
	crxor 6,6,6
	bl sprintf
	la 9,gi@l(21)
	mr 3,27
	lwz 0,8(9)
	la 5,.LC56@l(20)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L328
.L336:
	mr 3,31
	addi 4,1,16
	bl strcat
.L331:
	addi 28,28,1
	lwz 11,maxclients@l(22)
	xoris 0,28,0x8000
	lis 10,.LC65@ha
	stw 0,1516(1)
	la 10,.LC65@l(10)
	addi 30,30,976
	stw 26,1512(1)
	lfd 13,0(10)
	lfd 0,1512(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L332
.L330:
	lis 9,gi+8@ha
	lis 5,.LC56@ha
	lwz 0,gi+8@l(9)
	mr 3,27
	la 5,.LC56@l(5)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L328:
	lwz 0,1572(1)
	mtlr 0
	lmw 20,1520(1)
	la 1,1568(1)
	blr
.Lfe9:
	.size	 Cmd_PlayerList_f,.Lfe9-Cmd_PlayerList_f
	.section	".rodata"
	.align 2
.LC66:
	.string	"detpipe"
	.align 2
.LC68:
	.string	"Cannot reload while dead.\n"
	.align 2
.LC69:
	.string	"Pistol"
	.align 2
.LC70:
	.string	"Flare Gun"
	.align 2
.LC71:
	.string	"Shotgun"
	.align 2
.LC72:
	.string	"Super Shotgun"
	.align 2
.LC73:
	.string	"Chaingun"
	.align 2
.LC74:
	.string	"Grenade Launcher"
	.align 2
.LC75:
	.string	"Rocket Launcher"
	.align 2
.LC76:
	.string	"HyperBlaster"
	.align 2
.LC77:
	.string	"Railgun"
	.align 2
.LC78:
	.string	"You can't reload that.\n"
	.align 2
.LC79:
	.string	"You're on your last magazine!\n"
	.align 2
.LC80:
	.string	"Cannot reload with no ammo.\n"
	.section	".text"
	.align 2
	.globl Cmd_Reload_f
	.type	 Cmd_Reload_f,@function
Cmd_Reload_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 4,2,.L348
	lis 9,gi+12@ha
	lis 4,.LC68@ha
	lwz 0,gi+12@l(9)
	la 4,.LC68@l(4)
	b .L375
.L348:
	lwz 9,84(31)
	lis 4,.LC69@ha
	la 4,.LC69@l(4)
	lwz 11,1792(9)
	lwz 3,40(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L349
	li 11,12
	b .L350
.L349:
	lwz 9,84(31)
	lis 4,.LC70@ha
	la 4,.LC70@l(4)
	lwz 11,1792(9)
	lwz 3,40(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L351
	li 11,4
	b .L350
.L351:
	lwz 9,84(31)
	lis 4,.LC71@ha
	la 4,.LC71@l(4)
	lwz 11,1792(9)
	lwz 3,40(11)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L376
	lwz 9,84(31)
	lis 4,.LC72@ha
	la 4,.LC72@l(4)
	lwz 11,1792(9)
	lwz 3,40(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L355
	li 11,10
	b .L350
.L355:
	lwz 9,84(31)
	lis 4,.LC20@ha
	la 4,.LC20@l(4)
	lwz 11,1792(9)
	lwz 3,40(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L357
	li 11,30
	b .L350
.L357:
	lwz 9,84(31)
	lis 4,.LC29@ha
	la 4,.LC29@l(4)
	lwz 11,1792(9)
	lwz 3,40(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L359
	li 11,60
	b .L350
.L359:
	lwz 9,84(31)
	lis 4,.LC73@ha
	la 4,.LC73@l(4)
	lwz 11,1792(9)
	lwz 3,40(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L361
	li 11,75
	b .L350
.L361:
	lwz 9,84(31)
	lis 4,.LC74@ha
	la 4,.LC74@l(4)
	lwz 11,1792(9)
	lwz 3,40(11)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L376
	lwz 9,84(31)
	lis 4,.LC75@ha
	la 4,.LC75@l(4)
	lwz 11,1792(9)
	lwz 3,40(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L365
.L376:
	li 11,6
	b .L350
.L365:
	lwz 9,84(31)
	lis 4,.LC76@ha
	la 4,.LC76@l(4)
	lwz 11,1792(9)
	lwz 3,40(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L367
	li 11,40
	b .L350
.L367:
	lwz 9,84(31)
	lis 4,.LC77@ha
	la 4,.LC77@l(4)
	lwz 11,1792(9)
	lwz 3,40(11)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L369
	lis 9,gi+12@ha
	lis 4,.LC78@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC78@l(4)
	b .L375
.L369:
	li 11,3
.L350:
	lwz 9,84(31)
	lwz 0,1944(9)
	mr 10,9
	addi 9,9,744
	slwi 0,0,2
	lwzx 9,9,0
	cmpwi 0,9,0
	bc 12,2,.L371
	lwz 0,2000(10)
	cmpwi 0,0,4
	bc 12,2,.L372
	cmpw 0,9,11
	bc 4,0,.L372
	lis 9,gi+12@ha
	lis 4,.LC79@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC79@l(4)
.L375:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L347
.L372:
	li 0,10
	li 11,5
	stw 0,2328(10)
	lwz 9,84(31)
	stw 11,2000(9)
	b .L347
.L371:
	lis 9,gi+12@ha
	lis 4,.LC80@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC80@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L347:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 Cmd_Reload_f,.Lfe10-Cmd_Reload_f
	.section	".rodata"
	.align 2
.LC81:
	.string	"players"
	.align 2
.LC82:
	.string	"say"
	.align 2
.LC83:
	.string	"say_team"
	.align 2
.LC84:
	.string	"score"
	.align 2
.LC85:
	.string	"help"
	.align 2
.LC86:
	.string	"use"
	.align 2
.LC87:
	.string	"drop"
	.align 2
.LC88:
	.string	"give"
	.align 2
.LC89:
	.string	"god"
	.align 2
.LC90:
	.string	"notarget"
	.align 2
.LC91:
	.string	"noclip"
	.align 2
.LC92:
	.string	"inven"
	.align 2
.LC93:
	.string	"invnext"
	.align 2
.LC94:
	.string	"invprev"
	.align 2
.LC95:
	.string	"invnextw"
	.align 2
.LC96:
	.string	"invprevw"
	.align 2
.LC97:
	.string	"invnextp"
	.align 2
.LC98:
	.string	"invprevp"
	.align 2
.LC99:
	.string	"invuse"
	.align 2
.LC100:
	.string	"invdrop"
	.align 2
.LC101:
	.string	"weapprev"
	.align 2
.LC102:
	.string	"weapnext"
	.align 2
.LC103:
	.string	"weaplast"
	.align 2
.LC104:
	.string	"kill"
	.align 2
.LC105:
	.string	"putaway"
	.align 2
.LC106:
	.string	"wave"
	.align 2
.LC107:
	.string	"playerlist"
	.align 2
.LC108:
	.string	"team"
	.align 2
.LC109:
	.string	"id"
	.align 2
.LC110:
	.string	"chasecam"
	.align 2
.LC111:
	.string	"camzoomout"
	.align 2
.LC112:
	.string	"out"
	.align 2
.LC113:
	.string	"camzoomin"
	.align 2
.LC114:
	.string	"in"
	.align 2
.LC115:
	.string	"camviewlock"
	.align 2
.LC116:
	.string	"camreset"
	.align 2
.LC117:
	.string	"radio_power"
	.align 2
.LC118:
	.string	"radio"
	.align 2
.LC119:
	.string	"ALL"
	.align 2
.LC120:
	.string	"tradio"
	.align 2
.LC121:
	.string	"TEAM"
	.align 2
.LC122:
	.string	"infrared"
	.align 2
.LC123:
	.string	"flashlight"
	.align 2
.LC124:
	.string	"reload"
	.align 2
.LC126:
	.string	"playdead"
	.align 2
.LC127:
	.string	"laser"
	.align 2
.LC128:
	.string	"fence"
	.align 2
.LC129:
	.string	"c4"
	.align 2
.LC130:
	.string	"sight"
	.align 2
.LC131:
	.string	"zoom"
	.align 2
.LC132:
	.string	"airstrike1"
	.align 2
.LC133:
	.string	"airstrike2"
	.align 3
.LC125:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC134:
	.long 0x0
	.align 2
.LC135:
	.long 0x40a00000
	.align 2
.LC136:
	.long 0x447a0000
	.align 2
.LC137:
	.long 0x42b40000
	.align 2
.LC138:
	.long 0x42200000
	.align 2
.LC139:
	.long 0x41a00000
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
	bc 12,2,.L377
	lis 9,gi@ha
	li 3,0
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC81@ha
	la 4,.LC81@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L379
	mr 3,29
	bl Cmd_Players_f
	b .L377
.L379:
	lis 4,.LC82@ha
	mr 3,31
	la 4,.LC82@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L380
	mr 3,29
	li 4,0
	b .L629
.L380:
	lis 4,.LC83@ha
	mr 3,31
	la 4,.LC83@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L381
	mr 3,29
	li 4,1
.L629:
	li 5,0
	bl Cmd_Say_f
	b .L377
.L381:
	lis 4,.LC84@ha
	mr 3,31
	la 4,.LC84@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L382
	mr 3,29
	bl Cmd_Score_f
	b .L377
.L382:
	lis 4,.LC85@ha
	mr 3,31
	la 4,.LC85@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L383
	mr 3,29
	bl Cmd_Help_f
	b .L377
.L383:
	lis 8,.LC134@ha
	lis 9,level+200@ha
	la 8,.LC134@l(8)
	lfs 0,level+200@l(9)
	lfs 31,0(8)
	fcmpu 0,0,31
	bc 4,2,.L377
	lis 4,.LC86@ha
	mr 3,31
	la 4,.LC86@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L385
	mr 3,29
	bl Cmd_Use_f
	b .L377
.L385:
	lis 4,.LC87@ha
	mr 3,31
	la 4,.LC87@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L387
	lwz 9,164(30)
	mtlr 9
	blrl
	mr 31,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L388
	lwz 0,8(30)
	lis 5,.LC17@ha
	mr 3,29
	la 5,.LC17@l(5)
	b .L630
.L388:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L390
	lwz 0,8(30)
	lis 5,.LC37@ha
	mr 3,29
	la 5,.LC37@l(5)
	b .L631
.L390:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,11,744
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L391
	lwz 0,8(30)
	lis 5,.LC19@ha
	mr 3,29
	la 5,.LC19@l(5)
.L630:
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L377
.L391:
	mr 3,29
	mtlr 10
	blrl
	b .L377
.L387:
	lis 4,.LC88@ha
	mr 3,31
	la 4,.LC88@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L393
	mr 3,29
	bl Cmd_Give_f
	b .L377
.L393:
	lis 4,.LC89@ha
	mr 3,31
	la 4,.LC89@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L395
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L396
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L396
	lwz 0,8(30)
	lis 5,.LC1@ha
	mr 3,29
	la 5,.LC1@l(5)
	b .L631
.L396:
	lwz 0,264(29)
	xori 0,0,16
	andi. 8,0,16
	stw 0,264(29)
	bc 4,2,.L398
	lis 9,.LC11@ha
	la 5,.LC11@l(9)
	b .L411
.L398:
	lis 9,.LC12@ha
	la 5,.LC12@l(9)
	b .L411
.L395:
	lis 4,.LC90@ha
	mr 3,31
	la 4,.LC90@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L401
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L402
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L402
	lwz 0,8(30)
	lis 5,.LC1@ha
	mr 3,29
	la 5,.LC1@l(5)
	b .L631
.L402:
	lwz 0,264(29)
	xori 0,0,32
	andi. 8,0,32
	stw 0,264(29)
	bc 4,2,.L404
	lis 9,.LC13@ha
	la 5,.LC13@l(9)
	b .L411
.L404:
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L411
.L401:
	lis 4,.LC91@ha
	mr 3,31
	la 4,.LC91@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L407
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L408
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L408
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC1@l(5)
	b .L631
.L408:
	lwz 0,260(29)
	cmpwi 0,0,1
	bc 4,2,.L410
	li 0,4
	lis 9,.LC15@ha
	stw 0,260(29)
	la 5,.LC15@l(9)
	b .L411
.L410:
	li 0,1
	lis 9,.LC16@ha
	stw 0,260(29)
	la 5,.LC16@l(9)
.L411:
	lis 9,gi+8@ha
	mr 3,29
	lwz 0,gi+8@l(9)
.L631:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L377
.L407:
	lis 4,.LC92@ha
	mr 3,31
	la 4,.LC92@l(4)
	bl Q_strcasecmp
	mr. 3,3
	bc 4,2,.L413
	lwz 31,84(29)
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	stw 3,1936(31)
	stw 3,1920(31)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L414
	lwz 0,1840(31)
	cmpwi 0,0,0
	bc 4,2,.L414
	mr 3,29
	bl CTFOpenJoinMenu
	b .L377
.L414:
	lwz 9,84(29)
	lwz 9,1928(9)
	cmpwi 0,9,0
	bc 12,2,.L416
	mr 3,29
	bl PMenu_Close
	b .L546
.L416:
	lwz 0,1932(31)
	cmpwi 0,0,0
	bc 12,2,.L417
	stw 9,1932(31)
	b .L377
.L417:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,1932(31)
	li 3,5
	lwz 0,100(9)
	addi 30,31,1764
	mr 28,9
	addi 31,31,744
	mtlr 0
	blrl
.L420:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,30
	bc 4,1,.L420
	lis 9,gi+92@ha
	mr 3,29
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L377
.L413:
	lis 4,.LC93@ha
	mr 3,31
	la 4,.LC93@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L424
	lwz 8,84(29)
	lwz 0,1928(8)
	cmpwi 0,0,0
	bc 4,2,.L632
	lwz 0,2236(8)
	cmpwi 0,0,0
	bc 4,2,.L633
	li 0,256
	lis 9,itemlist@ha
	lwz 5,740(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,744
.L628:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L432
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L432
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L621
.L432:
	addi 7,7,1
	bdnz .L628
	b .L634
.L424:
	lis 4,.LC94@ha
	mr 3,31
	la 4,.LC94@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L437
	lwz 7,84(29)
	lwz 0,1928(7)
	cmpwi 0,0,0
	bc 4,2,.L635
	lwz 0,2236(7)
	cmpwi 0,0,0
	bc 4,2,.L636
	li 0,256
	lwz 11,740(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,744
	la 5,itemlist@l(9)
	addi 11,11,255
.L627:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L445
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L445
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L622
.L445:
	addi 11,11,-1
	bdnz .L627
	b .L637
.L437:
	lis 4,.LC95@ha
	mr 3,31
	la 4,.LC95@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L450
	lwz 8,84(29)
	lwz 0,1928(8)
	cmpwi 0,0,0
	bc 4,2,.L632
	lwz 0,2236(8)
	cmpwi 0,0,0
	bc 4,2,.L633
	li 0,256
	lis 9,itemlist@ha
	lwz 5,740(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,744
.L626:
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
	andi. 9,0,1
	bc 4,2,.L621
.L458:
	addi 7,7,1
	bdnz .L626
	b .L634
.L450:
	lis 4,.LC96@ha
	mr 3,31
	la 4,.LC96@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L463
	lwz 7,84(29)
	lwz 0,1928(7)
	cmpwi 0,0,0
	bc 4,2,.L635
	lwz 0,2236(7)
	cmpwi 0,0,0
	bc 4,2,.L636
	li 0,256
	lwz 11,740(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,744
	la 5,itemlist@l(9)
	addi 11,11,255
.L625:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L471
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L471
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L622
.L471:
	addi 11,11,-1
	bdnz .L625
	b .L637
.L463:
	lis 4,.LC97@ha
	mr 3,31
	la 4,.LC97@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L476
	lwz 8,84(29)
	lwz 0,1928(8)
	cmpwi 0,0,0
	bc 12,2,.L477
.L632:
	mr 3,29
	bl PMenu_Next
	b .L377
.L477:
	lwz 0,2236(8)
	cmpwi 0,0,0
	bc 12,2,.L479
.L633:
	mr 3,29
	bl ChaseNext
	b .L377
.L479:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,740(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,744
.L624:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L484
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L484
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L621
.L484:
	addi 7,7,1
	bdnz .L624
.L634:
	li 0,-1
	stw 0,740(8)
	b .L377
.L476:
	lis 4,.LC98@ha
	mr 3,31
	la 4,.LC98@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L489
	lwz 7,84(29)
	lwz 0,1928(7)
	cmpwi 0,0,0
	bc 12,2,.L490
.L635:
	mr 3,29
	bl PMenu_Prev
	b .L377
.L490:
	lwz 0,2236(7)
	cmpwi 0,0,0
	bc 12,2,.L492
.L636:
	mr 3,29
	bl ChasePrev
	b .L377
.L492:
	li 0,256
	lwz 11,740(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,744
	la 5,itemlist@l(9)
	addi 11,11,255
.L623:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L497
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L497
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L622
.L497:
	addi 11,11,-1
	bdnz .L623
.L637:
	li 0,-1
	stw 0,740(7)
	b .L377
.L489:
	lis 4,.LC99@ha
	mr 3,31
	la 4,.LC99@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L502
	mr 3,29
	bl Cmd_InvUse_f
	b .L377
.L502:
	lis 4,.LC100@ha
	mr 3,31
	la 4,.LC100@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L504
	mr 3,29
	bl Cmd_InvDrop_f
	b .L377
.L504:
	lis 4,.LC101@ha
	mr 3,31
	la 4,.LC101@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L506
	lwz 28,84(29)
	lwz 11,1792(28)
	cmpwi 0,11,0
	bc 12,2,.L377
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,28,744
	mullw 9,9,0
	srawi 27,9,2
.L511:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L513
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L513
	lwz 0,56(31)
	andi. 8,0,1
	bc 12,2,.L513
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1792(28)
	cmpw 0,0,31
	bc 12,2,.L377
.L513:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L511
	b .L377
.L506:
	lis 4,.LC102@ha
	mr 3,31
	la 4,.LC102@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L519
	lwz 28,84(29)
	lwz 11,1792(28)
	cmpwi 0,11,0
	bc 12,2,.L377
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 27,1
	subf 9,9,11
	addi 26,28,744
	mullw 9,9,0
	srawi 9,9,2
	addi 30,9,255
.L524:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L526
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L526
	lwz 0,56(31)
	andi. 8,0,1
	bc 12,2,.L526
	mr 3,29
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1792(28)
	cmpw 0,0,31
	bc 12,2,.L377
.L526:
	addi 27,27,1
	addi 30,30,-1
	cmpwi 0,27,256
	bc 4,1,.L524
	b .L377
.L519:
	lis 4,.LC103@ha
	mr 3,31
	la 4,.LC103@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L532
	lwz 10,84(29)
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L377
	lwz 0,1796(10)
	cmpwi 0,0,0
	bc 12,2,.L377
	lis 11,itemlist@ha
	lis 9,0x286b
	la 4,itemlist@l(11)
	ori 9,9,51739
	subf 0,4,0
	addi 11,10,744
	mullw 0,0,9
	srawi 10,0,2
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L377
	mulli 0,10,76
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L377
	lwz 0,56(4)
	andi. 8,0,1
	bc 12,2,.L377
	mr 3,29
	mtlr 9
	blrl
	b .L377
.L532:
	lis 4,.LC104@ha
	mr 3,31
	la 4,.LC104@l(4)
	bl Q_strcasecmp
	mr. 10,3
	bc 4,2,.L540
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 12,2,.L377
	lwz 11,84(29)
	lis 9,level+4@ha
	lis 8,.LC135@ha
	lfs 0,level+4@l(9)
	la 8,.LC135@l(8)
	lfs 13,2232(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L377
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
	b .L377
.L540:
	lis 4,.LC105@ha
	mr 3,31
	la 4,.LC105@l(4)
	bl Q_strcasecmp
	mr. 3,3
	bc 4,2,.L545
	lwz 9,84(29)
	stw 3,1920(9)
	lwz 11,84(29)
	stw 3,1936(11)
	lwz 9,84(29)
	stw 3,1932(9)
	lwz 11,84(29)
	lwz 0,1928(11)
	cmpwi 0,0,0
	bc 12,2,.L546
	mr 3,29
	bl PMenu_Close
.L546:
	lwz 9,84(29)
	li 0,1
	stw 0,2240(9)
	b .L377
.L545:
	lis 4,.LC106@ha
	mr 3,31
	la 4,.LC106@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L549
	mr 3,29
	bl Cmd_Wave_f
	b .L377
.L549:
	lis 4,.LC107@ha
	mr 3,31
	la 4,.LC107@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L551
	mr 3,29
	bl Cmd_PlayerList_f
	b .L377
.L551:
	lis 4,.LC108@ha
	mr 3,31
	la 4,.LC108@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L553
	mr 3,29
	bl CTFTeam_f
	b .L377
.L553:
	lis 4,.LC109@ha
	mr 3,31
	la 4,.LC109@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L555
	mr 3,29
	bl CTFID_f
	b .L377
.L555:
	lis 4,.LC110@ha
	mr 3,31
	la 4,.LC110@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L557
	mr 3,29
	bl Cmd_Chasecam_Toggle
	b .L377
.L557:
	lis 4,.LC111@ha
	mr 3,31
	la 4,.LC111@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L559
	lis 4,.LC112@ha
	mr 3,29
	la 4,.LC112@l(4)
	bl Cmd_Chasecam_Zoom
	b .L377
.L559:
	lis 4,.LC113@ha
	mr 3,31
	la 4,.LC113@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L561
	lis 4,.LC114@ha
	mr 3,29
	la 4,.LC114@l(4)
	bl Cmd_Chasecam_Zoom
	b .L377
.L561:
	lis 4,.LC115@ha
	mr 3,31
	la 4,.LC115@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L563
	mr 3,29
	bl Cmd_Chasecam_Viewlock
	b .L377
.L563:
	lis 4,.LC116@ha
	mr 3,31
	la 4,.LC116@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L565
	lwz 3,84(29)
	lwz 9,2244(3)
	xori 11,9,3
	addic 0,9,-1
	subfe 10,0,9
	addic 8,11,-1
	subfe 0,8,11
	and. 9,0,10
	bc 12,2,.L377
	lwz 9,2252(3)
	li 0,0
	stw 0,892(9)
	b .L377
.L565:
	lis 4,.LC117@ha
	mr 3,31
	la 4,.LC117@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L568
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	mr 4,3
	mr 3,29
	bl X_Radio_Power_f
	b .L377
.L568:
	lis 4,.LC118@ha
	mr 3,31
	la 4,.LC118@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L570
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	mr 5,3
	lis 4,.LC119@ha
	mr 3,29
	la 4,.LC119@l(4)
	bl X_Radio_f
	b .L377
.L570:
	lis 4,.LC120@ha
	mr 3,31
	la 4,.LC120@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L572
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	mr 5,3
	lis 4,.LC121@ha
	mr 3,29
	la 4,.LC121@l(4)
	bl X_Radio_f
	b .L377
.L572:
	lis 4,.LC122@ha
	mr 3,31
	la 4,.LC122@l(4)
	bl Q_strcasecmp
	mr. 3,3
	bc 4,2,.L574
	lwz 9,84(29)
	lwz 0,2272(9)
	cmpwi 0,0,0
	bc 12,2,.L575
	stw 3,2272(9)
	lwz 9,84(29)
	lwz 0,116(9)
	rlwinm 0,0,0,30,28
	stw 0,116(9)
	b .L377
.L575:
	li 0,1
	stw 0,2272(9)
	lwz 9,84(29)
	lwz 0,116(9)
	ori 0,0,4
	stw 0,116(9)
	b .L377
.L574:
	lis 4,.LC123@ha
	mr 3,31
	la 4,.LC123@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L579
	mr 3,29
	bl FL_make
	b .L377
.L579:
	lis 4,.LC124@ha
	mr 3,31
	la 4,.LC124@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L581
	mr 3,29
	bl Cmd_Reload_f
	b .L377
.L581:
	lis 4,.LC66@ha
	mr 3,31
	la 4,.LC66@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L583
	li 31,0
	addi 30,29,4
	b .L584
.L586:
	lwz 3,280(31)
	lis 4,.LC66@ha
	la 4,.LC66@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L584
	lwz 0,256(31)
	cmpw 0,0,29
	bc 4,2,.L584
	lis 9,level+4@ha
	lis 11,.LC125@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC125@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L584:
	lis 8,.LC136@ha
	mr 3,31
	la 8,.LC136@l(8)
	mr 4,30
	lfs 1,0(8)
	bl findradius
	mr. 31,3
	bc 4,2,.L586
	b .L377
.L583:
	lis 4,.LC126@ha
	mr 3,31
	la 4,.LC126@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L591
	mr 3,29
	bl PlayDead
	b .L377
.L591:
	lis 4,.LC127@ha
	mr 3,31
	la 4,.LC127@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L593
	mr 3,29
	bl PlaceLaser
	b .L377
.L593:
	lis 4,.LC128@ha
	mr 3,31
	la 4,.LC128@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L595
	mr 3,29
	bl Cmd_LaserFence_f
	b .L377
.L595:
	lis 4,.LC129@ha
	mr 3,31
	la 4,.LC129@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L597
	mr 3,29
	bl PlaceC4
	b .L377
.L597:
	lis 4,.LC130@ha
	mr 3,31
	la 4,.LC130@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L599
	mr 3,29
	bl SP_LaserSight
	b .L377
.L599:
	lis 4,.LC131@ha
	mr 3,31
	la 4,.LC131@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L601
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(29)
	lwz 0,1888(9)
	cmpwi 0,0,7
	bc 4,2,.L377
	cmpwi 0,3,0
	bc 4,2,.L603
	lis 0,0x42b4
	stw 0,112(9)
	b .L377
.L603:
	cmpwi 0,3,1
	bc 4,2,.L377
	lis 8,.LC137@ha
	lfs 13,112(9)
	la 8,.LC137@l(8)
	lfs 12,0(8)
	fcmpu 0,13,12
	bc 4,2,.L606
	lis 0,0x4220
	stw 0,112(9)
	b .L377
.L606:
	lis 11,.LC138@ha
	la 11,.LC138@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L608
	lis 0,0x41a0
	stw 0,112(9)
	b .L377
.L608:
	lis 8,.LC139@ha
	la 8,.LC139@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,2,.L610
	lis 0,0x4120
	stw 0,112(9)
	b .L377
.L610:
	stfs 12,112(9)
	b .L377
.L601:
	lis 4,.LC132@ha
	mr 3,31
	la 4,.LC132@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L613
	li 0,1
	b .L638
.L613:
	lis 4,.LC133@ha
	mr 3,31
	la 4,.LC133@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L615
	li 0,2
.L638:
	mr 3,29
	stw 0,972(29)
	bl Cmd_Airstrike_f
	b .L377
.L621:
	stw 11,740(8)
	b .L377
.L622:
	stw 8,740(7)
	b .L377
.L615:
	mr 3,29
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L377:
	lwz 0,52(1)
	mtlr 0
	lmw 25,12(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 ClientCommand,.Lfe11-ClientCommand
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
	bc 4,2,.L57
	lwz 0,1928(8)
	cmpwi 0,0,0
	bc 12,2,.L59
	bl PMenu_Next
	b .L57
.L59:
	lwz 0,2236(8)
	cmpwi 0,0,0
	bc 12,2,.L61
	bl ChaseNext
	b .L57
.L639:
	stw 11,740(8)
	b .L57
.L61:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 7,1
.L640:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L66
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L66
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L639
.L66:
	addi 7,7,1
	bdnz .L640
	li 0,-1
	stw 0,740(8)
.L57:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe12:
	.size	 ValidateSelectedItem,.Lfe12-ValidateSelectedItem
	.comm	lights,4,4
	.comm	saved_client,780,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_blaster,4,4
	.comm	item_shotgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_supershotgun,4,4
	.comm	item_chaingun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_railgun,4,4
	.comm	item_bfg,4,4
	.comm	item_jacketarmor,4,4
	.comm	item_combatarmor,4,4
	.comm	item_bodyarmor,4,4
	.comm	item_armorshard,4,4
	.comm	item_powerscreen,4,4
	.comm	item_powershield,4,4
	.comm	item_adrenaline,4,4
	.comm	item_health,4,4
	.comm	item_stimpak,4,4
	.comm	item_health_large,4,4
	.comm	item_health_mega,4,4
	.comm	item_quad,4,4
	.comm	item_invulnerability,4,4
	.comm	item_silencer,4,4
	.comm	item_breather,4,4
	.comm	item_enviro,4,4
	.comm	item_pack,4,4
	.comm	item_bandolier,4,4
	.comm	item_ancient_head,4,4
	.comm	key_data_cd,4,4
	.comm	key_power_cube,4,4
	.comm	key_pyramid,4,4
	.comm	key_data_spinner,4,4
	.comm	key_pass,4,4
	.comm	key_blue_key,4,4
	.comm	key_red_key,4,4
	.comm	key_commander_head,4,4
	.comm	key_airstrike_target,4,4
	.section	".rodata"
	.align 2
.LC140:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientTeam
	.type	 ClientTeam,@function
ClientTeam:
	lis 11,.LC140@ha
	lis 9,deathmatch@ha
	la 11,.LC140@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L7
	li 3,0
	blr
.L7:
	lis 9,team_dm@ha
	lwz 11,team_dm@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L8
	lwz 9,84(3)
	lwz 3,1884(9)
	addi 0,3,-1
	cmplwi 0,0,3
	bc 12,1,.L10
	blr
.L8:
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L10
	lwz 3,84(3)
	lwz 9,1840(3)
	cmpwi 0,9,1
	bc 12,1,.L10
	lwz 0,1884(3)
	mr 3,9
	cmpwi 0,0,0
	bclr 12,1
.L10:
	li 3,0
	blr
.Lfe13:
	.size	 ClientTeam,.Lfe13-ClientTeam
	.align 2
	.globl SelectNextItem
	.type	 SelectNextItem,@function
SelectNextItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 8,84(3)
	lwz 0,1928(8)
	cmpwi 0,0,0
	bc 12,2,.L36
	bl PMenu_Next
	b .L35
.L36:
	lwz 0,2236(8)
	cmpwi 0,0,0
	bc 12,2,.L37
	bl ChaseNext
	b .L35
.L642:
	stw 11,740(8)
	b .L35
.L37:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,740(8)
	mtctr 0
	li 7,1
	la 3,itemlist@l(9)
	addi 6,8,744
.L643:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L40
	mulli 0,11,76
	add 10,0,3
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L40
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L642
.L40:
	addi 7,7,1
	bdnz .L643
	li 0,-1
	stw 0,740(8)
.L35:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 SelectNextItem,.Lfe14-SelectNextItem
	.align 2
	.globl SelectPrevItem
	.type	 SelectPrevItem,@function
SelectPrevItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 7,84(3)
	lwz 0,1928(7)
	cmpwi 0,0,0
	bc 12,2,.L47
	bl PMenu_Prev
	b .L46
.L47:
	lwz 0,2236(7)
	cmpwi 0,0,0
	bc 12,2,.L48
	bl ChasePrev
	b .L46
.L644:
	stw 8,740(7)
	b .L46
.L48:
	li 0,256
	lwz 11,740(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,744
	la 5,itemlist@l(9)
	addi 11,11,255
.L645:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L51
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L51
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L644
.L51:
	addi 11,11,-1
	bdnz .L645
	li 0,-1
	stw 0,740(7)
.L46:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 SelectPrevItem,.Lfe15-SelectPrevItem
	.section	".rodata"
	.align 2
.LC141:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC141@ha
	lis 9,deathmatch@ha
	la 11,.LC141@l(11)
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
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(3)
	bc 4,2,.L125
	lis 9,.LC11@ha
	la 5,.LC11@l(9)
	b .L126
.L125:
	lis 9,.LC12@ha
	la 5,.LC12@l(9)
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
	.size	 Cmd_God_f,.Lfe16-Cmd_God_f
	.section	".rodata"
	.align 2
.LC142:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC142@ha
	lis 9,deathmatch@ha
	la 11,.LC142@l(11)
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
	lwz 0,264(3)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(3)
	bc 4,2,.L129
	lis 9,.LC13@ha
	la 5,.LC13@l(9)
	b .L130
.L129:
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
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
	.size	 Cmd_Notarget_f,.Lfe17-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC143:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC143@ha
	lis 9,deathmatch@ha
	la 11,.LC143@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L132
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L132
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L131
.L132:
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 4,2,.L133
	li 0,4
	lis 9,.LC15@ha
	stw 0,260(3)
	la 5,.LC15@l(9)
	b .L134
.L133:
	li 0,1
	lis 9,.LC16@ha
	stw 0,260(3)
	la 5,.LC16@l(9)
.L134:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L131:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 Cmd_Noclip_f,.Lfe18-Cmd_Noclip_f
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
	bc 4,2,.L192
	lwz 0,8(29)
	lis 5,.LC17@ha
	mr 3,31
	la 5,.LC17@l(5)
	b .L646
.L192:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L193
	lwz 0,8(29)
	lis 5,.LC37@ha
	mr 3,31
	la 5,.LC37@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L191
.L193:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,11,744
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L194
	lwz 0,8(29)
	lis 5,.LC19@ha
	mr 3,31
	la 5,.LC19@l(5)
.L646:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L191
.L194:
	mr 3,31
	mtlr 10
	blrl
.L191:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 Cmd_Drop_f,.Lfe19-Cmd_Drop_f
	.section	".rodata"
	.align 2
.LC144:
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
	lis 9,.LC144@ha
	mr 30,3
	la 9,.LC144@l(9)
	lwz 31,84(30)
	lis 11,ctf@ha
	lfs 13,0(9)
	li 0,0
	lwz 9,ctf@l(11)
	stw 0,1936(31)
	stw 0,1920(31)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L196
	lwz 0,1840(31)
	cmpwi 0,0,0
	bc 4,2,.L196
	bl CTFOpenJoinMenu
	b .L195
.L196:
	lwz 9,84(30)
	lwz 9,1928(9)
	cmpwi 0,9,0
	bc 12,2,.L197
	mr 3,30
	bl PMenu_Close
	lwz 9,84(30)
	li 0,1
	stw 0,2240(9)
	b .L195
.L197:
	lwz 0,1932(31)
	cmpwi 0,0,0
	bc 12,2,.L198
	stw 9,1932(31)
	b .L195
.L198:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,1932(31)
	li 3,5
	lwz 0,100(9)
	addi 29,31,1764
	mr 28,9
	addi 31,31,744
	mtlr 0
	blrl
.L202:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,29
	bc 4,1,.L202
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L195:
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
	lwz 11,1792(29)
	cmpwi 0,11,0
	bc 12,2,.L224
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,29,744
	mullw 9,9,0
	srawi 27,9,2
.L229:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L228
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L228
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L228
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1792(29)
	cmpw 0,0,31
	bc 12,2,.L224
.L228:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L229
.L224:
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
	lwz 11,1792(29)
	cmpwi 0,11,0
	bc 12,2,.L235
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 28,1
	subf 9,9,11
	addi 26,29,744
	mullw 9,9,0
	srawi 9,9,2
	addi 30,9,255
.L240:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L239
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L239
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L239
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1792(29)
	cmpw 0,0,31
	bc 12,2,.L235
.L239:
	addi 28,28,1
	addi 30,30,-1
	cmpwi 0,28,256
	bc 4,1,.L240
.L235:
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
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L246
	lwz 0,1796(10)
	cmpwi 0,0,0
	bc 12,2,.L246
	lis 11,itemlist@ha
	lis 9,0x286b
	la 4,itemlist@l(11)
	ori 9,9,51739
	subf 0,4,0
	addi 11,10,744
	mullw 0,0,9
	srawi 10,0,2
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L246
	mulli 0,10,76
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L246
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L246
	mtlr 9
	blrl
.L246:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 Cmd_WeapLast_f,.Lfe23-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC145:
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
	bc 12,2,.L271
	lwz 11,84(10)
	lis 9,level+4@ha
	lis 8,.LC145@ha
	lfs 0,level+4@l(9)
	la 8,.LC145@l(8)
	lfs 13,2232(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L271
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
.L271:
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
	stw 0,1920(9)
	lwz 11,84(31)
	stw 0,1936(11)
	lwz 9,84(31)
	stw 0,1932(9)
	lwz 11,84(31)
	lwz 0,1928(11)
	cmpwi 0,0,0
	bc 12,2,.L275
	bl PMenu_Close
.L275:
	lwz 9,84(31)
	li 0,1
	stw 0,2240(9)
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
	mulli 9,9,2384
	mulli 11,3,2384
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
	.align 2
	.globl Cmd_Infrared_f
	.type	 Cmd_Infrared_f,@function
Cmd_Infrared_f:
	lwz 9,84(3)
	lwz 0,2272(9)
	cmpwi 0,0,0
	bc 12,2,.L339
	li 0,0
	stw 0,2272(9)
	lwz 9,84(3)
	lwz 0,116(9)
	rlwinm 0,0,0,30,28
	stw 0,116(9)
	blr
.L339:
	li 0,1
	stw 0,2272(9)
	lwz 9,84(3)
	lwz 0,116(9)
	ori 0,0,4
	stw 0,116(9)
	blr
.Lfe27:
	.size	 Cmd_Infrared_f,.Lfe27-Cmd_Infrared_f
	.section	".rodata"
	.align 3
.LC146:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC147:
	.long 0x447a0000
	.section	".text"
	.align 2
	.globl Cmd_DetPipes_f
	.type	 Cmd_DetPipes_f,@function
Cmd_DetPipes_f:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	lis 9,.LC146@ha
	lis 11,level@ha
	lfd 31,.LC146@l(9)
	la 28,level@l(11)
	mr 30,3
	li 31,0
	lis 29,.LC66@ha
	b .L342
.L344:
	lwz 3,280(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L342
	lwz 0,256(31)
	cmpw 0,0,30
	bc 4,2,.L342
	lfs 0,4(28)
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(31)
.L342:
	lis 9,.LC147@ha
	mr 3,31
	la 9,.LC147@l(9)
	addi 4,30,4
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	la 4,.LC66@l(29)
	bc 4,2,.L344
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe28:
	.size	 Cmd_DetPipes_f,.Lfe28-Cmd_DetPipes_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
