	.file	"g_trigger.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC3:
	.string	"misc/secret.wav"
	.align 2
.LC4:
	.string	"misc/talk.wav"
	.align 2
.LC5:
	.string	"misc/trigger1.wav"
	.align 2
.LC6:
	.long 0x3e4ccccd
	.align 2
.LC7:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_trigger_multiple
	.type	 SP_trigger_multiple,@function
SP_trigger_multiple:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,804(31)
	cmpwi 0,0,1
	bc 4,2,.L33
	lis 9,gi+36@ha
	lis 3,.LC3@ha
	lwz 0,gi+36@l(9)
	la 3,.LC3@l(3)
	b .L42
.L33:
	cmpwi 0,0,2
	bc 4,2,.L35
	lis 9,gi+36@ha
	lis 3,.LC4@ha
	lwz 0,gi+36@l(9)
	la 3,.LC4@l(3)
	b .L42
.L35:
	cmpwi 0,0,3
	bc 4,2,.L34
	lis 9,gi@ha
	lis 3,.LC5@ha
	la 9,gi@l(9)
	la 3,.LC5@l(3)
	lwz 0,36(9)
.L42:
	mtlr 0
	blrl
	stw 3,852(31)
.L34:
	lis 8,.LC7@ha
	lfs 13,884(31)
	la 8,.LC7@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,2,.L38
	lis 9,.LC6@ha
	lfs 0,.LC6@l(9)
	stfs 0,884(31)
.L38:
	lwz 0,288(31)
	lis 9,Touch_Multi@ha
	li 10,0
	lwz 11,184(31)
	la 9,Touch_Multi@l(9)
	andi. 8,0,4
	stw 9,688(31)
	ori 11,11,1
	stw 10,264(31)
	stw 11,184(31)
	bc 12,2,.L39
	lis 9,trigger_enable@ha
	stw 10,248(31)
	la 9,trigger_enable@l(9)
	b .L43
.L39:
	lis 9,Use_Multi@ha
	li 0,1
	la 9,Use_Multi@l(9)
	stw 0,248(31)
.L43:
	stw 9,692(31)
	addi 29,31,16
	lis 4,vec3_origin@ha
	la 4,vec3_origin@l(4)
	mr 3,29
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L41
	mr 3,29
	addi 4,31,584
	bl G_SetMovedir
.L41:
	lis 29,gi@ha
	mr 3,31
	lwz 4,272(31)
	la 29,gi@l(29)
	lwz 9,44(29)
	mtlr 9
	blrl
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 SP_trigger_multiple,.Lfe1-SP_trigger_multiple
	.section	".rodata"
	.align 2
.LC8:
	.string	"fixed TRIGGERED flag on %s at %s\n"
	.align 2
.LC9:
	.string	"You need the %s"
	.align 2
.LC10:
	.string	"misc/keytry.wav"
	.align 2
.LC11:
	.string	"misc/keyuse.wav"
	.align 2
.LC12:
	.string	"key_power_cube"
	.align 3
.LC13:
	.long 0x40140000
	.long 0x0
	.align 2
.LC14:
	.long 0x3f800000
	.align 2
.LC15:
	.long 0x0
	.section	".text"
	.align 2
	.globl trigger_key_use
	.type	 trigger_key_use,@function
trigger_key_use:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 28,3
	mr 30,5
	lwz 10,1000(28)
	cmpwi 0,10,0
	bc 12,2,.L48
	lwz 11,84(30)
	cmpwi 0,11,0
	bc 12,2,.L48
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,11,748
	mullw 9,9,0
	srawi 27,9,3
	slwi 31,27,2
	lwzx 0,11,31
	cmpwi 0,0,0
	bc 4,2,.L51
	lis 9,level+4@ha
	lfs 0,704(28)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L48
	lis 9,.LC13@ha
	fmr 0,13
	lis 29,gi@ha
	la 9,.LC13@l(9)
	la 29,gi@l(29)
	lfd 13,0(9)
	lis 4,.LC9@ha
	mr 3,30
	la 4,.LC9@l(4)
	fadd 0,0,13
	frsp 0,0
	stfs 0,704(28)
	lwz 9,12(29)
	lwz 5,40(10)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
	mtlr 9
	blrl
	lis 9,.LC14@ha
	lwz 0,16(29)
	lis 11,.LC14@ha
	la 9,.LC14@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC14@l(11)
	li 4,0
	mtlr 0
	lis 9,.LC15@ha
	mr 3,30
	lfs 2,0(11)
	la 9,.LC15@l(9)
	lfs 3,0(9)
	blrl
	b .L48
