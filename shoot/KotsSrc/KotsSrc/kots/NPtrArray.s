	.file	"NPtrArray.cpp"
gcc2_compiled.:
	.section	".text"
	.align 2
	.globl SetSize__10CNPtrArrayii
	.type	 SetSize__10CNPtrArrayii,@function
SetSize__10CNPtrArrayii:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	cmpwi 0,5,-1
	mr 31,3
	mr 30,4
	bc 12,2,.L11
	stw 5,12(31)
.L11:
	cmpwi 0,30,0
	bc 4,2,.L12
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L14
	bl __builtin_vec_delete
.L14:
	stw 30,4(31)
	stw 30,0(31)
	stw 30,8(31)
	b .L15
.L12:
	lwz 0,0(31)
	cmpwi 0,0,0
	bc 4,2,.L16
	slwi 29,30,2
	mr 3,29
	bl __builtin_vec_new
	mr 0,3
	mr 5,29
	stw 0,0(31)
	li 4,0
	bl memset
	stw 30,4(31)
	stw 30,8(31)
	b .L15
.L16:
	lwz 10,8(31)
	cmpw 0,30,10
	bc 12,1,.L18
	lwz 3,4(31)
	cmpw 0,30,3
	bc 4,1,.L28
	subf 5,3,30
	li 4,0
	slwi 3,3,2
	slwi 5,5,2
	add 3,0,3
	bl memset
	b .L28
.L18:
	lwz 11,12(31)
	cmpwi 0,11,0
	bc 4,2,.L21
	lwz 9,4(31)
	srawi 0,9,31
	srwi 0,0,29
	add 9,9,0
	srawi 11,9,3
	cmpwi 7,11,3
	mfcr 0
	rlwinm 0,0,30,1
	neg 0,0
	nor 9,0,0
	and 0,11,0
	rlwinm 9,9,0,29,29
	or 11,0,9
	cmpwi 7,11,1025
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,11,0
	rlwinm 9,9,0,21,21
	or 11,0,9
.L21:
	add 9,10,11
	cmpw 7,30,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,30,0
	or 28,0,9
	slwi 3,28,2
	bl __builtin_vec_new
	lwz 5,4(31)
	mr 29,3
	lwz 4,0(31)
	slwi 5,5,2
	crxor 6,6,6
	bl memcpy
	lwz 3,4(31)
	li 4,0
	subf 5,3,30
	slwi 3,3,2
	slwi 5,5,2
	add 3,29,3
	bl memset
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L27
	bl __builtin_vec_delete
.L27:
	stw 28,8(31)
	stw 29,0(31)
.L28:
	stw 30,4(31)
.L15:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 SetSize__10CNPtrArrayii,.Lfe1-SetSize__10CNPtrArrayii
	.align 2
	.globl InsertAt__10CNPtrArrayiP10CNPtrArray
	.type	 InsertAt__10CNPtrArrayiP10CNPtrArray,@function
InsertAt__10CNPtrArrayiP10CNPtrArray:
	stwu 1,-48(1)
	mflr 0
	stmw 23,12(1)
	stw 0,52(1)
	mr 26,5
	mr 28,3
	mr 27,4
	mr 3,26
	bl GetSize__C10CNPtrArray
	cmpwi 0,3,0
	bc 4,1,.L48
	li 4,0
	mr 3,26
	bl GetAt__C10CNPtrArrayi
	mr 23,27
	mr 24,3
	mr 3,26
	bl GetSize__C10CNPtrArray
	lwz 30,4(28)
	mr 25,3
	mr 31,25
	cmpw 0,27,30
	bc 12,0,.L49
	add 4,27,31
	mr 3,28
	li 5,-1
	bl SetSize__10CNPtrArrayii
	b .L50
.L49:
	mr 3,28
	li 5,-1
	add 4,30,31
	slwi 29,27,2
	bl SetSize__10CNPtrArrayii
	lwz 0,0(28)
	add 3,27,31
	subf 5,27,30
	slwi 3,3,2
	slwi 5,5,2
	add 4,0,29
	add 3,0,3
	bl memmove
	lwz 3,0(28)
	slwi 5,31,2
	li 4,0
	add 3,3,29
	bl memset
.L50:
	cmpwi 0,25,0
	addi 31,25,-1
	bc 12,2,.L55
	slwi 11,23,2
.L53:
	lwz 9,0(28)
	cmpwi 0,31,0
	addi 31,31,-1
	stwx 24,11,9
	addi 11,11,4
	bc 4,2,.L53
.L55:
	li 31,0
	b .L56
.L59:
	mr 4,31
	mr 3,26
	bl GetAt__C10CNPtrArrayi
	mr 5,3
	add 4,27,31
	mr 3,28
	addi 31,31,1
	bl SetAt__10CNPtrArrayiPv
.L56:
	mr 3,26
	bl GetSize__C10CNPtrArray
	cmpw 0,31,3
	bc 12,0,.L59
