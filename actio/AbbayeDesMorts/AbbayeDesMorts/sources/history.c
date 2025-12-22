/* history.c */

# include "abbaye.h"

void history(struct game *G){

AB_Rect srcjean = {384,88,16,24};
AB_Rect desjean = {0,100,16,24};
AB_Rect srcenem = {96,64,16,24};
AB_Rect desenem = {0,100,16,24}; 
AB_Rect srcintro = {0,0,256,192};
AB_Rect desintro = {0,0,256,192};
float posjean = -16;
float posenem[4] = {-17,-17,-17,-17};
unsigned int animation = 0;
unsigned int i = 0;
unsigned int musicload = 0;
void* historymus;
void* historytex;

	/* Load audio */
	historymus = AB_LoadMusic(G,"sounds/ManhuntN.ogg");
	/* Loading PNG */
	historytex = AB_LoadTexture(G,"graphics/history.png");

	while (G->chapter== 1) {

		/* Cleaning the renderer */
		AB_Clear(G);

		/* Play historymus at start */
		if (musicload == 0) {
			musicload = 1;
			AB_PlayMusic(G,historymus,0);
		}

		/* Show history */
	 	AB_DrawSprite(G,historytex, &srcintro, &desintro);

		/* Animation control */
		if (animation < 13)
			animation ++;
		else
			animation = 0;

		/* Jean running */
		if (posjean < 257) {
			posjean += 0.75;
			desjean.x = posjean;
			srcjean.x = 384 + ((animation / 7) * 16); /* Walking animation */
			srcjean.y = 88 + (G->grapset * 120); /* 8 or 16 bits sprite */
			AB_DrawSprite(G,G->tiles,&srcjean,&desjean);
		}

		/* Crusaders running */
		/* When start running */
		for (i=0;i<4;i++) {
			if (posjean > (35 + (30 * i)))
				posenem[i] += 0.65;
		}
		/* Draw */
		for (i=0;i<4;i++) {
			if ((posenem[i] > -17) && (posenem[i] < 257)) {
				desenem.x = posenem[i];
				srcenem.x = 96 + ((animation / 7) * 16);
				srcenem.y = 64 + (G->grapset * 120);
				AB_DrawSprite(G,G->tiles,&srcenem,&desenem);
			}
		}

		/* Check keyboard */
		AB_Events(G);

		if (G->joystick.b0) 
			G->key=' ';
			
		if (G->joystick.b1) 
			G->key=' ';
				
		if(G->key==' ')  /* Start game */
			G->chapter = 2;

		if (posenem[3] > 256) { /* Ending history */
			G->chapter = 2;
		}

		/* Flip ! */
		AB_Update(G);

	}

	/* Cleaning */
	AB_DestroyTexture(G,historytex);
	AB_FreeMusic(G,historymus);

}
