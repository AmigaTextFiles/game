/* jean.c */

# include "abbaye.h"

void movejean (struct game *G){

	/* Jump */
	if (G->jean.jump == 1) {
		if (G->jean.height == 0) /* Jump sound */
			AB_PlaySoundN(G,3,0);
		if (G->jean.height < 56) {
			G->jean.height += 1.6;
			if ((G->jean.collision[0] == 0) && (G->jean.height < 44))
				G->jean.y -= 1.5;
			G->jean.animation = 0;
		}
		else {
			G->jean.jump = 2;
			G->jean.collision[0] = 0;
		}
	}


	/* Move to right */
	if (G->jean.push[3] == 1) {
		G->jean.direction = 1;
		if (G->jean.collision[3] == 0) {
			if (G->jean.jump == 0) {
			  if (G->jean.animation < 13)
					G->jean.animation ++;
			  else
					G->jean.animation = 0;
			}
			if (G->jean.push[1] == 1)
				G->jean.x += 0.30;
			else
				G->jean.x += 0.65;
		}
	}

	/* Move to left */
	if (G->jean.push[2] == 1) {
		G->jean.direction = 0;
		if (G->jean.collision[2] == 0) {
			if (G->jean.jump == 0) {
			  if (G->jean.animation < 13)
					G->jean.animation ++;
			  else
					G->jean.animation = 0;
			}
			if (G->jean.push[1] == 1)
				G->jean.x -= 0.30;
			else
				G->jean.x -= 0.65;
		}

	}

}

void drawjean (struct game *G){

	AB_Rect srctile = {320,88,16,24};
	AB_Rect destile = {0,0,16,24};
	AB_Rect srcducktile = {448,88,18,13};
	AB_Rect desducktile = {0,0,18,13};
	int r = 0;

	if (G->jean.death == 0) {
		if (G->jean.jump > 0) {
			r = 1;
			G->jean.animation = 0;
		}

 		if (G->jean.ducking == 0) {
			srctile.x += (64 * G->jean.direction) + ((G->jean.animation / 7) * 16) + (r * 32);
		 	destile.y = G->jean.y;
			destile.x = G->jean.x;
			if (G->jean.y > 152)
				srctile.h = (176 - G->jean.y);
			if (G->grapset == 1)
				srctile.y = 208;
			AB_DrawSprite(G,G->tiles,&srctile,&destile);
		}
		else {
  		srcducktile.x += (G->jean.direction * 36) + ((G->jean.animation / 7) * 18);
  		desducktile.y = G->jean.y + 11;
			desducktile.x = G->jean.x;
			if (G->grapset == 1)
				srcducktile.y = 208;
			AB_DrawSprite(G,G->tiles,&srcducktile,&desducktile);
		}
	}

	/* Death animation */
	if (G->jean.death > 0) {
		G->jean.death += 1;
		destile.x = G->jean.x;
		destile.y = G->jean.y;
		AB_PauseMusic(G);
		if (G->jean.death == 2)
			AB_PlaySoundN(G,6,0);
		if ((G->jean.death < 8) || ((G->jean.death > 23) && (G->jean.death < 32)) || ((G->jean.death > 47) && (G->jean.death < 56))) {
			srctile.x = 368 + (G->jean.direction * 64);
			if (G->grapset == 1)
				srctile.y = 208;
			AB_DrawSprite(G,G->tiles,&srctile,&destile);
		}
		if (((G->jean.death > 7) && (G->jean.death < 16)) || ((G->jean.death > 31) && (G->jean.death < 40)) || ((G->jean.death > 55) && (G->jean.death < 64))) {
			srctile.x = 536;
			if (G->grapset == 1)
				srctile.y = 207;
			else
				srctile.y = 87;
			AB_DrawSprite(G,G->tiles,&srctile,&destile);
		}
		if (((G->jean.death > 15) && (G->jean.death < 24)) || ((G->jean.death > 39) && (G->jean.death < 48)) || ((G->jean.death > 63) && (G->jean.death < 73))) {
			srctile.x = 520;
			if (G->grapset == 1)
				srctile.y = 207;
			else
				srctile.y = 87;
			AB_DrawSprite(G,G->tiles,&srctile,&destile);
		}
	}

	/* Animation hab. 24 */
	if ((G->jean.flags[6] == 5) && (G->counter[1] == 45)) {
		switch (G->jean.direction) {
			case 0: G->jean.direction = 1;
							break;
			case 1: G->jean.direction = 0;
							break;
		}
	}

}

