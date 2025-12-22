	.file	"acebot_items.c"
gcc2_compiled.:
	.globl num_players
	.section	".sdata","aw"
	.align 2
	.type	 num_players,@object
	.size	 num_players,4
num_players:
	.long 0
	.globl num_items
	.align 2
	.type	 num_items,@object
	.size	 num_items,4
num_items:
	.long 0
	.section	".text"
	.align 2
	.globl ACEIT_ChangeMK23SpecialWeapon
	.type	 ACEIT_ChangeMK23SpecialWeapon,@function
ACEIT_ChangeMK23SpecialWeapon:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	mr 29,4
	la 28,itemlist@l(9)
	lis 31,0x38e3
	subf 0,28,29
	ori 31,31,36409
	mr 30,3
	mullw 0,0,31
	li 8,1
	lwz 9,84(30)
	srawi 0,0,3
	slwi 0,0,2
	addi 9,9,740
	lwzx 11,9,0
	cmpwi 0,11,0
	li 3,0
	bc 12,2,.L48
	lwz 3,52(29)
	cmpwi 0,3,0
	bc 12,2,.L39
	bl FindItem
	subf 3,28,3
	lwz 9,84(30)
	mullw 3,3,31
	addi 9,9,740
	srawi 3,3,3
	slwi 3,3,2
	lwzx 11,9,3
	srawi 0,11,31
	subf 0,11,0
	srwi 8,0,31
.L39:
	lwz 10,84(30)
	lwz 0,1788(10)
	cmpw 0,29,0
	bc 4,2,.L42
	lwz 0,3992(10)
	xori 11,8,1
	xori 0,0,4
	addic 10,0,-1
	subfe 9,10,0
	cmpwi 7,9,0
	mfcr 0
	rlwinm 0,0,31,1
	and. 9,0,11
	bc 4,2,.L47
	bc 4,30,.L49
	mr 3,30
	bl Cmd_New_Reload_f
	b .L49
.L42:
	lwz 9,4224(10)
	xori 11,8,1
	addi 0,9,-1
	or 9,9,0
	srwi 9,9,31
	and. 0,9,11
	bc 4,2,.L47
	mr 3,30
	stw 29,3956(10)
	bl ChangeWeapon
.L49:
	li 3,1
	b .L48
.L47:
	li 3,0
.L48:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 ACEIT_ChangeMK23SpecialWeapon,.Lfe1-ACEIT_ChangeMK23SpecialWeapon
	.align 2
	.globl ACEIT_ChangeHCSpecialWeapon
	.type	 ACEIT_ChangeHCSpecialWeapon,@function
ACEIT_ChangeHCSpecialWeapon:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	mr 29,4
	la 28,itemlist@l(9)
	lis 31,0x38e3
	subf 0,28,29
	ori 31,31,36409
	mr 30,3
	mullw 0,0,31
	li 10,1
	lwz 9,84(30)
	srawi 0,0,3
	slwi 0,0,2
	addi 9,9,740
	lwzx 11,9,0
	cmpwi 0,11,0
	li 3,0
	bc 12,2,.L61
	lwz 3,52(29)
	cmpwi 0,3,0
	bc 12,2,.L52
	bl FindItem
	subf 3,28,3
	lwz 9,84(30)
	mullw 3,3,31
	addi 9,9,740
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,9,3
	cmpwi 7,0,1
	mfcr 10
	rlwinm 10,10,30,1
.L52:
	lwz 11,84(30)
	lwz 0,4272(11)
	lwz 9,1788(11)
	cmpwi 7,0,1
	cmpw 0,29,9
	mfcr 0
	rlwinm 0,0,30,1
	bc 4,2,.L56
	cmpwi 7,0,0
	xori 9,10,1
	mfcr 0
	rlwinm 0,0,31,1
	and. 10,0,9
	bc 12,2,.L57
	mr 3,30
	bl DropSpecialWeapon
	b .L60
.L57:
	bc 4,30,.L62
	mr 3,30
	bl Cmd_New_Reload_f
	b .L62
.L56:
	xori 9,0,1
	xori 0,10,1
	and. 10,9,0
	bc 4,2,.L60
	mr 3,30
	stw 29,3956(11)
	bl ChangeWeapon
.L62:
	li 3,1
	b .L61
.L60:
	li 3,0
.L61:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 ACEIT_ChangeHCSpecialWeapon,.Lfe2-ACEIT_ChangeHCSpecialWeapon
	.align 2
	.globl ACEIT_ChangeSniperSpecialWeapon
	.type	 ACEIT_ChangeSniperSpecialWeapon,@function
ACEIT_ChangeSniperSpecialWeapon:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	mr 29,4
	la 28,itemlist@l(9)
	lis 31,0x38e3
	subf 0,28,29
	ori 31,31,36409
	mr 30,3
	mullw 0,0,31
	li 8,1
	lwz 9,84(30)
	srawi 0,0,3
	slwi 0,0,2
	addi 9,9,740
	lwzx 11,9,0
	cmpwi 0,11,0
	li 3,0
	bc 12,2,.L74
	lwz 3,52(29)
	cmpwi 0,3,0
	bc 12,2,.L65
	bl FindItem
	subf 3,28,3
	lwz 9,84(30)
	mullw 3,3,31
	addi 9,9,740
	srawi 3,3,3
	slwi 3,3,2
	lwzx 11,9,3
	srawi 0,11,31
	subf 0,11,0
	srwi 8,0,31
.L65:
	lwz 10,84(30)
	lwz 11,4248(10)
	lwz 9,1788(10)
	srawi 0,11,31
	cmpw 0,29,9
	subf 0,11,0
	srwi 0,0,31
	bc 4,2,.L69
	cmpwi 7,0,0
	xori 9,8,1
	mfcr 0
	rlwinm 0,0,31,1
	and. 11,0,9
	bc 12,2,.L70
	mr 3,30
	bl DropSpecialWeapon
	b .L73
.L70:
	bc 4,30,.L75
	mr 3,30
	bl Cmd_New_Reload_f
	b .L75
.L69:
	xori 9,0,1
	xori 0,8,1
	and. 11,9,0
	bc 4,2,.L73
	mr 3,30
	stw 29,3956(10)
	bl ChangeWeapon
.L75:
	li 3,1
	b .L74
.L73:
	li 3,0
.L74:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 ACEIT_ChangeSniperSpecialWeapon,.Lfe3-ACEIT_ChangeSniperSpecialWeapon
	.align 2
	.globl ACEIT_ChangeM3SpecialWeapon
	.type	 ACEIT_ChangeM3SpecialWeapon,@function
