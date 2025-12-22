	.file	"m_jawa.c"
gcc2_compiled.:
	.globl jawa_frames_stand2
	.section	".data"
	.align 2
	.type	 jawa_frames_stand2,@object
jawa_frames_stand2:
	.long ai_stand
	.long 0x0
	.long 0
	.size	 jawa_frames_stand2,12
	.globl jawa_move_stand2
	.align 2
	.type	 jawa_move_stand2,@object
	.size	 jawa_move_stand2,16
jawa_move_stand2:
	.long 0
	.long 0
	.long jawa_frames_stand2
	.long jawa_stand
	.globl jawa_frames_stand1
	.align 2
	.type	 jawa_frames_stand1,@object
jawa_frames_stand1:
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
	.size	 jawa_frames_stand1,180
	.globl jawa_move_stand1
	.align 2
	.type	 jawa_move_stand1,@object
	.size	 jawa_move_stand1,16
jawa_move_stand1:
	.long 0
	.long 14
	.long jawa_frames_stand1
	.long jawa_stand
	.globl jawa_frames_walk1
	.align 2
	.type	 jawa_frames_walk1,@object
jawa_frames_walk1:
	.long ai_walk
	.long 0x40400000
	.long 0
	.long ai_walk
	.long 0x40c00000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x3f800000
	.long 0
	.size	 jawa_frames_walk1,72
	.globl jawa_move_walk1
	.align 2
	.type	 jawa_move_walk1,@object
	.size	 jawa_move_walk1,16
jawa_move_walk1:
	.long 16
	.long 21
	.long jawa_frames_walk1
	.long 0
	.globl jawa_frames_run1
	.align 2
	.type	 jawa_frames_run1,@object
jawa_frames_run1:
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41300000
	.long 0
	.long ai_run
	.long 0x41300000
	.long 0
	.long ai_run
	.long 0x41800000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41700000
	.long 0
	.size	 jawa_frames_run1,72
	.globl jawa_move_run1
	.align 2
	.type	 jawa_move_run1,@object
	.size	 jawa_move_run1,16
jawa_move_run1:
	.long 16
	.long 21
	.long jawa_frames_run1
	.long 0
	.globl jawa_frames_pain1
	.align 2
	.type	 jawa_frames_pain1,@object
jawa_frames_pain1:
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
	.size	 jawa_frames_pain1,48
	.globl jawa_move_pain1
	.align 2
	.type	 jawa_move_pain1,@object
	.size	 jawa_move_pain1,16
jawa_move_pain1:
	.long 27
	.long 30
	.long jawa_frames_pain1
	.long jawa_run
	.globl jawa_frames_pain2
	.align 2
	.type	 jawa_frames_pain2,@object
jawa_frames_pain2:
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
	.size	 jawa_frames_pain2,60
	.globl jawa_move_pain2
	.align 2
	.type	 jawa_move_pain2,@object
	.size	 jawa_move_pain2,16
jawa_move_pain2:
	.long 31
	.long 35
	.long jawa_frames_pain2
	.long jawa_run
	.section	".rodata"
	.align 2
.LC3:
	.long 0x46fffe00
	.align 3
.LC4:
	.long 0x408f4000
	.long 0x0
	.align 3
.LC5:
	.long 0x407f4000
	.long 0x0
	.align 3
.LC6:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC7:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC8:
	.long 0x46000000
	.align 2
.LC9:
	.long 0x0
	.align 2
.LC10:
	.long 0x447a0000
	.section	".text"
	.align 2
	.globl jawa_fire
	.type	 jawa_fire,@function
