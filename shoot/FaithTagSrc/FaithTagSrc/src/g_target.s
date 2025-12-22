	.file	"g_target.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"target_speaker with no noise set at %s\n"
	.align 2
.LC1:
	.string	".wav"
	.align 2
.LC2:
	.string	"%s.wav"
	.align 2
.LC3:
	.long 0x0
	.align 2
.LC4:
	.long 0xbf800000
	.section	".text"
	.align 2
	.globl SP_target_speaker
	.type	 SP_target_speaker,@function
SP_target_speaker:
	stwu 1,-96(1)
	mflr 0
	stmw 29,84(1)
	stw 0,100(1)
	lis 9,st@ha
	mr 31,3
	la 29,st@l(9)
	lwz 3,36(29)
	cmpwi 0,3,0
	bc 4,2,.L16
	lis 29,gi@ha
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L15
.L16:
	lis 4,.LC1@ha
	la 4,.LC1@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L17
	lis 5,.LC2@ha
	lwz 6,36(29)
	addi 3,1,8
	la 5,.LC2@l(5)
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	b .L18
.L17:
	lwz 4,36(29)
	addi 3,1,8
	li 5,64
	bl strncpy
.L18:
	lis 9,gi+36@ha
	addi 3,1,8
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
	lis 9,.LC3@ha
	lfs 0,584(31)
	la 9,.LC3@l(9)
	stw 3,576(31)
	lfs 12,0(9)
	fcmpu 0,0,12
	bc 4,2,.L19
	lis 0,0x3f80
	stw 0,584(31)
.L19:
	lfs 13,588(31)
	fcmpu 0,13,12
	bc 4,2,.L20
	lis 0,0x3f80
	stw 0,588(31)
	b .L21
.L20:
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L21
	stfs 12,588(31)
.L21:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L23
	lwz 0,576(31)
	stw 0,76(31)
