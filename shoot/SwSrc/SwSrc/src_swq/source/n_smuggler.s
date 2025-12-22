	.file	"n_smuggler.c"
gcc2_compiled.:
	.globl smuggler_frames_stand
	.section	".data"
	.align 2
	.type	 smuggler_frames_stand,@object
smuggler_frames_stand:
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
	.size	 smuggler_frames_stand,96
	.globl smuggler_move_stand
	.align 2
	.type	 smuggler_move_stand,@object
	.size	 smuggler_move_stand,16
smuggler_move_stand:
	.long 0
	.long 7
	.long smuggler_frames_stand
	.long 0
	.globl smuggler_frames_walk
	.align 2
	.type	 smuggler_frames_walk,@object
smuggler_frames_walk:
	.long ai_walk
	.long 0x41000000
	.long smuggler_update_head
	.long ai_walk
	.long 0x41000000
	.long smuggler_update_head
	.long ai_walk
	.long 0x41000000
	.long smuggler_update_head
	.long ai_walk
	.long 0x41000000
	.long smuggler_update_head
	.long ai_walk
	.long 0x41000000
	.long smuggler_update_head
	.long ai_walk
	.long 0x41000000
	.long smuggler_update_head
	.long ai_walk
	.long 0x41000000
	.long smuggler_update_head
	.long ai_walk
	.long 0x41000000
	.long smuggler_update_head
	.long ai_walk
	.long 0x41000000
	.long smuggler_update_head
	.long ai_walk
	.long 0x41000000
	.long smuggler_update_head
	.size	 smuggler_frames_walk,120
	.globl smuggler_move_walk
	.align 2
	.type	 smuggler_move_walk,@object
	.size	 smuggler_move_walk,16
smuggler_move_walk:
	.long 82
	.long 91
	.long smuggler_frames_walk
	.long 0
	.globl smuggler_frames_run
	.align 2
	.type	 smuggler_frames_run,@object
smuggler_frames_run:
	.long ai_run
	.long 0x40800000
	.long smuggler_update_head
	.long ai_run
	.long 0x41700000
	.long smuggler_update_head
	.long ai_run
	.long 0x41700000
	.long smuggler_update_head
	.long ai_run
	.long 0x41000000
	.long smuggler_update_head
	.long ai_run
	.long 0x41a00000
	.long smuggler_update_head
	.long ai_run
	.long 0x41700000
	.long smuggler_update_head
	.size	 smuggler_frames_run,72
	.globl smuggler_move_run
	.align 2
	.type	 smuggler_move_run,@object
	.size	 smuggler_move_run,16
smuggler_move_run:
	.long 102
	.long 107
	.long smuggler_frames_run
	.long 0
	.globl smuggler_frames_deatha
	.align 2
	.type	 smuggler_frames_deatha,@object
smuggler_frames_deatha:
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.size	 smuggler_frames_deatha,120
	.globl smuggler_move_deatha
	.align 2
	.type	 smuggler_move_deatha,@object
	.size	 smuggler_move_deatha,16
smuggler_move_deatha:
	.long 152
	.long 160
	.long smuggler_frames_deatha
	.long smuggler_dead
	.globl smuggler_frames_deathb
	.align 2
	.type	 smuggler_frames_deathb,@object
smuggler_frames_deathb:
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.size	 smuggler_frames_deathb,96
	.globl smuggler_move_deathb
	.align 2
	.type	 smuggler_move_deathb,@object
	.size	 smuggler_move_deathb,16
smuggler_move_deathb:
	.long 161
	.long 168
	.long smuggler_frames_deathb
	.long smuggler_dead
	.globl smuggler_frames_deathc
	.align 2
	.type	 smuggler_frames_deathc,@object
smuggler_frames_deathc:
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.long ai_move
	.long 0x0
	.long smuggler_update_head
	.size	 smuggler_frames_deathc,108
	.globl smuggler_move_deathc
	.align 2
	.type	 smuggler_move_deathc,@object
	.size	 smuggler_move_deathc,16
smuggler_move_deathc:
	.long 169
	.long 178
	.long smuggler_frames_deathc
	.long smuggler_dead
	.section	".rodata"
	.align 2
.LC8:
	.string	"weapons/pistol/fire.wav"
	.align 2
.LC3:
	.long 0xbe4ccccd
	.align 2
.LC4:
	.long 0xbdcccccd
	.align 2
.LC5:
	.long 0x46fffe00
	.align 2
.LC6:
	.long 0xbd75c28f
	.align 2
