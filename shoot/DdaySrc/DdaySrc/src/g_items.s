	.file	"g_items.c"
gcc2_compiled.:
	.globl combatarmor_info
	.section	".data"
	.align 2
	.type	 combatarmor_info,@object
	.size	 combatarmor_info,20
combatarmor_info:
	.long 50
	.long 100
	.long 0x3f19999a
	.long 0x3e99999a
	.long 2
	.section	".rodata"
	.align 2
.LC0:
	.long 0x3f800000
	.align 2
.LC1:
	.long 0x40000000
	.align 2
.LC2:
	.long 0x0
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Powerup
	.type	 Pickup_Powerup,@function
Pickup_Powerup:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 12,3
	lis 9,itemlist@ha
	lwz 8,664(12)
	lis 11,skill@ha
	la 9,itemlist@l(9)
	lis 0,0xc4ec
	lwz 10,skill@l(11)
	lis 7,.LC0@ha
	ori 0,0,20165
	subf 9,9,8
	mullw 9,9,0
	mr 31,4
	la 7,.LC0@l(7)
	lfs 13,20(10)
	lwz 11,84(31)
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
	bc 4,2,.L55
	lis 7,.LC1@ha
	srawi 0,11,31
	la 7,.LC1@l(7)
	subf 0,11,0
	lfs 0,0(7)
	srwi 10,0,31
	fcmpu 7,13,0
	cror 31,30,29
	mfcr 9
	rlwinm 9,9,0,1
	and. 0,9,10
	bc 4,2,.L55
	lis 11,coop@ha
	lis 7,.LC2@ha
	lwz 9,coop@l(11)
	la 7,.LC2@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L50
	lwz 0,56(8)
	rlwinm 0,0,29,31,31
	and. 9,0,10
	bc 12,2,.L50
.L55:
	li 3,0
	b .L54
.L50:
	lwz 0,664(12)
	lis 9,itemlist@ha
	lis 11,0xc4ec
	la 9,itemlist@l(9)
	ori 11,11,20165
	lwz 10,84(31)
	subf 0,9,0
	lis 8,deathmatch@ha
	mullw 0,0,11
	addi 10,10,740
	lis 7,.LC2@ha
	lwz 11,deathmatch@l(8)
	la 7,.LC2@l(7)
	srawi 0,0,3
	lfs 13,0(7)
	slwi 0,0,2
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L51
	lwz 0,288(12)
	andis. 4,0,0x1
	bc 4,2,.L51
	lis 9,.LC3@ha
	lwz 11,664(12)
	la 9,.LC3@l(9)
	lis 7,0x4330
	lwz 0,268(12)
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
	stw 0,268(12)
	stw 9,20(1)
	ori 11,11,1
	stw 7,16(1)
	lfd 0,16(1)
	stw 11,184(12)
	stw 4,248(12)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,440(12)
	frsp 0,0
	fadds 13,13,0
	stfs 13,432(12)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L51:
	mr 3,31
	bl WeighPlayer
	li 3,1
.L54:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Pickup_Powerup,.Lfe1-Pickup_Powerup
	.section	".rodata"
	.align 2
.LC4:
	.string	"Bullets"
	.align 2
.LC5:
	.string	"Shells"
	.align 2
.LC6:
	.long 0x0
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Bandolier
	.type	 Pickup_Bandolier,@function
Pickup_Bandolier:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 28,4
	mr 29,3
	lwz 9,84(28)
	lwz 0,1764(9)
	cmpwi 0,0,249
	bc 12,1,.L64
	li 0,250
	stw 0,1764(9)
.L64:
	lwz 9,84(28)
	lwz 0,1768(9)
	cmpwi 0,0,149
	bc 12,1,.L65
	li 0,150
	stw 0,1768(9)
.L65:
	lwz 9,84(28)
	lwz 0,1784(9)
	cmpwi 0,0,249
	bc 12,1,.L66
	li 0,250
	stw 0,1784(9)
.L66:
	lwz 9,84(28)
	lwz 0,1788(9)
	cmpwi 0,0,74
	bc 12,1,.L67
	li 0,75
	stw 0,1788(9)
.L67:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC4@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC4@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L75
	mr 27,10
.L70:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L72
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L72
	mr 8,31
	b .L74
.L72:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L70
.L75:
	li 8,0
