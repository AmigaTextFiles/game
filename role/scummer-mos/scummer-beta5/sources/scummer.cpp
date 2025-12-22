						/* SCUMMER */
		
	/* Copyright (C) 2001  Jack Burton aka Stefano Ceccherini */	
						
/*	A program which reads and display images from GREAT old
 *	LucasArts games files. It can display images contained in 
 *	"*.001" files, from MONKEY ISLAND I CD version, MONKEY 
 *	ISLAND II, INDIANA JONES AND THE FATE OF ATLANTIS, 
 *	probably others.											
						
					
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; see docs/LICENSE for further details.
 */


#include "blocks.h"
#include "image.h"
#include "scummer.h"


/* This is a global variable, to tell Scummer file functions	*/
/* what crypting version we are working with. Remember to set 	*/
/* it to DMN (new games) or DMNOLD (old games) after checking 	*/
/* game version. 												*/ 

Uint8 crypt_method = DMN; 

void Load_SplashScreen(void);

int main(int argc, char *argv[])
{	
	
	Uint8 room_n, quit = 0, r = 0;
	Uint32 offset;
	SDL_RWops *one_file = NULL;
	SDL_Event event;
	
	Scummer *scumm;		
	image *background;
			
	/* This part should be encapsulated into a class */
	if (argc < 2)
	{
		fprintf(stderr, "Usage: %s <filename>\n",argv[0]);
		exit(EXIT_FAILURE);
	}
	
	/* Open specified file */	
	if ((one_file=SDL_RWFromFile(argv[1],"rb"))==NULL) 
	{	
		fprintf(stderr, "Error: can't open %s\n",argv[1]);	
		exit (EXIT_FAILURE);
	}
	
	Load_SplashScreen();
	
	analyze (one_file);	
	
	room_n = room_number(one_file);
	
	
	do 
	{
		while( SDL_PollEvent( &event ) ) 
		{
			switch (event.type)
			{
				case SDL_QUIT:
                	quit = 1;
                	break; 
                case SDL_KEYDOWN:
            	case SDL_MOUSEBUTTONDOWN:          		
            		switch(event.key.keysym.sym)
            		{
            			case SDLK_q:
            				quit = 1;
            				break;
            			default:
						offset = room_offset(one_file, r++); 
						background = new image(one_file, offset);	
					    scumm = new Scummer(background);
						scumm->run();
						if (r == room_n ) quit = 1;
					}
			}
		}
	} while (!quit);
	
	SDL_RWclose (one_file);
	printf("Quitting...\n");
	delete scumm;
	delete background;
	exit(EXIT_SUCCESS);	
	
}	


Scummer::Scummer(image *img)
{
	this->img = img;
	
	/* Let's initialize SDL Video Subsystem */
	//printf("\nInitializing SDL...");
	if (SDL_Init (SDL_INIT_VIDEO)==-1) 
	{
		fprintf (stderr, "Failed! %s\n",SDL_GetError());
		exit(EXIT_FAILURE);
	}
	//printf("Done!\n");
	
	graphicengine = new GraphicEngine();
}

Scummer::~Scummer()
{
	delete graphicengine;
	SDL_Quit();
}

void Scummer::run()
{	
	Viewer *viewsession = new Viewer(graphicengine, img);
	viewsession->View();
	delete viewsession;
}


void Load_SplashScreen(void)
{

	SDL_Surface *splash, *view;
	
	SDL_Init (SDL_INIT_VIDEO);
	view = SDL_SetVideoMode(320,200,16,0);
	
	/* Taken from SDL examples */
	/* Load the BMP file into a surface */ 
    
    splash = SDL_LoadBMP("splash.bmp"); 
    if (splash == NULL) 
    { 
        fprintf(stderr, "Couldn't load %s: %s\n", "splash.bmp", SDL_GetError()); 
        exit(EXIT_FAILURE); 
    } 
    
 
    /* Blit onto the screen surface */ 
    if(SDL_BlitSurface(splash, NULL, view, NULL) < 0) 
        fprintf(stderr, "BlitSurface error: %s\n", SDL_GetError()); 

    SDL_UpdateRect(view, 0, 0, splash->w, splash->h); 

    /* Free the allocated BMP surface */ 
    SDL_FreeSurface(splash);
    
	
    /* End of taken part */
}
