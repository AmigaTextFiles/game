/* enemies.c */

# include "abbaye.h"

void searchenemies (struct game *G){

	int y = 0;

  for (y=0; y<7; y++) {
		G->enemies.type[y] 	= G->map.enemydata[G->room][y][0];
		G->enemies.x[y] 		= G->map.enemydata[G->room][y][1];
		G->enemies.y[y] 		= G->map.enemydata[G->room][y][2];
		G->enemies.direction[y] = G->map.enemydata[G->room][y][3];
		G->enemies.tilex[y] 	= G->map.enemydata[G->room][y][4];
		G->enemies.tiley[y] 	= G->map.enemydata[G->room][y][5];
		G->enemies.animation[y] = G->map.enemydata[G->room][y][6];
		G->enemies.limleft[y] = G->map.enemydata[G->room][y][7];
		G->enemies.limright[y] = G->map.enemydata[G->room][y][8];
		G->enemies.speed[y] = G->map.enemydata[G->room][y][9];
		G->enemies.fire[y] = G->map.enemydata[G->room][y][10];
		G->enemies.adjustx1[y] = G->map.enemydata[G->room][y][11];
		G->enemies.adjustx2[y] = G->map.enemydata[G->room][y][12];
		G->enemies.adjusty1[y] = G->map.enemydata[G->room][y][13];
		G->enemies.adjusty2[y] = G->map.enemydata[G->room][y][14];
  }

  G->screenchange -= 1;

}

void drawenemies (struct game *G){

	AB_Rect srctile = {0,0,16,16};
	AB_Rect destile = {0,0,16,16};

	int i = 0;

	for (i=0; i<7; i++) {
		if ((G->enemies.type[i] > 0) && (G->enemies.type[i] < 16)) {
	  	if ((G->enemies.type[i] == 3) || (G->enemies.type[i] == 5) || (G->enemies.type[i] == 15)) {
				srctile.h = 24;
				destile.h = 24;
			}
	  	else {
				srctile.h = 16;
				destile.h = 16;
			}
	  	if (G->enemies.type[i] == 6) {
				srctile.x = G->enemies.tilex[i] + (G->enemies.animation[i] * 24);
				srctile.w = 24;
				destile.w = 24;
	  	}
	  	else {
				if (G->enemies.type[i] == 15)
					srctile.x = G->enemies.tilex[i] + (G->enemies.animation[i] * 16);
				else
					srctile.x = G->enemies.tilex[i] + (G->enemies.animation[i] * 16);
				srctile.w = 16;
				destile.w = 16;
	  	}
	  	srctile.y = G->enemies.tiley[i] + (G->grapset * 120);
	  	destile.x = G->enemies.x[i];
	  	destile.y = G->enemies.y[i];
	  	if (((G->enemies.type[i] != 13) && (G->enemies.type[i] != 14)) || (((G->enemies.type[i] == 13) || (G->enemies.type[i] == 14)) && (G->enemies.y[i] < G->enemies.limright[i] - 8)))
				AB_DrawSprite(G,G->tiles,&srctile,&destile);

	  	if (G->enemies.type[i] == 13) { /* Water movement */
				if (((G->enemies.speed[i] > 30) && (G->enemies.speed[i] < 40)) || ((G->enemies.y[i] == G->enemies.limright[i] - 16) && (G->enemies.direction[i] == 1))) {
		  		srctile.x = 368;
					srctile.y = 32 + (G->grapset * 120);
				  srctile.h = 8;
					destile.h = 8;
				  destile.y = G->enemies.limright[i];
					AB_DrawSprite(G,G->tiles,&srctile,&destile);
					if ((G->enemies.speed[i] > 30) && (G->enemies.speed[i] < 40))
						AB_PlaySoundN(G,4,0);
				}
				if (((G->enemies.speed[i] > 39) && (G->enemies.speed[i] < 45)) || ((G->enemies.y[i] == G->enemies.limright[i] - 10) && (G->enemies.direction[i] == 1))) {
			  	srctile.x = 384;
					srctile.y = 32 + (G->grapset * 120);
				  srctile.h = 8;
					destile.h = 8;
				  destile.y = G->enemies.limright[i];
					AB_DrawSprite(G,G->tiles,&srctile,&destile);
				}
	  	}
		}
		/* Draw smoke */
		if (G->enemies.type[i] == 88) {
			if ((G->enemies.speed[i] < 10) || ((G->enemies.speed[i] > 19) && (G->enemies.speed[i] < 30)) || ((G->enemies.speed[i] > 39) && (G->enemies.speed[i] < 50)))
				srctile.x = 696;
			else
				srctile.x = 728;
			srctile.y = 0 + (G->grapset * 120);
			srctile.w = 32;
			srctile.h = 48;
			destile.w = 32;
			destile.h = 48;
			destile.x = G->enemies.x[i];
			destile.y = G->enemies.y[i];
			AB_DrawSprite(G,G->tiles,&srctile,&destile);
			if (G->enemies.speed[i] == 5)
				AB_PlaySoundN(G,6,0);
		}

	}

}

