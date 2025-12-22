	.file	"g_items.c"
gcc2_compiled.:
	.globl jacketarmor_info
	.section	".data"
	.align 2
	.type	 jacketarmor_info,@object
	.size	 jacketarmor_info,16
jacketarmor_info:
	.long 25
	.long 50
	.long 0x3e99999a
	.long 0x0
	.globl combatarmor_info
	.align 2
	.type	 combatarmor_info,@object
	.size	 combatarmor_info,16
combatarmor_info:
	.long 50
	.long 100
	.long 0x3f19999a
	.long 0x3e99999a
	.globl bodyarmor_info
	.align 2
	.type	 bodyarmor_info,@object
	.size	 bodyarmor_info,16
bodyarmor_info:
	.long 100
	.long 200
	.long 0x3f4ccccd
	.long 0x3f19999a
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
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	lis 11,skill@ha
	lis 9,itemlist@ha
	lwz 6,648(31)
	lis 0,0x286b
	lwz 10,skill@l(11)
	la 9,itemlist@l(9)
	lis 8,.LC1@ha
	ori 0,0,51739
	la 8,.LC1@l(8)
	mr 30,4
	subf 9,9,6
	lfs 0,0(8)
	mullw 9,9,0
	lfs 13,20(10)
	lwz 11,84(30)
	rlwinm 7,9,0,0,29
	addi 11,11,740
	fcmpu 7,13,0
	lwzx 10,11,7
	cmpwi 6,10,1
	mfcr 0
	rlwinm 9,0,31,1
	rlwinm 0,0,26,1
	and. 8,9,0
	bc 4,2,.L57
	lis 9,.LC2@ha
	srawi 0,10,31
	la 9,.LC2@l(9)
	subf 0,10,0
	lfs 0,0(9)
	srwi 8,0,31
	fcmpu 7,13,0
	cror 31,30,29
	mfcr 9
	rlwinm 9,9,0,1
	and. 0,9,8
	bc 4,2,.L57
	lwz 0,56(6)
	rlwinm 0,0,29,31,31
	and. 9,0,8
	bc 12,2,.L50
.L57:
	li 3,0
	b .L56
