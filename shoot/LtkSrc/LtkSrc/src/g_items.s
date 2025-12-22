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
	bc 12,2,.L42
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L43
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
.L43:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,16
	bc 4,2,.L46
	lwz 9,648(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L42
	lwz 0,284(31)
	andis. 7,0,2
	bc 12,2,.L42
.L46:
	lwz 9,648(31)
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
	lwz 9,648(31)
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
	.string	"Lasersight"
	.align 2
.LC6:
	.string	"Bandolier"
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Special
	.type	 Pickup_Special,@function
Pickup_Special:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,4
	lwz 7,84(31)
	lis 8,0x4330
	lis 11,.LC7@ha
	la 11,.LC7@l(11)
	mr 30,3
	lwz 0,4312(7)
	lfd 12,0(11)
	xoris 0,0,0x8000
	lis 11,unique_items@ha
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	lwz 10,unique_items@l(11)
	fsub 0,0,12
	lfs 13,20(10)
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L51
	li 3,0
	b .L63
.L51:
	lwz 0,648(30)
	lis 9,itemlist@ha
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	subf 0,9,0
	addi 8,7,740
	mullw 0,0,11
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,8,0
	addi 9,9,1
	stwx 9,8,0
	lwz 10,84(31)
	lwz 9,4312(10)
	addi 9,9,1
	stw 9,4312(10)
	lwz 11,648(30)
	lwz 3,40(11)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L53
	lwz 9,84(31)
	li 0,1
	mr 3,31
	stw 0,4392(9)
	lwz 4,648(30)
	bl SP_LaserSight
.L53:
	lwz 9,648(30)
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L52
	lwz 9,84(31)
	lwz 0,1764(9)
	cmpwi 0,0,3
	bc 12,1,.L55
	li 0,4
	stw 0,1764(9)
.L55:
	lwz 9,84(31)
	lwz 0,1768(9)
	cmpwi 0,0,27
	bc 12,1,.L56
	li 0,28
	stw 0,1768(9)
.L56:
	lwz 9,84(31)
	lwz 0,1780(9)
	cmpwi 0,0,1
	bc 12,1,.L57
	li 0,2
	stw 0,1780(9)
.L57:
	lwz 9,84(31)
	lwz 0,1784(9)
	cmpwi 0,0,39
	bc 12,1,.L58
	li 0,40
	stw 0,1784(9)
.L58:
	lwz 9,84(31)
	lwz 0,1776(9)
	cmpwi 0,0,5
	bc 12,1,.L59
	li 0,6
	stw 0,1776(9)
.L59:
	lwz 9,84(31)
	lwz 0,1772(9)
	cmpwi 0,0,3
	bc 12,1,.L60
	li 0,4
	stw 0,1772(9)
.L60:
	lwz 9,84(31)
	lwz 0,4276(9)
	cmpwi 0,0,19
	bc 12,1,.L61
	li 0,20
	stw 0,4276(9)
.L61:
	lwz 3,84(31)
	lwz 0,4280(3)
	cmpwi 0,0,3
	bc 12,1,.L52
	li 0,4
	stw 0,4280(3)
.L52:
	li 3,1
.L63:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Pickup_Special,.Lfe2-Pickup_Special
	.section	".rodata"
	.align 2
.LC8:
	.string	"Pistol Clip"
	.align 2
.LC9:
	.string	"12 Gauge Shells"
	.align 2
.LC10:
	.string	"M4 Clip"
	.align 2
.LC11:
	.string	"M26 Fragmentation Grenade"
	.align 2
.LC12:
	.string	"Machinegun Magazine"
	.align 2
.LC13:
	.string	"Combat Knife"
	.align 2
.LC14:
	.string	"AP Sniper Ammo"
	.align 2
.LC15:
	.string	"One of your guns is dropped with the bandolier.\n"
	.align 3
.LC16:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC17:
	.long 0x0
	.section	".text"
	.align 2
	.globl Drop_Special
	.type	 Drop_Special,@function
Drop_Special:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr 29,3
	mr 25,4
	lwz 11,84(29)
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	lwz 9,4312(11)
	addi 9,9,-1
	stw 9,4312(11)
	lwz 3,40(25)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L65
	lis 11,itemlist@ha
	lis 9,0x38e3
	lwz 10,84(29)
	la 8,itemlist@l(11)
	ori 9,9,36409
	subf 0,8,25
	addi 11,10,740
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,1
	bc 12,1,.L65
	li 0,2
	lis 9,game@ha
	la 11,game@l(9)
	stw 0,1764(10)
	li 30,0
	lwz 0,1556(11)
	lis 9,.LC8@ha
	mr 31,8
	lwz 26,84(29)
	la 27,.LC8@l(9)
	cmpw 0,30,0
	bc 4,0,.L74
	mr 28,11
.L69:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L71
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L71
	mr 0,31
	b .L73
.L71:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L69
.L74:
	li 0,0
.L73:
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 10,itemlist@l(11)
	ori 9,9,36409
	subf 0,10,0
	addi 11,26,740
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,2
	bc 4,1,.L66
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC8@ha
	lwz 0,1556(9)
	la 27,.LC8@l(11)
	mr 31,10
	cmpw 0,30,0
	bc 4,0,.L82
	mr 28,9
.L77:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L79
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L79
	mr 10,31
	b .L81
.L79:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L77
.L82:
	li 10,0
.L81:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	li 10,2
	srawi 9,9,3
	slwi 9,9,2
	stwx 10,11,9
.L66:
	lwz 11,84(29)
	li 0,14
	lis 9,game@ha
	la 10,game@l(9)
	li 30,0
	stw 0,1768(11)
	lis 9,.LC9@ha
	lwz 0,1556(10)
	lis 11,itemlist@ha
	la 27,.LC9@l(9)
	lwz 26,84(29)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L91
	mr 28,10
.L86:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L88
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L88
	mr 0,31
	b .L90
.L88:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L86
.L91:
	li 0,0
.L90:
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 10,itemlist@l(11)
	ori 9,9,36409
	subf 0,10,0
	addi 11,26,740
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,14
	bc 4,1,.L83
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC9@ha
	lwz 0,1556(9)
	la 27,.LC9@l(11)
	mr 31,10
	cmpw 0,30,0
	bc 4,0,.L99
	mr 28,9
.L94:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L96
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L96
	mr 10,31
	b .L98
.L96:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L94
.L99:
	li 10,0
.L98:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	li 10,14
	srawi 9,9,3
	slwi 9,9,2
	stwx 10,11,9
.L83:
	lwz 11,84(29)
	li 0,1
	lis 9,game@ha
	la 10,game@l(9)
	li 30,0
	stw 0,1780(11)
	lis 9,.LC10@ha
	lwz 0,1556(10)
	lis 11,itemlist@ha
	la 27,.LC10@l(9)
	lwz 26,84(29)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L108
	mr 28,10
.L103:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L105
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L105
	mr 0,31
	b .L107
.L105:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L103
.L108:
	li 0,0
.L107:
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 10,itemlist@l(11)
	ori 9,9,36409
	subf 0,10,0
	addi 11,26,740
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,1
	bc 4,1,.L100
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC10@ha
	lwz 0,1556(9)
	la 27,.LC10@l(11)
	mr 31,10
	cmpw 0,30,0
	bc 4,0,.L116
	mr 28,9
.L111:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L113
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L113
	mr 10,31
	b .L115
.L113:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L111
.L116:
	li 10,0
.L115:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	li 10,1
	srawi 9,9,3
	slwi 9,9,2
	stwx 10,11,9
.L100:
	lwz 11,84(29)
	li 0,2
	lis 9,game@ha
	la 10,game@l(9)
	li 30,0
	stw 0,4280(11)
	lis 9,.LC11@ha
	lwz 0,1556(10)
	lis 11,itemlist@ha
	la 27,.LC11@l(9)
	lwz 26,84(29)
	la 31,itemlist@l(11)
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
	mr 0,31
	b .L124
.L122:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L120
.L125:
	li 0,0
.L124:
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 10,itemlist@l(11)
	ori 9,9,36409
	subf 0,10,0
	addi 11,26,740
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,2
	bc 4,1,.L117
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC11@ha
	lwz 0,1556(9)
	la 27,.LC11@l(11)
	mr 31,10
	cmpw 0,30,0
	bc 4,0,.L133
	mr 28,9
.L128:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L130
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L130
	mr 10,31
	b .L132
.L130:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L128
.L133:
	li 10,0
.L132:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	li 10,2
	srawi 9,9,3
	slwi 9,9,2
	stwx 10,11,9
.L117:
	lwz 11,84(29)
	li 0,2
	lis 9,game@ha
	la 10,game@l(9)
	li 30,0
	stw 0,1772(11)
	lis 9,.LC12@ha
	lwz 0,1556(10)
	lis 11,itemlist@ha
	la 27,.LC12@l(9)
	lwz 26,84(29)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L142
	mr 28,10
.L137:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L139
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L139
	mr 0,31
	b .L141
.L139:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L137
.L142:
	li 0,0
.L141:
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 10,itemlist@l(11)
	ori 9,9,36409
	subf 0,10,0
	addi 11,26,740
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,2
	bc 4,1,.L134
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC12@ha
	lwz 0,1556(9)
	la 27,.LC12@l(11)
	mr 31,10
	cmpw 0,30,0
	bc 4,0,.L150
	mr 28,9
.L145:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L147
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L147
	mr 10,31
	b .L149
.L147:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L145
.L150:
	li 10,0
.L149:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	li 10,2
	srawi 9,9,3
	slwi 9,9,2
	stwx 10,11,9
.L134:
	lwz 11,84(29)
	li 0,10
	lis 9,game@ha
	la 10,game@l(9)
	li 30,0
	stw 0,4276(11)
	lis 9,.LC13@ha
	lwz 0,1556(10)
	lis 11,itemlist@ha
	la 27,.LC13@l(9)
	lwz 26,84(29)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L159
	mr 28,10
.L154:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L156
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L156
	mr 0,31
	b .L158
.L156:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L154
.L159:
	li 0,0
.L158:
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 10,itemlist@l(11)
	ori 9,9,36409
	subf 0,10,0
	addi 11,26,740
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,10
	bc 4,1,.L151
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC13@ha
	lwz 0,1556(9)
	la 27,.LC13@l(11)
	mr 31,10
	cmpw 0,30,0
	bc 4,0,.L167
	mr 28,9
.L162:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L164
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L164
	mr 10,31
	b .L166
.L164:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L162
.L167:
	li 10,0
.L166:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	li 10,10
	srawi 9,9,3
	slwi 9,9,2
	stwx 10,11,9
.L151:
	lwz 11,84(29)
	li 0,20
	lis 9,game@ha
	la 10,game@l(9)
	li 30,0
	stw 0,1784(11)
	lis 9,.LC14@ha
	lwz 0,1556(10)
	lis 11,itemlist@ha
	la 27,.LC14@l(9)
	lwz 26,84(29)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L176
	mr 28,10
.L171:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L173
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L173
	mr 0,31
	b .L175
.L173:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L171
.L176:
	li 0,0
.L175:
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 10,itemlist@l(11)
	ori 9,9,36409
	subf 0,10,0
	addi 11,26,740
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,20
	bc 4,1,.L168
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC14@ha
	lwz 0,1556(9)
	la 27,.LC14@l(11)
	mr 31,10
	cmpw 0,30,0
	bc 4,0,.L184
	mr 28,9
.L179:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L181
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L181
	mr 10,31
	b .L183
.L181:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L179
.L184:
	li 10,0
.L183:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	li 10,20
	srawi 9,9,3
	slwi 9,9,2
	stwx 10,11,9
.L168:
	lwz 10,84(29)
	lis 7,0x4330
	lis 9,.LC16@ha
	lwz 0,4308(10)
	la 9,.LC16@l(9)
	lfd 12,0(9)
	xoris 0,0,0x8000
	lis 9,unique_weapons@ha
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	lwz 8,unique_weapons@l(9)
	fsub 0,0,12
	lfs 13,20(8)
	frsp 0,0
	fcmpu 0,0,13
	bc 4,1,.L65
	lis 9,.LC17@ha
	lis 11,allweapon@ha
	la 9,.LC17@l(9)
	lfs 13,0(9)
	lwz 9,allweapon@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L65
	mr 3,29
	bl DropExtraSpecial
	lis 5,.LC15@ha
	mr 3,29
	la 5,.LC15@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L65:
	mr 4,25
	mr 3,29
	bl Drop_Spec
	mr 3,29
	bl ValidateSelectedItem
	mr 3,29
	mr 4,25
	bl SP_LaserSight
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 Drop_Special,.Lfe3-Drop_Special
	.section	".rodata"
	.align 2
.LC18:
	.string	"Stealth Slippers"
	.align 2
.LC19:
	.string	"Silencer"
	.align 2
.LC20:
	.string	"Kevlar Vest"
	.section	".text"
	.align 2
	.globl DropSpecialItem
	.type	 DropSpecialItem,@function
DropSpecialItem:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	mr 28,3
	lwz 0,1556(10)
	lis 9,.LC6@ha
	lis 11,itemlist@ha
	la 27,.LC6@l(9)
	lwz 26,84(28)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L195
	mr 29,10
.L190:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L192
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L276
.L192:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L190
.L195:
	li 0,0
.L194:
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 10,itemlist@l(11)
	ori 9,9,36409
	subf 0,10,0
	addi 11,26,740
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L187
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC6@ha
	lwz 0,1556(9)
	la 27,.LC6@l(11)
	mr 31,10
	cmpw 0,30,0
	bc 4,0,.L257
	mr 29,9
.L198:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L200
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L283
.L200:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L198
	b .L257
.L276:
	mr 0,31
	b .L194
.L278:
	mr 0,31
	b .L212
.L187:
	lis 9,game@ha
	li 30,0
	lwz 26,84(28)
	la 9,game@l(9)
	lis 11,.LC18@ha
	lwz 0,1556(9)
	la 27,.LC18@l(11)
	mr 31,10
	cmpw 0,30,0
	bc 4,0,.L213
	mr 29,9
.L208:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L210
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L278
.L210:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L208
.L213:
	li 0,0
.L212:
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 4,itemlist@l(11)
	ori 9,9,36409
	subf 0,4,0
	addi 11,26,740
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L205
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC18@ha
	lwz 0,1556(9)
	la 27,.LC18@l(11)
	mr 31,4
	cmpw 0,30,0
	bc 4,0,.L257
	mr 29,9
.L216:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L218
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L283
.L218:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L216
	b .L257
.L280:
	mr 0,31
	b .L230
.L205:
	lis 9,game@ha
	li 30,0
	lwz 26,84(28)
	la 9,game@l(9)
	lis 11,.LC19@ha
	lwz 0,1556(9)
	la 27,.LC19@l(11)
	mr 31,4
	cmpw 0,30,0
	bc 4,0,.L231
	mr 29,9
.L226:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L228
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L280
.L228:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L226
.L231:
	li 0,0
.L230:
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 4,itemlist@l(11)
	ori 9,9,36409
	subf 0,4,0
	addi 11,26,740
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L223
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC19@ha
	lwz 0,1556(9)
	la 27,.LC19@l(11)
	mr 31,4
	cmpw 0,30,0
	bc 4,0,.L257
	mr 29,9
.L234:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L236
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L283
.L236:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L234
	b .L257
.L282:
	mr 0,31
	b .L248
.L283:
	mr 4,31
	b .L256
.L223:
	lis 9,game@ha
	li 30,0
	lwz 26,84(28)
	la 9,game@l(9)
	lis 11,.LC5@ha
	lwz 0,1556(9)
	la 27,.LC5@l(11)
	mr 31,4
	cmpw 0,30,0
	bc 4,0,.L249
	mr 29,9
.L244:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L246
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L282
.L246:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L244
.L249:
	li 0,0
.L248:
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 4,itemlist@l(11)
	ori 9,9,36409
	subf 0,4,0
	addi 11,26,740
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L241
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC5@ha
	lwz 0,1556(9)
	la 27,.LC5@l(11)
	mr 31,4
	cmpw 0,30,0
	bc 4,0,.L257
	mr 29,9
.L252:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L254
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L283
.L254:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L252
.L257:
	li 4,0
.L256:
	mr 3,28
	bl Drop_Special
	b .L204
.L284:
	mr 0,31
	b .L266
.L285:
	mr 4,31
	b .L274
.L241:
	lis 9,game@ha
	li 30,0
	lwz 26,84(28)
	la 9,game@l(9)
	lis 11,.LC20@ha
	lwz 0,1556(9)
	la 27,.LC20@l(11)
	mr 31,4
	cmpw 0,30,0
	bc 4,0,.L267
	mr 29,9
.L262:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L264
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L284
.L264:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L262
.L267:
	li 0,0
.L266:
	lis 11,itemlist@ha
	lis 9,0x38e3
	la 4,itemlist@l(11)
	ori 9,9,36409
	subf 0,4,0
	addi 11,26,740
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L204
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC20@ha
	lwz 0,1556(9)
	la 27,.LC20@l(11)
	mr 31,4
	cmpw 0,30,0
	bc 4,0,.L275
	mr 29,9
.L270:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L272
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L285
.L272:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L270
.L275:
	li 4,0
.L274:
	mr 3,28
	bl Drop_Special
.L204:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 DropSpecialItem,.Lfe4-DropSpecialItem
	.section	".rodata"
	.align 2
.LC21:
	.string	"Bullets"
	.align 2
.LC22:
	.string	"Shells"
	.align 2
.LC23:
	.long 0x0
	.align 3
.LC24:
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
	bc 12,1,.L296
	li 0,250
	stw 0,1764(9)
.L296:
	lwz 9,84(29)
	lwz 0,1768(9)
	cmpwi 0,0,149
	bc 12,1,.L297
	li 0,150
	stw 0,1768(9)
.L297:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,249
	bc 12,1,.L298
	li 0,250
	stw 0,1780(9)
.L298:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,74
	bc 12,1,.L299
	li 0,75
	stw 0,1784(9)
.L299:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC21@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC21@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L307
	mr 27,10
.L302:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L304
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L304
	mr 8,31
	b .L306
.L304:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L302
.L307:
	li 8,0
.L306:
	cmpwi 0,8,0
	bc 12,2,.L308
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
	bc 4,1,.L308
	stwx 11,9,8
.L308:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC22@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC22@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L317
	mr 27,10
.L312:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L314
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L314
	mr 8,31
	b .L316
.L314:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L312
.L317:
	li 8,0
.L316:
	cmpwi 0,8,0
	bc 12,2,.L318
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
	bc 4,1,.L318
	stwx 11,4,8
.L318:
	lwz 0,284(28)
	andis. 4,0,0x1
	bc 4,2,.L320
	lis 9,.LC23@ha
	lis 11,deathmatch@ha
	la 9,.LC23@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L320
	lis 9,.LC24@ha
	lwz 11,648(28)
	la 9,.LC24@l(9)
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
.L320:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 Pickup_Bandolier,.Lfe5-Pickup_Bandolier
	.section	".rodata"
	.align 2
.LC25:
	.string	"Cells"
	.align 2
.LC26:
	.string	"Grenades"
	.align 2
.LC27:
	.string	"Rockets"
	.align 2
.LC28:
	.string	"Slugs"
	.align 2
.LC29:
	.long 0x0
	.align 3
.LC30:
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
	bc 12,1,.L323
	li 0,300
	stw 0,1764(9)
.L323:
	lwz 9,84(29)
	lwz 0,1768(9)
	cmpwi 0,0,199
	bc 12,1,.L324
	li 0,200
	stw 0,1768(9)
.L324:
	lwz 9,84(29)
	lwz 0,1772(9)
	cmpwi 0,0,99
	bc 12,1,.L325
	li 0,100
	stw 0,1772(9)
.L325:
	lwz 9,84(29)
	lwz 0,1776(9)
	cmpwi 0,0,99
	bc 12,1,.L326
	li 0,100
	stw 0,1776(9)
.L326:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,299
	bc 12,1,.L327
	li 0,300
	stw 0,1780(9)
.L327:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,99
	bc 12,1,.L328
	li 0,100
	stw 0,1784(9)
.L328:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC21@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC21@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L336
	mr 28,10
.L331:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L333
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L333
	mr 8,31
	b .L335
.L333:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L331
.L336:
	li 8,0
.L335:
	cmpwi 0,8,0
	bc 12,2,.L337
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
	bc 4,1,.L337
	stwx 11,9,8
.L337:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC22@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC22@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L346
	mr 28,10
.L341:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L343
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L343
	mr 8,31
	b .L345
.L343:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L341
.L346:
	li 8,0
.L345:
	cmpwi 0,8,0
	bc 12,2,.L347
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
	bc 4,1,.L347
	stwx 11,9,8
.L347:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC25@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC25@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L356
	mr 28,10
.L351:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L353
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L353
	mr 8,31
	b .L355
.L353:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L351
.L356:
	li 8,0
.L355:
	cmpwi 0,8,0
	bc 12,2,.L357
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
	bc 4,1,.L357
	stwx 11,9,8
.L357:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC26@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC26@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L366
	mr 28,10
.L361:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L363
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L363
	mr 8,31
	b .L365
.L363:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L361
.L366:
	li 8,0
.L365:
	cmpwi 0,8,0
	bc 12,2,.L367
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
	bc 4,1,.L367
	stwx 11,9,8
.L367:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC27@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC27@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L376
	mr 28,10
.L371:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L373
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L373
	mr 8,31
	b .L375
.L373:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L371
.L376:
	li 8,0
.L375:
	cmpwi 0,8,0
	bc 12,2,.L377
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
	bc 4,1,.L377
	stwx 11,9,8
.L377:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC28@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC28@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L386
	mr 28,10
.L381:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L383
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L383
	mr 8,31
	b .L385
.L383:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L381
.L386:
	li 8,0
.L385:
	cmpwi 0,8,0
	bc 12,2,.L387
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
	bc 4,1,.L387
	stwx 11,4,8
.L387:
	lwz 0,284(27)
	andis. 4,0,0x1
	bc 4,2,.L389
	lis 9,.LC29@ha
	lis 11,deathmatch@ha
	la 9,.LC29@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L389
	lis 9,.LC30@ha
	lwz 11,648(27)
	la 9,.LC30@l(9)
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
.L389:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 Pickup_Pack,.Lfe6-Pickup_Pack
	.section	".rodata"
	.align 2
.LC31:
	.string	"items/damage.wav"
	.align 3
.LC32:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC33:
	.long 0x3f800000
	.align 2
.LC34:
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
	bc 12,2,.L392
	li 0,0
	mr 10,9
	stw 0,quad_drop_timeout_hack@l(11)
	b .L393
.L392:
	li 10,300
.L393:
	lis 11,level@ha
	lwz 8,84(31)
	lwz 11,level@l(11)
	lis 7,0x4330
	lis 6,.LC32@ha
	la 6,.LC32@l(6)
	lfs 12,4132(8)
	xoris 0,11,0x8000
	lfd 13,0(6)
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L394
	xoris 0,10,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fadds 0,12,0
	b .L396
.L394:
	add 0,11,10
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
.L396:
	stfs 0,4132(8)
	lis 29,gi@ha
	lis 3,.LC31@ha
	la 29,gi@l(29)
	la 3,.LC31@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 6,.LC33@ha
	lwz 0,16(29)
	lis 9,.LC33@ha
	la 6,.LC33@l(6)
	mr 5,3
	lfs 1,0(6)
	la 9,.LC33@l(9)
	li 4,3
	mtlr 0
	lis 6,.LC34@ha
	mr 3,31
	lfs 2,0(9)
	la 6,.LC34@l(6)
	lfs 3,0(6)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 Use_Quad,.Lfe7-Use_Quad
	.section	".rodata"
	.align 2
.LC35:
	.string	"items/protect.wav"
	.align 3
.LC36:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC37:
	.long 0x43960000
	.align 2
.LC38:
	.long 0x3f800000
	.align 2
.LC39:
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
	lis 9,.LC36@ha
	lis 11,level@ha
	lwz 10,84(31)
	la 9,.LC36@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,4136(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L404
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L406
.L404:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L406:
	stfs 0,4136(10)
	lis 29,gi@ha
	lis 3,.LC35@ha
	la 29,gi@l(29)
	la 3,.LC35@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC38@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC38@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 2,0(9)
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 Use_Invulnerability,.Lfe8-Use_Invulnerability
	.section	".rodata"
	.align 2
.LC40:
	.string	"key_power_cube"
	.align 2
.LC41:
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
	lis 11,.LC41@ha
	lis 9,coop@ha
	la 11,.LC41@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 30,4
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L409
	lwz 3,280(31)
	lis 4,.LC40@ha
	la 4,.LC40@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L410
	lwz 10,84(30)
	lbz 9,286(31)
	lwz 0,1796(10)
	and. 11,0,9
	bc 4,2,.L415
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
	lwz 0,1796(11)
	or 0,0,9
	stw 0,1796(11)
	b .L412
.L410:
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
	bc 12,2,.L413
.L415:
	li 3,0
	b .L414
.L413:
	li 0,1
	stwx 0,4,3
.L412:
	li 3,1
	b .L414
.L409:
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
.L414:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 Pickup_Key,.Lfe9-Pickup_Key
	.align 2
	.globl Add_Ammo
	.type	 Add_Ammo,@function
Add_Ammo:
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 4,2,.L417
.L433:
	li 3,0
	blr
.L417:
	lwz 0,64(4)
	cmpwi 0,0,0
	bc 4,2,.L418
	lwz 10,1764(9)
	b .L419
.L418:
	cmpwi 0,0,1
	bc 4,2,.L420
	lwz 10,1768(9)
	b .L419
.L420:
	cmpwi 0,0,2
	bc 4,2,.L422
	lwz 10,1772(9)
	b .L419
.L422:
	cmpwi 0,0,3
	bc 4,2,.L424
	lwz 10,1776(9)
	b .L419
.L424:
	cmpwi 0,0,4
	bc 4,2,.L426
	lwz 10,1780(9)
	b .L419
.L426:
	cmpwi 0,0,5
	bc 4,2,.L433
	lwz 10,1784(9)
.L419:
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
	bc 12,2,.L433
	add 0,0,5
	stwx 0,11,4
	lwz 9,84(3)
	addi 3,9,740
	lwzx 0,3,4
	cmpw 0,0,10
	bc 4,1,.L431
	stwx 10,3,4
.L431:
	li 3,1
	blr
.Lfe10:
	.size	 Add_Ammo,.Lfe10-Add_Ammo
	.section	".rodata"
	.align 2
.LC42:
	.string	"blaster"
	.align 2
.LC43:
	.long 0x0
	.align 2
.LC44:
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
	lwz 4,648(29)
	lwz 0,56(4)
	andi. 30,0,1
	bc 12,2,.L435
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8192
	li 5,1000
	bc 4,2,.L436
.L435:
	lwz 5,532(29)
	cmpwi 0,5,0
	bc 12,2,.L437
	lwz 4,648(29)
	b .L436
.L437:
	lwz 9,648(29)
	lwz 5,48(9)
	mr 4,9
.L436:
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
	bc 4,2,.L439
	li 3,0
	b .L453
.L454:
	mr 9,31
	b .L449
.L439:
	subfic 9,31,0
	adde 0,9,31
	and. 11,30,0
	bc 12,2,.L440
	lwz 25,84(28)
	lwz 9,648(29)
	lwz 0,1788(25)
	cmpw 0,0,9
	bc 12,2,.L440
	lis 9,.LC43@ha
	lis 11,deathmatch@ha
	la 9,.LC43@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L442
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC42@ha
	lwz 0,1556(9)
	la 26,.LC42@l(11)
	mr 31,27
	cmpw 0,30,0
	bc 4,0,.L450
	mr 27,9
.L445:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L447
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L454
.L447:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L445
.L450:
	li 9,0
.L449:
	lwz 0,1788(25)
	cmpw 0,0,9
	bc 4,2,.L440
.L442:
	lwz 9,84(28)
	lwz 0,648(29)
	stw 0,3956(9)
.L440:
	lwz 0,284(29)
	andis. 7,0,0x3
	bc 4,2,.L451
	lis 9,.LC43@ha
	lis 11,deathmatch@ha
	la 9,.LC43@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L451
	lwz 9,264(29)
	lis 11,.LC44@ha
	lis 10,level+4@ha
	lwz 0,184(29)
	la 11,.LC44@l(11)
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
.L451:
	li 3,1
.L453:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe11:
	.size	 Pickup_Ammo,.Lfe11-Pickup_Ammo
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
	.align 2
.LC49:
	.long 0x40a00000
	.align 2
.LC50:
	.long 0x0
	.align 2
.LC51:
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
	lwz 0,644(7)
	andi. 8,0,1
	bc 4,2,.L464
	lwz 9,480(4)
	lwz 0,484(4)
	cmpw 0,9,0
	bc 12,0,.L464
	li 3,0
	b .L478
.L464:
	lwz 0,480(4)
	lwz 9,532(7)
	add 0,0,9
	stw 0,480(4)
	lwz 0,532(7)
	cmpwi 0,0,2
	bc 4,2,.L466
	lwz 11,648(7)
	lis 9,.LC45@ha
	la 9,.LC45@l(9)
	b .L479
.L466:
	cmpwi 0,0,10
	bc 4,2,.L468
	lwz 11,648(7)
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	b .L479
.L468:
	cmpwi 0,0,25
	bc 4,2,.L470
	lwz 11,648(7)
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	b .L479
.L470:
	lwz 11,648(7)
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
.L479:
	stw 9,20(11)
	lwz 0,644(7)
	andi. 9,0,1
	bc 4,2,.L472
	lwz 0,480(4)
	lwz 9,484(4)
	cmpw 0,0,9
	bc 4,1,.L472
	stw 9,480(4)
.L472:
	lwz 0,644(7)
	andi. 11,0,2
	bc 12,2,.L474
	lis 9,MegaHealth_think@ha
	lis 8,.LC49@ha
	lwz 11,264(7)
	la 9,MegaHealth_think@l(9)
	lis 10,level+4@ha
	lwz 0,184(7)
	stw 9,436(7)
	la 8,.LC49@l(8)
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
	b .L475
.L474:
	lwz 0,284(7)
	andis. 6,0,0x1
	bc 4,2,.L475
	lis 9,.LC50@ha
	lis 11,deathmatch@ha
	la 9,.LC50@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L475
	lwz 9,264(7)
	lis 11,.LC51@ha
	lis 10,level+4@ha
	lwz 0,184(7)
	la 11,.LC51@l(11)
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
.L475:
	li 3,1
.L478:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe12:
	.size	 Pickup_Health,.Lfe12-Pickup_Health
	.section	".rodata"
	.align 3
.LC52:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC53:
	.long 0x0
	.align 2
.LC54:
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
	lwz 7,60(9)
	bc 4,2,.L486
	li 6,0
	b .L487
.L486:
	lis 9,jacket_armor_index@ha
	addi 8,11,740
	lwz 6,jacket_armor_index@l(9)
	slwi 0,6,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L487
	lis 9,combat_armor_index@ha
	lwz 6,combat_armor_index@l(9)
	slwi 0,6,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L487
	lis 9,body_armor_index@ha
	lwz 10,body_armor_index@l(9)
	slwi 11,10,2
	lwzx 9,8,11
	srawi 0,9,31
	subf 0,9,0
	srawi 0,0,31
	and 6,10,0
.L487:
	lwz 8,648(31)
	lwz 0,64(8)
	cmpwi 0,0,4
	bc 4,2,.L491
	cmpwi 0,6,0
	bc 4,2,.L492
	lis 11,jacket_armor_index@ha
	lwz 9,84(12)
	li 10,2
	lwz 0,jacket_armor_index@l(11)
	addi 9,9,740
	slwi 0,0,2
	stwx 10,9,0
	b .L494
.L492:
	lwz 9,84(12)
	slwi 0,6,2
	addi 9,9,740
	lwzx 11,9,0
	addi 11,11,2
	stwx 11,9,0
	b .L494
.L491:
	cmpwi 0,6,0
	bc 4,2,.L495
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
	b .L494
.L495:
	lis 9,jacket_armor_index@ha
	lwz 0,jacket_armor_index@l(9)
	cmpw 0,6,0
	bc 4,2,.L497
	lis 9,jacketarmor_info@ha
	la 11,jacketarmor_info@l(9)
	b .L498
.L497:
	lis 9,combat_armor_index@ha
	lwz 0,combat_armor_index@l(9)
	cmpw 0,6,0
	bc 4,2,.L499
	lis 9,combatarmor_info@ha
	la 11,combatarmor_info@l(9)
	b .L498
.L499:
	lis 9,bodyarmor_info@ha
	la 11,bodyarmor_info@l(9)
.L498:
	lfs 13,8(7)
	lfs 0,8(11)
	fcmpu 0,13,0
	bc 4,1,.L501
	fdivs 11,0,13
	lwz 9,84(12)
	slwi 6,6,2
	lis 5,0x4330
	lis 10,.LC52@ha
	lwz 3,0(7)
	addi 9,9,740
	la 10,.LC52@l(10)
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
	b .L494
.L501:
	fdivs 11,13,0
	lwz 0,0(7)
	lis 8,0x4330
	lis 10,.LC52@ha
	mr 7,9
	lwz 11,4(11)
	xoris 0,0,0x8000
	la 10,.LC52@l(10)
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
	bc 12,0,.L505
	li 3,0
	b .L508
.L505:
	stwx 0,4,6
.L494:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L506
	lis 9,.LC53@ha
	lis 11,deathmatch@ha
	la 9,.LC53@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L506
	lwz 9,264(31)
	lis 11,.LC54@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC54@l(11)
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
.L506:
	li 3,1
.L508:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 Pickup_Armor,.Lfe13-Pickup_Armor
	.section	".rodata"
	.align 2
.LC55:
	.string	"misc/power2.wav"
	.align 2
.LC56:
	.string	"cells"
	.align 2
.LC57:
	.string	"No cells for power armor.\n"
	.align 2
.LC58:
	.string	"misc/power1.wav"
	.align 2
.LC59:
	.long 0x3f800000
	.align 2
.LC60:
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
	bc 12,2,.L515
	rlwinm 0,0,0,20,18
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(30)
	lis 3,.LC55@ha
	lwz 9,36(29)
	la 3,.LC55@l(3)
	mtlr 9
	blrl
	lis 9,.LC59@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC59@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC59@ha
	la 9,.LC59@l(9)
	lfs 2,0(9)
	lis 9,.LC60@ha
	la 9,.LC60@l(9)
	lfs 3,0(9)
	blrl
	b .L514
.L526:
	mr 10,29
	b .L523
.L515:
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lis 11,.LC56@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC56@l(11)
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L524
	mr 28,10
.L519:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L521
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L526
.L521:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,72
	cmpw 0,31,0
	bc 12,0,.L519
.L524:
	li 10,0
.L523:
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
	bc 4,2,.L525
	lis 5,.LC57@ha
	mr 3,30
	la 5,.LC57@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L514
.L525:
	lwz 0,264(30)
	lis 29,gi@ha
	lis 3,.LC58@ha
	la 29,gi@l(29)
	la 3,.LC58@l(3)
	ori 0,0,4096
	stw 0,264(30)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC59@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC59@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC59@ha
	la 9,.LC59@l(9)
	lfs 2,0(9)
	lis 9,.LC60@ha
	la 9,.LC60@l(9)
	lfs 3,0(9)
	blrl
.L514:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 Use_PowerArmor,.Lfe14-Use_PowerArmor
	.section	".rodata"
	.align 2
.LC61:
	.long 0x0
	.align 3
.LC62:
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
	addi 10,10,740
	srawi 0,0,3
	lis 9,.LC61@ha
	slwi 0,0,2
	la 9,.LC61@l(9)
	lwzx 30,10,0
	lfs 13,0(9)
	addi 9,30,1
	stwx 9,10,0
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L528
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L529
	lis 9,.LC62@ha
	lwz 11,648(31)
	la 9,.LC62@l(9)
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
.L529:
	cmpwi 0,30,0
	bc 4,2,.L528
	lwz 9,648(31)
	mr 3,29
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L528:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 Pickup_PowerArmor,.Lfe15-Pickup_PowerArmor
	.section	".rodata"
	.align 2
.LC63:
	.string	"Warning: null icon filename (classname = %s)\n"
	.align 2
.LC64:
	.string	"Warning: null icon filename (no classname)\n"
	.align 3
.LC65:
	.long 0x40080000
	.long 0x0
	.align 2
.LC66:
	.long 0x3f800000
	.align 2
.LC67:
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
	bc 12,2,.L535
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L535
	lwz 9,648(31)
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 12,2,.L535
	mtlr 0
	blrl
	mr. 28,3
	bc 12,2,.L539
	lwz 9,84(30)
	lis 0,0x3e80
	stw 0,4044(9)
	lwz 11,648(31)
	lwz 3,36(11)
	cmpwi 0,3,0
	bc 12,2,.L541
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L540
.L541:
	lwz 9,648(31)
	lwz 4,0(9)
	cmpwi 0,4,0
	bc 12,2,.L542
	lis 9,gi+4@ha
	lis 3,.LC63@ha
	lwz 0,gi+4@l(9)
	la 3,.LC63@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L540
.L542:
	lis 9,gi+4@ha
	lis 3,.LC64@ha
	lwz 0,gi+4@l(9)
	la 3,.LC64@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L540:
	lis 9,gi@ha
	lwz 11,648(31)
	la 29,gi@l(9)
	lwz 9,40(29)
	lwz 3,36(11)
	mtlr 9
	blrl
	lis 9,itemlist@ha
	lwz 11,84(30)
	lis 8,0x38e3
	la 7,itemlist@l(9)
	ori 8,8,36409
	lis 9,.LC65@ha
	sth 3,134(11)
	lis 10,level+4@ha
	la 9,.LC65@l(9)
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
	stfs 0,4164(9)
	lwz 9,648(31)
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 12,2,.L544
	subf 0,7,9
	lwz 11,84(30)
	mullw 0,0,8
	srawi 0,0,3
	extsh 9,0
	sth 0,144(11)
	stw 9,736(11)
.L544:
	lwz 9,648(31)
	lwz 11,36(29)
	lwz 3,20(9)
	mtlr 11
	blrl
	lis 9,.LC66@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC66@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC66@ha
	la 9,.LC66@l(9)
	lfs 2,0(9)
	lis 9,.LC67@ha
	la 9,.LC67@l(9)
	lfs 3,0(9)
	blrl
.L539:
	lwz 0,284(31)
	andis. 9,0,4
	bc 4,2,.L545
	mr 4,30
	mr 3,31
	bl G_UseTargets
	lwz 0,284(31)
	oris 0,0,0x4
	stw 0,284(31)
.L545:
	cmpwi 0,28,0
	bc 12,2,.L535
	lis 9,.LC67@ha
	lis 11,coop@ha
	la 9,.LC67@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L548
	lwz 9,648(31)
	lwz 0,56(9)
	andi. 9,0,8
	bc 12,2,.L548
	lwz 0,284(31)
	andis. 9,0,0x3
	bc 12,2,.L535
.L548:
	lwz 0,264(31)
	cmpwi 0,0,0
	bc 4,0,.L549
	rlwinm 0,0,0,1,31
	stw 0,264(31)
	b .L535
.L549:
	mr 3,31
	bl G_FreeEdict
.L535:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 Touch_Item,.Lfe16-Touch_Item
	.section	".rodata"
	.align 2
.LC68:
	.long 0x42c80000
	.align 2
.LC69:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Drop_Item
	.type	 Drop_Item,@function
Drop_Item:
	stwu 1,-176(1)
	mflr 0
	stmw 25,148(1)
	stw 0,180(1)
	mr 29,4
	mr 30,3
	bl G_Spawn
	lwz 10,0(29)
	mr 31,3
	lis 0,0x1
	stw 0,284(31)
	lis 9,0xc170
	lis 11,0x4170
	stw 10,280(31)
	li 8,512
	lis 4,.LC13@ha
	stw 29,648(31)
	la 4,.LC13@l(4)
	lwz 0,28(29)
	stw 8,68(31)
	stw 0,64(31)
	stw 9,196(31)
	stw 11,208(31)
	stw 9,188(31)
	stw 9,192(31)
	stw 11,200(31)
	stw 11,204(31)
	lwz 3,40(29)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L557
	lwz 3,40(29)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L557
	lwz 3,40(29)
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L556
.L557:
	lis 11,0xc170
	lis 10,0x4170
	lis 0,0xbf80
	lis 9,0x3f80
	stw 11,192(31)
	stw 0,196(31)
	stw 10,204(31)
	stw 9,208(31)
	stw 11,188(31)
	stw 10,200(31)
.L556:
	li 27,0
	lis 0,0x4416
	lwz 11,648(31)
	stw 0,392(31)
	lis 9,gi+44@ha
	mr 3,31
	stw 27,388(31)
	stw 27,396(31)
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
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
	bc 12,2,.L558
	addi 28,1,24
	addi 4,1,8
	addi 3,3,4060
	mr 5,28
	li 6,0
	addi 29,30,4
	bl AngleVectors
	mr 26,29
	lis 0,0x41c0
	lis 9,0xc180
	stw 27,44(1)
	addi 7,31,4
	stw 0,40(1)
	mr 6,28
	stw 9,48(1)
	mr 25,7
	mr 3,29
	addi 4,1,40
	addi 5,1,8
	bl G_ProjectSource
	lis 9,transparent_list@ha
	lwz 0,transparent_list@l(9)
	cmpwi 0,0,0
	bc 12,2,.L559
	lis 10,teamplay@ha
	lwz 9,teamplay@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,136(1)
	lwz 11,140(1)
	cmpwi 0,11,0
	bc 12,2,.L559
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L559
	li 3,2
	bl TransparentListSet
.L559:
	lis 9,gi+48@ha
	mr 4,26
	lwz 0,gi+48@l(9)
	mr 7,25
	mr 8,30
	li 9,1
	addi 3,1,56
	mtlr 0
	addi 5,31,188
	addi 6,31,200
	blrl
	lis 9,transparent_list@ha
	lwz 0,transparent_list@l(9)
	cmpwi 0,0,0
	bc 12,2,.L560
	lis 10,teamplay@ha
	lwz 9,teamplay@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,136(1)
	lwz 11,140(1)
	cmpwi 0,11,0
	bc 12,2,.L560
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L560
	li 3,1
	bl TransparentListSet
.L560:
	lfs 0,68(1)
	stfs 0,4(31)
	lfs 13,72(1)
	stfs 13,8(31)
	lfs 0,76(1)
	b .L562
.L558:
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
.L562:
	stfs 0,12(31)
	lis 9,.LC68@ha
	addi 3,1,8
	la 9,.LC68@l(9)
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
	lis 9,.LC69@ha
	lfs 0,level+4@l(11)
	la 9,.LC69@l(9)
	lfs 13,0(9)
	lis 9,gi+72@ha
	fadds 0,0,13
	stfs 0,428(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	lwz 0,180(1)
	mtlr 0
	lmw 25,148(1)
	la 1,176(1)
	blr
.Lfe17:
	.size	 Drop_Item,.Lfe17-Drop_Item
	.section	".rodata"
	.align 2
.LC70:
	.string	"droptofloor: %s startsolid at %s\n"
	.align 3
.LC71:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC72:
	.long 0xc1700000
	.align 2
.LC73:
	.long 0x41700000
	.align 2
.LC74:
	.long 0x0
	.align 2
.LC75:
	.long 0xc3000000
	.section	".text"
	.align 2
	.globl droptofloor
	.type	 droptofloor,@function
droptofloor:
	stwu 1,-112(1)
	mflr 0
	stmw 28,96(1)
	stw 0,116(1)
	lis 9,.LC72@ha
	lis 11,.LC72@ha
	la 9,.LC72@l(9)
	la 11,.LC72@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC72@ha
	lfs 2,0(11)
	la 9,.LC72@l(9)
	lfs 3,0(9)
	bl tv
	lfs 13,0(3)
	lis 9,.LC73@ha
	lis 11,.LC73@ha
	la 9,.LC73@l(9)
	la 11,.LC73@l(11)
	lfs 1,0(9)
	stfs 13,188(31)
	lis 9,.LC73@ha
	lfs 0,4(3)
	la 9,.LC73@l(9)
	lfs 3,0(9)
	lfs 2,0(11)
	stfs 0,192(31)
	lfs 13,8(3)
	stfs 13,196(31)
	bl tv
	lfs 13,0(3)
	lwz 9,648(31)
	stfs 13,200(31)
	cmpwi 0,9,0
	lfs 0,4(3)
	stfs 0,204(31)
	lfs 13,8(3)
	stfs 13,208(31)
	bc 12,2,.L567
	lwz 3,40(9)
	lis 4,.LC13@ha
	la 4,.LC13@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L569
	lwz 9,648(31)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L569
	lwz 9,648(31)
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L567
.L569:
	lis 11,0xc170
	lis 10,0x4170
	lis 0,0xbf80
	lis 9,0x3f80
	stw 11,192(31)
	stw 0,196(31)
	stw 10,204(31)
	stw 9,208(31)
	stw 11,188(31)
	stw 10,200(31)
.L567:
	lwz 4,268(31)
	cmpwi 0,4,0
	bc 12,2,.L570
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L571
.L570:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L571:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC74@ha
	stw 9,444(31)
	la 11,.LC74@l(11)
	lis 9,.LC75@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC75@l(9)
	lis 11,.LC74@ha
	lfs 3,0(9)
	la 11,.LC74@l(11)
	lfs 2,0(11)
	bl tv
	lfs 0,4(31)
	lis 9,transparent_list@ha
	lfs 13,0(3)
	lfs 12,8(31)
	lfs 11,12(31)
	fadds 0,0,13
	lwz 0,transparent_list@l(9)
	cmpwi 0,0,0
	stfs 0,72(1)
	lfs 0,4(3)
	fadds 12,12,0
	stfs 12,76(1)
	lfs 0,8(3)
	fadds 11,11,0
	stfs 11,80(1)
	bc 12,2,.L572
	lis 10,teamplay@ha
	lwz 9,teamplay@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,88(1)
	lwz 11,92(1)
	cmpwi 0,11,0
	bc 12,2,.L572
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L572
	li 3,2
	bl TransparentListSet
.L572:
	lis 9,gi+48@ha
	addi 4,31,4
	lwz 0,gi+48@l(9)
	addi 3,1,8
	addi 5,31,188
	li 9,3
	addi 6,31,200
	mtlr 0
	addi 7,1,72
	mr 8,31
	mr 28,4
	blrl
	lis 9,transparent_list@ha
	lwz 0,transparent_list@l(9)
	cmpwi 0,0,0
	bc 12,2,.L573
	lis 10,teamplay@ha
	lwz 9,teamplay@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,88(1)
	lwz 11,92(1)
	cmpwi 0,11,0
	bc 12,2,.L573
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L573
	li 3,1
	bl TransparentListSet
.L573:
	lwz 8,12(1)
	cmpwi 0,8,0
	bc 12,2,.L574
	mr 3,28
	lis 29,gi@ha
	lwz 28,280(31)
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC70@ha
	la 3,.LC70@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L566
.L574:
	lwz 0,308(31)
	lfs 12,20(1)
	lfs 0,24(1)
	cmpwi 0,0,0
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L575
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
	bc 4,2,.L575
	lis 11,level+4@ha
	lis 10,.LC71@ha
	lfs 0,level+4@l(11)
	lis 9,DoRespawn@ha
	lfd 13,.LC71@l(10)
	la 9,DoRespawn@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L575:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L577
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
.L577:
	lwz 0,284(31)
	andi. 11,0,1
	bc 12,2,.L578
	lwz 0,184(31)
	lis 9,Use_Item@ha
	li 11,0
	la 9,Use_Item@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
.L578:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L566:
	lwz 0,116(1)
	mtlr 0
	lmw 28,96(1)
	la 1,112(1)
	blr
.Lfe18:
	.size	 droptofloor,.Lfe18-droptofloor
	.section	".rodata"
	.align 2
.LC76:
	.string	"PrecacheItem: %s has bad precache string"
	.align 2
.LC77:
	.string	"md2"
	.align 2
.LC78:
	.string	"sp2"
	.align 2
.LC79:
	.string	"wav"
	.align 2
.LC80:
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
	bc 12,2,.L579
	lwz 3,20(26)
	cmpwi 0,3,0
	bc 12,2,.L581
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L581:
	lwz 3,24(26)
	cmpwi 0,3,0
	bc 12,2,.L582
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L582:
	lwz 3,32(26)
	cmpwi 0,3,0
	bc 12,2,.L583
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L583:
	lwz 3,36(26)
	cmpwi 0,3,0
	bc 12,2,.L584
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
.L584:
	lwz 29,52(26)
	cmpwi 0,29,0
	bc 12,2,.L585
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L585
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L593
	mr 28,9
.L588:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L590
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L590
	mr 3,31
	b .L592
.L590:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L588
.L593:
	li 3,0
.L592:
	cmpw 0,3,26
	bc 12,2,.L585
	bl PrecacheItem
.L585:
	lwz 30,68(26)
	cmpwi 0,30,0
	bc 12,2,.L579
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 12,2,.L579
	lis 9,gi@ha
	addi 29,1,8
	la 27,gi@l(9)
	lis 24,.LC77@ha
	lis 25,.LC80@ha
.L599:
	rlwinm 9,0,0,0xff
	mr 31,30
	b .L613
.L602:
	lbzu 9,1(30)
.L613:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L602
	subf 28,31,30
	addi 0,28,-5
	cmplwi 0,0,58
	bc 4,1,.L604
	lwz 9,28(27)
	lis 3,.LC76@ha
	la 3,.LC76@l(3)
	lwz 4,0(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L604:
	mr 4,31
	mr 5,28
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 0,0
	addi 11,30,1
	stbx 0,29,28
	add 9,29,28
	la 4,.LC77@l(24)
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
	bc 12,2,.L614
	lis 4,.LC78@ha
	mr 3,31
	la 4,.LC78@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L608
.L614:
	lwz 9,32(27)
	mr 3,29
	mtlr 9
	blrl
	b .L607
.L608:
	lis 4,.LC79@ha
	mr 3,31
	la 4,.LC79@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L607
	lwz 9,36(27)
	mr 3,29
	mtlr 9
	blrl
.L607:
	add 3,29,28
	la 4,.LC80@l(25)
	addi 3,3,-3
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L597
	lwz 9,40(27)
	mr 3,29
	mtlr 9
	blrl
.L597:
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L599
.L579:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe19:
	.size	 PrecacheItem,.Lfe19-PrecacheItem
	.section	".rodata"
	.align 2
.LC81:
	.string	"%s at %s has invalid spawnflags set\n"
	.align 2
.LC82:
	.string	"weapon_bfg"
	.align 3
.LC83:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC84:
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
	bc 12,2,.L616
	lwz 3,280(31)
	lis 4,.LC40@ha
	la 4,.LC40@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L616
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
	lis 3,.LC81@ha
	la 3,.LC81@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L616:
	lis 9,.LC84@ha
	lis 11,deathmatch@ha
	la 9,.LC84@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L618
	lis 10,dmflags@ha
	lwz 0,4(30)
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 9,11,2048
	bc 12,2,.L619
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L629
	lis 9,Pickup_PowerArmor@ha
	la 9,Pickup_PowerArmor@l(9)
	cmpw 0,0,9
	bc 12,2,.L629
.L619:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 9,11,2
	bc 12,2,.L622
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L629
.L622:
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L629
	lis 9,Pickup_Adrenaline@ha
	la 9,Pickup_Adrenaline@l(9)
	cmpw 0,0,9
	bc 12,2,.L629
	lis 9,Pickup_AncientHead@ha
	la 9,Pickup_AncientHead@l(9)
	cmpw 0,0,9
	bc 12,2,.L629
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8192
	bc 12,2,.L618
	lwz 0,56(30)
	cmpwi 0,0,2
	bc 12,2,.L629
	lwz 3,280(31)
	lis 4,.LC82@ha
	la 4,.LC82@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L618
.L629:
	mr 3,31
	bl G_FreeEdict
	b .L615
.L618:
	lis 11,.LC84@ha
	lis 9,coop@ha
	la 11,.LC84@l(11)
	lis 29,level@ha
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L630
	lwz 3,280(31)
	lis 4,.LC40@ha
	la 4,.LC40@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L630
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
.L630:
	lis 9,.LC84@ha
	lis 11,coop@ha
	la 9,.LC84@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L631
	lwz 0,56(30)
	andi. 11,0,8
	bc 12,2,.L631
	li 0,0
	stw 0,12(30)
.L631:
	stw 30,648(31)
	lis 11,level+4@ha
	lis 10,.LC83@ha
	lfs 0,level+4@l(11)
	lis 9,droptofloor@ha
	lfd 13,.LC83@l(10)
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
	bc 12,2,.L615
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L615:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 SpawnItem,.Lfe20-SpawnItem
	.globl itemlist
	.section	".data"
	.align 2
	.type	 itemlist,@object
itemlist:
	.long 0
	.space	68
	.long .LC85
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC86
	.long .LC87
	.long 1
	.long 0
	.long .LC88
	.long .LC89
	.long 3
	.long 0
	.long 0
	.long 4
	.long bodyarmor_info
	.long 3
	.long .LC90
	.long .LC91
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC86
	.long .LC92
	.long 1
	.long 0
	.long .LC93
	.long .LC94
	.long 3
	.long 0
	.long 0
	.long 4
	.long combatarmor_info
	.long 2
	.long .LC90
	.long .LC95
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC86
	.long .LC96
	.long 1
	.long 0
	.long .LC97
	.long .LC98
	.long 3
	.long 0
	.long 0
	.long 4
	.long jacketarmor_info
	.long 1
	.long .LC90
	.long .LC99
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC100
	.long .LC101
	.long 1
	.long 0
	.long .LC97
	.long .LC102
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long 4
	.long .LC90
	.long .LC103
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC104
	.long .LC105
	.long 1
	.long 0
	.long .LC106
	.long .LC107
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long .LC90
	.long .LC108
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC104
	.long .LC109
	.long 1
	.long 0
	.long .LC110
	.long .LC111
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long .LC90
	.long .LC112
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Blaster
	.long .LC113
	.long 0
	.long 0
	.long .LC114
	.long .LC115
	.long .LC116
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long .LC117
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Shotgun
	.long .LC113
	.long .LC118
	.long 1
	.long .LC119
	.long .LC120
	.long .LC121
	.long 0
	.long 1
	.long .LC22
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long .LC122
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_SuperShotgun
	.long .LC113
	.long .LC123
	.long 1
	.long .LC124
	.long .LC125
	.long .LC126
	.long 0
	.long 2
	.long .LC22
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long .LC127
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Machinegun
	.long .LC113
	.long .LC128
	.long 1
	.long .LC129
	.long .LC130
	.long .LC131
	.long 0
	.long 1
	.long .LC21
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long .LC132
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Chaingun
	.long .LC113
	.long .LC133
	.long 1
	.long .LC134
	.long .LC135
	.long .LC136
	.long 0
	.long 1
	.long .LC21
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long .LC137
	.long Pickup_Ammo
	.long Use_Weapon
	.long Drop_Ammo
	.long Weapon_Grenade
	.long .LC138
	.long .LC139
	.long 0
	.long .LC140
	.long .LC141
	.long .LC26
	.long 3
	.long 5
	.long .LC142
	.long 0
	.long 0
	.long 3
	.long .LC143
	.long .LC144
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_GrenadeLauncher
	.long .LC113
	.long .LC145
	.long 1
	.long .LC146
	.long .LC147
	.long .LC148
	.long 0
	.long 1
	.long .LC26
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long .LC149
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_RocketLauncher
	.long .LC113
	.long .LC150
	.long 1
	.long .LC151
	.long .LC152
	.long .LC153
	.long 0
	.long 1
	.long .LC27
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long .LC154
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_HyperBlaster
	.long .LC113
	.long .LC155
	.long 1
	.long .LC156
	.long .LC157
	.long .LC158
	.long 0
	.long 1
	.long .LC25
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long .LC159
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Railgun
	.long .LC113
	.long .LC160
	.long 1
	.long .LC161
	.long .LC162
	.long .LC163
	.long 0
	.long 1
	.long .LC28
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long .LC82
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_BFG
	.long .LC113
	.long .LC164
	.long 1
	.long .LC165
	.long .LC166
	.long .LC167
	.long 0
	.long 50
	.long .LC25
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long .LC168
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_MK23
	.long 0
	.long .LC169
	.long 0
	.long .LC114
	.long .LC170
	.long .LC171
	.long 0
	.long 1
	.long .LC8
	.long 1
	.long 0
	.long 0
	.long .LC172
	.long .LC173
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_MP5
	.long 0
	.long .LC128
	.long 0
	.long .LC129
	.long .LC174
	.long .LC175
	.long 0
	.long 0
	.long .LC12
	.long 1
	.long 0
	.long 0
	.long .LC176
	.long .LC177
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_M4
	.long 0
	.long .LC178
	.long 0
	.long .LC179
	.long .LC180
	.long .LC181
	.long 0
	.long 0
	.long .LC10
	.long 1
	.long 0
	.long 0
	.long .LC182
	.long .LC183
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_M3
	.long 0
	.long .LC118
	.long 0
	.long .LC119
	.long .LC184
	.long .LC185
	.long 0
	.long 0
	.long .LC9
	.long 1
	.long 0
	.long 0
	.long .LC186
	.long .LC187
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_HC
	.long 0
	.long .LC188
	.long 0
	.long .LC189
	.long .LC190
	.long .LC191
	.long 0
	.long 0
	.long .LC9
	.long 1
	.long 0
	.long 0
	.long .LC192
	.long .LC193
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Sniper
	.long 0
	.long .LC194
	.long 0
	.long .LC195
	.long .LC196
	.long .LC197
	.long 0
	.long 0
	.long .LC14
	.long 1
	.long 0
	.long 0
	.long .LC198
	.long .LC199
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Dual
	.long 0
	.long .LC169
	.long 0
	.long .LC200
	.long .LC201
	.long .LC202
	.long 0
	.long 0
	.long .LC8
	.long 1
	.long 0
	.long 0
	.long .LC203
	.long .LC204
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Knife
	.long 0
	.long .LC205
	.long 0
	.long .LC206
	.long .LC207
	.long .LC13
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC208
	.long .LC209
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Gas
	.long 0
	.long .LC210
	.long 0
	.long .LC140
	.long .LC211
	.long .LC11
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC212
	.long .LC213
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC138
	.long .LC214
	.long 0
	.long 0
	.long .LC215
	.long .LC22
	.long 3
	.long 10
	.long 0
	.long 0
	.long 0
	.long 1
	.long .LC90
	.long .LC216
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC138
	.long .LC217
	.long 0
	.long 0
	.long .LC218
	.long .LC21
	.long 3
	.long 50
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long .LC219
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC138
	.long .LC220
	.long 0
	.long 0
	.long .LC221
	.long .LC25
	.long 3
	.long 50
	.long 0
	.long 0
	.long 0
	.long 4
	.long .LC90
	.long .LC222
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC138
	.long .LC223
	.long 0
	.long 0
	.long .LC224
	.long .LC27
	.long 3
	.long 5
	.long 0
	.long 0
	.long 0
	.long 2
	.long .LC90
	.long .LC225
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC138
	.long .LC226
	.long 0
	.long 0
	.long .LC227
	.long .LC28
	.long 3
	.long 10
	.long 0
	.long 0
	.long 0
	.long 5
	.long .LC90
	.long .LC228
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long 0
	.long .LC229
	.long 0
	.long 0
	.long .LC230
	.long .LC8
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 0
	.long .LC90
	.long .LC231
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long 0
	.long .LC232
	.long 0
	.long 0
	.long .LC233
	.long .LC12
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 2
	.long .LC90
	.long .LC234
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long 0
	.long .LC235
	.long 0
	.long 0
	.long .LC236
	.long .LC10
	.long 3
	.long 1
	.long 0
	.long 2
	.long 0
	.long 4
	.long .LC90
	.long .LC237
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long 0
	.long .LC214
	.long 0
	.long 0
	.long .LC215
	.long .LC9
	.long 3
	.long 7
	.long 0
	.long 2
	.long 0
	.long 1
	.long .LC90
	.long .LC238
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long 0
	.long .LC239
	.long 0
	.long 0
	.long .LC218
	.long .LC14
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 5
	.long .LC90
	.long .LC240
	.long Pickup_Special
	.long 0
	.long Drop_Special
	.long 0
	.long .LC241
	.long .LC242
	.long 0
	.long 0
	.long .LC243
	.long .LC19
	.long 2
	.long 60
	.long 0
	.long 64
	.long 0
	.long 0
	.long .LC90
	.long .LC244
	.long Pickup_Special
	.long 0
	.long Drop_Special
	.long 0
	.long .LC245
	.long .LC246
	.long 0
	.long 0
	.long .LC247
	.long .LC18
	.long 2
	.long 60
	.long 0
	.long 64
	.long 0
	.long 0
	.long .LC90
	.long .LC248
	.long Pickup_Special
	.long 0
	.long Drop_Special
	.long 0
	.long .LC245
	.long .LC249
	.long 0
	.long 0
	.long .LC250
	.long .LC6
	.long 2
	.long 60
	.long 0
	.long 64
	.long 0
	.long 0
	.long .LC90
	.long .LC251
	.long Pickup_Special
	.long 0
	.long Drop_Special
	.long 0
	.long .LC245
	.long .LC96
	.long 0
	.long 0
	.long .LC97
	.long .LC20
	.long 2
	.long 60
	.long 0
	.long 64
	.long 0
	.long 0
	.long .LC90
	.long .LC252
	.long Pickup_Special
	.long 0
	.long Drop_Special
	.long 0
	.long .LC253
	.long .LC254
	.long 0
	.long 0
	.long .LC255
	.long .LC5
	.long 2
	.long 60
	.long 0
	.long 64
	.long 0
	.long 0
	.long .LC90
	.long .LC256
	.long Pickup_Powerup
	.long Use_Quad
	.long Drop_General
	.long 0
	.long .LC257
	.long .LC258
	.long 1
	.long 0
	.long .LC259
	.long .LC260
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long .LC261
	.long .LC262
	.long Pickup_Powerup
	.long Use_Invulnerability
	.long Drop_General
	.long 0
	.long .LC257
	.long .LC263
	.long 1
	.long 0
	.long .LC264
	.long .LC265
	.long 2
	.long 300
	.long 0
	.long 32
	.long 0
	.long 0
	.long .LC266
	.long .LC267
	.long Pickup_Powerup
	.long Use_Silencer
	.long Drop_General
	.long 0
	.long .LC257
	.long .LC268
	.long 1
	.long 0
	.long .LC243
	.long .LC19
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long .LC90
	.long .LC269
	.long Pickup_Powerup
	.long Use_Breather
	.long Drop_General
	.long 0
	.long .LC257
	.long .LC270
	.long 1
	.long 0
	.long .LC271
	.long .LC272
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long .LC273
	.long .LC274
	.long Pickup_Powerup
	.long Use_Envirosuit
	.long Drop_General
	.long 0
	.long .LC257
	.long .LC275
	.long 1
	.long 0
	.long .LC276
	.long .LC277
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC273
	.long .LC278
	.long Pickup_AncientHead
	.long 0
	.long 0
	.long 0
	.long .LC257
	.long .LC279
	.long 1
	.long 0
	.long .LC280
	.long .LC281
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long .LC282
	.long Pickup_Adrenaline
	.long 0
	.long 0
	.long 0
	.long .LC257
	.long .LC283
	.long 1
	.long 0
	.long .LC284
	.long .LC285
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long .LC286
	.long Pickup_Bandolier
	.long 0
	.long 0
	.long 0
	.long .LC257
	.long .LC249
	.long 1
	.long 0
	.long .LC250
	.long .LC287
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long .LC288
	.long Pickup_Pack
	.long 0
	.long 0
	.long 0
	.long .LC257
	.long .LC289
	.long 1
	.long 0
	.long .LC290
	.long .LC291
	.long 2
	.long 180
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long .LC292
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC257
	.long .LC293
	.long 1
	.long 0
	.long .LC294
	.long .LC295
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC90
	.long .LC40
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC257
	.long .LC296
	.long 1
	.long 0
	.long .LC297
	.long .LC298
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC90
	.long .LC299
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC257
	.long .LC300
	.long 1
	.long 0
	.long .LC301
	.long .LC302
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC90
	.long .LC303
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC257
	.long .LC304
	.long 1
	.long 0
	.long .LC305
	.long .LC306
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC90
	.long .LC307
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC257
	.long .LC308
	.long 1
	.long 0
	.long .LC309
	.long .LC310
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC90
	.long .LC311
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC257
	.long .LC312
	.long 1
	.long 0
	.long .LC313
	.long .LC314
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC90
	.long .LC315
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC257
	.long .LC316
	.long 1
	.long 0
	.long .LC317
	.long .LC318
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC90
	.long .LC319
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC257
	.long .LC320
	.long 2
	.long 0
	.long .LC321
	.long .LC322
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC90
	.long .LC323
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC257
	.long .LC324
	.long 1
	.long 0
	.long .LC325
	.long .LC326
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC90
	.long 0
	.long Pickup_Health
	.long 0
	.long 0
	.long 0
	.long .LC257
	.long 0
	.long 0
	.long 0
	.long .LC327
	.long .LC328
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long 0
	.space	68
	.section	".rodata"
	.align 2
.LC328:
	.string	"Health"
	.align 2
.LC327:
	.string	"i_health"
	.align 2
.LC326:
	.string	"Airstrike Marker"
	.align 2
.LC325:
	.string	"i_airstrike"
	.align 2
.LC324:
	.string	"models/items/keys/target/tris.md2"
	.align 2
.LC323:
	.string	"key_airstrike_target"
	.align 2
.LC322:
	.string	"Commander's Head"
	.align 2
.LC321:
	.string	"k_comhead"
	.align 2
.LC320:
	.string	"models/monsters/commandr/head/tris.md2"
	.align 2
.LC319:
	.string	"key_commander_head"
	.align 2
.LC318:
	.string	"Red Key"
	.align 2
.LC317:
	.string	"k_redkey"
	.align 2
.LC316:
	.string	"models/items/keys/red_key/tris.md2"
	.align 2
.LC315:
	.string	"key_red_key"
	.align 2
.LC314:
	.string	"Blue Key"
	.align 2
.LC313:
	.string	"k_bluekey"
	.align 2
.LC312:
	.string	"models/items/keys/key/tris.md2"
	.align 2
.LC311:
	.string	"key_blue_key"
	.align 2
.LC310:
	.string	"Security Pass"
	.align 2
.LC309:
	.string	"k_security"
	.align 2
.LC308:
	.string	"models/items/keys/pass/tris.md2"
	.align 2
.LC307:
	.string	"key_pass"
	.align 2
.LC306:
	.string	"Data Spinner"
	.align 2
.LC305:
	.string	"k_dataspin"
	.align 2
.LC304:
	.string	"models/items/keys/spinner/tris.md2"
	.align 2
.LC303:
	.string	"key_data_spinner"
	.align 2
.LC302:
	.string	"Pyramid Key"
	.align 2
.LC301:
	.string	"k_pyramid"
	.align 2
.LC300:
	.string	"models/items/keys/pyramid/tris.md2"
	.align 2
.LC299:
	.string	"key_pyramid"
	.align 2
.LC298:
	.string	"Power Cube"
	.align 2
.LC297:
	.string	"k_powercube"
	.align 2
.LC296:
	.string	"models/items/keys/power/tris.md2"
	.align 2
.LC295:
	.string	"Data CD"
	.align 2
.LC294:
	.string	"k_datacd"
	.align 2
.LC293:
	.string	"models/items/keys/data_cd/tris.md2"
	.align 2
.LC292:
	.string	"key_data_cd"
	.align 2
.LC291:
	.string	"Ammo Pack"
	.align 2
.LC290:
	.string	"i_pack"
	.align 2
.LC289:
	.string	"models/items/pack/tris.md2"
	.align 2
.LC288:
	.string	"item_pack"
	.align 2
.LC287:
	.string	"NogBandolier"
	.align 2
.LC286:
	.string	"item_bandolier"
	.align 2
.LC285:
	.string	"Adrenaline"
	.align 2
.LC284:
	.string	"p_adrenaline"
	.align 2
.LC283:
	.string	"models/items/adrenal/tris.md2"
	.align 2
.LC282:
	.string	"item_adrenaline"
	.align 2
.LC281:
	.string	"Ancient Head"
	.align 2
.LC280:
	.string	"i_fixme"
	.align 2
.LC279:
	.string	"models/items/c_head/tris.md2"
	.align 2
.LC278:
	.string	"item_ancient_head"
	.align 2
.LC277:
	.string	"Environment Suit"
	.align 2
.LC276:
	.string	"p_envirosuit"
	.align 2
.LC275:
	.string	"models/items/enviro/tris.md2"
	.align 2
.LC274:
	.string	"item_enviro"
	.align 2
.LC273:
	.string	"items/airout.wav"
	.align 2
.LC272:
	.string	"Rebreather"
	.align 2
.LC271:
	.string	"p_rebreather"
	.align 2
.LC270:
	.string	"models/items/breather/tris.md2"
	.align 2
.LC269:
	.string	"item_breather"
	.align 2
.LC268:
	.string	"models/items/silencer/tris.md2"
	.align 2
.LC267:
	.string	"item_silencer"
	.align 2
.LC266:
	.string	"items/protect.wav items/protect2.wav items/protect4.wav"
	.align 2
.LC265:
	.string	"Invulnerability"
	.align 2
.LC264:
	.string	"p_invulnerability"
	.align 2
.LC263:
	.string	"models/items/invulner/tris.md2"
	.align 2
.LC262:
	.string	"item_invulnerability"
	.align 2
.LC261:
	.string	"items/damage.wav items/damage2.wav items/damage3.wav"
	.align 2
.LC260:
	.string	"Quad Damage"
	.align 2
.LC259:
	.string	"p_quad"
	.align 2
.LC258:
	.string	"models/items/quaddama/tris.md2"
	.align 2
.LC257:
	.string	"items/pkup.wav"
	.align 2
.LC256:
	.string	"item_quad"
	.align 2
.LC255:
	.string	"p_laser"
	.align 2
.LC254:
	.string	"models/items/laser/tris.md2"
	.align 2
.LC253:
	.string	"misc/lasersight.wav"
	.align 2
.LC252:
	.string	"item_lasersight"
	.align 2
.LC251:
	.string	"item_vest"
	.align 2
.LC250:
	.string	"p_bandolier"
	.align 2
.LC249:
	.string	"models/items/band/tris.md2"
	.align 2
.LC248:
	.string	"item_band"
	.align 2
.LC247:
	.string	"slippers"
	.align 2
.LC246:
	.string	"models/items/slippers/slippers.md2"
	.align 2
.LC245:
	.string	"misc/veston.wav"
	.align 2
.LC244:
	.string	"item_slippers"
	.align 2
.LC243:
	.string	"p_silencer"
	.align 2
.LC242:
	.string	"models/items/quiet/tris.md2"
	.align 2
.LC241:
	.string	"misc/screw.wav"
	.align 2
.LC240:
	.string	"item_quiet"
	.align 2
.LC239:
	.string	"models/items/ammo/sniper/tris.md2"
	.align 2
.LC238:
	.string	"ammo_sniper"
	.align 2
.LC237:
	.string	"ammo_m3"
	.align 2
.LC236:
	.string	"a_m4"
	.align 2
.LC235:
	.string	"models/items/ammo/m4/tris.md2"
	.align 2
.LC234:
	.string	"ammo_m4"
	.align 2
.LC233:
	.string	"a_mag"
	.align 2
.LC232:
	.string	"models/items/ammo/mag/tris.md2"
	.align 2
.LC231:
	.string	"ammo_mag"
	.align 2
.LC230:
	.string	"a_clip"
	.align 2
.LC229:
	.string	"models/items/ammo/clip/tris.md2"
	.align 2
.LC228:
	.string	"ammo_clip"
	.align 2
.LC227:
	.string	"a_slugs"
	.align 2
.LC226:
	.string	"models/items/ammo/slugs/medium/tris.md2"
	.align 2
.LC225:
	.string	"ammo_slugs"
	.align 2
.LC224:
	.string	"a_rockets"
	.align 2
.LC223:
	.string	"models/items/ammo/rockets/medium/tris.md2"
	.align 2
.LC222:
	.string	"ammo_rockets"
	.align 2
.LC221:
	.string	"a_cells"
	.align 2
.LC220:
	.string	"models/items/ammo/cells/medium/tris.md2"
	.align 2
.LC219:
	.string	"ammo_cells"
	.align 2
.LC218:
	.string	"a_bullets"
	.align 2
.LC217:
	.string	"models/items/ammo/bullets/medium/tris.md2"
	.align 2
.LC216:
	.string	"ammo_bullets"
	.align 2
.LC215:
	.string	"a_shells"
	.align 2
.LC214:
	.string	"models/items/ammo/shells/medium/tris.md2"
	.align 2
.LC213:
	.string	"ammo_shells"
	.align 2
.LC212:
	.string	"misc/grenade.wav"
	.align 2
.LC211:
	.string	"a_m61frag"
	.align 2
.LC210:
	.string	"models/objects/grenade2/tris.md2"
	.align 2
.LC209:
	.string	"weapon_Grenade"
	.align 2
.LC208:
	.string	"weapons/throw.wav weapons/stab.wav weapons/swish.wav weapons/clank.wav"
	.align 2
.LC207:
	.string	"w_knife"
	.align 2
.LC206:
	.string	"models/weapons/v_knife/tris.md2"
	.align 2
.LC205:
	.string	"models/objects/knife/tris.md2"
	.align 2
.LC204:
	.string	"weapon_Knife"
	.align 2
.LC203:
	.string	"weapons/mk23fire.wav weapons/mk23in.wav weapons/mk23out.wav weapons/mk23slap.wav weapons/mk23slide.wav"
	.align 2
.LC202:
	.string	"Dual MK23 Pistols"
	.align 2
.LC201:
	.string	"w_akimbo"
	.align 2
.LC200:
	.string	"models/weapons/v_dual/tris.md2"
	.align 2
.LC199:
	.string	"weapon_Dual"
	.align 2
.LC198:
	.string	"weapons/ssgbolt.wav weapons/ssgfire.wav weapons/ssgin.wav misc/lensflik.wav"
	.align 2
.LC197:
	.string	"Sniper Rifle"
	.align 2
.LC196:
	.string	"w_sniper"
	.align 2
.LC195:
	.string	"models/weapons/v_sniper/tris.md2"
	.align 2
.LC194:
	.string	"models/weapons/g_sniper/tris.md2"
	.align 2
.LC193:
	.string	"weapon_Sniper"
	.align 2
.LC192:
	.string	"weapons/cannon_fire.wav weapons/cclose.wav weapons/cin.wav weapons/cout.wav weapons/copen.wav"
	.align 2
.LC191:
	.string	"Handcannon"
	.align 2
.LC190:
	.string	"w_cannon"
	.align 2
.LC189:
	.string	"models/weapons/v_cannon/tris.md2"
	.align 2
.LC188:
	.string	"models/weapons/g_cannon/tris.md2"
	.align 2
.LC187:
	.string	"weapon_HC"
	.align 2
.LC186:
	.string	"weapons/m3in.wav weapons/shotgf1b.wav"
	.align 2
.LC185:
	.string	"M3 Super 90 Assault Shotgun"
	.align 2
.LC184:
	.string	"w_super90"
	.align 2
.LC183:
	.string	"weapon_M3"
	.align 2
.LC182:
	.string	"weapons/m4a1fire.wav weapons/m4a1in.wav weapons/m4a1out.wav weapons/m4a1slide.wav"
	.align 2
.LC181:
	.string	"M4 Assault Rifle"
	.align 2
.LC180:
	.string	"w_m4"
	.align 2
.LC179:
	.string	"models/weapons/v_m4/tris.md2"
	.align 2
.LC178:
	.string	"models/weapons/g_m4/tris.md2"
	.align 2
.LC177:
	.string	"weapon_M4"
	.align 2
.LC176:
	.string	"weapons/mp5fire1.wav weapons/mp5in.wav weapons/mp5out.wav weapons/mp5slap.wav weapons/mp5slide.wav"
	.align 2
.LC175:
	.string	"MP5/10 Submachinegun"
	.align 2
.LC174:
	.string	"w_mp5"
	.align 2
.LC173:
	.string	"weapon_MP5"
	.align 2
.LC172:
	.string	"weapons/mk23fire.wav weapons/mk23in.wav weapons/mk23out.wav weapons/mk23slap.wav weapons/mk23slide.wav misc/click.wav"
	.align 2
.LC171:
	.string	"MK23 Pistol"
	.align 2
.LC170:
	.string	"w_mk23"
	.align 2
.LC169:
	.string	"models/weapons/g_dual/tris.md2"
	.align 2
.LC168:
	.string	"weapon_Mk23"
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
	.string	"Railgun"
	.align 2
.LC162:
	.string	"w_railgun"
	.align 2
.LC161:
	.string	"models/weapons/v_rail/tris.md2"
	.align 2
.LC160:
	.string	"models/weapons/g_rail/tris.md2"
	.align 2
.LC159:
	.string	"weapon_railgun"
	.align 2
.LC158:
	.string	"HyperBlaster"
	.align 2
.LC157:
	.string	"w_hyperblaster"
	.align 2
.LC156:
	.string	"models/weapons/v_hyperb/tris.md2"
	.align 2
.LC155:
	.string	"models/weapons/g_hyperb/tris.md2"
	.align 2
.LC154:
	.string	"weapon_hyperblaster"
	.align 2
.LC153:
	.string	"Rocket Launcher"
	.align 2
.LC152:
	.string	"w_rlauncher"
	.align 2
.LC151:
	.string	"models/weapons/v_rocket/tris.md2"
	.align 2
.LC150:
	.string	"models/weapons/g_rocket/tris.md2"
	.align 2
.LC149:
	.string	"weapon_rocketlauncher"
	.align 2
.LC148:
	.string	"Grenade Launcher"
	.align 2
.LC147:
	.string	"w_glauncher"
	.align 2
.LC146:
	.string	"models/weapons/v_launch/tris.md2"
	.align 2
.LC145:
	.string	"models/weapons/g_launch/tris.md2"
	.align 2
.LC144:
	.string	"weapon_grenadelauncher"
	.align 2
.LC143:
	.string	"weapons/hgrent1a.wav weapons/hgrena1b.wav weapons/hgrenc1b.wav weapons/hgrenb1a.wav weapons/hgrenb2a.wav "
	.align 2
.LC142:
	.string	"grenades"
	.align 2
.LC141:
	.string	"a_grenades"
	.align 2
.LC140:
	.string	"models/weapons/v_handgr/tris.md2"
	.align 2
.LC139:
	.string	"models/items/ammo/grenades/medium/tris.md2"
	.align 2
.LC138:
	.string	"misc/am_pkup.wav"
	.align 2
.LC137:
	.string	"ammo_grenades"
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
	.string	"Machinegun"
	.align 2
.LC130:
	.string	"w_machinegun"
	.align 2
.LC129:
	.string	"models/weapons/v_machn/tris.md2"
	.align 2
.LC128:
	.string	"models/weapons/g_machn/tris.md2"
	.align 2
.LC127:
	.string	"weapon_machinegun"
	.align 2
.LC126:
	.string	"Super Shotgun"
	.align 2
.LC125:
	.string	"w_sshotgun"
	.align 2
.LC124:
	.string	"models/weapons/v_shotg2/tris.md2"
	.align 2
.LC123:
	.string	"models/weapons/g_shotg2/tris.md2"
	.align 2
.LC122:
	.string	"weapon_supershotgun"
	.align 2
.LC121:
	.string	"Shotgun"
	.align 2
.LC120:
	.string	"w_shotgun"
	.align 2
.LC119:
	.string	"models/weapons/v_shotg/tris.md2"
	.align 2
.LC118:
	.string	"models/weapons/g_shotg/tris.md2"
	.align 2
.LC117:
	.string	"weapon_shotgun"
	.align 2
.LC116:
	.string	"Blaster"
	.align 2
.LC115:
	.string	"w_blaster"
	.align 2
.LC114:
	.string	"models/weapons/v_blast/tris.md2"
	.align 2
.LC113:
	.string	"misc/w_pkup.wav"
	.align 2
.LC112:
	.string	"weapon_blaster"
	.align 2
.LC111:
	.string	"Power Shield"
	.align 2
.LC110:
	.string	"i_powershield"
	.align 2
.LC109:
	.string	"models/items/armor/shield/tris.md2"
	.align 2
.LC108:
	.string	"item_power_shield"
	.align 2
.LC107:
	.string	"Power Screen"
	.align 2
.LC106:
	.string	"i_powerscreen"
	.align 2
.LC105:
	.string	"models/items/armor/screen/tris.md2"
	.align 2
.LC104:
	.string	"misc/ar3_pkup.wav"
	.align 2
.LC103:
	.string	"item_power_screen"
	.align 2
.LC102:
	.string	"Armor Shard"
	.align 2
.LC101:
	.string	"models/items/armor/shard/tris.md2"
	.align 2
.LC100:
	.string	"misc/ar2_pkup.wav"
	.align 2
.LC99:
	.string	"item_armor_shard"
	.align 2
.LC98:
	.string	"Jacket Armor"
	.align 2
.LC97:
	.string	"i_jacketarmor"
	.align 2
.LC96:
	.string	"models/items/armor/jacket/tris.md2"
	.align 2
.LC95:
	.string	"item_armor_jacket"
	.align 2
.LC94:
	.string	"Combat Armor"
	.align 2
.LC93:
	.string	"i_combatarmor"
	.align 2
.LC92:
	.string	"models/items/armor/combat/tris.md2"
	.align 2
.LC91:
	.string	"item_armor_combat"
	.align 2
.LC90:
	.string	""
	.align 2
.LC89:
	.string	"Body Armor"
	.align 2
.LC88:
	.string	"i_bodyarmor"
	.align 2
.LC87:
	.string	"models/items/armor/body/tris.md2"
	.align 2
.LC86:
	.string	"misc/ar1_pkup.wav"
	.align 2
.LC85:
	.string	"item_armor_body"
	.size	 itemlist,4464
	.align 2
.LC329:
	.string	"models/items/healing/medium/tris.md2"
	.align 2
.LC330:
	.string	"models/items/healing/stimpack/tris.md2"
	.align 2
.LC331:
	.string	"models/items/healing/large/tris.md2"
	.align 2
.LC332:
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
	bc 4,0,.L676
	lis 11,itemlist@ha
	lis 9,gi@ha
	la 11,itemlist@l(11)
	la 28,gi@l(9)
	mr 29,10
	addi 30,11,40
.L678:
	lwz 9,24(28)
	addi 3,31,1056
	lwz 4,0(30)
	addi 31,31,1
	mtlr 9
	addi 30,30,72
	blrl
	lwz 0,1556(29)
	cmpw 0,31,0
	bc 12,0,.L678
.L676:
	lis 9,game@ha
	lis 11,jacket_armor_index@ha
	la 10,game@l(9)
	li 30,0
	lwz 0,1556(10)
	la 27,jacket_armor_index@l(11)
	lis 9,.LC98@ha
	lis 11,itemlist@ha
	la 28,.LC98@l(9)
	cmpw 0,30,0
	la 31,itemlist@l(11)
	bc 4,0,.L687
	mr 29,10
.L682:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L684
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L684
	mr 11,31
	b .L686
.L684:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L682
.L687:
	li 11,0
.L686:
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
	lis 10,.LC94@ha
	la 26,combat_armor_index@l(9)
	srawi 11,11,3
	la 28,.LC94@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L695
	mr 29,7
.L690:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L692
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L692
	mr 11,31
	b .L694
.L692:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L690
.L695:
	li 11,0
.L694:
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
	lis 10,.LC89@ha
	la 27,body_armor_index@l(9)
	srawi 11,11,3
	la 28,.LC89@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L703
	mr 29,7
.L698:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L700
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L700
	mr 11,31
	b .L702
.L700:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L698
.L703:
	li 11,0
.L702:
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
	lis 10,.LC107@ha
	la 26,power_screen_index@l(9)
	srawi 11,11,3
	la 28,.LC107@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L711
	mr 29,7
.L706:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L708
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L708
	mr 11,31
	b .L710
.L708:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L706
.L711:
	li 11,0
.L710:
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
	lis 10,.LC111@ha
	la 27,power_shield_index@l(9)
	srawi 11,11,3
	la 28,.LC111@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L719
	mr 29,7
.L714:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L716
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L716
	mr 8,31
	b .L718
.L716:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L714
.L719:
	li 8,0
.L718:
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
.Lfe21:
	.size	 SetItemNames,.Lfe21-SetItemNames
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
	li 0,61
	stw 0,game+1556@l(9)
	blr
.Lfe22:
	.size	 InitItems,.Lfe22-InitItems
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
	b .L720
.L20:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L21
.L19:
	li 3,0
.L720:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 FindItem,.Lfe23-FindItem
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
	b .L721
.L12:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L13
.L11:
	li 3,0
.L721:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 FindItemByClassname,.Lfe24-FindItemByClassname
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
.Lfe25:
	.size	 SetRespawn,.Lfe25-SetRespawn
	.align 2
	.globl ArmorIndex
	.type	 ArmorIndex,@function
ArmorIndex:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L481
	li 3,0
	blr
.L481:
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
.Lfe26:
	.size	 ArmorIndex,.Lfe26-ArmorIndex
	.align 2
	.globl PowerArmorType
	.type	 PowerArmorType,@function
PowerArmorType:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L510
.L724:
	li 3,0
	blr
.L510:
	lwz 0,264(3)
	andi. 9,0,4096
	bc 12,2,.L724
	lis 9,power_shield_index@ha
	addi 11,11,740
	lwz 0,power_shield_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L512
	lis 9,power_screen_index@ha
	lwz 0,power_screen_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	srawi 3,9,31
	subf 3,9,3
	srwi 3,3,31
	blr
.L512:
	li 3,2
	blr
.Lfe27:
	.size	 PowerArmorType,.Lfe27-PowerArmorType
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
.Lfe28:
	.size	 GetItemByIndex,.Lfe28-GetItemByIndex
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
.Lfe29:
	.size	 DoRespawn,.Lfe29-DoRespawn
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
.Lfe30:
	.size	 Drop_General,.Lfe30-Drop_General
	.section	".rodata"
	.align 2
.LC333:
	.long 0x0
	.align 3
.LC334:
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
	lis 9,.LC333@ha
	lis 11,deathmatch@ha
	la 9,.LC333@l(9)
	mr 12,3
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L288
	lwz 9,484(4)
	addi 9,9,1
	stw 9,484(4)
.L288:
	lwz 0,480(4)
	lwz 9,484(4)
	cmpw 0,0,9
	bc 4,0,.L289
	stw 9,480(4)
.L289:
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L290
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L290
	lis 9,.LC334@ha
	lwz 11,648(12)
	la 9,.LC334@l(9)
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
.L290:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 Pickup_Adrenaline,.Lfe31-Pickup_Adrenaline
	.section	".rodata"
	.align 2
.LC335:
	.long 0x0
	.align 3
.LC336:
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
	bc 4,2,.L293
	lis 9,.LC335@ha
	lis 11,deathmatch@ha
	la 9,.LC335@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L293
	lis 9,.LC336@ha
	lwz 11,648(12)
	la 9,.LC336@l(9)
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
.L293:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe32:
	.size	 Pickup_AncientHead,.Lfe32-Pickup_AncientHead
	.section	".rodata"
	.align 3
.LC337:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC338:
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
	lis 9,.LC337@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC337@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,4140(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L398
	lis 9,.LC338@ha
	la 9,.LC338@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L726
.L398:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L726:
	stfs 0,4140(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe33:
	.size	 Use_Breather,.Lfe33-Use_Breather
	.section	".rodata"
	.align 3
.LC339:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC340:
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
	lis 9,.LC339@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC339@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,4144(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L401
	lis 9,.LC340@ha
	la 9,.LC340@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L727
.L401:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L727:
	stfs 0,4144(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe34:
	.size	 Use_Envirosuit,.Lfe34-Use_Envirosuit
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
	lwz 9,4156(11)
	addi 9,9,30
	stw 9,4156(11)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 Use_Silencer,.Lfe35-Use_Silencer
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
	bc 12,0,.L456
	stw 10,532(11)
	b .L457
.L456:
	stw 0,532(11)
.L457:
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
.Lfe36:
	.size	 Drop_Ammo,.Lfe36-Drop_Ammo
	.section	".rodata"
	.align 2
.LC341:
	.long 0x3f800000
	.align 2
.LC342:
	.long 0x0
	.align 2
.LC343:
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
	bc 4,1,.L459
	lis 10,.LC341@ha
	lis 9,level+4@ha
	la 10,.LC341@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(7)
	lwz 9,480(11)
	addi 9,9,-1
	stw 9,480(11)
	b .L458
.L459:
	lwz 0,284(7)
	andis. 6,0,0x1
	bc 4,2,.L460
	lis 9,.LC342@ha
	lis 11,deathmatch@ha
	la 9,.LC342@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L460
	lwz 9,264(7)
	lis 11,.LC343@ha
	lis 10,level+4@ha
	lwz 0,184(7)
	la 11,.LC343@l(11)
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
	b .L458
.L460:
	mr 3,7
	bl G_FreeEdict
.L458:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 MegaHealth_think,.Lfe37-MegaHealth_think
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
	bc 12,2,.L533
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
	bc 4,2,.L533
	bl Use_PowerArmor
.L533:
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
.Lfe38:
	.size	 Drop_PowerArmor,.Lfe38-Drop_PowerArmor
	.align 2
	.type	 drop_temp_touch,@function
drop_temp_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,256(3)
	cmpw 0,4,0
	bc 12,2,.L551
	bl Touch_Item
.L551:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe39:
	.size	 drop_temp_touch,.Lfe39-drop_temp_touch
	.section	".rodata"
	.align 2
.LC344:
	.long 0x0
	.align 2
.LC345:
	.long 0x42ee0000
	.section	".text"
	.align 2
	.type	 drop_make_touchable,@function
drop_make_touchable:
	lis 9,Touch_Item@ha
	lis 11,deathmatch@ha
	la 9,Touch_Item@l(9)
	lwz 10,deathmatch@l(11)
	stw 9,444(3)
	lis 9,.LC344@ha
	lfs 0,20(10)
	la 9,.LC344@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bclr 12,2
	lis 9,.LC345@ha
	lis 11,level+4@ha
	la 9,.LC345@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,436(3)
	stfs 0,428(3)
	blr
.Lfe40:
	.size	 drop_make_touchable,.Lfe40-drop_make_touchable
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
	bc 12,2,.L564
	li 0,2
	stw 11,444(3)
	stw 0,248(3)
	b .L565
.L564:
	lis 9,Touch_Item@ha
	li 0,1
	la 9,Touch_Item@l(9)
	stw 0,248(3)
	stw 9,444(3)
.L565:
	lis 9,gi+72@ha
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe41:
	.size	 Use_Item,.Lfe41-Use_Item
	.align 2
	.globl SP_item_health
	.type	 SP_item_health,@function
SP_item_health:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe42:
	.size	 SP_item_health,.Lfe42-SP_item_health
	.align 2
	.globl SP_item_health_small
	.type	 SP_item_health_small,@function
SP_item_health_small:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe43:
	.size	 SP_item_health_small,.Lfe43-SP_item_health_small
	.align 2
	.globl SP_item_health_large
	.type	 SP_item_health_large,@function
SP_item_health_large:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe44:
	.size	 SP_item_health_large,.Lfe44-SP_item_health_large
	.align 2
	.globl SP_item_health_mega
	.type	 SP_item_health_mega,@function
SP_item_health_mega:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe45:
	.size	 SP_item_health_mega,.Lfe45-SP_item_health_mega
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
