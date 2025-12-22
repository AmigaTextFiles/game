	.file	"m_gunner.c"
gcc2_compiled.:
	.globl gunner_frames_fidget
	.section	".data"
	.align 2
	.type	 gunner_frames_fidget,@object
gunner_frames_fidget:
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
	.long gunner_idlesound
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
	.long ai_stand
	.long 0x0
	.long 0
	.size	 gunner_frames_fidget,588
	.globl gunner_move_fidget
	.align 2
	.type	 gunner_move_fidget,@object
	.size	 gunner_move_fidget,16
gunner_move_fidget:
	.long 30
	.long 69
	.long gunner_frames_fidget
	.long gunner_stand
	.globl gunner_frames_stand
	.align 2
	.type	 gunner_frames_stand,@object
gunner_frames_stand:
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
	.long gunner_fidget
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
	.long gunner_fidget
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
	.long gunner_fidget
	.size	 gunner_frames_stand,360
	.globl gunner_move_stand
	.align 2
	.type	 gunner_move_stand,@object
	.size	 gunner_move_stand,16
gunner_move_stand:
	.long 0
	.long 29
	.long gunner_frames_stand
	.long 0
	.globl gunner_frames_walk
	.align 2
	.type	 gunner_frames_walk,@object
gunner_frames_walk:
	.long ai_walk
	.long 0x0
	.long 0
	.long ai_walk
	.long 0x40400000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40a00000
	.long 0
	.long ai_walk
	.long 0x40e00000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x40c00000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x40e00000
	.long 0
	.long ai_walk
	.long 0x40a00000
	.long 0
	.long ai_walk
	.long 0x40e00000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.size	 gunner_frames_walk,156
	.globl gunner_move_walk
	.align 2
	.type	 gunner_move_walk,@object
	.size	 gunner_move_walk,16
gunner_move_walk:
	.long 76
	.long 88
	.long gunner_frames_walk
	.long 0
	.globl gunner_frames_run
	.align 2
	.type	 gunner_frames_run,@object
gunner_frames_run:
	.long ai_run
	.long 0x41d00000
	.long 0
	.long ai_run
	.long 0x41100000
	.long 0
	.long ai_run
	.long 0x41100000
	.long 0
	.long ai_run
	.long 0x41100000
	.long monster_done_dodge
	.long ai_run
	.long 0x41700000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41500000
	.long 0
	.long ai_run
	.long 0x40c00000
	.long 0
	.size	 gunner_frames_run,96
	.globl gunner_move_run
	.align 2
	.type	 gunner_move_run,@object
	.size	 gunner_move_run,16
gunner_move_run:
	.long 94
	.long 101
	.long gunner_frames_run
	.long 0
	.globl gunner_frames_runandshoot
	.align 2
	.type	 gunner_frames_runandshoot,@object
gunner_frames_runandshoot:
	.long ai_run
	.long 0x42000000
	.long 0
	.long ai_run
	.long 0x41700000
	.long 0
	.long ai_run
	.long 0x41200000
	.long 0
	.long ai_run
	.long 0x41900000
	.long 0
	.long ai_run
	.long 0x41000000
	.long 0
	.long ai_run
	.long 0x41a00000
	.long 0
	.size	 gunner_frames_runandshoot,72
	.globl gunner_move_runandshoot
	.align 2
	.type	 gunner_move_runandshoot,@object
	.size	 gunner_move_runandshoot,16
gunner_move_runandshoot:
	.long 102
	.long 107
	.long gunner_frames_runandshoot
	.long 0
	.globl gunner_frames_pain3
	.align 2
	.type	 gunner_frames_pain3,@object
gunner_frames_pain3:
	.long ai_move
	.long 0xc0400000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.size	 gunner_frames_pain3,60
	.globl gunner_move_pain3
	.align 2
	.type	 gunner_move_pain3,@object
	.size	 gunner_move_pain3,16
gunner_move_pain3:
	.long 185
	.long 189
	.long gunner_frames_pain3
	.long gunner_run
	.globl gunner_frames_pain2
	.align 2
	.type	 gunner_frames_pain2,@object
gunner_frames_pain2:
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0x41300000
	.long 0
	.long ai_move
	.long 0x40c00000
	.long 0
	.long ai_move
	.long 0x40000000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xc0e00000
	.long 0
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0xc0e00000
	.long 0
	.size	 gunner_frames_pain2,96
	.globl gunner_move_pain2
	.align 2
	.type	 gunner_move_pain2,@object
	.size	 gunner_move_pain2,16
gunner_move_pain2:
	.long 177
	.long 184
	.long gunner_frames_pain2
	.long gunner_run
	.globl gunner_frames_pain1
	.align 2
	.type	 gunner_frames_pain1,@object
gunner_frames_pain1:
	.long ai_move
	.long 0x40000000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0xc0a00000
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0xbf800000
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
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x40000000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 gunner_frames_pain1,216
	.globl gunner_move_pain1
	.align 2
	.type	 gunner_move_pain1,@object
	.size	 gunner_move_pain1,16
gunner_move_pain1:
	.long 159
	.long 176
	.long gunner_frames_pain1
	.long gunner_run
	.globl gunner_frames_death
	.align 2
	.type	 gunner_frames_death,@object
gunner_frames_death:
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
	.long 0xc0e00000
	.long 0
	.long ai_move
	.long 0xc0400000
	.long 0
	.long ai_move
	.long 0xc0a00000
	.long 0
	.long ai_move
	.long 0x41000000
	.long 0
	.long ai_move
	.long 0x40c00000
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
	.size	 gunner_frames_death,132
	.globl gunner_move_death
	.align 2
	.type	 gunner_move_death,@object
	.size	 gunner_move_death,16
gunner_move_death:
	.long 190
	.long 200
	.long gunner_frames_death
	.long gunner_dead
	.section	".rodata"
	.align 2
.LC2:
	.string	"misc/udeath.wav"
	.align 2
.LC3:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC4:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC5:
	.string	"models/objects/gibs/head2/tris.md2"
	.globl gunner_frames_duck
	.section	".data"
	.align 2
	.type	 gunner_frames_duck,@object
gunner_frames_duck:
	.long ai_move
	.long 0x3f800000
	.long gunner_duck_down
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long monster_duck_hold
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0x0
	.long monster_duck_up
	.long ai_move
	.long 0xbf800000
	.long 0
	.size	 gunner_frames_duck,96
	.globl gunner_move_duck
	.align 2
	.type	 gunner_move_duck,@object
	.size	 gunner_move_duck,16
gunner_move_duck:
	.long 201
	.long 208
	.long gunner_frames_duck
	.long gunner_run
	.section	".rodata"
	.align 2
.LC7:
	.long 0xbe4ccccd
	.align 3
