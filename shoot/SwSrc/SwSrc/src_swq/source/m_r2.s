	.file	"m_r2.c"
gcc2_compiled.:
	.globl r2_frames_stand
	.section	".data"
	.align 2
	.type	 r2_frames_stand,@object
r2_frames_stand:
	.long ai_stand
	.long 0x0
	.long 0
	.size	 r2_frames_stand,12
	.globl r2_move_stand
	.align 2
	.type	 r2_move_stand,@object
	.size	 r2_move_stand,16
r2_move_stand:
	.long 0
	.long 0
	.long r2_frames_stand
	.long r2_stand
	.globl r2_frames_walk1
	.align 2
	.type	 r2_frames_walk1,@object
r2_frames_walk1:
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.size	 r2_frames_walk1,24
	.globl r2_move_walk1
	.align 2
	.type	 r2_move_walk1,@object
	.size	 r2_move_walk1,16
r2_move_walk1:
	.long 23
	.long 24
	.long r2_frames_walk1
	.long 0
	.globl r2_frames_run
	.align 2
	.type	 r2_frames_run,@object
r2_frames_run:
	.long ai_run
	.long 0x40800000
	.long 0
	.long ai_run
	.long 0x40800000
	.long 0
	.size	 r2_frames_run,24
	.globl r2_move_run
	.align 2
	.type	 r2_move_run,@object
	.size	 r2_move_run,16
r2_move_run:
	.long 23
	.long 24
	.long r2_frames_run
	.long 0
	.globl r2_frames_pain1
	.align 2
	.type	 r2_frames_pain1,@object
r2_frames_pain1:
	.long ai_move
	.long 0xc0400000
	.long 0
	.long ai_move
	.long 0x40800000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0xc0400000
	.long 0
	.long ai_move
	.long 0x40800000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0xc0400000
	.long 0
	.long ai_move
	.long 0x40800000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.size	 r2_frames_pain1,144
	.globl r2_move_pain1
	.align 2
	.type	 r2_move_pain1,@object
	.size	 r2_move_pain1,16
r2_move_pain1:
	.long 1
	.long 12
	.long r2_frames_pain1
	.long r2_run
	.section	".rodata"
	.align 2
.LC0:
	.string	"r2-unit/confusion.wav"
	.align 2
.LC1:
	.string	"r2-unit/happybeep.wav"
	.align 2
.LC2:
	.string	"r2-unit/r2happy1.wav"
	.align 2
.LC3:
	.string	"r2-unit/r2d21.wav"
	.align 2
.LC4:
	.string	"r2-unit/wow-oh!.wav"
	.align 2
.LC5:
	.string	"r2-unit/r2d2walk.wav"
	.align 2
.LC6:
	.string	"r2-unit/r2dangr.wav"
	.align 2
.LC7:
	.string	"r2-unit/r2hit.wav"
	.align 2
.LC8:
	.string	"r2-unit/r2warn.wav"
	.align 2
.LC9:
	.string	"r2-unit/wow-beep.wav"
	.align 2
.LC11:
	.string	"models/monsters/r2unit/tris.md2"
	.align 2
.LC10:
	.long 0x46fffe00
	.align 2
.LC12:
	.long 0x3f99999a
	.align 2
.LC13:
	.long 0x0
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC15:
	.long 0x41700000
	.align 2
.LC16:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl SP_monster_r2
	.type	 SP_monster_r2,@function
SP_monster_r2:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 11,.LC13@ha
	lis 9,deathmatch@ha
	la 11,.LC13@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L18
	bl G_FreeEdict
	b .L17
