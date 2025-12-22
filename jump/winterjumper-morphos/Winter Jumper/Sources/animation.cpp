#include "_variables.h"

Uint32 EnemyAnimationCounter = 0;
Uint32 EnemyAnimationNumber = 0;

void Animation()
{
	AnimationCounter++;
	if(AnimationCounter == 8)
		{
			AnimationCounter = 0;
			for(int v = 0; v < LEVEL_HEIGHT; v++)
			{
			for(int w = 0; w < LEVEL_WIDTH; w++)
			{
			if(TileAnimation[TileArray[w][v]].animated == 1)
			{TileArray[w][v] = TileAnimation[TileArray[w][v]].nexttile;}
			}
			}
		}
	
	WalkAnimationCounter++;
	if(WalkAnimationCounter > 10)
	{
		WalkAnimationCounter = 0;
		WalkAnimationNumber++;
		if(WalkAnimationNumber == 3){WalkAnimationNumber = 1;}
	}

	EnemyAnimationCounter++;
	if(EnemyAnimationCounter > 10)
	{
		EnemyAnimationCounter = 0;
		EnemyAnimationNumber++;
		if(EnemyAnimationNumber > 4){EnemyAnimationNumber = 1;}
	}
}
