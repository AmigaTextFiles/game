	.file	"kotsscore.cpp"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"***************%s GAINED A LEVEL!!!!***************\n"
	.align 3
.LC1:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC2:
	.long 0x401e0000
	.long 0x0
	.align 2
.LC3:
	.long 0x3f800000
	.section	".text"
	.align 2
	.type	 PtsForKill__FP7edict_sT0RlP5CUserT3,@function
PtsForKill__FP7edict_sT0RlP5CUserT3:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lwz 11,84(4)
	li 28,0
	mr 26,5
	mr 31,6
	mr 30,7
	stw 28,3940(11)
	lwz 9,84(4)
	lwz 27,3952(11)
	stw 28,3944(9)
	lwz 11,84(4)
	lwz 9,84(3)
	lwz 0,3948(11)
	cmpw 0,0,9
	bc 12,2,.L24
	stw 28,0(26)
	b .L23
.L24:
	lwz 9,728(11)
	li 4,0
	mr 3,30
	cmpw 7,27,9
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,27,0
	or 27,0,9
	bl Level__5CUserPl
	mr 29,3
	li 4,0
	mr 3,31
	bl Level__5CUserPl
	cmpw 0,29,3
	bc 12,0,.L26
	li 4,0
	mr 3,30
	bl Level__5CUserPl
	mr 29,3
	li 4,0
	mr 3,31
	bl Level__5CUserPl
	subf 29,3,29
	li 4,0
	mr 3,30
	addi 31,29,1
	bl Level__5CUserPl
	xoris 29,29,0x8000
	stw 29,20(1)
	lis 0,0x4330
	lis 10,.LC1@ha
	stw 0,16(1)
	la 10,.LC1@l(10)
	lis 11,.LC2@ha
	lfd 0,0(10)
	la 11,.LC2@l(11)
	addi 0,3,-1
	lfd 13,16(1)
	or 0,0,3
	lfd 12,0(11)
	add 9,31,31
	srawi 0,0,31
	andc 28,9,0
	fsub 13,13,0
	frsp 13,13
	fmr 0,13
	fsub 12,12,0
	frsp 11,12
	b .L28
.L26:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	mr 29,3
	li 4,0
	mr 3,30
	bl Level__5CUserPl
	subf 31,3,29
	xoris 0,31,0x8000
	lis 11,0x4330
	stw 0,20(1)
	lis 10,.LC1@ha
	la 10,.LC1@l(10)
	stw 11,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC2@ha
	la 10,.LC2@l(10)
	lfd 12,0(10)
	fsub 0,0,13
	frsp 0,0
	fmr 13,0
	fadd 13,13,12
	frsp 11,13
.L28:
	lis 11,.LC3@ha
	la 11,.LC3@l(11)
	lfs 0,0(11)
	fcmpu 0,11,0
	bc 4,0,.L29
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 11,0(9)
.L29:
	xoris 11,27,0x8000
	stw 11,20(1)
	lis 0,0x4330
	lis 10,.LC1@ha
	stw 0,16(1)
	la 10,.LC1@l(10)
	cmpwi 7,28,51
	lfd 13,16(1)
	mr 11,9
	mr 3,30
	lfd 0,0(10)
	li 5,2
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	fsub 13,13,0
	nor 9,0,0
	andi. 9,9,50
	and 0,28,0
	or 28,0,9
	frsp 13,13
	neg 4,28
	fdivs 13,13,11
	fmr 0,13
	fctiwz 12,0
	stfd 12,16(1)
	lwz 11,20(1)
	stw 11,0(26)
	bl ModScore__5CUserli
	cmpwi 0,3,0
	bc 12,2,.L31
	lwz 11,4(30)
	lis 9,gi@ha
	lis 4,.LC0@ha
	lwz 0,gi@l(9)
	la 4,.LC0@l(4)
	li 3,1
	lwz 5,84(11)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	mr 3,30
	li 4,1
	bl KOTSHelp__FP5CUseri
	b .L32
.L31:
	mr 3,30
	li 4,0
	bl KOTSHelp__FP5CUseri
.L32:
	mr 3,30
	bl KOTSPlayerDie__FP5CUser
.L23:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 PtsForKill__FP7edict_sT0RlP5CUserT3,.Lfe1-PtsForKill__FP7edict_sT0RlP5CUserT3
	.section	".rodata"
	.align 2
.LC4:
	.string	"%s is on a %d frag spree!\n"
	.align 2
.LC5:
	.string	"%s is on a rampage: %d frag spree!\n"
	.align 2
