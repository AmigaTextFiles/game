	.file	"m_bird.c"
gcc2_compiled.:
	.globl bird_frames_stand
	.section	".data"
	.align 2
	.type	 bird_frames_stand,@object
bird_frames_stand:
	.long ai_stand
	.long 0x3f800000
	.long 0
	.long ai_stand
	.long 0x3f800000
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0xbf800000
	.long 0
	.long ai_stand
	.long 0xbf800000
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.size	 bird_frames_stand,96
	.globl bird_move_stand
	.align 2
	.type	 bird_move_stand,@object
	.size	 bird_move_stand,16
bird_move_stand:
	.long 0
	.long 7
	.long bird_frames_stand
	.long bird_stand
	.section	".rodata"
	.align 2
.LC0:
	.long 0x4cbebc20
	.align 2
.LC1:
	.long 0x43000000
	.align 2
.LC2:
	.long 0x0
	.section	".text"
	.align 2
	.globl bird_path_near
	.type	 bird_path_near,@function
bird_path_near:
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
	.size	 bird_path_near,.Lfe1-bird_path_near
	.section	".rodata"
	.align 2
.LC3:
	.long 0x40a00000
	.align 2
.LC4:
	.long 0xc0a00000
	.align 2
.LC5:
	.long 0x40800000
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
	.globl bird_ai_walk
	.type	 bird_ai_walk,@function
bird_ai_walk:
	stwu 1,-96(1)
	mflr 0
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 29,68(1)
	stw 0,100(1)
	mr 31,3
	fmr 30,1
	bl M_ChangeYaw
	mr 3,31
	bl path_near
	lfs 1,20(31)
	lfs 31,424(31)
	bl anglemod
	lis 9,.LC3@ha
	lis 11,.LC4@ha
	fsubs 31,31,1
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
	.size	 bird_ai_walk,.Lfe2-bird_ai_walk
	.globl bird_frames_walk
	.section	".data"
	.align 2
	.type	 bird_frames_walk,@object
bird_frames_walk:
	.long bird_ai_walk
	.long 0x40800000
	.long 0
	.long bird_ai_walk
	.long 0x40800000
	.long 0
	.long bird_ai_walk
	.long 0x40800000
	.long 0
	.long bird_ai_walk
	.long 0x40800000
	.long 0
	.long bird_ai_walk
	.long 0x40800000
	.long 0
	.long bird_ai_walk
	.long 0x40800000
	.long 0
	.long bird_ai_walk
	.long 0x40800000
	.long 0
	.long bird_ai_walk
	.long 0x40800000
	.long 0
	.size	 bird_frames_walk,96
	.globl bird_move_walk
	.align 2
	.type	 bird_move_walk,@object
	.size	 bird_move_walk,16
bird_move_walk:
	.long 0
	.long 7
	.long bird_frames_walk
	.long bird_walk
	.globl bird_frames_run
	.align 2
	.type	 bird_frames_run,@object
bird_frames_run:
	.long ai_run
	.long 0x40c00000
	.long 0
	.long ai_run
	.long 0x40c00000
	.long 0
	.long ai_run
	.long 0x40c00000
	.long 0
	.long ai_run
	.long 0x40c00000
	.long 0
	.long ai_run
	.long 0x40c00000
	.long 0
	.long ai_run
	.long 0x40c00000
	.long 0
	.long ai_run
	.long 0x40c00000
	.long 0
	.long ai_run
	.long 0x40c00000
	.long 0
	.size	 bird_frames_run,96
	.globl bird_move_run
	.align 2
	.type	 bird_move_run,@object
	.size	 bird_move_run,16
bird_move_run:
	.long 0
	.long 7
	.long bird_frames_run
	.long 0
	.globl bird_frames_death1
	.align 2
	.type	 bird_frames_death1,@object
bird_frames_death1:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 bird_frames_death1,84
	.globl bird_move_death1
	.align 2
	.type	 bird_move_death1,@object
	.size	 bird_move_death1,16
bird_move_death1:
	.long 15
	.long 21
	.long bird_frames_death1
	.long bird_dead
	.globl bird_frames_death2
	.align 2
	.type	 bird_frames_death2,@object