.L18:
	lis 29,gi@ha
	lis 3,.LC0@ha
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	lwz 9,36(29)
	li 27,0
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_confused@ha
	lis 11,.LC1@ha
	stw 3,sound_confused@l(9)
	mtlr 10
	la 3,.LC1@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_happybeep@ha
	lis 11,.LC2@ha
	stw 3,sound_happybeep@l(9)
	mtlr 10
	la 3,.LC2@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_happy@ha
	lis 11,.LC3@ha
	stw 3,sound_happy@l(9)
	mtlr 10
	la 3,.LC3@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sad1@ha
	lis 11,.LC4@ha
	stw 3,sound_sad1@l(9)
	mtlr 10
	la 3,.LC4@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sad2@ha
	lis 11,.LC5@ha
	stw 3,sound_sad2@l(9)
	mtlr 10
	la 3,.LC5@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_walk@ha
	lis 11,.LC6@ha
	stw 3,sound_walk@l(9)
	mtlr 10
	la 3,.LC6@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_danger@ha
	lis 11,.LC7@ha
	stw 3,sound_danger@l(9)
	mtlr 10
	la 3,.LC7@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_die@ha
	lis 11,.LC8@ha
	stw 3,sound_die@l(9)
	mtlr 10
	la 3,.LC8@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_warn@ha
	lis 11,.LC9@ha
	stw 3,sound_warn@l(9)
	mtlr 10
	la 3,.LC9@l(11)
	blrl
	lis 9,sound_wowbeep@ha
	stw 3,sound_wowbeep@l(9)
	stw 27,60(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC14@ha
	lis 10,.LC10@ha
	stw 0,16(1)
	la 11,.LC14@l(11)
	lis 3,.LC11@ha
	lfd 13,0(11)
	li 0,-40
	la 3,.LC11@l(3)
	lfd 0,16(1)
	lis 11,.LC15@ha
	lfs 11,.LC10@l(10)
	la 11,.LC15@l(11)
	lfs 9,0(11)
	fsub 0,0,13
	lis 11,.LC16@ha
	stw 0,488(31)
	la 11,.LC16@l(11)
	lfs 10,0(11)
	frsp 0,0
	mr 11,9
	fdivs 0,0,11
	fmadds 0,0,9,10
	fmr 13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 11,20(1)
	stw 11,484(31)
	stw 11,480(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lwz 0,776(31)
	lis 9,.LC12@ha
	lis 11,r2_pain@ha
	lfs 0,.LC12@l(9)
	lis 10,r2_die@ha
	la 11,r2_pain@l(11)
	ori 0,0,256
	lis 9,r2_stand@ha
	stw 11,452(31)
	stw 0,776(31)
	la 10,r2_die@l(10)
	la 9,r2_stand@l(9)
	lis 0,0xc1c0
	stw 10,456(31)
	lis 7,r2_walk@ha
	stw 9,788(31)
	lis 6,r2_run@ha
	lis 5,r2_sight@ha
	stw 0,196(31)
	lis 4,0xc180
	la 7,r2_walk@l(7)
	la 6,r2_run@l(6)
	la 5,r2_sight@l(5)
	stw 3,40(31)
	lis 11,0x4200
	li 10,5
	stfs 0,784(31)
	li 8,2
	lis 9,0x4120
	stw 4,192(31)
	lis 28,0x4180
	li 0,50
	stw 11,208(31)
	stw 10,260(31)
	mr 3,31
	stw 8,248(31)
	stw 9,420(31)
	stw 7,800(31)
	stw 6,804(31)
	stw 5,820(31)
	stw 4,188(31)
	stw 28,204(31)
	stw 0,400(31)
	stw 27,816(31)
	stw 28,200(31)
	stw 27,808(31)
	stw 27,812(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	mr 3,31
	bl walkmonster_start
.L17:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 SP_monster_r2,.Lfe1-SP_monster_r2
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
	.section	".sbss","aw",@nobits
	.align 2
sound_confused:
	.space	4
	.size	 sound_confused,4
	.align 2
sound_happybeep:
	.space	4
	.size	 sound_happybeep,4
	.align 2
sound_happy:
	.space	4
	.size	 sound_happy,4
	.align 2
sound_sad1:
	.space	4
	.size	 sound_sad1,4
	.align 2
sound_sad2:
	.space	4
	.size	 sound_sad2,4
	.align 2
sound_walk:
	.space	4
	.size	 sound_walk,4
	.align 2
sound_danger:
	.space	4
	.size	 sound_danger,4
	.align 2
sound_die:
	.space	4
	.size	 sound_die,4
	.align 2
sound_warn:
	.space	4
	.size	 sound_warn,4
	.align 2
sound_wowbeep:
	.space	4
	.size	 sound_wowbeep,4
	.section	".text"
	.align 2
	.globl r2_stand
	.type	 r2_stand,@function
r2_stand:
	lis 9,r2_move_stand@ha
	la 9,r2_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe2:
	.size	 r2_stand,.Lfe2-r2_stand
	.align 2
	.globl r2_walk
	.type	 r2_walk,@function
r2_walk:
	lis 9,r2_move_walk1@ha
	la 9,r2_move_walk1@l(9)
	stw 9,772(3)
	blr
.Lfe3:
	.size	 r2_walk,.Lfe3-r2_walk
	.align 2
	.globl r2_run
	.type	 r2_run,@function
r2_run:
	lis 9,r2_move_run@ha
	la 9,r2_move_run@l(9)
	stw 9,772(3)
	blr
.Lfe4:
	.size	 r2_run,.Lfe4-r2_run
	.section	".rodata"
	.align 2
.LC17:
	.long 0x40c00000
	.align 2
.LC18:
	.long 0x3f800000
	.align 2
.LC19:
	.long 0x0
	.align 2
.LC20:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl r2_pain
	.type	 r2_pain,@function
r2_pain:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,464(31)
	fcmpu 0,13,0
	bc 12,0,.L9
	lis 9,.LC17@ha
	lis 11,gi+16@ha
	la 9,.LC17@l(9)
	lfs 0,0(9)
	li 4,2
	lis 9,sound_wowbeep@ha
	lwz 5,sound_wowbeep@l(9)
	lis 9,.LC18@ha
	fadds 0,13,0
	la 9,.LC18@l(9)
	lfs 1,0(9)
	lis 9,.LC18@ha
	stfs 0,464(31)
	la 9,.LC18@l(9)
	lwz 0,gi+16@l(11)
	lfs 2,0(9)
	lis 9,.LC19@ha
	mtlr 0
	la 9,.LC19@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC20@ha
	lis 11,skill@ha
	la 9,.LC20@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L9
	lis 9,r2_move_pain1@ha
	la 9,r2_move_pain1@l(9)
	stw 9,772(31)
.L9:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 r2_pain,.Lfe5-r2_pain
	.section	".rodata"
	.align 2
.LC21:
	.long 0x3f800000
	.align 2
.LC22:
	.long 0x0
	.section	".text"
	.align 2
	.globl r2_sight
	.type	 r2_sight,@function
r2_sight:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_danger@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC21@ha
	lwz 5,sound_danger@l(11)
	la 9,.LC21@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 2,0(9)
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 r2_sight,.Lfe6-r2_sight
	.align 2
	.globl r2_dead
	.type	 r2_dead,@function
r2_dead:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 11,0xc1c0
	lwz 0,184(9)
	lis 4,0xc180
	lis 5,0x4180
	stw 11,196(9)
	lis 7,0xc100
	li 6,7
	ori 0,0,2
	li 10,0
	stw 4,192(9)
	li 8,0
	stw 5,204(9)
	lis 11,gi+72@ha
	stw 7,208(9)
	stw 6,260(9)
	stw 10,248(9)
	stw 0,184(9)
	stw 8,428(9)
	stw 4,188(9)
	stw 5,200(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 r2_dead,.Lfe7-r2_dead
	.section	".rodata"
	.align 2
.LC23:
	.long 0x3f800000
	.align 2
.LC24:
	.long 0x0
	.section	".text"
	.align 2
	.globl r2_die
	.type	 r2_die,@function
r2_die:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L14
	lis 9,sound_die@ha
	li 0,2
	lwz 5,sound_die@l(9)
	lis 29,gi@ha
	lis 9,.LC23@ha
	la 29,gi@l(29)
	stw 0,492(31)
	la 9,.LC23@l(9)
	lwz 11,16(29)
	li 4,2
	lfs 1,0(9)
	lis 9,.LC23@ha
	mtlr 11
	la 9,.LC23@l(9)
	lfs 2,0(9)
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,184(31)
	li 9,23
	lis 6,0xc180
	stw 9,56(31)
	lis 5,0x4180
	lis 11,0xc1c0
	ori 0,0,2
	lis 7,0xc100
	stw 6,192(31)
	li 10,7
	li 9,0
	stw 11,196(31)
	li 8,0
	stw 5,204(31)
	mr 3,31
	stw 7,208(31)
	stw 10,260(31)
	stw 9,248(31)
	stw 0,184(31)
	stw 8,428(31)
	stw 6,188(31)
	stw 5,200(31)
	lwz 0,72(29)
	mtlr 0
	blrl
.L14:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 r2_die,.Lfe8-r2_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
