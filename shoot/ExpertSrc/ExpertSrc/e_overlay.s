	.file	"e_overlay.c"
gcc2_compiled.:
	.globl scrPic
	.section	".sdata","aw"
	.align 2
	.type	 scrPic,@object
	.size	 scrPic,2
scrPic:
	.byte 49
	.byte 50
	.globl scrWidth
	.align 1
	.type	 scrWidth,@object
	.size	 scrWidth,4
scrWidth:
	.short 32
	.short 64
	.globl scrHeight
	.align 1
	.type	 scrHeight,@object
	.size	 scrHeight,4
scrHeight:
	.short 32
	.short 64
	.align 1
	.type	 curMode,@object
	.size	 curMode,2
curMode:
	.short 1024
	.align 2
	.type	 mpaSightings,@object
	.size	 mpaSightings,4
mpaSightings:
	.long 0
	.align 2
	.type	 mpaFixtures,@object
	.size	 mpaFixtures,4
mpaFixtures:
	.long 0
	.section	".rodata"
	.align 2
.LC0:
	.string	"xv %d yv %d string \"%s\" "
	.align 2
.LC1:
	.string	"xv %d yv 120 string \"%s\" "
	.section	".text"
	.align 2
	.globl OverlayPrint
	.type	 OverlayPrint,@function
OverlayPrint:
	stwu 1,-160(1)
	mflr 0
	stmw 25,132(1)
	stw 0,164(1)
	mr 31,3
	mr 28,4
	lwz 9,84(31)
	mr 30,5
	mr 25,6
	li 27,0
	lbz 0,4574(9)
	subfic 9,0,0
	adde. 26,9,0
	bc 4,2,.L8
	andi. 0,28,1
	bc 12,2,.L8
	mr 3,30
	bl strlen
	lwz 9,84(31)
	slwi 29,3,2
	li 4,34
	subfic 29,29,160
	addi 3,9,4473
	bl numchr
	slwi 7,3,2
	lis 5,.LC0@ha
	addi 3,1,8
	mr 6,29
	mr 8,30
	la 5,.LC0@l(5)
	subfic 7,7,120
	li 4,101
	crxor 6,6,6
	bl Com_sprintf
	lwz 3,84(31)
	addi 3,3,4473
	bl strlen
	mr 29,3
	addi 3,1,8
	bl strlen
	add 29,29,3
	cmplwi 0,29,100
	bc 12,1,.L8
	lwz 3,84(31)
	addi 4,1,8
	li 27,1
	addi 3,3,4473
	bl strcat
	lwz 9,84(31)
	stb 25,4574(9)
.L8:
	cmpwi 0,27,0
	bc 4,2,.L13
	cmpwi 0,26,0
	bc 4,2,.L11
	andi. 0,28,2
	bc 12,2,.L10
.L11:
	mr 3,30
	li 27,1
	bl strlen
	slwi 6,3,2
	lis 5,.LC1@ha
	addi 3,1,8
	la 5,.LC1@l(5)
	subfic 6,6,160
	mr 7,30
	li 4,101
	crxor 6,6,6
	bl Com_sprintf
	lwz 3,84(31)
	addi 4,1,8
	li 5,100
	addi 3,3,4473
	bl strncpy
	lwz 9,84(31)
	stb 25,4574(9)
.L10:
	cmpwi 0,27,0
	bc 12,2,.L12
.L13:
	andi. 0,28,4
	bc 12,2,.L12
	mr 3,31
	bl OverlayUpdate
.L12:
	lwz 0,164(1)
	mtlr 0
	lmw 25,132(1)
	la 1,160(1)
	blr
.Lfe1:
	.size	 OverlayPrint,.Lfe1-OverlayPrint
	.section	".rodata"
	.align 2
.LC2:
	.string	"Expert Overlay Warning: Sightings Overflow.\n"
	.section	".text"
	.align 2
	.globl RecordSighting
	.type	 RecordSighting,@function
RecordSighting:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,game@ha
	li 5,0
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,5,0
	bc 4,0,.L16
	mr 30,9
	lis 31,mpaSightings@ha
	lis 12,level@ha
.L18:
	lwz 8,mpaSightings@l(31)
	mulli 10,5,12
	lwz 6,level@l(12)
	add 7,10,8
	lwz 0,8(7)
	cmpw 0,0,6
	bc 4,0,.L19
	stwx 4,10,8
	lwz 9,level@l(12)
	addi 9,9,16
	stw 9,8(7)
	lwz 11,84(3)
	lbz 0,3479(11)
	stb 0,4(7)
	b .L14
.L19:
	lwz 9,84(3)
	lbz 11,4(7)
	lwz 0,3476(9)
	cmpw 0,11,0
	bc 4,2,.L17
	lwzx 0,10,8
	cmpw 0,0,4
	bc 4,2,.L17
	addi 0,6,16
	stw 0,8(7)
	b .L14
.L17:
	addi 0,5,1
	lwz 9,1544(30)
	rlwinm 5,0,0,0xff
	cmpw 0,5,9
	bc 12,0,.L18
.L16:
	lis 9,gi+4@ha
	lis 3,.LC2@ha
	lwz 0,gi+4@l(9)
	la 3,.LC2@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L14:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 RecordSighting,.Lfe2-RecordSighting
	.section	".rodata"
	.align 2
.LC3:
	.string	"wea"
	.align 2
.LC4:
	.string	"ite"
	.align 2
.LC5:
	.string	"item_p"
	.align 2
.LC6:
	.string	"item_inv"
	.align 2
.LC7:
	.string	"item_qua"
	.align 2
.LC8:
	.string	"item_ban"
	.align 2
.LC9:
	.string	"item_health_mega"
	.align 2
.LC10:
	.string	"item_sil"
	.align 2
.LC11:
	.string	"item_armor_body"
	.align 2
.LC12:
	.string	"item_armor_combat"
	.section	".text"
	.align 2
	.globl InitRadar
	.type	 InitRadar,@function
InitRadar:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 28,game@ha
	lis 29,gi@ha
	la 29,gi@l(29)
	la 28,game@l(28)
	lwz 9,132(29)
	li 4,766
	lis 27,mpaSightings@ha
	lwz 3,1544(28)
	lis 26,mpaFixtures@ha
	li 31,32
	mtlr 9
	lis 25,g_edicts@ha
	lis 30,globals@ha
	mulli 3,3,12
	blrl
	lwz 0,132(29)
	li 4,766
	stw 3,mpaSightings@l(27)
	mtlr 0
	li 3,512
	blrl
	lwz 11,1544(28)
	lis 10,globals+72@ha
	lis 8,g_edicts@ha
	lwz 9,globals+72@l(10)
	lwz 0,g_edicts@l(8)
	mulli 11,11,916
	mulli 9,9,916
	stw 3,mpaFixtures@l(26)
	add 11,0,11
	add 0,0,9
	addi 29,11,916
	cmplw 0,29,0
	bc 4,0,.L25
	lis 28,mcFixtures@ha
	lis 27,mpaFixtures@ha
.L27:
	lwz 3,280(29)
	lis 4,.LC3@ha
	li 5,3
	la 4,.LC3@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 4,2,.L28
	lha 11,mcFixtures@l(28)
	li 0,102
	b .L36
