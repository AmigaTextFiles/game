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
	.align 2
.LC0:
	.long 0x0
	.section	".text"
	.align 2
	.globl DoRespawn
	.type	 DoRespawn,@function
DoRespawn:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	mr 31,3
	lwz 0,308(31)
	cmpwi 0,0,0
	bc 12,2,.L26
	lis 9,.LC0@ha
	lis 11,ctf@ha
	lwz 30,564(31)
	la 9,.LC0@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L27
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,40(1)
	lwz 11,44(1)
	andi. 0,11,4
	bc 12,2,.L27
	lwz 9,648(30)
	cmpwi 0,9,0
	bc 12,2,.L27
	lwz 0,56(9)
	andi. 9,0,1
	bc 12,2,.L27
	mr 31,30
	b .L39
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
	bc 4,1,.L39
	mr 29,3
.L36:
	addic. 29,29,-1
	lwz 31,536(31)
	bc 4,2,.L36
	b .L39
.L26:
	mr 3,31
	addi 4,1,8
	bl FindRandomWeapon
	mr. 11,3
	bc 12,2,.L39
	lis 9,gi@ha
	stw 11,648(31)
	mr 3,31
	la 9,gi@l(9)
	lwz 4,24(11)
	lwz 0,44(9)
	mtlr 0
	blrl
	lwz 9,648(31)
	lwz 0,28(9)
	stw 0,64(31)
