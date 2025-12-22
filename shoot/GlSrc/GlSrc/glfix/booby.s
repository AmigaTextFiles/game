	.file	"booby.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0xbca3d70a
	.align 2
.LC1:
	.long 0x3fe66666
	.align 3
.LC2:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC3:
	.long 0x42f00000
	.section	".text"
	.align 2
	.globl Cluster_Explode
	.type	 Cluster_Explode,@function
Cluster_Explode:
	stwu 1,-128(1)
	mflr 0
	stmw 28,112(1)
	stw 0,132(1)
	mr 31,3
	lwz 3,256(31)
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L7
	addi 4,31,4
	li 5,2
	bl PlayerNoise
.L7:
	lwz 0,612(31)
	lis 11,0x4330
	lis 8,.LC2@ha
	lfs 2,620(31)
	li 6,24
	xoris 0,0,0x8000
	la 8,.LC2@l(8)
	lwz 4,256(31)
	stw 0,108(1)
	mr 3,31
	addi 29,31,4
	stw 11,104(1)
	mr 30,29
	lfd 1,104(1)
	lfd 0,0(8)
	lwz 5,636(31)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
	lis 9,.LC0@ha
	mr 3,29
	lfs 1,.LC0@l(9)
	addi 4,31,472
	addi 5,1,8
	bl VectorMA
	lis 9,gi@ha
	li 3,3
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,708(31)
	cmpwi 0,0,0
	bc 12,2,.L8
	lwz 0,648(31)
	cmpwi 0,0,0
	bc 12,2,.L9
	lwz 0,100(29)
	li 3,18
	b .L14
.L9:
	lwz 0,100(29)
	li 3,17
	b .L14
.L8:
	lwz 0,648(31)
	cmpwi 0,0,0
	bc 12,2,.L12
	lwz 0,100(29)
	li 3,8
.L14:
	mtlr 0
	blrl
	b .L11
.L12:
	lwz 0,100(29)
	li 3,7
	mtlr 0
	blrl
.L11:
	lis 29,gi@ha
	addi 3,1,8
	la 29,gi@l(29)
	lis 28,.LC1@ha
	lwz 9,120(29)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,30
	li 4,2
	mtlr 0
	blrl
	lis 8,.LC3@ha
	lfs 1,.LC1@l(28)
	lis 9,0x4220
	la 8,.LC3@l(8)
	lwz 3,256(31)
	lis 0,0x41a0
	lfs 2,0(8)
	lis 11,0xc1a0
	li 10,0
	addi 4,1,8
	addi 5,1,24
	stw 0,60(1)
	stw 11,76(1)
	li 8,140
	li 6,120
	stw 10,92(1)
	li 7,10
	stw 9,96(1)
	stw 0,24(1)
	stw 0,28(1)
	stw 9,32(1)
	stw 0,40(1)
	stw 11,44(1)
	stw 9,48(1)
	stw 11,56(1)
	stw 9,64(1)
	stw 11,72(1)
	stw 9,80(1)
	stw 10,88(1)
	bl fire_grenade2
	lis 8,.LC3@ha
	lfs 1,.LC1@l(28)
	addi 4,1,8
	la 8,.LC3@l(8)
	lwz 3,256(31)
	addi 5,1,40
	lfs 2,0(8)
	li 6,120
	li 7,10
	li 8,140
	bl fire_grenade2
	lis 8,.LC3@ha
	lfs 1,.LC1@l(28)
	addi 4,1,8
	la 8,.LC3@l(8)
	lwz 3,256(31)
	addi 5,1,56
	lfs 2,0(8)
	li 6,120
	li 7,10
	li 8,140
	bl fire_grenade2
	lis 8,.LC3@ha
	lfs 1,.LC1@l(28)
	addi 4,1,8
	la 8,.LC3@l(8)
	lwz 3,256(31)
	addi 5,1,72
	lfs 2,0(8)
	li 6,120
	li 7,10
	li 8,140
	bl fire_grenade2
	lis 8,.LC3@ha
	lfs 1,.LC1@l(28)
	addi 4,1,8
	la 8,.LC3@l(8)
	lwz 3,256(31)
	addi 5,1,88
	lfs 2,0(8)
	li 6,120
	li 7,10
	li 8,140
	bl fire_grenade2
	mr 3,31
	bl G_FreeEdict
	lwz 0,132(1)
	mtlr 0
	lmw 28,112(1)
	la 1,128(1)
	blr