.LC6:
	.string	"%s is god-like: %d frag spree!\n"
	.align 2
.LC7:
	.string	"Damage Amp"
	.align 2
.LC8:
	.string	"kots_damage_item"
	.align 2
.LC9:
	.string	"boomerang"
	.align 2
.LC10:
	.string	"kots_boomerang"
	.align 2
.LC11:
	.string	"resist"
	.align 2
.LC12:
	.string	"kots_resist_item"
	.align 2
.LC13:
	.string	"SPREE WAR %s: %d frag spree!\n"
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC15:
	.long 0x40040000
	.long 0x0
	.section	".text"
	.align 2
	.type	 OnASpree__FP7edict_sP5CUserRl,@function
OnASpree__FP7edict_sP5CUserRl:
	stwu 1,-176(1)
	mflr 0
	stmw 25,148(1)
	stw 0,180(1)
	mr 31,3
	mr 28,4
	lwz 10,84(31)
	mr 25,5
	lwz 9,1860(10)
	addi 9,9,1
	stw 9,1860(10)
	lwz 11,84(31)
	lwz 0,669(28)
	lwz 9,1860(11)
	cmpw 0,0,9
	bc 4,0,.L36
	stw 9,669(28)
.L36:
	lwz 9,84(31)
	lwz 0,1860(9)
	cmpwi 0,0,5
	bc 12,1,.L37
	li 0,0
	stw 0,1864(9)
	b .L35
.L37:
	cmpwi 0,0,6
	bc 4,2,.L38
	lwz 9,673(28)
	addi 9,9,1
	stw 9,673(28)
.L38:
	lwz 29,84(31)
	lwz 6,1860(29)
	cmpwi 0,6,9
	bc 12,1,.L39
	lis 9,gi@ha
	lis 4,.LC4@ha
	lwz 0,gi@l(9)
	la 4,.LC4@l(4)
	addi 5,29,700
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,0(25)
	lwz 9,84(31)
	add 0,0,0
	stw 0,1864(9)
	b .L40
.L39:
	cmpwi 0,6,14
	bc 12,1,.L41
	lis 9,gi@ha
	lis 4,.LC5@ha
	lwz 0,gi@l(9)
	la 4,.LC5@l(4)
	addi 5,29,700
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,0(25)
	lis 10,0x4330
	lis 9,.LC14@ha
	lwz 8,84(31)
	xoris 0,0,0x8000
	la 9,.LC14@l(9)
	stw 0,140(1)
	stw 10,136(1)
	lfd 12,0(9)
	lfd 0,136(1)
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfd 11,0(9)
	fsub 0,0,12
	mr 9,11
	fmul 0,0,11
	fctiwz 13,0
	stfd 13,136(1)
	lwz 9,140(1)
	stw 9,1864(8)
	b .L40
.L41:
	cmpwi 0,6,24
	bc 12,1,.L43
	lis 9,gi@ha
	lis 4,.LC6@ha
	lwz 0,gi@l(9)
	la 4,.LC6@l(4)
	addi 5,29,700
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,0(25)
	lwz 11,84(31)
	slwi 0,9,1
	b .L50
.L43:
	cmpwi 0,6,25
	bc 4,2,.L45
	lis 26,.LC7@ha
	lis 30,0x286b
	la 3,.LC7@l(26)
	ori 30,30,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 11,29,740
	la 27,itemlist@l(9)
	subf 3,27,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,11,3
	cmpwi 0,0,0
	bc 12,2,.L46
	lis 3,.LC8@ha
	la 3,.LC8@l(3)
	bl FindItemByClassname
	mr 4,3
	mr 3,31
	bl Drop_Item
	la 3,.LC7@l(26)
	bl FindItem
	subf 3,27,3
	lwz 11,84(31)
	mullw 3,3,30
	addi 11,11,740
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,-1
	stwx 9,11,3
.L46:
	lis 26,.LC9@ha
	lwz 29,84(31)
	la 3,.LC9@l(26)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L47
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
	bl FindItemByClassname
	mr 4,3
	mr 3,31
	bl Drop_Item
	la 3,.LC9@l(26)
	bl FindItem
	subf 3,27,3
	lwz 11,84(31)
	mullw 3,3,30
	addi 11,11,740
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,-1
	stwx 9,11,3
.L47:
	lis 26,.LC11@ha
	lwz 29,84(31)
	la 3,.LC11@l(26)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L48
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	bl FindItemByClassname
	mr 4,3
	mr 3,31
	bl Drop_Item
	la 3,.LC11@l(26)
	bl FindItem
	subf 3,27,3
	lwz 11,84(31)
	mullw 3,3,30
	addi 11,11,740
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,-1
	stwx 9,11,3