.L39:
	lwz 0,184(31)
	li 29,1
	lis 9,gi+72@ha
	lfs 12,1000(31)
	mr 3,31
	lfs 13,1004(31)
	rlwinm 0,0,0,0,30
	lfs 0,1008(31)
	stfs 12,4(31)
	stfs 13,8(31)
	stfs 0,12(31)
	stw 0,184(31)
	stw 29,248(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	stw 29,80(31)
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe1:
	.size	 DoRespawn,.Lfe1-DoRespawn
	.section	".rodata"
	.align 3
.LC1:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC2:
	.long 0x3f800000
	.align 2
.LC3:
	.long 0x40000000
	.align 2
.LC4:
	.long 0x0
	.align 3
.LC5:
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
	lis 0,0x3cf3
	lwz 10,skill@l(11)
	la 9,itemlist@l(9)
	lis 7,.LC2@ha
	ori 0,0,53053
	mr 30,4
	subf 9,9,8
	la 7,.LC2@l(7)
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
	bc 4,2,.L53
	lis 7,.LC3@ha
	srawi 0,11,31
	la 7,.LC3@l(7)
	subf 0,11,0
	lfs 0,0(7)
	srwi 10,0,31
	fcmpu 7,13,0
	cror 31,30,29
	mfcr 9
	rlwinm 9,9,0,1
	and. 0,9,10
	bc 4,2,.L53
	lis 11,coop@ha
	lis 7,.LC4@ha
	lwz 9,coop@l(11)
	la 7,.LC4@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L45
	lwz 0,56(8)
	rlwinm 0,0,29,31,31
	and. 9,0,10
	bc 12,2,.L45
.L53:
	li 3,0
	b .L52
.L45:
	lwz 0,648(31)
	lis 9,itemlist@ha
	lis 11,0x3cf3
	la 9,itemlist@l(9)
	ori 11,11,53053
	lwz 10,84(30)
	subf 0,9,0
	lis 8,deathmatch@ha
	mullw 0,0,11
	addi 10,10,740
	lis 7,.LC4@ha
	lwz 11,deathmatch@l(8)
	la 7,.LC4@l(7)
	rlwinm 0,0,0,0,29
	lfs 13,0(7)
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L46
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L47
	lis 9,.LC5@ha
	lwz 11,648(31)
	la 9,.LC5@l(9)
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
.L47:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,16
	bc 4,2,.L50
	lwz 9,648(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L46
	lwz 0,284(31)
	andis. 7,0,2
	bc 12,2,.L46
.L50:
	lwz 9,648(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L51
	lwz 0,284(31)
	andis. 9,0,2
	bc 12,2,.L51
	lis 11,level+4@ha
	lfs 0,428(31)
	lis 10,.LC1@ha
	lfs 11,level+4@l(11)
	lfd 12,.LC1@l(10)
	lis 11,quad_drop_timeout_hack@ha
	fsubs 0,0,11
	fdiv 0,0,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	stw 9,quad_drop_timeout_hack@l(11)
.L51:
	lwz 9,648(31)
	mr 3,30
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L46:
	li 3,1
.L52:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Pickup_Powerup,.Lfe2-Pickup_Powerup
	.section	".rodata"
	.align 2
.LC6:
	.string	"Bullets"
	.align 2
.LC7:
	.string	"Shells"
	.align 2
.LC8:
	.long 0x0
	.align 3
.LC9:
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
	bc 12,1,.L64
	li 0,250
	stw 0,1764(9)
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
	lis 11,.LC6@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC6@l(11)
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
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L70
.L75:
	li 8,0
.L74:
	cmpwi 0,8,0
	bc 12,2,.L76
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,53053
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
	lis 11,.LC7@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC7@l(11)
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
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L80
.L85:
	li 8,0
.L84:
	cmpwi 0,8,0
	bc 12,2,.L86
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,53053
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
	bc 4,1,.L86
	stwx 11,4,8
.L86:
	lwz 0,284(28)
	andis. 4,0,0x1
	bc 4,2,.L88
	lis 9,.LC8@ha
	lis 11,deathmatch@ha
	la 9,.LC8@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L88
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
.L88:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 Pickup_Bandolier,.Lfe3-Pickup_Bandolier
	.section	".rodata"
	.align 2
.LC10:
	.string	"Cells"
	.align 2
.LC11:
	.string	"Grenades"
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
	mr 27,3
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
	cmpwi 0,0,99
	bc 12,1,.L94
	li 0,100
	stw 0,1776(9)
.L94:
	lwz 9,84(29)
	lwz 0,1780(9)
	cmpwi 0,0,299
	bc 12,1,.L95
	li 0,300
	stw 0,1780(9)
.L95:
	lwz 9,84(29)
	lwz 0,1784(9)
	cmpwi 0,0,99
	bc 12,1,.L96
	li 0,100
	stw 0,1784(9)
.L96:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC6@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC6@l(11)
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
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L99
.L104:
	li 8,0
.L103:
	cmpwi 0,8,0
	bc 12,2,.L105
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,53053
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
	bc 4,1,.L105
	stwx 11,9,8
.L105:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC7@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC7@l(11)
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
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L109
.L114:
	li 8,0
.L113:
	cmpwi 0,8,0
	bc 12,2,.L115
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,53053
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
	bc 4,1,.L115
	stwx 11,9,8
.L115:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC10@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC10@l(11)
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
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L119
.L124:
	li 8,0
.L123:
	cmpwi 0,8,0
	bc 12,2,.L125
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,53053
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
	bc 4,1,.L125
	stwx 11,9,8
.L125:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC11@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC11@l(11)
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
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L129
.L134:
	li 8,0
.L133:
	cmpwi 0,8,0
	bc 12,2,.L135
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,53053
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
	bc 4,1,.L135
	stwx 11,9,8
.L135:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC12@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC12@l(11)
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
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L139
.L144:
	li 8,0
.L143:
	cmpwi 0,8,0
	bc 12,2,.L145
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,53053
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
	bc 4,1,.L145
	stwx 11,9,8
.L145:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC13@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC13@l(11)
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
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L149
.L154:
	li 8,0
.L153:
	cmpwi 0,8,0
	bc 12,2,.L155
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,53053
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
	bc 4,1,.L155
	stwx 11,4,8
.L155:
	lwz 0,284(27)
	andis. 4,0,0x1
	bc 4,2,.L157
	lis 9,.LC14@ha
	lis 11,deathmatch@ha
	la 9,.LC14@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L157
	lis 9,.LC15@ha
	lwz 11,648(27)
	la 9,.LC15@l(9)
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
.Lfe4:
	.size	 Pickup_Pack,.Lfe4-Pickup_Pack
	.section	".rodata"
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
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	mr 31,3
	subf 4,9,4
	ori 0,0,53053
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
	lfs 12,3800(8)
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
	b .L164
.L162:
	add 0,11,10
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
.L164:
	stfs 0,3800(8)
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
.Lfe5:
	.size	 Use_Quad,.Lfe5-Use_Quad
	.section	".rodata"
	.align 2
.LC20:
	.string	"items/protect.wav"
	.align 3
.LC21:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC22:
	.long 0x43960000
	.align 2
.LC23:
	.long 0x3f800000
	.align 2
.LC24:
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
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	mr 31,3
	subf 4,9,4
	ori 0,0,53053
	lwz 11,84(31)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC21@ha
	lis 11,level@ha
	lwz 10,84(31)
	la 9,.LC21@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3804(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L172
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L174
.L172:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L174:
	stfs 0,3804(10)
	lis 29,gi@ha
	lis 3,.LC20@ha
	la 29,gi@l(29)
	la 3,.LC20@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC23@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC23@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 2,0(9)
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
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
.LC25:
	.string	"key_power_cube"
	.align 2
.LC26:
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
	lis 11,.LC26@ha
	lis 9,coop@ha
	la 11,.LC26@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 30,4
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L177
	lwz 3,280(31)
	lis 4,.LC25@ha
	la 4,.LC25@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L178
	lwz 10,84(30)
	lbz 9,286(31)
	lwz 0,1796(10)
	and. 11,0,9
	bc 4,2,.L183
	lwz 0,648(31)
	lis 9,itemlist@ha
	lis 11,0x3cf3
	la 9,itemlist@l(9)
	ori 11,11,53053
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
	b .L180
.L178:
	lwz 11,648(31)
	lis 9,itemlist@ha
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	ori 0,0,53053
	lwz 10,84(30)
	subf 11,9,11
	mullw 11,11,0
	addi 4,10,740
	rlwinm 3,11,0,0,29
	lwzx 0,4,3
	cmpwi 0,0,0
	bc 12,2,.L181
.L183:
	li 3,0
	b .L182
.L181:
	li 0,1
	stwx 0,4,3
.L180:
	li 3,1
	b .L182
.L177:
	lwz 0,648(31)
	lis 9,itemlist@ha
	lis 11,0x3cf3
	la 9,itemlist@l(9)
	ori 11,11,53053
	lwz 10,84(30)
	subf 0,9,0
	li 3,1
	mullw 0,0,11
	addi 10,10,740
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
.L182:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 Pickup_Key,.Lfe7-Pickup_Key
	.section	".rodata"
	.align 2
.LC27:
	.string	"blaster"
	.align 2
.LC28:
	.long 0x0
	.align 2
.LC29:
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
	mr 25,4
	lwz 8,648(29)
	lwz 0,56(8)
	andi. 4,0,1
	bc 12,2,.L201
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8192
	bc 12,2,.L201
	mr 7,8
	li 6,1000
	b .L202
.L201:
	lwz 0,532(29)
	cmpwi 0,0,0
	bc 12,2,.L203
	mr 6,0
	lwz 7,648(29)
	b .L202
.L203:
	lwz 9,648(29)
	lwz 6,48(9)
	mr 7,9
.L202:
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(25)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,7
	mr 8,11
	mullw 9,9,0
	cmpwi 0,11,0
	addi 11,11,740
	rlwinm 9,9,0,0,29
	lwzx 5,11,9
	li 0,0
	bc 12,2,.L207
	lwz 0,68(7)
	cmpwi 0,0,0
	bc 4,2,.L208
	lwz 10,1764(8)
	b .L209
.L208:
	cmpwi 0,0,1
	bc 4,2,.L210
	lwz 10,1768(8)
	b .L209
.L210:
	cmpwi 0,0,2
	bc 4,2,.L212
	lwz 10,1772(8)
	b .L209
.L212:
	cmpwi 0,0,3
	bc 4,2,.L214
	lwz 10,1776(8)
	b .L209
.L214:
	cmpwi 0,0,4
	bc 4,2,.L216
	lwz 10,1780(8)
	b .L209
.L216:
	cmpwi 0,0,5
	li 10,200
	bc 4,2,.L209
	lwz 10,1784(8)
.L209:
	lis 9,itemlist@ha
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,7
	addi 11,8,740
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	cmpw 0,0,10
	bc 4,2,.L220
	li 0,0
	b .L207
.L220:
	add 0,0,6
	stwx 0,11,8
	lwz 9,84(25)
	addi 9,9,740
	lwzx 0,9,8
	cmpw 0,0,10
	bc 4,1,.L221
	stwx 10,9,8
.L221:
	li 0,1
.L207:
	cmpwi 0,0,0
	bc 4,2,.L205
	li 3,0
	b .L235
.L236:
	mr 9,31
	b .L231
.L205:
	subfic 9,5,0
	adde 0,9,5
	and. 11,4,0
	bc 12,2,.L222
	lwz 26,84(25)
	lwz 9,648(29)
	lwz 0,1788(26)
	cmpw 0,0,9
	bc 12,2,.L222
	lis 9,.LC28@ha
	lis 11,deathmatch@ha
	la 9,.LC28@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L224
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC27@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC27@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L232
	mr 28,10
.L227:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L229
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L236
.L229:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L227
.L232:
	li 9,0
.L231:
	lwz 0,1788(26)
	cmpw 0,0,9
	bc 4,2,.L222
.L224:
	lwz 9,84(25)
	lwz 0,648(29)
	stw 0,3624(9)
.L222:
	lwz 0,284(29)
	andis. 7,0,0x3
	bc 4,2,.L233
	lis 9,.LC28@ha
	lis 11,deathmatch@ha
	la 9,.LC28@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L233
	lwz 9,264(29)
	lis 11,.LC29@ha
	lis 10,level+4@ha
	lwz 0,184(29)
	la 11,.LC29@l(11)
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
.L233:
	li 3,1
.L235:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 Pickup_Ammo,.Lfe8-Pickup_Ammo
	.section	".rodata"
	.align 2
.LC30:
	.string	"Can't drop current weapon\n"
	.align 2
.LC31:
	.string	"items/s_health.wav"
	.align 2
.LC32:
	.string	"items/n_health.wav"
	.align 2
.LC33:
	.string	"items/l_health.wav"
	.align 2
.LC34:
	.string	"items/m_health.wav"
	.align 2
.LC35:
	.long 0x0
	.align 3
.LC36:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC37:
	.long 0x40040000
	.long 0x0
	.align 2
.LC38:
	.long 0x40a00000
	.align 2
.LC39:
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
	lwz 0,532(31)
	cmpwi 0,0,100
	bc 4,2,.L247
	li 0,3
	stw 0,644(31)
.L247:
	lwz 0,644(31)
	lfs 13,1140(30)
	andi. 7,0,1
	bc 4,2,.L248
	lwz 9,480(30)
	lwz 0,484(30)
	cmpw 0,9,0
	bc 12,0,.L248
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L271
.L248:
	lis 8,.LC35@ha
	la 8,.LC35@l(8)
	lfs 31,0(8)
	fcmpu 0,13,31
	bc 12,2,.L251
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
	bc 4,0,.L252
	stfs 31,1140(30)
	b .L251
.L252:
	xoris 11,11,0x8000
	lfs 12,1140(30)
	stw 11,12(1)
	lis 0,0x4330
	lis 7,.LC36@ha
	la 7,.LC36@l(7)
	stw 0,8(1)
	lfd 13,0(7)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fsubs 12,12,0
	stfs 12,1140(30)
.L251:
	lwz 0,480(30)
	cmpwi 0,0,249
	bc 4,1,.L254
	lwz 0,532(31)
	cmpwi 0,0,25
	bc 4,1,.L254
.L271:
	li 3,0
	b .L270
.L254:
	lwz 0,644(31)
	andi. 8,0,1
	bc 12,2,.L255
	lwz 0,480(30)
	lwz 9,532(31)
	add 0,0,9
	stw 0,480(30)
	b .L256
.L255:
	lwz 11,480(30)
	lwz 9,484(30)
	cmpw 0,11,9
	bc 4,0,.L256
	lwz 0,532(31)
	add 0,11,0
	cmpw 0,0,9
	stw 0,480(30)
	bc 4,1,.L256
	stw 9,480(30)
.L256:
	lwz 0,480(30)
	lis 8,0x4330
	lwz 9,484(30)
	mr 10,11
	lis 7,.LC36@ha
	xoris 0,0,0x8000
	la 7,.LC36@l(7)
	stw 0,12(1)
	xoris 9,9,0x8000
	stw 8,8(1)
	lfd 13,8(1)
	stw 9,12(1)
	stw 8,8(1)
	lfd 12,0(7)
	lfd 0,8(1)
	lis 7,.LC37@ha
	la 7,.LC37@l(7)
	lfd 11,0(7)
	fsub 13,13,12
	fsub 0,0,12
	fmul 12,0,11
	fcmpu 0,13,12
	bc 4,1,.L259
	lwz 0,532(31)
	cmpwi 0,0,25
	bc 4,1,.L259
	fctiwz 0,12
	mr 9,11
	stfd 0,8(1)
	lwz 9,12(1)
	stw 9,480(30)
.L259:
	lwz 0,532(31)
	cmpwi 0,0,2
	bc 4,2,.L260
	lwz 11,648(31)
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	b .L272
.L260:
	cmpwi 0,0,10
	bc 4,2,.L262
	lwz 11,648(31)
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	b .L272
.L262:
	cmpwi 0,0,25
	bc 4,2,.L264
	lwz 11,648(31)
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	b .L272
.L264:
	lwz 11,648(31)
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
.L272:
	stw 9,20(11)
	lwz 0,644(31)
	andi. 8,0,2
	bc 12,2,.L266
	mr 3,30
	bl CTFHasRegeneration
	mr. 3,3
	bc 4,2,.L266
	lis 9,MegaHealth_think@ha
	lis 7,.LC38@ha
	lwz 11,264(31)
	la 9,MegaHealth_think@l(9)
	lis 10,level+4@ha
	lwz 0,184(31)
	la 7,.LC38@l(7)
	stw 9,436(31)
	oris 11,11,0x8000
	lfs 0,level+4@l(10)
	ori 0,0,1
	lfs 13,0(7)
	stw 3,248(31)
	stw 30,256(31)
	fadds 0,0,13
	stw 11,264(31)
	stw 0,184(31)
	stfs 0,428(31)
	b .L267
.L266:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L267
	lis 11,deathmatch@ha
	lis 8,.LC35@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC35@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L267
	lwz 9,264(31)
	lis 11,.LC39@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC39@l(11)
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
.L267:
	li 3,1
.L270:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 Pickup_Health,.Lfe9-Pickup_Health
	.section	".rodata"
	.align 2
.LC40:
	.long 0x0
	.align 3
.LC41:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC42:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl Pickup_Armor
	.type	 Pickup_Armor,@function
Pickup_Armor:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 9,enableclass@ha
	lis 8,.LC40@ha
	lwz 11,enableclass@l(9)
	la 8,.LC40@l(8)
	mr 31,3
	lfs 13,0(8)
	mr 30,4
	li 7,0
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L279
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L279
	lwz 7,3528(9)
.L279:
	lwz 11,648(31)
	lis 9,bodyarmor_info@ha
	la 9,bodyarmor_info@l(9)
	lwz 12,64(11)
	mr 4,11
	cmpw 0,12,9
	bc 4,2,.L281
	mulli 0,7,2924
	lis 9,classtbl+2904@ha
	la 9,classtbl+2904@l(9)
	add 12,0,9
	b .L282
.L281:
	lis 9,combatarmor_info@ha
	la 9,combatarmor_info@l(9)
	cmpw 0,12,9
	bc 4,2,.L283
	mulli 0,7,2924
	lis 9,classtbl+2884@ha
	la 9,classtbl+2884@l(9)
	add 12,0,9
	b .L282
.L283:
	lis 9,jacketarmor_info@ha
	la 9,jacketarmor_info@l(9)
	cmpw 0,12,9
	bc 4,2,.L285
	mulli 0,7,2924
	lis 9,classtbl+2864@ha
	la 9,classtbl+2864@l(9)
	add 12,0,9
	b .L282
.L285:
	li 12,0
.L282:
	lwz 0,84(30)
	cmpwi 0,0,0
	mr 6,0
	bc 4,2,.L287
	li 5,0
	b .L288
.L287:
	lis 9,jacket_armor_index@ha
	addi 8,6,740
	lwz 5,jacket_armor_index@l(9)
	slwi 0,5,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L288
	lis 9,combat_armor_index@ha
	lwz 5,combat_armor_index@l(9)
	slwi 0,5,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L288
	lis 9,body_armor_index@ha
	lwz 10,body_armor_index@l(9)
	slwi 11,10,2
	lwzx 9,8,11
	srawi 0,9,31
	subf 0,9,0
	srawi 0,0,31
	and 5,10,0
.L288:
	lwz 0,68(4)
	cmpwi 0,0,4
	bc 4,2,.L292
	cmpwi 0,5,0
	bc 4,2,.L293
	lis 9,jacket_armor_index@ha
	addi 10,6,740
	lwz 0,jacket_armor_index@l(9)
	li 11,2
	slwi 0,0,2
	stwx 11,10,0
	b .L295
.L293:
	slwi 0,5,2
	addi 11,6,740
	lwzx 9,11,0
	addi 9,9,2
	stwx 9,11,0
	b .L295
.L292:
	cmpwi 0,5,0
	bc 4,2,.L296
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 10,0(12)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,4
	addi 11,6,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	stwx 10,11,9
	b .L295
.L296:
	lis 9,jacket_armor_index@ha
	lwz 0,jacket_armor_index@l(9)
	cmpw 0,5,0
	bc 4,2,.L298
	mulli 0,7,2924
	lis 9,classtbl+2864@ha
	la 9,classtbl+2864@l(9)
	b .L310
.L298:
	lis 9,combat_armor_index@ha
	lwz 0,combat_armor_index@l(9)
	cmpw 0,5,0
	bc 4,2,.L300
	mulli 0,7,2924
	lis 9,classtbl+2884@ha
	la 9,classtbl+2884@l(9)
	b .L310
.L300:
	mulli 0,7,2924
	lis 9,classtbl+2904@ha
	la 9,classtbl+2904@l(9)
.L310:
	add 11,0,9
	lfs 13,8(12)
	lfs 0,8(11)
	fcmpu 0,13,0
	bc 4,1,.L302
	fdivs 11,0,13
	slwi 5,5,2
	addi 6,6,740
	lwz 8,4(12)
	lwzx 0,6,5
	lis 7,0x4330
	lis 11,.LC41@ha
	lwz 3,0(12)
	li 10,0
	xoris 0,0,0x8000
	la 11,.LC41@l(11)
	stwx 10,6,5
	stw 0,20(1)
	mr 4,9
	stw 7,16(1)
	lis 0,0x3cf3
	lfd 13,0(11)
	ori 0,0,53053
	lfd 0,16(1)
	lis 11,itemlist@ha
	lwz 9,648(31)
	la 11,itemlist@l(11)
	lwz 10,84(30)
	subf 9,11,9
	mullw 9,9,0
	addi 10,10,740
	rlwinm 9,9,0,0,29
	fsub 0,0,13
	frsp 0,0
	fmuls 0,11,0
	fmr 13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 0,20(1)
	add 3,3,0
	cmpw 7,3,8
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 8,8,0
	and 0,3,0
	or 3,0,8
	stwx 3,10,9
	b .L295
.L302:
	fdivs 11,13,0
	lwz 0,0(12)
	lis 10,0x4330
	lis 8,.LC41@ha
	slwi 5,5,2
	lwz 11,4(11)
	xoris 0,0,0x8000
	la 8,.LC41@l(8)
	stw 0,20(1)
	addi 6,6,740
	stw 10,16(1)
	lfd 13,0(8)
	lfd 0,16(1)
	mr 8,9
	lwzx 10,6,5
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
	bc 12,0,.L306
	li 3,0
	b .L309
.L306:
	stwx 0,6,5
.L295:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L307
	lis 9,.LC40@ha
	lis 11,deathmatch@ha
	la 9,.LC40@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L307
	lwz 9,264(31)
	lis 11,.LC42@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC42@l(11)
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
.L307:
	li 3,1
.L309:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 Pickup_Armor,.Lfe10-Pickup_Armor
	.section	".rodata"
	.align 2
.LC43:
	.string	"misc/power2.wav"
	.align 2
.LC44:
	.string	"cells"
	.align 2
.LC45:
	.string	"No cells for power armor.\n"
	.align 2
.LC46:
	.string	"misc/power1.wav"
	.align 2
.LC47:
	.long 0x3f800000
	.align 2
.LC48:
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
	andi. 9,0,12288
	bc 12,2,.L316
	rlwinm 0,0,0,20,17
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(30)
	lis 3,.LC43@ha
	lwz 9,36(29)
	la 3,.LC43@l(3)
	mtlr 9
	blrl
	lis 9,.LC47@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC47@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfs 2,0(9)
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfs 3,0(9)
	blrl
	b .L315
.L327:
	mr 10,29
	b .L324
.L316:
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lis 11,.LC44@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC44@l(11)
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L325
	mr 28,10
.L320:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L322
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L327
.L322:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,84
	cmpw 0,31,0
	bc 12,0,.L320
.L325:
	li 10,0
.L324:
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L326
	lis 9,gi+8@ha
	lis 5,.LC45@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC45@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L315
.L326:
	lwz 0,264(30)
	lis 29,gi@ha
	lis 3,.LC46@ha
	la 29,gi@l(29)
	la 3,.LC46@l(3)
	ori 0,0,4096
	stw 0,264(30)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC47@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC47@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfs 2,0(9)
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfs 3,0(9)
	blrl
.L315:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 Use_PowerArmor,.Lfe11-Use_PowerArmor
	.section	".rodata"
	.align 2
.LC49:
	.long 0x0
	.align 3
.LC50:
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
	lis 0,0x3cf3
	ori 0,0,53053
	mr 29,4
	subf 9,11,9
	lwz 10,84(29)
	mullw 9,9,0
	lis 11,deathmatch@ha
	addi 10,10,740
	lwz 8,deathmatch@l(11)
	rlwinm 9,9,0,0,29
	lis 11,.LC49@ha
	lwzx 30,10,9
	la 11,.LC49@l(11)
	lfs 13,0(11)
	addi 0,30,1
	stwx 0,10,9
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L329
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L330
	lis 9,.LC50@ha
	lwz 11,648(31)
	la 9,.LC50@l(9)
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
.L330:
	cmpwi 0,30,0
	bc 4,2,.L329
	lwz 9,648(31)
	mr 3,29
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L329:
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
.LC51:
	.string	"No cells for power screen.\n"
	.align 2
.LC52:
	.long 0x3f800000
	.align 2
.LC53:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_PowerScreen
	.type	 Use_PowerScreen,@function
Use_PowerScreen:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 30,3
	lwz 0,264(30)
	andi. 9,0,12288
	bc 12,2,.L337
	rlwinm 0,0,0,20,17
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(30)
	lis 3,.LC43@ha
	lwz 9,36(29)
	la 3,.LC43@l(3)
	mtlr 9
	blrl
	lis 9,.LC52@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC52@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 2,0(9)
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	lfs 3,0(9)
	blrl
	b .L336
.L348:
	mr 10,29
	b .L345
.L337:
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lis 11,.LC44@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC44@l(11)
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L346
	mr 28,10
.L341:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L343
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L348
.L343:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,84
	cmpw 0,31,0
	bc 12,0,.L341
.L346:
	li 10,0
.L345:
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L347
	lis 9,gi+8@ha
	lis 5,.LC51@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC51@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L336
.L347:
	lwz 0,264(30)
	lis 29,gi@ha
	lis 3,.LC46@ha
	la 29,gi@l(29)
	la 3,.LC46@l(3)
	ori 0,0,8192
	stw 0,264(30)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC52@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC52@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 2,0(9)
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	lfs 3,0(9)
	blrl
.L336:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 Use_PowerScreen,.Lfe13-Use_PowerScreen
	.section	".rodata"
	.align 2
.LC54:
	.long 0x0
	.align 3
.LC55:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_PowerScreen
	.type	 Pickup_PowerScreen,@function
Pickup_PowerScreen:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lis 11,itemlist@ha
	lwz 9,648(31)
	la 11,itemlist@l(11)
	lis 0,0x3cf3
	ori 0,0,53053
	mr 29,4
	subf 9,11,9
	lwz 10,84(29)
	mullw 9,9,0
	lis 11,deathmatch@ha
	addi 10,10,740
	lwz 8,deathmatch@l(11)
	rlwinm 9,9,0,0,29
	lis 11,.LC54@ha
	lwzx 30,10,9
	la 11,.LC54@l(11)
	lfs 13,0(11)
	addi 0,30,1
	stwx 0,10,9
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L350
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L351
	lis 9,.LC55@ha
	lwz 11,648(31)
	la 9,.LC55@l(9)
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
.L351:
	cmpwi 0,30,0
	bc 4,2,.L350
	lwz 9,648(31)
	mr 3,29
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L350:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe14:
	.size	 Pickup_PowerScreen,.Lfe14-Pickup_PowerScreen
	.section	".rodata"
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
	stwu 1,-48(1)
	mflr 0
	mfcr 12
	stmw 25,20(1)
	stw 0,52(1)
	stw 12,16(1)
	mr 27,4
	mr 30,3
	lwz 0,84(27)
	cmpwi 0,0,0
	bc 12,2,.L357
	lwz 0,480(27)
	cmpwi 0,0,0
	bc 4,1,.L357
	lwz 11,648(30)
	lwz 0,4(11)
	cmpwi 0,0,0
	bc 12,2,.L357
	lwz 0,284(30)
	andis. 9,0,0x3
	bc 12,2,.L361
	li 25,-1
	b .L362
.L361:
	lis 9,itemlist@ha
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,11
	mullw 9,9,0
	srawi 25,9,2
.L362:
	cmpwi 4,25,0
	bc 12,16,.L363
	lis 9,wrndtbl@ha
	mulli 10,25,76
	la 7,wrndtbl@l(9)
	addi 9,7,64
	mr 28,10
	lwzx 0,9,10
	mr 8,10
	cmpwi 0,0,4
	bc 4,2,.L364
	addi 3,7,68
	li 5,0
	lwzx 0,3,10
	li 6,0
	li 4,0
	cmpw 0,5,0
	bc 4,0,.L366
	lwz 11,84(27)
	lis 9,itemlist@ha
	lis 10,0x3cf3
	mr 31,7
	la 29,itemlist@l(9)
	addi 11,11,740
	ori 10,10,53053
	li 7,0
.L367:
	add 9,7,8
	lwzx 9,31,9
	subf 0,29,9
	mullw 0,0,10
	rlwinm 0,0,0,0,29
	lwzx 0,11,0
	cmpw 0,0,4
	bc 12,0,.L369
	cmpwi 0,5,0
	bc 4,2,.L368
.L369:
	mr 5,9
	mr 4,0
.L368:
	lwzx 0,3,28
	addi 6,6,1
	addi 7,7,4
	mr 8,28
	cmpw 0,6,0
	bc 12,0,.L367
.L366:
	stw 5,648(30)
	b .L363
.L364:
	cmpwi 0,0,5
	bc 4,2,.L372
	addi 11,7,68
	li 31,1
	lwzx 0,11,10
	cmpw 0,31,0
	bc 4,0,.L374
	add 9,10,7
	mr 26,11
	addi 29,9,4
.L375:
	lwz 9,0(29)
	addi 29,29,4
	stw 9,648(30)
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 12,2,.L376
	mr 3,30
	mr 4,27
	mtlr 0
	blrl
.L376:
	lwzx 0,26,28
	addi 31,31,1
	cmpw 0,31,0
	bc 12,0,.L375
.L374:
	lis 9,wrndtbl@ha
	la 9,wrndtbl@l(9)
	lwzx 0,9,28
	stw 0,648(30)
	b .L363
.L372:
	cmpwi 0,0,6
	bc 4,2,.L363
	lis 9,.LC56@ha
	lis 11,enableclass@ha
	la 9,.LC56@l(9)
	lfs 13,0(9)
	lwz 9,enableclass@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L381
	lwz 9,84(27)
	addi 11,7,68
	lwzx 0,11,10
	lwz 9,3528(9)
	cmpw 0,9,0
	bc 12,0,.L380
.L381:
	lwzx 0,7,10
	stw 0,648(30)
	b .L363
.L380:
	slwi 0,9,2
	add 0,0,10
	lwzx 9,7,0
	stw 9,648(30)
.L363:
	lwz 9,648(30)
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 12,2,.L357
	mr 3,30
	mr 4,27
	mtlr 0
	blrl
	mr. 31,3
	bc 12,2,.L384
	lwz 11,84(27)
	lis 0,0x3e80
	lis 10,gi+40@ha
	stw 0,3712(11)
	lwz 0,gi+40@l(10)
	lwz 9,648(30)
	mtlr 0
	lwz 3,36(9)
	blrl
	lis 9,itemlist@ha
	lwz 11,84(27)
	lis 7,0x3cf3
	la 8,itemlist@l(9)
	ori 7,7,53053
	lis 9,.LC57@ha
	sth 3,134(11)
	lis 10,level+4@ha
	la 9,.LC57@l(9)
	lwz 11,84(27)
	lfd 13,0(9)
	lwz 9,648(30)
	subf 9,8,9
	mullw 9,9,7
	srawi 9,9,2
	addi 9,9,1056
	sth 9,136(11)
	lfs 0,level+4@l(10)
	lwz 9,84(27)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3832(9)
	lwz 9,648(30)
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 12,2,.L385
	subf 0,8,9
	mullw 0,0,7
	lwz 8,84(27)
	srawi 10,0,2
	addi 11,8,740
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L385
	extsh 0,10
	sth 10,144(8)
	stw 0,736(8)
.L385:
	lwz 3,648(30)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	lwz 0,4(3)
	cmpw 0,0,9
	bc 4,2,.L386
	lwz 0,532(30)
	cmpwi 0,0,2
	bc 4,2,.L387
	lis 29,gi@ha
	lis 3,.LC31@ha
	la 29,gi@l(29)
	la 3,.LC31@l(3)
	b .L403
.L387:
	cmpwi 0,0,10
	bc 4,2,.L389
	lis 29,gi@ha
	lis 3,.LC32@ha
	la 29,gi@l(29)
	la 3,.LC32@l(3)
	b .L403
.L389:
	cmpwi 0,0,25
	bc 4,2,.L391
	lis 29,gi@ha
	lis 3,.LC33@ha
	la 29,gi@l(29)
	la 3,.LC33@l(3)
	b .L403
.L391:
	lis 29,gi@ha
	lis 3,.LC34@ha
	la 29,gi@l(29)
	la 3,.LC34@l(3)
.L403:
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC58@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC58@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,27
	mtlr 0
	lis 9,.LC58@ha
	la 9,.LC58@l(9)
	lfs 2,0(9)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 3,0(9)
	blrl
	b .L384
.L386:
	lwz 3,20(3)
	cmpwi 0,3,0
	bc 12,2,.L384
	lis 29,gi@ha
	la 29,gi@l(29)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC58@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC58@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,27
	mtlr 0
	lis 9,.LC58@ha
	la 9,.LC58@l(9)
	lfs 2,0(9)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 3,0(9)
	blrl
.L384:
	lwz 0,284(30)
	andis. 9,0,4
	bc 4,2,.L395
	mr 4,27
	mr 3,30
	bl G_UseTargets
	lwz 0,284(30)
	oris 0,0,0x4
	stw 0,284(30)
.L395:
	bc 12,16,.L396
	lis 9,wrndtbl@ha
	mulli 0,25,76
	la 9,wrndtbl@l(9)
	addi 9,9,64
	lwzx 11,9,0
	addi 11,11,-4
	cmplwi 0,11,2
	bc 12,1,.L396
	lwz 0,1092(30)
	stw 0,648(30)
.L396:
	cmpwi 0,31,0
	bc 12,2,.L357
	lis 9,.LC56@ha
	lis 11,coop@ha
	la 9,.LC56@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L400
	lwz 9,648(30)
	lwz 0,56(9)
	andi. 9,0,8
	bc 12,2,.L400
	lwz 0,284(30)
	andis. 9,0,0x3
	bc 12,2,.L357
.L400:
	lwz 0,264(30)
	cmpwi 0,0,0
	bc 4,0,.L401
	rlwinm 0,0,0,1,31
	stw 0,264(30)
	b .L357
.L401:
	mr 3,30
	bl G_FreeEdict
.L357:
	lwz 0,52(1)
	lwz 12,16(1)
	mtlr 0
	lmw 25,20(1)
	mtcrf 8,12
	la 1,48(1)
	blr
.Lfe15:
	.size	 Touch_Item,.Lfe15-Touch_Item
	.section	".rodata"
	.align 2
.LC59:
	.string	"misc/ir_start.wav"
	.align 3
.LC60:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC61:
	.long 0x44160000
	.align 2
.LC62:
	.long 0x3f800000
	.align 2
.LC63:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_IR
	.type	 Use_IR,@function
Use_IR:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,itemlist@ha
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	mr 31,3
	subf 4,9,4
	ori 0,0,53053
	lwz 11,84(31)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC60@ha
	lis 11,level@ha
	lwz 10,84(31)
	la 9,.LC60@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3924(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L405
	lis 9,.LC61@ha
	la 9,.LC61@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L407
.L405:
	addi 0,11,600
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L407:
	stfs 0,3924(10)
	lis 29,gi@ha
	lis 3,.LC59@ha
	la 29,gi@l(29)
	la 3,.LC59@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC62@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC62@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC62@ha
	la 9,.LC62@l(9)
	lfs 2,0(9)
	lis 9,.LC63@ha
	la 9,.LC63@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 Use_IR,.Lfe16-Use_IR
	.section	".rodata"
	.align 2
.LC64:
	.long 0x42c80000
	.align 2
.LC65:
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
	lwz 11,0(29)
	mr 31,3
	lis 0,0x1
	stw 0,284(31)
	li 9,0
	lis 10,0xc170
	stw 11,280(31)
	lis 8,0x4170
	ori 9,9,33280
	stw 29,648(31)
	lis 11,gi@ha
	lwz 0,28(29)
	la 26,gi@l(11)
	stw 9,68(31)
	stw 0,64(31)
	stw 10,196(31)
	stw 8,208(31)
	stw 10,188(31)
	stw 10,192(31)
	stw 8,200(31)
	stw 8,204(31)
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
	bc 12,2,.L414
	addi 29,1,24
	addi 4,1,8
	addi 3,3,3728
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
	b .L416
.L414:
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
.L416:
	stfs 0,12(31)
	lis 9,.LC64@ha
	addi 3,1,8
	la 9,.LC64@l(9)
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
	lis 9,.LC65@ha
	lfs 0,level+4@l(11)
	la 9,.LC65@l(9)
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
.Lfe17:
	.size	 Drop_Item,.Lfe17-Drop_Item
	.section	".rodata"
	.align 2
.LC66:
	.string	"droptofloor: %s startsolid at %s\n"
	.align 3
.LC67:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC68:
	.long 0xc1700000
	.align 2
.LC69:
	.long 0x41700000
	.align 2
.LC70:
	.long 0x0
	.align 2
.LC71:
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
	lis 9,.LC68@ha
	lis 11,.LC68@ha
	la 9,.LC68@l(9)
	la 11,.LC68@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC68@ha
	lfs 2,0(11)
	la 9,.LC68@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC69@ha
	lfs 13,0(11)
	la 9,.LC69@l(9)
	lfs 1,0(9)
	lis 9,.LC69@ha
	stfs 13,188(31)
	la 9,.LC69@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC69@ha
	stfs 0,192(31)
	la 9,.LC69@l(9)
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
	bc 12,2,.L421
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L422
.L421:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L422:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC70@ha
	stw 9,444(31)
	addi 29,31,4
	la 11,.LC70@l(11)
	lis 9,.LC71@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC71@l(9)
	lis 11,.LC70@ha
	lfs 3,0(9)
	la 11,.LC70@l(11)
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
	bc 12,2,.L423
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC66@ha
	la 3,.LC66@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L420
.L423:
	lwz 0,308(31)
	lfs 12,20(1)
	lfs 0,24(1)
	cmpwi 0,0,0
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L424
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
	bc 4,2,.L424
	lis 11,level+4@ha
	lis 10,.LC67@ha
	lfs 0,level+4@l(11)
	lis 9,DoRespawn@ha
	lfd 13,.LC67@l(10)
	la 9,DoRespawn@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L424:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L426
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
.L426:
	lwz 0,284(31)
	andi. 11,0,1
	bc 12,2,.L427
	lwz 0,184(31)
	lis 9,Use_Item@ha
	li 11,0
	la 9,Use_Item@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
.L427:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L420:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe18:
	.size	 droptofloor,.Lfe18-droptofloor
	.section	".rodata"
	.align 2
.LC72:
	.string	"PrecacheItem: %s has bad precache string"
	.align 2
.LC73:
	.string	"md2"
	.align 2
.LC74:
	.string	"sp2"
	.align 2
.LC75:
	.string	"wav"
	.align 2
.LC76:
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
	bc 12,2,.L428
	lwz 3,20(26)
	cmpwi 0,3,0
	bc 12,2,.L430
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L430:
	lwz 3,24(26)
	cmpwi 0,3,0
	bc 12,2,.L431
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L431:
	lwz 3,32(26)
	cmpwi 0,3,0
	bc 12,2,.L432
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L432:
	lwz 3,36(26)
	cmpwi 0,3,0
	bc 12,2,.L433
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
.L433:
	lwz 29,52(26)
	cmpwi 0,29,0
	bc 12,2,.L434
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L434
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L442
	mr 28,9
.L437:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L439
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L439
	mr 3,31
	b .L441
.L439:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L437
.L442:
	li 3,0
.L441:
	cmpw 0,3,26
	bc 12,2,.L434
	bl PrecacheItem
.L434:
	lwz 30,72(26)
	cmpwi 0,30,0
	bc 12,2,.L428
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 12,2,.L428
	lis 9,gi@ha
	addi 29,1,8
	la 27,gi@l(9)
	lis 24,.LC73@ha
	lis 25,.LC76@ha
.L448:
	rlwinm 9,0,0,0xff
	mr 31,30
	b .L462
.L451:
	lbzu 9,1(30)
.L462:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L451
	subf 28,31,30
	addi 0,28,-5
	cmplwi 0,0,58
	bc 4,1,.L453
	lwz 9,28(27)
	lis 3,.LC72@ha
	la 3,.LC72@l(3)
	lwz 4,0(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L453:
	mr 4,31
	mr 5,28
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 0,0
	addi 11,30,1
	stbx 0,29,28
	add 9,29,28
	la 4,.LC73@l(24)
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
	bc 12,2,.L463
	lis 4,.LC74@ha
	mr 3,31
	la 4,.LC74@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L457
.L463:
	lwz 9,32(27)
	mr 3,29
	mtlr 9
	blrl
	b .L456
.L457:
	lis 4,.LC75@ha
	mr 3,31
	la 4,.LC75@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L456
	lwz 9,36(27)
	mr 3,29
	mtlr 9
	blrl
.L456:
	add 3,29,28
	la 4,.LC76@l(25)
	addi 3,3,-3
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L446
	lwz 9,40(27)
	mr 3,29
	mtlr 9
	blrl
.L446:
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L448
.L428:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe19:
	.size	 PrecacheItem,.Lfe19-PrecacheItem
	.section	".rodata"
	.align 2
.LC77:
	.string	"%s at %s has invalid spawnflags set\n"
	.align 2
.LC78:
	.string	"item_medipak"
	.align 2
.LC79:
	.string	"weapon_bfg"
	.align 2
.LC80:
	.string	"item_flag_team1"
	.align 2
.LC81:
	.string	"item_flag_team2"
	.align 3
.LC82:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC83:
	.long 0x0
	.section	".text"
	.align 2
	.globl SpawnItem
	.type	 SpawnItem,@function
SpawnItem:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	mr 30,4
	lwz 0,284(31)
	stw 30,1092(31)
	andi. 9,0,8192
	bc 12,2,.L465
	rlwinm 0,0,0,19,17
	stw 0,284(31)
	b .L466
.L465:
	mr 3,31
	addi 4,1,8
	bl FindRandomWeapon
	mr. 3,3
	bc 4,2,.L467
	lwz 0,8(1)
	cmpwi 0,0,3
	bc 4,2,.L466
	b .L488
.L467:
	mr 30,3
.L466:
	mr 3,30
	bl PrecacheItem
	lwz 0,284(31)
	cmpwi 0,0,0
	bc 12,2,.L470
	lwz 3,280(31)
	lis 4,.LC25@ha
	la 4,.LC25@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L470
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
	lis 3,.LC77@ha
	la 3,.LC77@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L470:
	lis 9,.LC83@ha
	lis 11,deathmatch@ha
	la 9,.LC83@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L472
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,2048
	bc 12,2,.L473
	lwz 0,4(30)
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L488
	lis 9,Pickup_PowerArmor@ha
	la 9,Pickup_PowerArmor@l(9)
	cmpw 0,0,9
	bc 12,2,.L488
.L473:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,2
	bc 12,2,.L476
	lwz 0,4(30)
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L488
.L476:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1
	bc 12,2,.L478
	lwz 0,4(30)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L488
	lis 9,Pickup_Adrenaline@ha
	la 9,Pickup_Adrenaline@l(9)
	cmpw 0,0,9
	bc 12,2,.L488
	lis 9,Pickup_AncientHead@ha
	la 9,Pickup_AncientHead@l(9)
	cmpw 0,0,9
	bc 12,2,.L488
.L478:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8192
	bc 12,2,.L472
	lwz 0,56(30)
	cmpwi 0,0,2
	bc 4,2,.L484
	lwz 3,280(31)
	lis 4,.LC78@ha
	la 4,.LC78@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L488
.L484:
	lwz 3,280(31)
	lis 4,.LC79@ha
	la 4,.LC79@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L488
.L472:
	lis 9,.LC83@ha
	lis 11,coop@ha
	la 9,.LC83@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L485
	lwz 3,280(31)
	lis 4,.LC25@ha
	la 4,.LC25@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L485
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
.L485:
	lis 9,.LC83@ha
	lis 11,coop@ha
	la 9,.LC83@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L486
	lwz 0,56(30)
	andi. 9,0,8
	bc 12,2,.L486
	li 0,0
	stw 0,12(30)
.L486:
	lis 9,.LC83@ha
	lis 11,ctf@ha
	la 9,.LC83@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L487
	lwz 3,280(31)
	lis 4,.LC80@ha
	la 4,.LC80@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L488
	lwz 3,280(31)
	lis 4,.LC81@ha
	la 4,.LC81@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L487
.L488:
	mr 3,31
	bl G_FreeEdict
	b .L464
.L487:
	stw 30,648(31)
	lis 11,level+4@ha
	lis 10,.LC82@ha
	lfs 0,level+4@l(11)
	lis 9,droptofloor@ha
	lfd 13,.LC82@l(10)
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
	bc 12,2,.L489
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L489:
	lfs 12,4(31)
	lis 4,.LC80@ha
	lfs 13,8(31)
	la 4,.LC80@l(4)
	lfs 0,12(31)
	lwz 3,280(31)
	stfs 12,1000(31)
	stfs 13,1004(31)
	stfs 0,1008(31)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L491
	lwz 3,280(31)
	lis 4,.LC81@ha
	la 4,.LC81@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L464
.L491:
	lis 9,CTFFlagSetup@ha
	la 9,CTFFlagSetup@l(9)
	stw 9,436(31)
.L464:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 SpawnItem,.Lfe20-SpawnItem
	.globl itemlist
	.section	".data"
	.align 2
	.type	 itemlist,@object
itemlist:
	.long 0
	.space	80
	.long .LC84
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long .LC85
	.long 0
	.long 0
	.long .LC86
	.long .LC87
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
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
	.long .LC85
	.long 0
	.long 0
	.long .LC93
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC89
	.long .LC94
	.long 1
	.long 0
	.long .LC95
	.long .LC96
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long combatarmor_info
	.long 2
	.long .LC85
	.long 0
	.long 0
	.long .LC97
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC89
	.long .LC98
	.long 1
	.long 0
	.long .LC99
	.long .LC100
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long jacketarmor_info
	.long 1
	.long .LC85
	.long 0
	.long 0
	.long .LC101
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC102
	.long .LC103
	.long 1
	.long 0
	.long .LC99
	.long .LC104
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long 0
	.long 4
	.long .LC85
	.long 0
	.long 0
	.long .LC105
	.long Pickup_PowerScreen
	.long Use_PowerScreen
	.long Drop_PowerScreen
	.long 0
	.long .LC106
	.long .LC107
	.long 1
	.long 0
	.long .LC108
	.long .LC109
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC110
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC106
	.long .LC111
	.long 1
	.long 0
	.long .LC112
	.long .LC113
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC114
	.long 0
	.long 0
	.long .LC115
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Blaster
	.long .LC116
	.long .LC117
	.long 1
	.long .LC118
	.long .LC119
	.long .LC120
	.long 0
	.long 1
	.long .LC10
	.long 9
	.long 1
	.long 0
	.long 0
	.long .LC121
	.long 0
	.long 0
	.long .LC122
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Pistol
	.long .LC116
	.long .LC117
	.long 1
	.long .LC118
	.long .LC119
	.long .LC123
	.long 0
	.long 1
	.long .LC6
	.long 9
	.long 1
	.long 0
	.long 0
	.long .LC121
	.long 0
	.long 0
	.long .LC124
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Flaregun
	.long .LC116
	.long .LC117
	.long 1
	.long .LC118
	.long .LC119
	.long .LC125
	.long 0
	.long 1
	.long .LC7
	.long 9
	.long 1
	.long 0
	.long 0
	.long .LC121
	.long 0
	.long 0
	.long .LC126
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Bucky
	.long .LC116
	.long .LC117
	.long 1
	.long .LC118
	.long .LC119
	.long .LC127
	.long 0
	.long 3
	.long .LC11
	.long 9
	.long 1
	.long 0
	.long 0
	.long .LC128
	.long 0
	.long 0
	.long .LC129
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Shotgun
	.long .LC116
	.long .LC130
	.long 1
	.long .LC131
	.long .LC132
	.long .LC133
	.long 0
	.long 1
	.long .LC7
	.long 9
	.long 2
	.long 0
	.long 0
	.long .LC134
	.long 0
	.long 0
	.long .LC135
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Airfist
	.long .LC116
	.long .LC130
	.long 1
	.long .LC131
	.long .LC132
	.long .LC136
	.long 0
	.long 0
	.long 0
	.long 9
	.long 2
	.long 0
	.long 0
	.long .LC137
	.long 0
	.long 0
	.long .LC138
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_BloodDrainer
	.long .LC116
	.long .LC130
	.long 1
	.long .LC131
	.long .LC132
	.long .LC139
	.long 0
	.long 1
	.long .LC7
	.long 9
	.long 2
	.long 0
	.long 0
	.long .LC140
	.long 1
	.long .LC13
	.long .LC141
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_SuperShotgun
	.long .LC116
	.long .LC142
	.long 1
	.long .LC143
	.long .LC144
	.long .LC145
	.long 0
	.long 2
	.long .LC7
	.long 9
	.long 3
	.long 0
	.long 0
	.long .LC146
	.long 0
	.long 0
	.long .LC147
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_DGSuperShotgun
	.long .LC116
	.long .LC142
	.long 1
	.long .LC143
	.long .LC144
	.long .LC148
	.long 0
	.long 2
	.long .LC11
	.long 9
	.long 3
	.long 0
	.long 0
	.long .LC149
	.long 0
	.long 0
	.long .LC150
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_FlakCannon
	.long .LC116
	.long .LC142
	.long 1
	.long .LC143
	.long .LC144
	.long .LC151
	.long 0
	.long 1
	.long .LC7
	.long 9
	.long 3
	.long 0
	.long 0
	.long .LC149
	.long 5
	.long .LC6
	.long .LC152
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Machinegun
	.long .LC116
	.long .LC153
	.long 1
	.long .LC154
	.long .LC155
	.long .LC156
	.long 0
	.long 1
	.long .LC6
	.long 9
	.long 4
	.long 0
	.long 0
	.long .LC157
	.long 0
	.long 0
	.long .LC158
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_ExplosiveMachinegun
	.long .LC116
	.long .LC153
	.long 1
	.long .LC154
	.long .LC155
	.long .LC159
	.long 0
	.long 1
	.long .LC6
	.long 9
	.long 4
	.long 0
	.long 0
	.long .LC157
	.long 1
	.long .LC12
	.long .LC160
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_PulseRifle
	.long .LC116
	.long .LC153
	.long 1
	.long .LC154
	.long .LC155
	.long .LC161
	.long 0
	.long 3
	.long .LC6
	.long 9
	.long 4
	.long 0
	.long 0
	.long .LC162
	.long 0
	.long 0
	.long .LC163
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Nailgun
	.long .LC116
	.long .LC153
	.long 1
	.long .LC154
	.long .LC155
	.long .LC164
	.long 0
	.long 2
	.long .LC6
	.long 9
	.long 4
	.long 0
	.long 0
	.long .LC165
	.long 0
	.long 0
	.long .LC166
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Chaingun
	.long .LC116
	.long .LC167
	.long 1
	.long .LC168
	.long .LC169
	.long .LC170
	.long 0
	.long 1
	.long .LC6
	.long 9
	.long 5
	.long 0
	.long 0
	.long .LC171
	.long 0
	.long 0
	.long .LC172
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Flamethrower
	.long .LC116
	.long .LC167
	.long 1
	.long .LC168
	.long .LC169
	.long .LC173
	.long 0
	.long 1
	.long .LC12
	.long 9
	.long 5
	.long 0
	.long 0
	.long .LC174
	.long 0
	.long 0
	.long .LC175
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_StreetSweeper
	.long .LC116
	.long .LC167
	.long 1
	.long .LC168
	.long .LC169
	.long .LC176
	.long 0
	.long 1
	.long .LC7
	.long 9
	.long 5
	.long 0
	.long 0
	.long .LC177
	.long 0
	.long 0
	.long .LC178
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_SuperNailgun
	.long .LC116
	.long .LC167
	.long 1
	.long .LC168
	.long .LC169
	.long .LC179
	.long 0
	.long 2
	.long .LC6
	.long 9
	.long 5
	.long 0
	.long 0
	.long .LC180
	.long 0
	.long 0
	.long .LC181
	.long Pickup_Ammo
	.long Use_Weapon
	.long Drop_Ammo
	.long Weapon_Grenade
	.long .LC182
	.long .LC183
	.long 0
	.long .LC184
	.long .LC185
	.long .LC11
	.long 3
	.long 5
	.long .LC186
	.long 3
	.long 6
	.long 0
	.long 3
	.long .LC187
	.long 0
	.long 0
	.long .LC188
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Tripbomb
	.long .LC116
	.long .LC183
	.long 0
	.long .LC184
	.long .LC185
	.long .LC189
	.long 0
	.long 2
	.long .LC11
	.long 9
	.long 6
	.long 0
	.long 3
	.long .LC190
	.long 2
	.long .LC10
	.long .LC191
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_LaserTripbomb
	.long .LC116
	.long .LC183
	.long 0
	.long .LC184
	.long .LC185
	.long .LC192
	.long 0
	.long 1
	.long .LC11
	.long 9
	.long 6
	.long 0
	.long 3
	.long .LC190
	.long 5
	.long .LC10
	.long .LC193
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_GrenadeLauncher
	.long .LC116
	.long .LC194
	.long 1
	.long .LC195
	.long .LC196
	.long .LC197
	.long 0
	.long 1
	.long .LC11
	.long 9
	.long 7
	.long 0
	.long 0
	.long .LC198
	.long 0
	.long 0
	.long .LC199
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_ClusterGrenadeLauncher
	.long .LC116
	.long .LC194
	.long 1
	.long .LC195
	.long .LC196
	.long .LC200
	.long 0
	.long 3
	.long .LC11
	.long 9
	.long 7
	.long 0
	.long 0
	.long .LC198
	.long 0
	.long 0
	.long .LC201
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_BFGrenadeLauncher
	.long .LC116
	.long .LC194
	.long 1
	.long .LC195
	.long .LC196
	.long .LC202
	.long 0
	.long 1
	.long .LC11
	.long 9
	.long 7
	.long 0
	.long 0
	.long .LC198
	.long 20
	.long .LC10
	.long .LC203
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_ProxGrenadeLauncher
	.long .LC116
	.long .LC194
	.long 1
	.long .LC195
	.long .LC196
	.long .LC204
	.long 0
	.long 1
	.long .LC11
	.long 9
	.long 7
	.long 0
	.long 0
	.long .LC198
	.long 2
	.long .LC10
	.long .LC205
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_RailGrenadeLauncher
	.long .LC116
	.long .LC194
	.long 1
	.long .LC195
	.long .LC196
	.long .LC206
	.long 0
	.long 1
	.long .LC11
	.long 9
	.long 7
	.long 0
	.long 0
	.long .LC198
	.long 2
	.long .LC13
	.long .LC207
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_StickingGrenadeLauncher
	.long .LC116
	.long .LC194
	.long 1
	.long .LC195
	.long .LC196
	.long .LC208
	.long 0
	.long 1
	.long .LC11
	.long 9
	.long 7
	.long 0
	.long 0
	.long .LC198
	.long 0
	.long 0
	.long .LC209
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_NapalmGrenadeLauncher
	.long .LC116
	.long .LC194
	.long 1
	.long .LC195
	.long .LC196
	.long .LC210
	.long 0
	.long 2
	.long .LC11
	.long 9
	.long 7
	.long 0
	.long 0
	.long .LC198
	.long 0
	.long 0
	.long .LC211
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_RocketLauncher
	.long .LC116
	.long .LC212
	.long 1
	.long .LC213
	.long .LC214
	.long .LC215
	.long 0
	.long 1
	.long .LC12
	.long 9
	.long 8
	.long 0
	.long 0
	.long .LC216
	.long 0
	.long 0
	.long .LC217
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_NapalmRockets
	.long .LC116
	.long .LC212
	.long 1
	.long .LC213
	.long .LC214
	.long .LC218
	.long 0
	.long 2
	.long .LC12
	.long 9
	.long 8
	.long 0
	.long 0
	.long .LC216
	.long 0
	.long 0
	.long .LC219
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_GuidedMisiles
	.long .LC116
	.long .LC212
	.long 1
	.long .LC213
	.long .LC214
	.long .LC220
	.long 0
	.long 1
	.long .LC12
	.long 9
	.long 8
	.long 0
	.long 0
	.long .LC216
	.long 3
	.long .LC10
	.long .LC221
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Homing
	.long .LC116
	.long .LC212
	.long 1
	.long .LC213
	.long .LC214
	.long .LC222
	.long 0
	.long 1
	.long .LC12
	.long 9
	.long 8
	.long 0
	.long 0
	.long .LC216
	.long 3
	.long .LC10
	.long .LC223
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Perforator
	.long .LC116
	.long .LC212
	.long 1
	.long .LC213
	.long .LC214
	.long .LC224
	.long 0
	.long 1
	.long .LC12
	.long 9
	.long 8
	.long 0
	.long 0
	.long .LC225
	.long 1
	.long .LC13
	.long .LC226
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_HyperBlaster
	.long .LC116
	.long .LC227
	.long 1
	.long .LC228
	.long .LC229
	.long .LC230
	.long 0
	.long 1
	.long .LC10
	.long 9
	.long 9
	.long 0
	.long 0
	.long .LC231
	.long 0
	.long 0
	.long .LC232
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Freezegun
	.long .LC116
	.long .LC227
	.long 1
	.long .LC228
	.long .LC229
	.long .LC233
	.long 0
	.long 1
	.long .LC10
	.long 9
	.long 9
	.long 0
	.long 0
	.long .LC234
	.long 0
	.long 0
	.long .LC235
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Disintegrator
	.long .LC116
	.long .LC227
	.long 1
	.long .LC228
	.long .LC229
	.long .LC236
	.long 0
	.long 1
	.long .LC13
	.long 9
	.long 9
	.long 0
	.long 0
	.long .LC231
	.long 0
	.long 0
	.long .LC237
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_PlasmaGun
	.long .LC116
	.long .LC227
	.long 1
	.long .LC228
	.long .LC229
	.long .LC238
	.long 0
	.long 1
	.long .LC10
	.long 9
	.long 9
	.long 0
	.long 0
	.long .LC239
	.long 0
	.long 0
	.long .LC240
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Railgun
	.long .LC116
	.long .LC241
	.long 1
	.long .LC242
	.long .LC243
	.long .LC244
	.long 0
	.long 1
	.long .LC13
	.long 9
	.long 10
	.long 0
	.long 0
	.long .LC245
	.long 0
	.long 0
	.long .LC246
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_AntimatterCannon
	.long .LC116
	.long .LC241
	.long 1
	.long .LC242
	.long .LC243
	.long .LC247
	.long 0
	.long 3
	.long .LC13
	.long 9
	.long 10
	.long 0
	.long 0
	.long .LC245
	.long 0
	.long 0
	.long .LC248
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_PositronBeam
	.long .LC116
	.long .LC241
	.long 1
	.long .LC242
	.long .LC243
	.long .LC249
	.long 0
	.long 2
	.long .LC13
	.long 9
	.long 10
	.long 0
	.long 0
	.long .LC245
	.long 10
	.long .LC10
	.long .LC250
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_LightningGun
	.long .LC116
	.long .LC241
	.long 1
	.long .LC242
	.long .LC243
	.long .LC251
	.long 0
	.long 1
	.long .LC10
	.long 9
	.long 10
	.long 0
	.long 0
	.long .LC252
	.long 0
	.long 0
	.long .LC79
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_BFG
	.long .LC116
	.long .LC253
	.long 1
	.long .LC254
	.long .LC255
	.long .LC256
	.long 0
	.long 50
	.long .LC10
	.long 9
	.long 11
	.long 0
	.long 0
	.long .LC257
	.long 0
	.long 0
	.long .LC258
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Nuke
	.long .LC116
	.long .LC253
	.long 1
	.long .LC254
	.long .LC255
	.long .LC259
	.long 0
	.long 3
	.long .LC12
	.long 9
	.long 11
	.long 0
	.long 0
	.long .LC257
	.long 3
	.long .LC13
	.long .LC260
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_EnergyVortex
	.long .LC116
	.long .LC253
	.long 1
	.long .LC254
	.long .LC255
	.long .LC261
	.long 0
	.long 100
	.long .LC10
	.long 9
	.long 11
	.long 0
	.long 0
	.long .LC262
	.long 0
	.long 0
	.long .LC263
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_VacuumMaker
	.long .LC116
	.long .LC253
	.long 1
	.long .LC254
	.long .LC255
	.long .LC264
	.long 0
	.long 1
	.long .LC10
	.long 9
	.long 11
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC265
	.long Pickup_Sentry
	.long Use_Sentry
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC267
	.long 1
	.long 0
	.long .LC268
	.long .LC269
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC270
	.long 0
	.long 0
	.long .LC271
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC182
	.long .LC272
	.long 0
	.long 0
	.long .LC273
	.long .LC7
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 1
	.long .LC85
	.long 0
	.long 0
	.long .LC274
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC182
	.long .LC275
	.long 0
	.long 0
	.long .LC276
	.long .LC6
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC277
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC182
	.long .LC278
	.long 0
	.long 0
	.long .LC279
	.long .LC10
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long 4
	.long .LC85
	.long 0
	.long 0
	.long .LC280
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC182
	.long .LC281
	.long 0
	.long 0
	.long .LC282
	.long .LC12
	.long 3
	.long 5
	.long 0
	.long 2
	.long 0
	.long 0
	.long 2
	.long .LC85
	.long 0
	.long 0
	.long .LC283
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC182
	.long .LC284
	.long 0
	.long 0
	.long .LC285
	.long .LC13
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 5
	.long .LC85
	.long 0
	.long 0
	.long .LC286
	.long Pickup_Powerup
	.long Use_Quad
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC287
	.long 524289
	.long 0
	.long .LC288
	.long .LC289
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC290
	.long 0
	.long 0
	.long .LC291
	.long Pickup_Powerup
	.long Use_Invulnerability
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC292
	.long 262145
	.long 0
	.long .LC293
	.long .LC294
	.long 2
	.long 300
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC295
	.long 0
	.long 0
	.long .LC296
	.long Pickup_Powerup
	.long Use_Silencer
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC297
	.long 1
	.long 0
	.long .LC298
	.long .LC299
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC300
	.long Pickup_Powerup
	.long Use_Breather
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC301
	.long 1
	.long 0
	.long .LC302
	.long .LC303
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long 0
	.long .LC304
	.long 0
	.long 0
	.long .LC305
	.long Pickup_Powerup
	.long Use_Envirosuit
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC306
	.long 1
	.long 0
	.long .LC307
	.long .LC308
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long 0
	.long .LC304
	.long 0
	.long 0
	.long .LC309
	.long Pickup_AncientHead
	.long 0
	.long 0
	.long 0
	.long .LC266
	.long .LC310
	.long 1
	.long 0
	.long .LC86
	.long .LC311
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC312
	.long Pickup_Adrenaline
	.long 0
	.long 0
	.long 0
	.long .LC266
	.long .LC313
	.long 1
	.long 0
	.long .LC314
	.long .LC315
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC316
	.long Pickup_Bandolier
	.long 0
	.long 0
	.long 0
	.long .LC266
	.long .LC317
	.long 1
	.long 0
	.long .LC318
	.long .LC319
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC320
	.long Pickup_Pack
	.long 0
	.long 0
	.long 0
	.long .LC266
	.long .LC321
	.long 1
	.long 0
	.long .LC322
	.long .LC323
	.long 2
	.long 180
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC78
	.long Pickup_MediPak
	.long Use_MediPak
	.long Drop_MediPak
	.long 0
	.long .LC33
	.long .LC324
	.long 1
	.long 0
	.long .LC325
	.long .LC326
	.long 2
	.long 100
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC327
	.long Pickup_Key
	.long Use_Flashlight
	.long Drop_General
	.long 0
	.long .LC116
	.long .LC297
	.long 1
	.long 0
	.long .LC328
	.long .LC329
	.long 0
	.long 0
	.long 0
	.long 16
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC330
	.long Pickup_Powerup
	.long Use_IR
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC301
	.long 1
	.long 0
	.long .LC331
	.long .LC332
	.long 2
	.long 60
	.long 0
	.long 32
	.long 800
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC333
	.long Pickup_Jetpak
	.long Use_Jet
	.long Drop_Jetpak
	.long 0
	.long .LC266
	.long .LC334
	.long 1
	.long 0
	.long .LC335
	.long .LC336
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long 0
	.long .LC270
	.long 0
	.long 0
	.long .LC337
	.long Pickup_Powerup
	.long Use_Steroids
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC313
	.long 1
	.long 0
	.long .LC314
	.long .LC338
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC339
	.long Pickup_Powerup
	.long Use_Cloak
	.long Drop_General
	.long 0
	.long .LC266
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
	.long .LC343
	.long 0
	.long 0
	.long .LC344
	.long Pickup_Scanner
	.long Use_Scanner
	.long Drop_Scanner
	.long 0
	.long .LC266
	.long .LC345
	.long 1
	.long 0
	.long .LC346
	.long .LC347
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC348
	.long Pickup_Powerup
	.long Use_Beans
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC349
	.long 1
	.long 0
	.long .LC350
	.long .LC351
	.long 2
	.long 100
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC352
	.long 0
	.long 0
	.long .LC353
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC354
	.long 1
	.long 0
	.long .LC355
	.long .LC356
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC25
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC357
	.long 1
	.long 0
	.long .LC358
	.long .LC359
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC360
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC361
	.long 1
	.long 0
	.long .LC362
	.long .LC363
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC364
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC365
	.long 1
	.long 0
	.long .LC366
	.long .LC367
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC368
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC369
	.long 1
	.long 0
	.long .LC370
	.long .LC371
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC372
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC373
	.long 1
	.long 0
	.long .LC374
	.long .LC375
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC376
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC377
	.long 1
	.long 0
	.long .LC378
	.long .LC379
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC380
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC381
	.long 2
	.long 0
	.long .LC382
	.long .LC383
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC384
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC266
	.long .LC385
	.long 1
	.long 0
	.long .LC386
	.long .LC387
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long .LC388
	.long Pickup_Health
	.long 0
	.long 0
	.long 0
	.long .LC266
	.long .LC324
	.long 0
	.long 0
	.long .LC325
	.long .LC389
	.long 3
	.long 100
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC390
	.long 0
	.long 0
	.long 0
	.long Pickup_Health
	.long 0
	.long 0
	.long 0
	.long .LC266
	.long 0
	.long 0
	.long 0
	.long .LC391
	.long .LC392
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC390
	.long 0
	.long 0
	.long .LC80
	.long CTFPickup_Flag
	.long 0
	.long CTFDrop_Flag
	.long 0
	.long .LC393
	.long .LC394
	.long 262144
	.long 0
	.long .LC395
	.long .LC396
	.long 2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC397
	.long 0
	.long 0
	.long .LC81
	.long CTFPickup_Flag
	.long 0
	.long CTFDrop_Flag
	.long 0
	.long .LC393
	.long .LC398
	.long 524288
	.long 0
	.long .LC399
	.long .LC400
	.long 2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC397
	.long 0
	.long 0
	.long .LC401
	.long CTFPickup_Tech
	.long 0
	.long CTFDrop_Tech
	.long 0
	.long .LC266
	.long .LC402
	.long 1
	.long 0
	.long .LC403
	.long .LC404
	.long 2
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC405
	.long 0
	.long 0
	.long .LC406
	.long CTFPickup_Tech
	.long 0
	.long CTFDrop_Tech
	.long 0
	.long .LC266
	.long .LC407
	.long 1
	.long 0
	.long .LC408
	.long .LC409
	.long 2
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC410
	.long 0
	.long 0
	.long .LC411
	.long CTFPickup_Tech
	.long 0
	.long CTFDrop_Tech
	.long 0
	.long .LC266
	.long .LC412
	.long 1
	.long 0
	.long .LC413
	.long .LC414
	.long 2
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC415
	.long 0
	.long 0
	.long .LC416
	.long CTFPickup_Tech
	.long 0
	.long CTFDrop_Tech
	.long 0
	.long .LC266
	.long .LC417
	.long 1
	.long 0
	.long .LC418
	.long .LC419
	.long 2
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC420
	.long 0
	.long 0
	.long 0
	.space	80
	.section	".rodata"
	.align 2
.LC420:
	.string	"ctf/tech4.wav"
	.align 2
.LC419:
	.string	"AutoDoc"
	.align 2
.LC418:
	.string	"tech4"
	.align 2
.LC417:
	.string	"models/ctf/regeneration/tris.md2"
	.align 2
.LC416:
	.string	"item_tech4"
	.align 2
.LC415:
	.string	"ctf/tech3.wav"
	.align 2
.LC414:
	.string	"Time Accel"
	.align 2
.LC413:
	.string	"tech3"
	.align 2
.LC412:
	.string	"models/ctf/haste/tris.md2"
	.align 2
.LC411:
	.string	"item_tech3"
	.align 2
.LC410:
	.string	"ctf/tech2.wav ctf/tech2x.wav"
	.align 2
.LC409:
	.string	"Power Amplifier"
	.align 2
.LC408:
	.string	"tech2"
	.align 2
.LC407:
	.string	"models/ctf/strength/tris.md2"
	.align 2
.LC406:
	.string	"item_tech2"
	.align 2
.LC405:
	.string	"ctf/tech1.wav"
	.align 2
.LC404:
	.string	"Disruptor Shield"
	.align 2
.LC403:
	.string	"tech1"
	.align 2
.LC402:
	.string	"models/ctf/resistance/tris.md2"
	.align 2
.LC401:
	.string	"item_tech1"
	.align 2
.LC400:
	.string	"Blue Flag"
	.align 2
.LC399:
	.string	"i_ctf2"
	.align 2
.LC398:
	.string	"players/male/flag2.md2"
	.align 2
.LC397:
	.string	"ctf/flagcap.wav"
	.align 2
.LC396:
	.string	"Red Flag"
	.align 2
.LC395:
	.string	"i_ctf1"
	.align 2
.LC394:
	.string	"players/male/flag1.md2"
	.align 2
.LC393:
	.string	"ctf/flagtk.wav"
	.align 2
.LC392:
	.string	"Health"
	.align 2
.LC391:
	.string	"i_health"
	.align 2
.LC390:
	.string	"items/s_health.wav items/n_health.wav items/l_health.wav items/m_health.wav"
	.align 2
.LC389:
	.string	"MegaHealth"
	.align 2
.LC388:
	.string	"item_health_mega"
	.align 2
.LC387:
	.string	"Airstrike Marker"
	.align 2
.LC386:
	.string	"i_airstrike"
	.align 2
.LC385:
	.string	"models/items/keys/target/tris.md2"
	.align 2
.LC384:
	.string	"key_airstrike_target"
	.align 2
.LC383:
	.string	"Commander's Head"
	.align 2
.LC382:
	.string	"k_comhead"
	.align 2
.LC381:
	.string	"models/monsters/commandr/head/tris.md2"
	.align 2
.LC380:
	.string	"key_commander_head"
	.align 2
.LC379:
	.string	"Red Key"
	.align 2
.LC378:
	.string	"k_redkey"
	.align 2
.LC377:
	.string	"models/items/keys/red_key/tris.md2"
	.align 2
.LC376:
	.string	"key_red_key"
	.align 2
.LC375:
	.string	"Blue Key"
	.align 2
.LC374:
	.string	"k_bluekey"
	.align 2
.LC373:
	.string	"models/items/keys/key/tris.md2"
	.align 2
.LC372:
	.string	"key_blue_key"
	.align 2
.LC371:
	.string	"Security Pass"
	.align 2
.LC370:
	.string	"k_security"
	.align 2
.LC369:
	.string	"models/items/keys/pass/tris.md2"
	.align 2
.LC368:
	.string	"key_pass"
	.align 2
.LC367:
	.string	"Data Spinner"
	.align 2
.LC366:
	.string	"k_dataspin"
	.align 2
.LC365:
	.string	"models/items/keys/spinner/tris.md2"
	.align 2
.LC364:
	.string	"key_data_spinner"
	.align 2
.LC363:
	.string	"Pyramid Key"
	.align 2
.LC362:
	.string	"k_pyramid"
	.align 2
.LC361:
	.string	"models/items/keys/pyramid/tris.md2"
	.align 2
.LC360:
	.string	"key_pyramid"
	.align 2
.LC359:
	.string	"Power Cube"
	.align 2
.LC358:
	.string	"k_powercube"
	.align 2
.LC357:
	.string	"models/items/keys/power/tris.md2"
	.align 2
.LC356:
	.string	"Data CD"
	.align 2
.LC355:
	.string	"k_datacd"
	.align 2
.LC354:
	.string	"models/items/keys/data_cd/tris.md2"
	.align 2
.LC353:
	.string	"key_data_cd"
	.align 2
.LC352:
	.string	"copb/copb_1.wav copb/copb_2.wav copb/copb_3.wav copb/copb_4.wav copb/copb_5.wav"
	.align 2
.LC351:
	.string	"Beans"
	.align 2
.LC350:
	.string	"p_copb"
	.align 2
.LC349:
	.string	"models/copb/beans.md2"
	.align 2
.LC348:
	.string	"item_beans"
	.align 2
.LC347:
	.string	"Scanner"
	.align 2
.LC346:
	.string	"p_scanner"
	.align 2
.LC345:
	.string	"models/scanner/radar.md2"
	.align 2
.LC344:
	.string	"item_scanner"
	.align 2
.LC343:
	.string	"cloak/activate.wav cloak/off.wav cloak/running.wav"
	.align 2
.LC342:
	.string	"Cloaker"
	.align 2
.LC341:
	.string	"p_cloak"
	.align 2
.LC340:
	.string	"models/items/cloak/tris.md2"
	.align 2
.LC339:
	.string	"item_cloaker"
	.align 2
.LC338:
	.string	"Steroids"
	.align 2
.LC337:
	.string	"item_steroids"
	.align 2
.LC336:
	.string	"Jetpack"
	.align 2
.LC335:
	.string	"p_jetpack"
	.align 2
.LC334:
	.string	"models/items/jet/tris.md2"
	.align 2
.LC333:
	.string	"item_jet"
	.align 2
.LC332:
	.string	"IR Goggles"
	.align 2
.LC331:
	.string	"p_goggles"
	.align 2
.LC330:
	.string	"item_ir_goggles"
	.align 2
.LC329:
	.string	"Flashlight"
	.align 2
.LC328:
	.string	"a_blaster"
	.align 2
.LC327:
	.string	"item_flashlight"
	.align 2
.LC326:
	.string	"MediPak"
	.align 2
.LC325:
	.string	"p_megahealth"
	.align 2
.LC324:
	.string	"models/items/mega_h/tris.md2"
	.align 2
.LC323:
	.string	"Ammo Pack"
	.align 2
.LC322:
	.string	"i_pack"
	.align 2
.LC321:
	.string	"models/items/pack/tris.md2"
	.align 2
.LC320:
	.string	"item_pack"
	.align 2
.LC319:
	.string	"Bandolier"
	.align 2
.LC318:
	.string	"p_bandolier"
	.align 2
.LC317:
	.string	"models/items/band/tris.md2"
	.align 2
.LC316:
	.string	"item_bandolier"
	.align 2
.LC315:
	.string	"Adrenaline"
	.align 2
.LC314:
	.string	"p_adrenaline"
	.align 2
.LC313:
	.string	"models/items/adrenal/tris.md2"
	.align 2
.LC312:
	.string	"item_adrenaline"
	.align 2
.LC311:
	.string	"Ancient Head"
	.align 2
.LC310:
	.string	"models/items/c_head/tris.md2"
	.align 2
.LC309:
	.string	"item_ancient_head"
	.align 2
.LC308:
	.string	"Environment Suit"
	.align 2
.LC307:
	.string	"p_envirosuit"
	.align 2
.LC306:
	.string	"models/items/enviro/tris.md2"
	.align 2
.LC305:
	.string	"item_enviro"
	.align 2
.LC304:
	.string	"items/airout.wav"
	.align 2
.LC303:
	.string	"Rebreather"
	.align 2
.LC302:
	.string	"p_rebreather"
	.align 2
.LC301:
	.string	"models/items/breather/tris.md2"
	.align 2
.LC300:
	.string	"item_breather"
	.align 2
.LC299:
	.string	"Silencer"
	.align 2
.LC298:
	.string	"p_silencer"
	.align 2
.LC297:
	.string	"models/items/silencer/tris.md2"
	.align 2
.LC296:
	.string	"item_silencer"
	.align 2
.LC295:
	.string	"items/protect.wav items/protect2.wav items/protect4.wav"
	.align 2
.LC294:
	.string	"Invulnerability"
	.align 2
.LC293:
	.string	"p_invulnerability"
	.align 2
.LC292:
	.string	"models/items/invulner/tris.md2"
	.align 2
.LC291:
	.string	"item_invulnerability"
	.align 2
.LC290:
	.string	"items/damage.wav items/damage2.wav items/damage3.wav"
	.align 2
.LC289:
	.string	"Quad Damage"
	.align 2
.LC288:
	.string	"p_quad"
	.align 2
.LC287:
	.string	"models/items/quaddama/tris.md2"
	.align 2
.LC286:
	.string	"item_quad"
	.align 2
.LC285:
	.string	"a_slugs"
	.align 2
.LC284:
	.string	"models/items/ammo/slugs/medium/tris.md2"
	.align 2
.LC283:
	.string	"ammo_slugs"
	.align 2
.LC282:
	.string	"a_rockets"
	.align 2
.LC281:
	.string	"models/items/ammo/rockets/medium/tris.md2"
	.align 2
.LC280:
	.string	"ammo_rockets"
	.align 2
.LC279:
	.string	"a_cells"
	.align 2
.LC278:
	.string	"models/items/ammo/cells/medium/tris.md2"
	.align 2
.LC277:
	.string	"ammo_cells"
	.align 2
.LC276:
	.string	"a_bullets"
	.align 2
.LC275:
	.string	"models/items/ammo/bullets/medium/tris.md2"
	.align 2
.LC274:
	.string	"ammo_bullets"
	.align 2
.LC273:
	.string	"a_shells"
	.align 2
.LC272:
	.string	"models/items/ammo/shells/medium/tris.md2"
	.align 2
.LC271:
	.string	"ammo_shells"
	.align 2
.LC270:
	.string	"hover/hovidle1.wav items/damage.wav items/damage2.wav items/damage3.wav"
	.align 2
.LC269:
	.string	"Auto Sentry"
	.align 2
.LC268:
	.string	"p_sentry"
	.align 2
.LC267:
	.string	"models/items/lturret/tris.md2"
	.align 2
.LC266:
	.string	"items/pkup.wav"
	.align 2
.LC265:
	.string	"item_sentry"
	.align 2
.LC264:
	.string	"Vacuum Maker"
	.align 2
.LC263:
	.string	"weapon_vacuummaker"
	.align 2
.LC262:
	.string	"models/items/keys/pyramid/tris.md2 grav_new.wav "
	.align 2
.LC261:
	.string	"Energy Vortex"
	.align 2
.LC260:
	.string	"weapon_energyvortex"
	.align 2
.LC259:
	.string	"Nuke"
	.align 2
.LC258:
	.string	"weapon_nuke"
	.align 2
.LC257:
	.string	"sprites/s_bfg1.sp2 sprites/s_bfg2.sp2 sprites/s_bfg3.sp2 weapons/bfg__f1y.wav weapons/bfg__l1a.wav weapons/bfg__x1b.wav weapons/bfg_hum.wav"
	.align 2
.LC256:
	.string	"BFG10K"
	.align 2
.LC255:
	.string	"w_bfg"
	.align 2
.LC254:
	.string	"models/weapons/v_bfg/tris.md2"
	.align 2
.LC253:
	.string	"models/weapons/g_bfg/tris.md2"
	.align 2
.LC252:
	.string	"light/lhit.wav light/lstart.wav"
	.align 2
.LC251:
	.string	"Lightning Gun"
	.align 2
.LC250:
	.string	"weapon_lightninggun"
	.align 2
.LC249:
	.string	"Positron Beam"
	.align 2
.LC248:
	.string	"weapon_positron"
	.align 2
.LC247:
	.string	"Antimatter Cannon"
	.align 2
.LC246:
	.string	"weapon_asha"
	.align 2
.LC245:
	.string	"weapons/rg_hum.wav"
	.align 2
.LC244:
	.string	"Railgun"
	.align 2
.LC243:
	.string	"w_railgun"
	.align 2
.LC242:
	.string	"models/weapons/v_rail/tris.md2"
	.align 2
.LC241:
	.string	"models/weapons/g_rail/tris.md2"
	.align 2
.LC240:
	.string	"weapon_railgun"
	.align 2
.LC239:
	.string	"weapons/hyprbu1a.wav weapons/hyprbl1a.wav weapons/hyprbf1a.wav weapons/hyprbd1a.wav weapons/plasexpl.wav weapons/plasma.wav models/objects/pbullet/tris.md2"
	.align 2
.LC238:
	.string	"Plasma Gun"
	.align 2
.LC237:
	.string	"weapon_plasmagun"
	.align 2
.LC236:
	.string	"Disruptor"
	.align 2
.LC235:
	.string	"weapon_disintegrator"
	.align 2
.LC234:
	.string	"weapons/hyprbu1a.wav weapons/hyprbl1a.wav weapons/hyprbf1a.wav weapons/hyprbd1a.wav misc/lasfly.wav weapons/frozen.wav"
	.align 2
.LC233:
	.string	"Freezegun"
	.align 2
.LC232:
	.string	"weapon_freezegun"
	.align 2
.LC231:
	.string	"weapons/hyprbu1a.wav weapons/hyprbl1a.wav weapons/hyprbf1a.wav weapons/hyprbd1a.wav misc/lasfly.wav"
	.align 2
.LC230:
	.string	"HyperBlaster"
	.align 2
.LC229:
	.string	"w_hyperblaster"
	.align 2
.LC228:
	.string	"models/weapons/v_hyperb/tris.md2"
	.align 2
.LC227:
	.string	"models/weapons/g_hyperb/tris.md2"
	.align 2
.LC226:
	.string	"weapon_hyperblaster"
	.align 2
.LC225:
	.string	"models/objects/rocket/tris.md2 weapons/rockfly.wav weapons/rocklf1a.wav weapons/rocklr1b.wav models/objects/debris2/tris.md2smack.wav"
	.align 2
.LC224:
	.string	"Perforating Rockets"
	.align 2
.LC223:
	.string	"weapon_perforator"
	.align 2
.LC222:
	.string	"Homing Rockets"
	.align 2
.LC221:
	.string	"weapon_homing"
	.align 2
.LC220:
	.string	"Guided Misiles"
	.align 2
.LC219:
	.string	"weapon_guided"
	.align 2
.LC218:
	.string	"Napalm Rockets"
	.align 2
.LC217:
	.string	"weapon_napalmrockets"
	.align 2
.LC216:
	.string	"models/objects/rocket/tris.md2 weapons/rockfly.wav weapons/rocklf1a.wav weapons/rocklr1b.wav models/objects/debris2/tris.md2"
	.align 2
.LC215:
	.string	"Rocket Launcher"
	.align 2
.LC214:
	.string	"w_rlauncher"
	.align 2
.LC213:
	.string	"models/weapons/v_rocket/tris.md2"
	.align 2
.LC212:
	.string	"models/weapons/g_rocket/tris.md2"
	.align 2
.LC211:
	.string	"weapon_rocketlauncher"
	.align 2
.LC210:
	.string	"Napalm Grenades"
	.align 2
.LC209:
	.string	"weapon_napalmgrenadelauncher"
	.align 2
.LC208:
	.string	"Sticking Grenades"
	.align 2
.LC207:
	.string	"weapon_stickinggrenadelauncher"
	.align 2
.LC206:
	.string	"Rail Grenades"
	.align 2
.LC205:
	.string	"weapon_railgrenadelauncher"
	.align 2
.LC204:
	.string	"Proximity Grenades"
	.align 2
.LC203:
	.string	"weapon_proxgrenadelauncher"
	.align 2
.LC202:
	.string	"BFG Grenades"
	.align 2
.LC201:
	.string	"weapon_bfgrenadelauncher"
	.align 2
.LC200:
	.string	"Cluster Grenades"
	.align 2
.LC199:
	.string	"weapon_clustergrenadelauncher"
	.align 2
.LC198:
	.string	"models/objects/grenade/tris.md2 weapons/grenlf1a.wav weapons/grenlr1b.wav weapons/grenlb1b.wav"
	.align 2
.LC197:
	.string	"Grenade Launcher"
	.align 2
.LC196:
	.string	"w_glauncher"
	.align 2
.LC195:
	.string	"models/weapons/v_launch/tris.md2"
	.align 2
.LC194:
	.string	"models/weapons/g_launch/tris.md2"
	.align 2
.LC193:
	.string	"weapon_grenadelauncher"
	.align 2
.LC192:
	.string	"Laser Tripbombs"
	.align 2
.LC191:
	.string	"weapon_lasertripbomb"
	.align 2
.LC190:
	.string	"lsrbmb.wav lsrbmbpt.wav "
	.align 2
.LC189:
	.string	"Tripbombs"
	.align 2
.LC188:
	.string	"weapon_tripbomb"
	.align 2
.LC187:
	.string	"weapons/hgrent1a.wav weapons/hgrena1b.wav weapons/hgrenc1b.wav weapons/hgrenb1a.wav weapons/hgrenb2a.wav "
	.align 2
.LC186:
	.string	"grenades"
	.align 2
.LC185:
	.string	"a_grenades"
	.align 2
.LC184:
	.string	"models/weapons/v_handgr/tris.md2"
	.align 2
.LC183:
	.string	"models/items/ammo/grenades/medium/tris.md2"
	.align 2
.LC182:
	.string	"misc/am_pkup.wav"
	.align 2
.LC181:
	.string	"ammo_grenades"
	.align 2
.LC180:
	.string	"models/nail/tris.md2 weapons/chngnu1a.wav weapons/chngnl1a.wav weapons/machgf3b.wav` weapons/chngnd1a.wav"
	.align 2
.LC179:
	.string	"Super Nailgun"
	.align 2
.LC178:
	.string	"weapon_supernailgun"
	.align 2
.LC177:
	.string	"models/shell/tris.md2 weapons/chngnu1a.wav weapons/chngnl1a.wav weapons/machgf3b.wav` weapons/chngnd1a.wav"
	.align 2
.LC176:
	.string	"Street Sweeper"
	.align 2
.LC175:
	.string	"weapon_streetsweeper"
	.align 2
.LC174:
	.string	"weapons/chngnu1a.wav weapons/chngnl1a.wav weapons/machgf3b.wav` weapons/chngnd1a.wav"
	.align 2
.LC173:
	.string	"FlameThrower"
	.align 2
.LC172:
	.string	"weapon_flamethrower"
	.align 2
.LC171:
	.string	"weapons/chngnu1a.wav weapons/chngnl1a.wav weapons/machgf3b.wav weapons/chngnd1a.wav"
	.align 2
.LC170:
	.string	"Chaingun"
	.align 2
.LC169:
	.string	"w_chaingun"
	.align 2
.LC168:
	.string	"models/weapons/v_chain/tris.md2"
	.align 2
.LC167:
	.string	"models/weapons/g_chain/tris.md2"
	.align 2
.LC166:
	.string	"weapon_chaingun"
	.align 2
.LC165:
	.string	"models/nail/tris.md2 weapons/machgf1b.wav weapons/machgf2b.wav weapons/machgf3b.wav weapons/machgf4b.wav weapons/machgf5b.wav"
	.align 2
.LC164:
	.string	"Nailgun"
	.align 2
.LC163:
	.string	"weapon_nailgun"
	.align 2
.LC162:
	.string	"models/nail/tris.md2 weapons/machgf1b.wav weapons/machgf2b.wav weapons/machgf3b.wav weapons/machgf4b.wav weapons/machgf5b.wav weapons/pulse1.wav"
	.align 2
.LC161:
	.string	"Pulse Rifle"
	.align 2
.LC160:
	.string	"weapon_pulserifle"
	.align 2
.LC159:
	.string	"Explosive Machinegun"
	.align 2
.LC158:
	.string	"weapon_explosive_machinegun"
	.align 2
.LC157:
	.string	"weapons/machgf1b.wav weapons/machgf2b.wav weapons/machgf3b.wav weapons/machgf4b.wav weapons/machgf5b.wav"
	.align 2
.LC156:
	.string	"Machinegun"
	.align 2
.LC155:
	.string	"w_machinegun"
	.align 2
.LC154:
	.string	"models/weapons/v_machn/tris.md2"
	.align 2
.LC153:
	.string	"models/weapons/g_machn/tris.md2"
	.align 2
.LC152:
	.string	"weapon_machinegun"
	.align 2
.LC151:
	.string	"Flak Cannon"
	.align 2
.LC150:
	.string	"weapon_flakcannon"
	.align 2
.LC149:
	.string	"weapons/sshotf1b.wav"
	.align 2
.LC148:
	.string	"Double Impact"
	.align 2
.LC147:
	.string	"weapon_doubleimpact"
	.align 2
.LC146:
	.string	"models/shell/tris.md2 weapons/sshotf1b.wav"
	.align 2
.LC145:
	.string	"Super Shotgun"
	.align 2
.LC144:
	.string	"w_sshotgun"
	.align 2
.LC143:
	.string	"models/weapons/v_shotg2/tris.md2"
	.align 2
.LC142:
	.string	"models/weapons/g_shotg2/tris.md2"
	.align 2
.LC141:
	.string	"weapon_supershotgun"
	.align 2
.LC140:
	.string	"weapons/shotgf1b.wav weapons/shotgr1b.wav drainer/drain.wav"
	.align 2
.LC139:
	.string	"Blood Drainer"
	.align 2
.LC138:
	.string	"weapon_blooddrainer"
	.align 2
.LC137:
	.string	"weapons/shotgf1b.wav weapons/shotgr1b.wav"
	.align 2
.LC136:
	.string	"Airfist"
	.align 2
.LC135:
	.string	"weapon_airfist"
	.align 2
.LC134:
	.string	"models/shell/tris.md2 weapons/shotgf1b.wav weapons/shotgr1b.wav"
	.align 2
.LC133:
	.string	"Shotgun"
	.align 2
.LC132:
	.string	"w_shotgun"
	.align 2
.LC131:
	.string	"models/weapons/v_shotg/tris.md2"
	.align 2
.LC130:
	.string	"models/weapons/g_shotg/tris.md2"
	.align 2
.LC129:
	.string	"weapon_shotgun"
	.align 2
.LC128:
	.string	"bucky.wav weapons/blastf1a.wav misc/lasfly.wav"
	.align 2
.LC127:
	.string	"BuckyBall Gun"
	.align 2
.LC126:
	.string	"weapon_bucky"
	.align 2
.LC125:
	.string	"Flaregun"
	.align 2
.LC124:
	.string	"weapon_flaregun"
	.align 2
.LC123:
	.string	"Pistol"
	.align 2
.LC122:
	.string	"weapon_pistol"
	.align 2
.LC121:
	.string	"weapons/blastf1a.wav misc/lasfly.wav"
	.align 2
.LC120:
	.string	"Blaster"
	.align 2
.LC119:
	.string	"w_blaster"
	.align 2
.LC118:
	.string	"models/weapons/v_blast/tris.md2"
	.align 2
.LC117:
	.string	"models/weapons/g_blast/tris.md2"
	.align 2
.LC116:
	.string	"misc/w_pkup.wav"
	.align 2
.LC115:
	.string	"weapon_blaster"
	.align 2
.LC114:
	.string	"misc/power2.wav misc/power1.wav"
	.align 2
.LC113:
	.string	"Power Shield"
	.align 2
.LC112:
	.string	"i_powershield"
	.align 2
.LC111:
	.string	"models/items/armor/shield/tris.md2"
	.align 2
.LC110:
	.string	"item_power_shield"
	.align 2
.LC109:
	.string	"Power Screen"
	.align 2
.LC108:
	.string	"i_powerscreen"
	.align 2
.LC107:
	.string	"models/items/armor/screen/tris.md2"
	.align 2
.LC106:
	.string	"misc/ar3_pkup.wav"
	.align 2
.LC105:
	.string	"item_power_screen"
	.align 2
.LC104:
	.string	"Armor Shard"
	.align 2
.LC103:
	.string	"models/items/armor/shard/tris.md2"
	.align 2
.LC102:
	.string	"misc/ar2_pkup.wav"
	.align 2
.LC101:
	.string	"item_armor_shard"
	.align 2
.LC100:
	.string	"Jacket Armor"
	.align 2
.LC99:
	.string	"i_jacketarmor"
	.align 2
.LC98:
	.string	"models/items/armor/jacket/tris.md2"
	.align 2
.LC97:
	.string	"item_armor_jacket"
	.align 2
.LC96:
	.string	"Combat Armor"
	.align 2
.LC95:
	.string	"i_combatarmor"
	.align 2
.LC94:
	.string	"models/items/armor/combat/tris.md2"
	.align 2
.LC93:
	.string	"item_armor_combat"
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
	.align 2
.LC87:
	.string	"NO item"
	.align 2
.LC86:
	.string	"i_fixme"
	.align 2
.LC85:
	.string	""
	.align 2
.LC84:
	.string	"item_null"
	.size	 itemlist,7896
	.align 2
.LC421:
	.string	"models/items/healing/medium/tris.md2"
	.align 2
.LC422:
	.string	"models/items/healing/stimpack/tris.md2"
	.align 2
.LC423:
	.string	"models/items/healing/large/tris.md2"
	.align 2
.LC424:
	.string	"Jetpak"
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
	bc 4,0,.L554
	lis 11,itemlist@ha
	lis 9,gi@ha
	la 11,itemlist@l(11)
	la 28,gi@l(9)
	mr 29,10
	addi 30,11,40
.L556:
	lwz 9,24(28)
	addi 3,31,1056
	lwz 4,0(30)
	addi 31,31,1
	mtlr 9
	addi 30,30,84
	blrl
	lwz 0,1556(29)
	cmpw 0,31,0
	bc 12,0,.L556
.L554:
	lis 9,game@ha
	lis 11,jacket_armor_index@ha
	la 10,game@l(9)
	li 30,0
	lwz 0,1556(10)
	la 27,jacket_armor_index@l(11)
	lis 9,.LC100@ha
	lis 11,itemlist@ha
	la 28,.LC100@l(9)
	cmpw 0,30,0
	la 31,itemlist@l(11)
	bc 4,0,.L565
	mr 29,10
.L560:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L562
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L562
	mr 11,31
	b .L564
.L562:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L560
.L565:
	li 11,0
.L564:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x3cf3
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,53053
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,combat_armor_index@ha
	lis 10,.LC96@ha
	la 26,combat_armor_index@l(9)
	srawi 11,11,2
	la 28,.LC96@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L573
	mr 29,7
.L568:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L570
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L570
	mr 11,31
	b .L572
.L570:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L568
.L573:
	li 11,0
.L572:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x3cf3
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,53053
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
	bc 4,0,.L581
	mr 29,7
.L576:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L578
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L578
	mr 11,31
	b .L580
.L578:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L576
.L581:
	li 11,0
.L580:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x3cf3
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,53053
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,power_screen_index@ha
	lis 10,.LC109@ha
	la 26,power_screen_index@l(9)
	srawi 11,11,2
	la 28,.LC109@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L589
	mr 29,7
.L584:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L586
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L586
	mr 11,31
	b .L588
.L586:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L584
.L589:
	li 11,0
.L588:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x3cf3
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,53053
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,power_shield_index@ha
	lis 10,.LC113@ha
	la 27,power_shield_index@l(9)
	srawi 11,11,2
	la 28,.LC113@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L597
	mr 29,7
.L592:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L594
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L594
	mr 11,31
	b .L596
.L594:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L592
.L597:
	li 11,0
.L596:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x3cf3
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,53053
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,tech_resistance_index@ha
	lis 10,.LC401@ha
	la 26,tech_resistance_index@l(9)
	srawi 11,11,2
	la 28,.LC401@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L605
	mr 29,7
.L600:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L602
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L602
	mr 11,31
	b .L604
.L602:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L600
.L605:
	li 11,0
.L604:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x3cf3
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,53053
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,tech_strength_index@ha
	lis 10,.LC406@ha
	la 27,tech_strength_index@l(9)
	srawi 11,11,2
	la 28,.LC406@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L613
	mr 29,7
.L608:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L610
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L610
	mr 11,31
	b .L612
.L610:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L608
.L613:
	li 11,0
.L612:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x3cf3
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,53053
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,tech_haste_index@ha
	lis 10,.LC411@ha
	la 26,tech_haste_index@l(9)
	srawi 11,11,2
	la 28,.LC411@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L621
	mr 29,7
.L616:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L618
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L618
	mr 11,31
	b .L620
.L618:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L616
.L621:
	li 11,0
.L620:
	lis 9,game@ha
	lis 8,itemlist@ha
	la 7,game@l(9)
	la 8,itemlist@l(8)
	lis 0,0x3cf3
	lwz 10,1556(7)
	subf 11,8,11
	ori 0,0,53053
	li 30,0
	mullw 11,11,0
	cmpw 0,30,10
	lis 9,tech_regeneration_index@ha
	lis 10,.LC416@ha
	la 27,tech_regeneration_index@l(9)
	srawi 11,11,2
	la 28,.LC416@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L629
	mr 29,7
.L624:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L626
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L626
	mr 8,31
	b .L628
.L626:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L624
.L629:
	li 8,0
.L628:
	lis 9,itemlist@ha
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,8
	mullw 9,9,0
	srawi 9,9,2
	stw 9,0(27)
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 SetItemNames,.Lfe21-SetItemNames
	.section	".rodata"
	.align 2
.LC425:
	.long 0x0
	.align 2
.LC426:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl Pickup_MediPak
	.type	 Pickup_MediPak,@function
Pickup_MediPak:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 7,3
	lis 9,itemlist@ha
	lwz 0,648(7)
	la 6,itemlist@l(9)
	lis 10,0x3cf3
	ori 10,10,53053
	lwz 9,84(4)
	subf 0,6,0
	mullw 0,0,10
	addi 9,9,740
	rlwinm 8,0,0,0,29
	lwzx 11,9,8
	cmpwi 0,11,199
	bc 4,1,.L631
	li 3,0
	b .L635
.L631:
	lwz 0,532(7)
	add 0,11,0
	stwx 0,9,8
	lwz 9,648(7)
	lwz 11,84(4)
	subf 9,6,9
	mullw 9,9,10
	addi 4,11,740
	rlwinm 9,9,0,0,29
	lwzx 0,4,9
	cmpwi 0,0,200
	bc 4,1,.L632
	li 0,200
	stwx 0,4,9
.L632:
	lis 9,.LC425@ha
	lis 11,deathmatch@ha
	la 9,.LC425@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L633
	lwz 9,264(7)
	li 10,0
	lis 11,.LC426@ha
	lwz 0,184(7)
	la 11,.LC426@l(11)
	lis 8,level+4@ha
	oris 9,9,0x8000
	stw 10,248(7)
	mr 3,7
	ori 0,0,1
	stw 9,264(7)
	lis 10,gi+72@ha
	stw 0,184(7)
	lfs 0,level+4@l(8)
	lfs 13,0(11)
	lis 11,DoRespawn@ha
	la 11,DoRespawn@l(11)
	fadds 0,0,13
	stw 11,436(7)
	stfs 0,428(7)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
.L633:
	li 3,1
.L635:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 Pickup_MediPak,.Lfe22-Pickup_MediPak
	.section	".rodata"
	.align 2
.LC427:
	.long 0x0
	.align 2
.LC428:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl Pickup_Jetpak
	.type	 Pickup_Jetpak,@function
Pickup_Jetpak:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 7,3
	lis 9,itemlist@ha
	lwz 0,648(7)
	la 3,itemlist@l(9)
	lis 10,0x3cf3
	ori 10,10,53053
	lwz 9,84(4)
	subf 0,3,0
	mullw 0,0,10
	addi 5,9,740
	rlwinm 6,0,0,0,29
	lwzx 8,5,6
	cmpwi 0,8,799
	bc 4,1,.L637
	li 3,0
	b .L642
.L637:
	lwz 0,532(7)
	srawi 11,0,31
	xor 9,11,0
	subf 9,9,11
	srawi 9,9,31
	nor 11,9,9
	and 0,0,9
	andi. 11,11,800
	or 0,0,11
	add 0,8,0
	stwx 0,5,6
	lwz 9,648(7)
	lwz 11,84(4)
	subf 9,3,9
	mullw 9,9,10
	addi 4,11,740
	rlwinm 9,9,0,0,29
	lwzx 0,4,9
	cmpwi 0,0,800
	bc 4,1,.L639
	li 0,800
	stwx 0,4,9
.L639:
	lis 9,.LC427@ha
	lis 11,deathmatch@ha
	la 9,.LC427@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L640
	lwz 9,264(7)
	li 10,0
	lis 11,.LC428@ha
	lwz 0,184(7)
	la 11,.LC428@l(11)
	lis 8,level+4@ha
	oris 9,9,0x8000
	stw 10,248(7)
	mr 3,7
	ori 0,0,1
	stw 9,264(7)
	lis 10,gi+72@ha
	stw 0,184(7)
	lfs 0,level+4@l(8)
	lfs 13,0(11)
	lis 11,DoRespawn@ha
	la 11,DoRespawn@l(11)
	fadds 0,0,13
	stw 11,436(7)
	stfs 0,428(7)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
.L640:
	li 3,1
.L642:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 Pickup_Jetpak,.Lfe23-Pickup_Jetpak
	.section	".rodata"
	.align 2
.LC429:
	.string	"You cannot use the Jetpack on a turret!\n"
	.align 2
.LC431:
	.string	"hover/hovidle1.wav"
	.align 2
.LC430:
	.long 0x3f4ccccd
	.align 2
.LC432:
	.long 0x3f800000
	.align 2
.LC433:
	.long 0x0
	.align 3
.LC434:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Use_Jet
	.type	 Use_Jet,@function
Use_Jet:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 30,3
	lwz 9,84(30)
	lwz 0,3964(9)
	cmpwi 0,0,0
	bc 12,2,.L651
	lis 9,gi+8@ha
	lis 5,.LC429@ha
	lwz 0,gi+8@l(9)
	la 5,.LC429@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L650
.L651:
	lis 29,gi@ha
	lis 3,.LC20@ha
	la 29,gi@l(29)
	la 3,.LC20@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC430@ha
	lwz 0,16(29)
	lis 11,.LC433@ha
	lfs 1,.LC430@l(9)
	mr 5,3
	la 11,.LC433@l(11)
	lis 9,.LC432@ha
	mr 3,30
	lfs 3,0(11)
	mtlr 0
	la 9,.LC432@l(9)
	li 4,3
	lfs 2,0(9)
	blrl
	mr 3,30
	bl Jet_Active
	cmpwi 0,3,0
	bc 12,2,.L652
	lwz 9,84(30)
	li 0,0
	stw 0,3996(9)
	b .L650
.L662:
	mr 11,29
	b .L660
.L652:
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lis 11,.LC336@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC336@l(11)
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L661
	mr 28,10
.L656:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L658
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L662
.L658:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,84
	cmpw 0,31,0
	bc 12,0,.L656
.L661:
	li 11,0
.L660:
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 6,84(30)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,11
	addi 8,6,740
	mullw 9,9,0
	lis 11,level@ha
	lwz 0,level@l(11)
	lis 7,0x4330
	lis 29,gi@ha
	lis 11,.LC434@ha
	rlwinm 9,9,0,0,29
	la 11,.LC434@l(11)
	la 29,gi@l(29)
	lfd 13,0(11)
	lis 3,.LC431@ha
	lwzx 11,8,9
	la 3,.LC431@l(3)
	add 0,0,11
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 7,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,3996(6)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC430@ha
	lwz 0,16(29)
	lis 11,.LC433@ha
	lfs 1,.LC430@l(9)
	mr 5,3
	la 11,.LC433@l(11)
	lis 9,.LC432@ha
	mr 3,30
	lfs 3,0(11)
	mtlr 0
	la 9,.LC432@l(9)
	li 4,0
	lfs 2,0(9)
	blrl
.L650:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe24:
	.size	 Use_Jet,.Lfe24-Use_Jet
	.section	".rodata"
	.align 2
.LC435:
	.string	"You're using it!!\n"
	.align 2
.LC436:
	.long 0x3f4ccccd
	.align 3
.LC437:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC438:
	.long 0x43960000
	.align 2
.LC439:
	.long 0x3f800000
	.align 2
.LC440:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_Steroids
	.type	 Use_Steroids,@function
Use_Steroids:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,itemlist@ha
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	mr 31,3
	subf 4,9,4
	ori 0,0,53053
	lwz 11,84(31)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC437@ha
	lis 11,level@ha
	lwz 10,84(31)
	la 9,.LC437@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3896(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L666
	lis 9,.LC438@ha
	la 9,.LC438@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L668
.L666:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L668:
	stfs 0,3896(10)
	lis 29,gi@ha
	lis 3,.LC34@ha
	la 29,gi@l(29)
	la 3,.LC34@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC436@ha
	lwz 0,16(29)
	mr 5,3
	lfs 1,.LC436@l(9)
	mr 3,31
	li 4,3
	lis 9,.LC439@ha
	mtlr 0
	la 9,.LC439@l(9)
	lfs 2,0(9)
	lis 9,.LC440@ha
	la 9,.LC440@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe25:
	.size	 Use_Steroids,.Lfe25-Use_Steroids
	.section	".rodata"
	.align 2
.LC441:
	.string	"cloak/activate.wav"
	.align 3
.LC442:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC443:
	.long 0x44160000
	.align 2
.LC444:
	.long 0x3f800000
	.align 2
.LC445:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_Cloak
	.type	 Use_Cloak,@function
Use_Cloak:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,itemlist@ha
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	mr 31,3
	subf 4,9,4
	ori 0,0,53053
	lwz 11,84(31)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC442@ha
	lis 11,level@ha
	lwz 10,84(31)
	la 9,.LC442@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3900(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L670
	lis 9,.LC443@ha
	la 9,.LC443@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L672
.L670:
	addi 0,11,600
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L672:
	stfs 0,3900(10)
	lis 29,gi@ha
	lis 3,.LC441@ha
	la 29,gi@l(29)
	la 3,.LC441@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC444@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC444@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC444@ha
	la 9,.LC444@l(9)
	lfs 2,0(9)
	lis 9,.LC445@ha
	la 9,.LC445@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe26:
	.size	 Use_Cloak,.Lfe26-Use_Cloak
	.section	".rodata"
	.align 2
.LC446:
	.long 0x3f800000
	.align 2
.LC447:
	.long 0x40000000
	.align 2
.LC448:
	.long 0x0
	.align 3
.LC449:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Scanner
	.type	 Pickup_Scanner,@function
Pickup_Scanner:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 12,3
	lis 11,skill@ha
	lis 9,itemlist@ha
	lwz 8,648(12)
	lis 0,0x3cf3
	lwz 10,skill@l(11)
	la 9,itemlist@l(9)
	lis 7,.LC446@ha
	ori 0,0,53053
	subf 9,9,8
	lwz 11,84(4)
	la 7,.LC446@l(7)
	mullw 9,9,0
	lfs 13,20(10)
	lfs 0,0(7)
	addi 11,11,740
	rlwinm 9,9,0,0,29
	lwzx 11,11,9
	fcmpu 7,13,0
	cmpwi 6,11,1
	mfcr 9
	rlwinm 0,9,26,1
	rlwinm 9,9,31,1
	and. 10,9,0
	bc 4,2,.L681
	lis 7,.LC447@ha
	srawi 0,11,31
	la 7,.LC447@l(7)
	subf 0,11,0
	lfs 0,0(7)
	srwi 10,0,31
	fcmpu 7,13,0
	cror 31,30,29
	mfcr 9
	rlwinm 9,9,0,1
	and. 0,9,10
	bc 4,2,.L681
	lis 11,coop@ha
	lis 7,.LC448@ha
	lwz 9,coop@l(11)
	la 7,.LC448@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L676
	lwz 0,56(8)
	rlwinm 0,0,29,31,31
	and. 9,0,10
	bc 12,2,.L676
.L681:
	li 3,0
	b .L680
.L676:
	lwz 0,648(12)
	lis 9,itemlist@ha
	lis 11,0x3cf3
	la 9,itemlist@l(9)
	ori 11,11,53053
	lwz 10,84(4)
	subf 0,9,0
	lis 8,deathmatch@ha
	mullw 0,0,11
	addi 10,10,740
	lis 7,.LC448@ha
	lwz 11,deathmatch@l(8)
	la 7,.LC448@l(7)
	rlwinm 0,0,0,0,29
	lfs 13,0(7)
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L677
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L677
	lis 9,.LC449@ha
	lwz 11,648(12)
	la 9,.LC449@l(9)
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
.L677:
	li 3,1
.L680:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe27:
	.size	 Pickup_Scanner,.Lfe27-Pickup_Scanner
	.section	".rodata"
	.align 2
.LC450:
	.long 0x3f800000
	.align 2
.LC451:
	.long 0x40000000
	.align 2
.LC452:
	.long 0x0
	.align 3
.LC453:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Sentry
	.type	 Pickup_Sentry,@function
Pickup_Sentry:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 12,3
	lis 11,skill@ha
	lis 9,itemlist@ha
	lwz 8,648(12)
	lis 0,0x3cf3
	lwz 10,skill@l(11)
	la 9,itemlist@l(9)
	lis 7,.LC450@ha
	ori 0,0,53053
	subf 9,9,8
	lwz 11,84(4)
	la 7,.LC450@l(7)
	mullw 9,9,0
	lfs 13,20(10)
	lfs 0,0(7)
	addi 11,11,740
	rlwinm 9,9,0,0,29
	lwzx 11,11,9
	fcmpu 7,13,0
	cmpwi 6,11,1
	mfcr 9
	rlwinm 0,9,26,1
	rlwinm 9,9,31,1
	and. 10,9,0
	bc 4,2,.L693
	lis 7,.LC451@ha
	srawi 0,11,31
	la 7,.LC451@l(7)
	subf 0,11,0
	lfs 0,0(7)
	srwi 10,0,31
	fcmpu 7,13,0
	cror 31,30,29
	mfcr 9
	rlwinm 9,9,0,1
	and. 0,9,10
	bc 4,2,.L693
	lis 11,coop@ha
	lis 7,.LC452@ha
	lwz 9,coop@l(11)
	la 7,.LC452@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L688
	lwz 0,56(8)
	rlwinm 0,0,29,31,31
	and. 9,0,10
	bc 12,2,.L688
.L693:
	li 3,0
	b .L692
.L688:
	lwz 0,648(12)
	lis 9,itemlist@ha
	lis 11,0x3cf3
	la 9,itemlist@l(9)
	ori 11,11,53053
	lwz 10,84(4)
	subf 0,9,0
	lis 8,deathmatch@ha
	mullw 0,0,11
	addi 10,10,740
	lis 7,.LC452@ha
	lwz 11,deathmatch@l(8)
	la 7,.LC452@l(7)
	rlwinm 0,0,0,0,29
	lfs 13,0(7)
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L689
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L689
	lis 9,.LC453@ha
	lwz 11,648(12)
	la 9,.LC453@l(9)
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
.L689:
	li 3,1
.L692:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 Pickup_Sentry,.Lfe28-Pickup_Sentry
	.section	".rodata"
	.align 2
.LC454:
	.string	"weapons/turret/throw.wav"
	.comm	jacket_armor_index,4,4
	.comm	combat_armor_index,4,4
	.comm	body_armor_index,4,4
	.section	".text"
	.align 2
	.globl InitItems
	.type	 InitItems,@function
InitItems:
	lis 9,game+1556@ha
	li 0,93
	stw 0,game+1556@l(9)
	blr
.Lfe29:
	.size	 InitItems,.Lfe29-InitItems
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
	b .L700
.L20:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L21
.L19:
	li 3,0
.L700:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 FindItem,.Lfe30-FindItem
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
	b .L701
.L12:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L13
.L11:
	li 3,0
.L701:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 FindItemByClassname,.Lfe31-FindItemByClassname
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
.Lfe32:
	.size	 SetRespawn,.Lfe32-SetRespawn
	.align 2
	.globl ArmorIndex
	.type	 ArmorIndex,@function
ArmorIndex:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L274
	li 3,0
	blr
.L274:
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
.Lfe33:
	.size	 ArmorIndex,.Lfe33-ArmorIndex
	.align 2
	.globl PowerArmorType
	.type	 PowerArmorType,@function
PowerArmorType:
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 4,2,.L312
	li 3,0
	blr
.L312:
	lwz 3,264(3)
	andi. 0,3,4096
	rlwinm 3,3,19,31,31
	bclr 12,2
	li 3,2
	blr
.Lfe34:
	.size	 PowerArmorType,.Lfe34-PowerArmorType
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
	mulli 0,3,84
	lis 3,itemlist@ha
	la 3,itemlist@l(3)
	add 3,0,3
	blr
.Lfe35:
	.size	 GetItemByIndex,.Lfe35-GetItemByIndex
	.align 2
	.globl Add_Ammo
	.type	 Add_Ammo,@function
Add_Ammo:
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 4,2,.L185
.L706:
	li 3,0
	blr
.L185:
	lwz 0,68(4)
	cmpwi 0,0,0
	bc 4,2,.L186
	lwz 10,1764(9)
	b .L187
.L186:
	cmpwi 0,0,1
	bc 4,2,.L188
	lwz 10,1768(9)
	b .L187
.L188:
	cmpwi 0,0,2
	bc 4,2,.L190
	lwz 10,1772(9)
	b .L187
.L190:
	cmpwi 0,0,3
	bc 4,2,.L192
	lwz 10,1776(9)
	b .L187
.L192:
	cmpwi 0,0,4
	bc 4,2,.L194
	lwz 10,1780(9)
	b .L187
.L194:
	cmpwi 0,0,5
	li 10,200
	bc 4,2,.L187
	lwz 10,1784(9)
.L187:
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(3)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	rlwinm 4,9,0,0,29
	lwzx 0,11,4
	cmpw 0,0,10
	bc 12,2,.L706
	add 0,0,5
	stwx 0,11,4
	lwz 9,84(3)
	addi 3,9,740
	lwzx 0,3,4
	cmpw 0,0,10
	bc 4,1,.L199
	stwx 10,3,4
.L199:
	li 3,1
	blr
.Lfe36:
	.size	 Add_Ammo,.Lfe36-Add_Ammo
	.section	".sbss","aw",@nobits
	.align 2
power_screen_index:
	.space	4
	.size	 power_screen_index,4
	.align 2
power_shield_index:
	.space	4
	.size	 power_shield_index,4
	.comm	tech_resistance_index,4,4
	.comm	tech_strength_index,4,4
	.comm	tech_haste_index,4,4
	.comm	tech_regeneration_index,4,4
	.align 2
quad_drop_timeout_hack:
	.space	4
	.size	 quad_drop_timeout_hack,4
	.section	".rodata"
	.align 2
.LC455:
	.long 0x3f800000
	.align 2
.LC456:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_Sentry
	.type	 Use_Sentry,@function
Use_Sentry:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 4,9,4
	mr 31,3
	mullw 4,4,0
	lwz 9,84(31)
	rlwinm 30,4,0,0,29
	addi 9,9,740
	lwzx 0,9,30
	cmpwi 0,0,0
	bc 12,2,.L694
	lis 29,gi@ha
	lis 3,.LC454@ha
	la 29,gi@l(29)
	la 3,.LC454@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC455@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC455@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC455@ha
	la 9,.LC455@l(9)
	lfs 2,0(9)
	lis 9,.LC456@ha
	la 9,.LC456@l(9)
	lfs 3,0(9)
	blrl
	mr 3,31
	bl Launch_Sentry
	lwz 11,84(31)
	mr 3,31
	addi 11,11,740
	lwzx 9,11,30
	addi 9,9,-1
	stwx 9,11,30
	bl ValidateSelectedItem
.L694:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe37:
	.size	 Use_Sentry,.Lfe37-Use_Sentry
	.section	".rodata"
	.align 2
.LC457:
	.long 0x3f800000
	.align 2
.LC458:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_MediPak
	.type	 Use_MediPak,@function
Use_MediPak:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	mr 31,3
	la 9,itemlist@l(9)
	lis 0,0x3cf3
	lwz 8,480(31)
	subf 4,9,4
	lwz 11,484(31)
	ori 0,0,53053
	mullw 4,4,0
	lwz 9,84(31)
	cmpw 0,8,11
	addi 7,9,740
	rlwinm 4,4,0,0,29
	lwzx 10,7,4
	bc 4,0,.L643
	subf 9,8,11
	cmpw 7,9,10
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 11,10,0
	and 9,9,0
	or. 30,9,11
	bc 12,2,.L643
	subf 0,30,10
	stwx 0,7,4
	bl ValidateSelectedItem
	lwz 0,480(31)
	lis 29,gi@ha
	lis 3,.LC33@ha
	la 29,gi@l(29)
	la 3,.LC33@l(3)
	add 0,0,30
	stw 0,480(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC457@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC457@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC457@ha
	la 9,.LC457@l(9)
	lfs 2,0(9)
	lis 9,.LC458@ha
	la 9,.LC458@l(9)
	lfs 3,0(9)
	blrl
.L643:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe38:
	.size	 Use_MediPak,.Lfe38-Use_MediPak
	.align 2
	.globl Drop_MediPak
	.type	 Drop_MediPak,@function
Drop_MediPak:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	mr 29,4
	la 9,itemlist@l(9)
	lis 0,0x3cf3
	ori 0,0,53053
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
	bc 12,0,.L648
	stw 10,532(11)
	b .L649
.L648:
	stw 0,532(11)
.L649:
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
.Lfe39:
	.size	 Drop_MediPak,.Lfe39-Drop_MediPak
	.align 2
	.globl Drop_Jetpak
	.type	 Drop_Jetpak,@function
Drop_Jetpak:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	bl Jet_Active
	cmpwi 0,3,0
	bc 12,2,.L664
	lis 9,gi+8@ha
	lis 5,.LC435@ha
	lwz 0,gi+8@l(9)
	la 5,.LC435@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L664:
	lis 29,itemlist@ha
	lis 0,0x3cf3
	la 29,itemlist@l(29)
	ori 0,0,53053
	subf 29,29,30
	mr 4,30
	mullw 29,29,0
	mr 3,31
	srawi 29,29,2
	bl Drop_Item
	lwz 9,84(31)
	slwi 29,29,2
	li 11,0
	addi 9,9,740
	lwzx 0,9,29
	stw 0,532(3)
	lwz 9,84(31)
	mr 3,31
	addi 9,9,740
	stwx 11,9,29
	bl ValidateSelectedItem
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe40:
	.size	 Drop_Jetpak,.Lfe40-Drop_Jetpak
	.align 2
	.globl Use_Scanner
	.type	 Use_Scanner,@function
Use_Scanner:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl Toggle_Scanner
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe41:
	.size	 Use_Scanner,.Lfe41-Use_Scanner
	.align 2
	.globl Drop_Scanner
	.type	 Drop_Scanner,@function
Drop_Scanner:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 29,itemlist@ha
	lis 0,0x3cf3
	la 29,itemlist@l(29)
	ori 0,0,53053
	subf 29,29,4
	mr 31,3
	mullw 29,29,0
	srawi 29,29,2
	bl Drop_Item
	lwz 11,84(31)
	slwi 29,29,2
	addi 11,11,740
	lwzx 9,11,29
	addi 9,9,-1
	stwx 9,11,29
	lwz 11,84(31)
	addi 9,11,740
	lwzx 0,9,29
	cmpwi 0,0,0
	bc 4,2,.L684
	stw 0,1820(11)
.L684:
	mr 3,31
	bl ValidateSelectedItem
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe42:
	.size	 Drop_Scanner,.Lfe42-Drop_Scanner
	.section	".rodata"
	.align 3
.LC459:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC460:
	.long 0x40040000
	.long 0x0
	.align 2
.LC461:
	.long 0x437a0000
	.section	".text"
	.align 2
	.globl Use_Beans
	.type	 Use_Beans,@function
Use_Beans:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,480(3)
	lis 6,0x4330
	lwz 10,484(3)
	mr 7,8
	lis 11,.LC459@ha
	addi 9,9,150
	la 11,.LC459@l(11)
	xoris 0,9,0x8000
	xoris 10,10,0x8000
	lfd 11,0(11)
	stw 0,12(1)
	lis 11,.LC460@ha
	stw 6,8(1)
	la 11,.LC460@l(11)
	lis 0,0x3cf3
	lfd 13,8(1)
	ori 0,0,53053
	stw 10,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 13,13,11
	lfd 12,0(11)
	lis 11,itemlist@ha
	stw 9,480(3)
	fsub 0,0,11
	la 11,itemlist@l(11)
	subf 4,11,4
	mullw 4,4,0
	fmul 12,0,12
	srawi 4,4,2
	fcmpu 0,13,12
	bc 4,1,.L697
	fctiwz 0,12
	mr 9,8
	stfd 0,8(1)
	lwz 9,12(1)
	stw 9,480(3)
.L697:
	lis 11,level@ha
	lwz 10,84(3)
	lwz 11,level@l(11)
	lfs 13,3904(10)
	xoris 0,11,0x8000
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,11
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L698
	lis 9,.LC461@ha
	la 9,.LC461@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L707
.L698:
	addi 0,11,251
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,11
	frsp 0,0
.L707:
	stfs 0,3904(10)
	lwz 9,84(3)
	slwi 0,4,2
	addi 9,9,740
	lwzx 11,9,0
	addi 11,11,-1
	stwx 11,9,0
	bl ValidateSelectedItem
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe43:
	.size	 Use_Beans,.Lfe43-Use_Beans
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
	lis 0,0x3cf3
	lwz 11,84(28)
	la 9,itemlist@l(9)
	ori 0,0,53053
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
.Lfe44:
	.size	 Drop_General,.Lfe44-Drop_General
	.section	".rodata"
	.align 2
.LC462:
	.long 0x0
	.align 3
.LC463:
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
	lis 9,.LC462@ha
	lis 11,deathmatch@ha
	la 9,.LC462@l(9)
	mr 12,3
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	stfs 13,1140(4)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L56
	lwz 9,484(4)
	addi 9,9,1
	stw 9,484(4)
.L56:
	lwz 0,480(4)
	lwz 9,484(4)
	cmpw 0,0,9
	bc 4,0,.L57
	stw 9,480(4)
.L57:
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L58
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L58
	lis 9,.LC463@ha
	lwz 11,648(12)
	la 9,.LC463@l(9)
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
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe45:
	.size	 Pickup_Adrenaline,.Lfe45-Pickup_Adrenaline
	.section	".rodata"
	.align 2
.LC464:
	.long 0x0
	.align 3
.LC465:
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
	lis 9,.LC464@ha
	mr 12,3
	la 9,.LC464@l(9)
	lfs 13,0(9)
	lwz 9,484(4)
	addi 9,9,2
	stfs 13,1140(4)
	stw 9,484(4)
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L61
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L61
	lis 9,.LC465@ha
	lwz 11,648(12)
	la 9,.LC465@l(9)
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
.Lfe46:
	.size	 Pickup_AncientHead,.Lfe46-Pickup_AncientHead
	.section	".rodata"
	.align 3
.LC466:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC467:
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
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	mr 29,3
	subf 4,9,4
	ori 0,0,53053
	lwz 11,84(29)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC466@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC466@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3808(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L166
	lis 9,.LC467@ha
	la 9,.LC467@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L708
.L166:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L708:
	stfs 0,3808(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe47:
	.size	 Use_Breather,.Lfe47-Use_Breather
	.section	".rodata"
	.align 3
.LC468:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC469:
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
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	mr 29,3
	subf 4,9,4
	ori 0,0,53053
	lwz 11,84(29)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC468@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC468@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3812(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L169
	lis 9,.LC469@ha
	la 9,.LC469@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L709
.L169:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L709:
	stfs 0,3812(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe48:
	.size	 Use_Envirosuit,.Lfe48-Use_Envirosuit
	.align 2
	.globl Use_Silencer
	.type	 Use_Silencer,@function
Use_Silencer:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	mr 29,3
	subf 4,9,4
	ori 0,0,53053
	lwz 11,84(29)
	mullw 4,4,0
	addi 11,11,740
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lwz 11,84(29)
	lwz 9,3824(11)
	addi 9,9,30
	stw 9,3824(11)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe49:
	.size	 Use_Silencer,.Lfe49-Use_Silencer
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
	lis 0,0x3cf3
	ori 0,0,53053
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
	bc 12,0,.L238
	stw 11,532(29)
	b .L239
.L238:
	stw 0,532(29)
.L239:
	lwz 9,84(31)
	slwi 11,28,2
	lwz 8,532(29)
	mr 10,9
	lwz 9,1788(9)
	cmpwi 0,9,0
	bc 12,2,.L240
	lwz 0,68(9)
	cmpwi 0,0,3
	bc 4,2,.L240
	lwz 0,68(30)
	cmpwi 0,0,3
	bc 4,2,.L240
	addi 9,10,740
	lwzx 0,9,11
	subf. 9,8,0
	bc 12,1,.L240
	lis 9,gi+8@ha
	lis 5,.LC30@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC30@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,29
	bl G_FreeEdict
	b .L237
.L240:
	addi 9,10,740
	mr 3,31
	lwzx 0,9,11
	subf 0,8,0
	stwx 0,9,11
	bl ValidateSelectedItem
.L237:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe50:
	.size	 Drop_Ammo,.Lfe50-Drop_Ammo
	.section	".rodata"
	.align 2
.LC470:
	.long 0x3f800000
	.align 2
.LC471:
	.long 0x0
	.align 2
.LC472:
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
	bc 4,1,.L242
	bl CTFHasRegeneration
	cmpwi 0,3,0
	bc 4,2,.L242
	lis 11,.LC470@ha
	lis 9,level+4@ha
	la 11,.LC470@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	lwz 11,256(31)
	fadds 0,0,13
	stfs 0,428(31)
	lwz 9,480(11)
	addi 9,9,-1
	stw 9,480(11)
	b .L241
.L242:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L243
	lis 9,.LC471@ha
	lis 11,deathmatch@ha
	la 9,.LC471@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L243
	lwz 9,264(31)
	lis 11,.LC472@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC472@l(11)
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
	b .L241
.L243:
	mr 3,31
	bl G_FreeEdict
.L241:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe51:
	.size	 MegaHealth_think,.Lfe51-MegaHealth_think
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
	bc 12,2,.L334
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,30
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,1
	bc 4,2,.L334
	bl Use_PowerArmor
.L334:
	mr 3,31
	mr 4,30
	bl Drop_Item
	lis 11,itemlist@ha
	lis 0,0x3cf3
	lwz 10,84(31)
	la 11,itemlist@l(11)
	ori 0,0,53053
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
.Lfe52:
	.size	 Drop_PowerArmor,.Lfe52-Drop_PowerArmor
	.align 2
	.globl Drop_PowerScreen
	.type	 Drop_PowerScreen,@function
Drop_PowerScreen:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 0,264(31)
	andi. 9,0,8192
	bc 12,2,.L355
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,30
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,1
	bc 4,2,.L355
	bl Use_PowerScreen
.L355:
	mr 3,31
	mr 4,30
	bl Drop_Item
	lis 11,itemlist@ha
	lis 0,0x3cf3
	lwz 10,84(31)
	la 11,itemlist@l(11)
	ori 0,0,53053
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
.Lfe53:
	.size	 Drop_PowerScreen,.Lfe53-Drop_PowerScreen
	.align 2
	.type	 drop_temp_touch,@function
drop_temp_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,256(3)
	cmpw 0,4,0
	bc 12,2,.L408
	bl Touch_Item
.L408:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe54:
	.size	 drop_temp_touch,.Lfe54-drop_temp_touch
	.section	".rodata"
	.align 2
.LC473:
	.long 0x0
	.align 2
.LC474:
	.long 0x41e80000
	.align 2
.LC475:
	.long 0x42700000
	.section	".text"
	.align 2
	.type	 drop_make_touchable,@function
drop_make_touchable:
	lis 9,Touch_Item@ha
	lis 11,deathmatch@ha
	la 9,Touch_Item@l(9)
	lwz 10,deathmatch@l(11)
	stw 9,444(3)
	lis 9,.LC473@ha
	lfs 0,20(10)
	la 9,.LC473@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L411
	lis 9,.LC474@ha
	lis 11,level+4@ha
	la 9,.LC474@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,436(3)
	stfs 0,428(3)
.L411:
	lwz 9,648(3)
	cmpwi 0,9,0
	bclr 12,2
	lwz 0,12(9)
	lis 9,CTFDrop_Tech@ha
	la 9,CTFDrop_Tech@l(9)
	cmpw 0,0,9
	bclr 4,2
	lis 9,.LC475@ha
	lis 11,level+4@ha
	la 9,.LC475@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,TechThink@ha
	la 9,TechThink@l(9)
	fadds 0,0,13
	stw 9,436(3)
	stfs 0,428(3)
	blr
.Lfe55:
	.size	 drop_make_touchable,.Lfe55-drop_make_touchable
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
	bc 12,2,.L418
	li 0,2
	stw 11,444(3)
	stw 0,248(3)
	b .L419
.L418:
	lis 9,Touch_Item@ha
	li 0,1
	la 9,Touch_Item@l(9)
	stw 0,248(3)
	stw 9,444(3)
.L419:
	lis 9,gi+72@ha
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe56:
	.size	 Use_Item,.Lfe56-Use_Item
	.section	".rodata"
	.align 2
.LC476:
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
	lis 11,.LC476@ha
	lis 9,deathmatch@ha
	la 11,.LC476@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L493
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L493
	bl G_FreeEdict
	b .L492
.L710:
	mr 4,31
	b .L500
.L493:
	lis 9,.LC421@ha
	li 0,10
	la 9,.LC421@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC392@ha
	lis 11,itemlist@ha
	la 27,.LC392@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L501
	mr 28,10
.L496:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L498
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L710
.L498:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L496
.L501:
	li 4,0
.L500:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC32@ha
	lwz 0,gi+36@l(9)
	la 3,.LC32@l(3)
	mtlr 0
	blrl
.L492:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe57:
	.size	 SP_item_health,.Lfe57-SP_item_health
	.section	".rodata"
	.align 2
.LC477:
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
	lis 11,.LC477@ha
	lis 9,deathmatch@ha
	la 11,.LC477@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L503
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L503
	bl G_FreeEdict
	b .L502
.L711:
	mr 4,31
	b .L510
.L503:
	lis 9,.LC422@ha
	li 0,2
	la 9,.LC422@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC392@ha
	lis 11,itemlist@ha
	la 27,.LC392@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L511
	mr 28,10
.L506:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L508
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L711
.L508:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L506
.L511:
	li 4,0
.L510:
	mr 3,29
	bl SpawnItem
	li 0,1
	lis 9,gi+36@ha
	stw 0,644(29)
	lis 3,.LC31@ha
	lwz 0,gi+36@l(9)
	la 3,.LC31@l(3)
	mtlr 0
	blrl
.L502:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe58:
	.size	 SP_item_health_small,.Lfe58-SP_item_health_small
	.section	".rodata"
	.align 2
.LC478:
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
	lis 11,.LC478@ha
	lis 9,deathmatch@ha
	la 11,.LC478@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L513
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L513
	bl G_FreeEdict
	b .L512
.L712:
	mr 4,31
	b .L520
.L513:
	lis 9,.LC423@ha
	li 0,25
	la 9,.LC423@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC392@ha
	lis 11,itemlist@ha
	la 27,.LC392@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L521
	mr 28,10
.L516:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L518
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L712
.L518:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L516
.L521:
	li 4,0
.L520:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC33@ha
	lwz 0,gi+36@l(9)
	la 3,.LC33@l(3)
	mtlr 0
	blrl
.L512:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe59:
	.size	 SP_item_health_large,.Lfe59-SP_item_health_large
	.section	".rodata"
	.align 2
.LC479:
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
	lis 11,.LC479@ha
	lis 9,deathmatch@ha
	la 11,.LC479@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L523
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L523
	bl G_FreeEdict
	b .L522
.L713:
	mr 4,31
	b .L530
.L523:
	li 0,100
	lis 9,game@ha
	la 10,game@l(9)
	stw 0,532(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC389@ha
	lis 11,itemlist@ha
	la 27,.LC389@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L531
	mr 28,10
.L526:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L528
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L713
.L528:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L526
.L531:
	li 4,0
.L530:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC34@ha
	lwz 0,gi+36@l(9)
	la 3,.LC34@l(3)
	mtlr 0
	blrl
	li 0,3
	stw 0,644(29)
.L522:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe60:
	.size	 SP_item_health_mega,.Lfe60-SP_item_health_mega
	.section	".rodata"
	.align 2
.LC480:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_item_medipak
	.type	 SP_item_medipak,@function
SP_item_medipak:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 11,.LC480@ha
	lis 9,deathmatch@ha
	la 11,.LC480@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L533
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L533
	bl G_FreeEdict
	b .L532
.L714:
	mr 4,31
	b .L540
.L533:
	li 0,100
	lis 9,game@ha
	la 10,game@l(9)
	stw 0,532(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC326@ha
	lis 11,itemlist@ha
	la 27,.LC326@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L541
	mr 28,10
.L536:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L538
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L714
.L538:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L536
.L541:
	li 4,0
.L540:
	mr 3,29
	bl SpawnItem
.L532:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe61:
	.size	 SP_item_medipak,.Lfe61-SP_item_medipak
	.align 2
	.globl SP_item_jetpak
	.type	 SP_item_jetpak,@function
SP_item_jetpak:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	li 0,800
	lis 9,game@ha
	mr 28,3
	la 10,game@l(9)
	stw 0,532(28)
	li 30,0
	lis 11,.LC424@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC424@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L550
	mr 29,10
.L545:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L547
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L547
	mr 4,31
	b .L549
.L547:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,84
	cmpw 0,30,0
	bc 12,0,.L545
.L550:
	li 4,0
.L549:
	mr 3,28
	bl SpawnItem
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe62:
	.size	 SP_item_jetpak,.Lfe62-SP_item_jetpak
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
