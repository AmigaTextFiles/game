	.file	"g_items.c"
gcc2_compiled.:
	.globl jacketarmor_info
	.section	".data"
	.align 2
	.type	 jacketarmor_info,@object
	.size	 jacketarmor_info,20
jacketarmor_info:
	.long 25
	.long 50
	.long 0x3e99999a
	.long 0x0
	.long 1
	.globl combatarmor_info
	.align 2
	.type	 combatarmor_info,@object
	.size	 combatarmor_info,20
combatarmor_info:
	.long 50
	.long 100
	.long 0x3f19999a
	.long 0x3e99999a
	.long 2
	.globl bodyarmor_info
	.align 2
	.type	 bodyarmor_info,@object
	.size	 bodyarmor_info,20
bodyarmor_info:
	.long 100
	.long 200
	.long 0x3f4ccccd
	.long 0x3f19999a
	.long 3
	.globl num_items
	.section	".sdata","aw"
	.align 2
	.type	 num_items,@object
	.size	 num_items,4
num_items:
	.long 0
	.section	".rodata"
	.align 2
.LC1:
	.long 0x3f800000
	.align 2
.LC2:
	.long 0x40000000
	.align 2
.LC3:
	.long 0x0
	.align 3
.LC4:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Powerup
	.type	 Pickup_Powerup,@function
Pickup_Powerup:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	lis 11,skill@ha
	lis 9,itemlist@ha
	lwz 8,648(31)
	lis 0,0x286b
	lwz 10,skill@l(11)
	la 9,itemlist@l(9)
	lis 7,.LC1@ha
	ori 0,0,51739
	mr 30,4
	subf 9,9,8
	la 7,.LC1@l(7)
	lfs 13,20(10)
	mullw 9,9,0
	lwz 11,84(30)
	lfs 0,0(7)
	rlwinm 9,9,0,0,29
	addi 11,11,740
	lwzx 11,11,9
	fcmpu 7,13,0
	cmpwi 6,11,1
	mfcr 9
	rlwinm 0,9,26,1
	rlwinm 9,9,31,1
	and. 10,9,0
	bc 4,2,.L58
	lis 7,.LC2@ha
	srawi 0,11,31
	la 7,.LC2@l(7)
	subf 0,11,0
	lfs 0,0(7)
	srwi 10,0,31
	fcmpu 7,13,0
	cror 31,30,29
	mfcr 9
	rlwinm 9,9,0,1
	and. 0,9,10
	bc 4,2,.L58
	lis 11,coop@ha
	lis 7,.LC3@ha
	lwz 9,coop@l(11)
	la 7,.LC3@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L52
	lwz 0,56(8)
	rlwinm 0,0,29,31,31
	and. 9,0,10
	bc 12,2,.L52
.L58:
	li 3,0
	b .L57
.L52:
	lwz 0,648(31)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	lwz 10,84(30)
	subf 0,9,0
	lis 8,deathmatch@ha
	mullw 0,0,11
	addi 10,10,740
	lis 7,.LC3@ha
	lwz 11,deathmatch@l(8)
	la 7,.LC3@l(7)
	rlwinm 0,0,0,0,29
	lfs 13,0(7)
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L53
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L54
	lis 9,.LC4@ha
	lwz 11,648(31)
	la 9,.LC4@l(9)
	lis 7,0x4330
	lwz 0,264(31)
	lfd 12,0(9)
	lis 6,level+4@ha
	lis 10,DoRespawn@ha
	lwz 9,48(11)
	oris 0,0,0x8000
	la 10,DoRespawn@l(10)
	lwz 11,184(31)
	lis 5,gi+72@ha
	mr 3,31
	xoris 9,9,0x8000
	stw 0,264(31)
	stw 9,20(1)
	ori 11,11,1
	stw 7,16(1)
	lfd 0,16(1)
	stw 11,184(31)
	stw 4,248(31)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,436(31)
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(31)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L54:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,16
	bc 12,2,.L53
	lwz 0,284(31)
	andis. 7,0,2
	bc 12,2,.L53
	lwz 9,648(31)
	mr 3,30
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L53:
	li 3,1
.L57:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Pickup_Powerup,.Lfe1-Pickup_Powerup
	.section	".rodata"
	.align 2
.LC5:
	.string	"key_power_cube"
	.align 2
.LC6:
	.long 0x0
	.section	".text"
	.align 2
	.globl Pickup_Key
	.type	 Pickup_Key,@function
Pickup_Key:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 11,.LC6@ha
	lis 9,coop@ha
	la 11,.LC6@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 30,4
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L79
	lwz 3,280(31)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L80
	lwz 10,84(30)
	lbz 9,286(31)
	lwz 0,1772(10)
	and. 11,0,9
	bc 4,2,.L85
	lwz 0,648(31)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,0
	addi 10,10,740
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lwz 11,84(30)
	lbz 9,286(31)
	lwz 0,1772(11)
	or 0,0,9
	stw 0,1772(11)
	b .L82
.L80:
	lwz 11,648(31)
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,84(30)
	subf 11,9,11
	mullw 11,11,0
	addi 4,10,740
	rlwinm 3,11,0,0,29
	lwzx 0,4,3
	cmpwi 0,0,0
	bc 12,2,.L83
.L85:
	li 3,0
	b .L84
.L83:
	li 0,1
	stwx 0,4,3
.L82:
	li 3,1
	b .L84
.L79:
	lwz 0,648(31)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	lwz 10,84(30)
	subf 0,9,0
	li 3,1
	mullw 0,0,11
	addi 10,10,740
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
.L84:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 Pickup_Key,.Lfe2-Pickup_Key
	.align 2
	.globl Add_Ammo
	.type	 Add_Ammo,@function
Add_Ammo:
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 4,2,.L87
.L113:
	li 3,0
	blr
.L87:
	lwz 0,68(4)
	cmpwi 0,0,2
	bc 4,2,.L88
	li 7,4
	li 10,20
	li 0,2
	b .L89
.L88:
	cmpwi 0,0,1
	bc 4,2,.L90
	li 7,5
	li 10,25
	li 0,1
	b .L89
.L90:
	cmpwi 0,0,3
	bc 4,2,.L92
	li 7,5
	li 10,10
	li 0,3
	b .L89
.L92:
	cmpwi 0,0,4
	bc 4,2,.L94
	li 7,4
	li 10,3
	li 0,7
	b .L89
.L94:
	cmpwi 0,0,5
	bc 4,2,.L96
	li 7,10
	li 10,6
	li 0,4
	b .L89
.L96:
	cmpwi 0,0,6
	bc 4,2,.L98
	li 7,4
	li 10,3
	li 0,6
	b .L89
.L98:
	cmpwi 0,0,7
	bc 4,2,.L100
	li 7,4
	li 10,6
	li 0,5
	b .L89
.L100:
	cmpwi 0,0,9
	bc 4,2,.L102
	li 7,10
	li 10,1
	li 0,15
	b .L89
.L102:
	cmpwi 0,0,10
	bc 4,2,.L104
	li 7,4
	li 10,70
	li 0,9
	b .L89
.L104:
	cmpwi 0,0,11
	bc 4,2,.L113
	li 7,10
	li 10,5
	li 0,8
.L89:
	lwz 11,84(3)
	slwi 6,0,2
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	lis 0,0x286b
	addi 8,11,1792
	subf 9,9,4
	lwzx 11,8,6
	ori 0,0,51739
	mullw 9,9,0
	cmpwi 0,11,0
	srawi 4,9,2
	bc 4,2,.L108
	xori 0,5,1000
	addic 0,0,-1
	subfe 0,0,0
	addi 9,5,-1
	stwx 10,8,6
	andc 9,9,0
	and 0,5,0
	or 5,0,9
.L108:
	lwz 9,84(3)
	slwi 4,4,2
	addi 9,9,740
	lwzx 0,9,4
	cmpw 0,0,7
	bc 12,2,.L113
	add 0,0,5
	stwx 0,9,4
	lwz 9,84(3)
	addi 3,9,740
	lwzx 0,3,4
	cmpw 0,0,7
	bc 4,1,.L111
	stwx 7,3,4
.L111:
	li 3,1
	blr
.Lfe3:
	.size	 Add_Ammo,.Lfe3-Add_Ammo
	.section	".rodata"
	.align 2
.LC7:
	.string	"blaster"
	.align 2
.LC8:
	.long 0x0
	.align 2
.LC9:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Pickup_Ammo
	.type	 Pickup_Ammo,@function
Pickup_Ammo:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr 30,3
	mr 28,4
	lwz 4,648(30)
	lwz 0,56(4)
	andi. 29,0,1
	bc 12,2,.L115
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8192
	li 5,1000
	bc 4,2,.L116
.L115:
	lwz 5,532(30)
	cmpwi 0,5,0
	bc 12,2,.L117
	lwz 4,648(30)
	b .L116
.L117:
	lwz 9,648(30)
	lwz 5,48(9)
	mr 4,9
.L116:
	lis 10,itemlist@ha
	lis 9,0x286b
	lwz 11,84(28)
	la 27,itemlist@l(10)
	ori 9,9,51739
	subf 0,27,4
	addi 11,11,740
	mullw 0,0,9
	mr 3,28
	rlwinm 0,0,0,0,29
	lwzx 31,11,0
	bl Add_Ammo
	cmpwi 0,3,0
	bc 4,2,.L119
	li 3,0
	b .L133
.L134:
	mr 9,31
	b .L129
.L119:
	subfic 9,31,0
	adde 0,9,31
	and. 11,29,0
	bc 12,2,.L120
	lwz 25,84(28)
	lwz 9,648(30)
	lwz 0,1764(25)
	cmpw 0,0,9
	bc 12,2,.L120
	lis 9,.LC8@ha
	lis 11,deathmatch@ha
	la 9,.LC8@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L122
	lis 9,game@ha
	li 29,0
	la 9,game@l(9)
	lis 11,.LC7@ha
	lwz 0,1556(9)
	la 26,.LC7@l(11)
	mr 31,27
	cmpw 0,29,0
	bc 4,0,.L130
	mr 27,9
.L125:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L127
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L134
.L127:
	lwz 0,1556(27)
	addi 29,29,1
	addi 31,31,76
	cmpw 0,29,0
	bc 12,0,.L125
.L130:
	li 9,0