void movenemies (struct game *G){

	int i = 0;
	int tilex = 0;
	int tiley = 0;
	int n = 0;

	for (i=0; i<7; i++) {
		if ((G->enemies.type[i] > 0) && (G->enemies.type[i] < 10)) {
			if (G->enemies.direction[i] == 0) { /* Go right */
				if ((G->enemies.x[i] + 1) < G->enemies.limright[i])
					G->enemies.x[i] += G->enemies.speed[i] * 0.10;
				else {
					G->enemies.direction[i] = 1;
					if (G->enemies.type[i] != 2) {
						if (G->enemies.type[i] == 6)
							G->enemies.tilex[i] -= 48;
						else
							G->enemies.tilex[i] -= 32;
					}
				}
			}
			if (G->enemies.direction[i] == 1) { /* Go left */
				if ((G->enemies.x[i] - 1) > G->enemies.limleft[i])
					G->enemies.x[i] -= G->enemies.speed[i] * 0.10;
				else {
					G->enemies.direction[i] = 0;
					if (G->enemies.type[i] != 2) {
						if (G->enemies.type[i] == 6)
							G->enemies.tilex[i] += 48;
						else
							G->enemies.tilex[i] += 32;
					}
				}
			}
			if (G->enemies.direction[i] == 2) { /* Go up */
				if ((G->enemies.y[i] - 1) > G->enemies.limleft[i])
					G->enemies.y[i] -= G->enemies.speed[i] * 0.10;
				else {
					G->enemies.direction[i] = 3;
					if (G->enemies.type[i] == 4)
						G->enemies.tilex[i] += 32;
					if (G->enemies.type[i] == 5)
						G->enemies.tilex[i] += 16;
				}
			}
			if (G->enemies.direction[i] == 3) { /* Go down */
				if ((G->enemies.y[i] + 1) < G->enemies.limright[i])
					G->enemies.y[i] += G->enemies.speed[i] * 0.10;
				else {
					G->enemies.direction[i] = 2;
					if (G->enemies.type[i] == 4)
					G->enemies.tilex[i] -= 32;
					if (G->enemies.type[i] == 5)
					G->enemies.tilex[i] -= 16;
				}
			}

		}

		/* Animation */
		if (G->enemies.type[i] < 10) {
			if (((G->counter[0] == 1) || (G->counter[0] == 11) || (G->counter[0] == 21)) && (G->enemies.type[i] != 5)){
				if (G->enemies.animation[i] == 0)
					G->enemies.animation[i] = 1;
				else
					G->enemies.animation[i] = 0;
			}
		}

		/* Enemy's shoots */
		if ((G->enemies.type[i] == 15) || (G->enemies.type[i] == 11)) {
			if (G->enemies.type[i] == 15) { /* Move enemies looking at Jean */
				if ((G->jean.x + 23) < (G->enemies.x[i]) && (G->enemies.speed[i] == 0)) {
					G->enemies.tilex[i] = 256;
					G->enemies.direction[i] = 1;
				}
				if ((G->jean.x > (G->enemies.x[i] + 16)) && (G->enemies.speed[i] == 0)) {
					G->enemies.tilex[i] = 288;
					G->enemies.direction[i] = 0;
				}
			}
			if (i == 0) {
				if (G->enemies.speed[i] < 55) {
					G->enemies.speed[i] ++;
					G->enemies.animation[i] = 1;
				}
				else
					G->enemies.animation[i] = 0;
			}
			else {
				G->enemies.speed[i] = G->enemies.speed[0];
				G->enemies.animation[i] = G->enemies.animation[0];
			}
			/* Enable fire */
			if (G->enemies.speed[i] == 50) {
				for (n=0; n<=4; n+=2) {
					if (G->proyec[n] == 0) {
						G->enemies.fire[i] = 1;
						G->proyec[n] = G->enemies.x[i] - 8;
						if (n > 0)
							G->proyec[n+1] = i;
						n = 5;
						AB_PlaySoundN(G,0,0);
					}
				}
			}
		}

		if (G->enemies.type[i] == 12) { /* Water drop */
			if (G->enemies.speed[i] < 60)
				G->enemies.speed[i] ++; /* Using speed like G->counter */
			G->enemies.tilex[i] = 640 + ((G->enemies.speed[i] / 30) * 16);
			if (G->enemies.tilex[i] == 672) {
				if (G->enemies.y[i] < (G->enemies.limright[i] -8))
					G->enemies.y[i] += 0.9;
				else { /* Reboot drop */
					G->enemies.y[i] = G->enemies.limleft[i]; /* Using limleft like drop start */
					G->enemies.speed[i] = 0;
					G->enemies.tilex[i] = 640;
				}
			}
		}

		if ((G->enemies.type[i] == 13) || (G->enemies.type[i] == 14)) { /* Fireballs & fishes */
			if ((G->counter[0] == 1) || (G->counter[0] == 11) || (G->counter[0] == 21)) {
				if (G->enemies.animation[i] == 0)
					G->enemies.animation[i] = 1;
				else
					G->enemies.animation[i] = 0;
			}
			if (G->enemies.direction[i] == 0) { /* Fireball going up */
				if (G->enemies.y[i] == (G->enemies.limright[i])) {
					if (G->enemies.speed[i] < 45) /* Temp */
						G->enemies.speed[i] ++;
					else
						G->enemies.y[i] --;
				}
				else {
					if (G->enemies.y[i] > (G->enemies.limleft[i] + 16))
						G->enemies.y[i] -= 2;
					else
						G->enemies.y[i] --;
				}
				if (G->enemies.y[i] == G->enemies.limleft[i] + 8)
					G->enemies.direction[i] = 1;
			}
			else {
				if (G->enemies.y[i] != G->enemies.limright[i])
					G->enemies.y[i] += 2;
				else { /* Reboot */
					G->enemies.speed[i] = 0;
					G->enemies.direction[i] = 0;
				}
			}
		}

	}
}

