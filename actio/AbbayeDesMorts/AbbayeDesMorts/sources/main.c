/* Abbaye des Morts */
/* Version 2.1 */

/* (c) 2010 - Locomalito & Gryzor87 */
/* 2013 - David "Nevat" Lara */
/* 2014 - Amiga: Alain Thellier */

/* GPL v3 license */

# include "abbaye.h"

int main(int argc, char **argv)
{
struct game *G;
int size;	

	size=sizeof(struct game);	
	G=(struct game *)malloc(size);	
	if(!G)
		exit(0);
	memset(G,0,size);
	
	G->room=5; 
	G->prevroom=5; 
	G->screenchange=1;
	AB_InitGame(G,256,192,"Abbaye des Morts v2.2");

	while (G->chapter < 5) 
	{
		switch (G->chapter) 
		{
			case 0: startscreen(G);			break;
			case 1: history(G);				break;
			case 2: game(G);				break;
			case 3: gameover(G);			break;
			case 4: ending(G);				break;
		}
	}

	AB_CloseGame(G);
	free(G);
	exit(0);
}
