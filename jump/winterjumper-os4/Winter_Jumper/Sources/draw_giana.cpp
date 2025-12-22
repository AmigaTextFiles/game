#include "_variables.h"

SDL_Rect GianaTempRect;
SDL_Rect TestRect;

//extern WalkAnimationNumber;

//extern LEVEL_XPos;

void drawGiana()
{

GianaTempRect.x = LEVEL_XPos + Giana.x ;
GianaTempRect.y = Giana.y;

GianaTempRect.w = GianaRightSrcRect[0].w;
GianaTempRect.h = GianaRightSrcRect[0].h;

TestRect.x = 0;
TestRect.y = 0;
TestRect.w = 10;
TestRect.h = 10;

if(GianaTempRect.x < 0)						{GianaTempRect.x = 0;}
if(GianaTempRect.x > 320-GianaTempRect.w)	{GianaTempRect.x = 320-GianaTempRect.w;}

if(Key_RIGHT == 1){Giana.direction = 1;}
if(Key_LEFT == 1){Giana.direction = 0;}


//**********************
// draw sprites

if(Giana.onground == 0)
{
	GianaTempRect.x = GianaTempRect.x - 3;	
	if(Giana.direction == 1)
	{
		if(Giana.weapon == 0){SDL_BlitSurface(GianaSpritesSurface,&GianaJumpRightSrcRect,DisplaySurface,&GianaTempRect);}
		if(Giana.weapon > 0) {SDL_BlitSurface(GianaSpritesSurface,&GianaPunkJumpRightSrcRect,DisplaySurface,&GianaTempRect);}
	}
	if(Giana.direction == 0)
	{
		if(Giana.weapon == 0){SDL_BlitSurface(GianaSpritesSurface,&GianaJumpLeftSrcRect,DisplaySurface,&GianaTempRect);}
		if(Giana.weapon > 0) {SDL_BlitSurface(GianaSpritesSurface,&GianaPunkJumpLeftSrcRect,DisplaySurface,&GianaTempRect);}
	}
}

else
{
	if(Key_RIGHT == 1)
	{
		if(Giana.accelleration >= 0)
		{
			if(Giana.weapon == 0){SDL_BlitSurface(GianaSpritesSurface,&GianaRightSrcRect[WalkAnimationNumber],DisplaySurface,&GianaTempRect);}
			if(Giana.weapon > 0) {SDL_BlitSurface(GianaSpritesSurface,&GianaPunkRightSrcRect[WalkAnimationNumber],DisplaySurface,&GianaTempRect);}
		}
		if(Giana.accelleration < 0)
		{
			if(Giana.weapon == 0){SDL_BlitSurface(GianaSpritesSurface,&GianaTurnRightSrcRect,DisplaySurface,&GianaTempRect);}
			if(Giana.weapon > 0) {SDL_BlitSurface(GianaSpritesSurface,&GianaPunkTurnRightSrcRect,DisplaySurface,&GianaTempRect);}
		}

	}

	if(Key_LEFT == 1)
	{
		if(Giana.accelleration <= -0)
		{
			if(Giana.weapon == 0){SDL_BlitSurface(GianaSpritesSurface,&GianaLeftSrcRect[WalkAnimationNumber],DisplaySurface,&GianaTempRect);}
			if(Giana.weapon > 0) {SDL_BlitSurface(GianaSpritesSurface,&GianaPunkLeftSrcRect[WalkAnimationNumber],DisplaySurface,&GianaTempRect);}
		}
		if(Giana.accelleration > -0)
		{
			if(Giana.weapon == 0){SDL_BlitSurface(GianaSpritesSurface,&GianaTurnLeftSrcRect,DisplaySurface,&GianaTempRect);}
			if(Giana.weapon > 0) {SDL_BlitSurface(GianaSpritesSurface,&GianaPunkTurnLeftSrcRect,DisplaySurface,&GianaTempRect);}
		}

	}

	if(Key_RIGHT == 0 && Key_LEFT == 0)
	{
		if(Giana.direction == 1)
		{
			if(Giana.weapon == 0){SDL_BlitSurface(GianaSpritesSurface,&GianaRightSrcRect[0],DisplaySurface,&GianaTempRect);}
			if(Giana.weapon > 0) {SDL_BlitSurface(GianaSpritesSurface,&GianaPunkRightSrcRect[0],DisplaySurface,&GianaTempRect);}
		}
		if(Giana.direction == 0)
		{
			if(Giana.weapon == 0){SDL_BlitSurface(GianaSpritesSurface,&GianaLeftSrcRect[0],DisplaySurface,&GianaTempRect);}
			if(Giana.weapon > 0) {SDL_BlitSurface(GianaSpritesSurface,&GianaPunkLeftSrcRect[0],DisplaySurface,&GianaTempRect);}
		}
	}
}


//**********************
}
