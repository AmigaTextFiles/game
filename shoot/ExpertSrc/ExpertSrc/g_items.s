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
	.globl balanced_jacketarmor_info
	.align 2
	.type	 balanced_jacketarmor_info,@object
	.size	 balanced_jacketarmor_info,20
balanced_jacketarmor_info:
	.long 160
	.long 160
	.long 0x3e99999a
	.long 0x3e99999a
	.long 1
	.globl balanced_combatarmor_info
	.align 2
	.type	 balanced_combatarmor_info,@object
	.size	 balanced_combatarmor_info,20
balanced_combatarmor_info:
	.long 96
	.long 96
	.long 0x3f000000
	.long 0x3f000000
	.long 2
	.globl balanced_bodyarmor_info
	.align 2
	.type	 balanced_bodyarmor_info,@object
	.size	 balanced_bodyarmor_info,20
balanced_bodyarmor_info:
	.long 80
	.long 80
	.long 0x3f19999a
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
	addi 11,11,744
	lwzx 11,11,9
	fcmpu 6,13,0
	cmpwi 7,11,1
	mfcr 9
	rlwinm 0,9,30,1
	rlwinm 9,9,27,1
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
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	lwz 10,84(30)
	subf 0,9,0
	lis 8,deathmatch@ha
	mullw 0,0,11
	addi 10,10,744
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
	lwz 0,1768(9)
	cmpwi 0,0,249
	bc 12,1,.L64
	li 0,250
	stw 0,1768(9)
.L64:
	lwz 9,84(29)
	lwz 0,1772(9)
	cmpwi 0,0,149
	bc 12,1,.L65
	li 0,150
	stw 0,1772(9)
.L65:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,249
	bc 12,1,.L66
	li 0,250
	stw 0,1784(9)
.L66:
	lwz 9,84(29)
	lwz 0,1788(9)
	cmpwi 0,0,74
	bc 12,1,.L67
	li 0,75
	stw 0,1788(9)
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
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L70
.L75:
	li 8,0
.L74:
	cmpwi 0,8,0
	bc 12,2,.L76
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1768(9)
	addi 9,9,744
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
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L80
.L85:
	li 8,0
.L84:
	cmpwi 0,8,0
	bc 12,2,.L86
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	addi 4,9,744
	lwz 11,1772(9)
	lwzx 0,4,8
	cmpw 0,0,11
	bc 4,1,.L86
	stwx 11,4,8
.L86:
	lwz 0,284(28)
	andis. 4,0,0x1
	bc 4,2,.L88
	lis 9,.LC7@ha
	lis 11,deathmatch@ha
	la 9,.LC7@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L88
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
.L88:
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
	lwz 0,1768(9)
	cmpwi 0,0,299
	bc 12,1,.L91
	li 0,300
	stw 0,1768(9)
.L91:
	lwz 9,84(29)
	lwz 0,1772(9)
	cmpwi 0,0,199
	bc 12,1,.L92
	li 0,200
	stw 0,1772(9)
.L92:
	lwz 9,84(29)
	lwz 0,1776(9)
	cmpwi 0,0,99
	bc 12,1,.L93
	li 0,100
	stw 0,1776(9)
.L93:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,99
	bc 12,1,.L94
	li 0,100
	stw 0,1780(9)
.L94:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,299
	bc 12,1,.L95
	li 0,300
	stw 0,1784(9)
.L95:
	lwz 9,84(29)
	lwz 0,1788(9)
	cmpwi 0,0,99
	bc 12,1,.L96
	li 0,100
	stw 0,1788(9)
.L96:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC5@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC5@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L104
	mr 28,10
.L99:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L101
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L101
	mr 8,31
	b .L103
.L101:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L99
.L104:
	li 8,0
.L103:
	cmpwi 0,8,0
	bc 12,2,.L105
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1768(9)
	addi 9,9,744
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L105
	stwx 11,9,8
.L105:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC6@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC6@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L114
	mr 28,10
.L109:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L111
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L111
	mr 8,31
	b .L113
.L111:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L109
.L114:
	li 8,0
.L113:
	cmpwi 0,8,0
	bc 12,2,.L115
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1772(9)
	addi 9,9,744
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L115
	stwx 11,9,8
.L115:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC9@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC9@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L124
	mr 28,10
.L119:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L121
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L121
	mr 8,31
	b .L123
.L121:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L119
.L124:
	li 8,0
.L123:
	cmpwi 0,8,0
	bc 12,2,.L125
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1784(9)
	addi 9,9,744
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L125
	stwx 11,9,8
.L125:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC10@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC10@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L134
	mr 28,10
.L129:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L131
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L131
	mr 8,31
	b .L133
.L131:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L129
.L134:
	li 8,0
.L133:
	cmpwi 0,8,0
	bc 12,2,.L135
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1780(9)
	addi 9,9,744
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L135
	stwx 11,9,8
.L135:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC11@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC11@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L144
	mr 28,10
.L139:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L141
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L141
	mr 8,31
	b .L143
.L141:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L139
.L144:
	li 8,0
.L143:
	cmpwi 0,8,0
	bc 12,2,.L145
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1776(9)
	addi 9,9,744
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L145
	stwx 11,9,8
.L145:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC12@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC12@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L154
	mr 28,10
.L149:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L151
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L151
	mr 8,31
	b .L153
.L151:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L149
.L154:
	li 8,0
.L153:
	cmpwi 0,8,0
	bc 12,2,.L155
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	addi 4,9,744
	lwz 11,1788(9)
	lwzx 0,4,8
	cmpw 0,0,11
	bc 4,1,.L155
	stwx 11,4,8
.L155:
	lwz 0,284(27)
	andis. 4,0,0x1
	bc 4,2,.L157
	lis 9,.LC13@ha
	lis 11,deathmatch@ha
	la 9,.LC13@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L157
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
.L157:
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
	.string	"You got the Vampire Artifact!\n\nYou receive as life\npoints half the health\ndamage you do!\n"
	.align 2
.LC16:
	.string	"items/damage.wav"
	.align 3
.LC17:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC18:
	.long 0x3f800000
	.align 2
.LC19:
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
	addi 11,11,744
	slwi 4,4,2
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 11,quad_drop_timeout_hack@ha
	lwz 9,quad_drop_timeout_hack@l(11)
	cmpwi 0,9,0
	bc 12,2,.L160
	li 0,0
	mr 10,9
	stw 0,quad_drop_timeout_hack@l(11)
	b .L161
.L160:
	li 10,300
.L161:
	lis 11,level@ha
	lwz 8,84(31)
	lwz 11,level@l(11)
	lis 7,0x4330
	lis 6,.LC17@ha
	la 6,.LC17@l(6)
	lfs 12,3948(8)
	xoris 0,11,0x8000
	lfd 13,0(6)
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L162
	xoris 0,10,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fadds 0,12,0
	b .L165
.L162:
	add 0,11,10
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
.L165:
	stfs 0,3948(8)
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 9,11,8
	bc 12,2,.L164
	lis 9,gi@ha
	lis 4,.LC15@ha
	la 9,gi@l(9)
	la 4,.LC15@l(4)
	lwz 0,12(9)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
.L164:
	lis 29,gi@ha
	lis 3,.LC16@ha
	la 29,gi@l(29)
	la 3,.LC16@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 6,.LC18@ha
	lwz 0,16(29)
	lis 9,.LC18@ha
	la 6,.LC18@l(6)
	mr 5,3
	lfs 1,0(6)
	la 9,.LC18@l(9)
	li 4,3
	mtlr 0
	lis 6,.LC19@ha
	mr 3,31
	lfs 2,0(9)
	la 6,.LC19@l(6)
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
.LC20:
	.string	"You got the Mutant Jump!\n\nNow you can jump like a Mutant!\nYou are also invulnerable to slime,\nlava, and falling!"
	.align 2
.LC21:
	.string	"items/protect.wav"
	.align 3
.LC22:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC23:
	.long 0x43960000
	.align 2
.LC24:
	.long 0x3f800000
	.align 2
