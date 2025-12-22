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
	lwz 0,528(31)
	cmpwi 0,0,1
	bc 4,2,.L37
	lis 9,gi+36@ha
	lis 3,.LC3@ha
	lwz 0,gi+36@l(9)
	la 3,.LC3@l(3)
	b .L46
.L37:
	cmpwi 0,0,2
	bc 4,2,.L39
	lis 9,gi+36@ha
	lis 3,.LC4@ha
	lwz 0,gi+36@l(9)
	la 3,.LC4@l(3)
	b .L46
.L39:
	cmpwi 0,0,3
	bc 4,2,.L38
	lis 9,gi@ha
	lis 3,.LC5@ha
	la 9,gi@l(9)
	la 3,.LC5@l(3)
	lwz 0,36(9)
.L46:
	mtlr 0
	blrl
	stw 3,576(31)
.L38:
	lis 8,.LC7@ha
	lfs 13,592(31)
	la 8,.LC7@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,2,.L42
	lis 9,.LC6@ha
	lfs 0,.LC6@l(9)
	stfs 0,592(31)
.L42:
	lwz 0,284(31)
	lis 9,Touch_Multi@ha
	li 10,0
	lwz 11,184(31)
	la 9,Touch_Multi@l(9)
	andi. 8,0,12
	stw 9,444(31)
	ori 11,11,1
	stw 10,260(31)
	stw 11,184(31)
	bc 12,2,.L43
	lis 9,trigger_enable@ha
	stw 10,248(31)
	la 9,trigger_enable@l(9)
	b .L47
.L43:
	lis 9,Use_Multi@ha
	li 0,1
	la 9,Use_Multi@l(9)
	stw 0,248(31)
.L47:
	stw 9,448(31)
	addi 29,31,16
	lis 4,vec3_origin@ha
	la 4,vec3_origin@l(4)
	mr 3,29
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L45
	mr 3,29
	addi 4,31,340
	bl G_SetMovedir
.L45:
	lis 29,gi@ha
	mr 3,31
	lwz 4,268(31)
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
	.align 3
.LC12:
	.long 0x40140000
	.long 0x0
	.align 2
.LC13:
	.long 0x3f800000
	.align 2
.LC14:
	.long 0x0
	.section	".text"
	.align 2
	.globl trigger_key_use
	.type	 trigger_key_use,@function
