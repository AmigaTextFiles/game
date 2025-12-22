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
	.section	".rodata"
	.align 3
.LC0:
	.long 0x3fb99999
	.long 0x9999999a
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
	.align 2
.LC5:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Pickup_Powerup
	.type	 Pickup_Powerup,@function
Pickup_Powerup:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	mr 31,3
	lis 9,itemlist@ha
	lwz 8,648(31)
	lis 11,skill@ha
	la 9,itemlist@l(9)
	lis 0,0x38e3
	lwz 10,skill@l(11)
	lis 7,.LC1@ha
	ori 0,0,36409
	subf 9,9,8
	mullw 9,9,0
	mr 30,4
	la 7,.LC1@l(7)
	lfs 13,20(10)
	lwz 11,84(30)
	lfs 0,0(7)
	srawi 9,9,3
	slwi 9,9,2
	addi 11,11,740
	lwzx 11,11,9
	fcmpu 6,13,0
	cmpwi 7,11,1
	mfcr 9
	rlwinm 0,9,30,1
	rlwinm 9,9,27,1
	and. 10,9,0
	bc 4,2,.L61
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
	and. 11,9,10
	bc 4,2,.L61
	lis 11,coop@ha
	lis 7,.LC3@ha
	lwz 9,coop@l(11)
	la 7,.LC3@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L47
	lwz 0,56(8)
	rlwinm 0,0,29,31,31
	and. 9,0,10
	bc 12,2,.L47
.L61:
	li 3,0
	b .L60
.L47:
	lwz 0,648(31)
	lis 9,itemlist@ha
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	lwz 10,84(30)
	subf 0,9,0
	lis 8,deathmatch@ha
	mullw 0,0,11
	addi 10,10,740
	lis 7,.LC3@ha
	lwz 11,deathmatch@l(8)
	la 7,.LC3@l(7)
	srawi 0,0,3
	lfs 13,0(7)
	slwi 0,0,2
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L48
	lwz 0,284(31)
	andis. 5,0,0x1
	bc 4,2,.L49
	lwz 8,648(31)
	lis 11,.LC4@ha
	la 11,.LC4@l(11)
	lwz 9,264(31)
	lis 7,0x4330
	lwz 0,48(8)
	lis 6,compmod+4@ha
	lfd 13,0(11)
	oris 9,9,0x8000
	xoris 0,0,0x8000
	lwz 11,184(31)
	stw 0,12(1)
	stw 7,8(1)
	ori 11,11,1
	lfd 0,8(1)
	stw 9,264(31)
	stw 11,184(31)
	stw 5,248(31)
	fsub 0,0,13
	lwz 0,compmod+4@l(6)
	cmpwi 0,0,0
	frsp 31,0
	bc 12,2,.L52
	bl FindTimer
	mr. 3,3
	bc 12,2,.L52
	lis 9,level+4@ha
	lfs 12,288(3)
	lfs 13,level+4@l(9)
	fsubs 0,12,13
	fcmpu 0,0,31
	bc 4,0,.L53
	lis 7,.LC5@ha
	la 7,.LC5@l(7)
	lfs 0,0(7)
	fadds 0,12,0
	b .L51
.L53:
	fadds 0,13,31
	b .L51
