	.file	"flashlight.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 stuff_light,@object
	.size	 stuff_light,4
stuff_light:
	.long 1
	.section	".rodata"
	.align 2
.LC0:
	.string	"world/spark1.wav"
	.align 2
.LC1:
	.string	"world/spark3.wav"
	.align 2
.LC2:
	.string	"flashlight"
	.align 2
.LC3:
	.string	"sprites/s_bubble.sp2"
	.align 3
.LC4:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC5:
	.long 0x3f800000
	.align 2
.LC6:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_Flashlight
	.type	 SP_Flashlight,@function
SP_Flashlight:
	stwu 1,-96(1)
	mflr 0
	stmw 28,80(1)
	stw 0,100(1)
	mr 31,3
	lwz 0,912(31)
	cmpwi 0,0,0
	bc 4,2,.L8
	lwz 0,932(31)
	cmpwi 0,0,0
	bc 4,2,.L8
	lwz 29,492(31)
	cmpwi 0,29,0
	bc 4,2,.L8
	lwz 30,892(31)
	cmpwi 0,30,0
	bc 12,2,.L12
	mr 3,30
	bl G_FreeEdict
	lwz 0,896(31)
	stw 29,892(31)
	cmpwi 0,0,0
	bc 4,2,.L8
	lis 29,gi@ha
	lis 3,.LC0@ha
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC5@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC5@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 2,0(9)
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 3,0(9)
	blrl
	b .L8
.L12:
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 4,2,.L14
	lis 29,gi@ha
	lis 3,.LC1@ha
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC5@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC5@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 2,0(9)
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 3,0(9)
	blrl
.L14:
	lwz 3,84(31)
	addi 29,1,24
	addi 28,1,40
	mr 4,29
	mr 5,28
	addi 3,3,3652
	li 6,0
	bl AngleVectors
	li 9,0
	lis 0,0x42c8
	stw 9,64(1)
	addi 7,1,8
	mr 5,29
	stw 0,56(1)
	mr 6,28
	addi 4,1,56
	stw 9,60(1)
	addi 3,31,4
	bl G_ProjectSource
	bl G_Spawn
	stw 3,892(31)
	li 0,1
	lis 10,.LC2@ha
	stw 31,256(3)
	la 10,.LC2@l(10)
	lis 8,gi+32@ha
	lwz 11,892(31)
	lis 3,.LC3@ha
	la 3,.LC3@l(3)
	stw 0,260(11)
	lwz 9,892(31)
	stw 30,248(9)
	lwz 11,892(31)
	stw 10,280(11)
	lwz 0,gi+32@l(8)
	mtlr 0
	blrl
	lwz 9,892(31)
	stw 3,40(9)
	lwz 11,892(31)
	stw 30,60(11)
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L15
	lwz 9,892(31)
	lis 0,0x8
	b .L17
.L15:
	lwz 9,892(31)
	lwz 0,64(9)
	ori 0,0,128
