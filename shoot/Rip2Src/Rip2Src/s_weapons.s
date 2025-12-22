	.file	"s_weapons.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC2:
	.string	"world/spark3.wav"
	.align 2
.LC0:
	.long 0xbca3d70a
	.align 2
.LC1:
	.long 0x46fffe00
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC4:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC5:
	.long 0x0
	.align 2
.LC6:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl bolt_touch
	.type	 bolt_touch,@function
bolt_touch:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	mr 31,3
	mr 30,5
	lwz 0,256(31)
	cmpw 0,4,0
	bc 12,2,.L6
	cmpwi 0,6,0
	bc 12,2,.L8
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L8
	bl G_FreeEdict
	b .L6
.L8:
	lwz 3,256(31)
	addi 29,31,4
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L9
	mr 4,29
	li 5,2
	bl PlayerNoise
.L9:
	lis 9,.LC0@ha
	mr 3,29
	lfs 1,.LC0@l(9)
	addi 4,31,376
	addi 5,1,8
	bl VectorMA
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,44(1)
	lis 10,.LC3@ha
	lis 11,.LC1@ha
	la 10,.LC3@l(10)
	stw 0,40(1)
	lfd 13,0(10)
	lfd 0,40(1)
	lis 10,.LC4@ha
	lfs 12,.LC1@l(11)
	la 10,.LC4@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L10
	cmpwi 0,30,0
	bc 4,2,.L11
	mr 4,29
	li 3,46
	mr 5,4
	b .L16
.L11:
	mr 4,29
	mr 5,30
	li 3,46
.L16:
	li 6,2
	bl G_ImpactEntity
	b .L13
.L10:
	cmpwi 0,30,0
	bc 4,2,.L14
	lis 6,vec3_origin@ha
	mr 5,29
	la 6,vec3_origin@l(6)
	li 3,15
	li 4,2400
	li 7,10
	li 8,2
	bl G_SplashEntity
	b .L13
.L14:
	mr 5,29
	mr 6,30
	li 3,15
	li 4,2400
	li 7,10
	li 8,2
	bl G_SplashEntity
.L13:
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC5@ha
	lis 10,.LC5@ha
	lis 11,.LC6@ha
	la 9,.LC5@l(9)
	la 10,.LC5@l(10)
	mr 5,3
	lfs 2,0(9)
	mtlr 0
	la 11,.LC6@l(11)
	mr 3,31
	lfs 3,0(10)
	li 4,2
	lfs 1,0(11)
	blrl
	mr 3,31
	bl G_FreeEdict
.L6:
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe1:
	.size	 bolt_touch,.Lfe1-bolt_touch
	.section	".rodata"
	.align 2
.LC7:
	.string	"models/objects/laser/tris.md2"
	.align 2
.LC8:
	.string	"fbolt"
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl fire_bolt
	.type	 fire_bolt,@function
fire_bolt:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 28,5
	mr 29,4
	mr 27,7
	mr 26,6
	mr 30,3
	bl G_Spawn
	lfs 13,0(29)
	mr 31,3
	mr 3,28
	addi 4,31,16
	stfs 13,4(31)
	lfs 0,4(29)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	lfs 0,0(28)
	stfs 0,340(31)
	lfs 13,4(28)
	stfs 13,344(31)
	lfs 0,8(28)
	stfs 0,348(31)
	bl vectoangles
	xoris 27,27,0x8000
	stw 27,20(1)
	lis 0,0x4330
	lis 11,.LC9@ha
	stw 0,16(1)
	la 11,.LC9@l(11)
	mr 3,28
	lfd 0,0(11)
	addi 4,31,376
	lfd 1,16(1)
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	lis 0,0x600
	li 9,8
	ori 0,0,3
	li 11,2
	stw 9,260(31)
	stw 0,252(31)
	stw 11,248(31)
	bl rand
	andi. 0,3,1
	li 0,32
	bc 12,2,.L21
	lis 0,0x20
