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

#define TOTALBLOCKS 160
#define LEVELDIFF 500

int gameloopsingleplayer(SDL_Surface * screen, const int timelimit, const int gamemode)
{

	register int temp;
	
	int squares[TOTALBLOCKS];
	int boxP[4], boxT[4];
	int boxT2[4],boxT3[4],boxT4[4];
	
	for(temp=0;temp<TOTALBLOCKS;temp++) squares[temp]=0;

	SDL_Rect src, dest;
	SDL_Event event;
	SDL_Surface *bg, *tempomark, *num, *dead, *hud, *spark, *audvis, *bonusmessage;
	Uint8 *keystate;

	SDL_Surface *sq[7];
	
	if((bg = IMG_Load("gfx/1/bg.png"))==NULL) exit(1);

	if((sq[1] = IMG_Load("gfx/1/sq1.png"))==NULL) exit(1);

	if((sq[2] = IMG_Load("gfx/1/sq2.png"))==NULL) exit(1);
	
	if((sq[3] = IMG_Load("gfx/1/sq3.png"))==NULL) exit(1);
		
	if((sq[4] = IMG_Load("gfx/1/sq4.png"))==NULL) exit(1);

	if((sq[5] = IMG_Load("gfx/sq5.png"))==NULL) exit(1);
		
	if((sq[6] = IMG_Load("gfx/sq6.png"))==NULL) exit(1);
	
	if((tempomark = IMG_Load("gfx/tempo.png"))==NULL) exit(1);	
	
	if((num = IMG_Load("gfx/numbers.png"))==NULL) exit(1);
	
	if((dead = IMG_Load("gfx/dead.png"))==NULL) exit(1);	
	
	if((hud = IMG_Load("gfx/hud.png"))==NULL) exit(1);

	if((spark = IMG_Load("gfx/spark.png"))==NULL) exit(1);
	
	if((audvis = IMG_Load("gfx/audvis.png"))==NULL) exit(1);

	if((bonusmessage = IMG_Load("gfx/bonus.png"))==NULL) exit(1);
	
	int done=0, score=0, scorebuf=0, scorebuf2;
	register int ticker=0;
	register double tempo=0;

	//generate boxes
	boxP[0]=-24;boxP[1]=-23;
	boxP[2]=-8;boxP[3]=-7;
	
	boxT[0]=1;boxT[1]=1;
	boxT[2]=1;boxT[3]=2;
	
	boxT2[0]=rand()%2+1;boxT2[1]=rand()%2+1;
	boxT2[2]=rand()%2+1;boxT2[3]=rand()%2+1;
	
	boxT3[0]=rand()%2+1;boxT3[1]=rand()%2+1;
	boxT3[2]=rand()%2+1;boxT3[3]=rand()%2+1;
	
	boxT4[0]=rand()%2+1;boxT4[1]=rand()%2+1;
	boxT4[2]=rand()%2+1;boxT4[3]=rand()%2+1;
	
	int audenable=1, playmus=0;

	if((SDL_Init(SDL_INIT_AUDIO)!=0)||(Mix_OpenAudio(22050, AUDIO_S16SYS, 2, 4096)!= 0)) {
		printf("Unable to initialize audio: %s\n", Mix_GetError());
		audenable=0;
	}
	
	Mix_Music *bgm;
	
	Mix_Chunk *bd, *sd, *wd, *mat, *bass;

	if((bgm = Mix_LoadMUS("bgm.ogg"))==NULL) audenable=0;
	if((bd = Mix_LoadWAV("sfx/bd.wav"))==NULL) audenable=0;
	if((sd = Mix_LoadWAV("sfx/snare.wav"))==NULL) audenable=0;
	if((wd = Mix_LoadWAV("sfx/wood.wav"))==NULL) audenable=0;
	if((mat = Mix_LoadWAV("sfx/matrix.wav"))==NULL) audenable=0;
	if((bass = Mix_LoadWAV("sfx/bass.wav"))==NULL) audenable=0;
	
	int timer[4];
	timer[0]=SDL_GetTicks(); timer[1]=timer[2]=timer[3]=0;
	
	int level=1, highscore=0, prevscore=0;
	
	int goal=0,newgoal=1,goalrot=0; // for CPU mode
	
	FILE *hs;
	if((hs = fopen("hiscore.dat", "r"))!=NULL) {
		fscanf(hs, "%i", &highscore);
		fclose(hs);
	}
	
	int getkey=1;

	int bonus=0;
	
	int audrandx[16];
	
	int huddisp=1;
	
	int delay=0;
		
	for(temp=0;temp<16;temp++) audrandx[temp]=rand()%5;
		
	while(!done) {

		ticker++; // count loops

		if(timer[0]>=timer[1]) {  timer[1] = SDL_GetTicks(); timer[2]=timer[1]-timer[0]; }
		else {  timer[0] = SDL_GetTicks(); timer[2]=timer[0]-timer[1]; }

		timer[3]+=timer[2];

		if(delay&&(45-timer[2]>0)) SDL_Delay(45-timer[2]);

		if(tempo<15) tempo+=.2; else { tempo=0;  // move "tempo mark"
			
			if(scorebuf>3) { score+=(30+(scorebuf*5))*scorebuf; bonus=10; if(audenable&&playmus) Mix_PlayChannel(-1, mat, 0); }
			else score+=30*scorebuf;

			scorebuf=0; 

			srand(time(NULL)); // seed the random # generator
			
			// switch the background image based on the score
			
			int temps=score, temps2=prevscore;
			
			while(temps>=LEVELDIFF) temps-=LEVELDIFF;
			while(temps2>=LEVELDIFF) temps2-=LEVELDIFF;
			
			if(temps<temps2) {
			
			    level++;
			    SDL_FreeSurface(bg);
			    SDL_FreeSurface(sq[1]); SDL_FreeSurface(sq[2]); SDL_FreeSurface(sq[3]); SDL_FreeSurface(sq[4]);

			    switch(rand()%11) {
			
				case 0: bg = IMG_Load("gfx/1/bg.png"); sq[1] = IMG_Load("gfx/1/sq1.png"); sq[2] = IMG_Load("gfx/1/sq2.png"); sq[3] = IMG_Load("gfx/1/sq3.png"); sq[4] = IMG_Load("gfx/1/sq4.png"); break;
				case 1: bg = IMG_Load("gfx/2/bg.png"); sq[1] = IMG_Load("gfx/2/sq1.png"); sq[2] = IMG_Load("gfx/2/sq2.png"); sq[3] = IMG_Load("gfx/2/sq3.png"); sq[4] = IMG_Load("gfx/2/sq4.png"); break;
				case 2: bg = IMG_Load("gfx/3/bg.png"); sq[1] = IMG_Load("gfx/3/sq1.png"); sq[2] = IMG_Load("gfx/3/sq2.png"); sq[3] = IMG_Load("gfx/3/sq3.png"); sq[4] = IMG_Load("gfx/3/sq4.png"); break;
				case 3: bg = IMG_Load("gfx/4/bg.png"); sq[1] = IMG_Load("gfx/4/sq1.png"); sq[2] = IMG_Load("gfx/4/sq2.png"); sq[3] = IMG_Load("gfx/4/sq3.png"); sq[4] = IMG_Load("gfx/4/sq4.png"); break;
				case 4: bg = IMG_Load("gfx/5/bg.png"); sq[1] = IMG_Load("gfx/5/sq1.png"); sq[2] = IMG_Load("gfx/5/sq2.png"); sq[3] = IMG_Load("gfx/5/sq3.png"); sq[4] = IMG_Load("gfx/5/sq4.png"); break;
				case 5: bg = IMG_Load("gfx/6/bg.png"); sq[1] = IMG_Load("gfx/6/sq1.png"); sq[2] = IMG_Load("gfx/6/sq2.png"); sq[3] = IMG_Load("gfx/6/sq3.png"); sq[4] = IMG_Load("gfx/6/sq4.png"); break;
				case 6: bg = IMG_Load("gfx/7/bg.png"); sq[1] = IMG_Load("gfx/7/sq1.png"); sq[2] = IMG_Load("gfx/7/sq2.png"); sq[3] = IMG_Load("gfx/7/sq3.png"); sq[4] = IMG_Load("gfx/7/sq4.png"); break;
				case 7: bg = IMG_Load("gfx/8/bg.png"); sq[1] = IMG_Load("gfx/8/sq1.png"); sq[2] = IMG_Load("gfx/8/sq2.png"); sq[3] = IMG_Load("gfx/8/sq3.png"); sq[4] = IMG_Load("gfx/8/sq4.png"); break;
				case 8: bg = IMG_Load("gfx/9/bg.png"); sq[1] = IMG_Load("gfx/9/sq1.png"); sq[2] = IMG_Load("gfx/9/sq2.png"); sq[3] = IMG_Load("gfx/9/sq3.png"); sq[4] = IMG_Load("gfx/9/sq4.png"); break;
				case 9: bg = IMG_Load("gfx/10/bg.png"); sq[1] = IMG_Load("gfx/10/sq1.png"); sq[2] = IMG_Load("gfx/10/sq2.png"); sq[3] = IMG_Load("gfx/10/sq3.png"); sq[4] = IMG_Load("gfx/10/sq4.png"); break;
				case 10: bg = IMG_Load("gfx/11/bg.png"); sq[1] = IMG_Load("gfx/11/sq1.png"); sq[2] = IMG_Load("gfx/11/sq2.png"); sq[3] = IMG_Load("gfx/11/sq3.png"); sq[4] = IMG_Load("gfx/11/sq4.png"); break;
			
			    }

			
			}
			
			if((bg==NULL)||(sq[1]==NULL)||(sq[2]==NULL)||(sq[3]==NULL)||(sq[4]==NULL)) {
				printf("An image file is missing\n");
				exit(1);
			}
			
		}  
		
		if(score>=999999999) { printf("You win! Now get a job ;)\n"); done=1; }
		prevscore=score;

		if(timelimit&&(timer[3]*.001)>=timelimit) done=1;
		
		
		
		
		
	    if(gamemode==2) {	// this section contains code for the CPU demo mode
		
		// determine goal location and rotation
		
		goalrot=0;
		
		if(newgoal)
		    for(temp=0;temp<(TOTALBLOCKS-16);temp++) {
			
			
			int temp2;
		
			for(temp2=0;temp2<4;temp2++) {

			if(boxT[0]==boxT[1]&&boxT[0]==boxT[2]&&boxT[0]==boxT[3]&&((squares[boxP[2]+16]==0&&squares[boxP[3]+16]==0)||(squares[boxP[2]+16]!=0&&squares[boxP[3]+16]!=0))) {
			
				int temp3=boxP[2];
			
				while(!((squares[temp3+16]==0&&squares[temp3+17]==0)||(squares[temp3+16]!=0&&squares[temp3+17]!=0))) {
			
					if(gridgetx(temp3-1)!=-1) temp3--;

				}

				goal=gridgetx(temp3)+(TOTALBLOCKS-16);
				temp2=4; temp=TOTALBLOCKS;
			}
			
			
			else if(squares[temp-1]!=0&&squares[temp]!=0&&(squares[temp-1]==boxT[temp2]||squares[temp-1]-2==boxT[temp2])&&(squares[temp+15]==boxT[temp2]||squares[temp+15]-2==boxT[temp2])&&(squares[temp+16]==boxT[temp2]||squares[temp+16]-2==boxT[temp2])) {

				switch(temp2) {
				
					case 0: goalrot=2; break;
					case 1: goalrot=1; break;
					case 2: goalrot=0; break;
					case 3: goalrot=3; break;
					
				}
			
				goal=temp+1; temp2=4; temp=TOTALBLOCKS; newgoal=0;

			}
			
			
			else if((squares[temp-1]==squares[temp]||abs(squares[temp-1]-squares[temp])==2)&&boxT[temp2]==boxT[temp2+1]&&(boxT[temp2]==squares[temp-1]||abs(squares[temp-1]-boxT[temp2])==2)) {
		
				switch(temp2) {
			
					case 0: goalrot=2; break;
					case 1: goalrot=1; break;
					case 2: goalrot=0; break;
					case 3: goalrot=3; break;
				
					}
		
			goal=temp-1; temp2=4; temp=TOTALBLOCKS; newgoal=0;
		
			}
			
			else if((squares[temp-1]==boxT[temp2]||abs(squares[temp-1]-boxT[temp2]==2))&&boxT[temp2]==boxT[temp2+1]&&boxT[temp2]==boxT[temp2+2]) {
				goal=temp; goalrot=2;
			}
		
		
			else { 
				goal=(TOTALBLOCKS-16)+(rand()%16);
				newgoal=0; temp2=4; temp=TOTALBLOCKS; 
			}
		
		
			}
		

		
		    }
		
		
		while(squares[goal]!=0) goal-=16;
		
		// move based on goal location and rotation
		
		while(goalrot) {
			int temp2=boxT[0], temp3=boxT[1];boxP[0]+=16; boxP[2]+=16;
			boxT[0] = boxT[2];
			boxT[1] = temp2;
			boxT[2] = boxT[3];
			boxT[3] = temp3;	
			goalrot--;
		}
			
		if(boxP[0]+1==boxP[1]&&boxP[2]<(TOTALBLOCKS-16)) {
			if(gridgetx(goal)<gridgetx(boxP[0])&&gridgetx(boxP[0])>0&&squares[boxP[0]-1]==0&&squares[boxP[2]-1]==0) { boxP[0]--; boxP[1]--; boxP[2]--; boxP[3]--; }
			else if(gridgetx(goal)<gridgetx(boxP[0])&&gridgetx(boxP[0])>0&&boxP[2]<0) { boxP[0]--; boxP[1]--; boxP[2]--; boxP[3]--; }
			
			
			else if(gridgetx(goal)>gridgetx(boxP[0])&&gridgetx(boxP[1])+1<16&&squares[boxP[1]+1]==0&&squares[boxP[3]+1]==0) { boxP[0]++; boxP[1]++; boxP[2]++; boxP[3]++; }
			else if(gridgetx(goal)>gridgetx(boxP[0])&&gridgetx(boxP[1])+1<16&&boxP[2]<0) { boxP[0]++; boxP[1]++; boxP[2]++; boxP[3]++; }

		
		
			else if(gridgetx(goal)==gridgetx(boxP[0])&&ticker%2==0&&goal>(TOTALBLOCKS/2)) {
				if(squares[boxP[2]+16]==0) { boxP[0]+=16; boxP[2]+=16; }
				if(squares[boxP[3]+16]==0) { boxP[1]+=16; boxP[3]+=16; }
			}
			
			else if(gridgetx(boxP[0])==0&&ticker%2==0&&goal>(TOTALBLOCKS/2)) {
				if(squares[boxP[2]+16]==0) { boxP[0]+=16; boxP[2]+=16; }
				if(squares[boxP[3]+16]==0) { boxP[1]+=16; boxP[3]+=16; }
			}
			
			else if(gridgetx(boxP[1])+1==16&&ticker%2==0&&goal>(TOTALBLOCKS/2)) {
				if(squares[boxP[2]+16]==0) { boxP[0]+=16; boxP[2]+=16; }
				if(squares[boxP[3]+16]==0) { boxP[1]+=16; boxP[3]+=16; }
			}
			

		} else {
			while(boxP[2]<(TOTALBLOCKS-16)&&squares[boxP[2]+16]==0) { boxP[0]+=16; boxP[2]+=16; }
			while(boxP[3]<(TOTALBLOCKS-16)&&squares[boxP[3]+16]==0) { boxP[1]+=16; boxP[3]+=16; }
		}
				
		
	    }
		
		
		
		// update keyboard input
		
		
		SDL_PollEvent(&event);
		keystate = SDL_GetKeyState(NULL);
		
		if(keystate[SDLK_ESCAPE]) done=1;
		
		if(keystate[SDLK_LCTRL]||keystate[SDLK_RCTRL]||keystate[SDLK_RALT]||keystate[SDLK_LALT])
			getkey=1;	
				
				
	      if(gamemode==1&&boxP[0]==(boxP[1])-1&&getkey==1) { // fix "sliding while at different heights"


		if(keystate[SDLK_DOWN]) { 
			
			int temp2=boxT[0], temp3=boxT[2];
			boxT[0] = boxT[1];
			boxT[1] = boxT[3];
			boxT[2] = temp2;
			boxT[3] = temp3;

			if(audenable&&playmus) Mix_PlayChannel(-1, bd, 0);
		} 
		
		if(keystate[SDLK_UP]) { 
		
			int temp2=boxT[0], temp3=boxT[1];

			boxT[0] = boxT[2];
			boxT[1] = temp2;
			boxT[2] = boxT[3];
			boxT[3] = temp3;

			if(audenable&&playmus) Mix_PlayChannel(-1, sd, 0);	
			
		} 
		
		
		if(boxP[0]>=0) { // fix movement while "above" the game grid
		
		  if(keystate[SDLK_LEFT]&&gridgetx(boxP[0])>0&&(squares[boxP[0]-1]==0)&&(squares[boxP[2]-1]==0)) { 

			boxP[0]--;boxP[1]--;boxP[2]--;boxP[3]--; 
		  }
		
		
		  else if(keystate[SDLK_RIGHT]&&gridgetx(boxP[1])<15&&(squares[boxP[1]+1]==0)&&(squares[boxP[3]+1]==0)) { 

			boxP[0]++;boxP[1]++;boxP[2]++;boxP[3]++; 
		  }
		
		
		} else if(boxP[0]<0&&boxP[2]<0) {
		
		  if(keystate[SDLK_LEFT]&&boxP[0]>-32) {
		
			boxP[0]--;boxP[1]--;boxP[2]--;boxP[3]--; 		
		
		  }
	
		

		  if(keystate[SDLK_RIGHT]&&boxP[3]<-1) {

		
			boxP[0]++;boxP[1]++;boxP[2]++;boxP[3]++;		
		
		  }
		
	
	
		} else if(boxP[0]<0&&boxP[2]>=0) {
		
		  if(keystate[SDLK_LEFT]&&boxP[2]>0) {
		
			boxP[0]--;boxP[1]--;boxP[2]--;boxP[3]--; 		
		
		  }
	
		

		  if(keystate[SDLK_RIGHT]&&boxP[3]<15) {

		
			boxP[0]++;boxP[1]++;boxP[2]++;boxP[3]++;		
		
		  }
		
	
	
		}
		
		
		
	

	      }
		
		if(keystate[SDLK_SPACE]&&boxP[2]>=0&&gamemode==1) { // quickly lower the box & fix for newly spawned boxes
			for(temp=0;temp<3;temp++) {
				if(boxP[2]<(TOTALBLOCKS-16)&&squares[boxP[2]+16]==0) { boxP[0]+=16; boxP[2]+=16; }
				if(boxP[3]<(TOTALBLOCKS-16)&&squares[boxP[3]+16]==0) { boxP[1]+=16; boxP[3]+=16; }
			}
			if(audenable&&playmus) Mix_PlayChannel(-1, wd, 0);
		}
		
		else if(keystate[SDLK_SPACE]&&gamemode==1&&(keystate[SDLK_LCTRL]||keystate[SDLK_RCTRL]||keystate[SDLK_RALT]||keystate[SDLK_LALT])) {
			for(temp=0;temp<3;temp++) {
				if(boxP[2]<(TOTALBLOCKS-16)&&squares[boxP[2]+16]==0) { boxP[0]+=16; boxP[2]+=16; }
				if(boxP[3]<(TOTALBLOCKS-16)&&squares[boxP[3]+16]==0) { boxP[1]+=16; boxP[3]+=16; }
			}		
	
		}

		
		
		if(ticker%3==0) {
		
		
			if(keystate[SDLK_RETURN]) {
		
				SDL_Delay(500);
			
				do {
					SDL_PollEvent(&event);
					keystate = SDL_GetKeyState(NULL);
				} while(!keystate[SDLK_RETURN]);		

			}
		
			if(keystate[SDLK_m]&&audenable) {
			
				playmus = (playmus) ? 0:1;
				if(playmus) Mix_FadeInMusic(bgm, -1, 2000);
				if(playmus==0) Mix_FadeOutMusic(2000);
			
			}
		
		
			if(keystate[SDLK_f]) SDL_WM_ToggleFullScreen(screen);
		
			if(keystate[SDLK_s]) delay = (delay) ? 0:1;
		
			if(keystate[SDLK_h]) {
				huddisp = (huddisp) ? 0:1;
				src.x=src.y=0; src.w=bg->w; src.h=bg->h;
				dest.x=src.x; dest.y=src.y; dest.w=src.w; dest.h=src.h;
				SDL_BlitSurface(bg, &src, screen, &dest);
				
			}

		
		}

		if(event.type==SDL_KEYDOWN&&getkey==1) getkey=0;
		if(event.type==SDL_KEYUP&&getkey==0) getkey=1;
	
		
		
		
		
		
		

		// move "box" down after time elapse
	
		if((ticker%10==0&&boxP[2]>=0)||ticker%50==0) {

			if(boxP[2]<0&&squares[boxP[2]+16]!=0) done=1;
			else if(boxP[3]<0&&squares[boxP[3]+16]!=0) done=1;
			
			else if(boxP[2]>=0&&boxP[0]<0&&squares[boxP[2]+16]!=0) done=1;
			else if(boxP[3]>=0&&boxP[1]<0&&squares[boxP[3]+16]!=0) done=1;
			
			else if(boxP[2]>=(TOTALBLOCKS-16)) {
			
					temp=boxP[0];
					squares[temp]=boxT[0];
					temp=boxP[1];
					squares[temp]=boxT[1];
					temp=boxP[2];
					squares[temp]=boxT[2];
					temp=boxP[3];
					squares[temp]=boxT[3];
		
		
					boxP[0]=-24;boxP[1]=-23;
					boxP[2]=-8;boxP[3]=-7;

					boxT[0]=boxT2[0];boxT[1]=boxT2[1];
					boxT[2]=boxT2[2];boxT[3]=boxT2[3];

					boxT2[0]=boxT3[0];boxT2[1]=boxT3[1];
					boxT2[2]=boxT3[2];boxT2[3]=boxT3[3];

					boxT3[0]=boxT4[0];boxT3[1]=boxT4[1];
					boxT3[2]=boxT4[2];boxT3[3]=boxT4[3];

					boxT4[0]=rand()%2+1;boxT4[1]=rand()%2+1;
					boxT4[2]=rand()%2+1;boxT4[3]=rand()%2+1;
		
					newgoal=1;
			}
				
					
			else if((squares[boxP[2]+16]!=0)&&(squares[boxP[3]+16]!=0)) {
			
					temp=boxP[0];
					squares[temp]=boxT[0];
					temp=boxP[1];
					squares[temp]=boxT[1];
					temp=boxP[2];
					squares[temp]=boxT[2];
					temp=boxP[3];
					squares[temp]=boxT[3];
		
		
					boxP[0]=-24;boxP[1]=-23;
					boxP[2]=-8;boxP[3]=-7;
					
					boxT[0]=boxT2[0];boxT[1]=boxT2[1];
					boxT[2]=boxT2[2];boxT[3]=boxT2[3];

					boxT2[0]=boxT3[0];boxT2[1]=boxT3[1];
					boxT2[2]=boxT3[2];boxT2[3]=boxT3[3];

					boxT3[0]=boxT4[0];boxT3[1]=boxT4[1];
					boxT3[2]=boxT4[2];boxT3[3]=boxT4[3];

					boxT4[0]=rand()%2+1;boxT4[1]=rand()%2+1;
					boxT4[2]=rand()%2+1;boxT4[3]=rand()%2+1;
			
					newgoal=1;
			}
	    
			else if(boxP[2]<(TOTALBLOCKS-16)&&(squares[boxP[2]+16]==0)&&(squares[boxP[3]+16]==0))
				for(temp=0;temp<4;temp++) boxP[temp]+=16;

			else if(boxP[2]<(TOTALBLOCKS-16)&&(squares[boxP[2]+16]==0)&&(squares[boxP[3]+16]!=0)) {
				while(boxP[2]<(TOTALBLOCKS-16)&&squares[boxP[2]+16]==0) { boxP[0]+=16; boxP[2]+=16; }
				
					temp=boxP[0];
					squares[temp]=boxT[0];
					temp=boxP[1];
					squares[temp]=boxT[1];
					temp=boxP[2];
					squares[temp]=boxT[2];
					temp=boxP[3];
					squares[temp]=boxT[3];
		
		
					boxP[0]=-24;boxP[1]=-23;
					boxP[2]=-8;boxP[3]=-7;

					boxT[0]=boxT2[0];boxT[1]=boxT2[1];
					boxT[2]=boxT2[2];boxT[3]=boxT2[3];

					boxT2[0]=boxT3[0];boxT2[1]=boxT3[1];
					boxT2[2]=boxT3[2];boxT2[3]=boxT3[3];

					boxT3[0]=boxT4[0];boxT3[1]=boxT4[1];
					boxT3[2]=boxT4[2];boxT3[3]=boxT4[3];

					boxT4[0]=rand()%2+1;boxT4[1]=rand()%2+1;
					boxT4[2]=rand()%2+1;boxT4[3]=rand()%2+1;

					newgoal=1;
			}
			
			else if(boxP[2]<(TOTALBLOCKS-16)&&(squares[boxP[2]+16]!=0)&&(squares[boxP[3]+16]==0)) {
			
				while(boxP[3]<(TOTALBLOCKS-16)&&squares[boxP[3]+16]==0) { boxP[1]+=16; boxP[3]+=16; }
				
				temp=boxP[0];
				squares[temp]=boxT[0];
				temp=boxP[1];
				squares[temp]=boxT[1];
				temp=boxP[2];
				squares[temp]=boxT[2];
				temp=boxP[3];
				squares[temp]=boxT[3];
		
		
				boxP[0]=-24;boxP[1]=-23;
				boxP[2]=-8;boxP[3]=-7;

				boxT[0]=boxT2[0];boxT[1]=boxT2[1];
				boxT[2]=boxT2[2];boxT[3]=boxT2[3];

				boxT2[0]=boxT3[0];boxT2[1]=boxT3[1];
				boxT2[2]=boxT3[2];boxT2[3]=boxT3[3];

				boxT3[0]=boxT4[0];boxT3[1]=boxT4[1];
				boxT3[2]=boxT4[2];boxT3[3]=boxT4[3];

				boxT4[0]=rand()%2+1;boxT4[1]=rand()%2+1;
				boxT4[2]=rand()%2+1;boxT4[3]=rand()%2+1;

				newgoal=1;
				
			}
			
					
			
		}
		
		


		// display background

		if(tempo!=0&&ticker!=1) { src.x=140; src.y=50; src.w=560; src.h=450; }
		else { src.x=src.y=0; src.w=bg->w; src.h=bg->h; }
		dest.x=src.x; dest.y=src.y; dest.w=src.w; dest.h=src.h;
		SDL_BlitSurface(bg, &src, screen, &dest);
		
	
		// display audbars

		src.x=0; src.y=0; dest.w=src.w=audvis->w; dest.h=src.h=audvis->h;
		
		if(ticker%2==0) for(temp=0;temp<16;temp++) audrandx[temp]+=(rand()%7-2);
		
		for(temp=15;temp--;) {
		
			if(audrandx[temp]>27) audrandx[temp]=0; else if(audrandx[temp]<0) audrandx[temp]=0;
			
			int temp2;
			
			for(temp2=audrandx[temp]+1;temp2--;) {
		
				dest.x=156+(temp*30);
				dest.y=441-(temp2*10);
		
				SDL_BlitSurface(audvis, &src, screen, &dest);

			}

		}
		

		if(huddisp) {
		
			// display HUD & gridlines
		
			src.x=src.y=0;
			dest.x=0;dest.y=150;
			dest.w=src.w=hud->w;dest.h=src.h=hud->h;
			
			SDL_BlitSurface(hud, &src, screen, &dest);		
		
				
			//display next boxes
		
			for(temp=0;temp<4;temp++) {
			
				src.x=0;src.y=0;src.w=sq[1]->w;src.h=sq[1]->h;
			
			
				int temp2=temp,temp3=250;
			
				if(temp>1) { temp2=temp-2; temp3=280; }
				
			
				dest.x=50+(temp2*30); dest.y=temp3;
			
				SDL_BlitSurface(sq[boxT2[temp]], &src, screen, &dest);
						
				temp2=temp; temp3=340;
				
				if(temp>1) { temp2=temp-2; temp3=370; }
				
				dest.x=50+(temp2*30); dest.y=temp3;
			
				SDL_BlitSurface(sq[boxT3[temp]], &src, screen, &dest);

			
				temp2=temp; temp3=430;
				
				if(temp>1) { temp2=temp-2; temp3=460; }
				
				dest.x=50+(temp2*30); dest.y=temp3;
			
				SDL_BlitSurface(sq[boxT4[temp]], &src, screen, &dest);

			}

		}


	
		if(ticker%10) {
		
		// check for combo

		for(temp=0;temp<(TOTALBLOCKS-17);temp++) {
		
				if((temp+1)%16!=0&&squares[temp]!=0&&squares[temp+1]!=0&&squares[temp+16]!=0&&squares[temp+17]!=0)
	
			
					if((abs(squares[temp]-squares[temp+1])==2||squares[temp]==squares[temp+1])&&(abs(squares[temp]-squares[temp+16])==2||squares[temp]==squares[temp+16])&&(abs(squares[temp]-squares[temp+17])==2||squares[temp]==squares[temp+17])) { 
						
						switch(squares[temp]) {
						
							case 1: squares[temp]=squares[temp+1]=squares[temp+16]=squares[temp+17]=3; break;
							case 2: squares[temp]=squares[temp+1]=squares[temp+16]=squares[temp+17]=4; break;
							case 3: squares[temp]=squares[temp+1]=squares[temp+16]=squares[temp+17]=3; break;
							case 4:	squares[temp]=squares[temp+1]=squares[temp+16]=squares[temp+17]=4; break;
						}

					}
					
		}

		

		// check for combo&&tempo marker and adjust accordingly
		
		int tempo2=tempo;
		
		for(temp=1;temp<TOTALBLOCKS;temp+=16) {
			if(squares[tempo2-1+temp]==3||squares[tempo2+-1+temp]==4) {

				if(audenable&&playmus) Mix_PlayChannel(-1, bass, 0);
				
				squares[tempo2-1+temp]+=2;
				
				squares[tempo2]=0;

				src.x=0;src.y=0;
				src.w=spark->w;src.h=spark->h;
				dest.w=src.w;dest.h=src.h;
				dest.x=gridtoposX(tempo2); dest.y=gridtoposY(tempo2-1+temp-16);
				SDL_BlitSurface(spark, &src, screen, &dest);
				dest.x=gridtoposX(tempo2); dest.y=gridtoposY(tempo2-1+temp+16);
				SDL_BlitSurface(spark, &src, screen, &dest);
				dest.x=gridtoposX(tempo2-1); dest.y=gridtoposY(tempo2-1+temp);
				SDL_BlitSurface(spark, &src, screen, &dest);
				dest.x=gridtoposX(tempo2+1); dest.y=gridtoposY(tempo2-1+temp);
				SDL_BlitSurface(spark, &src, screen, &dest);
				
				if(squares[tempo2-2+temp]>2&&(tempo2-2+temp+1)%16!=0) 
					switch(squares[tempo2-2+temp]) {
						case 3: squares[tempo2-2+temp]=1; break;
						case 4: squares[tempo2-2+temp]=2; break;
						default: break;
					}
					

			}

		}

		// check for delayed removal of blocks

		scorebuf2=0;

		for(temp=TOTALBLOCKS;temp--;) {		
				
				
				if((gridgetx(tempo)>gridgetx(temp)&&squares[temp]>4&&squares[temp+1]<3)||(tempo<2&&gridgetx(temp)==15&&squares[temp]>4)||(gridgetx(temp)==14&&squares[temp]>4&&squares[temp+1]>4)) {
				
					int temp2,temp3=1;
					
					

					if(tempo<15)
					    for(temp2=gridgetx(temp)+1;temp2<TOTALBLOCKS;temp2+=16) {
					
						if(squares[temp2]>4) temp3=0;
					
					    }

					if(temp3) { squares[temp]=0; scorebuf2++; }
					
				}


		
		}
		
		scorebuf2-=1;
		
		while(scorebuf2>0) {
			scorebuf++;
			scorebuf2-=4;
		}

		
		
		// move blocks down
		
		for(temp=TOTALBLOCKS;temp>=0;temp--) {
		
			if(temp>=16&&!squares[temp]&&squares[temp-16]) {
		
				squares[temp]=squares[temp-16];
				squares[temp-16]=0;
				
			}
		
		}

		}
		
		// display squares on the grid based on type
		
		src.x=0;src.y=0;src.w=sq[1]->w;src.h=sq[1]->h;
		dest.w=src.w;dest.h=src.h;

		dest.y=gridtoposY(0);
		
		for(temp=0;temp<TOTALBLOCKS;temp++) {
			
			if(temp%16==0) dest.y=gridtoposY(temp);
		
			if(squares[temp]) {
				
				dest.x=gridtoposX(temp); 
				
				SDL_BlitSurface(sq[squares[temp]], &src, screen, &dest);
				
			}
			
		}
		
		// display "box" regardless of location
		
		src.x=0;src.y=0;src.w=sq[1]->w;src.h=sq[1]->h;
		
		for(temp=0;temp<4;temp++) {
			
			dest.x=gridtoposX(boxP[temp]); dest.y=gridtoposY(boxP[temp]);

			if(boxP[temp]<0) {
				dest.x = gridtoposX(boxP[temp]+32);
				dest.y=gridtoposY(boxP[temp]+32)-60;
			}
			
			SDL_BlitSurface(sq[boxT[temp]], &src, screen, &dest);
			
		
		}
		
		
		// display time marker
		
		src.x=0;src.y=0;src.w=tempomark->w;src.h=tempomark->h;

		dest.x = 136+(tempo*30); dest.y=135;
		SDL_BlitSurface(tempomark, &src, screen, &dest);	
	
	
		// display bonus message
		
		if(bonus) {
		
			src.x=0;src.y=0;src.w=bonusmessage->w;src.h=bonusmessage->h;

			dest.x = 600; dest.y=121;
			SDL_BlitSurface(bonusmessage, &src, screen, &dest);	
		
			bonus--;
		
		}
		
		if(huddisp) {
				
		    // display level, time, score, and hiscore
		
		
		    valuetoscreen(screen, num, level, 640, 185);
		
		    if(timelimit==0) valuetoscreen(screen, num, (timer[3]*.001), 640, 245);
		    else valuetoscreen(screen, num, timelimit-(timer[3]*.001), 640, 245);

		    valuetoscreen(screen, num, score, 640, 305);
		
		    valuetoscreen(screen, num, highscore, 640, 365);
		
		    valuetoscreen(screen, num, scorebuf, 136+(tempo*30), 120);
		
		}
		
		
		SDL_Flip(screen); // update the screen


		

	}
	
	
	printf("You have perished\nSeconds Played: %i\nFinal Score: %i\n",(timer[3]/1000),score);
	src.x = src.y = 0;
	dest.x = 175; dest.y = 500;
	dest.w = src.w = dead->w; dest.h = src.h = dead->h;
	
	SDL_BlitSurface(dead, &src, screen, &dest);
			
	done=1;

	SDL_Flip(screen);
	
	do {
		SDL_PollEvent(&event);
		keystate = SDL_GetKeyState(NULL);
	} while(!keystate[SDLK_RETURN]);
			
		
	SDL_Delay(500);				
					
					
	// free surfaces
	
	SDL_FreeSurface(bg);
	SDL_FreeSurface(sq[1]);
	SDL_FreeSurface(sq[2]);
	SDL_FreeSurface(sq[3]);
	SDL_FreeSurface(sq[4]);
	SDL_FreeSurface(sq[5]);
	SDL_FreeSurface(sq[6]);
	SDL_FreeSurface(tempomark);
	SDL_FreeSurface(num);
	SDL_FreeSurface(dead);
	SDL_FreeSurface(hud);
	SDL_FreeSurface(spark);
	SDL_FreeSurface(audvis);
	SDL_FreeSurface(bonusmessage);

	if(audenable) Mix_HaltMusic();
	Mix_FreeMusic(bgm);
	Mix_FreeChunk(bd);
	Mix_FreeChunk(sd);
	Mix_FreeChunk(wd);
	Mix_FreeChunk(mat);
	Mix_FreeChunk(bass);
	

	if(score>=highscore&&timelimit==0&&gamemode==1)
    		if((hs = fopen("hiscore.dat", "w"))!=NULL) {
			fprintf(hs, "%i\n", score);
			fclose(hs);	
		}
		
    
	
    
	return 0;
	
}

