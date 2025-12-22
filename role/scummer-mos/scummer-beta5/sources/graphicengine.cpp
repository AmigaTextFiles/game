#include "graphicengine.h"

GraphicEngine::GraphicEngine()
{
	width = 320;
	height = 200;
	
	this->view.y = 0;
	this->view.w = 8;
	this->view.h = height;
	
	/* Set window caption */
	SDL_WM_SetCaption("Scummer", "Scummer");
	
	/* Set a video mode */
	screen = SDL_SetVideoMode(width, height, 16, SDL_SWSURFACE);
	if (screen == NULL)
		fprintf(stderr, "Cannot set %dx%d video mode: %s\n",
			width, height, SDL_GetError());
}


void GraphicEngine::RenderImage()
{
	SDL_Surface *framebuffer;
		
	for (Uint8 x = 0; x < width/8; x++)
	{
		this->view.x = x*8;

		/* Get next strip to draw */
		framebuffer = img->GetStrip(x);
		
		/* Draw it */
		if (framebuffer != NULL)
			SDL_BlitSurface(framebuffer, NULL, screen, &view);
			
	}
	/* Update the screen */
	SDL_UpdateRect(screen, 0, 0, width, height);
}


