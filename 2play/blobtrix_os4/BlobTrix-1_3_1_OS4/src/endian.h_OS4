#ifndef _ENDIAN_H_
#define _ENDIAN_H_

#include "SDL_endian.h"

#if SDL_BYTEORDER == SDL_LIL_ENDIAN
#define SWAP16(X)    (X)
#define SWAP32(X)    (X)
#else
#define SWAP16(X)    SDL_Swap16(X)
#define SWAP32(X)    SDL_Swap32(X)
#endif

#endif /* _ENDIAN_H_ */