.LC7:
	.long 0x3d75c28f
	.align 2
.LC9:
	.long 0x0
	.align 2
.LC10:
	.long 0x45000000
	.align 2
.LC11:
	.long 0xbe800000
	.align 2
.LC12:
	.long 0x3f800000
	.align 2
.LC13:
	.long 0x40000000
	.align 2
.LC14:
	.long 0x40400000
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC16:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC17:
	.long 0x44480000
	.align 2
.LC18:
	.long 0x43960000
	.align 2
.LC19:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl smuggler_fire
	.type	 smuggler_fire,@function
smuggler_fire:
	stwu 1,-208(1)
	mflr 0
	stfd 27,168(1)
	stfd 28,176(1)
	stfd 29,184(1)
	stfd 30,192(1)
	stfd 31,200(1)
	stmw 22,128(1)
	stw 0,212(1)
	mr 31,3
	addi 28,1,24
	mr 23,28
	bl smuggler_update_head
	lis 24,skill@ha
	addi 29,1,40
	mr 4,28
	addi 3,31,16
	mr 5,29
	li 6,0
	mr 22,29
	bl AngleVectors
	lis 4,monster_flash_offset@ha
	addi 3,31,4
	la 4,monster_flash_offset@l(4)
	mr 5,28
	addi 4,4,468
	mr 6,29
	addi 7,1,8
	bl G_ProjectSource
	lis 9,.LC9@ha
	lis 11,skill@ha
	la 9,.LC9@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,1,.L20
	lwz 0,60(31)
	cmpwi 0,0,1
	bc 12,1,.L20
	lwz 9,540(31)
	lis 10,.LC10@ha
	addi 0,1,104
	la 10,.LC10@l(10)
	mr 3,31
	lfs 13,4(9)
	addi 4,1,8
	mr 5,0
	lfs 1,0(10)
	addi 6,9,376
	li 7,0
	mr 30,0
	stfs 13,104(1)
	lfs 0,8(9)
	stfs 0,108(1)
	lfs 13,12(9)
	stfs 13,112(1)
	bl predictTargPos
	b .L21
.L20:
	lwz 9,540(31)
	addi 30,1,104
	lfs 0,4(9)
	stfs 0,104(1)
	lfs 13,8(9)
	stfs 13,108(1)
	lfs 0,12(9)
	stfs 0,112(1)
.L21:
	lis 9,skill@ha
	lis 10,.LC9@ha
	lwz 11,skill@l(9)
	la 10,.LC9@l(10)
	lfs 0,0(10)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L22
	lis 11,.LC11@ha
	lwz 4,540(31)
	mr 3,30
	la 11,.LC11@l(11)
	mr 5,30
	lfs 1,0(11)
	b .L35
.L22:
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L24
	lis 9,.LC3@ha
	lwz 4,540(31)
	mr 3,30
	lfs 1,.LC3@l(9)
	b .L36
.L24:
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L26
	lis 9,.LC4@ha
	lwz 4,540(31)
	mr 3,30
	lfs 1,.LC4@l(9)
	b .L36
.L26:
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L23
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,124(1)
	lis 10,.LC15@ha
	lis 11,.LC5@ha
	la 10,.LC15@l(10)
	stw 0,120(1)
	lfd 13,0(10)
	lfd 0,120(1)
	lis 10,.LC16@ha
	lfs 12,.LC5@l(11)
	la 10,.LC16@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L29
	lis 9,.LC6@ha
	lwz 4,540(31)
	mr 3,30
	lfs 1,.LC6@l(9)
.L36:
	mr 5,30
.L35:
	addi 4,4,376
	bl VectorMA
	b .L23
.L29:
	lis 9,.LC7@ha
	lwz 4,540(31)
	mr 3,30
	lfs 1,.LC7@l(9)
	mr 5,30
	addi 4,4,376
	bl VectorMA
