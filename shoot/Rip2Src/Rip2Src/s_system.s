	.file	"s_system.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"%s.ini loaded.\n"
	.align 2
.LC1:
	.string	"Parms"
	.align 2
.LC2:
	.string	"Name"
	.align 2
.LC3:
	.string	"Nextmap"
	.align 2
.LC4:
	.string	"Sky"
	.align 2
.LC5:
	.string	"sky"
	.align 2
.LC6:
	.string	"Dmflags"
	.align 2
.LC7:
	.string	"dmflags"
	.align 2
.LC8:
	.string	"Ripflags"
	.align 2
.LC9:
	.string	"tflags"
	.align 2
.LC10:
	.string	"Timelimit"
	.align 2
.LC11:
	.string	"timelimit"
	.align 2
.LC12:
	.string	"Fraglimit"
	.align 2
.LC13:
	.string	"fraglimit"
	.align 2
.LC14:
	.string	"Gravity"
	.align 2
.LC15:
	.string	"sv_gravity"
	.align 2
.LC16:
	.string	"Max_Velocity"
	.align 2
.LC17:
	.string	"sv_maxvelocity"
	.align 2
.LC18:
	.string	"Capture_Message"
	.align 2
.LC19:
	.string	"Take_Message"
	.align 2
.LC20:
	.string	"Capturer_Message"
	.align 2
.LC21:
	.string	"Capturelimit"
	.align 2
.LC22:
	.string	"capturelimit"
	.align 2
.LC23:
	.string	"Extratime"
	.align 2
.LC24:
	.string	"extratime"
	.align 2
.LC25:
	.string	"Next_Maxclients"
	.align 2
.LC26:
	.string	"maxclients"
	.align 2
.LC27:
	.string	"Next_Eject"
	.align 2
.LC28:
	.string	"eject_life"
	.align 2
.LC29:
	.string	"Next_Bhole_Life"
	.align 2
.LC30:
	.string	"bhole_life"
	.align 2
.LC31:
	.string	"Maxspectators"
	.align 2
.LC32:
	.string	"maxspectators"
	.align 2
.LC33:
	.string	"Taker_Message"
	.align 2
.LC34:
	.string	"Return_Message"
	.align 2
.LC35:
	.string	"Flag_At_Base"
	.align 2
.LC36:
	.string	"Flag_Own"
	.align 2
.LC37:
	.string	"Flag_Lying"
	.align 2
.LC38:
	.string	"Flag_Corrupt"
	.align 2
.LC39:
	.string	"Take_Frags"
	.align 2
.LC40:
	.string	"Capture_Frags"
	.align 2
.LC41:
	.string	"Recovery_Frags"
	.align 2
.LC42:
	.string	"Team_Frags"
	.align 2
.LC43:
	.string	"Maphelp"
	.align 2
.LC44:
	.string	"Couldn't find file %s.ini.\n"
	.section	".text"
	.align 2
	.globl LoadMapCfg
	.type	 LoadMapCfg,@function
LoadMapCfg:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,ini_file@ha
	la 30,ini_file@l(9)
	lbz 0,8(30)
	cmpwi 0,0,0
	bc 12,2,.L7
	lis 9,gi@ha
	lis 3,.LC0@ha
	la 28,gi@l(9)
	lis 4,level+72@ha
	lwz 9,4(28)
	la 4,level+72@l(4)
	la 3,.LC0@l(3)
	lis 29,.LC1@ha
	mtlr 9
	crxor 6,6,6
	blrl
	lis 4,.LC1@ha
	lis 5,.LC2@ha
	la 4,.LC1@l(4)
	la 5,.LC2@l(5)
	mr 3,30
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L8
	lwz 9,24(28)
	li 3,0
	mr 4,31
	mtlr 9
	blrl
	lis 3,level+8@ha
	mr 4,31
	la 3,level+8@l(3)
	li 5,64
	bl strncpy
.L8:
	lis 5,.LC3@ha
	mr 3,30
	la 5,.LC3@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L9
	lis 3,level+136@ha
	mr 4,31
	la 3,level+136@l(3)
	li 5,64
	bl strncpy
.L9:
	lis 5,.LC4@ha
	mr 3,30
	la 5,.LC4@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L10
	lwz 9,24(28)
	li 3,2
	mr 4,31
	mtlr 9
	blrl
	lwz 9,148(28)
	lis 3,.LC5@ha
	mr 4,31
	la 3,.LC5@l(3)
	mtlr 9
	blrl
.L10:
	lis 5,.LC6@ha
	mr 3,30
	la 5,.LC6@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L11
	lwz 9,148(28)
	lis 3,.LC7@ha
	mr 4,31
	la 3,.LC7@l(3)
	mtlr 9
	blrl
.L11:
	lis 5,.LC8@ha
	mr 3,30
	la 5,.LC8@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L12
	lwz 9,148(28)
	lis 3,.LC9@ha
	mr 4,31
	la 3,.LC9@l(3)
	mtlr 9
	blrl
.L12:
	lis 5,.LC10@ha
	mr 3,30
	la 5,.LC10@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L13
	lwz 9,148(28)
	lis 3,.LC11@ha
	mr 4,31
	la 3,.LC11@l(3)
	mtlr 9
	blrl
.L13:
	lis 5,.LC12@ha
	mr 3,30
	la 5,.LC12@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L14
	lwz 9,148(28)
	lis 3,.LC13@ha
	mr 4,31
	la 3,.LC13@l(3)
	mtlr 9
	blrl
.L14:
	lis 5,.LC14@ha
	mr 3,30
	la 5,.LC14@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L15
	lwz 9,148(28)
	lis 3,.LC15@ha
	mr 4,31
	la 3,.LC15@l(3)
	mtlr 9
	blrl
