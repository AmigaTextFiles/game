	.file	"robocop.c"
gcc2_compiled.:
	.globl railbot_frames_stand1
	.section	".data"
	.align 2
	.type	 railbot_frames_stand1,@object
railbot_frames_stand1:
	.long ai_stand
	.long 0x0
	.long railbot_idle
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
	.size	 railbot_frames_stand1,480
	.globl railbot_move_stand1
	.align 2
	.type	 railbot_move_stand1,@object
	.size	 railbot_move_stand1,16
railbot_move_stand1:
	.long 0
	.long 39
	.long railbot_frames_stand1
	.long railbot_stand
	.globl railbot_frames_taunt1
	.align 2
	.type	 railbot_frames_taunt1,@object
railbot_frames_taunt1:
	.long ai_stand
	.long 0x0
	.long railbot_idle
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
	.size	 railbot_frames_taunt1,204
	.globl railbot_move_taunt1
	.align 2
	.type	 railbot_move_taunt1,@object
	.size	 railbot_move_taunt1,16
railbot_move_taunt1:
	.long 95
	.long 111
	.long railbot_frames_taunt1
	.long railbot_taunt
	.globl railbot_frames_run
	.align 2
	.type	 railbot_frames_run,@object
railbot_frames_run:
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
	.size	 railbot_frames_run,72
	.globl railbot_move_run
	.align 2
	.type	 railbot_move_run,@object
	.size	 railbot_move_run,16
railbot_move_run:
	.long 40
	.long 45
	.long railbot_frames_run
	.long railbot_run
	.globl railbot_frames_pain1
	.align 2
	.type	 railbot_frames_pain1,@object
railbot_frames_pain1:
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
	.long 0x0
	.long 0
	.size	 railbot_frames_pain1,48
	.globl railbot_move_pain1
	.align 2
	.type	 railbot_move_pain1,@object
	.size	 railbot_move_pain1,16
railbot_move_pain1:
	.long 54
	.long 57
	.long railbot_frames_pain1
	.long railbot_run
	.align 2
	.type	 blaster_flash,@object
blaster_flash:
	.long 39
	.long 40
	.long 83
	.long 86
	.long 89
	.long 92
	.long 95
	.long 98
	.size	 blaster_flash,32
	.align 2
	.type	 shotgun_flash,@object
shotgun_flash:
	.long 41
	.long 42
	.long 84
	.long 87
	.long 90
	.long 93
	.long 96
	.long 99
	.size	 shotgun_flash,32
	.align 2
	.type	 machinegun_flash,@object
machinegun_flash:
	.long 43
	.long 44
	.long 85
	.long 88
	.long 91
	.long 94
	.long 97
	.long 100
	.size	 machinegun_flash,32
	.section	".rodata"
	.align 2
.LC2:
	.long 0x46fffe00
	.align 3
.LC3:
	.long 0x408f4000
	.long 0x0
	.align 3
.LC4:
	.long 0x407f4000
	.long 0x0
	.align 3
.LC5:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC6:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC7:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl RailBot_fire
	.type	 RailBot_fire,@function
RailBot_fire:
	stwu 1,-192(1)
	mflr 0
	stfd 28,160(1)
	stfd 29,168(1)
	stfd 30,176(1)
	stfd 31,184(1)
	stmw 24,128(1)
	stw 0,196(1)
	mr 28,4
	lis 9,shotgun_flash@ha
	addi 31,1,24
	addi 30,1,40
	slwi 0,28,2
	la 9,shotgun_flash@l(9)
	mr 24,3
	lwzx 29,9,0
	mr 4,31
	addi 3,24,16
	mr 5,30
	li 6,0
	bl AngleVectors
	mulli 29,29,12
	lis 4,monster_flash_offset@ha
	addi 3,24,4
	la 4,monster_flash_offset@l(4)
	mr 5,31
	add 4,29,4
	mr 6,30
	addi 7,1,8
	bl G_ProjectSource
	addi 28,28,-5
	cmplwi 0,28,1
	bc 12,1,.L15
	lfs 0,24(1)
	addi 5,1,72
	lfs 13,28(1)
	lfs 12,32(1)
	stfs 0,72(1)
	stfs 13,76(1)
	stfs 12,80(1)
	b .L16
