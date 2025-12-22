

#ifndef __MMROOM_H
#define __MMROOM_H

#include "MMDataDefs.h"
#include "KSurface.h"
#include "MMCrusher.h"


class MMRoom : public KSurface
{

public:


	bool	Create(SDL_Surface *parent);
	bool	DrawLayout(PCROOM *room);

private:

	MMCrusher		*lpCrusher;			// surface holding crusher

};


#endif
