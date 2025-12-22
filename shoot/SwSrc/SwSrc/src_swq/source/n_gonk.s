	.file	"n_gonk.c"
gcc2_compiled.:
	.globl gonk_frames_stand
	.section	".data"
	.align 2
	.type	 gonk_frames_stand,@object
gonk_frames_stand:
	.long ai_stand
	.long 0x0
	.long gonk_gonk
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long gonk_check_walk
	.size	 gonk_frames_stand,36
	.globl gonk_move_stand
	.align 2
	.type	 gonk_move_stand,@object
	.size	 gonk_move_stand,16
gonk_move_stand:
	.long 12
	.long 14
	.long gonk_frames_stand
	.long 0
	.globl gonk_frames_turn
	.align 2
	.type	 gonk_frames_turn,@object
gonk_frames_turn:
	.long ai_move
	.long 0x3dcccccd
	.long gonk_turn
	.long ai_move
	.long 0x3ecccccd
	.long gonk_turn
	.long ai_move
	.long 0x3e99999a
	.long gonk_turn
	.long ai_move
	.long 0x3ecccccd
	.long gonk_turn
	.long ai_move
	.long 0x3e99999a
	.long gonk_turn
	.long ai_move
	.long 0x3e99999a
	.long gonk_turn
	.long ai_move
	.long 0x0
	.long gonk_turn
	.long ai_move
	.long 0x3ecccccd
	.long gonk_turn
	.long ai_move
	.long 0x3e99999a
	.long gonk_turn
	.long ai_move
	.long 0x3ecccccd
	.long gonk_turn
	.long ai_move
	.long 0x3e99999a
	.long gonk_turn
	.long ai_move
	.long 0x3ecccccd
	.long gonk_turn
	.size	 gonk_frames_turn,144
	.globl gonk_move_turn1
	.align 2
	.type	 gonk_move_turn1,@object
	.size	 gonk_move_turn1,16
gonk_move_turn1:
	.long 0
	.long 11
	.long gonk_frames_turn
	.long gonk_walk
	.globl gonk_frames_walk
	.align 2
	.type	 gonk_frames_walk,@object
gonk_frames_walk:
	.long ai_move
	.long 0x3dcccccd
	.long 0
	.long ai_move
	.long 0x3ecccccd
	.long 0
	.long ai_move
	.long 0x3e99999a
	.long 0
	.long ai_move
	.long 0x3ecccccd
	.long 0
	.long ai_move
	.long 0x3e99999a
	.long 0
	.long ai_move
	.long 0x3e99999a
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x3ecccccd
	.long 0
	.long ai_move
	.long 0x3e99999a
	.long 0
	.long ai_move
	.long 0x3ecccccd
	.long 0
	.long ai_move
	.long 0x3e99999a
	.long 0
	.long ai_move
	.long 0x3ecccccd
	.long 0
	.size	 gonk_frames_walk,144
	.globl gonk_move_walk
	.align 2
	.type	 gonk_move_walk,@object
	.size	 gonk_move_walk,16
gonk_move_walk:
	.long 0
	.long 11
	.long gonk_frames_walk
	.long gonk_walk
	.section	".rodata"
	.align 2
.LC6:
	.long 0x46fffe00
	.align 3
.LC7:
	.long 0x3fee6666
	.long 0x66666666
	.align 3
.LC8:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC9:
	.long 0x41c00000
	.align 2
.LC10:
	.long 0x3f800000
	.align 3
.LC11:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl gonk_walk
	.type	 gonk_walk,@function
gonk_walk:
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
	lis 10,.LC8@ha
	lis 11,.LC6@ha
	stw 0,112(1)
	la 10,.LC8@l(10)
	addi 4,1,72
	lfd 0,112(1)
	li 6,0
	addi 3,31,16
	lfd 12,0(10)
	li 5,0
	lfs 13,.LC6@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 31,0,13
	bl AngleVectors
	lis 9,.LC9@ha
	addi 4,1,72
	la 9,.LC9@l(9)
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
	lis 9,.LC10@ha
	lfs 13,16(1)
	la 9,.LC10@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L21
	lis 9,.LC7@ha
	fmr 13,31
	lfd 0,.LC7@l(9)
	fcmpu 0,13,0
	bc 4,0,.L21
	lis 9,gonk_move_walk@ha
	la 9,gonk_move_walk@l(9)
	b .L28
.L21:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,116(1)
	lis 10,.LC8@ha
	lis 11,.LC6@ha
	la 10,.LC8@l(10)
	stw 0,112(1)
	lfd 13,0(10)
	lfd 0,112(1)
	lis 10,.LC11@ha
	lfs 12,.LC6@l(11)
	la 10,.LC11@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	li 0,2
	bc 4,1,.L25
	li 0,1
.L25:
	stw 0,532(31)
	lis 9,gonk_move_turn1@ha
	la 9,gonk_move_turn1@l(9)
