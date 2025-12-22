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
	.string	"Bullets"
	.align 2
.LC6:
	.string	"Shells"
	.align 2
.LC7:
	.long 0x0
	.align 3
.LC8:
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
	mr 28,3
	lwz 9,84(29)
	lwz 0,1764(9)
	cmpwi 0,0,249
	bc 12,1,.L62
	li 0,250
	stw 0,1764(9)
.L62:
	lwz 9,84(29)
	lwz 0,1768(9)
	cmpwi 0,0,149
	bc 12,1,.L63
	li 0,150
	stw 0,1768(9)
.L63:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,249
	bc 12,1,.L64
	li 0,250
	stw 0,1780(9)
.L64:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,74
	bc 12,1,.L65
	li 0,75
	stw 0,1784(9)
.L65:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC5@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC5@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L73
	mr 27,10
.L68:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L70
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L70
	mr 8,31
	b .L72
.L70:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L68
.L73:
	li 8,0
.L72:
	cmpwi 0,8,0
	bc 12,2,.L74
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
	bc 4,1,.L74
	stwx 11,9,8
.L74:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC6@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC6@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L83
	mr 27,10
.L78:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L80
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L80
	mr 8,31
	b .L82
.L80:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L78
.L83:
	li 8,0
.L82:
	cmpwi 0,8,0
	bc 12,2,.L84
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
	bc 4,1,.L84
	stwx 11,4,8
.L84:
	lwz 0,284(28)
	andis. 4,0,0x1
	bc 4,2,.L86
	lis 9,.LC7@ha
	lis 11,deathmatch@ha
	la 9,.LC7@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L86
	lis 9,.LC8@ha
	lwz 11,648(28)
	la 9,.LC8@l(9)
	lis 7,0x4330
	lwz 0,264(28)
	lfd 12,0(9)
	lis 6,level+4@ha
	lis 10,DoRespawn@ha
	lwz 9,48(11)
	oris 0,0,0x8000
	la 10,DoRespawn@l(10)
	lwz 11,184(28)
	lis 5,gi+72@ha
	mr 3,28
	xoris 9,9,0x8000
	stw 0,264(28)
	stw 9,20(1)
	ori 11,11,1
	stw 7,16(1)
	lfd 0,16(1)
	stw 11,184(28)
	stw 4,248(28)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,436(28)
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(28)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L86:
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
.LC9:
	.string	"Cells"
	.align 2
.LC10:
	.string	"Grenades"
	.align 2
.LC11:
	.string	"Rockets"
	.align 2
.LC12:
	.string	"Slugs"
	.align 2
.LC13:
	.long 0x0
	.align 3
.LC14:
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
	mr 27,3
	lwz 9,84(29)
	lwz 0,1764(9)
	cmpwi 0,0,299
	bc 12,1,.L89
	li 0,300
	stw 0,1764(9)
.L89:
	lwz 9,84(29)
	lwz 0,1768(9)
	cmpwi 0,0,199
	bc 12,1,.L90
	li 0,200
	stw 0,1768(9)
.L90:
	lwz 9,84(29)
	lwz 0,1772(9)
	cmpwi 0,0,99
	bc 12,1,.L91
	li 0,100
	stw 0,1772(9)
.L91:
	lwz 9,84(29)
	lwz 0,1776(9)
	cmpwi 0,0,99
	bc 12,1,.L92
	li 0,100
	stw 0,1776(9)
.L92:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,299
	bc 12,1,.L93
	li 0,300
	stw 0,1780(9)
.L93:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,99
	bc 12,1,.L94
	li 0,100
	stw 0,1784(9)
.L94:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC5@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC5@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L102
	mr 28,10
.L97:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L99
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L99
	mr 8,31
	b .L101
.L99:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L97
.L102:
	li 8,0
.L101:
	cmpwi 0,8,0
	bc 12,2,.L103
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
	bc 4,1,.L103
	stwx 11,9,8
.L103:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC6@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC6@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L112
	mr 28,10
.L107:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L109
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L109
	mr 8,31
	b .L111
.L109:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L107
.L112:
	li 8,0
.L111:
	cmpwi 0,8,0
	bc 12,2,.L113
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
	bc 4,1,.L113
	stwx 11,9,8
.L113:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC9@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC9@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L122
	mr 28,10
.L117:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L119
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L119
	mr 8,31
	b .L121
.L119:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L117
.L122:
	li 8,0
.L121:
	cmpwi 0,8,0
	bc 12,2,.L123
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
	bc 4,1,.L123
	stwx 11,9,8
.L123:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC10@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC10@l(11)
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
	bc 4,2,.L129
	mr 8,31
	b .L131
.L129:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L127
.L132:
	li 8,0
.L131:
	cmpwi 0,8,0
	bc 12,2,.L133
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
	bc 4,1,.L133
	stwx 11,9,8
.L133:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC11@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC11@l(11)
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
	bc 4,2,.L139
	mr 8,31
	b .L141
.L139:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L137
.L142:
	li 8,0
.L141:
	cmpwi 0,8,0
	bc 12,2,.L143
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
	bc 4,1,.L143
	stwx 11,9,8
.L143:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC12@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC12@l(11)
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
	bc 4,2,.L149
	mr 8,31
	b .L151
.L149:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L147
.L152:
	li 8,0
.L151:
	cmpwi 0,8,0
	bc 12,2,.L153
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
	bc 4,1,.L153
	stwx 11,4,8
.L153:
	lwz 0,284(27)
	andis. 4,0,0x1
	bc 4,2,.L155
	lis 9,.LC13@ha
	lis 11,deathmatch@ha
	la 9,.LC13@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L155
	lis 9,.LC14@ha
	lwz 11,648(27)
	la 9,.LC14@l(9)
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
.L155:
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
.LC15:
	.string	"items/damage.wav"
	.align 3
.LC16:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC17:
	.long 0x3f800000
	.align 2
.LC18:
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
	bc 12,2,.L158
	li 0,0
	mr 10,9
	stw 0,quad_drop_timeout_hack@l(11)
	b .L159
.L158:
	li 10,300
.L159:
	lis 11,level@ha
	lwz 8,84(31)
	lwz 11,level@l(11)
	lis 7,0x4330
	lis 6,.LC16@ha
	la 6,.LC16@l(6)
	lfs 12,3744(8)
	xoris 0,11,0x8000
	lfd 13,0(6)
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L160
	xoris 0,10,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fadds 0,12,0
	b .L162
.L160:
	add 0,11,10
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
.L162:
	stfs 0,3744(8)
	lis 29,gi@ha
	lis 3,.LC15@ha
	la 29,gi@l(29)
	la 3,.LC15@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 6,.LC17@ha
	lwz 0,16(29)
	lis 9,.LC17@ha
	la 6,.LC17@l(6)
	mr 5,3
	lfs 1,0(6)
	la 9,.LC17@l(9)
	li 4,3
	mtlr 0
	lis 6,.LC18@ha
	mr 3,31
	lfs 2,0(9)
	la 6,.LC18@l(6)
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
.LC19:
	.string	"items/protect.wav"
	.align 3
.LC20:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC21:
	.long 0x43960000
	.align 2
.LC22:
	.long 0x3f800000
	.align 2
