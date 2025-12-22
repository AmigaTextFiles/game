/***************************************************************************
                          kurve.cpp  -  description
                             -------------------
    begin                : Tue Oct 5 2004
    copyright            : (C) 2004 by Jakub Judas
    email                : 
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "SDL.h"
#include "sdlkurve.h"
#define RND RAND_MAX/200
#define  numworms 5
SDL_Surface *screen;
SDL_Surface *worms=NULL;
SDL_Surface *worm;
SDL_Surface *numbers;
SDL_Surface *background;
SDL_Surface *login;
SDLKey keypressed;
kurve Worm[numworms];
bool play;
bool exitprog;
bool fullscreen;
bool nowall=false;
bool menu=true;
char bgname[256];
char wormname[256];
char numname[256];
char loginname[256];

int tick,oldtick=0,wormsalive=0,wormsactive=0;
void Keyboard(SDLKey,bool);
void SetWorms(void);

void LoadTheme(char*);
int main(int argc, char *argv[]){	printf("Sdlkurve - a cross platform remake of the old \"Achtung, die kurve\" game \nmade by Jakub Judas 2004\n");
	sprintf(bgname,"./background.bmp");
	sprintf(wormname,"./worm.bmp");
	sprintf(numname,"./numbers.bmp");
	sprintf(loginname,"./login.bmp");
  SDL_Init(SDL_INIT_VIDEO|SDL_INIT_TIMER);
  
  for(int i=1;i<argc;i++){
	 
	  if(strcmp(argv[i],"-f")==0) fullscreen=true;
	  else if(strcmp(argv[i],"-nowall")==0) nowall=true;
	  else if(strcmp(argv[i],"-b")==0){
		  memset(bgname,0,256);
          sprintf(bgname,"%s",argv[i+1]);
		  i++;
		  continue;
	  }
	  else if(strcmp(argv[i],"-w")==0){
		  memset(wormname,0,256);
          sprintf(wormname,"%s",argv[i+1]);
		  i++;
		  continue;
	  }
	  else if(strcmp(argv[i],"-n")==0){
		  memset(numname,0,256);
          sprintf(numname,"%s",argv[i+1]);
		  i++;
		  continue;
	  }
	  else if(strcmp(argv[i],"-w")==0){
		  memset(loginname,0,256);
          sprintf(loginname,"%s",argv[i+1]);
		  i++;
		  continue;
	  }
	  else if(strcmp(argv[i],"-theme")==0){
		  LoadTheme(argv[i+1]);
		  i++;
		  continue;
	  }
	  else printf("Unknown parameter %s\n",argv[i]);

  }
  if(fullscreen) screen=SDL_SetVideoMode(640,480,16,SDL_HWSURFACE|SDL_FULLSCREEN);
  else screen=SDL_SetVideoMode(640,480,16,SDL_HWSURFACE);
  
  if((worm=SDL_LoadBMP(wormname))==NULL) {
  	printf("Error loading worm sprites - file %s probably doesn't exist\n",wormname);
	SDL_Quit();
	return 0;
	}
  if((background=SDL_LoadBMP(bgname))==NULL) {
 	printf("Error loading background - file %s probably doesn't exist\n",wormname);
	SDL_Quit();
	return 0;
	}
  if((numbers=SDL_LoadBMP(numname))==NULL) {
 	printf("Error loading numbers - file %s probably doesn't exist\n",wormname);
	SDL_Quit();
	return 0;
	}

  if((login=SDL_LoadBMP(loginname))==NULL) {
  	printf("Error loading login screen - file %s probably doesn't exist\n",wormname);
	SDL_Quit();
	return 0;
	}




   
  SDL_SetColorKey(worm,SDL_SRCCOLORKEY,0x000000);
  SDL_ShowCursor(SDL_DISABLE);

  
  SDL_Rect rcrect; rcrect.x=0; rcrect.y=0; rcrect.h=480; rcrect.w=640; SDL_BlitSurface(login,&rcrect,screen,NULL);
  
  
  SDL_Event event;
  while(!exitprog){
    if(SDL_PollEvent(&event)){
    switch(event.type){
      case SDL_KEYDOWN:
              Keyboard(event.key.keysym.sym,1);
          
             break;
      case SDL_KEYUP:
             Keyboard(event.key.keysym.sym,0);
            
             
             break;
	  case SDL_MOUSEBUTTONDOWN:
		  switch(event.button.button){
			case SDL_BUTTON_LEFT:
				    if(play) Worm[4].leftpressed=1;
                    else Worm[4].active=1;
					break;
			case SDL_BUTTON_RIGHT:
				    if(play) Worm[4].rightpressed=1;
                    else Worm[4].active=1;
			break;
		  }
		  break;
		case SDL_MOUSEBUTTONUP:
		  switch(event.button.button){
			case SDL_BUTTON_LEFT:
				    if(play) Worm[4].leftpressed=0;
					break;
			case SDL_BUTTON_RIGHT:
				    if(play) Worm[4].rightpressed=0;
                    
			break;
		  }
		  break;
      
      case SDL_QUIT:
		  exitprog=1;
     
      break;
      
      }
      }
      else{
        Update();
        }
    
    }

  
  SDL_FreeSurface(worm);
  SDL_FreeSurface(worms);
  SDL_FreeSurface(background);
  SDL_FreeSurface(numbers);
  SDL_FreeSurface(login);
  SDL_Quit();

  printf("SCORE:"); 
  int highestscore=0;
  int winner=0;
  for(int i=0;i<numworms;i++){
	  if(Worm[i].active){
		  printf("Player %d:%d\n",i,Worm[i].points);
		  if(Worm[i].points>highestscore){
			  highestscore=Worm[i].points;
			  winner=i;
		  }
	  }
  }
  printf("Player %d wins\nPress enter to exit\n",winner);
  getchar();

  return 0;
  
    
  }
  void Update(void){
	tick=SDL_GetTicks();
	if(tick>oldtick+16){
    oldtick=tick;
	if(play){
	for(int i=0;i<numworms;i++){
    if(Worm[i].alive&&Worm[i].active){
    if(Worm[i].leftpressed){
        Worm[i].angle+=0.04;
		Worm[i].ax=sin(Worm[i].angle);
		Worm[i].ay=cos(Worm[i].angle);
      }
      if(Worm[i].rightpressed){
          Worm[i].angle-=0.04;
          Worm[i].ax=sin(Worm[i].angle);
          Worm[i].ay=cos(Worm[i].angle);
        }

    Worm[i].fx+=Worm[i].ax;
    Worm[i].fy+=Worm[i].ay;
    Worm[i].x=(int)Worm[i].fx;
    Worm[i].y=(int)Worm[i].fy;
    SDL_Rect dstrect,rcrect;



	dstrect.x=Worm[i].x;
	  dstrect.y=Worm[i].y;
	  dstrect.w=4;
	  dstrect.h=4;
	  rcrect.x=i<<2;
	  rcrect.y=0;
	  rcrect.h=4;
	  rcrect.w=4;

    

    SDL_LockSurface(worms);
   



	 
   Uint8 *p=(Uint8*)worms->pixels+(int)(Worm[i].fy+2+(Worm[i].ay*4))*worms->pitch+(int)(Worm[i].fx+2+(Worm[i].ax*4))*2;


	  if(Worm[i].fx>=634&&nowall) Worm[i].fx=5;
	  if(Worm[i].fy>=474&&nowall) Worm[i].fy=5;
	  if(Worm[i].fx<4&&nowall)	 Worm[i].fx=633;
	  if(Worm[i].fy<4&&nowall)    Worm[i].fy=473;
	  if((((Worm[i].x>=635)||(Worm[i].y>=475)||(Worm[i].x<=0)||(Worm[i].y<=0))&&!nowall)||*(unsigned short*)p){
		  Worm[i].alive=false;
		  wormsalive--;


		  for(int j=0;j<numworms;j++){
			  if(Worm[j].alive){
				  if((Worm[j].points++)>=(wormsactive-1)) exitprog=1;
				  sprintf(Worm[j].pointshow,"%02d",Worm[j].points);
				  Worm[j].pointshow[0]-=48;
				  Worm[j].pointshow[1]-=48;
			  }
		  }
		  if(wormsalive<=1) {
		  play=0;
		  SDL_UnlockSurface(worms);
		  

		  return;
		  }


	  }


	  SDL_UnlockSurface(worms);
	



	  if(rand()<RND){
		  Worm[i].hole=rand()&0xf;
	  }
	 
	  if(Worm[i].hole==0){
    SDL_BlitSurface(worm,&rcrect,worms,&dstrect);
	SDL_BlitSurface(worm,&rcrect,screen,&dstrect);
	  }
	  else{
		  Worm[i].hole--;
		  rcrect.x=0;
		  rcrect.y=4;
		  rcrect.h=4;
		  rcrect.w=4;
		  SDL_BlitSurface(worm,&rcrect,screen,&dstrect);
	  }
    }

	
	if(Worm[i].active){
	SDL_Rect rcrect = { (Worm[i].pointshow[0])<<3,i<<4,8,16 };
	SDL_Rect destrect = { 0,i<<4,8,16 };

	SDL_BlitSurface(numbers,&rcrect,screen,&destrect);
	rcrect.x=Worm[i].pointshow[1]<<3;
	destrect.x=8;
	
	SDL_BlitSurface(numbers,&rcrect,screen,&destrect);
	}

	}
    }


	else if(menu){
		SDL_Rect rcrect;
		SDL_Rect dstrect;
		for(int i=0; i<numworms;i++){
			if(Worm[i].active){
				rcrect.x=i<<3;rcrect.y=i<<4;rcrect.h=16;rcrect.w=8;dstrect.x=(i<<4)+160;dstrect.y=238;dstrect.h=16;dstrect.w=8;
				SDL_BlitSurface(numbers,&rcrect,screen,&dstrect);

			}
		}
	}
	
	  SDL_UpdateRect(screen,0,0,640,480);
	}
	  
    }
    void Keyboard(SDLKey key,bool enable){
      switch(key){
             case SDLK_LEFT:
				 if(play) Worm[0].leftpressed=enable;
                 else Worm[0].active=1;
				 break;
             case SDLK_DOWN:
                if(play) Worm[0].rightpressed=enable;
				else Worm[0].active=1;
                break;
             case SDLK_1:
				 if(play) Worm[1].leftpressed=enable;
                 else Worm[1].active=1;
				 break;
             case SDLK_q:
                 if(play) Worm[1].rightpressed=enable;
				 else Worm[1].active=1;
                 break;
			 case SDLK_LCTRL:
                 if(play) Worm[2].leftpressed=enable;
				 else Worm[2].active=1;
				 break;
			 case SDLK_LALT:
				 if(play) Worm[2].rightpressed=enable;
				 else Worm[2].active=1;
				 break;
			 case SDLK_KP_DIVIDE:
                 if(play) Worm[3].leftpressed=enable;
				 else Worm[3].active=1;
				 break;
			 case SDLK_KP_MULTIPLY:
				 if(play) Worm[3].rightpressed=enable;
				 else Worm[3].active=1;
				
                break;
			 
			 case SDLK_SPACE:
				 if(!play){
				 play=1;
				 menu=0;
				 SetWorms();
				 }
				 break;
			  case SDLK_ESCAPE:
			      exitprog=1;
			      return;

             default:
              break;
             }

      }
	void SetWorms(void){
		wormsalive=0;
		wormsactive=0;
		for(int i=0;i<numworms;i++){
			if(Worm[i].active){
			if((Worm[i].fx=(rand()&255)*2)>600) Worm[i].fx=600;
			if((Worm[i].fy=(rand()&255)*2)>400) Worm[i].fy=400;
			Worm[i].x=Worm[i].fx;
			Worm[i].y=Worm[i].fy;
			Worm[i].angle=(double)(rand()&255)/100;
			Worm[i].alive=true;
			Worm[i].ax=sin(Worm[i].angle);
			Worm[i].ay=cos(Worm[i].angle);
			Worm[i].leftpressed=false;
			Worm[i].rightpressed=false;
			wormsalive++;
			wormsactive+=10;
			}
			
			
			

			
		}
		wormsactive-=10;
		SDL_Rect rcrect;
		rcrect.x=0; rcrect.y=0; rcrect.h=480; rcrect.w=640;
		SDL_BlitSurface(background,&rcrect,screen,&rcrect);
		if(worms!=NULL) SDL_FreeSurface(worms);
		worms=SDL_CreateRGBSurface(SDL_SWSURFACE,640,480,16,0,0,0,0);
	}
	void LoadTheme(char* filename){
		FILE *f;
		
			
		char string[256];
		char string2[256];
		f=fopen(filename,"r");
		while(strcmp(string,"END")!=0){
			fscanf(f,"%s",string);
			fscanf(f," = %s",string2);
			if(strcmp(string,"background")==0)	sprintf(bgname,string2);
			if(strcmp(string,"worm")==0)		sprintf(wormname,string2);
			if(strcmp(string,"numbers")==0)		sprintf(numname,string2);
			if(strcmp(string,"login")==0)		sprintf(loginname,string2);
			if(strcmp(string,"name")==0)		printf("Theme name: %s\n",string2);
			if(strcmp(string,"author")==0)		printf("Theme author: %s\n",string2);
			printf("%s = %s\n", string, string2);

			

		}
		fclose(f);

	}
