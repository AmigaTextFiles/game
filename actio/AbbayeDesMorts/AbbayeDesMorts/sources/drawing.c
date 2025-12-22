/* drawing.c */

# include "abbaye.h"

void drawscreen (struct game *G){

	int coordx = 0;
	int coordy = 0;
	AB_Rect src = {0,0,8,8};
	AB_Rect dst = {0,0,8,8};
	unsigned int data = 0;

	for (coordy=0; coordy<=21; coordy++) {
		for (coordx=0; coordx<=31; coordx++) {
			data = G->map.stagedata[G->room][coordy][coordx];
			if ((data > 0) && (data != 99)) {
				dst.x = coordx * 8;
				dst.y = coordy * 8;
				if (data < 200) {
					src.w = 8;
					src.h = 8;
					if (data < 101) {
						src.y = 0;
						if (data == 84) /* Cross brightness */
							src.x = (data - 1) * 8 + (G->counter[0]/8 * 8);
						else
							src.x = (data - 1) * 8;
					}
					else {
						if (data == 154) {
							src.x=600 + ((G->counter[0] / 8) * 16);
							src.y=0;
							src.w=16;
							src.h=24;
						}
						else {
							src.y = 8;
							src.x = (data - 101) * 8;
						}
					}
				}
				if ((data > 199) && (data < 300)) {
					src.x = (data - 201) * 48;
					src.y = 16;
					src.w = 48;
					src.h = 48;
				}
				if ((data > 299) && (data < 399)) {
					src.x = 96 + ((data - 301) * 8);
					src.y = 16;
					src.w = 8;
					src.h = 8;
					/* Door movement */
					if ((G->room == 7) && ((G->counter[1] > 59) && (G->counter[1] < 71))) {
						if ((data == 347) || (data == 348) || (data == 349) || (data == 350)) {
							dst.x += 2;
							if ((data == 350) && (G->counter[1] == 70))
								AB_PlaySoundN(G,3,0); /* Sound of door */
						}
					}
				}
				/* Hearts */
				if ((data > 399) && (data < 405)) {
					src.x = 96 + ((data - 401) * 8) + (32 * (G->counter[0] / 15));
					src.y = 24;
					src.w = 8;
					src.h = 8;
				}
				/* Crosses */
				if ((data > 408) && (data < 429)) {
					src.x = 96 + ((data - 401) * 8) + (32 * (G->counter[1] / 23));
					src.y = 24;
					src.w = 8;
					src.h = 8;
				}

				if ((data > 499) && (data < 599)) {
					src.x = 96 + ((data - 501) * 8);
					src.y = 32;
					src.w = 8;
					src.h = 8;
				}
				if ((data > 599) && (data < 650)) {
					src.x = 96 + ((data - 601) * 8);
					src.y = 56;
					src.w = 8;
					src.h = 8;
				}
				if (data == 650) { /* Cup */
					src.x = 584;
					src.y = 87;
					src.w = 16;
					src.h = 16;
				}
				dst.w = src.w;
				dst.h = src.h;
				if ((data == 152) || (data == 137) || (data == 136)) {
					if (G->screenchange == 0) {
						src.y = src.y + (G->grapset * 120);
						AB_DrawSprite(G,G->tiles,&src,&dst);
					}
				}
				else {
					src.y = src.y + (G->grapset * 120);
					AB_DrawSprite(G,G->tiles,&src,&dst);
				}
			}
		}
	}

}

void statusbar (struct game *G){

	AB_Rect srcbar 	= {448,104,13,12};
	AB_Rect desbar 	= {0,177,13,12};
	AB_Rect srcnumbers = {0,460,10,10};
	AB_Rect desnumbers = {18,178,10,10};
	AB_Rect srctext 	= {0,0,140,20};
	AB_Rect destext 	= {115,174,136,18};
	int i = 0;

	/* Show heart and crosses sprites */
	if (G->grapset == 1)
		srcbar.y = 224;
	AB_DrawSprite(G,G->tiles,&srcbar,&desbar);
	srcbar.x = 461;
	srcbar.w = 12;
	desbar.x = 32;
	AB_DrawSprite(G,G->tiles,&srcbar,&desbar);

	for (i=0; i<=2; i++) {
		switch (i) {
			case 0: 		srcnumbers.x = G->jean.lifes * 10;
							AB_DrawSprite(G,G->fonts,&srcnumbers,&desnumbers);
							break;
			case 1: if (G->jean.crosses < 10) {
								desnumbers.x = 50;
								srcnumbers.x = G->jean.crosses * 10;
								AB_DrawSprite(G,G->fonts,&srcnumbers,&desnumbers);
							}
							else {
								desnumbers.x = 50;
								srcnumbers.x = 10;
								AB_DrawSprite(G,G->fonts,&srcnumbers,&desnumbers);
								desnumbers.x = 55;
								srcnumbers.x = (G->jean.crosses - 10) * 10;
								AB_DrawSprite(G,G->fonts,&srcnumbers,&desnumbers);
							}
							break;
			case 2: if ((G->room > 0) && (G->room < 4)) {
								srctext.y = (G->room - 1) * 20;
								AB_DrawSprite(G,G->fonts,&srctext,&destext);
							}
							if (G->room > 4) {
								srctext.y = (G->room - 2) * 20;
								AB_DrawSprite(G,G->fonts,&srctext,&destext);
							}
							break;
		}

	}

}