.LC8:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl GunnerFire
	.type	 GunnerFire,@function
GunnerFire:
	stwu 1,-128(1)
	mflr 0
	stmw 26,104(1)
	stw 0,132(1)
	mr 31,3
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L49
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L49
	lwz 27,56(31)
	addi 28,1,24
	addi 29,1,40
	addi 26,1,72
	mr 4,28
	addi 27,27,-99
	addi 3,31,16
	mr 5,29
	li 6,0
	bl AngleVectors
	mulli 0,27,12
	lis 4,monster_flash_offset@ha
	mr 6,29
	la 4,monster_flash_offset@l(4)
	addi 7,1,8
	add 4,0,4
	mr 5,28
	addi 3,31,4
	bl G_ProjectSource
	lwz 11,540(31)
	lis 9,.LC7@ha
	addi 3,1,56
	lfs 1,.LC7@l(9)
	mr 5,3
	lfs 13,4(11)
	addi 4,11,376
	stfs 13,56(1)
	lfs 0,8(11)
	stfs 0,60(1)
	lfs 13,12(11)
	stfs 13,64(1)
	bl VectorMA
	lwz 11,540(31)
	lis 10,0x4330
	lis 8,.LC8@ha
	lfs 13,8(1)
	mr 3,26
	lwz 0,508(11)
	la 8,.LC8@l(8)
	lfd 8,0(8)
	xoris 0,0,0x8000
	lfs 11,56(1)
	stw 0,100(1)
	stw 10,96(1)
	lfd 0,96(1)
	fsubs 11,11,13
	lfs 9,64(1)
	lfs 13,60(1)
	fsub 0,0,8
	lfs 10,12(1)
	lfs 12,16(1)
	stfs 11,72(1)
	frsp 0,0
	fsubs 13,13,10
	fadds 9,9,0
	stfs 13,76(1)
	fsubs 12,9,12
	stfs 9,64(1)
	stfs 12,80(1)
	bl VectorNormalize
	mr 3,31
	mr 5,26
	mr 10,27
	addi 4,1,8
	li 6,3
	li 7,4
	li 8,300
	li 9,500
	bl monster_fire_bullet
.L49:
	lwz 0,132(1)
	mtlr 0
	lmw 26,104(1)
	la 1,128(1)
	blr
.Lfe1:
	.size	 GunnerFire,.Lfe1-GunnerFire
	.section	".rodata"
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC10:
	.long 0x42c80000
	.align 2
.LC11:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl gunner_grenade_check
	.type	 gunner_grenade_check,@function
gunner_grenade_check:
	stwu 1,-176(1)
	mflr 0
	stmw 28,160(1)
	stw 0,180(1)
	mr 31,3
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L61
	lwz 0,776(31)
	andis. 10,0,1
	bc 12,2,.L54
	lwz 0,508(31)
	lis 11,0x4330
	lis 10,.LC9@ha
	lfs 13,12(31)
	xoris 0,0,0x8000
	la 10,.LC9@l(10)
	lfs 11,964(31)
	stw 0,156(1)
	stw 11,152(1)
	lfd 12,0(10)
	lfd 0,152(1)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	fcmpu 0,13,11
	bc 4,0,.L56
	b .L61
.L54:
	lfs 13,220(9)
	lfs 0,232(31)
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L61
.L56:
	addi 29,1,24
	addi 28,1,40
	mr 4,29
	addi 3,31,16
	mr 5,28
	li 6,0
	bl AngleVectors
	lis 4,monster_flash_offset+636@ha
	mr 5,29
	la 4,monster_flash_offset+636@l(4)
	mr 6,28
	addi 3,31,4
	addi 7,1,8
	bl G_ProjectSource
	lwz 0,776(31)
	andis. 9,0,1
	bc 12,2,.L58
	lfs 0,956(31)
	lfs 13,960(31)
	lfs 12,964(31)
	stfs 0,120(1)
	stfs 13,124(1)
	stfs 12,128(1)
	b .L59
.L58:
	lwz 9,540(31)
	lfs 0,4(9)
	stfs 0,120(1)
	lfs 13,8(9)
	stfs 13,124(1)
	lfs 0,12(9)
	stfs 0,128(1)
.L59:
	lfs 12,4(31)
	addi 3,1,136
	lfs 11,120(1)
	lfs 13,8(31)
	lfs 0,12(31)
	fsubs 12,12,11
	lfs 10,124(1)
	lfs 11,128(1)
	fsubs 13,13,10
	stfs 12,136(1)
	fsubs 0,0,11
	stfs 13,140(1)
	stfs 0,144(1)
	bl VectorLength
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L61
	lis 11,gi+48@ha
	lis 5,vec3_origin@ha
	lwz 0,gi+48@l(11)
	la 5,vec3_origin@l(5)
	lis 9,0x600
	ori 9,9,3
	addi 3,1,56
	mtlr 0
	addi 4,1,8
	mr 6,5
	addi 7,1,120
	mr 8,31
	blrl
	lwz 9,540(31)
	lwz 0,108(1)
	cmpw 0,0,9
	bc 12,2,.L62
	lis 9,.LC11@ha
	lfs 13,64(1)
	la 9,.LC11@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L61
.L62:
	li 3,1
	b .L63
.L61:
	li 3,0
.L63:
	lwz 0,180(1)
	mtlr 0
	lmw 28,160(1)
	la 1,176(1)
	blr
.Lfe2:
	.size	 gunner_grenade_check,.Lfe2-gunner_grenade_check
	.section	".rodata"
	.align 2
.LC12:
	.long 0x3ca3d70a
	.align 2
.LC13:
	.long 0x3d4ccccd
	.align 2
.LC14:
	.long 0x3da3d70a
	.align 2
.LC15:
	.long 0x3de147ae
	.align 3
.LC16:
	.long 0x3fd99999
	.long 0x9999999a
	.align 2
.LC17:
	.long 0x3ecccccd
	.align 2
.LC18:
	.long 0x44000000
	.align 2
.LC19:
	.long 0x42800000
	.align 2
.LC20:
	.long 0xc2800000
	.align 3
.LC21:
	.long 0xbfe00000
	.long 0x0
	.align 2
.LC22:
	.long 0xbf000000
	.section	".text"
	.align 2
	.globl GunnerGrenade
	.type	 GunnerGrenade,@function
GunnerGrenade:
	stwu 1,-160(1)
	mflr 0
	stfd 30,144(1)
	stfd 31,152(1)
	stmw 24,112(1)
	stw 0,164(1)
	mr 31,3
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L64
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L64
	lwz 10,776(31)
	lwz 11,56(31)
	andis. 0,10,1
	cmpwi 7,11,112
	mfcr 9
	rlwinm 9,9,3,1
	neg 9,9
	addi 0,9,1
	and 9,8,9
	or 8,9,0
	bc 4,30,.L68
	lis 9,.LC12@ha
	li 27,53
	lfs 30,.LC12@l(9)
	b .L69
