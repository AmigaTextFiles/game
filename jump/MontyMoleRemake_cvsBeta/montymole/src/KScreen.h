

#ifndef __KSCREEN_H
#define __KSCREEN_H

#include <SDL/SDL.h>
#include "KPtrArray.h"
#include "KJText.h"


enum {															// Bit depths available
				KSCREEN_DEPTH8 = 0x08,			// 8 bits per pixel
				KSCREEN_DEPTH16 = 0x10			// 16 bits per pixels
			};														/////////////////////////////////////////


				
class KScreen : public KPtrArray
{
public:

	KScreen();
	virtual ~KScreen();

	bool	Create(int width, int height,
		           int bitDepth = KSCREEN_DEPTH16,
							 Uint32 flags = SDL_HWSURFACE | SDL_DOUBLEBUF);

	bool	CreateChildSurface(SDL_Rect rcSize);
	bool	CreateChildBMP(const char *filename);
	void	Update();
	void  UpdateError();

	inline void cls() { SDL_FillRect(lpSurface, NULL, iBgColor); };
	inline SDL_Surface*	GetSurface() { return lpSurface; };

	enum { ERR_CANT_CREATE_VIDEO_SCREEN,
				 ERR_CANT_CREATE_SURFACE,
				 ERR_NO_ERROR,
				 ERR_OUT_OF_MEMORY,
				 ERR_USER_DEFINE
				};


protected:

	SDL_Surface		*lpSurface;
#ifdef __USE_KJTEXT
	KJText				textStream;
#endif

	bool	bCopied;
	int	objType;
	long	iBgColor;			// background colour
	int	lastError;			// Used for debugging

};

#endif
