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
	.section	".rodata"
	.align 2
.LC2:
	.long 0x0
	.long 0x0
	.long 0x3f800000
	.align 2
.LC5:
	.string	"models/monsters/gunner/dead/tris.md2"
	.align 2
.LC6:
	.string	"mutant/mutatck2.wav"
	.align 2
.LC3:
	.long 0x46fffe00
	.align 3
.LC4:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC7:
	.long 0x0
	.align 3
.LC8:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC9:
	.long 0x42200000
	.align 3
.LC10:
	.long 0x40080000
	.long 0x0
	.align 2
.LC11:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl gunner_touch
	.type	 gunner_touch,@function
gunner_touch:
	stwu 1,-64(1)
	mflr 0
	stmw 27,44(1)
	stw 0,68(1)
	lis 8,.LC7@ha
	mr 30,3
	la 8,.LC7@l(8)
	lfs 0,428(30)
	lis 9,.LC2@ha
	lfs 13,0(8)
	addi 10,1,8
	mr 31,4
	lwz 8,.LC2@l(9)
	la 9,.LC2@l(9)
	fcmpu 0,0,13
	lwz 0,8(9)
	lwz 11,4(9)
	stw 8,8(1)
	stw 0,8(10)
	stw 11,4(10)
	bc 4,2,.L29
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L29
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L29
	li 3,19
	bl GetItemByTag
	mr 29,3
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,36(1)
	lis 8,.LC8@ha
	lis 11,.LC3@ha
	stw 0,32(1)
	la 8,.LC8@l(8)
	lis 10,.LC9@ha
	lfd 0,32(1)
	la 10,.LC9@l(10)
	cmpwi 0,29,0
	lfd 11,0(8)
	lfs 13,.LC3@l(11)
	lfs 10,0(10)
	fsub 0,0,11
	mr 10,9
	frsp 0,0
	fdivs 0,0,13
	fmadds 0,0,10,10
	fmr 13,0
	fctiwz 12,13
	stfd 12,32(1)
	lwz 28,36(1)
	bc 12,2,.L29
	lwz 9,84(31)
	lwz 0,4916(9)
	cmpwi 0,0,0
	bc 4,2,.L34
	lis 9,gi+40@ha
	lwz 3,12(29)
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	lwz 11,84(31)
	lis 10,level+4@ha
	lis 9,.LC4@ha
	lfd 13,.LC4@l(9)
	sth 3,158(11)
	lfs 0,level+4@l(10)
	lwz 9,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,5212(9)
	b .L29
.L34:
	lis 9,gi@ha
	lis 3,.LC5@ha
	la 27,gi@l(9)
	la 3,.LC5@l(3)
	lwz 9,32(27)
	mtlr 9
	blrl
	li 0,0
	stw 3,40(30)
	mr 4,28
	stw 0,56(30)
	mr 3,29
	li 5,0
	lwz 6,28(29)
	mr 7,31
	crxor 6,6,6
	bl Pickup_BAItem
	cmpwi 0,3,0
	bc 12,2,.L35
	lwz 9,84(31)
	lis 0,0x3e80
	stw 0,4716(9)
	lwz 0,40(27)
	lwz 3,12(29)
	mtlr 0
	blrl
	lis 9,itemlist@ha
	lis 0,0xba2e
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,35747
	subf 9,9,29
	sth 3,126(11)
	lis 10,level+4@ha
	mullw 9,9,0
	lwz 11,84(31)
	lis 8,.LC10@ha
	la 8,.LC10@l(8)
	srawi 9,9,2
	lfd 13,0(8)
	addi 9,9,1056
	sth 9,128(11)
	lfs 0,level+4@l(10)
	lwz 9,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,4836(9)
	b .L36
.L35:
	mr 4,29
	mr 5,28
	lwz 7,28(4)
	mr 3,30
	li 6,0
	bl MonsterDropItem
.L36:
	addi 5,1,8
	addi 4,30,4
	li 6,50
	li 3,1
	bl SpawnDamage
	lis 29,gi@ha
	lis 3,.LC6@ha
	la 29,gi@l(29)
	la 3,.LC6@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 11,16(29)
	lis 8,.LC11@ha
	lis 9,.LC11@ha
	lis 10,.LC7@ha
	la 8,.LC11@l(8)
	la 9,.LC11@l(9)
	la 10,.LC7@l(10)
	mtlr 11
	lfs 1,0(8)
	mr 5,3
	lfs 2,0(9)
	li 4,1
	mr 3,31
	lfs 3,0(10)
	blrl
	li 0,0
	mr 3,30
	stw 0,444(30)
	lwz 0,72(29)
	mtlr 0
	blrl
.L29:
	lwz 0,68(1)
	mtlr 0
	lmw 27,44(1)
	la 1,64(1)
	blr
