	.file	"Kots.cpp"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"/kots/kotsdata"
	.align 2
.LC1:
	.string	"/"
	.align 2
.LC2:
	.string	"Saving all current players."
	.align 2
.LC3:
	.string	"User exists - "
	.align 2
.LC4:
	.string	"Loading - "
	.section	".text"
	.align 2
	.globl AddUser__8CKotsAppPCcT1Ri
	.type	 AddUser__8CKotsAppPCcT1Ri,@function
AddUser__8CKotsAppPCcT1Ri:
	stwu 1,-320(1)
	mflr 0
	stmw 24,288(1)
	stw 0,324(1)
	mr 24,6
	li 30,0
	mr 28,3
	mr 27,4
	stw 30,0(24)
	mr 25,5
	addi 29,1,264
	b .L52
.L54:
	mr 4,30
	mr 3,28
	bl __vc__10CNPtrArrayi
	lwz 31,0(3)
	mr 4,27
	addi 3,31,8
	bl strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L56
	addi 30,30,1
.L52:
	mr 3,28
	bl GetSize__C10CNPtrArray
	cmpw 0,30,3
	bc 12,0,.L54
	li 31,0
.L56:
	li 3,793
	bl __builtin_new
	mr 30,3
	mr 3,29
	bl time
	mr 3,29
	bl localtime
	cmpwi 0,31,0
	mr 29,3
	bc 4,2,.L59
	li 5,793
	li 4,0
	mr 3,30
	addi 31,28,271
	bl memset
	addi 26,28,16
	mr 3,29
	bl asctime
	mr 4,3
	addi 3,1,8
	bl strcpy
	lis 4,.LC4@ha
	addi 3,1,8
	la 4,.LC4@l(4)
	bl strcat
	mr 4,27
	addi 3,1,8
	bl strcat
	addi 3,1,8
	bl KOTSMessage__FPCc
	mr 3,31
	bl strlen
	srawi 0,3,31
	mr 5,27
	xor 4,0,3
	subf 4,4,0
	mr 3,30
	srawi 4,4,31
	andc 0,26,4
	and 4,31,4
	or 4,4,0
	bl Load__5CUserPCcT1
	cmpwi 0,3,0
	bc 12,2,.L60
	mr 4,27
	addi 3,30,8
	bl strcpy
	mr 4,25
	addi 3,30,78
	bl strcpy
	mr 3,30
	bl Respawn__5CUser
	mr 3,31
	bl strlen
	srawi 0,3,31
	li 5,1
	xor 4,0,3
	subf 4,4,0
	mr 3,30
	srawi 4,4,31
	andc 0,26,4
	and 4,31,4
	or 4,4,0
	bl Save__5CUserPCcb
	b .L69
.L59:
	li 5,793
	mr 4,31
	mr 3,30
	crxor 6,6,6
	bl memcpy
	mr 3,29
	bl asctime
	mr 4,3
	addi 3,1,8
	bl strcpy
	lis 4,.LC3@ha
	addi 3,1,8
	la 4,.LC3@l(4)
	bl strcat
	mr 4,27
	addi 3,1,8
	bl strcat
	addi 3,1,8
	bl KOTSMessage__FPCc
.L60:
	mr 4,25
	mr 3,30
	bl CheckPass__5CUserPCc
	cmpwi 0,3,0
	bc 12,2,.L66
.L69:
	mr 3,28
	mr 4,30
	bl Add__10CNPtrArrayPv
	mr 3,30
	b .L67
.L66:
	li 0,5
	mr 3,30
	stw 0,0(24)
	bl __builtin_delete
	li 3,0
.L67:
	lwz 0,324(1)
	mtlr 0
	lmw 24,288(1)
	la 1,320(1)
	blr
.Lfe1:
	.size	 AddUser__8CKotsAppPCcT1Ri,.Lfe1-AddUser__8CKotsAppPCcT1Ri
	.lcomm	theApp,544,4
	.globl theApp
	.align 2
	.type	 __static_initialization_and_destruction_0,@function
__static_initialization_and_destruction_0:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	li 0,0
	ori 0,0,65535
	cmpw 0,4,0
	bc 4,2,.L87
	cmpwi 0,3,0
	bc 12,2,.L88
	lis 29,theApp@ha
	la 29,theApp@l(29)
	mr 3,29
	addi 28,29,16
	bl __10CNPtrArray
	addi 3,29,528
	bl __10CNPtrArray
	li 4,255
	mr 3,28
	bl getcwd
	lis 4,.LC0@ha
	mr 3,28
	la 4,.LC0@l(4)
	bl strcat
	li 4,438
	mr 3,28
	bl mkdir
	lis 4,.LC1@ha
	mr 3,28
	la 4,.LC1@l(4)
	bl strcat
	addi 3,29,271
	li 4,0
	li 5,255
	bl memset
	b .L87
