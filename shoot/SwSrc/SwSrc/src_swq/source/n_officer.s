	.file	"n_officer.c"
gcc2_compiled.:
	.globl officer_frames_work
	.section	".data"
	.align 2
	.type	 officer_frames_work,@object
officer_frames_work:
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.size	 officer_frames_work,120
	.globl officer_move_work
	.align 2
	.type	 officer_move_work,@object
	.size	 officer_move_work,16
officer_move_work:
	.long 41
	.long 50
	.long officer_frames_work
	.long 0
	.globl officer_frames_stand
	.align 2
	.type	 officer_frames_stand,@object
officer_frames_stand:
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.long ai_npc_stand
	.long 0x0
	.long 0
	.size	 officer_frames_stand,132
	.globl officer_move_stand
	.align 2
	.type	 officer_move_stand,@object
	.size	 officer_move_stand,16
officer_move_stand:
	.long 0
	.long 10
	.long officer_frames_stand
	.long 0
	.globl officer_frames_walk
	.align 2
	.type	 officer_frames_walk,@object
officer_frames_walk:
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.size	 officer_frames_walk,144
	.globl officer_move_walk
	.align 2
	.type	 officer_move_walk,@object
	.size	 officer_move_walk,16
officer_move_walk:
	.long 21
	.long 32
	.long officer_frames_walk
	.long 0
	.globl officer_frames_start_walk
	.align 2
	.type	 officer_frames_start_walk,@object
officer_frames_start_walk:
	.long ai_npc_walk
	.long 0x3f000000
	.long 0
	.long ai_npc_walk
	.long 0x3f800000
	.long 0
	.long ai_npc_walk
	.long 0x3fc00000
	.long 0
	.long ai_npc_walk
	.long 0x40000000
	.long 0
	.long ai_npc_walk
	.long 0x40200000
	.long 0
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.long ai_npc_walk
	.long 0x40400000
	.long 0
	.size	 officer_frames_start_walk,120
	.globl officer_move_start_walk
	.align 2
	.type	 officer_move_start_walk,@object
	.size	 officer_move_start_walk,16
officer_move_start_walk:
	.long 11
	.long 20
	.long officer_frames_start_walk
	.long officer_walk
	.globl officer_frames_end_walk
	.align 2
	.type	 officer_frames_end_walk,@object
officer_frames_end_walk:
	.long ai_npc_stand
	.long 0x40400000
	.long 0
	.long ai_npc_stand
	.long 0x40200000
	.long 0
	.long ai_npc_stand
	.long 0x40000000
	.long 0
	.long ai_npc_stand
	.long 0x3fc00000
	.long 0
	.long ai_npc_stand
	.long 0x3f800000
	.long 0
	.long ai_npc_stand
	.long 0x3f000000
	.long 0
	.size	 officer_frames_end_walk,72
	.globl officer_move_end_walk
	.align 2
	.type	 officer_move_end_walk,@object
	.size	 officer_move_end_walk,16
officer_move_end_walk:
	.long 33
	.long 37
	.long officer_frames_end_walk
	.long officer_stand
	.section	".rodata"
	.align 2
.LC0:
	.long 0x0
	.section	".text"
	.align 2
	.globl officer_stand
	.type	 officer_stand,@function
officer_stand:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,1012(31)
	cmpwi 0,0,0
	bc 4,2,.L8
	lwz 0,776(31)
	cmpwi 0,0,0
	bc 4,2,.L8
	lis 9,.LC0@ha
	lfs 13,828(31)
	la 9,.LC0@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L8
	lwz 3,312(31)
	bl G_PickTarget
	stw 3,1012(31)
.L8:
	lwz 0,772(31)
	lis 9,officer_move_stand@ha
	la 9,officer_move_stand@l(9)
	cmpw 0,0,9
	bc 12,2,.L12
	lis 9,officer_move_work@ha
	la 11,officer_move_work@l(9)
	cmpw 0,0,11
	bc 12,2,.L12
	lis 9,officer_move_end_walk@ha
	la 9,officer_move_end_walk@l(9)
	cmpw 0,0,9
	bc 4,2,.L11
.L12:
	lwz 0,284(31)
	andi. 9,0,8
	bc 12,2,.L16
	lwz 0,776(31)
	cmpwi 0,0,0
	bc 4,2,.L16
	lis 9,officer_move_work@ha
	la 9,officer_move_work@l(9)
	b .L18
