#include <exec/memory.h>
#include <proto/exec.h>

APTR __builtin_new(ULONG size)
{
  ULONG *a;

  size = (size+3*sizeof(ULONG)-1)&~(2*sizeof(ULONG)-1);
  if ((a=(ULONG *)AllocMem(size,MEMF_CLEAR)) != NULL)
    *a++ = size;
  return (APTR)a;
}

VOID __builtin_delete(APTR mem)
{
  ULONG size;

  if (mem != NULL)
  {
    size = *--((ULONG *)mem); FreeMem(mem,size);
  }
}