.L52:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,31
.L51:
	lis 9,DoRespawn@ha
	stfs 0,428(31)
	lis 11,gi+72@ha
	la 9,DoRespawn@l(9)
	mr 3,31
	stw 9,436(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L49:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,16
	bc 4,2,.L58
	lwz 9,648(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L48
	lwz 0,284(31)
	andis. 7,0,2
	bc 12,2,.L48
.L58:
	lwz 9,648(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L59
	lwz 0,284(31)
	andis. 9,0,2
	bc 12,2,.L59
	lis 11,level+4@ha
	lfs 0,428(31)
	lis 10,.LC0@ha
	lfs 11,level+4@l(11)
	lfd 12,.LC0@l(10)
	lis 11,quad_drop_timeout_hack@ha
	fsubs 0,0,11
	fdiv 0,0,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	stw 9,quad_drop_timeout_hack@l(11)
.L59:
	lwz 9,648(31)
	mr 3,30
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L48:
	li 3,1
.L60:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Pickup_Powerup,.Lfe1-Pickup_Powerup
	.section	".rodata"
	.align 2
.LC6:
	.long 0x0
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC8:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Pickup_Adrenaline
	.type	 Pickup_Adrenaline,@function
Pickup_Adrenaline:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stw 31,36(1)
	stw 0,52(1)
	lis 9,.LC6@ha
	lis 11,deathmatch@ha
	la 9,.LC6@l(9)
	mr 31,3
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L64
	lwz 9,484(4)
	addi 9,9,1
	stw 9,484(4)
.L64:
	lwz 0,480(4)
	lwz 9,484(4)
	cmpw 0,0,9
	bc 4,0,.L65
	stw 9,480(4)
.L65:
	lwz 0,284(31)
	andis. 5,0,0x1
	bc 4,2,.L66
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L66
	lwz 8,648(31)
	lis 11,.LC7@ha
	la 11,.LC7@l(11)
	lwz 9,264(31)
	lis 7,0x4330
	lwz 0,48(8)
	lis 6,compmod+4@ha
	lfd 13,0(11)
	oris 9,9,0x8000
	xoris 0,0,0x8000
	lwz 11,184(31)
	stw 0,28(1)
	stw 7,24(1)
	ori 11,11,1
	lfd 0,24(1)
	stw 9,264(31)
	stw 11,184(31)
	stw 5,248(31)
	fsub 0,0,13
	lwz 0,compmod+4@l(6)
	cmpwi 0,0,0
	frsp 31,0
	bc 12,2,.L69
	bl FindTimer
	mr. 3,3
	bc 12,2,.L69
	lis 9,level+4@ha
	lfs 12,288(3)
	lfs 13,level+4@l(9)
	fsubs 0,12,13
	fcmpu 0,0,31
	bc 4,0,.L70
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfs 0,0(9)
	fadds 0,12,0
	b .L68
.L70:
	fadds 0,13,31
	b .L68
.L69:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,31
.L68:
	lis 9,DoRespawn@ha
	stfs 0,428(31)
	lis 11,gi+72@ha
	la 9,DoRespawn@l(9)
	mr 3,31
	stw 9,436(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L66:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lwz 31,36(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Pickup_Adrenaline,.Lfe2-Pickup_Adrenaline
	.section	".rodata"
	.align 2
.LC9:
	.string	"Bullets"
	.align 2
.LC10:
	.string	"Shells"
	.align 2
.LC11:
	.long 0x0
	.align 3
.LC12:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC13:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Pickup_Bandolier
	.type	 Pickup_Bandolier,@function
Pickup_Bandolier:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	mr 29,4
	mr 28,3
	lwz 9,84(29)
	lwz 0,1764(9)
	cmpwi 0,0,249
	bc 12,1,.L84
	li 0,250
	stw 0,1764(9)
.L84:
	lwz 9,84(29)
	lwz 0,1768(9)
	cmpwi 0,0,149
	bc 12,1,.L85
	li 0,150
	stw 0,1768(9)
.L85:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,249
	bc 12,1,.L86
	li 0,250
	stw 0,1780(9)
.L86:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,74
	bc 12,1,.L87
	li 0,75
	stw 0,1784(9)
.L87:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC9@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC9@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L95
	mr 27,10
.L90:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L92
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L116
.L92:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L90
.L95:
	li 8,0
.L94:
	cmpwi 0,8,0
	bc 12,2,.L96
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1764(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L96
	stwx 11,9,8
.L96:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC10@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC10@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L105
	mr 27,10
.L100:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L102
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L117
.L102:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L100
.L105:
	li 8,0
.L104:
	cmpwi 0,8,0
	bc 12,2,.L106
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	addi 4,9,740
	lwz 11,1768(9)
	lwzx 0,4,8
	cmpw 0,0,11
	bc 4,1,.L106
	stwx 11,4,8
.L106:
	lwz 0,284(28)
	andis. 5,0,0x1
	bc 4,2,.L108
	lis 9,.LC11@ha
	lis 11,deathmatch@ha
	la 9,.LC11@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L108
	lwz 8,648(28)
	lis 11,.LC12@ha
	la 11,.LC12@l(11)
	lwz 9,264(28)
	lis 7,0x4330
	lwz 0,48(8)
	lis 6,compmod+4@ha
	lfd 13,0(11)
	oris 9,9,0x8000
	xoris 0,0,0x8000
	lwz 11,184(28)
	stw 0,12(1)
	stw 7,8(1)
	ori 11,11,1
	lfd 0,8(1)
	stw 9,264(28)
	stw 11,184(28)
	stw 5,248(28)
	fsub 0,0,13
	lwz 0,compmod+4@l(6)
	cmpwi 0,0,0
	frsp 31,0
	bc 4,2,.L109
	b .L111
.L117:
	mr 8,31
	b .L104
.L116:
	mr 8,31
	b .L94
.L109:
	bl FindTimer
	mr. 3,3
	bc 12,2,.L111
	lis 9,level+4@ha
	lfs 12,288(3)
	lfs 13,level+4@l(9)
	fsubs 0,12,13
	fcmpu 0,0,31
	bc 4,0,.L112
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 0,0(9)
	fadds 0,12,0
	b .L110
.L112:
	fadds 0,13,31
	b .L110
.L111:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,31
.L110:
	lis 9,DoRespawn@ha
	stfs 0,428(28)
	lis 11,gi+72@ha
	la 9,DoRespawn@l(9)
	mr 3,28
	stw 9,436(28)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L108:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 Pickup_Bandolier,.Lfe3-Pickup_Bandolier
	.section	".rodata"
	.align 2
.LC14:
	.string	"Cells"
	.align 2
.LC15:
	.string	"Grenades"
	.align 2
.LC16:
	.string	"Rockets"
	.align 2
.LC17:
	.string	"Slugs"
	.align 2
.LC18:
	.long 0x0
	.align 3
.LC19:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC20:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Pickup_Pack
	.type	 Pickup_Pack,@function
Pickup_Pack:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	mr 29,4
	mr 27,3
	lwz 9,84(29)
	lwz 0,1764(9)
	cmpwi 0,0,299
	bc 12,1,.L119
	li 0,300
	stw 0,1764(9)
.L119:
	lwz 9,84(29)
	lwz 0,1768(9)
	cmpwi 0,0,199
	bc 12,1,.L120
	li 0,200
	stw 0,1768(9)
.L120:
	lwz 9,84(29)
	lwz 0,1772(9)
	cmpwi 0,0,99
	bc 12,1,.L121
	li 0,100
	stw 0,1772(9)
.L121:
	lwz 9,84(29)
	lwz 0,1776(9)
	cmpwi 0,0,99
	bc 12,1,.L122
	li 0,100
	stw 0,1776(9)
.L122:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,299
	bc 12,1,.L123
	li 0,300
	stw 0,1780(9)
.L123:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,99
	bc 12,1,.L124
	li 0,100
	stw 0,1784(9)
.L124:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC9@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC9@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L132
	mr 28,10
.L127:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L129
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L193
.L129:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L127
.L132:
	li 8,0
.L131:
	cmpwi 0,8,0
	bc 12,2,.L133
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1764(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L133
	stwx 11,9,8
.L133:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC10@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC10@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L142
	mr 28,10
.L137:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L139
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L194
.L139:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L137
.L142:
	li 8,0
.L141:
	cmpwi 0,8,0
	bc 12,2,.L143
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1768(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L143
	stwx 11,9,8
.L143:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC14@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC14@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L152
	mr 28,10
.L147:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L149
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L195
.L149:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L147
.L152:
	li 8,0
.L151:
	cmpwi 0,8,0
	bc 12,2,.L153
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1780(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L153
	stwx 11,9,8
.L153:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC15@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC15@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L162
	mr 28,10
.L157:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L159
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L196
.L159:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L157
.L162:
	li 8,0
.L161:
	cmpwi 0,8,0
	bc 12,2,.L163
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1776(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L163
	stwx 11,9,8
.L163:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC16@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC16@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L172
	mr 28,10
.L167:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L169
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L197
.L169:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L167
.L172:
	li 8,0
.L171:
	cmpwi 0,8,0
	bc 12,2,.L173
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1772(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L173
	stwx 11,9,8
.L173:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC17@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC17@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L182
	mr 28,10
.L177:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L179
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L198
.L179:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L177
.L182:
	li 8,0
.L181:
	cmpwi 0,8,0
	bc 12,2,.L183
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	addi 4,9,740
	lwz 11,1784(9)
	lwzx 0,4,8
	cmpw 0,0,11
	bc 4,1,.L183
	stwx 11,4,8
.L183:
	lwz 0,284(27)
	andis. 5,0,0x1
	bc 4,2,.L185
	lis 9,.LC18@ha
	lis 11,deathmatch@ha
	la 9,.LC18@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L185
	lwz 8,648(27)
	lis 11,.LC19@ha
	la 11,.LC19@l(11)
	lwz 9,264(27)
	lis 7,0x4330
	lwz 0,48(8)
	lis 6,compmod+4@ha
	lfd 13,0(11)
	oris 9,9,0x8000
	xoris 0,0,0x8000
	lwz 11,184(27)
	stw 0,12(1)
	stw 7,8(1)
	ori 11,11,1
	lfd 0,8(1)
	stw 9,264(27)
	stw 11,184(27)
	stw 5,248(27)
	fsub 0,0,13
	lwz 0,compmod+4@l(6)
	cmpwi 0,0,0
	frsp 31,0
	bc 4,2,.L186
	b .L188
.L198:
	mr 8,31
	b .L181
.L197:
	mr 8,31
	b .L171
.L196:
	mr 8,31
	b .L161
.L195:
	mr 8,31
	b .L151
.L194:
	mr 8,31
	b .L141
.L193:
	mr 8,31
	b .L131
.L186:
	bl FindTimer
	mr. 3,3
	bc 12,2,.L188
	lis 9,level+4@ha
	lfs 12,288(3)
	lfs 13,level+4@l(9)
	fsubs 0,12,13
	fcmpu 0,0,31
	bc 4,0,.L189
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fadds 0,12,0
	b .L187
.L189:
	fadds 0,13,31
	b .L187
.L188:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,31
.L187:
	lis 9,DoRespawn@ha
	stfs 0,428(27)
	lis 11,gi+72@ha
	la 9,DoRespawn@l(9)
	mr 3,27
	stw 9,436(27)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L185:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 Pickup_Pack,.Lfe4-Pickup_Pack
	.section	".rodata"
	.align 2
.LC21:
	.string	"items/damage.wav"
	.align 3
.LC22:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC23:
	.long 0x3f800000
	.align 2
.LC24:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_Quad
	.type	 Use_Quad,@function
Use_Quad:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 4,9,4
	mr 31,3
	mullw 4,4,0
	lwz 11,84(31)
	srawi 4,4,3
	addi 11,11,740
	slwi 4,4,2
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 11,quad_drop_timeout_hack@ha
	lwz 9,quad_drop_timeout_hack@l(11)
	cmpwi 0,9,0
	bc 12,2,.L200
	li 0,0
	mr 10,9
	stw 0,quad_drop_timeout_hack@l(11)
	b .L201
.L200:
	li 10,300
.L201:
	lis 11,level@ha
	lwz 8,84(31)
	lwz 11,level@l(11)
	lis 7,0x4330
	lis 6,.LC22@ha
	la 6,.LC22@l(6)
	lfs 12,3732(8)
	xoris 0,11,0x8000
	lfd 13,0(6)
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L202
	xoris 0,10,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fadds 0,12,0
	b .L204
.L202:
	add 0,11,10
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
.L204:
	stfs 0,3732(8)
	lis 29,gi@ha
	lis 3,.LC21@ha
	la 29,gi@l(29)
	la 3,.LC21@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 6,.LC23@ha
	lwz 0,16(29)
	lis 9,.LC23@ha
	la 6,.LC23@l(6)
	mr 5,3
	lfs 1,0(6)
	la 9,.LC23@l(9)
	li 4,3
	mtlr 0
	lis 6,.LC24@ha
	mr 3,31
	lfs 2,0(9)
	la 6,.LC24@l(6)
	lfs 3,0(6)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 Use_Quad,.Lfe5-Use_Quad
	.section	".rodata"
	.align 2
.LC25:
	.string	"items/protect.wav"
	.align 3
.LC26:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC27:
	.long 0x43960000
	.align 2
.LC28:
	.long 0x3f800000
	.align 2
.LC29:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_Invulnerability
	.type	 Use_Invulnerability,@function
Use_Invulnerability:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 4,9,4
	mr 31,3
	mullw 4,4,0
	lwz 11,84(31)
	srawi 4,4,3
	addi 11,11,740
	slwi 4,4,2
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC26@ha
	lis 11,level@ha
	lwz 10,84(31)
	la 9,.LC26@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3736(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L212
	lis 9,.LC27@ha
	la 9,.LC27@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L214
.L212:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L214:
	stfs 0,3736(10)
	lis 29,gi@ha
	lis 3,.LC25@ha
	la 29,gi@l(29)
	la 3,.LC25@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC28@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC28@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC28@ha
	la 9,.LC28@l(9)
	lfs 2,0(9)
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 Use_Invulnerability,.Lfe6-Use_Invulnerability
	.section	".rodata"
	.align 2
.LC30:
	.string	"key_power_cube"
	.align 2
.LC31:
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
	lis 11,.LC31@ha
	lis 9,coop@ha
	la 11,.LC31@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 30,4
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L217
	lwz 3,280(31)
	lis 4,.LC30@ha
	la 4,.LC30@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L218
	lwz 10,84(30)
	lbz 9,286(31)
	lwz 0,1800(10)
	and. 11,0,9
	bc 4,2,.L223
	lwz 0,648(31)
	lis 9,itemlist@ha
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	subf 0,9,0
	addi 10,10,740
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lwz 11,84(30)
	lbz 9,286(31)
	lwz 0,1800(11)
	or 0,0,9
	stw 0,1800(11)
	b .L220
.L218:
	lwz 0,648(31)
	lis 9,itemlist@ha
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	lwz 10,84(30)
	subf 0,9,0
	mullw 0,0,11
	addi 4,10,740
	srawi 0,0,3
	slwi 3,0,2
	lwzx 9,4,3
	cmpwi 0,9,0
	bc 12,2,.L221
.L223:
	li 3,0
	b .L222
.L221:
	li 0,1
	stwx 0,4,3
.L220:
	li 3,1
	b .L222
.L217:
	lwz 0,648(31)
	lis 9,itemlist@ha
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	lwz 10,84(30)
	subf 0,9,0
	li 3,1
	mullw 0,0,11
	addi 10,10,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
.L222:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 Pickup_Key,.Lfe7-Pickup_Key
	.align 2
	.globl Add_Ammo
	.type	 Add_Ammo,@function
Add_Ammo:
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 4,2,.L225
.L241:
	li 3,0
	blr
.L225:
	lwz 0,64(4)
	cmpwi 0,0,0
	bc 4,2,.L226
	lwz 10,1764(9)
	b .L227
.L226:
	cmpwi 0,0,1
	bc 4,2,.L228
	lwz 10,1768(9)
	b .L227
.L228:
	cmpwi 0,0,2
	bc 4,2,.L230
	lwz 10,1772(9)
	b .L227
.L230:
	cmpwi 0,0,3
	bc 4,2,.L232
	lwz 10,1776(9)
	b .L227
.L232:
	cmpwi 0,0,4
	bc 4,2,.L234
	lwz 10,1780(9)
	b .L227
.L234:
	cmpwi 0,0,5
	bc 4,2,.L241
	lwz 10,1784(9)
.L227:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(3)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 4,9,2
	lwzx 0,11,4
	cmpw 0,0,10
	bc 12,2,.L241
	add 0,0,5
	stwx 0,11,4
	lwz 9,84(3)
	addi 3,9,740
	lwzx 0,3,4
	cmpw 0,0,10
	bc 4,1,.L239
	stwx 10,3,4
.L239:
	li 3,1
	blr
.Lfe8:
	.size	 Add_Ammo,.Lfe8-Add_Ammo
	.section	".rodata"
	.align 2
.LC32:
	.string	"blaster"
	.align 2
.LC33:
	.long 0x0
	.align 2
.LC34:
	.long 0x41f00000
	.align 2
.LC35:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Pickup_Ammo
	.type	 Pickup_Ammo,@function
Pickup_Ammo:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	mr 29,3
	mr 28,4
	lwz 4,648(29)
	lwz 0,56(4)
	andi. 30,0,1
	bc 12,2,.L243
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,8192
	li 5,1000
	bc 4,2,.L244
.L243:
	lwz 5,532(29)
	cmpwi 0,5,0
	bc 12,2,.L245
	lwz 4,648(29)
	b .L244
.L245:
	lwz 9,648(29)
	lwz 5,48(9)
	mr 4,9
.L244:
	lis 10,itemlist@ha
	lis 9,0x38e3
	lwz 11,84(28)
	la 27,itemlist@l(10)
	ori 9,9,36409
	subf 0,27,4
	addi 11,11,740
	mullw 0,0,9
	mr 3,28
	srawi 0,0,3
	slwi 0,0,2
	lwzx 31,11,0
	bl Add_Ammo
	cmpwi 0,3,0
	bc 4,2,.L247
	li 3,0
	b .L267
.L268:
	mr 9,31
	b .L257
.L247:
	subfic 9,31,0
	adde 0,9,31
	and. 9,30,0
	bc 12,2,.L248
	lwz 25,84(28)
	lwz 9,648(29)
	lwz 0,1792(25)
	cmpw 0,0,9
	bc 12,2,.L248
	lis 9,.LC33@ha
	lis 11,deathmatch@ha
	la 9,.LC33@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L250
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC32@ha
	lwz 0,1556(9)
	la 26,.LC32@l(11)
	mr 31,27
	cmpw 0,30,0
	bc 4,0,.L258
	mr 27,9
.L253:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L255
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L268
.L255:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L253
.L258:
	li 9,0
.L257:
	lwz 0,1792(25)
	cmpw 0,0,9
	bc 4,2,.L248
.L250:
	lwz 9,84(28)
	lwz 0,648(29)
	stw 0,3556(9)
.L248:
	lwz 0,284(29)
	andis. 10,0,0x3
	bc 4,2,.L259
	lis 9,.LC33@ha
	lis 11,deathmatch@ha
	la 9,.LC33@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L259
	lis 9,.LC34@ha
	lwz 0,264(29)
	lis 11,compmod+4@ha
	la 9,.LC34@l(9)
	stw 10,248(29)
	lfs 31,0(9)
	oris 0,0,0x8000
	lwz 9,184(29)
	stw 0,264(29)
	ori 9,9,1
	stw 9,184(29)
	lwz 0,compmod+4@l(11)
	cmpwi 0,0,0
	bc 12,2,.L262
	bl FindTimer
	mr. 3,3
	bc 12,2,.L262
	lis 9,level+4@ha
	lfs 12,288(3)
	lfs 13,level+4@l(9)
	fsubs 0,12,13
	fcmpu 0,0,31
	bc 4,0,.L263
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 0,0(9)
	fadds 0,12,0
	b .L261
.L263:
	fadds 0,13,31
	b .L261
.L262:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,31
.L261:
	lis 9,DoRespawn@ha
	stfs 0,428(29)
	lis 11,gi+72@ha
	la 9,DoRespawn@l(9)
	mr 3,29
	stw 9,436(29)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L259:
	li 3,1
.L267:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe9:
	.size	 Pickup_Ammo,.Lfe9-Pickup_Ammo
	.section	".rodata"
	.align 2
.LC36:
	.long 0x3f800000
	.align 2
.LC37:
	.long 0x0
	.align 2
.LC38:
	.long 0x41a00000
	.align 2
.LC39:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl MegaHealth_think
	.type	 MegaHealth_think,@function
MegaHealth_think:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 31,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 11,256(31)
	lwz 9,480(11)
	lwz 0,484(11)
	cmpw 0,9,0
	bc 4,1,.L273
	lis 10,.LC36@ha
	lis 9,level+4@ha
	la 10,.LC36@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(31)
	lwz 9,480(11)
	addi 9,9,-1
	stw 9,480(11)
	b .L272
.L273:
	lwz 0,284(31)
	andis. 10,0,0x1
	bc 4,2,.L274
	lis 9,.LC37@ha
	lis 11,deathmatch@ha
	la 9,.LC37@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L274
	lis 9,.LC38@ha
	lwz 0,264(31)
	lis 11,compmod+4@ha
	la 9,.LC38@l(9)
	stw 10,248(31)
	lfs 31,0(9)
	oris 0,0,0x8000
	lwz 9,184(31)
	stw 0,264(31)
	ori 9,9,1
	stw 9,184(31)
	lwz 0,compmod+4@l(11)
	cmpwi 0,0,0
	bc 12,2,.L277
	bl FindTimer
	mr. 3,3
	bc 12,2,.L277
	lis 9,level+4@ha
	lfs 12,288(3)
	lfs 13,level+4@l(9)
	fsubs 0,12,13
	fcmpu 0,0,31
	bc 4,0,.L278
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 0,0(9)
	fadds 0,12,0
	b .L276
.L278:
	fadds 0,13,31
	b .L276
.L277:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,31
.L276:
	lis 9,DoRespawn@ha
	stfs 0,428(31)
	lis 11,gi+72@ha
	la 9,DoRespawn@l(9)
	mr 3,31
	stw 9,436(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	b .L272
.L274:
	mr 3,31
	bl G_FreeEdict
.L272:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 MegaHealth_think,.Lfe10-MegaHealth_think
	.section	".rodata"
	.align 2
.LC40:
	.string	"items/s_health.wav"
	.align 2
.LC41:
	.string	"items/n_health.wav"
	.align 2
.LC42:
	.string	"items/l_health.wav"
	.align 2
.LC43:
	.string	"items/m_health.wav"
	.align 2
.LC44:
	.long 0x40a00000
	.align 2
.LC45:
	.long 0x0
	.align 2
.LC46:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Pickup_Health
	.type	 Pickup_Health,@function
Pickup_Health:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 31,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,644(31)
	andi. 8,0,1
	bc 4,2,.L284
	lwz 9,480(4)
	lwz 0,484(4)
	cmpw 0,9,0
	bc 12,0,.L284
	li 3,0
	b .L304
.L284:
	lwz 0,480(4)
	lwz 9,532(31)
	add 0,0,9
	stw 0,480(4)
	lwz 0,532(31)
	cmpwi 0,0,2
	bc 4,2,.L286
	lwz 11,648(31)
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	b .L305
.L286:
	cmpwi 0,0,10
	bc 4,2,.L288
	lwz 11,648(31)
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	b .L305
.L288:
	cmpwi 0,0,25
	bc 4,2,.L290
	lwz 11,648(31)
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	b .L305
.L290:
	lwz 11,648(31)
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
.L305:
	stw 9,20(11)
	lwz 0,644(31)
	andi. 9,0,1
	bc 4,2,.L292
	lwz 0,480(4)
	lwz 9,484(4)
	cmpw 0,0,9
	bc 4,1,.L292
	stw 9,480(4)
.L292:
	lwz 0,644(31)
	andi. 8,0,2
	bc 12,2,.L294
	lis 9,MegaHealth_think@ha
	lis 8,.LC44@ha
	lwz 11,264(31)
	la 9,MegaHealth_think@l(9)
	lis 10,level+4@ha
	lwz 0,184(31)
	stw 9,436(31)
	la 8,.LC44@l(8)
	oris 11,11,0x8000
	lfs 0,level+4@l(10)
	li 9,0
	ori 0,0,1
	lfs 13,0(8)
	stw 9,248(31)
	stw 4,256(31)
	fadds 0,0,13
	stw 11,264(31)
	stw 0,184(31)
	stfs 0,428(31)
	b .L295
.L294:
	lwz 0,284(31)
	andis. 10,0,0x1
	bc 4,2,.L295
	lis 9,.LC45@ha
	lis 11,deathmatch@ha
	la 9,.LC45@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L295
	lwz 0,264(31)
	lis 11,compmod+4@ha
	lis 8,.LC46@ha
	lwz 9,184(31)
	la 8,.LC46@l(8)
	oris 0,0,0x8000
	stw 10,248(31)
	ori 9,9,1
	stw 0,264(31)
	stw 9,184(31)
	lwz 0,compmod+4@l(11)
	lfs 31,0(8)
	cmpwi 0,0,0
	bc 12,2,.L299
	bl FindTimer
	mr. 3,3
	bc 12,2,.L299
	lis 9,level+4@ha
	lfs 12,288(3)
	lfs 13,level+4@l(9)
	fsubs 0,12,13
	fcmpu 0,0,31
	bc 4,0,.L300
	lis 8,.LC44@ha
	la 8,.LC44@l(8)
	lfs 0,0(8)
	fadds 0,12,0
	b .L298
.L300:
	fadds 0,13,31
	b .L298
.L299:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,31
.L298:
	lis 9,DoRespawn@ha
	stfs 0,428(31)
	lis 11,gi+72@ha
	la 9,DoRespawn@l(9)
	mr 3,31
	stw 9,436(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L295:
	li 3,1
.L304:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 Pickup_Health,.Lfe11-Pickup_Health
	.section	".rodata"
	.align 3
.LC47:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC48:
	.long 0x0
	.align 2
.LC49:
	.long 0x41a00000
	.align 2
.LC50:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Pickup_Armor
	.type	 Pickup_Armor,@function
Pickup_Armor:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stw 31,36(1)
	stw 0,52(1)
	mr 12,4
	mr 31,3
	lwz 11,84(12)
	lwz 9,648(31)
	cmpwi 0,11,0
	lwz 7,60(9)
	bc 4,2,.L312
	li 6,0
	b .L313
.L312:
	lis 9,jacket_armor_index@ha
	addi 8,11,740
	lwz 6,jacket_armor_index@l(9)
	slwi 0,6,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L313
	lis 9,combat_armor_index@ha
	lwz 6,combat_armor_index@l(9)
	slwi 0,6,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L313
	lis 9,body_armor_index@ha
	lwz 10,body_armor_index@l(9)
	slwi 11,10,2
	lwzx 9,8,11
	srawi 0,9,31
	subf 0,9,0
	srawi 0,0,31
	and 6,10,0
.L313:
	lwz 8,648(31)
	lwz 0,64(8)
	cmpwi 0,0,4
	bc 4,2,.L317
	cmpwi 0,6,0
	bc 4,2,.L318
	lis 11,jacket_armor_index@ha
	lwz 9,84(12)
	li 10,2
	lwz 0,jacket_armor_index@l(11)
	addi 9,9,740
	slwi 0,0,2
	stwx 10,9,0
	b .L320
.L318:
	lwz 9,84(12)
	slwi 0,6,2
	addi 9,9,740
	lwzx 11,9,0
	addi 11,11,2
	stwx 11,9,0
	b .L320
.L317:
	cmpwi 0,6,0
	bc 4,2,.L321
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(12)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,0(7)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	stwx 10,11,9
	b .L320
.L321:
	lis 9,jacket_armor_index@ha
	lwz 0,jacket_armor_index@l(9)
	cmpw 0,6,0
	bc 4,2,.L323
	lis 9,jacketarmor_info@ha
	la 11,jacketarmor_info@l(9)
	b .L324
.L323:
	lis 9,combat_armor_index@ha
	lwz 0,combat_armor_index@l(9)
	cmpw 0,6,0
	bc 4,2,.L325
	lis 9,combatarmor_info@ha
	la 11,combatarmor_info@l(9)
	b .L324
.L325:
	lis 9,bodyarmor_info@ha
	la 11,bodyarmor_info@l(9)
.L324:
	lfs 13,8(7)
	lfs 0,8(11)
	fcmpu 0,13,0
	bc 4,1,.L327
	fdivs 11,0,13
	lwz 9,84(12)
	slwi 6,6,2
	lis 5,0x4330
	lis 10,.LC47@ha
	lwz 3,0(7)
	addi 9,9,740
	la 10,.LC47@l(10)
	lwz 7,4(7)
	lwzx 11,9,6
	li 0,0
	mr 4,8
	lfd 13,0(10)
	xoris 11,11,0x8000
	stwx 0,9,6
	lis 10,itemlist@ha
	stw 11,28(1)
	la 10,itemlist@l(10)
	lis 0,0x38e3
	stw 5,24(1)
	ori 0,0,36409
	lfd 0,24(1)
	lwz 9,648(31)
	lwz 11,84(12)
	subf 9,10,9
	mullw 9,9,0
	addi 11,11,740
	srawi 9,9,3
	slwi 9,9,2
	fsub 0,0,13
	frsp 0,0
	fmuls 0,11,0
	fmr 13,0
	fctiwz 12,13
	stfd 12,24(1)
	lwz 0,28(1)
	add 3,3,0
	cmpw 7,3,7
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 7,7,0
	and 0,3,0
	or 3,0,7
	stwx 3,11,9
	b .L320
.L327:
	fdivs 11,13,0
	lwz 0,0(7)
	lis 8,0x4330
	lis 10,.LC47@ha
	mr 7,9
	lwz 11,4(11)
	xoris 0,0,0x8000
	la 10,.LC47@l(10)
	stw 0,28(1)
	slwi 6,6,2
	stw 8,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lwz 10,84(12)
	addi 4,10,740
	lwzx 10,4,6
	fsub 0,0,13
	frsp 0,0
	fmuls 0,11,0
	fmr 13,0
	fctiwz 12,13
	stfd 12,24(1)
	lwz 0,28(1)
	add 3,10,0
	cmpw 7,3,11
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 11,11,0
	and 0,3,0
	or 0,0,11
	cmpw 0,10,0
	bc 12,0,.L331
	li 3,0
	b .L340
.L331:
	stwx 0,4,6
.L320:
	lwz 0,284(31)
	andis. 10,0,0x1
	bc 4,2,.L332
	lis 9,.LC48@ha
	lis 11,deathmatch@ha
	la 9,.LC48@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L332
	lis 9,.LC49@ha
	lwz 0,264(31)
	lis 11,compmod+4@ha
	la 9,.LC49@l(9)
	stw 10,248(31)
	lfs 31,0(9)
	oris 0,0,0x8000
	lwz 9,184(31)
	stw 0,264(31)
	ori 9,9,1
	stw 9,184(31)
	lwz 0,compmod+4@l(11)
	cmpwi 0,0,0
	bc 12,2,.L335
	bl FindTimer
	mr. 3,3
	bc 12,2,.L335
	lis 9,level+4@ha
	lfs 12,288(3)
	lfs 13,level+4@l(9)
	fsubs 0,12,13
	fcmpu 0,0,31
	bc 4,0,.L336
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 0,0(9)
	fadds 0,12,0
	b .L334
.L336:
	fadds 0,13,31
	b .L334
.L335:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,31
.L334:
	lis 9,DoRespawn@ha
	stfs 0,428(31)
	lis 11,gi+72@ha
	la 9,DoRespawn@l(9)
	mr 3,31
	stw 9,436(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L332:
	li 3,1
.L340:
	lwz 0,52(1)
	mtlr 0
	lwz 31,36(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 Pickup_Armor,.Lfe12-Pickup_Armor
	.section	".rodata"
	.align 2
.LC51:
	.string	"misc/power2.wav"
	.align 2
.LC52:
	.string	"cells"
	.align 2
.LC53:
	.string	"No cells for power armor.\n"
	.align 2
.LC54:
	.string	"misc/power1.wav"
	.align 2
.LC55:
	.long 0x3f800000
	.align 2
.LC56:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_PowerArmor
	.type	 Use_PowerArmor,@function
Use_PowerArmor:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 30,3
	lwz 0,264(30)
	andi. 9,0,4096
	bc 12,2,.L347
	rlwinm 0,0,0,20,18
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(30)
	lis 3,.LC51@ha
	lwz 9,36(29)
	la 3,.LC51@l(3)
	mtlr 9
	blrl
	lis 9,.LC55@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC55@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 2,0(9)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 3,0(9)
	blrl
	b .L346
.L358:
	mr 10,29
	b .L355
.L347:
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lis 11,.LC52@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC52@l(11)
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L356
	mr 28,10
.L351:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L353
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L358
.L353:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,72
	cmpw 0,31,0
	bc 12,0,.L351
.L356:
	li 10,0
.L355:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L357
	lis 9,gi+8@ha
	lis 5,.LC53@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC53@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L346
.L357:
	lwz 0,264(30)
	lis 29,gi@ha
	lis 3,.LC54@ha
	la 29,gi@l(29)
	la 3,.LC54@l(3)
	ori 0,0,4096
	stw 0,264(30)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC55@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC55@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 2,0(9)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 3,0(9)
	blrl
.L346:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 Use_PowerArmor,.Lfe13-Use_PowerArmor
	.section	".rodata"
	.align 2
.LC57:
	.long 0x0
	.align 3
.LC58:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC59:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Pickup_PowerArmor
	.type	 Pickup_PowerArmor,@function
Pickup_PowerArmor:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	mr 31,3
	lis 9,itemlist@ha
	lwz 0,648(31)
	la 9,itemlist@l(9)
	lis 11,0x38e3
	ori 11,11,36409
	mr 29,4
	subf 0,9,0
	lwz 10,84(29)
	mullw 0,0,11
	lis 9,deathmatch@ha
	lwz 8,deathmatch@l(9)
	addi 10,10,740
	srawi 0,0,3
	lis 9,.LC57@ha
	slwi 0,0,2
	la 9,.LC57@l(9)
	lwzx 30,10,0
	lfs 13,0(9)
	addi 9,30,1
	stwx 9,10,0
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L360
	lwz 0,284(31)
	andis. 5,0,0x1
	bc 4,2,.L361
	lwz 8,648(31)
	lis 11,.LC58@ha
	la 11,.LC58@l(11)
	lwz 9,264(31)
	lis 7,0x4330
	lwz 0,48(8)
	lis 6,compmod+4@ha
	lfd 13,0(11)
	oris 9,9,0x8000
	xoris 0,0,0x8000
	lwz 11,184(31)
	stw 0,20(1)
	stw 7,16(1)
	ori 11,11,1
	lfd 0,16(1)
	stw 9,264(31)
	stw 11,184(31)
	stw 5,248(31)
	fsub 0,0,13
	lwz 0,compmod+4@l(6)
	cmpwi 0,0,0
	frsp 31,0
	bc 12,2,.L364
	bl FindTimer
	mr. 3,3
	bc 12,2,.L364
	lis 9,level+4@ha
	lfs 12,288(3)
	lfs 13,level+4@l(9)
	fsubs 0,12,13
	fcmpu 0,0,31
	bc 4,0,.L365
	lis 9,.LC59@ha
	la 9,.LC59@l(9)
	lfs 0,0(9)
	fadds 0,12,0
	b .L363
.L365:
	fadds 0,13,31
	b .L363
.L364:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,31
.L363:
	lis 9,DoRespawn@ha
	stfs 0,428(31)
	lis 11,gi+72@ha
	la 9,DoRespawn@l(9)
	mr 3,31
	stw 9,436(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L361:
	cmpwi 0,30,0
	bc 4,2,.L360
	lwz 9,648(31)
	mr 3,29
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L360:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe14:
	.size	 Pickup_PowerArmor,.Lfe14-Pickup_PowerArmor
	.section	".rodata"
	.align 3
.LC60:
	.long 0x40080000
	.long 0x0
	.align 2
.LC61:
	.long 0x3f800000
	.align 2
.LC62:
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
	bc 12,2,.L373
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L373
	lwz 9,648(31)
	lwz 10,4(9)
	cmpwi 0,10,0
	bc 12,2,.L373
	lis 9,compmod+4@ha
	lwz 0,compmod+4@l(9)
	xori 11,0,3
	subfic 9,11,0
	adde 11,9,11
	xori 0,0,1
	subfic 9,0,0
	adde 0,9,0
	or. 9,0,11
	bc 4,2,.L373
	mtlr 10
	blrl
	mr. 28,3
	bc 12,2,.L378
	lwz 11,84(30)
	lis 0,0x3e80
	lis 9,gi@ha
	la 29,gi@l(9)
	stw 0,3644(11)
	lwz 9,648(31)
	lwz 11,40(29)
	lwz 3,36(9)
	mtlr 11
	blrl
	lis 9,itemlist@ha
	lwz 11,84(30)
	lis 8,0x38e3
	la 7,itemlist@l(9)
	ori 8,8,36409
	lis 9,.LC60@ha
	sth 3,134(11)
	lis 10,level+4@ha
	la 9,.LC60@l(9)
	lwz 11,84(30)
	lfd 13,0(9)
	lwz 9,648(31)
	subf 9,7,9
	mullw 9,9,8
	srawi 9,9,3
	addi 9,9,1056
	sth 9,136(11)
	lfs 0,level+4@l(10)
	lwz 9,84(30)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3764(9)
	lwz 9,648(31)
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 12,2,.L379
	subf 0,7,9
	lwz 11,84(30)
	mullw 0,0,8
	srawi 0,0,3
	extsh 9,0
	sth 0,144(11)
	stw 9,736(11)
.L379:
	lwz 9,648(31)
	lwz 11,36(29)
	lwz 3,20(9)
	mtlr 11
	blrl
	lis 9,.LC61@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC61@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC61@ha
	la 9,.LC61@l(9)
	lfs 2,0(9)
	lis 9,.LC62@ha
	la 9,.LC62@l(9)
	lfs 3,0(9)
	blrl
.L378:
	lwz 0,284(31)
	andis. 9,0,4
	bc 4,2,.L380
	mr 4,30
	mr 3,31
	bl G_UseTargets
	lwz 0,284(31)
	oris 0,0,0x4
	stw 0,284(31)
.L380:
	cmpwi 0,28,0
	bc 12,2,.L373
	lis 9,.LC62@ha
	lis 11,coop@ha
	la 9,.LC62@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L383
	lwz 9,648(31)
	lwz 0,56(9)
	andi. 9,0,8
	bc 12,2,.L383
	lwz 0,284(31)
	andis. 9,0,0x3
	bc 12,2,.L373
.L383:
	lwz 0,264(31)
	cmpwi 0,0,0
	bc 4,0,.L384
	rlwinm 0,0,0,1,31
	stw 0,264(31)
	b .L373
.L384:
	mr 3,31
	bl G_FreeEdict
.L373:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 Touch_Item,.Lfe15-Touch_Item
	.section	".rodata"
	.align 2
.LC63:
	.long 0x42c80000
	.align 2
.LC64:
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
	bc 12,2,.L391
	addi 29,1,24
	addi 4,1,8
	addi 3,3,3660
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
	b .L393
.L391:
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
.L393:
	stfs 0,12(31)
	lis 9,.LC63@ha
	addi 3,1,8
	la 9,.LC63@l(9)
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
	lis 9,.LC64@ha
	lfs 0,level+4@l(11)
	la 9,.LC64@l(9)
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
.Lfe16:
	.size	 Drop_Item,.Lfe16-Drop_Item
	.section	".rodata"
	.align 2
.LC65:
	.string	"droptofloor: %s startsolid at %s\n"
	.align 3
.LC66:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC67:
	.long 0xc1700000
	.align 2
.LC68:
	.long 0x41700000
	.align 2
.LC69:
	.long 0x0
	.align 2
.LC70:
	.long 0xc3000000
	.section	".text"
	.align 2
	.globl droptofloor
	.type	 droptofloor,@function
droptofloor:
	stwu 1,-112(1)
	mflr 0
	stmw 29,100(1)
	stw 0,116(1)
	lis 9,.LC67@ha
	lis 11,.LC67@ha
	la 9,.LC67@l(9)
	la 11,.LC67@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC67@ha
	lfs 2,0(11)
	la 9,.LC67@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC68@ha
	lfs 13,0(11)
	la 9,.LC68@l(9)
	lfs 1,0(9)
	lis 9,.LC68@ha
	stfs 13,188(31)
	la 9,.LC68@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC68@ha
	stfs 0,192(31)
	la 9,.LC68@l(9)
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
	bc 12,2,.L398
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L399
.L398:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L399:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC69@ha
	stw 9,444(31)
	addi 29,31,4
	la 11,.LC69@l(11)
	lis 9,.LC70@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC70@l(9)
	lis 11,.LC69@ha
	lfs 3,0(9)
	la 11,.LC69@l(11)
	lfs 2,0(11)
	bl tv
	mr 11,3
	lfs 11,4(31)
	lis 9,gi@ha
	lfs 0,0(11)
	la 30,gi@l(9)
	mr 8,31
	lfs 12,8(31)
	addi 3,1,8
	mr 4,29
	lfs 13,12(31)
	addi 5,31,188
	addi 6,31,200
	fadds 11,11,0
	lwz 10,48(30)
	addi 7,1,72
	li 9,3
	mtlr 10
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
	bc 12,2,.L400
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC65@ha
	la 3,.LC65@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L397
.L400:
	lwz 0,308(31)
	lfs 12,20(1)
	lfs 0,24(1)
	cmpwi 0,0,0
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L401
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
	bc 4,2,.L401
	lis 11,level+4@ha
	lis 10,.LC66@ha
	lfs 0,level+4@l(11)
	lis 9,DoRespawn@ha
	lfd 13,.LC66@l(10)
	la 9,DoRespawn@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L401:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L403
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
.L403:
	lwz 0,284(31)
	andi. 11,0,1
	bc 12,2,.L404
	lwz 0,184(31)
	lis 9,Use_Item@ha
	li 11,0
	la 9,Use_Item@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
.L404:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L397:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe17:
	.size	 droptofloor,.Lfe17-droptofloor
	.section	".rodata"
	.align 2
.LC71:
	.string	"PrecacheItem: %s has bad precache string"
	.align 2
.LC72:
	.string	"md2"
	.align 2
.LC73:
	.string	"sp2"
	.align 2
.LC74:
	.string	"wav"
	.align 2
.LC75:
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
	bc 12,2,.L405
	lwz 3,20(26)
	cmpwi 0,3,0
	bc 12,2,.L407
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L407:
	lwz 3,24(26)
	cmpwi 0,3,0
	bc 12,2,.L408
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L408:
	lwz 3,32(26)
	cmpwi 0,3,0
	bc 12,2,.L409
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L409:
	lwz 3,36(26)
	cmpwi 0,3,0
	bc 12,2,.L410
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
.L410:
	lwz 29,52(26)
	cmpwi 0,29,0
	bc 12,2,.L411
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L411
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L419
	mr 28,9
.L414:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L416
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L416
	mr 3,31
	b .L418
.L416:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L414
.L419:
	li 3,0
.L418:
	cmpw 0,3,26
	bc 12,2,.L411
	bl PrecacheItem
.L411:
	lwz 30,68(26)
	cmpwi 0,30,0
	bc 12,2,.L405
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 12,2,.L405
	lis 9,gi@ha
	addi 29,1,8
	la 27,gi@l(9)
	lis 24,.LC72@ha
	lis 25,.LC75@ha
.L425:
	rlwinm 9,0,0,0xff
	mr 31,30
	b .L439
.L428:
	lbzu 9,1(30)
.L439:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L428
	subf 28,31,30
	addi 0,28,-5
	cmplwi 0,0,58
	bc 4,1,.L430
	lwz 9,28(27)
	lis 3,.LC71@ha
	la 3,.LC71@l(3)
	lwz 4,0(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L430:
	mr 4,31
	mr 5,28
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 0,0
	addi 11,30,1
	stbx 0,29,28
	add 9,29,28
	la 4,.LC72@l(24)
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
	bc 12,2,.L440
	lis 4,.LC73@ha
	mr 3,31
	la 4,.LC73@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L434
.L440:
	lwz 9,32(27)
	mr 3,29
	mtlr 9
	blrl
	b .L433
.L434:
	lis 4,.LC74@ha
	mr 3,31
	la 4,.LC74@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L433
	lwz 9,36(27)
	mr 3,29
	mtlr 9
	blrl
.L433:
	add 3,29,28
	la 4,.LC75@l(25)
	addi 3,3,-3
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L423
	lwz 9,40(27)
	mr 3,29
	mtlr 9
	blrl
.L423:
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L425
.L405:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe18:
	.size	 PrecacheItem,.Lfe18-PrecacheItem
	.section	".rodata"
	.align 2
.LC76:
	.string	"%s at %s has invalid spawnflags set\n"
	.align 2
.LC77:
	.string	"weapon_bfg"
	.align 3
.LC78:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC79:
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
	bc 12,2,.L442
	lwz 3,280(31)
	lis 4,.LC30@ha
	la 4,.LC30@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L442
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
	lis 3,.LC76@ha
	la 3,.LC76@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L442:
	lis 9,.LC79@ha
	lis 11,deathmatch@ha
	la 9,.LC79@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L444
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2048
	bc 12,2,.L445
	lwz 0,4(30)
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L455
	lis 9,Pickup_PowerArmor@ha
	la 9,Pickup_PowerArmor@l(9)
	cmpw 0,0,9
	bc 12,2,.L455
.L445:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 12,2,.L448
	lwz 0,4(30)
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L455
.L448:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 12,2,.L450
	lwz 0,4(30)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L455
	lis 9,Pickup_Adrenaline@ha
	la 9,Pickup_Adrenaline@l(9)
	cmpw 0,0,9
	bc 12,2,.L455
	lis 9,Pickup_AncientHead@ha
	la 9,Pickup_AncientHead@l(9)
	cmpw 0,0,9
	bc 12,2,.L455
.L450:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8192
	bc 12,2,.L444
	lwz 0,56(30)
	cmpwi 0,0,2
	bc 12,2,.L455
	lwz 3,280(31)
	lis 4,.LC77@ha
	la 4,.LC77@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L444
.L455:
	mr 3,31
	bl G_FreeEdict
	b .L441
.L444:
	lis 11,.LC79@ha
	lis 9,coop@ha
	la 11,.LC79@l(11)
	lis 29,level@ha
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L456
	lwz 3,280(31)
	lis 4,.LC30@ha
	la 4,.LC30@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L456
	la 10,level@l(29)
	lwz 11,284(31)
	li 0,1
	lwz 9,300(10)
	addi 9,9,8
	slw 0,0,9
	or 11,11,0
	stw 11,284(31)
	lwz 9,300(10)
	addi 9,9,1
	stw 9,300(10)
.L456:
	lis 9,.LC79@ha
	lis 11,coop@ha
	la 9,.LC79@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L457
	lwz 0,56(30)
	andi. 11,0,8
	bc 12,2,.L457
	li 0,0
	stw 0,12(30)
.L457:
	stw 30,648(31)
	lis 11,level+4@ha
	lis 10,.LC78@ha
	lfs 0,level+4@l(11)
	lis 9,droptofloor@ha
	lfd 13,.LC78@l(10)
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
	bc 12,2,.L441
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L441:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 SpawnItem,.Lfe19-SpawnItem
	.globl itemlist
	.section	".data"
	.align 2
	.type	 itemlist,@object
itemlist:
	.long 0
	.space	68
	.long .LC80
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC81
	.long .LC82
	.long 1
	.long 0
	.long .LC83
	.long .LC84
	.long 3
	.long 0
	.long 0
	.long 4
	.long bodyarmor_info
	.long 3
	.long .LC85
	.long .LC86
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC81
	.long .LC87
	.long 1
	.long 0
	.long .LC88
	.long .LC89
	.long 3
	.long 0
	.long 0
	.long 4
	.long combatarmor_info
	.long 2
	.long .LC85
	.long .LC90
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC81
	.long .LC91
	.long 1
	.long 0
	.long .LC92
	.long .LC93
	.long 3
	.long 0
	.long 0
	.long 4
	.long jacketarmor_info
	.long 1
	.long .LC85
	.long .LC94
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC95
	.long .LC96
	.long 1
	.long 0
	.long .LC92
	.long .LC97
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long 4
	.long .LC85
	.long .LC98
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC99
	.long .LC100
	.long 1
	.long 0
	.long .LC101
	.long .LC102
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long .LC85
	.long .LC103
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC99
	.long .LC104
	.long 1
	.long 0
	.long .LC105
	.long .LC106
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long .LC107
	.long .LC108
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Blaster
	.long .LC109
	.long 0
	.long 0
	.long .LC110
	.long .LC111
	.long .LC112
	.long 0
	.long 0
	.long 0
	.long 9
	.long 0
	.long 0
	.long .LC113
	.long .LC114
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Shotgun
	.long .LC109
	.long .LC115
	.long 1
	.long .LC116
	.long .LC117
	.long .LC118
	.long 0
	.long 1
	.long .LC10
	.long 9
	.long 0
	.long 0
	.long .LC119
	.long .LC120
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_SuperShotgun
	.long .LC109
	.long .LC121
	.long 1
	.long .LC122
	.long .LC123
	.long .LC124
	.long 0
	.long 2
	.long .LC10
	.long 9
	.long 0
	.long 0
	.long .LC125
	.long .LC126
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Machinegun
	.long .LC109
	.long .LC127
	.long 1
	.long .LC128
	.long .LC129
	.long .LC130
	.long 0
	.long 1
	.long .LC9
	.long 9
	.long 0
	.long 0
	.long .LC131
	.long .LC132
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Chaingun
	.long .LC109
	.long .LC133
	.long 1
	.long .LC134
	.long .LC135
	.long .LC136
	.long 0
	.long 1
	.long .LC9
	.long 9
	.long 0
	.long 0
	.long .LC137
	.long .LC138
	.long Pickup_Ammo
	.long Use_Weapon
	.long Drop_Ammo
	.long Weapon_Grenade
	.long .LC139
	.long .LC140
	.long 0
	.long .LC141
	.long .LC142
	.long .LC15
	.long 3
	.long 5
	.long .LC143
	.long 3
	.long 0
	.long 3
	.long .LC144
	.long .LC145
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_GrenadeLauncher
	.long .LC109
	.long .LC146
	.long 1
	.long .LC147
	.long .LC148
	.long .LC149
	.long 0
	.long 1
	.long .LC15
	.long 9
	.long 0
	.long 0
	.long .LC150
	.long .LC151
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_RocketLauncher
	.long .LC109
	.long .LC152
	.long 1
	.long .LC153
	.long .LC154
	.long .LC155
	.long 0
	.long 1
	.long .LC16
	.long 9
	.long 0
	.long 0
	.long .LC156
	.long .LC157
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_HyperBlaster
	.long .LC109
	.long .LC158
	.long 1
	.long .LC159
	.long .LC160
	.long .LC161
	.long 0
	.long 1
	.long .LC14
	.long 9
	.long 0
	.long 0
	.long .LC162
	.long .LC163
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Railgun
	.long .LC109
	.long .LC164
	.long 1
	.long .LC165
	.long .LC166
	.long .LC167
	.long 0
	.long 1
	.long .LC17
	.long 9
	.long 0
	.long 0
	.long .LC168
	.long .LC77
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_BFG
	.long .LC109
	.long .LC169
	.long 1
	.long .LC170
	.long .LC171
	.long .LC172
	.long 0
	.long 50
	.long .LC14
	.long 9
	.long 0
	.long 0
	.long .LC173
	.long .LC174
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC139
	.long .LC175
	.long 0
	.long 0
	.long .LC176
	.long .LC10
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 1
	.long .LC85
	.long .LC177
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC139
	.long .LC178
	.long 0
	.long 0
	.long .LC179
	.long .LC9
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long .LC85
	.long .LC180
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC139
	.long .LC181
	.long 0
	.long 0
	.long .LC182
	.long .LC14
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 4
	.long .LC85
	.long .LC183
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC139
	.long .LC184
	.long 0
	.long 0
	.long .LC185
	.long .LC16
	.long 3
	.long 5
	.long 0
	.long 2
	.long 0
	.long 2
	.long .LC85
	.long .LC186
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC139
	.long .LC187
	.long 0
	.long 0
	.long .LC188
	.long .LC17
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 5
	.long .LC85
	.long .LC189
	.long Pickup_Powerup
	.long Use_Quad
	.long Drop_General
	.long 0
	.long .LC190
	.long .LC191
	.long 1
	.long 0
	.long .LC192
	.long .LC193
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long .LC194
	.long .LC195
	.long Pickup_Powerup
	.long Use_Invulnerability
	.long Drop_General
	.long 0
	.long .LC190
	.long .LC196
	.long 1
	.long 0
	.long .LC197
	.long .LC198
	.long 2
	.long 300
	.long 0
	.long 32
	.long 0
	.long 0
	.long .LC199
	.long .LC200
	.long Pickup_Powerup
	.long Use_Silencer
	.long Drop_General
	.long 0
	.long .LC190
	.long .LC201
	.long 1
	.long 0
	.long .LC202
	.long .LC203
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long .LC85
	.long .LC204
	.long Pickup_Powerup
	.long Use_Breather
	.long Drop_General
	.long 0
	.long .LC190
	.long .LC205
	.long 1
	.long 0
	.long .LC206
	.long .LC207
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long .LC208
	.long .LC209
	.long Pickup_Powerup
	.long Use_Envirosuit
	.long Drop_General
	.long 0
	.long .LC190
	.long .LC210
	.long 1
	.long 0
	.long .LC211
	.long .LC212
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long .LC208
	.long .LC213
	.long Pickup_AncientHead
	.long 0
	.long 0
	.long 0
	.long .LC190
	.long .LC214
	.long 1
	.long 0
	.long .LC215
	.long .LC216
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long .LC217
	.long Pickup_Adrenaline
	.long 0
	.long 0
	.long 0
	.long .LC190
	.long .LC218
	.long 1
	.long 0
	.long .LC219
	.long .LC220
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long .LC221
	.long Pickup_Bandolier
	.long 0
	.long 0
	.long 0
	.long .LC190
	.long .LC222
	.long 1
	.long 0
	.long .LC223
	.long .LC224
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long .LC225
	.long Pickup_Pack
	.long 0
	.long 0
	.long 0
	.long .LC190
	.long .LC226
	.long 1
	.long 0
	.long .LC227
	.long .LC228
	.long 2
	.long 180
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long .LC229
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC190
	.long .LC230
	.long 1
	.long 0
	.long .LC231
	.long .LC232
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC85
	.long .LC30
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC190
	.long .LC233
	.long 1
	.long 0
	.long .LC234
	.long .LC235
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC85
	.long .LC236
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC190
	.long .LC237
	.long 1
	.long 0
	.long .LC238
	.long .LC239
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC85
	.long .LC240
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC190
	.long .LC241
	.long 1
	.long 0
	.long .LC242
	.long .LC243
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC85
	.long .LC244
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC190
	.long .LC245
	.long 1
	.long 0
	.long .LC246
	.long .LC247
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC85
	.long .LC248
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC190
	.long .LC249
	.long 1
	.long 0
	.long .LC250
	.long .LC251
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC85
	.long .LC252
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC190
	.long .LC253
	.long 1
	.long 0
	.long .LC254
	.long .LC255
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC85
	.long .LC256
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC190
	.long .LC257
	.long 2
	.long 0
	.long .LC258
	.long .LC259
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC85
	.long .LC260
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC190
	.long .LC261
	.long 1
	.long 0
	.long .LC262
	.long .LC263
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long Pickup_Health
	.long 0
	.long 0
	.long 0
	.long .LC190
	.long 0
	.long 0
	.long 0
	.long .LC264
	.long .LC265
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.space	68
	.section	".rodata"
	.align 2
.LC265:
	.string	"Health"
	.align 2
.LC264:
	.string	"i_health"
	.align 2
.LC263:
	.string	"Airstrike Marker"
	.align 2
.LC262:
	.string	"i_airstrike"
	.align 2
.LC261:
	.string	"models/items/keys/target/tris.md2"
	.align 2
.LC260:
	.string	"key_airstrike_target"
	.align 2
.LC259:
	.string	"Commander's Head"
	.align 2
.LC258:
	.string	"k_comhead"
	.align 2
.LC257:
	.string	"models/monsters/commandr/head/tris.md2"
	.align 2
.LC256:
	.string	"key_commander_head"
	.align 2
.LC255:
	.string	"Red Key"
	.align 2
.LC254:
	.string	"k_redkey"
	.align 2
.LC253:
	.string	"models/items/keys/red_key/tris.md2"
	.align 2
.LC252:
	.string	"key_red_key"
	.align 2
.LC251:
	.string	"Blue Key"
	.align 2
.LC250:
	.string	"k_bluekey"
	.align 2
.LC249:
	.string	"models/items/keys/key/tris.md2"
	.align 2
.LC248:
	.string	"key_blue_key"
	.align 2
.LC247:
	.string	"Security Pass"
	.align 2
.LC246:
	.string	"k_security"
	.align 2
.LC245:
	.string	"models/items/keys/pass/tris.md2"
	.align 2
.LC244:
	.string	"key_pass"
	.align 2
.LC243:
	.string	"Data Spinner"
	.align 2
.LC242:
	.string	"k_dataspin"
	.align 2
.LC241:
	.string	"models/items/keys/spinner/tris.md2"
	.align 2
.LC240:
	.string	"key_data_spinner"
	.align 2
.LC239:
	.string	"Pyramid Key"
	.align 2
.LC238:
	.string	"k_pyramid"
	.align 2
.LC237:
	.string	"models/items/keys/pyramid/tris.md2"
	.align 2
.LC236:
	.string	"key_pyramid"
	.align 2
.LC235:
	.string	"Power Cube"
	.align 2
.LC234:
	.string	"k_powercube"
	.align 2
.LC233:
	.string	"models/items/keys/power/tris.md2"
	.align 2
.LC232:
	.string	"Data CD"
	.align 2
.LC231:
	.string	"k_datacd"
	.align 2
.LC230:
	.string	"models/items/keys/data_cd/tris.md2"
	.align 2
.LC229:
	.string	"key_data_cd"
	.align 2
.LC228:
	.string	"Ammo Pack"
	.align 2
.LC227:
	.string	"i_pack"
	.align 2
.LC226:
	.string	"models/items/pack/tris.md2"
	.align 2
.LC225:
	.string	"item_pack"
	.align 2
.LC224:
	.string	"Bandolier"
	.align 2
.LC223:
	.string	"p_bandolier"
	.align 2
.LC222:
	.string	"models/items/band/tris.md2"
	.align 2
.LC221:
	.string	"item_bandolier"
	.align 2
.LC220:
	.string	"Adrenaline"
	.align 2
.LC219:
	.string	"p_adrenaline"
	.align 2
.LC218:
	.string	"models/items/adrenal/tris.md2"
	.align 2
.LC217:
	.string	"item_adrenaline"
	.align 2
.LC216:
	.string	"Ancient Head"
	.align 2
.LC215:
	.string	"i_fixme"
	.align 2
.LC214:
	.string	"models/items/c_head/tris.md2"
	.align 2
.LC213:
	.string	"item_ancient_head"
	.align 2
.LC212:
	.string	"Environment Suit"
	.align 2
.LC211:
	.string	"p_envirosuit"
	.align 2
.LC210:
	.string	"models/items/enviro/tris.md2"
	.align 2
.LC209:
	.string	"item_enviro"
	.align 2
.LC208:
	.string	"items/airout.wav"
	.align 2
.LC207:
	.string	"Rebreather"
	.align 2
.LC206:
	.string	"p_rebreather"
	.align 2
.LC205:
	.string	"models/items/breather/tris.md2"
	.align 2
.LC204:
	.string	"item_breather"
	.align 2
.LC203:
	.string	"Silencer"
	.align 2
.LC202:
	.string	"p_silencer"
	.align 2
.LC201:
	.string	"models/items/silencer/tris.md2"
	.align 2
.LC200:
	.string	"item_silencer"
	.align 2
.LC199:
	.string	"items/protect.wav items/protect2.wav items/protect4.wav"
	.align 2
.LC198:
	.string	"Invulnerability"
	.align 2
.LC197:
	.string	"p_invulnerability"
	.align 2
.LC196:
	.string	"models/items/invulner/tris.md2"
	.align 2
.LC195:
	.string	"item_invulnerability"
	.align 2
.LC194:
	.string	"items/damage.wav items/damage2.wav items/damage3.wav"
	.align 2
.LC193:
	.string	"Quad Damage"
	.align 2
.LC192:
	.string	"p_quad"
	.align 2
.LC191:
	.string	"models/items/quaddama/tris.md2"
	.align 2
.LC190:
	.string	"items/pkup.wav"
	.align 2
.LC189:
	.string	"item_quad"
	.align 2
.LC188:
	.string	"a_slugs"
	.align 2
.LC187:
	.string	"models/items/ammo/slugs/medium/tris.md2"
	.align 2
.LC186:
	.string	"ammo_slugs"
	.align 2
.LC185:
	.string	"a_rockets"
	.align 2
.LC184:
	.string	"models/items/ammo/rockets/medium/tris.md2"
	.align 2
.LC183:
	.string	"ammo_rockets"
	.align 2
.LC182:
	.string	"a_cells"
	.align 2
.LC181:
	.string	"models/items/ammo/cells/medium/tris.md2"
	.align 2
.LC180:
	.string	"ammo_cells"
	.align 2
.LC179:
	.string	"a_bullets"
	.align 2
.LC178:
	.string	"models/items/ammo/bullets/medium/tris.md2"
	.align 2
.LC177:
	.string	"ammo_bullets"
	.align 2
.LC176:
	.string	"a_shells"
	.align 2
.LC175:
	.string	"models/items/ammo/shells/medium/tris.md2"
	.align 2
.LC174:
	.string	"ammo_shells"
	.align 2
.LC173:
	.string	"sprites/s_bfg1.sp2 sprites/s_bfg2.sp2 sprites/s_bfg3.sp2 weapons/bfg__f1y.wav weapons/bfg__l1a.wav weapons/bfg__x1b.wav weapons/bfg_hum.wav"
	.align 2
.LC172:
	.string	"BFG10K"
	.align 2
.LC171:
	.string	"w_bfg"
	.align 2
.LC170:
	.string	"models/weapons/v_bfg/tris.md2"
	.align 2
.LC169:
	.string	"models/weapons/g_bfg/tris.md2"
	.align 2
.LC168:
	.string	"weapons/rg_hum.wav"
	.align 2
.LC167:
	.string	"Railgun"
	.align 2
.LC166:
	.string	"w_railgun"
	.align 2
.LC165:
	.string	"models/weapons/v_rail/tris.md2"
	.align 2
.LC164:
	.string	"models/weapons/g_rail/tris.md2"
	.align 2
.LC163:
	.string	"weapon_railgun"
	.align 2
.LC162:
	.string	"weapons/hyprbu1a.wav weapons/hyprbl1a.wav weapons/hyprbf1a.wav weapons/hyprbd1a.wav misc/lasfly.wav"
	.align 2
.LC161:
	.string	"HyperBlaster"
	.align 2
.LC160:
	.string	"w_hyperblaster"
	.align 2
.LC159:
	.string	"models/weapons/v_hyperb/tris.md2"
	.align 2
.LC158:
	.string	"models/weapons/g_hyperb/tris.md2"
	.align 2
.LC157:
	.string	"weapon_hyperblaster"
	.align 2
.LC156:
	.string	"models/objects/rocket/tris.md2 weapons/rockfly.wav weapons/rocklf1a.wav weapons/rocklr1b.wav models/objects/debris2/tris.md2"
	.align 2
.LC155:
	.string	"Rocket Launcher"
	.align 2
.LC154:
	.string	"w_rlauncher"
	.align 2
.LC153:
	.string	"models/weapons/v_rocket/tris.md2"
	.align 2
.LC152:
	.string	"models/weapons/g_rocket/tris.md2"
	.align 2
.LC151:
	.string	"weapon_rocketlauncher"
	.align 2
.LC150:
	.string	"models/objects/grenade/tris.md2 weapons/grenlf1a.wav weapons/grenlr1b.wav weapons/grenlb1b.wav"
	.align 2
.LC149:
	.string	"Grenade Launcher"
	.align 2
.LC148:
	.string	"w_glauncher"
	.align 2
.LC147:
	.string	"models/weapons/v_launch/tris.md2"
	.align 2
.LC146:
	.string	"models/weapons/g_launch/tris.md2"
	.align 2
.LC145:
	.string	"weapon_grenadelauncher"
	.align 2
.LC144:
	.string	"weapons/hgrent1a.wav weapons/hgrena1b.wav weapons/hgrenc1b.wav weapons/hgrenb1a.wav weapons/hgrenb2a.wav "
	.align 2
.LC143:
	.string	"grenades"
	.align 2
.LC142:
	.string	"a_grenades"
	.align 2
.LC141:
	.string	"models/weapons/v_handgr/tris.md2"
	.align 2
.LC140:
	.string	"models/items/ammo/grenades/medium/tris.md2"
	.align 2
.LC139:
	.string	"misc/am_pkup.wav"
	.align 2
.LC138:
	.string	"ammo_grenades"
	.align 2
.LC137:
	.string	"weapons/chngnu1a.wav weapons/chngnl1a.wav weapons/machgf3b.wav` weapons/chngnd1a.wav"
	.align 2
.LC136:
	.string	"Chaingun"
	.align 2
.LC135:
	.string	"w_chaingun"
	.align 2
.LC134:
	.string	"models/weapons/v_chain/tris.md2"
	.align 2
.LC133:
	.string	"models/weapons/g_chain/tris.md2"
	.align 2
.LC132:
	.string	"weapon_chaingun"
	.align 2
.LC131:
	.string	"weapons/machgf1b.wav weapons/machgf2b.wav weapons/machgf3b.wav weapons/machgf4b.wav weapons/machgf5b.wav"
	.align 2
.LC130:
	.string	"Machinegun"
	.align 2
.LC129:
	.string	"w_machinegun"
	.align 2
.LC128:
	.string	"models/weapons/v_machn/tris.md2"
	.align 2
.LC127:
	.string	"models/weapons/g_machn/tris.md2"
	.align 2
.LC126:
	.string	"weapon_machinegun"
	.align 2
.LC125:
	.string	"weapons/sshotf1b.wav"
	.align 2
.LC124:
	.string	"Super Shotgun"
	.align 2
.LC123:
	.string	"w_sshotgun"
	.align 2
.LC122:
	.string	"models/weapons/v_shotg2/tris.md2"
	.align 2
.LC121:
	.string	"models/weapons/g_shotg2/tris.md2"
	.align 2
.LC120:
	.string	"weapon_supershotgun"
	.align 2
.LC119:
	.string	"weapons/shotgf1b.wav weapons/shotgr1b.wav"
	.align 2
.LC118:
	.string	"Shotgun"
	.align 2
.LC117:
	.string	"w_shotgun"
	.align 2
.LC116:
	.string	"models/weapons/v_shotg/tris.md2"
	.align 2
.LC115:
	.string	"models/weapons/g_shotg/tris.md2"
	.align 2
.LC114:
	.string	"weapon_shotgun"
	.align 2
.LC113:
	.string	"weapons/blastf1a.wav misc/lasfly.wav"
	.align 2
.LC112:
	.string	"Blaster"
	.align 2
.LC111:
	.string	"w_blaster"
	.align 2
.LC110:
	.string	"models/weapons/v_blast/tris.md2"
	.align 2
.LC109:
	.string	"misc/w_pkup.wav"
	.align 2
.LC108:
	.string	"weapon_blaster"
	.align 2
.LC107:
	.string	"misc/power2.wav misc/power1.wav"
	.align 2
.LC106:
	.string	"Power Shield"
	.align 2
.LC105:
	.string	"i_powershield"
	.align 2
.LC104:
	.string	"models/items/armor/shield/tris.md2"
	.align 2
.LC103:
	.string	"item_power_shield"
	.align 2
.LC102:
	.string	"Power Screen"
	.align 2
.LC101:
	.string	"i_powerscreen"
	.align 2
.LC100:
	.string	"models/items/armor/screen/tris.md2"
	.align 2
.LC99:
	.string	"misc/ar3_pkup.wav"
	.align 2
.LC98:
	.string	"item_power_screen"
	.align 2
.LC97:
	.string	"Armor Shard"
	.align 2
.LC96:
	.string	"models/items/armor/shard/tris.md2"
	.align 2
.LC95:
	.string	"misc/ar2_pkup.wav"
	.align 2
.LC94:
	.string	"item_armor_shard"
	.align 2
.LC93:
	.string	"Jacket Armor"
	.align 2
.LC92:
	.string	"i_jacketarmor"
	.align 2
.LC91:
	.string	"models/items/armor/jacket/tris.md2"
	.align 2
.LC90:
	.string	"item_armor_jacket"
	.align 2
.LC89:
	.string	"Combat Armor"
	.align 2
.LC88:
	.string	"i_combatarmor"
	.align 2
.LC87:
	.string	"models/items/armor/combat/tris.md2"
	.align 2
.LC86:
	.string	"item_armor_combat"
	.align 2
.LC85:
	.string	""
	.align 2
.LC84:
	.string	"Body Armor"
	.align 2
.LC83:
	.string	"i_bodyarmor"
	.align 2
.LC82:
	.string	"models/items/armor/body/tris.md2"
	.align 2
.LC81:
	.string	"misc/ar1_pkup.wav"
	.align 2
.LC80:
	.string	"item_armor_body"
	.size	 itemlist,3096
	.align 2
.LC266:
	.string	"models/items/healing/medium/tris.md2"
	.align 2
.LC267:
	.string	"models/items/healing/stimpack/tris.md2"
	.align 2
.LC268:
	.string	"models/items/healing/large/tris.md2"
	.align 2
.LC269:
	.string	"models/items/mega_h/tris.md2"
	.section	".text"
	.align 2
	.globl SetItemNames
	.type	 SetItemNames,@function
SetItemNames:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lwz 0,1556(10)
	cmpw 0,31,0
	bc 4,0,.L502
	lis 11,itemlist@ha
	lis 9,gi@ha
	la 11,itemlist@l(11)
	la 28,gi@l(9)
	mr 29,10
	addi 30,11,40
.L504:
	lwz 9,24(28)
	addi 3,31,1056
	lwz 4,0(30)
	addi 31,31,1
	mtlr 9
	addi 30,30,72
	blrl
	lwz 0,1556(29)
	cmpw 0,31,0
	bc 12,0,.L504
.L502:
	lis 9,game@ha
	lis 11,jacket_armor_index@ha
	la 10,game@l(9)
	li 30,0
	lwz 0,1556(10)
	la 27,jacket_armor_index@l(11)
	lis 9,.LC93@ha
	lis 11,itemlist@ha
	la 28,.LC93@l(9)
	cmpw 0,30,0
	la 31,itemlist@l(11)
	bc 4,0,.L513
	mr 29,10
.L508:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L510
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L510
	mr 11,31
	b .L512
.L510:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L508
.L513:
	li 11,0
.L512:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x38e3
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,36409
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,combat_armor_index@ha
	lis 10,.LC89@ha
	la 26,combat_armor_index@l(9)
	srawi 11,11,3
	la 28,.LC89@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L521
	mr 29,7
.L516:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L518
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L518
	mr 11,31
	b .L520
.L518:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L516
.L521:
	li 11,0
.L520:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x38e3
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,36409
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,body_armor_index@ha
	lis 10,.LC84@ha
	la 27,body_armor_index@l(9)
	srawi 11,11,3
	la 28,.LC84@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L529
	mr 29,7
.L524:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L526
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L526
	mr 11,31
	b .L528
.L526:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L524
.L529:
	li 11,0
.L528:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x38e3
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,36409
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,power_screen_index@ha
	lis 10,.LC102@ha
	la 26,power_screen_index@l(9)
	srawi 11,11,3
	la 28,.LC102@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L537
	mr 29,7
.L532:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L534
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L534
	mr 11,31
	b .L536
.L534:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L532
.L537:
	li 11,0
.L536:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x38e3
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,36409
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,power_shield_index@ha
	lis 10,.LC106@ha
	la 27,power_shield_index@l(9)
	srawi 11,11,3
	la 28,.LC106@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L545
	mr 29,7
.L540:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L542
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L542
	mr 8,31
	b .L544
.L542:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L540
.L545:
	li 8,0
.L544:
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,8
	mullw 9,9,0
	srawi 9,9,3
	stw 9,0(27)
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 SetItemNames,.Lfe20-SetItemNames
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
	.section	".text"
	.align 2
	.globl InitItems
	.type	 InitItems,@function
InitItems:
	lis 9,game+1556@ha
	li 0,42
	stw 0,game+1556@l(9)
	blr
.Lfe21:
	.size	 InitItems,.Lfe21-InitItems
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
	bc 4,0,.L19
	mr 28,9
.L21:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L20
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L20
	mr 3,31
	b .L546
.L20:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L21
.L19:
	li 3,0
.L546:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 FindItem,.Lfe22-FindItem
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
	bc 4,0,.L11
	mr 28,9
.L13:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L12
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L12
	mr 3,31
	b .L547
.L12:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L13
.L11:
	li 3,0
.L547:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 FindItemByClassname,.Lfe23-FindItemByClassname
	.section	".rodata"
	.align 2
.LC270:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl SetRespawn
	.type	 SetRespawn,@function
SetRespawn:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 31,20(1)
	stw 0,36(1)
	mr 31,3
	li 11,0
	fmr 31,1
	lwz 0,264(31)
	lis 10,compmod+4@ha
	lwz 9,184(31)
	oris 0,0,0x8000
	stw 11,248(31)
	ori 9,9,1
	stw 0,264(31)
	stw 9,184(31)
	lwz 0,compmod+4@l(10)
	cmpwi 0,0,0
	bc 12,2,.L40
	bl FindTimer
	mr. 3,3
	bc 12,2,.L40
	lis 9,level+4@ha
	lfs 13,288(3)
	lfs 1,level+4@l(9)
	fsubs 0,13,1
	fcmpu 0,0,31
	bc 4,0,.L41
	lis 9,.LC270@ha
	la 9,.LC270@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L39
.L41:
	fadds 0,1,31
	b .L39
.L40:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,31
.L39:
	lis 9,DoRespawn@ha
	stfs 0,428(31)
	lis 11,gi+72@ha
	la 9,DoRespawn@l(9)
	mr 3,31
	stw 9,436(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 SetRespawn,.Lfe24-SetRespawn
	.align 2
	.globl ArmorIndex
	.type	 ArmorIndex,@function
ArmorIndex:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L307
	li 3,0
	blr
.L307:
	lis 9,jacket_armor_index@ha
	addi 10,11,740
	lwz 3,jacket_armor_index@l(9)
	slwi 0,3,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bclr 12,1
	lis 9,combat_armor_index@ha
	lwz 3,combat_armor_index@l(9)
	slwi 0,3,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bclr 12,1
	lis 9,body_armor_index@ha
	lwz 11,body_armor_index@l(9)
	slwi 0,11,2
	lwzx 9,10,0
	srawi 3,9,31
	subf 3,9,3
	srawi 3,3,31
	and 3,11,3
	blr
.Lfe25:
	.size	 ArmorIndex,.Lfe25-ArmorIndex
	.align 2
	.globl PowerArmorType
	.type	 PowerArmorType,@function
PowerArmorType:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L342
.L550:
	li 3,0
	blr
.L342:
	lwz 0,264(3)
	andi. 9,0,4096
	bc 12,2,.L550
	lis 9,power_shield_index@ha
	addi 11,11,740
	lwz 0,power_shield_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L344
	lis 9,power_screen_index@ha
	lwz 0,power_screen_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	srawi 3,9,31
	subf 3,9,3
	srwi 3,3,31
	blr
.L344:
	li 3,2
	blr
.Lfe26:
	.size	 PowerArmorType,.Lfe26-PowerArmorType
	.align 2
	.globl GetItemByIndex
	.type	 GetItemByIndex,@function
GetItemByIndex:
	mr. 3,3
	bc 12,2,.L8
	lis 9,game+1556@ha
	lwz 0,game+1556@l(9)
	cmpw 0,3,0
	bc 12,0,.L7
.L8:
	li 3,0
	blr
.L7:
	mulli 0,3,72
	lis 3,itemlist@ha
	la 3,itemlist@l(3)
	add 3,0,3
	blr
.Lfe27:
	.size	 GetItemByIndex,.Lfe27-GetItemByIndex
	.comm	compmod,284,4
	.comm	team,221,1
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
	.globl DoRespawn
	.type	 DoRespawn,@function
DoRespawn:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,308(31)
	cmpwi 0,0,0
	bc 12,2,.L26
	lwz 30,564(31)
	li 29,0
	mr. 31,30
	bc 12,2,.L28
.L29:
	lwz 31,536(31)
	addi 29,29,1
	cmpwi 0,31,0
	bc 4,2,.L29
.L28:
	bl rand
	mr 31,30
	divw 0,3,29
	mullw 0,0,29
	subf. 3,0,3
	bc 4,1,.L26
	mr 29,3
.L34:
	addic. 29,29,-1
	lwz 31,536(31)
	bc 4,2,.L34
.L26:
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
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe28:
	.size	 DoRespawn,.Lfe28-DoRespawn
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
	lis 0,0x38e3
	lwz 11,84(28)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 29,9,29
	addi 11,11,740
	mullw 29,29,0
	mr 3,28
	srawi 29,29,3
	slwi 29,29,2
	lwzx 9,11,29
	addi 9,9,-1
	stwx 9,11,29
	bl ValidateSelectedItem
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 Drop_General,.Lfe29-Drop_General
	.section	".rodata"
	.align 2
.LC271:
	.long 0x0
	.align 3
.LC272:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC273:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Pickup_AncientHead
	.type	 Pickup_AncientHead,@function
Pickup_AncientHead:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stw 31,36(1)
	stw 0,52(1)
	lwz 9,484(4)
	mr 31,3
	addi 9,9,2
	stw 9,484(4)
	lwz 0,284(31)
	andis. 5,0,0x1
	bc 4,2,.L75
	lis 9,.LC271@ha
	lis 11,deathmatch@ha
	la 9,.LC271@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L75
	lwz 8,648(31)
	lis 11,.LC272@ha
	la 11,.LC272@l(11)
	lwz 9,264(31)
	lis 7,0x4330
	lwz 0,48(8)
	lis 6,compmod+4@ha
	lfd 13,0(11)
	oris 9,9,0x8000
	xoris 0,0,0x8000
	lwz 11,184(31)
	stw 0,28(1)
	stw 7,24(1)
	ori 11,11,1
	lfd 0,24(1)
	stw 9,264(31)
	stw 11,184(31)
	stw 5,248(31)
	fsub 0,0,13
	lwz 0,compmod+4@l(6)
	cmpwi 0,0,0
	frsp 31,0
	bc 12,2,.L78
	bl FindTimer
	mr. 3,3
	bc 12,2,.L78
	lis 9,level+4@ha
	lfs 12,288(3)
	lfs 13,level+4@l(9)
	fsubs 0,12,13
	fcmpu 0,0,31
	bc 4,0,.L79
	lis 9,.LC273@ha
	la 9,.LC273@l(9)
	lfs 0,0(9)
	fadds 0,12,0
	b .L77
.L79:
	fadds 0,13,31
	b .L77
.L78:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,31
.L77:
	lis 9,DoRespawn@ha
	stfs 0,428(31)
	lis 11,gi+72@ha
	la 9,DoRespawn@l(9)
	mr 3,31
	stw 9,436(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L75:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lwz 31,36(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe30:
	.size	 Pickup_AncientHead,.Lfe30-Pickup_AncientHead
	.section	".rodata"
	.align 3
.LC274:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC275:
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
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 4,9,4
	mr 29,3
	mullw 4,4,0
	lwz 11,84(29)
	srawi 4,4,3
	addi 11,11,740
	slwi 4,4,2
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC274@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC274@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3740(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L206
	lis 9,.LC275@ha
	la 9,.LC275@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L552
.L206:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L552:
	stfs 0,3740(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe31:
	.size	 Use_Breather,.Lfe31-Use_Breather
	.section	".rodata"
	.align 3
.LC276:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC277:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl Use_Envirosuit
	.type	 Use_Envirosuit,@function
Use_Envirosuit:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 4,9,4
	mr 29,3
	mullw 4,4,0
	lwz 11,84(29)
	srawi 4,4,3
	addi 11,11,740
	slwi 4,4,2
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC276@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC276@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3744(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L209
	lis 9,.LC277@ha
	la 9,.LC277@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L553
.L209:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L553:
	stfs 0,3744(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe32:
	.size	 Use_Envirosuit,.Lfe32-Use_Envirosuit
	.align 2
	.globl Use_Silencer
	.type	 Use_Silencer,@function
Use_Silencer:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 4,9,4
	mr 29,3
	mullw 4,4,0
	lwz 11,84(29)
	srawi 4,4,3
	addi 11,11,740
	slwi 4,4,2
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lwz 11,84(29)
	lwz 9,3756(11)
	addi 9,9,30
	stw 9,3756(11)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 Use_Silencer,.Lfe33-Use_Silencer
	.align 2
	.globl Drop_Ammo
	.type	 Drop_Ammo,@function
Drop_Ammo:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	mr 29,4
	la 9,itemlist@l(9)
	lis 0,0x38e3
	ori 0,0,36409
	subf 9,9,29
	mullw 9,9,0
	mr 31,3
	srawi 30,9,3
	bl Drop_Item
	lwz 9,84(31)
	slwi 0,30,2
	mr 11,3
	lwz 10,48(29)
	addi 9,9,740
	lwzx 0,9,0
	cmpw 0,0,10
	bc 12,0,.L270
	stw 10,532(11)
	b .L271
.L270:
	stw 0,532(11)
.L271:
	lwz 9,84(31)
	slwi 10,30,2
	mr 3,31
	lwz 11,532(11)
	addi 9,9,740
	lwzx 0,9,10
	subf 0,11,0
	stwx 0,9,10
	bl ValidateSelectedItem
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 Drop_Ammo,.Lfe34-Drop_Ammo
	.align 2
	.globl Drop_PowerArmor
	.type	 Drop_PowerArmor,@function
Drop_PowerArmor:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 0,264(31)
	andi. 9,0,4096
	bc 12,2,.L371
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,30
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,1
	bc 4,2,.L371
	bl Use_PowerArmor
.L371:
	mr 3,31
	mr 4,30
	bl Drop_Item
	lis 11,itemlist@ha
	lis 0,0x38e3
	lwz 10,84(31)
	la 11,itemlist@l(11)
	ori 0,0,36409
	subf 11,11,30
	addi 10,10,740
	mullw 11,11,0
	mr 3,31
	srawi 11,11,3
	slwi 11,11,2
	lwzx 9,10,11
	addi 9,9,-1
	stwx 9,10,11
	bl ValidateSelectedItem
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe35:
	.size	 Drop_PowerArmor,.Lfe35-Drop_PowerArmor
	.align 2
	.type	 drop_temp_touch,@function
drop_temp_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,256(3)
	cmpw 0,4,0
	bc 12,2,.L386
	bl Touch_Item
.L386:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe36:
	.size	 drop_temp_touch,.Lfe36-drop_temp_touch
	.section	".rodata"
	.align 2
.LC278:
	.long 0x0
	.align 2
.LC279:
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
	lis 9,.LC278@ha
	lfs 0,20(10)
	la 9,.LC278@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bclr 12,2
	lis 9,.LC279@ha
	lis 11,level+4@ha
	la 9,.LC279@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,436(3)
	stfs 0,428(3)
	blr
.Lfe37:
	.size	 drop_make_touchable,.Lfe37-drop_make_touchable
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
	bc 12,2,.L395
	li 0,2
	stw 11,444(3)
	stw 0,248(3)
	b .L396
.L395:
	lis 9,Touch_Item@ha
	li 0,1
	la 9,Touch_Item@l(9)
	stw 0,248(3)
	stw 9,444(3)
.L396:
	lis 9,gi+72@ha
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe38:
	.size	 Use_Item,.Lfe38-Use_Item
	.section	".rodata"
	.align 2
.LC280:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_item_health
	.type	 SP_item_health,@function
SP_item_health:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 11,.LC280@ha
	lis 9,deathmatch@ha
	la 11,.LC280@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L460
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L460
	bl G_FreeEdict
	b .L459
.L554:
	mr 4,31
	b .L467
.L460:
	lis 9,.LC266@ha
	li 0,10
	la 9,.LC266@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC265@ha
	lis 11,itemlist@ha
	la 27,.LC265@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L468
	mr 28,10
.L463:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L465
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L554
.L465:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L463
.L468:
	li 4,0
.L467:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC41@ha
	lwz 0,gi+36@l(9)
	la 3,.LC41@l(3)
	mtlr 0
	blrl
.L459:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe39:
	.size	 SP_item_health,.Lfe39-SP_item_health
	.section	".rodata"
	.align 2
.LC281:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_item_health_small
	.type	 SP_item_health_small,@function
SP_item_health_small:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 11,.LC281@ha
	lis 9,deathmatch@ha
	la 11,.LC281@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L470
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L470
	bl G_FreeEdict
	b .L469
.L555:
	mr 4,31
	b .L477
.L470:
	lis 9,.LC267@ha
	li 0,2
	la 9,.LC267@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC265@ha
	lis 11,itemlist@ha
	la 27,.LC265@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L478
	mr 28,10
.L473:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L475
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L555
.L475:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L473
.L478:
	li 4,0
.L477:
	mr 3,29
	bl SpawnItem
	li 0,1
	lis 9,gi+36@ha
	stw 0,644(29)
	lis 3,.LC40@ha
	lwz 0,gi+36@l(9)
	la 3,.LC40@l(3)
	mtlr 0
	blrl
.L469:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe40:
	.size	 SP_item_health_small,.Lfe40-SP_item_health_small
	.section	".rodata"
	.align 2
.LC282:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_item_health_large
	.type	 SP_item_health_large,@function
SP_item_health_large:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 11,.LC282@ha
	lis 9,deathmatch@ha
	la 11,.LC282@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L480
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L480
	bl G_FreeEdict
	b .L479
.L556:
	mr 4,31
	b .L487
.L480:
	lis 9,.LC268@ha
	li 0,25
	la 9,.LC268@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC265@ha
	lis 11,itemlist@ha
	la 27,.LC265@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L488
	mr 28,10
.L483:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L485
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L556
.L485:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L483
.L488:
	li 4,0
.L487:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC42@ha
	lwz 0,gi+36@l(9)
	la 3,.LC42@l(3)
	mtlr 0
	blrl
.L479:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe41:
	.size	 SP_item_health_large,.Lfe41-SP_item_health_large
	.section	".rodata"
	.align 2
.LC283:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_item_health_mega
	.type	 SP_item_health_mega,@function
SP_item_health_mega:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 11,.LC283@ha
	lis 9,deathmatch@ha
	la 11,.LC283@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L490
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L490
	bl G_FreeEdict
	b .L489
.L557:
	mr 4,31
	b .L497
.L490:
	lis 9,.LC269@ha
	li 0,100
	la 9,.LC269@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC265@ha
	lis 11,itemlist@ha
	la 27,.LC265@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L498
	mr 28,10
.L493:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L495
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L557
.L495:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L493
.L498:
	li 4,0
.L497:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC43@ha
	lwz 0,gi+36@l(9)
	la 3,.LC43@l(3)
	mtlr 0
	blrl
	li 0,3
	stw 0,644(29)
.L489:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe42:
	.size	 SP_item_health_mega,.Lfe42-SP_item_health_mega
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