void plants (struct game *G){

	AB_Rect srctile = {0,40,16,16};
	AB_Rect destile = {0,0,16,16};
	AB_Rect srcfire = {660,32,4,4};
	AB_Rect desfire = {0,0,4,4};
	int n = 0;
	int r = 0;

	/* Animation */

	for (n=1; n<4; n++) {
		if (G->enemies.speed[n] < (140 + ((n-1) * 30)))
			G->enemies.speed[n] ++;
		else
			G->enemies.speed[n] = 0;

		if (G->enemies.speed[n] < (100 + ((n-1) * 30)))
			G->enemies.animation[n] = 0;
		else
			G->enemies.animation[n] = 1;

		srctile.x = 384 + (G->enemies.animation[n] * 16);
		srctile.y = 40 + (G->grapset * 120);
		destile.x = G->enemies.x[n];
		destile.y = G->enemies.y[n];

		AB_DrawSprite(G,G->tiles,&srctile,&destile);
  }

	/* Init fire */
	for (n=1; n<4; n++) {
		if (G->enemies.speed[n] == 135 + ((n-1) * 30)) {
	 	 r = (n-1) * 4;
	  	G->proyec[r] = G->enemies.x[n] - 1;
	  	G->proyec[r+1] = G->enemies.y[n] - 1;
	  	G->proyec[r+2] = G->enemies.x[n] + 16;
	  	G->proyec[r+3] = G->enemies.y[n] - 1;
	  	AB_PlaySoundN(G,0,0);
		}
	}

	/* Move fires */
	for (n=1; n<4; n++) {
		r = (n-1) * 4;
		if (G->proyec[r] > 0) {
			if (G->enemies.direction[n] == 0) {
				if (G->enemies.y[n] - G->proyec[r+1] < 24) {
					G->proyec[r+1] --;
					G->proyec[r+3] --;
				}
				else
					G->enemies.direction[n] = 1;
				if (G->counter[0] % 2 == 0) {
					G->proyec[r] --;
					G->proyec[r+2] ++;
				}
			}
			if ((G->enemies.direction[n]>0) && (G->enemies.direction[n] < 6)) {
				G->proyec[r] --;
				G->proyec[r+2] ++;
				G->enemies.direction[n] ++;
			}
			if (G->enemies.direction[n] == 6) {
				if (G->proyec[r+1] < G->enemies.limleft[n]) {
					G->proyec[r+1] += 2;
					if (G->counter[0] % 2 == 0)
						G->proyec[r] --;
				}
				else {
					G->proyec[r] = 0;
					G->proyec[r+1] = 0;
				}
				if ((G->proyec[r+3] < G->enemies.limright[n]) && (G->proyec[r+3] > 7) && (G->proyec[r+2] < 240)) {
					G->proyec[r+3] += 2;
					if (G->counter[0] % 2 == 0)
						G->proyec[r+2] ++;
				}
				else {
					G->proyec[r+2] = 0;
					G->proyec[r+3] = 0;
				}
			}
			if ((G->proyec[r] == 0) && (G->proyec[r+2] == 0))
				G->enemies.direction[n] = 0;
		}

	}

	/* Draw fire */
	for (n=1; n<4; n++) {
		r = (n-1) * 4;
		if (G->proyec[r] > 0) {
			srcfire.y = 32 + (G->grapset * 120);
			desfire.x = G->proyec[r];
			desfire.y = G->proyec[r+1];
			AB_DrawSprite(G,G->tiles,&srcfire,&desfire);
		}
		if (G->proyec[r+2] > 0) {
			srcfire.y = 32 + (G->grapset * 120);
			desfire.x = G->proyec[r+2];
			desfire.y = G->proyec[r+3];
			AB_DrawSprite(G,G->tiles,&srcfire,&desfire);
		}

	}

}

