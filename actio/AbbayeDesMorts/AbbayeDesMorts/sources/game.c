/* game.c */

# include "abbaye.h"

void game(struct game *G){
int n,i;

	G->fonts = AB_LoadTexture(G,"graphics/fonts.png");

	/* Loading musics */
	loadingmusic(G);

	/* Load data */
	loaddata(G);

	/* Init struct */
	memset(&G->enemies,0,sizeof(struct gameenemies));
	memset(&G->jean,0,sizeof(struct gamehero));
	G->jean.x = 72;
	G->jean.y = 136;
	G->jean.direction = 1;
	G->jean.gravity = 1.9;
	G->jean.checkpoint[0]=5;
	G->jean.checkpoint[1]=72;
	G->jean.checkpoint[2]=136;
	G->jean.checkpoint[3]=5;
	G->jean.lifes=9;
	G->jean.crosses=0;

	/* Game loop */
	while (G->chapter==2) {

		/* Manage G->counters */
		counters(G);

		/* Cleaning the G->renderer */
		AB_Clear(G);


		/* Animation of fire and water */
		animation(G);

		/* Draw G->screen */
		drawscreen(G);

		/* Draw statusbar */
		if (G->room != 4)
			statusbar(G);

		/* Draw Jean */
		if (G->jean.flags[6] < 8)
			drawjean(G);

		/* Enemies */
		if (G->enemies.type[0] > 0) {
			if (G->room != 4)
				movenemies(G);
			if ((G->room == 5) || (G->room == 6))
				crusaders(G);
			if (G->room == 10)
				dragon(G);
			if (G->room == 11)
				fireball(G);
			if (G->room == 14)
				plants(G);
			if (G->room == 9)
				drawrope(G);
			if (G->room == 18)
				death(G);
			if ((G->room == 24) && (G->enemies.type[0] == 18))
				satan(G);
			if ((G->room == 24) && (G->jean.flags[6] == 5))
				crusaders(G);
			drawenemies(G);
		}

		/* Shoots */
		if ((G->proyec[0] > 0) && ((G->room == 17) || (G->room == 20) || (G->room == 21) || (G->room == 22)))
		  drawshoots(G);

		/* Jean management */
		if (G->jean.death == 0) {
			if (G->jean.flags[6] < 5) {
					if (G->jean.temp == 0)
						control(G);
					if (G->jean.temp == 1)
						G->jean.temp = 0;
					collisions(G);
					movejean(G);
					}
			if (G->room != 4) {
				touchobj(G);
				contact(G);
			}
			events(G);
		}

		/* Jean death */
		if (G->jean.death == 98) {
			if (G->room != 4) {
				G->room = G->jean.checkpoint[0];
				G->jean.x = G->jean.checkpoint[1];
				G->jean.y = G->jean.checkpoint[2];
				G->jean.jump = 0;
				G->jean.height = 0;
				G->jean.push[0] = 0;
				G->jean.push[1] = 0;
				G->jean.push[2] = 0;
				G->jean.push[3] = 0;
				G->screenchange = 2;
				G->jean.lifes--;
				G->jean.death = 0;
				G->jean.temp = 1;
				music(G);
				AB_ResumeMusic(G);
			}
			else {
				G->jean.death = 0;
				G->jean.flags[6] = 8;
			}
		}
		/* Using flag 6 as counter, to make time */
		if (G->jean.flags[6] > 7)
			G->jean.flags[6] ++;
		/* Reaching 15, jump to ending sequence */
		if (G->jean.flags[6] == 15) {
			G->chapter = 4;
		}
		changescreen(G);
		if (G->screenchange > 0) {
			if ((G->jean.flags[6] < 4) || (G->jean.flags[6] > 5))
				searchenemies(G);
			music(G);
			for (n=0; n<24; n++) { /* Reset enemyshoots */
			  G->proyec[n] = 0;
			}
			G->counter[0] = 0;
			G->screenchange = 0;
		}
		/* Parchments */
		if (G->parchment > 0)
			showparchment(G);
		if (G->jean.flags[6] == 3)
			redparchment(G);
		if (G->jean.flags[6] == 6)
			blueparchment(G);

		/* Flip ! */
		AB_Update(G);

		if (G->parchment > 0) {
			AB_PlaySoundN(G,2,0);
			AB_PauseMusic(G);
			/* Waiting a key */
			while (!G->keypressed)
				keybpause(G);
			G->jean.push[2] = 0;
			G->jean.push[3] = 0;
			G->keypressed = 0;
			AB_ResumeMusic(G);
			G->parchment = 0;
		}
		if (G->jean.flags[6] == 4) {
			AB_PlaySoundN(G,2,0);
			sleep(5);
			G->jean.flags[6] = 5;
			G->jean.direction = 0;
			music(G);
		}
		if (G->jean.flags[6] == 6) {
			sleep(5);
			G->jean.death = 0;
			G->screenchange = 1;
			G->room = 4;
			G->jean.flags[6] = 7;
			G->jean.x = 125;
			G->jean.y = 115;
			G->jean.jump = 1;
		}

		if (G->jean.lifes == 0) {
			AB_HaltMusic(G);
			/* AB_FreeMusic(sonido); */
			G->chapter = 3;
		}

	}

	/* Cleaning */
	AB_DestroyTexture(G,G->fonts);
	for (i=0;i<8;i++)
		AB_FreeMusic(G,G->bso[i]);
	for (i=0;i<7;i++)
		AB_FreeSound(G,G->fx[i]);

}