.L11:
	lwz 0,284(31)
	andi. 9,0,8
	bc 12,2,.L16
	lwz 0,776(31)
	cmpwi 0,0,0
	bc 4,2,.L16
	stw 11,772(31)
	b .L15
.L16:
	lis 9,officer_move_stand@ha
	la 9,officer_move_stand@l(9)
.L18:
	stw 9,772(31)
.L15:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 officer_stand,.Lfe1-officer_stand
	.globl officer_frames_run
	.section	".data"
	.align 2
	.type	 officer_frames_run,@object
officer_frames_run:
	.long ai_npc_walk
	.long 0x40800000
	.long 0
	.long ai_npc_walk
	.long 0x41700000
	.long 0
	.long ai_npc_walk
	.long 0x41700000
	.long 0
	.long ai_npc_walk
	.long 0x41000000
	.long 0
	.long ai_npc_walk
	.long 0x41a00000
	.long 0
	.long ai_npc_walk
	.long 0x41700000
	.long 0
	.long ai_npc_walk
	.long 0x41000000
	.long 0
	.long ai_npc_walk
	.long 0x41a00000
	.long 0
	.size	 officer_frames_run,96
	.globl officer_move_run
	.align 2
	.type	 officer_move_run,@object
	.size	 officer_move_run,16
officer_move_run:
	.long 52
	.long 59
	.long officer_frames_run
	.long 0
	.section	".rodata"
	.align 2
.LC1:
	.string	"officer_mark"
	.align 2
.LC2:
	.string	"%s has bad target %s at %s\n"
	.globl officer_frames_death1
	.section	".data"
	.align 2
	.type	 officer_frames_death1,@object
officer_frames_death1:
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
	.size	 officer_frames_death1,192
	.globl officer_move_death1
	.align 2
	.type	 officer_move_death1,@object
	.size	 officer_move_death1,16
officer_move_death1:
	.long 60
	.long 75
	.long officer_frames_death1
	.long officer_dead
	.section	".rodata"
	.align 2
.LC4:
	.string	"models/npcs/officer/tris.md2"
	.align 2
.LC5:
	.long 0x0
	.align 2
.LC6:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl SP_npc_officer
	.type	 SP_npc_officer,@function
SP_npc_officer:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	lis 11,.LC5@ha
	lis 9,deathmatch@ha
	la 11,.LC5@l(11)
	mr 31,3
	lfs 31,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L37
	bl G_FreeEdict
	b .L36
.L37:
	li 0,5
	li 11,2
	lis 9,gi@ha
	stw 0,260(31)
	lis 3,.LC4@ha
	stw 11,248(31)
	la 30,gi@l(9)
	la 3,.LC4@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 9,480(31)
	lis 10,0xc100
	lis 8,0x4100
	lis 0,0xc1c0
	lis 11,0x4200
	stw 3,40(31)
	cmpwi 0,9,0
	stw 10,192(31)
	stw 0,196(31)
	stw 8,204(31)
	stw 11,208(31)
	stw 10,188(31)
	stw 8,200(31)
	bc 4,2,.L38
	li 0,30
	stw 0,480(31)
