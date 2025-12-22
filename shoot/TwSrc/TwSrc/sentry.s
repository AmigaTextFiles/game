	.file	"sentry.c"
gcc2_compiled.:
	.globl sentry_frames_stand1
	.section	".data"
	.align 2
	.type	 sentry_frames_stand1,@object
sentry_frames_stand1:
	.long ai_stand
	.long 0x0
	.long sentry_idle
	.long ai_stand
	.long 0x0
	.long 0
	.size	 sentry_frames_stand1,24
	.globl sentry_move_stand1
	.align 2
	.type	 sentry_move_stand1,@object
	.size	 sentry_move_stand1,16
sentry_move_stand1:
	.long 0
	.long 0
	.long sentry_frames_stand1
	.long sentry_stand
	.globl sentry_frames_taunt1
	.align 2
	.type	 sentry_frames_taunt1,@object
sentry_frames_taunt1:
	.long ai_stand
	.long 0x0
	.long sentry_idle
	.long ai_stand
	.long 0x0
	.long 0
	.size	 sentry_frames_taunt1,24
	.globl sentry_move_taunt1
	.align 2
	.type	 sentry_move_taunt1,@object
	.size	 sentry_move_taunt1,16
sentry_move_taunt1:
	.long 95
	.long 95
	.long sentry_frames_taunt1
	.long sentry_taunt
	.globl sentry_frames_run
	.align 2
	.type	 sentry_frames_run,@object
sentry_frames_run:
	.long ai_run
	.long 0x0
	.long 0
	.size	 sentry_frames_run,12
	.globl sentry_move_run
	.align 2
	.type	 sentry_move_run,@object
	.size	 sentry_move_run,16
sentry_move_run:
	.long 40
	.long 40
	.long sentry_frames_run
	.long sentry_run
	.globl sentry_frames_pain1
	.align 2
	.type	 sentry_frames_pain1,@object
sentry_frames_pain1:
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
	.size	 sentry_frames_pain1,48
	.globl sentry_move_pain1
	.align 2
	.type	 sentry_move_pain1,@object
	.size	 sentry_move_pain1,16
sentry_move_pain1:
	.long 54
	.long 55
	.long sentry_frames_pain1
	.long sentry_run
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
	.align 2
.LC8:
	.long 0x0
	.section	".text"
	.align 2
	.globl sentry_fire
	.type	 sentry_fire,@function
sentry_fire:
	stwu 1,-224(1)
	mflr 0
	stfd 28,192(1)
	stfd 29,200(1)
	stfd 30,208(1)
	stfd 31,216(1)
	stmw 23,156(1)
	stw 0,228(1)
	mr 29,4
	lis 9,shotgun_flash@ha
	addi 31,1,32
	addi 30,1,48
	slwi 0,29,2
	la 9,shotgun_flash@l(9)
	mr 24,3
	lwzx 23,9,0
	mr 4,31
	addi 3,24,16
	mr 5,30
	li 6,0
	bl AngleVectors
	mulli 0,23,12
	lis 4,monster_flash_offset@ha
	addi 3,24,4
	la 4,monster_flash_offset@l(4)
	mr 5,31
	add 4,0,4
	mr 6,30
	addi 7,1,16
	bl G_ProjectSource
	addi 29,29,-5
	cmplwi 0,29,1
	bc 12,1,.L15
	lfs 0,32(1)
	addi 5,1,80
	lfs 13,36(1)
	lfs 12,40(1)
	stfs 0,80(1)
	stfs 13,84(1)
	stfs 12,88(1)
	b .L16
