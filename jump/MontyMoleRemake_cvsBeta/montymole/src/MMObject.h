

#ifndef __MMOBJECT_H
#define __MMOBJECT_H

#include "KSurface.h"

class MMObject : public KSurface
{

public:

		bool Create(SDL_Surface *parent, const char *filename);
		bool Create(SDL_Surface *parent, SDL_Surface *copy, SDL_Rect *rect=NULL);

		KJLine	GetBaseLine();
		bool		Under(KJLine baseline);
protected:


};

#endif
