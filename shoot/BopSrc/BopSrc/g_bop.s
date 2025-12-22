	.file	"g_bop.c"
gcc2_compiled.:
	.globl n_laghelp_str
	.section	".sdata","aw"
	.align 2
	.type	 n_laghelp_str,@object
	.size	 n_laghelp_str,4
n_laghelp_str:
	.long 0x3f000000
	.globl n_laghelp_rst
	.align 2
	.type	 n_laghelp_rst,@object
	.size	 n_laghelp_rst,4
n_laghelp_rst:
	.long 0x3f000000
	.globl n_max_delta_ping
	.align 2
	.type	 n_max_delta_ping,@object
	.size	 n_max_delta_ping,4
n_max_delta_ping:
	.long 1000
	.globl n_min_delta_ping
	.align 2
	.type	 n_min_delta_ping,@object
	.size	 n_min_delta_ping,4
n_min_delta_ping:
	.long 100
	.globl x_laghelp_str
	.align 2
	.type	 x_laghelp_str,@object
	.size	 x_laghelp_str,4
x_laghelp_str:
	.long 0x3d8f5c29
	.globl x_laghelp_rst
	.align 2
	.type	 x_laghelp_rst,@object
	.size	 x_laghelp_rst,4
x_laghelp_rst:
	.long 0x3e19999a
	.globl x_max_delta_ping
	.align 2
	.type	 x_max_delta_ping,@object
	.size	 x_max_delta_ping,4
x_max_delta_ping:
	.long 1000
	.globl x_min_delta_ping
	.align 2
	.type	 x_min_delta_ping,@object
	.size	 x_min_delta_ping,4
x_min_delta_ping:
	.long 225
	.globl t_laghelp_str
	.align 2
	.type	 t_laghelp_str,@object
	.size	 t_laghelp_str,4
t_laghelp_str:
	.long 0x0
	.globl t_laghelp_rst
	.align 2
	.type	 t_laghelp_rst,@object
	.size	 t_laghelp_rst,4
t_laghelp_rst:
	.long 0x0
	.globl t_max_delta_ping
	.align 2
	.type	 t_max_delta_ping,@object
	.size	 t_max_delta_ping,4
t_max_delta_ping:
	.long 500
	.globl t_min_delta_ping
	.align 2
	.type	 t_min_delta_ping,@object
	.size	 t_min_delta_ping,4
t_min_delta_ping:
	.long 500
	.globl max_delta_ping
	.align 2
	.type	 max_delta_ping,@object
	.size	 max_delta_ping,4
max_delta_ping:
	.long 1000
	.globl min_delta_ping
	.align 2
	.type	 min_delta_ping,@object
	.size	 min_delta_ping,4
min_delta_ping:
	.long 100
	.globl laghelp_str
	.align 2
	.type	 laghelp_str,@object
	.size	 laghelp_str,4
laghelp_str:
	.long 0x3e19999a
	.globl laghelp_rst
	.align 2
	.type	 laghelp_rst,@object
	.size	 laghelp_rst,4
laghelp_rst:
	.long 0x3e19999a
	.globl game_mode
	.type	 game_mode,@object
	.size	 game_mode,1
game_mode:
	.byte 0
	.globl bop_flareup
	.align 2
	.type	 bop_flareup,@object
	.size	 bop_flareup,4
bop_flareup:
	.long 0x40a00000
	.globl bop_deadtime
	.align 2
	.type	 bop_deadtime,@object
	.size	 bop_deadtime,4
bop_deadtime:
	.long 0x44160000
	.globl bop_getawaytime
	.align 2
	.type	 bop_getawaytime,@object
	.size	 bop_getawaytime,4
bop_getawaytime:
	.long 0x42200000
	.globl lagsicktime
	.align 2
	.type	 lagsicktime,@object
	.size	 lagsicktime,4
lagsicktime:
	.long 0x44098000
	.globl lag_threshold
	.align 2
	.type	 lag_threshold,@object
	.size	 lag_threshold,4
lag_threshold:
	.long 1000
	.globl lagged_out_detect
	.align 2
	.type	 lagged_out_detect,@object
	.size	 lagged_out_detect,4
lagged_out_detect:
	.long 30
	.globl msg_interval
	.align 2
	.type	 msg_interval,@object
	.size	 msg_interval,4
msg_interval:
	.long 0x41a00000
	.globl short_msg_interval
	.align 2
	.type	 short_msg_interval,@object
	.size	 short_msg_interval,4
short_msg_interval:
	.long 0x41200000
	.globl no_suicide_protect
	.align 2
	.type	 no_suicide_protect,@object
	.size	 no_suicide_protect,4
no_suicide_protect:
	.long 1
	.globl no_slag_protect
	.align 2
	.type	 no_slag_protect,@object
	.size	 no_slag_protect,4
no_slag_protect:
	.long 1
	.globl bop_verbose
	.align 2
	.type	 bop_verbose,@object
	.size	 bop_verbose,4
bop_verbose:
	.long 0
	.globl bop_invisible
	.align 2
	.type	 bop_invisible,@object
	.size	 bop_invisible,4
bop_invisible:
	.long 1
	.globl nobophelp
	.align 2
	.type	 nobophelp,@object
	.size	 nobophelp,4
nobophelp:
	.long 0
	.globl bopsickremove
	.align 2
	.type	 bopsickremove,@object
	.size	 bopsickremove,4
bopsickremove:
	.long 1
	.globl bopmanageobservers
	.align 2
	.type	 bopmanageobservers,@object
	.size	 bopmanageobservers,4
bopmanageobservers:
	.long 1
	.section	".rodata"
	.align 2
.LC1:
	.string	"Your damage increased from %d "
	.align 2
.LC2:
	.string	"Damage to you increased from %d "
	.align 2
.LC3:
	.string	" to %d [1:%f]\n"
	.align 3
.LC0:
	.long 0x3ff921ff
	.long 0x2e48e8a7
	.align 3
.LC4:
	.long 0x0
	.long 0x0
	.align 3
.LC5:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC6:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC7:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl anti_lpb
	.type	 anti_lpb,@function
anti_lpb:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 25,36(1)
	stw 0,84(1)
	lis 29,laghelp_str@ha
	lis 9,.LC4@ha
	lfs 0,laghelp_str@l(29)
	la 9,.LC4@l(9)
	mr 30,3
	lfd 13,0(9)
	mr 27,4
	mr 31,5
	fcmpu 0,0,13
	bc 12,2,.L16
	lwz 0,84(30)
	mr 3,31
	cmpwi 0,0,0
	bc 12,2,.L15
	mr 3,27
	mr 4,30
	bl OnSameTeam
	cmpwi 0,3,0
	bc 4,2,.L16
	lwz 9,84(27)
	cmpwi 0,9,0
	bc 12,2,.L16
	lwz 25,84(30)
	lis 11,min_delta_ping@ha
	lwz 10,184(9)
	lwz 0,184(25)
	lwz 9,min_delta_ping@l(11)
	subf 6,10,0
	cmpw 0,6,9
	bc 4,0,.L11
.L16:
	mr 3,31
	b .L15
.L11:
	lis 9,max_delta_ping@ha
	lfs 31,laghelp_str@l(29)
	lwz 11,max_delta_ping@l(9)
	lis 26,0x4330
	mr 10,8
	lis 9,.LC5@ha
	lis 28,bop_verbose@ha
	cmpw 7,6,11
	xoris 7,11,0x8000
	la 9,.LC5@l(9)
	lfd 30,0(9)
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	lis 9,.LC0@ha
	neg 0,0
	lfd 11,.LC0@l(9)
	andc 11,11,0
	and 0,6,0
	or 6,0,11
	xoris 9,6,0x8000
	stw 9,28(1)
	stw 26,24(1)
	lfd 13,24(1)
	stw 7,28(1)
	stw 26,24(1)
	lfd 12,24(1)
	fsub 13,13,30
	fsub 12,12,30
	frsp 13,13
	frsp 12,12
	fdivs 13,13,12
	fmr 0,13
	fmul 0,0,11
	frsp 0,0
	fmr 1,0
	bl sin
	lis 9,.LC6@ha
	lwz 0,bop_verbose@l(28)
	la 9,.LC6@l(9)
	lfd 0,0(9)
	cmpwi 0,0,0
	fmadd 31,31,1,0
	frsp 31,31
	bc 12,2,.L13
	lis 29,gi@ha
	lis 5,.LC1@ha
	la 29,gi@l(29)
	la 5,.LC1@l(5)
	lwz 9,8(29)
	mr 3,30
	li 4,2
	mr 6,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC2@ha
	mr 3,27
	la 5,.LC2@l(5)
	li 4,2
	mr 6,31
	mtlr 0
	crxor 6,6,6
	blrl
.L13:
	xoris 0,31,0x8000
	lwz 11,bop_verbose@l(28)
	stw 0,28(1)
	mr 10,9
	stw 26,24(1)
	cmpwi 0,11,0
	lfd 0,24(1)
	fsub 0,0,30
	frsp 0,0
	fmuls 0,0,31
	fmr 13,0
	fctiwz 12,13
	stfd 12,24(1)
	lwz 31,28(1)
	bc 12,2,.L14
	lis 29,gi@ha
	lis 28,.LC3@ha
	la 29,gi@l(29)
	mr 3,30
	lwz 9,8(29)
	li 4,2
	la 5,.LC3@l(28)
	mr 6,31
	fmr 1,31
	mtlr 9
	creqv 6,6,6
	blrl
	lwz 0,8(29)
	mr 3,27
	la 5,.LC3@l(28)
	fmr 1,31
	li 4,2
	mr 6,31
	mtlr 0
	creqv 6,6,6
	blrl
.L14:
	lis 11,level@ha
	lwz 0,level@l(11)
	mr 3,31
	lis 11,.LC7@ha
	xoris 0,0,0x8000
	la 11,.LC7@l(11)
	stw 0,28(1)
	stw 26,24(1)
	lfd 0,24(1)
	lfs 13,0(11)
	fsub 0,0,30
	frsp 0,0
	fadds 0,0,13
	stfs 0,3704(25)