.L15:
	lwz 9,816(24)
	lis 28,0x4330
	lfs 0,16(1)
	lis 10,.LC5@ha
	addi 26,1,80
	lfs 12,4(9)
	la 10,.LC5@l(10)
	addi 27,1,96
	lfs 10,20(1)
	addi 29,1,112
	addi 25,1,64
	lfd 31,0(10)
	mr 3,26
	mr 4,27
	stfs 12,112(1)
	lis 10,.LC6@ha
	fsubs 12,12,0
	lfs 11,24(1)
	la 10,.LC6@l(10)
	lfs 0,8(9)
	lfd 28,0(10)
	stfs 0,116(1)
	lfs 13,12(9)
	fsubs 0,0,10
	stfs 13,120(1)
	lwz 0,784(9)
	stfs 0,84(1)
	xoris 0,0,0x8000
	stfs 12,80(1)
	stw 0,148(1)
	stw 28,144(1)
	lfd 0,144(1)
	fsub 0,0,31
	frsp 0,0
	fadds 13,13,0
	fsubs 11,13,11
	stfs 13,120(1)
	stfs 11,88(1)
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
	stw 3,148(1)
	lis 11,.LC3@ha
	stw 28,144(1)
	lfd 0,144(1)
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
	stw 3,148(1)
	lis 10,.LC7@ha
	mr 4,31
	stw 28,144(1)
	la 10,.LC7@l(10)
	addi 3,1,16
	lfd 0,144(1)
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
	mr 5,26
.L16:
	lis 10,.LC8@ha
	lis 9,level+4@ha
	stw 23,8(1)
	la 10,.LC8@l(10)
	lfs 0,level+4@l(9)
	mr 3,24
	lfs 13,0(10)
	addi 4,1,16
	li 6,2
	li 7,1
	li 8,1000
	li 9,500
	li 10,6
	fadds 0,0,13
	stfs 0,1180(24)
	bl monster_fire_shotgun
	lwz 0,228(1)
	mtlr 0
	lmw 23,156(1)
	lfd 28,192(1)
	lfd 29,200(1)
	lfd 30,208(1)
	lfd 31,216(1)
	la 1,224(1)
	blr
.Lfe1:
	.size	 sentry_fire,.Lfe1-sentry_fire
	.globl aimangles
	.section	".data"
	.align 2
	.type	 aimangles,@object
aimangles:
	.long 0x0
	.long 0x40a00000
	.long 0x0
	.long 0x41200000
	.long 0x41700000
	.long 0x0
	.long 0x41a00000
	.long 0x41c80000
	.long 0x0
	.long 0x41c80000
	.long 0x420c0000
	.long 0x0
	.long 0x41f00000
	.long 0x42200000
	.long 0x0
	.long 0x41f00000
	.long 0x42340000
	.long 0x0
	.long 0x41c80000
	.long 0x42480000
	.long 0x0
	.long 0x41a00000
	.long 0x42200000
	.long 0x0
	.long 0x41700000
	.long 0x420c0000
	.long 0x0
	.long 0x42200000
	.long 0x420c0000
	.long 0x0
	.long 0x428c0000
	.long 0x420c0000
	.long 0x0
	.long 0x42b40000
	.long 0x420c0000
	.long 0x0
	.size	 aimangles,144
	.section	".rodata"
	.align 2
.LC9:
	.long 0x46fffe00
	.align 3
.LC10:
	.long 0x408f4000
	.long 0x0
	.align 3
.LC11:
	.long 0x407f4000
	.long 0x0
	.align 3
.LC12:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC13:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC14:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl SentryMachineGun
	.type	 SentryMachineGun,@function
SentryMachineGun:
	stwu 1,-240(1)
	mflr 0
	stfd 28,208(1)
	stfd 29,216(1)
	stfd 30,224(1)
	stfd 31,232(1)
	stmw 23,172(1)
	stw 0,244(1)
	lis 9,shotgun_flash@ha
	addi 31,1,40
	addi 30,1,56
	slwi 0,23,2
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
	addi 0,23,-5
	cmplwi 0,0,1
	bc 12,1,.L21
	lfs 0,40(1)
	addi 5,1,136
	lfs 13,44(1)
	lfs 12,48(1)
	stfs 0,136(1)
	stfs 13,140(1)
	stfs 12,144(1)
	b .L22