void crusaders (struct game *G){

	AB_Rect srctile = {96,64,16,24};
	AB_Rect destile = {0,0,16,24};
	int i = 0;

	for (i=0; i<7; i++) {

		/* Init values */
		if (G->enemies.type[i] == 17) {
			G->enemies.type[i] = 16;
			G->enemies.x[i] = -52 - (24 * i);
			G->enemies.y[i] = 136;
		}

		/* Mover & animation */
		/* Jump when needed */
		if (G->room == 5) {
			if ((G->enemies.x[i] == 146) || (G->enemies.x[i] == 160))
				(G->enemies.fire[i] = 1); /* Using fire as jump flag */
		}
		if (G->room == 6) {
			if ((G->enemies.x[i] == 76) || (G->enemies.x[i] == 124.75) || (G->enemies.x[i] == 155))
				G->enemies.fire[i] = 2;
			if ((G->enemies.x[i] == 208.25) || (G->enemies.x[i] == 220.50))
				G->enemies.fire[i] = 1; /* Using fire as jump flag */
		}
		if (G->room == 24) {
			if ((G->enemies.x[i] == 144) || (G->enemies.x[i] == 152) || (G->enemies.x[i] == 160) || (G->enemies.x[i] == 168))
				(G->enemies.fire[i] = 1);
		}

		/* Jump */
		if (G->enemies.fire[i] == 1) { /* Short jump */
			if (G->enemies.speed[i] < 23) {
				G->enemies.speed[i] += 2;
				G->enemies.y[i] -= 1;
				G->enemies.animation[i] = 0;
			}
			else {
				G->enemies.y[i] += 1;
				G->enemies.speed[i] += 2;
				G->enemies.animation[i] = 0;
			}
			if (G->enemies.speed[i] == 32) { /* Touching ground, reboot flags */
				G->enemies.speed[i] = 0;
				G->enemies.fire[i] = 0;
			}
		}
		if (G->enemies.fire[i] == 2) { /* Long jump */
			if (G->enemies.speed[i] < 8) {
				G->enemies.speed[i] += 1;
				G->enemies.y[i] -= 1;
				G->enemies.animation[i] = 0;
			}
			else {
				G->enemies.y[i] += 1;
				G->enemies.speed[i] += 1;
				G->enemies.animation[i] = 0;
			}
			if (G->enemies.speed[i] == 16) {
				G->enemies.fire[i] = 0;
				G->enemies.speed[i] = 0;
			}
		}

		if (G->enemies.animation[i] < 13)
			G->enemies.animation[i] ++;
		else
			G->enemies.animation[i] = 0;

		/* Fall */
		if (G->room == 5) {
			if (G->enemies.x[i] > 206) {
				if (G->enemies.speed[i] < 8) {
					G->enemies.speed[i] ++;
					G->enemies.y[i]+= 2;
					G->enemies.animation[i] = 0;
				}
			}
		}

		/* Movement */
		if ((G->room == 6) && (G->enemies.speed[i] > 0))
			G->enemies.x[i] += 0.75;
		else
			G->enemies.x[i] += 0.5;

		/* Draw */
		if ((G->enemies.x[i] > -8) && (G->enemies.x[i] < 257)) {
			srctile.x = 96 + (16 * (G->enemies.animation[i] / 7));
			srctile.y = 64 + (G->grapset * 120);
			destile.x = G->enemies.x[i];
			destile.y = G->enemies.y[i];
			AB_DrawSprite(G,G->tiles,&srctile,&destile);
		}

	}

}

