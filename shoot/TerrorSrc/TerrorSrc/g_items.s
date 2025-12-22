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
	bc 4,2,.L51
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
	bc 4,2,.L51
	lis 11,coop@ha
	lis 7,.LC3@ha
	lwz 9,coop@l(11)
	la 7,.LC3@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L43
	lwz 0,56(8)
	rlwinm 0,0,29,31,31
	and. 9,0,10
	bc 12,2,.L43
.L51:
	li 3,0
	b .L50
.L43:
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
	bc 12,2,.L44
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L45
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
.L45:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,16
	bc 4,2,.L48
	lwz 9,648(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L44
	lwz 0,284(31)
	andis. 7,0,2
	bc 12,2,.L44
.L48:
	lwz 9,648(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L49
	lwz 0,284(31)
	andis. 9,0,2
	bc 12,2,.L49
	lis 11,level+4@ha
	lfs 0,428(31)
	lis 10,.LC0@ha
	lfs 11,level+4@l(11)
	lfd 12,.LC0@l(10)
	lis 11,quad_drop_timeout_hack@ha
	fsubs 0,0,11
	fdiv 0,0,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	stw 9,quad_drop_timeout_hack@l(11)
.L49:
	lwz 9,648(31)
	mr 3,30
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L44:
	li 3,1
.L50:
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
	.string	"UZIclip"
	.align 2
.LC6:
	.string	"1911rounds"
	.align 2
.LC7:
	.string	"UZIrounds"
	.align 2
.LC8:
	.string	"50cal"
	.align 2
.LC9:
	.string	"MARINERrounds"
	.align 2
.LC10:
	.string	"MARINERshells"
	.align 2
.LC11:
	.long 0x0
	.align 3
.LC12:
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
	mr 29,4
	mr 27,3
	lwz 9,84(29)
	lwz 0,1764(9)
	cmpwi 0,0,249
	bc 12,1,.L60
	li 0,250
	stw 0,1764(9)
.L60:
	lwz 9,84(29)
	lwz 0,1804(9)
	cmpwi 0,0,249
	bc 12,1,.L61
	li 0,250
	stw 0,1804(9)
.L61:
	lwz 9,84(29)
	lwz 0,1808(9)
	cmpwi 0,0,249
	bc 12,1,.L62
	li 0,250
	stw 0,1808(9)
.L62:
	lwz 9,84(29)
	lwz 0,1812(9)
	cmpwi 0,0,249
	bc 12,1,.L63
	li 0,250
	stw 0,1812(9)
.L63:
	lwz 9,84(29)
	lwz 0,1816(9)
	cmpwi 0,0,249
	bc 12,1,.L64
	li 0,250
	stw 0,1816(9)
.L64:
	lwz 9,84(29)
	lwz 0,1768(9)
	cmpwi 0,0,149
	bc 12,1,.L65
	li 0,150
	stw 0,1768(9)
.L65:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,249
	bc 12,1,.L66
	li 0,250
	stw 0,1780(9)
.L66:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,74
	bc 12,1,.L67
	li 0,75
	stw 0,1784(9)
.L67:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC5@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC5@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L75
	mr 28,10
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
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L70
.L75:
	li 8,0
.L74:
	cmpwi 0,8,0
	bc 12,2,.L76
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
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
	lis 11,.LC6@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC6@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L85
	mr 28,10
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
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L80
.L85:
	li 8,0
.L84:
	cmpwi 0,8,0
	bc 12,2,.L86
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1804(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L86
	stwx 11,9,8
.L86:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC7@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC7@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L95
	mr 28,10
.L90:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L92
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L92
	mr 8,31
	b .L94
.L92:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L90
.L95:
	li 8,0
.L94:
	cmpwi 0,8,0
	bc 12,2,.L96
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1808(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L96
	stwx 11,9,8
.L96:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC8@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC8@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L105
	mr 28,10
.L100:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L102
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L102
	mr 8,31
	b .L104
.L102:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L100
.L105:
	li 8,0
.L104:
	cmpwi 0,8,0
	bc 12,2,.L106
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1812(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L106
	stwx 11,9,8
.L106:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC9@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC9@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L115
	mr 28,10
.L110:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L112
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L112
	mr 8,31
	b .L114
.L112:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L110
.L115:
	li 8,0
.L114:
	cmpwi 0,8,0
	bc 12,2,.L116
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1816(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L116
	stwx 11,9,8
.L116:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC10@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC10@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L125
	mr 28,10
.L120:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L122
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L122
	mr 8,31
	b .L124
.L122:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L120
.L125:
	li 8,0
.L124:
	cmpwi 0,8,0
	bc 12,2,.L126
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	addi 4,9,740
	lwz 11,1768(9)
	lwzx 0,4,8
	cmpw 0,0,11
	bc 4,1,.L126
	stwx 11,4,8
.L126:
	lwz 0,284(27)
	andis. 4,0,0x1
	bc 4,2,.L128
	lis 9,.LC11@ha
	lis 11,deathmatch@ha
	la 9,.LC11@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L128
	lis 9,.LC12@ha
	lwz 11,648(27)
	la 9,.LC12@l(9)
	lis 7,0x4330
	lwz 0,264(27)
	lfd 12,0(9)
	lis 6,level+4@ha
	lis 10,DoRespawn@ha
	lwz 9,48(11)
	oris 0,0,0x8000
	la 10,DoRespawn@l(10)
	lwz 11,184(27)
	lis 5,gi+72@ha
	mr 3,27
	xoris 9,9,0x8000
	stw 0,264(27)
	stw 9,20(1)
	ori 11,11,1
	stw 7,16(1)
	lfd 0,16(1)
	stw 11,184(27)
	stw 4,248(27)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,436(27)
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(27)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L128:
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
.LC13:
	.string	"1911clip"
	.align 2
.LC14:
	.string	"Grenades"
	.align 2
.LC15:
	.string	"Rockets"
	.align 2
.LC16:
	.string	"BARRETTclip"
	.align 2
.LC17:
	.long 0x0
	.align 3
.LC18:
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
	bc 12,1,.L131
	li 0,300
	stw 0,1764(9)
.L131:
	lwz 9,84(29)
	lwz 0,1808(9)
	cmpwi 0,0,299
	bc 12,1,.L132
	li 0,300
	stw 0,1808(9)
.L132:
	lwz 9,84(29)
	lwz 0,1804(9)
	cmpwi 0,0,299
	bc 12,1,.L133
	li 0,300
	stw 0,1804(9)
.L133:
	lwz 9,84(29)
	lwz 0,1812(9)
	cmpwi 0,0,299
	bc 12,1,.L134
	li 0,300
	stw 0,1812(9)
.L134:
	lwz 9,84(29)
	lwz 0,1816(9)
	cmpwi 0,0,299
	bc 12,1,.L135
	li 0,300
	stw 0,1816(9)
.L135:
	lwz 9,84(29)
	lwz 0,1768(9)
	cmpwi 0,0,199
	bc 12,1,.L136
	li 0,200
	stw 0,1768(9)
.L136:
	lwz 9,84(29)
	lwz 0,1772(9)
	cmpwi 0,0,99
	bc 12,1,.L137
	li 0,100
	stw 0,1772(9)
.L137:
	lwz 9,84(29)
	lwz 0,1776(9)
	cmpwi 0,0,99
	bc 12,1,.L138
	li 0,100
	stw 0,1776(9)
.L138:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,299
	bc 12,1,.L139
	li 0,300
	stw 0,1780(9)
.L139:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,99
	bc 12,1,.L140
	li 0,100
	stw 0,1784(9)
.L140:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC5@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC5@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L148
	mr 28,10
.L143:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L145
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L145
	mr 8,31
	b .L147
.L145:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L143
.L148:
	li 8,0
.L147:
	cmpwi 0,8,0
	bc 12,2,.L149
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1764(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L149
	stwx 11,9,8
.L149:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC6@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC6@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L158
	mr 28,10
.L153:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L155
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L155
	mr 8,31
	b .L157
.L155:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L153
.L158:
	li 8,0
.L157:
	cmpwi 0,8,0
	bc 12,2,.L159
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1804(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L159
	stwx 11,9,8
.L159:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC7@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC7@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L168
	mr 28,10
.L163:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L165
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L165
	mr 8,31
	b .L167
.L165:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L163
.L168:
	li 8,0
.L167:
	cmpwi 0,8,0
	bc 12,2,.L169
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1808(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L169
	stwx 11,9,8
.L169:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC8@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC8@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L178
	mr 28,10
.L173:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L175
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L175
	mr 8,31
	b .L177
.L175:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L173
.L178:
	li 8,0
.L177:
	cmpwi 0,8,0
	bc 12,2,.L179
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1812(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L179
	stwx 11,9,8
.L179:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC9@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC9@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L188
	mr 28,10
.L183:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L185
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L185
	mr 8,31
	b .L187
.L185:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L183
.L188:
	li 8,0
.L187:
	cmpwi 0,8,0
	bc 12,2,.L189
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1816(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L189
	stwx 11,9,8
.L189:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC10@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC10@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L198
	mr 28,10
.L193:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L195
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L195
	mr 8,31
	b .L197
.L195:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L193
.L198:
	li 8,0
.L197:
	cmpwi 0,8,0
	bc 12,2,.L199
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1768(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L199
	stwx 11,9,8
.L199:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC13@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC13@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L208
	mr 28,10
.L203:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L205
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L205
	mr 8,31
	b .L207
.L205:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L203
.L208:
	li 8,0
.L207:
	cmpwi 0,8,0
	bc 12,2,.L209
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1780(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L209
	stwx 11,9,8
.L209:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC14@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC14@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L218
	mr 28,10
.L213:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L215
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L215
	mr 8,31
	b .L217
.L215:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L213
.L218:
	li 8,0
.L217:
	cmpwi 0,8,0
	bc 12,2,.L219
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1776(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L219
	stwx 11,9,8
.L219:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC15@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC15@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L228
	mr 28,10
.L223:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L225
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L225
	mr 8,31
	b .L227
.L225:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L223
.L228:
	li 8,0
.L227:
	cmpwi 0,8,0
	bc 12,2,.L229
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1772(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L229
	stwx 11,9,8
.L229:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC16@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC16@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L238
	mr 28,10
.L233:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L235
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L235
	mr 8,31
	b .L237
.L235:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L233
.L238:
	li 8,0
.L237:
	cmpwi 0,8,0
	bc 12,2,.L239
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	addi 4,9,740
	lwz 11,1784(9)
	lwzx 0,4,8
	cmpw 0,0,11
	bc 4,1,.L239
	stwx 11,4,8
.L239:
	lwz 0,284(26)
	andis. 4,0,0x1
	bc 4,2,.L241
	lis 9,.LC17@ha
	lis 11,deathmatch@ha
	la 9,.LC17@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L241
	lis 9,.LC18@ha
	lwz 11,648(26)
	la 9,.LC18@l(9)
	lis 7,0x4330
	lwz 0,264(26)
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
	stw 0,264(26)
	stw 9,20(1)
	ori 11,11,1
	stw 7,16(1)
	lfd 0,16(1)
	stw 11,184(26)
	stw 4,248(26)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,436(26)
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(26)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L241:
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
.LC19:
	.string	"items/damage.wav"
	.align 3
.LC20:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC21:
	.long 0x3f800000
	.align 2
.LC22:
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
	lis 0,0x286b
	la 9,itemlist@l(9)
	mr 31,3
	subf 4,9,4
	ori 0,0,51739
	lwz 11,84(31)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 11,quad_drop_timeout_hack@ha
	lwz 9,quad_drop_timeout_hack@l(11)
	cmpwi 0,9,0
	bc 12,2,.L244
	li 0,0
	mr 10,9
	stw 0,quad_drop_timeout_hack@l(11)
	b .L245
.L244:
	li 10,300
.L245:
	lis 11,level@ha
	lwz 8,84(31)
	lwz 11,level@l(11)
	lis 7,0x4330
	lis 6,.LC20@ha
	la 6,.LC20@l(6)
	lfs 12,3836(8)
	xoris 0,11,0x8000
	lfd 13,0(6)
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L246
	xoris 0,10,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fadds 0,12,0
	b .L248
.L246:
	add 0,11,10
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
.L248:
	stfs 0,3836(8)
	lis 29,gi@ha
	lis 3,.LC19@ha
	la 29,gi@l(29)
	la 3,.LC19@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 6,.LC21@ha
	lwz 0,16(29)
	lis 9,.LC21@ha
	la 6,.LC21@l(6)
	mr 5,3
	lfs 1,0(6)
	la 9,.LC21@l(9)
	li 4,3
	mtlr 0
	lis 6,.LC22@ha
	mr 3,31
	lfs 2,0(9)
	la 6,.LC22@l(6)
	lfs 3,0(6)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 Use_Quad,.Lfe4-Use_Quad
	.section	".rodata"
	.align 2
.LC23:
	.string	"items/protect.wav"
	.align 3
.LC24:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC25:
	.long 0x43960000
	.align 2
.LC26:
	.long 0x3f800000
	.align 2
.LC27:
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
	lis 0,0x286b
	la 9,itemlist@l(9)
	mr 31,3
	subf 4,9,4
	ori 0,0,51739
	lwz 11,84(31)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC24@ha
	lis 11,level@ha
	lwz 10,84(31)
	la 9,.LC24@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3840(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L256
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L258
.L256:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L258:
	stfs 0,3840(10)
	lis 29,gi@ha
	lis 3,.LC23@ha
	la 29,gi@l(29)
	la 3,.LC23@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC26@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC26@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC26@ha
	la 9,.LC26@l(9)
	lfs 2,0(9)
	lis 9,.LC27@ha
	la 9,.LC27@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 Use_Invulnerability,.Lfe5-Use_Invulnerability
	.section	".rodata"
	.align 2
.LC28:
	.string	"key_power_cube"
	.align 2
.LC29:
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
	mr 30,4
	mr 31,3
	lwz 10,84(30)
	lbz 0,16(10)
	andi. 9,0,1
	bc 12,2,.L261
	lwz 0,4008(10)
	cmpwi 0,0,1
	bc 4,1,.L261
	lis 9,.LC29@ha
	lis 11,coop@ha
	la 9,.LC29@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L262
	lwz 3,280(31)
	lis 4,.LC28@ha
	la 4,.LC28@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L263
	lwz 10,84(30)
	lbz 9,286(31)
	lwz 0,1832(10)
	and. 11,0,9
	bc 4,2,.L261
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
	lwz 0,1832(11)
	or 0,0,9
	stw 0,1832(11)
	b .L265
.L263:
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
	bc 4,2,.L261
	li 0,1
	stwx 0,4,3
.L265:
	li 3,1
	b .L268
.L262:
	lwz 0,648(31)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,0
	addi 10,10,740
	mullw 0,0,11
	li 3,1
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lwz 11,84(30)
	lwz 9,4008(11)
	addi 9,9,-2
	stw 9,4008(11)
	b .L268
.L261:
	li 3,0
.L268:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 Pickup_Key,.Lfe6-Pickup_Key
	.section	".rodata"
	.align 2
.LC30:
	.string	"ir goggles"
	.align 2
.LC31:
	.string	"helmet"
	.align 2
.LC32:
	.string	"bullet proof vest"
	.align 2
.LC33:
	.string	"medkit"
	.align 2
.LC34:
	.string	"scuba gear"
	.align 2
.LC35:
	.string	"head light"
	.section	".text"
	.align 2
	.globl Pickup_Item
	.type	 Pickup_Item,@function
Pickup_Item:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 29,4
	mr 27,3
	lwz 9,84(29)
	lbz 0,16(9)
	andi. 9,0,1
	bc 12,2,.L270
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC30@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC30@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L279
	mr 28,10
.L274:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L276
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L345
.L276:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L274
.L279:
	li 9,0
.L278:
	lwz 0,648(27)
	cmpw 0,0,9
	bc 4,2,.L271
	lwz 9,84(29)
	lwz 11,4008(9)
	cmpwi 0,11,2
	bc 4,1,.L270
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 12,2,.L280
	b .L270
.L345:
	mr 9,31
	b .L278
.L346:
	mr 9,31
	b .L290
.L280:
	addi 0,11,-3
	stw 0,4008(9)
	li 11,1
	lwz 9,84(29)
	stw 11,3988(9)
.L271:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC31@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC31@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L291
	mr 28,10
.L286:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L288
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L346
.L288:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L286
.L291:
	li 9,0
.L290:
	lwz 0,648(27)
	cmpw 0,0,9
	bc 4,2,.L283
	lwz 9,84(29)
	lwz 11,4008(9)
	cmpwi 0,11,1
	bc 4,1,.L270
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 12,2,.L292
	b .L270
.L347:
	mr 9,31
	b .L302
.L292:
	addi 0,11,-2
	stw 0,4008(9)
	li 11,1
	lwz 9,84(29)
	stw 11,3988(9)
.L283:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC32@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC32@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L303
	mr 28,10
.L298:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L300
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L347
.L300:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L298
.L303:
	li 9,0
.L302:
	lwz 0,648(27)
	cmpw 0,0,9
	bc 4,2,.L295
	lwz 9,84(29)
	lwz 11,4008(9)
	cmpwi 0,11,3
	bc 4,1,.L270
	lwz 0,3992(9)
	cmpwi 0,0,0
	bc 12,2,.L304
	b .L270
.L348:
	mr 9,31
	b .L314
.L304:
	addi 0,11,-4
	stw 0,4008(9)
	li 11,1
	lwz 9,84(29)
	stw 11,3992(9)
.L295:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC33@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC33@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L315
	mr 28,10
.L310:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L312
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L348
.L312:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L310
.L315:
	li 9,0
.L314:
	lwz 0,648(27)
	cmpw 0,0,9
	bc 4,2,.L307
	lwz 9,84(29)
	lwz 11,4008(9)
	cmpwi 0,11,1
	bc 4,1,.L270
	lwz 0,3992(9)
	cmpwi 0,0,0
	bc 12,2,.L316
	b .L270
.L349:
	mr 9,31
	b .L326
.L316:
	addi 0,11,-2
	stw 0,4008(9)
	li 11,1
	lwz 9,84(29)
	stw 11,3992(9)
.L307:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC34@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC34@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L327
	mr 28,10
.L322:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L324
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L349
.L324:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L322
.L327:
	li 9,0
.L326:
	lwz 0,648(27)
	cmpw 0,0,9
	bc 4,2,.L319
	lwz 9,84(29)
	lwz 11,4008(9)
	cmpwi 0,11,4
	bc 4,1,.L270
	lwz 0,3992(9)
	cmpwi 0,0,0
	bc 12,2,.L328
	b .L270
.L350:
	mr 9,31
	b .L338
.L328:
	addi 0,11,-5
	stw 0,4008(9)
	li 11,1
	lwz 9,84(29)
	stw 11,3992(9)
.L319:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC35@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC35@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L339
	mr 28,10
.L334:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L336
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L350
.L336:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L334
.L339:
	li 9,0
.L338:
	lwz 0,648(27)
	cmpw 0,0,9
	bc 4,2,.L331
	lwz 9,84(29)
	lwz 11,4008(9)
	cmpwi 0,11,1
	bc 4,1,.L270
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 4,2,.L270
	addi 0,11,-2
	stw 0,4008(9)
	li 11,1
	lwz 9,84(29)
	stw 11,3988(9)
.L331:
	lwz 0,648(27)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	lwz 10,84(29)
	subf 0,9,0
	mr 3,29
	mullw 0,0,11
	addi 10,10,740
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	bl ShowItem
	mr 3,29
	bl ShowTorso
	li 3,1
	b .L344
.L270:
	li 3,0
.L344:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 Pickup_Item,.Lfe7-Pickup_Item
	.section	".rodata"
	.align 2
.LC36:
	.string	"IR goggles"
	.align 2
.LC37:
	.string	"barrett"
	.align 2
.LC38:
	.string	"Helmet"
	.align 2
.LC39:
	.string	"Bullet Proof Vest"
	.align 2
.LC40:
	.string	"MedKit"
	.align 2
.LC41:
	.string	"Scuba Gear"
	.align 2
.LC42:
	.string	"Head Light"
	.section	".text"
	.align 2
	.globl Drop_SpecialItem
	.type	 Drop_SpecialItem,@function
Drop_SpecialItem:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	mr 31,3
	lwz 0,1556(10)
	lis 9,.LC36@ha
	lis 11,itemlist@ha
	la 26,.LC36@l(9)
	lwz 25,84(31)
	mr 27,4
	cmpw 0,30,0
	la 29,itemlist@l(11)
	bc 4,0,.L360
	mr 28,10
.L355:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L357
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L430
.L357:
	lwz 0,1556(28)
	addi 30,30,1
	addi 29,29,76
	cmpw 0,30,0
	bc 12,0,.L355
.L360:
	li 0,0
.L359:
	lis 11,itemlist@ha
	lis 9,0x286b
	la 10,itemlist@l(11)
	ori 9,9,51739
	subf 0,10,0
	addi 11,25,740
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L352
	lwz 28,84(31)
	lwz 11,4036(28)
	cmpwi 0,11,0
	bc 4,2,.L361
	lwz 0,116(28)
	rlwinm 0,0,0,30,28
	stw 0,116(28)
	lwz 9,84(31)
	stw 11,4028(9)
	b .L362
.L430:
	mr 0,29
	b .L359
.L431:
	mr 9,29
	b .L370
.L361:
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC37@ha
	lwz 0,1556(9)
	la 25,.LC37@l(11)
	mr 29,10
	cmpw 0,30,0
	bc 4,0,.L371
	mr 26,9
.L366:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L368
	mr 4,25
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L431
.L368:
	lwz 0,1556(26)
	addi 30,30,1
	addi 29,29,76
	cmpw 0,30,0
	bc 12,0,.L366
.L371:
	li 9,0
.L370:
	lwz 0,1824(28)
	cmpw 0,0,9
	bc 4,2,.L362
	lwz 11,84(31)
	li 10,0
	lwz 0,116(11)
	rlwinm 0,0,0,30,28
	stw 0,116(11)
	lwz 9,84(31)
	stw 10,4028(9)
.L362:
	mr 4,27
	mr 3,31
	bl Drop_Item
	lis 11,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 11,11,27
	addi 10,10,740
	mullw 11,11,0
	mr 3,31
	rlwinm 11,11,0,0,29
	lwzx 9,10,11
	addi 9,9,-1
	stwx 9,10,11
	bl ValidateSelectedItem
	lwz 10,84(31)
	li 0,0
	lwz 9,4008(10)
	addi 9,9,3
	b .L437
.L432:
	mr 0,29
	b .L381
.L352:
	lis 9,game@ha
	li 30,0
	lwz 25,84(31)
	la 9,game@l(9)
	lis 11,.LC38@ha
	lwz 0,1556(9)
	la 26,.LC38@l(11)
	mr 29,10
	cmpw 0,30,0
	bc 4,0,.L382
	mr 28,9
.L377:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L379
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L432
.L379:
	lwz 0,1556(28)
	addi 30,30,1
	addi 29,29,76
	cmpw 0,30,0
	bc 12,0,.L377
.L382:
	li 0,0
.L381:
	lis 9,itemlist@ha
	lis 29,0x286b
	la 28,itemlist@l(9)
	ori 29,29,51739
	subf 0,28,0
	addi 11,25,740
	mullw 0,0,29
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L374
	mr 4,27
	mr 3,31
	bl Drop_Item
	subf 0,28,27
	lwz 11,84(31)
	mr 3,31
	mullw 0,0,29
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	bl ValidateSelectedItem
	lwz 10,84(31)
	li 0,0
	lwz 9,4008(10)
	addi 9,9,2
.L437:
	stw 9,4008(10)
	lwz 11,84(31)
	stw 0,3988(11)
	b .L373
.L433:
	mr 0,29
	b .L392
.L374:
	lis 9,game@ha
	li 30,0
	lwz 25,84(31)
	la 9,game@l(9)
	lis 11,.LC39@ha
	lwz 0,1556(9)
	la 26,.LC39@l(11)
	mr 29,28
	cmpw 0,30,0
	bc 4,0,.L393
	mr 28,9
.L388:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L390
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L433
.L390:
	lwz 0,1556(28)
	addi 30,30,1
	addi 29,29,76
	cmpw 0,30,0
	bc 12,0,.L388
.L393:
	li 0,0
.L392:
	lis 9,itemlist@ha
	lis 29,0x286b
	la 28,itemlist@l(9)
	ori 29,29,51739
	subf 0,28,0
	addi 11,25,740
	mullw 0,0,29
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L385
	mr 4,27
	mr 3,31
	bl Drop_Item
	subf 0,28,27
	lwz 11,84(31)
	mr 3,31
	mullw 0,0,29
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	bl ValidateSelectedItem
	lwz 10,84(31)
	li 0,0
	lwz 9,4008(10)
	addi 9,9,4
	b .L438
.L434:
	mr 0,29
	b .L403
.L385:
	lis 9,game@ha
	li 30,0
	lwz 25,84(31)
	la 9,game@l(9)
	lis 11,.LC40@ha
	lwz 0,1556(9)
	la 26,.LC40@l(11)
	mr 29,28
	cmpw 0,30,0
	bc 4,0,.L404
	mr 28,9
.L399:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L401
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L434
.L401:
	lwz 0,1556(28)
	addi 30,30,1
	addi 29,29,76
	cmpw 0,30,0
	bc 12,0,.L399
.L404:
	li 0,0
.L403:
	lis 9,itemlist@ha
	lis 29,0x286b
	la 28,itemlist@l(9)
	ori 29,29,51739
	subf 0,28,0
	addi 11,25,740
	mullw 0,0,29
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L396
	mr 4,27
	mr 3,31
	bl Drop_Item
	subf 0,28,27
	lwz 11,84(31)
	mr 3,31
	mullw 0,0,29
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	bl ValidateSelectedItem
	lwz 10,84(31)
	li 0,0
	lwz 9,4008(10)
	addi 9,9,2
	b .L438
.L435:
	mr 0,29
	b .L414
.L396:
	lis 9,game@ha
	li 30,0
	lwz 25,84(31)
	la 9,game@l(9)
	lis 11,.LC41@ha
	lwz 0,1556(9)
	la 26,.LC41@l(11)
	mr 29,28
	cmpw 0,30,0
	bc 4,0,.L415
	mr 28,9
.L410:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L412
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L435
.L412:
	lwz 0,1556(28)
	addi 30,30,1
	addi 29,29,76
	cmpw 0,30,0
	bc 12,0,.L410
.L415:
	li 0,0
.L414:
	lis 9,itemlist@ha
	lis 29,0x286b
	la 28,itemlist@l(9)
	ori 29,29,51739
	subf 0,28,0
	addi 11,25,740
	mullw 0,0,29
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L407
	mr 4,27
	mr 3,31
	bl Drop_Item
	subf 0,28,27
	lwz 11,84(31)
	mr 3,31
	mullw 0,0,29
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	bl ValidateSelectedItem
	lwz 10,84(31)
	li 0,0
	lwz 9,4008(10)
	addi 9,9,5
.L438:
	stw 9,4008(10)
	lwz 11,84(31)
	stw 0,3992(11)
	b .L373
.L436:
	mr 0,29
	b .L425
.L407:
	lis 9,game@ha
	li 30,0
	lwz 25,84(31)
	la 9,game@l(9)
	lis 11,.LC42@ha
	lwz 0,1556(9)
	la 26,.LC42@l(11)
	mr 29,28
	cmpw 0,30,0
	bc 4,0,.L426
	mr 28,9
.L421:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L423
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L436
.L423:
	lwz 0,1556(28)
	addi 30,30,1
	addi 29,29,76
	cmpw 0,30,0
	bc 12,0,.L421
.L426:
	li 0,0
.L425:
	lis 9,itemlist@ha
	lis 30,0x286b
	la 28,itemlist@l(9)
	ori 30,30,51739
	subf 0,28,0
	addi 11,25,740
	mullw 0,0,30
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L373
	lwz 9,84(31)
	lwz 0,4048(9)
	cmpwi 0,0,1
	bc 4,2,.L427
	mr 3,31
	bl SP_FlashLight
.L427:
	lwz 9,84(31)
	li 29,0
	mr 4,27
	mr 3,31
	stw 29,4048(9)
	bl Drop_Item
	subf 0,28,27
	lwz 11,84(31)
	mr 3,31
	mullw 0,0,30
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	bl ValidateSelectedItem
	lwz 10,84(31)
	lwz 9,4008(10)
	addi 9,9,2
	stw 9,4008(10)
	lwz 11,84(31)
	stw 29,3988(11)
.L373:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L351
	mr 3,31
	bl ShowItem
	mr 3,31
	bl ShowTorso
.L351:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 Drop_SpecialItem,.Lfe8-Drop_SpecialItem
	.align 2
	.globl Add_Ammo
	.type	 Add_Ammo,@function
Add_Ammo:
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 4,2,.L440
.L474:
	li 3,0
	blr
.L440:
	lwz 0,68(4)
	cmpwi 0,0,0
	mr 11,0
	bc 4,2,.L441
	mr 10,9
	lwz 11,1764(9)
	b .L442
.L441:
	cmpwi 0,11,6
	bc 4,2,.L443
	mr 10,9
	lwz 11,1804(9)
	b .L442
.L443:
	cmpwi 0,11,7
	bc 4,2,.L445
	mr 10,9
	lwz 11,1808(9)
	b .L442
.L445:
	cmpwi 0,11,8
	bc 4,2,.L447
	mr 10,9
	lwz 11,1812(9)
	b .L442
.L447:
	cmpwi 0,11,9
	bc 4,2,.L449
	mr 10,9
	lwz 11,1816(9)
	b .L442
.L449:
	cmpwi 0,11,10
	bc 4,2,.L451
	mr 10,9
	lwz 11,1800(9)
	b .L442
.L451:
	cmpwi 0,11,11
	bc 4,2,.L453
	mr 10,9
	lwz 11,1796(9)
	b .L442
.L453:
	cmpwi 0,11,12
	bc 4,2,.L455
	mr 10,9
	lwz 11,1792(9)
	b .L442
.L455:
	cmpwi 0,11,13
	bc 4,2,.L457
	mr 10,9
	lwz 11,1788(9)
	b .L442
.L457:
	cmpwi 0,11,14
	bc 4,2,.L459
	lwz 9,84(3)
	mr 10,9
	lwz 11,1820(9)
	b .L442
.L459:
	cmpwi 0,11,1
	bc 4,2,.L461
	lwz 9,84(3)
	mr 10,9
	lwz 11,1768(9)
	b .L442
.L461:
	cmpwi 0,11,2
	bc 4,2,.L463
	lwz 9,84(3)
	mr 10,9
	lwz 11,1772(9)
	b .L442
.L463:
	cmpwi 0,11,3
	bc 4,2,.L465
	lwz 9,84(3)
	mr 10,9
	lwz 11,1776(9)
	b .L442
.L465:
	cmpwi 0,11,4
	bc 4,2,.L467
	lwz 9,84(3)
	mr 10,9
	lwz 11,1780(9)
	b .L442
.L467:
	cmpwi 0,11,5
	bc 4,2,.L474
	lwz 9,84(3)
	lwz 11,1784(9)
	mr 10,9
.L442:
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 10,10,740
	mullw 9,9,0
	rlwinm 4,9,0,0,29
	lwzx 0,10,4
	cmpw 0,0,11
	bc 12,2,.L474
	add 0,0,5
	stwx 0,10,4
	lwz 9,84(3)
	addi 3,9,740
	lwzx 0,3,4
	cmpw 0,0,11
	bc 4,1,.L472
	stwx 11,3,4
.L472:
	li 3,1
	blr
.Lfe9:
	.size	 Add_Ammo,.Lfe9-Add_Ammo
	.section	".rodata"
	.align 2
.LC43:
	.string	"m60ammo"
	.align 2
.LC44:
	.string	"uziclip"
	.align 2
.LC45:
	.string	"barrettclip"
	.align 2
.LC46:
	.string	"ak47 clip"
	.align 2
.LC47:
	.string	"glockclip"
	.align 2
.LC48:
	.string	"berettaclip"
	.align 2
.LC49:
	.string	"mp5clip"
	.align 2
.LC50:
	.string	"msg90clip"
	.align 2
.LC51:
	.string	"casullbullets"
	.align 2
.LC52:
	.string	"marinershells"
	.align 2
.LC53:
	.string	"mine"
	.align 2
.LC54:
	.string	"c4 detpack"
	.align 2
.LC55:
	.string	"grenades"
	.align 2
.LC56:
	.long 0x0
	.align 2
.LC57:
	.long 0x42200000
	.section	".text"
	.align 2
	.globl Pickup_Ammo
	.type	 Pickup_Ammo,@function
Pickup_Ammo:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr 28,4
	mr 29,3
	lwz 9,84(28)
	cmpwi 0,9,0
	bc 4,2,.L476
	b .L477
.L709:
	mr 11,31
	b .L485
.L476:
	lbz 0,16(9)
	andi. 11,0,1
	bc 12,2,.L477
	lwz 0,4008(9)
	cmpwi 0,0,9
	bc 12,1,.L478
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(10)
	lis 9,.LC43@ha
	la 31,itemlist@l(11)
	la 26,.LC43@l(9)
	cmpw 0,30,0
	bc 4,0,.L486
	mr 27,10
.L481:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L483
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L709
.L483:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L481
.L486:
	li 11,0
.L485:
	lwz 0,648(29)
	cmpw 0,0,11
	bc 4,2,.L478
	lwz 9,84(28)
	lwz 0,4056(9)
	cmpwi 0,0,0
	bc 4,2,.L478
	b .L477
.L710:
	mr 9,31
	b .L494
.L478:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC43@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC43@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L495
	mr 27,10
.L490:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L492
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L710
.L492:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L490
.L495:
	li 9,0
.L494:
	lwz 0,648(29)
	lwz 11,84(28)
	cmpw 0,0,9
	bc 4,2,.L487
	lwz 0,3992(11)
	cmpwi 0,0,1
	bc 4,2,.L487
	lwz 0,4056(11)
	cmpwi 0,0,0
	bc 12,2,.L477
.L487:
	lwz 0,4008(11)
	cmpwi 0,0,1
	bc 12,1,.L496
	lwz 0,4056(11)
	cmpwi 0,0,0
	bc 4,2,.L496
	b .L477
.L711:
	mr 9,31
	b .L507
.L712:
	mr 9,31
	b .L516
.L713:
	mr 9,31
	b .L525
.L714:
	mr 9,31
	b .L534
.L715:
	mr 9,31
	b .L543
.L716:
	mr 9,31
	b .L552
.L717:
	mr 9,31
	b .L561
.L718:
	mr 9,31
	b .L570
.L719:
	mr 9,31
	b .L579
.L720:
	mr 9,31
	b .L588
.L721:
	mr 9,31
	b .L596
.L496:
	lwz 0,4056(11)
	cmpwi 0,0,1
	bc 4,2,.L500
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC13@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC13@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L508
	mr 27,10
.L503:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L505
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L711
.L505:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L503
.L508:
	li 9,0
.L507:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 4,2,.L477
.L500:
	lwz 9,84(28)
	lwz 0,4056(9)
	cmpwi 0,0,2
	bc 4,2,.L509
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC44@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC44@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L517
	mr 27,10
.L512:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L514
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L712
.L514:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L512
.L517:
	li 9,0
.L516:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 4,2,.L477
.L509:
	lwz 9,84(28)
	lwz 0,4056(9)
	cmpwi 0,0,3
	bc 4,2,.L518
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC45@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC45@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L526
	mr 27,10
.L521:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L523
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L713
.L523:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L521
.L526:
	li 9,0
.L525:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 4,2,.L477
.L518:
	lwz 9,84(28)
	lwz 0,4056(9)
	cmpwi 0,0,4
	bc 4,2,.L527
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC46@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC46@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L535
	mr 27,10
.L530:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L532
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L714
.L532:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L530
.L535:
	li 9,0
.L534:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 4,2,.L477
.L527:
	lwz 9,84(28)
	lwz 0,4056(9)
	cmpwi 0,0,5
	bc 4,2,.L536
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC47@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC47@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L544
	mr 27,10
.L539:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L541
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L715
.L541:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L539
.L544:
	li 9,0
.L543:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 4,2,.L477
.L536:
	lwz 9,84(28)
	lwz 0,4056(9)
	cmpwi 0,0,6
	bc 4,2,.L545
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC48@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC48@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L553
	mr 27,10
.L548:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L550
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L716
.L550:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L548
.L553:
	li 9,0
.L552:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 4,2,.L477
.L545:
	lwz 9,84(28)
	lwz 0,4056(9)
	cmpwi 0,0,7
	bc 4,2,.L554
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC49@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC49@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L562
	mr 27,10
.L557:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L559
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L717
.L559:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L557
.L562:
	li 9,0
.L561:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 4,2,.L477
.L554:
	lwz 9,84(28)
	lwz 0,4056(9)
	cmpwi 0,0,8
	bc 4,2,.L563
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC43@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC43@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L571
	mr 27,10
.L566:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L568
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L718
.L568:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L566
.L571:
	li 9,0
.L570:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 4,2,.L477
.L563:
	lwz 9,84(28)
	lwz 0,4056(9)
	cmpwi 0,0,9
	bc 4,2,.L572
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC50@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC50@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L580
	mr 27,10
.L575:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L577
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L719
.L577:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L575
.L580:
	li 9,0
.L579:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 4,2,.L477
.L572:
	lwz 9,84(28)
	lwz 0,4056(9)
	cmpwi 0,0,10
	bc 4,2,.L581
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC51@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC51@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L589
	mr 27,10
.L584:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L586
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L720
.L586:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L584
.L589:
	li 9,0
.L588:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 4,2,.L477
.L581:
	lwz 9,84(28)
	lwz 0,4056(9)
	cmpwi 0,0,11
	bc 4,2,.L498
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC52@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC52@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L597
	mr 27,10
.L592:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L594
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L721
.L594:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L592
.L597:
	li 9,0
.L596:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 12,2,.L498
	b .L477
.L722:
	mr 9,31
	b .L606
.L723:
	mr 9,31
	b .L614
.L724:
	mr 9,31
	b .L622
.L498:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC53@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC53@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L607
	mr 27,10
.L602:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L604
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L722
.L604:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L602
.L607:
	li 9,0
.L606:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 12,2,.L599
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC54@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC54@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L615
	mr 27,10
.L610:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L612
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L723
.L612:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L610
.L615:
	li 9,0
.L614:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 12,2,.L599
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC55@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC55@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L623
	mr 27,10
.L618:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L620
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L724
.L620:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L618
.L623:
	li 9,0
.L622:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 4,2,.L598
.L599:
	lwz 11,84(28)
	lwz 9,4008(11)
	cmpwi 0,9,4
	bc 4,1,.L477
	addi 0,9,-5
	stw 0,4008(11)
	b .L497
.L725:
	mr 9,31
	b .L634
.L598:
	lwz 11,84(28)
	lwz 0,4056(11)
	cmpwi 0,0,0
	bc 4,2,.L626
	lwz 9,4008(11)
	addi 9,9,-2
	stw 9,4008(11)
.L626:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC43@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC43@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L635
	mr 27,10
.L630:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L632
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L725
.L632:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L630
.L635:
	li 9,0
.L634:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 4,2,.L497
	lwz 9,84(28)
	li 0,1
	stw 0,3992(9)
	lwz 11,84(28)
	lwz 0,4056(11)
	cmpwi 0,0,0
	bc 4,2,.L497
	lwz 9,4008(11)
	addi 9,9,-8
	stw 9,4008(11)
.L497:
	lwz 9,648(29)
	lwz 0,56(9)
	mr 4,9
	andi. 9,0,1
	bc 12,2,.L637
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8192
	li 5,1000
	bc 4,2,.L638
.L637:
	lwz 5,532(29)
	cmpwi 0,5,0
	bc 4,2,.L638
	lwz 5,48(4)
.L638:
	mr 3,28
	bl Add_Ammo
	cmpwi 0,3,0
	bc 4,2,.L641
	b .L477
.L726:
	mr 9,31
	b .L653
.L727:
	mr 9,31
	b .L662
.L728:
	mr 0,31
	b .L671
.L729:
	mr 9,31
	b .L688
.L730:
	mr 0,31
	b .L697
.L641:
	lwz 0,284(29)
	andis. 7,0,0x3
	bc 4,2,.L642
	lis 9,.LC56@ha
	lis 11,deathmatch@ha
	la 9,.LC56@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L642
	lwz 9,264(29)
	lis 11,.LC57@ha
	lis 10,level+4@ha
	lwz 0,184(29)
	la 11,.LC57@l(11)
	lis 8,gi+72@ha
	oris 9,9,0x8000
	stw 7,248(29)
	mr 3,29
	ori 0,0,1
	stw 9,264(29)
	stw 0,184(29)
	lfs 0,level+4@l(10)
	lfs 13,0(11)
	lis 11,DoRespawn@ha
	la 11,DoRespawn@l(11)
	fadds 0,0,13
	stw 11,436(29)
	stfs 0,428(29)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
.L642:
	lwz 11,648(29)
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,84(28)
	subf 11,9,11
	mullw 11,11,0
	addi 9,10,740
	rlwinm 11,11,0,0,29
	lwzx 0,9,11
	cmpwi 0,0,0
	bc 12,2,.L644
	lwz 0,4056(10)
	cmpwi 0,0,0
	bc 12,2,.L645
	lwz 0,3696(10)
	cmpwi 0,0,0
	bc 12,2,.L644
	li 0,0
	stwx 0,9,11
.L644:
	lwz 9,84(28)
	lwz 0,4056(9)
	cmpwi 0,0,0
	bc 12,2,.L645
	mr 3,28
	bl Cmd_Reload_f
.L645:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC43@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC43@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L654
	mr 27,10
.L649:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L651
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L726
.L651:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L649
.L654:
	li 9,0
.L653:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 4,2,.L646
	mr 3,28
	bl ShowTorso
.L646:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC51@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC51@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L663
	mr 27,10
.L658:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L660
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L727
.L660:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L658
.L663:
	li 9,0
.L662:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 4,2,.L655
	lwz 10,84(28)
	lwz 0,4056(10)
	cmpwi 0,0,10
	bc 4,2,.L655
	lis 9,game@ha
	li 30,0
	la 8,game@l(9)
	lis 11,.LC51@ha
	lwz 0,1556(8)
	lis 9,itemlist@ha
	la 26,.LC51@l(11)
	la 31,itemlist@l(9)
	addi 25,10,740
	cmpw 0,30,0
	bc 4,0,.L672
	mr 27,8
.L667:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L669
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L728
.L669:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L667
.L672:
	li 0,0
.L671:
	lis 11,itemlist@ha
	lis 9,0x286b
	la 30,itemlist@l(11)
	ori 9,9,51739
	subf 0,30,0
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,25,0
	cmpwi 0,9,0
	bc 12,2,.L655
	lwz 4,648(29)
	mr 3,28
	li 31,0
	bl Drop_Ammo
	lis 9,game@ha
	lis 11,.LC51@ha
	la 9,game@l(9)
	la 26,.LC51@l(11)
	lwz 0,1556(9)
	cmpw 0,31,0
	bc 4,0,.L679
	mr 27,9
.L675:
	lwz 3,40(30)
	cmpwi 0,3,0
	bc 12,2,.L677
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L679
.L677:
	lwz 0,1556(27)
	addi 31,31,1
	addi 30,30,76
	cmpw 0,31,0
	bc 12,0,.L675
.L679:
	lwz 11,84(28)
	lwz 9,4016(11)
	addi 9,9,-1
	stw 9,4016(11)
.L655:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC52@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC52@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L689
	mr 27,10
.L684:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L686
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L729
.L686:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L684
.L689:
	li 9,0
.L688:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 4,2,.L681
	lwz 10,84(28)
	lwz 0,4056(10)
	cmpwi 0,0,11
	bc 4,2,.L681
	lis 9,game@ha
	li 30,0
	la 8,game@l(9)
	lis 11,.LC52@ha
	lwz 0,1556(8)
	lis 9,itemlist@ha
	la 26,.LC52@l(11)
	la 31,itemlist@l(9)
	addi 25,10,740
	cmpw 0,30,0
	bc 4,0,.L698
	mr 27,8
.L693:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L695
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L730
.L695:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L693
.L698:
	li 0,0
.L697:
	lis 11,itemlist@ha
	lis 9,0x286b
	la 30,itemlist@l(11)
	ori 9,9,51739
	subf 0,30,0
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,25,0
	cmpwi 0,9,0
	bc 12,2,.L681
	lwz 4,648(29)
	mr 3,28
	li 31,0
	bl Drop_Ammo
	lis 9,game@ha
	lis 11,.LC52@ha
	la 9,game@l(9)
	la 27,.LC52@l(11)
	lwz 0,1556(9)
	cmpw 0,31,0
	bc 4,0,.L705
	mr 29,9
.L701:
	lwz 3,40(30)
	cmpwi 0,3,0
	bc 12,2,.L703
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L705
.L703:
	lwz 0,1556(29)
	addi 31,31,1
	addi 30,30,76
	cmpw 0,31,0
	bc 12,0,.L701
.L705:
	lwz 11,84(28)
	lwz 9,4012(11)
	addi 9,9,-1
	stw 9,4012(11)
.L681:
	li 3,1
	b .L708
.L477:
	li 3,0
.L708:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe10:
	.size	 Pickup_Ammo,.Lfe10-Pickup_Ammo
	.section	".rodata"
	.align 2
.LC58:
	.string	"C4 Detpack"
	.align 2
.LC59:
	.string	"Mine"
	.align 2
.LC60:
	.string	"Can't drop current weapon\n"
	.section	".text"
	.align 2
	.globl Drop_Ammo
	.type	 Drop_Ammo,@function
Drop_Ammo:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 9,game@ha
	lis 10,itemlist@ha
	la 7,game@l(9)
	la 10,itemlist@l(10)
	mr 24,4
	lis 0,0x286b
	lwz 8,1556(7)
	subf 9,10,24
	ori 0,0,51739
	li 30,0
	mullw 9,9,0
	lis 11,.LC58@ha
	cmpw 0,30,8
	la 27,.LC58@l(11)
	srawi 26,9,2
	mr 28,3
	mr 31,10
	bc 4,0,.L741
	mr 29,7
.L736:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L738
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L789
.L738:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L736
.L741:
	li 10,0
.L740:
	lwz 0,648(28)
	cmpw 0,0,10
	bc 12,2,.L731
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC59@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC59@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L749
	mr 29,10
.L744:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L746
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L790
.L746:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L744
.L749:
	li 9,0
.L748:
	lwz 0,648(28)
	cmpw 0,0,9
	bc 12,2,.L731
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC55@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC55@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L757
	mr 29,10
.L752:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L754
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L791
.L754:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L752
.L757:
	li 9,0
.L756:
	lwz 0,648(28)
	cmpw 0,0,9
	bc 12,2,.L731
	mr 3,28
	mr 4,24
	bl Drop_Item
	lwz 9,84(28)
	slwi 0,26,2
	mr 30,3
	mr 25,0
	lwz 11,48(24)
	addi 9,9,740
	lwzx 0,9,0
	cmpw 0,0,11
	bc 12,0,.L758
	stw 11,532(30)
	b .L759
.L791:
	mr 9,31
	b .L756
.L790:
	mr 9,31
	b .L748
.L789:
	mr 10,31
	b .L740
.L792:
	mr 9,31
	b .L767
.L758:
	stw 0,532(30)
.L759:
	lis 9,game@ha
	li 29,0
	la 10,game@l(9)
	lis 11,.LC51@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC51@l(11)
	la 31,itemlist@l(9)
	cmpw 0,29,0
	bc 4,0,.L768
	mr 27,10
.L763:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L765
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L792
.L765:
	lwz 0,1556(27)
	addi 29,29,1
	addi 31,31,76
	cmpw 0,29,0
	bc 12,0,.L763
.L768:
	li 9,0
.L767:
	lwz 0,648(30)
	cmpw 0,0,9
	bc 4,2,.L760
	lwz 0,532(30)
	cmpwi 0,0,10
	bc 4,2,.L769
	li 0,0
	b .L793
.L769:
	cmpwi 0,0,9
	bc 4,2,.L771
	li 0,1
	b .L793
.L771:
	cmpwi 0,0,8
	bc 4,2,.L773
	li 0,2
	b .L793
.L773:
	cmpwi 0,0,7
	bc 4,2,.L775
	li 0,3
	b .L793
.L775:
	cmpwi 0,0,6
	bc 4,2,.L777
	li 0,4
	b .L793
.L777:
	cmpwi 0,0,5
	bc 12,2,.L793
	cmpwi 0,0,4
	bc 4,2,.L781
	li 0,6
	b .L793
.L781:
	cmpwi 0,0,3
	bc 4,2,.L783
	li 0,7
	b .L793
.L783:
	cmpwi 0,0,2
	bc 4,2,.L785
	li 0,8
	b .L793
.L785:
	cmpwi 0,0,1
	bc 4,2,.L760
	li 0,9
.L793:
	stw 0,56(30)
.L760:
	lwz 9,84(28)
	lwz 10,532(30)
	mr 11,9
	lwz 9,1824(9)
	cmpwi 0,9,0
	bc 12,2,.L788
	lwz 0,68(9)
	cmpwi 0,0,3
	bc 4,2,.L788
	lwz 0,68(24)
	cmpwi 0,0,3
	bc 4,2,.L788
	addi 9,11,740
	lwzx 0,9,25
	subf. 9,10,0
	bc 12,1,.L788
	lis 9,gi+8@ha
	lis 5,.LC60@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC60@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,30
	bl G_FreeEdict
	b .L731
.L788:
	addi 9,11,740
	mr 3,28
	lwzx 0,9,25
	subf 0,10,0
	stwx 0,9,25
	bl ValidateSelectedItem
.L731:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 Drop_Ammo,.Lfe11-Drop_Ammo
	.section	".rodata"
	.align 2
.LC61:
	.long 0x40a00000
	.align 2
.LC62:
	.long 0x0
	.align 2
.LC63:
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
	bc 4,2,.L800
	lwz 9,480(30)
	lwz 0,484(30)
	cmpw 0,9,0
	bc 4,0,.L811
.L800:
	lwz 0,480(30)
	lwz 9,532(31)
	cmpwi 0,0,249
	mr 11,0
	bc 4,1,.L802
	cmpwi 0,9,25
	bc 4,1,.L802
.L811:
	li 3,0
	b .L810
.L802:
	add 0,11,9
	cmpwi 0,0,250
	stw 0,480(30)
	bc 4,1,.L803
	lwz 0,532(31)
	cmpwi 0,0,25
	bc 4,1,.L803
	li 0,250
	stw 0,480(30)
.L803:
	lwz 0,644(31)
	andi. 9,0,1
	bc 4,2,.L804
	lwz 0,480(30)
	lwz 9,484(30)
	cmpw 0,0,9
	bc 4,1,.L804
	stw 9,480(30)
.L804:
	lwz 0,644(31)
	andi. 11,0,2
	bc 12,2,.L806
	mr 3,30
	bl CTFHasRegeneration
	mr. 3,3
	bc 4,2,.L806
	lis 9,MegaHealth_think@ha
	lis 8,.LC61@ha
	lwz 11,264(31)
	la 9,MegaHealth_think@l(9)
	lis 10,level+4@ha
	lwz 0,184(31)
	la 8,.LC61@l(8)
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
	b .L807
.L806:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L807
	lis 9,.LC62@ha
	lis 11,deathmatch@ha
	la 9,.LC62@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L807
	lwz 9,264(31)
	lis 11,.LC63@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC63@l(11)
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
.L807:
	li 3,1
.L810:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 Pickup_Health,.Lfe12-Pickup_Health
	.section	".rodata"
	.align 3
.LC64:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC65:
	.long 0x0
	.align 2
.LC66:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl Pickup_Armor
	.type	 Pickup_Armor,@function
Pickup_Armor:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 12,4
	mr 31,3
	lwz 11,84(12)
	lwz 9,648(31)
	cmpwi 0,11,0
	lwz 7,64(9)
	bc 4,2,.L818
	li 6,0
	b .L819
.L818:
	lis 9,jacket_armor_index@ha
	addi 8,11,740
	lwz 6,jacket_armor_index@l(9)
	slwi 0,6,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L819
	lis 9,combat_armor_index@ha
	lwz 6,combat_armor_index@l(9)
	slwi 0,6,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L819
	lis 9,body_armor_index@ha
	lwz 10,body_armor_index@l(9)
	slwi 11,10,2
	lwzx 9,8,11
	srawi 0,9,31
	subf 0,9,0
	srawi 0,0,31
	and 6,10,0
.L819:
	lwz 8,648(31)
	lwz 0,68(8)
	cmpwi 0,0,4
	bc 4,2,.L823
	cmpwi 0,6,0
	bc 4,2,.L824
	lis 11,jacket_armor_index@ha
	lwz 9,84(12)
	li 10,2
	lwz 0,jacket_armor_index@l(11)
	addi 9,9,740
	slwi 0,0,2
	stwx 10,9,0
	b .L826
.L824:
	lwz 9,84(12)
	slwi 0,6,2
	addi 9,9,740
	lwzx 11,9,0
	addi 11,11,2
	stwx 11,9,0
	b .L826
.L823:
	cmpwi 0,6,0
	bc 4,2,.L827
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(12)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,0(7)
	subf 9,9,8
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	stwx 10,11,9
	b .L826
.L827:
	lis 9,jacket_armor_index@ha
	lwz 0,jacket_armor_index@l(9)
	cmpw 0,6,0
	bc 4,2,.L829
	lis 9,jacketarmor_info@ha
	la 11,jacketarmor_info@l(9)
	b .L830
.L829:
	lis 9,combat_armor_index@ha
	lwz 0,combat_armor_index@l(9)
	cmpw 0,6,0
	bc 4,2,.L831
	lis 9,combatarmor_info@ha
	la 11,combatarmor_info@l(9)
	b .L830
.L831:
	lis 9,bodyarmor_info@ha
	la 11,bodyarmor_info@l(9)
.L830:
	lfs 13,8(7)
	lfs 0,8(11)
	fcmpu 0,13,0
	bc 4,1,.L833
	fdivs 11,0,13
	lwz 9,84(12)
	slwi 6,6,2
	lis 4,0x4330
	lis 10,.LC64@ha
	lwz 3,0(7)
	addi 9,9,740
	la 10,.LC64@l(10)
	lwz 7,4(7)
	lwzx 11,9,6
	li 0,0
	mr 5,8
	lfd 13,0(10)
	xoris 11,11,0x8000
	stwx 0,9,6
	lis 10,itemlist@ha
	stw 11,20(1)
	la 10,itemlist@l(10)
	lis 0,0x286b
	stw 4,16(1)
	ori 0,0,51739
	lfd 0,16(1)
	lwz 9,648(31)
	lwz 11,84(12)
	subf 9,10,9
	mullw 9,9,0
	addi 11,11,740
	rlwinm 9,9,0,0,29
	fsub 0,0,13
	frsp 0,0
	fmuls 0,11,0
	fmr 13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 0,20(1)
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
	b .L826
.L833:
	fdivs 11,13,0
	lwz 0,0(7)
	lis 8,0x4330
	lis 10,.LC64@ha
	mr 7,9
	lwz 11,4(11)
	xoris 0,0,0x8000
	la 10,.LC64@l(10)
	stw 0,20(1)
	slwi 6,6,2
	stw 8,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lwz 10,84(12)
	addi 4,10,740
	lwzx 10,4,6
	fsub 0,0,13
	frsp 0,0
	fmuls 0,11,0
	fmr 13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 0,20(1)
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
	bc 12,0,.L837
	li 3,0
	b .L840
.L837:
	stwx 0,4,6
.L826:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L838
	lis 9,.LC65@ha
	lis 11,deathmatch@ha
	la 9,.LC65@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L838
	lwz 9,264(31)
	lis 11,.LC66@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC66@l(11)
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
.L838:
	li 3,1
.L840:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 Pickup_Armor,.Lfe13-Pickup_Armor
	.section	".rodata"
	.align 2
.LC67:
	.string	"misc/power2.wav"
	.align 2
.LC68:
	.string	"No cells for power armor.\n"
	.align 2
.LC69:
	.string	"misc/power1.wav"
	.align 2
.LC70:
	.long 0x3f800000
	.align 2
.LC71:
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
	bc 12,2,.L847
	rlwinm 0,0,0,20,18
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(30)
	lis 3,.LC67@ha
	lwz 9,36(29)
	la 3,.LC67@l(3)
	mtlr 9
	blrl
	lis 9,.LC70@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC70@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC70@ha
	la 9,.LC70@l(9)
	lfs 2,0(9)
	lis 9,.LC71@ha
	la 9,.LC71@l(9)
	lfs 3,0(9)
	blrl
	b .L846
.L858:
	mr 10,29
	b .L855
.L847:
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lis 11,.LC13@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC13@l(11)
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L856
	mr 28,10
.L851:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L853
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L858
.L853:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,76
	cmpw 0,31,0
	bc 12,0,.L851
.L856:
	li 10,0
.L855:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L857
	lis 9,gi+8@ha
	lis 5,.LC68@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC68@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L846
.L857:
	lwz 0,264(30)
	lis 29,gi@ha
	lis 3,.LC69@ha
	la 29,gi@l(29)
	la 3,.LC69@l(3)
	ori 0,0,4096
	stw 0,264(30)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC70@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC70@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC70@ha
	la 9,.LC70@l(9)
	lfs 2,0(9)
	lis 9,.LC71@ha
	la 9,.LC71@l(9)
	lfs 3,0(9)
	blrl
.L846:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 Use_PowerArmor,.Lfe14-Use_PowerArmor
	.section	".rodata"
	.align 2
.LC72:
	.string	"items/s_health.wav"
	.align 2
.LC73:
	.string	"items/n_health.wav"
	.align 2
.LC74:
	.string	"items/l_health.wav"
	.align 2
.LC75:
	.string	"items/m_health.wav"
	.align 3
.LC76:
	.long 0x40080000
	.long 0x0
	.align 2
.LC77:
	.long 0x3f800000
	.align 2
.LC78:
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
	bc 12,2,.L865
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L865
	lwz 9,648(31)
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 12,2,.L865
	mtlr 0
	blrl
	mr. 28,3
	bc 12,2,.L869
	lwz 11,84(30)
	lis 0,0x3f00
	lis 9,gi@ha
	la 29,gi@l(9)
	stw 0,3748(11)
	lwz 9,648(31)
	lwz 11,40(29)
	lwz 3,36(9)
	mtlr 11
	blrl
	lis 9,itemlist@ha
	lwz 11,84(30)
	lis 8,0x286b
	la 7,itemlist@l(9)
	ori 8,8,51739
	lis 9,.LC76@ha
	sth 3,134(11)
	lis 10,level+4@ha
	la 9,.LC76@l(9)
	lwz 11,84(30)
	lfd 13,0(9)
	lwz 9,648(31)
	subf 9,7,9
	mullw 9,9,8
	srawi 9,9,2
	addi 9,9,1056
	sth 9,136(11)
	lfs 0,level+4@l(10)
	lwz 9,84(30)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3868(9)
	lwz 9,648(31)
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 12,2,.L870
	subf 0,7,9
	lwz 11,84(30)
	mullw 0,0,8
	srawi 0,0,2
	extsh 9,0
	sth 0,144(11)
	stw 9,736(11)
.L870:
	lwz 3,648(31)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	lwz 0,4(3)
	cmpw 0,0,9
	bc 4,2,.L871
	lwz 0,532(31)
	cmpwi 0,0,2
	bc 4,2,.L872
	lwz 9,36(29)
	lis 3,.LC72@ha
	la 3,.LC72@l(3)
	b .L886
.L872:
	cmpwi 0,0,10
	bc 4,2,.L874
	lwz 9,36(29)
	lis 3,.LC73@ha
	la 3,.LC73@l(3)
	b .L886
.L874:
	cmpwi 0,0,25
	bc 4,2,.L876
	lwz 9,36(29)
	lis 3,.LC74@ha
	la 3,.LC74@l(3)
	b .L886
.L876:
	lwz 9,36(29)
	lis 3,.LC75@ha
	la 3,.LC75@l(3)
.L886:
	mtlr 9
	blrl
	lis 9,.LC77@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC77@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC77@ha
	la 9,.LC77@l(9)
	lfs 2,0(9)
	lis 9,.LC78@ha
	la 9,.LC78@l(9)
	lfs 3,0(9)
	blrl
	b .L869
.L871:
	lwz 3,20(3)
	cmpwi 0,3,0
	bc 12,2,.L869
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC77@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC77@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC77@ha
	la 9,.LC77@l(9)
	lfs 2,0(9)
	lis 9,.LC78@ha
	la 9,.LC78@l(9)
	lfs 3,0(9)
	blrl
.L869:
	lwz 0,284(31)
	andis. 9,0,4
	bc 4,2,.L880
	mr 4,30
	mr 3,31
	bl G_UseTargets
	lwz 0,284(31)
	oris 0,0,0x4
	stw 0,284(31)
.L880:
	cmpwi 0,28,0
	bc 12,2,.L865
	lis 9,.LC78@ha
	lis 11,coop@ha
	la 9,.LC78@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L883
	lwz 9,648(31)
	lwz 0,56(9)
	andi. 9,0,8
	bc 12,2,.L883
	lwz 0,284(31)
	andis. 9,0,0x3
	bc 12,2,.L865
.L883:
	lwz 0,264(31)
	cmpwi 0,0,0
	bc 4,0,.L884
	rlwinm 0,0,0,1,31
	stw 0,264(31)
	b .L865
.L884:
	mr 3,31
	bl G_FreeEdict
.L865:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 Touch_Item,.Lfe15-Touch_Item
	.section	".rodata"
	.align 2
.LC79:
	.string	"1911"
	.align 2
.LC80:
	.long 0x42c80000
	.align 2
.LC81:
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
	lwz 8,0(29)
	mr 31,3
	lis 0,0x1
	stw 0,284(31)
	lis 9,0xc170
	lis 10,0x4170
	stw 8,280(31)
	lis 11,gi@ha
	stw 29,648(31)
	la 26,gi@l(11)
	lwz 0,28(29)
	stw 9,196(31)
	stw 0,64(31)
	stw 10,208(31)
	stw 9,188(31)
	stw 9,192(31)
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
	lfs 0,20(30)
	stfs 0,20(31)
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 12,2,.L901
	addi 29,1,24
	addi 4,1,8
	addi 3,3,3764
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
	b .L903
.L901:
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
.L903:
	stfs 0,12(31)
	lis 9,.LC80@ha
	addi 3,1,8
	la 9,.LC80@l(9)
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
	lis 9,.LC81@ha
	lfs 0,level+4@l(11)
	la 9,.LC81@l(9)
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
.LC82:
	.string	"droptofloor: %s startsolid at %s\n"
	.align 2
.LC83:
	.long 0xc1700000
	.align 2
.LC84:
	.long 0x41700000
	.align 2
.LC85:
	.long 0x0
	.align 2
.LC86:
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
	lis 9,.LC83@ha
	lis 11,.LC83@ha
	la 9,.LC83@l(9)
	la 11,.LC83@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC83@ha
	lfs 2,0(11)
	la 9,.LC83@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC84@ha
	lfs 13,0(11)
	la 9,.LC84@l(9)
	lfs 1,0(9)
	lis 9,.LC84@ha
	stfs 13,188(31)
	la 9,.LC84@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC84@ha
	stfs 0,192(31)
	la 9,.LC84@l(9)
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
	bc 12,2,.L908
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L909
.L908:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L909:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC85@ha
	stw 9,444(31)
	addi 29,31,4
	la 11,.LC85@l(11)
	lis 9,.LC86@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC86@l(9)
	lis 11,.LC85@ha
	lfs 3,0(9)
	la 11,.LC85@l(11)
	lfs 2,0(11)
	bl tv
	mr 11,3
	lfs 11,4(31)
	lis 9,gi@ha
	lfs 0,0(11)
	la 30,gi@l(9)
	addi 3,1,8
	lfs 12,8(31)
	mr 4,29
	addi 5,31,188
	lfs 13,12(31)
	addi 6,31,200
	addi 7,1,72
	fadds 11,11,0
	lwz 10,48(30)
	mr 8,31
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
	lwz 10,12(1)
	cmpwi 0,10,0
	bc 12,2,.L910
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC82@ha
	la 3,.LC82@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L907
.L910:
	lwz 0,308(31)
	lfs 12,20(1)
	lfs 0,24(1)
	cmpwi 0,0,0
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L911
	lwz 0,264(31)
	lwz 9,184(31)
	lwz 11,560(31)
	rlwinm 0,0,0,22,20
	ori 9,9,1
	stw 0,264(31)
	stw 11,536(31)
	stw 9,184(31)
	stw 10,560(31)
	stw 10,248(31)
.L911:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L912
	lwz 0,64(31)
	li 11,2
	lwz 9,68(31)
	rlwinm 0,0,0,0,30
	stw 11,248(31)
	rlwinm 9,9,0,23,21
	stw 0,64(31)
	stw 9,68(31)
	stw 10,444(31)
.L912:
	lwz 0,284(31)
	andi. 11,0,1
	bc 12,2,.L913
	lwz 0,184(31)
	lis 9,Use_Item@ha
	la 9,Use_Item@l(9)
	stw 10,248(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
.L913:
	lwz 0,72(30)
	mr 3,31
	mtlr 0
	blrl
.L907:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe17:
	.size	 droptofloor,.Lfe17-droptofloor
	.section	".rodata"
	.align 2
.LC87:
	.string	"PrecacheItem: %s has bad precache string"
	.align 2
.LC88:
	.string	"md2"
	.align 2
.LC89:
	.string	"sp2"
	.align 2
.LC90:
	.string	"wav"
	.align 2
.LC91:
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
	bc 12,2,.L914
	lwz 3,20(26)
	cmpwi 0,3,0
	bc 12,2,.L916
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L916:
	lwz 3,24(26)
	cmpwi 0,3,0
	bc 12,2,.L917
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L917:
	lwz 3,32(26)
	cmpwi 0,3,0
	bc 12,2,.L918
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L918:
	lwz 3,36(26)
	cmpwi 0,3,0
	bc 12,2,.L919
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
.L919:
	lwz 29,52(26)
	cmpwi 0,29,0
	bc 12,2,.L920
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L920
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L928
	mr 28,9
.L923:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L925
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L925
	mr 3,31
	b .L927
.L925:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L923
.L928:
	li 3,0
.L927:
	cmpw 0,3,26
	bc 12,2,.L920
	bl PrecacheItem
.L920:
	lwz 30,72(26)
	cmpwi 0,30,0
	bc 12,2,.L914
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 12,2,.L914
	lis 9,gi@ha
	addi 29,1,8
	la 27,gi@l(9)
	lis 24,.LC88@ha
	lis 25,.LC91@ha
.L934:
	rlwinm 9,0,0,0xff
	mr 31,30
	b .L948
.L937:
	lbzu 9,1(30)
.L948:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L937
	subf 28,31,30
	addi 0,28,-5
	cmplwi 0,0,58
	bc 4,1,.L939
	lwz 9,28(27)
	lis 3,.LC87@ha
	la 3,.LC87@l(3)
	lwz 4,0(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L939:
	mr 4,31
	mr 5,28
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 0,0
	addi 11,30,1
	stbx 0,29,28
	add 9,29,28
	la 4,.LC88@l(24)
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
	bc 12,2,.L949
	lis 4,.LC89@ha
	mr 3,31
	la 4,.LC89@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L943
.L949:
	lwz 9,32(27)
	mr 3,29
	mtlr 9
	blrl
	b .L942
.L943:
	lis 4,.LC90@ha
	mr 3,31
	la 4,.LC90@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L942
	lwz 9,36(27)
	mr 3,29
	mtlr 9
	blrl
.L942:
	add 3,29,28
	la 4,.LC91@l(25)
	addi 3,3,-3
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L932
	lwz 9,40(27)
	mr 3,29
	mtlr 9
	blrl
.L932:
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L934
.L914:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe18:
	.size	 PrecacheItem,.Lfe18-PrecacheItem
	.section	".rodata"
	.align 2
.LC92:
	.string	"%s at %s has invalid spawnflags set\n"
	.align 2
.LC93:
	.string	"weapon_bfg"
	.align 2
.LC94:
	.string	"item_flag_team1"
	.align 2
.LC95:
	.string	"item_flag_team2"
	.align 2
.LC96:
	.string	"item_detonator"
	.align 2
.LC97:
	.string	"ammo_grenades"
	.align 2
.LC98:
	.string	"weapon_mine"
	.align 2
.LC99:
	.string	"weapon_c4"
	.align 3
.LC100:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC101:
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
	bc 12,2,.L951
	lwz 3,280(31)
	lis 4,.LC28@ha
	la 4,.LC28@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L951
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
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L951:
	lis 9,.LC101@ha
	lis 11,deathmatch@ha
	la 9,.LC101@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L953
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2048
	bc 12,2,.L954
	lwz 0,4(30)
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L973
	lis 9,Pickup_PowerArmor@ha
	la 9,Pickup_PowerArmor@l(9)
	cmpw 0,0,9
	bc 12,2,.L973
.L954:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 12,2,.L957
	lwz 0,4(30)
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L973
.L957:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 12,2,.L959
	lwz 0,4(30)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L973
	lis 9,Pickup_Adrenaline@ha
	la 9,Pickup_Adrenaline@l(9)
	cmpw 0,0,9
	bc 12,2,.L973
	lis 9,Pickup_AncientHead@ha
	la 9,Pickup_AncientHead@l(9)
	cmpw 0,0,9
	bc 12,2,.L973
.L959:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8192
	bc 12,2,.L953
	lwz 0,56(30)
	cmpwi 0,0,2
	bc 12,2,.L973
	lwz 3,280(31)
	lis 4,.LC93@ha
	la 4,.LC93@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L973
.L953:
	lis 9,.LC101@ha
	lis 11,coop@ha
	la 9,.LC101@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L965
	lwz 3,280(31)
	lis 4,.LC28@ha
	la 4,.LC28@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L965
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
.L965:
	lis 9,.LC101@ha
	lis 11,coop@ha
	la 9,.LC101@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L966
	lwz 0,56(30)
	andi. 9,0,8
	bc 12,2,.L966
	li 0,0
	stw 0,12(30)
.L966:
	lis 9,.LC101@ha
	lis 11,ctf@ha
	la 9,.LC101@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L967
	lwz 3,280(31)
	lis 4,.LC94@ha
	la 4,.LC94@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L973
	lwz 3,280(31)
	lis 4,.LC95@ha
	la 4,.LC95@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L973
.L967:
	lis 9,.LC101@ha
	lis 11,leader@ha
	la 9,.LC101@l(9)
	lfs 13,0(9)
	lwz 9,leader@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L969
	lwz 3,280(31)
	lis 4,.LC94@ha
	la 4,.LC94@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L973
	lwz 3,280(31)
	lis 4,.LC95@ha
	la 4,.LC95@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L973
.L969:
	lis 9,.LC101@ha
	lis 11,explosives@ha
	la 9,.LC101@l(9)
	lfs 13,0(9)
	lwz 9,explosives@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L971
	lwz 3,280(31)
	lis 4,.LC96@ha
	la 4,.LC96@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L973
	lwz 3,280(31)
	lis 4,.LC97@ha
	la 4,.LC97@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L973
	lwz 3,280(31)
	lis 4,.LC98@ha
	la 4,.LC98@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L973
	lwz 3,280(31)
	lis 4,.LC99@ha
	la 4,.LC99@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L971
.L973:
	mr 3,31
	bl G_FreeEdict
	b .L950
.L971:
	stw 30,648(31)
	lis 11,level+4@ha
	lis 10,.LC100@ha
	lfs 0,level+4@l(11)
	lis 9,droptofloor@ha
	lfd 13,.LC100@l(10)
	la 9,droptofloor@l(9)
	li 11,0
	lwz 3,268(31)
	stw 9,436(31)
	cmpwi 0,3,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,28(30)
	stw 11,68(31)
	stw 0,64(31)
	bc 12,2,.L974
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L974:
	lwz 3,280(31)
	lis 4,.LC94@ha
	la 4,.LC94@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L975
	lis 9,CTFFlagSetup@ha
	la 9,CTFFlagSetup@l(9)
	stw 9,436(31)
.L975:
	lwz 3,280(31)
	lis 4,.LC95@ha
	la 4,.LC95@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L950
	lis 9,CTFFlagSetup@ha
	la 9,CTFFlagSetup@l(9)
	stw 9,436(31)
.L950:
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
	.space	72
	.long 0
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC102
	.long .LC103
	.long 1
	.long 0
	.long .LC104
	.long .LC105
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long bodyarmor_info
	.long 3
	.long .LC106
	.long 0
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC102
	.long .LC107
	.long 1
	.long 0
	.long .LC108
	.long .LC109
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long combatarmor_info
	.long 2
	.long .LC106
	.long .LC110
	.long Pickup_Item
	.long 0
	.long Drop_SpecialItem
	.long 0
	.long .LC102
	.long .LC111
	.long 0
	.long 0
	.long .LC112
	.long .LC113
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long 0
	.long 1
	.long .LC106
	.long .LC114
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC102
	.long .LC115
	.long 1
	.long 0
	.long .LC116
	.long .LC117
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long jacketarmor_info
	.long 1
	.long .LC106
	.long 0
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC118
	.long .LC119
	.long 1
	.long 0
	.long .LC116
	.long .LC120
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long 0
	.long 4
	.long .LC106
	.long .LC121
	.long Pickup_Item
	.long 0
	.long Drop_SpecialItem
	.long 0
	.long .LC118
	.long .LC122
	.long 0
	.long 0
	.long .LC123
	.long .LC38
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long 0
	.long 4
	.long .LC106
	.long .LC114
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC124
	.long .LC125
	.long 1
	.long 0
	.long .LC126
	.long .LC127
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC128
	.long Pickup_Item
	.long 0
	.long Drop_SpecialItem
	.long 0
	.long .LC124
	.long .LC129
	.long 0
	.long 0
	.long .LC130
	.long .LC39
	.long 0
	.long 0
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long 0
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC124
	.long .LC131
	.long 1
	.long 0
	.long .LC132
	.long .LC133
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC134
	.long .LC135
	.long Pickup_Item
	.long 0
	.long Drop_SpecialItem
	.long 0
	.long .LC102
	.long .LC136
	.long 0
	.long 0
	.long .LC137
	.long .LC40
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC138
	.long Pickup_Item
	.long 0
	.long Drop_SpecialItem
	.long 0
	.long .LC102
	.long .LC139
	.long 0
	.long 0
	.long .LC140
	.long .LC42
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC141
	.long Pickup_Item
	.long 0
	.long Drop_SpecialItem
	.long 0
	.long .LC102
	.long .LC142
	.long 0
	.long 0
	.long .LC143
	.long .LC41
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC102
	.long .LC142
	.long 0
	.long 0
	.long .LC143
	.long .LC144
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC145
	.long 0
	.long Use_Weapon
	.long 0
	.long CTFWeapon_Grapple
	.long .LC146
	.long 0
	.long 0
	.long .LC147
	.long .LC148
	.long .LC149
	.long 0
	.long 0
	.long 0
	.long 9
	.long 12
	.long 0
	.long 0
	.long .LC150
	.long .LC151
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Blaster
	.long .LC146
	.long .LC152
	.long 0
	.long .LC153
	.long .LC154
	.long .LC79
	.long 0
	.long 1
	.long .LC6
	.long 9
	.long 2
	.long 0
	.long 0
	.long .LC155
	.long .LC156
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Shotgun
	.long .LC146
	.long .LC157
	.long 0
	.long .LC158
	.long .LC159
	.long .LC160
	.long 0
	.long 1
	.long .LC9
	.long 9
	.long 3
	.long 0
	.long 0
	.long .LC161
	.long 0
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_SuperShotgun
	.long .LC146
	.long .LC162
	.long 0
	.long .LC163
	.long .LC164
	.long .LC165
	.long 0
	.long 2
	.long .LC10
	.long 9
	.long 3
	.long 0
	.long 0
	.long .LC166
	.long .LC167
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Machinegun
	.long .LC146
	.long .LC168
	.long 0
	.long .LC169
	.long .LC170
	.long .LC171
	.long 0
	.long 1
	.long .LC7
	.long 9
	.long 4
	.long 0
	.long 0
	.long .LC172
	.long 0
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Chaingun
	.long .LC146
	.long .LC173
	.long 0
	.long .LC174
	.long .LC175
	.long .LC176
	.long 0
	.long 1
	.long .LC5
	.long 9
	.long 5
	.long 0
	.long 0
	.long .LC177
	.long .LC97
	.long Pickup_Ammo
	.long Use_Weapon
	.long Drop_Ammo
	.long Weapon_Grenade
	.long .LC178
	.long .LC179
	.long 0
	.long .LC180
	.long .LC181
	.long .LC14
	.long 3
	.long 1
	.long .LC55
	.long 3
	.long 11
	.long 0
	.long 3
	.long .LC182
	.long 0
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_GrenadeLauncher
	.long .LC146
	.long .LC183
	.long 0
	.long .LC184
	.long .LC185
	.long .LC186
	.long 0
	.long 1
	.long .LC55
	.long 9
	.long 7
	.long 0
	.long 0
	.long .LC187
	.long 0
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_RocketLauncher
	.long .LC146
	.long .LC188
	.long 0
	.long .LC189
	.long .LC190
	.long .LC191
	.long 0
	.long 1
	.long .LC15
	.long 9
	.long 8
	.long 0
	.long 0
	.long .LC192
	.long 0
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_HyperBlaster
	.long .LC146
	.long .LC193
	.long 0
	.long .LC194
	.long .LC195
	.long .LC196
	.long 0
	.long 1
	.long .LC14
	.long 9
	.long 9
	.long 0
	.long 0
	.long .LC197
	.long .LC198
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Railgun
	.long .LC146
	.long .LC199
	.long 0
	.long .LC200
	.long .LC201
	.long .LC202
	.long 0
	.long 1
	.long .LC8
	.long 9
	.long 7
	.long 0
	.long 0
	.long .LC106
	.long 0
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_BFG
	.long .LC146
	.long .LC203
	.long 0
	.long .LC204
	.long .LC205
	.long .LC206
	.long 0
	.long 50
	.long .LC13
	.long 9
	.long 11
	.long 0
	.long 0
	.long .LC106
	.long .LC99
	.long Pickup_Ammo
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_C4
	.long .LC146
	.long .LC193
	.long 0
	.long .LC194
	.long .LC207
	.long .LC58
	.long 0
	.long 1
	.long .LC54
	.long 9
	.long 8
	.long 0
	.long 0
	.long .LC106
	.long .LC96
	.long Pickup_NoAmmo_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Detonator
	.long .LC146
	.long .LC208
	.long 0
	.long .LC209
	.long .LC210
	.long .LC211
	.long 0
	.long 0
	.long 0
	.long 9
	.long 10
	.long 0
	.long 0
	.long .LC106
	.long .LC93
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_AK
	.long .LC146
	.long .LC212
	.long 0
	.long .LC213
	.long .LC214
	.long .LC215
	.long 0
	.long 1
	.long .LC216
	.long 9
	.long 5
	.long 0
	.long 0
	.long .LC106
	.long .LC217
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Glock
	.long .LC146
	.long .LC218
	.long 0
	.long .LC219
	.long .LC220
	.long .LC221
	.long 0
	.long 1
	.long .LC222
	.long 9
	.long 6
	.long 0
	.long 0
	.long .LC106
	.long .LC223
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Casull
	.long .LC146
	.long .LC224
	.long 0
	.long .LC225
	.long .LC226
	.long .LC227
	.long 0
	.long 1
	.long .LC228
	.long 9
	.long 12
	.long 0
	.long 0
	.long .LC106
	.long .LC229
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Beretta
	.long .LC146
	.long .LC230
	.long 0
	.long .LC231
	.long .LC232
	.long .LC233
	.long 0
	.long 1
	.long .LC234
	.long 9
	.long 13
	.long 0
	.long 0
	.long .LC106
	.long .LC235
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_MP5
	.long .LC146
	.long .LC236
	.long 0
	.long .LC237
	.long .LC238
	.long .LC239
	.long 0
	.long 1
	.long .LC240
	.long 9
	.long 14
	.long 0
	.long 0
	.long .LC106
	.long .LC241
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_M60
	.long .LC146
	.long .LC242
	.long 0
	.long .LC243
	.long .LC244
	.long .LC245
	.long 0
	.long 1
	.long .LC246
	.long 9
	.long 15
	.long 0
	.long 0
	.long .LC106
	.long .LC247
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_MSG90
	.long .LC146
	.long .LC248
	.long 0
	.long .LC249
	.long .LC250
	.long .LC251
	.long 0
	.long 1
	.long .LC252
	.long 9
	.long 16
	.long 0
	.long 0
	.long .LC106
	.long .LC253
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Kick
	.long .LC146
	.long 0
	.long 0
	.long .LC254
	.long .LC195
	.long .LC255
	.long 0
	.long 0
	.long 0
	.long 9
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC256
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Bush
	.long .LC146
	.long 0
	.long 0
	.long .LC257
	.long .LC258
	.long .LC259
	.long 0
	.long 0
	.long 0
	.long 9
	.long 1
	.long 0
	.long 0
	.long .LC106
	.long .LC98
	.long Pickup_Ammo
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Mine
	.long .LC146
	.long .LC260
	.long 0
	.long .LC261
	.long .LC262
	.long .LC59
	.long 0
	.long 1
	.long .LC53
	.long 9
	.long 9
	.long 0
	.long 0
	.long .LC106
	.long .LC263
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC178
	.long .LC264
	.long 0
	.long 0
	.long .LC265
	.long .LC10
	.long 3
	.long 9
	.long 0
	.long 2
	.long 0
	.long 0
	.long 1
	.long .LC106
	.long .LC266
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC178
	.long .LC267
	.long 0
	.long 0
	.long .LC268
	.long .LC5
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC6
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC178
	.long 0
	.long 0
	.long 0
	.long .LC269
	.long .LC6
	.long 3
	.long 30
	.long 0
	.long 2
	.long 0
	.long 0
	.long 6
	.long .LC106
	.long .LC216
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC178
	.long 0
	.long 0
	.long 0
	.long .LC270
	.long .LC271
	.long 3
	.long 40
	.long 0
	.long 2
	.long 0
	.long 0
	.long 10
	.long .LC106
	.long .LC272
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC178
	.long .LC273
	.long 0
	.long 0
	.long .LC274
	.long .LC275
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 11
	.long .LC106
	.long .LC222
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC178
	.long 0
	.long 0
	.long 0
	.long .LC276
	.long .LC277
	.long 3
	.long 17
	.long 0
	.long 2
	.long 0
	.long 0
	.long 12
	.long .LC106
	.long .LC278
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC178
	.long .LC279
	.long 0
	.long 0
	.long .LC280
	.long .LC281
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 13
	.long .LC106
	.long .LC282
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC178
	.long .LC283
	.long 0
	.long 0
	.long .LC284
	.long .LC285
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC286
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC287
	.long .LC288
	.long 3
	.long 5
	.long 0
	.long 2
	.long 0
	.long 0
	.long 14
	.long .LC106
	.long .LC289
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC178
	.long .LC290
	.long 0
	.long 0
	.long .LC291
	.long .LC292
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC293
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC294
	.long .LC295
	.long 3
	.long 15
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC296
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC178
	.long .LC297
	.long 0
	.long 0
	.long .LC298
	.long .LC299
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC300
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC301
	.long .LC302
	.long 3
	.long 32
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC303
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC178
	.long .LC304
	.long 0
	.long 0
	.long .LC305
	.long .LC306
	.long 3
	.long 200
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC307
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC308
	.long .LC309
	.long 3
	.long 200
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC310
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC178
	.long .LC311
	.long 0
	.long 0
	.long .LC312
	.long .LC313
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC314
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC315
	.long .LC316
	.long 3
	.long 20
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC317
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC178
	.long 0
	.long 0
	.long 0
	.long .LC318
	.long .LC7
	.long 3
	.long 30
	.long 0
	.long 2
	.long 0
	.long 0
	.long 7
	.long .LC106
	.long .LC319
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC178
	.long 0
	.long 0
	.long 0
	.long .LC320
	.long .LC8
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 8
	.long .LC106
	.long .LC321
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC178
	.long 0
	.long 0
	.long 0
	.long .LC322
	.long .LC9
	.long 3
	.long 9
	.long 0
	.long 2
	.long 0
	.long 0
	.long 9
	.long .LC106
	.long .LC323
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC178
	.long .LC324
	.long 0
	.long 0
	.long .LC325
	.long .LC13
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 4
	.long .LC106
	.long 0
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC178
	.long .LC326
	.long 0
	.long 0
	.long .LC327
	.long .LC15
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 2
	.long .LC106
	.long .LC328
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC178
	.long .LC329
	.long 0
	.long 0
	.long .LC330
	.long .LC16
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long 5
	.long .LC106
	.long 0
	.long Pickup_Powerup
	.long Use_Quad
	.long Drop_General
	.long 0
	.long .LC331
	.long .LC332
	.long 1
	.long 0
	.long .LC333
	.long .LC334
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC335
	.long .LC114
	.long Pickup_Powerup
	.long Use_Invulnerability
	.long Drop_General
	.long 0
	.long .LC331
	.long .LC336
	.long 1
	.long 0
	.long .LC337
	.long .LC338
	.long 2
	.long 300
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC339
	.long .LC114
	.long Pickup_Powerup
	.long Use_Silencer
	.long Drop_General
	.long 0
	.long .LC331
	.long .LC340
	.long 1
	.long 0
	.long .LC341
	.long .LC342
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC114
	.long Pickup_Powerup
	.long Use_Breather
	.long Drop_General
	.long 0
	.long .LC331
	.long .LC343
	.long 1
	.long 0
	.long .LC344
	.long .LC345
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long 0
	.long .LC346
	.long .LC114
	.long Pickup_Powerup
	.long Use_Envirosuit
	.long Drop_General
	.long 0
	.long .LC331
	.long .LC347
	.long 1
	.long 0
	.long .LC348
	.long .LC349
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long 0
	.long .LC346
	.long .LC114
	.long Pickup_AncientHead
	.long 0
	.long 0
	.long 0
	.long .LC331
	.long .LC350
	.long 1
	.long 0
	.long .LC351
	.long .LC352
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC114
	.long Pickup_Adrenaline
	.long 0
	.long 0
	.long 0
	.long .LC331
	.long .LC353
	.long 1
	.long 0
	.long .LC354
	.long .LC355
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC114
	.long Pickup_Bandolier
	.long 0
	.long 0
	.long 0
	.long .LC331
	.long .LC356
	.long 1
	.long 0
	.long .LC357
	.long .LC358
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC114
	.long Pickup_Pack
	.long 0
	.long 0
	.long 0
	.long .LC331
	.long .LC359
	.long 1
	.long 0
	.long .LC360
	.long .LC361
	.long 2
	.long 180
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC362
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC331
	.long .LC363
	.long 0
	.long 0
	.long .LC364
	.long .LC365
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC28
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC331
	.long .LC366
	.long 0
	.long 0
	.long .LC367
	.long .LC368
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC369
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC331
	.long .LC370
	.long 0
	.long 0
	.long .LC371
	.long .LC372
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC373
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC331
	.long .LC374
	.long 0
	.long 0
	.long .LC375
	.long .LC376
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC377
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC331
	.long .LC378
	.long 0
	.long 0
	.long .LC379
	.long .LC380
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC381
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC331
	.long .LC382
	.long 0
	.long 0
	.long .LC383
	.long .LC384
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC385
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC331
	.long .LC386
	.long 0
	.long 0
	.long .LC387
	.long .LC388
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC389
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC331
	.long .LC390
	.long 0
	.long 0
	.long .LC391
	.long .LC392
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long .LC393
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC331
	.long .LC394
	.long 0
	.long 0
	.long .LC395
	.long .LC396
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC106
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC331
	.long 0
	.long 0
	.long 0
	.long .LC397
	.long .LC398
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC399
	.long .LC94
	.long CTFPickup_Flag
	.long 0
	.long CTFDrop_Flag
	.long 0
	.long .LC400
	.long .LC401
	.long 0
	.long 0
	.long .LC402
	.long .LC403
	.long 2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC404
	.long .LC95
	.long CTFPickup_Flag
	.long 0
	.long CTFDrop_Flag
	.long 0
	.long .LC400
	.long .LC401
	.long 0
	.long 0
	.long .LC405
	.long .LC406
	.long 2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC404
	.long 0
	.space	72
	.section	".rodata"
	.align 2
.LC406:
	.string	"Confiscated Drugpack"
	.align 2
.LC405:
	.string	"i_ctf2"
	.align 2
.LC404:
	.string	"ctf/flagcap.wav"
	.align 2
.LC403:
	.string	"Illegal Drugpack"
	.align 2
.LC402:
	.string	"i_ctf1"
	.align 2
.LC401:
	.string	"models/slat/drug/drug.md2"
	.align 2
.LC400:
	.string	"ctf/flagtk.wav"
	.align 2
.LC399:
	.string	"items/s_health.wav items/n_health.wav items/l_health.wav items/m_health.wav"
	.align 2
.LC398:
	.string	"Health"
	.align 2
.LC397:
	.string	"i_health"
	.align 2
.LC396:
	.string	"Airstrike Marker"
	.align 2
.LC395:
	.string	"i_airstrike"
	.align 2
.LC394:
	.string	"models/slat/key_radio/key_radio.md2"
	.align 2
.LC393:
	.string	"key_airstrike_target"
	.align 2
.LC392:
	.string	"Commander's Head"
	.align 2
.LC391:
	.string	"k_comhead"
	.align 2
.LC390:
	.string	"models/slat/key_id/key_id.md2"
	.align 2
.LC389:
	.string	"key_commander_head"
	.align 2
.LC388:
	.string	"Red Key"
	.align 2
.LC387:
	.string	"k_redkey"
	.align 2
.LC386:
	.string	"models/slat/key_key/key_key.md2"
	.align 2
.LC385:
	.string	"key_red_key"
	.align 2
.LC384:
	.string	"Blue Key"
	.align 2
.LC383:
	.string	"k_bluekey"
	.align 2
.LC382:
	.string	"models/slat/key_key2/key_key2.md2"
	.align 2
.LC381:
	.string	"key_blue_key"
	.align 2
.LC380:
	.string	"Security Pass"
	.align 2
.LC379:
	.string	"k_security"
	.align 2
.LC378:
	.string	"models/slat/key_pass/key_pass.md2"
	.align 2
.LC377:
	.string	"key_pass"
	.align 2
.LC376:
	.string	"Data Spinner"
	.align 2
.LC375:
	.string	"k_dataspin"
	.align 2
.LC374:
	.string	"models/slat/key_laptop/key_laptop.md2"
	.align 2
.LC373:
	.string	"key_data_spinner"
	.align 2
.LC372:
	.string	"Pyramid Key"
	.align 2
.LC371:
	.string	"k_pyramid"
	.align 2
.LC370:
	.string	"models/slat/key_security/key_security.md2"
	.align 2
.LC369:
	.string	"key_pyramid"
	.align 2
.LC368:
	.string	"Power Cube"
	.align 2
.LC367:
	.string	"k_powercube"
	.align 2
.LC366:
	.string	"models/slat/key_battery/key_battery.md2"
	.align 2
.LC365:
	.string	"Data CD"
	.align 2
.LC364:
	.string	"k_datacd"
	.align 2
.LC363:
	.string	"models/slat/key_cd/key_cd.md2"
	.align 2
.LC362:
	.string	"key_data_cd"
	.align 2
.LC361:
	.string	"Ammo Pack"
	.align 2
.LC360:
	.string	"i_pack"
	.align 2
.LC359:
	.string	"models/items/pack/tris.md2"
	.align 2
.LC358:
	.string	"Bandolier"
	.align 2
.LC357:
	.string	"p_bandolier"
	.align 2
.LC356:
	.string	"models/items/band/tris.md2"
	.align 2
.LC355:
	.string	"Adrenaline"
	.align 2
.LC354:
	.string	"p_adrenaline"
	.align 2
.LC353:
	.string	"models/items/adrenal/tris.md2"
	.align 2
.LC352:
	.string	"Ancient Head"
	.align 2
.LC351:
	.string	"i_fixme"
	.align 2
.LC350:
	.string	"models/items/c_head/tris.md2"
	.align 2
.LC349:
	.string	"Environment Suit"
	.align 2
.LC348:
	.string	"p_envirosuit"
	.align 2
.LC347:
	.string	"models/items/enviro/tris.md2"
	.align 2
.LC346:
	.string	"items/airout.wav"
	.align 2
.LC345:
	.string	"Rebreather"
	.align 2
.LC344:
	.string	"p_rebreather"
	.align 2
.LC343:
	.string	"models/items/breather/tris.md2"
	.align 2
.LC342:
	.string	"Silencer"
	.align 2
.LC341:
	.string	"p_silencer"
	.align 2
.LC340:
	.string	"models/items/silencer/tris.md2"
	.align 2
.LC339:
	.string	"items/protect.wav items/protect2.wav items/protect4.wav"
	.align 2
.LC338:
	.string	"Invulnerability"
	.align 2
.LC337:
	.string	"p_invulnerability"
	.align 2
.LC336:
	.string	"models/items/invulner/tris.md2"
	.align 2
.LC335:
	.string	"items/damage.wav items/damage2.wav items/damage3.wav"
	.align 2
.LC334:
	.string	"Quad Damage"
	.align 2
.LC333:
	.string	"p_quad"
	.align 2
.LC332:
	.string	"models/items/quaddama/tris.md2"
	.align 2
.LC331:
	.string	"items/pkup.wav"
	.align 2
.LC330:
	.string	"a_barrettclp"
	.align 2
.LC329:
	.string	"models/slat/world_barrett/barrett_clip.md2"
	.align 2
.LC328:
	.string	"ammo_slugs"
	.align 2
.LC327:
	.string	"a_rockets"
	.align 2
.LC326:
	.string	"models/items/ammo/rockets/medium/tris.md2"
	.align 2
.LC325:
	.string	"a_1911clp"
	.align 2
.LC324:
	.string	"models/slat/world_t1911/t1911_clip.md2"
	.align 2
.LC323:
	.string	"ammo_bullets"
	.align 2
.LC322:
	.string	"a_marinerrds"
	.align 2
.LC321:
	.string	"ammo_MARINERrounds"
	.align 2
.LC320:
	.string	"a_barrettrds"
	.align 2
.LC319:
	.string	"barrettrounds"
	.align 2
.LC318:
	.string	"a_uzirds"
	.align 2
.LC317:
	.string	"uzi_rounds"
	.align 2
.LC316:
	.string	"MSG90rounds"
	.align 2
.LC315:
	.string	"a_msg90rds"
	.align 2
.LC314:
	.string	"msg90_rounds"
	.align 2
.LC313:
	.string	"MSG90clip"
	.align 2
.LC312:
	.string	"a_msg90clp"
	.align 2
.LC311:
	.string	"models/slat/world_msg90/msg90_clip.md2"
	.align 2
.LC310:
	.string	"ammo_msg90"
	.align 2
.LC309:
	.string	"M60rounds"
	.align 2
.LC308:
	.string	"a_m60rds"
	.align 2
.LC307:
	.string	"m60_rounds"
	.align 2
.LC306:
	.string	"M60ammo"
	.align 2
.LC305:
	.string	"a_m60clp"
	.align 2
.LC304:
	.string	"models/slat/world_m60/m60_clip.md2"
	.align 2
.LC303:
	.string	"ammo_m60"
	.align 2
.LC302:
	.string	"MP5rounds"
	.align 2
.LC301:
	.string	"a_mp5rds"
	.align 2
.LC300:
	.string	"mp5_rounds"
	.align 2
.LC299:
	.string	"MP5clip"
	.align 2
.LC298:
	.string	"a_mp5clp"
	.align 2
.LC297:
	.string	"models/slat/world_mp5/mp5_clip.md2"
	.align 2
.LC296:
	.string	"ammo_mp5"
	.align 2
.LC295:
	.string	"BERETTArounds"
	.align 2
.LC294:
	.string	"a_berettards"
	.align 2
.LC293:
	.string	"beretta_rounds"
	.align 2
.LC292:
	.string	"BERETTAclip"
	.align 2
.LC291:
	.string	"a_berettaclp"
	.align 2
.LC290:
	.string	"models/slat/world_beretta/beretta_clip.md2"
	.align 2
.LC289:
	.string	"ammo_beretta"
	.align 2
.LC288:
	.string	"CASULLrounds"
	.align 2
.LC287:
	.string	"a_casullrds"
	.align 2
.LC286:
	.string	"casull_rounds"
	.align 2
.LC285:
	.string	"CASULLbullets"
	.align 2
.LC284:
	.string	"a_casullclp"
	.align 2
.LC283:
	.string	"models/slat/world_casull/casull_clip.md2"
	.align 2
.LC282:
	.string	"ammo_casull"
	.align 2
.LC281:
	.string	"GLOCKclip"
	.align 2
.LC280:
	.string	"a_glockclp"
	.align 2
.LC279:
	.string	"models/slat/world_glock/glock_clip.md2"
	.align 2
.LC278:
	.string	"ammo_glock"
	.align 2
.LC277:
	.string	"GLOCKrounds"
	.align 2
.LC276:
	.string	"a_glockrds"
	.align 2
.LC275:
	.string	"AK47 clip"
	.align 2
.LC274:
	.string	"a_ak47clp"
	.align 2
.LC273:
	.string	"models/slat/world_ak47/ak47_clip.md2"
	.align 2
.LC272:
	.string	"ammo_cells"
	.align 2
.LC271:
	.string	"AK47rounds"
	.align 2
.LC270:
	.string	"a_ak47rds"
	.align 2
.LC269:
	.string	"a_1911rds"
	.align 2
.LC268:
	.string	"a_uziclp"
	.align 2
.LC267:
	.string	"models/slat/world_uzi/uzi_clip.md2"
	.align 2
.LC266:
	.string	"ammo_rockets"
	.align 2
.LC265:
	.string	"a_shells"
	.align 2
.LC264:
	.string	"models/slat/world_mossberg/mossberg_clip.md2"
	.align 2
.LC263:
	.string	"ammo_shells"
	.align 2
.LC262:
	.string	"a_mine"
	.align 2
.LC261:
	.string	"models/slat/mine/mine.md2"
	.align 2
.LC260:
	.string	"models/slat/world_mine/world_mine.md2"
	.align 2
.LC259:
	.string	"Bush Knife"
	.align 2
.LC258:
	.string	"w_bushknife"
	.align 2
.LC257:
	.string	"models/slat/bushknife/bushknife.md2"
	.align 2
.LC256:
	.string	"weapon_bushknife"
	.align 2
.LC255:
	.string	"Trusty Leg"
	.align 2
.LC254:
	.string	"models/slat/leg/leg.md2"
	.align 2
.LC253:
	.string	"weapon_kick"
	.align 2
.LC252:
	.string	"msg90rounds"
	.align 2
.LC251:
	.string	"MSG90"
	.align 2
.LC250:
	.string	"w_msg90"
	.align 2
.LC249:
	.string	"models/slat/msg90/msg90.md2"
	.align 2
.LC248:
	.string	"models/slat/world_msg90/world_msg90.md2"
	.align 2
.LC247:
	.string	"weapon_msg90"
	.align 2
.LC246:
	.string	"m60rounds"
	.align 2
.LC245:
	.string	"M60"
	.align 2
.LC244:
	.string	"w_m60"
	.align 2
.LC243:
	.string	"models/slat/m60/m60.md2"
	.align 2
.LC242:
	.string	"models/slat/world_m60/world_m60.md2"
	.align 2
.LC241:
	.string	"weapon_m60"
	.align 2
.LC240:
	.string	"mp5rounds"
	.align 2
.LC239:
	.string	"MP5"
	.align 2
.LC238:
	.string	"w_mp5"
	.align 2
.LC237:
	.string	"models/slat/mp5/mp5.md2"
	.align 2
.LC236:
	.string	"models/slat/world_mp5/world_mp5.md2"
	.align 2
.LC235:
	.string	"weapon_mp5"
	.align 2
.LC234:
	.string	"berettarounds"
	.align 2
.LC233:
	.string	"BERETTA"
	.align 2
.LC232:
	.string	"w_beretta"
	.align 2
.LC231:
	.string	"models/slat/beretta/beretta.md2"
	.align 2
.LC230:
	.string	"models/slat/world_beretta/world_beretta.md2"
	.align 2
.LC229:
	.string	"weapon_beretta"
	.align 2
.LC228:
	.string	"casullrounds"
	.align 2
.LC227:
	.string	"CASULL"
	.align 2
.LC226:
	.string	"w_casull"
	.align 2
.LC225:
	.string	"models/slat/casull/casull.md2"
	.align 2
.LC224:
	.string	"models/slat/world_casull/world_casull.md2"
	.align 2
.LC223:
	.string	"weapon_casull"
	.align 2
.LC222:
	.string	"glockrounds"
	.align 2
.LC221:
	.string	"Glock"
	.align 2
.LC220:
	.string	"w_glock"
	.align 2
.LC219:
	.string	"models/slat/glock/glock.md2"
	.align 2
.LC218:
	.string	"models/slat/world_glock/world_glock.md2"
	.align 2
.LC217:
	.string	"weapon_glock"
	.align 2
.LC216:
	.string	"ak47rounds"
	.align 2
.LC215:
	.string	"AK 47"
	.align 2
.LC214:
	.string	"w_ak47"
	.align 2
.LC213:
	.string	"models/slat/ak47/ak47.md2"
	.align 2
.LC212:
	.string	"models/slat/world_ak47/world_ak47.md2"
	.align 2
.LC211:
	.string	"Detonator"
	.align 2
.LC210:
	.string	"w_detonator"
	.align 2
.LC209:
	.string	"models/slat/detonator/detonator.md2"
	.align 2
.LC208:
	.string	"models/slat/world_detonator/world_detonator.md2"
	.align 2
.LC207:
	.string	"a_detpack"
	.align 2
.LC206:
	.string	"BFG10K"
	.align 2
.LC205:
	.string	"w_bfg"
	.align 2
.LC204:
	.string	"models/weapons/v_bfg/tris.md2"
	.align 2
.LC203:
	.string	"models/weapons/g_bfg/tris.md2"
	.align 2
.LC202:
	.string	"BARRETT"
	.align 2
.LC201:
	.string	"w_barrett"
	.align 2
.LC200:
	.string	"models/slat/barrett/barrett.md2"
	.align 2
.LC199:
	.string	"models/slat/world_barrett/world_barrett.md2"
	.align 2
.LC198:
	.string	"weapon_chaingun"
	.align 2
.LC197:
	.string	"weapons/hyprbu1a.wav weapons/hyprbl1a.wav weapons/hyprbf1a.wav weapons/hyprbd1a.wav misc/lasfly.wav"
	.align 2
.LC196:
	.string	"HyperBlaster"
	.align 2
.LC195:
	.string	"w_hyperblaster"
	.align 2
.LC194:
	.string	"models/slat/c4/c4.md2"
	.align 2
.LC193:
	.string	"models/slat/world_c4/world_c4.md2"
	.align 2
.LC192:
	.string	"models/objects/rocket/tris.md2 weapons/rockfly.wav weapons/rocklf1a.wav weapons/rocklr1b.wav models/objects/debris2/tris.md2"
	.align 2
.LC191:
	.string	"Rocket Launcher"
	.align 2
.LC190:
	.string	"w_rlauncher"
	.align 2
.LC189:
	.string	"models/weapons/v_rocket/tris.md2"
	.align 2
.LC188:
	.string	"models/weapons/g_rocket/tris.md2"
	.align 2
.LC187:
	.string	"models/objects/grenade/tris.md2 weapons/grenlf1a.wav weapons/grenlr1b.wav weapons/grenlb1b.wav"
	.align 2
.LC186:
	.string	"Grenade Launcher"
	.align 2
.LC185:
	.string	"w_glauncher"
	.align 2
.LC184:
	.string	"models/weapons/v_launch/tris.md2"
	.align 2
.LC183:
	.string	"models/weapons/g_launch/tris.md2"
	.align 2
.LC182:
	.string	"models/slat/world_grenade/world_grenade_pinout.md2 weapons/hgrent1a.wav weapons/hgrena1b.wav weapons/hgrenc1b.wav weapons/hgrenb1a.wav weapons/hgrenb2a.wav "
	.align 2
.LC181:
	.string	"a_grenades"
	.align 2
.LC180:
	.string	"models/slat/grenade/grenade.md2"
	.align 2
.LC179:
	.string	"models/slat/world_grenade/world_grenade.md2"
	.align 2
.LC178:
	.string	"misc/am_pkup.wav"
	.align 2
.LC177:
	.string	"weapons/chngnu1a.wav weapons/chngnl1a.wav weapons/machgf3b.wav` weapons/chngnd1a.wav"
	.align 2
.LC176:
	.string	"Chaingun"
	.align 2
.LC175:
	.string	"w_chaingun"
	.align 2
.LC174:
	.string	"models/weapons/v_chain/tris.md2"
	.align 2
.LC173:
	.string	"models/weapons/g_chain/tris.md2"
	.align 2
.LC172:
	.string	"slat/weapons/uzi_fire.wav"
	.align 2
.LC171:
	.string	"UZI"
	.align 2
.LC170:
	.string	"w_uzi"
	.align 2
.LC169:
	.string	"models/slat/uzi/uzi.md2"
	.align 2
.LC168:
	.string	"models/slat/world_uzi/world_uzi.md2"
	.align 2
.LC167:
	.string	"weapon_machinegun"
	.align 2
.LC166:
	.string	"weapons/sshotf1b.wav"
	.align 2
.LC165:
	.string	"Super Shotgun"
	.align 2
.LC164:
	.string	"w_sshotgun"
	.align 2
.LC163:
	.string	"models/weapons/v_shotg2/tris.md2"
	.align 2
.LC162:
	.string	"models/weapons/g_shotg2/tris.md2"
	.align 2
.LC161:
	.string	"weapons/shotgf1b.wav weapons/shotgr1b.wav"
	.align 2
.LC160:
	.string	"MARINER"
	.align 2
.LC159:
	.string	"w_mariner"
	.align 2
.LC158:
	.string	"models/slat/mossberg/mossberg.md2"
	.align 2
.LC157:
	.string	"models/slat/world_mossberg/world_mossberg.md2"
	.align 2
.LC156:
	.string	"weapon_shotgun"
	.align 2
.LC155:
	.string	"weapons/blastf1a.wav misc/lasfly.wav"
	.align 2
.LC154:
	.string	"w_1911"
	.align 2
.LC153:
	.string	"models/slat/t1911/t1911.md2"
	.align 2
.LC152:
	.string	"models/slat/world_t1911/world_t1911.md2"
	.align 2
.LC151:
	.string	"weapon_1911"
	.align 2
.LC150:
	.string	"weapons/grapple/grfire.wav weapons/grapple/grpull.wav weapons/grapple/grhang.wav weapons/grapple/grreset.wav weapons/grapple/grhit.wav"
	.align 2
.LC149:
	.string	"Grapple"
	.align 2
.LC148:
	.string	"w_grapple"
	.align 2
.LC147:
	.string	"models/weapons/grapple/tris.md2"
	.align 2
.LC146:
	.string	"misc/w_pkup.wav"
	.align 2
.LC145:
	.string	"weapon_grapple"
	.align 2
.LC144:
	.string	"Weight"
	.align 2
.LC143:
	.string	"i_scuba"
	.align 2
.LC142:
	.string	"models/slat/scuba/scuba.md2"
	.align 2
.LC141:
	.string	"item_scuba"
	.align 2
.LC140:
	.string	"i_headlight"
	.align 2
.LC139:
	.string	"models/slat/flashlight/flashlight.md2"
	.align 2
.LC138:
	.string	"item_light"
	.align 2
.LC137:
	.string	"i_medkit"
	.align 2
.LC136:
	.string	"models/slat/medkit/medkit.md2"
	.align 2
.LC135:
	.string	"item_medkit"
	.align 2
.LC134:
	.string	"misc/power2.wav misc/power1.wav"
	.align 2
.LC133:
	.string	"Power Shield"
	.align 2
.LC132:
	.string	"i_powershield"
	.align 2
.LC131:
	.string	"models/items/armor/shield/tris.md2"
	.align 2
.LC130:
	.string	"i_vest"
	.align 2
.LC129:
	.string	"models/slat/vest/vest.md2"
	.align 2
.LC128:
	.string	"item_vest"
	.align 2
.LC127:
	.string	"Power Screen"
	.align 2
.LC126:
	.string	"i_powerscreen"
	.align 2
.LC125:
	.string	"models/items/armor/screen/tris.md2"
	.align 2
.LC124:
	.string	"misc/ar3_pkup.wav"
	.align 2
.LC123:
	.string	"i_helmet"
	.align 2
.LC122:
	.string	"models/slat/helmet/helmet.md2"
	.align 2
.LC121:
	.string	"item_helmet"
	.align 2
.LC120:
	.string	"Armor Shard"
	.align 2
.LC119:
	.string	"models/items/armor/shard/tris.md2"
	.align 2
.LC118:
	.string	"misc/ar2_pkup.wav"
	.align 2
.LC117:
	.string	"Jacket Armor"
	.align 2
.LC116:
	.string	"i_jacketarmor"
	.align 2
.LC115:
	.string	"models/items/armor/jacket/tris.md2"
	.align 2
.LC114:
	.string	"NULL"
	.align 2
.LC113:
	.string	"IR Goggles"
	.align 2
.LC112:
	.string	"i_irgoggles"
	.align 2
.LC111:
	.string	"models/slat/irgoggles/irgoggles.md2"
	.align 2
.LC110:
	.string	"item_ir"
	.align 2
.LC109:
	.string	"Combat Armor"
	.align 2
.LC108:
	.string	"i_combatarmor"
	.align 2
.LC107:
	.string	"models/items/armor/combat/tris.md2"
	.align 2
.LC106:
	.string	""
	.align 2
.LC105:
	.string	"Body Armor"
	.align 2
.LC104:
	.string	"i_bodyarmor"
	.align 2
.LC103:
	.string	"models/items/armor/body/tris.md2"
	.align 2
.LC102:
	.string	"misc/ar1_pkup.wav"
	.size	 itemlist,6308
	.align 2
.LC407:
	.string	"models/items/healing/medium/tris.md2"
	.align 2
.LC408:
	.string	"models/items/healing/stimpack/tris.md2"
	.align 2
.LC409:
	.string	"models/items/healing/large/tris.md2"
	.align 2
.LC410:
	.string	"models/items/mega_h/tris.md2"
	.align 2
.LC411:
	.string	"rockets"
	.align 2
.LC412:
	.string	"super shotgun"
	.align 2
.LC413:
	.string	"chaingun"
	.align 2
.LC414:
	.string	"grenade launcher"
	.align 2
.LC415:
	.string	"rocket launcher"
	.align 2
.LC416:
	.string	"hyperblaster"
	.align 2
.LC417:
	.string	"bfg10k"
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
	bc 4,0,.L1020
	lis 11,itemlist@ha
	lis 9,gi@ha
	la 11,itemlist@l(11)
	la 28,gi@l(9)
	mr 29,10
	addi 30,11,40
.L1022:
	lwz 9,24(28)
	addi 3,31,1056
	lwz 4,0(30)
	addi 31,31,1
	mtlr 9
	addi 30,30,76
	blrl
	lwz 0,1556(29)
	cmpw 0,31,0
	bc 12,0,.L1022
.L1020:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC10@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 28,.LC10@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L1031
	mr 29,10
.L1026:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1028
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1028
	mr 8,31
	b .L1030
.L1028:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1026
.L1031:
	li 8,0
.L1030:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_shells@ha
	lwz 0,1556(7)
	lis 9,.LC13@ha
	lis 11,itemlist@ha
	la 28,.LC13@l(9)
	stw 8,item_shells@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1039
	mr 29,7
.L1034:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1036
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1036
	mr 8,31
	b .L1038
.L1036:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1034
.L1039:
	li 8,0
.L1038:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_cells@ha
	lwz 0,1556(7)
	lis 9,.LC5@ha
	lis 11,itemlist@ha
	la 28,.LC5@l(9)
	stw 8,item_cells@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1047
	mr 29,7
.L1042:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1044
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1044
	mr 8,31
	b .L1046
.L1044:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1042
.L1047:
	li 8,0
.L1046:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_UZIclip@ha
	lwz 0,1556(7)
	lis 9,.LC411@ha
	lis 11,itemlist@ha
	la 28,.LC411@l(9)
	stw 8,item_UZIclip@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1055
	mr 29,7
.L1050:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1052
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1052
	mr 8,31
	b .L1054
.L1052:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1050
.L1055:
	li 8,0
.L1054:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_rockets@ha
	lwz 0,1556(7)
	lis 9,.LC16@ha
	lis 11,itemlist@ha
	la 28,.LC16@l(9)
	stw 8,item_rockets@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1063
	mr 29,7
.L1058:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1060
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1060
	mr 8,31
	b .L1062
.L1060:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1058
.L1063:
	li 8,0
.L1062:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_slugs@ha
	lwz 0,1556(7)
	lis 9,.LC55@ha
	lis 11,itemlist@ha
	la 28,.LC55@l(9)
	stw 8,item_slugs@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1071
	mr 29,7
.L1066:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1068
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1068
	mr 8,31
	b .L1070
.L1068:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1066
.L1071:
	li 8,0
.L1070:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_grenades@ha
	lwz 0,1556(7)
	lis 9,.LC7@ha
	lis 11,itemlist@ha
	la 28,.LC7@l(9)
	stw 8,item_grenades@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1079
	mr 29,7
.L1074:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1076
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1076
	mr 8,31
	b .L1078
.L1076:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1074
.L1079:
	li 8,0
.L1078:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_9mm@ha
	lwz 0,1556(7)
	lis 9,.LC6@ha
	lis 11,itemlist@ha
	la 28,.LC6@l(9)
	stw 8,item_9mm@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1087
	mr 29,7
.L1082:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1084
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1084
	mr 8,31
	b .L1086
.L1084:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1082
.L1087:
	li 8,0
.L1086:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_1911rounds@ha
	lwz 0,1556(7)
	lis 9,.LC8@ha
	lis 11,itemlist@ha
	la 28,.LC8@l(9)
	stw 8,item_1911rounds@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1095
	mr 29,7
.L1090:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1092
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1092
	mr 8,31
	b .L1094
.L1092:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1090
.L1095:
	li 8,0
.L1094:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_50cal@ha
	lwz 0,1556(7)
	lis 9,.LC9@ha
	lis 11,itemlist@ha
	la 28,.LC9@l(9)
	stw 8,item_50cal@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1103
	mr 29,7
.L1098:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1100
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1100
	mr 8,31
	b .L1102
.L1100:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1098
.L1103:
	li 8,0
.L1102:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_MARINERrounds@ha
	lwz 0,1556(7)
	lis 9,.LC79@ha
	lis 11,itemlist@ha
	la 28,.LC79@l(9)
	stw 8,item_MARINERrounds@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1111
	mr 29,7
.L1106:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1108
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1108
	mr 8,31
	b .L1110
.L1108:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1106
.L1111:
	li 8,0
.L1110:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_blaster@ha
	lwz 0,1556(7)
	lis 9,.LC160@ha
	lis 11,itemlist@ha
	la 28,.LC160@l(9)
	stw 8,item_blaster@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1119
	mr 29,7
.L1114:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1116
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1116
	mr 8,31
	b .L1118
.L1116:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1114
.L1119:
	li 8,0
.L1118:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_shotgun@ha
	lwz 0,1556(7)
	lis 9,.LC412@ha
	lis 11,itemlist@ha
	la 28,.LC412@l(9)
	stw 8,item_shotgun@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1127
	mr 29,7
.L1122:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1124
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1124
	mr 8,31
	b .L1126
.L1124:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1122
.L1127:
	li 8,0
.L1126:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_sshotgun@ha
	lwz 0,1556(7)
	lis 9,.LC14@ha
	lis 11,itemlist@ha
	la 28,.LC14@l(9)
	stw 8,item_sshotgun@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1135
	mr 29,7
.L1130:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1132
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1132
	mr 8,31
	b .L1134
.L1132:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1130
.L1135:
	li 8,0
.L1134:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_handgrenade@ha
	lwz 0,1556(7)
	lis 9,.LC171@ha
	lis 11,itemlist@ha
	la 28,.LC171@l(9)
	stw 8,item_handgrenade@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1143
	mr 29,7
.L1138:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1140
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1140
	mr 8,31
	b .L1142
.L1140:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1138
.L1143:
	li 8,0
.L1142:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_machinegun@ha
	lwz 0,1556(7)
	lis 9,.LC413@ha
	lis 11,itemlist@ha
	la 28,.LC413@l(9)
	stw 8,item_machinegun@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1151
	mr 29,7
.L1146:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1148
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1148
	mr 8,31
	b .L1150
.L1148:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1146
.L1151:
	li 8,0
.L1150:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_chaingun@ha
	lwz 0,1556(7)
	lis 9,.LC414@ha
	lis 11,itemlist@ha
	la 28,.LC414@l(9)
	stw 8,item_chaingun@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1159
	mr 29,7
.L1154:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1156
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1156
	mr 8,31
	b .L1158
.L1156:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1154
.L1159:
	li 8,0
.L1158:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_grenadelauncher@ha
	lwz 0,1556(7)
	lis 9,.LC415@ha
	lis 11,itemlist@ha
	la 28,.LC415@l(9)
	stw 8,item_grenadelauncher@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1167
	mr 29,7
.L1162:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1164
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1164
	mr 8,31
	b .L1166
.L1164:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1162
.L1167:
	li 8,0
.L1166:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_rocketlauncher@ha
	lwz 0,1556(7)
	lis 9,.LC202@ha
	lis 11,itemlist@ha
	la 28,.LC202@l(9)
	stw 8,item_rocketlauncher@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1175
	mr 29,7
.L1170:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1172
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1172
	mr 8,31
	b .L1174
.L1172:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1170
.L1175:
	li 8,0
.L1174:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_railgun@ha
	lwz 0,1556(7)
	lis 9,.LC416@ha
	lis 11,itemlist@ha
	la 28,.LC416@l(9)
	stw 8,item_railgun@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1183
	mr 29,7
.L1178:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1180
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1180
	mr 8,31
	b .L1182
.L1180:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1178
.L1183:
	li 8,0
.L1182:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_hyperblaster@ha
	lwz 0,1556(7)
	lis 9,.LC417@ha
	lis 11,itemlist@ha
	la 28,.LC417@l(9)
	stw 8,item_hyperblaster@l(10)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1191
	mr 29,7
.L1186:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1188
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1188
	mr 8,31
	b .L1190
.L1188:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1186
.L1191:
	li 8,0
.L1190:
	lis 9,game@ha
	li 30,0
	la 7,game@l(9)
	lis 10,item_bfg10k@ha
	lwz 0,1556(7)
	lis 9,jacket_armor_index@ha
	lis 11,.LC117@ha
	la 27,jacket_armor_index@l(9)
	la 28,.LC117@l(11)
	stw 8,item_bfg10k@l(10)
	cmpw 0,30,0
	lis 9,itemlist@ha
	la 31,itemlist@l(9)
	bc 4,0,.L1199
	mr 29,7
.L1194:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1196
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1196
	mr 11,31
	b .L1198
.L1196:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1194
.L1199:
	li 11,0
.L1198:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x286b
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,51739
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,combat_armor_index@ha
	lis 10,.LC109@ha
	la 26,combat_armor_index@l(9)
	srawi 11,11,2
	la 28,.LC109@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L1207
	mr 29,7
.L1202:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1204
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1204
	mr 11,31
	b .L1206
.L1204:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1202
.L1207:
	li 11,0
.L1206:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x286b
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,51739
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,body_armor_index@ha
	lis 10,.LC105@ha
	la 27,body_armor_index@l(9)
	srawi 11,11,2
	la 28,.LC105@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L1215
	mr 29,7
.L1210:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1212
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1212
	mr 11,31
	b .L1214
.L1212:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1210
.L1215:
	li 11,0
.L1214:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x286b
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,51739
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,power_screen_index@ha
	lis 10,.LC127@ha
	la 26,power_screen_index@l(9)
	srawi 11,11,2
	la 28,.LC127@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L1223
	mr 29,7
.L1218:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1220
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1220
	mr 11,31
	b .L1222
.L1220:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1218
.L1223:
	li 11,0
.L1222:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x286b
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,51739
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,power_shield_index@ha
	lis 10,.LC133@ha
	la 27,power_shield_index@l(9)
	srawi 11,11,2
	la 28,.LC133@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L1231
	mr 29,7
.L1226:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1228
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1228
	mr 8,31
	b .L1230
.L1228:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1226
.L1231:
	li 8,0
.L1230:
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,8
	mullw 9,9,0
	srawi 9,9,2
	stw 9,0(27)
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 SetItemNames,.Lfe20-SetItemNames
	.section	".rodata"
	.align 2
.LC418:
	.string	"INVALID weapon index in WeaponItem\n"
	.section	".text"
	.align 2
	.globl NextWeaponItem
	.type	 NextWeaponItem,@function
NextWeaponItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	addi 3,3,-1
	cmplwi 0,3,10
	bc 12,1,.L1233
	lis 11,.L1244@ha
	slwi 10,3,2
	la 11,.L1244@l(11)
	lis 9,.L1244@ha
	lwzx 0,10,11
	la 9,.L1244@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L1244:
	.long .L1234-.L1244
	.long .L1235-.L1244
	.long .L1236-.L1244
	.long .L1237-.L1244
	.long .L1238-.L1244
	.long .L1233-.L1244
	.long .L1239-.L1244
	.long .L1240-.L1244
	.long .L1242-.L1244
	.long .L1241-.L1244
	.long .L1247-.L1244
.L1234:
	lis 9,item_shotgun@ha
	lwz 3,item_shotgun@l(9)
	b .L1246
.L1235:
	lis 9,item_sshotgun@ha
	lwz 3,item_sshotgun@l(9)
	b .L1246
.L1236:
	lis 9,item_machinegun@ha
	lwz 3,item_machinegun@l(9)
	b .L1246
.L1237:
	lis 9,item_chaingun@ha
	lwz 3,item_chaingun@l(9)
	b .L1246
.L1238:
	lis 9,item_grenadelauncher@ha
	lwz 3,item_grenadelauncher@l(9)
	b .L1246
.L1239:
	lis 9,item_rocketlauncher@ha
	lwz 3,item_rocketlauncher@l(9)
	b .L1246
.L1240:
	lis 9,item_railgun@ha
	lwz 3,item_railgun@l(9)
	b .L1246
.L1241:
	lis 9,item_hyperblaster@ha
	lwz 3,item_hyperblaster@l(9)
	b .L1246
.L1242:
	lis 9,item_bfg10k@ha
	lwz 3,item_bfg10k@l(9)
	b .L1246
.L1233:
	lis 9,gi+4@ha
	lis 3,.LC418@ha
	lwz 0,gi+4@l(9)
	la 3,.LC418@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L1247:
	lis 9,item_blaster@ha
	lwz 3,item_blaster@l(9)
.L1246:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 NextWeaponItem,.Lfe21-NextWeaponItem
	.align 2
	.globl WeaponItem
	.type	 WeaponItem,@function
WeaponItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	addi 3,3,-1
	cmplwi 0,3,10
	bc 12,1,.L1249
	lis 11,.L1261@ha
	slwi 10,3,2
	la 11,.L1261@l(11)
	lis 9,.L1261@ha
	lwzx 0,10,11
	la 9,.L1261@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L1261:
	.long .L1264-.L1261
	.long .L1251-.L1261
	.long .L1252-.L1261
	.long .L1253-.L1261
	.long .L1254-.L1261
	.long .L1255-.L1261
	.long .L1256-.L1261
	.long .L1257-.L1261
	.long .L1259-.L1261
	.long .L1258-.L1261
	.long .L1260-.L1261
.L1251:
	lis 9,item_shotgun@ha
	lwz 3,item_shotgun@l(9)
	b .L1263
.L1252:
	lis 9,item_sshotgun@ha
	lwz 3,item_sshotgun@l(9)
	b .L1263
.L1253:
	lis 9,item_machinegun@ha
	lwz 3,item_machinegun@l(9)
	b .L1263
.L1254:
	lis 9,item_chaingun@ha
	lwz 3,item_chaingun@l(9)
	b .L1263
.L1255:
	lis 9,item_handgrenade@ha
	lwz 3,item_handgrenade@l(9)
	b .L1263
.L1256:
	lis 9,item_grenadelauncher@ha
	lwz 3,item_grenadelauncher@l(9)
	b .L1263
.L1257:
	lis 9,item_rocketlauncher@ha
	lwz 3,item_rocketlauncher@l(9)
	b .L1263
.L1258:
	lis 9,item_railgun@ha
	lwz 3,item_railgun@l(9)
	b .L1263
.L1259:
	lis 9,item_hyperblaster@ha
	lwz 3,item_hyperblaster@l(9)
	b .L1263
.L1260:
	lis 9,item_bfg10k@ha
	lwz 3,item_bfg10k@l(9)
	b .L1263
.L1249:
	lis 9,gi+4@ha
	lis 3,.LC418@ha
	lwz 0,gi+4@l(9)
	la 3,.LC418@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L1264:
	lis 9,item_blaster@ha
	lwz 3,item_blaster@l(9)
.L1263:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 WeaponItem,.Lfe22-WeaponItem
	.section	".rodata"
	.align 2
.LC419:
	.string	"INVALID weapon index in WeaponIdx\n"
	.section	".text"
	.align 2
	.globl WeaponIdx
	.type	 WeaponIdx,@function
WeaponIdx:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,item_blaster@ha
	lwz 0,item_blaster@l(9)
	cmpw 0,3,0
	bc 12,2,.L1279
	lis 9,item_shotgun@ha
	lwz 0,item_shotgun@l(9)
	cmpw 0,3,0
	bc 4,2,.L1267
	li 3,2
	b .L1277
.L1267:
	lis 9,item_sshotgun@ha
	lwz 0,item_sshotgun@l(9)
	cmpw 0,3,0
	bc 4,2,.L1268
	li 3,3
	b .L1277
.L1268:
	lis 9,item_machinegun@ha
	lwz 0,item_machinegun@l(9)
	cmpw 0,3,0
	bc 4,2,.L1269
	li 3,4
	b .L1277
.L1269:
	lis 9,item_chaingun@ha
	lwz 0,item_chaingun@l(9)
	cmpw 0,3,0
	bc 4,2,.L1270
	li 3,5
	b .L1277
.L1270:
	lis 9,item_handgrenade@ha
	lwz 0,item_handgrenade@l(9)
	cmpw 0,3,0
	bc 12,2,.L1279
	lis 9,item_grenadelauncher@ha
	lwz 0,item_grenadelauncher@l(9)
	cmpw 0,3,0
	bc 4,2,.L1272
	li 3,7
	b .L1277
.L1272:
	lis 9,item_rocketlauncher@ha
	lwz 0,item_rocketlauncher@l(9)
	cmpw 0,3,0
	bc 4,2,.L1273
	li 3,8
	b .L1277
.L1273:
	lis 9,item_railgun@ha
	lwz 0,item_railgun@l(9)
	cmpw 0,3,0
	bc 4,2,.L1274
	li 3,10
	b .L1277
.L1274:
	lis 9,item_hyperblaster@ha
	lwz 0,item_hyperblaster@l(9)
	cmpw 0,3,0
	bc 4,2,.L1275
	li 3,9
	b .L1277
.L1275:
	lis 9,item_bfg10k@ha
	lwz 0,item_bfg10k@l(9)
	cmpw 0,3,0
	bc 12,2,.L1276
	lis 9,gi+4@ha
	lis 3,.LC419@ha
	lwz 0,gi+4@l(9)
	la 3,.LC419@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L1279:
	li 3,1
	b .L1277
.L1276:
	li 3,11
.L1277:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 WeaponIdx,.Lfe23-WeaponIdx
	.section	".rodata"
	.align 2
.LC420:
	.string	"INVALID weapontype in AmmoIndex"
	.section	".text"
	.align 2
	.globl AmmoIndex
	.type	 AmmoIndex,@function
AmmoIndex:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,item_blaster@ha
	lwz 0,item_blaster@l(9)
	cmpw 0,3,0
	bc 4,2,.L1282
	li 3,0
	b .L1293
.L1282:
	lis 9,item_shotgun@ha
	lwz 0,item_shotgun@l(9)
	cmpw 0,3,0
	bc 4,2,.L1283
	lis 11,item_shells@ha
	lis 9,itemlist@ha
	lwz 3,item_shells@l(11)
	b .L1294
.L1283:
	lis 9,item_sshotgun@ha
	lwz 0,item_sshotgun@l(9)
	cmpw 0,3,0
	bc 4,2,.L1284
	lis 11,item_shells@ha
	lis 9,itemlist@ha
	lwz 3,item_shells@l(11)
	b .L1294
.L1284:
	lis 9,item_machinegun@ha
	lwz 0,item_machinegun@l(9)
	cmpw 0,3,0
	bc 4,2,.L1285
	lis 11,item_UZIclip@ha
	lis 9,itemlist@ha
	lwz 3,item_UZIclip@l(11)
	b .L1294
.L1285:
	lis 9,item_chaingun@ha
	lwz 0,item_chaingun@l(9)
	cmpw 0,3,0
	bc 4,2,.L1286
	lis 11,item_UZIclip@ha
	lis 9,itemlist@ha
	lwz 3,item_UZIclip@l(11)
	b .L1294
.L1286:
	lis 9,item_handgrenade@ha
	lwz 0,item_handgrenade@l(9)
	cmpw 0,3,0
	bc 4,2,.L1287
	lis 11,item_grenades@ha
	lis 9,itemlist@ha
	lwz 3,item_grenades@l(11)
	b .L1294
.L1287:
	lis 9,item_grenadelauncher@ha
	lwz 0,item_grenadelauncher@l(9)
	cmpw 0,3,0
	bc 4,2,.L1288
	lis 11,item_grenades@ha
	lis 9,itemlist@ha
	lwz 3,item_grenades@l(11)
	b .L1294
.L1288:
	lis 9,item_rocketlauncher@ha
	lwz 0,item_rocketlauncher@l(9)
	cmpw 0,3,0
	bc 4,2,.L1289
	lis 11,item_rockets@ha
	lis 9,itemlist@ha
	lwz 3,item_rockets@l(11)
	b .L1294
.L1289:
	lis 9,item_railgun@ha
	lwz 0,item_railgun@l(9)
	cmpw 0,3,0
	bc 4,2,.L1290
	lis 11,item_slugs@ha
	lis 9,itemlist@ha
	lwz 3,item_slugs@l(11)
	b .L1294
.L1290:
	lis 9,item_hyperblaster@ha
	lwz 0,item_hyperblaster@l(9)
	cmpw 0,3,0
	bc 12,2,.L1292
	lis 9,item_bfg10k@ha
	lwz 0,item_bfg10k@l(9)
	cmpw 0,3,0
	bc 12,2,.L1292
	lis 9,gi+4@ha
	lis 3,.LC420@ha
	lwz 0,gi+4@l(9)
	la 3,.LC420@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L1293
.L1292:
	lis 11,item_cells@ha
	lis 9,itemlist@ha
	lwz 3,item_cells@l(11)
.L1294:
	la 9,itemlist@l(9)
	lis 0,0x286b
	ori 0,0,51739
	subf 3,9,3
	mullw 3,3,0
	srawi 3,3,2
.L1293:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 AmmoIndex,.Lfe24-AmmoIndex
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_UZIclip,4,4
	.comm	item_9mm,4,4
	.comm	item_1911rounds,4,4
	.comm	item_50cal,4,4
	.comm	item_MARINERrounds,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_sshotgun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	jacket_armor_index,4,4
	.comm	combat_armor_index,4,4
	.comm	body_armor_index,4,4
	.align 2
	.globl InitItems
	.type	 InitItems,@function
InitItems:
	lis 9,game+1556@ha
	li 0,82
	stw 0,game+1556@l(9)
	blr
.Lfe25:
	.size	 InitItems,.Lfe25-InitItems
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
	b .L1298
.L20:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L21
.L19:
	li 3,0
.L1298:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 FindItem,.Lfe26-FindItem
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
	b .L1299
.L12:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L13
.L11:
	li 3,0
.L1299:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 FindItemByClassname,.Lfe27-FindItemByClassname
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
.Lfe28:
	.size	 SetRespawn,.Lfe28-SetRespawn
	.align 2
	.globl ArmorIndex
	.type	 ArmorIndex,@function
ArmorIndex:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L813
	li 3,0
	blr
.L813:
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
.Lfe29:
	.size	 ArmorIndex,.Lfe29-ArmorIndex
	.align 2
	.globl PowerArmorType
	.type	 PowerArmorType,@function
PowerArmorType:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L842
.L1302:
	li 3,0
	blr
.L842:
	lwz 0,264(3)
	andi. 9,0,4096
	bc 12,2,.L1302
	lis 9,power_shield_index@ha
	addi 11,11,740
	lwz 0,power_shield_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L844
	lis 9,power_screen_index@ha
	lwz 0,power_screen_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	srawi 3,9,31
	subf 3,9,3
	srwi 3,3,31
	blr
.L844:
	li 3,2
	blr
.Lfe30:
	.size	 PowerArmorType,.Lfe30-PowerArmorType
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
	mulli 0,3,76
	lis 3,itemlist@ha
	la 3,itemlist@l(3)
	add 3,0,3
	blr
.Lfe31:
	.size	 GetItemByIndex,.Lfe31-GetItemByIndex
	.comm	ctfgame,24,4
	.align 2
	.globl WeapIndex
	.type	 WeapIndex,@function
WeapIndex:
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	mullw 3,3,0
	srawi 3,3,2
	blr
.Lfe32:
	.size	 WeapIndex,.Lfe32-WeapIndex
	.align 2
	.globl HasWeaponInInventory
	.type	 HasWeaponInInventory,@function
HasWeaponInInventory:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lwz 29,84(3)
	mr 3,4
	bl WeaponItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 3,29,3
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 HasWeaponInInventory,.Lfe33-HasWeaponInInventory
	.align 2
	.globl HasAmmoInInventory
	.type	 HasAmmoInInventory,@function
HasAmmoInInventory:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lwz 29,84(3)
	mr 3,4
	bl WeaponItem
	bl AmmoIndex
	slwi 3,3,2
	addi 29,29,740
	lwzx 3,29,3
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 HasAmmoInInventory,.Lfe34-HasAmmoInInventory
	.comm	enemies,4,4
	.comm	spawned,4,4
	.comm	lms_round,4,4
	.comm	terror_l,4,4
	.comm	swat_l,4,4
	.comm	lms_delay,4,4
	.comm	lms_delay2,4,4
	.comm	lms_players,4,4
	.comm	lms_dead_players,4,4
	.comm	lms_alive_players,4,4
	.comm	lms_round_over,4,4
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
	.section	".rodata"
	.align 2
.LC421:
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
	bc 12,2,.L26
	lis 9,.LC421@ha
	lis 11,ctf@ha
	lwz 30,564(31)
	la 9,.LC421@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L27
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,4
	bc 12,2,.L27
	lwz 9,648(30)
	cmpwi 0,9,0
	bc 12,2,.L27
	lwz 0,56(9)
	andi. 9,0,1
	bc 12,2,.L27
	mr 31,30
	b .L26
.L27:
	mr. 31,30
	li 29,0
	bc 12,2,.L30
.L31:
	lwz 31,536(31)
	addi 29,29,1
	cmpwi 0,31,0
	bc 4,2,.L31
.L30:
	bl rand
	mr 31,30
	divw 0,3,29
	mullw 0,0,29
	subf. 3,0,3
	bc 4,1,.L26
	mr 29,3
.L36:
	addic. 29,29,-1
	lwz 31,536(31)
	bc 4,2,.L36
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
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe35:
	.size	 DoRespawn,.Lfe35-DoRespawn
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
.Lfe36:
	.size	 Drop_General,.Lfe36-Drop_General
	.section	".rodata"
	.align 2
.LC422:
	.long 0x0
	.align 3
.LC423:
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
	lis 9,.LC422@ha
	lis 11,deathmatch@ha
	la 9,.LC422@l(9)
	mr 12,3
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L54
	lwz 9,484(4)
	addi 9,9,1
	stw 9,484(4)
.L54:
	lwz 0,480(4)
	lwz 9,484(4)
	cmpw 0,0,9
	bc 4,0,.L55
	stw 9,480(4)
.L55:
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L56
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L56
	lis 9,.LC423@ha
	lwz 11,648(12)
	la 9,.LC423@l(9)
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
.L56:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 Pickup_Adrenaline,.Lfe37-Pickup_Adrenaline
	.align 2
	.globl Pickup_AncientHead
	.type	 Pickup_AncientHead,@function
Pickup_AncientHead:
	lwz 9,484(4)
	li 3,1
	addi 9,9,2
	stw 9,484(4)
	blr
.Lfe38:
	.size	 Pickup_AncientHead,.Lfe38-Pickup_AncientHead
	.section	".rodata"
	.align 3
.LC424:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC425:
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
	lis 9,.LC424@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC424@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3844(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L250
	lis 9,.LC425@ha
	la 9,.LC425@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L1304
.L250:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L1304:
	stfs 0,3844(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe39:
	.size	 Use_Breather,.Lfe39-Use_Breather
	.section	".rodata"
	.align 3
.LC426:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC427:
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
	lis 9,.LC426@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC426@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3848(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L253
	lis 9,.LC427@ha
	la 9,.LC427@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L1305
.L253:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L1305:
	stfs 0,3848(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe40:
	.size	 Use_Envirosuit,.Lfe40-Use_Envirosuit
	.align 2
	.globl Use_Silencer
	.type	 Use_Silencer,@function
Use_Silencer:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
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
	lwz 11,84(29)
	lwz 9,3860(11)
	addi 9,9,30
	stw 9,3860(11)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe41:
	.size	 Use_Silencer,.Lfe41-Use_Silencer
	.section	".rodata"
	.align 2
.LC428:
	.long 0x3f800000
	.align 2
.LC429:
	.long 0x0
	.align 2
.LC430:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl MegaHealth_think
	.type	 MegaHealth_think,@function
MegaHealth_think:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 3,256(31)
	lwz 9,480(3)
	lwz 0,484(3)
	cmpw 0,9,0
	bc 4,1,.L795
	bl CTFHasRegeneration
	cmpwi 0,3,0
	bc 4,2,.L795
	lis 11,.LC428@ha
	lis 9,level+4@ha
	la 11,.LC428@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	lwz 11,256(31)
	fadds 0,0,13
	stfs 0,428(31)
	lwz 9,480(11)
	addi 9,9,-1
	stw 9,480(11)
	b .L794
.L795:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L796
	lis 9,.LC429@ha
	lis 11,deathmatch@ha
	la 9,.LC429@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L796
	lwz 9,264(31)
	lis 11,.LC430@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC430@l(11)
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
	b .L794
.L796:
	mr 3,31
	bl G_FreeEdict
.L794:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe42:
	.size	 MegaHealth_think,.Lfe42-MegaHealth_think
	.section	".rodata"
	.align 2
.LC431:
	.long 0x0
	.section	".text"
	.align 2
	.globl Pickup_PowerArmor
	.type	 Pickup_PowerArmor,@function
Pickup_PowerArmor:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 7,3
	lis 11,itemlist@ha
	lwz 9,648(7)
	la 11,itemlist@l(11)
	lis 0,0x286b
	ori 0,0,51739
	mr 3,4
	subf 9,11,9
	lwz 10,84(3)
	lis 11,deathmatch@ha
	mullw 9,9,0
	lwz 8,deathmatch@l(11)
	addi 10,10,740
	lis 11,.LC431@ha
	rlwinm 9,9,0,0,29
	la 11,.LC431@l(11)
	lfs 13,0(11)
	lwzx 11,10,9
	addi 0,11,1
	stwx 0,10,9
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L860
	cmpwi 0,11,0
	bc 4,2,.L860
	lwz 9,648(7)
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L860:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe43:
	.size	 Pickup_PowerArmor,.Lfe43-Pickup_PowerArmor
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
	bc 12,2,.L863
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,30
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,1
	bc 4,2,.L863
	bl Use_PowerArmor
.L863:
	mr 3,31
	mr 4,30
	bl Drop_Item
	lis 11,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 11,11,30
	addi 10,10,740
	mullw 11,11,0
	mr 3,31
	rlwinm 11,11,0,0,29
	lwzx 9,10,11
	addi 9,9,-1
	stwx 9,10,11
	bl ValidateSelectedItem
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe44:
	.size	 Drop_PowerArmor,.Lfe44-Drop_PowerArmor
	.align 2
	.type	 drop_temp_touch,@function
drop_temp_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,256(3)
	cmpw 0,4,0
	bc 12,2,.L887
	bl Touch_Item
.L887:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe45:
	.size	 drop_temp_touch,.Lfe45-drop_temp_touch
	.section	".rodata"
	.align 2
.LC432:
	.long 0x0
	.align 2
.LC433:
	.long 0x41f00000
	.section	".text"
	.align 2
	.type	 drop_make_touchable,@function
drop_make_touchable:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 29,3
	lis 9,Touch_Item@ha
	la 9,Touch_Item@l(9)
	lwz 10,648(29)
	lis 11,Pickup_Ammo@ha
	stw 9,444(29)
	la 11,Pickup_Ammo@l(11)
	lwz 0,4(10)
	cmpw 0,0,11
	bc 12,2,.L891
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC79@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC79@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L899
	mr 28,10
.L894:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L896
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L896
	mr 9,31
	b .L898
.L896:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L894
.L899:
	li 9,0
.L898:
	lwz 0,648(29)
	cmpw 0,0,9
	bc 4,2,.L890
.L891:
	lis 9,.LC432@ha
	lis 11,deathmatch@ha
	la 9,.LC432@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L890
	lis 9,.LC433@ha
	lis 11,level+4@ha
	la 9,.LC433@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,436(29)
	stfs 0,428(29)
.L890:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe46:
	.size	 drop_make_touchable,.Lfe46-drop_make_touchable
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
	bc 12,2,.L905
	li 0,2
	stw 11,444(3)
	stw 0,248(3)
	b .L906
.L905:
	lis 9,Touch_Item@ha
	li 0,1
	la 9,Touch_Item@l(9)
	stw 0,248(3)
	stw 9,444(3)
.L906:
	lis 9,gi+72@ha
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe47:
	.size	 Use_Item,.Lfe47-Use_Item
	.section	".rodata"
	.align 2
.LC434:
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
	lis 11,.LC434@ha
	lis 9,deathmatch@ha
	la 11,.LC434@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L978
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L978
	bl G_FreeEdict
	b .L977
.L1306:
	mr 4,31
	b .L985
.L978:
	lis 9,.LC407@ha
	li 0,10
	la 9,.LC407@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC398@ha
	lis 11,itemlist@ha
	la 27,.LC398@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L986
	mr 28,10
.L981:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L983
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L1306
.L983:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L981
.L986:
	li 4,0
.L985:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC73@ha
	lwz 0,gi+36@l(9)
	la 3,.LC73@l(3)
	mtlr 0
	blrl
.L977:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe48:
	.size	 SP_item_health,.Lfe48-SP_item_health
	.section	".rodata"
	.align 2
.LC435:
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
	lis 11,.LC435@ha
	lis 9,deathmatch@ha
	la 11,.LC435@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L988
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L988
	bl G_FreeEdict
	b .L987
.L1307:
	mr 4,31
	b .L995
.L988:
	lis 9,.LC408@ha
	li 0,2
	la 9,.LC408@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC398@ha
	lis 11,itemlist@ha
	la 27,.LC398@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L996
	mr 28,10
.L991:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L993
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L1307
.L993:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L991
.L996:
	li 4,0
.L995:
	mr 3,29
	bl SpawnItem
	li 0,1
	lis 9,gi+36@ha
	stw 0,644(29)
	lis 3,.LC72@ha
	lwz 0,gi+36@l(9)
	la 3,.LC72@l(3)
	mtlr 0
	blrl
.L987:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe49:
	.size	 SP_item_health_small,.Lfe49-SP_item_health_small
	.section	".rodata"
	.align 2
.LC436:
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
	lis 11,.LC436@ha
	lis 9,deathmatch@ha
	la 11,.LC436@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L998
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L998
	bl G_FreeEdict
	b .L997
.L1308:
	mr 4,31
	b .L1005
.L998:
	lis 9,.LC409@ha
	li 0,25
	la 9,.LC409@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC398@ha
	lis 11,itemlist@ha
	la 27,.LC398@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1006
	mr 28,10
.L1001:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1003
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L1308
.L1003:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1001
.L1006:
	li 4,0
.L1005:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC74@ha
	lwz 0,gi+36@l(9)
	la 3,.LC74@l(3)
	mtlr 0
	blrl
.L997:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe50:
	.size	 SP_item_health_large,.Lfe50-SP_item_health_large
	.section	".rodata"
	.align 2
.LC437:
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
	lis 11,.LC437@ha
	lis 9,deathmatch@ha
	la 11,.LC437@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L1008
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L1008
	bl G_FreeEdict
	b .L1007
.L1309:
	mr 4,31
	b .L1015
.L1008:
	lis 9,.LC410@ha
	li 0,100
	la 9,.LC410@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC398@ha
	lis 11,itemlist@ha
	la 27,.LC398@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L1016
	mr 28,10
.L1011:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L1013
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L1309
.L1013:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L1011
.L1016:
	li 4,0
.L1015:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC75@ha
	lwz 0,gi+36@l(9)
	la 3,.LC75@l(3)
	mtlr 0
	blrl
	li 0,3
	stw 0,644(29)
.L1007:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe51:
	.size	 SP_item_health_mega,.Lfe51-SP_item_health_mega
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
