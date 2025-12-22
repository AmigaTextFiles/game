	.file	"g_rws.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"%s !\n"
	.align 2
.LC1:
	.string	"------------------------------------------"
	.align 2
.LC2:
	.string	"%s\\%s"
	.align 2
.LC3:
	.string	"baseq2"
	.align 2
.LC4:
	.string	"wt"
	.align 2
.LC5:
	.string	"%s\\%s.rws"
	.align 2
.LC6:
	.string	"rt"
	.align 2
.LC7:
	.string	"%s\\%s.log"
	.align 2
.LC8:
	.string	"default.rws"
	.align 2
.LC9:
	.string	"rw.log"
	.align 2
.LC10:
	.string	"%s\nReading CFG from : %s\nWriting LOG to (this) : %s\n"
	.align 2
.LC11:
	.string	"Map Name : '%s'\n"
	.align 2
.LC12:
	.string	"%s\nReading item : '%s'\n"
	.align 2
.LC13:
	.string	"Can't find item"
	.align 2
.LC14:
	.string	"Mode requested : '%s'\n"
	.align 2
.LC15:
	.string	"RANDOM"
	.align 2
.LC16:
	.string	"Mode RANDOM OK\n"
	.align 2
.LC17:
	.string	"CYCLE"
	.align 2
.LC18:
	.string	"Mode CYCLE OK\n"
	.align 2
.LC19:
	.string	"REMOVE"
	.align 2
.LC20:
	.string	"Mode REMOVE OK\n"
	.align 2
.LC21:
	.string	"UPGRADE"
	.align 2
.LC22:
	.string	"Mode UPGRADE OK\n"
	.align 2
.LC23:
	.string	"GIVE"
	.align 2
.LC24:
	.string	"Mode GIVE OK\n"
	.align 2
.LC25:
	.string	"CLASS"
	.align 2
.LC26:
	.string	"Mode CLASS OK\n"
	.align 2
.LC27:
	.string	"FIXED"
	.align 2
.LC28:
	.string	"Mode FIXED OK\n"
	.align 2
.LC29:
	.string	"BAD Mode"
	.align 2
.LC30:
	.string	"%d permutations requested\n"
	.align 2
.LC31:
	.string	"Illegal permutation count"
	.align 2
.LC32:
	.string	"Reading perm item : '%s'\n"
	.align 2
.LC33:
	.string	"Can't find perm item"
	.align 2
.LC34:
	.string	"Perm item OK : %s\n"
	.align 2
.LC35:
	.string	"No perm items found : ITEM_FIXED set"
	.align 2
.LC36:
	.string	"%s\nErrors : %d\n%s"
	.align 2
.LC37:
	.long .LC1
	.section	".text"
	.align 2
	.globl ReadInRandomWeaponTable
	.type	 ReadInRandomWeaponTable,@function
ReadInRandomWeaponTable:
	stwu 1,-784(1)
	mflr 0
	stmw 14,712(1)
	stw 0,788(1)
	mr. 25,3
	bc 12,2,.L19
	lis 3,map_name_copy@ha
	mr 4,25
	la 3,map_name_copy@l(3)
	bl strcpy
.L19:
	lis 9,cv_rwcfgin@ha
	li 0,0
	lwz 11,cv_rwcfgin@l(9)
	lis 10,actual_items@ha
	lis 9,rws_err_count@ha
	lwz 3,4(11)
	stw 0,rws_err_count@l(9)
	stw 0,actual_items@l(10)
	bl strlen
	lis 9,cv_rwcfgout@ha
	addic 0,3,-1
	subfe 27,0,3
	lwz 11,cv_rwcfgout@l(9)
	lwz 3,4(11)
	bl strlen
	lis 9,cv_rwcfgdef@ha
	addic 0,3,-1
	subfe 26,0,3
	lwz 11,cv_rwcfgdef@l(9)
	lwz 3,4(11)
	bl strlen
	lis 9,cv_game@ha
	addic 0,3,-1
	subfe 28,0,3
	lwz 11,cv_game@l(9)
	lwz 3,4(11)
	bl strlen
	cmpwi 0,28,0
	addic 0,3,-1
	subfe 31,0,3
	bc 12,2,.L20
	cmpwi 0,31,0
	addi 3,1,136
	mr 30,3
	bc 12,2,.L21
	lis 9,cv_game@ha
	lwz 11,cv_game@l(9)
	lwz 5,4(11)
	b .L22
