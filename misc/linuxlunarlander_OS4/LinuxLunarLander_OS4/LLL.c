/* Linux Lunar Lander 
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
//#include <tgmath.h>
#include <SDL/SDL.h>
#include "SFont.h"
#include "SDL_image.h"

#define G 1			
#define FUEL 200		
#define MAX_V_Y 10
#define MAX_V_X 3
#define MAX_ANGLE 10


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
 
 int angle=0,thrust=0,thrust_x=0,thrust_y=0;
 int v_x=5,v_y=0,fuel=FUEL,p_x=0;
 unsigned int p_y=400;
 int status[5];


void init(void)
{
 
 /* Loading and initializing data */

 atexit(SDL_Quit);
 
 if(SDL_Init(SDL_INIT_VIDEO) < 0){printf("Error:%s\n",SDL_GetError()); exit(1);}

 screen = SDL_SetVideoMode(640,480,16,0);
 if(screen==NULL){ printf("Error:%s\n", SDL_GetError()); exit(1);}
 
 background = IMG_Load("/usr/share/games/LLL/background.png");
 if(background==NULL){background = IMG_Load("background.png");}
 if(background==NULL){printf("Error:%s\n", SDL_GetError()); exit(1);}
 
 spacecraft = IMG_Load("/usr/share/games/LLL/eagle.png");
 if(spacecraft==NULL){spacecraft = IMG_Load("eagle.png");}
 if(spacecraft==NULL){printf("Error:%s\n", SDL_GetError()); exit(1);}
 SDL_SetColorKey(spacecraft,SDL_SRCCOLORKEY,SDL_MapRGB(spacecraft->format,0,0,255));

 spacecraft_thrust = IMG_Load("/usr/share/games/LLL/eagle_thrust.png");
 if(spacecraft_thrust==NULL){spacecraft_thrust=IMG_Load("eagle_thrust.png");}
 if(spacecraft_thrust==NULL){ printf("Error:%s\n", SDL_GetError()); exit(1);}
 SDL_SetColorKey(spacecraft_thrust,SDL_SRCCOLORKEY,SDL_MapRGB(spacecraft->format,0,0,255));

 spacecraft_crash = IMG_Load("/usr/share/games/LLL/eagle_crash.png");
 if(spacecraft_crash==NULL){spacecraft_crash = IMG_Load("eagle_crash.png");}
 if(spacecraft_crash==NULL){ printf("Error:%s\n", SDL_GetError()); exit(1);}
 SDL_SetColorKey(spacecraft_crash,SDL_SRCCOLORKEY,SDL_MapRGB(spacecraft->format,0,0,255));

 spacecraft_landing = IMG_Load("/usr/share/games/LLL/eagle_landing.png");
 if(spacecraft_landing==NULL){spacecraft_landing = IMG_Load("eagle_landing.png");}
 if(spacecraft_landing==NULL){ printf("Error:%s\n", SDL_GetError()); exit(1);}
 SDL_SetColorKey(spacecraft_landing,SDL_SRCCOLORKEY,SDL_MapRGB(spacecraft->format,0,0,255));

 intro = IMG_Load("/usr/share/games/LLL/intro.png");
 if(intro==NULL){intro = IMG_Load("intro.png");}
 if(intro==NULL){printf("Error:%s\n", SDL_GetError()); exit(1);}

 SDL_WM_SetCaption("Linux Lunar Lander"," "); 
 
 Font=IMG_Load("/usr/share/games/LLL/font.png");
 if(Font==NULL){Font=IMG_Load("font.png");}
 if(Font==NULL){printf("Error:%s\n", SDL_GetError()); exit(1);}

 InitFont(Font);

/* The introduction screen */
src.x=0;
src.y=0;
src.w=background -> w;
src.h=background -> h;
  
dest=src;
	 
SDL_BlitSurface(intro,&src,screen,&dest);