ACEIT_ChangeM3SpecialWeapon:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	mr 29,4
	la 28,itemlist@l(9)
	lis 31,0x38e3
	subf 0,28,29
	ori 31,31,36409
	mr 30,3
	mullw 0,0,31
	li 8,1
	lwz 9,84(30)
	srawi 0,0,3
	slwi 0,0,2
	addi 9,9,740
	lwzx 11,9,0
	cmpwi 0,11,0
	li 3,0
	bc 12,2,.L87
	lwz 3,52(29)
	cmpwi 0,3,0
	bc 12,2,.L78
	bl FindItem
	subf 3,28,3
	lwz 9,84(30)
	mullw 3,3,31
	addi 9,9,740
	srawi 3,3,3
	slwi 3,3,2
	lwzx 11,9,3
	srawi 0,11,31
	subf 0,11,0
	srwi 8,0,31
.L78:
	lwz 10,84(30)
	lwz 11,4240(10)
	lwz 9,1788(10)
	srawi 0,11,31
	cmpw 0,29,9
	subf 0,11,0
	srwi 0,0,31
	bc 4,2,.L82
	cmpwi 7,0,0
	xori 9,8,1
	mfcr 0
	rlwinm 0,0,31,1
	and. 11,0,9
	bc 12,2,.L83
	mr 3,30
	bl DropSpecialWeapon
	b .L86
.L83:
	bc 4,30,.L88
	mr 3,30
	bl Cmd_New_Reload_f
	b .L88
.L82:
	xori 9,0,1
	xori 0,8,1
	and. 11,9,0
	bc 4,2,.L86
	mr 3,30
	stw 29,3956(10)
	bl ChangeWeapon
.L88:
	li 3,1
	b .L87
.L86:
	li 3,0
.L87:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 ACEIT_ChangeM3SpecialWeapon,.Lfe4-ACEIT_ChangeM3SpecialWeapon
	.align 2
	.globl ACEIT_ChangeM4SpecialWeapon
	.type	 ACEIT_ChangeM4SpecialWeapon,@function
ACEIT_ChangeM4SpecialWeapon:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	mr 29,4
	la 28,itemlist@l(9)
	lis 31,0x38e3
	subf 0,28,29
	ori 31,31,36409
	mr 30,3
	mullw 0,0,31
	li 8,1
	lwz 9,84(30)
	srawi 0,0,3
	slwi 0,0,2
	addi 9,9,740
	lwzx 11,9,0
	cmpwi 0,11,0
	li 3,0
	bc 12,2,.L100
	lwz 3,52(29)
	cmpwi 0,3,0
	bc 12,2,.L91
	bl FindItem
	subf 3,28,3
	lwz 9,84(30)
	mullw 3,3,31
	addi 9,9,740
	srawi 3,3,3
	slwi 3,3,2
	lwzx 11,9,3
	srawi 0,11,31
	subf 0,11,0
	srwi 8,0,31
.L91:
	lwz 10,84(30)
	lwz 11,4264(10)
	lwz 9,1788(10)
	srawi 0,11,31
	cmpw 0,29,9
	subf 0,11,0
	srwi 0,0,31
	bc 4,2,.L95
	cmpwi 7,0,0
	xori 9,8,1
	mfcr 0
	rlwinm 0,0,31,1
	and. 11,0,9
	bc 12,2,.L96
	mr 3,30
	bl DropSpecialWeapon
	b .L99
.L96:
	bc 4,30,.L101
	mr 3,30
	bl Cmd_New_Reload_f
	b .L101
.L95:
	xori 9,0,1
	xori 0,8,1
	and. 11,9,0
	bc 4,2,.L99
	mr 3,30
	stw 29,3956(10)
	bl ChangeWeapon
.L101:
	li 3,1
	b .L100
.L99:
	li 3,0
.L100:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 ACEIT_ChangeM4SpecialWeapon,.Lfe5-ACEIT_ChangeM4SpecialWeapon
	.section	".rodata"
	.align 2
.LC0:
	.string	"Machinegun Magazine"
	.section	".text"
	.align 2
	.globl ACEIT_ChangeMP5SpecialWeapon
	.type	 ACEIT_ChangeMP5SpecialWeapon,@function
ACEIT_ChangeMP5SpecialWeapon:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	mr 29,4
	la 28,itemlist@l(9)
	lis 31,0x38e3
	subf 0,28,29
	ori 31,31,36409
	mr 30,3
	mullw 0,0,31
	lwz 9,84(30)
	srawi 0,0,3
	slwi 0,0,2
	addi 9,9,740
	lwzx 11,9,0
	cmpwi 0,11,0
	li 3,0
	bc 12,2,.L112
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	bl FindItem
	subf 3,28,3
	lwz 7,84(30)
	mullw 3,3,31
	lwz 0,1788(7)
	addi 8,7,740
	srawi 3,3,3
	lwz 10,4256(7)
	slwi 3,3,2
	cmpw 0,29,0
	lwzx 11,8,3
	srawi 9,10,31
	subf 9,10,9
	srawi 0,11,31
	srwi 9,9,31
	subf 0,11,0
	srwi 11,0,31
	bc 4,2,.L107
	xori 9,9,1
	xori 0,11,1
	and. 10,9,0
	bc 12,2,.L108
	mr 3,30
	bl DropSpecialWeapon
	b .L111
.L108:
	and. 0,9,11
	bc 12,2,.L113
	mr 3,30
	bl Cmd_New_Reload_f
	b .L113
.L107:
	xori 9,9,1
	xori 0,11,1
	and. 10,9,0
	bc 4,2,.L111
	mr 3,30
	stw 29,3956(7)
	bl ChangeWeapon
.L113:
	li 3,1
	b .L112
.L111:
	li 3,0
.L112:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 ACEIT_ChangeMP5SpecialWeapon,.Lfe6-ACEIT_ChangeMP5SpecialWeapon
	.align 2
	.globl ACEIT_ChangeDualSpecialWeapon
	.type	 ACEIT_ChangeDualSpecialWeapon,@function
ACEIT_ChangeDualSpecialWeapon:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	mr 29,4
	la 28,itemlist@l(9)
	lis 31,0x38e3
	subf 0,28,29
	ori 31,31,36409
	mr 30,3
	mullw 0,0,31
	li 10,1
	lwz 9,84(30)
	srawi 0,0,3
	slwi 0,0,2
	addi 9,9,740
	lwzx 11,9,0
	cmpwi 0,11,0
	li 3,0
	bc 12,2,.L125
	lwz 3,52(29)
	cmpwi 0,3,0
	bc 12,2,.L116
	bl FindItem
	subf 3,28,3
	lwz 9,84(30)
	mullw 3,3,31
	addi 9,9,740
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,9,3
	cmpwi 7,0,1
	mfcr 10
	rlwinm 10,10,30,1
