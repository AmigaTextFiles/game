	.file	"m_actor.c"
gcc2_compiled.:
	.globl actor_names
	.section	".data"
	.align 2
	.type	 actor_names,@object
	.size	 actor_names,32
actor_names:
	.long .LC0
	.long .LC1
	.long .LC2
	.long .LC3
	.long .LC4
	.long .LC5
	.long .LC6
	.long .LC7
	.section	".rodata"
	.align 2
.LC7:
	.string	"Bitterman"
	.align 2
.LC6:
	.string	"Titus"
	.align 2
.LC5:
	.string	"Rambear"
	.align 2
.LC4:
	.string	"Adrianator"
	.align 2
.LC3:
	.string	"Disruptor"
	.align 2
.LC2:
	.string	"Killme"
	.align 2
.LC1:
	.string	"Tokay"
	.align 2
.LC0:
	.string	"Hellrot"
	.globl actor_frames_stand
	.section	".data"
	.align 2
	.type	 actor_frames_stand,@object
actor_frames_stand:
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
	.size	 actor_frames_stand,480
	.globl actor_move_stand
	.align 2
	.type	 actor_move_stand,@object
	.size	 actor_move_stand,16
actor_move_stand:
	.long 128
	.long 167
	.long actor_frames_stand
	.long 0
	.globl actor_frames_walk
	.align 2
	.type	 actor_frames_walk,@object
actor_frames_walk:
	.long ai_walk
	.long 0x0
	.long 0
	.long ai_walk
	.long 0x40c00000
	.long 0
	.long ai_walk
	.long 0x41200000
	.long 0
	.long ai_walk
	.long 0x40400000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x40e00000
	.long 0
	.long ai_walk
	.long 0x41200000
	.long 0
	.long ai_walk
	.long 0x3f800000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x0
	.long 0
	.long ai_walk
	.long 0x0
	.long 0
	.size	 actor_frames_walk,132
	.globl actor_move_walk
	.align 2
	.type	 actor_move_walk,@object
	.size	 actor_move_walk,16
actor_move_walk:
	.long 251
	.long 258
	.long actor_frames_walk
	.long 0
	.globl actor_frames_run
	.align 2
	.type	 actor_frames_run,@object
actor_frames_run:
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
	.long ai_run
	.long 0x41000000
	.long 0
	.long ai_run
	.long 0x41880000
	.long 0
	.long ai_run
	.long 0x41400000
	.long 0
	.long ai_run
	.long 0xc0000000
	.long 0
	.long ai_run
	.long 0xc0000000
	.long 0
	.long ai_run
	.long 0xbf800000
	.long 0
	.size	 actor_frames_run,144
	.globl actor_move_run
	.align 2
	.type	 actor_move_run,@object
	.size	 actor_move_run,16
actor_move_run:
	.long 93
	.long 98
	.long actor_frames_run
	.long 0
	.section	".rodata"
	.align 3
.LC8:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl actor_run
	.type	 actor_run,@function
actor_run:
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
	bc 4,0,.L10
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L10
	lwz 0,416(31)
	cmpwi 0,0,0
	bc 12,2,.L11
	lis 9,actor_move_walk@ha
	la 9,actor_move_walk@l(9)
	b .L19
.L11:
	lis 9,actor_move_stand@ha
	lis 10,.LC8@ha
	la 9,actor_move_stand@l(9)
	la 10,.LC8@l(10)
	stw 9,788(31)
	lfs 0,4(11)
	b .L20
.L10:
	lwz 0,792(31)
	andi. 9,0,1
	bc 12,2,.L16
	lis 9,actor_move_stand@ha
	lis 11,level+4@ha
	la 9,actor_move_stand@l(9)
	lis 10,.LC8@ha
	stw 9,788(31)
	la 10,.LC8@l(10)
	lfs 0,level+4@l(11)
.L20:
	lfd 13,0(10)
	fcmpu 0,0,13
	bc 4,0,.L9
	bl rand
	lwz 10,788(31)
	lwz 11,0(10)
	lwz 9,4(10)
	subf 9,11,9
	addi 9,9,1
	divw 0,3,9
	mullw 0,0,9
	subf 3,0,3
	add 11,11,3
	stw 11,56(31)
	b .L9
.L16:
	lis 9,actor_move_run@ha
	la 9,actor_move_run@l(9)
.L19:
	stw 9,788(31)
