	.file	"g_lightning.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 stuff_light,@object
	.size	 stuff_light,4
stuff_light:
	.long 1
	.section	".rodata"
	.align 2
.LC1:
	.string	"light_show_interval"
	.align 2
.LC2:
	.string	"60"
	.align 2
.LC4:
	.string	"daaaaaaaaaaaaaaaaaaa"
	.align 2
.LC5:
	.string	"faaaaaaaaaaaaaaaaaaa"
	.align 2
.LC6:
	.string	"daammeeaaaaaaaaaaaaa"
	.align 2
.LC7:
	.string	"daaaeaaaaaaaaaaaaaaa"
	.align 2
.LC8:
	.string	"zzzeeaaaaaaaaazzeeaa"
	.section	".text"
	.align 2
	.globl Set_Lightning_Effect
	.type	 Set_Lightning_Effect,@function
Set_Lightning_Effect:
	stwu 1,-48(1)
	mflr 0
	stw 31,44(1)
	stw 0,52(1)
	mr 31,3
	addi 10,31,-1
	cmplwi 0,10,4
	bc 12,1,.L21
	lis 11,.L22@ha
	slwi 10,10,2
	la 11,.L22@l(11)
	lis 9,.L22@ha
	lwzx 0,10,11
	la 9,.L22@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L22:
	.long .L21-.L22
	.long .L17-.L22
	.long .L18-.L22
	.long .L19-.L22
	.long .L20-.L22
.L17:
	lis 9,.LC5@ha
	addi 11,1,8
	lwz 5,.LC5@l(9)
	la 9,.LC5@l(9)
	b .L23
.L18:
	lis 9,.LC6@ha
	addi 11,1,8
	lwz 5,.LC6@l(9)
	la 9,.LC6@l(9)
	b .L23
.L19:
	lis 9,.LC7@ha
	addi 11,1,8
	lwz 5,.LC7@l(9)
	la 9,.LC7@l(9)
	b .L23
.L20:
	lis 9,.LC8@ha
	addi 11,1,8
	lwz 5,.LC8@l(9)
	la 9,.LC8@l(9)
	b .L23
.L21:
	lis 9,.LC4@ha
	addi 11,1,8
	lwz 5,.LC4@l(9)
	la 9,.LC4@l(9)
