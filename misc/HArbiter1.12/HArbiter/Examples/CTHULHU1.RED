; Cthulhu1
; Autor: Dominik Kozaczko kl 3b.
.WA91

source:		DAT	15
target:		DAT	50
split:		DAT	20
loop:		DAT	4
start:		MOV	#15	source
		MOV	#50	target
		MOV	#20	split
		MOV	#4	loop
		SPL	@split
		ADD 	#10		split
		DJN	-2		loop
clone:		MOV	<source		<target
		JMN	clone		source
		ADD	#4	target
wow:		JMP	@target
		END	START
		
