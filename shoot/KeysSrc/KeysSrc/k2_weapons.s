	.file	"k2_weapons.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.section	".rodata"
	.align 3
.LC0:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC1:
	.long 0x0
	.align 2
.LC2:
	.long 0x45000000
	.section	".text"
	.align 2
	.globl K2_HomingThink
	.type	 K2_HomingThink,@function
K2_HomingThink:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 30,0
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L25
	addi 29,31,4
	b .L8
.L10:
	cmpw 0,30,31
	bc 12,2,.L8
	lwz 8,256(31)
	cmpw 0,30,8
	bc 12,2,.L8
	lwz 0,512(30)
	cmpwi 0,0,0
	bc 12,2,.L8
	lwz 10,84(30)
	cmpwi 0,10,0
	bc 12,2,.L8
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L8
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 4,2,.L8
	lis 9,.LC1@ha
	lis 11,ctf@ha
	la 9,.LC1@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L17
	lwz 9,84(8)
	lwz 11,3468(10)
	lwz 0,3468(9)
	cmpw 0,11,0
	bc 12,2,.L8
	cmpwi 0,11,0
	bc 12,2,.L8
.L17:
	lwz 0,3988(10)
	cmpwi 0,0,1
	bc 12,2,.L8
	cmpwi 0,0,32
	bc 12,2,.L8
	mr 3,31
	mr 4,30
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L8
	mr 3,31
	mr 4,30
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L8
	stw 30,540(31)
.L8:
	lis 9,.LC2@ha
	mr 3,30
	la 9,.LC2@l(9)
	mr 4,29
	lfs 1,0(9)
	bl findradius
	mr. 30,3
	bc 4,2,.L10
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 12,2,.L24
.L25:
	lwz 0,64(31)
	lis 9,K2_HomeTarget@ha
	lwz 11,68(31)
	la 9,K2_HomeTarget@l(9)
	ori 0,0,256
	stw 9,436(31)
	ori 11,11,2048
	stw 0,64(31)
	stw 11,68(31)
.L24:
	mr 3,31
	bl K2_HomingInformDanger
	lis 9,level+4@ha
	lis 11,.LC0@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC0@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 K2_HomingThink,.Lfe1-K2_HomingThink
	.section	".rodata"
	.align 2
.LC4:
	.string	"misc/comp_up.wav"
	.align 2
.LC5:
	.string	"weapons/noammo.wav"
	.align 3
.LC3:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC6:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC7:
	.long 0x3f800000
	.align 2
.LC8:
	.long 0x0
	.section	".text"
	.align 2
	.globl K2_HomeTarget
	.type	 K2_HomeTarget,@function
K2_HomeTarget:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 29,44(1)
	stw 0,68(1)
	mr 31,3
	lwz 4,540(31)
	lwz 0,492(4)
	cmpwi 0,0,0
	bc 4,2,.L28
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L28
	lwz 3,540(31)
	lwz 0,612(3)
	cmpwi 0,0,2
	bc 12,1,.L28
	bl K2_IsAnti
	cmpwi 0,3,0
	bc 4,2,.L28
	lwz 3,540(31)
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 4,2,.L28
	lwz 9,540(31)
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 4,2,.L27
.L28:
	lwz 9,64(31)
	lis 11,K2_HomingThink@ha
	li 10,0
	lwz 0,68(31)
	la 11,K2_HomingThink@l(11)
	lis 7,level+4@ha
	rlwinm 9,9,0,24,22
	stw 10,540(31)
	lis 8,.LC3@ha
	rlwinm 0,0,0,21,19
	stw 9,64(31)
	stw 0,68(31)
	stw 11,436(31)
	lfs 0,level+4@l(7)
	lfd 13,.LC3@l(8)
	b .L32
