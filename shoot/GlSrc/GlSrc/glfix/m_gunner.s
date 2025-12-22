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
	.long 0
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
	.long gunner_duck_hold
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
	.long gunner_duck_up
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
.LC8:
	.long 0xbe4ccccd
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl GunnerFire
	.type	 GunnerFire,@function
GunnerFire:
	stwu 1,-144(1)
	mflr 0
	stmw 25,116(1)
	stw 0,148(1)
	mr 28,3
	addi 27,1,24
	lwz 26,56(28)
	addi 29,1,40
	mr 4,27
	addi 3,28,16
	mr 5,29
	addi 26,26,-99
	li 6,0
	bl AngleVectors
	mulli 0,26,12
	lis 4,monster_flash_offset@ha
	addi 25,1,72
	la 4,monster_flash_offset@l(4)
	mr 6,29
	add 4,0,4
	addi 7,1,8
	mr 5,27
	addi 3,28,4
	bl G_ProjectSource
	lwz 11,636(28)
	lis 9,.LC8@ha
	addi 3,1,56
	lfs 1,.LC8@l(9)
	mr 5,3
	lfs 13,4(11)
	addi 4,11,472
	stfs 13,56(1)
	lfs 0,8(11)
	stfs 0,60(1)
	lfs 13,12(11)
	stfs 13,64(1)
	bl VectorMA
	lwz 11,636(28)
	lis 10,0x4330
	lis 8,.LC9@ha
	lfs 13,8(1)
	mr 3,25
	lwz 0,604(11)
	la 8,.LC9@l(8)
	lfd 8,0(8)
	xoris 0,0,0x8000
	lfs 11,56(1)
	stw 0,108(1)
	stw 10,104(1)
	lfd 0,104(1)
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
	mr 3,28
	mr 5,25
	mr 10,26
	addi 4,1,8
	li 6,3
	li 7,4
	li 8,300
	li 9,500
	bl monster_fire_bullet
	lwz 0,148(1)
	mtlr 0
	lmw 25,116(1)
	la 1,144(1)
	blr
.Lfe1:
	.size	 GunnerFire,.Lfe1-GunnerFire
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
.LC12:
	.string	"gunner/death1.wav"
	.align 2
.LC13:
	.string	"gunner/gunpain2.wav"
	.align 2
.LC14:
	.string	"gunner/gunpain1.wav"
	.align 2
.LC15:
	.string	"gunner/gunidle1.wav"
	.align 2
.LC16:
	.string	"gunner/gunatck1.wav"
	.align 2
.LC17:
	.string	"gunner/gunsrch1.wav"
	.align 2
.LC18:
	.string	"gunner/sight1.wav"
	.align 2
.LC19:
	.string	"gunner/gunatck2.wav"
	.align 2
.LC20:
	.string	"gunner/gunatck3.wav"
	.align 2
.LC21:
	.string	"models/monsters/gunner/tris.md2"
	.align 2
.LC22:
	.long 0x3f933333
	.section	".text"
	.align 2
	.globl SP_monster_gunner
	.type	 SP_monster_gunner,@function
