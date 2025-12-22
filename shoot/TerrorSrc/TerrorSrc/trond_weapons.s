	.file	"trond_weapons.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"hgrenade"
	.align 2
.LC1:
	.string	"police"
	.align 2
.LC4:
	.string	"models/slat/world_mine/world_mine_placed.md2"
	.align 2
.LC5:
	.string	"mine"
	.align 2
.LC6:
	.string	"slat/weapons/bush_hit.wav"
	.align 2
.LC7:
	.long 0xc0000000
	.align 3
.LC8:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC9:
	.long 0x3ff80000
	.long 0x0
	.align 2
.LC10:
	.long 0x3f800000
	.align 2
.LC11:
	.long 0x0
	.section	".text"
	.align 2
	.type	 Weapon_Mine_Place,@function
Weapon_Mine_Place:
	stwu 1,-176(1)
	mflr 0
	stmw 27,156(1)
	stw 0,180(1)
	mr 31,3
	addi 29,1,24
	lwz 11,84(31)
	addi 27,1,40
	li 6,0
	mr 5,27
	mr 4,29
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	lwz 3,84(31)
	addi 3,3,3764
	bl AngleVectors
	lis 9,.LC7@ha
	lwz 4,84(31)
	mr 3,29
	la 9,.LC7@l(9)
	lfs 1,0(9)
	addi 4,4,3712
	bl VectorScale
	lwz 11,84(31)
	lis 0,0xc000
	lis 28,0x4330
	lis 10,.LC8@ha
	stw 0,3700(11)
	la 10,.LC8@l(10)
	mr 6,29
	lwz 0,508(31)
	mr 7,27
	addi 4,31,4
	lfd 13,0(10)
	addi 5,1,56
	addi 8,1,8
	xoris 0,0,0x8000
	lwz 3,84(31)
	li 10,0
	stw 0,148(1)
	stw 28,144(1)
	lfd 0,144(1)
	stw 10,60(1)
	stw 10,56(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	bl P_ProjectSource
	lwz 9,84(31)
	lwz 0,3640(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,1,.L17
	bl G_Spawn
	lis 27,0x4396
	lfs 13,4(31)
	mr 29,3
	addi 3,1,96
	addi 4,29,16
	stfs 13,4(29)
	lfs 0,8(31)
	stfs 0,8(29)
	lfs 13,12(31)
	stfs 13,12(29)
	bl vectoangles
	lis 28,gi@ha
	lis 3,.LC4@ha
	la 28,gi@l(28)
	la 3,.LC4@l(3)
	lwz 9,32(28)
	mtlr 9
	blrl
	lwz 9,68(29)
	li 0,300
	li 10,7
	stw 0,516(29)
	lis 8,.LC5@ha
	lis 5,0xc080
	stw 10,260(29)
	lis 6,0x4080
	la 8,.LC5@l(8)
	lis 7,0x4100
	ori 9,9,32768
	stw 8,280(29)
	li 11,2
	lis 0,0xc0c0
	stw 5,192(29)
	stw 6,204(29)
	lis 10,level+4@ha
	stw 7,208(29)
	stw 5,188(29)
	stw 6,200(29)
	stw 3,40(29)
	stw 9,68(29)
	mr 3,29
	stw 11,248(29)
	lis 9,.LC9@ha
	stw 27,524(29)
	la 9,.LC9@l(9)
	stw 0,196(29)
	stw 31,256(29)
	lfs 0,level+4@l(10)
	lfd 13,0(9)
	lis 9,Mine_Think@ha
	la 9,Mine_Think@l(9)
	stw 9,436(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 11,84(31)
	lwz 0,3640(11)
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	lwz 10,84(31)
	lwz 9,4008(10)
	addi 9,9,5
	stw 9,4008(10)
	lwz 9,72(28)
	mtlr 9
	blrl
	lwz 9,36(28)
	lis 3,.LC6@ha
	la 3,.LC6@l(3)
	mtlr 9
	blrl
	lis 9,.LC10@ha
	lwz 0,16(28)
	lis 10,.LC11@ha
	la 9,.LC10@l(9)
	la 10,.LC11@l(10)
	lfs 2,0(9)
	mr 5,3
	mtlr 0
	li 4,1
	lis 9,.LC10@ha
	mr 3,31
	lfs 3,0(10)
	la 9,.LC10@l(9)
	lfs 1,0(9)
	blrl
	lwz 9,84(31)
	li 0,0
	mr 3,31
	stw 0,88(9)
	bl NoAmmoWeaponChange
.L17:
	lwz 0,180(1)
	mtlr 0
	lmw 27,156(1)
	la 1,176(1)
	blr
.Lfe1:
	.size	 Weapon_Mine_Place,.Lfe1-Weapon_Mine_Place
	.section	".data"
	.align 2
	.type	 pause_frames.21,@object
pause_frames.21:
	.long 14
	.long 0
	.align 2
	.type	 fire_frames.22,@object
fire_frames.22:
	.long 11
	.long 0
	.section	".rodata"
	.align 2
.LC12:
	.string	"models/slat/world_c4/world_c4_placed.md2"
	.align 2
.LC13:
	.string	"explosive"
	.align 2
.LC14:
	.long 0x40000000
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC16:
	.long 0x42700000
	.align 3
.LC17:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC18:
	.long 0x3f800000
	.align 2
.LC19:
	.long 0x0
	.section	".text"
	.align 2
	.type	 Weapon_C4_Placed,@function
Weapon_C4_Placed:
	stwu 1,-160(1)
	mflr 0
	stfd 31,152(1)
	stmw 26,128(1)
	stw 0,164(1)
	lis 9,.LC14@ha
	fmr 31,1
	mr 31,3
	la 9,.LC14@l(9)
	mr 27,4
	lfs 1,0(9)
	addi 28,1,72
	addi 3,1,88
	addi 4,1,104
	mr 29,5
	mr 26,6
	bl VectorScale
	lwz 0,508(31)
	lis 11,0x4330
	lis 10,.LC15@ha
	lfs 13,12(31)
	mr 4,29
	xoris 0,0,0x8000
	la 10,.LC15@l(10)
	lfs 9,112(1)
	stw 0,124(1)
	mr 3,27
	mr 5,28
	stw 11,120(1)
	lfd 10,0(10)
	fadds 9,9,13
	lfd 0,120(1)
	lis 10,.LC16@ha
	lfs 12,4(31)
	la 10,.LC16@l(10)
	lfs 13,104(1)
	fsub 0,0,10
	lfs 11,108(1)
	lfs 10,8(31)
	fadds 13,13,12
	lfs 1,0(10)
	frsp 0,0
	fadds 11,11,10
	stfs 13,104(1)
	fadds 9,9,0
	stfs 11,108(1)
	stfs 9,112(1)
	bl VectorMA
	lis 11,gi@ha
	lis 9,0x600
	la 30,gi@l(11)
	ori 9,9,3
	lwz 11,48(30)
	mr 4,27
	mr 7,28
	addi 3,1,8
	li 5,0
	li 6,0
	mr 8,31
	mtlr 11
	blrl
	lwz 9,52(1)
	cmpwi 0,9,0
	bc 12,2,.L22
	lwz 0,16(9)
	andi. 9,0,4
	bc 4,2,.L20
.L22:
	lfs 0,16(1)
	lis 10,.LC17@ha
	la 10,.LC17@l(10)
	lfd 13,0(10)
	fcmpu 0,0,13
	bc 4,0,.L23
	lwz 9,60(1)
	lwz 27,512(9)
	cmpwi 0,27,0
	bc 4,2,.L27
	lwz 9,100(30)
	li 3,3
	addi 29,1,20
	addi 28,1,32
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,9
	mtlr 9
	blrl
	lwz 9,120(30)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,124(30)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,88(30)
	mr 3,29
	li 4,2
	mtlr 9
	blrl
	bl G_Spawn
	lfs 13,20(1)
	mr 29,3
	addi 4,29,16
	mr 3,28
	stfs 13,4(29)
	lfs 0,24(1)
	stfs 0,8(29)
	lfs 13,28(1)
	stfs 13,12(29)
	bl vectoangles
	lwz 9,32(30)
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	mtlr 9
	blrl
	lwz 9,68(29)
	lis 11,.LC13@ha
	li 0,0
	la 11,.LC13@l(11)
	li 10,2
	stw 3,40(29)
	ori 9,9,32768
	stw 10,248(29)
	mr 3,29
	stw 0,200(29)
	stw 9,68(29)
	stw 26,516(29)
	stfs 31,524(29)
	stw 11,280(29)
	stw 31,256(29)
	stw 0,196(29)
	stw 0,192(29)
	stw 0,188(29)
	stw 0,208(29)
	stw 0,204(29)
	lwz 11,84(31)
	lwz 0,3640(11)
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	lwz 10,84(31)
	lwz 9,4008(10)
	addi 9,9,5
	stw 9,4008(10)
	lwz 9,72(30)
	mtlr 9
	blrl
	lwz 4,60(1)
	mr 3,29
	bl stick
	lwz 9,36(30)
	lis 3,.LC6@ha
	la 3,.LC6@l(3)
	mtlr 9
	blrl
	lis 9,.LC18@ha
	lwz 0,16(30)
	lis 10,.LC19@ha
	la 9,.LC18@l(9)
	la 10,.LC19@l(10)
	lfs 2,0(9)
	mr 5,3
	li 4,1
	mtlr 0
	lis 9,.LC18@ha
	mr 3,31
	lfs 3,0(10)
	la 9,.LC18@l(9)
	lfs 1,0(9)
	blrl
	lwz 9,84(31)
	mr 3,31
	stw 27,88(9)
	bl NoAmmoWeaponChange
	b .L20
.L23:
	bc 4,2,.L20
.L27:
	lwz 10,84(31)
	li 0,0
	lwz 9,92(10)
	addi 9,9,1
	stw 9,92(10)
	lwz 11,84(31)
	stw 0,3696(11)
.L20:
	lwz 0,164(1)
	mtlr 0
	lmw 26,128(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe2:
	.size	 Weapon_C4_Placed,.Lfe2-Weapon_C4_Placed
	.section	".data"
	.align 2
	.type	 pause_frames.32,@object
pause_frames.32:
	.long 34
	.long 51
	.long 59
	.long 0
	.align 2
	.type	 fire_frames.33,@object
fire_frames.33:
	.long 6
	.long 0
	.section	".rodata"
	.align 2
.LC20:
	.string	"slat/world/vindu_knus.wav"
	.align 2
.LC21:
	.long 0x40000000
	.align 3
.LC22:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC23:
	.long 0x42960000
	.align 3
.LC24:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC25:
	.long 0x0
	.align 2
.LC26:
	.long 0x41a00000
	.align 2
.LC27:
	.long 0x3f800000
	.section	".text"
	.align 2
	.type	 Weapon_Bush_Struck,@function
Weapon_Bush_Struck:
	stwu 1,-176(1)
	mflr 0
	stfd 31,168(1)
	stmw 26,144(1)
	stw 0,180(1)
	lis 9,.LC21@ha
	mr 30,3
	la 9,.LC21@l(9)
	mr 28,4
	lfs 1,0(9)
	addi 3,1,96
	addi 4,1,112
	mr 31,5
	mr 27,6
	mr 26,7
	bl VectorScale
	lwz 0,508(30)
	lis 11,0x4330
	lis 10,.LC22@ha
	lfs 13,12(30)
	addi 29,1,80
	xoris 0,0,0x8000
	la 10,.LC22@l(10)
	lfs 9,120(1)
	stw 0,140(1)
	mr 3,28
	mr 4,31
	stw 11,136(1)
	mr 5,29
	lfd 10,0(10)
	fadds 9,9,13
	lfd 0,136(1)
	lis 10,.LC23@ha
	lfs 12,4(30)
	la 10,.LC23@l(10)
	lfs 13,112(1)
	fsub 0,0,10
	lfs 11,116(1)
	lfs 10,8(30)
	fadds 13,13,12
	lfs 1,0(10)
	frsp 0,0
	fadds 11,11,10
	stfs 13,112(1)
	fadds 9,9,0
	stfs 11,116(1)
	stfs 9,120(1)
	bl VectorMA
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mr 4,28
	mr 7,29
	addi 3,1,16
	li 5,0
	li 6,0
	mtlr 0
	mr 8,30
	blrl
	lwz 9,60(1)
	cmpwi 0,9,0
	bc 12,2,.L33
	lwz 0,16(9)
	andi. 9,0,4
	bc 4,2,.L31
.L33:
	lfs 0,24(1)
	lis 10,.LC24@ha
	la 10,.LC24@l(10)
	lfd 13,0(10)
	fcmpu 0,0,13
	bc 4,0,.L31
	lwz 3,68(1)
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L35
	lwz 0,280(3)
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	cmpw 0,0,9
	bc 12,2,.L36
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L35
.L36:
	lis 9,.LC25@ha
	lfs 0,12(3)
	la 9,.LC25@l(9)
	lfs 13,36(1)
	lfs 31,0(9)
	fsubs 0,0,31
	fcmpu 0,13,0
	bc 4,0,.L37
	li 9,38
	li 0,0
	stw 9,12(1)
	mr 4,30
	mr 5,30
	stw 0,8(1)
	mr 6,31
	addi 7,1,28
	addi 8,1,40
	mr 9,27
	mr 10,26
	bl T_Damage
.L37:
	lwz 3,68(1)
	lis 9,.LC26@ha
	la 9,.LC26@l(9)
	lfs 12,36(1)
	lfs 0,0(9)
	lfs 13,12(3)
	fadds 0,13,0
	fcmpu 0,12,0
	bc 4,0,.L38
	fsubs 0,13,31
	fcmpu 0,12,0
	bc 4,1,.L38
	li 9,37
	li 0,0
	stw 9,12(1)
	mr 4,30
	mr 5,30
	stw 0,8(1)
	mr 6,31
	addi 7,1,28
	addi 8,1,40
	mr 9,27
	mr 10,26
	bl T_Damage
.L38:
	lwz 3,68(1)
	lis 9,.LC26@ha
	la 9,.LC26@l(9)
	lfs 12,36(1)
	lfs 0,0(9)
	lfs 13,12(3)
	fadds 13,13,0
	fcmpu 0,12,13
	bc 4,1,.L31
	li 9,36
	mr 4,30
	li 0,0
	stw 9,12(1)
	mr 6,31
	stw 0,8(1)
	mr 9,27
	mr 10,26
	mr 5,4
	addi 7,1,28
	addi 8,1,40
	bl T_Damage
	b .L31
.L35:
	lis 9,gi@ha
	li 3,3
	la 31,gi@l(9)
	addi 29,1,28
	lwz 9,100(31)
	addi 28,1,40
	mtlr 9
	blrl
	lwz 9,100(31)
	li 3,9
	mtlr 9
	blrl
	lwz 9,120(31)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,124(31)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,88(31)
	li 4,2
	mr 3,29
	mtlr 9
	blrl
	lwz 9,100(31)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(31)
	li 3,9
	mtlr 9
	blrl
	lwz 9,120(31)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,124(31)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,88(31)
	mr 3,29
	li 4,2
	mtlr 9
	blrl
	lwz 9,60(1)
	lwz 0,16(9)
	andi. 9,0,48
	bc 12,2,.L41
	lwz 9,36(31)
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	mtlr 9
	blrl
	lis 9,.LC27@ha
	lwz 0,16(31)
	lis 10,.LC27@ha
	la 9,.LC27@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC27@l(10)
	li 4,1
	mtlr 0
	lis 9,.LC25@ha
	mr 3,30
	lfs 2,0(10)
	la 9,.LC25@l(9)
	lfs 3,0(9)
	blrl
	b .L31
.L41:
	lwz 9,36(31)
	lis 3,.LC6@ha
	la 3,.LC6@l(3)
	mtlr 9
	blrl
	lis 9,.LC27@ha
	lwz 0,16(31)
	lis 10,.LC27@ha
	la 9,.LC27@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC27@l(10)
	li 4,1
	mtlr 0
	lis 9,.LC25@ha
	mr 3,30
	lfs 2,0(10)
	la 9,.LC25@l(9)
	lfs 3,0(9)
	blrl
.L31:
	lwz 0,180(1)
	mtlr 0
	lmw 26,144(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe3:
	.size	 Weapon_Bush_Struck,.Lfe3-Weapon_Bush_Struck
	.section	".data"
	.align 2
	.type	 pause_frames.43,@object
pause_frames.43:
	.long 21
	.long 36
	.long 0
	.align 2
	.type	 fire_frames.44,@object
fire_frames.44:
	.long 11
	.long 0
	.section	".rodata"
	.align 2
.LC28:
	.string	"slat/weapons/bush_swing.wav"
	.align 2
.LC29:
	.string	"weapons/noammo.wav"
	.align 2
.LC30:
	.string	"slat/weapons/glock_fire.wav"
	.align 2
.LC31:
	.long 0x46fffe00
	.align 2
.LC32:
	.long 0x3f800000
	.align 2
.LC33:
	.long 0x0
	.align 2
.LC34:
	.long 0x40400000
	.align 2
.LC35:
	.long 0xc0000000
	.align 3
.LC36:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC37:
	.long 0x3fd00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_Glock_Fire
	.type	 Weapon_Glock_Fire,@function
Weapon_Glock_Fire:
	stwu 1,-112(1)
	mflr 0
	stmw 27,92(1)
	stw 0,116(1)
	mr 31,3
	lwz 10,84(31)
	lwz 9,92(10)
	addi 9,9,1
	stw 9,92(10)
	lwz 11,84(31)
	lwz 0,3640(11)
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L47
	lis 29,gi@ha
	lis 3,.LC29@ha
	la 29,gi@l(29)
	la 3,.LC29@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC32@ha
	lis 10,.LC32@ha
	lis 11,.LC33@ha
	la 9,.LC32@l(9)
	la 10,.LC32@l(10)
	mr 5,3
	lfs 1,0(9)
	mtlr 0
	la 11,.LC33@l(11)
	lfs 2,0(10)
	li 4,2
	mr 3,31
	lfs 3,0(11)
	blrl
	lis 10,.LC32@ha
	lis 9,level+4@ha
	la 10,.LC32@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,464(31)
.L47:
	lis 29,gi@ha
	lis 3,.LC30@ha
	la 29,gi@l(29)
	la 3,.LC30@l(3)
	lwz 9,36(29)
	addi 28,1,24
	addi 27,1,40
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC34@ha
	lis 10,.LC33@ha
	lis 11,.LC32@ha
	la 10,.LC33@l(10)
	mr 5,3
	la 9,.LC34@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC32@l(11)
	lfs 2,0(9)
	mr 3,31
	lfs 1,0(11)
	li 4,1
	blrl
	lwz 11,84(31)
	mr 5,27
	li 6,0
	mr 4,28
	lwz 0,3640(11)
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	lwz 3,84(31)
	addi 3,3,3764
	bl AngleVectors
	lis 9,.LC35@ha
	lwz 4,84(31)
	mr 3,28
	la 9,.LC35@l(9)
	lfs 1,0(9)
	addi 4,4,3712
	bl VectorScale
	lwz 9,84(31)
	lis 0,0xc000
	lis 29,0x4330
	lis 10,.LC36@ha
	stw 0,3700(9)
	la 10,.LC36@l(10)
	addi 5,1,56
	lwz 9,508(31)
	mr 7,27
	addi 4,31,4
	lfd 13,0(10)
	mr 6,28
	addi 8,1,8
	addi 9,9,-8
	lwz 3,84(31)
	li 10,0
	xoris 9,9,0x8000
	stw 10,60(1)
	stw 9,84(1)
	stw 29,80(1)
	lfd 0,80(1)
	stw 10,56(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	bl P_ProjectSource
	lwz 9,84(31)
	mr 5,28
	cmpwi 0,9,0
	bc 12,2,.L48
	lwz 0,4052(9)
	cmpwi 0,0,0
	bc 12,2,.L48
	mr 3,31
	addi 4,1,8
	li 6,30
	li 7,130
	li 8,10
	li 9,10
	b .L61
.L48:
	lis 9,.LC33@ha
	lfs 0,376(31)
	la 9,.LC33@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L51
	lfs 0,380(31)
	fcmpu 0,0,13
	bc 12,2,.L50
.L51:
	lwz 9,84(31)
	lwz 0,4044(9)
	cmpwi 0,0,0
	bc 12,2,.L52
	mr 3,31
	addi 4,1,8
	li 6,30
	li 7,130
	li 8,600
	li 9,1000
	b .L61
.L52:
	mr 3,31
	addi 4,1,8
	li 6,30
	li 7,130
	li 8,480
	li 9,800
	b .L61
.L50:
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 10,0,1
	bc 12,2,.L55
	mr 3,31
	addi 4,1,8
	li 6,30
	li 7,130
	li 8,30
	li 9,30
	b .L61
.L55:
	lwz 0,4044(9)
	cmpwi 0,0,0
	bc 12,2,.L57
	mr 3,31
	addi 4,1,8
	li 6,30
	li 7,130
	li 8,300
	li 9,500
.L61:
	li 10,35
	bl fire_bullet
	b .L49
.L57:
	mr 3,31
	addi 4,1,8
	li 6,30
	li 7,130
	li 8,150
	li 9,250
	li 10,35
	bl fire_bullet
.L49:
	lwz 11,84(31)
	li 0,4
	stw 0,3824(11)
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 9,0,1
	bc 12,2,.L59
	bl rand
	rlwinm 3,3,0,17,31
	lwz 8,84(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,84(1)
	lis 9,.LC36@ha
	lis 10,.LC31@ha
	stw 0,80(1)
	la 9,.LC36@l(9)
	lfd 13,0(9)
	li 0,168
	lfd 0,80(1)
	lis 9,.LC37@ha
	lfs 11,.LC31@l(10)
	la 9,.LC37@l(9)
	lfd 10,0(9)
	fsub 0,0,13
	mr 9,11
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fadd 13,13,10
	fctiwz 12,13
	stfd 12,80(1)
	lwz 9,84(1)
	subfic 9,9,160
	b .L62
.L59:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 8,84(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,84(1)
	lis 9,.LC36@ha
	lis 10,.LC31@ha
	stw 0,80(1)
	la 9,.LC36@l(9)
	lfd 13,0(9)
	li 0,53
	lfd 0,80(1)
	lis 9,.LC37@ha
	lfs 11,.LC31@l(10)
	la 9,.LC37@l(9)
	lfd 10,0(9)
	fsub 0,0,13
	mr 9,11
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fadd 13,13,10
	fctiwz 12,13
	stfd 12,80(1)
	lwz 9,84(1)
	subfic 9,9,46
.L62:
	stw 9,56(31)
	stw 0,3820(8)
	lwz 0,116(1)
	mtlr 0
	lmw 27,92(1)
	la 1,112(1)
	blr
.Lfe4:
	.size	 Weapon_Glock_Fire,.Lfe4-Weapon_Glock_Fire
	.section	".data"
	.align 2
	.type	 pause_frames.51,@object
pause_frames.51:
	.long 13
	.align 2
	.type	 fire_frames.52,@object
fire_frames.52:
	.long 10
	.section	".rodata"
	.align 2
.LC38:
	.string	"slat/weapons/glock_reload2.wav"
	.align 2
.LC39:
	.string	"slat/weapons/glock_reload1.wav"
	.align 2
.LC40:
	.string	"slat/weapons/glock_reload3.wav"
	.align 2
.LC41:
	.long 0x3f800000
	.align 2
.LC42:
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_Glock
	.type	 Weapon_Glock,@function
Weapon_Glock:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,40
	bc 4,2,.L64
	lwz 0,4052(9)
	cmpwi 0,0,1
	bc 4,2,.L64
	bl SP_LaserSight
	lwz 9,84(31)
	li 0,0
	stw 0,4052(9)
.L64:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,2
	bc 4,2,.L65
	lis 29,gi@ha
	lis 3,.LC38@ha
	la 29,gi@l(29)
	la 3,.LC38@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC41@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC41@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 2,0(9)
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 3,0(9)
	blrl
.L65:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,45
	bc 4,2,.L66
	lis 29,gi@ha
	lis 3,.LC39@ha
	la 29,gi@l(29)
	la 3,.LC39@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC41@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC41@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 2,0(9)
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 3,0(9)
	blrl
.L66:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,58
	bc 4,2,.L67
	lis 29,gi@ha
	lis 3,.LC40@ha
	la 29,gi@l(29)
	la 3,.LC40@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC41@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC41@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 2,0(9)
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 3,0(9)
	blrl
.L67:
	lis 9,fire_frames.52@ha
	lis 11,Weapon_Glock_Fire@ha
	la 9,fire_frames.52@l(9)
	la 11,Weapon_Glock_Fire@l(11)
	lis 10,pause_frames.51@ha
	stw 9,8(1)
	mr 3,31
	stw 11,12(1)
	la 10,pause_frames.51@l(10)
	li 4,9
	li 5,12
	li 6,38
	li 7,40
	li 8,40
	li 9,64
	bl Weapon_Generic
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Weapon_Glock,.Lfe5-Weapon_Glock
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_UZIclip,4,4
	.comm	item_9mm,4,4
	.comm	item_1911rounds,4,4
	.comm	item_50cal,4,4
	.comm	item_MARINERrounds,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_sshotgun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	ctfgame,24,4
	.comm	enemies,4,4
	.comm	spawned,4,4
	.comm	lms_round,4,4
	.comm	terror_l,4,4
	.comm	swat_l,4,4
	.comm	lms_delay,4,4
	.comm	lms_delay2,4,4
	.comm	lms_players,4,4
	.comm	lms_dead_players,4,4
	.comm	lms_alive_players,4,4
	.comm	lms_round_over,4,4
	.section	".rodata"
	.align 3
.LC43:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC44:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC45:
	.long 0x42200000
	.section	".text"
	.align 2
	.type	 Mine_Think,@function
Mine_Think:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 3,0
	b .L8
.L10:
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 4,2,.L12
	lwz 0,280(3)
	lis 9,.LC0@ha
	la 9,.LC0@l(9)
	cmpw 0,0,9
	bc 12,2,.L12
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	cmpw 0,0,9
	bc 4,2,.L8
.L12:
	lis 11,level+4@ha
	lis 10,.LC43@ha
	lfs 0,level+4@l(11)
	lis 9,Mine_Blow@ha
	lfd 13,.LC43@l(10)
	la 9,Mine_Blow@l(9)
	stw 9,436(31)
	b .L68
.L8:
	lis 9,.LC45@ha
	addi 4,31,4
	la 9,.LC45@l(9)
	lfs 1,0(9)
	bl findradius
	mr. 3,3
	bc 4,2,.L10
	lis 9,level+4@ha
	lis 11,.LC44@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC44@l(11)
.L68:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 Mine_Think,.Lfe6-Mine_Think
	.align 2
	.globl Weapon_Mine
	.type	 Weapon_Mine,@function
Weapon_Mine:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,fire_frames.22@ha
	lis 11,Weapon_Mine_Place@ha
	la 9,fire_frames.22@l(9)
	la 11,Weapon_Mine_Place@l(11)
	lis 10,pause_frames.21@ha
	stw 9,8(1)
	li 4,4
	stw 11,12(1)
	la 10,pause_frames.21@l(10)
	li 5,12
	li 6,22
	li 7,24
	li 8,0
	li 9,0
	bl Weapon_Generic
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 Weapon_Mine,.Lfe7-Weapon_Mine
	.align 2
	.globl Weapon_C4
	.type	 Weapon_C4,@function
Weapon_C4:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,fire_frames.33@ha
	lis 11,Weapon_C4_Place@ha
	la 9,fire_frames.33@l(9)
	la 11,Weapon_C4_Place@l(11)
	lis 10,pause_frames.32@ha
	stw 9,8(1)
	li 4,4
	stw 11,12(1)
	la 10,pause_frames.32@l(10)
	li 5,10
	li 6,18
	li 7,20
	li 8,0
	li 9,0
	bl Weapon_Generic
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 Weapon_C4,.Lfe8-Weapon_C4
	.section	".rodata"
	.align 2
.LC46:
	.long 0x3f800000
	.align 2
.LC47:
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_Bush
	.type	 Weapon_Bush,@function
Weapon_Bush:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,10
	bc 4,2,.L45
	lis 29,gi@ha
	lis 3,.LC28@ha
	la 29,gi@l(29)
	la 3,.LC28@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC46@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC46@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 2,0(9)
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfs 3,0(9)
	blrl
.L45:
	lis 9,fire_frames.44@ha
	lis 11,Weapon_Bush_Strike@ha
	la 9,fire_frames.44@l(9)
	la 11,Weapon_Bush_Strike@l(11)
	lis 10,pause_frames.43@ha
	stw 9,8(1)
	mr 3,31
	stw 11,12(1)
	la 10,pause_frames.43@l(10)
	li 4,7
	li 5,15
	li 6,40
	li 7,48
	li 8,40
	li 9,48
	bl Weapon_Generic
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 Weapon_Bush,.Lfe9-Weapon_Bush
	.align 2
	.type	 Mine_Blow,@function
Mine_Blow:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl Grenade_Explode
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 Mine_Blow,.Lfe10-Mine_Blow
	.section	".rodata"
	.align 2
.LC48:
	.long 0xc0000000
	.align 3
.LC49:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC50:
	.long 0x43960000
	.section	".text"
	.align 2
	.type	 Weapon_C4_Place,@function
Weapon_C4_Place:
	stwu 1,-96(1)
	mflr 0
	stmw 28,80(1)
	stw 0,100(1)
	mr 31,3
	addi 30,1,24
	lwz 11,84(31)
	addi 28,1,40
	li 6,0
	mr 5,28
	mr 4,30
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	lwz 3,84(31)
	addi 3,3,3764
	bl AngleVectors
	lis 9,.LC48@ha
	lwz 4,84(31)
	mr 3,30
	la 9,.LC48@l(9)
	lfs 1,0(9)
	addi 4,4,3712
	bl VectorScale
	lwz 11,84(31)
	lis 0,0xc000
	lis 29,0x4330
	lis 10,.LC49@ha
	stw 0,3700(11)
	la 10,.LC49@l(10)
	mr 7,28
	lwz 0,508(31)
	addi 4,31,4
	addi 5,1,56
	lfd 13,0(10)
	mr 6,30
	addi 8,1,8
	xoris 0,0,0x8000
	lwz 3,84(31)
	li 10,0
	stw 0,76(1)
	stw 29,72(1)
	lfd 0,72(1)
	stw 10,60(1)
	stw 10,56(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	bl P_ProjectSource
	lwz 9,84(31)
	lwz 0,3640(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,1,.L29
	lis 9,.LC50@ha
	mr 3,31
	la 9,.LC50@l(9)
	mr 5,30
	lfs 1,0(9)
	addi 4,1,8
	li 6,300
	li 7,500
	bl Weapon_C4_Placed
.L29:
	lwz 0,100(1)
	mtlr 0
	lmw 28,80(1)
	la 1,96(1)
	blr
.Lfe11:
	.size	 Weapon_C4_Place,.Lfe11-Weapon_C4_Place
	.section	".rodata"
	.align 2
.LC51:
	.long 0xc0000000
	.align 3
.LC52:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.type	 Weapon_Bush_Strike,@function
Weapon_Bush_Strike:
	stwu 1,-112(1)
	mflr 0
	stmw 27,92(1)
	stw 0,116(1)
	mr 29,3
	addi 28,1,24
	lwz 11,84(29)
	addi 27,1,40
	li 6,0
	mr 5,27
	mr 4,28
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	lwz 3,84(29)
	addi 3,3,3764
	bl AngleVectors
	lis 9,.LC51@ha
	lwz 4,84(29)
	mr 3,28
	la 9,.LC51@l(9)
	lfs 1,0(9)
	addi 4,4,3712
	bl VectorScale
	lwz 11,84(29)
	lis 0,0xc000
	lis 10,0x4330
	mr 7,27
	stw 0,3700(11)
	addi 4,29,4
	addi 5,1,56
	lwz 0,508(29)
	lis 11,.LC52@ha
	mr 6,28
	la 11,.LC52@l(11)
	lwz 3,84(29)
	addi 8,1,8
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,84(1)
	li 11,0
	stw 10,80(1)
	lfd 0,80(1)
	stw 11,60(1)
	stw 11,56(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	bl P_ProjectSource
	mr 3,29
	mr 5,28
	addi 4,1,8
	li 6,200
	li 7,100
	bl Weapon_Bush_Struck
	lwz 0,116(1)
	mtlr 0
	lmw 27,92(1)
	la 1,112(1)
	blr
.Lfe12:
	.size	 Weapon_Bush_Strike,.Lfe12-Weapon_Bush_Strike
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
