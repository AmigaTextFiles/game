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
	.string	"Jetpack"
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
	.align 3
.LC4:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC5:
	.long 0x0
	.section	".text"
	.align 2
	.globl Pickup_Powerup
	.type	 Pickup_Powerup,@function
Pickup_Powerup:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	mr 31,3
	la 28,itemlist@l(9)
	lwz 0,648(31)
	lis 30,0x286b
	lis 9,skill@ha
	lis 7,.LC2@ha
	lwz 11,skill@l(9)
	la 7,.LC2@l(7)
	mr 29,4
	subf 0,28,0
	ori 30,30,51739
	lwz 9,84(29)
	mullw 0,0,30
	lfs 0,0(7)
	lfs 13,20(11)
	addi 8,9,744
	rlwinm 10,0,0,0,29
	lwzx 11,8,10
	fcmpu 7,13,0
	cmpwi 6,11,1
	mfcr 9
	rlwinm 0,9,26,1
	rlwinm 9,9,31,1
	and. 7,9,0
	bc 4,2,.L42
	lis 9,.LC3@ha
	srawi 0,11,31
	la 9,.LC3@l(9)
	subf 0,11,0
	lfs 0,0(9)
	srwi 0,0,31
	fcmpu 7,13,0
	cror 31,30,29
	mfcr 9
	rlwinm 9,9,0,1
	and. 7,9,0
	bc 12,2,.L41
.L42:
	li 3,0
	b .L53
.L41:
	addi 0,11,1
	lis 4,.LC0@ha
	stwx 0,8,10
	la 4,.LC0@l(4)
	lwz 9,648(31)
	lwz 3,40(9)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L43
	lwz 0,648(31)
	lis 9,dmflags@ha
	li 6,1
	lwz 11,84(29)
	lis 7,0x442f
	subf 0,28,0
	lwz 8,dmflags@l(9)
	mullw 0,0,30
	addi 11,11,744
	rlwinm 0,0,0,0,29
	stwx 6,11,0
	lwz 9,84(29)
	stw 7,2264(9)
	lfs 0,20(8)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 10,12(1)
	andi. 0,10,16
	bc 12,2,.L44
	lwz 9,84(29)
	li 0,0
	stw 0,2260(9)
	b .L43
.L44:
	mr 3,29
	bl Jet_Active
	cmpwi 0,3,0
	bc 12,2,.L43
	lis 11,level@ha
	lwz 8,84(29)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 7,.LC4@ha
	la 7,.LC4@l(7)
	lfs 12,2264(8)
	xoris 0,0,0x8000
	lfd 13,0(7)
	stw 0,12(1)
	stw 10,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fadds 0,0,12
	stfs 0,2260(8)
