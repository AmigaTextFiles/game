	.file	"g_objectives.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC1:
	.string	"Team %s has %i minutes before they win the battle.\n"
	.align 2
.LC2:
	.string	"Team %s has %i seconds before they win the battle.\n"
	.align 2
.LC3:
	.string	"%s/objectives/area_cap.wav"
	.align 2
.LC4:
	.string	"Objective %s taken by team %s!\n"
	.align 2
.LC5:
	.string	"Objective %s taken\n by team %s!\n"
	.align 3
.LC0:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC6:
	.long 0x0
	.align 2
.LC7:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl objective_area_think
	.type	 objective_area_think,@function
objective_area_think:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,level+4@ha
	lis 11,.LC0@ha
	lfs 0,level+4@l(9)
	mr 30,3
	li 31,0
	lfd 13,.LC0@l(11)
	li 29,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(30)
	b .L8
.L10:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L8
	mr 3,31
	bl IsValidPlayer
	cmpwi 0,3,0
	bc 12,2,.L8
	lwz 10,84(31)
	addi 11,29,1
	lwz 0,952(30)
	lwz 9,3448(10)
	lwz 28,84(9)
	xor 0,28,0
	addic 0,0,-1
	subfe 0,0,0
	andc 11,11,0
	and 0,29,0
	or 29,0,11
.L8:
	lfs 1,944(30)
	mr 3,31
	addi 4,30,4
	bl findradius
	mr. 31,3
	bc 4,2,.L10
	lwz 0,964(30)
	cmpw 0,29,0
	bc 12,0,.L15
	lwz 9,952(30)
	lis 11,.LC6@ha
	lis 8,team_list@ha
	la 11,.LC6@l(11)
	la 8,team_list@l(8)
	lwz 10,960(30)
	lfs 0,0(11)
	slwi 9,9,2
	slwi 6,28,2
	lwzx 11,9,8
	lwz 0,88(11)
	subf 0,10,0
	stw 0,88(11)
	lwzx 9,6,8
	lwz 7,956(30)
	lwz 0,84(9)
	stw 0,952(30)
	slwi 11,0,2
	lwzx 10,11,8
	lwz 0,88(10)
	add 0,0,7
	stw 0,88(10)
	lwz 9,952(30)
	slwi 9,9,2
	lwzx 11,9,8
	lfs 12,92(11)
	fcmpu 0,12,0
	bc 12,2,.L16
	lis 9,level+4@ha
	lfs 13,948(30)
	lfs 0,level+4@l(9)
	fadds 13,13,0
	fcmpu 0,12,13
	bc 4,1,.L18
	stfs 13,92(11)
	b .L18
.L16:
	lis 9,level+4@ha
	lfs 0,948(30)
	lfs 13,level+4@l(9)
	fadds 0,0,13
	stfs 0,92(11)
.L18:
	lwz 11,952(30)
	lis 9,team_list@ha
	lis 10,level+4@ha
	la 9,team_list@l(9)
	lfs 12,level+4@l(10)
	slwi 11,11,2
	lis 0,0x8888
	lwzx 5,11,9
	ori 0,0,34953
	lfs 0,92(5)
	fsubs 0,0,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 6,12(1)
	mulhw 0,6,0
	srawi 9,6,31
	add 0,0,6
	srawi 0,0,5
	subf. 0,9,0
	bc 4,1,.L19
	lis 9,gi@ha
	lis 4,.LC1@ha
	lwz 5,0(5)
	lwz 9,gi@l(9)
	la 4,.LC1@l(4)
	mr 6,0
	li 3,2
	mtlr 9
	crxor 6,6,6
	blrl
	b .L20
