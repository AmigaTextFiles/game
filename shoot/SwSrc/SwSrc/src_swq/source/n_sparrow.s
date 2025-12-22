	.file	"n_sparrow.c"
gcc2_compiled.:
	.globl sparrow_frames_stand
	.section	".data"
	.align 2
	.type	 sparrow_frames_stand,@object
sparrow_frames_stand:
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.size	 sparrow_frames_stand,60
	.globl sparrow_move_stand
	.align 2
	.type	 sparrow_move_stand,@object
	.size	 sparrow_move_stand,16
sparrow_move_stand:
	.long 0
	.long 4
	.long sparrow_frames_stand
	.long sparrow_fly
	.globl sparrow_frames_turn
	.align 2
	.type	 sparrow_frames_turn,@object
sparrow_frames_turn:
	.long ai_move
	.long 0x41100000
	.long sparrow_turn
	.long ai_move
	.long 0x41100000
	.long sparrow_turn
	.long ai_move
	.long 0x41100000
	.long sparrow_turn
	.long ai_move
	.long 0x41100000
	.long sparrow_turn
	.long ai_move
	.long 0x41100000
	.long sparrow_turn_end
	.size	 sparrow_frames_turn,60
	.globl sparrow_move_turn1
	.align 2
	.type	 sparrow_move_turn1,@object
	.size	 sparrow_move_turn1,16
sparrow_move_turn1:
	.long 0
	.long 4
	.long sparrow_frames_turn
	.long sparrow_fly
	.globl sparrow_frames_fly
	.align 2
	.type	 sparrow_frames_fly,@object
sparrow_frames_fly:
	.long ai_stand
	.long 0x41100000
	.long 0
	.long ai_stand
	.long 0x41100000
	.long 0
	.long ai_stand
	.long 0x41100000
	.long 0
	.long ai_stand
	.long 0x41100000
	.long 0
	.long ai_stand
	.long 0x41100000
	.long 0
	.size	 sparrow_frames_fly,60
	.globl sparrow_move_fly
	.align 2
	.type	 sparrow_move_fly,@object
	.size	 sparrow_move_fly,16
sparrow_move_fly:
	.long 0
	.long 4
	.long sparrow_frames_fly
	.long sparrow_fly
	.section	".rodata"
	.align 2
.LC2:
	.long 0x46fffe00
	.align 3
.LC3:
	.long 0x3fee6666
	.long 0x66666666
	.align 3
.LC4:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC5:
	.long 0x43000000
	.align 2
.LC6:
	.long 0x3f800000
	.align 3
.LC7:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sparrow_fly
	.type	 sparrow_fly,@function
sparrow_fly:
	stwu 1,-144(1)
	mflr 0
	stfd 31,136(1)
	stmw 29,124(1)
	stw 0,148(1)
	mr 31,3
	bl rand
	addi 29,31,4
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,116(1)
	lis 10,.LC4@ha
	lis 11,.LC2@ha
	stw 0,112(1)
	la 10,.LC4@l(10)
	addi 4,1,72
	lfd 0,112(1)
	li 6,0
	addi 3,31,16
	lfd 12,0(10)
	li 5,0
	lfs 13,.LC2@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 31,0,13
	bl AngleVectors
	lis 9,.LC5@ha
	addi 4,1,72
	la 9,.LC5@l(9)
	addi 5,1,88
	lfs 1,0(9)
	mr 3,29
	bl VectorMA
	lis 9,gi+48@ha
	mr 4,29
	lwz 0,gi+48@l(9)
	addi 3,1,8
	addi 5,31,188
	li 9,-1
	addi 6,31,200
	addi 7,1,88
	mr 8,31
	mtlr 0
	blrl
	lis 9,.LC6@ha
	lfs 13,16(1)
	la 9,.LC6@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L21
	lis 9,.LC3@ha
	fmr 13,31
	lfd 0,.LC3@l(9)
	fcmpu 0,13,0
	bc 4,0,.L21
	lis 9,sparrow_move_fly@ha
	la 9,sparrow_move_fly@l(9)
	b .L28
.L21:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,116(1)
	lis 10,.LC4@ha
	lis 11,.LC2@ha
	la 10,.LC4@l(10)
	stw 0,112(1)
	lfd 13,0(10)
	lfd 0,112(1)
	lis 10,.LC7@ha
	lfs 12,.LC2@l(11)
	la 10,.LC7@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L25
	li 0,1
	lis 9,0x4170
	b .L29