.L23:
	lwz 11,540(31)
	lis 27,0x4330
	lis 10,.LC15@ha
	lfs 13,8(1)
	addi 3,1,72
	lwz 0,508(11)
	la 10,.LC15@l(10)
	addi 28,1,88
	lfd 29,0(10)
	addi 29,1,56
	mr 26,3
	xoris 0,0,0x8000
	lfs 10,104(1)
	mr 4,28
	stw 0,124(1)
	mr 25,29
	stw 27,120(1)
	lfd 0,120(1)
	fsubs 10,10,13
	lfs 9,112(1)
	lfs 13,108(1)
	fsub 0,0,29
	lfs 11,12(1)
	lfs 12,16(1)
	stfs 10,72(1)
	frsp 0,0
	fsubs 13,13,11
	fadds 9,9,0
	stfs 13,76(1)
	fsubs 12,9,12
	stfs 9,112(1)
	stfs 12,80(1)
	bl vectoangles
	mr 3,28
	mr 4,23
	mr 5,22
	mr 6,29
	bl AngleVectors
	lis 9,.LC14@ha
	lis 11,skill@ha
	la 9,.LC14@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,0,.L31
	bl rand
	lis 9,.LC16@ha
	rlwinm 3,3,0,17,31
	la 9,.LC16@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 11,.LC5@ha
	lfs 27,.LC5@l(11)
	stw 3,124(1)
	stw 27,120(1)
	lfd 0,120(1)
	fsub 0,0,29
	frsp 0,0
	fdivs 0,0,27
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L31
	bl rand
	lis 9,.LC12@ha
	rlwinm 3,3,0,17,31
	lwz 11,skill@l(24)
	la 9,.LC12@l(9)
	xoris 3,3,0x8000
	lfs 31,0(9)
	lis 10,.LC17@ha
	lfs 0,20(11)
	la 10,.LC17@l(10)
	stw 3,124(1)
	stw 27,120(1)
	lfd 13,120(1)
	fadds 0,0,31
	lfs 12,0(10)
	fsub 13,13,29
	fdivs 12,12,0
	frsp 13,13
	fdivs 13,13,27
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmul 0,0,12
	frsp 28,0
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,skill@l(24)
	xoris 3,3,0x8000
	lis 10,.LC18@ha
	stw 3,124(1)
	la 10,.LC18@l(10)
	stw 27,120(1)
	lfd 13,120(1)
	lfs 0,20(11)
	lfs 12,0(10)
	fsub 13,13,29
	fadds 0,0,31
	frsp 13,13
	fdivs 12,12,0
	fdivs 13,13,27
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmul 0,0,12
	frsp 31,0
	b .L32
.L31:
	lis 11,.LC9@ha
	lis 9,.LC9@ha
	la 11,.LC9@l(11)
	la 9,.LC9@l(9)
	lfs 28,0(11)
	lfs 31,0(9)
.L32:
	lis 10,.LC19@ha
	addi 3,1,8
	la 10,.LC19@l(10)
	mr 4,23
	lfs 1,0(10)
	mr 5,30
	bl VectorMA
	fmr 1,28
	mr 4,22
	mr 3,30
	mr 5,30
	bl VectorMA
	fmr 1,31
	mr 3,30
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
	lis 9,skill@ha
	lis 10,.LC14@ha
	lwz 11,skill@l(9)
	la 10,.LC14@l(10)
	li 6,25
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,0,.L33
	li 6,10
.L33:
	mr 5,26
	addi 4,1,8
	mr 3,31
	li 9,8
	li 7,2048
	li 8,39
	bl monster_fire_blaster
	lis 29,gi@ha
	lis 3,.LC8@ha
	la 29,gi@l(29)
	la 3,.LC8@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC12@ha
	lis 10,.LC12@ha
	lis 11,.LC9@ha
	mr 5,3
	la 9,.LC12@l(9)
	la 10,.LC12@l(10)
	mtlr 0
	la 11,.LC9@l(11)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	lwz 0,212(1)
	mtlr 0
	lmw 22,128(1)
	lfd 27,168(1)
	lfd 28,176(1)
	lfd 29,184(1)
	lfd 30,192(1)
	lfd 31,200(1)
	la 1,208(1)
	blr
.Lfe1:
	.size	 smuggler_fire,.Lfe1-smuggler_fire
	.globl smuggler_frames_attack
	.section	".data"
	.align 2
	.type	 smuggler_frames_attack,@object
smuggler_frames_attack:
	.long ai_charge
	.long 0x0
	.long smuggler_update_head
	.long ai_charge
	.long 0x0
	.long smuggler_update_head
	.long ai_charge
	.long 0x0
	.long smuggler_update_head
	.long ai_charge
	.long 0x0
	.long smuggler_update_head
	.long ai_charge
	.long 0x0
	.long smuggler_fire
	.long ai_charge
	.long 0x0
	.long smuggler_attack_refire
	.size	 smuggler_frames_attack,72
	.globl smuggler_move_attack
	.align 2
	.type	 smuggler_move_attack,@object
	.size	 smuggler_move_attack,16