.L50:
	addi 9,10,1
	stwx 9,11,7
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L51
	lis 9,.LC3@ha
	lwz 11,648(31)
	la 9,.LC3@l(9)
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
.L51:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,16
	bc 4,2,.L54
	lwz 9,648(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L53
	lwz 0,284(31)
	andis. 8,0,2
	bc 12,2,.L53
.L54:
	lwz 9,648(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L55
	lwz 0,284(31)
	andis. 9,0,2
	bc 12,2,.L55
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
.L55:
	lwz 9,648(31)
	mr 3,30
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L53:
	li 3,1
.L56:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
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
	mr 29,4
	mr 28,3
	lwz 9,84(29)
	lwz 0,1764(9)
	cmpwi 0,0,249
	bc 12,1,.L68
	li 0,250
	stw 0,1764(9)
.L68:
	lwz 9,84(29)
	lwz 0,1768(9)
	cmpwi 0,0,149
	bc 12,1,.L69
	li 0,150
	stw 0,1768(9)
.L69:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,249
	bc 12,1,.L70
	li 0,250
	stw 0,1780(9)
.L70:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,74
	bc 12,1,.L71
	li 0,75
	stw 0,1784(9)
.L71:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC4@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC4@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L79
	mr 27,10
.L74:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L76
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L76
	mr 8,31
	b .L78
.L76:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L74
.L79:
	li 8,0
.L78:
	cmpwi 0,8,0
	bc 12,2,.L80
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
	bc 4,1,.L80
	stwx 11,9,8
.L80:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC5@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC5@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L89
	mr 27,10
.L84:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L86
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L86
	mr 8,31
	b .L88
.L86:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L84
.L89:
	li 8,0
.L88:
	cmpwi 0,8,0
	bc 12,2,.L90
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
	bc 4,1,.L90
	stwx 11,4,8
.L90:
	lwz 0,284(28)
	andis. 4,0,0x1
	bc 4,2,.L92
	lis 9,.LC6@ha
	lwz 11,648(28)
	la 9,.LC6@l(9)
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
.L92:
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
	.align 3
.LC11:
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
	lis 11,.LC4@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC4@l(11)
	mr 27,3
	mr 29,4
	cmpw 0,30,0
	la 31,itemlist@l(9)
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
	lis 11,.LC5@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC5@l(11)
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
	lis 11,.LC7@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC7@l(11)
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
	lis 11,.LC8@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC8@l(11)
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
	lis 11,.LC9@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC9@l(11)
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
	lis 11,.LC10@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC10@l(11)
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
	lis 9,.LC11@ha
	lwz 11,648(27)
	la 9,.LC11@l(9)
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
.LC12:
	.string	"items/damage.wav"
	.align 3
.LC13:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC14:
	.long 0x3f800000
	.align 2
.LC15:
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
	lis 6,.LC13@ha
	la 6,.LC13@l(6)
	lfs 12,2196(8)
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
	stfs 0,2196(8)
	lis 29,gi@ha
	lis 3,.LC12@ha
	la 29,gi@l(29)
	la 3,.LC12@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 6,.LC14@ha
	lwz 0,16(29)
	lis 9,.LC14@ha
	la 6,.LC14@l(6)
	mr 5,3
	lfs 1,0(6)
	la 9,.LC14@l(9)
	li 4,3
	mtlr 0
	lis 6,.LC15@ha
	mr 3,31
	lfs 2,0(9)
	la 6,.LC15@l(6)
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
.LC16:
	.string	"items/protect.wav"
	.align 3
.LC17:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC18:
	.long 0x43960000
	.align 2
.LC19:
	.long 0x3f800000
	.align 2
.LC20:
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
	lis 9,.LC17@ha
	lis 11,level@ha
	lwz 10,84(31)
	la 9,.LC17@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,2200(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L170
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
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
	stfs 0,2200(10)
	lis 29,gi@ha
	lis 3,.LC16@ha
	la 29,gi@l(29)
	la 3,.LC16@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC19@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC19@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfs 2,0(9)
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 Use_Invulnerability,.Lfe5-Use_Invulnerability
	.align 2
	.globl Add_Ammo
	.type	 Add_Ammo,@function
Add_Ammo:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	mr 29,5
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L194
	lwz 0,68(30)
	cmpwi 0,0,0
	bc 4,2,.L177
	lwz 9,84(31)
	mr 10,9
	lwz 11,1764(9)
	b .L178
.L177:
	cmpwi 0,0,1
	bc 4,2,.L179
	lwz 9,84(31)
	mr 10,9
	lwz 11,1768(9)
	b .L178
.L179:
	cmpwi 0,0,2
	bc 4,2,.L181
	lwz 9,84(31)
	mr 10,9
	lwz 11,1772(9)
	b .L178
.L181:
	cmpwi 0,0,3
	bc 4,2,.L183
	lwz 9,84(31)
	mr 10,9
	lwz 11,1776(9)
	b .L178
.L183:
	cmpwi 0,0,4
	bc 4,2,.L185
	lwz 9,84(31)
	mr 10,9
	lwz 11,1780(9)
	b .L178
.L185:
	cmpwi 0,0,5
	bc 4,2,.L187
	lwz 9,84(31)
	mr 10,9
	lwz 11,1784(9)
	b .L178
.L187:
	cmpwi 0,0,6
	bc 4,2,.L194
	lwz 10,84(31)
	li 11,5
.L178:
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,30
	addi 10,10,740
	mullw 9,9,0
	rlwinm 4,9,0,0,29
	lwzx 0,10,4
	cmpw 0,0,11
	bc 4,2,.L191
.L194:
	li 3,0
	b .L193
.L191:
	add 0,0,29
	stwx 0,10,4
	lwz 9,84(31)
	addi 3,9,740
	lwzx 0,3,4
	cmpw 0,0,11
	bc 4,1,.L192
	stwx 11,3,4
.L192:
	li 3,1
.L193:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 Add_Ammo,.Lfe6-Add_Ammo
	.section	".rodata"
	.align 2
.LC21:
	.string	"blaster"
	.align 2
.LC22:
	.long 0x0
	.align 2
.LC23:
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
	bc 12,2,.L196
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8192
	li 5,1000
	bc 4,2,.L197
.L196:
	lwz 5,532(30)
	cmpwi 0,5,0
	bc 12,2,.L198
	lwz 4,648(30)
	b .L197
.L198:
	lwz 9,648(30)
	lwz 5,48(9)
	mr 4,9
.L197:
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
	bc 4,2,.L200
	li 3,0
	b .L214
.L215:
	mr 9,31
	b .L210
.L200:
	subfic 9,31,0
	adde 0,9,31
	and. 11,29,0
	bc 12,2,.L201
	lwz 25,84(28)
	lwz 9,648(30)
	lwz 0,1788(25)
	cmpw 0,0,9
	bc 12,2,.L201
	lis 9,.LC22@ha
	lis 11,deathmatch@ha
	la 9,.LC22@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L203
	lis 9,game@ha
	li 29,0
	la 9,game@l(9)
	lis 11,.LC21@ha
	lwz 0,1556(9)
	la 26,.LC21@l(11)
	mr 31,27
	cmpw 0,29,0
	bc 4,0,.L211
	mr 27,9
.L206:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L208
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L215
.L208:
	lwz 0,1556(27)
	addi 29,29,1
	addi 31,31,76
	cmpw 0,29,0
	bc 12,0,.L206
.L211:
	li 9,0
.L210:
	lwz 0,1788(25)
	cmpw 0,0,9
	bc 4,2,.L201
.L203:
	lwz 9,84(28)
	lwz 0,648(30)
	stw 0,2020(9)
.L201:
	lwz 0,284(30)
	andis. 7,0,0x3
	bc 4,2,.L212
	lwz 9,264(30)
	lis 11,.LC23@ha
	lis 10,level+4@ha
	lwz 0,184(30)
	la 11,.LC23@l(11)
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
.L212:
	li 3,1
.L214:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe7:
	.size	 Pickup_Ammo,.Lfe7-Pickup_Ammo
	.section	".rodata"
	.align 2
.LC24:
	.string	"items/s_health.wav"
	.align 2
.LC25:
	.string	"items/n_health.wav"
	.align 2
.LC26:
	.string	"items/l_health.wav"
	.align 2
.LC27:
	.string	"items/m_health.wav"
	.align 2
.LC28:
	.long 0x0
	.align 3
.LC29:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC30:
	.long 0x40a00000
	.align 2
.LC31:
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
	lwz 0,644(31)
	andi. 8,0,1
	bc 4,2,.L225
	lwz 9,480(30)
	lwz 0,484(30)
	cmpw 0,9,0
	bc 12,0,.L225
	lis 9,level+4@ha
	lfs 13,948(30)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L225
	li 3,0
	b .L245
.L225:
	lis 9,.LC28@ha
	lfs 0,948(30)
	la 9,.LC28@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 12,2,.L228
	bl rand
	lis 0,0x51eb
	srawi 9,3,31
	lwz 11,532(31)
	ori 0,0,34079
	mulhw 0,3,0
	srawi 0,0,5
	subf 0,9,0
	mulli 0,0,100
	subf 3,0,3
	cmpw 0,3,11
	bc 4,0,.L229
	stfs 31,948(30)
	b .L228
.L229:
	xoris 11,11,0x8000
	lfs 12,948(30)
	stw 11,12(1)
	lis 0,0x4330
	lis 8,.LC29@ha
	la 8,.LC29@l(8)
	stw 0,8(1)
	lfd 13,0(8)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fsubs 12,12,0
	stfs 12,948(30)
.L228:
	lwz 0,644(31)
	andi. 9,0,1
	bc 12,2,.L231
	lwz 0,480(30)
	lwz 9,532(31)
	add 0,0,9
	stw 0,480(30)
	b .L232
.L231:
	lwz 11,480(30)
	lwz 9,484(30)
	cmpw 0,11,9
	bc 4,0,.L232
	lwz 0,532(31)
	add 0,11,0
	cmpw 0,0,9
	stw 0,480(30)
	bc 4,1,.L232
	stw 9,480(30)
.L232:
	lwz 0,532(31)
	cmpwi 0,0,2
	bc 4,2,.L235
	lwz 11,648(31)
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	b .L246
.L235:
	cmpwi 0,0,10
	bc 4,2,.L237
	lwz 11,648(31)
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	b .L246
.L237:
	cmpwi 0,0,25
	bc 4,2,.L239
	lwz 11,648(31)
	lis 9,.LC26@ha
	la 9,.LC26@l(9)
	b .L246
.L239:
	lwz 11,648(31)
	lis 9,.LC27@ha
	la 9,.LC27@l(9)
.L246:
	stw 9,20(11)
	lwz 0,644(31)
	andi. 11,0,2
	bc 12,2,.L241
	lis 9,MegaHealth_think@ha
	lis 8,.LC30@ha
	lwz 11,264(31)
	la 9,MegaHealth_think@l(9)
	lis 10,level+4@ha
	lwz 0,184(31)
	stw 9,436(31)
	la 8,.LC30@l(8)
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
	b .L242
.L241:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L242
	lwz 9,264(31)
	lis 11,.LC31@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC31@l(11)
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
.L242:
	li 3,1
.L245:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 Pickup_Health,.Lfe8-Pickup_Health
	.section	".rodata"
	.align 3
.LC32:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC33:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl Pickup_Armor
	.type	 Pickup_Armor,@function
Pickup_Armor:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,4
	mr 30,3
	mr 3,31
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L285
	lwz 9,84(31)
	lwz 11,1884(9)
	cmpwi 0,11,0
	bc 4,2,.L261
.L285:
	li 10,0
	b .L260
.L261:
	lwz 9,648(30)
	li 10,1
	lwz 0,68(9)
	cmpwi 0,0,4
	bc 12,2,.L260
	xor 10,0,11
	subfic 9,10,0
	adde 10,9,10
.L260:
	cmpwi 0,10,0
	bc 12,2,.L286
	lwz 9,648(30)
	mr 3,31
	lwz 29,64(9)
	bl G_ClientExists
	cmpwi 0,3,0
	bc 4,2,.L264
	lwz 3,84(31)
	li 11,0
	b .L265
.L264:
	lis 9,jacket_armor_index@ha
	lwz 11,84(31)
	lwz 10,jacket_armor_index@l(9)
	addi 8,11,740
	mr 3,11
	slwi 0,10,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L287
	lis 9,combat_armor_index@ha
	lwz 10,combat_armor_index@l(9)
	slwi 0,10,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 4,1,.L267
.L287:
	mr 11,10
	b .L265
.L267:
	lis 9,body_armor_index@ha
	lwz 10,body_armor_index@l(9)
	slwi 11,10,2
	lwzx 9,8,11
	srawi 0,9,31
	subf 0,9,0
	srawi 0,0,31
	and 11,10,0
.L265:
	lwz 8,648(30)
	lwz 0,68(8)
	cmpwi 0,0,4
	bc 4,2,.L269
	cmpwi 0,11,0
	bc 4,2,.L270
	lis 9,jacket_armor_index@ha
	addi 10,3,740
	lwz 0,jacket_armor_index@l(9)
	li 11,2
	slwi 0,0,2
	stwx 11,10,0
	b .L272
.L270:
	slwi 0,11,2
	addi 11,3,740
	lwzx 9,11,0
	addi 9,9,2
	stwx 9,11,0
	b .L272
.L269:
	cmpwi 0,11,0
	bc 4,2,.L273
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,0(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,8
	addi 11,3,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	stwx 10,11,9
	b .L272
.L273:
	lis 9,jacket_armor_index@ha
	lwz 0,jacket_armor_index@l(9)
	cmpw 0,11,0
	bc 4,2,.L275
	lis 9,jacketarmor_info@ha
	la 6,jacketarmor_info@l(9)
	b .L276
.L275:
	lis 9,combat_armor_index@ha
	lwz 0,combat_armor_index@l(9)
	cmpw 0,11,0
	bc 4,2,.L277
	lis 9,combatarmor_info@ha
	la 6,combatarmor_info@l(9)
	b .L276
.L277:
	lis 9,bodyarmor_info@ha
	la 6,bodyarmor_info@l(9)
.L276:
	lfs 0,8(6)
	lis 8,0x4330
	lfs 13,8(29)
	lis 9,.LC32@ha
	slwi 4,11,2
	lwz 0,0(29)
	la 9,.LC32@l(9)
	addi 5,3,740
	lfd 11,0(9)
	fdivs 13,13,0
	xoris 0,0,0x8000
	mr 9,10
	lwzx 7,5,4
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	lwz 11,4(6)
	lwz 8,1864(3)
	fsub 0,0,11
	frsp 0,0
	fmuls 13,13,0
	fctiwz 12,13
	stfd 12,24(1)
	lwz 9,28(1)
	add 9,7,9
	cmpw 7,9,11
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 11,11,0
	and 9,9,0
	or 9,9,11
	cmpw 7,9,8
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 8,8,0
	and 9,9,0
	or 3,9,8
	cmpw 0,7,3
	bc 12,0,.L281
.L286:
	li 3,0
	b .L284
.L281:
	stwx 3,5,4
.L272:
	lwz 0,284(30)
	andis. 7,0,0x1
	bc 4,2,.L282
	lwz 9,264(30)
	lis 11,.LC33@ha
	lis 10,level+4@ha
	lwz 0,184(30)
	la 11,.LC33@l(11)
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
.L282:
	li 3,1
.L284:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 Pickup_Armor,.Lfe9-Pickup_Armor
	.section	".rodata"
	.align 2
.LC34:
	.string	"misc/power2.wav"
	.align 2
.LC35:
	.string	"cells"
	.align 2
.LC36:
	.string	"No cells for power armor.\n"
	.align 2
.LC37:
	.string	"misc/power1.wav"
	.align 2
.LC38:
	.long 0x3f800000
	.align 2
.LC39:
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
	bc 12,2,.L294
	rlwinm 0,0,0,20,18
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(30)
	lis 3,.LC34@ha
	lwz 9,36(29)
	la 3,.LC34@l(3)
	mtlr 9
	blrl
	lis 9,.LC38@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC38@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 2,0(9)
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 3,0(9)
	blrl
	b .L293
.L305:
	mr 10,29
	b .L302
.L294:
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lis 11,.LC35@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC35@l(11)
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L303
	mr 28,10
.L298:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L300
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L305
.L300:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,76
	cmpw 0,31,0
	bc 12,0,.L298
.L303:
	li 10,0
.L302:
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
	bc 4,2,.L304
	lis 9,gi+8@ha
	lis 5,.LC36@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC36@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L293
.L304:
	lwz 0,264(30)
	lis 29,gi@ha
	lis 3,.LC37@ha
	la 29,gi@l(29)
	la 3,.LC37@l(3)
	ori 0,0,4096
	stw 0,264(30)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC38@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC38@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 2,0(9)
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 3,0(9)
	blrl
.L293:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 Use_PowerArmor,.Lfe10-Use_PowerArmor
	.section	".rodata"
	.align 3
.LC40:
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
	mr 29,4
	ori 0,0,51739
	subf 9,11,9
	lwz 10,84(29)
	mullw 9,9,0
	addi 10,10,740
	rlwinm 9,9,0,0,29
	lwzx 30,10,9
	addi 11,30,1
	stwx 11,10,9
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L307
	lis 9,.LC40@ha
	lwz 11,648(31)
	la 9,.LC40@l(9)
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
.L307:
	cmpwi 0,30,0
	bc 4,2,.L309
	lwz 9,648(31)
	mr 3,29
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L309:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 Pickup_PowerArmor,.Lfe11-Pickup_PowerArmor
	.section	".rodata"
	.align 3
.LC41:
	.long 0x40080000
	.long 0x0
	.align 2
.LC42:
	.long 0x3f800000
	.align 2
.LC43:
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
	mr 3,30
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L313
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L313
	lwz 9,648(31)
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 12,2,.L313
	mr 3,31
	mr 4,30
	mtlr 0
	blrl
	mr. 28,3
	bc 12,2,.L317
	lwz 11,84(30)
	lis 0,0x3e80
	lis 9,gi@ha
	la 29,gi@l(9)
	stw 0,2108(11)
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
	lis 9,.LC41@ha
	sth 3,134(11)
	lis 10,level+4@ha
	la 9,.LC41@l(9)
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
	stfs 0,2276(9)
	lwz 9,648(31)
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 12,2,.L318
	subf 0,7,9
	lwz 11,84(30)
	mullw 0,0,8
	srawi 0,0,2
	extsh 9,0
	sth 0,144(11)
	stw 9,736(11)
.L318:
	lwz 9,648(31)
	lwz 11,36(29)
	lwz 3,20(9)
	mtlr 11
	blrl
	lis 9,.LC42@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC42@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 2,0(9)
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 3,0(9)
	blrl
.L317:
	lwz 0,284(31)
	andis. 9,0,4
	bc 4,2,.L319
	mr 4,30
	mr 3,31
	bl G_UseTargets
	lwz 0,284(31)
	oris 0,0,0x4
	stw 0,284(31)
.L319:
	cmpwi 0,28,0
	bc 12,2,.L313
	lwz 9,648(31)
	lwz 0,56(9)
	andi. 9,0,8
	bc 4,2,.L322
	lwz 0,284(31)
	andis. 9,0,0x3
	bc 12,2,.L313
.L322:
	lwz 0,264(31)
	cmpwi 0,0,0
	bc 4,0,.L323
	rlwinm 0,0,0,1,31
	stw 0,264(31)
	b .L313
.L323:
	mr 3,31
	bl G_FreeEdict
.L313:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 Touch_Item,.Lfe12-Touch_Item
	.section	".rodata"
	.align 2
.LC44:
	.long 0x42c80000
	.align 2
.LC45:
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
	stw 8,68(31)
	stw 0,64(31)
	stw 11,196(31)
	stw 10,208(31)
	stw 11,188(31)
	stw 11,192(31)
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
	mr 3,30
	stw 9,444(31)
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L329
	lwz 3,84(30)
	addi 29,1,24
	addi 4,1,8
	mr 5,29
	li 6,0
	addi 3,3,2124
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
	b .L331
.L329:
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
.L331:
	stfs 0,12(31)
	lis 9,.LC44@ha
	addi 3,1,8
	la 9,.LC44@l(9)
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
	lis 9,.LC45@ha
	lfs 0,level+4@l(11)
	la 9,.LC45@l(9)
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
.Lfe13:
	.size	 Drop_Item,.Lfe13-Drop_Item
	.section	".rodata"
	.align 2
.LC46:
	.string	"Maximum Formulation 4"
	.align 2
.LC47:
	.string	"droptofloor: %s startsolid at %s\n"
	.align 3
.LC48:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC49:
	.long 0xc1700000
	.align 2
.LC50:
	.long 0x41700000
	.align 2
.LC51:
	.long 0x0
	.align 2
.LC52:
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
	lis 9,.LC49@ha
	lis 11,.LC49@ha
	la 9,.LC49@l(9)
	la 11,.LC49@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC49@ha
	lfs 2,0(11)
	la 9,.LC49@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC50@ha
	lfs 13,0(11)
	la 9,.LC50@l(9)
	lfs 1,0(9)
	lis 9,.LC50@ha
	stfs 13,188(31)
	la 9,.LC50@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC50@ha
	stfs 0,192(31)
	la 9,.LC50@l(9)
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
	bc 12,2,.L336
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L337
.L336:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L337:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC51@ha
	stw 9,444(31)
	addi 29,31,4
	la 11,.LC51@l(11)
	lis 9,.LC52@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC52@l(9)
	lis 11,.LC51@ha
	lfs 3,0(9)
	la 11,.LC51@l(11)
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
	bc 12,2,.L338
	lis 3,level+8@ha
	lis 4,.LC46@ha
	la 3,level+8@l(3)
	la 4,.LC46@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L339
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC47@ha
	la 3,.LC47@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L339:
	mr 3,31
	bl G_FreeEdict
	b .L335
.L338:
	lwz 0,308(31)
	lfs 12,20(1)
	lfs 0,24(1)
	cmpwi 0,0,0
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L340
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
	bc 4,2,.L340
	lis 11,level+4@ha
	lis 10,.LC48@ha
	lfs 0,level+4@l(11)
	lis 9,DoRespawn@ha
	lfd 13,.LC48@l(10)
	la 9,DoRespawn@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L340:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L342
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
.L342:
	lwz 0,284(31)
	andi. 11,0,1
	bc 12,2,.L343
	lwz 0,184(31)
	lis 9,Use_Item@ha
	li 11,0
	la 9,Use_Item@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
.L343:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L335:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe14:
	.size	 droptofloor,.Lfe14-droptofloor
	.section	".rodata"
	.align 2
.LC53:
	.string	"PrecacheItem: %s has bad precache string"
	.align 2
.LC54:
	.string	"md2"
	.align 2
.LC55:
	.string	"sp2"
	.align 2
.LC56:
	.string	"wav"
	.align 2
.LC57:
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
	bc 12,2,.L344
	lwz 3,20(26)
	cmpwi 0,3,0
	bc 12,2,.L346
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L346:
	lwz 3,24(26)
	cmpwi 0,3,0
	bc 12,2,.L347
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L347:
	lwz 3,32(26)
	cmpwi 0,3,0
	bc 12,2,.L348
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L348:
	lwz 3,36(26)
	cmpwi 0,3,0
	bc 12,2,.L349
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
.L349:
	lwz 29,52(26)
	cmpwi 0,29,0
	bc 12,2,.L350
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L350
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L358
	mr 28,9
.L353:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L355
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L355
	mr 3,31
	b .L357
.L355:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L353
.L358:
	li 3,0
.L357:
	cmpw 0,3,26
	bc 12,2,.L350
	bl PrecacheItem
.L350:
	lwz 30,72(26)
	cmpwi 0,30,0
	bc 12,2,.L344
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 12,2,.L344
	lis 9,gi@ha
	addi 29,1,8
	la 27,gi@l(9)
	lis 24,.LC54@ha
	lis 25,.LC57@ha
.L364:
	rlwinm 9,0,0,0xff
	mr 31,30
	b .L378
.L367:
	lbzu 9,1(30)
.L378:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L367
	subf 28,31,30
	addi 0,28,-5
	cmplwi 0,0,58
	bc 4,1,.L369
	lwz 9,28(27)
	lis 3,.LC53@ha
	la 3,.LC53@l(3)
	lwz 4,0(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L369:
	mr 4,31
	mr 5,28
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 0,0
	addi 11,30,1
	stbx 0,29,28
	add 9,29,28
	la 4,.LC54@l(24)
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
	bc 12,2,.L379
	lis 4,.LC55@ha
	mr 3,31
	la 4,.LC55@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L373
.L379:
	lwz 9,32(27)
	mr 3,29
	mtlr 9
	blrl
	b .L372
.L373:
	lis 4,.LC56@ha
	mr 3,31
	la 4,.LC56@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L372
	lwz 9,36(27)
	mr 3,29
	mtlr 9
	blrl
.L372:
	add 3,29,28
	la 4,.LC57@l(25)
	addi 3,3,-3
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L362
	lwz 9,40(27)
	mr 3,29
	mtlr 9
	blrl
.L362:
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L364
.L344:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe15:
	.size	 PrecacheItem,.Lfe15-PrecacheItem
	.section	".rodata"
	.align 2
.LC58:
	.string	"key_power_cube"
	.align 2
.LC59:
	.string	"%s at %s has invalid spawnflags set\n"
	.align 2
.LC60:
	.string	"weapon_bfg"
	.align 2
.LC62:
	.string	"item_flag_team1"
	.align 2
.LC63:
	.string	"item_flag_team2"
	.align 2
.LC64:
	.string	"item_flag"
	.align 3
.LC61:
	.long 0x3fc99999
	.long 0x9999999a
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
	bc 12,2,.L381
	lwz 3,280(31)
	lis 4,.LC58@ha
	la 4,.LC58@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L381
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
	lis 3,.LC59@ha
	la 3,.LC59@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L381:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2048
	bc 12,2,.L383
	lwz 0,4(30)
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L393
	lis 9,Pickup_PowerArmor@ha
	la 9,Pickup_PowerArmor@l(9)
	cmpw 0,0,9
	bc 12,2,.L393
.L383:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 12,2,.L386
	lwz 0,4(30)
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L393
.L386:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 12,2,.L388
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
.L388:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8192
	bc 12,2,.L391
	lwz 0,56(30)
	cmpwi 0,0,2
	bc 12,2,.L393
	lwz 3,280(31)
	lis 4,.LC60@ha
	la 4,.LC60@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L391
.L393:
	mr 3,31
	bl G_FreeEdict
	b .L380
.L391:
	lwz 3,280(31)
	lis 4,.LC58@ha
	la 4,.LC58@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L394
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
.L394:
	lwz 0,56(30)
	andi. 9,0,8
	bc 12,2,.L395
	li 0,0
	stw 0,12(30)
.L395:
	stw 30,648(31)
	lis 11,level+4@ha
	lis 10,.LC61@ha
	lfs 0,level+4@l(11)
	lis 9,droptofloor@ha
	lfd 13,.LC61@l(10)
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
	bc 12,2,.L396
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L396:
	lwz 3,280(31)
	lis 4,.LC62@ha
	la 4,.LC62@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L398
	lwz 3,280(31)
	lis 4,.LC63@ha
	la 4,.LC63@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L398
	lwz 3,280(31)
	lis 4,.LC64@ha
	la 4,.LC64@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L380
.L398:
	lis 9,CTFFlagSetup@ha
	la 9,CTFFlagSetup@l(9)
	stw 9,436(31)
.L380:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 SpawnItem,.Lfe16-SpawnItem
	.globl itemlist
	.section	".data"
	.align 2
	.type	 itemlist,@object
itemlist:
	.long 0
	.space	72
	.long .LC65
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC66
	.long .LC67
	.long 1
	.long 0
	.long .LC68
	.long .LC69
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long bodyarmor_info
	.long 3
	.long .LC70
	.long .LC71
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC66
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
	.long combatarmor_info
	.long 2
	.long .LC70
	.long .LC75
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC66
	.long .LC76
	.long 1
	.long 0
	.long .LC77
	.long .LC78
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long jacketarmor_info
	.long 1
	.long .LC70
	.long .LC79
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC80
	.long .LC81
	.long 1
	.long 0
	.long .LC77
	.long .LC82
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long 0
	.long 4
	.long .LC70
	.long .LC83
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC84
	.long .LC85
	.long 1
	.long 0
	.long .LC86
	.long .LC87
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC88
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC84
	.long .LC89
	.long 1
	.long 0
	.long .LC90
	.long .LC91
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC92
	.long .LC93
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Blaster
	.long .LC94
	.long 0
	.long 0
	.long .LC95
	.long .LC96
	.long .LC97
	.long 0
	.long 0
	.long 0
	.long 1
	.long 1
	.long 0
	.long 0
	.long .LC98
	.long .LC99
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Shotgun
	.long .LC94
	.long .LC100
	.long 1
	.long .LC101
	.long .LC102
	.long .LC103
	.long 0
	.long 1
	.long .LC5
	.long 1
	.long 2
	.long 0
	.long 0
	.long .LC104
	.long .LC105
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_SuperShotgun
	.long .LC94
	.long .LC106
	.long 1
	.long .LC107
	.long .LC108
	.long .LC109
	.long 0
	.long 2
	.long .LC5
	.long 1
	.long 3
	.long 0
	.long 0
	.long .LC110
	.long .LC111
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Machinegun
	.long .LC94
	.long .LC112
	.long 1
	.long .LC113
	.long .LC114
	.long .LC115
	.long 0
	.long 1
	.long .LC4
	.long 9
	.long 4
	.long 0
	.long 0
	.long .LC116
	.long .LC117
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Chaingun
	.long .LC94
	.long .LC118
	.long 1
	.long .LC119
	.long .LC120
	.long .LC121
	.long 0
	.long 1
	.long .LC4
	.long 9
	.long 5
	.long 0
	.long 0
	.long .LC122
	.long .LC123
	.long Pickup_Ammo
	.long Use_Weapon
	.long Drop_Ammo
	.long Weapon_Grenade
	.long .LC124
	.long .LC125
	.long 0
	.long .LC126
	.long .LC127
	.long .LC8
	.long 3
	.long 5
	.long .LC128
	.long 3
	.long 6
	.long 0
	.long 3
	.long .LC129
	.long .LC130
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_GrenadeLauncher
	.long .LC94
	.long .LC131
	.long 1
	.long .LC132
	.long .LC133
	.long .LC134
	.long 0
	.long 1
	.long .LC8
	.long 1
	.long 7
	.long 0
	.long 0
	.long .LC135
	.long .LC136
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_RocketLauncher
	.long .LC94
	.long .LC137
	.long 1
	.long .LC138
	.long .LC139
	.long .LC140
	.long 0
	.long 1
	.long .LC9
	.long 1
	.long 8
	.long 0
	.long 0
	.long .LC141
	.long .LC142
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_HyperBlaster
	.long .LC94
	.long .LC143
	.long 1
	.long .LC144
	.long .LC145
	.long .LC146
	.long 0
	.long 1
	.long .LC7
	.long 9
	.long 9
	.long 0
	.long 0
	.long .LC147
	.long .LC148
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Railgun
	.long .LC94
	.long .LC149
	.long 1
	.long .LC150
	.long .LC151
	.long .LC152
	.long 0
	.long 1
	.long .LC10
	.long 1
	.long 10
	.long 0
	.long 0
	.long .LC153
	.long .LC60
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_BFG
	.long .LC94
	.long .LC154
	.long 1
	.long .LC155
	.long .LC156
	.long .LC157
	.long 0
	.long 50
	.long .LC7
	.long 1
	.long 11
	.long 0
	.long 0
	.long .LC158
	.long .LC159
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Pistol
	.long .LC94
	.long 0
	.long 0
	.long .LC160
	.long .LC70
	.long .LC161
	.long 0
	.long 0
	.long .LC7
	.long 1
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC162
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Blaster1
	.long .LC94
	.long 0
	.long 0
	.long .LC163
	.long .LC164
	.long .LC165
	.long 0
	.long 0
	.long .LC35
	.long 1
	.long 12
	.long 0
	.long 0
	.long .LC70
	.long .LC166
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Plasma
	.long .LC94
	.long .LC167
	.long 1
	.long .LC168
	.long .LC70
	.long .LC169
	.long 0
	.long 1
	.long .LC10
	.long 1
	.long 1
	.long 0
	.long 0
	.long .LC153
	.long .LC170
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_PipeLauncher
	.long .LC94
	.long .LC70
	.long 0
	.long .LC171
	.long .LC172
	.long .LC173
	.long 0
	.long 1
	.long .LC174
	.long 1
	.long 13
	.long 0
	.long 0
	.long .LC135
	.long .LC175
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Gorelka
	.long .LC94
	.long .LC70
	.long 0
	.long .LC176
	.long .LC177
	.long .LC178
	.long 0
	.long 1
	.long .LC7
	.long 1
	.long 14
	.long 0
	.long 0
	.long .LC70
	.long .LC179
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC70
	.long .LC70
	.long 0
	.long 0
	.long .LC127
	.long .LC174
	.long 3
	.long 5
	.long 0
	.long 2
	.long 0
	.long 0
	.long 6
	.space	4
	.long .LC180
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC124
	.long .LC181
	.long 0
	.long 0
	.long .LC182
	.long .LC5
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 1
	.long .LC70
	.long .LC183
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC124
	.long .LC184
	.long 0
	.long 0
	.long .LC185
	.long .LC4
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC186
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC124
	.long .LC187
	.long 0
	.long 0
	.long .LC188
	.long .LC7
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long 4
	.long .LC70
	.long .LC189
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC124
	.long .LC190
	.long 0
	.long 0
	.long .LC191
	.long .LC9
	.long 3
	.long 5
	.long 0
	.long 2
	.long 0
	.long 0
	.long 2
	.long .LC70
	.long .LC192
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC124
	.long .LC193
	.long 0
	.long 0
	.long .LC194
	.long .LC10
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 5
	.long .LC70
	.long .LC195
	.long Pickup_Powerup
	.long Use_Quad
	.long Drop_General
	.long 0
	.long .LC196
	.long .LC197
	.long 1
	.long 0
	.long .LC198
	.long .LC199
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC200
	.long .LC201
	.long Pickup_Powerup
	.long Use_Invulnerability
	.long Drop_General
	.long 0
	.long .LC196
	.long .LC202
	.long 1
	.long 0
	.long .LC203
	.long .LC204
	.long 2
	.long 300
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC205
	.long .LC206
	.long Pickup_Powerup
	.long Use_Silencer
	.long Drop_General
	.long 0
	.long .LC196
	.long .LC207
	.long 1
	.long 0
	.long .LC208
	.long .LC209
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC210
	.long Pickup_Powerup
	.long Use_Breather
	.long Drop_General
	.long 0
	.long .LC196
	.long .LC211
	.long 1
	.long 0
	.long .LC212
	.long .LC213
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long 0
	.long .LC214
	.long .LC215
	.long Pickup_Powerup
	.long Use_Envirosuit
	.long Drop_General
	.long 0
	.long .LC196
	.long .LC216
	.long 1
	.long 0
	.long .LC217
	.long .LC218
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long 0
	.long .LC214
	.long .LC219
	.long Pickup_AncientHead
	.long 0
	.long 0
	.long 0
	.long .LC196
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
	.long 0
	.long .LC70
	.long .LC223
	.long Pickup_Adrenaline
	.long 0
	.long 0
	.long 0
	.long .LC196
	.long .LC224
	.long 1
	.long 0
	.long .LC225
	.long .LC226
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC227
	.long Pickup_Bandolier
	.long 0
	.long 0
	.long 0
	.long .LC196
	.long .LC228
	.long 1
	.long 0
	.long .LC229
	.long .LC230
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC231
	.long Pickup_Pack
	.long 0
	.long 0
	.long 0
	.long .LC196
	.long .LC232
	.long 1
	.long 0
	.long .LC233
	.long .LC234
	.long 2
	.long 180
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC235
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC196
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
	.long .LC70
	.long .LC58
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC196
	.long .LC239
	.long 1
	.long 0
	.long .LC240
	.long .LC241
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC242
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC196
	.long .LC243
	.long 1
	.long 0
	.long .LC244
	.long .LC245
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC246
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC196
	.long .LC247
	.long 1
	.long 0
	.long .LC248
	.long .LC249
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC250
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC196
	.long .LC251
	.long 1
	.long 0
	.long .LC252
	.long .LC253
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC254
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC196
	.long .LC255
	.long 1
	.long 0
	.long .LC256
	.long .LC257
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC258
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC196
	.long .LC259
	.long 1
	.long 0
	.long .LC260
	.long .LC261
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC262
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC196
	.long .LC263
	.long 2
	.long 0
	.long .LC264
	.long .LC265
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC266
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC196
	.long .LC267
	.long 1
	.long 0
	.long .LC268
	.long .LC269
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long 0
	.long Pickup_Health
	.long 0
	.long 0
	.long 0
	.long .LC196
	.long 0
	.long 0
	.long 0
	.long .LC270
	.long .LC271
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long .LC62
	.long CTFPickup_Flag
	.long 0
	.long RipDropFlag
	.long 0
	.long .LC70
	.long .LC272
	.long 262144
	.long 0
	.long .LC273
	.long .LC274
	.long 2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC275
	.long .LC63
	.long CTFPickup_Flag
	.long 0
	.long RipDropFlag
	.long 0
	.long .LC70
	.long .LC276
	.long 524288
	.long 0
	.long .LC277
	.long .LC278
	.long 2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC275
	.long .LC64
	.long Pickup_Flag
	.long 0
	.long RipDropFlag
	.long 0
	.long .LC70
	.long .LC276
	.long 786432
	.long 0
	.long .LC70
	.long .LC279
	.long 2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC275
	.long 0
	.space	72
	.section	".rodata"
	.align 2
.LC279:
	.string	"Flag"
	.align 2
.LC278:
	.string	"Blue Flag"
	.align 2
.LC277:
	.string	"team2_i"
	.align 2
.LC276:
	.string	"models/players/male/flag2.md2"
	.align 2
.LC275:
	.string	"teams/flagcap.wav"
	.align 2
.LC274:
	.string	"Red Flag"
	.align 2
.LC273:
	.string	"team1_i"
	.align 2
.LC272:
	.string	"models/players/male/flag1.md2"
	.align 2
.LC271:
	.string	"Health"
	.align 2
.LC270:
	.string	"i_health"
	.align 2
.LC269:
	.string	"Airstrike Marker"
	.align 2
.LC268:
	.string	"i_airstrike"
	.align 2
.LC267:
	.string	"models/items/keys/target/tris.md2"
	.align 2
.LC266:
	.string	"key_airstrike_target"
	.align 2
.LC265:
	.string	"Commander's Head"
	.align 2
.LC264:
	.string	"k_comhead"
	.align 2
.LC263:
	.string	"models/monsters/commandr/head/tris.md2"
	.align 2
.LC262:
	.string	"key_commander_head"
	.align 2
.LC261:
	.string	"Red Key"
	.align 2
.LC260:
	.string	"k_redkey"
	.align 2
.LC259:
	.string	"models/items/keys/red_key/tris.md2"
	.align 2
.LC258:
	.string	"key_red_key"
	.align 2
.LC257:
	.string	"Blue Key"
	.align 2
.LC256:
	.string	"k_bluekey"
	.align 2
.LC255:
	.string	"models/items/keys/key/tris.md2"
	.align 2
.LC254:
	.string	"key_blue_key"
	.align 2
.LC253:
	.string	"Switcher"
	.align 2
.LC252:
	.string	"k_security"
	.align 2
.LC251:
	.string	"models/items/keys/pass/tris.md2"
	.align 2
.LC250:
	.string	"key_pass"
	.align 2
.LC249:
	.string	"Data Spinner"
	.align 2
.LC248:
	.string	"k_dataspin"
	.align 2
.LC247:
	.string	"models/items/keys/spinner/tris.md2"
	.align 2
.LC246:
	.string	"key_data_spinner"
	.align 2
.LC245:
	.string	"Pyramid Key"
	.align 2
.LC244:
	.string	"k_pyramid"
	.align 2
.LC243:
	.string	"models/items/keys/pyramid/tris.md2"
	.align 2
.LC242:
	.string	"key_pyramid"
	.align 2
.LC241:
	.string	"Power Cube"
	.align 2
.LC240:
	.string	"k_powercube"
	.align 2
.LC239:
	.string	"models/items/keys/power/tris.md2"
	.align 2
.LC238:
	.string	"Data CD"
	.align 2
.LC237:
	.string	"k_datacd"
	.align 2
.LC236:
	.string	"models/items/keys/data_cd/tris.md2"
	.align 2
.LC235:
	.string	"key_data_cd"
	.align 2
.LC234:
	.string	"Ammo Pack"
	.align 2
.LC233:
	.string	"i_pack"
	.align 2
.LC232:
	.string	"models/items/pack/tris.md2"
	.align 2
.LC231:
	.string	"item_pack"
	.align 2
.LC230:
	.string	"Bandolier"
	.align 2
.LC229:
	.string	"p_bandolier"
	.align 2
.LC228:
	.string	"models/items/band/tris.md2"
	.align 2
.LC227:
	.string	"item_bandolier"
	.align 2
.LC226:
	.string	"Adrenaline"
	.align 2
.LC225:
	.string	"p_adrenaline"
	.align 2
.LC224:
	.string	"models/items/adrenal/tris.md2"
	.align 2
.LC223:
	.string	"item_adrenaline"
	.align 2
.LC222:
	.string	"Ancient Head"
	.align 2
.LC221:
	.string	"i_fixme"
	.align 2
.LC220:
	.string	"models/items/c_head/tris.md2"
	.align 2
.LC219:
	.string	"item_ancient_head"
	.align 2
.LC218:
	.string	"Environment Suit"
	.align 2
.LC217:
	.string	"p_envirosuit"
	.align 2
.LC216:
	.string	"models/items/enviro/tris.md2"
	.align 2
.LC215:
	.string	"item_enviro"
	.align 2
.LC214:
	.string	"items/airout.wav"
	.align 2
.LC213:
	.string	"Rebreather"
	.align 2
.LC212:
	.string	"p_rebreather"
	.align 2
.LC211:
	.string	"models/items/breather/tris.md2"
	.align 2
.LC210:
	.string	"item_breather"
	.align 2
.LC209:
	.string	"Silencer"
	.align 2
.LC208:
	.string	"p_silencer"
	.align 2
.LC207:
	.string	"models/items/silencer/tris.md2"
	.align 2
.LC206:
	.string	"item_silencer"
	.align 2
.LC205:
	.string	"items/protect.wav items/protect2.wav items/protect4.wav"
	.align 2
.LC204:
	.string	"Invulnerability"
	.align 2
.LC203:
	.string	"p_invulnerability"
	.align 2
.LC202:
	.string	"models/items/invulner/tris.md2"
	.align 2
.LC201:
	.string	"item_invulnerability"
	.align 2
.LC200:
	.string	"items/damage.wav items/damage2.wav items/damage3.wav"
	.align 2
.LC199:
	.string	"Quad Damage"
	.align 2
.LC198:
	.string	"p_quad"
	.align 2
.LC197:
	.string	"models/items/quaddama/tris.md2"
	.align 2
.LC196:
	.string	"items/pkup.wav"
	.align 2
.LC195:
	.string	"item_quad"
	.align 2
.LC194:
	.string	"a_slugs"
	.align 2
.LC193:
	.string	"models/items/ammo/slugs/medium/tris.md2"
	.align 2
.LC192:
	.string	"ammo_slugs"
	.align 2
.LC191:
	.string	"a_rockets"
	.align 2
.LC190:
	.string	"models/items/ammo/rockets/medium/tris.md2"
	.align 2
.LC189:
	.string	"ammo_rockets"
	.align 2
.LC188:
	.string	"a_cells"
	.align 2
.LC187:
	.string	"models/items/ammo/cells/medium/tris.md2"
	.align 2
.LC186:
	.string	"ammo_cells"
	.align 2
.LC185:
	.string	"a_bullets"
	.align 2
.LC184:
	.string	"models/items/ammo/bullets/medium/tris.md2"
	.align 2
.LC183:
	.string	"ammo_bullets"
	.align 2
.LC182:
	.string	"a_shells"
	.align 2
.LC181:
	.string	"models/items/ammo/shells/medium/tris.md2"
	.align 2
.LC180:
	.string	"ammo_shells"
	.align 2
.LC179:
	.string	"ammo_pipebombs"
	.align 2
.LC178:
	.string	"Flamethrower"
	.align 2
.LC177:
	.string	"w_grapple"
	.align 2
.LC176:
	.string	"models/weapons/grapple/tris.md2"
	.align 2
.LC175:
	.string	"weapon_gorelka"
	.align 2
.LC174:
	.string	"Pipebombs"
	.align 2
.LC173:
	.string	"Pipebomb Launcher"
	.align 2
.LC172:
	.string	"w_pipe"
	.align 2
.LC171:
	.string	"models/weapons/v_launcp/tris.md2"
	.align 2
.LC170:
	.string	"weapon_pipelauncher"
	.align 2
.LC169:
	.string	"Plasma Rifle"
	.align 2
.LC168:
	.string	"models/weapons/v_laser/tris.md2"
	.align 2
.LC167:
	.string	"models/weapons/g_laser/tris.md2"
	.align 2
.LC166:
	.string	"weapon_plasma"
	.align 2
.LC165:
	.string	"Flame Launcher"
	.align 2
.LC164:
	.string	"w_flame"
	.align 2
.LC163:
	.string	"models/weapons/v_napalm/tris.md2"
	.align 2
.LC162:
	.string	"weapon_flamelauncher"
	.align 2
.LC161:
	.string	"Magic"
	.align 2
.LC160:
	.string	"models/weapons/v_hand/tris.md2"
	.align 2
.LC159:
	.string	"weapon_magic"
	.align 2
.LC158:
	.string	"sprites/s_bfg1.sp2 sprites/s_bfg2.sp2 sprites/s_bfg3.sp2 weapons/bfg__f1y.wav weapons/bfg__l1a.wav weapons/bfg__x1b.wav weapons/bfg_hum.wav"
	.align 2
.LC157:
	.string	"BFG10K"
	.align 2
.LC156:
	.string	"w_bfg"
	.align 2
.LC155:
	.string	"models/weapons/v_bfg/tris.md2"
	.align 2
.LC154:
	.string	"models/weapons/g_bfg/tris.md2"
	.align 2
.LC153:
	.string	"weapons/rg_hum.wav"
	.align 2
.LC152:
	.string	"Railgun"
	.align 2
.LC151:
	.string	"w_railgun"
	.align 2
.LC150:
	.string	"models/weapons/v_rail/tris.md2"
	.align 2
.LC149:
	.string	"models/weapons/g_rail/tris.md2"
	.align 2
.LC148:
	.string	"weapon_railgun"
	.align 2
.LC147:
	.string	"weapons/hyprbu1a.wav weapons/hyprbl1a.wav weapons/hyprbf1a.wav weapons/hyprbd1a.wav misc/lasfly.wav"
	.align 2
.LC146:
	.string	"HyperBlaster"
	.align 2
.LC145:
	.string	"w_hyperblaster"
	.align 2
.LC144:
	.string	"models/weapons/v_hyperb/tris.md2"
	.align 2
.LC143:
	.string	"models/weapons/g_hyperb/tris.md2"
	.align 2
.LC142:
	.string	"weapon_hyperblaster"
	.align 2
.LC141:
	.string	"models/objects/rocket/tris.md2 weapons/rockfly.wav weapons/rocklf1a.wav weapons/rocklr1b.wav models/objects/debris2/tris.md2"
	.align 2
.LC140:
	.string	"Rocket Launcher"
	.align 2
.LC139:
	.string	"w_rlauncher"
	.align 2
.LC138:
	.string	"models/weapons/v_rocket/tris.md2"
	.align 2
.LC137:
	.string	"models/weapons/g_rocket/tris.md2"
	.align 2
.LC136:
	.string	"weapon_rocketlauncher"
	.align 2
.LC135:
	.string	"models/objects/grenade/tris.md2 weapons/grenlf1a.wav weapons/grenlr1b.wav weapons/grenlb1b.wav"
	.align 2
.LC134:
	.string	"Grenade Launcher"
	.align 2
.LC133:
	.string	"w_glauncher"
	.align 2
.LC132:
	.string	"models/weapons/v_launch/tris.md2"
	.align 2
.LC131:
	.string	"models/weapons/g_launch/tris.md2"
	.align 2
.LC130:
	.string	"weapon_grenadelauncher"
	.align 2
.LC129:
	.string	"weapons/hgrent1a.wav weapons/hgrena1b.wav weapons/hgrenc1b.wav weapons/hgrenb1a.wav weapons/hgrenb2a.wav "
	.align 2
.LC128:
	.string	"grenades"
	.align 2
.LC127:
	.string	"a_grenades"
	.align 2
.LC126:
	.string	"models/weapons/v_handgr/tris.md2"
	.align 2
.LC125:
	.string	"models/items/ammo/grenades/medium/tris.md2"
	.align 2
.LC124:
	.string	"misc/am_pkup.wav"
	.align 2
.LC123:
	.string	"ammo_grenades"
	.align 2
.LC122:
	.string	"weapons/chngnu1a.wav weapons/chngnl1a.wav weapons/machgf3b.wav` weapons/chngnd1a.wav"
	.align 2
.LC121:
	.string	"Chaingun"
	.align 2
.LC120:
	.string	"w_chaingun"
	.align 2
.LC119:
	.string	"models/weapons/v_chain/tris.md2"
	.align 2
.LC118:
	.string	"models/weapons/g_chain/tris.md2"
	.align 2
.LC117:
	.string	"weapon_chaingun"
	.align 2
.LC116:
	.string	"weapons/machgf1b.wav weapons/machgf2b.wav weapons/machgf3b.wav weapons/machgf4b.wav weapons/machgf5b.wav"
	.align 2
.LC115:
	.string	"Machinegun"
	.align 2
.LC114:
	.string	"w_machinegun"
	.align 2
.LC113:
	.string	"models/weapons/v_machn/tris.md2"
	.align 2
.LC112:
	.string	"models/weapons/g_machn/tris.md2"
	.align 2
.LC111:
	.string	"weapon_machinegun"
	.align 2
.LC110:
	.string	"weapons/sshotf1b.wav"
	.align 2
.LC109:
	.string	"Super Shotgun"
	.align 2
.LC108:
	.string	"w_sshotgun"
	.align 2
.LC107:
	.string	"models/weapons/v_shotg2/tris.md2"
	.align 2
.LC106:
	.string	"models/weapons/g_shotg2/tris.md2"
	.align 2
.LC105:
	.string	"weapon_supershotgun"
	.align 2
.LC104:
	.string	"weapons/v_shotg/flash2/tris.md2 weapons/shotgf1b.wav weapons/shotgr1b.wav"
	.align 2
.LC103:
	.string	"Shotgun"
	.align 2
.LC102:
	.string	"w_shotgun"
	.align 2
.LC101:
	.string	"models/weapons/v_shotg/tris.md2"
	.align 2
.LC100:
	.string	"models/weapons/g_shotg/tris.md2"
	.align 2
.LC99:
	.string	"weapon_shotgun"
	.align 2
.LC98:
	.string	"weapons/blastf1a.wav misc/lasfly.wav"
	.align 2
.LC97:
	.string	"Blaster"
	.align 2
.LC96:
	.string	"w_blaster"
	.align 2
.LC95:
	.string	"models/weapons/v_blast/tris.md2"
	.align 2
.LC94:
	.string	"misc/w_pkup.wav"
	.align 2
.LC93:
	.string	"weapon_blaster"
	.align 2
.LC92:
	.string	"misc/power2.wav misc/power1.wav"
	.align 2
.LC91:
	.string	"Power Shield"
	.align 2
.LC90:
	.string	"i_powershield"
	.align 2
.LC89:
	.string	"models/items/armor/shield/tris.md2"
	.align 2
.LC88:
	.string	"item_power_shield"
	.align 2
.LC87:
	.string	"Power Screen"
	.align 2
.LC86:
	.string	"i_powerscreen"
	.align 2
.LC85:
	.string	"models/items/armor/screen/tris.md2"
	.align 2
.LC84:
	.string	"misc/ar3_pkup.wav"
	.align 2
.LC83:
	.string	"item_power_screen"
	.align 2
.LC82:
	.string	"Armor Shard"
	.align 2
.LC81:
	.string	"models/items/armor/shard/tris.md2"
	.align 2
.LC80:
	.string	"misc/ar2_pkup.wav"
	.align 2
.LC79:
	.string	"item_armor_shard"
	.align 2
.LC78:
	.string	"Jacket Armor"
	.align 2
.LC77:
	.string	"i_jacketarmor"
	.align 2
.LC76:
	.string	"models/items/armor/jacket/tris.md2"
	.align 2
.LC75:
	.string	"item_armor_jacket"
	.align 2
.LC74:
	.string	"Combat Armor"
	.align 2
.LC73:
	.string	"i_combatarmor"
	.align 2
.LC72:
	.string	"models/items/armor/combat/tris.md2"
	.align 2
.LC71:
	.string	"item_armor_combat"
	.align 2
.LC70:
	.string	""
	.align 2
.LC69:
	.string	"Body Armor"
	.align 2
.LC68:
	.string	"i_bodyarmor"
	.align 2
.LC67:
	.string	"models/items/armor/body/tris.md2"
	.align 2
.LC66:
	.string	"misc/ar1_pkup.wav"
	.align 2
.LC65:
	.string	"item_armor_body"
	.size	 itemlist,3952
	.align 2
.LC280:
	.string	"models/items/healing/medium/tris.md2"
	.align 2
.LC281:
	.string	"models/items/healing/stimpack/tris.md2"
	.align 2
.LC282:
	.string	"models/items/healing/large/tris.md2"
	.align 2
.LC283:
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
	bc 4,0,.L442
	lis 11,itemlist@ha
	lis 9,gi@ha
	la 11,itemlist@l(11)
	la 28,gi@l(9)
	mr 29,10
	addi 30,11,40
.L444:
	lwz 9,24(28)
	addi 3,31,1056
	lwz 4,0(30)
	addi 31,31,1
	mtlr 9
	addi 30,30,76
	blrl
	lwz 0,1556(29)
	cmpw 0,31,0
	bc 12,0,.L444
.L442:
	lis 9,game@ha
	lis 11,jacket_armor_index@ha
	la 10,game@l(9)
	li 30,0
	lwz 0,1556(10)
	la 27,jacket_armor_index@l(11)
	lis 9,.LC78@ha
	lis 11,itemlist@ha
	la 28,.LC78@l(9)
	cmpw 0,30,0
	la 31,itemlist@l(11)
	bc 4,0,.L453
	mr 29,10
.L448:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L450
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L450
	mr 11,31
	b .L452
.L450:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L448
.L453:
	li 11,0
.L452:
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
	lis 10,.LC74@ha
	la 26,combat_armor_index@l(9)
	srawi 11,11,2
	la 28,.LC74@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L461
	mr 29,7
.L456:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L458
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L458
	mr 11,31
	b .L460
.L458:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L456
.L461:
	li 11,0
.L460:
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
	lis 10,.LC69@ha
	la 27,body_armor_index@l(9)
	srawi 11,11,2
	la 28,.LC69@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L469
	mr 29,7
.L464:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L466
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L466
	mr 11,31
	b .L468
.L466:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L464
.L469:
	li 11,0
.L468:
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
	lis 10,.LC87@ha
	la 26,power_screen_index@l(9)
	srawi 11,11,2
	la 28,.LC87@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L477
	mr 29,7
.L472:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L474
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L474
	mr 11,31
	b .L476
.L474:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L472
.L477:
	li 11,0
.L476:
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
	lis 10,.LC91@ha
	la 27,power_shield_index@l(9)
	srawi 11,11,2
	la 28,.LC91@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L485
	mr 29,7
.L480:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L482
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L482
	mr 8,31
	b .L484
.L482:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L480
.L485:
	li 8,0
.L484:
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
.Lfe17:
	.size	 SetItemNames,.Lfe17-SetItemNames
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
	li 0,51
	stw 0,game+1556@l(9)
	blr
.Lfe18:
	.size	 InitItems,.Lfe18-InitItems
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
	b .L486
.L29:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L30
.L28:
	li 3,0
.L486:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 FindItem,.Lfe19-FindItem
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
	b .L487
.L12:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L13
.L11:
	li 3,0
.L487:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 FindItemByClassname,.Lfe20-FindItemByClassname
	.align 2
	.globl FindItemByIcon
	.type	 FindItemByIcon,@function
FindItemByIcon:
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
	lwz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L20
	lwz 3,36(31)
	cmpwi 0,3,0
	bc 12,2,.L20
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L20
	mr 3,31
	b .L488
.L20:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L21
.L19:
	li 3,0
.L488:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 FindItemByIcon,.Lfe21-FindItemByIcon
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
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl G_ClientExists
	cmpwi 0,3,0
	bc 4,2,.L248
	li 3,0
	b .L489
.L248:
	lis 9,jacket_armor_index@ha
	lwz 11,84(31)
	lwz 10,jacket_armor_index@l(9)
	addi 3,11,740
	slwi 0,10,2
	lwzx 9,3,0
	cmpwi 0,9,0
	bc 4,1,.L249
	mr 3,10
	b .L489
.L249:
	lis 9,combat_armor_index@ha
	lwz 11,combat_armor_index@l(9)
	slwi 0,11,2
	lwzx 9,3,0
	cmpwi 0,9,0
	bc 4,1,.L250
	mr 3,11
	b .L489
.L250:
	lis 9,body_armor_index@ha
	lwz 11,body_armor_index@l(9)
	slwi 0,11,2
	lwzx 9,3,0
	srawi 3,9,31
	subf 3,9,3
	srawi 3,3,31
	and 3,11,3
.L489:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe23:
	.size	 ArmorIndex,.Lfe23-ArmorIndex
	.align 2
	.globl PowerArmorType
	.type	 PowerArmorType,@function
PowerArmorType:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L491
	lwz 0,264(31)
	andi. 9,0,4096
	bc 4,2,.L290
.L491:
	li 3,0
	b .L490
.L290:
	lis 9,power_shield_index@ha
	lwz 11,84(31)
	lwz 0,power_shield_index@l(9)
	addi 3,11,740
	slwi 0,0,2
	lwzx 9,3,0
	cmpwi 0,9,0
	bc 12,1,.L291
	lis 9,power_screen_index@ha
	lwz 0,power_screen_index@l(9)
	slwi 0,0,2
	lwzx 9,3,0
	srawi 3,9,31
	subf 3,9,3
	srwi 3,3,31
	b .L490
.L291:
	li 3,2
.L490:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
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
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
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
	bc 12,2,.L35
	lwz 30,564(31)
	li 29,0
	mr. 31,30
	bc 12,2,.L37
.L38:
	lwz 31,536(31)
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
	lwz 31,536(31)
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
.LC284:
	.long 0x0
	.align 3
.LC285:
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
	lis 9,deathmatch@ha
	mr 12,3
	lwz 11,deathmatch@l(9)
	lis 9,.LC284@ha
	la 9,.LC284@l(9)
	lfs 13,0(9)
	stfs 13,948(4)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L60
	lwz 9,484(4)
	addi 9,9,1
	stw 9,484(4)
.L60:
	lwz 0,480(4)
	lwz 9,484(4)
	cmpw 0,0,9
	bc 4,0,.L61
	stw 9,480(4)
.L61:
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L62
	lis 9,.LC285@ha
	lwz 11,648(12)
	la 9,.LC285@l(9)
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
.L62:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 Pickup_Adrenaline,.Lfe28-Pickup_Adrenaline
	.section	".rodata"
	.align 3
.LC286:
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
	li 0,0
	mr 12,3
	stw 0,948(4)
	addi 9,9,2
	stw 9,484(4)
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L65
	lis 9,.LC286@ha
	lwz 11,648(12)
	la 9,.LC286@l(9)
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
.L65:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 Pickup_AncientHead,.Lfe29-Pickup_AncientHead
	.section	".rodata"
	.align 3
.LC287:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC288:
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
	lis 9,.LC287@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC287@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,2204(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L164
	lis 9,.LC288@ha
	la 9,.LC288@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L493
.L164:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L493:
	stfs 0,2204(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe30:
	.size	 Use_Breather,.Lfe30-Use_Breather
	.section	".rodata"
	.align 3
.LC289:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC290:
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
	lis 9,.LC289@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC289@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,2208(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L167
	lis 9,.LC290@ha
	la 9,.LC290@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L494
.L167:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L494:
	stfs 0,2208(10)
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
	lwz 9,2220(11)
	addi 9,9,30
	stw 9,2220(11)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe32:
	.size	 Use_Silencer,.Lfe32-Use_Silencer
	.align 2
	.globl Pickup_Key
	.type	 Pickup_Key,@function
Pickup_Key:
	lwz 0,648(3)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	lwz 10,84(4)
	subf 0,9,0
	li 3,1
	mullw 0,0,11
	addi 10,10,740
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	blr
.Lfe33:
	.size	 Pickup_Key,.Lfe33-Pickup_Key
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
	lis 0,0x286b
	ori 0,0,51739
	subf 9,9,29
	mullw 9,9,0
	mr 31,3
	srawi 30,9,2
	bl Drop_Item
	lwz 9,84(31)
	slwi 0,30,2
	mr 11,3
	lwz 10,48(29)
	addi 9,9,740
	lwzx 0,9,0
	cmpw 0,0,10
	bc 12,0,.L217
	stw 10,532(11)
	b .L218
.L217:
	stw 0,532(11)
.L218:
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
	.section	".rodata"
	.align 2
.LC291:
	.long 0x3f800000
	.align 2
.LC292:
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
	bc 4,1,.L220
	lis 10,.LC291@ha
	lis 9,level+4@ha
	la 10,.LC291@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(7)
	lwz 9,480(11)
	addi 9,9,-1
	stw 9,480(11)
	b .L219
.L220:
	lwz 0,284(7)
	andis. 6,0,0x1
	bc 4,2,.L221
	lwz 9,264(7)
	lis 11,.LC292@ha
	lis 10,level+4@ha
	lwz 0,184(7)
	la 11,.LC292@l(11)
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
	b .L219
.L221:
	mr 3,7
	bl G_FreeEdict
.L219:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe35:
	.size	 MegaHealth_think,.Lfe35-MegaHealth_think
	.align 2
	.globl Can_PickupArmor
	.type	 Can_PickupArmor,@function
Can_PickupArmor:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,4
	mr 30,3
	mr 3,31
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L496
	lwz 9,84(31)
	lwz 4,1884(9)
	cmpwi 0,4,0
	bc 4,2,.L254
.L496:
	li 3,0
	b .L495
.L254:
	lwz 9,648(30)
	lwz 3,68(9)
	cmpwi 0,3,4
	bc 12,2,.L255
	cmpw 0,3,4
	li 3,0
	bc 4,2,.L495
.L255:
	li 3,1
.L495:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe36:
	.size	 Can_PickupArmor,.Lfe36-Can_PickupArmor
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
	bc 12,2,.L311
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
	bc 4,2,.L311
	bl Use_PowerArmor
.L311:
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
.Lfe37:
	.size	 Drop_PowerArmor,.Lfe37-Drop_PowerArmor
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
.Lfe38:
	.size	 drop_temp_touch,.Lfe38-drop_temp_touch
	.section	".rodata"
	.align 2
.LC293:
	.long 0x41e80000
	.section	".text"
	.align 2
	.type	 drop_make_touchable,@function
drop_make_touchable:
	lis 9,Touch_Item@ha
	lis 11,level+4@ha
	la 9,Touch_Item@l(9)
	stw 9,444(3)
	lis 9,.LC293@ha
	lfs 0,level+4@l(11)
	la 9,.LC293@l(9)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,436(3)
	stfs 0,428(3)
	blr
.Lfe39:
	.size	 drop_make_touchable,.Lfe39-drop_make_touchable
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
	bc 12,2,.L333
	li 0,2
	stw 11,444(3)
	stw 0,248(3)
	b .L334
.L333:
	lis 9,Touch_Item@ha
	li 0,1
	la 9,Touch_Item@l(9)
	stw 0,248(3)
	stw 9,444(3)
.L334:
	lis 9,gi+72@ha
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe40:
	.size	 Use_Item,.Lfe40-Use_Item
	.section	".rodata"
	.align 2
.LC294:
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
	lis 11,.LC294@ha
	lis 9,deathmatch@ha
	la 11,.LC294@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L400
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L400
	bl G_FreeEdict
	b .L399
.L497:
	mr 4,31
	b .L407
.L400:
	lis 9,.LC280@ha
	li 0,10
	la 9,.LC280@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC271@ha
	lis 11,itemlist@ha
	la 27,.LC271@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L408
	mr 28,10
.L403:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L405
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L497
.L405:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L403
.L408:
	li 4,0
.L407:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC25@ha
	lwz 0,gi+36@l(9)
	la 3,.LC25@l(3)
	mtlr 0
	blrl
.L399:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe41:
	.size	 SP_item_health,.Lfe41-SP_item_health
	.section	".rodata"
	.align 2
.LC295:
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
	lis 11,.LC295@ha
	lis 9,deathmatch@ha
	la 11,.LC295@l(11)
	mr 29,3
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
.L498:
	mr 4,31
	b .L417
.L410:
	lis 9,.LC281@ha
	li 0,2
	la 9,.LC281@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC271@ha
	lis 11,itemlist@ha
	la 27,.LC271@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L418
	mr 28,10
.L413:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L415
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L498
.L415:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L413
.L418:
	li 4,0
.L417:
	mr 3,29
	bl SpawnItem
	li 0,1
	lis 9,gi+36@ha
	stw 0,644(29)
	lis 3,.LC24@ha
	lwz 0,gi+36@l(9)
	la 3,.LC24@l(3)
	mtlr 0
	blrl
.L409:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe42:
	.size	 SP_item_health_small,.Lfe42-SP_item_health_small
	.section	".rodata"
	.align 2
.LC296:
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
	lis 11,.LC296@ha
	lis 9,deathmatch@ha
	la 11,.LC296@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L420
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L420
	bl G_FreeEdict
	b .L419
.L499:
	mr 4,31
	b .L427
.L420:
	lis 9,.LC282@ha
	li 0,25
	la 9,.LC282@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC271@ha
	lis 11,itemlist@ha
	la 27,.LC271@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L428
	mr 28,10
.L423:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L425
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L499
.L425:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L423
.L428:
	li 4,0
.L427:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC26@ha
	lwz 0,gi+36@l(9)
	la 3,.LC26@l(3)
	mtlr 0
	blrl
.L419:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe43:
	.size	 SP_item_health_large,.Lfe43-SP_item_health_large
	.section	".rodata"
	.align 2
.LC297:
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
	lis 11,.LC297@ha
	lis 9,deathmatch@ha
	la 11,.LC297@l(11)
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
.L500:
	mr 4,31
	b .L437
.L430:
	lis 9,.LC283@ha
	li 0,100
	la 9,.LC283@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC271@ha
	lis 11,itemlist@ha
	la 27,.LC271@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L438
	mr 28,10
.L433:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L435
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L500
.L435:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L433
.L438:
	li 4,0
.L437:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC27@ha
	lwz 0,gi+36@l(9)
	la 3,.LC27@l(3)
	mtlr 0
	blrl
	li 0,3
	stw 0,644(29)
.L429:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe44:
	.size	 SP_item_health_mega,.Lfe44-SP_item_health_mega
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
