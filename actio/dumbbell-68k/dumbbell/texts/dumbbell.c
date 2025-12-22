/*
   Dumbbell - Copyright (c) 2005 Thunder Palace Entertainment.
   See README for copying conditions.
*/

#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <SDL/SDL.h>

#define DIR_LEFT 0
#define DIR_RIGHT 1
#define DIR_UP 2
#define DIR_DOWN 3

#define SCRWIDTH sw
#define SCRHEIGHT sh

#define DIGWIDTH 8
#define DIGHEIGHT 12

#define RECTSIZE 16
#define DELAY vdelay

Uint32 getpixel(int,int);
Uint32 obtainpixel(int,int);
void putpixel(int,int,Uint32);
void showdumbbell(int,int,Uint32);
Uint32 timeleft(void);

SDL_Surface *surface,*digits;
int sw=640,sh=480,vdelay=30;

int main(int argc,char *argv[]) {
	char numdisp[12];
	int dir,px,py,dx,dy,ss=1,fullscreen=1,wrap=1;
	Uint32 white,black,score=0;
	SDL_Rect rect;
	SDL_Event event;

	if(SDL_Init(SDL_INIT_VIDEO)<0) {
		fprintf(stderr,"Unable to initialise SDL: %s\n",SDL_GetError());
		return EXIT_FAILURE;
	}

	{
		int i;
		for(i=1;i<argc;i++) {
			if(*argv[i]!='-') continue;
			if(!strcmp(argv[i],"-small")) {
				sw=320;
				sh=240;
			} else if(!strcmp(argv[i],"-tiny")) {
				sw=320;
				sh=200;
			} else if(!strcmp(argv[i],"-midsize")) {
				/* do nothing because default size is 640x480 */
			} else if(!strcmp(argv[i],"-large")) {
				sw=800;
				sh=600;
			} else if(!strcmp(argv[i],"-huge")) {
				sw=1024;
				sh=768;
			} else if(!strcmp(argv[i],"-wide")) {
				sw=1280;
				sh=800;
			} else if(!strcmp(argv[i],"-square")) {
				sw=sh=360;
			} else if(!strcmp(argv[i],"-boring")) {
				vdelay=110;
			} else if(!strcmp(argv[i],"-slow")) {
				vdelay=60;
			} else if(!strcmp(argv[i],"-midspeed")) {
				/* do nothing because default delay is 30 */
			} else if(!strcmp(argv[i],"-fast")) {
				vdelay=20;
			} else if(!strcmp(argv[i],"-insane")) {
				vdelay=12;
			} else if(!strcmp(argv[i],"-window")) {
				fullscreen=0;
			} else if(!strcmp(argv[i],"-fullscreen")) {
				/* do nothing because fullscreen is on by default */
			} else if(!strcmp(argv[i],"-nowrap")) {
				wrap=0;
			} else if(!strcmp(argv[i],"-wrap")) {
				/* do nothing because wrapping is on by default */
			}
		}
	}

	if(fullscreen) surface=SDL_SetVideoMode(SCRWIDTH,SCRHEIGHT,0,SDL_ANYFORMAT|SDL_FULLSCREEN);
	else surface=SDL_SetVideoMode(SCRWIDTH,SCRHEIGHT,0,SDL_ANYFORMAT);

	if(surface==NULL) {
		fprintf(stderr,"Unable to set video mode: %s\n",SDL_GetError());
		SDL_Quit();
		return EXIT_FAILURE;
	}

	white=SDL_MapRGB(surface->format,255,255,255);
	black=SDL_MapRGB(surface->format,0,0,0);
	SDL_WM_SetCaption("Dumbbell",NULL);

	digits=SDL_LoadBMP("digits.bmp");
	SDL_DisplayFormat(digits);

	srand((unsigned)time(NULL));
	px=rand()%SCRWIDTH;
	py=rand()%SCRHEIGHT;
	dir=rand()%4;
	dx=rand()%(SCRWIDTH-8)+3;
	dy=rand()%(SCRHEIGHT-8)+3;

	if(!wrap)
	{
		SDL_Rect r;

		r.x = r.y = 1;
		r.w = SCRWIDTH-2;
		r.h = SCRHEIGHT-2;
		SDL_FillRect(surface,NULL,white);
		SDL_SetClipRect(surface,&r);
	}

	SDL_FillRect(surface,NULL,black);
	SDL_UpdateRect(surface,0,0,0,0);
	showdumbbell(dx,dy,white);
	SDL_ShowCursor(SDL_DISABLE);
	timeleft();

	for(;;) {
		switch(dir) {
		case DIR_LEFT:
			if(px==0) px=SCRWIDTH;
			px--;
			break;
		case DIR_RIGHT:
			px++;
			if(px==SCRWIDTH) px=0;
			break;
		case DIR_UP:
			if(py==0) py=SCRHEIGHT;
			py--;
			break;
		case DIR_DOWN:
			py++;
			if(py==SCRHEIGHT) py=0;
			break;
		}

		if(getpixel(px,py)==white) {
			if(px>dx-3 && px<dx+3 && py>dy-3 && py<dy+3) {
				score+=1000;
				rect.x=dx-RECTSIZE;
				rect.y=dy-RECTSIZE;
				rect.w=RECTSIZE*2+1;
				rect.h=RECTSIZE*2+1;
				SDL_FillRect(surface,&rect,black);
				SDL_UpdateRect(surface,rect.x,rect.y,rect.w,rect.h);
				dx=rand()%(SCRWIDTH-8)+3;
				dy=rand()%(SCRHEIGHT-8)+3;
				showdumbbell(dx,dy,white);
			} else break;
		}
		
		if(SDL_MUSTLOCK(surface)) SDL_LockSurface(surface);
		putpixel(px,py,white);
		if(SDL_MUSTLOCK(surface)) SDL_UnlockSurface(surface);
		SDL_UpdateRect(surface,px,py,1,1);
		score++;
		SDL_Delay(timeleft());

		if(SDL_PollEvent(&event)) {
			if(event.type==SDL_KEYDOWN) {
				if(event.key.keysym.sym==SDLK_ESCAPE) {
					ss=2;
					break;
				}
				if(event.key.keysym.sym==SDLK_SPACE) {
					int done=0;
					while(!done) {
						if(SDL_PollEvent(&event)) {
							if(event.type==SDL_QUIT) {
								ss=0;
								done=2;
								break;
							}
							if(event.type==SDL_KEYDOWN) {
								if(event.key.keysym.sym==SDLK_ESCAPE) {
									ss=2;
									done=2;
								}
								if(event.key.keysym.sym==SDLK_SPACE) done=1;
							}
						}
						SDL_Delay(50);
					}
					if(done==2) break;
				}
				if(event.key.keysym.sym==SDLK_UP && dir!=DIR_DOWN) dir=DIR_UP;
				if(event.key.keysym.sym==SDLK_DOWN && dir!=DIR_UP) dir=DIR_DOWN;
				if(event.key.keysym.sym==SDLK_LEFT && dir!=DIR_RIGHT) dir=DIR_LEFT;
				if(event.key.keysym.sym==SDLK_RIGHT && dir!=DIR_LEFT) dir=DIR_RIGHT;
			}

			if(event.type==SDL_QUIT) {
				ss=0;
				break;
			}
		}
	}

	while(ss) {
		int len,i;
		SDL_Rect dest;

		if(ss==1) {
			while(!SDL_PollEvent(&event)) SDL_Delay(50);
			if(event.type==SDL_QUIT) break;
			if(event.type!=SDL_KEYDOWN) continue;
			if(event.key.keysym.sym!=SDLK_ESCAPE && event.key.keysym.sym!=SDLK_SPACE) continue;
		}

		SDL_FillRect(surface,NULL,white);
		SDL_UpdateRect(surface,0,0,0,0);
		sprintf(numdisp,"%lu",(unsigned long)score);
		len=strlen(numdisp);
		dest.x=SCRWIDTH/2-(len*DIGWIDTH/2);
		rect.y=0;
		dest.y=SCRHEIGHT/2-DIGHEIGHT/2;
		rect.w=dest.w=DIGWIDTH;
		rect.h=dest.h=DIGHEIGHT;
		for(i=0;i<len;i++) {
			rect.x=DIGWIDTH*(numdisp[i]-'0');
			SDL_BlitSurface(digits,&rect,surface,&dest);
			dest.x+=DIGWIDTH;
		}
		SDL_UpdateRect(surface,0,0,0,0);
		break;
	}

	while(ss) {
		while(!SDL_PollEvent(&event)) SDL_Delay(50);
		if(event.type==SDL_QUIT) break;
		if(event.type!=SDL_KEYDOWN) continue;
		if(event.key.keysym.sym==SDLK_ESCAPE || event.key.keysym.sym==SDLK_SPACE) ss=0;
	}

	SDL_ShowCursor(SDL_ENABLE);
	SDL_Quit();
	return EXIT_SUCCESS;
}

