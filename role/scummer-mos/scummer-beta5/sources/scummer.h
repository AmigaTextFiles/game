#ifndef scummer_h
#define scummer_h

#include "graphicengine.h"
#include "viewer.h"
#include "image.h"

class Scummer
{
	GraphicEngine *graphicengine;
	Viewer *viewsession;
	image *img;
	
public:
	
	Scummer(image *img);
	~Scummer();
	void run();
};

#endif
