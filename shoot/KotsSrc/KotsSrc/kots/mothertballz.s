	.file	"mothertballz.cpp"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Damage Amp"
	.align 2
.LC1:
	.string	"resist"
	.align 2
.LC2:
	.long 0x47800000
	.align 2
.LC3:
	.long 0x43b40000
	.align 2
.LC4:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl KOTSTeleport__FP7edict_s
	.type	 KOTSTeleport__FP7edict_s,@function
KOTSTeleport__FP7edict_s:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,0
	bc 4,2,.L18
	lwz 0,1860(9)
	cmpwi 0,0,24
	bc 12,1,.L18
	bl SelectDeathmatchSpawnPoint
	mr. 30,3
	bc 4,2,.L5
.L18:
	li 3,0
	b .L16
.L5:
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L6
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L6
	lwz 0,12(3)
	mr 4,3
	mr 3,31
	mtlr 0
	blrl
.L6:
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L8
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L8
	lwz 0,12(3)
	mr 4,3
	mr 3,31
	mtlr 0
	blrl
.L8:
	lis 9,gi+76@ha
	mr 3,31
	lwz 0,gi+76@l(9)
	mtlr 0
	blrl
	lfs 0,4(30)
	lis 9,.LC2@ha
	li 0,0
	la 9,.LC2@l(9)
	lwz 10,84(31)
	li 11,20
	lfs 10,0(9)
	li 8,6
	addi 5,30,16
	stfs 0,4(31)
	lis 9,.LC3@ha
	li 6,0
	lfs 0,8(30)
	la 9,.LC3@l(9)
	li 7,0
	lfs 11,0(9)
	lis 9,.LC4@ha
	stfs 0,8(31)
	la 9,.LC4@l(9)
	lfs 12,12(30)
	lfs 13,0(9)
	li 9,3
	stfs 12,12(31)
	mtctr 9
	lfs 0,4(30)
	fadds 12,12,13
	stfs 0,28(31)
	lfs 13,8(30)
	stfs 13,32(31)
	lfs 0,12(30)
	stfs 12,12(31)
	stw 0,376(31)
	stfs 0,36(31)
	stw 0,384(31)
	stw 0,380(31)
	stb 11,17(10)
	lwz 9,84(31)
	lbz 0,16(9)
	ori 0,0,32
	stb 0,16(9)
	stw 8,80(31)
.L17:
	lwz 10,84(31)
	add 0,6,6
	lfsx 0,7,5
	addi 6,6,1
	addi 9,10,3564
	lfsx 13,9,7
	addi 10,10,20
	addi 7,7,4
	fsubs 0,0,13
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,16(1)
	lwz 11,20(1)
	sthx 11,10,0
	bdnz .L17
	li 0,0
	lwz 11,84(31)
	mr 3,31
	stw 0,24(31)
	stw 0,20(31)
	stw 0,16(31)
	stw 0,28(11)
	stw 0,36(11)
	stw 0,32(11)
	lwz 9,84(31)
	stw 0,3760(9)
	stw 0,3768(9)
	stw 0,3764(9)
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	li 3,1
.L16:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 KOTSTeleport__FP7edict_s,.Lfe1-KOTSTeleport__FP7edict_s
	.section	".rodata"
	.align 2
.LC5:
	.string	"tball"
	.align 2
.LC6:
	.string	"%s stopped %s's tball\n"
	.align 2
.LC7:
	.string	"misc/tele1.wav"
	.align 2
.LC8:
	.string	"player"
	.align 2
.LC9:
	.string	"%s was teleported by %s\n"
	.align 2
.LC10:
	.string	"%s teleports away\n"
	.align 2
.LC11:
	.string	"KOTSbot"
	.align 2
.LC12:
	.long 0x3f000000
	.align 3
.LC13:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC14:
	.long 0x0
	.align 2
.LC15:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl T_RadiusTeleport__FP7edict_sT0fT0f
	.type	 T_RadiusTeleport__FP7edict_sT0fT0f,@function
T_RadiusTeleport__FP7edict_sT0fT0f:
	stwu 1,-112(1)
	mflr 0
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 20,48(1)
	stw 0,116(1)
	mr 28,4
	mr 30,3
	fmr 30,1
	mr 27,5
	fmr 31,2
	mr 3,28
	bl KOTSGetUser__FP7edict_s
	li 21,0
	li 24,0
	addi 29,1,24
	mr 20,3
	mr 3,29
	li 31,0
	bl __10CNPtrArray
	mr 25,29
	b .L20
