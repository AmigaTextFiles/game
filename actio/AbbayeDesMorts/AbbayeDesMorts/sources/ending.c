/* ending.c */

# include "abbaye.h"

void ending (struct game *G){
	int i = 0;
	int x = 0;
	int height = 0;
	int width = 0;
	char message[25];
	AB_Rect srcdoor = {600,72,64,48};
	AB_Rect desdoor = {96,72,64,48};

	
	void* endingtex = AB_LoadTexture(G,"graphics/ending.png");
	void* endingmus = AB_LoadMusic(G,"sounds/PrayerofHopeN.ogg");

	AB_PlayMusic(G,endingmus,0);

	for (i=0;i<951;i++) {

		/* Cleaning the renderer */
		AB_Clear(G);

		if (i<360)
			x = i/60;
		else
			x = 5;
		
		if (i > 365)
			AB_DrawSprite(G,endingtex,NULL,NULL);

		srcdoor.x = 600 + (64 * x);
		AB_DrawSprite(G,G->tiles,&srcdoor,&desdoor);

		/* Flip */
		AB_Update(G);

	}

	/* Cleaning */
	AB_DestroyTexture(G,endingtex);
	AB_FreeMusic(G,endingmus);

	G->chapter = 0;

}
