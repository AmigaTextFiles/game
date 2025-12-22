	.file	"m_vehicle.c"
gcc2_compiled.:
	.globl skimmer_frames_stand
	.section	".data"
	.align 2
	.type	 skimmer_frames_stand,@object
skimmer_frames_stand:
	.long ai_stand
	.long 0x0
	.long 0
	.size	 skimmer_frames_stand,12
	.globl skimmer_move_stand
	.align 2
	.type	 skimmer_move_stand,@object
	.size	 skimmer_move_stand,16
skimmer_move_stand:
	.long 0
	.long 0
	.long skimmer_frames_stand
	.long skimmer_stand
	.section	".rodata"
	.align 2
.LC0:
	.long 0x4cbebc20
	.align 2
.LC1:
	.long 0x43420000
	.align 2
.LC2:
	.long 0x0
	.section	".text"
	.align 2
	.globl path_near
	.type	 path_near,@function
path_near:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 9,412(31)
	addi 3,1,8
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,1,.L7
	lwz 30,416(31)
	stw 30,1008(31)
	lwz 0,312(30)
	cmpwi 0,0,0
	bc 12,2,.L9
	lwz 29,296(30)
	mr 3,30
	mr 4,31
	stw 0,296(30)
	bl G_UseTargets
	stw 29,296(30)
.L9:
	lwz 3,296(30)
	cmpwi 0,3,0
	bc 12,2,.L10
	bl G_PickTarget
	mr 9,3
	b .L11
.L10:
	li 9,0
.L11:
	cmpwi 0,9,0
	bc 12,2,.L12
	lwz 0,284(9)
	andi. 11,0,1
	bc 12,2,.L12
	lfs 11,4(9)
	lfs 10,196(31)
	stfs 11,8(1)
	lfs 12,8(9)
	stfs 12,12(1)
	lfs 0,12(9)
	stfs 0,16(1)
	lfs 13,196(9)
	stfs 11,4(31)
	stfs 12,8(31)
	fadds 0,0,13
	fsubs 0,0,10
	stfs 0,12(31)
	stfs 0,16(1)
	lwz 3,296(9)
	bl G_PickTarget
	mr 9,3
.L12:
	stw 9,416(31)
	addi 3,1,8
	stw 9,412(31)
	lfs 13,4(9)
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	bl vectoyaw
	lis 9,.LC2@ha
	stfs 1,424(31)
	la 9,.LC2@l(9)
	lfs 13,592(30)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L13
	lis 9,level+4@ha
	lwz 11,788(31)
	mr 3,31
	lfs 0,level+4@l(9)
	mtlr 11
	b .L16
.L13:
	lwz 0,416(31)
	cmpwi 0,0,0
	bc 4,2,.L14
	lis 9,level+4@ha
	lis 11,.LC0@ha
	lwz 10,788(31)
	lfs 0,level+4@l(9)
	mr 3,31
	lfs 13,.LC0@l(11)
	mtlr 10
.L16:
	fadds 0,0,13
	stfs 0,828(31)
	blrl
	b .L7
.L14:
	lwz 9,412(31)
	addi 3,1,8
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	bl vectoyaw
	stfs 1,424(31)
.L7:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 path_near,.Lfe1-path_near
	.section	".rodata"
	.align 2
.LC3:
	.long 0x40a00000
	.align 2
.LC4:
	.long 0xc0a00000
	.align 2
.LC5:
	.long 0x41a00000
	.align 2
.LC6:
	.long 0x42b40000
	.align 2
.LC7:
	.long 0x40e00000
	.align 2
.LC8:
	.long 0xc0e00000
	.section	".text"
	.align 2
	.globl skimmer_ai_walk
	.type	 skimmer_ai_walk,@function