PutString(screen,400,0,"Linux Lunar Lander");
PutString(screen,150,450,"Use arrows to pilot the Lunar Module");
SDL_UpdateRect(screen, 0, 0, 0, 0);

SDL_Delay(2000);	

}

void crash(void)
{
 src.x=0;
 src.y=0;
 src.w=50;
 src.h=50;
 	 
 dest.x=p_x;
 dest.y=410;
 dest.w=spacecraft -> w;
 dest.h=spacecraft -> h;
 
 SDL_BlitSurface(spacecraft_crash,&src,screen,&dest);
 
 PutString(screen,200,100,"Houston, we have a problem!");
 
 SDL_UpdateRect(screen,0,0,0,0);
}

void landing(void)
{
 src.x=0;
 src.y=0;
 src.w=100;
 src.h=50;
 	 
 dest.x=p_x;
 dest.y=p_y-400;
 dest.w=spacecraft -> w;
 dest.h=spacecraft -> h;
 
 SDL_BlitSurface(spacecraft_landing,&src,screen,&dest);

 PutString(screen,220,100,"The Penguin has landed!");
 
 snprintf((char*) status, 50, "%d Points",abs(200+fuel-10*(v_y+v_x+angle))+(400-abs(400-p_x))*10);
 PutString(screen,300,200,(char*) status);
  
 SDL_UpdateRect(screen,0,0,0,0);

 SDL_Delay(3000);
}

void end(void)
{
 src.x=0;
 src.y=0;
 src.w=background -> w;
 src.h=background -> h;
  
 dest=src;
	 
 SDL_BlitSurface(background,&src,screen,&dest);

 if( (v_y>MAX_V_Y) || (abs(v_x)>MAX_V_X) || (angle>abs(MAX_ANGLE)) )crash();
 else landing();
 SDL_Delay(1000);
 exit(0);
}

void input(void)
{
 SDL_PumpEvents(); 
 keystate=SDL_GetKeyState(NULL);
 if(keystate[SDLK_LEFT]) angle-=10; 
 if(keystate[SDLK_RIGHT]) angle+=10;
 thrust=0;
 if(keystate[SDLK_UP]) thrust=3;	
}

void physics(void)
{
 if(angle<-90)angle=-90;    
 if(angle>90)angle=90;
  
 fuel-=thrust;
 fuel=(fuel>0)*fuel;
 thrust=(fuel>0)*thrust;
 
 thrust_x=abs(sin(angle)*thrust); 
 thrust_y=abs(cos(angle)*thrust);
   
 if(angle<0)v_x-=thrust_x; else v_x+=thrust_x;
 v_y+=G-thrust_y;

 p_x+=v_x;
 p_y+=v_y;

 if(p_x<=0)p_x+=640;
 if(p_x>=640)p_x-=640; 
 
}

void display(void)
{
 /* Displaying the background */
 src.x=0;
 src.y=0;
 src.w=background -> w;
 src.h=background -> h;
  
 dest=src;
	 
 SDL_BlitSurface(background,&src,screen,&dest);
	
 
 /* Displaying the spacecraft */
 src.x=450+5*angle; /* Displaying the spacecraft at the right angle */
 src.y=0;
 src.w=50;
 src.h=50;
 	 
 dest.x+=p_x;
 dest.y+=p_y-400;
 dest.w=spacecraft -> w;
 dest.h=spacecraft -> h;
	
 if(thrust==0) SDL_BlitSurface(spacecraft,&src,screen,&dest);
 else SDL_BlitSurface(spacecraft_thrust,&src,screen,&dest);

 /* Displaying spacecraft status */
 snprintf((char*) status, 50, "FUEL: %dkg",fuel);
 PutString(screen,1,0,(char*) status);

 snprintf((char*) status, 50, "ALT: %dm",810-p_y);
 PutString(screen,1,20,(char*) status);
  
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
/*printf("%d usec\n",diff);*/

}

int main(void)
{
 init();
 while(dest.y<410)loop();
 end();
}

	 
	 
