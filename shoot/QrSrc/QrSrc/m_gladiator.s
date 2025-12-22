	.file	"m_gladiator.c"
gcc2_compiled.:
	.globl gladiator_frames_stand
	.section	".data"
	.align 2
	.type	 gladiator_frames_stand,@object
gladiator_frames_stand:
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.size	 gladiator_frames_stand,84
	.globl gladiator_move_stand
	.align 2
	.type	 gladiator_move_stand,@object
	.size	 gladiator_move_stand,16
gladiator_move_stand:
	.long 0
	.long 6
	.long gladiator_frames_stand
	.long 0
	.globl gladiator_frames_walk
	.align 2
	.type	 gladiator_frames_walk,@object
gladiator_frames_walk:
	.long ai_walk
	.long 0x41700000
	.long 0
	.long ai_walk
	.long 0x40e00000
	.long 0
	.long ai_walk
	.long 0x40c00000
	.long 0
	.long ai_walk
	.long 0x40a00000
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x0
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x41000000
	.long 0
	.long ai_walk
	.long 0x41400000
	.long 0
	.long ai_walk
	.long 0x41000000
	.long 0
	.long ai_walk
	.long 0x40a00000
	.long 0
	.long ai_walk
	.long 0x40a00000
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
	.long ai_walk
	.long 0x41000000
	.long 0
	.size	 gladiator_frames_walk,192
	.globl gladiator_move_walk
	.align 2
	.type	 gladiator_move_walk,@object
	.size	 gladiator_move_walk,16
gladiator_move_walk:
	.long 7
	.long 22
	.long gladiator_frames_walk
	.long 0
	.globl gladiator_frames_run
	.align 2
	.type	 gladiator_frames_run,@object
gladiator_frames_run:
	.long ai_run
	.long 0x41b80000
	.long 0
	.long ai_run
	.long 0x41600000
	.long 0
	.long ai_run
	.long 0x41600000
	.long 0
	.long ai_run
	.long 0x41a80000
	.long 0
	.long ai_run
	.long 0x41400000
	.long 0
	.long ai_run
	.long 0x41500000
	.long 0
	.size	 gladiator_frames_run,72
	.globl gladiator_move_run
	.align 2
	.type	 gladiator_move_run,@object
	.size	 gladiator_move_run,16
gladiator_move_run:
	.long 23
	.long 28
	.long gladiator_frames_run
	.long 0
	.globl gladiator_frames_attack_melee
	.align 2
	.type	 gladiator_frames_attack_melee,@object
gladiator_frames_attack_melee:
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
	.long gladiator_cleaver_swing
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long GaldiatorMelee
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
	.long gladiator_cleaver_swing
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long GaldiatorMelee
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.size	 gladiator_frames_attack_melee,204
	.globl gladiator_move_attack_melee
	.align 2
	.type	 gladiator_move_attack_melee,@object
	.size	 gladiator_move_attack_melee,16
gladiator_move_attack_melee:
	.long 29
	.long 45
	.long gladiator_frames_attack_melee
	.long gladiator_run
	.globl gladiator_frames_attack_gun
	.align 2
	.type	 gladiator_frames_attack_gun,@object
gladiator_frames_attack_gun:
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
	.long GladiatorGun
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
	.size	 gladiator_frames_attack_gun,108
	.globl gladiator_move_attack_gun
	.align 2
	.type	 gladiator_move_attack_gun,@object
	.size	 gladiator_move_attack_gun,16
gladiator_move_attack_gun:
	.long 46
	.long 54
	.long gladiator_frames_attack_gun
	.long gladiator_run
	.globl gladiator_frames_pain
	.align 2
	.type	 gladiator_frames_pain,@object
gladiator_frames_pain:
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
	.size	 gladiator_frames_pain,72
	.globl gladiator_move_pain
	.align 2
	.type	 gladiator_move_pain,@object
	.size	 gladiator_move_pain,16