.L21:
	lis 9,.LC3@ha
	la 5,.LC3@l(9)
.L22:
	lis 9,cv_rwcfgdef@ha
	lis 4,.LC2@ha
	lwz 11,cv_rwcfgdef@l(9)
	la 4,.LC2@l(4)
	lwz 6,4(11)
	crxor 6,6,6
	bl sprintf
	lis 4,.LC4@ha
	mr 3,30
	la 4,.LC4@l(4)
	bl fopen
	mr 22,3
.L20:
	cmpwi 0,31,0
	lis 9,game+1556@ha
	lwz 0,game+1556@l(9)
	addi 31,1,72
	mfcr 29
	cmpwi 0,0,0
	bc 4,1,.L24
	lis 9,wrndtbl@ha
	lis 4,actual_items@ha
	la 9,wrndtbl@l(9)
	lis 11,itemlist@ha
	lwz 10,actual_items@l(4)
	addi 5,9,64
	addi 6,9,68
	addi 7,9,72
	la 11,itemlist@l(11)
	mr 30,0
	li 8,0
.L26:
	mulli 0,10,76
	addic. 30,30,-1
	addi 10,10,1
	stwx 11,9,0
	stwx 8,5,0
	addi 11,11,84
	stwx 8,6,0
	stwx 8,7,0
	bc 4,2,.L26
	stw 10,actual_items@l(4)
.L24:
	addic 9,22,-1
	subfe 0,9,22
	and. 11,28,0
	bc 12,2,.L28
	mr 3,22
	bl fclose
.L28:
	mtcrf 128,29
	bc 12,2,.L29
	lis 9,cv_game@ha
	lwz 11,cv_game@l(9)
	lwz 5,4(11)
	b .L30
.L29:
	lis 9,.LC3@ha
	la 5,.LC3@l(9)
.L30:
	lis 4,.LC5@ha
	lis 6,map_name_copy@ha
	la 4,.LC5@l(4)
	la 6,map_name_copy@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	lis 4,.LC6@ha
	addi 3,1,8
	la 4,.LC6@l(4)
	bl fopen
	mr. 22,3
	bc 12,2,.L31
	mtcrf 128,29
	bc 12,2,.L32
	lis 9,cv_game@ha
	lwz 11,cv_game@l(9)
	lwz 5,4(11)
	b .L33
.L32:
	lis 9,.LC3@ha
	la 5,.LC3@l(9)
.L33:
	lis 4,.LC7@ha
	lis 6,map_name_copy@ha
	la 4,.LC7@l(4)
	la 6,map_name_copy@l(6)
	mr 3,31
	crxor 6,6,6
	bl sprintf
	b .L34
.L31:
	mtcrf 128,29
	bc 12,2,.L35
	lis 9,cv_game@ha
	lwz 11,cv_game@l(9)
	lwz 5,4(11)
	b .L36
.L35:
	lis 9,.LC3@ha
	la 5,.LC3@l(9)
.L36:
	cmpwi 0,27,0
	bc 12,2,.L37
	lis 9,cv_rwcfgin@ha
	lwz 11,cv_rwcfgin@l(9)
	lwz 6,4(11)
	b .L38
.L37:
	lis 9,.LC8@ha
	la 6,.LC8@l(9)