.L43:
	lis 9,.LC5@ha
	lis 11,deathmatch@ha
	la 9,.LC5@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L47
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L48
	lwz 11,648(31)
	lis 7,0x4330
	lis 10,.LC4@ha
	lwz 0,264(31)
	lis 6,level+4@ha
	lwz 9,48(11)
	la 10,.LC4@l(10)
	lis 5,gi+72@ha
	lfd 12,0(10)
	oris 0,0,0x8000
	mr 3,31
	xoris 9,9,0x8000
	lwz 11,184(31)
	lis 10,DoRespawn@ha
	stw 9,12(1)
	la 10,DoRespawn@l(10)
	stw 7,8(1)
	ori 11,11,1
	lfd 0,8(1)
	stw 0,264(31)
	stw 11,184(31)
	fsub 0,0,12
	stw 4,248(31)
	lfs 13,level+4@l(6)
	stw 10,436(31)
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(31)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L48:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,16
	bc 4,2,.L51
	lwz 9,648(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L47
	lwz 0,284(31)
	andis. 7,0,2
	bc 12,2,.L47
.L51:
	lwz 9,648(31)
	lis 11,Use_Quad@ha
	la 11,Use_Quad@l(11)
	lwz 0,8(9)
	cmpw 0,0,11
	bc 4,2,.L52
	lwz 0,284(31)
	andis. 9,0,2
	bc 12,2,.L52
	lis 11,level+4@ha
	lfs 0,428(31)
	lis 10,.LC1@ha
	lfs 11,level+4@l(11)
	lfd 12,.LC1@l(10)
	lis 11,quad_drop_timeout_hack@ha
	fsubs 0,0,11
	fdiv 0,0,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	stw 9,quad_drop_timeout_hack@l(11)
.L52:
	lwz 9,648(31)
	mr 3,29
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L47:
	li 3,1
.L53:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Pickup_Powerup,.Lfe1-Pickup_Powerup
	.section	".rodata"
	.align 2
.LC6:
	.long 0x0
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Bandolier
	.type	 Pickup_Bandolier,@function
Pickup_Bandolier:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(4)
	mr 12,3
	lwz 9,1768(11)
	addi 9,9,-1
	cmplwi 0,9,248
	bc 12,1,.L64
	li 0,250
	stw 0,1768(11)
.L64:
	lwz 11,84(4)
	lwz 9,1772(11)
	addi 9,9,-1
	cmplwi 0,9,148
	bc 12,1,.L65
	li 0,150
	stw 0,1772(11)
.L65:
	lwz 11,84(4)
	lwz 9,1784(11)
	addi 9,9,-1
	cmplwi 0,9,248
	bc 12,1,.L66
	li 0,250
	stw 0,1784(11)
.L66:
	lwz 11,84(4)
	lwz 9,1788(11)
	addi 9,9,-1
	cmplwi 0,9,73
	bc 12,1,.L67
	li 0,75
	stw 0,1788(11)
.L67:
	lis 9,item_bullets@ha
	lwz 8,item_bullets@l(9)
	cmpwi 0,8,0
	bc 12,2,.L68
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(4)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(4)
	lwz 11,1768(9)
	addi 9,9,744
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L68
	stwx 11,9,8
.L68:
	lis 9,item_shells@ha
	lwz 8,item_shells@l(9)
	cmpwi 0,8,0
	bc 12,2,.L70
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(4)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(4)
	addi 4,9,744
	lwz 11,1772(9)
	lwzx 0,4,8
	cmpw 0,0,11
	bc 4,1,.L70
	stwx 11,4,8
.L70:
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L72
	lis 9,.LC6@ha
	lis 11,deathmatch@ha
	la 9,.LC6@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L72
	lis 9,.LC7@ha
	lwz 11,648(12)
	la 9,.LC7@l(9)
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
.L72:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe2:
	.size	 Pickup_Bandolier,.Lfe2-Pickup_Bandolier
	.section	".rodata"
	.align 2
.LC8:
	.long 0x0
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Pickup_Pack
	.type	 Pickup_Pack,@function
Pickup_Pack:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(4)
	mr 12,3
	lwz 9,1768(11)
	addi 9,9,-1
	cmplwi 0,9,298
	bc 12,1,.L75
	li 0,300
	stw 0,1768(11)
.L75:
	lwz 11,84(4)
	lwz 9,1772(11)
	addi 9,9,-1
	cmplwi 0,9,198
	bc 12,1,.L76
	li 0,200
	stw 0,1772(11)
.L76:
	lwz 11,84(4)
	lwz 9,1776(11)
	addi 9,9,-1
	cmplwi 0,9,98
	bc 12,1,.L77
	li 0,100
	stw 0,1776(11)
.L77:
	lwz 9,84(4)
	lwz 0,1780(9)
	cmpwi 0,0,99
	bc 12,1,.L78
	li 0,100
	stw 0,1780(9)
.L78:
	lwz 11,84(4)
	lwz 9,1784(11)
	addi 9,9,-1
	cmplwi 0,9,298
	bc 12,1,.L79
	li 0,300
	stw 0,1784(11)
.L79:
	lwz 11,84(4)
	lwz 9,1788(11)
	addi 9,9,-1
	cmplwi 0,9,98
	bc 12,1,.L80
	li 0,100
	stw 0,1788(11)
.L80:
	lis 9,item_bullets@ha
	lwz 8,item_bullets@l(9)
	cmpwi 0,8,0
	bc 12,2,.L81
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(4)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(4)
	lwz 11,1768(9)
	addi 9,9,744
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L81
	stwx 11,9,8
.L81:
	lis 9,item_shells@ha
	lwz 8,item_shells@l(9)
	cmpwi 0,8,0
	bc 12,2,.L83
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(4)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(4)
	lwz 11,1772(9)
	addi 9,9,744
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L83
	stwx 11,9,8
.L83:
	lis 9,item_cells@ha
	lwz 8,item_cells@l(9)
	cmpwi 0,8,0
	bc 12,2,.L85
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(4)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(4)
	lwz 11,1784(9)
	addi 9,9,744
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L85
	stwx 11,9,8
.L85:
	lis 9,item_grenades@ha
	lwz 8,item_grenades@l(9)
	cmpwi 0,8,0
	bc 12,2,.L87
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(4)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(4)
	lwz 11,1780(9)
	addi 9,9,744
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L87
	stwx 11,9,8
.L87:
	lis 9,item_rockets@ha
	lwz 8,item_rockets@l(9)
	cmpwi 0,8,0
	bc 12,2,.L89
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(4)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(4)
	lwz 11,1776(9)
	addi 9,9,744
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,1,.L89
	stwx 11,9,8
.L89:
	lis 9,item_slugs@ha
	lwz 8,item_slugs@l(9)
	cmpwi 0,8,0
	bc 12,2,.L91
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(4)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,48(8)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	rlwinm 8,9,0,0,29
	lwzx 0,11,8
	add 0,0,10
	stwx 0,11,8
	lwz 9,84(4)
	addi 4,9,744
	lwz 11,1788(9)
	lwzx 0,4,8
	cmpw 0,0,11
	bc 4,1,.L91
	stwx 11,4,8
.L91:
	lwz 0,284(12)
	andis. 4,0,0x1
	bc 4,2,.L93
	lis 9,.LC8@ha
	lis 11,deathmatch@ha
	la 9,.LC8@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L93
	lis 9,.LC9@ha
	lwz 11,648(12)
	la 9,.LC9@l(9)
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
.L93:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 Pickup_Pack,.Lfe3-Pickup_Pack
	.section	".rodata"
	.align 2
.LC10:
	.string	"items/protect.wav"
	.align 2
.LC12:
	.string	"hover/hovidle1.wav"
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
	addi 11,11,744
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 11,quad_drop_timeout_hack@ha
	lwz 9,quad_drop_timeout_hack@l(11)
	cmpwi 0,9,0
	bc 12,2,.L100
	li 0,0
	mr 10,9
	stw 0,quad_drop_timeout_hack@l(11)
	b .L101
.L100:
	li 10,300
.L101:
	lis 11,level@ha
	lwz 8,84(31)
	lwz 11,level@l(11)
	lis 7,0x4330
	lis 6,.LC14@ha
	la 6,.LC14@l(6)
	lfs 12,2148(8)
	xoris 0,11,0x8000
	lfd 13,0(6)
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L102
	xoris 0,10,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fadds 0,12,0
	b .L104
.L102:
	add 0,11,10
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
.L104:
	stfs 0,2148(8)
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
	addi 11,11,744
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
	lfs 13,2152(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L112
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L114
.L112:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L114:
	stfs 0,2152(10)
	lis 29,gi@ha
	lis 3,.LC10@ha
	la 29,gi@l(29)
	la 3,.LC10@l(3)
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
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 4,2,.L118
.L134:
	li 3,0
	blr
.L118:
	lwz 0,68(4)
	cmpwi 0,0,0
	bc 4,2,.L119
	lwz 10,1768(9)
	b .L120
.L119:
	cmpwi 0,0,1
	bc 4,2,.L121
	lwz 10,1772(9)
	b .L120
.L121:
	cmpwi 0,0,2
	bc 4,2,.L123
	lwz 10,1776(9)
	b .L120
.L123:
	cmpwi 0,0,3
	bc 4,2,.L125
	lwz 10,1780(9)
	b .L120
.L125:
	cmpwi 0,0,4
	bc 4,2,.L127
	lwz 10,1784(9)
	b .L120
.L127:
	cmpwi 0,0,5
	bc 4,2,.L134
	lwz 10,1788(9)
.L120:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(3)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,11,744
	mullw 9,9,0
	rlwinm 4,9,0,0,29
	lwzx 0,11,4
	cmpw 0,0,10
	bc 12,2,.L134
	add 0,0,5
	stwx 0,11,4
	lwz 9,84(3)
	addi 3,9,744
	lwzx 0,3,4
	cmpw 0,0,10
	bc 4,1,.L132
	stwx 10,3,4
.L132:
	li 3,1
	blr
.Lfe6:
	.size	 Add_Ammo,.Lfe6-Add_Ammo
	.section	".rodata"
	.align 2
.LC21:
	.long 0x0
	.align 2
.LC22:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Pickup_Ammo
	.type	 Pickup_Ammo,@function
Pickup_Ammo:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 29,4
	lwz 4,648(31)
	lwz 0,56(4)
	andi. 28,0,1
	bc 12,2,.L136
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8192
	li 5,1000
	bc 4,2,.L137
.L136:
	lwz 5,532(31)
	cmpwi 0,5,0
	bc 12,2,.L138
	lwz 4,648(31)
	b .L137
.L138:
	lwz 9,648(31)
	lwz 5,48(9)
	mr 4,9
.L137:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(29)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,11,744
	mullw 9,9,0
	mr 3,29
	rlwinm 9,9,0,0,29
	lwzx 30,11,9
	bl Add_Ammo
	cmpwi 0,3,0
	bc 4,2,.L140
	li 3,0
	b .L146
.L140:
	subfic 9,30,0
	adde 0,9,30
	and. 11,28,0
	bc 12,2,.L141
	lwz 3,84(29)
	lwz 8,648(31)
	lwz 10,1792(3)
	cmpw 0,10,8
	bc 12,2,.L141
	lis 9,.LC21@ha
	lis 11,deathmatch@ha
	la 9,.LC21@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L143
	lis 9,item_blaster@ha
	lwz 0,item_blaster@l(9)
	cmpw 0,10,0
	bc 4,2,.L141
.L143:
	stw 8,1964(3)
.L141:
	lwz 0,284(31)
	andis. 7,0,0x3
	bc 4,2,.L144
	lis 9,.LC21@ha
	lis 11,deathmatch@ha
	la 9,.LC21@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L144
	lwz 9,264(31)
	lis 11,.LC22@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC22@l(11)
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
.L144:
	li 3,1
.L146:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 Pickup_Ammo,.Lfe7-Pickup_Ammo
	.section	".rodata"
	.align 2
.LC23:
	.string	"Can't drop current weapon\n"
	.align 2
.LC24:
	.long 0x0
	.align 2
.LC25:
	.long 0x40a00000
	.align 2
.LC26:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Pickup_Health
	.type	 Pickup_Health,@function
Pickup_Health:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 7,3
	mr 31,4
	lwz 0,644(7)
	andi. 8,0,1
	bc 4,2,.L157
	lis 9,.LC24@ha
	lis 11,deathmatch@ha
	lwz 10,480(31)
	la 9,.LC24@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L158
	lwz 9,84(31)
	lwz 0,1888(9)
	cmpwi 0,0,9
	bc 4,2,.L158
	cmpwi 0,10,99
	bc 4,1,.L158
	lwz 0,728(9)
	cmpwi 0,0,199
	bc 12,1,.L158
	bl Set_Heal_Health
	lwz 4,84(31)
	lwz 0,728(4)
	cmpwi 0,0,200
	bc 4,1,.L165
	li 0,200
	stw 0,728(4)
	b .L165
.L158:
	lwz 0,484(31)
	cmpw 0,10,0
	bc 12,0,.L157
	li 3,0
	b .L168
.L157:
	lwz 0,480(31)
	lwz 9,532(7)
	add 9,0,9
	stw 9,480(31)
	lwz 0,644(7)
	andi. 8,0,1
	bc 4,2,.L162
	lwz 0,484(31)
	cmpw 0,9,0
	bc 4,1,.L162
	stw 0,480(31)
.L162:
	lwz 0,644(7)
	andi. 9,0,2
	bc 12,2,.L164
	lis 9,MegaHealth_think@ha
	lis 8,.LC25@ha
	lwz 11,264(7)
	la 9,MegaHealth_think@l(9)
	lis 10,level+4@ha
	lwz 0,184(7)
	stw 9,436(7)
	la 8,.LC25@l(8)
	oris 11,11,0x8000
	lfs 0,level+4@l(10)
	li 9,0
	ori 0,0,1
	lfs 13,0(8)
	stw 9,248(7)
	stw 31,256(7)
	fadds 0,0,13
	stw 11,264(7)
	stw 0,184(7)
	stfs 0,428(7)
	b .L165
.L164:
	lwz 0,284(7)
	andis. 6,0,0x1
	bc 4,2,.L165
	lis 9,.LC24@ha
	lis 11,deathmatch@ha
	la 9,.LC24@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L165
	lwz 9,264(7)
	lis 11,.LC26@ha
	lis 10,level+4@ha
	lwz 0,184(7)
	la 11,.LC26@l(11)
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
.L165:
	li 3,1
.L168:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 Pickup_Health,.Lfe8-Pickup_Health
	.section	".rodata"
	.align 3
.LC27:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC28:
	.long 0x0
	.align 2
.LC29:
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
	bc 4,2,.L175
	li 6,0
	b .L176
.L175:
	lis 9,jacket_armor_index@ha
	addi 8,11,744
	lwz 6,jacket_armor_index@l(9)
	slwi 0,6,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L176
	lis 9,combat_armor_index@ha
	lwz 6,combat_armor_index@l(9)
	slwi 0,6,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,1,.L176
	lis 9,body_armor_index@ha
	lwz 10,body_armor_index@l(9)
	slwi 11,10,2
	lwzx 9,8,11
	srawi 0,9,31
	subf 0,9,0
	srawi 0,0,31
	and 6,10,0
.L176:
	lwz 8,648(31)
	lwz 0,68(8)
	cmpwi 0,0,4
	bc 4,2,.L180
	cmpwi 0,6,0
	bc 4,2,.L181
	lis 11,jacket_armor_index@ha
	lwz 9,84(12)
	li 10,2
	lwz 0,jacket_armor_index@l(11)
	addi 9,9,744
	slwi 0,0,2
	stwx 10,9,0
	b .L183
.L181:
	lwz 9,84(12)
	slwi 0,6,2
	addi 9,9,744
	lwzx 11,9,0
	addi 11,11,2
	stwx 11,9,0
	b .L183
.L180:
	cmpwi 0,6,0
	bc 4,2,.L184
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(12)
	la 9,itemlist@l(9)
	ori 0,0,51739
	lwz 10,0(7)
	subf 9,9,8
	addi 11,11,744
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	stwx 10,11,9
	b .L183
.L184:
	lis 9,jacket_armor_index@ha
	lwz 0,jacket_armor_index@l(9)
	cmpw 0,6,0
	bc 4,2,.L186
	lis 9,jacketarmor_info@ha
	la 11,jacketarmor_info@l(9)
	b .L187
.L186:
	lis 9,combat_armor_index@ha
	lwz 0,combat_armor_index@l(9)
	cmpw 0,6,0
	bc 4,2,.L188
	lis 9,combatarmor_info@ha
	la 11,combatarmor_info@l(9)
	b .L187
.L188:
	lis 9,bodyarmor_info@ha
	la 11,bodyarmor_info@l(9)
.L187:
	lfs 13,8(7)
	lfs 0,8(11)
	fcmpu 0,13,0
	bc 4,1,.L190
	fdivs 11,0,13
	lwz 9,84(12)
	slwi 6,6,2
	lis 4,0x4330
	lis 10,.LC27@ha
	lwz 3,0(7)
	addi 9,9,744
	la 10,.LC27@l(10)
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
	addi 11,11,744
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
	b .L183
.L190:
	fdivs 11,13,0
	lwz 0,0(7)
	lis 8,0x4330
	lis 10,.LC27@ha
	mr 7,9
	lwz 11,4(11)
	xoris 0,0,0x8000
	la 10,.LC27@l(10)
	stw 0,20(1)
	slwi 6,6,2
	stw 8,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lwz 10,84(12)
	addi 4,10,744
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
	bc 12,0,.L194
	li 3,0
	b .L197
.L194:
	stwx 0,4,6
.L183:
	lwz 0,284(31)
	andis. 7,0,0x1
	bc 4,2,.L195
	lis 9,.LC28@ha
	lis 11,deathmatch@ha
	la 9,.LC28@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L195
	lwz 9,264(31)
	lis 11,.LC29@ha
	lis 10,level+4@ha
	lwz 0,184(31)
	la 11,.LC29@l(11)
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
.L195:
	li 3,1
.L197:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 Pickup_Armor,.Lfe9-Pickup_Armor
	.section	".rodata"
	.align 2
.LC30:
	.string	"misc/power2.wav"
	.align 2
.LC31:
	.string	"No cells for power armor.\n"
	.align 2
.LC32:
	.string	"misc/power1.wav"
	.align 2
.LC33:
	.long 0x0
	.align 3
.LC34:
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
	addi 10,10,744
	lwz 8,deathmatch@l(11)
	rlwinm 9,9,0,0,29
	lis 11,.LC33@ha
	lwzx 30,10,9
	la 11,.LC33@l(11)
	lfs 13,0(11)
	addi 0,30,1
	stwx 0,10,9
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L208
	lwz 0,284(31)
	andis. 4,0,0x1
	bc 4,2,.L209
	lis 9,.LC34@ha
	lwz 11,648(31)
	la 9,.LC34@l(9)
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
.L209:
	cmpwi 0,30,0
	bc 4,2,.L208
	lwz 9,648(31)
	mr 3,29
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L208:
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 Pickup_PowerArmor,.Lfe10-Pickup_PowerArmor
	.section	".rodata"
	.align 2
.LC35:
	.long 0x3f800000
	.align 2
.LC36:
	.long 0x0
	.section	".text"
	.align 2
	.globl Drop_PowerArmor
	.type	 Drop_PowerArmor,@function
Drop_PowerArmor:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 10,264(31)
	andi. 0,10,4096
	bc 12,2,.L213
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,30
	addi 11,11,744
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,1
	bc 4,2,.L213
	rlwinm 0,10,0,20,18
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(31)
	lis 3,.LC30@ha
	lwz 9,36(29)
	la 3,.LC30@l(3)
	mtlr 9
	blrl
	lis 9,.LC35@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC35@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 2,0(9)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 3,0(9)
	blrl
.L213:
	mr 3,31
	mr 4,30
	bl Drop_Item
	lis 11,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 11,11,30
	addi 10,10,744
	mullw 11,11,0
	mr 3,31
	rlwinm 11,11,0,0,29
	lwzx 9,10,11
	addi 9,9,-1
	stwx 9,10,11
	bl ValidateSelectedItem
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 Drop_PowerArmor,.Lfe11-Drop_PowerArmor
	.section	".rodata"
	.align 2
.LC37:
	.string	"items/s_health.wav"
	.align 2
.LC38:
	.string	"items/n_health.wav"
	.align 2
.LC39:
	.string	"items/l_health.wav"
	.align 2
.LC40:
	.string	"items/m_health.wav"
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
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L219
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L219
	lwz 9,648(31)
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 12,2,.L219
	mtlr 0
	blrl
	mr. 28,3
	bc 12,2,.L223
	lwz 11,84(30)
	lis 0,0x3e80
	lis 9,gi@ha
	la 29,gi@l(9)
	stw 0,2056(11)
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
	stfs 0,2180(9)
	lwz 9,648(31)
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 12,2,.L224
	subf 0,7,9
	lwz 11,84(30)
	mullw 0,0,8
	srawi 0,0,2
	extsh 9,0
	sth 0,144(11)
	stw 9,740(11)
.L224:
	lwz 3,648(31)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	lwz 0,4(3)
	cmpw 0,0,9
	bc 4,2,.L225
	lwz 0,532(31)
	cmpwi 0,0,2
	bc 4,2,.L226
	lwz 9,36(29)
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	b .L239
.L226:
	cmpwi 0,0,10
	bc 4,2,.L228
	lwz 9,36(29)
	lis 3,.LC38@ha
	la 3,.LC38@l(3)
	b .L239
.L228:
	cmpwi 0,0,25
	bc 4,2,.L230
	lwz 9,36(29)
	lis 3,.LC39@ha
	la 3,.LC39@l(3)
	b .L239
.L230:
	lwz 9,36(29)
	lis 3,.LC40@ha
	la 3,.LC40@l(3)
.L239:
	mtlr 9
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
	b .L223
.L225:
	lwz 3,20(3)
	cmpwi 0,3,0
	bc 12,2,.L223
	lwz 9,36(29)
	mtlr 9
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
.L223:
	lwz 0,284(31)
	andis. 9,0,4
	bc 4,2,.L234
	mr 4,30
	mr 3,31
	bl G_UseTargets
	lwz 0,284(31)
	oris 0,0,0x4
	stw 0,284(31)
.L234:
	cmpwi 0,28,0
	bc 12,2,.L219
	lwz 0,284(31)
	andis. 9,0,0x3
	bc 4,2,.L219
	lwz 0,264(31)
	cmpwi 0,0,0
	bc 4,0,.L237
	rlwinm 0,0,0,1,31
	stw 0,264(31)
	b .L219
.L237:
	mr 3,31
	bl G_FreeEdict
.L219:
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
	bc 12,2,.L245
	addi 29,1,24
	addi 4,1,8
	addi 3,3,2072
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
	b .L247
.L245:
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
.L247:
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
	.string	"droptofloor: %s startsolid at %s\n"
	.align 3
.LC47:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC48:
	.long 0xc1700000
	.align 2
.LC49:
	.long 0x41700000
	.align 2
.LC50:
	.long 0x0
	.align 2
.LC51:
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
	lis 9,.LC48@ha
	lis 11,.LC48@ha
	la 9,.LC48@l(9)
	la 11,.LC48@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC48@ha
	lfs 2,0(11)
	la 9,.LC48@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC49@ha
	lfs 13,0(11)
	la 9,.LC49@l(9)
	lfs 1,0(9)
	lis 9,.LC49@ha
	stfs 13,188(31)
	la 9,.LC49@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC49@ha
	stfs 0,192(31)
	la 9,.LC49@l(9)
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
	bc 12,2,.L252
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L253
.L252:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L253:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC50@ha
	stw 9,444(31)
	addi 29,31,4
	la 11,.LC50@l(11)
	lis 9,.LC51@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC51@l(9)
	lis 11,.LC50@ha
	lfs 3,0(9)
	la 11,.LC50@l(11)
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
	bc 12,2,.L254
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC46@ha
	la 3,.LC46@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L251
.L254:
	lwz 0,308(31)
	lfs 12,20(1)
	lfs 0,24(1)
	cmpwi 0,0,0
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L255
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
	bc 4,2,.L255
	lis 11,level+4@ha
	lis 10,.LC47@ha
	lfs 0,level+4@l(11)
	lis 9,DoRespawn@ha
	lfd 13,.LC47@l(10)
	la 9,DoRespawn@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L255:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L257
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
.L257:
	lwz 0,284(31)
	andi. 11,0,1
	bc 12,2,.L258
	lwz 0,184(31)
	lis 9,Use_Item@ha
	li 11,0
	la 9,Use_Item@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
.L258:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L251:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe14:
	.size	 droptofloor,.Lfe14-droptofloor
	.section	".rodata"
	.align 2
.LC52:
	.string	"PrecacheItem: %s has bad precache string"
	.align 2
.LC53:
	.string	"md2"
	.align 2
.LC54:
	.string	"sp2"
	.align 2
.LC55:
	.string	"wav"
	.align 2
.LC56:
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
	bc 12,2,.L259
	lwz 3,20(26)
	cmpwi 0,3,0
	bc 12,2,.L261
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L261:
	lwz 3,24(26)
	cmpwi 0,3,0
	bc 12,2,.L262
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L262:
	lwz 3,32(26)
	cmpwi 0,3,0
	bc 12,2,.L263
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L263:
	lwz 3,36(26)
	cmpwi 0,3,0
	bc 12,2,.L264
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
.L264:
	lwz 29,52(26)
	cmpwi 0,29,0
	bc 12,2,.L265
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L265
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L273
	mr 28,9
.L268:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L270
	mr 4,29
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L270
	mr 3,31
	b .L272
.L270:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L268
.L273:
	li 3,0
.L272:
	cmpw 0,3,26
	bc 12,2,.L265
	bl PrecacheItem
.L265:
	lwz 30,72(26)
	cmpwi 0,30,0
	bc 12,2,.L259
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 12,2,.L259
	lis 9,gi@ha
	addi 29,1,8
	la 27,gi@l(9)
	lis 24,.LC53@ha
	lis 25,.LC56@ha
.L279:
	rlwinm 9,0,0,0xff
	mr 31,30
	b .L293
.L282:
	lbzu 9,1(30)
.L293:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L282
	subf 28,31,30
	addi 0,28,-5
	cmplwi 0,0,58
	bc 4,1,.L284
	lwz 9,28(27)
	lis 3,.LC52@ha
	la 3,.LC52@l(3)
	lwz 4,0(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L284:
	mr 4,31
	mr 5,28
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 0,0
	addi 11,30,1
	stbx 0,29,28
	add 9,29,28
	la 4,.LC53@l(24)
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
	bc 12,2,.L294
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L288
.L294:
	lwz 9,32(27)
	mr 3,29
	mtlr 9
	blrl
	b .L287
.L288:
	lis 4,.LC55@ha
	mr 3,31
	la 4,.LC55@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L287
	lwz 9,36(27)
	mr 3,29
	mtlr 9
	blrl
.L287:
	add 3,29,28
	la 4,.LC56@l(25)
	addi 3,3,-3
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L277
	lwz 9,40(27)
	mr 3,29
	mtlr 9
	blrl
.L277:
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L279
.L259:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe15:
	.size	 PrecacheItem,.Lfe15-PrecacheItem
	.section	".rodata"
	.align 2
.LC57:
	.string	"weapon_shotgun"
	.align 2
.LC58:
	.string	"ammo_shells"
	.align 2
.LC59:
	.string	"weapon_supershotgun"
	.align 2
.LC60:
	.string	"weapon_machinegun"
	.align 2
.LC61:
	.string	"ammo_bullets"
	.align 2
.LC62:
	.string	"weapon_chaingun"
	.align 2
.LC63:
	.string	"weapon_grenadelauncher"
	.align 2
.LC64:
	.string	"ammo_grenades"
	.align 2
.LC65:
	.string	"weapon_rocketlauncher"
	.align 2
.LC66:
	.string	"ammo_rockets"
	.align 2
.LC67:
	.string	"weapon_railgun"
	.align 2
.LC68:
	.string	"ammo_slugs"
	.align 2
.LC69:
	.string	"weapon_hyperblaster"
	.align 2
.LC70:
	.string	"ammo_cells"
	.align 2
.LC71:
	.string	"weapon_bfg"
	.align 2
.LC72:
	.string	"key_power_cube"
	.align 2
.LC73:
	.string	"%s at %s has invalid spawnflags set\n"
	.align 2
.LC74:
	.string	"item_flag_team1"
	.align 2
.LC75:
	.string	"item_flag_team2"
	.align 3
.LC76:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC77:
	.long 0x0
	.section	".text"
	.align 2
	.globl SpawnItem
	.type	 SpawnItem,@function
SpawnItem:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 11,.LC77@ha
	lis 9,deathmatch@ha
	la 11,.LC77@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 30,4
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L296
	lwz 3,280(31)
	lis 4,.LC57@ha
	la 4,.LC57@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L296
	lis 9,.LC58@ha
	lis 11,game@ha
	la 30,.LC58@l(9)
	la 11,game@l(11)
	stw 30,280(31)
	li 28,0
	lis 9,itemlist@ha
	lwz 0,1556(11)
	la 29,itemlist@l(9)
	cmpw 0,28,0
	bc 4,0,.L305
	mr 27,11
.L300:
	lwz 3,0(29)
	cmpwi 0,3,0
	bc 12,2,.L302
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L405
.L302:
	lwz 0,1556(27)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L300
.L305:
	li 3,0
.L304:
	mr 30,3
.L296:
	lis 9,.LC77@ha
	lis 11,deathmatch@ha
	la 9,.LC77@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L306
	lwz 3,280(31)
	lis 4,.LC59@ha
	la 4,.LC59@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L306
	lis 9,.LC58@ha
	lis 11,game@ha
	la 30,.LC58@l(9)
	la 11,game@l(11)
	stw 30,280(31)
	li 28,0
	lis 9,itemlist@ha
	lwz 0,1556(11)
	la 29,itemlist@l(9)
	cmpw 0,28,0
	bc 4,0,.L315
	mr 27,11
.L310:
	lwz 3,0(29)
	cmpwi 0,3,0
	bc 12,2,.L312
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L406
.L312:
	lwz 0,1556(27)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L310
.L315:
	li 3,0
.L314:
	mr 30,3
.L306:
	lis 9,.LC77@ha
	lis 11,deathmatch@ha
	la 9,.LC77@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L316
	lwz 3,280(31)
	lis 4,.LC60@ha
	la 4,.LC60@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L316
	lis 9,.LC61@ha
	lis 11,game@ha
	la 30,.LC61@l(9)
	la 11,game@l(11)
	stw 30,280(31)
	li 28,0
	lis 9,itemlist@ha
	lwz 0,1556(11)
	la 29,itemlist@l(9)
	cmpw 0,28,0
	bc 4,0,.L325
	mr 27,11
.L320:
	lwz 3,0(29)
	cmpwi 0,3,0
	bc 12,2,.L322
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L407
.L322:
	lwz 0,1556(27)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L320
.L325:
	li 3,0
.L324:
	mr 30,3
.L316:
	lis 9,.LC77@ha
	lis 11,deathmatch@ha
	la 9,.LC77@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L326
	lwz 3,280(31)
	lis 4,.LC62@ha
	la 4,.LC62@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L326
	lis 9,.LC61@ha
	lis 11,game@ha
	la 30,.LC61@l(9)
	la 11,game@l(11)
	stw 30,280(31)
	li 28,0
	lis 9,itemlist@ha
	lwz 0,1556(11)
	la 29,itemlist@l(9)
	cmpw 0,28,0
	bc 4,0,.L335
	mr 27,11
.L330:
	lwz 3,0(29)
	cmpwi 0,3,0
	bc 12,2,.L332
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L408
.L332:
	lwz 0,1556(27)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L330
.L335:
	li 3,0
.L334:
	mr 30,3
.L326:
	lis 9,.LC77@ha
	lis 11,deathmatch@ha
	la 9,.LC77@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L336
	lwz 3,280(31)
	lis 4,.LC63@ha
	la 4,.LC63@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L336
	lis 9,.LC64@ha
	lis 11,game@ha
	la 30,.LC64@l(9)
	la 11,game@l(11)
	stw 30,280(31)
	li 28,0
	lis 9,itemlist@ha
	lwz 0,1556(11)
	la 29,itemlist@l(9)
	cmpw 0,28,0
	bc 4,0,.L345
	mr 27,11
.L340:
	lwz 3,0(29)
	cmpwi 0,3,0
	bc 12,2,.L342
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L409
.L342:
	lwz 0,1556(27)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L340
.L345:
	li 3,0
.L344:
	mr 30,3
.L336:
	lis 9,.LC77@ha
	lis 11,deathmatch@ha
	la 9,.LC77@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L346
	lwz 3,280(31)
	lis 4,.LC65@ha
	la 4,.LC65@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L346
	lis 9,.LC66@ha
	lis 11,game@ha
	la 30,.LC66@l(9)
	la 11,game@l(11)
	stw 30,280(31)
	li 28,0
	lis 9,itemlist@ha
	lwz 0,1556(11)
	la 29,itemlist@l(9)
	cmpw 0,28,0
	bc 4,0,.L355
	mr 27,11
.L350:
	lwz 3,0(29)
	cmpwi 0,3,0
	bc 12,2,.L352
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L410
.L352:
	lwz 0,1556(27)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L350
.L355:
	li 3,0
.L354:
	mr 30,3
.L346:
	lis 9,.LC77@ha
	lis 11,deathmatch@ha
	la 9,.LC77@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L356
	lwz 3,280(31)
	lis 4,.LC67@ha
	la 4,.LC67@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L356
	lis 9,.LC68@ha
	lis 11,game@ha
	la 30,.LC68@l(9)
	la 11,game@l(11)
	stw 30,280(31)
	li 28,0
	lis 9,itemlist@ha
	lwz 0,1556(11)
	la 29,itemlist@l(9)
	cmpw 0,28,0
	bc 4,0,.L365
	mr 27,11
.L360:
	lwz 3,0(29)
	cmpwi 0,3,0
	bc 12,2,.L362
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L411
.L362:
	lwz 0,1556(27)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L360
.L365:
	li 3,0
.L364:
	mr 30,3
.L356:
	lis 9,.LC77@ha
	lis 11,deathmatch@ha
	la 9,.LC77@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L366
	lwz 3,280(31)
	lis 4,.LC69@ha
	la 4,.LC69@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L366
	lis 9,.LC70@ha
	lis 11,game@ha
	la 30,.LC70@l(9)
	la 11,game@l(11)
	stw 30,280(31)
	li 28,0
	lis 9,itemlist@ha
	lwz 0,1556(11)
	la 29,itemlist@l(9)
	cmpw 0,28,0
	bc 4,0,.L375
	mr 27,11
.L370:
	lwz 3,0(29)
	cmpwi 0,3,0
	bc 12,2,.L372
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L412
.L372:
	lwz 0,1556(27)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L370
.L375:
	li 3,0
.L374:
	mr 30,3
.L366:
	lis 9,.LC77@ha
	lis 11,deathmatch@ha
	la 9,.LC77@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L376
	lwz 3,280(31)
	lis 4,.LC71@ha
	la 4,.LC71@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L376
	lis 9,.LC70@ha
	lis 11,game@ha
	la 30,.LC70@l(9)
	la 11,game@l(11)
	stw 30,280(31)
	li 28,0
	lis 9,itemlist@ha
	lwz 0,1556(11)
	la 29,itemlist@l(9)
	cmpw 0,28,0
	bc 4,0,.L385
	mr 27,11
.L380:
	lwz 3,0(29)
	cmpwi 0,3,0
	bc 12,2,.L382
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L413
.L382:
	lwz 0,1556(27)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L380
.L385:
	li 3,0
.L384:
	mr 30,3
.L376:
	mr 3,30
	bl PrecacheItem
	lwz 0,284(31)
	cmpwi 0,0,0
	bc 12,2,.L386
	lwz 3,280(31)
	lis 4,.LC72@ha
	la 4,.LC72@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L386
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
.L386:
	lis 9,.LC77@ha
	lis 11,deathmatch@ha
	la 9,.LC77@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L388
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,2048
	bc 12,2,.L389
	lwz 0,4(30)
	lis 9,Pickup_Armor@ha
	la 9,Pickup_Armor@l(9)
	cmpw 0,0,9
	bc 12,2,.L401
	lis 9,Pickup_PowerArmor@ha
	la 9,Pickup_PowerArmor@l(9)
	cmpw 0,0,9
	bc 4,2,.L389
	b .L401
.L413:
	mr 3,29
	b .L384
.L412:
	mr 3,29
	b .L374
.L411:
	mr 3,29
	b .L364
.L410:
	mr 3,29
	b .L354
.L409:
	mr 3,29
	b .L344
.L408:
	mr 3,29
	b .L334
.L407:
	mr 3,29
	b .L324
.L406:
	mr 3,29
	b .L314
.L405:
	mr 3,29
	b .L304
.L389:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,2
	bc 12,2,.L392
	lwz 0,4(30)
	lis 9,Pickup_Powerup@ha
	la 9,Pickup_Powerup@l(9)
	cmpw 0,0,9
	bc 12,2,.L401
.L392:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L394
	lwz 0,4(30)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L401
	lis 9,Pickup_Adrenaline@ha
	la 9,Pickup_Adrenaline@l(9)
	cmpw 0,0,9
	bc 12,2,.L401
	lis 9,Pickup_AncientHead@ha
	la 9,Pickup_AncientHead@l(9)
	cmpw 0,0,9
	bc 12,2,.L401
.L394:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,8192
	bc 12,2,.L388
	lwz 0,56(30)
	cmpwi 0,0,2
	bc 12,2,.L401
	lwz 3,280(31)
	lis 4,.LC71@ha
	la 4,.LC71@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L401
.L388:
	lis 9,.LC77@ha
	lis 11,ctf@ha
	la 9,.LC77@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L400
	lwz 3,280(31)
	lis 4,.LC74@ha
	la 4,.LC74@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L401
	lwz 3,280(31)
	lis 4,.LC75@ha
	la 4,.LC75@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L400
.L401:
	mr 3,31
	bl G_FreeEdict
	b .L295
.L400:
	stw 30,648(31)
	lis 11,level+4@ha
	lis 10,.LC76@ha
	lfs 0,level+4@l(11)
	lis 9,droptofloor@ha
	lfd 13,.LC76@l(10)
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
	bc 12,2,.L402
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L402:
	lwz 3,280(31)
	lis 4,.LC74@ha
	la 4,.LC74@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L404
	lwz 3,280(31)
	lis 4,.LC75@ha
	la 4,.LC75@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L295
.L404:
	lis 9,CTFFlagSetup@ha
	la 9,CTFFlagSetup@l(9)
	stw 9,436(31)
.L295:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
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
	.long .LC78
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC79
	.long .LC80
	.long 1
	.long 0
	.long .LC81
	.long .LC82
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long bodyarmor_info
	.long 3
	.long .LC83
	.long .LC84
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC79
	.long .LC85
	.long 1
	.long 0
	.long .LC86
	.long .LC87
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long combatarmor_info
	.long 2
	.long .LC83
	.long .LC88
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC79
	.long .LC89
	.long 1
	.long 0
	.long .LC90
	.long .LC91
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long jacketarmor_info
	.long 1
	.long .LC83
	.long .LC92
	.long Pickup_Armor
	.long 0
	.long 0
	.long 0
	.long .LC93
	.long .LC94
	.long 1
	.long 0
	.long .LC90
	.long .LC95
	.long 3
	.long 0
	.long 0
	.long 4
	.long 0
	.long 0
	.long 4
	.long .LC83
	.long .LC96
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC97
	.long .LC98
	.long 1
	.long 0
	.long .LC99
	.long .LC100
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long .LC101
	.long Pickup_PowerArmor
	.long Use_PowerArmor
	.long Drop_PowerArmor
	.long 0
	.long .LC97
	.long .LC102
	.long 1
	.long 0
	.long .LC103
	.long .LC104
	.long 0
	.long 60
	.long 0
	.long 4
	.long 0
	.long 0
	.long 0
	.long .LC105
	.long .LC106
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_Pistol
	.long .LC107
	.long 0
	.long 0
	.long .LC108
	.long .LC109
	.long .LC110
	.long 0
	.long 1
	.long .LC111
	.long 1
	.long 0
	.long 0
	.long 0
	.long .LC112
	.long .LC113
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_FlareGun
	.long .LC107
	.long 0
	.long 0
	.long .LC114
	.long .LC115
	.long .LC116
	.long 0
	.long 1
	.long .LC117
	.long 1
	.long 12
	.long 0
	.long 0
	.long .LC83
	.long .LC57
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Shotgun
	.long .LC107
	.long .LC118
	.long 1
	.long .LC119
	.long .LC120
	.long .LC121
	.long 0
	.long 1
	.long .LC122
	.long 1
	.long 2
	.long 0
	.long 0
	.long .LC123
	.long .LC59
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_SuperShotgun
	.long .LC107
	.long .LC124
	.long 1
	.long .LC125
	.long .LC126
	.long .LC127
	.long 0
	.long 2
	.long .LC122
	.long 1
	.long 3
	.long 0
	.long 0
	.long .LC128
	.long .LC60
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Machinegun
	.long .LC107
	.long .LC129
	.long 1
	.long .LC130
	.long .LC131
	.long .LC132
	.long 0
	.long 1
	.long .LC111
	.long 1
	.long 4
	.long 0
	.long 0
	.long .LC133
	.long .LC62
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Chaingun
	.long .LC107
	.long .LC134
	.long 1
	.long .LC135
	.long .LC136
	.long .LC137
	.long 0
	.long 1
	.long .LC111
	.long 1
	.long 5
	.long 0
	.long 0
	.long .LC138
	.long .LC64
	.long Pickup_Ammo
	.long Use_Weapon
	.long Drop_Ammo
	.long Weapon_Grenade
	.long .LC139
	.long .LC140
	.long 0
	.long .LC141
	.long .LC142
	.long .LC143
	.long 3
	.long 5
	.long .LC144
	.long 3
	.long 6
	.long 0
	.long 3
	.long .LC145
	.long .LC63
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_GrenadeLauncher
	.long .LC107
	.long .LC146
	.long 1
	.long .LC147
	.long .LC148
	.long .LC149
	.long 0
	.long 1
	.long .LC143
	.long 1
	.long 7
	.long 0
	.long 0
	.long .LC150
	.long .LC65
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_RocketLauncher
	.long .LC107
	.long .LC151
	.long 1
	.long .LC152
	.long .LC153
	.long .LC154
	.long 0
	.long 1
	.long .LC155
	.long 1
	.long 8
	.long 0
	.long 0
	.long .LC156
	.long .LC69
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_HyperBlaster
	.long .LC107
	.long .LC157
	.long 1
	.long .LC158
	.long .LC159
	.long .LC160
	.long 0
	.long 1
	.long .LC117
	.long 1
	.long 9
	.long 0
	.long 0
	.long .LC161
	.long .LC67
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_Railgun
	.long .LC107
	.long .LC162
	.long 1
	.long .LC163
	.long .LC164
	.long .LC165
	.long 0
	.long 1
	.long .LC166
	.long 1
	.long 10
	.long 0
	.long 0
	.long .LC167
	.long .LC71
	.long Pickup_Weapon
	.long Use_Weapon
	.long Drop_Weapon
	.long Weapon_BFG
	.long .LC107
	.long .LC168
	.long 1
	.long .LC169
	.long .LC170
	.long .LC171
	.long 0
	.long 50
	.long .LC117
	.long 1
	.long 11
	.long 0
	.long 0
	.long .LC172
	.long .LC173
	.long 0
	.long Use_Weapon
	.long 0
	.long Weapon_DualMachinegun
	.long .LC107
	.long 0
	.long 0
	.long .LC174
	.long .LC131
	.long .LC175
	.long 0
	.long 1
	.long .LC111
	.long 1
	.long 4
	.long 0
	.long 0
	.long .LC133
	.long .LC58
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC139
	.long .LC176
	.long 0
	.long 0
	.long .LC177
	.long .LC122
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 1
	.long .LC83
	.long .LC61
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC139
	.long .LC178
	.long 0
	.long 0
	.long .LC179
	.long .LC111
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long .LC70
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC139
	.long .LC180
	.long 0
	.long 0
	.long .LC181
	.long .LC117
	.long 3
	.long 50
	.long 0
	.long 2
	.long 0
	.long 0
	.long 4
	.long .LC83
	.long .LC66
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC139
	.long .LC182
	.long 0
	.long 0
	.long .LC183
	.long .LC155
	.long 3
	.long 5
	.long 0
	.long 2
	.long 0
	.long 0
	.long 2
	.long .LC83
	.long .LC68
	.long Pickup_Ammo
	.long 0
	.long Drop_Ammo
	.long 0
	.long .LC139
	.long .LC184
	.long 0
	.long 0
	.long .LC185
	.long .LC166
	.long 3
	.long 10
	.long 0
	.long 2
	.long 0
	.long 0
	.long 5
	.long .LC83
	.long .LC186
	.long Pickup_Powerup
	.long Use_Jet
	.long 0
	.long 0
	.long .LC187
	.long .LC188
	.long 1
	.long 0
	.long .LC189
	.long .LC0
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC190
	.long .LC191
	.long Pickup_Powerup
	.long Use_Quad
	.long Drop_General
	.long 0
	.long .LC187
	.long .LC192
	.long 1
	.long 0
	.long .LC189
	.long .LC193
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC194
	.long .LC195
	.long Pickup_Powerup
	.long Use_Invulnerability
	.long Drop_General
	.long 0
	.long .LC187
	.long .LC196
	.long 1
	.long 0
	.long .LC197
	.long .LC198
	.long 2
	.long 300
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC199
	.long .LC200
	.long Pickup_Powerup
	.long Use_Silencer
	.long Drop_General
	.long 0
	.long .LC187
	.long .LC201
	.long 1
	.long 0
	.long .LC202
	.long .LC203
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long .LC204
	.long Pickup_Powerup
	.long Use_Breather
	.long Drop_General
	.long 0
	.long .LC187
	.long .LC205
	.long 1
	.long 0
	.long .LC206
	.long .LC207
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC208
	.long .LC209
	.long Pickup_Powerup
	.long Use_Envirosuit
	.long Drop_General
	.long 0
	.long .LC187
	.long .LC210
	.long 1
	.long 0
	.long .LC211
	.long .LC212
	.long 2
	.long 60
	.long 0
	.long 32
	.long 0
	.long 0
	.long 0
	.long .LC208
	.long .LC213
	.long Pickup_AncientHead
	.long 0
	.long 0
	.long 0
	.long .LC187
	.long .LC214
	.long 1
	.long 0
	.long .LC215
	.long .LC216
	.long 2
	.long 60
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long .LC217
	.long Pickup_Adrenaline
	.long 0
	.long 0
	.long 0
	.long .LC187
	.long .LC218
	.long 1
	.long 0
	.long .LC219
	.long .LC220
	.long 2
	.long 60
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long .LC221
	.long Pickup_Bandolier
	.long 0
	.long 0
	.long 0
	.long .LC187
	.long .LC222
	.long 1
	.long 0
	.long .LC223
	.long .LC224
	.long 2
	.long 60
	.long 0
	.long 128
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long .LC225
	.long Pickup_Pack
	.long 0
	.long 0
	.long 0
	.long .LC187
	.long .LC226
	.long 1
	.long 0
	.long .LC227
	.long .LC228
	.long 2
	.long 180
	.long 0
	.long 128
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long .LC229
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC187
	.long .LC230
	.long 1
	.long 0
	.long .LC231
	.long .LC232
	.long 2
	.long 0
	.long 0
	.long 16
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long .LC72
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC187
	.long .LC233
	.long 1
	.long 0
	.long .LC234
	.long .LC235
	.long 2
	.long 0
	.long 0
	.long 16
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long .LC236
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC187
	.long .LC237
	.long 1
	.long 0
	.long .LC238
	.long .LC239
	.long 2
	.long 0
	.long 0
	.long 16
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long .LC240
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC187
	.long .LC241
	.long 1
	.long 0
	.long .LC242
	.long .LC243
	.long 2
	.long 0
	.long 0
	.long 16
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long .LC244
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC187
	.long .LC245
	.long 1
	.long 0
	.long .LC246
	.long .LC247
	.long 2
	.long 0
	.long 0
	.long 16
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long .LC248
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC187
	.long .LC249
	.long 1
	.long 0
	.long .LC250
	.long .LC251
	.long 2
	.long 0
	.long 0
	.long 16
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long .LC252
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC187
	.long .LC253
	.long 1
	.long 0
	.long .LC254
	.long .LC255
	.long 2
	.long 0
	.long 0
	.long 16
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long .LC256
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC187
	.long .LC257
	.long 2
	.long 0
	.long .LC258
	.long .LC259
	.long 2
	.long 0
	.long 0
	.long 16
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long .LC260
	.long Pickup_Key
	.long 0
	.long Drop_General
	.long 0
	.long .LC187
	.long .LC261
	.long 1
	.long 0
	.long .LC262
	.long .LC263
	.long 2
	.long 0
	.long 0
	.long 16
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long 0
	.long Pickup_Health
	.long 0
	.long 0
	.long 0
	.long .LC187
	.long 0
	.long 0
	.long 0
	.long .LC264
	.long .LC265
	.long 3
	.long 0
	.long 0
	.long 64
	.long 0
	.long 0
	.long 0
	.long .LC266
	.long .LC74
	.long CTFPickup_Flag
	.long 0
	.long 0
	.long 0
	.long .LC267
	.long .LC268
	.long 262144
	.long 0
	.long .LC269
	.long .LC270
	.long 2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC271
	.long .LC75
	.long CTFPickup_Flag
	.long 0
	.long 0
	.long 0
	.long .LC267
	.long .LC272
	.long 524288
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
	.long .LC271
	.long 0
	.space	72
	.section	".rodata"
	.align 2
.LC274:
	.string	"Blue Flag"
	.align 2
.LC273:
	.string	"i_ctf2"
	.align 2
.LC272:
	.string	"players/male/flag2.md2"
	.align 2
.LC271:
	.string	"ctf/flagcap.wav"
	.align 2
.LC270:
	.string	"Red Flag"
	.align 2
.LC269:
	.string	"i_ctf1"
	.align 2
.LC268:
	.string	"players/male/flag1.md2"
	.align 2
.LC267:
	.string	"ctf/flagtk.wav"
	.align 2
.LC266:
	.string	"items/s_health.wav items/n_health.wav items/l_health.wav items/m_health.wav"
	.align 2
.LC265:
	.string	"Health"
	.align 2
.LC264:
	.string	"i_health"
	.align 2
.LC263:
	.string	"Airstrike Marker"
	.align 2
.LC262:
	.string	"i_airstrike"
	.align 2
.LC261:
	.string	"models/items/keys/target/tris.md2"
	.align 2
.LC260:
	.string	"key_airstrike_target"
	.align 2
.LC259:
	.string	"Commander's Head"
	.align 2
.LC258:
	.string	"k_comhead"
	.align 2
.LC257:
	.string	"models/monsters/commandr/head/tris.md2"
	.align 2
.LC256:
	.string	"key_commander_head"
	.align 2
.LC255:
	.string	"Red Key"
	.align 2
.LC254:
	.string	"k_redkey"
	.align 2
.LC253:
	.string	"models/items/keys/red_key/tris.md2"
	.align 2
.LC252:
	.string	"key_red_key"
	.align 2
.LC251:
	.string	"Blue Key"
	.align 2
.LC250:
	.string	"k_bluekey"
	.align 2
.LC249:
	.string	"models/items/keys/key/tris.md2"
	.align 2
.LC248:
	.string	"key_blue_key"
	.align 2
.LC247:
	.string	"Security Pass"
	.align 2
.LC246:
	.string	"k_security"
	.align 2
.LC245:
	.string	"models/items/keys/pass/tris.md2"
	.align 2
.LC244:
	.string	"key_pass"
	.align 2
.LC243:
	.string	"Data Spinner"
	.align 2
.LC242:
	.string	"k_dataspin"
	.align 2
.LC241:
	.string	"models/items/keys/spinner/tris.md2"
	.align 2
.LC240:
	.string	"key_data_spinner"
	.align 2
.LC239:
	.string	"Pyramid Key"
	.align 2
.LC238:
	.string	"k_pyramid"
	.align 2
.LC237:
	.string	"models/items/keys/pyramid/tris.md2"
	.align 2
.LC236:
	.string	"key_pyramid"
	.align 2
.LC235:
	.string	"Power Cube"
	.align 2
.LC234:
	.string	"k_powercube"
	.align 2
.LC233:
	.string	"models/items/keys/power/tris.md2"
	.align 2
.LC232:
	.string	"Data CD"
	.align 2
.LC231:
	.string	"k_datacd"
	.align 2
.LC230:
	.string	"models/items/keys/data_cd/tris.md2"
	.align 2
.LC229:
	.string	"key_data_cd"
	.align 2
.LC228:
	.string	"Ammo Pack"
	.align 2
.LC227:
	.string	"i_pack"
	.align 2
.LC226:
	.string	"models/items/pack/tris.md2"
	.align 2
.LC225:
	.string	"item_pack"
	.align 2
.LC224:
	.string	"Bandolier"
	.align 2
.LC223:
	.string	"p_bandolier"
	.align 2
.LC222:
	.string	"models/items/band/tris.md2"
	.align 2
.LC221:
	.string	"item_bandolier"
	.align 2
.LC220:
	.string	"Adrenaline"
	.align 2
.LC219:
	.string	"p_adrenaline"
	.align 2
.LC218:
	.string	"models/items/adrenal/tris.md2"
	.align 2
.LC217:
	.string	"item_adrenaline"
	.align 2
.LC216:
	.string	"Ancient Head"
	.align 2
.LC215:
	.string	"i_fixme"
	.align 2
.LC214:
	.string	"models/items/c_head/tris.md2"
	.align 2
.LC213:
	.string	"item_ancient_head"
	.align 2
.LC212:
	.string	"Environment Suit"
	.align 2
.LC211:
	.string	"p_envirosuit"
	.align 2
.LC210:
	.string	"models/items/enviro/tris.md2"
	.align 2
.LC209:
	.string	"item_enviro"
	.align 2
.LC208:
	.string	"items/airout.wav"
	.align 2
.LC207:
	.string	"Rebreather"
	.align 2
.LC206:
	.string	"p_rebreather"
	.align 2
.LC205:
	.string	"models/items/breather/tris.md2"
	.align 2
.LC204:
	.string	"item_breather"
	.align 2
.LC203:
	.string	"Silencer"
	.align 2
.LC202:
	.string	"p_silencer"
	.align 2
.LC201:
	.string	"models/items/silencer/tris.md2"
	.align 2
.LC200:
	.string	"item_silencer"
	.align 2
.LC199:
	.string	"items/protect.wav items/protect2.wav items/protect4.wav"
	.align 2
.LC198:
	.string	"Invulnerability"
	.align 2
.LC197:
	.string	"p_invulnerability"
	.align 2
.LC196:
	.string	"models/items/invulner/tris.md2"
	.align 2
.LC195:
	.string	"item_invulnerability"
	.align 2
.LC194:
	.string	"items/damage.wav items/damage2.wav items/damage3.wav"
	.align 2
.LC193:
	.string	"Quad Damage"
	.align 2
.LC192:
	.string	"models/items/quaddama/tris.md2"
	.align 2
.LC191:
	.string	"item_quad"
	.align 2
.LC190:
	.string	"hover/hovidle1.wav items/damage.wav items/damage2.wav items/damage3.wav"
	.align 2
.LC189:
	.string	"p_quad"
	.align 2
.LC188:
	.string	"models/monsters/hover/tris.md2"
	.align 2
.LC187:
	.string	"items/pkup.wav"
	.align 2
.LC186:
	.string	"item_jet"
	.align 2
.LC185:
	.string	"a_slugs"
	.align 2
.LC184:
	.string	"models/items/ammo/slugs/medium/tris.md2"
	.align 2
.LC183:
	.string	"a_rockets"
	.align 2
.LC182:
	.string	"models/items/ammo/rockets/medium/tris.md2"
	.align 2
.LC181:
	.string	"a_cells"
	.align 2
.LC180:
	.string	"models/items/ammo/cells/medium/tris.md2"
	.align 2
.LC179:
	.string	"a_bullets"
	.align 2
.LC178:
	.string	"models/items/ammo/bullets/medium/tris.md2"
	.align 2
.LC177:
	.string	"a_shells"
	.align 2
.LC176:
	.string	"models/items/ammo/shells/medium/tris.md2"
	.align 2
.LC175:
	.string	"Dual Machineguns"
	.align 2
.LC174:
	.string	"models/weapons/v_2machn/tris.md2"
	.align 2
.LC173:
	.string	"weapon_2machineguns"
	.align 2
.LC172:
	.string	"sprites/s_bfg1.sp2 sprites/s_bfg2.sp2 sprites/s_bfg3.sp2 weapons/bfg__f1y.wav weapons/bfg__l1a.wav weapons/bfg__x1b.wav weapons/bfg_hum.wav"
	.align 2
.LC171:
	.string	"BFG10K"
	.align 2
.LC170:
	.string	"w_bfg"
	.align 2
.LC169:
	.string	"models/weapons/v_bfg/tris.md2"
	.align 2
.LC168:
	.string	"models/weapons/g_bfg/tris.md2"
	.align 2
.LC167:
	.string	"weapons/rg_hum.wav"
	.align 2
.LC166:
	.string	"Slugs"
	.align 2
.LC165:
	.string	"Railgun"
	.align 2
.LC164:
	.string	"w_railgun"
	.align 2
.LC163:
	.string	"models/weapons/v_rail/tris.md2"
	.align 2
.LC162:
	.string	"models/weapons/g_rail/tris.md2"
	.align 2
.LC161:
	.string	"weapons/hyprbu1a.wav weapons/hyprbl1a.wav weapons/hyprbf1a.wav weapons/hyprbd1a.wav misc/lasfly.wav"
	.align 2
.LC160:
	.string	"HyperBlaster"
	.align 2
.LC159:
	.string	"w_hyperblaster"
	.align 2
.LC158:
	.string	"models/weapons/v_hyperb/tris.md2"
	.align 2
.LC157:
	.string	"models/weapons/g_hyperb/tris.md2"
	.align 2
.LC156:
	.string	"models/objects/rocket/tris.md2 weapons/rockfly.wav weapons/rocklf1a.wav weapons/rocklr1b.wav models/objects/debris2/tris.md2"
	.align 2
.LC155:
	.string	"Rockets"
	.align 2
.LC154:
	.string	"Rocket Launcher"
	.align 2
.LC153:
	.string	"w_rlauncher"
	.align 2
.LC152:
	.string	"models/weapons/v_rocket/tris.md2"
	.align 2
.LC151:
	.string	"models/weapons/g_rocket/tris.md2"
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
	.string	"weapons/hgrent1a.wav weapons/hgrena1b.wav weapons/hgrenc1b.wav weapons/hgrenb1a.wav weapons/hgrenb2a.wav "
	.align 2
.LC144:
	.string	"grenades"
	.align 2
.LC143:
	.string	"Grenades"
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
	.string	"weapons/chngnu1a.wav weapons/chngnl1a.wav weapons/machgf3b.wav` weapons/chngnd1a.wav"
	.align 2
.LC137:
	.string	"Chaingun"
	.align 2
.LC136:
	.string	"w_chaingun"
	.align 2
.LC135:
	.string	"models/weapons/v_chain/tris.md2"
	.align 2
.LC134:
	.string	"models/weapons/g_chain/tris.md2"
	.align 2
.LC133:
	.string	"weapons/machgf1b.wav weapons/machgf2b.wav weapons/machgf3b.wav weapons/machgf4b.wav weapons/machgf5b.wav"
	.align 2
.LC132:
	.string	"Machinegun"
	.align 2
.LC131:
	.string	"w_machinegun"
	.align 2
.LC130:
	.string	"models/weapons/v_machn/tris.md2"
	.align 2
.LC129:
	.string	"models/weapons/g_machn/tris.md2"
	.align 2
.LC128:
	.string	"weapons/sshotf1b.wav"
	.align 2
.LC127:
	.string	"Super Shotgun"
	.align 2
.LC126:
	.string	"w_sshotgun"
	.align 2
.LC125:
	.string	"models/weapons/v_shotg2/tris.md2"
	.align 2
.LC124:
	.string	"models/weapons/g_shotg2/tris.md2"
	.align 2
.LC123:
	.string	"weapons/shotgf1b.wav weapons/shotgr1b.wav"
	.align 2
.LC122:
	.string	"Shells"
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
	.string	"Cells"
	.align 2
.LC116:
	.string	"Flare Gun"
	.align 2
.LC115:
	.string	"w_flareg"
	.align 2
.LC114:
	.string	"models/weapons/v_flareg/tris.md2"
	.align 2
.LC113:
	.string	"weapon_flaregun"
	.align 2
.LC112:
	.string	"weapons/blastf1a.wav misc/lasfly.wav"
	.align 2
.LC111:
	.string	"Bullets"
	.align 2
.LC110:
	.string	"Pistol"
	.align 2
.LC109:
	.string	"w_pistol"
	.align 2
.LC108:
	.string	"models/weapons/v_glock/tris.md2"
	.align 2
.LC107:
	.string	"misc/w_pkup.wav"
	.align 2
.LC106:
	.string	"weapon_pistol"
	.align 2
.LC105:
	.string	"misc/power2.wav misc/power1.wav"
	.align 2
.LC104:
	.string	"Power Shield"
	.align 2
.LC103:
	.string	"i_powershield"
	.align 2
.LC102:
	.string	"models/items/armor/shield/tris.md2"
	.align 2
.LC101:
	.string	"item_power_shield"
	.align 2
.LC100:
	.string	"Power Screen"
	.align 2
.LC99:
	.string	"i_powerscreen"
	.align 2
.LC98:
	.string	"models/items/armor/screen/tris.md2"
	.align 2
.LC97:
	.string	"misc/ar3_pkup.wav"
	.align 2
.LC96:
	.string	"item_power_screen"
	.align 2
.LC95:
	.string	"Armor Shard"
	.align 2
.LC94:
	.string	"models/items/armor/shard/tris.md2"
	.align 2
.LC93:
	.string	"misc/ar2_pkup.wav"
	.align 2
.LC92:
	.string	"item_armor_shard"
	.align 2
.LC91:
	.string	"Jacket Armor"
	.align 2
.LC90:
	.string	"i_jacketarmor"
	.align 2
.LC89:
	.string	"models/items/armor/jacket/tris.md2"
	.align 2
.LC88:
	.string	"item_armor_jacket"
	.align 2
.LC87:
	.string	"Combat Armor"
	.align 2
.LC86:
	.string	"i_combatarmor"
	.align 2
.LC85:
	.string	"models/items/armor/combat/tris.md2"
	.align 2
.LC84:
	.string	"item_armor_combat"
	.align 2
.LC83:
	.string	""
	.align 2
.LC82:
	.string	"Body Armor"
	.align 2
.LC81:
	.string	"i_bodyarmor"
	.align 2
.LC80:
	.string	"models/items/armor/body/tris.md2"
	.align 2
.LC79:
	.string	"misc/ar1_pkup.wav"
	.align 2
.LC78:
	.string	"item_armor_body"
	.size	 itemlist,3648
	.align 2
.LC275:
	.string	"models/items/healing/medium/tris.md2"
	.align 2
.LC276:
	.string	"models/items/healing/stimpack/tris.md2"
	.align 2
.LC277:
	.string	"models/items/healing/large/tris.md2"
	.align 2
.LC278:
	.string	"models/items/mega_h/tris.md2"
	.align 2
.LC279:
	.string	"shells"
	.align 2
.LC280:
	.string	"cells"
	.align 2
.LC281:
	.string	"bullets"
	.align 2
.LC282:
	.string	"rockets"
	.align 2
.LC283:
	.string	"slugs"
	.align 2
.LC284:
	.string	"pistol"
	.align 2
.LC285:
	.string	"shotgun"
	.align 2
.LC286:
	.string	"super shotgun"
	.align 2
.LC287:
	.string	"machinegun"
	.align 2
.LC288:
	.string	"chaingun"
	.align 2
.LC289:
	.string	"grenade launcher"
	.align 2
.LC290:
	.string	"rocket launcher"
	.align 2
.LC291:
	.string	"railgun"
	.align 2
.LC292:
	.string	"hyperblaster"
	.align 2
.LC293:
	.string	"bfg10k"
	.section	".text"
	.align 2
	.globl SetItemNames
	.type	 SetItemNames,@function
SetItemNames:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,game@ha
	li 29,0
	la 10,game@l(9)
	lwz 0,1556(10)
	cmpw 0,29,0
	bc 4,0,.L457
	lis 11,itemlist@ha
	lis 9,gi@ha
	la 11,itemlist@l(11)
	la 30,gi@l(9)
	mr 31,10
	addi 28,11,40
.L459:
	lwz 9,24(30)
	addi 3,29,1056
	lwz 4,0(28)
	addi 29,29,1
	mtlr 9
	addi 28,28,76
	blrl
	lwz 0,1556(31)
	cmpw 0,29,0
	bc 12,0,.L459
.L457:
	lis 9,game@ha
	li 28,0
	la 10,game@l(9)
	lis 11,.LC91@ha
	lwz 0,1556(10)
	lis 9,itemlist@ha
	la 30,.LC91@l(11)
	la 29,itemlist@l(9)
	cmpw 0,28,0
	bc 4,0,.L468
	mr 31,10
.L463:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L465
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L465
	mr 8,29
	b .L467
.L465:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L463
.L468:
	li 8,0
.L467:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_jacketarmor@ha
	lwz 0,1556(7)
	lis 9,.LC87@ha
	lis 11,itemlist@ha
	la 30,.LC87@l(9)
	stw 8,item_jacketarmor@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L476
	mr 31,7
.L471:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L473
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L473
	mr 8,29
	b .L475
.L473:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L471
.L476:
	li 8,0
.L475:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_combatarmor@ha
	lwz 0,1556(7)
	lis 9,.LC82@ha
	lis 11,itemlist@ha
	la 30,.LC82@l(9)
	stw 8,item_combatarmor@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L484
	mr 31,7
.L479:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L481
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L481
	mr 8,29
	b .L483
.L481:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L479
.L484:
	li 8,0
.L483:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_bodyarmor@ha
	lwz 0,1556(7)
	lis 9,.LC95@ha
	lis 11,itemlist@ha
	la 30,.LC95@l(9)
	stw 8,item_bodyarmor@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L492
	mr 31,7
.L487:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L489
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L489
	mr 8,29
	b .L491
.L489:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L487
.L492:
	li 8,0
.L491:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_armorshard@ha
	lwz 0,1556(7)
	lis 9,.LC100@ha
	lis 11,itemlist@ha
	la 30,.LC100@l(9)
	stw 8,item_armorshard@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L500
	mr 31,7
.L495:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L497
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L497
	mr 8,29
	b .L499
.L497:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L495
.L500:
	li 8,0
.L499:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_powerscreen@ha
	lwz 0,1556(7)
	lis 9,.LC104@ha
	lis 11,itemlist@ha
	la 30,.LC104@l(9)
	stw 8,item_powerscreen@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L508
	mr 31,7
.L503:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L505
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L507
.L505:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L503
.L508:
	li 29,0
.L507:
	lis 9,item_jacketarmor@ha
	lis 7,item_combatarmor@ha
	lwz 11,item_jacketarmor@l(9)
	lis 6,item_bodyarmor@ha
	lis 10,itemlist@ha
	lwz 8,item_combatarmor@l(7)
	lis 9,game@ha
	la 10,itemlist@l(10)
	lis 5,item_powerscreen@ha
	lwz 7,item_bodyarmor@l(6)
	la 30,game@l(9)
	lis 0,0x286b
	lwz 9,item_powerscreen@l(5)
	subf 11,10,11
	ori 0,0,51739
	subf 8,10,8
	lwz 4,1556(30)
	subf 7,10,7
	mullw 11,11,0
	subf 5,10,29
	lis 6,item_powershield@ha
	subf 9,10,9
	mullw 8,8,0
	mullw 7,7,0
	stw 29,item_powershield@l(6)
	srawi 11,11,2
	li 31,0
	mullw 5,5,0
	lis 3,jacket_armor_index@ha
	lis 28,combat_armor_index@ha
	mullw 9,9,0
	lis 29,body_armor_index@ha
	cmpw 0,31,4
	stw 11,jacket_armor_index@l(3)
	srawi 8,8,2
	srawi 7,7,2
	srawi 5,5,2
	lis 4,power_screen_index@ha
	stw 8,combat_armor_index@l(28)
	lis 6,power_shield_index@ha
	lis 11,.LC279@ha
	stw 7,body_armor_index@l(29)
	srawi 9,9,2
	la 28,.LC279@l(11)
	stw 5,power_shield_index@l(6)
	stw 9,power_screen_index@l(4)
	mr 29,10
	bc 4,0,.L516
.L511:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L513
	mr 4,28
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L513
	mr 8,29
	b .L515
.L513:
	lwz 0,1556(30)
	addi 31,31,1
	addi 29,29,76
	cmpw 0,31,0
	bc 12,0,.L511
.L516:
	li 8,0
.L515:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_shells@ha
	lwz 0,1556(7)
	lis 9,.LC280@ha
	lis 11,itemlist@ha
	la 30,.LC280@l(9)
	stw 8,item_shells@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L524
	mr 31,7
.L519:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L521
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L521
	mr 8,29
	b .L523
.L521:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L519
.L524:
	li 8,0
.L523:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_cells@ha
	lwz 0,1556(7)
	lis 9,.LC281@ha
	lis 11,itemlist@ha
	la 30,.LC281@l(9)
	stw 8,item_cells@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L532
	mr 31,7
.L527:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L529
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L529
	mr 8,29
	b .L531
.L529:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L527
.L532:
	li 8,0
.L531:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_bullets@ha
	lwz 0,1556(7)
	lis 9,.LC282@ha
	lis 11,itemlist@ha
	la 30,.LC282@l(9)
	stw 8,item_bullets@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L540
	mr 31,7
.L535:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L537
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L537
	mr 8,29
	b .L539
.L537:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L535
.L540:
	li 8,0
.L539:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_rockets@ha
	lwz 0,1556(7)
	lis 9,.LC283@ha
	lis 11,itemlist@ha
	la 30,.LC283@l(9)
	stw 8,item_rockets@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L548
	mr 31,7
.L543:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L545
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L545
	mr 8,29
	b .L547
.L545:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L543
.L548:
	li 8,0
.L547:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_slugs@ha
	lwz 0,1556(7)
	lis 9,.LC144@ha
	lis 11,itemlist@ha
	la 30,.LC144@l(9)
	stw 8,item_slugs@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L556
	mr 31,7
.L551:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L553
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L553
	mr 8,29
	b .L555
.L553:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L551
.L556:
	li 8,0
.L555:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_grenades@ha
	lwz 0,1556(7)
	lis 9,.LC284@ha
	lis 11,itemlist@ha
	la 30,.LC284@l(9)
	stw 8,item_grenades@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L564
	mr 31,7
.L559:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L561
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L561
	mr 8,29
	b .L563
.L561:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L559
.L564:
	li 8,0
.L563:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_blaster@ha
	lwz 0,1556(7)
	lis 9,.LC285@ha
	lis 11,itemlist@ha
	la 30,.LC285@l(9)
	stw 8,item_blaster@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L572
	mr 31,7
.L567:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L569
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L569
	mr 8,29
	b .L571
.L569:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L567
.L572:
	li 8,0
.L571:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_shotgun@ha
	lwz 0,1556(7)
	lis 9,.LC286@ha
	lis 11,itemlist@ha
	la 30,.LC286@l(9)
	stw 8,item_shotgun@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L580
	mr 31,7
.L575:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L577
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L577
	mr 8,29
	b .L579
.L577:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L575
.L580:
	li 8,0
.L579:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_supershotgun@ha
	lwz 0,1556(7)
	lis 9,.LC144@ha
	lis 11,itemlist@ha
	la 30,.LC144@l(9)
	stw 8,item_supershotgun@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L588
	mr 31,7
.L583:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L585
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L585
	mr 8,29
	b .L587
.L585:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L583
.L588:
	li 8,0
.L587:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_handgrenade@ha
	lwz 0,1556(7)
	lis 9,.LC287@ha
	lis 11,itemlist@ha
	la 30,.LC287@l(9)
	stw 8,item_handgrenade@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L596
	mr 31,7
.L591:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L593
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L593
	mr 8,29
	b .L595
.L593:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L591
.L596:
	li 8,0
.L595:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_machinegun@ha
	lwz 0,1556(7)
	lis 9,.LC288@ha
	lis 11,itemlist@ha
	la 30,.LC288@l(9)
	stw 8,item_machinegun@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L604
	mr 31,7
.L599:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L601
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L601
	mr 8,29
	b .L603
.L601:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L599
.L604:
	li 8,0
.L603:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_chaingun@ha
	lwz 0,1556(7)
	lis 9,.LC289@ha
	lis 11,itemlist@ha
	la 30,.LC289@l(9)
	stw 8,item_chaingun@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L612
	mr 31,7
.L607:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L609
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L609
	mr 8,29
	b .L611
.L609:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L607
.L612:
	li 8,0
.L611:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_grenadelauncher@ha
	lwz 0,1556(7)
	lis 9,.LC290@ha
	lis 11,itemlist@ha
	la 30,.LC290@l(9)
	stw 8,item_grenadelauncher@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L620
	mr 31,7
.L615:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L617
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L617
	mr 8,29
	b .L619
.L617:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L615
.L620:
	li 8,0
.L619:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_rocketlauncher@ha
	lwz 0,1556(7)
	lis 9,.LC291@ha
	lis 11,itemlist@ha
	la 30,.LC291@l(9)
	stw 8,item_rocketlauncher@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L628
	mr 31,7
.L623:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L625
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L625
	mr 8,29
	b .L627
.L625:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L623
.L628:
	li 8,0
.L627:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_railgun@ha
	lwz 0,1556(7)
	lis 9,.LC292@ha
	lis 11,itemlist@ha
	la 30,.LC292@l(9)
	stw 8,item_railgun@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L636
	mr 31,7
.L631:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L633
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L633
	mr 8,29
	b .L635
.L633:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L631
.L636:
	li 8,0
.L635:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_hyperblaster@ha
	lwz 0,1556(7)
	lis 9,.LC293@ha
	lis 11,itemlist@ha
	la 30,.LC293@l(9)
	stw 8,item_hyperblaster@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L644
	mr 31,7
.L639:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L641
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L641
	mr 8,29
	b .L643
.L641:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L639
.L644:
	li 8,0
.L643:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_bfg@ha
	lwz 0,1556(7)
	lis 9,.LC220@ha
	lis 11,itemlist@ha
	la 30,.LC220@l(9)
	stw 8,item_bfg@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L652
	mr 31,7
.L647:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L649
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L649
	mr 8,29
	b .L651
.L649:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L647
.L652:
	li 8,0
.L651:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_adrenaline@ha
	lwz 0,1556(7)
	lis 9,.LC265@ha
	lis 11,itemlist@ha
	la 30,.LC265@l(9)
	stw 8,item_adrenaline@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L660
	mr 31,7
.L655:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L657
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L657
	mr 8,29
	b .L659
.L657:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L655
.L660:
	li 8,0
.L659:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_health@ha
	lwz 0,1556(7)
	lis 9,.LC265@ha
	lis 11,itemlist@ha
	la 30,.LC265@l(9)
	stw 8,item_health@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L668
	mr 31,7
.L663:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L665
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L665
	mr 8,29
	b .L667
.L665:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L663
.L668:
	li 8,0
.L667:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_stimpak@ha
	lwz 0,1556(7)
	lis 9,.LC265@ha
	lis 11,itemlist@ha
	la 30,.LC265@l(9)
	stw 8,item_stimpak@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L676
	mr 31,7
.L671:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L673
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L673
	mr 8,29
	b .L675
.L673:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L671
.L676:
	li 8,0
.L675:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_health_large@ha
	lwz 0,1556(7)
	lis 9,.LC265@ha
	lis 11,itemlist@ha
	la 30,.LC265@l(9)
	stw 8,item_health_large@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L684
	mr 31,7
.L679:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L681
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L681
	mr 8,29
	b .L683
.L681:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L679
.L684:
	li 8,0
.L683:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_health_mega@ha
	lwz 0,1556(7)
	lis 9,.LC193@ha
	lis 11,itemlist@ha
	la 30,.LC193@l(9)
	stw 8,item_health_mega@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L692
	mr 31,7
.L687:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L689
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L689
	mr 8,29
	b .L691
.L689:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L687
.L692:
	li 8,0
.L691:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_quad@ha
	lwz 0,1556(7)
	lis 9,.LC198@ha
	lis 11,itemlist@ha
	la 30,.LC198@l(9)
	stw 8,item_quad@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L700
	mr 31,7
.L695:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L697
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L697
	mr 8,29
	b .L699
.L697:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L695
.L700:
	li 8,0
.L699:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_invulnerability@ha
	lwz 0,1556(7)
	lis 9,.LC203@ha
	lis 11,itemlist@ha
	la 30,.LC203@l(9)
	stw 8,item_invulnerability@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L708
	mr 31,7
.L703:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L705
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L705
	mr 8,29
	b .L707
.L705:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L703
.L708:
	li 8,0
.L707:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_silencer@ha
	lwz 0,1556(7)
	lis 9,.LC207@ha
	lis 11,itemlist@ha
	la 30,.LC207@l(9)
	stw 8,item_silencer@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L716
	mr 31,7
.L711:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L713
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L713
	mr 8,29
	b .L715
.L713:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L711
.L716:
	li 8,0
.L715:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_breather@ha
	lwz 0,1556(7)
	lis 9,.LC212@ha
	lis 11,itemlist@ha
	la 30,.LC212@l(9)
	stw 8,item_breather@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L724
	mr 31,7
.L719:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L721
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L721
	mr 8,29
	b .L723
.L721:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L719
.L724:
	li 8,0
.L723:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_enviro@ha
	lwz 0,1556(7)
	lis 9,.LC228@ha
	lis 11,itemlist@ha
	la 30,.LC228@l(9)
	stw 8,item_enviro@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L732
	mr 31,7
.L727:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L729
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L729
	mr 8,29
	b .L731
.L729:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L727
.L732:
	li 8,0
.L731:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_pack@ha
	lwz 0,1556(7)
	lis 9,.LC224@ha
	lis 11,itemlist@ha
	la 30,.LC224@l(9)
	stw 8,item_pack@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L740
	mr 31,7
.L735:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L737
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L737
	mr 8,29
	b .L739
.L737:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L735
.L740:
	li 8,0
.L739:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_bandolier@ha
	lwz 0,1556(7)
	lis 9,.LC216@ha
	lis 11,itemlist@ha
	la 30,.LC216@l(9)
	stw 8,item_bandolier@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L748
	mr 31,7
.L743:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L745
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L745
	mr 8,29
	b .L747
.L745:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L743
.L748:
	li 8,0
.L747:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,item_ancient_head@ha
	lwz 0,1556(7)
	lis 9,.LC232@ha
	lis 11,itemlist@ha
	la 30,.LC232@l(9)
	stw 8,item_ancient_head@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L756
	mr 31,7
.L751:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L753
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L753
	mr 8,29
	b .L755
.L753:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L751
.L756:
	li 8,0
.L755:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,key_data_cd@ha
	lwz 0,1556(7)
	lis 9,.LC235@ha
	lis 11,itemlist@ha
	la 30,.LC235@l(9)
	stw 8,key_data_cd@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L764
	mr 31,7
.L759:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L761
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L761
	mr 8,29
	b .L763
.L761:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L759
.L764:
	li 8,0
.L763:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,key_power_cube@ha
	lwz 0,1556(7)
	lis 9,.LC239@ha
	lis 11,itemlist@ha
	la 30,.LC239@l(9)
	stw 8,key_power_cube@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L772
	mr 31,7
.L767:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L769
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L769
	mr 8,29
	b .L771
.L769:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L767
.L772:
	li 8,0
.L771:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,key_pyramid@ha
	lwz 0,1556(7)
	lis 9,.LC243@ha
	lis 11,itemlist@ha
	la 30,.LC243@l(9)
	stw 8,key_pyramid@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L780
	mr 31,7
.L775:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L777
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L777
	mr 8,29
	b .L779
.L777:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L775
.L780:
	li 8,0
.L779:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,key_data_spinner@ha
	lwz 0,1556(7)
	lis 9,.LC247@ha
	lis 11,itemlist@ha
	la 30,.LC247@l(9)
	stw 8,key_data_spinner@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L788
	mr 31,7
.L783:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L785
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L785
	mr 8,29
	b .L787
.L785:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L783
.L788:
	li 8,0
.L787:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,key_pass@ha
	lwz 0,1556(7)
	lis 9,.LC251@ha
	lis 11,itemlist@ha
	la 30,.LC251@l(9)
	stw 8,key_pass@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L796
	mr 31,7
.L791:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L793
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L793
	mr 8,29
	b .L795
.L793:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L791
.L796:
	li 8,0
.L795:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,key_blue_key@ha
	lwz 0,1556(7)
	lis 9,.LC255@ha
	lis 11,itemlist@ha
	la 30,.LC255@l(9)
	stw 8,key_blue_key@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L804
	mr 31,7
.L799:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L801
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L801
	mr 8,29
	b .L803
.L801:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L799
.L804:
	li 8,0
.L803:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,key_red_key@ha
	lwz 0,1556(7)
	lis 9,.LC259@ha
	lis 11,itemlist@ha
	la 30,.LC259@l(9)
	stw 8,key_red_key@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L812
	mr 31,7
.L807:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L809
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L809
	mr 8,29
	b .L811
.L809:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L807
.L812:
	li 8,0
.L811:
	lis 9,game@ha
	li 28,0
	la 7,game@l(9)
	lis 10,key_commander_head@ha
	lwz 0,1556(7)
	lis 9,.LC263@ha
	lis 11,itemlist@ha
	la 30,.LC263@l(9)
	stw 8,key_commander_head@l(10)
	la 29,itemlist@l(11)
	cmpw 0,28,0
	bc 4,0,.L820
	mr 31,7
.L815:
	lwz 3,40(29)
	cmpwi 0,3,0
	bc 12,2,.L817
	mr 4,30
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L817
	mr 11,29
	b .L819
.L817:
	lwz 0,1556(31)
	addi 28,28,1
	addi 29,29,76
	cmpw 0,28,0
	bc 12,0,.L815
.L820:
	li 11,0
.L819:
	lis 9,key_airstrike_target@ha
	stw 11,key_airstrike_target@l(9)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 SetItemNames,.Lfe17-SetItemNames
	.comm	jacket_armor_index,4,4
	.comm	combat_armor_index,4,4
	.comm	body_armor_index,4,4
	.align 2
	.globl InitItems
	.type	 InitItems,@function
InitItems:
	lis 9,game+1556@ha
	li 0,47
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
	bc 4,0,.L19
	mr 28,9
.L21:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L20
	mr 4,29
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L20
	mr 3,31
	b .L821
.L20:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L21
.L19:
	li 3,0
.L821:
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
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L12
	mr 3,31
	b .L822
.L12:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L13
.L11:
	li 3,0
.L822:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 FindItemByClassname,.Lfe20-FindItemByClassname
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
.Lfe21:
	.size	 SetRespawn,.Lfe21-SetRespawn
	.align 2
	.globl ArmorIndex
	.type	 ArmorIndex,@function
ArmorIndex:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L170
	li 3,0
	blr
.L170:
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
.Lfe22:
	.size	 ArmorIndex,.Lfe22-ArmorIndex
	.align 2
	.globl PowerArmorType
	.type	 PowerArmorType,@function
PowerArmorType:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 4,2,.L199
.L825:
	li 3,0
	blr
.L199:
	lwz 0,264(3)
	andi. 9,0,4096
	bc 12,2,.L825
	lis 9,power_shield_index@ha
	addi 11,11,744
	lwz 0,power_shield_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L201
	lis 9,power_screen_index@ha
	lwz 0,power_screen_index@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	srawi 3,9,31
	subf 3,9,3
	srwi 3,3,31
	blr
.L201:
	li 3,2
	blr
.Lfe23:
	.size	 PowerArmorType,.Lfe23-PowerArmorType
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
.Lfe24:
	.size	 GetItemByIndex,.Lfe24-GetItemByIndex
	.comm	lights,4,4
	.comm	saved_client,780,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_blaster,4,4
	.comm	item_shotgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_supershotgun,4,4
	.comm	item_chaingun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_railgun,4,4
	.comm	item_bfg,4,4
	.comm	item_jacketarmor,4,4
	.comm	item_combatarmor,4,4
	.comm	item_bodyarmor,4,4
	.comm	item_armorshard,4,4
	.comm	item_powerscreen,4,4
	.comm	item_powershield,4,4
	.comm	item_adrenaline,4,4
	.comm	item_health,4,4
	.comm	item_stimpak,4,4
	.comm	item_health_large,4,4
	.comm	item_health_mega,4,4
	.comm	item_quad,4,4
	.comm	item_invulnerability,4,4
	.comm	item_silencer,4,4
	.comm	item_breather,4,4
	.comm	item_enviro,4,4
	.comm	item_pack,4,4
	.comm	item_bandolier,4,4
	.comm	item_ancient_head,4,4
	.comm	key_data_cd,4,4
	.comm	key_power_cube,4,4
	.comm	key_pyramid,4,4
	.comm	key_data_spinner,4,4
	.comm	key_pass,4,4
	.comm	key_blue_key,4,4
	.comm	key_red_key,4,4
	.comm	key_commander_head,4,4
	.comm	key_airstrike_target,4,4
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
.Lfe25:
	.size	 DoRespawn,.Lfe25-DoRespawn
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
	addi 11,11,744
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
.Lfe26:
	.size	 Drop_General,.Lfe26-Drop_General
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
.L58:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe27:
	.size	 Pickup_Adrenaline,.Lfe27-Pickup_Adrenaline
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
	bc 4,2,.L61
	lis 9,.LC297@ha
	lis 11,deathmatch@ha
	la 9,.LC297@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L61
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
.L61:
	li 3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 Pickup_AncientHead,.Lfe28-Pickup_AncientHead
	.section	".rodata"
	.align 2
.LC299:
	.long 0x3f4ccccd
	.align 2
.LC300:
	.long 0x0
	.align 3
.LC301:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC302:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Use_Jet
	.type	 Use_Jet,@function
Use_Jet:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	lis 9,.LC300@ha
	mr 31,3
	la 9,.LC300@l(9)
	lfs 31,0(9)
	bl ValidateSelectedItem
	lwz 9,84(31)
	lfs 0,2264(9)
	fcmpu 0,0,31
	bc 4,2,.L96
	lis 0,0x442f
	stw 0,2264(9)
.L96:
	mr 3,31
	bl Jet_Active
	cmpwi 0,3,0
	bc 12,2,.L97
	lwz 9,84(31)
	stfs 31,2260(9)
	b .L98
.L97:
	lis 11,level@ha
	lwz 8,84(31)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC301@ha
	lfs 12,2264(8)
	xoris 0,0,0x8000
	la 11,.LC301@l(11)
	stw 0,20(1)
	stw 10,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fadds 0,0,12
	stfs 0,2260(8)
.L98:
	lis 29,gi@ha
	lis 3,.LC10@ha
	la 29,gi@l(29)
	la 3,.LC10@l(3)
	lwz 9,36(29)
	lis 28,.LC299@ha
	mtlr 9
	blrl
	lis 9,.LC302@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC302@l(9)
	li 4,3
	lfs 1,.LC299@l(28)
	lfs 2,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC300@ha
	la 9,.LC300@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,36(29)
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC302@ha
	lis 11,.LC300@ha
	mr 5,3
	la 9,.LC302@l(9)
	lfs 1,.LC299@l(28)
	la 11,.LC300@l(11)
	li 4,0
	lfs 2,0(9)
	mtlr 0
	mr 3,31
	lfs 3,0(11)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe29:
	.size	 Use_Jet,.Lfe29-Use_Jet
	.section	".rodata"
	.align 3
.LC303:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC304:
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
	addi 11,11,744
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC303@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC303@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,2156(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L106
	lis 9,.LC304@ha
	la 9,.LC304@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L827
.L106:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L827:
	stfs 0,2156(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe30:
	.size	 Use_Breather,.Lfe30-Use_Breather
	.section	".rodata"
	.align 3
.LC305:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC306:
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
	addi 11,11,744
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lis 9,.LC305@ha
	lis 11,level@ha
	lwz 10,84(29)
	la 9,.LC305@l(9)
	lwz 11,level@l(11)
	lis 8,0x4330
	lfd 12,0(9)
	xoris 0,11,0x8000
	lfs 13,2160(10)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L109
	lis 9,.LC306@ha
	la 9,.LC306@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L828
.L109:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
.L828:
	stfs 0,2160(10)
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
	addi 11,11,744
	rlwinm 4,4,0,0,29
	lwzx 9,11,4
	addi 9,9,-1
	stwx 9,11,4
	bl ValidateSelectedItem
	lwz 11,84(29)
	lwz 9,2172(11)
	addi 9,9,30
	stw 9,2172(11)
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
	addi 10,10,744
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
	addi 9,9,744
	lwzx 0,9,0
	cmpw 0,0,11
	bc 12,0,.L148
	stw 11,532(29)
	b .L149
.L148:
	stw 0,532(29)
.L149:
	lwz 9,84(31)
	slwi 11,28,2
	lwz 8,532(29)
	mr 10,9
	lwz 9,1792(9)
	cmpwi 0,9,0
	bc 12,2,.L150
	lwz 0,68(9)
	cmpwi 0,0,3
	bc 4,2,.L150
	lwz 0,68(30)
	cmpwi 0,0,3
	bc 4,2,.L150
	addi 9,10,744
	lwzx 0,9,11
	subf. 9,8,0
	bc 12,1,.L150
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC23@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,29
	bl G_FreeEdict
	b .L147
.L150:
	addi 9,10,744
	mr 3,31
	lwzx 0,9,11
	subf 0,8,0
	stwx 0,9,11
	bl ValidateSelectedItem
.L147:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 Drop_Ammo,.Lfe34-Drop_Ammo
	.section	".rodata"
	.align 2
.LC307:
	.long 0x3f800000
	.align 2
.LC308:
	.long 0x0
	.align 2
.LC309:
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
	bc 4,1,.L152
	lis 10,.LC307@ha
	lis 9,level+4@ha
	la 10,.LC307@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(7)
	lwz 9,480(11)
	addi 9,9,-1
	stw 9,480(11)
	b .L151
.L152:
	lwz 0,284(7)
	andis. 6,0,0x1
	bc 4,2,.L153
	lis 9,.LC308@ha
	lis 11,deathmatch@ha
	la 9,.LC308@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L153
	lwz 9,264(7)
	lis 11,.LC309@ha
	lis 10,level+4@ha
	lwz 0,184(7)
	la 11,.LC309@l(11)
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
	b .L151
.L153:
	mr 3,7
	bl G_FreeEdict
.L151:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe35:
	.size	 MegaHealth_think,.Lfe35-MegaHealth_think
	.section	".rodata"
	.align 2
.LC310:
	.long 0x3f800000
	.align 2
.LC311:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_PowerArmor
	.type	 Use_PowerArmor,@function
Use_PowerArmor:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 8,264(31)
	andi. 0,8,4096
	bc 12,2,.L204
	rlwinm 0,8,0,20,18
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(31)
	lis 3,.LC30@ha
	lwz 9,36(29)
	la 3,.LC30@l(3)
	mtlr 9
	blrl
	lis 9,.LC310@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC310@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC310@ha
	la 9,.LC310@l(9)
	lfs 2,0(9)
	lis 9,.LC311@ha
	la 9,.LC311@l(9)
	lfs 3,0(9)
	blrl
	b .L203
.L204:
	lis 9,item_cells@ha
	lis 11,itemlist@ha
	lwz 10,84(31)
	lwz 0,item_cells@l(9)
	la 11,itemlist@l(11)
	lis 9,0x286b
	addi 10,10,744
	ori 9,9,51739
	subf 0,11,0
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L206
	lis 9,gi+8@ha
	lis 5,.LC31@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC31@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L203
.L206:
	ori 0,8,4096
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(31)
	lis 3,.LC32@ha
	lwz 9,36(29)
	la 3,.LC32@l(3)
	mtlr 9
	blrl
	lis 9,.LC310@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC310@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC310@ha
	la 9,.LC310@l(9)
	lfs 2,0(9)
	lis 9,.LC311@ha
	la 9,.LC311@l(9)
	lfs 3,0(9)
	blrl
.L203:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 Use_PowerArmor,.Lfe36-Use_PowerArmor
	.align 2
	.type	 drop_temp_touch,@function
drop_temp_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,256(3)
	cmpw 0,4,0
	bc 12,2,.L240
	bl Touch_Item
.L240:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 drop_temp_touch,.Lfe37-drop_temp_touch
	.section	".rodata"
	.align 2
.LC312:
	.long 0x0
	.align 2
.LC313:
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
	lis 9,.LC312@ha
	lfs 0,20(10)
	la 9,.LC312@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bclr 12,2
	lis 9,.LC313@ha
	lis 11,level+4@ha
	la 9,.LC313@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,436(3)
	stfs 0,428(3)
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
	bc 12,2,.L249
	li 0,2
	stw 11,444(3)
	stw 0,248(3)
	b .L250
.L249:
	lis 9,Touch_Item@ha
	li 0,1
	la 9,Touch_Item@l(9)
	stw 0,248(3)
	stw 9,444(3)
.L250:
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
.LC314:
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
	lis 11,.LC314@ha
	lis 9,deathmatch@ha
	la 11,.LC314@l(11)
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
.L829:
	mr 4,31
	b .L422
.L415:
	lis 9,.LC275@ha
	li 0,10
	la 9,.LC275@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC265@ha
	lis 11,itemlist@ha
	la 27,.LC265@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L423
	mr 28,10
.L418:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L420
	mr 4,27
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L829
.L420:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L418
.L423:
	li 4,0
.L422:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC38@ha
	lwz 0,gi+36@l(9)
	la 3,.LC38@l(3)
	mtlr 0
	blrl
.L414:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe40:
	.size	 SP_item_health,.Lfe40-SP_item_health
	.section	".rodata"
	.align 2
.LC315:
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
	lis 11,.LC315@ha
	lis 9,deathmatch@ha
	la 11,.LC315@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L425
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L425
	bl G_FreeEdict
	b .L424
.L830:
	mr 4,31
	b .L432
.L425:
	lis 9,.LC276@ha
	li 0,2
	la 9,.LC276@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC265@ha
	lis 11,itemlist@ha
	la 27,.LC265@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L433
	mr 28,10
.L428:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L430
	mr 4,27
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L830
.L430:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L428
.L433:
	li 4,0
.L432:
	mr 3,29
	bl SpawnItem
	li 0,1
	lis 9,gi+36@ha
	stw 0,644(29)
	lis 3,.LC37@ha
	lwz 0,gi+36@l(9)
	la 3,.LC37@l(3)
	mtlr 0
	blrl
.L424:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe41:
	.size	 SP_item_health_small,.Lfe41-SP_item_health_small
	.section	".rodata"
	.align 2
.LC316:
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
	lis 11,.LC316@ha
	lis 9,deathmatch@ha
	la 11,.LC316@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L435
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L435
	bl G_FreeEdict
	b .L434
.L831:
	mr 4,31
	b .L442
.L435:
	lis 9,.LC277@ha
	li 0,25
	la 9,.LC277@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC265@ha
	lis 11,itemlist@ha
	la 27,.LC265@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L443
	mr 28,10
.L438:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L440
	mr 4,27
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L831
.L440:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L438
.L443:
	li 4,0
.L442:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC39@ha
	lwz 0,gi+36@l(9)
	la 3,.LC39@l(3)
	mtlr 0
	blrl
.L434:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe42:
	.size	 SP_item_health_large,.Lfe42-SP_item_health_large
	.section	".rodata"
	.align 2
.LC317:
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
	lis 11,.LC317@ha
	lis 9,deathmatch@ha
	la 11,.LC317@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L445
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L445
	bl G_FreeEdict
	b .L444
.L832:
	mr 4,31
	b .L452
.L445:
	lis 9,.LC278@ha
	li 0,100
	la 9,.LC278@l(9)
	lis 11,game@ha
	stw 0,532(29)
	la 10,game@l(11)
	stw 9,268(29)
	li 30,0
	lwz 0,1556(10)
	lis 9,.LC265@ha
	lis 11,itemlist@ha
	la 27,.LC265@l(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L453
	mr 28,10
.L448:
	lwz 3,40(31)
	cmpwi 0,3,0
	bc 12,2,.L450
	mr 4,27
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L832
.L450:
	lwz 0,1556(28)
	addi 30,30,1
	addi 31,31,76
	cmpw 0,30,0
	bc 12,0,.L448
.L453:
	li 4,0
.L452:
	mr 3,29
	bl SpawnItem
	lis 9,gi+36@ha
	lis 3,.LC40@ha
	lwz 0,gi+36@l(9)
	la 3,.LC40@l(3)
	mtlr 0
	blrl
	li 0,3
	stw 0,644(29)
.L444:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe43:
	.size	 SP_item_health_mega,.Lfe43-SP_item_health_mega
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