gladiator_move_pain:
	.long 55
	.long 60
	.long gladiator_frames_pain
	.long gladiator_run
	.globl gladiator_frames_pain_air
	.align 2
	.type	 gladiator_frames_pain_air,@object
gladiator_frames_pain_air:
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
	.size	 gladiator_frames_pain_air,84
	.globl gladiator_move_pain_air
	.align 2
	.type	 gladiator_move_pain_air,@object
	.size	 gladiator_move_pain_air,16
gladiator_move_pain_air:
	.long 83
	.long 89
	.long gladiator_frames_pain_air
	.long gladiator_run
	.section	".rodata"
	.align 2
.LC0:
	.long 0x46fffe00
	.align 2
.LC1:
	.long 0x42c80000
	.align 2
.LC2:
	.long 0x40400000
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC4:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC5:
	.long 0x3f800000
	.align 2
.LC6:
	.long 0x0
	.section	".text"
	.align 2
	.globl gladiator_pain
	.type	 gladiator_pain,@function
gladiator_pain:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,484(31)
	lwz 11,480(31)
	srwi 9,0,31
	add 0,0,9
	srawi 0,0,1
	cmpw 0,11,0
	bc 4,0,.L23
	li 0,1
	stw 0,60(31)
.L23:
	lis 9,level+4@ha
	lfs 0,464(31)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L24
	lis 9,.LC1@ha
	lfs 13,384(31)
	la 9,.LC1@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L22
	lwz 0,788(31)
	lis 9,gladiator_move_pain@ha
	la 9,gladiator_move_pain@l(9)
	cmpw 0,0,9
	bc 4,2,.L22
	lis 9,gladiator_move_pain_air@ha
	la 9,gladiator_move_pain_air@l(9)
	b .L31