.L38:
	lis 4,.LC2@ha
	addi 3,1,8
	la 4,.LC2@l(4)
	crxor 6,6,6
	bl sprintf
	lis 4,.LC6@ha
	addi 3,1,8
	la 4,.LC6@l(4)
	bl fopen
	mr 22,3
	mtcrf 128,29
	bc 12,2,.L39
	lis 9,cv_game@ha
	lwz 11,cv_game@l(9)
	lwz 5,4(11)
	b .L40
.L39:
	lis 9,.LC3@ha
	la 5,.LC3@l(9)
.L40:
	cmpwi 0,26,0
	bc 12,2,.L41
	lis 9,cv_rwcfgout@ha
	lwz 11,cv_rwcfgout@l(9)
	lwz 6,4(11)
	b .L42
.L119:
	lis 5,.LC31@ha
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	la 5,.LC31@l(5)
	mr 3,27
	crxor 6,6,6
	bl fprintf
	lis 11,rws_err_count@ha
	lwz 9,rws_err_count@l(11)
	addi 9,9,1
	stw 9,rws_err_count@l(11)
	b .L46
.L41:
	lis 9,.LC9@ha
	la 6,.LC9@l(9)
.L42:
	lis 4,.LC2@ha
	mr 3,31
	la 4,.LC2@l(4)
	crxor 6,6,6
	bl sprintf
.L34:
	lis 4,.LC4@ha
	mr 3,31
	la 4,.LC4@l(4)
	bl fopen
	addic 0,22,-1
	subfe 9,0,22
	mr 27,3
	addic 11,27,-1
	subfe 0,11,27
	and. 11,9,0
	bc 12,2,.L43
	lis 9,.LC37@ha
	lis 4,.LC10@ha
	la 9,.LC37@l(9)
	mr 7,31
	lwz 5,0(9)
	la 4,.LC10@l(4)
	addi 6,1,8
	crxor 6,6,6
	bl fprintf
	cmpwi 0,25,0
	bc 12,2,.L44
	lis 4,.LC11@ha
	lis 5,map_name_copy@ha
	la 4,.LC11@l(4)
	la 5,map_name_copy@l(5)
	mr 3,27
	crxor 6,6,6
	bl fprintf
.L44:
	lis 9,wrndtbl+64@ha
	addi 17,1,200
	la 20,wrndtbl+64@l(9)
	li 14,0
	lis 15,.LC0@ha
	lis 16,rws_err_count@ha
.L50:
	stb 14,0(17)
	addi 3,1,200
	li 4,128
	mr 5,22
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L116
	addi 3,1,200
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L54
	addi 3,1,200
	bl strlen
	add 3,17,3
	stb 14,-1(3)
.L54:
	lbz 0,200(1)
	cmpwi 0,0,59
	bc 12,2,.L50
	addi 3,1,200
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L50
	li 0,1
.L52:
	cmpwi 0,0,0
	bc 12,2,.L46
	lis 9,.LC37@ha
	lis 4,.LC12@ha
	la 9,.LC37@l(9)
	la 4,.LC12@l(4)
	lwz 5,0(9)
	addi 6,1,200
	mr 3,27
	crxor 6,6,6
	bl fprintf
	addi 3,1,200
	bl FindItemByClassname
	mr. 3,3
	bc 4,2,.L59
	li 28,-1
	b .L58
.L116:
	li 0,0
	b .L52
.L59:
	lis 9,itemlist@ha
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,3
	mullw 9,9,0
	srawi 28,9,2
.L58:
	cmpwi 0,28,0
	bc 4,0,.L56
	lis 5,.LC13@ha
	mr 3,27
	la 5,.LC13@l(5)
	b .L122
.L117:
	li 0,0
	b .L66
.L56:
	addi 31,1,584
	li 29,0
	mr 30,31
.L64:
	stb 29,0(30)
	addi 3,1,584
	li 4,128
	mr 5,22
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L117
	addi 3,1,584
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L68
	addi 3,1,584
	bl strlen
	add 3,30,3
	stb 29,-1(3)
