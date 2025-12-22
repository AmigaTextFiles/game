#ifdef _M68020
#define __DO_STI_CPUCHECK
#else
#ifdef _M68881
#define __DO_STI_CPUCHECK
#else
#ifdef _M68040
#define __DO_STI_CPUCHECK
#else
#ifdef _M68030
#define __DO_STI_CPUCHECK
#endif
#endif
#endif
#endif

#ifdef __DO_STI_CPUCHECK

#include <proto/exec.h>
#include <exec/execbase.h>
#include <stdlib.h>

void _STI_CheckCPU(void);

void _STI_CheckCPU()
{
 register long cpuid;
 register struct ExecBase **execbaseptr=(struct ExecBase **)4;
 register struct ExecBase *execbase;

 execbase = *execbaseptr;
 cpuid = execbase->AttnFlags;

#ifdef _M68020
 if (!(cpuid & AFF_68020))
  exit(0);
#else
#ifdef _M68030
 if (!(cpuid & AFF_68020))
  exit(0);
#else
#ifdef _M68040
 if (!(cpuid & AFF_68020))
  exit(0);
#endif
#endif
#endif

#ifdef _M68881
 if (!(cpuid & AFF_68881))
  exit(0);
#endif
}

#undef __DO_STI_CPUCHECK

#endif