.L15:
	lis 5,.LC16@ha
	mr 3,30
	la 5,.LC16@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L16
	lwz 0,148(28)
	lis 3,.LC17@ha
	mr 4,31
	la 3,.LC17@l(3)
	mtlr 0
	blrl
.L16:
	lis 5,.LC18@ha
	mr 3,30
	la 5,.LC18@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L17
	lis 3,level+304@ha
	mr 4,31
	la 3,level+304@l(3)
	li 5,64
	bl strncpy
.L17:
	lis 5,.LC19@ha
	mr 3,30
	la 5,.LC19@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L18
	lis 3,level+432@ha
	mr 4,31
	la 3,level+432@l(3)
	li 5,64
	bl strncpy
.L18:
	lis 5,.LC20@ha
	mr 3,30
	la 5,.LC20@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L19
	lis 3,level+368@ha
	mr 4,31
	la 3,level+368@l(3)
	li 5,64
	bl strncpy
.L19:
	lis 5,.LC21@ha
	mr 3,30
	la 5,.LC21@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L20
	lis 9,gi+148@ha
	lis 3,.LC22@ha
	lwz 0,gi+148@l(9)
	la 3,.LC22@l(3)
	mr 4,31
	mtlr 0
	blrl
.L20:
	lis 5,.LC23@ha
	mr 3,30
	la 5,.LC23@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L21
	lis 9,gi+148@ha
	lis 3,.LC24@ha
	lwz 0,gi+148@l(9)
	la 3,.LC24@l(3)
	mr 4,31
	mtlr 0
	blrl
.L21:
	lis 5,.LC25@ha
	mr 3,30
	la 5,.LC25@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L22
	lis 9,gi+148@ha
	lis 3,.LC26@ha
	lwz 0,gi+148@l(9)
	la 3,.LC26@l(3)
	mr 4,31
	mtlr 0
	blrl
.L22:
	lis 5,.LC27@ha
	mr 3,30
	la 5,.LC27@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L23
	lis 9,gi+148@ha
	lis 3,.LC28@ha
	lwz 0,gi+148@l(9)
	la 3,.LC28@l(3)
	mr 4,31
	mtlr 0
	blrl
.L23:
	lis 5,.LC29@ha
	mr 3,30
	la 5,.LC29@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L24
	lis 9,gi+148@ha
	lis 3,.LC30@ha
	lwz 0,gi+148@l(9)
	la 3,.LC30@l(3)
	mr 4,31
	mtlr 0
	blrl
.L24:
	lis 5,.LC31@ha
	mr 3,30
	la 5,.LC31@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L25
	lis 9,gi+148@ha
	lis 3,.LC32@ha
	lwz 0,gi+148@l(9)
	la 3,.LC32@l(3)
	mr 4,31
	mtlr 0
	blrl
.L25:
	lis 5,.LC33@ha
	mr 3,30
	la 5,.LC33@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L26
	lis 3,level+496@ha
	mr 4,31
	la 3,level+496@l(3)
	li 5,64
	bl strncpy
.L26:
	lis 5,.LC34@ha
	mr 3,30
	la 5,.LC34@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L27
	lis 3,level+560@ha
	mr 4,31
	la 3,level+560@l(3)
	li 5,64
	bl strncpy
.L27:
	lis 5,.LC35@ha
	mr 3,30
	la 5,.LC35@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L28
	lis 3,level+624@ha
	mr 4,31
	la 3,level+624@l(3)
	li 5,64
	bl strncpy
.L28:
	lis 5,.LC36@ha
	mr 3,30
	la 5,.LC36@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L29
	lis 3,level+688@ha
	mr 4,31
	la 3,level+688@l(3)
	li 5,64
	bl strncpy
.L29:
	lis 5,.LC37@ha
	mr 3,30
	la 5,.LC37@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L30
	lis 3,level+752@ha
	mr 4,31
	la 3,level+752@l(3)
	li 5,64
	bl strncpy
.L30:
	lis 5,.LC38@ha
	mr 3,30
	la 5,.LC38@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L31
	lis 3,level+816@ha
	mr 4,31
	la 3,level+816@l(3)
	li 5,64
	bl strncpy
.L31:
	lis 5,.LC39@ha
	mr 3,30
	la 5,.LC39@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L32
	mr 3,31
	bl atoi
	lis 9,level+952@ha
	stw 3,level+952@l(9)
.L32:
	lis 5,.LC40@ha
	mr 3,30
	la 5,.LC40@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L33
	mr 3,31
	bl atoi
	lis 9,level+956@ha
	stw 3,level+956@l(9)
.L33:
	lis 5,.LC41@ha
	mr 3,30
	la 5,.LC41@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L34
	mr 3,31
	bl atoi
	lis 9,level+948@ha
	stw 3,level+948@l(9)
.L34:
	lis 5,.LC42@ha
	mr 3,30
	la 5,.LC42@l(5)
	la 4,.LC1@l(29)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L35
	mr 3,31
	bl atoi
	lis 9,level+960@ha
	stw 3,level+960@l(9)
.L35:
	lis 5,.LC43@ha
	mr 3,30
	la 4,.LC1@l(29)
	la 5,.LC43@l(5)
	bl Ini_GetValue
	mr. 31,3
	bc 12,2,.L37
	lis 3,level+884@ha
	mr 4,31
	la 3,level+884@l(3)
	li 5,64
	bl strncpy
	b .L37
.L7:
	lis 9,gi+4@ha
	lis 3,.LC44@ha
	lwz 0,gi+4@l(9)
	lis 4,level+72@ha
	la 3,.LC44@l(3)
	la 4,level+72@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L37:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 LoadMapCfg,.Lfe1-LoadMapCfg
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