.L129:
	lwz 0,1764(25)
	cmpw 0,0,9
	bc 4,2,.L120
.L122:
	lwz 9,84(28)
	lwz 0,648(30)
	stw 0,4148(9)
.L120:
	lwz 0,284(30)
	andis. 7,0,0x3
	bc 4,2,.L131
	lis 9,.LC8@ha
	lis 11,deathmatch@ha
	la 9,.LC8@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L131
	lwz 9,264(30)
	lis 11,.LC9@ha
	lis 10,level+4@ha
	lwz 0,184(30)
	la 11,.LC9@l(11)
	lis 8,gi+72@ha
	oris 9,9,0x8000
	stw 7,248(30)
	mr 3,30
	ori 0,0,1
	stw 9,264(30)
	stw 0,184(30)
	lfs 0,level+4@l(10)
	lfs 13,0(11)
	lis 11,DoRespawn@ha
	la 11,DoRespawn@l(11)
	fadds 0,0,13
	stw 11,436(30)
	stfs 0,428(30)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
.L131:
	li 3,1
.L133:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 Pickup_Ammo,.Lfe4-Pickup_Ammo
	.section	".rodata"
	.align 2
.LC10:
	.string	"Can't drop current weapon\n"
	.align 2
.LC11:
	.long 0x40a00000
	.align 2
.LC12:
	.long 0x0
	.align 2
.LC13:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Pickup_Health
	.type	 Pickup_Health,@function
Pickup_Health:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 0,644(31)
	andi. 8,0,1
	bc 4,2,.L145
	lwz 9,480(30)
	lwz 0,484(30)
	cmpw 0,9,0
	bc 4,0,.L156
.L145:
	lwz 0,480(30)
	lwz 9,532(31)
	cmpwi 0,0,249
	mr 11,0
	bc 4,1,.L147
	cmpwi 0,9,25
	bc 4,1,.L147
.L156:
	li 3,0
	b .L155
.L147:
	add 0,11,9
	cmpwi 0,0,250
	stw 0,480(30)
	bc 4,1,.L148
	lwz 0,532(31)
	cmpwi 0,0,25
	bc 4,1,.L148
	li 0,250
	stw 0,480(30)
.L148:
	lwz 0,644(31)
	andi. 9,0,1
	bc 4,2,.L149
	lwz 0,480(30)
	lwz 9,484(30)
	cmpw 0,0,9
	bc 4,1,.L149
	stw 9,480(30)
.L149:
	lwz 0,644(31)
	andi. 11,0,2
	bc 12,2,.L151
	mr 3,30
	bl CTFHasRegeneration
	mr. 3,3
	bc 4,2,.L151
	lis 9,MegaHealth_think@ha
	lis 8,.LC11@ha
	lwz 11,264(31)
	la 9,MegaHealth_think@l(9)
	lis 10,level+4@ha
	lwz 0,184(31)
	la 8,.LC11@l(8)
	stw 9,436(31)
	oris 11,11,0x8000
	lfs 0,level+4@l(10)
	ori 0,0,1
	lfs 13,0(8)
	stw 3,248(31)
	stw 30,256(31)
	fadds 0,0,13
	stw 11,264(31)
	stw 0,184(31)
	stfs 0,428(31)
	b .L152
.L151:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L152
	lis 9,.LC12@ha
	lis 11,deathmatch@ha
	la 9,.LC12@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L152
	lwz 9,264(31)
	lis 11,.LC13@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC13@l(11)
	lis 8,gi+72@ha
	oris 9,9,0x8000
	stw 7,248(31)
	mr 3,31
	ori 0,0,1
	stw 9,264(31)
	stw 0,184(31)
	lfs 0,level+4@l(10)
	lfs 13,0(11)
	lis 11,DoRespawn@ha
	la 11,DoRespawn@l(11)
	fadds 0,0,13
	stw 11,436(31)
	stfs 0,428(31)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
.L152:
	li 3,1
.L155:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Pickup_Health,.Lfe5-Pickup_Health
	.section	".rodata"
	.align 2
.LC14:
	.long 0x0
	.align 2
.LC15:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl Pickup_Armor
	.type	 Pickup_Armor,@function
Pickup_Armor:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 7,3
	lwz 8,648(7)
	lwz 0,68(8)
	lwz 10,64(8)
	cmpwi 0,0,4
	bc 4,2,.L160
	lis 11,jacket_armor_index@ha
	lwz 9,84(4)
	li 10,2
	lwz 0,jacket_armor_index@l(11)
	addi 9,9,740
	slwi 0,0,2
	stwx 10,9,0
	b .L163
.L160:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(4)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,0(10)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	stwx 10,11,9
.L163:
	lwz 0,284(7)
	andis. 6,0,0x1
	bc 4,2,.L175
	lis 9,.LC14@ha
	lis 11,deathmatch@ha
	la 9,.LC14@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L175
	lwz 9,264(7)
	lis 11,.LC15@ha
	lis 10,level+4@ha
	lwz 0,184(7)
	la 11,.LC15@l(11)
	lis 8,gi+72@ha
	oris 9,9,0x8000
	stw 6,248(7)
	mr 3,7
	ori 0,0,1
	stw 9,264(7)
	stw 0,184(7)
	lfs 0,level+4@l(10)
	lfs 13,0(11)
	lis 11,DoRespawn@ha
	la 11,DoRespawn@l(11)
	fadds 0,0,13
	stw 11,436(7)
	stfs 0,428(7)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
.L175:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 Pickup_Armor,.Lfe6-Pickup_Armor
	.section	".rodata"
	.align 2
.LC16:
	.long 0x3f800000
	.align 2
.LC17:
	.long 0x0
	.section	".text"
	.align 2
	.globl Touch_Item
	.type	 Touch_Item,@function
Touch_Item:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,4
	mr 31,3
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L182
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L182
	lwz 9,648(31)
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 12,2,.L182
	mtlr 0
	blrl
	mr. 28,3
	bc 12,2,.L186
	lwz 9,84(30)
	lis 0,0x3e80
	stw 0,4236(9)
	lwz 10,648(31)
	lwz 0,8(10)
	cmpwi 0,0,0
	bc 12,2,.L187
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,10
	mullw 9,9,0
	srawi 9,9,2
	extsh 0,9
	sth 9,144(11)
	stw 0,736(11)
.L187:
	lwz 9,648(31)
	lwz 3,20(9)
	cmpwi 0,3,0
	bc 12,2,.L186
	lis 29,gi@ha
	la 29,gi@l(29)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC16@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC16@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 2,0(9)
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 3,0(9)
	blrl
.L186:
	lwz 0,284(31)
	andis. 9,0,4
	bc 4,2,.L189
	mr 4,30
	mr 3,31
	bl G_UseTargets
	lwz 0,284(31)
	oris 0,0,0x4
	stw 0,284(31)
.L189:
	cmpwi 0,28,0
	bc 12,2,.L182
	lis 9,.LC17@ha
	lis 11,coop@ha
	la 9,.LC17@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L192
	lwz 9,648(31)
	lwz 0,56(9)
	andi. 9,0,8
	bc 12,2,.L192
	lwz 0,284(31)
	andis. 9,0,0x3
	bc 12,2,.L182
.L192:
	lwz 0,264(31)
	cmpwi 0,0,0
	bc 4,0,.L193
	rlwinm 0,0,0,1,31
	stw 0,264(31)
	b .L182
.L193:
	mr 3,31
	bl G_FreeEdict
.L182:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 Touch_Item,.Lfe7-Touch_Item
	.section	".rodata"
	.align 2
.LC18:
	.long 0x42c80000
	.align 2
.LC19:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Drop_Item
	.type	 Drop_Item,@function
Drop_Item:
	stwu 1,-144(1)
	mflr 0
	stmw 26,120(1)
	stw 0,148(1)
	mr 29,4
	mr 30,3
	bl G_Spawn
	lwz 9,0(29)
	mr 31,3
	lis 0,0x1
	stw 0,284(31)
	lis 11,0xc170
	lis 10,0x4170
	stw 9,280(31)
	li 8,512
	stw 29,648(31)
	lis 9,gi@ha
	lwz 0,28(29)
	la 26,gi@l(9)
	stw 11,196(31)
	stw 0,64(31)
	stw 11,188(31)
	stw 11,192(31)
	stw 8,68(31)
	stw 10,208(31)
	stw 10,200(31)
	stw 10,204(31)
	lwz 9,44(26)
	lwz 4,24(29)
	mtlr 9
	blrl
	lis 9,drop_temp_touch@ha
	li 11,1
	stw 30,256(31)
	la 9,drop_temp_touch@l(9)
	li 0,7
	stw 11,248(31)
	stw 0,260(31)
	stw 9,444(31)
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 12,2,.L200
	addi 29,1,24
	addi 4,1,8
	addi 3,3,4252
	mr 5,29
	li 6,0
	addi 27,30,4
	bl AngleVectors
	addi 28,31,4
	lis 0,0x41c0
	li 9,0
	lis 11,0xc180
	stw 0,40(1)
	addi 4,1,40
	stw 9,44(1)
	addi 5,1,8
	mr 6,29
	mr 3,27
	stw 11,48(1)
	mr 7,28
	bl G_ProjectSource
	lwz 0,48(26)
	mr 4,27
	mr 7,28
	mr 8,30
	addi 3,1,56
	addi 5,31,188
	addi 6,31,200
	mtlr 0
	li 9,1
	blrl
	lfs 0,68(1)
	stfs 0,4(31)
	lfs 13,72(1)
	stfs 13,8(31)
	lfs 0,76(1)
	b .L202
.L200:
	addi 3,30,16
	addi 4,1,8
	addi 5,1,24
	li 6,0
	bl AngleVectors
	lfs 0,4(30)
	stfs 0,4(31)
	lfs 13,8(30)
	stfs 13,8(31)
	lfs 0,12(30)