.L19:
	lis 9,gi@ha
	lis 4,.LC2@ha
	lwz 5,0(5)
	lwz 0,gi@l(9)
	la 4,.LC2@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L20:
	lwz 0,952(30)
	lis 9,team_list@ha
	lis 11,gi@ha
	la 29,team_list@l(9)
	lis 3,.LC3@ha
	slwi 0,0,2
	la 31,gi@l(11)
	lwzx 4,29,0
	la 3,.LC3@l(3)
	addi 4,4,100
	crxor 6,6,6
	bl va
	lwz 9,36(31)
	mtlr 9
	blrl
	lis 9,.LC7@ha
	lwz 11,16(31)
	mr 5,3
	la 9,.LC7@l(9)
	li 4,8
	lfs 1,0(9)
	mtlr 11
	mr 3,30
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 2,0(9)
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC6@ha
	lis 11,dedicated@ha
	la 9,.LC6@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L21
	lwz 0,952(30)
	lis 5,.LC4@ha
	li 3,0
	lwz 11,8(31)
	la 5,.LC4@l(5)
	li 4,2
	slwi 0,0,2
	lwz 6,940(30)
	lwzx 9,29,0
	mtlr 11
	lwz 7,0(9)
	crxor 6,6,6
	blrl
.L21:
	lwz 0,952(30)
	lis 3,.LC5@ha
	lwz 4,940(30)
	la 3,.LC5@l(3)
	slwi 0,0,2
	lwzx 9,29,0
	lwz 5,0(9)
	crxor 6,6,6
	bl centerprintall
.L15:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 objective_area_think,.Lfe1-objective_area_think
	.section	".rodata"
	.align 2
.LC8:
	.string	"Objective"
	.align 2
.LC9:
	.string	"\n\nobjective_area spawned belonging to team %i (%s) as \"%s\"\n"
	.align 2
.LC10:
	.string	"distance: %f\n"
	.align 2
.LC11:
	.string	"award: %i, loss: %i\n"
	.align 2
.LC12:
	.string	"required persons: %i\n"
	.align 2
.LC13:
	.string	"must hold for %i seconds.\n\n"
	.align 2
.LC14:
	.string	" mins: %s\n maxs: %s\n\n"
	.align 3
.LC15:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC16:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_objective_area
	.type	 SP_objective_area,@function
SP_objective_area:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,940(31)
	cmpwi 0,0,0
	bc 4,2,.L23
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	stw 9,940(31)
.L23:
	lis 9,.LC16@ha
	lfs 13,944(31)
	la 9,.LC16@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L24
	lis 0,0x42c8
	stw 0,944(31)
.L24:
	lwz 9,964(31)
	lis 0,0x42f0
	stw 0,948(31)
	cmpwi 0,9,0
	bc 4,2,.L25
	li 0,3
	stw 0,964(31)
