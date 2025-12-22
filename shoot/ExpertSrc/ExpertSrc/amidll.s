	.file	"amidll.c"
gcc2_compiled.:
	.globl DLL_ExportSymbols
	.section	".data"
	.align 2
	.type	 DLL_ExportSymbols,@object
DLL_ExportSymbols:
	.long dllFindResource
	.long .LC0
	.long dllLoadResource
	.long .LC1
	.long dllFreeResource
	.long .LC2
	.long GetGameAPI
	.long .LC3
	.long SetExeName
	.long .LC4
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC4:
	.string	"SetExeName"
	.align 2
.LC3:
	.string	"GetGameAPI"
	.align 2
.LC2:
	.string	"dllFreeResource"
	.align 2
.LC1:
	.string	"dllLoadResource"
	.align 2
.LC0:
	.string	"dllFindResource"
	.size	 DLL_ExportSymbols,48
	.globl DLL_ImportSymbols
	.section	".data"
	.align 2
	.type	 DLL_ImportSymbols,@object
DLL_ImportSymbols:
	.long 0
	.long 0
	.long 0
	.long 0
	.size	 DLL_ImportSymbols,16
	.comm	gametype,4,4
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.section	".text"
	.align 2
	.globl DLL_Init
	.type	 DLL_Init,@function
DLL_Init:
	stwu 1,-160(1)
	lis 9,DOSBase@ha
	lis 11,PowerPCBase@ha
	lwz 10,DOSBase@l(9)
	li 0,0
	addi 4,1,8
	li 9,-492
	lwz 3,PowerPCBase@l(11)
	stw 9,12(1)
	stw 10,8(1)
	stw 0,16(1)
	stw 10,84(1)
	stw 0,20(1)
	stw 0,24(1)
	lwz 0,-298(3)
	
	stwu	1,-32(1)
	mflr	12
	stw	12,28(1)
	mfcr	12
	stw	12,24(1)
	mtlr	0
	blrl
	lwz	12,24(1)
	mtcr	12
	lwz	12,28(1)
	mtlr	12
	la	1,32(1)
	
	lwz 9,28(1)
	cmpwi 0,9,0
	bc 12,2,.L11
	lwz 0,60(9)
	li 3,1
	lis 9,SegList@ha
	stw 0,SegList@l(9)
	b .L13
.L11:
	li 3,0
.L13:
	la 1,160(1)
	blr
.Lfe1:
	.size	 DLL_Init,.Lfe1-DLL_Init
	.align 2
	.globl DLL_DeInit
	.type	 DLL_DeInit,@function
DLL_DeInit:
	blr
.Lfe2:
	.size	 DLL_DeInit,.Lfe2-DLL_DeInit
	.align 2
	.globl SetExeName
	.type	 SetExeName,@function
SetExeName:
	lis 9,exe_found@ha
	li 0,1
	stw 0,exe_found@l(9)
	blr
.Lfe3:
	.size	 SetExeName,.Lfe3-SetExeName
	.align 2
	.globl dllFindResource
	.type	 dllFindResource,@function
dllFindResource:
	li 3,0
	blr
.Lfe4:
	.size	 dllFindResource,.Lfe4-dllFindResource
	.align 2
	.globl dllLoadResource
	.type	 dllLoadResource,@function
dllLoadResource:
	li 3,0
	blr
.Lfe5:
	.size	 dllLoadResource,.Lfe5-dllLoadResource
	.align 2
	.globl dllFreeResource
	.type	 dllFreeResource,@function
dllFreeResource:
	blr
.Lfe6:
	.size	 dllFreeResource,.Lfe6-dllFreeResource
	.comm	SegList,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