void collisions (struct game *G){

	int blleft = 0;
	int blright = 0;
	int blground[4] = {0,0,0,0};
	int blroof[2] = {0,0};
	int points[8] = {0,0,0,0,0,0,0,0};
	int n = 0;
	int pixel = 0;
	int r = 0;

	points[0] = (G->jean.x + 1) / 8;
	points[1] = (G->jean.x + 7) / 8;
	points[2] = (G->jean.x + 8) / 8;
	points[3] = (G->jean.x + 13) / 8;
	points[4] = (G->jean.y + 1) / 8;
	points[5] = (G->jean.y + 8) / 8;
	points[6] = (G->jean.y + 15) / 8;
	points[7] = (G->jean.y + 23) / 8;

	G->jean.collision[0] = 0;
	G->jean.collision[1] = 0;
	G->jean.collision[2] = 0;
	G->jean.collision[3] = 0;

	/* Left & Right collisions */
	if (G->jean.ducking == 0) {
		for (n=4; n<8; n++) {
			if (((points[0] != 0) && (G->jean.direction ==0)) || ((points[3] != 31) && (G->jean.direction == 1))) {
				blleft = G->map.stagedata[G->room][points[n]][points[0] - 1];
				blright = G->map.stagedata[G->room][points[n]][points[3] + 1];
				if (((blleft > 0) && (blleft < 100) && (blleft != 16) && (blleft != 38) && (blleft != 37)) || ((G->map.stagedata[G->room][points[4]][points[0]] == 128) || (blleft == 348))) {
					if (G->jean.x - ((points[0] - 1) * 8 + 7) < 1.1)
						G->jean.collision[2] = 1;
				}
				if (((blright > 0) && (blright < 100) && (blright != 16) && (blright != 38) && (blright != 37)) || (blright == 344)) {
					if (((points[3] + 1) * 8) - (G->jean.x + 14) < 1.1)
						G->jean.collision[3] = 1;
				}
			}
		}
	}

	/* Collision with Jean ducking */
	if (G->jean.ducking == 1) {
		if (((points[0] != 0) && (G->jean.direction ==0)) || ((points[3] != 31) && (G->jean.direction == 1))) {
			r = (G->jean.y + 16) / 8;
			blleft = G->map.stagedata[G->room][r][points[0] - 1];
			blright = G->map.stagedata[G->room][r][points[3] + 1];
			if (((blleft > 0) && (blleft < 100) && (blleft != 37)) || ((G->map.stagedata[G->room][r][points[0]] == 128) || ((blleft > 346) && (blleft < 351)))) {
				if (G->jean.x - ((points[0] - 1) * 8 + 7) < 1.1)
					G->jean.collision[2] = 1;
			}
			if (((blright > 0) && (blright < 100) && (blright != 37)) || ((blright > 342) && (blright< 347))) {
				if (((points[3] + 1) * 8) - (G->jean.x + 14) < 1.1)
					G->jean.collision[3] = 1;
			}
		}
		/* Invisible wall */
		if ((G->room == 11) && (r == 5)) {
			if ((points[0] - 1 == 0) || (points[0] - 1 == 1))
				G->jean.collision[2] = 0;
			if ((points[3] + 1 == 0) || (points[3] + 1 == 1))
				G->jean.collision[3] = 0;
		}
		if ((G->room == 10) && (r == 5)) {
			if ((points[0] - 1 > 27) && (points[0] - 1 < 32))
				G->jean.collision[2] = 0;
			if ((points[3] + 1 > 27) && (points[3] + 1 < 32))
				G->jean.collision[3] = 0;
		}
	}

	/* Touch ground collision */
	blground[0] = G->map.stagedata[G->room][points[7]+1][points[0]];
	blground[1] = G->map.stagedata[G->room][points[7]+1][points[1]];
	blground[2] = G->map.stagedata[G->room][points[7]+1][points[2]];
	blground[3] = G->map.stagedata[G->room][points[7]+1][points[3]];

	if (G->jean.jump != 1) {
		/* Invisible ground */
		if (((G->room == 11) && (points[7]+1 > 19) && (points[0] == 2)) || ((G->room == 16) && ((G->jean.y / 8) < 4) && (points[0] == 2))) {
			G->jean.y += G->jean.gravity;
			G->jean.jump = 2;
		}
		else {
			if (((blground[0] > 0) && (blground[0] < 100)) || ((blground[1] > 0) && (blground[1] < 100)) || ((blground[2] > 0) && (blground[2] < 100)) || ((blground[3] > 0) && (blground[3] < 100))) {
				G->jean.ground = (points[7] + 1) * 8;
				if (points[7] + 1 > 21) /* Dirty trick to make Jean go bottom of the screen */
					G->jean.ground = 300;
				if ((G->jean.ground - 1) - (G->jean.y+23) > 1.2)
					G->jean.y += G->jean.gravity;
				else { /* Near ground */
					G->jean.y += (G->jean.ground - 1) - (G->jean.y + 23);
					G->jean.height = 0;
					G->jean.jump = 0;
					G->jean.flags[5] = 0;
				}
			}
			else {/* In air, ground near */
				G->jean.y += G->jean.gravity;
				G->jean.jump = 2;
			}
		}
	}

	/* Check small platforms */
	if (G->jean.direction == 0) {
		if ((blground[3] == 38) && ((G->jean.x + 13) < (points[3] * 8 + 5)) && (G->jean.push[2] == 1) && (G->jean.jump ==0)) {
			G->jean.y += G->jean.gravity;
			G->jean.jump = 2;
		}
	}
	if (G->jean.direction == 1) {
		if ((blground[0] == 38) && ((G->jean.x + 1) > (points[0] + 2)) && (G->jean.push[3] == 1) && (G->jean.jump == 0)) {
			G->jean.y += G->jean.gravity;
			G->jean.jump = 2;
		}
	}

	/* Touch roof collision */
	blroof[0] = G->map.stagedata[G->room][points[4]-1][points[0]];
	blroof[1] = G->map.stagedata[G->room][points[4]-1][points[3]];

	if ((G->jean.jump == 1) && (points[4] > 0)) {
		if (((blroof[0] > 0) && (blroof[0] < 100) && (blroof[0] != 16) && (blroof[0] != 38) && (blroof[0] != 37)) || ((blroof[1] > 0) && (blroof[1] < 100) && (blroof[1] != 16) && (blroof[1] != 38) && (blroof[1] != 37))) {
			if ((G->jean.y - 1) - ((points[4] - 1) * 8 + 7) < 1)
				G->jean.collision[0] = 1;
		}
	}

}

