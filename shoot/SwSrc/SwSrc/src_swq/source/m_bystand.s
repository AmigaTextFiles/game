	.file	"m_bystand.c"
gcc2_compiled.:
	.globl maleworker_frames_stand
	.section	".data"
	.align 2
	.type	 maleworker_frames_stand,@object
maleworker_frames_stand:
	.long ai_stand
	.long 0x0
	.long maleworker_AI_stand
	.long ai_stand
	.long 0x0
	.long maleworker_AI_stand
	.long ai_stand
	.long 0x0
	.long maleworker_AI_stand
	.long ai_stand
	.long 0x0
	.long maleworker_AI_stand
	.size	 maleworker_frames_stand,48
	.globl maleworker_move_stand
	.align 2
	.type	 maleworker_move_stand,@object
	.size	 maleworker_move_stand,16
maleworker_move_stand:
	.long 0
	.long 3
	.long maleworker_frames_stand
	.long 0
	.globl maleworker_frames_walk
	.align 2
	.type	 maleworker_frames_walk,@object
maleworker_frames_walk:
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.size	 maleworker_frames_walk,216
	.globl maleworker_move_walk
	.align 2
	.type	 maleworker_move_walk,@object
	.size	 maleworker_move_walk,16
maleworker_move_walk:
	.long 23
	.long 40
	.long maleworker_frames_walk
	.long 0
	.globl maleworker_frames_run
	.align 2
	.type	 maleworker_frames_run,@object
maleworker_frames_run:
	.long ai_run
	.long 0x40800000
	.long 0
	.long ai_run
	.long 0x41700000
	.long 0
	.long ai_run
	.long 0x41700000
	.long 0
	.long ai_run
	.long 0x41000000
	.long 0
	.long ai_run
	.long 0x41a00000
	.long 0
	.long ai_run
	.long 0x41700000
	.long 0
	.size	 maleworker_frames_run,72
	.globl maleworker_move_run
	.align 2
	.type	 maleworker_move_run,@object
	.size	 maleworker_move_run,16
maleworker_move_run:
	.long 41
	.long 46
	.long maleworker_frames_run
	.long 0
	.section	".rodata"
	.align 3
.LC2:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl maleworker_run
	.type	 maleworker_run,@function
maleworker_run:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,level@ha
	mr 31,3
	la 11,level@l(9)
	lfs 13,464(31)
	lfs 0,4(11)
	fcmpu 0,0,13
	bc 4,0,.L15
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L15
	lwz 0,416(31)
	cmpwi 0,0,0
	bc 12,2,.L16
	lis 9,maleworker_move_walk@ha
	la 9,maleworker_move_walk@l(9)
	b .L24
.L16:
	lis 9,maleworker_move_stand@ha
	lis 10,.LC2@ha
	la 9,maleworker_move_stand@l(9)
	la 10,.LC2@l(10)
	stw 9,772(31)
	lfs 0,4(11)
	b .L25
.L15:
	lwz 0,776(31)
	andi. 9,0,1
	bc 12,2,.L21
	lis 9,maleworker_move_stand@ha
	lis 11,level+4@ha
	la 9,maleworker_move_stand@l(9)
	lis 10,.LC2@ha
	stw 9,772(31)
	la 10,.LC2@l(10)
	lfs 0,level+4@l(11)
.L25:
	lfd 13,0(10)
	fcmpu 0,0,13
	bc 4,0,.L14
	bl rand
	lwz 10,772(31)
	lwz 11,0(10)
	lwz 9,4(10)
	subf 9,11,9
	addi 9,9,1
	divw 0,3,9
	mullw 0,0,9
	subf 3,0,3
	add 11,11,3
	stw 11,56(31)
	b .L14
.L21:
	lis 9,maleworker_move_run@ha
	la 9,maleworker_move_run@l(9)
.L24:
	stw 9,772(31)
.L14:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 maleworker_run,.Lfe1-maleworker_run
	.globl maleworker_frames_pain
	.section	".data"
	.align 2
	.type	 maleworker_frames_pain,@object
maleworker_frames_pain:
	.long ai_move
	.long 0xc0a00000
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
	.size	 maleworker_frames_pain,48
	.globl maleworker_move_pain
	.align 2
	.type	 maleworker_move_pain,@object
	.size	 maleworker_move_pain,16
