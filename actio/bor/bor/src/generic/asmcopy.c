#include <string.h>
#include "asmcopy.h"
// ASM data copy routines


// Syntax: asm_copy(dest, source, bytes)
void asm_copy(void* dest,const void* source ,int length)
{
	memcpy(dest,source,length);
}

// Syntax: asm_clear(buf, bytes)
void asm_clear(void* dest,int length)
{
	memset(dest,0,length);
}


// Syntax: asm_planarvcopy(vram,source,startline,lines)
//extern void asm_planarvcopy(void* dest,void* source,int startline,int lines);

/*
// Syntax: copyrect(source,dest,left,top,right,bottom,screenheight)
// Watcom accepts only 6 registers in a call, so the last one is
// passed through the stack. Argh!
extern void __near copyrect(void*,void*,int,int,int,int,int);
#pragma aux copyrect parm[esi][edi][eax][ebx][ecx][edx] modify[eax ebx ecx edx edi];
*/
