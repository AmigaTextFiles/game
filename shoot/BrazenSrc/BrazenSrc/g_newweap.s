	.file	"g_newweap.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"models/proj/flechette/tris.md2"
	.align 2
.LC1:
	.string	"items/damage3.wav"
	.align 2
.LC2:
	.long 0xbca3d70a
	.align 2
.LC3:
	.long 0x3f800000
	.align 2
.LC4:
	.long 0x0
	.align 3
.LC5:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC6:
	.long 0x43400000
	.section	".text"
	.align 2
	.globl Prox_Explode
	.type	 Prox_Explode,@function
Prox_Explode:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	lwz 3,560(31)
	cmpwi 0,3,0
	bc 12,2,.L17
	lwz 0,256(3)
	cmpw 0,0,31
	bc 4,2,.L17
	bl G_FreeEdict
.L17:
	lwz 0,564(31)
	mr 30,31
	addi 28,31,4
	cmpwi 0,0,0
	bc 12,2,.L18
	mr 30,0
	mr 4,28
	mr 3,30
	li 5,2
	bl PlayerNoise
.L18:
	lwz 0,516(31)
	cmpwi 0,0,90
	bc 4,1,.L19
	lis 29,gi@ha
	lis 3,.LC1@ha
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC3@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC3@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 2,0(9)
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 3,0(9)
	blrl
.L19:
	lwz 0,516(31)
	lis 10,0x4330
	lis 9,.LC5@ha
	li 6,46
	xoris 0,0,0x8000
	la 9,.LC5@l(9)
	stw 0,28(1)
	mr 4,30
	mr 3,31
	stw 10,24(1)
	mr 5,31
	lfd 0,0(9)
	lfd 1,24(1)
	li 9,0
	stw 9,512(31)
	lis 9,.LC6@ha
	fsub 1,1,0
	la 9,.LC6@l(9)
	lfs 2,0(9)
	frsp 1,1
	bl T_RadiusDamage
	lis 9,.LC2@ha
	mr 3,28
	lfs 1,.LC2@l(9)
	addi 4,31,376
	addi 5,1,8
	bl VectorMA
	lis 9,gi@ha
	li 3,3
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L20
	lwz 0,100(29)
	li 3,8
	mtlr 0
	blrl
	b .L21
.L20:
	lwz 0,100(29)
	li 3,7
	mtlr 0
	blrl
.L21:
	lis 29,gi@ha
	addi 3,1,8
	la 29,gi@l(29)
	lwz 9,120(29)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	mr 3,31
	bl G_FreeEdict
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 Prox_Explode,.Lfe1-Prox_Explode
	.section	".rodata"
	.align 2
.LC7:
	.string	"prox"
	.align 2
.LC9:
	.string	"weapons/proxwarn.wav"
	.align 2
.LC11:
	.string	"info_player_deathmatch"
	.align 2
.LC12:
	.string	"info_player_start"
	.align 2
.LC13:
	.string	"info_player_coop"
	.align 2
.LC14:
	.string	"misc_teleporter_dest"
	.align 2
.LC16:
	.string	"weapons/proxopen.wav"
	.align 3
.LC15:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC17:
	.long 0x3fa99999
	.long 0x9999999a
	.align 2
.LC18:
	.long 0x0
	.align 2
.LC19:
	.long 0x434a0000
	.align 2
.LC20:
	.long 0x42340000
	.align 2
.LC21:
	.long 0x41f00000
	.align 2
.LC22:
	.long 0x41700000
	.align 2
.LC23:
	.long 0x41200000
	.align 2
.LC24:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl prox_open
	.type	 prox_open,@function
prox_open:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 29,0
	lwz 0,56(31)
	cmpwi 0,0,9
	bc 4,2,.L35
	lwz 11,560(31)
	stw 29,76(31)
	cmpwi 0,11,0
	stw 29,256(31)
	bc 12,2,.L36
	lis 9,Prox_Field_Touch@ha
	la 9,Prox_Field_Touch@l(9)
	stw 9,444(11)
.L36:
	addi 30,31,4
	b .L37
.L39:
	lwz 0,280(29)
	cmpwi 0,0,0
	mr 3,0
	bc 12,2,.L37
	lwz 0,184(29)
	andi. 9,0,4
	bc 4,2,.L44
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L43
.L44:
	lwz 0,480(29)
	cmpwi 0,0,0
	bc 12,1,.L42
.L43:
	lis 9,.LC18@ha
	lis 11,deathmatch@ha
	la 9,.LC18@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L37
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L42
	lwz 3,280(29)
	lis 4,.LC12@ha
	la 4,.LC12@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L42
	lwz 3,280(29)
	lis 4,.LC13@ha
	la 4,.LC13@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L42
	lwz 3,280(29)
	lis 4,.LC14@ha
	la 4,.LC14@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L37
.L42:
	mr 3,29
	mr 4,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L58
.L37:
	lis 9,.LC19@ha
	mr 3,29
	la 9,.LC19@l(9)
	mr 4,30
	lfs 1,0(9)
	bl findradius
	mr. 29,3
	bc 4,2,.L39
	lis 9,strong_mines@ha
	lwz 9,strong_mines@l(9)
	cmpwi 0,9,0
	bc 12,2,.L46
	lfs 13,20(9)
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L53
.L46:
	lwz 0,516(31)
	lis 9,0xb60b
	ori 9,9,24759
	mulhw 9,0,9
	srawi 11,0,31
	add 9,9,0
	srawi 9,9,6
	subf 9,11,9
	cmpwi 0,9,2
	bc 12,2,.L50
	bc 12,1,.L55
	cmpwi 0,9,1
	b .L53
.L55:
	cmpwi 0,9,4
	bc 12,2,.L51
	cmpwi 0,9,8
	bc 12,2,.L52
	b .L53
.L50:
	lis 11,.LC21@ha
	lis 9,level+4@ha
	la 11,.LC21@l(11)
	b .L59
.L51:
	lis 11,.LC22@ha
	lis 9,level+4@ha
	la 11,.LC22@l(11)
	b .L59
.L52:
	lis 11,.LC23@ha
	lis 9,level+4@ha
	la 11,.LC23@l(11)
	b .L59
.L53:
	lis 11,.LC20@ha
	lis 9,level+4@ha
	la 11,.LC20@l(11)
.L59:
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,592(31)
	lis 9,prox_seek@ha
	lis 10,level+4@ha
	la 9,prox_seek@l(9)
	lis 11,.LC15@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC15@l(11)
	b .L60
.L58:
	lis 29,gi@ha
	lis 3,.LC9@ha
	la 29,gi@l(29)
	la 3,.LC9@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC24@ha
	lwz 0,16(29)
	lis 11,.LC24@ha
	la 9,.LC24@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC24@l(11)
	mr 3,31
	mtlr 0
	lis 9,.LC18@ha
	li 4,2
	lfs 2,0(11)
	la 9,.LC18@l(9)
	lfs 3,0(9)
	blrl
	mr 3,31
	bl Prox_Explode
	b .L34