jawa_fire:
	stwu 1,-272(1)
	mflr 0
	stfd 27,232(1)
	stfd 28,240(1)
	stfd 29,248(1)
	stfd 30,256(1)
	stfd 31,264(1)
	stmw 23,196(1)
	stw 0,276(1)
	addi 29,1,24
	addi 27,1,40
	mr 31,3
	mr 4,29
	addi 3,31,16
	mr 5,27
	li 6,0
	lis 30,0x4330
	bl AngleVectors
	mr 23,29
	lis 9,.LC6@ha
	lis 4,monster_flash_offset@ha
	la 9,.LC6@l(9)
	la 4,monster_flash_offset@l(4)
	addi 24,1,72
	addi 7,1,8
	lfd 27,0(9)
	mr 5,29
	mr 6,27
	addi 4,4,468
	addi 3,31,4
	bl G_ProjectSource
	lwz 9,540(31)
	lis 10,.LC7@ha
	lfs 13,8(1)
	addi 26,1,88
	la 10,.LC7@l(10)
	lfs 12,4(9)
	addi 28,1,104
	addi 25,1,56
	lfs 10,12(1)
	mr 3,24
	mr 4,26
	lfs 11,16(1)
	stfs 12,104(1)
	lfs 0,8(9)
	fsubs 12,12,13
	lfd 28,0(10)
	stfs 0,108(1)
	lfs 13,12(9)
	fsubs 0,0,10
	stfs 13,112(1)
	lwz 0,508(9)
	stfs 0,76(1)
	xoris 0,0,0x8000
	stfs 12,72(1)
	stw 0,188(1)
	stw 30,184(1)
	lfd 0,184(1)
	fsub 0,0,27
	frsp 0,0
	fadds 13,13,0
	fsubs 11,13,11
	stfs 13,112(1)
	stfs 11,80(1)
	bl vectoangles
	mr 6,25
	mr 4,29
	mr 5,27
	mr 3,26
	bl AngleVectors
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC3@ha
	stw 3,188(1)
	lis 11,.LC4@ha
	stw 30,184(1)
	lfd 0,184(1)
	lfs 29,.LC3@l(10)
	lfd 13,.LC4@l(11)
	fsub 0,0,27
	frsp 0,0
	fdivs 0,0,29
	fmr 30,0
	fsub 30,30,28
	fadd 30,30,30
	fmul 30,30,13
	frsp 30,30
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC5@ha
	stw 3,188(1)
	lis 10,.LC8@ha
	mr 4,29
	stw 30,184(1)
	la 10,.LC8@l(10)
	addi 3,1,8
	lfd 0,184(1)
	mr 5,28
	lfd 13,.LC5@l(11)
	lfs 1,0(10)
	fsub 0,0,27
	frsp 0,0
	fdivs 0,0,29
	fmr 31,0
	fsub 31,31,28
	fadd 31,31,31
	fmul 31,31,13
	frsp 31,31
	bl VectorMA
	fmr 1,30
	mr 4,27
	mr 3,28
	mr 5,28
	bl VectorMA
	fmr 1,31
	mr 3,28
	mr 4,25
	mr 5,3
	bl VectorMA
	lfs 11,8(1)
	mr 3,24
	lfs 12,104(1)
	lfs 13,108(1)
	lfs 10,12(1)
	fsubs 12,12,11
	lfs 0,112(1)
	lfs 11,16(1)
	fsubs 13,13,10
	stfs 12,72(1)
	fsubs 0,0,11
	stfs 13,76(1)
	stfs 0,80(1)
	bl VectorNormalize
	lwz 11,540(31)
	lwz 0,492(31)
	lfs 13,4(11)
	cmpwi 0,0,0
	stfs 13,152(1)
	lfs 0,8(11)
	stfs 0,156(1)
	lfs 13,12(11)
	stfs 13,160(1)
	lwz 0,508(11)
	xoris 0,0,0x8000
	stw 0,188(1)
	stw 30,184(1)
	lfd 0,184(1)
	fsub 0,0,27
	frsp 0,0
	fadds 13,13,0
	stfs 13,160(1)
	bc 4,2,.L21
	lfs 0,4(11)
	addi 29,1,136
	lfs 13,4(31)
	mr 3,29
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,136(1)
	lfs 0,8(11)
	fsubs 12,12,0
	stfs 12,140(1)
	lfs 0,12(11)
	fsubs 11,11,0
	stfs 11,144(1)
	bl VectorLength
	lis 9,.LC9@ha
	fmr 11,1
	la 9,.LC9@l(9)
	lfs 12,0(9)
	lwz 9,540(31)
	lfs 0,376(9)
	stfs 0,136(1)
	lfs 13,380(9)
	stfs 13,140(1)
	lfs 0,384(9)
	fcmpu 0,0,12
	stfs 0,144(1)
	bc 4,1,.L22
	stfs 12,144(1)
