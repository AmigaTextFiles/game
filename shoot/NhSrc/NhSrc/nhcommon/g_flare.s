	.file	"g_flare.c"
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
	.long 0x0
	.long 0xbf800000
	.long 0x0
	.align 2
.LC1:
	.long 0x3f800000
	.section	".text"
	.align 2
	.type	 Flare_Burnout,@function
Flare_Burnout:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	lis 11,.LC0@ha
	lwz 9,532(31)
	la 10,.LC0@l(11)
	addi 7,1,8
	lwz 8,.LC0@l(11)
	addi 9,9,-1
	lwz 11,8(10)
	lwz 0,4(10)
	cmpwi 0,9,0
	stw 8,8(1)
	stw 11,8(7)
	stw 0,4(7)
	stw 9,532(31)
	bc 4,2,.L8
	lwz 0,64(31)
	andi. 9,0,128
	bc 12,2,.L9
	xori 0,0,128
	li 9,1024
	ori 0,0,8
	stw 9,68(31)
	stw 0,64(31)
	bl getFlareDimTime
	b .L13
.L9:
	andi. 9,0,8
	bc 12,2,.L11
	xori 0,0,8
	stw 0,64(31)
	bl getFlareDieTime
.L13:
	mulli 3,3,10
	stw 3,532(31)
	b .L8
.L11:
	lis 9,Flare_End@ha
	la 9,Flare_End@l(9)
	stw 9,436(31)
.L8:
	lis 9,.LC1@ha
	lfs 0,428(31)
	lis 29,gi@ha
	la 9,.LC1@l(9)
	la 29,gi@l(29)
	lfs 13,0(9)
	li 3,3
	addi 28,31,4
	fadds 0,0,13
	stfs 0,428(31)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,25
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,10
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,124(29)
	addi 3,1,8
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,28
	li 4,2
	mtlr 9
	blrl
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 Flare_Burnout,.Lfe1-Flare_Burnout
	.section	".rodata"
	.align 2
.LC2:
	.long 0x3f000000
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC4:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.type	 Flare_Explode,@function
Flare_Explode:
	stwu 1,-80(1)
	mflr 0
	stmw 29,68(1)
	stw 0,84(1)
	mr 31,3
	lwz 3,256(31)
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L16
	addi 4,31,4
	li 5,2
	bl PlayerNoise
.L16:
	lwz 9,540(31)
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 4,2,.L18
	lwz 0,184(9)
	andi. 11,0,4
	bc 12,2,.L17
.L18:
	lfs 0,200(9)
	lis 11,.LC2@ha
	addi 4,1,16
	lfs 13,188(9)
	la 11,.LC2@l(11)
	addi 3,9,4
	lfs 1,0(11)
	mr 5,4
	fadds 13,13,0
	stfs 13,16(1)
	lfs 13,204(9)
	lfs 0,192(9)
	fadds 0,0,13
	stfs 0,20(1)
	lfs 0,208(9)
	lfs 13,196(9)
	fadds 13,13,0
	stfs 13,24(1)
	bl VectorMA
	lfs 9,16(1)
	addi 3,1,16
	lfs 11,20(1)
	lfs 10,24(1)
	lfs 0,4(31)
	lfs 13,8(31)
	lfs 12,12(31)
	fsubs 0,0,9
	fsubs 13,13,11
	fsubs 12,12,10
	stfs 0,16(1)
	stfs 13,20(1)
	stfs 12,24(1)
	bl VectorLength
	lis 9,.LC3@ha
	lwz 0,516(31)
	la 9,.LC3@l(9)
	lis 8,0x4330
	lwz 10,540(31)
	lfd 13,0(9)
	xoris 0,0,0x8000
	li 29,60
	lis 9,.LC4@ha
	stw 0,60(1)
	mr 3,10
	la 9,.LC4@l(9)
	stw 8,56(1)
	li 0,1
	lfd 0,0(9)
	lis 8,vec3_origin@ha
	addi 6,1,32
	lfs 12,4(10)
	mr 9,11
	addi 7,31,4
	lfs 8,4(31)
	la 8,vec3_origin@l(8)
	mr 4,31
	fmul 1,1,0
	lfs 10,8(31)
	lfd 0,56(1)
	fsubs 12,12,8
	lfs 9,12(31)
	lwz 5,256(31)
	fsub 0,0,13
	stfs 12,32(1)
	lfs 13,8(10)
	fsub 0,0,1
	fsubs 13,13,10
	frsp 0,0
	stfs 13,36(1)
	fmr 12,0
	lfs 0,12(10)
	stw 0,8(1)
	fctiwz 11,12
	stw 29,12(1)
	fsubs 0,0,9
	stfd 11,56(1)
	lwz 9,60(1)
	stfs 0,40(1)
	mr 10,9
	bl T_Damage
	mr 3,31
	bl G_FreeEdict