void touchobj (struct game *G){

	int x = 0;
	int y = 0;
	int h = 0;
	int v = 0;
	int r = 0;
	int flag = 0;

	x = (G->jean.x + 2) / 8;
	y = G->jean.y / 8;

	if (y > 0) {

		/* Touch spikes, water or fire */
		if (((G->map.stagedata[G->room][y+3][x] == 5) || (G->map.stagedata[G->room][y+3][x+1] == 5)) || (((G->map.stagedata[G->room][y+3][x] > 500) && (G->map.stagedata[G->room][y+3][x] < 532))|| ((G->map.stagedata[G->room][y+3][x+1] > 500) && (G->map.stagedata[G->room][y+3][x+1] < 532))) || (((G->map.stagedata[G->room][y+3][x] == 59) || (G->map.stagedata[G->room][y+3][x] == 59)) || ((G->map.stagedata[G->room][y+3][x+1] == 60) && (G->map.stagedata[G->room][y+3][x+1] == 60)))) {
			if ((G->room == 11) && (y+3 == 20) && (x < 4))
				G->jean.death = 0;
			else {
				if (G->jean.death == 0)
					G->jean.death = 1;
			}
		}

		/* Touch checkpoint */
		if (((G->map.stagedata[G->room][y][x] > 320) &&  (G->map.stagedata[G->room][y][x] < 325)) || ((G->map.stagedata[G->room][y][x+1] > 320) &&  (G->map.stagedata[G->room][y][x+1] < 325))) {
			for (v=0;v<22;v++) {
				for (h=0;h<32;h++) {
					if ((G->map.stagedata[G->room][v][h] > 320) && (G->map.stagedata[G->room][v][h] < 325))
						G->map.stagedata[G->room][v][h] += 6;
				}
			}
			G->jean.checkpoint[3] = G->jean.checkpoint[0];
			G->jean.checkpoint[0] = G->room;
			G->jean.checkpoint[1] = G->jean.x;
			G->jean.checkpoint[2] = G->jean.y;
			/* Old checkpoint returns to original state */
			for (v=0;v<22;v++) {
				for (h=0;h<32;h++) {
					if ((G->map.stagedata[G->jean.checkpoint[3]][v][h] > 326) && (G->map.stagedata[G->jean.checkpoint[3]][v][h] < 331))
						G->map.stagedata[G->jean.checkpoint[3]][v][h] -= 6;
				}
			}
			AB_PlaySoundN(G,2,0);
		}

		/* Touch bell */
		if (G->room == 2) {
			if (((G->map.stagedata[G->room][y+1][x] > 300) &&  (G->map.stagedata[G->room][y+1][x] < 305)) || ((G->map.stagedata[G->room][y+1][x+1] > 300) &&  (G->map.stagedata[G->room][y+1][x+1] < 305))) {
				for (v=1;v<3;v++) {
					for (h=5;h<7;h++) {
						if ((G->map.stagedata[G->room][v][h] > 300) && (G->map.stagedata[G->room][v][h] < 305))
							G->map.stagedata[G->room][v][h] += 4;
					}
				}
				G->jean.flags[1] = 1;
				AB_PauseMusic(G);
				AB_PlaySoundN(G,5,0);
				sleep(2);
				AB_ResumeMusic(G);
			}
		}

		/* Touch lever */
		if (((G->map.stagedata[G->room][y+1][x] > 308) && (G->map.stagedata[G->room][y+1][x] < 313)) || ((G->map.stagedata[G->room][y+1][x+1] > 308) && (G->map.stagedata[G->room][y+1][x+1] < 313))) {
			for (v=0;v<22;v++) {
				for (h=0;h<32;h++) {
					if ((G->map.stagedata[G->room][v][h] > 308) && (G->map.stagedata[G->room][v][h] < 313))
						G->map.stagedata[G->room][v][h] += 4;
				}
			}
			if (G->room == 9)
				G->jean.flags[3] = 1;
			if (G->room == 10)
				G->jean.flags[2] = 1;
			if (G->room == 20)
				G->jean.flags[4] = 1;
			AB_PauseMusic(G);
			AB_PlaySoundN(G,5,0);
			sleep(2);
			AB_ResumeMusic(G);
		}


		/* Touch hearts */
		if (G->room == 23) {
			if (((G->map.stagedata[G->room][y+1][x] > 400) &&  (G->map.stagedata[G->room][y+1][x] < 405)) || ((G->map.stagedata[G->room][y+1][x+1] > 400) &&  (G->map.stagedata[G->room][y+1][x+1] < 405))) {
				if (G->jean.x > 160) {
					G->map.stagedata[23][7][23] = 0;
					G->map.stagedata[23][7][24] = 0;
					G->map.stagedata[23][8][23] = 0;
					G->map.stagedata[23][8][24] = 0;
				}
				else {
					G->map.stagedata[23][18][8] = 0;
					G->map.stagedata[23][18][9] = 0;
					G->map.stagedata[23][19][8] = 0;
					G->map.stagedata[23][19][9] = 0;
				}
				if (G->jean.lifes < 9)
					G->jean.lifes += 1;
				AB_PlaySoundN(G,2,0);
			}
		}
		else {
			if (((G->map.stagedata[G->room][y+1][x] > 400) &&  (G->map.stagedata[G->room][y+1][x] < 405)) || ((G->map.stagedata[G->room][y+1][x+1] > 400) &&  (G->map.stagedata[G->room][y+1][x+1] < 405))) {
				for (v=0;v<22;v++) {
					for (h=0;h<32;h++) {
						if ((G->map.stagedata[G->room][v][h] > 400) && (G->map.stagedata[G->room][v][h] < 405))
							G->map.stagedata[G->room][v][h] = 0;
					}
				}
				if (G->jean.lifes < 9)
					G->jean.lifes += 1;
				AB_PlaySoundN(G,2,0);
			}
		}

		/* Touch crosses */
		if (((G->map.stagedata[G->room][y+1][x] > 408) &&  (G->map.stagedata[G->room][y+1][x] < 413)) || ((G->map.stagedata[G->room][y+1][x+1] > 408) &&  (G->map.stagedata[G->room][y+1][x+1] < 413)) || ((G->map.stagedata[G->room][y+2][x] > 408) &&  (G->map.stagedata[G->room][y+2][x] < 413))) {
			for (v=0;v<22;v++) {
				for (h=0;h<32;h++) {
					if ((G->map.stagedata[G->room][v][h] > 408) && (G->map.stagedata[G->room][v][h] < 413))
						G->map.stagedata[G->room][v][h] = 0;
				}
			}
			G->jean.crosses += 1;
			AB_PlaySoundN(G,2,0);
		}

		/* Touch yellow parchment */
		if (((G->map.stagedata[G->room][y+1][x] > 316) &&  (G->map.stagedata[G->room][y+1][x] < 321)) || ((G->map.stagedata[G->room][y+1][x+1] > 316) &&  (G->map.stagedata[G->room][y+1][x+1] < 321))) {
			for (v=0;v<22;v++) {
				for (h=0;h<32;h++) {
					if ((G->map.stagedata[G->room][v][h] > 316) && (G->map.stagedata[G->room][v][h] < 321))
						G->map.stagedata[G->room][v][h] = 0;
				}
			}
			G->parchment = G->room;
		}

		/* Touch red parchment */
		if (((G->map.stagedata[G->room][y+1][x] > 338) &&  (G->map.stagedata[G->room][y+1][x] < 343)) || ((G->map.stagedata[G->room][y+1][x+1] > 338) &&  (G->map.stagedata[G->room][y+1][x+1] < 343))) {
			G->jean.flags[6] = 3;
			/* Delete parchment */
			G->map.stagedata[24][14][28] = 0;
			G->map.stagedata[24][14][29] = 0;
			G->map.stagedata[24][15][28] = 0;
			G->map.stagedata[24][15][29] = 0;
		}

		/* Touch door */
		if ((G->room == 10) || (G->room == 19)) {
			if (G->map.stagedata[G->room][y][x] == 154) {
				switch (G->room) {
					case 10: G->room = 19;
									 G->jean.x = 160;
									 G->jean.y = 120;
									 break;
				  case 19: G->room = 10;
									 G->jean.x = 176;
									 G->jean.y = 136;
								   break;
				}
				AB_PlaySoundN(G,1,0);
				G->screenchange = 1;
			}
		}

		/* Touch switch */
		if (G->room == 17) {
			if ((((G->map.stagedata[G->room][y+1][x] > 330) && (G->map.stagedata[G->room][y+1][x] < 339)) || ((G->map.stagedata[G->room][y+1][x+1] > 330) && (G->map.stagedata[G->room][y+1][x+1] < 339))) && (G->jean.flags[5] == 0)) {
				for (v=2;v<4;v++) {
					for (h=15;h<17;h++) {
						if ((G->map.stagedata[G->room][v][h] > 330) && (G->map.stagedata[G->room][v][h] < 335)) {
							G->map.stagedata[G->room][v][h] += 4;
							G->jean.flags[5] = 1;
						}
						if (((G->map.stagedata[G->room][v][h] > 334) && (G->map.stagedata[G->room][v][h] < 339)) && (G->jean.flags[5] == 0))
							G->map.stagedata[G->room][v][h] -= 4;
					}
				}
				G->jean.flags[5] = 1;
				/* Flapping all crosses  */
				for (r=1; r<25; r++) {
					for (v=0; v<22; v++) {
						for (h=0; h<32; h++) {
							flag = 0;
							/* Crosses enabled */
							if ((G->map.stagedata[r][v][h] > 408) && (G->map.stagedata[r][v][h] < 413)) {
								G->map.stagedata[r][v][h] += 16;
								flag = 1;
							}
							/* Crosses disabled */
							if ((G->map.stagedata[r][v][h] > 424) && (G->map.stagedata[r][v][h] < 429) && (flag == 0))
								G->map.stagedata[r][v][h] -= 16;
						}
					}
				}
			AB_PauseMusic(G);
			AB_PlaySoundN(G,5,0);
			sleep(2);
			AB_ResumeMusic(G);
			}
		}

		/* Touch cup */
		if (G->room == 24) {
			if ((G->map.stagedata[G->room][y][x+1] == 650) || (G->map.stagedata[G->room][y+1][x+1] == 650) || (G->map.stagedata[G->room][y+2][x+1] == 650)) {
				AB_HaltMusic(G);
				AB_PlaySoundN(G,5,0);
				sleep(2);
				G->map.stagedata[24][3][15] = 0; /* Delete cup */
				/* Delete crosses */
				for (v=0; v<22; v++) {
					for (h=0; h<32; h++) {
						if (G->map.stagedata[G->room][v][h] == 84)
							G->map.stagedata[G->room][v][h] = 0;
					}
				}
				/* Delete Satan */
				G->enemies.type[0] = 88;
				G->enemies.speed[0] = 0; /* Using speed as G->counter */
				G->enemies.adjustx1[0] = 0;
				G->enemies.adjustx2[0] = 0;
				G->enemies.adjusty1[0] = 0;
				G->enemies.adjusty2[0] = 0;
				/* Deleting shoots */
				for (v=0;v<24;v++)
					G->proyec[v] = 0;
				/* Init crusaders */
				for (v=1;v<7;v++)
					G->enemies.type[v] = 17;
				G->enemies.adjustx2[0] = 15;
				G->enemies.adjusty2[0] = 23;
			}
		}

	}

}