void death (struct game *G){

	AB_Rect srcaxe = {0,56,16,16};
	AB_Rect desaxe = {0,0,16,16};
	AB_Rect srctile = {0,88,32,32};
	AB_Rect destile = {0,8,32,32};
	int x = 0;
	int y = 0;
	int n = 0;

	if (G->enemies.speed[0] < 60)
	  G->enemies.speed[0]++;
	else
	  G->enemies.speed[0] = 0;

	/* Movimiento */
	if (G->enemies.direction[0] == 0) { /* Left mov. */
		if (G->enemies.x[0] > G->enemies.limleft[0])
			G->enemies.x[0] --;
		else
			G->enemies.direction[0] = 1;
	}
	if (G->enemies.direction[0] == 1) { /* Right mov. */
		if (G->enemies.x[0] < G->enemies.limright[0])
			G->enemies.x[0] ++;
		else
			G->enemies.direction[0] = 0;
	}

	/* Init axes */
	if ((G->enemies.speed[0] == 45) && (G->enemies.x[0] > 48)) {
	  for (x=0; x<8; x+=2) {
			if (G->proyec[x] == 0) {
			  G->proyec[x] = G->enemies.y[0] + 35;
			  G->proyec[x+1] = G->enemies.x[0];
			  x = 9;
			  AB_PlaySoundN(G,0,0);
			}
	  }
	}

	/* Animation */
	if (G->enemies.speed[0] < 45) {
	  if ((G->counter[0] == 1) || (G->counter[0] == 11) || (G->counter[0] == 21)) {
			if (G->enemies.animation[0] == 0)
			  G->enemies.animation[0] = 1;
			else
				G->enemies.animation[0] = 0;
		  }
	}
	else {
	  if (G->enemies.x[0] > 48) {
			if (G->enemies.speed[0] < 55)
				G->enemies.animation[0] = 2;
			else
				G->enemies.animation[0] = 0;
		}
	}

	/* Draw */
	srctile.x = 0 + (G->enemies.animation[0] * 32) + (G->enemies.direction[0] * 96);
	srctile.y = 88 + (G->grapset * 120);
	destile.x = G->enemies.x[0];
	AB_DrawSprite(G,G->tiles,&srctile,&destile);

	/* Axes movement */
  for (n=0; n<8; n+=2) {

		if (G->proyec[n] > 0) {
	  	/* Locating axe */
		  x = G->proyec[n+1] / 8;
		  y = G->proyec[n] / 8;

		  /* Touching ground, take out & cleaning */
		  if (y == 20) {
				G->proyec[n] = 0;
				G->proyec[n+1] = 0;
		  }
		  else {
				/* Touching a solid tile ? Move */
				if (((G->map.stagedata[18][y+2][x] != 73) && (G->map.stagedata[18][y+2][x] != 75)) && ((G->map.stagedata[18][y+2][x+1] != 73) && (G->map.stagedata[18][y+2][x+1] != 75)))
				  G->proyec[n] ++;
				else
				  G->proyec[n+1] --;
		  }
		  if (x == 0) {
				G->proyec[n] = 0;
				G->proyec[n+1] = 0;
		  }
		}
  }

	/* Draw axe */
	for (n=0; n<8; n+=2) {
		if (G->proyec[n] > 0) {
	  	desaxe.x = G->proyec[n+1];
		  desaxe.y = G->proyec[n];
		  /* Rotation */
		  srcaxe.x = 576 + (16 * (G->counter[2] / 2));
			srcaxe.y = 56 + (G->grapset * 120);
			AB_DrawSprite(G,G->tiles,&srcaxe,&desaxe);
		}
	}

}