.L24:
	lis 10,.LC2@ha
	la 10,.LC2@l(10)
	lfs 0,0(10)
	fadds 0,13,0
	stfs 0,464(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC3@ha
	lis 11,.LC0@ha
	la 10,.LC3@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC4@ha
	lfs 12,.LC0@l(11)
	la 10,.LC4@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L26
	lis 9,gi+16@ha
	lis 11,sound_pain1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC6@ha
	mr 3,31
	lwz 5,sound_pain1@l(11)
	lis 9,.LC5@ha
	la 10,.LC6@l(10)
	lis 11,.LC5@ha
	la 9,.LC5@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC5@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L27
.L26:
	lis 9,gi+16@ha
	lis 11,sound_pain2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC5@ha
	mr 3,31
	lwz 5,sound_pain2@l(11)
	lis 9,.LC5@ha
	la 10,.LC5@l(10)
	lis 11,.LC6@ha
	la 9,.LC5@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC6@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L27:
	lis 9,.LC2@ha
	lis 11,skill@ha
	la 9,.LC2@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L22
	lis 10,.LC1@ha
	lfs 13,384(31)
	la 10,.LC1@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L29
	lis 9,gladiator_move_pain_air@ha
	la 9,gladiator_move_pain_air@l(9)
	b .L31
.L29:
	lis 9,gladiator_move_pain@ha
	la 9,gladiator_move_pain@l(9)
.L31:
	stw 9,788(31)
.L22:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 gladiator_pain,.Lfe1-gladiator_pain
	.globl gladiator_frames_death
	.section	".data"
	.align 2
	.type	 gladiator_frames_death,@object
gladiator_frames_death:
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
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 gladiator_frames_death,264
	.globl gladiator_move_death
	.align 2
	.type	 gladiator_move_death,@object
	.size	 gladiator_move_death,16
gladiator_move_death:
	.long 61
	.long 82
	.long gladiator_frames_death
	.long gladiator_dead
	.section	".rodata"
	.align 2
.LC7:
	.string	"misc/udeath.wav"
	.align 2
.LC8:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC9:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC10:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC11:
	.string	"gladiator/pain.wav"
	.align 2
.LC12:
	.string	"gladiator/gldpain2.wav"
	.align 2
.LC13:
	.string	"gladiator/glddeth2.wav"
	.align 2
.LC14:
	.string	"gladiator/railgun.wav"
	.align 2
.LC15:
	.string	"gladiator/melee1.wav"
	.align 2
.LC16:
	.string	"gladiator/melee2.wav"
	.align 2
.LC17:
	.string	"gladiator/melee3.wav"
	.align 2
.LC18:
	.string	"gladiator/gldidle1.wav"
	.align 2
.LC19:
	.string	"gladiator/gldsrch1.wav"
	.align 2
.LC20:
	.string	"gladiator/sight.wav"
	.align 2
.LC21:
	.string	"models/monsters/gladiatr/tris.md2"
	.align 2
.LC22:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_gladiator
	.type	 SP_monster_gladiator,@function
SP_monster_gladiator:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 11,.LC22@ha
	lis 9,deathmatch@ha
	la 11,.LC22@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L47
	bl G_FreeEdict
	b .L46
.L47:
	lis 29,gi@ha
	lis 3,.LC11@ha
	la 29,gi@l(29)
	la 3,.LC11@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_pain1@ha
	lis 11,.LC12@ha
	stw 3,sound_pain1@l(9)
	mtlr 10
	la 3,.LC12@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain2@ha
	lis 11,.LC13@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC13@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_die@ha
	lis 11,.LC14@ha
	stw 3,sound_die@l(9)
	mtlr 10
	la 3,.LC14@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_gun@ha
	lis 11,.LC15@ha
	stw 3,sound_gun@l(9)
	mtlr 10
	la 3,.LC15@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_cleaver_swing@ha
	lis 11,.LC16@ha
	stw 3,sound_cleaver_swing@l(9)
	mtlr 10
	la 3,.LC16@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_cleaver_hit@ha
	lis 11,.LC17@ha
	stw 3,sound_cleaver_hit@l(9)
	mtlr 10
	la 3,.LC17@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_cleaver_miss@ha
	lis 11,.LC18@ha
	stw 3,sound_cleaver_miss@l(9)
	mtlr 10
	la 3,.LC18@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_idle@ha
	lis 11,.LC19@ha
	stw 3,sound_idle@l(9)
	mtlr 10
	la 3,.LC19@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_search@ha
	lis 11,.LC20@ha
	stw 3,sound_search@l(9)
	mtlr 10
	la 3,.LC20@l(11)
	blrl
	lis 9,sound_sight@ha
	li 0,5
	stw 3,sound_sight@l(9)
	li 11,2
	stw 0,260(31)
	lis 3,.LC21@ha
	stw 11,248(31)
	la 3,.LC21@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,gladiator_pain@ha
	lis 11,gladiator_die@ha
	stw 3,40(31)
	lis 10,gladiator_stand@ha
	lis 8,gladiator_walk@ha
	la 9,gladiator_pain@l(9)
	la 11,gladiator_die@l(11)
	la 10,gladiator_stand@l(10)
	la 8,gladiator_walk@l(8)
	stw 9,452(31)
	stw 11,456(31)
	lis 7,gladiator_run@ha
	lis 6,gladiator_attack@ha
	stw 10,804(31)
	lis 5,gladiator_melee@ha
	lis 4,gladiator_sight@ha
	stw 8,816(31)
	lis 28,gladiator_idle@ha
	lis 27,gladiator_search@ha
	li 8,400
	lis 9,0x4280
	la 7,gladiator_run@l(7)
	la 6,gladiator_attack@l(6)
	stw 9,208(31)
	la 5,gladiator_melee@l(5)
	la 4,gladiator_sight@l(4)
	stw 7,820(31)
	la 28,gladiator_idle@l(28)
	la 27,gladiator_search@l(27)
	stw 8,400(31)
	lis 26,0xc200
	lis 25,0x4200
	stw 6,828(31)
	lis 0,0xc1c0
	li 11,-175
	stw 26,192(31)
	li 10,0
	stw 0,196(31)
	mr 3,31
	stw 25,204(31)
	stw 11,488(31)
	stw 10,824(31)
	stw 5,832(31)
	stw 4,836(31)
	stw 28,808(31)
	stw 27,812(31)
	stw 26,188(31)
	stw 25,200(31)
	stw 8,480(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lis 9,gladiator_move_stand@ha
	lis 0,0x3f80
	la 9,gladiator_move_stand@l(9)
	stw 0,800(31)
	mr 3,31
	stw 9,788(31)
	bl walkmonster_start
.L46:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 SP_monster_gladiator,.Lfe2-SP_monster_gladiator
	.section	".sbss","aw",@nobits
	.align 2
sound_pain1:
	.space	4
	.size	 sound_pain1,4
	.align 2
sound_pain2:
	.space	4
	.size	 sound_pain2,4
	.align 2
sound_die:
	.space	4
	.size	 sound_die,4
	.align 2
sound_gun:
	.space	4
	.size	 sound_gun,4
	.align 2
sound_cleaver_swing:
	.space	4
	.size	 sound_cleaver_swing,4
	.align 2
sound_cleaver_hit:
	.space	4
	.size	 sound_cleaver_hit,4
	.align 2
sound_cleaver_miss:
	.space	4
	.size	 sound_cleaver_miss,4
	.align 2
sound_idle:
	.space	4
	.size	 sound_idle,4
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
.LC23:
	.long 0x3f800000
	.align 2
.LC24:
	.long 0x40000000
	.align 2
.LC25:
	.long 0x0
	.section	".text"
	.align 2
	.globl gladiator_idle
	.type	 gladiator_idle,@function
gladiator_idle:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_idle@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC23@ha
	lwz 5,sound_idle@l(11)
	la 9,.LC23@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 2,0(9)
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 gladiator_idle,.Lfe3-gladiator_idle
	.section	".rodata"
	.align 2
.LC26:
	.long 0x3f800000
	.align 2
.LC27:
	.long 0x0
	.section	".text"
	.align 2
	.globl gladiator_sight
	.type	 gladiator_sight,@function
gladiator_sight:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_sight@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC26@ha
	lwz 5,sound_sight@l(11)
	la 9,.LC26@l(9)
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
	.size	 gladiator_sight,.Lfe4-gladiator_sight
	.section	".rodata"
	.align 2
.LC28:
	.long 0x3f800000
	.align 2
.LC29:
	.long 0x0
	.section	".text"
	.align 2
	.globl gladiator_search
	.type	 gladiator_search,@function
gladiator_search:
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
.Lfe5:
	.size	 gladiator_search,.Lfe5-gladiator_search
	.section	".rodata"
	.align 2
.LC30:
	.long 0x3f800000
	.align 2
.LC31:
	.long 0x0
	.section	".text"
	.align 2
	.globl gladiator_cleaver_swing
	.type	 gladiator_cleaver_swing,@function
gladiator_cleaver_swing:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_cleaver_swing@ha
	lwz 0,gi+16@l(9)
	li 4,1
	lis 9,.LC30@ha
	lwz 5,sound_cleaver_swing@l(11)
	la 9,.LC30@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 2,0(9)
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 gladiator_cleaver_swing,.Lfe6-gladiator_cleaver_swing
	.align 2
	.globl gladiator_stand
	.type	 gladiator_stand,@function
gladiator_stand:
	lis 9,gladiator_move_stand@ha
	la 9,gladiator_move_stand@l(9)
	stw 9,788(3)
	blr
.Lfe7:
	.size	 gladiator_stand,.Lfe7-gladiator_stand
	.align 2
	.globl gladiator_walk
	.type	 gladiator_walk,@function
gladiator_walk:
	lis 9,gladiator_move_walk@ha
	la 9,gladiator_move_walk@l(9)
	stw 9,788(3)
	blr
.Lfe8:
	.size	 gladiator_walk,.Lfe8-gladiator_walk
	.align 2
	.globl gladiator_run
	.type	 gladiator_run,@function
gladiator_run:
	lwz 0,792(3)
	andi. 9,0,1
	bc 12,2,.L13
	lis 9,gladiator_move_stand@ha
	la 9,gladiator_move_stand@l(9)
	stw 9,788(3)
	blr
.L13:
	lis 9,gladiator_move_run@ha
	la 9,gladiator_move_run@l(9)
	stw 9,788(3)
	blr
.Lfe9:
	.size	 gladiator_run,.Lfe9-gladiator_run
	.section	".rodata"
	.align 2
.LC32:
	.long 0x3f800000
	.align 2
.LC33:
	.long 0x0
	.section	".text"
	.align 2
	.globl GaldiatorMelee
	.type	 GaldiatorMelee,@function
GaldiatorMelee:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lis 0,0x42a0
	lfs 0,188(31)
	lis 9,0xc080
	stw 0,8(1)
	stw 9,16(1)
	stfs 0,12(1)
	bl rand
	lis 9,0x6666
	mr 5,3
	ori 9,9,26215
	srawi 11,5,31
	mulhw 9,5,9
	mr 3,31
	addi 4,1,8
	li 6,300
	srawi 9,9,1
	subf 9,11,9
	slwi 0,9,2
	add 0,0,9
	subf 5,0,5
	addi 5,5,20
	bl fire_hit
	cmpwi 0,3,0
	bc 12,2,.L16
	lis 9,gi+16@ha
	lis 11,sound_cleaver_hit@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,0
	lis 9,.LC32@ha
	lwz 5,sound_cleaver_hit@l(11)
	la 9,.LC32@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 2,0(9)
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	lfs 3,0(9)
	blrl
	b .L17
.L16:
	lis 9,gi+16@ha
	lis 11,sound_cleaver_miss@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,0
	lis 9,.LC32@ha
	lwz 5,sound_cleaver_miss@l(11)
	la 9,.LC32@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 2,0(9)
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	lfs 3,0(9)
	blrl
.L17:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 GaldiatorMelee,.Lfe10-GaldiatorMelee
	.align 2
	.globl gladiator_melee
	.type	 gladiator_melee,@function
gladiator_melee:
	lis 9,gladiator_move_attack_melee@ha
	la 9,gladiator_move_attack_melee@l(9)
	stw 9,788(3)
	blr
.Lfe11:
	.size	 gladiator_melee,.Lfe11-gladiator_melee
	.align 2
	.globl GladiatorGun
	.type	 GladiatorGun,@function
GladiatorGun:
	stwu 1,-96(1)
	mflr 0
	stmw 26,72(1)
	stw 0,100(1)
	mr 29,3
	addi 28,1,40
	addi 27,1,56
	addi 26,1,24
	mr 4,28
	addi 3,29,16
	mr 5,27
	li 6,0
	bl AngleVectors
	lis 4,monster_flash_offset+732@ha
	mr 5,28
	la 4,monster_flash_offset+732@l(4)
	mr 6,27
	addi 7,1,8
	addi 3,29,4
	bl G_ProjectSource
	lfs 12,352(29)
	mr 3,26
	lfs 11,8(1)
	lfs 13,356(29)
	lfs 0,360(29)
	fsubs 12,12,11
	lfs 10,12(1)
	lfs 11,16(1)
	fsubs 13,13,10
	stfs 12,24(1)
	fsubs 0,0,11
	stfs 13,28(1)
	stfs 0,32(1)
	bl VectorNormalize
	mr 3,29
	mr 5,26
	addi 4,1,8
	li 6,50
	li 7,100
	li 8,61
	bl monster_fire_railgun
	lwz 0,100(1)
	mtlr 0
	lmw 26,72(1)
	la 1,96(1)
	blr
.Lfe12:
	.size	 GladiatorGun,.Lfe12-GladiatorGun
	.section	".rodata"
	.align 2
.LC34:
	.long 0x42e00000
	.align 2
.LC35:
	.long 0x3f800000
	.align 2
.LC36:
	.long 0x0
	.align 3
.LC37:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl gladiator_attack
	.type	 gladiator_attack,@function
gladiator_attack:
	stwu 1,-48(1)
	mflr 0
	stw 31,44(1)
	stw 0,52(1)
	mr 31,3
	lwz 9,540(31)
	addi 3,1,8
	lfs 13,4(31)
	lfs 0,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	cror 3,2,0
	bc 12,3,.L20
	lis 9,gi+16@ha
	lis 11,sound_gun@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,1
	lis 9,.LC35@ha
	lwz 5,sound_gun@l(11)
	la 9,.LC35@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 2,0(9)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,540(31)
	lis 8,0x4330
	lis 9,.LC37@ha
	lfs 13,4(11)
	la 9,.LC37@l(9)
	lfd 12,0(9)
	lis 9,gladiator_move_attack_gun@ha
	stfs 13,352(31)
	la 9,gladiator_move_attack_gun@l(9)
	lfs 0,8(11)
	stfs 0,356(31)
	lfs 13,12(11)
	stfs 13,360(31)
	lwz 0,508(11)
	stw 9,788(31)
	xoris 0,0,0x8000
	stw 0,36(1)
	stw 8,32(1)
	lfd 0,32(1)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,360(31)
.L20:
	lwz 0,52(1)
	mtlr 0
	lwz 31,44(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 gladiator_attack,.Lfe13-gladiator_attack
	.align 2
	.globl gladiator_dead
	.type	 gladiator_dead,@function
gladiator_dead:
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
.Lfe14:
	.size	 gladiator_dead,.Lfe14-gladiator_dead
	.section	".rodata"
	.align 2
.LC38:
	.long 0x3f800000
	.align 2
.LC39:
	.long 0x0
	.section	".text"
	.align 2
	.globl gladiator_die
	.type	 gladiator_die,@function
gladiator_die:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 30,3
	mr 28,6
	lwz 9,480(30)
	lwz 0,488(30)
	cmpw 0,9,0
	bc 12,1,.L34
	lis 29,gi@ha
	lis 3,.LC7@ha
	la 29,gi@l(29)
	la 3,.LC7@l(3)
	lwz 9,36(29)
	lis 27,.LC8@ha
	lis 26,.LC9@ha
	li 31,2
	mtlr 9
	blrl
	lis 9,.LC38@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC38@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 2,0(9)
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 3,0(9)
	blrl
.L38:
	mr 3,30
	la 4,.LC8@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L38
	li 31,4
.L43:
	mr 3,30
	la 4,.LC9@l(26)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L43
	lis 4,.LC10@ha
	mr 5,28
	la 4,.LC10@l(4)
	mr 3,30
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,492(30)
	b .L33
.L34:
	lwz 0,492(30)
	cmpwi 0,0,2
	bc 12,2,.L33
	lis 9,gi+16@ha
	lis 11,sound_die@ha
	lwz 0,gi+16@l(9)
	mr 3,30
	li 4,2
	lis 9,.LC38@ha
	lwz 5,sound_die@l(11)
	la 9,.LC38@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 2,0(9)
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 3,0(9)
	blrl
	lis 9,gladiator_move_death@ha
	li 0,2
	la 9,gladiator_move_death@l(9)
	li 11,1
	stw 0,492(30)
	stw 9,788(30)
	stw 11,512(30)
.L33:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 gladiator_die,.Lfe15-gladiator_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