.L17:
	stw 0,64(9)
	lwz 8,892(31)
	lis 9,.LC4@ha
	lis 10,FlashlightThink@ha
	lfd 13,.LC4@l(9)
	la 10,FlashlightThink@l(10)
	lis 7,level+4@ha
	lwz 0,68(8)
	ori 0,0,32
	stw 0,68(8)
	lwz 11,892(31)
	lwz 0,68(11)
	ori 0,0,8
	stw 0,68(11)
	lwz 9,892(31)
	stw 10,436(9)
	lfs 0,level+4@l(7)
	lwz 9,892(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(9)
.L8:
	lwz 0,100(1)
	mtlr 0
	lmw 28,80(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 SP_Flashlight,.Lfe1-SP_Flashlight
	.section	".rodata"
	.align 3
.LC7:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC8:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC9:
	.long 0x46000000
	.align 2
.LC10:
	.long 0x3f800000
	.align 2
.LC11:
	.long 0xc0800000
	.section	".text"
	.align 2
	.globl FlashlightThink
	.type	 FlashlightThink,@function
FlashlightThink:
	stwu 1,-208(1)
	mflr 0
	stmw 28,192(1)
	stw 0,212(1)
	mr 31,3
	addi 30,1,72
	lwz 9,256(31)
	addi 29,1,88
	addi 28,1,24
	addi 6,1,104
	mr 4,30
	lwz 3,84(9)
	mr 5,29
	addi 3,3,3652
	bl AngleVectors
	lwz 3,256(31)
	lis 9,0x40c0
	lis 0,0x41c0
	stw 9,60(1)
	addi 7,1,8
	lis 9,.LC8@ha
	stw 0,56(1)
	addi 4,1,56
	la 9,.LC8@l(9)
	lis 0,0x4330
	lfd 13,0(9)
	mr 6,29
	mr 5,30
	lwz 9,508(3)
	addi 3,3,4
	addi 9,9,-7
	xoris 9,9,0x8000
	stw 9,188(1)
	stw 0,184(1)
	lfd 0,184(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	bl G_ProjectSource
	lis 9,.LC9@ha
	addi 3,1,8
	la 9,.LC9@l(9)
	mr 4,30
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 8,256(31)
	lwz 0,gi+48@l(11)
	ori 9,9,1
	mr 7,28
	addi 3,1,120
	addi 4,1,8
	li 5,0
	li 6,0
	mtlr 0
	blrl
	lis 9,.LC10@ha
	lfs 13,128(1)
	la 9,.LC10@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L19
	lis 11,.LC11@ha
	mr 4,30
	la 11,.LC11@l(11)
	addi 3,1,132
	lfs 1,0(11)
	addi 5,1,40
	bl VectorMA
	lfs 0,40(1)
	lfs 13,44(1)
	lfs 12,48(1)
	stfs 0,132(1)
	stfs 13,136(1)
	stfs 12,140(1)
.L19:
	lwz 9,172(1)
	lwz 0,184(9)
	andi. 11,0,4
	bc 4,2,.L21
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L20
.L21:
	lwz 0,512(9)
	cmpwi 0,0,0
	bc 12,2,.L23
	lwz 0,256(31)
	cmpw 0,9,0
	bc 12,2,.L23
	li 0,1
.L20:
	stw 0,60(31)
.L23:
	addi 3,1,144
	addi 4,31,16
	bl vectoangles
	lfs 0,136(1)
	lis 9,gi+72@ha
	mr 3,31
	lfs 13,140(1)
	lfs 12,132(1)
	stfs 0,8(31)
	stfs 13,12(31)
	stfs 12,4(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC7@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC7@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,212(1)
	mtlr 0
	lmw 28,192(1)
	la 1,208(1)
	blr
.Lfe2:
	.size	 FlashlightThink,.Lfe2-FlashlightThink
	.section	".rodata"
	.align 2
.LC12:
	.string	"xv 32 yv 8 picn help "
	.align 2
.LC13:
	.string	"nhunters/motd.txt"
	.align 2
.LC14:
	.string	"r"
	.align 2
.LC15:
	.string	"Night Hunters %s\nhttp://nhunters.gameplex.net\n- - - - - - - - - - - - - -\n%s"
	.align 2
.LC16:
	.string	"1.51"
	.align 2
.LC17:
	.string	"Night Hunters %s\nhttp://nhunters.gameplex.net\n"
	.align 3
.LC18:
	.long 0x407f4000
	.long 0x0
	.align 3
.LC19:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC20:
	.long 0x3f000000
	.align 3
.LC21:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC22:
	.long 0x0
	.align 2
.LC23:
	.long 0x42480000
	.section	".text"
	.align 2
	.globl KickRadiusDamage
	.type	 KickRadiusDamage,@function
KickRadiusDamage:
	stwu 1,-144(1)
	mflr 0
	stfd 27,104(1)
	stfd 28,112(1)
	stfd 29,120(1)
	stfd 30,128(1)
	stfd 31,136(1)
	stmw 24,72(1)
	stw 0,148(1)
	mr 25,9
	lis 11,.LC18@ha
	fmr 27,1
	lis 9,.LC19@ha
	fmr 28,2
	lfd 29,.LC18@l(11)
	mr 29,3
	la 9,.LC19@l(9)
	mr 30,4
	lfd 30,0(9)
	mr 27,5
	mr 24,6
	mr 28,7
	li 31,0
	lis 26,0x4330
	b .L38
.L40:
	cmpw 0,31,24
	bc 12,2,.L38
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L38
	lfs 0,200(31)
	lis 9,.LC20@ha
	addi 4,1,16
	lfs 13,188(31)
	la 9,.LC20@l(9)
	addi 3,31,4
	lfs 1,0(9)
	mr 5,4
	fadds 13,13,0
	stfs 13,16(1)
	lfs 13,204(31)
	lfs 0,192(31)
	fadds 0,0,13
	stfs 0,20(1)
	lfs 0,208(31)
	lfs 13,196(31)
	fadds 13,13,0
	stfs 13,24(1)
	bl VectorMA
	lfs 0,4(30)
	addi 3,1,16
	lfs 13,8(30)
	lfs 12,12(30)
	lfs 11,20(1)
	lfs 9,16(1)
	lfs 10,24(1)
	fsubs 13,13,11
	fsubs 0,0,9
	fsubs 12,12,10
	stfs 13,20(1)
	stfs 0,16(1)
	stfs 12,24(1)
	bl VectorLength
	lis 9,.LC21@ha
	cmpw 0,31,27
	la 9,.LC21@l(9)
	fmr 0,27
	lfd 11,0(9)
	fmul 1,1,11
	fsub 0,0,1
	frsp 31,0
	bc 4,2,.L43
	fmr 0,31
	fmul 0,0,11
	frsp 31,0
.L43:
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 4,1,.L44
	cmpwi 0,28,0
	bc 12,2,.L44
	lwz 0,260(29)
	cmpwi 0,0,0
	bc 12,2,.L44
	cmpwi 0,0,9
	bc 12,2,.L44
	cmpwi 0,0,2
	bc 12,2,.L44
	cmpwi 0,0,3
	bc 12,2,.L44
	lwz 0,400(29)
	cmpwi 0,0,49
	bc 12,1,.L46
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 0,0(9)
	b .L47
.L46:
	xoris 0,0,0x8000
	stw 0,68(1)
	stw 26,64(1)
	lfd 0,64(1)
	fsub 0,0,30
	frsp 0,0
.L47:
	xoris 0,28,0x8000
	fmr 13,0
	stw 0,68(1)
	addi 3,1,32
	addi 4,1,48
	stw 26,64(1)
	lfd 0,64(1)
	fsub 0,0,30
	frsp 0,0
	fmr 1,0
	fmul 1,1,29
	fdiv 1,1,13
	frsp 1,1
	bl VectorScale
	lfs 11,48(1)
	lfs 10,52(1)
	lfs 9,56(1)
	lfs 0,376(29)
	lfs 13,380(29)
	lfs 12,384(29)
	fadds 0,0,11
	fadds 13,13,10
	fadds 12,12,9
	stfs 0,376(29)
	stfs 13,380(29)
	stfs 12,384(29)
.L44:
	mr 3,31
	mr 4,30
	bl CanDamage
	cmpwi 0,3,0
	bc 12,2,.L38
	lfs 0,4(30)
	fmr 11,31
	li 0,1
	lfs 12,4(31)
	lis 8,vec3_origin@ha
	mr 3,31
	lfs 10,8(30)
	la 8,vec3_origin@l(8)
	mr 4,30
	lfs 9,12(30)
	fctiwz 13,11
	mr 5,27
	addi 6,1,32
	fsubs 12,12,0
	addi 7,30,4
	stfd 13,64(1)
	stfs 12,32(1)
	lfs 0,8(31)
	lwz 9,68(1)
	fsubs 0,0,10
	mr 10,9
	stfs 0,36(1)
	lfs 0,12(31)
	stw 0,8(1)
	stw 25,12(1)
	fsubs 0,0,9
	stfs 0,40(1)
	bl T_Damage
.L38:
	fmr 1,28
	mr 3,31
	addi 4,30,4
	bl findradius
	mr. 31,3
	bc 4,2,.L40
	lwz 0,148(1)
	mtlr 0
	lmw 24,72(1)
	lfd 27,104(1)
	lfd 28,112(1)
	lfd 29,120(1)
	lfd 30,128(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe3:
	.size	 KickRadiusDamage,.Lfe3-KickRadiusDamage
	.comm	showscores,4,4
	.align 2
	.globl ClearFlashlight
	.type	 ClearFlashlight,@function
ClearFlashlight:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 3,892(31)
	cmpwi 0,3,0
	bc 12,2,.L7
	bl G_FreeEdict
	li 0,0
	stw 0,892(31)
.L7:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 ClearFlashlight,.Lfe4-ClearFlashlight
	.align 2
	.globl onPlayerConnect
	.type	 onPlayerConnect,@function
onPlayerConnect:
	stwu 1,-624(1)
	mflr 0
	stmw 29,612(1)
	stw 0,628(1)
	mr 29,3
	lis 4,.LC14@ha
	lis 3,.LC13@ha
	la 4,.LC14@l(4)
	la 3,.LC13@l(3)
	bl fopen
	mr. 30,3
	bc 12,2,.L30
	addi 3,1,8
	li 4,500
	mr 5,30
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L31
	addi 31,1,520
	b .L32
.L34:
	addi 3,1,8
	mr 4,31
	bl strcat
.L32:
	mr 3,31
	li 4,80
	mr 5,30
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L34
	lis 9,gi+12@ha
	lis 4,.LC15@ha
	lwz 0,gi+12@l(9)
	lis 5,.LC16@ha
	mr 3,29
	la 4,.LC15@l(4)
	la 5,.LC16@l(5)
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L31:
	mr 3,30
	bl fclose
	b .L36
.L30:
	lis 9,gi+12@ha
	lis 4,.LC17@ha
	lwz 0,gi+12@l(9)
	lis 5,.LC16@ha
	mr 3,29
	la 4,.LC17@l(4)
	la 5,.LC16@l(5)
	mtlr 0
	crxor 6,6,6
	blrl
.L36:
	lwz 0,628(1)
	mtlr 0
	lmw 29,612(1)
	la 1,624(1)
	blr
.Lfe5:
	.size	 onPlayerConnect,.Lfe5-onPlayerConnect
	.align 2
	.globl InfoComputer
	.type	 InfoComputer,@function
InfoComputer:
	stwu 1,-1056(1)
	mflr 0
	stmw 28,1040(1)
	stw 0,1060(1)
	mr 29,3
	lis 5,.LC12@ha
	li 4,1024
	addi 3,1,8
	la 5,.LC12@l(5)
	crxor 6,6,6
	bl Com_sprintf
	lis 28,gi@ha
	li 3,4
	la 28,gi@l(28)
	lwz 9,100(28)
	mtlr 9
	blrl
	lwz 9,116(28)
	addi 3,1,8
	mtlr 9
	blrl
	lwz 0,92(28)
	mr 3,29
	li 4,1
	mtlr 0
	blrl
	lwz 0,1060(1)
	mtlr 0
	lmw 28,1040(1)
	la 1,1056(1)
	blr
.Lfe6:
	.size	 InfoComputer,.Lfe6-InfoComputer
	.align 2
	.globl Cmd_ShowInfo_f
	.type	 Cmd_ShowInfo_f,@function
Cmd_ShowInfo_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 11,3
	li 0,0
	lwz 10,84(11)
	stw 0,3516(10)
	lwz 9,84(11)
	stw 0,3512(9)
	bl InfoComputer
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 Cmd_ShowInfo_f,.Lfe7-Cmd_ShowInfo_f
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.align 2
	.globl playerEffects
	.type	 playerEffects,@function
playerEffects:
	lwz 0,892(3)
	cmpwi 0,0,0
	bc 12,2,.L25
	lwz 0,896(3)
	cmpwi 0,0,0
	bc 4,2,.L50
	lis 0,0x4
	stw 0,64(3)
.L25:
	lwz 0,896(3)
	cmpwi 0,0,0
	bclr 12,2
.L50:
	li 0,32
	stw 0,68(3)
	blr
.Lfe8:
	.size	 playerEffects,.Lfe8-playerEffects
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