.L116:
	lwz 11,84(30)
	lwz 0,4232(11)
	lwz 9,1788(11)
	cmpwi 7,0,1
	cmpw 0,29,9
	mfcr 0
	rlwinm 0,0,30,1
	bc 4,2,.L120
	cmpwi 7,0,0
	xori 9,10,1
	mfcr 0
	rlwinm 0,0,31,1
	and. 10,0,9
	bc 12,2,.L121
	mr 3,30
	bl DropSpecialWeapon
	b .L124
.L121:
	bc 4,30,.L126
	mr 3,30
	bl Cmd_New_Reload_f
	b .L126
.L120:
	xori 9,0,1
	xori 0,10,1
	and. 10,9,0
	bc 4,2,.L124
	mr 3,30
	stw 29,3956(11)
	bl ChangeWeapon
.L126:
	li 3,1
	b .L125
.L124:
	li 3,0
.L125:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 ACEIT_ChangeDualSpecialWeapon,.Lfe7-ACEIT_ChangeDualSpecialWeapon
	.section	".rodata"
	.align 2
.LC1:
	.string	"Jacket Armor"
	.align 2
.LC2:
	.string	"Combat Armor"
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ACEIT_CanUseArmor
	.type	 ACEIT_CanUseArmor,@function
ACEIT_CanUseArmor:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 29,3
	mr 27,4
	lwz 28,60(29)
	mr 3,27
	bl ArmorIndex
	lwz 0,64(29)
	mr 31,3
	cmpwi 0,0,4
	li 3,1
	bc 12,2,.L136
	lis 3,.LC1@ha
	lis 29,0x38e3
	la 3,.LC1@l(3)
	ori 29,29,36409
	bl FindItem
	lis 9,itemlist@ha
	la 30,itemlist@l(9)
	subf 3,30,3
	mullw 3,3,29
	srawi 3,3,3
	cmpw 0,31,3
	bc 4,2,.L129
	lis 9,jacketarmor_info@ha
	la 8,jacketarmor_info@l(9)
	b .L130
.L129:
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	bl FindItem
	subf 3,30,3
	mullw 3,3,29
	srawi 3,3,3
	cmpw 0,31,3
	bc 4,2,.L131
	lis 9,combatarmor_info@ha
	la 8,combatarmor_info@l(9)
	b .L130
.L131:
	lis 9,bodyarmor_info@ha
	la 8,bodyarmor_info@l(9)
.L130:
	lfs 0,8(28)
	lfs 13,8(8)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L133
	fdivs 13,0,13
	lwz 0,0(28)
	lis 6,0x4330
	lis 9,.LC3@ha
	lwz 11,84(27)
	slwi 7,31,2
	xoris 0,0,0x8000
	la 9,.LC3@l(9)
	lwz 8,4(8)
	stw 0,20(1)
	addi 11,11,740
	li 3,0
	stw 6,16(1)
	lfd 11,0(9)
	lfd 0,16(1)
	mr 9,10
	lwzx 6,11,7
	fsub 0,0,11
	frsp 0,0
	fmuls 13,13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 9,20(1)
	add 9,6,9
	cmpw 7,9,8
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 8,8,0
	and 9,9,0
	or 9,9,8
	cmpw 0,6,9
	bc 4,0,.L136
.L133:
	li 3,1
.L136:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 ACEIT_CanUseArmor,.Lfe8-ACEIT_CanUseArmor
	.section	".rodata"
	.align 2
.LC4:
	.string	"Bandolier"
	.align 2
.LC6:
	.string	"Body Armor"
	.align 2
.LC9:
	.string	"Pistol Clip"
	.align 2
.LC10:
	.string	"M4 Clip"
	.align 2
.LC11:
	.string	"AP Sniper Ammo"
	.align 2
.LC12:
	.string	"12 Gauge Shells"
	.align 2
.LC5:
	.long 0x3e99999a
	.align 2
.LC7:
	.long 0x3f19999a
	.align 2
.LC8:
	.long 0x3f333333
	.align 2
.LC13:
	.long 0x0
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC15:
	.long 0x42c80000
	.align 3
.LC16:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC17:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl ACEIT_ItemNeed
	.type	 ACEIT_ItemNeed,@function
ACEIT_ItemNeed:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,4
	mr 31,3
	cmplwi 0,29,100
	bc 12,1,.L204
	lis 3,.LC4@ha
	la 3,.LC4@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 10,29,-1
	mullw 3,3,0
	addi 11,11,740
	cmplwi 0,10,72
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,11,3
	addic 9,0,-1
	subfe 6,9,0
	bc 12,1,.L206
	lis 11,.L207@ha
	slwi 10,10,2
	la 11,.L207@l(11)
	lis 9,.L207@ha
	lwzx 0,10,11
	la 9,.L207@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L207:
	.long .L172-.L207
	.long .L175-.L207
	.long .L178-.L207
	.long .L206-.L207
	.long .L182-.L207
	.long .L182-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L169-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L160-.L207
	.long .L157-.L207
	.long .L163-.L207
	.long .L166-.L207
	.long .L154-.L207
	.long .L153-.L207
	.long .L153-.L207
	.long .L153-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L153-.L207
	.long .L153-.L207
	.long .L153-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L145-.L207
	.long .L145-.L207
	.long .L145-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L145-.L207
	.long .L206-.L207
	.long .L188-.L207
	.long .L188-.L207
	.long .L188-.L207
	.long .L188-.L207
	.long .L188-.L207
	.long .L188-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L206-.L207
	.long .L191-.L207
	.long .L203-.L207
	.long .L194-.L207
	.long .L197-.L207
	.long .L200-.L207
.L145:
	lwz 0,480(31)
	cmpwi 0,0,99
	bc 12,1,.L167
	xoris 0,0,0x8000
	lis 11,0x4330
	stw 0,28(1)
	lis 10,.LC14@ha
	la 10,.LC14@l(10)
	stw 11,24(1)
	lfd 13,0(10)
	lis 11,.LC15@ha
	lfd 0,24(1)
	la 11,.LC15@l(11)
	lis 10,.LC16@ha
	lfs 12,0(11)
	la 10,.LC16@l(10)
	lfd 1,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fsub 1,1,13
	frsp 1,1
	b .L208
.L153:
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 1,0(9)
	b .L208
.L154:
	lwz 9,84(31)
	lwz 11,1784(9)
	lwz 0,832(9)
.L212:
	cmpw 0,0,11
	bc 12,0,.L209
	b .L206
.L157:
	lwz 9,84(31)
	lwz 11,1764(9)
	lwz 0,820(9)
	b .L216