void dragon (struct game *G){

	AB_Rect srctile = {456,72,16,8};
	AB_Rect destile = {120,40,16,8};
	int n = 0;

	/* Draw front paw */
	srctile.y = 72 + (G->grapset * 120);
	AB_DrawSprite(G,G->tiles,&srctile,&destile);

	/* Head position */
	if (G->enemies.speed[0] < 150) /* Using speed as temp */
		G->enemies.speed[0] ++;
	else
		G->enemies.speed[0] = 0;

	if (G->enemies.speed[0] < 110)
		G->enemies.animation[0] = 0;
	else
		G->enemies.animation[0] = 1;

	/* Draw head */
	srctile.w = 32;
	srctile.h = 24;
	srctile.x = 416;
	srctile.y = 56 + (G->grapset * 120);;
	destile.w = 32;
	destile.h = 24;
	destile.x = 120;
	destile.y = 8 + (G->enemies.animation[0] * 3);
	AB_DrawSprite(G,G->tiles,&srctile,&destile);
	/* Draw snout */
	srctile.h = 16;
	srctile.x = 448;
	destile.h = 16;
	destile.y += 24;
	AB_DrawSprite(G,G->tiles,&srctile,&destile);

	/* Spit fire */
	if (G->enemies.animation[0] == 1) {
		if ((G->enemies.speed[0] == 115) || (G->enemies.speed[0] == 125) || (G->enemies.speed[0] == 135) || (G->enemies.speed[0] == 145))
			G->enemies.direction[0] = 1;
		if ((G->enemies.speed[0] == 110) || (G->enemies.speed[0] == 120) || (G->enemies.speed[0] == 130) || (G->enemies.speed[0] == 140))
			G->enemies.direction[0] = 0;
		srctile.x = 504 + (G->enemies.direction[0] * 48);
		srctile.y = 56 + (G->grapset * 120);
		srctile.w = 24;
		srctile.h = 24;
		destile.x = 119 + (G->enemies.direction[0] * 16);
		destile.y = 51;
		destile.w = 24;
		destile.h = 24;
		AB_DrawSprite(G,G->tiles,&srctile,&destile);
		srctile.x = 480 + (G->enemies.direction[0] * 48);
		destile.y = 75;
		destile.x = 127;
		AB_DrawSprite(G,G->tiles,&srctile,&destile);
	}

	/* Make fire in ground */
	if (G->enemies.speed[0] == 150) {
	  AB_PlaySoundN(G,0,0);
	  for (n=0; n<16; n+=8) {
			if (G->proyec[n] == 0) {
			  G->proyec[n] = 120;
			  G->proyec[n+1] = 464;
			  G->proyec[n+2] = 128;
			  G->proyec[n+3] = 472;
			  G->proyec[n+4] = 136;
			  G->proyec[n+5] = 472;
			  G->proyec[n+6] = 144;
			  G->proyec[n+7] = 464;
			  n = 16;
			}
	  }
	}

	/* Fire movement & animation */
	for (n=0; n<16; n+=2) {
	  if (G->proyec[n] > 0) {
			if ((n < 3) || ((n>7) && (n<11))) {
		  	if (G->proyec[n] > 48) {
					G->proyec[n] -= 0.3;
					/* Animation */
					if (G->counter[0] % 8 == 0) {
			  		if (G->proyec[n+1] == 464)
							G->proyec[n+1] = 472;
			  		else
							G->proyec[n+1] = 464;
					}
		  	}
		  	else {
					G->proyec[n] = 0;
					G->proyec[n+1] = 0;
		  	}
			}
			else {
		  	if (G->proyec[n] < 248) {
					G->proyec[n] += 0.3;
					/* Animation */
					if (G->counter[0] % 8 == 0) {
			  		if (G->proyec[n+1] == 464)
							G->proyec[n+1] = 472;
			  		else
							G->proyec[n+1] = 464;
					}
		  	}
		  	else {
					G->proyec[n] = 0;
					G->proyec[n+1] = 0;
		  	}
			}
			srctile.x = G->proyec[n+1];
			srctile.y = 0 + (G->grapset * 120);
			srctile.w = 8;
			srctile.h = 8;
			destile.x = G->proyec[n];
			destile.y = 88;
			destile.w = 8;
			destile.h = 8;
			AB_DrawSprite(G,G->tiles,&srctile,&destile);
	  }
	}
}

