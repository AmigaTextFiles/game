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


int gameloopsinglecpu(SDL_Surface * screen)
{
      	
	register int temp;
	
	int squares[TOTALBLOCKS];
	int boxP[4], boxT[4];
	int boxT2[4],boxT3[4],boxT4[4];
	
	SDL_Rect src, dest;
	SDL_Event event;
	SDL_Surface *grid, *bg, *sq1, *sq2, *sq3, *sq4, *tempomark, *num, *dead, *hud, *spark, *audvis;
	Uint8 *keystate;
	
	int done, speed, score, scorebuf;
	register int ticker;
	register double tempo;
	
	int audenable, playmus;
	
	Mix_Music *bgm;
	
	int timer[4];
	
	int level, highscore, prevscore;
	
	FILE *hs;
	
	int goal, newgoal, goalrot;
	
	int audrandx[16];
	
	int temps, temps2;
	int temp2, temp3;
	int tempo2;
	int wait;
	
	for(temp=0;temp<TOTALBLOCKS;temp++) squares[temp]=0;

	if((grid = IMG_Load("gfx/grid.png"))==NULL) exit(1);
	
	if((bg = IMG_Load("gfx/1/bg.png"))==NULL) exit(1);

	if((sq1 = IMG_Load("gfx/1/sq1.png"))==NULL) exit(1);

	if((sq2 = IMG_Load("gfx/1/sq2.png"))==NULL) exit(1);
	
	if((sq3 = IMG_Load("gfx/1/sq3.png"))==NULL) exit(1);
		
	if((sq4 = IMG_Load("gfx/1/sq4.png"))==NULL) exit(1);
	
	if((tempomark = IMG_Load("gfx/tempo.png"))==NULL) exit(1);	
	
	if((num = IMG_Load("gfx/numbers.png"))==NULL) exit(1);
	
	if((dead = IMG_Load("gfx/dead.png"))==NULL) exit(1);	
	
	if((hud = IMG_Load("gfx/hud.png"))==NULL) exit(1);

	if((spark = IMG_Load("gfx/spark.png"))==NULL) exit(1);

	if((audvis = IMG_Load("gfx/audvis.png"))==NULL) exit(1);

	done=0; speed=10; score=0; scorebuf=0;
	ticker=0;
	tempo=0;

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
	
	audenable=1, playmus=0;

	if((SDL_Init(SDL_INIT_AUDIO)!=0)||(Mix_OpenAudio(22050, AUDIO_S16SYS, 2, 4096)!= 0)) {
		printf("Unable to initialize audio: %s\n", Mix_GetError());
		audenable=0;
	}
	
	if((bgm = Mix_LoadMUS("bgm.ogg"))==NULL) audenable=0;

	timer[0]=SDL_GetTicks(); timer[1]=timer[2]=timer[3]=0;
	
	level=1; highscore=0; prevscore=0;
	
	
	if((hs = fopen("hiscore.dat", "r"))!=NULL) {
		fscanf(hs, "%i", &highscore);
		fclose(hs);
	}
	
	
	goal=0; newgoal=1; goalrot=0;
	
	for(temp=0;temp<16;temp++) audrandx[temp]=rand()%5;
		
	while(!done) {
	
		ticker++; // count loops

		if(timer[0]>=timer[1]) {  timer[1] = SDL_GetTicks(); timer[2]=timer[1]-timer[0]; }
		else {  timer[0] = SDL_GetTicks(); timer[2]=timer[0]-timer[1]; }

		timer[3]+=timer[2];

		if(timer[2]<60) SDL_Delay(60-timer[2]);

		// clear the game grid currently covered of "types"

		for(temp=0;temp<4;temp++) if(boxP[temp]>=0) squares[boxP[temp]]=0;
		
		if(tempo<15) tempo+=.1; else { tempo=0;  // move "tempo mark"
			
			if(scorebuf>=20) scorebuf*=2;  // determine combo points
			else if(scorebuf>=15) scorebuf+=12;
			else if(scorebuf>=10) scorebuf+=8;
			else if(scorebuf>=8) scorebuf+=4;
			else if(scorebuf>=5) scorebuf+=2;

			score+=scorebuf; scorebuf=0;  // calculate score
			
			// switch the background image based on the score
			
			temps=score; temps2=prevscore;
			while(temps>600) temps-=600;
			while(temps2>600) temps2-=600;
	
			if(temps>=500) { 
				SDL_FreeSurface(bg);
				SDL_FreeSurface(sq1); SDL_FreeSurface(sq2); SDL_FreeSurface(sq3); SDL_FreeSurface(sq4);
				bg = IMG_Load("gfx/1/bg.png");
				sq1 = IMG_Load("gfx/1/sq1.png"); sq2 = IMG_Load("gfx/1/sq2.png"); 
				sq3 = IMG_Load("gfx/1/sq3.png"); sq4 = IMG_Load("gfx/1/sq4.png");
				if(temps2<500) level++;
				}
			else if(temps>=400) {
				SDL_FreeSurface(bg);
				SDL_FreeSurface(sq1); SDL_FreeSurface(sq2); SDL_FreeSurface(sq3); SDL_FreeSurface(sq4);
				bg = IMG_Load("gfx/5/bg.png");
				sq1 = IMG_Load("gfx/5/sq1.png"); sq2 = IMG_Load("gfx/5/sq2.png"); 
				sq3 = IMG_Load("gfx/5/sq3.png"); sq4 = IMG_Load("gfx/5/sq4.png"); 
				if(temps2<400) level++;
				}
			else if(temps>=300) {
				SDL_FreeSurface(bg);
				SDL_FreeSurface(sq1); SDL_FreeSurface(sq2); SDL_FreeSurface(sq3); SDL_FreeSurface(sq4);
				bg = IMG_Load("gfx/4/bg.png");
				sq1 = IMG_Load("gfx/4/sq1.png"); sq2 = IMG_Load("gfx/4/sq2.png"); 
				sq3 = IMG_Load("gfx/4/sq3.png"); sq4 = IMG_Load("gfx/4/sq4.png"); 
				if(temps2<300) level++;
				}
			else if(temps>=200) {
				SDL_FreeSurface(bg);
				SDL_FreeSurface(sq1); SDL_FreeSurface(sq2); SDL_FreeSurface(sq3); SDL_FreeSurface(sq4);
				bg = IMG_Load("gfx/3/bg.png");
				sq1 = IMG_Load("gfx/3/sq1.png"); sq2 = IMG_Load("gfx/3/sq2.png"); 
				sq3 = IMG_Load("gfx/3/sq3.png"); sq4 = IMG_Load("gfx/3/sq4.png"); 
				if(temps2<200) level++;
				}
			else if(temps>=100) {
				SDL_FreeSurface(bg);
				SDL_FreeSurface(sq1); SDL_FreeSurface(sq2); SDL_FreeSurface(sq3); SDL_FreeSurface(sq4);
				bg = IMG_Load("gfx/2/bg.png");
				sq1 = IMG_Load("gfx/2/sq1.png"); sq2 = IMG_Load("gfx/2/sq2.png"); 
				sq3 = IMG_Load("gfx/2/sq3.png"); sq4 = IMG_Load("gfx/2/sq4.png"); 
				if(temps2<100) level++;
				}
			
			if((bg==NULL)||(sq1==NULL)||(sq2==NULL)||(sq3==NULL)||(sq4==NULL)) {
				printf("An image file is missing\n");
				exit(1);
			}
			
		}  
		
		if(score>=999999999) { printf("You win! Now get a job ;)\n"); done=1; }
		prevscore=score;
		
		if(ticker%20==0) srand(time(NULL)); // occasionaly seed the random # generator
		
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
				

		
		// move "box" down after time elapse
	
		if(ticker%10==0) {

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
			
			
		// update keyboard input
		
		SDL_PollEvent(&event);
		keystate = SDL_GetKeyState(NULL);
		
		if(keystate[SDLK_ESCAPE]) done=1; 

		if(keystate[SDLK_RETURN]&&ticker%3==0) {
			temp=1;

			SDL_Delay(500);
			
			while(temp) {			
				SDL_PollEvent(&event);
				keystate = SDL_GetKeyState(NULL);
				if(keystate[SDLK_RETURN]) temp=0;
		
			}	
		}
		
		if(keystate[SDLK_m]&&ticker%2==0) {
			playmus = (playmus) ? 0:1;
			if(audenable&&playmus) Mix_PlayMusic(bgm, -1);
			if(audenable&&playmus==0) Mix_HaltMusic();
		}
		
		if(keystate[SDLK_f]&&ticker%2==0)
			if(SDL_WM_ToggleFullScreen(screen)==0);
		
		
		// display background
		
		src.x=0;src.y=0;src.w=bg->w;src.h=bg->h;
		dest.x=0;dest.y=0;dest.w=src.w;dest.h=src.h;
		SDL_BlitSurface(bg, &src, screen, &dest);


		// display audbars
		
		src.x=0; src.y=0; dest.w=src.w=audvis->w; dest.h=src.h=audvis->h;
		
		
		if(ticker%2==0) for(temp=0;temp<16;temp++) audrandx[temp]+=(rand()%7-2);
		
		for(temp=0;temp<16;temp++) {
			if(audrandx[temp]>27) audrandx[temp]=0;
			if(audrandx[temp]<0) audrandx[temp]=0;
		}
		
		for(temp=0;temp<16;temp++) {
		
			int temp2;
			
			for(temp2=0;temp2<=audrandx[temp];temp2++) {
		
		
				dest.x=156+(temp*30);
				dest.y=441-(temp2*10);
		
				SDL_BlitSurface(audvis, &src, screen, &dest);

			}

		}
		
			
		// display gridlines
		
		src.x=0;src.y=0;src.w=grid->w;src.h=grid->h;
		dest.x=150;dest.y=150;dest.w=src.w;dest.h=src.h;
		SDL_BlitSurface(grid, &src, screen, &dest);

		// display HUD
		
		src.x=0;src.y=0;src.w=hud->w;src.h=hud->h;
		dest.x=0;dest.y=150;dest.w=src.w;dest.h=src.h;
		SDL_BlitSurface(hud, &src, screen, &dest);		
		
		//display next box
		
		for(temp=0;temp<4;temp++) {
			
			src.x=0;src.y=0;src.w=sq1->w;src.h=sq1->h;
			
			
			temp2=temp; temp3=250;
			
			switch(temp) {
				case 0: break;
				case 1: break;
				case 2: temp2=0; temp3=280; break;
				case 3: temp2=1; temp3=280; break;
			
			
			}
			
			dest.x=50+(temp2*30); dest.y=temp3;
			
			if(boxT2[temp]==1) SDL_BlitSurface(sq1, &src, screen, &dest);
			if(boxT2[temp]==2) SDL_BlitSurface(sq2, &src, screen, &dest);		
			
			
			temp2=temp; temp3=340;
			
			switch(temp) {
				case 0: break;
				case 1: break;
				case 2: temp2=0; temp3=370; break;
				case 3: temp2=1; temp3=370; break;
			
			
			}
			
			dest.x=50+(temp2*30); dest.y=temp3;
			
			if(boxT3[temp]==1) SDL_BlitSurface(sq1, &src, screen, &dest);
			if(boxT3[temp]==2) SDL_BlitSurface(sq2, &src, screen, &dest);		
			
			
			
			
			temp2=temp; temp3=430;
			
			switch(temp) {
				case 0: break;
				case 1: break;
				case 2: temp2=0; temp3=460; break;
				case 3: temp2=1; temp3=460; break;
			
			
			}
			
			dest.x=50+(temp2*30); dest.y=temp3;
			
			if(boxT4[temp]==1) SDL_BlitSurface(sq1, &src, screen, &dest);
			if(boxT4[temp]==2) SDL_BlitSurface(sq2, &src, screen, &dest);		
			
			
		
		}


		// check for combo

		for(temp=0;temp<(TOTALBLOCKS-17);temp++) {
		
				if((temp+1)%16!=0&&squares[temp]!=0&&squares[temp+1]!=0&&squares[temp+16]!=0&&squares[temp+17]!=0)
	
			
					if((abs(squares[temp]-squares[temp+1])==2||squares[temp]==squares[temp+1])&&(abs(squares[temp]-squares[temp+16])==2||squares[temp]==squares[temp+16])&&(abs(squares[temp]-squares[temp+17])==2||squares[temp]==squares[temp+17]))
	
						
						switch(squares[temp]) {
						
							case 1: squares[temp]=3; squares[temp+1]=3; squares[temp+16]=3; squares[temp+17]=3; break;
							case 2: squares[temp]=4; squares[temp+1]=4; squares[temp+16]=4; squares[temp+17]=4; break;
							case 3: squares[temp]=3; squares[temp+1]=3; squares[temp+16]=3; squares[temp+17]=3; break;
							case 4:	squares[temp]=4; squares[temp+1]=4; squares[temp+16]=4; squares[temp+17]=4; break;					
							default: break;
						}

		}

		

		// check for combo&&tempo marker and adjust accordingly
		
		tempo2=tempo;
		
		for(temp=1;temp<TOTALBLOCKS;temp+=16) {
			if(squares[tempo2-1+temp]==3||squares[tempo2+-1+temp]==4) {

				int temp2;
				
				for(temp2=0;temp2<(temp-16);temp2+=16)
					squares[tempo2-1+temp-temp2]=squares[tempo2-1+temp-(temp2+16)];
				
				squares[tempo2]=0;

				scorebuf++;
		
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
				
				
				

			}

		}

		for(temp=TOTALBLOCKS;temp>=0;temp--) {
		
			if(temp>=16&&squares[temp]==0&&squares[temp-16]!=0) {
		
				squares[temp]=squares[temp-16];
				squares[temp-16]=0;
				
			}
		
		}

		// display squares on the grid based on "type"
		
		src.x=0;src.y=0;src.w=sq1->w;src.h=sq1->h;
		dest.w=src.w;dest.h=src.h;

		for(temp=0;temp<TOTALBLOCKS;temp++) {
			
			dest.x=gridtoposX(temp); dest.y=gridtoposY(temp);
			
				
			switch(squares[temp]) {
			
				case 1: SDL_BlitSurface(sq1, &src, screen, &dest); break;
				case 2: SDL_BlitSurface(sq2, &src, screen, &dest); break;
				case 3: SDL_BlitSurface(sq3, &src, screen, &dest); break;
				case 4: SDL_BlitSurface(sq4, &src, screen, &dest); break;
				default: break;
			
			}
	
		}
		// display "box" regardless of location
		
		for(temp=0;temp<4;temp++) {
			
			src.x=0;src.y=0;src.w=sq1->w;src.h=sq1->h;
			
			dest.x=gridtoposX(boxP[temp]); dest.y=gridtoposY(boxP[temp]);

			if(boxP[temp]<0) {
				dest.x = gridtoposX(boxP[temp]+32);
				dest.y=(gridtoposY(boxP[temp]+32)-60);
			}


			
			if(boxT[temp]==1) SDL_BlitSurface(sq1, &src, screen, &dest);
			if(boxT[temp]==2) SDL_BlitSurface(sq2, &src, screen, &dest);		
		
		}
		
		
		// display "tempo marker"
		
		src.x=0;src.y=0;src.w=tempomark->w;src.h=tempomark->h;

		dest.x = 136+(tempo*30); dest.y=135;
		SDL_BlitSurface(tempomark, &src, screen, &dest);	
			
		
		// display level, time, score, and hiscore
		
		valuetoscreen(screen, num, level, 185);
		
		valuetoscreen(screen, num, (timer[3]/1000), 245);
		
		valuetoscreen(screen, num, score, 305);
				
		valuetoscreen(screen, num, highscore, 365);
		
		
		
		SDL_Flip(screen); // update the screen


		

	}
	
	
	wait=1;
		
	src.x = src.y = 0;
	dest.x = 175; dest.y = 500;
	dest.w = src.w = dead->w; dest.h = src.h = dead->h;

	SDL_BlitSurface(dead, &src, screen, &dest);
			
	done=1;

	SDL_Flip(screen);

	while(wait) {			
		SDL_PollEvent(&event);
		keystate = SDL_GetKeyState(NULL);
		if(keystate[SDLK_RETURN]) wait=0;
	}		
	
	SDL_Delay(500);
			
	// free surfaces
	
	SDL_FreeSurface(bg);
	SDL_FreeSurface(grid);
	SDL_FreeSurface(sq1);
	SDL_FreeSurface(sq2);
	SDL_FreeSurface(sq3);
	SDL_FreeSurface(sq4);
	SDL_FreeSurface(tempomark);
	SDL_FreeSurface(num);
	SDL_FreeSurface(dead);
	SDL_FreeSurface(hud);
	SDL_FreeSurface(spark);
	SDL_FreeSurface(audvis);

    
	return 0;
	
}

