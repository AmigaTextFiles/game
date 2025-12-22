/*	Righteous
	Copyright (C) 2006 Ben Hull 
	
	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.
		      
	This program is distributed in the hope that it will be fun,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
			       
	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <SDL/SDL_mixer.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "mathstuff.c"
#include "gameloopsingleplayer.c"


int main( int argc, char *argv[])
{


	if (SDL_Init(SDL_INIT_VIDEO) != 0) {
		printf("Error: %s\n", SDL_GetError());
		return 1;
	}
	atexit(SDL_Quit);

	SDL_WM_SetCaption("Righteous!", NULL);
    
	SDL_Surface *screen, *title, *arrow, *num;

	if ((screen = SDL_SetVideoMode(800, 600, 0, SDL_DOUBLEBUF)) == NULL) {
		printf("Error: %s\n", SDL_GetError());
		return 1;
	}
	
	
	
	if((title = IMG_Load("gfx/title.png"))==NULL) exit(1);
	if((arrow = IMG_Load("gfx/arrow.png"))==NULL) exit(1);
	if((num = IMG_Load("gfx/numbers.png"))==NULL) exit(1);

	SDL_Rect src, dest;
	SDL_Event event;
	Uint8 *keystate;

	
	
	int quit=0, selection=0, timelimit=30;
	
	while(quit==0) {

		srand(time(NULL));
		
		
		
		src.x=0;src.y=0;src.w=title->w;src.h=title->h;
		dest.x=0;dest.y=0;dest.w=src.w;dest.h=src.h;
		SDL_BlitSurface(title, &src, screen, &dest);
					
		src.x=0;src.y=0;src.w=arrow->w;src.h=arrow->h;
		dest.x=130; dest.y=430+(40*selection); dest.w=src.w;dest.h=src.h;
		SDL_BlitSurface(arrow, &src, screen, &dest);	
		
		
		int temp2=timelimit, tmp, digits[30];

		int digit=-1,temp=1;
		
		do{
			digit++;
			temp*=10;
		} while(temp<=temp2);

		
		tmp=digit;

		do {
		
			int x,y=1;

			digits[tmp] = determine_digits(temp2,tmp); // determine the value of the digit

			for(x=0;x<tmp;x++) y*=10; // determine the power of 10
	
			temp2-=digits[tmp]*y; // subtract from temporary value
		
		
		} while(tmp--);
		
		
		for(tmp=0;tmp<=digit;tmp++) { // display the value

			src.x = digits[tmp]*20; 
			src.y = 0;
			dest.w = src.w = 20; dest.h = src.h = num->h;

			dest.x = 520+(digit*15)+(tmp*-1*15); dest.y = 477;


			SDL_BlitSurface(num, &src, screen, &dest);
	
		}

	
		
		SDL_Flip(screen);
	
		temp=1;

		while(temp) {			
			SDL_PollEvent(&event);
			keystate = SDL_GetKeyState(NULL);
			
			if(SDL_GetTicks()%100==0) {

				if(keystate[SDLK_UP]&&selection>0) { temp=0; selection--; }
				else if(keystate[SDLK_UP]&&selection==0) { temp=0; selection=3; }

				if(keystate[SDLK_DOWN]&&selection<3) { temp=0; selection++; }
				else if(keystate[SDLK_DOWN]&&selection==3) { temp=0; selection=0; }
			
				if(keystate[SDLK_RIGHT]&&selection==1&&timelimit<1000) { temp=0; timelimit+=10; }
				if(keystate[SDLK_LEFT]&&selection==1&&timelimit>10) { temp=0; timelimit-=10; }
				
				if(keystate[SDLK_f]) {
					SDL_WM_ToggleFullScreen(screen);
#ifdef __amigaos4__
					SDL_Flip(screen);
#endif
				}

					
				}
											
				
				if(keystate[SDLK_RETURN]) {
				
					switch(selection) {
				
						case 0: temp=0; gameloopsingleplayer(screen, 0, 1); break;
						case 1: temp=0; gameloopsingleplayer(screen, timelimit, 1); break;
						case 2: temp=0; gameloopsingleplayer(screen, 0, 2); break;
						case 3: temp=0; quit=1; break;
						default: break;

					}
	
				}
			
		}
		
	}

	SDL_FreeSurface(title);
	SDL_FreeSurface(arrow);
	
	return 0;
  
}