.L27:
	lfs 13,4(9)
	lis 11,.LC6@ha
	addi 3,1,8
	lfs 0,4(31)
	la 11,.LC6@l(11)
	lis 29,0x4330
	lfs 11,12(31)
	lfs 12,8(31)
	fsubs 13,13,0
	lfd 31,0(11)
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorNormalize
	lfs 0,12(1)
	addi 3,1,8
	addi 4,31,16
	lfs 13,16(1)
	lfs 12,8(1)
	stfs 0,344(31)
	stfs 13,348(31)
	stfs 12,340(31)
	bl vectoangles
	lwz 0,1336(31)
	addi 3,1,8
	addi 4,31,376
	xoris 0,0,0x8000
	stw 0,36(1)
	stw 29,32(1)
	lfd 1,32(1)
	fsub 1,1,31
	frsp 1,1
	bl VectorScale
	lis 11,level@ha
	lfs 13,1340(31)
	lwz 0,level@l(11)
	xoris 0,0,0x8000
	stw 0,36(1)
	stw 29,32(1)
	lfd 0,32(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,0,.L29
	lwz 0,520(31)
	cmpwi 0,0,0
	bc 12,2,.L30
	lis 29,gi@ha
	lis 3,.LC4@ha
	la 29,gi@l(29)
	la 3,.LC4@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC7@ha
	lwz 0,16(29)
	lis 11,.LC7@ha
	la 9,.LC7@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC7@l(11)
	li 4,0
	mtlr 0
	lis 9,.LC8@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC8@l(9)
	lfs 3,0(9)
	blrl
	b .L31
.L30:
	lis 29,gi@ha
	lis 3,.LC5@ha
	la 29,gi@l(29)
	la 3,.LC5@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC7@ha
	lwz 0,16(29)
	lis 11,.LC7@ha
	la 9,.LC7@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC7@l(11)
	li 4,0
	mtlr 0
	lis 9,.LC8@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC8@l(9)
	lfs 3,0(9)
	blrl
.L31:
	lis 11,level@ha
	lwz 9,level@l(11)
	lis 0,0x4330
	lis 11,.LC6@ha
	addi 9,9,5
	la 11,.LC6@l(11)
	xoris 9,9,0x8000
	lfd 13,0(11)
	stw 9,36(1)
	stw 0,32(1)
	lfd 0,32(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,1340(31)
.L29:
	mr 3,31
	bl K2_HomingInformDanger
	lis 9,level+4@ha
	lis 11,.LC3@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC3@l(11)
.L32:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,68(1)
	mtlr 0
	lmw 29,44(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe2:
	.size	 K2_HomeTarget,.Lfe2-K2_HomeTarget
	.section	".rodata"
	.align 2
.LC11:
	.string	"You are blinded by %s's flash grenade!!!\n"
	.align 2
.LC12:
	.string	"%s is blinded by your flash grenade!\n"
	.align 3
.LC13:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC14:
	.long 0x0
	.align 2
.LC15:
	.long 0x41200000
	.align 2
.LC16:
	.long 0x41a00000
	.align 2
.LC17:
	.long 0x40000000
	.align 2
.LC18:
	.long 0x3f800000
	.align 3
.LC19:
	.long 0x3ff80000
	.long 0x0
	.align 3
.LC20:
	.long 0x3fe80000
	.long 0x0
	.align 3
.LC21:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Flash_Explode
	.type	 Flash_Explode,@function
Flash_Explode:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 28,56(1)
	stw 0,84(1)
	lis 10,.LC13@ha
	mr 31,3
	la 10,.LC13@l(10)
	lwz 0,516(31)
	lfd 10,0(10)
	lis 11,0x4330
	lis 10,.LC14@ha
	xoris 0,0,0x8000
	lfs 11,4(31)
	la 10,.LC14@l(10)
	stw 0,52(1)
	li 5,0
	lfs 12,0(10)
	li 6,36
	lfs 13,8(31)
	lis 10,.LC15@ha
	stw 11,48(1)
	la 10,.LC15@l(10)
	lfd 1,48(1)
	fadds 11,11,12
	lfs 0,12(31)
	fadds 13,13,12
	lfs 9,0(10)
	fsub 1,1,10
	lfs 2,524(31)
	lwz 4,256(31)
	fadds 0,0,9
	stfs 11,4(31)
	stfs 13,8(31)
	frsp 1,1
	stfs 12,8(1)
	stfs 0,12(31)
	stfs 12,12(1)
	stfs 9,16(1)
	bl T_RadiusDamage
	lwz 3,256(31)
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L39
	addi 4,31,4
	li 5,2
	bl PlayerNoise
.L39:
	li 30,0
	addi 29,31,4
	lis 28,flash_radius@ha
	b .L40
.L42:
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L40
	mr 3,31
	mr 4,30
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L40
	mr 3,30
	mr 4,31
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L40
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 4,2,.L40
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L40
	mr 3,30
	bl K2_IsProtected
	cmpwi 0,3,0
	bc 4,2,.L40
	lfs 0,4(30)
	addi 3,1,24
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 0,8(30)
	fsubs 12,12,0
	stfs 12,28(1)
	lfs 0,12(30)
	fsubs 11,11,0
	stfs 11,32(1)
	bl VectorLength
	lwz 9,flash_radius@l(28)
	lis 10,.LC16@ha
	la 10,.LC16@l(10)
	lfs 0,0(10)
	lfs 11,20(9)
	fdivs 0,11,0
	fcmpu 0,1,0
	bc 4,0,.L49
	lis 9,.LC15@ha
	lis 11,blindtime@ha
	la 9,.LC15@l(9)
	lfs 13,0(9)
	lwz 9,blindtime@l(11)
	lfs 0,20(9)
	fmuls 31,0,13
	b .L50
.L49:
	fadds 11,11,11
	lis 10,.LC17@ha
	lis 11,.LC18@ha
	la 10,.LC17@l(10)
	la 11,.LC18@l(11)
	lfs 8,0(10)
	lis 9,blindtime@ha
	fsubs 0,1,11
	lfs 9,0(11)
	lis 10,.LC15@ha
	lwz 11,blindtime@l(9)
	la 10,.LC15@l(10)
	lfs 10,0(10)
	lis 9,.LC19@ha
	fdivs 0,0,11
	lfs 13,20(11)
	la 9,.LC19@l(9)
	lfd 12,0(9)
	fsubs 0,0,8
	fmuls 13,13,10
	fdivs 0,9,0
	fadds 0,0,9
	fmul 13,13,12
	fmul 13,13,0
	frsp 31,13
.L50:
	lis 10,.LC14@ha
	la 10,.LC14@l(10)
	lfs 0,0(10)
	fcmpu 0,31,0
	bc 4,0,.L51
	lis 11,.LC14@ha
	la 11,.LC14@l(11)
	lfs 31,0(11)
.L51:
	mr 3,30
	mr 4,31
	bl infront
	cmpwi 0,3,0
	bc 4,2,.L52
	lis 9,.LC20@ha
	fmr 0,31
	la 9,.LC20@l(9)
	lfd 13,0(9)
	fmul 0,0,13
	frsp 31,0
.L52:
	lwz 0,256(31)
	cmpw 0,30,0
	bc 4,2,.L53
	lwz 11,84(30)
	lis 10,.LC21@ha
	fmr 13,31
	lis 9,blindtime@ha
	la 10,.LC21@l(10)
	lfs 0,4024(11)
	lfd 12,0(10)
	lwz 10,blindtime@l(9)
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 11,0(9)
	fmadd 13,13,12,0
	frsp 13,13
	stfs 13,4024(11)
	lfs 0,20(10)
	lwz 9,84(30)
	fmuls 0,0,11
	stfs 0,4028(9)
	b .L40
.L53:
	lis 11,.LC15@ha
	lis 9,blindtime@ha
	lwz 10,84(30)
	la 11,.LC15@l(11)
	lfs 11,0(11)
	lwz 11,blindtime@l(9)
	lfs 13,4024(10)
	lis 9,.LC19@ha
	lfs 0,20(11)
	la 9,.LC19@l(9)
	lfd 12,0(9)
	fmuls 0,0,11
	fmadd 0,0,12,13
	frsp 0,0
	stfs 0,4024(10)
	lfs 13,20(11)
	lwz 9,84(30)
	fmuls 13,13,11
	stfs 13,4028(9)
	lwz 0,968(30)
	cmpwi 0,0,0
	bc 4,2,.L54
	lwz 9,256(31)
	lis 5,.LC11@ha
	mr 3,30
	la 5,.LC11@l(5)
	li 4,2
	lwz 6,84(9)
	addi 6,6,700
	crxor 6,6,6
	bl safe_cprintf
.L54:
	lwz 3,256(31)
	cmpw 0,30,3
	bc 12,2,.L55
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L55
	lwz 6,84(30)
	lis 5,.LC12@ha
	li 4,2
	la 5,.LC12@l(5)
	addi 6,6,700
	crxor 6,6,6
	bl safe_cprintf
.L55:
	lwz 0,968(30)
	cmpwi 0,0,0
	bc 12,2,.L40
	li 0,0
	stw 0,540(30)
.L40:
	lis 9,flash_radius@ha
	mr 3,30
	lwz 11,flash_radius@l(9)
	mr 4,29
	lfs 1,20(11)
	bl findradius
	mr. 30,3
	bc 4,2,.L42
	mr 3,31
	bl BecomeExplosion1
	lwz 0,84(1)
	mtlr 0
	lmw 28,56(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe3:
	.size	 Flash_Explode,.Lfe3-Flash_Explode
	.section	".rodata"
	.align 2
.LC23:
	.string	"weapons/hgrenb1a.wav"
	.align 2
.LC24:
	.string	"weapons/hgrenb2a.wav"
	.align 2
.LC25:
	.string	"weapons/grenlb1b.wav"
	.align 2
.LC26:
	.string	"models/objects/rocket/tris.md2"
	.align 2
.LC27:
	.string	"drunk_rocket"
	.align 2
.LC28:
	.string	"weapons/rockfly.wav"
	.align 2
.LC29:
	.long 0x44228000
	.align 3
.LC30:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC31:
	.long 0x0
	.align 2
.LC32:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl Rocket_DrunkThink
	.type	 Rocket_DrunkThink,@function
Rocket_DrunkThink:
	stwu 1,-48(1)
	mflr 0
	stw 31,44(1)
	stw 0,52(1)
	mr 31,3
	bl rand
	lis 9,.LC31@ha
	srawi 11,3,31
	la 9,.LC31@l(9)
	lfs 11,0(9)
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 10,0(9)
	lis 9,0x5555
	stfs 11,28(1)
	ori 9,9,21846
	stfs 11,32(1)
	mulhw 9,3,9
	stfs 10,24(1)
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf 9,0,3
	cmpwi 0,9,1
	bc 4,2,.L69
	lfs 0,340(31)
	lfs 13,344(31)
	lfs 12,348(31)
	fadds 0,0,10
	fadds 13,13,11
	fadds 12,12,11
	b .L73
.L69:
	cmpwi 0,9,2
	bc 4,2,.L71
	lfs 0,340(31)
	lfs 13,344(31)
	lfs 12,348(31)
	fsubs 0,0,10
	fsubs 13,13,11
	fsubs 12,12,11
	b .L73
.L71:
	lfs 0,340(31)
	lfs 13,344(31)
	lfs 12,348(31)
.L73:
	stfs 0,8(1)
	stfs 13,12(1)
	stfs 12,16(1)
	addi 3,1,8
	bl VectorNormalize
	lfs 0,12(1)
	addi 3,1,8
	addi 4,31,16
	lfs 13,16(1)
	lfs 12,8(1)
	stfs 0,344(31)
	stfs 13,348(31)
	stfs 12,340(31)
	bl vectoangles
	lis 9,.LC29@ha
	addi 3,1,8
	lfs 1,.LC29@l(9)
	addi 4,31,376
	bl VectorScale
	lis 9,level+4@ha
	lis 11,.LC30@ha
	lfs 0,level+4@l(9)
	lis 10,gi+72@ha
	mr 3,31
	lfd 13,.LC30@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lwz 31,44(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 Rocket_DrunkThink,.Lfe4-Rocket_DrunkThink
	.section	".rodata"
	.align 2
.LC33:
	.long 0x3f000000
	.align 2
.LC34:
	.long 0x0
	.section	".text"
	.align 2
	.globl K2_Fire_Radius_Explosions
	.type	 K2_Fire_Radius_Explosions,@function
K2_Fire_Radius_Explosions:
	stwu 1,-128(1)
	mflr 0
	stmw 29,116(1)
	stw 0,132(1)
	lis 9,.LC33@ha
	lfs 11,4(3)
	addi 31,1,8
	la 9,.LC33@l(9)
	lfs 0,524(3)
	addi 29,1,44
	lfs 12,0(9)
	lis 9,.LC34@ha
	lfs 10,12(3)
	la 9,.LC34@l(9)
	lfs 13,0(9)
	fmuls 0,0,12
	lfs 12,8(3)
	lis 9,gi@ha
	la 30,gi@l(9)
	fsubs 9,11,13
	stfs 13,88(1)
	fsubs 4,10,13
	stfs 0,92(1)
	fsubs 8,12,0
	stfs 13,96(1)
	stfs 9,44(1)
	fadds 7,11,0
	fadds 6,12,13
	stfs 4,52(1)
	fsubs 5,11,0
	stfs 8,48(1)
	fsubs 9,12,13
	stfs 7,8(1)
	fadds 10,10,13
	stfs 6,12(1)
	fadds 11,11,13
	stfs 5,20(1)
	fadds 12,12,0
	stfs 9,24(1)
	stfs 10,40(1)
	stfs 11,32(1)
	stfs 12,36(1)
	stfs 10,16(1)
	stfs 4,28(1)
.L78:
	lwz 9,100(30)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,5
	mtlr 9
	blrl
	lwz 9,120(30)
	mr 3,31
	mtlr 9
	blrl
	lwz 9,88(30)
	mr 3,31
	li 4,2
	addi 31,31,12
	mtlr 9
	blrl
	cmpw 0,31,29
	bc 4,1,.L78
	lwz 0,132(1)
	mtlr 0
	lmw 29,116(1)
	la 1,128(1)
	blr
.Lfe5:
	.size	 K2_Fire_Radius_Explosions,.Lfe5-K2_Fire_Radius_Explosions
	.section	".rodata"
	.align 2
.LC35:
	.string	"flame"
	.align 2
.LC36:
	.string	"player/burn1.wav"
	.align 2
.LC37:
	.string	"player/burn2.wav"
	.align 3
.LC38:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC40:
	.long 0x3f800000
	.align 2
.LC41:
	.long 0x0
	.align 2
.LC42:
	.long 0x42800000
	.section	".text"
	.align 2
	.globl K2_FlameBurnDamage
	.type	 K2_FlameBurnDamage,@function
K2_FlameBurnDamage:
	stwu 1,-80(1)
	mflr 0
	stmw 23,44(1)
	stw 0,84(1)
	mr 30,3
	li 31,0
	lwz 11,540(30)
	cmpwi 0,11,0
	bc 12,2,.L89
	lwz 0,492(11)
	cmpwi 0,0,0
	bc 4,2,.L89
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 4,2,.L88
.L89:
	mr 3,30
	bl G_FreeEdict
	b .L87
.L88:
	lfs 13,4(11)
	lis 9,gi@ha
	mr 3,30
	la 28,gi@l(9)
	lis 25,level@ha
	stfs 13,4(30)
	lfs 0,8(11)
	stfs 0,8(30)
	lfs 13,12(11)
	stfs 13,12(30)
	lwz 9,72(28)
	mtlr 9
	blrl
	lwz 11,540(30)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lwz 10,84(11)
	lfs 0,4040(10)
	fcmpu 0,0,13
	bc 4,1,.L90
	lwz 0,level@l(25)
	lis 11,0x4330
	lis 8,.LC39@ha
	lfs 12,4064(10)
	addi 26,30,4
	xoris 0,0,0x8000
	la 8,.LC39@l(8)
	stw 0,36(1)
	stw 11,32(1)
	lfd 13,0(8)
	lfd 0,32(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,0,.L91
	bl rand
	andi. 0,3,1
	bc 12,2,.L92
	lwz 9,36(28)
	lis 3,.LC36@ha
	la 3,.LC36@l(3)
	lwz 29,540(30)
	mtlr 9
	blrl
	lwz 0,16(28)
	lis 8,.LC40@ha
	lis 9,.LC40@ha
	lis 10,.LC41@ha
	mr 5,3
	la 8,.LC40@l(8)
	la 9,.LC40@l(9)
	mtlr 0
	la 10,.LC41@l(10)
	li 4,2
	lfs 1,0(8)
	mr 3,29
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L93
.L92:
	lwz 9,36(28)
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	lwz 29,540(30)
	mtlr 9
	blrl
	lwz 0,16(28)
	lis 8,.LC40@ha
	lis 9,.LC40@ha
	lis 10,.LC41@ha
	mr 5,3
	la 8,.LC40@l(8)
	la 9,.LC40@l(9)
	mtlr 0
	la 10,.LC41@l(10)
	li 4,2
	lfs 1,0(8)
	mr 3,29
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L93:
	lwz 3,540(30)
	li 11,0
	li 0,35
	lwz 5,256(30)
	addi 28,30,4
	lis 8,vec3_origin@ha
	lwz 9,516(30)
	la 8,vec3_origin@l(8)
	addi 6,3,376
	stw 11,8(1)
	li 10,0
	mr 7,28
	stw 0,12(1)
	mr 4,30
	mr 26,28
	bl T_Damage
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,6
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
	lis 10,level@ha
	lwz 8,540(30)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC39@ha
	addi 9,9,10
	la 10,.LC39@l(10)
	xoris 9,9,0x8000
	lfd 13,0(10)
	stw 9,36(1)
	stw 0,32(1)
	lfd 0,32(1)
	lwz 10,84(8)
	fsub 0,0,13
	frsp 0,0
	stfs 0,4064(10)
.L91:
	lis 9,.LC35@ha
	lis 11,K2_FlameBurnDamage@ha
	la 23,.LC35@l(9)
	la 24,K2_FlameBurnDamage@l(11)
	b .L94
.L96:
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L94
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L94
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L94
	la 27,level@l(25)
	lfs 13,4040(9)
	lfs 0,4(27)
	fcmpu 0,13,0
	cror 3,2,1
	bc 12,3,.L94
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L94
	mr 3,31
	bl K2_IsProtected
	cmpwi 0,3,0
	bc 4,2,.L87
	lwz 0,84(31)
	lwz 29,540(30)
	cmpwi 0,0,0
	bc 12,2,.L94
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L94
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L94
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L94
	mr 3,31
	bl K2_IsProtected
	mr. 28,3
	bc 4,2,.L94
	cmpw 0,31,29
	bc 12,2,.L109
	lwz 9,84(31)
	li 0,0
	stw 0,4020(9)
.L109:
	lis 9,burntime@ha
	lfs 13,4(27)
	lwz 11,burntime@l(9)
	lwz 10,84(31)
	lfs 0,20(11)
	fadds 13,13,0
	stfs 13,4040(10)
	bl G_Spawn
	lis 9,burndamage@ha
	li 0,1
	lwz 11,burndamage@l(9)
	lis 8,.LC40@ha
	stw 29,256(3)
	la 8,.LC40@l(8)
	stw 0,284(3)
	stw 31,540(3)
	lfs 0,20(11)
	stw 23,280(3)
	stw 28,260(3)
	lfs 12,0(8)
	fctiwz 13,0
	stfd 13,32(1)
	lwz 9,36(1)
	stw 9,516(3)
	lfs 0,4(31)
	stfs 0,4(3)
	lfs 13,8(31)
	stfs 13,8(3)
	lfs 0,12(31)
	stw 28,248(3)
	stw 24,436(3)
	stfs 0,12(3)
	lfs 0,4(27)
	fadds 0,0,12
	stfs 0,428(3)
.L94:
	lis 9,.LC42@ha
	mr 3,31
	la 9,.LC42@l(9)
	mr 4,26
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 4,2,.L96
	b .L111
.L90:
	mr 3,30
	bl G_FreeEdict
.L111:
	lis 9,level+4@ha
	lis 11,.LC38@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC38@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
.L87:
	lwz 0,84(1)
	mtlr 0
	lmw 23,44(1)
	la 1,80(1)
	blr
.Lfe6:
	.size	 K2_FlameBurnDamage,.Lfe6-K2_FlameBurnDamage
	.section	".rodata"
	.align 2
.LC44:
	.string	"gibgun"
	.align 2
.LC45:
	.string	"world/amb10.wav"
	.align 3
.LC43:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC46:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl K2_FireGibGun
	.type	 K2_FireGibGun,@function
K2_FireGibGun:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 27,3
	mr 28,4
	mr 29,5
	mr 26,6
	mr 30,7
	bl G_Spawn
	lis 0,0x600
	mr 31,3
	ori 0,0,3
	mr 3,27
	stw 0,252(31)
	bl K2_IsHoming
	cmpwi 0,3,0
	bc 12,2,.L113
	lis 9,Rocket_Die@ha
	lis 0,0xc140
	la 9,Rocket_Die@l(9)
	lis 11,0xc0a0
	stw 0,188(31)
	stw 9,456(31)
	lis 8,0x4140
	lis 10,K2_HomingThink@ha
	li 9,0
	stw 11,192(31)
	lis 7,0x40a0
	stw 9,196(31)
	la 10,K2_HomingThink@l(10)
	li 30,250
	stw 8,200(31)
	lis 0,0x4100
	li 4,10
	li 6,15
	li 5,2
	stw 7,204(31)
	li 9,3
	li 11,1024
	stw 0,208(31)
	lis 8,level+4@ha
	stw 4,400(31)
	lis 7,.LC43@ha
	stw 6,480(31)
	stw 5,512(31)
	stw 9,252(31)
	stw 11,776(31)
	stw 10,436(31)
	stw 30,1336(31)
	lfs 0,level+4@l(8)
	lfd 13,.LC43@l(7)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L114
.L113:
	li 0,8000
	divw 0,0,30
	lis 8,0x4330
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lis 10,level+4@ha
	lfd 12,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	stw 9,436(31)
	lfs 13,level+4@l(10)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(31)
.L114:
	lfs 13,0(28)
	mr 3,29
	addi 4,31,16
	stfs 13,4(31)
	lfs 0,4(28)
	stfs 0,8(31)
	lfs 13,8(28)
	stfs 13,12(31)
	lfs 0,0(29)
	stfs 0,340(31)
	lfs 13,4(29)
	stfs 13,344(31)
	lfs 0,8(29)
	stfs 0,348(31)
	bl vectoangles
	xoris 0,30,0x8000
	stw 0,20(1)
	lis 11,0x4330
	lis 10,.LC46@ha
	stw 11,16(1)
	la 10,.LC46@l(10)
	mr 3,29
	lfd 0,0(10)
	addi 4,31,376
	lfd 1,16(1)
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	lwz 9,64(31)
	li 11,8
	li 10,2
	lwz 0,68(31)
	lis 29,gi@ha
	lis 3,.LC26@ha
	ori 9,9,16
	la 29,gi@l(29)
	stw 11,260(31)
	ori 0,0,32
	stw 10,248(31)
	la 3,.LC26@l(3)
	stw 0,68(31)
	stw 9,64(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,K2_GibGunTouch@ha
	lis 11,.LC44@ha
	stw 3,40(31)
	la 9,K2_GibGunTouch@l(9)
	la 11,.LC44@l(11)
	stw 27,256(31)
	stw 9,444(31)
	lis 3,.LC45@ha
	stw 26,516(31)
	la 3,.LC45@l(3)
	stw 11,280(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,76(31)
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 K2_FireGibGun,.Lfe7-K2_FireGibGun
	.section	".rodata"
	.align 2
.LC48:
	.string	"weapons/hyprbu1a.wav"
	.align 2
.LC49:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 3
.LC50:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC51:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC52:
	.long 0x3f800000
	.align 2
.LC53:
	.long 0x0
	.section	".text"
	.align 2
	.globl K2_GibGunThink
	.type	 K2_GibGunThink,@function
K2_GibGunThink:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 26,32(1)
	stw 0,68(1)
	mr 31,3
	lwz 11,540(31)
	lwz 28,492(11)
	cmpwi 0,28,0
	bc 4,2,.L122
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 4,2,.L121
.L122:
	mr 3,31
	bl G_FreeEdict
	b .L120
.L121:
	lfs 13,4(11)
	lis 9,gi@ha
	mr 3,31
	la 30,gi@l(9)
	lis 26,level@ha
	stfs 13,4(31)
	lfs 0,8(11)
	stfs 0,8(31)
	lfs 13,12(11)
	stfs 13,12(31)
	lwz 9,72(30)
	mtlr 9
	blrl
	lwz 11,540(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lwz 11,84(11)
	lfs 0,4048(11)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L123
	lwz 0,level@l(26)
	lis 27,0x4330
	lis 10,.LC51@ha
	lfs 13,4068(11)
	xoris 0,0,0x8000
	la 10,.LC51@l(10)
	stw 0,28(1)
	stw 27,24(1)
	lfd 31,0(10)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,0,.L125
	lwz 9,36(30)
	lis 3,.LC48@ha
	lis 29,.LC49@ha
	la 3,.LC48@l(3)
	mtlr 9
	blrl
	lis 9,.LC52@ha
	lwz 0,16(30)
	lis 10,.LC52@ha
	la 9,.LC52@l(9)
	la 10,.LC52@l(10)
	lfs 1,0(9)
	mr 5,3
	mtlr 0
	li 4,0
	lis 9,.LC53@ha
	lfs 2,0(10)
	mr 3,31
	la 9,.LC53@l(9)
	lfs 3,0(9)
	blrl
	lwz 3,540(31)
	li 0,34
	lis 8,vec3_origin@ha
	lwz 9,516(31)
	li 10,0
	la 8,vec3_origin@l(8)
	lwz 5,256(31)
	addi 7,31,4
	addi 6,3,376
	stw 28,8(1)
	mr 4,31
	stw 0,12(1)
	bl T_Damage
	lwz 3,540(31)
	la 4,.LC49@l(29)
	li 5,1
	li 6,0
	bl ThrowGib
	lwz 3,540(31)
	la 4,.LC49@l(29)
	li 5,1
	li 6,0
	bl ThrowGib
	lwz 9,level@l(26)
	lwz 10,540(31)
	addi 9,9,10
	xoris 9,9,0x8000
	lwz 8,84(10)
	stw 9,28(1)
	stw 27,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,4068(8)
	b .L125
.L123:
	mr 3,31
	bl G_FreeEdict
.L125:
	lis 9,level+4@ha
	lis 11,.LC50@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC50@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L120:
	lwz 0,68(1)
	mtlr 0
	lmw 26,32(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 K2_GibGunThink,.Lfe8-K2_GibGunThink
	.section	".rodata"
	.align 2
.LC54:
	.string	"You are frozen by %s's freeze grenade!!!\n"
	.align 2
.LC55:
	.string	"%s is frozen by your freeze grenade!\n"
	.align 3
.LC56:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC57:
	.long 0x0
	.align 2
.LC58:
	.long 0x41200000
	.align 2
.LC59:
	.long 0x41a00000
	.align 2
.LC60:
	.long 0x40000000
	.align 2
.LC61:
	.long 0x3f800000
	.align 3
.LC62:
	.long 0x3ff80000
	.long 0x0
	.align 3
.LC63:
	.long 0x3fe80000
	.long 0x0
	.align 3
.LC64:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Freeze_Explode
	.type	 Freeze_Explode,@function
Freeze_Explode:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 28,56(1)
	stw 0,84(1)
	lis 10,.LC56@ha
	mr 31,3
	la 10,.LC56@l(10)
	lwz 0,516(31)
	lfd 11,0(10)
	lis 11,0x4330
	lis 10,.LC57@ha
	xoris 0,0,0x8000
	lfs 12,4(31)
	la 10,.LC57@l(10)
	stw 0,52(1)
	li 5,0
	lfs 31,0(10)
	li 6,44
	lfs 13,8(31)
	lis 10,.LC58@ha
	stw 11,48(1)
	la 10,.LC58@l(10)
	lfd 1,48(1)
	fadds 12,12,31
	lfs 0,12(31)
	fadds 13,13,31
	lfs 10,0(10)
	fsub 1,1,11
	lfs 2,524(31)
	lwz 4,256(31)
	fadds 0,0,10
	stfs 12,4(31)
	stfs 13,8(31)
	frsp 1,1
	stfs 31,8(1)
	stfs 0,12(31)
	stfs 31,12(1)
	stfs 10,16(1)
	bl T_RadiusDamage
	lwz 3,256(31)
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L127
	addi 4,31,4
	li 5,2
	bl PlayerNoise
.L127:
	li 30,0
	addi 29,31,4
	lis 28,freeze_radius@ha
	b .L128
.L130:
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L128
	mr 3,31
	mr 4,30
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L128
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 4,2,.L128
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L128
	mr 3,30
	bl K2_IsProtected
	cmpwi 0,3,0
	bc 4,2,.L128
	lis 9,level@ha
	lwz 8,84(30)
	lwz 0,level@l(9)
	lis 10,0x4330
	lis 9,.LC56@ha
	lfs 12,4020(8)
	xoris 0,0,0x8000
	la 9,.LC56@l(9)
	stw 0,52(1)
	stw 10,48(1)
	lfd 13,0(9)
	lfd 0,48(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 12,1,.L128
	lwz 0,256(31)
	cmpw 0,30,0
	bc 12,2,.L137
	li 0,0
	stw 0,4040(8)
.L137:
	lfs 0,4(30)
	addi 3,1,24
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 0,8(30)
	fsubs 12,12,0
	stfs 12,28(1)
	lfs 0,12(30)
	fsubs 11,11,0
	stfs 11,32(1)
	bl VectorLength
	lwz 9,freeze_radius@l(28)
	lis 10,.LC59@ha
	la 10,.LC59@l(10)
	lfs 0,0(10)
	lfs 11,20(9)
	fdivs 0,11,0
	fcmpu 0,1,0
	bc 4,0,.L138
	lis 9,.LC58@ha
	lis 11,freezetime@ha
	la 9,.LC58@l(9)
	lfs 13,0(9)
	lwz 9,freezetime@l(11)
	lfs 0,20(9)
	fmuls 31,0,13
	b .L139
.L138:
	fadds 11,11,11
	lis 10,.LC60@ha
	lis 11,.LC61@ha
	la 10,.LC60@l(10)
	la 11,.LC61@l(11)
	lfs 8,0(10)
	lis 9,freezetime@ha
	fsubs 0,1,11
	lfs 9,0(11)
	lis 10,.LC58@ha
	lwz 11,freezetime@l(9)
	la 10,.LC58@l(10)
	lfs 10,0(10)
	lis 9,.LC62@ha
	fdivs 0,0,11
	lfs 13,20(11)
	la 9,.LC62@l(9)
	lfd 12,0(9)
	fsubs 0,0,8
	fmuls 13,13,10
	fdivs 0,9,0
	fadds 0,0,9
	fmul 13,13,12
	fmul 13,13,0
	frsp 31,13
.L139:
	lis 10,.LC57@ha
	la 10,.LC57@l(10)
	lfs 0,0(10)
	fcmpu 0,31,0
	bc 4,0,.L140
	lis 11,.LC57@ha
	la 11,.LC57@l(11)
	lfs 31,0(11)
.L140:
	mr 3,30
	mr 4,31
	bl infront
	cmpwi 0,3,0
	bc 4,2,.L141
	lis 9,.LC63@ha
	fmr 0,31
	la 9,.LC63@l(9)
	lfd 13,0(9)
	fmul 0,0,13
	frsp 31,0
.L141:
	lwz 0,256(31)
	cmpw 0,30,0
	bc 4,2,.L142
	lis 10,.LC64@ha
	fmr 0,31
	la 10,.LC64@l(10)
	lfd 13,0(10)
	fmul 0,0,13
	frsp 31,0
.L142:
	lis 11,level@ha
	lwz 8,84(30)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC56@ha
	xoris 0,0,0x8000
	la 11,.LC56@l(11)
	stw 0,52(1)
	stw 10,48(1)
	lfd 13,0(11)
	lfd 0,48(1)
	fsub 0,0,13
	frsp 0,0
	fadds 0,0,31
	stfs 0,4020(8)
	lwz 0,968(30)
	cmpwi 0,0,0
	bc 4,2,.L143
	lwz 9,256(31)
	lis 4,.LC54@ha
	mr 3,30
	la 4,.LC54@l(4)
	lwz 5,84(9)
	addi 5,5,700
	crxor 6,6,6
	bl safe_centerprintf
.L143:
	lwz 3,256(31)
	cmpw 0,30,3
	bc 12,2,.L144
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L144
	lwz 6,84(30)
	lis 5,.LC55@ha
	li 4,2
	la 5,.LC55@l(5)
	addi 6,6,700
	crxor 6,6,6
	bl safe_cprintf
.L144:
	lwz 0,968(30)
	cmpwi 0,0,0
	bc 12,2,.L128
	li 0,0
	stw 0,540(30)
.L128:
	lis 9,freeze_radius@ha
	mr 3,30
	lwz 11,freeze_radius@l(9)
	mr 4,29
	lfs 1,20(11)
	bl findradius
	mr. 30,3
	bc 4,2,.L130
	mr 3,31
	bl BecomeExplosion1
	lwz 0,84(1)
	mtlr 0
	lmw 28,56(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe9:
	.size	 Freeze_Explode,.Lfe9-Freeze_Explode
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.comm	last_trail_time,4,4
	.comm	bot_frametime,8,8
	.comm	max_bots,4,4
	.comm	last_bot_spawn,4,4
	.comm	bot_male_names_used,4,4
	.comm	bot_female_names_used,4,4
	.comm	bot_count,4,4
	.comm	bot_teams,256,4
	.comm	total_teams,4,4
	.comm	the_client,4,4
	.comm	num_players,4,4
	.comm	players,1024,4
	.comm	weapons_head,4,4
	.comm	health_head,4,4
	.comm	bonus_head,4,4
	.comm	ammo_head,4,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_supershotgun,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	botinfo_list,4,4
	.comm	total_bots,4,4
	.comm	teambot_list,4,4
	.comm	paused,4,4
	.section	".rodata"
	.align 2
.LC66:
	.long 0x46fffe00
	.align 3
.LC67:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC68:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC69:
	.long 0x3f800000
	.align 2
.LC70:
	.long 0x0
	.section	".text"
	.align 2
	.globl Flash_Touch
	.type	 Flash_Touch,@function
Flash_Touch:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,256(31)
	cmpw 0,4,0
	bc 12,2,.L59
	cmpwi 0,6,0
	bc 12,2,.L61
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L61
	bl G_FreeEdict
	b .L59
.L61:
	lwz 0,512(4)
	cmpwi 0,0,0
	bc 4,2,.L62
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L63
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC67@ha
	lis 11,.LC66@ha
	la 10,.LC67@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC68@ha
	lfs 12,.LC66@l(11)
	la 10,.LC68@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L64
	lis 29,gi@ha
	lis 3,.LC23@ha
	la 29,gi@l(29)
	la 3,.LC23@l(3)
	b .L156
.L64:
	lis 29,gi@ha
	lis 3,.LC24@ha
	la 29,gi@l(29)
	la 3,.LC24@l(3)
	b .L156
.L63:
	lis 29,gi@ha
	lis 3,.LC25@ha
	la 29,gi@l(29)
	la 3,.LC25@l(3)
.L156:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC69@ha
	lis 10,.LC69@ha
	lis 11,.LC70@ha
	mr 5,3
	la 9,.LC69@l(9)
	la 10,.LC69@l(10)
	mtlr 0
	la 11,.LC70@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L59
.L62:
	mr 3,31
	bl Flash_Explode
.L59:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 Flash_Touch,.Lfe10-Flash_Touch
	.section	".rodata"
	.align 2
.LC71:
	.long 0x46fffe00
	.align 3
.LC72:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC73:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC74:
	.long 0x3f800000
	.align 2
.LC75:
	.long 0x0
	.section	".text"
	.align 2
	.globl Freeze_Touch
	.type	 Freeze_Touch,@function
Freeze_Touch:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,256(31)
	cmpw 0,4,0
	bc 12,2,.L148
	cmpwi 0,6,0
	bc 12,2,.L150
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L150
	bl G_FreeEdict
	b .L148
.L150:
	lwz 0,512(4)
	cmpwi 0,0,0
	bc 4,2,.L151
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L152
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC72@ha
	lis 11,.LC71@ha
	la 10,.LC72@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC73@ha
	lfs 12,.LC71@l(11)
	la 10,.LC73@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L153
	lis 29,gi@ha
	lis 3,.LC23@ha
	la 29,gi@l(29)
	la 3,.LC23@l(3)
	b .L157
.L153:
	lis 29,gi@ha
	lis 3,.LC24@ha
	la 29,gi@l(29)
	la 3,.LC24@l(3)
	b .L157
.L152:
	lis 29,gi@ha
	lis 3,.LC25@ha
	la 29,gi@l(29)
	la 3,.LC25@l(3)
.L157:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC74@ha
	lis 10,.LC74@ha
	lis 11,.LC75@ha
	mr 5,3
	la 9,.LC74@l(9)
	la 10,.LC74@l(10)
	mtlr 0
	la 11,.LC75@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L148
.L151:
	mr 3,31
	bl Freeze_Explode
.L148:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 Freeze_Touch,.Lfe11-Freeze_Touch
	.section	".rodata"
	.align 2
.LC76:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl K2_BurnPlayer
	.type	 K2_BurnPlayer,@function
K2_BurnPlayer:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L80
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L80
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L80
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L80
	bl K2_IsProtected
	mr. 28,3
	bc 4,2,.L80
	cmpw 0,31,30
	bc 12,2,.L86
	lwz 9,84(31)
	li 0,0
	stw 0,4020(9)
.L86:
	lis 9,burntime@ha
	lis 29,level@ha
	lwz 10,84(31)
	lwz 11,burntime@l(9)
	la 29,level@l(29)
	lfs 0,4(29)
	lfs 13,20(11)
	fadds 0,0,13
	stfs 0,4040(10)
	bl G_Spawn
	lis 9,burndamage@ha
	li 0,1
	lwz 8,burndamage@l(9)
	lis 10,K2_FlameBurnDamage@ha
	stw 30,256(3)
	lis 9,.LC35@ha
	la 10,K2_FlameBurnDamage@l(10)
	stw 0,284(3)
	la 9,.LC35@l(9)
	lis 7,.LC76@ha
	stw 31,540(3)
	la 7,.LC76@l(7)
	lfs 0,20(8)
	stw 9,280(3)
	stw 28,260(3)
	lfs 12,0(7)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	stw 11,516(3)
	lfs 0,4(31)
	stfs 0,4(3)
	lfs 13,8(31)
	stfs 13,8(3)
	lfs 0,12(31)
	stw 28,248(3)
	stw 10,436(3)
	stfs 0,12(3)
	lfs 0,4(29)
	fadds 0,0,12
	stfs 0,428(3)
.L80:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 K2_BurnPlayer,.Lfe12-K2_BurnPlayer
	.section	".rodata"
	.align 3
.LC77:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl K2_GibGunTouch
	.type	 K2_GibGunTouch,@function
K2_GibGunTouch:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 0,256(31)
	cmpw 0,30,0
	bc 12,2,.L115
	lwz 11,84(30)
	cmpwi 0,11,0
	bc 4,2,.L117
	bl G_FreeEdict
	b .L115
.L117:
	lis 9,level@ha
	lfs 13,4048(11)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,13,0
	bc 12,1,.L158
	mr 3,30
	bl K2_IsProtected
	mr. 6,3
	bc 12,2,.L119
.L158:
	mr 3,31
	bl G_FreeEdict
	b .L115
.L119:
	lis 11,gibtime@ha
	li 0,0
	stw 6,76(31)
	lwz 10,gibtime@l(11)
	li 9,32
	lis 8,.LC77@ha
	stw 9,68(31)
	lis 11,K2_GibGunThink@ha
	lis 7,gi+72@ha
	stw 0,396(31)
	la 11,K2_GibGunThink@l(11)
	mr 3,31
	stw 0,340(31)
	stw 0,344(31)
	stw 0,348(31)
	stw 0,376(31)
	stw 0,380(31)
	stw 0,384(31)
	stw 0,388(31)
	stw 0,392(31)
	stw 6,260(31)
	stw 6,248(31)
	stw 6,64(31)
	lfs 13,20(10)
	lfs 0,4(29)
	lwz 9,84(30)
	lfd 12,.LC77@l(8)
	fadds 0,0,13
	stfs 0,4048(9)
	lfs 13,4(30)
	stfs 13,4(31)
	lfs 0,8(30)
	stfs 0,8(31)
	lfs 13,12(30)
	stfs 13,12(31)
	lfs 0,4(29)
	stw 11,436(31)
	stw 30,540(31)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(31)
	lwz 0,gi+72@l(7)
	mtlr 0
	blrl
.L115:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 K2_GibGunTouch,.Lfe13-K2_GibGunTouch
	.section	".rodata"
	.align 2
.LC78:
	.long 0xbca3d70a
	.align 3
.LC79:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Rocket_Explode
	.type	 Rocket_Explode,@function
Rocket_Explode:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	mr 31,3
	lwz 3,256(31)
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L34
	addi 4,31,4
	li 5,2
	bl PlayerNoise
.L34:
	lis 9,.LC78@ha
	addi 3,31,4
	lfs 1,.LC78@l(9)
	addi 5,1,8
	mr 30,3
	addi 4,31,376
	bl VectorMA
	lwz 0,520(31)
	lis 11,0x4330
	lis 10,.LC79@ha
	lfs 2,524(31)
	li 6,42
	xoris 0,0,0x8000
	la 10,.LC79@l(10)
	lwz 4,256(31)
	stw 0,44(1)
	mr 3,31
	li 5,0
	stw 11,40(1)
	lfd 1,40(1)
	lfd 0,0(10)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
	lis 9,gi@ha
	li 3,3
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L35
	lwz 0,100(29)
	li 3,17
	mtlr 0
	blrl
	b .L36
.L35:
	lwz 0,100(29)
	li 3,7
	mtlr 0
	blrl
.L36:
	lis 29,gi@ha
	addi 3,1,8
	la 29,gi@l(29)
	lwz 9,120(29)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,30
	li 4,2
	mtlr 0
	blrl
	mr 3,31
	bl G_FreeEdict
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe14:
	.size	 Rocket_Explode,.Lfe14-Rocket_Explode
	.section	".rodata"
	.align 3
.LC80:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl Rocket_Die
	.type	 Rocket_Die,@function
Rocket_Die:
	lis 9,Rocket_Explode@ha
	li 0,0
	la 9,Rocket_Explode@l(9)
	stw 0,512(3)
	lis 11,level+4@ha
	stw 9,436(3)
	lis 10,.LC80@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC80@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe15:
	.size	 Rocket_Die,.Lfe15-Rocket_Die
	.section	".rodata"
	.align 3
.LC81:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC82:
	.long 0x3fe80000
	.long 0x0
	.align 3
.LC83:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl fire_rocket_drunk
	.type	 fire_rocket_drunk,@function
fire_rocket_drunk:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 22,24(1)
	stw 0,84(1)
	mr 27,5
	mr 26,7
	fmr 30,1
	mr 22,8
	mr 25,6
	mr 28,4
	mr 23,3
	bl G_Spawn
	lis 24,0x4330
	lfs 13,0(28)
	mr 29,3
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	mr 3,27
	lfd 31,0(9)
	addi 4,29,16
	stfs 13,4(29)
	lfs 0,4(28)
	stfs 0,8(29)
	lfs 13,8(28)
	stfs 13,12(29)
	lfs 0,0(27)
	stfs 0,340(29)
	lfs 13,4(27)
	stfs 13,344(29)
	lfs 0,8(27)
	stfs 0,348(29)
	bl vectoangles
	xoris 26,26,0x8000
	stw 26,20(1)
	mr 3,27
	addi 4,29,376
	stw 24,16(1)
	lfd 1,16(1)
	fsub 1,1,31
	frsp 1,1
	bl VectorScale
	lwz 11,64(29)
	lis 0,0x600
	li 9,0
	ori 0,0,3
	li 10,8
	stw 9,200(29)
	ori 11,11,16
	li 8,2
	stw 0,252(29)
	lis 28,gi@ha
	stw 10,260(29)
	lis 3,.LC26@ha
	la 28,gi@l(28)
	stw 8,248(29)
	la 3,.LC26@l(3)
	stw 11,64(29)
	stw 9,196(29)
	stw 9,192(29)
	stw 9,188(29)
	stw 9,208(29)
	stw 9,204(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	xoris 25,25,0x8000
	stw 3,40(29)
	stw 25,20(1)
	lis 11,rocket_touch@ha
	lis 10,Rocket_DrunkThink@ha
	stw 24,16(1)
	la 11,rocket_touch@l(11)
	la 10,Rocket_DrunkThink@l(10)
	lfd 13,16(1)
	lis 7,level+4@ha
	lis 9,.LC82@ha
	stw 23,256(29)
	lis 3,.LC28@ha
	stw 11,444(29)
	la 9,.LC82@l(9)
	la 3,.LC28@l(3)
	stw 10,436(29)
	fsub 13,13,31
	lfs 0,level+4@l(7)
	lfd 11,0(9)
	lis 9,.LC83@ha
	stw 22,520(29)
	la 9,.LC83@l(9)
	stfs 30,524(29)
	lfd 10,0(9)
	fmul 13,13,11
	lis 9,.LC27@ha
	la 9,.LC27@l(9)
	fctiwz 12,13
	stw 9,280(29)
	fadd 0,0,10
	stfd 12,16(1)
	frsp 0,0
	lwz 8,20(1)
	stw 8,516(29)
	stfs 0,428(29)
	lwz 9,36(28)
	mtlr 9
	blrl
	stw 3,76(29)
	lwz 0,72(28)
	mr 3,29
	mtlr 0
	blrl
	lwz 0,84(1)
	mtlr 0
	lmw 22,24(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe16:
	.size	 fire_rocket_drunk,.Lfe16-fire_rocket_drunk
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