.L35:
	cmpwi 0,0,0
	bc 4,2,.L57
	lis 29,gi@ha
	lis 3,.LC16@ha
	la 29,gi@l(29)
	la 3,.LC16@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC24@ha
	lwz 0,16(29)
	lis 11,.LC24@ha
	la 9,.LC24@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC24@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC18@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC18@l(9)
	lfs 3,0(9)
	blrl
.L57:
	lwz 11,56(31)
	lis 9,prox_open@ha
	lis 8,level+4@ha
	la 9,prox_open@l(9)
	lis 10,.LC17@ha
	addi 11,11,1
	stw 9,436(31)
	stw 11,56(31)
	lfs 0,level+4@l(8)
	lfd 13,.LC17@l(10)
.L60:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L34:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 prox_open,.Lfe2-prox_open
	.section	".rodata"
	.align 2
.LC28:
	.string	"prox_field"
	.align 3
.LC25:
	.long 0x3fe66666
	.long 0x66666666
	.align 3
.LC26:
	.long 0xbfb99999
	.long 0x9999999a
	.align 3
.LC27:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC29:
	.long 0x3fa99999
	.long 0x9999999a
	.align 2
.LC30:
	.long 0xc1200000
	.align 3
.LC31:
	.long 0x3ff80000
	.long 0x0
	.align 2
.LC32:
	.long 0x42700000
	.align 2
.LC33:
	.long 0x42b40000
	.section	".text"
	.align 2
	.globl prox_land
	.type	 prox_land,@function
prox_land:
	stwu 1,-144(1)
	mflr 0
	mfcr 12
	stmw 26,120(1)
	stw 0,148(1)
	stw 12,116(1)
	mr. 6,6
	mr 31,3
	mr 28,4
	mr 30,5
	li 26,0
	bc 12,2,.L62
	lwz 0,16(6)
	andi. 4,0,4
	bc 12,2,.L62
	bl G_FreeEdict
	b .L61
.L62:
	cmpwi 4,30,0
	bc 12,18,.L63
	lis 4,.LC30@ha
	addi 29,1,72
	la 4,.LC30@l(4)
	addi 3,31,4
	lfs 1,0(4)
	mr 5,29
	mr 4,30
	bl VectorMA
	lis 9,gi+52@ha
	mr 3,29
	lwz 0,gi+52@l(9)
	mtlr 0
	blrl
	andi. 0,3,24
	bc 4,2,.L87
.L63:
	lwz 9,184(28)
	andi. 0,9,4
	bc 4,2,.L66
	lwz 0,84(28)
	cmpwi 0,0,0
	bc 4,2,.L66
	andi. 4,9,8
	bc 12,2,.L65
.L66:
	lwz 0,564(31)
	cmpw 0,28,0
	bc 12,2,.L61
	b .L87
.L65:
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,28,0
	bc 12,2,.L69
	bc 12,18,.L87
	lwz 0,260(28)
	li 5,0
	lfs 8,8(30)
	cmpwi 0,0,2
	bc 4,2,.L71
	lis 9,.LC25@ha
	fmr 13,8
	lfd 0,.LC25@l(9)
	fcmpu 0,13,0
	bc 4,1,.L71
	li 5,1
.L71:
	lfs 0,4(30)
	lis 4,.LC31@ha
	lis 9,.LC26@ha
	lfs 12,380(31)
	la 4,.LC31@l(4)
	lis 11,.LC27@ha
	lfs 11,0(30)
	addi 8,1,88
	addi 7,31,376
	lfs 13,376(31)
	mr 6,8
	li 0,0
	fmuls 12,12,0
	lfd 10,0(4)
	li 10,0
	lfs 0,384(31)
	li 4,3
	mtctr 4
	lfd 9,.LC26@l(9)
	fmadds 13,13,11,12
	lfd 11,.LC27@l(11)
	fmadds 0,0,8,13
	fmul 0,0,10
	frsp 12,0
.L86:
	lfsx 0,10,30
	lfsx 13,10,7
	fmuls 0,0,12
	fsubs 13,13,0
	fmr 0,13
	stfsx 13,10,6
	fcmpu 0,0,9
	bc 4,1,.L75
	fcmpu 0,0,11
	bc 4,0,.L75
	stwx 0,10,8
.L75:
	addi 10,10,4
	bdnz .L86
	lis 9,.LC32@ha
	lfs 13,96(1)
	la 9,.LC32@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,1,.L61
	cmpwi 0,5,0
	li 26,9
	bc 12,2,.L80
	lis 9,vec3_origin@ha
	lfs 13,vec3_origin@l(9)
	la 11,vec3_origin@l(9)
	stfs 13,376(31)
	lfs 0,4(11)
	stfs 0,380(31)
	lfs 13,8(11)
	stfs 13,384(31)
	lfs 0,vec3_origin@l(9)
	stfs 0,388(31)
	lfs 13,4(11)
	stfs 13,392(31)
	lfs 0,8(11)
	stfs 0,396(31)
	b .L68
.L80:
	lfs 0,8(30)
	lis 9,.LC25@ha
	lfd 13,.LC25@l(9)
	fcmpu 0,0,13
	bc 4,1,.L61
	b .L87
.L69:
	lwz 0,40(28)
	cmpwi 0,0,1
	bc 4,2,.L61
.L68:
	addi 4,1,8
	mr 3,30
	bl vectoangles2
	addi 3,1,8
	addi 6,1,56
	addi 4,1,24
	addi 5,1,40
	bl AngleVectors
	lis 9,gi@ha
	addi 3,31,4
	la 30,gi@l(9)
	lwz 9,52(30)
	mtlr 9
	blrl
	andi. 27,3,24
	bc 12,2,.L85
.L87:
	mr 3,31
	bl Prox_Explode
	b .L61
.L85:
	bl G_Spawn
	li 28,0
	lfs 0,4(31)
	mr 29,3
	lis 9,.LC28@ha
	lis 0,0xc2c0
	lis 11,0x42c0
	la 9,.LC28@l(9)
	li 10,1
	stfs 0,4(29)
	lfs 0,8(31)
	stfs 0,8(29)
	lfs 13,12(31)
	stw 0,196(29)
	stw 11,208(29)
	stfs 13,12(29)
	stw 10,248(29)
	stw 0,188(29)
	stw 0,192(29)
	stw 11,200(29)
	stw 11,204(29)
	stw 9,280(29)
	stw 28,384(29)
	stw 28,380(29)
	stw 28,376(29)
	stw 28,396(29)
	stw 28,392(29)
	stw 28,388(29)
	stw 27,260(29)
	stw 31,256(29)
	stw 31,564(29)
	lwz 9,72(30)
	mtlr 9
	blrl
	lis 4,.LC33@ha
	lfs 12,8(1)
	lis 9,prox_die@ha
	la 4,.LC33@l(4)
	lfs 13,12(1)
	li 8,2
	lfs 0,0(4)
	li 0,20
	la 9,prox_die@l(9)
	lfs 11,16(1)
	lis 7,level+4@ha
	lis 10,.LC29@ha
	stfs 13,20(31)
	lis 11,prox_open@ha
	mr 3,31
	fadds 12,12,0
	stw 28,388(31)
	la 11,prox_open@l(11)
	stfs 11,24(31)
	stw 26,260(31)
	stfs 12,16(31)
	stw 9,456(31)
	stw 29,560(31)
	stw 0,480(31)
	stw 28,384(31)
	stw 28,380(31)
	stw 28,376(31)
	stw 28,396(31)
	stw 28,392(31)
	stw 8,512(31)
	lfs 0,level+4@l(7)
	lfd 13,.LC29@l(10)
	stw 11,436(31)
	stw 27,444(31)
	stw 8,248(31)
	stfs 12,8(1)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,72(30)
	mtlr 0
	blrl