.L51:
	lis 29,gi@ha
	lis 3,.LC11@ha
	la 29,gi@l(29)
	la 3,.LC11@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC14@ha
	lwz 0,16(29)
	lis 11,.LC14@ha
	la 9,.LC14@l(9)
	la 11,.LC14@l(11)
	lfs 1,0(9)
	mr 5,3
	li 4,0
	mtlr 0
	lis 9,.LC15@ha
	lfs 2,0(11)
	mr 3,30
	la 9,.LC15@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC15@ha
	lis 11,coop@ha
	la 9,.LC15@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L53
	lwz 9,1000(28)
	lis 4,.LC12@ha
	la 4,.LC12@l(4)
	lwz 3,0(9)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L54
	lwz 9,84(30)
	li 5,0
	lwz 0,1856(9)
	andi. 11,0,1
	bc 4,2,.L56
.L57:
	addi 5,5,1
	cmpwi 0,5,7
	bc 12,1,.L56
	lwz 0,1856(9)
	sraw 0,0,5
	andi. 11,0,1
	bc 12,2,.L57
.L56:
	lis 9,game@ha
	li 7,1
	la 10,game@l(9)
	lwz 0,1544(10)
	cmpw 0,7,0
	bc 12,1,.L77
	lis 9,g_edicts@ha
	slw 0,7,5
	lwz 11,g_edicts@l(9)
	nor 4,0,0
	slwi 6,27,2
	mr 3,10
	addi 8,11,1268
.L64:
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L63
	lwz 11,84(8)
	cmpwi 0,11,0
	bc 12,2,.L63
	lwz 0,1856(11)
	sraw 0,0,5
	andi. 9,0,1
	bc 12,2,.L63
	addi 11,11,748
	lwzx 9,11,6
	addi 9,9,-1
	stwx 9,11,6
	lwz 10,84(8)
	lwz 0,1856(10)
	and 0,0,4
	stw 0,1856(10)
.L63:
	lwz 0,1544(3)
	addi 7,7,1
	addi 8,8,1268
	cmpw 0,7,0
	bc 4,1,.L64
	b .L77
.L54:
	lis 9,game@ha
	li 7,1
	la 10,game@l(9)
	lwz 0,1544(10)
	cmpw 0,7,0
	bc 12,1,.L77
	lis 9,g_edicts@ha
	mr 6,10
	lwz 11,g_edicts@l(9)
	mr 8,31
	li 10,0
	addi 11,11,1268
.L73:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L72
	lwz 9,84(11)
	cmpwi 0,9,0
	bc 12,2,.L72
	addi 9,9,748
	stwx 10,9,8
.L72:
	lwz 0,1544(6)
	addi 7,7,1
	addi 11,11,1268
	cmpw 0,7,0
	bc 4,1,.L73
	b .L77
.L53:
	lwz 11,84(30)
	addi 11,11,748
	lwzx 9,11,31
	addi 9,9,-1
	stwx 9,11,31
.L77:
	mr 4,30
	mr 3,28
	bl G_UseTargets
	li 0,0
	stw 0,692(28)
.L48:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 trigger_key_use,.Lfe2-trigger_key_use
	.section	".rodata"
	.align 2
.LC16:
	.string	"no key item for trigger_key at %s\n"
	.align 2
.LC17:
	.string	"item %s not found for trigger_key at %s\n"
	.align 2
.LC18:
	.string	"%s at %s has no target\n"
	.section	".text"
	.align 2
	.globl SP_trigger_key
	.type	 SP_trigger_key,@function
SP_trigger_key:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,st@ha
	mr 31,3
	la 28,st@l(9)
	lwz 3,44(28)
	cmpwi 0,3,0
	bc 4,2,.L79
	lis 29,gi@ha
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC16@ha
	la 3,.LC16@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L78
.L79:
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,1000(31)
	bc 4,2,.L80
	lis 29,gi@ha
	lwz 28,44(28)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC17@ha
	la 3,.LC17@l(3)
	b .L82