.Lfe1:
	.size	 Cluster_Explode,.Lfe1-Cluster_Explode
	.section	".rodata"
	.align 3
.LC4:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC5:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC6:
	.long 0x43fa0000
	.section	".text"
	.align 2
	.globl homing_think
	.type	 homing_think,@function
homing_think:
	stwu 1,-80(1)
	mflr 0
	stmw 30,72(1)
	stw 0,84(1)
	mr 31,3
	li 30,0
	b .L16
.L18:
	lwz 0,184(30)
	andi. 9,0,4
	bc 4,2,.L19
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L16
.L19:
	lwz 0,256(31)
	cmpw 0,30,0
	bc 12,2,.L16
	lwz 0,608(30)
	cmpwi 0,0,0
	bc 12,2,.L16
	lwz 0,576(30)
	cmpwi 0,0,0
	bc 4,1,.L16
	mr 3,31
	mr 4,30
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L16
	mr 3,31
	mr 4,30
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L16
	lfs 10,4(30)
	lis 10,0x4330
	lfs 9,4(31)
	lis 9,.LC5@ha
	mr 3,31
	la 9,.LC5@l(9)
	addi 4,1,40
	stfs 10,8(1)
	addi 5,1,24
	li 6,2
	lfs 0,8(30)
	fsubs 10,10,9
	li 7,1000
	li 8,60
	lfs 11,8(31)
	lfd 8,0(9)
	stfs 0,12(1)
	li 9,8
	lfs 13,12(30)
	fsubs 0,0,11
	lfs 12,12(31)
	stfs 9,40(1)
	stfs 13,16(1)
	stfs 12,48(1)
	stfs 11,44(1)
	lwz 0,604(30)
	stfs 0,28(1)
	xoris 0,0,0x8000
	stfs 10,24(1)
	stw 0,68(1)
	stw 10,64(1)
	lfd 0,64(1)
	fsub 0,0,8
	frsp 0,0
	fadds 13,13,0
	fsubs 12,13,12
	stfs 13,16(1)
	stfs 12,32(1)
	bl monster_fire_blaster
.L16:
	lis 9,.LC6@ha
	mr 3,30
	la 9,.LC6@l(9)
	addi 4,31,4
	lfs 1,0(9)
	bl findradius
	mr. 30,3
	bc 4,2,.L18
	lis 9,level+4@ha
	lis 11,.LC4@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC4@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
	lwz 0,84(1)
	mtlr 0
	lmw 30,72(1)
	la 1,80(1)
	blr
.Lfe2:
	.size	 homing_think,.Lfe2-homing_think
	.section	".rodata"
	.align 2
.LC7:
	.long 0x46fffe00
	.align 3
.LC8:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC10:
	.long 0x40140000
	.long 0x0
	.align 2
.LC11:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl Proxim_Think
	.type	 Proxim_Think,@function
Proxim_Think:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 30,3
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	li 31,0
	lfs 0,692(30)
	fcmpu 0,13,0
	bc 4,1,.L27
	bl Grenade_Explode
.L27:
	lis 9,Proxim_Think@ha
	la 9,Proxim_Think@l(9)
	stw 9,532(30)
	addi 29,30,4
	b .L28
.L30:
	lwz 0,184(31)
	andi. 9,0,4
	bc 4,2,.L31
	lwz 9,84(31)
	lwz 0,292(31)
	subfic 11,9,0
	adde 9,11,9
	subfic 11,0,0
	adde 0,11,0
	and. 11,9,0
	bc 4,2,.L28
.L31:
	lwz 0,256(30)
	cmpw 0,31,0
	bc 12,2,.L28
	lwz 0,608(31)
	cmpwi 0,0,0
	bc 12,2,.L28
	lwz 0,576(31)
	cmpwi 0,0,0
	bc 4,1,.L28
	mr 3,30
	mr 4,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L28
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 9,.LC9@ha
	lis 10,.LC7@ha
	la 9,.LC9@l(9)
	stw 0,24(1)
	lfd 13,0(9)
	lfd 0,24(1)
	lis 9,.LC10@ha
	lfs 11,.LC7@l(10)
	la 9,.LC10@l(9)
	lfd 10,0(9)
	fsub 0,0,13
	mr 9,11
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fmul 13,13,10
	fctiwz 12,13
	stfd 12,24(1)
	lwz 9,28(1)
	cmpwi 0,9,4
	bc 4,2,.L36
	lis 9,Cluster_Explode@ha
	la 9,Cluster_Explode@l(9)
	stw 9,532(30)
	b .L29
