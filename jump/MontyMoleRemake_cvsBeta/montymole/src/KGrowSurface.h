

#ifndef __KGROWSURFACE_H
#define __KGROWSURFACE_H

#include "KSurface.h"


class KGrowSurface : public KSurface
{

public:

	KGrowSurface();
	~KGrowSurface();

	bool Create(SDL_Surface *parent, Uint32 flags, int x, int y, int w, int h, int bitDepth);
	void Update();

private:

		int						nGrowBy;
		SDL_Rect			rcNotBorder,					// area of surface not including any border
									rcSrc,								// area blitted from
									rcDest;								// area blitted to parent surface
		KJSize				ptGrowTo;							// size to grow to

};

#endif
