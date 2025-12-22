# include <stdio.h>
# include <stdlib.h>
# include "SDL2/SDL.h"
# include "SDL2/SDL_image.h"
# include "SDL2/SDL_mixer.h"
/*==================================================================*/		
void* AB_LoadMusic(struct game *G,char *filename)
{
void* mus;
	mus=Mix_LoadMUS(filename);
	return(mus);
}
/*==================================================================*/		
void* AB_LoadSound(struct game *G,char *filename)
{
void* fx;
	fx=Mix_LoadWAV(filename);
	return(fx);
}
/*==================================================================*/
void AB_FreeMusic(struct game *G,void* mus)
{
	Mix_FreeMusic(mus);
}
/*==================================================================*/
void AB_FreeSound(struct game *G,void* fx)
{
	Mix_FreeChunk(fx);
}
/*==================================================================*/
void AB_HaltMusic(struct game *G)
{
	Mix_HaltMusic();
}
/*==================================================================*/
void AB_PauseMusic(struct game *G)
{
	Mix_PauseMusic();
}
/*==================================================================*/
void AB_ResumeMusic(struct game *G)
{
	Mix_ResumeMusic ();
}
/*==================================================================*/
void AB_PlayMusic(struct game *G,void *mus,int loops)
{
	Mix_PlayMusic(mus,loops);
}
/*==================================================================*/
void AB_PlaySound(struct game *G,void* fx,int loops)
{
	Mix_PlayChannel(-1,fx,loops);
}
/*==================================================================*/
int AB_InitGame(struct game *G,int w,int h,char *name)
{

/* Creating window */
	G->screen=SDL_CreateWindow(name,SDL_WINDOWPOS_CENTERED,SDL_WINDOWPOS_CENTERED,w*3,h*3,SDL_WINDOW_OPENGL);

/* Renderer (with VSync, nice !) */
	G->renderer = SDL_CreateRenderer(G->screen, -1, SDL_RENDERER_PRESENTVSYNC|SDL_RENDERER_ACCELERATED);
	SDL_SetHint("SDL_HINT_RENDER_SCALE_QUALITY", "0");
	SDL_RenderSetLogicalSize(G->renderer,w,h);

/* Init audio */
	Mix_OpenAudio (44100,MIX_DEFAULT_FORMAT,2,4096);
	Mix_AllocateChannels(5);

/* Loading PNG */
	G->tiles = SDL_CreateTexture(G->renderer,SDL_PIXELFORMAT_ARGB8888,SDL_TEXTUREACCESS_STATIC,1000,240); /* tiles pointer is set here */
	SDL_Surface *tilesb = IMG_Load("graphics/tiles.png");
	SDL_SetColorKey(tilesb, SDL_TRUE, SDL_MapRGB(tilesb->format, 0, 0, 0) );
	G->tiles = SDL_CreateTextureFromSurface(G->renderer, tilesb); 					/* but tiles pointer is set here again = bad bad bad */
	SDL_FreeSurface(tilesb);
	return(TRUE);
}
/*==================================================================*/
void AB_CloseGame(struct game *G)
{
/* Exiting normally */
	SDL_DestroyTexture(G->tiles);
/* Cleaning */
	SDL_DestroyRenderer(G->renderer);
	SDL_DestroyWindow(G->screen);	
}
/*==================================================================*/
void AB_Clear(struct game *G)
{
	SDL_RenderClear(G->renderer);
}
/*==================================================================*/
void AB_Update(struct game *G)
{
	SDL_RenderPresent(G->renderer);
}
/*==================================================================*/
void* AB_LoadTexture(struct game *G,char *filename)
{	
SDL_Texture *tex;
	tex=IMG_LoadTexture(G->renderer,filename);
	return(tex);
}		
/*==================================================================*/
void AB_DrawSprite(struct game *G,AB_Texture *tex,AB_Rect *src,AB_Rect *dst)
{
	SDL_RenderCopy(G->renderer,tex,&src,&dst);
}
/*==================================================================*/
void AB_DestroyTexture(struct game *G,AB_Texture *tex)
{
	SDL_DestroyTexture(tex);
}
/*==================================================================*/
void AB_Events(struct game *G)
{
SDL_Event event;
int key,type;

	key=0;
	while (SDL_PollEvent(&event)) 
		{
		key =event.key.keysym.sym;
		type=event.type;

		if (type == SDL_KEYDOWN) 
			G->key=key;
		
		if (type == SDL_QUIT)
			{G->chapter=6;}

		if (key == SDLK_UP)
		if (type == SDL_KEYDOWN) 
			G->joystick.up=TRUE;
			
		if (key == SDLK_DOWN) 
		if (type == SDL_KEYDOWN) 
			G->joystick.down=TRUE;
		
		if (key == SDLK_LEFT)
		if (type == SDL_KEYDOWN) 
			G->joystick.left=TRUE;

		if (key == SDLK_RIGHT)
		if (type == SDL_KEYDOWN) 
			G->joystick.right=TRUE;

		if (key == SDLK_UP)
		if (type == SDL_KEYUP) 
			G->joystick.up=FALSE;
			
		if (key == SDLK_DOWN) 
		if (type == SDL_KEYUP) 
			G->joystick.down=FALSE;
		
		if (key == SDLK_LEFT)
		if (type == SDL_KEYUP) 
			G->joystick.left=FALSE;

		if (key == SDLK_RIGHT)
		if (type == SDL_KEYUP) 
			G->joystick.right=FALSE;

		
		if (G->key == SDLK_c) 
			G->grapset=!G->grapset;	/* Change graphic set */

		if (G->key == SDLK_f) 
			{ 
					G->fullscreen = !G->fullscreen ;	/* Switch fullscreen/windowed */
					if (G->fullscreen) 
						SDL_SetWindowFullscreen(G->screen,SDL_WINDOW_FULLSCREEN_DESKTOP);
					else 
						SDL_SetWindowFullscreen(G->screen,0);
			}
			
   		if (G->key == SDLK_ESCAPE)
			G->chapter = 6;

		}
	
}	
/*==================================================================*/
void AB_NewMusicN(struct game *G,int n,int loops)
{
	AB_HaltMusic();
	AB_PlayMusic(G,G->bso[n],loops);
}
/*==================================================================*/
void AB_PlaySoundN(struct game *G,int n,int loops)
{
	AB_PlaySound(G,G->fx[n],loops);
}
/*==================================================================*/		
void AB_Drawtexture(struct game *G,char *filename)
{
	void* tex = AB_LoadTexture(G,filename);
	AB_DrawSprite(G,tex,NULL,NULL);
	AB_DestroyTexture(G,tex);
}
/*==================================================================*/
