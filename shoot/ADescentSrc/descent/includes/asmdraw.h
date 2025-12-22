#ifndef __ASMDRAW_H
#define __ASMDRAW_H

#include <exec/types.h>

extern void virge_repw(UWORD *dest __asm("a0"), int count __asm("d0"), UWORD word __asm("d1"));

#endif
