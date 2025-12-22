#ifndef  CLIB_KRSNAKE_PROTOS_H
#define  CLIB_KRSNAKE_PROTOS_H

/*
**      $VER: krsnake_protos.h 1.11 (24 Oct 1995)
*/

#ifndef  LIBRARIES_KRSNAKE_H
#include <libraries/krsnake.h>
#endif

APTR  KsRegisterClient(void);
ULONG KsRemoveClient(APTR);
ULONG KsWaitForEvent(APTR);
ULONG KsReadEvent(APTR,APTR,APTR);
UBYTE KsGetClientSig(APTR);
struct KPrefs * KsReadKRSNAkePrefs(void);
ULONG KsWriteKRSNAkePrefs(struct KPrefs *);
void KsDeleteSoundObject(APTR);
ULONG KsPlaySoundObject(APTR);
APTR KsReadSoundObject(char *);
ULONG KsNotifyServer(ULONG,ULONG);

#endif   /* CLIB_KRSNAKE_PROTOS_H */