.L25:
	lwz 4,952(31)
	lis 9,team_list@ha
	lis 28,gi@ha
	la 28,gi@l(28)
	la 9,team_list@l(9)
	lwz 6,940(31)
	slwi 0,4,2
	lwz 10,4(28)
	lis 3,.LC9@ha
	lwzx 11,9,0
	la 3,.LC9@l(3)
	addi 26,31,188
	mtlr 10
	addi 25,31,200
	lis 24,.LC14@ha
	lwz 5,0(11)
	li 27,0
	crxor 6,6,6
	blrl
	lfs 1,944(31)
	lis 3,.LC10@ha
	lwz 9,4(28)
	la 3,.LC10@l(3)
	mtlr 9
	creqv 6,6,6
	blrl
	lwz 9,4(28)
	lis 3,.LC11@ha
	lwz 5,960(31)
	la 3,.LC11@l(3)
	mtlr 9
	lwz 4,956(31)
	crxor 6,6,6
	blrl
	lwz 9,4(28)
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	lwz 4,964(31)
	mtlr 9
	crxor 6,6,6
	blrl
	lfs 0,948(31)
	lis 3,.LC13@ha
	lwz 9,4(28)
	la 3,.LC13@l(3)
	mtlr 9
	fctiwz 13,0
	stfd 13,8(1)
	lwz 4,12(1)
	crxor 6,6,6
	blrl
	mr 3,26
	bl vtos
	mr 29,3
	mr 3,25
	bl vtos
	lwz 9,4(28)
	mr 5,3
	mr 4,29
	la 3,.LC14@l(24)
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,objective_area_think@ha
	lis 10,level+4@ha
	lwz 4,272(31)
	la 9,objective_area_think@l(9)
	lis 11,.LC15@ha
	stw 9,440(31)
	mr 3,31
	lfs 0,level+4@l(10)
	lfd 13,.LC15@l(11)
	stw 27,264(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(31)
	lwz 9,44(28)
	mtlr 9
	blrl
	stw 27,248(31)
	mr 3,31
	lwz 9,72(28)
	mtlr 9
	blrl
	mr 3,26
	bl vtos
	mr 29,3
	mr 3,25
	bl vtos
	lwz 0,4(28)
	mr 5,3
	mr 4,29
	la 3,.LC14@l(24)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 SP_objective_area,.Lfe2-SP_objective_area
	.section	".rodata"
	.align 2
.LC17:
	.string	"%s/objectives/touch_cap.wav"
	.align 2
.LC18:
	.string	"%s taken by %s [%s]\n"
	.align 2
.LC19:
	.string	"%s taken by:\n\n%s\n%s"
	.align 2
.LC20:
	.long 0x3f800000
	.align 2
.LC21:
	.long 0x0
	.section	".text"
	.align 2
	.globl objective_touch
	.type	 objective_touch,@function
objective_touch:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 30,4
	mr 31,3
	mr 3,30
	bl IsValidPlayer
	cmpwi 0,3,0
	bc 12,2,.L26
	lwz 10,84(30)
	lwz 0,3464(10)
	cmpwi 0,0,8
	bc 4,2,.L27
	lis 9,.LC20@ha
	lis 11,invuln_medic@ha
	la 9,.LC20@l(9)
	lfs 13,0(9)
	lwz 9,invuln_medic@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L26
.L27:
	lwz 9,3448(10)
	lwz 11,952(31)
	lwz 0,84(9)
	cmpw 0,0,11
	bc 12,2,.L29
	lis 27,level@ha
	lwz 9,964(31)
	lwz 0,level@l(27)
	subf 0,9,0
	cmpwi 0,0,15
	bc 4,1,.L26
	cmpwi 0,11,1
	bc 12,1,.L31
	lis 9,team_list@ha
	slwi 11,11,2
	lwz 8,520(31)
	la 9,team_list@l(9)
	lwzx 10,11,9
	lwz 0,88(10)
	subf 0,8,0
	stw 0,88(10)
.L31:
	lwz 8,84(30)
	lis 9,team_list@ha
	lis 11,gi@ha
	la 28,team_list@l(9)
	la 29,gi@l(11)
	lwz 7,484(31)
	lwz 10,3448(8)
	lis 3,.LC17@ha
	la 3,.LC17@l(3)
	lwz 0,84(10)
	stw 0,952(31)
	slwi 9,0,2
	lwzx 11,9,28
	lwz 0,88(11)
	add 0,0,7
	stw 0,88(11)
	lwz 9,952(31)
	slwi 9,9,2
	lwzx 4,9,28
	addi 4,4,100
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC20@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC20@l(9)
	li 4,8
	lfs 1,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 2,0(9)
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC21@ha
	lis 11,dedicated@ha
	la 9,.LC21@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L32
	lwz 0,952(31)
	lis 5,.LC18@ha
	li 3,0
	lwz 7,84(30)
	la 5,.LC18@l(5)
	li 4,2
	slwi 0,0,2
	lwz 11,8(29)
	lwzx 9,28,0
	addi 7,7,700
	lwz 6,280(31)
	mtlr 11
	lwz 8,0(9)
	crxor 6,6,6
	blrl
.L32:
	lwz 0,952(31)
	lis 3,.LC19@ha
	lwz 5,84(30)
	la 3,.LC19@l(3)
	slwi 0,0,2
	lwz 4,280(31)
	lwzx 9,28,0
	addi 5,5,700
	lwz 6,0(9)
	crxor 6,6,6
	bl centerprintall
	lwz 0,level@l(27)
	b .L35
.L29:
	lwz 0,496(30)
	cmpwi 0,0,0
	bc 4,2,.L26
	lis 9,level@ha
	lwz 0,level@l(9)
.L35:
	stw 0,964(31)
.L26:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 objective_touch,.Lfe3-objective_touch
	.section	".rodata"
	.align 2
.LC23:
	.string	"models/objects/debris1/tris.md2"
	.align 2
.LC24:
	.string	"models/objects/debris2/tris.md2"
	.align 2
.LC25:
	.string	"%s destroyed by %s [%s]\n"
	.align 2
.LC26:
	.string	"%s destroyed by:\n\n%s\n%s"
	.align 2
.LC22:
	.long 0x46fffe00
	.align 2
.LC27:
	.long 0x3f000000
	.align 3
.LC28:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC29:
	.long 0x43160000
	.align 3
.LC30:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC31:
	.long 0x3f800000
	.align 2
.LC32:
	.long 0x40000000
	.align 2
.LC33:
	.long 0x0
	.section	".text"
	.align 2
	.globl func_explosive_objective_explode
	.type	 func_explosive_objective_explode,@function
func_explosive_objective_explode:
	stwu 1,-112(1)
	mflr 0
	stfd 29,88(1)
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 26,64(1)
	stw 0,116(1)
	mr 27,5
	mr 31,3
	lwz 9,84(27)
	mr 28,4
	cmpwi 0,9,0
	bc 12,2,.L37
	lwz 0,3464(9)
	cmpwi 0,0,0
	bc 12,2,.L37
	lis 9,.LC27@ha
	addi 30,1,40
	la 9,.LC27@l(9)
	addi 3,31,236
	lfs 1,0(9)
	mr 4,30
	bl VectorScale
	lfs 11,40(1)
	li 0,0
	lfs 12,212(31)
	lfs 10,44(1)
	lfs 13,216(31)
	fadds 12,12,11
	lfs 0,220(31)
	lfs 11,48(1)
	fadds 13,13,10
	lwz 11,520(31)
	stfs 12,4(31)
	fadds 0,0,11
	stw 0,516(31)
	cmpwi 0,11,0
	stfs 13,8(31)
	stfs 12,8(1)
	stfs 0,12(31)
	stfs 13,12(1)
	stfs 0,16(1)
	bc 12,2,.L40
	xoris 0,11,0x8000
	stw 0,60(1)
	lis 10,0x4330
	mr 3,31
	stw 10,56(1)
	addi 0,11,40
	mr 4,27
	mr 11,9
	lfd 1,56(1)
	xoris 0,0,0x8000
	lis 9,.LC28@ha
	stw 0,60(1)
	li 5,0
	la 9,.LC28@l(9)
	stw 10,56(1)
	li 6,25
	lfd 0,0(9)
	lfd 2,56(1)
	fsub 1,1,0
	fsub 2,2,0
	frsp 1,1
	frsp 2,2
	bl T_RadiusDamage
.L40:
	lfs 0,4(28)
	addi 29,31,380
	lfs 13,4(31)
	mr 3,29
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,380(31)
	lfs 0,8(28)
	fsubs 12,12,0
	stfs 12,384(31)
	lfs 0,12(28)
	fsubs 11,11,0
	stfs 11,388(31)
	bl VectorNormalize
	lis 9,.LC29@ha
	mr 3,29
	la 9,.LC29@l(9)
	mr 4,3
	lfs 1,0(9)
	bl VectorScale
	lis 9,.LC27@ha
	mr 3,30
	la 9,.LC27@l(9)
	mr 4,3
	lfs 1,0(9)
	bl VectorScale
	lwz 28,404(31)
	srawi 9,28,31
	xor 0,9,28
	subf 0,0,9
	srawi 0,0,31
	nor 9,0,0
	andi. 9,9,75
	and 0,28,0
	or 28,0,9
	cmpwi 0,28,99
	bc 4,1,.L42
	lis 0,0x51eb
	srawi 9,28,31
	ori 0,0,34079
	mulhw 0,28,0
	srawi 0,0,5
	subf 29,9,0
	cmpwi 7,29,9
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,29,0
	rlwinm 9,9,0,28,28
	or 29,0,9
	cmpwi 0,29,0
	addi 29,29,-1
	bc 12,2,.L42
	lis 9,.LC22@ha
	lis 11,.LC30@ha
	lfs 29,.LC22@l(9)
	la 11,.LC30@l(11)
	lis 30,0x4330
	lis 9,.LC28@ha
	lfd 31,0(11)
	lis 26,.LC23@ha
	la 9,.LC28@l(9)
	lfd 30,0(9)
.L46:
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(1)
	xoris 3,3,0x8000
	lfs 12,40(1)
	stw 3,60(1)
	stw 30,56(1)
	lfd 13,56(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,24(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,12(1)
	xoris 3,3,0x8000
	lfs 12,44(1)
	stw 3,60(1)
	stw 30,56(1)
	lfd 13,56(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,28(1)
	bl rand
	rlwinm 0,3,0,17,31
	lfs 11,16(1)
	xoris 0,0,0x8000
	lfs 12,48(1)
	lis 11,.LC31@ha
	stw 0,60(1)
	la 11,.LC31@l(11)
	mr 3,31
	stw 30,56(1)
	la 4,.LC23@l(26)
	addi 5,1,24
	lfd 13,56(1)
	lfs 1,0(11)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,32(1)
	bl ThrowDebris
	cmpwi 0,29,0
	addi 29,29,-1
	bc 4,2,.L46
.L42:
	lis 0,0x51eb
	srawi 9,28,31
	ori 0,0,34079
	mulhw 0,28,0
	srawi 0,0,3
	subf 29,9,0
	cmpwi 7,29,17
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,29,0
	rlwinm 9,9,0,27,27
	or 29,0,9
	cmpwi 0,29,0
	addi 29,29,-1
	bc 12,2,.L50
	lis 9,.LC22@ha
	lis 11,.LC30@ha
	lfs 29,.LC22@l(9)
	la 11,.LC30@l(11)
	lis 30,0x4330
	lis 9,.LC28@ha
	lfd 31,0(11)
	lis 28,.LC24@ha
	la 9,.LC28@l(9)
	lfd 30,0(9)
.L51:
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(1)
	xoris 3,3,0x8000
	lfs 12,40(1)
	stw 3,60(1)
	stw 30,56(1)
	lfd 13,56(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,24(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,12(1)
	xoris 3,3,0x8000
	lfs 12,44(1)
	stw 3,60(1)
	stw 30,56(1)
	lfd 13,56(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,28(1)
	bl rand
	rlwinm 0,3,0,17,31
	lfs 11,16(1)
	xoris 0,0,0x8000
	lfs 12,48(1)
	lis 11,.LC32@ha
	stw 0,60(1)
	la 11,.LC32@l(11)
	mr 3,31
	stw 30,56(1)
	la 4,.LC24@l(28)
	addi 5,1,24
	lfd 13,56(1)
	lfs 1,0(11)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,32(1)
	bl ThrowDebris
	cmpwi 0,29,0
	addi 29,29,-1
	bc 4,2,.L51
.L50:
	mr 3,31
	mr 4,27
	bl G_UseTargets
	lwz 10,952(31)
	cmpwi 0,10,99
	bc 12,2,.L53
	lis 9,team_list@ha
	slwi 10,10,2
	lwz 8,960(31)
	la 9,team_list@l(9)
	lwzx 11,10,9
	lwz 0,88(11)
	subf 0,8,0
	stw 0,88(11)
	lwz 9,952(31)
	subfic 0,9,0
	adde 10,0,9
	b .L54
.L53:
	li 10,99
.L54:
	lwz 9,84(27)
	lwz 0,952(31)
	lwz 11,3448(9)
	lwz 11,84(11)
	cmpw 0,0,11
	bc 12,2,.L55
	lis 9,team_list@ha
	slwi 10,11,2
	b .L61
.L55:
	cmpwi 0,10,99
	bc 12,2,.L56
	lis 9,team_list@ha
	slwi 10,10,2
.L61:
	lwz 8,956(31)
	la 9,team_list@l(9)
	lwzx 11,10,9
	lwz 0,88(11)
	add 0,0,8
	stw 0,88(11)
.L56:
	lis 9,.LC33@ha
	lis 11,dedicated@ha
	la 9,.LC33@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L58
	lwz 7,84(27)
	lis 9,gi+8@ha
	lis 11,team_list@ha
	lwz 30,gi+8@l(9)
	la 11,team_list@l(11)
	lis 5,.LC25@ha
	lwz 10,3448(7)
	la 5,.LC25@l(5)
	li 3,0
	addi 7,7,700
	li 4,2
	lwz 6,940(31)
	mtlr 30
	lwz 0,84(10)
	slwi 0,0,2
	lwzx 9,11,0
	lwz 8,0(9)
	crxor 6,6,6
	blrl
.L58:
	lwz 5,84(27)
	lis 28,team_list@ha
	lis 3,.LC26@ha
	la 28,team_list@l(28)
	lwz 4,940(31)
	la 3,.LC26@l(3)
	lwz 9,3448(5)
	addi 5,5,700
	lwz 0,84(9)
	slwi 0,0,2
	lwzx 9,28,0
	lwz 6,0(9)
	crxor 6,6,6
	bl centerprintall
	lwz 0,952(31)
	lis 29,gi@ha
	lis 3,.LC17@ha
	la 29,gi@l(29)
	la 3,.LC17@l(3)
	slwi 0,0,2
	lwzx 4,28,0
	addi 4,4,100
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC31@ha
	lwz 0,16(29)
	lis 11,.LC33@ha
	la 9,.LC31@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC33@l(11)
	mtlr 0
	li 4,8
	lis 9,.LC33@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC33@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,520(31)
	cmpwi 0,0,0
	bc 12,2,.L59
	mr 3,31
	bl BecomeExplosion1
	b .L37
.L59:
	mr 3,31
	bl G_FreeEdict
.L37:
	lwz 0,116(1)
	mtlr 0
	lmw 26,64(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe4:
	.size	 func_explosive_objective_explode,.Lfe4-func_explosive_objective_explode
	.align 2
	.globl SP_func_explosive_objective
	.type	 SP_func_explosive_objective,@function
SP_func_explosive_objective:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 0,2
	lis 29,gi@ha
	stw 0,264(31)
	lis 3,.LC23@ha
	la 29,gi@l(29)
	la 3,.LC23@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC24@ha
	la 3,.LC24@l(3)
	mtlr 9
	blrl
	lwz 0,44(29)
	mr 3,31
	lwz 4,272(31)
	mtlr 0
	blrl
	lwz 0,288(31)
	andi. 9,0,1
	bc 12,2,.L65
	lwz 0,184(31)
	lis 9,func_explosive_objective_spawn@ha
	li 11,0
	la 9,func_explosive_objective_spawn@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,452(31)
	stw 0,184(31)
	b .L66
.L65:
	lwz 9,304(31)
	li 0,3
	stw 0,248(31)
	cmpwi 0,9,0
	bc 12,2,.L66
	lis 9,func_explosive_objective_use@ha
	la 9,func_explosive_objective_use@l(9)
	stw 9,452(31)
.L66:
	lwz 0,288(31)
	andi. 9,0,2
	bc 12,2,.L68
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L68:
	lwz 0,288(31)
	andi. 9,0,4
	bc 12,2,.L69
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L69:
	lwz 0,452(31)
	lis 9,func_explosive_objective_use@ha
	la 9,func_explosive_objective_use@l(9)
	cmpw 0,0,9
	bc 12,2,.L70
	lwz 0,484(31)
	cmpwi 0,0,0
	bc 4,2,.L71
	li 0,500
	stw 0,484(31)
.L71:
	lis 9,func_explosive_objective_explode@ha
	li 0,1
	la 9,func_explosive_objective_explode@l(9)
	stw 0,516(31)
	stw 9,460(31)
.L70:
	lwz 0,940(31)
	cmpwi 0,0,0
	bc 4,2,.L72
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	stw 9,940(31)
.L72:
	lwz 0,956(31)
	cmpwi 0,0,0
	bc 4,2,.L73
	li 0,5
	stw 0,956(31)
.L73:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 SP_func_explosive_objective,.Lfe5-SP_func_explosive_objective
	.section	".rodata"
	.align 2
.LC34:
	.string	"dday/pics/objectives/"
	.align 2
.LC35:
	.string	".pcx"
	.align 2
.LC36:
	.string	"Loading map objective pic %s..."
	.align 2
.LC37:
	.string	"r"
	.align 2
.LC38:
	.string	"done.\n"
	.align 2
.LC39:
	.string	"error.\n"
	.comm	is_silenced,1,1
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.section	".text"
	.align 2
	.globl SP_objective_touch
	.type	 SP_objective_touch,@function
SP_objective_touch:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,objective_touch@ha
	mr 28,3
	la 9,objective_touch@l(9)
	li 0,0
	lwz 4,272(28)
	li 11,1
	lis 29,gi@ha
	stw 0,264(28)
	la 29,gi@l(29)
	stw 9,448(28)
	stw 11,248(28)
	lwz 9,44(29)
	mtlr 9
	blrl
	lwz 0,72(29)
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 SP_objective_touch,.Lfe6-SP_objective_touch
	.align 2
	.globl func_explosive_objective_use
	.type	 func_explosive_objective_use,@function
func_explosive_objective_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 5,4
	lis 7,vec3_origin@ha
	lwz 6,484(3)
	la 7,vec3_origin@l(7)
	mr 4,3
	bl func_explosive_objective_explode
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 func_explosive_objective_use,.Lfe7-func_explosive_objective_use
	.align 2
	.globl func_explosive_objective_spawn
	.type	 func_explosive_objective_spawn,@function
func_explosive_objective_spawn:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	li 9,3
	lwz 0,184(29)
	li 11,0
	stw 9,248(29)
	rlwinm 0,0,0,0,30
	stw 11,452(29)
	stw 0,184(29)
	bl KillBox
	lis 9,gi+72@ha
	mr 3,29
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 func_explosive_objective_spawn,.Lfe8-func_explosive_objective_spawn
	.align 2
	.globl GetMapObjective
	.type	 GetMapObjective,@function
GetMapObjective:
	stwu 1,-128(1)
	mflr 0
	stmw 30,120(1)
	stw 0,132(1)
	lis 9,.LC34@ha
	addi 31,1,8
	lwz 7,.LC34@l(9)
	lis 4,level+72@ha
	mr 3,31
	la 9,.LC34@l(9)
	la 4,level+72@l(4)
	lhz 6,20(9)
	lwz 0,4(9)
	lwz 11,8(9)
	lwz 10,12(9)
	lwz 8,16(9)
	stw 7,8(1)
	stw 0,4(31)
	stw 11,8(31)
	stw 10,12(31)
	stw 8,16(31)
	sth 6,20(31)
	bl strcat
	lis 4,.LC35@ha
	mr 3,31
	la 4,.LC35@l(4)
	bl strcat
	lis 9,gi@ha
	lis 3,.LC36@ha
	la 30,gi@l(9)
	mr 4,31
	lwz 9,4(30)
	la 3,.LC36@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	lis 4,.LC37@ha
	mr 3,31
	la 4,.LC37@l(4)
	bl fopen
	mr. 3,3
	bc 12,2,.L75
	bl fclose
	lwz 0,4(30)
	lis 3,.LC38@ha
	lis 9,level+200@ha
	la 3,.LC38@l(3)
	stw 31,level+200@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L76
.L75:
	lwz 0,4(30)
	lis 3,.LC39@ha
	la 3,.LC39@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L76:
	lwz 0,132(1)
	mtlr 0
	lmw 30,120(1)
	la 1,128(1)
	blr
.Lfe9:
	.size	 GetMapObjective,.Lfe9-GetMapObjective
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