.L61:
	lwz 0,148(1)
	lwz 12,116(1)
	mtlr 0
	lmw 26,120(1)
	mtcrf 8,12
	la 1,144(1)
	blr
.Lfe3:
	.size	 prox_land,.Lfe3-prox_land
	.section	".rodata"
	.align 2
.LC35:
	.string	"models/weapons/g_prox/tris.md2"
	.align 2
.LC34:
	.long 0x46fffe00
	.align 3
.LC36:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC37:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC38:
	.long 0x40240000
	.long 0x0
	.align 3
.LC39:
	.long 0x40690000
	.long 0x0
	.align 2
.LC40:
	.long 0x42b40000
	.align 2
.LC41:
	.long 0x42340000
	.align 2
.LC42:
	.long 0x41f00000
	.align 2
.LC43:
	.long 0x41700000
	.align 2
.LC44:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl fire_prox
	.type	 fire_prox,@function
fire_prox:
	stwu 1,-160(1)
	mflr 0
	stfd 28,128(1)
	stfd 29,136(1)
	stfd 30,144(1)
	stfd 31,152(1)
	stmw 22,88(1)
	stw 0,164(1)
	mr 27,4
	mr 25,5
	mr 22,3
	mr 29,7
	addi 23,1,40
	addi 4,1,8
	mr 30,6
	mr 3,25
	bl vectoangles2
	lis 26,0x4330
	addi 24,1,56
	addi 4,1,24
	mr 6,24
	addi 3,1,8
	mr 5,23
	bl AngleVectors
	lis 9,.LC36@ha
	lis 10,.LC37@ha
	la 10,.LC37@l(10)
	la 9,.LC36@l(9)
	lfd 29,0(10)
	lfd 31,0(9)
	bl G_Spawn
	lis 9,.LC38@ha
	lfs 13,0(27)
	xoris 29,29,0x8000
	la 9,.LC38@l(9)
	mr 31,3
	lfd 28,0(9)
	addi 28,31,376
	mr 3,25
	stfs 13,4(31)
	mr 4,28
	stw 29,84(1)
	stw 26,80(1)
	lfd 1,80(1)
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
	lis 11,.LC34@ha
	stw 3,84(1)
	lis 10,.LC39@ha
	mr 4,24
	stw 26,80(1)
	la 10,.LC39@l(10)
	mr 5,28
	lfd 0,80(1)
	mr 3,28
	lfs 30,.LC34@l(11)
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
	stw 26,80(1)
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
	lis 9,.LC40@ha
	lfs 13,8(1)
	lis 11,0x600
	la 9,.LC40@l(9)
	lwz 0,68(31)
	lis 10,0xc0c0
	lfs 0,0(9)
	lis 8,0x40c0
	ori 11,11,27
	stfs 13,16(31)
	li 7,2
	ori 0,0,32768
	lwz 9,64(31)
	li 6,9
	lis 5,gi+32@ha
	fsubs 13,13,0
	lis 3,.LC35@ha
	lfs 0,12(1)
	ori 9,9,32
	la 3,.LC35@l(3)
	stfs 0,20(31)
	lfs 0,16(1)
	stw 7,248(31)
	stw 9,64(31)
	stw 11,252(31)
	stw 10,196(31)
	stw 8,208(31)
	stw 10,188(31)
	stw 10,192(31)
	stw 8,200(31)
	stw 8,204(31)
	stfs 13,16(31)
	stfs 0,24(31)
	stw 6,260(31)
	stw 0,68(31)
	lwz 0,gi+32@l(5)
	mtlr 0
	blrl
	lwz 8,184(31)
	lis 10,prox_land@ha
	mulli 7,30,90
	lis 9,Prox_Explode@ha
	lwz 0,264(31)
	lis 11,.LC7@ha
	cmpwi 0,30,2
	la 10,prox_land@l(10)
	la 9,Prox_Explode@l(9)
	stw 3,40(31)
	la 11,.LC7@l(11)
	ori 8,8,8
	stw 22,564(31)
	ori 0,0,8192
	stw 10,444(31)
	stw 9,436(31)
	stw 7,516(31)
	stw 11,280(31)
	stw 8,184(31)
	stw 0,264(31)
	stw 22,256(31)
	bc 12,2,.L91
	bc 12,1,.L96
	cmpwi 0,30,1
	b .L94
.L96:
	cmpwi 0,30,4
	bc 12,2,.L92
	cmpwi 0,30,8
	bc 12,2,.L93
	b .L94
.L91:
	lis 11,.LC42@ha
	lis 9,level+4@ha
	la 11,.LC42@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	b .L97
.L92:
	lis 10,.LC43@ha
	lis 9,level+4@ha
	la 10,.LC43@l(10)
	b .L98
.L93:
	lis 11,.LC44@ha
	lis 9,level+4@ha
	la 11,.LC44@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	b .L97
.L94:
	lis 10,.LC41@ha
	lis 9,level+4@ha
	la 10,.LC41@l(10)
.L98:
	lfs 0,level+4@l(9)
	lfs 13,0(10)
.L97:
	fadds 0,0,13
	stfs 0,428(31)
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
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
	.size	 fire_prox,.Lfe4-fire_prox
	.section	".rodata"
	.align 2
.LC45:
	.string	"weapons/swish.wav"
	.align 2
.LC46:
	.string	"weapons/meatht.wav"
	.align 2
.LC47:
	.string	"weapons/tink1.wav"
	.align 3
.LC48:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC49:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC50:
	.long 0x3f800000
	.align 2
.LC51:
	.long 0x0
	.align 2
.LC52:
	.long 0x42960000
	.align 2
.LC53:
	.long 0x43800000
	.section	".text"
	.align 2
	.globl fire_player_melee
	.type	 fire_player_melee,@function