.L23:
	lbz 0,20(9)
	lwz 10,4(9)
	lwz 8,8(9)
	lwz 7,12(9)
	lwz 6,16(9)
	stw 5,8(1)
	stb 0,20(11)
	stw 10,4(11)
	stw 8,8(11)
	stw 7,12(11)
	stw 6,16(11)
	lis 9,gi+24@ha
	li 3,800
	lwz 0,gi+24@l(9)
	addi 4,1,8
	mtlr 0
	blrl
	lis 9,level+344@ha
	stw 31,level+344@l(9)
	lwz 0,52(1)
	mtlr 0
	lwz 31,44(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 Set_Lightning_Effect,.Lfe1-Set_Lightning_Effect
	.section	".rodata"
	.align 2
.LC9:
	.string	"a"
	.align 2
.LC11:
	.string	"world/battle1.wav"
	.align 2
.LC12:
	.string	"world/battle2.wav"
	.align 2
.LC13:
	.string	"world/battle3.wav"
	.align 2
.LC14:
	.string	"world/battle4.wav"
	.align 2
.LC15:
	.string	"world/battle5.wav"
	.align 2
.LC10:
	.long 0x461c3c00
	.align 2
.LC16:
	.long 0x0
	.align 2
.LC17:
	.long 0x3f800000
	.align 3
.LC18:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC19:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl Lightning_Off
	.type	 Lightning_Off,@function
Lightning_Off:
	stwu 1,-128(1)
	mflr 0
	stfd 31,120(1)
	stmw 25,92(1)
	stw 0,132(1)
	lis 11,.LC16@ha
	lis 9,enable_light_show@ha
	la 11,.LC16@l(11)
	lfs 31,0(11)
	lwz 11,enable_light_show@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L27
	lis 9,gi@ha
	lis 4,.LC9@ha
	la 31,gi@l(9)
	la 4,.LC9@l(4)
	lwz 9,24(31)
	li 3,800
	mtlr 9
	blrl
	lis 9,light_show_interval@ha
	lis 11,level+332@ha
	lwz 10,light_show_interval@l(9)
	li 0,0
	stw 0,level+332@l(11)
	lwz 9,16(10)
	cmpwi 0,9,0
	bc 12,2,.L29
	lfs 13,20(10)
	fcmpu 0,13,31
	bc 12,0,.L30
	lis 9,.LC10@ha
	lfs 0,.LC10@l(9)
	fcmpu 0,13,0
	bc 4,1,.L29
.L30:
	lwz 0,148(31)
	lis 3,.LC1@ha
	lis 4,.LC2@ha
	la 3,.LC1@l(3)
	la 4,.LC2@l(4)
	mtlr 0
	blrl
.L29:
	lis 11,light_show_interval@ha
	lwz 9,light_show_interval@l(11)
	li 3,1
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,80(1)
	lwz 4,84(1)
	bl nhrand
	lis 10,level@ha
	la 10,level@l(10)
	lfs 0,4(10)
	lwz 11,344(10)
	addi 0,11,-1
	cmplwi 0,0,4
	fctiwz 13,0
	stfd 13,80(1)
	lwz 9,84(1)
	add 9,9,3
	stw 9,340(10)
	bc 12,1,.L40
	lis 11,.L41@ha
	slwi 10,0,2
	la 11,.L41@l(11)
	lis 9,.L41@ha
	lwzx 0,10,11
	la 9,.L41@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L41:
	.long .L40-.L41
	.long .L36-.L41
	.long .L37-.L41
	.long .L38-.L41
	.long .L39-.L41
.L36:
	lis 9,.LC12@ha
	addi 11,1,8
	lwz 6,.LC12@l(9)
	la 9,.LC12@l(9)
	b .L48
.L37:
	lis 9,.LC13@ha
	addi 11,1,8
	lwz 6,.LC13@l(9)
	la 9,.LC13@l(9)
	b .L48
.L38:
	lis 9,.LC14@ha
	addi 11,1,8
	lwz 6,.LC14@l(9)
	la 9,.LC14@l(9)
	b .L48
.L39:
	lis 9,.LC15@ha
	addi 11,1,8
	lwz 6,.LC15@l(9)
	la 9,.LC15@l(9)
	b .L48
.L40:
	lis 9,.LC11@ha
	addi 11,1,8
	lwz 6,.LC11@l(9)
	la 9,.LC11@l(9)
.L48:
	lhz 0,16(9)
	lwz 10,4(9)
	lwz 8,8(9)
	lwz 7,12(9)
	stw 6,8(1)
	sth 0,16(11)
	stw 10,4(11)
	stw 8,8(11)
	stw 7,12(11)
	lis 11,.LC17@ha
	lis 9,maxclients@ha
	la 11,.LC17@l(11)
	li 29,1
	lfs 13,0(11)
	lis 25,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L27
	lis 9,gi@ha
	lis 26,g_edicts@ha
	la 28,gi@l(9)
	lis 27,0x4330
	lis 9,.LC18@ha
	li 30,952
	la 9,.LC18@l(9)
	lfd 31,0(9)
.L45:
	lwz 0,g_edicts@l(26)
	add. 31,0,30
	bc 12,2,.L44
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L44
	lwz 9,36(28)
	addi 3,1,8
	mtlr 9
	blrl
	lis 9,.LC17@ha
	lwz 11,16(28)
	mr 5,3
	la 9,.LC17@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 11
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfs 2,0(9)
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 3,0(9)
	blrl
.L44:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 30,30,952
	stw 0,84(1)
	stw 27,80(1)
	lfd 0,80(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L45
.L27:
	lwz 0,132(1)
	mtlr 0
	lmw 25,92(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe2:
	.size	 Lightning_Off,.Lfe2-Lightning_Off
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.section	".rodata"
	.align 2
.LC20:
	.long 0x461c3c00
	.align 2
.LC21:
	.long 0x0
	.section	".text"
	.align 2
	.globl validateLightShowInterval
	.type	 validateLightShowInterval,@function
validateLightShowInterval:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC21@ha
	lis 9,light_show_interval@ha
	la 11,.LC21@l(11)
	lfs 0,0(11)
	lwz 11,light_show_interval@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L8
	lis 9,.LC20@ha
	lfs 0,.LC20@l(9)
	fcmpu 0,13,0
	bc 4,1,.L7
.L8:
	lis 9,gi+148@ha
	lis 3,.LC1@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC2@ha
	la 3,.LC1@l(3)
	la 4,.LC2@l(4)
	mtlr 0
	blrl
.L7:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 validateLightShowInterval,.Lfe3-validateLightShowInterval
	.section	".rodata"
	.align 2
.LC22:
	.long 0x461c3c00
	.align 2
.LC23:
	.long 0x0
	.section	".text"
	.align 2
	.globl getLightShowInterval
	.type	 getLightShowInterval,@function
getLightShowInterval:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,light_show_interval@ha
	lwz 9,light_show_interval@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L10
	lfs 13,20(9)
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L11
	lis 9,.LC22@ha
	lfs 0,.LC22@l(9)
	fcmpu 0,13,0
	bc 4,1,.L10
.L11:
	lis 9,gi+148@ha
	lis 3,.LC1@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC2@ha
	la 3,.LC1@l(3)
	la 4,.LC2@l(4)
	mtlr 0
	blrl
.L10:
	lis 11,light_show_interval@ha
	lwz 9,light_show_interval@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 getLightShowInterval,.Lfe4-getLightShowInterval
	.section	".rodata"
	.align 2
.LC24:
	.long 0x0
	.section	".text"
	.align 2
	.globl Lightning_On
	.type	 Lightning_On,@function
Lightning_On:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,.LC24@ha
	lis 11,enable_light_show@ha
	la 9,.LC24@l(9)
	lfs 13,0(9)
	lwz 9,enable_light_show@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L24
	lis 9,level@ha
	la 31,level@l(9)
	lwz 0,332(31)
	cmpwi 0,0,0
	bc 4,2,.L24
	li 4,5
	li 3,1
	bl nhrand
	bl Set_Lightning_Effect
	lfs 0,4(31)
	li 0,1
	stw 0,332(31)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	addi 9,9,1
	stw 9,336(31)
.L24:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Lightning_On,.Lfe5-Lightning_On
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