.L88:
	lis 29,theApp@ha
	la 29,theApp@l(29)
	mr 3,29
	bl Cleanup__8CKotsApp
	addi 3,29,528
	li 4,2
	bl _._10CNPtrArray
	mr 3,29
	li 4,2
	bl _._10CNPtrArray
.L87:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 __static_initialization_and_destruction_0,.Lfe2-__static_initialization_and_destruction_0
	.align 2
	.globl __8CKotsApp
	.type	 __8CKotsApp,@function
__8CKotsApp:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	addi 29,28,16
	bl __10CNPtrArray
	addi 3,28,528
	bl __10CNPtrArray
	li 4,255
	mr 3,29
	bl getcwd
	lis 4,.LC0@ha
	mr 3,29
	la 4,.LC0@l(4)
	bl strcat
	li 4,438
	mr 3,29
	bl mkdir
	lis 4,.LC1@ha
	mr 3,29
	la 4,.LC1@l(4)
	bl strcat
	addi 3,28,271
	li 4,0
	li 5,255
	bl memset
	mr 3,28
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 __8CKotsApp,.Lfe3-__8CKotsApp
	.align 2
	.globl _._8CKotsApp
	.type	 _._8CKotsApp,@function
_._8CKotsApp:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	mr 29,4
	bl Cleanup__8CKotsApp
	addi 3,31,528
	li 4,2
	bl _._10CNPtrArray
	mr 3,31
	li 4,2
	bl _._10CNPtrArray
	andi. 0,29,1
	bc 12,2,.L12
	mr 3,31
	bl __builtin_delete
.L12:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 _._8CKotsApp,.Lfe4-_._8CKotsApp
	.align 2
	.globl GetDataDir__8CKotsApp
	.type	 GetDataDir__8CKotsApp,@function
GetDataDir__8CKotsApp:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,3
	addi 31,30,271
	mr 3,31
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L14
	mr 3,31
	b .L90
.L14:
	addi 3,30,16
.L90:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 GetDataDir__8CKotsApp,.Lfe5-GetDataDir__8CKotsApp
	.align 2
	.globl SetDataDir__8CKotsAppPCc
	.type	 SetDataDir__8CKotsAppPCc,@function
SetDataDir__8CKotsAppPCc:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,4
	mr 30,3
	mr 3,31
	bl strlen
	cmplwi 0,3,2
	bc 12,1,.L16
	addi 3,30,271
	li 4,0
	li 5,255
	bl memset
	b .L15
.L16:
	addi 30,30,271
	mr 4,31
	mr 3,30
	bl strcpy
	mr 3,31
	bl strlen
	add 3,3,31
	lbz 0,-1(3)
	cmpwi 0,0,47
	bc 12,2,.L17
	lis 4,.LC1@ha
	mr 3,30
	la 4,.LC1@l(4)
	bl strcat
.L17:
	mr 3,30
	li 4,438
	bl mkdir
.L15:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 SetDataDir__8CKotsAppPCc,.Lfe6-SetDataDir__8CKotsAppPCc
	.align 2
	.globl Cleanup__8CKotsApp
	.type	 Cleanup__8CKotsApp,@function
Cleanup__8CKotsApp:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	li 30,0
	addi 28,31,271
	addi 27,31,16
	b .L19
.L22:
	mr 4,30
	mr 3,31
	bl __vc__10CNPtrArrayi
	addi 30,30,1
	lwz 29,0(3)
	mr 3,28
	bl strlen
	srawi 0,3,31
	xor 4,0,3
	subf 4,4,0
	mr 3,29
	srawi 4,4,31
	andc 0,27,4
	and 4,28,4
	or 4,4,0
	bl GameSave__5CUserPCc
	mr 3,29
	bl __builtin_delete
.L19:
	mr 3,31
	bl GetSize__C10CNPtrArray
	cmpw 0,30,3
	bc 12,0,.L22
	mr 3,31
	li 30,0
	bl RemoveAll__10CNPtrArray
	addi 29,31,528
	b .L26
.L29:
	mr 4,30
	mr 3,29
	bl __vc__10CNPtrArrayi
	addi 30,30,1
	lwz 3,0(3)
	bl __builtin_delete
.L26:
	mr 3,29
	bl GetSize__C10CNPtrArray
	cmpw 0,30,3
	bc 12,0,.L29
	mr 3,29
	bl RemoveAll__10CNPtrArray
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 Cleanup__8CKotsApp,.Lfe7-Cleanup__8CKotsApp
	.align 2
	.globl SaveAll__8CKotsApp
	.type	 SaveAll__8CKotsApp,@function
SaveAll__8CKotsApp:
	stwu 1,-304(1)
	mflr 0
	stmw 27,284(1)
	stw 0,308(1)
	addi 29,1,264
	mr 30,3
	mr 3,29
	addi 28,30,271
	bl time
	addi 27,30,16
	li 31,0
	mr 3,29
	bl localtime
	bl asctime
	mr 4,3
	addi 3,1,8
	bl strcpy
	lis 4,.LC2@ha
	addi 3,1,8
	la 4,.LC2@l(4)
	bl strcat
	addi 3,1,8
	bl KOTSMessage__FPCc
	b .L32
