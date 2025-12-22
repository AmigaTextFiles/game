/* Linux Shuttle Lander 
 *
 * Copyright (C) 2003 Thomas Raes (thomas.raes@pandora.be)
 * 
 * This program is free software; you can redistribute it and/or modify
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or 
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be usefull,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details
 */

#include <stdio.h>
#include <sys/time.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <SDL/SDL.h>
#include "SFont.h"
#include "SDL_image.h"

 SDL_Surface *screen;
 SDL_Surface *intro;
 SDL_Surface *background;
 SDL_Surface *spacecraft;
 SDL_Surface *spacecraft_thrust;
 SDL_Surface *spacecraft_crash;
 SDL_Surface *spacecraft_landing;
 SDL_Surface *Font;
 SDL_Event event;
 Uint8 *keystate;
 SDL_Rect src, dest;
 
 struct timeval tv1,tv2;
 struct timezone tz;
 long long diff; 
 
 int angle=20;
 int v_x=0,v_y=0,alt=1460; /*v_*:velocity, alt:altitude above ground level */
 unsigned int p_x=320,i=0; /*p_x:background x position, i:counter	   */
 int status[5]; 	   /*status messages (altitude, inclination, ...)  */

void init(void)
{
 /* Loading and initializing data */
 atexit(SDL_Quit);
 
 if(SDL_Init(SDL_INIT_VIDEO) < 0){printf("Error:%s\n",SDL_GetError()); exit(1);}

 screen = SDL_SetVideoMode(640,480,16,0);
 if(screen==NULL){ printf("Error:%s\n", SDL_GetError()); exit(1);}
 
 background = IMG_Load("/usr/share/games/LSL/background.png");
 if(background==NULL)background = IMG_Load("background.png");
 if(background==NULL){printf("Error:%s\n", SDL_GetError()); exit(1);}
 
 spacecraft = IMG_Load("/usr/share/games/LSL/shuttle.png");
 if(spacecraft==NULL)spacecraft = IMG_Load("shuttle.png");
 if(spacecraft==NULL){ printf("Error:%s\n", SDL_GetError()); exit(1);}
 SDL_SetColorKey(spacecraft,SDL_SRCCOLORKEY,SDL_MapRGB(spacecraft->format,0,0,255));

 spacecraft_crash = IMG_Load("/usr/share/games/LSL/shuttle_crash.png");
 if(spacecraft_crash==NULL)spacecraft_crash = IMG_Load("shuttle_crash.png");
 if(spacecraft_crash==NULL){ printf("Error:%s\n", SDL_GetError()); exit(1);}
 SDL_SetColorKey(spacecraft_crash,SDL_SRCCOLORKEY,SDL_MapRGB(spacecraft_crash->format,0,0,255));

 spacecraft_landing = IMG_Load("/usr/share/games/LSL/shuttle_landing.png");
 if(spacecraft_landing==NULL)spacecraft_landing = IMG_Load("shuttle_landing.png");
 if(spacecraft_landing==NULL){ printf("Error:%s\n", SDL_GetError()); exit(1);}
 SDL_SetColorKey(spacecraft_landing,SDL_SRCCOLORKEY,SDL_MapRGB(spacecraft_landing->format,0,0,255));

 intro = IMG_Load("/usr/share/games/LSL/intro.png");
 if(intro==NULL)intro = IMG_Load("intro.png");
 if(intro==NULL){ printf("Error:%s\n", SDL_GetError()); exit(1);}

 SDL_WM_SetCaption("Linux Shuttle Lander"," "); 
 
 Font=IMG_Load("/usr/share/games/LSL/font.png");
 if(Font==NULL)Font = IMG_Load("font.png");
 if(Font==NULL){ printf("Error:%s\n", SDL_GetError()); exit(1);}

 InitFont(Font);

/* The introduction screen */
src.x=0;
src.y=0;
src.w=background -> w;
src.h=background -> h;
  
dest=src;
	 
SDL_BlitSurface(intro,&src,screen,&dest);

PutString(screen,400,0,"Linux Shuttle Lander");
SDL_UpdateRect(screen, 0, 0, 0, 0);

SDL_Delay(2000);	

}
void overshoot(void)
{
	PutString(screen,300,200,"Overshoot!");
	SDL_UpdateRect(screen,0,0,0,0);
	SDL_Delay(1000);
	exit(0);
}
		