skimmer_ai_walk:
	stwu 1,-96(1)
	mflr 0
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 29,68(1)
	stw 0,100(1)
	mr 31,3
	fmr 30,1
	bl path_near
	lwz 9,412(31)
	addi 3,1,8
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	bl vectoyaw
	fmr 31,1
	lfs 1,20(31)
	stfs 31,424(31)
	bl anglemod
	fsubs 31,31,1
	mr 3,31
	bl M_ChangeYaw
	lis 9,.LC3@ha
	lis 11,.LC4@ha
	la 9,.LC3@l(9)
	la 11,.LC4@l(11)
	lfs 0,0(9)
	lfs 13,0(11)
	fcmpu 7,31,0
	fcmpu 6,31,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 11,9,0
	bc 12,2,.L18
	fmr 1,30
	mr 3,31
	bl ai_walk
	b .L19
.L18:
	lwz 9,1008(31)
	addi 29,1,24
	addi 3,1,8
	lfs 0,4(31)
	mr 4,29
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorNormalize2
	lis 9,.LC5@ha
	mr 4,29
	la 9,.LC5@l(9)
	addi 3,31,4
	lfs 1,0(9)
	addi 5,1,40
	bl VectorMA
	lfs 0,40(1)
	lfs 13,44(1)
	lfs 12,12(31)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,48(1)
.L19:
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 12,1,.L28
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 4,0,.L22
.L28:
	lis 11,.LC6@ha
	lfs 13,24(31)
	la 11,.LC6@l(11)
	lfs 0,0(11)
	fdivs 0,0,31
	fsubs 13,13,0
	stfs 13,24(31)
	b .L21
.L22:
	lis 9,.LC7@ha
	lfs 13,24(31)
	la 9,.LC7@l(9)
	lfs 12,0(9)
	fcmpu 0,13,12
	bc 4,1,.L24
	fsubs 0,13,12
	b .L29
.L24:
	lis 11,.LC8@ha
	la 11,.LC8@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L26
	fadds 0,13,12
	b .L29
.L26:
	fsubs 0,13,13
.L29:
	stfs 0,24(31)
