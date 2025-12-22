	.file	"g_items.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.globl jacketarmor_info
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
	bc 4,2,.L81
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
	bc 4,2,.L81
	lis 11,coop@ha
	lis 7,.LC3@ha
	lwz 9,coop@l(11)
	la 7,.LC3@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L73
	lwz 0,56(8)
	rlwinm 0,0,29,31,31
	and. 9,0,10
	bc 12,2,.L73
.L81:
	li 3,0
	b .L80
.L73:
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
	bc 12,2,.L74
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L75
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
.L75:
	lwz 0,968(30)
	lis 8,Use_Quad@ha
	cmpwi 0,0,0
	bc 4,2,.L78
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,16
	bc 4,2,.L78
	lwz 9,648(31)
	la 11,Use_Quad@l(8)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L74
	lwz 0,284(31)
	andis. 7,0,2
	bc 12,2,.L74
.L78:
	lwz 9,648(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L79
	lwz 0,284(31)
	andis. 9,0,2
	bc 12,2,.L79
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
.L79:
	lwz 9,648(31)
	mr 3,30
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L74:
	li 3,1
.L80:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Pickup_Powerup,.Lfe1-Pickup_Powerup
	.section	".rodata"
	.align 2
.LC6:
	.string	"Bullets"
	.align 2
.LC7:
	.string	"Shells"
	.align 3
.LC5:
	.long 0x3feaa7ef
	.long 0x9db22d0e
	.align 2
.LC8:
	.long 0x0
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC10:
	.long 0x3fe80000
	.long 0x0
	.section	".text"
	.align 2
	.globl Pickup_Bandolier
	.type	 Pickup_Bandolier,@function
Pickup_Bandolier:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 9,swaat@ha
	lis 5,.LC8@ha
	lwz 11,swaat@l(9)
	la 5,.LC8@l(5)
	mr 28,3
	lfs 13,0(5)
	mr 29,4
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L92
	lis 9,maxbullets@ha
	lwz 5,84(29)
	lwz 7,maxbullets@l(9)
	lis 6,0x4330
	mr 11,10
	lwz 0,1764(5)
	mr 8,10
	lis 9,.LC9@ha
	lfs 0,20(7)
	la 9,.LC9@l(9)
	xoris 0,0,0x8000
	lfd 11,0(9)
	stw 0,20(1)
	lis 9,.LC5@ha
	stw 6,16(1)
	lfd 13,16(1)
	lfd 10,.LC5@l(9)
	fctiwz 12,0
	fsub 13,13,11
	stfd 12,16(1)
	lwz 11,20(1)
	xoris 11,11,0x8000
	stw 11,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,11
	fmul 12,0,10
	fcmpu 0,13,12
	bc 4,0,.L93
	fctiwz 0,12
	mr 9,10
	stfd 0,16(1)
	lwz 9,20(1)
	stw 9,1764(5)
.L93:
	lis 10,maxshells@ha
	lwz 7,84(29)
	lwz 8,maxshells@l(10)
	mr 9,11
	lis 5,.LC10@ha
	lwz 0,1768(7)
	mr 10,11
	la 5,.LC10@l(5)
	lfs 0,20(8)
	xoris 0,0,0x8000
	lfd 9,0(5)
	stw 0,20(1)
	stw 6,16(1)
	lfd 13,16(1)
	fctiwz 12,0
	fsub 13,13,11
	stfd 12,16(1)
	lwz 9,20(1)
	xoris 9,9,0x8000
	stw 9,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,11
	fmul 12,0,9
	fcmpu 0,13,12
	bc 4,0,.L94
	fctiwz 0,12
	mr 9,11
	stfd 0,16(1)
	lwz 9,20(1)
	stw 9,1768(7)
.L94:
	lis 10,maxcells@ha
	lwz 7,84(29)
	lwz 8,maxcells@l(10)
	mr 9,11
	lwz 0,1780(7)
	mr 10,11
	lfs 0,20(8)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 6,16(1)
	lfd 13,16(1)
	fctiwz 12,0
	fsub 13,13,11
	stfd 12,16(1)
	lwz 9,20(1)
	xoris 9,9,0x8000
	stw 9,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,11
	fmul 12,0,10
	fcmpu 0,13,12
	bc 4,0,.L95
	fctiwz 0,12
	mr 9,11
	stfd 0,16(1)
	lwz 9,20(1)
	stw 9,1780(7)
.L95:
	lis 10,maxslugs@ha
	lwz 7,84(29)
	lwz 8,maxslugs@l(10)
	mr 9,11
	lwz 0,1784(7)
	mr 10,11
	lfs 0,20(8)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 6,16(1)
	lfd 13,16(1)
	fctiwz 12,0
	fsub 13,13,11
	stfd 12,16(1)
	lwz 9,20(1)
	xoris 9,9,0x8000
	stw 9,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,11
	fmul 12,0,9
	fcmpu 0,13,12
	bc 4,0,.L97
	fctiwz 0,12
	mr 9,11
	stfd 0,16(1)
	lwz 9,20(1)
	stw 9,1784(7)
	b .L97
.L124:
	mr 8,31
	b .L108
.L125:
	mr 8,31
	b .L118
.L92:
	lwz 9,84(29)
	lwz 0,1764(9)
	cmpwi 0,0,249
	bc 12,1,.L98
	li 0,250
	stw 0,1764(9)
.L98:
	lwz 9,84(29)
	lwz 0,1768(9)
	cmpwi 0,0,149
	bc 12,1,.L99
	li 0,150
	stw 0,1768(9)
.L99:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,249
	bc 12,1,.L100
	li 0,250
	stw 0,1780(9)
.L100:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,74
	bc 12,1,.L97
	li 0,75
	stw 0,1784(9)
.L97:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC6@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC6@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L109
	mr 27,10
.L104:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L106
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L124
.L106:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L104
.L109:
	li 8,0
.L108:
	cmpwi 0,8,0
	bc 12,2,.L110
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
	bc 4,1,.L110
	stwx 11,9,8
.L110:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC7@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC7@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L119
	mr 27,10
.L114:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L116
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L125
.L116:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L114
.L119:
	li 8,0
.L118:
	cmpwi 0,8,0
	bc 12,2,.L120
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
	bc 4,1,.L120
	stwx 11,4,8
.L120:
	lwz 0,284(28)
	andis. 4,0,0x1
	bc 4,2,.L122
	lis 11,deathmatch@ha
	lis 5,.LC8@ha
	lwz 9,deathmatch@l(11)
	la 5,.LC8@l(5)
	lfs 13,0(5)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L122
	lis 9,.LC9@ha
	lwz 11,648(28)
	la 9,.LC9@l(9)
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
.L122:
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
.LC11:
	.string	"Cells"
	.align 2
.LC12:
	.string	"Grenades"
	.align 2
.LC13:
	.string	"Rockets"
	.align 2
.LC14:
	.string	"Slugs"
	.align 2
.LC15:
	.long 0x0
	.align 3
.LC16:
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
	lis 11,.LC15@ha
	lis 9,swaat@ha
	la 11,.LC15@l(11)
	mr 26,3
	lfs 13,0(11)
	mr 29,4
	lwz 11,swaat@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L127
	lis 11,maxbullets@ha
	lwz 8,84(29)
	lwz 9,maxbullets@l(11)
	lwz 0,1764(8)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpw 0,0,9
	bc 4,0,.L128
	stw 9,1764(8)
.L128:
	lis 11,maxshells@ha
	lwz 8,84(29)
	lwz 9,maxshells@l(11)
	lwz 0,1768(8)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpw 0,0,9
	bc 4,0,.L129
	stw 9,1768(8)
.L129:
	lis 11,maxrockets@ha
	lwz 8,84(29)
	lwz 9,maxrockets@l(11)
	lwz 0,1772(8)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpw 0,0,9
	bc 4,0,.L130
	stw 9,1772(8)
.L130:
	lis 11,maxgrenades@ha
	lwz 8,84(29)
	lwz 9,maxgrenades@l(11)
	lwz 0,1776(8)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpw 0,0,9
	bc 4,0,.L131
	stw 9,1776(8)
.L131:
	lis 11,maxcells@ha
	lwz 8,84(29)
	lwz 9,maxcells@l(11)
	lwz 0,1780(8)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpw 0,0,9
	bc 4,0,.L132
	stw 9,1780(8)
.L132:
	lis 11,maxslugs@ha
	lwz 8,84(29)
	lwz 9,maxslugs@l(11)
	lwz 0,1784(8)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpw 0,0,9
	bc 4,0,.L134
	stw 9,1784(8)
	b .L134
.L203:
	mr 8,31
	b .L147
.L204:
	mr 8,31
	b .L157
.L205:
	mr 8,31
	b .L167
.L206:
	mr 8,31
	b .L177
.L207:
	mr 8,31
	b .L187
.L208:
	mr 8,31
	b .L197
.L127:
	lwz 9,84(29)
	lwz 0,1764(9)
	cmpwi 0,0,299
	bc 12,1,.L135
	li 0,300
	stw 0,1764(9)
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
	bc 12,1,.L134
	li 0,100
	stw 0,1784(9)
.L134:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC6@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC6@l(11)
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
	bc 12,2,.L203
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
	lis 11,.LC7@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC7@l(11)
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
	bc 12,2,.L204
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
	lwz 11,1768(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L159
	stwx 11,9,8
.L159:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC11@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC11@l(11)
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
	bc 12,2,.L205
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
	lwz 11,1780(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L169
	stwx 11,9,8
.L169:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC12@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC12@l(11)
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
	bc 12,2,.L206
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
	lwz 11,1776(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L179
	stwx 11,9,8
.L179:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC13@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC13@l(11)
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
	bc 12,2,.L207
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
	lwz 11,1772(9)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L189
	stwx 11,9,8
.L189:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC14@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC14@l(11)
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
	bc 12,2,.L208
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
	addi 4,9,740
	lwz 11,1784(9)
	lwzx 0,4,8
	cmpw 0,0,11
	bc 4,1,.L199
	stwx 11,4,8
.L199:
	lwz 0,284(26)
	andis. 4,0,0x1
	bc 4,2,.L201
	lis 9,.LC15@ha
	lis 11,deathmatch@ha
	la 9,.LC15@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L201
	lis 9,.LC16@ha
	lwz 11,648(26)
	la 9,.LC16@l(9)
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
.L201:
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
.LC17:
	.string	"items/damage.wav"
	.align 3
.LC18:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC19:
	.long 0x3f800000
	.align 2
.LC20:
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
	bc 12,2,.L210
	li 0,0
	mr 10,9
	stw 0,quad_drop_timeout_hack@l(11)
	b .L211
.L210:
	li 10,300
.L211:
	lis 11,level@ha
	lwz 8,84(31)
	lwz 11,level@l(11)
	lis 7,0x4330
	lis 6,.LC18@ha
	la 6,.LC18@l(6)
	lfs 12,3772(8)
	xoris 0,11,0x8000
	lfd 13,0(6)
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L212
	xoris 0,10,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fadds 0,12,0
	b .L215
.L212:
	add 0,11,10
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
.L215:
	stfs 0,3772(8)
	lis 29,gi@ha
	lis 3,.LC17@ha
	la 29,gi@l(29)
	la 3,.LC17@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 6,.LC19@ha
	lwz 0,16(29)
	lis 9,.LC19@ha
	la 6,.LC19@l(6)
	mr 5,3
	lfs 1,0(6)
	la 9,.LC19@l(9)
	mtlr 0
	li 4,3
	lis 6,.LC20@ha
	mr 3,31
	lfs 2,0(9)
	la 6,.LC20@l(6)
	lfs 3,0(6)
	blrl
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L214
	mr 3,31
	bl botPickBestWeapon
.L214:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 Use_Quad,.Lfe4-Use_Quad
	.section	".rodata"
	.align 2
.LC21:
	.string	"items/protect.wav"
	.align 2
.LC22:
	.string	"key_power_cube"
	.align 2
.LC23:
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
	lis 11,.LC23@ha
	lis 9,coop@ha
	la 11,.LC23@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 30,4
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L235
	lwz 3,280(31)
	lis 4,.LC22@ha
	la 4,.LC22@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L236
	lwz 10,84(30)
	lbz 9,286(31)
	lwz 0,1796(10)
	and. 11,0,9
	bc 4,2,.L241
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
	b .L238
.L236:
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
	bc 12,2,.L239
.L241:
	li 3,0
	b .L240
.L239:
	li 0,1
	stwx 0,4,3
.L238:
	li 3,1
	b .L240
.L235:
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
.L240:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Pickup_Key,.Lfe5-Pickup_Key
	.section	".rodata"
	.align 2
.LC24:
	.string	"blaster"
	.align 2
.LC25:
	.long 0x40400000
	.align 2
.LC26:
	.long 0x0
	.align 2
.LC27:
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
	lwz 8,648(29)
	lwz 0,56(8)
	andi. 4,0,1
	bc 12,2,.L260
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8192
	bc 12,2,.L260
	mr 7,8
	li 6,1000
	b .L261
.L260:
	lwz 0,532(29)
	cmpwi 0,0,0
	bc 12,2,.L262
	mr 6,0
	lwz 7,648(29)
	b .L261
.L262:
	lwz 9,648(29)
	lwz 6,48(9)
	mr 7,9
.L261:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 8,84(28)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,7
	cmpwi 0,8,0
	mullw 9,9,0
	addi 11,8,740
	rlwinm 9,9,0,0,29
	lwzx 5,11,9
	bc 12,2,.L298
	lwz 0,68(7)
	cmpwi 0,0,0
	bc 4,2,.L268
	lwz 10,1764(8)
	b .L269
.L268:
	cmpwi 0,0,1
	bc 4,2,.L270
	lwz 10,1768(8)
	b .L269
.L270:
	cmpwi 0,0,2
	bc 4,2,.L272
	lwz 10,1772(8)
	b .L269
.L272:
	cmpwi 0,0,3
	bc 4,2,.L274
	lwz 10,1776(8)
	b .L269
.L274:
	cmpwi 0,0,4
	bc 4,2,.L276
	lwz 10,1780(8)
	b .L269
.L276:
	cmpwi 0,0,5
	bc 4,2,.L298
	lwz 10,1784(8)
.L269:
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,7
	addi 11,8,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpw 0,0,10
	bc 4,2,.L280
.L298:
	li 11,0
	b .L267
.L280:
	add 0,0,6
	cmpw 0,0,10
	stwx 0,11,9
	bc 4,1,.L281
	stwx 10,11,9
.L281:
	li 11,1
.L267:
	cmpwi 0,11,0
	bc 4,2,.L264
	lwz 0,968(28)
	cmpwi 0,0,0
	bc 12,2,.L282
	lwz 0,416(28)
	cmpw 0,0,29
	bc 4,2,.L282
	lis 10,.LC25@ha
	lis 9,level+4@ha
	la 10,.LC25@l(10)
	lfs 0,level+4@l(9)
	mr 3,28
	lfs 13,0(10)
	li 4,0
	fadds 0,0,13
	stfs 0,1296(29)
	stw 11,416(28)
	bl bot_roam
.L282:
	li 3,0
	b .L296
.L297:
	mr 9,31
	b .L292
.L264:
	subfic 9,5,0
	adde 0,9,5
	and. 10,4,0
	bc 12,2,.L283
	lwz 25,84(28)
	lwz 9,648(29)
	lwz 0,1788(25)
	cmpw 0,0,9
	bc 12,2,.L283
	lis 9,.LC26@ha
	lis 11,deathmatch@ha
	la 9,.LC26@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L285
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC24@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC24@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L293
	mr 27,10
.L288:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L290
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L297
.L290:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L288
.L293:
	li 9,0
.L292:
	lwz 0,1788(25)
	cmpw 0,0,9
	bc 4,2,.L283
.L285:
	lwz 9,84(28)
	lwz 0,648(29)
	stw 0,3596(9)
.L283:
	lwz 0,284(29)
	andis. 7,0,0x3
	bc 4,2,.L294
	lis 9,.LC26@ha
	lis 11,deathmatch@ha
	la 9,.LC26@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L294
	lwz 9,264(29)
	lis 11,.LC27@ha
	lis 10,level+4@ha
	lwz 0,184(29)
	la 11,.LC27@l(11)
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
.L294:
	li 3,1
.L296:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 Pickup_Ammo,.Lfe6-Pickup_Ammo
	.section	".rodata"
	.align 2
.LC28:
	.string	"Can't drop current weapon\n"
	.align 2
.LC29:
	.long 0x3f800000
	.align 2
.LC30:
	.long 0x0
	.align 2
.LC31:
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
	bl K2_IsRegen
	cmpwi 0,3,0
	bc 4,2,.L303
	lwz 3,256(31)
	bl K2_IsBFK
	cmpwi 0,3,0
	bc 4,2,.L303
	lwz 3,256(31)
	lwz 9,480(3)
	lwz 0,484(3)
	cmpw 0,9,0
	bc 4,1,.L306
	bl CTFHasRegeneration
	cmpwi 0,3,0
	bc 4,2,.L306
	lis 11,.LC29@ha
	lis 9,level+4@ha
	la 11,.LC29@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	lwz 11,256(31)
	fadds 0,0,13
	stfs 0,428(31)
	lwz 9,480(11)
	addi 9,9,-1
	stw 9,480(11)
	b .L303
.L306:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L307
	lis 9,.LC30@ha
	lis 11,deathmatch@ha
	la 9,.LC30@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L307
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
	b .L303
.L307:
	mr 3,31
	bl G_FreeEdict
.L303:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 MegaHealth_think,.Lfe7-MegaHealth_think
	.section	".rodata"
	.align 2
.LC32:
	.long 0x3f800000
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
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 0,644(31)
	andi. 11,0,1
	bc 4,2,.L311
	lwz 9,480(30)
	lwz 0,484(30)
	cmpw 0,9,0
	bc 12,0,.L311
	lwz 0,968(30)
	cmpwi 0,0,0
	bc 12,2,.L315
	lwz 0,416(30)
	cmpw 0,0,31
	bc 4,2,.L315
	lis 8,.LC32@ha
	lis 9,level+4@ha
	la 8,.LC32@l(8)
	lfs 0,level+4@l(9)
	mr 3,30
	lfs 13,0(8)
	li 4,0
	fadds 0,0,13
	stfs 0,1296(31)
	stw 11,416(30)
	bl bot_roam
	b .L328
.L311:
	lwz 0,644(31)
	rlwinm 0,0,0,30,31
	cmpwi 0,0,1
	bc 4,2,.L314
	lis 6,maxhealth@ha
	lwz 10,484(30)
	lwz 7,maxhealth@l(6)
	lwz 8,480(30)
	lfs 13,20(7)
	fctiwz 0,13
	stfd 0,16(1)
	lwz 9,20(1)
	addi 9,9,100
	cmpw 0,10,9
	bc 12,0,.L316
	addi 0,10,100
	cmpw 0,8,0
	bc 4,0,.L315
.L316:
	lwz 11,532(31)
	add 11,8,11
	stw 11,480(30)
	lwz 0,532(31)
	add 0,10,0
	stw 0,484(30)
	lfs 0,20(7)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	addi 9,9,100
	cmpw 0,11,9
	bc 4,1,.L317
	stw 9,480(30)
.L317:
	lwz 11,maxhealth@l(6)
	lwz 0,484(30)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	addi 9,9,100
	cmpw 0,0,9
	bc 4,1,.L320
	stw 9,484(30)
	b .L320
.L328:
.L315:
	li 3,0
	b .L327
.L314:
	lwz 0,480(30)
	lwz 9,532(31)
	add 0,0,9
	stw 0,480(30)
.L320:
	lwz 0,644(31)
	andi. 8,0,1
	bc 4,2,.L321
	lwz 0,480(30)
	lwz 9,484(30)
	cmpw 0,0,9
	bc 4,1,.L321
	stw 9,480(30)
.L321:
	lwz 0,644(31)
	andi. 9,0,2
	bc 12,2,.L323
	mr 3,30
	bl CTFHasRegeneration
	mr. 3,3
	bc 4,2,.L323
	lis 9,MegaHealth_think@ha
	lis 8,.LC33@ha
	lwz 11,264(31)
	la 9,MegaHealth_think@l(9)
	lis 10,level+4@ha
	lwz 0,184(31)
	la 8,.LC33@l(8)
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
	b .L324
.L323:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L324
	lis 9,.LC34@ha
	lis 11,deathmatch@ha
	la 9,.LC34@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L324
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
.L324:
	li 3,1
.L327:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 Pickup_Health,.Lfe8-Pickup_Health
	.section	".rodata"
	.align 3
.LC36:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC37:
	.long 0x40000000
	.align 2
.LC38:
	.long 0x0
	.align 2
.LC39:
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
	lwz 7,84(4)
	mr 12,3
	cmpwi 0,7,0
	bc 4,2,.L336
	li 3,0
	b .L362
.L336:
	lis 11,jacket_armor_index@ha
	lwz 9,648(12)
	addi 8,7,740
	lwz 5,jacket_armor_index@l(11)
	mr 6,9
	lwz 31,64(9)
	slwi 0,5,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L340
	lis 9,combat_armor_index@ha
	lwz 5,combat_armor_index@l(9)
	slwi 0,5,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L340
	lis 9,body_armor_index@ha
	lwz 10,body_armor_index@l(9)
	slwi 11,10,2
	lwzx 9,8,11
	srawi 0,9,31
	subf 0,9,0
	srawi 0,0,31
	and 5,10,0
.L340:
	lwz 0,68(6)
	cmpwi 0,0,4
	bc 4,2,.L344
	cmpwi 0,5,0
	bc 4,2,.L345
	lis 9,jacket_armor_index@ha
	addi 10,7,740
	lwz 0,jacket_armor_index@l(9)
	li 11,2
	slwi 0,0,2
	stwx 11,10,0
	b .L347
.L345:
	slwi 0,5,2
	addi 11,7,740
	lwzx 9,11,0
	addi 9,9,2
	stwx 9,11,0
	b .L347
.L344:
	cmpwi 0,5,0
	bc 4,2,.L348
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,0(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,6
	addi 11,7,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	stwx 10,11,9
	b .L347
.L348:
	lis 9,jacket_armor_index@ha
	lwz 0,jacket_armor_index@l(9)
	cmpw 0,5,0
	bc 4,2,.L350
	lis 9,jacketarmor_info@ha
	la 11,jacketarmor_info@l(9)
	b .L351
.L350:
	lis 9,combat_armor_index@ha
	lwz 0,combat_armor_index@l(9)
	cmpw 0,5,0
	bc 4,2,.L352
	lis 9,combatarmor_info@ha
	la 11,combatarmor_info@l(9)
	b .L351
.L352:
	lis 9,bodyarmor_info@ha
	la 11,bodyarmor_info@l(9)
.L351:
	lfs 13,8(31)
	lfs 0,8(11)
	fcmpu 0,13,0
	bc 4,1,.L354
	fdivs 11,0,13
	addi 7,7,740
	slwi 5,5,2
	lwz 10,4(31)
	lwzx 0,7,5
	lis 6,0x4330
	lis 8,.LC36@ha
	lwz 3,0(31)
	mr 4,9
	xoris 0,0,0x8000
	la 8,.LC36@l(8)
	stw 0,20(1)
	lis 11,itemlist@ha
	stw 6,16(1)
	lis 0,0x286b
	la 11,itemlist@l(11)
	lfd 13,0(8)
	ori 0,0,51739
	lfd 0,16(1)
	li 8,0
	stwx 8,7,5
	lwz 9,648(12)
	subf 9,11,9
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	fsub 0,0,13
	frsp 0,0
	fmuls 0,11,0
	fmr 13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 0,20(1)
	add 3,3,0
	cmpw 7,3,10
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 10,10,0
	and 0,3,0
	or 3,0,10
	stwx 3,7,9
	b .L347
.L354:
	fdivs 11,13,0
	lwz 0,0(31)
	lis 10,0x4330
	lis 8,.LC36@ha
	slwi 5,5,2
	lwz 11,4(11)
	xoris 0,0,0x8000
	la 8,.LC36@l(8)
	stw 0,20(1)
	addi 7,7,740
	stw 10,16(1)
	lfd 13,0(8)
	lfd 0,16(1)
	mr 8,9
	lwzx 10,7,5
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
	bc 12,0,.L358
	lwz 0,968(4)
	cmpwi 0,0,0
	bc 12,2,.L359
	lwz 0,416(4)
	cmpw 0,0,12
	bc 4,2,.L359
	li 0,0
	stw 0,416(4)
.L359:
	lis 11,.LC37@ha
	lis 9,level+4@ha
	la 11,.LC37@l(11)
	lfs 0,level+4@l(9)
	li 3,0
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,1296(12)
	b .L362
.L358:
	stwx 0,7,5
.L347:
	lwz 0,284(12)
	andis. 7,0,0x1
	bc 4,2,.L360
	lis 11,deathmatch@ha
	lis 8,.LC38@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC38@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L360
	lwz 9,264(12)
	lis 11,.LC39@ha
	lis 10,level+4@ha
	lwz 0,184(12)
	la 11,.LC39@l(11)
	lis 8,gi+72@ha
	oris 9,9,0x8000
	stw 7,248(12)
	mr 3,12
	ori 0,0,1
	stw 9,264(12)
	stw 0,184(12)
	lfs 0,level+4@l(10)
	lfs 13,0(11)
	lis 11,DoRespawn@ha
	la 11,DoRespawn@l(11)
	fadds 0,0,13
	stw 11,436(12)
	stfs 0,428(12)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
.L360:
	li 3,1
.L362:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 Pickup_Armor,.Lfe9-Pickup_Armor
	.section	".rodata"
	.align 2
.LC40:
	.string	"misc/power2.wav"
	.align 2
.LC41:
	.string	"cells"
	.align 2
.LC42:
	.string	"No cells for power armor.\n"
	.align 2
.LC43:
	.string	"misc/power1.wav"
	.align 2
.LC44:
	.long 0x3f800000
	.align 2
.LC45:
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
	bc 12,2,.L370
	rlwinm 0,0,0,20,18
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(30)
	lis 3,.LC40@ha
	lwz 9,36(29)
	la 3,.LC40@l(3)
	mtlr 9
	blrl
	lis 9,.LC44@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC44@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 2,0(9)
	lis 9,.LC45@ha
	la 9,.LC45@l(9)
	lfs 3,0(9)
	blrl
	b .L369
.L381:
	mr 10,29
	b .L378
.L370:
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lis 11,.LC41@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC41@l(11)
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L379
	mr 28,10
.L374:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L376
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L381
.L376:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,76
	cmpw 0,31,0
	bc 12,0,.L374
.L379:
	li 10,0
.L378:
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
	bc 4,2,.L380
	lis 5,.LC42@ha
	mr 3,30
	la 5,.LC42@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L369
.L380:
	lwz 0,264(30)
	lis 29,gi@ha
	lis 3,.LC43@ha
	la 29,gi@l(29)
	la 3,.LC43@l(3)
	ori 0,0,4096
	stw 0,264(30)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC44@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC44@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 2,0(9)
	lis 9,.LC45@ha
	la 9,.LC45@l(9)
	lfs 3,0(9)
	blrl
.L369:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 Use_PowerArmor,.Lfe10-Use_PowerArmor
	.section	".rodata"
	.align 2
.LC46:
	.long 0x0
	.align 3
.LC47:
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
	lis 11,.LC46@ha
	lwzx 30,10,9
	la 11,.LC46@l(11)
	lfs 13,0(11)
	addi 0,30,1
	stwx 0,10,9
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L383
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L384
	lis 9,.LC47@ha
	lwz 11,648(31)
	la 9,.LC47@l(9)
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
.L384:
	cmpwi 0,30,0
	bc 4,2,.L383
	lwz 9,648(31)
	mr 3,29
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L383:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 Pickup_PowerArmor,.Lfe11-Pickup_PowerArmor
	.section	".rodata"
	.align 2
.LC49:
	.string	"items/s_health.wav"
	.align 2
.LC50:
	.string	"items/n_health.wav"
	.align 2
.LC51:
	.string	"items/l_health.wav"
	.align 2
.LC52:
	.string	"items/m_health.wav"
	.align 2
.LC48:
	.long 0x3e4ccccd
	.align 2
.LC53:
	.long 0x3f800000
	.align 3
.LC54:
	.long 0x40080000
	.long 0x0
	.align 2
.LC55:
	.long 0x0
	.section	".text"
	.align 2
	.globl Touch_Item
	.type	 Touch_Item,@function
Touch_Item:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	mr 31,4
	lis 9,.LC53@ha
	lwz 0,968(31)
	la 9,.LC53@l(9)
	mr 30,3
	lfs 31,0(9)
	cmpwi 0,0,0
	bc 12,2,.L391
	lwz 11,648(30)
	lis 9,Pickup_Weapon@ha
	la 9,Pickup_Weapon@l(9)
	lwz 0,4(11)
	cmpw 0,0,9
	bc 12,2,.L392
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L392
	lis 9,Pickup_Ammo@ha
	la 9,Pickup_Ammo@l(9)
	cmpw 0,0,9
	bc 12,2,.L392
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L392
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L392
	lis 9,Pickup_Pack@ha
	la 9,Pickup_Pack@l(9)
	cmpw 0,0,9
	bc 12,2,.L392
	lis 9,Pickup_Bandolier@ha
	la 9,Pickup_Bandolier@l(9)
	cmpw 0,0,9
	bc 12,2,.L392
	lis 9,CTFPickup_Flag@ha
	la 9,CTFPickup_Flag@l(9)
	cmpw 0,0,9
	bc 12,2,.L392
	lis 9,CTFPickup_Tech@ha
	la 9,CTFPickup_Tech@l(9)
	cmpw 0,0,9
	bc 4,2,.L390
.L392:
	lwz 0,416(31)
	cmpw 0,0,30
	bc 4,2,.L391
	li 0,0
	li 9,0
	stw 0,416(31)
	stw 9,1056(31)
	stw 0,412(31)
	stw 9,1128(31)
.L391:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L390
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L390
	lwz 9,648(30)
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 12,2,.L390
	mr 3,30
	mr 4,31
	mtlr 0
	blrl
	mr. 28,3
	bc 12,2,.L399
	lwz 11,84(31)
	lis 0,0x3e80
	lis 9,gi@ha
	la 29,gi@l(9)
	stw 0,3684(11)
	lwz 9,648(30)
	lwz 11,40(29)
	lwz 3,36(9)
	mtlr 11
	blrl
	lis 9,itemlist@ha
	lwz 11,84(31)
	lis 8,0x286b
	la 7,itemlist@l(9)
	ori 8,8,51739
	lis 9,.LC54@ha
	sth 3,134(11)
	lis 10,level+4@ha
	la 9,.LC54@l(9)
	lwz 11,84(31)
	lfd 13,0(9)
	lwz 9,648(30)
	subf 9,7,9
	mullw 9,9,8
	srawi 9,9,2
	addi 9,9,1056
	sth 9,136(11)
	lfs 0,level+4@l(10)
	lwz 9,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3804(9)
	lwz 9,648(30)
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 12,2,.L400
	subf 0,7,9
	lwz 11,84(31)
	mullw 0,0,8
	srawi 0,0,2
	extsh 9,0
	sth 0,144(11)
	stw 9,736(11)
.L400:
	mr 3,31
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L401
	lis 9,.LC48@ha
	lfs 31,.LC48@l(9)
.L401:
	lwz 3,648(30)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	lwz 0,4(3)
	cmpw 0,0,9
	bc 4,2,.L402
	lwz 0,532(30)
	cmpwi 0,0,2
	bc 4,2,.L403
	lwz 9,36(29)
	lis 3,.LC49@ha
	la 3,.LC49@l(3)
	b .L430
.L403:
	cmpwi 0,0,10
	bc 4,2,.L405
	lwz 9,36(29)
	lis 3,.LC50@ha
	la 3,.LC50@l(3)
	b .L430
.L405:
	cmpwi 0,0,25
	bc 4,2,.L407
	lwz 9,36(29)
	lis 3,.LC51@ha
	la 3,.LC51@l(3)
	b .L430
.L407:
	lwz 9,36(29)
	lis 3,.LC52@ha
	la 3,.LC52@l(3)
.L430:
	mtlr 9
	blrl
	lis 9,.LC53@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC53@l(9)
	li 4,3
	lfs 2,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 3,0(9)
	blrl
	b .L399
.L402:
	lwz 3,20(3)
	cmpwi 0,3,0
	bc 12,2,.L399
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC53@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC53@l(9)
	li 4,3
	lfs 2,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 3,0(9)
	blrl
.L399:
	lwz 0,284(30)
	andis. 9,0,4
	bc 4,2,.L411
	mr 4,31
	mr 3,30
	bl G_UseTargets
	lwz 0,284(30)
	oris 0,0,0x4
	stw 0,284(30)
.L411:
	cmpwi 0,28,0
	bc 12,2,.L390
	lis 9,.LC55@ha
	lis 11,coop@ha
	la 9,.LC55@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L414
	lwz 9,648(30)
	lwz 0,56(9)
	andi. 9,0,8
	bc 12,2,.L414
	lwz 0,284(30)
	andis. 9,0,0x3
	bc 12,2,.L390
.L414:
	lwz 0,264(30)
	cmpwi 0,0,0
	bc 4,0,.L415
	rlwinm 0,0,0,1,31
	stw 0,264(30)
	b .L390
.L415:
	lwz 11,648(30)
	lis 9,Pickup_Weapon@ha
	la 9,Pickup_Weapon@l(9)
	lwz 0,4(11)
	cmpw 0,0,9
	bc 12,2,.L418
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L418
	lis 9,Pickup_Ammo@ha
	la 9,Pickup_Ammo@l(9)
	cmpw 0,0,9
	bc 12,2,.L418
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L418
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L418
	lis 9,CTFPickup_Flag@ha
	la 9,CTFPickup_Flag@l(9)
	cmpw 0,0,9
	bc 12,2,.L418
	lis 9,CTFPickup_Tech@ha
	la 9,CTFPickup_Tech@l(9)
	cmpw 0,0,9
	bc 4,2,.L417
.L418:
	lwz 9,936(30)
	cmpwi 0,9,0
	bc 12,2,.L419
	lwz 0,892(30)
	stw 0,892(9)
.L419:
	lwz 9,892(30)
	cmpwi 0,9,0
	bc 12,2,.L420
	lwz 0,936(30)
	stw 0,936(9)
	b .L421
.L420:
	lwz 10,936(30)
	cmpwi 0,10,0
	bc 12,2,.L421
	lwz 11,648(30)
	lis 9,Pickup_Weapon@ha
	la 9,Pickup_Weapon@l(9)
	lwz 0,4(11)
	cmpw 0,0,9
	bc 4,2,.L423
	lis 9,weapons_head@ha
	stw 10,weapons_head@l(9)
	b .L421
.L423:
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 4,2,.L425
	lis 9,health_head@ha
	stw 10,health_head@l(9)
	b .L421
.L425:
	lis 9,Pickup_Ammo@ha
	la 9,Pickup_Ammo@l(9)
	cmpw 0,0,9
	bc 4,2,.L427
	lis 9,ammo_head@ha
	stw 10,ammo_head@l(9)
	b .L421
.L427:
	lis 9,bonus_head@ha
	stw 10,bonus_head@l(9)
.L421:
	li 0,0
	stw 0,892(30)
	stw 0,936(30)
.L417:
	mr 3,30
	bl G_FreeEdict
.L390:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 Touch_Item,.Lfe12-Touch_Item
	.section	".rodata"
	.align 2
.LC56:
	.long 0x0
	.align 2
.LC57:
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
	lis 9,.LC56@ha
	lfs 0,20(10)
	la 9,.LC56@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L434
	lwz 11,648(31)
	lis 9,Pickup_Weapon@ha
	la 9,Pickup_Weapon@l(9)
	lwz 0,4(11)
	cmpw 0,0,9
	bc 12,2,.L436
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L436
	lis 9,Pickup_Ammo@ha
	la 9,Pickup_Ammo@l(9)
	cmpw 0,0,9
	bc 12,2,.L436
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L436
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L436
	lis 9,CTFPickup_Flag@ha
	la 9,CTFPickup_Flag@l(9)
	cmpw 0,0,9
	bc 12,2,.L436
	lis 9,CTFPickup_Tech@ha
	la 9,CTFPickup_Tech@l(9)
	cmpw 0,0,9
	bc 4,2,.L435
.L436:
	mr 3,31
	bl CalcItemPaths
	lis 9,.LC57@ha
	lis 11,level+4@ha
	la 9,.LC57@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,RemoveDroppedItem@ha
	la 9,RemoveDroppedItem@l(9)
	b .L438
.L435:
	lis 9,.LC57@ha
	lis 11,level+4@ha
	la 9,.LC57@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
.L438:
	fadds 0,0,13
	stw 9,436(31)
	stfs 0,428(31)
.L434:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe13:
	.size	 drop_make_touchable,.Lfe13-drop_make_touchable
	.section	".rodata"
	.align 2
.LC58:
	.long 0x42c80000
	.align 2
.LC59:
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
	bc 12,2,.L440
	addi 29,1,24
	addi 4,1,8
	addi 3,3,3700
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
	b .L442
.L440:
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
.L442:
	stfs 0,12(31)
	lis 9,.LC58@ha
	addi 3,1,8
	la 9,.LC58@l(9)
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
	lis 9,.LC59@ha
	lfs 0,level+4@l(11)
	la 9,.LC59@l(9)
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
.LC60:
	.string	"droptofloor: %s startsolid at %s\n"
	.align 3
.LC61:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC62:
	.long 0xc1700000
	.align 2
.LC63:
	.long 0x41700000
	.align 2
.LC64:
	.long 0x0
	.align 2
.LC65:
	.long 0xc3000000
	.section	".text"
	.align 2
	.globl droptofloor
	.type	 droptofloor,@function
droptofloor:
	stwu 1,-128(1)
	mflr 0
	stmw 29,116(1)
	stw 0,132(1)
	lis 9,.LC62@ha
	lis 11,.LC62@ha
	la 9,.LC62@l(9)
	la 11,.LC62@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC62@ha
	lfs 2,0(11)
	la 9,.LC62@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC63@ha
	lfs 13,0(11)
	la 9,.LC63@l(9)
	lfs 1,0(9)
	lis 9,.LC63@ha
	stfs 13,188(31)
	la 9,.LC63@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC63@ha
	stfs 0,192(31)
	la 9,.LC63@l(9)
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
	bc 12,2,.L447
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L448
.L447:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L448:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC64@ha
	stw 9,444(31)
	addi 29,31,4
	la 11,.LC64@l(11)
	lis 9,.LC65@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC65@l(9)
	lis 11,.LC64@ha
	lfs 3,0(9)
	la 11,.LC64@l(11)
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
	bc 12,2,.L449
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC60@ha
	la 3,.LC60@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L457
.L449:
	lwz 0,308(31)
	lfs 12,20(1)
	lfs 0,24(1)
	cmpwi 0,0,0
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L450
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
	bc 4,2,.L450
	lis 11,level+4@ha
	lis 10,.LC61@ha
	lfs 0,level+4@l(11)
	lis 9,DoRespawn@ha
	lfd 13,.LC61@l(10)
	la 9,DoRespawn@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L450:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L452
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
.L452:
	lwz 0,284(31)
	andi. 11,0,1
	bc 12,2,.L453
	lwz 0,184(31)
	lis 9,Use_Item@ha
	li 11,0
	la 9,Use_Item@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
.L453:
	lis 10,dmflags@ha
	lwz 8,648(31)
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,104(1)
	lwz 11,108(1)
	andi. 0,11,8192
	bc 12,2,.L454
	lwz 0,4(8)
	lis 9,Pickup_Ammo@ha
	la 9,Pickup_Ammo@l(9)
	cmpw 0,0,9
	bc 4,2,.L454
.L457:
	mr 3,31
	bl G_FreeEdict
	b .L446
.L454:
	lwz 0,4(8)
	lis 9,Pickup_Weapon@ha
	la 9,Pickup_Weapon@l(9)
	cmpw 0,0,9
	bc 12,2,.L456
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L456
	lis 9,Pickup_Ammo@ha
	la 9,Pickup_Ammo@l(9)
	cmpw 0,0,9
	bc 12,2,.L456
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L456
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L456
	lis 9,Pickup_Pack@ha
	la 9,Pickup_Pack@l(9)
	cmpw 0,0,9
	bc 12,2,.L456
	lis 9,Pickup_Bandolier@ha
	la 9,Pickup_Bandolier@l(9)
	cmpw 0,0,9
	bc 12,2,.L456
	lis 9,CTFPickup_Flag@ha
	la 9,CTFPickup_Flag@l(9)
	cmpw 0,0,9
	bc 12,2,.L456
	lis 9,CTFPickup_Tech@ha
	la 9,CTFPickup_Tech@l(9)
	cmpw 0,0,9
	bc 4,2,.L455
.L456:
	mr 3,31
	bl CalcItemPaths
.L455:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L446:
	lwz 0,132(1)
	mtlr 0
	lmw 29,116(1)
	la 1,128(1)
	blr
.Lfe15:
	.size	 droptofloor,.Lfe15-droptofloor
	.section	".rodata"
	.align 2
.LC66:
	.string	"PrecacheItem: %s has bad precache string"
	.align 2
.LC67:
	.string	"md2"
	.align 2
.LC68:
	.string	"sp2"
	.align 2
.LC69:
	.string	"wav"
	.align 2
.LC70:
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
	bc 12,2,.L458
	lwz 3,20(26)
	cmpwi 0,3,0
	bc 12,2,.L460
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L460:
	lwz 3,24(26)
	cmpwi 0,3,0
	bc 12,2,.L461
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L461:
	lwz 3,32(26)
	cmpwi 0,3,0
	bc 12,2,.L462
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L462:
	lwz 3,36(26)
	cmpwi 0,3,0
	bc 12,2,.L463
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
.L463:
	lwz 29,52(26)
	cmpwi 0,29,0
	bc 12,2,.L464
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L464
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L472
	mr 28,9
.L467:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L469
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L469
	mr 3,31
	b .L471
.L469:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L467
.L472:
	li 3,0
.L471:
	cmpw 0,3,26
	bc 12,2,.L464
	bl PrecacheItem
.L464:
	lwz 30,72(26)
	cmpwi 0,30,0
	bc 12,2,.L458
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 12,2,.L458
	lis 9,gi@ha
	addi 29,1,8
	la 27,gi@l(9)
	lis 24,.LC67@ha
	lis 25,.LC70@ha
.L478:
	rlwinm 9,0,0,0xff
	mr 31,30
	b .L492
.L481:
	lbzu 9,1(30)
.L492:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L481
	subf 28,31,30
	addi 0,28,-5
	cmplwi 0,0,58
	bc 4,1,.L483
	lwz 9,28(27)
	lis 3,.LC66@ha
	la 3,.LC66@l(3)
	lwz 4,0(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L483:
	mr 4,31
	mr 5,28
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 0,0
	addi 11,30,1
	stbx 0,29,28
	add 9,29,28
	la 4,.LC67@l(24)
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
	bc 12,2,.L493
	lis 4,.LC68@ha
	mr 3,31
	la 4,.LC68@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L487
.L493:
	lwz 9,32(27)
	mr 3,29
	mtlr 9
	blrl
	b .L486
.L487:
	lis 4,.LC69@ha
	mr 3,31
	la 4,.LC69@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L486
	lwz 9,36(27)
	mr 3,29
	mtlr 9
	blrl
.L486:
	add 3,29,28
	la 4,.LC70@l(25)
	addi 3,3,-3
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L476
	lwz 9,40(27)
	mr 3,29
	mtlr 9
	blrl
.L476:
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L478
.L458:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe16:
	.size	 PrecacheItem,.Lfe16-PrecacheItem
	.section	".rodata"
	.align 2
.LC71:
	.string	"%s at %s has invalid spawnflags set\n"
	.align 2
.LC72:
	.string	"BFG10K"
	.align 2
.LC73:
	.string	"Shotgun"
	.align 2
.LC74:
	.string	"Super Shotgun"
	.align 2
.LC75:
	.string	"Machinegun"
	.align 2
.LC76:
	.string	"Chaingun"
	.align 2
.LC77:
	.string	"Grenade Launcher"
	.align 2
.LC78:
	.string	"Rocket Launcher"
	.align 2
.LC79:
	.string	"Hyperblaster"
	.align 2
.LC80:
	.string	"Railgun"
	.align 2
.LC81:
	.string	"Quad Damage"
	.align 2
.LC82:
	.string	"Invulnerability"
	.align 2
.LC83:
	.string	"weapon_bfg"
	.align 2
.LC85:
	.string	"item_flag_team1"
	.align 2
.LC86:
	.string	"item_flag_team2"
	.align 3
.LC84:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC87:
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
	bc 12,2,.L495
	lwz 3,280(31)
	lis 4,.LC22@ha
	la 4,.LC22@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L495
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
	lis 3,.LC71@ha
	la 3,.LC71@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L495:
	lwz 3,40(30)
	lis 4,.LC72@ha
	la 4,.LC72@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L497
	lis 9,.LC87@ha
	lis 11,nobfg@ha
	la 9,.LC87@l(9)
	lfs 13,0(9)
	lwz 9,nobfg@l(11)
.L546:
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L499
	b .L540
.L497:
	lwz 3,40(30)
	lis 4,.LC73@ha
	la 4,.LC73@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L500
	lis 9,.LC87@ha
	lis 11,noshotgun@ha
	la 9,.LC87@l(9)
	lfs 13,0(9)
	lwz 9,noshotgun@l(11)
	b .L546
.L500:
	lwz 3,40(30)
	lis 4,.LC74@ha
	la 4,.LC74@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L503
	lis 9,.LC87@ha
	lis 11,nosupershotgun@ha
	la 9,.LC87@l(9)
	lfs 13,0(9)
	lwz 9,nosupershotgun@l(11)
	b .L546
.L503:
	lwz 3,40(30)
	lis 4,.LC75@ha
	la 4,.LC75@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L506
	lis 9,.LC87@ha
	lis 11,nomachinegun@ha
	la 9,.LC87@l(9)
	lfs 13,0(9)
	lwz 9,nomachinegun@l(11)
	b .L546
.L506:
	lwz 3,40(30)
	lis 4,.LC76@ha
	la 4,.LC76@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L509
	lis 9,.LC87@ha
	lis 11,nochaingun@ha
	la 9,.LC87@l(9)
	lfs 13,0(9)
	lwz 9,nochaingun@l(11)
	b .L546
.L509:
	lwz 3,40(30)
	lis 4,.LC77@ha
	la 4,.LC77@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L512
	lis 9,.LC87@ha
	lis 11,nogrenadelauncher@ha
	la 9,.LC87@l(9)
	lfs 13,0(9)
	lwz 9,nogrenadelauncher@l(11)
	b .L546
.L512:
	lwz 3,40(30)
	lis 4,.LC78@ha
	la 4,.LC78@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L515
	lis 9,.LC87@ha
	lis 11,norocketlauncher@ha
	la 9,.LC87@l(9)
	lfs 13,0(9)
	lwz 9,norocketlauncher@l(11)
	b .L546
.L515:
	lwz 3,40(30)
	lis 4,.LC79@ha
	la 4,.LC79@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L518
	lis 9,.LC87@ha
	lis 11,nohyperblaster@ha
	la 9,.LC87@l(9)
	lfs 13,0(9)
	lwz 9,nohyperblaster@l(11)
	b .L546
.L518:
	lwz 3,40(30)
	lis 4,.LC80@ha
	la 4,.LC80@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L521
	lis 9,.LC87@ha
	lis 11,norailgun@ha
	la 9,.LC87@l(9)
	lfs 13,0(9)
	lwz 9,norailgun@l(11)
	b .L546
.L521:
	lwz 3,40(30)
	lis 4,.LC81@ha
	la 4,.LC81@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L524
	lis 9,.LC87@ha
	lis 11,noquad@ha
	la 9,.LC87@l(9)
	lfs 13,0(9)
	lwz 9,noquad@l(11)
	b .L546
.L524:
	lwz 3,40(30)
	lis 4,.LC82@ha
	la 4,.LC82@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L499
	lis 9,.LC87@ha
	lis 11,noinvulnerability@ha
	la 9,.LC87@l(9)
	lfs 13,0(9)
	lwz 9,noinvulnerability@l(11)
	b .L546
.L499:
	lis 9,.LC87@ha
	lis 11,deathmatch@ha
	la 9,.LC87@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L529
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2048
	bc 12,2,.L530
	lwz 0,4(30)
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L540
	lis 9,Pickup_PowerArmor@ha
	la 9,Pickup_PowerArmor@l(9)
	cmpw 0,0,9
	bc 12,2,.L540
.L530:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 12,2,.L533
	lwz 0,4(30)
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L540
.L533:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 12,2,.L535
	lwz 0,4(30)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L540
	lis 9,Pickup_Adrenaline@ha
	la 9,Pickup_Adrenaline@l(9)
	cmpw 0,0,9
	bc 12,2,.L540
	lis 9,Pickup_AncientHead@ha
	la 9,Pickup_AncientHead@l(9)
	cmpw 0,0,9
	bc 12,2,.L540
.L535:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8192
	bc 12,2,.L529
	lwz 0,56(30)
	cmpwi 0,0,2
	bc 12,2,.L540
	lwz 3,280(31)
	lis 4,.LC83@ha
	la 4,.LC83@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L529
.L540:
	mr 3,31
	bl G_FreeEdict
	b .L494
.L529:
	lis 11,.LC87@ha
	lis 9,coop@ha
	la 11,.LC87@l(11)
	lis 29,level@ha
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L541
	lwz 3,280(31)
	lis 4,.LC22@ha
	la 4,.LC22@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L541
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
.L541:
	lis 9,.LC87@ha
	lis 11,coop@ha
	la 9,.LC87@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L542
	lwz 0,56(30)
	andi. 11,0,8
	bc 12,2,.L542
	li 0,0
	stw 0,12(30)
.L542:
	li 0,0
	stw 30,648(31)
	lis 11,level+4@ha
	stw 0,416(31)
	lis 10,.LC84@ha
	lis 9,droptofloor@ha
	lfs 0,level+4@l(11)
	la 9,droptofloor@l(9)
	lfd 13,.LC84@l(10)
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
	bc 12,2,.L543
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L543:
	lwz 3,280(31)
	lis 4,.LC85@ha
	la 4,.LC85@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L545
	lwz 3,280(31)
	lis 4,.LC86@ha
	la 4,.LC86@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L494
.L545:
	lis 9,CTFFlagSetup@ha
	la 9,CTFFlagSetup@l(9)
	stw 9,436(31)
.L494:
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
	.long .LC88
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC89
	.long .LC90
	.long 1
	.long 0
	.long .LC91
	.long .LC92
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long bodyarmor_info
	.long 3
	.long .LC93
	.long .LC94
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC89
	.long .LC95
	.long 1
	.long 0
	.long .LC96
	.long .LC97
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long combatarmor_info
	.long 2
	.long .LC93
	.long .LC98
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC89
	.long .LC99
	.long 1
	.long 0
	.long .LC100
	.long .LC101
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long jacketarmor_info
	.long 1
	.long .LC93
	.long .LC102
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC103
	.long .LC104
	.long 1
	.long 0
	.long .LC100
	.long .LC105
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long 0
	.long 4
	.long .LC93
	.long .LC106
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC107
	.long .LC108
	.long 1
	.long 0
	.long .LC109
	.long .LC110
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC93
	.long .LC111
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC107
	.long .LC112
	.long 1
	.long 0
	.long .LC113
	.long .LC114
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC115
	.long .LC116
	.long 0
	.long Use_Weapon
	.long 0
	.long CTFWeapon_Grapple
	.long .LC117
	.long 0
	.long 0
	.long .LC118
	.long .LC119
	.long .LC120
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long 0
	.long .LC121
	.long .LC122
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Blaster
	.long .LC117
	.long 0
	.long 0
	.long .LC123
	.long .LC124
	.long .LC125
	.long 0
	.long 0
	.long 0
	.long 9
	.long 1
	.long 0
	.long 0
	.long .LC126
	.long .LC127
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Shotgun
	.long .LC117
	.long .LC128
	.long 1
	.long .LC129
	.long .LC130
	.long .LC73
	.long 0
	.long 1
	.long .LC7
	.long 9
	.long 2
	.long 0
	.long 0
	.long .LC131
	.long .LC132
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_SuperShotgun
	.long .LC117
	.long .LC133
	.long 1
	.long .LC134
	.long .LC135
	.long .LC74
	.long 0
	.long 2
	.long .LC7
	.long 9
	.long 3
	.long 0
	.long 0
	.long .LC136
	.long .LC137
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Machinegun
	.long .LC117
	.long .LC138
	.long 1
	.long .LC139
	.long .LC140
	.long .LC75
	.long 0
	.long 1
	.long .LC6
	.long 9
	.long 4
	.long 0
	.long 0
	.long .LC141
	.long .LC142
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Chaingun
	.long .LC117
	.long .LC143
	.long 1
	.long .LC144
	.long .LC145
	.long .LC76
	.long 0
	.long 1
	.long .LC6
	.long 9
	.long 5
	.long 0
	.long 0
	.long .LC146
	.long .LC147
	.long Pickup_Ammo
	.long Use_Weapon
	.long Drop_Ammo
	.long Weapon_Grenade
	.long .LC148
	.long .LC149
	.long 0
	.long .LC150
	.long .LC151
	.long .LC12
	.long 3
	.long 5
	.long .LC152
	.long 3
	.long 6
	.long 0
	.long 3
	.long .LC153
	.long .LC154
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_GrenadeLauncher
	.long .LC117
	.long .LC155
	.long 1
	.long .LC156
	.long .LC157
	.long .LC77
	.long 0
	.long 1
	.long .LC12
	.long 9
	.long 7
	.long 0
	.long 0
	.long .LC158
	.long .LC159
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_RocketLauncher
	.long .LC117
	.long .LC160
	.long 1
	.long .LC161
	.long .LC162
	.long .LC78
	.long 0
	.long 1
	.long .LC13
	.long 9
	.long 8
	.long 0
	.long 0
	.long .LC163
	.long .LC164
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_HyperBlaster
	.long .LC117
	.long .LC165
	.long 1
	.long .LC166
	.long .LC167
	.long .LC168
	.long 0
	.long 1
	.long .LC11
	.long 9
	.long 9
	.long 0
	.long 0
	.long .LC169
	.long .LC170
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Railgun
	.long .LC117
	.long .LC171
	.long 1
	.long .LC172
	.long .LC173
	.long .LC80
	.long 0
	.long 1
	.long .LC14
	.long 9
	.long 10
	.long 0
	.long 0
	.long .LC174
	.long .LC83
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_BFG
	.long .LC117
	.long .LC175
	.long 1
	.long .LC176
	.long .LC177
	.long .LC72
	.long 0
	.long 50
	.long .LC11
	.long 9
	.long 11
	.long 0
	.long 0
	.long .LC178
	.long .LC179
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC148
	.long .LC180
	.long 0
	.long 0
	.long .LC181
	.long .LC7
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 1
	.long .LC93
	.long .LC182
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC148
	.long .LC183
	.long 0
	.long 0
	.long .LC184
	.long .LC6
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC93
	.long .LC185
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC148
	.long .LC186
	.long 0
	.long 0
	.long .LC187
	.long .LC11
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long 4
	.long .LC93
	.long .LC188
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC148
	.long .LC189
	.long 0
	.long 0
	.long .LC190
	.long .LC13
	.long 3
	.long 5
	.long 0
	.long 2
	.long 0
	.long 0
	.long 2
	.long .LC93
	.long .LC191
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC148
	.long .LC192
	.long 0
	.long 0
	.long .LC193
	.long .LC14
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 5
	.long .LC93
	.long .LC194
	.long Pickup_Powerup
	.long Use_Quad
	.long Drop_General
	.long 0
	.long .LC195
	.long .LC196
	.long 1
	.long 0
	.long .LC197
	.long .LC81
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC198
	.long .LC199
	.long Pickup_Powerup
	.long Use_Invulnerability
	.long Drop_General
	.long 0
	.long .LC195
	.long .LC200
	.long 1
	.long 0
	.long .LC201
	.long .LC82
	.long 2
	.long 300
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC202
	.long .LC203
	.long Pickup_Powerup
	.long Use_Silencer
	.long Drop_General
	.long 0
	.long .LC195
	.long .LC204
	.long 1
	.long 0
	.long .LC205
	.long .LC206
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC93
	.long .LC207
	.long Pickup_Powerup
	.long Use_Breather
	.long Drop_General
	.long 0
	.long .LC195
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
	.long 0
	.long .LC211
	.long .LC212
	.long Pickup_Powerup
	.long Use_Envirosuit
	.long Drop_General
	.long 0
	.long .LC195
	.long .LC213
	.long 1
	.long 0
	.long .LC214
	.long .LC215
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long 0
	.long .LC211
	.long .LC216
	.long Pickup_AncientHead
	.long 0
	.long 0
	.long 0
	.long .LC195
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
	.long .LC93
	.long .LC220
	.long Pickup_Adrenaline
	.long 0
	.long 0
	.long 0
	.long .LC195
	.long .LC221
	.long 1
	.long 0
	.long .LC222
	.long .LC223
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC93
	.long .LC224
	.long Pickup_Bandolier
	.long 0
	.long 0
	.long 0
	.long .LC195
	.long .LC225
	.long 1
	.long 0
	.long .LC226
	.long .LC227
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC93
	.long .LC228
	.long Pickup_Pack
	.long 0
	.long 0
	.long 0
	.long .LC195
	.long .LC229
	.long 1
	.long 0
	.long .LC230
	.long .LC231
	.long 2
	.long 180
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC93
	.long .LC232
	.long Pickup_Key
	.long K2_UseKey
	.long K2_Drop_Key
	.long 0
	.long .LC195
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
	.long 0
	.long .LC93
	.long .LC22
	.long Pickup_Key
	.long K2_UseKey
	.long K2_Drop_Key
	.long 0
	.long .LC195
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
	.long .LC93
	.long .LC239
	.long Pickup_Key
	.long K2_UseKey
	.long K2_Drop_Key
	.long 0
	.long .LC195
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
	.long .LC93
	.long .LC243
	.long Pickup_Key
	.long K2_UseKey
	.long K2_Drop_Key
	.long 0
	.long .LC195
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
	.long .LC93
	.long .LC247
	.long Pickup_Key
	.long K2_UseKey
	.long K2_Drop_Key
	.long 0
	.long .LC195
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
	.long .LC93
	.long .LC251
	.long Pickup_Key
	.long K2_UseKey
	.long K2_Drop_Key
	.long 0
	.long .LC195
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
	.long .LC93
	.long .LC255
	.long Pickup_Key
	.long K2_UseKey
	.long K2_Drop_Key
	.long 0
	.long .LC195
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
	.long .LC93
	.long .LC259
	.long Pickup_Key
	.long K2_UseKey
	.long K2_Drop_Key
	.long 0
	.long .LC195
	.long .LC260
	.long 2
	.long 0
	.long .LC261
	.long .LC262
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC93
	.long .LC263
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC195
	.long .LC264
	.long 1
	.long 0
	.long .LC265
	.long .LC266
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC93
	.long 0
	.long Pickup_Health
	.long 0
	.long 0
	.long 0
	.long .LC195
	.long 0
	.long 0
	.long 0
	.long .LC267
	.long .LC268
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC93
	.long .LC85
	.long CTFPickup_Flag
	.long 0
	.long CTFDrop_Flag
	.long 0
	.long .LC269
	.long .LC270
	.long 262144
	.long 0
	.long .LC271
	.long .LC272
	.long 2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC273
	.long .LC86
	.long CTFPickup_Flag
	.long 0
	.long CTFDrop_Flag
	.long 0
	.long .LC269
	.long .LC274
	.long 524288
	.long 0
	.long .LC275
	.long .LC276
	.long 2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC273
	.long .LC277
	.long CTFPickup_Tech
	.long 0
	.long CTFDrop_Tech
	.long 0
	.long .LC195
	.long .LC278
	.long 1
	.long 0
	.long .LC279
	.long .LC280
	.long 2
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC281
	.long .LC282
	.long CTFPickup_Tech
	.long 0
	.long CTFDrop_Tech
	.long 0
	.long .LC195
	.long .LC283
	.long 1
	.long 0
	.long .LC284
	.long .LC285
	.long 2
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC286
	.long .LC287
	.long CTFPickup_Tech
	.long 0
	.long CTFDrop_Tech
	.long 0
	.long .LC195
	.long .LC288
	.long 1
	.long 0
	.long .LC289
	.long .LC290
	.long 2
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC291
	.long .LC292
	.long CTFPickup_Tech
	.long 0
	.long CTFDrop_Tech
	.long 0
	.long .LC195
	.long .LC293
	.long 1
	.long 0
	.long .LC294
	.long .LC295
	.long 2
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC296
	.long 0
	.space	72
	.section	".rodata"
	.align 2
.LC296:
	.string	"ctf/tech4.wav"
	.align 2
.LC295:
	.string	"AutoDoc"
	.align 2
.LC294:
	.string	"tech4"
	.align 2
.LC293:
	.string	"models/ctf/regeneration/tris.md2"
	.align 2
.LC292:
	.string	"item_tech4"
	.align 2
.LC291:
	.string	"ctf/tech3.wav"
	.align 2
.LC290:
	.string	"Time Accel"
	.align 2
.LC289:
	.string	"tech3"
	.align 2
.LC288:
	.string	"models/ctf/haste/tris.md2"
	.align 2
.LC287:
	.string	"item_tech3"
	.align 2
.LC286:
	.string	"ctf/tech2.wav ctf/tech2x.wav"
	.align 2
.LC285:
	.string	"Power Amplifier"
	.align 2
.LC284:
	.string	"tech2"
	.align 2
.LC283:
	.string	"models/ctf/strength/tris.md2"
	.align 2
.LC282:
	.string	"item_tech2"
	.align 2
.LC281:
	.string	"ctf/tech1.wav"
	.align 2
.LC280:
	.string	"Disruptor Shield"
	.align 2
.LC279:
	.string	"tech1"
	.align 2
.LC278:
	.string	"models/ctf/resistance/tris.md2"
	.align 2
.LC277:
	.string	"item_tech1"
	.align 2
.LC276:
	.string	"Blue Flag"
	.align 2
.LC275:
	.string	"i_ctf2"
	.align 2
.LC274:
	.string	"players/male/flag2.md2"
	.align 2
.LC273:
	.string	"ctf/flagcap.wav"
	.align 2
.LC272:
	.string	"Red Flag"
	.align 2
.LC271:
	.string	"i_ctf1"
	.align 2
.LC270:
	.string	"players/male/flag1.md2"
	.align 2
.LC269:
	.string	"ctf/flagtk.wav"
	.align 2
.LC268:
	.string	"Health"
	.align 2
.LC267:
	.string	"i_health"
	.align 2
.LC266:
	.string	"Airstrike Marker"
	.align 2
.LC265:
	.string	"i_airstrike"
	.align 2
.LC264:
	.string	"models/items/keys/target/tris.md2"
	.align 2
.LC263:
	.string	"key_airstrike_target"
	.align 2
.LC262:
	.string	"Homing Key"
	.align 2
.LC261:
	.string	"k_comhead"
	.align 2
.LC260:
	.string	"models/monsters/commandr/head/tris.md2"
	.align 2
.LC259:
	.string	"key_commander_head"
	.align 2
.LC258:
	.string	"Haste Key"
	.align 2
.LC257:
	.string	"k_redkey"
	.align 2
.LC256:
	.string	"models/items/keys/red_key/tris.md2"
	.align 2
.LC255:
	.string	"key_red_key"
	.align 2
.LC254:
	.string	"Regeneration Key"
	.align 2
.LC253:
	.string	"k_bluekey"
	.align 2
.LC252:
	.string	"models/items/keys/key/tris.md2"
	.align 2
.LC251:
	.string	"key_blue_key"
	.align 2
.LC250:
	.string	"Futility Key"
	.align 2
.LC249:
	.string	"k_security"
	.align 2
.LC248:
	.string	"models/items/keys/pass/tris.md2"
	.align 2
.LC247:
	.string	"key_pass"
	.align 2
.LC246:
	.string	"Anti-Key"
	.align 2
.LC245:
	.string	"k_dataspin"
	.align 2
.LC244:
	.string	"models/items/keys/spinner/tris.md2"
	.align 2
.LC243:
	.string	"key_data_spinner"
	.align 2
.LC242:
	.string	"BFK"
	.align 2
.LC241:
	.string	"k_pyramid"
	.align 2
.LC240:
	.string	"models/items/keys/pyramid/tris.md2"
	.align 2
.LC239:
	.string	"key_pyramid"
	.align 2
.LC238:
	.string	"Stealth Key"
	.align 2
.LC237:
	.string	"k_powercube"
	.align 2
.LC236:
	.string	"models/items/keys/power/tris.md2"
	.align 2
.LC235:
	.string	"Infliction Key"
	.align 2
.LC234:
	.string	"k_datacd"
	.align 2
.LC233:
	.string	"models/items/keys/data_cd/tris.md2"
	.align 2
.LC232:
	.string	"key_data_cd"
	.align 2
.LC231:
	.string	"Ammo Pack"
	.align 2
.LC230:
	.string	"i_pack"
	.align 2
.LC229:
	.string	"models/items/pack/tris.md2"
	.align 2
.LC228:
	.string	"item_pack"
	.align 2
.LC227:
	.string	"Bandolier"
	.align 2
.LC226:
	.string	"p_bandolier"
	.align 2
.LC225:
	.string	"models/items/band/tris.md2"
	.align 2
.LC224:
	.string	"item_bandolier"
	.align 2
.LC223:
	.string	"Adrenaline"
	.align 2
.LC222:
	.string	"p_adrenaline"
	.align 2
.LC221:
	.string	"models/items/adrenal/tris.md2"
	.align 2
.LC220:
	.string	"item_adrenaline"
	.align 2
.LC219:
	.string	"Ancient Head"
	.align 2
.LC218:
	.string	"i_fixme"
	.align 2
.LC217:
	.string	"models/items/c_head/tris.md2"
	.align 2
.LC216:
	.string	"item_ancient_head"
	.align 2
.LC215:
	.string	"Environment Suit"
	.align 2
.LC214:
	.string	"p_envirosuit"
	.align 2
.LC213:
	.string	"models/items/enviro/tris.md2"
	.align 2
.LC212:
	.string	"item_enviro"
	.align 2
.LC211:
	.string	"items/airout.wav"
	.align 2
.LC210:
	.string	"Rebreather"
	.align 2
.LC209:
	.string	"p_rebreather"
	.align 2
.LC208:
	.string	"models/items/breather/tris.md2"
	.align 2
.LC207:
	.string	"item_breather"
	.align 2
.LC206:
	.string	"Silencer"
	.align 2
.LC205:
	.string	"p_silencer"
	.align 2
.LC204:
	.string	"models/items/silencer/tris.md2"
	.align 2
.LC203:
	.string	"item_silencer"
	.align 2
.LC202:
	.string	"items/protect.wav items/protect2.wav items/protect4.wav"
	.align 2
.LC201:
	.string	"p_invulnerability"
	.align 2
.LC200:
	.string	"models/items/invulner/tris.md2"
	.align 2
.LC199:
	.string	"item_invulnerability"
	.align 2
.LC198:
	.string	"items/damage.wav items/damage2.wav items/damage3.wav"
	.align 2
.LC197:
	.string	"p_quad"
	.align 2
.LC196:
	.string	"models/items/quaddama/tris.md2"
	.align 2
.LC195:
	.string	"items/pkup.wav"
	.align 2
.LC194:
	.string	"item_quad"
	.align 2
.LC193:
	.string	"a_slugs"
	.align 2
.LC192:
	.string	"models/items/ammo/slugs/medium/tris.md2"
	.align 2
.LC191:
	.string	"ammo_slugs"
	.align 2
.LC190:
	.string	"a_rockets"
	.align 2
.LC189:
	.string	"models/items/ammo/rockets/medium/tris.md2"
	.align 2
.LC188:
	.string	"ammo_rockets"
	.align 2
.LC187:
	.string	"a_cells"
	.align 2
.LC186:
	.string	"models/items/ammo/cells/medium/tris.md2"
	.align 2
.LC185:
	.string	"ammo_cells"
	.align 2
.LC184:
	.string	"a_bullets"
	.align 2
.LC183:
	.string	"models/items/ammo/bullets/medium/tris.md2"
	.align 2
.LC182:
	.string	"ammo_bullets"
	.align 2
.LC181:
	.string	"a_shells"
	.align 2
.LC180:
	.string	"models/items/ammo/shells/medium/tris.md2"
	.align 2
.LC179:
	.string	"ammo_shells"
	.align 2
.LC178:
	.string	"sprites/s_bfg1.sp2 sprites/s_bfg2.sp2 sprites/s_bfg3.sp2 weapons/bfg__f1y.wav weapons/bfg__l1a.wav weapons/bfg__x1b.wav weapons/bfg_hum.wav"
	.align 2
.LC177:
	.string	"w_bfg"
	.align 2
.LC176:
	.string	"models/weapons/v_bfg/tris.md2"
	.align 2
.LC175:
	.string	"models/weapons/g_bfg/tris.md2"
	.align 2
.LC174:
	.string	"weapons/rg_hum.wav"
	.align 2
.LC173:
	.string	"w_railgun"
	.align 2
.LC172:
	.string	"models/weapons/v_rail/tris.md2"
	.align 2
.LC171:
	.string	"models/weapons/g_rail/tris.md2"
	.align 2
.LC170:
	.string	"weapon_railgun"
	.align 2
.LC169:
	.string	"weapons/hyprbu1a.wav weapons/hyprbl1a.wav weapons/hyprbf1a.wav weapons/hyprbd1a.wav misc/lasfly.wav"
	.align 2
.LC168:
	.string	"HyperBlaster"
	.align 2
.LC167:
	.string	"w_hyperblaster"
	.align 2
.LC166:
	.string	"models/weapons/v_hyperb/tris.md2"
	.align 2
.LC165:
	.string	"models/weapons/g_hyperb/tris.md2"
	.align 2
.LC164:
	.string	"weapon_hyperblaster"
	.align 2
.LC163:
	.string	"models/objects/rocket/tris.md2 weapons/rockfly.wav weapons/rocklf1a.wav weapons/rocklr1b.wav models/objects/debris2/tris.md2"
	.align 2
.LC162:
	.string	"w_rlauncher"
	.align 2
.LC161:
	.string	"models/weapons/v_rocket/tris.md2"
	.align 2
.LC160:
	.string	"models/weapons/g_rocket/tris.md2"
	.align 2
.LC159:
	.string	"weapon_rocketlauncher"
	.align 2
.LC158:
	.string	"models/objects/grenade/tris.md2 weapons/grenlf1a.wav weapons/grenlr1b.wav weapons/grenlb1b.wav"
	.align 2
.LC157:
	.string	"w_glauncher"
	.align 2
.LC156:
	.string	"models/weapons/v_launch/tris.md2"
	.align 2
.LC155:
	.string	"models/weapons/g_launch/tris.md2"
	.align 2
.LC154:
	.string	"weapon_grenadelauncher"
	.align 2
.LC153:
	.string	"weapons/hgrent1a.wav weapons/hgrena1b.wav weapons/hgrenc1b.wav weapons/hgrenb1a.wav weapons/hgrenb2a.wav "
	.align 2
.LC152:
	.string	"grenades"
	.align 2
.LC151:
	.string	"a_grenades"
	.align 2
.LC150:
	.string	"models/weapons/v_handgr/tris.md2"
	.align 2
.LC149:
	.string	"models/items/ammo/grenades/medium/tris.md2"
	.align 2
.LC148:
	.string	"misc/am_pkup.wav"
	.align 2
.LC147:
	.string	"ammo_grenades"
	.align 2
.LC146:
	.string	"weapons/chngnu1a.wav weapons/chngnl1a.wav weapons/machgf3b.wav` weapons/chngnd1a.wav"
	.align 2
.LC145:
	.string	"w_chaingun"
	.align 2
.LC144:
	.string	"models/weapons/v_chain/tris.md2"
	.align 2
.LC143:
	.string	"models/weapons/g_chain/tris.md2"
	.align 2
.LC142:
	.string	"weapon_chaingun"
	.align 2
.LC141:
	.string	"weapons/machgf1b.wav weapons/machgf2b.wav weapons/machgf3b.wav weapons/machgf4b.wav weapons/machgf5b.wav"
	.align 2
.LC140:
	.string	"w_machinegun"
	.align 2
.LC139:
	.string	"models/weapons/v_machn/tris.md2"
	.align 2
.LC138:
	.string	"models/weapons/g_machn/tris.md2"
	.align 2
.LC137:
	.string	"weapon_machinegun"
	.align 2
.LC136:
	.string	"weapons/sshotf1b.wav"
	.align 2
.LC135:
	.string	"w_sshotgun"
	.align 2
.LC134:
	.string	"models/weapons/v_shotg2/tris.md2"
	.align 2
.LC133:
	.string	"models/weapons/g_shotg2/tris.md2"
	.align 2
.LC132:
	.string	"weapon_supershotgun"
	.align 2
.LC131:
	.string	"weapons/shotgf1b.wav weapons/shotgr1b.wav"
	.align 2
.LC130:
	.string	"w_shotgun"
	.align 2
.LC129:
	.string	"models/weapons/v_shotg/tris.md2"
	.align 2
.LC128:
	.string	"models/weapons/g_shotg/tris.md2"
	.align 2
.LC127:
	.string	"weapon_shotgun"
	.align 2
.LC126:
	.string	"weapons/blastf1a.wav misc/lasfly.wav"
	.align 2
.LC125:
	.string	"Blaster"
	.align 2
.LC124:
	.string	"w_blaster"
	.align 2
.LC123:
	.string	"models/weapons/v_blast/tris.md2"
	.align 2
.LC122:
	.string	"weapon_blaster"
	.align 2
.LC121:
	.string	"weapons/grapple/grfire.wav weapons/grapple/grpull.wav weapons/grapple/grhang.wav weapons/grapple/grreset.wav weapons/grapple/grhit.wav"
	.align 2
.LC120:
	.string	"Grapple"
	.align 2
.LC119:
	.string	"w_grapple"
	.align 2
.LC118:
	.string	"models/weapons/grapple/tris.md2"
	.align 2
.LC117:
	.string	"misc/w_pkup.wav"
	.align 2
.LC116:
	.string	"weapon_grapple"
	.align 2
.LC115:
	.string	"misc/power2.wav misc/power1.wav"
	.align 2
.LC114:
	.string	"Power Shield"
	.align 2
.LC113:
	.string	"i_powershield"
	.align 2
.LC112:
	.string	"models/items/armor/shield/tris.md2"
	.align 2
.LC111:
	.string	"item_power_shield"
	.align 2
.LC110:
	.string	"Power Screen"
	.align 2
.LC109:
	.string	"i_powerscreen"
	.align 2
.LC108:
	.string	"models/items/armor/screen/tris.md2"
	.align 2
.LC107:
	.string	"misc/ar3_pkup.wav"
	.align 2
.LC106:
	.string	"item_power_screen"
	.align 2
.LC105:
	.string	"Armor Shard"
	.align 2
.LC104:
	.string	"models/items/armor/shard/tris.md2"
	.align 2
.LC103:
	.string	"misc/ar2_pkup.wav"
	.align 2
.LC102:
	.string	"item_armor_shard"
	.align 2
.LC101:
	.string	"Jacket Armor"
	.align 2
.LC100:
	.string	"i_jacketarmor"
	.align 2
.LC99:
	.string	"models/items/armor/jacket/tris.md2"
	.align 2
.LC98:
	.string	"item_armor_jacket"
	.align 2
.LC97:
	.string	"Combat Armor"
	.align 2
.LC96:
	.string	"i_combatarmor"
	.align 2
.LC95:
	.string	"models/items/armor/combat/tris.md2"
	.align 2
.LC94:
	.string	"item_armor_combat"
	.align 2
.LC93:
	.string	""
	.align 2
.LC92:
	.string	"Body Armor"
	.align 2
.LC91:
	.string	"i_bodyarmor"
	.align 2
.LC90:
	.string	"models/items/armor/body/tris.md2"
	.align 2
.LC89:
	.string	"misc/ar1_pkup.wav"
	.align 2
.LC88:
	.string	"item_armor_body"
	.size	 itemlist,3800
	.align 2
.LC297:
	.string	"models/items/healing/medium/tris.md2"
	.align 2
.LC298:
	.string	"models/items/healing/stimpack/tris.md2"
	.align 2
.LC299:
	.string	"models/items/healing/large/tris.md2"
	.align 2
.LC300:
	.string	"models/items/mega_h/tris.md2"
	.align 2
.LC301:
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
	lis 11,.LC301@ha
	lis 9,deathmatch@ha
	la 11,.LC301@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L578
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L578
	bl G_FreeEdict
	b .L577
.L578:
	lis 9,.LC301@ha
	lis 11,nomegahealth@ha
	la 9,.LC301@l(9)
	lfs 13,0(9)
	lwz 9,nomegahealth@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L579
	mr 3,29
	bl G_FreeEdict
	b .L577
.L588:
	mr 4,31
	b .L586
.L579:
	lis 9,.LC300@ha
	li 0,100
	la 9,.LC300@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC268@ha
	lis 11,itemlist@ha
	la 27,.LC268@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L587
	mr 28,10
.L582:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L584
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L588
.L584:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L582
.L587:
	li 4,0
.L586:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC52@ha
	lwz 0,gi+36@l(9)
	la 3,.LC52@l(3)
	mtlr 0
	blrl
	li 0,3
	stw 0,644(29)
.L577:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 SP_item_health_mega,.Lfe18-SP_item_health_mega
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
	bc 4,0,.L592
	lis 11,itemlist@ha
	lis 9,gi@ha
	la 11,itemlist@l(11)
	la 28,gi@l(9)
	mr 29,10
	addi 30,11,40
.L594:
	lwz 9,24(28)
	addi 3,31,1056
	lwz 4,0(30)
	addi 31,31,1
	mtlr 9
	addi 30,30,76
	blrl
	lwz 0,1556(29)
	cmpw 0,31,0
	bc 12,0,.L594
.L592:
	lis 9,game@ha
	lis 11,jacket_armor_index@ha
	la 10,game@l(9)
	li 30,0
	lwz 0,1556(10)
	la 27,jacket_armor_index@l(11)
	lis 9,.LC101@ha
	lis 11,itemlist@ha
	la 28,.LC101@l(9)
	cmpw 0,30,0
	la 31,itemlist@l(11)
	bc 4,0,.L603
	mr 29,10
.L598:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L600
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L600
	mr 11,31
	b .L602
.L600:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L598
.L603:
	li 11,0
.L602:
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
	lis 10,.LC97@ha
	la 26,combat_armor_index@l(9)
	srawi 11,11,2
	la 28,.LC97@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L611
	mr 29,7
.L606:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L608
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L608
	mr 11,31
	b .L610
.L608:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L606
.L611:
	li 11,0
.L610:
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
	lis 10,.LC92@ha
	la 27,body_armor_index@l(9)
	srawi 11,11,2
	la 28,.LC92@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L619
	mr 29,7
.L614:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L616
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L616
	mr 11,31
	b .L618
.L616:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L614
.L619:
	li 11,0
.L618:
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
	lis 10,.LC110@ha
	la 26,power_screen_index@l(9)
	srawi 11,11,2
	la 28,.LC110@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L627
	mr 29,7
.L622:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L624
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L624
	mr 11,31
	b .L626
.L624:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L622
.L627:
	li 11,0
.L626:
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
	lis 10,.LC114@ha
	la 27,power_shield_index@l(9)
	srawi 11,11,2
	la 28,.LC114@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L635
	mr 29,7
.L630:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L632
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L632
	mr 8,31
	b .L634
.L632:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L630
.L635:
	li 8,0
.L634:
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
	.comm	jacket_armor_index,4,4
	.comm	combat_armor_index,4,4
	.comm	body_armor_index,4,4
	.align 2
	.globl InitItems
	.type	 InitItems,@function
InitItems:
	lis 9,game+1556@ha
	li 0,49
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
	bc 4,0,.L49
	mr 28,9
.L51:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L50
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L50
	mr 3,31
	b .L636
.L50:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L51
.L49:
	li 3,0
.L636:
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
	bc 4,0,.L41
	mr 28,9
.L43:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L42
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L42
	mr 3,31
	b .L637
.L42:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L43
.L41:
	li 3,0
.L637:
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
	bc 4,2,.L330
	li 3,0
	blr
.L330:
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
	bc 4,2,.L364
.L640:
	li 3,0
	blr
.L364:
	lwz 0,264(3)
	andi. 9,0,4096
	bc 12,2,.L640
	lis 9,power_shield_index@ha
	addi 11,11,740
	lwz 0,power_shield_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L367
	lis 9,power_screen_index@ha
	lwz 0,power_screen_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	srawi 3,9,31
	subf 3,9,3
	srwi 3,3,31
	blr
.L367:
	li 3,2
	blr
.Lfe25:
	.size	 PowerArmorType,.Lfe25-PowerArmorType
	.align 2
	.globl GetItemByIndex
	.type	 GetItemByIndex,@function
GetItemByIndex:
	mr. 3,3
	bc 12,2,.L38
	lis 9,game+1556@ha
	lwz 0,game+1556@l(9)
	cmpw 0,3,0
	bc 12,0,.L37
.L38:
	li 3,0
	blr
.L37:
	mulli 0,3,76
	lis 3,itemlist@ha
	la 3,itemlist@l(3)
	add 3,0,3
	blr
.Lfe26:
	.size	 GetItemByIndex,.Lfe26-GetItemByIndex
	.align 2
	.globl Add_Ammo
	.type	 Add_Ammo,@function
Add_Ammo:
	lwz 10,84(3)
	cmpwi 0,10,0
	bc 4,2,.L243
.L643:
	li 3,0
	blr
.L243:
	lwz 0,68(4)
	cmpwi 0,0,0
	bc 4,2,.L245
	lwz 11,1764(10)
	b .L246
.L245:
	cmpwi 0,0,1
	bc 4,2,.L247
	lwz 11,1768(10)
	b .L246
.L247:
	cmpwi 0,0,2
	bc 4,2,.L249
	lwz 11,1772(10)
	b .L246
.L249:
	cmpwi 0,0,3
	bc 4,2,.L251
	lwz 11,1776(10)
	b .L246
.L251:
	cmpwi 0,0,4
	bc 4,2,.L253
	lwz 11,1780(10)
	b .L246
.L253:
	cmpwi 0,0,5
	bc 4,2,.L643
	lwz 11,1784(10)
.L246:
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
	bc 12,2,.L643
	add 0,0,5
	cmpw 0,0,11
	stwx 0,10,4
	bc 4,1,.L258
	stwx 11,10,4
.L258:
	li 3,1
	blr
.Lfe27:
	.size	 Add_Ammo,.Lfe27-Add_Ammo
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.comm	last_trail_time,4,4
	.comm	bot_frametime,8,8
	.comm	max_bots,4,4
	.comm	last_bot_spawn,4,4
	.comm	bot_male_names_used,4,4
	.comm	bot_female_names_used,4,4
	.comm	bot_count,4,4
	.comm	bot_teams,256,4
	.comm	total_teams,4,4
	.comm	the_client,4,4
	.comm	num_players,4,4
	.comm	players,1024,4
	.comm	weapons_head,4,4
	.comm	health_head,4,4
	.comm	bonus_head,4,4
	.comm	ammo_head,4,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_supershotgun,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	botinfo_list,4,4
	.comm	total_bots,4,4
	.comm	teambot_list,4,4
	.comm	paused,4,4
	.align 2
	.globl AddToItemList
	.type	 AddToItemList,@function
AddToItemList:
	cmpwi 0,4,0
	mr 11,3
	mr 9,4
	bc 12,2,.L12
.L9:
	cmpw 0,9,11
	bc 4,2,.L10
	mr 3,4
	blr
.L10:
	lwz 9,936(9)
	cmpwi 0,9,0
	bc 4,2,.L9
	cmpwi 0,4,0
	bc 12,2,.L12
	stw 11,892(4)
.L12:
	li 0,0
	stw 4,936(11)
	mr 3,11
	stw 0,892(11)
	blr
.Lfe28:
	.size	 AddToItemList,.Lfe28-AddToItemList
	.comm	power_screen_index,4,4
	.comm	power_shield_index,4,4
	.comm	spawn_bots,4,4
	.comm	roam_calls_this_frame,4,4
	.comm	bestdirection_callsthisframe,4,4
	.comm	bot_chat_text,2048,4
	.comm	bot_chat_count,32,4
	.comm	last_bot_chat,32,4
	.comm	num_view_weapons,4,4
	.comm	view_weapon_models,4096,1
	.comm	botdebug,4,4
	.comm	PathToEnt_Node,4,4
	.comm	PathToEnt_TargetNode,4,4
	.comm	trail_head,4,4
	.comm	last_head,4,4
	.comm	dropped_trail,4,4
	.comm	last_optimize,4,4
	.comm	optimize_marker,4,4
	.comm	trail_portals,490000,4
	.comm	num_trail_portals,2500,4
	.comm	ctf_item_head,4,4
	.section	".sbss","aw",@nobits
	.align 2
quad_drop_timeout_hack:
	.space	4
	.size	 quad_drop_timeout_hack,4
	.section	".text"
	.align 2
	.globl RemoveFromItemList
	.type	 RemoveFromItemList,@function
RemoveFromItemList:
	lwz 9,936(3)
	cmpwi 0,9,0
	bc 12,2,.L14
	lwz 0,892(3)
	stw 0,892(9)
.L14:
	lwz 9,892(3)
	cmpwi 0,9,0
	bc 12,2,.L15
	lwz 0,936(3)
	stw 0,936(9)
	b .L16
.L15:
	lwz 10,936(3)
	cmpwi 0,10,0
	bc 12,2,.L16
	lwz 11,648(3)
	lis 9,Pickup_Weapon@ha
	la 9,Pickup_Weapon@l(9)
	lwz 0,4(11)
	cmpw 0,0,9
	bc 4,2,.L18
	lis 9,weapons_head@ha
	stw 10,weapons_head@l(9)
	b .L16
.L18:
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 4,2,.L20
	lis 9,health_head@ha
	stw 10,health_head@l(9)
	b .L16
.L20:
	lis 9,Pickup_Ammo@ha
	la 9,Pickup_Ammo@l(9)
	cmpw 0,0,9
	bc 4,2,.L22
	lis 9,ammo_head@ha
	stw 10,ammo_head@l(9)
	b .L16
.L22:
	lis 9,bonus_head@ha
	stw 10,bonus_head@l(9)
.L16:
	li 0,0
	stw 0,892(3)
	stw 0,936(3)
	blr
.Lfe29:
	.size	 RemoveFromItemList,.Lfe29-RemoveFromItemList
	.align 2
	.globl RemoveDroppedItem
	.type	 RemoveDroppedItem,@function
RemoveDroppedItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	lwz 9,936(10)
	cmpwi 0,9,0
	bc 12,2,.L25
	lwz 0,892(10)
	stw 0,892(9)
.L25:
	lwz 9,892(10)
	cmpwi 0,9,0
	bc 12,2,.L26
	lwz 0,936(10)
	stw 0,936(9)
	b .L27
.L26:
	lwz 8,936(10)
	cmpwi 0,8,0
	bc 12,2,.L27
	lwz 11,648(10)
	lis 9,Pickup_Weapon@ha
	la 9,Pickup_Weapon@l(9)
	lwz 0,4(11)
	cmpw 0,0,9
	bc 4,2,.L29
	lis 9,weapons_head@ha
	stw 8,weapons_head@l(9)
	b .L27
.L29:
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 4,2,.L31
	lis 9,health_head@ha
	stw 8,health_head@l(9)
	b .L27
.L31:
	lis 9,Pickup_Ammo@ha
	la 9,Pickup_Ammo@l(9)
	cmpw 0,0,9
	bc 4,2,.L33
	lis 9,ammo_head@ha
	stw 8,ammo_head@l(9)
	b .L27
.L33:
	lis 9,bonus_head@ha
	stw 8,bonus_head@l(9)
.L27:
	li 0,0
	mr 3,10
	stw 0,892(10)
	stw 0,936(10)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 RemoveDroppedItem,.Lfe30-RemoveDroppedItem
	.section	".rodata"
	.align 2
.LC302:
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
	bc 12,2,.L56
	lis 9,.LC302@ha
	lis 11,ctf@ha
	lwz 30,564(31)
	la 9,.LC302@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L57
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,4
	bc 12,2,.L57
	lwz 9,648(30)
	cmpwi 0,9,0
	bc 12,2,.L57
	lwz 0,56(9)
	andi. 9,0,1
	bc 12,2,.L57
	mr 31,30
	b .L56
.L57:
	mr. 31,30
	li 29,0
	bc 12,2,.L60
.L61:
	lwz 31,536(31)
	addi 29,29,1
	cmpwi 0,31,0
	bc 4,2,.L61
.L60:
	bl rand
	mr 31,30
	divw 0,3,29
	mullw 0,0,29
	subf. 3,0,3
	bc 4,1,.L56
	mr 29,3
.L66:
	addic. 29,29,-1
	lwz 31,536(31)
	bc 4,2,.L66
.L56:
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
.Lfe31:
	.size	 DoRespawn,.Lfe31-DoRespawn
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
.Lfe32:
	.size	 Drop_General,.Lfe32-Drop_General
	.section	".rodata"
	.align 2
.LC303:
	.long 0x0
	.align 3
.LC304:
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
	lis 9,.LC303@ha
	lis 11,deathmatch@ha
	la 9,.LC303@l(9)
	mr 12,3
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L84
	lwz 9,484(4)
	addi 9,9,1
	stw 9,484(4)
.L84:
	lwz 0,480(4)
	lwz 9,484(4)
	cmpw 0,0,9
	bc 4,0,.L85
	stw 9,480(4)
.L85:
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L86
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L86
	lis 9,.LC304@ha
	lwz 11,648(12)
	la 9,.LC304@l(9)
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
.L86:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe33:
	.size	 Pickup_Adrenaline,.Lfe33-Pickup_Adrenaline
	.section	".rodata"
	.align 2
.LC305:
	.long 0x0
	.align 3
.LC306:
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
	bc 4,2,.L89
	lis 9,.LC305@ha
	lis 11,deathmatch@ha
	la 9,.LC305@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L89
	lis 9,.LC306@ha
	lwz 11,648(12)
	la 9,.LC306@l(9)
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
.L89:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 Pickup_AncientHead,.Lfe34-Pickup_AncientHead
	.section	".rodata"
	.align 3
.LC307:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC308:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl Use_Breather
	.type	 Use_Breather,@function
Use_Breather:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lwz 31,84(3)
	cmpwi 0,31,0
	bc 12,2,.L216
	lis 11,itemlist@ha
	lis 0,0x286b
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 11,11,4
	addi 10,31,740
	mullw 11,11,0
	rlwinm 11,11,0,0,29
	lwzx 9,10,11
	addi 9,9,-1
	stwx 9,10,11
	bl ValidateSelectedItem
	lis 9,.LC307@ha
	lis 11,level@ha
	lfs 13,3780(31)
	la 9,.LC307@l(9)
	lwz 11,level@l(11)
	lis 10,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L219
	lis 9,.LC308@ha
	la 9,.LC308@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L645
.L219:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
.L645:
	stfs 0,3780(31)
.L216:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 Use_Breather,.Lfe35-Use_Breather
	.section	".rodata"
	.align 3
.LC309:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC310:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl Use_Envirosuit
	.type	 Use_Envirosuit,@function
Use_Envirosuit:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lwz 31,84(3)
	cmpwi 0,31,0
	bc 12,2,.L221
	lis 11,itemlist@ha
	lis 0,0x286b
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 11,11,4
	addi 10,31,740
	mullw 11,11,0
	rlwinm 11,11,0,0,29
	lwzx 9,10,11
	addi 9,9,-1
	stwx 9,10,11
	bl ValidateSelectedItem
	lis 9,.LC309@ha
	lis 11,level@ha
	lfs 13,3784(31)
	la 9,.LC309@l(9)
	lwz 11,level@l(11)
	lis 10,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L224
	lis 9,.LC310@ha
	la 9,.LC310@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L646
.L224:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
.L646:
	stfs 0,3784(31)
.L221:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 Use_Envirosuit,.Lfe36-Use_Envirosuit
	.section	".rodata"
	.align 3
.LC311:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC312:
	.long 0x43960000
	.align 2
.LC313:
	.long 0x3f800000
	.align 2
.LC314:
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
	mr 31,3
	lwz 29,84(31)
	cmpwi 0,29,0
	bc 12,2,.L226
	lis 11,itemlist@ha
	lis 0,0x286b
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 11,11,4
	addi 10,29,740
	mullw 11,11,0
	rlwinm 11,11,0,0,29
	lwzx 9,10,11
	addi 9,9,-1
	stwx 9,10,11
	bl ValidateSelectedItem
	lis 9,.LC311@ha
	lis 11,level@ha
	lfs 13,3776(29)
	la 9,.LC311@l(9)
	lwz 11,level@l(11)
	lis 10,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	stw 0,28(1)
	stw 10,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L229
	lis 9,.LC312@ha
	la 9,.LC312@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L647
.L229:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 10,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L647:
	stfs 0,3776(29)
	lis 29,gi@ha
	lis 3,.LC21@ha
	la 29,gi@l(29)
	la 3,.LC21@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC313@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC313@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC313@ha
	la 9,.LC313@l(9)
	lfs 2,0(9)
	lis 9,.LC314@ha
	la 9,.LC314@l(9)
	lfs 3,0(9)
	blrl
.L226:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe37:
	.size	 Use_Invulnerability,.Lfe37-Use_Invulnerability
	.align 2
	.globl Use_Silencer
	.type	 Use_Silencer,@function
Use_Silencer:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lwz 31,84(3)
	cmpwi 0,31,0
	bc 12,2,.L231
	lis 11,itemlist@ha
	lis 0,0x286b
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 11,11,4
	addi 10,31,740
	mullw 11,11,0
	rlwinm 11,11,0,0,29
	lwzx 9,10,11
	addi 9,9,-1
	stwx 9,10,11
	bl ValidateSelectedItem
	lwz 9,3796(31)
	addi 9,9,30
	stw 9,3796(31)
.L231:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe38:
	.size	 Use_Silencer,.Lfe38-Use_Silencer
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
	bc 12,0,.L300
	stw 11,532(29)
	b .L301
.L300:
	stw 0,532(29)
.L301:
	lwz 9,84(31)
	slwi 11,28,2
	lwz 8,532(29)
	mr 10,9
	lwz 9,1788(9)
	cmpwi 0,9,0
	bc 12,2,.L302
	lwz 0,68(9)
	cmpwi 0,0,3
	bc 4,2,.L302
	lwz 0,68(30)
	cmpwi 0,0,3
	bc 4,2,.L302
	addi 9,10,740
	lwzx 0,9,11
	subf. 9,8,0
	bc 12,1,.L302
	lis 9,gi+8@ha
	lis 5,.LC28@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC28@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,29
	bl G_FreeEdict
	b .L299
.L302:
	addi 9,10,740
	mr 3,31
	lwzx 0,9,11
	subf 0,8,0
	stwx 0,9,11
	bl ValidateSelectedItem
.L299:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe39:
	.size	 Drop_Ammo,.Lfe39-Drop_Ammo
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
	bc 12,2,.L388
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
	bc 4,2,.L388
	bl Use_PowerArmor
.L388:
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
.Lfe40:
	.size	 Drop_PowerArmor,.Lfe40-Drop_PowerArmor
	.align 2
	.type	 drop_temp_touch,@function
drop_temp_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,256(3)
	cmpw 0,4,0
	bc 12,2,.L431
	bl Touch_Item
.L431:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe41:
	.size	 drop_temp_touch,.Lfe41-drop_temp_touch
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
	bc 12,2,.L444
	li 0,2
	stw 11,444(3)
	stw 0,248(3)
	b .L445
.L444:
	lis 9,Touch_Item@ha
	li 0,1
	la 9,Touch_Item@l(9)
	stw 0,248(3)
	stw 9,444(3)
.L445:
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
	.section	".rodata"
	.align 2
.LC315:
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
	lis 11,.LC315@ha
	lis 9,deathmatch@ha
	la 11,.LC315@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L548
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L548
	bl G_FreeEdict
	b .L547
.L648:
	mr 4,31
	b .L555
.L548:
	lis 9,.LC297@ha
	li 0,10
	la 9,.LC297@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC268@ha
	lis 11,itemlist@ha
	la 27,.LC268@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L556
	mr 28,10
.L551:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L553
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L648
.L553:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L551
.L556:
	li 4,0
.L555:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC50@ha
	lwz 0,gi+36@l(9)
	la 3,.LC50@l(3)
	mtlr 0
	blrl
.L547:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe43:
	.size	 SP_item_health,.Lfe43-SP_item_health
	.section	".rodata"
	.align 2
.LC316:
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
	lis 11,.LC316@ha
	lis 9,deathmatch@ha
	la 11,.LC316@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L558
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L558
	bl G_FreeEdict
	b .L557
.L649:
	mr 4,31
	b .L565
.L558:
	lis 9,.LC298@ha
	li 0,2
	la 9,.LC298@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC268@ha
	lis 11,itemlist@ha
	la 27,.LC268@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L566
	mr 28,10
.L561:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L563
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L649
.L563:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L561
.L566:
	li 4,0
.L565:
	mr 3,29
	bl SpawnItem
	li 0,1
	lis 9,gi+36@ha
	stw 0,644(29)
	lis 3,.LC49@ha
	lwz 0,gi+36@l(9)
	la 3,.LC49@l(3)
	mtlr 0
	blrl
.L557:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe44:
	.size	 SP_item_health_small,.Lfe44-SP_item_health_small
	.section	".rodata"
	.align 2
.LC317:
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
	lis 11,.LC317@ha
	lis 9,deathmatch@ha
	la 11,.LC317@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L568
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L568
	bl G_FreeEdict
	b .L567
.L650:
	mr 4,31
	b .L575
.L568:
	lis 9,.LC299@ha
	li 0,25
	la 9,.LC299@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC268@ha
	lis 11,itemlist@ha
	la 27,.LC268@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L576
	mr 28,10
.L571:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L573
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L650
.L573:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L571
.L576:
	li 4,0
.L575:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC51@ha
	lwz 0,gi+36@l(9)
	la 3,.LC51@l(3)
	mtlr 0
	blrl
.L567:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe45:
	.size	 SP_item_health_large,.Lfe45-SP_item_health_large
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