.L74:
	cmpwi 0,8,0
	bc 12,2,.L76
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(28)
	la 9,itemlist@l(9)
	ori 0,0,20165
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(28)
	lwz 11,1764(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L76
	stwx 11,9,8
.L76:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC5@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC5@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L85
	mr 27,10
.L80:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L82
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L82
	mr 8,31
	b .L84
.L82:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L80
.L85:
	li 8,0
.L84:
	cmpwi 0,8,0
	bc 12,2,.L86
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(28)
	la 9,itemlist@l(9)
	ori 0,0,20165
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(28)
	lwz 11,1768(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L86
	stwx 11,9,8
.L86:
	lwz 0,288(29)
	andis. 4,0,0x1
	bc 4,2,.L88
	lis 9,.LC6@ha
	lis 11,deathmatch@ha
	la 9,.LC6@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L88
	lis 9,.LC7@ha
	lwz 11,664(29)
	la 9,.LC7@l(9)
	lis 7,0x4330
	lwz 0,268(29)
	lfd 12,0(9)
	lis 6,level+4@ha
	lis 10,DoRespawn@ha
	lwz 9,48(11)
	oris 0,0,0x8000
	la 10,DoRespawn@l(10)
	lwz 11,184(29)
	lis 5,gi+72@ha
	mr 3,29
	xoris 9,9,0x8000
	stw 0,268(29)
	stw 9,20(1)
	ori 11,11,1
	stw 7,16(1)
	lfd 0,16(1)
	stw 11,184(29)
	stw 4,248(29)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,440(29)
	frsp 0,0
	fadds 13,13,0
	stfs 13,432(29)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L88:
	mr 3,28
	bl WeighPlayer
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Pickup_Bandolier,.Lfe2-Pickup_Bandolier
	.section	".rodata"
	.align 2
.LC8:
	.string	"Cells"
	.align 2
.LC9:
	.string	"Grenades"
	.align 2
.LC10:
	.string	"USA Grenade"
	.align 2
.LC11:
	.string	"Potato Masher"
	.align 2
.LC12:
	.string	"Rockets"
	.align 2
.LC13:
	.string	"Slugs"
	.align 2
.LC14:
	.long 0x0
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Pack
	.type	 Pickup_Pack,@function
Pickup_Pack:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 29,4
	mr 26,3
	lwz 9,84(29)
	lwz 0,1764(9)
	cmpwi 0,0,299
	bc 12,1,.L91
	li 0,300
	stw 0,1764(9)
.L91:
	lwz 9,84(29)
	lwz 0,1768(9)
	cmpwi 0,0,199
	bc 12,1,.L92
	li 0,200
	stw 0,1768(9)
.L92:
	lwz 9,84(29)
	lwz 0,1772(9)
	cmpwi 0,0,99
	bc 12,1,.L93
	li 0,100
	stw 0,1772(9)
.L93:
	lwz 9,84(29)
	lwz 0,1776(9)
	cmpwi 0,0,1
	bc 12,1,.L94
	li 0,2
	stw 0,1776(9)
.L94:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,0
	bc 12,1,.L95
	li 0,1
	stw 0,1780(9)
.L95:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,299
	bc 12,1,.L96
	li 0,300
	stw 0,1784(9)
.L96:
	lwz 9,84(29)
	lwz 0,1788(9)
	cmpwi 0,0,99
	bc 12,1,.L97
	li 0,100
	stw 0,1788(9)
.L97:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC4@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC4@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L105
	mr 28,10
.L100:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L102
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L102
	mr 8,31
	b .L104
.L102:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L100
.L105:
	li 8,0
.L104:
	cmpwi 0,8,0
	bc 12,2,.L106
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,20165
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
	bc 4,1,.L106
	stwx 11,9,8
.L106:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC5@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC5@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L115
	mr 28,10
.L110:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L112
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L112
	mr 8,31
	b .L114
.L112:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L110
.L115:
	li 8,0
.L114:
	cmpwi 0,8,0
	bc 12,2,.L116
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,20165
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
	bc 4,1,.L116
	stwx 11,9,8
.L116:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC8@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC8@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L125
	mr 28,10
.L120:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L122
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L122
	mr 8,31
	b .L124
.L122:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L120
.L125:
	li 8,0
.L124:
	cmpwi 0,8,0
	bc 12,2,.L126
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,20165
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
	lwz 11,1784(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L126
	stwx 11,9,8
.L126:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC9@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC9@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L135
	mr 28,10
.L130:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L132
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L132
	mr 8,31
	b .L134
.L132:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L130
.L135:
	li 8,0
.L134:
	cmpwi 0,8,0
	bc 12,2,.L136
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,20165
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
	bc 4,1,.L136
	stwx 11,9,8
.L136:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC10@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC10@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L145
	mr 28,10
.L140:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L142
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L142
	mr 8,31
	b .L144
.L142:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L140
.L145:
	li 8,0
.L144:
	cmpwi 0,8,0
	bc 12,2,.L146
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,20165
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
	bc 4,1,.L146
	stwx 11,9,8
.L146:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC11@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC11@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L155
	mr 28,10
.L150:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L152
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L152
	mr 8,31
	b .L154
.L152:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L150
.L155:
	li 8,0
.L154:
	cmpwi 0,8,0
	bc 12,2,.L156
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,20165
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
	bc 4,1,.L156
	stwx 11,9,8
.L156:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC12@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC12@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L165
	mr 28,10
.L160:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L162
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L162
	mr 8,31
	b .L164
.L162:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L160
.L165:
	li 8,0
.L164:
	cmpwi 0,8,0
	bc 12,2,.L166
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,20165
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
	bc 4,1,.L166
	stwx 11,9,8
.L166:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC13@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC13@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L175
	mr 28,10
.L170:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L172
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L172
	mr 8,31
	b .L174
.L172:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L170
.L175:
	li 8,0
.L174:
	cmpwi 0,8,0
	bc 12,2,.L176
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,20165
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
	lwz 11,1788(9)
	lwzx 0,4,8
	cmpw 0,0,11
	bc 4,1,.L176
	stwx 11,4,8
.L176:
	lwz 0,288(26)
	andis. 4,0,0x1
	bc 4,2,.L178
	lis 9,.LC14@ha
	lis 11,deathmatch@ha
	la 9,.LC14@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L178
	lis 9,.LC15@ha
	lwz 11,664(26)
	la 9,.LC15@l(9)
	lis 7,0x4330
	lwz 0,268(26)
	lfd 12,0(9)
	lis 6,level+4@ha
	lis 10,DoRespawn@ha
	lwz 9,48(11)
	oris 0,0,0x8000
	la 10,DoRespawn@l(10)
	lwz 11,184(26)
	lis 5,gi+72@ha
	mr 3,26
	xoris 9,9,0x8000
	stw 0,268(26)
	stw 9,20(1)
	ori 11,11,1
	stw 7,16(1)
	lfd 0,16(1)
	stw 11,184(26)
	stw 4,248(26)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,440(26)
	frsp 0,0
	fadds 13,13,0
	stfs 13,432(26)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L178:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 Pickup_Pack,.Lfe3-Pickup_Pack
	.section	".rodata"
	.align 2
.LC16:
	.string	"key_power_cube"
	.align 2
.LC17:
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
	lis 11,.LC17@ha
	lis 9,coop@ha
	la 11,.LC17@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 30,4
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L188
	lwz 3,284(31)
	lis 4,.LC16@ha
	la 4,.LC16@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L189
	lwz 0,664(31)
	lis 9,itemlist@ha
	lis 11,0xc4ec
	la 9,itemlist@l(9)
	ori 11,11,20165
	lwz 10,84(30)
	subf 0,9,0
	mullw 0,0,11
	addi 10,10,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	b .L193
.L189:
	lwz 0,664(31)
	lis 9,itemlist@ha
	lis 11,0xc4ec
	la 9,itemlist@l(9)
	ori 11,11,20165
	lwz 10,84(30)
	subf 0,9,0
	mullw 0,0,11
	addi 4,10,740
	srawi 0,0,3
	slwi 3,0,2
	lwzx 9,4,3
	cmpwi 0,9,0
	bc 12,2,.L191
	li 3,0
	b .L192
.L191:
	li 0,1
	stwx 0,4,3
	b .L193
.L188:
	lwz 0,664(31)
	lis 9,itemlist@ha
	lis 11,0xc4ec
	la 9,itemlist@l(9)
	ori 11,11,20165
	lwz 10,84(30)
	subf 0,9,0
	mr 3,30
	mullw 0,0,11
	addi 10,10,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	bl WeighPlayer
.L193:
	li 3,1
.L192:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 Pickup_Key,.Lfe4-Pickup_Key
	.section	".rodata"
	.align 2
.LC18:
	.string	"WARNING: in Add_Ammo %s has NULL ammo\n"
	.section	".text"
	.align 2
	.globl Add_Ammo
	.type	 Add_Ammo,@function
Add_Ammo:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,4
	lwz 4,84(3)
	cmpwi 0,4,0
	bc 12,2,.L223
	cmpwi 0,10,0
	bc 4,2,.L196
	lis 9,gi+4@ha
	lis 3,.LC18@ha
	lwz 0,gi+4@l(9)
	la 3,.LC18@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L223:
	li 3,0
	b .L219
.L196:
	lwz 0,64(10)
	cmpwi 0,0,0
	bc 12,2,.L221
	cmpwi 0,0,1
	bc 4,2,.L199
.L221:
	mr 11,4
	lwz 4,1764(4)
	b .L198
.L199:
	cmpwi 0,0,2
	bc 4,2,.L201
	mr 11,4
	lwz 4,1772(4)
	b .L198
.L201:
	cmpwi 0,0,3
	bc 4,2,.L203
	mr 11,4
	lwz 4,1776(4)
	b .L198
.L203:
	cmpwi 0,0,4
	bc 4,2,.L205
	mr 11,4
	lwz 4,1780(4)
	b .L198
.L205:
	cmpwi 0,0,6
	bc 12,2,.L222
	cmpwi 0,0,5
	bc 4,2,.L209
.L222:
	mr 11,4
	lwz 4,1784(4)
	b .L198
.L209:
	cmpwi 0,0,7
	bc 4,2,.L211
	mr 11,4
	lwz 4,1788(4)
	b .L198
.L211:
	cmpwi 0,0,8
	bc 4,2,.L213
	lwz 9,84(3)
	mr 11,9
	lwz 4,1788(9)
	b .L198
.L213:
	cmpwi 0,0,9
	bc 4,2,.L223
	lwz 9,84(3)
	lwz 4,1792(9)
	mr 11,9
.L198:
	lis 9,itemlist@ha
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 9,9,10
	mullw 9,9,0
	addi 10,11,740
	srawi 9,9,3
	slwi 11,9,2
	lwzx 0,10,11
	cmpw 0,0,4
	bc 12,2,.L223
	add 0,0,5
	stwx 0,10,11
	lwz 9,84(3)
	addi 9,9,740
	lwzx 0,9,11
	cmpw 0,0,4
	bc 4,1,.L218
	stwx 4,9,11
.L218:
	bl WeighPlayer
	li 3,1
.L219:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe5:
	.size	 Add_Ammo,.Lfe5-Add_Ammo
	.section	".rodata"
	.align 2
.LC19:
	.string	"colt45"
	.align 2
.LC20:
	.long 0x0
	.align 2
.LC21:
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
	mr 29,3
	mr 27,4
	lwz 4,664(29)
	lwz 0,56(4)
	andi. 30,0,1
	bc 12,2,.L225
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8192
	li 5,1000
	bc 4,2,.L226
.L225:
	lwz 5,536(29)
	cmpwi 0,5,0
	bc 12,2,.L227
	lwz 4,664(29)
	b .L226
.L227:
	lwz 9,664(29)
	lwz 5,48(9)
	mr 4,9
.L226:
	lis 10,itemlist@ha
	lis 9,0xc4ec
	lwz 11,84(27)
	la 28,itemlist@l(10)
	ori 9,9,20165
	subf 0,28,4
	addi 11,11,740
	mullw 0,0,9
	mr 3,27
	srawi 0,0,3
	slwi 0,0,2
	lwzx 31,11,0
	bl Add_Ammo
	cmpwi 0,3,0
	bc 4,2,.L229
	li 3,0
	b .L243
.L244:
	mr 9,31
	b .L239
.L229:
	subfic 9,31,0
	adde 0,9,31
	and. 11,30,0
	bc 12,2,.L230
	lwz 25,84(27)
	lwz 9,664(29)
	lwz 0,1796(25)
	cmpw 0,0,9
	bc 12,2,.L230
	lis 9,.LC20@ha
	lis 11,deathmatch@ha
	la 9,.LC20@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L232
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC19@ha
	lwz 0,1556(9)
	la 26,.LC19@l(11)
	mr 31,28
	cmpw 0,30,0
	bc 4,0,.L240
	mr 28,9
.L235:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L237
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L244
.L237:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L235
.L240:
	li 9,0
.L239:
	lwz 0,1796(25)
	cmpw 0,0,9
	bc 4,2,.L230
.L232:
	lwz 9,84(27)
	lwz 0,664(29)
	stw 0,4148(9)
.L230:
	lwz 0,288(29)
	andis. 7,0,0x3
	bc 4,2,.L241
	lis 9,.LC20@ha
	lis 11,deathmatch@ha
	la 9,.LC20@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L241
	lwz 9,268(29)
	lis 11,.LC21@ha
	lis 10,level+4@ha
	lwz 0,184(29)
	la 11,.LC21@l(11)
	lis 8,gi+72@ha
	oris 9,9,0x8000
	stw 7,248(29)
	mr 3,29
	ori 0,0,1
	stw 9,268(29)
	stw 0,184(29)
	lfs 0,level+4@l(10)
	lfs 13,0(11)
	lis 11,DoRespawn@ha
	la 11,DoRespawn@l(11)
	fadds 0,0,13
	stw 11,440(29)
	stfs 0,432(29)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
.L241:
	mr 3,27
	bl WeighPlayer
	li 3,1
.L243:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 Pickup_Ammo,.Lfe6-Pickup_Ammo
	.section	".rodata"
	.align 2
.LC22:
	.string	"items/s_health.wav"
	.align 2
.LC23:
	.string	"items/n_health.wav"
	.align 2
.LC24:
	.string	"items/l_health.wav"
	.align 2
.LC25:
	.string	"items/m_health.wav"
	.align 2
.LC26:
	.long 0x0
	.align 3
.LC27:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC28:
	.long 0x40a00000
	.align 2
.LC29:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Pickup_Health
	.type	 Pickup_Health,@function
Pickup_Health:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 0,660(31)
	andi. 8,0,1
	bc 4,2,.L258
	lwz 9,484(30)
	lwz 0,488(30)
	cmpw 0,9,0
	bc 12,0,.L258
	lis 9,level+4@ha
	lfs 13,988(30)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L258
	li 3,0
	b .L276
.L258:
	lis 9,.LC26@ha
	lfs 0,988(30)
	la 9,.LC26@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 12,2,.L261
	bl rand
	lis 0,0x51eb
	srawi 9,3,31
	lwz 11,536(31)
	ori 0,0,34079
	mulhw 0,3,0
	srawi 0,0,5
	subf 0,9,0
	mulli 0,0,100
	subf 3,0,3
	cmpw 0,3,11
	bc 4,0,.L262
	stfs 31,988(30)
	b .L261
.L262:
	xoris 11,11,0x8000
	lfs 12,988(30)
	stw 11,12(1)
	lis 0,0x4330
	lis 8,.LC27@ha
	la 8,.LC27@l(8)
	stw 0,8(1)
	lfd 13,0(8)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fsubs 12,12,0
	stfs 12,988(30)
.L261:
	lwz 0,484(30)
	lwz 9,536(31)
	add 0,0,9
	stw 0,484(30)
	lwz 0,536(31)
	cmpwi 0,0,2
	bc 4,2,.L264
	lwz 11,664(31)
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	b .L277
.L264:
	cmpwi 0,0,10
	bc 4,2,.L266
	lwz 11,664(31)
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	b .L277
.L266:
	cmpwi 0,0,25
	bc 4,2,.L268
	lwz 11,664(31)
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	b .L277
.L268:
	lwz 11,664(31)
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
.L277:
	stw 9,20(11)
	lwz 0,660(31)
	andi. 9,0,1
	bc 4,2,.L270
	lwz 0,484(30)
	lwz 9,488(30)
	cmpw 0,0,9
	bc 4,1,.L270
	stw 9,484(30)
.L270:
	lwz 0,660(31)
	andi. 11,0,2
	bc 12,2,.L272
	lis 9,MegaHealth_think@ha
	lis 8,.LC28@ha
	lwz 11,268(31)
	la 9,MegaHealth_think@l(9)
	lis 10,level+4@ha
	lwz 0,184(31)
	stw 9,440(31)
	la 8,.LC28@l(8)
	oris 11,11,0x8000
	lfs 0,level+4@l(10)
	li 9,0
	ori 0,0,1
	lfs 13,0(8)
	stw 9,248(31)
	stw 30,256(31)
	fadds 0,0,13
	stw 11,268(31)
	stw 0,184(31)
	stfs 0,432(31)
	b .L273
.L272:
	lwz 0,288(31)
	andis. 7,0,0x1
	bc 4,2,.L273
	lis 9,.LC26@ha
	lis 11,deathmatch@ha
	la 9,.LC26@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L273
	lwz 9,268(31)
	lis 11,.LC29@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC29@l(11)
	lis 8,gi+72@ha
	oris 9,9,0x8000
	stw 7,248(31)
	mr 3,31
	ori 0,0,1
	stw 9,268(31)
	stw 0,184(31)
	lfs 0,level+4@l(10)
	lfs 13,0(11)
	lis 11,DoRespawn@ha
	la 11,DoRespawn@l(11)
	fadds 0,0,13
	stw 11,440(31)
	stfs 0,432(31)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
.L273:
	li 3,1
.L276:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 Pickup_Health,.Lfe7-Pickup_Health
	.section	".rodata"
	.align 2
.LC30:
	.string	"misc/power2.wav"
	.align 2
.LC31:
	.string	"cells"
	.align 2
.LC32:
	.string	"No cells for power armor.\n"
	.align 2
.LC33:
	.string	"misc/power1.wav"
	.align 2
.LC34:
	.long 0x3f800000
	.align 2
.LC35:
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
	lwz 0,268(30)
	andi. 9,0,4096
	bc 12,2,.L284
	rlwinm 0,0,0,20,18
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,268(30)
	lis 3,.LC30@ha
	lwz 9,36(29)
	la 3,.LC30@l(3)
	mtlr 9
	blrl
	lis 9,.LC34@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC34@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	lfs 2,0(9)
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 3,0(9)
	blrl
	b .L283
.L295:
	mr 10,29
	b .L292
.L284:
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lis 11,.LC31@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC31@l(11)
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L293
	mr 28,10
.L288:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L290
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L295
.L290:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,104
	cmpw 0,31,0
	bc 12,0,.L288
.L293:
	li 10,0
.L292:
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L294
	lis 9,gi+8@ha
	lis 5,.LC32@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC32@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L283
.L294:
	lwz 0,268(30)
	lis 29,gi@ha
	lis 3,.LC33@ha
	la 29,gi@l(29)
	la 3,.LC33@l(3)
	ori 0,0,4096
	stw 0,268(30)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC34@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC34@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	lfs 2,0(9)
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 3,0(9)
	blrl
.L283:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 Use_PowerArmor,.Lfe8-Use_PowerArmor
	.section	".rodata"
	.align 2
.LC36:
	.long 0x0
	.align 3
.LC37:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_PowerArmor
	.type	 Pickup_PowerArmor,@function
Pickup_PowerArmor:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lis 9,itemlist@ha
	lwz 0,664(31)
	la 9,itemlist@l(9)
	lis 11,0xc4ec
	ori 11,11,20165
	mr 29,4
	subf 0,9,0
	lwz 10,84(29)
	mullw 0,0,11
	lis 9,deathmatch@ha
	lwz 8,deathmatch@l(9)
	addi 10,10,740
	srawi 0,0,3
	lis 9,.LC36@ha
	slwi 0,0,2
	la 9,.LC36@l(9)
	lwzx 30,10,0
	lfs 13,0(9)
	addi 9,30,1
	stwx 9,10,0
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L297
	lwz 0,288(31)
	andis. 4,0,0x1
	bc 4,2,.L298
	lis 9,.LC37@ha
	lwz 11,664(31)
	la 9,.LC37@l(9)
	lis 7,0x4330
	lwz 0,268(31)
	lfd 12,0(9)
	lis 6,level+4@ha
	lis 10,DoRespawn@ha
	lwz 9,48(11)
	oris 0,0,0x8000
	la 10,DoRespawn@l(10)
	lwz 11,184(31)
	lis 5,gi+72@ha
	xoris 9,9,0x8000
	stw 0,268(31)
	stw 9,28(1)
	ori 11,11,1
	stw 7,24(1)
	lfd 0,24(1)
	stw 11,184(31)
	stw 4,248(31)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,440(31)
	frsp 0,0
	fadds 13,13,0
	stfs 13,432(31)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L298:
	cmpwi 0,30,0
	bc 4,2,.L297
	lwz 9,664(31)
	mr 3,29
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L297:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 Pickup_PowerArmor,.Lfe9-Pickup_PowerArmor
	.section	".rodata"
	.align 2
.LC38:
	.string	"hgrenade"
	.align 2
.LC39:
	.string	"Helmet"
	.align 3
.LC40:
	.long 0x40080000
	.long 0x0
	.align 2
.LC41:
	.long 0x3f800000
	.align 2
.LC42:
	.long 0x0
	.section	".text"
	.align 2
	.globl Touch_Item
	.type	 Touch_Item,@function
Touch_Item:
	stwu 1,-32(1)
	mflr 0
	mfcr 12
	stmw 29,20(1)
	stw 0,36(1)
	stw 12,16(1)
	mr 30,4
	mr 31,3
	lwz 9,84(30)
	cmpwi 0,9,0
	bc 12,2,.L305
	lwz 0,484(30)
	cmpwi 0,0,0
	bc 4,1,.L305
	lwz 3,664(31)
	lwz 0,4(3)
	cmpwi 0,0,0
	bc 12,2,.L305
	lwz 0,3476(9)
	cmpwi 0,0,0
	bc 4,2,.L309
	lwz 3,0(3)
	lis 4,.LC38@ha
	la 4,.LC38@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L305
.L309:
	lwz 9,664(31)
	lwz 3,40(9)
	cmpwi 0,3,0
	bc 12,2,.L310
	lis 4,.LC39@ha
	la 4,.LC39@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L310
	lwz 0,664(31)
	lis 9,itemlist@ha
	lis 11,0xc4ec
	la 9,itemlist@l(9)
	ori 11,11,20165
	lwz 10,84(30)
	subf 0,9,0
	mullw 0,0,11
	addi 10,10,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L305
.L310:
	lwz 9,664(31)
	lwz 0,96(9)
	mr 10,9
	cmpwi 0,0,0
	bc 12,2,.L312
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L305
.L312:
	lwz 0,68(10)
	cmpwi 0,0,12
	bc 12,2,.L313
	lwz 0,536(31)
	cmpwi 0,0,1
	bc 4,1,.L313
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L305
.L313:
	lwz 0,4(10)
	mr 3,31
	mr 4,30
	mtlr 0
	blrl
	cmpwi 4,3,0
	bc 12,18,.L314
	lwz 9,664(31)
	lis 29,gi@ha
	la 29,gi@l(29)
	lwz 3,36(9)
	lwz 9,40(29)
	mtlr 9
	blrl
	lwz 9,84(30)
	lis 11,itemlist@ha
	lis 0,0xc4ec
	la 11,itemlist@l(11)
	ori 0,0,20165
	sth 3,134(9)
	lis 8,level+4@ha
	lis 9,.LC40@ha
	lwz 10,84(30)
	la 9,.LC40@l(9)
	lfd 13,0(9)
	lwz 9,664(31)
	subf 9,11,9
	mullw 9,9,0
	srawi 9,9,3
	addi 9,9,1056
	sth 9,136(10)
	lfs 0,level+4@l(8)
	lwz 11,84(30)
	fadd 0,0,13
	frsp 0,0
	stfs 0,4376(11)
	lwz 9,664(31)
	lwz 11,36(29)
	lwz 3,20(9)
	mtlr 11
	blrl
	lis 9,.LC41@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC41@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 2,0(9)
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 3,0(9)
	blrl
.L314:
	lwz 0,288(31)
	andis. 9,0,4
	bc 4,2,.L315
	mr 4,30
	mr 3,31
	bl G_UseTargets
	lwz 0,288(31)
	oris 0,0,0x4
	stw 0,288(31)
.L315:
	bc 12,18,.L305
	lis 9,.LC42@ha
	lis 11,coop@ha
	la 9,.LC42@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L318
	lwz 9,664(31)
	lwz 0,56(9)
	andi. 9,0,8
	bc 12,2,.L318
	lwz 0,288(31)
	andis. 9,0,0x3
	bc 12,2,.L305
.L318:
	lwz 0,268(31)
	cmpwi 0,0,0
	bc 4,0,.L319
	rlwinm 0,0,0,1,31
	stw 0,268(31)
	b .L305
.L319:
	mr 3,31
	bl G_FreeEdict
.L305:
	lwz 0,36(1)
	lwz 12,16(1)
	mtlr 0
	lmw 29,20(1)
	mtcrf 8,12
	la 1,32(1)
	blr
.Lfe10:
	.size	 Touch_Item,.Lfe10-Touch_Item
	.section	".rodata"
	.align 2
.LC43:
	.long 0x42c80000
	.align 2
.LC44:
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
	stw 0,288(31)
	lis 11,0xc170
	lis 10,0x4170
	stw 9,284(31)
	li 8,512
	stw 29,664(31)
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
	stw 0,264(31)
	stw 9,448(31)
	lwz 28,84(30)
	cmpwi 0,28,0
	bc 12,2,.L326
	addi 29,1,24
	addi 4,1,8
	addi 3,28,4264
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
	b .L328
.L326:
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
	stw 28,56(31)
.L328:
	stfs 0,12(31)
	lis 9,.LC43@ha
	addi 3,1,8
	la 9,.LC43@l(9)
	addi 4,31,380
	lfs 1,0(9)
	bl VectorScale
	lis 9,drop_make_touchable@ha
	lis 0,0x4396
	la 9,drop_make_touchable@l(9)
	stw 0,388(31)
	lis 11,level+4@ha
	stw 9,440(31)
	mr 3,31
	lis 9,.LC44@ha
	lfs 0,level+4@l(11)
	la 9,.LC44@l(9)
	lfs 13,0(9)
	lis 9,gi+72@ha
	fadds 0,0,13
	stfs 0,432(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	lwz 0,148(1)
	mtlr 0
	lmw 26,120(1)
	la 1,144(1)
	blr
.Lfe11:
	.size	 Drop_Item,.Lfe11-Drop_Item
	.section	".rodata"
	.align 2
.LC45:
	.string	"droptofloor: %s startsolid at %s\n"
	.align 3
.LC46:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC47:
	.long 0xc1700000
	.align 2
.LC48:
	.long 0x41700000
	.align 2
.LC49:
	.long 0x0
	.align 2
.LC50:
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
	lis 9,.LC47@ha
	lis 11,.LC47@ha
	la 9,.LC47@l(9)
	la 11,.LC47@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC47@ha
	lfs 2,0(11)
	la 9,.LC47@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC48@ha
	lfs 13,0(11)
	la 9,.LC48@l(9)
	lfs 1,0(9)
	lis 9,.LC48@ha
	stfs 13,188(31)
	la 9,.LC48@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC48@ha
	stfs 0,192(31)
	la 9,.LC48@l(9)
	lfs 13,8(11)
	lfs 3,0(9)
	stfs 13,196(31)
	bl tv
	mr 11,3
	lwz 4,272(31)
	lfs 13,0(11)
	cmpwi 0,4,0
	stfs 13,200(31)
	lfs 0,4(11)
	stfs 0,204(31)
	lfs 13,8(11)
	stfs 13,208(31)
	bc 12,2,.L333
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L334
.L333:
	lis 9,gi+44@ha
	lwz 11,664(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L334:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC49@ha
	stw 9,448(31)
	addi 29,31,4
	la 11,.LC49@l(11)
	lis 9,.LC50@ha
	stw 0,264(31)
	lfs 1,0(11)
	la 9,.LC50@l(9)
	lis 11,.LC49@ha
	lfs 3,0(9)
	la 11,.LC49@l(11)
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
	bc 12,2,.L335
	mr 3,29
	lwz 29,284(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC45@ha
	la 3,.LC45@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L332
.L335:
	lwz 0,312(31)
	lfs 12,20(1)
	lfs 0,24(1)
	cmpwi 0,0,0
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L336
	lwz 11,572(31)
	lwz 0,268(31)
	lwz 9,184(31)
	cmpw 0,31,11
	lwz 10,568(31)
	rlwinm 0,0,0,22,20
	ori 9,9,1
	stw 0,268(31)
	stw 10,544(31)
	stw 9,184(31)
	stw 8,248(31)
	stw 8,568(31)
	bc 4,2,.L336
	lis 11,level+4@ha
	lis 10,.LC46@ha
	lfs 0,level+4@l(11)
	lis 9,DoRespawn@ha
	lfd 13,.LC46@l(10)
	la 9,DoRespawn@l(9)
	stw 9,440(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(31)
.L336:
	lwz 0,288(31)
	andi. 9,0,2
	bc 12,2,.L338
	lwz 9,64(31)
	li 11,2
	li 10,0
	lwz 0,68(31)
	rlwinm 9,9,0,0,30
	stw 11,248(31)
	rlwinm 0,0,0,23,21
	stw 10,448(31)
	stw 9,64(31)
	stw 0,68(31)
.L338:
	lwz 0,288(31)
	andi. 11,0,1
	bc 12,2,.L339
	lwz 0,184(31)
	lis 9,Use_Item@ha
	li 11,0
	la 9,Use_Item@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,452(31)
	stw 0,184(31)
.L339:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L332:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe12:
	.size	 droptofloor,.Lfe12-droptofloor
	.section	".rodata"
	.align 2
.LC51:
	.string	"PrecacheItem: %s has bad precache string"
	.align 2
.LC52:
	.string	"md2"
	.align 2
.LC53:
	.string	"sp2"
	.align 2
.LC54:
	.string	"wav"
	.align 2
.LC55:
	.string	"pcx"
	.section	".text"
	.align 2
	.globl PrecacheItem
	.type	 PrecacheItem,@function
PrecacheItem:
	stwu 1,-112(1)
	mflr 0
	stmw 25,84(1)
	stw 0,116(1)
	mr. 26,3
	bc 12,2,.L340
	lwz 3,20(26)
	cmpwi 0,3,0
	bc 12,2,.L342
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L342:
	lwz 3,24(26)
	cmpwi 0,3,0
	bc 12,2,.L343
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L343:
	lwz 3,32(26)
	cmpwi 0,3,0
	bc 12,2,.L344
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L344:
	lwz 3,36(26)
	cmpwi 0,3,0
	bc 12,2,.L345
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
.L345:
	lwz 29,52(26)
	cmpwi 0,29,0
	bc 12,2,.L346
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L346
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L354
	mr 28,9
.L349:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L351
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L351
	mr 3,31
	b .L353
.L351:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L349
.L354:
	li 3,0
.L353:
	cmpw 0,3,26
	bc 12,2,.L346
	bl PrecacheItem
.L346:
	lwz 30,92(26)
	cmpwi 0,30,0
	bc 12,2,.L340
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 12,2,.L340
	lis 9,gi@ha
	addi 29,1,8
	la 27,gi@l(9)
	lis 25,.LC52@ha
.L360:
	rlwinm 9,0,0,0xff
	mr 28,30
	b .L375
.L363:
	lbzu 9,1(30)
.L375:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L363
	subf 31,28,30
	addi 0,31,-5
	cmplwi 0,0,58
	bc 4,1,.L365
	lwz 9,28(27)
	lis 3,.LC51@ha
	la 3,.LC51@l(3)
	lwz 4,0(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L365:
	mr 5,31
	mr 4,28
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 0,0
	addi 11,30,1
	stbx 0,29,31
	add 9,29,31
	la 4,.LC52@l(25)
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
	bc 4,2,.L367
	lwz 9,32(27)
	b .L376
.L367:
	lis 4,.LC53@ha
	mr 3,31
	la 4,.LC53@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L369
	lwz 9,32(27)
	b .L376
.L369:
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L371
	lwz 9,36(27)
.L376:
	mr 3,29
	mtlr 9
	blrl
	b .L358
.L371:
	lis 4,.LC55@ha
	mr 3,31
	la 4,.LC55@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L358
	lwz 9,40(27)
	mr 3,29
	mtlr 9
	blrl
.L358:
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L360
.L340:
	lwz 0,116(1)
	mtlr 0
	lmw 25,84(1)
	la 1,112(1)
	blr
.Lfe13:
	.size	 PrecacheItem,.Lfe13-PrecacheItem
	.section	".rodata"
	.align 2
.LC56:
	.string	"%s at %s has invalid spawnflags set\n"
	.align 3
.LC57:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC58:
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
	lwz 0,288(31)
	cmpwi 0,0,0
	bc 12,2,.L378
	lwz 3,284(31)
	lis 4,.LC16@ha
	la 4,.LC16@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L378
	li 0,0
	lis 29,gi@ha
	lwz 28,284(31)
	la 29,gi@l(29)
	stw 0,288(31)
	addi 3,31,4
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC56@ha
	la 3,.LC56@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L378:
	lis 9,.LC58@ha
	lis 11,deathmatch@ha
	la 9,.LC58@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L380
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2048
	bc 12,2,.L381
	lwz 0,4(30)
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L394
	lis 9,Pickup_PowerArmor@ha
	la 9,Pickup_PowerArmor@l(9)
	cmpw 0,0,9
	bc 12,2,.L394
.L381:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 12,2,.L384
	lwz 0,4(30)
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L394
.L384:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 12,2,.L386
	lwz 0,4(30)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L394
	lis 9,Pickup_Adrenaline@ha
	la 9,Pickup_Adrenaline@l(9)
	cmpw 0,0,9
	bc 12,2,.L394
.L386:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8192
	bc 12,2,.L380
	lwz 0,56(30)
	cmpwi 0,0,2
	bc 4,2,.L380
.L394:
	mr 3,31
	bl G_FreeEdict
	b .L377
.L380:
	lis 11,.LC58@ha
	lis 9,coop@ha
	la 11,.LC58@l(11)
	lis 29,level@ha
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L391
	lwz 3,284(31)
	lis 4,.LC16@ha
	la 4,.LC16@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L391
	la 10,level@l(29)
	lwz 11,288(31)
	li 0,1
	lwz 9,304(10)
	addi 9,9,8
	slw 0,0,9
	or 11,11,0
	stw 11,288(31)
	lwz 9,304(10)
	addi 9,9,1
	stw 9,304(10)
.L391:
	lis 9,.LC58@ha
	lis 11,coop@ha
	la 9,.LC58@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L392
	lwz 0,56(30)
	andi. 11,0,8
	bc 12,2,.L392
	li 0,0
	stw 0,12(30)
.L392:
	stw 30,664(31)
	lis 11,level+4@ha
	lis 10,.LC57@ha
	lfs 0,level+4@l(11)
	lis 9,droptofloor@ha
	lfd 13,.LC57@l(10)
	la 9,droptofloor@l(9)
	li 11,512
	lwz 3,272(31)
	stw 9,440(31)
	cmpwi 0,3,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(31)
	lwz 0,28(30)
	stw 11,68(31)
	stw 0,64(31)
	bc 12,2,.L377
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L377:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 SpawnItem,.Lfe14-SpawnItem
	.globl itemlist
	.section	".data"
	.align 2
	.type	 itemlist,@object
	.size	 itemlist,26624
itemlist:
	.long 0
	.space	100
	.long .LC59
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC60
	.long .LC61
	.long 1
	.long 0
	.long .LC62
	.long .LC63
	.long 3
	.long 0
	.long 0
	.long 4
	.long combatarmor_info
	.long 2
	.long 0
	.long 0
	.long 0x0
	.long 0
	.long 0
	.long .LC64
	.space	12
	.long .LC65
	.long Pickup_Ammo
	.long Use_Weapon
	.long Drop_Ammo
	.long Weapon_TNT
	.long .LC66
	.long .LC67
	.long 0
	.long .LC68
	.long .LC69
	.long .LC70
	.long 3
	.long 5
	.long .LC71
	.long 3
	.long 0
	.long 4
	.long 13
	.long 0
	.long 0x3e800000
	.long 0
	.long 0
	.long .LC72
	.space	12
	.long .LC73
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Knife
	.long .LC74
	.long .LC75
	.long 0
	.long .LC76
	.long .LC77
	.long .LC78
	.long 0
	.long 1
	.long .LC78
	.long 1
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0x0
	.long 0
	.long 0
	.long .LC79
	.space	12
	.long .LC80
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Knife
	.long .LC74
	.long .LC81
	.long 0
	.long .LC82
	.long .LC83
	.long .LC84
	.long 0
	.long 1
	.long .LC85
	.long 1
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0x0
	.long 0
	.long 0
	.long .LC86
	.space	12
	.long .LC87
	.long Pickup_Weapon
	.long 0
	.long Drop_General
	.long 0
	.long .LC88
	.long .LC81
	.long 0
	.long 0
	.long .LC89
	.long .LC39
	.long 2
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long 2
	.long 0
	.long 0x0
	.long 0
	.long 0
	.long .LC64
	.space	12
	.long .LC90
	.long Pickup_Weapon
	.long Use_Weapon
	.long 0
	.long Weapon_Binoculars
	.long .LC88
	.long .LC91
	.long 0
	.long .LC92
	.long .LC93
	.long .LC94
	.long 1
	.long 1
	.long .LC94
	.long 1
	.long 0
	.long 0
	.long 8
	.long 0
	.long 0x3f000000
	.long 0
	.long 0
	.long .LC64
	.space	12
	.long .LC95
	.long Pickup_Weapon
	.long Use_Weapon
	.long 0
	.long Weapon_Morphine
	.long .LC88
	.long .LC96
	.long 0
	.long .LC97
	.long .LC98
	.long .LC99
	.long 0
	.long 5
	.long .LC99
	.long 3
	.long 0
	.long 0
	.long 8
	.long 0
	.long 0x0
	.long 0
	.long 0
	.long .LC64
	.space	12
	.long .LC100
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Flamethrower
	.long .LC74
	.long .LC101
	.long 0
	.long .LC102
	.long .LC103
	.long .LC104
	.long 0
	.long 1
	.long .LC105
	.long 9
	.long 0
	.long 0
	.long 11
	.long 3
	.long 0x428c0000
	.long 0
	.long 0
	.long .LC106
	.space	12
	.long .LC107
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC66
	.long .LC108
	.long 0
	.long 0
	.long .LC109
	.long .LC105
	.long 3
	.long 300
	.long 0
	.long 2
	.long 0
	.long 9
	.long 0
	.long 0
	.long 0x3e800000
	.long 0
	.long 0
	.long .LC64
	.space	12
	.long .LC110
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Antidote
	.long .LC88
	.long .LC96
	.long 0
	.long .LC92
	.long .LC98
	.long .LC111
	.long 0
	.long 5
	.long .LC111
	.long 3
	.long 0
	.long 0
	.long 8
	.long 0
	.long 0x0
	.long 0
	.long 0
	.long .LC64
	.space	12
	.long 0
	.space	100
	.space	25376
	.section	".rodata"
	.align 2
.LC111:
	.string	"Antidote"
	.align 2
.LC110:
	.string	"weapon_Antidote"
	.align 2
.LC109:
	.string	"a_flame"
	.align 2
.LC108:
	.string	"models/items/ammo/cells/medium/tris.md2"
	.align 2
.LC107:
	.string	"ammo_napalm"
	.align 2
.LC106:
	.string	"weapons/flamer/fire.wav"
	.align 2
.LC105:
	.string	"flame_mag"
	.align 2
.LC104:
	.string	"Flamethrower"
	.align 2
.LC103:
	.string	"w_flame"
	.align 2
.LC102:
	.string	"models/weapons/v_flamethrower/tris.md2"
	.align 2
.LC101:
	.string	"models/weapons/g_flamethrower/tris.md2"
	.align 2
.LC100:
	.string	"weapon_flamethrower"
	.align 2
.LC99:
	.string	"Morphine"
	.align 2
.LC98:
	.string	"w_morphine"
	.align 2
.LC97:
	.string	"models/weapons/v_morphine/tris.md2"
	.align 2
.LC96:
	.string	"models/items/band/tris.md2"
	.align 2
.LC95:
	.string	"weapon_Morphine"
	.align 2
.LC94:
	.string	"Binoculars"
	.align 2
.LC93:
	.string	"w_binoc"
	.align 2
.LC92:
	.string	"models/weapons/v_binoculars/tris.md2"
	.align 2
.LC91:
	.string	"models/items/g_binoculars/tris.md2"
	.align 2
.LC90:
	.string	"weapon_binoculars"
	.align 2
.LC89:
	.string	"w_helmet"
	.align 2
.LC88:
	.string	"items/pkup.wav"
	.align 2
.LC87:
	.string	"item_helmet"
	.align 2
.LC86:
	.string	"misc/fhit3.wav fists/fire.wav fists/hit.wav"
	.align 2
.LC85:
	.string	"fists"
	.align 2
.LC84:
	.string	"Fists"
	.align 2
.LC83:
	.string	"w_fists"
	.align 2
.LC82:
	.string	"models/weapons/v_fists/tris.md2"
	.align 2
.LC81:
	.string	"models/weapons/g_helmet/tris.md2"
	.align 2
.LC80:
	.string	"weapon_fists"
	.align 2
.LC79:
	.string	"misc/fhit3.wav knife/fire.wav knife/hit.wav knife/pullout.wav"
	.align 2
.LC78:
	.string	"Knife"
	.align 2
.LC77:
	.string	"w_knife"
	.align 2
.LC76:
	.string	"models/weapons/v_knife/tris.md2"
	.align 2
.LC75:
	.string	"models/weapons/g_knife/tris.md2"
	.align 2
.LC74:
	.string	"misc/w_pkup.wav"
	.align 2
.LC73:
	.string	"weapon_knife"
	.align 2
.LC72:
	.string	"weapons/hgrent1a.wav weapons/hgrena1b.wav weapons/hgrenb1a.wav weapons/hgrenb2a.wav "
	.align 2
.LC71:
	.string	"tnt"
	.align 2
.LC70:
	.string	"TNT"
	.align 2
.LC69:
	.string	"w_tnt"
	.align 2
.LC68:
	.string	"models/weapons/v_tnt/tris.md2"
	.align 2
.LC67:
	.string	"models/weapons/g_tnt/tris.md2"
	.align 2
.LC66:
	.string	"misc/am_pkup.wav"
	.align 2
.LC65:
	.string	"ammo_tnt"
	.align 2
.LC64:
	.string	""
	.align 2
.LC63:
	.string	"Combat Armor"
	.align 2
.LC62:
	.string	"i_combatarmor"
	.align 2
.LC61:
	.string	"models/items/armor/combat/tris.md2"
	.align 2
.LC60:
	.string	"misc/ar1_pkup.wav"
	.align 2
.LC59:
	.string	"item_armor_combat"
	.align 2
.LC112:
	.string	"models/items/healing/medium/tris.md2"
	.align 2
.LC113:
	.string	"models/items/healing/stimpack/tris.md2"
	.align 2
.LC114:
	.string	"models/items/healing/large/tris.md2"
	.align 2
.LC115:
	.string	"models/items/mega_h/tris.md2"
	.align 2
.LC116:
	.string	"ammo_grenades"
	.align 2
.LC117:
	.string	"weapon_mine"
	.align 2
.LC118:
	.string	"item_silencer"
	.align 2
.LC119:
	.string	"item_breather"
	.align 2
.LC120:
	.string	"item_enviro"
	.align 2
.LC121:
	.string	"item_adrenaline"
	.align 2
.LC122:
	.string	"item_bandolier"
	.align 2
.LC123:
	.string	"item_pack"
	.align 2
.LC124:
	.string	"key_blue_key"
	.align 2
.LC125:
	.string	"key_red_key"
	.section	".sbss","aw",@nobits
	.align 2
combat_armor_index:
	.space	4
	.size	 combat_armor_index,4
	.comm	is_silenced,1,1
	.section	".text"
	.align 2
	.globl InitItems
	.type	 InitItems,@function
InitItems:
	li 0,257
	lis 9,itemlist@ha
	mtctr 0
	li 10,0
	la 11,itemlist@l(9)
.L526:
	cmpwi 0,11,0
	bc 12,2,.L406
	lwz 0,40(11)
	addi 9,10,1
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,10,0
	or 10,0,9
.L406:
	addi 11,11,104
	bdnz .L526
	lis 9,game+1556@ha
	stw 10,game+1556@l(9)
	blr
.Lfe15:
	.size	 InitItems,.Lfe15-InitItems
	.align 2
	.globl SetItemNames
	.type	 SetItemNames,@function
SetItemNames:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lwz 0,1556(10)
	cmpw 0,31,0
	bc 4,0,.L412
	lis 11,itemlist@ha
	lis 9,gi@ha
	la 11,itemlist@l(11)
	la 28,gi@l(9)
	mr 29,10
	addi 30,11,40
.L414:
	lwz 9,24(28)
	addi 3,31,1056
	lwz 4,0(30)
	addi 31,31,1
	mtlr 9
	addi 30,30,104
	blrl
	lwz 0,1556(29)
	cmpw 0,31,0
	bc 12,0,.L414
.L412:
	lis 9,game@ha
	lis 11,combat_armor_index@ha
	la 10,game@l(9)
	li 30,0
	lwz 0,1556(10)
	la 27,combat_armor_index@l(11)
	lis 9,.LC63@ha
	lis 11,itemlist@ha
	la 28,.LC63@l(9)
	cmpw 0,30,0
	la 31,itemlist@l(11)
	bc 4,0,.L423
	mr 29,10
.L418:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L420
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L420
	mr 11,31
	b .L422
.L420:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L418
.L423:
	li 11,0
.L422:
	lis 9,itemlist@ha
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 9,9,11
	mullw 9,9,0
	srawi 9,9,3
	stw 9,0(27)
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 SetItemNames,.Lfe16-SetItemNames
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
	b .L527
.L20:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L21
.L19:
	li 3,0
.L527:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 FindItem,.Lfe17-FindItem
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
	b .L528
.L12:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L13
.L11:
	li 3,0
.L528:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 FindItemByClassname,.Lfe18-FindItemByClassname
	.align 2
	.globl SetRespawn
	.type	 SetRespawn,@function
SetRespawn:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	li 8,0
	lwz 11,268(9)
	lis 7,level+4@ha
	lis 10,DoRespawn@ha
	lwz 0,184(9)
	la 10,DoRespawn@l(10)
	lis 6,gi+72@ha
	oris 11,11,0x8000
	stw 8,248(9)
	ori 0,0,1
	stw 11,268(9)
	stw 0,184(9)
	lfs 0,level+4@l(7)
	stw 10,440(9)
	fadds 0,0,1
	stfs 0,432(9)
	lwz 0,gi+72@l(6)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 SetRespawn,.Lfe19-SetRespawn
	.align 2
	.globl FindTeamItem
	.type	 FindTeamItem,@function
FindTeamItem:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	mr 28,3
	mr 29,4
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L27
	mr 27,9
.L29:
	lwz 0,68(31)
	cmpwi 0,0,0
	bc 12,2,.L28
	cmpw 0,0,29
	bc 4,2,.L28
	lwz 3,88(31)
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L28
	mr 3,31
	b .L529
.L28:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L29
.L27:
	li 3,0
.L529:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 FindTeamItem,.Lfe20-FindTeamItem
	.align 2
	.globl ArmorIndex
	.type	 ArmorIndex,@function
ArmorIndex:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L279
	li 3,0
	blr
.L279:
	lis 9,combat_armor_index@ha
	addi 11,11,740
	lwz 10,combat_armor_index@l(9)
	slwi 0,10,2
	lwzx 9,11,0
	srawi 3,9,31
	subf 3,9,3
	srawi 3,3,31
	and 3,10,3
	blr
.Lfe21:
	.size	 ArmorIndex,.Lfe21-ArmorIndex
	.align 2
	.globl PowerArmorType
	.type	 PowerArmorType,@function
PowerArmorType:
	li 3,0
	blr
.Lfe22:
	.size	 PowerArmorType,.Lfe22-PowerArmorType
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
	mulli 0,3,104
	lis 3,itemlist@ha
	la 3,itemlist@l(3)
	add 3,0,3
	blr
.Lfe23:
	.size	 GetItemByIndex,.Lfe23-GetItemByIndex
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.align 2
	.globl DoRespawn
	.type	 DoRespawn,@function
DoRespawn:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,312(31)
	cmpwi 0,0,0
	bc 12,2,.L35
	lwz 30,572(31)
	li 29,0
	mr. 31,30
	bc 12,2,.L37
.L38:
	lwz 31,544(31)
	addi 29,29,1
	cmpwi 0,31,0
	bc 4,2,.L38
.L37:
	bl rand
	mr 31,30
	divw 0,3,29
	mullw 0,0,29
	subf. 3,0,3
	bc 4,1,.L35
	mr 29,3
.L43:
	addic. 29,29,-1
	lwz 31,544(31)
	bc 4,2,.L43
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
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 DoRespawn,.Lfe24-DoRespawn
	.align 2
	.globl Drop_General
	.type	 Drop_General,@function
Drop_General:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr. 30,4
	mr 31,3
	bc 12,2,.L56
	mr 4,30
	bl Drop_Item
	lis 11,itemlist@ha
	lis 0,0xc4ec
	lwz 10,84(31)
	la 11,itemlist@l(11)
	ori 0,0,20165
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
	mr 3,31
	bl WeighPlayer
.L56:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 Drop_General,.Lfe25-Drop_General
	.section	".rodata"
	.align 2
.LC126:
	.long 0x0
	.align 3
.LC127:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Adrenaline
	.type	 Pickup_Adrenaline,@function
Pickup_Adrenaline:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,.LC126@ha
	lis 11,deathmatch@ha
	la 9,.LC126@l(9)
	mr 31,4
	lfs 13,0(9)
	mr 4,3
	lwz 9,deathmatch@l(11)
	stfs 13,988(31)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L59
	lwz 9,488(31)
	addi 9,9,1
	stw 9,488(31)
.L59:
	lwz 0,484(31)
	lwz 9,488(31)
	cmpw 0,0,9
	bc 4,0,.L60
	stw 9,484(31)
.L60:
	lwz 0,288(4)
	andis. 12,0,0x1
	bc 4,2,.L61
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L61
	lis 9,.LC127@ha
	lwz 11,664(4)
	la 9,.LC127@l(9)
	lis 7,0x4330
	lwz 0,268(4)
	lfd 12,0(9)
	lis 6,level+4@ha
	lis 10,DoRespawn@ha
	lwz 9,48(11)
	oris 0,0,0x8000
	la 10,DoRespawn@l(10)
	lwz 11,184(4)
	lis 5,gi+72@ha
	mr 3,4
	xoris 9,9,0x8000
	stw 0,268(4)
	stw 9,20(1)
	ori 11,11,1
	stw 7,16(1)
	lfd 0,16(1)
	stw 11,184(4)
	stw 12,248(4)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,440(4)
	frsp 0,0
	fadds 13,13,0
	stfs 13,432(4)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L61:
	mr 3,31
	bl WeighPlayer
	li 3,1
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 Pickup_Adrenaline,.Lfe26-Pickup_Adrenaline
	.section	".rodata"
	.align 3
.LC128:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC129:
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
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
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
	lis 9,.LC128@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC128@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,4348(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L181
	lis 9,.LC129@ha
	la 9,.LC129@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L532
.L181:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L532:
	stfs 0,4348(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe27:
	.size	 Use_Breather,.Lfe27-Use_Breather
	.section	".rodata"
	.align 3
.LC130:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC131:
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
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
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
	lis 9,.LC130@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC130@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,4352(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L184
	lis 9,.LC131@ha
	la 9,.LC131@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L533
.L184:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L533:
	stfs 0,4352(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe28:
	.size	 Use_Envirosuit,.Lfe28-Use_Envirosuit
	.align 2
	.globl Use_Silencer
	.type	 Use_Silencer,@function
Use_Silencer:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
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
	lwz 9,4368(11)
	addi 9,9,30
	stw 9,4368(11)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 Use_Silencer,.Lfe29-Use_Silencer
	.align 2
	.globl Drop_Ammo
	.type	 Drop_Ammo,@function
Drop_Ammo:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	mr 31,4
	la 9,itemlist@l(9)
	lis 0,0xc4ec
	ori 0,0,20165
	subf 9,9,31
	mullw 9,9,0
	mr 30,3
	srawi 29,9,3
	bl Drop_Item
	lwz 9,84(30)
	slwi 0,29,2
	lwz 11,48(31)
	addi 9,9,740
	lwzx 0,9,0
	cmpw 0,0,11
	bc 12,0,.L246
	stw 11,536(3)
	b .L247
.L246:
	stw 0,536(3)
.L247:
	lwz 0,64(31)
	cmpwi 0,0,3
	bc 4,2,.L250
	li 0,1
	stw 0,536(3)
.L250:
	lwz 9,84(30)
	slwi 11,29,2
	li 0,0
	mr 3,30
	addi 9,9,740
	stwx 0,9,11
	bl ValidateSelectedItem
	mr 3,30
	bl WeighPlayer
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 Drop_Ammo,.Lfe30-Drop_Ammo
	.section	".rodata"
	.align 2
.LC132:
	.long 0x3f800000
	.align 2
.LC133:
	.long 0x0
	.align 2
.LC134:
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
	lwz 9,484(11)
	lwz 0,488(11)
	cmpw 0,9,0
	bc 4,1,.L253
	lis 10,.LC132@ha
	lis 9,level+4@ha
	la 10,.LC132@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,432(7)
	lwz 9,484(11)
	addi 9,9,-1
	stw 9,484(11)
	b .L252
.L253:
	lwz 0,288(7)
	andis. 6,0,0x1
	bc 4,2,.L254
	lis 9,.LC133@ha
	lis 11,deathmatch@ha
	la 9,.LC133@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L254
	lwz 9,268(7)
	lis 11,.LC134@ha
	lis 10,level+4@ha
	lwz 0,184(7)
	la 11,.LC134@l(11)
	lis 8,gi+72@ha
	oris 9,9,0x8000
	stw 6,248(7)
	mr 3,7
	ori 0,0,1
	stw 9,268(7)
	stw 0,184(7)
	lfs 0,level+4@l(10)
	lfs 13,0(11)
	lis 11,DoRespawn@ha
	la 11,DoRespawn@l(11)
	fadds 0,0,13
	stw 11,440(7)
	stfs 0,432(7)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	b .L252
.L254:
	mr 3,7
	bl G_FreeEdict
.L252:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 MegaHealth_think,.Lfe31-MegaHealth_think
	.align 2
	.globl Pickup_Armor
	.type	 Pickup_Armor,@function
Pickup_Armor:
	lwz 0,664(3)
	lis 9,itemlist@ha
	lis 11,0xc4ec
	la 9,itemlist@l(9)
	ori 11,11,20165
	lwz 10,84(4)
	subf 0,9,0
	li 8,1
	mullw 0,0,11
	addi 10,10,740
	li 3,1
	srawi 0,0,3
	slwi 0,0,2
	stwx 8,10,0
	blr
.Lfe32:
	.size	 Pickup_Armor,.Lfe32-Pickup_Armor
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
	lwz 0,268(31)
	andi. 9,0,4096
	bc 12,2,.L302
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 9,9,30
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,1
	bc 4,2,.L302
	bl Use_PowerArmor
.L302:
	cmpwi 0,30,0
	bc 12,2,.L304
	mr 4,30
	mr 3,31
	bl Drop_Item
	lis 11,itemlist@ha
	lis 0,0xc4ec
	lwz 10,84(31)
	la 11,itemlist@l(11)
	ori 0,0,20165
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
	mr 3,31
	bl WeighPlayer
.L304:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe33:
	.size	 Drop_PowerArmor,.Lfe33-Drop_PowerArmor
	.align 2
	.type	 drop_temp_touch,@function
drop_temp_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,256(3)
	cmpw 0,4,0
	bc 12,2,.L321
	bl Touch_Item
.L321:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 drop_temp_touch,.Lfe34-drop_temp_touch
	.section	".rodata"
	.align 2
.LC135:
	.long 0x0
	.align 2
.LC136:
	.long 0x41e80000
	.section	".text"
	.align 2
	.type	 drop_make_touchable,@function
drop_make_touchable:
	lis 9,Touch_Item@ha
	lis 11,deathmatch@ha
	la 9,Touch_Item@l(9)
	lwz 10,deathmatch@l(11)
	stw 9,448(3)
	lis 9,.LC135@ha
	lfs 0,20(10)
	la 9,.LC135@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bclr 12,2
	lis 9,.LC136@ha
	lis 11,level+4@ha
	la 9,.LC136@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,440(3)
	stfs 0,432(3)
	blr
.Lfe35:
	.size	 drop_make_touchable,.Lfe35-drop_make_touchable
	.align 2
	.globl Use_Item
	.type	 Use_Item,@function
Use_Item:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,288(3)
	li 11,0
	lwz 0,184(3)
	andi. 10,9,2
	stw 11,452(3)
	rlwinm 0,0,0,0,30
	stw 0,184(3)
	bc 12,2,.L330
	li 0,2
	stw 11,448(3)
	stw 0,248(3)
	b .L331
.L330:
	lis 9,Touch_Item@ha
	li 0,1
	la 9,Touch_Item@l(9)
	stw 0,248(3)
	stw 9,448(3)
.L331:
	lis 9,gi+72@ha
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe36:
	.size	 Use_Item,.Lfe36-Use_Item
	.section	".rodata"
	.align 2
.LC137:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_item_health
	.type	 SP_item_health,@function
SP_item_health:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC137@ha
	lis 9,deathmatch@ha
	la 11,.LC137@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L396
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 12,2,.L396
	bl G_FreeEdict
	b .L395
.L396:
	lis 9,.LC112@ha
	li 0,10
	la 9,.LC112@l(9)
	stw 0,536(3)
	lis 11,gi+36@ha
	stw 9,272(3)
	lwz 0,gi+36@l(11)
	lis 3,.LC23@ha
	la 3,.LC23@l(3)
	mtlr 0
	blrl
.L395:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 SP_item_health,.Lfe37-SP_item_health
	.section	".rodata"
	.align 2
.LC138:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_item_health_small
	.type	 SP_item_health_small,@function
SP_item_health_small:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC138@ha
	lis 9,deathmatch@ha
	la 11,.LC138@l(11)
	mr 8,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L398
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 12,2,.L398
	bl G_FreeEdict
	b .L397
.L398:
	li 11,2
	lis 9,.LC113@ha
	li 0,1
	stw 11,536(8)
	la 9,.LC113@l(9)
	stw 0,660(8)
	lis 11,gi+36@ha
	lis 3,.LC22@ha
	stw 9,272(8)
	la 3,.LC22@l(3)
	lwz 0,gi+36@l(11)
	mtlr 0
	blrl
.L397:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe38:
	.size	 SP_item_health_small,.Lfe38-SP_item_health_small
	.section	".rodata"
	.align 2
.LC139:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_item_health_large
	.type	 SP_item_health_large,@function
SP_item_health_large:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC139@ha
	lis 9,deathmatch@ha
	la 11,.LC139@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L400
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 12,2,.L400
	bl G_FreeEdict
	b .L399
.L400:
	lis 9,.LC114@ha
	li 0,25
	la 9,.LC114@l(9)
	stw 0,536(3)
	lis 11,gi+36@ha
	stw 9,272(3)
	lwz 0,gi+36@l(11)
	lis 3,.LC24@ha
	la 3,.LC24@l(3)
	mtlr 0
	blrl
.L399:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe39:
	.size	 SP_item_health_large,.Lfe39-SP_item_health_large
	.section	".rodata"
	.align 2
.LC140:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_item_health_mega
	.type	 SP_item_health_mega,@function
SP_item_health_mega:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 11,.LC140@ha
	lis 9,deathmatch@ha
	la 11,.LC140@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L402
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L402
	bl G_FreeEdict
	b .L401
.L402:
	lis 9,.LC115@ha
	li 0,100
	la 9,.LC115@l(9)
	stw 0,536(31)
	lis 11,gi+36@ha
	stw 9,272(31)
	lis 3,.LC25@ha
	lwz 0,gi+36@l(11)
	la 3,.LC25@l(3)
	mtlr 0
	blrl
	li 0,3
	stw 0,660(31)
.L401:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe40:
	.size	 SP_item_health_mega,.Lfe40-SP_item_health_mega
	.align 2
	.globl SP_item_armor_body
	.type	 SP_item_armor_body,@function
SP_item_armor_body:
	blr
.Lfe41:
	.size	 SP_item_armor_body,.Lfe41-SP_item_armor_body
	.align 2
	.globl SP_item_armor_combat
	.type	 SP_item_armor_combat,@function
SP_item_armor_combat:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC59@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC59@l(11)
	mr 28,3
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L433
	mr 29,10
.L428:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L430
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L430
	mr 4,31
	b .L432
.L430:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L428
.L433:
	li 4,0
.L432:
	mr 3,28
	bl SpawnItem
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe42:
	.size	 SP_item_armor_combat,.Lfe42-SP_item_armor_combat
	.align 2
	.globl SP_item_armor_jacket
	.type	 SP_item_armor_jacket,@function
SP_item_armor_jacket:
	blr
.Lfe43:
	.size	 SP_item_armor_jacket,.Lfe43-SP_item_armor_jacket
	.align 2
	.globl SP_item_armor_shard
	.type	 SP_item_armor_shard,@function
SP_item_armor_shard:
	blr
.Lfe44:
	.size	 SP_item_armor_shard,.Lfe44-SP_item_armor_shard
	.align 2
	.globl SP_item_ammo_grenades
	.type	 SP_item_ammo_grenades,@function
SP_item_ammo_grenades:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC116@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC116@l(11)
	mr 28,3
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L444
	mr 29,10
.L439:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L441
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L441
	mr 4,31
	b .L443
.L441:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L439
.L444:
	li 4,0
.L443:
	mr 3,28
	bl SpawnItem
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe45:
	.size	 SP_item_ammo_grenades,.Lfe45-SP_item_ammo_grenades
	.align 2
	.globl SP_item_weapon_mine
	.type	 SP_item_weapon_mine,@function
SP_item_weapon_mine:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC117@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC117@l(11)
	mr 28,3
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L453
	mr 29,10
.L448:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L450
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L450
	mr 4,31
	b .L452
.L450:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L448
.L453:
	li 4,0
.L452:
	mr 3,28
	bl SpawnItem
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe46:
	.size	 SP_item_weapon_mine,.Lfe46-SP_item_weapon_mine
	.align 2
	.globl SP_item_powerup_silencer
	.type	 SP_item_powerup_silencer,@function
SP_item_powerup_silencer:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC118@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC118@l(11)
	mr 28,3
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L462
	mr 29,10
.L457:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L459
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L459
	mr 4,31
	b .L461
.L459:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L457
.L462:
	li 4,0
.L461:
	mr 3,28
	bl SpawnItem
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe47:
	.size	 SP_item_powerup_silencer,.Lfe47-SP_item_powerup_silencer
	.align 2
	.globl SP_item_powerup_breather
	.type	 SP_item_powerup_breather,@function
SP_item_powerup_breather:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC119@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC119@l(11)
	mr 28,3
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L471
	mr 29,10
.L466:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L468
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L468
	mr 4,31
	b .L470
.L468:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L466
.L471:
	li 4,0
.L470:
	mr 3,28
	bl SpawnItem
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe48:
	.size	 SP_item_powerup_breather,.Lfe48-SP_item_powerup_breather
	.align 2
	.globl SP_item_powerup_enviro
	.type	 SP_item_powerup_enviro,@function
SP_item_powerup_enviro:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC120@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC120@l(11)
	mr 28,3
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L480
	mr 29,10
.L475:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L477
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L477
	mr 4,31
	b .L479
.L477:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L475
.L480:
	li 4,0
.L479:
	mr 3,28
	bl SpawnItem
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe49:
	.size	 SP_item_powerup_enviro,.Lfe49-SP_item_powerup_enviro
	.align 2
	.globl SP_item_powerup_adrenaline
	.type	 SP_item_powerup_adrenaline,@function
SP_item_powerup_adrenaline:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC121@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC121@l(11)
	mr 28,3
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L489
	mr 29,10
.L484:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L486
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L486
	mr 4,31
	b .L488
.L486:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L484
.L489:
	li 4,0
.L488:
	mr 3,28
	bl SpawnItem
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe50:
	.size	 SP_item_powerup_adrenaline,.Lfe50-SP_item_powerup_adrenaline
	.align 2
	.globl SP_item_powerup_bandolier
	.type	 SP_item_powerup_bandolier,@function
SP_item_powerup_bandolier:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC122@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC122@l(11)
	mr 28,3
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L498
	mr 29,10
.L493:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L495
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L495
	mr 4,31
	b .L497
.L495:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L493
.L498:
	li 4,0
.L497:
	mr 3,28
	bl SpawnItem
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe51:
	.size	 SP_item_powerup_bandolier,.Lfe51-SP_item_powerup_bandolier
	.align 2
	.globl SP_item_powerup_pack
	.type	 SP_item_powerup_pack,@function
SP_item_powerup_pack:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC123@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC123@l(11)
	mr 28,3
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L507
	mr 29,10
.L502:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L504
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L504
	mr 4,31
	b .L506
.L504:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L502
.L507:
	li 4,0
.L506:
	mr 3,28
	bl SpawnItem
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe52:
	.size	 SP_item_powerup_pack,.Lfe52-SP_item_powerup_pack
	.align 2
	.globl SP_item_key_blue_key
	.type	 SP_item_key_blue_key,@function
SP_item_key_blue_key:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC124@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC124@l(11)
	mr 28,3
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L516
	mr 29,10
.L511:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L513
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L513
	mr 4,31
	b .L515
.L513:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L511
.L516:
	li 4,0
.L515:
	mr 3,28
	bl SpawnItem
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe53:
	.size	 SP_item_key_blue_key,.Lfe53-SP_item_key_blue_key
	.align 2
	.globl SP_item_key_red_key
	.type	 SP_item_key_red_key,@function
SP_item_key_red_key:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC125@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC125@l(11)
	mr 28,3
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L525
	mr 29,10
.L520:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L522
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L522
	mr 4,31
	b .L524
.L522:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,104
	cmpw 0,30,0
	bc 12,0,.L520
.L525:
	li 4,0
.L524:
	mr 3,28
	bl SpawnItem
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe54:
	.size	 SP_item_key_red_key,.Lfe54-SP_item_key_red_key
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