.L23:
	lis 9,Use_Target_Speaker@ha
	lis 11,gi+72@ha
	la 9,Use_Target_Speaker@l(9)
	mr 3,31
	stw 9,448(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L15:
	lwz 0,100(1)
	mtlr 0
	lmw 29,84(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 SP_target_speaker,.Lfe1-SP_target_speaker
	.section	".rodata"
	.align 2
.LC5:
	.string	"%s with no message at %s\n"
	.align 2
.LC6:
	.string	"misc/secret.wav"
	.align 2
.LC7:
	.string	"mine3"
	.align 2
.LC8:
	.string	"You have found a secret area."
	.align 2
.LC9:
	.string	"0"
	.align 2
.LC10:
	.string	"%s exited the level.\n"
	.align 2
.LC11:
	.string	"*"
	.align 2
.LC12:
	.long 0x0
	.section	".text"
	.align 2
	.globl use_target_changelevel
	.type	 use_target_changelevel,@function
use_target_changelevel:
	stwu 1,-48(1)
	mflr 0
	stw 31,44(1)
	stw 0,52(1)
	lis 11,.LC12@ha
	lis 9,level+200@ha
	la 11,.LC12@l(11)
	lfs 0,level+200@l(9)
	mr 31,3
	lfs 13,0(11)
	mr 3,4
	fcmpu 0,0,13
	bc 4,2,.L45
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L47
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L47
	lis 9,g_edicts@ha
	lwz 11,g_edicts@l(9)
	lwz 0,1380(11)
	cmpwi 0,0,0
	bc 4,1,.L45
.L47:
	lis 9,.LC12@ha
	lis 11,deathmatch@ha
	la 9,.LC12@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L49
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,32(1)
	lwz 11,36(1)
	andi. 11,11,4096
	bc 4,2,.L49
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,3,0
	bc 12,2,.L49
	lwz 9,484(3)
	lis 6,vec3_origin@ha
	mr 4,31
	la 6,vec3_origin@l(6)
	li 0,28
	stw 11,8(1)
	mulli 9,9,10
	mr 5,4
	stw 0,12(1)
	addi 7,3,4
	mr 8,6
	li 10,1000
	bl T_Damage
	b .L45
.L49:
	lis 9,.LC12@ha
	lis 11,deathmatch@ha
	la 9,.LC12@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L50
	cmpwi 0,5,0
	bc 12,2,.L50
	lwz 5,84(5)
	cmpwi 0,5,0
	bc 12,2,.L50
	lis 9,gi@ha
	lis 4,.LC10@ha
	lwz 0,gi@l(9)
	la 4,.LC10@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L50:
	lwz 3,504(31)
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L52
	lis 9,game@ha
	la 9,game@l(9)
	lwz 0,1552(9)
	rlwinm 0,0,0,0,23
	stw 0,1552(9)
.L52:
	mr 3,31
	bl BeginIntermission
.L45:
	lwz 0,52(1)
	mtlr 0
	lwz 31,44(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 use_target_changelevel,.Lfe2-use_target_changelevel
	.section	".rodata"
	.align 2
.LC13:
	.string	"target_changelevel with no map at %s\n"
	.align 2
.LC14:
	.string	"fact1"
	.align 2
.LC15:
	.string	"fact3"
	.align 2
.LC16:
	.string	"fact3$secret1"
	.align 2
.LC17:
	.string	"weapons/laser2.wav"
	.align 3
.LC18:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC19:
	.long 0x3f000000
	.align 2
.LC20:
	.long 0x45000000
	.section	".text"
	.align 2
	.globl target_laser_think
	.type	 target_laser_think,@function
target_laser_think:
	stwu 1,-176(1)
	mflr 0
	stmw 27,156(1)
	stw 0,180(1)
	mr 31,3
	lwz 0,284(31)
	lwz 9,540(31)
	cmpwi 7,0,0
	cmpwi 0,9,0
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	nor 9,0,0
	rlwinm 0,0,0,29,29
	rlwinm 9,9,0,28,28
	or 27,0,9
	bc 12,2,.L81
	lfs 13,340(31)
	lis 9,.LC19@ha
	addi 5,1,112
	la 9,.LC19@l(9)
	addi 29,31,340
	lfs 1,0(9)
	stfs 13,128(1)
	lfs 0,344(31)
	stfs 0,132(1)
	lfs 13,348(31)
	stfs 13,136(1)
	lwz 3,540(31)
	addi 4,3,236
	addi 3,3,212
	bl VectorMA
	lfs 13,112(1)
	mr 3,29
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,340(31)
	lfs 0,116(1)
	fsubs 0,0,12
	stfs 0,344(31)
	lfs 13,120(1)
	fsubs 13,13,11
	stfs 13,348(31)
	bl VectorNormalize
	mr 3,29
	addi 4,1,128
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L81
	lwz 0,284(31)
	oris 0,0,0x8000
	stw 0,284(31)
.L81:
	lfs 0,4(31)
	lis 9,.LC20@ha
	addi 29,1,32
	la 9,.LC20@l(9)
	addi 3,1,16
	lfs 1,0(9)
	addi 4,31,340
	mr 5,29
	stfs 0,16(1)
	mr 28,31
	lfs 0,8(31)
	stfs 0,20(1)
	lfs 13,12(31)
	stfs 13,24(1)
	bl VectorMA
	addi 30,1,48
	b .L85
.L86:
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L87
	lwz 0,264(3)
	andi. 9,0,4
	bc 4,2,.L87
	lwz 5,548(31)
	li 0,4
	li 11,30
	lwz 9,516(31)
	lis 8,vec3_origin@ha
	mr 4,31
	stw 0,8(1)
	la 8,vec3_origin@l(8)
	addi 6,31,340
	stw 11,12(1)
	addi 7,1,60
	li 10,1
	bl T_Damage
.L87:
	lwz 9,100(1)
	lwz 0,184(9)
	mr 8,9
	andi. 9,0,4
	bc 4,2,.L88
	lwz 0,84(8)
	cmpwi 0,0,0
	bc 4,2,.L88
	lwz 0,284(31)
	cmpwi 0,0,0
	bc 4,0,.L84
	rlwinm 0,0,0,1,31
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,284(31)
	li 3,3
	lwz 9,100(29)
	addi 28,1,60
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,15
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,124(29)
	addi 3,1,72
	mtlr 9
	blrl
	lwz 9,100(29)
	lwz 3,60(31)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	b .L84
.L88:
	lfs 0,60(1)
	mr 28,8
	lfs 13,64(1)
	lfs 12,68(1)
	stfs 0,16(1)
	stfs 13,20(1)
	stfs 12,24(1)
.L85:
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	mr 3,30
	mr 8,28
	addi 4,1,16
	li 5,0
	li 6,0
	mr 7,29
	mtlr 0
	ori 9,9,1
	blrl
	lwz 3,100(1)
	cmpwi 0,3,0
	bc 4,2,.L86
.L84:
	lfs 13,60(1)
	lis 11,level+4@ha
	lis 9,.LC18@ha
	lfd 12,.LC18@l(9)
	stfs 13,28(31)
	lfs 0,64(1)
	stfs 0,32(31)
	lfs 13,68(1)
	stfs 13,36(31)
	lfs 0,level+4@l(11)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(31)
	lwz 0,180(1)
	mtlr 0
	lmw 27,156(1)
	la 1,176(1)
	blr
.Lfe3:
	.size	 target_laser_think,.Lfe3-target_laser_think
	.section	".rodata"
	.align 2
.LC21:
	.string	"%s at %s: %s is a bad target\n"
	.section	".text"
	.align 2
	.globl target_laser_start
	.type	 target_laser_start,@function
target_laser_start:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	li 10,0
	lwz 9,284(31)
	li 11,1
	lwz 0,68(31)
	andi. 8,9,64
	stw 10,248(31)
	ori 0,0,160
	stw 11,40(31)
	stw 0,68(31)
	stw 10,260(31)
	li 0,4
	bc 12,2,.L101
	li 0,16
.L101:
	stw 0,56(31)
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L103
	lis 0,0xf2f2
	ori 0,0,61680
	b .L123
.L103:
	andi. 8,0,4
	bc 12,2,.L105
	lis 0,0xd0d1
	ori 0,0,53971
	b .L123
.L105:
	andi. 9,0,8
	bc 12,2,.L107
	lis 0,0xf3f3
	ori 0,0,61937
	b .L123
.L107:
	andi. 8,0,16
	bc 12,2,.L109
	lis 0,0xdcdd
	ori 0,0,57055
	b .L123
.L109:
	andi. 9,0,32
	bc 12,2,.L104
	lis 0,0xe0e1
	ori 0,0,58083
.L123:
	stw 0,60(31)
.L104:
	lwz 0,540(31)
	lis 29,gi@ha
	cmpwi 0,0,0
	bc 4,2,.L112
	lwz 5,296(31)
	cmpwi 0,5,0
	bc 12,2,.L113
	li 3,0
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L114
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC21@ha
	lwz 6,296(31)
	la 3,.LC21@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L114:
	stw 30,540(31)
	b .L112
.L113:
	addi 3,31,16
	addi 4,31,340
	bl G_SetMovedir
.L112:
	lwz 0,516(31)
	lis 9,target_laser_use@ha
	lis 11,target_laser_think@ha
	la 9,target_laser_use@l(9)
	la 11,target_laser_think@l(11)
	cmpwi 0,0,0
	stw 9,448(31)
	stw 11,436(31)
	bc 4,2,.L116
	li 0,1
	stw 0,516(31)
.L116:
	lis 0,0xc100
	lis 9,0x4100
	lis 11,gi+72@ha
	stw 0,196(31)
	mr 3,31
	stw 9,208(31)
	stw 0,188(31)
	stw 0,192(31)
	stw 9,200(31)
	stw 9,204(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 11,284(31)
	andi. 0,11,1
	bc 12,2,.L117
	lwz 0,548(31)
	cmpwi 0,0,0
	bc 4,2,.L118
	stw 31,548(31)
.L118:
	lwz 0,284(31)
	mr 3,31
	lwz 9,184(31)
	oris 0,0,0x8000
	ori 0,0,1
	rlwinm 9,9,0,0,30
	stw 0,284(31)
	stw 9,184(31)
	bl target_laser_think
	b .L120
.L117:
	lwz 0,184(31)
	rlwinm 11,11,0,0,30
	li 9,0
	stw 9,428(31)
	ori 0,0,1
	stw 11,284(31)
	stw 0,184(31)
.L120:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 target_laser_start,.Lfe4-target_laser_start
	.section	".rodata"
	.align 3
.LC22:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC23:
	.long 0x42c20000
	.align 3
.LC24:
	.long 0x43300000
	.long 0x0
	.section	".text"
	.align 2
	.globl target_lightramp_think
	.type	 target_lightramp_think,@function
target_lightramp_think:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 29,44(1)
	stw 0,68(1)
	lis 29,level@ha
	mr 31,3
	la 29,level@l(29)
	lfs 12,288(31)
	lis 11,.LC22@ha
	lfs 0,4(29)
	lis 9,.LC23@ha
	lis 10,gi+24@ha
	lfd 31,.LC22@l(11)
	la 9,.LC23@l(9)
	addi 4,1,8
	lfs 10,0(9)
	fsubs 0,0,12
	lfs 13,340(31)
	lfs 12,348(31)
	lwz 11,540(31)
	lwz 0,gi+24@l(10)
	fadds 13,13,10
	mtlr 0
	fdiv 0,0,31
	fmadd 0,0,12,13
	fctiwz 11,0
	stfd 11,32(1)
	lwz 9,36(1)
	slwi 9,9,8
	sth 9,8(1)
	lwz 3,644(11)
	addi 3,3,800
	blrl
	lfs 12,4(29)
	lfs 0,288(31)
	lfs 13,328(31)
	fsubs 0,12,0
	fcmpu 0,0,13
	bc 4,0,.L126
	fmr 0,12
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(31)
	b .L127
.L126:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L127
	lfs 0,340(31)
	lis 0,0x4330
	mr 11,9
	lis 10,.LC24@ha
	lfs 13,348(31)
	la 10,.LC24@l(10)
	lfs 11,344(31)
	lfd 10,0(10)
	fneg 13,13
	stfs 11,340(31)
	fctiwz 12,0
	stfs 13,348(31)
	stfd 12,32(1)
	lwz 9,36(1)
	rlwinm 9,9,0,0xff
	stw 9,36(1)
	stw 0,32(1)
	lfd 0,32(1)
	fsub 0,0,10
	frsp 0,0
	stfs 0,344(31)
.L127:
	lwz 0,68(1)
	mtlr 0
	lmw 29,44(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 target_lightramp_think,.Lfe5-target_lightramp_think
	.section	".rodata"
	.align 2
.LC25:
	.string	"light"
	.align 2
.LC26:
	.string	"%s at %s "
	.align 2
.LC27:
	.string	"target %s (%s at %s) is not a light\n"
	.align 2
.LC28:
	.string	"%s target %s not found at %s\n"
	.align 2
.LC29:
	.string	"target_lightramp has bad ramp (%s) at %s\n"
	.align 2
.LC30:
	.string	"%s with no target at %s\n"
	.align 3
.LC31:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC32:
	.long 0x0
	.align 3
.LC33:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_target_lightramp
	.type	 SP_target_lightramp,@function
SP_target_lightramp:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 3,276(31)
	cmpwi 0,3,0
	bc 12,2,.L141
	bl strlen
	cmpwi 0,3,2
	bc 4,2,.L141
	lwz 7,276(31)
	lbz 9,0(7)
	cmplwi 0,9,96
	bc 4,1,.L141
	cmplwi 0,9,122
	bc 12,1,.L141
	lbz 0,1(7)
	cmplwi 0,0,96
	bc 4,1,.L141
	cmplwi 0,0,122
	bc 12,1,.L141
	cmpw 0,9,0
	bc 4,2,.L140
.L141:
	lis 29,gi@ha
	lwz 28,276(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC29@ha
	la 3,.LC29@l(3)
	b .L144
.L140:
	lis 9,.LC32@ha
	lis 11,deathmatch@ha
	la 9,.LC32@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L145
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L143
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC30@ha
	la 3,.LC30@l(3)
.L144:
	mtlr 0
	crxor 6,6,6
	blrl
.L145:
	mr 3,31
	bl G_FreeEdict
	b .L139
.L143:
	lis 9,target_lightramp_use@ha
	lwz 0,184(31)
	lis 11,target_lightramp_think@ha
	la 9,target_lightramp_use@l(9)
	la 11,target_lightramp_think@l(11)
	lfs 11,328(31)
	stw 9,448(31)
	ori 0,0,1
	lis 8,.LC31@ha
	lis 9,.LC33@ha
	stw 0,184(31)
	la 9,.LC33@l(9)
	stw 11,436(31)
	lis 0,0x4330
	lfd 10,0(9)
	mr 11,10
	lbz 9,0(7)
	lfd 0,.LC31@l(8)
	addi 9,9,-97
	xoris 9,9,0x8000
	stw 9,12(1)
	fdiv 11,11,0
	stw 0,8(1)
	lfd 12,8(1)
	fsub 12,12,10
	frsp 12,12
	stfs 12,340(31)
	lbz 9,1(7)
	addi 9,9,-97
	xoris 9,9,0x8000
	stw 9,12(1)
	stw 0,8(1)
	lfd 13,8(1)
	fsub 13,13,10
	frsp 13,13
	fsubs 12,13,12
	stfs 13,344(31)
	fmr 0,12
	fdiv 0,0,11
	frsp 0,0
	stfs 0,348(31)
.L139:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 SP_target_lightramp,.Lfe6-SP_target_lightramp
	.section	".rodata"
	.align 2
.LC34:
	.long 0x46fffe00
	.align 3
.LC35:
	.long 0x4062c000
	.long 0x0
	.align 3
.LC36:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC37:
	.long 0x3f800000
	.align 2
.LC38:
	.long 0x0
	.align 3
.LC39:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC40:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC41:
	.long 0x40590000
	.long 0x0
	.section	".text"
	.align 2
	.globl target_earthquake_think
	.type	 target_earthquake_think,@function
target_earthquake_think:
	stwu 1,-80(1)
	mflr 0
	stfd 27,40(1)
	stfd 28,48(1)
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 26,16(1)
	stw 0,84(1)
	lis 9,level@ha
	mr 30,3
	la 31,level@l(9)
	lfs 13,476(30)
	lfs 0,4(31)
	fcmpu 0,13,0
	bc 4,0,.L147
	lis 9,gi+20@ha
	addi 3,30,4
	lwz 6,576(30)
	lwz 0,gi+20@l(9)
	mr 4,30
	li 5,0
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 2,0(9)
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 3,0(9)
	blrl
	lfs 0,4(31)
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,476(30)
.L147:
	lis 9,globals@ha
	li 29,1
	la 10,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(10)
	lwz 9,g_edicts@l(11)
	cmpw 0,29,0
	addi 31,9,900
	bc 4,0,.L149
	lis 9,.LC34@ha
	lis 11,.LC35@ha
	lfs 28,.LC34@l(9)
	mr 26,10
	li 27,0
	lis 9,.LC40@ha
	lfd 29,.LC35@l(11)
	lis 28,0x4330
	la 9,.LC40@l(9)
	lfd 31,0(9)
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfd 30,0(9)
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfd 27,0(9)
.L151:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L150
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L150
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L150
	stw 27,552(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,376(31)
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 28,8(1)
	lfd 13,8(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,29,12
	frsp 0,0
	stfs 0,376(31)
	bl rand
	rlwinm 3,3,0,17,31
	lwz 0,400(31)
	xoris 3,3,0x8000
	mr 11,9
	lfs 11,380(31)
	stw 3,12(1)
	xoris 0,0,0x8000
	stw 28,8(1)
	lfd 13,8(1)
	stw 0,12(1)
	stw 28,8(1)
	fsub 13,13,31
	lfd 12,8(1)
	frsp 13,13
	fsub 12,12,31
	fdivs 13,13,28
	fdiv 12,27,12
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,29,11
	frsp 0,0
	stfs 0,380(31)
	lfs 13,328(30)
	fmul 13,13,12
	frsp 13,13
	stfs 13,384(31)
.L150:
	lwz 0,72(26)
	addi 29,29,1
	addi 31,31,900
	cmpw 0,29,0
	bc 12,0,.L151
.L149:
	lis 9,level+4@ha
	lfs 0,288(30)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L156
	fmr 0,13
	lis 9,.LC36@ha
	lfd 13,.LC36@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
.L156:
	lwz 0,84(1)
	mtlr 0
	lmw 26,16(1)
	lfd 27,40(1)
	lfd 28,48(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe7:
	.size	 target_earthquake_think,.Lfe7-target_earthquake_think
	.section	".rodata"
	.align 2
.LC43:
	.string	"untargeted %s at %s\n"
	.align 2
.LC44:
	.string	"world/quake.wav"
	.section	".text"
	.align 2
	.globl Use_Target_Tent
	.type	 Use_Target_Tent,@function
Use_Target_Tent:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 28,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	addi 27,28,4
	mtlr 9
	blrl
	lwz 9,100(29)
	lwz 3,644(28)
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 Use_Target_Tent,.Lfe8-Use_Target_Tent
	.align 2
	.globl SP_target_temp_entity
	.type	 SP_target_temp_entity,@function
SP_target_temp_entity:
	lis 9,Use_Target_Tent@ha
	la 9,Use_Target_Tent@l(9)
	stw 9,448(3)
	blr
.Lfe9:
	.size	 SP_target_temp_entity,.Lfe9-SP_target_temp_entity
	.section	".rodata"
	.align 2
.LC45:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_Target_Speaker
	.type	 Use_Target_Speaker,@function
Use_Target_Speaker:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 5,284(3)
	andi. 0,5,3
	bc 12,2,.L9
	lwz 0,76(3)
	cmpwi 0,0,0
	bc 12,2,.L10
	li 0,0
	stw 0,76(3)
	b .L12
.L10:
	lwz 0,576(3)
	stw 0,76(3)
	b .L12
.L9:
	lis 9,gi+20@ha
	rlwinm 5,5,0,29,29
	lwz 0,gi+20@l(9)
	neg 5,5
	mr 4,3
	srawi 5,5,31
	lis 9,.LC45@ha
	lwz 6,576(4)
	andi. 5,5,18
	la 9,.LC45@l(9)
	lfs 1,584(4)
	mtlr 0
	addi 3,3,4
	lfs 3,0(9)
	ori 5,5,2
	lfs 2,588(4)
	blrl
.L12:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 Use_Target_Speaker,.Lfe10-Use_Target_Speaker
	.align 2
	.globl Use_Target_Help
	.type	 Use_Target_Help,@function
Use_Target_Help:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,284(3)
	andi. 9,0,1
	bc 12,2,.L25
	lwz 4,276(3)
	li 5,511
	lis 3,game@ha
	la 3,game@l(3)
	bl strncpy
	b .L26
.L25:
	lwz 4,276(3)
	li 5,511
	lis 3,game+512@ha
	la 3,game+512@l(3)
	bl strncpy
.L26:
	lis 11,game@ha
	la 11,game@l(11)
	lwz 9,1024(11)
	addi 9,9,1
	stw 9,1024(11)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 Use_Target_Help,.Lfe11-Use_Target_Help
	.section	".rodata"
	.align 2
.LC46:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_help
	.type	 SP_target_help,@function
SP_target_help:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC46@ha
	lis 9,deathmatch@ha
	la 11,.LC46@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L28
	bl G_FreeEdict
	b .L27
.L28:
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 4,2,.L29
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC5@ha
	la 3,.LC5@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L27
.L29:
	lis 9,Use_Target_Help@ha
	la 9,Use_Target_Help@l(9)
	stw 9,448(31)
.L27:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 SP_target_help,.Lfe12-SP_target_help
	.section	".rodata"
	.align 2
.LC47:
	.long 0x3f800000
	.align 2
.LC48:
	.long 0x0
	.section	".text"
	.align 2
	.globl use_target_secret
	.type	 use_target_secret,@function
use_target_secret:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,gi+16@ha
	mr 29,3
	lwz 0,gi+16@l(9)
	mr 28,5
	lis 9,.LC47@ha
	lwz 5,576(29)
	li 4,2
	la 9,.LC47@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfs 2,0(9)
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfs 3,0(9)
	blrl
	lis 11,level@ha
	mr 3,29
	la 11,level@l(11)
	mr 4,28
	lwz 9,272(11)
	addi 9,9,1
	stw 9,272(11)
	bl G_UseTargets
	mr 3,29
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 use_target_secret,.Lfe13-use_target_secret
	.section	".rodata"
	.align 2
.LC49:
	.long 0x0
	.align 2
.LC50:
	.long 0x438c0000
	.align 2
.LC51:
	.long 0xc5000000
	.align 2
.LC52:
	.long 0xc41c0000
	.section	".text"
	.align 2
	.globl SP_target_secret
	.type	 SP_target_secret,@function
SP_target_secret:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC49@ha
	lis 9,deathmatch@ha
	la 11,.LC49@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L32
	bl G_FreeEdict
	b .L31
.L32:
	lis 9,use_target_secret@ha
	lis 11,st@ha
	la 9,use_target_secret@l(9)
	la 11,st@l(11)
	stw 9,448(31)
	lwz 0,36(11)
	cmpwi 0,0,0
	bc 4,2,.L33
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	stw 9,36(11)
.L33:
	lis 9,gi+36@ha
	lwz 3,36(11)
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
	li 0,1
	lis 11,level@ha
	stw 3,576(31)
	la 11,level@l(11)
	stw 0,184(31)
	lis 4,.LC7@ha
	lwz 9,268(11)
	addi 3,11,72
	la 4,.LC7@l(4)
	addi 9,9,1
	stw 9,268(11)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L31
	lis 9,.LC50@ha
	lfs 13,4(31)
	la 9,.LC50@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L31
	lis 11,.LC51@ha
	lfs 13,8(31)
	la 11,.LC51@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L31
	lis 9,.LC52@ha
	lfs 13,12(31)
	la 9,.LC52@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L31
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	stw 9,276(31)
.L31:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 SP_target_secret,.Lfe14-SP_target_secret
	.section	".rodata"
	.align 2
.LC53:
	.long 0x3f800000
	.align 2
.LC54:
	.long 0x0
	.section	".text"
	.align 2
	.globl use_target_goal
	.type	 use_target_goal,@function
use_target_goal:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 29,gi@l(9)
	mr 30,5
	lis 9,.LC53@ha
	lwz 11,16(29)
	la 9,.LC53@l(9)
	li 4,2
	lwz 5,576(31)
	lfs 1,0(9)
	mtlr 11
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	lfs 2,0(9)
	lis 9,.LC54@ha
	la 9,.LC54@l(9)
	lfs 3,0(9)
	blrl
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,280(11)
	lwz 0,276(11)
	addi 9,9,1
	cmpw 0,9,0
	stw 9,280(11)
	bc 4,2,.L36
	lwz 0,24(29)
	lis 4,.LC9@ha
	li 3,1
	la 4,.LC9@l(4)
	mtlr 0
	blrl
.L36:
	mr 3,31
	mr 4,30
	bl G_UseTargets
	mr 3,31
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 use_target_goal,.Lfe15-use_target_goal
	.section	".rodata"
	.align 2
.LC55:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_goal
	.type	 SP_target_goal,@function
SP_target_goal:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC55@ha
	lis 9,deathmatch@ha
	la 11,.LC55@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L38
	bl G_FreeEdict
	b .L37
.L38:
	lis 9,use_target_goal@ha
	lis 11,st@ha
	la 9,use_target_goal@l(9)
	la 11,st@l(11)
	stw 9,448(31)
	lwz 0,36(11)
	cmpwi 0,0,0
	bc 4,2,.L39
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	stw 9,36(11)
.L39:
	lis 9,gi+36@ha
	lwz 3,36(11)
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
	li 0,1
	lis 11,level@ha
	stw 3,576(31)
	stw 0,184(31)
	la 11,level@l(11)
	lwz 9,276(11)
	addi 9,9,1
	stw 9,276(11)
.L37:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe16:
	.size	 SP_target_goal,.Lfe16-SP_target_goal
	.section	".rodata"
	.align 3
.LC56:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl target_explosion_explode
	.type	 target_explosion_explode,@function
target_explosion_explode:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	lis 29,gi@ha
	mr 28,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	addi 27,28,4
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,5
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,1
	mtlr 0
	blrl
	lwz 11,516(28)
	lis 8,0x4330
	mr 9,10
	lis 7,.LC56@ha
	lwz 4,548(28)
	xoris 0,11,0x8000
	la 7,.LC56@l(7)
	stw 0,28(1)
	addi 11,11,40
	li 5,0
	stw 8,24(1)
	xoris 11,11,0x8000
	li 6,25
	lfd 1,24(1)
	mr 3,28
	stw 11,28(1)
	stw 8,24(1)
	lfd 0,0(7)
	lfd 2,24(1)
	fsub 1,1,0
	fsub 2,2,0
	frsp 1,1
	frsp 2,2
	bl T_RadiusDamage
	lfs 31,596(28)
	li 0,0
	mr 3,28
	lwz 4,548(28)
	stw 0,596(28)
	bl G_UseTargets
	stfs 31,596(28)
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe17:
	.size	 target_explosion_explode,.Lfe17-target_explosion_explode
	.section	".rodata"
	.align 2
.LC57:
	.long 0x0
	.align 3
.LC58:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl use_target_explosion
	.type	 use_target_explosion,@function
use_target_explosion:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 28,16(1)
	stw 0,52(1)
	lis 7,.LC57@ha
	mr 31,3
	la 7,.LC57@l(7)
	lfs 13,596(31)
	lfs 30,0(7)
	stw 5,548(31)
	fcmpu 0,13,30
	bc 4,2,.L42
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,31,4
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,5
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,1
	mtlr 0
	blrl
	lwz 11,516(31)
	lis 8,0x4330
	mr 9,10
	lis 7,.LC58@ha
	lwz 4,548(31)
	xoris 0,11,0x8000
	la 7,.LC58@l(7)
	stw 0,12(1)
	addi 11,11,40
	li 5,0
	stw 8,8(1)
	xoris 11,11,0x8000
	li 6,25
	lfd 1,8(1)
	mr 3,31
	stw 11,12(1)
	stw 8,8(1)
	lfd 0,0(7)
	lfd 2,8(1)
	fsub 1,1,0
	fsub 2,2,0
	frsp 1,1
	frsp 2,2
	bl T_RadiusDamage
	lfs 31,596(31)
	mr 3,31
	lwz 4,548(31)
	stfs 30,596(31)
	bl G_UseTargets
	stfs 31,596(31)
	b .L41
.L42:
	lis 9,target_explosion_explode@ha
	lis 11,level+4@ha
	la 9,target_explosion_explode@l(9)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	stfs 0,428(31)
.L41:
	lwz 0,52(1)
	mtlr 0
	lmw 28,16(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 use_target_explosion,.Lfe18-use_target_explosion
	.align 2
	.globl SP_target_explosion
	.type	 SP_target_explosion,@function
SP_target_explosion:
	lis 9,use_target_explosion@ha
	li 0,1
	la 9,use_target_explosion@l(9)
	stw 0,184(3)
	stw 9,448(3)
	blr
.Lfe19:
	.size	 SP_target_explosion,.Lfe19-SP_target_explosion
	.align 2
	.globl SP_target_changelevel
	.type	 SP_target_changelevel,@function
SP_target_changelevel:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,504(31)
	cmpwi 0,0,0
	bc 4,2,.L54
	lis 29,gi@ha
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L53
.L54:
	lis 3,level+72@ha
	lis 4,.LC14@ha
	la 3,level+72@l(3)
	la 4,.LC14@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L55
	lwz 3,504(31)
	lis 4,.LC15@ha
	la 4,.LC15@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L55
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	stw 9,504(31)
.L55:
	lis 9,use_target_changelevel@ha
	li 0,1
	la 9,use_target_changelevel@l(9)
	stw 0,184(31)
	stw 9,448(31)
.L53:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 SP_target_changelevel,.Lfe20-SP_target_changelevel
	.section	".rodata"
	.align 3
.LC59:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl use_target_splash
	.type	 use_target_splash,@function
use_target_splash:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 31,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	mr 30,5
	addi 28,31,4
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,10
	mtlr 9
	blrl
	lwz 9,100(29)
	lwz 3,532(31)
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,124(29)
	addi 3,31,340
	mtlr 9
	blrl
	lwz 9,100(29)
	lwz 3,528(31)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	lwz 11,516(31)
	cmpwi 0,11,0
	bc 12,2,.L57
	xoris 0,11,0x8000
	stw 0,12(1)
	lis 10,0x4330
	mr 3,31
	stw 10,8(1)
	addi 0,11,40
	mr 4,30
	mr 11,9
	lfd 1,8(1)
	xoris 0,0,0x8000
	lis 9,.LC59@ha
	stw 0,12(1)
	li 5,0
	la 9,.LC59@l(9)
	stw 10,8(1)
	li 6,29
	lfd 0,0(9)
	lfd 2,8(1)
	fsub 1,1,0
	fsub 2,2,0
	frsp 1,1
	frsp 2,2
	bl T_RadiusDamage
.L57:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 use_target_splash,.Lfe21-use_target_splash
	.align 2
	.globl SP_target_splash
	.type	 SP_target_splash,@function
SP_target_splash:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,use_target_splash@ha
	mr 31,3
	la 9,use_target_splash@l(9)
	addi 3,31,16
	stw 9,448(31)
	addi 4,31,340
	bl G_SetMovedir
	lwz 0,532(31)
	cmpwi 0,0,0
	bc 4,2,.L59
	li 0,32
	stw 0,532(31)
.L59:
	li 0,1
	stw 0,184(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe22:
	.size	 SP_target_splash,.Lfe22-SP_target_splash
	.section	".rodata"
	.align 2
.LC60:
	.long 0x0
	.section	".text"
	.align 2
	.globl use_target_spawner
	.type	 use_target_spawner,@function
use_target_spawner:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	bl G_Spawn
	lwz 0,296(30)
	mr 31,3
	stw 0,280(31)
	lfs 0,4(30)
	stfs 0,4(31)
	lfs 13,8(30)
	stfs 13,8(31)
	lfs 0,12(30)
	stfs 0,12(31)
	lfs 13,16(30)
	stfs 13,16(31)
	lfs 0,20(30)
	stfs 0,20(31)
	lfs 13,24(30)
	stfs 13,24(31)
	bl ED_CallSpawn
	lis 29,gi@ha
	mr 3,31
	la 29,gi@l(29)
	lwz 9,76(29)
	mtlr 9
	blrl
	mr 3,31
	bl KillBox
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
	lis 9,.LC60@ha
	lfs 13,328(30)
	la 9,.LC60@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L61
	lfs 0,340(30)
	stfs 0,376(31)
	lfs 13,344(30)
	stfs 13,380(31)
	lfs 0,348(30)
	stfs 0,384(31)
.L61:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 use_target_spawner,.Lfe23-use_target_spawner
	.section	".rodata"
	.align 2
.LC61:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_spawner
	.type	 SP_target_spawner,@function
SP_target_spawner:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,.LC61@ha
	mr 31,3
	la 9,.LC61@l(9)
	lfs 0,328(31)
	li 0,1
	lfs 13,0(9)
	lis 9,use_target_spawner@ha
	stw 0,184(31)
	la 9,use_target_spawner@l(9)
	fcmpu 0,0,13
	stw 9,448(31)
	bc 12,2,.L63
	addi 29,31,340
	addi 3,31,16
	mr 4,29
	bl G_SetMovedir
	lfs 1,328(31)
	mr 3,29
	mr 4,3
	bl VectorScale
.L63:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 SP_target_spawner,.Lfe24-SP_target_spawner
	.section	".rodata"
	.align 2
.LC62:
	.long 0x3f800000
	.align 2
.LC63:
	.long 0x0
	.section	".text"
	.align 2
	.globl use_target_blaster
	.type	 use_target_blaster,@function
use_target_blaster:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	lfs 0,328(29)
	addi 4,29,4
	lwz 6,516(29)
	addi 5,29,340
	li 9,33
	li 8,8
	fctiwz 13,0
	stfd 13,24(1)
	lwz 7,28(1)
	bl fire_blaster
	lis 9,gi+16@ha
	mr 3,29
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC62@ha
	lwz 5,576(3)
	la 9,.LC62@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC62@ha
	la 9,.LC62@l(9)
	lfs 2,0(9)
	lis 9,.LC63@ha
	la 9,.LC63@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe25:
	.size	 use_target_blaster,.Lfe25-use_target_blaster
	.section	".rodata"
	.align 2
.LC64:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_blaster
	.type	 SP_target_blaster,@function
SP_target_blaster:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,use_target_blaster@ha
	mr 31,3
	la 9,use_target_blaster@l(9)
	addi 3,31,16
	addi 4,31,340
	stw 9,448(31)
	bl G_SetMovedir
	lis 9,gi+36@ha
	lis 3,.LC17@ha
	lwz 0,gi+36@l(9)
	la 3,.LC17@l(3)
	mtlr 0
	blrl
	lwz 0,516(31)
	stw 3,576(31)
	cmpwi 0,0,0
	bc 4,2,.L70
	li 0,15
	stw 0,516(31)
.L70:
	lis 9,.LC64@ha
	lfs 13,328(31)
	la 9,.LC64@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L71
	lis 0,0x447a
	stw 0,328(31)
.L71:
	li 0,1
	stw 0,184(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe26:
	.size	 SP_target_blaster,.Lfe26-SP_target_blaster
	.align 2
	.globl trigger_crosslevel_trigger_use
	.type	 trigger_crosslevel_trigger_use,@function
trigger_crosslevel_trigger_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,game@ha
	lwz 11,284(3)
	la 9,game@l(9)
	lwz 0,1552(9)
	or 0,0,11
	stw 0,1552(9)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe27:
	.size	 trigger_crosslevel_trigger_use,.Lfe27-trigger_crosslevel_trigger_use
	.align 2
	.globl SP_target_crosslevel_trigger
	.type	 SP_target_crosslevel_trigger,@function
SP_target_crosslevel_trigger:
	lis 9,trigger_crosslevel_trigger_use@ha
	li 0,1
	la 9,trigger_crosslevel_trigger_use@l(9)
	stw 0,184(3)
	stw 9,448(3)
	blr
.Lfe28:
	.size	 SP_target_crosslevel_trigger,.Lfe28-SP_target_crosslevel_trigger
	.align 2
	.globl target_crosslevel_target_think
	.type	 target_crosslevel_target_think,@function
target_crosslevel_target_think:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 11,game+1552@ha
	lwz 10,284(31)
	lwz 0,game+1552@l(11)
	rlwinm 9,10,0,24,31
	and 0,0,9
	cmpw 0,10,0
	bc 4,2,.L75
	mr 4,31
	bl G_UseTargets
	mr 3,31
	bl G_FreeEdict
.L75:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe29:
	.size	 target_crosslevel_target_think,.Lfe29-target_crosslevel_target_think
	.section	".rodata"
	.align 2
.LC65:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_crosslevel_target
	.type	 SP_target_crosslevel_target,@function
SP_target_crosslevel_target:
	lis 9,.LC65@ha
	lfs 0,596(3)
	la 9,.LC65@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L77
	lis 0,0x3f80
	stw 0,596(3)
.L77:
	lis 9,target_crosslevel_target_think@ha
	li 0,1
	lfs 13,596(3)
	la 9,target_crosslevel_target_think@l(9)
	stw 0,184(3)
	lis 11,level+4@ha
	stw 9,436(3)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	stfs 0,428(3)
	blr
.Lfe30:
	.size	 SP_target_crosslevel_target,.Lfe30-SP_target_crosslevel_target
	.align 2
	.globl target_laser_on
	.type	 target_laser_on,@function
target_laser_on:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 11,3
	lwz 0,548(11)
	cmpwi 0,0,0
	bc 4,2,.L92
	stw 11,548(11)
.L92:
	lwz 0,284(11)
	mr 3,11
	lwz 9,184(11)
	oris 0,0,0x8000
	ori 0,0,1
	rlwinm 9,9,0,0,30
	stw 0,284(11)
	stw 9,184(11)
	bl target_laser_think
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 target_laser_on,.Lfe31-target_laser_on
	.align 2
	.globl target_laser_off
	.type	 target_laser_off,@function
target_laser_off:
	lwz 0,284(3)
	li 11,0
	lwz 9,184(3)
	rlwinm 0,0,0,0,30
	stw 11,428(3)
	ori 9,9,1
	stw 0,284(3)
	stw 9,184(3)
	blr
.Lfe32:
	.size	 target_laser_off,.Lfe32-target_laser_off
	.align 2
	.globl target_laser_use
	.type	 target_laser_use,@function
target_laser_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	lwz 11,284(10)
	stw 5,548(10)
	andi. 0,11,1
	bc 12,2,.L95
	lwz 0,184(10)
	rlwinm 11,11,0,0,30
	li 9,0
	stw 9,428(10)
	ori 0,0,1
	stw 11,284(10)
	stw 0,184(10)
	b .L97
.L95:
	cmpwi 0,5,0
	bc 4,2,.L98
	stw 10,548(10)
.L98:
	lwz 0,284(10)
	mr 3,10
	lwz 9,184(10)
	oris 0,0,0x8000
	ori 0,0,1
	rlwinm 9,9,0,0,30
	stw 0,284(10)
	stw 9,184(10)
	bl target_laser_think
.L97:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe33:
	.size	 target_laser_use,.Lfe33-target_laser_use
	.section	".rodata"
	.align 2
.LC66:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SP_target_laser
	.type	 SP_target_laser,@function
SP_target_laser:
	lis 9,target_laser_start@ha
	lis 11,level+4@ha
	la 9,target_laser_start@l(9)
	stw 9,436(3)
	lis 9,.LC66@ha
	lfs 0,level+4@l(11)
	la 9,.LC66@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,428(3)
	blr
.Lfe34:
	.size	 SP_target_laser,.Lfe34-SP_target_laser
	.align 2
	.globl target_lightramp_use
	.type	 target_lightramp_use,@function
target_lightramp_use:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L130
	lis 9,gi@ha
	li 27,0
	la 30,gi@l(9)
	lis 24,.LC25@ha
	lis 25,.LC26@ha
	lis 26,.LC27@ha
	b .L133
.L134:
	lwz 3,280(27)
	la 4,.LC25@l(24)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L135
	lwz 29,280(31)
	addi 3,31,4
	bl vtos
	lwz 9,4(30)
	mr 5,3
	mr 4,29
	la 3,.LC26@l(25)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 29,296(31)
	addi 3,27,4
	lwz 28,280(27)
	bl vtos
	lwz 9,4(30)
	mr 6,3
	mr 4,29
	mr 5,28
	la 3,.LC27@l(26)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L133
.L135:
	stw 27,540(31)
.L133:
	lwz 5,296(31)
	mr 3,27
	li 4,300
	bl G_Find
	mr. 27,3
	bc 4,2,.L134
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L130
	lis 29,gi@ha
	lwz 27,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	lwz 28,296(31)
	bl vtos
	mr 6,3
	lwz 0,4(29)
	mr 4,27
	lis 3,.LC28@ha
	mr 5,28
	la 3,.LC28@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L129
.L130:
	lis 9,level+4@ha
	mr 3,31
	lfs 0,level+4@l(9)
	stfs 0,288(31)
	bl target_lightramp_think
.L129:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe35:
	.size	 target_lightramp_use,.Lfe35-target_lightramp_use
	.section	".rodata"
	.align 3
.LC67:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC68:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl target_earthquake_use
	.type	 target_earthquake_use,@function
target_earthquake_use:
	stwu 1,-16(1)
	lwz 0,532(3)
	lis 8,0x4330
	lis 9,.LC68@ha
	lis 10,.LC67@ha
	xoris 0,0,0x8000
	la 9,.LC68@l(9)
	lfd 11,.LC67@l(10)
	stw 0,12(1)
	li 10,0
	stw 8,8(1)
	lfd 12,0(9)
	lfd 0,8(1)
	lis 9,level@ha
	la 9,level@l(9)
	lfs 13,4(9)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,288(3)
	lfs 0,4(9)
	stw 10,476(3)
	stw 5,548(3)
	fadd 0,0,11
	frsp 0,0
	stfs 0,428(3)
	la 1,16(1)
	blr
.Lfe36:
	.size	 target_earthquake_use,.Lfe36-target_earthquake_use
	.section	".rodata"
	.align 2
.LC69:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_earthquake
	.type	 SP_target_earthquake,@function
SP_target_earthquake:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L159
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC43@ha
	la 3,.LC43@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L159:
	lwz 0,532(31)
	cmpwi 0,0,0
	bc 4,2,.L160
	li 0,5
	stw 0,532(31)
.L160:
	lis 9,.LC69@ha
	lfs 13,328(31)
	la 9,.LC69@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L161
	lis 0,0x4348
	stw 0,328(31)
.L161:
	lwz 0,184(31)
	lis 9,target_earthquake_think@ha
	lis 11,target_earthquake_use@ha
	la 9,target_earthquake_think@l(9)
	la 11,target_earthquake_use@l(11)
	ori 0,0,1
	stw 9,436(31)
	lis 10,gi+36@ha
	stw 0,184(31)
	lis 3,.LC44@ha
	stw 11,448(31)
	la 3,.LC44@l(3)
	lwz 0,gi+36@l(10)
	mtlr 0
	blrl
	stw 3,576(31)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe37:
	.size	 SP_target_earthquake,.Lfe37-SP_target_earthquake
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