SP_monster_gunner:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 28,gi@ha
	mr 29,3
	la 28,gi@l(28)
	lis 3,.LC12@ha
	lwz 9,36(28)
	la 3,.LC12@l(3)
	mtlr 9
	blrl
	lwz 10,36(28)
	lis 9,sound_death@ha
	lis 11,.LC13@ha
	stw 3,sound_death@l(9)
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
	lis 9,sound_pain2@ha
	lis 11,.LC15@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC15@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_idle@ha
	lis 11,.LC16@ha
	stw 3,sound_idle@l(9)
	mtlr 10
	la 3,.LC16@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_open@ha
	lis 11,.LC17@ha
	stw 3,sound_open@l(9)
	mtlr 10
	la 3,.LC17@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_search@ha
	lis 11,.LC18@ha
	stw 3,sound_search@l(9)
	mtlr 10
	la 3,.LC18@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_sight@ha
	lis 11,.LC19@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC19@l(11)
	blrl
	lwz 9,36(28)
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	mtlr 9
	blrl
	li 0,5
	li 9,2
	stw 0,260(29)
	lis 3,.LC21@ha
	stw 9,248(29)
	la 3,.LC21@l(3)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,gunner_pain@ha
	lis 11,gunner_die@ha
	stw 3,40(29)
	lis 10,gunner_stand@ha
	lis 8,gunner_walk@ha
	la 9,gunner_pain@l(9)
	la 11,gunner_die@l(11)
	la 10,gunner_stand@l(10)
	la 8,gunner_walk@l(8)
	stw 9,548(29)
	lis 0,0xc1c0
	stw 11,552(29)
	lis 7,gunner_run@ha
	stw 10,884(29)
	lis 6,gunner_dodge@ha
	lis 5,gunner_attack@ha
	stw 8,896(29)
	lis 4,gunner_sight@ha
	lis 27,gunner_search@ha
	stw 0,196(29)
	lis 11,0x4200
	li 9,200
	la 7,gunner_run@l(7)
	la 6,gunner_dodge@l(6)
	stw 11,208(29)
	la 5,gunner_attack@l(5)
	la 4,gunner_sight@l(4)
	stw 9,496(29)
	la 27,gunner_search@l(27)
	lis 26,0xc180
	stw 7,900(29)
	lis 25,0x4180
	li 10,175
	stw 26,192(29)
	li 8,-70
	li 0,0
	stw 25,204(29)
	stw 10,576(29)
	mr 3,29
	stw 8,584(29)
	stw 6,904(29)
	stw 5,908(29)
	stw 0,912(29)
	stw 4,916(29)
	stw 27,892(29)
	stw 26,188(29)
	stw 25,200(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lis 11,.LC22@ha
	lis 9,gunner_move_stand@ha
	lfs 0,.LC22@l(11)
	la 9,gunner_move_stand@l(9)
	mr 3,29
	stw 9,868(29)
	stfs 0,880(29)
	bl walkmonster_start
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 SP_monster_gunner,.Lfe2-SP_monster_gunner
	.section	".rodata"
	.align 2
.LC23:
	.long 0x3f933333
	.align 2
.LC24:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl SP_monster_gunner2
	.type	 SP_monster_gunner2,@function
SP_monster_gunner2:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr 28,3
	li 4,36
	li 5,100
	li 6,10
	bl CheckBounds
	cmpwi 0,3,0
	bc 12,2,.L73
	bl G_Spawn
	lwz 9,84(28)
	mr 29,3
	li 6,0
	addi 4,1,8
	li 5,0
	addi 3,9,3636
	addi 27,29,4
	bl AngleVectors
	lis 9,.LC24@ha
	mr 5,27
	la 9,.LC24@l(9)
	addi 4,1,8
	lfs 1,0(9)
	addi 3,28,4
	bl VectorMA
	lfs 0,20(28)
	li 3,1
	lis 28,gi@ha
	la 28,gi@l(28)
	stfs 0,20(29)
	lwz 9,100(28)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xbdef
	lwz 10,104(28)
	lwz 3,g_edicts@l(9)
	ori 0,0,31711
	mtlr 10
	subf 3,3,29
	mullw 3,3,0
	srawi 3,3,5
	blrl
	lwz 9,100(28)
	li 3,9
	mtlr 9
	blrl
	lwz 9,88(28)
	li 4,2
	mr 3,27
	mtlr 9
	blrl
	lwz 9,36(28)
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	mtlr 9
	blrl
	lwz 10,36(28)
	lis 9,sound_death@ha
	lis 11,.LC13@ha
	stw 3,sound_death@l(9)
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
	lis 9,sound_pain2@ha
	lis 11,.LC15@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC15@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_idle@ha
	lis 11,.LC16@ha
	stw 3,sound_idle@l(9)
	mtlr 10
	la 3,.LC16@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_open@ha
	lis 11,.LC17@ha
	stw 3,sound_open@l(9)
	mtlr 10
	la 3,.LC17@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_search@ha
	lis 11,.LC18@ha
	stw 3,sound_search@l(9)
	mtlr 10
	la 3,.LC18@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_sight@ha
	lis 11,.LC19@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC19@l(11)
	blrl
	lwz 9,36(28)
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	mtlr 9
	blrl
	li 0,5
	li 9,2
	stw 0,260(29)
	lis 3,.LC21@ha
	stw 9,248(29)
	la 3,.LC21@l(3)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,gunner_pain@ha
	lis 11,gunner_die@ha
	stw 3,40(29)
	lis 10,gunner_stand@ha
	lis 8,gunner_walk@ha
	la 9,gunner_pain@l(9)
	la 11,gunner_die@l(11)
	la 10,gunner_stand@l(10)
	la 8,gunner_walk@l(8)
	stw 9,548(29)
	lis 0,0xc1c0
	stw 11,552(29)
	lis 7,gunner_run@ha
	stw 10,884(29)
	lis 6,gunner_dodge@ha
	lis 5,gunner_attack@ha
	stw 8,896(29)
	lis 4,gunner_sight@ha
	lis 27,gunner_search@ha
	stw 0,196(29)
	lis 11,0x4200
	li 9,200
	la 7,gunner_run@l(7)
	la 6,gunner_dodge@l(6)
	stw 11,208(29)
	la 5,gunner_attack@l(5)
	la 4,gunner_sight@l(4)
	stw 9,496(29)
	la 27,gunner_search@l(27)
	lis 26,0xc180
	stw 7,900(29)
	lis 25,0x4180
	li 10,175
	stw 26,192(29)
	li 8,-70
	li 0,0
	stw 25,204(29)
	stw 10,576(29)
	mr 3,29
	stw 8,584(29)
	stw 6,904(29)
	stw 5,908(29)
	stw 0,912(29)
	stw 4,916(29)
	stw 27,892(29)
	stw 26,188(29)
	stw 25,200(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lis 11,.LC23@ha
	lis 9,gunner_move_stand@ha
	lfs 0,.LC23@l(11)
	la 9,gunner_move_stand@l(9)
	mr 3,29
	stw 9,868(29)
	stfs 0,880(29)
	bl walkmonster_start
.L73:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 SP_monster_gunner2,.Lfe3-SP_monster_gunner2
	.comm	maplist,292,4
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
.LC25:
	.long 0x3f800000
	.align 2
.LC26:
	.long 0x40000000
	.align 2
.LC27:
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
	lis 9,.LC25@ha
	lwz 5,sound_idle@l(11)
	la 9,.LC25@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC26@ha
	la 9,.LC26@l(9)
	lfs 2,0(9)
	lis 9,.LC27@ha
	la 9,.LC27@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 gunner_idlesound,.Lfe4-gunner_idlesound
	.align 2
	.globl gunner_sight
	.type	 gunner_sight,@function
gunner_sight:
	blr
.Lfe5:
	.size	 gunner_sight,.Lfe5-gunner_sight
	.section	".rodata"
	.align 2
.LC28:
	.long 0x3f800000
	.align 2
.LC29:
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
	lis 9,.LC28@ha
	lwz 5,sound_search@l(11)
	la 9,.LC28@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC28@ha
	la 9,.LC28@l(9)
	lfs 2,0(9)
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 gunner_search,.Lfe6-gunner_search
	.align 2
	.globl GunnerGrenade
	.type	 GunnerGrenade,@function
GunnerGrenade:
	stwu 1,-96(1)
	mflr 0
	stmw 28,80(1)
	stw 0,100(1)
	mr 31,3
	lwz 0,56(31)
	cmpwi 0,0,112
	bc 4,2,.L56
	li 30,53
	b .L57
.L56:
	cmpwi 0,0,115
	bc 4,2,.L58
	li 30,54
	b .L57
.L58:
	xori 0,0,118
	srawi 11,0,31
	xor 9,11,0
	subf 9,9,11
	srawi 9,9,31
	nor 0,9,9
	rlwinm 9,9,0,26,28
	andi. 0,0,55
	or 30,9,0
.L57:
	addi 29,1,24
	addi 28,1,40
	mr 4,29
	addi 3,31,16
	mr 5,28
	li 6,0
	bl AngleVectors
	mulli 0,30,12
	lis 4,monster_flash_offset@ha
	mr 5,29
	la 4,monster_flash_offset@l(4)
	mr 6,28
	add 4,0,4
	addi 3,31,4
	addi 7,1,8
	bl G_ProjectSource
	lfs 12,24(1)
	mr 3,31
	mr 8,30
	lfs 13,28(1)
	addi 4,1,8
	addi 5,1,56
	lfs 0,32(1)
	li 6,50
	li 7,600
	stfs 12,56(1)
	stfs 13,60(1)
	stfs 0,64(1)
	bl monster_fire_grenade
	lwz 0,100(1)
	mtlr 0
	lmw 28,80(1)
	la 1,96(1)
	blr
.Lfe7:
	.size	 GunnerGrenade,.Lfe7-GunnerGrenade
	.align 2
	.globl gunner_fire_chain
	.type	 gunner_fire_chain,@function
gunner_fire_chain:
	lis 9,gunner_move_fire_chain@ha
	la 9,gunner_move_fire_chain@l(9)
	stw 9,868(3)
	blr
.Lfe8:
	.size	 gunner_fire_chain,.Lfe8-gunner_fire_chain
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
	lwz 4,636(31)
	lwz 0,576(4)
	cmpwi 0,0,0
	bc 4,1,.L69
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L69
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
	cror 3,2,0
	bc 4,3,.L69
	lis 9,gunner_move_fire_chain@ha
	la 9,gunner_move_fire_chain@l(9)
	b .L75
.L69:
	lis 9,gunner_move_endfire_chain@ha
	la 9,gunner_move_endfire_chain@l(9)
.L75:
	stw 9,868(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 gunner_refire_chain,.Lfe9-gunner_refire_chain
	.align 2
	.globl gunner_stand
	.type	 gunner_stand,@function
gunner_stand:
	lis 9,gunner_move_stand@ha
	la 9,gunner_move_stand@l(9)
	stw 9,868(3)
	blr
.Lfe10:
	.size	 gunner_stand,.Lfe10-gunner_stand
	.section	".rodata"
	.align 2
.LC33:
	.long 0x46fffe00
	.align 3
.LC34:
	.long 0x3fa99999
	.long 0x9999999a
	.align 3
.LC35:
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
	lwz 0,872(31)
	andi. 9,0,1
	bc 4,2,.L9
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC35@ha
	lis 10,.LC33@ha
	la 11,.LC35@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC34@ha
	lfs 11,.LC33@l(10)
	lfd 12,.LC34@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,0
	bc 4,3,.L9
	lis 9,gunner_move_fidget@ha
	la 9,gunner_move_fidget@l(9)
	stw 9,868(31)
.L9:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 gunner_fidget,.Lfe11-gunner_fidget
	.align 2
	.globl gunner_walk
	.type	 gunner_walk,@function
gunner_walk:
	lis 9,gunner_move_walk@ha
	la 9,gunner_move_walk@l(9)
	stw 9,868(3)
	blr
.Lfe12:
	.size	 gunner_walk,.Lfe12-gunner_walk
	.align 2
	.globl gunner_run
	.type	 gunner_run,@function
gunner_run:
	lwz 0,872(3)
	andi. 9,0,1
	bc 12,2,.L15
	lis 9,gunner_move_stand@ha
	la 9,gunner_move_stand@l(9)
	stw 9,868(3)
	blr
.L15:
	lis 9,gunner_move_run@ha
	la 9,gunner_move_run@l(9)
	stw 9,868(3)
	blr
.Lfe13:
	.size	 gunner_run,.Lfe13-gunner_run
	.align 2
	.globl gunner_runandshoot
	.type	 gunner_runandshoot,@function
gunner_runandshoot:
	lis 9,gunner_move_runandshoot@ha
	la 9,gunner_move_runandshoot@l(9)
	stw 9,868(3)
	blr
.Lfe14:
	.size	 gunner_runandshoot,.Lfe14-gunner_runandshoot
	.section	".rodata"
	.align 2
.LC36:
	.long 0x40400000
	.align 2
.LC37:
	.long 0x3f800000
	.align 2
.LC38:
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
	lwz 0,580(31)
	lwz 11,576(31)
	srwi 9,0,31
	add 0,0,9
	srawi 0,0,1
	cmpw 0,11,0
	bc 4,0,.L19
	li 0,1
	stw 0,60(31)
.L19:
	lis 9,level+4@ha
	lfs 0,560(31)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L18
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,560(31)
	bl rand
	andi. 0,3,1
	bc 12,2,.L21
	lis 9,gi+16@ha
	lis 11,sound_pain@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC37@ha
	lwz 5,sound_pain@l(11)
	la 9,.LC37@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 2,0(9)
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 3,0(9)
	blrl
	b .L22
.L21:
	lis 9,gi+16@ha
	lis 11,sound_pain2@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC37@ha
	lwz 5,sound_pain2@l(11)
	la 9,.LC37@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 2,0(9)
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 3,0(9)
	blrl
.L22:
	lis 9,.LC36@ha
	lis 11,skill@ha
	la 9,.LC36@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L18
	cmpwi 0,30,10
	bc 12,1,.L24
	lis 9,gunner_move_pain3@ha
	la 9,gunner_move_pain3@l(9)
	b .L76
.L24:
	cmpwi 0,30,25
	bc 12,1,.L26
	lis 9,gunner_move_pain2@ha
	la 9,gunner_move_pain2@l(9)
	b .L76
.L26:
	lis 9,gunner_move_pain1@ha
	la 9,gunner_move_pain1@l(9)
.L76:
	stw 9,868(31)
.L18:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe15:
	.size	 gunner_pain,.Lfe15-gunner_pain
	.section	".rodata"
	.align 2
.LC39:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl gunner_dead
	.type	 gunner_dead,@function
gunner_dead:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 9,3
	lis 11,0xc1c0
	lwz 10,184(9)
	lis 4,0xc180
	lis 5,0x4180
	stw 11,196(9)
	li 0,0
	lis 8,0xc100
	li 29,7
	ori 10,10,2
	stw 0,524(9)
	lis 11,.LC39@ha
	stw 4,192(9)
	lis 7,level+4@ha
	la 11,.LC39@l(11)
	stw 5,204(9)
	lis 6,gi+72@ha
	stw 8,208(9)
	stw 29,260(9)
	stw 10,184(9)
	stw 4,188(9)
	stw 5,200(9)
	lfs 0,level+4@l(7)
	lfs 13,0(11)
	lis 11,G_FreeEdict@ha
	la 11,G_FreeEdict@l(11)
	fadds 0,0,13
	stw 11,532(9)
	stfs 0,524(9)
	lwz 0,gi+72@l(6)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 gunner_dead,.Lfe16-gunner_dead
	.section	".rodata"
	.align 2
.LC40:
	.long 0x3f800000
	.align 2
.LC41:
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
	lwz 9,576(30)
	lwz 0,584(30)
	cmpw 0,9,0
	bc 12,1,.L30
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
	lis 9,.LC40@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC40@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 2,0(9)
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 3,0(9)
	blrl
.L34:
	mr 3,30
	la 4,.LC3@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L34
	li 31,4
.L39:
	mr 3,30
	la 4,.LC4@l(26)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L39
	lis 4,.LC5@ha
	mr 5,28
	la 4,.LC5@l(4)
	mr 3,30
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,588(30)
	b .L29
.L30:
	lwz 0,588(30)
	cmpwi 0,0,2
	bc 12,2,.L29
	lis 9,gi+16@ha
	lis 11,sound_death@ha
	lwz 0,gi+16@l(9)
	mr 3,30
	li 4,2
	lis 9,.LC40@ha
	lwz 5,sound_death@l(11)
	la 9,.LC40@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 2,0(9)
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 3,0(9)
	blrl
	lis 9,gunner_move_death@ha
	li 0,2
	la 9,gunner_move_death@l(9)
	li 11,1
	stw 0,588(30)
	stw 9,868(30)
	stw 11,608(30)
.L29:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 gunner_die,.Lfe17-gunner_die
	.section	".rodata"
	.align 2
.LC42:
	.long 0x46fffe00
	.align 2
.LC43:
	.long 0x40000000
	.align 3
.LC44:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC45:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC46:
	.long 0x42000000
	.align 2
.LC47:
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
	lwz 0,872(31)
	andi. 9,0,2048
	bc 4,2,.L42
	lis 9,skill@ha
	ori 0,0,2048
	lwz 11,skill@l(9)
	lis 10,.LC43@ha
	la 10,.LC43@l(10)
	stw 0,872(31)
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L44
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC44@ha
	lis 11,.LC42@ha
	la 10,.LC44@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC45@ha
	lfs 12,.LC42@l(11)
	la 10,.LC45@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L44
	mr 3,31
	bl GunnerGrenade
.L44:
	lis 9,.LC46@ha
	lfs 13,208(31)
	li 0,1
	la 9,.LC46@l(9)
	lis 10,.LC47@ha
	stw 0,608(31)
	lfs 0,0(9)
	la 10,.LC47@l(10)
	lis 11,gi+72@ha
	lis 9,level+4@ha
	lfs 12,0(10)
	mr 3,31
	fsubs 13,13,0
	stfs 13,208(31)
	lfs 0,level+4@l(9)
	fadds 0,0,12
	stfs 0,924(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L42:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 gunner_duck_down,.Lfe18-gunner_duck_down
	.align 2
	.globl gunner_duck_hold
	.type	 gunner_duck_hold,@function
gunner_duck_hold:
	lis 9,level+4@ha
	lfs 0,924(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L47
	lwz 0,872(3)
	rlwinm 0,0,0,25,23
	stw 0,872(3)
	blr
.L47:
	lwz 0,872(3)
	ori 0,0,128
	stw 0,872(3)
	blr
.Lfe19:
	.size	 gunner_duck_hold,.Lfe19-gunner_duck_hold
	.section	".rodata"
	.align 2
.LC48:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl gunner_duck_up
	.type	 gunner_duck_up,@function
gunner_duck_up:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC48@ha
	mr 9,3
	la 11,.LC48@l(11)
	lfs 0,208(9)
	lis 10,gi+72@ha
	lfs 13,0(11)
	lwz 0,872(9)
	li 11,2
	stw 11,608(9)
	fadds 0,0,13
	rlwinm 0,0,0,21,19
	stw 0,872(9)
	stfs 0,208(9)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe20:
	.size	 gunner_duck_up,.Lfe20-gunner_duck_up
	.section	".rodata"
	.align 2
.LC49:
	.long 0x46fffe00
	.align 3
.LC50:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC51:
	.long 0x3fd00000
	.long 0x0
	.section	".text"
	.align 2
	.globl gunner_dodge
	.type	 gunner_dodge,@function
gunner_dodge:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC50@ha
	lis 11,.LC49@ha
	la 10,.LC50@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC51@ha
	lfs 12,.LC49@l(11)
	la 10,.LC51@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,1,.L50
	lwz 0,636(31)
	cmpwi 0,0,0
	bc 4,2,.L52
	stw 30,636(31)
.L52:
	lis 9,gunner_move_duck@ha
	la 9,gunner_move_duck@l(9)
	stw 9,868(31)
.L50:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 gunner_dodge,.Lfe21-gunner_dodge
	.section	".rodata"
	.align 2
.LC52:
	.long 0x3f800000
	.align 2
.LC53:
	.long 0x40000000
	.align 2
.LC54:
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
	lis 9,.LC52@ha
	lwz 5,sound_open@l(11)
	la 9,.LC52@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	lfs 2,0(9)
	lis 9,.LC54@ha
	la 9,.LC54@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 gunner_opengun,.Lfe22-gunner_opengun
	.section	".rodata"
	.align 2
.LC55:
	.long 0x46fffe00
	.align 3
.LC56:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC57:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl gunner_attack
	.type	 gunner_attack,@function
gunner_attack:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 4,636(31)
	bl range
	cmpwi 0,3,0
	bc 12,2,.L65
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC56@ha
	lis 11,.LC55@ha
	la 10,.LC56@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC57@ha
	lfs 12,.LC55@l(11)
	la 10,.LC57@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,0
	bc 4,3,.L65
	lis 9,gunner_move_attack_grenade@ha
	la 9,gunner_move_attack_grenade@l(9)
	b .L77
.L65:
	lis 9,gunner_move_attack_chain@ha
	la 9,gunner_move_attack_chain@l(9)
.L77:
	stw 9,868(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 gunner_attack,.Lfe23-gunner_attack
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
