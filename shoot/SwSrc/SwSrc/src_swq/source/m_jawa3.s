	.file	"m_jawa3.c"
gcc2_compiled.:
	.globl jawa3_frames_stand2
	.section	".data"
	.align 2
	.type	 jawa3_frames_stand2,@object
jawa3_frames_stand2:
	.long ai_stand
	.long 0x0
	.long 0
	.size	 jawa3_frames_stand2,12
	.globl jawa3_move_stand2
	.align 2
	.type	 jawa3_move_stand2,@object
	.size	 jawa3_move_stand2,16
jawa3_move_stand2:
	.long 0
	.long 0
	.long jawa3_frames_stand2
	.long jawa3_stand
	.globl jawa3_frames_stand1
	.align 2
	.type	 jawa3_frames_stand1,@object
jawa3_frames_stand1:
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
	.size	 jawa3_frames_stand1,180
	.globl jawa3_move_stand1
	.align 2
	.type	 jawa3_move_stand1,@object
	.size	 jawa3_move_stand1,16
jawa3_move_stand1:
	.long 0
	.long 14
	.long jawa3_frames_stand1
	.long jawa3_stand
	.globl jawa3_frames_idle1
	.align 2
	.type	 jawa3_frames_idle1,@object
jawa3_frames_idle1:
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
	.size	 jawa3_frames_idle1,72
	.globl jawa3_move_idle1
	.align 2
	.type	 jawa3_move_idle1,@object
	.size	 jawa3_move_idle1,16
jawa3_move_idle1:
	.long 15
	.long 20
	.long jawa3_frames_idle1
	.long jawa3_stand
	.globl jawa3_frames_agree1
	.align 2
	.type	 jawa3_frames_agree1,@object
jawa3_frames_agree1:
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
	.size	 jawa3_frames_agree1,48
	.globl jawa3_move_agree1
	.align 2
	.type	 jawa3_move_agree1,@object
	.size	 jawa3_move_agree1,16
jawa3_move_agree1:
	.long 40
	.long 43
	.long jawa3_frames_agree1
	.long jawa3_stand
	.globl jawa3_frames_disagre1
	.align 2
	.type	 jawa3_frames_disagre1,@object
jawa3_frames_disagre1:
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
	.size	 jawa3_frames_disagre1,48
	.globl jawa3_move_disagre1
	.align 2
	.type	 jawa3_move_disagre1,@object
	.size	 jawa3_move_disagre1,16
jawa3_move_disagre1:
	.long 44
	.long 47
	.long jawa3_frames_disagre1
	.long jawa3_stand
	.globl jawa3_frames_walk1
	.align 2
	.type	 jawa3_frames_walk1,@object
jawa3_frames_walk1:
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
	.size	 jawa3_frames_walk1,144
	.globl jawa3_move_walk1
	.align 2
	.type	 jawa3_move_walk1,@object
	.size	 jawa3_move_walk1,16
jawa3_move_walk1:
	.long 21
	.long 32
	.long jawa3_frames_walk1
	.long 0
	.globl jawa3_frames_run1
	.align 2
	.type	 jawa3_frames_run1,@object
jawa3_frames_run1:
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
	.size	 jawa3_frames_run1,72
	.globl jawa3_move_run1
	.align 2
	.type	 jawa3_move_run1,@object
	.size	 jawa3_move_run1,16
jawa3_move_run1:
	.long 33
	.long 38
	.long jawa3_frames_run1
	.long 0
	.globl jawa3_frames_pain1
	.align 2
	.type	 jawa3_frames_pain1,@object
jawa3_frames_pain1:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 jawa3_frames_pain1,36
	.globl jawa3_move_pain1
	.align 2
	.type	 jawa3_move_pain1,@object
	.size	 jawa3_move_pain1,16
jawa3_move_pain1:
	.long 48
	.long 50
	.long jawa3_frames_pain1
	.long jawa3_run
	.globl jawa3_frames_death1
	.align 2
	.type	 jawa3_frames_death1,@object
