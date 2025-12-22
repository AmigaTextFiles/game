#include "_variables.h"

int GoodieX;
int GoodieY;

SDL_Rect GoodieSrcRect[10];

void defineGoodies()
{
	fprintf(stdout,"\nattempting to define goodies...\n");
		GoodieSrcRect[1].x = 0;
		GoodieSrcRect[1].y = 0;
		GoodieSrcRect[1].w = 18;
		GoodieSrcRect[1].h = 15;
		GoodieX = -200;
		GoodieY = -200;
	fprintf(stdout,"Succesfully defined goodies...\n");
}
