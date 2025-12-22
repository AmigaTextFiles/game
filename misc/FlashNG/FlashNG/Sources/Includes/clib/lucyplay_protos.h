#ifndef LUCYPLAY_PROTOS_H
#define LUCYPLAY_PROTOS_H

#include <exec/types.h>
#ifndef LIBRARIES_LUCYPLAY_H
#include <libraries/lucyplay.h>
#endif /* LIBRARIES_LUCYPLAY_H */

LONG lucAudioInit(VOID);
VOID lucAudioKill(VOID);
struct LucyPlaySample * lucAudioLoad(STRPTR fname);
VOID lucAudioFree(struct LucyPlaySample *smp);
VOID lucAudioPlay(struct LucyPlaySample *smp);
VOID lucAudioStop(VOID);
VOID lucAudioWait(VOID);
struct LucyPlayJoystick * lucJoyInit(VOID);
VOID lucJoyKill(struct LucyPlayJoystick *joy);
VOID lucJoyRead(struct LucyPlayJoystick *joy);
ULONG lucJoyReadBool(VOID);
ULONG lucBestModeID(ULONG w, ULONG h, ULONG d);
struct LucyPlayJoystick * lucJoyInitForce(VOID);

#endif /* LUCYPLAY_PROTOS_H */