jawa3_frames_death1:
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
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 jawa3_frames_death1,228
	.globl jawa3_move_death1
	.align 2
	.type	 jawa3_move_death1,@object
	.size	 jawa3_move_death1,16
jawa3_move_death1:
	.long 51
	.long 69
	.long jawa3_frames_death1
	.long jawa3_dead
	.globl jawa3_frames_death2
	.align 2
	.type	 jawa3_frames_death2,@object
jawa3_frames_death2:
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
	.size	 jawa3_frames_death2,108
	.globl jawa3_move_death2
	.align 2
	.type	 jawa3_move_death2,@object
	.size	 jawa3_move_death2,16
jawa3_move_death2:
	.long 70
	.long 78
	.long jawa3_frames_death2
	.long jawa3_dead
	.section	".rodata"
	.align 2
.LC3:
	.string	"misc/udeath.wav"
	.align 2
.LC4:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC5:
	.string	"models/objects/gibs/chest/tris.md2"
	.align 2
.LC6:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC7:
	.long 0x46fffe00
	.align 2
.LC8:
	.long 0x0
	.align 2
.LC9:
	.long 0x3f800000
	.align 2
.LC10:
	.long 0x40400000
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
	.globl jawa3_die
	.type	 jawa3_die,@function
jawa3_die:
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
	bc 12,1,.L22
	lis 29,gi@ha
	lis 9,.LC8@ha
	la 29,gi@l(29)
	la 9,.LC8@l(9)
	lwz 11,36(29)
	lis 3,.LC3@ha
	lis 10,.LC9@ha
	lfs 31,0(9)
	la 3,.LC3@l(3)
	la 10,.LC9@l(10)
	mtlr 11
	lis 9,.LC10@ha
	lfs 29,0(10)
	lis 28,.LC4@ha
	la 9,.LC10@l(9)
	lfs 30,0(9)
	blrl
	lwz 0,16(29)
	lis 9,.LC9@ha
	lis 10,.LC9@ha
	lis 11,.LC8@ha
	mr 5,3
	la 9,.LC9@l(9)
	la 10,.LC9@l(10)
	mtlr 0
	la 11,.LC8@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L26:
	fadds 31,31,29
	mr 3,31
	la 4,.LC4@l(28)
	mr 5,30
	li 6,0
	bl ThrowGib
	fcmpu 0,31,30
	bc 12,0,.L26
	lis 4,.LC5@ha
	mr 3,31
	la 4,.LC5@l(4)
	mr 5,30
	li 6,0
	bl ThrowGib
	lis 4,.LC6@ha
	mr 5,30
	la 4,.LC6@l(4)
	mr 3,31
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,492(31)
	b .L21
