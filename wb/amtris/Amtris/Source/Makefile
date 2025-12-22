Amtris : Amtris.o
   Blink WITH $*.blink

Amtris.o : Amtris.h

.c.o :
   NorthC -OT:$*.s $*.c
   Top T:$*.s T:$*.s1
   A68k -g -q -o$*.o T:$*.s1
   Delete T:$*.s T:$*.s1