fire_player_melee:
	stwu 1,-208(1)
	mflr 0
	stmw 22,168(1)
	stw 0,212(1)
	addi 28,1,64
	mr 27,4
	mr 31,3
	mr 24,9
	mr 22,7
	mr 30,8
	mr 25,10
	mr 29,6
	mr 3,5
	mr 4,28
	bl vectoangles2
	addi 23,1,48
	addi 26,1,80
	addi 4,1,16
	addi 5,1,32
	mr 6,23
	mr 3,28
	bl AngleVectors
	addi 3,1,16
	bl VectorNormalize
	xoris 29,29,0x8000
	stw 29,164(1)
	lis 0,0x4330
	lis 11,.LC48@ha
	stw 0,160(1)
	la 11,.LC48@l(11)
	addi 4,1,16
	lfd 0,0(11)
	mr 3,27
	mr 5,26
	lfd 1,160(1)
	fsub 1,1,0
	frsp 1,1
	bl VectorMA
	lis 11,gi@ha
	lis 9,0x600
	la 28,gi@l(11)
	ori 9,9,3
	lwz 11,48(28)
	mr 4,27
	addi 3,1,96
	li 5,0
	li 6,0
	mr 7,26
	mr 8,31
	mtlr 11
	blrl
	lfs 0,104(1)
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L100
	cmpwi 0,24,0
	bc 4,2,.L99
	lwz 9,36(28)
	lis 3,.LC45@ha
	la 3,.LC45@l(3)
	mtlr 9
	blrl
	lis 9,.LC50@ha
	lwz 0,16(28)
	b .L108
.L100:
	lwz 11,148(1)
	lwz 9,512(11)
	addi 9,9,-1
	cmplwi 0,9,1
	bc 12,1,.L102
	lis 9,.LC52@ha
	addi 29,31,376
	la 9,.LC52@l(9)
	addi 4,1,16
	lfs 1,0(9)
	mr 3,29
	mr 5,29
	bl VectorMA
	lis 9,.LC52@ha
	mr 3,29
	la 9,.LC52@l(9)
	mr 4,23
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	cmpwi 0,25,40
	bc 4,2,.L103
	lwz 3,148(1)
	srwi 10,30,31
	lis 6,vec3_origin@ha
	add 10,30,10
	la 6,vec3_origin@l(6)
	stw 25,12(1)
	li 0,72
	mr 9,22
	stw 0,8(1)
	srawi 10,10,1
	mr 4,31
	mr 5,31
	addi 7,3,4
	mr 8,6
	bl T_Damage
	b .L104
.L103:
	lwz 3,148(1)
	srwi 10,30,31
	lis 6,vec3_origin@ha
	add 10,30,10
	la 6,vec3_origin@l(6)
	stw 25,12(1)
	li 0,8
	mr 9,22
	stw 0,8(1)
	srawi 10,10,1
	mr 4,31
	mr 5,31
	addi 7,3,4
	mr 8,6
	bl T_Damage
.L104:
	cmpwi 0,24,0
	bc 4,2,.L99
	lis 29,gi@ha
	lis 3,.LC46@ha
	la 29,gi@l(29)
	la 3,.LC46@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC50@ha
	lwz 0,16(29)
.L108:
	lis 11,.LC50@ha
	la 9,.LC50@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC50@l(11)
	li 4,1
	mtlr 0
	lis 9,.LC51@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC51@l(9)
	lfs 3,0(9)
	blrl
	b .L99
.L102:
	cmpwi 0,24,0
	bc 4,2,.L107
	lwz 9,36(28)
	lis 3,.LC47@ha
	la 3,.LC47@l(3)
	mtlr 9
	blrl
	lis 9,.LC50@ha
	lwz 11,16(28)
	mr 5,3
	la 9,.LC50@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 11
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 2,0(9)
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 3,0(9)
	blrl
.L107:
	lis 9,.LC53@ha
	addi 29,1,108
	la 9,.LC53@l(9)
	mr 4,26
	lfs 1,0(9)
	addi 3,1,120
	bl VectorScale
	lwz 9,100(28)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(28)
	li 3,0
	mtlr 9
	blrl
	lwz 9,120(28)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,124(28)
	mr 3,26
	mtlr 9
	blrl
	lwz 0,88(28)
	mr 3,29
	li 4,2
	mtlr 0
	blrl
.L99:
	lwz 0,212(1)
	mtlr 0
	lmw 22,168(1)
	la 1,208(1)
	blr
.Lfe5:
	.size	 fire_player_melee,.Lfe5-fire_player_melee
	.section	".rodata"
	.align 3
.LC54:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl blaster2_touch
	.type	 blaster2_touch,@function
blaster2_touch:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 31,3
	mr 30,4
	lwz 0,256(31)
	mr 28,5
	cmpw 0,30,0
	bc 12,2,.L109
	cmpwi 0,6,0
	bc 12,2,.L111
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L111
	bl G_FreeEdict
	b .L109
.L111:
	lwz 3,256(31)
	addi 29,31,4
	cmpwi 0,3,0
	bc 12,2,.L112
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L112
	mr 4,29
	li 5,2
	bl PlayerNoise
.L112:
	lwz 0,512(30)
	cmpwi 0,0,0
	bc 12,2,.L113
	lwz 11,256(31)
	lwz 9,84(11)
	cmpwi 7,11,0
	addic 9,9,-1
	subfe 9,9,9
	nor 0,9,9
	andi. 9,9,43
	andi. 0,0,50
	or 26,9,0
	bc 12,30,.L116
	lwz 27,512(11)
	li 0,0
	stw 0,512(11)
	lwz 11,516(31)
	cmpwi 0,11,4
	bc 4,1,.L117
	slwi 0,11,1
	lfs 2,524(31)
	add 0,0,11
	lis 10,.LC54@ha
	lwz 4,256(31)
	xoris 0,0,0x8000
	lis 11,0x4330
	stw 0,20(1)
	la 10,.LC54@l(10)
	mr 3,31
	stw 11,16(1)
	mr 5,30
	li 6,0
	lfd 0,0(10)
	lfd 1,16(1)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
.L117:
	lwz 9,516(31)
	li 0,4
	mr 3,30
	lwz 5,256(31)
	mr 7,29
	mr 8,28
	stw 0,8(1)
	mr 4,31
	addi 6,31,376
	stw 26,12(1)
	li 10,1
	bl T_Damage
	lwz 9,256(31)
	stw 27,512(9)
	b .L120
.L116:
	lwz 11,516(31)
	cmpwi 0,11,4
	bc 4,1,.L119
	slwi 0,11,1
	lfs 2,524(31)
	add 0,0,11
	lis 10,.LC54@ha
	xoris 0,0,0x8000
	lis 11,0x4330
	stw 0,20(1)
	la 10,.LC54@l(10)
	mr 3,31
	stw 11,16(1)
	li 4,0
	mr 5,30
	lfd 0,0(10)
	li 6,0
	lfd 1,16(1)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
.L119:
	lwz 5,256(31)
	li 0,4
	mr 3,30
	lwz 9,516(31)
	mr 7,29
	mr 8,28
	stw 0,8(1)
	mr 4,31
	addi 6,31,376
	stw 26,12(1)
	li 10,1
	bl T_Damage
	b .L120
.L113:
	lwz 11,516(31)
	cmpwi 0,11,4
	bc 4,1,.L121
	slwi 0,11,1
	lwz 4,256(31)
	add 0,0,11
	lis 10,.LC54@ha
	lfs 2,524(31)
	xoris 0,0,0x8000
	lis 11,0x4330
	stw 0,20(1)
	la 10,.LC54@l(10)
	mr 3,31
	stw 11,16(1)
	mr 5,4
	li 6,0
	lfd 0,0(10)
	lfd 1,16(1)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