.L17:
	lwz 0,84(1)
	mtlr 0
	lmw 29,68(1)
	la 1,80(1)
	blr
.Lfe2:
	.size	 Flare_Explode,.Lfe2-Flare_Explode
	.section	".rodata"
	.align 2
.LC6:
	.string	"weapons/hgrenb1a.wav"
	.align 2
.LC7:
	.string	"weapons/hgrenb2a.wav"
	.align 2
.LC8:
	.string	"weapons/grenlb1b.wav"
	.align 2
.LC5:
	.long 0x46fffe00
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC10:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC11:
	.long 0x3f800000
	.align 2
.LC12:
	.long 0x0
	.section	".text"
	.align 2
	.type	 Flare_Touch,@function
Flare_Touch:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	mr 29,4
	lwz 0,256(31)
	cmpw 0,29,0
	bc 12,2,.L19
	cmpwi 0,6,0
	bc 12,2,.L21
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L21
	bl G_FreeEdict
	b .L19
.L21:
	bl getFlareDamage
	cmpwi 0,3,0
	bc 4,1,.L19
	lwz 0,512(29)
	cmpwi 0,0,0
	bc 4,2,.L23
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L24
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC9@ha
	lis 11,.LC5@ha
	la 10,.LC9@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC10@ha
	lfs 12,.LC5@l(11)
	la 10,.LC10@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L25
	lis 29,gi@ha
	lis 3,.LC6@ha
	la 29,gi@l(29)
	la 3,.LC6@l(3)
	b .L28
.L25:
	lis 29,gi@ha
	lis 3,.LC7@ha
	la 29,gi@l(29)
	la 3,.LC7@l(3)
	b .L28
.L24:
	lis 29,gi@ha
	lis 3,.LC8@ha
	la 29,gi@l(29)
	la 3,.LC8@l(3)
.L28:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC11@ha
	lis 10,.LC11@ha
	lis 11,.LC12@ha
	mr 5,3
	la 9,.LC11@l(9)
	la 10,.LC11@l(10)
	mtlr 0
	la 11,.LC12@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L19
.L23:
	stw 29,540(31)
	mr 3,31
	bl Flare_Explode
.L19:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 Flare_Touch,.Lfe3-Flare_Touch
	.section	".rodata"
	.align 2
.LC14:
	.string	"models/objects/grenade2/tris.md2"
	.align 2
.LC15:
	.string	"hgrenade"
	.align 2
.LC13:
	.long 0x46fffe00
	.align 3
.LC16:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC17:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC18:
	.long 0x40240000
	.long 0x0
	.align 3
.LC19:
	.long 0x40690000
	.long 0x0
	.align 2
.LC20:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl fire_flare
	.type	 fire_flare,@function
