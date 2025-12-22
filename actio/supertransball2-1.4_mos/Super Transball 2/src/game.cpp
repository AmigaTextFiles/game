#ifdef _WIN32
#include "windows.h"
#else
#include <stddef.h>
#include <sys/types.h>
#include <dirent.h>
#include "ctype.h"
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "SDL/SDL.h"
#include "SDL_mixer.h"
#include "SDL_image.h"

#include "fonts.h"
#include "list.h"
#include "auxiliar.h"

#include "tiles.h"
#include "maps.h"
#include "transball.h"

#include "encoder.h"

#define MAXLEVELS	64

int NLEVELS=-1;


extern int SCREEN_X,SCREEN_Y;
int STATE=0,SUBSTATE=0,SUBSTATE2=0;
int level=0,timer=0;
int ship_type=1;

/* Statistics: */ 
extern int fuelfactor[3];
int used_fuel=0,remaining_fuel=0;
int n_shots=0,n_hits=0,enemies_destroyed=0;
int previous_high=-1;

char *levelnames[MAXLEVELS]={0,0,0,0,0,0,0,0,
							 0,0,0,0,0,0,0,0,
							 0,0,0,0,0,0,0,0,
							 0,0,0,0,0,0,0,0,
							 0,0,0,0,0,0,0,0,
							 0,0,0,0,0,0,0,0,
							 0,0,0,0,0,0,0,0,
							 0,0,0,0,0,0,0,0};
char *leveltext[MAXLEVELS]={0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0};
char *levelcode[MAXLEVELS]={0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0};
int initialfuel[MAXLEVELS]={0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0,
							0,0,0,0,0,0,0,0};

/* Game: */ 
/* playmode = 0 : normal */ 
/* playmode = 1 : recording */ 
/* playmode = 0 : replaying */ 
extern TRANSBALL *game;

/* Frames per second counter: */ 
extern int frames_per_sec;

FILE *replayfile;
int replaynum;
int replay_source=0;


SDLKey THRUST_KEY=SDLK_q,ANTITHRUST_KEY=SDLK_a,LEFT_KEY=SDLK_o,RIGHT_KEY=SDLK_p;
SDLKey FIRE_KEY=SDLK_SPACE,ATRACTOR_KEY=SDLK_RETURN;
SDLKey PAUSE_KEY=SDLK_F1;
bool pause=false;

unsigned char old_keyboard[322];
SDL_Surface *image=0,*image2=0;	/* For the tittle screen, etc. */ 

/* Edit variables: */ 
char edit_text[80];
int edit_position;

/* Replay variables: */ 
List<char> files;
int act_file;
int first_file;
bool refind_files;

/* Demo variables: */ 
int demotimer;
bool demoon;
int tittle_alpha;

/* Actual level-pack: */ 
List<char> levelpacks;
int act_levelpack;
char levelpack[256]="transball.lp";