smuggler_move_attack:
	.long 66
	.long 71
	.long smuggler_frames_attack
	.long smuggler_run
	.section	".rodata"
	.align 2
.LC21:
	.string	"models/monsters/smuggler/smugheada.md2"
	.align 2
.LC22:
	.string	"models/monsters/smuggler/nsmug.md2"
	.align 2
.LC23:
	.string	"models/monsters/smuggler/blastera.md2"
	.align 2
.LC24:
	.long 0x0
	.align 2
.LC25:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SP_npc_smuggler
	.type	 SP_npc_smuggler,@function
SP_npc_smuggler:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	lis 11,.LC24@ha
	lis 9,deathmatch@ha
	la 11,.LC24@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L52
	bl G_FreeEdict
	b .L51
.L52:
	li 0,5
	li 11,2
	lis 9,gi@ha
	stw 0,260(31)
	lis 3,.LC22@ha
	stw 11,248(31)
	la 30,gi@l(9)
	la 3,.LC22@l(3)
	lwz 9,32(30)
	lis 27,0xc1c0
	lis 26,0x4200
	mtlr 9
	blrl
	stw 3,40(31)
	lwz 9,32(30)
	lis 3,.LC23@ha
	la 3,.LC23@l(3)
	mtlr 9
	blrl
	lwz 0,480(31)
	lis 9,0xc140
	lis 11,0x4140
	stw 3,44(31)
	cmpwi 0,0,0
	stw 9,192(31)
	stw 11,204(31)
	stw 9,188(31)
	stw 27,196(31)
	stw 11,200(31)
	stw 26,208(31)
	bc 4,2,.L53
	li 0,30
	stw 0,480(31)
.L53:
	lis 9,smuggler_pain@ha
	lis 11,smuggler_die@ha
	la 9,smuggler_pain@l(9)
	la 11,smuggler_die@l(11)
	stw 9,452(31)
	lis 10,smuggler_stand@ha
	lis 8,smuggler_walk@ha
	li 9,200
	stw 11,456(31)
	lis 7,smuggler_run@ha
	stw 9,400(31)
	lis 6,smuggler_attack@ha
	lis 5,smuggler_sight@ha
	lis 9,.LC25@ha
	la 10,smuggler_stand@l(10)
	la 8,smuggler_walk@l(8)
	la 7,smuggler_run@l(7)
	stw 10,788(31)
	la 6,smuggler_attack@l(6)
	la 5,smuggler_sight@l(5)
	stw 8,800(31)
	lis 0,0x4234
	li 11,-1
	stw 7,804(31)
	li 28,0
	la 9,.LC25@l(9)
	stw 0,420(31)
	stw 6,812(31)
	mr 3,31
	stw 5,820(31)
	sth 11,992(31)
	lfs 31,0(9)
	stw 28,816(31)
	lwz 9,72(30)
	mtlr 9
	blrl
	lis 9,smuggler_move_stand@ha
	mr 3,31
	stfs 31,784(31)
	la 9,smuggler_move_stand@l(9)
	stw 9,772(31)
	bl walkmonster_start
	bl G_Spawn
	mr 29,3
	stw 28,248(29)
	lis 3,.LC21@ha
	stw 28,260(29)
	la 3,.LC21@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	stw 3,40(29)
	lis 11,0xc000
	lis 10,0x4000
	lfs 0,16(31)
	li 8,1
	lis 7,level+4@ha
	lis 9,smuggler_head_update@ha
	mr 3,29
	la 9,smuggler_head_update@l(9)
	stfs 0,16(29)
	lfs 0,20(31)
	stfs 0,20(29)
	lfs 13,24(31)
	stfs 13,24(29)
	lwz 0,56(31)
	stw 11,192(29)
	stw 0,56(29)
	stw 27,196(29)
	stw 10,204(29)
	stw 26,208(29)
	stw 8,60(29)
	stw 11,188(29)
	stw 10,200(29)
	lfs 0,4(31)
	stfs 0,4(29)
	lfs 13,8(31)
	stfs 13,8(29)
	lfs 12,12(31)
	stfs 12,12(29)
	lfs 0,level+4@l(7)
	stw 9,436(29)
	fadds 0,0,31
	stfs 0,428(29)
	lwz 0,72(30)
	mtlr 0
	blrl
	stw 29,1016(31)
.L51:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 SP_npc_smuggler,.Lfe2-SP_npc_smuggler
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
	.globl smuggler_update_head
	.type	 smuggler_update_head,@function