.L121:
	lis 9,gi@ha
	li 3,3
	la 30,gi@l(9)
	lwz 9,100(30)
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,30
	mtlr 9
	blrl
	lwz 9,120(30)
	mr 3,29
	mtlr 9
	blrl
	cmpwi 0,28,0
	bc 4,2,.L122
	lwz 0,124(30)
	lis 3,vec3_origin@ha
	la 3,vec3_origin@l(3)
	mtlr 0
	blrl
	b .L123
.L122:
	lwz 0,124(30)
	mr 3,28
	mtlr 0
	blrl
.L123:
	lis 9,gi+88@ha
	mr 3,29
	lwz 0,gi+88@l(9)
	li 4,2
	mtlr 0
	blrl
.L120:
	mr 3,31
	bl G_FreeEdict
.L109:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 blaster2_touch,.Lfe6-blaster2_touch
	.section	".rodata"
	.align 2
.LC55:
	.string	"models/proj/laser2/tris.md2"
	.align 2
.LC56:
	.string	"bolt"
	.align 3
.LC57:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC58:
	.long 0x40000000
	.align 3
.LC59:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC60:
	.long 0xc1200000
	.section	".text"
	.align 2
	.globl fire_blaster2
	.type	 fire_blaster2,@function
fire_blaster2:
	stwu 1,-128(1)
	mflr 0
	stmw 25,100(1)
	stw 0,132(1)
	mr 30,5
	mr 27,3
	mr 29,4
	mr 28,8
	mr 26,7
	mr 25,6
	mr 3,30
	bl VectorNormalize
	bl G_Spawn
	lfs 13,0(29)
	mr 31,3
	mr 3,30
	addi 4,31,16
	stfs 13,4(31)
	lfs 0,4(29)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	lfs 0,0(29)
	stfs 0,28(31)
	lfs 13,4(29)
	stfs 13,32(31)
	lfs 0,8(29)
	stfs 0,36(31)
	bl vectoangles2
	xoris 0,26,0x8000
	stw 0,92(1)
	lis 11,0x4330
	lis 10,.LC57@ha
	stw 11,88(1)
	la 10,.LC57@l(10)
	mr 3,30
	lfd 0,0(10)
	addi 4,31,376
	lfd 1,88(1)
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	lwz 11,64(31)
	lis 0,0x600
	cmpwi 0,28,0
	li 9,0
	li 10,8
	or 8,11,28
	ori 0,0,3
	stw 10,260(31)
	li 11,2
	stw 0,252(31)
	stw 11,248(31)
	stw 9,200(31)
	stw 8,64(31)
	stw 9,196(31)
	stw 9,192(31)
	stw 9,188(31)
	stw 9,208(31)
	stw 9,204(31)
	bc 12,2,.L125
	oris 0,8,0x400
	stw 0,64(31)
.L125:
	lis 0,0x4300
	lis 9,gi@ha
	stw 0,524(31)
	la 28,gi@l(9)
	lis 3,.LC55@ha
	lwz 9,32(28)
	la 3,.LC55@l(3)
	addi 29,31,4
	mtlr 9
	blrl
	lis 11,blaster2_touch@ha
	lis 9,.LC58@ha
	stw 3,40(31)
	la 11,blaster2_touch@l(11)
	stw 27,256(31)
	lis 10,level+4@ha
	stw 11,444(31)
	la 9,.LC58@l(9)
	mr 3,31
	lfs 0,level+4@l(10)
	lis 11,.LC56@ha
	lfs 13,0(9)
	la 11,.LC56@l(11)
	lis 9,G_FreeEdict@ha
	stw 25,516(31)
	la 9,G_FreeEdict@l(9)
	stw 11,280(31)
	fadds 0,0,13
	stw 9,436(31)
	stfs 0,428(31)
	lwz 9,72(28)
	mtlr 9
	blrl
	lwz 0,84(27)
	cmpwi 0,0,0
	bc 12,2,.L126
	mr 6,26
	mr 3,27
	mr 4,29
	mr 5,30
	bl check_dodge
.L126:
	lwz 0,48(28)
	lis 9,0x600
	addi 4,27,4
	ori 9,9,3
	addi 3,1,8
	li 5,0
	li 6,0
	mtlr 0
	mr 7,29
	mr 8,31
	blrl
	lfs 0,16(1)
	lis 9,.LC59@ha
	la 9,.LC59@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L127
	lis 10,.LC60@ha
	mr 3,29
	la 10,.LC60@l(10)
	mr 5,3
	lfs 1,0(10)
	mr 4,30
	bl VectorMA
	lwz 0,444(31)
	mr 3,31
	li 5,0
	lwz 4,60(1)
	li 6,0
	mtlr 0
	blrl
.L127:
	lwz 0,132(1)
	mtlr 0
	lmw 25,100(1)
	la 1,128(1)
	blr
.Lfe7:
	.size	 fire_blaster2,.Lfe7-fire_blaster2
	.section	".data"
	.align 2
	.type	 pain_normal.42,@object
	.size	 pain_normal.42,12
pain_normal.42:
	.long 0x0
	.long 0x0
	.long 0x3f800000
	.section	".rodata"
	.align 3
.LC61:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC62:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl tracker_pain_daemon_think
	.type	 tracker_pain_daemon_think,@function
tracker_pain_daemon_think:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L128
	lis 9,level@ha
	lfs 12,288(31)
	lis 11,.LC62@ha
	la 26,level@l(9)
	la 11,.LC62@l(11)
	lfs 0,4(26)
	lfd 13,0(11)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,1,.L130
	lwz 9,540(31)
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 4,2,.L131
	lwz 0,64(9)
	rlwinm 0,0,0,1,31
	stw 0,64(9)
.L131:
	mr 3,31
	bl G_FreeEdict
	b .L128
.L130:
	lwz 3,540(31)
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L133
	lwz 5,256(31)
	li 28,268
	li 27,51
	lwz 9,516(31)
	lis 30,vec3_origin@ha
	lis 29,pain_normal.42@ha
	stw 28,8(1)
	mr 4,31
	la 6,vec3_origin@l(30)
	stw 27,12(1)
	addi 7,3,4
	la 8,pain_normal.42@l(29)
	li 10,0
	bl T_Damage
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L128
	lwz 3,540(31)
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 12,1,.L135
	lwz 9,488(3)
	la 6,vec3_origin@l(30)
	la 8,pain_normal.42@l(29)
	lwz 5,256(31)
	mr 4,31
	addi 7,3,4
	neg 0,9
	stw 28,8(1)
	li 10,0
	addic 9,9,-1
	subfe 9,9,9
	stw 27,12(1)
	andc 0,0,9
	andi. 9,9,500
	or 9,9,0
	bl T_Damage
.L135:
	lwz 11,540(31)
	lis 9,.LC61@ha
	lfd 13,.LC61@l(9)
	lwz 0,64(11)
	oris 0,0,0x8000
	stw 0,64(11)
	lfs 0,4(26)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L128
.L133:
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 4,2,.L139
	lwz 0,64(3)
	rlwinm 0,0,0,1,31
	stw 0,64(3)
.L139:
	mr 3,31
	bl G_FreeEdict