void drawrope (struct game *G){

	int i = 0;
	int blocks = 0;
	int j = 0;
	AB_Rect srctile = {424,8,16,8};
	AB_Rect destile = {0,0,16,8};

	for (i=2; i<6; i++) {
		blocks = (G->enemies.y[i] - (G->enemies.limleft[i] - 8)) / 8;
		for (j=0; j<=blocks; j++) {
			srctile.y = 8 + (G->grapset * 120);
	  	destile.x = G->enemies.x[i];
	  	destile.y = (G->enemies.limleft[i] - 8) + (8 * j);
			AB_DrawSprite(G,G->tiles,&srctile,&destile);
		}
	}

}

void drawshoots (struct game *G){
/* Shoots from skeletons & gargoyles */

	AB_Rect srctile = {656,24,16,8};
	AB_Rect destile = {0,0,0,0};
	int i = 0;
	int n = 0;

	srctile.y = 24 + (G->grapset * 120);

  for (n=0; n<=4; n+=2) {
		if (G->proyec[n] > 0) {
	  	i = G->proyec[n+1];
	  	if (G->enemies.type[i] == 15) {
				srctile.h = 16;
				srctile.x = 640 - (16 * G->enemies.direction[i]);
	  	}

	  	/* Move shoot */
	  	if (G->enemies.direction[i] == 1) {
				if (G->proyec[n] > G->enemies.limleft[i])
				  G->proyec[n] -= 2.5;
				else {
				  G->enemies.fire[i] = 0;
				  G->enemies.speed[i] = 0;
				  G->proyec[n] = 0;
				}
	  	}
	  	else {
				if (G->proyec[n] < G->enemies.limright[i])
		  		G->proyec[n] += 2.5;
				else {
		  		G->enemies.fire[i] = 0;
				  G->enemies.speed[i] = 0;
				  G->proyec[n] = 0;
				}
	  	}
	  	destile.w = srctile.w;
			destile.h = srctile.h;

	  	/* Draw shoot */
	  	switch (G->enemies.direction[i]) {
				case 0: if ((G->proyec[n] < (G->enemies.limright[i] - 8)) && (G->proyec[n] != 0)) {
								  destile.x = G->proyec[n];
								  destile.y = G->enemies.y[i] + 8;
									AB_DrawSprite(G,G->tiles,&srctile,&destile);
								}
								break;
				case 1: if (G->proyec[n] > (G->enemies.limleft[i] + 8)) {
								  destile.x = G->proyec[n];
								  destile.y = G->enemies.y[i] + 8;
									AB_DrawSprite(G,G->tiles,&srctile,&destile);
								}
								break;
	  	}
		}

	}

}

void showparchment (struct game *G){


	switch (G->parchment) {
		case 3:  AB_Drawtexture(G,"graphics/parchment1.png");	break;
		case 8:	 AB_Drawtexture(G,"graphics/parchment2.png");	break;
		case 12: AB_Drawtexture(G,"graphics/parchment3.png");	break;
		case 14: AB_Drawtexture(G,"graphics/parchment4.png");	break;
		case 16: AB_Drawtexture(G,"graphics/parchment5.png");	break;
		case 21: AB_Drawtexture(G,"graphics/parchment6.png");	break;
	}

}

void redparchment (struct game *G){

	AB_Drawtexture(G,"graphics/redparch.png");
	G->jean.flags[6] = 4;

}

void blueparchment (struct game *G){

	AB_Drawtexture(G,"graphics/blueparch.png");

}
