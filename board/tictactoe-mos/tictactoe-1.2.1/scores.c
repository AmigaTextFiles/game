#include "messages.h"
#include "scores.h"
#include "t3types.h"
#include "line_o_s.h"
#include "moves.h"

int get_winning_position(int who) {
	int y, x;
	int position=-1;
	
	for(y=0; y<SIZE && position==-1; y++) 
		for(x=0; x<SIZE && position==-1; x++) 
			if(!board[y][x]) {
				board[y][x]=who;	/* do it */
				if(end_of_game()==who)
					position=y*SIZE+x;
				board[y][x]=0;		/* undo it */
			}
	return position;
}

int get_centre_score(int row, int col, int who) {
	int centre = SIZE/2;
	if(row==centre && col==centre && board[centre][centre]==0)
		return CENTRE_SCORE;
	return 0;
}

int get_corner_score(int row, int col, int who) {
	if((row>0 && row<SIZE-1) || (col>0 && col<SIZE-1))
		return 0;
	if(board[row][col]==0)
		return CORNER_SCORE;
	return 0;
}

int get_los_score(int row, int col, int who) {
	int score=0, i;
	int (*possible[3])(int, int, int)={
		col_possible, row_possible, dia_possible
	};

	if(board[row][col])
		return 0;

	for(i=0; i<3; i++)
		score+=possible[i](row, col, who);

	print_debug("Line of sight score(%d,%d): %d", row, col, score);
	return score;
}

int get_sticky_score(int row, int col, int who) {
	int y, x;
	int score=0;

	if(board[row][col])
		return 0;

	for(y=row-1; y<=row+1; y++) {
		if(y<0 || y>SIZE-1)
			continue;
		for(x=col-1; x<=col+1; x++) {
			if(x<0 || x>SIZE-1)
				continue;
			if(y==row && x==col)
				continue;
			if(board[y][x]==-who)
				score+=STICKY_SCORE;
		}
	}

	print_debug("Sticky score(%d,%d): %d", row, col, score);
	return score;
}

int set_scores(int who) {
	int y, x, pos=-1;
	int i;
	int (*get_score[4])(int, int, int) = {
		get_centre_score, 
		get_los_score, 
		get_sticky_score, 
		get_corner_score
	};

	for(y=0; y<SIZE; y++)
		for(x=0; x<SIZE; x++) {
			for(i=0, scores[y][x]=0; i<4; i++)
				scores[y][x]+=get_score[i](y, x, who);
			if(scores[y][x] > 0 && (pos < 0 ||
				scores[y][x] > scores[pos/SIZE][pos%SIZE]))
				pos=y*SIZE+x;
		}

	return pos;
}