.L28:
	lwz 3,280(29)
	lis 4,.LC4@ha
	li 5,3
	la 4,.LC4@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 4,2,.L26
	lwz 3,280(29)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L33
	lwz 3,280(29)
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L33
	lwz 3,280(29)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L33
	lwz 3,280(29)
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L33
	lwz 3,280(29)
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L33
	lwz 3,280(29)
	lis 4,.LC10@ha
	la 4,.LC10@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L33
	lwz 3,280(29)
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L33
	lwz 3,280(29)
	lis 4,.LC12@ha
	la 4,.LC12@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L26
.L33:
	lha 11,mcFixtures@l(28)
	li 0,112
.L36:
	la 3,mpaFixtures@l(27)
	lwz 9,mpaFixtures@l(27)
	slwi 11,11,3
	stwx 29,11,9
	add 11,11,9
	stb 0,4(11)
	lhz 9,mcFixtures@l(28)
	addi 9,9,1
	extsh 0,9
	sth 9,mcFixtures@l(28)
	cmpw 0,0,31
	bc 4,2,.L26
	slwi 4,31,4
	slwi 5,31,3
	bl ResizeLevelMemory
	add 0,31,31
	extsh 31,0
.L26:
	la 11,globals@l(30)
	lwz 9,g_edicts@l(25)
	addi 29,29,916
	lwz 0,72(11)
	mulli 0,0,916
	add 9,9,0
	cmplw 0,29,9
	bc 12,0,.L27
.L25:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 InitRadar,.Lfe3-InitRadar
	.section	".rodata"
	.align 2
.LC13:
	.long 0x0
	.long 0x0
	.long 0xbf800000
	.align 2
.LC14:
	.long 0x42b40000
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Plot
	.type	 Plot,@function
Plot:
	stwu 1,-80(1)
	mflr 0
	stmw 28,64(1)
	stw 0,84(1)
	lis 9,.LC13@ha
	lis 11,mpedCur@ha
	lwz 10,.LC13@l(9)
	addi 31,1,24
	lis 8,curMode@ha
	lwz 12,mpedCur@l(11)
	la 9,.LC13@l(9)
	lwz 0,4(9)
	li 6,0
	mr 28,4
	lwz 11,8(9)
	mr 29,5
	stw 10,24(1)
	stw 0,4(31)
	stw 11,8(31)
	lfs 13,4(3)
	lfs 0,4(12)
	lfs 11,8(3)
	lfs 10,12(3)
	fsubs 0,0,13
	lhz 0,curMode@l(8)
	andi. 9,0,64
	stfs 0,8(1)
	lfs 13,8(12)
	fsubs 13,13,11
	stfs 13,12(1)
	lfs 0,12(12)
	stw 6,16(1)
	fsubs 0,0,10
	fctiwz 12,0
	stfd 12,56(1)
	lwz 30,60(1)
	bc 12,2,.L38
	lis 11,.LC14@ha
	mr 4,31
	la 11,.LC14@l(11)
	addi 3,1,40
	lfs 1,0(11)
	addi 5,1,8
	bl RotatePointAroundVector
	b .L39
.L38:
	lfs 1,20(12)
	mr 4,31
	addi 3,1,40
	addi 5,1,8
	bl RotatePointAroundVector
.L39:
	lis 9,curMode@ha
	lhz 0,curMode@l(9)
	andi. 9,0,128
	bc 12,2,.L40
	lis 9,vscale@ha
	lis 11,curScreen@ha
	lfs 10,44(1)
	lhz 8,vscale@l(9)
	lis 10,scrHeight@ha
	lhz 9,curScreen@l(11)
	la 10,scrHeight@l(10)
	divw 8,30,8
	add 9,9,9
	lhax 0,10,9
	srwi 11,0,31
	add 0,0,11
	srawi 0,0,1
	add 6,8,0
	b .L41
.L40:
	lis 11,vscale@ha
	lfs 13,40(1)
	lhz 9,vscale@l(11)
	lis 7,0x4330
	lis 10,curScreen@ha
	lis 11,.LC15@ha
	lhz 0,curScreen@l(10)
	xoris 9,9,0x8000
	la 11,.LC15@l(11)
	lfs 10,44(1)
	stw 9,60(1)
	add 0,0,0
	mr 10,8
	stw 7,56(1)
	lfd 11,0(11)
	lfd 0,56(1)
	lis 11,scrHeight@ha
	la 11,scrHeight@l(11)
	lhax 9,11,0
	fsub 0,0,11
	srwi 0,9,31
	add 9,9,0
	frsp 0,0
	srawi 9,9,1
	fdivs 13,13,0
	fctiwz 12,13
	stfd 12,56(1)
	lwz 10,60(1)
	add 6,10,9
.L41:
	lis 9,hscale@ha
	lhz 0,hscale@l(9)
	lis 7,0x4330
	lis 11,curScreen@ha
	lis 9,.LC15@ha
	lhz 8,curScreen@l(11)
	xoris 0,0,0x8000
	la 9,.LC15@l(9)
	stw 0,60(1)
	add 5,8,8
	mr 11,10
	stw 7,56(1)
	andi. 0,29,1
	lfd 13,0(9)
	lfd 0,56(1)
	lis 9,scrWidth@ha
	la 9,scrWidth@l(9)
	lhax 7,9,5
	fsub 0,0,13
	srwi 0,7,31
	add 0,7,0
	frsp 0,0
	srawi 0,0,1
	fdivs 0,10,0
	fmr 13,0
	fctiwz 12,13
	stfd 12,56(1)
	lwz 11,60(1)
	add 8,11,0
	bc 12,2,.L42
	lis 9,scrHeight@ha
	cmpw 7,7,8
	la 9,scrHeight@l(9)
	lhax 10,9,5
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	cmpw 6,10,6
	neg 0,0
	andc 11,8,0
	and 0,7,0
	cror 27,26,24
	mfcr 9
	rlwinm 9,9,28,1
	or 8,0,11
	neg 9,9
	nor 11,8,8
	andc 0,6,9
	and 10,10,9
	or 6,10,0
	srawi 11,11,31
	nor 0,6,6
	and 8,8,11
	srawi 0,0,31
	and 6,6,0
	b .L47
.L42:
	cmpw 7,7,8
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 11,8,0
	and 0,7,0
	or 0,0,11
	nor 9,0,0
	srawi 9,9,31
	and 0,0,9
	cmpw 0,8,0
	bc 4,2,.L37
	lis 9,scrHeight@ha
	la 9,scrHeight@l(9)
	lhax 11,9,5
	cmpw 7,11,6
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,6,0
	and 11,11,0
	or 11,11,9
	nor 0,11,11
	srawi 0,0,31
	and 11,11,0
	cmpw 0,6,11
	bc 4,2,.L37
.L47:
	andi. 9,29,2
	slwi 10,8,6
	bc 4,2,.L55
	add 0,10,8
	lis 9,blip@ha
	la 9,blip@l(9)
	add 0,6,0
	lbzx 11,9,0
	cmpwi 0,11,1
	bc 4,2,.L37
.L55:
	add 0,10,8
	lis 9,blip@ha
	la 9,blip@l(9)
	add 0,6,0
	stbx 28,9,0
	lis 11,IsRow@ha
	lis 10,IsColumn@ha
	li 0,1
	la 11,IsRow@l(11)
	slwi 9,6,2
	la 10,IsColumn@l(10)
	slwi 8,8,2
	stwx 0,11,9
	stwx 0,10,8
.L37:
	lwz 0,84(1)
	mtlr 0
	lmw 28,64(1)
	la 1,80(1)
	blr