.L22:
	lis 10,.LC10@ha
	lwz 3,540(31)
	mr 4,29
	la 10,.LC10@l(10)
	addi 5,1,120
	lfs 1,0(10)
	addi 3,3,4
	fdivs 1,11,1
	bl VectorMA
	lwz 10,540(31)
	mr 3,23
	lfs 0,8(1)
	lwz 9,508(10)
	lfs 11,120(1)
	addi 9,9,-8
	lfs 10,128(1)
	xoris 9,9,0x8000
	lfs 12,124(1)
	stw 9,188(1)
	fsubs 11,11,0
	stw 30,184(1)
	lfd 0,184(1)
	lfs 9,12(1)
	lfs 13,16(1)
	fsub 0,0,27
	stfs 11,24(1)
	fsubs 12,12,9
	frsp 0,0
	stfs 12,28(1)
	fadds 10,10,0
	fsubs 13,10,13
	stfs 10,128(1)
	stfs 13,32(1)
	bl VectorNormalize
.L21:
	mr 3,31
	mr 5,23
	addi 4,1,8
	li 6,5
	li 7,2048
	li 8,39
	li 9,8
	bl monster_fire_blaster
	lwz 0,276(1)
	mtlr 0
	lmw 23,196(1)
	lfd 27,232(1)
	lfd 28,240(1)
	lfd 29,248(1)
	lfd 30,256(1)
	lfd 31,264(1)
	la 1,272(1)
	blr
.Lfe1:
	.size	 jawa_fire,.Lfe1-jawa_fire
	.globl jawa_frames_attack1
	.section	".data"
	.align 2
	.type	 jawa_frames_attack1,@object
jawa_frames_attack1:
	.long ai_charge
	.long 0x0
	.long jawa_fire1
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long jawa_attack1_refire
	.long ai_charge
	.long 0x0
	.long 0
	.size	 jawa_frames_attack1,60
	.globl jawa_move_attack1
	.align 2
	.type	 jawa_move_attack1,@object
	.size	 jawa_move_attack1,16
jawa_move_attack1:
	.long 22
	.long 26
	.long jawa_frames_attack1
	.long jawa_run
	.globl jawa_frames_death1
	.align 2
	.type	 jawa_frames_death1,@object
jawa_frames_death1:
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
	.size	 jawa_frames_death1,108
	.globl jawa_move_death1
	.align 2
	.type	 jawa_move_death1,@object
	.size	 jawa_move_death1,16
jawa_move_death1:
	.long 36
	.long 44
	.long jawa_frames_death1
	.long jawa_dead
	.globl jawa_frames_death2
	.align 2
	.type	 jawa_frames_death2,@object
jawa_frames_death2:
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
	.size	 jawa_frames_death2,156
	.globl jawa_move_death2
	.align 2
	.type	 jawa_move_death2,@object
	.size	 jawa_move_death2,16
jawa_move_death2:
	.long 45
	.long 57
	.long jawa_frames_death2
	.long jawa_dead
	.section	".rodata"
	.align 2
.LC13:
	.string	"misc/udeath.wav"
	.align 2
.LC14:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC15:
	.string	"models/objects/gibs/chest/tris.md2"
	.align 2
.LC16:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC17:
	.long 0x46fffe00
	.align 2
.LC18:
	.long 0x0
	.align 2
.LC19:
	.long 0x3f800000
	.align 2
.LC20:
	.long 0x40400000
	.align 3
.LC21:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC22:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl jawa_die
	.type	 jawa_die,@function
