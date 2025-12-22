	.file	"a_cmds.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Lasersight"
	.align 2
.LC1:
	.string	"lasersight"
	.align 2
.LC2:
	.string	"sprites/lsight.sp2"
	.align 3
.LC3:
	.long 0x3f847ae1
	.long 0x47ae147b
	.section	".text"
	.align 2
	.globl SP_LaserSight
	.type	 SP_LaserSight,@function
SP_LaserSight:
	stwu 1,-96(1)
	mflr 0
	stmw 28,80(1)
	stw 0,100(1)
	mr 31,3
	li 29,0
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 11,10,740
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,11,3
	cmpwi 0,0,0
	bc 4,2,.L7
	lwz 3,892(31)
	cmpwi 0,3,0
	bc 12,2,.L6
	bl G_FreeEdict
	stw 29,892(31)
	b .L6
.L7:
	lwz 0,4284(10)
	cmpwi 0,0,2
	bc 12,1,.L13
	nor 0,0,0
	srwi 29,0,31
.L13:
	cmpwi 7,29,0
	lwz 3,892(31)
	addic 0,3,-1
	subfe 9,0,3
	mfcr 0
	rlwinm 0,0,31,1
	and. 30,9,0
	bc 12,2,.L15
	bl G_FreeEdict
	li 0,0
	stw 0,892(31)
	b .L6