fire_flare:
	stwu 1,-160(1)
	mflr 0
	stfd 28,128(1)
	stfd 29,136(1)
	stfd 30,144(1)
	stfd 31,152(1)
	stmw 22,88(1)
	stw 0,164(1)
	mr 30,3
	mr 29,7
	mr 22,8
	mr 27,4
	mr 26,5
	bl clearSafetyMode
	lis 25,0x4330
	addi 23,1,40
	addi 24,1,56
	addi 4,1,8
	mr 3,26
	bl vectoangles
	lis 9,.LC16@ha
	mr 6,24
	la 9,.LC16@l(9)
	addi 4,1,24
	addi 3,1,8
	lfd 31,0(9)
	mr 5,23
	bl AngleVectors
	lis 9,.LC17@ha
	lis 10,.LC18@ha
	la 10,.LC18@l(10)
	la 9,.LC17@l(9)
	lfd 28,0(10)
	lfd 29,0(9)
	bl G_Spawn
	lfs 13,0(27)
	xoris 29,29,0x8000
	stw 29,84(1)
	mr 31,3
	stw 25,80(1)
	addi 28,31,376
	mr 3,26
	lfd 1,80(1)
	mr 4,28
	stfs 13,4(31)
	lfs 0,4(27)
	fsub 1,1,31
	stfs 0,8(31)
	lfs 13,8(27)
	frsp 1,1
	stfs 13,12(31)
	bl VectorScale
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC13@ha
	stw 3,84(1)
	lis 10,.LC19@ha
	mr 4,24
	stw 25,80(1)
	la 10,.LC19@l(10)
	mr 5,28
	lfd 0,80(1)
	mr 3,28
	lfs 30,.LC13@l(11)
	lfd 13,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 1,0
	fsub 1,1,29
	fadd 1,1,1
	fmadd 1,1,28,13
	frsp 1,1
	bl VectorMA
	bl rand
	rlwinm 0,3,0,17,31
	xoris 0,0,0x8000
	mr 3,28
	stw 0,84(1)
	mr 5,3
	mr 4,23
	stw 25,80(1)
	lfd 0,80(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 1,0
	fsub 1,1,29
	fadd 1,1,1
	fmul 1,1,28
	frsp 1,1
	bl VectorMA
	lwz 11,68(31)
	li 7,9
	lis 0,0x600
	lwz 10,64(31)
	li 8,0
	lis 6,0x4396
	ori 11,11,7168
	ori 0,0,3
	stw 7,260(31)
	ori 10,10,384
	rlwinm 11,11,0,23,21
	stw 6,396(31)
	li 9,2
	lis 7,gi+32@ha
	stw 8,200(31)
	stw 6,388(31)
	lis 3,.LC14@ha
	stw 6,392(31)
	la 3,.LC14@l(3)
	stw 8,196(31)
	stw 8,192(31)
	stw 8,188(31)
	stw 8,208(31)
	stw 8,204(31)
	stw 9,248(31)
	stw 10,64(31)
	stw 11,68(31)
	stw 0,252(31)
	lwz 0,gi+32@l(7)
	mtlr 0
	blrl
	lis 9,Flare_Touch@ha
	lis 10,.LC20@ha
	stw 3,40(31)
	la 9,Flare_Touch@l(9)
	lis 11,level+4@ha
	stw 30,256(31)
	la 10,.LC20@l(10)
	stw 9,444(31)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(31)
	bl getFlareBrightTime
	mulli 3,3,10
	lis 9,Flare_Burnout@ha
	la 9,Flare_Burnout@l(9)
	stw 9,436(31)
	stw 3,532(31)
	bl getFlareDamage
	stw 3,516(31)
	bl getFlareDamageRadius
	xoris 3,3,0x8000
	stw 3,84(1)
	lis 9,.LC15@ha
	cmpwi 0,22,0
	stw 25,80(1)
	la 9,.LC15@l(9)
	lfd 0,80(1)
	stw 9,280(31)
	fsub 0,0,31
	frsp 0,0
	stfs 0,524(31)
	li 0,1
	bc 12,2,.L30
	li 0,3
.L30:
	stw 0,284(31)
	lis 9,Flare_Die@ha
	lis 7,0xc040
	lis 8,0x4040
	la 9,Flare_Die@l(9)
	stw 7,192(31)
	li 11,0
	lis 10,0x40c0
	stw 8,204(31)
	li 0,2
	stw 11,196(31)
	stw 10,208(31)
	stw 0,400(31)
	stw 9,456(31)
	stw 7,188(31)
	stw 8,200(31)
	bl getFlareHealth
	li 0,1
	stw 3,480(31)
	lis 9,gi+72@ha
	stw 0,512(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,30
	bl clearSafetyMode
	lwz 0,164(1)
	mtlr 0
	lmw 22,88(1)
	lfd 28,128(1)
	lfd 29,136(1)
	lfd 30,144(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe4:
	.size	 fire_flare,.Lfe4-fire_flare
	.section	".rodata"
	.align 2
.LC21:
	.string	"Predator cannot use flares\n"
	.align 2
.LC22:
	.string	"flares"
	.align 2
.LC23:
	.string	"Flares are not enabled.\n"
	.align 2
.LC24:
	.string	"Only one flare per respawn.\n"
	.align 2
.LC25:
	.string	"Only %d flares per respawn.\n"
	.align 2
.LC26:
	.string	"Flare selected\n"
	.section	".text"
	.align 2
	.globl Cmd_Flare_f
	.type	 Cmd_Flare_f,@function
Cmd_Flare_f:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L34
	lis 9,gi+8@ha
	lis 5,.LC21@ha
	lwz 0,gi+8@l(9)
	la 5,.LC21@l(5)
	b .L40
.L34:
	lis 3,.LC22@ha
	la 3,.LC22@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 30,3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	lis 0,0x286b
	ori 0,0,51739
	subf 9,9,30
	mullw 9,9,0
	addi 11,11,740
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L35
	lis 11,max_flares@ha
	lwz 9,max_flares@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 6,20(1)
	cmpwi 0,6,0
	bc 12,1,.L36
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC23@l(5)
	b .L40
.L36:
	cmpwi 0,6,1
	bc 4,2,.L38
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC24@l(5)
.L40:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L33
.L38:
	lis 9,gi+8@ha
	lis 5,.LC25@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC25@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L33
.L35:
	lis 9,gi+8@ha
	lis 5,.LC26@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	li 4,2
	la 5,.LC26@l(5)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,8(30)
	mr 3,31
	mr 4,30
	mtlr 0
	blrl
.L33:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Cmd_Flare_f,.Lfe5-Cmd_Flare_f
	.section	".rodata"
	.align 2
.LC27:
	.string	"max_flares"
	.align 2
.LC28:
	.string	"5"
	.align 2
.LC29:
	.string	"flare_bright_time"
	.align 2
.LC30:
	.string	"10"
	.align 2
.LC31:
	.string	"flare_dim_time"
	.align 2
.LC32:
	.string	"flare_die_time"
	.align 2
.LC33:
	.string	"flare_health"
	.align 2
.LC34:
	.string	"0"
	.align 2
.LC35:
	.string	"flare_damage"
	.align 2
.LC36:
	.string	"flare_damage_radius"
	.align 2
.LC37:
	.long 0x0
	.align 2
.LC38:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl validateMaxFlares
	.type	 validateMaxFlares,@function
validateMaxFlares:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC37@ha
	lis 9,max_flares@ha
	la 11,.LC37@l(11)
	lfs 0,0(11)
	lwz 11,max_flares@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L43
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L42
.L43:
	lis 9,gi+148@ha
	lis 3,.LC27@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC28@ha
	la 3,.LC27@l(3)
	la 4,.LC28@l(4)
	mtlr 0
	blrl
.L42:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 validateMaxFlares,.Lfe6-validateMaxFlares
	.section	".rodata"
	.align 2
.LC39:
	.long 0x0
	.align 2
.LC40:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl getMaxFlares
	.type	 getMaxFlares,@function
getMaxFlares:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,max_flares@ha
	lwz 9,max_flares@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L45
	lfs 13,20(9)
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L46
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L45
.L46:
	lis 9,gi+148@ha
	lis 3,.LC27@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC28@ha
	la 3,.LC27@l(3)
	la 4,.LC28@l(4)
	mtlr 0
	blrl
.L45:
	lis 11,max_flares@ha
	lwz 9,max_flares@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 getMaxFlares,.Lfe7-getMaxFlares
	.section	".rodata"
	.align 2
.LC41:
	.long 0x0
	.align 2
.LC42:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl validateFlareBrightTime
	.type	 validateFlareBrightTime,@function
validateFlareBrightTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC41@ha
	lis 9,flare_bright_time@ha
	la 11,.LC41@l(11)
	lfs 0,0(11)
	lwz 11,flare_bright_time@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L51
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L50
.L51:
	lis 9,gi+148@ha
	lis 3,.LC29@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC30@ha
	la 3,.LC29@l(3)
	la 4,.LC30@l(4)
	mtlr 0
	blrl
.L50:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 validateFlareBrightTime,.Lfe8-validateFlareBrightTime
	.section	".rodata"
	.align 2
.LC43:
	.long 0x0
	.align 2
.LC44:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl getFlareBrightTime
	.type	 getFlareBrightTime,@function
getFlareBrightTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,flare_bright_time@ha
	lwz 9,flare_bright_time@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L53
	lfs 13,20(9)
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L54
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L53
.L54:
	lis 9,gi+148@ha
	lis 3,.LC29@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC30@ha
	la 3,.LC29@l(3)
	la 4,.LC30@l(4)
	mtlr 0
	blrl
.L53:
	lis 11,flare_bright_time@ha
	lwz 9,flare_bright_time@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 getFlareBrightTime,.Lfe9-getFlareBrightTime
	.section	".rodata"
	.align 2
.LC45:
	.long 0x0
	.align 2
.LC46:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl validateFlareDimTime
	.type	 validateFlareDimTime,@function
validateFlareDimTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC45@ha
	lis 9,flare_dim_time@ha
	la 11,.LC45@l(11)
	lfs 0,0(11)
	lwz 11,flare_dim_time@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L59
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L58
.L59:
	lis 9,gi+148@ha
	lis 3,.LC31@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC28@ha
	la 3,.LC31@l(3)
	la 4,.LC28@l(4)
	mtlr 0
	blrl
.L58:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 validateFlareDimTime,.Lfe10-validateFlareDimTime
	.section	".rodata"
	.align 2
.LC47:
	.long 0x0
	.align 2
.LC48:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl getFlareDimTime
	.type	 getFlareDimTime,@function
getFlareDimTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,flare_dim_time@ha
	lwz 9,flare_dim_time@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L61
	lfs 13,20(9)
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L62
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L61
.L62:
	lis 9,gi+148@ha
	lis 3,.LC31@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC28@ha
	la 3,.LC31@l(3)
	la 4,.LC28@l(4)
	mtlr 0
	blrl
.L61:
	lis 11,flare_dim_time@ha
	lwz 9,flare_dim_time@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 getFlareDimTime,.Lfe11-getFlareDimTime
	.section	".rodata"
	.align 2
.LC49:
	.long 0x0
	.align 2
.LC50:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl validateFlareDieTime
	.type	 validateFlareDieTime,@function
validateFlareDieTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC49@ha
	lis 9,flare_die_time@ha
	la 11,.LC49@l(11)
	lfs 0,0(11)
	lwz 11,flare_die_time@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L67
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L66
.L67:
	lis 9,gi+148@ha
	lis 3,.LC32@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC28@ha
	la 3,.LC32@l(3)
	la 4,.LC28@l(4)
	mtlr 0
	blrl
.L66:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe12:
	.size	 validateFlareDieTime,.Lfe12-validateFlareDieTime
	.section	".rodata"
	.align 2
.LC51:
	.long 0x0
	.align 2
.LC52:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl getFlareDieTime
	.type	 getFlareDieTime,@function
getFlareDieTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,flare_die_time@ha
	lwz 9,flare_die_time@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L69
	lfs 13,20(9)
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L70
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L69
.L70:
	lis 9,gi+148@ha
	lis 3,.LC32@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC28@ha
	la 3,.LC32@l(3)
	la 4,.LC28@l(4)
	mtlr 0
	blrl
.L69:
	lis 11,flare_die_time@ha
	lwz 9,flare_die_time@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 getFlareDieTime,.Lfe13-getFlareDieTime
	.section	".rodata"
	.align 2
.LC53:
	.long 0x0
	.align 2
.LC54:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl validateFlareHealth
	.type	 validateFlareHealth,@function
validateFlareHealth:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC53@ha
	lis 9,flare_health@ha
	la 11,.LC53@l(11)
	lfs 0,0(11)
	lwz 11,flare_health@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L75
	lis 9,.LC54@ha
	la 9,.LC54@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L74
.L75:
	lis 9,gi+148@ha
	lis 3,.LC33@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC34@ha
	la 3,.LC33@l(3)
	la 4,.LC34@l(4)
	mtlr 0
	blrl
.L74:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 validateFlareHealth,.Lfe14-validateFlareHealth
	.section	".rodata"
	.align 2
.LC55:
	.long 0x0
	.align 2
.LC56:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl getFlareHealth
	.type	 getFlareHealth,@function
getFlareHealth:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,flare_health@ha
	lwz 9,flare_health@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L77
	lfs 13,20(9)
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L78
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L77
.L78:
	lis 9,gi+148@ha
	lis 3,.LC33@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC34@ha
	la 3,.LC33@l(3)
	la 4,.LC34@l(4)
	mtlr 0
	blrl
.L77:
	lis 11,flare_health@ha
	lwz 9,flare_health@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 getFlareHealth,.Lfe15-getFlareHealth
	.section	".rodata"
	.align 2
.LC57:
	.long 0x0
	.align 2
.LC58:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl validateFlareDamage
	.type	 validateFlareDamage,@function
validateFlareDamage:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC57@ha
	lis 9,flare_damage@ha
	la 11,.LC57@l(11)
	lfs 0,0(11)
	lwz 11,flare_damage@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L83
	lis 9,.LC58@ha
	la 9,.LC58@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L82
.L83:
	lis 9,gi+148@ha
	lis 3,.LC35@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC34@ha
	la 3,.LC35@l(3)
	la 4,.LC34@l(4)
	mtlr 0
	blrl
.L82:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 validateFlareDamage,.Lfe16-validateFlareDamage
	.section	".rodata"
	.align 2
.LC59:
	.long 0x0
	.align 2
.LC60:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl getFlareDamage
	.type	 getFlareDamage,@function
getFlareDamage:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,flare_damage@ha
	lwz 9,flare_damage@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L85
	lfs 13,20(9)
	lis 9,.LC59@ha
	la 9,.LC59@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L86
	lis 9,.LC60@ha
	la 9,.LC60@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L85
.L86:
	lis 9,gi+148@ha
	lis 3,.LC35@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC34@ha
	la 3,.LC35@l(3)
	la 4,.LC34@l(4)
	mtlr 0
	blrl
.L85:
	lis 11,flare_damage@ha
	lwz 9,flare_damage@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 getFlareDamage,.Lfe17-getFlareDamage
	.section	".rodata"
	.align 2
.LC61:
	.long 0x0
	.align 2
.LC62:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl validateFlareDamageRadius
	.type	 validateFlareDamageRadius,@function
validateFlareDamageRadius:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC61@ha
	lis 9,flare_damage_radius@ha
	la 11,.LC61@l(11)
	lfs 0,0(11)
	lwz 11,flare_damage_radius@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L91
	lis 9,.LC62@ha
	la 9,.LC62@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L90
.L91:
	lis 9,gi+148@ha
	lis 3,.LC36@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC34@ha
	la 3,.LC36@l(3)
	la 4,.LC34@l(4)
	mtlr 0
	blrl
.L90:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 validateFlareDamageRadius,.Lfe18-validateFlareDamageRadius
	.section	".rodata"
	.align 2
.LC63:
	.long 0x0
	.align 2
.LC64:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl getFlareDamageRadius
	.type	 getFlareDamageRadius,@function
getFlareDamageRadius:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,flare_damage_radius@ha
	lwz 9,flare_damage_radius@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L93
	lfs 13,20(9)
	lis 9,.LC63@ha
	la 9,.LC63@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L94
	lis 9,.LC64@ha
	la 9,.LC64@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L93
.L94:
	lis 9,gi+148@ha
	lis 3,.LC36@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC34@ha
	la 3,.LC36@l(3)
	la 4,.LC34@l(4)
	mtlr 0
	blrl
.L93:
	lis 11,flare_damage_radius@ha
	lwz 9,flare_damage_radius@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 getFlareDamageRadius,.Lfe19-getFlareDamageRadius
	.align 2
	.type	 Flare_End,@function
Flare_End:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 29,gi@ha
	lis 9,.LC0@ha
	la 29,gi@l(29)
	lwz 10,.LC0@l(9)
	mr 26,3
	lwz 8,100(29)
	la 9,.LC0@l(9)
	li 3,3
	lwz 11,8(9)
	addi 28,1,8
	addi 27,26,4
	mtlr 8
	lwz 0,4(9)
	stw 10,8(1)
	stw 0,4(28)
	stw 11,8(28)
	blrl
	lwz 9,100(29)
	li 3,25
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,100
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	mr 3,26
	bl G_FreeEdict
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 Flare_End,.Lfe20-Flare_End
	.align 2
	.type	 Flare_Die,@function
Flare_Die:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 29,gi@ha
	lis 9,.LC0@ha
	la 29,gi@l(29)
	lwz 10,.LC0@l(9)
	mr 26,3
	lwz 8,100(29)
	la 9,.LC0@l(9)
	li 3,3
	lwz 11,8(9)
	addi 28,1,8
	addi 27,26,4
	mtlr 8
	lwz 0,4(9)
	stw 10,8(1)
	stw 0,4(28)
	stw 11,8(28)
	blrl
	lwz 9,100(29)
	li 3,25
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,100
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	mr 3,26
	bl G_FreeEdict
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe21:
	.size	 Flare_Die,.Lfe21-Flare_Die
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
