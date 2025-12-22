#include "viewer.h"

Viewer::~Viewer()
{
}

void Viewer::View()
{	
	gfxengine->SetupCurrentImage(animage);
	
	/* Completely scroll right */
	do {
	gfxengine->RenderImage();
	} while (!animage->Scroll(SCROLL_RIGHT));
	
	/* Completely scroll left */
	do {
	gfxengine->RenderImage();
	} while (!animage->Scroll(SCROLL_LEFT));

}