.Lfe1:
	.size	 gunner_touch,.Lfe1-gunner_touch
	.globl gunner_frames_death
	.section	".data"
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
.LC12:
	.string	"misc/udeath.wav"
	.align 2
.LC13:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC14:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC15:
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
.LC17:
	.long 0xbe4ccccd
	.align 3
.LC18:
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
	bc 12,2,.L56
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L56
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
	lis 9,.LC17@ha
	addi 3,1,56
	lfs 1,.LC17@l(9)
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
	lis 8,.LC18@ha
	lfs 13,8(1)
	mr 3,26
	lwz 0,508(11)
	la 8,.LC18@l(8)
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
.L56:
	lwz 0,132(1)
	mtlr 0
	lmw 26,104(1)
	la 1,128(1)
	blr
.Lfe2:
	.size	 GunnerFire,.Lfe2-GunnerFire
	.section	".rodata"
	.align 3
.LC19:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC20:
	.long 0x42c80000
	.align 2
.LC21:
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
	bc 12,2,.L68
	lwz 0,776(31)
	andis. 10,0,1
	bc 12,2,.L61
	lwz 0,508(31)
	lis 11,0x4330
	lis 10,.LC19@ha
	lfs 13,12(31)
	xoris 0,0,0x8000
	la 10,.LC19@l(10)
	lfs 11,964(31)
	stw 0,156(1)
	stw 11,152(1)
	lfd 12,0(10)
	lfd 0,152(1)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	fcmpu 0,13,11
	bc 4,0,.L63
	b .L68
.L61:
	lfs 13,220(9)
	lfs 0,232(31)
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L68
.L63:
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
	bc 12,2,.L65
	lfs 0,956(31)
	lfs 13,960(31)
	lfs 12,964(31)
	stfs 0,120(1)
	stfs 13,124(1)
	stfs 12,128(1)
	b .L66
.L65:
	lwz 9,540(31)
	lfs 0,4(9)
	stfs 0,120(1)
	lfs 13,8(9)
	stfs 13,124(1)
	lfs 0,12(9)
	stfs 0,128(1)
.L66:
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
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L68
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
	bc 12,2,.L69
	lis 9,.LC21@ha
	lfs 13,64(1)
	la 9,.LC21@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L68
.L69:
	li 3,1
	b .L70
.L68:
	li 3,0
.L70:
	lwz 0,180(1)
	mtlr 0
	lmw 28,160(1)
	la 1,176(1)
	blr
.Lfe3:
	.size	 gunner_grenade_check,.Lfe3-gunner_grenade_check
	.section	".rodata"
	.align 2
.LC22:
	.long 0x3ca3d70a
	.align 2
.LC23:
	.long 0x3d4ccccd
	.align 2
.LC24:
	.long 0x3da3d70a
	.align 2
.LC25:
	.long 0x3de147ae
	.align 3
.LC26:
	.long 0x3fd99999
	.long 0x9999999a
	.align 2
.LC27:
	.long 0x3ecccccd
	.align 2
.LC28:
	.long 0x44000000
	.align 2
.LC29:
	.long 0x42800000
	.align 2
.LC30:
	.long 0xc2800000
	.align 3
.LC31:
	.long 0xbfe00000
	.long 0x0
	.align 2
.LC32:
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
	bc 12,2,.L71
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L71
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
	bc 4,30,.L75
	lis 9,.LC22@ha
	li 27,53
	lfs 30,.LC22@l(9)
	b .L76
.L75:
	cmpwi 0,11,115
	bc 4,2,.L77
	lis 9,.LC23@ha
	li 27,54
	lfs 30,.LC23@l(9)
	b .L76
.L77:
	cmpwi 0,11,118
	bc 4,2,.L79
	lis 9,.LC24@ha
	li 27,55
	lfs 30,.LC24@l(9)
	b .L76
.L79:
	lis 9,.LC25@ha
	rlwinm 0,10,0,16,14
	lfs 30,.LC25@l(9)
	li 27,56
	stw 0,776(31)
.L76:
	cmpwi 0,8,0
	bc 12,2,.L81
	lwz 4,540(31)
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L81
	lis 4,vec3_origin@ha
	addi 3,31,956
	la 4,vec3_origin@l(4)
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L71
	lfs 0,956(31)
	lfs 13,960(31)
	lfs 12,964(31)
	b .L89
.L81:
	lfs 0,4(31)
	lfs 13,8(31)
	lfs 12,12(31)
.L89:
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
	bc 12,2,.L84
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
	lis 9,.LC28@ha
	la 9,.LC28@l(9)
	lfs 12,0(9)
	fcmpu 0,1,12
	bc 4,1,.L85
	lis 9,.LC29@ha
	lfs 13,80(1)
	la 9,.LC29@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L85
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L85
	fsubs 0,1,12
	fadds 0,13,0
	stfs 0,80(1)
