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
	.string	"item_flag_team1"
	.align 2
.LC1:
	.string	"item_flag_team2"
	.section	".text"
	.align 2
	.globl CTFResetFlags
	.type	 CTFResetFlags,@function
CTFResetFlags:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,.LC0@ha
	li 31,0
	la 29,.LC0@l(9)
	b .L44
.L46:
	lwz 0,288(31)
	andis. 11,0,1
	bc 12,2,.L47
	mr 3,31
	bl G_FreeEdict
	b .L44
.L47:
	lwz 0,184(31)
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	stw 30,80(31)
.L44:
	mr 3,31
	li 4,284
	mr 5,29
	li 30,1
	bl G_Find
	mr. 31,3
	lis 9,gi+72@ha
	mr 3,31
	bc 4,2,.L46
	lis 9,.LC1@ha
	lis 11,gi@ha
	la 28,.LC1@l(9)
	la 29,gi@l(11)
	li 31,0
	b .L55
.L57:
	lwz 0,288(31)
	andis. 9,0,1
	bc 12,2,.L58
	mr 3,31
	bl G_FreeEdict
	b .L55
.L58:
	lwz 0,184(31)
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	stw 30,80(31)
.L55:
	mr 3,31
	li 4,284
	mr 5,28
	bl G_Find
	mr. 31,3
	mr 3,31
	bc 4,2,.L57
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 CTFResetFlags,.Lfe1-CTFResetFlags
	.section	".rodata"
	.align 2
.LC2:
	.string	"Red"
	.align 2
.LC3:
	.string	"Blue"
	.align 2
.LC4:
	.string	"Don't know what team the flag is on.\n"
	.align 2
.LC5:
	.string	"%s got the %s flag!\n"
	.align 2
.LC6:
	.string	"%s captured the %s flag!\n"
	.align 2
.LC7:
	.string	"ctf/flagcap.wav"
	.align 2
.LC8:
	.string	"%s returned the flag!\n"
	.align 2
.LC9:
	.string	"ctf/flagret.wav"
	.align 2
.LC10:
	.long 0x3f800000
	.align 2
.LC11:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFPickup_Flag
	.type	 CTFPickup_Flag,@function
CTFPickup_Flag:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 28,3
	mr 30,4
	lwz 3,284(28)
	lis 29,.LC0@ha
	la 4,.LC0@l(29)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L62
	li 0,2
	lis 9,game@ha
	la 8,game@l(9)
	stw 0,908(28)
	li 31,0
	lwz 0,1556(8)
	lis 10,.LC2@ha
	lis 9,.LC1@ha
	lis 11,itemlist@ha
	la 25,.LC1@l(9)
	cmpw 0,31,0
	la 26,.LC2@l(10)
	la 29,itemlist@l(11)
	bc 4,0,.L80
	mr 27,8
.L65:
	lwz 3,0(29)
	cmpwi 0,3,0
	bc 12,2,.L67
	mr 4,25
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L92
.L67:
	lwz 0,1556(27)
	addi 31,31,1
	addi 29,29,72
	cmpw 0,31,0
	bc 12,0,.L65
	b .L80
.L62:
	lwz 3,284(28)
	lis 4,.LC1@ha
	la 4,.LC1@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L72
	li 0,1
	lis 9,game@ha
	la 10,game@l(9)
	stw 0,908(28)
	li 31,0
	lwz 0,1556(10)
	lis 9,.LC3@ha
	lis 11,itemlist@ha
	la 25,.LC0@l(29)
	la 26,.LC3@l(9)
	cmpw 0,31,0
	la 29,itemlist@l(11)
	bc 4,0,.L80
	mr 27,10
.L75:
	lwz 3,0(29)
	cmpwi 0,3,0
	bc 12,2,.L77
	mr 4,25
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L93
.L77:
	lwz 0,1556(27)
	addi 31,31,1
	addi 29,29,72
	cmpw 0,31,0
	bc 12,0,.L75
.L80:
	li 11,0
	b .L71
.L72:
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC4@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L89
.L93:
.L92:
	mr 11,29
.L71:
	lwz 9,908(28)
	lwz 0,908(30)
	cmpw 0,9,0
	bc 12,2,.L90
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC5@ha
	lwz 0,gi@l(9)
	la 4,.LC5@l(4)
	mr 6,26
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,908(30)
	cmpwi 0,0,1
	bc 4,2,.L83
	lwz 0,268(30)
	oris 0,0,0x4
	stw 0,268(30)
.L83:
	lwz 0,908(30)
	cmpwi 0,0,2
	bc 4,2,.L84
	lwz 0,268(30)
	oris 0,0,0x8
	stw 0,268(30)
.L84:
	lwz 11,1000(28)
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,84(30)
	subf 11,9,11
	mullw 11,11,0
	addi 10,10,748
	srawi 11,11,3
	slwi 11,11,2
	lwzx 9,10,11
	addi 9,9,1
	stwx 9,10,11
	lwz 0,288(28)
	andis. 11,0,0x1
	bc 4,2,.L85
	lwz 0,268(28)
	lwz 9,184(28)
	oris 0,0,0x8000
	stw 11,248(28)
	ori 9,9,1
	stw 0,268(28)
	stw 9,184(28)
.L85:
	li 3,1
	b .L91
.L90:
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	cmpw 0,26,9
	bc 4,2,.L87
	lis 9,.LC3@ha
	la 26,.LC3@l(9)
	b .L88
.L87:
	mr 26,9
.L88:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 5,84(30)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,11
	mullw 9,9,0
	addi 11,5,748
	srawi 9,9,3
	slwi 31,9,2
	lwzx 0,11,31
	cmpwi 0,0,0
	bc 12,2,.L89
	lis 29,gi@ha
	lis 4,.LC6@ha
	lwz 9,gi@l(29)
	mr 6,26
	la 4,.LC6@l(4)
	addi 5,5,700
	li 3,2
	mtlr 9
	la 29,gi@l(29)
	crxor 6,6,6
	blrl
	mr 3,30
	crxor 6,6,6
	bl CapTheFlag
	lwz 9,84(30)
	li 0,0
	lis 3,.LC7@ha
	la 3,.LC7@l(3)
	addi 9,9,748
	stwx 0,9,31
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC10@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC10@l(9)
	mr 3,28
	lfs 1,0(9)
	li 4,26
	mtlr 0
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 2,0(9)
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 3,0(9)
	blrl
	bl CTFResetFlags
.L89:
	li 3,0
.L91:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 CTFPickup_Flag,.Lfe2-CTFPickup_Flag
	.section	".rodata"
	.align 2
.LC12:
	.string	"Red Flag"
	.align 2
.LC13:
	.string	"Blue Flag"
	.align 2
.LC14:
	.long 0x3f800000
	.align 2
.LC15:
	.long 0x0
	.section	".text"
	.align 2
	.globl CapTheFlag
	.type	 CapTheFlag,@function
CapTheFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 30,3
	lwz 0,908(30)
	cmpwi 0,0,1
	bc 4,2,.L95
	lis 9,.LC12@ha
	la 28,.LC12@l(9)
.L95:
	cmpwi 0,0,2
	bc 4,2,.L96
	lis 9,.LC13@ha
	la 28,.LC13@l(9)
.L96:
	lis 9,game@ha
	li 31,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 29,itemlist@l(11)
	cmpw 0,31,0
	bc 4,0,.L104
	mr 27,9
.L99:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L101
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L101
	mr 10,29
	b .L103
.L101:
	lwz 0,1556(27)
	addi 31,31,1
	addi 29,29,72
	cmpw 0,31,0
	bc 12,0,.L99
.L104:
	li 10,0
.L103:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	cmpwi 0,0,0
	bc 12,2,.L94
	lwz 0,908(30)
	cmpwi 0,0,1
	bc 4,2,.L107
	lis 11,level@ha
	li 10,0
	la 11,level@l(11)
	lwz 9,304(11)
	addi 9,9,15
	stw 9,304(11)
	lwz 0,268(30)
	stw 10,64(30)
	rlwinm 0,0,0,14,12
	stw 0,268(30)
.L107:
	lwz 0,908(30)
	cmpwi 0,0,2
	bc 4,2,.L108
	lis 11,level@ha
	li 10,0
	la 11,level@l(11)
	lwz 9,308(11)
	addi 9,9,15
	stw 9,308(11)
	lwz 0,268(30)
	stw 10,64(30)
	rlwinm 0,0,0,13,11
	stw 0,268(30)
.L108:
	lwz 11,84(30)
	lis 29,gi@ha
	lis 3,.LC7@ha
	la 29,gi@l(29)
	la 3,.LC7@l(3)
	addi 11,11,748
	lwzx 9,11,8
	addi 9,9,-1
	stwx 9,11,8
	lwz 10,84(30)
	lwz 9,3560(10)
	addi 9,9,5
	stw 9,3560(10)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC14@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC14@l(9)
	mr 3,30
	lfs 1,0(9)
	li 4,3
	mtlr 0
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 2,0(9)
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 3,0(9)
	blrl
	mr 3,30
	bl ValidateSelectedItem
.L94:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 CapTheFlag,.Lfe3-CapTheFlag
	.section	".rodata"
	.align 3
.LC16:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC17:
	.long 0x3f800000
	.align 2
.LC18:
	.long 0x40000000
	.align 2
.LC19:
	.long 0x0
	.align 3
.LC20:
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
	lwz 8,1000(31)
	lis 11,skill@ha
	la 9,itemlist@l(9)
	lis 0,0x38e3
	lwz 10,skill@l(11)
	lis 7,.LC17@ha
	ori 0,0,36409
	subf 9,9,8
	mullw 9,9,0
	mr 30,4
	la 7,.LC17@l(7)
	lfs 13,20(10)
	lwz 11,84(30)
	lfs 0,0(7)
	srawi 9,9,3
	slwi 9,9,2
	addi 11,11,748
	lwzx 11,11,9
	fcmpu 6,13,0
	cmpwi 7,11,1
	mfcr 9
	rlwinm 0,9,30,1
	rlwinm 9,9,27,1
	and. 10,9,0
	bc 4,2,.L133
	lis 7,.LC18@ha
	srawi 0,11,31
	la 7,.LC18@l(7)
	subf 0,11,0
	lfs 0,0(7)
	srwi 10,0,31
	fcmpu 7,13,0
	cror 31,30,29
	mfcr 9
	rlwinm 9,9,0,1
	and. 0,9,10
	bc 4,2,.L133
	lis 11,coop@ha
	lis 7,.LC19@ha
	lwz 9,coop@l(11)
	la 7,.LC19@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L125
	lwz 0,56(8)
	rlwinm 0,0,29,31,31
	and. 9,0,10
	bc 12,2,.L125
.L133:
	li 3,0
	b .L132