.Lfe4:
	.size	 Plot,.Lfe4-Plot
	.align 2
	.globl PlotFixtures
	.type	 PlotFixtures,@function
PlotFixtures:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,mcFixtures@ha
	li 31,0
	lha 0,mcFixtures@l(9)
	lis 28,mcFixtures@ha
	cmpw 0,31,0
	bc 4,0,.L58
	lis 29,mpaFixtures@ha
	lis 30,curMode@ha
.L60:
	slwi 9,31,3
	lwz 11,mpaFixtures@l(29)
	mr 10,9
	add 9,9,11
	lbz 0,4(9)
	cmpwi 0,0,102
	bc 12,2,.L62
	cmpwi 0,0,112
	bc 12,2,.L64
	b .L66
.L62:
	lhz 0,curMode@l(30)
	andi. 9,0,8
	bc 12,2,.L59
	lwzx 3,10,11
	li 4,102
	b .L69
.L64:
	lhz 0,curMode@l(30)
	andi. 9,0,16
	bc 12,2,.L59
	lwzx 3,10,11
	li 4,112
.L69:
	li 5,0
	bl Plot
	b .L59
.L66:
	lwz 9,mpaFixtures@l(29)
	li 5,0
	add 11,10,9
	lwzx 3,10,9
	lbz 4,4(11)
	bl Plot
.L59:
	addi 0,31,1
	lha 9,mcFixtures@l(28)
	extsh 31,0
	cmpw 0,31,9
	bc 12,0,.L60
.L58:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 PlotFixtures,.Lfe5-PlotFixtures
	.align 2
	.globl PlotPlayers
	.type	 PlotPlayers,@function
PlotPlayers:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game@ha
	li 31,0
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,31,0
	bc 4,0,.L72
	mr 28,9
	lis 29,g_edicts@ha
	lis 30,mpedCur@ha
.L74:
	mulli 0,31,916
	lwz 9,g_edicts@l(29)
	add 9,9,0
	addi 3,9,916
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L73
	lwz 9,mpedCur@l(30)
	lwz 11,84(3)
	lwz 10,84(9)
	lwz 8,3476(11)
	lwz 0,3476(10)
	cmpw 0,0,8
	bc 4,2,.L73
	li 4,119
	li 5,0
	bl Plot
.L73:
	addi 0,31,1
	lwz 9,1544(28)
	rlwinm 31,0,0,0xff
	cmpw 0,31,9
	bc 12,0,.L74
.L72:
	lis 9,game@ha
	li 31,0
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,31,0
	bc 4,0,.L78
	mr 27,9
	lis 28,mpaSightings@ha
	lis 29,level@ha
	lis 30,mpedCur@ha
.L80:
	lwz 7,mpaSightings@l(28)
	mulli 8,31,12
	lwz 9,level@l(29)
	add 10,8,7
	lwz 0,8(10)
	cmpw 0,0,9
	bc 4,1,.L79
	lwz 11,mpedCur@l(30)
	lbz 10,4(10)
	lwz 9,84(11)
	lwz 0,3476(9)
	cmpw 0,10,0
	bc 4,2,.L79
	lwzx 3,8,7
	li 4,114
	li 5,0
	bl Plot
.L79:
	addi 0,31,1
	lwz 9,1544(27)
	rlwinm 31,0,0,0xff
	cmpw 0,31,9
	bc 12,0,.L80
.L78:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 PlotPlayers,.Lfe6-PlotPlayers
	.section	".rodata"
	.align 2
.LC16:
	.string	"xl %d "
	.align 2
.LC17:
	.string	"yt %d picn %c "
	.align 2
.LC18:
	.string	"yt %d "
	.align 2
.LC19:
	.string	"xl %d picn %c "
	.section	".text"
	.align 2
	.globl AppendRadar
	.type	 AppendRadar,@function
AppendRadar:
	stwu 1,-96(1)
	mflr 0
	stmw 19,44(1)
	stw 0,100(1)
	lis 9,curScreen@ha
	lis 11,scrWidth@ha
	lhz 0,curScreen@l(9)
	la 11,scrWidth@l(11)
	li 30,0
	mr 28,3
	lis 22,curScreen@ha
	add 0,0,0
	lhax 10,11,0
	cmpw 0,30,10
	bc 12,1,.L85
	lis 9,scrHeight@ha
	lis 11,IsColumn@ha
	la 9,scrHeight@l(9)
	la 12,IsColumn@l(11)
	lhax 26,9,0
	mr 21,9
	mr 27,10
	mr 29,0
	li 23,0
	lis 24,IsRow@ha
	lis 25,blip@ha
.L87:
	li 31,0
	slwi 0,30,2
	cmpw 0,31,26
	stwx 23,12,0
	addi 4,30,1
	bc 12,1,.L86
	slwi 0,30,6
	lhax 8,21,29
	la 3,IsRow@l(24)
	add 10,0,30
	li 5,0
	la 6,blip@l(25)
	li 7,1
.L91:
	slwi 9,31,2
	add 11,31,10
	addi 0,31,1
	stwx 5,3,9
	extsh 31,0
	stbx 7,6,11
	cmpw 0,31,8
	bc 4,1,.L91
.L86:
	extsh 30,4
	cmpw 0,30,27
	bc 4,1,.L87
.L85:
	lis 9,gametype@ha
	lwz 0,gametype@l(9)
	cmpwi 0,0,1
	bc 4,2,.L94
	bl PlotFixtures
	b .L95
.L94:
	bl PlotPlayers
	bl PlotFixtures
.L95:
	lis 9,curMode@ha
	lhz 0,curMode@l(9)
	andi. 9,0,4
	bc 12,2,.L96
	lis 9,curScreen@ha
	lis 11,scrPic@ha
	lhz 8,curScreen@l(9)
	la 11,scrPic@l(11)
	li 10,1
	lis 7,blip@ha
	lis 6,IsColumn@ha
	lbzx 0,11,8
	lis 9,IsRow@ha
	stw 10,IsRow@l(9)
	stb 0,blip@l(7)
	stw 10,IsColumn@l(6)
.L96:
	lis 11,curScreen@ha
	lis 9,scrWidth@ha
	lhz 0,curScreen@l(11)
	la 9,scrWidth@l(9)
	li 30,0
	li 8,0
	li 10,0
	add 0,0,0
	lhax 0,9,0
	cmpw 0,30,0
	bc 12,1,.L98
	lis 9,IsColumn@ha
	mr 11,0
	la 7,IsColumn@l(9)
.L100:
	slwi 0,30,2
	lwzx 9,7,0
	cmpwi 0,9,0
	bc 12,2,.L99
	addi 0,10,1
	extsh 10,0
.L99:
	addi 0,30,1
	extsh 30,0
	cmpw 0,30,11
	bc 4,1,.L100
.L98:
	lis 11,curScreen@ha
	lis 9,scrHeight@ha
	lhz 0,curScreen@l(11)
	la 9,scrHeight@l(9)
	li 31,0
	add 0,0,0
	lhax 0,9,0
	cmpw 0,31,0
	bc 12,1,.L104
	lis 9,IsRow@ha
	mr 11,0
	la 7,IsRow@l(9)
.L106:
	slwi 0,31,2
	lwzx 9,7,0
	cmpwi 0,9,0
	bc 12,2,.L105
	addi 0,8,1
	extsh 8,0
