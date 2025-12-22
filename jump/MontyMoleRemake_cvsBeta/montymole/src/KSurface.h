

#ifndef __KSURFACE_H
#define	__KSURFACE_H

#include "KJ.h"
#include "KScreen.h"




class	KSurface : public KScreen
{

public:

	enum MODE 
				{									// Current condition of window
					MODE_HIDE,			// hidden
					MODE_SHOW				// showing
				};

	virtual ~KSurface() { };
	
	virtual bool Create(SDL_Surface *parent, Uint32 flags, int x, int y, int w, int h, int bitDepth);
	virtual bool Create(SDL_Surface *parent, const char *filename, int x=0, int y=0);
	
	virtual void Update();

	bool	InRect(SDL_Rect *lpRect);	// Test if object Rect is within given Rect

	inline void Show(bool show) { if(show) 
																	mode = MODE_SHOW; 
																else
																	mode = MODE_HIDE; } ;
	
	inline MODE Visible() { return mode; };

	inline SDL_Rect GetDestRect() { return rcDest; } ;
	inline SDL_Rect GetSrcRect() { return rcSrc; } ;


protected:

	MODE					mode;
	SDL_Surface		*lpParent;
	SDL_Rect			rcDest,
								rcSrc;						// bounds of surface

};


#endif
