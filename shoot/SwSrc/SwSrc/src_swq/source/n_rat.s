	.file	"n_rat.c"
gcc2_compiled.:
	.globl rat_frames_eat
	.section	".data"
	.align 2
	.type	 rat_frames_eat,@object
rat_frames_eat:
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
	.long ai_stand
	.long 0x0
	.long 0
	.size	 rat_frames_eat,132
	.globl rat_move_eat
	.align 2
	.type	 rat_move_eat,@object
	.size	 rat_move_eat,16
rat_move_eat:
	.long 37
	.long 47
	.long rat_frames_eat
	.long rat_eat_check
	.globl rat_frames_headup
	.align 2
	.type	 rat_frames_headup,@object
rat_frames_headup:
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.size	 rat_frames_headup,36
	.globl rat_move_headup
	.align 2
	.type	 rat_move_headup,@object
	.size	 rat_move_headup,16
rat_move_headup:
	.long 0
	.long 2
	.long rat_frames_headup
	.long rat_stand
	.globl rat_frames_headdn
	.align 2
	.type	 rat_frames_headdn,@object
rat_frames_headdn:
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long rat_walk
	.size	 rat_frames_headdn,24
	.globl rat_move_headdn
	.align 2
	.type	 rat_move_headdn,@object
	.size	 rat_move_headdn,16
rat_move_headdn:
	.long 33
	.long 34
	.long rat_frames_headdn
	.long rat_walk
	.globl rat_frames_stand
	.align 2
	.type	 rat_frames_stand,@object
rat_frames_stand:
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
	.long rat_ai_check_move
	.size	 rat_frames_stand,360
	.globl rat_move_stand
	.align 2
	.type	 rat_move_stand,@object
	.size	 rat_move_stand,16
rat_move_stand:
	.long 3
	.long 32
	.long rat_frames_stand
	.long rat_stand
	.globl rat_frames_turn
	.align 2
	.type	 rat_frames_turn,@object
rat_frames_turn:
	.long ai_move
	.long 0x0
	.long rat_turn
	.long ai_move
	.long 0x40000000
	.long rat_turn
	.long ai_move
	.long 0x40400000
	.long rat_turn
	.long ai_move
	.long 0x3f800000
	.long rat_turn
	.long ai_move
	.long 0x0
	.long rat_turn_end
	.size	 rat_frames_turn,60
	.globl rat_move_turn1
	.align 2
	.type	 rat_move_turn1,@object
	.size	 rat_move_turn1,16
rat_move_turn1:
	.long 48
	.long 52
	.long rat_frames_turn
	.long rat_walk
	.globl rat_frames_run1
	.align 2
	.type	 rat_frames_run1,@object
rat_frames_run1:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x41100000
	.long 0
	.long ai_move
	.long 0x40e00000
	.long 0
	.long ai_move
	.long 0x40800000
	.long rat_ai_check_stop
	.size	 rat_frames_run1,60
	.globl rat_move_run1
	.align 2
	.type	 rat_move_run1,@object
	.size	 rat_move_run1,16
rat_move_run1:
	.long 48
	.long 52
	.long rat_frames_run1
	.long rat_walk
	.section	".rodata"
	.align 2
.LC8:
	.long 0x46fffe00
	.align 3
.LC9:
	.long 0x3fee6666
	.long 0x66666666
	.align 3
.LC10:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC11:
	.long 0x42800000
	.align 2
.LC12:
	.long 0x3f800000
	.align 3
.LC13:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl rat_walk
	.type	 rat_walk,@function
rat_walk:
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
	lis 10,.LC10@ha
	lis 11,.LC8@ha
	stw 0,112(1)
	la 10,.LC10@l(10)
	addi 4,1,72
	lfd 0,112(1)
	li 6,0
	addi 3,31,16
	lfd 12,0(10)
	li 5,0
	lfs 13,.LC8@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 31,0,13
	bl AngleVectors
	lis 9,.LC11@ha
	addi 4,1,72
	la 9,.LC11@l(9)
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
	lis 9,.LC12@ha
	lfs 13,16(1)
	la 9,.LC12@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L27
	lis 9,.LC9@ha
	fmr 13,31
	lfd 0,.LC9@l(9)
	fcmpu 0,13,0
	bc 4,0,.L27
	lis 9,rat_move_run1@ha
	la 9,rat_move_run1@l(9)
	b .L34