.L15:
	lwz 0,84(1)
	mtlr 0
	lmw 25,36(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe1:
	.size	 anti_lpb,.Lfe1-anti_lpb
	.section	".rodata"
	.align 2
.LC9:
	.string	"Damage to you reduced from %d "
	.align 2
.LC10:
	.string	"Damage to your target reduced from %d "
	.align 2
.LC11:
	.string	" to %d [%f:1]\n"
	.align 2
.LC12:
	.string	"%s"
	.align 2
.LC13:
	.string	"You hit for %d damage\n"
	.align 3
.LC8:
	.long 0x3ff921ff
	.long 0x2e48e8a7
	.align 2
.LC14:
	.long 0x0
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC16:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC17:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl pro_hpb
	.type	 pro_hpb,@function
pro_hpb:
	stwu 1,-192(1)
	mflr 0
	stfd 30,176(1)
	stfd 31,184(1)
	stmw 25,148(1)
	stw 0,196(1)
	lis 9,.LC14@ha
	lis 29,laghelp_rst@ha
	la 9,.LC14@l(9)
	lfs 0,laghelp_rst@l(29)
	mr 30,3
	lfs 13,0(9)
	mr 27,4
	mr 31,5
	fcmpu 0,0,13
	bc 12,2,.L27
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L27
	lwz 0,84(27)
	cmpwi 0,0,0
	bc 12,2,.L27
	mr 3,27
	mr 4,30
	bl OnSameTeam
	cmpwi 0,3,0
	bc 4,2,.L27
	lwz 9,84(30)
	lis 10,min_delta_ping@ha
	lwz 25,84(27)
	lwz 11,184(9)
	lwz 0,184(25)
	lwz 9,min_delta_ping@l(10)
	subf 6,11,0
	cmpw 0,6,9
	bc 4,0,.L20
.L27:
	mr 3,31
	b .L26
.L20:
	lis 9,max_delta_ping@ha
	lfs 31,laghelp_rst@l(29)
	lwz 11,max_delta_ping@l(9)
	lis 28,0x4330
	mr 10,8
	lis 9,.LC15@ha
	lis 26,bop_verbose@ha
	cmpw 7,6,11
	xoris 7,11,0x8000
	la 9,.LC15@l(9)
	lfd 30,0(9)
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	lis 9,.LC8@ha
	neg 0,0
	lfd 11,.LC8@l(9)
	andc 11,11,0
	and 0,6,0
	or 6,0,11
	xoris 9,6,0x8000
	stw 9,140(1)
	stw 28,136(1)
	lfd 13,136(1)
	stw 7,140(1)
	stw 28,136(1)
	lfd 12,136(1)
	fsub 13,13,30
	fsub 12,12,30
	frsp 13,13
	frsp 12,12
	fdivs 13,13,12
	fmr 0,13
	fmul 0,0,11
	frsp 0,0
	fmr 1,0
	bl sin
	lis 9,.LC16@ha
	lwz 0,bop_verbose@l(26)
	la 9,.LC16@l(9)
	lfd 0,0(9)
	cmpwi 0,0,0
	fmadd 31,31,1,0
	frsp 31,31
	bc 12,2,.L22
	lis 29,gi@ha
	lis 5,.LC9@ha
	la 29,gi@l(29)
	la 5,.LC9@l(5)
	lwz 9,8(29)
	mr 3,27
	li 4,2
	mr 6,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC10@ha
	mr 3,30
	la 5,.LC10@l(5)
	li 4,2
	mr 6,31
	mtlr 0
	crxor 6,6,6
	blrl
.L22:
	xoris 0,31,0x8000
	fmr 1,31
	stw 0,140(1)
	mr 11,9
	lis 4,.LC11@ha
	stw 28,136(1)
	la 4,.LC11@l(4)
	addi 3,1,8
	lfd 0,136(1)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,31
	fmr 13,0
	fctiwz 12,13
	stfd 12,136(1)
	lwz 31,140(1)
	mr 5,31
	creqv 6,6,6
	bl sprintf
	lwz 0,bop_verbose@l(26)
	cmpwi 0,0,0
	bc 12,2,.L23
	lis 29,gi@ha
	lis 28,.LC12@ha
	la 29,gi@l(29)
	mr 3,27
	lwz 9,8(29)
	li 4,2
	la 5,.LC12@l(28)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	la 5,.LC12@l(28)
	mr 3,30
	li 4,2
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L23:
	mr 4,27
	mr 3,30
	addi 5,1,104
	bl adjust_resistance
	cmpwi 0,3,0
	bc 4,2,.L24
	lwz 6,104(1)
	cmpw 0,31,6
	bc 4,0,.L24
	lwz 0,bop_verbose@l(26)
	cmpwi 0,0,0
	bc 12,2,.L25
	lis 9,gi+8@ha
	lis 5,.LC13@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L25:
	lwz 3,104(1)
	b .L26
.L24:
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 10,0x4330
	mr 3,31
	lis 9,.LC15@ha
	xoris 0,0,0x8000
	la 9,.LC15@l(9)
	stw 0,140(1)
	stw 10,136(1)
	lfd 13,0(9)
	lfd 0,136(1)
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 12,0(9)
	fsub 0,0,13
	frsp 0,0
	fadds 0,0,12
	stfs 0,3708(25)
.L26:
	lwz 0,196(1)
	mtlr 0
	lmw 25,148(1)
	lfd 30,176(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe2:
	.size	 pro_hpb,.Lfe2-pro_hpb
	.section	".rodata"
	.align 2
.LC18:
	.string	"%s overflowed\n"
	.align 2
.LC19:
	.string	"%s lagged out\n"
	.align 3
.LC20:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl protecthpb
	.type	 protecthpb,@function
protecthpb:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	mr 31,4
	lwz 29,84(31)
	cmpwi 0,29,0
	bc 12,2,.L28
	cmpw 0,31,3
	bc 4,2,.L30
	lis 9,no_suicide_protect@ha
	lwz 0,no_suicide_protect@l(9)
	cmpwi 0,0,0
	bc 4,2,.L28
.L30:
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 4,2,.L31
	lis 9,no_slag_protect@ha
	lwz 0,no_slag_protect@l(9)
	cmpwi 0,0,0
	bc 4,2,.L28
.L31:
	lis 28,level@ha
	lfs 13,3692(29)
	lwz 0,level@l(28)
	lis 30,0x4330
	lis 11,.LC20@ha
	la 11,.LC20@l(11)
	xoris 0,0,0x8000
	lfd 31,0(11)
	stw 0,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 12,0
	fcmpu 0,13,12
	bc 12,1,.L28
	lfs 0,3712(29)
	fcmpu 0,0,12
	bc 12,1,.L28
	mr 3,31
	bl lagged_out
	cmpwi 0,3,0
	bc 12,2,.L28
	lwz 0,level@l(28)
	lis 9,bop_deadtime@ha
	lfs 13,bop_deadtime@l(9)
	lis 10,bopsickremove@ha
	mr 8,11
	xoris 0,0,0x8000
	lis 9,bop_getawaytime@ha
	stw 0,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	lwz 0,bopsickremove@l(10)
	lfs 12,bop_getawaytime@l(9)
	fsub 0,0,31
	cmpwi 0,0,0
	frsp 0,0
	fadds 0,0,13
	stfs 0,3712(29)
	lwz 0,level@l(28)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fadds 0,0,12
	stfs 0,3692(29)
	bc 12,2,.L28
	lis 30,gi@ha
	li 3,1
	la 29,gi@l(30)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xdb43
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,47903
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(29)
	li 3,10
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
	lis 9,bop_invisible@ha
	lwz 0,184(31)
	li 11,1
	lwz 10,bop_invisible@l(9)
	li 8,0
	ori 0,0,1
	stw 11,260(31)
	cmpwi 0,10,0
	stw 8,248(31)
	stw 0,184(31)
	bc 12,2,.L36
	lwz 5,84(31)
	lis 4,.LC18@ha
	li 3,2
	lwz 0,gi@l(30)
	la 4,.LC18@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L37
.L36:
	lwz 5,84(31)
	lis 4,.LC19@ha
	li 3,2
	lwz 0,gi@l(30)
	la 4,.LC19@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L37:
	lwz 9,84(31)
	li 0,1
	stw 0,3732(9)
.L28:
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 protecthpb,.Lfe3-protecthpb
	.section	".rodata"
	.align 2
.LC21:
	.string	"It is advised that you type\ncl_nodelta 0\nat the console!  You will be\nnotified three times"
	.align 2
.LC22:
	.string	"Client's ping has exceeded threshold\n"
	.align 3
.LC23:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC24:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl lagged_out
	.type	 lagged_out,@function
lagged_out:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,480(31)
	lwz 7,84(31)
	cmpwi 0,0,0
	bc 4,1,.L55
	lis 6,level@ha
	lfs 12,3768(7)
	lis 8,.LC23@ha
	la 9,level@l(6)
	la 8,.LC23@l(8)
	lfs 0,4(9)
	lfd 13,0(8)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,0,.L40
	lwz 11,184(7)
	lis 10,0x4330
	lis 8,.LC24@ha
	li 3,0
	stw 11,3724(7)
	la 8,.LC24@l(8)
	lwz 0,level@l(6)
	lfd 13,0(8)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,3720(7)
	b .L56
.L40:
	lwz 11,184(7)
	cmpwi 0,11,0
	bc 4,2,.L41
	lwz 0,level@l(6)
	lis 9,0x6666
	lwz 11,3420(7)
	ori 9,9,26215
	subf 0,11,0
	mulhw 9,0,9
	srawi 0,0,31
	srawi 9,9,2
	subf 9,0,9
	cmpwi 0,9,60
	bc 12,2,.L45
	bc 12,1,.L49
	cmpwi 0,9,30
	bc 12,2,.L45
	b .L55
.L49:
	cmpwi 0,9,90
	bc 4,2,.L55
.L45:
	mr 3,31
	bl lag_msg
	cmpwi 0,3,0
	bc 12,2,.L55
	lis 9,gi+12@ha
	lis 4,.LC21@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC21@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L55
.L41:
	lis 9,lag_threshold@ha
	lwz 0,lag_threshold@l(9)
	cmpw 0,11,0
	bc 4,1,.L50
	lis 9,bop_verbose@ha
	lwz 0,bop_verbose@l(9)
	cmpwi 0,0,0
	bc 12,2,.L57
	lis 9,gi+8@ha
	lis 5,.LC22@ha
	lwz 0,gi+8@l(9)
	la 5,.LC22@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L57
.L50:
	cmpwi 0,11,99
	lis 9,lagged_out_detect@ha
	lwz 8,lagged_out_detect@l(9)
	bc 12,1,.L52
	slwi 0,8,1
	add 8,0,8
.L52:
	lwz 0,3724(7)
	cmpw 0,0,11
	bc 4,2,.L53
	lwz 0,level@l(6)
	lis 10,0x4330
	lfs 11,3720(7)
	mr 11,9
	xoris 8,8,0x8000
	xoris 0,0,0x8000
	lis 7,.LC24@ha
	stw 0,20(1)
	la 7,.LC24@l(7)
	stw 10,16(1)
	lfd 12,0(7)
	lfd 0,16(1)
	stw 8,20(1)
	stw 10,16(1)
	lfd 13,16(1)
	fsub 0,0,12
	fsub 13,13,12
	frsp 0,0
	frsp 13,13
	fsubs 0,0,11
	fcmpu 0,0,13
	bc 4,1,.L55
.L57:
	li 3,1
	b .L56
.L53:
	stw 11,3724(7)
	lis 8,.LC24@ha
	lwz 0,level@l(6)
	lis 11,0x4330
	la 8,.LC24@l(8)
	lfd 13,0(8)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 11,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,3720(7)
.L55:
	li 3,0
.L56:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 lagged_out,.Lfe4-lagged_out
	.section	".rodata"
	.align 2
.LC25:
	.string	"misc/secret.wav"
	.align 2
.LC26:
	.string	"You've got lag sickness!\n\nYou are frozen until you\n\nstop lagging out..."
	.align 2
.LC27:
	.string	"You've got lag sickness!\n\nWeapons are jammed...\n\nFleeing would be a good option...\n"
	.align 2
.LC28:
	.string	"You've got lag sickness\nfor %d more seconds\n"
	.align 3
.LC29:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC30:
	.long 0x41200000
	.align 2
.LC31:
	.long 0x3f800000
	.align 2
.LC32:
	.long 0x0
	.align 3
.LC33:
	.long 0x40340000
	.long 0x0
	.section	".text"
	.align 2
	.globl lag_sick_notice
	.type	 lag_sick_notice,@function
lag_sick_notice:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 10,0x4330
	mr 31,3
	lis 9,.LC29@ha
	lis 8,lagsicktime@ha
	xoris 0,0,0x8000
	la 9,.LC29@l(9)
	lfs 10,lagsicktime@l(8)
	stw 0,28(1)
	stw 10,24(1)
	lfd 12,0(9)
	lfd 0,24(1)
	lwz 9,84(31)
	fsub 0,0,12
	lfs 13,3712(9)
	frsp 0,0
	fsubs 11,13,0
	fcmpu 0,11,10
	bc 4,1,.L69
	lis 11,.LC30@ha
	fsubs 11,11,10
	lis 9,.LC31@ha
	la 11,.LC30@l(11)
	la 9,.LC31@l(9)
	lfs 0,0(11)
	lis 11,.LC32@ha
	lfs 13,0(9)
	la 11,.LC32@l(11)
	fdivs 0,11,0
	lfs 12,0(11)
	fcmpu 7,0,13
	fcmpu 6,0,12
	crnor 27,26,26
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L70
	li 30,1
	b .L71
.L70:
	fctiwz 13,0
	stfd 13,24(1)
	lwz 30,28(1)
	b .L71
.L69:
	li 30,0
.L71:
	cmpwi 0,30,0
	lwz 8,84(31)
	bc 4,2,.L74
	lis 11,level@ha
	lfs 12,3692(8)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC29@ha
	xoris 0,0,0x8000
	la 11,.LC29@l(11)
	stw 0,28(1)
	stw 10,24(1)
	lfd 13,0(11)
	lfd 0,24(1)
	li 11,0
	fsub 0,0,13
	frsp 13,0
	fcmpu 0,12,13
	bc 4,1,.L75
	lfs 0,3712(8)
	fcmpu 0,0,13
	bc 4,1,.L75
	li 11,1
.L75:
	cmpwi 0,11,0
	bc 12,2,.L73
.L74:
	lis 11,level@ha
	lfs 13,3716(8)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC29@ha
	xoris 0,0,0x8000
	la 11,.LC29@l(11)
	stw 0,28(1)
	stw 10,24(1)
	lfd 12,0(11)
	lfd 0,24(1)
	lis 11,.LC33@ha
	la 11,.LC33@l(11)
	lfd 11,0(11)
	fsub 0,0,12
	frsp 0,0
	fsubs 13,13,0
	fabs 13,13
	fcmpu 0,13,11
	bc 4,1,.L78
	stfs 0,3716(8)
	li 0,1
	b .L79
.L78:
	li 0,0
.L79:
	cmpwi 0,0,0
	bc 12,2,.L77
	lis 29,gi@ha
	lis 3,.LC25@ha
	la 29,gi@l(29)
	la 3,.LC25@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC31@ha
	lwz 0,16(29)
	lis 11,.LC31@ha
	la 9,.LC31@l(9)
	la 11,.LC31@l(11)
	lfs 1,0(9)
	mr 5,3
	mtlr 0
	li 4,2
	lis 9,.LC32@ha
	lfs 2,0(11)
	mr 3,31
	la 9,.LC32@l(9)
	lfs 3,0(9)
	blrl
	lis 9,level@ha
	lwz 8,84(31)
	lwz 0,level@l(9)
	lis 10,0x4330
	lis 9,.LC29@ha
	lfs 12,3692(8)
	xoris 0,0,0x8000
	la 9,.LC29@l(9)
	stw 0,28(1)
	stw 10,24(1)
	lfd 13,0(9)
	lfd 0,24(1)
	li 9,0
	fsub 0,0,13
	frsp 13,0
	fcmpu 0,12,13
	bc 4,1,.L81
	lfs 0,3712(8)
	fcmpu 0,0,13
	bc 4,1,.L81
	li 9,1
.L81:
	cmpwi 0,9,0
	bc 12,2,.L80
	lwz 9,84(31)
	lwz 0,3732(9)
	cmpwi 0,0,0
	bc 12,2,.L83
	lis 9,gi+12@ha
	lis 4,.LC26@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC26@l(4)
	b .L87
.L83:
	lis 9,gi+12@ha
	lis 4,.LC27@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC27@l(4)
.L87:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L77
.L80:
	lis 9,gi+12@ha
	lis 4,.LC28@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC28@l(4)
	mr 5,30
	mtlr 0
	crxor 6,6,6
	blrl
.L77:
	li 3,1
	b .L86
.L73:
	li 3,0
.L86:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 lag_sick_notice,.Lfe5-lag_sick_notice
	.section	".rodata"
	.align 2
.LC34:
	.string	"You lagged out but were saved\n\nGet ready to re-enter the game\n\n%i"
	.align 2
.LC35:
	.string	"player"
	.align 2
.LC36:
	.string	"%s re-entered the game\n"
	.align 2
.LC37:
	.string	"%s is in your way!\n"
	.align 3
.LC38:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC39:
	.long 0x3f800000
	.align 3
.LC40:
	.long 0x40240000
	.long 0x0
	.align 2
.LC41:
	.long 0x41200000
	.align 2
.LC42:
	.long 0x42a00000
	.align 3
.LC43:
	.long 0x40340000
	.long 0x0
	.section	".text"
	.align 2
	.globl do_bop_frame
	.type	 do_bop_frame,@function
do_bop_frame:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 10,0x4330
	mr 31,3
	lis 9,.LC38@ha
	lwz 30,84(31)
	xoris 0,0,0x8000
	la 9,.LC38@l(9)
	stw 0,20(1)
	stw 10,16(1)
	lfd 12,0(9)
	lfd 0,16(1)
	li 9,0
	lfs 13,3692(30)
	fsub 0,0,12
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L90
	lfs 0,3712(30)
	fcmpu 0,0,12
	bc 4,1,.L90
	li 9,1
.L90:
	cmpwi 0,9,0
	bc 12,2,.L89
	mr 3,31
	bl lagged_out
	cmpwi 0,3,0
	bc 4,2,.L105
	lis 9,bopsickremove@ha
	lwz 0,bopsickremove@l(9)
	cmpwi 0,0,0
	bc 12,2,.L88
	lis 11,level@ha
	lwz 8,84(31)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC38@ha
	lfs 13,3716(8)
	xoris 0,0,0x8000
	la 11,.LC38@l(11)
	stw 0,20(1)
	stw 10,16(1)
	lfd 12,0(11)
	lfd 0,16(1)
	lis 11,.LC40@ha
	la 11,.LC40@l(11)
	lfd 11,0(11)
	fsub 0,0,12
	frsp 0,0
	fsubs 13,13,0
	fabs 13,13
	fcmpu 0,13,11
	bc 4,1,.L96
	stfs 0,3716(8)
	li 0,1
	b .L97
.L96:
	li 0,0
.L97:
	cmpwi 0,0,0
	bc 12,2,.L88
	lis 11,level@ha
	lfs 13,3692(30)
	lwz 0,level@l(11)
	lis 10,0x4330
	mr 5,9
	lis 11,.LC38@ha
	lis 4,.LC34@ha
	xoris 0,0,0x8000
	la 11,.LC38@l(11)
	stw 0,20(1)
	mr 3,31
	la 4,.LC34@l(4)
	stw 10,16(1)
	lfd 11,0(11)
	lfd 0,16(1)
	lis 11,.LC41@ha
	la 11,.LC41@l(11)
	lfs 10,0(11)
	fsub 0,0,11
	lis 11,gi+12@ha
	lwz 0,gi+12@l(11)
	frsp 0,0
	mtlr 0
	fsubs 13,13,0
	fdivs 13,13,10
	fctiwz 12,13
	stfd 12,16(1)
	lwz 5,20(1)
	crxor 6,6,6
	blrl
	b .L88
.L89:
	lwz 9,84(31)
	lwz 0,3732(9)
	cmpwi 0,0,0
	bc 12,2,.L98
	li 29,0
	li 26,0
	addi 27,31,4
	lis 28,.LC35@ha
.L102:
	lis 9,.LC42@ha
	mr 3,29
	la 9,.LC42@l(9)
	mr 4,27
	lfs 1,0(9)
	bl findradius
	mr. 29,3
	bc 12,2,.L100
	lwz 3,280(29)
	la 4,.LC35@l(28)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L102
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L102
	li 26,1
.L100:
	cmpwi 0,26,0
	bc 4,2,.L103
	mr 3,31
	lis 28,gi@ha
	bl KillBox
	la 29,gi@l(28)
	lwz 0,184(31)
	li 11,2
	li 9,4
	stw 11,248(31)
	li 3,1
	rlwinm 0,0,0,0,30
	stw 9,260(31)
	stw 0,184(31)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xdb43
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,47903
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 0,88(29)
	li 4,2
	mr 3,27
	mtlr 0
	blrl
	lwz 0,gi@l(28)
	lis 4,.LC36@ha
	li 3,2
	lwz 5,84(31)
	la 4,.LC36@l(4)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	li 0,32
	li 9,14
	stw 26,3732(30)
	stb 0,16(30)
	stb 9,17(30)
	b .L88
.L103:
	lis 11,level@ha
	lwz 8,84(31)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC38@ha
	lfs 13,3716(8)
	xoris 0,0,0x8000
	la 11,.LC38@l(11)
	stw 0,20(1)
	stw 10,16(1)
	lfd 12,0(11)
	lfd 0,16(1)
	lis 11,.LC43@ha
	la 11,.LC43@l(11)
	lfd 11,0(11)
	fsub 0,0,12
	frsp 0,0
	fsubs 13,13,0
	fabs 13,13
	fcmpu 0,13,11
	bc 4,1,.L106
	stfs 0,3716(8)
	li 0,1
	b .L107
.L106:
	li 0,0
.L107:
	cmpwi 0,0,0
	bc 12,2,.L105
	lis 9,gi+12@ha
	lwz 5,84(29)
	lis 4,.LC37@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC37@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L105:
	lis 9,.LC39@ha
	lfs 0,3692(30)
	la 9,.LC39@l(9)
	lfs 13,3712(30)
	lfs 12,0(9)
	fadds 0,0,12
	fadds 13,13,12
	stfs 0,3692(30)
	stfs 13,3712(30)
	b .L88
.L98:
	lis 9,bopmanageobservers@ha
	lwz 0,bopmanageobservers@l(9)
	cmpwi 0,0,0
	bc 12,2,.L88
	lwz 9,184(31)
	andi. 11,9,1
	bc 12,2,.L88
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L88
	rlwinm 0,9,0,0,30
	stw 0,184(31)
.L88:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 do_bop_frame,.Lfe6-do_bop_frame
	.section	".rodata"
	.align 2
.LC44:
	.string	"Alpha Release (Bugs may exist)"
	.align 2
.LC45:
	.string	"Beta Release"
	.align 2
.LC46:
	.string	"Public Release"
	.align 2
.LC47:
	.string	"Server running Balance of Power %.2f\n\n%s\n\nBOP set to %s mode\n\nFor help type 'cmd bophelp'\n\nLatest stable version at:\nwww.planetquake.com/bop/"
	.align 2
.LC49:
	.string	"NORMAL"
	.align 2
.LC50:
	.string	"Customized NORMAL"
	.align 2
.LC53:
	.string	"EXPERT"
	.align 2
.LC54:
	.string	"Customized EXPERT"
	.align 2
.LC55:
	.string	"ANTI PHONE-JACK"
	.align 2
.LC56:
	.string	"Cust. PHONE-JACK"
	.align 2
.LC57:
	.string	"UNKNOWN (Bug)"
	.align 2
.LC51:
	.long 0x3d8f5c29
	.align 2
.LC52:
	.long 0x3e19999a
	.align 2
.LC58:
	.long 0x3f000000
	.align 2
.LC59:
	.long 0x0
	.section	".text"
	.align 2
	.globl get_mode_name
	.type	 get_mode_name,@function
get_mode_name:
	lis 9,game_mode@ha
	lbz 0,game_mode@l(9)
	cmpwi 0,0,1
	bc 12,2,.L125
	bc 12,1,.L134
	cmpwi 0,0,0
	bc 12,2,.L122
	blr
.L134:
	cmpwi 0,0,2
	bc 12,2,.L128
	cmpwi 0,0,3
	bc 12,2,.L131
	blr
.L122:
	lis 11,.LC58@ha
	lis 9,laghelp_str@ha
	la 11,.LC58@l(11)
	lfs 0,laghelp_str@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L123
	lis 9,laghelp_rst@ha
	lfs 0,laghelp_rst@l(9)
	fcmpu 0,0,13
	bc 4,2,.L123
	lis 9,max_delta_ping@ha
	lwz 0,max_delta_ping@l(9)
	cmpwi 0,0,1000
	bc 4,2,.L123
	lis 9,min_delta_ping@ha
	lwz 0,min_delta_ping@l(9)
	cmpwi 0,0,100
	bc 4,2,.L123
	lis 9,.LC49@ha
	lwz 10,.LC49@l(9)
	la 11,.LC49@l(9)
.L135:
	lbz 0,6(11)
	lhz 9,4(11)
	stb 0,6(3)
	stw 10,0(3)
	sth 9,4(3)
	blr
.L123:
	lis 9,.LC50@ha
	lwz 0,.LC50@l(9)
	la 11,.LC50@l(9)
.L136:
	lwz 10,4(11)
	lwz 9,8(11)
	lwz 8,12(11)
	stw 0,0(3)
	stw 10,4(3)
	stw 9,8(3)
	stw 8,12(3)
	lhz 0,16(11)
	sth 0,16(3)
	blr
.L125:
	lis 9,laghelp_str@ha
	lis 11,.LC51@ha
	lfs 13,laghelp_str@l(9)
	lfs 0,.LC51@l(11)
	fcmpu 0,13,0
	bc 4,2,.L126
	lis 9,laghelp_rst@ha
	lis 11,.LC52@ha
	lfs 13,laghelp_rst@l(9)
	lfs 0,.LC52@l(11)
	fcmpu 0,13,0
	bc 4,2,.L126
	lis 9,max_delta_ping@ha
	lwz 0,max_delta_ping@l(9)
	cmpwi 0,0,1000
	bc 4,2,.L126
	lis 9,min_delta_ping@ha
	lwz 0,min_delta_ping@l(9)
	cmpwi 0,0,225
	bc 4,2,.L126
	lis 9,.LC53@ha
	lwz 10,.LC53@l(9)
	la 11,.LC53@l(9)
	b .L135
.L126:
	lis 9,.LC54@ha
	lwz 0,.LC54@l(9)
	la 11,.LC54@l(9)
	b .L136
.L128:
	lis 11,.LC59@ha
	lis 9,laghelp_str@ha
	la 11,.LC59@l(11)
	lfs 0,laghelp_str@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L129
	lis 9,laghelp_rst@ha
	lfs 0,laghelp_rst@l(9)
	fcmpu 0,0,13
	bc 4,2,.L129
	lis 11,.LC55@ha
	lwz 8,.LC55@l(11)
	la 9,.LC55@l(11)
	lwz 0,12(9)
	lwz 11,4(9)
	lwz 10,8(9)
	stw 0,12(3)
.L137:
	stw 8,0(3)
	stw 11,4(3)
	stw 10,8(3)
	blr
.L129:
	lis 9,.LC56@ha
	lwz 0,.LC56@l(9)
	la 11,.LC56@l(9)
	lwz 10,4(11)
	lwz 9,8(11)
	lwz 8,12(11)
	stw 0,0(3)
	stw 10,4(3)
	stw 9,8(3)
	stw 8,12(3)
	lbz 0,16(11)
	stb 0,16(3)
	blr
.L131:
	lis 11,.LC57@ha
	lwz 8,.LC57@l(11)
	la 9,.LC57@l(11)
	lhz 0,12(9)
	lwz 11,4(9)
	lwz 10,8(9)
	sth 0,12(3)
	b .L137
.Lfe7:
	.size	 get_mode_name,.Lfe7-get_mode_name
	.section	".rodata"
	.align 2
.LC60:
	.string	"bop.ini"
	.align 2
.LC61:
	.string	"bop.cfg"
	.align 2
.LC62:
	.string	"bop/bop.ini"
	.align 2
.LC63:
	.string	"bop/bop.cfg"
	.align 2
.LC64:
	.long .LC60
	.long .LC61
	.long .LC62
	.long .LC63
	.align 2
.LC65:
	.string	"v%.2f"
	.align 2
.LC67:
	.string	"bop"
	.align 2
.LC68:
	.string	"gamedir"
	.align 2
.LC69:
	.string	"r"
	.align 2
.LC70:
	.string	"%s file found, processing...\n"
	.align 2
.LC71:
	.string	"%s file not found\n"
	.align 2
.LC72:
	.string	"/"
	.align 2
.LC73:
	.string	"No bop.ini or bop.cfg file found, using defaults\n"
	.align 2
.LC74:
	.string	"BUG IN bopinit() PLEASE REPORT TO bop@planetquake.com\n"
	.align 3
.LC66:
	.long 0x3fed70a3
	.long 0xd70a3d71
	.section	".text"
	.align 2
	.globl bopinit
	.type	 bopinit,@function
bopinit:
	stwu 1,-384(1)
	mflr 0
	mfcr 12
	stmw 21,340(1)
	stw 0,388(1)
	stw 12,336(1)
	lis 10,.LC64@ha
	lis 9,.LC66@ha
	la 11,.LC64@l(10)
	lwz 8,.LC64@l(10)
	lis 4,.LC65@ha
	lwz 0,4(11)
	addi 27,1,216
	addi 3,1,8
	lfd 1,.LC66@l(9)
	la 4,.LC65@l(4)
	lis 28,.LC67@ha
	lwz 7,12(11)
	addi 9,1,312
	mr 31,27
	lwz 10,8(11)
	mr 23,9
	li 24,0
	stw 8,312(1)
	mr 30,31
	lis 22,gi@ha
	stw 0,4(9)
	lis 21,.LC69@ha
	li 26,0
	stw 10,8(9)
	stw 7,12(9)
	creqv 6,6,6
	bl sprintf
	lis 29,gi@ha
	addi 4,1,8
	la 29,gi@l(29)
	li 5,4
	lwz 9,144(29)
	la 3,.LC67@l(28)
	mtlr 9
	blrl
	lwz 0,144(29)
	lis 3,.LC68@ha
	la 4,.LC67@l(28)
	la 3,.LC68@l(3)
	li 5,4
	mtlr 0
	blrl
	lwz 25,4(3)
	lwz 4,312(1)
	mr 3,27
	bl strcpy
.L141:
	mr 3,31
	la 4,.LC69@l(21)
	bl fopen
	mr. 27,3
	bc 12,2,.L142
	la 9,gi@l(22)
	lis 5,.LC70@ha
	lwz 0,8(9)
	mr 6,31
	la 5,.LC70@l(5)
	li 3,0
	li 4,2
	mtlr 0
	li 28,0
	addi 29,1,24
	li 31,0
	crxor 6,6,6
	blrl
.L145:
	lwz 9,4(27)
	addi 9,9,-1
	cmpwi 0,9,0
	stw 9,4(27)
	bc 4,0,.L146
	mr 3,27
	bl __srget
	b .L147
.L146:
	lwz 9,0(27)
	lbz 3,0(9)
	addi 9,9,1
	stw 9,0(27)
.L147:
	xori 9,3,10
	subfic 0,9,0
	adde 9,0,9
	xori 0,3,13
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 4,2,.L149
	cmpwi 0,28,79
	bc 4,1,.L148
.L149:
	cmpwi 0,28,0
	stbx 31,29,28
	cmpwi 4,3,-1
	bc 12,2,.L150
	li 28,0
	b .L151
.L153:
	addi 28,28,1
.L151:
	mr 3,29
	bl strlen
	cmplw 0,28,3
	bc 4,0,.L152
	lbzx 0,29,28
	cmpwi 0,0,32
	bc 4,2,.L153
.L152:
	lbz 0,24(1)
	cmpwi 0,0,47
	bc 12,2,.L150
	lbz 0,25(1)
	cmpwi 0,0,47
	bc 12,2,.L150
	mr 3,29
	bl strlen
	cmpw 0,28,3
	bc 4,2,.L158
	mr 3,29
	li 4,0
	bl process_bop_cmds
	b .L150
.L158:
	li 11,0
	addi 4,1,120
	stbx 11,29,28
	addi 28,28,1
	lbzx 0,29,28
	cmpwi 0,0,0
	bc 12,2,.L161
	mr 8,4
	mr 10,29
.L162:
	lbzx 0,10,28
	addi 28,28,1
	stbx 0,8,11
	lbzx 9,10,28
	addi 11,11,1
	cmpwi 0,9,0
	bc 4,2,.L162
.L161:
	stbx 31,4,11
	mr 3,29
	bl process_bop_cmds
.L150:
	li 28,0
	b .L143
.L148:
	cmpwi 4,3,-1
	stbx 3,29,28
	addi 28,28,1
.L143:
	bc 4,18,.L145
	mr 3,27
	li 31,0
	bl fclose
	b .L139
.L142:
	la 28,gi@l(22)
	lis 5,.LC71@ha
	lwz 9,8(28)
	la 5,.LC71@l(5)
	li 4,2
	mr 6,31
	li 3,0
	mtlr 9
	crxor 6,6,6
	blrl
	lwzx 29,26,23
	mr 3,29
	bl strlen
	mr 5,3
	mr 4,29
	mr 3,30
	bl strncmp
	cmpwi 0,3,0
	bc 4,2,.L167
	mr 4,25
	mr 3,30
	bl strcpy
	lis 4,.LC72@ha
	mr 3,30
	la 4,.LC72@l(4)
	bl strcat
	lwzx 4,26,23
	mr 3,30
	bl strcat
	b .L139
.L167:
	mr 3,25
	bl strlen
	mr 5,3
	mr 4,25
	mr 3,30
	bl strncmp
	cmpwi 0,3,0
	bc 4,2,.L169
	addi 24,24,1
	addi 26,26,4
	cmpwi 0,24,3
	bc 12,1,.L170
	lwzx 4,26,23
	mr 3,30
	bl strcpy
	b .L139
.L170:
	lwz 0,8(28)
	lis 5,.LC73@ha
	li 3,0
	la 5,.LC73@l(5)
	li 4,2
	mtlr 0
	li 31,0
	crxor 6,6,6
	blrl
	b .L139
.L169:
	lwz 0,8(28)
	lis 5,.LC74@ha
	li 3,0
	la 5,.LC74@l(5)
	li 4,2
	mtlr 0
	li 31,0
	crxor 6,6,6
	blrl
.L139:
	cmpwi 0,31,0
	bc 4,2,.L141
	lwz 0,388(1)
	lwz 12,336(1)
	mtlr 0
	lmw 21,340(1)
	mtcrf 8,12
	la 1,384(1)
	blr
.Lfe8:
	.size	 bopinit,.Lfe8-bopinit
	.section	".rodata"
	.align 2
.LC75:
	.string	"p_quad"
	.align 2
.LC76:
	.string	"p_invulnerability"
	.align 2
.LC77:
	.string	"%s is frozen!\n"
	.align 2
.LC78:
	.string	"%s has lag sickness\n\n(type 'bophelp' for more info)"
	.align 3
.LC79:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC80:
	.long 0x40340000
	.long 0x0
	.align 2
.LC81:
	.long 0x3f800000
	.align 2
.LC82:
	.long 0x0
	.section	".text"
	.align 2
	.globl check_4_lagpent
	.type	 check_4_lagpent,@function
check_4_lagpent:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	mr 30,4
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L183
	lis 9,bop_invisible@ha
	lwz 0,bop_invisible@l(9)
	cmpwi 0,0,0
	bc 4,2,.L183
	lis 11,level@ha
	lwz 8,84(30)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC79@ha
	lfs 12,3692(8)
	xoris 0,0,0x8000
	la 11,.LC79@l(11)
	stw 0,28(1)
	stw 10,24(1)
	lfd 13,0(11)
	lfd 0,24(1)
	li 11,0
	fsub 0,0,13
	frsp 13,0
	fcmpu 0,12,13
	bc 4,1,.L187
	lfs 0,3712(8)
	fcmpu 0,0,13
	bc 4,1,.L187
	li 11,1
.L187:
	cmpwi 0,11,0
	bc 12,2,.L183
	lis 11,level@ha
	lwz 8,84(29)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC79@ha
	lfs 13,3716(8)
	xoris 0,0,0x8000
	la 11,.LC79@l(11)
	stw 0,28(1)
	stw 10,24(1)
	lfd 12,0(11)
	lfd 0,24(1)
	lis 11,.LC80@ha
	la 11,.LC80@l(11)
	lfd 11,0(11)
	fsub 0,0,12
	frsp 0,0
	fsubs 13,13,0
	fabs 13,13
	fcmpu 0,13,11
	bc 4,1,.L189
	stfs 0,3716(8)
	li 0,1
	b .L190
.L189:
	li 0,0
.L190:
	cmpwi 0,0,0
	bc 12,2,.L183
	lis 9,gi@ha
	lis 3,.LC25@ha
	la 31,gi@l(9)
	la 3,.LC25@l(3)
	lwz 9,36(31)
	mtlr 9
	blrl
	lis 9,.LC81@ha
	lwz 11,16(31)
	mr 5,3
	la 9,.LC81@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,29
	mtlr 11
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	lfs 2,0(9)
	lis 9,.LC82@ha
	la 9,.LC82@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,84(30)
	lwz 0,3732(9)
	cmpwi 0,0,0
	bc 4,2,.L183
	mr 3,30
	bl lagged_out
	cmpwi 0,3,0
	bc 12,2,.L192
	lwz 5,84(30)
	lis 4,.LC77@ha
	mr 3,29
	lwz 0,12(31)
	la 4,.LC77@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L183
.L192:
	lwz 5,84(30)
	lis 4,.LC78@ha
	mr 3,29
	lwz 0,12(31)
	la 4,.LC78@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L183:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 check_4_lagpent,.Lfe9-check_4_lagpent
	.section	".rodata"
	.align 2
.LC83:
	.string	""
	.align 2
.LC84:
	.string	"weapon_railgun"
	.align 2
.LC85:
	.string	"Damage to you will be at least %d (railgun)\n"
	.align 2
.LC86:
	.string	"Damage to your target at least %d (railgun)\n"
	.align 2
.LC87:
	.string	"xv 32 yv 8 picn inventory yv 32 xv 64 string2 \"Balance of Power Help\" "
	.align 2
.LC88:
	.string	"yv 48 xv 64 string2 \"The Rules:\" "
	.align 2
.LC89:
	.string	"yv 64 xv 64 string \"High ping players may\" "
	.align 2
.LC90:
	.string	"yv 72 xv 64 string \"inflict more damage and\" "
	.align 2
.LC91:
	.string	"yv 80 xv 64 string \"absorb extra damage when\" "
	.align 2
.LC92:
	.string	"yv 88 xv 64 string \"they fight LPB's.\" "
	.align 2
.LC93:
	.string	"yv 104 xv 64 string \"HPB's flash red and blue\" "
	.align 2
.LC94:
	.string	"yv 112 xv 64 string \"to indicate resistance\" "
	.align 2
.LC95:
	.string	"yv 120 xv 64 string \"and strength adjustments\" "
	.align 2
.LC96:
	.string	"yv 128 xv 64 string \"respectively.\" "
	.align 2
.LC97:
	.string	"yv 144 xv 104 string2 \"--Press Enter--\" "
	.align 2
.LC98:
	.string	"yv 48 xv 64 string2 \"Lag Sickness:\" "
	.align 2
.LC99:
	.string	"yv 64 xv 64 string \"If you experience unusual\" "
	.align 2
.LC100:
	.string	"yv 72 xv 64 string \"lag, BoP will protect you\" "
	.align 2
.LC101:
	.string	"yv 80 xv 64 string \"from enemy attacks for a\" "
	.align 2
.LC102:
	.string	"yv 88 xv 64 string \"certain period of time.\" "
	.align 2
.LC103:
	.string	"yv 104 xv 64 string \"The price of this shield\" "
	.align 2
.LC104:
	.string	"yv 112 xv 64 string \"is a condition called lag\" "
	.align 2
.LC105:
	.string	"yv 120 xv 64 string \"sickness which prevents\" "
	.align 2
.LC106:
	.string	"yv 128 xv 64 string \"weapon usage temporarily.\" "
	.align 2
.LC107:
	.string	"yv 48 xv 64 string2 \"Server Specific Settings:\" "
	.align 2
.LC108:
	.string	"yv 64 xv 64 string \"This server is set to\" "
	.align 2
.LC109:
	.string	"yv 72 xv 64 string2 \"BOP %s mode\" "
	.align 2
.LC110:
	.string	"yv 88 xv 64 string \"HPB resistance is DISABLED\" "
	.align 2
.LC111:
	.string	"yv 88 xv 64 string \"HPB resistance is %0.2f:1\" "
	.align 2
.LC112:
	.string	"yv 104 xv 64 string \"HPB strength is DISABLED\" "
	.align 2
.LC113:
	.string	"yv 104 xv 64 string \"HPB strength is %0.2f:1\" "
	.align 2
.LC114:
	.string	"yv 128 xv 64 string \"After %0.1f seconds of\" "
	.align 2
.LC115:
	.string	"yv 136 xv 64 string \"phone-jack, you're\" "
	.align 2
.LC116:
	.string	"yv 144 xv 64 string \"lag sickness prone.\" "
	.align 2
.LC117:
	.long 0x0
	.align 2
.LC118:
	.long 0x3f800000
	.align 3
.LC119:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC120:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl refresh_bop_menu
	.type	 refresh_bop_menu,@function
refresh_bop_menu:
	stwu 1,-1248(1)
	mflr 0
	stmw 28,1232(1)
	stw 0,1252(1)
	lis 9,bop_invisible@ha
	mr 29,3
	lwz 0,bop_invisible@l(9)
	cmpwi 0,0,0
	bc 12,2,.L205
	lwz 9,84(29)
	lwz 0,3728(9)
	cmpwi 0,0,1
	bc 4,2,.L205
	li 0,2
	stw 0,3728(9)
.L205:
	addi 31,1,8
	lis 4,.LC87@ha
	la 4,.LC87@l(4)
	mr 3,31
	li 5,71
	crxor 6,6,6
	bl memcpy
	lwz 9,84(29)
	lwz 3,3728(9)
	cmpwi 0,3,1
	bc 4,2,.L206
	lis 4,.LC88@ha
	mr 3,31
	la 4,.LC88@l(4)
	bl strcat
	lis 4,.LC89@ha
	mr 3,31
	la 4,.LC89@l(4)
	bl strcat
	lis 4,.LC90@ha
	mr 3,31
	la 4,.LC90@l(4)
	bl strcat
	lis 4,.LC91@ha
	mr 3,31
	la 4,.LC91@l(4)
	bl strcat
	lis 4,.LC92@ha
	mr 3,31
	la 4,.LC92@l(4)
	bl strcat
	lis 4,.LC93@ha
	mr 3,31
	la 4,.LC93@l(4)
	bl strcat
	lis 4,.LC94@ha
	mr 3,31
	la 4,.LC94@l(4)
	bl strcat
	lis 4,.LC95@ha
	mr 3,31
	la 4,.LC95@l(4)
	bl strcat
	lis 4,.LC96@ha
	mr 3,31
	la 4,.LC96@l(4)
	b .L214
.L206:
	cmpwi 0,3,2
	bc 4,2,.L208
	lis 4,.LC98@ha
	mr 3,31
	la 4,.LC98@l(4)
	bl strcat
	lis 4,.LC99@ha
	mr 3,31
	la 4,.LC99@l(4)
	bl strcat
	lis 4,.LC100@ha
	mr 3,31
	la 4,.LC100@l(4)
	bl strcat
	lis 4,.LC101@ha
	mr 3,31
	la 4,.LC101@l(4)
	bl strcat
	lis 4,.LC102@ha
	mr 3,31
	la 4,.LC102@l(4)
	bl strcat
	lis 4,.LC103@ha
	mr 3,31
	la 4,.LC103@l(4)
	bl strcat
	lis 4,.LC104@ha
	mr 3,31
	la 4,.LC104@l(4)
	bl strcat
	lis 4,.LC105@ha
	mr 3,31
	la 4,.LC105@l(4)
	bl strcat
	lis 4,.LC106@ha
	mr 3,31
	la 4,.LC106@l(4)
.L214:
	bl strcat
	lis 4,.LC97@ha
	mr 3,31
	la 4,.LC97@l(4)
	bl strcat
	b .L207
.L208:
	lis 4,.LC107@ha
	addi 29,1,1032
	la 4,.LC107@l(4)
	mr 3,31
	bl strcat
	mr 30,29
	lis 4,.LC108@ha
	addi 28,1,1128
	la 4,.LC108@l(4)
	mr 3,31
	bl strcat
	mr 3,29
	bl get_mode_name
	lis 4,.LC109@ha
	mr 5,29
	la 4,.LC109@l(4)
	mr 3,28
	crxor 6,6,6
	bl sprintf
	mr 4,28
	mr 3,31
	bl strcat
	lis 11,.LC117@ha
	lis 9,laghelp_rst@ha
	la 11,.LC117@l(11)
	lfs 13,laghelp_rst@l(9)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L210
	lis 4,.LC110@ha
	mr 3,31
	la 4,.LC110@l(4)
	bl strcat
	b .L211
.L210:
	lis 9,.LC118@ha
	lis 4,.LC111@ha
	la 9,.LC118@l(9)
	la 4,.LC111@l(4)
	lfs 1,0(9)
	mr 3,30
	fadds 1,13,1
	creqv 6,6,6
	bl sprintf
	mr 3,31
	mr 4,30
	bl strcat
.L211:
	lis 11,.LC117@ha
	lis 9,laghelp_str@ha
	la 11,.LC117@l(11)
	lfs 13,laghelp_str@l(9)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L212
	lis 4,.LC112@ha
	addi 3,1,8
	la 4,.LC112@l(4)
	bl strcat
	b .L213
.L212:
	lis 9,.LC118@ha
	lis 4,.LC113@ha
	la 9,.LC118@l(9)
	la 4,.LC113@l(4)
	lfs 1,0(9)
	mr 3,30
	fadds 1,13,1
	creqv 6,6,6
	bl sprintf
	addi 3,1,8
	mr 4,30
	bl strcat
.L213:
	lis 9,lagged_out_detect@ha
	lwz 0,lagged_out_detect@l(9)
	lis 10,0x4330
	lis 4,.LC114@ha
	lis 9,.LC119@ha
	la 4,.LC114@l(4)
	xoris 0,0,0x8000
	la 9,.LC119@l(9)
	stw 0,1228(1)
	mr 3,30
	stw 10,1224(1)
	lfd 13,0(9)
	lfd 0,1224(1)
	lis 9,.LC120@ha
	la 9,.LC120@l(9)
	lfs 12,0(9)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 1,0
	creqv 6,6,6
	bl sprintf
	mr 4,30
	addi 3,1,8
	bl strcat
	lis 4,.LC115@ha
	addi 3,1,8
	la 4,.LC115@l(4)
	bl strcat
	lis 4,.LC116@ha
	addi 3,1,8
	la 4,.LC116@l(4)
	bl strcat
.L207:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	addi 3,1,8
	mtlr 0
	blrl
	lwz 0,1252(1)
	mtlr 0
	lmw 28,1232(1)
	la 1,1248(1)
	blr
.Lfe10:
	.size	 refresh_bop_menu,.Lfe10-refresh_bop_menu
	.section	".rodata"
	.align 2
.LC121:
	.string	"lagstats"
	.align 2
.LC122:
	.string	"bophelp"
	.align 2
.LC123:
	.string	"Bop help menu disabled\n"
	.align 3
.LC124:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC125:
	.long 0x40340000
	.long 0x0
	.section	".text"
	.align 2
	.globl bop_client_cmds
	.type	 bop_client_cmds,@function
bop_client_cmds:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 30,4
	mr 31,3
	lis 4,.LC121@ha
	mr 3,30
	la 4,.LC121@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L220
	mr 3,31
	bl Cmd_lagstats
	b .L221
.L220:
	lis 4,.LC122@ha
	mr 3,30
	la 4,.LC122@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L222
	lis 9,nobophelp@ha
	lwz 0,nobophelp@l(9)
	cmpwi 0,0,0
	bc 4,2,.L223
	lwz 9,84(31)
	lwz 0,3728(9)
	cmpwi 0,0,0
	bc 4,2,.L224
	li 0,1
	mr 3,31
	stw 0,3728(9)
	lwz 9,84(31)
	stw 0,3476(9)
	bl refresh_bop_menu
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L221
.L224:
	mr 3,31
	bl adv_bop_menu
	b .L221
.L223:
	lis 11,level@ha
	lwz 8,84(31)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC124@ha
	lfs 13,3716(8)
	xoris 0,0,0x8000
	la 11,.LC124@l(11)
	stw 0,20(1)
	stw 10,16(1)
	lfd 12,0(11)
	lfd 0,16(1)
	lis 11,.LC125@ha
	la 11,.LC125@l(11)
	lfd 11,0(11)
	fsub 0,0,12
	frsp 0,0
	fsubs 13,13,0
	fabs 13,13
	fcmpu 0,13,11
	bc 4,1,.L229
	stfs 0,3716(8)
	li 0,1
	b .L230
.L229:
	li 0,0
.L230:
	cmpwi 0,0,0
	bc 12,2,.L221
	lis 9,gi+8@ha
	lis 5,.LC123@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC123@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L221
.L222:
	li 3,0
	b .L232
.L221:
	li 3,1
.L232:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 bop_client_cmds,.Lfe11-bop_client_cmds
	.section	".rodata"
	.align 2
.LC126:
	.string	"laghelp_str"
	.align 2
.LC127:
	.string	"laghelp_rst"
	.align 2
.LC128:
	.string	"nobophelp"
	.align 2
.LC129:
	.string	"bopsickremove"
	.align 2
.LC130:
	.string	"laghelp"
	.align 2
.LC131:
	.string	"lagcap_str"
	.align 2
.LC132:
	.string	"lagcap_rst"
	.align 2
.LC133:
	.string	"gamemode"
	.align 2
.LC134:
	.string	"pingmax"
	.align 2
.LC135:
	.string	"pingmin"
	.align 2
.LC136:
	.string	"lagbare"
	.align 2
.LC137:
	.string	"lagpent"
	.align 2
.LC138:
	.string	"lagsick"
	.align 2
.LC139:
	.string	"lagpeak"
	.align 2
.LC140:
	.string	"lagtimeout"
	.align 2
.LC141:
	.string	"lagsuicide"
	.align 2
.LC142:
	.string	"lagslag"
	.align 2
.LC143:
	.string	"lagverbose"
	.align 2
.LC144:
	.string	"laginvisible"
	.align 2
.LC145:
	.string	"bopmanageobservers"
	.align 2
.LC146:
	.string	"sv"
	.align 2
.LC147:
	.string	"An 'sv' was received that should not be there, try again!\n"
	.section	".text"
	.align 2
	.globl process_bop_cmds
	.type	 process_bop_cmds,@function
process_bop_cmds:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 5,80
	lis 3,bop_twoarg@ha
	la 3,bop_twoarg@l(3)
	bl strncpy
	lis 4,.LC126@ha
	mr 3,31
	la 4,.LC126@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L234
	bl sv_laghelp_str
	b .L235
.L234:
	lis 4,.LC127@ha
	mr 3,31
	la 4,.LC127@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L236
	bl sv_laghelp_rst
	b .L235
.L236:
	lis 4,.LC128@ha
	mr 3,31
	la 4,.LC128@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L238
	bl sv_nobophelp
	b .L235
.L238:
	lis 4,.LC129@ha
	mr 3,31
	la 4,.LC129@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L240
	bl sv_bopsickremove
	b .L235
.L240:
	lis 4,.LC130@ha
	mr 3,31
	la 4,.LC130@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L242
	bl sv_laghelp_old
	b .L235
.L242:
	lis 4,.LC131@ha
	mr 3,31
	la 4,.LC131@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L244
	bl sv_lagcap_str
	b .L235
.L244:
	lis 4,.LC132@ha
	mr 3,31
	la 4,.LC132@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L246
	bl sv_lagcap_rst
	b .L235
.L246:
	lis 4,.LC133@ha
	mr 3,31
	la 4,.LC133@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L248
	bl sv_gamemode
	b .L235
.L248:
	lis 4,.LC134@ha
	mr 3,31
	la 4,.LC134@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L250
	bl sv_pingmax
	b .L235
.L250:
	lis 4,.LC135@ha
	mr 3,31
	la 4,.LC135@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L252
	bl sv_pingmin
	b .L235
.L252:
	lis 4,.LC136@ha
	mr 3,31
	la 4,.LC136@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L254
	bl sv_lagbare
	b .L235
.L254:
	lis 4,.LC137@ha
	mr 3,31
	la 4,.LC137@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L256
	bl sv_lagpent
	b .L235
.L256:
	lis 4,.LC138@ha
	mr 3,31
	la 4,.LC138@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L258
	bl sv_lagsick
	b .L235
.L258:
	lis 4,.LC139@ha
	mr 3,31
	la 4,.LC139@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L260
	bl sv_lagpeak
	b .L235
.L260:
	lis 4,.LC140@ha
	mr 3,31
	la 4,.LC140@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L262
	bl sv_lagtimeout
	b .L235
.L262:
	lis 4,.LC141@ha
	mr 3,31
	la 4,.LC141@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L264
	bl sv_lagsuicide
	b .L235
.L264:
	lis 4,.LC142@ha
	mr 3,31
	la 4,.LC142@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L266
	bl sv_lagslag
	b .L235
.L266:
	lis 4,.LC143@ha
	mr 3,31
	la 4,.LC143@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L268
	bl sv_verbose
	b .L235
.L268:
	lis 4,.LC144@ha
	mr 3,31
	la 4,.LC144@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L270
	bl sv_invisible
	b .L235
.L270:
	lis 4,.LC145@ha
	mr 3,31
	la 4,.LC145@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L272
	bl sv_bopmanageobservers
	b .L235
.L272:
	lis 4,.LC146@ha
	mr 3,31
	la 4,.LC146@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L274
	li 3,0
	b .L276
.L274:
	lis 9,gi+8@ha
	lis 5,.LC147@ha
	lwz 0,gi+8@l(9)
	la 5,.LC147@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L235:
	li 3,1
.L276:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 process_bop_cmds,.Lfe12-process_bop_cmds
	.section	".rodata"
	.align 2
.LC150:
	.string	"TOURNAMENT"
	.align 2
.LC151:
	.string	"Bug in Gamemode func!\n"
	.align 2
.LC152:
	.string	"BOP is now set to %s mode.\n"
	.align 2
.LC148:
	.long 0x3d8f5c29
	.align 2
.LC149:
	.long 0x3e19999a
	.section	".text"
	.align 2
	.globl sv_gamemode
	.type	 sv_gamemode,@function
sv_gamemode:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	bl getargi
	subfic 0,3,2
	subfe 0,0,0
	nand 0,0,0
	lis 9,game_mode@ha
	and 3,3,0
	cmpwi 0,3,1
	stb 3,game_mode@l(9)
	bc 12,2,.L281
	bc 12,1,.L285
	cmpwi 0,3,0
	bc 12,2,.L280
	b .L283
.L285:
	cmpwi 0,3,2
	bc 12,2,.L282
	b .L283
.L280:
	lis 9,.LC49@ha
	lis 3,0x3f00
	lwz 6,.LC49@l(9)
	lis 7,max_delta_ping@ha
	li 8,1000
	la 9,.LC49@l(9)
	lis 11,min_delta_ping@ha
	lbz 29,6(9)
	li 0,100
	addi 5,1,8
	lhz 4,4(9)
	lis 10,laghelp_str@ha
	lis 9,laghelp_rst@ha
	stw 6,8(1)
	stw 8,max_delta_ping@l(7)
	stw 0,min_delta_ping@l(11)
	stw 3,laghelp_rst@l(9)
	stb 29,6(5)
	stw 3,laghelp_str@l(10)
	sth 4,4(5)
	b .L279
.L281:
	lis 9,.LC53@ha
	lis 11,.LC148@ha
	lis 10,.LC149@ha
	lwz 29,.LC53@l(9)
	lis 5,max_delta_ping@ha
	lfs 13,.LC148@l(11)
	la 9,.LC53@l(9)
	li 8,1000
	lfs 0,.LC149@l(10)
	lis 7,min_delta_ping@ha
	li 0,225
	lbz 4,6(9)
	lis 10,laghelp_str@ha
	lis 11,laghelp_rst@ha
	lhz 6,4(9)
	addi 3,1,8
	stw 29,8(1)
	stw 8,max_delta_ping@l(5)
	stw 0,min_delta_ping@l(7)
	stfs 13,laghelp_str@l(10)
	stfs 0,laghelp_rst@l(11)
	stb 4,6(3)
	sth 6,4(3)
	b .L279
.L282:
	lis 9,.LC150@ha
	li 6,500
	lwz 3,.LC150@l(9)
	li 0,0
	lis 8,min_delta_ping@ha
	la 9,.LC150@l(9)
	lis 11,laghelp_rst@ha
	lbz 29,10(9)
	addi 10,1,8
	lis 4,max_delta_ping@ha
	lwz 28,4(9)
	lis 7,laghelp_str@ha
	lhz 5,8(9)
	stw 3,8(1)
	stw 6,min_delta_ping@l(8)
	stw 0,laghelp_rst@l(11)
	stb 29,10(10)
	stw 6,max_delta_ping@l(4)
	stw 0,laghelp_str@l(7)
	stw 28,4(10)
	sth 5,8(10)
	b .L279
.L283:
	lis 9,gi+8@ha
	lis 5,.LC151@ha
	lwz 0,gi+8@l(9)
	la 5,.LC151@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L279:
	lis 9,gi+8@ha
	lis 5,.LC152@ha
	lwz 0,gi+8@l(9)
	la 5,.LC152@l(5)
	li 3,0
	li 4,2
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe13:
	.size	 sv_gamemode,.Lfe13-sv_gamemode
	.section	".rodata"
	.align 2
.LC153:
	.string	"Strength bonus cannot exceed %f:1\n"
	.align 2
.LC154:
	.string	"Caution: High numbers may crash the server!\n"
	.align 2
.LC155:
	.string	"Caution: Much higher and lagged players can gib LPB's with a blaster\n"
	.align 2
.LC156:
	.string	"Notice: You have DISABLED HPB strength adjustment!\n"
	.align 2
.LC157:
	.long 0x0
	.align 2
.LC158:
	.long 0x3f800000
	.align 2
.LC159:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl sv_laghelp_str
	.type	 sv_laghelp_str,@function
sv_laghelp_str:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 29,20(1)
	stw 0,52(1)
	bl getargf
	lis 9,.LC157@ha
	la 9,.LC157@l(9)
	lfs 30,0(9)
	fcmpu 0,1,30
	cror 3,2,1
	bc 4,3,.L287
	lis 9,laghelp_str@ha
	stfs 1,laghelp_str@l(9)
.L287:
	lis 9,.LC158@ha
	lis 29,laghelp_str@ha
	la 9,.LC158@l(9)
	lfs 1,laghelp_str@l(29)
	lis 5,.LC153@ha
	lfs 31,0(9)
	la 5,.LC153@l(5)
	li 3,0
	lis 9,gi@ha
	li 4,2
	la 31,gi@l(9)
	fadds 1,1,31
	lwz 9,8(31)
	mtlr 9
	creqv 6,6,6
	blrl
	lis 9,.LC159@ha
	lfs 13,laghelp_str@l(29)
	la 9,.LC159@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L288
	lwz 0,8(31)
	lis 5,.LC154@ha
	li 3,0
	la 5,.LC154@l(5)
	b .L293
.L288:
	fcmpu 0,13,31
	bc 4,1,.L290
	lwz 0,8(31)
	lis 5,.LC155@ha
	li 3,0
	la 5,.LC155@l(5)
.L293:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L289
.L290:
	fcmpu 0,13,30
	bc 4,2,.L289
	lwz 0,8(31)
	lis 5,.LC156@ha
	li 3,0
	la 5,.LC156@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L289:
	lwz 0,52(1)
	mtlr 0
	lmw 29,20(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe14:
	.size	 sv_laghelp_str,.Lfe14-sv_laghelp_str
	.section	".rodata"
	.align 2
.LC160:
	.string	"Resistance bonus cannot exceed %f:1\n"
	.align 2
.LC161:
	.string	"Caution: Much higher and lagged players will be impossible to frag\n"
	.align 2
.LC162:
	.string	"Notice: You have DISABLED HPB resistance adjustment!\n"
	.align 2
.LC163:
	.long 0x0
	.align 2
.LC164:
	.long 0x3f800000
	.align 2
.LC165:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl sv_laghelp_rst
	.type	 sv_laghelp_rst,@function
sv_laghelp_rst:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 29,20(1)
	stw 0,52(1)
	bl getargf
	lis 9,.LC163@ha
	la 9,.LC163@l(9)
	lfs 30,0(9)
	fcmpu 0,1,30
	cror 3,2,1
	bc 4,3,.L295
	lis 9,laghelp_rst@ha
	stfs 1,laghelp_rst@l(9)
.L295:
	lis 9,.LC164@ha
	lis 29,laghelp_rst@ha
	la 9,.LC164@l(9)
	lfs 1,laghelp_rst@l(29)
	lis 5,.LC160@ha
	lfs 31,0(9)
	la 5,.LC160@l(5)
	li 3,0
	lis 9,gi@ha
	li 4,2
	la 31,gi@l(9)
	fadds 1,1,31
	lwz 9,8(31)
	mtlr 9
	creqv 6,6,6
	blrl
	lis 9,.LC165@ha
	lfs 13,laghelp_rst@l(29)
	la 9,.LC165@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L296
	lwz 0,8(31)
	lis 5,.LC154@ha
	li 3,0
	la 5,.LC154@l(5)
	b .L301
.L296:
	fcmpu 0,13,31
	bc 4,1,.L298
	lwz 0,8(31)
	lis 5,.LC161@ha
	li 3,0
	la 5,.LC161@l(5)
.L301:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L297
.L298:
	fcmpu 0,13,30
	bc 4,2,.L297
	lwz 0,8(31)
	lis 5,.LC162@ha
	li 3,0
	la 5,.LC162@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L297:
	lwz 0,52(1)
	mtlr 0
	lmw 29,20(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 sv_laghelp_rst,.Lfe15-sv_laghelp_rst
	.section	".rodata"
	.align 2
.LC166:
	.string	"Bop Help Menu ENABLED\n"
	.align 2
.LC167:
	.string	"Bop Help Menu DISABLED\n"
	.align 2
.LC168:
	.string	"Lag sick players will become observers temporarily\n"
	.align 2
.LC169:
	.string	"Lag sick players will get stay visible\n"
	.align 2
.LC170:
	.string	"Notice: sv laghelp is now an obsolete command.\n"
	.align 2
.LC171:
	.string	"Try sv laghelp_str and sv laghelp_rst!\n"
	.align 2
.LC172:
	.string	"Lag strength cap is obsolete!  Use laghelp_str as your cap\n"
	.align 2
.LC173:
	.string	"Lag resistance cap is obsolete!  Use laghelp_rst as your cap\n"
	.align 2
.LC174:
	.string	"Max Delta Ping is %d\n"
	.align 2
.LC175:
	.string	"Min Delta Ping is %d\n"
	.align 2
.LC176:
	.string	"LagBare time is %d seconds\n"
	.align 2
.LC177:
	.string	"Make sure you check the value of lagsick!\n"
	.align 2
.LC178:
	.string	"Lagpent will now last for %d seconds\n"
	.align 2
.LC179:
	.string	"Make sure you check the value for lagsick!\n"
	.align 2
.LC180:
	.string	"Lagsick set for %d seconds (%f actual)\n"
	.align 2
.LC181:
	.long 0x41200000
	.align 3
.LC182:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl sv_lagsick
	.type	 sv_lagsick,@function
sv_lagsick:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl getargi
	mr. 3,3
	bc 12,2,.L320
	lis 9,bop_deadtime@ha
	lfs 12,bop_deadtime@l(9)
	xoris 0,3,0x8000
	lis 10,0x4330
	lis 9,.LC181@ha
	stw 0,12(1)
	la 9,.LC181@l(9)
	stw 10,8(1)
	lfs 13,0(9)
	lis 9,bop_getawaytime@ha
	lfs 0,bop_getawaytime@l(9)
	lis 9,.LC182@ha
	la 9,.LC182@l(9)
	fsubs 12,12,0
	lfd 11,0(9)
	lfd 0,8(1)
	fdivs 13,12,13
	fsub 0,0,11
	frsp 0,0
	fcmpu 0,0,13
	bc 4,0,.L320
	mulli 0,3,10
	mr 9,11
	lis 11,lagsicktime@ha
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 10,8(1)
	lfd 0,8(1)
	fsub 0,0,11
	frsp 0,0
	fsubs 0,12,0
	stfs 0,lagsicktime@l(11)
	b .L321
.L320:
	lis 9,bop_deadtime@ha
	lis 10,bop_getawaytime@ha
	lfs 0,bop_deadtime@l(9)
	lis 11,lagsicktime@ha
	lfs 11,bop_getawaytime@l(10)
	lis 9,.LC181@ha
	lfs 12,lagsicktime@l(11)
	la 9,.LC181@l(9)
	lfs 10,0(9)
	fsubs 0,0,11
	fsubs 0,0,12
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
.L321:
	lis 9,lagsicktime@ha
	lis 11,gi+8@ha
	lfs 1,lagsicktime@l(9)
	lis 5,.LC180@ha
	mr 6,3
	lwz 0,gi+8@l(11)
	la 5,.LC180@l(5)
	li 3,0
	li 4,2
	mtlr 0
	creqv 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 sv_lagsick,.Lfe16-sv_lagsick
	.section	".rodata"
	.align 2
.LC183:
	.string	"You'll get lag pent if your ping exceeds %d\n"
	.align 2
.LC184:
	.string	"See also 'sv lagtimeout'\n"
	.align 2
.LC185:
	.string	"Users will get lagpent after %d frames of ping-freeze (10 frames = 1 second)\n"
	.align 2
.LC186:
	.string	"Suicide lag protection "
	.align 2
.LC187:
	.string	"DISABLED\n"
	.align 2
.LC188:
	.string	"ENABLED\n"
	.align 2
.LC189:
	.string	"Lag non-player protection "
	.align 2
.LC190:
	.string	"Verbose messaging "
	.align 2
.LC191:
	.string	"BOP Quake2 mod is now "
	.align 2
.LC192:
	.string	"INVISIBLE\n"
	.align 2
.LC193:
	.string	"VISIBLE\n"
	.align 2
.LC194:
	.string	"BOP Observer Managing is %i\n"
	.align 2
.LC195:
	.string	"BoP running:\nLHS=%f\nLHR=%f\nLB=%f\nLPt=%f\nLPk=%d\nMiDP=%d MxDP=%d\nLS=%f\nNSuP=%d\nNSlP=%d\nLV=%d\nMI=%d\n"
	.align 3
.LC196:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC197:
	.long 0x40340000
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_lagstats
	.type	 Cmd_lagstats,@function
Cmd_lagstats:
	stwu 1,-304(1)
	mflr 0
	stmw 26,280(1)
	stw 0,308(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 10,0x4330
	mr 31,3
	lis 9,.LC196@ha
	xoris 0,0,0x8000
	la 9,.LC196@l(9)
	stw 0,276(1)
	stw 10,272(1)
	lfd 12,0(9)
	lfd 13,272(1)
	lis 9,.LC197@ha
	la 9,.LC197@l(9)
	lfd 11,0(9)
	fsub 13,13,12
	lwz 9,84(31)
	lfs 0,3716(9)
	frsp 13,13
	fsubs 0,0,13
	fabs 0,0
	fcmpu 0,0,11
	bc 4,1,.L341
	stfs 13,3716(9)
	li 0,1
	b .L342
.L341:
	li 0,0
.L342:
	cmpwi 0,0,0
	bc 12,2,.L340
	lis 9,laghelp_str@ha
	lis 11,laghelp_rst@ha
	lis 10,bop_deadtime@ha
	lis 8,bop_getawaytime@ha
	lfs 1,laghelp_str@l(9)
	lis 7,lagsicktime@ha
	lfs 2,laghelp_rst@l(11)
	lis 9,lag_threshold@ha
	lfs 3,bop_deadtime@l(10)
	lis 26,bop_invisible@ha
	lis 11,min_delta_ping@ha
	lfs 4,bop_getawaytime@l(8)
	lis 10,no_suicide_protect@ha
	lis 28,max_delta_ping@ha
	lfs 5,lagsicktime@l(7)
	lis 27,no_slag_protect@ha
	lis 29,bop_verbose@ha
	lwz 5,lag_threshold@l(9)
	lis 4,.LC195@ha
	addi 3,1,16
	lwz 0,bop_invisible@l(26)
	la 4,.LC195@l(4)
	lwz 8,no_suicide_protect@l(10)
	lwz 6,min_delta_ping@l(11)
	lwz 9,no_slag_protect@l(27)
	lwz 7,max_delta_ping@l(28)
	lwz 10,bop_verbose@l(29)
	stw 0,8(1)
	creqv 6,6,6
	bl sprintf
	lis 9,gi+8@ha
	lis 5,.LC12@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC12@l(5)
	li 4,2
	addi 6,1,16
	mtlr 0
	crxor 6,6,6
	blrl
.L340:
	lwz 0,308(1)
	mtlr 0
	lmw 26,280(1)
	la 1,304(1)
	blr
.Lfe17:
	.size	 Cmd_lagstats,.Lfe17-Cmd_lagstats
	.section	".rodata"
	.align 2
.LC198:
	.string	"dies the lonely death"
	.align 2
.LC199:
	.string	"fell into her boots"
	.align 2
.LC200:
	.string	"fell into his boots"
	.align 2
.LC201:
	.string	"was crushed like a grapefruit"
	.align 2
.LC202:
	.string	"forgot to grab a rebreather"
	.align 2
.LC203:
	.string	"melted"
	.align 2
.LC204:
	.string	"can't exist on slag alone"
	.align 2
.LC205:
	.string	"was blown up"
	.align 2
.LC206:
	.string	"found a way out"
	.align 2
.LC207:
	.string	"got abdominal surgery"
	.align 2
.LC208:
	.string	"got electrocuted"
	.align 2
.LC209:
	.string	"died the death"
	.align 2
.LC210:
	.string	"got stuck to her grenade"
	.align 2
.LC211:
	.string	"got stuck to his grenade"
	.align 2
.LC212:
	.string	"tried to put the pin back in"
	.align 2
.LC213:
	.string	"got too quad happy"
	.align 2
.LC214:
	.string	"becomes bored with life"
	.align 2
.LC215:
	.string	"pointed the BFG the wrong way"
	.align 2
.LC216:
	.string	"cracked her own pate"
	.align 2
.LC217:
	.string	"cracked his own pate"
	.align 2
.LC218:
	.string	"%s %s.\n"
	.align 2
.LC219:
	.string	"was humiliated by"
	.align 2
.LC220:
	.string	"'s blaster"
	.align 2
.LC221:
	.string	"was picked-off by"
	.align 2
.LC222:
	.string	"was blown away by"
	.align 2
.LC223:
	.string	"'s super shotgun"
	.align 2
.LC224:
	.string	"was machine-gunned by"
	.align 2
.LC225:
	.string	"was sawn in half by"
	.align 2
.LC226:
	.string	"'s chaingun"
	.align 2
.LC227:
	.string	"ate"
	.align 2
.LC228:
	.string	"'s pineapple"
	.align 2
.LC229:
	.string	"was snagged by"
	.align 2
.LC230:
	.string	"'s grenade"
	.align 2
.LC231:
	.string	"got her world rocked by"
	.align 2
.LC232:
	.string	"got his world rocked by"
	.align 2
.LC233:
	.string	"'s quad rocket"
	.align 2
.LC234:
	.string	"was gibbed by"
	.align 2
.LC235:
	.string	"'s rocket"
	.align 2
.LC236:
	.string	"was obliterated by"
	.align 2
.LC237:
	.string	"was gibbed into meat chunks by"
	.align 2
.LC238:
	.string	"was melted by"
	.align 2
.LC239:
	.string	"'s hyperblaster"
	.align 2
.LC240:
	.string	"was railed by"
	.align 2
.LC241:
	.string	"saw the pretty lights from"
	.align 2
.LC242:
	.string	"'s BFG"
	.align 2
.LC243:
	.string	"didn't feel a thing as"
	.align 2
.LC244:
	.string	"'s quad BFG ripped her body apart"
	.align 2
.LC245:
	.string	"'s quad BFG ripped his body apart"
	.align 2
.LC246:
	.string	"intercepted"
	.align 2
.LC247:
	.string	"'s big green ball"
	.align 2
.LC248:
	.string	"sprinted like a madwoman from"
	.align 2
.LC249:
	.string	"'s quad BFG and got vaporized for her trouble"
	.align 2
.LC250:
	.string	"sprinted like a madman from"
	.align 2
.LC251:
	.string	"'s quad BFG and got vaporized for his trouble"
	.align 2
.LC252:
	.string	"couldn't hide from"
	.align 2
.LC253:
	.string	"played catch with"
	.align 2
.LC254:
	.string	"'s handgrenade"
	.align 2
.LC255:
	.string	"cartwheeled over"
	.align 2
.LC256:
	.string	"feels"
	.align 2
.LC257:
	.string	"'s pain"
	.align 2
.LC258:
	.string	"was caught trespassing on"
	.align 2
.LC259:
	.string	"'s pad"
	.align 2
.LC260:
	.string	"forgot to run from pent-girl"
	.align 2
.LC261:
	.string	"forgot to run from pent-boy"
	.align 2
.LC262:
	.string	"%s %s %s%s\n"
	.align 2
.LC263:
	.string	"%s died.\n"
	.align 3
.LC264:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC265:
	.long 0x0
	.section	".text"
	.align 2
	.globl LagObituary
	.type	 LagObituary,@function
LagObituary:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	mr 29,3
	mr 28,5
	lwz 10,84(29)
	li 26,0
	cmpwi 0,10,0
	bc 12,2,.L346
	lis 11,level@ha
	lfs 12,3688(10)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC264@ha
	xoris 0,0,0x8000
	la 11,.LC264@l(11)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(11)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 7,12,0
	mfcr 25
	rlwinm 25,25,30,1
.L346:
	lwz 10,84(28)
	cmpwi 6,10,0
	bc 12,26,.L347
	lis 11,level@ha
	lfs 12,3688(10)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC264@ha
	xoris 0,0,0x8000
	la 11,.LC264@l(11)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(11)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 7,12,0
	mfcr 26
	rlwinm 26,26,30,1
.L347:
	lis 9,.LC265@ha
	lis 11,coop@ha
	la 9,.LC265@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L348
	bc 12,26,.L348
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L348:
	lis 11,.LC265@ha
	lis 9,deathmatch@ha
	la 11,.LC265@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L350
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L349
.L350:
	lis 9,meansOfDeath@ha
	lis 11,.LC83@ha
	lwz 0,meansOfDeath@l(9)
	la 30,.LC83@l(11)
	li 31,0
	rlwinm 27,0,0,5,3
	rlwinm 24,0,0,4,4
	addi 10,27,-17
	cmplwi 0,10,16
	bc 12,1,.L351
	lis 11,.L368@ha
	slwi 10,10,2
	la 11,.L368@l(11)
	lis 9,.L368@ha
	lwzx 0,10,11
	la 9,.L368@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L368:
	.long .L357-.L368
	.long .L358-.L368
	.long .L359-.L368
	.long .L356-.L368
	.long .L351-.L368
	.long .L353-.L368
	.long .L352-.L368
	.long .L351-.L368
	.long .L361-.L368
	.long .L361-.L368
	.long .L367-.L368
	.long .L362-.L368
	.long .L367-.L368
	.long .L363-.L368
	.long .L367-.L368
	.long .L351-.L368
	.long .L364-.L368
.L352:
	lis 9,.LC198@ha
	la 31,.LC198@l(9)
	b .L351
.L353:
	mr 3,29
	crxor 6,6,6
	bl IsFemale
	cmpwi 0,3,0
	bc 12,2,.L354
	lis 9,.LC199@ha
	la 31,.LC199@l(9)
	b .L351
.L354:
	lis 9,.LC200@ha
	la 31,.LC200@l(9)
	b .L351
.L356:
	lis 9,.LC201@ha
	la 31,.LC201@l(9)
	b .L351
.L357:
	lis 9,.LC202@ha
	la 31,.LC202@l(9)
	b .L351
.L358:
	lis 9,.LC203@ha
	la 31,.LC203@l(9)
	b .L351
.L359:
	lis 9,.LC204@ha
	la 31,.LC204@l(9)
	b .L351
.L361:
	lis 9,.LC205@ha
	la 31,.LC205@l(9)
	b .L351
.L362:
	lis 9,.LC206@ha
	la 31,.LC206@l(9)
	b .L351
.L363:
	lis 9,.LC207@ha
	la 31,.LC207@l(9)
	b .L351
.L364:
	lis 9,.LC208@ha
	la 31,.LC208@l(9)
	b .L351
.L367:
	lis 9,.LC209@ha
	la 31,.LC209@l(9)
.L351:
	cmpw 0,28,29
	bc 4,2,.L370
	addi 10,27,-7
	cmplwi 0,10,17
	bc 12,1,.L381
	lis 11,.L384@ha
	slwi 10,10,2
	la 11,.L384@l(11)
	lis 9,.L384@ha
	lwzx 0,10,11
	la 9,.L384@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L384:
	.long .L376-.L384
	.long .L381-.L384
	.long .L377-.L384
	.long .L381-.L384
	.long .L381-.L384
	.long .L381-.L384
	.long .L380-.L384
	.long .L381-.L384
	.long .L381-.L384
	.long .L376-.L384
	.long .L381-.L384
	.long .L381-.L384
	.long .L381-.L384
	.long .L381-.L384
	.long .L381-.L384
	.long .L381-.L384
	.long .L381-.L384
	.long .L372-.L384
.L372:
	mr 3,29
	crxor 6,6,6
	bl IsFemale
	cmpwi 0,3,0
	bc 12,2,.L373
	lis 9,.LC210@ha
	la 31,.LC210@l(9)
	b .L370
.L373:
	lis 9,.LC211@ha
	la 31,.LC211@l(9)
	b .L370
.L376:
	lis 9,.LC212@ha
	la 31,.LC212@l(9)
	b .L370
.L377:
	cmpwi 0,25,0
	bc 12,2,.L378
	lis 9,.LC213@ha
	la 31,.LC213@l(9)
	b .L370
.L378:
	lis 9,.LC214@ha
	la 31,.LC214@l(9)
	b .L370
.L380:
	lis 9,.LC215@ha
	la 31,.LC215@l(9)
	b .L370
.L381:
	mr 3,29
	crxor 6,6,6
	bl IsFemale
	cmpwi 0,3,0
	bc 12,2,.L382
	lis 9,.LC216@ha
	la 31,.LC216@l(9)
	b .L370
.L382:
	lis 9,.LC217@ha
	la 31,.LC217@l(9)
.L370:
	cmpwi 0,31,0
	bc 12,2,.L385
	lis 9,gi@ha
	lwz 5,84(29)
	lis 4,.LC218@ha
	lwz 0,gi@l(9)
	la 4,.LC218@l(4)
	mr 6,31
	addi 5,5,700
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,.LC265@ha
	lis 11,deathmatch@ha
	la 9,.LC265@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L386
	lwz 11,84(29)
	lwz 9,3424(11)
	addi 9,9,-1
	stw 9,3424(11)
.L386:
	li 0,0
	stw 0,540(29)
	b .L345
.L385:
	cmpwi 0,28,0
	stw 28,540(29)
	bc 12,2,.L349
	lwz 10,84(28)
	cmpwi 0,10,0
	bc 12,2,.L349
	lis 11,level@ha
	lfs 12,3692(10)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC264@ha
	xoris 0,0,0x8000
	la 11,.LC264@l(11)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(11)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	cror 3,2,0
	bc 4,3,.L388
	addi 0,27,-1
	cmplwi 0,0,23
	bc 12,1,.L428
	lis 11,.L426@ha
	slwi 10,0,2
	la 11,.L426@l(11)
	lis 9,.L426@ha
	lwzx 0,10,11
	la 9,.L426@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L426:
	.long .L390-.L426
	.long .L391-.L426
	.long .L392-.L426
	.long .L393-.L426
	.long .L394-.L426
	.long .L395-.L426
	.long .L396-.L426
	.long .L397-.L426
	.long .L404-.L426
	.long .L409-.L426
	.long .L410-.L426
	.long .L411-.L426
	.long .L412-.L426
	.long .L417-.L426
	.long .L422-.L426
	.long .L423-.L426
	.long .L428-.L426
	.long .L428-.L426
	.long .L428-.L426
	.long .L428-.L426
	.long .L425-.L426
	.long .L428-.L426
	.long .L428-.L426
	.long .L424-.L426
.L390:
	lis 9,.LC219@ha
	lis 11,.LC220@ha
	la 31,.LC219@l(9)
	la 30,.LC220@l(11)
	b .L428
.L391:
	lis 9,.LC221@ha
	la 31,.LC221@l(9)
	b .L428
.L392:
	lis 9,.LC222@ha
	lis 11,.LC223@ha
	la 31,.LC222@l(9)
	la 30,.LC223@l(11)
	b .L428
.L393:
	lis 9,.LC224@ha
	la 31,.LC224@l(9)
	b .L428
.L394:
	lis 9,.LC225@ha
	lis 11,.LC226@ha
	la 31,.LC225@l(9)
	la 30,.LC226@l(11)
	b .L428
.L395:
	lis 9,.LC227@ha
	lis 11,.LC228@ha
	la 31,.LC227@l(9)
	la 30,.LC228@l(11)
	b .L428
.L396:
	lis 9,.LC229@ha
	lis 11,.LC230@ha
	la 31,.LC229@l(9)
	la 30,.LC230@l(11)
	b .L428
.L397:
	cmpwi 0,26,0
	bc 12,2,.L398
	mr 3,29
	crxor 6,6,6
	bl IsFemale
	cmpwi 0,3,0
	bc 12,2,.L399
	lis 9,.LC231@ha
	la 31,.LC231@l(9)
	b .L400
.L399:
	lis 9,.LC232@ha
	la 31,.LC232@l(9)
.L400:
	lis 9,.LC233@ha
	la 30,.LC233@l(9)
	b .L428
.L398:
	lwz 0,480(29)
	cmpwi 0,0,-40
	bc 4,0,.L407
	lis 9,.LC234@ha
	lis 11,.LC235@ha
	la 31,.LC234@l(9)
	la 30,.LC235@l(11)
	b .L428
.L404:
	cmpwi 0,26,0
	bc 12,2,.L405
	lis 9,.LC236@ha
	lis 11,.LC233@ha
	la 31,.LC236@l(9)
	la 30,.LC233@l(11)
	b .L428
.L405:
	lwz 0,480(29)
	cmpwi 0,0,-40
	bc 4,0,.L407
	lis 9,.LC237@ha
	lis 11,.LC235@ha
	la 31,.LC237@l(9)
	la 30,.LC235@l(11)
	b .L428
.L407:
	lis 9,.LC227@ha
	lis 11,.LC235@ha
	la 31,.LC227@l(9)
	la 30,.LC235@l(11)
	b .L428
.L409:
	lis 9,.LC238@ha
	lis 11,.LC239@ha
	la 31,.LC238@l(9)
	la 30,.LC239@l(11)
	b .L428
.L410:
	lis 9,.LC240@ha
	la 31,.LC240@l(9)
	b .L428
.L411:
	lis 9,.LC241@ha
	lis 11,.LC242@ha
	la 31,.LC241@l(9)
	la 30,.LC242@l(11)
	b .L428
.L412:
	cmpwi 0,26,0
	bc 12,2,.L413
	lis 9,.LC243@ha
	mr 3,29
	la 31,.LC243@l(9)
	crxor 6,6,6
	bl IsFemale
	cmpwi 0,3,0
	bc 12,2,.L414
	lis 9,.LC244@ha
	la 30,.LC244@l(9)
	b .L428
.L414:
	lis 9,.LC245@ha
	la 30,.LC245@l(9)
	b .L428
.L413:
	lis 9,.LC246@ha
	lis 11,.LC247@ha
	la 31,.LC246@l(9)
	la 30,.LC247@l(11)
	b .L428
.L417:
	cmpwi 0,26,0
	bc 12,2,.L418
	mr 3,29
	crxor 6,6,6
	bl IsFemale
	cmpwi 0,3,0
	bc 12,2,.L419
	lis 9,.LC248@ha
	lis 11,.LC249@ha
	la 31,.LC248@l(9)
	la 30,.LC249@l(11)
	b .L428
.L419:
	lis 9,.LC250@ha
	lis 11,.LC251@ha
	la 31,.LC250@l(9)
	la 30,.LC251@l(11)
	b .L428
.L418:
	lis 9,.LC252@ha
	lis 11,.LC242@ha
	la 31,.LC252@l(9)
	la 30,.LC242@l(11)
	b .L428
.L422:
	lis 9,.LC253@ha
	lis 11,.LC254@ha
	la 31,.LC253@l(9)
	la 30,.LC254@l(11)
	b .L428
.L423:
	lis 9,.LC255@ha
	lis 11,.LC254@ha
	la 31,.LC255@l(9)
	la 30,.LC254@l(11)
	b .L428
.L424:
	lis 9,.LC256@ha
	lis 11,.LC257@ha
	la 31,.LC256@l(9)
	la 30,.LC257@l(11)
	b .L428
.L425:
	lis 9,.LC258@ha
	lis 11,.LC259@ha
	la 31,.LC258@l(9)
	la 30,.LC259@l(11)
	b .L428
.L388:
	mr 3,28
	crxor 6,6,6
	bl IsFemale
	cmpwi 0,3,0
	bc 12,2,.L429
	lis 9,.LC260@ha
	la 31,.LC260@l(9)
	b .L428
.L429:
	lis 9,.LC261@ha
	la 31,.LC261@l(9)
.L428:
	cmpwi 0,31,0
	bc 12,2,.L349
	lis 9,gi@ha
	lwz 5,84(29)
	lis 4,.LC262@ha
	lwz 0,gi@l(9)
	la 4,.LC262@l(4)
	mr 6,31
	lwz 7,84(28)
	addi 5,5,700
	mr 8,30
	li 3,1
	mtlr 0
	addi 7,7,700
	crxor 6,6,6
	blrl
	lis 9,.LC265@ha
	lis 11,deathmatch@ha
	la 9,.LC265@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L345
	cmpwi 0,24,0
	bc 12,2,.L433
	lwz 11,84(28)
	b .L436
.L433:
	lwz 11,84(28)
	lwz 9,3424(11)
	addi 9,9,1
	b .L437
.L349:
	lis 9,gi@ha
	lwz 5,84(29)
	lis 4,.LC263@ha
	lwz 0,gi@l(9)
	la 4,.LC263@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,.LC265@ha
	lis 11,deathmatch@ha
	la 9,.LC265@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L345
	lwz 11,84(29)
.L436:
	lwz 9,3424(11)
	addi 9,9,-1
.L437:
	stw 9,3424(11)
.L345:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 LagObituary,.Lfe18-LagObituary
	.section	".rodata"
	.align 3
.LC266:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl pent_from_lag
	.type	 pent_from_lag,@function
pent_from_lag:
	stwu 1,-16(1)
	lis 11,level@ha
	lwz 8,84(3)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC266@ha
	lfs 12,3692(8)
	xoris 0,0,0x8000
	la 11,.LC266@l(11)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(11)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 13,0
	fcmpu 0,12,13
	bc 4,1,.L59
	lfs 0,3712(8)
	li 3,1
	fcmpu 0,0,13
	bc 12,1,.L438
.L59:
	li 3,0
.L438:
	la 1,16(1)
	blr
.Lfe19:
	.size	 pent_from_lag,.Lfe19-pent_from_lag
	.section	".rodata"
	.align 3
.LC267:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC268:
	.long 0x41200000
	.align 2
.LC269:
	.long 0x3f800000
	.align 2
.LC270:
	.long 0x0
	.section	".text"
	.align 2
	.globl lag_sickness
	.type	 lag_sickness,@function
lag_sickness:
	stwu 1,-16(1)
	lis 9,level@ha
	lwz 10,84(3)
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 9,.LC267@ha
	lfs 12,3712(10)
	xoris 0,0,0x8000
	la 9,.LC267@l(9)
	stw 0,12(1)
	stw 8,8(1)
	lfd 13,0(9)
	lfd 0,8(1)
	lis 9,lagsicktime@ha
	lfs 10,lagsicktime@l(9)
	fsub 0,0,13
	frsp 0,0
	fsubs 11,12,0
	fcmpu 0,11,10
	bc 4,1,.L61
	lis 11,.LC268@ha
	fsubs 11,11,10
	lis 9,.LC269@ha
	la 11,.LC268@l(11)
	la 9,.LC269@l(9)
	lfs 0,0(11)
	lis 11,.LC270@ha
	lfs 13,0(9)
	la 11,.LC270@l(11)
	fdivs 0,11,0
	lfs 12,0(11)
	fcmpu 7,0,13
	fcmpu 6,0,12
	crnor 27,26,26
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L62
	li 3,1
	b .L439
.L62:
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	b .L439
.L61:
	li 3,0
.L439:
	la 1,16(1)
	blr
.Lfe20:
	.size	 lag_sickness,.Lfe20-lag_sickness
	.section	".rodata"
	.align 3
.LC271:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC272:
	.long 0x40340000
	.long 0x0
	.section	".text"
	.align 2
	.globl lag_msg
	.type	 lag_msg,@function
lag_msg:
	stwu 1,-16(1)
	lis 11,level@ha
	lwz 8,84(3)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC271@ha
	lfs 13,3716(8)
	xoris 0,0,0x8000
	la 11,.LC271@l(11)
	stw 0,12(1)
	stw 10,8(1)
	lfd 12,0(11)
	lfd 0,8(1)
	lis 11,.LC272@ha
	la 11,.LC272@l(11)
	lfd 11,0(11)
	fsub 0,0,12
	frsp 0,0
	fsubs 13,13,0
	fabs 13,13
	fcmpu 0,13,11
	bc 12,1,.L65
	li 3,0
	b .L440
.L65:
	stfs 0,3716(8)
	li 3,1
.L440:
	la 1,16(1)
	blr
.Lfe21:
	.size	 lag_msg,.Lfe21-lag_msg
	.section	".rodata"
	.align 3
.LC273:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC274:
	.long 0x40240000
	.long 0x0
	.section	".text"
	.align 2
	.globl short_lag_msg
	.type	 short_lag_msg,@function
short_lag_msg:
	stwu 1,-16(1)
	lis 11,level@ha
	lwz 8,84(3)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC273@ha
	lfs 13,3716(8)
	xoris 0,0,0x8000
	la 11,.LC273@l(11)
	stw 0,12(1)
	stw 10,8(1)
	lfd 12,0(11)
	lfd 0,8(1)
	lis 11,.LC274@ha
	la 11,.LC274@l(11)
	lfd 11,0(11)
	fsub 0,0,12
	frsp 0,0
	fsubs 13,13,0
	fabs 13,13
	fcmpu 0,13,11
	bc 12,1,.L67
	li 3,0
	b .L441
.L67:
	stfs 0,3716(8)
	li 3,1
.L441:
	la 1,16(1)
	blr
.Lfe22:
	.size	 short_lag_msg,.Lfe22-short_lag_msg
	.section	".rodata"
	.align 3
.LC275:
	.long 0x3fed70a3
	.long 0xd70a3d71
	.section	".text"
	.align 2
	.globl do_greeting
	.type	 do_greeting,@function
do_greeting:
	stwu 1,-224(1)
	mflr 0
	stmw 27,204(1)
	stw 0,228(1)
	lis 9,.LC46@ha
	addi 29,1,8
	lwz 8,.LC46@l(9)
	addi 28,1,104
	mr 27,3
	la 9,.LC46@l(9)
	mr 3,28
	lwz 0,8(9)
	lhz 11,12(9)
	lbz 7,14(9)
	lwz 10,4(9)
	stw 8,8(1)
	stw 0,8(29)
	sth 11,12(29)
	stw 10,4(29)
	stb 7,14(29)
	bl get_mode_name
	lis 9,gi+12@ha
	lis 4,.LC47@ha
	lwz 0,gi+12@l(9)
	lis 11,.LC275@ha
	mr 3,27
	la 4,.LC47@l(4)
	lfd 1,.LC275@l(11)
	mr 5,29
	mr 6,28
	mtlr 0
	creqv 6,6,6
	blrl
	lwz 0,228(1)
	mtlr 0
	lmw 27,204(1)
	la 1,224(1)
	blr
.Lfe23:
	.size	 do_greeting,.Lfe23-do_greeting
	.section	".rodata"
	.align 3
.LC276:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl check_effects
	.type	 check_effects,@function
check_effects:
	stwu 1,-16(1)
	lis 9,bop_invisible@ha
	lwz 0,bop_invisible@l(9)
	cmpwi 0,0,0
	bc 4,2,.L174
	lis 10,level@ha
	lwz 11,84(3)
	lwz 0,level@l(10)
	lis 8,0x4330
	lis 7,.LC276@ha
	la 7,.LC276@l(7)
	lfs 13,3704(11)
	xoris 0,0,0x8000
	lfd 12,0(7)
	stw 0,12(1)
	stw 8,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L176
	lwz 0,64(3)
	ori 0,0,32768
	stw 0,64(3)
.L176:
	lwz 0,level@l(10)
	lwz 11,84(3)
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 8,8(1)
	lfd 0,8(1)
	lfs 13,3708(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L174
	lwz 0,64(3)
	oris 0,0,0x1
	stw 0,64(3)
.L174:
	la 1,16(1)
	blr
.Lfe24:
	.size	 check_effects,.Lfe24-check_effects
	.section	".rodata"
	.align 3
.LC277:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl bop_showicon
	.type	 bop_showicon,@function
bop_showicon:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 11,level@ha
	lwz 31,84(3)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC277@ha
	lfs 12,3704(31)
	xoris 0,0,0x8000
	la 11,.LC277@l(11)
	stw 0,20(1)
	stw 10,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 13,0
	fcmpu 0,12,13
	bc 4,1,.L179
	lis 9,gi+40@ha
	lis 3,.LC75@ha
	lwz 0,gi+40@l(9)
	la 3,.LC75@l(3)
	b .L443
.L179:
	lfs 0,3708(31)
	fcmpu 0,0,13
	bc 12,1,.L181
	li 3,0
	b .L442
.L181:
	lis 9,gi+40@ha
	lis 3,.LC76@ha
	lwz 0,gi+40@l(9)
	la 3,.LC76@l(3)
.L443:
	mtlr 0
	blrl
	sth 3,132(31)
	li 3,1
.L442:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 bop_showicon,.Lfe25-bop_showicon
	.align 2
	.globl adjust_resistance
	.type	 adjust_resistance,@function
adjust_resistance:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	mr 28,4
	lwz 9,84(30)
	mr 31,5
	lwz 3,1788(9)
	cmpwi 0,3,0
	bc 12,2,.L195
	lwz 3,0(3)
	b .L196
.L195:
	lis 9,.LC83@ha
	la 3,.LC83@l(9)
.L196:
	li 29,100
	lis 4,.LC84@ha
	la 4,.LC84@l(4)
	stw 29,0(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L197
	stw 29,0(31)
	lis 9,bop_verbose@ha
	lwz 0,bop_verbose@l(9)
	cmpwi 0,0,0
	bc 12,2,.L198
	lis 29,gi@ha
	lis 5,.LC85@ha
	la 29,gi@l(29)
	la 5,.LC85@l(5)
	lwz 9,8(29)
	mr 3,28
	li 4,2
	li 6,100
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC86@ha
	mr 3,30
	la 5,.LC86@l(5)
	lwz 6,0(31)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L198:
	li 3,0
	b .L444
.L197:
	li 3,1
.L444:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 adjust_resistance,.Lfe26-adjust_resistance
	.align 2
	.globl reset_bop_counters
	.type	 reset_bop_counters,@function
reset_bop_counters:
	lwz 10,84(3)
	lis 9,bopsickremove@ha
	li 0,0
	lwz 8,bopsickremove@l(9)
	stw 0,3704(10)
	lwz 11,84(3)
	cmpwi 0,8,0
	stw 0,3708(11)
	lwz 9,84(3)
	stw 0,3712(9)
	bclr 12,2
	lwz 0,184(3)
	rlwinm 0,0,0,0,30
	stw 0,184(3)
	blr
.Lfe27:
	.size	 reset_bop_counters,.Lfe27-reset_bop_counters
	.align 2
	.globl bophelp
	.type	 bophelp,@function
bophelp:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3728(9)
	cmpwi 0,0,0
	bc 4,2,.L202
	li 0,1
	stw 0,3728(9)
	lwz 9,84(31)
	stw 0,3476(9)
	bl refresh_bop_menu
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L203
.L202:
	mr 3,31
	bl adv_bop_menu
.L203:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe28:
	.size	 bophelp,.Lfe28-bophelp
	.align 2
	.globl adv_bop_menu
	.type	 adv_bop_menu,@function
adv_bop_menu:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 11,3728(9)
	addi 11,11,1
	stw 11,3728(9)
	lwz 9,84(31)
	lwz 0,3728(9)
	cmpwi 0,0,3
	bc 4,1,.L216
	li 0,0
	stw 0,3728(9)
	lwz 9,84(31)
	stw 0,3476(9)
	b .L217
.L216:
	mr 3,31
	bl refresh_bop_menu
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L217:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe29:
	.size	 adv_bop_menu,.Lfe29-adv_bop_menu
	.align 2
	.globl bopreport
	.type	 bopreport,@function
bopreport:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	li 0,3
	lwz 11,84(29)
	li 10,1
	stw 0,3728(11)
	lwz 9,84(29)
	stw 10,3476(9)
	bl refresh_bop_menu
	lis 9,gi+92@ha
	mr 3,29
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 bopreport,.Lfe30-bopreport
	.align 2
	.globl sv_nobophelp
	.type	 sv_nobophelp,@function
sv_nobophelp:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl getargi
	cmpwi 0,3,0
	lis 9,nobophelp@ha
	stw 3,nobophelp@l(9)
	bc 4,2,.L303
	lis 9,gi+8@ha
	lis 5,.LC166@ha
	lwz 0,gi+8@l(9)
	la 5,.LC166@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L304
.L303:
	lis 9,gi+8@ha
	lis 5,.LC167@ha
	lwz 0,gi+8@l(9)
	la 5,.LC167@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L304:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 sv_nobophelp,.Lfe31-sv_nobophelp
	.align 2
	.globl sv_bopsickremove
	.type	 sv_bopsickremove,@function
sv_bopsickremove:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl getargi
	cmpwi 0,3,0
	lis 9,bopsickremove@ha
	stw 3,bopsickremove@l(9)
	bc 12,2,.L306
	lis 9,gi+8@ha
	lis 5,.LC168@ha
	lwz 0,gi+8@l(9)
	la 5,.LC168@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L307
.L306:
	lis 9,gi+8@ha
	lis 5,.LC169@ha
	lwz 0,gi+8@l(9)
	la 5,.LC169@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L307:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe32:
	.size	 sv_bopsickremove,.Lfe32-sv_bopsickremove
	.align 2
	.globl sv_laghelp_old
	.type	 sv_laghelp_old,@function
sv_laghelp_old:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 29,gi@ha
	lis 5,.LC170@ha
	la 29,gi@l(29)
	la 5,.LC170@l(5)
	lwz 9,8(29)
	li 3,0
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC171@ha
	li 3,0
	la 5,.LC171@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 sv_laghelp_old,.Lfe33-sv_laghelp_old
	.align 2
	.globl sv_lagcap_str
	.type	 sv_lagcap_str,@function
sv_lagcap_str:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+8@ha
	lis 5,.LC172@ha
	lwz 0,gi+8@l(9)
	la 5,.LC172@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 sv_lagcap_str,.Lfe34-sv_lagcap_str
	.align 2
	.globl sv_lagcap_rst
	.type	 sv_lagcap_rst,@function
sv_lagcap_rst:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+8@ha
	lis 5,.LC173@ha
	lwz 0,gi+8@l(9)
	la 5,.LC173@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe35:
	.size	 sv_lagcap_rst,.Lfe35-sv_lagcap_rst
	.align 2
	.globl sv_pingmax
	.type	 sv_pingmax,@function
sv_pingmax:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl getargi
	mr. 3,3
	bc 4,1,.L312
	lis 9,max_delta_ping@ha
	stw 3,max_delta_ping@l(9)
.L312:
	lis 9,gi+8@ha
	lis 11,max_delta_ping@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC174@ha
	li 3,0
	la 5,.LC174@l(5)
	lwz 6,max_delta_ping@l(11)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe36:
	.size	 sv_pingmax,.Lfe36-sv_pingmax
	.align 2
	.globl sv_pingmin
	.type	 sv_pingmin,@function
sv_pingmin:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl getargi
	mr. 3,3
	bc 4,1,.L314
	lis 9,min_delta_ping@ha
	stw 3,min_delta_ping@l(9)
.L314:
	lis 9,gi+8@ha
	lis 11,min_delta_ping@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC175@ha
	li 3,0
	la 5,.LC175@l(5)
	lwz 6,min_delta_ping@l(11)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 sv_pingmin,.Lfe37-sv_pingmin
	.section	".rodata"
	.align 3
.LC278:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl sv_lagbare
	.type	 sv_lagbare,@function
sv_lagbare:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	bl getargi
	mr. 3,3
	bc 12,2,.L316
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC278@ha
	xoris 0,0,0x8000
	la 10,.LC278@l(10)
	stw 0,28(1)
	stw 11,24(1)
	lfd 0,24(1)
	lfd 13,0(10)
	lis 9,bop_deadtime@ha
	fsub 0,0,13
	frsp 0,0
	stfs 0,bop_deadtime@l(9)
.L316:
	lis 11,bop_deadtime@ha
	lfs 0,bop_deadtime@l(11)
	lis 6,0x6666
	lis 29,gi@ha
	ori 6,6,26215
	la 29,gi@l(29)
	lwz 11,8(29)
	lis 5,.LC176@ha
	li 3,0
	la 5,.LC176@l(5)
	li 4,2
	mtlr 11
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	mulhw 6,9,6
	srawi 9,9,31
	srawi 6,6,2
	subf 6,9,6
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC177@ha
	li 3,0
	la 5,.LC177@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe38:
	.size	 sv_lagbare,.Lfe38-sv_lagbare
	.section	".rodata"
	.align 3
.LC279:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl sv_lagpent
	.type	 sv_lagpent,@function
sv_lagpent:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	bl getargi
	mr. 3,3
	bc 12,2,.L318
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC279@ha
	xoris 0,0,0x8000
	la 10,.LC279@l(10)
	stw 0,28(1)
	stw 11,24(1)
	lfd 0,24(1)
	lfd 13,0(10)
	lis 9,bop_getawaytime@ha
	fsub 0,0,13
	frsp 0,0
	stfs 0,bop_getawaytime@l(9)
.L318:
	lis 11,bop_getawaytime@ha
	lfs 0,bop_getawaytime@l(11)
	lis 6,0x6666
	lis 29,gi@ha
	ori 6,6,26215
	la 29,gi@l(29)
	lwz 11,8(29)
	lis 5,.LC178@ha
	li 3,0
	la 5,.LC178@l(5)
	li 4,2
	mtlr 11
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	mulhw 6,9,6
	srawi 9,9,31
	srawi 6,6,2
	subf 6,9,6
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC179@ha
	li 3,0
	la 5,.LC179@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe39:
	.size	 sv_lagpent,.Lfe39-sv_lagpent
	.align 2
	.globl sv_lagpeak
	.type	 sv_lagpeak,@function
sv_lagpeak:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	bl getargi
	mr. 3,3
	bc 12,2,.L323
	lis 9,lag_threshold@ha
	stw 3,lag_threshold@l(9)
.L323:
	lis 9,lag_threshold@ha
	lis 29,gi@ha
	la 29,gi@l(29)
	lwz 6,lag_threshold@l(9)
	lis 5,.LC183@ha
	lwz 9,8(29)
	la 5,.LC183@l(5)
	li 3,0
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC184@ha
	li 3,0
	la 5,.LC184@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe40:
	.size	 sv_lagpeak,.Lfe40-sv_lagpeak
	.align 2
	.globl sv_lagtimeout
	.type	 sv_lagtimeout,@function
sv_lagtimeout:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl getargi
	mr. 3,3
	bc 12,2,.L325
	lis 9,lagged_out_detect@ha
	stw 3,lagged_out_detect@l(9)
.L325:
	lis 9,gi+8@ha
	lis 11,lagged_out_detect@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC185@ha
	li 3,0
	la 5,.LC185@l(5)
	lwz 6,lagged_out_detect@l(11)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe41:
	.size	 sv_lagtimeout,.Lfe41-sv_lagtimeout
	.align 2
	.globl sv_lagsuicide
	.type	 sv_lagsuicide,@function
sv_lagsuicide:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	lis 6,.LC186@ha
	la 31,gi@l(9)
	lis 5,.LC12@ha
	lwz 9,8(31)
	la 6,.LC186@l(6)
	li 3,0
	la 5,.LC12@l(5)
	li 4,2
	mtlr 9
	lis 29,no_suicide_protect@ha
	crxor 6,6,6
	blrl
	bl getargi
	subfic 0,3,0
	adde 3,0,3
	cmpwi 0,3,0
	stw 3,no_suicide_protect@l(29)
	bc 12,2,.L327
	lwz 0,8(31)
	lis 5,.LC187@ha
	li 3,0
	la 5,.LC187@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L328
.L327:
	lwz 0,8(31)
	lis 5,.LC188@ha
	li 3,0
	la 5,.LC188@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L328:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe42:
	.size	 sv_lagsuicide,.Lfe42-sv_lagsuicide
	.align 2
	.globl sv_lagslag
	.type	 sv_lagslag,@function
sv_lagslag:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	lis 6,.LC189@ha
	la 31,gi@l(9)
	lis 5,.LC12@ha
	lwz 9,8(31)
	la 6,.LC189@l(6)
	li 3,0
	la 5,.LC12@l(5)
	li 4,2
	mtlr 9
	lis 29,no_slag_protect@ha
	crxor 6,6,6
	blrl
	bl getargi
	subfic 0,3,0
	adde 3,0,3
	cmpwi 0,3,0
	stw 3,no_slag_protect@l(29)
	bc 12,2,.L330
	lwz 0,8(31)
	lis 5,.LC187@ha
	li 3,0
	la 5,.LC187@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L331
.L330:
	lwz 0,8(31)
	lis 5,.LC188@ha
	li 3,0
	la 5,.LC188@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L331:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe43:
	.size	 sv_lagslag,.Lfe43-sv_lagslag
	.align 2
	.globl sv_verbose
	.type	 sv_verbose,@function
sv_verbose:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	lis 6,.LC190@ha
	la 31,gi@l(9)
	lis 5,.LC12@ha
	lwz 9,8(31)
	la 6,.LC190@l(6)
	li 3,0
	la 5,.LC12@l(5)
	li 4,2
	mtlr 9
	lis 29,bop_verbose@ha
	crxor 6,6,6
	blrl
	bl getargi
	cmpwi 0,3,0
	stw 3,bop_verbose@l(29)
	bc 12,2,.L333
	lwz 0,8(31)
	lis 5,.LC188@ha
	li 3,0
	la 5,.LC188@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L334
.L333:
	lwz 0,8(31)
	lis 5,.LC187@ha
	li 3,0
	la 5,.LC187@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L334:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe44:
	.size	 sv_verbose,.Lfe44-sv_verbose
	.align 2
	.globl sv_invisible
	.type	 sv_invisible,@function
sv_invisible:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	lis 6,.LC191@ha
	la 31,gi@l(9)
	lis 5,.LC12@ha
	lwz 9,8(31)
	la 6,.LC191@l(6)
	li 3,0
	la 5,.LC12@l(5)
	li 4,2
	mtlr 9
	lis 29,bop_invisible@ha
	crxor 6,6,6
	blrl
	bl getargi
	cmpwi 0,3,0
	stw 3,bop_invisible@l(29)
	bc 12,2,.L336
	lwz 0,8(31)
	lis 5,.LC192@ha
	li 3,0
	la 5,.LC192@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L337
.L336:
	lwz 0,8(31)
	lis 5,.LC193@ha
	li 3,0
	la 5,.LC193@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L337:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe45:
	.size	 sv_invisible,.Lfe45-sv_invisible
	.align 2
	.globl sv_bopmanageobservers
	.type	 sv_bopmanageobservers,@function
sv_bopmanageobservers:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl getargi
	lis 9,gi+8@ha
	mr 0,3
	lwz 11,gi+8@l(9)
	lis 5,.LC194@ha
	mr 6,0
	la 5,.LC194@l(5)
	li 3,0
	li 4,2
	mtlr 11
	lis 9,bopmanageobservers@ha
	stw 0,bopmanageobservers@l(9)
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe46:
	.size	 sv_bopmanageobservers,.Lfe46-sv_bopmanageobservers
	.align 2
	.globl getargf
	.type	 getargf,@function
getargf:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 3,bop_twoarg@ha
	la 3,bop_twoarg@l(3)
	bl atof
	frsp 1,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe47:
	.size	 getargf,.Lfe47-getargf
	.comm	bop_twoarg,81,4
	.section	".rodata"
	.align 3
.LC280:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl do_bop_client_frame
	.type	 do_bop_client_frame,@function
do_bop_client_frame:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 10,0x4330
	mr 31,3
	lis 9,.LC280@ha
	mr 30,4
	xoris 0,0,0x8000
	la 9,.LC280@l(9)
	stw 0,20(1)
	li 8,0
	stw 10,16(1)
	lfd 12,0(9)
	lfd 0,16(1)
	lwz 9,84(31)
	fsub 0,0,12
	lfs 13,3692(9)
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L113
	lfs 0,3712(9)
	fcmpu 0,0,12
	bc 4,1,.L113
	li 8,1
.L113:
	cmpwi 0,8,0
	bc 12,2,.L112
	mr 3,31
	bl lagged_out
	cmpwi 0,3,0
	bc 4,2,.L111
.L112:
	lwz 9,84(31)
	lwz 0,3732(9)
	cmpwi 0,0,0
	bc 12,2,.L110
.L111:
	li 0,0
	sth 0,12(30)
	sth 0,8(30)
	sth 0,10(30)
.L110:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe48:
	.size	 do_bop_client_frame,.Lfe48-do_bop_client_frame
	.align 2
	.globl getargi
	.type	 getargi,@function
getargi:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 3,bop_twoarg@ha
	la 3,bop_twoarg@l(3)
	bl atoi
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe49:
	.size	 getargi,.Lfe49-getargi
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