Uint32 getpixel(int x,int y) {
	Uint32 result;

	if(SDL_MUSTLOCK(surface)) SDL_LockSurface(surface);
	result=obtainpixel(x,y);
	if(SDL_MUSTLOCK(surface)) SDL_UnlockSurface(surface);
	return result;
}

Uint32 obtainpixel(int x,int y) {
	int bpp;
	Uint8 *p;

	bpp=surface->format->BytesPerPixel;
	p=(Uint8 *)surface->pixels+y*surface->pitch+x*bpp;

	switch(bpp) {
	case 1:
		return *p;
	case 2:
		return *(Uint16 *)p;
	case 3:
		if(SDL_BYTEORDER==SDL_BIG_ENDIAN)
			return p[0]<<16 | p[1]<<8 | p[2];
		else
			return p[0] | p[1]<<8 | p[2]<<16;
	case 4:
		return *(Uint32 *)p;
	default:
		return 0;
	}
}

void putpixel(int x,int y,Uint32 pixel) {
	int bpp;
	Uint8 *p;

	if(x<0 || y<0 || x>=SCRWIDTH || y>=SCRHEIGHT) return;

	bpp=surface->format->BytesPerPixel;
	p=(Uint8 *)surface->pixels+y*surface->pitch+x*bpp;

	switch(bpp) {
	case 1:
		*p=pixel;
		break;
	case 2:
		*(Uint16 *)p=pixel;
		break;
	case 3:
		if(SDL_BYTEORDER==SDL_BIG_ENDIAN) {
			p[0]=(pixel>>16) & 0xFF;
			p[1]=(pixel>>8) & 0xFF;
			p[2]=pixel & 0xFF;
		} else {
			p[0]=pixel & 0xFF;
			p[1]=(pixel>>8) & 0xFF;
			p[2]=(pixel>>16) & 0xFF;
		}
		break;
	case 4:
		*(Uint32 *)p=pixel;
		break;
	}
}

void showdumbbell(int x,int y,Uint32 c) {
	if(SDL_MUSTLOCK(surface)) SDL_LockSurface(surface);
	putpixel(x,y,c);
	putpixel(x-1,y-1,c);
	putpixel(x+1,y+1,c);
	putpixel(x-2,y-2,c);
	putpixel(x+2,y+2,c);
	putpixel(x+1,y-1,c);
	putpixel(x-1,y+1,c);
	putpixel(x+2,y-2,c);
	putpixel(x-2,y+2,c);
	putpixel(x-1,y-2,c);
	putpixel(x-1,y+2,c);
	putpixel(x+1,y-2,c);
	putpixel(x+1,y+2,c);
	putpixel(x,y-2,c);
	putpixel(x,y+2,c);
	putpixel(x,y-1,c);
	putpixel(x,y+1,c);
	if(SDL_MUSTLOCK(surface)) SDL_UnlockSurface(surface);
	SDL_UpdateRect(surface,x-2,y-2,5,5);
}

Uint32 timeleft(void) {
	static Uint32 next=0;
	Uint32 now;

	now=SDL_GetTicks();

	if(next<=now) {
		next=now+DELAY;
		return 0;
	}

	return next-now;
}