trigger_key_use:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	mr 31,5
	lwz 9,648(30)
	cmpwi 0,9,0
	bc 12,2,.L52
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L52
	lwz 4,20(9)
	mr 3,31
	bl CountItemByTag
	cmpwi 0,3,0
	bc 12,1,.L55
	lis 9,level+4@ha
	lfs 0,460(30)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L52
	lis 9,.LC12@ha
	fmr 0,13
	lis 29,gi@ha
	la 9,.LC12@l(9)
	la 29,gi@l(29)
	lfd 13,0(9)
	lis 4,.LC9@ha
	mr 3,31
	lwz 9,648(30)
	la 4,.LC9@l(4)
	fadd 0,0,13
	frsp 0,0
	stfs 0,460(30)
	lwz 5,16(9)
	lwz 9,12(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
	mtlr 9
	blrl
	lis 9,.LC13@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC13@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 2,0(9)
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 3,0(9)
	blrl
	b .L52
.L55:
	lis 29,gi@ha
	lis 3,.LC11@ha
	la 29,gi@l(29)
	la 3,.LC11@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC13@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC13@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 2,0(9)
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 3,0(9)
	blrl
	li 4,0
	li 8,0
	b .L57
.L59:
	addi 8,8,4
	addi 4,4,1
.L57:
	cmpwi 0,4,31
	bc 12,1,.L58
	lwz 9,84(31)
	lwz 10,648(30)
	addi 9,9,1848
	lwzx 11,9,8
	lwz 0,20(10)
	cmpw 0,11,0
	bc 4,2,.L59
	mr 3,31
	bl RemoveItem
.L58:
	mr 4,31
	mr 3,30
	bl G_UseTargets
	li 0,0
	stw 0,448(30)
.L52:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 trigger_key_use,.Lfe2-trigger_key_use
	.section	".rodata"
	.align 2
.LC15:
	.string	"no key item for trigger_key at %s\n"
	.align 2
.LC16:
	.string	"item %s not found for trigger_key at %s\n"
	.align 2
.LC17:
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
	bc 4,2,.L64
	lis 29,gi@ha
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L63
.L64:
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,648(31)
	bc 4,2,.L65
	lis 29,gi@ha
	lwz 28,44(28)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC16@ha
	la 3,.LC16@l(3)
	b .L67
.L65:
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L66
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC17@ha
	la 3,.LC17@l(3)
.L67:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L63
.L66:
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
	stw 9,448(31)
.L63:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 SP_trigger_key,.Lfe3-SP_trigger_key
	.section	".rodata"
	.align 2
.LC18:
	.string	"%i more to go..."
	.align 2
.LC19:
	.string	"misc/talk1.wav"
	.align 2
.LC20:
	.string	"Sequence completed!"
	.align 3
.LC21:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC22:
	.long 0x3f800000
	.align 2
.LC23:
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
	lwz 5,532(31)
	cmpwi 0,5,0
	bc 12,2,.L68
	addi 28,5,-1
	cmpwi 0,28,0
	stw 28,532(31)
	bc 12,2,.L70
	lwz 0,284(31)
	andi. 9,0,1
	bc 4,2,.L68
	lis 29,gi@ha
	lis 4,.LC18@ha
	la 29,gi@l(29)
	la 4,.LC18@l(4)
	lwz 9,12(29)
	mr 5,28
	mr 3,30
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	mtlr 9
	blrl
	lis 9,.LC22@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC22@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 2,0(9)
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 3,0(9)
	blrl
	b .L68
.L70:
	lwz 0,284(31)
	andi. 9,0,1
	bc 4,2,.L72
	lis 29,gi@ha
	lis 4,.LC20@ha
	la 29,gi@l(29)
	la 4,.LC20@l(4)
	lwz 9,12(29)
	mr 3,30
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	mtlr 9
	blrl
	lis 9,.LC22@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC22@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 2,0(9)
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 3,0(9)
	blrl
.L72:
	lis 9,.LC23@ha
	lfs 0,428(31)
	la 9,.LC23@l(9)
	stw 30,548(31)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L68
	mr 4,30
	mr 3,31
	bl G_UseTargets
	lfs 13,592(31)
	fcmpu 0,13,31
	bc 4,1,.L75
	lis 9,multi_wait@ha
	lis 11,level+4@ha
	la 9,multi_wait@l(9)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	b .L77
.L75:
	stw 28,444(31)
	lis 11,level+4@ha
	lis 10,.LC21@ha
	lfs 0,level+4@l(11)
	lis 9,G_FreeEdict@ha
	lfd 13,.LC21@l(10)
	la 9,G_FreeEdict@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
.L77:
	stfs 0,428(31)
.L68:
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
.LC26:
	.string	"misc/windfly.wav"
	.align 2
.LC27:
	.string	"trigger_push is START_OFF but not targeted.\n"
	.align 2
.LC28:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_trigger_push
	.type	 SP_trigger_push,@function
SP_trigger_push:
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
	bc 4,2,.L90
	mr 3,29
	addi 4,31,340
	bl G_SetMovedir
.L90:
	li 29,1
	lis 9,gi@ha
	lwz 4,268(31)
	li 28,0
	la 30,gi@l(9)
	stw 29,248(31)
	stw 28,260(31)
	mr 3,31
	lwz 9,44(30)
	mtlr 9
	blrl
	stw 29,184(31)
	lis 3,.LC26@ha
	lwz 9,36(30)
	la 3,.LC26@l(3)
	mtlr 9
	blrl
	lis 9,.LC28@ha
	lfs 13,328(31)
	lis 11,windsound@ha
	la 9,.LC28@l(9)
	stw 3,windsound@l(11)
	lfs 0,0(9)
	lis 9,trigger_push_touch@ha
	la 9,trigger_push_touch@l(9)
	fcmpu 0,13,0
	stw 9,444(31)
	bc 4,2,.L92
	lis 0,0x447a
	stw 0,328(31)
.L92:
	lwz 29,300(31)
	cmpwi 0,29,0
	bc 12,2,.L93
	lwz 0,284(31)
	lis 9,trigger_push_use@ha
	la 9,trigger_push_use@l(9)
	andi. 11,0,2
	stw 9,448(31)
	bc 12,2,.L95
	stw 28,248(31)
	b .L95
.L93:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L95
	lwz 0,4(30)
	lis 3,.LC27@ha
	la 3,.LC27@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,3
	li 9,2
	stw 29,444(31)
	stw 0,248(31)
	stw 9,260(31)
	stw 29,184(31)
.L95:
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
.Lfe5:
	.size	 SP_trigger_push,.Lfe5-SP_trigger_push
	.section	".rodata"
	.align 2
.LC30:
	.string	"world/electro.wav"
	.align 2
.LC31:
	.string	"trigger_gravity without gravity set at %s\n"
	.section	".text"
	.align 2
	.globl SP_trigger_gravity
	.type	 SP_trigger_gravity,@function
SP_trigger_gravity:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,st@ha
	mr 31,3
	la 28,st@l(9)
	lwz 0,48(28)
	cmpwi 0,0,0
	bc 4,2,.L122
	lis 29,gi@ha
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC31@ha
	la 3,.LC31@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L121
.L122:
	addi 29,31,16
	lis 4,vec3_origin@ha
	la 4,vec3_origin@l(4)
	mr 3,29
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L123
	mr 3,29
	addi 4,31,340
	bl G_SetMovedir
.L123:
	li 29,1
	lis 9,gi@ha
	lwz 4,268(31)
	li 30,0
	stw 29,248(31)
	la 27,gi@l(9)
	stw 30,260(31)
	mr 3,31
	lwz 9,44(27)
	mtlr 9
	blrl
	stw 29,184(31)
	lwz 3,48(28)
	bl atof
	lwz 0,284(31)
	frsp 1,1
	andi. 9,0,1
	stfs 1,408(31)
	bc 12,2,.L125
	lis 9,trigger_gravity_use@ha
	la 9,trigger_gravity_use@l(9)
	stw 9,448(31)
.L125:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L126
	lis 9,trigger_gravity_use@ha
	stw 30,248(31)
	la 9,trigger_gravity_use@l(9)
	stw 9,448(31)
.L126:
	lis 9,trigger_gravity_touch@ha
	mr 3,31
	la 9,trigger_gravity_touch@l(9)
	stw 9,444(31)
	lwz 0,72(27)
	mtlr 0
	blrl
.L121:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 SP_trigger_gravity,.Lfe6-SP_trigger_gravity
	.section	".rodata"
	.align 2
.LC32:
	.long 0x43800000
	.section	".text"
	.align 2
	.globl touchent_setup
	.type	 touchent_setup,@function
touchent_setup:
	stwu 1,-160(1)
	mflr 0
	stfd 31,152(1)
	stmw 26,128(1)
	stw 0,164(1)
	lis 9,.LC32@ha
	mr 29,3
	la 9,.LC32@l(9)
	lis 28,gi@ha
	lfs 0,12(29)
	la 28,gi@l(28)
	lfs 31,0(9)
	addi 26,1,72
	lwz 11,48(28)
	addi 27,29,4
	addi 3,1,8
	lfs 13,4(29)
	mr 4,27
	li 5,0
	lfs 12,8(29)
	fadds 0,0,31
	mtlr 11
	li 6,0
	mr 7,26
	mr 8,29
	li 9,3
	li 0,0
	stfs 13,72(1)
	stfs 12,76(1)
	stw 0,104(1)
	stfs 0,80(1)
	stw 0,96(1)
	stw 0,92(1)
	stw 0,88(1)
	stw 0,112(1)
	stw 0,108(1)
	blrl
	lfs 0,12(29)
	addi 3,1,8
	mr 4,27
	lfs 13,28(1)
	li 5,0
	li 6,0
	lwz 11,48(28)
	mr 7,26
	mr 8,29
	fsubs 11,0,31
	lfs 12,8(29)
	li 9,3
	fsubs 13,13,0
	mtlr 11
	lfs 0,4(29)
	stfs 12,76(1)
	stfs 13,112(1)
	stfs 0,72(1)
	stfs 11,80(1)
	blrl
	lfs 11,12(29)
	addi 3,1,8
	mr 4,27
	lfs 0,8(29)
	li 5,0
	li 6,0
	lfs 13,28(1)
	mr 7,26
	mr 8,29
	lwz 11,48(28)
	li 9,3
	lfs 12,4(29)
	fadds 0,0,31
	fsubs 13,13,11
	mtlr 11
	stfs 11,80(1)
	stfs 12,72(1)
	stfs 13,96(1)
	stfs 0,76(1)
	blrl
	lfs 0,8(29)
	addi 3,1,8
	mr 4,27
	lfs 13,24(1)
	li 5,0
	li 6,0
	lwz 11,48(28)
	mr 7,26
	mr 8,29
	fsubs 11,0,31
	lfs 12,12(29)
	li 9,3
	fsubs 13,13,0
	mtlr 11
	lfs 0,4(29)
	stfs 12,80(1)
	stfs 13,108(1)
	stfs 0,72(1)
	stfs 11,76(1)
	blrl
	lfs 11,8(29)
	addi 3,1,8
	mr 4,27
	lfs 0,4(29)
	li 5,0
	li 6,0
	lfs 13,24(1)
	mr 7,26
	mr 8,29
	lwz 11,48(28)
	li 9,3
	lfs 12,12(29)
	fadds 0,0,31
	fsubs 13,13,11
	mtlr 11
	stfs 11,76(1)
	stfs 12,80(1)
	stfs 13,92(1)
	stfs 0,72(1)
	blrl
	lfs 0,4(29)
	addi 3,1,8
	mr 4,27
	lfs 13,20(1)
	mr 7,26
	li 5,0
	lwz 11,48(28)
	li 6,0
	mr 8,29
	fsubs 31,0,31
	lfs 12,12(29)
	li 9,3
	fsubs 13,13,0
	mtlr 11
	lfs 0,8(29)
	stfs 12,80(1)
	stfs 13,104(1)
	stfs 0,76(1)
	stfs 31,72(1)
	blrl
	lfs 13,20(1)
	mr 3,29
	lfs 0,4(29)
	lfs 9,92(1)
	lfs 12,96(1)
	fsubs 13,13,0
	lfs 11,108(1)
	lfs 0,104(1)
	lfs 10,112(1)
	stfs 13,188(29)
	stfs 9,192(29)
	stfs 12,196(29)
	stfs 0,200(29)
	stfs 11,204(29)
	stfs 10,208(29)
	lwz 0,72(28)
	stfs 13,88(1)
	mtlr 0
	blrl
	lwz 0,164(1)
	mtlr 0
	lmw 26,128(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe7:
	.size	 touchent_setup,.Lfe7-touchent_setup
	.section	".rodata"
	.align 2
.LC34:
	.string	"models/items/c_head/tris.md2"
	.align 2
.LC33:
	.long 0x3e4ccccd
	.align 3
.LC35:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC36:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_touchent_multiple
	.type	 SP_touchent_multiple,@function
SP_touchent_multiple:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,528(31)
	cmpwi 0,0,1
	bc 4,2,.L141
	lis 9,gi+36@ha
	lis 3,.LC3@ha
	lwz 0,gi+36@l(9)
	la 3,.LC3@l(3)
	b .L150
.L141:
	cmpwi 0,0,2
	bc 4,2,.L143
	lis 9,gi+36@ha
	lis 3,.LC4@ha
	lwz 0,gi+36@l(9)
	la 3,.LC4@l(3)
	b .L150
.L143:
	cmpwi 0,0,3
	bc 4,2,.L142
	lis 9,gi@ha
	lis 3,.LC5@ha
	la 9,gi@l(9)
	la 3,.LC5@l(3)
	lwz 0,36(9)
.L150:
	mtlr 0
	blrl
	stw 3,576(31)
.L142:
	lis 8,.LC36@ha
	lfs 13,592(31)
	la 8,.LC36@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,2,.L146
	lis 9,.LC33@ha
	lfs 0,.LC33@l(9)
	stfs 0,592(31)
.L146:
	lwz 0,284(31)
	lis 9,Touch_Multi@ha
	li 10,0
	lwz 11,184(31)
	la 9,Touch_Multi@l(9)
	andi. 8,0,12
	stw 9,444(31)
	ori 11,11,1
	stw 10,260(31)
	stw 11,184(31)
	bc 12,2,.L147
	lis 9,trigger_enable@ha
	stw 10,248(31)
	la 9,trigger_enable@l(9)
	b .L151
.L147:
	lis 9,Use_Multi@ha
	li 0,1
	la 9,Use_Multi@l(9)
	stw 0,248(31)
.L151:
	stw 9,448(31)
	addi 29,31,16
	lis 4,vec3_origin@ha
	la 4,vec3_origin@l(4)
	mr 3,29
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L149
	mr 3,29
	addi 4,31,340
	bl G_SetMovedir
.L149:
	lis 29,gi@ha
	lis 4,.LC34@ha
	la 29,gi@l(29)
	mr 3,31
	lwz 9,44(29)
	la 4,.LC34@l(4)
	mtlr 9
	blrl
	lis 9,touchent_setup@ha
	lis 10,level+4@ha
	la 9,touchent_setup@l(9)
	lis 11,.LC35@ha
	stw 9,436(31)
	mr 3,31
	lfs 0,level+4@l(10)
	lfd 13,.LC35@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 SP_touchent_multiple,.Lfe8-SP_touchent_multiple
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
	addi 4,31,340
	bl G_SetMovedir
.L7:
	li 29,1
	li 0,0
	lwz 4,268(31)
	stw 0,260(31)
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
.Lfe9:
	.size	 InitTrigger,.Lfe9-InitTrigger
	.align 2
	.globl multi_wait
	.type	 multi_wait,@function
multi_wait:
	li 0,0
	stw 0,428(3)
	blr
.Lfe10:
	.size	 multi_wait,.Lfe10-multi_wait
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
	.globl multi_trigger
	.type	 multi_trigger,@function
multi_trigger:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 31,20(1)
	stw 0,36(1)
	lis 9,.LC38@ha
	mr 31,3
	la 9,.LC38@l(9)
	lfs 0,428(31)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L9
	lwz 4,548(31)
	bl G_UseTargets
	lfs 13,592(31)
	fcmpu 0,13,31
	bc 4,1,.L11
	lis 9,multi_wait@ha
	lis 11,level+4@ha
	la 9,multi_wait@l(9)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	b .L153
.L11:
	li 0,0
	lis 11,level+4@ha
	stw 0,444(31)
	lis 10,.LC37@ha
	lis 9,G_FreeEdict@ha
	lfs 0,level+4@l(11)
	la 9,G_FreeEdict@l(9)
	lfd 13,.LC37@l(10)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
.L153:
	stfs 0,428(31)
.L9:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 multi_trigger,.Lfe11-multi_trigger
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
	.globl Use_Multi
	.type	 Use_Multi,@function
Use_Multi:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	mr 31,3
	mr 4,5
	lwz 0,284(31)
	andi. 30,0,8
	bc 12,2,.L14
	lwz 0,248(31)
	cmpwi 0,0,1
	li 0,1
	bc 4,2,.L15
	li 0,0
.L15:
	stw 0,248(31)
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	b .L17
.L14:
	lis 9,.LC40@ha
	lfs 0,428(31)
	la 9,.LC40@l(9)
	stw 4,548(31)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L17
	mr 3,31
	bl G_UseTargets
	lfs 13,592(31)
	fcmpu 0,13,31
	bc 4,1,.L20
	lis 9,multi_wait@ha
	lis 11,level+4@ha
	la 9,multi_wait@l(9)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	b .L155
.L20:
	stw 30,444(31)
	lis 11,level+4@ha
	lis 10,.LC39@ha
	lfs 0,level+4@l(11)
	lis 9,G_FreeEdict@ha
	lfd 13,.LC39@l(10)
	la 9,G_FreeEdict@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
.L155:
	stfs 0,428(31)
.L17:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 Use_Multi,.Lfe12-Use_Multi
	.section	".rodata"
	.align 3
.LC41:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC42:
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
	bc 12,2,.L23
	lwz 0,284(31)
	andi. 9,0,2
	bc 4,2,.L22
	b .L25
.L23:
	lwz 0,184(30)
	andi. 9,0,4
	bc 12,2,.L22
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L22
.L25:
	addi 29,31,340
	lis 4,vec3_origin@ha
	la 4,vec3_origin@l(4)
	mr 3,29
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L29
	addi 4,1,8
	addi 3,30,16
	li 5,0
	li 6,0
	bl AngleVectors
	mr 4,29
	addi 3,1,8
	bl _DotProduct
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L22
.L29:
	lis 9,.LC42@ha
	lfs 0,428(31)
	la 9,.LC42@l(9)
	stw 30,548(31)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L22
	mr 4,30
	mr 3,31
	bl G_UseTargets
	lfs 13,592(31)
	fcmpu 0,13,31
	bc 4,1,.L33
	lis 9,multi_wait@ha
	lis 11,level+4@ha
	la 9,multi_wait@l(9)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	b .L156
.L33:
	li 0,0
	lis 11,level+4@ha
	stw 0,444(31)
	lis 10,.LC41@ha
	lis 9,G_FreeEdict@ha
	lfs 0,level+4@l(11)
	la 9,G_FreeEdict@l(9)
	lfd 13,.LC41@l(10)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
.L156:
	stfs 0,428(31)
.L22:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 Touch_Multi,.Lfe13-Touch_Multi
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
	stw 11,448(9)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 trigger_enable,.Lfe14-trigger_enable
	.section	".rodata"
	.align 2
.LC43:
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
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L49
	lis 9,.LC43@ha
	addi 4,31,236
	la 9,.LC43@l(9)
	addi 5,1,8
	lfs 1,0(9)
	addi 3,31,188
	bl VectorMA
	lwz 0,284(31)
	lis 29,gi@ha
	addi 3,1,8
	la 29,gi@l(29)
	lwz 28,280(31)
	rlwinm 0,0,0,0,30
	ori 0,0,4
	stw 0,284(31)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC8@ha
	la 3,.LC8@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L49:
	lis 0,0xbf80
	mr 3,31
	stw 0,592(31)
	bl SP_trigger_multiple
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 SP_trigger_once,.Lfe15-SP_trigger_once
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
.Lfe16:
	.size	 trigger_relay_use,.Lfe16-trigger_relay_use
	.align 2
	.globl SP_trigger_relay
	.type	 SP_trigger_relay,@function
SP_trigger_relay:
	lis 9,trigger_relay_use@ha
	la 9,trigger_relay_use@l(9)
	stw 9,448(3)
	blr
.Lfe17:
	.size	 SP_trigger_relay,.Lfe17-SP_trigger_relay
	.align 2
	.globl SP_trigger_counter
	.type	 SP_trigger_counter,@function
SP_trigger_counter:
	lwz 9,532(3)
	lis 0,0xbf80
	stw 0,592(3)
	cmpwi 0,9,0
	bc 4,2,.L79
	li 0,2
	stw 0,532(3)
.L79:
	lis 9,trigger_counter_use@ha
	la 9,trigger_counter_use@l(9)
	stw 9,448(3)
	blr
.Lfe18:
	.size	 SP_trigger_counter,.Lfe18-SP_trigger_counter
	.section	".rodata"
	.align 3
.LC44:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC45:
	.long 0x3e4ccccd
	.section	".text"
	.align 2
	.globl SP_trigger_always
	.type	 SP_trigger_always,@function
SP_trigger_always:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lfs 0,596(3)
	lis 9,.LC44@ha
	lfd 13,.LC44@l(9)
	fcmpu 0,0,13
	bc 4,0,.L81
	lis 9,.LC45@ha
	lfs 0,.LC45@l(9)
	stfs 0,596(3)
.L81:
	mr 4,3
	bl G_UseTargets
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 SP_trigger_always,.Lfe19-SP_trigger_always
	.section	".sbss","aw",@nobits
	.align 2
windsound:
	.space	4
	.size	 windsound,4
	.section	".rodata"
	.align 2
.LC46:
	.long 0x41200000
	.align 3
.LC47:
	.long 0x3ff80000
	.long 0x0
	.align 2
.LC48:
	.long 0x3f800000
	.align 2
.LC49:
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
	lis 9,.LC46@ha
	mr 30,3
	la 9,.LC46@l(9)
	lfs 1,328(30)
	mr 31,4
	lfs 0,0(9)
	addi 3,30,340
	addi 4,31,376
	fmuls 1,1,0
	bl VectorScale
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L83
	lfs 0,376(31)
	stfs 0,4760(9)
	lfs 0,380(31)
	lwz 9,84(31)
	stfs 0,4764(9)
	lfs 0,384(31)
	lwz 11,84(31)
	stfs 0,4768(11)
	lwz 0,284(30)
	andi. 9,0,4
	bc 4,2,.L83
	lis 9,level+4@ha
	lfs 0,472(31)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L83
	lis 9,.LC47@ha
	fmr 0,13
	lis 11,gi+16@ha
	la 9,.LC47@l(9)
	mr 3,31
	lfd 13,0(9)
	li 4,0
	lis 9,windsound@ha
	lwz 5,windsound@l(9)
	fadd 0,0,13
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfs 1,0(9)
	frsp 0,0
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfs 2,0(9)
	stfs 0,472(31)
	lis 9,.LC49@ha
	lwz 0,gi+16@l(11)
	la 9,.LC49@l(9)
	lfs 3,0(9)
	mtlr 0
	blrl
.L83:
	lwz 0,284(30)
	andi. 9,0,1
	bc 12,2,.L85
	mr 3,30
	bl G_FreeEdict
.L85:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe20:
	.size	 trigger_push_touch,.Lfe20-trigger_push_touch
	.align 2
	.globl trigger_push_use
	.type	 trigger_push_use,@function
trigger_push_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,248(3)
	cmpwi 0,0,0
	li 0,0
	bc 4,2,.L87
	li 0,1
.L87:
	stw 0,248(3)
	lis 9,gi+72@ha
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 trigger_push_use,.Lfe21-trigger_push_use
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
	bc 4,2,.L98
	li 0,1
.L98:
	stw 0,248(31)
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,284(31)
	andi. 0,0,2
	bc 4,2,.L100
	stw 0,448(31)
.L100:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe22:
	.size	 hurt_use,.Lfe22-hurt_use
	.section	".rodata"
	.align 3
.LC50:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC51:
	.long 0x3f800000
	.align 2
.LC52:
	.long 0x0
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
	lwz 0,512(30)
	cmpwi 0,0,0
	bc 12,2,.L101
	lis 9,level+4@ha
	lfs 0,288(31)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 12,1,.L101
	lwz 0,284(31)
	andi. 9,0,16
	bc 12,2,.L104
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L159
.L104:
	fmr 0,13
	lis 9,.LC50@ha
	lfd 13,.LC50@l(9)
	fadd 0,0,13
	frsp 0,0
.L159:
	stfs 0,288(31)
	lwz 0,284(31)
	andi. 9,0,4
	bc 4,2,.L106
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
	bc 4,2,.L106
	lis 9,gi+16@ha
	mr 3,30
	lwz 5,576(31)
	lwz 0,gi+16@l(9)
	li 4,0
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 2,0(9)
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 3,0(9)
	blrl
.L106:
	lwz 0,284(31)
	lis 6,vec3_origin@ha
	mr 3,30
	lwz 9,516(31)
	mr 4,31
	la 6,vec3_origin@l(6)
	rlwinm 0,0,2,26,26
	li 11,31
	stw 0,8(1)
	mr 5,4
	addi 7,3,4
	stw 11,12(1)
	mr 8,6
	mr 10,9
	bl T_Damage
.L101:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 hurt_touch,.Lfe23-hurt_touch
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
	bc 4,2,.L111
	mr 3,29
	addi 4,31,340
	bl G_SetMovedir
.L111:
	li 30,1
	li 28,0
	lwz 4,268(31)
	lis 29,gi@ha
	stw 30,248(31)
	mr 3,31
	la 29,gi@l(29)
	stw 28,260(31)
	lwz 9,44(29)
	mtlr 9
	blrl
	stw 30,184(31)
	lis 3,.LC30@ha
	lwz 0,36(29)
	la 3,.LC30@l(3)
	mtlr 0
	blrl
	lwz 0,516(31)
	lis 9,hurt_touch@ha
	la 9,hurt_touch@l(9)
	stw 3,576(31)
	cmpwi 0,0,0
	stw 9,444(31)
	bc 4,2,.L113
	li 0,5
	stw 0,516(31)
.L113:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L114
	stw 28,248(31)
	b .L115
.L114:
	stw 30,248(31)
.L115:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L116
	lis 9,hurt_use@ha
	la 9,hurt_use@l(9)
	stw 9,448(31)
.L116:
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
.Lfe24:
	.size	 SP_trigger_hurt,.Lfe24-SP_trigger_hurt
	.align 2
	.globl trigger_gravity_use
	.type	 trigger_gravity_use,@function
trigger_gravity_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,248(3)
	cmpwi 0,0,0
	li 0,0
	bc 4,2,.L118
	li 0,1
.L118:
	stw 0,248(3)
	lis 9,gi+72@ha
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe25:
	.size	 trigger_gravity_use,.Lfe25-trigger_gravity_use
	.align 2
	.globl trigger_gravity_touch
	.type	 trigger_gravity_touch,@function
trigger_gravity_touch:
	lfs 0,408(3)
	stfs 0,408(4)
	blr
.Lfe26:
	.size	 trigger_gravity_touch,.Lfe26-trigger_gravity_touch
	.align 2
	.globl trigger_monsterjump_touch
	.type	 trigger_monsterjump_touch,@function
trigger_monsterjump_touch:
	lwz 0,264(4)
	andi. 9,0,3
	bclr 4,2
	lwz 0,184(4)
	andi. 9,0,2
	bclr 4,2
	andi. 11,0,4
	bclr 12,2
	lfs 0,328(3)
	lfs 13,340(3)
	lwz 0,552(4)
	fmuls 13,13,0
	cmpwi 0,0,0
	stfs 13,376(4)
	lfs 0,344(3)
	lfs 13,328(3)
	fmuls 0,0,13
	stfs 0,380(4)
	bclr 12,2
	stw 9,552(4)
	lfs 0,348(3)
	stfs 0,384(4)
	blr
.Lfe27:
	.size	 trigger_monsterjump_touch,.Lfe27-trigger_monsterjump_touch
	.section	".rodata"
	.align 2
.LC53:
	.long 0x0
	.align 3
.LC54:
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
	lis 9,.LC53@ha
	mr 31,3
	la 9,.LC53@l(9)
	lfs 0,328(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L133
	lis 0,0x4348
	stw 0,328(31)
.L133:
	lis 9,st@ha
	la 30,st@l(9)
	lwz 0,32(30)
	cmpwi 0,0,0
	bc 4,2,.L134
	li 0,200
	stw 0,32(30)
.L134:
	lfs 0,20(31)
	fcmpu 0,0,13
	bc 4,2,.L135
	lis 0,0x43b4
	stw 0,20(31)
.L135:
	addi 29,31,16
	lis 4,vec3_origin@ha
	la 4,vec3_origin@l(4)
	mr 3,29
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L136
	mr 3,29
	addi 4,31,340
	bl G_SetMovedir
.L136:
	li 29,1
	li 0,0
	lwz 4,268(31)
	lis 9,gi+44@ha
	stw 0,260(31)
	mr 3,31
	stw 29,248(31)
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	lis 9,trigger_monsterjump_touch@ha
	stw 29,184(31)
	la 9,trigger_monsterjump_touch@l(9)
	lis 10,0x4330
	stw 9,444(31)
	lwz 0,32(30)
	lis 9,.LC54@ha
	la 9,.LC54@l(9)
	xoris 0,0,0x8000
	lfd 13,0(9)
	stw 0,28(1)
	stw 10,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,348(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe28:
	.size	 SP_trigger_monsterjump,.Lfe28-SP_trigger_monsterjump
	.align 2
	.globl InitWannaBeTrigger
	.type	 InitWannaBeTrigger,@function
InitWannaBeTrigger:
	li 9,1
	li 0,0
	stw 9,184(3)
	stw 0,260(3)
	stw 9,248(3)
	blr
.Lfe29:
	.size	 InitWannaBeTrigger,.Lfe29-InitWannaBeTrigger
	.align 2
	.globl SP_touchent_once
	.type	 SP_touchent_once,@function
SP_touchent_once:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 0,0xbf80
	stw 0,592(3)
	bl SP_touchent_multiple
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 SP_touchent_once,.Lfe30-SP_touchent_once
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
