#ifndef PIECES_H
#define PIECES_H

#include <string>
#include <vector>
using namespace std;

class piece
{
	public:
	unsigned short axis_x;
	unsigned short axis_y;
	bool onHalf;
	bool twoPos;
	bool curPos;
	unsigned short map[4][2];
	int graphic;
	vector< vector<signed char> > *board;
	short x;
	short y;
	piece (string pSpec, short init_x, short init_y, vector< vector<signed char> > *init_board);
	piece (void);
	bool turn (bool direction);
	bool canMove (int xChange, int yChange);
	bool blockOn (int cX, int cY);
	bool checkPos (int cX, int cY);
	short getTop (void);
	string getSpec (void);
};

#endif