smuggler_update_head:
	lwz 9,1016(3)
	lfs 0,4(9)
	stfs 0,28(9)
	lwz 11,1016(3)
	lfs 0,8(11)
	stfs 0,32(11)
	lwz 9,1016(3)
	lfs 0,12(9)
	stfs 0,36(9)
	lfs 0,16(3)
	lwz 11,1016(3)
	stfs 0,16(11)
	lfs 0,20(3)
	lwz 9,1016(3)
	stfs 0,20(9)
	lfs 0,24(3)
	lwz 11,1016(3)
	stfs 0,24(11)
	lfs 0,4(3)
	lwz 9,1016(3)
	stfs 0,4(9)
	lfs 0,8(3)
	lwz 11,1016(3)
	stfs 0,8(11)
	lfs 0,12(3)
	lwz 9,1016(3)
	stfs 0,12(9)
	lwz 0,492(3)
	cmpwi 0,0,2
	bc 4,2,.L47
	lwz 9,56(3)
	lwz 11,1016(3)
	addi 9,9,1
	stw 9,56(11)
	blr
.L47:
	lwz 0,56(3)
	lwz 9,1016(3)
	stw 0,56(9)
	blr
.Lfe3:
	.size	 smuggler_update_head,.Lfe3-smuggler_update_head
	.align 2
	.globl smuggler_stand
	.type	 smuggler_stand,@function
smuggler_stand:
	lis 9,smuggler_move_stand@ha
	la 9,smuggler_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe4:
	.size	 smuggler_stand,.Lfe4-smuggler_stand
	.align 2
	.globl smuggler_walk
	.type	 smuggler_walk,@function
smuggler_walk:
	lis 9,smuggler_move_walk@ha
	la 9,smuggler_move_walk@l(9)
	stw 9,772(3)
	blr
.Lfe5:
	.size	 smuggler_walk,.Lfe5-smuggler_walk
	.align 2
	.globl smuggler_run
	.type	 smuggler_run,@function
smuggler_run:
	lwz 0,776(3)
	andi. 9,0,1
	bc 12,2,.L9
	lis 9,smuggler_move_stand@ha
	la 9,smuggler_move_stand@l(9)
	stw 9,772(3)
	blr
.L9:
	lis 9,smuggler_move_run@ha
	la 9,smuggler_move_run@l(9)
	stw 9,772(3)
	blr
.Lfe6:
	.size	 smuggler_run,.Lfe6-smuggler_run
	.align 2
	.globl smuggler_pain
	.type	 smuggler_pain,@function
smuggler_pain:
	blr
.Lfe7:
	.size	 smuggler_pain,.Lfe7-smuggler_pain
	.align 2
	.globl smuggler_dead
	.type	 smuggler_dead,@function
smuggler_dead:
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
	.size	 smuggler_dead,.Lfe8-smuggler_dead
	.section	".rodata"
	.align 2
.LC26:
	.long 0x46fffe00
	.align 3
.LC27:
	.long 0x3fd51eb8
	.long 0x51eb851f
	.align 3
.LC28:
	.long 0x3fe51eb8
	.long 0x51eb851f
	.align 3
.LC29:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl smuggler_die
	.type	 smuggler_die,@function
