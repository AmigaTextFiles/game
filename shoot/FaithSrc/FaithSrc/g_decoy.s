	.file	"g_decoy.c"
gcc2_compiled.:
	.globl decoy_frames_stand1
	.section	".data"
	.align 2
	.type	 decoy_frames_stand1,@object
decoy_frames_stand1:
	.long ai_stand
	.long 0x0
	.long decoy_idle
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
	.size	 decoy_frames_stand1,480
	.globl decoy_move_stand1
	.align 2
	.type	 decoy_move_stand1,@object
	.size	 decoy_move_stand1,16
decoy_move_stand1:
	.long 0
	.long 39
	.long decoy_frames_stand1
	.long decoy_stand
	.globl decoy_frames_taunt1
	.align 2
	.type	 decoy_frames_taunt1,@object
decoy_frames_taunt1:
	.long ai_stand
	.long 0x0
	.long decoy_idle
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
	.size	 decoy_frames_taunt1,204
	.globl decoy_move_taunt1
	.align 2
	.type	 decoy_move_taunt1,@object
	.size	 decoy_move_taunt1,16
decoy_move_taunt1:
	.long 95
	.long 111
	.long decoy_frames_taunt1
	.long decoy_taunt
	.globl decoy_frames_run
	.align 2
	.type	 decoy_frames_run,@object
decoy_frames_run:
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
	.size	 decoy_frames_run,72
	.globl decoy_move_run
	.align 2
	.type	 decoy_move_run,@object
	.size	 decoy_move_run,16
decoy_move_run:
	.long 40
	.long 45
	.long decoy_frames_run
	.long decoy_run
	.globl decoy_frames_pain1
	.align 2
	.type	 decoy_frames_pain1,@object
decoy_frames_pain1:
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
	.size	 decoy_frames_pain1,48
	.globl decoy_move_pain1
	.align 2
	.type	 decoy_move_pain1,@object
	.size	 decoy_move_pain1,16
decoy_move_pain1:
	.long 54
	.long 57
	.long decoy_frames_pain1
	.long decoy_run
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
.LC3:
	.string	"soul"
	.align 2
.LC2:
	.long 0x46fffe00
	.align 3
.LC4:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC5:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC6:
	.long 0x40590000
	.long 0x0
	.align 2
.LC7:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl decoy_fire
	.type	 decoy_fire,@function
decoy_fire:
	stwu 1,-224(1)
	mflr 0
	stfd 27,184(1)
	stfd 28,192(1)
	stfd 29,200(1)
	stfd 30,208(1)
	stfd 31,216(1)
	stmw 22,144(1)
	stw 0,228(1)
	mr 29,4
	lis 9,shotgun_flash@ha
	mr 31,3
	slwi 0,29,2
	la 9,shotgun_flash@l(9)
	addi 30,1,32
	addi 24,1,48
	lwzx 22,9,0
	addi 3,31,16
	mr 4,30
	mr 5,24
	li 6,0
	bl AngleVectors
	lfs 0,4(31)
	addi 29,29,-5
	lfs 12,8(31)
	cmplwi 0,29,1
	lfs 11,12(31)
	stfs 0,16(1)
	stfs 12,20(1)
	stfs 11,24(1)
	bc 12,1,.L15
	lfs 0,32(1)
	addi 23,1,80
	lfs 13,36(1)
	lfs 12,40(1)
	stfs 0,80(1)
	stfs 13,84(1)
	stfs 12,88(1)
	b .L16
