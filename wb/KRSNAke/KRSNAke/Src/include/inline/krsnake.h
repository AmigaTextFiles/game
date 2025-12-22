#ifndef _INLINE_KRSNAKE_H
#define _INLINE_KRSNAKE_H

#include <sys/cdefs.h>
#include <inline/stubs.h>

__BEGIN_DECLS

#ifndef BASE_EXT_DECL
#define BASE_EXT_DECL extern struct krsnakebase*  krsnakebase;
#endif
#ifndef BASE_PAR_DECL
#define BASE_PAR_DECL
#define BASE_PAR_DECL0 void
#endif
#ifndef BASE_NAME
#define BASE_NAME krsnakebase
#endif

static __inline void 
KsDeleteSoundObject (BASE_PAR_DECL a)
{
  BASE_EXT_DECL
  register struct krsnakebase* a6 __asm("a6") = BASE_NAME;
  register a __asm("D0") = a;
  __asm __volatile ("jsr a6@(-0x66)"
  : /* no output */
  : "r" (a6), "r" (D0)
  : "D0","a0","a1","d0","d1", "memory");
}
static __inline UBYTE 
KsGetClientSig (BASE_PAR_DECL a)
{
  BASE_EXT_DECL
  register UBYTE  _res  __asm("d0");
  register struct krsnakebase* a6 __asm("a6") = BASE_NAME;
  register a __asm("D0") = a;
  __asm __volatile ("jsr a6@(-0x48)"
  : "=r" (_res)
  : "r" (a6), "r" (D0)
  : "D0","a0","a1","d0","d1", "memory");
  return _res;
}
static __inline ULONG 
KsNotifyServer (BASE_PAR_DECL a,b)
{
  BASE_EXT_DECL
  register ULONG  _res  __asm("d0");
  register struct krsnakebase* a6 __asm("a6") = BASE_NAME;
  register a __asm("A0") = a;
  register b __asm("D0") = b;
  __asm __volatile ("jsr a6@(-0x78)"
  : "=r" (_res)
  : "r" (a6), "r" (A0), "r" (D0)
  : "A0","D0","a0","a1","d0","d1", "memory");
  return _res;
}
static __inline ULONG 
KsPlaySoundObject (BASE_PAR_DECL a)
{
  BASE_EXT_DECL
  register ULONG  _res  __asm("d0");
  register struct krsnakebase* a6 __asm("a6") = BASE_NAME;
  register a __asm("D0") = a;
  __asm __volatile ("jsr a6@(-0x60)"
  : "=r" (_res)
  : "r" (a6), "r" (D0)
  : "D0","a0","a1","d0","d1", "memory");
  return _res;
}
static __inline ULONG 
KsReadEvent (BASE_PAR_DECL a,b,c)
{
  BASE_EXT_DECL
  register ULONG  _res  __asm("d0");
  register struct krsnakebase* a6 __asm("a6") = BASE_NAME;
  register a __asm("A0") = a;
  register b __asm("D1") = b;
  register c __asm("D0") = c;
  __asm __volatile ("jsr a6@(-0x42)"
  : "=r" (_res)
  : "r" (a6), "r" (A0), "r" (D1), "r" (D0)
  : "A0","D0","D1","a0","a1","d0","d1", "memory");
  return _res;
}
static __inline struct KPrefs * 
KsReadKRSNAkePrefs (BASE_PAR_DECL0)
{
  BASE_EXT_DECL
  register struct KPrefs *  _res  __asm("d0");
  register struct krsnakebase* a6 __asm("a6") = BASE_NAME;
  __asm __volatile ("jsr a6@(-0x4e)"
  : "=r" (_res)
  : "r" (a6)
  : "a0","a1","d0","d1", "memory");
  return _res;
}
static __inline APTR 
KsReadSoundObject (BASE_PAR_DECL char * a)
{
  BASE_EXT_DECL
  register APTR  _res  __asm("d0");
  register struct krsnakebase* a6 __asm("a6") = BASE_NAME;
  register char * D0 __asm("D0") = a;
  __asm __volatile ("jsr a6@(-0x5a)"
  : "=r" (_res)
  : "r" (a6), "r" (D0)
  : "D0","a0","a1","d0","d1", "memory");
  return _res;
}
static __inline APTR 
KsRegisterClient (BASE_PAR_DECL0)
{
  BASE_EXT_DECL
  register APTR  _res  __asm("d0");
  register struct krsnakebase* a6 __asm("a6") = BASE_NAME;
  __asm __volatile ("jsr a6@(-0x2a)"
  : "=r" (_res)
  : "r" (a6)
  : "a0","a1","d0","d1", "memory");
  return _res;
}
static __inline ULONG 
KsRemoveClient (BASE_PAR_DECL a)
{
  BASE_EXT_DECL
  register ULONG  _res  __asm("d0");
  register struct krsnakebase* a6 __asm("a6") = BASE_NAME;
  register a __asm("D0") = a;
  __asm __volatile ("jsr a6@(-0x30)"
  : "=r" (_res)
  : "r" (a6), "r" (D0)
  : "D0","a0","a1","d0","d1", "memory");
  return _res;
}
static __inline ULONG 
KsWaitForEvent (BASE_PAR_DECL a)
{
  BASE_EXT_DECL
  register ULONG  _res  __asm("d0");
  register struct krsnakebase* a6 __asm("a6") = BASE_NAME;
  register a __asm("D0") = a;
  __asm __volatile ("jsr a6@(-0x3c)"
  : "=r" (_res)
  : "r" (a6), "r" (D0)
  : "D0","a0","a1","d0","d1", "memory");
  return _res;
}
static __inline ULONG 
KsWriteKRSNAkePrefs (BASE_PAR_DECL struct KPrefs * a)
{
  BASE_EXT_DECL
  register ULONG  _res  __asm("d0");
  register struct krsnakebase* a6 __asm("a6") = BASE_NAME;
  register struct KPrefs * D0 __asm("D0") = a;
  __asm __volatile ("jsr a6@(-0x54)"
  : "=r" (_res)
  : "r" (a6), "r" (D0)
  : "D0","a0","a1","d0","d1", "memory");
  return _res;
}
#undef BASE_EXT_DECL
#undef BASE_PAR_DECL
#undef BASE_PAR_DECL0
#undef BASE_NAME

__END_DECLS

#endif /* _INLINE_KRSNAKE_H */