smuggler_die:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L13
	li 0,0
	li 9,2
	li 11,1
	stw 0,44(31)
	stw 9,492(31)
	stw 11,512(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC29@ha
	lis 10,.LC26@ha
	la 11,.LC29@l(11)
	stw 0,16(1)
	lfd 12,0(11)
	lfd 0,16(1)
	lis 11,.LC27@ha
	lfs 11,.LC26@l(10)
	lfd 13,.LC27@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,11
	fmr 12,0
	fcmpu 0,12,13
	bc 4,0,.L15
	lis 9,smuggler_move_deatha@ha
	la 9,smuggler_move_deatha@l(9)
	b .L55
.L15:
	lis 9,.LC28@ha
	lfd 0,.LC28@l(9)
	fcmpu 0,12,0
	bc 4,0,.L17
	lis 9,smuggler_move_deathb@ha
	la 9,smuggler_move_deathb@l(9)
	b .L55
.L17:
	lis 9,smuggler_move_deathc@ha
	la 9,smuggler_move_deathc@l(9)
.L55:
	stw 9,772(31)
.L13:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 smuggler_die,.Lfe9-smuggler_die
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
	.long 0x40400000
	.align 2
.LC34:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl smuggler_attack_refire
	.type	 smuggler_attack_refire,@function
smuggler_attack_refire:
	stwu 1,-96(1)
	mflr 0
	stw 31,92(1)
	stw 0,100(1)
	mr 31,3
	lwz 9,540(31)
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L37
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,84(1)
	lis 10,.LC31@ha
	lis 11,.LC30@ha
	la 10,.LC31@l(10)
	stw 0,80(1)
	lfd 13,0(10)
	lfd 0,80(1)
	lis 10,.LC32@ha
	lfs 12,.LC30@l(11)
	la 10,.LC32@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,1
	bc 12,3,.L37
	lis 11,gi+48@ha
	lwz 7,540(31)
	lis 9,0x202
	lwz 0,gi+48@l(11)
	ori 9,9,3
	addi 3,1,8
	addi 4,31,4
	addi 7,7,4
	li 5,0
	li 6,0
	mtlr 0
	mr 8,31
	blrl
	lis 9,.LC33@ha
	lis 11,skill@ha
	la 9,.LC33@l(9)
	lfs 0,0(9)
	lwz 9,skill@l(11)
	lfs 13,20(9)
	fcmpu 0,13,0
	bc 12,2,.L42
	lis 10,.LC34@ha
	la 10,.LC34@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L42
	lwz 9,60(1)
	lwz 0,540(31)
	cmpw 0,9,0
	li 0,68
	bc 12,2,.L56
.L42:
	li 0,71
.L56:
	stw 0,780(31)
	mr 3,31
	bl smuggler_update_head
.L37:
	lwz 0,100(1)
	mtlr 0
	lwz 31,92(1)
	la 1,96(1)
	blr
.Lfe10:
	.size	 smuggler_attack_refire,.Lfe10-smuggler_attack_refire
	.align 2
	.globl smuggler_attack
	.type	 smuggler_attack,@function
smuggler_attack:
	lis 9,smuggler_move_attack@ha
	la 9,smuggler_move_attack@l(9)
	stw 9,772(3)
	blr
.Lfe11:
	.size	 smuggler_attack,.Lfe11-smuggler_attack
	.align 2
	.globl smuggler_sight
	.type	 smuggler_sight,@function
smuggler_sight:
	blr
.Lfe12:
	.size	 smuggler_sight,.Lfe12-smuggler_sight
	.section	".rodata"
	.align 2
.LC35:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl smuggler_head_update
	.type	 smuggler_head_update,@function
smuggler_head_update:
	lis 9,.LC35@ha
	lfs 0,12(3)
	la 9,.LC35@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(3)
	blr
.Lfe13:
	.size	 smuggler_head_update,.Lfe13-smuggler_head_update
	.section	".rodata"
	.align 2
.LC36:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SP_smuggler_head
	.type	 SP_smuggler_head,@function
SP_smuggler_head:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 28,3
	bl G_Spawn
	mr 29,3
	li 0,0
	lis 27,gi@ha
	stw 0,248(29)
	lis 3,.LC21@ha
	la 27,gi@l(27)
	stw 0,260(29)
	la 3,.LC21@l(3)
	lwz 9,32(27)
	mtlr 9
	blrl
	stw 3,40(29)
	lis 11,0xc000
	lis 10,0x4000
	lfs 0,16(28)
	lis 8,0xc1c0
	lis 7,0x4200
	li 6,1
	lis 9,.LC36@ha
	lis 5,level+4@ha
	la 9,.LC36@l(9)
	stfs 0,16(29)
	mr 3,29
	lfs 13,20(28)
	lfs 11,0(9)
	lis 9,smuggler_head_update@ha
	stfs 13,20(29)
	la 9,smuggler_head_update@l(9)
	lfs 0,24(28)
	stfs 0,24(29)
	lwz 0,56(28)
	stw 11,192(29)
	stw 0,56(29)
	stw 8,196(29)
	stw 10,204(29)
	stw 7,208(29)
	stw 6,60(29)
	stw 11,188(29)
	stw 10,200(29)
	lfs 0,4(28)
	stfs 0,4(29)
	lfs 13,8(28)
	stfs 13,8(29)
	lfs 12,12(28)
	stfs 12,12(29)
	lfs 0,level+4@l(5)
	stw 9,436(29)
	fadds 0,0,11
	stfs 0,428(29)
	lwz 0,72(27)
	mtlr 0
	blrl
	stw 29,1016(28)
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 SP_smuggler_head,.Lfe14-SP_smuggler_head
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