.L48:
	lwz 0,52(1)
	mtlr 0
	lmw 23,12(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 InsertAt__10CNPtrArrayiP10CNPtrArray,.Lfe2-InsertAt__10CNPtrArrayiP10CNPtrArray
	.align 2
	.globl __10CNPtrArray
	.type	 __10CNPtrArray,@function
__10CNPtrArray:
	mr 9,3
	li 0,0
	stw 0,4(9)
	stw 0,0(9)
	stw 0,12(9)
	stw 0,8(9)
	blr
.Lfe3:
	.size	 __10CNPtrArray,.Lfe3-__10CNPtrArray
	.align 2
	.globl _._10CNPtrArray
	.type	 _._10CNPtrArray,@function
_._10CNPtrArray:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L7
	bl __builtin_vec_delete
.L7:
	andi. 0,30,1
	bc 12,2,.L9
	mr 3,31
	bl __builtin_delete
.L9:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 _._10CNPtrArray,.Lfe4-_._10CNPtrArray
	.align 2
	.globl Append__10CNPtrArrayRC10CNPtrArray
	.type	 Append__10CNPtrArrayRC10CNPtrArray,@function
Append__10CNPtrArrayRC10CNPtrArray:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 28,4
	mr 29,3
	lwz 27,4(29)
	li 5,-1
	lwz 4,4(28)
	add 4,27,4
	bl SetSize__10CNPtrArrayii
	lwz 0,0(29)
	slwi 3,27,2
	lwz 5,4(28)
	lwz 4,0(28)
	add 3,3,0
	slwi 5,5,2
	crxor 6,6,6
	bl memcpy
	mr 3,27
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Append__10CNPtrArrayRC10CNPtrArray,.Lfe5-Append__10CNPtrArrayRC10CNPtrArray
	.align 2
	.globl Copy__10CNPtrArrayRC10CNPtrArray
	.type	 Copy__10CNPtrArrayRC10CNPtrArray,@function
Copy__10CNPtrArrayRC10CNPtrArray:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,4
	mr 28,3
	lwz 4,4(29)
	li 5,-1
	bl SetSize__10CNPtrArrayii
	lwz 5,4(29)
	lwz 3,0(28)
	lwz 4,0(29)
	slwi 5,5,2
	crxor 6,6,6
	bl memcpy
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 Copy__10CNPtrArrayRC10CNPtrArray,.Lfe6-Copy__10CNPtrArrayRC10CNPtrArray
	.align 2
	.globl FreeExtra__10CNPtrArray
	.type	 FreeExtra__10CNPtrArray,@function
FreeExtra__10CNPtrArray:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 3,4(31)
	lwz 0,8(31)
	cmpw 0,3,0
	bc 12,2,.L32
	cmpwi 0,3,0
	li 30,0
	bc 12,2,.L33
	slwi 3,3,2
	bl __builtin_vec_new
	lwz 5,4(31)
	mr 30,3
	lwz 4,0(31)
	slwi 5,5,2
	crxor 6,6,6
	bl memcpy
.L33:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L35
	bl __builtin_vec_delete
.L35:
	lwz 0,4(31)
	stw 30,0(31)
	stw 0,8(31)
.L32:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 FreeExtra__10CNPtrArray,.Lfe7-FreeExtra__10CNPtrArray
	.align 2
	.globl SetAtGrow__10CNPtrArrayiPv
	.type	 SetAtGrow__10CNPtrArrayiPv,@function
SetAtGrow__10CNPtrArrayiPv:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 0,4(31)
	mr 29,5
	cmpw 0,30,0
	bc 12,0,.L37
	addi 4,30,1
	li 5,-1
	bl SetSize__10CNPtrArrayii
.L37:
	lwz 11,0(31)
	slwi 9,30,2
	stwx 29,9,11
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 SetAtGrow__10CNPtrArrayiPv,.Lfe8-SetAtGrow__10CNPtrArrayiPv
	.align 2
	.globl InsertAt__10CNPtrArrayiPvi
	.type	 InsertAt__10CNPtrArrayiPvi,@function
InsertAt__10CNPtrArrayiPvi:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 28,3
	mr 27,4
	lwz 30,4(28)
	mr 26,5
	mr 31,6
	cmpw 0,27,30
	bc 12,0,.L39
	add 4,27,31
	li 5,-1
	bl SetSize__10CNPtrArrayii
	b .L40
.L39:
	mr 3,28
	li 5,-1
	add 4,30,31
	slwi 29,27,2
	bl SetSize__10CNPtrArrayii
	lwz 0,0(28)
	add 3,27,31
	subf 5,27,30
	slwi 3,3,2
	slwi 5,5,2
	add 4,0,29
	add 3,0,3
	bl memmove
	lwz 3,0(28)
	li 4,0
	slwi 5,31,2
	add 3,3,29
	bl memset
.L40:
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L42
	slwi 3,27,2
.L43:
	lwz 9,0(28)
	cmpwi 0,31,0
	addi 31,31,-1
	stwx 26,3,9
	addi 3,3,4
	bc 4,2,.L43
.L42:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 InsertAt__10CNPtrArrayiPvi,.Lfe9-InsertAt__10CNPtrArrayiPvi
	.align 2
	.globl RemoveAt__10CNPtrArrayii
	.type	 RemoveAt__10CNPtrArrayii,@function
RemoveAt__10CNPtrArrayii:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,5
	mr 3,4
	lwz 0,4(31)
	add 4,3,30
	subf. 5,4,0
	bc 12,2,.L46
	lwz 0,0(31)
	slwi 3,3,2
	slwi 4,4,2
	slwi 5,5,2
	add 4,0,4
	add 3,0,3
	bl memmove
.L46:
	lwz 0,4(31)
	subf 0,30,0
	stw 0,4(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 RemoveAt__10CNPtrArrayii,.Lfe10-RemoveAt__10CNPtrArrayii
	.align 2
	.globl GetSize__C10CNPtrArray
	.type	 GetSize__C10CNPtrArray,@function
GetSize__C10CNPtrArray:
	lwz 3,4(3)
	blr
.Lfe11:
	.size	 GetSize__C10CNPtrArray,.Lfe11-GetSize__C10CNPtrArray
	.align 2
	.globl GetUpperBound__C10CNPtrArray
	.type	 GetUpperBound__C10CNPtrArray,@function
GetUpperBound__C10CNPtrArray:
	lwz 3,4(3)
	addi 3,3,-1
	blr
.Lfe12:
	.size	 GetUpperBound__C10CNPtrArray,.Lfe12-GetUpperBound__C10CNPtrArray
	.align 2
	.globl RemoveAll__10CNPtrArray
	.type	 RemoveAll__10CNPtrArray,@function
RemoveAll__10CNPtrArray:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,0
	li 5,-1
	bl SetSize__10CNPtrArrayii
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 RemoveAll__10CNPtrArray,.Lfe13-RemoveAll__10CNPtrArray
	.align 2
	.globl GetAt__C10CNPtrArrayi
	.type	 GetAt__C10CNPtrArrayi,@function
GetAt__C10CNPtrArrayi:
	lwz 9,0(3)
	slwi 4,4,2
	lwzx 3,4,9
	blr
.Lfe14:
	.size	 GetAt__C10CNPtrArrayi,.Lfe14-GetAt__C10CNPtrArrayi
	.align 2
	.globl SetAt__10CNPtrArrayiPv
	.type	 SetAt__10CNPtrArrayiPv,@function
SetAt__10CNPtrArrayiPv:
	lwz 9,0(3)
	slwi 4,4,2
	stwx 5,4,9
	blr
.Lfe15:
	.size	 SetAt__10CNPtrArrayiPv,.Lfe15-SetAt__10CNPtrArrayiPv
	.align 2
	.globl ElementAt__10CNPtrArrayi
	.type	 ElementAt__10CNPtrArrayi,@function
ElementAt__10CNPtrArrayi:
	lwz 3,0(3)
	slwi 4,4,2
	add 3,3,4
	blr
.Lfe16:
	.size	 ElementAt__10CNPtrArrayi,.Lfe16-ElementAt__10CNPtrArrayi
	.align 2
	.globl GetData__C10CNPtrArray
	.type	 GetData__C10CNPtrArray,@function
GetData__C10CNPtrArray:
	lwz 3,0(3)
	blr
.Lfe17:
	.size	 GetData__C10CNPtrArray,.Lfe17-GetData__C10CNPtrArray
	.align 2
	.globl GetData__10CNPtrArray
	.type	 GetData__10CNPtrArray,@function
GetData__10CNPtrArray:
	lwz 3,0(3)
	blr
.Lfe18:
	.size	 GetData__10CNPtrArray,.Lfe18-GetData__10CNPtrArray
	.align 2
	.globl Add__10CNPtrArrayPv
	.type	 Add__10CNPtrArrayPv,@function
Add__10CNPtrArrayPv:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 29,3
	mr 27,4
	lwz 28,4(29)
	li 5,-1
	addi 4,28,1
	bl SetSize__10CNPtrArrayii
	lwz 11,0(29)
	slwi 9,28,2
	mr 3,28
	stwx 27,9,11
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 Add__10CNPtrArrayPv,.Lfe19-Add__10CNPtrArrayPv
	.align 2
	.globl __vc__C10CNPtrArrayi
	.type	 __vc__C10CNPtrArrayi,@function
__vc__C10CNPtrArrayi:
	lwz 9,0(3)
	slwi 4,4,2
	lwzx 3,4,9
	blr
.Lfe20:
	.size	 __vc__C10CNPtrArrayi,.Lfe20-__vc__C10CNPtrArrayi
	.align 2
	.globl __vc__10CNPtrArrayi
	.type	 __vc__10CNPtrArrayi,@function
__vc__10CNPtrArrayi:
	lwz 3,0(3)
	slwi 4,4,2
	add 3,3,4
	blr
.Lfe21:
	.size	 __vc__10CNPtrArrayi,.Lfe21-__vc__10CNPtrArrayi
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