.L160:
	lwz 9,84(31)
	lwz 11,1768(9)
	lwz 0,816(9)
.L213:
	cmpw 0,0,11
	bc 12,0,.L209
	b .L204
.L163:
	lwz 9,84(31)
	lwz 11,1780(9)
	lwz 0,824(9)
	b .L212
.L166:
	lwz 9,84(31)
	lwz 11,1772(9)
	lwz 0,828(9)
.L216:
	cmpw 0,0,11
	bc 12,0,.L209
.L167:
	lis 11,.LC13@ha
	la 11,.LC13@l(11)
	lfs 1,0(11)
	b .L208
.L169:
	lwz 9,84(31)
	lwz 11,1776(9)
	lwz 0,792(9)
	b .L213
.L172:
	lis 3,.LC6@ha
	la 3,.LC6@l(3)
.L214:
	bl FindItem
	mr 4,31
	bl ACEIT_CanUseArmor
	cmpwi 0,3,0
	bc 4,2,.L210
	b .L204
.L175:
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	b .L214
.L178:
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	bl FindItem
	mr 4,31
	bl ACEIT_CanUseArmor
	cmpwi 0,3,0
	bc 12,2,.L204
.L210:
	lis 9,.LC7@ha
	lfs 1,.LC7@l(9)
	b .L208
.L182:
	lis 10,.LC17@ha
	la 10,.LC17@l(10)
	b .L211
.L188:
	lwz 3,84(31)
	lis 8,0x4330
	mr 10,11
	xoris 6,6,0x8000
	lwz 0,4308(3)
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	xoris 0,0,0x8000
	lfd 11,0(9)
	stw 0,28(1)
	lis 9,unique_weapons@ha
	stw 8,24(1)
	lfd 13,24(1)
	stw 6,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 13,13,11
	lwz 7,unique_weapons@l(9)
	fsub 0,0,11
	lfs 12,20(7)
	frsp 13,13
	frsp 0,0
	fadds 12,12,0
	fcmpu 0,13,12
	bc 4,0,.L206
	slwi 0,29,2
	addi 9,3,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,2,.L206
	lis 9,.LC8@ha
	lfs 1,.LC8@l(9)
	b .L208
.L191:
	lis 3,.LC9@ha
	lwz 29,84(31)
	la 3,.LC9@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	lwz 9,1764(11)
.L215:
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpw 0,0,9
	bc 12,0,.L209
	b .L204
.L194:
	lis 3,.LC10@ha
	lwz 29,84(31)
	la 3,.LC10@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	lwz 9,1780(11)
	b .L215
.L197:
	lis 3,.LC0@ha
	lwz 29,84(31)
	la 3,.LC0@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	lwz 9,1772(11)
	b .L215
.L200:
	lis 3,.LC11@ha
	lwz 29,84(31)
	la 3,.LC11@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	lwz 9,1784(11)
	b .L215
.L203:
	lis 3,.LC12@ha
	lwz 29,84(31)
	la 3,.LC12@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	lwz 9,1768(11)
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpw 0,0,9
	bc 4,0,.L204
.L209:
	lis 9,.LC5@ha
	lfs 1,.LC5@l(9)
	b .L208
.L204:
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 1,0(9)
	b .L208
.L206:
	lis 10,.LC13@ha
	la 10,.LC13@l(10)
.L211:
	lfs 1,0(10)
.L208:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 ACEIT_ItemNeed,.Lfe9-ACEIT_ItemNeed
	.section	".rodata"
	.align 2
.LC18:
	.string	"weapon_Mk23"
	.align 2
.LC19:
	.string	"weapon_MP5"
	.align 2
.LC20:
	.string	"weapon_M4"
	.align 2
.LC21:
	.string	"weapon_M3"
	.align 2
.LC22:
	.string	"weapon_HC"
	.align 2
.LC23:
	.string	"weapon_Sniper"
	.align 2
.LC24:
	.string	"weapon_Dual"
	.align 2
.LC25:
	.string	"weapon_Knife"
	.align 2
.LC26:
	.string	"weapon_Grenade"
	.align 2
.LC27:
	.string	"item_quiet"
	.align 2
.LC28:
	.string	"item_slippers"
	.align 2
.LC29:
	.string	"item_band"
	.align 2
.LC30:
	.string	"item_vest"
	.align 2
.LC31:
	.string	"item_lasersight"
	.align 2
.LC32:
	.string	"ammo_clip"
	.align 2
.LC33:
	.string	"ammo_m4"
	.align 2
.LC34:
	.string	"ammo_mag"
	.align 2
.LC35:
	.string	"ammo_sniper"
	.align 2
.LC36:
	.string	"ammo_m3"
	.align 2
.LC37:
	.string	"item_armor_body"
	.align 2
.LC38:
	.string	"item_armor_combat"
	.align 2
.LC39:
	.string	"item_armor_jacket"
	.align 2
.LC40:
	.string	"item_armor_shard"
	.align 2
.LC41:
	.string	"item_power_screen"
	.align 2
.LC42:
	.string	"item_power_shield"
	.align 2
.LC43:
	.string	"weapon_grapple"
	.align 2
.LC44:
	.string	"weapon_blaster"
	.align 2
.LC45:
	.string	"weapon_shotgun"
	.align 2
.LC46:
	.string	"weapon_supershotgun"
	.align 2
.LC47:
	.string	"weapon_machinegun"
	.align 2
.LC48:
	.string	"weapon_chaingun"
	.align 2
.LC49:
	.string	"ammo_grenades"
	.align 2
.LC50:
	.string	"weapon_grenadelauncher"
	.align 2
.LC51:
	.string	"weapon_rocketlauncher"
	.align 2
.LC52:
	.string	"weapon_hyperblaster"
	.align 2
.LC53:
	.string	"weapon_railgun"
	.align 2
.LC54:
	.string	"weapon_bfg10k"
	.align 2
.LC55:
	.string	"ammo_shells"
	.align 2
.LC56:
	.string	"ammo_bullets"
	.align 2
.LC57:
	.string	"ammo_cells"
	.align 2
.LC58:
	.string	"ammo_rockets"
	.align 2
.LC59:
	.string	"ammo_slugs"
	.align 2
.LC60:
	.string	"item_quad"
	.align 2
.LC61:
	.string	"item_invunerability"
	.align 2
.LC62:
	.string	"item_silencer"
	.align 2
.LC63:
	.string	"item_rebreather"
	.align 2
.LC64:
	.string	"item_enviornmentsuit"
	.align 2
.LC65:
	.string	"item_ancienthead"
	.align 2
.LC66:
	.string	"item_adrenaline"
	.align 2