.L15:
	lwz 9,540(31)
	lis 28,0x4330
	lis 10,.LC4@ha
	addi 26,1,80
	lfs 13,4(9)
	la 10,.LC4@l(10)
	addi 27,1,96
	lfd 31,0(10)
	addi 29,1,112
	addi 25,1,64
	lis 10,.LC5@ha
	mr 3,26
	stfs 13,112(1)
	la 10,.LC5@l(10)
	mr 4,27
	fsubs 13,13,0
	lfd 28,0(10)
	mr 23,26
	lfs 0,8(9)
	lis 10,.LC6@ha
	la 10,.LC6@l(10)
	lfd 27,0(10)
	stfs 0,116(1)
	fsubs 0,0,12
	lfs 12,12(9)
	stfs 12,120(1)
	lwz 0,508(9)
	stfs 0,84(1)
	xoris 0,0,0x8000
	stfs 13,80(1)
	stw 0,140(1)
	stw 28,136(1)
	lfd 0,136(1)
	fsub 0,0,31
	frsp 0,0
	fadds 12,12,0
	fsubs 13,12,11
	stfs 12,120(1)
	stfs 13,88(1)
	bl vectoangles
	mr 6,25
	mr 4,30
	mr 5,24
	mr 3,27
	bl AngleVectors
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC2@ha
	stw 3,140(1)
	stw 28,136(1)
	lfd 0,136(1)
	lfs 29,.LC2@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 30,0
	fsub 30,30,28
	fadd 30,30,30
	fmul 30,30,27
	frsp 30,30
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC7@ha
	stw 3,140(1)
	la 10,.LC7@l(10)
	mr 4,30
	stw 28,136(1)
	addi 3,1,16
	mr 5,29
	lfd 0,136(1)
	lfs 1,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 31,0
	fsub 31,31,28
	fadd 31,31,31
	fmul 31,31,27
	frsp 31,31
	bl VectorMA
	fmr 1,30
	mr 4,24
	mr 3,29
	mr 5,29
	bl VectorMA
	fmr 1,31
	mr 3,29
	mr 4,25
	mr 5,3
	bl VectorMA
	lfs 11,16(1)
	mr 3,26
	lfs 12,112(1)
	lfs 13,116(1)
	lfs 10,20(1)
	fsubs 12,12,11
	lfs 0,120(1)
	lfs 11,24(1)
	fsubs 13,13,10
	stfs 12,80(1)
	fsubs 0,0,11
	stfs 13,84(1)
	stfs 0,88(1)
	bl VectorNormalize
.L16:
	lwz 3,280(31)
	lis 4,.LC3@ha
	la 4,.LC3@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L17
	mr 3,31
	mr 5,23
	addi 4,1,16
	li 6,20
	li 7,650
	li 8,57
	bl monster_fire_rocket
	b .L18
.L17:
	stw 22,8(1)
	mr 3,31
	mr 5,23
	addi 4,1,16
	li 6,5
	li 7,1
	li 8,1000
	li 9,500
	li 10,12
	bl monster_fire_shotgun
.L18:
	lwz 0,228(1)
	mtlr 0
	lmw 22,144(1)
	lfd 27,184(1)
	lfd 28,192(1)
	lfd 29,200(1)
	lfd 30,208(1)
	lfd 31,216(1)
	la 1,224(1)
	blr
.Lfe1:
	.size	 decoy_fire,.Lfe1-decoy_fire
	.globl decoy_frames_attack1
	.section	".data"
	.align 2
	.type	 decoy_frames_attack1,@object
decoy_frames_attack1:
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long decoy_fire1
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
	.size	 decoy_frames_attack1,96
	.globl decoy_move_attack1
	.align 2
	.type	 decoy_move_attack1,@object
	.size	 decoy_move_attack1,16
decoy_move_attack1:
	.long 46
	.long 53
	.long decoy_frames_attack1
	.long decoy_run
	.section	".rodata"
	.align 2
.LC9:
	.string	"models/monsters/tris.md2"
	.align 2
.LC10:
	.string	"models/monsters/w_rlauncher.md2"
	.align 2
.LC11:
	.string	"decoy"
	.align 2
.LC12:
	.string	"soldier/solidle1.wav"
	.align 2
.LC13:
	.string	"soldier/solsght1.wav"
	.align 2
.LC14:
	.string	"soldier/solsrch1.wav"
	.align 2
.LC15:
	.string	"soldier/solpain1.wav"
	.align 2
.LC16:
	.string	"misc/keyuse.wav"
	.align 2
.LC17:
	.string	"monsters/idle.wav"
	.align 2
.LC18:
	.string	"monsters/sight1.wav"
	.align 2
.LC19:
	.string	"monsters/sight2.wav"
	.align 2
.LC20:
	.string	"monsters/pain.wav"
	.align 2
.LC21:
	.string	"monsters/death.wav"
	.align 2
.LC22:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl spawn_decoy
	.type	 spawn_decoy,@function