.L105:
	addi 0,31,1
	extsh 31,0
	cmpw 0,31,11
	bc 4,1,.L106
.L104:
	cmpw 0,8,10
	bc 12,0,.L109
	lis 9,curScreen@ha
	lis 11,scrWidth@ha
	lhz 0,curScreen@l(9)
	la 10,scrWidth@l(11)
	li 30,0
	add 0,0,0
	lhax 9,10,0
	cmpw 0,30,9
	bc 12,1,.L83
	lis 9,IsColumn@ha
	lis 11,scrHeight@ha
	la 19,IsColumn@l(9)
	la 20,scrHeight@l(11)
	mr 21,10
.L113:
	slwi 0,30,2
	lwzx 9,19,0
	cmpwi 0,9,0
	bc 12,2,.L112
	lis 9,hpos@ha
	lis 3,.LC16@ha
	lhz 4,hpos@l(9)
	la 3,.LC16@l(3)
	add 4,4,30
	crxor 6,6,6
	bl va
	mr 4,3
	addi 3,1,8
	bl strcpy
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,28
	bl strlen
	add 29,29,3
	cmplwi 0,29,1399
	bc 12,1,.L83
	mr 3,28
	addi 4,1,8
	bl strcat
	li 31,0
	lhz 0,curScreen@l(22)
	add 0,0,0
	lhax 9,20,0
	cmpw 0,31,9
	bc 12,1,.L112
	lis 9,blip@ha
	slwi 0,30,6
	la 23,blip@l(9)
	add 27,0,30
	lis 9,scrHeight@ha
	lis 24,vpos@ha
	la 25,scrHeight@l(9)
	lis 26,.LC17@ha
.L119:
	add 0,31,27
	lbzx 5,23,0
	cmpwi 0,5,1
	bc 12,2,.L118
	lhz 4,vpos@l(24)
	la 3,.LC17@l(26)
	add 4,4,31
	crxor 6,6,6
	bl va
	mr 4,3
	addi 3,1,8
	bl strcpy
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,28
	bl strlen
	add 29,29,3
	cmplwi 0,29,1399
	bc 12,1,.L83
	mr 3,28
	addi 4,1,8
	bl strcat
.L118:
	lhz 0,curScreen@l(22)
	addi 9,31,1
	extsh 31,9
	add 0,0,0
	lhax 9,25,0
	cmpw 0,31,9
	bc 4,1,.L119
.L112:
	lhz 0,curScreen@l(22)
	addi 9,30,1
	extsh 30,9
	add 0,0,0
	lhax 9,21,0
	cmpw 0,30,9
	bc 4,1,.L113
	b .L83
.L109:
	lis 9,curScreen@ha
	lis 11,scrHeight@ha
	lhz 0,curScreen@l(9)
	la 10,scrHeight@l(11)
	li 31,0
	add 0,0,0
	lhax 9,10,0
	cmpw 0,31,9
	bc 12,1,.L83
	lis 9,IsRow@ha
	lis 11,scrWidth@ha
	la 20,IsRow@l(9)
	la 21,scrWidth@l(11)
	mr 23,10
.L128:
	slwi 0,31,2
	lwzx 9,20,0
	cmpwi 0,9,0
	bc 12,2,.L127
	lis 9,vpos@ha
	lis 3,.LC18@ha
	lhz 4,vpos@l(9)
	la 3,.LC18@l(3)
	add 4,4,31
	crxor 6,6,6
	bl va
	mr 4,3
	addi 3,1,8
	bl strcpy
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,28
	bl strlen
	add 29,29,3
	cmplwi 0,29,1399
	bc 12,1,.L83
	mr 3,28
	addi 4,1,8
	bl strcat
	li 30,0
	lhz 0,curScreen@l(22)
	add 0,0,0
	lhax 9,21,0
	cmpw 0,30,9
	bc 12,1,.L127
	lis 9,blip@ha
	lis 11,scrWidth@ha
	la 24,blip@l(9)
	la 25,scrWidth@l(11)
	lis 26,hpos@ha
	lis 27,.LC19@ha
.L134:
	slwi 0,30,6
	add 0,0,30
	add 0,31,0
	lbzx 5,24,0
	cmpwi 0,5,1
	bc 12,2,.L133
	lhz 4,hpos@l(26)
	la 3,.LC19@l(27)
	add 4,4,30
	crxor 6,6,6
	bl va
	mr 4,3
	addi 3,1,8
	bl strcpy
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,28
	bl strlen
	add 29,29,3
	cmplwi 0,29,1399
	bc 12,1,.L83
	mr 3,28
	addi 4,1,8
	bl strcat
.L133:
	lhz 0,curScreen@l(22)
	addi 9,30,1
	extsh 30,9
	add 0,0,0
	lhax 9,25,0
	cmpw 0,30,9
	bc 4,1,.L134
.L127:
	lhz 0,curScreen@l(22)
	addi 9,31,1
	extsh 31,9
	add 0,0,0
	lhax 9,23,0
	cmpw 0,31,9
	bc 4,1,.L128
.L83:
	lwz 0,100(1)
	mtlr 0
	lmw 19,44(1)
	la 1,96(1)
	blr
.Lfe7:
	.size	 AppendRadar,.Lfe7-AppendRadar
	.section	".rodata"
	.align 2
.LC20:
	.string	"set %s %i u \n"
	.align 2
.LC21:
	.string	"hpos"
	.align 2
.LC22:
	.string	"vpos"
	.align 2
.LC23:
	.string	"hscale"
	.align 2
.LC24:
	.string	"vscale"
	.align 2
.LC25:
	.string	"screen"
	.align 2
.LC26:
	.string	"mode"
	.section	".text"
	.align 2
	.globl ResetConfig
	.type	 ResetConfig,@function
ResetConfig:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,.LC21@ha
	lis 30,mpedCur@ha
	la 31,.LC21@l(9)
	lis 28,.LC20@ha
	lwz 29,mpedCur@l(30)
	li 5,4
	mr 4,31
	la 3,.LC20@l(28)
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
	lwz 9,mpedCur@l(30)
	mr 4,31
	lwz 3,84(9)
	addi 3,3,188
	bl Info_ValueForKey
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L146
	mr 4,31
	lwz 29,mpedCur@l(30)
	la 3,.LC20@l(28)
	li 5,4
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
.L146:
	lis 9,.LC22@ha
	li 5,4
	lwz 29,mpedCur@l(30)
	la 31,.LC22@l(9)
	la 3,.LC20@l(28)
	mr 4,31
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
	lwz 9,mpedCur@l(30)
	mr 4,31
	lwz 3,84(9)
	addi 3,3,188
	bl Info_ValueForKey
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L148
	mr 4,31
	lwz 29,mpedCur@l(30)
	la 3,.LC20@l(28)
	li 5,4
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
.L148:
	lis 9,.LC23@ha
	li 5,100
	lwz 29,mpedCur@l(30)
	la 31,.LC23@l(9)
	la 3,.LC20@l(28)
	mr 4,31
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
	lwz 9,mpedCur@l(30)
	mr 4,31
	lwz 3,84(9)
	addi 3,3,188
	bl Info_ValueForKey
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L150
	mr 4,31
	lwz 29,mpedCur@l(30)
	la 3,.LC20@l(28)
	li 5,100
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
.L150:
	lis 9,.LC24@ha
	li 5,100
	lwz 29,mpedCur@l(30)
	la 31,.LC24@l(9)
	la 3,.LC20@l(28)
	mr 4,31
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
	lwz 9,mpedCur@l(30)
	mr 4,31
	lwz 3,84(9)
	addi 3,3,188
	bl Info_ValueForKey
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L152
	mr 4,31
	lwz 29,mpedCur@l(30)
	la 3,.LC20@l(28)
	li 5,100
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
.L152:
	lis 9,.LC25@ha
	li 5,0
	lwz 29,mpedCur@l(30)
	la 31,.LC25@l(9)
	la 3,.LC20@l(28)
	mr 4,31
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
	lwz 9,mpedCur@l(30)
	mr 4,31
	lwz 3,84(9)
	addi 3,3,188
	bl Info_ValueForKey
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L154
	mr 4,31
	lwz 29,mpedCur@l(30)
	la 3,.LC20@l(28)
	li 5,0
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
.L154:
	lis 9,.LC26@ha
	li 5,-1
	lwz 29,mpedCur@l(30)
	la 31,.LC26@l(9)
	la 3,.LC20@l(28)
	mr 4,31
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
	lwz 9,mpedCur@l(30)
	mr 4,31
	lwz 3,84(9)
	addi 3,3,188
	bl Info_ValueForKey
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L156
	lwz 29,mpedCur@l(30)
	mr 4,31
	la 3,.LC20@l(28)
	li 5,-1
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
.L156:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 ResetConfig,.Lfe8-ResetConfig
	.align 2
	.globl SetCurrentPlayer
	.type	 SetCurrentPlayer,@function
