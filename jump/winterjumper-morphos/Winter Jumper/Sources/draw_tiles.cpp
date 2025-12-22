#include "_variables.h"

SDL_Rect TempRect;

//extern SDL_Rect BGRect;

void drawTiles()
{
	int i;
	LEVEL_XPos = (-1)*(Giana.x - 150);

	if(LEVEL_XPos > 0)								{LEVEL_XPos = 0;}
	if(LEVEL_XPos < (-1)*(LEVEL_WIDTH * 8-320))		{LEVEL_XPos = (-1)*(LEVEL_WIDTH * 8-320);}

//**********************
// draw tiles
	TopLeft_Tile_X = - LEVEL_XPos / 8;
	TopRight_Tile_X = 1 + TopLeft_Tile_X + 320 / 8; //SCREEN_WIDTH const doesn't work!!!
	if(TopRight_Tile_X > LEVEL_WIDTH)	{TopRight_Tile_X = LEVEL_WIDTH;}

	for(int maplinecounter = 0; maplinecounter < LEVEL_HEIGHT; maplinecounter++)
	{
		for(int mapcolcounter = TopLeft_Tile_X; mapcolcounter < TopRight_Tile_X; mapcolcounter++)
		{
			TempRect.x = mapcolcounter * 8 + LEVEL_XPos;
			TempRect.y = maplinecounter * 8;
			TempRect.w = 8;
			TempRect.h = 8;
			i = TileArray[mapcolcounter][maplinecounter];
			if(i!=0)
			{
				SDL_BlitSurface(TilesSurface,&TileSrcRect[i],DisplaySurface,&TempRect);
			}
		}
	}
			
//**********************
}