spawn_decoy:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 30,3
	mr 28,4
	bl G_Spawn
	mr 31,3
	addi 4,1,8
	lwz 3,84(30)
	li 6,0
	li 5,0
	addi 3,3,3668
	bl AngleVectors
	lis 9,.LC22@ha
	addi 3,30,4
	la 9,.LC22@l(9)
	addi 4,1,8
	lfs 1,0(9)
	addi 5,31,4
	bl VectorMA
	cmpwi 0,28,0
	stw 31,892(30)
	stw 30,896(31)
	bc 4,2,.L27
	lwz 0,268(30)
	stw 0,268(31)
	lwz 9,60(30)
	stw 9,60(31)
	lwz 0,40(30)
	stw 0,40(31)
	lwz 9,44(30)
	stw 9,44(31)
	b .L28
.L27:
	lis 29,gi@ha
	lis 4,.LC9@ha
	la 29,gi@l(29)
	mr 3,31
	lwz 9,44(29)
	la 4,.LC9@l(4)
	mtlr 9
	blrl
	lwz 0,32(29)
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
	mtlr 0
	blrl
	stw 3,44(31)
.L28:
	cmpwi 0,28,0
	bc 4,2,.L29
	stw 28,64(31)
	b .L30
.L29:
	li 0,16384
	stw 0,64(31)
.L30:
	li 0,0
	stw 0,56(31)
	bc 4,2,.L31
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	b .L37
.L31:
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
.L37:
	stw 9,280(31)
	li 0,80
	bc 4,2,.L33
	li 0,50
.L33:
	stw 0,484(31)
	stw 0,480(31)
	lis 9,decoy_pain@ha
	lis 11,decoy_die@ha
	lis 10,decoy_stand@ha
	la 9,decoy_pain@l(9)
	la 11,decoy_die@l(11)
	la 10,decoy_stand@l(10)
	stw 9,452(31)
	lis 0,0x3f80
	lis 4,0x201
	stw 11,456(31)
	lis 8,decoy_run@ha
	lis 6,decoy_attack@ha
	stw 10,788(31)
	lis 5,decoy_sight@ha
	stw 0,784(31)
	li 7,0
	lis 29,0xc180
	lis 28,0x4180
	stw 7,816(31)
	li 3,2
	la 8,decoy_run@l(8)
	stw 29,192(31)
	la 6,decoy_attack@l(6)
	la 5,decoy_sight@l(5)
	stw 8,804(31)
	lis 9,0xc1c0
	lis 10,0x4200
	stw 28,204(31)
	li 11,5
	ori 4,4,3
	stw 9,196(31)
	li 0,100
	stw 10,208(31)
	stw 11,260(31)
	stw 4,252(31)
	stw 3,512(31)
	stw 0,400(31)
	stw 6,812(31)
	stw 5,820(31)
	stw 29,188(31)
	stw 28,200(31)
	stw 3,248(31)
	stw 7,800(31)
	stw 7,808(31)
	bc 4,2,.L35
	lis 29,gi@ha
	lis 3,.LC12@ha
	la 29,gi@l(29)
	la 3,.LC12@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_idle@ha
	lis 11,.LC13@ha
	stw 3,sound_idle@l(9)
	mtlr 10
	la 3,.LC13@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sight1@ha
	lis 11,.LC14@ha
	stw 3,sound_sight1@l(9)
	mtlr 10
	la 3,.LC14@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sight2@ha
	lis 11,.LC15@ha
	stw 3,sound_sight2@l(9)
	mtlr 10
	la 3,.LC15@l(11)
	blrl
	lis 9,sound_pain@ha
	lwz 0,36(29)
	lis 11,.LC16@ha
	stw 3,sound_pain@l(9)
	la 3,.LC16@l(11)
	b .L39
.L35:
	lis 29,gi@ha
	lis 3,.LC17@ha
	la 29,gi@l(29)
	la 3,.LC17@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_idle@ha
	lis 11,.LC18@ha
	stw 3,sound_idle@l(9)
	mtlr 10
	la 3,.LC18@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sight1@ha
	lis 11,.LC19@ha
	stw 3,sound_sight1@l(9)
	mtlr 10
	la 3,.LC19@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sight2@ha
	lis 11,.LC20@ha
	stw 3,sound_sight2@l(9)
	mtlr 10
	la 3,.LC20@l(11)
	blrl
	lis 9,sound_pain@ha
	lwz 0,36(29)
	lis 11,.LC21@ha
	stw 3,sound_pain@l(9)
	la 3,.LC21@l(11)