jawa_die:
	stwu 1,-64(1)
	mflr 0
	stfd 29,40(1)
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 28,24(1)
	stw 0,68(1)
	mr 31,3
	mr 30,6
	lwz 9,480(31)
	lwz 0,488(31)
	cmpw 0,9,0
	bc 12,1,.L40
	lis 29,gi@ha
	lis 9,.LC18@ha
	la 29,gi@l(29)
	la 9,.LC18@l(9)
	lwz 11,36(29)
	lis 3,.LC13@ha
	lis 10,.LC19@ha
	lfs 31,0(9)
	la 3,.LC13@l(3)
	la 10,.LC19@l(10)
	mtlr 11
	lis 9,.LC20@ha
	lfs 29,0(10)
	lis 28,.LC14@ha
	la 9,.LC20@l(9)
	lfs 30,0(9)
	blrl
	lwz 0,16(29)
	lis 9,.LC19@ha
	lis 10,.LC19@ha
	lis 11,.LC18@ha
	mr 5,3
	la 9,.LC19@l(9)
	la 10,.LC19@l(10)
	mtlr 0
	la 11,.LC18@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L44:
	fadds 31,31,29
	mr 3,31
	la 4,.LC14@l(28)
	mr 5,30
	li 6,0
	bl ThrowGib
	fcmpu 0,31,30
	bc 12,0,.L44
	lis 4,.LC15@ha
	mr 3,31
	la 4,.LC15@l(4)
	mr 5,30
	li 6,0
	bl ThrowGib
	lis 4,.LC16@ha
	mr 5,30
	la 4,.LC16@l(4)
	mr 3,31
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,492(31)
	b .L39