SetCurrentPlayer:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,mpedCur@ha
	lis 11,hpos@ha
	lwz 10,mpedCur@l(9)
	lis 4,.LC21@ha
	la 31,hpos@l(11)
	la 4,.LC21@l(4)
	lwz 3,84(10)
	addi 3,3,188
	bl Info_ValueForKey
	li 4,4
	bl StrToInt
	mr. 3,3
	bc 12,0,.L158
	cmpwi 0,3,1600
	bc 4,1,.L160
.L158:
	li 3,4
.L160:
	sth 3,0(31)
	lis 11,mpedCur@ha
	lis 9,vpos@ha
	lwz 10,mpedCur@l(11)
	lis 4,.LC22@ha
	la 31,vpos@l(9)
	la 4,.LC22@l(4)
	lwz 3,84(10)
	addi 3,3,188
	bl Info_ValueForKey
	li 4,4
	bl StrToInt
	mr. 3,3
	bc 12,0,.L161
	cmpwi 0,3,1600
	bc 4,1,.L163
.L161:
	li 3,4
.L163:
	sth 3,0(31)
	lis 11,mpedCur@ha
	lis 9,hscale@ha
	lwz 10,mpedCur@l(11)
	lis 4,.LC23@ha
	la 31,hscale@l(9)
	la 4,.LC23@l(4)
	lwz 3,84(10)
	addi 3,3,188
	bl Info_ValueForKey
	li 4,100
	bl StrToInt
	cmpwi 0,3,2
	bc 12,0,.L164
	cmpwi 0,3,1000
	bc 4,1,.L166
.L164:
	li 3,100
.L166:
	sth 3,0(31)
	lis 11,mpedCur@ha
	lis 9,vscale@ha
	lwz 10,mpedCur@l(11)
	lis 4,.LC24@ha
	la 31,vscale@l(9)
	la 4,.LC24@l(4)
	lwz 3,84(10)
	addi 3,3,188
	bl Info_ValueForKey
	li 4,100
	bl StrToInt
	cmpwi 0,3,2
	bc 12,0,.L167
	cmpwi 0,3,1000
	bc 4,1,.L169
.L167:
	li 3,100
.L169:
	sth 3,0(31)
	lis 11,mpedCur@ha
	lis 9,curScreen@ha
	lwz 10,mpedCur@l(11)
	lis 4,.LC25@ha
	la 31,curScreen@l(9)
	la 4,.LC25@l(4)
	lwz 3,84(10)
	addi 3,3,188
	bl Info_ValueForKey
	li 4,0
	bl StrToInt
	mr. 3,3
	bc 12,0,.L170
	cmpwi 0,3,1
	bc 4,1,.L172
.L170:
	li 3,0
.L172:
	lis 9,gametype@ha
	sth 3,0(31)
	lwz 0,gametype@l(9)
	cmpwi 0,0,1
	bc 4,2,.L173
	lis 9,mpedCur@ha
	lis 11,curMode@ha
	lwz 10,mpedCur@l(9)
	lis 4,.LC26@ha
	la 31,curMode@l(11)
	la 4,.LC26@l(4)
	lwz 3,84(10)
	addi 3,3,188
	bl Info_ValueForKey
	li 4,1054
	bl StrToInt
	mr. 3,3
	bc 12,0,.L174
	cmpwi 0,3,32767
	bc 4,1,.L180
.L174:
	li 3,1054
	b .L180
.L173:
	lis 9,mpedCur@ha
	lis 11,curMode@ha
	lwz 10,mpedCur@l(9)
	lis 4,.LC26@ha
	la 31,curMode@l(11)
	la 4,.LC26@l(4)
	lwz 3,84(10)
	addi 3,3,188
	bl Info_ValueForKey
	li 4,1030
	bl StrToInt
	mr. 3,3
	bc 12,0,.L178
	cmpwi 0,3,32767
	bc 4,1,.L180
.L178:
	li 3,1030