.L68:
	cmpwi 0,11,115
	bc 4,2,.L70
	lis 9,.LC13@ha
	li 27,54
	lfs 30,.LC13@l(9)
	b .L69
.L70:
	cmpwi 0,11,118
	bc 4,2,.L72
	lis 9,.LC14@ha
	li 27,55
	lfs 30,.LC14@l(9)
	b .L69
.L72:
	lis 9,.LC15@ha
	rlwinm 0,10,0,16,14
	lfs 30,.LC15@l(9)
	li 27,56
	stw 0,776(31)
.L69:
	cmpwi 0,8,0
	bc 12,2,.L74
	lwz 4,540(31)
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L74
	lis 4,vec3_origin@ha
	addi 3,31,956
	la 4,vec3_origin@l(4)
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L64
	lfs 0,956(31)
	lfs 13,960(31)
	lfs 12,964(31)
	b .L82
.L74:
	lfs 0,4(31)
	lfs 13,8(31)
	lfs 12,12(31)
.L82:
	stfs 0,88(1)
	stfs 13,92(1)
	stfs 12,96(1)
	addi 29,1,24
	addi 28,1,40
	addi 6,1,56
	mr 4,29
	addi 3,31,16
	mr 24,6
	mr 5,28
	mr 26,29
	bl AngleVectors
	mr 25,28
	mulli 0,27,12
	lis 4,monster_flash_offset@ha
	addi 30,1,72
	la 4,monster_flash_offset@l(4)
	addi 3,31,4
	add 4,0,4
	mr 5,29
	mr 6,28
	addi 7,1,8
	bl G_ProjectSource
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 12,2,.L77
	lfs 11,4(31)
	mr 3,30
	lfs 12,88(1)
	lfs 10,8(31)
	lfs 13,92(1)
	fsubs 12,12,11
	lfs 0,96(1)
	lfs 11,12(31)
	fsubs 13,13,10
	stfs 12,72(1)
	fsubs 0,0,11
	stfs 13,76(1)
	stfs 0,80(1)
	bl VectorLength
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 12,0(9)
	fcmpu 0,1,12
	bc 4,1,.L78
	lis 9,.LC19@ha
	lfs 13,80(1)
	la 9,.LC19@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L78
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L78
	fsubs 0,1,12
	fadds 0,13,0
	stfs 0,80(1)
.L78:
	mr 3,30
	bl VectorNormalize
	lfs 31,80(1)
	lis 9,.LC16@ha
	lfd 0,.LC16@l(9)
	fmr 13,31
	fcmpu 0,13,0
	bc 4,1,.L79
	lis 9,.LC17@ha
	lfs 31,.LC17@l(9)
	b .L77
.L79:
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L77
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 31,0(9)
.L77:
	fmr 1,30
	mr 3,26
	mr 4,25
	mr 5,30
	bl VectorMA
	fmr 1,31
	mr 4,24
	mr 3,30
	mr 5,30
	bl VectorMA
	mr 3,31
	mr 5,30
	mr 8,27
	addi 4,1,8
	li 6,50
	li 7,600
	bl monster_fire_grenade