.L36:
	lis 9,Grenade_Explode@ha
	la 9,Grenade_Explode@l(9)
	stw 9,532(30)
	b .L29
.L28:
	lis 11,.LC11@ha
	mr 3,31
	la 11,.LC11@l(11)
	mr 4,29
	lfs 1,0(11)
	bl findradius
	mr. 31,3
	bc 4,2,.L30
.L29:
	lis 9,level+4@ha
	lis 11,.LC8@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC8@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(30)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 Proxim_Think,.Lfe3-Proxim_Think
	.section	".rodata"
	.align 2
.LC12:
	.string	"Too close to wall.\n"
	.align 2
.LC13:
	.string	"trap"
	.align 2
.LC14:
	.string	"Another Trap Too Close\n"
	.align 2
.LC15:
	.string	"Players are nearby,cant place\n"
	.align 2
.LC16:
	.string	"Cells"
	.align 2
.LC17:
	.string	"models/items/armor/body/tris.md2"
	.align 2
.LC18:
	.string	"models/items/quaddama/tris.md2"
	.align 2
.LC19:
	.string	"models/items/mega_h/tris.md2"
	.align 2
.LC20:
	.string	"models/objects/barrels/tris.md2"
	.align 2
.LC21:
	.long 0x43160000
	.align 3
.LC22:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC23:
	.long 0x43960000
	.align 2
.LC24:
	.long 0x42c80000
	.align 2
.LC25:
	.long 0x3f800000
	.align 2
.LC26:
	.long 0x43340000
	.section	".text"
	.align 2
	.globl SP_boobytrap
	.type	 SP_boobytrap,@function
SP_boobytrap:
	stwu 1,-128(1)
	mflr 0
	stmw 26,104(1)
	stw 0,132(1)
	mr 30,3
	mr 27,4
	lwz 3,84(30)
	li 31,0
	cmpwi 0,3,0
	bc 12,2,.L39
	lwz 0,576(30)
	cmpwi 0,0,0
	bc 4,1,.L39
	lfs 12,4(30)
	addi 4,1,8
	addi 3,3,3636
	lfs 13,8(30)
	li 5,0
	li 6,0
	lfs 0,12(30)
	addi 29,30,4
	stfs 12,24(1)
	mr 28,29
	stfs 13,28(1)
	stfs 0,32(1)
	bl AngleVectors
	lis 11,.LC21@ha
	lfs 0,4(30)
	lis 9,gi@ha
	la 11,.LC21@l(11)
	lfs 10,8(1)
	la 26,gi@l(9)
	lfs 11,0(11)
	li 9,3
	addi 3,1,40
	lfs 13,12(30)
	mr 4,29
	li 5,0
	lfs 9,8(30)
	li 6,0
	addi 7,1,24
	fmadds 10,10,11,0
	lfs 12,12(1)
	mr 8,30
	lfs 0,16(1)
	lwz 11,48(26)
	fmadds 12,12,11,9
	stfs 10,24(1)
	fmadds 0,0,11,13
	mtlr 11
	stfs 12,28(1)
	stfs 0,32(1)
	blrl
	lfs 0,48(1)
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L42
	lwz 0,8(26)
	lis 5,.LC12@ha
	mr 3,30
	la 5,.LC12@l(5)
	b .L67
.L42:
	lis 29,.LC13@ha
	b .L43
.L45:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L43
	lwz 3,280(31)
	la 4,.LC13@l(29)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L65
.L43:
	lis 9,.LC21@ha
	mr 3,31
	la 9,.LC21@l(9)
	mr 4,28
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 4,2,.L45
	b .L49
.L51:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L49
	lwz 0,320(31)
	cmpwi 0,0,0
	bc 12,2,.L66
.L49:
	lis 9,.LC23@ha
	mr 3,31
	la 9,.LC23@l(9)
	mr 4,28
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 4,2,.L51
	lwz 9,84(1)
	cmpwi 0,9,0
	bc 12,2,.L55
	lwz 0,16(9)
	andi. 9,0,4
	bc 4,2,.L39