.LC67:
	.string	"item_bandolier"
	.align 2
.LC68:
	.string	"item_pack"
	.align 2
.LC69:
	.string	"item_datacd"
	.align 2
.LC70:
	.string	"item_powercube"
	.align 2
.LC71:
	.string	"item_pyramidkey"
	.align 2
.LC72:
	.string	"item_dataspinner"
	.align 2
.LC73:
	.string	"item_securitypass"
	.align 2
.LC74:
	.string	"item_bluekey"
	.align 2
.LC75:
	.string	"item_redkey"
	.align 2
.LC76:
	.string	"item_commandershead"
	.align 2
.LC77:
	.string	"item_airstrikemarker"
	.align 2
.LC78:
	.string	"item_health"
	.align 2
.LC79:
	.string	"item_flag_team1"
	.align 2
.LC80:
	.string	"item_flag_team2"
	.align 2
.LC81:
	.string	"item_tech1"
	.align 2
.LC82:
	.string	"item_tech2"
	.align 2
.LC83:
	.string	"item_tech3"
	.align 2
.LC84:
	.string	"item_tech4"
	.align 2
.LC85:
	.string	"item_health_small"
	.align 2
.LC86:
	.string	"item_health_medium"
	.align 2
.LC87:
	.string	"item_health_large"
	.align 2
.LC88:
	.string	"item_health_mega"
	.section	".text"
	.align 2
	.globl ACEIT_ClassnameToIndex
	.type	 ACEIT_ClassnameToIndex,@function
ACEIT_ClassnameToIndex:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 4,.LC18@ha
	la 4,.LC18@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,55
	bc 12,2,.L290
	lis 4,.LC19@ha
	mr 3,31
	la 4,.LC19@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,56
	bc 12,2,.L290
	lis 4,.LC20@ha
	mr 3,31
	la 4,.LC20@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,57
	bc 12,2,.L290
	lis 4,.LC21@ha
	mr 3,31
	la 4,.LC21@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,58
	bc 12,2,.L290
	lis 4,.LC22@ha
	mr 3,31
	la 4,.LC22@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,59
	bc 12,2,.L290
	lis 4,.LC23@ha
	mr 3,31
	la 4,.LC23@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,60
	bc 12,2,.L290
	lis 4,.LC24@ha
	mr 3,31
	la 4,.LC24@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,61
	bc 12,2,.L290
	lis 4,.LC25@ha
	mr 3,31
	la 4,.LC25@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,62
	bc 12,2,.L290
	lis 4,.LC26@ha
	mr 3,31
	la 4,.LC26@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,63
	bc 12,2,.L290
	lis 4,.LC27@ha
	mr 3,31
	la 4,.LC27@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,64
	bc 12,2,.L290
	lis 4,.LC28@ha
	mr 3,31
	la 4,.LC28@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,65
	bc 12,2,.L290
	lis 4,.LC29@ha
	mr 3,31
	la 4,.LC29@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,66
	bc 12,2,.L290
	lis 4,.LC30@ha
	mr 3,31
	la 4,.LC30@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,67
	bc 12,2,.L290
	lis 4,.LC31@ha
	mr 3,31
	la 4,.LC31@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,68
	bc 12,2,.L290
	lis 4,.LC32@ha
	mr 3,31
	la 4,.LC32@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,69
	bc 12,2,.L290
	lis 4,.LC33@ha
	mr 3,31
	la 4,.LC33@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,71
	bc 12,2,.L290
	lis 4,.LC34@ha
	mr 3,31
	la 4,.LC34@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,72
	bc 12,2,.L290
	lis 4,.LC35@ha
	mr 3,31
	la 4,.LC35@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,73
	bc 12,2,.L290
	lis 4,.LC36@ha
	mr 3,31
	la 4,.LC36@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,70
	bc 12,2,.L290
	lis 4,.LC37@ha
	mr 3,31
	la 4,.LC37@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,1
	bc 12,2,.L290
	lis 4,.LC38@ha
	mr 3,31
	la 4,.LC38@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,2
	bc 12,2,.L290
	lis 4,.LC39@ha
	mr 3,31
	la 4,.LC39@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,3
	bc 12,2,.L290
	lis 4,.LC40@ha
	mr 3,31
	la 4,.LC40@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,4
	bc 12,2,.L290
	lis 4,.LC41@ha
	mr 3,31
	la 4,.LC41@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,5
	bc 12,2,.L290
	lis 4,.LC42@ha
	mr 3,31
	la 4,.LC42@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,6
	bc 12,2,.L290
	lis 4,.LC43@ha
	mr 3,31
	la 4,.LC43@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,7
	bc 12,2,.L290
	lis 4,.LC44@ha
	mr 3,31
	la 4,.LC44@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,8
	bc 12,2,.L290
	lis 4,.LC45@ha
	mr 3,31
	la 4,.LC45@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,9
	bc 12,2,.L290
	lis 4,.LC46@ha
	mr 3,31
	la 4,.LC46@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,10
	bc 12,2,.L290
	lis 4,.LC47@ha
	mr 3,31
	la 4,.LC47@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,11
	bc 12,2,.L290
	lis 30,.LC48@ha
	mr 3,31
	la 4,.LC48@l(30)
	bl strcmp
	cmpwi 0,3,0
	li 3,12
	bc 12,2,.L290
	la 4,.LC48@l(30)
	mr 3,31
	bl strcmp
	cmpwi 0,3,0
	li 3,12
	bc 12,2,.L290
	lis 4,.LC49@ha
	mr 3,31
	la 4,.LC49@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,13
	bc 12,2,.L290
	lis 4,.LC50@ha
	mr 3,31
	la 4,.LC50@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,14
	bc 12,2,.L290
	lis 4,.LC51@ha
	mr 3,31
	la 4,.LC51@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,15
	bc 12,2,.L290
	lis 4,.LC52@ha
	mr 3,31
	la 4,.LC52@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,16
	bc 12,2,.L290
	lis 4,.LC53@ha
	mr 3,31
	la 4,.LC53@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,17
	bc 12,2,.L290
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,18
	bc 12,2,.L290
	lis 4,.LC55@ha
	mr 3,31
	la 4,.LC55@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,19
	bc 12,2,.L290
	lis 4,.LC56@ha
	mr 3,31
	la 4,.LC56@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,20
	bc 12,2,.L290
	lis 4,.LC57@ha
	mr 3,31
	la 4,.LC57@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,21
	bc 12,2,.L290
	lis 4,.LC58@ha
	mr 3,31
	la 4,.LC58@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,22
	bc 12,2,.L290
	lis 4,.LC59@ha
	mr 3,31
	la 4,.LC59@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,23
	bc 12,2,.L290
	lis 4,.LC60@ha
	mr 3,31
	la 4,.LC60@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,24
	bc 12,2,.L290
	lis 4,.LC61@ha
	mr 3,31
	la 4,.LC61@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,25
	bc 12,2,.L290
	lis 4,.LC62@ha
	mr 3,31
	la 4,.LC62@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,26
	bc 12,2,.L290
	lis 4,.LC63@ha
	mr 3,31
	la 4,.LC63@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,27
	bc 12,2,.L290
	lis 4,.LC64@ha
	mr 3,31
	la 4,.LC64@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,28
	bc 12,2,.L290
	lis 4,.LC65@ha
	mr 3,31
	la 4,.LC65@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,29
	bc 12,2,.L290
	lis 4,.LC66@ha
	mr 3,31
	la 4,.LC66@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,30
	bc 12,2,.L290
	lis 4,.LC67@ha
	mr 3,31
	la 4,.LC67@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,31
	bc 12,2,.L290
	lis 4,.LC68@ha
	mr 3,31
	la 4,.LC68@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,32
	bc 12,2,.L290
	lis 4,.LC69@ha
	mr 3,31
	la 4,.LC69@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,33
	bc 12,2,.L290
	lis 4,.LC70@ha
	mr 3,31
	la 4,.LC70@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,34
	bc 12,2,.L290
	lis 4,.LC71@ha
	mr 3,31
	la 4,.LC71@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,35
	bc 12,2,.L290
	lis 4,.LC72@ha
	mr 3,31
	la 4,.LC72@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,36
	bc 12,2,.L290
	lis 4,.LC73@ha
	mr 3,31
	la 4,.LC73@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,37
	bc 12,2,.L290
	lis 4,.LC74@ha
	mr 3,31
	la 4,.LC74@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,38
	bc 12,2,.L290
	lis 4,.LC75@ha
	mr 3,31
	la 4,.LC75@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,39
	bc 12,2,.L290
	lis 4,.LC76@ha
	mr 3,31
	la 4,.LC76@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,40
	bc 12,2,.L290
	lis 4,.LC77@ha
	mr 3,31
	la 4,.LC77@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,41
	bc 12,2,.L290
	lis 4,.LC78@ha
	mr 3,31
	la 4,.LC78@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,42
	bc 12,2,.L290
	lis 4,.LC79@ha
	mr 3,31
	la 4,.LC79@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,43
	bc 12,2,.L290
	lis 4,.LC80@ha
	mr 3,31
	la 4,.LC80@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,44
	bc 12,2,.L290
	lis 4,.LC81@ha
	mr 3,31
	la 4,.LC81@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,45
	bc 12,2,.L290
	lis 4,.LC82@ha
	mr 3,31
	la 4,.LC82@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,46
	bc 12,2,.L290
	lis 4,.LC83@ha
	mr 3,31
	la 4,.LC83@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,47
	bc 12,2,.L290
	lis 4,.LC84@ha
	mr 3,31
	la 4,.LC84@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,48
	bc 12,2,.L290
	lis 4,.LC85@ha
	mr 3,31
	la 4,.LC85@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,49
	bc 12,2,.L290
	lis 4,.LC86@ha
	mr 3,31
	la 4,.LC86@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,50
	bc 12,2,.L290
	lis 4,.LC87@ha
	mr 3,31
	la 4,.LC87@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,51
	bc 12,2,.L290
	lis 4,.LC88@ha
	mr 3,31
	la 4,.LC88@l(4)
	bl strcmp
	srawi 0,3,31
	xor 3,0,3
	subf 3,3,0
	srawi 3,3,31
	ori 3,3,54
