

#ifndef _AMIGA_SOUND_LIB_H
#define _AMIGA_SOUND_LIB_H



 
#ifndef __INLINE_MACROS_H
#include <inline/macros.h>
#endif

#ifndef DOOMSND_BASE_NAME
#define DOOMSND_BASE_NAME DoomSndBase
#endif

#define Sfx_SetVol(vol) \
	LP1NR(0x1E, Sfx_SetVol, int, vol, d0, \
	, DOOMSND_BASE_NAME)

#define Sfx_Start(wave, cnum, step, vol, sep, length) \
	LP6NR(0x24, Sfx_Start, char *, wave, a0, int, cnum, d0, int, step, d1, int, vol, d2, int, sep, d3, int, length, d4, \
	, DOOMSND_BASE_NAME)

#define Sfx_Update(cnum, step, vol, sep) \
	LP4NR(0x2A, Sfx_Update, int, cnum, d0, int, step, d1, int, vol, d2, int, sep, d3, \
	, DOOMSND_BASE_NAME)

#define Sfx_Stop(cnum) \
	LP1NR(0x30, Sfx_Stop, int, cnum, d0, \
	, DOOMSND_BASE_NAME)
	
#define Sfx_Done(cnum) \
	LP1(0x36, int, Sfx_Done, int, cnum, d0, \
	, DOOMSND_BASE_NAME)

#define Mus_SetVol(vol) \
	LP1NR(0x3C, Mus_SetVol, int, vol, d0, \
	, DOOMSND_BASE_NAME)

#define Mus_Register(musdata) \
	LP1(0x42, int, Mus_Register, void *, musdata, a0, \
	, DOOMSND_BASE_NAME)

#define Mus_Unregister(handle) \
	LP1NR(0x48, Mus_Unregister, int, handle, d0, \
	, DOOMSND_BASE_NAME)

#define Mus_Play(handle, looping) \
	LP2NR(0x4E, Mus_Play, int, handle, d0, int, looping, d1, \
	, DOOMSND_BASE_NAME)

#define Mus_Stop(handle) \
	LP1NR(0x54, Mus_Stop, int, handle, d0, \
	, DOOMSND_BASE_NAME)

#define Mus_Pause(handle) \
	LP1NR(0x5A, Mus_Pause, int, handle, d0, \
	, DOOMSND_BASE_NAME)

#define Mus_Resume(handle) \
	LP1NR(0x60, Mus_Resume, int, handle, d0, \
	, DOOMSND_BASE_NAME)

#define Mus_Done(handle) \
	LP1(0x66, int, Mus_Done, int, handle, d0, \
	, DOOMSND_BASE_NAME)
	
#endif /*  _AMIGA_SOUND_LIB_H  */