.L21:
	lwz 0,100(1)
	mtlr 0
	lmw 29,68(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe2:
	.size	 skimmer_ai_walk,.Lfe2-skimmer_ai_walk
	.globl skimmer_frames_walk
	.section	".data"
	.align 2
	.type	 skimmer_frames_walk,@object
skimmer_frames_walk:
	.long skimmer_ai_walk
	.long 0x42480000
	.long Check_Collide
	.long skimmer_ai_walk
	.long 0x42480000
	.long Check_Collide
	.long skimmer_ai_walk
	.long 0x42480000
	.long Check_Collide
	.long skimmer_ai_walk
	.long 0x42480000
	.long Check_Collide
	.long skimmer_ai_walk
	.long 0x42480000
	.long Check_Collide
	.size	 skimmer_frames_walk,60
	.globl skimmer_move_walk
	.align 2
	.type	 skimmer_move_walk,@object
	.size	 skimmer_move_walk,16
skimmer_move_walk:
	.long 0
	.long 4
	.long skimmer_frames_walk
	.long 0
	.globl skimmer_frames_run
	.align 2
	.type	 skimmer_frames_run,@object
skimmer_frames_run:
	.long skimmer_ai_walk
	.long 0x42480000
	.long 0
	.long skimmer_ai_walk
	.long 0x42480000
	.long 0
	.long skimmer_ai_walk
	.long 0x42480000
	.long 0
	.long skimmer_ai_walk
	.long 0x42480000
	.long 0
	.long skimmer_ai_walk
	.long 0x42480000
	.long 0
	.size	 skimmer_frames_run,60
	.globl skimmer_move_run
	.align 2
	.type	 skimmer_move_run,@object
	.size	 skimmer_move_run,16
skimmer_move_run:
	.long 0
	.long 4
	.long skimmer_frames_run
	.long 0
	.comm	node_count,2,2
	.comm	path_not_time_yet,4,4
	.comm	conversation_content,7760,4
	.comm	highlighted,4,4
	.comm	yeah_you,4,4
	.comm	its_me,4,4
	.comm	holdthephone,4,4
	.comm	NoTouch,4,4
	.comm	showingit,4,4
	.comm	path_time,4,4
	.comm	print_time,4,4
	.section	".text"
	.align 2
	.globl skimmer_stand
	.type	 skimmer_stand,@function
skimmer_stand:
	lis 9,skimmer_move_stand@ha
	la 9,skimmer_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe3:
	.size	 skimmer_stand,.Lfe3-skimmer_stand
	.align 2
	.globl skimmer_walk
	.type	 skimmer_walk,@function
skimmer_walk:
	lis 9,skimmer_move_walk@ha
	la 9,skimmer_move_walk@l(9)
	stw 9,772(3)
	blr
.Lfe4:
	.size	 skimmer_walk,.Lfe4-skimmer_walk
	.align 2
	.globl skimmer_run
	.type	 skimmer_run,@function
skimmer_run:
	lis 9,skimmer_move_run@ha
	la 9,skimmer_move_run@l(9)
	stw 9,772(3)
	blr
.Lfe5:
	.size	 skimmer_run,.Lfe5-skimmer_run
	.section	".rodata"
	.align 2
.LC9:
	.long 0x42000000
	.align 2
.LC10:
	.long 0x41800000
	.align 2
.LC11:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Check_Collide
	.type	 Check_Collide,@function
Check_Collide:
	stwu 1,-160(1)
	mflr 0
	stmw 28,144(1)
	stw 0,164(1)
	addi 30,1,48
	mr 31,3
	li 6,0
	addi 3,31,16
	mr 4,30
	li 5,0
	bl AngleVectors
	addi 29,31,4
	lis 9,.LC9@ha
	addi 28,1,32
	la 9,.LC9@l(9)
	mr 3,29
	lfs 1,0(9)
	mr 4,30
	mr 5,28
	bl VectorMA
	lis 9,.LC10@ha
	addi 5,1,16
	la 9,.LC10@l(9)
	mr 3,29
	lfs 1,0(9)
	mr 4,30
	bl VectorMA
	lis 9,gi+48@ha
	mr 7,28
	lwz 0,gi+48@l(9)
	addi 3,1,64
	addi 4,1,16
	li 9,-1
	addi 5,31,188
	addi 6,31,200
	mr 8,31
	mtlr 0
	blrl
	lis 9,.LC11@ha
	lfs 13,72(1)
	la 9,.LC11@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L31
	lwz 0,116(1)
	cmpwi 0,0,0
	bc 12,2,.L31
	addi 29,1,128
	mr 3,30
	mr 4,29
	bl VectorNormalize2
	li 0,1
	mr 4,31
	lwz 3,116(1)
	stw 0,12(1)
	mr 6,30
	mr 8,29
	stw 0,8(1)
	mr 5,4
	addi 7,1,76
	li 9,30
	li 10,1000
	bl T_Damage
.L31:
	lwz 0,164(1)
	mtlr 0
	lmw 28,144(1)
	la 1,160(1)
	blr
.Lfe6:
	.size	 Check_Collide,.Lfe6-Check_Collide
	.align 2
	.globl skimmer_pain
	.type	 skimmer_pain,@function
skimmer_pain:
	blr
.Lfe7:
	.size	 skimmer_pain,.Lfe7-skimmer_pain
	.align 2
	.globl skimmer_attack
	.type	 skimmer_attack,@function
skimmer_attack:
	blr
.Lfe8:
	.size	 skimmer_attack,.Lfe8-skimmer_attack
	.align 2
	.globl skimmer_die
	.type	 skimmer_die,@function
skimmer_die:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl BecomeExplosion1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 skimmer_die,.Lfe9-skimmer_die
	.align 2
	.globl SP_misc_skimmer
	.type	 SP_misc_skimmer,@function
SP_misc_skimmer:
	blr
.Lfe10:
	.size	 SP_misc_skimmer,.Lfe10-SP_misc_skimmer
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