.L128:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 tracker_pain_daemon_think,.Lfe8-tracker_pain_daemon_think
	.section	".rodata"
	.align 2
.LC63:
	.string	"pain daemon"
	.align 3
.LC65:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC66:
	.long 0x430c0000
	.align 3
.LC67:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC68:
	.long 0x43800000
	.section	".text"
	.align 2
	.globl tracker_touch
	.type	 tracker_touch,@function
tracker_touch:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 26,48(1)
	stw 0,84(1)
	mr 31,3
	mr 29,4
	lwz 0,256(31)
	mr 27,5
	cmpw 0,29,0
	bc 12,2,.L145
	cmpwi 0,6,0
	bc 12,2,.L147
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L147
	bl G_FreeEdict
	b .L145
.L147:
	lwz 0,84(31)
	addi 28,31,4
	cmpwi 0,0,0
	bc 12,2,.L148
	lwz 3,256(31)
	mr 4,28
	li 5,2
	bl PlayerNoise
.L148:
	lwz 0,512(29)
	cmpwi 0,0,0
	bc 12,2,.L149
	lwz 0,184(29)
	andi. 9,0,4
	bc 4,2,.L151
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L150
.L151:
	lwz 0,480(29)
	cmpwi 0,0,0
	bc 4,1,.L152
	lwz 0,516(31)
	li 9,260
	li 11,51
	lwz 5,256(31)
	mr 3,29
	mr 4,31
	slwi 10,0,1
	stw 9,8(1)
	addi 6,31,376
	add 10,10,0
	li 9,0
	stw 11,12(1)
	mr 7,28
	mr 8,27
	bl T_Damage
	lwz 0,264(29)
	andi. 9,0,3
	bc 4,2,.L153
	lis 11,.LC66@ha
	lfs 0,384(29)
	la 11,.LC66@l(11)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,384(29)
.L153:
	lwz 0,516(31)
	lis 10,0x4330
	lis 11,.LC67@ha
	mr 8,9
	lwz 26,256(31)
	xoris 0,0,0x8000
	la 11,.LC67@l(11)
	stw 0,44(1)
	cmpwi 0,29,0
	stw 10,40(1)
	lfd 13,0(11)
	lfd 0,40(1)
	lis 11,.LC65@ha
	lfd 31,.LC65@l(11)
	fsub 0,0,13
	frsp 0,0
	fmr 13,0
	fmul 13,13,31
	frsp 0,13
	fadd 0,0,0
	frsp 0,0
	fmr 13,0
	fctiwz 12,13
	stfd 12,40(1)
	lwz 30,44(1)
	bc 12,2,.L149
	bl G_Spawn
	lis 9,.LC63@ha
	lis 11,tracker_pain_daemon_think@ha
	la 9,.LC63@l(9)
	la 11,tracker_pain_daemon_think@l(11)
	lis 10,level@ha
	stw 9,280(3)
	stw 11,436(3)
	la 10,level@l(10)
	lfs 0,4(10)
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(3)
	lfs 13,4(10)
	stw 30,516(3)
	stw 26,256(3)
	stfs 13,288(3)
	stw 29,540(3)
	b .L149
.L152:
	lwz 9,516(31)
	li 0,260
	li 11,51
	lwz 5,256(31)
	mr 3,29
	mr 4,31
	slwi 10,9,1
	stw 0,8(1)
	addi 6,31,376
	add 10,10,9
	stw 11,12(1)
	mr 7,28
	mr 8,27
	slwi 9,9,2
	bl T_Damage
	b .L149
.L150:
	lwz 10,516(31)
	li 0,260
	li 11,51
	lwz 5,256(31)
	mr 3,29
	mr 4,31
	mr 9,10
	stw 0,8(1)
	addi 6,31,376
	slwi 10,10,1
	stw 11,12(1)
	mr 7,28
	add 10,10,9
	mr 8,27
	bl T_Damage
.L149:
	cmpwi 0,27,0
	bc 4,2,.L158
	li 0,0
	stw 0,16(1)
	stw 0,24(1)
	stw 0,20(1)
	b .L159
.L158:
	lis 9,.LC68@ha
	mr 3,27
	la 9,.LC68@l(9)
	addi 4,1,16
	lfs 1,0(9)
	bl VectorScale
.L159:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,47
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	mr 3,31
	bl G_FreeEdict
