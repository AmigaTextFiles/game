typedef unsigned char	Uint8;
typedef signed char	Sint8;
typedef unsigned short	Uint16;
typedef signed short	Sint16;
typedef unsigned int	Uint32;
typedef signed int	Sint32;
#ifndef ENABLE_AHI
typedef struct {
	Sint16 x, y;
	Uint16 w, h;
} SDL_Rect;
#endif