maleworker_move_pain:
	.long 146
	.long 149
	.long maleworker_frames_pain
	.long maleworker_run
	.globl maleworker_frames_pain2
	.align 2
	.type	 maleworker_frames_pain2,@object
maleworker_frames_pain2:
	.long ai_move
	.long 0xc0800000
	.long 0
	.long ai_move
	.long 0x40800000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 maleworker_frames_pain2,48
	.globl maleworker_move_pain2
	.align 2
	.type	 maleworker_move_pain2,@object
	.size	 maleworker_move_pain2,16
maleworker_move_pain2:
	.long 146
	.long 149
	.long maleworker_frames_pain2
	.long maleworker_run
	.section	".rodata"
	.align 2
.LC4:
	.string	"player/male/pain25_1.wav"
	.align 2
.LC5:
	.string	"player/male/pain25_2.wav"
	.align 2
.LC6:
	.string	"player/male/pain50_1.wav"
	.align 2
.LC7:
	.string	"player/male/pain50_2.wav"
	.align 2
.LC8:
	.string	"player/male/pain75_1.wav"
	.align 2
.LC9:
	.string	"player/male/pain75_2.wav"
	.align 2
.LC10:
	.string	"player/male/pain100_1.wav"
	.align 2
.LC11:
	.string	"player/male/pain100_2.wav"
	.align 2
.LC3:
	.long 0x46fffe00
	.align 2
.LC12:
	.long 0x40400000
	.align 3
.LC13:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC14:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC15:
	.long 0x3f800000
	.align 2
.LC16:
	.long 0x0
	.section	".text"
	.align 2
	.globl maleworker_pain
	.type	 maleworker_pain,@function
