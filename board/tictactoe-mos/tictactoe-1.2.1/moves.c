#include <stdio.h>
#include "messages.h"
#include "t3types.h"
#include "t3visual.h"
#include "line_o_s.h"
#include "scores.h"

int end_of_game() {
	int x, y;
	int rsum, csum, drsum, dlsum;

	/* Check rows and cols*/
	for(y=0; y<SIZE; y++) {
		for(x=rsum=csum=0; x<SIZE; x++) {
			rsum+=board[y][x];
			csum+=board[x][y];
		}
		if(rsum==SIZE*ME || csum==SIZE*ME)
			return ME;
		if(rsum==SIZE*YOU || csum==SIZE*YOU)
			return YOU;
	}
		
	/* Check diags */
	for(x=drsum=dlsum=0; x<SIZE; x++) {
		drsum+=board[x][x];
		dlsum+=board[x][SIZE-1-x];
	}
	if(drsum==SIZE*ME || dlsum==SIZE*ME)
		return ME;
	if(drsum==SIZE*YOU || dlsum==SIZE*YOU)
		return YOU;

	/* Check if no more moves */
	for(y=0; y<SIZE; y++)
		for(x=0; x<SIZE; x++)
			if(!board[y][x])
				return 0;
	return DRAW;
}

int is_valid_move(int row, int col) {
	if(row<0 || row>=SIZE)
		return 1;
	if(col<0 || col>=SIZE)
		return -1;
	if(board[row][col])
		return -3;
	return 0;
}

int get_your_move() {
	int x, y;
	int invalid=1;

	while(invalid) {
		print_msg("Place your piece\n");
		print_msg("row = (1-%d) ", SIZE);
		fflush(stdin);
		scanf("%u", &y);
		print_msg("col = (1-%d) ", SIZE);
		fflush(stdin);
		scanf("%u", &x);

		y--; x--;

		invalid=is_valid_move(y,x);
		switch (invalid) {
			case -3:
				print_error("slot_not_empty");
				break;
			case 1:
				print_error("y_out_of_bounds");
				break;
			case -1:
				print_error("x_out_of_bounds");
				break;
		}
	}

	return y*SIZE+x;
}

int get_my_move() {
	int position;

	print_msg("My move\n");

	/* Check if ME can win */
	print_debug("Can I win?");
	position=get_winning_position(ME);
	if(position >= 0)
		return position;

	/* Check if YOU can win */
	print_debug("Can you win?");
	position=get_winning_position(YOU);
	if(position >= 0)
		return position;

	print_debug("So what's my best move then?");
	position=set_scores(ME);
	if(debug)
		show_scores();
	/* If there is no position, then it is already end of game */
	return position;
}

