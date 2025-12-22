	.file	"n_mse.c"
gcc2_compiled.:
	.globl MSE_frames_stand
	.section	".data"
	.align 2
	.type	 MSE_frames_stand,@object
MSE_frames_stand:
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
	.size	 MSE_frames_stand,144
	.globl MSE_move_stand
	.align 2
	.type	 MSE_move_stand,@object
	.size	 MSE_move_stand,16
MSE_move_stand:
	.long 0
	.long 11
	.long MSE_frames_stand
	.long MSE_stand
	.globl MSE_frames_death1
	.align 2
	.type	 MSE_frames_death1,@object
MSE_frames_death1:
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
	.long ai_move
	.long 0x0
	.long 0
	.size	 MSE_frames_death1,132
	.globl MSE_move_death
	.align 2
	.type	 MSE_move_death,@object
	.size	 MSE_move_death,16
MSE_move_death:
	.long 16
	.long 26
	.long MSE_frames_death1
	.long MSE_dead
	.section	".rodata"
	.align 2
.LC0:
	.string	"models/npcs/mousedroid/tris.md2"
	.align 2
.LC1:
	.string	"models/npcs/mousedroid/fwheels.md2"
	.align 2
.LC2:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_npc_MSE
	.type	 SP_npc_MSE,@function
SP_npc_MSE:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	lis 11,.LC2@ha
	lis 9,deathmatch@ha
	la 11,.LC2@l(11)
	mr 31,3
	lfs 31,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L13
	bl G_FreeEdict
	b .L12
.L13:
	li 27,0
	li 0,-40
	li 29,5
	lis 28,gi@ha
	stw 0,488(31)
	la 28,gi@l(28)
	stw 27,60(31)
	lis 3,.LC0@ha
	stw 29,480(31)
	la 3,.LC0@l(3)
	stw 29,484(31)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(31)
	lwz 9,32(28)
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	mtlr 9
	blrl
	lwz 5,776(31)
	lis 0,0x3f80
	lis 8,MSE_pain@ha
	stw 0,784(31)
	lis 7,MSE_die@ha
	lis 9,MSE_stand@ha
	la 9,MSE_stand@l(9)
	lis 4,0x4100
	stw 3,44(31)
	la 8,MSE_pain@l(8)
	la 7,MSE_die@l(7)
	stw 4,204(31)
	ori 5,5,256
	lis 11,0x4180
	stw 8,452(31)
	li 6,2
	lis 10,0x4140
	stw 11,208(31)
	lis 26,0xc100
	li 0,50
	stw 6,248(31)
	stw 10,420(31)
	mr 3,31
	stw 7,456(31)
	stw 9,804(31)
	stw 5,776(31)
	stw 4,200(31)
	stw 9,788(31)
	stw 9,800(31)
	stfs 31,196(31)
	stw 29,260(31)
	stw 26,192(31)
	stw 0,400(31)
	stw 27,820(31)
	stw 26,188(31)
	stw 27,808(31)
	stw 27,812(31)
	stw 27,816(31)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	mr 3,31
	bl walkmonster_start
.L12:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 SP_npc_MSE,.Lfe1-SP_npc_MSE
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
	.globl MSE_stand
	.type	 MSE_stand,@function
MSE_stand:
	lis 9,MSE_move_stand@ha
	la 9,MSE_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe2:
	.size	 MSE_stand,.Lfe2-MSE_stand
	.section	".rodata"
	.align 2
.LC3:
	.long 0x40c00000
	.section	".text"
	.align 2
	.globl MSE_pain
	.type	 MSE_pain,@function
MSE_pain:
	lis 9,level+4@ha
	lfs 0,464(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bclr 12,0
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,464(3)
	blr
.Lfe3:
	.size	 MSE_pain,.Lfe3-MSE_pain
	.align 2
	.globl MSE_dead
	.type	 MSE_dead,@function
MSE_dead:
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
.Lfe4:
	.size	 MSE_dead,.Lfe4-MSE_dead
	.align 2
	.globl MSE_die
	.type	 MSE_die,@function
MSE_die:
	lwz 0,492(3)
	cmpwi 0,0,2
	bclr 12,2
	lis 9,MSE_move_death@ha
	li 0,2
	la 9,MSE_move_death@l(9)
	li 11,1
	stw 0,492(3)
	stw 9,772(3)
	stw 11,512(3)
	blr
.Lfe5:
	.size	 MSE_die,.Lfe5-MSE_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
