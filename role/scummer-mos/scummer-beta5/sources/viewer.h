#ifndef viewer_h
#define viewer_h

#include "graphicengine.h"
#include "image.h"

class Viewer
{
	GraphicEngine *gfxengine;
	image *animage;

public:

	Viewer(GraphicEngine *graphicengine, image *img)
		{ this->gfxengine = graphicengine; this->animage = img; };
	~Viewer();
	void View();
};

#endif