maleworker_pain:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	mr 31,3
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	mr 29,4
	lfs 0,464(31)
	fcmpu 0,13,0
	bc 12,0,.L26
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,464(31)
	bl rand
	rlwinm 3,3,0,17,31
	lwz 10,480(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 29,540(31)
	stw 3,20(1)
	lis 11,.LC13@ha
	cmpwi 0,10,24
	la 11,.LC13@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC3@ha
	lfs 12,.LC3@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	bc 12,1,.L28
	lis 9,.LC14@ha
	fmr 13,0
	la 9,.LC14@l(9)
	lfd 0,0(9)
	fmr 31,13
	fcmpu 0,13,0
	bc 4,0,.L29
	lis 29,gi@ha
	lis 3,.LC4@ha
	la 29,gi@l(29)
	la 3,.LC4@l(3)
	lwz 9,36(29)
	b .L44
.L29:
	lis 29,gi@ha
	lis 3,.LC5@ha
	la 29,gi@l(29)
	la 3,.LC5@l(3)
	lwz 9,36(29)
	b .L44
.L28:
	cmpwi 0,10,49
	fmr 31,0
	lis 29,gi@ha
	bc 12,1,.L31
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfd 0,0(9)
	fcmpu 0,31,0
	bc 4,0,.L33
	la 29,gi@l(29)
	lis 3,.LC6@ha
	lwz 9,36(29)
	la 3,.LC6@l(3)
.L44:
	mtlr 9
	blrl
	lis 9,.LC15@ha
	lwz 0,16(29)
	lis 11,.LC15@ha
	la 9,.LC15@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC15@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC16@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC16@l(9)
	lfs 3,0(9)
	blrl
	b .L31
.L33:
	la 29,gi@l(29)
	lis 3,.LC7@ha
	lwz 9,36(29)
	la 3,.LC7@l(3)
	mtlr 9
	blrl
	lis 9,.LC15@ha
	lwz 0,16(29)
	lis 11,.LC15@ha
	la 9,.LC15@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC15@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC16@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC16@l(9)
	lfs 3,0(9)
	blrl
.L31:
	lwz 0,480(31)
	cmpwi 0,0,74
	bc 12,1,.L35
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfd 0,0(9)
	fcmpu 0,31,0
	bc 4,0,.L36
	lis 29,gi@ha
	lis 3,.LC8@ha
	la 29,gi@l(29)
	la 3,.LC8@l(3)
	b .L45
.L36:
	lis 29,gi@ha
	lis 3,.LC9@ha
	la 29,gi@l(29)
	la 3,.LC9@l(3)
	b .L45
.L35:
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfd 0,0(9)
	fcmpu 0,31,0
	bc 4,0,.L39
	lis 29,gi@ha
	lis 3,.LC10@ha
	la 29,gi@l(29)
	la 3,.LC10@l(3)
.L45:
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC15@ha
	lwz 0,16(29)
	lis 11,.LC15@ha
	la 9,.LC15@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC15@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC16@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC16@l(9)
	lfs 3,0(9)
	blrl
	b .L38
.L39:
	lis 29,gi@ha
	lis 3,.LC11@ha
	la 29,gi@l(29)
	la 3,.LC11@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC15@ha
	lwz 0,16(29)
	lis 11,.LC15@ha
	la 9,.LC15@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC15@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC16@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC16@l(9)
	lfs 3,0(9)
	blrl
.L38:
	bl rand
	lis 9,0x5555
	srawi 11,3,31
	ori 9,9,21846
	mulhw 9,3,9
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf. 9,0,3
	bc 12,2,.L46
	cmpwi 0,9,1
	bc 4,2,.L26
.L46:
	lis 9,maleworker_move_pain@ha
	la 9,maleworker_move_pain@l(9)
	stw 9,772(31)
.L26:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 maleworker_pain,.Lfe2-maleworker_pain
	.globl maleworker_frames_death1
	.section	".data"
	.align 2
	.type	 maleworker_frames_death1,@object
maleworker_frames_death1:
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
	.long 0xc1500000
	.long 0
	.long ai_move
	.long 0x41600000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x41600000
	.long 0
	.size	 maleworker_frames_death1,84
	.globl maleworker_move_death1
	.align 2
	.type	 maleworker_move_death1,@object
	.size	 maleworker_move_death1,16
maleworker_move_death1:
	.long 213
	.long 219
	.long maleworker_frames_death1
	.long maleworker_dead
	.globl maleworker_frames_death2
	.align 2
	.type	 maleworker_frames_death2,@object
maleworker_frames_death2:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x40e00000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0xc0c00000
	.long 0
	.long ai_move
	.long 0xc0a00000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x40e00000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0xc0c00000
	.long 0
	.long ai_move
	.long 0xc0a00000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0xc0c00000
	.long 0
	.long ai_move
	.long 0xc0a00000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 maleworker_frames_death2,216
	.globl maleworker_move_death2
	.align 2
	.type	 maleworker_move_death2,@object
	.size	 maleworker_move_death2,16
maleworker_move_death2:
	.long 220
	.long 237
	.long maleworker_frames_death2
	.long maleworker_dead
	.section	".rodata"
	.align 2
.LC17:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC18:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC19:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC21:
	.string	"player/male/death1.wav"
	.align 2
.LC22:
	.string	"player/male/death2.wav"
	.align 2
.LC23:
	.string	"player/male/death3.wav"
	.align 2
.LC24:
	.string	"player/male/death4.wav"
	.align 2
.LC20:
	.long 0x46fffe00
	.align 3
.LC25:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC26:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC27:
	.long 0x3f800000
	.align 2
.LC28:
	.long 0x0
	.align 3
.LC29:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC30:
	.long 0x3fe80000
	.long 0x0
	.section	".text"
	.align 2
	.globl maleworker_die
	.type	 maleworker_die,@function
maleworker_die:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 30,3
	li 0,0
	lwz 9,480(30)
	mr 31,6
	stw 0,44(30)
	cmpwi 0,9,-80
	bc 12,1,.L49
	lis 28,.LC17@ha
	lis 27,.LC18@ha
	li 29,2
.L53:
	mr 3,30
	la 4,.LC17@l(28)
	mr 5,31
	li 6,0
	bl ThrowGib
	addic. 29,29,-1
	bc 4,2,.L53
	li 29,4
.L58:
	mr 3,30
	la 4,.LC18@l(27)
	mr 5,31
	li 6,0
	bl ThrowGib
	addic. 29,29,-1
	bc 4,2,.L58
	lis 4,.LC19@ha
	mr 5,31
	la 4,.LC19@l(4)
	mr 3,30
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,492(30)
	b .L48
.L49:
	lwz 0,492(30)
	cmpwi 0,0,2
	bc 12,2,.L48
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC25@ha
	lis 11,.LC20@ha
	la 10,.LC25@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC26@ha
	lfs 12,.LC20@l(11)
	la 10,.LC26@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L61
	lis 29,gi@ha
	lis 3,.LC21@ha
	la 29,gi@l(29)
	la 3,.LC21@l(3)
	b .L69
.L61:
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L63
	lis 29,gi@ha
	lis 3,.LC22@ha
	la 29,gi@l(29)
	la 3,.LC22@l(3)
	b .L69
.L63:
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L65
	lis 29,gi@ha
	lis 3,.LC23@ha
	la 29,gi@l(29)
	la 3,.LC23@l(3)
.L69:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC27@ha
	lis 10,.LC27@ha
	lis 11,.LC28@ha
	mr 5,3
	la 9,.LC27@l(9)
	la 10,.LC27@l(10)
	mtlr 0
	la 11,.LC28@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L62
.L65:
	lis 29,gi@ha
	lis 3,.LC24@ha
	la 29,gi@l(29)
	la 3,.LC24@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC27@ha
	lis 10,.LC27@ha
	lis 11,.LC28@ha
	mr 5,3
	la 9,.LC27@l(9)
	la 10,.LC27@l(10)
	mtlr 0
	la 11,.LC28@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L62:
	li 0,2
	li 9,1
	stw 0,492(30)
	stw 9,512(30)
	bl rand
	srwi 0,3,31
	add 0,3,0
	rlwinm 0,0,0,0,30
	cmpw 0,3,0
	bc 4,2,.L67
	lis 9,maleworker_move_death1@ha
	la 9,maleworker_move_death1@l(9)
	b .L70
.L67:
	lis 9,maleworker_move_death2@ha
	la 9,maleworker_move_death2@l(9)
.L70:
	stw 9,772(30)
.L48:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 maleworker_die,.Lfe3-maleworker_die
	.globl maleworker_frames_attack
	.section	".data"
	.align 2
	.type	 maleworker_frames_attack,@object
maleworker_frames_attack:
	.long ai_charge
	.long 0xc0000000
	.long 0
	.long ai_charge
	.long 0xc0000000
	.long 0
	.long ai_charge
	.long 0x40400000
	.long 0
	.long ai_charge
	.long 0x40000000
	.long 0
	.long ai_charge
	.long 0xc0000000
	.long 0
	.long ai_charge
	.long 0xc0000000
	.long 0
	.long ai_charge
	.long 0x40400000
	.long 0
	.long ai_charge
	.long 0xc0000000
	.long 0
	.long ai_charge
	.long 0xc0000000
	.long 0
	.long ai_charge
	.long 0x40000000
	.long 0
	.long ai_charge
	.long 0xc0000000
	.long 0
	.size	 maleworker_frames_attack,132
	.globl maleworker_move_attack
	.align 2
	.type	 maleworker_move_attack,@object
	.size	 maleworker_move_attack,16
maleworker_move_attack:
	.long 162
	.long 169
	.long maleworker_frames_attack
	.long maleworker_run
	.section	".rodata"
	.align 2
.LC31:
	.string	"models/npcs/mworker/mworker.md2"
	.align 2
.LC32:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_npc_maleworker
	.type	 SP_npc_maleworker,@function
SP_npc_maleworker:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,deathmatch@ha
	lis 5,.LC32@ha
	lwz 11,deathmatch@l(9)
	la 5,.LC32@l(5)
	mr 31,3
	lfs 13,0(5)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L73
	bl G_FreeEdict
	b .L72
.L73:
	li 9,2
	li 0,5
	lis 11,gi+32@ha
	stw 9,248(31)
	lis 3,.LC31@ha
	stw 0,260(31)
	la 3,.LC31@l(3)
	lwz 0,gi+32@l(11)
	mtlr 0
	blrl
	lwz 9,480(31)
	lis 10,0xc180
	lis 8,0x4180
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
	bc 4,2,.L74
	li 0,20
	stw 0,480(31)
.L74:
	lwz 0,284(31)
	lis 9,maleworker_pain@ha
	lis 11,maleworker_die@ha
	la 9,maleworker_pain@l(9)
	lis 10,maleworker_stand@ha
	lis 8,maleworker_walk@ha
	lis 7,maleworker_run@ha
	stw 9,452(31)
	lis 6,maleworker_attack@ha
	andi. 5,0,4
	li 9,0
	la 11,maleworker_die@l(11)
	la 10,maleworker_stand@l(10)
	la 8,maleworker_walk@l(8)
	stw 11,456(31)
	la 7,maleworker_run@l(7)
	la 6,maleworker_attack@l(6)
	stw 10,788(31)
	li 0,200
	stw 8,800(31)
	stw 0,400(31)
	stw 7,804(31)
	stw 6,812(31)
	stw 9,820(31)
	stw 9,816(31)
	bc 12,2,.L75
	lwz 0,776(31)
	oris 0,0,0x2
	b .L77
.L75:
	lwz 0,776(31)
	oris 0,0,0x1
.L77:
	stw 0,776(31)
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,maleworker_move_stand@ha
	lis 0,0x3f80
	la 9,maleworker_move_stand@l(9)
	stw 0,784(31)
	mr 3,31
	stw 9,772(31)
	bl walkmonster_start
.L72:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 SP_npc_maleworker,.Lfe4-SP_npc_maleworker
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
.LC33:
	.long 0x46fffe00
	.align 3
.LC34:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 3
.LC35:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC36:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl maleworker_AI_stand
	.type	 maleworker_AI_stand,@function
maleworker_AI_stand:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 30,24(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,952(31)
	cmpwi 0,0,10
	bc 12,2,.L6
	bl rand
	lis 30,0x4330
	lis 9,.LC35@ha
	rlwinm 3,3,0,17,31
	la 9,.LC35@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 10,.LC33@ha
	lis 11,.LC34@ha
	lfs 30,.LC33@l(10)
	stw 3,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	lfd 12,.LC34@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L6
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC36@ha
	stw 3,20(1)
	la 11,.LC36@l(11)
	stw 30,16(1)
	lfd 0,16(1)
	lfd 12,0(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L9
	mr 3,31
	li 4,2
	li 5,0
	bl find_action_point
	b .L6
.L9:
	mr 3,31
	li 4,4
	li 5,0
	bl find_action_point
.L6:
	lwz 0,52(1)
	mtlr 0
	lmw 30,24(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 maleworker_AI_stand,.Lfe5-maleworker_AI_stand
	.section	".rodata"
	.align 3
.LC37:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl maleworker_stand
	.type	 maleworker_stand,@function
maleworker_stand:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,maleworker_move_stand@ha
	mr 31,3
	la 9,maleworker_move_stand@l(9)
	lis 11,level+4@ha
	stw 9,772(31)
	lfs 0,level+4@l(11)
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L12
	bl rand
	lwz 10,772(31)
	lwz 11,0(10)
	lwz 9,4(10)
	subf 9,11,9
	addi 9,9,1
	divw 0,3,9
	mullw 0,0,9
	subf 3,0,3
	add 11,11,3
	stw 11,56(31)
.L12:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 maleworker_stand,.Lfe6-maleworker_stand
	.align 2
	.globl maleworker_walk
	.type	 maleworker_walk,@function
maleworker_walk:
	lis 9,maleworker_move_walk@ha
	la 9,maleworker_move_walk@l(9)
	stw 9,772(3)
	blr
.Lfe7:
	.size	 maleworker_walk,.Lfe7-maleworker_walk
	.align 2
	.globl maleworker_dead
	.type	 maleworker_dead,@function
maleworker_dead:
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
.Lfe8:
	.size	 maleworker_dead,.Lfe8-maleworker_dead
	.align 2
	.globl maleworker_attack
	.type	 maleworker_attack,@function
maleworker_attack:
	lis 9,maleworker_move_attack@ha
	la 9,maleworker_move_attack@l(9)
	stw 9,772(3)
	blr
.Lfe9:
	.size	 maleworker_attack,.Lfe9-maleworker_attack
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
