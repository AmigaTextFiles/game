#include "_variables.h"

PlayableCharacter Giana;

SDL_Rect GianaRightSrcRect[4];
SDL_Rect GianaLeftSrcRect[4];
SDL_Rect GianaJumpRightSrcRect;
SDL_Rect GianaJumpLeftSrcRect;
SDL_Rect GianaTurnRightSrcRect;
SDL_Rect GianaTurnLeftSrcRect;
SDL_Rect GianaDeadSrcRect;

SDL_Rect GianaPunkRightSrcRect[4];
SDL_Rect GianaPunkLeftSrcRect[4];
SDL_Rect GianaPunkJumpRightSrcRect;
SDL_Rect GianaPunkJumpLeftSrcRect;
SDL_Rect GianaPunkTurnRightSrcRect;
SDL_Rect GianaPunkTurnLeftSrcRect;

int WalkAnimationCounter = 0;
int WalkAnimationNumber = 0;
bool GianaDied = false;


void defineGiana()
{
	fprintf(stdout,"\nattempting to define giana...\n");
	int i;
	for(i=0;i<3;i++)
	{
		/*Giana standing/walking to the right */
		GianaRightSrcRect[i].x = i*15;
		GianaRightSrcRect[i].y = 0;
		GianaRightSrcRect[i].w = 15;
		GianaRightSrcRect[i].h = 21;
		
		/*Giana standing/walking to the left */
		GianaLeftSrcRect[i].x = i*15;
		GianaLeftSrcRect[i].y = 21;
		GianaLeftSrcRect[i].w = 15;
		GianaLeftSrcRect[i].h = 21;
	}
		
		/*Giana jumping to the right */
		GianaJumpRightSrcRect.x = 45;
		GianaJumpRightSrcRect.y = 0;
		GianaJumpRightSrcRect.w = 21;
		GianaJumpRightSrcRect.h = 21;

		/*Giana jumping to the left */
		GianaJumpLeftSrcRect.x = 45;
		GianaJumpLeftSrcRect.y = 21;
		GianaJumpLeftSrcRect.w = 21;
		GianaJumpLeftSrcRect.h = 21;

		/*Giana turning to the right */
		GianaTurnRightSrcRect.x = 75;
		GianaTurnRightSrcRect.y = 0;
		GianaTurnRightSrcRect.w = 16;
		GianaTurnRightSrcRect.h = 21;

		/*Giana turning to the left */
		GianaTurnLeftSrcRect.x = 75;
		GianaTurnLeftSrcRect.y = 21;
		GianaTurnLeftSrcRect.w = 16;
		GianaTurnLeftSrcRect.h = 21;

	for(i=0;i<3;i++)
	{
		/*PunkGiana standing/walking to the right */
		GianaPunkRightSrcRect[i].x = i*24;
		GianaPunkRightSrcRect[i].y = 48;
		GianaPunkRightSrcRect[i].w = 19;
		GianaPunkRightSrcRect[i].h = 21;
		
		/*PunkGiana standing/walking to the left */
		GianaPunkLeftSrcRect[i].x = i*24;
		GianaPunkLeftSrcRect[i].y = 72;
		GianaPunkLeftSrcRect[i].w = 19;
		GianaPunkLeftSrcRect[i].h = 21;
	}
		
		/*PunkGiana jumping to the right */
		GianaPunkJumpRightSrcRect.x = 72;
		GianaPunkJumpRightSrcRect.y = 48;
		GianaPunkJumpRightSrcRect.w = 21;
		GianaPunkJumpRightSrcRect.h = 21;

		/*PunkGiana jumping to the left */
		GianaPunkJumpLeftSrcRect.x = 72;
		GianaPunkJumpLeftSrcRect.y = 72;
		GianaPunkJumpLeftSrcRect.w = 21;
		GianaPunkJumpLeftSrcRect.h = 21;

		/*PunkGiana turning to the right */
		GianaPunkTurnRightSrcRect.x = 96;
		GianaPunkTurnRightSrcRect.y = 48;
		GianaPunkTurnRightSrcRect.w = 19;
		GianaPunkTurnRightSrcRect.h = 21;

		/*PunkGiana turning to the left */
		GianaPunkTurnLeftSrcRect.x = 96;
		GianaPunkTurnLeftSrcRect.y = 72;
		GianaPunkTurnLeftSrcRect.w = 19;
		GianaPunkTurnLeftSrcRect.h = 21;

		/*Giana dead */
		GianaDeadSrcRect.x = 96;
		GianaDeadSrcRect.y = 1;
		GianaDeadSrcRect.w = 18;
		GianaDeadSrcRect.h = 19;

		Giana.w = GianaRightSrcRect[0].w;
		Giana.h = GianaRightSrcRect[0].h;
	fprintf(stdout,"Succesfully defined giana...\n");
}
