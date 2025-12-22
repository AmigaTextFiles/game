/* Prototypes for functions defined in
EasySound.c
 */

extern struct IOAudio * IOA[4];

BOOL ESPlaySound(struct SoundInfo * , UWORD , UBYTE , BYTE , WORD , UWORD , ULONG , ULONG , BOOL );

void ESStopSound(UBYTE );

BOOL ESPrepareIOA(UWORD , UWORD , UWORD , UBYTE , BYTE , struct SoundInfo * , ULONG , ULONG );

void ESRemoveSound(struct SoundInfo * );

struct SoundInfo * ESPrepareSound(STRPTR );

UWORD ESLoadSound(STRPTR , struct SoundInfo * );

ULONG ESGetSize(STRPTR );

ULONG ESSizeIFF(STRPTR );

UWORD ESReadIFF(STRPTR , struct SoundInfo * );

BOOL ESMoveTo(STRPTR , FILE * );

void playSound(APTR sound_ptr,
               int volume);