.L290:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 ACEIT_ClassnameToIndex,.Lfe10-ACEIT_ClassnameToIndex
	.section	".rodata"
	.align 2
.LC89:
	.string	"items.txt"
	.align 2
.LC90:
	.string	"wt"
	.align 2
.LC91:
	.string	"func_plat"
	.align 2
.LC92:
	.string	"misc_teleporter_dest"
	.align 2
.LC93:
	.string	"misc_teleporter"
	.align 2
.LC94:
	.string	"func_door_rotating"
	.align 2
.LC95:
	.string	"item: %s node: %d pos: %f %f %f\n"
	.align 2
.LC96:
	.string	"Rejected item: %s node: %d pos: %f %f %f\n"
	.align 2
.LC97:
	.string	"Relink item: %s node: %d pos: %f %f %f\n"
	.align 2
.LC98:
	.long 0x41800000
	.align 2
.LC99:
	.long 0x3f000000
	.align 2
.LC100:
	.long 0x42000000
	.align 2
.LC101:
	.long 0x42800000
	.section	".text"
	.align 2
	.globl ACEIT_BuildItemNodeTable
	.type	 ACEIT_BuildItemNodeTable,@function
ACEIT_BuildItemNodeTable:
	stwu 1,-176(1)
	mflr 0
	mfcr 12
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 14,88(1)
	stw 0,180(1)
	stw 12,84(1)
	mr 30,3
	lis 4,.LC90@ha
	lis 3,.LC89@ha
	la 4,.LC90@l(4)
	la 3,.LC89@l(3)
	bl fopen
	mr. 25,3
	bc 12,2,.L291
	lis 9,globals+72@ha
	lis 11,g_edicts@ha
	lwz 0,globals+72@l(9)
	lis 10,num_items@ha
	lis 24,num_items@ha
	lwz 31,g_edicts@l(11)
	li 9,0
	mulli 0,0,996
	stw 9,num_items@l(10)
	add 0,31,0
	cmplw 0,31,0
	bc 4,0,.L294
	lis 9,item_table@ha
	cmpwi 4,30,0
	la 15,item_table@l(9)
	lis 11,nodes@ha
	addi 16,15,12
	mr 17,15
	la 14,nodes@l(11)
	lis 22,num_items@ha
.L296:
	lwz 0,248(31)
	addi 27,31,996
	cmpwi 0,0,0
	bc 12,2,.L295
	lwz 3,280(31)
	cmpwi 0,3,0
	bc 12,2,.L295
	bl ACEIT_ClassnameToIndex
	mr 30,3
	lis 4,.LC91@ha
	lwz 3,280(31)
	la 4,.LC91@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L299
	bc 4,18,.L300
	mr 3,31
	li 4,2
	bl ACEND_AddNode
.L300:
	li 30,99
.L299:
	lwz 3,280(31)
	lis 4,.LC92@ha
	la 4,.LC92@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L302
	lwz 3,280(31)
	lis 4,.LC93@ha
	la 4,.LC93@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L301
.L302:
	bc 4,18,.L303
	mr 3,31
	li 4,3
	bl ACEND_AddNode