.L28:
	stw 9,772(31)
	lwz 0,148(1)
	mtlr 0
	lmw 29,124(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe1:
	.size	 gonk_walk,.Lfe1-gonk_walk
	.section	".rodata"
	.align 2
.LC12:
	.long 0x46fffe00
	.align 3
.LC13:
	.long 0x3fee6666
	.long 0x66666666
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC15:
	.long 0x41c00000
	.align 2
.LC16:
	.long 0x3f800000
	.align 3
.LC17:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl gonk_run
	.type	 gonk_run,@function
gonk_run:
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
	lis 10,.LC14@ha
	lis 11,.LC12@ha
	stw 0,112(1)
	la 10,.LC14@l(10)
	addi 4,1,72
	lfd 0,112(1)
	li 6,0
	addi 3,31,16
	lfd 12,0(10)
	li 5,0
	lfs 13,.LC12@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 31,0,13
	bl AngleVectors
	lis 9,.LC15@ha
	addi 4,1,72
	la 9,.LC15@l(9)
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
	lis 9,.LC16@ha
	lfs 13,16(1)
	la 9,.LC16@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L31
	lis 9,.LC13@ha
	fmr 13,31
	lfd 0,.LC13@l(9)
	fcmpu 0,13,0
	bc 4,0,.L31
	lis 9,gonk_move_walk@ha
	la 9,gonk_move_walk@l(9)
	b .L38
.L31:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,116(1)
	lis 10,.LC14@ha
	lis 11,.LC12@ha
	la 10,.LC14@l(10)
	stw 0,112(1)
	lfd 13,0(10)
	lfd 0,112(1)
	lis 10,.LC17@ha
	lfs 12,.LC12@l(11)
	la 10,.LC17@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	li 0,2
	bc 4,1,.L35
	li 0,1
.L35:
	stw 0,532(31)
	lis 9,gonk_move_turn1@ha
	la 9,gonk_move_turn1@l(9)
.L38:
	stw 9,772(31)
	lwz 0,148(1)
	mtlr 0
	lmw 29,124(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe2:
	.size	 gonk_run,.Lfe2-gonk_run
	.globl gonk_frames_death1
	.section	".data"
	.align 2
	.type	 gonk_frames_death1,@object
gonk_frames_death1:
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
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 gonk_frames_death1,120
	.globl gonk_move_death
	.align 2
	.type	 gonk_move_death,@object
	.size	 gonk_move_death,16
gonk_move_death:
	.long 15
	.long 24
	.long gonk_frames_death1
	.long gonk_dead
	.section	".rodata"
	.align 2
.LC18:
	.string	"models/npcs/gonk/gonk.md2"
	.align 2
.LC19:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_npc_gonk
	.type	 SP_npc_gonk,@function
SP_npc_gonk:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	lis 11,.LC19@ha
	lis 9,deathmatch@ha
	la 11,.LC19@l(11)
	mr 31,3
	lfs 31,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L46
	bl G_FreeEdict
	b .L45
.L46:
	li 28,0
	li 29,5
	li 0,-40
	lis 27,gi@ha
	stw 29,480(31)
	la 27,gi@l(27)
	stw 0,488(31)
	lis 3,.LC18@ha
	stw 29,484(31)
	la 3,.LC18@l(3)
	stw 28,60(31)
	lwz 9,32(27)
	mtlr 9
	blrl
	lis 9,gonk_pain@ha
	lis 11,gonk_die@ha
	lwz 5,776(31)
	la 9,gonk_pain@l(9)
	la 11,gonk_die@l(11)
	stw 29,260(31)
	lis 0,0x3f80
	stw 9,452(31)
	lis 7,gonk_stand@ha
	stw 11,456(31)
	lis 6,gonk_walk@ha
	lis 10,gonk_run@ha
	stw 0,784(31)
	lis 4,0x4100
	la 7,gonk_stand@l(7)
	la 6,gonk_walk@l(6)
	la 10,gonk_run@l(10)
	stw 3,40(31)
	ori 5,5,256
	lis 9,0xc1c0
	stw 4,204(31)
	li 8,2
	lis 11,0x4140
	stw 9,196(31)
	lis 29,0xc100
	li 0,50
	stw 8,248(31)
	stw 11,420(31)
	mr 3,31
	stw 7,788(31)
	stw 6,800(31)
	stw 10,804(31)
	stw 5,776(31)
	stw 4,200(31)
	stfs 31,208(31)
	stw 29,192(31)
	stw 0,400(31)
	stw 28,820(31)
	stw 29,188(31)
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
	bl walkmonster_start
.L45:
	lwz 0,52(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 SP_npc_gonk,.Lfe3-SP_npc_gonk
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
	.globl gonk_stand
	.type	 gonk_stand,@function
gonk_stand:
	lis 9,gonk_move_stand@ha
	la 9,gonk_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe4:
	.size	 gonk_stand,.Lfe4-gonk_stand
	.align 2
	.globl gonk_turn_end
	.type	 gonk_turn_end,@function
gonk_turn_end:
	li 0,0
	stw 0,532(3)
	blr
.Lfe5:
	.size	 gonk_turn_end,.Lfe5-gonk_turn_end
	.section	".rodata"
	.align 2
.LC20:
	.long 0x46fffe00
	.align 3
.LC21:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC22:
	.long 0x40a00000
	.align 2
.LC23:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl gonk_turn
	.type	 gonk_turn,@function
gonk_turn:
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
	lis 11,.LC21@ha
	cmpwi 0,10,1
	la 11,.LC21@l(11)
	stw 0,16(1)
	lis 10,.LC22@ha
	lfd 12,0(11)
	la 10,.LC22@l(10)
	lfd 0,16(1)
	lis 11,.LC20@ha
	lfs 13,.LC20@l(11)
	lfs 11,0(10)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,13
	fmuls 12,0,11
	bc 4,2,.L15
	lis 11,.LC23@ha
	lfs 13,20(31)
	la 11,.LC23@l(11)
	lfs 0,0(11)
	fadds 0,12,0
	fadds 13,13,0
	b .L47
.L15:
	lis 9,.LC23@ha
	lfs 13,20(31)
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fadds 0,12,0
	fsubs 13,13,0
.L47:
	stfs 13,20(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 gonk_turn,.Lfe6-gonk_turn
	.section	".rodata"
	.align 2
.LC24:
	.long 0x46fffe00
	.align 3
.LC25:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC26:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl gonk_move_turn
	.type	 gonk_move_turn,@function
gonk_move_turn:
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
	lis 10,.LC25@ha
	lis 11,.LC24@ha
	la 10,.LC25@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC26@ha
	lfs 12,.LC24@l(11)
	la 10,.LC26@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	li 0,2
	bc 4,1,.L18
	li 0,1
.L18:
	stw 0,532(31)
	lis 9,gonk_move_turn1@ha
	la 9,gonk_move_turn1@l(9)
	stw 9,772(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 gonk_move_turn,.Lfe7-gonk_move_turn
	.align 2
	.globl gonk_gonk
	.type	 gonk_gonk,@function
gonk_gonk:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl rand
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 gonk_gonk,.Lfe8-gonk_gonk
	.section	".rodata"
	.align 2
.LC29:
	.long 0x46fffe00
	.align 3
.LC30:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 3
.LC31:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl gonk_check_walk
	.type	 gonk_check_walk,@function
gonk_check_walk:
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
	lis 11,.LC31@ha
	lis 10,.LC29@ha
	la 11,.LC31@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC30@ha
	lfs 11,.LC29@l(10)
	lfd 12,.LC30@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L9
	mr 3,31
	bl gonk_walk
.L9:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 gonk_check_walk,.Lfe9-gonk_check_walk
	.section	".rodata"
	.align 2
.LC32:
	.long 0x41c00000
	.align 2
.LC33:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl gonk_ai_check_move_forward
	.type	 gonk_ai_check_move_forward,@function
gonk_ai_check_move_forward:
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
	lis 9,.LC32@ha
	addi 26,1,88
	la 9,.LC32@l(9)
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
	lis 9,.LC33@ha
	lfs 13,16(1)
	la 9,.LC33@l(9)
	lfs 0,0(9)
	fcmpu 7,13,0
	mfcr 3
	rlwinm 3,3,31,1
	lwz 0,132(1)
	mtlr 0
	lmw 26,104(1)
	la 1,128(1)
	blr
.Lfe10:
	.size	 gonk_ai_check_move_forward,.Lfe10-gonk_ai_check_move_forward
	.section	".rodata"
	.align 2
.LC34:
	.long 0x40c00000
	.section	".text"
	.align 2
	.globl gonk_pain
	.type	 gonk_pain,@function
gonk_pain:
	lis 9,level+4@ha
	lfs 0,464(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bclr 12,0
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,464(3)
	blr
.Lfe11:
	.size	 gonk_pain,.Lfe11-gonk_pain
	.align 2
	.globl gonk_dead
	.type	 gonk_dead,@function
gonk_dead:
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
.Lfe12:
	.size	 gonk_dead,.Lfe12-gonk_dead
	.align 2
	.globl gonk_die
	.type	 gonk_die,@function
gonk_die:
	lwz 0,492(3)
	cmpwi 0,0,2
	bclr 12,2
	lis 9,gonk_move_death@ha
	li 0,2
	la 9,gonk_move_death@l(9)
	li 11,1
	stw 0,492(3)
	stw 9,772(3)
	stw 11,512(3)
	blr
.Lfe13:
	.size	 gonk_die,.Lfe13-gonk_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
