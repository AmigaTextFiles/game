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
	lis 9,itemlist@ha
	lwz 8,664(31)
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
	bc 4,2,.L49
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
	bc 4,2,.L49
	lis 11,coop@ha
	lis 7,.LC3@ha
	lwz 9,coop@l(11)
	la 7,.LC3@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L41
	lwz 0,56(8)
	rlwinm 0,0,29,31,31
	and. 9,0,10
	bc 12,2,.L41
.L49:
	li 3,0
	b .L48
.L41:
	lwz 0,664(31)
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
	bc 12,2,.L42
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L43
	lis 9,.LC4@ha
	lwz 11,664(31)
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
.L43:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,16
	bc 4,2,.L46
	lwz 9,664(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L42
	lwz 0,284(31)
	andis. 7,0,2
	bc 12,2,.L42
.L46:
	lwz 9,664(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L47
	lwz 0,284(31)
	andis. 9,0,2
	bc 12,2,.L47
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
.L47:
	lwz 9,664(31)
	mr 3,30
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L42:
	li 3,1
.L48:
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
	bc 12,1,.L60
	li 0,250
	stw 0,1764(9)
.L60:
	lwz 9,84(29)
	lwz 0,1768(9)
	cmpwi 0,0,149
	bc 12,1,.L61
	li 0,150
	stw 0,1768(9)
.L61:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,249
	bc 12,1,.L62
	li 0,250
	stw 0,1780(9)
.L62:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,74
	bc 12,1,.L63
	li 0,75
	stw 0,1784(9)
.L63:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC5@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC5@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L71
	mr 27,10
.L66:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L68
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L68
	mr 8,31
	b .L70
.L68:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L66
.L71:
	li 8,0
.L70:
	cmpwi 0,8,0
	bc 12,2,.L72
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
	bc 4,1,.L72
	stwx 11,9,8
.L72:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC6@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC6@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L81
	mr 27,10
.L76:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L78
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L78
	mr 8,31
	b .L80
.L78:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L76
.L81:
	li 8,0
.L80:
	cmpwi 0,8,0
	bc 12,2,.L82
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
	bc 4,1,.L82
	stwx 11,4,8
.L82:
	lwz 0,284(28)
	andis. 4,0,0x1
	bc 4,2,.L84
	lis 9,.LC7@ha
	lis 11,deathmatch@ha
	la 9,.LC7@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L84
	lis 9,.LC8@ha
	lwz 11,664(28)
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
.L84:
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
	bc 12,1,.L87
	li 0,300
	stw 0,1764(9)
.L87:
	lwz 9,84(29)
	lwz 0,1768(9)
	cmpwi 0,0,199
	bc 12,1,.L88
	li 0,200
	stw 0,1768(9)
.L88:
	lwz 9,84(29)
	lwz 0,1772(9)
	cmpwi 0,0,99
	bc 12,1,.L89
	li 0,100
	stw 0,1772(9)
.L89:
	lwz 9,84(29)
	lwz 0,1776(9)
	cmpwi 0,0,99
	bc 12,1,.L90
	li 0,100
	stw 0,1776(9)
.L90:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,299
	bc 12,1,.L91
	li 0,300
	stw 0,1780(9)
.L91:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,99
	bc 12,1,.L92
	li 0,100
	stw 0,1784(9)
.L92:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC5@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC5@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L100
	mr 28,10
.L95:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L97
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L97
	mr 8,31
	b .L99
.L97:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L95
.L100:
	li 8,0
.L99:
	cmpwi 0,8,0
	bc 12,2,.L101
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
	bc 4,1,.L101
	stwx 11,9,8
.L101:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC6@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC6@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L110
	mr 28,10
.L105:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L107
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L107
	mr 8,31
	b .L109
.L107:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L105
.L110:
	li 8,0
.L109:
	cmpwi 0,8,0
	bc 12,2,.L111
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
	bc 4,1,.L111
	stwx 11,9,8
.L111:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC9@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC9@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L120
	mr 28,10
.L115:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L117
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L117
	mr 8,31
	b .L119
.L117:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L115
.L120:
	li 8,0
.L119:
	cmpwi 0,8,0
	bc 12,2,.L121
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
	bc 4,1,.L121
	stwx 11,9,8
.L121:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC10@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC10@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L130
	mr 28,10
.L125:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L127
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L127
	mr 8,31
	b .L129
.L127:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L125
.L130:
	li 8,0
.L129:
	cmpwi 0,8,0
	bc 12,2,.L131
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
	bc 4,1,.L131
	stwx 11,9,8
.L131:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC11@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC11@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L140
	mr 28,10
.L135:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L137
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L137
	mr 8,31
	b .L139
.L137:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L135
.L140:
	li 8,0
.L139:
	cmpwi 0,8,0
	bc 12,2,.L141
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
	bc 4,1,.L141
	stwx 11,9,8
.L141:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC12@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC12@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L150
	mr 28,10
.L145:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L147
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L147
	mr 8,31
	b .L149
.L147:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L145
.L150:
	li 8,0
.L149:
	cmpwi 0,8,0
	bc 12,2,.L151
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
	bc 4,1,.L151
	stwx 11,4,8
.L151:
	lwz 0,284(27)
	andis. 4,0,0x1
	bc 4,2,.L153
	lis 9,.LC13@ha
	lis 11,deathmatch@ha
	la 9,.LC13@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L153
	lis 9,.LC14@ha
	lwz 11,664(27)
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
.L153:
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
	bc 12,2,.L156
	li 0,0
	mr 10,9
	stw 0,quad_drop_timeout_hack@l(11)
	b .L157
.L156:
	li 10,300
.L157:
	lis 11,level@ha
	lwz 8,84(31)
	lwz 11,level@l(11)
	lis 7,0x4330
	lis 6,.LC16@ha
	la 6,.LC16@l(6)
	lfs 12,3688(8)
	xoris 0,11,0x8000
	lfd 13,0(6)
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L158
	xoris 0,10,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fadds 0,12,0
	b .L160
.L158:
	add 0,11,10
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
.L160:
	stfs 0,3688(8)
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
	lis 9,.LC20@ha
	lis 11,level@ha
	lwz 10,84(31)
	la 9,.LC20@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3692(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L168
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L170
.L168:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L170:
	stfs 0,3692(10)
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
	bc 12,2,.L173
	lwz 3,280(31)
	lis 4,.LC24@ha
	la 4,.LC24@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L174
	lwz 10,84(30)
	lbz 9,286(31)
	lwz 0,1796(10)
	and. 11,0,9
	bc 4,2,.L179
	lwz 0,664(31)
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
	lwz 0,1796(11)
	or 0,0,9
	stw 0,1796(11)
	b .L176
.L174:
	lwz 0,664(31)
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
	bc 12,2,.L177
.L179:
	li 3,0
	b .L178
.L177:
	li 0,1
	stwx 0,4,3
.L176:
	li 3,1
	b .L178
.L173:
	lwz 0,664(31)
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
.L178:
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
	bc 4,2,.L181
.L197:
	li 3,0
	blr
.L181:
	lwz 0,64(4)
	cmpwi 0,0,0
	bc 4,2,.L182
	lwz 10,1764(9)
	b .L183
.L182:
	cmpwi 0,0,1
	bc 4,2,.L184
	lwz 10,1768(9)
	b .L183
.L184:
	cmpwi 0,0,2
	bc 4,2,.L186
	lwz 10,1772(9)
	b .L183
.L186:
	cmpwi 0,0,3
	bc 4,2,.L188
	lwz 10,1776(9)
	b .L183
.L188:
	cmpwi 0,0,4
	bc 4,2,.L190
	lwz 10,1780(9)
	b .L183
.L190:
	cmpwi 0,0,5
	bc 4,2,.L197
	lwz 10,1784(9)
.L183:
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
	bc 12,2,.L197
	add 0,0,5
	stwx 0,11,4
	lwz 9,84(3)
	addi 3,9,740
	lwzx 0,3,4
	cmpw 0,0,10
	bc 4,1,.L195
	stwx 10,3,4
.L195:
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
	mr 29,3
	mr 28,4
	lwz 4,664(29)
	lwz 0,56(4)
	andi. 30,0,1
	bc 12,2,.L199
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8192
	li 5,1000
	bc 4,2,.L200
.L199:
	lwz 5,532(29)
	cmpwi 0,5,0
	bc 12,2,.L201
	lwz 4,664(29)
	b .L200
.L201:
	lwz 9,664(29)
	lwz 5,48(9)
	mr 4,9
.L200:
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
	bc 4,2,.L203
	li 3,0
	b .L217
.L218:
	mr 9,31
	b .L213
.L203:
	subfic 9,31,0
	adde 0,9,31
	and. 11,30,0
	bc 12,2,.L204
	lwz 25,84(28)
	lwz 9,664(29)
	lwz 0,1788(25)
	cmpw 0,0,9
	bc 12,2,.L204
	lis 9,.LC27@ha
	lis 11,deathmatch@ha
	la 9,.LC27@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L206
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC26@ha
	lwz 0,1556(9)
	la 26,.LC26@l(11)
	mr 31,27
	cmpw 0,30,0
	bc 4,0,.L214
	mr 27,9
.L209:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L211
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L218
.L211:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L209
.L214:
	li 9,0
.L213:
	lwz 0,1788(25)
	cmpw 0,0,9
	bc 4,2,.L204
.L206:
	lwz 9,84(28)
	lwz 0,664(29)
	stw 0,3512(9)
.L204:
	lwz 0,284(29)
	andis. 7,0,0x3
	bc 4,2,.L215
	lis 9,.LC27@ha
	lis 11,deathmatch@ha
	la 9,.LC27@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L215
	lwz 9,264(29)
	lis 11,.LC28@ha
	lis 10,level+4@ha
	lwz 0,184(29)
	la 11,.LC28@l(11)
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
.L215:
	li 3,1
.L217:
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
	.string	"items/s_health.wav"
	.align 2
.LC30:
	.string	"items/n_health.wav"
	.align 2
.LC31:
	.string	"items/l_health.wav"
	.align 2
.LC32:
	.string	"items/m_health.wav"
	.align 2
.LC33:
	.long 0x40a00000
	.align 2
.LC34:
	.long 0x0
	.align 2
.LC35:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Pickup_Health
	.type	 Pickup_Health,@function
Pickup_Health:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 7,3
	lwz 0,660(7)
	andi. 8,0,1
	bc 4,2,.L228
	lwz 9,480(4)
	lwz 0,484(4)
	cmpw 0,9,0
	bc 12,0,.L228
	li 3,0
	b .L242
.L228:
	lwz 0,480(4)
	lwz 9,532(7)
	add 0,0,9
	stw 0,480(4)
	lwz 0,532(7)
	cmpwi 0,0,2
	bc 4,2,.L230
	lwz 11,664(7)
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	b .L243
.L230:
	cmpwi 0,0,10
	bc 4,2,.L232
	lwz 11,664(7)
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	b .L243
.L232:
	cmpwi 0,0,25
	bc 4,2,.L234
	lwz 11,664(7)
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	b .L243
.L234:
	lwz 11,664(7)
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
.L243:
	stw 9,20(11)
	lwz 0,660(7)
	andi. 9,0,1
	bc 4,2,.L236
	lwz 0,480(4)
	lwz 9,484(4)
	cmpw 0,0,9
	bc 4,1,.L236
	stw 9,480(4)
.L236:
	lwz 0,660(7)
	andi. 11,0,2
	bc 12,2,.L238
	lis 9,MegaHealth_think@ha
	lis 8,.LC33@ha
	lwz 11,264(7)
	la 9,MegaHealth_think@l(9)
	lis 10,level+4@ha
	lwz 0,184(7)
	stw 9,436(7)
	la 8,.LC33@l(8)
	oris 11,11,0x8000
	lfs 0,level+4@l(10)
	li 9,0
	ori 0,0,1
	lfs 13,0(8)
	stw 9,248(7)
	stw 4,256(7)
	fadds 0,0,13
	stw 11,264(7)
	stw 0,184(7)
	stfs 0,428(7)
	b .L239
.L238:
	lwz 0,284(7)
	andis. 6,0,0x1
	bc 4,2,.L239
	lis 9,.LC34@ha
	lis 11,deathmatch@ha
	la 9,.LC34@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L239
	lwz 9,264(7)
	lis 11,.LC35@ha
	lis 10,level+4@ha
	lwz 0,184(7)
	la 11,.LC35@l(11)
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
.L239:
	li 3,1
.L242:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 Pickup_Health,.Lfe9-Pickup_Health
	.section	".rodata"
	.align 3
.LC36:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC37:
	.long 0x0
	.align 2
.LC38:
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
	lwz 9,664(31)
	cmpwi 0,11,0
	lwz 7,60(9)
	bc 4,2,.L250
	li 6,0
	b .L251
.L250:
	lis 9,jacket_armor_index@ha
	addi 8,11,740
	lwz 6,jacket_armor_index@l(9)
	slwi 0,6,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L251
	lis 9,combat_armor_index@ha
	lwz 6,combat_armor_index@l(9)
	slwi 0,6,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L251
	lis 9,body_armor_index@ha
	lwz 10,body_armor_index@l(9)
	slwi 11,10,2
	lwzx 9,8,11
	srawi 0,9,31
	subf 0,9,0
	srawi 0,0,31
	and 6,10,0
.L251:
	lwz 8,664(31)
	lwz 0,64(8)
	cmpwi 0,0,4
	bc 4,2,.L255
	cmpwi 0,6,0
	bc 4,2,.L256
	lis 11,jacket_armor_index@ha
	lwz 9,84(12)
	li 10,2
	lwz 0,jacket_armor_index@l(11)
	addi 9,9,740
	slwi 0,0,2
	stwx 10,9,0
	b .L258
.L256:
	lwz 9,84(12)
	slwi 0,6,2
	addi 9,9,740
	lwzx 11,9,0
	addi 11,11,2
	stwx 11,9,0
	b .L258
.L255:
	cmpwi 0,6,0
	bc 4,2,.L259
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
	b .L258
.L259:
	lis 9,jacket_armor_index@ha
	lwz 0,jacket_armor_index@l(9)
	cmpw 0,6,0
	bc 4,2,.L261
	lis 9,jacketarmor_info@ha
	la 11,jacketarmor_info@l(9)
	b .L262
.L261:
	lis 9,combat_armor_index@ha
	lwz 0,combat_armor_index@l(9)
	cmpw 0,6,0
	bc 4,2,.L263
	lis 9,combatarmor_info@ha
	la 11,combatarmor_info@l(9)
	b .L262
.L263:
	lis 9,bodyarmor_info@ha
	la 11,bodyarmor_info@l(9)
.L262:
	lfs 13,8(7)
	lfs 0,8(11)
	fcmpu 0,13,0
	bc 4,1,.L265
	fdivs 11,0,13
	lwz 9,84(12)
	slwi 6,6,2
	lis 5,0x4330
	lis 10,.LC36@ha
	lwz 3,0(7)
	addi 9,9,740
	la 10,.LC36@l(10)
	lwz 7,4(7)
	lwzx 11,9,6
	li 0,0
	mr 4,8
	lfd 13,0(10)
	xoris 11,11,0x8000
	stwx 0,9,6
	lis 10,itemlist@ha
	stw 11,20(1)
	la 10,itemlist@l(10)
	lis 0,0x38e3
	stw 5,16(1)
	ori 0,0,36409
	lfd 0,16(1)
	lwz 9,664(31)
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
	b .L258
.L265:
	fdivs 11,13,0
	lwz 0,0(7)
	lis 8,0x4330
	lis 10,.LC36@ha
	mr 7,9
	lwz 11,4(11)
	xoris 0,0,0x8000
	la 10,.LC36@l(10)
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
	bc 12,0,.L269
	li 3,0
	b .L272
.L269:
	stwx 0,4,6
.L258:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L270
	lis 9,.LC37@ha
	lis 11,deathmatch@ha
	la 9,.LC37@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L270
	lwz 9,264(31)
	lis 11,.LC38@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC38@l(11)
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
.L270:
	li 3,1
.L272:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 Pickup_Armor,.Lfe10-Pickup_Armor
	.section	".rodata"
	.align 2
.LC39:
	.string	"misc/power2.wav"
	.align 2
.LC40:
	.string	"cells"
	.align 2
.LC41:
	.string	"No cells for power armor.\n"
	.align 2
.LC42:
	.string	"misc/power1.wav"
	.align 2
.LC43:
	.long 0x3f800000
	.align 2
.LC44:
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
	bc 12,2,.L279
	rlwinm 0,0,0,20,18
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(30)
	lis 3,.LC39@ha
	lwz 9,36(29)
	la 3,.LC39@l(3)
	mtlr 9
	blrl
	lis 9,.LC43@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC43@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 2,0(9)
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 3,0(9)
	blrl
	b .L278
.L290:
	mr 10,29
	b .L287
.L279:
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lis 11,.LC40@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC40@l(11)
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L288
	mr 28,10
.L283:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L285
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L290
.L285:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,72
	cmpw 0,31,0
	bc 12,0,.L283
.L288:
	li 10,0
.L287:
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
	bc 4,2,.L289
	lis 9,gi+8@ha
	lis 5,.LC41@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC41@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L278
.L289:
	lwz 0,264(30)
	lis 29,gi@ha
	lis 3,.LC42@ha
	la 29,gi@l(29)
	la 3,.LC42@l(3)
	ori 0,0,4096
	stw 0,264(30)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC43@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC43@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 2,0(9)
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 3,0(9)
	blrl
.L278:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 Use_PowerArmor,.Lfe11-Use_PowerArmor
	.section	".rodata"
	.align 2
.LC45:
	.long 0x0
	.align 3
.LC46:
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
	lis 9,.LC45@ha
	slwi 0,0,2
	la 9,.LC45@l(9)
	lwzx 30,10,0
	lfs 13,0(9)
	addi 9,30,1
	stwx 9,10,0
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L292
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L293
	lis 9,.LC46@ha
	lwz 11,664(31)
	la 9,.LC46@l(9)
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
.L293:
	cmpwi 0,30,0
	bc 4,2,.L292
	lwz 9,664(31)
	mr 3,29
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L292:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 Pickup_PowerArmor,.Lfe12-Pickup_PowerArmor
	.section	".rodata"
	.align 3
.LC47:
	.long 0x40080000
	.long 0x0
	.align 2
.LC48:
	.long 0x3f800000
	.align 2
.LC49:
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
	bc 12,2,.L299
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L299
	lwz 9,664(31)
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 12,2,.L299
	mtlr 0
	blrl
	mr. 28,3
	bc 12,2,.L303
	lwz 11,84(30)
	lis 0,0x3e80
	lis 9,gi@ha
	la 29,gi@l(9)
	stw 0,3600(11)
	lwz 9,664(31)
	lwz 11,40(29)
	lwz 3,36(9)
	mtlr 11
	blrl
	lis 9,itemlist@ha
	lwz 11,84(30)
	lis 8,0x38e3
	la 7,itemlist@l(9)
	ori 8,8,36409
	lis 9,.LC47@ha
	sth 3,134(11)
	lis 10,level+4@ha
	la 9,.LC47@l(9)
	lwz 11,84(30)
	lfd 13,0(9)
	lwz 9,664(31)
	subf 9,7,9
	mullw 9,9,8
	srawi 9,9,3
	addi 9,9,1056
	sth 9,136(11)
	lfs 0,level+4@l(10)
	lwz 9,84(30)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3720(9)
	lwz 9,664(31)
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 12,2,.L304
	subf 0,7,9
	lwz 11,84(30)
	mullw 0,0,8
	srawi 0,0,3
	extsh 9,0
	sth 0,144(11)
	stw 9,736(11)
.L304:
	lwz 9,664(31)
	lwz 11,36(29)
	lwz 3,20(9)
	mtlr 11
	blrl
	lis 9,.LC48@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC48@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfs 2,0(9)
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfs 3,0(9)
	blrl
.L303:
	lwz 0,284(31)
	andis. 9,0,4
	bc 4,2,.L305
	mr 4,30
	mr 3,31
	bl G_UseTargets
	lwz 0,284(31)
	oris 0,0,0x4
	stw 0,284(31)
.L305:
	cmpwi 0,28,0
	bc 12,2,.L299
	lis 9,.LC49@ha
	lis 11,coop@ha
	la 9,.LC49@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L308
	lwz 9,664(31)
	lwz 0,56(9)
	andi. 9,0,8
	bc 12,2,.L308
	lwz 0,284(31)
	andis. 9,0,0x3
	bc 12,2,.L299
.L308:
	lwz 0,264(31)
	cmpwi 0,0,0
	bc 4,0,.L309
	rlwinm 0,0,0,1,31
	stw 0,264(31)
	b .L299
.L309:
	mr 3,31
	bl G_FreeEdict
.L299:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 Touch_Item,.Lfe13-Touch_Item
	.section	".rodata"
	.align 2
.LC50:
	.long 0x42c80000
	.align 2
.LC51:
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
	stw 0,260(31)
	stw 9,444(31)
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 12,2,.L316
	addi 29,1,24
	addi 4,1,8
	addi 3,3,3616
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
	b .L318
.L316:
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
.L318:
	stfs 0,12(31)
	lis 9,.LC50@ha
	addi 3,1,8
	la 9,.LC50@l(9)
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
	lis 9,.LC51@ha
	lfs 0,level+4@l(11)
	la 9,.LC51@l(9)
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
.LC52:
	.string	"droptofloor: %s startsolid at %s\n"
	.align 3
.LC53:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC54:
	.long 0xc1700000
	.align 2
.LC55:
	.long 0x41700000
	.align 2
.LC56:
	.long 0x0
	.align 2
.LC57:
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
	lis 9,.LC54@ha
	lis 11,.LC54@ha
	la 9,.LC54@l(9)
	la 11,.LC54@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC54@ha
	lfs 2,0(11)
	la 9,.LC54@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC55@ha
	lfs 13,0(11)
	la 9,.LC55@l(9)
	lfs 1,0(9)
	lis 9,.LC55@ha
	stfs 13,188(31)
	la 9,.LC55@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC55@ha
	stfs 0,192(31)
	la 9,.LC55@l(9)
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
	bc 12,2,.L323
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L324
.L323:
	lis 9,gi+44@ha
	lwz 11,664(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L324:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC56@ha
	stw 9,444(31)
	addi 29,31,4
	la 11,.LC56@l(11)
	lis 9,.LC57@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC57@l(9)
	lis 11,.LC56@ha
	lfs 3,0(9)
	la 11,.LC56@l(11)
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
	bc 12,2,.L325
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC52@ha
	la 3,.LC52@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L322
.L325:
	lwz 0,308(31)
	lfs 12,20(1)
	lfs 0,24(1)
	cmpwi 0,0,0
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L326
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
	bc 4,2,.L326
	lis 11,level+4@ha
	lis 10,.LC53@ha
	lfs 0,level+4@l(11)
	lis 9,DoRespawn@ha
	lfd 13,.LC53@l(10)
	la 9,DoRespawn@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L326:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L328
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
.L328:
	lwz 0,284(31)
	andi. 11,0,1
	bc 12,2,.L329
	lwz 0,184(31)
	lis 9,Use_Item@ha
	li 11,0
	la 9,Use_Item@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
.L329:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L322:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe15:
	.size	 droptofloor,.Lfe15-droptofloor
	.section	".rodata"
	.align 2
.LC58:
	.string	"PrecacheItem: %s has bad precache string"
	.align 2
.LC59:
	.string	"md2"
	.align 2
.LC60:
	.string	"sp2"
	.align 2
.LC61:
	.string	"wav"
	.align 2
.LC62:
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
	bc 12,2,.L330
	lwz 3,20(26)
	cmpwi 0,3,0
	bc 12,2,.L332
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L332:
	lwz 3,24(26)
	cmpwi 0,3,0
	bc 12,2,.L333
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L333:
	lwz 3,32(26)
	cmpwi 0,3,0
	bc 12,2,.L334
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L334:
	lwz 3,36(26)
	cmpwi 0,3,0
	bc 12,2,.L335
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
.L335:
	lwz 29,52(26)
	cmpwi 0,29,0
	bc 12,2,.L336
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L336
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L344
	mr 28,9
.L339:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L341
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L341
	mr 3,31
	b .L343
.L341:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L339
.L344:
	li 3,0
.L343:
	cmpw 0,3,26
	bc 12,2,.L336
	bl PrecacheItem
.L336:
	lwz 30,68(26)
	cmpwi 0,30,0
	bc 12,2,.L330
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 12,2,.L330
	lis 9,gi@ha
	addi 29,1,8
	la 27,gi@l(9)
	lis 24,.LC59@ha
	lis 25,.LC62@ha
.L350:
	rlwinm 9,0,0,0xff
	mr 31,30
	b .L364
.L353:
	lbzu 9,1(30)
.L364:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L353
	subf 28,31,30
	addi 0,28,-5
	cmplwi 0,0,58
	bc 4,1,.L355
	lwz 9,28(27)
	lis 3,.LC58@ha
	la 3,.LC58@l(3)
	lwz 4,0(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L355:
	mr 4,31
	mr 5,28
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 0,0
	addi 11,30,1
	stbx 0,29,28
	add 9,29,28
	la 4,.LC59@l(24)
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
	bc 12,2,.L365
	lis 4,.LC60@ha
	mr 3,31
	la 4,.LC60@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L359
.L365:
	lwz 9,32(27)
	mr 3,29
	mtlr 9
	blrl
	b .L358
.L359:
	lis 4,.LC61@ha
	mr 3,31
	la 4,.LC61@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L358
	lwz 9,36(27)
	mr 3,29
	mtlr 9
	blrl
.L358:
	add 3,29,28
	la 4,.LC62@l(25)
	addi 3,3,-3
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L348
	lwz 9,40(27)
	mr 3,29
	mtlr 9
	blrl
.L348:
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L350
.L330:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe16:
	.size	 PrecacheItem,.Lfe16-PrecacheItem
	.section	".rodata"
	.align 2
.LC63:
	.string	"%s at %s has invalid spawnflags set\n"
	.align 2
.LC64:
	.string	"weapon_bfg"
	.align 3
.LC65:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC66:
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
	bc 12,2,.L367
	lwz 3,280(31)
	lis 4,.LC24@ha
	la 4,.LC24@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L367
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
	lis 3,.LC63@ha
	la 3,.LC63@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L367:
	lis 9,.LC66@ha
	lis 11,deathmatch@ha
	la 9,.LC66@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L369
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2048
	bc 12,2,.L370
	lwz 0,4(30)
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L380
	lis 9,Pickup_PowerArmor@ha
	la 9,Pickup_PowerArmor@l(9)
	cmpw 0,0,9
	bc 12,2,.L380
.L370:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 12,2,.L373
	lwz 0,4(30)
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L380
.L373:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 12,2,.L375
	lwz 0,4(30)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L380
	lis 9,Pickup_Adrenaline@ha
	la 9,Pickup_Adrenaline@l(9)
	cmpw 0,0,9
	bc 12,2,.L380
	lis 9,Pickup_AncientHead@ha
	la 9,Pickup_AncientHead@l(9)
	cmpw 0,0,9
	bc 12,2,.L380
.L375:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8192
	bc 12,2,.L369
	lwz 0,56(30)
	cmpwi 0,0,2
	bc 12,2,.L380
	lwz 3,280(31)
	lis 4,.LC64@ha
	la 4,.LC64@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L369
.L380:
	mr 3,31
	bl G_FreeEdict
	b .L366
.L369:
	lis 11,.LC66@ha
	lis 9,coop@ha
	la 11,.LC66@l(11)
	lis 29,level@ha
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L381
	lwz 3,280(31)
	lis 4,.LC24@ha
	la 4,.LC24@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L381
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
.L381:
	lis 9,.LC66@ha
	lis 11,coop@ha
	la 9,.LC66@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L382
	lwz 0,56(30)
	andi. 11,0,8
	bc 12,2,.L382
	li 0,0
	stw 0,12(30)
.L382:
	stw 30,664(31)
	lis 11,level+4@ha
	lis 10,.LC65@ha
	lfs 0,level+4@l(11)
	lis 9,droptofloor@ha
	lfd 13,.LC65@l(10)
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
	bc 12,2,.L366
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L366:
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
	.space	68
	.long .LC67
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC68
	.long .LC69
	.long 1
	.long 0
	.long .LC70
	.long .LC71
	.long 3
	.long 0
	.long 0
	.long 4
	.long bodyarmor_info
	.long 3
	.long .LC72
	.long .LC73
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC68
	.long .LC74
	.long 1
	.long 0
	.long .LC75
	.long .LC76
	.long 3
	.long 0
	.long 0
	.long 4
	.long combatarmor_info
	.long 2
	.long .LC72
	.long .LC77
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC68
	.long .LC78
	.long 1
	.long 0
	.long .LC79
	.long .LC80
	.long 3
	.long 0
	.long 0
	.long 4
	.long jacketarmor_info
	.long 1
	.long .LC72
	.long .LC81
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC82
	.long .LC83
	.long 1
	.long 0
	.long .LC79
	.long .LC84
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long 4
	.long .LC72
	.long .LC85
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC86
	.long .LC87
	.long 1
	.long 0
	.long .LC88
	.long .LC89
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long .LC72
	.long .LC90
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC86
	.long .LC91
	.long 1
	.long 0
	.long .LC92
	.long .LC93
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long .LC94
	.long .LC95
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Blaster
	.long .LC96
	.long 0
	.long 0
	.long .LC97
	.long .LC98
	.long .LC99
	.long 0
	.long 0
	.long 0
	.long 9
	.long 0
	.long 0
	.long .LC100
	.long .LC101
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Shotgun
	.long .LC96
	.long .LC102
	.long 1
	.long .LC103
	.long .LC104
	.long .LC105
	.long 0
	.long 1
	.long .LC6
	.long 9
	.long 0
	.long 0
	.long .LC106
	.long .LC107
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_SuperShotgun
	.long .LC96
	.long .LC108
	.long 1
	.long .LC109
	.long .LC110
	.long .LC111
	.long 0
	.long 2
	.long .LC6
	.long 9
	.long 0
	.long 0
	.long .LC112
	.long .LC113
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Machinegun
	.long .LC96
	.long .LC114
	.long 1
	.long .LC115
	.long .LC116
	.long .LC117
	.long 0
	.long 1
	.long .LC5
	.long 9
	.long 0
	.long 0
	.long .LC118
	.long .LC119
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Chaingun
	.long .LC96
	.long .LC120
	.long 1
	.long .LC121
	.long .LC122
	.long .LC123
	.long 0
	.long 1
	.long .LC5
	.long 9
	.long 0
	.long 0
	.long .LC124
	.long .LC125
	.long Pickup_Ammo
	.long Use_Weapon
	.long Drop_Ammo
	.long Weapon_Grenade
	.long .LC126
	.long .LC127
	.long 0
	.long .LC128
	.long .LC129
	.long .LC10
	.long 3
	.long 5
	.long .LC130
	.long 3
	.long 0
	.long 3
	.long .LC131
	.long .LC132
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_GrenadeLauncher
	.long .LC96
	.long .LC133
	.long 1
	.long .LC134
	.long .LC135
	.long .LC136
	.long 0
	.long 1
	.long .LC10
	.long 9
	.long 0
	.long 0
	.long .LC137
	.long .LC138
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_RocketLauncher
	.long .LC96
	.long .LC139
	.long 1
	.long .LC140
	.long .LC141
	.long .LC142
	.long 0
	.long 1
	.long .LC11
	.long 9
	.long 0
	.long 0
	.long .LC143
	.long .LC144
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_HyperBlaster
	.long .LC96
	.long .LC145
	.long 1
	.long .LC146
	.long .LC147
	.long .LC148
	.long 0
	.long 1
	.long .LC9
	.long 9
	.long 0
	.long 0
	.long .LC149
	.long .LC150
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Railgun
	.long .LC96
	.long .LC151
	.long 1
	.long .LC152
	.long .LC153
	.long .LC154
	.long 0
	.long 1
	.long .LC12
	.long 9
	.long 0
	.long 0
	.long .LC155
	.long .LC64
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_BFG
	.long .LC96
	.long .LC156
	.long 1
	.long .LC157
	.long .LC158
	.long .LC159
	.long 0
	.long 50
	.long .LC9
	.long 9
	.long 0
	.long 0
	.long .LC160
	.long .LC161
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC126
	.long .LC162
	.long 0
	.long 0
	.long .LC163
	.long .LC6
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 1
	.long .LC72
	.long .LC164
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC126
	.long .LC165
	.long 0
	.long 0
	.long .LC166
	.long .LC5
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long .LC72
	.long .LC167
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC126
	.long .LC168
	.long 0
	.long 0
	.long .LC169
	.long .LC9
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 4
	.long .LC72
	.long .LC170
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC126
	.long .LC171
	.long 0
	.long 0
	.long .LC172
	.long .LC11
	.long 3
	.long 5
	.long 0
	.long 2
	.long 0
	.long 2
	.long .LC72
	.long .LC173
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC126
	.long .LC174
	.long 0
	.long 0
	.long .LC175
	.long .LC12
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 5
	.long .LC72
	.long .LC176
	.long Pickup_Powerup
	.long Use_Quad
	.long Drop_General
	.long 0
	.long .LC177
	.long .LC178
	.long 1
	.long 0
	.long .LC179
	.long .LC180
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long .LC181
	.long .LC182
	.long Pickup_Powerup
	.long Use_Invulnerability
	.long Drop_General
	.long 0
	.long .LC177
	.long .LC183
	.long 1
	.long 0
	.long .LC184
	.long .LC185
	.long 2
	.long 300
	.long 0
	.long 32
	.long 0
	.long 0
	.long .LC186
	.long .LC187
	.long Pickup_Powerup
	.long Use_Silencer
	.long Drop_General
	.long 0
	.long .LC177
	.long .LC188
	.long 1
	.long 0
	.long .LC189
	.long .LC190
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long .LC72
	.long .LC191
	.long Pickup_Powerup
	.long Use_Breather
	.long Drop_General
	.long 0
	.long .LC177
	.long .LC192
	.long 1
	.long 0
	.long .LC193
	.long .LC194
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long .LC195
	.long .LC196
	.long Pickup_Powerup
	.long Use_Envirosuit
	.long Drop_General
	.long 0
	.long .LC177
	.long .LC197
	.long 1
	.long 0
	.long .LC198
	.long .LC199
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long .LC195
	.long .LC200
	.long Pickup_AncientHead
	.long 0
	.long 0
	.long 0
	.long .LC177
	.long .LC201
	.long 1
	.long 0
	.long .LC202
	.long .LC203
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC72
	.long .LC204
	.long Pickup_Adrenaline
	.long 0
	.long 0
	.long 0
	.long .LC177
	.long .LC205
	.long 1
	.long 0
	.long .LC206
	.long .LC207
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC72
	.long .LC208
	.long Pickup_Bandolier
	.long 0
	.long 0
	.long 0
	.long .LC177
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
	.long .LC72
	.long .LC212
	.long Pickup_Pack
	.long 0
	.long 0
	.long 0
	.long .LC177
	.long .LC213
	.long 1
	.long 0
	.long .LC214
	.long .LC215
	.long 2
	.long 180
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC72
	.long .LC216
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC177
	.long .LC217
	.long 1
	.long 0
	.long .LC218
	.long .LC219
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC72
	.long .LC24
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC177
	.long .LC220
	.long 1
	.long 0
	.long .LC221
	.long .LC222
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC72
	.long .LC223
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC177
	.long .LC224
	.long 1
	.long 0
	.long .LC225
	.long .LC226
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC72
	.long .LC227
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC177
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
	.long .LC72
	.long .LC231
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC177
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
	.long .LC72
	.long .LC235
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC177
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
	.long .LC72
	.long .LC239
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC177
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
	.long .LC72
	.long .LC243
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC177
	.long .LC244
	.long 2
	.long 0
	.long .LC245
	.long .LC246
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC72
	.long .LC247
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC177
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
	.long .LC72
	.long 0
	.long Pickup_Health
	.long 0
	.long 0
	.long 0
	.long .LC177
	.long 0
	.long 0
	.long 0
	.long .LC251
	.long .LC252
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC72
	.long 0
	.space	68
	.section	".rodata"
	.align 2
.LC252:
	.string	"Health"
	.align 2
.LC251:
	.string	"i_health"
	.align 2
.LC250:
	.string	"Airstrike Marker"
	.align 2
.LC249:
	.string	"i_airstrike"
	.align 2
.LC248:
	.string	"models/items/keys/target/tris.md2"
	.align 2
.LC247:
	.string	"key_airstrike_target"
	.align 2
.LC246:
	.string	"Commander's Head"
	.align 2
.LC245:
	.string	"k_comhead"
	.align 2
.LC244:
	.string	"models/monsters/commandr/head/tris.md2"
	.align 2
.LC243:
	.string	"key_commander_head"
	.align 2
.LC242:
	.string	"Red Key"
	.align 2
.LC241:
	.string	"k_redkey"
	.align 2
.LC240:
	.string	"models/items/keys/red_key/tris.md2"
	.align 2
.LC239:
	.string	"key_red_key"
	.align 2
.LC238:
	.string	"Blue Key"
	.align 2
.LC237:
	.string	"k_bluekey"
	.align 2
.LC236:
	.string	"models/items/keys/key/tris.md2"
	.align 2
.LC235:
	.string	"key_blue_key"
	.align 2
.LC234:
	.string	"Security Pass"
	.align 2
.LC233:
	.string	"k_security"
	.align 2
.LC232:
	.string	"models/items/keys/pass/tris.md2"
	.align 2
.LC231:
	.string	"key_pass"
	.align 2
.LC230:
	.string	"Data Spinner"
	.align 2
.LC229:
	.string	"k_dataspin"
	.align 2
.LC228:
	.string	"models/items/keys/spinner/tris.md2"
	.align 2
.LC227:
	.string	"key_data_spinner"
	.align 2
.LC226:
	.string	"Pyramid Key"
	.align 2
.LC225:
	.string	"k_pyramid"
	.align 2
.LC224:
	.string	"models/items/keys/pyramid/tris.md2"
	.align 2
.LC223:
	.string	"key_pyramid"
	.align 2
.LC222:
	.string	"Power Cube"
	.align 2
.LC221:
	.string	"k_powercube"
	.align 2
.LC220:
	.string	"models/items/keys/power/tris.md2"
	.align 2
.LC219:
	.string	"Data CD"
	.align 2
.LC218:
	.string	"k_datacd"
	.align 2
.LC217:
	.string	"models/items/keys/data_cd/tris.md2"
	.align 2
.LC216:
	.string	"key_data_cd"
	.align 2
.LC215:
	.string	"Ammo Pack"
	.align 2
.LC214:
	.string	"i_pack"
	.align 2
.LC213:
	.string	"models/items/pack/tris.md2"
	.align 2
.LC212:
	.string	"item_pack"
	.align 2
.LC211:
	.string	"Bandolier"
	.align 2
.LC210:
	.string	"p_bandolier"
	.align 2
.LC209:
	.string	"models/items/band/tris.md2"
	.align 2
.LC208:
	.string	"item_bandolier"
	.align 2
.LC207:
	.string	"Adrenaline"
	.align 2
.LC206:
	.string	"p_adrenaline"
	.align 2
.LC205:
	.string	"models/items/adrenal/tris.md2"
	.align 2
.LC204:
	.string	"item_adrenaline"
	.align 2
.LC203:
	.string	"Ancient Head"
	.align 2
.LC202:
	.string	"i_fixme"
	.align 2
.LC201:
	.string	"models/items/c_head/tris.md2"
	.align 2
.LC200:
	.string	"item_ancient_head"
	.align 2
.LC199:
	.string	"Environment Suit"
	.align 2
.LC198:
	.string	"p_envirosuit"
	.align 2
.LC197:
	.string	"models/items/enviro/tris.md2"
	.align 2
.LC196:
	.string	"item_enviro"
	.align 2
.LC195:
	.string	"items/airout.wav"
	.align 2
.LC194:
	.string	"Rebreather"
	.align 2
.LC193:
	.string	"p_rebreather"
	.align 2
.LC192:
	.string	"models/items/breather/tris.md2"
	.align 2
.LC191:
	.string	"item_breather"
	.align 2
.LC190:
	.string	"Silencer"
	.align 2
.LC189:
	.string	"p_silencer"
	.align 2
.LC188:
	.string	"models/items/silencer/tris.md2"
	.align 2
.LC187:
	.string	"item_silencer"
	.align 2
.LC186:
	.string	"items/protect.wav items/protect2.wav items/protect4.wav"
	.align 2
.LC185:
	.string	"Invulnerability"
	.align 2
.LC184:
	.string	"p_invulnerability"
	.align 2
.LC183:
	.string	"models/items/invulner/tris.md2"
	.align 2
.LC182:
	.string	"item_invulnerability"
	.align 2
.LC181:
	.string	"items/damage.wav items/damage2.wav items/damage3.wav"
	.align 2
.LC180:
	.string	"Quad Damage"
	.align 2
.LC179:
	.string	"p_quad"
	.align 2
.LC178:
	.string	"models/items/quaddama/tris.md2"
	.align 2
.LC177:
	.string	"items/pkup.wav"
	.align 2
.LC176:
	.string	"item_quad"
	.align 2
.LC175:
	.string	"a_slugs"
	.align 2
.LC174:
	.string	"models/items/ammo/slugs/medium/tris.md2"
	.align 2
.LC173:
	.string	"ammo_slugs"
	.align 2
.LC172:
	.string	"a_rockets"
	.align 2
.LC171:
	.string	"models/items/ammo/rockets/medium/tris.md2"
	.align 2
.LC170:
	.string	"ammo_rockets"
	.align 2
.LC169:
	.string	"a_cells"
	.align 2
.LC168:
	.string	"models/items/ammo/cells/medium/tris.md2"
	.align 2
.LC167:
	.string	"ammo_cells"
	.align 2
.LC166:
	.string	"a_bullets"
	.align 2
.LC165:
	.string	"models/items/ammo/bullets/medium/tris.md2"
	.align 2
.LC164:
	.string	"ammo_bullets"
	.align 2
.LC163:
	.string	"a_shells"
	.align 2
.LC162:
	.string	"models/items/ammo/shells/medium/tris.md2"
	.align 2
.LC161:
	.string	"ammo_shells"
	.align 2
.LC160:
	.string	"sprites/s_bfg1.sp2 sprites/s_bfg2.sp2 sprites/s_bfg3.sp2 weapons/bfg__f1y.wav weapons/bfg__l1a.wav weapons/bfg__x1b.wav weapons/bfg_hum.wav"
	.align 2
.LC159:
	.string	"BFG10K"
	.align 2
.LC158:
	.string	"w_bfg"
	.align 2
.LC157:
	.string	"models/weapons/v_bfg/tris.md2"
	.align 2
.LC156:
	.string	"models/weapons/g_bfg/tris.md2"
	.align 2
.LC155:
	.string	"weapons/rg_hum.wav"
	.align 2
.LC154:
	.string	"Railgun"
	.align 2
.LC153:
	.string	"w_railgun"
	.align 2
.LC152:
	.string	"models/weapons/v_rail/tris.md2"
	.align 2
.LC151:
	.string	"models/weapons/g_rail/tris.md2"
	.align 2
.LC150:
	.string	"weapon_railgun"
	.align 2
.LC149:
	.string	"weapons/hyprbu1a.wav weapons/hyprbl1a.wav weapons/hyprbf1a.wav weapons/hyprbd1a.wav misc/lasfly.wav"
	.align 2
.LC148:
	.string	"HyperBlaster"
	.align 2
.LC147:
	.string	"w_hyperblaster"
	.align 2
.LC146:
	.string	"models/weapons/v_hyperb/tris.md2"
	.align 2
.LC145:
	.string	"models/weapons/g_hyperb/tris.md2"
	.align 2
.LC144:
	.string	"weapon_hyperblaster"
	.align 2
.LC143:
	.string	"models/objects/rocket/tris.md2 weapons/rockfly.wav weapons/rocklf1a.wav weapons/rocklr1b.wav models/objects/debris2/tris.md2"
	.align 2
.LC142:
	.string	"Rocket Launcher"
	.align 2
.LC141:
	.string	"w_rlauncher"
	.align 2
.LC140:
	.string	"models/weapons/v_rocket/tris.md2"
	.align 2
.LC139:
	.string	"models/weapons/g_rocket/tris.md2"
	.align 2
.LC138:
	.string	"weapon_rocketlauncher"
	.align 2
.LC137:
	.string	"models/objects/grenade/tris.md2 weapons/grenlf1a.wav weapons/grenlr1b.wav weapons/grenlb1b.wav"
	.align 2
.LC136:
	.string	"Grenade Launcher"
	.align 2
.LC135:
	.string	"w_glauncher"
	.align 2
.LC134:
	.string	"models/weapons/v_launch/tris.md2"
	.align 2
.LC133:
	.string	"models/weapons/g_launch/tris.md2"
	.align 2
.LC132:
	.string	"weapon_grenadelauncher"
	.align 2
.LC131:
	.string	"weapons/hgrent1a.wav weapons/hgrena1b.wav weapons/hgrenc1b.wav weapons/hgrenb1a.wav weapons/hgrenb2a.wav "
	.align 2
.LC130:
	.string	"grenades"
	.align 2
.LC129:
	.string	"a_grenades"
	.align 2
.LC128:
	.string	"models/weapons/v_handgr/tris.md2"
	.align 2
.LC127:
	.string	"models/items/ammo/grenades/medium/tris.md2"
	.align 2
.LC126:
	.string	"misc/am_pkup.wav"
	.align 2
.LC125:
	.string	"ammo_grenades"
	.align 2
.LC124:
	.string	"weapons/chngnu1a.wav weapons/chngnl1a.wav weapons/machgf3b.wav` weapons/chngnd1a.wav"
	.align 2
.LC123:
	.string	"Chaingun"
	.align 2
.LC122:
	.string	"w_chaingun"
	.align 2
.LC121:
	.string	"models/weapons/v_chain/tris.md2"
	.align 2
.LC120:
	.string	"models/weapons/g_chain/tris.md2"
	.align 2
.LC119:
	.string	"weapon_chaingun"
	.align 2
.LC118:
	.string	"weapons/machgf1b.wav weapons/machgf2b.wav weapons/machgf3b.wav weapons/machgf4b.wav weapons/machgf5b.wav"
	.align 2
.LC117:
	.string	"Machinegun"
	.align 2
.LC116:
	.string	"w_machinegun"
	.align 2
.LC115:
	.string	"models/weapons/v_machn/tris.md2"
	.align 2
.LC114:
	.string	"models/weapons/g_machn/tris.md2"
	.align 2
.LC113:
	.string	"weapon_machinegun"
	.align 2
.LC112:
	.string	"weapons/sshotf1b.wav"
	.align 2
.LC111:
	.string	"Super Shotgun"
	.align 2
.LC110:
	.string	"w_sshotgun"
	.align 2
.LC109:
	.string	"models/weapons/v_shotg2/tris.md2"
	.align 2
.LC108:
	.string	"models/weapons/g_shotg2/tris.md2"
	.align 2
.LC107:
	.string	"weapon_supershotgun"
	.align 2
.LC106:
	.string	"weapons/shotgf1b.wav weapons/shotgr1b.wav"
	.align 2
.LC105:
	.string	"Shotgun"
	.align 2
.LC104:
	.string	"w_shotgun"
	.align 2
.LC103:
	.string	"models/weapons/v_shotg/tris.md2"
	.align 2
.LC102:
	.string	"models/weapons/g_shotg/tris.md2"
	.align 2
.LC101:
	.string	"weapon_shotgun"
	.align 2
.LC100:
	.string	"weapons/blastf1a.wav misc/lasfly.wav"
	.align 2
.LC99:
	.string	"Blaster"
	.align 2
.LC98:
	.string	"w_blaster"
	.align 2
.LC97:
	.string	"models/weapons/v_blast/tris.md2"
	.align 2
.LC96:
	.string	"misc/w_pkup.wav"
	.align 2
.LC95:
	.string	"weapon_blaster"
	.align 2
.LC94:
	.string	"misc/power2.wav misc/power1.wav"
	.align 2
.LC93:
	.string	"Power Shield"
	.align 2
.LC92:
	.string	"i_powershield"
	.align 2
.LC91:
	.string	"models/items/armor/shield/tris.md2"
	.align 2
.LC90:
	.string	"item_power_shield"
	.align 2
.LC89:
	.string	"Power Screen"
	.align 2
.LC88:
	.string	"i_powerscreen"
	.align 2
.LC87:
	.string	"models/items/armor/screen/tris.md2"
	.align 2
.LC86:
	.string	"misc/ar3_pkup.wav"
	.align 2
.LC85:
	.string	"item_power_screen"
	.align 2
.LC84:
	.string	"Armor Shard"
	.align 2
.LC83:
	.string	"models/items/armor/shard/tris.md2"
	.align 2
.LC82:
	.string	"misc/ar2_pkup.wav"
	.align 2
.LC81:
	.string	"item_armor_shard"
	.align 2
.LC80:
	.string	"Jacket Armor"
	.align 2
.LC79:
	.string	"i_jacketarmor"
	.align 2
.LC78:
	.string	"models/items/armor/jacket/tris.md2"
	.align 2
.LC77:
	.string	"item_armor_jacket"
	.align 2
.LC76:
	.string	"Combat Armor"
	.align 2
.LC75:
	.string	"i_combatarmor"
	.align 2
.LC74:
	.string	"models/items/armor/combat/tris.md2"
	.align 2
.LC73:
	.string	"item_armor_combat"
	.align 2
.LC72:
	.string	""
	.align 2
.LC71:
	.string	"Body Armor"
	.align 2
.LC70:
	.string	"i_bodyarmor"
	.align 2
.LC69:
	.string	"models/items/armor/body/tris.md2"
	.align 2
.LC68:
	.string	"misc/ar1_pkup.wav"
	.align 2
.LC67:
	.string	"item_armor_body"
	.size	 itemlist,3096
	.align 2
.LC253:
	.string	"models/items/healing/medium/tris.md2"
	.align 2
.LC254:
	.string	"models/items/healing/stimpack/tris.md2"
	.align 2
.LC255:
	.string	"models/items/healing/large/tris.md2"
	.align 2
.LC256:
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
	bc 4,0,.L427
	lis 11,itemlist@ha
	lis 9,gi@ha
	la 11,itemlist@l(11)
	la 28,gi@l(9)
	mr 29,10
	addi 30,11,40
.L429:
	lwz 9,24(28)
	addi 3,31,1056
	lwz 4,0(30)
	addi 31,31,1
	mtlr 9
	addi 30,30,72
	blrl
	lwz 0,1556(29)
	cmpw 0,31,0
	bc 12,0,.L429
.L427:
	lis 9,game@ha
	lis 11,jacket_armor_index@ha
	la 10,game@l(9)
	li 30,0
	lwz 0,1556(10)
	la 27,jacket_armor_index@l(11)
	lis 9,.LC80@ha
	lis 11,itemlist@ha
	la 28,.LC80@l(9)
	cmpw 0,30,0
	la 31,itemlist@l(11)
	bc 4,0,.L438
	mr 29,10
.L433:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L435
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L435
	mr 11,31
	b .L437
.L435:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L433
.L438:
	li 11,0
.L437:
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
	lis 10,.LC76@ha
	la 26,combat_armor_index@l(9)
	srawi 11,11,3
	la 28,.LC76@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L446
	mr 29,7
.L441:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L443
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L443
	mr 11,31
	b .L445
.L443:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L441
.L446:
	li 11,0
.L445:
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
	lis 10,.LC71@ha
	la 27,body_armor_index@l(9)
	srawi 11,11,3
	la 28,.LC71@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L454
	mr 29,7
.L449:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L451
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L451
	mr 11,31
	b .L453
.L451:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L449
.L454:
	li 11,0
.L453:
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
	lis 10,.LC89@ha
	la 26,power_screen_index@l(9)
	srawi 11,11,3
	la 28,.LC89@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L462
	mr 29,7
.L457:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L459
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L459
	mr 11,31
	b .L461
.L459:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L457
.L462:
	li 11,0
.L461:
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
	lis 10,.LC93@ha
	la 27,power_shield_index@l(9)
	srawi 11,11,3
	la 28,.LC93@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L470
	mr 29,7
.L465:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L467
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L467
	mr 8,31
	b .L469
.L467:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L465
.L470:
	li 8,0
.L469:
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
	li 0,42
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
	b .L471
.L20:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L21
.L19:
	li 3,0
.L471:
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
	b .L472
.L12:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L13
.L11:
	li 3,0
.L472:
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
	bc 4,2,.L245
	li 3,0
	blr
.L245:
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
	bc 4,2,.L274
.L475:
	li 3,0
	blr
.L274:
	lwz 0,264(3)
	andi. 9,0,4096
	bc 12,2,.L475
	lis 9,power_shield_index@ha
	addi 11,11,740
	lwz 0,power_shield_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L276
	lis 9,power_screen_index@ha
	lwz 0,power_screen_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	srawi 3,9,31
	subf 3,9,3
	srwi 3,3,31
	blr
.L276:
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
	mulli 0,3,72
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
.Lfe27:
	.size	 Drop_General,.Lfe27-Drop_General
	.section	".rodata"
	.align 2
.LC257:
	.long 0x0
	.align 3
.LC258:
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
	lis 9,.LC257@ha
	lis 11,deathmatch@ha
	la 9,.LC257@l(9)
	mr 12,3
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L52
	lwz 9,484(4)
	addi 9,9,1
	stw 9,484(4)
.L52:
	lwz 0,480(4)
	lwz 9,484(4)
	cmpw 0,0,9
	bc 4,0,.L53
	stw 9,480(4)
.L53:
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L54
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L54
	lis 9,.LC258@ha
	lwz 11,664(12)
	la 9,.LC258@l(9)
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
.L54:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 Pickup_Adrenaline,.Lfe28-Pickup_Adrenaline
	.section	".rodata"
	.align 2
.LC259:
	.long 0x0
	.align 3
.LC260:
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
	bc 4,2,.L57
	lis 9,.LC259@ha
	lis 11,deathmatch@ha
	la 9,.LC259@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L57
	lis 9,.LC260@ha
	lwz 11,664(12)
	la 9,.LC260@l(9)
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
.L57:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 Pickup_AncientHead,.Lfe29-Pickup_AncientHead
	.section	".rodata"
	.align 3
.LC261:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC262:
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
	lis 9,.LC261@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC261@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3696(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L162
	lis 9,.LC262@ha
	la 9,.LC262@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L477
.L162:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L477:
	stfs 0,3696(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe30:
	.size	 Use_Breather,.Lfe30-Use_Breather
	.section	".rodata"
	.align 3
.LC263:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC264:
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
	lis 9,.LC263@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC263@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3700(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L165
	lis 9,.LC264@ha
	la 9,.LC264@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L478
.L165:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L478:
	stfs 0,3700(10)
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
	lwz 9,3712(11)
	addi 9,9,30
	stw 9,3712(11)
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
	bc 12,0,.L220
	stw 10,532(11)
	b .L221
.L220:
	stw 0,532(11)
.L221:
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
.Lfe33:
	.size	 Drop_Ammo,.Lfe33-Drop_Ammo
	.section	".rodata"
	.align 2
.LC265:
	.long 0x3f800000
	.align 2
.LC266:
	.long 0x0
	.align 2
.LC267:
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
	bc 4,1,.L223
	lis 10,.LC265@ha
	lis 9,level+4@ha
	la 10,.LC265@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(7)
	lwz 9,480(11)
	addi 9,9,-1
	stw 9,480(11)
	b .L222
.L223:
	lwz 0,284(7)
	andis. 6,0,0x1
	bc 4,2,.L224
	lis 9,.LC266@ha
	lis 11,deathmatch@ha
	la 9,.LC266@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L224
	lwz 9,264(7)
	lis 11,.LC267@ha
	lis 10,level+4@ha
	lwz 0,184(7)
	la 11,.LC267@l(11)
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
	b .L222
.L224:
	mr 3,7
	bl G_FreeEdict
.L222:
	lwz 0,20(1)
	mtlr 0
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
	bc 12,2,.L297
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
	bc 4,2,.L297
	bl Use_PowerArmor
.L297:
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
	bc 12,2,.L311
	bl Touch_Item
.L311:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe36:
	.size	 drop_temp_touch,.Lfe36-drop_temp_touch
	.section	".rodata"
	.align 2
.LC268:
	.long 0x0
	.align 2
.LC269:
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
	lis 9,.LC268@ha
	lfs 0,20(10)
	la 9,.LC268@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bclr 12,2
	lis 9,.LC269@ha
	lis 11,level+4@ha
	la 9,.LC269@l(9)
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
	bc 12,2,.L320
	li 0,2
	stw 11,444(3)
	stw 0,248(3)
	b .L321
.L320:
	lis 9,Touch_Item@ha
	li 0,1
	la 9,Touch_Item@l(9)
	stw 0,248(3)
	stw 9,444(3)
.L321:
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
.LC270:
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
	lis 11,.LC270@ha
	lis 9,deathmatch@ha
	la 11,.LC270@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L385
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L385
	bl G_FreeEdict
	b .L384
.L479:
	mr 4,31
	b .L392
.L385:
	lis 9,.LC253@ha
	li 0,10
	la 9,.LC253@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC252@ha
	lis 11,itemlist@ha
	la 27,.LC252@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L393
	mr 28,10
.L388:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L390
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L479
.L390:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L388
.L393:
	li 4,0
.L392:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC30@ha
	lwz 0,gi+36@l(9)
	la 3,.LC30@l(3)
	mtlr 0
	blrl
.L384:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe39:
	.size	 SP_item_health,.Lfe39-SP_item_health
	.section	".rodata"
	.align 2
.LC271:
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
	lis 11,.LC271@ha
	lis 9,deathmatch@ha
	la 11,.LC271@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L395
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L395
	bl G_FreeEdict
	b .L394
.L480:
	mr 4,31
	b .L402
.L395:
	lis 9,.LC254@ha
	li 0,2
	la 9,.LC254@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC252@ha
	lis 11,itemlist@ha
	la 27,.LC252@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L403
	mr 28,10
.L398:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L400
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L480
.L400:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L398
.L403:
	li 4,0
.L402:
	mr 3,29
	bl SpawnItem
	li 0,1
	lis 9,gi+36@ha
	stw 0,660(29)
	lis 3,.LC29@ha
	lwz 0,gi+36@l(9)
	la 3,.LC29@l(3)
	mtlr 0
	blrl
.L394:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe40:
	.size	 SP_item_health_small,.Lfe40-SP_item_health_small
	.section	".rodata"
	.align 2
.LC272:
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
	lis 11,.LC272@ha
	lis 9,deathmatch@ha
	la 11,.LC272@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L405
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L405
	bl G_FreeEdict
	b .L404
.L481:
	mr 4,31
	b .L412
.L405:
	lis 9,.LC255@ha
	li 0,25
	la 9,.LC255@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC252@ha
	lis 11,itemlist@ha
	la 27,.LC252@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L413
	mr 28,10
.L408:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L410
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L481
.L410:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L408
.L413:
	li 4,0
.L412:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC31@ha
	lwz 0,gi+36@l(9)
	la 3,.LC31@l(3)
	mtlr 0
	blrl
.L404:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe41:
	.size	 SP_item_health_large,.Lfe41-SP_item_health_large
	.section	".rodata"
	.align 2
.LC273:
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
	lis 11,.LC273@ha
	lis 9,deathmatch@ha
	la 11,.LC273@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L415
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L415
	bl G_FreeEdict
	b .L414
.L482:
	mr 4,31
	b .L422
.L415:
	lis 9,.LC256@ha
	li 0,100
	la 9,.LC256@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC252@ha
	lis 11,itemlist@ha
	la 27,.LC252@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L423
	mr 28,10
.L418:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L420
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L482
.L420:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L418
.L423:
	li 4,0
.L422:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC32@ha
	lwz 0,gi+36@l(9)
	la 3,.LC32@l(3)
	mtlr 0
	blrl
	li 0,3
	stw 0,660(29)
.L414:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe42:
	.size	 SP_item_health_mega,.Lfe42-SP_item_health_mega
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