.L35:
	mr 4,31
	mr 3,30
	bl __vc__10CNPtrArrayi
	addi 31,31,1
	lwz 29,0(3)
	mr 3,28
	bl strlen
	srawi 0,3,31
	xor 4,0,3
	subf 4,4,0
	mr 3,29
	srawi 4,4,31
	andc 0,27,4
	and 4,28,4
	or 4,4,0
	bl GameSave__5CUserPCc
.L32:
	mr 3,30
	bl GetSize__C10CNPtrArray
	cmpw 0,31,3
	bc 12,0,.L35
	li 31,0
	addi 29,30,528
	b .L39
.L42:
	mr 4,31
	mr 3,29
	bl __vc__10CNPtrArrayi
	addi 31,31,1
	lwz 3,0(3)
	bl __builtin_delete
.L39:
	mr 3,29
	bl GetSize__C10CNPtrArray
	cmpw 0,31,3
	bc 12,0,.L42
	mr 3,29
	bl RemoveAll__10CNPtrArray
	lwz 0,308(1)
	mtlr 0
	lmw 27,284(1)
	la 1,304(1)
	blr
.Lfe8:
	.size	 SaveAll__8CKotsApp,.Lfe8-SaveAll__8CKotsApp
	.align 2
	.globl FindUser__8CKotsAppPCc
	.type	 FindUser__8CKotsAppPCc,@function
FindUser__8CKotsAppPCc:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	mr 28,4
	li 30,0
	b .L45
.L48:
	mr 4,30
	mr 3,29
	bl __vc__10CNPtrArrayi
	lwz 31,0(3)
	mr 4,28
	addi 3,31,8
	bl strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L47
	mr 3,31
	b .L91
.L47:
	addi 30,30,1
.L45:
	mr 3,29
	bl GetSize__C10CNPtrArray
	cmpw 0,30,3
	bc 12,0,.L48
	li 3,0
.L91:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 FindUser__8CKotsAppPCc,.Lfe9-FindUser__8CKotsAppPCc
	.align 2
	.globl DelUser__8CKotsAppP5CUserb
	.type	 DelUser__8CKotsAppP5CUserb,@function
DelUser__8CKotsAppP5CUserb:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	mr 27,5
	li 28,0
	li 29,0
	b .L71
.L73:
	addi 29,29,1
.L71:
	mr 3,31
	bl GetSize__C10CNPtrArray
	cmpw 0,29,3
	bc 4,0,.L72
	mr 3,31
	mr 4,29
	bl __vc__10CNPtrArrayi
	lwz 0,0(3)
	cmpw 0,30,0
	bc 4,2,.L73
	mr 4,29
	mr 3,31
	li 5,1
	li 28,1
	bl RemoveAt__10CNPtrArrayii
.L72:
	cmpwi 0,27,0
	bc 12,2,.L77
	addi 29,31,271
	mr 3,29
	bl strlen
	srawi 9,3,31
	addi 4,31,16
	xor 0,9,3
	subf 0,0,9
	mr 3,30
	srawi 0,0,31
	andc 4,4,0
	and 29,29,0
	or 4,29,4
	bl GameSave__5CUserPCc
.L77:
	mr 3,30
	bl __builtin_delete
	mr 3,28
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 DelUser__8CKotsAppP5CUserb,.Lfe10-DelUser__8CKotsAppP5CUserb
	.align 2
	.type	 _GLOBAL_.I.AddUser__8CKotsAppPCcT1Ri,@function
_GLOBAL_.I.AddUser__8CKotsAppPCcT1Ri:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,0
	li 3,1
	ori 4,4,65535
	bl __static_initialization_and_destruction_0
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 _GLOBAL_.I.AddUser__8CKotsAppPCcT1Ri,.Lfe11-_GLOBAL_.I.AddUser__8CKotsAppPCcT1Ri
.section	.ctors,"aw"
	.long	 _GLOBAL_.I.AddUser__8CKotsAppPCcT1Ri
	.section	".text"
	.align 2
	.type	 _GLOBAL_.D.AddUser__8CKotsAppPCcT1Ri,@function
_GLOBAL_.D.AddUser__8CKotsAppPCcT1Ri:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,0
	li 3,0
	ori 4,4,65535
	bl __static_initialization_and_destruction_0
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe12:
	.size	 _GLOBAL_.D.AddUser__8CKotsAppPCcT1Ri,.Lfe12-_GLOBAL_.D.AddUser__8CKotsAppPCcT1Ri
.section	.dtors,"aw"
	.long	 _GLOBAL_.D.AddUser__8CKotsAppPCcT1Ri
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
