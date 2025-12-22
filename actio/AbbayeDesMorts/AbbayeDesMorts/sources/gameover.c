/* gameover.c */

# include "abbaye.h"

void gameover (struct game *G){

	void* gameovertex = AB_LoadTexture(G,"graphics/gameover.png");
	void* gameovermus = AB_LoadMusic(G,"sounds/GameOverV2N.ogg");

	AB_Clear(G);
	AB_DrawSprite(G,gameovertex,NULL,NULL);

	/* Flip */
	AB_Update(G);
	AB_PlayMusic(G,gameovermus,0);

	/* Wait */
	sleep(12);

	/* Cleaning */
	AB_FreeMusic(G,gameovermus);
	AB_DestroyTexture(G,gameovertex);

	G->chapter = 0;
}