.L21:
	lwz 9,816(24)
	lis 28,0x4330
	lfs 0,8(1)
	lis 10,.LC12@ha
	addi 26,1,136
	lfs 12,4(9)
	la 10,.LC12@l(10)
	addi 27,1,120
	lfs 10,12(1)
	addi 29,1,104
	addi 25,1,88
	lfd 31,0(10)
	mr 3,26
	mr 4,27
	stfs 12,104(1)
	lis 10,.LC13@ha
	fsubs 12,12,0
	lfs 11,16(1)
	la 10,.LC13@l(10)
	lfs 0,8(9)
	lfd 28,0(10)
	stfs 0,108(1)
	lfs 13,12(9)
	fsubs 0,0,10
	stfs 13,112(1)
	lwz 0,784(9)
	stfs 0,140(1)
	xoris 0,0,0x8000
	stfs 12,136(1)
	stw 0,164(1)
	stw 28,160(1)
	lfd 0,160(1)
	fsub 0,0,31
	frsp 0,0
	fadds 13,13,0
	fsubs 11,13,11
	stfs 13,112(1)
	stfs 11,144(1)
	bl vectoangles
	mr 6,25
	mr 4,31
	mr 5,30
	mr 3,27
	bl AngleVectors
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC9@ha
	stw 3,164(1)
	lis 11,.LC10@ha
	stw 28,160(1)
	lfd 0,160(1)
	lfs 29,.LC9@l(10)
	lfd 13,.LC10@l(11)
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
	lis 11,.LC11@ha
	stw 3,164(1)
	lis 10,.LC14@ha
	mr 4,31
	stw 28,160(1)
	la 10,.LC14@l(10)
	addi 3,1,8
	lfd 0,160(1)
	mr 5,29
	lfd 13,.LC11@l(11)
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
	stfs 12,136(1)
	fsubs 0,0,11
	stfs 13,140(1)
	stfs 0,144(1)
	bl VectorNormalize
	mr 5,26
.L22:
	mr 3,24
	mr 10,23
	addi 4,1,8
	li 6,3
	li 7,4
	li 8,300
	li 9,500
	bl fire_bullet
	lwz 0,244(1)
	mtlr 0
	lmw 23,172(1)
	lfd 28,208(1)
	lfd 29,216(1)
	lfd 30,224(1)
	lfd 31,232(1)
	la 1,240(1)
	blr
.Lfe2:
	.size	 SentryMachineGun,.Lfe2-SentryMachineGun
	.globl sentry_frames_attack1
	.section	".data"
	.align 2
	.type	 sentry_frames_attack1,@object
sentry_frames_attack1:
	.long ai_charge
	.long 0x0
	.long sentry2_fire
	.size	 sentry_frames_attack1,12
	.globl sentry_move_attack1
	.align 2
	.type	 sentry_move_attack1,@object
	.size	 sentry_move_attack1,16
sentry_move_attack1:
	.long 46
	.long 46
	.long sentry_frames_attack1
	.long sentry_run
	.section	".rodata"
	.align 2
.LC16:
	.string	"models/sentry/turret1/tris.md2"
	.align 2
.LC17:
	.string	"sentry"
	.align 2
.LC18:
	.string	"soldier/solsght1.wav"
	.align 2
.LC19:
	.string	"soldier/solsrch1.wav"
	.align 2
.LC20:
	.string	"player/male/pain50_1.wav"
	.align 2
.LC21:
	.string	"misc/keyuse.wav"
	.align 2
.LC22:
	.string	"soldier/solatck1.wav"
	.align 2
.LC23:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl spawn_sentry
	.type	 spawn_sentry,@function