.L22:
	cmpw 0,31,27
	bc 12,2,.L20
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L20
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L20
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L20
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L20
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 12,2,.L20
	lwz 0,3576(9)
	cmpwi 0,0,0
	bc 4,2,.L20
	lfs 0,200(31)
	lis 9,.LC12@ha
	addi 4,1,8
	lfs 13,188(31)
	la 9,.LC12@l(9)
	addi 3,31,4
	lfs 1,0(9)
	mr 5,4
	fadds 13,13,0
	stfs 13,8(1)
	lfs 13,204(31)
	lfs 0,192(31)
	fadds 0,0,13
	stfs 0,12(1)
	lfs 0,208(31)
	lfs 13,196(31)
	fadds 13,13,0
	stfs 13,16(1)
	bl VectorMA
	lfs 0,4(30)
	addi 3,1,8
	lfs 13,8(30)
	lfs 12,12(30)
	lfs 9,8(1)
	lfs 11,12(1)
	lfs 10,16(1)
	fsubs 0,0,9
	fsubs 13,13,11
	fsubs 12,12,10
	stfs 0,8(1)
	stfs 13,12(1)
	stfs 12,16(1)
	bl VectorLength
	lis 9,.LC13@ha
	cmpw 0,31,28
	la 9,.LC13@l(9)
	fmr 0,30
	lfd 12,0(9)
	fmul 1,1,12
	fsub 0,0,1
	frsp 13,0
	bc 4,2,.L29
	fmr 0,13
	fmul 0,0,12
	frsp 13,0
.L29:
	lis 11,.LC14@ha
	la 11,.LC14@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 12,3,.L20
	mr 3,31
	mr 4,30
	bl CanDamage
	cmpwi 0,3,0
	bc 12,2,.L20
	lwz 9,84(31)
	lwz 0,1820(9)
	cmpwi 0,0,0
	bc 12,2,.L32
	lis 3,.LC5@ha
	la 3,.LC5@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 11,0x286b
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,3
	addi 10,10,740
	mullw 0,0,11
	lis 8,gi@ha
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	li 3,2
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lwz 5,84(31)
	lwz 6,84(28)
	lwz 0,gi@l(8)
	addi 5,5,700
	addi 6,6,700
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,25
	li 4,2
	bl _._10CNPtrArray
	b .L19
.L32:
	mr 3,25
	mr 4,31
	bl Add__10CNPtrArrayPv
.L20:
	fmr 1,31
	mr 3,31
	addi 4,30,4
	bl findradius
	mr. 31,3
	bc 4,2,.L22
	lis 9,gi@ha
	li 27,0
	la 22,gi@l(9)
	lis 23,.LC9@ha
	b .L34
.L37:
	mr 4,27
	mr 3,25
	bl __vc__10CNPtrArrayi
	lwz 31,0(3)
	mr 3,31
	bl KOTSTeleport__FP7edict_s
	cmpwi 0,3,0
	bc 12,2,.L36
	lwz 9,36(22)
	lis 3,.LC7@ha
	lis 30,.LC8@ha
	la 3,.LC7@l(3)
	lis 29,gi@ha
	mtlr 9
	lis 26,gi@ha
	blrl
	lis 9,.LC15@ha
	lis 11,.LC14@ha
	la 9,.LC15@l(9)
	la 11,.LC14@l(11)
	lfs 2,0(9)
	mr 5,3
	li 4,3
	lfs 3,0(11)
	lis 9,.LC15@ha
	mr 3,31
	lwz 11,16(22)
	la 9,.LC15@l(9)
	lfs 1,0(9)
	mtlr 11
	blrl
	lwz 3,280(31)
	la 4,.LC8@l(30)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L39
	lwz 3,280(28)
	la 4,.LC8@l(30)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L39
	cmpw 0,31,28
	bc 12,2,.L40
	lwz 5,84(31)
	li 3,2
	la 4,.LC9@l(23)
	lwz 6,84(28)
	addi 24,24,1
	lwz 0,gi@l(29)
	addi 5,5,700
	addi 6,6,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L36
.L40:
	lwz 5,84(28)
	lis 4,.LC10@ha
	li 3,2
	lwz 0,gi@l(29)
	la 4,.LC10@l(4)
	li 21,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L36
.L39:
	lwz 3,280(31)
	lis 4,.LC11@ha
	li 5,7
	la 4,.LC11@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 4,2,.L36
	lwz 6,84(28)
	li 3,2
	la 4,.LC9@l(23)
	lwz 0,gi@l(26)
	lwz 5,280(31)
	addi 6,6,700
	mtlr 0
	crxor 6,6,6
	blrl
.L36:
	addi 27,27,1