void contact (struct game *G){

	int i = 0;
	int half = 0; /* Half size of enemy sprite */
	int points[4] = {0,0,0,0}; /* 4 points of collision of enemy sprite */
	int x = 0;
	int y = 0;
	int n = 0;
	
	if(G->trainer) return;

	/* Collisions with enemies */
	for (i=0;i<7;i++) {
		if (((G->enemies.type[i] > 0) && (G->enemies.type[i] != 12)) || ((G->enemies.type[i] == 12) && (G->enemies.y[i] > G->enemies.limleft[i] + 8))) {
			/* Setting points of collision... */
			points[0] = G->enemies.x[i] + G->enemies.adjustx1[i];
			points[1] = G->enemies.x[i] + G->enemies.adjustx2[i];
			points[2] = G->enemies.y[i] + G->enemies.adjusty1[i];
			points[3] = G->enemies.y[i] + G->enemies.adjusty2[i];
			/* Checking... */
			for (x=points[0];x<=points[1];x++) {
				if ((x>G->jean.x+1) && (x<G->jean.x+13)) {
					for (y=points[2];y<=points[3];y++) {
						if ((y>G->jean.y+(G->jean.ducking*8)) && (y<G->jean.y+22)) {
							if (G->jean.flags[6] < 5) {
								G->jean.death = 1;
								y=points[3] + 1;
								x=points[1] + 1;
							}
							else {
								/* Mix_HaltMusic (); */
								G->jean.flags[6] = 6;
							}
						}
					}
				}
			}

		}
	}

	/* Collision with shoots */
	for (i=0;i<3;i++) {
		if (G->proyec[i*2] > 0) {
			/* Setting points of collision */
			if (G->enemies.type[i] == 11) { /* Gargoyle */
				points[0] = G->proyec[i*2];
				points[1] = G->proyec[i*2]+10;
				points[2] = G->enemies.y[i] + 10;
				points[3] = G->enemies.y[i] + 12;
			}

			if (G->enemies.type[i] == 15) { /* Archers */
				points[0] = G->proyec[i*2] + 3;
				points[1] = G->proyec[i*2] + 7;
				points[2] = G->enemies.y[i] + 10;
				points[3] = G->enemies.y[i] + 17;
			}
			for (x=points[0];x<=points[1];x++) {
				if ((x>G->jean.x+3) && (x<G->jean.x+13)) {
					for (y=points[2];y<=points[3];y++) {
						if ((y>(G->jean.y+5+(G->jean.ducking*8))) && (y<G->jean.y+22)) {
							G->jean.death = 1;
							y=points[3] + 1;
							x=points[1] + 1;
						}
					}
				}
			}

		}

	}

	/* Check collision with plants shoots, dragon, death and Satan */
	if ((G->room == 10) || (G->room == 14) || (G->room == 18) || (G->room == 24)) {
		for (i=0;i<23;i+=2) {
			if (G->proyec[i] > 0) {
				if (G->room == 18) {
					points[0] = G->proyec[i+1];
					points[1] = G->proyec[i+1]+15;
					points[2] = G->proyec[i];
					points[3] = G->proyec[i] + 15;
				}
				if ((G->room == 14) || (G->room == 24)) {
					points[0] = G->proyec[i];
					points[1] = G->proyec[i] + 3;
					points[2] = G->proyec[i+1];
					points[3] = G->proyec[i+1] + 3;
				}
				if (G->room == 10) {
					points[0] = G->proyec[i];
					points[1] = G->proyec[i] + 8;
					points[2] = 88;
					points[3] = 96;
				}

				for (x=points[0];x<=points[1];x++) {
					if ((x>G->jean.x+1) && (x<G->jean.x+13)) {
						for (y=points[2];y<=points[3];y++) {
							if ((y>G->jean.y+(G->jean.ducking*8)) && (y<G->jean.y+22)) {
								G->jean.death = 1;
								y=points[3] + 1;
								x=points[1] + 1;
								i= 17;
							}
						}
					}
				}
			}
		}
	}

}
