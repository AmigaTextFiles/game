/* startscreen.c */

# include "abbaye.h"

void startscreen(struct game *G)
{
int musicplay = 0;
AB_Rect srcintro = {0,0,256,192};
AB_Rect desintro = {0,0,256,192};
void* introtex1;
void* introtex2;
void* intromus;

    /* Loading PNG */
    introtex1    = AB_LoadTexture(G,"graphics/intro.png");
    introtex2    = AB_LoadTexture(G,"graphics/intromd.png");

    /* Load audio */
    intromus = AB_LoadMusic(G,"sounds/MainTitleN.ogg");

    while (G->chapter==0) {

        /* Cleaning the renderer */
        AB_Clear(G);

        /* Put image on renderer */
        if (G->grapset == 0)
            AB_DrawSprite(G, introtex1, &srcintro, &desintro);
        else
            AB_DrawSprite(G, introtex2, &srcintro, &desintro);

        /* Flip ! */
        AB_Update(G);

        /* Play music if required */
        if (musicplay == 0) {
            musicplay = 1;
            AB_PlayMusic(G,intromus, 0);
        }

			/* Check keyboard */
			AB_Events(G);
		
			if (G->key == 'i') 				/* Show instructions */
			{ 
				if (srcintro.y == 0)
					{
						srcintro.y = 192;
					}
                    else
					{
                        srcintro.y = 0;
                        musicplay = 0;
                    }
            }
			
			if (G->joystick.b0) 
				G->key=' ';
			
			if (G->joystick.b1) 
				G->key=' ';
			
			if (G->key == ' ') 			/* Start game */
			{
					G->chapter    = 1;
					G->room=5; 
					G->prevroom=5; 
					G->screenchange=1;
			}

        

    }

    /* Cleaning */
    AB_DestroyTexture(G,introtex1);
    AB_DestroyTexture(G,introtex2);
	AB_FreeMusic(G,intromus);
}