void animation (struct game *G){

	int i = 0;
	int j = 0;

	unsigned int data = 0;

	for (j=0; j<=21; j++) {
		for (i=0; i<=31; i++) {

			data = G->map.stagedata[G->room][j][i];

			/* Fire animation */
			if ((data == 59) || (data == 60)) {
				if ((G->counter[0] == 1) || (G->counter[0] == 11) || (G->counter[0] == 21)) {
					if (data == 59)
						data = 60;
					else
						data = 59;
				}
			}

			/* Water animation */
			if ((data > 500) && (data < 533)) {
				if (data < 532)
					data ++;
				else
					data = 501;
			}

			G->map.stagedata[G->room][j][i] = data;

		}
	}
}

void counters (struct game *G){

	if (G->counter[0] < 29)
		G->counter[0] ++;
	else
		G->counter[0] = 0;

	if (G->counter[1] < 90)
		G->counter[1] ++;
	else
		G->counter[1] = 0;

	if (G->counter[2] < 8)
		G->counter[2] ++;
	else
		G->counter[2] = 0;

}

void control (struct game *G){

		AB_Events(G);
		G->keypressed=(G->key!=0);

		if (G->joystick.b0) 
				G->joystick.up=TRUE;

		if (G->joystick.up) 
				{
				if ((G->jean.push[0] == 0) && (G->jean.jump == 0) )
					{G->jean.jump = 1; G->jean.ducking=0;}
				}
				
		if (G->joystick.down)
				if ((G->jean.push[1] == 0) && (G->jean.jump == 0))
				{
					G->jean.push[1] = 1;
					G->jean.ducking = 1;
				}
				
		if (G->joystick.left)
				if (G->jean.push[2] == 0) 
				{
					G->jean.push[2] = 1;
					G->jean.push[3] = 0;
				}
				
		if (G->joystick.right)
				if (G->jean.push[3] == 0) 
				{
					G->jean.push[3] = 1;
					G->jean.push[2] = 0;
				}
				

		if (!G->joystick.up) 
		if (!G->joystick.down)
		if (!G->joystick.left)
		if (!G->joystick.right)
			{
				G->jean.push[0] = 0;
				G->jean.push[1] = 0;
				G->jean.push[2] = 0;
				G->jean.push[3] = 0;
			}

}