bird_frames_death2:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 bird_frames_death2,96
	.globl bird_move_death2
	.align 2
	.type	 bird_move_death2,@object
	.size	 bird_move_death2,16
bird_move_death2:
	.long 23
	.long 30
	.long bird_frames_death2
	.long bird_dead2
	.section	".rodata"
	.align 2
.LC11:
	.string	"misc/udeath.wav"
	.align 2
.LC12:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC13:
	.string	"models/objects/gibs/chest/tris.md2"
	.align 2
.LC14:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC15:
	.string	"models/monsters/crittera/tris.md2"
	.align 2
.LC16:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_bird
	.type	 SP_monster_bird,@function
SP_monster_bird:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 11,.LC16@ha
	lis 9,deathmatch@ha
	la 11,.LC16@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L49
	bl G_FreeEdict
	b .L48
.L49:
	li 29,5
	li 26,0
	li 0,-40
	lis 28,gi@ha
	stw 29,480(31)
	la 28,gi@l(28)
	stw 0,488(31)
	lis 3,.LC15@ha
	stw 29,484(31)
	la 3,.LC15@l(3)
	stw 26,60(31)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,bird_pain@ha
	lis 11,bird_die@ha
	lwz 4,776(31)
	lis 10,bird_stand@ha
	lis 8,bird_walk@ha
	stw 29,260(31)
	la 9,bird_pain@l(9)
	la 11,bird_die@l(11)
	stw 3,40(31)
	la 10,bird_stand@l(10)
	la 8,bird_walk@l(8)
	stw 9,452(31)
	lis 0,0x3f80
	stw 11,456(31)
	lis 6,bird_run@ha
	stw 10,788(31)
	lis 5,bird_attack@ha
	lis 7,bird_sight@ha
	stw 8,800(31)
	la 6,bird_run@l(6)
	la 5,bird_attack@l(5)
	stw 0,784(31)
	la 7,bird_sight@l(7)
	ori 4,4,256
	lis 9,0xc1c0
	lis 8,0x4200
	stw 6,804(31)
	li 11,2
	lis 10,0x4140
	stw 9,196(31)
	lis 27,0xc180
	lis 29,0x4180
	stw 8,208(31)
	li 0,50
	stw 11,248(31)
	mr 3,31
	stw 10,420(31)
	stw 5,812(31)
	stw 7,820(31)
	stw 4,776(31)
	stw 26,816(31)
	stw 27,192(31)
	stw 29,204(31)
	stw 0,400(31)
	stw 27,188(31)
	stw 29,200(31)
	stw 26,808(31)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	mr 3,31
	bl flymonster_start
.L48:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 SP_monster_bird,.Lfe3-SP_monster_bird
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
	.align 2
	.globl bird_stand
	.type	 bird_stand,@function
bird_stand:
	lis 9,bird_move_stand@ha
	la 9,bird_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe4:
	.size	 bird_stand,.Lfe4-bird_stand
	.align 2
	.globl bird_walk
	.type	 bird_walk,@function
bird_walk:
	lis 9,bird_move_walk@ha
	la 9,bird_move_walk@l(9)
	stw 9,772(3)
	blr
.Lfe5:
	.size	 bird_walk,.Lfe5-bird_walk
	.align 2
	.globl bird_run
	.type	 bird_run,@function
bird_run:
	lis 9,bird_move_run@ha
	la 9,bird_move_run@l(9)
	stw 9,772(3)
	blr
.Lfe6:
	.size	 bird_run,.Lfe6-bird_run
	.section	".rodata"
	.align 2
.LC17:
	.long 0x40c00000
	.section	".text"
	.align 2
	.globl bird_pain
	.type	 bird_pain,@function