.L68:
	lbz 0,584(1)
	cmpwi 0,0,59
	bc 12,2,.L64
	addi 3,1,584
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L64
	li 0,1
.L66:
	cmpwi 0,0,0
	bc 12,2,.L46
	lis 4,.LC14@ha
	mr 5,31
	la 4,.LC14@l(4)
	mr 3,27
	crxor 6,6,6
	bl fprintf
	mr 3,31
	crxor 6,6,6
	bl strupr
	lis 4,.LC15@ha
	mr 3,31
	la 4,.LC15@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L70
	mulli 0,28,76
	li 9,1
	lis 4,.LC16@ha
	la 4,.LC16@l(4)
	b .L123
.L70:
	lis 4,.LC17@ha
	mr 3,31
	la 4,.LC17@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L72
	mulli 0,28,76
	li 9,2
	lis 4,.LC18@ha
	la 4,.LC18@l(4)
	b .L123
.L72:
	lis 4,.LC19@ha
	mr 3,31
	la 4,.LC19@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L74
	mulli 9,28,76
	li 0,3
	lis 4,.LC20@ha
	la 4,.LC20@l(4)
	mr 3,27
	stwx 0,20,9
	crxor 6,6,6
	bl fprintf
	b .L50
.L74:
	lis 4,.LC21@ha
	mr 3,31
	la 4,.LC21@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L76
	mulli 0,28,76
	li 9,4
	lis 4,.LC22@ha
	la 4,.LC22@l(4)
	b .L123
.L76:
	lis 4,.LC23@ha
	mr 3,31
	la 4,.LC23@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L78
	mulli 0,28,76
	li 9,5
	lis 4,.LC24@ha
	la 4,.LC24@l(4)
	b .L123
.L78:
	lis 4,.LC25@ha
	mr 3,31
	la 4,.LC25@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L80
	mulli 0,28,76
	li 9,6
	lis 4,.LC26@ha
	la 4,.LC26@l(4)
.L123:
	mr 3,27
	stwx 9,20,0
	mr 28,0
	crxor 6,6,6
	bl fprintf
	b .L71
.L80:
	lis 4,.LC27@ha
	mr 3,31
	la 4,.LC27@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L82
	lis 4,.LC28@ha
	mr 3,27
	mulli 28,28,76
	la 4,.LC28@l(4)
	crxor 6,6,6
	bl fprintf
	b .L71
.L82:
	lis 5,.LC29@ha
	mr 3,27
	mulli 28,28,76
	la 5,.LC29@l(5)
	la 4,.LC0@l(15)
	crxor 6,6,6
	bl fprintf
	lwz 9,rws_err_count@l(16)
	addi 9,9,1
	stw 9,rws_err_count@l(16)
.L71:
	lwzx 0,20,28
	cmpwi 0,0,0
	bc 4,2,.L85
	li 24,1
	b .L86
.L118:
	li 0,0
	b .L91
.L85:
	addi 31,1,456
	li 29,0
	mr 30,31
.L89:
	stb 29,0(30)
	addi 3,1,456
	li 4,128
	mr 5,22
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L118
	addi 3,1,456
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L93
	addi 3,1,456
	bl strlen
	add 3,30,3
	stb 29,-1(3)
.L93:
	lbz 0,456(1)
	cmpwi 0,0,59
	bc 12,2,.L89
	addi 3,1,456
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L89
	li 0,1
.L91:
	cmpwi 0,0,0
	bc 12,2,.L46
	mr 3,31
	bl atoi
	mr 24,3
.L86:
	lis 4,.LC30@ha
	mr 3,27
	la 4,.LC30@l(4)
	mr 5,24
	crxor 6,6,6
	bl fprintf
	addi 0,24,-1
	cmplwi 0,0,15
	bc 12,1,.L119
	li 30,0
	cmpw 0,30,24
	bc 4,0,.L98
	lis 9,wrndtbl@ha
	addi 31,1,328
	la 21,wrndtbl@l(9)
	li 25,0
	addi 26,21,68
	lis 23,rws_err_count@ha
	mr 29,28
	lis 19,.LC32@ha
	lis 18,.LC33@ha
