#ifndef __TIMER_H
#define __TIMER_H

void timer_init(void);
void timer_exit(void);
//unsigned timer_gettime(void);
/*
;----------------------------------------------------------------
; Proc:		timer_getinterval
; In:		ECX = frequency (1 to 1193181 Hz)
; Returns:	EAX = units passed since last call
; Destroys:	EBX ECX EDX
; Description:	Returns the time that passed since the last call,
;		measured in the specified frequency.
;		This function is extremely accurate, since all
;		rounding errors are compensatred for.
;		Only use for very short intervals!
;----------------------------------------------------------------
*/
unsigned long timer_getinterval(unsigned freq);

#endif