void crash(void)
{
 src.x=p_x-320;
 src.y=1460;
 src.w=640;
 src.h=480;
 
 dest.x=0;
 dest.y=0;
 dest.w=640;
 dest.h=480;
 
 SDL_BlitSurface(background,&src,screen,&dest);

 src.x=0;
 src.y=0;
 src.w=100;
 src.h=50;
  
 dest.x=320;
 dest.y=430;
 dest.w=100;
 dest.h=50;
 
 SDL_BlitSurface(spacecraft_crash,&src,screen,&dest);
 
 PutString(screen,300,100,"Crash!");
 
 SDL_UpdateRect(screen,0,0,0,0);

 SDL_Delay(1000);
 exit(0);
}

void landing(void)
{
  
 for(p_x=130;p_x<640;p_x+=5)
 {
 src.x=1600;
 src.y=1460;
 src.w=700;
 src.h=480;
  
 dest.x=0;
 dest.y=0;
 dest.w=700;
 dest.h=480;
	 
 SDL_BlitSurface(background,&src,screen,&dest);
 
 src.x=0;
 src.y=0;
 src.w=120;
 src.h=50;
 	 
 dest.x=p_x;
 dest.y=415;
 dest.w=spacecraft -> w;
 dest.h=spacecraft -> h;

 SDL_BlitSurface(spacecraft_landing,&src,screen,&dest);
 SDL_UpdateRect(screen,0,0,0,0);
 }
 
 
 PutString(screen,300,100,"Nice landing.");
 
 snprintf(status, 50, "%d Points",2000-10*v_y-p_x/40-50*i);
 PutString(screen,300,200,status);
  
 SDL_UpdateRect(screen,0,0,0,0);

 SDL_Delay(3000);
 exit(0);
}

void input(void)
{
 SDL_PumpEvents(); 
 keystate=SDL_GetKeyState(NULL);
 if(keystate[SDLK_LEFT]) {angle+=10; i++;}
 if(keystate[SDLK_RIGHT]){angle-=10; i++;}
 if(keystate[SDLK_q])exit(0);
}

void physics(void)
{
 if(angle<-60) angle=-60;    
 if(angle>60) angle=60;

 v_x=10+abs(sin(angle));
 v_y=1+2*abs(angle/3);

 p_x+=v_x; if(p_x>1780) overshoot();
 alt-=v_y; 
 	if(alt<=0)
	{
		if((p_x>1700) && (p_x<1780) && (angle=10)) landing();	
		else crash();
	}
}

void display(void)
{
 /* Displaying the background */
 
 src.x=p_x-320; if(src.x>1600) src.x=1600;
 src.y=1910-alt-450;
 src.w=640;
 src.h=480;
  
 dest.x=0;
 dest.y=0;
 dest.w=640;
 dest.h=480;
 
 SDL_BlitSurface(background,&src,screen,&dest);
 
 /* Displaying the spacecraft */
 src.x=600-10*angle;
 src.y=0;
 src.w=100;
 src.h=50;
 	 
 dest.x=320;
 dest.y=430;
 dest.w=spacecraft -> w;
 dest.h=spacecraft -> h;
	
 SDL_BlitSurface(spacecraft,&src,screen,&dest);

 /* Displaying spacecraft status */
 snprintf(status, 50, "ALT: %dm",alt);
 PutString(screen,450,0,status);
 
 snprintf(status, 50, "INC: %dDEG",angle);
 PutString(screen,450,20,status);
  
 snprintf(status, 50, "RW DIST: %dm",1700-p_x);
 PutString(screen,450,40,status);
 
 SDL_UpdateRect(screen,0,0,0,0);
}

void loop(void)
{
 gettimeofday(&tv1,&tz);
 input();
 physics();
 display();
 gettimeofday(&tv2,&tz);
 diff=(tv2.tv_sec-tv1.tv_sec)*1000000L + (tv2.tv_usec-tv1.tv_usec);

 	while(diff<56000)
	{
 	 gettimeofday(&tv2,&tz);
 	 diff=(tv2.tv_sec-tv1.tv_sec)*1000000L + (tv2.tv_usec-tv1.tv_usec);
 	}
 /* printf("%d usec\n",diff); */

}
void main(void)
{
 init();
 while(1)loop();
}

	 
	 