.L303:
	li 30,99
.L301:
	lwz 3,280(31)
	lis 4,.LC94@ha
	la 4,.LC94@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L304
	li 30,99
	bc 4,18,.L304
	lwz 0,num_items@l(22)
	addi 9,15,8
	li 4,8
	mr 3,31
	addi 27,31,996
	slwi 0,0,4
	stwx 30,15,0
	stwx 31,9,0
	bl ACEND_AddNode
	lwz 0,num_items@l(22)
	mr 9,3
	lis 4,.LC95@ha
	mr 6,9
	la 4,.LC95@l(4)
	slwi 0,0,4
	mr 3,25
	stwx 9,16,0
	lfs 1,4(31)
	lfs 2,8(31)
	lfs 3,12(31)
	lwz 5,280(31)
	creqv 6,6,6
	bl fprintf
	lwz 9,num_items@l(22)
	addi 9,9,1
	stw 9,num_items@l(22)
	b .L295
.L304:
	cmpwi 0,30,-1
	bc 4,2,.L323
	lfs 1,4(31)
	lis 4,.LC96@ha
	mr 3,25
	lfs 2,8(31)
	la 4,.LC96@l(4)
	addi 27,31,996
	lfs 3,12(31)
	lwz 0,num_items@l(24)
	lwz 5,280(31)
	slwi 0,0,4
	lwzx 6,16,0
	creqv 6,6,6
	bl fprintf
	b .L295
.L323:
	lwz 0,num_items@l(24)
	addi 9,17,8
	slwi 0,0,4
	stwx 30,17,0
	stwx 31,9,0
	bc 4,18,.L308
	li 4,4
	mr 3,31
	bl ACEND_AddNode
	addi 27,31,996
	lwz 0,num_items@l(24)
	mr 9,3
	lis 4,.LC95@ha
	mr 6,9
	la 4,.LC95@l(4)
	slwi 0,0,4
	mr 3,25
	stwx 9,16,0
	lfs 1,4(31)
	lfs 2,8(31)
	lfs 3,12(31)
	lwz 5,280(31)
	creqv 6,6,6
	bl fprintf
	lwz 9,num_items@l(24)
	addi 9,9,1
	stw 9,num_items@l(24)
	b .L295
.L308:
	lis 9,numnodes@ha
	li 29,0
	lwz 0,numnodes@l(9)
	lis 18,numnodes@ha
	addi 27,31,996
	cmpw 0,29,0
	bc 4,0,.L295
	lis 9,nodes+4@ha
	lis 10,.LC99@ha
	la 23,nodes+4@l(9)
	la 10,.LC99@l(10)
	lis 9,.LC98@ha
	lfs 31,0(10)
	lis 19,nodes@ha
	la 9,.LC98@l(9)
	addi 20,23,4
	lfs 30,0(9)
	lis 26,num_items@ha
	addi 21,17,12
	li 30,0
	addi 28,14,12
.L313:
	lwz 11,0(28)
	addi 28,28,116
	xori 9,11,4
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,2
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 4,2,.L315
	cmpwi 0,11,8
	bc 12,2,.L315
	cmpwi 0,11,3
	bc 4,2,.L312
.L315:
	lfs 0,4(31)
	la 11,nodes@l(19)
	addi 9,11,12
	stfs 0,8(1)
	lfs 13,8(31)
	lwzx 0,9,30
	stfs 13,12(1)
	cmpwi 0,0,4
	lfs 0,12(31)
	stfs 0,16(1)
	bc 4,2,.L316
	fadds 0,0,30
	stfs 0,16(1)
.L316:
	lwzx 0,9,30
	cmpwi 0,0,3
	bc 4,2,.L317
	lis 10,.LC100@ha
	lfs 0,16(1)
	la 10,.LC100@l(10)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,16(1)
.L317:
	lwzx 0,9,30
	cmpwi 0,0,8
	bc 4,2,.L318
	lfs 12,4(31)
	stfs 12,56(1)
	lfs 10,8(31)
	stfs 10,60(1)
	lfs 11,12(31)
	stfs 11,64(1)
	lfs 13,188(31)
	fsubs 11,11,30
	lfs 0,200(31)
	fadds 12,12,13
	fsubs 0,0,13
	fmadds 0,0,31,12
	stfs 0,56(1)
	lfs 12,192(31)
	lfs 13,204(31)
	stfs 0,8(1)
	fadds 10,10,12
	stfs 11,16(1)
	fsubs 13,13,12
	stfs 11,64(1)
	fmadds 13,13,31,10
	stfs 13,12(1)
	stfs 13,60(1)
.L318:
	lwzx 0,9,30
	cmpwi 0,0,2
	bc 4,2,.L319
	lfs 10,200(31)
	lis 9,.LC101@ha
	la 9,.LC101@l(9)
	lfs 9,0(9)
	stfs 10,24(1)
	lfs 11,204(31)
	stfs 11,28(1)
	lfs 0,208(31)
	stfs 0,32(1)
	lfs 13,188(31)
	stfs 13,40(1)
	fsubs 10,10,13
	lfs 0,192(31)
	fmadds 10,10,31,13
	fsubs 11,11,0
	stfs 0,44(1)
	lfs 12,196(31)
	stfs 10,8(1)
	fmadds 11,11,31,0
	stfs 12,48(1)
	stfs 11,12(1)
	lfs 0,196(31)
	fadds 0,0,9
	stfs 0,16(1)
.L319:
	lfsx 13,11,30
	lfs 0,8(1)
	fcmpu 0,0,13
	bc 4,2,.L312
	lfs 13,12(1)
	lfsx 0,23,30
	fcmpu 0,13,0
	bc 4,2,.L312
	lfs 13,16(1)
	lfsx 0,20,30
	fcmpu 0,13,0
	bc 4,2,.L312
	lwz 0,num_items@l(26)
	lis 4,.LC97@ha
	mr 3,25
	la 4,.LC97@l(4)
	mr 6,29
	slwi 0,0,4
	stwx 29,21,0
	lfs 1,4(31)
	lfs 2,8(31)
	lfs 3,12(31)
	lwz 5,280(31)
	creqv 6,6,6
	bl fprintf
	lwz 9,num_items@l(26)
	addi 9,9,1
	stw 9,num_items@l(26)
.L312:
	lwz 0,numnodes@l(18)
	addi 29,29,1
	addi 30,30,116
	cmpw 0,29,0
	bc 12,0,.L313
.L295:
	lis 9,globals@ha
	lis 10,g_edicts@ha
	la 11,globals@l(9)
	mr 31,27
	lwz 0,72(11)
	lwz 9,g_edicts@l(10)
	mulli 0,0,996
	add 9,9,0
	cmplw 0,31,9
	bc 12,0,.L296
