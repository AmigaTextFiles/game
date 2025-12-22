	.file	"g_cmds.c"
gcc2_compiled.:
	.section	".text"
	.align 2
	.globl debug_printf
	.type	 debug_printf,@function
debug_printf:
	stwu 1,-112(1)
	stw 4,12(1)
	stw 5,16(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	bc 4,6,.L7
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L7:
	la 1,112(1)
	blr
.Lfe1:
	.size	 debug_printf,.Lfe1-debug_printf
	.align 2
	.globl safe_cprintf
	.type	 safe_cprintf,@function
safe_cprintf:
	mr 12,1
	lis 0,0xfffe
	ori 0,0,65376
	stwux 1,1,0
	mflr 0
	stmw 28,-16(12)
	stw 0,4(12)
	lis 0,0x1
	lis 31,0x1
	ori 31,31,168
	ori 0,0,112
	add 12,1,0
	add 11,1,31
	lis 28,0x300
	addi 29,1,8
	stw 11,20(12)
	stw 29,24(12)
	mr 31,3
	mr 30,4
	stw 28,16(12)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	bc 4,6,.L9
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L9:
	cmpwi 0,31,0
	mr 4,5
	bc 12,2,.L10
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L8
	lwz 0,972(31)
	cmpwi 0,0,0
	bc 4,2,.L8
.L10:
	addi 9,12,16
	mr 5,12
	lwz 0,4(9)
	addi 3,1,112
	lwz 11,8(9)
	stw 0,4(12)
	stw 28,0(12)
	stw 11,8(12)
	bl vsprintf
	lis 9,gi+8@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	mr 4,30
	addi 5,1,112
	mtlr 0
	crxor 6,6,6
	blrl
.L8:
	lwz 11,0(1)
	lwz 0,4(11)
	mtlr 0
	lmw 28,-16(11)
	mr 1,11
	blr
.Lfe2:
	.size	 safe_cprintf,.Lfe2-safe_cprintf
	.align 2
	.globl safe_centerprintf
	.type	 safe_centerprintf,@function
safe_centerprintf:
	stwu 1,-112(1)
	stw 5,16(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	bc 4,6,.L13
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L13:
	la 1,112(1)
	blr
.Lfe3:
	.size	 safe_centerprintf,.Lfe3-safe_centerprintf
	.section	".rodata"
	.align 2
.LC0:
	.long 0x0
	.align 3
.LC1:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl safe_bprintf
	.type	 safe_bprintf,@function
safe_bprintf:
	mr 12,1
	lis 0,0xfffe
	ori 0,0,65344
	stwux 1,1,0
	mflr 0
	stfd 31,-8(12)
	stmw 26,-32(12)
	stw 0,4(12)
	lis 0,0x1
	lis 30,0x1
	ori 30,30,200
	ori 0,0,112
	add 12,1,0
	add 11,1,30
	lis 31,0x200
	addi 29,1,8
	stw 11,20(12)
	stw 29,24(12)
	mr 30,3
	stw 31,16(12)
	stw 5,16(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	bc 4,6,.L15
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L15:
	addi 9,12,16
	mr 5,12
	lwz 11,8(9)
	addi 3,1,112
	lwz 0,4(9)
	lis 9,.LC0@ha
	stw 11,8(12)
	la 9,.LC0@l(9)
	stw 31,0(12)
	lfs 31,0(9)
	stw 0,4(12)
	bl vsprintf
	lis 9,dedicated@ha
	lwz 11,dedicated@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L16
	li 3,0
	mr 4,30
	addi 5,1,112
	crxor 6,6,6
	bl safe_cprintf
.L16:
	lis 9,maxclients@ha
	li 31,0
	lwz 11,maxclients@l(9)
	lis 26,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,31,0
	bc 4,0,.L18
	lis 9,.LC1@ha
	lis 27,g_edicts@ha
	la 9,.LC1@l(9)
	lis 28,0x4330
	lfd 31,0(9)
	li 29,1076
.L20:
	lwz 0,g_edicts@l(27)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L19
	lwz 0,972(3)
	cmpwi 0,0,0
	bc 4,2,.L19
	mr 4,30
	addi 5,1,112
	crxor 6,6,6
	bl safe_cprintf
.L19:
	addi 31,31,1
	addis 9,1,1
	lwz 11,maxclients@l(26)
	xoris 0,31,0x8000
	addi 29,29,1076
	stw 0,156(9)
	stw 28,152(9)
	lfd 0,152(9)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L20
.L18:
	lwz 11,0(1)
	lwz 0,4(11)
	mtlr 0
	lmw 26,-32(11)
	lfd 31,-8(11)
	mr 1,11
	blr
.Lfe4:
	.size	 safe_bprintf,.Lfe4-safe_bprintf
	.section	".rodata"
	.align 2
.LC2:
	.string	"Colors:\n  Green\n  Red\n  Yellow\n  Blue\n"
	.align 2
.LC3:
	.string	"red"
	.align 2
.LC4:
	.string	"Using Red Light Saber\n"
	.align 2
.LC5:
	.string	"green"
	.align 2
.LC6:
	.string	"Using Green Light Saber\n"
	.align 2
.LC7:
	.string	"yellow"
	.align 2
.LC8:
	.string	"Using Yellow Light Saber\n"
	.align 2
.LC9:
	.string	"blue"
	.align 2
.LC10:
	.string	"Using Blue Light Saber\n"
	.align 2
.LC11:
	.string	"No color defined, please type:\ncolor \244\244\244\244 with \244\244\244\244 being either red, green, yellow or blue.\n\nUsing Blue as default Saber Color.\n"
	.section	".text"
	.align 2
	.globl Cmd_Saber_Color
	.type	 Cmd_Saber_Color,@function
Cmd_Saber_Color:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi@ha
	mr 31,3
	la 30,gi@l(9)
	lwz 9,156(30)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 4,2,.L25
	lis 5,.LC2@ha
	mr 3,31
	la 5,.LC2@l(5)
	li 4,1
	crxor 6,6,6
	bl safe_cprintf
	b .L24
.L25:
	lwz 0,164(30)
	mtlr 0
	blrl
	mr 30,3
	lis 4,.LC3@ha
	mr 3,30
	la 4,.LC3@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L27
	lwz 9,84(31)
	li 0,1
	lis 5,.LC4@ha
	la 5,.LC4@l(5)
	b .L35
.L27:
	lis 4,.LC5@ha
	mr 3,30
	la 4,.LC5@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L29
	lwz 9,84(31)
	li 0,2
	lis 5,.LC6@ha
	la 5,.LC6@l(5)
	b .L35
.L29:
	lis 4,.LC7@ha
	mr 3,30
	la 4,.LC7@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L31
	lwz 9,84(31)
	li 0,3
	lis 5,.LC8@ha
	la 5,.LC8@l(5)
	b .L35
.L31:
	lis 4,.LC9@ha
	mr 3,30
	la 4,.LC9@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L33
	lwz 9,84(31)
	li 0,4
	lis 5,.LC10@ha
	la 5,.LC10@l(5)
.L35:
	mr 3,31
	stw 0,4844(9)
	li 4,1
	crxor 6,6,6
	bl safe_cprintf
	b .L28
.L33:
	lwz 9,84(31)
	li 0,4
	lis 5,.LC11@ha
	la 5,.LC11@l(5)
	mr 3,31
	stw 0,4844(9)
	li 4,1
	crxor 6,6,6
	bl safe_cprintf
.L28:
	mr 3,31
	bl ChangeWeapon
.L24:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_Saber_Color,.Lfe5-Cmd_Saber_Color
	.section	".rodata"
	.align 2
.LC12:
	.string	"Lightsaber"
	.align 2
.LC13:
	.string	"Acceptable commands are \"mouse_s off\" and \"mouse_s #\" with # being a number\n"
	.align 2
.LC14:
	.string	"off"
	.align 2
.LC15:
	.string	"Custom mouse sensitivity is off\n"
	.align 2
.LC16:
	.string	"sensitivity \"%f\"\n"
	.align 2
.LC17:
	.string	"Custom mouse sensitivity is %f\n"
	.align 2
.LC18:
	.string	"Autoreload ON\n"
	.align 2
.LC19:
	.string	"Autoreload OFF\n"
	.align 2
.LC20:
	.string	"Usage: vehicle num\n"
	.align 2
.LC21:
	.string	"Where num is the number of the vehicle\n"
	.align 2
.LC22:
	.string	"cl_predict 1\n"
	.align 2
.LC23:
	.string	"cl_footsteps 1\n"
	.align 2
.LC24:
	.string	"vehicles/s_bike/start.wav"
	.align 2
.LC25:
	.string	"cl_predict 0\n"
	.align 2
.LC26:
	.string	"cl_footsteps 0\n"
	.align 2
.LC27:
	.string	"models/vehicles/spdrbike/tris.md2"
	.align 2
.LC28:
	.long 0x3f800000
	.align 2
.LC29:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_sbike
	.type	 Cmd_sbike,@function
Cmd_sbike:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4740(9)
	andi. 9,0,4
	bc 12,2,.L71
	lis 29,gi@ha
	li 3,11
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC22@ha
	la 3,.LC22@l(3)
	mtlr 9
	blrl
	lwz 9,92(29)
	li 4,1
	mr 3,31
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,11
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC23@ha
	la 3,.LC23@l(3)
	mtlr 9
	blrl
	lwz 9,92(29)
	mr 3,31
	li 4,1
	mtlr 9
	blrl
	li 0,255
	mr 3,31
	stw 0,40(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 10,84(31)
	li 11,0
	li 0,0
	stw 11,4740(10)
	lwz 9,84(31)
	stw 0,4752(9)
	lwz 11,84(31)
	stw 0,4744(11)
	lwz 9,84(31)
	stw 0,4748(9)
	b .L70
.L71:
	lis 29,gi@ha
	lis 3,.LC24@ha
	la 29,gi@l(29)
	la 3,.LC24@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC28@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC28@l(9)
	li 4,0
	lfs 1,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC28@ha
	la 9,.LC28@l(9)
	lfs 2,0(9)
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,100(29)
	li 3,11
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC25@ha
	la 3,.LC25@l(3)
	mtlr 9
	blrl
	lwz 9,92(29)
	li 4,1
	mr 3,31
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,11
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC26@ha
	la 3,.LC26@l(3)
	mtlr 9
	blrl
	lwz 9,92(29)
	li 4,1
	mr 3,31
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC27@ha
	la 3,.LC27@l(3)
	mtlr 9
	blrl
	stw 3,40(31)
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
	lwz 9,84(31)
	li 10,0
	lis 8,0x4220
	lwz 0,4740(9)
	ori 0,0,4
	stw 0,4740(9)
	lwz 11,84(31)
	lwz 0,4740(11)
	ori 0,0,1
	stw 0,4740(11)
	lwz 9,84(31)
	stw 10,4752(9)
	lwz 11,84(31)
	stw 8,4744(11)
	lwz 9,84(31)
	stw 10,4748(9)
.L70:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 Cmd_sbike,.Lfe6-Cmd_sbike
	.section	".rodata"
	.align 2
.LC30:
	.string	"Hands"
	.align 2
.LC31:
	.string	"worldspawn"
	.align 2
.LC32:
	.string	"func_door"
	.align 2
.LC33:
	.string	"func_button"
	.align 2
.LC34:
	.string	"func_door_rotating"
	.align 2
.LC35:
	.long 0x41c00000
	.align 2
.LC36:
	.long 0x42800000
	.section	".text"
	.align 2
	.globl Cmd_OpenDoor
	.type	 Cmd_OpenDoor,@function
Cmd_OpenDoor:
	stwu 1,-144(1)
	mflr 0
	stmw 28,128(1)
	stw 0,148(1)
	lis 9,.LC35@ha
	mr 31,3
	la 9,.LC35@l(9)
	lfs 0,12(31)
	addi 28,1,40
	lfs 12,0(9)
	addi 29,1,24
	li 6,0
	lfs 11,4(31)
	mr 4,28
	li 5,0
	lfs 13,8(31)
	fadds 0,0,12
	lwz 3,84(31)
	stfs 11,8(1)
	stfs 13,12(1)
	addi 3,3,4252
	stfs 0,16(1)
	bl AngleVectors
	lis 9,.LC36@ha
	addi 3,1,8
	la 9,.LC36@l(9)
	mr 4,28
	lfs 1,0(9)
	mr 5,29
	bl VectorMA
	lis 11,gi+48@ha
	addi 4,1,8
	lwz 0,gi+48@l(11)
	li 9,3
	addi 3,1,56
	mr 7,29
	mr 8,31
	li 5,0
	li 6,0
	mtlr 0
	blrl
	lwz 9,108(1)
	lis 4,.LC31@ha
	la 4,.LC31@l(4)
	lwz 3,280(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L78
	lwz 9,108(1)
	lis 4,.LC32@ha
	la 4,.LC32@l(4)
	lwz 3,280(9)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L80
	lwz 3,108(1)
	lwz 0,300(3)
	cmpwi 0,0,0
	bc 4,2,.L78
	mr 4,31
	mr 5,4
	bl door_use
	b .L78
.L80:
	lwz 9,108(1)
	lis 4,.LC33@ha
	la 4,.LC33@l(4)
	lwz 3,280(9)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L83
	mr 4,31
	lwz 3,108(1)
	mr 5,4
	bl button_use
	b .L78
.L83:
	lwz 9,108(1)
	lis 4,.LC34@ha
	la 4,.LC34@l(4)
	lwz 3,280(9)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L78
	lwz 3,108(1)
	lwz 0,300(3)
	cmpwi 0,0,0
	bc 4,2,.L78
	mr 4,31
	mr 5,4
	bl door_use
.L78:
	lwz 0,148(1)
	mtlr 0
	lmw 28,128(1)
	la 1,144(1)
	blr
.Lfe7:
	.size	 Cmd_OpenDoor,.Lfe7-Cmd_OpenDoor
	.section	".rodata"
	.align 2
.LC37:
	.string	"This command only works in deathmatch\n"
	.align 2
.LC38:
	.string	"You must run the server with '+set cheats 1' to enable this command.\n"
	.align 2
.LC39:
	.string	"setting force level to: %i\n"
	.align 2
.LC40:
	.long 0x0
	.align 3
.LC41:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_Set_Force_Level
	.type	 Cmd_Set_Force_Level,@function
Cmd_Set_Force_Level:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 9,deathmatch@ha
	lis 10,.LC40@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC40@l(10)
	mr 30,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L92
	lis 5,.LC37@ha
	la 5,.LC37@l(5)
	b .L107
.L92:
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L93
	lis 5,.LC38@ha
	mr 3,30
	la 5,.LC38@l(5)
.L107:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L91
.L93:
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	bl atoi
	mr 31,3
	cmpwi 0,31,50
	bc 4,1,.L94
	li 31,50
	b .L95
.L94:
	cmpwi 7,31,-50
	li 9,-50
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,31,0
	or 31,0,9
.L95:
	lis 9,gi+4@ha
	lis 3,.LC39@ha
	lwz 0,gi+4@l(9)
	la 3,.LC39@l(3)
	mr 4,31
	mtlr 0
	crxor 6,6,6
	blrl
	xoris 0,31,0x8000
	lwz 8,84(30)
	stw 0,20(1)
	lis 10,0x4330
	lis 9,.LC41@ha
	stw 10,16(1)
	la 9,.LC41@l(9)
	li 0,1
	lfd 13,0(9)
	addi 3,31,50
	addi 4,31,-50
	lfd 0,16(1)
	lis 9,powerlist@ha
	li 5,1
	la 9,powerlist@l(9)
	li 11,22
	addi 7,9,84
	mtctr 11
	lis 6,0x447a
	fsub 0,0,13
	li 12,0
	li 10,4
	frsp 0,0
	stfs 0,1956(8)
	lwz 9,84(30)
	stw 0,4612(9)
.L106:
	lha 0,-8(7)
	cmpwi 0,0,0
	bc 12,2,.L108
	lwz 0,0(7)
	cmpw 7,0,3
	cmpw 6,0,4
	cror 31,30,28
	cror 27,26,25
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 0,0,9
	bc 12,2,.L103
.L108:
	lwz 9,84(30)
	addi 9,9,1856
	stwx 5,9,10
	lwz 11,84(30)
	addi 11,11,1984
	stwx 6,11,10
	b .L99
.L103:
	lwz 9,84(30)
	addi 9,9,1856
	stwx 0,9,10
	lwz 11,84(30)
	addi 11,11,1984
	stwx 12,11,10
.L99:
	addi 10,10,4
	addi 7,7,44
	bdnz .L106
	mr 3,30
	bl calc_subgroup_values
	mr 3,30
	bl calc_darklight_value
	mr 3,30
	bl calc_top_level_value
	lwz 9,84(30)
	lfs 1,1952(9)
	fadds 1,1,1
	bl ceil
	fctiwz 0,1
	lwz 8,84(30)
	lis 10,.LC41@ha
	mr 11,9
	la 10,.LC41@l(10)
	lfd 13,0(10)
	lis 7,0x4330
	stfd 0,16(1)
	lwz 9,20(1)
	sth 9,1948(8)
	lwz 10,84(30)
	lha 0,1948(10)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 7,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,1852(10)
.L91:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 Cmd_Set_Force_Level,.Lfe8-Cmd_Set_Force_Level
	.section	".rodata"
	.align 2
.LC42:
	.string	"YOU CANNOT USE THE FORCE\n"
	.align 2
.LC43:
	.string	"%i"
	.align 2
.LC44:
	.string	" %s:"
	.align 2
.LC45:
	.string	" DARK"
	.align 2
.LC46:
	.string	" LIGHT"
	.align 2
.LC47:
	.string	" NEUTRAL"
	.align 2
.LC48:
	.string	" %f"
	.align 2
.LC49:
	.string	"\n"
	.align 2
.LC50:
	.string	"POOL = %f\n"
	.align 2
.LC51:
	.string	"POOL_MAX = %i\n"
	.align 2
.LC52:
	.string	"TOP LEVEL = %f\n"
	.align 2
.LC53:
	.string	"AFFILIATION = %f\n"
	.align 2
.LC54:
	.string	"SUBGROUP1 = %f\n"
	.align 2
.LC55:
	.string	"SUBGROUP2 = %f\n"
	.align 2
.LC56:
	.string	"SUBGROUP3 = %f\n"
	.align 2
.LC57:
	.string	"SUBGROUP4 = %f\n"
	.align 2
.LC58:
	.string	"SUBGROUP5 = %f\n"
	.align 2
.LC59:
	.string	"SUBGROUP6 = %f\n"
	.section	".text"
	.align 2
	.globl cmd_force_info
	.type	 cmd_force_info,@function
cmd_force_info:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4612(9)
	cmpwi 0,0,0
	bc 4,2,.L110
	lwz 0,972(31)
	cmpwi 0,0,0
	bc 4,2,.L109
	lis 9,gi+4@ha
	lis 3,.LC42@ha
	lwz 0,gi+4@l(9)
	la 3,.LC42@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L109
.L110:
	lis 9,powerlist@ha
	li 27,4
	la 9,powerlist@l(9)
	li 28,4
	addi 29,9,44
	lis 25,.LC43@ha
	lis 26,.LC44@ha
	li 30,22
.L115:
	lwz 9,84(31)
	addi 9,9,1856
	lwzx 0,9,28
	cmpwi 0,0,0
	bc 12,2,.L114
	lwz 6,40(29)
	mr 3,31
	li 4,2
	la 5,.LC43@l(25)
	crxor 6,6,6
	bl safe_cprintf
	lwz 6,20(29)
	mr 3,31
	li 4,2
	la 5,.LC44@l(26)
	crxor 6,6,6
	bl safe_cprintf
	lha 0,32(29)
	cmpwi 0,0,-1
	bc 4,2,.L117
	lis 5,.LC45@ha
	mr 3,31
	la 5,.LC45@l(5)
	b .L123
.L117:
	cmpwi 0,0,1
	bc 4,2,.L119
	lis 5,.LC46@ha
	mr 3,31
	la 5,.LC46@l(5)
.L123:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L118
.L119:
	lis 5,.LC47@ha
	mr 3,31
	la 5,.LC47@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L118:
	lwz 9,84(31)
	lis 5,.LC48@ha
	mr 3,31
	la 5,.LC48@l(5)
	li 4,2
	addi 9,9,1984
	lfsx 1,9,27
	creqv 6,6,6
	bl safe_cprintf
	lis 5,.LC49@ha
	mr 3,31
	la 5,.LC49@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L114:
	addic. 30,30,-1
	addi 27,27,4
	addi 29,29,44
	addi 28,28,4
	bc 4,2,.L115
	lwz 0,972(31)
	cmpwi 0,0,0
	bc 12,2,.L109
	lwz 9,84(31)
	lis 29,gi@ha
	lis 3,.LC50@ha
	la 29,gi@l(29)
	la 3,.LC50@l(3)
	lfs 1,1852(9)
	lwz 9,4(29)
	mtlr 9
	creqv 6,6,6
	blrl
	lwz 9,84(31)
	lis 3,.LC51@ha
	lwz 11,4(29)
	la 3,.LC51@l(3)
	lha 4,1948(9)
	mtlr 11
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lis 3,.LC52@ha
	lwz 11,4(29)
	la 3,.LC52@l(3)
	lfs 1,1952(9)
	mtlr 11
	creqv 6,6,6
	blrl
	lwz 9,84(31)
	lis 3,.LC53@ha
	lwz 11,4(29)
	la 3,.LC53@l(3)
	lfs 1,1956(9)
	mtlr 11
	creqv 6,6,6
	blrl
	lwz 9,84(31)
	lis 3,.LC54@ha
	lwz 11,4(29)
	la 3,.LC54@l(3)
	lfs 1,1964(9)
	mtlr 11
	creqv 6,6,6
	blrl
	lwz 9,84(31)
	lis 3,.LC55@ha
	lwz 11,4(29)
	la 3,.LC55@l(3)
	lfs 1,1968(9)
	mtlr 11
	creqv 6,6,6
	blrl
	lwz 9,84(31)
	lis 3,.LC56@ha
	lwz 11,4(29)
	la 3,.LC56@l(3)
	lfs 1,1972(9)
	mtlr 11
	creqv 6,6,6
	blrl
	lwz 9,84(31)
	lis 3,.LC57@ha
	lwz 11,4(29)
	la 3,.LC57@l(3)
	lfs 1,1976(9)
	mtlr 11
	creqv 6,6,6
	blrl
	lwz 9,84(31)
	lis 3,.LC58@ha
	lwz 11,4(29)
	la 3,.LC58@l(3)
	lfs 1,1980(9)
	mtlr 11
	creqv 6,6,6
	blrl
	lwz 9,84(31)
	lis 3,.LC59@ha
	lwz 0,4(29)
	la 3,.LC59@l(3)
	lfs 1,1984(9)
	mtlr 0
	creqv 6,6,6
	blrl
.L109:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 cmd_force_info,.Lfe9-cmd_force_info
	.section	".rodata"
	.align 2
.LC60:
	.string	"Night_Stinger"
	.align 2
.LC61:
	.string	"You can't use the Night Stinger zoom while moving\n"
	.align 2
.LC62:
	.long 0x0
	.section	".text"
	.align 2
	.globl sniper_zoom
	.type	 sniper_zoom,@function
sniper_zoom:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 3,.LC60@ha
	la 3,.LC60@l(3)
	bl FindItem
	lwz 10,84(31)
	lwz 0,1764(10)
	cmpw 0,0,3
	bc 12,2,.L126
	lis 9,.LC62@ha
	lis 11,zoomall@ha
	la 9,.LC62@l(9)
	lfs 13,0(9)
	lwz 9,zoomall@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L125
.L126:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L127
	lwz 0,0(10)
	cmpwi 0,0,0
	bc 4,2,.L127
	lis 9,gi+4@ha
	lis 3,.LC61@ha
	lwz 0,gi+4@l(9)
	la 3,.LC61@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L124
.L127:
	lwz 9,84(31)
	lhz 30,4426(9)
	cmpwi 0,30,0
	bc 12,2,.L128
	lwz 11,1764(9)
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	lwz 3,32(11)
	mtlr 0
	blrl
	lwz 11,84(31)
	lis 9,.LC62@ha
	li 0,0
	la 9,.LC62@l(9)
	lis 10,0x42b4
	stw 3,88(11)
	lfs 0,0(9)
	lwz 9,84(31)
	sth 0,4426(9)
	lwz 11,84(31)
	stw 10,112(11)
	lwz 9,84(31)
	lfs 1,4824(9)
	fcmpu 0,1,0
	bc 12,2,.L129
	lis 4,.LC16@ha
	mr 3,31
	la 4,.LC16@l(4)
	creqv 6,6,6
	bl _stuffcmd
.L129:
	lwz 9,84(31)
	li 0,4
	li 11,0
	stw 0,260(31)
	stw 11,0(9)
	b .L124
.L128:
	mr 3,31
	bl set_fov
	lwz 9,84(31)
	li 0,1
	sth 0,4426(9)
	lwz 11,84(31)
	stw 30,260(31)
	stw 30,88(11)
	lwz 9,84(31)
	lwz 0,4724(9)
	cmpwi 0,0,0
	bc 4,1,.L131
	lis 4,.LC14@ha
	mr 3,31
	la 4,.LC14@l(4)
	bl ChasecamRemove
.L131:
	lwz 9,84(31)
	li 0,4
	stw 0,0(9)
	b .L124
.L125:
	li 0,0
	lis 11,0x42b4
	sth 0,4426(10)
	lwz 9,84(31)
	stw 11,112(9)
.L124:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 sniper_zoom,.Lfe10-sniper_zoom
	.section	".rodata"
	.align 2
.LC63:
	.long 0x0
	.align 2
.LC64:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl cmd_Weapon_Menu
	.type	 cmd_Weapon_Menu,@function
cmd_Weapon_Menu:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi+160@ha
	mr 30,3
	lwz 0,gi+160@l(9)
	li 3,1
	mtlr 0
	blrl
	bl atoi
	lis 9,saberonly@ha
	lis 10,.LC63@ha
	lwz 11,saberonly@l(9)
	la 10,.LC63@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L133
	lwz 9,84(30)
	lhz 0,4426(9)
	cmpwi 0,0,0
	bc 4,2,.L133
	cmpwi 0,31,4
	bc 4,1,.L136
	lhz 31,4620(9)
.L136:
	mr 3,30
	bl setup_weap_menu
	lwz 11,84(30)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,4476(11)
	fcmpu 0,0,13
	bc 4,1,.L137
	lhz 0,4620(11)
	cmpw 0,0,31
	bc 4,2,.L138
	lwz 9,4624(11)
	addi 9,9,1
	stw 9,4624(11)
	lwz 8,84(30)
	lhz 9,4620(8)
	addi 11,8,4692
	lwz 10,4624(8)
	addi 9,9,-1
	add 9,9,9
	lhzx 0,11,9
	cmpw 0,10,0
	bc 4,1,.L141
	li 0,1
	stw 0,4624(8)
	b .L141
.L138:
.L137:
	sth 31,4620(11)
	li 0,1
	lwz 9,84(30)
	stw 0,4624(9)
.L141:
	lwz 9,84(30)
	li 0,2
	lis 10,.LC64@ha
	lis 11,level+4@ha
	la 10,.LC64@l(10)
	sth 0,4716(9)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	lwz 9,84(30)
	fadds 0,0,13
	stfs 0,4476(9)
.L133:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 cmd_Weapon_Menu,.Lfe11-cmd_Weapon_Menu
	.section	".rodata"
	.align 2
.LC65:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl cmd_Force_Menu
	.type	 cmd_Force_Menu,@function
cmd_Force_Menu:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4612(9)
	cmpwi 0,0,0
	bc 12,2,.L142
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	bl FindPowerByName
	mr. 8,3
	bc 12,2,.L144
	lwz 10,84(31)
	slwi 0,8,2
	addi 9,10,1856
	lwzx 11,9,0
	cmpwi 0,11,1
	bc 4,2,.L144
	lis 9,powerlist@ha
	mulli 11,8,44
	la 30,powerlist@l(9)
	add 11,11,30
	lhz 0,34(11)
	cmpwi 0,0,1
	bc 4,2,.L146
	stw 11,2076(10)
	mr 3,31
	li 4,1
	lwz 11,84(31)
	lhz 29,2106(10)
	sth 8,2106(11)
	lwz 9,84(31)
	lwz 11,2076(9)
	lwz 0,0(11)
	mtlr 0
	blrl
	mulli 0,29,44
	lwz 11,84(31)
	add 0,0,30
	stw 0,2076(11)
	lwz 9,84(31)
	sth 29,2106(9)
	b .L142
.L146:
	stw 11,2076(10)
	lwz 9,84(31)
	sth 8,2106(9)
	b .L142
.L144:
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	bl atoi
	mr 29,3
	addi 0,29,-1
	cmplwi 0,0,4
	bc 12,1,.L142
	mr 3,31
	bl setup_force_menu
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,4476(11)
	fcmpu 0,0,13
	bc 4,1,.L149
	lhz 0,4470(11)
	cmpw 0,0,29
	bc 4,2,.L150
	lhz 9,4472(11)
	add 10,29,29
	addi 9,9,1
	sth 9,4472(11)
	lwz 8,84(31)
	addi 9,8,4480
	lhz 11,4472(8)
	lhzx 0,9,10
	cmpw 0,11,0
	bc 4,2,.L153
	li 0,0
	sth 0,4472(8)
	b .L153
.L150:
.L149:
	sth 29,4470(11)
	li 0,0
	lwz 9,84(31)
	sth 0,4472(9)
.L153:
	lwz 9,84(31)
	li 0,1
	lis 10,.LC65@ha
	lis 11,level+4@ha
	la 10,.LC65@l(10)
	sth 0,4716(9)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	lwz 9,84(31)
	fadds 0,0,13
	stfs 0,4476(9)
.L142:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 cmd_Force_Menu,.Lfe12-cmd_Force_Menu
	.lcomm	value.84,512,4
	.section	".rodata"
	.align 2
.LC66:
	.string	"skin"
	.section	".text"
	.align 2
	.globl OnSameTeam
	.type	 OnSameTeam,@function
OnSameTeam:
	stwu 1,-1072(1)
	mflr 0
	stmw 27,1052(1)
	stw 0,1076(1)
	lis 11,dmflags@ha
	lwz 10,dmflags@l(11)
	mr 28,4
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 9,1044(1)
	andi. 0,9,192
	bc 4,2,.L159
	li 3,0
	b .L169
.L159:
	lis 9,value.84@ha
	li 30,0
	stb 30,value.84@l(9)
	la 31,value.84@l(9)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L171
	lis 4,.LC66@ha
	addi 3,3,188
	la 4,.LC66@l(4)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L171
	lis 9,dmflags@ha
	lwz 11,dmflags@l(9)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 9,1044(1)
	andi. 0,9,128
	bc 12,2,.L163
	stb 30,0(3)
.L171:
	mr 3,31
	b .L161
.L163:
	addi 3,3,1
.L161:
	mr 4,3
	li 29,0
	addi 3,1,8
	bl strcpy
	lis 9,value.84@ha
	addi 30,1,520
	stb 29,value.84@l(9)
	mr 27,30
	la 31,value.84@l(9)
	lwz 3,84(28)
	cmpwi 0,3,0
	bc 12,2,.L173
	lis 4,.LC66@ha
	addi 3,3,188
	la 4,.LC66@l(4)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L173
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 11,1044(1)
	andi. 0,11,128
	bc 12,2,.L167
	stb 29,0(3)
.L173:
	mr 3,31
	b .L165
.L167:
	addi 3,3,1
.L165:
	mr 4,3
	mr 3,30
	bl strcpy
	mr 4,27
	addi 3,1,8
	bl strcmp
	subfic 0,3,0
	adde 3,0,3
.L169:
	lwz 0,1076(1)
	mtlr 0
	lmw 27,1052(1)
	la 1,1072(1)
	blr
.Lfe13:
	.size	 OnSameTeam,.Lfe13-OnSameTeam
	.align 2
	.globl SelectNextItem
	.type	 SelectNextItem,@function
SelectNextItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,4760(9)
	cmpwi 0,0,0
	bc 12,2,.L175
	bl PMenu_Next
	b .L174
.L175:
	lwz 0,4408(9)
	cmpwi 0,0,0
	bc 12,2,.L176
	bl ChaseNext
	b .L174
.L176:
	lis 9,NoTouch@ha
	lwz 6,NoTouch@l(9)
	cmpwi 0,6,0
	bc 4,2,.L174
	lis 4,highlighted@ha
	lwz 10,highlighted@l(4)
	cmpwi 0,10,9
	bc 4,2,.L180
	lis 9,conversation_content@ha
	li 11,2
	la 9,conversation_content@l(9)
	stw 11,highlighted@l(4)
	li 0,1
	stw 0,1660(9)
	stw 6,7092(9)
	b .L174
.L180:
	lis 9,conversation_content@ha
	addi 5,10,1
	la 8,conversation_content@l(9)
	mulli 7,5,776
	addi 9,8,104
	lwzx 0,9,7
	cmpwi 0,0,0
	bc 4,2,.L181
	mulli 10,10,776
	li 0,2
	addi 11,8,108
	stw 0,highlighted@l(4)
	li 9,1
	stwx 6,11,10
	stw 9,1660(8)
	b .L174
.L181:
	addi 9,8,108
	stw 5,highlighted@l(4)
	mulli 11,10,776
	li 0,1
	stwx 0,9,7
	stwx 6,9,11
.L174:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 SelectNextItem,.Lfe14-SelectNextItem
	.align 2
	.globl SelectPrevItem
	.type	 SelectPrevItem,@function
SelectPrevItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,4760(9)
	cmpwi 0,0,0
	bc 12,2,.L192
	bl PMenu_Prev
	b .L191
.L192:
	lwz 0,4408(9)
	cmpwi 0,0,0
	bc 12,2,.L193
	bl ChasePrev
	b .L191
.L193:
	lis 9,NoTouch@ha
	lwz 6,NoTouch@l(9)
	cmpwi 0,6,0
	bc 4,2,.L191
	lis 7,highlighted@ha
	lwz 8,highlighted@l(7)
	cmpwi 0,8,2
	bc 4,2,.L197
	lis 9,conversation_content@ha
	li 0,9
	la 9,conversation_content@l(9)
	stw 0,highlighted@l(7)
	addi 9,9,104
	lwz 0,6984(9)
	cmpwi 0,0,0
	bc 4,2,.L199
	mr 10,9
	li 11,9
.L200:
	addi 11,11,-1
	mulli 0,11,776
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L200
	lis 9,highlighted@ha
	stw 11,highlighted@l(9)
.L199:
	lis 10,highlighted@ha
	lis 9,conversation_content@ha
	lwz 11,highlighted@l(10)
	la 9,conversation_content@l(9)
	li 0,0
	stw 0,1660(9)
	mulli 11,11,776
	addi 9,9,108
	li 0,1
	stwx 0,9,11
	b .L191
.L197:
	addi 11,8,-1
	lis 9,conversation_content@ha
	la 9,conversation_content@l(9)
	mulli 10,11,776
	stw 11,highlighted@l(7)
	li 0,1
	addi 9,9,108
	mulli 8,8,776
	stwx 0,9,10
	stwx 6,9,8
.L191:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 SelectPrevItem,.Lfe15-SelectPrevItem
	.section	".rodata"
	.align 2
.LC67:
	.string	"neut"
	.align 2
.LC68:
	.string	"light"
	.align 2
.LC69:
	.string	"dark"
	.align 2
.LC70:
	.string	"Try typing a bit clearer\n"
	.section	".text"
	.align 2
	.globl watchmesing
	.type	 watchmesing,@function
watchmesing:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	li 0,1
	lwz 11,84(31)
	lis 9,powerlist@ha
	li 8,1
	la 9,powerlist@l(9)
	li 5,0
	stw 0,4612(11)
	addi 7,9,76
	lis 6,0x447a
	li 0,22
	li 10,4
	mtctr 0
.L232:
	lha 0,0(7)
	addi 7,7,44
	cmpwi 0,0,-1
	bc 4,2,.L227
	lwz 9,84(31)
	addi 9,9,1856
	stwx 8,9,10
	lwz 11,84(31)
	addi 11,11,1984
	stwx 5,11,10
	b .L225
.L227:
	cmpwi 0,0,0
	lwz 9,84(31)
	addi 9,9,1856
	stwx 8,9,10
	lwz 11,84(31)
	addi 11,11,1984
	stwx 6,11,10
.L225:
	addi 10,10,4
	bdnz .L232
	mr 3,31
	bl calc_subgroup_values
	mr 3,31
	bl calc_darklight_value
	mr 3,31
	bl calc_top_level_value
	lwz 9,84(31)
	lfs 1,1952(9)
	fadds 1,1,1
	bl ceil
	fctiwz 0,1
	lwz 11,84(31)
	mr 3,31
	stfd 0,16(1)
	lwz 9,20(1)
	sth 9,1948(11)
	bl sort_useable_powers
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 watchmesing,.Lfe16-watchmesing
	.align 2
	.globl imabigchicken
	.type	 imabigchicken,@function
imabigchicken:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	li 0,1
	lwz 11,84(31)
	lis 9,powerlist@ha
	li 8,1
	la 9,powerlist@l(9)
	li 6,0
	stw 0,4612(11)
	addi 7,9,76
	lis 5,0x447a
	li 0,22
	li 10,4
	mtctr 0
.L243:
	lha 0,0(7)
	addi 7,7,44
	cmpwi 0,0,-1
	bc 12,2,.L240
	cmpwi 0,0,0
	bc 4,2,.L240
	lwz 9,84(31)
	addi 9,9,1856
	stwx 8,9,10
	lwz 11,84(31)
	addi 11,11,1984
	stwx 5,11,10
	b .L236
.L240:
	lwz 9,84(31)
	addi 9,9,1856
	stwx 8,9,10
	lwz 11,84(31)
	addi 11,11,1984
	stwx 6,11,10
.L236:
	addi 10,10,4
	bdnz .L243
	mr 3,31
	bl calc_subgroup_values
	mr 3,31
	bl calc_darklight_value
	mr 3,31
	bl calc_top_level_value
	lwz 9,84(31)
	lfs 1,1952(9)
	fadds 1,1,1
	bl ceil
	fctiwz 0,1
	lwz 11,84(31)
	mr 3,31
	stfd 0,16(1)
	lwz 9,20(1)
	sth 9,1948(11)
	bl sort_useable_powers
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 imabigchicken,.Lfe17-imabigchicken
	.align 2
	.globl googl3
	.type	 googl3,@function
googl3:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	li 0,1
	lwz 11,84(31)
	lis 9,powerlist@ha
	li 8,1
	la 9,powerlist@l(9)
	lis 6,0x447a
	stw 0,4612(11)
	addi 7,9,76
	li 5,0
	li 0,22
	li 10,4
	mtctr 0
.L254:
	lha 0,0(7)
	addi 7,7,44
	cmpwi 0,0,-1
	bc 12,2,.L255
	cmpwi 0,0,0
	bc 4,2,.L251
.L255:
	lwz 9,84(31)
	addi 9,9,1856
	stwx 8,9,10
	lwz 11,84(31)
	addi 11,11,1984
	stwx 6,11,10
	b .L247
.L251:
	lwz 9,84(31)
	addi 9,9,1856
	stwx 8,9,10
	lwz 11,84(31)
	addi 11,11,1984
	stwx 5,11,10
.L247:
	addi 10,10,4
	bdnz .L254
	mr 3,31
	bl calc_subgroup_values
	mr 3,31
	bl calc_darklight_value
	mr 3,31
	bl calc_top_level_value
	lwz 9,84(31)
	lfs 1,1952(9)
	fadds 1,1,1
	bl ceil
	fctiwz 0,1
	lwz 11,84(31)
	mr 3,31
	stfd 0,16(1)
	lwz 9,20(1)
	sth 9,1948(11)
	bl sort_useable_powers
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 googl3,.Lfe18-googl3
	.section	".rodata"
	.align 2
.LC71:
	.string	"force"
	.align 2
.LC72:
	.string	"neutral"
	.align 2
.LC73:
	.string	"all"
	.align 2
.LC74:
	.string	"health"
	.align 2
.LC75:
	.string	"weapons"
	.align 2
.LC76:
	.string	"ammo"
	.align 2
.LC77:
	.string	"unknown item\n"
	.align 2
.LC78:
	.string	"non-pickup item\n"
	.align 2
.LC79:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Give_f
	.type	 Cmd_Give_f,@function
Cmd_Give_f:
	stwu 1,-64(1)
	mflr 0
	mfcr 12
	stmw 26,40(1)
	stw 0,68(1)
	stw 12,36(1)
	lis 9,deathmatch@ha
	lis 10,.LC79@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC79@l(10)
	mr 30,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L263
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L263
	lis 5,.LC38@ha
	la 5,.LC38@l(5)
	b .L348
.L263:
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 27,3
	lis 4,.LC71@ha
	la 4,.LC71@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L264
	lwz 9,84(30)
	li 0,1
	li 7,1
	lis 8,0x447a
	li 10,4
	stw 0,4612(9)
	li 0,22
	mtctr 0
.L347:
	lwz 9,84(30)
	addi 9,9,1856
	stwx 7,9,10
	lwz 11,84(30)
	addi 11,11,1984
	stwx 8,11,10
	addi 10,10,4
	bdnz .L347
	b .L349
.L264:
	lis 4,.LC68@ha
	mr 3,27
	la 4,.LC68@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L270
	lwz 9,84(30)
	li 0,1
	lis 11,powerlist@ha
	la 11,powerlist@l(11)
	li 7,1
	stw 0,4612(9)
	addi 8,11,76
	li 5,0
	li 0,22
	lis 6,0x447a
	mtctr 0
	li 10,4
.L346:
	lha 0,0(8)
	addi 8,8,44
	cmpwi 0,0,-1
	bc 4,2,.L275
	lwz 9,84(30)
	addi 9,9,1856
	stwx 7,9,10
	lwz 11,84(30)
	addi 11,11,1984
	stwx 5,11,10
	b .L273
.L275:
	cmpwi 0,0,0
	lwz 9,84(30)
	addi 9,9,1856
	stwx 7,9,10
	lwz 11,84(30)
	addi 11,11,1984
	stwx 6,11,10
.L273:
	addi 10,10,4
	bdnz .L346
	b .L349
.L270:
	lis 4,.LC72@ha
	mr 3,27
	la 4,.LC72@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L280
	lwz 9,84(30)
	li 0,1
	lis 11,powerlist@ha
	la 11,powerlist@l(11)
	li 7,1
	stw 0,4612(9)
	addi 8,11,76
	li 6,0
	li 0,22
	lis 5,0x447a
	mtctr 0
	li 10,4
.L345:
	lha 0,0(8)
	addi 8,8,44
	cmpwi 0,0,-1
	bc 12,2,.L287
	cmpwi 0,0,0
	bc 4,2,.L287
	lwz 9,84(30)
	addi 9,9,1856
	stwx 7,9,10
	lwz 11,84(30)
	addi 11,11,1984
	stwx 5,11,10
	b .L283
.L287:
	lwz 9,84(30)
	addi 9,9,1856
	stwx 7,9,10
	lwz 11,84(30)
	addi 11,11,1984
	stwx 6,11,10
.L283:
	addi 10,10,4
	bdnz .L345
	b .L349
.L280:
	lis 4,.LC69@ha
	mr 3,27
	la 4,.LC69@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L290
	lwz 9,84(30)
	li 0,1
	lis 11,powerlist@ha
	la 11,powerlist@l(11)
	li 7,1
	stw 0,4612(9)
	addi 8,11,76
	lis 6,0x447a
	li 0,22
	li 5,0
	mtctr 0
	li 10,4
.L344:
	lha 0,0(8)
	addi 8,8,44
	cmpwi 0,0,-1
	bc 12,2,.L350
	cmpwi 0,0,0
	bc 4,2,.L297
.L350:
	lwz 9,84(30)
	addi 9,9,1856
	stwx 7,9,10
	lwz 11,84(30)
	addi 11,11,1984
	stwx 6,11,10
	b .L293
.L297:
	lwz 9,84(30)
	addi 9,9,1856
	stwx 7,9,10
	lwz 11,84(30)
	addi 11,11,1984
	stwx 5,11,10
.L293:
	addi 10,10,4
	bdnz .L344
.L349:
	mr 3,30
	bl calc_subgroup_values
	mr 3,30
	bl calc_darklight_value
	mr 3,30
	bl calc_top_level_value
	lwz 9,84(30)
	lfs 1,1952(9)
	fadds 1,1,1
	bl ceil
	fctiwz 0,1
	lwz 11,84(30)
	mr 3,30
	stfd 0,24(1)
	lwz 9,28(1)
	sth 9,1948(11)
	bl sort_useable_powers
	b .L262
.L290:
	lis 4,.LC73@ha
	mr 3,27
	la 4,.LC73@l(4)
	bl Q_stricmp
	subfic 0,3,0
	adde. 28,0,3
	mfcr 31
	bc 4,2,.L303
	lwz 9,160(29)
	li 3,1
	rlwinm 31,31,16,0xffffffff
	mtcrf 8,31
	rlwinm 31,31,16,0xffffffff
	mtlr 9
	blrl
	lis 4,.LC74@ha
	la 4,.LC74@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L302
.L303:
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L304
	lwz 0,160(29)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	stw 3,480(30)
	b .L305
.L304:
	lwz 0,484(30)
	stw 0,480(30)
.L305:
	cmpwi 4,28,0
	bc 12,18,.L262
.L302:
	bc 4,18,.L308
	lis 4,.LC75@ha
	mr 3,27
	la 4,.LC75@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L307
.L308:
	lis 9,.LC79@ha
	lis 11,saberonly@ha
	la 9,.LC79@l(9)
	lfs 13,0(9)
	lwz 9,saberonly@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L262
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L311
	lis 9,itemlist@ha
	mr 7,11
	la 8,itemlist@l(9)
	li 10,0
.L313:
	mr 31,8
	lwz 0,4(31)
	cmpwi 0,0,0
	bc 12,2,.L312
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L312
	lwz 11,84(30)
	addi 11,11,740
	lwzx 9,11,10
	addi 9,9,1
	stwx 9,11,10
.L312:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 8,8,76
	cmpw 0,29,0
	bc 12,0,.L313
.L311:
	bc 12,18,.L262
.L307:
	bc 4,18,.L319
	lis 4,.LC76@ha
	mr 3,27
	la 4,.LC76@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L318
.L319:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L321
	lis 9,itemlist@ha
	mr 26,11
	la 28,itemlist@l(9)
.L323:
	mr 31,28
	lwz 0,4(31)
	cmpwi 0,0,0
	bc 12,2,.L322
	lwz 0,56(31)
	andi. 9,0,2
	bc 12,2,.L322
	mr 4,31
	mr 3,30
	li 5,1000
	bl Add_Ammo
.L322:
	lwz 0,1556(26)
	addi 29,29,1
	addi 28,28,76
	cmpw 0,29,0
	bc 12,0,.L323
.L321:
	bc 12,18,.L262
.L318:
	bc 12,18,.L328
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L262
	lis 9,itemlist@ha
	mr 7,11
	la 11,itemlist@l(9)
	li 8,1
	li 10,0
.L332:
	lwz 0,4(11)
	cmpwi 0,0,0
	bc 12,2,.L331
	lwz 0,56(11)
	andi. 9,0,3
	bc 4,2,.L331
	lwz 9,84(30)
	addi 9,9,740
	stwx 8,9,10
.L331:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 11,11,76
	cmpw 0,29,0
	bc 12,0,.L332
	b .L262
.L328:
	mr 3,27
	bl FindItem
	mr. 31,3
	bc 4,2,.L336
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	bl FindItem
	mr. 31,3
	bc 4,2,.L336
	lis 5,.LC77@ha
	mr 3,30
	la 5,.LC77@l(5)
	b .L348
.L336:
	lwz 0,4(31)
	cmpwi 0,0,0
	bc 4,2,.L338
	lis 5,.LC78@ha
	mr 3,30
	la 5,.LC78@l(5)
.L348:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L262
.L338:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,56(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,31
	andi. 10,11,2
	mullw 9,9,0
	srawi 28,9,2
	bc 12,2,.L339
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L340
	lwz 0,160(29)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(30)
	slwi 0,28,2
	addi 9,9,740
	stwx 3,9,0
	b .L262
.L340:
	lwz 9,84(30)
	slwi 10,28,2
	lwz 11,48(31)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L262
.L339:
	bl G_Spawn
	lwz 0,0(31)
	mr 29,3
	mr 4,31
	stw 0,280(29)
	bl SpawnItem
	mr 4,30
	mr 3,29
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L262
	mr 3,29
	bl G_FreeEdict
.L262:
	lwz 0,68(1)
	lwz 12,36(1)
	mtlr 0
	lmw 26,40(1)
	mtcrf 8,12
	la 1,64(1)
	blr
.Lfe19:
	.size	 Cmd_Give_f,.Lfe19-Cmd_Give_f
	.section	".rodata"
	.align 2
.LC80:
	.string	"godmode OFF\n"
	.align 2
.LC81:
	.string	"godmode ON\n"
	.align 2
.LC82:
	.string	"notarget OFF\n"
	.align 2
.LC83:
	.string	"notarget ON\n"
	.align 2
.LC84:
	.string	"noclip OFF\n"
	.align 2
.LC85:
	.string	"noclip ON\n"
	.align 2
.LC86:
	.string	"unknown item: %s\n"
	.align 2
.LC87:
	.string	"Item is not usable.\n"
	.align 2
.LC88:
	.string	"Out of item: %s\n"
	.align 2
.LC89:
	.string	"tech"
	.align 2
.LC90:
	.string	"Item is not dropable.\n"
	.section	".text"
	.align 2
	.globl Cmd_Drop_f
	.type	 Cmd_Drop_f,@function
Cmd_Drop_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi+164@ha
	mr 31,3
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	lis 4,.LC89@ha
	la 4,.LC89@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L368
	mr 3,31
	bl CTFWhat_Tech
	mr. 10,3
	bc 12,2,.L368
	lwz 0,12(10)
	mr 3,31
	mr 4,10
	mtlr 0
	blrl
	b .L367
.L368:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 30,3
	bl FindItem
	mr. 10,3
	bc 4,2,.L369
	lis 5,.LC86@ha
	mr 3,31
	la 5,.LC86@l(5)
	b .L372
.L369:
	lwz 8,12(10)
	cmpwi 0,8,0
	bc 4,2,.L370
	lis 5,.LC90@ha
	mr 3,31
	la 5,.LC90@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L367
.L370:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L371
	lis 5,.LC88@ha
	mr 3,31
	la 5,.LC88@l(5)
.L372:
	mr 6,30
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L367
.L371:
	mr 3,31
	mr 4,10
	mtlr 8
	blrl
.L367:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe20:
	.size	 Cmd_Drop_f,.Lfe20-Cmd_Drop_f
	.section	".rodata"
	.align 2
.LC91:
	.string	"No item to use.\n"
	.align 2
.LC92:
	.string	"No item to drop.\n"
	.align 2
.LC93:
	.string	"%3i %s\n"
	.align 2
.LC94:
	.string	"...\n"
	.align 2
.LC95:
	.string	"%s\n%i players\n"
	.align 2
.LC96:
	.long 0x0
	.align 3
.LC97:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_Players_f
	.type	 Cmd_Players_f,@function
Cmd_Players_f:
	stwu 1,-2432(1)
	mflr 0
	stmw 23,2396(1)
	stw 0,2436(1)
	lis 11,.LC96@ha
	lis 9,maxclients@ha
	la 11,.LC96@l(11)
	mr 23,3
	lfs 13,0(11)
	li 27,0
	li 31,0
	lwz 11,maxclients@l(9)
	addi 29,1,1352
	addi 30,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L440
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC97@ha
	la 9,.LC97@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L442:
	lwz 0,0(11)
	addi 11,11,4956
	cmpwi 0,0,0
	bc 12,2,.L441
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L441:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L442
.L440:
	lis 6,PlayerSort@ha
	mr 3,29
	la 6,PlayerSort@l(6)
	mr 4,27
	li 5,4
	li 31,0
	bl qsort
	cmpw 0,31,27
	li 0,0
	stb 0,72(1)
	bc 4,0,.L446
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC93@ha
	lis 25,.LC94@ha
.L448:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC93@l(26)
	addi 28,28,4
	mulli 7,7,4956
	add 7,7,0
	lha 6,148(7)
	addi 7,7,700
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,30
	bl strlen
	add 29,29,3
	cmplwi 0,29,1180
	bc 4,1,.L449
	la 4,.LC94@l(25)
	mr 3,30
	bl strcat
	b .L446
.L449:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L448
.L446:
	lis 5,.LC95@ha
	mr 3,23
	la 5,.LC95@l(5)
	mr 6,30
	mr 7,27
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 0,2436(1)
	mtlr 0
	lmw 23,2396(1)
	la 1,2432(1)
	blr
.Lfe21:
	.size	 Cmd_Players_f,.Lfe21-Cmd_Players_f
	.section	".rodata"
	.align 2
.LC98:
	.string	"(%s): "
	.align 2
.LC99:
	.string	"%s: "
	.align 2
.LC100:
	.string	" "
	.align 2
.LC101:
	.string	"You can't talk for %d more seconds\n"
	.align 2
.LC102:
	.string	"Flood protection:  You can't talk for %d seconds.\n"
	.align 2
.LC103:
	.string	"%s"
	.align 2
.LC104:
	.long 0x0
	.align 3
.LC105:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC106:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Cmd_Say_f
	.type	 Cmd_Say_f,@function
Cmd_Say_f:
	stwu 1,-2096(1)
	mflr 0
	mfcr 12
	stmw 25,2068(1)
	stw 0,2100(1)
	stw 12,2064(1)
	lis 9,gi+156@ha
	mr 28,3
	lwz 0,gi+156@l(9)
	mr 30,4
	mr 31,5
	mtlr 0
	blrl
	cmpwi 0,3,1
	bc 12,1,.L452
	cmpwi 0,31,0
	bc 12,2,.L451
.L452:
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,2056(1)
	lwz 9,2060(1)
	rlwinm 9,9,0,24,25
	neg 9,9
	srawi 9,9,31
	and. 30,30,9
	bc 12,2,.L454
	lwz 6,84(28)
	lis 5,.LC98@ha
	addi 3,1,8
	la 5,.LC98@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L455
.L454:
	lwz 6,84(28)
	lis 5,.LC99@ha
	addi 3,1,8
	la 5,.LC99@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L455:
	cmpwi 0,31,0
	bc 12,2,.L456
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC100@ha
	addi 3,1,8
	la 4,.LC100@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L457
.L456:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L458
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
.L458:
	mr 4,29
	addi 3,1,8
	bl strcat
.L457:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L459
	li 0,0
	stb 0,158(1)
.L459:
	lis 4,.LC49@ha
	addi 3,1,8
	la 4,.LC49@l(4)
	bl strcat
	lis 9,.LC104@ha
	la 9,.LC104@l(9)
	lfs 8,0(9)
	lis 9,flood_msgs@ha
	lwz 11,flood_msgs@l(9)
	lfs 9,20(11)
	fcmpu 0,9,8
	bc 12,2,.L460
	lwz 7,84(28)
	lis 9,level+4@ha
	lfs 10,level+4@l(9)
	lfs 0,4356(7)
	fcmpu 0,10,0
	bc 4,0,.L461
	fsubs 0,0,10
	lis 5,.LC101@ha
	mr 3,28
	la 5,.LC101@l(5)
	li 4,2
	fctiwz 13,0
	stfd 13,2056(1)
	b .L474
.L461:
	lwz 0,4400(7)
	lis 10,0x4330
	lis 11,.LC105@ha
	addi 8,7,4360
	mr 6,0
	la 11,.LC105@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,2060(1)
	lis 11,.LC106@ha
	stw 10,2056(1)
	la 11,.LC106@l(11)
	lfd 0,2056(1)
	mr 10,8
	lfs 11,0(11)
	mr 11,9
	fsub 0,0,13
	frsp 0,0
	fsubs 0,0,9
	fadds 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,2056(1)
	lwz 11,2060(1)
	nor 0,11,11
	addi 9,11,10
	srawi 0,0,31
	andc 9,9,0
	and 11,11,0
	or 11,11,9
	slwi 11,11,2
	lfsx 0,8,11
	fcmpu 0,0,8
	bc 12,2,.L463
	lis 11,flood_persecond@ha
	fsubs 13,10,0
	lwz 9,flood_persecond@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L463
	lis 9,flood_waitdelay@ha
	lwz 11,flood_waitdelay@l(9)
	lis 5,.LC102@ha
	mr 3,28
	la 5,.LC102@l(5)
	li 4,3
	lfs 13,20(11)
	fadds 13,10,13
	stfs 13,4356(7)
	lfs 0,20(11)
	fctiwz 12,0
	stfd 12,2056(1)
.L474:
	lwz 6,2060(1)
	crxor 6,6,6
	bl safe_cprintf
	b .L451
.L463:
	lis 0,0xcccc
	addi 9,6,1
	ori 0,0,52429
	lis 11,level+4@ha
	mulhwu 0,9,0
	srwi 0,0,3
	mulli 0,0,10
	subf 9,0,9
	stw 9,4400(7)
	lfs 0,level+4@l(11)
	slwi 9,9,2
	stfsx 0,10,9
.L460:
	lis 9,.LC104@ha
	lis 11,dedicated@ha
	la 9,.LC104@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L464
	lis 5,.LC103@ha
	li 3,0
	la 5,.LC103@l(5)
	li 4,3
	addi 6,1,8
	crxor 6,6,6
	bl safe_cprintf
.L464:
	lis 9,game@ha
	li 31,1
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,31,0
	bc 12,1,.L451
	cmpwi 4,30,0
	mr 25,9
	lis 26,g_edicts@ha
	lis 27,.LC103@ha
	li 30,1076
.L468:
	lwz 0,g_edicts@l(26)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L467
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L467
	bc 12,18,.L471
	mr 3,28
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L467
.L471:
	mr 3,29
	li 4,3
	la 5,.LC103@l(27)
	addi 6,1,8
	crxor 6,6,6
	bl safe_cprintf
.L467:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,1076
	cmpw 0,31,0
	bc 4,1,.L468
.L451:
	lwz 0,2100(1)
	lwz 12,2064(1)
	mtlr 0
	lmw 25,2068(1)
	mtcrf 8,12
	la 1,2096(1)
	blr
.Lfe22:
	.size	 Cmd_Say_f,.Lfe22-Cmd_Say_f
	.section	".rodata"
	.align 2
.LC107:
	.string	"%02d:%02d %4d %3d %s%s\n"
	.align 2
.LC108:
	.string	" (spectator)"
	.align 2
.LC109:
	.string	""
	.align 2
.LC110:
	.string	"And more...\n"
	.align 2
.LC111:
	.long 0x0
	.align 3
.LC112:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_PlayerList_f
	.type	 Cmd_PlayerList_f,@function
Cmd_PlayerList_f:
	stwu 1,-1568(1)
	mflr 0
	stmw 21,1524(1)
	stw 0,1572(1)
	lis 9,maxclients@ha
	li 0,0
	lwz 11,maxclients@l(9)
	lis 10,g_edicts@ha
	mr 28,3
	lis 9,.LC111@ha
	stb 0,96(1)
	li 27,0
	la 9,.LC111@l(9)
	lfs 0,20(11)
	lis 22,maxclients@ha
	lfs 13,0(9)
	addi 31,1,96
	lis 21,.LC103@ha
	lwz 9,g_edicts@l(10)
	fcmpu 0,13,0
	addi 30,9,1076
	bc 4,0,.L477
	lis 9,.LC108@ha
	lis 11,.LC109@ha
	la 23,.LC108@l(9)
	la 24,.LC109@l(11)
	lis 25,level@ha
	lis 26,0x4330
.L479:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L478
	lwz 10,84(30)
	lis 11,0x1b4e
	lis 8,0x6666
	lwz 9,level@l(25)
	ori 11,11,33205
	ori 8,8,26215
	lwz 0,4028(10)
	addi 29,10,700
	lwz 7,4076(10)
	subf 9,0,9
	lwz 3,184(10)
	mulhw 11,9,11
	lwz 4,4032(10)
	cmpwi 0,7,0
	srawi 10,9,31
	srawi 11,11,6
	subf 6,10,11
	mulli 0,6,600
	subf 9,0,9
	mulhw 8,9,8
	srawi 9,9,31
	srawi 8,8,2
	subf 7,9,8
	bc 12,2,.L481
	stw 23,8(1)
	b .L482
.L481:
	stw 24,8(1)
.L482:
	mr 8,3
	mr 9,4
	lis 5,.LC107@ha
	mr 10,29
	addi 3,1,16
	la 5,.LC107@l(5)
	li 4,80
	crxor 6,6,6
	bl Com_sprintf
	mr 3,31
	bl strlen
	mr 29,3
	addi 3,1,16
	bl strlen
	add 29,29,3
	cmplwi 0,29,1350
	bc 4,1,.L483
	mr 3,31
	bl strlen
	lis 4,.LC110@ha
	add 3,31,3
	la 4,.LC110@l(4)
	crxor 6,6,6
	bl sprintf
	mr 3,28
	la 5,.LC103@l(21)
	mr 6,31
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L475
.L483:
	mr 3,31
	addi 4,1,16
	bl strcat
.L478:
	addi 27,27,1
	lwz 11,maxclients@l(22)
	xoris 0,27,0x8000
	lis 10,.LC112@ha
	stw 0,1516(1)
	la 10,.LC112@l(10)
	addi 30,30,1076
	stw 26,1512(1)
	lfd 13,0(10)
	lfd 0,1512(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L479
.L477:
	lis 5,.LC103@ha
	mr 3,28
	la 5,.LC103@l(5)
	mr 6,31
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L475:
	lwz 0,1572(1)
	mtlr 0
	lmw 21,1524(1)
	la 1,1568(1)
	blr
.Lfe23:
	.size	 Cmd_PlayerList_f,.Lfe23-Cmd_PlayerList_f
	.section	".rodata"
	.align 2
.LC113:
	.string	"players"
	.align 2
.LC114:
	.string	"say"
	.align 2
.LC115:
	.string	"say_team"
	.align 2
.LC116:
	.string	"score"
	.align 2
.LC117:
	.string	"help"
	.align 2
.LC118:
	.string	"use"
	.align 2
.LC119:
	.string	"drop"
	.align 2
.LC120:
	.string	"give"
	.align 2
.LC121:
	.string	"god"
	.align 2
.LC122:
	.string	"notarget"
	.align 2
.LC123:
	.string	"noclip"
	.align 2
.LC124:
	.string	"inven"
	.align 2
.LC125:
	.string	"invnext"
	.align 2
.LC126:
	.string	"invprev"
	.align 2
.LC127:
	.string	"invnextw"
	.align 2
.LC128:
	.string	"invprevw"
	.align 2
.LC129:
	.string	"invnextp"
	.align 2
.LC130:
	.string	"invprevp"
	.align 2
.LC131:
	.string	"invuse"
	.align 2
.LC132:
	.string	"invdrop"
	.align 2
.LC133:
	.string	"weapprev"
	.align 2
.LC134:
	.string	"weapnext"
	.align 2
.LC135:
	.string	"weaplast"
	.align 2
.LC136:
	.string	"kill"
	.align 2
.LC137:
	.string	"putaway"
	.align 2
.LC138:
	.string	"playerlist"
	.align 2
.LC139:
	.string	"opendoor"
	.align 2
.LC140:
	.string	"secondary"
	.align 2
.LC141:
	.string	"reload"
	.align 2
.LC142:
	.string	"zoom"
	.align 2
.LC143:
	.string	"forceinfo"
	.align 2
.LC144:
	.string	"weapon"
	.align 2
.LC145:
	.string	"holster"
	.align 2
.LC146:
	.string	"chasecam"
	.align 2
.LC147:
	.string	"chaselock"
	.align 2
.LC148:
	.string	"camzoomout"
	.align 2
.LC149:
	.string	"out"
	.align 2
.LC150:
	.string	"camzoomin"
	.align 2
.LC151:
	.string	"in"
	.align 2
.LC152:
	.string	"speak"
	.align 2
.LC153:
	.string	"cd"
	.align 2
.LC154:
	.string	"cd.."
	.align 2
.LC155:
	.string	".."
	.align 2
.LC156:
	.string	"cat"
	.align 2
.LC157:
	.string	"pass"
	.align 2
.LC158:
	.string	"update"
	.align 2
.LC159:
	.string	"rel"
	.align 2
.LC160:
	.string	"run"
	.align 2
.LC161:
	.string	"add"
	.align 2
.LC162:
	.string	"team"
	.align 2
.LC163:
	.string	"id"
	.align 2
.LC164:
	.string	"save_nodes"
	.align 2
.LC165:
	.string	"load_nodes"
	.align 2
.LC166:
	.string	"show_nodes"
	.align 2
.LC167:
	.string	"show_all_nodes"
	.align 2
.LC168:
	.string	"mapping"
	.align 2
.LC169:
	.string	"nodetest"
	.align 2
.LC170:
	.string	"vehicle"
	.align 2
.LC171:
	.string	"bot"
	.align 2
.LC172:
	.string	"forcelevel"
	.align 2
.LC173:
	.string	"giveforce"
	.align 2
.LC174:
	.string	"duel"
	.align 2
.LC175:
	.string	"Duel Mode Off\n"
	.align 2
.LC176:
	.string	"Duel Mode On\n"
	.align 2
.LC177:
	.string	"Duel Function removed on Red Knight's Request\n"
	.align 2
.LC178:
	.string	"noreload"
	.align 2
.LC179:
	.string	"credits"
	.align 2
.LC180:
	.string	"choose"
	.align 2
.LC181:
	.string	"mouse"
	.align 2
.LC182:
	.string	"rk"
	.align 2
.LC183:
	.string	"taunt"
	.align 2
.LC184:
	.string	"color"
	.align 2
.LC185:
	.long 0x0
	.align 2
.LC186:
	.long 0x40a00000
	.align 3
.LC187:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ClientCommand
	.type	 ClientCommand,@function
ClientCommand:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	mr 31,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L485
	lis 9,gi@ha
	li 3,0
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	mr 29,3
	lis 4,.LC113@ha
	la 4,.LC113@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L487
	mr 3,31
	bl Cmd_Players_f
	b .L485
.L487:
	lis 4,.LC114@ha
	mr 3,29
	la 4,.LC114@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L488
	mr 3,31
	li 4,0
	b .L754
.L488:
	lis 4,.LC115@ha
	mr 3,29
	la 4,.LC115@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L489
	mr 3,31
	li 4,1
.L754:
	li 5,0
	bl Cmd_Say_f
	b .L485
.L489:
	lis 4,.LC116@ha
	mr 3,29
	la 4,.LC116@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L490
	mr 3,31
	bl Cmd_Score_f
	b .L485
.L490:
	lis 4,.LC117@ha
	mr 3,29
	la 4,.LC117@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L491
	mr 3,31
	bl Cmd_Help_f
	b .L485
.L491:
	lis 8,.LC185@ha
	lis 9,level+200@ha
	la 8,.LC185@l(8)
	lfs 0,level+200@l(9)
	lfs 31,0(8)
	fcmpu 0,0,31
	bc 4,2,.L485
	lis 4,.LC118@ha
	mr 3,29
	la 4,.LC118@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L493
	lwz 0,164(30)
	mtlr 0
	blrl
	mr 29,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L494
	lis 5,.LC86@ha
	mr 3,31
	la 5,.LC86@l(5)
	b .L755
.L494:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L496
	lis 5,.LC87@ha
	mr 3,31
	la 5,.LC87@l(5)
	b .L756
.L496:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L497
	lis 5,.LC88@ha
	mr 3,31
	la 5,.LC88@l(5)
.L755:
	mr 6,29
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L485
.L497:
	mr 3,31
	mtlr 10
	blrl
	b .L485
.L493:
	lis 4,.LC119@ha
	mr 3,29
	la 4,.LC119@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L499
	mr 3,31
	bl Cmd_Drop_f
	b .L485
.L499:
	lis 4,.LC120@ha
	mr 3,29
	la 4,.LC120@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L501
	mr 3,31
	bl Cmd_Give_f
	b .L485
.L501:
	lis 4,.LC121@ha
	mr 3,29
	la 4,.LC121@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L503
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L504
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L504
	lis 5,.LC38@ha
	mr 3,31
	la 5,.LC38@l(5)
	b .L756
.L504:
	lwz 0,264(31)
	xori 0,0,16
	andi. 8,0,16
	stw 0,264(31)
	bc 4,2,.L506
	lis 9,.LC80@ha
	la 5,.LC80@l(9)
	b .L507
.L506:
	lis 9,.LC81@ha
	la 5,.LC81@l(9)
.L507:
	mr 3,31
	b .L756
.L503:
	lis 4,.LC122@ha
	mr 3,29
	la 4,.LC122@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L509
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L510
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L510
	lis 5,.LC38@ha
	mr 3,31
	la 5,.LC38@l(5)
	b .L756
.L510:
	lwz 0,264(31)
	xori 0,0,32
	andi. 8,0,32
	stw 0,264(31)
	bc 4,2,.L512
	lis 9,.LC82@ha
	la 5,.LC82@l(9)
	b .L513
.L512:
	lis 9,.LC83@ha
	la 5,.LC83@l(9)
.L513:
	mr 3,31
	b .L756
.L509:
	lis 4,.LC123@ha
	mr 3,29
	la 4,.LC123@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L515
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L516
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L516
	lis 5,.LC38@ha
	mr 3,31
	la 5,.LC38@l(5)
	b .L756
.L516:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 4,2,.L518
	li 0,4
	lis 9,.LC84@ha
	stw 0,260(31)
	la 5,.LC84@l(9)
	b .L519
.L518:
	li 0,1
	lis 9,.LC85@ha
	stw 0,260(31)
	la 5,.LC85@l(9)
.L519:
	mr 3,31
	b .L756
.L515:
	lis 4,.LC124@ha
	mr 3,29
	la 4,.LC124@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L521
	lwz 29,84(31)
	stw 3,4120(29)
	stw 3,4112(29)
	lwz 9,84(31)
	lwz 9,4760(9)
	cmpwi 0,9,0
	bc 12,2,.L522
	mr 3,31
	bl PMenu_Close
	b .L604
.L522:
	lwz 0,4116(29)
	cmpwi 0,0,0
	bc 12,2,.L524
	stw 9,4116(29)
	b .L485
.L524:
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L525
	lwz 0,4048(29)
	cmpwi 0,0,0
	bc 4,2,.L525
	mr 3,31
	bl CTFOpenJoinMenu
	b .L485
.L525:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,4116(29)
	li 3,5
	lwz 0,100(9)
	addi 28,29,1760
	mr 30,9
	addi 29,29,740
	mtlr 0
	blrl
.L528:
	lwz 9,104(30)
	lwz 3,0(29)
	mtlr 9
	addi 29,29,4
	blrl
	cmpw 0,29,28
	bc 4,1,.L528
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	b .L757
.L521:
	lis 4,.LC125@ha
	mr 3,29
	la 4,.LC125@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L532
	mr 3,31
	li 4,-1
	bl SelectNextItem
	b .L485
.L532:
	lis 4,.LC126@ha
	mr 3,29
	la 4,.LC126@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L534
	mr 3,31
	li 4,-1
	bl SelectPrevItem
	b .L485
.L534:
	lis 4,.LC127@ha
	mr 3,29
	la 4,.LC127@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L536
	mr 3,31
	li 4,1
	bl SelectNextItem
	b .L485
.L536:
	lis 4,.LC128@ha
	mr 3,29
	la 4,.LC128@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L538
	mr 3,31
	li 4,1
	bl SelectPrevItem
	b .L485
.L538:
	lis 4,.LC129@ha
	mr 3,29
	la 4,.LC129@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L540
	mr 3,31
	li 4,32
	bl SelectNextItem
	b .L485
.L540:
	lis 4,.LC130@ha
	mr 3,29
	la 4,.LC130@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L542
	mr 3,31
	li 4,32
	bl SelectPrevItem
	b .L485
.L542:
	lis 4,.LC131@ha
	mr 3,29
	la 4,.LC131@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L544
	lwz 9,84(31)
	lwz 0,4760(9)
	cmpwi 0,0,0
	bc 12,2,.L545
	mr 3,31
	bl PMenu_Select
	b .L485
.L545:
	lis 9,holdthephone@ha
	lwz 0,holdthephone@l(9)
	cmpwi 0,0,1
	bc 4,2,.L547
	lis 9,NoTouch@ha
	lwz 0,NoTouch@l(9)
	cmpwi 0,0,0
	bc 4,2,.L547
	bl IChooseYou
	b .L485
.L547:
	lwz 9,84(31)
	lwz 0,736(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,2,.L550
	mr 3,31
	li 4,-1
	bl SelectNextItem
.L550:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L551
	lis 5,.LC91@ha
	mr 3,31
	la 5,.LC91@l(5)
	b .L756
.L551:
	mulli 0,0,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L559
	lis 5,.LC87@ha
	mr 3,31
	la 5,.LC87@l(5)
	b .L756
.L544:
	lis 4,.LC132@ha
	mr 3,29
	la 4,.LC132@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L554
	lwz 9,84(31)
	lwz 0,736(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,2,.L556
	mr 3,31
	li 4,-1
	bl SelectNextItem
.L556:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L557
	lis 5,.LC92@ha
	mr 3,31
	la 5,.LC92@l(5)
	b .L756
.L557:
	mulli 0,0,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L559
	lis 5,.LC90@ha
	mr 3,31
	la 5,.LC90@l(5)
	b .L756
.L559:
	mr 3,31
.L757:
	mtlr 0
	blrl
	b .L485
.L554:
	lis 4,.LC133@ha
	mr 3,29
	la 4,.LC133@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L561
	lis 11,saberonly@ha
	lis 8,.LC185@ha
	lwz 30,84(31)
	lwz 9,saberonly@l(11)
	la 8,.LC185@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L485
	lwz 11,1764(30)
	cmpwi 0,11,0
	bc 12,2,.L485
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 28,1
	subf 9,9,11
	addi 26,30,740
	mullw 9,9,0
	srawi 27,9,2
.L567:
	add 11,27,28
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L569
	mulli 0,11,76
	add 29,0,25
	lwz 9,8(29)
	cmpwi 0,9,0
	bc 12,2,.L569
	lwz 0,56(29)
	andi. 10,0,1
	bc 12,2,.L569
	mr 3,31
	mr 4,29
	mtlr 9
	blrl
	lwz 0,1764(30)
	cmpw 0,0,29
	bc 12,2,.L485
.L569:
	addi 28,28,1
	cmpwi 0,28,256
	bc 4,1,.L567
	b .L485
.L561:
	lis 4,.LC134@ha
	mr 3,29
	la 4,.LC134@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L575
	lis 11,saberonly@ha
	lis 8,.LC185@ha
	lwz 27,84(31)
	lwz 9,saberonly@l(11)
	la 8,.LC185@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L485
	lwz 11,1764(27)
	cmpwi 0,11,0
	bc 12,2,.L485
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,27,740
	mullw 9,9,0
	srawi 9,9,2
	addi 28,9,255
.L581:
	srawi 0,28,31
	srwi 0,0,24
	add 0,28,0
	rlwinm 0,0,0,0,23
	subf 11,0,28
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L583
	mulli 0,11,76
	add 29,0,25
	lwz 9,8(29)
	cmpwi 0,9,0
	bc 12,2,.L583
	lwz 0,56(29)
	andi. 10,0,1
	bc 12,2,.L583
	mr 3,31
	mr 4,29
	mtlr 9
	blrl
	lwz 0,1764(27)
	cmpw 0,0,29
	bc 12,2,.L485
.L583:
	addi 30,30,1
	addi 28,28,-1
	cmpwi 0,30,256
	bc 4,1,.L581
	b .L485
.L575:
	lis 4,.LC135@ha
	mr 3,29
	la 4,.LC135@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L589
	lis 11,saberonly@ha
	lis 8,.LC185@ha
	lwz 10,84(31)
	lwz 9,saberonly@l(11)
	la 8,.LC185@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L485
	lwz 0,1764(10)
	cmpwi 0,0,0
	bc 12,2,.L485
	lwz 0,1768(10)
	cmpwi 0,0,0
	bc 12,2,.L485
	lis 11,itemlist@ha
	lis 9,0x286b
	la 4,itemlist@l(11)
	ori 9,9,51739
	subf 0,4,0
	addi 11,10,740
	mullw 0,0,9
	srawi 10,0,2
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L485
	mulli 0,10,76
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L485
	lwz 0,56(4)
	andi. 10,0,1
	bc 12,2,.L485
	mr 3,31
	mtlr 9
	blrl
	b .L485
.L589:
	lis 4,.LC136@ha
	mr 3,29
	la 4,.LC136@l(4)
	bl Q_stricmp
	mr. 10,3
	bc 4,2,.L598
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L485
	lwz 11,84(31)
	lis 9,level+4@ha
	lis 8,.LC186@ha
	lfs 0,level+4@l(9)
	la 8,.LC186@l(8)
	lfs 13,4404(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L485
	lwz 0,264(31)
	mr 3,31
	lis 11,meansOfDeath@ha
	stw 10,480(31)
	li 9,23
	lis 6,0x1
	rlwinm 0,0,0,28,26
	lis 7,vec3_origin@ha
	stw 0,264(31)
	la 7,vec3_origin@l(7)
	mr 4,3
	stw 9,meansOfDeath@l(11)
	mr 5,3
	ori 6,6,34464
	bl player_die
	b .L485
.L598:
	lis 4,.LC137@ha
	mr 3,29
	la 4,.LC137@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L603
	lwz 9,84(31)
	stw 3,4112(9)
	lwz 11,84(31)
	stw 3,4120(11)
	lwz 9,84(31)
	stw 3,4116(9)
	lwz 11,84(31)
	lwz 0,4760(11)
	cmpwi 0,0,0
	bc 12,2,.L604
	mr 3,31
	bl PMenu_Close
.L604:
	lwz 9,84(31)
	li 0,1
	stw 0,4412(9)
	b .L485
.L603:
	lis 4,.LC138@ha
	mr 3,29
	la 4,.LC138@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L607
	mr 3,31
	bl Cmd_PlayerList_f
	b .L485
.L607:
	lis 4,.LC139@ha
	mr 3,29
	la 4,.LC139@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L609
	mr 3,31
	bl Cmd_OpenDoor
	b .L485
.L609:
	lis 4,.LC140@ha
	mr 3,29
	la 4,.LC140@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L611
	lwz 9,84(31)
	mr 3,31
	li 4,1
	lwz 0,4132(9)
	ori 0,0,1
	stw 0,4132(9)
	bl Think_Weapon
	b .L485
.L611:
	lis 4,.LC141@ha
	mr 3,29
	la 4,.LC141@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L614
	lis 11,saberonly@ha
	lis 8,.LC185@ha
	lwz 9,saberonly@l(11)
	la 8,.LC185@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L485
	lwz 9,84(31)
	li 0,12
	mr 3,31
	li 4,0
	stw 0,4432(9)
	bl Think_Weapon
	b .L485
.L614:
	lis 4,.LC142@ha
	mr 3,29
	la 4,.LC142@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L618
	mr 3,31
	bl sniper_zoom
	b .L485
.L618:
	lis 4,.LC143@ha
	mr 3,29
	la 4,.LC143@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L620
	mr 3,31
	bl cmd_force_info
	b .L485
.L620:
	lis 4,.LC71@ha
	mr 3,29
	la 4,.LC71@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L622
	mr 3,31
	bl cmd_Force_Menu
	b .L485
.L622:
	lis 4,.LC144@ha
	mr 3,29
	la 4,.LC144@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L624
	mr 3,31
	bl cmd_Weapon_Menu
	b .L485
.L624:
	lis 4,.LC145@ha
	mr 3,29
	la 4,.LC145@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L626
	lis 11,saberonly@ha
	lis 8,.LC185@ha
	lwz 9,saberonly@l(11)
	la 8,.LC185@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L485
	lhz 0,926(31)
	cmpwi 0,0,0
	bc 4,2,.L629
	lwz 9,84(31)
	li 0,2
	lis 3,.LC30@ha
	sth 0,926(31)
	la 3,.LC30@l(3)
	lwz 0,1764(9)
	stw 0,928(31)
	bl FindItem
	lwz 9,84(31)
	stw 3,4148(9)
	mr 3,31
	bl ChasecamStart
	b .L485
.L629:
	cmpwi 0,0,1
	bc 4,2,.L485
	lwz 9,84(31)
	li 11,3
	lis 4,.LC14@ha
	lwz 0,928(31)
	mr 3,31
	la 4,.LC14@l(4)
	stw 0,4148(9)
	sth 11,926(31)
	bl ChasecamRemove
	b .L485
.L626:
	lis 4,.LC146@ha
	mr 3,29
	la 4,.LC146@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L634
	mr 3,31
	bl Cmd_Chasecam_Toggle
	b .L485
.L634:
	lis 4,.LC147@ha
	mr 3,29
	la 4,.LC147@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L636
	lis 4,.LC109@ha
	mr 3,31
	la 4,.LC109@l(4)
	bl Cmd_Chasecam_Viewlock
	b .L485
.L636:
	lis 4,.LC148@ha
	mr 3,29
	la 4,.LC148@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L638
	lis 4,.LC149@ha
	mr 3,31
	la 4,.LC149@l(4)
	bl Cmd_Chasecam_Zoom
	b .L485
.L638:
	lis 4,.LC150@ha
	mr 3,29
	la 4,.LC150@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L640
	lis 4,.LC151@ha
	mr 3,31
	la 4,.LC151@l(4)
	bl Cmd_Chasecam_Zoom
	b .L485
.L640:
	lis 4,.LC152@ha
	mr 3,29
	la 4,.LC152@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L642
	mr 3,31
	mr 4,3
	bl JustTalk
	b .L485
.L642:
	lis 4,.LC153@ha
	mr 3,29
	la 4,.LC153@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L644
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L485
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,31
	bl Computer_Change_Dir
	b .L485
.L644:
	lis 4,.LC154@ha
	mr 3,29
	la 4,.LC154@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L648
	lis 3,.LC155@ha
	mr 4,31
	la 3,.LC155@l(3)
	bl Computer_Change_Dir
	b .L485
.L648:
	lis 4,.LC156@ha
	mr 3,29
	la 4,.LC156@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L650
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L485
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,31
	bl Computer_Cat
	b .L485
.L650:
	lis 4,.LC157@ha
	mr 3,29
	la 4,.LC157@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L654
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L485
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,31
	bl Computer_Pass
	b .L485
.L654:
	lis 4,.LC158@ha
	mr 3,29
	la 4,.LC158@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L659
	lis 4,.LC159@ha
	mr 3,29
	la 4,.LC159@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L658
.L659:
	mr 3,31
	bl Computer_Dir
	b .L485
.L658:
	lis 4,.LC160@ha
	mr 3,29
	la 4,.LC160@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L662
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L485
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,31
	bl Computer_Exec
	b .L485
.L662:
	lis 4,.LC161@ha
	mr 3,29
	la 4,.LC161@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L666
	lwz 9,960(31)
	addi 9,9,1
	stw 9,960(31)
	b .L485
.L666:
	lis 4,.LC162@ha
	mr 3,29
	la 4,.LC162@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L668
	mr 3,31
	bl CTFTeam_f
	b .L485
.L668:
	lis 4,.LC163@ha
	mr 3,29
	la 4,.LC163@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L670
	mr 3,31
	bl CTFID_f
	b .L485
.L670:
	lis 4,.LC164@ha
	mr 3,29
	la 4,.LC164@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L672
	bl cmd_Save_f
	b .L485
.L672:
	lis 4,.LC165@ha
	mr 3,29
	la 4,.LC165@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L674
	bl cmd_Load_f
	b .L485
.L674:
	lis 4,.LC166@ha
	mr 3,29
	la 4,.LC166@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L676
	mr 3,31
	bl show_visible_nodes
	b .L485
.L676:
	lis 4,.LC167@ha
	mr 3,29
	la 4,.LC167@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L678
	bl show_nodes
	b .L485
.L678:
	lis 4,.LC168@ha
	mr 3,29
	la 4,.LC168@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L680
	bl mapping_toggle
	b .L485
.L680:
	lis 4,.LC169@ha
	mr 3,29
	la 4,.LC169@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L682
	mr 3,31
	bl create_nodetest
	b .L485
.L682:
	lis 4,.LC170@ha
	mr 3,29
	la 4,.LC170@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L684
	lis 9,gi@ha
	la 30,gi@l(9)
	lwz 9,156(30)
	mtlr 9
	blrl
	addi 0,3,-1
	li 11,-1
	cmpwi 7,0,1
	xori 3,3,1
	subfic 8,3,0
	adde 3,8,3
	mfcr 0
	rlwinm 0,0,30,1
	or. 9,3,0
	bc 12,2,.L685
	lis 5,.LC20@ha
	mr 3,31
	la 5,.LC20@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lis 5,.LC21@ha
	mr 3,31
	la 5,.LC21@l(5)
	b .L756
.L685:
	bc 4,30,.L687
	lwz 0,160(30)
	li 3,1
	mtlr 0
	blrl
	bl atoi
	mr 11,3
.L687:
	cmpwi 0,11,1
	bc 12,2,.L688
	bc 12,1,.L485
	cmpwi 0,11,0
	bc 4,2,.L485
	lwz 9,84(31)
	stw 11,4740(9)
	b .L485
.L688:
	mr 3,31
	bl Cmd_sbike
	b .L485
.L684:
	lis 4,.LC171@ha
	mr 3,29
	la 4,.LC171@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L697
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	lwz 0,160(29)
	mr 28,3
	li 3,2
	mtlr 0
	blrl
	mr 4,3
	mr 3,28
	bl Spawn_New_Bot
	b .L485
.L697:
	lis 4,.LC172@ha
	mr 3,29
	la 4,.LC172@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L700
	mr 3,31
	bl Cmd_Set_Force_Level
	b .L485
.L700:
	lis 4,.LC173@ha
	mr 3,29
	la 4,.LC173@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L702
	lwz 11,84(31)
	li 0,1
	lis 10,0x4348
	mr 3,31
	stw 0,4612(11)
	lwz 9,84(31)
	stw 0,1860(9)
	lwz 11,84(31)
	stw 10,1988(11)
	lwz 9,84(31)
	stw 0,1864(9)
	lwz 11,84(31)
	stw 10,1992(11)
	lwz 9,84(31)
	stw 0,1884(9)
	lwz 11,84(31)
	stw 10,2012(11)
	lwz 9,84(31)
	stw 0,1924(9)
	lwz 11,84(31)
	stw 10,2052(11)
	bl calc_subgroup_values
	mr 3,31
	bl calc_darklight_value
	mr 3,31
	bl calc_top_level_value
	lwz 9,84(31)
	lfs 1,1952(9)
	fadds 1,1,1
	bl ceil
	fctiwz 0,1
	lwz 11,84(31)
	mr 3,31
	stfd 0,16(1)
	lwz 9,20(1)
	sth 9,1948(11)
	bl sort_useable_powers
	b .L485
.L702:
	lis 4,.LC174@ha
	mr 3,29
	la 4,.LC174@l(4)
	bl Q_stricmp
	mr. 10,3
	bc 4,2,.L705
	lis 11,advanced@ha
	lis 8,.LC185@ha
	lwz 9,advanced@l(11)
	la 8,.LC185@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L485
	lwz 3,84(31)
	lwz 0,4436(3)
	cmpwi 0,0,1
	bc 4,2,.L707
	lis 4,.LC175@ha
	stw 10,4436(3)
	li 3,2
	la 4,.LC175@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L708
.L707:
	li 0,1
	lis 4,.LC176@ha
	stw 0,4436(3)
	la 4,.LC176@l(4)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
.L708:
	lis 9,gi+4@ha
	lis 3,.LC177@ha
	lwz 0,gi+4@l(9)
	la 3,.LC177@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L485
.L705:
	lis 4,.LC178@ha
	mr 3,29
	la 4,.LC178@l(4)
	bl Q_stricmp
	mr. 30,3
	bc 4,2,.L710
	lwz 9,84(31)
	lwz 0,4440(9)
	cmpwi 0,0,0
	bc 12,2,.L711
	lis 5,.LC18@ha
	mr 3,31
	la 5,.LC18@l(5)
	li 4,1
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	stw 30,4440(9)
	b .L485
.L711:
	lis 5,.LC19@ha
	mr 3,31
	la 5,.LC19@l(5)
	li 4,1
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,1
	stw 0,4440(9)
	b .L485
.L710:
	lis 4,.LC179@ha
	mr 3,29
	la 4,.LC179@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L715
	lis 9,showingit@ha
	lwz 0,showingit@l(9)
	cmpwi 0,0,1
	bc 4,2,.L716
	stw 3,showingit@l(9)
	b .L485
.L716:
	li 0,1
	stw 0,showingit@l(9)
	b .L485
.L715:
	lis 4,.LC180@ha
	mr 3,29
	la 4,.LC180@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L719
	lis 11,theforce@ha
	lis 8,.LC185@ha
	lwz 9,theforce@l(11)
	la 8,.LC185@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L485
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L485
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 29,3
	lis 4,.LC67@ha
	la 4,.LC67@l(4)
	li 5,4
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L722
	mr 3,31
	bl watchmesing
	lwz 9,84(31)
	li 0,11
	stw 0,4080(9)
	b .L485
.L722:
	lis 4,.LC68@ha
	mr 3,29
	la 4,.LC68@l(4)
	li 5,5
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L724
	mr 3,31
	bl imabigchicken
	lwz 9,84(31)
	li 0,12
	stw 0,4080(9)
	b .L485
.L724:
	lis 4,.LC69@ha
	mr 3,29
	la 4,.LC69@l(4)
	li 5,4
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L726
	mr 3,31
	bl googl3
	lwz 9,84(31)
	li 0,13
	stw 0,4080(9)
	b .L485
.L726:
	lis 5,.LC70@ha
	mr 3,31
	la 5,.LC70@l(5)
.L756:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L485
.L719:
	lis 4,.LC181@ha
	mr 3,29
	la 4,.LC181@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L730
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 4,2,.L731
	lis 5,.LC13@ha
	mr 3,31
	la 5,.LC13@l(5)
	b .L758
.L731:
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 29,3
	lis 4,.LC14@ha
	la 4,.LC14@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L734
	lwz 9,84(31)
	li 0,0
	lis 5,.LC15@ha
	mr 3,31
	la 5,.LC15@l(5)
	stw 0,4824(9)
.L758:
	li 4,1
	crxor 6,6,6
	bl safe_cprintf
	b .L485
.L734:
	mr 3,29
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(31)
	stw 3,20(1)
	lis 0,0x4330
	lis 8,.LC187@ha
	stw 0,16(1)
	la 8,.LC187@l(8)
	lis 4,.LC16@ha
	lfd 0,16(1)
	mr 3,31
	la 4,.LC16@l(4)
	lfd 13,0(8)
	fsub 0,0,13
	frsp 0,0
	stfs 0,4824(11)
	lwz 9,84(31)
	lfs 1,4824(9)
	creqv 6,6,6
	bl _stuffcmd
	lwz 9,84(31)
	lis 5,.LC17@ha
	mr 3,31
	la 5,.LC17@l(5)
	li 4,1
	lfs 1,4824(9)
	creqv 6,6,6
	bl safe_cprintf
	b .L485
.L730:
	lis 4,.LC182@ha
	mr 3,29
	la 4,.LC182@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L737
	lwz 9,84(31)
	li 0,1
	li 7,1
	lis 8,0x447a
	li 10,4
	stw 0,4612(9)
	li 0,22
	mtctr 0
.L753:
	lwz 9,84(31)
	addi 9,9,1856
	stwx 7,9,10
	lwz 11,84(31)
	addi 11,11,1984
	stwx 8,11,10
	addi 10,10,4
	bdnz .L753
	mr 3,31
	bl calc_subgroup_values
	mr 3,31
	bl calc_darklight_value
	mr 3,31
	bl calc_top_level_value
	lwz 9,84(31)
	lfs 1,1952(9)
	fadds 1,1,1
	bl ceil
	fctiwz 0,1
	lwz 11,84(31)
	mr 3,31
	stfd 0,16(1)
	lwz 9,20(1)
	sth 9,1948(11)
	bl sort_useable_powers
	lwz 11,84(31)
	lis 0,0x4120
	li 10,1000
	stw 0,4456(11)
	lwz 9,84(31)
	sth 10,1948(9)
	b .L485
.L737:
	lis 4,.LC183@ha
	mr 3,29
	la 4,.LC183@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L745
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L485
	lis 3,.LC12@ha
	lwz 29,84(31)
	la 3,.LC12@l(3)
	bl FindItem
	lwz 0,1764(29)
	cmpw 0,0,3
	bc 4,2,.L748
	lwz 9,84(31)
	li 0,369
	li 11,384
	b .L759
.L748:
	lwz 9,84(31)
	li 0,175
	li 11,190
.L759:
	stw 0,56(31)
	stw 11,4308(9)
	b .L485
.L745:
	lis 4,.LC184@ha
	mr 3,29
	la 4,.LC184@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L751
	mr 3,31
	bl Cmd_Saber_Color
	b .L485
.L751:
	mr 3,31
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L485:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe24:
	.size	 ClientCommand,.Lfe24-ClientCommand
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
	.globl Cmd_Change_Dir
	.type	 Cmd_Change_Dir,@function
Cmd_Change_Dir:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi@ha
	mr 30,3
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L47
	lwz 0,164(31)
	mtlr 0
	blrl
	mr 4,30
	bl Computer_Change_Dir
.L47:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 Cmd_Change_Dir,.Lfe25-Cmd_Change_Dir
	.align 2
	.globl Cmd_Cat
	.type	 Cmd_Cat,@function
Cmd_Cat:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi@ha
	mr 30,3
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L49
	lwz 0,164(31)
	mtlr 0
	blrl
	mr 4,30
	bl Computer_Cat
.L49:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe26:
	.size	 Cmd_Cat,.Lfe26-Cmd_Cat
	.align 2
	.globl Cmd_Dir
	.type	 Cmd_Dir,@function
Cmd_Dir:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl Computer_Dir
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe27:
	.size	 Cmd_Dir,.Lfe27-Cmd_Dir
	.align 2
	.globl Cmd_Change_Pass
	.type	 Cmd_Change_Pass,@function
Cmd_Change_Pass:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi@ha
	mr 30,3
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L51
	lwz 0,164(31)
	mtlr 0
	blrl
	mr 4,30
	bl Computer_Pass
.L51:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe28:
	.size	 Cmd_Change_Pass,.Lfe28-Cmd_Change_Pass
	.align 2
	.globl Cmd_Exec
	.type	 Cmd_Exec,@function
Cmd_Exec:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi@ha
	mr 30,3
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L54
	lwz 0,164(31)
	mtlr 0
	blrl
	mr 4,30
	bl Computer_Exec
.L54:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe29:
	.size	 Cmd_Exec,.Lfe29-Cmd_Exec
	.align 2
	.globl Cmd_Set_AutoReload
	.type	 Cmd_Set_AutoReload,@function
Cmd_Set_AutoReload:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4440(9)
	cmpwi 0,0,0
	bc 12,2,.L56
	lis 5,.LC18@ha
	la 5,.LC18@l(5)
	li 4,1
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,0
	b .L760
.L56:
	lis 5,.LC19@ha
	mr 3,31
	la 5,.LC19@l(5)
	li 4,1
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,1
.L760:
	stw 0,4440(9)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe30:
	.size	 Cmd_Set_AutoReload,.Lfe30-Cmd_Set_AutoReload
	.align 2
	.globl Cmd_vehicle_f
	.type	 Cmd_vehicle_f,@function
Cmd_vehicle_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi@ha
	mr 31,3
	la 30,gi@l(9)
	lwz 9,156(30)
	mtlr 9
	blrl
	addi 0,3,-1
	li 11,-1
	cmpwi 7,0,1
	xori 3,3,1
	subfic 9,3,0
	adde 3,9,3
	mfcr 0
	rlwinm 0,0,30,1
	or. 9,3,0
	bc 12,2,.L59
	lis 5,.LC20@ha
	mr 3,31
	la 5,.LC20@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lis 5,.LC21@ha
	mr 3,31
	la 5,.LC21@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L58
.L59:
	bc 4,30,.L60
	lwz 0,160(30)
	li 3,1
	mtlr 0
	blrl
	bl atoi
	mr 11,3
.L60:
	cmpwi 0,11,1
	bc 12,2,.L63
	bc 12,1,.L58
	cmpwi 0,11,0
	bc 4,2,.L58
	lwz 9,84(31)
	stw 11,4740(9)
	b .L58
.L63:
	mr 3,31
	bl Cmd_sbike
.L58:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe31:
	.size	 Cmd_vehicle_f,.Lfe31-Cmd_vehicle_f
	.section	".rodata"
	.align 2
.LC188:
	.long 0x0
	.section	".text"
	.align 2
	.globl cmd_holster
	.type	 cmd_holster,@function
cmd_holster:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC188@ha
	lis 9,saberonly@ha
	la 11,.LC188@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,saberonly@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L72
	lhz 0,926(31)
	cmpwi 0,0,0
	bc 4,2,.L74
	lwz 9,84(31)
	li 0,2
	lis 3,.LC30@ha
	sth 0,926(31)
	la 3,.LC30@l(3)
	lwz 0,1764(9)
	stw 0,928(31)
	bl FindItem
	lwz 9,84(31)
	stw 3,4148(9)
	mr 3,31
	bl ChasecamStart
	b .L72
.L74:
	cmpwi 0,0,1
	bc 4,2,.L72
	lwz 9,84(31)
	li 11,3
	lis 4,.LC14@ha
	lwz 0,928(31)
	mr 3,31
	la 4,.LC14@l(4)
	stw 0,4148(9)
	sth 11,926(31)
	bl ChasecamRemove
.L72:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe32:
	.size	 cmd_holster,.Lfe32-cmd_holster
	.align 2
	.globl Cmd_Secondary_Fire
	.type	 Cmd_Secondary_Fire,@function
Cmd_Secondary_Fire:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	li 4,1
	lwz 0,4132(9)
	ori 0,0,1
	stw 0,4132(9)
	bl Think_Weapon
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe33:
	.size	 Cmd_Secondary_Fire,.Lfe33-Cmd_Secondary_Fire
	.align 2
	.globl Cmd_Set_Force_Useable
	.type	 Cmd_Set_Force_Useable,@function
Cmd_Set_Force_Useable:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	li 0,1
	lwz 11,84(29)
	lis 10,0x4348
	stw 0,4612(11)
	lwz 9,84(29)
	stw 0,1860(9)
	lwz 11,84(29)
	stw 10,1988(11)
	lwz 9,84(29)
	stw 0,1864(9)
	lwz 11,84(29)
	stw 10,1992(11)
	lwz 9,84(29)
	stw 0,1884(9)
	lwz 11,84(29)
	stw 10,2012(11)
	lwz 9,84(29)
	stw 0,1924(9)
	lwz 11,84(29)
	stw 10,2052(11)
	bl calc_subgroup_values
	mr 3,29
	bl calc_darklight_value
	mr 3,29
	bl calc_top_level_value
	lwz 9,84(29)
	lfs 1,1952(9)
	fadds 1,1,1
	bl ceil
	fctiwz 0,1
	lwz 11,84(29)
	mr 3,29
	stfd 0,24(1)
	lwz 9,28(1)
	sth 9,1948(11)
	bl sort_useable_powers
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe34:
	.size	 Cmd_Set_Force_Useable,.Lfe34-Cmd_Set_Force_Useable
	.section	".rodata"
	.align 2
.LC189:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Reload
	.type	 Cmd_Reload,@function
Cmd_Reload:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC189@ha
	lis 9,saberonly@ha
	la 11,.LC189@l(11)
	lfs 13,0(11)
	lwz 11,saberonly@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L88
	lwz 9,84(3)
	li 0,12
	li 4,0
	stw 0,4432(9)
	bl Think_Weapon
.L88:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe35:
	.size	 Cmd_Reload,.Lfe35-Cmd_Reload
	.align 2
	.globl ClientTeam
	.type	 ClientTeam,@function
ClientTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 9,value.84@ha
	li 30,0
	stb 30,value.84@l(9)
	la 31,value.84@l(9)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L762
	lis 4,.LC66@ha
	addi 3,3,188
	la 4,.LC66@l(4)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L762
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L157
	addi 3,3,1
	b .L761
.L157:
	stb 30,0(3)
.L762:
	mr 3,31
.L761:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 ClientTeam,.Lfe36-ClientTeam
	.align 2
	.globl ValidateSelectedItem
	.type	 ValidateSelectedItem,@function
ValidateSelectedItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,736(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,2,.L211
	li 4,-1
	bl SelectNextItem
.L211:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 ValidateSelectedItem,.Lfe37-ValidateSelectedItem
	.section	".rodata"
	.align 2
.LC190:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Set_Affiliation
	.type	 Cmd_Set_Affiliation,@function
Cmd_Set_Affiliation:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 11,.LC190@ha
	lis 9,theforce@ha
	la 11,.LC190@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,theforce@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L214
	lis 9,gi@ha
	la 30,gi@l(9)
	lwz 9,156(30)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L214
	lwz 0,164(30)
	mtlr 0
	blrl
	mr 30,3
	lis 4,.LC67@ha
	la 4,.LC67@l(4)
	li 5,4
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L216
	mr 3,31
	bl watchmesing
	lwz 9,84(31)
	li 0,11
	stw 0,4080(9)
	b .L214
.L216:
	lis 4,.LC68@ha
	mr 3,30
	la 4,.LC68@l(4)
	li 5,5
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L218
	mr 3,31
	bl imabigchicken
	lwz 9,84(31)
	li 0,12
	stw 0,4080(9)
	b .L214
.L218:
	lis 4,.LC69@ha
	mr 3,30
	la 4,.LC69@l(4)
	li 5,4
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L220
	mr 3,31
	bl googl3
	lwz 9,84(31)
	li 0,13
	stw 0,4080(9)
	b .L214
.L220:
	lis 5,.LC70@ha
	mr 3,31
	la 5,.LC70@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L214:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe38:
	.size	 Cmd_Set_Affiliation,.Lfe38-Cmd_Set_Affiliation
	.align 2
	.globl Cmd_RK
	.type	 Cmd_RK,@function
Cmd_RK:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	li 11,22
	mr 31,3
	mtctr 11
	lwz 9,84(31)
	li 0,1
	li 7,1
	lis 8,0x447a
	li 10,4
	stw 0,4612(9)
.L763:
	lwz 9,84(31)
	addi 9,9,1856
	stwx 7,9,10
	lwz 11,84(31)
	addi 11,11,1984
	stwx 8,11,10
	addi 10,10,4
	bdnz .L763
	mr 3,31
	bl calc_subgroup_values
	mr 3,31
	bl calc_darklight_value
	mr 3,31
	bl calc_top_level_value
	lwz 9,84(31)
	lfs 1,1952(9)
	fadds 1,1,1
	bl ceil
	fctiwz 0,1
	lwz 11,84(31)
	mr 3,31
	stfd 0,16(1)
	lwz 9,20(1)
	sth 9,1948(11)
	bl sort_useable_powers
	lwz 11,84(31)
	lis 0,0x4120
	li 10,1000
	stw 0,4456(11)
	lwz 9,84(31)
	sth 10,1948(9)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe39:
	.size	 Cmd_RK,.Lfe39-Cmd_RK
	.section	".rodata"
	.align 2
.LC191:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC191@ha
	lis 9,deathmatch@ha
	la 11,.LC191@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L352
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L352
	lis 5,.LC38@ha
	li 4,2
	la 5,.LC38@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L351
.L352:
	lwz 0,264(3)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(3)
	bc 4,2,.L353
	lis 9,.LC80@ha
	la 5,.LC80@l(9)
	b .L354
.L353:
	lis 9,.LC81@ha
	la 5,.LC81@l(9)
.L354:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L351:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe40:
	.size	 Cmd_God_f,.Lfe40-Cmd_God_f
	.section	".rodata"
	.align 2
.LC192:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC192@ha
	lis 9,deathmatch@ha
	la 11,.LC192@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L356
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L356
	lis 5,.LC38@ha
	li 4,2
	la 5,.LC38@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L355
.L356:
	lwz 0,264(3)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(3)
	bc 4,2,.L357
	lis 9,.LC82@ha
	la 5,.LC82@l(9)
	b .L358
.L357:
	lis 9,.LC83@ha
	la 5,.LC83@l(9)
.L358:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L355:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe41:
	.size	 Cmd_Notarget_f,.Lfe41-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC193:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC193@ha
	lis 9,deathmatch@ha
	la 11,.LC193@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L360
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L360
	lis 5,.LC38@ha
	li 4,2
	la 5,.LC38@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L359
.L360:
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 4,2,.L361
	li 0,4
	lis 9,.LC84@ha
	stw 0,260(3)
	la 5,.LC84@l(9)
	b .L362
.L361:
	li 0,1
	lis 9,.LC85@ha
	stw 0,260(3)
	la 5,.LC85@l(9)
.L362:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L359:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe42:
	.size	 Cmd_Noclip_f,.Lfe42-Cmd_Noclip_f
	.align 2
	.globl Cmd_Use_f
	.type	 Cmd_Use_f,@function
Cmd_Use_f:
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
	bl FindItem
	mr. 4,3
	bc 4,2,.L364
	lis 5,.LC86@ha
	mr 3,31
	la 5,.LC86@l(5)
	b .L764
.L364:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L365
	lis 5,.LC87@ha
	mr 3,31
	la 5,.LC87@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L363
.L365:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L366
	lis 5,.LC88@ha
	mr 3,31
	la 5,.LC88@l(5)
.L764:
	mr 6,30
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L363
.L366:
	mr 3,31
	mtlr 10
	blrl
.L363:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe43:
	.size	 Cmd_Use_f,.Lfe43-Cmd_Use_f
	.section	".rodata"
	.align 2
.LC194:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Inven_f
	.type	 Cmd_Inven_f,@function
Cmd_Inven_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	li 0,0
	lwz 31,84(30)
	stw 0,4120(31)
	stw 0,4112(31)
	lwz 9,84(30)
	lwz 9,4760(9)
	cmpwi 0,9,0
	bc 12,2,.L374
	bl PMenu_Close
	lwz 9,84(30)
	li 0,1
	stw 0,4412(9)
	b .L373
.L374:
	lwz 0,4116(31)
	cmpwi 0,0,0
	bc 12,2,.L375
	stw 9,4116(31)
	b .L373
.L375:
	lis 9,.LC194@ha
	lis 11,ctf@ha
	la 9,.LC194@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L376
	lwz 0,4048(31)
	cmpwi 0,0,0
	bc 4,2,.L376
	mr 3,30
	bl CTFOpenJoinMenu
	b .L373
.L376:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,4116(31)
	li 3,5
	lwz 0,100(9)
	addi 29,31,1760
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L380:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,29
	bc 4,1,.L380
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L373:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe44:
	.size	 Cmd_Inven_f,.Lfe44-Cmd_Inven_f
	.align 2
	.globl Cmd_InvUse_f
	.type	 Cmd_InvUse_f,@function
Cmd_InvUse_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4760(9)
	cmpwi 0,0,0
	bc 12,2,.L383
	bl PMenu_Select
	b .L382
.L383:
	lis 9,holdthephone@ha
	lwz 0,holdthephone@l(9)
	cmpwi 0,0,1
	bc 4,2,.L384
	lis 9,NoTouch@ha
	lwz 0,NoTouch@l(9)
	cmpwi 0,0,0
	bc 4,2,.L384
	bl IChooseYou
	b .L382
.L384:
	lwz 9,84(31)
	lwz 0,736(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,2,.L387
	mr 3,31
	li 4,-1
	bl SelectNextItem
.L387:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L388
	lis 5,.LC91@ha
	mr 3,31
	la 5,.LC91@l(5)
	b .L765
.L388:
	mulli 0,0,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L389
	lis 5,.LC87@ha
	mr 3,31
	la 5,.LC87@l(5)
.L765:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L382
.L389:
	mr 3,31
	mtlr 0
	blrl
.L382:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe45:
	.size	 Cmd_InvUse_f,.Lfe45-Cmd_InvUse_f
	.section	".rodata"
	.align 2
.LC195:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_LastWeap_f
	.type	 Cmd_LastWeap_f,@function
Cmd_LastWeap_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC195@ha
	lis 9,saberonly@ha
	lwz 4,84(3)
	la 11,.LC195@l(11)
	lfs 13,0(11)
	lwz 11,saberonly@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L390
	lwz 0,1764(4)
	cmpwi 0,0,0
	bc 12,2,.L390
	lwz 9,1768(4)
	cmpwi 0,9,0
	bc 12,2,.L390
	lwz 0,8(9)
	mr 4,9
	mtlr 0
	blrl
.L390:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe46:
	.size	 Cmd_LastWeap_f,.Lfe46-Cmd_LastWeap_f
	.section	".rodata"
	.align 2
.LC196:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_WeapPrev_f
	.type	 Cmd_WeapPrev_f,@function
Cmd_WeapPrev_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 11,.LC196@ha
	lis 9,saberonly@ha
	la 11,.LC196@l(11)
	mr 28,3
	lfs 13,0(11)
	lwz 11,saberonly@l(9)
	lwz 29,84(28)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L394
	lwz 11,1764(29)
	cmpwi 0,11,0
	bc 12,2,.L394
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,29,740
	mullw 9,9,0
	srawi 27,9,2
.L400:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L399
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L399
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L399
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1764(29)
	cmpw 0,0,31
	bc 12,2,.L394
.L399:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L400
.L394:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe47:
	.size	 Cmd_WeapPrev_f,.Lfe47-Cmd_WeapPrev_f
	.section	".rodata"
	.align 2
.LC197:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_WeapNext_f
	.type	 Cmd_WeapNext_f,@function
Cmd_WeapNext_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 11,.LC197@ha
	lis 9,saberonly@ha
	la 11,.LC197@l(11)
	mr 27,3
	lfs 13,0(11)
	lwz 11,saberonly@l(9)
	lwz 28,84(27)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L406
	lwz 11,1764(28)
	cmpwi 0,11,0
	bc 12,2,.L406
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 29,1
	subf 9,9,11
	addi 26,28,740
	mullw 9,9,0
	srawi 9,9,2
	addi 30,9,255
.L412:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L411
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L411
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L411
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1764(28)
	cmpw 0,0,31
	bc 12,2,.L406
.L411:
	addi 29,29,1
	addi 30,30,-1
	cmpwi 0,29,256
	bc 4,1,.L412
.L406:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe48:
	.size	 Cmd_WeapNext_f,.Lfe48-Cmd_WeapNext_f
	.section	".rodata"
	.align 2
.LC198:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_WeapLast_f
	.type	 Cmd_WeapLast_f,@function
Cmd_WeapLast_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC198@ha
	lis 9,saberonly@ha
	lwz 10,84(3)
	la 11,.LC198@l(11)
	lfs 13,0(11)
	lwz 11,saberonly@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L418
	lwz 0,1764(10)
	cmpwi 0,0,0
	bc 12,2,.L418
	lwz 0,1768(10)
	cmpwi 0,0,0
	bc 12,2,.L418
	lis 11,itemlist@ha
	lis 9,0x286b
	la 4,itemlist@l(11)
	ori 9,9,51739
	subf 0,4,0
	addi 11,10,740
	mullw 0,0,9
	srawi 10,0,2
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L418
	mulli 0,10,76
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L418
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L418
	mtlr 9
	blrl
.L418:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe49:
	.size	 Cmd_WeapLast_f,.Lfe49-Cmd_WeapLast_f
	.align 2
	.globl Cmd_InvDrop_f
	.type	 Cmd_InvDrop_f,@function
Cmd_InvDrop_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,736(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,2,.L427
	li 4,-1
	bl SelectNextItem
.L427:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L428
	lis 5,.LC92@ha
	mr 3,31
	la 5,.LC92@l(5)
	b .L766
.L428:
	mulli 0,0,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L429
	lis 5,.LC90@ha
	mr 3,31
	la 5,.LC90@l(5)
.L766:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L425
.L429:
	mr 3,31
	mtlr 0
	blrl
.L425:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe50:
	.size	 Cmd_InvDrop_f,.Lfe50-Cmd_InvDrop_f
	.section	".rodata"
	.align 2
.LC199:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Cmd_Kill_f
	.type	 Cmd_Kill_f,@function
Cmd_Kill_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	lwz 0,248(10)
	cmpwi 0,0,0
	bc 12,2,.L430
	lwz 11,84(10)
	lis 9,level+4@ha
	lis 8,.LC199@ha
	lfs 0,level+4@l(9)
	la 8,.LC199@l(8)
	lfs 13,4404(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L430
	lwz 0,264(10)
	li 9,0
	stw 9,480(10)
	lis 11,meansOfDeath@ha
	lis 6,0x1
	rlwinm 0,0,0,28,26
	li 9,23
	stw 0,264(10)
	lis 7,vec3_origin@ha
	mr 4,3
	stw 9,meansOfDeath@l(11)
	la 7,vec3_origin@l(7)
	mr 5,3
	ori 6,6,34464
	bl player_die
.L430:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe51:
	.size	 Cmd_Kill_f,.Lfe51-Cmd_Kill_f
	.align 2
	.globl Cmd_PutAway_f
	.type	 Cmd_PutAway_f,@function
Cmd_PutAway_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 0,0
	lwz 9,84(31)
	stw 0,4112(9)
	lwz 11,84(31)
	stw 0,4120(11)
	lwz 9,84(31)
	stw 0,4116(9)
	lwz 11,84(31)
	lwz 0,4760(11)
	cmpwi 0,0,0
	bc 12,2,.L434
	bl PMenu_Close
.L434:
	lwz 9,84(31)
	li 0,1
	stw 0,4412(9)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe52:
	.size	 Cmd_PutAway_f,.Lfe52-Cmd_PutAway_f
	.align 2
	.globl PlayerSort
	.type	 PlayerSort,@function
PlayerSort:
	lwz 9,0(3)
	lis 11,game+1028@ha
	lwz 3,0(4)
	lwz 0,game+1028@l(11)
	mulli 9,9,4956
	mulli 11,3,4956
	add 9,9,0
	add 11,11,0
	lha 9,148(9)
	lha 3,148(11)
	cmpw 0,9,3
	li 3,-1
	bclr 12,0
	mfcr 3
	rlwinm 3,3,2,1
	blr
.Lfe53:
	.size	 PlayerSort,.Lfe53-PlayerSort
	.section	".rodata"
	.align 3
.LC200:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_Set_MouseSensitivity
	.type	 Cmd_Set_MouseSensitivity,@function
Cmd_Set_MouseSensitivity:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 30,gi@l(9)
	lwz 9,156(30)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 4,2,.L41
	lis 5,.LC13@ha
	mr 3,31
	la 5,.LC13@l(5)
	b .L768
.L41:
	lwz 0,164(30)
	mtlr 0
	blrl
	mr 30,3
	lis 4,.LC14@ha
	mr 3,30
	la 4,.LC14@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L43
	lwz 9,84(31)
	li 0,0
	lis 5,.LC15@ha
	mr 3,31
	la 5,.LC15@l(5)
	stw 0,4824(9)
.L768:
	li 4,1
	crxor 6,6,6
	bl safe_cprintf
	b .L40
.L43:
	mr 3,30
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(31)
	stw 3,20(1)
	lis 0,0x4330
	lis 10,.LC200@ha
	stw 0,16(1)
	la 10,.LC200@l(10)
	lis 4,.LC16@ha
	lfd 0,16(1)
	mr 3,31
	la 4,.LC16@l(4)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,4824(11)
	lwz 9,84(31)
	lfs 1,4824(9)
	creqv 6,6,6
	bl _stuffcmd
	lwz 9,84(31)
	lis 5,.LC17@ha
	mr 3,31
	la 5,.LC17@l(5)
	li 4,1
	lfs 1,4824(9)
	creqv 6,6,6
	bl safe_cprintf
.L40:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe54:
	.size	 Cmd_Set_MouseSensitivity,.Lfe54-Cmd_Set_MouseSensitivity
	.align 2
	.globl Cmd_Taunt
	.type	 Cmd_Taunt,@function
Cmd_Taunt:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L36
	lis 3,.LC12@ha
	lwz 29,84(31)
	la 3,.LC12@l(3)
	bl FindItem
	lwz 0,1764(29)
	cmpw 0,0,3
	bc 4,2,.L38
	lwz 9,84(31)
	li 0,369
	li 11,384
	b .L769
.L38:
	lwz 9,84(31)
	li 0,175
	li 11,190
.L769:
	stw 0,56(31)
	stw 11,4308(9)
.L36:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe55:
	.size	 Cmd_Taunt,.Lfe55-Cmd_Taunt
	.align 2
	.globl Cmd_Spawn_New_Bot
	.type	 Cmd_Spawn_New_Bot,@function
Cmd_Spawn_New_Bot:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	lwz 0,160(29)
	mr 28,3
	li 3,2
	mtlr 0
	blrl
	mr 4,3
	mr 3,28
	bl Spawn_New_Bot
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe56:
	.size	 Cmd_Spawn_New_Bot,.Lfe56-Cmd_Spawn_New_Bot
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