.L38:
	lis 9,officer_pain@ha
	lis 11,officer_die@ha
	la 9,officer_pain@l(9)
	la 11,officer_die@l(11)
	stw 9,452(31)
	lis 10,officer_stand@ha
	lis 8,officer_walk@ha
	stw 11,456(31)
	lis 7,officer_run@ha
	lis 6,officer_attack@ha
	li 5,0
	la 10,officer_stand@l(10)
	la 8,officer_walk@l(8)
	la 7,officer_run@l(7)
	stw 10,788(31)
	la 6,officer_attack@l(6)
	li 9,200
	stw 8,800(31)
	li 11,-1
	lis 0,0x4170
	stw 9,400(31)
	stw 7,804(31)
	mr 3,31
	stw 6,812(31)
	stw 5,820(31)
	sth 11,992(31)
	stw 5,816(31)
	stw 0,420(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lis 9,officer_move_stand@ha
	lis 0,0x3f80
	la 9,officer_move_stand@l(9)
	stw 0,784(31)
	mr 3,31
	stw 9,772(31)
	bl walkmonster_start
	lfs 13,592(31)
	fcmpu 0,13,31
	bc 12,2,.L39
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	b .L41
.L39:
	lis 11,.LC6@ha
	lis 9,level+4@ha
	la 11,.LC6@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
.L41:
	fadds 0,0,13
	stfs 0,828(31)
.L36:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 SP_npc_officer,.Lfe2-SP_npc_officer
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
	.globl officer_walk
	.type	 officer_walk,@function
officer_walk:
	lis 9,officer_move_walk@ha
	lwz 0,772(3)
	la 11,officer_move_walk@l(9)
	cmpw 0,0,11
	bc 12,2,.L21
	lis 9,officer_move_start_walk@ha
	la 9,officer_move_start_walk@l(9)
	cmpw 0,0,9
	bc 4,2,.L20
.L21:
	stw 11,772(3)
	blr
.L20:
	stw 9,772(3)
	blr
.Lfe3:
	.size	 officer_walk,.Lfe3-officer_walk
	.align 2
	.globl officer_run
	.type	 officer_run,@function
officer_run:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,1012(31)
	cmpwi 0,0,0
	bc 4,2,.L24
	lwz 3,320(31)
	bl G_PickTarget
	stw 3,1012(31)
.L24:
	lwz 0,776(31)
	andi. 9,0,1
	bc 12,2,.L25
	mr 3,31
	bl officer_stand
	b .L23
.L25:
	lis 9,officer_move_run@ha
	la 9,officer_move_run@l(9)
	stw 9,772(31)
.L23:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 officer_run,.Lfe4-officer_run
	.section	".rodata"
	.align 2
.LC7:
	.long 0x4cbebc20
	.section	".text"
	.align 2
	.globl officer_pain_hide
	.type	 officer_pain_hide,@function
officer_pain_hide:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	lwz 3,316(31)
	cmpwi 0,3,0
	bc 12,2,.L26
	bl G_PickTarget
	cmpwi 0,3,0
	stw 3,416(31)
	stw 3,412(31)
	bc 12,2,.L29
	lwz 3,280(3)
	lis 4,.LC1@ha
	la 4,.LC1@l(4)
	bl strcmp
	mr. 30,3
	bc 12,2,.L28
.L29:
	lis 9,gi+4@ha
	lis 3,.LC2@ha
	lwz 4,280(31)
	lwz 0,gi+4@l(9)
	la 3,.LC2@l(3)
	lwz 5,316(31)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,788(31)
	lis 9,.LC7@ha
	mr 3,31
	lfs 0,.LC7@l(9)
	li 0,0
	mtlr 11
	stw 0,316(31)
	stfs 0,828(31)
	blrl
	b .L26
.L28:
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
	lwz 9,800(31)
	mr 3,31
	stfs 1,424(31)
	mtlr 9
	stfs 1,20(31)
	blrl
	stw 30,316(31)
.L26:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 officer_pain_hide,.Lfe5-officer_pain_hide
	.align 2
	.globl officer_pain
	.type	 officer_pain,@function
officer_pain:
	blr
.Lfe6:
	.size	 officer_pain,.Lfe6-officer_pain
	.align 2
	.globl officer_dead
	.type	 officer_dead,@function
officer_dead:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 11,0xc1c0
	lwz 0,184(9)
	lis 5,0xc180
	lis 6,0x4180
	stw 11,196(9)
	lis 8,0xc100
	li 7,7
	ori 0,0,2
	li 10,0
	stw 5,192(9)
	stw 6,204(9)
	lis 11,gi+72@ha
	stw 8,208(9)
	stw 7,260(9)
	stw 0,184(9)
	stw 10,428(9)
	stw 5,188(9)
	stw 6,200(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 officer_dead,.Lfe7-officer_dead
	.align 2
	.globl officer_die
	.type	 officer_die,@function
officer_die:
	lwz 0,492(3)
	cmpwi 0,0,2
	bclr 12,2
	lis 9,officer_move_death1@ha
	li 0,2
	la 9,officer_move_death1@l(9)
	li 11,1
	stw 0,492(3)
	stw 9,772(3)
	stw 11,512(3)
	blr
.Lfe8:
	.size	 officer_die,.Lfe8-officer_die
	.align 2
	.globl officer_use
	.type	 officer_use,@function
officer_use:
	blr
.Lfe9:
	.size	 officer_use,.Lfe9-officer_use
	.align 2
	.globl officer_attack
	.type	 officer_attack,@function
officer_attack:
	blr
.Lfe10:
	.size	 officer_attack,.Lfe10-officer_attack
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