.L64:
	lwz 0,164(1)
	mtlr 0
	lmw 24,112(1)
	lfd 30,144(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe3:
	.size	 GunnerGrenade,.Lfe3-GunnerGrenade
	.globl gunner_frames_attack_chain
	.section	".data"
	.align 2
	.type	 gunner_frames_attack_chain,@object
gunner_frames_attack_chain:
	.long ai_charge
	.long 0x0
	.long gunner_opengun
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
	.long ai_charge
	.long 0x0
	.long 0
	.size	 gunner_frames_attack_chain,84
	.globl gunner_move_attack_chain
	.align 2
	.type	 gunner_move_attack_chain,@object
	.size	 gunner_move_attack_chain,16
gunner_move_attack_chain:
	.long 137
	.long 143
	.long gunner_frames_attack_chain
	.long gunner_fire_chain
	.globl gunner_frames_fire_chain
	.align 2
	.type	 gunner_frames_fire_chain,@object
gunner_frames_fire_chain:
	.long ai_charge
	.long 0x0
	.long GunnerFire
	.long ai_charge
	.long 0x0
	.long GunnerFire
	.long ai_charge
	.long 0x0
	.long GunnerFire
	.long ai_charge
	.long 0x0
	.long GunnerFire
	.long ai_charge
	.long 0x0
	.long GunnerFire
	.long ai_charge
	.long 0x0
	.long GunnerFire
	.long ai_charge
	.long 0x0
	.long GunnerFire
	.long ai_charge
	.long 0x0
	.long GunnerFire
	.size	 gunner_frames_fire_chain,96
	.globl gunner_move_fire_chain
	.align 2
	.type	 gunner_move_fire_chain,@object
	.size	 gunner_move_fire_chain,16
gunner_move_fire_chain:
	.long 144
	.long 151
	.long gunner_frames_fire_chain
	.long gunner_refire_chain
	.globl gunner_frames_endfire_chain
	.align 2
	.type	 gunner_frames_endfire_chain,@object
gunner_frames_endfire_chain:
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
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.size	 gunner_frames_endfire_chain,84
	.globl gunner_move_endfire_chain
	.align 2
	.type	 gunner_move_endfire_chain,@object
	.size	 gunner_move_endfire_chain,16
gunner_move_endfire_chain:
	.long 152
	.long 158
	.long gunner_frames_endfire_chain
	.long gunner_run
	.globl gunner_frames_attack_grenade
	.align 2
	.type	 gunner_frames_attack_grenade,@object
gunner_frames_attack_grenade:
	.long ai_charge
	.long 0x0
	.long gunner_blind_check
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
	.long GunnerGrenade
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long GunnerGrenade
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long GunnerGrenade
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long GunnerGrenade
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
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.size	 gunner_frames_attack_grenade,252
	.globl gunner_move_attack_grenade
	.align 2
	.type	 gunner_move_attack_grenade,@object
	.size	 gunner_move_attack_grenade,16
gunner_move_attack_grenade:
	.long 108
	.long 128
	.long gunner_frames_attack_grenade
	.long gunner_run
	.section	".rodata"
	.align 2
.LC23:
	.long 0x3ecccccd
	.align 2
.LC24:
	.long 0x3dcccccd
	.align 2
.LC25:
	.long 0x46fffe00
	.align 3
.LC26:
	.long 0x40106666
	.long 0x66666666
	.align 3
.LC27:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC28:
	.long 0x3f800000
	.align 3
.LC29:
	.long 0x401e0000
	.long 0x0
	.align 3
.LC30:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC31:
	.long 0x40080000
	.long 0x0
	.align 3
.LC32:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl gunner_attack
	.type	 gunner_attack,@function
gunner_attack:
	stwu 1,-64(1)
	mflr 0
	stfd 28,32(1)
	stfd 29,40(1)
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 30,24(1)
	stw 0,68(1)
	mr 31,3
	bl monster_done_dodge
	lwz 0,868(31)
	cmpwi 0,0,5
	bc 4,2,.L86
	lfs 13,952(31)
	lis 9,.LC27@ha
	la 9,.LC27@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L87
	lis 10,.LC28@ha
	la 10,.LC28@l(10)
	lfs 30,0(10)
	b .L88
.L87:
	lis 11,.LC29@ha
	la 11,.LC29@l(11)
	lfd 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L89
	lis 9,.LC23@ha
	lfs 30,.LC23@l(9)
	b .L88
.L89:
	lis 9,.LC24@ha
	lfs 30,.LC24@l(9)
.L88:
	bl rand
	lis 30,0x4330
	lis 9,.LC30@ha
	rlwinm 3,3,0,17,31
	la 9,.LC30@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC25@ha
	lfs 29,.LC25@l(11)
	stw 3,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 28,0,29
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,952(31)
	xoris 3,3,0x8000
	lis 10,.LC31@ha
	stw 3,20(1)
	lis 11,.LC26@ha
	la 10,.LC31@l(10)
	stw 30,16(1)
	lis 4,vec3_origin@ha
	addi 3,31,956
	lfd 0,16(1)
	la 4,vec3_origin@l(4)
	lfd 10,0(10)
	lfd 11,.LC26@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fmadd 13,13,10,11
	fadd 12,12,13
	frsp 12,12
	stfs 12,952(31)
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L85
	fcmpu 0,28,30
	bc 12,1,.L85
	lwz 0,776(31)
	mr 3,31
	oris 0,0,0x1
	stw 0,776(31)
	bl gunner_grenade_check
	cmpwi 0,3,0
	bc 12,2,.L93
	lis 9,gunner_move_attack_grenade@ha
	la 9,gunner_move_attack_grenade@l(9)
	stw 9,772(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,level+4@ha
	stw 3,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	lfs 13,level+4@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fadds 0,0,0
	fadds 13,13,0
	stfs 13,832(31)
.L93:
	lwz 0,776(31)
	rlwinm 0,0,0,16,14
	stw 0,776(31)
	b .L85
.L86:
	lwz 4,540(31)
	mr 3,31
	bl range
	cmpwi 0,3,0
	bc 12,2,.L97
	lwz 0,1040(31)
	cmpwi 0,0,0
	bc 4,2,.L97
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC30@ha
	lis 11,.LC25@ha
	la 10,.LC30@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC32@ha
	lfs 12,.LC25@l(11)
	la 10,.LC32@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,0
	bc 4,3,.L97
	mr 3,31
	bl gunner_grenade_check
	cmpwi 0,3,0
	bc 12,2,.L97
	lis 9,gunner_move_attack_grenade@ha
	la 9,gunner_move_attack_grenade@l(9)
	b .L99
.L97:
	lis 9,gunner_move_attack_chain@ha
	la 9,gunner_move_attack_chain@l(9)
.L99:
	stw 9,772(31)
.L85:
	lwz 0,68(1)
	mtlr 0
	lmw 30,24(1)
	lfd 28,32(1)
	lfd 29,40(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 gunner_attack,.Lfe4-gunner_attack
	.globl gunner_frames_jump
	.section	".data"
	.align 2
	.type	 gunner_frames_jump,@object
gunner_frames_jump:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long gunner_jump_now
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long gunner_jump_wait_land
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 gunner_frames_jump,96
	.globl gunner_move_jump
	.align 2
	.type	 gunner_move_jump,@object
	.size	 gunner_move_jump,16
gunner_move_jump:
	.long 94
	.long 101
	.long gunner_frames_jump
	.long gunner_run
	.globl gunner_frames_jump2
	.align 2
	.type	 gunner_frames_jump2,@object
gunner_frames_jump2:
	.long ai_move
	.long 0xc1000000
	.long 0
	.long ai_move
	.long 0xc0800000
	.long 0
	.long ai_move
	.long 0x0
	.long gunner_jump_now
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long gunner_jump_wait_land
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 gunner_frames_jump2,96
	.globl gunner_move_jump2
	.align 2
	.type	 gunner_move_jump2,@object
	.size	 gunner_move_jump2,16
gunner_move_jump2:
	.long 94
	.long 101
	.long gunner_frames_jump2
	.long gunner_run
	.section	".rodata"
	.align 3
.LC35:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC36:
	.long 0x46fffe00
	.align 2
.LC37:
	.long 0x0
	.align 2
.LC38:
	.long 0x3f800000
	.align 2
.LC39:
	.long 0x40400000
	.align 2
.LC40:
	.long 0x40000000
	.align 3
.LC41:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC42:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC43:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl gunner_duck
	.type	 gunner_duck,@function
gunner_duck:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lis 9,gunner_move_jump2@ha
	lwz 0,772(31)
	la 9,gunner_move_jump2@l(9)
	cmpw 0,0,9
	bc 12,2,.L123
	lis 9,gunner_move_jump@ha
	la 9,gunner_move_jump@l(9)
	cmpw 0,0,9
	bc 12,2,.L123
	lis 9,gunner_move_attack_chain@ha
	la 9,gunner_move_attack_chain@l(9)
	cmpw 0,0,9
	bc 12,2,.L127
	lis 9,gunner_move_fire_chain@ha
	la 9,gunner_move_fire_chain@l(9)
	cmpw 0,0,9
	bc 12,2,.L127
	lis 9,gunner_move_attack_grenade@ha
	la 9,gunner_move_attack_grenade@l(9)
	cmpw 0,0,9
	bc 4,2,.L126
.L127:
	lis 9,.LC37@ha
	lis 11,skill@ha
	la 9,.LC37@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L126
	lwz 0,776(31)
	rlwinm 0,0,0,21,19
	stw 0,776(31)
	b .L123
.L126:
	lis 9,skill@ha
	lis 10,.LC37@ha
	lwz 11,skill@l(9)
	la 10,.LC37@l(10)
	lfs 0,0(10)
	lfs 12,20(11)
	fcmpu 0,12,0
	bc 4,2,.L129
	lis 9,level+4@ha
	lis 11,.LC38@ha
	lfs 0,level+4@l(9)
	la 11,.LC38@l(11)
	lfs 13,0(11)
	fadds 0,0,1
	fadds 0,0,13
	b .L135
.L129:
	lis 10,.LC39@ha
	lis 9,level+4@ha
	la 10,.LC39@l(10)
	lfs 13,level+4@l(9)
	lfs 0,0(10)
	lis 9,.LC35@ha
	fadds 13,13,1
	fsubs 0,0,12
	lfd 12,.LC35@l(9)
	fmadd 0,0,12,13
	frsp 0,0
.L135:
	stfs 0,940(31)
	lis 11,.LC40@ha
	lwz 0,776(31)
	lis 9,skill@ha
	la 11,.LC40@l(11)
	lfs 13,0(11)
	ori 0,0,2048
	lwz 11,skill@l(9)
	stw 0,776(31)
	lfs 0,20(11)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L131
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC41@ha
	lis 11,.LC36@ha
	la 10,.LC41@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC42@ha
	lfs 12,.LC36@l(11)
	la 10,.LC42@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L131
	mr 3,31
	bl GunnerGrenade
.L131:
	lis 9,.LC43@ha
	lfs 0,932(31)
	li 0,1
	la 9,.LC43@l(9)
	stw 0,512(31)
	lfs 12,0(9)
	lis 9,level+4@ha
	lfs 13,940(31)
	fsubs 0,0,12
	stfs 0,208(31)
	lfs 12,level+4@l(9)
	fcmpu 0,13,12
	bc 4,0,.L133
	lis 10,.LC38@ha
	la 10,.LC38@l(10)
	lfs 0,0(10)
	fadds 0,12,0
	stfs 0,940(31)
.L133:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,gunner_move_duck@ha
	li 0,201
	la 9,gunner_move_duck@l(9)
	stw 0,780(31)
	stw 9,772(31)
.L123:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 gunner_duck,.Lfe5-gunner_duck
	.section	".rodata"
	.align 2
.LC44:
	.string	"gunner/death1.wav"
	.align 2
.LC45:
	.string	"gunner/gunpain2.wav"
	.align 2
.LC46:
	.string	"gunner/gunpain1.wav"
	.align 2
.LC47:
	.string	"gunner/gunidle1.wav"
	.align 2
.LC48:
	.string	"gunner/gunatck1.wav"
	.align 2
.LC49:
	.string	"gunner/gunsrch1.wav"
	.align 2
.LC50:
	.string	"gunner/sight1.wav"
	.align 2
.LC51:
	.string	"gunner/gunatck2.wav"
	.align 2
.LC52:
	.string	"gunner/gunatck3.wav"
	.align 2
.LC53:
	.string	"models/monsters/gunner/tris.md2"
	.align 2
.LC54:
	.long 0x3f933333
	.align 2
.LC55:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_gunner
	.type	 SP_monster_gunner,@function
SP_monster_gunner:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 11,.LC55@ha
	lis 9,deathmatch@ha
	la 11,.LC55@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L144
	bl G_FreeEdict
	b .L143
.L144:
	lis 29,gi@ha
	lis 3,.LC44@ha
	la 29,gi@l(29)
	la 3,.LC44@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_death@ha
	lis 11,.LC45@ha
	stw 3,sound_death@l(9)
	mtlr 10
	la 3,.LC45@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain@ha
	lis 11,.LC46@ha
	stw 3,sound_pain@l(9)
	mtlr 10
	la 3,.LC46@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain2@ha
	lis 11,.LC47@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC47@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_idle@ha
	lis 11,.LC48@ha
	stw 3,sound_idle@l(9)
	mtlr 10
	la 3,.LC48@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_open@ha
	lis 11,.LC49@ha
	stw 3,sound_open@l(9)
	mtlr 10
	la 3,.LC49@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_search@ha
	lis 11,.LC50@ha
	stw 3,sound_search@l(9)
	mtlr 10
	la 3,.LC50@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sight@ha
	lis 11,.LC51@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC51@l(11)
	blrl
	lwz 9,36(29)
	lis 3,.LC52@ha
	la 3,.LC52@l(3)
	mtlr 9
	blrl
	li 0,5
	li 9,2
	stw 0,260(31)
	lis 3,.LC53@ha
	stw 9,248(31)
	la 3,.LC53@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,gunner_pain@ha
	lis 11,gunner_die@ha
	stw 3,40(31)
	lis 10,gunner_stand@ha
	lis 8,gunner_walk@ha
	lis 7,gunner_run@ha
	lis 6,M_MonsterDodge@ha
	la 9,gunner_pain@l(9)
	la 11,gunner_die@l(11)
	la 10,gunner_stand@l(10)
	la 8,gunner_walk@l(8)
	stw 9,452(31)
	la 7,gunner_run@l(7)
	la 6,M_MonsterDodge@l(6)
	stw 11,456(31)
	lis 0,0xc1c0
	stw 10,788(31)
	lis 5,gunner_duck@ha
	stw 8,800(31)
	lis 4,monster_duck_up@ha
	lis 28,gunner_sidestep@ha
	stw 7,804(31)
	lis 27,gunner_attack@ha
	lis 26,gunner_sight@ha
	stw 6,808(31)
	lis 25,gunner_search@ha
	lis 24,gunner_blocked@ha
	stw 0,196(31)
	lis 7,0xc180
	lis 6,0x4180
	lis 11,0x4200
	li 10,175
	stw 7,192(31)
	li 9,200
	la 5,gunner_duck@l(5)
	stw 11,208(31)
	la 4,monster_duck_up@l(4)
	la 28,gunner_sidestep@l(28)
	stw 10,480(31)
	la 27,gunner_attack@l(27)
	la 26,gunner_sight@l(26)
	stw 9,400(31)
	la 25,gunner_search@l(25)
	la 24,gunner_blocked@l(24)
	stw 5,920(31)
	li 8,-70
	li 0,0
	stw 6,204(31)
	stw 8,488(31)
	mr 3,31
	stw 4,924(31)
	stw 28,928(31)
	stw 27,812(31)
	stw 0,816(31)
	stw 26,820(31)
	stw 25,796(31)
	stw 24,892(31)
	stw 7,188(31)
	stw 6,200(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lis 11,.LC54@ha
	lis 9,gunner_move_stand@ha
	lfs 0,.LC54@l(11)
	lis 10,SP_monster_gunner@ha
	la 9,gunner_move_stand@l(9)
	la 10,SP_monster_gunner@l(10)
	li 0,1
	stw 9,772(31)
	mr 3,31
	stw 0,948(31)
	stfs 0,784(31)
	stw 10,992(31)
	bl walkmonster_start
.L143:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 SP_monster_gunner,.Lfe6-SP_monster_gunner
	.section	".sbss","aw",@nobits
	.align 2
sound_pain:
	.space	4
	.size	 sound_pain,4
	.align 2
sound_pain2:
	.space	4
	.size	 sound_pain2,4
	.align 2
sound_death:
	.space	4
	.size	 sound_death,4
	.align 2
sound_idle:
	.space	4
	.size	 sound_idle,4
	.align 2
sound_open:
	.space	4
	.size	 sound_open,4
	.align 2
sound_search:
	.space	4
	.size	 sound_search,4
	.align 2
sound_sight:
	.space	4
	.size	 sound_sight,4
	.section	".rodata"
	.align 2
.LC56:
	.long 0x3f800000
	.align 2
.LC57:
	.long 0x40000000
	.align 2
.LC58:
	.long 0x0
	.section	".text"
	.align 2
	.globl gunner_idlesound
	.type	 gunner_idlesound,@function
gunner_idlesound:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_idle@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC56@ha
	lwz 5,sound_idle@l(11)
	la 9,.LC56@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC57@ha
	la 9,.LC57@l(9)
	lfs 2,0(9)
	lis 9,.LC58@ha
	la 9,.LC58@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 gunner_idlesound,.Lfe7-gunner_idlesound
	.section	".rodata"
	.align 2
.LC59:
	.long 0x3f800000
	.align 2
.LC60:
	.long 0x0
	.section	".text"
	.align 2
	.globl gunner_sight
	.type	 gunner_sight,@function
gunner_sight:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_sight@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC59@ha
	lwz 5,sound_sight@l(11)
	la 9,.LC59@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC59@ha
	la 9,.LC59@l(9)
	lfs 2,0(9)
	lis 9,.LC60@ha
	la 9,.LC60@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 gunner_sight,.Lfe8-gunner_sight
	.section	".rodata"
	.align 2
.LC61:
	.long 0x3f800000
	.align 2
.LC62:
	.long 0x0
	.section	".text"
	.align 2
	.globl gunner_search
	.type	 gunner_search,@function
gunner_search:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_search@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC61@ha
	lwz 5,sound_search@l(11)
	la 9,.LC61@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC61@ha
	la 9,.LC61@l(9)
	lfs 2,0(9)
	lis 9,.LC62@ha
	la 9,.LC62@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 gunner_search,.Lfe9-gunner_search
	.align 2
	.globl gunner_fire_chain
	.type	 gunner_fire_chain,@function
gunner_fire_chain:
	lis 9,gunner_move_fire_chain@ha
	la 9,gunner_move_fire_chain@l(9)
	stw 9,772(3)
	blr
.Lfe10:
	.size	 gunner_fire_chain,.Lfe10-gunner_fire_chain
	.section	".rodata"
	.align 2
.LC63:
	.long 0x46fffe00
	.align 3
.LC64:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC65:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl gunner_refire_chain
	.type	 gunner_refire_chain,@function
gunner_refire_chain:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 4,540(31)
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L102
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L102
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC64@ha
	lis 11,.LC63@ha
	la 10,.LC64@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC65@ha
	lfs 12,.LC63@l(11)
	la 10,.LC65@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,0
	bc 4,3,.L102
	lis 9,gunner_move_fire_chain@ha
	la 9,gunner_move_fire_chain@l(9)
	b .L145
.L102:
	lis 9,gunner_move_endfire_chain@ha
	la 9,gunner_move_endfire_chain@l(9)
.L145:
	stw 9,772(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 gunner_refire_chain,.Lfe11-gunner_refire_chain
	.align 2
	.globl gunner_stand
	.type	 gunner_stand,@function
gunner_stand:
	lis 9,gunner_move_stand@ha
	la 9,gunner_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe12:
	.size	 gunner_stand,.Lfe12-gunner_stand
	.section	".rodata"
	.align 2
.LC66:
	.long 0x46fffe00
	.align 3
.LC67:
	.long 0x3fa99999
	.long 0x9999999a
	.align 3
.LC68:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl gunner_fidget
	.type	 gunner_fidget,@function
gunner_fidget:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,776(31)
	andi. 9,0,1
	bc 4,2,.L9
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC68@ha
	lis 10,.LC66@ha
	la 11,.LC68@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC67@ha
	lfs 11,.LC66@l(10)
	lfd 12,.LC67@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,0
	bc 4,3,.L9
	lis 9,gunner_move_fidget@ha
	la 9,gunner_move_fidget@l(9)
	stw 9,772(31)
.L9:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 gunner_fidget,.Lfe13-gunner_fidget
	.align 2
	.globl gunner_walk
	.type	 gunner_walk,@function
gunner_walk:
	lis 9,gunner_move_walk@ha
	la 9,gunner_move_walk@l(9)
	stw 9,772(3)
	blr
.Lfe14:
	.size	 gunner_walk,.Lfe14-gunner_walk
	.align 2
	.globl gunner_run
	.type	 gunner_run,@function
gunner_run:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl monster_done_dodge
	lwz 0,776(31)
	andi. 9,0,1
	bc 12,2,.L15
	lis 9,gunner_move_stand@ha
	la 9,gunner_move_stand@l(9)
	b .L146
.L15:
	lis 9,gunner_move_run@ha
	la 9,gunner_move_run@l(9)
.L146:
	stw 9,772(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe15:
	.size	 gunner_run,.Lfe15-gunner_run
	.align 2
	.globl gunner_runandshoot
	.type	 gunner_runandshoot,@function
gunner_runandshoot:
	lis 9,gunner_move_runandshoot@ha
	la 9,gunner_move_runandshoot@l(9)
	stw 9,772(3)
	blr
.Lfe16:
	.size	 gunner_runandshoot,.Lfe16-gunner_runandshoot
	.section	".rodata"
	.align 2
.LC69:
	.long 0x40400000
	.align 2
.LC70:
	.long 0x3f800000
	.align 2
.LC71:
	.long 0x0
	.section	".text"
	.align 2
	.globl gunner_pain
	.type	 gunner_pain,@function
gunner_pain:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,5
	lwz 0,484(31)
	lwz 11,480(31)
	srwi 9,0,31
	add 0,0,9
	srawi 0,0,1
	cmpw 0,11,0
	bc 4,0,.L19
	li 0,1
	stw 0,60(31)
.L19:
	mr 3,31
	bl monster_done_dodge
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L18
	lis 9,level+4@ha
	lfs 0,464(31)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L18
	lis 9,.LC69@ha
	la 9,.LC69@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,464(31)
	bl rand
	andi. 0,3,1
	bc 12,2,.L22
	lis 9,gi+16@ha
	lis 11,sound_pain@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC70@ha
	lwz 5,sound_pain@l(11)
	la 9,.LC70@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC70@ha
	la 9,.LC70@l(9)
	lfs 2,0(9)
	lis 9,.LC71@ha
	la 9,.LC71@l(9)
	lfs 3,0(9)
	blrl
	b .L23
.L22:
	lis 9,gi+16@ha
	lis 11,sound_pain2@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC70@ha
	lwz 5,sound_pain2@l(11)
	la 9,.LC70@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC70@ha
	la 9,.LC70@l(9)
	lfs 2,0(9)
	lis 9,.LC71@ha
	la 9,.LC71@l(9)
	lfs 3,0(9)
	blrl
.L23:
	lis 9,.LC69@ha
	lis 11,skill@ha
	la 9,.LC69@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L18
	cmpwi 0,30,10
	bc 12,1,.L25
	lis 9,gunner_move_pain3@ha
	la 9,gunner_move_pain3@l(9)
	b .L147
.L25:
	cmpwi 0,30,25
	bc 12,1,.L27
	lis 9,gunner_move_pain2@ha
	la 9,gunner_move_pain2@l(9)
	b .L147
.L27:
	lis 9,gunner_move_pain1@ha
	la 9,gunner_move_pain1@l(9)
.L147:
	stw 9,772(31)
	lwz 0,776(31)
	andi. 9,0,2048
	rlwinm 0,0,0,16,14
	stw 0,776(31)
	bc 12,2,.L18
	mr 3,31
	bl monster_duck_up
.L18:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe17:
	.size	 gunner_pain,.Lfe17-gunner_pain
	.align 2
	.globl gunner_dead
	.type	 gunner_dead,@function
gunner_dead:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 6,0xc180
	lwz 0,184(29)
	lis 7,0x4180
	lis 9,0xc1c0
	lis 10,0xc100
	li 8,7
	stw 9,196(29)
	ori 0,0,2
	li 11,0
	stw 6,192(29)
	stw 0,184(29)
	stw 7,204(29)
	stw 10,208(29)
	stw 8,260(29)
	stw 11,428(29)
	stw 6,188(29)
	stw 7,200(29)
	bl SetMonsterRespawn
	lis 9,gi+72@ha
	mr 3,29
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 gunner_dead,.Lfe18-gunner_dead
	.section	".rodata"
	.align 2
.LC72:
	.long 0x3f800000
	.align 2
.LC73:
	.long 0x0
	.section	".text"
	.align 2
	.globl gunner_die
	.type	 gunner_die,@function
gunner_die:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 30,3
	mr 28,6
	lwz 9,480(30)
	lwz 0,488(30)
	cmpw 0,9,0
	bc 12,1,.L32
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	lis 27,.LC3@ha
	lis 26,.LC4@ha
	li 31,2
	mtlr 9
	blrl
	lis 9,.LC72@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC72@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC72@ha
	la 9,.LC72@l(9)
	lfs 2,0(9)
	lis 9,.LC73@ha
	la 9,.LC73@l(9)
	lfs 3,0(9)
	blrl
.L36:
	mr 3,30
	la 4,.LC3@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L36
	li 31,4
.L41:
	mr 3,30
	la 4,.LC4@l(26)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L41
	lis 4,.LC5@ha
	mr 5,28
	la 4,.LC5@l(4)
	mr 3,30
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,492(30)
	b .L31
.L32:
	lwz 0,492(30)
	cmpwi 0,0,2
	bc 12,2,.L31
	lis 9,gi+16@ha
	lis 11,sound_death@ha
	lwz 0,gi+16@l(9)
	mr 3,30
	li 4,2
	lis 9,.LC72@ha
	lwz 5,sound_death@l(11)
	la 9,.LC72@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC72@ha
	la 9,.LC72@l(9)
	lfs 2,0(9)
	lis 9,.LC73@ha
	la 9,.LC73@l(9)
	lfs 3,0(9)
	blrl
	lis 9,gunner_move_death@ha
	li 0,2
	la 9,gunner_move_death@l(9)
	li 11,1
	stw 0,492(30)
	stw 9,772(30)
	stw 11,512(30)
.L31:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 gunner_die,.Lfe19-gunner_die
	.section	".rodata"
	.align 2
.LC74:
	.long 0x46fffe00
	.align 2
.LC75:
	.long 0x40000000
	.align 3
.LC76:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC77:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC78:
	.long 0x42000000
	.align 2
.LC79:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl gunner_duck_down
	.type	 gunner_duck_down,@function
gunner_duck_down:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lis 9,skill@ha
	lwz 0,776(31)
	lis 10,.LC75@ha
	lwz 11,skill@l(9)
	la 10,.LC75@l(10)
	ori 0,0,2048
	lfs 13,0(10)
	stw 0,776(31)
	lfs 0,20(11)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L45
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC76@ha
	lis 11,.LC74@ha
	la 10,.LC76@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC77@ha
	lfs 12,.LC74@l(11)
	la 10,.LC77@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L45
	mr 3,31
	bl GunnerGrenade
.L45:
	lis 9,.LC78@ha
	lfs 0,932(31)
	li 0,1
	la 9,.LC78@l(9)
	stw 0,512(31)
	lfs 12,0(9)
	lis 9,level+4@ha
	lfs 13,940(31)
	fsubs 0,0,12
	stfs 0,208(31)
	lfs 12,level+4@l(9)
	fcmpu 0,13,12
	bc 4,0,.L47
	lis 10,.LC79@ha
	la 10,.LC79@l(10)
	lfs 0,0(10)
	fadds 0,12,0
	stfs 0,940(31)
.L47:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 gunner_duck_down,.Lfe20-gunner_duck_down
	.section	".rodata"
	.align 2
.LC80:
	.long 0x3f800000
	.align 2
.LC81:
	.long 0x40000000
	.align 2
.LC82:
	.long 0x0
	.section	".text"
	.align 2
	.globl gunner_opengun
	.type	 gunner_opengun,@function
gunner_opengun:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_open@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC80@ha
	lwz 5,sound_open@l(11)
	la 9,.LC80@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	lfs 2,0(9)
	lis 9,.LC82@ha
	la 9,.LC82@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 gunner_opengun,.Lfe21-gunner_opengun
	.align 2
	.globl gunner_blind_check
	.type	 gunner_blind_check,@function
gunner_blind_check:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,776(31)
	andis. 9,0,1
	bc 12,2,.L84
	lfs 11,4(31)
	addi 3,1,8
	lfs 12,956(31)
	lfs 13,960(31)
	lfs 10,8(31)
	fsubs 12,12,11
	lfs 0,964(31)
	lfs 11,12(31)
	fsubs 13,13,10
	stfs 12,8(1)
	fsubs 0,0,11
	stfs 13,12(1)
	stfs 0,16(1)
	bl vectoyaw
	stfs 1,424(31)
.L84:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 gunner_blind_check,.Lfe22-gunner_blind_check
	.section	".rodata"
	.align 2
.LC83:
	.long 0x42c80000
	.align 2
.LC84:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl gunner_jump_now
	.type	 gunner_jump_now,@function
gunner_jump_now:
	stwu 1,-64(1)
	mflr 0
	stmw 27,44(1)
	stw 0,68(1)
	mr 29,3
	addi 27,1,24
	addi 28,29,376
	bl monster_jump_start
	addi 4,1,8
	mr 6,27
	addi 3,29,16
	li 5,0
	bl AngleVectors
	lis 9,.LC83@ha
	mr 3,28
	la 9,.LC83@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 9,.LC84@ha
	mr 3,28
	la 9,.LC84@l(9)
	mr 4,27
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lwz 0,68(1)
	mtlr 0
	lmw 27,44(1)
	la 1,64(1)
	blr
.Lfe23:
	.size	 gunner_jump_now,.Lfe23-gunner_jump_now
	.section	".rodata"
	.align 2
.LC85:
	.long 0x43160000
	.align 2
.LC86:
	.long 0x43c80000
	.section	".text"
	.align 2
	.globl gunner_jump2_now
	.type	 gunner_jump2_now,@function
gunner_jump2_now:
	stwu 1,-64(1)
	mflr 0
	stmw 27,44(1)
	stw 0,68(1)
	mr 29,3
	addi 27,1,24
	addi 28,29,376
	bl monster_jump_start
	addi 4,1,8
	mr 6,27
	addi 3,29,16
	li 5,0
	bl AngleVectors
	lis 9,.LC85@ha
	mr 3,28
	la 9,.LC85@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 9,.LC86@ha
	mr 3,28
	la 9,.LC86@l(9)
	mr 4,27
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lwz 0,68(1)
	mtlr 0
	lmw 27,44(1)
	la 1,64(1)
	blr
.Lfe24:
	.size	 gunner_jump2_now,.Lfe24-gunner_jump2_now
	.align 2
	.globl gunner_jump_wait_land
	.type	 gunner_jump_wait_land,@function
gunner_jump_wait_land:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L108
	lwz 0,56(31)
	stw 0,780(31)
	bl monster_jump_finished
	cmpwi 0,3,0
	bc 12,2,.L110
.L108:
	lwz 9,56(31)
	addi 9,9,1
	stw 9,780(31)
.L110:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 gunner_jump_wait_land,.Lfe25-gunner_jump_wait_land
	.align 2
	.globl gunner_jump
	.type	 gunner_jump,@function
gunner_jump:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 12,2,.L111
	bl monster_done_dodge
	lwz 9,540(31)
	lfs 13,12(31)
	lfs 0,12(9)
	fcmpu 0,0,13
	bc 4,1,.L113
	lis 9,gunner_move_jump2@ha
	la 9,gunner_move_jump2@l(9)
	b .L148
.L113:
	lis 9,gunner_move_jump@ha
	la 9,gunner_move_jump@l(9)
.L148:
	stw 9,772(31)
.L111:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe26:
	.size	 gunner_jump,.Lfe26-gunner_jump
	.section	".rodata"
	.align 3
.LC87:
	.long 0x3fa99999
	.long 0x9999999a
	.align 3
.LC88:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC89:
	.long 0x43400000
	.align 2
.LC90:
	.long 0x42200000
	.section	".text"
	.align 2
	.globl gunner_blocked
	.type	 gunner_blocked,@function
gunner_blocked:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 31,20(1)
	stw 0,36(1)
	lis 9,skill@ha
	fmr 31,1
	lis 11,.LC87@ha
	lwz 10,skill@l(9)
	mr 31,3
	lis 9,.LC88@ha
	lfd 0,.LC87@l(11)
	lfs 1,20(10)
	la 9,.LC88@l(9)
	lfd 13,0(9)
	fmadd 1,1,0,13
	frsp 1,1
	bl blocked_checkshot
	cmpwi 0,3,0
	li 3,1
	bc 4,2,.L149
	fmr 1,31
	mr 3,31
	bl blocked_checkplat
	cmpwi 0,3,0
	li 3,1
	bc 4,2,.L149
	lis 9,.LC89@ha
	fmr 1,31
	mr 3,31
	la 9,.LC89@l(9)
	lfs 2,0(9)
	lis 9,.LC90@ha
	la 9,.LC90@l(9)
	lfs 3,0(9)
	bl blocked_checkjump
	cmpwi 0,3,0
	bc 12,2,.L118
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 12,2,.L120
	mr 3,31
	bl monster_done_dodge
	lwz 9,540(31)
	lfs 13,12(31)
	lfs 0,12(9)
	fcmpu 0,0,13
	bc 4,1,.L121
	lis 9,gunner_move_jump2@ha
	la 9,gunner_move_jump2@l(9)
	b .L150
.L121:
	lis 9,gunner_move_jump@ha
	la 9,gunner_move_jump@l(9)
.L150:
	stw 9,772(31)
.L120:
	li 3,1
	b .L149
.L118:
	li 3,0
.L149:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 gunner_blocked,.Lfe27-gunner_blocked
	.section	".rodata"
	.align 2
.LC91:
	.long 0x0
	.section	".text"
	.align 2
	.globl gunner_sidestep
	.type	 gunner_sidestep,@function
gunner_sidestep:
	lis 9,gunner_move_jump2@ha
	lwz 0,772(3)
	la 9,gunner_move_jump2@l(9)
	cmpw 0,0,9
	bclr 12,2
	lis 9,gunner_move_jump@ha
	la 9,gunner_move_jump@l(9)
	cmpw 0,0,9
	bclr 12,2
	lis 9,gunner_move_attack_chain@ha
	la 9,gunner_move_attack_chain@l(9)
	cmpw 0,0,9
	bc 12,2,.L140
	lis 9,gunner_move_fire_chain@ha
	la 9,gunner_move_fire_chain@l(9)
	cmpw 0,0,9
	bc 12,2,.L140
	lis 9,gunner_move_attack_grenade@ha
	la 9,gunner_move_attack_grenade@l(9)
	cmpw 0,0,9
	bc 4,2,.L139
.L140:
	lis 9,.LC91@ha
	lis 11,skill@ha
	la 9,.LC91@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L139
	lwz 0,776(3)
	rlwinm 0,0,0,14,12
	stw 0,776(3)
	blr
.L139:
	lwz 0,772(3)
	lis 9,gunner_move_run@ha
	la 9,gunner_move_run@l(9)
	cmpw 0,0,9
	bclr 12,2
	stw 9,772(3)
	blr
.Lfe28:
	.size	 gunner_sidestep,.Lfe28-gunner_sidestep
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