bird_pain:
	lis 9,level+4@ha
	lfs 0,464(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bclr 12,0
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,464(3)
	blr
.Lfe7:
	.size	 bird_pain,.Lfe7-bird_pain
	.align 2
	.globl bird_attack
	.type	 bird_attack,@function
bird_attack:
	blr
.Lfe8:
	.size	 bird_attack,.Lfe8-bird_attack
	.align 2
	.globl bird_sight
	.type	 bird_sight,@function
bird_sight:
	blr
.Lfe9:
	.size	 bird_sight,.Lfe9-bird_sight
	.section	".rodata"
	.align 3
.LC18:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC19:
	.long 0x41700000
	.section	".text"
	.align 2
	.globl bird_dead
	.type	 bird_dead,@function
bird_dead:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 10,bird_deadthink@ha
	mr 9,3
	lis 5,0xc180
	lis 4,0x4180
	lis 0,0xc080
	li 8,0
	stw 5,192(9)
	la 10,bird_deadthink@l(10)
	li 7,7
	stw 8,208(9)
	lis 11,level@ha
	stw 0,196(9)
	lis 6,.LC18@ha
	stw 4,204(9)
	la 11,level@l(11)
	lis 8,.LC19@ha
	stw 7,260(9)
	la 8,.LC19@l(8)
	stw 10,436(9)
	stw 5,188(9)
	stw 4,200(9)
	lfs 0,4(11)
	lfd 13,.LC18@l(6)
	lfs 12,0(8)
	lis 8,gi+72@ha
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(9)
	lfs 13,4(11)
	fadds 13,13,12
	stfs 13,288(9)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 bird_dead,.Lfe10-bird_dead
	.align 2
	.globl bird_dead2
	.type	 bird_dead2,@function
bird_dead2:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	li 11,7
	lwz 0,184(9)
	li 10,0
	lis 8,gi+72@ha
	stw 11,260(9)
	ori 0,0,2
	stw 10,428(9)
	stw 0,184(9)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 bird_dead2,.Lfe11-bird_dead2
	.section	".rodata"
	.align 3
.LC20:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl bird_deadthink
	.type	 bird_deadthink,@function
bird_deadthink:
	lwz 0,552(3)
	cmpwi 0,0,0
	bc 4,2,.L38
	lis 9,level+4@ha
	lfs 0,288(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L38
	fmr 0,13
	lis 9,.LC20@ha
	lfd 13,.LC20@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.L38:
	lis 9,bird_move_death2@ha
	la 9,bird_move_death2@l(9)
	stw 9,772(3)
	blr
.Lfe12:
	.size	 bird_deadthink,.Lfe12-bird_deadthink
	.section	".rodata"
	.align 2
.LC21:
	.long 0x0
	.align 2
.LC22:
	.long 0x3f800000
	.align 2
.LC23:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl bird_die
	.type	 bird_die,@function
bird_die:
	stwu 1,-48(1)
	mflr 0
	stfd 29,24(1)
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 28,8(1)
	stw 0,52(1)
	mr 31,3
	mr 30,6
	lwz 9,480(31)
	lwz 0,488(31)
	cmpw 0,9,0
	bc 12,1,.L41
	lis 9,.LC21@ha
	lis 29,gi@ha
	la 9,.LC21@l(9)
	la 29,gi@l(29)
	lfs 31,0(9)
	lis 3,.LC11@ha
	lis 28,.LC12@ha
	lwz 11,36(29)
	lis 9,.LC22@ha
	la 3,.LC11@l(3)
	la 9,.LC22@l(9)
	lfs 29,0(9)
	mtlr 11
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 30,0(9)
	blrl
	lis 9,.LC22@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC22@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 2,0(9)
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 3,0(9)
	blrl
.L45:
	fadds 31,31,29
	mr 3,31
	la 4,.LC12@l(28)
	mr 5,30
	li 6,0
	bl ThrowGib
	fcmpu 0,31,30
	bc 12,0,.L45
	lis 4,.LC13@ha
	mr 3,31
	la 4,.LC13@l(4)
	mr 5,30
	li 6,0
	bl ThrowGib
	lis 4,.LC14@ha
	mr 5,30
	la 4,.LC14@l(4)
	mr 3,31
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,492(31)
	b .L40
.L41:
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L40
	lis 9,bird_move_death1@ha
	li 0,2
	la 9,bird_move_death1@l(9)
	li 11,1
	stw 0,492(31)
	stw 9,772(31)
	stw 11,512(31)
.L40:
	lwz 0,52(1)
	mtlr 0
	lmw 28,8(1)
	lfd 29,24(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 bird_die,.Lfe13-bird_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
