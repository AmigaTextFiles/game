; Cthulhu9
; Autor: Dominik Kozaczko kl 3b.
.WA91

source:		DAT	15
target:		DAT	800
kill:		DAT	200
loop:		DAT	10
		MOV	#15	source
		MOV	#100	target
		MOV	#100	kill
		MOV	#10	loop
start:		MOV	loop	@kill
		ADD 	#10		kill
		DJN	-2		loop
clone:		MOV	<source		<target
		JMN	clone		source
		ADD	#4	target
wow:		JMP	@target
		END	START
		