.L9:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 actor_run,.Lfe1-actor_run
	.globl actor_frames_pain1
	.section	".data"
	.align 2
	.type	 actor_frames_pain1,@object
actor_frames_pain1:
	.long ai_move
	.long 0xc0a00000
	.long 0
	.long ai_move
	.long 0x40800000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.size	 actor_frames_pain1,36
	.globl actor_move_pain1
	.align 2
	.type	 actor_move_pain1,@object
	.size	 actor_move_pain1,16
actor_move_pain1:
	.long 74
	.long 76
	.long actor_frames_pain1
	.long actor_run
	.globl actor_frames_pain2
	.align 2
	.type	 actor_frames_pain2,@object
actor_frames_pain2:
	.long ai_move
	.long 0xc0800000
	.long 0
	.long ai_move
	.long 0x40800000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 actor_frames_pain2,36
	.globl actor_move_pain2
	.align 2
	.type	 actor_move_pain2,@object
	.size	 actor_move_pain2,16
actor_move_pain2:
	.long 77
	.long 79
	.long actor_frames_pain2
	.long actor_run
	.globl actor_frames_pain3
	.align 2
	.type	 actor_frames_pain3,@object
actor_frames_pain3:
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 actor_frames_pain3,36
	.globl actor_move_pain3
	.align 2
	.type	 actor_move_pain3,@object
	.size	 actor_move_pain3,16
actor_move_pain3:
	.long 80
	.long 82
	.long actor_frames_pain3
	.long actor_run
	.globl actor_frames_flipoff
	.align 2
	.type	 actor_frames_flipoff,@object
actor_frames_flipoff:
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.size	 actor_frames_flipoff,168
	.globl actor_move_flipoff
	.align 2
	.type	 actor_move_flipoff,@object
	.size	 actor_move_flipoff,16
actor_move_flipoff:
	.long 39
	.long 52
	.long actor_frames_flipoff
	.long actor_run
	.globl actor_frames_taunt
	.align 2
	.type	 actor_frames_taunt,@object
actor_frames_taunt:
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.long ai_turn
	.long 0x0
	.long 0
	.size	 actor_frames_taunt,204
	.globl actor_move_taunt
	.align 2
	.type	 actor_move_taunt,@object
	.size	 actor_move_taunt,16
actor_move_taunt:
	.long 234
	.long 250
	.long actor_frames_taunt
	.long actor_run
	.globl messages
	.align 2
	.type	 messages,@object
messages:
	.long .LC9
	.long .LC10
	.long .LC11
	.long .LC12
	.section	".rodata"
	.align 2
.LC12:
	.string	"Check your targets"
	.align 2
.LC11:
	.string	"Idiot"
	.align 2
.LC10:
	.string	"#$@*&"
	.align 2
.LC9:
	.string	"Watch it"
	.size	 messages,16
	.align 2
.LC15:
	.string	"%s: %s!\n"
	.align 2
.LC13:
	.long 0x46fffe00
	.align 3
.LC14:
	.long 0x3fd99999
	.long 0x9999999a
	.align 2
.LC16:
	.long 0x40400000
	.align 3
.LC17:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC18:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl actor_pain
	.type	 actor_pain,@function
actor_pain:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 27,44(1)
	stw 0,84(1)
	mr 28,3
	mr 31,4
	lwz 0,484(28)
	lwz 11,480(28)
	srwi 9,0,31
	add 0,0,9
	srawi 0,0,1
	cmpw 0,11,0
	bc 4,0,.L22
	li 0,1
	stw 0,60(28)
