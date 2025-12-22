#include "_variables.h"

BlingDefinition Bling[6];

int BlingCounter = 1;
SDL_Rect TempBlingRect;
SDL_Rect TempGoodieRect;
int BlingX;
int BlingY;

void drawBling()
{
	for(int Bling_i = 1; Bling_i < 6; Bling_i++)
	{
		if(Bling[Bling_i].active == 1)
		{
			TempBlingRect.x = Bling[Bling_i].x + LEVEL_XPos;
			TempBlingRect.y = Bling[Bling_i].y;
			TempBlingRect.w = 8;
			TempBlingRect.h = 8;
			SDL_BlitSurface(TilesSurface,&TileSrcRect[51],DisplaySurface,&TempBlingRect);
		}
	}
}

void setBling(int setBlingX, int setBlingY)
{
	if(BlingCounter > 5){BlingCounter = 1;}
	Bling[BlingCounter].active = 1;
	Bling[BlingCounter].x = setBlingX;
	Bling[BlingCounter].y = setBlingY;
	BlingCounter++;
}

void moveBling()
{
	for(int Bling_i = 1; Bling_i < 6; Bling_i++)
	{
		if(Bling[Bling_i].active == 1)
		{
			Bling[Bling_i].y -= 2;
				if(Bling[Bling_i].y < -10){Bling[Bling_i].active = 0;}
		}

	}
}

void defineBling()
{
	for(int Bling_i = 1; Bling_i < 6; Bling_i++)
	{
		Bling[Bling_i].active = 0;

	}
}

void drawWeapon()
{
TempGoodieRect.x = GoodieX + LEVEL_XPos;
TempGoodieRect.y = GoodieY;
TempGoodieRect.w = GoodieSrcRect[1].w;
TempGoodieRect.h = GoodieSrcRect[1].h;
SDL_BlitSurface(GoodiesSurface,&GoodieSrcRect[1],DisplaySurface,&TempGoodieRect);
}
