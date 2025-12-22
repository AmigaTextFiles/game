#include "_variables.h"

SDL_Rect EnemySrcRightRect[10][6];	//[EnemyType][AnimationFrame]
SDL_Rect EnemySrcLeftRect[10][6];	//[EnemyType][AnimationFrame]
Uint16 EnemyPath[10];				// normal enemies don't have paths. Exception = Ball
Uint16 EnemyFlying[10];				// bees etc.


EnemyDefinition Enemy[20];

void defineEnemies()
{
    int i; 
	for(i = 1; i < 10;i++)
	{
		EnemyPath[i] = 0;
	}
		
	for(i = 1; i < 6;i++)
	{
		EnemySrcRightRect[1][i].w = 24;
		EnemySrcRightRect[1][i].h = 17;
		EnemySrcRightRect[1][i].y = 7;
		EnemySrcLeftRect[1][i].w = 24;
		EnemySrcLeftRect[1][i].h = 17;
		EnemySrcLeftRect[1][i].y = 7;
	}
		EnemySrcRightRect[1][1].x = 0;
		EnemySrcRightRect[1][2].x = 24;
		EnemySrcRightRect[1][3].x = 48;
		EnemySrcRightRect[1][4].x = 72;
		EnemySrcRightRect[1][5].x = 96;
		EnemySrcLeftRect[1][1].x = 120;
		EnemySrcLeftRect[1][2].x = 144;
		EnemySrcLeftRect[1][3].x = 168;
		EnemySrcLeftRect[1][4].x = 192;
		EnemySrcLeftRect[1][5].x = 216;
		EnemyFlying[1] = 0;

	for(i = 1; i < 6;i++)
	{
		EnemySrcRightRect[2][i].w = 24;
		EnemySrcRightRect[2][i].h = 18;
		EnemySrcRightRect[2][i].y = 30;
		EnemySrcLeftRect[2][i].w = 24;
		EnemySrcLeftRect[2][i].h = 18;
		EnemySrcLeftRect[2][i].y = 30;
	}
		EnemySrcRightRect[2][1].x = 0;
		EnemySrcRightRect[2][2].x = 24;
		EnemySrcRightRect[2][3].x = 48;
		EnemySrcRightRect[2][4].x = 72;
		EnemySrcRightRect[2][5].x = 96;
		EnemySrcLeftRect[2][1].x = 120;
		EnemySrcLeftRect[2][2].x = 144;
		EnemySrcLeftRect[2][3].x = 168;
		EnemySrcLeftRect[2][4].x = 192;
		EnemySrcLeftRect[2][5].x = 216;
		EnemyFlying[2] = 0;

	for(i = 1; i < 6;i++)
	{
		EnemySrcRightRect[3][i].w = 24;
		EnemySrcRightRect[3][i].h = 13;
		EnemySrcRightRect[3][i].y = 51;
		EnemySrcLeftRect[3][i].w = 24;
		EnemySrcLeftRect[3][i].h = 13;
		EnemySrcLeftRect[3][i].y = 51;
	}
		EnemySrcRightRect[3][1].x = 0;
		EnemySrcRightRect[3][2].x = 24;
		EnemySrcRightRect[3][3].x = 48;
		EnemySrcRightRect[3][4].x = 72;
		EnemySrcRightRect[3][5].x = 96;
		EnemySrcLeftRect[3][1].x = 120;
		EnemySrcLeftRect[3][2].x = 144;
		EnemySrcLeftRect[3][3].x = 168;
		EnemySrcLeftRect[3][4].x = 192;
		EnemySrcLeftRect[3][5].x = 216;
		EnemyFlying[3] = 0;

	for(i = 1; i < 6;i++)
	{
		EnemySrcRightRect[5][i].w = 24;
		EnemySrcRightRect[5][i].h = 18;
		EnemySrcRightRect[5][i].y = 86;
		EnemySrcLeftRect[5][i].w = 24;
		EnemySrcLeftRect[5][i].h = 18;
		EnemySrcLeftRect[5][i].y = 86;
	}
		EnemySrcRightRect[5][1].x = 0;
		EnemySrcRightRect[5][2].x = 24;
		EnemySrcRightRect[5][3].x = 48;
		EnemySrcRightRect[5][4].x = 72;
		EnemySrcRightRect[5][5].x = 96;
		EnemySrcLeftRect[5][1].x = 120;
		EnemySrcLeftRect[5][2].x = 144;
		EnemySrcLeftRect[5][3].x = 168;
		EnemySrcLeftRect[5][4].x = 192;
		EnemySrcLeftRect[5][5].x = 216;
		EnemyFlying[5] = 1;
}

void resetEnemies()
{
	for(int j = 0; j < 20; j++)
	{
		Enemy[j].inUse = 0;
		Enemy[j].direction = 0;
		Enemy[j].alive = 1;
	}
}