.L22:
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L21
	li 0,2
	li 9,1
	stw 0,492(31)
	stw 9,512(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC11@ha
	lis 11,.LC7@ha
	la 10,.LC11@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC12@ha
	lfs 12,.LC7@l(11)
	la 10,.LC12@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 31,0,12
	fmr 13,31
	fcmpu 0,13,11
	cror 3,2,1
	bc 4,3,.L29
	lis 9,gi+16@ha
	lis 11,sound_cry1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC8@ha
	mr 3,31
	lwz 5,sound_cry1@l(11)
	lis 9,.LC9@ha
	la 10,.LC8@l(10)
	lis 11,.LC9@ha
	la 9,.LC9@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC9@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L30
.L29:
	lis 9,gi+16@ha
	lis 11,sound_cry2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC9@ha
	mr 3,31
	lwz 5,sound_cry2@l(11)
	lis 9,.LC9@ha
	la 10,.LC9@l(10)
	lis 11,.LC8@ha
	la 9,.LC9@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC8@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L30:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC11@ha
	lis 11,.LC7@ha
	la 10,.LC11@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC12@ha
	lfs 12,.LC7@l(11)
	la 10,.LC12@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 31,0,12
	fmr 13,31
	fcmpu 0,13,11
	cror 3,2,1
	bc 4,3,.L31
	lis 9,jawa3_move_death1@ha
	la 9,jawa3_move_death1@l(9)
	b .L33
.L31:
	lis 9,jawa3_move_death2@ha
	la 9,jawa3_move_death2@l(9)
.L33:
	stw 9,772(31)
.L21:
	lwz 0,68(1)
	mtlr 0
	lmw 28,24(1)
	lfd 29,40(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe1:
	.size	 jawa3_die,.Lfe1-jawa3_die
	.section	".rodata"
	.align 2
.LC13:
	.string	"jawa/j_agree.wav"
	.align 2
.LC14:
	.string	"jawa/j_cry1.wav"
	.align 2
.LC15:
	.string	"jawa/j_cry2.wav"
	.align 2
.LC16:
	.string	"jawa/j_disagr.wav"
	.align 2
.LC17:
	.string	"jawa/j_lift1.wav"
	.align 2
.LC18:
	.string	"jawa/j_lift2.wav"
	.align 2
.LC19:
	.string	"jawa/j_scare.wav"
	.align 2
.LC20:
	.string	"jawa/j_talk1.wav"
	.align 2
.LC21:
	.string	"jawa/j_talk2.wav"
	.align 2
.LC22:
	.string	"jawa/j_talk3.wav"
	.align 2
.LC23:
	.string	"jawa/j_talk4.wav"
	.align 2
.LC24:
	.string	"jawa/j_talk5.wav"
	.align 2
.LC25:
	.string	"jawa/j_talk6.wav"
	.align 2
.LC26:
	.string	"jawa/j_work.wav"
	.align 2
.LC28:
	.string	"models/monsters/jawa/trader.md2"
	.align 2
.LC27:
	.long 0x46fffe00
	.align 2
.LC29:
	.long 0x3f99999a
	.align 2
.LC30:
	.long 0x0
	.align 3
.LC31:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC32:
	.long 0x41700000
	.align 2
.LC33:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl SP_monster_jawa3
	.type	 SP_monster_jawa3,@function
SP_monster_jawa3:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 11,.LC30@ha
	lis 9,deathmatch@ha
	la 11,.LC30@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L35
	bl G_FreeEdict
	b .L34
.L35:
	lis 29,gi@ha
	lis 3,.LC13@ha
	la 29,gi@l(29)
	la 3,.LC13@l(3)
	lwz 9,36(29)
	li 26,0
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_agree@ha
	lis 11,.LC14@ha
	stw 3,sound_agree@l(9)
	mtlr 10
	la 3,.LC14@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_cry1@ha
	lis 11,.LC15@ha
	stw 3,sound_cry1@l(9)
	mtlr 10
	la 3,.LC15@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_cry2@ha
	lis 11,.LC16@ha
	stw 3,sound_cry2@l(9)
	mtlr 10
	la 3,.LC16@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_disagree@ha
	lis 11,.LC17@ha
	stw 3,sound_disagree@l(9)
	mtlr 10
	la 3,.LC17@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_lift1@ha
	lis 11,.LC18@ha
	stw 3,sound_lift1@l(9)
	mtlr 10
	la 3,.LC18@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_lift2@ha
	lis 11,.LC19@ha
	stw 3,sound_lift2@l(9)
	mtlr 10
	la 3,.LC19@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_scare@ha
	lis 11,.LC20@ha
	stw 3,sound_scare@l(9)
	mtlr 10
	la 3,.LC20@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_talk1@ha
	lis 11,.LC21@ha
	stw 3,sound_talk1@l(9)
	mtlr 10
	la 3,.LC21@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_talk2@ha
	lis 11,.LC22@ha
	stw 3,sound_talk2@l(9)
	mtlr 10
	la 3,.LC22@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_talk3@ha
	lis 11,.LC23@ha
	stw 3,sound_talk3@l(9)
	mtlr 10
	la 3,.LC23@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_talk4@ha
	lis 11,.LC24@ha
	stw 3,sound_talk4@l(9)
	mtlr 10
	la 3,.LC24@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_talk5@ha
	lis 11,.LC25@ha
	stw 3,sound_talk5@l(9)
	mtlr 10
	la 3,.LC25@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_talk6@ha
	lis 11,.LC26@ha
	stw 3,sound_talk6@l(9)
	mtlr 10
	la 3,.LC26@l(11)
	blrl
	lis 9,sound_work@ha
	stw 3,sound_work@l(9)
	stw 26,60(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC31@ha
	lis 10,.LC27@ha
	stw 0,16(1)
	la 11,.LC31@l(11)
	lis 3,.LC28@ha
	lfd 13,0(11)
	li 0,-40
	la 3,.LC28@l(3)
	lfd 0,16(1)
	lis 11,.LC32@ha
	lfs 11,.LC27@l(10)
	la 11,.LC32@l(11)
	lfs 9,0(11)
	fsub 0,0,13
	lis 11,.LC33@ha
	stw 0,488(31)
	la 11,.LC33@l(11)
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
	lis 9,.LC29@ha
	lis 11,jawa3_pain@ha
	lwz 4,776(31)
	lfs 0,.LC29@l(9)
	lis 10,jawa3_die@ha
	lis 8,jawa3_walk@ha
	lis 9,jawa3_stand@ha
	la 11,jawa3_pain@l(11)
	stw 3,40(31)
	la 10,jawa3_die@l(10)
	la 9,jawa3_stand@l(9)
	stw 11,452(31)
	la 8,jawa3_walk@l(8)
	lis 0,0xc1c0
	stw 10,456(31)
	stw 9,788(31)
	lis 5,jawa3_run@ha
	lis 7,jawa3_attack@ha
	stw 8,800(31)
	lis 6,jawa3_sight@ha
	la 5,jawa3_run@l(5)
	stw 0,196(31)
	la 7,jawa3_attack@l(7)
	la 6,jawa3_sight@l(6)
	ori 4,4,256
	lis 11,0x4200
	stfs 0,784(31)
	li 10,5
	li 8,2
	stw 11,208(31)
	lis 9,0x4234
	lis 28,0xc180
	stw 10,260(31)
	lis 27,0x4180
	li 0,50
	stw 8,248(31)
	stw 9,420(31)
	mr 3,31
	stw 5,804(31)
	stw 7,812(31)
	stw 6,820(31)
	stw 4,776(31)
	stw 26,816(31)
	stw 28,192(31)
	stw 27,204(31)
	stw 0,400(31)
	stw 28,188(31)
	stw 27,200(31)
	stw 26,808(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	mr 3,31
	bl walkmonster_start
.L34:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 SP_monster_jawa3,.Lfe2-SP_monster_jawa3
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
sound_agree:
	.space	4
	.size	 sound_agree,4
	.align 2
sound_cry1:
	.space	4
	.size	 sound_cry1,4
	.align 2
sound_cry2:
	.space	4
	.size	 sound_cry2,4
	.align 2
sound_disagree:
	.space	4
	.size	 sound_disagree,4
	.align 2
sound_lift1:
	.space	4
	.size	 sound_lift1,4
	.align 2
sound_lift2:
	.space	4
	.size	 sound_lift2,4
	.align 2
sound_scare:
	.space	4
	.size	 sound_scare,4
	.align 2
sound_talk1:
	.space	4
	.size	 sound_talk1,4
	.align 2
sound_talk2:
	.space	4
	.size	 sound_talk2,4
	.align 2
sound_talk3:
	.space	4
	.size	 sound_talk3,4
	.align 2
sound_talk4:
	.space	4
	.size	 sound_talk4,4
	.align 2
sound_talk5:
	.space	4
	.size	 sound_talk5,4
	.align 2
sound_talk6:
	.space	4
	.size	 sound_talk6,4
	.align 2
sound_work:
	.space	4
	.size	 sound_work,4
	.section	".rodata"
	.align 2
.LC34:
	.long 0x46fffe00
	.align 3
.LC35:
	.long 0x3f847ae1
	.long 0x47ae147b
	.align 3
.LC36:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl jawa3_stand
	.type	 jawa3_stand,@function
jawa3_stand:
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
	lis 11,.LC36@ha
	lis 10,.LC34@ha
	la 11,.LC36@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC35@ha
	lfs 11,.LC34@l(10)
	lfd 12,.LC35@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L7
	lis 9,jawa3_move_stand2@ha
	la 9,jawa3_move_stand2@l(9)
	b .L36
.L7:
	lis 9,jawa3_move_stand1@ha
	la 9,jawa3_move_stand1@l(9)
.L36:
	stw 9,772(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 jawa3_stand,.Lfe3-jawa3_stand
	.align 2
	.globl jawa3_walk
	.type	 jawa3_walk,@function
jawa3_walk:
	lis 9,jawa3_move_walk1@ha
	la 9,jawa3_move_walk1@l(9)
	stw 9,772(3)
	blr
.Lfe4:
	.size	 jawa3_walk,.Lfe4-jawa3_walk
	.align 2
	.globl jawa3_run
	.type	 jawa3_run,@function
jawa3_run:
	lwz 0,776(3)
	andi. 9,0,1
	bc 12,2,.L11
	lis 9,jawa3_move_stand1@ha
	la 9,jawa3_move_stand1@l(9)
	stw 9,772(3)
	blr
.L11:
	lis 9,jawa3_move_run1@ha
	la 9,jawa3_move_run1@l(9)
	stw 9,772(3)
	blr
.Lfe5:
	.size	 jawa3_run,.Lfe5-jawa3_run
	.section	".rodata"
	.align 2
.LC37:
	.long 0x46fffe00
	.align 2
.LC38:
	.long 0x40c00000
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC40:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC41:
	.long 0x3f800000
	.align 2
.LC42:
	.long 0x0
	.align 2
.LC43:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl jawa3_pain
	.type	 jawa3_pain,@function
jawa3_pain:
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
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,464(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC39@ha
	lis 11,.LC37@ha
	la 10,.LC39@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC40@ha
	lfs 12,.LC37@l(11)
	la 10,.LC40@l(10)
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
	lis 10,.LC42@ha
	mr 3,31
	lwz 5,sound_cry1@l(11)
	lis 9,.LC41@ha
	la 10,.LC42@l(10)
	lis 11,.LC41@ha
	la 9,.LC41@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC41@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L16
.L15:
	lis 9,gi+16@ha
	lis 11,sound_cry2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC41@ha
	mr 3,31
	lwz 5,sound_cry2@l(11)
	lis 9,.LC41@ha
	la 10,.LC41@l(10)
	lis 11,.LC42@ha
	la 9,.LC41@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC42@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L16:
	lis 9,.LC43@ha
	lis 11,skill@ha
	la 9,.LC43@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L13
	lis 9,jawa3_move_pain1@ha
	la 9,jawa3_move_pain1@l(9)
	stw 9,772(31)
.L13:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 jawa3_pain,.Lfe6-jawa3_pain
	.align 2
	.globl jawa3_attack
	.type	 jawa3_attack,@function
jawa3_attack:
	blr
.Lfe7:
	.size	 jawa3_attack,.Lfe7-jawa3_attack
	.align 2
	.globl jawa3_sight
	.type	 jawa3_sight,@function
jawa3_sight:
	blr
.Lfe8:
	.size	 jawa3_sight,.Lfe8-jawa3_sight
	.align 2
	.globl jawa3_dead
	.type	 jawa3_dead,@function
jawa3_dead:
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
	.size	 jawa3_dead,.Lfe9-jawa3_dead
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
