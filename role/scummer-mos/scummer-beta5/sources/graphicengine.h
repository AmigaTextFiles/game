/* A Graphics Engine class (taken almost entirely from FreeCnC).	*
 * This class should offer some basics graphic services.			*/

#ifndef graphicengine_h
#define graphicengine_h

#include "SDL.h"
#include "image.h"

class GraphicEngine 
{
	SDL_Surface *screen;
	SDL_Rect view;
	image *img;
	Uint16 width;
	Uint16 height;
	
public:
	
	GraphicEngine();
	~GraphicEngine() { SDL_FreeSurface(screen); };
	void SetupCurrentImage(image *img) { this->img = img; };
	void RenderImage() ;
	Uint16 GetWidth() { return width ; };
	Uint16 GetHeight() { return height ; };
};

#endif