.L103:
	stb 25,0(31)
	addi 3,1,328
	li 4,128
	mr 5,22
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L120
	addi 3,1,328
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L107
	addi 3,1,328
	bl strlen
	add 3,31,3
	stb 25,-1(3)
.L107:
	lbz 0,328(1)
	cmpwi 0,0,59
	bc 12,2,.L103
	addi 3,1,328
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L103
	li 0,1
.L105:
	cmpwi 0,0,0
	bc 12,2,.L98
	la 4,.LC32@l(19)
	mr 5,31
	mr 3,27
	crxor 6,6,6
	bl fprintf
	mr 3,31
	bl FindItemByClassname
	mr. 9,3
	bc 4,2,.L109
	la 5,.LC33@l(18)
	mr 3,27
	la 4,.LC0@l(15)
	crxor 6,6,6
	bl fprintf
	lwz 9,rws_err_count@l(23)
	addi 9,9,1
	stw 9,rws_err_count@l(23)
	b .L98
.L120:
	li 0,0
	b .L105
.L109:
	lwzx 0,26,29
	lis 4,.LC34@ha
	mr 3,27
	la 4,.LC34@l(4)
	mr 5,31
	slwi 0,0,2
	addi 30,30,1
	add 0,0,29
	stwx 9,21,0
	lwzx 9,26,29
	addi 9,9,1
	stwx 9,26,29
	crxor 6,6,6
	bl fprintf
	cmpw 0,30,24
	bc 12,0,.L103
.L98:
	lis 9,wrndtbl+68@ha
	la 9,wrndtbl+68@l(9)
	lwzx 0,9,28
	cmpwi 0,0,0
	bc 4,2,.L50
	lis 5,.LC35@ha
	stwx 0,20,28
	mr 3,27
	la 5,.LC35@l(5)
.L122:
	la 4,.LC0@l(15)
	crxor 6,6,6
	bl fprintf
	lwz 9,rws_err_count@l(16)
	addi 9,9,1
	stw 9,rws_err_count@l(16)
	b .L50
.L46:
	lis 11,.LC37@ha
	lis 9,rws_err_count@ha
	la 11,.LC37@l(11)
	lwz 6,rws_err_count@l(9)
	lis 4,.LC36@ha
	lwz 5,0(11)
	la 4,.LC36@l(4)
	mr 3,27
	mr 7,5
	crxor 6,6,6
	bl fprintf
	mr 3,22
	bl fclose
	mr 3,27
	bl fclose
.L43:
	lwz 0,788(1)
	mtlr 0
	lmw 14,712(1)
	la 1,784(1)
	blr
.Lfe1:
	.size	 ReadInRandomWeaponTable,.Lfe1-ReadInRandomWeaponTable
	.section	".rodata"
	.align 2
.LC38:
	.long 0x46fffe00
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC40:
	.long 0x447a0000
	.section	".text"
	.align 2
	.globl FindRandomWeapon
	.type	 FindRandomWeapon,@function
FindRandomWeapon:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lwz 11,1092(3)
	cmpwi 0,11,0
	bc 12,2,.L125
	lwz 0,0(11)
	cmpwi 0,0,0
	bc 12,2,.L125
	lis 9,itemlist@ha
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 9,9,11
	mullw 9,9,0
	lis 11,wrndtbl@ha
	la 11,wrndtbl@l(11)
	srawi 31,9,2
	addi 11,11,64
	mulli 10,31,76
	lwzx 0,11,10
	stw 0,0(4)
	lwzx 10,11,10
	cmplwi 0,10,6
	bc 12,1,.L125
	lis 11,.L135@ha
	slwi 10,10,2
	la 11,.L135@l(11)
	lis 9,.L135@ha
	lwzx 0,10,11
	la 9,.L135@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L135:
	.long .L128-.L135
	.long .L133-.L135
	.long .L132-.L135
	.long .L134-.L135
	.long .L131-.L135
	.long .L131-.L135
	.long .L131-.L135