.L55:
	bl G_Spawn
	mr 31,3
	lis 3,.LC16@ha
	addi 29,31,4
	la 3,.LC16@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 4,1,8
	mullw 3,3,0
	li 6,0
	li 5,0
	srawi 3,3,2
	stw 3,736(10)
	lwz 11,84(30)
	lwz 0,736(11)
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,-10
	stwx 9,11,0
	stw 30,256(31)
	lwz 3,84(30)
	addi 3,3,3636
	bl AngleVectors
	lis 9,.LC24@ha
	addi 4,1,8
	la 9,.LC24@l(9)
	mr 5,29
	lfs 1,0(9)
	mr 3,28
	bl VectorMA
	lfs 13,16(30)
	lis 9,gi@ha
	li 3,1
	la 28,gi@l(9)
	stfs 13,16(31)
	lfs 0,20(30)
	stfs 0,20(31)
	lfs 13,24(30)
	stfs 13,24(31)
	lwz 9,100(28)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xbdef
	lwz 10,104(28)
	lwz 3,g_edicts@l(9)
	ori 0,0,31711
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,5
	blrl
	lwz 9,100(28)
	li 3,9
	mtlr 9
	blrl
	lwz 9,88(28)
	mr 3,29
	li 4,2
	mtlr 9
	blrl
	addi 0,27,-2
	lis 9,0x600
	cmplwi 0,0,1
	li 11,120
	lis 10,0x42dc
	ori 9,9,3
	stw 11,612(31)
	li 0,2
	stw 10,620(31)
	mfcr 29
	stw 9,252(31)
	stw 0,248(31)
	bc 4,1,.L57
	lwz 0,64(31)
	ori 0,0,1
	stw 0,64(31)
.L57:
	li 0,7
	lis 3,.LC17@ha
	stw 0,260(31)
	la 3,.LC17@l(3)
	lwz 9,32(28)
	mtlr 9
	blrl
	cmpwi 0,27,1
	stw 3,40(31)
	bc 4,2,.L58
	lwz 9,32(28)
	lis 3,.LC18@ha
	la 3,.LC18@l(3)
	mtlr 9
	blrl
	stw 3,40(31)
.L58:
	cmpwi 0,27,2
	bc 4,2,.L59
	lwz 9,32(28)
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	mtlr 9
	blrl
	stw 3,40(31)
.L59:
	cmpwi 0,27,3
	mfcr 30
	bc 4,2,.L60
	lwz 0,32(28)
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	mtlr 0
	blrl
	stw 3,40(31)
.L60:
	lis 9,.LC13@ha
	lis 11,Proxim_Think@ha
	la 9,.LC13@l(9)
	la 11,Proxim_Think@l(11)
	stw 9,280(31)
	lis 10,level@ha
	mtcrf 128,29
	lis 9,.LC25@ha
	stw 11,532(31)
	la 10,level@l(10)
	la 9,.LC25@l(9)
	lfs 0,4(10)
	lis 11,.LC26@ha
	lfs 13,0(9)
	la 11,.LC26@l(11)
	lfs 12,0(11)
	fadds 0,0,13
	stfs 0,524(31)
	lfs 13,4(10)
	fadds 13,13,12
	stfs 13,692(31)
	bc 4,1,.L61
	lis 9,0xc180
	lis 0,0xc1c0
	b .L68
.L61:
	mtcrf 128,30
	bc 4,2,.L63
	lis 9,0xc180
	li 0,0
.L68:
	stw 9,192(31)
	stw 0,196(31)
	stw 9,188(31)
	b .L62
.L65:
	lis 9,gi+8@ha
	lis 5,.LC14@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC14@l(5)
	b .L67
.L66:
	lis 9,gi+8@ha
	lis 5,.LC15@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC15@l(5)
.L67:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L39
.L63:
	lis 0,0xc180
	stw 0,196(31)
	stw 0,188(31)
	stw 0,192(31)