spawn_sentry:
	stwu 1,-80(1)
	mflr 0
	stmw 21,36(1)
	stw 0,84(1)
	mr 27,3
	li 22,0
	bl G_Spawn
	lwz 9,84(27)
	mr 29,3
	li 6,0
	addi 4,1,8
	li 5,0
	addi 3,9,3752
	bl AngleVectors
	lis 9,.LC23@ha
	addi 4,1,8
	la 9,.LC23@l(9)
	addi 5,29,4
	lfs 1,0(9)
	addi 3,27,4
	bl VectorMA
	stw 29,1252(27)
	lis 28,gi@ha
	lis 3,.LC16@ha
	la 28,gi@l(28)
	stw 27,1264(29)
	la 3,.LC16@l(3)
	stw 22,60(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,.LC17@ha
	li 0,20
	stw 3,40(29)
	la 9,.LC17@l(9)
	stw 0,756(29)
	lis 6,0x201
	stw 9,284(29)
	lis 26,sentry_pain@ha
	lis 25,sentry_die@ha
	stw 0,728(29)
	lis 9,0xc180
	lis 5,sentry_stand@ha
	stw 22,64(29)
	lis 0,0x3f80
	lis 8,sentry_attack@ha
	stw 22,56(29)
	lis 4,sentry_sight@ha
	la 8,sentry_attack@l(8)
	lwz 11,908(27)
	la 5,sentry_stand@l(5)
	la 4,sentry_sight@l(4)
	stw 0,1136(29)
	ori 6,6,3
	lis 7,0x4180
	stw 11,908(29)
	lis 0,0x4200
	lis 10,0xc200
	stw 9,188(29)
	lis 11,0xc1c0
	la 26,sentry_pain@l(26)
	la 25,sentry_die@l(25)
	li 21,2
	stw 7,200(29)
	li 9,5
	lis 24,0x4100
	stw 6,252(29)
	li 23,4000
	stw 5,1140(29)
	lis 3,.LC18@ha
	stw 8,1164(29)
	la 3,.LC18@l(3)
	stw 4,1172(29)
	stw 8,1156(29)
	stw 0,208(29)
	stw 10,192(29)
	stw 11,196(29)
	stw 24,204(29)
	stw 9,264(29)
	stw 21,788(29)
	stw 23,644(29)
	stw 26,696(29)
	stw 25,700(29)
	stw 22,1168(29)
	stw 21,248(29)
	stw 22,1152(29)
	stw 22,1160(29)
	lwz 9,36(28)
	mtlr 9
	blrl
	lwz 10,36(28)
	lis 9,sound_sight1@ha
	lis 11,.LC19@ha
	stw 3,sound_sight1@l(9)
	mtlr 10
	la 3,.LC19@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_sight2@ha
	lis 11,.LC20@ha
	stw 3,sound_sight2@l(9)
	mtlr 10
	la 3,.LC20@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_pain@ha
	lis 11,.LC21@ha
	stw 3,sound_pain@l(9)
	mtlr 10
	la 3,.LC21@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_death@ha
	lis 11,.LC22@ha
	stw 3,sound_death@l(9)
	mtlr 10
	la 3,.LC22@l(11)
	blrl
	li 9,-10
	li 0,180
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
	lmw 21,36(1)
	la 1,80(1)
	blr
.Lfe3:
	.size	 spawn_sentry,.Lfe3-spawn_sentry
	.section	".rodata"
	.align 2
.LC24:
	.string	"on"
	.align 2
.LC25:
	.string	"off"
	.align 2
.LC26:
	.string	"sentry destroyed.\n"
	.align 2
.LC27:
	.string	"sentry created.\n"
	.section	".text"
	.align 2
	.globl SP_sentry
	.type	 SP_sentry,@function
SP_sentry:
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
	lis 4,.LC24@ha
	la 4,.LC24@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L31
	li 0,1
	lwz 3,1252(31)
	b .L32
.L31:
	lis 4,.LC25@ha
	mr 3,30
	la 4,.LC25@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L33
	li 0,0
	lwz 3,1252(31)
	b .L32
.L33:
	lwz 0,1252(31)
	mr 3,0
	subfic 9,0,0
	adde 0,9,0
.L32:
	cmpwi 0,0,1
	bc 4,2,.L37
	cmpwi 0,3,0
	bc 4,2,.L30
.L37:
	cmpwi 0,0,0
	bc 4,2,.L38
	cmpwi 0,3,0
	bc 12,2,.L30
.L38:
	cmpwi 0,3,0
	bc 12,2,.L39
	bl G_FreeEdict
	li 0,0
	lis 9,gi+8@ha
	stw 0,1252(31)
	lis 5,.LC26@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	la 5,.LC26@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L30
.L39:
	mr 3,31
	bl spawn_sentry
	lis 9,gi+8@ha
	lis 5,.LC27@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC27@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L30:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 SP_sentry,.Lfe4-SP_sentry
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
	.globl sentry_idle
	.type	 sentry_idle,@function
sentry_idle:
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
.Lfe5:
	.size	 sentry_idle,.Lfe5-sentry_idle
	.align 2
	.globl sentry_stand
	.type	 sentry_stand,@function
sentry_stand:
	lis 9,sentry_move_stand1@ha
	la 9,sentry_move_stand1@l(9)
	stw 9,1124(3)
	blr
.Lfe6:
	.size	 sentry_stand,.Lfe6-sentry_stand
	.align 2
	.globl sentry_taunt
	.type	 sentry_taunt,@function
sentry_taunt:
	lis 9,sentry_move_taunt1@ha
	la 9,sentry_move_taunt1@l(9)
	stw 9,1124(3)
	blr
.Lfe7:
	.size	 sentry_taunt,.Lfe7-sentry_taunt
	.align 2
	.globl sentry_run
	.type	 sentry_run,@function
sentry_run:
	lwz 0,1128(3)
	andi. 9,0,1
	bc 12,2,.L11
	lis 9,sentry_move_stand1@ha
	la 9,sentry_move_stand1@l(9)
	stw 9,1124(3)
	blr
.L11:
	lis 9,sentry_move_run@ha
	la 9,sentry_move_run@l(9)
	stw 9,1124(3)
	blr
.Lfe8:
	.size	 sentry_run,.Lfe8-sentry_run
	.align 2
	.globl sentry_pain
	.type	 sentry_pain,@function
sentry_pain:
	blr
.Lfe9:
	.size	 sentry_pain,.Lfe9-sentry_pain
	.align 2
	.globl sentry2_fire
	.type	 sentry2_fire,@function
sentry2_fire:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 4,0
	bl sentry_fire
	mr 3,31
	li 4,0
	bl sentry_fire
	lis 9,level+4@ha
	lfs 13,1180(31)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L18
	lwz 0,1128(31)
	rlwinm 0,0,0,25,23
	b .L40
.L18:
	lwz 0,1128(31)
	ori 0,0,128
.L40:
	stw 0,1128(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 sentry2_fire,.Lfe10-sentry2_fire
	.align 2
	.globl sentry_attack
	.type	 sentry_attack,@function
sentry_attack:
	lis 9,sentry_move_attack1@ha
	la 9,sentry_move_attack1@l(9)
	stw 9,1124(3)
	blr
.Lfe11:
	.size	 sentry_attack,.Lfe11-sentry_attack
	.section	".rodata"
	.align 2
.LC34:
	.long 0x46fffe00
	.align 3
.LC35:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC36:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC37:
	.long 0x3f800000
	.align 2
.LC38:
	.long 0x0
	.section	".text"
	.align 2
	.globl sentry_sight
	.type	 sentry_sight,@function
sentry_sight:
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
	lis 10,.LC35@ha
	lis 11,.LC34@ha
	la 10,.LC35@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC36@ha
	lfs 12,.LC34@l(11)
	la 10,.LC36@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L25
	lis 9,gi+16@ha
	lis 11,sound_sight1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC38@ha
	mr 3,31
	lwz 5,sound_sight1@l(11)
	lis 9,.LC37@ha
	la 10,.LC38@l(10)
	lis 11,.LC37@ha
	la 9,.LC37@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC37@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L26
.L25:
	lis 9,gi+16@ha
	lis 11,sound_sight2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC37@ha
	mr 3,31
	lwz 5,sound_sight2@l(11)
	lis 9,.LC37@ha
	la 10,.LC37@l(10)
	lis 11,.LC38@ha
	la 9,.LC37@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC38@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L26:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 sentry_sight,.Lfe12-sentry_sight
	.section	".rodata"
	.align 2
.LC39:
	.long 0x3f800000
	.align 2
.LC40:
	.long 0x0
	.section	".text"
	.align 2
	.globl sentry_die
	.type	 sentry_die,@function
sentry_die:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,764(31)
	cmpwi 0,0,2
	bc 12,2,.L27
	lis 9,sound_death@ha
	li 0,2
	lwz 5,sound_death@l(9)
	li 11,1
	lis 29,gi@ha
	lis 9,.LC39@ha
	stw 0,764(31)
	la 29,gi@l(29)
	la 9,.LC39@l(9)
	stw 11,788(31)
	li 4,2
	lfs 1,0(9)
	addi 28,31,4
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 2,0(9)
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 3,0(9)
	lwz 9,16(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,8
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
	stw 0,1252(9)
	bl G_FreeEdict
.L27:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 sentry_die,.Lfe13-sentry_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