.L128:
	mulli 0,31,76
	lis 9,wrndtbl@ha
	la 9,wrndtbl@l(9)
	lwzx 3,9,0
	b .L137
.L131:
	lwz 3,1092(3)
	b .L137
.L132:
	lis 10,wrndtbl@ha
	mulli 7,31,76
	la 10,wrndtbl@l(10)
	addi 5,10,72
	addi 8,10,68
	lwzx 9,5,7
	lwzx 6,8,7
	addi 11,9,1
	divw 0,11,6
	slwi 9,9,2
	add 9,9,7
	lwzx 3,10,9
	mullw 0,0,6
	subf 11,0,11
	stwx 11,5,7
	b .L137
.L133:
	lis 29,wrndtbl@ha
	la 29,wrndtbl@l(29)
	bl rand
	rlwinm 3,3,0,17,31
	mulli 7,31,76
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 9,.LC39@ha
	lis 8,.LC38@ha
	stw 0,24(1)
	la 9,.LC39@l(9)
	addi 11,29,68
	lfd 0,24(1)
	lfd 11,0(9)
	lfs 13,.LC38@l(8)
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	fsub 0,0,11
	lfs 10,0(9)
	mr 9,10
	lwzx 10,11,7
	frsp 0,0
	fdivs 0,0,13
	fmuls 0,0,10
	fmr 13,0
	fctiwz 12,13
	stfd 12,24(1)
	lwz 9,28(1)
	divw 0,9,10
	mullw 0,0,10
	subf 9,0,9
	slwi 9,9,2
	add 9,9,7
	lwzx 3,29,9
	b .L137
.L134:
.L125:
	li 3,0
.L137:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 FindRandomWeapon,.Lfe2-FindRandomWeapon
	.align 2
	.globl FindInTable
	.type	 FindInTable,@function
FindInTable:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr. 0,3
	li 3,-1
	bc 12,2,.L138
	mr 3,0
	bl FindItemByClassname
	mr. 9,3
	bc 12,2,.L16
	lis 3,itemlist@ha
	lis 0,0x3cf3
	la 3,itemlist@l(3)
	ori 0,0,53053
	subf 3,3,9
	mullw 3,3,0
	srawi 3,3,2
	b .L138
.L16:
	li 3,-1
.L138:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 FindInTable,.Lfe3-FindInTable
	.comm	wrndtbl,19456,4
	.comm	actual_items,4,4
	.comm	rws_err_count,4,4
	.comm	map_name_copy,64,4
	.align 2
	.globl ReadString
	.type	 ReadString,@function
ReadString:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	mr 31,4
	li 30,0
.L12:
	stb 30,0(31)
	mr 3,31
	li 4,128
	mr 5,29
	bl fgets
	cmpwi 0,3,0
	li 3,0
	bc 12,2,.L139
	mr 3,31
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L9
	mr 3,31
	bl strlen
	add 3,31,3
	stb 30,-1(3)
.L9:
	lbz 0,0(31)
	cmpwi 0,0,59
	bc 12,2,.L12
	mr 3,31
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L12
	li 3,1
.L139:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 ReadString,.Lfe4-ReadString
	.align 2
	.globl ClockRandomError
	.type	 ClockRandomError,@function
ClockRandomError:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 5,4
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	crxor 6,6,6
	bl fprintf
	lis 11,rws_err_count@ha
	lwz 9,rws_err_count@l(11)
	addi 9,9,1
	stw 9,rws_err_count@l(11)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe5:
	.size	 ClockRandomError,.Lfe5-ClockRandomError
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