void events (struct game *G){

	int i = 0;
	int x = 0;
	int y = 0;

	if (G->room == 4) {
		if (G->jean.temp < 7) {
			/* Mover a Jean */
			if (G->counter[1] == 45) {
				switch (G->jean.direction) {
					case 0: G->jean.direction = 1;
									break;
					case 1: G->jean.direction = 0;
									break;
				}
				G->jean.temp ++;
			}
		}
		else {
			G->jean.direction = 0;
			G->jean.death = 1;
		}
	}

	if (G->room == 7) {
		/* Close door */
		if ((G->jean.x > 24) && (G->jean.flags[0] == 0)) {
			G->map.stagedata[7][14][0] = 347;
			G->map.stagedata[7][15][0] = 348;
			G->map.stagedata[7][16][0] = 349;
			G->map.stagedata[7][17][0] = 350;
			G->jean.flags[0] = 1;
			AB_PlaySoundN(G,1,0);
			sleep(1);
		}
	}

	if (G->room == 8) {
		/* Open ground */
		if ((G->jean.x > 15) && (G->jean.flags[1] == 1) && (G->map.stagedata[8][20][26] == 7)) {
			G->map.stagedata[8][20][26] = 38;
			G->map.stagedata[8][20][27] = 0;
			G->map.stagedata[8][21][26] = 0;
			G->map.stagedata[8][21][27] = 0;
			AB_PlaySoundN(G,1,0);
			sleep(1);
		}
		/* Open door */
		if ((G->jean.x > 211) && (G->jean.flags[2] == 1) && (G->map.stagedata[8][14][31] == 343)) {
			G->map.stagedata[8][14][31] = 0;
			G->map.stagedata[8][15][31] = 0;
			G->map.stagedata[8][16][31] = 0;
			G->map.stagedata[8][17][31] = 0;
			AB_PlaySoundN(G,1,0);
			sleep(1);
		}
	}
	if (G->room == 10) {
		/* Dragon fire kills Jean */
		if (((G->jean.x > 127) && (G->jean.x < 144)) && (G->jean.y < 89)) {
			if ((G->enemies.speed[0] > 109) && (G->enemies.speed[0] < 146))
				G->jean.death = 1;
		}
	}
	if (G->room == 19) {
		/* Open door */
		if ((G->jean.y > 16) && (G->jean.flags[3] == 1) && (G->map.stagedata[19][16][0] == 347)) {
			G->map.stagedata[19][16][0] = 0;
			G->map.stagedata[19][17][0] = 0;
			G->map.stagedata[19][18][0] = 0;
			G->map.stagedata[19][19][0] = 0;
			AB_PlaySoundN(G,1,0);
			sleep(1);
		}
	}
	if (G->room == 20) {
		/* Open door */
		if ((G->jean.x > 208) && (G->jean.flags[4] == 1) && (G->map.stagedata[20][14][31] == 343)) {
			G->map.stagedata[20][14][31] = 0;
			G->map.stagedata[20][15][31] = 0;
			G->map.stagedata[20][16][31] = 0;
			G->map.stagedata[20][17][31] = 0;
			AB_PlaySoundN(G,1,0);
			sleep(1);
		}
	}

	if (G->room == 24) {
		if ((G->jean.crosses == 12) && (G->jean.x > 8) && (G->jean.flags[6] == 0)) {
			/* Block entry */
			G->map.stagedata[24][16][0] = 99;
			G->map.stagedata[24][17][0] = 99;
			G->map.stagedata[24][18][0] = 99;
			G->map.stagedata[24][19][0] = 99;
			G->jean.flags[6] = 1;
			/* Mark checkpoint */
			G->jean.checkpoint[0] = 24;
			G->jean.checkpoint[1] = G->jean.x;
			G->jean.checkpoint[2] = G->jean.y;
		}
		if ((G->jean.flags[6] == 1) && (G->jean.crosses > 0) && (G->counter[0] == 0)) {
			/* Putting crosses */
			switch (G->jean.crosses) {
				case 1: x=11;
							  y=5;
							  break;
				case 2: x=10;
							  y=5;
							  break;
				case 3: x=8;
							  y=8;
							  break;
				case 4: x=5;
							  y=8;
							  break;
				case 5: x=4;
							  y=8;
							  break;
				case 6: x=2;
							  y=12;
							  break;
				case 7: x=5;
							  y=14;
							  break;
				case 8: x=6;
							  y=14;
							  break;
				case 9: x=9;
							  y=14;
							  break;
				case 10: x=10;
							 y=14;
							 break;
				case 11: x=13;
							 y=13;
							 break;
				case 12: x=15;
							 y=16;
							 break;
			}
			G->map.stagedata[24][y][x] = 84;
			G->jean.crosses --;
			AB_PlaySoundN(G,1,0);
		}
		if ((G->jean.flags[6] == 1) && (G->jean.crosses == 0) && (G->counter[0] == 29)) {
			/* Draw cup */
			G->map.stagedata[24][3][15] = 650;
			G->jean.flags[6] = 2;
			AB_PlaySoundN(G,1,0);
		}
		/* Killed Satan, Smoke appears */
		if (G->enemies.type[0] == 88) {
			if (G->enemies.speed[0] < 90)
				G->enemies.speed[0] ++;
			else {
				G->enemies.speed[0] = 0;
				G->enemies.type[i] = 0;
				G->enemies.x[0] = 0;
				G->enemies.y[0] = 0;
				G->enemies.type[0] = 17;
				/* Putting red parchment */
				G->map.stagedata[24][14][28] = 339;
				G->map.stagedata[24][14][29] = 340;
				G->map.stagedata[24][15][28] = 341;
				G->map.stagedata[24][15][29] = 342;
			}
		}
	}
}

