#include "scores.h"
#include "messages.h"
#include "line_o_s.h"

int col_possible(int row, int col, int who) {
	int y, score=0;
	for(y=0; y<SIZE; y++) {
		if(y==row)
			continue;
		if(board[y][col]==-who)
			return 0;
		if(!board[y][col])
			continue;
		if(row > y)
			score+=SIZE-(row-y);
		else
			score+=SIZE-(y-row);
	}
	return score?score+LOS_SCORE:0;
}

int row_possible(int row, int col, int who) {
	int x, score=0;
	for(x=0; x<SIZE; x++) {
		if(x==col)
			continue;
		if(board[row][x]==-who)
			return 0;
		if(!board[row][x])
			continue;
		if(col > x)
			score+=SIZE-(col-x);
		else
			score+=SIZE-(x-col);
	}
	return score?score+LOS_SCORE:0;
}

int dia_possible(int row, int col, int who) {
	int x, scorerd=0, scoreld=0;

	if(row!=col && row!=SIZE-1-col)	/* point not on diagonal */
		return 0;
	
	if(row==col)			/* Going right-down */
		for(x=0; x<SIZE; x++) {
			if(x==row && x==col)
				continue;
			if(board[x][x]==-who) {
				scorerd=0;
				break;
			}
			if(!board[x][x])
				continue;
			if(row>x)
				scorerd+=SIZE-(row-x);
			else
				scorerd+=SIZE-(x-row);
		}
	if(row==SIZE-1-col) 			/* Going left-down */
		for(x=0; x<SIZE; x++) {
			if(x==row && SIZE-1-x==col)
				continue;
			if(board[x][SIZE-1-x]==-who) {
				scoreld=0;
				break;
			}
			if(!board[x][SIZE-1-x])
				continue;
			if(row>x)
				scoreld+=SIZE-(row-x);
			else
				scoreld+=SIZE-(x-row);
		}

	scorerd += scorerd?LOS_SCORE:0;
	scoreld += scoreld?LOS_SCORE:0;

	return scorerd+scoreld;
}