.L62:
	lis 10,0x4180
	lis 0,0x4200
	li 9,40
	stw 10,204(31)
	lis 11,gi+72@ha
	stw 0,208(31)
	mr 3,31
	stw 9,496(31)
	stw 10,200(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L39:
	lwz 0,132(1)
	mtlr 0
	lmw 26,104(1)
	la 1,128(1)
	blr
.Lfe4:
	.size	 SP_boobytrap,.Lfe4-SP_boobytrap
	.section	".rodata"
	.align 3
.LC27:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC28:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl Mine_Think
	.type	 Mine_Think,@function
Mine_Think:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	li 31,0
	lfs 0,692(30)
	fcmpu 0,13,0
	bc 4,1,.L71
	bl Cluster_Explode
.L71:
	lis 9,Mine_Think@ha
	la 9,Mine_Think@l(9)
	stw 9,532(30)
	addi 29,30,4
	b .L72
.L74:
	lwz 0,184(31)
	andi. 9,0,4
	bc 4,2,.L75
	lwz 9,84(31)
	lwz 0,292(31)
	subfic 11,9,0
	adde 9,11,9
	subfic 11,0,0
	adde 0,11,0
	and. 11,9,0
	bc 4,2,.L72
.L75:
	lwz 0,256(30)
	cmpw 0,31,0
	bc 12,2,.L72
	lwz 0,608(31)
	cmpwi 0,0,0
	bc 12,2,.L72
	lwz 0,576(31)
	cmpwi 0,0,0
	bc 4,1,.L72
	mr 3,30
	mr 4,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L72
	lis 9,Cluster_Explode@ha
	la 9,Cluster_Explode@l(9)
	stw 9,532(30)
	b .L73
.L72:
	lis 9,.LC28@ha
	mr 3,31
	la 9,.LC28@l(9)
	mr 4,29
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 4,2,.L74
.L73:
	lwz 0,576(30)
	cmpwi 0,0,0
	bc 12,1,.L81
	mr 3,30
	bl Cluster_Explode
.L81:
	lis 9,level+4@ha
	lis 11,.LC27@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC27@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(30)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Mine_Think,.Lfe5-Mine_Think
	.section	".rodata"
	.align 2
.LC29:
	.string	"models/objects/mine/tris.md2"
	.align 2
.LC30:
	.long 0x43160000
	.align 3
.LC31:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC32:
	.long 0x43960000
	.align 2
.LC33:
	.long 0x42c80000
	.align 2
.LC34:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl SP_minetrap
	.type	 SP_minetrap,@function
SP_minetrap:
	stwu 1,-128(1)
	mflr 0
	stmw 26,104(1)
	stw 0,132(1)
	mr 31,3
	li 28,0
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 12,2,.L82
	lwz 0,576(31)
	cmpwi 0,0,0
	bc 4,1,.L82
	lfs 12,4(31)
	addi 4,1,8
	addi 3,3,3636
	lfs 13,8(31)
	li 5,0
	li 6,0
	lfs 0,12(31)
	addi 29,31,4
	stfs 12,24(1)
	mr 30,29
	stfs 13,28(1)
	stfs 0,32(1)
	bl AngleVectors
	lis 11,.LC30@ha
	lfs 0,4(31)
	lis 9,gi@ha
	la 11,.LC30@l(11)
	lfs 10,8(1)
	la 27,gi@l(9)
	lfs 11,0(11)
	li 9,3
	addi 3,1,40
	lfs 13,12(31)
	mr 4,29
	li 5,0
	lfs 9,8(31)
	li 6,0
	addi 7,1,24
	fmadds 10,10,11,0
	lfs 12,12(1)
	mr 8,31
	lfs 0,16(1)
	lwz 11,48(27)
	fmadds 12,12,11,9
	stfs 10,24(1)
	fmadds 0,0,11,13
	mtlr 11
	stfs 12,28(1)
	stfs 0,32(1)
	blrl
	lfs 0,48(1)
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L85
	lwz 0,8(27)
	lis 5,.LC12@ha
	mr 3,31
	la 5,.LC12@l(5)
	b .L102
.L100:
	lis 9,gi+8@ha
	lis 5,.LC14@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC14@l(5)
	b .L102
.L101:
	lis 9,gi+8@ha
	lis 5,.LC15@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC15@l(5)
.L102:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L82
.L85:
	lis 29,.LC13@ha
	b .L86
.L88:
	lwz 0,84(28)
	cmpwi 0,0,0
	bc 4,2,.L86
	lwz 3,280(28)
	la 4,.LC13@l(29)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L100
.L86:
	lis 9,.LC30@ha
	mr 3,28
	la 9,.LC30@l(9)
	mr 4,30
	lfs 1,0(9)
	bl findradius
	mr. 28,3
	bc 4,2,.L88
	b .L92
.L94:
	lwz 0,84(28)
	cmpwi 0,0,0
	bc 12,2,.L92
	lwz 0,320(28)
	cmpwi 0,0,0
	bc 12,2,.L101
.L92:
	lis 9,.LC32@ha
	mr 3,28
	la 9,.LC32@l(9)
	mr 4,30
	lfs 1,0(9)
	bl findradius
	mr. 28,3
	bc 4,2,.L94
	lwz 9,84(1)
	cmpwi 0,9,0
	bc 12,2,.L98
	lwz 0,16(9)
	andi. 9,0,4
	bc 4,2,.L82
.L98:
	bl G_Spawn
	li 26,2
	mr 29,3
	lis 3,.LC16@ha
	addi 27,29,4
	la 3,.LC16@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	addi 4,1,8
	li 6,0
	li 5,0
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,-2
	stwx 9,11,3
	stw 31,256(29)
	lwz 3,84(31)
	addi 3,3,3636
	bl AngleVectors
	lis 9,.LC33@ha
	addi 4,1,8
	la 9,.LC33@l(9)
	mr 5,27
	lfs 1,0(9)
	mr 3,30
	bl VectorMA
	lfs 13,16(31)
	lis 28,gi@ha
	li 3,1
	la 28,gi@l(28)
	stfs 13,16(29)
	lfs 0,20(31)
	stfs 0,20(29)
	lfs 13,24(31)
	stfs 13,24(29)
	lwz 9,100(28)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xbdef
	lwz 10,104(28)
	lwz 3,g_edicts@l(9)
	ori 0,0,31711
	mtlr 10
	subf 3,3,29
	mullw 3,3,0
	srawi 3,3,5
	blrl
	lwz 9,100(28)
	li 3,9
	mtlr 9
	blrl
	lwz 9,88(28)
	mr 3,27
	li 4,2
	mtlr 9
	blrl
	lis 9,mine_die@ha
	lis 0,0x600
	stw 26,248(29)
	la 9,mine_die@l(9)
	ori 0,0,3
	li 11,30
	li 10,120
	stw 0,252(29)
	lis 8,0x42dc
	stw 11,576(29)
	lis 3,.LC29@ha
	stw 10,612(29)
	la 3,.LC29@l(3)
	stw 8,620(29)
	stw 9,552(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,.LC13@ha
	lis 11,Mine_Think@ha
	stw 3,40(29)
	la 9,.LC13@l(9)
	la 11,Mine_Think@l(11)
	stw 9,280(29)
	li 0,7
	lis 10,level@ha
	lis 9,.LC34@ha
	stw 0,260(29)
	la 10,level@l(10)
	stw 11,532(29)
	la 9,.LC34@l(9)
	lis 8,0xc180
	lfs 13,4(10)
	lis 11,.LC32@ha
	li 0,0
	lfs 0,0(9)
	la 11,.LC32@l(11)
	li 7,40
	lfs 12,0(11)
	lis 9,0x4100
	mr 3,29
	lis 11,0x4180
	fadds 13,13,0
	stfs 13,524(29)
	lfs 0,4(10)
	stw 8,192(29)
	stw 0,196(29)
	fadds 0,0,12
	stw 11,204(29)
	stw 9,208(29)
	stw 26,608(29)
	stfs 0,692(29)
	stw 7,496(29)
	stw 8,188(29)
	stw 11,200(29)
	lwz 0,72(28)
	mtlr 0
	blrl
.L82:
	lwz 0,132(1)
	mtlr 0
	lmw 26,104(1)
	la 1,128(1)
	blr
.Lfe6:
	.size	 SP_minetrap,.Lfe6-SP_minetrap
	.comm	maplist,292,4
	.align 2
	.globl mine_die
	.type	 mine_die,@function
mine_die:
	lis 9,Grenade_Explode@ha
	la 9,Grenade_Explode@l(9)
	stw 9,532(3)
	blr
.Lfe7:
	.size	 mine_die,.Lfe7-mine_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