.L40:
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L39
	li 0,2
	li 9,1
	stw 0,492(31)
	stw 9,512(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC21@ha
	lis 11,.LC17@ha
	la 10,.LC21@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC22@ha
	lfs 12,.LC17@l(11)
	la 10,.LC22@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 31,0,12
	fmr 13,31
	fcmpu 0,13,11
	cror 3,2,1
	bc 4,3,.L47
	lis 9,gi+16@ha
	lis 11,sound_cry1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC18@ha
	mr 3,31
	lwz 5,sound_cry1@l(11)
	lis 9,.LC19@ha
	la 10,.LC18@l(10)
	lis 11,.LC19@ha
	la 9,.LC19@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC19@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L48
.L47:
	lis 9,gi+16@ha
	lis 11,sound_cry2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC19@ha
	mr 3,31
	lwz 5,sound_cry2@l(11)
	lis 9,.LC19@ha
	la 10,.LC19@l(10)
	lis 11,.LC18@ha
	la 9,.LC19@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC18@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L48:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC21@ha
	lis 11,.LC17@ha
	la 10,.LC21@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC22@ha
	lfs 12,.LC17@l(11)
	la 10,.LC22@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 31,0,12
	fmr 13,31
	fcmpu 0,13,11
	cror 3,2,1
	bc 4,3,.L49
	lis 9,jawa_move_death1@ha
	la 9,jawa_move_death1@l(9)
	b .L51
.L49:
	lis 9,jawa_move_death2@ha
	la 9,jawa_move_death2@l(9)
.L51:
	stw 9,772(31)
.L39:
	lwz 0,68(1)
	mtlr 0
	lmw 28,24(1)
	lfd 29,40(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe2:
	.size	 jawa_die,.Lfe2-jawa_die
	.section	".rodata"
	.align 2
.LC23:
	.string	"jawa/j_attack1.wav"
	.align 2
.LC24:
	.string	"jawa/j_attack2.wav"
	.align 2
.LC25:
	.string	"jawa/j_attack3.wav"
	.align 2
.LC26:
	.string	"jawa/j_attack4.wav"
	.align 2
.LC27:
	.string	"jawa/j_cry1.wav"
	.align 2
.LC28:
	.string	"jawa/j_cry2.wav"
	.align 2
.LC29:
	.string	"jawa/j_scare.wav"
	.align 2
.LC31:
	.string	"models/monsters/jawa/guard.md2"
	.align 2
.LC30:
	.long 0x46fffe00
	.align 2
.LC32:
	.long 0x3f99999a
	.align 2
.LC33:
	.long 0x0
	.align 3
.LC34:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC35:
	.long 0x41700000
	.align 2
.LC36:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl SP_monster_jawa
	.type	 SP_monster_jawa,@function
SP_monster_jawa:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 11,.LC33@ha
	lis 9,deathmatch@ha
	la 11,.LC33@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L53
	bl G_FreeEdict
	b .L52
.L53:
	lis 29,gi@ha
	lis 3,.LC23@ha
	la 29,gi@l(29)
	la 3,.LC23@l(3)
	lwz 9,36(29)
	li 28,0
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_attack1@ha
	lis 11,.LC24@ha
	stw 3,sound_attack1@l(9)
	mtlr 10
	la 3,.LC24@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_attack2@ha
	lis 11,.LC25@ha
	stw 3,sound_attack2@l(9)
	mtlr 10
	la 3,.LC25@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_attack3@ha
	lis 11,.LC26@ha
	stw 3,sound_attack3@l(9)
	mtlr 10
	la 3,.LC26@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_attack4@ha
	lis 11,.LC27@ha
	stw 3,sound_attack4@l(9)
	mtlr 10
	la 3,.LC27@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_cry1@ha
	lis 11,.LC28@ha
	stw 3,sound_cry1@l(9)
	mtlr 10
	la 3,.LC28@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_cry2@ha
	lis 11,.LC29@ha
	stw 3,sound_cry2@l(9)
	mtlr 10
	la 3,.LC29@l(11)
	blrl
	lis 9,sound_scare@ha
	stw 3,sound_scare@l(9)
	stw 28,60(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC34@ha
	lis 10,.LC30@ha
	stw 0,16(1)
	la 11,.LC34@l(11)
	lis 3,.LC31@ha
	lfd 13,0(11)
	li 0,-40
	la 3,.LC31@l(3)
	lfd 0,16(1)
	lis 11,.LC35@ha
	lfs 11,.LC30@l(10)
	la 11,.LC35@l(11)
	lfs 9,0(11)
	fsub 0,0,13
	lis 11,.LC36@ha
	stw 0,488(31)
	la 11,.LC36@l(11)
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
	lis 9,.LC32@ha
	lis 11,jawa_pain@ha
	stw 28,816(31)
	lfs 0,.LC32@l(9)
	lis 10,jawa_die@ha
	la 11,jawa_pain@l(11)
	lis 9,jawa_stand@ha
	la 10,jawa_die@l(10)
	stw 28,808(31)
	la 9,jawa_stand@l(9)
	lis 0,0xc1c0
	stw 11,452(31)
	stw 10,456(31)
	lis 5,jawa_walk@ha
	lis 4,jawa_run@ha
	stw 9,788(31)
	lis 7,jawa_attack@ha
	lis 6,jawa_sight@ha
	stw 0,196(31)
	la 5,jawa_walk@l(5)
	la 4,jawa_run@l(4)
	la 7,jawa_attack@l(7)
	la 6,jawa_sight@l(6)
	stw 3,40(31)
	lis 9,0x4200
	li 8,5
	stfs 0,784(31)
	li 11,2
	lis 10,0x4234
	stw 9,208(31)
	lis 27,0xc180
	lis 28,0x4180
	stw 8,260(31)
	li 0,50
	stw 11,248(31)
	mr 3,31
	stw 10,420(31)
	stw 5,800(31)
	stw 4,804(31)
	stw 7,812(31)
	stw 6,820(31)
	stw 27,192(31)
	stw 28,204(31)
	stw 0,400(31)
	stw 27,188(31)
	stw 28,200(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	mr 3,31
	bl walkmonster_start
.L52:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 SP_monster_jawa,.Lfe3-SP_monster_jawa
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
sound_attack1:
	.space	4
	.size	 sound_attack1,4
	.align 2
sound_attack2:
	.space	4
	.size	 sound_attack2,4
	.align 2
sound_attack3:
	.space	4
	.size	 sound_attack3,4
	.align 2
sound_attack4:
	.space	4
	.size	 sound_attack4,4
	.align 2
sound_cry1:
	.space	4
	.size	 sound_cry1,4
	.align 2
sound_cry2:
	.space	4
	.size	 sound_cry2,4
	.align 2
sound_scare:
	.space	4
	.size	 sound_scare,4
	.section	".rodata"
	.align 2
.LC37:
	.long 0x46fffe00
	.align 3
.LC38:
	.long 0x3f847ae1
	.long 0x47ae147b
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl jawa_stand
	.type	 jawa_stand,@function
jawa_stand:
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
	lis 11,.LC39@ha
	lis 10,.LC37@ha
	la 11,.LC39@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC38@ha
	lfs 11,.LC37@l(10)
	lfd 12,.LC38@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L7
	lis 9,jawa_move_stand2@ha
	la 9,jawa_move_stand2@l(9)
	b .L54
.L7:
	lis 9,jawa_move_stand1@ha
	la 9,jawa_move_stand1@l(9)
.L54:
	stw 9,772(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 jawa_stand,.Lfe4-jawa_stand
	.align 2
	.globl jawa_walk
	.type	 jawa_walk,@function
jawa_walk:
	lis 9,jawa_move_walk1@ha
	la 9,jawa_move_walk1@l(9)
	stw 9,772(3)
	blr
.Lfe5:
	.size	 jawa_walk,.Lfe5-jawa_walk
	.align 2
	.globl jawa_run
	.type	 jawa_run,@function
jawa_run:
	lwz 0,776(3)
	andi. 9,0,1
	bc 12,2,.L11
	lis 9,jawa_move_stand1@ha
	la 9,jawa_move_stand1@l(9)
	stw 9,772(3)
	blr
.L11:
	lis 9,jawa_move_run1@ha
	la 9,jawa_move_run1@l(9)
	stw 9,772(3)
	blr
.Lfe6:
	.size	 jawa_run,.Lfe6-jawa_run
	.section	".rodata"
	.align 2
.LC40:
	.long 0x46fffe00
	.align 2
.LC41:
	.long 0x40c00000
	.align 3
.LC42:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC43:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC44:
	.long 0x3f800000
	.align 2
.LC45:
	.long 0x0
	.align 2
.LC46:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl jawa_pain
	.type	 jawa_pain,@function
jawa_pain:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,464(31)
	fcmpu 0,13,0
	bc 12,0,.L13
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,464(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC42@ha
	lis 11,.LC40@ha
	la 10,.LC42@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC43@ha
	lfs 12,.LC40@l(11)
	la 10,.LC43@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,1
	bc 4,3,.L15
	lis 9,gi+16@ha
	lis 11,sound_cry1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC45@ha
	mr 3,31
	lwz 5,sound_cry1@l(11)
	lis 9,.LC44@ha
	la 10,.LC45@l(10)
	lis 11,.LC44@ha
	la 9,.LC44@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC44@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L16
.L15:
	lis 9,gi+16@ha
	lis 11,sound_cry2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC44@ha
	mr 3,31
	lwz 5,sound_cry2@l(11)
	lis 9,.LC44@ha
	la 10,.LC44@l(10)
	lis 11,.LC45@ha
	la 9,.LC44@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC45@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L16:
	lis 9,.LC46@ha
	lis 11,skill@ha
	la 9,.LC46@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L13
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC42@ha
	lis 11,.LC40@ha
	la 10,.LC42@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC43@ha
	lfs 12,.LC40@l(11)
	la 10,.LC43@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,1
	bc 4,3,.L18
	lis 9,jawa_move_pain1@ha
	la 9,jawa_move_pain1@l(9)
	b .L55
.L18:
	lis 9,jawa_move_pain2@ha
	la 9,jawa_move_pain2@l(9)
.L55:
	stw 9,772(31)
.L13:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 jawa_pain,.Lfe7-jawa_pain
	.align 2
	.globl jawa_fire1
	.type	 jawa_fire1,@function
jawa_fire1:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,0
	bl jawa_fire
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 jawa_fire1,.Lfe8-jawa_fire1
	.section	".rodata"
	.align 2
.LC47:
	.long 0x46fffe00
	.align 3
.LC48:
	.long 0x3fe66666
	.long 0x66666666
	.align 3
.LC49:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC50:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl jawa_attack1_refire
	.type	 jawa_attack1_refire,@function
jawa_attack1_refire:
	stwu 1,-96(1)
	mflr 0
	stw 31,92(1)
	stw 0,100(1)
	mr 31,3
	lwz 9,540(31)
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L24
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,84(1)
	lis 11,.LC49@ha
	lis 10,.LC47@ha
	la 11,.LC49@l(11)
	stw 0,80(1)
	lfd 13,0(11)
	lfd 0,80(1)
	lis 11,.LC48@ha
	lfs 11,.LC47@l(10)
	lfd 12,.LC48@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L24
	lis 9,gi+48@ha
	lwz 7,540(31)
	addi 3,1,8
	lwz 0,gi+48@l(9)
	addi 4,31,4
	li 5,0
	li 9,3
	addi 7,7,4
	li 6,0
	mr 8,31
	mtlr 0
	blrl
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 13,0(9)
	lis 9,skill@ha
	lwz 11,skill@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	li 0,26
	cror 3,2,1
	bc 4,3,.L27
	lfs 0,16(1)
	fcmpu 0,0,13
	bc 4,2,.L27
	li 0,22
.L27:
	stw 0,780(31)
.L24:
	lwz 0,100(1)
	mtlr 0
	lwz 31,92(1)
	la 1,96(1)
	blr
.Lfe9:
	.size	 jawa_attack1_refire,.Lfe9-jawa_attack1_refire
	.align 2
	.globl jawa_attack
	.type	 jawa_attack,@function
jawa_attack:
	lis 9,jawa_move_attack1@ha
	la 9,jawa_move_attack1@l(9)
	stw 9,772(3)
	blr
.Lfe10:
	.size	 jawa_attack,.Lfe10-jawa_attack
	.section	".rodata"
	.align 2
.LC51:
	.long 0x3f800000
	.align 2
.LC52:
	.long 0x0
	.section	".text"
	.align 2
	.globl jawa_sight
	.type	 jawa_sight,@function
jawa_sight:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl rand
	srawi 0,3,31
	srwi 0,0,30
	add 0,3,0
	rlwinm 0,0,0,0,29
	subf. 3,0,3
	bc 4,2,.L31
	lis 9,gi+16@ha
	lis 11,sound_attack1@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC51@ha
	lwz 5,sound_attack1@l(11)
	b .L57
.L31:
	cmpwi 0,3,1
	bc 4,2,.L33
	lis 9,gi+16@ha
	lis 11,sound_attack2@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC51@ha
	lwz 5,sound_attack2@l(11)
	b .L57
.L33:
	cmpwi 0,3,2
	bc 4,2,.L35
	lis 9,gi+16@ha
	lis 11,sound_attack3@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC51@ha
	lwz 5,sound_attack3@l(11)
.L57:
	la 9,.LC51@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 2,0(9)
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 3,0(9)
	blrl
	b .L32
.L35:
	cmpwi 0,3,3
	bc 4,2,.L32
	lis 9,gi+16@ha
	lis 11,sound_attack4@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC51@ha
	lwz 5,sound_attack4@l(11)
	la 9,.LC51@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 2,0(9)
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 3,0(9)
	blrl
.L32:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 jawa_sight,.Lfe11-jawa_sight
	.align 2
	.globl jawa_dead
	.type	 jawa_dead,@function
jawa_dead:
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
.Lfe12:
	.size	 jawa_dead,.Lfe12-jawa_dead
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