.L15:
	bc 12,30,.L6
	addi 29,1,24
	addi 28,1,40
	addi 3,10,4060
	mr 4,29
	mr 5,28
	li 6,0
	bl AngleVectors
	li 9,0
	lis 0,0x42c8
	stw 9,64(1)
	addi 7,1,8
	mr 5,29
	stw 0,56(1)
	mr 6,28
	addi 4,1,56
	stw 9,60(1)
	addi 3,31,4
	bl G_ProjectSource
	bl G_Spawn
	stw 3,892(31)
	li 0,1
	lis 10,.LC1@ha
	stw 31,256(3)
	la 10,.LC1@l(10)
	lis 8,gi+32@ha
	lwz 11,892(31)
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	stw 0,260(11)
	lwz 9,892(31)
	stw 30,248(9)
	lwz 11,892(31)
	stw 10,280(11)
	lwz 0,gi+32@l(8)
	mtlr 0
	blrl
	lwz 11,892(31)
	lis 9,.LC3@ha
	li 0,32
	lfd 13,.LC3@l(9)
	lis 10,LaserSightThink@ha
	lis 8,level+4@ha
	stw 3,40(11)
	la 10,LaserSightThink@l(10)
	lwz 11,892(31)
	stw 0,68(11)
	lwz 9,892(31)
	stw 10,436(9)
	lfs 0,level+4@l(8)
	lwz 9,892(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(9)
.L6:
	lwz 0,100(1)
	mtlr 0
	lmw 28,80(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 SP_LaserSight,.Lfe1-SP_LaserSight
	.section	".rodata"
	.align 3
.LC4:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC5:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC6:
	.long 0x46000000
	.align 2
.LC7:
	.long 0x3f800000
	.align 2
.LC8:
	.long 0xc0800000
	.section	".text"
	.align 2
	.globl LaserSightThink
	.type	 LaserSightThink,@function
LaserSightThink:
	stwu 1,-240(1)
	mflr 0
	stmw 26,216(1)
	stw 0,244(1)
	mr 31,3
	addi 4,1,72
	lwz 11,256(31)
	addi 28,1,88
	mr 30,4
	addi 3,1,120
	mr 5,28
	lwz 9,84(11)
	addi 6,1,104
	lfs 13,3996(9)
	lfs 0,4060(9)
	fadds 0,0,13
	stfs 0,120(1)
	lwz 9,84(11)
	lfs 13,4000(9)
	lfs 0,4064(9)
	fadds 0,0,13
	stfs 0,124(1)
	lwz 9,84(11)
	lfs 13,4004(9)
	lfs 0,4068(9)
	fadds 0,0,13
	stfs 0,128(1)
	bl AngleVectors
	lwz 9,256(31)
	lwz 0,892(9)
	cmpw 0,0,31
	bc 12,2,.L18
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	stw 9,436(31)
.L18:
	lwz 29,256(31)
	lis 9,.LC5@ha
	lis 0,0x41c0
	la 9,.LC5@l(9)
	lis 3,0x4100
	lwz 11,84(29)
	lis 27,0x4330
	lfd 13,0(9)
	mr 7,28
	addi 5,1,56
	lwz 9,1808(11)
	addi 28,1,24
	addi 4,29,4
	stw 0,56(1)
	mr 6,30
	addi 8,1,8
	stw 3,60(1)
	xori 9,9,1
	addic 9,9,-1
	subfe 9,9,9
	mr 26,28
	lwz 0,508(29)
	rlwinm 9,9,0,28,28
	subf 0,9,0
	xoris 0,0,0x8000
	stw 0,212(1)
	stw 27,208(1)
	lfd 0,208(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	lwz 3,84(29)
	bl P_ProjectSource
	lis 9,.LC6@ha
	addi 3,1,8
	la 9,.LC6@l(9)
	mr 4,30
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 9,transparent_list@ha
	lwz 0,transparent_list@l(9)
	cmpwi 0,0,0
	bc 12,2,.L20
	lis 10,teamplay@ha
	lwz 9,teamplay@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,208(1)
	lwz 11,212(1)
	cmpwi 0,11,0
	bc 12,2,.L20
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L20
	li 3,2
	bl TransparentListSet
.L20:
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 8,256(31)
	lwz 0,gi+48@l(11)
	ori 9,9,1
	mr 7,26
	addi 3,1,136
	addi 4,1,8
	mtlr 0
	li 5,0
	li 6,0
	blrl
	lis 9,transparent_list@ha
	lwz 0,transparent_list@l(9)
	cmpwi 0,0,0
	bc 12,2,.L21
	lis 10,teamplay@ha
	lwz 9,teamplay@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,208(1)
	lwz 11,212(1)
	cmpwi 0,11,0
	bc 12,2,.L21
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L21
	li 3,1
	bl TransparentListSet
.L21:
	lis 9,.LC7@ha
	lfs 13,144(1)
	la 9,.LC7@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L22
	lis 9,.LC8@ha
	mr 4,30
	la 9,.LC8@l(9)
	addi 3,1,148
	lfs 1,0(9)
	addi 5,1,40
	bl VectorMA
	lfs 0,40(1)
	lfs 13,44(1)
	lfs 12,48(1)
	stfs 0,148(1)
	stfs 13,152(1)
	stfs 12,156(1)
.L22:
	addi 3,1,160
	addi 4,31,16
	bl vectoangles
	lfs 0,152(1)
	lis 9,gi+72@ha
	mr 3,31
	lfs 13,156(1)
	lfs 12,148(1)
	stfs 0,8(31)
	stfs 13,12(31)
	stfs 12,4(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC4@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC4@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,244(1)
	mtlr 0
	lmw 26,216(1)
	la 1,240(1)
	blr
.Lfe2:
	.size	 LaserSightThink,.Lfe2-LaserSightThink
	.section	".rodata"
	.align 2
.LC9:
	.string	"Out of ammo\n"
	.section	".text"
	.align 2
	.globl Cmd_Reload_f
	.type	 Cmd_Reload_f,@function
Cmd_Reload_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L25
	lwz 11,84(31)
	lwz 9,3992(11)
	cmpwi 0,9,8
	bc 12,2,.L25
	lwz 0,4328(11)
	cmpwi 0,0,1
	bc 12,2,.L25
	lwz 0,4388(11)
	cmpwi 0,0,1
	bc 12,2,.L25
	cmpwi 0,9,1
	bc 12,2,.L25
	cmpwi 0,9,2
	bc 12,2,.L25
	cmpwi 0,9,3
	bc 12,2,.L25
	lwz 0,4296(11)
	cmpwi 0,0,0
	bc 4,2,.L29
	lwz 9,4420(11)
	addi 9,9,-1
	stw 9,4420(11)
.L29:
	lwz 9,84(31)
	lwz 0,4420(9)
	cmpwi 0,0,0
	bc 4,0,.L30
	li 0,0
	stw 0,4420(9)
.L30:
	lwz 11,84(31)
	lwz 10,4284(11)
	cmplwi 0,10,6
	bc 12,1,.L25
	lwz 0,3936(11)
	addi 9,11,740
	slwi 0,0,2
	lwzx 8,9,0
	cmpwi 0,8,0
	bc 12,2,.L33
	cmpwi 0,10,3
	bc 4,2,.L34
	lwz 10,4240(11)
	lwz 9,4236(11)
	cmpw 0,10,9
	bc 4,0,.L25
	lwz 0,3992(11)
	cmpwi 0,0,5
	bc 4,2,.L34
	addi 0,9,-1
	cmpw 0,10,0
	bc 4,0,.L34
	lwz 0,4296(11)
	cmpwi 0,0,0
	bc 4,2,.L34
	addic. 0,8,-1
	bc 4,1,.L34
	lwz 0,92(11)
	cmpwi 0,0,47
	bc 4,1,.L37
	li 0,1
	stw 0,4296(11)
	lwz 11,84(31)
	lwz 0,3936(11)
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	b .L34
.L37:
	lwz 9,4420(11)
	addi 9,9,1
	stw 9,4420(11)
.L34:
	lwz 10,84(31)
	lwz 8,4284(10)
	cmpwi 0,8,4
	bc 4,2,.L39
	lwz 9,4272(10)
	lwz 0,4268(10)
	cmpw 0,9,0
	bc 4,0,.L25
	lwz 0,3936(10)
	addi 11,10,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,1
	bc 4,1,.L25
.L39:
	cmpwi 0,8,5
	bc 4,2,.L42
	lwz 11,4248(10)
	lwz 9,4244(10)
	cmpw 0,11,9
	bc 4,0,.L25
	lwz 0,3992(10)
	cmpwi 0,0,5
	bc 4,2,.L44
	addi 0,9,-1
	cmpw 0,11,0
	bc 4,0,.L44
	lwz 0,4296(10)
	cmpwi 0,0,0
	bc 4,2,.L44
	lwz 0,3936(10)
	addi 11,10,740
	slwi 0,0,2
	lwzx 9,11,0
	addic. 0,9,-1
	bc 4,1,.L44
	lwz 0,92(10)
	cmpwi 0,0,71
	bc 4,1,.L45
	li 0,1
	stw 0,4296(10)
	lwz 11,84(31)
	lwz 0,3936(11)
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	b .L44
.L45:
	lwz 9,4420(10)
	addi 9,9,1
	stw 9,4420(10)
.L44:
	lwz 9,84(31)
	lis 0,0x42b4
	stw 0,112(9)
	lwz 11,84(31)
	lwz 11,1788(11)
	cmpwi 0,11,0
	bc 12,2,.L42
	lis 9,gi+32@ha
	lwz 3,32(11)
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 3,88(9)
.L42:
	lwz 3,84(31)
	lwz 10,4284(3)
	cmpwi 0,10,6
	bc 4,2,.L48
	lwz 0,3936(3)
	addi 11,3,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,1
	bc 4,1,.L25
	lwz 9,4232(3)
	lwz 0,4228(3)
	cmpw 0,9,0
	bc 12,2,.L25
.L48:
	cmpwi 0,10,1
	bc 4,2,.L51
	lwz 9,4256(3)
	lwz 0,4252(3)
	cmpw 0,9,0
	bc 12,2,.L25
.L51:
	cmpwi 0,10,2
	bc 4,2,.L53
	lwz 9,4264(3)
	lwz 0,4260(3)
	cmpw 0,9,0
	bc 12,2,.L25
.L53:
	cmpwi 0,10,0
	bc 4,2,.L55
	lwz 9,4224(3)
	lwz 0,4220(3)
	cmpw 0,9,0
	bc 12,2,.L25
.L55:
	li 0,5
	stw 0,3992(3)
	b .L25
.L33:
	lis 5,.LC9@ha
	mr 3,31
	la 5,.LC9@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L25:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 Cmd_Reload_f,.Lfe3-Cmd_Reload_f
	.section	".rodata"
	.align 2
.LC10:
	.string	"You'll get to your weapon when your done bandaging!\n"
	.align 2
.LC11:
	.string	"misc/click.wav"
	.align 2
.LC12:
	.string	"MK23 Pistol set for semi-automatic action\n"
	.align 2
.LC13:
	.string	"MK23 Pistol set for automatic action\n"
	.align 2
.LC14:
	.string	"MP5 set to 3 Round Burst mode\n"
	.align 2
.LC15:
	.string	"MP5 set to Full Automatic mode\n"
	.align 2
.LC16:
	.string	"M4 set to 3 Round Burst mode\n"
	.align 2
.LC17:
	.string	"M4 set to Full Automatic mode\n"
	.align 2
.LC18:
	.string	"misc/lensflik.wav"
	.align 2
.LC19:
	.string	"Switching to throwing\n"
	.align 2
.LC20:
	.string	"Switching to slashing\n"
	.align 2
.LC21:
	.string	"Prepared to make a medium range throw\n"
	.align 2
.LC22:
	.string	"Prepared to make a long range throw\n"
	.align 2
.LC23:
	.string	"Prepared to make a short range throw\n"
	.align 2
.LC24:
	.long 0x3f800000
	.align 2
.LC25:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Weapon_f
	.type	 Cmd_Weapon_f,@function
Cmd_Weapon_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 30,0
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L62
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 4,2,.L61
.L62:
	li 30,1
.L61:
	lwz 9,84(31)
	lwz 11,4424(9)
	addi 11,11,-1
	stw 11,4424(9)
	lwz 9,84(31)
	lwz 0,4424(9)
	cmpwi 0,0,0
	bc 4,0,.L63
	li 0,0
	stw 0,4424(9)
.L63:
	lwz 11,84(31)
	lwz 0,4328(11)
	cmpwi 0,0,0
	bc 4,2,.L65
	lwz 0,4388(11)
	cmpwi 0,0,0
	bc 12,2,.L64
.L65:
	lis 5,.LC10@ha
	mr 3,31
	la 5,.LC10@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 11,84(31)
	b .L99
.L64:
	lwz 0,3992(11)
	xori 9,0,7
	subfic 10,9,0
	adde 9,10,9
	xori 0,0,3
	subfic 10,0,0
	adde 0,10,0
	or. 10,0,9
	bc 12,2,.L66
.L99:
	lwz 9,4424(11)
	addi 9,9,1
	stw 9,4424(11)
	b .L60
.L66:
	lwz 0,4284(11)
	cmpwi 0,0,0
	bc 4,2,.L67
	cmpwi 0,30,0
	bc 4,2,.L68
	lis 29,gi@ha
	lis 3,.LC11@ha
	la 29,gi@l(29)
	la 3,.LC11@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC24@ha
	lis 10,.LC24@ha
	lis 11,.LC25@ha
	mr 5,3
	la 9,.LC24@l(9)
	la 10,.LC24@l(10)
	mtlr 0
	la 11,.LC25@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L68:
	lwz 11,84(31)
	lwz 0,3844(11)
	subfic 9,0,0
	adde 0,9,0
	stw 0,3844(11)
	lwz 9,84(31)
	lwz 0,3844(9)
	cmpwi 0,0,0
	bc 12,2,.L69
	lis 5,.LC12@ha
	mr 3,31
	la 5,.LC12@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L67
.L69:
	lis 5,.LC13@ha
	mr 3,31
	la 5,.LC13@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L67:
	lwz 9,84(31)
	lwz 0,4284(9)
	cmpwi 0,0,1
	bc 4,2,.L71
	cmpwi 0,30,0
	bc 4,2,.L72
	lis 29,gi@ha
	lis 3,.LC11@ha
	la 29,gi@l(29)
	la 3,.LC11@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC24@ha
	lis 10,.LC24@ha
	lis 11,.LC25@ha
	mr 5,3
	la 9,.LC24@l(9)
	la 10,.LC24@l(10)
	mtlr 0
	la 11,.LC25@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L72:
	lwz 11,84(31)
	lwz 0,3848(11)
	subfic 9,0,0
	adde 0,9,0
	stw 0,3848(11)
	lwz 9,84(31)
	lwz 0,3848(9)
	cmpwi 0,0,0
	bc 12,2,.L73
	lis 5,.LC14@ha
	mr 3,31
	la 5,.LC14@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L71
.L73:
	lis 5,.LC15@ha
	mr 3,31
	la 5,.LC15@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L71:
	lwz 9,84(31)
	lwz 0,4284(9)
	cmpwi 0,0,2
	bc 4,2,.L75
	cmpwi 0,30,0
	bc 4,2,.L76
	lis 29,gi@ha
	lis 3,.LC11@ha
	la 29,gi@l(29)
	la 3,.LC11@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC24@ha
	lis 10,.LC24@ha
	lis 11,.LC25@ha
	mr 5,3
	la 9,.LC24@l(9)
	la 10,.LC24@l(10)
	mtlr 0
	la 11,.LC25@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L76:
	lwz 11,84(31)
	lwz 0,3852(11)
	subfic 9,0,0
	adde 0,9,0
	stw 0,3852(11)
	lwz 9,84(31)
	lwz 0,3852(9)
	cmpwi 0,0,0
	bc 12,2,.L77
	lis 5,.LC16@ha
	mr 3,31
	la 5,.LC16@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L75
.L77:
	lis 5,.LC17@ha
	mr 3,31
	la 5,.LC17@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L75:
	lwz 9,84(31)
	lwz 0,4284(9)
	cmpwi 0,0,5
	bc 4,2,.L79
	cmpwi 0,30,0
	bc 4,2,.L60
	lwz 0,3464(9)
	cmpwi 0,0,0
	bc 4,2,.L81
	lis 29,gi@ha
	lis 3,.LC18@ha
	la 29,gi@l(29)
	la 3,.LC18@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC24@ha
	lis 10,.LC24@ha
	lis 11,.LC25@ha
	la 9,.LC24@l(9)
	la 10,.LC24@l(10)
	la 11,.LC25@l(11)
	lfs 1,0(9)
	mtlr 0
	mr 5,3
	lfs 2,0(10)
	li 4,3
	lfs 3,0(11)
	mr 3,31
	blrl
	lwz 11,84(31)
	li 0,1
	li 10,45
	stw 0,3464(11)
	lwz 9,84(31)
	stw 10,4304(9)
	lwz 9,84(31)
	lwz 0,3992(9)
	cmpwi 0,0,5
	bc 12,2,.L79
	li 0,6
	li 10,22
	stw 0,4300(9)
	li 8,7
	lwz 9,84(31)
	stw 10,92(9)
	lwz 11,84(31)
	stw 8,3992(11)
	b .L79
.L81:
	cmpwi 0,0,1
	bc 4,2,.L84
	lis 29,gi@ha
	lis 3,.LC18@ha
	la 29,gi@l(29)
	la 3,.LC18@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC24@ha
	lis 10,.LC24@ha
	lis 11,.LC25@ha
	la 9,.LC24@l(9)
	la 10,.LC24@l(10)
	la 11,.LC25@l(11)
	lfs 1,0(9)
	mtlr 0
	mr 5,3
	lfs 2,0(10)
	li 4,3
	lfs 3,0(11)
	mr 3,31
	blrl
	lwz 11,84(31)
	li 0,2
	li 10,20
	b .L100
.L84:
	cmpwi 0,0,2
	bc 4,2,.L86
	lis 29,gi@ha
	lis 3,.LC18@ha
	la 29,gi@l(29)
	la 3,.LC18@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC24@ha
	lis 10,.LC24@ha
	lis 11,.LC25@ha
	la 9,.LC24@l(9)
	la 10,.LC24@l(10)
	la 11,.LC25@l(11)
	lfs 1,0(9)
	mtlr 0
	mr 5,3
	lfs 2,0(10)
	li 4,3
	lfs 3,0(11)
	mr 3,31
	blrl
	lwz 11,84(31)
	li 0,3
	li 10,10
.L100:
	stw 0,3464(11)
	lwz 9,84(31)
	stw 10,4304(9)
	b .L79
.L86:
	lis 9,gi@ha
	lis 3,.LC18@ha
	la 29,gi@l(9)
	la 3,.LC18@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC24@ha
	lwz 11,16(29)
	lis 10,.LC24@ha
	la 9,.LC24@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC24@l(10)
	mtlr 11
	li 4,3
	lis 9,.LC25@ha
	mr 3,31
	lfs 2,0(10)
	la 9,.LC25@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,84(31)
	li 0,90
	stw 30,3464(11)
	lwz 9,84(31)
	stw 0,4304(9)
	lwz 11,84(31)
	lwz 9,1788(11)
	cmpwi 0,9,0
	bc 12,2,.L79
	lwz 0,32(29)
	lwz 3,32(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 3,88(9)
.L79:
	lwz 9,84(31)
	lwz 0,4284(9)
	cmpwi 0,0,7
	bc 4,2,.L89
	cmpwi 0,30,0
	bc 4,2,.L60
	lwz 29,3992(9)
	cmpwi 0,29,0
	bc 4,2,.L89
	lwz 0,3856(9)
	li 10,1
	subfic 11,0,0
	adde 0,11,0
	stw 0,3856(9)
	lwz 9,84(31)
	stw 10,3992(9)
	lwz 11,84(31)
	lwz 0,3856(11)
	cmpwi 0,0,0
	bc 12,2,.L92
	lis 5,.LC19@ha
	mr 3,31
	la 5,.LC19@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	stw 29,92(9)
	b .L89
.L92:
	lis 5,.LC20@ha
	mr 3,31
	la 5,.LC20@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,106
	stw 0,92(9)
.L89:
	lwz 9,84(31)
	lwz 0,4284(9)
	cmpwi 0,0,8
	bc 4,2,.L60
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 4,2,.L95
	lis 5,.LC21@ha
	mr 3,31
	la 5,.LC21@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,1
	b .L101
.L95:
	cmpwi 0,0,1
	bc 4,2,.L97
	lis 5,.LC22@ha
	mr 3,31
	la 5,.LC22@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,2
	b .L101
.L97:
	lis 5,.LC23@ha
	mr 3,31
	la 5,.LC23@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,0
.L101:
	stw 0,3860(9)
.L60:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 Cmd_Weapon_f,.Lfe4-Cmd_Weapon_f
	.section	".rodata"
	.align 2
.LC26:
	.string	"M26 Fragmentation Grenade"
	.align 2
.LC27:
	.string	"MK23 Pistol"
	.align 2
.LC28:
	.string	"Already bandaging\n"
	.align 2
.LC29:
	.string	"No need to bandage\n"
	.align 2
.LC30:
	.string	"Can't bandage now\n"
	.align 2
.LC31:
	.long 0x0
	.align 2
.LC32:
	.long 0x40000000
	.align 2
.LC33:
	.long 0x43aa0000
	.section	".text"
	.align 2
	.globl Cmd_Bandage_f
	.type	 Cmd_Bandage_f,@function
Cmd_Bandage_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4348(9)
	cmpwi 0,0,0
	bc 4,2,.L105
	lwz 0,4332(9)
	cmpwi 0,0,0
	bc 12,2,.L104
.L105:
	lwz 0,4328(9)
	cmpwi 0,0,1
	bc 12,2,.L104
	li 0,0
	stw 0,4420(9)
.L104:
	lwz 9,84(31)
	lwz 0,3992(9)
	mr 10,9
	xori 11,0,4
	subfic 9,11,0
	adde 11,9,11
	subfic 9,0,0
	adde 0,9,0
	or. 9,0,11
	bc 12,2,.L106
	lwz 0,4348(10)
	cmpwi 0,0,0
	bc 4,2,.L107
	lwz 0,4332(10)
	cmpwi 0,0,0
	bc 12,2,.L106
.L107:
	lwz 0,4328(10)
	cmpwi 0,0,1
	bc 12,2,.L116
	lwz 0,4284(10)
	cmpwi 0,0,8
	bc 4,2,.L108
	lwz 9,92(10)
	addi 0,9,-4
	addi 9,9,-40
	subfic 0,0,5
	li 0,0
	adde 0,0,0
	subfic 9,9,29
	li 9,0
	adde 9,9,9
	or. 11,9,0
	bc 12,2,.L108
	lis 9,.LC31@ha
	lis 11,.LC31@ha
	la 9,.LC31@l(9)
	la 11,.LC31@l(11)
	lfs 3,0(9)
	li 0,0
	lis 9,.LC31@ha
	lfs 1,0(11)
	la 9,.LC31@l(9)
	stw 0,92(10)
	lfs 2,0(9)
	bl tv
	lis 9,.LC32@ha
	lis 11,.LC33@ha
	la 9,.LC32@l(9)
	la 11,.LC33@l(11)
	lfs 1,0(9)
	mr 5,3
	addi 4,31,4
	lfs 2,0(11)
	mr 3,31
	li 6,170
	li 7,0
	li 8,0
	bl fire_grenade2
	lis 3,.LC26@ha
	la 3,.LC26@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 10,10,740
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	lwzx 9,10,3
	addi 9,9,-1
	stwx 9,10,3
	lwz 11,84(31)
	addi 11,11,740
	lwzx 0,11,3
	cmpwi 0,0,0
	bc 12,1,.L108
	lis 3,.LC27@ha
	la 3,.LC27@l(3)
	bl FindItem
	lwz 9,84(31)
	stw 3,3956(9)
.L108:
	lwz 11,84(31)
	li 0,1
	li 10,0
	lis 8,0x42b4
	li 7,90
	stw 0,4328(11)
	lwz 9,84(31)
	stw 10,3464(9)
	lwz 11,84(31)
	stw 8,112(11)
	lwz 9,84(31)
	stw 7,4304(9)
	lwz 11,84(31)
	lwz 11,1788(11)
	cmpwi 0,11,0
	bc 12,2,.L111
	lis 9,gi+32@ha
	lwz 3,32(11)
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 3,88(9)
	b .L111
.L106:
	lwz 0,4328(10)
	cmpwi 0,0,1
	bc 4,2,.L112
.L116:
	lis 5,.LC28@ha
	mr 3,31
	la 5,.LC28@l(5)
	b .L117
.L112:
	lwz 0,4348(10)
	cmpwi 0,0,0
	bc 4,2,.L114
	lwz 0,4332(10)
	cmpwi 0,0,0
	bc 4,2,.L114
	lis 5,.LC29@ha
	mr 3,31
	la 5,.LC29@l(5)
.L117:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L111
.L114:
	lis 5,.LC30@ha
	mr 3,31
	la 5,.LC30@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L111:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_Bandage_f,.Lfe5-Cmd_Bandage_f
	.section	".rodata"
	.align 2
.LC34:
	.string	"Disabling player identification display.\n"
	.align 2
.LC35:
	.string	"Activating player identification display.\n"
	.align 3
.LC36:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC37:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl loc_CanSee
	.type	 loc_CanSee,@function
loc_CanSee:
	stwu 1,-256(1)
	mflr 0
	stfd 31,248(1)
	stmw 23,212(1)
	stw 0,260(1)
	lwz 0,260(3)
	mr 30,4
	cmpwi 0,0,2
	bc 4,2,.L124
	b .L136
.L135:
	li 3,1
	b .L134
.L124:
	mr 10,3
	lfs 12,188(3)
	addi 11,3,188
	lfsu 9,4(10)
	addi 8,3,200
	lis 9,.LC36@ha
	lfs 7,200(3)
	la 9,.LC36@l(9)
	lfd 6,0(9)
	lis 6,0x4330
	li 29,0
	fadds 8,9,12
	lis 9,gi@ha
	lis 26,transparent_list@ha
	fadds 9,9,7
	la 23,gi@l(9)
	addi 25,1,168
	lis 9,.LC37@ha
	lis 24,vec3_origin@ha
	stfs 8,72(1)
	fsubs 12,8,12
	la 9,.LC37@l(9)
	lis 27,teamplay@ha
	lfs 0,4(11)
	fsubs 5,9,7
	lis 28,lights_camera_action@ha
	addi 31,1,72
	lfs 11,4(10)
	fsubs 7,8,7
	lfd 31,0(9)
	fadds 11,11,0
	stfs 11,76(1)
	lfs 0,8(11)
	lfs 10,8(10)
	stfs 11,100(1)
	stfs 11,88(1)
	fadds 10,10,0
	stfs 12,84(1)
	stfs 8,96(1)
	stfs 10,80(1)
	stfs 10,92(1)
	stfs 10,104(1)
	lfs 13,4(11)
	stfs 11,112(1)
	stfs 10,116(1)
	fsubs 13,11,13
	stfs 12,108(1)
	stfs 13,100(1)
	lfs 0,4(11)
	stfs 9,120(1)
	fsubs 0,11,0
	stfs 0,112(1)
	lfs 0,4(8)
	lfs 13,4(10)
	fadds 13,13,0
	stfs 13,124(1)
	lfs 12,8(8)
	lfs 0,8(10)
	stfs 13,136(1)
	stfs 5,132(1)
	fadds 0,0,12
	stfs 0,140(1)
	stfs 0,128(1)
	stfs 8,144(1)
	lwz 0,508(30)
	stfs 11,148(1)
	xoris 0,0,0x8000
	stfs 10,152(1)
	stw 0,204(1)
	lfs 13,4(8)
	stw 6,200(1)
	lfd 0,200(1)
	fsubs 13,11,13
	stfs 11,160(1)
	stfs 10,164(1)
	stfs 7,156(1)
	fsub 0,0,6
	lfs 12,12(30)
	stfs 13,148(1)
	lfs 13,4(8)
	frsp 0,0
	lfs 9,4(30)
	lfs 10,8(30)
	fsubs 11,11,13
	fadds 12,12,0
	stfs 9,168(1)
	stfs 10,172(1)
	stfs 11,160(1)
	stfs 12,176(1)
.L129:
	lwz 0,transparent_list@l(26)
	cmpwi 0,0,0
	bc 12,2,.L130
	lwz 11,teamplay@l(27)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,200(1)
	lwz 9,204(1)
	cmpwi 0,9,0
	bc 12,2,.L130
	lwz 0,lights_camera_action@l(28)
	cmpwi 0,0,0
	bc 4,2,.L130
	li 3,2
	bl TransparentListSet
.L130:
	lwz 11,48(23)
	la 5,vec3_origin@l(24)
	addi 3,1,8
	mr 4,25
	mr 6,5
	mr 7,31
	mr 8,30
	mtlr 11
	li 9,3
	blrl
	lwz 0,transparent_list@l(26)
	cmpwi 0,0,0
	bc 12,2,.L131
	lwz 11,teamplay@l(27)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,200(1)
	lwz 9,204(1)
	cmpwi 0,9,0
	bc 12,2,.L131
	lwz 0,lights_camera_action@l(28)
	cmpwi 0,0,0
	bc 4,2,.L131
	li 3,1
	bl TransparentListSet
.L131:
	lfs 0,16(1)
	fcmpu 0,0,31
	bc 12,2,.L135
	addi 29,29,1
	addi 31,31,12
	cmpwi 0,29,7
	bc 4,1,.L129
.L136:
	li 3,0
.L134:
	lwz 0,260(1)
	mtlr 0
	lmw 23,212(1)
	lfd 31,248(1)
	la 1,256(1)
	blr
.Lfe6:
	.size	 loc_CanSee,.Lfe6-loc_CanSee
	.section	".rodata"
	.align 2
.LC38:
	.long 0x3f666666
	.align 3
.LC39:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 2
.LC40:
	.long 0x0
	.align 2
.LC41:
	.long 0x46000000
	.align 2
.LC42:
	.long 0x3f800000
	.align 3
.LC43:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SetIDView
	.type	 SetIDView,@function
SetIDView:
	stwu 1,-176(1)
	mflr 0
	stfd 29,152(1)
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 24,120(1)
	stw 0,180(1)
	mr 30,3
	li 10,0
	lwz 11,84(30)
	lis 9,.LC38@ha
	lfs 29,.LC38@l(9)
	sth 10,162(11)
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 12,2,.L138
	lis 9,.LC40@ha
	lis 11,teamplay@ha
	la 9,.LC40@l(9)
	lfs 13,0(9)
	lwz 9,teamplay@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L138
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,112(1)
	lwz 11,116(1)
	andi. 0,11,192
	bc 12,2,.L137
.L138:
	lwz 3,84(30)
	lwz 0,4444(3)
	cmpwi 0,0,0
	bc 12,2,.L140
	lwz 10,4436(3)
	cmpwi 0,10,0
	bc 12,2,.L137
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L137
	lis 11,g_edicts@ha
	lis 0,0xe64
	lwz 9,g_edicts@l(11)
	ori 0,0,49481
	subf 9,9,10
	mullw 9,9,0
	srawi 9,9,2
	addi 9,9,1311
	sth 9,162(3)
	b .L137
.L140:
	lwz 0,3864(3)
	cmpwi 0,0,1
	bc 12,2,.L137
	addi 4,1,8
	addi 3,3,4060
	li 5,0
	li 6,0
	bl AngleVectors
	lis 9,.LC41@ha
	addi 3,1,8
	la 9,.LC41@l(9)
	mr 4,3
	lfs 1,0(9)
	bl VectorScale
	lfs 0,4(30)
	lis 9,transparent_list@ha
	lfs 13,8(30)
	lfs 12,12(30)
	lfs 11,8(1)
	lfs 10,12(1)
	lfs 9,16(1)
	lwz 0,transparent_list@l(9)
	fadds 0,0,11
	fadds 13,13,10
	fadds 12,12,9
	cmpwi 0,0,0
	stfs 0,8(1)
	stfs 13,12(1)
	stfs 12,16(1)
	bc 12,2,.L143
	lis 10,teamplay@ha
	lwz 9,teamplay@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,112(1)
	lwz 11,116(1)
	cmpwi 0,11,0
	bc 12,2,.L143
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L143
	li 3,2
	bl TransparentListSet
.L143:
	lis 9,gi+48@ha
	addi 3,1,40
	lwz 0,gi+48@l(9)
	addi 4,30,4
	li 5,0
	li 9,3
	li 6,0
	mtlr 0
	addi 7,1,8
	mr 8,30
	blrl
	lis 9,transparent_list@ha
	lwz 0,transparent_list@l(9)
	cmpwi 0,0,0
	bc 12,2,.L144
	lis 10,teamplay@ha
	lwz 9,teamplay@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,112(1)
	lwz 11,116(1)
	cmpwi 0,11,0
	bc 12,2,.L144
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L144
	li 3,1
	bl TransparentListSet
.L144:
	lis 9,.LC42@ha
	lfs 13,48(1)
	la 9,.LC42@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L145
	lwz 9,92(1)
	cmpwi 0,9,0
	bc 12,2,.L145
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L145
	lis 11,g_edicts@ha
	lis 0,0xe64
	lwz 10,84(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,49481
	subf 9,9,30
	b .L156
.L145:
	lwz 3,84(30)
	addi 4,1,8
	li 5,0
	li 6,0
	li 27,0
	addi 3,3,4060
	li 28,1
	bl AngleVectors
	lis 24,maxclients@ha
	lis 9,.LC42@ha
	lis 11,maxclients@ha
	la 9,.LC42@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L147
	lis 9,.LC43@ha
	lis 25,g_edicts@ha
	la 9,.LC43@l(9)
	lis 26,0x4330
	lfd 30,0(9)
	li 29,996
.L149:
	lwz 0,g_edicts@l(25)
	add 31,0,29
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L148
	lfs 0,4(30)
	addi 3,1,24
	lfs 13,4(31)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 0,8(31)
	fsubs 0,0,12
	stfs 0,28(1)
	lfs 13,12(31)
	fsubs 13,13,11
	stfs 13,32(1)
	bl VectorNormalize
	lfs 0,28(1)
	lfs 12,12(1)
	lfs 13,8(1)
	lfs 11,24(1)
	fmuls 12,12,0
	lfs 10,16(1)
	lfs 0,32(1)
	fmadds 13,13,11,12
	fmadds 31,10,0,13
	fcmpu 0,31,29
	bc 4,1,.L148
	mr 3,30
	mr 4,31
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L148
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L152
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 4,2,.L148
.L152:
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 12,2,.L153
	mr 3,30
	mr 4,31
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L148
.L153:
	fmr 29,31
	mr 27,31
.L148:
	addi 28,28,1
	lwz 11,maxclients@l(24)
	xoris 0,28,0x8000
	addi 29,29,996
	stw 0,116(1)
	stw 26,112(1)
	lfd 0,112(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L149
.L147:
	cmpwi 0,27,0
	bc 12,2,.L137
	lis 9,.LC39@ha
	fmr 13,29
	lfd 0,.LC39@l(9)
	fcmpu 0,13,0
	bc 4,1,.L137
	lis 11,g_edicts@ha
	lis 0,0xe64
	lwz 10,84(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,49481
	subf 9,9,27
.L156:
	mullw 9,9,0
	srawi 9,9,2
	addi 9,9,1311
	sth 9,162(10)
.L137:
	lwz 0,180(1)
	mtlr 0
	lmw 24,120(1)
	lfd 29,152(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe7:
	.size	 SetIDView,.Lfe7-SetIDView
	.section	".rodata"
	.align 2
.LC44:
	.string	"Bandolier"
	.align 2
.LC45:
	.string	"IR vision disabled.\n"
	.align 2
.LC46:
	.string	"IR vision will be disabled when you get a bandolier.\n"
	.align 2
.LC47:
	.string	"IR vision enabled.\n"
	.align 2
.LC48:
	.string	"IR vision will be enabled when you get a bandolier.\n"
	.align 2
.LC49:
	.string	"IR vision not enabled on this server.\n"
	.align 2
.LC50:
	.string	"A 2nd pistol"
	.align 2
.LC51:
	.string	"railgun"
	.align 2
.LC52:
	.string	"Dual MK23 Pistols"
	.align 2
.LC53:
	.string	"shotgun"
	.align 2
.LC54:
	.string	"M3 Super 90 Assault Shotgun"
	.align 2
.LC55:
	.string	"machinegun"
	.align 2
.LC56:
	.string	"Handcannon"
	.align 2
.LC57:
	.string	"super shotgun"
	.align 2
.LC58:
	.string	"MP5/10 Submachinegun"
	.align 2
.LC59:
	.string	"chaingun"
	.align 2
.LC60:
	.string	"Sniper Rifle"
	.align 2
.LC61:
	.string	"bfg10k"
	.align 2
.LC62:
	.string	"Combat Knife"
	.align 2
.LC63:
	.string	"grenade launcher"
	.align 2
.LC64:
	.string	"M4 Assault Rifle"
	.align 2
.LC65:
	.string	"Kevlar Vest"
	.align 2
.LC66:
	.string	"Stealth Slippers"
	.align 2
.LC67:
	.string	"Silencer"
	.align 2
.LC68:
	.string	"Invalid weapon or item choice.\n"
	.align 2
.LC69:
	.string	"Weapon selected: %s\nItem selected: %s\n"
	.align 2
.LC70:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Choose_f
	.type	 Cmd_Choose_f,@function
Cmd_Choose_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+164@ha
	mr 30,3
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	lis 11,.LC70@ha
	lis 9,teamplay@ha
	la 11,.LC70@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L167
	lis 4,.LC50@ha
	la 4,.LC50@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L170
	lis 4,.LC51@ha
	mr 3,31
	la 4,.LC51@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L169
.L170:
	lis 9,.LC52@ha
	la 31,.LC52@l(9)
.L169:
	lis 4,.LC53@ha
	mr 3,31
	la 4,.LC53@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L171
	lis 9,.LC54@ha
	la 31,.LC54@l(9)
.L171:
	lis 4,.LC55@ha
	mr 3,31
	la 4,.LC55@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L172
	lis 9,.LC56@ha
	la 31,.LC56@l(9)
.L172:
	lis 4,.LC57@ha
	mr 3,31
	la 4,.LC57@l(4)
	lis 29,.LC58@ha
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L173
	la 31,.LC58@l(29)
.L173:
	lis 4,.LC59@ha
	mr 3,31
	la 4,.LC59@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L174
	lis 9,.LC60@ha
	la 31,.LC60@l(9)
.L174:
	lis 4,.LC61@ha
	mr 3,31
	la 4,.LC61@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L175
	lis 9,.LC62@ha
	la 31,.LC62@l(9)
.L175:
	lis 4,.LC63@ha
	mr 3,31
	la 4,.LC63@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L176
	lis 9,.LC64@ha
	la 31,.LC64@l(9)
.L176:
	lis 4,.LC58@ha
	mr 3,31
	la 4,.LC58@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L177
	la 3,.LC58@l(29)
	b .L201
.L177:
	lis 29,.LC54@ha
	mr 3,31
	la 4,.LC54@l(29)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L179
	la 3,.LC54@l(29)
	b .L201
.L179:
	lis 29,.LC64@ha
	mr 3,31
	la 4,.LC64@l(29)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L181
	la 3,.LC64@l(29)
	b .L201
.L181:
	lis 29,.LC56@ha
	mr 3,31
	la 4,.LC56@l(29)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L183
	la 3,.LC56@l(29)
	b .L201
.L183:
	lis 29,.LC60@ha
	mr 3,31
	la 4,.LC60@l(29)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L185
	la 3,.LC60@l(29)
	b .L201
.L185:
	lis 29,.LC62@ha
	mr 3,31
	la 4,.LC62@l(29)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L187
	la 3,.LC62@l(29)
	b .L201
.L187:
	lis 29,.LC52@ha
	mr 3,31
	la 4,.LC52@l(29)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L189
	la 3,.LC52@l(29)
.L201:
	bl FindItem
	lwz 9,84(30)
	stw 3,3484(9)
	b .L178
.L189:
	lis 29,.LC65@ha
	mr 3,31
	la 4,.LC65@l(29)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L191
	la 3,.LC65@l(29)
	b .L202
.L191:
	lis 29,.LC0@ha
	mr 3,31
	la 4,.LC0@l(29)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L193
	la 3,.LC0@l(29)
	b .L202
.L193:
	lis 29,.LC66@ha
	mr 3,31
	la 4,.LC66@l(29)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L195
	la 3,.LC66@l(29)
	b .L202
.L195:
	lis 29,.LC67@ha
	mr 3,31
	la 4,.LC67@l(29)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L197
	la 3,.LC67@l(29)
	b .L202
.L197:
	lis 29,.LC44@ha
	mr 3,31
	la 4,.LC44@l(29)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L199
	lis 5,.LC68@ha
	mr 3,30
	la 5,.LC68@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L167
.L199:
	la 3,.LC44@l(29)
.L202:
	bl FindItem
	lwz 9,84(30)
	stw 3,3480(9)
.L178:
	lwz 10,84(30)
	lis 5,.LC69@ha
	mr 3,30
	la 5,.LC69@l(5)
	li 4,2
	lwz 9,3480(10)
	lwz 11,3484(10)
	lwz 7,40(9)
	lwz 6,40(11)
	crxor 6,6,6
	bl safe_cprintf
.L167:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 Cmd_Choose_f,.Lfe8-Cmd_Choose_f
	.align 2
	.globl Cmd_New_Reload_f
	.type	 Cmd_New_Reload_f,@function
Cmd_New_Reload_f:
	stwu 1,-16(1)
	lis 10,teamplay@ha
	lwz 11,teamplay@l(10)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	cmpwi 0,9,0
	bc 12,2,.L24
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L23
.L24:
	lwz 11,84(3)
	lwz 9,4420(11)
	addi 9,9,1
	stw 9,4420(11)
.L23:
	la 1,16(1)
	blr
.Lfe9:
	.size	 Cmd_New_Reload_f,.Lfe9-Cmd_New_Reload_f
	.align 2
	.globl Cmd_New_Weapon_f
	.type	 Cmd_New_Weapon_f,@function
Cmd_New_Weapon_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 10,84(3)
	lwz 9,4424(10)
	addi 9,9,1
	stw 9,4424(10)
	lwz 11,84(3)
	lwz 0,4424(11)
	cmpwi 0,0,1
	bc 4,2,.L59
	bl Cmd_Weapon_f
.L59:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 Cmd_New_Weapon_f,.Lfe10-Cmd_New_Weapon_f
	.align 2
	.globl Cmd_OpenDoor_f
	.type	 Cmd_OpenDoor_f,@function
Cmd_OpenDoor_f:
	lwz 9,84(3)
	li 0,1
	stw 0,4396(9)
	blr
.Lfe11:
	.size	 Cmd_OpenDoor_f,.Lfe11-Cmd_OpenDoor_f
	.align 2
	.globl Cmd_ID_f
	.type	 Cmd_ID_f,@function
Cmd_ID_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3864(9)
	cmpwi 0,0,0
	bc 4,2,.L120
	lis 5,.LC34@ha
	la 5,.LC34@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,1
	b .L203
.L120:
	lis 5,.LC35@ha
	mr 3,31
	la 5,.LC35@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,0
.L203:
	stw 0,3864(9)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 Cmd_ID_f,.Lfe12-Cmd_ID_f
	.section	".rodata"
	.align 2
.LC71:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_IR_f
	.type	 Cmd_IR_f,@function
Cmd_IR_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 11,.LC71@ha
	lis 9,ir@ha
	la 11,.LC71@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,ir@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L158
	lis 3,.LC44@ha
	lwz 29,84(31)
	la 3,.LC44@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	lwz 11,3868(10)
	addi 29,29,740
	mullw 3,3,0
	cmpwi 0,11,0
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	addic 11,0,-1
	subfe 9,11,0
	mr 0,9
	bc 4,2,.L160
	cmpwi 0,0,0
	li 0,1
	stw 0,3868(10)
	bc 12,2,.L161
	lis 5,.LC45@ha
	mr 3,31
	la 5,.LC45@l(5)
	b .L204
.L161:
	lis 5,.LC46@ha
	mr 3,31
	la 5,.LC46@l(5)
	b .L204
.L160:
	cmpwi 0,0,0
	li 0,0
	stw 0,3868(10)
	bc 12,2,.L164
	lis 5,.LC47@ha
	mr 3,31
	la 5,.LC47@l(5)
	b .L204
.L164:
	lis 5,.LC48@ha
	mr 3,31
	la 5,.LC48@l(5)
.L204:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L166
.L158:
	lis 5,.LC49@ha
	mr 3,31
	la 5,.LC49@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L166:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 Cmd_IR_f,.Lfe13-Cmd_IR_f
	.align 2
	.globl Bandage
	.type	 Bandage,@function
Bandage:
	lwz 11,84(3)
	li 0,0
	li 10,1
	li 8,27
	stw 0,4340(11)
	lwz 9,84(3)
	stw 0,4332(9)
	lwz 11,84(3)
	stw 0,4344(11)
	lwz 9,84(3)
	stw 0,4348(9)
	lwz 11,84(3)
	stw 0,4352(11)
	lwz 9,84(3)
	stw 0,4328(9)
	lwz 11,84(3)
	stw 0,4336(11)
	lwz 9,84(3)
	stw 0,4400(9)
	lwz 11,84(3)
	stw 10,4388(11)
	lwz 9,84(3)
	stw 8,4300(9)
	blr
.Lfe14:
	.size	 Bandage,.Lfe14-Bandage
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