.L145:
	lwz 0,84(1)
	mtlr 0
	lmw 26,48(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe9:
	.size	 tracker_touch,.Lfe9-tracker_touch
	.section	".rodata"
	.align 3
.LC69:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC70:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC71:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl tracker_fly
	.type	 tracker_fly,@function
tracker_fly:
	stwu 1,-96(1)
	mflr 0
	stmw 28,80(1)
	stw 0,100(1)
	mr 31,3
	lwz 3,540(31)
	cmpwi 0,3,0
	bc 12,2,.L163
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L163
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 12,1,.L162
.L163:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	li 0,0
	lwz 11,100(29)
	addi 9,1,56
	addi 28,31,4
	stw 0,4(9)
	mtlr 11
	stw 0,8(9)
	stw 0,56(1)
	blrl
	lwz 9,100(29)
	li 3,47
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L161
.L162:
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L167
	lfs 13,4(3)
	lis 11,0x4330
	lis 10,.LC70@ha
	la 10,.LC70@l(10)
	stfs 13,8(1)
	lfs 0,8(3)
	lfd 12,0(10)
	stfs 0,12(1)
	lfs 13,12(3)
	stfs 13,16(1)
	lwz 0,508(3)
	xoris 0,0,0x8000
	stw 0,76(1)
	stw 11,72(1)
	lfd 0,72(1)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,16(1)
	b .L168
.L167:
	lis 28,vec3_origin@ha
	addi 3,3,212
	la 4,vec3_origin@l(28)
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L170
	lwz 3,540(31)
	la 4,vec3_origin@l(28)
	addi 3,3,224
	bl VectorCompare
	cmpwi 0,3,0
	bc 12,2,.L169
.L170:
	lwz 9,540(31)
	lfs 0,4(9)
	stfs 0,8(1)
	lfs 13,8(9)
	stfs 13,12(1)
	lfs 0,12(9)
	stfs 0,16(1)
	b .L168
.L169:
	lis 9,.LC71@ha
	lwz 4,540(31)
	addi 29,1,40
	la 9,.LC71@l(9)
	la 3,vec3_origin@l(28)
	lfs 1,0(9)
	addi 4,4,212
	mr 5,29
	bl VectorMA
	lis 9,.LC71@ha
	lwz 4,540(31)
	mr 3,29
	la 9,.LC71@l(9)
	mr 5,3
	lfs 1,0(9)
	addi 4,4,224
	bl VectorMA
	lfs 0,40(1)
	lfs 13,44(1)
	lfs 12,48(1)
	stfs 0,8(1)
	stfs 13,12(1)
	stfs 12,16(1)
.L168:
	lfs 11,4(31)
	addi 29,1,24
	lfs 12,8(1)
	mr 3,29
	lfs 10,8(31)
	lfs 13,12(1)
	fsubs 12,12,11
	lfs 0,16(1)
	lfs 11,12(31)
	fsubs 13,13,10
	stfs 12,24(1)
	fsubs 0,0,11
	stfs 13,28(1)
	stfs 0,32(1)
	bl VectorNormalize
	mr 3,29
	addi 4,31,16
	bl vectoangles2
	lfs 1,328(31)
	mr 3,29
	addi 4,31,376
	bl VectorScale
	lfs 0,12(1)
	lis 9,level+4@ha
	lis 11,.LC69@ha
	lfs 13,16(1)
	lfs 12,8(1)
	stfs 0,840(31)
	stfs 13,844(31)
	stfs 12,836(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC69@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L161:
	lwz 0,100(1)
	mtlr 0
	lmw 28,80(1)
	la 1,96(1)
	blr
.Lfe10:
	.size	 tracker_fly,.Lfe10-tracker_fly
	.section	".rodata"
	.align 2
.LC72:
	.string	"weapons/disrupt.wav"
	.align 2
.LC73:
	.string	"models/proj/disintegrator/tris.md2"
	.align 2
.LC74:
	.string	"tracker"
	.align 3
.LC75:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC76:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC77:
	.long 0x41200000
	.align 3
.LC78:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC79:
	.long 0xc1200000
	.section	".text"
	.align 2
	.globl fire_tracker
	.type	 fire_tracker,@function
fire_tracker:
	stwu 1,-128(1)
	mflr 0
	stfd 31,120(1)
	stmw 25,92(1)
	stw 0,132(1)
	mr 30,5
	mr 26,3
	mr 29,4
	mr 28,8
	mr 27,6
	mr 25,7
	mr 3,30
	bl VectorNormalize
	bl G_Spawn
	lfs 13,0(29)
	mr 31,3
	mr 3,30
	addi 4,31,16
	stfs 13,4(31)
	lfs 0,4(29)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	lfs 0,0(29)
	stfs 0,28(31)
	lfs 13,4(29)
	stfs 13,32(31)
	lfs 0,8(29)
	stfs 0,36(31)
	bl vectoangles2
	xoris 0,25,0x8000
	stw 0,84(1)
	lis 11,0x4330
	lis 10,.LC76@ha
	stw 11,80(1)
	la 10,.LC76@l(10)
	addi 4,31,376
	lfd 0,0(10)
	mr 3,30
	lfd 31,80(1)
	fsub 31,31,0
	frsp 31,31
	fmr 1,31
	bl VectorScale
	lis 0,0x600
	li 11,2
	stfs 31,328(31)
	lis 10,0x400
	ori 0,0,3
	stw 11,248(31)
	li 9,8
	lis 29,gi@ha
	stw 10,64(31)
	la 29,gi@l(29)
	stw 0,252(31)
	lis 3,.LC72@ha
	stw 9,260(31)
	la 3,.LC72@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	li 0,0
	stw 3,76(31)
	stw 0,200(31)
	lis 3,.LC73@ha
	stw 0,196(31)
	la 3,.LC73@l(3)
	stw 0,192(31)
	stw 0,188(31)
	stw 0,208(31)
	stw 0,204(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,tracker_touch@ha
	lis 11,.LC74@ha
	stw 3,40(31)
	la 9,tracker_touch@l(9)
	la 11,.LC74@l(11)
	stw 27,516(31)
	stw 9,444(31)
	mr 3,31
	stw 11,280(31)
	stw 28,540(31)
	stw 26,256(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	cmpwi 0,28,0
	bc 12,2,.L173
	lis 11,level+4@ha
	lis 10,.LC75@ha
	lfs 0,level+4@l(11)
	lis 9,tracker_fly@ha
	lfd 13,.LC75@l(10)
	la 9,tracker_fly@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	b .L177
.L173:
	lis 9,.LC77@ha
	lis 11,level+4@ha
	la 9,.LC77@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,436(31)
.L177:
	stfs 0,428(31)
	lwz 0,84(26)
	addi 29,31,4
	cmpwi 0,0,0
	bc 12,2,.L175
	mr 6,25
	mr 3,26
	mr 4,29
	mr 5,30
	bl check_dodge
.L175:
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	ori 9,9,3
	addi 4,26,4
	addi 3,1,8
	li 5,0
	li 6,0
	mr 7,29
	mtlr 0
	mr 8,31
	blrl
	lfs 0,16(1)
	lis 9,.LC78@ha
	la 9,.LC78@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L176
	lis 10,.LC79@ha
	mr 3,29
	la 10,.LC79@l(10)
	mr 5,3
	lfs 1,0(10)
	mr 4,30
	bl VectorMA
	lwz 0,444(31)
	mr 3,31
	li 5,0
	lwz 4,60(1)
	li 6,0
	mtlr 0
	blrl
.L176:
	lwz 0,132(1)
	mtlr 0
	lmw 25,92(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe11:
	.size	 fire_tracker,.Lfe11-fire_tracker
	.section	".rodata"
	.align 3
.LC80:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl fire_flechette
	.type	 fire_flechette,@function
fire_flechette:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 24,24(1)
	stw 0,68(1)
	mr 30,5
	mr 25,3
	mr 29,4
	mr 24,7
	mr 27,8
	mr 26,6
	mr 3,30
	lis 28,0x4330
	bl VectorNormalize
	lis 9,.LC80@ha
	la 9,.LC80@l(9)
	lfd 31,0(9)
	bl G_Spawn
	lfs 13,0(29)
	mr 31,3
	mr 3,30
	addi 4,31,16
	stfs 13,4(31)
	lfs 0,4(29)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	lfs 0,0(29)
	stfs 0,28(31)
	lfs 13,4(29)
	stfs 13,32(31)
	lfs 0,8(29)
	stfs 0,36(31)
	bl vectoangles2
	xoris 0,24,0x8000
	stw 0,20(1)
	addi 4,31,376
	mr 3,30
	stw 28,16(1)
	lfd 1,16(1)
	fsub 1,1,31
	frsp 1,1
	bl VectorScale
	lis 0,0x600
	li 9,0
	li 10,8
	ori 0,0,3
	stw 9,200(31)
	li 11,2
	lis 29,gi@ha
	stw 0,252(31)
	la 29,gi@l(29)
	stw 11,248(31)
	lis 3,.LC0@ha
	stw 10,68(31)
	la 3,.LC0@l(3)
	stw 10,260(31)
	stw 9,196(31)
	stw 9,192(31)
	stw 9,188(31)
	stw 9,208(31)
	stw 9,204(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	li 0,8000
	stw 3,40(31)
	divw 0,0,24
	mr 10,8
	xoris 27,27,0x8000
	stw 25,256(31)
	lis 9,flechette_touch@ha
	lis 7,level+4@ha
	la 9,flechette_touch@l(9)
	lis 11,G_FreeEdict@ha
	stw 9,444(31)
	la 11,G_FreeEdict@l(11)
	mr 3,31
	lfs 12,level+4@l(7)
	stw 11,436(31)
	stw 26,516(31)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 28,16(1)
	lfd 13,16(1)
	stw 27,20(1)
	stw 28,16(1)
	lfd 0,16(1)
	fsub 13,13,31
	fsub 0,0,31
	frsp 13,13
	frsp 0,0
	fadds 12,12,13
	stfs 0,524(31)
	stfs 12,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 0,84(25)
	cmpwi 0,0,0
	bc 12,2,.L15
	mr 3,25
	addi 4,31,4
	mr 5,30
	mr 6,24
	bl check_dodge
.L15:
	lwz 0,68(1)
	mtlr 0
	lmw 24,24(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe12:
	.size	 fire_flechette,.Lfe12-fire_flechette
	.section	".rodata"
	.align 2
.LC81:
	.long 0x43800000
	.section	".text"
	.align 2
	.globl flechette_touch
	.type	 flechette_touch,@function
flechette_touch:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	mr 31,3
	mr 29,4
	lwz 0,256(31)
	mr 30,5
	cmpw 0,29,0
	bc 12,2,.L6
	cmpwi 0,6,0
	bc 12,2,.L8
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L8
	bl G_FreeEdict
	b .L6
.L8:
	lwz 0,84(31)
	addi 28,31,4
	cmpwi 0,0,0
	bc 12,2,.L9
	lwz 3,256(31)
	mr 4,28
	li 5,2
	bl PlayerNoise
.L9:
	lwz 0,512(29)
	cmpwi 0,0,0
	bc 12,2,.L10
	lfs 0,524(31)
	li 0,128
	lwz 5,256(31)
	li 11,42
	mr 3,29
	lwz 9,516(31)
	mr 7,28
	mr 8,30
	stw 0,8(1)
	mr 4,31
	addi 6,31,376
	stw 11,12(1)
	fctiwz 13,0
	stfd 13,40(1)
	lwz 10,44(1)
	bl T_Damage
	b .L11
.L10:
	cmpwi 0,30,0
	bc 4,2,.L12
	li 0,0
	stw 0,16(1)
	stw 0,24(1)
	stw 0,20(1)
	b .L13
.L12:
	lis 9,.LC81@ha
	mr 3,30
	la 9,.LC81@l(9)
	addi 4,1,16
	lfs 1,0(9)
	bl VectorScale
.L13:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,55
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,124(29)
	addi 3,1,16
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
.L11:
	mr 3,31
	bl G_FreeEdict
.L6:
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe13:
	.size	 flechette_touch,.Lfe13-flechette_touch
	.section	".rodata"
	.align 3
.LC82:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl prox_die
	.type	 prox_die,@function
prox_die:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 9,.LC7@ha
	lwz 3,280(4)
	la 4,.LC7@l(9)
	bl strcmp
	mr. 3,3
	bc 12,2,.L23
	li 0,0
	mr 3,31
	stw 0,512(31)
	bl Prox_Explode
	b .L24
.L23:
	lis 9,Prox_Explode@ha
	stw 3,512(31)
	lis 10,level+4@ha
	la 9,Prox_Explode@l(9)
	lis 11,.LC82@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC82@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L24:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 prox_die,.Lfe14-prox_die
	.section	".rodata"
	.align 2
.LC83:
	.long 0x3f800000
	.align 2
.LC84:
	.long 0x0
	.align 3
.LC85:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Prox_Field_Touch
	.type	 Prox_Field_Touch,@function
Prox_Field_Touch:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lwz 0,184(4)
	mr 31,3
	andi. 9,0,4
	bc 4,2,.L26
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L25
.L26:
	lwz 30,256(31)
	cmpw 0,4,30
	bc 12,2,.L25
	lwz 0,436(30)
	lis 9,Prox_Explode@ha
	la 28,Prox_Explode@l(9)
	cmpw 0,0,28
	bc 12,2,.L25
	lwz 0,560(30)
	cmpw 0,0,31
	bc 4,2,.L29
	lis 29,gi@ha
	lis 3,.LC9@ha
	la 29,gi@l(29)
	la 3,.LC9@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC83@ha
	lwz 0,16(29)
	lis 11,.LC83@ha
	la 9,.LC83@l(9)
	la 11,.LC83@l(11)
	lfs 1,0(9)
	mr 5,3
	li 4,2
	mtlr 0
	lis 9,.LC84@ha
	lfs 2,0(11)
	mr 3,31
	la 9,.LC84@l(9)
	lfs 3,0(9)
	blrl
	stw 28,436(30)
	lis 9,level+4@ha
	lis 11,.LC85@ha
	lfs 0,level+4@l(9)
	la 11,.LC85@l(11)
	lfd 13,0(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
	b .L25
.L29:
	li 0,0
	mr 3,31
	stw 0,248(31)
	bl G_FreeEdict
.L25:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 Prox_Field_Touch,.Lfe15-Prox_Field_Touch
	.section	".rodata"
	.align 3
.LC86:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl prox_seek
	.type	 prox_seek,@function
prox_seek:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,level@ha
	lfs 13,592(3)
	la 10,level@l(9)
	lfs 0,4(10)
	fcmpu 0,0,13
	bc 4,1,.L31
	bl Prox_Explode
	b .L32
.L31:
	lwz 9,56(3)
	addi 9,9,1
	cmpwi 0,9,13
	stw 9,56(3)
	bc 4,1,.L33
	li 0,9
	stw 0,56(3)
.L33:
	lis 9,prox_seek@ha
	lis 11,.LC86@ha
	la 9,prox_seek@l(9)
	lfd 13,.LC86@l(11)
	stw 9,436(3)
	lfs 0,4(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
.L32:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 prox_seek,.Lfe16-prox_seek
	.section	".rodata"
	.align 3
.LC87:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl tracker_pain_daemon_spawn
	.type	 tracker_pain_daemon_spawn,@function
tracker_pain_daemon_spawn:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr. 29,4
	mr 30,3
	mr 31,5
	bc 12,2,.L140
	bl G_Spawn
	lis 9,.LC63@ha
	lis 11,tracker_pain_daemon_think@ha
	la 9,.LC63@l(9)
	la 11,tracker_pain_daemon_think@l(11)
	lis 10,level@ha
	stw 9,280(3)
	stw 11,436(3)
	la 10,level@l(10)
	lis 9,.LC87@ha
	lfs 0,4(10)
	lfd 13,.LC87@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	lfs 13,4(10)
	stw 31,516(3)
	stw 30,256(3)
	stfs 13,288(3)
	stw 29,540(3)
.L140:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 tracker_pain_daemon_spawn,.Lfe17-tracker_pain_daemon_spawn
	.section	".rodata"
	.align 2
.LC88:
	.long 0x43800000
	.section	".text"
	.align 2
	.globl tracker_explode
	.type	 tracker_explode,@function
tracker_explode:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr. 4,4
	mr 31,3
	bc 4,2,.L143
	li 0,0
	stw 0,8(1)
	stw 0,16(1)
	stw 0,12(1)
	b .L144
.L143:
	lis 9,.LC88@ha
	mr 3,4
	la 9,.LC88@l(9)
	addi 4,1,8
	lfs 1,0(9)
	bl VectorScale
.L144:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,31,4
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,47
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	mr 3,31
	bl G_FreeEdict
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 tracker_explode,.Lfe18-tracker_explode
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