.L39:
	mtlr 0
	blrl
	lis 9,sound_death@ha
	stw 3,sound_death@l(9)
	li 0,-50
	lis 9,gi+72@ha
	stw 0,488(31)
	mr 3,31
	lfs 0,16(30)
	stfs 0,16(31)
	lfs 13,20(30)
	stfs 13,20(31)
	lfs 0,24(30)
	stfs 0,24(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	mr 3,31
	bl walkmonster_start
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 spawn_decoy,.Lfe2-spawn_decoy
	.section	".rodata"
	.align 2
.LC23:
	.string	"on"
	.align 2
.LC24:
	.string	"off"
	.align 2
.LC25:
	.string	"Illusion destroyed.\n"
	.align 2
.LC26:
	.string	"Soul destroyed. \n"
	.align 2
.LC27:
	.string	"Illusion created.\n"
	.section	".text"
	.align 2
	.globl SP_Decoy
	.type	 SP_Decoy,@function
SP_Decoy:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+164@ha
	mr 29,4
	lwz 0,gi+164@l(9)
	mr 31,3
	mtlr 0
	blrl
	mr 30,3
	lis 4,.LC23@ha
	la 4,.LC23@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L41
	li 0,1
	lwz 3,892(31)
	b .L42
.L41:
	lis 4,.LC24@ha
	mr 3,30
	la 4,.LC24@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L43
	li 0,0
	lwz 3,892(31)
	b .L42
.L43:
	lwz 0,892(31)
	mr 3,0
	subfic 9,0,0
	adde 0,9,0
.L42:
	cmpwi 0,0,1
	bc 4,2,.L47
	cmpwi 0,3,0
	bc 4,2,.L40
.L47:
	cmpwi 0,0,0
	bc 4,2,.L48
	cmpwi 0,3,0
	bc 12,2,.L40
.L48:
	cmpwi 7,29,0
	cmpwi 0,3,0
	mfcr 30
	rlwinm 30,30,28,0xf0000000
	bc 12,2,.L49
	bl G_FreeEdict
	li 0,0
	mtcrf 128,30
	stw 0,892(31)
	bc 4,2,.L50
	lis 9,gi+8@ha
	lis 5,.LC25@ha
	lwz 0,gi+8@l(9)
	la 5,.LC25@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L49
.L50:
	lis 9,gi+8@ha
	lis 5,.LC26@ha
	lwz 0,gi+8@l(9)
	la 5,.LC26@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L49:
	mr 4,29
	mr 3,31
	bl spawn_decoy
	mtcrf 128,30
	bc 4,2,.L40
	lis 9,gi+8@ha
	lis 5,.LC27@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC27@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L40:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 SP_Decoy,.Lfe3-SP_Decoy
	.comm	maplist,292,4
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
.LC28:
	.long 0x46fffe00
	.align 3
.LC29:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC30:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC31:
	.long 0x3f800000
	.align 2
.LC32:
	.long 0x40000000
	.align 2
.LC33:
	.long 0x0
	.section	".text"
	.align 2
	.globl decoy_idle
	.type	 decoy_idle,@function
decoy_idle:
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
	lis 11,.LC30@ha
	lis 10,.LC28@ha
	la 11,.LC30@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC29@ha
	lfs 11,.LC28@l(10)
	lfd 12,.LC29@l(11)
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
	lis 9,.LC31@ha
	lwz 5,sound_idle@l(11)
	la 9,.LC31@l(9)
	lis 11,.LC32@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC32@l(11)
	lis 9,.LC33@ha
	lfs 2,0(11)
	la 9,.LC33@l(9)
	lfs 3,0(9)
	blrl
.L7:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 decoy_idle,.Lfe4-decoy_idle
	.align 2
	.globl decoy_stand
	.type	 decoy_stand,@function
decoy_stand:
	lis 9,decoy_move_stand1@ha
	la 9,decoy_move_stand1@l(9)
	stw 9,772(3)
	blr
.Lfe5:
	.size	 decoy_stand,.Lfe5-decoy_stand
	.align 2
	.globl decoy_taunt
	.type	 decoy_taunt,@function
decoy_taunt:
	lis 9,decoy_move_taunt1@ha
	la 9,decoy_move_taunt1@l(9)
	stw 9,772(3)
	blr
.Lfe6:
	.size	 decoy_taunt,.Lfe6-decoy_taunt
	.align 2
	.globl decoy_run
	.type	 decoy_run,@function
decoy_run:
	lwz 0,776(3)
	andi. 9,0,1
	bc 12,2,.L11
	lis 9,decoy_move_stand1@ha
	la 9,decoy_move_stand1@l(9)
	stw 9,772(3)
	blr
.L11:
	lis 9,decoy_move_run@ha
	la 9,decoy_move_run@l(9)
	stw 9,772(3)
	blr
.Lfe7:
	.size	 decoy_run,.Lfe7-decoy_run
	.section	".rodata"
	.align 2
.LC34:
	.long 0x40400000
	.align 2
.LC35:
	.long 0x3f800000
	.align 2
.LC36:
	.long 0x0
	.section	".text"
	.align 2
	.globl decoy_pain
	.type	 decoy_pain,@function
decoy_pain:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,464(31)
	fcmpu 0,13,0
	bc 12,0,.L12
	lis 9,.LC34@ha
	lis 11,gi+16@ha
	la 9,.LC34@l(9)
	lfs 0,0(9)
	li 4,2
	lis 9,sound_pain@ha
	lwz 5,sound_pain@l(9)
	lis 9,.LC35@ha
	fadds 0,13,0
	la 9,.LC35@l(9)
	lfs 1,0(9)
	lis 9,.LC35@ha
	stfs 0,464(31)
	la 9,.LC35@l(9)
	lwz 0,gi+16@l(11)
	lfs 2,0(9)
	lis 9,.LC36@ha
	mtlr 0
	la 9,.LC36@l(9)
	lfs 3,0(9)
	blrl
	lis 9,decoy_move_pain1@ha
	la 9,decoy_move_pain1@l(9)
	stw 9,772(31)
.L12:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 decoy_pain,.Lfe8-decoy_pain
	.align 2
	.globl decoy_fire1
	.type	 decoy_fire1,@function
decoy_fire1:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,0
	bl decoy_fire
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 decoy_fire1,.Lfe9-decoy_fire1
	.align 2
	.globl decoy_attack
	.type	 decoy_attack,@function
decoy_attack:
	lis 9,decoy_move_attack1@ha
	la 9,decoy_move_attack1@l(9)
	stw 9,772(3)
	blr
.Lfe10:
	.size	 decoy_attack,.Lfe10-decoy_attack
	.section	".rodata"
	.align 2
.LC37:
	.long 0x46fffe00
	.align 3
.LC38:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC39:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC40:
	.long 0x3f800000
	.align 2
.LC41:
	.long 0x0
	.section	".text"
	.align 2
	.globl decoy_sight
	.type	 decoy_sight,@function
decoy_sight:
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
	lis 10,.LC38@ha
	lis 11,.LC37@ha
	la 10,.LC38@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC39@ha
	lfs 12,.LC37@l(11)
	la 10,.LC39@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L22
	lis 9,gi+16@ha
	lis 11,sound_sight1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC41@ha
	mr 3,31
	lwz 5,sound_sight1@l(11)
	lis 9,.LC40@ha
	la 10,.LC41@l(10)
	lis 11,.LC40@ha
	la 9,.LC40@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC40@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L23
.L22:
	lis 9,gi+16@ha
	lis 11,sound_sight2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC40@ha
	mr 3,31
	lwz 5,sound_sight2@l(11)
	lis 9,.LC40@ha
	la 10,.LC40@l(10)
	lis 11,.LC41@ha
	la 9,.LC40@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC41@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L23:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 decoy_sight,.Lfe11-decoy_sight
	.section	".rodata"
	.align 2
.LC42:
	.long 0x3f800000
	.align 2
.LC43:
	.long 0x0
	.section	".text"
	.align 2
	.globl decoy_die
	.type	 decoy_die,@function
decoy_die:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L24
	lis 9,sound_death@ha
	li 0,2
	lwz 5,sound_death@l(9)
	li 11,1
	lis 29,gi@ha
	lis 9,.LC42@ha
	stw 0,492(31)
	la 29,gi@l(29)
	la 9,.LC42@l(9)
	stw 11,512(31)
	li 4,2
	lfs 1,0(9)
	addi 28,31,4
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 2,0(9)
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 3,0(9)
	lwz 9,16(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,21
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
	lwz 9,896(31)
	li 0,0
	mr 3,31
	stw 0,892(9)
	bl G_FreeEdict
.L24:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 decoy_die,.Lfe12-decoy_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