bool gamecycle(SDL_Surface *screen,int sx,int sy)
{
	int i;
	unsigned char *keyboard;
	SDL_PumpEvents();
	keyboard = SDL_GetKeyState(NULL);

	if (NLEVELS==-1) {
		/* Load level info: */ 
		FILE *fp;
		char tmp[256];

		strcpy(tmp,"maps/");
		strcat(tmp,levelpack);

		decode(tmp,"decoding.tmp");

		fp=fopen("decoding.tmp","r+");
		if (fp!=0) {
			fscanf(fp,"%i",&NLEVELS);

			for(i=0;i<NLEVELS;i++) {
				fscanf(fp,"%s %s",tmp,tmp);
				if (levelnames[i]!=0) delete levelnames[i];
				levelnames[i]=new char[strlen(tmp)+1];
				strcpy(levelnames[i],tmp);

				fscanf(fp,"%s ",tmp);
				fgets(tmp,128,fp);
				if (leveltext[i]!=0) delete leveltext[i];
				leveltext[i]=new char[strlen(tmp)+1];
				strcpy(leveltext[i],tmp);

				fscanf(fp,"%s %s",tmp,tmp);
				if (levelcode[i]!=0) delete levelcode[i];
				levelcode[i]=new char[strlen(tmp)+1];
				strcpy(levelcode[i],tmp);

				fscanf(fp,"%s %i",tmp,&initialfuel[i]);
			} /* for */ 

			fclose(fp);
		} /* if */ 

		remove("decoding.tmp");
	} /* if */ 

	if (NLEVELS==-1) return false;

	switch(STATE) {
	case 0:
		/* Logo Brain + presents + Transball 2: */ 
		if (SUBSTATE==0) {
			load_configuration();

			if (image!=0) SDL_FreeSurface(image);
			image=IMG_Load("graphics/brain.pcx");
		} /* if */ 
		SDL_BlitSurface(image,0,screen,0);
		font_print_centered(sx/2,sy-64,"PRESENTS",screen);

		if (SUBSTATE<32) {
			surface_fader(screen,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F);
			SUBSTATE++;
		} /* if */ 
		if (SUBSTATE==32) {
			if (keyboard[FIRE_KEY] && !old_keyboard[FIRE_KEY]) SUBSTATE++;
		} /* if */ 
		if (SUBSTATE>32) {
			surface_fader(screen,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F);
			SUBSTATE++;
			if (SUBSTATE==64) {
				SDL_FreeSurface(image);
				image=0;

				STATE=1;
				SUBSTATE=0;
			} /* if */ 
		} /* if */ 
		break;

	case 1:
		/* Main menu: */ 
		if (SUBSTATE==0) {
			if (image!=0) SDL_FreeSurface(image);
			image=IMG_Load("graphics/tittle.pcx");
			SDL_SetColorKey(image,SDL_SRCCOLORKEY,SDL_MapRGB(image->format,0,0,0));
			demotimer=0;
			demoon=false;
		} /* if */ 

		if (demoon) {
			int retval;
			int i;
			unsigned char tmp[322];

			for(i=0;i<322;i++) tmp[i]=0;
			tmp[THRUST_KEY]=fgetc(replayfile);
			tmp[ANTITHRUST_KEY]=fgetc(replayfile);
			tmp[LEFT_KEY]=fgetc(replayfile);
			tmp[RIGHT_KEY]=fgetc(replayfile);
			tmp[FIRE_KEY]=fgetc(replayfile);
			tmp[ATRACTOR_KEY]=fgetc(replayfile);
			game->cycle(tmp);
			retval=fgetc(replayfile);

			game->render(screen,sx,sy);

			if (retval!=0) {
				delete game;
				game=0;

				fclose(replayfile);
				replayfile=0;
				demoon=false;
			} /* if */ 
		} else {
			SDL_FillRect(screen,0,0);
		} /* if */ 

		if (demoon) {
			SDL_SetAlpha(image,SDL_SRCALPHA,tittle_alpha--);
			if (tittle_alpha<=0) tittle_alpha=0;
		} else {
			SDL_SetAlpha(image,SDL_SRCALPHA,tittle_alpha);
			tittle_alpha+=2;
			if (tittle_alpha>=255) tittle_alpha=255;
		} /* if */ 
		SDL_BlitSurface(image,0,screen,0);
		font_print(SCREEN_X/2-52,sy-72,"FIRE - START GAME",screen);
		font_print(SCREEN_X/2-52,sy-64," C   - ENTER CODE",screen);
		font_print(SCREEN_X/2-52,sy-56," L   - CHANGE LEVEL-PACK",screen);
		font_print(SCREEN_X/2-52,sy-48," K   - REDEFINE KEYBOARD",screen);
		font_print(SCREEN_X/2-52,sy-40," I   - INSTRUCTIONS",screen);
		font_print(SCREEN_X/2-52,sy-32," R   - REPLAYS",screen);
		font_print(SCREEN_X/2-52,sy-24,"ESC  - QUIT GAME",screen);

		if (SUBSTATE<32) {
			surface_fader(screen,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F);
			SUBSTATE++;
		} /* if */ 
		if (SUBSTATE==32) {
			if (!demoon) demotimer++;
			if (demotimer>=256) {
				int i;
				char tmp[80];
				char levelname[256];
				int fuel;
				int v1,v2;

				
				demoon=true;
				demotimer=0;
				tittle_alpha=255;

				sprintf(tmp,"demos/demo%i.rpl",((rand()%40)/10)+1);
				replayfile=fopen(tmp,"rb");
				v1=fgetc(replayfile);
				v2=fgetc(replayfile);	// To maintain compatibility with a previous version

				level=0;
				for(i=0;i<256;i++) levelname[i]=fgetc(replayfile);
				fuel=fgetc(replayfile);

				ship_type=fgetc(replayfile);
				if (game!=0) delete game;
				game=new TRANSBALL("graphics/","sound/","maps/",fuel,levelname,ship_type);
			} /* if */ 

			if (keyboard[FIRE_KEY] && !old_keyboard[FIRE_KEY]) {
				SUBSTATE++;
				SUBSTATE2=0;
				timer=0;
			} /* if */ 
			if (keyboard[SDLK_ESCAPE] && !old_keyboard[SDLK_ESCAPE]) {
				SUBSTATE++;
				SUBSTATE2=1;
			} /* if */ 
			if (keyboard[SDLK_i] && !old_keyboard[SDLK_i]) {
				SUBSTATE++;
				SUBSTATE2=2;
			} /* if */ 
			if (keyboard[SDLK_c] && !old_keyboard[SDLK_c]) {
				SUBSTATE++;
				SUBSTATE2=3;
			} /* if */ 
			if (keyboard[SDLK_r] && !old_keyboard[SDLK_r]) {
				SUBSTATE++;
				SUBSTATE2=4;
			} /* if */ 
			if (keyboard[SDLK_k] && !old_keyboard[SDLK_k]) {
				SUBSTATE++;
				SUBSTATE2=5;
			} /* if */ 
			if (keyboard[SDLK_l] && !old_keyboard[SDLK_l]) {
				SUBSTATE++;
				SUBSTATE2=6;
			} /* if */ 
		} /* if */ 
		if (SUBSTATE>32) {
			surface_fader(screen,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F);
			SUBSTATE++;
			if (SUBSTATE==64) {
				SDL_FreeSurface(image);
				image=0;

				if (game!=0) delete game;
				game=0;
				if (replayfile!=0) fclose(replayfile);
				replayfile=0;
				demoon=false;
				demotimer=0;

				if (SUBSTATE2==0) {
					int i;

					for(i=0;i<1000;i++) {
						char tmp[80];
						sprintf(tmp,"replays/autoreplay%.3i.rpl",i);
						remove(tmp);
					} /* for */ 

					STATE=4;
					SUBSTATE=0;
					level=0;
					replaynum=0;
				} /* if */ 
				if (SUBSTATE2==1) {
					return false;
				} /* if */ 
				if (SUBSTATE2==2) {
					STATE=2;
					SUBSTATE=0;
				} /* if */ 
				if (SUBSTATE2==3) {
					STATE=3;
					SUBSTATE=0;
					SUBSTATE2=0;
					edit_text[0]=0;
					edit_position=0;
				} /* if */ 
				if (SUBSTATE2==4) {
					STATE=7;
					SUBSTATE=0;
				} /* if */ 
				if (SUBSTATE2==5) {
					STATE=11;
					SUBSTATE=0;
				} /* if */ 
				if (SUBSTATE2==6) {
					STATE=12;
					SUBSTATE=0;
				} /* if */ 
			} /* if */ 
		} /* if */ 
		break;
	case 2:
		/* Instructions: */ 
		if (SUBSTATE==0) {
			if (image!=0) SDL_FreeSurface(image);
			image=IMG_Load("graphics/tittle.pcx");
		} /* if */ 
		SDL_BlitSurface(image,0,screen,0);
		surface_fader(screen,0.5F,0.5F,0.5F);
		if (SUBSTATE<64) {
			font_print(16,10,"              SUPER TRANSBALL 2 V1.4",screen);

			font_print(16,30,"  THE FUTURE, THE SUN DOES NOT SHINE ANYMORE",screen);
			font_print(16,40,"AND THE ONLY ENERGY SOURCE ARE \"THE SPHERES\".",screen);
			font_print(16,50,"THE SPHERES CONTAIN ENOUGH ENERGY FOR A PLANET",screen);
			font_print(16,60,"TO SURVIVE. THEY ARE CHARGED WITH THE ENERGY",screen);
			font_print(16,70,"OF OTHER STARS.",screen);
			font_print(16,90,"  AS THE HUMANS ARE HIGHLY DEPENDENT ON THE",screen);
			font_print(16,100,"SPHERES, AN OPORTUNIST CIVILIZATION HAS STOLEN",screen);
			font_print(16,110,"ALL THE CHARGED SPHERES FROM THE EARTH EXPECTING",screen);
			font_print(16,120,"TO COLONIZE THE PLANET. AS A LAST CHANCE, THE",screen);
			font_print(16,130,"LAST ENERGY HAS BEEN TRANSFERED TO A SCOUT SHIP",screen);
			font_print(16,140,"AND SENT TO RECOVER THE SPHERES...",screen);

			font_print(16,160,"YOU COMMAND THIS SHIP, YOU ARE THE LAST CHANCE",screen);
			font_print(16,170,"FOR THE SURVIVAL OF THE HUMAN RACE...",screen);
		} /* if */ 
		if (SUBSTATE>64 && SUBSTATE<128) {
			font_print(16,10,"                SUPER TRANSBALL 2",screen);

			font_print(16,30,"  THE CONTROLS OF THE SHIP ARE [REDEFINIBLE]:",screen);
			font_print(16,50,"    Q   - PROPULSORS",screen);
			font_print(16,60,"    A   - RETROPROPULSORS [NOT ALL THE SHIPS]",screen);
			font_print(16,70,"    O   - TURN LEFT",screen);
			font_print(16,80,"    P   - TURN RIGHT",screen);
			font_print(16,90,"  SPACE - FIRE",screen);
			font_print(16,100,"  ENTER - BALL ATRACTOR",screen);

			font_print(16,120,"TO ACHIEVE YOUR GOAL, YOU CAN CHOOSE BETWEEN",screen);
			font_print(16,130,"THREE DIFFERENT SHIPS, EACH ONE WITH ITS OWN",screen);
			font_print(16,140,"CHARACTERISTICS:",screen);
			font_print(16,160," THE SHADOW RUNNER: HIGH SPEED, FEW WEAPONS",screen);
			font_print(16,170," THE V-PANTHER 2  : MEDIUM SPEED, MEDIUM WEAPONS",screen);
			font_print(16,180," THE X-TERMINATOR : LOW SPEED, DEFINITIVE WEAPONS",screen);
		} /* if */ 

		if (SUBSTATE>128 && SUBSTATE<192) {
			font_print(16,10, "                SUPER TRANSBALL 2",screen);

			font_print(16,30, "GUIDE[1]:",screen);
			font_print(16,50, " - YOUR SHIP IS UNDER THE EFFECT OF THE GRAVITY.",screen);
			font_print(16,60, " - WITH YOUR THRUSTER, YOU MUST AVOID TO COLLIDE",screen);
			font_print(16,70, "   WITH THE BACKGROUND.",screen);
			font_print(16,80, " - YOU MUST FIND THE WHITE BALL, THEN USE THE",screen);
			font_print(16,90, "   ATRACTOR OVER IT DURING A WHILE. IT WILL TURN",screen);
			font_print(16,100,"   BLUE. ",screen);
			font_print(16,110," - WHEN THE BALL IS BLUE, YOUR SHIP ATRACTS IT.",screen);
			font_print(16,120," - TO COMPLETE A LEVEL YOU MUST CARRY THE BALL",screen);
			font_print(16,130,"   TO THE UPPER PART.",screen);
			font_print(16,140," - YOU CAN KILL THE MANY ENEMIES YOU WILL FIND",screen);
			font_print(16,150,"   USING YOUR CANONS, SEVERAL SHOTS ARE NEEDED",screen);
			font_print(16,160,"   TO KILL THE ENEMIES [DEPENDING ON THE SHIP].",screen);
		} /* if */ 

		if (SUBSTATE>192 && SUBSTATE<256) {
			font_print(16,10, "                SUPER TRANSBALL 2",screen);

			font_print(16,30, "GUIDE[2]:",screen);
			font_print(16,50, " - YOU WILL FIND DOORS THAT OPEN OR CLOSE WHEN",screen);
			font_print(16,60, "   YOU TAKE THE BALL.",screen);
			font_print(16,70, " - SOME OTHER DOORS ARE ACTIVATED BY SWITCHES.",screen);
			font_print(16,80, " - TO PRESS A SWITCH, YOU MUST MAKE THE BALL TO",screen);
			font_print(16,90, "   BOUNCE ON IT.",screen);
			font_print(16,100," - YOUR THRUSTER AND WEAPONS USE FUEL, YOU MUST ",screen);
			font_print(16,110,"   RECHARGE IT WHENEVER POSSIBLE.",screen);
			font_print(16,120," - SOME LEVELS MAY SEEM VERY DIFFICULT THE FIRST",screen);
			font_print(16,130,"   TIME, BUT WITH PRACTICE, EVERY LEVEL BECOMES",screen);
			font_print(16,140,"   EASY... :]",screen);
		} /* if */ 

		if (SUBSTATE>256 && SUBSTATE<320) {
			font_print(16,10,"                SUPER TRANSBALL 2",screen);

			font_print(16,30,"THIS GAME IS INSPIRED ON THARA ZHRUSTA FOR THE",screen);
			font_print(16,40,"AMIGA 500, BUT UNFORTUNATELY CANNOT COMPARE WITH",screen);
			font_print(16,50,"IT...",screen);

			font_print(16,100,"                  BRAIN 2002",screen);
			font_print(16,110,"             SANTI ONTA~ON VILLAR",screen);
			font_print(16,120,"         SEE README FILE FOR MORE INFO",screen);
		} /* if */ 
		if ((SUBSTATE%64)<32) {
			surface_fader(screen,float((SUBSTATE%64))/32.0F,float((SUBSTATE%64))/32.0F,float((SUBSTATE%64))/32.0F);
			SUBSTATE++;
		} /* if */ 
		if ((SUBSTATE%64)==32) {
			if (keyboard[FIRE_KEY] && !old_keyboard[FIRE_KEY]) SUBSTATE++;
		} /* if */ 
		if ((SUBSTATE%64)>32) {
			surface_fader(screen,float(64-(SUBSTATE%64))/32.0F,float(64-(SUBSTATE%64))/32.0F,float(64-(SUBSTATE%64))/32.0F);
			SUBSTATE++;
			if (SUBSTATE==320) {
				SDL_FreeSurface(image);
				image=0;

				STATE=1;
				SUBSTATE=0;
			} /* if */ 
		} /* if */ 
		break;

	case 3:
		/* Editing text: For entering a code or renaming a replay */ 
		{
			SDL_Rect r;
			int i;
			int maxlen;

			if (SUBSTATE==0) {
				if (image!=0) SDL_FreeSurface(image);
				image=IMG_Load("graphics/tittle.pcx");
			} /* if */ 

			SDL_BlitSurface(image,0,screen,0);
			i=SUBSTATE;
			if (i>32) i=32;
			surface_fader(screen,float(i)/32.0F,float(i)/32.0F,float(i)/32.0F);

			SUBSTATE++;
			if (SUBSTATE2==0) {
				font_print_centered(sx/2,40,"ENTER LEVEL CODE:",screen);
				maxlen=6;
			} /* if */ 
			if (SUBSTATE2==1) {
				font_print_centered(sx/2,40,"TYPE NEW FILE NAME:",screen);
				maxlen=32;
			} /* if */ 

			rectangle(screen,160-((maxlen+1)*3+2),52,(maxlen+1)*6+4,10,SDL_MapRGB(screen->format,255,255,255));

			font_print(160-(maxlen+1)*3,54,edit_text,screen);
			r.x=160-(maxlen+1)*3+(strlen(edit_text))*6;
			r.y=60;
			r.w=7;
			r.h=1;

			if (((SUBSTATE>>4)&0x01)!=0) SDL_FillRect(screen,&r,SDL_MapRGB(screen->format,255,255,255));

			for(i=0;i<322;i++) {
				if (keyboard[i] && !old_keyboard[i]) {
					if ((i>=SDLK_a && i<=SDLK_z) ||
					    i==SDLK_PERIOD ||
					    (i>=SDLK_0 && i<=SDLK_9)) {
						if (edit_position>=maxlen) edit_position=maxlen-1;
						if (i>=SDLK_a && i<=SDLK_z) edit_text[edit_position++]=(i-SDLK_a)+'a';
						if (i>=SDLK_0 && i<=SDLK_9) edit_text[edit_position++]=(i-SDLK_0)+'0';
						if (i==SDLK_PERIOD) edit_text[edit_position++]='.';
						edit_text[edit_position]=0;
					} /* if */ 
				} /* if */ 
			} /* for */ 

			if (keyboard[SDLK_BACKSPACE] && !old_keyboard[SDLK_BACKSPACE] && edit_position>0) {
				edit_text[--edit_position]=0;
			} /* if */ 

			if (keyboard[SDLK_RETURN] && !old_keyboard[SDLK_RETURN]) {
				SDL_FreeSurface(image);
				image=0;

				if (SUBSTATE2==0) {
					level=0;
					for(i=0;i<NLEVELS;i++) {
						if (strcmp(edit_text,levelcode[i])==0) {
							level=i;
						} /* if */ 
					} /* for */ 
					
					if (level==0) {
						STATE=1;
						SUBSTATE=0;
					} else {
						int i;

						for(i=0;i<1000;i++) {
							char tmp[80];
							sprintf(tmp,"replays/autoreplay%.3i.rpl",i);
							remove(tmp);
						} /* for */ 
						STATE=4;
						SUBSTATE=0;
						replaynum=0;
					} /* if */ 
				} /* if */ 
				if (SUBSTATE2==1) {
					char tmp[80],tmp2[80];
					int i;
					bool found=false;

					for(i=0;i<edit_position && !found;i++) {
						if (edit_text[i]=='.') {
							edit_text[i+1]='r';
							edit_text[i+2]='p';
							edit_text[i+3]='l';
							edit_text[i+4]=0;
							found=true;
						} /* if */ 
					} /* for */ 
					if (!found) {
						edit_text[edit_position]='.';
						edit_text[edit_position+1]='r';
						edit_text[edit_position+2]='p';
						edit_text[edit_position+3]='l';
						edit_text[edit_position+4]=0;
					} /* if */ 
					STATE=7;
					SUBSTATE=0;
					sprintf(tmp,"replays/%s",files[act_file]);
					sprintf(tmp2,"replays/%s",edit_text);
					rename(tmp,tmp2);
				} /* if */  
			} /* if */ 

		}
		break;

	case 4:
		/* Choose ship: */ 
		if (SUBSTATE==0) {
			if (image!=0) SDL_FreeSurface(image);
			if (image2!=0) SDL_FreeSurface(image);
			image=IMG_Load("graphics/tittle.pcx");
			image2=IMG_Load("graphics/tiles.pcx");
			SDL_SetColorKey(image2,SDL_SRCCOLORKEY,SDL_MapRGB(image2->format,0,0,0));
		} /* if */ 


		SDL_BlitSurface(image,0,screen,0);
		surface_fader(screen,0.5F,0.5F,0.5F);

		font_print_centered(sx/2,40,"CHOOSE YOUR SHIP:",screen);
		font_print(100,60,"SHADOW RUNNER:",screen);
		font_print(100,70," - HIGH SPEED AND RETRO THRUSTERS.",screen);
		font_print(100,80," - LOW POWERED WEAPONS.",screen);
	
		font_print(100,100,"V-PANTHER 2:",screen);
		font_print(100,110," - MODERATE SPEED.",screen);
		font_print(100,120," - MEDIUM POWERED WEAPONS.",screen);

		font_print(100,140,"X-TERMINATOR:",screen);
		font_print(100,150," - LOW SPEED.",screen);
		font_print(100,160," - HIGH POWERED WEAPONS.",screen);

		rectangle(screen,60,56+40*ship_type,32,32,SDL_MapRGB(screen->format,255,255,255));

		{
			SDL_Rect r,d;

			r.x=96; r.y=272;
			r.w=32; r.h=32;
			d.x=60; d.y=60;
			SDL_BlitSurface(image2,&r,screen,&d);
			r.x=32; r.y=240;
			r.w=32; r.h=32;
			d.x=60; d.y=100;
			SDL_BlitSurface(image2,&r,screen,&d);
			r.x=96; r.y=336;
			r.w=32; r.h=32;
			d.x=60; d.y=140;
			SDL_BlitSurface(image2,&r,screen,&d);
		}
		
		if (SUBSTATE<32) {
			surface_fader(screen,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F);
			SUBSTATE++;
		} /* if */ 
		if (SUBSTATE>32) {
			surface_fader(screen,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F);
			SUBSTATE++;
			if (SUBSTATE==64) {
				SDL_FreeSurface(image);
				image=0;
				SDL_FreeSurface(image2);
				image2=0;

				if (SUBSTATE2==0) {
					STATE=5;
					SUBSTATE=0;
				} /* if */ 
				if (SUBSTATE2==1) {
					STATE=1;
					SUBSTATE=0;
				} /* if */ 
			} /* if */ 
		} /* if */ 

		if (SUBSTATE==32) {
			if (keyboard[SDLK_LEFT] && !old_keyboard[SDLK_LEFT] && ship_type>0) ship_type--;
			if (keyboard[SDLK_RIGHT] && !old_keyboard[SDLK_RIGHT] && ship_type<2) ship_type++;
			if (keyboard[SDLK_UP] && !old_keyboard[SDLK_UP] && ship_type>0) ship_type--;
			if (keyboard[SDLK_DOWN] && !old_keyboard[SDLK_DOWN] && ship_type<2) ship_type++;
			if (keyboard[SDLK_SPACE] && !old_keyboard[SDLK_SPACE]) {
				SUBSTATE++;
				SUBSTATE2=0;
			} /* if */ 
			if (keyboard[SDLK_ESCAPE] && !old_keyboard[SDLK_ESCAPE]) {
				SUBSTATE++;
				SUBSTATE2=1;
			} /* if */ 
		} /* if */ 

		break;

	case 5:
		/* Interphase: */ 
		char tmp[80];
		sprintf(tmp,"LEVEL %i",level+1);
		font_print_centered(sx/2,(sy/2)-24,tmp,screen);
		font_print_centered(sx/2,(sy/2)-16,leveltext[level],screen);
		font_print_centered(sx/2,(sy/2),levelcode[level],screen);

		if (SUBSTATE<32) {
			surface_fader(screen,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F);
			SUBSTATE++;
		} /* if */ 
		if (SUBSTATE==32) {
			if (keyboard[FIRE_KEY] && !old_keyboard[FIRE_KEY]) SUBSTATE++;
		} /* if */ 
		if (SUBSTATE>32) {
			surface_fader(screen,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F);
			SUBSTATE++;
			if (SUBSTATE==64) {
				int i;
				char tmp[80];
				char levelname[256];

				STATE=6;
				SUBSTATE=0;
				if (game=0) delete game;
				game=new TRANSBALL("graphics/","sound/","maps/",initialfuel[level],levelnames[level],ship_type);
				sprintf(tmp,"replays/autoreplay%.3i.rpl",replaynum++);
				replayfile=fopen(tmp,"wb+");
				fputc(32,replayfile);
				fputc(0,replayfile);
				/* level name: */ 
				for(i=0;i<256;i++) levelname[i]=0;
				strcpy(levelname,levelnames[level]);
				for(i=0;i<256;i++) fputc(levelname[i],replayfile);
				fputc(initialfuel[level],replayfile);
				fputc(ship_type,replayfile);

				timer=0;
			} /* if */ 
		} /* if */ 
		break;
	case 6:
		/* Game: */ 
		{
			int retval=0;

			if (keyboard[PAUSE_KEY] && !old_keyboard[PAUSE_KEY]) {
				if (pause) pause=false;
					  else pause=true;
			} /* if */ 

			if (!pause) {
				retval=game->cycle(keyboard);
				if (replayfile!=0) {
					fputc(keyboard[THRUST_KEY],replayfile);
					fputc(keyboard[ANTITHRUST_KEY],replayfile);
					fputc(keyboard[LEFT_KEY],replayfile);
					fputc(keyboard[RIGHT_KEY],replayfile);
					fputc(keyboard[FIRE_KEY],replayfile);
					fputc(keyboard[ATRACTOR_KEY],replayfile);
					fputc(retval,replayfile);
				} /* if */ 
			} /* if */ 

			game->render(screen,sx,sy);

			if (pause) {
				surface_fader(screen,0.5F,0.5F,0.5F);
				font_print(sx/2,sy/2-16,"PAUSE",screen);
			} else {
				timer++;
			} /* if */ 

			/* Print time */ 
			{
				char tmp[128];
				int min,sec,dec;

				dec=(timer*18)/10;
				sec=dec/100;
				dec=dec%100;
				min=sec/60;
				sec=sec%60;
				sprintf(tmp,"%.2i:%.2i",min,sec);
				font_print_right(sx,0,tmp,screen);
			}

			if (retval!=0) {
				/* Retrieve statistics: */ 
//				timmer=game->get_statistics(0);
				used_fuel=game->get_statistics(1);
				remaining_fuel=game->get_statistics(2);
				n_shots=game->get_statistics(3);
				n_hits=game->get_statistics(4);
				enemies_destroyed=game->get_statistics(5);

				delete game;
				game=0;
				fclose(replayfile);
				replayfile=0;
			} /* if */ 
			if (retval==1) {
				STATE=5;
				SUBSTATE=0;
			} /* if */ 
			if (retval==2) {
				STATE=13;
				SUBSTATE=0;
			} /* if */ 
			if (retval==3) {
				STATE=9;
				SUBSTATE=0;
			} /* if */ 
		}

		break;

	case 7:
		/* Replay files: */ 
		if (SUBSTATE==0) {
			if (image!=0) SDL_FreeSurface(image);
			image=IMG_Load("graphics/tittle.pcx");
			refind_files=true;
			SUBSTATE2=0;
		} /* if */ 

		if (refind_files) {

			refind_files=false;
			files.Delete();
#ifdef _WIN32
			/* Find files: */ 
			WIN32_FIND_DATA finfo;
			HANDLE h;

			if (replay_source==0) h=FindFirstFile("replays/*.rpl",&finfo);
							 else h=FindFirstFile("high/*.rpl",&finfo);
			if (h!=INVALID_HANDLE_VALUE) {
				char *tmp;

				tmp=new char[strlen(finfo.cFileName)+1];
				strcpy(tmp,finfo.cFileName);
				files.Add(tmp);

				while(FindNextFile(h,&finfo)==TRUE) {
					char *tmp;

					tmp=new char[strlen(finfo.cFileName)+1];
					strcpy(tmp,finfo.cFileName);
					files.Add(tmp);
				} /* while */ 
			} /* if */ 
#else
			DIR *dp;
			struct dirent *ep;
			  
			if (replay_source==0) dp = opendir ("replays");
							 else dp = opendir ("high");
			if (dp != NULL)
			 {
			    while (ep = readdir (dp))
			     {
                                char *tmp;
                             
                                if (strlen(ep->d_name)>4 &&
                                    ep->d_name[strlen(ep->d_name)-4]=='.' &&
                                    ep->d_name[strlen(ep->d_name)-3]=='r' &&
                                    ep->d_name[strlen(ep->d_name)-2]=='p' &&
                                    ep->d_name[strlen(ep->d_name)-1]=='l') {
                                    tmp=new char[strlen(ep->d_name)+1];
                                    strcpy(tmp,ep->d_name);
                                    files.Add(tmp);                                    
                                } /* if */
                                   
			     }
			    (void) closedir (dp);
			 }
#endif                          
			first_file=0;
			act_file=0;		
		} /* if */ 

		SDL_BlitSurface(image,0,screen,0);
		surface_fader(screen,0.5F,0.5F,0.5F);


		if (replay_source==0) font_print_centered(sx/2,20,"REPLAY FILES [TAB - CHANGE SOURCE]:",screen);
						 else font_print_centered(sx/2,20,"HIGH SCORE FILES [TAB - CHANGE SOURCE]:",screen);
		font_print_centered(sx/2,30,"PRESS FIRE TO VIEW OR R TO RENAME",screen);
		{
			char *tmp;
			int i;

			files.Rewind();
			i=0;
			while(files.Iterate(tmp)) {
				if (i>=first_file &&
					i<first_file+18) {
					char *sname[3]={"SH.RNR.","PNTR.2","X-TRM."};
					int ship,length;
					char tmp2[80],tmp3[256];

					if (i==act_file) {
						SDL_Rect r;
						r.x=22;
						r.y=42+(i-first_file)*10-1;
						r.w=strlen(tmp)*6+2;
						r.h=9;
						SDL_FillRect(screen,&r,SDL_MapRGB(screen->format,255,0,0));
					} /* if */ 
					font_print(24,42+(i-first_file)*10,tmp,screen);
					
					if (replay_source==0) sprintf(tmp2,"replays/%s",tmp);
									 else sprintf(tmp2,"high/%s",tmp);
					replay_parameters(tmp2,&ship,&length,tmp3);
					{
						int min,sec,dec;

						dec=(length*18)/10;
						sec=dec/100;
						dec=dec%100;
						min=sec/60;
						sec=sec%60;
						sprintf(tmp2,"%.2i:%.2i'%.2i %s",min,sec,dec,sname[ship]);
						font_print(170,42+(i-first_file)*10,tmp2,screen);
					}

				} /* if */ 
				i++;
			} /* while */ 
		} 

		rectangle(screen,20,40,280,185,SDL_MapRGB(screen->format,255,255,255));
		rectangle(screen,164,40,0,185,SDL_MapRGB(screen->format,255,255,255));

		if (SUBSTATE<32) {
			surface_fader(screen,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F);
			SUBSTATE++;
		} /* if */ 
		if (SUBSTATE>32) {
			surface_fader(screen,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F);
			SUBSTATE++;
			if (SUBSTATE==64) {
				SDL_FreeSurface(image);
				image=0;

				if (SUBSTATE2==0) {
					STATE=1;
					SUBSTATE=0;
				} /* if */ 
				if (SUBSTATE2==1) {
					int i;
					char tmp[80];
					char levelname[256];
					int v1,v2;
					int fuel;
					STATE=8;
					SUBSTATE=0;

					if (replay_source==0) sprintf(tmp,"replays/%s",files[act_file]);
									 else sprintf(tmp,"high/%s",files[act_file]);
					replayfile=fopen(tmp,"rb");
					v1=fgetc(replayfile);
					v2=fgetc(replayfile);	// To maintain compatibility with a previous version

					level=0;
					for(i=0;i<256;i++) levelname[i]=fgetc(replayfile);
					fuel=fgetc(replayfile);

					ship_type=fgetc(replayfile);
					game=new TRANSBALL("graphics/","sound/","maps/",fuel,levelname,ship_type);

					timer=0;
				} /* if */ 
			} /* if */ 
		} /* if */ 

		if (SUBSTATE==32) {
			if ((keyboard[SDLK_UP] && !old_keyboard[SDLK_UP]) ||
				(keyboard[SDLK_LEFT] && !old_keyboard[SDLK_LEFT])) {
				if (act_file>0) act_file--;
				if (act_file<first_file) first_file=act_file;
			} /* if */ 

			if ((keyboard[SDLK_DOWN] && !old_keyboard[SDLK_DOWN]) ||
				(keyboard[SDLK_RIGHT] && !old_keyboard[SDLK_RIGHT])) {
				if (act_file<(files.Length()-1)) act_file++;
				if (act_file>=(first_file+18)) first_file=act_file-17;
			} /* if */ 

			if (keyboard[SDLK_PAGEUP] && !old_keyboard[SDLK_PAGEUP]) {
				act_file-=18;
				if (act_file<0) act_file=0;
				if (act_file<first_file) first_file=act_file;
			} /* if */ 

			if (keyboard[SDLK_PAGEDOWN] && !old_keyboard[SDLK_PAGEDOWN]) {
				act_file+=18;
				if (act_file>=files.Length()) act_file=(files.Length()-1);
				if (act_file>=(first_file+18)) first_file=act_file-17;
			} /* if */ 

			if (keyboard[SDLK_SPACE] && !old_keyboard[SDLK_SPACE]) {
				SUBSTATE2=1;
				if (files.EmptyP()) SUBSTATE2=0;
				SUBSTATE++;
			} /* if */ 

			if (keyboard[SDLK_r] && !old_keyboard[SDLK_r]) {
				STATE=3;
				SUBSTATE=0;
				SUBSTATE2=1;
				strcpy(edit_text,files[act_file]);
				edit_position=strlen(edit_text);
			} /* if */ 

			if (keyboard[SDLK_ESCAPE] && !old_keyboard[SDLK_ESCAPE]) {
				SUBSTATE2=0;
				SUBSTATE++;
			} /* if */ 

			if (keyboard[SDLK_TAB] && !old_keyboard[SDLK_TAB]) {
				if (replay_source==0) replay_source=1;
								 else replay_source=0;
				act_file=0;
				first_file=0;
				refind_files=true;
			} /* if */ 
		} /* if */ 
		break;

	case 8:
		/* Viewing replay: */ 
		{
			int retval=0;

			SUBSTATE++;

			if (keyboard[PAUSE_KEY] && !old_keyboard[PAUSE_KEY]) {
				if (pause) pause=false;
					  else pause=true;
			} /* if */ 

			if (!pause) {
				int i;
				unsigned char tmp[322];
				for(i=0;i<322;i++) tmp[i]=0;
				tmp[THRUST_KEY]=fgetc(replayfile);
				tmp[ANTITHRUST_KEY]=fgetc(replayfile);
				tmp[LEFT_KEY]=fgetc(replayfile);
				tmp[RIGHT_KEY]=fgetc(replayfile);
				tmp[FIRE_KEY]=fgetc(replayfile);
				tmp[ATRACTOR_KEY]=fgetc(replayfile);
				retval=game->cycle(tmp);
				retval=fgetc(replayfile);
			} /* if */ 

			game->render(screen,sx,sy);

			if (pause) {
				surface_fader(screen,0.5F,0.5F,0.5F);
				font_print(sx/2,sy/2-16,"PAUSE",screen);
			} else {
				timer++;
			} /* if */ 

			/* print time */ 
			{
				char tmp[128];
				int min,sec,dec;

				dec=(timer*18)/10;
				sec=dec/100;
				dec=dec%100;
				min=sec/60;
				sec=sec%60;
				sprintf(tmp,"%.2i:%.2i'%.2i",min,sec,dec);
				font_print_right(sx,0,tmp,screen);
			}	

			if (((SUBSTATE>>5)&0x01)==0) {
				font_print_centered(sx/2,sy-10,"REPLAY",screen);
			} /* if */ 

			if (retval!=0 || keyboard[SDLK_ESCAPE]) {
				delete game;
				game=0;
				fclose(replayfile);
				replayfile=0;
				STATE=7;
				SUBSTATE=0;
			} /* if */ 
		}		
		break;

	case 9:
		/* Game over: */ 
		font_print_centered(sx/2,(sy/2)-24,"GAME OVER",screen);
		font_print_centered(sx/2,(sy/2)-16,"PRESS R TO VIEW THE REPLAYS",screen);

		if (SUBSTATE<32) {
			surface_fader(screen,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F);
			SUBSTATE++;
		} /* if */ 
		if (SUBSTATE==32) {
			if (keyboard[SDLK_r] && !old_keyboard[SDLK_r]) {
				SUBSTATE2=0;
				SUBSTATE++;
			} /* if */ 
			if (keyboard[FIRE_KEY] && !old_keyboard[FIRE_KEY]) {
				SUBSTATE2=1;
				SUBSTATE++;
			} /* if */ 
		} /* if */ 
		if (SUBSTATE>32) {
			surface_fader(screen,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F);
			SUBSTATE++;
			if (SUBSTATE==64) {
				if (SUBSTATE2==1) {
					STATE=1;
					SUBSTATE=0;
				} /* if */ 
				if (SUBSTATE2==0) {
					STATE=7;
					SUBSTATE=0;
				} /* if */ 
			} /* if */ 
		} /* if */ 
		break;

	case 10:
		/* End secuence: */ 
		if (strcmp(levelpack,"levels.lp")==0) {
			font_print(16,10,"                CONGRATULATIONS!",screen);

			font_print(16,30,"YOU HAVE RECOVERED ALL THE STOLEN SPHERES!!",screen);
			font_print(16,40,"YOU HAVE GIVEN THE HUMAN KIND ANOTHER CHANCE",screen);
			font_print(16,50,"TO SURVIVE. BUT THIS IS NOT THE END, A WAR HAS",screen);
			font_print(16,60,"STARTED BETWEEN THE HUMANS AND THE ALIEN RACE...",screen);

			font_print(16,80,"MORE CHALLENGES AWAIT YOU IN TRANSBALL 3...",screen);
		} else {
			font_print(16,10,"                CONGRATULATIONS!",screen);

			font_print(16,30,"YOU HAVE FINISHED THIS LEVEL-PACK!!",screen);
			font_print(16,40,"BUT...",screen);
			font_print(16,50,"HAVE YOU ALREADY FINISHED ALL THE OTHER PACKS?",screen);
		} /* if */ 

		if (SUBSTATE<32) {
			surface_fader(screen,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F);
			SUBSTATE++;
		} /* if */ 
		if (SUBSTATE==32) {
			if (keyboard[FIRE_KEY] && !old_keyboard[FIRE_KEY]) {
				SUBSTATE++;
			} /* if */ 
		} /* if */ 
		if (SUBSTATE>32) {
			surface_fader(screen,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F);
			SUBSTATE++;
			if (SUBSTATE==64) {
				if (SUBSTATE2==0) {
					STATE=1;
					SUBSTATE=0;
				} /* if */ 
			} /* if */ 
		} /* if */ 
		break;

	case 11:
		/* Key redefinition: */ 
		if (SUBSTATE==0) {
			if (image!=0) SDL_FreeSurface(image);
			if (image2!=0) SDL_FreeSurface(image);
			image=IMG_Load("graphics/tittle.pcx");
		} /* if */ 

		SDL_BlitSurface(image,0,screen,0);
		surface_fader(screen,0.5F,0.5F,0.5F);

		font_print_centered(sx/2,40,"REDEFINE KEYBOARD:",screen);

		if (SUBSTATE<32) {
			surface_fader(screen,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F);
			SUBSTATE++;
		} /* if */ 
		if (SUBSTATE>39) {
			surface_fader(screen,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F);
			SUBSTATE++;
			if (SUBSTATE==64) {
				save_configuration();

				SDL_FreeSurface(image);
				image=0;

				STATE=1;
				SUBSTATE=0;
			} /* if */ 
		} /* if */ 

		if (SUBSTATE>=32) {
			bool found;
			char *upstr;

			SUBSTATE-=32;
			if (SUBSTATE>=0) {
				font_print(16,60,"PRESS A KEY FOR THRUST:",screen);
			} /* if */ 
			if (SUBSTATE>=1) { 
#ifdef __MORPHOS__
				upstr=SDL_GetKeyName((SDLKey)THRUST_KEY);
#else
				upstr=strupr(SDL_GetKeyName((SDLKey)THRUST_KEY));
#endif
				font_print(200,60,upstr,screen);
				font_print(16,70,"PRESS A KEY FOR ANTITHRUST:",screen);
				//delete upstr;
			} /* if */ 
			if (SUBSTATE>=2) { 
#ifdef __MORPHOS__
				upstr=SDL_GetKeyName((SDLKey)ANTITHRUST_KEY);
#else
				upstr=strupr(SDL_GetKeyName((SDLKey)ANTITHRUST_KEY));
#endif
				font_print(200,70,upstr,screen);
				font_print(16,80,"PRESS A KEY FOR LEFT:",screen);
				//delete upstr;
			} /* if */ 
			if (SUBSTATE>=3) {  
#ifdef __MORPHOS__
				upstr=SDL_GetKeyName((SDLKey)LEFT_KEY);
#else
				upstr=strupr(SDL_GetKeyName((SDLKey)LEFT_KEY));
#endif
				font_print(200,80,upstr,screen);
				font_print(16,90,"PRESS A KEY FOR RIGHT:",screen);
				//delete upstr;
			} /* if */ 
			if (SUBSTATE>=4) { 
#ifdef __MORPHOS__
				upstr=SDL_GetKeyName((SDLKey)RIGHT_KEY);
#else
				upstr=strupr(SDL_GetKeyName((SDLKey)RIGHT_KEY));
#endif
				font_print(200,90,upstr,screen);
				font_print(16,100,"PRESS A KEY FOR FIRE:",screen);
				//delete upstr;
			} /* if */ 
			if (SUBSTATE>=5) { 
#ifdef __MORPHOS__
				upstr=SDL_GetKeyName((SDLKey)FIRE_KEY);
#else
				upstr=strupr(SDL_GetKeyName((SDLKey)FIRE_KEY));
#endif
				font_print(200,100,upstr,screen);
				font_print(16,110,"PRESS A KEY FOR ATRACTOR:",screen);
				//delete upstr;
			} /* if */ 
			if (SUBSTATE>=6) {
#ifdef __MORPHOS__
				upstr=SDL_GetKeyName((SDLKey)ATRACTOR_KEY);
#else
				upstr=strupr(SDL_GetKeyName((SDLKey)ATRACTOR_KEY));
#endif
				font_print(200,110,upstr,screen);
				font_print(16,120,"PRESS A KEY FOR PAUSE:",screen);
				//delete upstr;
			} /* if */ 
			if (SUBSTATE>=7) { 
#ifdef __MORPHOS__
				upstr=SDL_GetKeyName((SDLKey)PAUSE_KEY);
#else
				upstr=strupr(SDL_GetKeyName((SDLKey)PAUSE_KEY));
#endif
				font_print(200,120,upstr,screen);
				//delete upstr;
			} /* if */ 

			found=false;
			for(i=0;!found && i<322;i++) {
				if (keyboard[i] && !old_keyboard[i]) {
					switch(SUBSTATE) {
					case 0:THRUST_KEY=(SDLKey)i;
						   SUBSTATE++;
						   found=true;
						   break;
					case 1:ANTITHRUST_KEY=(SDLKey)i;
						   SUBSTATE++;
						   found=true;
						   break;
					case 2:LEFT_KEY=(SDLKey)i;
						   SUBSTATE++;
						   found=true;
						   break;
					case 3:RIGHT_KEY=(SDLKey)i;
						   SUBSTATE++;
						   found=true;
						   break;
					case 4:FIRE_KEY=(SDLKey)i;
						   SUBSTATE++;
						   found=true;
						   break;
					case 5:ATRACTOR_KEY=(SDLKey)i;
						   SUBSTATE++;
						   found=true;
						   break;
					case 6:PAUSE_KEY=(SDLKey)i;
						   SUBSTATE++;
						   found=true;
						   break;
					} /* switch */ 
				} /* if */ 
			} /* for */ 

			if (SUBSTATE==7 && 
				((keyboard[SDLK_ESCAPE] && !old_keyboard[SDLK_ESCAPE]) ||
				 (keyboard[FIRE_KEY] && !old_keyboard[FIRE_KEY])
				)) {
				SUBSTATE++;
			} /* if */ 
			SUBSTATE+=32;
		} /* if */ 

		break;

	case 12:
		/* CHANGE LEVEL PACK: */ 
		if (SUBSTATE==0) {
			if (image!=0) SDL_FreeSurface(image);
			image=IMG_Load("graphics/tittle.pcx");

			{
				levelpacks.Delete();
                                                             
#ifdef _WIN32
                            /* Find files: */ 
                            WIN32_FIND_DATA finfo;
                            HANDLE h;

                            h=FindFirstFile("maps/*.lp",&finfo);
                            if (h!=INVALID_HANDLE_VALUE) {
                                    char *tmp;

                                    tmp=new char[strlen(finfo.cFileName)+1];
                                    strcpy(tmp,finfo.cFileName);
                                    levelpacks.Add(tmp);

                                    while(FindNextFile(h,&finfo)==TRUE) {
                                        char *tmp;

                                        tmp=new char[strlen(finfo.cFileName)+1];
                                        strcpy(tmp,finfo.cFileName);
                                        levelpacks.Add(tmp);
                                    } /* while */ 
                            } /* if */ 
#else
                            DIR *dp;
                            struct dirent *ep;
			  
                            dp = opendir ("maps");
                            if (dp != NULL)
                            {
                                while (ep = readdir (dp))
                                {
                                    char *tmp;
                             
                                    if (strlen(ep->d_name)>4 &&
                                        ep->d_name[strlen(ep->d_name)-3]=='.' &&
                                        ep->d_name[strlen(ep->d_name)-2]=='l' &&
                                        ep->d_name[strlen(ep->d_name)-1]=='p') {
                                        tmp=new char[strlen(ep->d_name)+1];
                                        strcpy(tmp,ep->d_name);
                                        levelpacks.Add(tmp);                                    
                                    } /* if */
                                   
                                }
                                (void) closedir (dp);
                            }
#endif                                 
                        act_levelpack=0;
			}
		} /* if */ 
		SDL_BlitSurface(image,0,screen,0);
		surface_fader(screen,0.5F,0.5F,0.5F);

		font_print_centered(sx/2,(sy/2)-24,"CHOOSE LEVEL-PACK:",screen);

		{
			int i,y;
			char *tmp;

			i=0;
			y=(sy/2)-8;
			levelpacks.Rewind();
			while(levelpacks.Iterate(tmp)) {
				if (i==act_levelpack) {
					SDL_Rect r;
					r.x=0;
					r.y=y;
					r.w=SCREEN_X;
					r.h=8;
					SDL_FillRect(screen,&r,SDL_MapRGB(screen->format,255,0,0));
				} /* if */ 
				font_print_centered(sx/2,y,tmp,screen);
				i++;
				y+=8;
			} /* while */ 
		}

		if (SUBSTATE<32) {
			surface_fader(screen,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F);
			SUBSTATE++;
		} /* if */ 
		if (SUBSTATE==32) {
			if (keyboard[FIRE_KEY] && !old_keyboard[FIRE_KEY]) {
				/* change level-pack: */ 
				strcpy(levelpack,levelpacks[act_levelpack]);
				NLEVELS=-1;

				SUBSTATE2=0;
				SUBSTATE++;
			} /* if */ 
			if (keyboard[SDLK_ESCAPE] && !old_keyboard[SDLK_ESCAPE]) {
				SUBSTATE2=0;
				SUBSTATE++;
			} /* if */ 

			if (keyboard[SDLK_UP] && !old_keyboard[SDLK_UP]) {
				if (act_levelpack>0) act_levelpack--;
			} /* if */ 
			if (keyboard[SDLK_DOWN] && !old_keyboard[SDLK_DOWN]) {
				if (act_levelpack<(levelpacks.Length()-1)) act_levelpack++;
			} /* if */ 
		} /* if */ 
		if (SUBSTATE>32) {
			surface_fader(screen,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F,float(64-SUBSTATE)/32.0F);
			SUBSTATE++;
			if (SUBSTATE==64) {
				STATE=1;
				SUBSTATE=0;
			} /* if */ 
		} /* if */ 

		break;

	case 13:
		/* Level finished: */ 
		{
			char tmp[80];

			if (SUBSTATE==0) {
				/* UPDATE THE HIGHSCORES: */ 
				int current_time=timer;
				int best_time=-1;
				int i;
				char highname[256],filename[256],filename2[256];

				previous_high=-1;

				for(i=0;levelpack[i]!='.' && levelpack[i]!=0;i++) highname[i]=levelpack[i];
				highname[i++]='-';
				sprintf(highname+i,"%.3i",level);
				i+=3;
				highname[i++]='-';
				if (ship_type==0) highname[i++]='S';
				if (ship_type==0) highname[i++]='R';
				if (ship_type==1) highname[i++]='V';
				if (ship_type==1) highname[i++]='P';
				if (ship_type==2) highname[i++]='X';
				if (ship_type==2) highname[i++]='T';
				highname[i++]='.';
				highname[i++]='r';
				highname[i++]='p';
				highname[i++]='l';
				highname[i++]=0;

				{
					int retval;
					int s,l;
					char levelname[256];

					sprintf(filename,"high/%s",highname);
					retval=replay_parameters(filename,&s,&l,levelname);

					if (retval==2) {
						previous_high=best_time=l;
					} /* if */ 
				}

				if (best_time==-1 || best_time>current_time) {
					sprintf(filename2,"replays/autoreplay%.3i.rpl",replaynum-1);
					replay_copy(filename2,filename);
				} /* if */ 
			} /* if */ 

			sprintf(tmp,"LEVEL %i COMPLETED",level+1);
			font_print_centered(sx/2,(sy/2)-32,tmp,screen);

			/* print time */ 
			{
				char tmp[128];
				int min,sec,dec;

				dec=(timer*18)/10;
				sec=dec/100;
				dec=dec%100;
				min=sec/60;
				sec=sec%60;
				sprintf(tmp,"TIME: %.2i:%.2i'%.2i",min,sec,dec);
				font_print_centered(sx/2,(sy/2)-16,tmp,screen);

				if (previous_high!=-1) {
					dec=(previous_high*18)/10;
					sec=dec/100;
					dec=dec%100;
					min=sec/60;
					sec=sec%60;
					sprintf(tmp,"PREVIOUS HIGH: %.2i:%.2i'%.2i",min,sec,dec);
					font_print_centered(sx/2,(sy/2)-8,tmp,screen);
				} else {
					font_print_centered(sx/2,(sy/2)-8,"PREVIOUS HIGH: --",screen);
				} /* if */ 
			}

			/* print other statistics: */ 
			{
				sprintf(tmp,"FUEL, INITIAL: %i, USED: %i, REMAINING: %i",initialfuel[level]*fuelfactor[ship_type],used_fuel,remaining_fuel);
				font_print_centered(sx/2,(sy/2)+8,tmp,screen);

				sprintf(tmp,"SHOTS: %i, HITS: %i, ACCURACY: %.2f%%",n_shots,n_hits,(n_shots==0 ? 0.0F:100.0F*float(n_hits)/float(n_shots)));
				font_print_centered(sx/2,(sy/2)+16,tmp,screen);

				sprintf(tmp,"ENEMIES DESTROYED: %i",enemies_destroyed);
				font_print_centered(sx/2,(sy/2)+24,tmp,screen);
			}

			font_print_centered(sx/2,(sy/2)+40,"SPACE - CONTINUE",screen);
			font_print_centered(sx/2,(sy/2)+48,"R - REPEAT LEVEL",screen);

			if (SUBSTATE<32) {
				surface_fader(screen,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F,float(SUBSTATE)/32.0F);
				SUBSTATE++;
			} /* if */ 
			if (SUBSTATE==32) {
				if (keyboard[SDLK_SPACE] && !old_keyboard[SDLK_SPACE]) {
					SUBSTATE++;
					SUBSTATE2=0;
				} /* if */ 
				if (keyboard[SDLK_r] && !old_keyboard[SDLK_r]) {
					SUBSTATE++;
					SUBSTATE2=1;
				} /* if */ 
			} /* if */ 
			if (SUBSTATE>32) {
				if (SUBSTATE2==0) {
					level++;
					if (level>=NLEVELS) {
						STATE=10;
						SUBSTATE=0;
					} else {
						STATE=5;
						SUBSTATE=0;
					} /* if */ 
				} else {
					STATE=5;
					SUBSTATE=0;
				} /* if */ 
			} /* if */ 
		}
		break;

	} /* switch */ 

	/* Print the FPS: */ 
//	{
//		char tmp[80];
//		sprintf(tmp,"%i FPS",frames_per_sec);
//		font_print_right(sx,sy-8,tmp,screen);
//	}

	for(i=0;i<322;i++) old_keyboard[i]=keyboard[i];
	return true;	
}