.L48:
	lwz 9,677(28)
	lis 4,.LC13@ha
	addi 3,1,8
	la 4,.LC13@l(4)
	addi 9,9,1
	stw 9,677(28)
	lwz 5,84(31)
	lwz 6,1860(5)
	addi 5,5,700
	crxor 6,6,6
	bl sprintf
	li 3,0
	addi 4,1,8
	bl KOTSSendAll__FbPc
	b .L51
.L45:
	lis 9,gi@ha
	lis 4,.LC13@ha
	lwz 0,gi@l(9)
	la 4,.LC13@l(4)
	addi 5,29,700
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
.L51:
	lwz 9,0(25)
	lwz 11,84(31)
	slwi 0,9,2
.L50:
	add 0,0,9
	stw 0,1864(11)
.L40:
	lwz 9,84(31)
	lwz 0,1864(9)
	stw 0,0(25)
.L35:
	lwz 0,180(1)
	mtlr 0
	lmw 25,148(1)
	la 1,176(1)
	blr
.Lfe2:
	.size	 OnASpree__FP7edict_sP5CUserRl,.Lfe2-OnASpree__FP7edict_sP5CUserRl
	.section	".rodata"
	.align 2
.LC16:
	.string	"%s's SPREE WAR BROKEN by %s: %d frag spree!\n"
	.align 2
.LC17:
	.string	"%s broke %s's %d frag spree!\n"
	.align 2
.LC18:
	.string	"%s got a 2fer!\n"
	.section	".text"
	.align 2
	.type	 TeamplayScoring__FP7edict_sl,@function
TeamplayScoring__FP7edict_sl:
	stwu 1,-48(1)
	mflr 0
	stmw 23,12(1)
	stw 0,52(1)
	lis 9,game@ha
	lis 0,0x6666
	la 11,game@l(9)
	ori 0,0,26215
	lwz 9,1544(11)
	mulhw 0,4,0
	li 30,0
	mr 29,3
	srawi 4,4,31
	cmpw 0,30,9
	srawi 0,0,1
	subf 27,4,0
	bc 4,0,.L61
	mr 23,11
	lis 24,g_edicts@ha
	lis 25,gi@ha
	lis 26,.LC0@ha
	li 28,976
.L63:
	lwz 0,g_edicts@l(24)
	add 3,0,28
	lwz 9,480(3)
	cmpwi 0,9,0
	bc 4,1,.L62
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L62
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 12,2,.L62
	cmpw 0,3,29
	bc 12,2,.L62
	lwz 0,3580(11)
	cmpwi 0,0,0
	bc 12,2,.L62
	lwz 9,84(29)
	lwz 11,3584(11)
	lwz 0,3584(9)
	cmpw 0,11,0
	bc 4,2,.L62
	bl KOTSGetUser__FP7edict_s
	mr. 31,3
	bc 12,2,.L62
	mr 3,31
	mr 4,27
	li 5,0
	bl ModScore__5CUserli
	cmpwi 0,3,0
	bc 12,2,.L71
	lwz 9,4(31)
	li 3,1
	la 4,.LC0@l(26)
	lwz 11,gi@l(25)
	lwz 5,84(9)
	mtlr 11
	addi 5,5,700
	crxor 6,6,6
	blrl
	mr 3,31
	li 4,1
	bl KOTSHelp__FP5CUseri
	b .L62
.L71:
	mr 3,31
	li 4,0
	bl KOTSHelp__FP5CUseri
.L62:
	lwz 0,1544(23)
	addi 30,30,1
	addi 28,28,976
	cmpw 0,30,0
	bc 12,0,.L63