.L27:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,116(1)
	lis 10,.LC10@ha
	lis 11,.LC8@ha
	la 10,.LC10@l(10)
	stw 0,112(1)
	lfd 13,0(10)
	lfd 0,112(1)
	lis 10,.LC13@ha
	lfs 12,.LC8@l(11)
	la 10,.LC13@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	li 0,2
	bc 4,1,.L31
	li 0,1
.L31:
	stw 0,532(31)
	lis 9,rat_move_turn1@ha
	la 9,rat_move_turn1@l(9)
.L34:
	stw 9,772(31)
	lwz 0,148(1)
	mtlr 0
	lmw 29,124(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe1:
	.size	 rat_walk,.Lfe1-rat_walk
	.globl rat_frames_pain
	.section	".data"
	.align 2
	.type	 rat_frames_pain,@object
rat_frames_pain:
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
	.size	 rat_frames_pain,48
	.globl rat_move_pain
	.align 2
	.type	 rat_move_pain,@object
	.size	 rat_move_pain,16
rat_move_pain:
	.long 53
	.long 56
	.long rat_frames_pain
	.long rat_stand
	.globl rat_frames_death2
	.align 2
	.type	 rat_frames_death2,@object
rat_frames_death2:
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
	.size	 rat_frames_death2,108
	.globl rat_move_death2
	.align 2
	.type	 rat_move_death2,@object
	.size	 rat_move_death2,16
rat_move_death2:
	.long 65
	.long 73
	.long rat_frames_death2
	.long rat_dead
	.globl rat_frames_death1
	.align 2
	.type	 rat_frames_death1,@object
rat_frames_death1:
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
	.size	 rat_frames_death1,96
	.globl rat_move_death1
	.align 2
	.type	 rat_move_death1,@object
	.size	 rat_move_death1,16
rat_move_death1:
	.long 57
	.long 64
	.long rat_frames_death1
	.long rat_dead
	.section	".rodata"
	.align 2
.LC17:
	.string	"models/npcs/rat/rat.md2"
	.align 2
.LC18:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_npc_rat
	.type	 SP_npc_rat,@function
SP_npc_rat:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 11,.LC18@ha
	lis 9,deathmatch@ha
	la 11,.LC18@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L49
	bl G_FreeEdict
	b .L48
.L49:
	li 28,0
	li 29,5
	li 0,-40
	lis 27,gi@ha
	stw 29,480(31)
	la 27,gi@l(27)
	stw 0,488(31)
	lis 3,.LC17@ha
	stw 29,484(31)
	la 3,.LC17@l(3)
	stw 28,60(31)
	lwz 9,32(27)
	mtlr 9
	blrl
	lis 9,rat_pain@ha
	lis 11,rat_die@ha
	lwz 5,776(31)
	lis 10,rat_stand@ha
	la 9,rat_pain@l(9)
	stw 29,260(31)
	la 11,rat_die@l(11)
	la 10,rat_stand@l(10)
	stw 9,452(31)
	lis 0,0x3f80
	stw 11,456(31)
	lis 7,rat_walk@ha
	stw 10,788(31)
	lis 8,rat_run@ha
	lis 4,0x4100
	stw 0,784(31)
	la 7,rat_walk@l(7)
	la 8,rat_run@l(8)
	ori 5,5,256
	lis 6,0x4080
	stw 4,204(31)
	li 11,2
	lis 10,0x4140
	stw 6,208(31)
	lis 9,0xc080
	lis 29,0xc100
	stw 11,248(31)
	li 0,50
	stw 10,420(31)
	stw 7,800(31)
	stw 8,804(31)
	stw 5,776(31)
	stw 4,200(31)
	stw 3,40(31)
	stw 9,196(31)
	mr 3,31
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
	lwz 0,804(31)
	mr 3,31
	mtlr 0
	blrl
.L48:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 SP_npc_rat,.Lfe2-SP_npc_rat
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
	.section	".rodata"
	.align 2
.LC19:
	.long 0x46fffe00
	.align 3
.LC20:
	.long 0x3fee6666
	.long 0x66666666
	.align 3
.LC21:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC22:
	.long 0x42800000
	.align 2
.LC23:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl rat_run
	.type	 rat_run,@function
rat_run:
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
	lis 11,.LC21@ha
	addi 4,1,72
	stw 0,112(1)
	la 11,.LC21@l(11)
	li 6,0
	lfd 12,0(11)
	addi 3,31,16
	li 5,0
	lfd 0,112(1)
	lis 11,.LC19@ha
	lfs 13,.LC19@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 31,0,13
	bl AngleVectors
	lis 9,.LC22@ha
	addi 4,1,72
	la 9,.LC22@l(9)
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
	lis 9,.LC23@ha
	lfs 13,16(1)
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L37
	lis 9,.LC20@ha
	fmr 13,31
	lfd 0,.LC20@l(9)
	fcmpu 0,13,0
	bc 4,0,.L37
	lis 9,rat_move_run1@ha
	la 9,rat_move_run1@l(9)
	b .L50
.L37:
	lis 9,rat_move_turn1@ha
	la 9,rat_move_turn1@l(9)
.L50:
	stw 9,772(31)
	lwz 0,148(1)
	mtlr 0
	lmw 29,124(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe3:
	.size	 rat_run,.Lfe3-rat_run
	.align 2
	.globl rat_stand
	.type	 rat_stand,@function
rat_stand:
	lis 9,rat_move_stand@ha
	la 9,rat_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe4:
	.size	 rat_stand,.Lfe4-rat_stand
	.section	".rodata"
	.align 2
.LC24:
	.long 0x46fffe00
	.align 3
.LC25:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC26:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl rat_eat_check
	.type	 rat_eat_check,@function
rat_eat_check:
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
	lis 11,.LC26@ha
	lis 10,.LC24@ha
	la 11,.LC26@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC25@ha
	lfs 11,.LC24@l(10)
	lfd 12,.LC25@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 4,3,.L7
	li 0,35
	stw 0,780(31)
	b .L8
.L7:
	mr 3,31
	bl rat_head_up
.L8:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 rat_eat_check,.Lfe5-rat_eat_check
	.align 2
	.globl rat_head_up
	.type	 rat_head_up,@function
rat_head_up:
	lis 9,rat_move_headup@ha
	la 9,rat_move_headup@l(9)
	stw 9,772(3)
	blr
.Lfe6:
	.size	 rat_head_up,.Lfe6-rat_head_up
	.align 2
	.globl rat_head_down
	.type	 rat_head_down,@function
rat_head_down:
	lis 9,rat_move_headdn@ha
	la 9,rat_move_headdn@l(9)
	stw 9,772(3)
	blr
.Lfe7:
	.size	 rat_head_down,.Lfe7-rat_head_down
	.section	".rodata"
	.align 2
.LC27:
	.long 0x46fffe00
	.align 3
.LC28:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC29:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl rat_move_turn
	.type	 rat_move_turn,@function
rat_move_turn:
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
	lis 10,.LC28@ha
	lis 11,.LC27@ha
	la 10,.LC28@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC29@ha
	lfs 12,.LC27@l(11)
	la 10,.LC29@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	li 0,2
	bc 4,1,.L24
	li 0,1
.L24:
	stw 0,532(31)
	lis 9,rat_move_turn1@ha
	la 9,rat_move_turn1@l(9)
	stw 9,772(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 rat_move_turn,.Lfe8-rat_move_turn
	.section	".rodata"
	.align 2
.LC30:
	.long 0x46fffe00
	.align 3
.LC31:
	.long 0x40318000
	.long 0x0
	.align 3
.LC32:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC33:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl rat_turn
	.type	 rat_turn,@function
rat_turn:
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
	lis 11,.LC32@ha
	cmpwi 0,10,1
	la 11,.LC32@l(11)
	stw 0,16(1)
	lis 10,.LC33@ha
	lfd 12,0(11)
	la 10,.LC33@l(10)
	lfd 0,16(1)
	lis 11,.LC30@ha
	lfs 13,.LC30@l(11)
	lfs 11,0(10)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,13
	fmuls 0,0,11
	bc 4,2,.L21
	fmr 13,0
	lis 9,.LC31@ha
	lfs 0,20(31)
	lfd 12,.LC31@l(9)
	fadd 13,13,12
	fadd 0,0,13
	b .L52
.L21:
	fmr 13,0
	lis 9,.LC31@ha
	lfs 0,20(31)
	lfd 12,.LC31@l(9)
	fadd 13,13,12
	fsub 0,0,13
.L52:
	frsp 0,0
	stfs 0,20(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 rat_turn,.Lfe9-rat_turn
	.align 2
	.globl rat_turn_end
	.type	 rat_turn_end,@function
rat_turn_end:
	li 0,0
	stw 0,532(3)
	blr
.Lfe10:
	.size	 rat_turn_end,.Lfe10-rat_turn_end
	.section	".rodata"
	.align 2
.LC34:
	.long 0x42800000
	.align 2
.LC35:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl rat_ai_check_move_forward
	.type	 rat_ai_check_move_forward,@function
rat_ai_check_move_forward:
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
	lis 9,.LC34@ha
	addi 26,1,88
	la 9,.LC34@l(9)
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
	lis 9,.LC35@ha
	lfs 13,16(1)
	la 9,.LC35@l(9)
	lfs 0,0(9)
	fcmpu 7,13,0
	mfcr 3
	rlwinm 3,3,31,1
	lwz 0,132(1)
	mtlr 0
	lmw 26,104(1)
	la 1,128(1)
	blr
.Lfe11:
	.size	 rat_ai_check_move_forward,.Lfe11-rat_ai_check_move_forward
	.section	".rodata"
	.align 2
.LC36:
	.long 0x46fffe00
	.align 3
.LC37:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC38:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl rat_ai_check_stop
	.type	 rat_ai_check_stop,@function
rat_ai_check_stop:
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
	lis 11,.LC38@ha
	lis 10,.LC36@ha
	la 11,.LC38@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC37@ha
	lfs 11,.LC36@l(10)
	lfd 12,.LC37@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L14
	lis 9,rat_move_eat@ha
	la 9,rat_move_eat@l(9)
	stw 9,772(31)
.L14:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 rat_ai_check_stop,.Lfe12-rat_ai_check_stop
	.section	".rodata"
	.align 2
.LC39:
	.long 0x46fffe00
	.align 3
.LC40:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC41:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl rat_ai_check_move
	.type	 rat_ai_check_move,@function
rat_ai_check_move:
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
	lis 10,.LC40@ha
	lis 11,.LC39@ha
	la 10,.LC40@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC41@ha
	lfs 12,.LC39@l(11)
	la 10,.LC41@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,1
	bc 4,3,.L16
	lis 9,rat_move_headdn@ha
	la 9,rat_move_headdn@l(9)
	stw 9,772(31)
.L16:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 rat_ai_check_move,.Lfe13-rat_ai_check_move
	.section	".rodata"
	.align 2
.LC42:
	.long 0x40c00000
	.section	".text"
	.align 2
	.globl rat_pain
	.type	 rat_pain,@function
rat_pain:
	lis 9,level+4@ha
	lfs 0,464(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bclr 12,0
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 0,0(9)
	lis 9,rat_move_pain@ha
	la 9,rat_move_pain@l(9)
	fadds 0,13,0
	stw 9,772(3)
	stfs 0,464(3)
	blr
.Lfe14:
	.size	 rat_pain,.Lfe14-rat_pain
	.align 2
	.globl rat_dead
	.type	 rat_dead,@function
rat_dead:
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
.Lfe15:
	.size	 rat_dead,.Lfe15-rat_dead
	.section	".rodata"
	.align 2
.LC43:
	.long 0x46fffe00
	.align 3
.LC44:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC45:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl rat_die
	.type	 rat_die,@function
rat_die:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L44
	li 0,2
	li 9,1
	stw 0,492(31)
	stw 9,512(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC44@ha
	lis 11,.LC43@ha
	la 10,.LC44@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC45@ha
	lfs 12,.LC43@l(11)
	la 10,.LC45@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,1
	bc 4,3,.L46
	lis 9,rat_move_death1@ha
	la 9,rat_move_death1@l(9)
	b .L54
.L46:
	lis 9,rat_move_death2@ha
	la 9,rat_move_death2@l(9)
.L54:
	stw 9,772(31)
.L44:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 rat_die,.Lfe16-rat_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