.L180:
	sth 3,0(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 SetCurrentPlayer,.Lfe9-SetCurrentPlayer
	.section	".rodata"
	.align 2
.LC27:
	.string	"on"
	.align 2
.LC28:
	.string	"yes"
	.align 2
.LC29:
	.string	"off"
	.align 2
.LC30:
	.string	"no"
	.section	".text"
	.align 2
	.globl SetProperMode
	.type	 SetProperMode,@function
SetProperMode:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,gi+160@ha
	mr 31,3
	lwz 0,gi+160@l(9)
	li 3,1
	lis 28,curMode@ha
	mtlr 0
	blrl
	lis 9,curMode@ha
	mr 29,3
	lis 4,.LC27@ha
	lis 5,0x1
	lha 30,curMode@l(9)
	la 4,.LC27@l(4)
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 12,2,.L183
	lis 4,.LC28@ha
	lis 5,0x1
	la 4,.LC28@l(4)
	mr 3,29
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 12,2,.L183
	mr 3,29
	li 4,-1
	bl StrToInt
	cmpwi 0,3,1
	bc 4,2,.L182
.L183:
	lis 9,curMode@ha
	lhz 0,curMode@l(9)
	or 0,0,31
	sth 0,curMode@l(9)
	b .L184
.L182:
	lis 4,.LC29@ha
	lis 5,0x1
	la 4,.LC29@l(4)
	mr 3,29
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 12,2,.L186
	lis 4,.LC30@ha
	lis 5,0x1
	la 4,.LC30@l(4)
	mr 3,29
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 12,2,.L186
	mr 3,29
	li 4,-1
	bl StrToInt
	cmpwi 0,3,0
	bc 4,2,.L185
.L186:
	lis 9,curMode@ha
	rlwinm 0,31,0,0xffff
	lhz 11,curMode@l(9)
	andc 0,11,0
	sth 0,curMode@l(9)
	b .L184
.L185:
	lhz 0,curMode@l(28)
	xor 0,0,31
	sth 0,curMode@l(28)
.L184:
	lis 9,curMode@ha
	lhz 31,curMode@l(9)
	cmpw 0,30,31
	bc 12,2,.L188
	lis 9,.LC26@ha
	lis 28,mpedCur@ha
	la 30,.LC26@l(9)
	lis 27,.LC20@ha
	lwz 29,mpedCur@l(28)
	mr 5,31
	mr 4,30
	la 3,.LC20@l(27)
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
	lwz 9,mpedCur@l(28)
	mr 4,30
	lwz 3,84(9)
	addi 3,3,188
	bl Info_ValueForKey
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L188
	lwz 29,mpedCur@l(28)
	mr 4,30
	la 3,.LC20@l(27)
	mr 5,31
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
.L188:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 SetProperMode,.Lfe10-SetProperMode
	.section	".rodata"
	.align 2
.LC31:
	.string	"Current %s setting: %i. \n"
	.align 2
.LC32:
	.string	"%i is an unusable %s setting. Please try a different value.\n"
	.align 2
.LC33:
	.string	"reset"
	.align 2
.LC34:
	.string	"overlay"
	.align 2
.LC35:
	.string	"Mar 11th, R27"
	.align 2
.LC36:
	.string	"print"
	.align 2
.LC37:
	.string	"legend"
	.align 2
.LC38:
	.string	"No legend defined for current game mode.\n"
	.align 2
.LC39:
	.string	"Green dots are weapons. Yellow dots are powerups. Items taken do not disappear from the radar, as that would supply too much knowledge about player movements.\n"
	.align 2
.LC40:
	.string	"matrix"
	.align 2
.LC41:
	.string	"LEARN"
	.align 2
.LC42:
	.string	"RADAR"
	.align 2
.LC43:
	.string	"backdrop"
	.align 2
.LC44:
	.string	"rotation"
	.align 2
.LC45:
	.string	"ZVERT"
	.align 2
.LC46:
	.string	"SHOWWEAP"
	.align 2
.LC47:
	.string	"SHOWPOWER"
	.align 2
.LC48:
	.string	"horizontal position"
	.align 2
.LC49:
	.string	"testvar"
	.align 2
.LC50:
	.string	"Testvar value: %i\n"
	.align 2
.LC51:
	.string	"vertical position"
	.align 2
.LC52:
	.string	"scale"
	.align 2
.LC53:
	.string	"horizontal scale"
	.align 2
.LC54:
	.string	"vertical scale"
	.section	".text"
	.align 2
	.globl ValidOverlayCommand
	.type	 ValidOverlayCommand,@function
ValidOverlayCommand:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 9,gi@ha
	mr 29,3
	la 30,gi@l(9)
	li 3,0
	lwz 9,160(30)
	lis 26,mpedCur@ha
	mtlr 9
	blrl
	lwz 9,160(30)
	mr 28,3
	li 3,1
	mtlr 9
	blrl
	li 4,-1
	bl StrToInt
	lis 9,sv_expflags@ha
	lwz 10,sv_expflags@l(9)
	mr 31,3
	lis 9,mpedCur@ha
	lfs 0,20(10)
	stw 29,mpedCur@l(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 0,11,8
	bc 12,2,.L195
	bl SetCurrentPlayer
.L195:
	lis 4,.LC33@ha
	lis 5,0x1
	la 4,.LC33@l(4)
	mr 3,28
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L196
	bl ResetConfig
	b .L197
.L196:
	lis 4,.LC34@ha
	lis 5,0x1
	la 4,.LC34@l(4)
	mr 3,28
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L198
	lwz 0,8(30)
	lis 5,.LC35@ha
	li 4,2
	lwz 3,mpedCur@l(26)
	la 5,.LC35@l(5)
	b .L295
.L198:
	lis 4,.LC36@ha
	lis 5,0x1
	la 4,.LC36@l(4)
	mr 3,28
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 12,2,.L197
	lis 4,.LC37@ha
	lis 5,0x1
	la 4,.LC37@l(4)
	mr 3,28
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L202
	lis 9,gametype@ha
	lwz 0,gametype@l(9)
	cmpwi 0,0,1
	bc 12,2,.L203
	lwz 9,8(30)
	lis 5,.LC38@ha
	li 4,2
	la 5,.LC38@l(5)
	lwz 3,mpedCur@l(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L203:
	lis 9,curMode@ha
	lhz 0,curMode@l(9)
	rlwinm 0,0,0,27,28
	cmpwi 0,0,0
	bc 12,2,.L197
	lwz 0,8(30)
	lis 5,.LC39@ha
	li 4,2
	lwz 3,mpedCur@l(26)
	la 5,.LC39@l(5)
.L295:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L197
.L202:
	lis 4,.LC40@ha
	lis 5,0x1
	la 4,.LC40@l(4)
	mr 3,28
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L209
	lwz 3,mpedCur@l(26)
	lwz 9,84(3)
	lwz 0,4064(9)
	xori 0,0,2
	stw 0,4064(9)
	bl OverlayUpdate
	b .L197
.L209:
	lis 4,.LC41@ha
	lis 5,0x1
	la 4,.LC41@l(4)
	mr 3,28
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L211
	li 3,1024
	bl SetProperMode
	b .L197
.L211:
	lis 4,.LC42@ha
	lis 5,0x1
	la 4,.LC42@l(4)
	mr 3,28
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L213
	li 3,2
	bl SetProperMode
	b .L197
.L213:
	lis 4,.LC43@ha
	lis 5,0x1
	la 4,.LC43@l(4)
	mr 3,28
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L215
	li 3,4
	bl SetProperMode
	b .L197
.L215:
	lis 4,.LC44@ha
	lis 5,0x1
	la 4,.LC44@l(4)
	mr 3,28
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L217
	li 3,64
	bl SetProperMode
	b .L197
.L217:
	lis 4,.LC45@ha
	lis 5,0x1
	la 4,.LC45@l(4)
	mr 3,28
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L219
	li 3,128
	bl SetProperMode
	b .L197
.L219:
	lis 4,.LC46@ha
	lis 5,0x1
	la 4,.LC46@l(4)
	mr 3,28
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L221
	li 3,8
	bl SetProperMode
	b .L197
.L221:
	lis 4,.LC47@ha
	lis 5,0x1
	la 4,.LC47@l(4)
	mr 3,28
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L223
	li 3,16
	bl SetProperMode
	b .L197
.L223:
	lis 30,.LC21@ha
	lis 5,0x1
	mr 3,28
	la 4,.LC21@l(30)
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L225
	addi 0,31,-1
	cmplwi 0,0,1598
	bc 12,1,.L226
	la 30,.LC21@l(30)
	b .L296
.L226:
	lis 9,gi@ha
	li 3,1
	la 31,gi@l(9)
	lis 11,hpos@ha
	lwz 10,160(31)
	lis 9,.LC48@ha
	lhz 30,hpos@l(11)
	la 29,.LC48@l(9)
	mtlr 10
	blrl
	li 4,-999
	bl StrToInt
	mr 6,3
	cmpwi 0,6,-999
	bc 4,2,.L290
	lwz 0,8(31)
	lis 9,mpedCur@ha
	lis 5,.LC31@ha
	lwz 3,mpedCur@l(9)
	la 5,.LC31@l(5)
	mr 6,29
	mr 7,30
	b .L297
.L225:
	lis 4,.LC49@ha
	lis 5,0x1
	la 4,.LC49@l(4)
	mr 3,28
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L234
	cmpwi 0,31,-9999
	bc 4,2,.L235
	lis 9,gi+8@ha
	lis 11,mpedCur@ha
	lwz 0,gi+8@l(9)
	lis 10,testvar@ha
	lis 5,.LC50@ha
	lwz 3,mpedCur@l(11)
	la 5,.LC50@l(5)
	li 4,2
	lwz 6,testvar@l(10)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L197
.L235:
	lis 9,testvar@ha
	stw 31,testvar@l(9)
	b .L197
.L234:
	lis 30,.LC22@ha
	lis 5,0x1
	mr 3,28
	la 4,.LC22@l(30)
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L238
	addi 0,31,-1
	cmplwi 0,0,1278
	bc 12,1,.L239
	la 30,.LC22@l(30)
	b .L296
.L239:
	lis 9,gi@ha
	li 3,1
	la 31,gi@l(9)
	lis 11,vpos@ha
	lwz 10,160(31)
	lis 9,.LC51@ha
	lhz 30,vpos@l(11)
	la 29,.LC51@l(9)
	mtlr 10
	blrl
	li 4,-999
	bl StrToInt
	mr 6,3
	cmpwi 0,6,-999
	bc 4,2,.L290
	lwz 0,8(31)
	lis 9,mpedCur@ha
	lis 5,.LC31@ha
	lwz 3,mpedCur@l(9)
	la 5,.LC31@l(5)
	mr 6,29
	mr 7,30
	b .L297
.L238:
	lis 30,.LC52@ha
	lis 5,0x1
	mr 3,28
	la 4,.LC52@l(30)
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L247
	addi 0,31,-3
	cmplwi 0,0,996
	bc 12,1,.L248
	lis 9,.LC23@ha
	lis 28,mpedCur@ha
	la 30,.LC23@l(9)
	lis 27,.LC20@ha
	lwz 29,mpedCur@l(28)
	mr 5,31
	mr 4,30
	la 3,.LC20@l(27)
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
	lwz 9,mpedCur@l(28)
	mr 4,30
	lwz 3,84(9)
	addi 3,3,188
	bl Info_ValueForKey
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L250
	mr 4,30
	lwz 29,mpedCur@l(26)
	la 3,.LC20@l(27)
	mr 5,31
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
.L250:
	lis 9,.LC24@ha
	mr 5,31
	lwz 29,mpedCur@l(26)
	la 28,.LC24@l(9)
	la 3,.LC20@l(27)
	mr 4,28
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
	lwz 9,mpedCur@l(26)
	mr 4,28
	lwz 3,84(9)
	addi 3,3,188
	bl Info_ValueForKey
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L197
	lwz 29,mpedCur@l(26)
	mr 4,28
	b .L298
.L248:
	lis 9,gi@ha
	li 3,1
	la 31,gi@l(9)
	lis 11,vscale@ha
	lwz 9,160(31)
	la 29,.LC52@l(30)
	lhz 30,vscale@l(11)
	mtlr 9
	blrl
	li 4,-999
	bl StrToInt
	mr 6,3
	cmpwi 0,6,-999
	bc 4,2,.L290
	lwz 0,8(31)
	lis 9,mpedCur@ha
	lis 5,.LC31@ha
	lwz 3,mpedCur@l(9)
	la 5,.LC31@l(5)
	mr 6,29
	mr 7,30
	b .L297
.L247:
	lis 30,.LC23@ha
	lis 5,0x1
	mr 3,28
	la 4,.LC23@l(30)
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L258
	addi 0,31,-3
	cmplwi 0,0,996
	bc 12,1,.L259
	la 30,.LC23@l(30)
	b .L296
.L259:
	lis 9,gi@ha
	li 3,1
	la 31,gi@l(9)
	lis 11,hscale@ha
	lwz 10,160(31)
	lis 9,.LC53@ha
	lhz 30,hscale@l(11)
	la 29,.LC53@l(9)
	mtlr 10
	blrl
	li 4,-999
	bl StrToInt
	mr 6,3
	cmpwi 0,6,-999
	bc 4,2,.L290
	lwz 0,8(31)
	lis 9,mpedCur@ha
	lis 5,.LC31@ha
	lwz 3,mpedCur@l(9)
	la 5,.LC31@l(5)
	mr 6,29
	mr 7,30
	b .L297
.L258:
	lis 30,.LC24@ha
	lis 5,0x1
	mr 3,28
	la 4,.LC24@l(30)
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L267
	addi 0,31,-3
	cmplwi 0,0,996
	bc 12,1,.L268
	la 30,.LC24@l(30)
	b .L296
.L268:
	lis 9,gi@ha
	li 3,1
	la 31,gi@l(9)
	lis 11,vscale@ha
	lwz 10,160(31)
	lis 9,.LC54@ha
	lhz 30,vscale@l(11)
	la 29,.LC54@l(9)
	mtlr 10
	blrl
	li 4,-999
	bl StrToInt
	mr 6,3
	cmpwi 0,6,-999
	bc 4,2,.L290
	lwz 0,8(31)
	lis 9,mpedCur@ha
	lis 5,.LC31@ha
	lwz 3,mpedCur@l(9)
	la 5,.LC31@l(5)
	mr 6,29
	mr 7,30
	b .L297
.L267:
	lis 29,.LC25@ha
	lis 5,0x1
	mr 3,28
	la 4,.LC25@l(29)
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L276
	addi 31,31,-1
	cmplwi 0,31,1
	bc 12,1,.L277
	la 30,.LC25@l(29)
	b .L296
.L277:
	lis 9,gi@ha
	lis 11,curScreen@ha
	la 31,gi@l(9)
	li 3,1
	lhz 9,curScreen@l(11)
	la 29,.LC25@l(29)
	lwz 11,160(31)
	addi 30,9,1
	mtlr 11
	blrl
	li 4,-999
	bl StrToInt
	mr 6,3
	cmpwi 0,6,-999
	bc 4,2,.L290
	lwz 0,8(31)
	lis 9,mpedCur@ha
	lis 5,.LC31@ha
	lwz 3,mpedCur@l(9)
	la 5,.LC31@l(5)
	mr 6,29
	mr 7,30
	b .L297
.L276:
	lis 29,.LC26@ha
	lis 5,0x1
	mr 3,28
	la 4,.LC26@l(29)
	ori 5,5,34463
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L285
	cmplwi 0,31,32766
	bc 12,1,.L286
	la 30,.LC26@l(29)
.L296:
	lis 28,mpedCur@ha
	lis 27,.LC20@ha
	mr 5,31
	lwz 29,mpedCur@l(28)
	mr 4,30
	la 3,.LC20@l(27)
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
	lwz 9,mpedCur@l(28)
	mr 4,30
	lwz 3,84(9)
	addi 3,3,188
	bl Info_ValueForKey
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L197
	lwz 29,mpedCur@l(26)
	mr 4,30
.L298:
	la 3,.LC20@l(27)
	mr 5,31
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
	b .L197
.L286:
	lis 9,gi@ha
	li 3,1
	la 31,gi@l(9)
	lis 11,curMode@ha
	lwz 9,160(31)
	la 29,.LC26@l(29)
	lhz 30,curMode@l(11)
	mtlr 9
	blrl
	li 4,-999
	bl StrToInt
	mr 6,3
	cmpwi 0,6,-999
	bc 4,2,.L290
	lwz 0,8(31)
	lis 9,mpedCur@ha
	lis 5,.LC31@ha
	lwz 3,mpedCur@l(9)
	la 5,.LC31@l(5)
	mr 6,29
	mr 7,30
	b .L297
.L290:
	lwz 0,8(31)
	lis 9,mpedCur@ha
	lis 5,.LC32@ha
	lwz 3,mpedCur@l(9)
	la 5,.LC32@l(5)
	mr 7,29
.L297:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L197
.L285:
	li 3,0
	b .L294
.L197:
	li 3,1
.L294:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 ValidOverlayCommand,.Lfe11-ValidOverlayCommand
	.section	".rodata"
	.align 2
.LC55:
	.string	""
	.globl memset
	.section	".text"
	.align 2
	.globl OverlayUpdate
	.type	 OverlayUpdate,@function
OverlayUpdate:
	stwu 1,-1440(1)
	mflr 0
	stmw 28,1424(1)
	stw 0,1444(1)
	lis 9,.LC55@ha
	mr 29,3
	lbz 0,.LC55@l(9)
	addi 3,1,9
	li 4,0
	li 5,1399
	stb 0,8(1)
	crxor 6,6,6
	bl memset
	lis 10,level@ha
	lwz 6,84(29)
	lis 8,sv_expflags@ha
	lwz 9,level@l(10)
	lis 7,mpedCur@ha
	lwz 10,sv_expflags@l(8)
	addi 9,9,8
	stw 9,4068(6)
	lfs 0,20(10)
	stw 29,mpedCur@l(7)
	fctiwz 13,0
	stfd 13,1416(1)
	lwz 11,1420(1)
	andis. 0,11,8
	bc 12,2,.L300
	lis 9,mpaSightings@ha
	lwz 0,mpaSightings@l(9)
	cmpwi 0,0,0
	bc 4,2,.L301
	bl InitRadar
.L301:
	bl SetCurrentPlayer
.L300:
	lwz 4,84(29)
	lbz 0,4574(4)
	cmpwi 0,0,0
	bc 12,2,.L302
	addi 4,4,4473
	addi 3,1,8
	bl strcpy
.L302:
	lwz 9,84(29)
	lwz 0,4064(9)
	mr 8,9
	andi. 9,0,2
	bc 12,2,.L303
	lis 9,curMode@ha
	lhz 0,curMode@l(9)
	andi. 9,0,1024
	bc 12,2,.L304
	lis 9,mpedCur@ha
	addi 4,1,8
	lwz 3,mpedCur@l(9)
	li 5,1
	bl DrawMatrix
	b .L306
.L304:
	lis 9,mpedCur@ha
	addi 4,1,8
	lwz 3,mpedCur@l(9)
	li 5,0
	bl DrawMatrix
	b .L306
.L303:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1416(1)
	lwz 11,1420(1)
	andis. 0,11,8
	bc 12,2,.L307
	lis 9,curMode@ha
	lhz 0,curMode@l(9)
	andi. 9,0,2
	bc 12,2,.L307
	addi 3,1,8
	bl AppendRadar
	b .L306
.L307:
	lbz 9,4574(8)
	rlwinm 0,9,0,0xff
	cmpwi 0,0,0
	bc 4,2,.L309
	stb 0,4072(8)
	lwz 9,84(29)
	stw 0,4064(9)
	b .L299
.L309:
	addi 0,9,-1
	stb 0,4574(8)
.L306:
	lwz 9,84(29)
	addi 4,1,8
	li 5,400
	lwz 0,4064(9)
	ori 0,0,1
	stw 0,4064(9)
	lwz 3,84(29)
	addi 3,3,4072
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L299
	lwz 3,84(29)
	addi 4,1,8
	li 5,400
	mr 28,4
	addi 3,3,4072
	bl strncpy
	addi 3,1,8
	bl strlen
	lis 29,gi@ha
	addi 9,3,-1
	la 29,gi@l(29)
	li 3,4
	lwz 11,100(29)
	li 0,0
	stbx 0,28,9
	mtlr 11
	blrl
	lwz 9,116(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,92(29)
	lis 9,mpedCur@ha
	li 4,0
	lwz 3,mpedCur@l(9)
	mtlr 0
	blrl
.L299:
	lwz 0,1444(1)
	mtlr 0
	lmw 28,1424(1)
	la 1,1440(1)
	blr
.Lfe12:
	.size	 OverlayUpdate,.Lfe12-OverlayUpdate
	.comm	gametype,4,4
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.section	".sbss","aw",@nobits
	.align 2
testvar:
	.space	4
	.size	 testvar,4
	.lcomm	blip,4225,1
	.lcomm	IsColumn,260,4
	.lcomm	IsRow,260,4
	.align 2
mpedCur:
	.space	4
	.size	 mpedCur,4
	.align 1
curScreen:
	.space	2
	.size	 curScreen,2
	.align 1
hpos:
	.space	2
	.size	 hpos,2
	.align 1
vpos:
	.space	2
	.size	 vpos,2
	.align 1
hscale:
	.space	2
	.size	 hscale,2
	.align 1
vscale:
	.space	2
	.size	 vscale,2
	.align 1
mcFixtures:
	.space	2
	.size	 mcFixtures,2
	.section	".text"
	.align 2
	.globl SetIntKey
	.type	 SetIntKey,@function
SetIntKey:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	mr 28,4
	lis 30,mpedCur@ha
	lis 27,.LC20@ha
	mr 5,28
	lwz 29,mpedCur@l(30)
	mr 4,31
	la 3,.LC20@l(27)
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
	lwz 9,mpedCur@l(30)
	mr 4,31
	lwz 3,84(9)
	addi 3,3,188
	bl Info_ValueForKey
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L140
	lwz 29,mpedCur@l(30)
	mr 4,31
	la 3,.LC20@l(27)
	mr 5,28
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl StuffCmd
.L140:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 SetIntKey,.Lfe13-SetIntKey
	.align 2
	.globl ReadShortKey
	.type	 ReadShortKey,@function
ReadShortKey:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,mpedCur@ha
	mr 29,4
	lwz 11,mpedCur@l(9)
	mr 4,3
	mr 31,6
	mr 30,5
	lwz 3,84(11)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,31
	bl StrToInt
	cmpw 0,3,29
	bc 12,0,.L143
	cmpw 0,3,30
	bc 4,1,.L142
.L143:
	mr 3,31
	b .L312
.L142:
	extsh 3,3
.L312:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 ReadShortKey,.Lfe14-ReadShortKey
	.align 2
	.globl PrintProperMessage
	.type	 PrintProperMessage,@function
PrintProperMessage:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 29,3
	la 31,gi@l(9)
	li 3,1
	lwz 9,160(31)
	mr 30,4
	mtlr 9
	blrl
	li 4,-999
	bl StrToInt
	mr 6,3
	cmpwi 0,6,-999
	bc 4,2,.L192
	lwz 0,8(31)
	lis 9,mpedCur@ha
	lis 5,.LC31@ha
	lwz 3,mpedCur@l(9)
	la 5,.LC31@l(5)
	mr 6,29
	mr 7,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L193
.L192:
	lwz 0,8(31)
	lis 9,mpedCur@ha
	lis 5,.LC32@ha
	lwz 3,mpedCur@l(9)
	la 5,.LC32@l(5)
	mr 7,29
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L193:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 PrintProperMessage,.Lfe15-PrintProperMessage
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