void satan (struct game *G){

	AB_Rect srctile = {192,88,32,24};
	AB_Rect destile = {192,0,32,24};
	AB_Rect srcfire = {656,32,4,4};
	AB_Rect desfire = {0,0,4,4};
	int n = 0;
	int r = 0;
	int x = 0;

	/* Movement */
	if (G->enemies.direction[0] == 0) { /* Subiendo */
		if (G->enemies.y[0] > G->enemies.limleft[0])
			G->enemies.y[0] -= 0.5;
		else
			G->enemies.direction[0] = 1;
	}
	if (G->enemies.direction[0] == 1) { /* Bajando */
		if (G->enemies.y[0] < G->enemies.limright[0])
			G->enemies.y[0] += 0.5;
		else
			G->enemies.direction[0] = 0;
	}

	/* Animation */
	if ((G->counter[0] == 1) || (G->counter[0] == 11) || (G->counter[0] == 21)) {
		if (G->enemies.animation[0] == 0)
			G->enemies.animation[0] = 1;
		else
			G->enemies.animation[0] = 0;
	}

	/* Draw */
	srctile.x = 192 + (G->enemies.animation[0] * 64);
	srctile.y = 88 + (G->grapset * 120);
	destile.y = G->enemies.y[0];
	AB_DrawSprite(G,G->tiles,&srctile,&destile);
	srctile.x = 224 + (G->enemies.animation[0] * 64);
	destile.y = G->enemies.y[0] + 24;
	AB_DrawSprite(G,G->tiles,&srctile,&destile);

	/* Init shoots */
	if (((G->enemies.y[0] == 37) && (G->enemies.direction[0] == 0)) || ((G->enemies.y[0] == 20) && (G->enemies.direction[0] == 1)) || ((G->enemies.y[0] == 62) && (G->enemies.direction[0] == 0))) {
		x = G->enemies.y[0];
		switch (x) {
		  case 20: r = 0;
				   		 break;
		  case 37: r = 6;
				   	 	 break;
		  case 62: r = 12;
							 break;
		}
		if ((G->proyec[r] == 0) && (G->proyec[r+2] == 0) && (G->proyec[r+4] == 0)) {
			G->proyec[r] = 190;
			G->proyec[r+1] = G->enemies.y[0] + 15;
			G->proyec[r+2] = 190;
			G->proyec[r+3] = G->enemies.y[0] + 10;
			G->proyec[r+4] = 190;
			G->proyec[r+5] = G->enemies.y[0] + 20;
			AB_PlaySoundN(G,0,0);
		}
	}

	/* Move shoots */
	for (n=0; n<17; n+=2) {
	  if ((G->proyec[n] > 16) && ((G->proyec[n+1] > 8) && (G->proyec[n+1] < 160))) {
			G->proyec[n] -= 2;
			if ((n+1 == 3) || (n+1 == 9) || (n+1 == 15))
			  G->proyec[n+1] -= 0.75;
			if ((n+1 == 5) || (n+1 == 11) || (n+1 == 17))
			  G->proyec[n+1] += 0.75;
			srcfire.y = 32 + (G->grapset * 120);
			desfire.x = G->proyec[n];
			desfire.y = G->proyec[n+1];
			AB_DrawSprite(G,G->tiles,&srcfire,&desfire);
	  }
	  else {
			G->proyec[n] = 0;
			G->proyec[n+1] = 0;
	  }
	}

}