.L61:
	lwz 0,52(1)
	mtlr 0
	lmw 23,12(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 TeamplayScoring__FP7edict_sl,.Lfe3-TeamplayScoring__FP7edict_sl
	.section	".rodata"
	.align 2
.LC19:
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSScoring
	.type	 KOTSScoring,@function
KOTSScoring:
	stwu 1,-160(1)
	mflr 0
	stmw 27,140(1)
	stw 0,164(1)
	mr 30,3
	mr 31,4
	mr 29,5
	bl KOTSGetUser__FP7edict_s
	mr. 27,3
	bc 12,2,.L108
	lis 9,.LC19@ha
	lis 11,kots_lives@ha
	la 9,.LC19@l(9)
	lfs 13,0(9)
	lwz 9,kots_lives@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L78
	lwz 9,928(30)
	addi 9,9,-1
	stw 9,928(30)
.L78:
	lwz 9,900(30)
	cmpwi 0,29,0
	addi 9,9,1
	stw 9,900(30)
	bc 12,2,.L80
	cmpwi 0,29,1
	bc 12,2,.L85
	b .L79
.L80:
	li 4,0
	mr 3,27
	bl Level__5CUserPl
	slwi 4,3,1
	li 5,3
	add 4,4,3
	neg 4,4
	mr 3,27
	bl ModScore__5CUserli
	cmpwi 0,3,0
	bc 12,2,.L81
	lwz 11,4(27)
	lis 9,gi@ha
	lis 4,.LC0@ha
	lwz 0,gi@l(9)
	la 4,.LC0@l(4)
	li 3,1
	lwz 5,84(11)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	mr 3,27
	li 4,1
	bl KOTSHelp__FP5CUseri
	b .L82
.L81:
	mr 3,27
	li 4,0
	bl KOTSHelp__FP5CUseri
.L82:
	mr 3,27
	bl KOTSPlayerDie__FP5CUser
	b .L79
.L85:
	mr 3,31
	bl KOTSGetUser__FP7edict_s
	mr. 28,3
	bc 4,2,.L86
.L108:
	li 3,1
	b .L107
.L86:
	lwz 11,900(31)
	addi 29,1,120
	mr 3,31
	lwz 9,920(31)
	mr 4,30
	mr 5,29
	addi 11,11,1
	mr 6,28
	addi 9,9,1
	stw 11,900(31)
	mr 7,27
	stw 9,920(31)
	bl PtsForKill__FP7edict_sT0RlP5CUserT3
	mr 5,29
	mr 3,31
	mr 4,28
	bl OnASpree__FP7edict_sP5CUserRl
	lwz 9,84(30)
	lwz 0,1860(9)
	cmpwi 0,0,5
	bc 4,1,.L88
	cmpwi 0,0,24
	bc 4,1,.L89
	lwz 9,685(28)
	lis 4,.LC16@ha
	addi 3,1,8
	la 4,.LC16@l(4)
	addi 9,9,1
	stw 9,685(28)
	lwz 5,84(30)
	lwz 6,84(31)
	lwz 7,1860(5)
	addi 5,5,700
	addi 6,6,700
	crxor 6,6,6
	bl sprintf
	li 3,0
	addi 4,1,8
	bl KOTSSendAll__FbPc
	li 0,150
	b .L109
.L89:
	lwz 9,681(28)
	lis 10,gi@ha
	lis 4,.LC17@ha
	la 4,.LC17@l(4)
	li 3,1
	addi 9,9,1
	stw 9,681(28)
	lwz 11,84(30)
	lwz 0,gi@l(10)
	lwz 5,84(31)
	addi 6,11,700
	mtlr 0
	lwz 7,1860(11)
	addi 5,5,700
	crxor 6,6,6
	blrl
	lwz 9,120(1)
	slwi 0,9,2
	add 0,0,9
.L109:
	stw 0,120(1)
.L88:
	lwz 5,84(31)
	lwz 10,1824(5)
	cmpwi 0,10,0
	bc 4,1,.L91
	lis 9,level@ha
	addi 0,10,5
	lwz 11,level@l(9)
	cmpw 0,0,11
	bc 12,0,.L91
	lis 9,gi@ha
	lis 4,.LC18@ha
	lwz 0,gi@l(9)
	la 4,.LC18@l(4)
	addi 5,5,700
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,120(1)
	addi 9,9,10
	stw 9,120(1)
	lwz 11,689(28)
	addi 11,11,1
	stw 11,689(28)
.L91:
	lis 9,level@ha
	lwz 10,84(31)
	lis 11,kots_teamplay@ha
	lwz 0,level@l(9)
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfs 13,0(9)
	lwz 9,kots_teamplay@l(11)
	stw 0,1824(10)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L94
	lwz 4,120(1)
	mr 3,31
	bl TeamplayScoring__FP7edict_sl
.L94:
	lwz 11,84(31)
	lwz 0,3940(11)
	cmpw 0,0,30
	bc 4,2,.L95
	lwz 9,3944(11)
	addi 9,9,1
	stw 9,3944(11)
	b .L96
.L95:
	stw 30,3940(11)
	li 0,1
	lwz 9,84(31)
	stw 0,3944(9)
.L96:
	lwz 9,84(31)
	lwz 0,3944(9)
	cmpwi 0,0,4
	bc 4,1,.L97
	li 0,0
	stw 0,120(1)
.L97:
	lwz 0,120(1)
	cmpwi 0,0,150
	bc 4,1,.L98
	li 0,150
	stw 0,120(1)
.L98:
	lbz 0,244(27)
	cmpwi 0,0,0
	bc 12,2,.L99
	li 0,200
	stw 0,120(1)
.L99:
	lwz 4,120(1)
	mr 3,28
	li 5,1
	bl ModScore__5CUserli
	cmpwi 0,3,0
	bc 12,2,.L100
	lwz 11,4(28)
	lis 9,gi@ha
	lis 4,.LC0@ha
	lwz 0,gi@l(9)
	la 4,.LC0@l(4)
	li 3,1
	lwz 5,84(11)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	mr 3,28
	li 4,1
	bl KOTSHelp__FP5CUseri
	b .L79
.L100:
	mr 3,28
	li 4,0
	bl KOTSHelp__FP5CUseri
.L79:
	lwz 11,84(30)
	li 0,0
	li 3,1
	stw 0,1860(11)
	lwz 9,84(30)
	stw 0,1864(9)
	lwz 11,84(30)
	stw 0,3948(11)
	lwz 9,84(30)
	stw 0,3952(9)
.L107:
	lwz 0,164(1)
	mtlr 0
	lmw 27,140(1)
	la 1,160(1)
	blr
.Lfe4:
	.size	 KOTSScoring,.Lfe4-KOTSScoring
	.align 2
	.globl KOTSSaveDamage
	.type	 KOTSSaveDamage,@function
KOTSSaveDamage:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 30,3
	mr 29,4
	mr 28,5
	mr 27,6
	bl KOTSGetUser__FP7edict_s
	subfic 0,29,0
	adde 9,0,29
	mr 31,3
	subfic 11,30,0
	adde 0,11,30
	or. 11,9,0
	bc 4,2,.L7
	cmpwi 0,31,0
	bc 12,2,.L7
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L7
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L7
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,6
	bc 12,1,.L12
	cmpwi 0,27,0
	bc 4,2,.L7
.L12:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,6
	bc 4,1,.L13
	cmpwi 0,27,0
	bc 12,2,.L7
.L13:
	lwz 9,84(29)
	lwz 11,84(30)
	lwz 0,3948(9)
	cmpw 0,0,11
	bc 4,2,.L14
	lwz 0,3952(9)
	add 0,0,28
	stw 0,3952(9)
	b .L15
.L14:
	stw 11,3948(9)
	lwz 9,84(29)
	stw 28,3952(9)
.L15:
	mr 3,30
	mr 4,29
	mr 5,28
	bl KOTSKnock
.L7:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 KOTSSaveDamage,.Lfe5-KOTSSaveDamage
	.section	".rodata"
	.align 3
.LC20:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl KOTSPowerDamage
	.type	 KOTSPowerDamage,@function
KOTSPowerDamage:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 0,36(1)
	fmr 31,1
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L18
	bl GetAmmoMulti__5CUser
	xoris 3,3,0x8000
	stw 3,20(1)
	lis 0,0x4330
	lis 11,.LC20@ha
	la 11,.LC20@l(11)
	stw 0,16(1)
	lfd 0,0(11)
	lfd 1,16(1)
	fsub 1,1,0
	frsp 1,1
	fdivs 1,31,1
	b .L110
.L18:
	fmr 1,31
.L110:
	lwz 0,36(1)
	mtlr 0
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 KOTSPowerDamage,.Lfe6-KOTSPowerDamage
	.align 2
	.globl KOTSChangeScore__FP5CUserii
	.type	 KOTSChangeScore__FP5CUserii,@function
KOTSChangeScore__FP5CUserii:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,5
	bl ModScore__5CUserli
	cmpwi 0,3,0
	bc 12,2,.L20
	lwz 11,4(31)
	lis 9,gi@ha
	lis 4,.LC0@ha
	lwz 0,gi@l(9)
	la 4,.LC0@l(4)
	li 3,1
	lwz 5,84(11)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	mr 3,31
	li 4,1
	bl KOTSHelp__FP5CUseri
	b .L21
.L20:
	mr 3,31
	li 4,0
	bl KOTSHelp__FP5CUseri
.L21:
	addi 0,30,-2
	cmplwi 0,0,1
	bc 12,1,.L22
	mr 3,31
	bl KOTSPlayerDie__FP5CUser
.L22:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 KOTSChangeScore__FP5CUserii,.Lfe7-KOTSChangeScore__FP5CUserii
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
