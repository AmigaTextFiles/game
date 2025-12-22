#include "pieces.h"
#include <string>
#include <vector>
using namespace std;

piece::piece (string pSpec, short init_x, short init_y, vector< vector<signed char> > *init_board)
{
	x = init_x;
	y = init_y;
	axis_x = pSpec[0];
	axis_y = pSpec[1];
	onHalf = pSpec[2];
	graphic = pSpec[3];
	twoPos = pSpec[4];
	for (int i = 5; i <= 12; i+=2)
	{
		map[(i-4)/2][0] = pSpec[i];
		map[(i-4)/2][1] = pSpec[i+1];
	}
	board = init_board;
}

piece::piece (void)
{
	x = 0;
	y = 0;
	axis_x = 1;
	axis_y = 1;
	onHalf = true;
	twoPos = false;
	curPos = 0;
	graphic = 0;
	for (int i = 0; i <= 4; i++)
	{
		map[i][0] = 1;
		map[i][1] = i;
	}
	board = NULL;
}

string piece::getSpec (void)
{
	string result;
	result += (char)axis_x;
	result += (char)axis_y;
	result += (char)onHalf;
	result += (char)graphic;
	result += (char)twoPos;
	for (int i = 0; i < 4; i++)
	{
		result += map[i][0];
		result += map[i][1];
	}
	return(result);
}

bool piece::turn (bool direction)
{
	if (twoPos)
	{
		direction = curPos;
	}
	piece newpiece;
	if (!onHalf)
	{
		if (direction)
		{
			for (int i=0;i<4;i++)
			{
				newpiece.map[i][0] = axis_x - (axis_y - map[i][1]);
				newpiece.map[i][1] = axis_y + (axis_x - map[i][0]);
			}
		}
		else
		{
		for (int i=0;i<4;i++)
			{
				newpiece.map[i][0] = axis_x + (axis_y - map[i][1]);
				newpiece.map[i][1] = axis_y - (axis_x - map[i][0]);
			}
		}
	}
	else
	{
		if (direction)
		{
			for (int i=0;i<4;i++)
			{
				newpiece.map[i][0] = (int)(axis_x + .5 - (float)(axis_y + .5 - map[i][1]));
				newpiece.map[i][1] = (int)(axis_y + .5 + (float)(axis_x + .5 - map[i][0]));
			}
		}
		else 
		{
			for (int i=0;i<4;i++)
			{
				newpiece.map[i][0] = (int)(axis_x + .5 + (float)(axis_y + .5 - map[i][1]));
				newpiece.map[i][1] = (int)(axis_y + .5 - (float)(axis_x + .5 - map[i][0]));
			}
		}
	}
	if (board != NULL)
	{
		for (int i = 0; i < 4; i++)
		{
			if (checkPos(newpiece.map[i][0]+x, newpiece.map[i][1]+y) == false)
			{
				return (false);
			}
		}
	}				
	for (int i = 0; i < 4; i++)
	{
		map[i][0] = newpiece.map[i][0];
		map[i][1] = newpiece.map[i][1];
	}
	if (twoPos)
	{
		curPos ? curPos = 0 : curPos = 1;
	}
	return (true);
}

bool piece::canMove (int xChange, int yChange)
{
	if (board != NULL)
	{
		for (int i = 0; i < 4; i++)
		{
			if (checkPos(map[i][0]+x+xChange, map[i][1]+y+yChange) == false)
			{
				return (false);
			}
		}
	}
	return (true);
}

bool piece::blockOn (int cX, int cY)
{
	for (int i = 0; i < 4; i++)
	{
		if (map[i][0] == cX-x && map[i][1] == cY-y) {return true;}
	}
	return false;
}

bool piece::checkPos (int cX, int cY)
{
	if (cX < 0) return false;
	if ((unsigned)cX >= (*board)[0].size()) return false;
	if (cY < 0) return true;
	if ((unsigned)cY >= board->size()) return false;
	if (blockOn(cX, cY)) return true;
	if ((*board)[cY][cX] != -1) return false;
	return true;
}

short piece::getTop (void)
{
	short top = 3;
	for (int i = 0; i < 4; i++)
	{
		if (map[i][1] < top) top = map[i][1];
	}
	return top+y;
}
