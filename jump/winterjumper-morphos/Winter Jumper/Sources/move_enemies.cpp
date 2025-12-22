#include "_variables.h"

int EnemyTopLeft;
int EnemyTopRight;
int EnemyBottomLeft;
int EnemyBottomRight;

int TileEnemyTopLeftX;
int TileEnemyTopRightX;
int TileEnemyBottomLeftX;
int TileEnemyBottomRightX;
int TileEnemyTopLeftY;
int TileEnemyTopRightY;
int TileEnemyBottomLeftY;
int TileEnemyBottomRightY;

int TileEnemyGroundLeftX;
int TileEnemyGroundRightX;
int TileEnemyGroundLeftY;
int TileEnemyGroundRightY;

int EnemyKilled;

void moveEnemies()
{

EnemyKilled = 0; //check whether an enemy was killed in this cicle

for(int i = 0;i<20;i++)
{
	if(EnemyFlying[Enemy[i].type] == 0 && Enemy[i].inUse == 1 && Enemy[i].alive == 1 && EnemyPath[Enemy[i].type] == 0 && Enemy[i].x + LEVEL_XPos < 400)
	{
		EnemyPosition(i);

		if(TileTypes[TileArray[TileEnemyGroundLeftX][TileEnemyGroundLeftY]].solid == 0 
		&& TileTypes[TileArray[TileEnemyGroundRightX][TileEnemyGroundRightY]].solid == 0)
		{

		for(int Repeater = 0; Repeater < MovementSpeed; Repeater++)
		{
			EnemyPosition(i);
			if(TileTypes[TileArray[TileEnemyGroundLeftX][TileEnemyGroundLeftY]].solid == 0 
			&& TileTypes[TileArray[TileEnemyGroundRightX][TileEnemyGroundRightY]].solid == 0)
			{Enemy[i].y = Enemy[i].y + 1;}
		}

		}

		else
		{
		if(Enemy[i].x < 0){Enemy[i].direction = 1;}
		if(Enemy[i].x > (256*8)-Enemy[i].w){Enemy[i].direction = 0;}

		if(TileTypes[TileArray[TileEnemyTopLeftX][TileEnemyTopLeftY]].solid == 1){Enemy[i].direction = 1;}
		if(TileTypes[TileArray[TileEnemyTopRightX][TileEnemyTopRightY]].solid == 1){Enemy[i].direction = 0;}

		if(TileTypes[TileArray[TileEnemyBottomLeftX][TileEnemyBottomLeftY]].solid == 1){Enemy[i].direction = 1;}
		if(TileTypes[TileArray[TileEnemyBottomRightX][TileEnemyBottomRightY]].solid == 1){Enemy[i].direction = 0;}

		if(TileTypes[TileArray[TileEnemyGroundLeftX][TileEnemyGroundLeftY]].solid == 0){Enemy[i].direction = 1;}
		if(TileTypes[TileArray[TileEnemyGroundRightX][TileEnemyGroundRightY]].solid == 0){Enemy[i].direction = 0;}

		if(Enemy[i].direction == 0){Enemy[i].x = Enemy[i].x - MovementSpeed;}
		if(Enemy[i].direction == 1){Enemy[i].x = Enemy[i].x + MovementSpeed;}
		}
	}

	if(EnemyFlying[Enemy[i].type] == 1 && Enemy[i].inUse == 1 && Enemy[i].alive == 1 && EnemyPath[Enemy[i].type] == 0 && Enemy[i].x + LEVEL_XPos < 400)
	{
		EnemyPosition(i);
		if(Enemy[i].x < 0){Enemy[i].direction = 1;}
		if(Enemy[i].x > (256*8)-Enemy[i].w){Enemy[i].direction = 0;}

		if(TileTypes[TileArray[TileEnemyTopLeftX][TileEnemyTopLeftY]].solid == 1){Enemy[i].direction = 1;}
		if(TileTypes[TileArray[TileEnemyTopRightX][TileEnemyTopRightY]].solid == 1){Enemy[i].direction = 0;}

		if(TileTypes[TileArray[TileEnemyBottomLeftX] [TileEnemyBottomLeftY]].solid == 1){Enemy[i].direction = 1;}
		if(TileTypes[TileArray[TileEnemyBottomRightX][TileEnemyBottomRightY]].solid == 1){Enemy[i].direction = 0;}

		if(Enemy[i].x < 1){Enemy[i].direction = 1;}

		if(Enemy[i].direction == 0){Enemy[i].x = Enemy[i].x - MovementSpeed;}
		if(Enemy[i].direction == 1){Enemy[i].x = Enemy[i].x + MovementSpeed;}
	}

	if(EnemyFlying[Enemy[i].type] == 1 && Enemy[i].alive == 0 && Enemy[i].y < 240)
	{
		Enemy[i].y = Enemy[i].y + 2 * MovementSpeed;
	}

}
if(EnemyKilled == 1){Giana.jumpcounter = 78;}
}