void music (struct game *G){

	if (G->room == 1) {
		AB_NewMusicN(G,0,1);
	}
	if ((G->room == 2) && (G->prevroom == 1)) {
		AB_NewMusicN(G,1,-1);
	}
	if (G->room == 4) {
		AB_NewMusicN(G,2,1);
	}
	if ((G->room == 5) && (G->prevroom != 6)) {
		AB_NewMusicN(G,7,-1);
	}
	if ((G->room == 6) && (G->prevroom == 7)) {
		AB_NewMusicN(G,7,-1);
	}
	if ((G->room == 7) && (G->prevroom == 6)) {
		AB_NewMusicN(G,1,-1);
	}
	if (((G->room == 8) && (G->prevroom == 9)) || ((G->room == 8) && (G->screenchange == 2))) {
		AB_NewMusicN(G,1,-1);
	}
	if (G->room == 9) {
		AB_NewMusicN(G,3,1);
	}
	if (((G->room == 11) && (G->prevroom == 12)) || ((G->room == 11) && (G->screenchange == 2))) {
		AB_NewMusicN(G,4,-1);
	}
	if (((G->room == 12) && (G->prevroom == 11)) || ((G->room == 12) && (G->screenchange == 2))) {
		AB_NewMusicN(G,1,-1);
	}
	if ((G->room == 13) && (G->prevroom == 14)) {
		AB_NewMusicN(G,1,-1);
	}
	if (((G->room == 14) && (G->prevroom == 13)) || ((G->room == 14) && (G->screenchange == 2))) {
		AB_NewMusicN(G,4,-1);
	}
	if ((G->room == 15) && (G->screenchange == 2)) {
		AB_NewMusicN(G,4,-1);
	}
	if ((G->room == 16) && (G->prevroom == 17)) {
		AB_NewMusicN(G,4,-1);
	}
	if ((G->room == 17) && (G->prevroom == 16)) {
		AB_NewMusicN(G,1,-1);
	}
	if (G->room == 18) {
		AB_NewMusicN(G,5,-1);
	}
	if (((G->room == 19) && (G->prevroom == 18)) || ((G->room == 19) && (G->screenchange == 2))) {
		AB_NewMusicN(G,4,-1);
	}
	if ((G->room == 20) && (G->prevroom == 21)) {
		AB_NewMusicN(G,4,-1);
	}
	if ((G->room == 21) && (G->prevroom == 20)) {
		AB_NewMusicN(G,6,-1);
	}
	if ((G->room == 23) && (G->prevroom == 24)) {
		AB_NewMusicN(G,6,-1);
	}
	if ((G->room == 24) && (G->flag != 5)) {
		AB_NewMusicN(G,5,-1);
	}
	if ((G->room == 24) && (G->flag == 5))
		AB_NewMusicN(G,7,-1);

 	G->screenchange -= 1;

}

void changescreen (struct game *G){

  if ((G->jean.x < 1) && (G->room != 5)) {
		G->prevroom = G->room;
		G->room -= 1;
		G->jean.x = 240;
		G->screenchange = 1;
  }
  if ((G->jean.x + 8) > 256) {
		G->prevroom = G->room;
		G->room += 1;
		G->jean.x = 1;
		G->screenchange = 1;
  }
	if ((G->jean.y + 12 < -16) && (G->jean.jump == 1)) {
		G->prevroom = G->room;
		G->room -=5;
		G->jean.y = 152;
		G->screenchange = 1;
	}
	if ((G->jean.y > 175) && (G->jean.jump != 1)) {
		G->prevroom = G->room;
		G->room +=5;
		G->jean.y = -16;
		G->screenchange = 1;
	}

}

void keybpause (struct game *G){
	
	AB_Events(G);
	G->keypressed=(G->key!=0);

}
