#include "_variables.h"

SDL_Surface* DisplaySurface = NULL;			//display surface
SDL_Surface* TilesSurface = NULL;			//tiles surface
SDL_Surface* GianaSpritesSurface = NULL;	//Giana's sprites surface
SDL_Surface* EnemySpritesSurface = NULL;	//enemy-sprites surface
SDL_Surface* FontSurface = NULL;			//the font surface
SDL_Surface* GoodiesSurface = NULL;			//the goodies surface

void setSurfaces()
{
	fprintf(stdout,"\nattempting to set up surfaces...\n");
	//*********************************
	// create windowed / fullscreen environment
	if(FULLSCREEN == 0){DisplaySurface = SDL_SetVideoMode(SCREENWIDTH, SCREENHEIGHT, 8, SDL_ANYFORMAT);}
	if(FULLSCREEN == 1){DisplaySurface = SDL_SetVideoMode(SCREENWIDTH, SCREENHEIGHT, 8, SDL_SWSURFACE|SDL_FULLSCREEN);}
	if (DisplaySurface == NULL){fprintf(stderr,"Could not set up display surface!\n");exit(1);}
	else{fprintf(stdout,"Succesfully created DisplaySurface...\n");}
	//*********************************
/*
	//*********************************
	// hide cursor if in fullscreen mode
	int SDL_ShowCursor(int toggle);
    if(intFullscreen == 1){SDL_ShowCursor(SDL_DISABLE);}
	//*********************************
*/
	//*********************************
	// set colourcode for transparent colour
	Uint32 CKColor = SDL_MapRGB(DisplaySurface->format,255,0,255);
	//*********************************

	//*********************************
	// generate font surfaces
	FontSurface = SDL_DisplayFormat (SDL_LoadBMP("font.bmp"));
	SDL_SetColorKey(FontSurface, SDL_SRCCOLORKEY, CKColor);
	if(FontSurface==NULL){fprintf(stderr,"Could not load FontSurface!\n");exit(1);}
	else{fprintf(stdout,"Succesfully loaded FontSurface...\n");}
	//*********************************

	//*********************************
	// generate tiles surfaces
	TilesSurface = SDL_DisplayFormat (SDL_LoadBMP("tiles.bmp"));
	SDL_SetColorKey(TilesSurface, SDL_SRCCOLORKEY, CKColor);
	if(TilesSurface==NULL){fprintf(stderr,"Could not load TilesSurface!\n");exit(1);}
	else{fprintf(stdout,"Succesfully loaded TilesSurface...\n");}
	//*********************************

	//*********************************
	// generate giana sprites surfaces
	GianaSpritesSurface = SDL_DisplayFormat (SDL_LoadBMP("giana.bmp"));
	SDL_SetColorKey(GianaSpritesSurface, SDL_SRCCOLORKEY, CKColor);
	if(GianaSpritesSurface==NULL){fprintf(stderr,"Could not load GianaSpritesSurface!\n");exit(1);}
	else{fprintf(stdout,"Succesfully loaded GianaSpritesSurface...\n");}
	//*********************************

	//*********************************
	// generate enemy sprites surfaces
	EnemySpritesSurface = SDL_DisplayFormat (SDL_LoadBMP("enemies.bmp"));
	SDL_SetColorKey(EnemySpritesSurface, SDL_SRCCOLORKEY, CKColor);
	if(EnemySpritesSurface==NULL){fprintf(stderr,"Could not load EnemySpritesSurface!\n");exit(1);}
	else{fprintf(stdout,"Succesfully loaded EnemySpritesSurface...\n");}
	//*********************************

		//*********************************
	// generate enemy sprites surfaces
	GoodiesSurface = SDL_DisplayFormat (SDL_LoadBMP("goodies.bmp"));
	SDL_SetColorKey(GoodiesSurface, SDL_SRCCOLORKEY, CKColor);
	if(GoodiesSurface==NULL){fprintf(stderr,"Could not load EnemySpritesSurface!\n");exit(1);}
	else{fprintf(stdout,"Succesfully loaded GoodiesSurface...\n");}
	//*********************************



}