void EnemyPosition(int EnemyNumber)
{
Enemy[EnemyNumber].w = EnemySrcRightRect[Enemy[EnemyNumber].type][1].w;
Enemy[EnemyNumber].h = EnemySrcRightRect[Enemy[EnemyNumber].type][1].h;

TileEnemyTopLeftX = ((Enemy[EnemyNumber].x) / 8);
TileEnemyTopLeftY = ((Enemy[EnemyNumber].y) / 8);
TileEnemyTopRightX = ((Enemy[EnemyNumber].x + Enemy[EnemyNumber].w) / 8);
TileEnemyTopRightY = ((Enemy[EnemyNumber].y) / 8);

TileEnemyBottomLeftX = ((Enemy[EnemyNumber].x) / 8);
TileEnemyBottomLeftY = ((Enemy[EnemyNumber].y + Enemy[EnemyNumber].h-1) / 8);
TileEnemyBottomRightX = ((Enemy[EnemyNumber].x + Enemy[EnemyNumber].w) / 8);
TileEnemyBottomRightY = ((Enemy[EnemyNumber].y + Enemy[EnemyNumber].h-1) / 8);

TileEnemyGroundLeftX = ((Enemy[EnemyNumber].x) / 8);
TileEnemyGroundLeftY = ((Enemy[EnemyNumber].y + EnemySrcRightRect[Enemy[EnemyNumber].type][1].h) / 8);
TileEnemyGroundRightX = ((Enemy[EnemyNumber].x + EnemySrcRightRect[Enemy[EnemyNumber].type][1].w) / 8);
TileEnemyGroundRightY = ((Enemy[EnemyNumber].y + EnemySrcRightRect[Enemy[EnemyNumber].type][1].h) / 8);

if(Enemy[EnemyNumber].alive == 1 && Giana.x > Enemy[EnemyNumber].x && Giana.x < Enemy[EnemyNumber].x + Enemy[EnemyNumber].w)
{
	if(Giana.y > Enemy[EnemyNumber].y && Giana.y < Enemy[EnemyNumber].y + Enemy[EnemyNumber].h)
	{
		if(Giana.onground == 1){GianaDied = 1;}
		if(Giana.onground == 0){Enemy[EnemyNumber].alive = 0; Giana.jumpcounter = 78; intPoints += POINTSPERENEMY;}
		if(Giana.y > Enemy[EnemyNumber].y){GianaDied = 1;}
	}

	if(Giana.y + Giana.h - 3 > Enemy[EnemyNumber].y && Giana.y + Giana.h - 3 < Enemy[EnemyNumber].y + Enemy[EnemyNumber].h)
	{
		if(Giana.onground == 1){GianaDied = 1;}
		if(Giana.onground == 0){Enemy[EnemyNumber].alive = 0; Giana.jumpcounter = 78; intPoints += POINTSPERENEMY;}
		if(Giana.y > Enemy[EnemyNumber].y){GianaDied = 1;}
	}
}

if(Enemy[EnemyNumber].alive == 1 && Giana.x + Giana.w > Enemy[EnemyNumber].x && Giana.x + Giana.w < Enemy[EnemyNumber].x + Enemy[EnemyNumber].w)
{
	if(Giana.y > Enemy[EnemyNumber].y && Giana.y < Enemy[EnemyNumber].y + Enemy[EnemyNumber].h)
	{
		if(Giana.onground == 1 || Giana.jumpcounter > 0){GianaDied = 1;}
		if(Giana.onground == 0 || Giana.jumpcounter == 0){Enemy[EnemyNumber].alive = 0;EnemyKilled = 1; intPoints += POINTSPERENEMY;}
		if(Giana.y > Enemy[EnemyNumber].y){GianaDied = 1;}
	}

	if(Giana.y + Giana.h - 3 > Enemy[EnemyNumber].y && Giana.y + Giana.h - 3 < Enemy[EnemyNumber].y + Enemy[EnemyNumber].h)
	{
		if(Giana.onground == 1 || Giana.jumpcounter > 0){GianaDied =1;}
		if(Giana.onground == 0 || Giana.jumpcounter == 0){Enemy[EnemyNumber].alive = 0;EnemyKilled = 1; intPoints += POINTSPERENEMY;}
		if(Giana.y > Enemy[EnemyNumber].y){GianaDied = 1;}
	}
}

}