.L15:
	lwz 9,816(24)
	lis 28,0x4330
	lfs 0,8(1)
	lis 10,.LC5@ha
	addi 26,1,72
	lfs 12,4(9)
	la 10,.LC5@l(10)
	addi 27,1,88
	lfs 10,12(1)
	addi 29,1,104
	addi 25,1,56
	lfd 31,0(10)
	mr 3,26
	mr 4,27
	stfs 12,104(1)
	lis 10,.LC6@ha
	fsubs 12,12,0
	lfs 11,16(1)
	la 10,.LC6@l(10)
	lfs 0,8(9)
	lfd 28,0(10)
	stfs 0,108(1)
	lfs 13,12(9)
	fsubs 0,0,10
	stfs 13,112(1)
	lwz 0,784(9)
	stfs 0,76(1)
	xoris 0,0,0x8000
	stfs 12,72(1)
	stw 0,124(1)
	stw 28,120(1)
	lfd 0,120(1)
	fsub 0,0,31
	frsp 0,0
	fadds 13,13,0
	fsubs 11,13,11
	stfs 13,112(1)
	stfs 11,80(1)
	bl vectoangles
	mr 6,25
	mr 4,31
	mr 5,30
	mr 3,27
	bl AngleVectors
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC2@ha
	stw 3,124(1)
	lis 11,.LC3@ha
	stw 28,120(1)
	lfd 0,120(1)
	lfs 29,.LC2@l(10)
	lfd 13,.LC3@l(11)
	fsub 0,0,31
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
	lis 11,.LC4@ha
	stw 3,124(1)
	lis 10,.LC7@ha
	mr 4,31
	stw 28,120(1)
	la 10,.LC7@l(10)
	addi 3,1,8
	lfd 0,120(1)
	mr 5,29
	lfd 13,.LC4@l(11)
	lfs 1,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 31,0
	fsub 31,31,28
	fadd 31,31,31
	fmul 31,31,13
	frsp 31,31
	bl VectorMA
	fmr 1,30
	mr 4,30
	mr 3,29
	mr 5,29
	bl VectorMA
	fmr 1,31
	mr 3,29
	mr 4,25
	mr 5,3
	bl VectorMA
	lfs 11,8(1)
	mr 3,26
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
	mr 5,26