.L125:
	lwz 0,1000(31)
	lis 9,itemlist@ha
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	lwz 10,84(30)
	subf 0,9,0
	lis 8,deathmatch@ha
	mullw 0,0,11
	addi 10,10,748
	lis 7,.LC19@ha
	lwz 11,deathmatch@l(8)
	la 7,.LC19@l(7)
	srawi 0,0,3
	lfs 13,0(7)
	slwi 0,0,2
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L126
	lwz 0,288(31)
	andis. 4,0,0x1
	bc 4,2,.L127
	lis 9,.LC20@ha
	lwz 11,1000(31)
	la 9,.LC20@l(9)
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
	mr 3,31
	xoris 9,9,0x8000
	stw 0,268(31)
	stw 9,20(1)
	ori 11,11,1
	stw 7,16(1)
	lfd 0,16(1)
	stw 11,184(31)
	stw 4,248(31)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,680(31)
	frsp 0,0
	fadds 13,13,0
	stfs 13,672(31)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L127:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,16
	bc 4,2,.L130
	lwz 9,1000(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L126
	lwz 0,288(31)
	andis. 7,0,2
	bc 12,2,.L126
.L130:
	lwz 9,1000(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L131
	lwz 0,288(31)
	andis. 9,0,2
	bc 12,2,.L131
	lis 11,level+4@ha
	lfs 0,672(31)
	lis 10,.LC16@ha
	lfs 11,level+4@l(11)
	lfd 12,.LC16@l(10)
	lis 11,quad_drop_timeout_hack@ha
	fsubs 0,0,11
	fdiv 0,0,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	stw 9,quad_drop_timeout_hack@l(11)
.L131:
	lwz 9,1000(31)
	mr 3,30
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L126:
	li 3,1
.L132:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 Pickup_Powerup,.Lfe4-Pickup_Powerup
	.section	".rodata"
	.align 3
.LC21:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC22:
	.long 0x3f800000
	.align 2
.LC23:
	.long 0x40000000
	.align 2
.LC24:
	.long 0x0
	.align 3
.LC25:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_BlueFlag
	.type	 Pickup_BlueFlag,@function
Pickup_BlueFlag:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lis 11,itemlist@ha
	lwz 0,1000(31)
	la 11,itemlist@l(11)
	lis 9,0x38e3
	mr 29,4
	ori 9,9,36409
	subf 0,11,0
	lwz 10,908(29)
	mullw 0,0,9
	lwz 11,84(29)
	cmpwi 0,10,1
	srawi 0,0,3
	addi 11,11,748
	slwi 0,0,2
	lwzx 30,11,0
	bc 4,2,.L135
	mr 3,29
	bl CapTheFlag
.L135:
	lis 9,skill@ha
	lwz 0,908(29)
	lis 8,.LC22@ha
	lwz 11,skill@l(9)
	la 8,.LC22@l(8)
	xori 0,0,1
	lfs 0,0(8)
	lfs 13,20(11)
	li 8,0
	srawi 11,0,31
	xor 9,11,0
	subf 9,9,11
	fcmpu 7,13,0
	srawi 9,9,31
	nor 0,9,9
	and 9,30,9
	andi. 0,0,10
	or 30,9,0
	bc 12,30,.L139
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L138
.L139:
	li 8,1
.L138:
	srawi 0,30,31
	subf 0,30,0
	srwi 10,0,31
	and. 11,8,10
	bc 4,2,.L146
	lis 11,coop@ha
	lis 8,.LC24@ha
	lwz 9,coop@l(11)
	la 8,.LC24@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	lwz 8,1000(31)
	fcmpu 0,0,13
	bc 12,2,.L140
	lwz 0,56(8)
	rlwinm 0,0,29,31,31
	and. 9,0,10
	bc 12,2,.L140
.L146:
	li 3,0
	b .L145
.L140:
	lis 11,itemlist@ha
	lis 0,0x38e3
	lwz 10,84(29)
	la 11,itemlist@l(11)
	ori 0,0,36409
	subf 11,11,8
	lis 9,deathmatch@ha
	mullw 11,11,0
	lis 8,.LC24@ha
	addi 10,10,748
	la 8,.LC24@l(8)
	lfs 13,0(8)
	srawi 11,11,3
	lwz 8,deathmatch@l(9)
	slwi 11,11,2
	lwzx 9,10,11
	addi 9,9,1
	stwx 9,10,11
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L141
	lwz 0,288(31)
	andis. 4,0,0x1
	bc 4,2,.L142
	lis 9,.LC25@ha
	lwz 11,1000(31)
	la 9,.LC25@l(9)
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
	mr 3,31
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
	stw 10,680(31)
	frsp 0,0
	fadds 13,13,0
	stfs 13,672(31)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L142:
	lwz 9,1000(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L144
	lwz 0,288(31)
	andis. 8,0,2
	bc 12,2,.L144
	lis 11,level+4@ha
	lfs 0,672(31)
	lis 10,.LC21@ha
	lfs 11,level+4@l(11)
	lfd 12,.LC21@l(10)
	lis 11,quad_drop_timeout_hack@ha
	fsubs 0,0,11
	fdiv 0,0,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	stw 9,quad_drop_timeout_hack@l(11)
.L144:
	lwz 9,1000(31)
	mr 3,29
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L141:
	li 3,1
.L145:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 Pickup_BlueFlag,.Lfe5-Pickup_BlueFlag
	.section	".rodata"
	.align 3
.LC26:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC27:
	.long 0x3f800000
	.align 2
.LC28:
	.long 0x40000000
	.align 2
.LC29:
	.long 0x0
	.align 3
.LC30:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_RedFlag
	.type	 Pickup_RedFlag,@function
Pickup_RedFlag:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lis 11,itemlist@ha
	lwz 0,1000(31)
	la 11,itemlist@l(11)
	lis 9,0x38e3
	mr 29,4
	ori 9,9,36409
	subf 0,11,0
	lwz 10,908(29)
	mullw 0,0,9
	lwz 11,84(29)
	cmpwi 0,10,2
	srawi 0,0,3
	addi 11,11,748
	slwi 0,0,2
	lwzx 30,11,0
	bc 4,2,.L148
	mr 3,29
	bl CapTheFlag
.L148:
	lis 9,skill@ha
	lwz 0,908(29)
	lis 8,.LC27@ha
	lwz 11,skill@l(9)
	la 8,.LC27@l(8)
	xori 0,0,2
	lfs 0,0(8)
	lfs 13,20(11)
	li 8,0
	srawi 11,0,31
	xor 9,11,0
	subf 9,9,11
	fcmpu 7,13,0
	srawi 9,9,31
	nor 0,9,9
	and 9,30,9
	andi. 0,0,10
	or 30,9,0
	bc 12,30,.L152
	lis 9,.LC28@ha
	la 9,.LC28@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L151
.L152:
	li 8,1
.L151:
	srawi 0,30,31
	subf 0,30,0
	srwi 10,0,31
	and. 11,8,10
	bc 4,2,.L159
	lis 11,coop@ha
	lis 8,.LC29@ha
	lwz 9,coop@l(11)
	la 8,.LC29@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	lwz 8,1000(31)
	fcmpu 0,0,13
	bc 12,2,.L153
	lwz 0,56(8)
	rlwinm 0,0,29,31,31
	and. 9,0,10
	bc 12,2,.L153
.L159:
	li 3,0
	b .L158
.L153:
	lis 11,itemlist@ha
	lis 0,0x38e3
	lwz 10,84(29)
	la 11,itemlist@l(11)
	ori 0,0,36409
	subf 11,11,8
	lis 9,deathmatch@ha
	mullw 11,11,0
	lis 8,.LC29@ha
	addi 10,10,748
	la 8,.LC29@l(8)
	lfs 13,0(8)
	srawi 11,11,3
	lwz 8,deathmatch@l(9)
	slwi 11,11,2
	lwzx 9,10,11
	addi 9,9,1
	stwx 9,10,11
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L154
	lwz 0,288(31)
	andis. 4,0,0x1
	bc 4,2,.L155
	lis 9,.LC30@ha
	lwz 11,1000(31)
	la 9,.LC30@l(9)
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
	mr 3,31
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
	stw 10,680(31)
	frsp 0,0
	fadds 13,13,0
	stfs 13,672(31)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L155:
	lwz 9,1000(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L157
	lwz 0,288(31)
	andis. 8,0,2
	bc 12,2,.L157
	lis 11,level+4@ha
	lfs 0,672(31)
	lis 10,.LC26@ha
	lfs 11,level+4@l(11)
	lfd 12,.LC26@l(10)
	lis 11,quad_drop_timeout_hack@ha
	fsubs 0,0,11
	fdiv 0,0,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	stw 9,quad_drop_timeout_hack@l(11)
.L157:
	lwz 9,1000(31)
	mr 3,29
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L154:
	li 3,1
.L158:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 Pickup_RedFlag,.Lfe6-Pickup_RedFlag
	.section	".rodata"
	.align 2
.LC31:
	.string	"Bullets"
	.align 2
.LC32:
	.string	"Shells"
	.align 2
.LC33:
	.long 0x0
	.align 3
.LC34:
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
	lis 11,.LC31@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC31@l(11)
	mr 29,3
	mr 28,4
	cmpw 0,30,0
	la 31,itemlist@l(9)
	bc 4,0,.L177
	mr 27,10
.L172:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L174
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L174
	mr 8,31
	b .L176
.L174:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L172
.L177:
	li 8,0
.L176:
	cmpwi 0,8,0
	bc 12,2,.L178
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(28)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(28)
	lwz 11,1772(9)
	addi 9,9,748
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L178
	stwx 11,9,8
.L178:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC32@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC32@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L187
	mr 27,10
.L182:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L184
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L184
	mr 8,31
	b .L186
.L184:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L182
.L187:
	li 8,0
.L186:
	cmpwi 0,8,0
	bc 12,2,.L188
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(28)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(28)
	addi 4,9,748
	lwz 11,1776(9)
	lwzx 0,4,8
	cmpw 0,0,11
	bc 4,1,.L188
	stwx 11,4,8
.L188:
	lwz 0,288(29)
	andis. 4,0,0x1
	bc 4,2,.L190
	lis 9,.LC33@ha
	lis 11,deathmatch@ha
	la 9,.LC33@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L190
	lis 9,.LC34@ha
	lwz 11,1000(29)
	la 9,.LC34@l(9)
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
	stw 10,680(29)
	frsp 0,0
	fadds 13,13,0
	stfs 13,672(29)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L190:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 Pickup_Bandolier,.Lfe7-Pickup_Bandolier
	.section	".rodata"
	.align 2
.LC35:
	.string	"Rockets"
	.align 2
.LC36:
	.string	"Slugs"
	.align 2
.LC37:
	.string	"Cells"
	.align 2
.LC38:
	.string	"Grenades"
	.align 2
.LC39:
	.string	"Jacket Armor"
	.align 2
.LC40:
	.string	"Combat Armor"
	.align 2
.LC41:
	.string	"Body Armor"
	.align 2
.LC42:
	.long 0x0
	.align 3
.LC43:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_BackPack
	.type	 Pickup_BackPack,@function
Pickup_BackPack:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 27,3
	mr 29,4
	lwz 9,908(27)
	cmpwi 0,9,0
	bc 4,1,.L193
	lwz 0,908(29)
	cmpw 0,0,9
	bc 12,2,.L193
	li 3,0
	b .L278
.L279:
	mr 8,31
	b .L201
.L280:
	mr 8,31
	b .L210
.L281:
	mr 8,31
	b .L219
.L282:
	mr 8,31
	b .L228
.L283:
	mr 8,31
	b .L237
.L284:
	mr 8,31
	b .L246
.L285:
	mr 8,31
	b .L256
.L286:
	mr 8,31
	b .L265
.L287:
	mr 8,31
	b .L274
.L193:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC31@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC31@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L202
	mr 28,10
.L197:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L199
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L279
.L199:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L197
.L202:
	li 8,0
.L201:
	cmpwi 0,8,0
	bc 12,2,.L203
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,8
	lwz 10,1772(11)
	mullw 9,9,0
	addi 11,11,748
	srawi 0,9,3
	slwi 0,0,2
	stwx 10,11,0
.L203:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC32@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC32@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L211
	mr 28,10
.L206:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L208
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L280
.L208:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L206
.L211:
	li 8,0
.L210:
	cmpwi 0,8,0
	bc 12,2,.L212
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,8
	lwz 10,1776(11)
	mullw 9,9,0
	addi 11,11,748
	srawi 0,9,3
	slwi 0,0,2
	stwx 10,11,0
.L212:
	lwz 10,84(29)
	lis 9,game@ha
	li 30,0
	la 8,game@l(9)
	lis 11,.LC35@ha
	lwz 0,736(10)
	lis 9,itemlist@ha
	la 26,.LC35@l(11)
	la 31,itemlist@l(9)
	stw 0,732(10)
	lwz 9,84(29)
	lwz 0,736(9)
	stw 0,728(29)
	lwz 9,1556(8)
	cmpw 0,30,9
	bc 4,0,.L220
	mr 28,8
.L215:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L217
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L281
.L217:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L215
.L220:
	li 8,0
.L219:
	cmpwi 0,8,0
	bc 12,2,.L221
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,8
	lwz 10,1780(11)
	mullw 9,9,0
	addi 11,11,748
	srawi 0,9,3
	slwi 0,0,2
	stwx 10,11,0
.L221:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC36@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC36@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L229
	mr 28,10
.L224:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L226
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L282
.L226:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L224
.L229:
	li 8,0
.L228:
	cmpwi 0,8,0
	bc 12,2,.L230
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,8
	lwz 10,1792(11)
	mullw 9,9,0
	addi 11,11,748
	srawi 0,9,3
	slwi 0,0,2
	stwx 10,11,0
.L230:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC37@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC37@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L238
	mr 28,10
.L233:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L235
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L283
.L235:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L233
.L238:
	li 8,0
.L237:
	cmpwi 0,8,0
	bc 12,2,.L239
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,8
	lwz 10,1788(11)
	mullw 9,9,0
	addi 11,11,748
	srawi 0,9,3
	slwi 0,0,2
	stwx 10,11,0
.L239:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC38@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC38@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L247
	mr 28,10
.L242:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L244
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L284
.L244:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L242
.L247:
	li 8,0
.L246:
	cmpwi 0,8,0
	bc 12,2,.L248
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,8
	lwz 10,1784(11)
	mullw 9,9,0
	addi 11,11,748
	srawi 0,9,3
	slwi 0,0,2
	stwx 10,11,0
.L248:
	lwz 9,84(29)
	lwz 0,724(9)
	cmpwi 0,0,1
	bc 4,2,.L249
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC39@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC39@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L257
	mr 28,10
.L252:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L254
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L285
.L254:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L252
.L257:
	li 8,0
.L256:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 10,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,8
	mullw 9,9,0
	srawi 9,9,3
	stw 9,744(10)
	lwz 11,84(29)
	lwz 0,744(11)
	addi 10,11,748
	lwz 9,728(11)
	slwi 0,0,2
	stwx 9,10,0
.L249:
	lwz 9,84(29)
	lwz 0,724(9)
	cmpwi 0,0,2
	bc 4,2,.L258
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC40@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC40@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L266
	mr 28,10
.L261:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L263
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L286
.L263:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L261
.L266:
	li 8,0
.L265:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 10,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,8
	mullw 9,9,0
	srawi 9,9,3
	stw 9,744(10)
	lwz 11,84(29)
	lwz 0,744(11)
	addi 10,11,748
	lwz 9,728(11)
	slwi 0,0,2
	stwx 9,10,0
.L258:
	lwz 9,84(29)
	lwz 0,724(9)
	cmpwi 0,0,3
	bc 4,2,.L267
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC41@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC41@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L275
	mr 28,10
.L270:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L272
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L287
.L272:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L270
.L275:
	li 8,0
.L274:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 10,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,8
	mullw 9,9,0
	srawi 9,9,3
	stw 9,744(10)
	lwz 11,84(29)
	lwz 0,744(11)
	addi 10,11,748
	lwz 9,728(11)
	slwi 0,0,2
	stwx 9,10,0
.L267:
	lwz 0,288(27)
	andis. 4,0,0x1
	bc 4,2,.L276
	lis 9,.LC42@ha
	lis 11,deathmatch@ha
	la 9,.LC42@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L276
	lis 9,.LC43@ha
	lwz 11,1000(27)
	la 9,.LC43@l(9)
	lis 7,0x4330
	lwz 0,268(27)
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
	stw 0,268(27)
	stw 9,20(1)
	ori 11,11,1
	stw 7,16(1)
	lfd 0,16(1)
	stw 11,184(27)
	stw 4,248(27)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,680(27)
	frsp 0,0
	fadds 13,13,0
	stfs 13,672(27)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L276:
	li 3,1
.L278:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 Pickup_BackPack,.Lfe8-Pickup_BackPack
	.section	".rodata"
	.align 2
.LC44:
	.long 0x0
	.align 3
.LC45:
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
	lis 11,.LC31@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC31@l(11)
	mr 27,3
	mr 29,4
	cmpw 0,30,0
	la 31,itemlist@l(9)
	bc 4,0,.L296
	mr 28,10
.L291:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L293
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L293
	mr 8,31
	b .L295
.L293:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L291
.L296:
	li 8,0
.L295:
	cmpwi 0,8,0
	bc 12,2,.L297
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1772(9)
	addi 9,9,748
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L297
	stwx 11,9,8
.L297:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC32@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC32@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L306
	mr 28,10
.L301:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L303
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L303
	mr 8,31
	b .L305
.L303:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L301
.L306:
	li 8,0
.L305:
	cmpwi 0,8,0
	bc 12,2,.L307
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1776(9)
	addi 9,9,748
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L307
	stwx 11,9,8
.L307:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC37@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC37@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L316
	mr 28,10
.L311:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L313
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L313
	mr 8,31
	b .L315
.L313:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L311
.L316:
	li 8,0
.L315:
	cmpwi 0,8,0
	bc 12,2,.L317
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1788(9)
	addi 9,9,748
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L317
	stwx 11,9,8
.L317:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC38@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC38@l(11)
	la 31,itemlist@l(9)
	cmpw 0,30,0
	bc 4,0,.L326
	mr 28,10
.L321:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L323
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L323
	mr 8,31
	b .L325
.L323:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L321
.L326:
	li 8,0
.L325:
	cmpwi 0,8,0
	bc 12,2,.L327
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1784(9)
	addi 9,9,748
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L327
	stwx 11,9,8
.L327:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC35@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC35@l(11)
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
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	lwz 11,1780(9)
	addi 9,9,748
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L337
	stwx 11,9,8
.L337:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lis 11,.LC36@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 26,.LC36@l(11)
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
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(29)
	addi 4,9,748
	lwz 11,1792(9)
	lwzx 0,4,8
	cmpw 0,0,11
	bc 4,1,.L347
	stwx 11,4,8
.L347:
	lwz 0,288(27)
	andis. 4,0,0x1
	bc 4,2,.L349
	lis 9,.LC44@ha
	lis 11,deathmatch@ha
	la 9,.LC44@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L349
	lis 9,.LC45@ha
	lwz 11,1000(27)
	la 9,.LC45@l(9)
	lis 7,0x4330
	lwz 0,268(27)
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
	stw 0,268(27)
	stw 9,20(1)
	ori 11,11,1
	stw 7,16(1)
	lfd 0,16(1)
	stw 11,184(27)
	stw 4,248(27)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,680(27)
	frsp 0,0
	fadds 13,13,0
	stfs 13,672(27)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L349:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 Pickup_Pack,.Lfe9-Pickup_Pack
	.section	".rodata"
	.align 2
.LC46:
	.string	"items/damage.wav"
	.align 3
.LC47:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC48:
	.long 0x3f800000
	.align 2
.LC49:
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
	addi 11,11,748
	slwi 4,4,2
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 11,quad_drop_timeout_hack@ha
	lwz 9,quad_drop_timeout_hack@l(11)
	cmpwi 0,9,0
	bc 12,2,.L352
	li 0,0
	mr 10,9
	stw 0,quad_drop_timeout_hack@l(11)
	b .L353
.L352:
	li 10,300
.L353:
	lis 11,level@ha
	lwz 8,84(31)
	lwz 11,level@l(11)
	lis 7,0x4330
	lis 6,.LC47@ha
	la 6,.LC47@l(6)
	lfs 12,3876(8)
	xoris 0,11,0x8000
	lfd 13,0(6)
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L354
	xoris 0,10,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fadds 0,12,0
	b .L356
.L354:
	add 0,11,10
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
.L356:
	stfs 0,3876(8)
	lis 29,gi@ha
	lis 3,.LC46@ha
	la 29,gi@l(29)
	la 3,.LC46@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 6,.LC48@ha
	lwz 0,16(29)
	lis 9,.LC48@ha
	la 6,.LC48@l(6)
	mr 5,3
	lfs 1,0(6)
	la 9,.LC48@l(9)
	li 4,3
	mtlr 0
	lis 6,.LC49@ha
	mr 3,31
	lfs 2,0(9)
	la 6,.LC49@l(6)
	lfs 3,0(6)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 Use_Quad,.Lfe10-Use_Quad
	.section	".rodata"
	.align 2
.LC50:
	.string	"%s got the BLUE flag.\n"
	.align 2
.LC51:
	.string	"ctf/flagtk.wav"
	.align 2
.LC52:
	.string	"%s got the RED flag.\n"
	.align 2
.LC53:
	.string	"items/protect.wav"
	.align 3
.LC54:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC55:
	.long 0x43960000
	.align 2
.LC56:
	.long 0x3f800000
	.align 2
.LC57:
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
	addi 11,11,748
	slwi 4,4,2
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC54@ha
	lis 11,level@ha
	lwz 10,84(31)
	la 9,.LC54@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3880(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L366
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L368
.L366:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L368:
	stfs 0,3880(10)
	lis 29,gi@ha
	lis 3,.LC53@ha
	la 29,gi@l(29)
	la 3,.LC53@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC56@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC56@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 2,0(9)
	lis 9,.LC57@ha
	la 9,.LC57@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 Use_Invulnerability,.Lfe11-Use_Invulnerability
	.section	".rodata"
	.align 2
.LC58:
	.string	"key_power_cube"
	.align 2
.LC59:
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
	lis 11,.LC59@ha
	lis 9,coop@ha
	la 11,.LC59@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 30,4
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L371
	lwz 3,284(31)
	lis 4,.LC58@ha
	la 4,.LC58@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L372
	lwz 10,84(30)
	lbz 9,290(31)
	lwz 0,1856(10)
	and. 11,0,9
	bc 4,2,.L377
	lwz 0,1000(31)
	lis 9,itemlist@ha
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	subf 0,9,0
	addi 10,10,748
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lwz 11,84(30)
	lbz 9,290(31)
	lwz 0,1856(11)
	or 0,0,9
	stw 0,1856(11)
	b .L374
.L372:
	lwz 0,1000(31)
	lis 9,itemlist@ha
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	lwz 10,84(30)
	subf 0,9,0
	mullw 0,0,11
	addi 4,10,748
	srawi 0,0,3
	slwi 3,0,2
	lwzx 9,4,3
	cmpwi 0,9,0
	bc 12,2,.L375
.L377:
	li 3,0
	b .L376
.L375:
	li 0,1
	stwx 0,4,3
.L374:
	li 3,1
	b .L376
.L371:
	lwz 0,1000(31)
	lis 9,itemlist@ha
	lis 11,0x38e3
	la 9,itemlist@l(9)
	ori 11,11,36409
	lwz 10,84(30)
	subf 0,9,0
	li 3,1
	mullw 0,0,11
	addi 10,10,748
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
.L376:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 Pickup_Key,.Lfe12-Pickup_Key
	.align 2
	.globl Add_Ammo
	.type	 Add_Ammo,@function
Add_Ammo:
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 4,2,.L379
.L395:
	li 3,0
	blr
.L379:
	lwz 0,64(4)
	cmpwi 0,0,0
	bc 4,2,.L380
	lwz 10,1772(9)
	b .L381
.L380:
	cmpwi 0,0,1
	bc 4,2,.L382
	lwz 10,1776(9)
	b .L381
.L382:
	cmpwi 0,0,2
	bc 4,2,.L384
	lwz 10,1780(9)
	b .L381
.L384:
	cmpwi 0,0,3
	bc 4,2,.L386
	lwz 10,1784(9)
	b .L381
.L386:
	cmpwi 0,0,4
	bc 4,2,.L388
	lwz 10,1788(9)
	b .L381
.L388:
	cmpwi 0,0,5
	bc 4,2,.L395
	lwz 10,1792(9)
.L381:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(3)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,4
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 4,9,2
	lwzx 0,11,4
	cmpw 0,0,10
	bc 12,2,.L395
	add 0,0,5
	stwx 0,11,4
	lwz 9,84(3)
	addi 3,9,748
	lwzx 0,3,4
	cmpw 0,0,10
	bc 4,1,.L393
	stwx 10,3,4
.L393:
	li 3,1
	blr
.Lfe13:
	.size	 Add_Ammo,.Lfe13-Add_Ammo
	.section	".rodata"
	.align 2
.LC60:
	.string	"blaster"
	.align 2
.LC61:
	.long 0x0
	.align 2
.LC62:
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
	lwz 4,1000(29)
	lwz 0,56(4)
	andi. 30,0,1
	bc 12,2,.L397
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8192
	li 5,1000
	bc 4,2,.L398
.L397:
	lwz 5,808(29)
	cmpwi 0,5,0
	bc 12,2,.L399
	lwz 4,1000(29)
	b .L398
.L399:
	lwz 9,1000(29)
	lwz 5,48(9)
	mr 4,9
.L398:
	lis 10,itemlist@ha
	lis 9,0x38e3
	lwz 11,84(28)
	la 27,itemlist@l(10)
	ori 9,9,36409
	subf 0,27,4
	addi 11,11,748
	mullw 0,0,9
	mr 3,28
	srawi 0,0,3
	slwi 0,0,2
	lwzx 31,11,0
	bl Add_Ammo
	cmpwi 0,3,0
	bc 4,2,.L401
	li 3,0
	b .L415
.L416:
	mr 9,31
	b .L411
.L401:
	subfic 9,31,0
	adde 0,9,31
	and. 11,30,0
	bc 12,2,.L402
	lwz 25,84(28)
	lwz 9,1000(29)
	lwz 0,1848(25)
	cmpw 0,0,9
	bc 12,2,.L402
	lis 9,.LC61@ha
	lis 11,deathmatch@ha
	la 9,.LC61@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L404
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,.LC60@ha
	lwz 0,1556(9)
	la 26,.LC60@l(11)
	mr 31,27
	cmpw 0,30,0
	bc 4,0,.L412
	mr 27,9
.L407:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L409
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L416
.L409:
	lwz 0,1556(27)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L407
.L412:
	li 9,0
.L411:
	lwz 0,1848(25)
	cmpw 0,0,9
	bc 4,2,.L402
.L404:
	lwz 9,84(28)
	lwz 0,1000(29)
	stw 0,3648(9)
.L402:
	lwz 0,288(29)
	andis. 7,0,0x3
	bc 4,2,.L413
	lis 9,.LC61@ha
	lis 11,deathmatch@ha
	la 9,.LC61@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L413
	lwz 9,268(29)
	lis 11,.LC62@ha
	lis 10,level+4@ha
	lwz 0,184(29)
	la 11,.LC62@l(11)
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
	stw 11,680(29)
	stfs 0,672(29)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
.L413:
	li 3,1
.L415:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe14:
	.size	 Pickup_Ammo,.Lfe14-Pickup_Ammo
	.section	".rodata"
	.align 2
.LC63:
	.string	"items/s_health.wav"
	.align 2
.LC64:
	.string	"items/n_health.wav"
	.align 2
.LC65:
	.string	"items/l_health.wav"
	.align 2
.LC66:
	.string	"items/m_health.wav"
	.align 2
.LC67:
	.long 0x40a00000
	.align 2
.LC68:
	.long 0x0
	.align 2
.LC69:
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
	lwz 0,996(7)
	andi. 8,0,1
	bc 4,2,.L426
	lwz 9,728(4)
	lwz 0,756(4)
	cmpw 0,9,0
	bc 12,0,.L426
	li 3,0
	b .L440
.L426:
	lwz 0,728(4)
	lwz 9,808(7)
	add 0,0,9
	stw 0,728(4)
	lwz 0,808(7)
	cmpwi 0,0,2
	bc 4,2,.L428
	lwz 11,1000(7)
	lis 9,.LC63@ha
	la 9,.LC63@l(9)
	b .L441
.L428:
	cmpwi 0,0,10
	bc 4,2,.L430
	lwz 11,1000(7)
	lis 9,.LC64@ha
	la 9,.LC64@l(9)
	b .L441
.L430:
	cmpwi 0,0,25
	bc 4,2,.L432
	lwz 11,1000(7)
	lis 9,.LC65@ha
	la 9,.LC65@l(9)
	b .L441
.L432:
	lwz 11,1000(7)
	lis 9,.LC66@ha
	la 9,.LC66@l(9)
.L441:
	stw 9,20(11)
	lwz 0,996(7)
	andi. 9,0,1
	bc 4,2,.L434
	lwz 0,728(4)
	lwz 9,756(4)
	cmpw 0,0,9
	bc 4,1,.L434
	stw 9,728(4)
.L434:
	lwz 0,996(7)
	andi. 11,0,2
	bc 12,2,.L436
	lis 9,MegaHealth_think@ha
	lis 8,.LC67@ha
	lwz 11,268(7)
	la 9,MegaHealth_think@l(9)
	lis 10,level+4@ha
	lwz 0,184(7)
	stw 9,680(7)
	la 8,.LC67@l(8)
	oris 11,11,0x8000
	lfs 0,level+4@l(10)
	li 9,0
	ori 0,0,1
	lfs 13,0(8)
	stw 9,248(7)
	stw 4,256(7)
	fadds 0,0,13
	stw 11,268(7)
	stw 0,184(7)
	stfs 0,672(7)
	b .L437
.L436:
	lwz 0,288(7)
	andis. 6,0,0x1
	bc 4,2,.L437
	lis 9,.LC68@ha
	lis 11,deathmatch@ha
	la 9,.LC68@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L437
	lwz 9,268(7)
	lis 11,.LC69@ha
	lis 10,level+4@ha
	lwz 0,184(7)
	la 11,.LC69@l(11)
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
	stw 11,680(7)
	stfs 0,672(7)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
.L437:
	li 3,1
.L440:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 Pickup_Health,.Lfe15-Pickup_Health
	.section	".rodata"
	.align 3
.LC70:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC71:
	.long 0x0
	.align 2
.LC72:
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
	lwz 9,1000(31)
	cmpwi 0,11,0
	lwz 7,60(9)
	bc 4,2,.L448
	li 6,0
	b .L449
.L448:
	lis 9,jacket_armor_index@ha
	addi 8,11,748
	lwz 6,jacket_armor_index@l(9)
	slwi 0,6,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L449
	lis 9,combat_armor_index@ha
	lwz 6,combat_armor_index@l(9)
	slwi 0,6,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L449
	lis 9,body_armor_index@ha
	lwz 10,body_armor_index@l(9)
	slwi 11,10,2
	lwzx 9,8,11
	srawi 0,9,31
	subf 0,9,0
	srawi 0,0,31
	and 6,10,0
.L449:
	lwz 8,1000(31)
	lwz 0,64(8)
	cmpwi 0,0,4
	bc 4,2,.L453
	cmpwi 0,6,0
	bc 4,2,.L454
	lis 11,jacket_armor_index@ha
	lwz 9,84(12)
	li 10,2
	lwz 0,jacket_armor_index@l(11)
	addi 9,9,748
	slwi 0,0,2
	stwx 10,9,0
	b .L456
.L454:
	lwz 9,84(12)
	slwi 0,6,2
	addi 9,9,748
	lwzx 11,9,0
	addi 11,11,2
	stwx 11,9,0
	b .L456
.L453:
	cmpwi 0,6,0
	bc 4,2,.L457
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(12)
	la 9,itemlist@l(9)
	ori 0,0,36409
	lwz 10,0(7)
	subf 9,9,8
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	stwx 10,11,9
	b .L456
.L457:
	lis 9,jacket_armor_index@ha
	lwz 0,jacket_armor_index@l(9)
	cmpw 0,6,0
	bc 4,2,.L459
	lis 9,jacketarmor_info@ha
	la 11,jacketarmor_info@l(9)
	b .L460
.L459:
	lis 9,combat_armor_index@ha
	lwz 0,combat_armor_index@l(9)
	cmpw 0,6,0
	bc 4,2,.L461
	lis 9,combatarmor_info@ha
	la 11,combatarmor_info@l(9)
	b .L460
.L461:
	lis 9,bodyarmor_info@ha
	la 11,bodyarmor_info@l(9)
.L460:
	lfs 13,8(7)
	lfs 0,8(11)
	fcmpu 0,13,0
	bc 4,1,.L463
	fdivs 11,0,13
	lwz 9,84(12)
	slwi 6,6,2
	lis 5,0x4330
	lis 10,.LC70@ha
	lwz 3,0(7)
	addi 9,9,748
	la 10,.LC70@l(10)
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
	lwz 9,1000(31)
	lwz 11,84(12)
	subf 9,10,9
	mullw 9,9,0
	addi 11,11,748
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
	b .L456
.L463:
	fdivs 11,13,0
	lwz 0,0(7)
	lis 8,0x4330
	lis 10,.LC70@ha
	mr 7,9
	lwz 11,4(11)
	xoris 0,0,0x8000
	la 10,.LC70@l(10)
	stw 0,20(1)
	slwi 6,6,2
	stw 8,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lwz 10,84(12)
	addi 4,10,748
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
	bc 12,0,.L467
	li 3,0
	b .L470
.L467:
	stwx 0,4,6
.L456:
	lwz 0,288(31)
	andis. 7,0,0x1
	bc 4,2,.L468
	lis 9,.LC71@ha
	lis 11,deathmatch@ha
	la 9,.LC71@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L468
	lwz 9,268(31)
	lis 11,.LC72@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC72@l(11)
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
	stw 11,680(31)
	stfs 0,672(31)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
.L468:
	li 3,1
.L470:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 Pickup_Armor,.Lfe16-Pickup_Armor
	.section	".rodata"
	.align 2
.LC73:
	.string	"misc/power2.wav"
	.align 2
.LC74:
	.string	"cells"
	.align 2
.LC75:
	.string	"No cells for power armor.\n"
	.align 2
.LC76:
	.string	"misc/power1.wav"
	.align 2
.LC77:
	.long 0x3f800000
	.align 2
.LC78:
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
	bc 12,2,.L477
	rlwinm 0,0,0,20,18
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,268(30)
	lis 3,.LC73@ha
	lwz 9,36(29)
	la 3,.LC73@l(3)
	mtlr 9
	blrl
	lis 9,.LC77@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC77@l(9)
	li 4,0
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
	b .L476
.L488:
	mr 10,29
	b .L485
.L477:
	lis 9,game@ha
	li 31,0
	la 10,game@l(9)
	lis 11,.LC74@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 27,.LC74@l(11)
	la 29,itemlist@l(9)
	cmpw 0,31,0
	bc 4,0,.L486
	mr 28,10
.L481:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L483
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L488
.L483:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,72
	cmpw 0,31,0
	bc 12,0,.L481
.L486:
	li 10,0
.L485:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L487
	lis 9,gi+8@ha
	lis 5,.LC75@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC75@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L476
.L487:
	lwz 0,268(30)
	lis 29,gi@ha
	lis 3,.LC76@ha
	la 29,gi@l(29)
	la 3,.LC76@l(3)
	ori 0,0,4096
	stw 0,268(30)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC77@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC77@l(9)
	li 4,0
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
.L476:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 Use_PowerArmor,.Lfe17-Use_PowerArmor
	.section	".rodata"
	.align 2
.LC79:
	.long 0x0
	.align 3
.LC80:
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
	lwz 0,1000(31)
	la 9,itemlist@l(9)
	lis 11,0x38e3
	ori 11,11,36409
	mr 29,4
	subf 0,9,0
	lwz 10,84(29)
	mullw 0,0,11
	lis 9,deathmatch@ha
	lwz 8,deathmatch@l(9)
	addi 10,10,748
	srawi 0,0,3
	lis 9,.LC79@ha
	slwi 0,0,2
	la 9,.LC79@l(9)
	lwzx 30,10,0
	lfs 13,0(9)
	addi 9,30,1
	stwx 9,10,0
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L490
	lwz 0,288(31)
	andis. 4,0,0x1
	bc 4,2,.L491
	lis 9,.LC80@ha
	lwz 11,1000(31)
	la 9,.LC80@l(9)
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
	stw 10,680(31)
	frsp 0,0
	fadds 13,13,0
	stfs 13,672(31)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L491:
	cmpwi 0,30,0
	bc 4,2,.L490
	lwz 9,1000(31)
	mr 3,29
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L490:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 Pickup_PowerArmor,.Lfe18-Pickup_PowerArmor
	.section	".rodata"
	.align 3
.LC81:
	.long 0x40080000
	.long 0x0
	.align 2
.LC82:
	.long 0x3f800000
	.align 2
.LC83:
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
	bc 12,2,.L497
	lwz 0,728(30)
	cmpwi 0,0,0
	bc 4,1,.L497
	lwz 9,1000(31)
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 12,2,.L497
	mtlr 0
	blrl
	mr. 28,3
	bc 12,2,.L501
	lwz 11,84(30)
	lis 0,0x3e80
	lis 9,gi@ha
	la 29,gi@l(9)
	stw 0,3736(11)
	lwz 9,1000(31)
	lwz 11,40(29)
	lwz 3,36(9)
	mtlr 11
	blrl
	lis 9,itemlist@ha
	lwz 11,84(30)
	lis 8,0x38e3
	la 7,itemlist@l(9)
	ori 8,8,36409
	lis 9,.LC81@ha
	sth 3,134(11)
	lis 10,level+4@ha
	la 9,.LC81@l(9)
	lwz 11,84(30)
	lfd 13,0(9)
	lwz 9,1000(31)
	subf 9,7,9
	mullw 9,9,8
	srawi 9,9,3
	addi 9,9,1056
	sth 9,136(11)
	lfs 0,level+4@l(10)
	lwz 9,84(30)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3908(9)
	lwz 9,1000(31)
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 12,2,.L502
	subf 0,7,9
	lwz 11,84(30)
	mullw 0,0,8
	srawi 0,0,3
	extsh 9,0
	sth 0,144(11)
	stw 9,744(11)
.L502:
	lwz 9,1000(31)
	lwz 11,36(29)
	lwz 3,20(9)
	mtlr 11
	blrl
	lis 9,.LC82@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC82@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC82@ha
	la 9,.LC82@l(9)
	lfs 2,0(9)
	lis 9,.LC83@ha
	la 9,.LC83@l(9)
	lfs 3,0(9)
	blrl
.L501:
	lwz 0,288(31)
	andis. 9,0,4
	bc 4,2,.L503
	mr 4,30
	mr 3,31
	bl G_UseTargets
	lwz 0,288(31)
	oris 0,0,0x4
	stw 0,288(31)
.L503:
	cmpwi 0,28,0
	bc 12,2,.L497
	lis 9,.LC83@ha
	lis 11,coop@ha
	la 9,.LC83@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L506
	lwz 9,1000(31)
	lwz 0,56(9)
	andi. 9,0,8
	bc 12,2,.L506
	lwz 0,288(31)
	andis. 9,0,0x3
	bc 12,2,.L497
.L506:
	lwz 0,268(31)
	cmpwi 0,0,0
	bc 4,0,.L507
	rlwinm 0,0,0,1,31
	stw 0,268(31)
	b .L497
.L507:
	mr 3,31
	bl G_FreeEdict
.L497:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 Touch_Item,.Lfe19-Touch_Item
	.section	".rodata"
	.align 2
.LC84:
	.long 0x42c80000
	.align 2
.LC85:
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
	stw 29,1000(31)
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
	stw 9,688(31)
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 12,2,.L514
	addi 29,1,24
	addi 4,1,8
	addi 3,3,3752
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
	b .L516
.L514:
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
.L516:
	stfs 0,12(31)
	lis 9,.LC84@ha
	addi 3,1,8
	la 9,.LC84@l(9)
	addi 4,31,620
	lfs 1,0(9)
	bl VectorScale
	lis 9,drop_make_touchable@ha
	lis 0,0x4396
	la 9,drop_make_touchable@l(9)
	stw 0,628(31)
	lis 11,level+4@ha
	stw 9,680(31)
	mr 3,31
	lis 9,.LC85@ha
	lfs 0,level+4@l(11)
	la 9,.LC85@l(9)
	lfs 13,0(9)
	lis 9,gi+72@ha
	fadds 0,0,13
	stfs 0,672(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	lwz 0,148(1)
	mtlr 0
	lmw 26,120(1)
	la 1,144(1)
	blr
.Lfe20:
	.size	 Drop_Item,.Lfe20-Drop_Item
	.align 2
	.globl Dropped_Flag
	.type	 Dropped_Flag,@function
Dropped_Flag:
	stwu 1,-80(1)
	mflr 0
	stmw 27,60(1)
	stw 0,84(1)
	mr 31,4
	lis 30,.LC0@ha
	lwz 3,0(31)
	la 4,.LC0@l(30)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L518
	lis 9,gi@ha
	la 28,.LC0@l(30)
	la 29,gi@l(9)
	li 31,0
	li 30,1
	b .L524
.L526:
	lwz 0,288(31)
	andis. 9,0,1
	bc 12,2,.L527
	mr 3,31
	bl G_FreeEdict
	b .L524
.L527:
	lwz 0,184(31)
	mr 3,31
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	stw 30,80(31)
.L524:
	mr 3,31
	li 4,284
	mr 5,28
	bl G_Find
	mr. 31,3
	bc 4,2,.L526
	b .L530
.L518:
	lwz 3,0(31)
	lis 31,.LC1@ha
	la 4,.LC1@l(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L530
	lis 9,gi@ha
	la 28,.LC1@l(31)
	la 29,gi@l(9)
	li 31,0
	li 30,1
	b .L537
.L539:
	lwz 0,288(31)
	andis. 9,0,1
	bc 12,2,.L540
	mr 3,31
	bl G_FreeEdict
	b .L537
.L540:
	lwz 0,184(31)
	mr 3,31
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	stw 30,80(31)
.L537:
	mr 3,31
	li 4,284
	mr 5,28
	bl G_Find
	mr. 31,3
	bc 4,2,.L539
.L530:
	mr 3,27
	lwz 0,84(1)
	mtlr 0
	lmw 27,60(1)
	la 1,80(1)
	blr
.Lfe21:
	.size	 Dropped_Flag,.Lfe21-Dropped_Flag
	.section	".rodata"
	.align 2
.LC86:
	.string	"droptofloor: %s startsolid at %s\n"
	.align 3
.LC87:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC88:
	.long 0xc1700000
	.align 2
.LC89:
	.long 0x41700000
	.align 2
.LC90:
	.long 0x0
	.align 2
.LC91:
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
	lis 9,.LC88@ha
	lis 11,.LC88@ha
	la 9,.LC88@l(9)
	la 11,.LC88@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC88@ha
	lfs 2,0(11)
	la 9,.LC88@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC89@ha
	lfs 13,0(11)
	la 9,.LC89@l(9)
	lfs 1,0(9)
	lis 9,.LC89@ha
	stfs 13,188(31)
	la 9,.LC89@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC89@ha
	stfs 0,192(31)
	la 9,.LC89@l(9)
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
	bc 12,2,.L547
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L548
.L547:
	lis 9,gi+44@ha
	lwz 11,1000(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L548:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC90@ha
	stw 9,688(31)
	addi 29,31,4
	la 11,.LC90@l(11)
	lis 9,.LC91@ha
	stw 0,264(31)
	lfs 1,0(11)
	la 9,.LC91@l(9)
	lis 11,.LC90@ha
	lfs 3,0(9)
	la 11,.LC90@l(11)
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
	bc 12,2,.L549
	mr 3,29
	lwz 29,284(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC86@ha
	la 3,.LC86@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L546
.L549:
	lwz 0,544(31)
	lfs 12,20(1)
	lfs 0,24(1)
	cmpwi 0,0,0
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L550
	lwz 11,840(31)
	lwz 0,268(31)
	lwz 9,184(31)
	cmpw 0,31,11
	lwz 10,836(31)
	rlwinm 0,0,0,22,20
	ori 9,9,1
	stw 0,268(31)
	stw 10,812(31)
	stw 9,184(31)
	stw 8,248(31)
	stw 8,836(31)
	bc 4,2,.L550
	lis 11,level+4@ha
	lis 10,.LC87@ha
	lfs 0,level+4@l(11)
	lis 9,DoRespawn@ha
	lfd 13,.LC87@l(10)
	la 9,DoRespawn@l(9)
	stw 9,680(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L550:
	lwz 0,288(31)
	andi. 9,0,2
	bc 12,2,.L552
	lwz 9,64(31)
	li 11,2
	li 10,0
	lwz 0,68(31)
	rlwinm 9,9,0,0,30
	stw 11,248(31)
	rlwinm 0,0,0,23,21
	stw 10,688(31)
	stw 9,64(31)
	stw 0,68(31)
.L552:
	lwz 0,288(31)
	andi. 11,0,1
	bc 12,2,.L553
	lwz 0,184(31)
	lis 9,Use_Item@ha
	li 11,0
	la 9,Use_Item@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,692(31)
	stw 0,184(31)
.L553:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L546:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe22:
	.size	 droptofloor,.Lfe22-droptofloor
	.section	".rodata"
	.align 2
.LC92:
	.string	"PrecacheItem: %s has bad precache string"
	.align 2
.LC93:
	.string	"md2"
	.align 2
.LC94:
	.string	"sp2"
	.align 2
.LC95:
	.string	"wav"
	.align 2
.LC96:
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
	bc 12,2,.L554
	lwz 3,20(26)
	cmpwi 0,3,0
	bc 12,2,.L556
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L556:
	lwz 3,24(26)
	cmpwi 0,3,0
	bc 12,2,.L557
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L557:
	lwz 3,32(26)
	cmpwi 0,3,0
	bc 12,2,.L558
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L558:
	lwz 3,36(26)
	cmpwi 0,3,0
	bc 12,2,.L559
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
.L559:
	lwz 29,52(26)
	cmpwi 0,29,0
	bc 12,2,.L560
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L560
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L568
	mr 28,9
.L563:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L565
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L565
	mr 3,31
	b .L567
.L565:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L563
.L568:
	li 3,0
.L567:
	cmpw 0,3,26
	bc 12,2,.L560
	bl PrecacheItem
.L560:
	lwz 30,68(26)
	cmpwi 0,30,0
	bc 12,2,.L554
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 12,2,.L554
	lis 9,gi@ha
	addi 29,1,8
	la 27,gi@l(9)
	lis 24,.LC93@ha
	lis 25,.LC96@ha
.L574:
	rlwinm 9,0,0,0xff
	mr 31,30
	b .L588
.L577:
	lbzu 9,1(30)
.L588:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L577
	subf 28,31,30
	addi 0,28,-5
	cmplwi 0,0,58
	bc 4,1,.L579
	lwz 9,28(27)
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	lwz 4,0(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L579:
	mr 4,31
	mr 5,28
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 0,0
	addi 11,30,1
	stbx 0,29,28
	add 9,29,28
	la 4,.LC93@l(24)
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
	bc 12,2,.L589
	lis 4,.LC94@ha
	mr 3,31
	la 4,.LC94@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L583
.L589:
	lwz 9,32(27)
	mr 3,29
	mtlr 9
	blrl
	b .L582
.L583:
	lis 4,.LC95@ha
	mr 3,31
	la 4,.LC95@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L582
	lwz 9,36(27)
	mr 3,29
	mtlr 9
	blrl
.L582:
	add 3,29,28
	la 4,.LC96@l(25)
	addi 3,3,-3
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L572
	lwz 9,40(27)
	mr 3,29
	mtlr 9
	blrl
.L572:
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L574
.L554:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe23:
	.size	 PrecacheItem,.Lfe23-PrecacheItem
	.section	".rodata"
	.align 2
.LC97:
	.string	"%s at %s has invalid spawnflags set\n"
	.align 2
.LC98:
	.string	"weapon_bfg"
	.align 3
.LC99:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC100:
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
	bc 12,2,.L591
	lwz 3,284(31)
	lis 4,.LC58@ha
	la 4,.LC58@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L591
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
	lis 3,.LC97@ha
	la 3,.LC97@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L591:
	lis 9,.LC100@ha
	lis 11,deathmatch@ha
	la 9,.LC100@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L593
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2048
	bc 12,2,.L594
	lwz 0,4(30)
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L604
	lis 9,Pickup_PowerArmor@ha
	la 9,Pickup_PowerArmor@l(9)
	cmpw 0,0,9
	bc 12,2,.L604
.L594:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,2
	bc 12,2,.L597
	lwz 0,4(30)
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L604
.L597:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 12,2,.L599
	lwz 0,4(30)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L604
	lis 9,Pickup_Adrenaline@ha
	la 9,Pickup_Adrenaline@l(9)
	cmpw 0,0,9
	bc 12,2,.L604
	lis 9,Pickup_AncientHead@ha
	la 9,Pickup_AncientHead@l(9)
	cmpw 0,0,9
	bc 12,2,.L604
.L599:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8192
	bc 12,2,.L593
	lwz 0,56(30)
	cmpwi 0,0,2
	bc 12,2,.L604
	lwz 3,284(31)
	lis 4,.LC98@ha
	la 4,.LC98@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L593
.L604:
	mr 3,31
	bl G_FreeEdict
	b .L590
.L593:
	lis 11,.LC100@ha
	lis 9,coop@ha
	la 11,.LC100@l(11)
	lis 29,level@ha
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L605
	lwz 3,284(31)
	lis 4,.LC58@ha
	la 4,.LC58@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L605
	la 10,level@l(29)
	lwz 11,288(31)
	li 0,1
	lwz 9,300(10)
	addi 9,9,8
	slw 0,0,9
	or 11,11,0
	stw 11,288(31)
	lwz 9,300(10)
	addi 9,9,1
	stw 9,300(10)
.L605:
	lis 9,.LC100@ha
	lis 11,coop@ha
	la 9,.LC100@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L606
	lwz 0,56(30)
	andi. 11,0,8
	bc 12,2,.L606
	li 0,0
	stw 0,12(30)
.L606:
	stw 30,1000(31)
	lis 11,level+4@ha
	lis 10,.LC99@ha
	lfs 0,level+4@l(11)
	lis 9,droptofloor@ha
	lfd 13,.LC99@l(10)
	la 9,droptofloor@l(9)
	li 11,512
	lwz 3,272(31)
	stw 9,680(31)
	cmpwi 0,3,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
	lwz 0,28(30)
	stw 11,68(31)
	stw 0,64(31)
	bc 12,2,.L590
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L590:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 SpawnItem,.Lfe24-SpawnItem
	.globl itemlist
	.section	".data"
	.align 2
	.type	 itemlist,@object
itemlist:
	.long 0
	.space	68
	.long .LC101
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC102
	.long .LC103
	.long 1
	.long 0
	.long .LC104
	.long .LC41
	.long 3
	.long 0
	.long 0
	.long 4
	.long bodyarmor_info
	.long 3
	.long .LC105
	.long .LC106
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC102
	.long .LC107
	.long 1
	.long 0
	.long .LC108
	.long .LC40
	.long 3
	.long 0
	.long 0
	.long 4
	.long combatarmor_info
	.long 2
	.long .LC105
	.long .LC109
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC102
	.long .LC110
	.long 1
	.long 0
	.long .LC111
	.long .LC39
	.long 3
	.long 0
	.long 0
	.long 4
	.long jacketarmor_info
	.long 1
	.long .LC105
	.long .LC112
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC113
	.long .LC114
	.long 1
	.long 0
	.long .LC111
	.long .LC115
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long 4
	.long .LC105
	.long .LC116
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC117
	.long .LC118
	.long 1
	.long 0
	.long .LC119
	.long .LC120
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long .LC105
	.long .LC121
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC117
	.long .LC122
	.long 1
	.long 0
	.long .LC123
	.long .LC124
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long .LC125
	.long .LC126
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Blaster
	.long .LC127
	.long 0
	.long 0
	.long .LC128
	.long .LC129
	.long .LC130
	.long 0
	.long 0
	.long 0
	.long 9
	.long 0
	.long 0
	.long .LC131
	.long .LC132
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Shotgun
	.long .LC127
	.long .LC133
	.long 1
	.long .LC134
	.long .LC135
	.long .LC136
	.long 0
	.long 1
	.long .LC32
	.long 9
	.long 0
	.long 0
	.long .LC137
	.long .LC138
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_tranquilizer
	.long .LC127
	.long .LC133
	.long 1
	.long .LC134
	.long .LC135
	.long .LC139
	.long 0
	.long 1
	.long .LC32
	.long 9
	.long 0
	.long 0
	.long .LC137
	.long .LC140
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_SuperShotgun
	.long .LC127
	.long .LC141
	.long 1
	.long .LC142
	.long .LC143
	.long .LC144
	.long 0
	.long 2
	.long .LC32
	.long 9
	.long 0
	.long 0
	.long .LC145
	.long .LC146
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Machinegun
	.long .LC127
	.long .LC147
	.long 1
	.long .LC148
	.long .LC149
	.long .LC150
	.long 0
	.long 1
	.long .LC31
	.long 9
	.long 0
	.long 0
	.long .LC151
	.long .LC152
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Chaingun
	.long .LC127
	.long .LC153
	.long 1
	.long .LC154
	.long .LC155
	.long .LC156
	.long 0
	.long 1
	.long .LC31
	.long 9
	.long 0
	.long 0
	.long .LC157
	.long .LC158
	.long Pickup_Ammo
	.long Use_Weapon
	.long Drop_Ammo
	.long Weapon_Grenade
	.long .LC159
	.long .LC160
	.long 0
	.long .LC161
	.long .LC162
	.long .LC38
	.long 3
	.long 5
	.long .LC163
	.long 3
	.long 0
	.long 3
	.long .LC164
	.long .LC165
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_GrenadeLauncher
	.long .LC127
	.long .LC166
	.long 1
	.long .LC167
	.long .LC168
	.long .LC169
	.long 0
	.long 1
	.long .LC38
	.long 9
	.long 0
	.long 0
	.long .LC170
	.long .LC171
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_RocketLauncher
	.long .LC127
	.long .LC172
	.long 1
	.long .LC173
	.long .LC174
	.long .LC175
	.long 0
	.long 1
	.long .LC35
	.long 9
	.long 0
	.long 0
	.long .LC176
	.long .LC177
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_HyperBlaster
	.long .LC127
	.long .LC178
	.long 1
	.long .LC179
	.long .LC180
	.long .LC181
	.long 0
	.long 1
	.long .LC37
	.long 9
	.long 0
	.long 0
	.long .LC182
	.long .LC183
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Railgun
	.long .LC127
	.long .LC184
	.long 1
	.long .LC185
	.long .LC186
	.long .LC187
	.long 0
	.long 1
	.long .LC36
	.long 9
	.long 0
	.long 0
	.long .LC188
	.long .LC98
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_BFG
	.long .LC127
	.long .LC189
	.long 1
	.long .LC190
	.long .LC191
	.long .LC192
	.long 0
	.long 50
	.long .LC37
	.long 9
	.long 0
	.long 0
	.long .LC193
	.long .LC194
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Sword
	.long .LC127
	.long 0
	.long 0
	.long .LC195
	.long .LC129
	.long .LC196
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC197
	.long .LC198
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC159
	.long .LC199
	.long 0
	.long 0
	.long .LC200
	.long .LC32
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 1
	.long .LC105
	.long .LC201
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC159
	.long .LC202
	.long 0
	.long 0
	.long .LC203
	.long .LC31
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long .LC105
	.long .LC204
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC159
	.long .LC205
	.long 0
	.long 0
	.long .LC206
	.long .LC37
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 4
	.long .LC105
	.long .LC207
	.long Pickup_BackPack
	.long 0
	.long 0
	.long 0
	.long .LC159
	.long .LC208
	.long 1
	.long 0
	.long .LC209
	.long .LC210
	.long 3
	.long 10
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC105
	.long .LC211
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC159
	.long .LC212
	.long 0
	.long 0
	.long .LC213
	.long .LC35
	.long 3
	.long 5
	.long 0
	.long 2
	.long 0
	.long 2
	.long .LC105
	.long .LC214
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC159
	.long .LC215
	.long 0
	.long 0
	.long .LC216
	.long .LC36
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 5
	.long .LC105
	.long .LC217
	.long Pickup_Powerup
	.long Use_Quad
	.long Drop_General
	.long 0
	.long .LC218
	.long .LC219
	.long 1
	.long 0
	.long .LC220
	.long .LC221
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long .LC222
	.long .LC0
	.long CTFPickup_Flag
	.long 0
	.long CTFDrop_Flag
	.long 0
	.long .LC51
	.long .LC223
	.long 262144
	.long 0
	.long .LC224
	.long .LC12
	.long 2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC7
	.long .LC1
	.long CTFPickup_Flag
	.long 0
	.long CTFDrop_Flag
	.long 0
	.long .LC51
	.long .LC225
	.long 524288
	.long 0
	.long .LC226
	.long .LC13
	.long 2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC7
	.long .LC227
	.long Pickup_Powerup
	.long Use_Invulnerability
	.long Drop_General
	.long 0
	.long .LC218
	.long .LC228
	.long 1
	.long 0
	.long .LC229
	.long .LC230
	.long 2
	.long 300
	.long 0
	.long 32
	.long 0
	.long 0
	.long .LC231
	.long .LC232
	.long Pickup_Powerup
	.long Use_Silencer
	.long Drop_General
	.long 0
	.long .LC218
	.long .LC233
	.long 1
	.long 0
	.long .LC234
	.long .LC235
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long .LC105
	.long .LC236
	.long Pickup_Powerup
	.long Use_Breather
	.long Drop_General
	.long 0
	.long .LC218
	.long .LC237
	.long 1
	.long 0
	.long .LC238
	.long .LC239
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long .LC240
	.long .LC241
	.long Pickup_Powerup
	.long Use_Envirosuit
	.long Drop_General
	.long 0
	.long .LC218
	.long .LC242
	.long 1
	.long 0
	.long .LC243
	.long .LC244
	.long 2
	.long 60
	.long 0
	.long 40
	.long 0
	.long 0
	.long .LC240
	.long .LC245
	.long Pickup_AncientHead
	.long 0
	.long 0
	.long 0
	.long .LC218
	.long .LC246
	.long 1
	.long 0
	.long .LC247
	.long .LC248
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC105
	.long .LC249
	.long Pickup_Adrenaline
	.long 0
	.long 0
	.long 0
	.long .LC218
	.long .LC250
	.long 1
	.long 0
	.long .LC251
	.long .LC252
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC105
	.long .LC253
	.long Pickup_Bandolier
	.long 0
	.long 0
	.long 0
	.long .LC218
	.long .LC254
	.long 1
	.long 0
	.long .LC255
	.long .LC256
	.long 2
	.long 60
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC105
	.long .LC257
	.long Pickup_Pack
	.long 0
	.long 0
	.long 0
	.long .LC218
	.long .LC208
	.long 1
	.long 0
	.long .LC209
	.long .LC258
	.long 2
	.long 180
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC105
	.long .LC259
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC218
	.long .LC260
	.long 1
	.long 0
	.long .LC261
	.long .LC262
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC105
	.long .LC58
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC218
	.long .LC263
	.long 1
	.long 0
	.long .LC264
	.long .LC265
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC105
	.long .LC266
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC218
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
	.long .LC105
	.long .LC270
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC218
	.long .LC271
	.long 1
	.long 0
	.long .LC272
	.long .LC273
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC105
	.long .LC274
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC218
	.long .LC275
	.long 1
	.long 0
	.long .LC276
	.long .LC277
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC105
	.long .LC278
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC218
	.long .LC279
	.long 1
	.long 0
	.long .LC280
	.long .LC281
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC105
	.long .LC282
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC218
	.long .LC283
	.long 1
	.long 0
	.long .LC284
	.long .LC285
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC105
	.long .LC286
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC218
	.long .LC287
	.long 2
	.long 0
	.long .LC288
	.long .LC289
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC105
	.long .LC290
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC218
	.long .LC291
	.long 1
	.long 0
	.long .LC292
	.long .LC293
	.long 2
	.long 0
	.long 0
	.long 24
	.long 0
	.long 0
	.long .LC105
	.long 0
	.long Pickup_Health
	.long 0
	.long 0
	.long 0
	.long .LC218
	.long 0
	.long 0
	.long 0
	.long .LC294
	.long .LC295
	.long 3
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC105
	.long 0
	.space	68
	.section	".rodata"
	.align 2
.LC295:
	.string	"Health"
	.align 2
.LC294:
	.string	"i_health"
	.align 2
.LC293:
	.string	"Airstrike Marker"
	.align 2
.LC292:
	.string	"i_airstrike"
	.align 2
.LC291:
	.string	"models/items/keys/target/tris.md2"
	.align 2
.LC290:
	.string	"key_airstrike_target"
	.align 2
.LC289:
	.string	"Commander's Head"
	.align 2
.LC288:
	.string	"k_comhead"
	.align 2
.LC287:
	.string	"models/monsters/commandr/head/tris.md2"
	.align 2
.LC286:
	.string	"key_commander_head"
	.align 2
.LC285:
	.string	"Red Key"
	.align 2
.LC284:
	.string	"k_redkey"
	.align 2
.LC283:
	.string	"models/items/keys/red_key/tris.md2"
	.align 2
.LC282:
	.string	"key_red_key"
	.align 2
.LC281:
	.string	"Blue Key"
	.align 2
.LC280:
	.string	"k_bluekey"
	.align 2
.LC279:
	.string	"models/items/keys/key/tris.md2"
	.align 2
.LC278:
	.string	"key_blue_key"
	.align 2
.LC277:
	.string	"Security Pass"
	.align 2
.LC276:
	.string	"k_security"
	.align 2
.LC275:
	.string	"models/items/keys/pass/tris.md2"
	.align 2
.LC274:
	.string	"key_pass"
	.align 2
.LC273:
	.string	"Data Spinner"
	.align 2
.LC272:
	.string	"k_dataspin"
	.align 2
.LC271:
	.string	"models/items/keys/spinner/tris.md2"
	.align 2
.LC270:
	.string	"key_data_spinner"
	.align 2
.LC269:
	.string	"Pyramid Key"
	.align 2
.LC268:
	.string	"k_pyramid"
	.align 2
.LC267:
	.string	"models/items/keys/pyramid/tris.md2"
	.align 2
.LC266:
	.string	"key_pyramid"
	.align 2
.LC265:
	.string	"Power Cube"
	.align 2
.LC264:
	.string	"k_powercube"
	.align 2
.LC263:
	.string	"models/items/keys/power/tris.md2"
	.align 2
.LC262:
	.string	"Data CD"
	.align 2
.LC261:
	.string	"k_datacd"
	.align 2
.LC260:
	.string	"models/items/keys/data_cd/tris.md2"
	.align 2
.LC259:
	.string	"key_data_cd"
	.align 2
.LC258:
	.string	"Ammo Pack"
	.align 2
.LC257:
	.string	"item_pack"
	.align 2
.LC256:
	.string	"Bandolier"
	.align 2
.LC255:
	.string	"p_bandolier"
	.align 2
.LC254:
	.string	"models/items/band/tris.md2"
	.align 2
.LC253:
	.string	"item_bandolier"
	.align 2
.LC252:
	.string	"Adrenaline"
	.align 2
.LC251:
	.string	"p_adrenaline"
	.align 2
.LC250:
	.string	"models/items/adrenal/tris.md2"
	.align 2
.LC249:
	.string	"item_adrenaline"
	.align 2
.LC248:
	.string	"Ancient Head"
	.align 2
.LC247:
	.string	"i_fixme"
	.align 2
.LC246:
	.string	"models/items/c_head/tris.md2"
	.align 2
.LC245:
	.string	"item_ancient_head"
	.align 2
.LC244:
	.string	"Environment Suit"
	.align 2
.LC243:
	.string	"p_envirosuit"
	.align 2
.LC242:
	.string	"models/items/enviro/tris.md2"
	.align 2
.LC241:
	.string	"item_enviro"
	.align 2
.LC240:
	.string	"items/airout.wav"
	.align 2
.LC239:
	.string	"Rebreather"
	.align 2
.LC238:
	.string	"p_rebreather"
	.align 2
.LC237:
	.string	"models/items/breather/tris.md2"
	.align 2
.LC236:
	.string	"item_breather"
	.align 2
.LC235:
	.string	"Silencer"
	.align 2
.LC234:
	.string	"p_silencer"
	.align 2
.LC233:
	.string	"models/items/silencer/tris.md2"
	.align 2
.LC232:
	.string	"item_silencer"
	.align 2
.LC231:
	.string	"items/protect.wav items/protect2.wav items/protect4.wav"
	.align 2
.LC230:
	.string	"Invulnerability"
	.align 2
.LC229:
	.string	"p_invulnerability"
	.align 2
.LC228:
	.string	"models/items/invulner/tris.md2"
	.align 2
.LC227:
	.string	"item_invulnerability"
	.align 2
.LC226:
	.string	"i_ctf2"
	.align 2
.LC225:
	.string	"players/male/flag2.md2"
	.align 2
.LC224:
	.string	"i_ctf1"
	.align 2
.LC223:
	.string	"players/male/flag1.md2"
	.align 2
.LC222:
	.string	"items/damage.wav items/damage2.wav items/damage3.wav"
	.align 2
.LC221:
	.string	"Quad Damage"
	.align 2
.LC220:
	.string	"p_quad"
	.align 2
.LC219:
	.string	"models/items/quaddama/tris.md2"
	.align 2
.LC218:
	.string	"items/pkup.wav"
	.align 2
.LC217:
	.string	"item_quad"
	.align 2
.LC216:
	.string	"a_slugs"
	.align 2
.LC215:
	.string	"models/items/ammo/slugs/medium/tris.md2"
	.align 2
.LC214:
	.string	"ammo_slugs"
	.align 2
.LC213:
	.string	"a_rockets"
	.align 2
.LC212:
	.string	"models/items/ammo/rockets/medium/tris.md2"
	.align 2
.LC211:
	.string	"ammo_rockets"
	.align 2
.LC210:
	.string	"Ammo Backpack"
	.align 2
.LC209:
	.string	"i_pack"
	.align 2
.LC208:
	.string	"models/items/pack/tris.md2"
	.align 2
.LC207:
	.string	"item_backpack"
	.align 2
.LC206:
	.string	"a_cells"
	.align 2
.LC205:
	.string	"models/items/ammo/cells/medium/tris.md2"
	.align 2
.LC204:
	.string	"ammo_cells"
	.align 2
.LC203:
	.string	"a_bullets"
	.align 2
.LC202:
	.string	"models/items/ammo/bullets/medium/tris.md2"
	.align 2
.LC201:
	.string	"ammo_bullets"
	.align 2
.LC200:
	.string	"a_shells"
	.align 2
.LC199:
	.string	"models/items/ammo/shells/medium/tris.md2"
	.align 2
.LC198:
	.string	"ammo_shells"
	.align 2
.LC197:
	.string	"weapons/hgrenlb1b.wav misc/fhit3.wav"
	.align 2
.LC196:
	.string	"Sword"
	.align 2
.LC195:
	.string	"models/weapons/v_q1axe/tris.md2"
	.align 2
.LC194:
	.string	"weapon_sword"
	.align 2
.LC193:
	.string	"sprites/s_bfg1.sp2 sprites/s_bfg2.sp2 sprites/s_bfg3.sp2 weapons/bfg__f1y.wav weapons/bfg__l1a.wav weapons/bfg__x1b.wav weapons/bfg_hum.wav"
	.align 2
.LC192:
	.string	"BFG10K"
	.align 2
.LC191:
	.string	"w_bfg"
	.align 2
.LC190:
	.string	"models/weapons/v_bfg/tris.md2"
	.align 2
.LC189:
	.string	"models/weapons/g_bfg/tris.md2"
	.align 2
.LC188:
	.string	"weapons/rg_hum.wav"
	.align 2
.LC187:
	.string	"Railgun"
	.align 2
.LC186:
	.string	"w_railgun"
	.align 2
.LC185:
	.string	"models/weapons/v_rail/tris.md2"
	.align 2
.LC184:
	.string	"models/weapons/g_rail/tris.md2"
	.align 2
.LC183:
	.string	"weapon_railgun"
	.align 2
.LC182:
	.string	"weapons/hyprbu1a.wav weapons/hyprbl1a.wav weapons/hyprbf1a.wav weapons/hyprbd1a.wav misc/lasfly.wav"
	.align 2
.LC181:
	.string	"HyperBlaster"
	.align 2
.LC180:
	.string	"w_hyperblaster"
	.align 2
.LC179:
	.string	"models/weapons/v_hyperb/tris.md2"
	.align 2
.LC178:
	.string	"models/weapons/g_hyperb/tris.md2"
	.align 2
.LC177:
	.string	"weapon_hyperblaster"
	.align 2
.LC176:
	.string	"models/objects/rocket/tris.md2 weapons/rockfly.wav weapons/rocklf1a.wav weapons/rocklr1b.wav models/objects/debris2/tris.md2"
	.align 2
.LC175:
	.string	"Rocket Launcher"
	.align 2
.LC174:
	.string	"w_rlauncher"
	.align 2
.LC173:
	.string	"models/weapons/v_rocket/tris.md2"
	.align 2
.LC172:
	.string	"models/weapons/g_rocket/tris.md2"
	.align 2
.LC171:
	.string	"weapon_rocketlauncher"
	.align 2
.LC170:
	.string	"models/objects/grenade/tris.md2 weapons/grenlf1a.wav weapons/grenlr1b.wav weapons/grenlb1b.wav"
	.align 2
.LC169:
	.string	"Grenade Launcher"
	.align 2
.LC168:
	.string	"w_glauncher"
	.align 2
.LC167:
	.string	"models/weapons/v_launch/tris.md2"
	.align 2
.LC166:
	.string	"models/weapons/g_launch/tris.md2"
	.align 2
.LC165:
	.string	"weapon_grenadelauncher"
	.align 2
.LC164:
	.string	"weapons/hgrent1a.wav weapons/hgrena1b.wav weapons/hgrenc1b.wav weapons/hgrenb1a.wav weapons/hgrenb2a.wav "
	.align 2
.LC163:
	.string	"grenades"
	.align 2
.LC162:
	.string	"a_grenades"
	.align 2
.LC161:
	.string	"models/weapons/v_handgr/tris.md2"
	.align 2
.LC160:
	.string	"models/items/ammo/grenades/medium/tris.md2"
	.align 2
.LC159:
	.string	"misc/am_pkup.wav"
	.align 2
.LC158:
	.string	"ammo_grenades"
	.align 2
.LC157:
	.string	"weapons/chngnu1a.wav weapons/chngnl1a.wav weapons/machgf3b.wav` weapons/chngnd1a.wav"
	.align 2
.LC156:
	.string	"Chaingun"
	.align 2
.LC155:
	.string	"w_chaingun"
	.align 2
.LC154:
	.string	"models/weapons/v_chain/tris.md2"
	.align 2
.LC153:
	.string	"models/weapons/g_chain/tris.md2"
	.align 2
.LC152:
	.string	"weapon_chaingun"
	.align 2
.LC151:
	.string	"weapons/machgf1b.wav weapons/machgf2b.wav weapons/machgf3b.wav weapons/machgf4b.wav weapons/machgf5b.wav"
	.align 2
.LC150:
	.string	"Machinegun"
	.align 2
.LC149:
	.string	"w_machinegun"
	.align 2
.LC148:
	.string	"models/weapons/v_machn/tris.md2"
	.align 2
.LC147:
	.string	"models/weapons/g_machn/tris.md2"
	.align 2
.LC146:
	.string	"weapon_machinegun"
	.align 2
.LC145:
	.string	"weapons/sshotf1b.wav"
	.align 2
.LC144:
	.string	"Super Shotgun"
	.align 2
.LC143:
	.string	"w_sshotgun"
	.align 2
.LC142:
	.string	"models/weapons/v_shotg2/tris.md2"
	.align 2
.LC141:
	.string	"models/weapons/g_shotg2/tris.md2"
	.align 2
.LC140:
	.string	"weapon_supershotgun"
	.align 2
.LC139:
	.string	"tranquilizer"
	.align 2
.LC138:
	.string	"weapon_tranquilizer"
	.align 2
.LC137:
	.string	"weapons/shotgf1b.wav weapons/shotgr1b.wav"
	.align 2
.LC136:
	.string	"Shotgun"
	.align 2
.LC135:
	.string	"w_shotgun"
	.align 2
.LC134:
	.string	"models/weapons/v_shotg/tris.md2"
	.align 2
.LC133:
	.string	"models/weapons/g_shotg/tris.md2"
	.align 2
.LC132:
	.string	"weapon_shotgun"
	.align 2
.LC131:
	.string	"weapons/blastf1a.wav misc/lasfly.wav"
	.align 2
.LC130:
	.string	"Blaster"
	.align 2
.LC129:
	.string	"w_blaster"
	.align 2
.LC128:
	.string	"models/weapons/v_blast/tris.md2"
	.align 2
.LC127:
	.string	"misc/w_pkup.wav"
	.align 2
.LC126:
	.string	"weapon_blaster"
	.align 2
.LC125:
	.string	"misc/power2.wav misc/power1.wav"
	.align 2
.LC124:
	.string	"Power Shield"
	.align 2
.LC123:
	.string	"i_powershield"
	.align 2
.LC122:
	.string	"models/items/armor/shield/tris.md2"
	.align 2
.LC121:
	.string	"item_power_shield"
	.align 2
.LC120:
	.string	"Power Screen"
	.align 2
.LC119:
	.string	"i_powerscreen"
	.align 2
.LC118:
	.string	"models/items/armor/screen/tris.md2"
	.align 2
.LC117:
	.string	"misc/ar3_pkup.wav"
	.align 2
.LC116:
	.string	"item_power_screen"
	.align 2
.LC115:
	.string	"Armor Shard"
	.align 2
.LC114:
	.string	"models/items/armor/shard/tris.md2"
	.align 2
.LC113:
	.string	"misc/ar2_pkup.wav"
	.align 2
.LC112:
	.string	"item_armor_shard"
	.align 2
.LC111:
	.string	"i_jacketarmor"
	.align 2
.LC110:
	.string	"models/items/armor/jacket/tris.md2"
	.align 2
.LC109:
	.string	"item_armor_jacket"
	.align 2
.LC108:
	.string	"i_combatarmor"
	.align 2
.LC107:
	.string	"models/items/armor/combat/tris.md2"
	.align 2
.LC106:
	.string	"item_armor_combat"
	.align 2
.LC105:
	.string	""
	.align 2
.LC104:
	.string	"i_bodyarmor"
	.align 2
.LC103:
	.string	"models/items/armor/body/tris.md2"
	.align 2
.LC102:
	.string	"misc/ar1_pkup.wav"
	.align 2
.LC101:
	.string	"item_armor_body"
	.size	 itemlist,3456
	.align 2
.LC296:
	.string	"models/items/healing/medium/tris.md2"
	.align 2
.LC297:
	.string	"models/items/healing/stimpack/tris.md2"
	.align 2
.LC298:
	.string	"models/items/healing/large/tris.md2"
	.align 2
.LC299:
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
	bc 4,0,.L651
	lis 11,itemlist@ha
	lis 9,gi@ha
	la 11,itemlist@l(11)
	la 28,gi@l(9)
	mr 29,10
	addi 30,11,40
.L653:
	lwz 9,24(28)
	addi 3,31,1056
	lwz 4,0(30)
	addi 31,31,1
	mtlr 9
	addi 30,30,72
	blrl
	lwz 0,1556(29)
	cmpw 0,31,0
	bc 12,0,.L653
.L651:
	lis 9,game@ha
	lis 11,jacket_armor_index@ha
	la 10,game@l(9)
	li 30,0
	lwz 0,1556(10)
	la 27,jacket_armor_index@l(11)
	lis 9,.LC39@ha
	lis 11,itemlist@ha
	la 28,.LC39@l(9)
	cmpw 0,30,0
	la 31,itemlist@l(11)
	bc 4,0,.L662
	mr 29,10
.L657:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L659
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L659
	mr 11,31
	b .L661
.L659:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L657
.L662:
	li 11,0
.L661:
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
	lis 10,.LC40@ha
	la 26,combat_armor_index@l(9)
	srawi 11,11,3
	la 28,.LC40@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L670
	mr 29,7
.L665:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L667
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L667
	mr 11,31
	b .L669
.L667:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L665
.L670:
	li 11,0
.L669:
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
	lis 10,.LC41@ha
	la 27,body_armor_index@l(9)
	srawi 11,11,3
	la 28,.LC41@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L678
	mr 29,7
.L673:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L675
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L675
	mr 11,31
	b .L677
.L675:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L673
.L678:
	li 11,0
.L677:
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
	lis 10,.LC120@ha
	la 26,power_screen_index@l(9)
	srawi 11,11,3
	la 28,.LC120@l(10)
	stw 11,0(27)
	mr 31,8
	bc 4,0,.L686
	mr 29,7
.L681:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L683
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L683
	mr 11,31
	b .L685
.L683:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L681
.L686:
	li 11,0
.L685:
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
	lis 10,.LC124@ha
	la 27,power_shield_index@l(9)
	srawi 11,11,3
	la 28,.LC124@l(10)
	stw 11,0(26)
	mr 31,8
	bc 4,0,.L694
	mr 29,7
.L689:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L691
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L691
	mr 8,31
	b .L693
.L691:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L689
.L694:
	li 8,0
.L693:
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
.Lfe25:
	.size	 SetItemNames,.Lfe25-SetItemNames
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
	li 0,47
	stw 0,game+1556@l(9)
	blr
.Lfe26:
	.size	 InitItems,.Lfe26-InitItems
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
	bc 4,0,.L20
	mr 28,9
.L22:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L21
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L21
	mr 3,31
	b .L695
.L21:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L22
.L20:
	li 3,0
.L695:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 FindItem,.Lfe27-FindItem
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
	b .L696
.L12:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L13
.L11:
	li 3,0
.L696:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe28:
	.size	 FindItemByClassname,.Lfe28-FindItemByClassname
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
	stw 10,680(9)
	fadds 0,0,1
	stfs 0,672(9)
	lwz 0,gi+72@l(6)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 SetRespawn,.Lfe29-SetRespawn
	.align 2
	.globl ArmorIndex
	.type	 ArmorIndex,@function
ArmorIndex:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L443
	li 3,0
	blr
.L443:
	lis 9,jacket_armor_index@ha
	addi 10,11,748
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
.Lfe30:
	.size	 ArmorIndex,.Lfe30-ArmorIndex
	.align 2
	.globl PowerArmorType
	.type	 PowerArmorType,@function
PowerArmorType:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L472
.L699:
	li 3,0
	blr
.L472:
	lwz 0,268(3)
	andi. 9,0,4096
	bc 12,2,.L699
	lis 9,power_shield_index@ha
	addi 11,11,748
	lwz 0,power_shield_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L474
	lis 9,power_screen_index@ha
	lwz 0,power_screen_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	srawi 3,9,31
	subf 3,9,3
	srwi 3,3,31
	blr
.L474:
	li 3,2
	blr
.Lfe31:
	.size	 PowerArmorType,.Lfe31-PowerArmorType
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
.Lfe32:
	.size	 GetItemByIndex,.Lfe32-GetItemByIndex
	.section	".sbss","aw",@nobits
	.align 2
power_screen_index:
	.space	4
	.size	 power_screen_index,4
	.align 2
power_shield_index:
	.space	4
	.size	 power_shield_index,4
	.comm	team1_flag_spawn,4,4
	.comm	team2_flag_spawn,4,4
	.align 2
quad_drop_timeout_hack:
	.space	4
	.size	 quad_drop_timeout_hack,4
	.section	".text"
	.align 2
	.globl CTFDrop_Flag
	.type	 CTFDrop_Flag,@function
CTFDrop_Flag:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	mr 29,4
	crxor 6,6,6
	bl Dropped_Flag
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(28)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 29,9,29
	addi 11,11,748
	mullw 29,29,0
	mr 3,28
	srawi 29,29,3
	slwi 29,29,2
	lwzx 9,11,29
	addi 9,9,-1
	stwx 9,11,29
	bl ValidateSelectedItem
	li 3,1
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 CTFDrop_Flag,.Lfe33-CTFDrop_Flag
	.align 2
	.globl CTFResetFlag
	.type	 CTFResetFlag,@function
CTFResetFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	cmpwi 0,3,1
	bc 12,2,.L28
	cmpwi 0,3,2
	bc 12,2,.L29
	b .L26
.L28:
	lis 9,.LC0@ha
	la 29,.LC0@l(9)
	b .L27
.L29:
	lis 9,.LC1@ha
	la 29,.LC1@l(9)
.L27:
	lis 9,gi@ha
	li 31,0
	la 28,gi@l(9)
	li 30,1
	b .L32
.L34:
	lwz 0,288(31)
	andis. 9,0,1
	bc 12,2,.L35
	mr 3,31
	bl G_FreeEdict
	b .L32
.L35:
	lwz 0,184(31)
	mr 3,31
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(28)
	mtlr 9
	blrl
	stw 30,80(31)
.L32:
	mr 3,31
	li 4,284
	mr 5,29
	bl G_Find
	mr. 31,3
	bc 4,2,.L34
.L26:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 CTFResetFlag,.Lfe34-CTFResetFlag
	.align 2
	.globl DoRespawn
	.type	 DoRespawn,@function
DoRespawn:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,544(31)
	cmpwi 0,0,0
	bc 12,2,.L110
	lwz 30,840(31)
	li 29,0
	mr. 31,30
	bc 12,2,.L112
.L113:
	lwz 31,812(31)
	addi 29,29,1
	cmpwi 0,31,0
	bc 4,2,.L113
.L112:
	bl rand
	mr 31,30
	divw 0,3,29
	mullw 0,0,29
	subf. 3,0,3
	bc 4,1,.L110
	mr 29,3
.L118:
	addic. 29,29,-1
	lwz 31,812(31)
	bc 4,2,.L118
.L110:
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
	lis 0,0x38e3
	lwz 11,84(28)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 29,9,29
	addi 11,11,748
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
.Lfe36:
	.size	 Drop_General,.Lfe36-Drop_General
	.section	".rodata"
	.align 2
.LC300:
	.long 0x0
	.align 3
.LC301:
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
	lis 9,.LC300@ha
	lis 11,deathmatch@ha
	la 9,.LC300@l(9)
	mr 12,3
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L162
	lwz 9,756(4)
	addi 9,9,1
	stw 9,756(4)
.L162:
	lwz 0,728(4)
	lwz 9,756(4)
	cmpw 0,0,9
	bc 4,0,.L163
	stw 9,728(4)
.L163:
	lwz 0,288(12)
	andis. 4,0,0x1
	bc 4,2,.L164
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L164
	lis 9,.LC301@ha
	lwz 11,1000(12)
	la 9,.LC301@l(9)
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
	stw 9,12(1)
	ori 11,11,1
	stw 7,8(1)
	lfd 0,8(1)
	stw 11,184(12)
	stw 4,248(12)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,680(12)
	frsp 0,0
	fadds 13,13,0
	stfs 13,672(12)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L164:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 Pickup_Adrenaline,.Lfe37-Pickup_Adrenaline
	.section	".rodata"
	.align 2
.LC302:
	.long 0x0
	.align 3
.LC303:
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
	lwz 9,756(4)
	mr 12,3
	addi 9,9,2
	stw 9,756(4)
	lwz 0,288(12)
	andis. 4,0,0x1
	bc 4,2,.L167
	lis 9,.LC302@ha
	lis 11,deathmatch@ha
	la 9,.LC302@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L167
	lis 9,.LC303@ha
	lwz 11,1000(12)
	la 9,.LC303@l(9)
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
	xoris 9,9,0x8000
	stw 0,268(12)
	stw 9,12(1)
	ori 11,11,1
	stw 7,8(1)
	lfd 0,8(1)
	stw 11,184(12)
	stw 4,248(12)
	fsub 0,0,12
	lfs 13,level+4@l(6)
	stw 10,680(12)
	frsp 0,0
	fadds 13,13,0
	stfs 13,672(12)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L167:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe38:
	.size	 Pickup_AncientHead,.Lfe38-Pickup_AncientHead
	.section	".rodata"
	.align 2
.LC304:
	.long 0x3f800000
	.align 2
.LC305:
	.long 0x0
	.section	".text"
	.align 2
	.globl use_blueflag
	.type	 use_blueflag,@function
use_blueflag:
	stwu 1,-544(1)
	mflr 0
	stmw 28,528(1)
	stw 0,548(1)
	mr 29,3
	addi 28,1,8
	lwz 0,908(29)
	li 9,0
	li 5,512
	lwz 4,84(29)
	mr 3,28
	stw 9,952(29)
	stw 0,948(29)
	addi 4,4,188
	crxor 6,6,6
	bl memcpy
	mr 4,28
	mr 3,29
	crxor 6,6,6
	bl ClientUserinfoChanged
	lwz 0,268(29)
	mr 3,29
	oris 0,0,0x8
	stw 0,268(29)
	bl ValidateSelectedItem
	lis 28,gi@ha
	lwz 5,84(29)
	lis 4,.LC50@ha
	lwz 9,gi@l(28)
	la 4,.LC50@l(4)
	li 3,1
	addi 5,5,700
	la 28,gi@l(28)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(28)
	lis 3,.LC51@ha
	la 3,.LC51@l(3)
	mtlr 9
	blrl
	lis 9,.LC304@ha
	lwz 0,16(28)
	mr 5,3
	la 9,.LC304@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,29
	mtlr 0
	lis 9,.LC304@ha
	la 9,.LC304@l(9)
	lfs 2,0(9)
	lis 9,.LC305@ha
	la 9,.LC305@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,548(1)
	mtlr 0
	lmw 28,528(1)
	la 1,544(1)
	blr
.Lfe39:
	.size	 use_blueflag,.Lfe39-use_blueflag
	.section	".rodata"
	.align 2
.LC306:
	.long 0x3f800000
	.align 2
.LC307:
	.long 0x0
	.section	".text"
	.align 2
	.globl use_redflag
	.type	 use_redflag,@function
use_redflag:
	stwu 1,-544(1)
	mflr 0
	stmw 28,528(1)
	stw 0,548(1)
	mr 29,3
	addi 28,1,8
	lwz 0,908(29)
	li 9,0
	li 5,512
	lwz 4,84(29)
	mr 3,28
	stw 9,952(29)
	stw 0,948(29)
	addi 4,4,188
	crxor 6,6,6
	bl memcpy
	mr 4,28
	mr 3,29
	crxor 6,6,6
	bl ClientUserinfoChanged
	lwz 0,268(29)
	mr 3,29
	oris 0,0,0x4
	stw 0,268(29)
	bl ValidateSelectedItem
	lis 28,gi@ha
	lwz 5,84(29)
	lis 4,.LC52@ha
	lwz 9,gi@l(28)
	la 4,.LC52@l(4)
	li 3,1
	addi 5,5,700
	la 28,gi@l(28)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(28)
	lis 3,.LC51@ha
	la 3,.LC51@l(3)
	mtlr 9
	blrl
	lis 9,.LC306@ha
	lwz 0,16(28)
	mr 5,3
	la 9,.LC306@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,29
	mtlr 0
	lis 9,.LC306@ha
	la 9,.LC306@l(9)
	lfs 2,0(9)
	lis 9,.LC307@ha
	la 9,.LC307@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,548(1)
	mtlr 0
	lmw 28,528(1)
	la 1,544(1)
	blr
.Lfe40:
	.size	 use_redflag,.Lfe40-use_redflag
	.section	".rodata"
	.align 3
.LC308:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC309:
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
	addi 11,11,748
	slwi 4,4,2
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC308@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC308@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3884(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L360
	lis 9,.LC309@ha
	la 9,.LC309@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L701
.L360:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L701:
	stfs 0,3884(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe41:
	.size	 Use_Breather,.Lfe41-Use_Breather
	.section	".rodata"
	.align 3
.LC310:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC311:
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
	addi 11,11,748
	slwi 4,4,2
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC310@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC310@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,3888(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L363
	lis 9,.LC311@ha
	la 9,.LC311@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L702
.L363:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L702:
	stfs 0,3888(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe42:
	.size	 Use_Envirosuit,.Lfe42-Use_Envirosuit
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
	addi 11,11,748
	slwi 4,4,2
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lwz 11,84(29)
	lwz 9,3900(11)
	addi 9,9,30
	stw 9,3900(11)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe43:
	.size	 Use_Silencer,.Lfe43-Use_Silencer
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
	addi 9,9,748
	lwzx 0,9,0
	cmpw 0,0,10
	bc 12,0,.L418
	stw 10,808(11)
	b .L419
.L418:
	stw 0,808(11)
.L419:
	lwz 9,84(31)
	slwi 10,30,2
	mr 3,31
	lwz 11,808(11)
	addi 9,9,748
	lwzx 0,9,10
	subf 0,11,0
	stwx 0,9,10
	bl ValidateSelectedItem
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe44:
	.size	 Drop_Ammo,.Lfe44-Drop_Ammo
	.section	".rodata"
	.align 2
.LC312:
	.long 0x3f800000
	.align 2
.LC313:
	.long 0x0
	.align 2
.LC314:
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
	lwz 9,728(11)
	lwz 0,756(11)
	cmpw 0,9,0
	bc 4,1,.L421
	lis 10,.LC312@ha
	lis 9,level+4@ha
	la 10,.LC312@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,672(7)
	lwz 9,728(11)
	addi 9,9,-1
	stw 9,728(11)
	b .L420
.L421:
	lwz 0,288(7)
	andis. 6,0,0x1
	bc 4,2,.L422
	lis 9,.LC313@ha
	lis 11,deathmatch@ha
	la 9,.LC313@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L422
	lwz 9,268(7)
	lis 11,.LC314@ha
	lis 10,level+4@ha
	lwz 0,184(7)
	la 11,.LC314@l(11)
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
	stw 11,680(7)
	stfs 0,672(7)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	b .L420
.L422:
	mr 3,7
	bl G_FreeEdict
.L420:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe45:
	.size	 MegaHealth_think,.Lfe45-MegaHealth_think
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
	bc 12,2,.L495
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,30
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,1
	bc 4,2,.L495
	bl Use_PowerArmor
.L495:
	mr 3,31
	mr 4,30
	bl Drop_Item
	lis 11,itemlist@ha
	lis 0,0x38e3
	lwz 10,84(31)
	la 11,itemlist@l(11)
	ori 0,0,36409
	subf 11,11,30
	addi 10,10,748
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
.Lfe46:
	.size	 Drop_PowerArmor,.Lfe46-Drop_PowerArmor
	.align 2
	.type	 drop_temp_touch,@function
drop_temp_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,256(3)
	cmpw 0,4,0
	bc 12,2,.L509
	bl Touch_Item
.L509:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe47:
	.size	 drop_temp_touch,.Lfe47-drop_temp_touch
	.section	".rodata"
	.align 2
.LC315:
	.long 0x0
	.align 2
.LC316:
	.long 0x41e80000
	.section	".text"
	.align 2
	.type	 drop_make_touchable,@function
drop_make_touchable:
	lis 9,Touch_Item@ha
	lis 11,deathmatch@ha
	la 9,Touch_Item@l(9)
	lwz 10,deathmatch@l(11)
	stw 9,688(3)
	lis 9,.LC315@ha
	lfs 0,20(10)
	la 9,.LC315@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bclr 12,2
	lis 9,.LC316@ha
	lis 11,level+4@ha
	la 9,.LC316@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,680(3)
	stfs 0,672(3)
	blr
.Lfe48:
	.size	 drop_make_touchable,.Lfe48-drop_make_touchable
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
	stw 11,692(3)
	rlwinm 0,0,0,0,30
	stw 0,184(3)
	bc 12,2,.L544
	li 0,2
	stw 11,688(3)
	stw 0,248(3)
	b .L545
.L544:
	lis 9,Touch_Item@ha
	li 0,1
	la 9,Touch_Item@l(9)
	stw 0,248(3)
	stw 9,688(3)
.L545:
	lis 9,gi+72@ha
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe49:
	.size	 Use_Item,.Lfe49-Use_Item
	.section	".rodata"
	.align 2
.LC317:
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
	lis 11,.LC317@ha
	lis 9,deathmatch@ha
	la 11,.LC317@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L609
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L609
	bl G_FreeEdict
	b .L608
.L703:
	mr 4,31
	b .L616
.L609:
	lis 9,.LC296@ha
	li 0,10
	la 9,.LC296@l(9)
	lis 11,game@ha
	stw 0,808(29)
	la 10,game@l(11)
	stw 9,272(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC295@ha
	lis 11,itemlist@ha
	la 27,.LC295@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L617
	mr 28,10
.L612:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L614
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L703
.L614:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L612
.L617:
	li 4,0
.L616:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC64@ha
	lwz 0,gi+36@l(9)
	la 3,.LC64@l(3)
	mtlr 0
	blrl
.L608:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe50:
	.size	 SP_item_health,.Lfe50-SP_item_health
	.section	".rodata"
	.align 2
.LC318:
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
	lis 11,.LC318@ha
	lis 9,deathmatch@ha
	la 11,.LC318@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L619
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L619
	bl G_FreeEdict
	b .L618
.L704:
	mr 4,31
	b .L626
.L619:
	lis 9,.LC297@ha
	li 0,2
	la 9,.LC297@l(9)
	lis 11,game@ha
	stw 0,808(29)
	la 10,game@l(11)
	stw 9,272(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC295@ha
	lis 11,itemlist@ha
	la 27,.LC295@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L627
	mr 28,10
.L622:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L624
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L704
.L624:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L622
.L627:
	li 4,0
.L626:
	mr 3,29
	bl SpawnItem
	li 0,1
	lis 9,gi+36@ha
	stw 0,996(29)
	lis 3,.LC63@ha
	lwz 0,gi+36@l(9)
	la 3,.LC63@l(3)
	mtlr 0
	blrl
.L618:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe51:
	.size	 SP_item_health_small,.Lfe51-SP_item_health_small
	.section	".rodata"
	.align 2
.LC319:
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
	lis 11,.LC319@ha
	lis 9,deathmatch@ha
	la 11,.LC319@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L629
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L629
	bl G_FreeEdict
	b .L628
.L705:
	mr 4,31
	b .L636
.L629:
	lis 9,.LC298@ha
	li 0,25
	la 9,.LC298@l(9)
	lis 11,game@ha
	stw 0,808(29)
	la 10,game@l(11)
	stw 9,272(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC295@ha
	lis 11,itemlist@ha
	la 27,.LC295@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L637
	mr 28,10
.L632:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L634
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L705
.L634:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L632
.L637:
	li 4,0
.L636:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC65@ha
	lwz 0,gi+36@l(9)
	la 3,.LC65@l(3)
	mtlr 0
	blrl
.L628:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe52:
	.size	 SP_item_health_large,.Lfe52-SP_item_health_large
	.section	".rodata"
	.align 2
.LC320:
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
	lis 11,.LC320@ha
	lis 9,deathmatch@ha
	la 11,.LC320@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L639
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L639
	bl G_FreeEdict
	b .L638
.L706:
	mr 4,31
	b .L646
.L639:
	lis 9,.LC299@ha
	li 0,100
	la 9,.LC299@l(9)
	lis 11,game@ha
	stw 0,808(29)
	la 10,game@l(11)
	stw 9,272(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC295@ha
	lis 11,itemlist@ha
	la 27,.LC295@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L647
	mr 28,10
.L642:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L644
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L706
.L644:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L642
.L647:
	li 4,0
.L646:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC66@ha
	lwz 0,gi+36@l(9)
	la 3,.LC66@l(3)
	mtlr 0
	blrl
	li 0,3
	stw 0,996(29)
.L638:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe53:
	.size	 SP_item_health_mega,.Lfe53-SP_item_health_mega
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
