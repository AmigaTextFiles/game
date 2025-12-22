#include "_variables.h"

// GoodieX;
// GoodieY;

void checkGoodieCollision()
{

if(Giana.x > GoodieX && Giana.x < GoodieX + 20)
{
	if(Giana.y > GoodieY && Giana.y < GoodieY + 20)
	{
	Giana.weapon = 1;
	GoodieX = -200;
	GoodieY = -200;
	}
}

if(Giana.x > GoodieX && Giana.x < GoodieX + 20)
{
	if(Giana.y + Giana.h  > GoodieY && Giana.y + Giana.h < GoodieY + 20)
	{
	Giana.weapon = 1;
	GoodieX = -200;
	GoodieY = -200;
	}
}

if(Giana.x + Giana.w > GoodieX && Giana.x + Giana.w < GoodieX + 20)
{
	if(Giana.y  > GoodieY && Giana.y < GoodieY + 20)
	{
	Giana.weapon = 1;
	GoodieX = -200;
	GoodieY = -200;
	}
}

if(Giana.x + Giana.w > GoodieX && Giana.x + Giana.w < GoodieX + 20)
{
	if(Giana.y + Giana.h  > GoodieY && Giana.y + Giana.h < GoodieY + 20)
	{
	Giana.weapon = 1;
	GoodieX = -200;
	GoodieY = -200;
	}
}

}