.L80:
	lwz 0,532(31)
	cmpwi 0,0,0
	bc 4,2,.L81
	lis 29,gi@ha
	lwz 28,284(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC18@ha
	la 3,.LC18@l(3)
.L82:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L78
.L81:
	lis 29,gi@ha
	lis 3,.LC10@ha
	la 29,gi@l(29)
	la 3,.LC10@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,36(29)
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	mtlr 0
	blrl
	lis 9,trigger_key_use@ha
	la 9,trigger_key_use@l(9)
	stw 9,692(31)
.L78:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 SP_trigger_key,.Lfe3-SP_trigger_key
	.section	".rodata"
	.align 2
.LC19:
	.string	"%i more to go..."
	.align 2
.LC20:
	.string	"misc/talk1.wav"
	.align 2
.LC21:
	.string	"Sequence completed!"
	.align 3
.LC22:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC23:
	.long 0x3f800000
	.align 2
.LC24:
	.long 0x0
	.section	".text"
	.align 2
	.globl trigger_counter_use
	.type	 trigger_counter_use,@function
trigger_counter_use:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	mr 31,3
	mr 30,5
	lwz 5,808(31)
	cmpwi 0,5,0
	bc 12,2,.L83
	addi 28,5,-1
	cmpwi 0,28,0
	stw 28,808(31)
	bc 12,2,.L85
	lwz 0,288(31)
	andi. 9,0,1
	bc 4,2,.L83
	lis 29,gi@ha
	lis 4,.LC19@ha
	la 29,gi@l(29)
	la 4,.LC19@l(4)
	lwz 9,12(29)
	mr 5,28
	mr 3,30
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	mtlr 9
	blrl
	lis 9,.LC23@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC23@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 2,0(9)
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 3,0(9)
	blrl
	b .L83
.L85:
	lwz 0,288(31)
	andi. 9,0,1
	bc 4,2,.L87
	lis 29,gi@ha
	lis 4,.LC21@ha
	la 29,gi@l(29)
	la 4,.LC21@l(4)
	lwz 9,12(29)
	mr 3,30
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	mtlr 9
	blrl
	lis 9,.LC23@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC23@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 2,0(9)
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 3,0(9)
	blrl
.L87:
	lis 9,.LC24@ha
	lfs 0,672(31)
	la 9,.LC24@l(9)
	stw 30,824(31)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L83
	mr 4,30
	mr 3,31
	bl G_UseTargets
	lfs 13,884(31)
	fcmpu 0,13,31
	bc 4,1,.L90
	lis 9,multi_wait@ha
	lis 11,level+4@ha
	la 9,multi_wait@l(9)
	stw 9,680(31)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	b .L92
.L90:
	stw 28,688(31)
	lis 11,level+4@ha
	lis 10,.LC22@ha
	lfs 0,level+4@l(11)
	lis 9,G_FreeEdict@ha
	lfd 13,.LC22@l(10)
	la 9,G_FreeEdict@l(9)
	stw 9,680(31)
	fadd 0,0,13
	frsp 0,0
.L92:
	stfs 0,672(31)
.L83:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 trigger_counter_use,.Lfe4-trigger_counter_use
	.section	".rodata"
	.align 2
.LC27:
	.string	"grenade"
	.align 2
.LC28:
	.string	"misc/windfly.wav"
	.align 3
.LC29:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC30:
	.long 0x3f800000
	.align 2
.LC31:
	.long 0x0
	.align 2
.LC32:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl hurt_touch
	.type	 hurt_touch,@function
hurt_touch:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 30,4
	mr 31,3
	lwz 0,788(30)
	cmpwi 0,0,0
	bc 12,2,.L112
	lis 9,level+4@ha
	lfs 0,520(31)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 12,1,.L112
	lwz 0,288(31)
	andi. 9,0,16
	bc 12,2,.L115
	lis 11,.LC30@ha
	la 11,.LC30@l(11)
	lfs 0,0(11)
	fadds 0,13,0
	b .L138
.L115:
	fmr 0,13
	lis 9,.LC29@ha
	lfd 13,.LC29@l(9)
	fadd 0,0,13
	frsp 0,0
.L138:
	stfs 0,520(31)
	lwz 0,288(31)
	andi. 9,0,4
	bc 4,2,.L117
	lis 11,level@ha
	lis 0,0x6666
	lwz 9,level@l(11)
	ori 0,0,26215
	mulhw 0,9,0
	srawi 11,9,31
	srawi 0,0,2
	subf 0,11,0
	mulli 0,0,10
	cmpw 0,9,0
	bc 4,2,.L117
	lis 11,.LC30@ha
	lis 9,gi+16@ha
	lwz 5,852(31)
	la 11,.LC30@l(11)
	lwz 0,gi+16@l(9)
	mr 3,30
	lfs 1,0(11)
	lis 9,.LC30@ha
	li 4,0
	lis 11,.LC31@ha
	la 9,.LC30@l(9)
	mtlr 0
	la 11,.LC31@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L117:
	lwz 9,908(31)
	lwz 0,288(31)
	cmpwi 0,9,0
	rlwinm 11,0,2,26,26
	bc 12,2,.L121
	lwz 0,908(30)
	cmpw 0,9,0
	bc 4,2,.L122
	lwz 9,792(31)
	lis 6,vec3_origin@ha
	li 0,31
	la 6,vec3_origin@l(6)
	stw 11,8(1)
	mr 3,30
	stw 0,12(1)
	mr 4,31
	mr 5,31
	addi 7,30,4
	mr 8,6
	mr 10,9
	bl T_Damage
	lwz 11,872(31)
	cmpwi 0,11,0
	bc 12,2,.L122
	lwz 9,84(30)
	cmpwi 0,9,0
	bc 12,2,.L122
	lwz 0,3560(9)
	add 0,0,11
	stw 0,3560(9)
.L122:
	lwz 10,876(31)
	cmpwi 0,10,0
	bc 12,2,.L112
	lis 9,level@ha
	la 11,level@l(9)
	lwz 0,316(11)
	cmpwi 0,0,0
	bc 4,2,.L126
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L127
	lwz 0,908(30)
	lwz 9,908(31)
	cmpw 0,9,0
	bc 4,2,.L127
	cmpwi 0,9,1
	bc 4,2,.L129
	lwz 0,304(11)
	add 0,0,10
	stw 0,304(11)
	b .L127
.L129:
	lwz 0,308(11)
	add 0,0,10
	stw 0,308(11)
.L127:
	lis 11,.LC32@ha
	lis 9,level+4@ha
	la 11,.LC32@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	b .L139
.L126:
	lwz 9,908(31)
	lwz 0,908(30)
	cmpw 0,9,0
	bc 4,2,.L112
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L112
	cmpwi 0,9,1
	bc 4,2,.L134
	lwz 0,304(11)
	add 0,0,10
	stw 0,304(11)
.L134:
	lwz 0,908(30)
	cmpwi 0,0,2
	bc 4,2,.L135
	lwz 0,308(11)
	lwz 9,876(31)
	add 0,0,9
	stw 0,308(11)
.L135:
	lwz 0,908(30)
	cmpwi 0,0,3
	bc 4,2,.L136
	lwz 0,312(11)
	lwz 9,876(31)
	add 0,0,9
	stw 0,312(11)
.L136:
	lis 9,.LC32@ha
	lfs 0,4(11)
	la 9,.LC32@l(9)
	lfs 13,0(9)
.L139:
	fadds 0,0,13
	stfs 0,936(31)
	b .L112
.L121:
	lwz 9,792(31)
	lis 6,vec3_origin@ha
	mr 3,30
	mr 4,31
	la 6,vec3_origin@l(6)
	stw 11,8(1)
	li 0,31
	mr 5,4
	stw 0,12(1)
	addi 7,3,4
	mr 8,6
	mr 10,9
	bl T_Damage
.L112:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 hurt_touch,.Lfe5-hurt_touch
	.section	".rodata"
	.align 2
.LC33:
	.string	"world/electro.wav"
	.align 2
.LC34:
	.string	"trigger_gravity without gravity set at %s\n"
	.section	".text"
	.align 2
	.globl InitTrigger
	.type	 InitTrigger,@function
InitTrigger:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lis 4,vec3_origin@ha
	addi 29,31,16
	la 4,vec3_origin@l(4)
	mr 3,29
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L7
	mr 3,29
	addi 4,31,584
	bl G_SetMovedir
.L7:
	li 29,1
	li 0,0
	lwz 4,272(31)
	stw 0,264(31)
	lis 9,gi+44@ha
	mr 3,31
	stw 29,248(31)
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	stw 29,184(31)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 InitTrigger,.Lfe6-InitTrigger
	.align 2
	.globl multi_wait
	.type	 multi_wait,@function
multi_wait:
	li 0,0
	stw 0,672(3)
	blr
.Lfe7:
	.size	 multi_wait,.Lfe7-multi_wait
	.section	".rodata"
	.align 3
.LC35:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC36:
	.long 0x0
	.section	".text"
	.align 2
	.globl multi_trigger
	.type	 multi_trigger,@function
multi_trigger:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 31,20(1)
	stw 0,36(1)
	lis 9,.LC36@ha
	mr 31,3
	la 9,.LC36@l(9)
	lfs 0,672(31)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L9
	lwz 4,824(31)
	bl G_UseTargets
	lfs 13,884(31)
	fcmpu 0,13,31
	bc 4,1,.L11
	lis 9,multi_wait@ha
	lis 11,level+4@ha
	la 9,multi_wait@l(9)
	stw 9,680(31)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	b .L163
.L11:
	li 0,0
	lis 11,level+4@ha
	stw 0,688(31)
	lis 10,.LC35@ha
	lis 9,G_FreeEdict@ha
	lfs 0,level+4@l(11)
	la 9,G_FreeEdict@l(9)
	lfd 13,.LC35@l(10)
	stw 9,680(31)
	fadd 0,0,13
	frsp 0,0
.L163:
	stfs 0,672(31)
.L9:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 multi_trigger,.Lfe8-multi_trigger
	.section	".rodata"
	.align 3
.LC37:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC38:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_Multi
	.type	 Use_Multi,@function
Use_Multi:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 31,20(1)
	stw 0,36(1)
	lis 9,.LC38@ha
	mr 31,3
	la 9,.LC38@l(9)
	lfs 0,672(31)
	mr 4,5
	lfs 31,0(9)
	stw 4,824(31)
	fcmpu 0,0,31
	bc 4,2,.L15
	bl G_UseTargets
	lfs 13,884(31)
	fcmpu 0,13,31
	bc 4,1,.L16
	lis 9,multi_wait@ha
	lis 11,level+4@ha
	la 9,multi_wait@l(9)
	stw 9,680(31)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	b .L164
.L16:
	li 0,0
	lis 11,level+4@ha
	stw 0,688(31)
	lis 10,.LC37@ha
	lis 9,G_FreeEdict@ha
	lfs 0,level+4@l(11)
	la 9,G_FreeEdict@l(9)
	lfd 13,.LC37@l(10)
	stw 9,680(31)
	fadd 0,0,13
	frsp 0,0
.L164:
	stfs 0,672(31)
.L15:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 Use_Multi,.Lfe9-Use_Multi
	.section	".rodata"
	.align 3
.LC39:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC40:
	.long 0x0
	.section	".text"
	.align 2
	.globl Touch_Multi
	.type	 Touch_Multi,@function
Touch_Multi:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	mr 30,4
	mr 31,3
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L19
	lwz 0,288(31)
	andi. 9,0,2
	bc 4,2,.L18
	b .L21
.L19:
	lwz 0,184(30)
	andi. 9,0,4
	bc 12,2,.L18
	lwz 0,288(31)
	andi. 9,0,1
	bc 12,2,.L18
.L21:
	addi 29,31,584
	lis 4,vec3_origin@ha
	la 4,vec3_origin@l(4)
	mr 3,29
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L25
	addi 4,1,8
	addi 3,30,16
	li 5,0
	li 6,0
	bl AngleVectors
	mr 4,29
	addi 3,1,8
	bl _DotProduct
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L18
.L25:
	lis 9,.LC40@ha
	lfs 0,672(31)
	la 9,.LC40@l(9)
	stw 30,824(31)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L18
	mr 4,30
	mr 3,31
	bl G_UseTargets
	lfs 13,884(31)
	fcmpu 0,13,31
	bc 4,1,.L29
	lis 9,multi_wait@ha
	lis 11,level+4@ha
	la 9,multi_wait@l(9)
	stw 9,680(31)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	b .L165
.L29:
	li 0,0
	lis 11,level+4@ha
	stw 0,688(31)
	lis 10,.LC39@ha
	lis 9,G_FreeEdict@ha
	lfs 0,level+4@l(11)
	la 9,G_FreeEdict@l(9)
	lfd 13,.LC39@l(10)
	stw 9,680(31)
	fadd 0,0,13
	frsp 0,0
.L165:
	stfs 0,672(31)
.L18:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 Touch_Multi,.Lfe10-Touch_Multi
	.align 2
	.globl trigger_enable
	.type	 trigger_enable,@function
trigger_enable:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,Use_Multi@ha
	mr 9,3
	li 0,1
	la 11,Use_Multi@l(11)
	stw 0,248(9)
	lis 10,gi+72@ha
	stw 11,692(9)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 trigger_enable,.Lfe11-trigger_enable
	.section	".rodata"
	.align 2
.LC41:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl SP_trigger_once
	.type	 SP_trigger_once,@function
SP_trigger_once:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,288(31)
	andi. 9,0,1
	bc 12,2,.L45
	lis 9,.LC41@ha
	addi 4,31,236
	la 9,.LC41@l(9)
	addi 5,1,8
	lfs 1,0(9)
	addi 3,31,188
	bl VectorMA
	lwz 0,288(31)
	lis 29,gi@ha
	addi 3,1,8
	la 29,gi@l(29)
	lwz 28,284(31)
	rlwinm 0,0,0,0,30
	ori 0,0,4
	stw 0,288(31)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC8@ha
	la 3,.LC8@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L45:
	lis 0,0xbf80
	mr 3,31
	stw 0,884(31)
	bl SP_trigger_multiple
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 SP_trigger_once,.Lfe12-SP_trigger_once
	.align 2
	.globl trigger_relay_use
	.type	 trigger_relay_use,@function
trigger_relay_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 4,5
	bl G_UseTargets
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 trigger_relay_use,.Lfe13-trigger_relay_use
	.align 2
	.globl SP_trigger_relay
	.type	 SP_trigger_relay,@function
SP_trigger_relay:
	lis 9,trigger_relay_use@ha
	la 9,trigger_relay_use@l(9)
	stw 9,692(3)
	blr
.Lfe14:
	.size	 SP_trigger_relay,.Lfe14-SP_trigger_relay
	.align 2
	.globl SP_trigger_counter
	.type	 SP_trigger_counter,@function
SP_trigger_counter:
	lwz 9,808(3)
	lis 0,0xbf80
	stw 0,884(3)
	cmpwi 0,9,0
	bc 4,2,.L94
	li 0,2
	stw 0,808(3)
.L94:
	lis 9,trigger_counter_use@ha
	la 9,trigger_counter_use@l(9)
	stw 9,692(3)
	blr
.Lfe15:
	.size	 SP_trigger_counter,.Lfe15-SP_trigger_counter
	.section	".rodata"
	.align 3
.LC42:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC43:
	.long 0x3e4ccccd
	.section	".text"
	.align 2
	.globl SP_trigger_always
	.type	 SP_trigger_always,@function
SP_trigger_always:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lfs 0,888(3)
	lis 9,.LC42@ha
	lfd 13,.LC42@l(9)
	fcmpu 0,0,13
	bc 4,0,.L96
	lis 9,.LC43@ha
	lfs 0,.LC43@l(9)
	stfs 0,888(3)
.L96:
	mr 4,3
	bl G_UseTargets
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 SP_trigger_always,.Lfe16-SP_trigger_always
	.section	".sbss","aw",@nobits
	.align 2
windsound:
	.space	4
	.size	 windsound,4
	.section	".rodata"
	.align 2
.LC44:
	.long 0x41200000
	.align 3
.LC45:
	.long 0x3ff80000
	.long 0x0
	.align 2
.LC46:
	.long 0x3f800000
	.align 2
.LC47:
	.long 0x0
	.section	".text"
	.align 2
	.globl trigger_push_touch
	.type	 trigger_push_touch,@function
trigger_push_touch:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,4
	mr 30,3
	lwz 3,284(31)
	lis 4,.LC27@ha
	la 4,.LC27@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L98
	lis 9,.LC44@ha
	lfs 0,572(30)
	addi 4,31,620
	la 9,.LC44@l(9)
	addi 3,30,584
	lfs 1,0(9)
	fmuls 1,0,1
	bl VectorScale
	b .L99
.L98:
	lwz 0,728(31)
	cmpwi 0,0,0
	bc 4,1,.L99
	lis 9,.LC44@ha
	lfs 0,572(30)
	addi 3,30,584
	la 9,.LC44@l(9)
	addi 4,31,620
	lfs 1,0(9)
	fmuls 1,0,1
	bl VectorScale
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L99
	lfs 0,620(31)
	lis 10,level+4@ha
	stfs 0,3832(9)
	lfs 0,624(31)
	lwz 9,84(31)
	stfs 0,3836(9)
	lfs 0,628(31)
	lwz 11,84(31)
	stfs 0,3840(11)
	lfs 13,level+4@l(10)
	lfs 0,716(31)
	fcmpu 0,0,13
	bc 4,0,.L99
	lis 9,.LC45@ha
	fmr 0,13
	lis 11,gi+16@ha
	la 9,.LC45@l(9)
	mr 3,31
	lfd 13,0(9)
	li 4,0
	lis 9,windsound@ha
	lwz 5,windsound@l(9)
	fadd 0,0,13
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 1,0(9)
	frsp 0,0
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 2,0(9)
	stfs 0,716(31)
	lis 9,.LC47@ha
	lwz 0,gi+16@l(11)
	la 9,.LC47@l(9)
	lfs 3,0(9)
	mtlr 0
	blrl
.L99:
	lwz 0,288(30)
	andi. 9,0,1
	bc 12,2,.L103
	mr 3,30
	bl G_FreeEdict
.L103:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe17:
	.size	 trigger_push_touch,.Lfe17-trigger_push_touch
	.section	".rodata"
	.align 2
.LC48:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_trigger_push
	.type	 SP_trigger_push,@function
SP_trigger_push:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lis 4,vec3_origin@ha
	addi 29,31,16
	la 4,vec3_origin@l(4)
	mr 3,29
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L105
	mr 3,29
	addi 4,31,584
	bl G_SetMovedir
.L105:
	li 0,0
	li 29,1
	lwz 4,272(31)
	lis 9,gi@ha
	stw 0,264(31)
	mr 3,31
	la 30,gi@l(9)
	stw 29,248(31)
	lwz 9,44(30)
	mtlr 9
	blrl
	stw 29,184(31)
	lis 3,.LC28@ha
	lwz 9,36(30)
	la 3,.LC28@l(3)
	mtlr 9
	blrl
	lis 9,.LC48@ha
	lfs 13,572(31)
	lis 11,windsound@ha
	la 9,.LC48@l(9)
	stw 3,windsound@l(11)
	lfs 0,0(9)
	lis 9,trigger_push_touch@ha
	la 9,trigger_push_touch@l(9)
	fcmpu 0,13,0
	stw 9,688(31)
	bc 4,2,.L107
	lis 0,0x447a
	stw 0,572(31)
.L107:
	lwz 0,72(30)
	mr 3,31
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 SP_trigger_push,.Lfe18-SP_trigger_push
	.align 2
	.globl hurt_use
	.type	 hurt_use,@function
hurt_use:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,248(31)
	cmpwi 0,0,0
	li 0,0
	bc 4,2,.L109
	li 0,1
.L109:
	stw 0,248(31)
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,288(31)
	andi. 0,0,2
	bc 4,2,.L111
	stw 0,692(31)
.L111:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe19:
	.size	 hurt_use,.Lfe19-hurt_use
	.align 2
	.globl SP_trigger_hurt
	.type	 SP_trigger_hurt,@function
SP_trigger_hurt:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lis 4,vec3_origin@ha
	addi 29,31,16
	la 4,vec3_origin@l(4)
	mr 3,29
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L141
	mr 3,29
	addi 4,31,584
	bl G_SetMovedir
.L141:
	li 30,1
	li 28,0
	lwz 4,272(31)
	lis 29,gi@ha
	stw 30,248(31)
	mr 3,31
	la 29,gi@l(29)
	stw 28,264(31)
	lwz 9,44(29)
	mtlr 9
	blrl
	stw 30,184(31)
	lis 3,.LC33@ha
	lwz 0,36(29)
	la 3,.LC33@l(3)
	mtlr 0
	blrl
	lwz 0,792(31)
	lis 9,hurt_touch@ha
	la 9,hurt_touch@l(9)
	stw 3,852(31)
	cmpwi 0,0,0
	stw 9,688(31)
	bc 4,2,.L143
	li 0,5
	stw 0,792(31)
.L143:
	lwz 0,288(31)
	andi. 9,0,1
	bc 12,2,.L144
	stw 28,248(31)
	b .L145
.L144:
	stw 30,248(31)
.L145:
	lwz 0,288(31)
	andi. 9,0,2
	bc 12,2,.L146
	lis 9,hurt_use@ha
	la 9,hurt_use@l(9)
	stw 9,692(31)
.L146:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 SP_trigger_hurt,.Lfe20-SP_trigger_hurt
	.align 2
	.globl trigger_gravity_touch
	.type	 trigger_gravity_touch,@function
trigger_gravity_touch:
	lfs 0,652(3)
	stfs 0,652(4)
	blr
.Lfe21:
	.size	 trigger_gravity_touch,.Lfe21-trigger_gravity_touch
	.section	".rodata"
	.align 3
.LC49:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_trigger_gravity
	.type	 SP_trigger_gravity,@function
SP_trigger_gravity:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,st@ha
	mr 31,3
	la 30,st@l(9)
	lwz 0,48(30)
	cmpwi 0,0,0
	bc 4,2,.L149
	lis 29,gi@ha
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC34@ha
	la 3,.LC34@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L148
.L149:
	addi 29,31,16
	lis 4,vec3_origin@ha
	la 4,vec3_origin@l(4)
	mr 3,29
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L150
	mr 3,29
	addi 4,31,584
	bl G_SetMovedir
.L150:
	li 29,1
	li 0,0
	lwz 4,272(31)
	lis 9,gi+44@ha
	stw 0,264(31)
	mr 3,31
	stw 29,248(31)
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	stw 29,184(31)
	lwz 3,48(30)
	bl atoi
	xoris 3,3,0x8000
	stw 3,28(1)
	lis 0,0x4330
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	stw 0,24(1)
	lfd 13,0(9)
	lfd 0,24(1)
	lis 9,trigger_gravity_touch@ha
	la 9,trigger_gravity_touch@l(9)
	stw 9,688(31)
	fsub 0,0,13
	frsp 0,0
	stfs 0,652(31)
.L148:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe22:
	.size	 SP_trigger_gravity,.Lfe22-SP_trigger_gravity
	.align 2
	.globl trigger_monsterjump_touch
	.type	 trigger_monsterjump_touch,@function
trigger_monsterjump_touch:
	lwz 0,268(4)
	andi. 9,0,3
	bclr 4,2
	lwz 0,184(4)
	andi. 9,0,2
	bclr 4,2
	andi. 11,0,4
	bclr 12,2
	lfs 0,572(3)
	lfs 13,584(3)
	lwz 0,828(4)
	fmuls 13,13,0
	cmpwi 0,0,0
	stfs 13,620(4)
	lfs 0,588(3)
	lfs 13,572(3)
	fmuls 0,0,13
	stfs 0,624(4)
	bclr 12,2
	stw 9,828(4)
	lfs 0,592(3)
	stfs 0,628(4)
	blr
.Lfe23:
	.size	 trigger_monsterjump_touch,.Lfe23-trigger_monsterjump_touch
	.section	".rodata"
	.align 2
.LC50:
	.long 0x0
	.align 3
.LC51:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_trigger_monsterjump
	.type	 SP_trigger_monsterjump,@function
SP_trigger_monsterjump:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,.LC50@ha
	mr 31,3
	la 9,.LC50@l(9)
	lfs 0,572(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L158
	lis 0,0x4348
	stw 0,572(31)
.L158:
	lis 9,st@ha
	la 30,st@l(9)
	lwz 0,32(30)
	cmpwi 0,0,0
	bc 4,2,.L159
	li 0,200
	stw 0,32(30)
.L159:
	lfs 0,20(31)
	fcmpu 0,0,13
	bc 4,2,.L160
	lis 0,0x43b4
	stw 0,20(31)
.L160:
	addi 29,31,16
	lis 4,vec3_origin@ha
	la 4,vec3_origin@l(4)
	mr 3,29
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L161
	mr 3,29
	addi 4,31,584
	bl G_SetMovedir
.L161:
	li 29,1
	li 0,0
	lwz 4,272(31)
	lis 9,gi+44@ha
	stw 0,264(31)
	mr 3,31
	stw 29,248(31)
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	lis 9,trigger_monsterjump_touch@ha
	stw 29,184(31)
	la 9,trigger_monsterjump_touch@l(9)
	lis 10,0x4330
	stw 9,688(31)
	lwz 0,32(30)
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	xoris 0,0,0x8000
	lfd 13,0(9)
	stw 0,28(1)
	stw 10,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,592(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe24:
	.size	 SP_trigger_monsterjump,.Lfe24-SP_trigger_monsterjump
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