.L16:
	mr 3,24
	addi 4,1,8
	li 6,50
	li 7,100
	li 8,61
	bl monster_fire_railgun
	lwz 0,196(1)
	mtlr 0
	lmw 24,128(1)
	lfd 28,160(1)
	lfd 29,168(1)
	lfd 30,176(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe1:
	.size	 RailBot_fire,.Lfe1-RailBot_fire
	.globl RailBot_frames_attack1
	.section	".data"
	.align 2
	.type	 RailBot_frames_attack1,@object
RailBot_frames_attack1:
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long RailBot_fire1
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.size	 RailBot_frames_attack1,96
	.globl RailBot_move_attack1
	.align 2
	.type	 RailBot_move_attack1,@object
	.size	 RailBot_move_attack1,16
RailBot_move_attack1:
	.long 46
	.long 53
	.long RailBot_frames_attack1
	.long railbot_run
	.section	".rodata"
	.align 2
.LC9:
	.string	"railbot"
	.align 2
.LC10:
	.string	"soldier/solidle1.wav"
	.align 2
.LC11:
	.string	"soldier/solsght1.wav"
	.align 2
.LC12:
	.string	"soldier/solsrch1.wav"
	.align 2
.LC13:
	.string	"soldier/solpain1.wav"
	.align 2
.LC14:
	.string	"misc/keyuse.wav"
	.align 2
.LC15:
	.string	"soldier/solatck1.wav"
	.align 2
.LC16:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl spawn_railbot
	.type	 spawn_railbot,@function
spawn_railbot:
	stwu 1,-80(1)
	mflr 0
	stmw 18,24(1)
	stw 0,84(1)
	mr 27,3
	bl G_Spawn
	lwz 9,84(27)
	mr 29,3
	li 6,0
	addi 4,1,8
	li 5,0
	addi 3,9,3752
	bl AngleVectors
	lis 9,.LC16@ha
	addi 4,1,8
	la 9,.LC16@l(9)
	addi 5,29,4
	lfs 1,0(9)
	addi 3,27,4
	bl VectorMA
	stw 29,1256(27)
	lis 9,.LC9@ha
	li 7,0
	stw 27,1264(29)
	la 9,.LC9@l(9)
	li 25,100
	lwz 0,272(27)
	lis 6,0x201
	lis 5,railbot_pain@ha
	lis 4,railbot_die@ha
	lis 26,railbot_stand@ha
	stw 0,272(29)
	la 5,railbot_pain@l(5)
	la 4,railbot_die@l(4)
	lwz 0,60(27)
	ori 6,6,3
	la 26,railbot_stand@l(26)
	lis 20,0xc180
	lis 19,0x4180
	stw 0,60(29)
	li 18,2
	lis 24,0x3f80
	lwz 0,40(27)
	lis 23,0xc1c0
	lis 22,0x4200
	li 21,5
	lis 8,railbot_run@ha
	stw 0,40(29)
	la 8,railbot_run@l(8)
	lis 11,RailBot_attack@ha
	lwz 0,40(27)
	lis 10,railbot_sight@ha
	la 11,RailBot_attack@l(11)
	stw 7,64(29)
	la 10,railbot_sight@l(10)
	lis 28,gi@ha
	stw 7,56(29)
	la 28,gi@l(28)
	lis 3,.LC10@ha
	stw 9,284(29)
	la 3,.LC10@l(3)
	stw 0,44(29)
	stw 25,728(29)
	stw 25,756(29)
	lwz 0,908(27)
	stw 6,252(29)
	stw 5,696(29)
	stw 4,700(29)
	stw 7,1152(29)
	stw 0,908(29)
	stw 24,1136(29)
	stw 20,192(29)
	stw 23,196(29)
	stw 19,204(29)
	stw 22,208(29)
	stw 21,264(29)
	stw 18,788(29)
	stw 25,644(29)
	stw 26,1140(29)
	stw 20,188(29)
	stw 19,200(29)
	stw 18,248(29)
	stw 8,1156(29)
	stw 7,1168(29)
	stw 7,1160(29)
	stw 11,1164(29)
	stw 10,1172(29)
	lwz 9,36(28)
	mtlr 9
	blrl
	lwz 10,36(28)
	lis 9,sound_idle@ha
	lis 11,.LC11@ha
	stw 3,sound_idle@l(9)
	mtlr 10
	la 3,.LC11@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_sight1@ha
	lis 11,.LC12@ha
	stw 3,sound_sight1@l(9)
	mtlr 10
	la 3,.LC12@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_sight2@ha
	lis 11,.LC13@ha
	stw 3,sound_sight2@l(9)
	mtlr 10
	la 3,.LC13@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_pain@ha
	lis 11,.LC14@ha
	stw 3,sound_pain@l(9)
	mtlr 10
	la 3,.LC14@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_death@ha
	lis 11,.LC15@ha
	stw 3,sound_death@l(9)
	mtlr 10
	la 3,.LC15@l(11)
	blrl
	li 9,-30
	li 0,30
	stw 9,760(29)
	mr 3,29
	stw 0,728(29)
	lfs 0,16(27)
	stfs 0,16(29)
	lfs 13,20(27)
	stfs 13,20(29)
	lfs 0,24(27)
	stfs 0,24(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 9,1140(29)
	mr 3,29
	mtlr 9
	blrl
	mr 3,29
	bl walkmonster_start
	lwz 0,84(1)
	mtlr 0
	lmw 18,24(1)
	la 1,80(1)
	blr
.Lfe2:
	.size	 spawn_railbot,.Lfe2-spawn_railbot
	.section	".rodata"
	.align 2
.LC17:
	.string	"on"
	.align 2
.LC18:
	.string	"off"
	.align 2
.LC19:
	.string	"RailBot destroyed.\n"
	.align 2
.LC20:
	.string	"RailBot created.\n"
	.section	".sbss","aw",@nobits
	.align 2
sound_idle:
	.space	4
	.size	 sound_idle,4
	.align 2
sound_sight1:
	.space	4
	.size	 sound_sight1,4
	.align 2
sound_sight2:
	.space	4
	.size	 sound_sight2,4
	.align 2
sound_pain:
	.space	4
	.size	 sound_pain,4
	.align 2
sound_death:
	.space	4
	.size	 sound_death,4
	.section	".rodata"
	.align 2
.LC21:
	.long 0x46fffe00
	.align 3
.LC22:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC23:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC24:
	.long 0x3f800000
	.align 2
.LC25:
	.long 0x40000000
	.align 2
.LC26:
	.long 0x0
	.section	".text"
	.align 2
	.globl railbot_idle
	.type	 railbot_idle,@function
railbot_idle:
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
	lis 11,.LC23@ha
	lis 10,.LC21@ha
	la 11,.LC23@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC22@ha
	lfs 11,.LC21@l(10)
	lfd 12,.LC22@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L7
	lis 9,gi+16@ha
	lis 11,sound_idle@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC24@ha
	lwz 5,sound_idle@l(11)
	la 9,.LC24@l(9)
	lis 11,.LC25@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC25@l(11)
	lis 9,.LC26@ha
	lfs 2,0(11)
	la 9,.LC26@l(9)
	lfs 3,0(9)
	blrl
.L7:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 railbot_idle,.Lfe3-railbot_idle
	.align 2
	.globl railbot_stand
	.type	 railbot_stand,@function
railbot_stand:
	lis 9,railbot_move_stand1@ha
	la 9,railbot_move_stand1@l(9)
	stw 9,1124(3)
	blr
.Lfe4:
	.size	 railbot_stand,.Lfe4-railbot_stand
	.align 2
	.globl railbot_taunt
	.type	 railbot_taunt,@function
railbot_taunt:
	lis 9,railbot_move_taunt1@ha
	la 9,railbot_move_taunt1@l(9)
	stw 9,1124(3)
	blr
.Lfe5:
	.size	 railbot_taunt,.Lfe5-railbot_taunt
	.align 2
	.globl railbot_run
	.type	 railbot_run,@function
railbot_run:
	lwz 0,1128(3)
	andi. 9,0,1
	bc 12,2,.L11
	lis 9,railbot_move_stand1@ha
	la 9,railbot_move_stand1@l(9)
	stw 9,1124(3)
	blr
.L11:
	lis 9,railbot_move_run@ha
	la 9,railbot_move_run@l(9)
	stw 9,1124(3)
	blr
.Lfe6:
	.size	 railbot_run,.Lfe6-railbot_run
	.section	".rodata"
	.align 2
.LC27:
	.long 0x40400000
	.align 2
.LC28:
	.long 0x3f800000
	.align 2
.LC29:
	.long 0x0
	.section	".text"
	.align 2
	.globl railbot_pain
	.type	 railbot_pain,@function
railbot_pain:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,708(31)
	fcmpu 0,13,0
	bc 12,0,.L12
	lis 9,.LC27@ha
	lis 11,gi+16@ha
	la 9,.LC27@l(9)
	lfs 0,0(9)
	li 4,2
	lis 9,sound_pain@ha
	lwz 5,sound_pain@l(9)
	lis 9,.LC28@ha
	fadds 0,13,0
	la 9,.LC28@l(9)
	lfs 1,0(9)
	lis 9,.LC28@ha
	stfs 0,708(31)
	la 9,.LC28@l(9)
	lwz 0,gi+16@l(11)
	lfs 2,0(9)
	lis 9,.LC29@ha
	mtlr 0
	la 9,.LC29@l(9)
	lfs 3,0(9)
	blrl
	lis 9,railbot_move_pain1@ha
	la 9,railbot_move_pain1@l(9)
	stw 9,1124(31)
.L12:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 railbot_pain,.Lfe7-railbot_pain
	.align 2
	.globl RailBot_fire1
	.type	 RailBot_fire1,@function
RailBot_fire1:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,0
	bl RailBot_fire
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 RailBot_fire1,.Lfe8-RailBot_fire1
	.align 2
	.globl RailBot_attack
	.type	 RailBot_attack,@function
RailBot_attack:
	lis 9,RailBot_move_attack1@ha
	la 9,RailBot_move_attack1@l(9)
	stw 9,1124(3)
	blr
.Lfe9:
	.size	 RailBot_attack,.Lfe9-RailBot_attack
	.section	".rodata"
	.align 2
.LC30:
	.long 0x46fffe00
	.align 3
.LC31:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC32:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC33:
	.long 0x3f800000
	.align 2
.LC34:
	.long 0x0
	.section	".text"
	.align 2
	.globl railbot_sight
	.type	 railbot_sight,@function
railbot_sight:
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
	lis 10,.LC31@ha
	lis 11,.LC30@ha
	la 10,.LC31@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC32@ha
	lfs 12,.LC30@l(11)
	la 10,.LC32@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L20
	lis 9,gi+16@ha
	lis 11,sound_sight1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC34@ha
	mr 3,31
	lwz 5,sound_sight1@l(11)
	lis 9,.LC33@ha
	la 10,.LC34@l(10)
	lis 11,.LC33@ha
	la 9,.LC33@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC33@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L21
.L20:
	lis 9,gi+16@ha
	lis 11,sound_sight2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC33@ha
	mr 3,31
	lwz 5,sound_sight2@l(11)
	lis 9,.LC33@ha
	la 10,.LC33@l(10)
	lis 11,.LC34@ha
	la 9,.LC33@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC34@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L21:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 railbot_sight,.Lfe10-railbot_sight
	.section	".rodata"
	.align 2
.LC35:
	.long 0x3f800000
	.align 2
.LC36:
	.long 0x0
	.section	".text"
	.align 2
	.globl railbot_die
	.type	 railbot_die,@function
railbot_die:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,764(31)
	cmpwi 0,0,2
	bc 12,2,.L22
	lis 9,sound_death@ha
	li 0,2
	lwz 5,sound_death@l(9)
	li 11,1
	lis 29,gi@ha
	lis 9,.LC35@ha
	stw 0,764(31)
	la 29,gi@l(29)
	la 9,.LC35@l(9)
	stw 11,788(31)
	li 4,2
	lfs 1,0(9)
	addi 28,31,4
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 2,0(9)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 3,0(9)
	lwz 9,16(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,20
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	lwz 9,1264(31)
	li 0,0
	mr 3,31
	stw 0,1256(9)
	bl G_FreeEdict
.L22:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 railbot_die,.Lfe11-railbot_die
	.align 2
	.globl SP_RailBot
	.type	 SP_RailBot,@function
SP_RailBot:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi+164@ha
	mr 31,3
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 30,3
	lis 4,.LC17@ha
	la 4,.LC17@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L26
	li 0,1
	lwz 3,1256(31)
	b .L27
.L26:
	lis 4,.LC18@ha
	mr 3,30
	la 4,.LC18@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L28
	li 0,0
	lwz 3,1256(31)
	b .L27
.L28:
	lwz 0,1256(31)
	mr 3,0
	subfic 9,0,0
	adde 0,9,0
.L27:
	cmpwi 0,0,1
	bc 4,2,.L32
	cmpwi 0,3,0
	bc 4,2,.L25
.L32:
	cmpwi 0,0,0
	bc 4,2,.L33
	cmpwi 0,3,0
	bc 12,2,.L25
.L33:
	cmpwi 0,3,0
	bc 12,2,.L34
	bl G_FreeEdict
	li 0,0
	lis 9,gi+8@ha
	stw 0,1256(31)
	lis 5,.LC19@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	la 5,.LC19@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L25
.L34:
	mr 3,31
	bl spawn_railbot
	lis 9,gi+8@ha
	lis 5,.LC20@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC20@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L25:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 SP_RailBot,.Lfe12-SP_RailBot
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
