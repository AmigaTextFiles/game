#include "_variables.h"

SDL_Rect EnemyRect;

void drawEnemy()
{
for(int i = 0;i<20;i++)
{
	if(Enemy[i].inUse == 1)
	{
		EnemyRect.x = Enemy[i].x + LEVEL_XPos;
		EnemyRect.y = Enemy[i].y;
		EnemyRect.w = EnemySrcRightRect[Enemy[i].type][1].w;
		EnemyRect.h = EnemySrcRightRect[Enemy[i].type][1].h;
		if(Enemy[i].alive == 0)
		{
			if(Enemy[i].direction == 1){SDL_BlitSurface(EnemySpritesSurface,&EnemySrcRightRect[Enemy[i].type][5],DisplaySurface,&EnemyRect);}
			if(Enemy[i].direction == 0){SDL_BlitSurface(EnemySpritesSurface,&EnemySrcLeftRect[Enemy[i].type][5],DisplaySurface,&EnemyRect);}
		}
		else
		{
			if(Enemy[i].direction == 1){SDL_BlitSurface(EnemySpritesSurface,&EnemySrcRightRect[Enemy[i].type][EnemyAnimationNumber],DisplaySurface,&EnemyRect);}
			if(Enemy[i].direction == 0){SDL_BlitSurface(EnemySpritesSurface,&EnemySrcLeftRect[Enemy[i].type][EnemyAnimationNumber],DisplaySurface,&EnemyRect);}
		}
	}
}
	
}