.LC25:
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
	addi 11,11,744
	slwi 4,4,2
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC22@ha
	lis 11,level@ha
	lwz 10,84(31)
	la 9,.LC22@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3952(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L173
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L176
.L173:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L176:
	stfs 0,3952(10)
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8
	bc 12,2,.L175
	lis 9,gi@ha
	lis 4,.LC20@ha
	la 9,gi@l(9)
	la 4,.LC20@l(4)
	lwz 0,12(9)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,264(31)
	ori 0,0,192
	stw 0,264(31)
.L175:
	lis 29,gi@ha
	lis 3,.LC21@ha
	la 29,gi@l(29)
	la 3,.LC21@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC24@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC24@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 2,0(9)
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
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
.LC26:
	.string	"key_power_cube"
	.align 2
.LC27:
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
	lis 11,.LC27@ha
	lis 9,coop@ha
	la 11,.LC27@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 30,4
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L179
	lwz 3,280(31)
	lis 4,.LC26@ha
	la 4,.LC26@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L180
	lwz 10,84(30)
	lbz 9,286(31)
	lwz 0,1800(10)
	and. 11,0,9
	bc 4,2,.L185
	lwz 0,648(31)
	lis 9,itemlist@ha
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	subf 0,9,0
	addi 10,10,744
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
	b .L182
.L180:
	lwz 0,648(31)
	lis 9,itemlist@ha
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	lwz 10,84(30)
	subf 0,9,0
	mullw 0,0,11
	addi 4,10,744
	srawi 0,0,3
	slwi 3,0,2
	lwzx 9,4,3
	cmpwi 0,9,0
	bc 12,2,.L183
.L185:
	li 3,0
	b .L184
.L183:
	li 0,1
	stwx 0,4,3
.L182:
	li 3,1
	b .L184
.L179:
	lwz 0,648(31)
	lis 9,itemlist@ha
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	lwz 10,84(30)
	subf 0,9,0
	li 3,1
	mullw 0,0,11
	addi 10,10,744
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
.L184:
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
	bc 4,2,.L187
.L203:
	li 3,0
	blr
.L187:
	lwz 0,64(4)
	cmpwi 0,0,0
	bc 4,2,.L188
	lwz 10,1768(9)
	b .L189
.L188:
	cmpwi 0,0,1
	bc 4,2,.L190
	lwz 10,1772(9)
	b .L189
.L190:
	cmpwi 0,0,2
	bc 4,2,.L192
	lwz 10,1776(9)
	b .L189
.L192:
	cmpwi 0,0,3
	bc 4,2,.L194
	lwz 10,1780(9)
	b .L189
.L194:
	cmpwi 0,0,4
	bc 4,2,.L196
	lwz 10,1784(9)
	b .L189
.L196:
	cmpwi 0,0,5
	bc 4,2,.L203
	lwz 10,1788(9)
.L189:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(3)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,4
	addi 11,11,744
	mullw 9,9,0
	srawi 9,9,3
	slwi 4,9,2
	lwzx 0,11,4
	cmpw 0,0,10
	bc 12,2,.L203
	add 0,0,5
	stwx 0,11,4
	lwz 9,84(3)
	addi 3,9,744
	lwzx 0,3,4
	cmpw 0,0,10
	bc 4,1,.L201
	stwx 10,3,4
.L201:
	li 3,1
	blr
.Lfe7:
	.size	 Add_Ammo,.Lfe7-Add_Ammo
	.section	".rodata"
	.align 2
.LC28:
	.string	"ammo_rockets"
	.align 2
.LC29:
	.string	"ammo_slugs"
	.align 2
.LC30:
	.string	"blaster"
	.align 2
.LC31:
	.long 0x0
	.align 2
.LC32:
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
	mr 26,4
	lwz 9,648(29)
	lwz 0,56(9)
	andi. 30,0,1
	bc 12,2,.L205
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8192
	bc 12,2,.L205
	li 31,1000
	b .L206
.L205:
	lwz 5,532(29)
	cmpwi 0,5,0
	bc 12,2,.L207
	mr 31,5
	b .L206
.L207:
	lwz 9,648(29)
	lwz 31,48(9)
.L206:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 9,11,1
	bc 12,2,.L209
	lwz 0,284(29)
	andis. 11,0,0x3
	bc 4,2,.L209
	lwz 9,648(29)
	lis 4,.LC28@ha
	la 4,.LC28@l(4)
	lwz 3,0(9)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L210
	li 31,10
	b .L209
.L210:
	lwz 9,648(29)
	lis 4,.LC29@ha
	la 4,.LC29@l(4)
	lwz 3,0(9)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	nor 9,0,0
	and 0,31,0
	andi. 9,9,25
	or 31,0,9
.L209:
	lwz 4,648(29)
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 28,itemlist@l(11)
	ori 9,9,36409
	subf 0,28,4
	lwz 11,84(26)
	mr 5,31
	mullw 0,0,9
	mr 3,26
	addi 11,11,744
	srawi 0,0,3
	slwi 0,0,2
	lwzx 31,11,0
	bl Add_Ammo
	cmpwi 0,3,0
	bc 4,2,.L213
	li 3,0
	b .L227
.L228:
	mr 9,31
	b .L223
.L213:
	subfic 9,31,0
	adde 0,9,31
	and. 11,30,0
	bc 12,2,.L214
	lwz 25,84(26)
	lwz 9,648(29)
	lwz 0,1792(25)
	cmpw 0,0,9
	bc 12,2,.L214
	lis 9,.LC31@ha
	lis 11,deathmatch@ha
	la 9,.LC31@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L216
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC30@ha
	lwz 0,1556(9)
	la 27,.LC30@l(11)
	mr 31,28
	cmpw 0,30,0
	bc 4,0,.L224
	mr 28,9
.L219:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L221
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L228
.L221:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L219
.L224:
	li 9,0
.L223:
	lwz 0,1792(25)
	cmpw 0,0,9
	bc 4,2,.L214
.L216:
	lwz 9,84(26)
	lwz 0,648(29)
	stw 0,3772(9)
.L214:
	lwz 0,284(29)
	andis. 7,0,0x3
	bc 4,2,.L225
	lis 9,.LC31@ha
	lis 11,deathmatch@ha
	la 9,.LC31@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L225
	lwz 9,264(29)
	lis 11,.LC32@ha
	lis 10,level+4@ha
	lwz 0,184(29)
	la 11,.LC32@l(11)
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
.L225:
	li 3,1
.L227:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 Pickup_Ammo,.Lfe8-Pickup_Ammo
	.section	".rodata"
	.align 2
.LC33:
	.string	"Can't drop ammo in ammo regen mode\n"
	.align 2
.LC34:
	.string	"items/m_health.wav"
	.align 2
.LC35:
	.string	"items/s_health.wav"
	.align 2
.LC36:
	.string	"items/n_health.wav"
	.align 2
.LC37:
	.string	"items/l_health.wav"
	.align 2
.LC38:
	.long 0x40a00000
	.align 2
.LC39:
	.long 0x0
	.align 2
.LC40:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Pickup_Health
	.type	 Pickup_Health,@function
Pickup_Health:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 11,sv_expflags@ha
	lwz 10,sv_expflags@l(11)
	mr 31,3
	mr 30,4
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,2
	bc 12,2,.L239
	lwz 0,532(31)
	cmpwi 0,0,100
	bc 4,2,.L239
	mr 3,30
	bl canPickupArkOfLife
	cmpwi 0,3,0
	bc 4,2,.L241
.L262:
	li 3,0
	b .L260
.L239:
	lwz 0,644(31)
	andi. 8,0,1
	bc 4,2,.L241
	lwz 9,480(30)
	lwz 0,484(30)
	cmpw 0,9,0
	bc 4,0,.L262
.L241:
	lis 10,sv_expflags@ha
	lwz 8,532(31)
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 9,11,2
	bc 12,2,.L244
	cmpwi 0,8,100
	bc 4,2,.L244
	mr 3,31
	mr 4,30
	bl pickupArkOfLife
	lwz 11,648(31)
	lis 9,.LC34@ha
	li 3,1
	la 9,.LC34@l(9)
	stw 9,20(11)
	b .L260
.L244:
	lwz 0,480(30)
	add 0,0,8
	stw 0,480(30)
	lwz 0,532(31)
	cmpwi 0,0,2
	bc 12,2,.L246
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 8,11,2
	bc 12,2,.L245
	cmpwi 0,0,10
	bc 4,2,.L261
.L246:
	lwz 11,648(31)
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	b .L263
.L245:
	cmpwi 0,0,10
	bc 12,2,.L249
.L261:
	lis 10,sv_expflags@ha
	lwz 8,532(31)
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 9,11,2
	bc 12,2,.L248
	cmpwi 0,8,15
	bc 4,2,.L248
.L249:
	lwz 11,648(31)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	b .L263
.L248:
	cmpwi 0,8,25
	bc 12,2,.L252
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,2
	bc 12,2,.L251
	cmpwi 0,8,20
	bc 4,2,.L251
.L252:
	lwz 11,648(31)
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	b .L263
.L251:
	lwz 11,648(31)
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
.L263:
	stw 9,20(11)
	lwz 0,644(31)
	andi. 8,0,1
	bc 4,2,.L254
	lwz 0,480(30)
	lwz 9,484(30)
	cmpw 0,0,9
	bc 4,1,.L254
	stw 9,480(30)
.L254:
	lwz 0,644(31)
	andi. 9,0,2
	bc 12,2,.L256
	lis 9,MegaHealth_think@ha
	lis 8,.LC38@ha
	lwz 11,264(31)
	la 9,MegaHealth_think@l(9)
	lis 10,level+4@ha
	lwz 0,184(31)
	stw 9,436(31)
	la 8,.LC38@l(8)
	oris 11,11,0x8000
	lfs 0,level+4@l(10)
	li 9,0
	ori 0,0,1
	lfs 13,0(8)
	stw 9,248(31)
	stw 30,256(31)
	fadds 0,0,13
	stw 11,264(31)
	stw 0,184(31)
	stfs 0,428(31)
	b .L257
.L256:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L257
	lis 9,.LC39@ha
	lis 11,deathmatch@ha
	la 9,.LC39@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L257
	lwz 9,264(31)
	lis 11,.LC40@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC40@l(11)
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
.L257:
	li 3,1
.L260:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 Pickup_Health,.Lfe9-Pickup_Health
	.section	".rodata"
	.align 3
.LC41:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC42:
	.long 0x0
	.align 2
.LC43:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl Pickup_Armor
	.type	 Pickup_Armor,@function
Pickup_Armor:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,4
	mr 28,3
	lwz 11,84(30)
	lwz 9,648(28)
	cmpwi 0,11,0
	lwz 29,60(9)
	bc 4,2,.L270
	li 7,0
	b .L271
.L270:
	lis 9,jacket_armor_index@ha
	addi 8,11,744
	lwz 3,jacket_armor_index@l(9)
	slwi 0,3,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L294
	lis 9,combat_armor_index@ha
	lwz 3,combat_armor_index@l(9)
	slwi 0,3,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 4,1,.L273
.L294:
	mr 7,3
	b .L271
.L273:
	lis 9,body_armor_index@ha
	lwz 10,body_armor_index@l(9)
	slwi 11,10,2
	lwzx 9,8,11
	srawi 0,9,31
	subf 0,9,0
	srawi 0,0,31
	and 7,10,0
.L271:
	lwz 8,648(28)
	lwz 0,64(8)
	cmpwi 0,0,4
	bc 4,2,.L275
	cmpwi 0,7,0
	bc 4,2,.L276
	lis 29,jacket_armor_index@ha
	lwz 3,jacket_armor_index@l(29)
	bl ShardPoints
	lwz 9,84(30)
	lwz 0,jacket_armor_index@l(29)
	addi 9,9,744
	slwi 0,0,2
	stwx 3,9,0
	b .L282
.L276:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 12,2,.L278
	lis 9,itemlist@ha
	mulli 0,7,72
	lwz 11,84(30)
	slwi 29,7,2
	la 9,itemlist@l(9)
	li 3,0
	addi 9,9,60
	addi 11,11,744
	lwzx 31,9,0
	lwzx 10,11,29
	lwz 0,4(31)
	cmpw 0,10,0
	bc 12,2,.L293
	mr 3,7
	bl ShardPoints
	lwz 9,84(30)
	addi 9,9,744
	lwzx 0,9,29
	add 0,0,3
	stwx 0,9,29
	lwz 9,84(30)
	lwz 11,4(31)
	addi 4,9,744
	lwzx 0,4,29
	cmpw 0,0,11
	bc 4,1,.L282
	stwx 11,4,29
	b .L282
.L278:
	lwz 9,84(30)
	slwi 0,7,2
	addi 9,9,744
	lwzx 11,9,0
	addi 11,11,2
	stwx 11,9,0
	b .L282
.L275:
	cmpwi 0,7,0
	bc 4,2,.L283
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,0(29)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	stwx 10,11,9
	b .L282
.L283:
	lis 10,sv_expflags@ha
	mulli 0,7,72
	lwz 6,84(30)
	lwz 8,sv_expflags@l(10)
	lis 9,itemlist@ha
	slwi 3,7,2
	la 9,itemlist@l(9)
	lfs 0,20(8)
	addi 9,9,60
	lwzx 31,9,0
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 12,2,.L285
	addi 9,6,744
	lwz 11,4(31)
	lwzx 0,9,3
	cmpw 0,0,11
	bc 12,2,.L295
.L285:
	lfs 13,8(29)
	lfs 0,8(31)
	fcmpu 0,13,0
	bc 4,1,.L286
	fdivs 11,0,13
	addi 6,6,744
	lwz 8,4(29)
	lwzx 0,6,3
	lis 7,0x4330
	lis 11,.LC41@ha
	la 11,.LC41@l(11)
	lwz 4,0(29)
	li 10,0
	xoris 0,0,0x8000
	lfd 13,0(11)
	mr 5,9
	stw 0,12(1)
	lis 11,itemlist@ha
	stw 7,8(1)
	la 11,itemlist@l(11)
	lis 0,0x38e3
	lfd 0,8(1)
	ori 0,0,36409
	stwx 10,6,3
	lwz 9,648(28)
	lwz 10,84(30)
	subf 9,11,9
	mullw 9,9,0
	addi 10,10,744
	srawi 9,9,3
	slwi 9,9,2
	fsub 0,0,13
	frsp 0,0
	fmuls 0,11,0
	fmr 13,0
	fctiwz 12,13
	stfd 12,8(1)
	lwz 0,12(1)
	add 4,4,0
	cmpw 7,4,8
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 8,8,0
	and 0,4,0
	or 4,0,8
	stwx 4,10,9
	b .L282
.L286:
	fdivs 11,13,0
	lwz 0,0(29)
	lis 10,0x4330
	lis 11,.LC41@ha
	mr 8,9
	xoris 0,0,0x8000
	la 11,.LC41@l(11)
	stw 0,12(1)
	addi 6,6,744
	stw 10,8(1)
	lfd 13,0(11)
	lfd 0,8(1)
	lwzx 10,6,3
	lwz 11,4(31)
	fsub 0,0,13
	frsp 0,0
	fmuls 0,11,0
	fmr 13,0
	fctiwz 12,13
	stfd 12,8(1)
	lwz 0,12(1)
	add 4,10,0
	cmpw 7,4,11
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 11,11,0
	and 0,4,0
	or 0,0,11
	cmpw 0,10,0
	bc 12,0,.L290
.L295:
	li 3,0
	b .L293
.L290:
	stwx 0,6,3
.L282:
	lwz 0,284(28)
	andis. 7,0,0x1
	bc 4,2,.L291
	lis 9,.LC42@ha
	lis 11,deathmatch@ha
	la 9,.LC42@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L291
	lwz 9,264(28)
	lis 11,.LC43@ha
	lis 10,level+4@ha
	lwz 0,184(28)
	la 11,.LC43@l(11)
	lis 8,gi+72@ha
	oris 9,9,0x8000
	stw 7,248(28)
	mr 3,28
	ori 0,0,1
	stw 9,264(28)
	stw 0,184(28)
	lfs 0,level+4@l(10)
	lfs 13,0(11)
	lis 11,DoRespawn@ha
	la 11,DoRespawn@l(11)
	fadds 0,0,13
	stw 11,436(28)
	stfs 0,428(28)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
.L291:
	li 3,1
.L293:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 Pickup_Armor,.Lfe10-Pickup_Armor
	.section	".rodata"
	.align 2
.LC44:
	.string	"misc/power1.wav"
	.align 2
.LC45:
	.string	"Inertial Screen\n\nShots from the front\ndo less damage!\n"
	.align 2
.LC46:
	.string	"misc/power2.wav"
	.align 2
.LC47:
	.string	"cells"
	.align 2
.LC48:
	.string	"No cells for power armor.\n"
	.align 3
.LC49:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC50:
	.long 0x43960000
	.align 2
.LC51:
	.long 0x3f800000
	.align 2
.LC52:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_PowerArmor
	.type	 Use_PowerArmor,@function
Use_PowerArmor:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 11,sv_expflags@ha
	lwz 10,sv_expflags@l(11)
	mr 30,3
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,2
	bc 12,2,.L302
	lis 11,itemlist@ha
	lis 0,0x38e3
	lwz 10,84(30)
	la 11,itemlist@l(11)
	ori 0,0,36409
	subf 11,11,4
	addi 10,10,744
	mullw 11,11,0
	srawi 11,11,3
	slwi 11,11,2
	lwzx 9,10,11
	addi 9,9,-1
	stwx 9,10,11
	bl ValidateSelectedItem
	lis 9,.LC49@ha
	lis 11,level@ha
	lwz 10,84(30)
	la 9,.LC49@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3996(10)
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L303
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L317
.L303:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
.L317:
	stfs 0,3996(10)
	lis 29,gi@ha
	lis 3,.LC44@ha
	la 29,gi@l(29)
	la 3,.LC44@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC51@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC51@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	mtlr 11
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 2,0(9)
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,12(29)
	lis 4,.LC45@ha
	mr 3,30
	la 4,.LC45@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L301
.L302:
	lwz 0,264(30)
	andi. 9,0,4096
	bc 12,2,.L305
	rlwinm 0,0,0,20,18
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(30)
	lis 3,.LC46@ha
	lwz 9,36(29)
	la 3,.LC46@l(3)
	mtlr 9
	blrl
	lis 9,.LC51@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC51@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 2,0(9)
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 3,0(9)
	blrl
	b .L301
.L316:
	mr 10,29
	b .L313
.L305:
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lis 11,.LC47@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC47@l(11)
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L314
	mr 28,10
.L309:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L311
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L316
.L311:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,72
	cmpw 0,31,0
	bc 12,0,.L309
.L314:
	li 10,0
.L313:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,11,744
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L315
	lis 9,gi+8@ha
	lis 5,.LC48@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC48@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L301
.L315:
	lwz 0,264(30)
	lis 29,gi@ha
	lis 3,.LC44@ha
	la 29,gi@l(29)
	la 3,.LC44@l(3)
	ori 0,0,4096
	stw 0,264(30)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC51@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC51@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 2,0(9)
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 3,0(9)
	blrl
.L301:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 Use_PowerArmor,.Lfe11-Use_PowerArmor
	.section	".rodata"
	.align 2
.LC53:
	.long 0x0
	.align 3
.LC54:
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
	addi 10,10,744
	srawi 0,0,3
	lis 9,.LC53@ha
	slwi 0,0,2
	la 9,.LC53@l(9)
	lwzx 30,10,0
	lfs 13,0(9)
	addi 9,30,1
	stwx 9,10,0
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L319
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L320
	lis 9,.LC54@ha
	lwz 11,648(31)
	la 9,.LC54@l(9)
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
.L320:
	cmpwi 0,30,0
	bc 4,2,.L319
	lwz 9,648(31)
	mr 3,29
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L319:
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
.LC55:
	.string	"Blaster"
	.align 2
.LC56:
	.long 0x0
	.align 3
.LC57:
	.long 0x40080000
	.long 0x0
	.align 2
.LC58:
	.long 0x3f800000
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
	bc 12,2,.L326
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L326
	lwz 9,648(31)
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 4,2,.L329
	lwz 3,40(9)
	lis 4,.LC55@ha
	la 4,.LC55@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L326
.L329:
	lwz 9,648(31)
	mr 3,31
	mr 4,30
	lwz 0,4(9)
	mtlr 0
	blrl
	mr. 28,3
	bc 12,2,.L331
	lis 9,ctf@ha
	lwz 10,84(30)
	lis 0,0x3e80
	lwz 11,ctf@l(9)
	lis 9,.LC56@ha
	stw 0,3860(10)
	la 9,.LC56@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L332
	lis 9,gi@ha
	lwz 11,648(31)
	la 9,gi@l(9)
	lwz 0,40(9)
	lwz 3,36(11)
	mtlr 0
	blrl
	lwz 10,84(30)
	lis 11,itemlist@ha
	lis 0,0x38e3
	la 11,itemlist@l(11)
	ori 0,0,36409
	sth 3,134(10)
	lwz 9,648(31)
	lwz 10,84(30)
	subf 9,11,9
	mullw 9,9,0
	srawi 9,9,3
	addi 9,9,1056
	sth 9,136(10)
.L332:
	lis 9,level+4@ha
	lis 11,.LC57@ha
	lfs 0,level+4@l(9)
	la 11,.LC57@l(11)
	lfd 13,0(11)
	lwz 11,84(30)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3980(11)
	lwz 10,648(31)
	lwz 0,8(10)
	cmpwi 0,0,0
	bc 12,2,.L333
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	mullw 9,9,0
	srawi 9,9,3
	extsh 0,9
	sth 9,144(11)
	stw 0,740(11)
.L333:
	lwz 9,648(31)
	lis 29,gi@ha
	la 29,gi@l(29)
	lwz 3,20(9)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC58@ha
	lwz 0,16(29)
	lis 11,.LC58@ha
	la 9,.LC58@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC58@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC56@ha
	mr 3,30
	lfs 2,0(11)
	la 9,.LC56@l(9)
	lfs 3,0(9)
	blrl
.L331:
	lwz 0,284(31)
	andis. 9,0,4
	bc 4,2,.L334
	mr 3,31
	mr 4,30
	bl G_UseTargets
	lwz 0,284(31)
	oris 0,0,0x4
	stw 0,284(31)
.L334:
	cmpwi 0,28,0
	bc 12,2,.L326
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 12,2,.L336
	lwz 0,284(31)
	andis. 9,0,2
	bc 12,2,.L336
	mr 4,30
	mr 3,31
	bl ExpertPickupDroppedWeapon
.L336:
	lis 9,.LC56@ha
	lis 11,coop@ha
	la 9,.LC56@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L338
	lwz 9,648(31)
	lwz 0,56(9)
	andi. 11,0,8
	bc 12,2,.L338
	lwz 0,284(31)
	andis. 9,0,0x3
	bc 12,2,.L326
.L338:
	lwz 0,264(31)
	cmpwi 0,0,0
	bc 4,0,.L339
	rlwinm 0,0,0,1,31
	stw 0,264(31)
	b .L326
.L339:
	mr 3,31
	bl G_FreeEdict
.L326:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 Touch_Item,.Lfe13-Touch_Item
	.section	".rodata"
	.align 2
.LC59:
	.long 0x0
	.align 2
.LC60:
	.long 0x3f800000
	.align 2
.LC61:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl Drop_Item
	.type	 Drop_Item,@function
Drop_Item:
	stwu 1,-224(1)
	mflr 0
	stmw 26,200(1)
	stw 0,228(1)
	mr 29,4
	mr 30,3
	bl G_Spawn
	lwz 11,0(29)
	mr 31,3
	lis 0,0x1
	stw 0,284(31)
	lis 10,sv_expflags@ha
	li 8,512
	stw 11,280(31)
	stw 29,648(31)
	lwz 0,28(29)
	lwz 11,sv_expflags@l(10)
	stw 0,64(31)
	stw 8,68(31)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,192(1)
	lwz 9,196(1)
	andi. 0,9,64
	bc 12,2,.L347
	li 0,520
	stw 0,68(31)
.L347:
	lis 0,0xc170
	lis 9,0x4170
	lwz 10,648(31)
	lis 11,gi@ha
	stw 0,196(31)
	mr 3,31
	stw 0,188(31)
	la 26,gi@l(11)
	stw 0,192(31)
	stw 9,208(31)
	stw 9,200(31)
	stw 9,204(31)
	lwz 9,44(26)
	lwz 4,24(10)
	mtlr 9
	blrl
	li 11,1
	lis 9,drop_temp_touch@ha
	stw 30,256(31)
	stw 11,248(31)
	la 9,drop_temp_touch@l(9)
	li 0,7
	stw 0,260(31)
	lis 11,level+4@ha
	stw 9,444(31)
	lfs 0,level+4@l(11)
	stfs 0,900(31)
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 12,2,.L348
	addi 29,1,24
	addi 4,1,8
	addi 3,3,3876
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
	addi 3,1,56
	addi 5,31,188
	addi 6,31,200
	mr 8,30
	mtlr 0
	li 9,1
	blrl
	lfs 0,68(1)
	stfs 0,4(31)
	lfs 13,72(1)
	stfs 13,8(31)
	lfs 0,76(1)
	b .L352
.L348:
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
.L352:
	stfs 0,12(31)
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,192(1)
	lwz 11,196(1)
	andi. 0,11,2
	bc 12,2,.L350
	lis 11,.LC59@ha
	lis 0,0xc1a0
	la 11,.LC59@l(11)
	lis 9,0x41a0
	stw 0,192(31)
	lfs 1,0(11)
	lis 29,0xc170
	lis 28,0x4170
	lis 11,.LC59@ha
	stw 9,204(31)
	la 11,.LC59@l(11)
	stw 0,188(31)
	lfs 2,0(11)
	lis 11,.LC60@ha
	stw 9,200(31)
	la 11,.LC60@l(11)
	stw 29,196(31)
	lfs 3,0(11)
	stw 28,208(31)
	bl tv
	mr 11,3
	lfs 11,4(30)
	lis 9,gi+48@ha
	lfs 0,0(11)
	addi 3,1,120
	addi 4,31,4
	lfs 12,8(30)
	addi 5,31,188
	addi 6,31,200
	lfs 13,12(30)
	addi 7,1,56
	mr 8,31
	fadds 11,11,0
	lwz 0,gi+48@l(9)
	li 9,3
	mtlr 0
	stfs 11,56(1)
	lfs 0,4(11)
	fadds 12,12,0
	stfs 12,60(1)
	lfs 0,8(11)
	fadds 13,13,0
	stfs 13,64(1)
	blrl
	lwz 0,124(1)
	cmpwi 0,0,0
	bc 12,2,.L350
	stw 29,196(31)
	stw 28,208(31)
	stw 29,188(31)
	stw 29,192(31)
	stw 28,200(31)
	stw 28,204(31)
.L350:
	lis 9,.LC61@ha
	addi 3,1,8
	la 9,.LC61@l(9)
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
	lis 9,.LC60@ha
	lfs 0,level+4@l(11)
	la 9,.LC60@l(9)
	lfs 13,0(9)
	lis 9,gi+72@ha
	fadds 0,0,13
	stfs 0,428(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	lwz 0,228(1)
	mtlr 0
	lmw 26,200(1)
	la 1,224(1)
	blr
.Lfe14:
	.size	 Drop_Item,.Lfe14-Drop_Item
	.section	".rodata"
	.align 2
.LC62:
	.string	"droptofloor: %s startsolid at %s\n"
	.align 3
.LC63:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC64:
	.long 0xc1700000
	.align 2
.LC65:
	.long 0x41700000
	.align 2
.LC66:
	.long 0x0
	.align 2
.LC67:
	.long 0xc3000000
	.section	".text"
	.align 2
	.globl droptofloor
	.type	 droptofloor,@function
droptofloor:
	stwu 1,-144(1)
	mflr 0
	stmw 25,116(1)
	stw 0,148(1)
	lis 9,.LC64@ha
	lis 11,.LC64@ha
	la 9,.LC64@l(9)
	la 11,.LC64@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC64@ha
	lfs 2,0(11)
	la 9,.LC64@l(9)
	lfs 3,0(9)
	bl tv
	mr 29,3
	lis 9,.LC65@ha
	lfs 13,0(29)
	la 9,.LC65@l(9)
	lis 11,.LC65@ha
	lfs 1,0(9)
	la 11,.LC65@l(11)
	lis 9,.LC65@ha
	lfs 2,0(11)
	stfs 13,188(31)
	la 9,.LC65@l(9)
	lfs 0,4(29)
	lfs 3,0(9)
	stfs 0,192(31)
	lfs 13,8(29)
	stfs 13,196(31)
	bl tv
	mr 29,3
	lis 11,sv_expflags@ha
	lfs 13,0(29)
	lwz 10,sv_expflags@l(11)
	stfs 13,200(31)
	lfs 0,4(29)
	stfs 0,204(31)
	lfs 13,8(29)
	stfs 13,208(31)
	lfs 0,20(10)
	fctiwz 12,0
	stfd 12,104(1)
	lwz 9,108(1)
	andi. 0,9,2
	bc 12,2,.L357
	lis 11,0xc1a0
	lis 10,0x41a0
	lis 0,0xc170
	lis 9,0x4170
	stw 11,192(31)
	stw 0,196(31)
	stw 10,204(31)
	stw 9,208(31)
	stw 11,188(31)
	stw 10,200(31)
.L357:
	lwz 4,268(31)
	cmpwi 0,4,0
	bc 12,2,.L358
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L359
.L358:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L359:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC66@ha
	stw 9,444(31)
	addi 30,31,4
	la 11,.LC66@l(11)
	lis 9,.LC67@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC67@l(9)
	addi 26,31,188
	lis 11,.LC66@ha
	lfs 3,0(9)
	addi 25,31,200
	la 11,.LC66@l(11)
	lfs 2,0(11)
	bl tv
	mr 29,3
	lfs 11,4(31)
	lis 9,gi@ha
	lfs 0,0(29)
	la 28,gi@l(9)
	addi 27,1,72
	lfs 12,8(31)
	addi 3,1,8
	mr 4,30
	lfs 13,12(31)
	mr 5,26
	mr 6,25
	fadds 11,11,0
	lwz 11,48(28)
	mr 7,27
	mr 8,31
	li 9,3
	mtlr 11
	stfs 11,72(1)
	lfs 0,4(29)
	fadds 12,12,0
	stfs 12,76(1)
	lfs 0,8(29)
	fadds 13,13,0
	stfs 13,80(1)
	blrl
	lwz 0,12(1)
	cmpwi 0,0,0
	bc 12,2,.L360
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,104(1)
	lwz 11,108(1)
	andi. 0,11,2
	bc 12,2,.L361
	lis 11,.LC66@ha
	lis 0,0xc170
	la 11,.LC66@l(11)
	lis 9,0x4170
	stw 0,196(31)
	lfs 1,0(11)
	lis 11,.LC66@ha
	stw 0,188(31)
	la 11,.LC66@l(11)
	stw 0,192(31)
	lfs 2,0(11)
	lis 11,.LC67@ha
	stw 9,208(31)
	la 11,.LC67@l(11)
	stw 9,200(31)
	lfs 3,0(11)
	stw 9,204(31)
	bl tv
	mr 29,3
	lfs 11,4(31)
	mr 5,26
	lfs 0,0(29)
	mr 6,25
	mr 7,27
	lfs 12,8(31)
	addi 3,1,8
	mr 4,30
	lfs 13,12(31)
	mr 8,31
	li 9,3
	fadds 11,11,0
	lwz 11,48(28)
	mtlr 11
	stfs 11,72(1)
	lfs 0,4(29)
	fadds 12,12,0
	stfs 12,76(1)
	lfs 0,8(29)
	fadds 13,13,0
	stfs 13,80(1)
	blrl
	lwz 0,12(1)
	cmpwi 0,0,0
	bc 12,2,.L360
.L361:
	lwz 29,280(31)
	mr 3,30
	bl vtos
	mr 5,3
	lwz 0,4(28)
	mr 4,29
	lis 3,.LC62@ha
	la 3,.LC62@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L356
.L360:
	lwz 0,308(31)
	lfs 12,20(1)
	lfs 0,24(1)
	cmpwi 0,0,0
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L364
	lwz 11,564(31)
	li 8,0
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
	bc 4,2,.L364
	lis 11,level+4@ha
	lis 10,.LC63@ha
	lfs 0,level+4@l(11)
	lis 9,DoRespawn@ha
	lfd 13,.LC63@l(10)
	la 9,DoRespawn@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L364:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L366
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
.L366:
	lwz 0,284(31)
	andi. 11,0,1
	bc 12,2,.L367
	lwz 0,184(31)
	lis 9,Use_Item@ha
	li 11,0
	la 9,Use_Item@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
.L367:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L356:
	lwz 0,148(1)
	mtlr 0
	lmw 25,116(1)
	la 1,144(1)
	blr
.Lfe15:
	.size	 droptofloor,.Lfe15-droptofloor
	.section	".rodata"
	.align 2
.LC68:
	.string	"PrecacheItem: %s has bad precache string"
	.align 2
.LC69:
	.string	"md2"
	.align 2
.LC70:
	.string	"sp2"
	.align 2
.LC71:
	.string	"wav"
	.align 2
.LC72:
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
	bc 12,2,.L368
	lwz 3,20(26)
	cmpwi 0,3,0
	bc 12,2,.L370
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L370:
	lwz 3,24(26)
	cmpwi 0,3,0
	bc 12,2,.L371
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L371:
	lwz 3,32(26)
	cmpwi 0,3,0
	bc 12,2,.L372
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L372:
	lwz 3,36(26)
	cmpwi 0,3,0
	bc 12,2,.L373
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
.L373:
	lwz 29,52(26)
	cmpwi 0,29,0
	bc 12,2,.L374
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L374
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L382
	mr 28,9
.L377:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L379
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L379
	mr 3,31
	b .L381
.L379:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L377
.L382:
	li 3,0
.L381:
	cmpw 0,3,26
	bc 12,2,.L374
	bl PrecacheItem
.L374:
	lwz 30,68(26)
	cmpwi 0,30,0
	bc 12,2,.L368
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 12,2,.L368
	lis 9,gi@ha
	addi 29,1,8
	la 27,gi@l(9)
	lis 24,.LC69@ha
	lis 25,.LC72@ha
.L388:
	rlwinm 9,0,0,0xff
	mr 31,30
	b .L402
.L391:
	lbzu 9,1(30)
.L402:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L391
	subf 28,31,30
	addi 0,28,-5
	cmplwi 0,0,58
	bc 4,1,.L393
	lwz 9,28(27)
	lis 3,.LC68@ha
	la 3,.LC68@l(3)
	lwz 4,0(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L393:
	mr 4,31
	mr 5,28
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 0,0
	addi 11,30,1
	stbx 0,29,28
	add 9,29,28
	la 4,.LC69@l(24)
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
	bc 12,2,.L403
	lis 4,.LC70@ha
	mr 3,31
	la 4,.LC70@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L397
.L403:
	lwz 9,32(27)
	mr 3,29
	mtlr 9
	blrl
	b .L396
.L397:
	lis 4,.LC71@ha
	mr 3,31
	la 4,.LC71@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L396
	lwz 9,36(27)
	mr 3,29
	mtlr 9
	blrl
.L396:
	add 3,29,28
	la 4,.LC72@l(25)
	addi 3,3,-3
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L386
	lwz 9,40(27)
	mr 3,29
	mtlr 9
	blrl
.L386:
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L388
.L368:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe16:
	.size	 PrecacheItem,.Lfe16-PrecacheItem
	.section	".rodata"
	.align 2
.LC73:
	.string	"%s at %s has invalid spawnflags set\n"
	.align 2
.LC74:
	.string	"weapon_bfg"
	.align 2
.LC75:
	.string	"item_flag_team1"
	.align 2
.LC76:
	.string	"item_flag_team2"
	.align 3
.LC77:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC78:
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
	bc 12,2,.L405
	lwz 3,280(31)
	lis 4,.LC26@ha
	la 4,.LC26@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L405
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
	lis 3,.LC73@ha
	la 3,.LC73@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L405:
	lis 9,.LC78@ha
	lis 11,deathmatch@ha
	la 9,.LC78@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L407
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2048
	bc 12,2,.L408
	lwz 0,4(30)
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L422
	lis 9,Pickup_PowerArmor@ha
	la 9,Pickup_PowerArmor@l(9)
	cmpw 0,0,9
	bc 12,2,.L422
.L408:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 12,2,.L411
	lwz 0,4(30)
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L422
.L411:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 12,2,.L413
	lwz 0,4(30)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L422
	lis 9,Pickup_Adrenaline@ha
	la 9,Pickup_Adrenaline@l(9)
	cmpw 0,0,9
	bc 12,2,.L422
	lis 9,Pickup_AncientHead@ha
	la 9,Pickup_AncientHead@l(9)
	cmpw 0,0,9
	bc 12,2,.L422
.L413:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8192
	bc 12,2,.L407
	lwz 0,56(30)
	cmpwi 0,0,2
	bc 12,2,.L422
	lwz 3,280(31)
	lis 4,.LC74@ha
	la 4,.LC74@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L422
.L407:
	lis 9,.LC78@ha
	lis 11,coop@ha
	la 9,.LC78@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L419
	lwz 3,280(31)
	lis 4,.LC26@ha
	la 4,.LC26@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L419
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
.L419:
	lis 9,.LC78@ha
	lis 11,coop@ha
	la 9,.LC78@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L420
	lwz 0,56(30)
	andi. 9,0,8
	bc 12,2,.L420
	li 0,0
	stw 0,12(30)
.L420:
	lis 9,.LC78@ha
	lis 11,ctf@ha
	la 9,.LC78@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L421
	lwz 3,280(31)
	lis 4,.LC75@ha
	la 4,.LC75@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L422
	lwz 3,280(31)
	lis 4,.LC76@ha
	la 4,.LC76@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L421
.L422:
	mr 3,31
	bl G_FreeEdict
	b .L404
.L421:
	stw 30,648(31)
	lis 11,level+4@ha
	lis 10,.LC77@ha
	lfs 0,level+4@l(11)
	lis 9,droptofloor@ha
	lis 8,sv_expflags@ha
	lfd 12,.LC77@l(10)
	la 9,droptofloor@l(9)
	lwz 10,sv_expflags@l(8)
	stw 9,436(31)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(31)
	lwz 0,28(30)
	stw 0,64(31)
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,64
	li 0,512
	bc 12,2,.L423
	li 0,513
.L423:
	stw 0,68(31)
	lwz 3,268(31)
	cmpwi 0,3,0
	bc 12,2,.L425
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L425:
	lwz 3,280(31)
	lis 4,.LC75@ha
	la 4,.LC75@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L427
	lwz 3,280(31)
	lis 4,.LC76@ha
	la 4,.LC76@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L404
.L427:
	lis 9,CTFFlagSetup@ha
	la 9,CTFFlagSetup@l(9)
	stw 9,436(31)
.L404:
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
	.long .LC79
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC80
	.long .LC81
	.long 1
	.long 0
	.long .LC82
	.long .LC83
	.long 3
	.long 0
	.long 0
	.long 4
	.long bodyarmor_info
	.long 3
	.long .LC84
	.long .LC85
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC80
	.long .LC86
	.long 1
	.long 0
	.long .LC87
	.long .LC88
	.long 3
	.long 0
	.long 0
	.long 4
	.long combatarmor_info
	.long 2
	.long .LC84
	.long .LC89
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC80
	.long .LC90
	.long 1
	.long 0
	.long .LC91
	.long .LC92
	.long 3
	.long 0
	.long 0
	.long 4
	.long jacketarmor_info
	.long 1
	.long .LC84
	.long .LC93
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC94
	.long .LC95
	.long 1
	.long 0
	.long .LC91
	.long .LC96
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long 4
	.long .LC84
	.long .LC97
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC98
	.long .LC99
	.long 1
	.long 0
	.long .LC100
	.long .LC101
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long .LC84
	.long .LC102
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC98
	.long .LC103
	.long 1
	.long 0
	.long .LC104
	.long .LC105
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long .LC106
	.long .LC102
	.long Pickup_Powerup
	.long Use_PowerArmor
	.long Drop_General
	.long 0
	.long .LC98
	.long .LC103
	.long 1
	.long 0
	.long .LC104
	.long .LC107
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long .LC106
	.long .LC108
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Blaster
	.long .LC109
	.long .LC110
	.long 1
	.long .LC111
	.long .LC112
	.long .LC55
	.long 0
	.long 0
	.long .LC55
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
	.long .LC6
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
	.long .LC6
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
	.long .LC5
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
	.long .LC5
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
	.long .LC10
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
	.long .LC10
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
	.long .LC11
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
	.long .LC9
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
	.long .LC12
	.long 9
	.long 0
	.long 0
	.long .LC168
	.long .LC74
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
	.long .LC9
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
	.long .LC6
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 1
	.long .LC84
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
	.long .LC5
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long .LC84
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
	.long .LC9
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 4
	.long .LC84
	.long .LC28
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC139
	.long .LC183
	.long 0
	.long 0
	.long .LC184
	.long .LC11
	.long 3
	.long 5
	.long 0
	.long 2
	.long 0
	.long 2
	.long .LC84
	.long .LC29
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC139
	.long .LC185
	.long 0
	.long 0
	.long .LC186
	.long .LC12
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 5
	.long .LC84
	.long .LC187
	.long Pickup_Powerup
	.long Use_Quad
	.long Drop_General
	.long 0
	.long .LC188
	.long .LC189
	.long 1
	.long 0
	.long .LC190
	.long .LC191
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long .LC192
	.long .LC193
	.long Pickup_Powerup
	.long Use_Invulnerability
	.long Drop_General
	.long 0
	.long .LC188
	.long .LC194
	.long 1
	.long 0
	.long .LC195
	.long .LC196
	.long 2
	.long 300
	.long 0
	.long 32
	.long 0
	.long 0
	.long .LC197
	.long .LC198
	.long Pickup_Powerup
	.long Use_Silencer
	.long Drop_General
	.long 0
	.long .LC188
	.long .LC199
	.long 1
	.long 0
	.long .LC200
	.long .LC201
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long .LC84
	.long .LC202
	.long Pickup_Powerup
	.long Use_Breather
	.long Drop_General
	.long 0
	.long .LC188
	.long .LC203
	.long 1
	.long 0
	.long .LC204
	.long .LC205
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long .LC206
	.long .LC207
	.long Pickup_Powerup
	.long Use_Envirosuit
	.long Drop_General
	.long 0
	.long .LC188
	.long .LC208
	.long 1
	.long 0
	.long .LC209
	.long .LC210
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long .LC206
	.long .LC211
	.long Pickup_AncientHead
	.long 0
	.long 0
	.long 0
	.long .LC188
	.long .LC212
	.long 1
	.long 0
	.long .LC213
	.long .LC214
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC84
	.long .LC215
	.long Pickup_Adrenaline
	.long 0
	.long 0
	.long 0
	.long .LC188
	.long .LC216
	.long 1
	.long 0
	.long .LC217
	.long .LC218
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC84
	.long .LC219
	.long Pickup_Bandolier
	.long 0
	.long 0
	.long 0
	.long .LC188
	.long .LC220
	.long 1
	.long 0
	.long .LC221
	.long .LC222
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC84
	.long .LC223
	.long Pickup_Pack
	.long 0
	.long 0
	.long 0
	.long .LC188
	.long .LC110
	.long 1
	.long 0
	.long .LC224
	.long .LC225
	.long 2
	.long 180
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC84
	.long .LC226
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC188
	.long .LC227
	.long 1
	.long 0
	.long .LC228
	.long .LC229
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC84
	.long .LC26
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC188
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
	.long .LC84
	.long .LC233
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC188
	.long .LC234
	.long 1
	.long 0
	.long .LC235
	.long .LC236
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC84
	.long .LC237
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC188
	.long .LC238
	.long 1
	.long 0
	.long .LC239
	.long .LC240
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC84
	.long .LC241
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC188
	.long .LC242
	.long 1
	.long 0
	.long .LC243
	.long .LC244
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC84
	.long .LC245
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC188
	.long .LC246
	.long 1
	.long 0
	.long .LC247
	.long .LC248
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC84
	.long .LC249
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC188
	.long .LC250
	.long 1
	.long 0
	.long .LC251
	.long .LC252
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC84
	.long .LC253
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC188
	.long .LC254
	.long 2
	.long 0
	.long .LC255
	.long .LC256
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC84
	.long .LC257
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC188
	.long .LC258
	.long 1
	.long 0
	.long .LC259
	.long .LC260
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC84
	.long 0
	.long Pickup_Health
	.long 0
	.long 0
	.long 0
	.long .LC188
	.long 0
	.long 0
	.long 0
	.long .LC261
	.long .LC262
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC84
	.long .LC75
	.long CTFTouchFlag
	.long 0
	.long 0
	.long 0
	.long 0
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
	.long .LC266
	.long .LC76
	.long CTFTouchFlag
	.long 0
	.long 0
	.long 0
	.long 0
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
	.long .LC266
	.long 0
	.space	68
	.section	".rodata"
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
	.string	"Health"
	.align 2
.LC261:
	.string	"i_health"
	.align 2
.LC260:
	.string	"Airstrike Marker"
	.align 2
.LC259:
	.string	"i_airstrike"
	.align 2
.LC258:
	.string	"models/items/keys/target/tris.md2"
	.align 2
.LC257:
	.string	"key_airstrike_target"
	.align 2
.LC256:
	.string	"Commander's Head"
	.align 2
.LC255:
	.string	"k_comhead"
	.align 2
.LC254:
	.string	"models/monsters/commandr/head/tris.md2"
	.align 2
.LC253:
	.string	"key_commander_head"
	.align 2
.LC252:
	.string	"Red Key"
	.align 2
.LC251:
	.string	"k_redkey"
	.align 2
.LC250:
	.string	"models/items/keys/red_key/tris.md2"
	.align 2
.LC249:
	.string	"key_red_key"
	.align 2
.LC248:
	.string	"Blue Key"
	.align 2
.LC247:
	.string	"k_bluekey"
	.align 2
.LC246:
	.string	"models/items/keys/key/tris.md2"
	.align 2
.LC245:
	.string	"key_blue_key"
	.align 2
.LC244:
	.string	"Security Pass"
	.align 2
.LC243:
	.string	"k_security"
	.align 2
.LC242:
	.string	"models/items/keys/pass/tris.md2"
	.align 2
.LC241:
	.string	"key_pass"
	.align 2
.LC240:
	.string	"Data Spinner"
	.align 2
.LC239:
	.string	"k_dataspin"
	.align 2
.LC238:
	.string	"models/items/keys/spinner/tris.md2"
	.align 2
.LC237:
	.string	"key_data_spinner"
	.align 2
.LC236:
	.string	"Pyramid Key"
	.align 2
.LC235:
	.string	"k_pyramid"
	.align 2
.LC234:
	.string	"models/items/keys/pyramid/tris.md2"
	.align 2
.LC233:
	.string	"key_pyramid"
	.align 2
.LC232:
	.string	"Power Cube"
	.align 2
.LC231:
	.string	"k_powercube"
	.align 2
.LC230:
	.string	"models/items/keys/power/tris.md2"
	.align 2
.LC229:
	.string	"Data CD"
	.align 2
.LC228:
	.string	"k_datacd"
	.align 2
.LC227:
	.string	"models/items/keys/data_cd/tris.md2"
	.align 2
.LC226:
	.string	"key_data_cd"
	.align 2
.LC225:
	.string	"Ammo Pack"
	.align 2
.LC224:
	.string	"i_pack"
	.align 2
.LC223:
	.string	"item_pack"
	.align 2
.LC222:
	.string	"Bandolier"
	.align 2
.LC221:
	.string	"p_bandolier"
	.align 2
.LC220:
	.string	"models/items/band/tris.md2"
	.align 2
.LC219:
	.string	"item_bandolier"
	.align 2
.LC218:
	.string	"Adrenaline"
	.align 2
.LC217:
	.string	"p_adrenaline"
	.align 2
.LC216:
	.string	"models/items/adrenal/tris.md2"
	.align 2
.LC215:
	.string	"item_adrenaline"
	.align 2
.LC214:
	.string	"Ancient Head"
	.align 2
.LC213:
	.string	"i_fixme"
	.align 2
.LC212:
	.string	"models/items/c_head/tris.md2"
	.align 2
.LC211:
	.string	"item_ancient_head"
	.align 2
.LC210:
	.string	"Environment Suit"
	.align 2
.LC209:
	.string	"p_envirosuit"
	.align 2
.LC208:
	.string	"models/items/enviro/tris.md2"
	.align 2
.LC207:
	.string	"item_enviro"
	.align 2
.LC206:
	.string	"items/airout.wav"
	.align 2
.LC205:
	.string	"Rebreather"
	.align 2
.LC204:
	.string	"p_rebreather"
	.align 2
.LC203:
	.string	"models/items/breather/tris.md2"
	.align 2
.LC202:
	.string	"item_breather"
	.align 2
.LC201:
	.string	"Silencer"
	.align 2
.LC200:
	.string	"p_silencer"
	.align 2
.LC199:
	.string	"models/items/silencer/tris.md2"
	.align 2
.LC198:
	.string	"item_silencer"
	.align 2
.LC197:
	.string	"items/protect.wav items/protect2.wav items/protect4.wav"
	.align 2
.LC196:
	.string	"Invulnerability"
	.align 2
.LC195:
	.string	"p_invulnerability"
	.align 2
.LC194:
	.string	"models/items/invulner/tris.md2"
	.align 2
.LC193:
	.string	"item_invulnerability"
	.align 2
.LC192:
	.string	"items/damage.wav items/damage2.wav items/damage3.wav"
	.align 2
.LC191:
	.string	"Quad Damage"
	.align 2
.LC190:
	.string	"p_quad"
	.align 2
.LC189:
	.string	"models/items/quaddama/tris.md2"
	.align 2
.LC188:
	.string	"items/pkup.wav"
	.align 2
.LC187:
	.string	"item_quad"
	.align 2
.LC186:
	.string	"a_slugs"
	.align 2
.LC185:
	.string	"models/items/ammo/slugs/medium/tris.md2"
	.align 2
.LC184:
	.string	"a_rockets"
	.align 2
.LC183:
	.string	"models/items/ammo/rockets/medium/tris.md2"
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
	.string	"w_blaster"
	.align 2
.LC111:
	.string	"models/weapons/v_blast/tris.md2"
	.align 2
.LC110:
	.string	"models/items/pack/tris.md2"
	.align 2
.LC109:
	.string	"misc/w_pkup.wav"
	.align 2
.LC108:
	.string	"weapon_blaster"
	.align 2
.LC107:
	.string	"Inertial Screen"
	.align 2
.LC106:
	.string	"misc/power2.wav misc/power1.wav"
	.align 2
.LC105:
	.string	"Power Shield"
	.align 2
.LC104:
	.string	"i_powershield"
	.align 2
.LC103:
	.string	"models/items/armor/shield/tris.md2"
	.align 2
.LC102:
	.string	"item_power_shield"
	.align 2
.LC101:
	.string	"Power Screen"
	.align 2
.LC100:
	.string	"i_powerscreen"
	.align 2
.LC99:
	.string	"models/items/armor/screen/tris.md2"
	.align 2
.LC98:
	.string	"misc/ar3_pkup.wav"
	.align 2
.LC97:
	.string	"item_power_screen"
	.align 2
.LC96:
	.string	"Armor Shard"
	.align 2
.LC95:
	.string	"models/items/armor/shard/tris.md2"
	.align 2
.LC94:
	.string	"misc/ar2_pkup.wav"
	.align 2
.LC93:
	.string	"item_armor_shard"
	.align 2
.LC92:
	.string	"Jacket Armor"
	.align 2
.LC91:
	.string	"i_jacketarmor"
	.align 2
.LC90:
	.string	"models/items/armor/jacket/tris.md2"
	.align 2
.LC89:
	.string	"item_armor_jacket"
	.align 2
.LC88:
	.string	"Combat Armor"
	.align 2
.LC87:
	.string	"i_combatarmor"
	.align 2
.LC86:
	.string	"models/items/armor/combat/tris.md2"
	.align 2
.LC85:
	.string	"item_armor_combat"
	.align 2
.LC84:
	.string	""
	.align 2
.LC83:
	.string	"Body Armor"
	.align 2
.LC82:
	.string	"i_bodyarmor"
	.align 2
.LC81:
	.string	"models/items/armor/body/tris.md2"
	.align 2
.LC80:
	.string	"misc/ar1_pkup.wav"
	.align 2
.LC79:
	.string	"item_armor_body"
	.size	 itemlist,3312
	.align 2
.LC270:
	.string	"models/items/healing/medium/tris.md2"
	.align 2
.LC271:
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
	lis 11,.LC271@ha
	lis 9,deathmatch@ha
	la 11,.LC271@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L430
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L430
	bl G_FreeEdict
	b .L429
.L430:
	lis 11,.LC270@ha
	lis 10,sv_expflags@ha
	lwz 8,sv_expflags@l(10)
	la 11,.LC270@l(11)
	stw 11,268(29)
	lfs 0,20(8)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,2
	bc 12,2,.L431
	li 0,15
	b .L442
.L441:
	mr 4,31
	b .L439
.L431:
	li 0,10
.L442:
	stw 0,532(29)
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC262@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC262@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L440
	mr 28,10
.L435:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L437
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L441
.L437:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L435
.L440:
	li 4,0
.L439:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC36@ha
	lwz 0,gi+36@l(9)
	la 3,.LC36@l(3)
	mtlr 0
	blrl
.L429:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 SP_item_health,.Lfe18-SP_item_health
	.section	".rodata"
	.align 2
.LC272:
	.string	"models/items/healing/stimpack/tris.md2"
	.align 2
.LC273:
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
	lis 11,.LC273@ha
	lis 9,deathmatch@ha
	la 11,.LC273@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L444
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L444
	bl G_FreeEdict
	b .L443
.L444:
	lis 11,.LC272@ha
	lis 10,sv_expflags@ha
	lwz 8,sv_expflags@l(10)
	la 11,.LC272@l(11)
	stw 11,268(29)
	lfs 0,20(8)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,2
	bc 12,2,.L445
	li 0,10
	li 9,0
	b .L456
.L455:
	mr 4,31
	b .L453
.L445:
	li 0,2
	li 9,1
.L456:
	stw 0,532(29)
	stw 9,644(29)
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC262@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC262@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L454
	mr 28,10
.L449:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L451
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L455
.L451:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L449
.L454:
	li 4,0
.L453:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC35@ha
	lwz 0,gi+36@l(9)
	la 3,.LC35@l(3)
	mtlr 0
	blrl
.L443:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe19:
	.size	 SP_item_health_small,.Lfe19-SP_item_health_small
	.section	".rodata"
	.align 2
.LC274:
	.string	"models/items/healing/large/tris.md2"
	.align 2
.LC275:
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
	lis 11,.LC275@ha
	lis 9,deathmatch@ha
	la 11,.LC275@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L458
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L458
	bl G_FreeEdict
	b .L457
.L458:
	lis 11,.LC274@ha
	lis 10,sv_expflags@ha
	lwz 8,sv_expflags@l(10)
	la 11,.LC274@l(11)
	stw 11,268(29)
	lfs 0,20(8)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,2
	bc 12,2,.L459
	li 0,20
	b .L470
.L469:
	mr 4,31
	b .L467
.L459:
	li 0,25
.L470:
	stw 0,532(29)
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC262@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC262@l(11)
	la 31,itemlist@l(9)
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
	bc 12,2,.L469
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
	lis 3,.LC37@ha
	lwz 0,gi+36@l(9)
	la 3,.LC37@l(3)
	mtlr 0
	blrl
.L457:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 SP_item_health_large,.Lfe20-SP_item_health_large
	.section	".rodata"
	.align 2
.LC276:
	.string	"models/items/mega_h/tris.md2"
	.align 2
.LC277:
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
	lis 11,.LC277@ha
	lis 9,deathmatch@ha
	la 11,.LC277@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L472
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L472
	bl G_FreeEdict
	b .L471
.L483:
	mr 4,31
	b .L479
.L472:
	lis 9,.LC276@ha
	li 0,100
	la 9,.LC276@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC262@ha
	lis 11,itemlist@ha
	la 27,.LC262@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L480
	mr 28,10
.L475:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L477
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L483
.L477:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L475
.L480:
	li 4,0
.L479:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC34@ha
	lwz 0,gi+36@l(9)
	la 3,.LC34@l(3)
	mtlr 0
	blrl
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,8
	li 0,3
	bc 12,2,.L481
	li 0,0
.L481:
	stw 0,644(29)
.L471:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe21:
	.size	 SP_item_health_mega,.Lfe21-SP_item_health_mega
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
	bc 4,0,.L488
	lis 11,itemlist@ha
	lis 9,gi@ha
	la 11,itemlist@l(11)
	la 28,gi@l(9)
	mr 29,10
	addi 30,11,40
.L490:
	lwz 9,24(28)
	addi 3,31,1056
	lwz 4,0(30)
	addi 31,31,1
	mtlr 9
	addi 30,30,72
	blrl
	lwz 0,1556(29)
	cmpw 0,31,0
	bc 12,0,.L490
.L488:
	lis 9,game@ha
	lis 11,jacket_armor_index@ha
	la 10,game@l(9)
	li 30,0
	lwz 0,1556(10)
	la 27,jacket_armor_index@l(11)
	lis 9,.LC92@ha
	lis 11,itemlist@ha
	la 28,.LC92@l(9)
	cmpw 0,30,0
	la 31,itemlist@l(11)
	bc 4,0,.L499
	mr 29,10
.L494:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L496
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L496
	mr 11,31
	b .L498
.L496:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L494
.L499:
	li 11,0
.L498:
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
	lis 10,.LC88@ha
	la 26,combat_armor_index@l(9)
	srawi 11,11,3
	la 28,.LC88@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L507
	mr 29,7
.L502:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L504
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L504
	mr 11,31
	b .L506
.L504:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L502
.L507:
	li 11,0
.L506:
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
	lis 10,.LC83@ha
	la 27,body_armor_index@l(9)
	srawi 11,11,3
	la 28,.LC83@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L515
	mr 29,7
.L510:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L512
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L512
	mr 11,31
	b .L514
.L512:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L510
.L515:
	li 11,0
.L514:
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
	lis 10,.LC101@ha
	la 26,power_screen_index@l(9)
	srawi 11,11,3
	la 28,.LC101@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L523
	mr 29,7
.L518:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L520
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L520
	mr 11,31
	b .L522
.L520:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L518
.L523:
	li 11,0
.L522:
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
	lis 10,.LC105@ha
	la 27,power_shield_index@l(9)
	srawi 11,11,3
	la 28,.LC105@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L531
	mr 29,7
.L526:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L528
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L528
	mr 8,31
	b .L530
.L528:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L526
.L531:
	li 8,0
.L530:
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
.Lfe22:
	.size	 SetItemNames,.Lfe22-SetItemNames
	.comm	jacket_armor_index,4,4
	.comm	combat_armor_index,4,4
	.comm	body_armor_index,4,4
	.align 2
	.globl InitItems
	.type	 InitItems,@function
InitItems:
	lis 9,game+1556@ha
	li 0,45
	stw 0,game+1556@l(9)
	blr
.Lfe23:
	.size	 InitItems,.Lfe23-InitItems
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
	b .L532
.L20:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L21
.L19:
	li 3,0
.L532:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 FindItem,.Lfe24-FindItem
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
	b .L533
.L12:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L13
.L11:
	li 3,0
.L533:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 FindItemByClassname,.Lfe25-FindItemByClassname
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
.Lfe26:
	.size	 SetRespawn,.Lfe26-SetRespawn
	.align 2
	.globl ArmorIndex
	.type	 ArmorIndex,@function
ArmorIndex:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L265
	li 3,0
	blr
.L265:
	lis 9,jacket_armor_index@ha
	addi 10,11,744
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
.Lfe27:
	.size	 ArmorIndex,.Lfe27-ArmorIndex
	.align 2
	.globl PowerArmorType
	.type	 PowerArmorType,@function
PowerArmorType:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L297
.L536:
	li 3,0
	blr
.L297:
	lwz 0,264(3)
	andi. 9,0,4096
	bc 12,2,.L536
	lis 9,power_shield_index@ha
	addi 11,11,744
	lwz 0,power_shield_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L299
	lis 9,power_screen_index@ha
	lwz 0,power_screen_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	srawi 3,9,31
	subf 3,9,3
	srwi 3,3,31
	blr
.L299:
	li 3,2
	blr
.Lfe28:
	.size	 PowerArmorType,.Lfe28-PowerArmorType
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
.Lfe29:
	.size	 GetItemByIndex,.Lfe29-GetItemByIndex
	.comm	gametype,4,4
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.comm	power_screen_index,4,4
	.comm	power_shield_index,4,4
	.section	".sbss","aw",@nobits
	.align 2
quad_drop_timeout_hack:
	.space	4
	.size	 quad_drop_timeout_hack,4
	.section	".rodata"
	.align 2
.LC278:
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
	lis 9,.LC278@ha
	lis 11,ctf@ha
	lwz 30,564(31)
	la 9,.LC278@l(9)
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
.Lfe30:
	.size	 DoRespawn,.Lfe30-DoRespawn
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
	addi 11,11,744
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
.Lfe31:
	.size	 Drop_General,.Lfe31-Drop_General
	.section	".rodata"
	.align 2
.LC279:
	.long 0x0
	.align 3
.LC280:
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
	lis 11,.LC279@ha
	lis 9,deathmatch@ha
	la 11,.LC279@l(11)
	mr 12,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L54
	lwz 9,484(4)
	addi 9,9,1
	stw 9,484(4)
.L54:
	lwz 0,480(4)
	lwz 9,484(4)
	cmpw 0,0,9
	bc 12,0,.L55
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 12,2,.L56
	li 3,0
	b .L538
.L55:
	stw 9,480(4)
.L56:
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L58
	lis 9,.LC279@ha
	lis 11,deathmatch@ha
	la 9,.LC279@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L58
	lis 9,.LC280@ha
	lwz 11,648(12)
	la 9,.LC280@l(9)
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
.L58:
	li 3,1
.L538:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe32:
	.size	 Pickup_Adrenaline,.Lfe32-Pickup_Adrenaline
	.section	".rodata"
	.align 2
.LC281:
	.long 0x0
	.align 3
.LC282:
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
	bc 4,2,.L61
	lis 9,.LC281@ha
	lis 11,deathmatch@ha
	la 9,.LC281@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L61
	lis 9,.LC282@ha
	lwz 11,648(12)
	la 9,.LC282@l(9)
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
.L61:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe33:
	.size	 Pickup_AncientHead,.Lfe33-Pickup_AncientHead
	.section	".rodata"
	.align 3
.LC283:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC284:
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
	addi 11,11,744
	slwi 4,4,2
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC283@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC283@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3956(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L167
	lis 9,.LC284@ha
	la 9,.LC284@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L539
.L167:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L539:
	stfs 0,3956(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe34:
	.size	 Use_Breather,.Lfe34-Use_Breather
	.section	".rodata"
	.align 3
.LC285:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC286:
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
	addi 11,11,744
	slwi 4,4,2
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC285@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC285@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3960(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L170
	lis 9,.LC286@ha
	la 9,.LC286@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L540
.L170:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L540:
	stfs 0,3960(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe35:
	.size	 Use_Envirosuit,.Lfe35-Use_Envirosuit
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
	addi 11,11,744
	slwi 4,4,2
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lwz 11,84(29)
	lwz 9,3972(11)
	addi 9,9,30
	stw 9,3972(11)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 Use_Silencer,.Lfe36-Use_Silencer
	.align 2
	.globl Drop_Ammo
	.type	 Drop_Ammo,@function
Drop_Ammo:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,sv_expflags@ha
	lwz 10,sv_expflags@l(11)
	mr 30,3
	mr 31,4
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	andis. 0,9,2
	bc 12,2,.L230
	lis 9,gi+8@ha
	lis 5,.LC33@ha
	lwz 0,gi+8@l(9)
	la 5,.LC33@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L229
.L230:
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,31
	mr 4,31
	mullw 9,9,0
	mr 3,30
	srawi 29,9,3
	bl Drop_Item
	lwz 9,84(30)
	slwi 0,29,2
	mr 11,3
	lwz 4,48(31)
	addi 9,9,744
	lwzx 0,9,0
	cmpw 0,0,4
	bc 12,0,.L231
	stw 4,532(11)
	b .L232
.L231:
	stw 0,532(11)
.L232:
	lwz 9,84(30)
	slwi 10,29,2
	mr 3,30
	lwz 11,532(11)
	addi 9,9,744
	lwzx 0,9,10
	subf 0,11,0
	stwx 0,9,10
	bl ValidateSelectedItem
.L229:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe37:
	.size	 Drop_Ammo,.Lfe37-Drop_Ammo
	.section	".rodata"
	.align 2
.LC287:
	.long 0x3f800000
	.align 2
.LC288:
	.long 0x0
	.align 2
.LC289:
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
	bc 4,1,.L234
	lis 10,.LC287@ha
	lis 9,level+4@ha
	la 10,.LC287@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(7)
	lwz 9,480(11)
	addi 9,9,-1
	stw 9,480(11)
	b .L233
.L234:
	lwz 0,284(7)
	andis. 6,0,0x1
	bc 4,2,.L235
	lis 9,.LC288@ha
	lis 11,deathmatch@ha
	la 9,.LC288@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L235
	lwz 9,264(7)
	lis 11,.LC289@ha
	lis 10,level+4@ha
	lwz 0,184(7)
	la 11,.LC289@l(11)
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
	b .L233
.L235:
	mr 3,7
	bl G_FreeEdict
.L233:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe38:
	.size	 MegaHealth_think,.Lfe38-MegaHealth_think
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
	bc 12,2,.L324
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,30
	addi 11,11,744
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,1
	bc 4,2,.L324
	bl Use_PowerArmor
.L324:
	mr 3,31
	mr 4,30
	bl Drop_Item
	lis 11,itemlist@ha
	lis 0,0x38e3
	lwz 10,84(31)
	la 11,itemlist@l(11)
	ori 0,0,36409
	subf 11,11,30
	addi 10,10,744
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
.Lfe39:
	.size	 Drop_PowerArmor,.Lfe39-Drop_PowerArmor
	.align 2
	.type	 drop_temp_touch,@function
drop_temp_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,256(3)
	cmpw 0,4,0
	bc 12,2,.L341
	bl Touch_Item
.L341:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe40:
	.size	 drop_temp_touch,.Lfe40-drop_temp_touch
	.section	".rodata"
	.align 2
.LC290:
	.long 0x0
	.section	".text"
	.align 2
	.type	 drop_make_touchable,@function
drop_make_touchable:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,Touch_Item@ha
	lis 11,deathmatch@ha
	la 9,Touch_Item@l(9)
	lwz 10,deathmatch@l(11)
	stw 9,444(3)
	lis 9,.LC290@ha
	lfs 0,20(10)
	la 9,.LC290@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L343
	lwz 0,284(3)
	andis. 9,0,2
	bc 12,2,.L343
	bl ItemEffects
.L343:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe41:
	.size	 drop_make_touchable,.Lfe41-drop_make_touchable
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
	bc 12,2,.L354
	li 0,2
	stw 11,444(3)
	stw 0,248(3)
	b .L355
.L354:
	lis 9,Touch_Item@ha
	li 0,1
	la 9,Touch_Item@l(9)
	stw 0,248(3)
	stw 9,444(3)
.L355:
	lis 9,gi+72@ha
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe42:
	.size	 Use_Item,.Lfe42-Use_Item
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