void fireball (struct game *G){

	AB_Rect srctile = {576,40,16,16};
	AB_Rect destile = {0,0,16,16};
	int x = 0;
	int y = 0;

	/* Current tile X and Y */
	x = G->enemies.x[0] / 8;
	y = G->enemies.y[0] / 8;

	/* Follow Jean */
	if (G->enemies.x[0] < G->jean.x + 1) {
		G->enemies.direction[0] = 1;
		if (((G->map.stagedata[11][y][x+2] == 0) || (G->map.stagedata[11][y][x+2] > 99) || (G->map.stagedata[11][y][x+2] == 37)) && ((G->map.stagedata[11][y+1][x+2] == 0) || (G->map.stagedata[11][y+1][x+2] > 99) || (G->map.stagedata[11][y+1][x+2] == 37))) {
			if (G->enemies.fire[0] == 0)
				G->enemies.x[0] += 0.3;
		}
	}
	if (G->enemies.x[0] > G->jean.x - 1) {
		G->enemies.direction[0] = 0;
		if (((G->map.stagedata[11][y][x-1] == 0) || (G->map.stagedata[11][y][x-1] > 99) || (G->map.stagedata[11][y][x-1] == 37)) && ((G->map.stagedata[11][y+1][x-1] == 0) || (G->map.stagedata[11][y+1][x-1] > 99) || (G->map.stagedata[11][y+1][x-1] == 37))) {
			if (G->enemies.fire[0] == 0)
				G->enemies.x[0] -= 0.3;
		}
	}
	if (G->enemies.y[0] < G->jean.y + 1) {
		if (((G->map.stagedata[11][y+2][x] == 0) || (G->map.stagedata[11][y+2][x] > 99)) && ((G->map.stagedata[11][y+2][x+1] == 0) || (G->map.stagedata[11][y+2][x+1] > 99))) {
			if (G->enemies.fire[0] == 0)
				G->enemies.y[0] +=0.3;
			G->enemies.fire[0] = 0;
		}
		else {
			G->enemies.fire[0] = 1; /* Using fire like flag */
			if (G->enemies.x[0] > G->jean.x -1)
				G->enemies.x[0] -=0.3;
			else
				G->enemies.x[0] +=0.3;
		}
	}
	if (G->enemies.y[0] > G->jean.y + 1) {
		if (((G->map.stagedata[11][y-1][x] == 0) || (G->map.stagedata[11][y-1][x] > 99) || (G->map.stagedata[11][y-1][x] == 37)) && ((G->map.stagedata[11][y-1][x+1] == 0) || (G->map.stagedata[11][y-1][x+1] > 99) || (G->map.stagedata[11][y-1][x+1] == 37))) {
			G->enemies.y[0] -=0.3;
			G->enemies.fire[0] = 0;
		}
		else {
			G->enemies.fire[0] = 1; /* Usando fire como flag */
			if (G->enemies.x[0] > G->jean.x - 1)
				G->enemies.x[0] -=0.3;
			else
				G->enemies.x[0] +=0.3;
		}
	}

	/* Animation */
	G->enemies.animation[0] = G->counter[0] / 15;

	/* Draw */
	srctile.x = 576 + (G->enemies.animation[0] * 16) + (G->enemies.direction[0] * 32);
	srctile.y = 40 + (G->grapset * 120);
	destile.x = G->enemies.x[0];
	destile.y = G->enemies.y[0];
	AB_DrawSprite(G,G->tiles,&srctile,&destile);

}
