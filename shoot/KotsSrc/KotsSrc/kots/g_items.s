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
	.long 0x0
	.align 3
.LC2:
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
	lwz 0,648(31)
	la 9,itemlist@l(9)
	lis 11,0x286b
	mr 30,4
	ori 11,11,51739
	subf 0,9,0
	lwz 10,84(30)
	lis 9,deathmatch@ha
	mullw 0,0,11
	lwz 8,deathmatch@l(9)
	addi 10,10,740
	lis 9,.LC1@ha
	rlwinm 0,0,0,0,29
	la 9,.LC1@l(9)
	lfs 13,0(9)
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L39
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L40
	lis 9,.LC2@ha
	lwz 11,648(31)
	la 9,.LC2@l(9)
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
.L40:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,16
	bc 4,2,.L43
	lwz 9,648(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L39
	lwz 0,284(31)
	andis. 9,0,2
	bc 12,2,.L39
.L43:
	lwz 9,648(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L44
	lwz 0,284(31)
	andis. 9,0,2
	bc 12,2,.L44
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
.L44:
	lwz 9,648(31)
	mr 3,30
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L39:
	li 3,1
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Pickup_Powerup,.Lfe1-Pickup_Powerup
	.section	".rodata"
	.align 2
.LC3:
	.string	"Bullets"
	.align 2
.LC4:
	.string	"Shells"
	.align 2
.LC5:
	.long 0x0
	.align 3
.LC6:
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
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC3@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC3@l(11)
	mr 29,3
	mr 28,4
	cmpw 0,30,0
	la 31,itemlist@l(9)
	bc 4,0,.L62
	mr 27,10
.L57:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L59
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L59
	mr 8,31
	b .L61
.L59:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L57
.L62:
	li 8,0
.L61:
	cmpwi 0,8,0
	bc 12,2,.L63
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(28)
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
	lwz 9,84(28)
	lwz 11,1764(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L63
	stwx 11,9,8
.L63:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC4@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC4@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L72
	mr 27,10
.L67:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L69
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L69
	mr 8,31
	b .L71
.L69:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L67
.L72:
	li 8,0
.L71:
	cmpwi 0,8,0
	bc 12,2,.L73
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(28)
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
	lwz 9,84(28)
	lwz 11,1768(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L73
	stwx 11,9,8
.L73:
	li 4,2
	mr 3,28
	bl KOTSPickup_Pack
	lwz 0,284(29)
	andis. 4,0,0x1
	bc 4,2,.L75
	lis 9,.LC5@ha
	lis 11,deathmatch@ha
	la 9,.LC5@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L75
	lis 9,.LC6@ha
	lwz 11,648(29)
	la 9,.LC6@l(9)
	lis 7,0x4330
	lwz 0,264(29)
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
	stw 0,264(29)
	stw 9,20(1)
	ori 11,11,1
	stw 7,16(1)
	lfd 0,16(1)
	stw 11,184(29)
	stw 4,248(29)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,436(29)
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(29)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L75:
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
.LC7:
	.string	"Cells"
	.align 2
.LC8:
	.string	"Grenades"
	.align 2
.LC9:
	.string	"Rockets"
	.align 2
.LC10:
	.string	"Slugs"
	.align 2
.LC11:
	.long 0x0
	.align 3
.LC12:
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
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC3@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC3@l(11)
	mr 27,3
	mr 29,4
	cmpw 0,30,0
	la 31,itemlist@l(9)
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
	lwz 11,1764(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L86
	stwx 11,9,8
.L86:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC4@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC4@l(11)
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
	lwz 11,1768(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L96
	stwx 11,9,8
.L96:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC7@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC7@l(11)
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
	lwz 11,1780(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L106
	stwx 11,9,8
.L106:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC8@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC8@l(11)
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
	lwz 11,1776(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L116
	stwx 11,9,8
.L116:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC9@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC9@l(11)
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
	lwz 11,1772(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L126
	stwx 11,9,8
.L126:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC10@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC10@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L135
	mr 28,10
.L130:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L132
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L132
	mr 8,31
	b .L134
.L132:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L130
.L135:
	li 8,0
.L134:
	cmpwi 0,8,0
	bc 12,2,.L136
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
	lwz 11,1784(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L136
	stwx 11,9,8
.L136:
	li 4,1
	mr 3,29
	bl KOTSPickup_Pack
	lwz 0,284(27)
	andis. 4,0,0x1
	bc 4,2,.L138
	lis 9,.LC11@ha
	lis 11,deathmatch@ha
	la 9,.LC11@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L138
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
.L138:
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
.LC13:
	.string	"items/damage.wav"
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC15:
	.long 0x3f800000
	.align 2
.LC16:
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
	bc 12,2,.L141
	li 0,0
	mr 10,9
	stw 0,quad_drop_timeout_hack@l(11)
	b .L142
.L141:
	li 10,300
.L142:
	lis 11,level@ha
	lwz 8,84(31)
	lwz 11,level@l(11)
	lis 7,0x4330
	lis 6,.LC14@ha
	la 6,.LC14@l(6)
	lfs 12,3832(8)
	xoris 0,11,0x8000
	lfd 13,0(6)
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L143
	xoris 0,10,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fadds 0,12,0
	b .L145
.L143:
	add 0,11,10
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
.L145:
	stfs 0,3832(8)
	lis 29,gi@ha
	lis 3,.LC13@ha
	la 29,gi@l(29)
	la 3,.LC13@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 6,.LC15@ha
	lwz 0,16(29)
	lis 9,.LC15@ha
	la 6,.LC15@l(6)
	mr 5,3
	lfs 1,0(6)
	la 9,.LC15@l(9)
	li 4,3
	mtlr 0
	lis 6,.LC16@ha
	mr 3,31
	lfs 2,0(9)
	la 6,.LC16@l(6)
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
.LC17:
	.string	"items/protect.wav"
	.align 3
.LC18:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC19:
	.long 0x43960000
	.align 2
.LC20:
	.long 0x3f800000
	.align 2
.LC21:
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
	lis 9,.LC18@ha
	lis 11,level@ha
	lwz 10,84(31)
	la 9,.LC18@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3836(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L153
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L155
.L153:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L155:
	stfs 0,3836(10)
	lis 29,gi@ha
	lis 3,.LC17@ha
	la 29,gi@l(29)
	la 3,.LC17@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC20@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC20@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 2,0(9)
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
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
.LC22:
	.string	"key_power_cube"
	.align 2
.LC23:
	.string	"Damage Amp"
	.align 2
.LC24:
	.string	"resist"
	.align 2
.LC25:
	.string	"boomerang"
	.align 2
.LC26:
	.string	"kots_boomerang"
	.align 2
.LC27:
	.string	"You got the boomerang\nTo use this type KOTSBOOMERANG\n"
	.align 2
.LC28:
	.string	"kots_damage_item"
	.align 2
.LC29:
	.string	"You got the damage amplifier\nTo drop this type DROP SPECIAL\n"
	.align 2
.LC30:
	.string	"kots_resist_item"
	.align 2
.LC31:
	.string	"You got the damage dampner\nTo drop this type DROP SPECIAL\n"
	.align 2
.LC32:
	.long 0x0
	.section	".text"
	.align 2
	.globl Pickup_Key
	.type	 Pickup_Key,@function
Pickup_Key:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 11,.LC32@ha
	lis 9,coop@ha
	la 11,.LC32@l(11)
	mr 28,3
	lfs 13,0(11)
	mr 29,4
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L158
	lwz 3,280(28)
	lis 4,.LC22@ha
	la 4,.LC22@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L159
	lwz 10,84(29)
	lbz 9,286(28)
	lwz 0,1796(10)
	and. 11,0,9
	bc 4,2,.L190
	lwz 0,648(28)
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
	lwz 11,84(29)
	lbz 9,286(28)
	lwz 0,1796(11)
	or 0,0,9
	stw 0,1796(11)
	b .L161
.L159:
	lwz 11,648(28)
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,84(29)
	subf 11,9,11
	mullw 11,11,0
	addi 4,10,740
	rlwinm 3,11,0,0,29
	lwzx 0,4,3
	cmpwi 0,0,0
	bc 4,2,.L190
	li 0,1
	stwx 0,4,3
.L161:
	li 3,1
	b .L196
.L197:
	mr 0,31
	b .L170
.L198:
	mr 0,31
	b .L178
.L199:
	mr 11,31
	b .L186
.L158:
	lis 9,game@ha
	li 30,0
	lwz 25,84(29)
	la 10,game@l(9)
	lis 11,.LC23@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC23@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L171
	mr 27,10
.L166:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L168
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L197
.L168:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L166
.L171:
	li 0,0
.L170:
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
	bc 12,1,.L163
	lis 9,game@ha
	li 30,0
	lwz 25,84(29)
	la 9,game@l(9)
	lis 11,.LC24@ha
	lwz 0,1556(9)
	la 26,.LC24@l(11)
	mr 31,10
	cmpw 0,30,0
	bc 4,0,.L179
	mr 27,9
.L174:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L176
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L198
.L176:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L174
.L179:
	li 0,0
.L178:
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
	bc 12,1,.L163
	lis 9,game@ha
	li 30,0
	lwz 25,84(29)
	la 9,game@l(9)
	lis 11,.LC25@ha
	lwz 0,1556(9)
	la 26,.LC25@l(11)
	mr 31,10
	cmpw 0,30,0
	bc 4,0,.L187
	mr 27,9
.L182:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L184
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L199
.L184:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L182
.L187:
	li 11,0
.L186:
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,11
	li 10,0
	mullw 9,9,0
	addi 11,25,740
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,1,.L188
.L163:
	li 10,1
.L188:
	cmpwi 0,10,0
	bc 4,2,.L190
	lwz 9,84(29)
	lwz 0,1860(9)
	cmpwi 0,0,24
	bc 4,1,.L189
.L190:
	li 3,0
	b .L196
.L189:
	lwz 3,280(28)
	lis 4,.LC26@ha
	la 4,.LC26@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L192
	lis 9,gi+8@ha
	lis 5,.LC27@ha
	lwz 0,gi+8@l(9)
	la 5,.LC27@l(5)
	mr 3,29
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L193
.L192:
	lwz 3,280(28)
	lis 4,.LC28@ha
	la 4,.LC28@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L193
	lis 9,gi+8@ha
	lis 5,.LC29@ha
	lwz 0,gi+8@l(9)
	la 5,.LC29@l(5)
	mr 3,29
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
.L193:
	lwz 3,280(28)
	lis 4,.LC30@ha
	la 4,.LC30@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L195
	lis 9,gi+8@ha
	lis 5,.LC31@ha
	lwz 0,gi+8@l(9)
	la 5,.LC31@l(5)
	mr 3,29
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,464(29)
.L195:
	lwz 0,648(28)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	lwz 10,84(29)
	subf 0,9,0
	li 3,1
	mullw 0,0,11
	addi 10,10,740
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
.L196:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 Pickup_Key,.Lfe6-Pickup_Key
	.align 2
	.globl Add_Ammo
	.type	 Add_Ammo,@function
Add_Ammo:
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 4,2,.L201
.L217:
	li 3,0
	blr
.L201:
	lwz 0,68(4)
	cmpwi 0,0,0
	bc 4,2,.L202
	lwz 10,1764(9)
	b .L203
.L202:
	cmpwi 0,0,1
	bc 4,2,.L204
	lwz 10,1768(9)
	b .L203
.L204:
	cmpwi 0,0,2
	bc 4,2,.L206
	lwz 10,1772(9)
	b .L203
.L206:
	cmpwi 0,0,3
	bc 4,2,.L208
	lwz 10,1776(9)
	b .L203
.L208:
	cmpwi 0,0,4
	bc 4,2,.L210
	lwz 10,1780(9)
	b .L203
.L210:
	cmpwi 0,0,5
	bc 4,2,.L217
	lwz 10,1784(9)
.L203:
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
	bc 12,2,.L217
	add 0,0,5
	stwx 0,11,4
	lwz 9,84(3)
	addi 3,9,740
	lwzx 0,3,4
	cmpw 0,0,10
	bc 4,1,.L215
	stwx 10,3,4
.L215:
	li 3,1
	blr
.Lfe7:
	.size	 Add_Ammo,.Lfe7-Add_Ammo
	.section	".rodata"
	.align 2
.LC33:
	.long 0x0
	.align 2
.LC34:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl Pickup_Ammo
	.type	 Pickup_Ammo,@function
Pickup_Ammo:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	mr 3,4
	lwz 4,648(31)
	lwz 0,56(4)
	andi. 9,0,1
	bc 12,2,.L219
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,8192
	li 5,1000
	bc 4,2,.L220
.L219:
	lwz 5,532(31)
	cmpwi 0,5,0
	bc 12,2,.L221
	lwz 4,648(31)
	b .L220
.L221:
	lwz 9,648(31)
	lwz 5,48(9)
	mr 4,9
.L220:
	bl Add_Ammo
	cmpwi 0,3,0
	bc 4,2,.L223
	li 3,0
	b .L226
.L223:
	lwz 0,284(31)
	andis. 7,0,0x3
	bc 4,2,.L224
	lis 9,.LC33@ha
	lis 11,deathmatch@ha
	la 9,.LC33@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L224
	lwz 9,264(31)
	lis 11,.LC34@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC34@l(11)
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
.L224:
	li 3,1
.L226:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 Pickup_Ammo,.Lfe8-Pickup_Ammo
	.section	".rodata"
	.align 2
.LC35:
	.string	"Can't drop current weapon\n"
	.align 2
.LC36:
	.long 0x40a00000
	.align 2
.LC37:
	.long 0x0
	.align 2
.LC38:
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
	bc 4,2,.L237
	lwz 9,480(30)
	lwz 0,484(30)
	cmpw 0,9,0
	li 3,0
	bc 4,0,.L247
.L237:
	lwz 3,532(31)
	cmpwi 0,3,2
	bc 4,2,.L239
	mr 3,30
	bl KOTSModKarma
	slwi 3,3,1
.L239:
	lwz 0,480(30)
	add 3,0,3
	stw 3,480(30)
	lwz 0,644(31)
	andi. 8,0,1
	bc 4,2,.L240
	lwz 0,484(30)
	cmpw 0,3,0
	bc 4,1,.L240
	stw 0,480(30)
.L240:
	lwz 0,484(30)
	lwz 9,480(30)
	add 0,0,0
	cmpw 0,9,0
	bc 4,1,.L242
	stw 0,480(30)
.L242:
	lwz 0,644(31)
	andi. 9,0,2
	bc 12,2,.L243
	lis 9,MegaHealth_think@ha
	lis 8,.LC36@ha
	lwz 11,264(31)
	la 9,MegaHealth_think@l(9)
	lis 10,level+4@ha
	lwz 0,184(31)
	stw 9,436(31)
	la 8,.LC36@l(8)
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
	b .L244
.L243:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L244
	lis 9,.LC37@ha
	lis 11,deathmatch@ha
	la 9,.LC37@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L244
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
.L244:
	li 3,1
.L247:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 Pickup_Health,.Lfe9-Pickup_Health
	.align 2
	.globl Pickup_Armor
	.type	 Pickup_Armor,@function
Pickup_Armor:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl KOTSPickup_Armor
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
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
	bc 12,2,.L282
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
	b .L281
.L293:
	mr 10,29
	b .L290
.L282:
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lis 11,.LC40@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC40@l(11)
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L291
	mr 28,10
.L286:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L288
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L293
.L288:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,76
	cmpw 0,31,0
	bc 12,0,.L286
.L291:
	li 10,0
.L290:
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
	bc 4,2,.L292
	lis 9,gi+8@ha
	lis 5,.LC41@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC41@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L281
.L292:
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
.L281:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 Use_PowerArmor,.Lfe11-Use_PowerArmor
	.align 2
	.globl Pickup_PowerArmor
	.type	 Pickup_PowerArmor,@function
Pickup_PowerArmor:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl KOTSPickup_PowerArmor
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe12:
	.size	 Pickup_PowerArmor,.Lfe12-Pickup_PowerArmor
	.section	".rodata"
	.align 2
.LC45:
	.string	"items/s_health.wav"
	.align 2
.LC46:
	.string	"items/n_health.wav"
	.align 2
.LC47:
	.string	"items/l_health.wav"
	.align 2
.LC48:
	.string	"items/m_health.wav"
	.align 3
.LC49:
	.long 0x40080000
	.long 0x0
	.align 2
.LC50:
	.long 0x3f800000
	.align 2
.LC51:
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
	mr 31,4
	mr 30,3
	lwz 3,280(31)
	lis 29,.LC25@ha
	la 4,.LC25@l(29)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L303
	lwz 31,256(31)
.L303:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L304
	lwz 3,280(31)
	la 4,.LC25@l(29)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L302
.L304:
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 12,1,.L305
	lwz 3,280(31)
	la 4,.LC25@l(29)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L302
.L305:
	lwz 9,648(30)
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 12,2,.L302
	mr 3,30
	mr 4,31
	mtlr 0
	blrl
	mr. 28,3
	bc 12,2,.L307
	lwz 11,84(31)
	lis 0,0x3e80
	lis 9,gi@ha
	la 29,gi@l(9)
	stw 0,3744(11)
	lwz 9,648(30)
	lwz 11,40(29)
	lwz 3,36(9)
	mtlr 11
	blrl
	lwz 9,84(31)
	lis 11,itemlist@ha
	lis 0,0x286b
	la 11,itemlist@l(11)
	ori 0,0,51739
	sth 3,134(9)
	lis 8,level+4@ha
	lis 9,.LC49@ha
	lwz 10,84(31)
	mr 3,31
	la 9,.LC49@l(9)
	lfd 13,0(9)
	lwz 9,648(30)
	subf 9,11,9
	mullw 9,9,0
	srawi 9,9,2
	addi 9,9,1056
	sth 9,136(10)
	lfs 0,level+4@l(8)
	lwz 9,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3864(9)
	bl KOTSSilentPickup
	cmpwi 0,3,0
	bc 4,2,.L307
	lwz 3,648(30)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	lwz 0,4(3)
	cmpw 0,0,9
	bc 4,2,.L309
	lwz 0,532(30)
	cmpwi 0,0,2
	bc 4,2,.L310
	lwz 9,36(29)
	lis 3,.LC45@ha
	la 3,.LC45@l(3)
	b .L324
.L310:
	cmpwi 0,0,10
	bc 4,2,.L312
	lwz 9,36(29)
	lis 3,.LC46@ha
	la 3,.LC46@l(3)
	b .L324
.L312:
	cmpwi 0,0,25
	bc 4,2,.L314
	lwz 9,36(29)
	lis 3,.LC47@ha
	la 3,.LC47@l(3)
	b .L324
.L314:
	lwz 9,36(29)
	lis 3,.LC48@ha
	la 3,.LC48@l(3)
.L324:
	mtlr 9
	blrl
	lis 9,.LC50@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC50@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 2,0(9)
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 3,0(9)
	blrl
	b .L307
.L309:
	lwz 3,20(3)
	cmpwi 0,3,0
	bc 12,2,.L307
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC50@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC50@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 2,0(9)
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 3,0(9)
	blrl
.L307:
	lwz 0,284(30)
	andis. 9,0,4
	bc 4,2,.L318
	mr 4,31
	mr 3,30
	bl G_UseTargets
	lwz 0,284(30)
	oris 0,0,0x4
	stw 0,284(30)
.L318:
	cmpwi 0,28,0
	bc 12,2,.L302
	lis 9,.LC51@ha
	lis 11,coop@ha
	la 9,.LC51@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L321
	lwz 9,648(30)
	lwz 0,56(9)
	andi. 9,0,8
	bc 12,2,.L321
	lwz 0,284(30)
	andis. 9,0,0x3
	bc 12,2,.L302
.L321:
	lwz 0,264(30)
	cmpwi 0,0,0
	bc 4,0,.L322
	rlwinm 0,0,0,1,31
	stw 0,264(30)
	b .L302
.L322:
	mr 3,30
	bl G_FreeEdict
.L302:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 Touch_Item,.Lfe13-Touch_Item
	.section	".rodata"
	.align 2
.LC52:
	.long 0x42c80000
	.align 2
.LC53:
	.long 0x40400000
	.align 2
.LC54:
	.long 0x40a00000
	.align 2
.LC55:
	.long 0xc0800000
	.align 2
.LC56:
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
	bc 12,2,.L331
	addi 29,1,24
	addi 4,1,8
	addi 3,3,3760
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
	b .L341
.L331:
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
.L341:
	stfs 0,12(31)
	lis 9,.LC52@ha
	addi 3,1,8
	la 9,.LC52@l(9)
	addi 4,31,376
	lfs 1,0(9)
	bl VectorScale
	lis 0,0x4396
	lwz 3,280(31)
	lis 4,.LC28@ha
	stw 0,384(31)
	la 4,.LC28@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L333
	lis 9,.LC53@ha
	lfs 0,380(31)
	la 9,.LC53@l(9)
	lwz 0,68(31)
	lfs 13,0(9)
	lwz 9,64(31)
	ori 0,0,1024
	b .L343
.L333:
	lwz 3,280(31)
	lis 4,.LC26@ha
	la 4,.LC26@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L336
	lis 9,.LC53@ha
	lfs 0,380(31)
	la 9,.LC53@l(9)
	lwz 0,68(31)
	lfs 13,0(9)
	lwz 9,64(31)
	ori 0,0,5120
	stw 0,68(31)
	fcmpu 0,0,13
	ori 9,9,256
	stw 9,64(31)
	bc 4,0,.L337
	stfs 13,380(31)
.L337:
	lis 11,.LC55@ha
	lfs 0,380(31)
	la 11,.LC55@l(11)
	b .L342
.L336:
	lwz 3,280(31)
	lis 4,.LC30@ha
	la 4,.LC30@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L335
	lis 9,.LC53@ha
	lfs 0,380(31)
	la 9,.LC53@l(9)
	lwz 0,68(31)
	lfs 13,0(9)
	lwz 9,64(31)
	ori 0,0,4096
.L343:
	stw 0,68(31)
	fcmpu 0,0,13
	ori 9,9,256
	stw 9,64(31)
	bc 4,0,.L340
	stfs 13,380(31)
.L340:
	lis 11,.LC54@ha
	lfs 0,380(31)
	la 11,.LC54@l(11)
.L342:
	lfs 13,384(31)
	lfs 12,0(11)
	fadds 13,13,13
	fmuls 0,0,12
	stfs 13,384(31)
	stfs 0,380(31)
.L335:
	lis 9,drop_make_touchable@ha
	lis 11,.LC56@ha
	la 9,drop_make_touchable@l(9)
	lis 10,level+4@ha
	stw 9,436(31)
	la 11,.LC56@l(11)
	mr 3,31
	lfs 13,0(11)
	lfs 0,level+4@l(10)
	lis 11,gi+72@ha
	fadds 0,0,13
	stfs 0,428(31)
	lwz 0,gi+72@l(11)
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
.LC57:
	.string	"droptofloor: %s startsolid at %s\n"
	.align 3
.LC58:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC59:
	.long 0xc1700000
	.align 2
.LC60:
	.long 0x41700000
	.align 2
.LC61:
	.long 0x0
	.align 2
.LC62:
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
	lis 9,.LC59@ha
	lis 11,.LC59@ha
	la 9,.LC59@l(9)
	la 11,.LC59@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC59@ha
	lfs 2,0(11)
	la 9,.LC59@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC60@ha
	lfs 13,0(11)
	la 9,.LC60@l(9)
	lfs 1,0(9)
	lis 9,.LC60@ha
	stfs 13,188(31)
	la 9,.LC60@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC60@ha
	stfs 0,192(31)
	la 9,.LC60@l(9)
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
	bc 12,2,.L348
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L349
.L348:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L349:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC61@ha
	stw 9,444(31)
	addi 29,31,4
	la 11,.LC61@l(11)
	lis 9,.LC62@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC62@l(9)
	lis 11,.LC61@ha
	lfs 3,0(9)
	la 11,.LC61@l(11)
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
	bc 12,2,.L350
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC57@ha
	la 3,.LC57@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L347
.L350:
	lwz 0,308(31)
	lfs 12,20(1)
	lfs 0,24(1)
	cmpwi 0,0,0
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L351
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
	bc 4,2,.L351
	lis 11,level+4@ha
	lis 10,.LC58@ha
	lfs 0,level+4@l(11)
	lis 9,DoRespawn@ha
	lfd 13,.LC58@l(10)
	la 9,DoRespawn@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L351:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L353
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
.L353:
	lwz 0,284(31)
	andi. 11,0,1
	bc 12,2,.L354
	lwz 0,184(31)
	lis 9,Use_Item@ha
	li 11,0
	la 9,Use_Item@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
.L354:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L347:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe15:
	.size	 droptofloor,.Lfe15-droptofloor
	.section	".rodata"
	.align 2
.LC63:
	.string	"PrecacheItem: %s has bad precache string"
	.align 2
.LC64:
	.string	"md2"
	.align 2
.LC65:
	.string	"sp2"
	.align 2
.LC66:
	.string	"wav"
	.align 2
.LC67:
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
	bc 12,2,.L355
	lwz 3,20(26)
	cmpwi 0,3,0
	bc 12,2,.L357
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L357:
	lwz 3,24(26)
	cmpwi 0,3,0
	bc 12,2,.L358
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L358:
	lwz 3,32(26)
	cmpwi 0,3,0
	bc 12,2,.L359
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L359:
	lwz 3,36(26)
	cmpwi 0,3,0
	bc 12,2,.L360
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
.L360:
	lwz 29,52(26)
	cmpwi 0,29,0
	bc 12,2,.L361
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L361
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L369
	mr 28,9
.L364:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L366
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L366
	mr 3,31
	b .L368
.L366:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L364
.L369:
	li 3,0
.L368:
	cmpw 0,3,26
	bc 12,2,.L361
	bl PrecacheItem
.L361:
	lwz 30,72(26)
	cmpwi 0,30,0
	bc 12,2,.L355
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 12,2,.L355
	lis 9,gi@ha
	addi 29,1,8
	la 27,gi@l(9)
	lis 24,.LC64@ha
	lis 25,.LC67@ha
.L375:
	rlwinm 9,0,0,0xff
	mr 31,30
	b .L389
.L378:
	lbzu 9,1(30)
.L389:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L378
	subf 28,31,30
	addi 0,28,-5
	cmplwi 0,0,58
	bc 4,1,.L380
	lwz 9,28(27)
	lis 3,.LC63@ha
	la 3,.LC63@l(3)
	lwz 4,0(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L380:
	mr 4,31
	mr 5,28
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 0,0
	addi 11,30,1
	stbx 0,29,28
	add 9,29,28
	la 4,.LC64@l(24)
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
	bc 12,2,.L390
	lis 4,.LC65@ha
	mr 3,31
	la 4,.LC65@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L384
.L390:
	lwz 9,32(27)
	mr 3,29
	mtlr 9
	blrl
	b .L383
.L384:
	lis 4,.LC66@ha
	mr 3,31
	la 4,.LC66@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L383
	lwz 9,36(27)
	mr 3,29
	mtlr 9
	blrl
.L383:
	add 3,29,28
	la 4,.LC67@l(25)
	addi 3,3,-3
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L373
	lwz 9,40(27)
	mr 3,29
	mtlr 9
	blrl
.L373:
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L375
.L355:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe16:
	.size	 PrecacheItem,.Lfe16-PrecacheItem
	.section	".rodata"
	.align 2
.LC68:
	.string	"%s at %s has invalid spawnflags set\n"
	.align 2
.LC69:
	.string	"weapon_bfg"
	.align 3
.LC70:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC71:
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
	bc 12,2,.L392
	lwz 3,280(31)
	lis 4,.LC22@ha
	la 4,.LC22@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L392
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
	lis 3,.LC68@ha
	la 3,.LC68@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L392:
	lis 9,.LC71@ha
	lis 11,deathmatch@ha
	la 9,.LC71@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L394
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2048
	bc 12,2,.L395
	lwz 0,4(30)
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L405
	lis 9,Pickup_PowerArmor@ha
	la 9,Pickup_PowerArmor@l(9)
	cmpw 0,0,9
	bc 12,2,.L405
.L395:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 12,2,.L398
	lwz 0,4(30)
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L405
.L398:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 12,2,.L400
	lwz 0,4(30)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L405
	lis 9,Pickup_Adrenaline@ha
	la 9,Pickup_Adrenaline@l(9)
	cmpw 0,0,9
	bc 12,2,.L405
	lis 9,Pickup_AncientHead@ha
	la 9,Pickup_AncientHead@l(9)
	cmpw 0,0,9
	bc 12,2,.L405
.L400:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8192
	bc 12,2,.L394
	lwz 0,56(30)
	cmpwi 0,0,2
	bc 12,2,.L405
	lwz 3,280(31)
	lis 4,.LC69@ha
	la 4,.LC69@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L394
.L405:
	mr 3,31
	bl G_FreeEdict
	b .L391
.L394:
	lis 11,.LC71@ha
	lis 9,coop@ha
	la 11,.LC71@l(11)
	lis 29,level@ha
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L406
	lwz 3,280(31)
	lis 4,.LC22@ha
	la 4,.LC22@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L406
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
.L406:
	lis 9,.LC71@ha
	lis 11,coop@ha
	la 9,.LC71@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L407
	lwz 0,56(30)
	andi. 11,0,8
	bc 12,2,.L407
	li 0,0
	stw 0,12(30)
.L407:
	stw 30,648(31)
	lis 11,level+4@ha
	lis 10,.LC70@ha
	lfs 0,level+4@l(11)
	lis 9,droptofloor@ha
	lfd 13,.LC70@l(10)
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
	bc 12,2,.L391
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L391:
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
	.long .LC72
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC73
	.long .LC74
	.long 1
	.long 0
	.long .LC75
	.long .LC76
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long bodyarmor_info
	.long 3
	.long .LC77
	.long .LC78
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC73
	.long .LC79
	.long 1
	.long 0
	.long .LC80
	.long .LC81
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long combatarmor_info
	.long 2
	.long .LC77
	.long .LC82
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC73
	.long .LC83
	.long 1
	.long 0
	.long .LC84
	.long .LC85
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long jacketarmor_info
	.long 1
	.long .LC77
	.long .LC86
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC87
	.long .LC88
	.long 1
	.long 0
	.long .LC84
	.long .LC89
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long 0
	.long 4
	.long .LC77
	.long .LC90
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC91
	.long .LC92
	.long 1
	.long 0
	.long .LC93
	.long .LC94
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC77
	.long .LC95
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC91
	.long .LC96
	.long 1
	.long 0
	.long .LC97
	.long .LC98
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC99
	.long .LC100
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Sword
	.long .LC101
	.long 0
	.long 0
	.long .LC77
	.long .LC102
	.long .LC103
	.long 0
	.long 0
	.long 0
	.long 9
	.long 1
	.long 0
	.long 0
	.long .LC104
	.long .LC105
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Shotgun
	.long .LC101
	.long .LC106
	.long 1
	.long .LC107
	.long .LC108
	.long .LC109
	.long 0
	.long 1
	.long .LC4
	.long 9
	.long 2
	.long 0
	.long 0
	.long .LC110
	.long .LC111
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_SuperShotgun
	.long .LC101
	.long .LC112
	.long 1
	.long .LC113
	.long .LC114
	.long .LC115
	.long 0
	.long 2
	.long .LC4
	.long 9
	.long 3
	.long 0
	.long 0
	.long .LC116
	.long .LC117
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Machinegun
	.long .LC101
	.long .LC118
	.long 1
	.long .LC119
	.long .LC120
	.long .LC121
	.long 0
	.long 1
	.long .LC3
	.long 9
	.long 4
	.long 0
	.long 0
	.long .LC122
	.long .LC123
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Chaingun
	.long .LC101
	.long .LC124
	.long 1
	.long .LC125
	.long .LC126
	.long .LC127
	.long 0
	.long 1
	.long .LC3
	.long 9
	.long 5
	.long 0
	.long 0
	.long .LC128
	.long .LC129
	.long Pickup_Ammo
	.long Use_Weapon
	.long Drop_Ammo
	.long Weapon_Grenade
	.long .LC130
	.long .LC131
	.long 0
	.long .LC132
	.long .LC133
	.long .LC8
	.long 3
	.long 5
	.long .LC134
	.long 3
	.long 6
	.long 0
	.long 3
	.long .LC135
	.long .LC136
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_GrenadeLauncher
	.long .LC101
	.long .LC137
	.long 1
	.long .LC138
	.long .LC139
	.long .LC140
	.long 0
	.long 1
	.long .LC8
	.long 9
	.long 7
	.long 0
	.long 0
	.long .LC141
	.long .LC142
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_RocketLauncher
	.long .LC101
	.long .LC143
	.long 1
	.long .LC144
	.long .LC145
	.long .LC146
	.long 0
	.long 1
	.long .LC9
	.long 9
	.long 8
	.long 0
	.long 0
	.long .LC147
	.long .LC148
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_HyperBlaster
	.long .LC101
	.long .LC149
	.long 1
	.long .LC150
	.long .LC151
	.long .LC152
	.long 0
	.long 1
	.long .LC7
	.long 9
	.long 9
	.long 0
	.long 0
	.long .LC153
	.long .LC154
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Railgun
	.long .LC101
	.long .LC155
	.long 1
	.long .LC156
	.long .LC157
	.long .LC158
	.long 0
	.long 1
	.long .LC10
	.long 9
	.long 10
	.long 0
	.long 0
	.long .LC159
	.long .LC69
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_BFG
	.long .LC101
	.long .LC160
	.long 1
	.long .LC161
	.long .LC162
	.long .LC163
	.long 0
	.long 3
	.long .LC7
	.long 9
	.long 11
	.long 0
	.long 0
	.long .LC164
	.long .LC165
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC130
	.long .LC166
	.long 0
	.long 0
	.long .LC167
	.long .LC4
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 1
	.long .LC77
	.long .LC168
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC130
	.long .LC169
	.long 0
	.long 0
	.long .LC170
	.long .LC3
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC77
	.long .LC171
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC130
	.long .LC172
	.long 0
	.long 0
	.long .LC173
	.long .LC7
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long 4
	.long .LC77
	.long .LC174
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC130
	.long .LC175
	.long 0
	.long 0
	.long .LC176
	.long .LC9
	.long 3
	.long 5
	.long 0
	.long 2
	.long 0
	.long 0
	.long 2
	.long .LC77
	.long .LC177
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC130
	.long .LC178
	.long 0
	.long 0
	.long .LC179
	.long .LC10
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 5
	.long .LC77
	.long .LC180
	.long Pickup_Powerup
	.long Use_Quad
	.long Drop_General
	.long 0
	.long .LC181
	.long .LC182
	.long 1
	.long 0
	.long .LC183
	.long .LC184
	.long 2
	.long 400
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC185
	.long .LC186
	.long Pickup_Powerup
	.long Use_Invulnerability
	.long Drop_General
	.long 0
	.long .LC181
	.long .LC187
	.long 1
	.long 0
	.long .LC188
	.long .LC189
	.long 2
	.long 400
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC190
	.long .LC191
	.long Pickup_Powerup
	.long Use_Silencer
	.long Drop_General
	.long 0
	.long .LC181
	.long .LC192
	.long 1
	.long 0
	.long .LC193
	.long .LC194
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC77
	.long .LC195
	.long Pickup_Powerup
	.long Use_Breather
	.long Drop_General
	.long 0
	.long .LC181
	.long .LC196
	.long 1
	.long 0
	.long .LC197
	.long .LC198
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long 0
	.long .LC199
	.long .LC200
	.long Pickup_Powerup
	.long Use_Envirosuit
	.long Drop_General
	.long 0
	.long .LC181
	.long .LC201
	.long 1
	.long 0
	.long .LC202
	.long .LC203
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long 0
	.long .LC199
	.long .LC204
	.long Pickup_AncientHead
	.long 0
	.long 0
	.long 0
	.long .LC181
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
	.long 0
	.long .LC77
	.long .LC208
	.long Pickup_Adrenaline
	.long 0
	.long 0
	.long 0
	.long .LC181
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
	.long .LC77
	.long .LC212
	.long Pickup_Bandolier
	.long 0
	.long 0
	.long 0
	.long .LC181
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
	.long .LC77
	.long .LC216
	.long Pickup_Pack
	.long 0
	.long 0
	.long 0
	.long .LC181
	.long .LC217
	.long 1
	.long 0
	.long .LC218
	.long .LC219
	.long 2
	.long 80
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC77
	.long .LC220
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC181
	.long .LC221
	.long 1
	.long 0
	.long .LC222
	.long .LC223
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC77
	.long .LC22
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC181
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
	.long 0
	.long .LC77
	.long .LC227
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC181
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
	.long .LC77
	.long .LC231
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC181
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
	.long .LC77
	.long .LC235
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC181
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
	.long .LC77
	.long .LC239
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC181
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
	.long .LC77
	.long .LC243
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC181
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
	.long .LC77
	.long .LC247
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC181
	.long .LC248
	.long 2
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
	.long .LC77
	.long .LC251
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC181
	.long .LC252
	.long 1
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
	.long .LC77
	.long 0
	.long Pickup_Health
	.long 0
	.long 0
	.long 0
	.long .LC181
	.long 0
	.long 0
	.long 0
	.long .LC255
	.long .LC256
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC257
	.long 0
	.long 0
	.long KOTS_Use_T_Ball
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC229
	.long .LC258
	.long 3
	.long 1
	.long 0
	.long 8
	.long 0
	.long 0
	.long 0
	.long .LC135
	.long .LC259
	.long KOTSPickup_KOTSPack
	.long 0
	.long 0
	.long 0
	.long .LC181
	.long .LC217
	.long 2
	.long 0
	.long .LC218
	.long .LC260
	.long 2
	.long 180
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC77
	.long .LC261
	.long KOTSPickup_KOTSExPack
	.long 0
	.long 0
	.long 0
	.long .LC181
	.long .LC217
	.long 2097152
	.long 0
	.long .LC218
	.long .LC262
	.long 2
	.long 180
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC77
	.long .LC28
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC181
	.long .LC263
	.long 1
	.long 0
	.long .LC206
	.long .LC23
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC77
	.long .LC30
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC181
	.long .LC263
	.long 1
	.long 0
	.long .LC206
	.long .LC24
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC77
	.long .LC26
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC181
	.long .LC221
	.long 1
	.long 0
	.long .LC222
	.long .LC25
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC77
	.long 0
	.space	72
	.section	".rodata"
	.align 2
.LC263:
	.string	"models/items/ammo/nuke/tris.md2"
	.align 2
.LC262:
	.string	"KOTS ExPack"
	.align 2
.LC261:
	.string	"item_kotsexpack"
	.align 2
.LC260:
	.string	"KOTS Pack"
	.align 2
.LC259:
	.string	"item_kotspack"
	.align 2
.LC258:
	.string	"tball"
	.align 2
.LC257:
	.string	"items/s_health.wav items/n_health.wav items/l_health.wav items/m_health.wav"
	.align 2
.LC256:
	.string	"Health"
	.align 2
.LC255:
	.string	"i_health"
	.align 2
.LC254:
	.string	"Airstrike Marker"
	.align 2
.LC253:
	.string	"i_airstrike"
	.align 2
.LC252:
	.string	"models/items/keys/target/tris.md2"
	.align 2
.LC251:
	.string	"key_airstrike_target"
	.align 2
.LC250:
	.string	"Commander's Head"
	.align 2
.LC249:
	.string	"k_comhead"
	.align 2
.LC248:
	.string	"models/monsters/commandr/head/tris.md2"
	.align 2
.LC247:
	.string	"key_commander_head"
	.align 2
.LC246:
	.string	"Red Key"
	.align 2
.LC245:
	.string	"k_redkey"
	.align 2
.LC244:
	.string	"models/items/keys/red_key/tris.md2"
	.align 2
.LC243:
	.string	"key_red_key"
	.align 2
.LC242:
	.string	"Blue Key"
	.align 2
.LC241:
	.string	"k_bluekey"
	.align 2
.LC240:
	.string	"models/items/keys/key/tris.md2"
	.align 2
.LC239:
	.string	"key_blue_key"
	.align 2
.LC238:
	.string	"Security Pass"
	.align 2
.LC237:
	.string	"k_security"
	.align 2
.LC236:
	.string	"models/items/keys/pass/tris.md2"
	.align 2
.LC235:
	.string	"key_pass"
	.align 2
.LC234:
	.string	"Data Spinner"
	.align 2
.LC233:
	.string	"k_dataspin"
	.align 2
.LC232:
	.string	"models/items/keys/spinner/tris.md2"
	.align 2
.LC231:
	.string	"key_data_spinner"
	.align 2
.LC230:
	.string	"Pyramid Key"
	.align 2
.LC229:
	.string	"k_pyramid"
	.align 2
.LC228:
	.string	"models/items/keys/pyramid/tris.md2"
	.align 2
.LC227:
	.string	"key_pyramid"
	.align 2
.LC226:
	.string	"Power Cube"
	.align 2
.LC225:
	.string	"k_powercube"
	.align 2
.LC224:
	.string	"models/items/keys/power/tris.md2"
	.align 2
.LC223:
	.string	"Data CD"
	.align 2
.LC222:
	.string	"k_datacd"
	.align 2
.LC221:
	.string	"models/items/keys/data_cd/tris.md2"
	.align 2
.LC220:
	.string	"key_data_cd"
	.align 2
.LC219:
	.string	"Ammo Pack"
	.align 2
.LC218:
	.string	"i_pack"
	.align 2
.LC217:
	.string	"models/items/pack/tris.md2"
	.align 2
.LC216:
	.string	"item_pack"
	.align 2
.LC215:
	.string	"Bandolier"
	.align 2
.LC214:
	.string	"p_bandolier"
	.align 2
.LC213:
	.string	"models/items/band/tris.md2"
	.align 2
.LC212:
	.string	"item_bandolier"
	.align 2
.LC211:
	.string	"Adrenaline"
	.align 2
.LC210:
	.string	"p_adrenaline"
	.align 2
.LC209:
	.string	"models/items/adrenal/tris.md2"
	.align 2
.LC208:
	.string	"item_adrenaline"
	.align 2
.LC207:
	.string	"Ancient Head"
	.align 2
.LC206:
	.string	"i_fixme"
	.align 2
.LC205:
	.string	"models/items/c_head/tris.md2"
	.align 2
.LC204:
	.string	"item_ancient_head"
	.align 2
.LC203:
	.string	"Environment Suit"
	.align 2
.LC202:
	.string	"p_envirosuit"
	.align 2
.LC201:
	.string	"models/items/enviro/tris.md2"
	.align 2
.LC200:
	.string	"item_enviro"
	.align 2
.LC199:
	.string	"items/airout.wav"
	.align 2
.LC198:
	.string	"Rebreather"
	.align 2
.LC197:
	.string	"p_rebreather"
	.align 2
.LC196:
	.string	"models/items/breather/tris.md2"
	.align 2
.LC195:
	.string	"item_breather"
	.align 2
.LC194:
	.string	"Silencer"
	.align 2
.LC193:
	.string	"p_silencer"
	.align 2
.LC192:
	.string	"models/items/silencer/tris.md2"
	.align 2
.LC191:
	.string	"item_silencer"
	.align 2
.LC190:
	.string	"items/protect.wav items/protect2.wav items/protect4.wav"
	.align 2
.LC189:
	.string	"Invulnerability"
	.align 2
.LC188:
	.string	"p_invulnerability"
	.align 2
.LC187:
	.string	"models/items/invulner/tris.md2"
	.align 2
.LC186:
	.string	"item_invulnerability"
	.align 2
.LC185:
	.string	"items/damage.wav items/damage2.wav items/damage3.wav"
	.align 2
.LC184:
	.string	"Quad Damage"
	.align 2
.LC183:
	.string	"p_quad"
	.align 2
.LC182:
	.string	"models/items/quaddama/tris.md2"
	.align 2
.LC181:
	.string	"items/pkup.wav"
	.align 2
.LC180:
	.string	"item_quad"
	.align 2
.LC179:
	.string	"a_slugs"
	.align 2
.LC178:
	.string	"models/items/ammo/slugs/medium/tris.md2"
	.align 2
.LC177:
	.string	"ammo_slugs"
	.align 2
.LC176:
	.string	"a_rockets"
	.align 2
.LC175:
	.string	"models/items/ammo/rockets/medium/tris.md2"
	.align 2
.LC174:
	.string	"ammo_rockets"
	.align 2
.LC173:
	.string	"a_cells"
	.align 2
.LC172:
	.string	"models/items/ammo/cells/medium/tris.md2"
	.align 2
.LC171:
	.string	"ammo_cells"
	.align 2
.LC170:
	.string	"a_bullets"
	.align 2
.LC169:
	.string	"models/items/ammo/bullets/medium/tris.md2"
	.align 2
.LC168:
	.string	"ammo_bullets"
	.align 2
.LC167:
	.string	"a_shells"
	.align 2
.LC166:
	.string	"models/items/ammo/shells/medium/tris.md2"
	.align 2
.LC165:
	.string	"ammo_shells"
	.align 2
.LC164:
	.string	"sprites/s_bfg1.sp2 sprites/s_bfg2.sp2 sprites/s_bfg3.sp2 weapons/bfg__f1y.wav weapons/bfg__l1a.wav weapons/bfg__x1b.wav weapons/bfg_hum.wav"
	.align 2
.LC163:
	.string	"BFG10K"
	.align 2
.LC162:
	.string	"w_bfg"
	.align 2
.LC161:
	.string	"models/weapons/v_bfg/tris.md2"
	.align 2
.LC160:
	.string	"models/weapons/g_bfg/tris.md2"
	.align 2
.LC159:
	.string	"weapons/rg_hum.wav"
	.align 2
.LC158:
	.string	"Railgun"
	.align 2
.LC157:
	.string	"w_railgun"
	.align 2
.LC156:
	.string	"models/weapons/v_rail/tris.md2"
	.align 2
.LC155:
	.string	"models/weapons/g_rail/tris.md2"
	.align 2
.LC154:
	.string	"weapon_railgun"
	.align 2
.LC153:
	.string	"weapons/hyprbu1a.wav weapons/hyprbl1a.wav weapons/hyprbf1a.wav weapons/hyprbd1a.wav misc/lasfly.wav"
	.align 2
.LC152:
	.string	"HyperBlaster"
	.align 2
.LC151:
	.string	"w_hyperblaster"
	.align 2
.LC150:
	.string	"models/weapons/v_hyperb/tris.md2"
	.align 2
.LC149:
	.string	"models/weapons/g_hyperb/tris.md2"
	.align 2
.LC148:
	.string	"weapon_hyperblaster"
	.align 2
.LC147:
	.string	"models/objects/rocket/tris.md2 weapons/rockfly.wav weapons/rocklf1a.wav weapons/rocklr1b.wav models/objects/debris2/tris.md2"
	.align 2
.LC146:
	.string	"Rocket Launcher"
	.align 2
.LC145:
	.string	"w_rlauncher"
	.align 2
.LC144:
	.string	"models/weapons/v_rocket/tris.md2"
	.align 2
.LC143:
	.string	"models/weapons/g_rocket/tris.md2"
	.align 2
.LC142:
	.string	"weapon_rocketlauncher"
	.align 2
.LC141:
	.string	"models/objects/grenade/tris.md2 weapons/grenlf1a.wav weapons/grenlr1b.wav weapons/grenlb1b.wav"
	.align 2
.LC140:
	.string	"Grenade Launcher"
	.align 2
.LC139:
	.string	"w_glauncher"
	.align 2
.LC138:
	.string	"models/weapons/v_launch/tris.md2"
	.align 2
.LC137:
	.string	"models/weapons/g_launch/tris.md2"
	.align 2
.LC136:
	.string	"weapon_grenadelauncher"
	.align 2
.LC135:
	.string	"weapons/hgrent1a.wav weapons/hgrena1b.wav weapons/hgrenc1b.wav weapons/hgrenb1a.wav weapons/hgrenb2a.wav "
	.align 2
.LC134:
	.string	"grenades"
	.align 2
.LC133:
	.string	"a_grenades"
	.align 2
.LC132:
	.string	"models/weapons/v_handgr/tris.md2"
	.align 2
.LC131:
	.string	"models/items/ammo/grenades/medium/tris.md2"
	.align 2
.LC130:
	.string	"misc/am_pkup.wav"
	.align 2
.LC129:
	.string	"ammo_grenades"
	.align 2
.LC128:
	.string	"weapons/chngnu1a.wav weapons/chngnl1a.wav weapons/machgf3b.wav` weapons/chngnd1a.wav"
	.align 2
.LC127:
	.string	"Chaingun"
	.align 2
.LC126:
	.string	"w_chaingun"
	.align 2
.LC125:
	.string	"models/weapons/v_chain/tris.md2"
	.align 2
.LC124:
	.string	"models/weapons/g_chain/tris.md2"
	.align 2
.LC123:
	.string	"weapon_chaingun"
	.align 2
.LC122:
	.string	"weapons/machgf1b.wav weapons/machgf2b.wav weapons/machgf3b.wav weapons/machgf4b.wav weapons/machgf5b.wav"
	.align 2
.LC121:
	.string	"Machinegun"
	.align 2
.LC120:
	.string	"w_machinegun"
	.align 2
.LC119:
	.string	"models/weapons/v_machn/tris.md2"
	.align 2
.LC118:
	.string	"models/weapons/g_machn/tris.md2"
	.align 2
.LC117:
	.string	"weapon_machinegun"
	.align 2
.LC116:
	.string	"weapons/sshotf1b.wav"
	.align 2
.LC115:
	.string	"Super Shotgun"
	.align 2
.LC114:
	.string	"w_sshotgun"
	.align 2
.LC113:
	.string	"models/weapons/v_shotg2/tris.md2"
	.align 2
.LC112:
	.string	"models/weapons/g_shotg2/tris.md2"
	.align 2
.LC111:
	.string	"weapon_supershotgun"
	.align 2
.LC110:
	.string	"weapons/shotgf1b.wav weapons/shotgr1b.wav"
	.align 2
.LC109:
	.string	"Shotgun"
	.align 2
.LC108:
	.string	"w_shotgun"
	.align 2
.LC107:
	.string	"models/weapons/v_shotg/tris.md2"
	.align 2
.LC106:
	.string	"models/weapons/g_shotg/tris.md2"
	.align 2
.LC105:
	.string	"weapon_shotgun"
	.align 2
.LC104:
	.string	"misc/fhit3.wav"
	.align 2
.LC103:
	.string	"Blaster"
	.align 2
.LC102:
	.string	"w_blaster"
	.align 2
.LC101:
	.string	"misc/w_pkup.wav"
	.align 2
.LC100:
	.string	"weapon_blaster"
	.align 2
.LC99:
	.string	"misc/power2.wav misc/power1.wav"
	.align 2
.LC98:
	.string	"Power Shield"
	.align 2
.LC97:
	.string	"i_powershield"
	.align 2
.LC96:
	.string	"models/items/armor/shield/tris.md2"
	.align 2
.LC95:
	.string	"item_power_shield"
	.align 2
.LC94:
	.string	"Power Screen"
	.align 2
.LC93:
	.string	"i_powerscreen"
	.align 2
.LC92:
	.string	"models/items/armor/screen/tris.md2"
	.align 2
.LC91:
	.string	"misc/ar3_pkup.wav"
	.align 2
.LC90:
	.string	"item_power_screen"
	.align 2
.LC89:
	.string	"Armor Shard"
	.align 2
.LC88:
	.string	"models/items/armor/shard/tris.md2"
	.align 2
.LC87:
	.string	"misc/ar2_pkup.wav"
	.align 2
.LC86:
	.string	"item_armor_shard"
	.align 2
.LC85:
	.string	"Jacket Armor"
	.align 2
.LC84:
	.string	"i_jacketarmor"
	.align 2
.LC83:
	.string	"models/items/armor/jacket/tris.md2"
	.align 2
.LC82:
	.string	"item_armor_jacket"
	.align 2
.LC81:
	.string	"Combat Armor"
	.align 2
.LC80:
	.string	"i_combatarmor"
	.align 2
.LC79:
	.string	"models/items/armor/combat/tris.md2"
	.align 2
.LC78:
	.string	"item_armor_combat"
	.align 2
.LC77:
	.string	""
	.align 2
.LC76:
	.string	"Body Armor"
	.align 2
.LC75:
	.string	"i_bodyarmor"
	.align 2
.LC74:
	.string	"models/items/armor/body/tris.md2"
	.align 2
.LC73:
	.string	"misc/ar1_pkup.wav"
	.align 2
.LC72:
	.string	"item_armor_body"
	.size	 itemlist,3724
	.align 2
.LC266:
	.string	"models/items/healing/medium/tris.md2"
	.align 2
.LC264:
	.long 0x46fffe00
	.align 3
.LC265:
	.long 0x3fd99999
	.long 0x9999999a
	.align 2
.LC267:
	.long 0x0
	.align 3
.LC268:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_item_health
	.type	 SP_item_health,@function
SP_item_health:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 11,.LC267@ha
	lis 9,deathmatch@ha
	la 11,.LC267@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L410
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L410
	bl G_FreeEdict
	b .L409
.L410:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC268@ha
	lis 10,.LC264@ha
	la 11,.LC268@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC265@ha
	lfs 11,.LC264@l(10)
	lfd 12,.LC265@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L411
	lis 9,level+308@ha
	lwz 0,level+308@l(9)
	cmpwi 7,0,2
	bc 12,29,.L411
	cmpwi 0,0,1
	bc 12,2,.L422
	bc 12,1,.L442
	cmpwi 0,0,0
	bc 12,2,.L413
	b .L409
.L442:
	bc 12,30,.L431
	b .L409
.L452:
	mr 4,30
	b .L420
.L413:
	lis 9,.LC221@ha
	lis 11,game@ha
	la 9,.LC221@l(9)
	la 10,game@l(11)
	stw 9,268(31)
	li 29,0
	lis 11,.LC25@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC25@l(11)
	la 30,itemlist@l(9)
	cmpw 0,29,0
	bc 4,0,.L421
	mr 28,10
.L416:
	lwz 3,40(30)
	cmpwi 0,3,0
	bc 12,2,.L418
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L452
.L418:
	lwz 0,1556(28)
	addi 29,29,1
	addi 30,30,76
	cmpw 0,29,0
	bc 12,0,.L416
.L421:
	li 4,0
.L420:
	mr 3,31
	bl SpawnItem
	lwz 9,64(31)
	lis 11,level@ha
	lis 10,.LC26@ha
	lwz 0,68(31)
	la 11,level@l(11)
	lis 6,0xc180
	ori 9,9,256
	lis 7,0x4180
	ori 0,0,5120
	stw 9,64(31)
	la 10,.LC26@l(10)
	stw 0,68(31)
	lis 8,0xc0e0
	lwz 9,308(11)
	lis 0,0x40e0
	addi 9,9,1
	stw 9,308(11)
	stw 0,208(31)
	stw 10,280(31)
	stw 6,192(31)
	stw 8,196(31)
	stw 7,204(31)
	stw 6,188(31)
	stw 7,200(31)
	b .L409
.L453:
	mr 4,30
	b .L429
.L422:
	lis 9,.LC263@ha
	lis 11,game@ha
	la 9,.LC263@l(9)
	la 10,game@l(11)
	stw 9,268(31)
	li 29,0
	lis 11,.LC24@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC24@l(11)
	la 30,itemlist@l(9)
	cmpw 0,29,0
	bc 4,0,.L430
	mr 28,10
.L425:
	lwz 3,40(30)
	cmpwi 0,3,0
	bc 12,2,.L427
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L453
.L427:
	lwz 0,1556(28)
	addi 29,29,1
	addi 30,30,76
	cmpw 0,29,0
	bc 12,0,.L425
.L430:
	li 4,0
.L429:
	mr 3,31
	bl SpawnItem
	lwz 9,64(31)
	lis 11,level@ha
	lis 7,.LC30@ha
	lwz 0,68(31)
	la 11,level@l(11)
	lis 8,0xc180
	ori 9,9,256
	lis 10,0x4180
	ori 0,0,4096
	stw 9,64(31)
	la 7,.LC30@l(7)
	b .L456
.L454:
	mr 4,30
	b .L438
.L431:
	lis 9,.LC263@ha
	lis 11,game@ha
	la 9,.LC263@l(9)
	la 10,game@l(11)
	stw 9,268(31)
	li 29,0
	lis 11,.LC23@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC23@l(11)
	la 30,itemlist@l(9)
	cmpw 0,29,0
	bc 4,0,.L439
	mr 28,10
.L434:
	lwz 3,40(30)
	cmpwi 0,3,0
	bc 12,2,.L436
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L454
.L436:
	lwz 0,1556(28)
	addi 29,29,1
	addi 30,30,76
	cmpw 0,29,0
	bc 12,0,.L434
.L439:
	li 4,0
.L438:
	mr 3,31
	bl SpawnItem
	lwz 9,64(31)
	lis 11,level@ha
	lis 7,.LC28@ha
	lwz 0,68(31)
	la 11,level@l(11)
	lis 8,0xc180
	ori 9,9,256
	lis 10,0x4180
	ori 0,0,1024
	stw 9,64(31)
	la 7,.LC28@l(7)
.L456:
	stw 0,68(31)
	lwz 9,308(11)
	addi 9,9,1
	stw 9,308(11)
	stw 10,208(31)
	stw 7,280(31)
	stw 8,196(31)
	stw 8,188(31)
	stw 8,192(31)
	stw 10,200(31)
	stw 10,204(31)
	b .L409
.L455:
	mr 4,30
	b .L450
.L411:
	lis 9,.LC266@ha
	li 0,10
	la 9,.LC266@l(9)
	lis 11,game@ha
	stw 0,532(31)
	la 10,game@l(11)
	stw 9,268(31)
	li 29,0
	lwz 0,1556(10)
	lis 9,.LC256@ha
	lis 11,itemlist@ha
	la 27,.LC256@l(9)
	la 30,itemlist@l(11)
	cmpw 0,29,0
	bc 4,0,.L451
	mr 28,10
.L446:
	lwz 3,40(30)
	cmpwi 0,3,0
	bc 12,2,.L448
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L455
.L448:
	lwz 0,1556(28)
	addi 29,29,1
	addi 30,30,76
	cmpw 0,29,0
	bc 12,0,.L446
.L451:
	li 4,0
.L450:
	mr 3,31
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC46@ha
	lwz 0,gi+36@l(9)
	la 3,.LC46@l(3)
	mtlr 0
	blrl
.L409:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 SP_item_health,.Lfe18-SP_item_health
	.section	".rodata"
	.align 2
.LC269:
	.string	"models/items/healing/stimpack/tris.md2"
	.align 2
.LC270:
	.string	"models/items/healing/large/tris.md2"
	.align 2
.LC271:
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
	bc 4,0,.L490
	lis 11,itemlist@ha
	lis 9,gi@ha
	la 11,itemlist@l(11)
	la 28,gi@l(9)
	mr 29,10
	addi 30,11,40
.L492:
	lwz 9,24(28)
	addi 3,31,1056
	lwz 4,0(30)
	addi 31,31,1
	mtlr 9
	addi 30,30,76
	blrl
	lwz 0,1556(29)
	cmpw 0,31,0
	bc 12,0,.L492
.L490:
	lis 9,game@ha
	lis 11,jacket_armor_index@ha
	la 10,game@l(9)
	li 30,0
	lwz 0,1556(10)
	la 27,jacket_armor_index@l(11)
	lis 9,.LC85@ha
	lis 11,itemlist@ha
	la 28,.LC85@l(9)
	cmpw 0,30,0
	la 31,itemlist@l(11)
	bc 4,0,.L501
	mr 29,10
.L496:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L498
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L498
	mr 11,31
	b .L500
.L498:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L496
.L501:
	li 11,0
.L500:
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
	lis 10,.LC81@ha
	la 26,combat_armor_index@l(9)
	srawi 11,11,2
	la 28,.LC81@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L509
	mr 29,7
.L504:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L506
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L506
	mr 11,31
	b .L508
.L506:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L504
.L509:
	li 11,0
.L508:
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
	lis 10,.LC76@ha
	la 27,body_armor_index@l(9)
	srawi 11,11,2
	la 28,.LC76@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L517
	mr 29,7
.L512:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L514
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L514
	mr 11,31
	b .L516
.L514:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L512
.L517:
	li 11,0
.L516:
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
	lis 10,.LC94@ha
	la 26,power_screen_index@l(9)
	srawi 11,11,2
	la 28,.LC94@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L525
	mr 29,7
.L520:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L522
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L522
	mr 11,31
	b .L524
.L522:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L520
.L525:
	li 11,0
.L524:
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
	lis 10,.LC98@ha
	la 27,power_shield_index@l(9)
	srawi 11,11,2
	la 28,.LC98@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L533
	mr 29,7
.L528:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L530
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L530
	mr 8,31
	b .L532
.L530:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L528
.L533:
	li 8,0
.L532:
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
.Lfe19:
	.size	 SetItemNames,.Lfe19-SetItemNames
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
	li 0,48
	stw 0,game+1556@l(9)
	blr
.Lfe20:
	.size	 InitItems,.Lfe20-InitItems
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
	b .L534
.L20:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L21
.L19:
	li 3,0
.L534:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 FindItem,.Lfe21-FindItem
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
	b .L535
.L12:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L13
.L11:
	li 3,0
.L535:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 FindItemByClassname,.Lfe22-FindItemByClassname
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
.Lfe23:
	.size	 SetRespawn,.Lfe23-SetRespawn
	.align 2
	.globl ArmorIndex
	.type	 ArmorIndex,@function
ArmorIndex:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L249
	li 3,0
	blr
.L249:
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
.Lfe24:
	.size	 ArmorIndex,.Lfe24-ArmorIndex
	.align 2
	.globl PowerArmorType
	.type	 PowerArmorType,@function
PowerArmorType:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L277
.L538:
	li 3,0
	blr
.L277:
	lwz 0,264(3)
	andi. 9,0,4096
	bc 12,2,.L538
	lis 9,power_shield_index@ha
	addi 11,11,740
	lwz 0,power_shield_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L279
	lis 9,power_screen_index@ha
	lwz 0,power_screen_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	srawi 3,9,31
	subf 3,9,3
	srwi 3,3,31
	blr
.L279:
	li 3,2
	blr
.Lfe25:
	.size	 PowerArmorType,.Lfe25-PowerArmorType
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
.Lfe26:
	.size	 GetItemByIndex,.Lfe26-GetItemByIndex
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
.Lfe27:
	.size	 DoRespawn,.Lfe27-DoRespawn
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
.Lfe28:
	.size	 Drop_General,.Lfe28-Drop_General
	.section	".rodata"
	.align 2
.LC272:
	.long 0x0
	.align 3
.LC273:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Adrenaline
	.type	 Pickup_Adrenaline,@function
Pickup_Adrenaline:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	lis 9,.LC272@ha
	lis 30,deathmatch@ha
	la 9,.LC272@l(9)
	mr 31,3
	lfs 31,0(9)
	mr 3,4
	lwz 9,deathmatch@l(30)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 4,2,.L47
	lwz 9,484(3)
	addi 9,9,1
	stw 9,484(3)
.L47:
	lwz 0,480(3)
	lwz 9,484(3)
	cmpw 0,0,9
	bc 4,0,.L48
	stw 9,480(3)
.L48:
	li 4,3
	bl KOTSPickup_Pack
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L49
	lwz 9,deathmatch@l(30)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L49
	lis 9,.LC273@ha
	lwz 11,648(31)
	la 9,.LC273@l(9)
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
	stw 9,12(1)
	ori 11,11,1
	stw 7,8(1)
	lfd 0,8(1)
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
.L49:
	li 3,1
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 Pickup_Adrenaline,.Lfe29-Pickup_Adrenaline
	.section	".rodata"
	.align 2
.LC274:
	.long 0x0
	.align 3
.LC275:
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
	bc 4,2,.L52
	lis 9,.LC274@ha
	lis 11,deathmatch@ha
	la 9,.LC274@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L52
	lis 9,.LC275@ha
	lwz 11,648(12)
	la 9,.LC275@l(9)
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
.L52:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 Pickup_AncientHead,.Lfe30-Pickup_AncientHead
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
	lis 9,.LC276@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC276@l(9)
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
	bc 4,1,.L147
	lis 9,.LC277@ha
	la 9,.LC277@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L540
.L147:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L540:
	stfs 0,3840(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe31:
	.size	 Use_Breather,.Lfe31-Use_Breather
	.section	".rodata"
	.align 3
.LC278:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC279:
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
	lis 9,.LC278@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC278@l(9)
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
	bc 4,1,.L150
	lis 9,.LC279@ha
	la 9,.LC279@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L541
.L150:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L541:
	stfs 0,3844(10)
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
	lwz 9,3856(11)
	addi 9,9,30
	stw 9,3856(11)
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
	bc 12,0,.L228
	stw 11,532(29)
	b .L229
.L228:
	stw 0,532(29)
.L229:
	lwz 9,84(31)
	slwi 11,28,2
	lwz 8,532(29)
	mr 10,9
	lwz 9,1788(9)
	cmpwi 0,9,0
	bc 12,2,.L230
	lwz 0,68(9)
	cmpwi 0,0,3
	bc 4,2,.L230
	lwz 0,68(30)
	cmpwi 0,0,3
	bc 4,2,.L230
	addi 9,10,740
	lwzx 0,9,11
	subf. 9,8,0
	bc 12,1,.L230
	lis 9,gi+8@ha
	lis 5,.LC35@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC35@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,29
	bl G_FreeEdict
	b .L227
.L230:
	addi 9,10,740
	mr 3,31
	lwzx 0,9,11
	subf 0,8,0
	stwx 0,9,11
	bl ValidateSelectedItem
.L227:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 Drop_Ammo,.Lfe34-Drop_Ammo
	.section	".rodata"
	.align 2
.LC280:
	.long 0x3f800000
	.align 2
.LC281:
	.long 0x0
	.align 2
.LC282:
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
	bc 4,1,.L232
	lis 10,.LC280@ha
	lis 9,level+4@ha
	la 10,.LC280@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(7)
	lwz 9,480(11)
	addi 9,9,-1
	stw 9,480(11)
	b .L231
.L232:
	lwz 0,284(7)
	andis. 6,0,0x1
	bc 4,2,.L233
	lis 9,.LC281@ha
	lis 11,deathmatch@ha
	la 9,.LC281@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L233
	lwz 9,264(7)
	lis 11,.LC282@ha
	lis 10,level+4@ha
	lwz 0,184(7)
	la 11,.LC282@l(11)
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
	b .L231
.L233:
	mr 3,7
	bl G_FreeEdict
.L231:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe35:
	.size	 MegaHealth_think,.Lfe35-MegaHealth_think
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
	bc 12,2,.L300
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
	bc 4,2,.L300
	bl Use_PowerArmor
.L300:
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
	bc 12,2,.L325
	bl Touch_Item
.L325:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 drop_temp_touch,.Lfe37-drop_temp_touch
	.section	".rodata"
	.align 2
.LC283:
	.long 0x0
	.align 2
.LC284:
	.long 0x41e80000
	.section	".text"
	.align 2
	.type	 drop_make_touchable,@function
drop_make_touchable:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,Touch_Item@ha
	lis 11,deathmatch@ha
	la 9,Touch_Item@l(9)
	lwz 10,deathmatch@l(11)
	mr 31,3
	stw 9,444(31)
	lis 9,.LC283@ha
	lfs 0,20(10)
	la 9,.LC283@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L328
	lwz 3,280(31)
	lis 4,.LC28@ha
	la 4,.LC28@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L328
	lwz 3,280(31)
	lis 4,.LC30@ha
	la 4,.LC30@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L328
	lwz 3,280(31)
	lis 4,.LC26@ha
	la 4,.LC26@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L328
	lis 9,.LC284@ha
	lis 11,level+4@ha
	la 9,.LC284@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,436(31)
	stfs 0,428(31)
.L328:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe38:
	.size	 drop_make_touchable,.Lfe38-drop_make_touchable
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
	bc 12,2,.L345
	li 0,2
	stw 11,444(3)
	stw 0,248(3)
	b .L346
.L345:
	lis 9,Touch_Item@ha
	li 0,1
	la 9,Touch_Item@l(9)
	stw 0,248(3)
	stw 9,444(3)
.L346:
	lis 9,gi+72@ha
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe39:
	.size	 Use_Item,.Lfe39-Use_Item
	.section	".rodata"
	.align 2
.LC285:
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
	lis 11,.LC285@ha
	lis 9,deathmatch@ha
	la 11,.LC285@l(11)
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
.L542:
	mr 4,31
	b .L465
.L458:
	lis 9,.LC269@ha
	li 0,2
	la 9,.LC269@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC256@ha
	lis 11,itemlist@ha
	la 27,.LC256@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L466
	mr 28,10
.L461:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L463
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L542
.L463:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L461
.L466:
	li 4,0
.L465:
	mr 3,29
	bl SpawnItem
	li 0,1
	lis 9,gi+36@ha
	stw 0,644(29)
	lis 3,.LC45@ha
	lwz 0,gi+36@l(9)
	la 3,.LC45@l(3)
	mtlr 0
	blrl
.L457:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe40:
	.size	 SP_item_health_small,.Lfe40-SP_item_health_small
	.section	".rodata"
	.align 2
.LC286:
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
	lis 11,.LC286@ha
	lis 9,deathmatch@ha
	la 11,.LC286@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L468
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L468
	bl G_FreeEdict
	b .L467
.L543:
	mr 4,31
	b .L475
.L468:
	lis 9,.LC270@ha
	li 0,25
	la 9,.LC270@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC256@ha
	lis 11,itemlist@ha
	la 27,.LC256@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L476
	mr 28,10
.L471:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L473
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L543
.L473:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L471
.L476:
	li 4,0
.L475:
	mr 3,29
	bl SpawnItem
.L467:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe41:
	.size	 SP_item_health_large,.Lfe41-SP_item_health_large
	.section	".rodata"
	.align 2
.LC287:
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
	lis 11,.LC287@ha
	lis 9,deathmatch@ha
	la 11,.LC287@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L478
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L478
	bl G_FreeEdict
	b .L477
.L544:
	mr 4,31
	b .L485
.L478:
	lis 9,.LC271@ha
	li 0,100
	la 9,.LC271@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC256@ha
	lis 11,itemlist@ha
	la 27,.LC256@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L486
	mr 28,10
.L481:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L483
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L544
.L483:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L481
.L486:
	li 4,0
.L485:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC48@ha
	lwz 0,gi+36@l(9)
	la 3,.LC48@l(3)
	mtlr 0
	blrl
	li 0,3
	stw 0,644(29)
.L477:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe42:
	.size	 SP_item_health_mega,.Lfe42-SP_item_health_mega
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