.L21:
	stw 0,64(31)
	li 0,0
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,200(31)
	lis 3,.LC7@ha
	stw 0,196(31)
	la 3,.LC7@l(3)
	stw 0,192(31)
	stw 0,188(31)
	stw 0,208(31)
	stw 0,204(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,blaster_touch@ha
	lis 11,.LC8@ha
	stw 3,40(31)
	li 0,0
	la 9,blaster_touch@l(9)
	stw 30,256(31)
	la 11,.LC8@l(11)
	stw 9,444(31)
	mr 3,31
	stw 0,48(31)
	stw 26,516(31)
	stw 11,280(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 fire_bolt,.Lfe2-fire_bolt
	.section	".rodata"
	.align 3
.LC10:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl fire_el
	.type	 fire_el,@function
fire_el:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 28,5
	mr 29,4
	mr 27,7
	mr 26,6
	mr 30,3
	bl G_Spawn
	lfs 13,0(29)
	mr 31,3
	mr 3,28
	addi 4,31,16
	stfs 13,4(31)
	lfs 0,4(29)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	lfs 0,0(28)
	stfs 0,340(31)
	lfs 13,4(28)
	stfs 13,344(31)
	lfs 0,8(28)
	stfs 0,348(31)
	bl vectoangles
	xoris 27,27,0x8000
	stw 27,20(1)
	lis 0,0x4330
	lis 11,.LC10@ha
	stw 0,16(1)
	la 11,.LC10@l(11)
	mr 3,28
	lfd 0,0(11)
	addi 4,31,376
	lfd 1,16(1)
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	lis 0,0x600
	li 9,8
	ori 0,0,3
	li 11,2
	stw 9,260(31)
	stw 0,252(31)
	stw 11,248(31)
	bl rand
	andi. 0,3,1
	lis 0,0x20
	bc 4,2,.L28
	lwz 0,64(31)
	ori 0,0,7456
.L28:
	stw 0,64(31)
	li 0,0
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,200(31)
	lis 3,.LC7@ha
	stw 0,196(31)
	la 3,.LC7@l(3)
	stw 0,192(31)
	stw 0,188(31)
	stw 0,208(31)
	stw 0,204(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,blaster_touch@ha
	lis 11,.LC8@ha
	stw 3,40(31)
	li 0,0
	la 9,blaster_touch@l(9)
	stw 30,256(31)
	la 11,.LC8@l(11)
	stw 9,444(31)
	mr 3,31
	stw 0,48(31)
	stw 26,516(31)
	stw 11,280(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 fire_el,.Lfe3-fire_el
	.section	".rodata"
	.align 2
.LC11:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl fire_electric
	.type	 fire_electric,@function
fire_electric:
	stwu 1,-144(1)
	mflr 0
	stmw 26,120(1)
	stw 0,148(1)
	lis 9,.LC11@ha
	mr 29,4
	la 9,.LC11@l(9)
	addi 28,1,32
	lfs 1,0(9)
	mr 31,3
	mr 30,5
	mr 27,6
	mr 26,7
	mr 3,29
	mr 4,30
	mr 5,28
	bl VectorMA
	lis 11,gi+48@ha
	lis 9,0x600
	lfs 12,8(29)
	lwz 0,gi+48@l(11)
	addi 3,1,48
	mr 7,28
	lfs 13,0(29)
	addi 4,1,16
	li 5,0
	lfs 0,4(29)
	li 6,0
	mr 8,31
	mtlr 0
	ori 9,9,3
	stfs 12,24(1)
	stfs 13,16(1)
	stfs 0,20(1)
	blrl
	lwz 3,100(1)
	cmpw 0,3,31
	bc 12,2,.L24
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L24
	li 9,40
	li 0,0
	stw 9,12(1)
	mr 6,30
	mr 10,26
	stw 0,8(1)
	mr 9,27
	mr 4,31
	mr 5,31
	addi 7,1,60
	addi 8,1,72
	bl T_Damage
.L24:
	lfs 0,60(1)
	mr 3,31
	lfs 13,64(1)
	lfs 12,68(1)
	stfs 0,16(1)
	stfs 13,20(1)
	stfs 12,24(1)
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L25
	mr 3,31
	addi 4,1,60
	li 5,2
	bl PlayerNoise
.L25:
	lwz 9,92(1)
	cmpwi 0,9,0
	bc 12,2,.L26
	lwz 0,16(9)
	andi. 9,0,4
	bc 4,2,.L23
.L26:
	li 3,55
	addi 4,1,60
	addi 5,1,72
	li 6,2
	bl G_ImpactEntity
.L23:
	lwz 0,148(1)
	mtlr 0
	lmw 26,120(1)
	la 1,144(1)
	blr
.Lfe4:
	.size	 fire_electric,.Lfe4-fire_electric
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