.L34:
	mr 3,25
	bl GetSize__C10CNPtrArray
	cmpw 0,27,3
	bc 12,0,.L37
	cmpwi 0,21,0
	bc 4,2,.L45
	srawi 0,24,31
	addic 11,20,-1
	subfe 9,11,20
	subf 0,24,0
	srwi 0,0,31
	and. 11,9,0
	bc 12,2,.L45
	mr 3,20
	mr 4,24
	li 5,4
	bl KOTSChangeScore__FP5CUserii
.L45:
	mr 3,25
	li 4,2
	bl _._10CNPtrArray
.L19:
	lwz 0,116(1)
	mtlr 0
	lmw 20,48(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe2:
	.size	 T_RadiusTeleport__FP7edict_sT0fT0f,.Lfe2-T_RadiusTeleport__FP7edict_sT0fT0f
	.section	".rodata"
	.align 2
.LC16:
	.long 0xbca3d70a
	.align 3
.LC17:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC18:
	.long 0x42200000
	.section	".text"
	.align 2
	.type	 T_Ballz_Explode__FP7edict_s,@function
T_Ballz_Explode__FP7edict_s:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	mr 31,3
	lwz 3,256(31)
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L51
	addi 4,31,4
	li 5,2
	bl PlayerNoise
.L51:
	lwz 0,516(31)
	lis 11,0x4330
	lis 10,.LC17@ha
	lfs 0,524(31)
	mr 3,31
	xoris 0,0,0x8000
	la 10,.LC17@l(10)
	lwz 4,256(31)
	stw 0,44(1)
	li 5,0
	addi 29,31,4
	stw 11,40(1)
	mr 30,29
	lfd 13,0(10)
	lfd 1,40(1)
	lis 10,.LC18@ha
	la 10,.LC18@l(10)
	lfs 2,0(10)
	fsub 1,1,13
	fadds 2,0,2
	frsp 1,1
	bl T_RadiusTeleport__FP7edict_sT0fT0f
	lis 9,.LC16@ha
	mr 3,29
	lfs 1,.LC16@l(9)
	addi 4,31,376
	addi 5,1,8
	bl VectorMA
	lis 9,gi@ha
	li 3,3
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L52
	lwz 0,552(31)
	cmpwi 0,0,0
	b .L59
.L52:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L56
.L59:
	lwz 0,100(29)
	li 3,20
	mtlr 0
	blrl
	b .L55
.L56:
	lwz 0,100(29)
	li 3,20
	mtlr 0
	blrl
.L55:
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
.Lfe3:
	.size	 T_Ballz_Explode__FP7edict_s,.Lfe3-T_Ballz_Explode__FP7edict_s
	.section	".rodata"
	.align 2
.LC20:
	.string	"weapons/hgrenb1a.wav"
	.align 2
.LC21:
	.string	"weapons/hgrenb2a.wav"
	.align 2
.LC22:
	.string	"weapons/grenlb1b.wav"
	.align 2
.LC24:
	.string	"models/items/ammo/grenades/medium/tris.md2"
	.align 2
.LC25:
	.string	"T_Ball"
	.align 2
.LC23:
	.long 0x46fffe00
	.align 3
.LC26:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC27:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC28:
	.long 0x40240000
	.long 0x0
	.align 3
.LC29:
	.long 0x40690000
	.long 0x0
	.align 2
.LC30:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl fire_T_Ballz__FP7edict_sPfT1iiffi
	.type	 fire_T_Ballz__FP7edict_sPfT1iiffi,@function
fire_T_Ballz__FP7edict_sPfT1iiffi:
	stwu 1,-176(1)
	mflr 0
	stfd 27,136(1)
	stfd 28,144(1)
	stfd 29,152(1)
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 20,88(1)
	stw 0,180(1)
	mr 27,4
	mr 25,5
	fmr 27,2
	mr 22,3
	mr 29,7
	mr 20,8
	addi 4,1,8
	mr 21,6
	mr 3,25
	bl vectoangles
	lis 26,0x4330
	addi 23,1,40
	addi 24,1,56
	mr 6,24
	addi 4,1,24
	addi 3,1,8
	mr 5,23
	bl AngleVectors
	lis 9,.LC26@ha
	la 9,.LC26@l(9)
	lfd 31,0(9)
	bl G_Spawn
	lis 9,.LC27@ha
	lfs 13,0(27)
	xoris 29,29,0x8000
	la 9,.LC27@l(9)
	mr 31,3
	lfd 29,0(9)
	lis 10,.LC28@ha
	addi 28,31,376
	stfs 13,4(31)
	la 10,.LC28@l(10)
	stw 29,84(1)
	mr 4,28
	mr 3,25
	stw 26,80(1)
	lfd 1,80(1)
	lfs 0,4(27)
	lfd 28,0(10)
	fsub 1,1,31
	stfs 0,8(31)
	lfs 13,8(27)
	frsp 1,1
	stfs 13,12(31)
	bl VectorScale
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC23@ha
	stw 3,84(1)
	lis 10,.LC29@ha
	mr 4,24
	stw 26,80(1)
	la 10,.LC29@l(10)
	mr 5,28
	lfd 0,80(1)
	mr 3,28
	lfs 30,.LC23@l(11)
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
	lwz 11,64(31)
	lis 0,0x600
	lis 10,0x4396
	lis 8,0xc100
	lis 7,0x4100
	stw 10,396(31)
	ori 11,11,32
	ori 0,0,3
	stw 8,196(31)
	li 6,2
	li 9,9
	stw 0,252(31)
	lis 29,gi@ha
	stw 6,248(31)
	lis 3,.LC24@ha
	la 29,gi@l(29)
	stw 11,64(31)
	la 3,.LC24@l(3)
	stw 7,208(31)
	stw 10,388(31)
	stw 10,392(31)
	stw 8,188(31)
	stw 8,192(31)
	stw 7,200(31)
	stw 7,204(31)
	stw 9,260(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 11,T_Ball_Touch__FP7edict_sT0P8cplane_sP10csurface_s@ha
	lis 9,.LC30@ha
	stw 3,40(31)
	la 11,T_Ball_Touch__FP7edict_sT0P8cplane_sP10csurface_s@l(11)
	stw 22,256(31)
	lis 10,level+4@ha
	stw 11,444(31)
	la 9,.LC30@l(9)
	mr 3,31
	lfs 0,level+4@l(10)
	lis 11,.LC25@ha
	lfs 13,0(9)
	la 11,.LC25@l(11)
	lis 9,T_Ballz_Explode__FP7edict_s@ha
	stw 21,516(31)
	la 9,T_Ballz_Explode__FP7edict_s@l(9)
	stfs 27,524(31)
	fadds 0,0,13
	stw 9,436(31)
	stw 11,280(31)
	stfs 0,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	cmpwi 0,20,0
	bc 12,2,.L71
	mr 3,31
	bl T_Ballz_Explode__FP7edict_s
.L71:
	lwz 0,180(1)
	mtlr 0
	lmw 20,88(1)
	lfd 27,136(1)
	lfd 28,144(1)
	lfd 29,152(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe4:
	.size	 fire_T_Ballz__FP7edict_sPfT1iiffi,.Lfe4-fire_T_Ballz__FP7edict_sPfT1iiffi
	.section	".rodata"
	.align 2
.LC31:
	.string	"self"
	.align 2
.LC32:
	.string	"no tballing while on a spree war!\n"
	.align 2
.LC33:
	.string	"You now have %i T_Ballz left\n"
	.align 3
.LC34:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC35:
	.long 0xc0000000
	.align 2
.LC36:
	.long 0x43200000
	.align 2
.LC37:
	.long 0x40200000
	.section	".text"
	.align 2
	.globl KOTS_Use_T_Ball
	.type	 KOTS_Use_T_Ball,@function
KOTS_Use_T_Ball:
	stwu 1,-128(1)
	mflr 0
	stmw 25,100(1)
	stw 0,132(1)
	lis 9,gi@ha
	mr 31,3
	la 30,gi@l(9)
	li 3,2
	lwz 9,160(30)
	mr 27,4
	mtlr 9
	blrl
	mr 28,3
	mr 3,31
	bl KOTSGetUser__FP7edict_s
	mr 29,3
	lis 4,.LC31@ha
	mr 3,28
	la 4,.LC31@l(4)
	bl strcmp
	lwz 9,480(31)
	subfic 0,3,0
	adde 25,0,3
	subfic 8,29,0
	adde 29,8,29
	addi 0,9,-1
	or 9,9,0
	srwi 9,9,31
	or. 0,9,29
	bc 4,2,.L72
	lwz 9,84(31)
	lwz 0,1860(9)
	cmpwi 0,0,24
	bc 4,1,.L75
	lwz 0,8(30)
	lis 5,.LC32@ha
	mr 3,31
	la 5,.LC32@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L72
.L75:
	lis 29,itemlist@ha
	lis 0,0x286b
	la 29,itemlist@l(29)
	ori 0,0,51739
	subf 29,29,27
	mullw 29,29,0
	lis 10,0x4330
	lis 8,.LC34@ha
	la 8,.LC34@l(8)
	addi 28,1,24
	srawi 29,29,2
	lfd 13,0(8)
	addi 26,1,40
	stw 29,736(9)
	lis 0,0x4100
	addi 27,1,56
	lwz 9,508(31)
	mr 4,28
	mr 5,26
	lwz 3,84(31)
	li 6,0
	addi 9,9,-8
	stw 0,12(1)
	xoris 9,9,0x8000
	stw 0,8(1)
	addi 3,3,3760
	stw 9,92(1)
	stw 10,88(1)
	lfd 0,88(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,16(1)
	bl AngleVectors
	lwz 3,84(31)
	addi 5,1,8
	mr 8,27
	mr 7,26
	mr 6,28
	addi 4,31,4
	bl P_ProjectSource
	lis 8,.LC35@ha
	lwz 4,84(31)
	mr 3,28
	la 8,.LC35@l(8)
	lfs 1,0(8)
	addi 4,4,3708
	bl VectorScale
	lwz 9,84(31)
	lis 0,0xbf80
	lis 8,.LC36@ha
	la 8,.LC36@l(8)
	li 6,160
	stw 0,3696(9)
	mr 5,28
	mr 3,31
	lis 9,.LC37@ha
	lfs 2,0(8)
	mr 4,27
	la 9,.LC37@l(9)
	mr 8,25
	lfs 1,0(9)
	li 7,600
	bl fire_T_Ballz__FP7edict_sPfT1iiffi
	li 5,1
	mr 4,27
	mr 3,31
	bl PlayerNoise
	lwz 10,84(31)
	slwi 29,29,2
	lis 5,.LC33@ha
	mr 3,31
	la 5,.LC33@l(5)
	addi 10,10,740
	li 4,2
	lwzx 9,10,29
	addi 9,9,-1
	stwx 9,10,29
	lwz 11,84(31)
	lwz 0,8(30)
	addi 11,11,740
	lwzx 6,11,29
	mtlr 0
	crxor 6,6,6
	blrl
.L72:
	lwz 0,132(1)
	mtlr 0
	lmw 25,100(1)
	la 1,128(1)
	blr
.Lfe5:
	.size	 KOTS_Use_T_Ball,.Lfe5-KOTS_Use_T_Ball
	.section	".rodata"
	.align 2
.LC38:
	.long 0x43200000
	.align 2
.LC39:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl KOTSRadiusTeleport
	.type	 KOTSRadiusTeleport,@function
KOTSRadiusTeleport:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC38@ha
	mr 4,3
	la 9,.LC38@l(9)
	mr 5,3
	lfs 1,0(9)
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 2,0(9)
	bl T_RadiusTeleport__FP7edict_sT0fT0f
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 KOTSRadiusTeleport,.Lfe6-KOTSRadiusTeleport
	.section	".rodata"
	.align 2
.LC40:
	.long 0x46fffe00
	.align 3
.LC41:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC42:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC43:
	.long 0x3f800000
	.align 2
.LC44:
	.long 0x0
	.section	".text"
	.align 2
	.type	 T_Ball_Touch__FP7edict_sT0P8cplane_sP10csurface_s,@function
T_Ball_Touch__FP7edict_sT0P8cplane_sP10csurface_s:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,256(31)
	cmpw 0,4,0
	bc 12,2,.L60
	cmpwi 0,6,0
	bc 12,2,.L62
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L62
	bl G_FreeEdict
	b .L60
.L62:
	lwz 0,512(4)
	cmpwi 0,0,0
	bc 4,2,.L63
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L64
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC41@ha
	lis 11,.LC40@ha
	la 10,.LC41@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC42@ha
	lfs 12,.LC40@l(11)
	la 10,.LC42@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L65
	lis 29,gi@ha
	lis 3,.LC20@ha
	la 29,gi@l(29)
	la 3,.LC20@l(3)
	b .L77
.L65:
	lis 29,gi@ha
	lis 3,.LC21@ha
	la 29,gi@l(29)
	la 3,.LC21@l(3)
	b .L77
.L64:
	lis 29,gi@ha
	lis 3,.LC22@ha
	la 29,gi@l(29)
	la 3,.LC22@l(3)
.L77:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC43@ha
	lis 10,.LC43@ha
	lis 11,.LC44@ha
	mr 5,3
	la 9,.LC43@l(9)
	la 10,.LC43@l(10)
	mtlr 0
	la 11,.LC44@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L60
.L63:
	mr 3,31
	bl T_Ballz_Explode__FP7edict_s
.L60:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 T_Ball_Touch__FP7edict_sT0P8cplane_sP10csurface_s,.Lfe7-T_Ball_Touch__FP7edict_sT0P8cplane_sP10csurface_s
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