.L85:
	mr 3,30
	bl VectorNormalize
	lfs 31,80(1)
	lis 9,.LC26@ha
	lfd 0,.LC26@l(9)
	fmr 13,31
	fcmpu 0,13,0
	bc 4,1,.L86
	lis 9,.LC27@ha
	lfs 31,.LC27@l(9)
	b .L84
.L86:
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L84
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 31,0(9)
.L84:
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
.L71:
	lwz 0,164(1)
	mtlr 0
	lmw 24,112(1)
	lfd 30,144(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe4:
	.size	 GunnerGrenade,.Lfe4-GunnerGrenade
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
.LC33:
	.long 0x3ecccccd
	.align 2
.LC34:
	.long 0x3dcccccd
	.align 2
.LC35:
	.long 0x46fffe00
	.align 3
.LC36:
	.long 0x40106666
	.long 0x66666666
	.align 3
.LC37:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC38:
	.long 0x3f800000
	.align 3
.LC39:
	.long 0x401e0000
	.long 0x0
	.align 3
.LC40:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC41:
	.long 0x40080000
	.long 0x0
	.align 3
.LC42:
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
	bc 4,2,.L93
	lfs 13,952(31)
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L94
	lis 10,.LC38@ha
	la 10,.LC38@l(10)
	lfs 30,0(10)
	b .L95
.L94:
	lis 11,.LC39@ha
	la 11,.LC39@l(11)
	lfd 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L96
	lis 9,.LC33@ha
	lfs 30,.LC33@l(9)
	b .L95
.L96:
	lis 9,.LC34@ha
	lfs 30,.LC34@l(9)
.L95:
	bl rand
	lis 30,0x4330
	lis 9,.LC40@ha
	rlwinm 3,3,0,17,31
	la 9,.LC40@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC35@ha
	lfs 29,.LC35@l(11)
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
	lis 10,.LC41@ha
	stw 3,20(1)
	lis 11,.LC36@ha
	la 10,.LC41@l(10)
	stw 30,16(1)
	lis 4,vec3_origin@ha
	addi 3,31,956
	lfd 0,16(1)
	la 4,vec3_origin@l(4)
	lfd 10,0(10)
	lfd 11,.LC36@l(11)
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
	bc 4,2,.L92
	fcmpu 0,28,30
	bc 12,1,.L92
	lwz 0,776(31)
	mr 3,31
	oris 0,0,0x1
	stw 0,776(31)
	bl gunner_grenade_check
	cmpwi 0,3,0
	bc 12,2,.L100
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
.L100:
	lwz 0,776(31)
	rlwinm 0,0,0,16,14
	stw 0,776(31)
	b .L92
.L93:
	lwz 4,540(31)
	mr 3,31
	bl range
	cmpwi 0,3,0
	bc 12,2,.L104
	lwz 0,1060(31)
	cmpwi 0,0,0
	bc 4,2,.L104
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC40@ha
	lis 11,.LC35@ha
	la 10,.LC40@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC42@ha
	lfs 12,.LC35@l(11)
	la 10,.LC42@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,0
	bc 4,3,.L104
	mr 3,31
	bl gunner_grenade_check
	cmpwi 0,3,0
	bc 12,2,.L104
	lis 9,gunner_move_attack_grenade@ha
	la 9,gunner_move_attack_grenade@l(9)
	b .L106
.L104:
	lis 9,gunner_move_attack_chain@ha
	la 9,gunner_move_attack_chain@l(9)
.L106:
	stw 9,772(31)
.L92:
	lwz 0,68(1)
	mtlr 0
	lmw 30,24(1)
	lfd 28,32(1)
	lfd 29,40(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 gunner_attack,.Lfe5-gunner_attack
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
	.long 0
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
	.long gunner_jump_wait_land
	.long ai_move
	.long 0x0
	.long 0
	.size	 gunner_frames_jump,96
	.globl gunner_move_jump
	.align 2
	.type	 gunner_move_jump,@object
	.size	 gunner_move_jump,16
gunner_move_jump:
	.long 201
	.long 208
	.long gunner_frames_jump
	.long gunner_run
	.globl gunner_frames_jump2
	.align 2
	.type	 gunner_frames_jump2,@object
gunner_frames_jump2:
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
	.long gunner_jump_now
	.long ai_move
	.long 0x0
	.long gunner_jump_wait_land
	.long ai_move
	.long 0x0
	.long 0
	.size	 gunner_frames_jump2,96
	.globl gunner_move_jump2
	.align 2
	.type	 gunner_move_jump2,@object
	.size	 gunner_move_jump2,16
gunner_move_jump2:
	.long 201
	.long 208
	.long gunner_frames_jump2
	.long gunner_run
	.section	".rodata"
	.align 3
.LC45:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC46:
	.long 0x46fffe00
	.align 2
.LC47:
	.long 0x0
	.align 2
.LC48:
	.long 0x3f800000
	.align 2
.LC49:
	.long 0x40400000
	.align 2
.LC50:
	.long 0x40000000
	.align 3
.LC51:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC52:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC53:
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
	bc 12,2,.L132
	lis 9,gunner_move_jump@ha
	la 9,gunner_move_jump@l(9)
	cmpw 0,0,9
	bc 12,2,.L132
	lis 9,gunner_move_attack_chain@ha
	la 9,gunner_move_attack_chain@l(9)
	cmpw 0,0,9
	bc 12,2,.L136
	lis 9,gunner_move_fire_chain@ha
	la 9,gunner_move_fire_chain@l(9)
	cmpw 0,0,9
	bc 12,2,.L136
	lis 9,gunner_move_attack_grenade@ha
	la 9,gunner_move_attack_grenade@l(9)
	cmpw 0,0,9
	bc 4,2,.L135
.L136:
	lis 9,.LC47@ha
	lis 11,skill@ha
	la 9,.LC47@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L135
	lwz 0,776(31)
	rlwinm 0,0,0,21,19
	stw 0,776(31)
	b .L132
.L135:
	lis 9,skill@ha
	lis 10,.LC47@ha
	lwz 11,skill@l(9)
	la 10,.LC47@l(10)
	lfs 0,0(10)
	lfs 12,20(11)
	fcmpu 0,12,0
	bc 4,2,.L138
	lis 9,level+4@ha
	lis 11,.LC48@ha
	lfs 0,level+4@l(9)
	la 11,.LC48@l(11)
	lfs 13,0(11)
	fadds 0,0,1
	fadds 0,0,13
	b .L144
.L138:
	lis 10,.LC49@ha
	lis 9,level+4@ha
	la 10,.LC49@l(10)
	lfs 13,level+4@l(9)
	lfs 0,0(10)
	lis 9,.LC45@ha
	fadds 13,13,1
	fsubs 0,0,12
	lfd 12,.LC45@l(9)
	fmadd 0,0,12,13
	frsp 0,0
.L144:
	stfs 0,940(31)
	lis 11,.LC50@ha
	lwz 0,776(31)
	lis 9,skill@ha
	la 11,.LC50@l(11)
	lfs 13,0(11)
	ori 0,0,2048
	lwz 11,skill@l(9)
	stw 0,776(31)
	lfs 0,20(11)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L140
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC51@ha
	lis 11,.LC46@ha
	la 10,.LC51@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC52@ha
	lfs 12,.LC46@l(11)
	la 10,.LC52@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L140
	mr 3,31
	bl GunnerGrenade
.L140:
	lis 9,.LC53@ha
	lfs 0,932(31)
	li 0,1
	la 9,.LC53@l(9)
	stw 0,512(31)
	lfs 12,0(9)
	lis 9,level+4@ha
	lfs 13,940(31)
	fsubs 0,0,12
	stfs 0,208(31)
	lfs 12,level+4@l(9)
	fcmpu 0,13,12
	bc 4,0,.L142
	lis 10,.LC48@ha
	la 10,.LC48@l(10)
	lfs 0,0(10)
	fadds 0,12,0
	stfs 0,940(31)
.L142:
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
.L132:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 gunner_duck,.Lfe6-gunner_duck
	.section	".rodata"
	.align 2
.LC54:
	.string	"gunner/death1.wav"
	.align 2
.LC55:
	.string	"gunner/gunpain2.wav"
	.align 2
.LC56:
	.string	"gunner/gunpain1.wav"
	.align 2
.LC57:
	.string	"gunner/gunidle1.wav"
	.align 2
.LC58:
	.string	"gunner/gunatck1.wav"
	.align 2
.LC59:
	.string	"gunner/gunsrch1.wav"
	.align 2
.LC60:
	.string	"gunner/sight1.wav"
	.align 2
.LC61:
	.string	"gunner/gunatck2.wav"
	.align 2
.LC62:
	.string	"gunner/gunatck3.wav"
	.align 2
.LC63:
	.string	"models/monsters/gunner/tris.md2"
	.align 2
.LC64:
	.long 0x3f933333
	.align 2
.LC65:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_gunner
	.type	 SP_monster_gunner,@function
SP_monster_gunner:
	stwu 1,-48(1)
	mflr 0
	stmw 22,8(1)
	stw 0,52(1)
	lis 11,.LC65@ha
	lis 9,deathmatch@ha
	la 11,.LC65@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L153
	bl G_FreeEdict
	b .L152
.L153:
	lis 29,gi@ha
	lis 3,.LC54@ha
	la 29,gi@l(29)
	la 3,.LC54@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_death@ha
	lis 11,.LC55@ha
	stw 3,sound_death@l(9)
	mtlr 10
	la 3,.LC55@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain@ha
	lis 11,.LC56@ha
	stw 3,sound_pain@l(9)
	mtlr 10
	la 3,.LC56@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain2@ha
	lis 11,.LC57@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC57@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_idle@ha
	lis 11,.LC58@ha
	stw 3,sound_idle@l(9)
	mtlr 10
	la 3,.LC58@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_open@ha
	lis 11,.LC59@ha
	stw 3,sound_open@l(9)
	mtlr 10
	la 3,.LC59@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_search@ha
	lis 11,.LC60@ha
	stw 3,sound_search@l(9)
	mtlr 10
	la 3,.LC60@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sight@ha
	lis 11,.LC61@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC61@l(11)
	blrl
	lwz 9,36(29)
	lis 3,.LC62@ha
	la 3,.LC62@l(3)
	mtlr 9
	blrl
	li 0,5
	li 9,2
	stw 0,260(31)
	lis 3,.LC5@ha
	stw 9,248(31)
	la 3,.LC5@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC63@ha
	la 3,.LC63@l(3)
	mtlr 9
	blrl
	lis 9,gunner_pain@ha
	lis 11,gunner_die@ha
	lwz 22,264(31)
	lis 10,gunner_stand@ha
	lis 8,gunner_walk@ha
	stw 3,40(31)
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
	lis 23,GunnerDMGAdjust@ha
	lis 6,0xc180
	lis 7,0x4180
	lis 9,0x4200
	stw 6,192(31)
	li 11,-70
	la 5,gunner_duck@l(5)
	stw 9,208(31)
	la 4,monster_duck_up@l(4)
	la 28,gunner_sidestep@l(28)
	stw 11,488(31)
	la 27,gunner_attack@l(27)
	la 26,gunner_sight@l(26)
	stw 5,920(31)
	la 25,gunner_search@l(25)
	la 24,gunner_blocked@l(24)
	stw 7,204(31)
	la 23,GunnerDMGAdjust@l(23)
	oris 22,22,0x2
	stw 4,924(31)
	li 10,175
	li 0,200
	stw 28,928(31)
	li 8,0
	stw 10,480(31)
	mr 3,31
	stw 0,400(31)
	stw 27,812(31)
	stw 8,816(31)
	stw 26,820(31)
	stw 25,796(31)
	stw 24,892(31)
	stw 23,1000(31)
	stw 22,264(31)
	stw 6,188(31)
	stw 7,200(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lis 11,.LC64@ha
	lis 9,gunner_move_stand@ha
	lfs 0,.LC64@l(11)
	la 9,gunner_move_stand@l(9)
	li 0,1
	stw 9,772(31)
	mr 3,31
	stw 0,948(31)
	stfs 0,784(31)
	bl walkmonster_start
.L152:
	lwz 0,52(1)
	mtlr 0
	lmw 22,8(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 SP_monster_gunner,.Lfe7-SP_monster_gunner
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
.LC66:
	.long 0x3f800000
	.align 2
.LC67:
	.long 0x40000000
	.align 2
.LC68:
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
	lis 9,.LC66@ha
	lwz 5,sound_idle@l(11)
	la 9,.LC66@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC67@ha
	la 9,.LC67@l(9)
	lfs 2,0(9)
	lis 9,.LC68@ha
	la 9,.LC68@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 gunner_idlesound,.Lfe8-gunner_idlesound
	.section	".rodata"
	.align 2
.LC69:
	.long 0x3f800000
	.align 2
.LC70:
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
	lis 9,.LC69@ha
	lwz 5,sound_sight@l(11)
	la 9,.LC69@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC69@ha
	la 9,.LC69@l(9)
	lfs 2,0(9)
	lis 9,.LC70@ha
	la 9,.LC70@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 gunner_sight,.Lfe9-gunner_sight
	.section	".rodata"
	.align 2
.LC71:
	.long 0x3f800000
	.align 2
.LC72:
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
	lis 9,.LC71@ha
	lwz 5,sound_search@l(11)
	la 9,.LC71@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC71@ha
	la 9,.LC71@l(9)
	lfs 2,0(9)
	lis 9,.LC72@ha
	la 9,.LC72@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 gunner_search,.Lfe10-gunner_search
	.align 2
	.globl gunner_fire_chain
	.type	 gunner_fire_chain,@function
gunner_fire_chain:
	lis 9,gunner_move_fire_chain@ha
	la 9,gunner_move_fire_chain@l(9)
	stw 9,772(3)
	blr
.Lfe11:
	.size	 gunner_fire_chain,.Lfe11-gunner_fire_chain
	.section	".rodata"
	.align 2
.LC73:
	.long 0x46fffe00
	.align 3
.LC74:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC75:
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
	bc 4,1,.L109
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L109
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC74@ha
	lis 11,.LC73@ha
	la 10,.LC74@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC75@ha
	lfs 12,.LC73@l(11)
	la 10,.LC75@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,0
	bc 4,3,.L109
	lis 9,gunner_move_fire_chain@ha
	la 9,gunner_move_fire_chain@l(9)
	b .L154
.L109:
	lis 9,gunner_move_endfire_chain@ha
	la 9,gunner_move_endfire_chain@l(9)
.L154:
	stw 9,772(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 gunner_refire_chain,.Lfe12-gunner_refire_chain
	.align 2
	.globl gunner_stand
	.type	 gunner_stand,@function
gunner_stand:
	lis 9,gunner_move_stand@ha
	la 9,gunner_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe13:
	.size	 gunner_stand,.Lfe13-gunner_stand
	.section	".rodata"
	.align 2
.LC76:
	.long 0x46fffe00
	.align 3
.LC77:
	.long 0x3fa99999
	.long 0x9999999a
	.align 3
.LC78:
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
	lis 11,.LC78@ha
	lis 10,.LC76@ha
	la 11,.LC78@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC77@ha
	lfs 11,.LC76@l(10)
	lfd 12,.LC77@l(11)
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
.Lfe14:
	.size	 gunner_fidget,.Lfe14-gunner_fidget
	.align 2
	.globl gunner_walk
	.type	 gunner_walk,@function
gunner_walk:
	lis 9,gunner_move_walk@ha
	la 9,gunner_move_walk@l(9)
	stw 9,772(3)
	blr
.Lfe15:
	.size	 gunner_walk,.Lfe15-gunner_walk
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
	b .L155
.L15:
	lis 9,gunner_move_run@ha
	la 9,gunner_move_run@l(9)
.L155:
	stw 9,772(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe16:
	.size	 gunner_run,.Lfe16-gunner_run
	.align 2
	.globl gunner_runandshoot
	.type	 gunner_runandshoot,@function
gunner_runandshoot:
	lis 9,gunner_move_runandshoot@ha
	la 9,gunner_move_runandshoot@l(9)
	stw 9,772(3)
	blr
.Lfe17:
	.size	 gunner_runandshoot,.Lfe17-gunner_runandshoot
	.section	".rodata"
	.align 2
.LC79:
	.long 0x40400000
	.align 2
.LC80:
	.long 0x3f800000
	.align 2
.LC81:
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
	lis 9,.LC79@ha
	la 9,.LC79@l(9)
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
	lis 9,.LC80@ha
	lwz 5,sound_pain@l(11)
	la 9,.LC80@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC80@ha
	la 9,.LC80@l(9)
	lfs 2,0(9)
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	lfs 3,0(9)
	blrl
	b .L23
.L22:
	lis 9,gi+16@ha
	lis 11,sound_pain2@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC80@ha
	lwz 5,sound_pain2@l(11)
	la 9,.LC80@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC80@ha
	la 9,.LC80@l(9)
	lfs 2,0(9)
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	lfs 3,0(9)
	blrl
.L23:
	cmpwi 0,30,10
	bc 12,1,.L24
	lis 9,gunner_move_pain3@ha
	la 9,gunner_move_pain3@l(9)
	b .L156
.L24:
	cmpwi 0,30,25
	bc 12,1,.L26
	lis 9,gunner_move_pain2@ha
	la 9,gunner_move_pain2@l(9)
	b .L156
.L26:
	lis 9,gunner_move_pain1@ha
	la 9,gunner_move_pain1@l(9)
.L156:
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
.Lfe18:
	.size	 gunner_pain,.Lfe18-gunner_pain
	.align 2
	.globl gunner_dead
	.type	 gunner_dead,@function
gunner_dead:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 11,0xc1c0
	lwz 0,184(9)
	lis 10,gunner_touch@ha
	lis 5,0xc180
	stw 11,196(9)
	lis 4,0x4180
	la 10,gunner_touch@l(10)
	ori 0,0,2
	lis 8,0xc100
	stw 5,192(9)
	li 7,7
	li 11,0
	stw 4,204(9)
	stw 8,208(9)
	lis 6,gi+72@ha
	stw 7,260(9)
	stw 0,184(9)
	stw 11,428(9)
	stw 10,444(9)
	stw 5,188(9)
	stw 4,200(9)
	lwz 0,gi+72@l(6)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 gunner_dead,.Lfe19-gunner_dead
	.section	".rodata"
	.align 2
.LC82:
	.long 0x3f800000
	.align 2
.LC83:
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
	bc 12,1,.L39
	lis 29,gi@ha
	lis 3,.LC12@ha
	la 29,gi@l(29)
	la 3,.LC12@l(3)
	lwz 9,36(29)
	lis 27,.LC13@ha
	lis 26,.LC14@ha
	li 31,2
	mtlr 9
	blrl
	lis 9,.LC82@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC82@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC82@ha
	la 9,.LC82@l(9)
	lfs 2,0(9)
	lis 9,.LC83@ha
	la 9,.LC83@l(9)
	lfs 3,0(9)
	blrl
.L43:
	mr 3,30
	la 4,.LC13@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L43
	li 31,4
.L48:
	mr 3,30
	la 4,.LC14@l(26)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L48
	lis 4,.LC15@ha
	mr 5,28
	la 4,.LC15@l(4)
	mr 3,30
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,492(30)
	b .L38
.L39:
	lwz 0,492(30)
	cmpwi 0,0,2
	bc 12,2,.L38
	lis 9,gi+16@ha
	lis 11,sound_death@ha
	lwz 0,gi+16@l(9)
	mr 3,30
	li 4,2
	lis 9,.LC82@ha
	lwz 5,sound_death@l(11)
	la 9,.LC82@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC82@ha
	la 9,.LC82@l(9)
	lfs 2,0(9)
	lis 9,.LC83@ha
	la 9,.LC83@l(9)
	lfs 3,0(9)
	blrl
	lis 9,gunner_move_death@ha
	li 0,2
	la 9,gunner_move_death@l(9)
	li 11,1
	stw 0,492(30)
	stw 9,772(30)
	stw 11,512(30)
.L38:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 gunner_die,.Lfe20-gunner_die
	.section	".rodata"
	.align 2
.LC84:
	.long 0x46fffe00
	.align 2
.LC85:
	.long 0x40000000
	.align 3
.LC86:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC87:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC88:
	.long 0x42000000
	.align 2
.LC89:
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
	lis 10,.LC85@ha
	lwz 11,skill@l(9)
	la 10,.LC85@l(10)
	ori 0,0,2048
	lfs 13,0(10)
	stw 0,776(31)
	lfs 0,20(11)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L52
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC86@ha
	lis 11,.LC84@ha
	la 10,.LC86@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC87@ha
	lfs 12,.LC84@l(11)
	la 10,.LC87@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L52
	mr 3,31
	bl GunnerGrenade
.L52:
	lis 9,.LC88@ha
	lfs 0,932(31)
	li 0,1
	la 9,.LC88@l(9)
	stw 0,512(31)
	lfs 12,0(9)
	lis 9,level+4@ha
	lfs 13,940(31)
	fsubs 0,0,12
	stfs 0,208(31)
	lfs 12,level+4@l(9)
	fcmpu 0,13,12
	bc 4,0,.L54
	lis 10,.LC89@ha
	la 10,.LC89@l(10)
	lfs 0,0(10)
	fadds 0,12,0
	stfs 0,940(31)
.L54:
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
.Lfe21:
	.size	 gunner_duck_down,.Lfe21-gunner_duck_down
	.section	".rodata"
	.align 2
.LC90:
	.long 0x3f800000
	.align 2
.LC91:
	.long 0x40000000
	.align 2
.LC92:
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
	lis 9,.LC90@ha
	lwz 5,sound_open@l(11)
	la 9,.LC90@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC91@ha
	la 9,.LC91@l(9)
	lfs 2,0(9)
	lis 9,.LC92@ha
	la 9,.LC92@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 gunner_opengun,.Lfe22-gunner_opengun
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
	bc 12,2,.L91
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
.L91:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 gunner_blind_check,.Lfe23-gunner_blind_check
	.align 2
	.globl GunnerDMGAdjust
	.type	 GunnerDMGAdjust,@function
GunnerDMGAdjust:
	andi. 0,7,16
	li 10,0
	bc 12,2,.L113
	lwz 0,484(3)
	lwz 11,480(3)
	srwi 9,0,31
	add 0,0,9
	srawi 0,0,1
	cmpw 0,11,0
	bc 4,1,.L113
	lwz 0,996(3)
	cmpwi 0,0,258
	bc 4,2,.L113
	srawi 0,6,31
	srwi 0,0,30
	add 0,6,0
	srawi 0,0,2
	subf 10,0,6
.L113:
	mr 3,10
	blr
.Lfe24:
	.size	 GunnerDMGAdjust,.Lfe24-GunnerDMGAdjust
	.section	".rodata"
	.align 2
.LC93:
	.long 0x42c80000
	.align 2
.LC94:
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
	lis 9,.LC93@ha
	mr 3,28
	la 9,.LC93@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 9,.LC94@ha
	mr 3,28
	la 9,.LC94@l(9)
	mr 4,27
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lwz 0,68(1)
	mtlr 0
	lmw 27,44(1)
	la 1,64(1)
	blr
.Lfe25:
	.size	 gunner_jump_now,.Lfe25-gunner_jump_now
	.section	".rodata"
	.align 2
.LC95:
	.long 0x43160000
	.align 2
.LC96:
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
	lis 9,.LC95@ha
	mr 3,28
	la 9,.LC95@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 9,.LC96@ha
	mr 3,28
	la 9,.LC96@l(9)
	mr 4,27
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lwz 0,68(1)
	mtlr 0
	lmw 27,44(1)
	la 1,64(1)
	blr
.Lfe26:
	.size	 gunner_jump2_now,.Lfe26-gunner_jump2_now
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
	bc 4,2,.L117
	lwz 0,56(31)
	stw 0,780(31)
	bl monster_jump_finished
	cmpwi 0,3,0
	bc 12,2,.L119
.L117:
	lwz 9,56(31)
	addi 9,9,1
	stw 9,780(31)
.L119:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe27:
	.size	 gunner_jump_wait_land,.Lfe27-gunner_jump_wait_land
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
	bc 12,2,.L120
	bl monster_done_dodge
	lwz 9,540(31)
	lfs 13,12(31)
	lfs 0,12(9)
	fcmpu 0,0,13
	bc 4,1,.L122
	lis 9,gunner_move_jump2@ha
	la 9,gunner_move_jump2@l(9)
	b .L157
.L122:
	lis 9,gunner_move_jump@ha
	la 9,gunner_move_jump@l(9)
.L157:
	stw 9,772(31)
.L120:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe28:
	.size	 gunner_jump,.Lfe28-gunner_jump
	.section	".rodata"
	.align 3
.LC97:
	.long 0x3fa99999
	.long 0x9999999a
	.align 3
.LC98:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC99:
	.long 0x43400000
	.align 2
.LC100:
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
	lis 11,.LC97@ha
	lwz 10,skill@l(9)
	mr 31,3
	lis 9,.LC98@ha
	lfd 0,.LC97@l(11)
	lfs 1,20(10)
	la 9,.LC98@l(9)
	lfd 13,0(9)
	fmadd 1,1,0,13
	frsp 1,1
	bl blocked_checkshot
	cmpwi 0,3,0
	li 3,1
	bc 4,2,.L158
	fmr 1,31
	mr 3,31
	bl blocked_checkplat
	cmpwi 0,3,0
	li 3,1
	bc 4,2,.L158
	lis 9,.LC99@ha
	fmr 1,31
	mr 3,31
	la 9,.LC99@l(9)
	lfs 2,0(9)
	lis 9,.LC100@ha
	la 9,.LC100@l(9)
	lfs 3,0(9)
	bl blocked_checkjump
	cmpwi 0,3,0
	bc 12,2,.L127
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 12,2,.L129
	mr 3,31
	bl monster_done_dodge
	lwz 9,540(31)
	lfs 13,12(31)
	lfs 0,12(9)
	fcmpu 0,0,13
	bc 4,1,.L130
	lis 9,gunner_move_jump2@ha
	la 9,gunner_move_jump2@l(9)
	b .L159
.L130:
	lis 9,gunner_move_jump@ha
	la 9,gunner_move_jump@l(9)
.L159:
	stw 9,772(31)
.L129:
	li 3,1
	b .L158
.L127:
	li 3,0
.L158:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 gunner_blocked,.Lfe29-gunner_blocked
	.section	".rodata"
	.align 2
.LC101:
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
	bc 12,2,.L149
	lis 9,gunner_move_fire_chain@ha
	la 9,gunner_move_fire_chain@l(9)
	cmpw 0,0,9
	bc 12,2,.L149
	lis 9,gunner_move_attack_grenade@ha
	la 9,gunner_move_attack_grenade@l(9)
	cmpw 0,0,9
	bc 4,2,.L148
.L149:
	lis 9,.LC101@ha
	lis 11,skill@ha
	la 9,.LC101@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L148
	lwz 0,776(3)
	rlwinm 0,0,0,14,12
	stw 0,776(3)
	blr
.L148:
	lwz 0,772(3)
	lis 9,gunner_move_run@ha
	la 9,gunner_move_run@l(9)
	cmpw 0,0,9
	bclr 12,2
	stw 9,772(3)
	blr
.Lfe30:
	.size	 gunner_sidestep,.Lfe30-gunner_sidestep
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