.L22:
	lis 9,level+4@ha
	lfs 0,464(28)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L21
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,464(28)
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L24
	bl rand
	lis 29,0x4330
	lis 9,.LC17@ha
	rlwinm 3,3,0,17,31
	la 9,.LC17@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 10,.LC13@ha
	lis 11,.LC14@ha
	lfs 30,.LC13@l(10)
	stw 3,36(1)
	stw 29,32(1)
	lfd 0,32(1)
	lfd 12,.LC14@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L24
	lfs 11,4(28)
	addi 3,1,8
	lfs 12,4(31)
	lfs 10,8(28)
	lfs 13,8(31)
	fsubs 12,12,11
	lfs 0,12(31)
	lfs 11,12(28)
	fsubs 13,13,10
	stfs 12,8(1)
	fsubs 0,0,11
	stfs 13,12(1)
	stfs 0,16(1)
	bl vectoyaw
	stfs 1,424(28)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC18@ha
	stw 3,36(1)
	la 11,.LC18@l(11)
	stw 29,32(1)
	lfd 0,32(1)
	lfd 12,0(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L25
	lis 9,actor_move_flipoff@ha
	la 9,actor_move_flipoff@l(9)
	b .L31
.L25:
	lis 9,actor_move_taunt@ha
	la 9,actor_move_taunt@l(9)
.L31:
	stw 9,788(28)
	lis 11,g_edicts@ha
	lis 0,0xcb12
	lwz 9,g_edicts@l(11)
	ori 0,0,23781
	lis 29,gi@ha
	lis 11,actor_names@ha
	la 29,gi@l(29)
	subf 9,9,28
	la 11,actor_names@l(11)
	mullw 9,9,0
	lis 28,messages@ha
	la 28,messages@l(28)
	srawi 0,9,31
	srawi 9,9,2
	srwi 0,0,29
	add 0,9,0
	rlwinm 0,0,0,0,28
	subf 9,0,9
	slwi 9,9,2
	lwzx 27,11,9
	bl rand
	lis 9,0x5555
	mr 11,3
	lwz 10,8(29)
	ori 9,9,21846
	srawi 0,11,31
	mulhw 9,11,9
	lis 5,.LC15@ha
	mr 3,31
	mtlr 10
	la 5,.LC15@l(5)
	mr 6,27
	subf 9,0,9
	li 4,3
	slwi 0,9,1
	add 0,0,9
	subf 11,0,11
	slwi 11,11,2
	lwzx 7,28,11
	crxor 6,6,6
	blrl
	b .L21
.L24:
	bl rand
	lis 9,0x5555
	srawi 11,3,31
	ori 9,9,21846
	mulhw 9,3,9
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf. 9,0,3
	bc 4,2,.L27
	lis 9,actor_move_pain1@ha
	la 9,actor_move_pain1@l(9)
	b .L32
.L27:
	cmpwi 0,9,1
	bc 4,2,.L29
	lis 9,actor_move_pain2@ha
	la 9,actor_move_pain2@l(9)
	b .L32
.L29:
	lis 9,actor_move_pain3@ha
	la 9,actor_move_pain3@l(9)
.L32:
	stw 9,788(28)
.L21:
	lwz 0,84(1)
	mtlr 0
	lmw 27,44(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe2:
	.size	 actor_pain,.Lfe2-actor_pain
	.section	".rodata"
	.align 2
.LC19:
	.long 0xbe4ccccd
	.align 3
.LC20:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC21:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl actorMachineGun
	.type	 actorMachineGun,@function
actorMachineGun:
	stwu 1,-112(1)
	mflr 0
	stmw 27,92(1)
	stw 0,116(1)
	mr 31,3
	addi 29,1,40
	addi 28,1,56
	addi 30,31,16
	mr 4,29
	mr 3,30
	mr 5,28
	li 6,0
	bl AngleVectors
	mr 27,29
	lis 4,monster_flash_offset+756@ha
	addi 3,31,4
	mr 6,28
	la 4,monster_flash_offset+756@l(4)
	mr 5,29
	addi 7,1,8
	bl G_ProjectSource
	lwz 3,540(31)
	cmpwi 0,3,0
	bc 12,2,.L34
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L35
	lis 9,.LC19@ha
	addi 4,3,376
	lfs 1,.LC19@l(9)
	addi 3,3,4
	addi 5,1,24
	bl VectorMA
	lwz 11,540(31)
	lis 10,0x4330
	lis 8,.LC20@ha
	lfs 13,32(1)
	lwz 0,508(11)
	la 8,.LC20@l(8)
	lfd 12,0(8)
	xoris 0,0,0x8000
	stw 0,84(1)
	stw 10,80(1)
	lfd 0,80(1)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,32(1)
	b .L36
.L35:
	lfs 13,212(3)
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 12,0(9)
	stfs 13,24(1)
	lfs 0,216(3)
	stfs 0,28(1)
	lfs 13,220(3)
	stfs 13,32(1)
	lfs 0,244(3)
	fmadds 0,0,12,13
	stfs 0,32(1)
.L36:
	lfs 11,8(1)
	mr 3,27
	lfs 12,24(1)
	lfs 13,28(1)
	lfs 10,12(1)
	fsubs 12,12,11
	lfs 0,32(1)
	lfs 11,16(1)
	fsubs 13,13,10
	stfs 12,40(1)
	fsubs 0,0,11
	stfs 13,44(1)
	stfs 0,48(1)
	bl VectorNormalize
	b .L37
.L34:
	mr 3,30
	mr 4,27
	li 5,0
	li 6,0
	bl AngleVectors
.L37:
	mr 3,31
	mr 5,27
	addi 4,1,8
	li 6,3
	li 7,4
	li 8,300
	li 9,500
	li 10,63
	bl monster_fire_bullet
	lwz 0,116(1)
	mtlr 0
	lmw 27,92(1)
	la 1,112(1)
	blr
.Lfe3:
	.size	 actorMachineGun,.Lfe3-actorMachineGun
	.globl actor_frames_death1
	.section	".data"
	.align 2
	.type	 actor_frames_death1,@object
actor_frames_death1:
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
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.size	 actor_frames_death1,84
	.globl actor_move_death1
	.align 2
	.type	 actor_move_death1,@object
	.size	 actor_move_death1,16
actor_move_death1:
	.long 4
	.long 10
	.long actor_frames_death1
	.long actor_dead
	.globl actor_frames_death2
	.align 2
	.type	 actor_frames_death2,@object
actor_frames_death2:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x40e00000
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
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xc1100000
	.long 0
	.long ai_move
	.long 0xc1500000
	.long 0
	.long ai_move
	.long 0xc1500000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 actor_frames_death2,156
	.globl actor_move_death2
	.align 2
	.type	 actor_move_death2,@object
	.size	 actor_move_death2,16
actor_move_death2:
	.long 11
	.long 23
	.long actor_frames_death2
	.long actor_dead
	.section	".rodata"
	.align 2
.LC22:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC23:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC24:
	.string	"models/objects/gibs/head2/tris.md2"
	.globl actor_frames_attack
	.section	".data"
	.align 2
	.type	 actor_frames_attack,@object
actor_frames_attack:
	.long ai_charge
	.long 0xc0000000
	.long actor_fire
	.long ai_charge
	.long 0xc0000000
	.long 0
	.long ai_charge
	.long 0x40400000
	.long 0
	.long ai_charge
	.long 0x40000000
	.long 0
	.size	 actor_frames_attack,48
	.globl actor_move_attack
	.align 2
	.type	 actor_move_attack,@object
	.size	 actor_move_attack,16
actor_move_attack:
	.long 0
	.long 3
	.long actor_frames_attack
	.long actor_run
	.section	".rodata"
	.align 2
.LC26:
	.string	"target_actor"
	.align 2
.LC27:
	.string	"%s has bad target %s at %s\n"
	.align 2
.LC29:
	.string	"untargeted %s at %s\n"
	.align 2
.LC30:
	.string	"%s with no target at %s\n"
	.align 2
.LC31:
	.string	"players/male/tris.md2"
	.align 2
.LC32:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_misc_actor
	.type	 SP_misc_actor,@function
SP_misc_actor:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC32@ha
	lis 9,deathmatch@ha
	la 11,.LC32@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L62
	bl G_FreeEdict
	b .L61
.L62:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L63
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC29@ha
	la 3,.LC29@l(3)
	b .L66
.L63:
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L64
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC30@ha
	la 3,.LC30@l(3)
.L66:
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L61
.L64:
	li 0,5
	li 11,2
	lis 9,gi@ha
	stw 0,260(31)
	lis 3,.LC31@ha
	stw 11,248(31)
	la 29,gi@l(9)
	la 3,.LC31@l(3)
	lwz 9,32(29)
	mtlr 9
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
	bc 4,2,.L65
	li 0,100
	stw 0,480(31)
.L65:
	lis 9,actor_pain@ha
	lwz 5,792(31)
	lis 11,actor_die@ha
	la 9,actor_pain@l(9)
	lis 10,actor_stand@ha
	stw 9,452(31)
	lis 8,actor_walk@ha
	lis 7,actor_run@ha
	lis 6,actor_attack@ha
	li 9,0
	la 11,actor_die@l(11)
	la 10,actor_stand@l(10)
	stw 9,836(31)
	la 8,actor_walk@l(8)
	la 7,actor_run@l(7)
	stw 11,456(31)
	la 6,actor_attack@l(6)
	ori 5,5,256
	stw 10,804(31)
	li 0,200
	stw 8,816(31)
	mr 3,31
	stw 7,820(31)
	stw 6,828(31)
	stw 5,792(31)
	stw 9,832(31)
	stw 0,400(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lis 9,actor_move_stand@ha
	lis 0,0x3f80
	la 9,actor_move_stand@l(9)
	stw 0,800(31)
	mr 3,31
	stw 9,788(31)
	bl walkmonster_start
	lis 9,actor_use@ha
	la 9,actor_use@l(9)
	stw 9,448(31)
.L61:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 SP_misc_actor,.Lfe4-SP_misc_actor
	.section	".rodata"
	.align 2
.LC33:
	.string	"%s: %s\n"
	.align 2
.LC34:
	.string	"player/male/jump1.wav"
	.align 2
.LC35:
	.long 0x4cbebc20
	.align 2
.LC36:
	.long 0x3f800000
	.align 2
.LC37:
	.long 0x0
	.align 3
.LC38:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl target_actor_touch
	.type	 target_actor_touch,@function
target_actor_touch:
	stwu 1,-64(1)
	mflr 0
	stmw 22,24(1)
	stw 0,68(1)
	mr 31,4
	mr 30,3
	lwz 0,416(31)
	cmpw 0,0,30
	bc 4,2,.L67
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L67
	stw 0,412(31)
	stw 0,416(31)
	lwz 0,276(30)
	cmpwi 0,0,0
	bc 12,2,.L70
	lis 9,game@ha
	li 28,1
	la 10,game@l(9)
	lwz 0,1544(10)
	cmpw 0,28,0
	bc 12,1,.L70
	lis 9,gi@ha
	lis 11,actor_names@ha
	lis 29,0xcb12
	la 22,gi@l(9)
	la 23,actor_names@l(11)
	mr 24,10
	lis 25,g_edicts@ha
	ori 29,29,23781
	lis 26,.LC33@ha
	li 27,948
.L74:
	lwz 9,g_edicts@l(25)
	add 3,9,27
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L73
	subf 9,9,31
	lwz 11,8(22)
	li 4,3
	mullw 9,9,29
	la 5,.LC33@l(26)
	lwz 7,276(30)
	mtlr 11
	srawi 0,9,31
	srawi 9,9,2
	srwi 0,0,29
	add 0,9,0
	rlwinm 0,0,0,0,28
	subf 9,0,9
	slwi 9,9,2
	lwzx 6,23,9
	crxor 6,6,6
	blrl
.L73:
	lwz 0,1544(24)
	addi 28,28,1
	addi 27,27,948
	cmpw 0,28,0
	bc 4,1,.L74
.L70:
	lwz 0,284(30)
	andi. 9,0,1
	bc 12,2,.L77
	lfs 0,328(30)
	lfs 13,340(30)
	lwz 0,552(31)
	fmuls 13,13,0
	cmpwi 0,0,0
	stfs 13,376(31)
	lfs 0,344(30)
	lfs 13,328(30)
	fmuls 0,0,13
	stfs 0,380(31)
	bc 12,2,.L77
	li 0,0
	lis 29,gi@ha
	stw 0,552(31)
	la 29,gi@l(29)
	lis 3,.LC34@ha
	lfs 0,348(30)
	la 3,.LC34@l(3)
	stfs 0,384(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC36@ha
	lwz 0,16(29)
	lis 10,.LC36@ha
	la 9,.LC36@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC36@l(10)
	li 4,2
	mtlr 0
	lis 9,.LC37@ha
	mr 3,31
	lfs 2,0(10)
	la 9,.LC37@l(9)
	lfs 3,0(9)
	blrl
.L77:
	lwz 0,284(30)
	andi. 9,0,2
	bc 4,2,.L80
	andi. 10,0,4
	bc 12,2,.L80
	lwz 3,312(30)
	bl G_PickTarget
	cmpwi 0,3,0
	stw 3,540(31)
	bc 12,2,.L80
	stw 3,412(31)
	lwz 0,284(30)
	andi. 9,0,32
	bc 12,2,.L83
	lwz 0,792(31)
	ori 0,0,512
	stw 0,792(31)
.L83:
	lwz 0,284(30)
	andi. 10,0,16
	bc 12,2,.L84
	lwz 0,792(31)
	lis 9,actor_move_stand@ha
	lis 11,level+4@ha
	la 9,actor_move_stand@l(9)
	lis 10,.LC38@ha
	ori 0,0,1
	stw 9,788(31)
	la 10,.LC38@l(10)
	stw 0,792(31)
	lfs 0,level+4@l(11)
	lfd 13,0(10)
	fcmpu 0,0,13
	bc 4,0,.L80
	bl rand
	lwz 10,788(31)
	lwz 11,0(10)
	lwz 9,4(10)
	subf 9,11,9
	addi 9,9,1
	divw 0,3,9
	mullw 0,0,9
	subf 3,0,3
	add 11,11,3
	stw 11,56(31)
	b .L80
.L84:
	mr 3,31
	bl actor_run
.L80:
	lwz 0,284(30)
	andi. 9,0,6
	bc 4,2,.L88
	lwz 0,312(30)
	cmpwi 0,0,0
	bc 12,2,.L88
	lwz 29,296(30)
	mr 3,30
	mr 4,31
	stw 0,296(30)
	bl G_UseTargets
	stw 29,296(30)
.L88:
	lwz 3,296(30)
	bl G_PickTarget
	lwz 0,412(31)
	stw 3,416(31)
	cmpwi 0,0,0
	bc 4,2,.L89
	stw 3,412(31)
.L89:
	lwz 0,416(31)
	cmpwi 0,0,0
	mr 9,0
	bc 4,2,.L90
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L90
	lis 9,level+4@ha
	lis 11,.LC35@ha
	lwz 10,804(31)
	lfs 0,level+4@l(9)
	mr 3,31
	lfs 13,.LC35@l(11)
	mtlr 10
	fadds 0,0,13
	stfs 0,844(31)
	blrl
	b .L67
.L90:
	lwz 0,412(31)
	cmpw 0,9,0
	bc 4,2,.L67
	lfs 0,4(31)
	addi 3,1,8
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
.L67:
	lwz 0,68(1)
	mtlr 0
	lmw 22,24(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 target_actor_touch,.Lfe5-target_actor_touch
	.section	".rodata"
	.align 2
.LC39:
	.string	"%s with no targetname at %s\n"
	.align 2
.LC40:
	.long 0x0
	.align 3
.LC41:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_target_actor
	.type	 SP_target_actor,@function
SP_target_actor:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L94
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC39@ha
	la 3,.LC39@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L94:
	lwz 8,284(31)
	lis 9,target_actor_touch@ha
	lis 11,0xc100
	lis 10,0x4100
	la 9,target_actor_touch@l(9)
	stw 11,196(31)
	andi. 0,8,1
	stw 9,444(31)
	li 0,1
	stw 10,208(31)
	stw 0,184(31)
	stw 0,248(31)
	stw 11,188(31)
	stw 11,192(31)
	stw 10,200(31)
	stw 10,204(31)
	bc 12,2,.L95
	lis 9,.LC40@ha
	lfs 0,328(31)
	la 9,.LC40@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L96
	lis 0,0x4348
	stw 0,328(31)
.L96:
	lis 9,st@ha
	la 29,st@l(9)
	lwz 0,32(29)
	cmpwi 0,0,0
	bc 4,2,.L97
	li 0,200
	stw 0,32(29)
.L97:
	lfs 0,20(31)
	fcmpu 0,0,13
	bc 4,2,.L98
	lis 0,0x43b4
	stw 0,20(31)
.L98:
	addi 3,31,16
	addi 4,31,340
	bl G_SetMovedir
	lwz 0,32(29)
	lis 11,0x4330
	lis 10,.LC41@ha
	xoris 0,0,0x8000
	la 10,.LC41@l(10)
	stw 0,12(1)
	stw 11,8(1)
	lfd 13,0(10)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,348(31)
.L95:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 SP_target_actor,.Lfe6-SP_target_actor
	.section	".rodata"
	.align 3
.LC42:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl actor_stand
	.type	 actor_stand,@function
actor_stand:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,actor_move_stand@ha
	mr 31,3
	la 9,actor_move_stand@l(9)
	lis 11,level+4@ha
	stw 9,788(31)
	lfs 0,level+4@l(11)
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L7
	bl rand
	lwz 10,788(31)
	lwz 11,0(10)
	lwz 9,4(10)
	subf 9,11,9
	addi 9,9,1
	divw 0,3,9
	mullw 0,0,9
	subf 3,0,3
	add 11,11,3
	stw 11,56(31)
.L7:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 actor_stand,.Lfe7-actor_stand
	.align 2
	.globl actor_walk
	.type	 actor_walk,@function
actor_walk:
	lis 9,actor_move_walk@ha
	la 9,actor_move_walk@l(9)
	stw 9,788(3)
	blr
.Lfe8:
	.size	 actor_walk,.Lfe8-actor_walk
	.align 2
	.globl actor_dead
	.type	 actor_dead,@function
actor_dead:
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
.Lfe9:
	.size	 actor_dead,.Lfe9-actor_dead
	.align 2
	.globl actor_die
	.type	 actor_die,@function
actor_die:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 30,3
	mr 29,6
	lwz 0,480(30)
	cmpwi 0,0,-80
	bc 12,1,.L40
	lis 28,.LC22@ha
	lis 27,.LC23@ha
	li 31,2
.L44:
	mr 3,30
	la 4,.LC22@l(28)
	mr 5,29
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L44
	li 31,4
.L49:
	mr 3,30
	la 4,.LC23@l(27)
	mr 5,29
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L49
	lis 4,.LC24@ha
	mr 5,29
	la 4,.LC24@l(4)
	mr 3,30
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,492(30)
	b .L39
.L40:
	lwz 0,492(30)
	cmpwi 0,0,2
	bc 12,2,.L39
	li 0,2
	li 9,1
	stw 0,492(30)
	stw 9,512(30)
	bl rand
	srwi 0,3,31
	add 0,3,0
	rlwinm 0,0,0,0,30
	cmpw 0,3,0
	bc 4,2,.L52
	lis 9,actor_move_death1@ha
	la 9,actor_move_death1@l(9)
	b .L99
.L52:
	lis 9,actor_move_death2@ha
	la 9,actor_move_death2@l(9)
.L99:
	stw 9,788(30)
.L39:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 actor_die,.Lfe10-actor_die
	.align 2
	.globl actor_fire
	.type	 actor_fire,@function
actor_fire:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl actorMachineGun
	lis 9,level+4@ha
	lfs 13,844(31)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L55
	lwz 0,792(31)
	rlwinm 0,0,0,25,23
	b .L100
.L55:
	lwz 0,792(31)
	ori 0,0,128
.L100:
	stw 0,792(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 actor_fire,.Lfe11-actor_fire
	.section	".rodata"
	.align 3
.LC43:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC44:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl actor_attack
	.type	 actor_attack,@function
actor_attack:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,actor_move_attack@ha
	mr 29,3
	la 9,actor_move_attack@l(9)
	stw 9,788(29)
	bl rand
	rlwinm 3,3,0,28,31
	addi 3,3,10
	lis 0,0x4330
	xoris 3,3,0x8000
	lis 11,.LC44@ha
	stw 3,28(1)
	la 11,.LC44@l(11)
	lis 10,level+4@ha
	stw 0,24(1)
	lfd 11,0(11)
	lfs 13,level+4@l(10)
	lis 11,.LC43@ha
	lfd 0,24(1)
	lfd 12,.LC43@l(11)
	fsub 0,0,11
	fmadd 0,0,12,13
	frsp 0,0
	stfs 0,844(29)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 actor_attack,.Lfe12-actor_attack
	.section	".rodata"
	.align 2
.LC45:
	.long 0x4cbebc20
	.section	".text"
	.align 2
	.globl actor_use
	.type	 actor_use,@function
actor_use:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 31,3
	lwz 3,296(31)
	bl G_PickTarget
	cmpwi 0,3,0
	stw 3,416(31)
	stw 3,412(31)
	bc 12,2,.L60
	lwz 3,280(3)
	lis 4,.LC26@ha
	la 4,.LC26@l(4)
	bl strcmp
	mr. 29,3
	bc 12,2,.L59
.L60:
	lis 29,gi@ha
	lwz 27,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	lwz 28,296(31)
	bl vtos
	mr 6,3
	lwz 0,4(29)
	mr 5,28
	lis 3,.LC27@ha
	mr 4,27
	mtlr 0
	la 3,.LC27@l(3)
	crxor 6,6,6
	blrl
	lwz 11,804(31)
	lis 9,.LC45@ha
	mr 3,31
	lfs 0,.LC45@l(9)
	li 0,0
	mtlr 11
	stw 0,296(31)
	stfs 0,844(31)
	blrl
	b .L58
.L59:
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
	lwz 9,816(31)
	mr 3,31
	stfs 1,424(31)
	mtlr 9
	stfs 1,20(31)
	blrl
	stw 29,296(31)
.L58:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 actor_use,.Lfe13-actor_use
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
