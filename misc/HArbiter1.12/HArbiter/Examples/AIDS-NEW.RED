;Piotr Owsiak IIc
.WA91
plus equ 7
kill:	dat	$0	$0
start:	spl	spl1
	spl	$2	
first:	jmp	$0	<-500
	jmp	$0	<-626
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl1:	spl	spl2
	mov	kill	kill-4
	add     #-4     $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl2:	spl	spl3
	mov	kill	kill-50
	add     #4	$-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl3:	spl	spl4
	mov	kill	kill-53
	add     #-4     $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl4:	spl	spl5
	mov	kill	kill-100
	add     #4      $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl5:	spl	spl6
	mov	kill	kill-103
	add     #-4     $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl6:	spl	spl7
	mov	kill	kill-150
	add     #4	$-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl7:	spl	spl8
	mov	kill	kill-153
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl8:	spl	spl9
	mov	kill	kill-200
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl9:	spl	spl10
	mov	kill	kill-203
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl10:	spl	spl11
	mov	kill	kill-250
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl11:	spl	spl12
	mov	kill	kill-253
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl12:	spl	spl13
	mov	kill	kill-300
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl13:	spl	spl14
	mov	kill	kill-303
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl14:	spl	spl15
	mov	kill	kill-350
	add	#4	kill
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl15:	spl	spl16
	mov	kill	kill-353
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl16:	spl	spl17
	mov	kill	kill-400
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl17:	spl	spl18
	mov	kill	kill-403
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl18:	spl	spl19
	mov	kill	kill-450
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl19:	spl	spl20
	mov	kill	kill-453
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl20:	spl	spl21
	mov	kill	kill-500
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl21:	spl	spl22
	mov	kill	kill-503
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl22:	spl	spl23
	mov	kill	kill-550
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl23:	spl	spl24
	mov	kill	kill-553
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl24:	spl	spl25
	mov	kill	kill-600
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl25:	spl	spl26
	mov	kill	kill-603
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl26:  spl	spl27
	mov	kill	kill-650
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl27:	spl	spl28
	mov	kill	kill-653
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl28:	spl	spl29
	mov	kill	kill-700
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl29:	spl	spl30
	mov	kill	kill-703
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl30:	spl	spl31
	mov	kill	kill-750
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl31:	spl	spl32
	mov	kill	kill-753
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl32:	spl	spl33
	mov	kill	kill-800
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl33:	spl	spl34
	mov	kill	kill-803
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl34:	spl	spl35
	mov	kill	kill-850
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl35:	spl	spl36
	mov	kill	kill-853
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl36:	spl	spl37
	mov	kill	kill-900
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl37:	spl	spl38
	mov	kill	kill-903
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl38:	spl	spl39
	mov	kill	kill-950
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl39:	spl	spl40
	mov	kill	kill-953
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl40:	spl	spl41
	mov	kill	kill-1000
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl41:	spl	spl42
	mov	kill	kill-1003
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl42:	spl	spl43
	mov	kill	kill-1050
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl43:	spl	spl44
	mov	kill	kill-1053
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl44:	spl	spl45
	mov	kill	kill-1100
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl45:	spl	spl46
	mov	kill	kill-1103
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl46:	spl	spl47
	mov	kill	kill-1150
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl47:	spl	spl48
	mov	kill	kill-1153
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl48:	spl	spl49
	mov	kill	kill-1200
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl49:	spl	spl50
	mov	kill	kill-1203
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl50:	spl	spl51
	mov	kill	kill-1250
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl51:	spl	spl52
	mov	kill	kill-1253
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl52:	spl	spl53
	mov	kill	kill-1300
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl53:	spl	spl54
	mov	kill	kill-1303
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl54:	spl	spl55
	mov	kill	kill-1350
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl55:	spl	spl56
	mov	kill	kill-1353
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl56:	spl	spl57
	mov	kill	kill-1400
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl57:	spl	spl58
	mov	kill	kill-1403
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl58:	spl	spl59
	mov	kill	kill-1450
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl59:	spl	spl60
	mov	kill	kill-1453
	add     #-4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	dat	$0	$0
spl60:	spl	$14
	spl	last
	mov	kill	kill+476
	add     #4    $-1
	jmp	$-2
	dat	$0	$0
	dat	$0	$0
	mov	$0	$1
last:	mov	$-1	@1
	spl	@0	$10    ;jmp	$0	<626
	add	#plus	$-1
	jmp	$-3
	dat	$0	$0
	dat	$0	$0
lastx:	jmp	$0	<500
end start