.LC23:
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
	lis 9,.LC20@ha
	lis 11,level@ha
	lwz 10,84(31)
	la 9,.LC20@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3748(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L170
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L172
.L170:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L172:
	stfs 0,3748(10)
	lis 29,gi@ha
	lis 3,.LC19@ha
	la 29,gi@l(29)
	la 3,.LC19@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC22@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC22@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 2,0(9)
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
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
.LC24:
	.string	"key_power_cube"
	.align 2
.LC25:
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
	lis 11,.LC25@ha
	lis 9,coop@ha
	la 11,.LC25@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 30,4
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L175
	lwz 3,280(31)
	lis 4,.LC24@ha
	la 4,.LC24@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L176
	lwz 10,84(30)
	lbz 9,286(31)
	lwz 0,1796(10)
	and. 11,0,9
	bc 4,2,.L181
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
	lwz 0,1796(11)
	or 0,0,9
	stw 0,1796(11)
	b .L178
.L176:
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
	bc 12,2,.L179
.L181:
	li 3,0
	b .L180
.L179:
	li 0,1
	stwx 0,4,3
.L178:
	li 3,1
	b .L180
.L175:
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
.L180:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 Pickup_Key,.Lfe6-Pickup_Key
	.align 2
	.globl Add_Ammo
	.type	 Add_Ammo,@function
Add_Ammo:
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 4,2,.L183
.L199:
	li 3,0
	blr
.L183:
	lwz 0,68(4)
	cmpwi 0,0,0
	bc 4,2,.L184
	lwz 10,1764(9)
	b .L185
.L184:
	cmpwi 0,0,1
	bc 4,2,.L186
	lwz 10,1768(9)
	b .L185
.L186:
	cmpwi 0,0,2
	bc 4,2,.L188
	lwz 10,1772(9)
	b .L185
.L188:
	cmpwi 0,0,3
	bc 4,2,.L190
	lwz 10,1776(9)
	b .L185
.L190:
	cmpwi 0,0,4
	bc 4,2,.L192
	lwz 10,1780(9)
	b .L185
.L192:
	cmpwi 0,0,5
	bc 4,2,.L199
	lwz 10,1784(9)
.L185:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(3)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	rlwinm 4,9,0,0,29
	lwzx 0,11,4
	cmpw 0,0,10
	bc 12,2,.L199
	add 0,0,5
	stwx 0,11,4
	lwz 9,84(3)
	addi 3,9,740
	lwzx 0,3,4
	cmpw 0,0,10
	bc 4,1,.L197
	stwx 10,3,4
.L197:
	li 3,1
	blr
.Lfe7:
	.size	 Add_Ammo,.Lfe7-Add_Ammo
	.section	".rodata"
	.align 2
.LC26:
	.string	"blaster"
	.align 2
.LC27:
	.long 0x0
	.align 2
.LC28:
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
	bc 12,2,.L201
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8192
	li 5,1000
	bc 4,2,.L202
.L201:
	lwz 5,532(30)
	cmpwi 0,5,0
	bc 12,2,.L203
	lwz 4,648(30)
	b .L202
.L203:
	lwz 9,648(30)
	lwz 5,48(9)
	mr 4,9
.L202:
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
	bc 4,2,.L205
	li 3,0
	b .L219
.L220:
	mr 9,31
	b .L215
.L205:
	subfic 9,31,0
	adde 0,9,31
	and. 11,29,0
	bc 12,2,.L206
	lwz 25,84(28)
	lwz 9,648(30)
	lwz 0,1788(25)
	cmpw 0,0,9
	bc 12,2,.L206
	lis 9,.LC27@ha
	lis 11,deathmatch@ha
	la 9,.LC27@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L208
	lis 9,game@ha
	li 29,0
	la 9,game@l(9)
	lis 11,.LC26@ha
	lwz 0,1556(9)
	la 26,.LC26@l(11)
	mr 31,27
	cmpw 0,29,0
	bc 4,0,.L216
	mr 27,9
.L211:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L213
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L220
.L213:
	lwz 0,1556(27)
	addi 29,29,1
	addi 31,31,76
	cmpw 0,29,0
	bc 12,0,.L211
.L216:
	li 9,0
.L215:
	lwz 0,1788(25)
	cmpw 0,0,9
	bc 4,2,.L206
.L208:
	lwz 9,84(28)
	lwz 0,648(30)
	stw 0,3568(9)
.L206:
	lwz 0,284(30)
	andis. 7,0,0x3
	bc 4,2,.L217
	lis 9,.LC27@ha
	lis 11,deathmatch@ha
	la 9,.LC27@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L217
	lwz 9,264(30)
	lis 11,.LC28@ha
	lis 10,level+4@ha
	lwz 0,184(30)
	la 11,.LC28@l(11)
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
.L217:
	li 3,1
.L219:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 Pickup_Ammo,.Lfe8-Pickup_Ammo
	.section	".rodata"
	.align 2
.LC29:
	.string	"Can't drop current weapon\n"
	.align 2
.LC30:
	.long 0x40a00000
	.align 2
.LC31:
	.long 0x0
	.align 2
.LC32:
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
	bc 4,2,.L231
	lwz 9,480(30)
	lwz 0,484(30)
	cmpw 0,9,0
	bc 4,0,.L242
.L231:
	lwz 0,480(30)
	lwz 9,532(31)
	cmpwi 0,0,249
	mr 11,0
	bc 4,1,.L233
	cmpwi 0,9,25
	bc 4,1,.L233
.L242:
	li 3,0
	b .L241
.L233:
	add 0,11,9
	cmpwi 0,0,250
	stw 0,480(30)
	bc 4,1,.L234
	lwz 0,532(31)
	cmpwi 0,0,25
	bc 4,1,.L234
	li 0,250
	stw 0,480(30)
.L234:
	lwz 0,644(31)
	andi. 9,0,1
	bc 4,2,.L235
	lwz 0,480(30)
	lwz 9,484(30)
	cmpw 0,0,9
	bc 4,1,.L235
	stw 9,480(30)
.L235:
	lwz 0,644(31)
	andi. 11,0,2
	bc 12,2,.L237
	mr 3,30
	bl CTFHasRegeneration
	mr. 3,3
	bc 4,2,.L237
	lis 9,MegaHealth_think@ha
	lis 8,.LC30@ha
	lwz 11,264(31)
	la 9,MegaHealth_think@l(9)
	lis 10,level+4@ha
	lwz 0,184(31)
	la 8,.LC30@l(8)
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
	b .L238
.L237:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L238
	lis 9,.LC31@ha
	lis 11,deathmatch@ha
	la 9,.LC31@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L238
	lwz 9,264(31)
	lis 11,.LC32@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC32@l(11)
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
.L238:
	li 3,1
.L241:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 Pickup_Health,.Lfe9-Pickup_Health
	.section	".rodata"
	.align 3
.LC33:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC34:
	.long 0x0
	.align 2
.LC35:
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
	bc 4,2,.L249
	li 6,0
	b .L250
.L249:
	lis 9,jacket_armor_index@ha
	addi 8,11,740
	lwz 6,jacket_armor_index@l(9)
	slwi 0,6,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L250
	lis 9,combat_armor_index@ha
	lwz 6,combat_armor_index@l(9)
	slwi 0,6,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L250
	lis 9,body_armor_index@ha
	lwz 10,body_armor_index@l(9)
	slwi 11,10,2
	lwzx 9,8,11
	srawi 0,9,31
	subf 0,9,0
	srawi 0,0,31
	and 6,10,0
.L250:
	lwz 8,648(31)
	lwz 0,68(8)
	cmpwi 0,0,4
	bc 4,2,.L254
	cmpwi 0,6,0
	bc 4,2,.L255
	lis 11,jacket_armor_index@ha
	lwz 9,84(12)
	li 10,2
	lwz 0,jacket_armor_index@l(11)
	addi 9,9,740
	slwi 0,0,2
	stwx 10,9,0
	b .L257
.L255:
	lwz 9,84(12)
	slwi 0,6,2
	addi 9,9,740
	lwzx 11,9,0
	addi 11,11,2
	stwx 11,9,0
	b .L257
.L254:
	cmpwi 0,6,0
	bc 4,2,.L258
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
	b .L257
.L258:
	lis 9,jacket_armor_index@ha
	lwz 0,jacket_armor_index@l(9)
	cmpw 0,6,0
	bc 4,2,.L260
	lis 9,jacketarmor_info@ha
	la 11,jacketarmor_info@l(9)
	b .L261
.L260:
	lis 9,combat_armor_index@ha
	lwz 0,combat_armor_index@l(9)
	cmpw 0,6,0
	bc 4,2,.L262
	lis 9,combatarmor_info@ha
	la 11,combatarmor_info@l(9)
	b .L261
.L262:
	lis 9,bodyarmor_info@ha
	la 11,bodyarmor_info@l(9)
.L261:
	lfs 13,8(7)
	lfs 0,8(11)
	fcmpu 0,13,0
	bc 4,1,.L264
	fdivs 11,0,13
	lwz 9,84(12)
	slwi 6,6,2
	lis 4,0x4330
	lis 10,.LC33@ha
	lwz 3,0(7)
	addi 9,9,740
	la 10,.LC33@l(10)
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
	b .L257
.L264:
	fdivs 11,13,0
	lwz 0,0(7)
	lis 8,0x4330
	lis 10,.LC33@ha
	mr 7,9
	lwz 11,4(11)
	xoris 0,0,0x8000
	la 10,.LC33@l(10)
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
	bc 12,0,.L268
	li 3,0
	b .L271
.L268:
	stwx 0,4,6
.L257:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L269
	lis 9,.LC34@ha
	lis 11,deathmatch@ha
	la 9,.LC34@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L269
	lwz 9,264(31)
	lis 11,.LC35@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC35@l(11)
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
.L269:
	li 3,1
.L271:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 Pickup_Armor,.Lfe10-Pickup_Armor
	.section	".rodata"
	.align 2
.LC36:
	.string	"misc/power2.wav"
	.align 2
.LC37:
	.string	"cells"
	.align 2
.LC38:
	.string	"No cells for power armor.\n"
	.align 2
.LC39:
	.string	"misc/power1.wav"
	.align 2
.LC40:
	.long 0x3f800000
	.align 2
.LC41:
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
	bc 12,2,.L278
	rlwinm 0,0,0,20,18
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(30)
	lis 3,.LC36@ha
	lwz 9,36(29)
	la 3,.LC36@l(3)
	mtlr 9
	blrl
	lis 9,.LC40@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC40@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 2,0(9)
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 3,0(9)
	blrl
	b .L277
.L289:
	mr 10,29
	b .L286
.L278:
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lis 11,.LC37@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC37@l(11)
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L287
	mr 28,10
.L282:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L284
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L289
.L284:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,76
	cmpw 0,31,0
	bc 12,0,.L282
.L287:
	li 10,0
.L286:
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
	bc 4,2,.L288
	lis 5,.LC38@ha
	mr 3,30
	la 5,.LC38@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L277
.L288:
	lwz 0,264(30)
	lis 29,gi@ha
	lis 3,.LC39@ha
	la 29,gi@l(29)
	la 3,.LC39@l(3)
	ori 0,0,4096
	stw 0,264(30)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC40@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC40@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 2,0(9)
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 3,0(9)
	blrl
.L277:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 Use_PowerArmor,.Lfe11-Use_PowerArmor
	.section	".rodata"
	.align 2
.LC42:
	.long 0x0
	.align 3
.LC43:
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
	lis 11,itemlist@ha
	lwz 9,648(31)
	la 11,itemlist@l(11)
	lis 0,0x286b
	ori 0,0,51739
	mr 29,4
	subf 9,11,9
	lwz 10,84(29)
	mullw 9,9,0
	lis 11,deathmatch@ha
	addi 10,10,740
	lwz 8,deathmatch@l(11)
	rlwinm 9,9,0,0,29
	lis 11,.LC42@ha
	lwzx 30,10,9
	la 11,.LC42@l(11)
	lfs 13,0(11)
	addi 0,30,1
	stwx 0,10,9
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L291
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L292
	lis 9,.LC43@ha
	lwz 11,648(31)
	la 9,.LC43@l(9)
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
	xoris 9,9,0x8000
	stw 0,264(31)
	stw 9,28(1)
	ori 11,11,1
	stw 7,24(1)
	lfd 0,24(1)
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
.L292:
	cmpwi 0,30,0
	bc 4,2,.L291
	lwz 9,648(31)
	mr 3,29
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L291:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 Pickup_PowerArmor,.Lfe12-Pickup_PowerArmor
	.section	".rodata"
	.align 2
.LC44:
	.string	"items/s_health.wav"
	.align 2
.LC45:
	.string	"items/n_health.wav"
	.align 2
.LC46:
	.string	"items/l_health.wav"
	.align 2
.LC47:
	.string	"items/m_health.wav"
	.align 3
.LC48:
	.long 0x40080000
	.long 0x0
	.align 2
.LC49:
	.long 0x3f800000
	.align 2
.LC50:
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
	bc 12,2,.L298
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L298
	lwz 9,648(31)
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 12,2,.L298
	mtlr 0
	blrl
	mr. 28,3
	bc 12,2,.L302
	lwz 11,84(30)
	lis 0,0x3e80
	lis 9,gi@ha
	la 29,gi@l(9)
	stw 0,3656(11)
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
	lis 9,.LC48@ha
	sth 3,134(11)
	lis 10,level+4@ha
	la 9,.LC48@l(9)
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
	stfs 0,3776(9)
	lwz 9,648(31)
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 12,2,.L303
	subf 0,7,9
	lwz 11,84(30)
	mullw 0,0,8
	srawi 0,0,2
	extsh 9,0
	sth 0,144(11)
	stw 9,736(11)
.L303:
	lwz 3,648(31)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	lwz 0,4(3)
	cmpw 0,0,9
	bc 4,2,.L304
	lwz 0,532(31)
	cmpwi 0,0,2
	bc 4,2,.L305
	lwz 9,36(29)
	lis 3,.LC44@ha
	la 3,.LC44@l(3)
	b .L319
.L305:
	cmpwi 0,0,10
	bc 4,2,.L307
	lwz 9,36(29)
	lis 3,.LC45@ha
	la 3,.LC45@l(3)
	b .L319
.L307:
	cmpwi 0,0,25
	bc 4,2,.L309
	lwz 9,36(29)
	lis 3,.LC46@ha
	la 3,.LC46@l(3)
	b .L319
.L309:
	lwz 9,36(29)
	lis 3,.LC47@ha
	la 3,.LC47@l(3)
.L319:
	mtlr 9
	blrl
	lis 9,.LC49@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC49@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfs 2,0(9)
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 3,0(9)
	blrl
	b .L302
.L304:
	lwz 3,20(3)
	cmpwi 0,3,0
	bc 12,2,.L302
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC49@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC49@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfs 2,0(9)
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 3,0(9)
	blrl
.L302:
	lwz 0,284(31)
	andis. 9,0,4
	bc 4,2,.L313
	mr 4,30
	mr 3,31
	bl G_UseTargets
	lwz 0,284(31)
	oris 0,0,0x4
	stw 0,284(31)
.L313:
	cmpwi 0,28,0
	bc 12,2,.L298
	lis 9,.LC50@ha
	lis 11,coop@ha
	la 9,.LC50@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L316
	lwz 9,648(31)
	lwz 0,56(9)
	andi. 9,0,8
	bc 12,2,.L316
	lwz 0,284(31)
	andis. 9,0,0x3
	bc 12,2,.L298
.L316:
	lwz 0,264(31)
	cmpwi 0,0,0
	bc 4,0,.L317
	rlwinm 0,0,0,1,31
	stw 0,264(31)
	b .L298
.L317:
	mr 3,31
	bl G_FreeEdict
.L298:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 Touch_Item,.Lfe13-Touch_Item
	.section	".rodata"
	.align 2
.LC51:
	.long 0x42c80000
	.align 2
.LC52:
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
	bc 12,2,.L325
	addi 29,1,24
	addi 4,1,8
	addi 3,3,3672
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
	b .L327
.L325:
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
.L327:
	stfs 0,12(31)
	lis 9,.LC51@ha
	addi 3,1,8
	la 9,.LC51@l(9)
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
	lis 9,.LC52@ha
	lfs 0,level+4@l(11)
	la 9,.LC52@l(9)
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
.Lfe14:
	.size	 Drop_Item,.Lfe14-Drop_Item
	.section	".rodata"
	.align 2
.LC53:
	.string	"droptofloor: %s startsolid at %s\n"
	.align 3
.LC54:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC55:
	.long 0xc1700000
	.align 2
.LC56:
	.long 0x41700000
	.align 2
.LC57:
	.long 0x0
	.align 2
.LC58:
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
	lis 9,.LC55@ha
	lis 11,.LC55@ha
	la 9,.LC55@l(9)
	la 11,.LC55@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC55@ha
	lfs 2,0(11)
	la 9,.LC55@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC56@ha
	lfs 13,0(11)
	la 9,.LC56@l(9)
	lfs 1,0(9)
	lis 9,.LC56@ha
	stfs 13,188(31)
	la 9,.LC56@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC56@ha
	stfs 0,192(31)
	la 9,.LC56@l(9)
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
	bc 12,2,.L332
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L333
.L332:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L333:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC57@ha
	stw 9,444(31)
	addi 29,31,4
	la 11,.LC57@l(11)
	lis 9,.LC58@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC58@l(9)
	lis 11,.LC57@ha
	lfs 3,0(9)
	la 11,.LC57@l(11)
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
	bc 12,2,.L334
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC53@ha
	la 3,.LC53@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L331
.L334:
	lwz 0,308(31)
	lfs 12,20(1)
	lfs 0,24(1)
	cmpwi 0,0,0
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L335
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
	bc 4,2,.L335
	lis 11,level+4@ha
	lis 10,.LC54@ha
	lfs 0,level+4@l(11)
	lis 9,DoRespawn@ha
	lfd 13,.LC54@l(10)
	la 9,DoRespawn@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L335:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L337
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
.L337:
	lwz 0,284(31)
	andi. 11,0,1
	bc 12,2,.L338
	lwz 0,184(31)
	lis 9,Use_Item@ha
	li 11,0
	la 9,Use_Item@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
.L338:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L331:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe15:
	.size	 droptofloor,.Lfe15-droptofloor
	.section	".rodata"
	.align 2
.LC59:
	.string	"PrecacheItem: %s has bad precache string"
	.align 2
.LC60:
	.string	"md2"
	.align 2
.LC61:
	.string	"sp2"
	.align 2
.LC62:
	.string	"wav"
	.align 2
.LC63:
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
	bc 12,2,.L339
	lwz 3,20(26)
	cmpwi 0,3,0
	bc 12,2,.L341
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L341:
	lwz 3,24(26)
	cmpwi 0,3,0
	bc 12,2,.L342
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L342:
	lwz 3,32(26)
	cmpwi 0,3,0
	bc 12,2,.L343
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L343:
	lwz 3,36(26)
	cmpwi 0,3,0
	bc 12,2,.L344
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
.L344:
	lwz 29,52(26)
	cmpwi 0,29,0
	bc 12,2,.L345
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L345
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L353
	mr 28,9
.L348:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L350
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L350
	mr 3,31
	b .L352
.L350:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L348
.L353:
	li 3,0
.L352:
	cmpw 0,3,26
	bc 12,2,.L345
	bl PrecacheItem
.L345:
	lwz 30,72(26)
	cmpwi 0,30,0
	bc 12,2,.L339
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 12,2,.L339
	lis 9,gi@ha
	addi 29,1,8
	la 27,gi@l(9)
	lis 24,.LC60@ha
	lis 25,.LC63@ha
.L359:
	rlwinm 9,0,0,0xff
	mr 31,30
	b .L373
.L362:
	lbzu 9,1(30)
.L373:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L362
	subf 28,31,30
	addi 0,28,-5
	cmplwi 0,0,58
	bc 4,1,.L364
	lwz 9,28(27)
	lis 3,.LC59@ha
	la 3,.LC59@l(3)
	lwz 4,0(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L364:
	mr 4,31
	mr 5,28
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 0,0
	addi 11,30,1
	stbx 0,29,28
	add 9,29,28
	la 4,.LC60@l(24)
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
	bc 12,2,.L374
	lis 4,.LC61@ha
	mr 3,31
	la 4,.LC61@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L368
.L374:
	lwz 9,32(27)
	mr 3,29
	mtlr 9
	blrl
	b .L367
.L368:
	lis 4,.LC62@ha
	mr 3,31
	la 4,.LC62@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L367
	lwz 9,36(27)
	mr 3,29
	mtlr 9
	blrl
.L367:
	add 3,29,28
	la 4,.LC63@l(25)
	addi 3,3,-3
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L357
	lwz 9,40(27)
	mr 3,29
	mtlr 9
	blrl
.L357:
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L359
.L339:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe16:
	.size	 PrecacheItem,.Lfe16-PrecacheItem
	.section	".rodata"
	.align 2
.LC64:
	.string	"%s at %s has invalid spawnflags set\n"
	.align 2
.LC65:
	.string	"weapon_bfg"
	.align 2
.LC66:
	.string	"item_flag_team1"
	.align 2
.LC67:
	.string	"item_flag_team2"
	.align 3
.LC68:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC69:
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
	bc 12,2,.L376
	lwz 3,280(31)
	lis 4,.LC24@ha
	la 4,.LC24@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L376
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
	lis 3,.LC64@ha
	la 3,.LC64@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L376:
	lis 9,.LC69@ha
	lis 11,deathmatch@ha
	la 9,.LC69@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L378
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2048
	bc 12,2,.L379
	lwz 0,4(30)
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L393
	lis 9,Pickup_PowerArmor@ha
	la 9,Pickup_PowerArmor@l(9)
	cmpw 0,0,9
	bc 12,2,.L393
.L379:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 12,2,.L382
	lwz 0,4(30)
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L393
.L382:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 12,2,.L384
	lwz 0,4(30)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L393
	lis 9,Pickup_Adrenaline@ha
	la 9,Pickup_Adrenaline@l(9)
	cmpw 0,0,9
	bc 12,2,.L393
	lis 9,Pickup_AncientHead@ha
	la 9,Pickup_AncientHead@l(9)
	cmpw 0,0,9
	bc 12,2,.L393
.L384:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8192
	bc 12,2,.L378
	lwz 0,56(30)
	cmpwi 0,0,2
	bc 12,2,.L393
	lwz 3,280(31)
	lis 4,.LC65@ha
	la 4,.LC65@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L393
.L378:
	lis 9,.LC69@ha
	lis 11,coop@ha
	la 9,.LC69@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L390
	lwz 3,280(31)
	lis 4,.LC24@ha
	la 4,.LC24@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L390
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
.L390:
	lis 9,.LC69@ha
	lis 11,coop@ha
	la 9,.LC69@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L391
	lwz 0,56(30)
	andi. 9,0,8
	bc 12,2,.L391
	li 0,0
	stw 0,12(30)
.L391:
	lis 9,.LC69@ha
	lis 11,ctf@ha
	la 9,.LC69@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L392
	lwz 3,280(31)
	lis 4,.LC66@ha
	la 4,.LC66@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L393
	lwz 3,280(31)
	lis 4,.LC67@ha
	la 4,.LC67@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L392
.L393:
	mr 3,31
	bl G_FreeEdict
	b .L375
.L392:
	stw 30,648(31)
	lis 11,level+4@ha
	lis 10,.LC68@ha
	lfs 0,level+4@l(11)
	lis 9,droptofloor@ha
	lfd 13,.LC68@l(10)
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
	bc 12,2,.L394
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L394:
	lwz 3,280(31)
	lis 4,.LC66@ha
	la 4,.LC66@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L396
	lwz 3,280(31)
	lis 4,.LC67@ha
	la 4,.LC67@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L375
.L396:
	lis 9,CTFFlagSetup@ha
	la 9,CTFFlagSetup@l(9)
	stw 9,436(31)
.L375:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 SpawnItem,.Lfe17-SpawnItem
	.globl itemlist
	.section	".data"
	.align 2
	.type	 itemlist,@object
itemlist:
	.long 0
	.space	72
	.long .LC70
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC71
	.long .LC72
	.long 1
	.long 0
	.long .LC73
	.long .LC74
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long bodyarmor_info
	.long 3
	.long .LC75
	.long .LC76
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC71
	.long .LC77
	.long 1
	.long 0
	.long .LC78
	.long .LC79
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long combatarmor_info
	.long 2
	.long .LC75
	.long .LC80
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC71
	.long .LC81
	.long 1
	.long 0
	.long .LC82
	.long .LC83
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long jacketarmor_info
	.long 1
	.long .LC75
	.long .LC84
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long .LC86
	.long 1
	.long 0
	.long .LC82
	.long .LC87
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long 0
	.long 4
	.long .LC75
	.long .LC88
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC89
	.long .LC90
	.long 1
	.long 0
	.long .LC91
	.long .LC92
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long .LC93
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC89
	.long .LC94
	.long 1
	.long 0
	.long .LC95
	.long .LC96
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC97
	.long .LC98
	.long 0
	.long Use_Weapon
	.long 0
	.long CTFWeapon_Grapple
	.long .LC99
	.long 0
	.long 0
	.long .LC100
	.long .LC101
	.long .LC102
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long 0
	.long .LC103
	.long .LC104
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Blaster
	.long .LC99
	.long 0
	.long 0
	.long .LC105
	.long .LC106
	.long .LC107
	.long 0
	.long 0
	.long 0
	.long 9
	.long 1
	.long 0
	.long 0
	.long .LC108
	.long .LC109
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Shotgun
	.long .LC99
	.long .LC110
	.long 1
	.long .LC111
	.long .LC112
	.long .LC113
	.long 0
	.long 1
	.long .LC6
	.long 9
	.long 2
	.long 0
	.long 0
	.long .LC114
	.long .LC115
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_SuperShotgun
	.long .LC99
	.long .LC116
	.long 1
	.long .LC117
	.long .LC118
	.long .LC119
	.long 0
	.long 2
	.long .LC6
	.long 9
	.long 3
	.long 0
	.long 0
	.long .LC120
	.long .LC121
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Machinegun
	.long .LC99
	.long .LC122
	.long 1
	.long .LC123
	.long .LC124
	.long .LC125
	.long 0
	.long 1
	.long .LC5
	.long 9
	.long 4
	.long 0
	.long 0
	.long .LC126
	.long .LC127
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Chaingun
	.long .LC99
	.long .LC128
	.long 1
	.long .LC129
	.long .LC130
	.long .LC131
	.long 0
	.long 1
	.long .LC5
	.long 9
	.long 5
	.long 0
	.long 0
	.long .LC132
	.long .LC133
	.long Pickup_Ammo
	.long Use_Weapon
	.long Drop_Ammo
	.long Weapon_Grenade
	.long .LC134
	.long .LC135
	.long 0
	.long .LC136
	.long .LC137
	.long .LC10
	.long 3
	.long 5
	.long .LC138
	.long 3
	.long 6
	.long 0
	.long 3
	.long .LC139
	.long .LC140
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_GrenadeLauncher
	.long .LC99
	.long .LC141
	.long 1
	.long .LC142
	.long .LC143
	.long .LC144
	.long 0
	.long 1
	.long .LC10
	.long 9
	.long 7
	.long 0
	.long 0
	.long .LC145
	.long .LC146
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_RocketLauncher
	.long .LC99
	.long .LC147
	.long 1
	.long .LC148
	.long .LC149
	.long .LC150
	.long 0
	.long 1
	.long .LC11
	.long 9
	.long 8
	.long 0
	.long 0
	.long .LC151
	.long .LC152
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_HyperBlaster
	.long .LC99
	.long .LC153
	.long 1
	.long .LC154
	.long .LC155
	.long .LC156
	.long 0
	.long 1
	.long .LC9
	.long 9
	.long 9
	.long 0
	.long 0
	.long .LC157
	.long .LC158
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Railgun
	.long .LC99
	.long .LC159
	.long 1
	.long .LC160
	.long .LC161
	.long .LC162
	.long 0
	.long 1
	.long .LC12
	.long 9
	.long 10
	.long 0
	.long 0
	.long .LC163
	.long .LC65
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_BFG
	.long .LC99
	.long .LC164
	.long 1
	.long .LC165
	.long .LC166
	.long .LC167
	.long 0
	.long 50
	.long .LC9
	.long 9
	.long 11
	.long 0
	.long 0
	.long .LC168
	.long .LC169
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC134
	.long .LC170
	.long 0
	.long 0
	.long .LC171
	.long .LC6
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 1
	.long .LC75
	.long .LC172
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC134
	.long .LC173
	.long 0
	.long 0
	.long .LC174
	.long .LC5
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long .LC175
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC134
	.long .LC176
	.long 0
	.long 0
	.long .LC177
	.long .LC9
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long 4
	.long .LC75
	.long .LC178
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC134
	.long .LC179
	.long 0
	.long 0
	.long .LC180
	.long .LC11
	.long 3
	.long 5
	.long 0
	.long 2
	.long 0
	.long 0
	.long 2
	.long .LC75
	.long .LC181
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC134
	.long .LC182
	.long 0
	.long 0
	.long .LC183
	.long .LC12
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 5
	.long .LC75
	.long .LC184
	.long Pickup_Powerup
	.long Use_Quad
	.long Drop_General
	.long 0
	.long .LC185
	.long .LC186
	.long 1
	.long 0
	.long .LC187
	.long .LC188
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC189
	.long .LC190
	.long Pickup_Powerup
	.long Use_Invulnerability
	.long Drop_General
	.long 0
	.long .LC185
	.long .LC191
	.long 1
	.long 0
	.long .LC192
	.long .LC193
	.long 2
	.long 300
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC194
	.long .LC195
	.long Pickup_Powerup
	.long Use_Silencer
	.long Drop_General
	.long 0
	.long .LC185
	.long .LC196
	.long 1
	.long 0
	.long .LC197
	.long .LC198
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long .LC199
	.long Pickup_Powerup
	.long Use_Breather
	.long Drop_General
	.long 0
	.long .LC185
	.long .LC200
	.long 1
	.long 0
	.long .LC201
	.long .LC202
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long 0
	.long .LC203
	.long .LC204
	.long Pickup_Powerup
	.long Use_Envirosuit
	.long Drop_General
	.long 0
	.long .LC185
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
	.long 0
	.long .LC203
	.long .LC208
	.long Pickup_AncientHead
	.long 0
	.long 0
	.long 0
	.long .LC185
	.long .LC209
	.long 1
	.long 0
	.long .LC210
	.long .LC211
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long .LC212
	.long Pickup_Adrenaline
	.long 0
	.long 0
	.long 0
	.long .LC185
	.long .LC213
	.long 1
	.long 0
	.long .LC214
	.long .LC215
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long .LC216
	.long Pickup_Bandolier
	.long 0
	.long 0
	.long 0
	.long .LC185
	.long .LC217
	.long 1
	.long 0
	.long .LC218
	.long .LC219
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long .LC220
	.long Pickup_Pack
	.long 0
	.long 0
	.long 0
	.long .LC185
	.long .LC221
	.long 1
	.long 0
	.long .LC222
	.long .LC223
	.long 2
	.long 180
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long .LC224
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC185
	.long .LC225
	.long 1
	.long 0
	.long .LC226
	.long .LC227
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long .LC24
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC185
	.long .LC228
	.long 1
	.long 0
	.long .LC229
	.long .LC230
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long .LC231
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC185
	.long .LC232
	.long 1
	.long 0
	.long .LC233
	.long .LC234
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long .LC235
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC185
	.long .LC236
	.long 1
	.long 0
	.long .LC237
	.long .LC238
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long .LC239
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC185
	.long .LC240
	.long 1
	.long 0
	.long .LC241
	.long .LC242
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long .LC243
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC185
	.long .LC244
	.long 1
	.long 0
	.long .LC245
	.long .LC246
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long .LC247
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC185
	.long .LC248
	.long 1
	.long 0
	.long .LC249
	.long .LC250
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long .LC251
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC185
	.long .LC252
	.long 2
	.long 0
	.long .LC253
	.long .LC254
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long .LC255
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC185
	.long .LC256
	.long 1
	.long 0
	.long .LC257
	.long .LC258
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long 0
	.long Pickup_Health
	.long 0
	.long 0
	.long 0
	.long .LC185
	.long 0
	.long 0
	.long 0
	.long .LC259
	.long .LC260
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC261
	.long .LC66
	.long CTFPickup_Flag
	.long 0
	.long CTFDrop_Flag
	.long 0
	.long .LC262
	.long .LC263
	.long 262144
	.long 0
	.long .LC264
	.long .LC265
	.long 2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC266
	.long .LC67
	.long CTFPickup_Flag
	.long 0
	.long CTFDrop_Flag
	.long 0
	.long .LC262
	.long .LC267
	.long 524288
	.long 0
	.long .LC268
	.long .LC269
	.long 2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC266
	.long .LC270
	.long CTFPickup_Tech
	.long 0
	.long CTFDrop_Tech
	.long 0
	.long .LC185
	.long .LC271
	.long 1
	.long 0
	.long .LC272
	.long .LC273
	.long 2
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC274
	.long .LC275
	.long CTFPickup_Tech
	.long 0
	.long CTFDrop_Tech
	.long 0
	.long .LC185
	.long .LC276
	.long 1
	.long 0
	.long .LC277
	.long .LC278
	.long 2
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC279
	.long .LC280
	.long CTFPickup_Tech
	.long 0
	.long CTFDrop_Tech
	.long 0
	.long .LC185
	.long .LC281
	.long 1
	.long 0
	.long .LC282
	.long .LC283
	.long 2
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC284
	.long .LC285
	.long CTFPickup_Tech
	.long 0
	.long CTFDrop_Tech
	.long 0
	.long .LC185
	.long .LC286
	.long 1
	.long 0
	.long .LC287
	.long .LC288
	.long 2
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC289
	.long 0
	.space	72
	.section	".rodata"
	.align 2
.LC289:
	.string	"ctf/tech4.wav"
	.align 2
.LC288:
	.string	"AutoDoc"
	.align 2
.LC287:
	.string	"tech4"
	.align 2
.LC286:
	.string	"models/ctf/regeneration/tris.md2"
	.align 2
.LC285:
	.string	"item_tech4"
	.align 2
.LC284:
	.string	"ctf/tech3.wav"
	.align 2
.LC283:
	.string	"Time Accel"
	.align 2
.LC282:
	.string	"tech3"
	.align 2
.LC281:
	.string	"models/ctf/haste/tris.md2"
	.align 2
.LC280:
	.string	"item_tech3"
	.align 2
.LC279:
	.string	"ctf/tech2.wav ctf/tech2x.wav"
	.align 2
.LC278:
	.string	"Power Amplifier"
	.align 2
.LC277:
	.string	"tech2"
	.align 2
.LC276:
	.string	"models/ctf/strength/tris.md2"
	.align 2
.LC275:
	.string	"item_tech2"
	.align 2
.LC274:
	.string	"ctf/tech1.wav"
	.align 2
.LC273:
	.string	"Disruptor Shield"
	.align 2
.LC272:
	.string	"tech1"
	.align 2
.LC271:
	.string	"models/ctf/resistance/tris.md2"
	.align 2
.LC270:
	.string	"item_tech1"
	.align 2
.LC269:
	.string	"Blue Flag"
	.align 2
.LC268:
	.string	"i_ctf2"
	.align 2
.LC267:
	.string	"players/male/flag2.md2"
	.align 2
.LC266:
	.string	"ctf/flagcap.wav"
	.align 2
.LC265:
	.string	"Red Flag"
	.align 2
.LC264:
	.string	"i_ctf1"
	.align 2
.LC263:
	.string	"players/male/flag1.md2"
	.align 2
.LC262:
	.string	"ctf/flagtk.wav"
	.align 2
.LC261:
	.string	"items/s_health.wav items/n_health.wav items/l_health.wav items/m_health.wav"
	.align 2
.LC260:
	.string	"Health"
	.align 2
.LC259:
	.string	"i_health"
	.align 2
.LC258:
	.string	"Airstrike Marker"
	.align 2
.LC257:
	.string	"i_airstrike"
	.align 2
.LC256:
	.string	"models/items/keys/target/tris.md2"
	.align 2
.LC255:
	.string	"key_airstrike_target"
	.align 2
.LC254:
	.string	"Commander's Head"
	.align 2
.LC253:
	.string	"k_comhead"
	.align 2
.LC252:
	.string	"models/monsters/commandr/head/tris.md2"
	.align 2
.LC251:
	.string	"key_commander_head"
	.align 2
.LC250:
	.string	"Red Key"
	.align 2
.LC249:
	.string	"k_redkey"
	.align 2
.LC248:
	.string	"models/items/keys/red_key/tris.md2"
	.align 2
.LC247:
	.string	"key_red_key"
	.align 2
.LC246:
	.string	"Blue Key"
	.align 2
.LC245:
	.string	"k_bluekey"
	.align 2
.LC244:
	.string	"models/items/keys/key/tris.md2"
	.align 2
.LC243:
	.string	"key_blue_key"
	.align 2
.LC242:
	.string	"Security Pass"
	.align 2
.LC241:
	.string	"k_security"
	.align 2
.LC240:
	.string	"models/items/keys/pass/tris.md2"
	.align 2
.LC239:
	.string	"key_pass"
	.align 2
.LC238:
	.string	"Data Spinner"
	.align 2
.LC237:
	.string	"k_dataspin"
	.align 2
.LC236:
	.string	"models/items/keys/spinner/tris.md2"
	.align 2
.LC235:
	.string	"key_data_spinner"
	.align 2
.LC234:
	.string	"Pyramid Key"
	.align 2
.LC233:
	.string	"k_pyramid"
	.align 2
.LC232:
	.string	"models/items/keys/pyramid/tris.md2"
	.align 2
.LC231:
	.string	"key_pyramid"
	.align 2
.LC230:
	.string	"Power Cube"
	.align 2
.LC229:
	.string	"k_powercube"
	.align 2
.LC228:
	.string	"models/items/keys/power/tris.md2"
	.align 2
.LC227:
	.string	"Data CD"
	.align 2
.LC226:
	.string	"k_datacd"
	.align 2
.LC225:
	.string	"models/items/keys/data_cd/tris.md2"
	.align 2
.LC224:
	.string	"key_data_cd"
	.align 2
.LC223:
	.string	"Ammo Pack"
	.align 2
.LC222:
	.string	"i_pack"
	.align 2
.LC221:
	.string	"models/items/pack/tris.md2"
	.align 2
.LC220:
	.string	"item_pack"
	.align 2
.LC219:
	.string	"Bandolier"
	.align 2
.LC218:
	.string	"p_bandolier"
	.align 2
.LC217:
	.string	"models/items/band/tris.md2"
	.align 2
.LC216:
	.string	"item_bandolier"
	.align 2
.LC215:
	.string	"Adrenaline"
	.align 2
.LC214:
	.string	"p_adrenaline"
	.align 2
.LC213:
	.string	"models/items/adrenal/tris.md2"
	.align 2
.LC212:
	.string	"item_adrenaline"
	.align 2
.LC211:
	.string	"Ancient Head"
	.align 2
.LC210:
	.string	"i_fixme"
	.align 2
.LC209:
	.string	"models/items/c_head/tris.md2"
	.align 2
.LC208:
	.string	"item_ancient_head"
	.align 2
.LC207:
	.string	"Environment Suit"
	.align 2
.LC206:
	.string	"p_envirosuit"
	.align 2
.LC205:
	.string	"models/items/enviro/tris.md2"
	.align 2
.LC204:
	.string	"item_enviro"
	.align 2
.LC203:
	.string	"items/airout.wav"
	.align 2
.LC202:
	.string	"Rebreather"
	.align 2
.LC201:
	.string	"p_rebreather"
	.align 2
.LC200:
	.string	"models/items/breather/tris.md2"
	.align 2
.LC199:
	.string	"item_breather"
	.align 2
.LC198:
	.string	"Silencer"
	.align 2
.LC197:
	.string	"p_silencer"
	.align 2
.LC196:
	.string	"models/items/silencer/tris.md2"
	.align 2
.LC195:
	.string	"item_silencer"
	.align 2
.LC194:
	.string	"items/protect.wav items/protect2.wav items/protect4.wav"
	.align 2
.LC193:
	.string	"Invulnerability"
	.align 2
.LC192:
	.string	"p_invulnerability"
	.align 2
.LC191:
	.string	"models/items/invulner/tris.md2"
	.align 2
.LC190:
	.string	"item_invulnerability"
	.align 2
.LC189:
	.string	"items/damage.wav items/damage2.wav items/damage3.wav"
	.align 2
.LC188:
	.string	"Quad Damage"
	.align 2
.LC187:
	.string	"p_quad"
	.align 2
.LC186:
	.string	"models/items/quaddama/tris.md2"
	.align 2
.LC185:
	.string	"items/pkup.wav"
	.align 2
.LC184:
	.string	"item_quad"
	.align 2
.LC183:
	.string	"a_slugs"
	.align 2
.LC182:
	.string	"models/items/ammo/slugs/medium/tris.md2"
	.align 2
.LC181:
	.string	"ammo_slugs"
	.align 2
.LC180:
	.string	"a_rockets"
	.align 2
.LC179:
	.string	"models/items/ammo/rockets/medium/tris.md2"
	.align 2
.LC178:
	.string	"ammo_rockets"
	.align 2
.LC177:
	.string	"a_cells"
	.align 2
.LC176:
	.string	"models/items/ammo/cells/medium/tris.md2"
	.align 2
.LC175:
	.string	"ammo_cells"
	.align 2
.LC174:
	.string	"a_bullets"
	.align 2
.LC173:
	.string	"models/items/ammo/bullets/medium/tris.md2"
	.align 2
.LC172:
	.string	"ammo_bullets"
	.align 2
.LC171:
	.string	"a_shells"
	.align 2
.LC170:
	.string	"models/items/ammo/shells/medium/tris.md2"
	.align 2
.LC169:
	.string	"ammo_shells"
	.align 2
.LC168:
	.string	"sprites/s_bfg1.sp2 sprites/s_bfg2.sp2 sprites/s_bfg3.sp2 weapons/bfg__f1y.wav weapons/bfg__l1a.wav weapons/bfg__x1b.wav weapons/bfg_hum.wav"
	.align 2
.LC167:
	.string	"BFG10K"
	.align 2
.LC166:
	.string	"w_bfg"
	.align 2
.LC165:
	.string	"models/weapons/v_bfg/tris.md2"
	.align 2
.LC164:
	.string	"models/weapons/g_bfg/tris.md2"
	.align 2
.LC163:
	.string	"weapons/rg_hum.wav"
	.align 2
.LC162:
	.string	"Railgun"
	.align 2
.LC161:
	.string	"w_railgun"
	.align 2
.LC160:
	.string	"models/weapons/v_rail/tris.md2"
	.align 2
.LC159:
	.string	"models/weapons/g_rail/tris.md2"
	.align 2
.LC158:
	.string	"weapon_railgun"
	.align 2
.LC157:
	.string	"weapons/hyprbu1a.wav weapons/hyprbl1a.wav weapons/hyprbf1a.wav weapons/hyprbd1a.wav misc/lasfly.wav"
	.align 2
.LC156:
	.string	"HyperBlaster"
	.align 2
.LC155:
	.string	"w_hyperblaster"
	.align 2
.LC154:
	.string	"models/weapons/v_hyperb/tris.md2"
	.align 2
.LC153:
	.string	"models/weapons/g_hyperb/tris.md2"
	.align 2
.LC152:
	.string	"weapon_hyperblaster"
	.align 2
.LC151:
	.string	"models/objects/rocket/tris.md2 weapons/rockfly.wav weapons/rocklf1a.wav weapons/rocklr1b.wav models/objects/debris2/tris.md2"
	.align 2
.LC150:
	.string	"Rocket Launcher"
	.align 2
.LC149:
	.string	"w_rlauncher"
	.align 2
.LC148:
	.string	"models/weapons/v_rocket/tris.md2"
	.align 2
.LC147:
	.string	"models/weapons/g_rocket/tris.md2"
	.align 2
.LC146:
	.string	"weapon_rocketlauncher"
	.align 2
.LC145:
	.string	"models/objects/grenade/tris.md2 weapons/grenlf1a.wav weapons/grenlr1b.wav weapons/grenlb1b.wav"
	.align 2
.LC144:
	.string	"Grenade Launcher"
	.align 2
.LC143:
	.string	"w_glauncher"
	.align 2
.LC142:
	.string	"models/weapons/v_launch/tris.md2"
	.align 2
.LC141:
	.string	"models/weapons/g_launch/tris.md2"
	.align 2
.LC140:
	.string	"weapon_grenadelauncher"
	.align 2
.LC139:
	.string	"weapons/hgrent1a.wav weapons/hgrena1b.wav weapons/hgrenc1b.wav weapons/hgrenb1a.wav weapons/hgrenb2a.wav "
	.align 2
.LC138:
	.string	"grenades"
	.align 2
.LC137:
	.string	"a_grenades"
	.align 2
.LC136:
	.string	"models/weapons/v_handgr/tris.md2"
	.align 2
.LC135:
	.string	"models/items/ammo/grenades/medium/tris.md2"
	.align 2
.LC134:
	.string	"misc/am_pkup.wav"
	.align 2
.LC133:
	.string	"ammo_grenades"
	.align 2
.LC132:
	.string	"weapons/chngnu1a.wav weapons/chngnl1a.wav weapons/machgf3b.wav` weapons/chngnd1a.wav"
	.align 2
.LC131:
	.string	"Chaingun"
	.align 2
.LC130:
	.string	"w_chaingun"
	.align 2
.LC129:
	.string	"models/weapons/v_chain/tris.md2"
	.align 2
.LC128:
	.string	"models/weapons/g_chain/tris.md2"
	.align 2
.LC127:
	.string	"weapon_chaingun"
	.align 2
.LC126:
	.string	"weapons/machgf1b.wav weapons/machgf2b.wav weapons/machgf3b.wav weapons/machgf4b.wav weapons/machgf5b.wav"
	.align 2
.LC125:
	.string	"Machinegun"
	.align 2
.LC124:
	.string	"w_machinegun"
	.align 2
.LC123:
	.string	"models/weapons/v_machn/tris.md2"
	.align 2
.LC122:
	.string	"models/weapons/g_machn/tris.md2"
	.align 2
.LC121:
	.string	"weapon_machinegun"
	.align 2
.LC120:
	.string	"weapons/sshotf1b.wav"
	.align 2
.LC119:
	.string	"Super Shotgun"
	.align 2
.LC118:
	.string	"w_sshotgun"
	.align 2
.LC117:
	.string	"models/weapons/v_shotg2/tris.md2"
	.align 2
.LC116:
	.string	"models/weapons/g_shotg2/tris.md2"
	.align 2
.LC115:
	.string	"weapon_supershotgun"
	.align 2
.LC114:
	.string	"weapons/shotgf1b.wav weapons/shotgr1b.wav"
	.align 2
.LC113:
	.string	"Shotgun"
	.align 2
.LC112:
	.string	"w_shotgun"
	.align 2
.LC111:
	.string	"models/weapons/v_shotg/tris.md2"
	.align 2
.LC110:
	.string	"models/weapons/g_shotg/tris.md2"
	.align 2
.LC109:
	.string	"weapon_shotgun"
	.align 2
.LC108:
	.string	"weapons/blastf1a.wav misc/lasfly.wav"
	.align 2
.LC107:
	.string	"Blaster"
	.align 2
.LC106:
	.string	"w_blaster"
	.align 2
.LC105:
	.string	"models/weapons/v_blast/tris.md2"
	.align 2
.LC104:
	.string	"weapon_blaster"
	.align 2
.LC103:
	.string	"weapons/grapple/grfire.wav weapons/grapple/grpull.wav weapons/grapple/grhang.wav weapons/grapple/grreset.wav weapons/grapple/grhit.wav"
	.align 2
.LC102:
	.string	"Grapple"
	.align 2
.LC101:
	.string	"w_grapple"
	.align 2
.LC100:
	.string	"models/weapons/grapple/tris.md2"
	.align 2
.LC99:
	.string	"misc/w_pkup.wav"
	.align 2
.LC98:
	.string	"weapon_grapple"
	.align 2
.LC97:
	.string	"misc/power2.wav misc/power1.wav"
	.align 2
.LC96:
	.string	"Power Shield"
	.align 2
.LC95:
	.string	"i_powershield"
	.align 2
.LC94:
	.string	"models/items/armor/shield/tris.md2"
	.align 2
.LC93:
	.string	"item_power_shield"
	.align 2
.LC92:
	.string	"Power Screen"
	.align 2
.LC91:
	.string	"i_powerscreen"
	.align 2
.LC90:
	.string	"models/items/armor/screen/tris.md2"
	.align 2
.LC89:
	.string	"misc/ar3_pkup.wav"
	.align 2
.LC88:
	.string	"item_power_screen"
	.align 2
.LC87:
	.string	"Armor Shard"
	.align 2
.LC86:
	.string	"models/items/armor/shard/tris.md2"
	.align 2
.LC85:
	.string	"misc/ar2_pkup.wav"
	.align 2
.LC84:
	.string	"item_armor_shard"
	.align 2
.LC83:
	.string	"Jacket Armor"
	.align 2
.LC82:
	.string	"i_jacketarmor"
	.align 2
.LC81:
	.string	"models/items/armor/jacket/tris.md2"
	.align 2
.LC80:
	.string	"item_armor_jacket"
	.align 2
.LC79:
	.string	"Combat Armor"
	.align 2
.LC78:
	.string	"i_combatarmor"
	.align 2
.LC77:
	.string	"models/items/armor/combat/tris.md2"
	.align 2
.LC76:
	.string	"item_armor_combat"
	.align 2
.LC75:
	.string	""
	.align 2
.LC74:
	.string	"Body Armor"
	.align 2
.LC73:
	.string	"i_bodyarmor"
	.align 2
.LC72:
	.string	"models/items/armor/body/tris.md2"
	.align 2
.LC71:
	.string	"misc/ar1_pkup.wav"
	.align 2
.LC70:
	.string	"item_armor_body"
	.size	 itemlist,3800
	.align 2
.LC290:
	.string	"models/items/healing/medium/tris.md2"
	.align 2
.LC291:
	.string	"models/items/healing/stimpack/tris.md2"
	.align 2
.LC292:
	.string	"models/items/healing/large/tris.md2"
	.align 2
.LC293:
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
	bc 4,0,.L440
	lis 11,itemlist@ha
	lis 9,gi@ha
	la 11,itemlist@l(11)
	la 28,gi@l(9)
	mr 29,10
	addi 30,11,40
.L442:
	lwz 9,24(28)
	addi 3,31,1056
	lwz 4,0(30)
	addi 31,31,1
	mtlr 9
	addi 30,30,76
	blrl
	lwz 0,1556(29)
	cmpw 0,31,0
	bc 12,0,.L442
.L440:
	lis 9,game@ha
	lis 11,jacket_armor_index@ha
	la 10,game@l(9)
	li 30,0
	lwz 0,1556(10)
	la 27,jacket_armor_index@l(11)
	lis 9,.LC83@ha
	lis 11,itemlist@ha
	la 28,.LC83@l(9)
	cmpw 0,30,0
	la 31,itemlist@l(11)
	bc 4,0,.L451
	mr 29,10
.L446:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L448
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L448
	mr 11,31
	b .L450
.L448:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L446
.L451:
	li 11,0
.L450:
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
	lis 10,.LC79@ha
	la 26,combat_armor_index@l(9)
	srawi 11,11,2
	la 28,.LC79@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L459
	mr 29,7
.L454:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L456
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L456
	mr 11,31
	b .L458
.L456:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L454
.L459:
	li 11,0
.L458:
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
	lis 10,.LC74@ha
	la 27,body_armor_index@l(9)
	srawi 11,11,2
	la 28,.LC74@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L467
	mr 29,7
.L462:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L464
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L464
	mr 11,31
	b .L466
.L464:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L462
.L467:
	li 11,0
.L466:
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
	lis 10,.LC92@ha
	la 26,power_screen_index@l(9)
	srawi 11,11,2
	la 28,.LC92@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L475
	mr 29,7
.L470:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L472
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L472
	mr 11,31
	b .L474
.L472:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L470
.L475:
	li 11,0
.L474:
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
	lis 10,.LC96@ha
	la 27,power_shield_index@l(9)
	srawi 11,11,2
	la 28,.LC96@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L483
	mr 29,7
.L478:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L480
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L480
	mr 8,31
	b .L482
.L480:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L478
.L483:
	li 8,0
.L482:
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
.Lfe18:
	.size	 SetItemNames,.Lfe18-SetItemNames
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
	li 0,49
	stw 0,game+1556@l(9)
	blr
.Lfe19:
	.size	 InitItems,.Lfe19-InitItems
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
	b .L484
.L20:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L21
.L19:
	li 3,0
.L484:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 FindItem,.Lfe20-FindItem
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
	b .L485
.L12:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L13
.L11:
	li 3,0
.L485:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 FindItemByClassname,.Lfe21-FindItemByClassname
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
.Lfe22:
	.size	 SetRespawn,.Lfe22-SetRespawn
	.align 2
	.globl ArmorIndex
	.type	 ArmorIndex,@function
ArmorIndex:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L244
	li 3,0
	blr
.L244:
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
.Lfe23:
	.size	 ArmorIndex,.Lfe23-ArmorIndex
	.align 2
	.globl PowerArmorType
	.type	 PowerArmorType,@function
PowerArmorType:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L273
.L488:
	li 3,0
	blr
.L273:
	lwz 0,264(3)
	andi. 9,0,4096
	bc 12,2,.L488
	lis 9,power_shield_index@ha
	addi 11,11,740
	lwz 0,power_shield_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L275
	lis 9,power_screen_index@ha
	lwz 0,power_screen_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	srawi 3,9,31
	subf 3,9,3
	srwi 3,3,31
	blr
.L275:
	li 3,2
	blr
.Lfe24:
	.size	 PowerArmorType,.Lfe24-PowerArmorType
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
.Lfe25:
	.size	 GetItemByIndex,.Lfe25-GetItemByIndex
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
.LC294:
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
	lis 9,.LC294@ha
	lis 11,ctf@ha
	lwz 30,564(31)
	la 9,.LC294@l(9)
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
.Lfe26:
	.size	 DoRespawn,.Lfe26-DoRespawn
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
.Lfe27:
	.size	 Drop_General,.Lfe27-Drop_General
	.section	".rodata"
	.align 2
.LC295:
	.long 0x0
	.align 3
.LC296:
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
	lis 9,.LC295@ha
	lis 11,deathmatch@ha
	la 9,.LC295@l(9)
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
	lis 9,.LC296@ha
	lwz 11,648(12)
	la 9,.LC296@l(9)
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
.Lfe28:
	.size	 Pickup_Adrenaline,.Lfe28-Pickup_Adrenaline
	.section	".rodata"
	.align 2
.LC297:
	.long 0x0
	.align 3
.LC298:
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
	bc 4,2,.L59
	lis 9,.LC297@ha
	lis 11,deathmatch@ha
	la 9,.LC297@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L59
	lis 9,.LC298@ha
	lwz 11,648(12)
	la 9,.LC298@l(9)
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
.L59:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 Pickup_AncientHead,.Lfe29-Pickup_AncientHead
	.section	".rodata"
	.align 3
.LC299:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC300:
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
	lis 9,.LC299@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC299@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3752(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L164
	lis 9,.LC300@ha
	la 9,.LC300@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L490
.L164:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L490:
	stfs 0,3752(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe30:
	.size	 Use_Breather,.Lfe30-Use_Breather
	.section	".rodata"
	.align 3
.LC301:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC302:
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
	lis 9,.LC301@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC301@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3756(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L167
	lis 9,.LC302@ha
	la 9,.LC302@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L491
.L167:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L491:
	stfs 0,3756(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe31:
	.size	 Use_Envirosuit,.Lfe31-Use_Envirosuit
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
	lwz 9,3768(11)
	addi 9,9,30
	stw 9,3768(11)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe32:
	.size	 Use_Silencer,.Lfe32-Use_Silencer
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
	bc 12,0,.L222
	stw 11,532(29)
	b .L223
.L222:
	stw 0,532(29)
.L223:
	lwz 9,84(31)
	slwi 11,28,2
	lwz 8,532(29)
	mr 10,9
	lwz 9,1788(9)
	cmpwi 0,9,0
	bc 12,2,.L224
	lwz 0,68(9)
	cmpwi 0,0,3
	bc 4,2,.L224
	lwz 0,68(30)
	cmpwi 0,0,3
	bc 4,2,.L224
	addi 9,10,740
	lwzx 0,9,11
	subf. 9,8,0
	bc 12,1,.L224
	lis 5,.LC29@ha
	mr 3,31
	la 5,.LC29@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	mr 3,29
	bl G_FreeEdict
	b .L221
.L224:
	addi 9,10,740
	mr 3,31
	lwzx 0,9,11
	subf 0,8,0
	stwx 0,9,11
	bl ValidateSelectedItem
.L221:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 Drop_Ammo,.Lfe33-Drop_Ammo
	.section	".rodata"
	.align 2
.LC303:
	.long 0x3f800000
	.align 2
.LC304:
	.long 0x0
	.align 2
.LC305:
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
	bc 4,1,.L226
	bl CTFHasRegeneration
	cmpwi 0,3,0
	bc 4,2,.L226
	lis 11,.LC303@ha
	lis 9,level+4@ha
	la 11,.LC303@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	lwz 11,256(31)
	fadds 0,0,13
	stfs 0,428(31)
	lwz 9,480(11)
	addi 9,9,-1
	stw 9,480(11)
	b .L225
.L226:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L227
	lis 9,.LC304@ha
	lis 11,deathmatch@ha
	la 9,.LC304@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L227
	lwz 9,264(31)
	lis 11,.LC305@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC305@l(11)
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
	b .L225
.L227:
	mr 3,31
	bl G_FreeEdict
.L225:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe34:
	.size	 MegaHealth_think,.Lfe34-MegaHealth_think
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
	bc 12,2,.L296
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
	bc 4,2,.L296
	bl Use_PowerArmor
.L296:
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
	bc 12,2,.L320
	bl Touch_Item
.L320:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe36:
	.size	 drop_temp_touch,.Lfe36-drop_temp_touch
	.section	".rodata"
	.align 2
.LC306:
	.long 0x0
	.align 2
.LC307:
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
	lis 9,.LC306@ha
	lfs 0,20(10)
	la 9,.LC306@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bclr 12,2
	lis 9,.LC307@ha
	lis 11,level+4@ha
	la 9,.LC307@l(9)
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
	bc 12,2,.L329
	li 0,2
	stw 11,444(3)
	stw 0,248(3)
	b .L330
.L329:
	lis 9,Touch_Item@ha
	li 0,1
	la 9,Touch_Item@l(9)
	stw 0,248(3)
	stw 9,444(3)
.L330:
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
.LC308:
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
	lis 11,.LC308@ha
	lis 9,deathmatch@ha
	la 11,.LC308@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L398
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L398
	bl G_FreeEdict
	b .L397
.L492:
	mr 4,31
	b .L405
.L398:
	lis 9,.LC290@ha
	li 0,10
	la 9,.LC290@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC260@ha
	lis 11,itemlist@ha
	la 27,.LC260@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L406
	mr 28,10
.L401:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L403
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L492
.L403:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L401
.L406:
	li 4,0
.L405:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC45@ha
	lwz 0,gi+36@l(9)
	la 3,.LC45@l(3)
	mtlr 0
	blrl
.L397:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe39:
	.size	 SP_item_health,.Lfe39-SP_item_health
	.section	".rodata"
	.align 2
.LC309:
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
	lis 11,.LC309@ha
	lis 9,deathmatch@ha
	la 11,.LC309@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L408
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L408
	bl G_FreeEdict
	b .L407
.L493:
	mr 4,31
	b .L415
.L408:
	lis 9,.LC291@ha
	li 0,2
	la 9,.LC291@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC260@ha
	lis 11,itemlist@ha
	la 27,.LC260@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L416
	mr 28,10
.L411:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L413
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L493
.L413:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L411
.L416:
	li 4,0
.L415:
	mr 3,29
	bl SpawnItem
	li 0,1
	lis 9,gi+36@ha
	stw 0,644(29)
	lis 3,.LC44@ha
	lwz 0,gi+36@l(9)
	la 3,.LC44@l(3)
	mtlr 0
	blrl
.L407:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe40:
	.size	 SP_item_health_small,.Lfe40-SP_item_health_small
	.section	".rodata"
	.align 2
.LC310:
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
	lis 11,.LC310@ha
	lis 9,deathmatch@ha
	la 11,.LC310@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L418
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L418
	bl G_FreeEdict
	b .L417
.L494:
	mr 4,31
	b .L425
.L418:
	lis 9,.LC292@ha
	li 0,25
	la 9,.LC292@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC260@ha
	lis 11,itemlist@ha
	la 27,.LC260@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L426
	mr 28,10
.L421:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L423
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L494
.L423:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L421
.L426:
	li 4,0
.L425:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC46@ha
	lwz 0,gi+36@l(9)
	la 3,.LC46@l(3)
	mtlr 0
	blrl
.L417:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe41:
	.size	 SP_item_health_large,.Lfe41-SP_item_health_large
	.section	".rodata"
	.align 2
.LC311:
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
	lis 11,.LC311@ha
	lis 9,deathmatch@ha
	la 11,.LC311@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L428
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L428
	bl G_FreeEdict
	b .L427
.L495:
	mr 4,31
	b .L435
.L428:
	lis 9,.LC293@ha
	li 0,100
	la 9,.LC293@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC260@ha
	lis 11,itemlist@ha
	la 27,.LC260@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L436
	mr 28,10
.L431:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L433
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L495
.L433:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L431
.L436:
	li 4,0
.L435:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC47@ha
	lwz 0,gi+36@l(9)
	la 3,.LC47@l(3)
	mtlr 0
	blrl
	li 0,3
	stw 0,644(29)
.L427:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe42:
	.size	 SP_item_health_mega,.Lfe42-SP_item_health_mega
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