.L25:
	li 0,2
	lis 9,0xc170
.L29:
	stw 0,532(31)
	stw 9,24(31)
	lis 9,sparrow_move_turn1@ha
	la 9,sparrow_move_turn1@l(9)
.L28:
	stw 9,772(31)
	lwz 0,148(1)
	mtlr 0
	lmw 29,124(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe1:
	.size	 sparrow_fly,.Lfe1-sparrow_fly
	.section	".rodata"
	.align 2
.LC8:
	.string	"models/npcs/bird/sparrow.md2"
	.align 2
.LC9:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_npc_sparrow
	.type	 SP_npc_sparrow,@function
SP_npc_sparrow:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 11,.LC9@ha
	lis 9,deathmatch@ha
	la 11,.LC9@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L35
	bl G_FreeEdict
	b .L34
.L35:
	li 28,0
	li 29,5
	li 0,-40
	lis 27,gi@ha
	stw 28,60(31)
	la 27,gi@l(27)
	stw 0,488(31)
	lis 3,.LC8@ha
	stw 29,480(31)
	la 3,.LC8@l(3)
	stw 29,484(31)
	lwz 9,32(27)
	mtlr 9
	blrl
	lis 9,sparrow_pain@ha
	lis 11,sparrow_die@ha
	lwz 6,776(31)
	la 9,sparrow_pain@l(9)
	la 11,sparrow_die@l(11)
	stw 3,40(31)
	lis 0,0x3f80
	stw 9,452(31)
	lis 8,sparrow_stand@ha
	stw 11,456(31)
	lis 10,sparrow_fly@ha
	lis 4,0xc100
	stw 0,784(31)
	la 10,sparrow_fly@l(10)
	lis 5,0x4100
	la 8,sparrow_stand@l(8)
	ori 6,6,256
	stw 4,192(31)
	lis 9,0xc080
	lis 7,0x4080
	stw 5,204(31)
	lis 11,0x4140
	li 0,50
	stw 9,196(31)
	stw 7,208(31)
	mr 3,31
	stw 11,420(31)
	stw 8,788(31)
	stw 10,804(31)
	stw 6,776(31)
	stw 4,188(31)
	stw 5,200(31)
	stw 10,800(31)
	stw 29,260(31)
	stw 0,400(31)
	stw 28,820(31)
	stw 28,248(31)
	stw 28,808(31)
	stw 28,812(31)
	stw 28,816(31)
	lwz 0,72(27)
	mtlr 0
	blrl
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	mr 3,31
	bl flymonster_start
.L34:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 SP_npc_sparrow,.Lfe2-SP_npc_sparrow
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
	.globl sparrow_stand
	.type	 sparrow_stand,@function
sparrow_stand:
	lis 9,sparrow_move_stand@ha
	la 9,sparrow_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe3:
	.size	 sparrow_stand,.Lfe3-sparrow_stand
	.section	".rodata"
	.align 2
.LC10:
	.long 0x46fffe00
	.align 3
.LC11:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC12:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sparrow_move_turn
	.type	 sparrow_move_turn,@function
sparrow_move_turn:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC11@ha
	lis 11,.LC10@ha
	la 10,.LC11@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC12@ha
	lfs 12,.LC10@l(11)
	la 10,.LC12@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L18
	li 0,1
	lis 9,0x4170
	b .L36
.L18:
	li 0,2
	lis 9,0xc170
.L36:
	stw 0,532(31)
	stw 9,24(31)
	lis 9,sparrow_move_turn1@ha
	la 9,sparrow_move_turn1@l(9)
	stw 9,772(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 sparrow_move_turn,.Lfe4-sparrow_move_turn
	.section	".rodata"
	.align 2
.LC13:
	.long 0x46fffe00
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC15:
	.long 0x40a00000
	.align 2
.LC16:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl sparrow_turn
	.type	 sparrow_turn,@function
sparrow_turn:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	bl rand
	rlwinm 3,3,0,17,31
	lwz 10,532(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC14@ha
	cmpwi 0,10,1
	la 11,.LC14@l(11)
	stw 0,16(1)
	lis 10,.LC15@ha
	lfd 12,0(11)
	la 10,.LC15@l(10)
	lfd 0,16(1)
	lis 11,.LC13@ha
	lfs 13,.LC13@l(11)
	lfs 11,0(10)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,13
	fmuls 12,0,11
	bc 4,2,.L15
	lis 11,.LC16@ha
	lfs 13,20(31)
	lis 0,0x41f0
	la 11,.LC16@l(11)
	stw 0,24(31)
	lfs 0,0(11)
	fadds 0,12,0
	fadds 13,13,0
	b .L37
.L15:
	lis 9,.LC16@ha
	lfs 13,20(31)
	lis 0,0xc1f0
	la 9,.LC16@l(9)
	stw 0,24(31)
	lfs 0,0(9)
	fadds 0,12,0
	fsubs 13,13,0
.L37:
	stfs 13,20(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 sparrow_turn,.Lfe5-sparrow_turn
	.section	".rodata"
	.align 2
.LC17:
	.long 0x43000000
	.align 2
.LC18:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl sparrow_turn_end
	.type	 sparrow_turn_end,@function
sparrow_turn_end:
	stwu 1,-128(1)
	mflr 0
	stmw 29,116(1)
	stw 0,132(1)
	mr 31,3
	addi 4,1,72
	li 6,0
	addi 3,31,16
	li 5,0
	addi 29,31,4
	bl AngleVectors
	lis 9,.LC17@ha
	addi 4,1,72
	la 9,.LC17@l(9)
	addi 5,1,88
	lfs 1,0(9)
	mr 3,29
	bl VectorMA
	lis 9,gi+48@ha
	mr 4,29
	lwz 0,gi+48@l(9)
	addi 3,1,8
	addi 5,31,188
	li 9,-1
	addi 6,31,200
	addi 7,1,88
	mr 8,31
	mtlr 0
	blrl
	lis 9,.LC18@ha
	lfs 13,16(1)
	la 9,.LC18@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L10
	li 9,0
	li 0,0
	stw 0,24(31)
	stw 9,532(31)
	b .L13
.L10:
	lis 9,sparrow_move_turn1@ha
	la 9,sparrow_move_turn1@l(9)
	stw 9,772(31)
.L13:
	lwz 0,132(1)
	mtlr 0
	lmw 29,116(1)
	la 1,128(1)
	blr
.Lfe6:
	.size	 sparrow_turn_end,.Lfe6-sparrow_turn_end
	.section	".rodata"
	.align 2
.LC19:
	.long 0x43000000
	.align 2
.LC20:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl sparrow_ai_check_move_forward
	.type	 sparrow_ai_check_move_forward,@function
sparrow_ai_check_move_forward:
	stwu 1,-128(1)
	mflr 0
	stmw 26,104(1)
	stw 0,132(1)
	mr 29,3
	addi 27,1,72
	li 6,0
	addi 3,29,16
	mr 4,27
	li 5,0
	bl AngleVectors
	addi 28,29,4
	lis 9,.LC19@ha
	addi 26,1,88
	la 9,.LC19@l(9)
	mr 4,27
	lfs 1,0(9)
	mr 3,28
	mr 5,26
	bl VectorMA
	lis 9,gi+48@ha
	addi 3,1,8
	lwz 0,gi+48@l(9)
	mr 4,28
	mr 7,26
	li 9,-1
	mr 8,29
	addi 5,29,188
	addi 6,29,200
	mtlr 0
	blrl
	lis 9,.LC20@ha
	lfs 13,16(1)
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fcmpu 7,13,0
	mfcr 3
	rlwinm 3,3,31,1
	lwz 0,132(1)
	mtlr 0
	lmw 26,104(1)
	la 1,128(1)
	blr
.Lfe7:
	.size	 sparrow_ai_check_move_forward,.Lfe7-sparrow_ai_check_move_forward
	.section	".rodata"
	.align 2
.LC21:
	.long 0x40c00000
	.section	".text"
	.align 2
	.globl sparrow_pain
	.type	 sparrow_pain,@function
sparrow_pain:
	lis 9,level+4@ha
	lfs 0,464(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bclr 12,0
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,464(3)
	blr
.Lfe8:
	.size	 sparrow_pain,.Lfe8-sparrow_pain
	.align 2
	.globl sparrow_die
	.type	 sparrow_die,@function
sparrow_die:
	lwz 0,492(3)
	cmpwi 0,0,2
	bclr 12,2
	li 9,2
	li 0,1
	stw 0,512(3)
	stw 9,492(3)
	blr
.Lfe9:
	.size	 sparrow_die,.Lfe9-sparrow_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