.L202:
	stfs 0,12(31)
	lis 9,.LC18@ha
	addi 3,1,8
	la 9,.LC18@l(9)
	addi 4,31,376
	lfs 1,0(9)
	bl VectorScale
	lis 9,drop_make_touchable@ha
	lis 0,0x4396
	la 9,drop_make_touchable@l(9)
	stw 0,384(31)
	lis 11,level+4@ha
	stw 9,436(31)
	mr 3,31
	lis 9,.LC19@ha
	lfs 0,level+4@l(11)
	la 9,.LC19@l(9)
	lfs 13,0(9)
	lis 9,gi+72@ha
	fadds 0,0,13
	stfs 0,428(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	lwz 0,148(1)
	mtlr 0
	lmw 26,120(1)
	la 1,144(1)
	blr
.Lfe8:
	.size	 Drop_Item,.Lfe8-Drop_Item
	.section	".rodata"
	.align 3
.LC20:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC21:
	.long 0xc1700000
	.align 2
.LC22:
	.long 0x41700000
	.align 2
.LC23:
	.long 0x0
	.align 2
.LC24:
	.long 0xc3000000
	.section	".text"
	.align 2
	.globl droptofloor
	.type	 droptofloor,@function
droptofloor:
	stwu 1,-96(1)
	mflr 0
	stw 31,92(1)
	stw 0,100(1)
	lis 9,.LC21@ha
	lis 11,.LC21@ha
	la 9,.LC21@l(9)
	la 11,.LC21@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC21@ha
	lfs 2,0(11)
	la 9,.LC21@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC22@ha
	lfs 13,0(11)
	la 9,.LC22@l(9)
	lfs 1,0(9)
	lis 9,.LC22@ha
	stfs 13,188(31)
	la 9,.LC22@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC22@ha
	stfs 0,192(31)
	la 9,.LC22@l(9)
	lfs 13,8(11)
	lfs 3,0(9)
	stfs 13,196(31)
	bl tv
	mr 11,3
	lwz 4,268(31)
	lfs 13,0(11)
	cmpwi 0,4,0
	stfs 13,200(31)
	lfs 0,4(11)
	stfs 0,204(31)
	lfs 13,8(11)
	stfs 13,208(31)
	bc 12,2,.L207
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L208
.L207:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L208:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC23@ha
	stw 9,444(31)
	la 11,.LC23@l(11)
	lis 9,.LC24@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC24@l(9)
	lis 11,.LC23@ha
	lfs 3,0(9)
	la 11,.LC23@l(11)
	lfs 2,0(11)
	bl tv
	mr 11,3
	mr 4,31
	lfs 12,8(31)
	lfs 0,0(11)
	lis 9,gi+48@ha
	mr 8,31
	lfsu 11,4(4)
	addi 3,1,8
	addi 5,31,188
	lfs 13,12(31)
	addi 6,31,200
	addi 7,1,72
	lwz 0,gi+48@l(9)
	fadds 11,11,0
	li 9,3
	mtlr 0
	stfs 11,72(1)
	lfs 0,4(11)
	fadds 12,12,0
	stfs 12,76(1)
	lfs 0,8(11)
	fadds 13,13,0
	stfs 13,80(1)
	blrl
	lwz 8,12(1)
	cmpwi 0,8,0
	bc 12,2,.L209
	mr 3,31
	bl G_FreeEdict
	b .L206
.L209:
	lwz 0,308(31)
	lfs 12,20(1)
	lfs 0,24(1)
	cmpwi 0,0,0
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L210
	lwz 11,564(31)
	lwz 0,264(31)
	lwz 9,184(31)
	cmpw 0,31,11
	lwz 10,560(31)
	rlwinm 0,0,0,22,20
	ori 9,9,1
	stw 0,264(31)
	stw 10,536(31)
	stw 9,184(31)
	stw 8,248(31)
	stw 8,560(31)
	bc 4,2,.L210
	lis 11,level+4@ha
	lis 10,.LC20@ha
	lfs 0,level+4@l(11)
	lis 9,DoRespawn@ha
	lfd 13,.LC20@l(10)
	la 9,DoRespawn@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L210:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L212
	lwz 9,64(31)
	li 11,2
	li 10,0
	lwz 0,68(31)
	rlwinm 9,9,0,0,30
	stw 11,248(31)
	rlwinm 0,0,0,23,21
	stw 10,444(31)
	stw 9,64(31)
	stw 0,68(31)
.L212:
	lwz 0,284(31)
	andi. 11,0,1
	bc 12,2,.L213
	lwz 0,184(31)
	lis 9,Use_Item@ha
	li 11,0
	la 9,Use_Item@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
.L213:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L206:
	lwz 0,100(1)
	mtlr 0
	lwz 31,92(1)
	la 1,96(1)
	blr
.Lfe9:
	.size	 droptofloor,.Lfe9-droptofloor
	.section	".rodata"
	.align 2
.LC25:
	.string	"PrecacheItem: %s has bad precache string"
	.align 2
.LC26:
	.string	"md2"
	.align 2
.LC27:
	.string	"sp2"
	.align 2
.LC28:
	.string	"wav"
	.align 2
.LC29:
	.string	"pcx"
	.section	".text"
	.align 2
	.globl PrecacheItem
	.type	 PrecacheItem,@function
PrecacheItem:
	stwu 1,-112(1)
	mflr 0
	stmw 24,80(1)
	stw 0,116(1)
	mr. 26,3
	bc 12,2,.L214
	lwz 3,20(26)
	cmpwi 0,3,0
	bc 12,2,.L216
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L216:
	lwz 3,24(26)
	cmpwi 0,3,0
	bc 12,2,.L217
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L217:
	lwz 3,32(26)
	cmpwi 0,3,0
	bc 12,2,.L218
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L218:
	lwz 3,36(26)
	cmpwi 0,3,0
	bc 12,2,.L219
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
.L219:
	lwz 29,52(26)
	cmpwi 0,29,0
	bc 12,2,.L220
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L220
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L228
	mr 28,9
.L223:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L225
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L225
	mr 3,31
	b .L227
.L225:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L223
.L228:
	li 3,0
.L227:
	cmpw 0,3,26
	bc 12,2,.L220
	bl PrecacheItem
.L220:
	lwz 30,72(26)
	cmpwi 0,30,0
	bc 12,2,.L214
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 12,2,.L214
	lis 9,gi@ha
	addi 29,1,8
	la 27,gi@l(9)
	lis 24,.LC26@ha
	lis 25,.LC29@ha
.L234:
	rlwinm 9,0,0,0xff
	mr 31,30
	b .L248
.L237:
	lbzu 9,1(30)
.L248:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L237
	subf 28,31,30
	addi 0,28,-5
	cmplwi 0,0,58
	bc 4,1,.L239
	lwz 9,28(27)
	lis 3,.LC25@ha
	la 3,.LC25@l(3)
	lwz 4,0(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L239:
	mr 4,31
	mr 5,28
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 0,0
	addi 11,30,1
	stbx 0,29,28
	add 9,29,28
	la 4,.LC26@l(24)
	lbz 0,0(30)
	addi 31,9,-3
	mr 3,31
	addic 0,0,-1
	subfe 0,0,0
	andc 11,11,0
	and 0,30,0
	or 30,0,11
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L249
	lis 4,.LC27@ha
	mr 3,31
	la 4,.LC27@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L243
.L249:
	lwz 9,32(27)
	mr 3,29
	mtlr 9
	blrl
	b .L242
.L243:
	lis 4,.LC28@ha
	mr 3,31
	la 4,.LC28@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L242
	lwz 9,36(27)
	mr 3,29
	mtlr 9
	blrl
.L242:
	add 3,29,28
	la 4,.LC29@l(25)
	addi 3,3,-3
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L232
	lwz 9,40(27)
	mr 3,29
	mtlr 9
	blrl
.L232:
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L234
.L214:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe10:
	.size	 PrecacheItem,.Lfe10-PrecacheItem
	.section	".rodata"
	.align 2
.LC30:
	.long 0x0
	.section	".text"
	.align 2
	.globl setup_item_table
	.type	 setup_item_table,@function
setup_item_table:
	stwu 1,-64(1)
	mflr 0
	stmw 19,12(1)
	stw 0,68(1)
	lis 9,.LC30@ha
	lis 11,deathmatch@ha
	la 9,.LC30@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L250
	lis 9,num_items@ha
	li 30,0
	lwz 0,num_items@l(9)
	lis 19,num_items@ha
	cmpw 0,30,0
	bc 4,0,.L250
	lis 9,item_table@ha
	lis 11,game@ha
	la 27,item_table@l(9)
	la 20,game@l(11)
	addi 21,27,8
	lis 24,node_count@ha
	lis 22,itemlist@ha
	lis 23,game@ha
.L255:
	mulli 29,30,12
	lhz 4,node_count@l(24)
	li 31,0
	addi 25,30,1
	la 28,itemlist@l(22)
	add 9,29,27
	mr 26,29
	sth 4,4(9)
	lwzx 3,27,29
	rlwinm 4,4,0,0xffff
	bl add_node_to_list
	lwz 0,1556(20)
	lhz 9,node_count@l(24)
	lwzx 11,27,29
	cmpw 0,31,0
	addi 9,9,1
	lwz 30,280(11)
	sth 9,node_count@l(24)
	bc 4,0,.L263
	la 29,game@l(23)
.L258:
	lwz 3,0(28)
	cmpwi 0,3,0
	bc 12,2,.L260
	mr 4,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L260
	mr 9,31
	b .L262
.L260:
	lwz 0,1556(29)
	addi 31,31,1
	addi 28,28,76
	cmpw 0,31,0
	bc 12,0,.L258
.L263:
	li 9,0
.L262:
	lwz 0,num_items@l(19)
	mr 30,25
	stwx 9,21,26
	cmpw 0,30,0
	bc 12,0,.L255
.L250:
	lwz 0,68(1)
	mtlr 0
	lmw 19,12(1)
	la 1,64(1)
	blr
.Lfe11:
	.size	 setup_item_table,.Lfe11-setup_item_table
	.section	".rodata"
	.align 2
.LC31:
	.string	"%s at %s has invalid spawnflags set\n"
	.align 2
.LC32:
	.string	"weapon_bfg"
	.align 2
.LC33:
	.string	"item_flag_team1"
	.align 2
.LC34:
	.string	"item_flag_team2"
	.align 3
.LC35:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC36:
	.long 0x0
	.section	".text"
	.align 2
	.globl SpawnItem
	.type	 SpawnItem,@function
SpawnItem:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	mr 3,30
	bl PrecacheItem
	lwz 0,284(31)
	cmpwi 0,0,0
	bc 12,2,.L266
	lwz 3,280(31)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L266
	li 0,0
	lis 29,gi@ha
	lwz 28,280(31)
	la 29,gi@l(29)
	stw 0,284(31)
	addi 3,31,4
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC31@ha
	la 3,.LC31@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L266:
	lis 9,.LC36@ha
	lis 11,deathmatch@ha
	la 9,.LC36@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L268
	lwz 0,0(30)
	cmpwi 0,0,0
	bc 12,2,.L269
	lis 10,num_items@ha
	lis 11,item_table@ha
	lwz 9,num_items@l(10)
	la 11,item_table@l(11)
	mulli 0,9,12
	addi 9,9,1
	stw 9,num_items@l(10)
	stwx 31,11,0
.L269:
	lwz 0,4(30)
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	mr 8,0
	bc 12,2,.L284
	lis 9,Pickup_PowerArmor@ha
	la 9,Pickup_PowerArmor@l(9)
	cmpw 0,8,9
	bc 12,2,.L284
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 12,2,.L272
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,8,9
	bc 12,2,.L284
.L272:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 12,2,.L274
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,8,9
	bc 12,2,.L284
	lis 9,Pickup_Adrenaline@ha
	la 9,Pickup_Adrenaline@l(9)
	cmpw 0,8,9
	bc 12,2,.L284
	lis 9,Pickup_AncientHead@ha
	la 9,Pickup_AncientHead@l(9)
	cmpw 0,8,9
	bc 12,2,.L284
.L274:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8192
	bc 12,2,.L268
	lwz 0,56(30)
	cmpwi 0,0,2
	bc 12,2,.L284
	lwz 3,280(31)
	lis 4,.LC32@ha
	la 4,.LC32@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L284
.L268:
	lis 10,saberonly@ha
	lwz 9,saberonly@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	cmpwi 0,11,0
	bc 4,2,.L284
	lis 9,.LC36@ha
	lis 11,coop@ha
	la 9,.LC36@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L281
	lwz 3,280(31)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L281
	lis 10,level@ha
	lwz 11,284(31)
	li 0,1
	la 10,level@l(10)
	lwz 9,300(10)
	addi 9,9,8
	slw 0,0,9
	or 11,11,0
	stw 11,284(31)
	lwz 9,300(10)
	addi 9,9,1
	stw 9,300(10)
.L281:
	lis 9,.LC36@ha
	lis 11,coop@ha
	la 9,.LC36@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L282
	lwz 0,56(30)
	andi. 9,0,8
	bc 12,2,.L282
	li 0,0
	stw 0,12(30)
.L282:
	lis 9,.LC36@ha
	lis 11,ctf@ha
	la 9,.LC36@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L283
	lwz 3,280(31)
	lis 4,.LC33@ha
	la 4,.LC33@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L284
	lwz 3,280(31)
	lis 4,.LC34@ha
	la 4,.LC34@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L283
.L284:
	mr 3,31
	bl G_FreeEdict
	b .L265
.L283:
	stw 30,648(31)
	lis 11,level+4@ha
	lis 10,.LC35@ha
	lfs 0,level+4@l(11)
	lis 9,droptofloor@ha
	lfd 13,.LC35@l(10)
	la 9,droptofloor@l(9)
	li 11,512
	lwz 3,268(31)
	stw 9,436(31)
	cmpwi 0,3,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,28(30)
	stw 11,68(31)
	stw 0,64(31)
	bc 12,2,.L285
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L285:
	lwz 3,280(31)
	lis 4,.LC33@ha
	la 4,.LC33@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L287
	lwz 3,280(31)
	lis 4,.LC34@ha
	la 4,.LC34@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L265
.L287:
	lis 9,CTFFlagSetup@ha
	la 9,CTFFlagSetup@l(9)
	stw 9,436(31)
.L265:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 SpawnItem,.Lfe12-SpawnItem
	.globl itemlist
	.section	".data"
	.align 2
	.type	 itemlist,@object
itemlist:
	.long 0
	.space	72
	.long .LC37
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Blaster
	.long .LC38
	.long .LC39
	.long 0
	.long .LC40
	.long .LC41
	.long .LC42
	.long 0
	.long 1
	.long .LC43
	.long 9
	.long 1
	.long 0
	.long 0
	.long .LC44
	.long .LC45
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Rifle
	.long .LC38
	.long .LC46
	.long 0
	.long .LC47
	.long .LC48
	.long .LC49
	.long 0
	.long 1
	.long .LC50
	.long 9
	.long 2
	.long 0
	.long 0
	.long .LC51
	.long .LC52
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Repeater
	.long .LC38
	.long .LC53
	.long 0
	.long .LC54
	.long .LC55
	.long .LC56
	.long 0
	.long 1
	.long .LC57
	.long 9
	.long 3
	.long 0
	.long 0
	.long .LC58
	.long .LC59
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Bowcaster
	.long .LC38
	.long .LC60
	.long 0
	.long .LC61
	.long .LC62
	.long .LC63
	.long 0
	.long 1
	.long .LC64
	.long 9
	.long 4
	.long 0
	.long 0
	.long .LC65
	.long .LC66
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_WristRocket
	.long .LC38
	.long .LC67
	.long 0
	.long .LC68
	.long .LC69
	.long .LC70
	.long 0
	.long 1
	.long .LC71
	.long 9
	.long 5
	.long 0
	.long 0
	.long .LC72
	.long .LC73
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_MissileTube
	.long .LC38
	.long .LC74
	.long 0
	.long .LC75
	.long .LC76
	.long .LC77
	.long 0
	.long 1
	.long .LC78
	.long 9
	.long 6
	.long 0
	.long 0
	.long .LC79
	.long .LC80
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Disruptor
	.long .LC38
	.long .LC81
	.long 0
	.long .LC82
	.long .LC83
	.long .LC84
	.long 0
	.long 1
	.long .LC85
	.long 9
	.long 7
	.long 0
	.long 0
	.long .LC86
	.long .LC87
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Sniper
	.long .LC38
	.long .LC88
	.long 0
	.long .LC89
	.long .LC90
	.long .LC91
	.long 0
	.long 1
	.long .LC92
	.long 9
	.long 8
	.long 0
	.long 0
	.long .LC93
	.long .LC94
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_BeamTube
	.long .LC38
	.long .LC95
	.long 0
	.long .LC96
	.long .LC97
	.long .LC98
	.long 0
	.long 1
	.long .LC99
	.long 9
	.long 9
	.long 0
	.long 0
	.long .LC100
	.long .LC101
	.long Pickup_Ammo
	.long Use_Weapon
	.long Drop_Ammo
	.long Weapon_Thermal
	.long .LC102
	.long .LC103
	.long 0
	.long .LC104
	.long .LC105
	.long .LC106
	.long 3
	.long 4
	.long .LC106
	.long 3
	.long 10
	.long 0
	.long 9
	.long .LC107
	.long .LC108
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Hands
	.long .LC38
	.long 0
	.long 0
	.long 0
	.long .LC109
	.long .LC110
	.long 0
	.long 0
	.long 0
	.long 0
	.long 11
	.long 0
	.long 0
	.long .LC111
	.long .LC112
	.long Pickup_Weapon
	.long Use_Weapon
	.long 0
	.long Weapon_Saber
	.long .LC38
	.long .LC113
	.long 1
	.long .LC114
	.long .LC115
	.long .LC116
	.long 0
	.long 0
	.long 0
	.long 9
	.long 12
	.long 0
	.long 0
	.long .LC117
	.long .LC118
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC102
	.long .LC119
	.long 0
	.long 0
	.long .LC120
	.long .LC121
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC111
	.long .LC122
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC102
	.long .LC123
	.long 0
	.long 0
	.long .LC124
	.long .LC43
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 1
	.long .LC111
	.long .LC125
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC102
	.long .LC126
	.long 0
	.long 0
	.long .LC127
	.long .LC50
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 2
	.long .LC111
	.long .LC128
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC102
	.long .LC129
	.long 0
	.long 0
	.long .LC127
	.long .LC57
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 3
	.long .LC111
	.long .LC130
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC102
	.long .LC131
	.long 0
	.long 0
	.long .LC132
	.long .LC85
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 4
	.long .LC111
	.long .LC133
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC102
	.long .LC134
	.long 0
	.long 0
	.long .LC135
	.long .LC64
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 5
	.long .LC111
	.long .LC136
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC102
	.long .LC137
	.long 0
	.long 0
	.long .LC138
	.long .LC139
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 6
	.long .LC111
	.long .LC140
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC102
	.long .LC141
	.long 0
	.long 0
	.long .LC142
	.long .LC71
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 7
	.long .LC111
	.long .LC143
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC102
	.long .LC103
	.long 0
	.long 0
	.long .LC105
	.long .LC144
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 8
	.long .LC111
	.long .LC145
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC102
	.long .LC146
	.long 0
	.long 0
	.long .LC147
	.long .LC99
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 10
	.long .LC111
	.long .LC148
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC102
	.long .LC149
	.long 0
	.long 0
	.long .LC150
	.long .LC92
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 11
	.long .LC111
	.long .LC151
	.long Pickup_Powerup
	.long Use_MediKit
	.long Drop_General
	.long 0
	.long .LC152
	.long .LC153
	.long 0
	.long 0
	.long .LC154
	.long .LC155
	.long 2
	.long 1
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC111
	.long .LC156
	.long Pickup_Powerup
	.long Use_GlowLamp
	.long Drop_General
	.long 0
	.long .LC152
	.long .LC157
	.long 0
	.long 0
	.long .LC154
	.long .LC158
	.long 2
	.long 1
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC111
	.long .LC159
	.long Pickup_Powerup
	.long Use_Breather
	.long Drop_General
	.long 0
	.long .LC152
	.long .LC157
	.long 0
	.long 0
	.long .LC154
	.long .LC160
	.long 2
	.long 3
	.long 0
	.long 40
	.long 0
	.long 0
	.long 0
	.long .LC161
	.long .LC162
	.long Pickup_Powerup
	.long Use_SaberCrystal
	.long 0
	.long 0
	.long .LC152
	.long 0
	.long 0
	.long 0
	.long .LC154
	.long .LC163
	.long 2
	.long 3
	.long 0
	.long 40
	.long 0
	.long 0
	.long 38
	.long .LC111
	.long .LC164
	.long Pickup_Powerup
	.long Use_SaberCrystal
	.long 0
	.long 0
	.long .LC152
	.long 0
	.long 0
	.long 0
	.long .LC154
	.long .LC165
	.long 2
	.long 3
	.long 0
	.long 40
	.long 0
	.long 0
	.long 37
	.long .LC111
	.long .LC166
	.long Pickup_Powerup
	.long Use_SaberCrystal
	.long 0
	.long 0
	.long .LC152
	.long 0
	.long 0
	.long 0
	.long .LC154
	.long .LC167
	.long 2
	.long 3
	.long 0
	.long 40
	.long 0
	.long 0
	.long 36
	.long .LC111
	.long .LC168
	.long Pickup_Powerup
	.long Use_SaberCrystal
	.long 0
	.long 0
	.long .LC152
	.long 0
	.long 0
	.long 0
	.long .LC154
	.long .LC169
	.long 2
	.long 3
	.long 0
	.long 40
	.long 0
	.long 0
	.long 39
	.long .LC111
	.long .LC170
	.long Pickup_AncientHead
	.long 0
	.long 0
	.long 0
	.long .LC152
	.long .LC171
	.long 1
	.long 0
	.long .LC172
	.long .LC173
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC111
	.long .LC174
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC152
	.long .LC175
	.long 1
	.long 0
	.long .LC176
	.long .LC177
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC111
	.long .LC5
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC152
	.long .LC178
	.long 1
	.long 0
	.long .LC179
	.long .LC180
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC111
	.long .LC181
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC152
	.long .LC182
	.long 1
	.long 0
	.long .LC183
	.long .LC184
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC111
	.long .LC185
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC152
	.long .LC186
	.long 1
	.long 0
	.long .LC187
	.long .LC188
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC111
	.long .LC189
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC152
	.long .LC190
	.long 1
	.long 0
	.long .LC191
	.long .LC192
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC111
	.long .LC193
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC152
	.long .LC194
	.long 1
	.long 0
	.long .LC195
	.long .LC196
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC111
	.long .LC197
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC152
	.long .LC198
	.long 1
	.long 0
	.long .LC199
	.long .LC200
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC111
	.long .LC201
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC152
	.long .LC202
	.long 2
	.long 0
	.long .LC203
	.long .LC204
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC111
	.long .LC205
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC152
	.long .LC206
	.long 1
	.long 0
	.long .LC207
	.long .LC208
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC111
	.long 0
	.long Pickup_Health
	.long 0
	.long 0
	.long 0
	.long .LC152
	.long 0
	.long 0
	.long 0
	.long .LC209
	.long .LC210
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC211
	.long .LC212
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC213
	.long .LC214
	.long 1
	.long 0
	.long .LC215
	.long .LC216
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long bodyarmor_info
	.long 3
	.long .LC111
	.long .LC217
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC213
	.long .LC218
	.long 1
	.long 0
	.long .LC219
	.long .LC220
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long combatarmor_info
	.long 2
	.long .LC111
	.long .LC221
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC213
	.long .LC222
	.long 1
	.long 0
	.long .LC223
	.long .LC224
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long jacketarmor_info
	.long 1
	.long .LC111
	.long .LC225
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC226
	.long .LC227
	.long 1
	.long 0
	.long .LC223
	.long .LC228
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long 0
	.long 4
	.long .LC111
	.long .LC33
	.long CTFPickup_Flag
	.long 0
	.long CTFDrop_Flag
	.long 0
	.long .LC229
	.long .LC230
	.long 262144
	.long 0
	.long .LC231
	.long .LC232
	.long 2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC233
	.long .LC34
	.long CTFPickup_Flag
	.long 0
	.long CTFDrop_Flag
	.long 0
	.long .LC229
	.long .LC234
	.long 524288
	.long 0
	.long .LC235
	.long .LC236
	.long 2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC233
	.long .LC237
	.long CTFPickup_Tech
	.long 0
	.long CTFDrop_Tech
	.long 0
	.long .LC152
	.long .LC238
	.long 1
	.long 0
	.long .LC239
	.long .LC240
	.long 2
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC241
	.long .LC242
	.long CTFPickup_Tech
	.long 0
	.long CTFDrop_Tech
	.long 0
	.long .LC152
	.long .LC243
	.long 1
	.long 0
	.long .LC244
	.long .LC245
	.long 2
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC246
	.long .LC247
	.long CTFPickup_Tech
	.long 0
	.long CTFDrop_Tech
	.long 0
	.long .LC152
	.long .LC248
	.long 1
	.long 0
	.long .LC249
	.long .LC250
	.long 2
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC251
	.long .LC252
	.long CTFPickup_Tech
	.long 0
	.long CTFDrop_Tech
	.long 0
	.long .LC152
	.long .LC253
	.long 1
	.long 0
	.long .LC254
	.long .LC255
	.long 2
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC256
	.long 0
	.space	72
	.section	".rodata"
	.align 2
.LC256:
	.string	"ctf/tech4.wav"
	.align 2
.LC255:
	.string	"AutoDoc"
	.align 2
.LC254:
	.string	"tech4"
	.align 2
.LC253:
	.string	"models/ctf/regeneration/tris.md2"
	.align 2
.LC252:
	.string	"item_tech4"
	.align 2
.LC251:
	.string	"ctf/tech3.wav"
	.align 2
.LC250:
	.string	"Time Accel"
	.align 2
.LC249:
	.string	"tech3"
	.align 2
.LC248:
	.string	"models/ctf/haste/tris.md2"
	.align 2
.LC247:
	.string	"item_tech3"
	.align 2
.LC246:
	.string	"ctf/tech2.wav ctf/tech2x.wav"
	.align 2
.LC245:
	.string	"Power Amplifier"
	.align 2
.LC244:
	.string	"tech2"
	.align 2
.LC243:
	.string	"models/ctf/strength/tris.md2"
	.align 2
.LC242:
	.string	"item_tech2"
	.align 2
.LC241:
	.string	"ctf/tech1.wav"
	.align 2
.LC240:
	.string	"Disruptor Shield"
	.align 2
.LC239:
	.string	"tech1"
	.align 2
.LC238:
	.string	"models/ctf/resistance/tris.md2"
	.align 2
.LC237:
	.string	"item_tech1"
	.align 2
.LC236:
	.string	"Blue Flag"
	.align 2
.LC235:
	.string	"i_ctf2"
	.align 2
.LC234:
	.string	"models/objects/ewok/ewok.md2"
	.align 2
.LC233:
	.string	"ctf/flagcap.wav"
	.align 2
.LC232:
	.string	"Red Flag"
	.align 2
.LC231:
	.string	"i_ctf1"
	.align 2
.LC230:
	.string	"models/objects/jawa/jawa.md2"
	.align 2
.LC229:
	.string	"ctf/flagtk.wav"
	.align 2
.LC228:
	.string	"Armor Shard"
	.align 2
.LC227:
	.string	"models/items/armor/shard/tris.md2"
	.align 2
.LC226:
	.string	"misc/ar2_pkup.wav"
	.align 2
.LC225:
	.string	"item_armor_shard"
	.align 2
.LC224:
	.string	"Jacket Armor"
	.align 2
.LC223:
	.string	"i_jacketarmor"
	.align 2
.LC222:
	.string	"models/items/armor/jacket/tris.md2"
	.align 2
.LC221:
	.string	"item_armor_jacket"
	.align 2
.LC220:
	.string	"Combat Armor"
	.align 2
.LC219:
	.string	"i_combatarmor"
	.align 2
.LC218:
	.string	"models/items/armor/combat/tris.md2"
	.align 2
.LC217:
	.string	"item_armor_combat"
	.align 2
.LC216:
	.string	"Body Armor"
	.align 2
.LC215:
	.string	"i_bodyarmor"
	.align 2
.LC214:
	.string	"models/items/armor/body/tris.md2"
	.align 2
.LC213:
	.string	"misc/ar1_pkup.wav"
	.align 2
.LC212:
	.string	"item_armor_body"
	.align 2
.LC211:
	.string	"items/s_health.wav items/n_health.wav items/l_health.wav items/m_health.wav"
	.align 2
.LC210:
	.string	"Health"
	.align 2
.LC209:
	.string	"i_health"
	.align 2
.LC208:
	.string	"Airstrike Marker"
	.align 2
.LC207:
	.string	"i_airstrike"
	.align 2
.LC206:
	.string	"models/items/keys/target/tris.md2"
	.align 2
.LC205:
	.string	"key_airstrike_target"
	.align 2
.LC204:
	.string	"Commander's Head"
	.align 2
.LC203:
	.string	"k_comhead"
	.align 2
.LC202:
	.string	"models/monsters/commandr/head/tris.md2"
	.align 2
.LC201:
	.string	"key_commander_head"
	.align 2
.LC200:
	.string	"Red Key"
	.align 2
.LC199:
	.string	"k_redkey"
	.align 2
.LC198:
	.string	"models/items/keys/red_key/tris.md2"
	.align 2
.LC197:
	.string	"key_red_key"
	.align 2
.LC196:
	.string	"Blue Key"
	.align 2
.LC195:
	.string	"k_bluekey"
	.align 2
.LC194:
	.string	"models/items/keys/key/tris.md2"
	.align 2
.LC193:
	.string	"key_blue_key"
	.align 2
.LC192:
	.string	"Security Pass"
	.align 2
.LC191:
	.string	"k_security"
	.align 2
.LC190:
	.string	"models/items/keys/pass/tris.md2"
	.align 2
.LC189:
	.string	"key_pass"
	.align 2
.LC188:
	.string	"Data Spinner"
	.align 2
.LC187:
	.string	"k_dataspin"
	.align 2
.LC186:
	.string	"models/items/keys/spinner/tris.md2"
	.align 2
.LC185:
	.string	"key_data_spinner"
	.align 2
.LC184:
	.string	"Pyramid Key"
	.align 2
.LC183:
	.string	"k_pyramid"
	.align 2
.LC182:
	.string	"models/items/keys/pyramid/tris.md2"
	.align 2
.LC181:
	.string	"key_pyramid"
	.align 2
.LC180:
	.string	"Power Cube"
	.align 2
.LC179:
	.string	"k_powercube"
	.align 2
.LC178:
	.string	"models/items/keys/power/tris.md2"
	.align 2
.LC177:
	.string	"Data CD"
	.align 2
.LC176:
	.string	"k_datacd"
	.align 2
.LC175:
	.string	"models/items/keys/data_cd/tris.md2"
	.align 2
.LC174:
	.string	"key_data_cd"
	.align 2
.LC173:
	.string	"Ancient Head"
	.align 2
.LC172:
	.string	"i_fixme"
	.align 2
.LC171:
	.string	"models/items/c_head/tris.md2"
	.align 2
.LC170:
	.string	"item_ancient_head"
	.align 2
.LC169:
	.string	"Green Crystal"
	.align 2
.LC168:
	.string	"item_greencrystal"
	.align 2
.LC167:
	.string	"Red Crystal"
	.align 2
.LC166:
	.string	"item_redcrystal"
	.align 2
.LC165:
	.string	"Yellow Crystal"
	.align 2
.LC164:
	.string	"item_yellowcrystal"
	.align 2
.LC163:
	.string	"Blue Crystal"
	.align 2
.LC162:
	.string	"item_bluecrystal"
	.align 2
.LC161:
	.string	"items/airout.wav"
	.align 2
.LC160:
	.string	"Gill"
	.align 2
.LC159:
	.string	"item_gill"
	.align 2
.LC158:
	.string	"GlowLamp"
	.align 2
.LC157:
	.string	"models/items/breather/tris.md2"
	.align 2
.LC156:
	.string	"item_glowlamp"
	.align 2
.LC155:
	.string	"MediKit"
	.align 2
.LC154:
	.string	"p_rebreather"
	.align 2
.LC153:
	.string	"models/items/healing/medium/tris.md2"
	.align 2
.LC152:
	.string	"items/pkup.wav"
	.align 2
.LC151:
	.string	"item_medikit"
	.align 2
.LC150:
	.string	"a_nightstinger"
	.align 2
.LC149:
	.string	"models/items/ammo/snipclip/tris.md2"
	.align 2
.LC148:
	.string	"ammo_sniper"
	.align 2
.LC147:
	.string	"a_beampack"
	.align 2
.LC146:
	.string	"models/items/ammo/beamclip/tris.md2"
	.align 2
.LC145:
	.string	"ammo_bpack"
	.align 2
.LC144:
	.string	"Detonators"
	.align 2
.LC143:
	.string	"ammo_dets"
	.align 2
.LC142:
	.string	"a_rockets1"
	.align 2
.LC141:
	.string	"models/items/ammo/wrocket/tris.md2"
	.align 2
.LC140:
	.string	"ammo_bmiss"
	.align 2
.LC139:
	.string	"concussion missiles"
	.align 2
.LC138:
	.string	"a_rockets2"
	.align 2
.LC137:
	.string	"models/items/ammo/rockets/tris.md2"
	.align 2
.LC136:
	.string	"ammo_cmiss"
	.align 2
.LC135:
	.string	"a_arrows"
	.align 2
.LC134:
	.string	"models/items/ammo/arrows/tris.md2"
	.align 2
.LC133:
	.string	"ammo_bolts"
	.align 2
.LC132:
	.string	"a_disruptor"
	.align 2
.LC131:
	.string	"models/items/ammo/discharg/tris.md2"
	.align 2
.LC130:
	.string	"ammo_dis"
	.align 2
.LC129:
	.string	"models/items/ammo/rapclip/tris.md2"
	.align 2
.LC128:
	.string	"ammo_t21"
	.align 2
.LC127:
	.string	"a_cells"
	.align 2
.LC126:
	.string	"models/items/ammo/riflclip/tris.md2"
	.align 2
.LC125:
	.string	"ammo_e11"
	.align 2
.LC124:
	.string	"a_blaster"
	.align 2
.LC123:
	.string	"models/items/ammo/pistclip/tris.md2"
	.align 2
.LC122:
	.string	"ammo_dl44"
	.align 2
.LC121:
	.string	"Nothing"
	.align 2
.LC120:
	.string	"a_shells"
	.align 2
.LC119:
	.string	"models/items/ammo/shells/medium/tris.md2"
	.align 2
.LC118:
	.string	"ammo_nothing"
	.align 2
.LC117:
	.string	"weapons/sabre/idle.wav weapons/sabre/on.wav weapons/sabre/off.wav weapons/sabre/strike1.wav weapons/sabre/strike2.wav weapons/sabre/swing1.wav weapons/sabre/swing2.wav weapons/sabre/swing3.wav weapons/sabre/swing4.wav"
	.align 2
.LC116:
	.string	"Lightsaber"
	.align 2
.LC115:
	.string	"w_sabr"
	.align 2
.LC114:
	.string	"models/weapons/v_saber/tris.md2"
	.align 2
.LC113:
	.string	"models/weapons/g_bfg/tris.md2"
	.align 2
.LC112:
	.string	"weapon_saber"
	.align 2
.LC111:
	.string	""
	.align 2
.LC110:
	.string	"Hands"
	.align 2
.LC109:
	.string	"w_blast"
	.align 2
.LC108:
	.string	"weapon_hands"
	.align 2
.LC107:
	.string	"weapons/td/activate.wav weapons/td/throw.wav weapons/td/tick.wav"
	.align 2
.LC106:
	.string	"Thermals"
	.align 2
.LC105:
	.string	"a_thermal"
	.align 2
.LC104:
	.string	"models/weapons/v_thdet/tris.md2"
	.align 2
.LC103:
	.string	"models/items/ammo/dets/tris.md2"
	.align 2
.LC102:
	.string	"misc/am_pkup.wav"
	.align 2
.LC101:
	.string	"ammo_thermal"
	.align 2
.LC100:
	.string	"weapons/beam/fire.wav"
	.align 2
.LC99:
	.string	"BeamPack"
	.align 2
.LC98:
	.string	"Beam_Tube"
	.align 2
.LC97:
	.string	"w_beam"
	.align 2
.LC96:
	.string	"models/weapons/v_beam/tris.md2"
	.align 2
.LC95:
	.string	"models/weapons/g_beam/tris.md2"
	.align 2
.LC94:
	.string	"weapon_beamtube"
	.align 2
.LC93:
	.string	"weapons/sniper/fire.wav"
	.align 2
.LC92:
	.string	"Sniper Ammo"
	.align 2
.LC91:
	.string	"Night_Stinger"
	.align 2
.LC90:
	.string	"w_nstg"
	.align 2
.LC89:
	.string	"models/weapons/v_sniper/tris.md2"
	.align 2
.LC88:
	.string	"models/weapons/g_sniper/tris.md2"
	.align 2
.LC87:
	.string	"weapon_sniper"
	.align 2
.LC86:
	.string	"weapons/disrupt/fire.wav"
	.align 2
.LC85:
	.string	"Disruptor clip"
	.align 2
.LC84:
	.string	"Disruptor"
	.align 2
.LC83:
	.string	"w_dis"
	.align 2
.LC82:
	.string	"models/weapons/v_biggun/tris.md2"
	.align 2
.LC81:
	.string	"models/weapons/g_biggun/tris.md2"
	.align 2
.LC80:
	.string	"weapon_disruptor"
	.align 2
.LC79:
	.string	"weapons/mtube/fire.wav"
	.align 2
.LC78:
	.string	"Concussion missiles"
	.align 2
.LC77:
	.string	"Rocket_Launcher"
	.align 2
.LC76:
	.string	"w_mtube"
	.align 2
.LC75:
	.string	"models/weapons/v_lgrckt/tris.md2"
	.align 2
.LC74:
	.string	"models/weapons/g_lgrckt/tris.md2"
	.align 2
.LC73:
	.string	"weapon_missiletube"
	.align 2
.LC72:
	.string	"weapons/wrocket/fire.wav"
	.align 2
.LC71:
	.string	"Dumb Fire missiles"
	.align 2
.LC70:
	.string	"Wrist_Rocket"
	.align 2
.LC69:
	.string	"w_wrstrkt"
	.align 2
.LC68:
	.string	"models/weapons/v_wrstrkt/tris.md2"
	.align 2
.LC67:
	.string	"models/weapons/g_wrstrkt/tris.md2"
	.align 2
.LC66:
	.string	"weapon_wristrocket"
	.align 2
.LC65:
	.string	"weapons/arrow/fire.wav"
	.align 2
.LC64:
	.string	"Bolts"
	.align 2
.LC63:
	.string	"Bowcaster"
	.align 2
.LC62:
	.string	"w_arrw"
	.align 2
.LC61:
	.string	"models/weapons/v_arrow/tris.md2"
	.align 2
.LC60:
	.string	"models/weapons/g_arrow/tris.md2"
	.align 2
.LC59:
	.string	"weapon_bowcaster"
	.align 2
.LC58:
	.string	"weapons/rapid/fire.wav"
	.align 2
.LC57:
	.string	"T21 clip"
	.align 2
.LC56:
	.string	"Repeater"
	.align 2
.LC55:
	.string	"w_rapid"
	.align 2
.LC54:
	.string	"models/weapons/v_rapid/tris.md2"
	.align 2
.LC53:
	.string	"models/weapons/g_rapid/tris.md2"
	.align 2
.LC52:
	.string	"weapon_repeater"
	.align 2
.LC51:
	.string	"weapons/rifle/fire.wav"
	.align 2
.LC50:
	.string	"E11 clip"
	.align 2
.LC49:
	.string	"Trooper_Rifle"
	.align 2
.LC48:
	.string	"w_trpr"
	.align 2
.LC47:
	.string	"models/weapons/v_trpr/tris.md2"
	.align 2
.LC46:
	.string	"models/weapons/g_trpr/tris.md2"
	.align 2
.LC45:
	.string	"weapon_blasterrifle"
	.align 2
.LC44:
	.string	"weapons/pistol/fire.wav"
	.align 2
.LC43:
	.string	"DL44 clip"
	.align 2
.LC42:
	.string	"Blaster"
	.align 2
.LC41:
	.string	"w_pist"
	.align 2
.LC40:
	.string	"models/weapons/v_pistol/tris.md2"
	.align 2
.LC39:
	.string	"models/weapons/g_pistol/tris.md2"
	.align 2
.LC38:
	.string	"misc/w_pkup.wav"
	.align 2
.LC37:
	.string	"weapon_blasterpistol"
	.size	 itemlist,4028
	.comm	node_count,2,2
	.comm	path_not_time_yet,4,4
	.section	".sbss","aw",@nobits
	.align 2
jacket_armor_index:
	.space	4
	.size	 jacket_armor_index,4
	.align 2
combat_armor_index:
	.space	4
	.size	 combat_armor_index,4
	.align 2
body_armor_index:
	.space	4
	.size	 body_armor_index,4
	.comm	conversation_content,7760,4
	.comm	highlighted,4,4
	.comm	yeah_you,4,4
	.comm	its_me,4,4
	.comm	holdthephone,4,4
	.comm	NoTouch,4,4
	.comm	showingit,4,4
	.comm	path_time,4,4
	.comm	print_time,4,4
	.comm	item_table,12288,4
	.section	".rodata"
	.align 2
.LC257:
	.long 0x46fffe00
	.align 3
.LC258:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC259:
	.long 0x43480000
	.align 2
.LC260:
	.long 0x42c80000
	.align 2
.LC261:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl SpawnEmptyClip
	.type	 SpawnEmptyClip,@function
SpawnEmptyClip:
	stwu 1,-96(1)
	mflr 0
	stfd 28,64(1)
	stfd 29,72(1)
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 25,36(1)
	stw 0,100(1)
	mr 27,4
	mr 28,3
	bl G_Spawn
	lis 25,0x4330
	lis 26,gi@ha
	lis 8,.LC258@ha
	la 26,gi@l(26)
	mr 29,3
	lwz 11,32(26)
	la 8,.LC258@l(8)
	mr 3,27
	lfd 30,0(8)
	lis 9,.LC259@ha
	mtlr 11
	lis 8,.LC260@ha
	la 9,.LC259@l(9)
	la 8,.LC260@l(8)
	lfs 28,0(9)
	lfs 29,0(8)
	blrl
	li 10,7
	li 9,0
	stw 3,40(29)
	li 11,10
	stw 10,260(29)
	lis 0,0x41f0
	stw 9,248(29)
	stw 11,400(29)
	lfs 0,4(28)
	stfs 0,4(29)
	lfs 13,8(28)
	stfs 13,8(29)
	lfs 0,12(28)
	stw 0,396(29)
	stw 0,388(29)
	stw 0,392(29)
	stfs 0,12(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC257@ha
	stw 3,28(1)
	stw 25,24(1)
	lfd 0,24(1)
	lfs 31,.LC257@l(11)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,31
	fmsubs 0,0,28,29
	stfs 0,376(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,G_FreeEdict@ha
	stw 3,28(1)
	lis 0,0x4396
	la 11,G_FreeEdict@l(11)
	stw 25,24(1)
	lis 8,.LC261@ha
	lis 10,level+4@ha
	lfd 0,24(1)
	la 8,.LC261@l(8)
	mr 3,29
	stw 0,384(29)
	stw 11,436(29)
	fsub 0,0,30
	lfs 12,0(8)
	frsp 0,0
	fdivs 0,0,31
	fmsubs 0,0,28,29
	stfs 0,380(29)
	lfs 13,level+4@l(10)
	fadds 13,13,12
	stfs 13,428(29)
	lwz 0,72(26)
	mtlr 0
	blrl
	lwz 0,100(1)
	mtlr 0
	lmw 25,36(1)
	lfd 28,64(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe13:
	.size	 SpawnEmptyClip,.Lfe13-SpawnEmptyClip
	.align 2
	.globl GetItemByIndex
	.type	 GetItemByIndex,@function
GetItemByIndex:
	mr. 3,3
	bc 12,2,.L9
	lis 9,game+1556@ha
	lwz 0,game+1556@l(9)
	cmpw 0,3,0
	bc 12,0,.L8
.L9:
	li 3,0
	blr
.L8:
	mulli 0,3,76
	lis 3,itemlist@ha
	la 3,itemlist@l(3)
	add 3,0,3
	blr
.Lfe14:
	.size	 GetItemByIndex,.Lfe14-GetItemByIndex
	.align 2
	.globl FindItemByClassname
	.type	 FindItemByClassname,@function
FindItemByClassname:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	mr 29,3
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L12
	mr 28,9
.L14:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L13
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L13
	mr 3,31
	b .L300
.L13:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L14
.L12:
	li 3,0
.L300:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 FindItemByClassname,.Lfe15-FindItemByClassname
	.align 2
	.globl FindItem
	.type	 FindItem,@function
FindItem:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	mr 29,3
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L28
	mr 28,9
.L30:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L29
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L29
	mr 3,31
	b .L301
.L29:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L30
.L28:
	li 3,0
.L301:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 FindItem,.Lfe16-FindItem
	.section	".rodata"
	.align 2
.LC262:
	.long 0x0
	.section	".text"
	.align 2
	.globl DoRespawn
	.type	 DoRespawn,@function
DoRespawn:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,308(31)
	cmpwi 0,0,0
	bc 12,2,.L35
	lis 9,.LC262@ha
	lis 11,ctf@ha
	lwz 30,564(31)
	la 9,.LC262@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L36
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,4
	bc 12,2,.L36
	lwz 9,648(30)
	cmpwi 0,9,0
	bc 12,2,.L36
	lwz 0,56(9)
	andi. 9,0,1
	bc 12,2,.L36
	mr 31,30
	b .L35
.L36:
	mr. 31,30
	li 29,0
	bc 12,2,.L39
.L40:
	lwz 31,536(31)
	addi 29,29,1
	cmpwi 0,31,0
	bc 4,2,.L40
.L39:
	bl rand
	mr 31,30
	divw 0,3,29
	mullw 0,0,29
	subf. 3,0,3
	bc 4,1,.L35
	mr 29,3
.L45:
	addic. 29,29,-1
	lwz 31,536(31)
	bc 4,2,.L45
.L35:
	lwz 0,184(31)
	li 29,1
	lis 9,gi+72@ha
	stw 29,248(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	stw 29,80(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 DoRespawn,.Lfe17-DoRespawn
	.align 2
	.globl SetRespawn
	.type	 SetRespawn,@function
SetRespawn:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	li 8,0
	lwz 11,264(9)
	lis 7,level+4@ha
	lis 10,DoRespawn@ha
	lwz 0,184(9)
	la 10,DoRespawn@l(10)
	lis 6,gi+72@ha
	oris 11,11,0x8000
	stw 8,248(9)
	ori 0,0,1
	stw 11,264(9)
	stw 0,184(9)
	lfs 0,level+4@l(7)
	stw 10,436(9)
	fadds 0,0,1
	stfs 0,428(9)
	lwz 0,gi+72@l(6)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 SetRespawn,.Lfe18-SetRespawn
	.align 2
	.globl Drop_General
	.type	 Drop_General,@function
Drop_General:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	mr 29,4
	bl Drop_Item
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(28)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 29,9,29
	addi 11,11,740
	mullw 29,29,0
	mr 3,28
	rlwinm 29,29,0,0,29
	lwzx 9,11,29
	addi 9,9,-1
	stwx 9,11,29
	bl ValidateSelectedItem
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 Drop_General,.Lfe19-Drop_General
	.align 2
	.globl Use_Item
	.type	 Use_Item,@function
Use_Item:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,284(3)
	li 11,0
	lwz 0,184(3)
	andi. 10,9,2
	stw 11,448(3)
	rlwinm 0,0,0,0,30
	stw 0,184(3)
	bc 12,2,.L204
	li 0,2
	stw 11,444(3)
	stw 0,248(3)
	b .L205
.L204:
	lis 9,Touch_Item@ha
	li 0,1
	la 9,Touch_Item@l(9)
	stw 0,248(3)
	stw 9,444(3)
.L205:
	lis 9,gi+72@ha
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe20:
	.size	 Use_Item,.Lfe20-Use_Item
	.align 2
	.globl InitItems
	.type	 InitItems,@function
InitItems:
	lis 9,game+1556@ha
	li 0,52
	stw 0,game+1556@l(9)
	blr
.Lfe21:
	.size	 InitItems,.Lfe21-InitItems
	.align 2
	.globl SetItemNames
	.type	 SetItemNames,@function
SetItemNames:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lwz 0,1556(10)
	cmpw 0,31,0
	bc 4,0,.L295
	lis 9,itemlist@ha
	lis 11,gi@ha
	la 9,itemlist@l(9)
	la 28,gi@l(11)
	mr 29,10
	addi 30,9,40
.L297:
	lwz 9,24(28)
	addi 3,31,1056
	lwz 4,0(30)
	addi 31,31,1
	mtlr 9
	addi 30,30,76
	blrl
	lwz 0,1556(29)
	cmpw 0,31,0
	bc 12,0,.L297
.L295:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 SetItemNames,.Lfe22-SetItemNames
	.section	".sbss","aw",@nobits
	.align 2
power_screen_index:
	.space	4
	.size	 power_screen_index,4
	.align 2
power_shield_index:
	.space	4
	.size	 power_shield_index,4
	.align 2
quad_drop_timeout_hack:
	.space	4
	.size	 quad_drop_timeout_hack,4
	.section	".text"
	.align 2
	.globl FindIndexByClassname
	.type	 FindIndexByClassname,@function
FindIndexByClassname:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,game@ha
	li 31,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	mr 29,3
	la 30,itemlist@l(11)
	cmpw 0,31,0
	bc 4,0,.L20
	mr 28,9
.L22:
	lwz 3,0(30)
	cmpwi 0,3,0
	bc 12,2,.L21
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L21
	mr 3,31
	b .L302
.L21:
	lwz 0,1556(28)
	addi 31,31,1
	addi 30,30,76
	cmpw 0,31,0
	bc 12,0,.L22
.L20:
	li 3,0
.L302:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 FindIndexByClassname,.Lfe23-FindIndexByClassname
	.section	".rodata"
	.align 2
.LC263:
	.long 0x0
	.align 3
.LC264:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Adrenaline
	.type	 Pickup_Adrenaline,@function
Pickup_Adrenaline:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC263@ha
	lis 11,deathmatch@ha
	la 9,.LC263@l(9)
	mr 12,3
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L61
	lwz 9,484(4)
	addi 9,9,1
	stw 9,484(4)
.L61:
	lwz 0,480(4)
	lwz 9,484(4)
	cmpw 0,0,9
	bc 4,0,.L62
	stw 9,480(4)
.L62:
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L63
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L63
	lis 9,.LC264@ha
	lwz 11,648(12)
	la 9,.LC264@l(9)
	lis 7,0x4330
	lwz 0,264(12)
	lfd 12,0(9)
	lis 6,level+4@ha
	lis 10,DoRespawn@ha
	lwz 9,48(11)
	oris 0,0,0x8000
	la 10,DoRespawn@l(10)
	lwz 11,184(12)
	lis 5,gi+72@ha
	mr 3,12
	xoris 9,9,0x8000
	stw 0,264(12)
	stw 9,12(1)
	ori 11,11,1
	stw 7,8(1)
	lfd 0,8(1)
	stw 11,184(12)
	stw 4,248(12)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,436(12)
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(12)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L63:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 Pickup_Adrenaline,.Lfe24-Pickup_Adrenaline
	.section	".rodata"
	.align 2
.LC265:
	.long 0x0
	.align 3
.LC266:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_AncientHead
	.type	 Pickup_AncientHead,@function
Pickup_AncientHead:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,484(4)
	mr 12,3
	addi 9,9,2
	stw 9,484(4)
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L66
	lis 9,.LC265@ha
	lis 11,deathmatch@ha
	la 9,.LC265@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L66
	lis 9,.LC266@ha
	lwz 11,648(12)
	la 9,.LC266@l(9)
	lis 7,0x4330
	lwz 0,264(12)
	lfd 12,0(9)
	lis 6,level+4@ha
	lis 10,DoRespawn@ha
	lwz 9,48(11)
	oris 0,0,0x8000
	la 10,DoRespawn@l(10)
	lwz 11,184(12)
	lis 5,gi+72@ha
	xoris 9,9,0x8000
	stw 0,264(12)
	stw 9,12(1)
	ori 11,11,1
	stw 7,8(1)
	lfd 0,8(1)
	stw 11,184(12)
	stw 4,248(12)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,436(12)
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(12)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L66:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe25:
	.size	 Pickup_AncientHead,.Lfe25-Pickup_AncientHead
	.align 2
	.globl Use_SaberCrystal
	.type	 Use_SaberCrystal,@function
Use_SaberCrystal:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,itemlist@ha
	mr 28,4
	la 11,itemlist@l(11)
	lis 0,0x286b
	mr 29,3
	ori 0,0,51739
	subf 11,11,28
	lwz 10,84(29)
	mullw 11,11,0
	addi 10,10,740
	rlwinm 11,11,0,0,29
	lwzx 9,10,11
	addi 9,9,-1
	stwx 9,10,11
	bl ValidateSelectedItem
	lbz 0,71(28)
	stb 0,924(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 Use_SaberCrystal,.Lfe26-Use_SaberCrystal
	.section	".rodata"
	.align 3
.LC267:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC268:
	.long 0x42480000
	.section	".text"
	.align 2
	.globl Use_MediKit
	.type	 Use_MediKit,@function
Use_MediKit:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	mr 29,3
	subf 4,9,4
	ori 0,0,51739
	lwz 11,84(29)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC267@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC267@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,4328(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L70
	lis 9,.LC268@ha
	la 9,.LC268@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L303
.L70:
	addi 0,11,50
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L303:
	stfs 0,4328(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe27:
	.size	 Use_MediKit,.Lfe27-Use_MediKit
	.section	".rodata"
	.align 3
.LC269:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC270:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl Use_GlowLamp
	.type	 Use_GlowLamp,@function
Use_GlowLamp:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	mr 29,3
	subf 4,9,4
	ori 0,0,51739
	lwz 11,84(29)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC269@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC269@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,4332(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L73
	lis 9,.LC270@ha
	la 9,.LC270@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L304
.L73:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L304:
	stfs 0,4332(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe28:
	.size	 Use_GlowLamp,.Lfe28-Use_GlowLamp
	.section	".rodata"
	.align 3
.LC271:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC272:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl Use_Breather
	.type	 Use_Breather,@function
Use_Breather:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	mr 29,3
	subf 4,9,4
	ori 0,0,51739
	lwz 11,84(29)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC271@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC271@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,4324(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L76
	lis 9,.LC272@ha
	la 9,.LC272@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L305
.L76:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L305:
	stfs 0,4324(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe29:
	.size	 Use_Breather,.Lfe29-Use_Breather
	.align 2
	.globl Drop_Ammo
	.type	 Drop_Ammo,@function
Drop_Ammo:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	mr 30,4
	la 9,itemlist@l(9)
	lis 0,0x286b
	ori 0,0,51739
	subf 9,9,30
	mullw 9,9,0
	mr 31,3
	srawi 28,9,2
	bl Drop_Item
	lwz 9,84(31)
	slwi 0,28,2
	mr 29,3
	lwz 11,48(30)
	addi 9,9,740
	lwzx 0,9,0
	cmpw 0,0,11
	bc 12,0,.L136
	stw 11,532(29)
	b .L137
.L136:
	stw 0,532(29)
.L137:
	lwz 9,84(31)
	slwi 11,28,2
	lwz 8,532(29)
	mr 10,9
	lwz 9,1764(9)
	cmpwi 0,9,0
	bc 12,2,.L138
	lwz 0,68(9)
	cmpwi 0,0,9
	bc 4,2,.L138
	lwz 0,68(30)
	cmpwi 0,0,9
	bc 4,2,.L138
	addi 9,10,740
	lwzx 0,9,11
	subf. 9,8,0
	bc 12,1,.L138
	lis 5,.LC10@ha
	mr 3,31
	la 5,.LC10@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	mr 3,29
	bl G_FreeEdict
	b .L135
.L138:
	addi 9,10,740
	mr 3,31
	lwzx 0,9,11
	subf 0,8,0
	stwx 0,9,11
	bl ValidateSelectedItem
.L135:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 Drop_Ammo,.Lfe30-Drop_Ammo
	.section	".rodata"
	.align 2
.LC273:
	.long 0x3f800000
	.align 2
.LC274:
	.long 0x0
	.align 2
.LC275:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl MegaHealth_think
	.type	 MegaHealth_think,@function
MegaHealth_think:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 7,3
	lwz 11,256(7)
	lwz 9,480(11)
	lwz 0,484(11)
	cmpw 0,9,0
	bc 4,1,.L140
	lis 10,.LC273@ha
	lis 9,level+4@ha
	la 10,.LC273@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(7)
	lwz 9,480(11)
	addi 9,9,-1
	stw 9,480(11)
	b .L139
.L140:
	lwz 0,284(7)
	andis. 6,0,0x1
	bc 4,2,.L141
	lis 9,.LC274@ha
	lis 11,deathmatch@ha
	la 9,.LC274@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L141
	lwz 9,264(7)
	lis 11,.LC275@ha
	lis 10,level+4@ha
	lwz 0,184(7)
	la 11,.LC275@l(11)
	lis 8,gi+72@ha
	oris 9,9,0x8000
	stw 6,248(7)
	mr 3,7
	ori 0,0,1
	stw 9,264(7)
	stw 0,184(7)
	lfs 0,level+4@l(10)
	lfs 13,0(11)
	lis 11,DoRespawn@ha
	la 11,DoRespawn@l(11)
	fadds 0,0,13
	stw 11,436(7)
	stfs 0,428(7)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	b .L139
.L141:
	mr 3,7
	bl G_FreeEdict
.L139:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 MegaHealth_think,.Lfe31-MegaHealth_think
	.align 2
	.globl ArmorIndex
	.type	 ArmorIndex,@function
ArmorIndex:
	li 3,0
	blr
.Lfe32:
	.size	 ArmorIndex,.Lfe32-ArmorIndex
	.align 2
	.globl PowerArmorType
	.type	 PowerArmorType,@function
PowerArmorType:
	li 3,0
	blr
.Lfe33:
	.size	 PowerArmorType,.Lfe33-PowerArmorType
	.align 2
	.globl Use_PowerArmor
	.type	 Use_PowerArmor,@function
Use_PowerArmor:
	blr
.Lfe34:
	.size	 Use_PowerArmor,.Lfe34-Use_PowerArmor
	.align 2
	.globl Pickup_PowerArmor
	.type	 Pickup_PowerArmor,@function
Pickup_PowerArmor:
	li 3,1
	blr
.Lfe35:
	.size	 Pickup_PowerArmor,.Lfe35-Pickup_PowerArmor
	.align 2
	.globl Drop_PowerArmor
	.type	 Drop_PowerArmor,@function
Drop_PowerArmor:
	blr
.Lfe36:
	.size	 Drop_PowerArmor,.Lfe36-Drop_PowerArmor
	.align 2
	.type	 drop_temp_touch,@function
drop_temp_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,256(3)
	cmpw 0,4,0
	bc 12,2,.L195
	bl Touch_Item
.L195:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 drop_temp_touch,.Lfe37-drop_temp_touch
	.section	".rodata"
	.align 2
.LC276:
	.long 0x0
	.align 2
.LC277:
	.long 0x41e80000
	.section	".text"
	.align 2
	.type	 drop_make_touchable,@function
drop_make_touchable:
	lis 9,Touch_Item@ha
	lis 11,deathmatch@ha
	la 9,Touch_Item@l(9)
	lwz 10,deathmatch@l(11)
	stw 9,444(3)
	lis 9,.LC276@ha
	lfs 0,20(10)
	la 9,.LC276@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bclr 12,2
	lis 9,.LC277@ha
	lis 11,level+4@ha
	la 9,.LC277@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,436(3)
	stfs 0,428(3)
	blr
.Lfe38:
	.size	 drop_make_touchable,.Lfe38-drop_make_touchable
	.align 2
	.globl SP_item_health
	.type	 SP_item_health,@function
SP_item_health:
	blr
.Lfe39:
	.size	 SP_item_health,.Lfe39-SP_item_health
	.align 2
	.globl SP_item_health_small
	.type	 SP_item_health_small,@function
SP_item_health_small:
	blr
.Lfe40:
	.size	 SP_item_health_small,.Lfe40-SP_item_health_small
	.align 2
	.globl SP_item_health_large
	.type	 SP_item_health_large,@function
SP_item_health_large:
	blr
.Lfe41:
	.size	 SP_item_health_large,.Lfe41-SP_item_health_large
	.align 2
	.globl SP_item_health_mega
	.type	 SP_item_health_mega,@function
SP_item_health_mega:
	blr
.Lfe42:
	.size	 SP_item_health_mega,.Lfe42-SP_item_health_mega
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