.L294:
	mr 3,25
	bl fclose
.L291:
	lwz 0,180(1)
	lwz 12,84(1)
	mtlr 0
	lmw 14,88(1)
	lfd 30,160(1)
	lfd 31,168(1)
	mtcrf 8,12
	la 1,176(1)
	blr
.Lfe11:
	.size	 ACEIT_BuildItemNodeTable,.Lfe11-ACEIT_BuildItemNodeTable
	.comm	players,1024,4
	.comm	item_table,16384,4
	.align 2
	.globl ACEIT_PlayerAdded
	.type	 ACEIT_PlayerAdded,@function
ACEIT_PlayerAdded:
	lis 10,num_players@ha
	lis 11,players@ha
	lwz 9,num_players@l(10)
	la 11,players@l(11)
	slwi 0,9,2
	addi 9,9,1
	stwx 3,11,0
	stw 9,num_players@l(10)
	blr
.Lfe12:
	.size	 ACEIT_PlayerAdded,.Lfe12-ACEIT_PlayerAdded
	.align 2
	.globl ACEIT_PlayerRemoved
	.type	 ACEIT_PlayerRemoved,@function
ACEIT_PlayerRemoved:
	lis 9,num_players@ha
	lwz 0,num_players@l(9)
	cmpwi 0,0,0
	bclr 12,2
	cmpwi 0,0,1
	bc 4,2,.L9
	li 0,0
	stw 0,num_players@l(9)
	blr
.L9:
	li 10,0
	cmpw 0,10,0
	bc 4,0,.L11
	lis 9,players@ha
	mr 7,0
	la 11,players@l(9)
.L13:
	lwz 0,0(11)
	addi 11,11,4
	xor 0,3,0
	srawi 6,0,31
	xor 9,6,0
	subf 9,9,6
	srawi 9,9,31
	andc 0,10,9
	addi 10,10,1
	and 9,8,9
	cmpw 0,10,7
	or 8,9,0
	bc 12,0,.L13
.L11:
	lis 11,num_players@ha
	mr 10,8
	lwz 9,num_players@l(11)
	addi 11,9,-1
	cmpw 0,10,11
	bc 4,0,.L17
	lis 9,players@ha
	slwi 0,10,2
	la 9,players@l(9)
	add 9,0,9
.L19:
	lwz 0,4(9)
	addi 10,10,1
	cmpw 0,10,11
	stw 0,0(9)
	addi 9,9,4
	bc 12,0,.L19
.L17:
	lis 11,num_players@ha
	lwz 9,num_players@l(11)
	addi 9,9,-1
	stw 9,num_players@l(11)
	blr
.Lfe13:
	.size	 ACEIT_PlayerRemoved,.Lfe13-ACEIT_PlayerRemoved
	.section	".rodata"
	.align 3
.LC102:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEIT_IsVisible
	.type	 ACEIT_IsVisible,@function
ACEIT_IsVisible:
	stwu 1,-80(1)
	mflr 0
	stw 0,84(1)
	lis 9,gi+48@ha
	lis 5,vec3_origin@ha
	lwz 0,gi+48@l(9)
	mr 11,3
	mr 7,4
	la 5,vec3_origin@l(5)
	addi 3,1,8
	li 9,27
	mr 8,11
	mtlr 0
	addi 4,11,4
	mr 6,5
	blrl
	lfs 0,16(1)
	lis 9,.LC102@ha
	la 9,.LC102@l(9)
	lfd 13,0(9)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,31,1
	lwz 0,84(1)
	mtlr 0
	la 1,80(1)
	blr
.Lfe14:
	.size	 ACEIT_IsVisible,.Lfe14-ACEIT_IsVisible
	.section	".rodata"
	.align 2
.LC103:
	.long 0x41900000
	.align 3
.LC104:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEIT_IsReachable
	.type	 ACEIT_IsReachable,@function
ACEIT_IsReachable:
	stwu 1,-96(1)
	mflr 0
	stw 0,100(1)
	lis 9,.LC103@ha
	mr 11,3
	la 9,.LC103@l(9)
	lfs 13,196(11)
	mr 7,4
	lfs 0,0(9)
	addi 3,1,8
	mr 8,11
	lis 9,gi+48@ha
	lfs 12,188(11)
	addi 4,11,4
	lwz 0,gi+48@l(9)
	addi 5,1,72
	addi 6,11,200
	fadds 13,13,0
	li 9,27
	lfs 0,192(11)
	mtlr 0
	stfs 12,72(1)
	stfs 13,80(1)
	stfs 0,76(1)
	blrl
	lfs 0,16(1)
	lis 9,.LC104@ha
	la 9,.LC104@l(9)
	lfd 13,0(9)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,31,1
	lwz 0,100(1)
	mtlr 0
	la 1,96(1)
	blr
.Lfe15:
	.size	 ACEIT_IsReachable,.Lfe15-ACEIT_IsReachable
	.align 2
	.globl ACEIT_ChangeWeapon
	.type	 ACEIT_ChangeWeapon,@function
ACEIT_ChangeWeapon:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,itemlist@ha
	mr 29,4
	la 28,itemlist@l(9)
	lis 31,0x38e3
	subf 0,28,29
	ori 31,31,36409
	mr 30,3
	mullw 0,0,31
	li 10,1
	lwz 9,84(30)
	srawi 0,0,3
	slwi 0,0,2
	addi 9,9,740
	lwzx 11,9,0
	cmpwi 0,11,0
	li 3,0
	bc 12,2,.L326
	lwz 3,52(29)
	cmpwi 0,3,0
	bc 12,2,.L29
	bl FindItem
	subf 3,28,3
	lwz 9,84(30)
	mullw 3,3,31
	addi 9,9,740
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,9,3
	addic 9,0,-1
	subfe 10,9,0
.L29:
	lwz 9,84(30)
	lwz 0,1788(9)
	cmpw 0,29,0
	bc 4,2,.L32
	lwz 0,3992(9)
	xori 11,10,1
	xori 0,0,4
	addic 10,0,-1
	subfe 9,10,0
	cmpwi 7,9,0
	mfcr 0
	rlwinm 0,0,31,1
	and. 9,0,11
	bc 12,2,.L34
	li 3,0
	b .L326
.L34:
	bc 4,30,.L327
	mr 3,30
	bl Cmd_New_Reload_f
	b .L327
.L32:
	mr 3,30
	stw 29,3956(9)
	bl ChangeWeapon
.L327:
	li 3,1
.L326:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 ACEIT_ChangeWeapon,.Lfe16-ACEIT_ChangeWeapon
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
