#include <stdio.h>
#include <string.h>
#include <stdlib.h>  /* declaration of malloc(), calloc() */
#include "messages.h"
#include "t3types.h"
#include "t3visual.h"
#include "moves.h"

void create_board() {
	int row;
	signed char *cbuf;
	int *ibuf;

	board = (signed char **)malloc(SIZE * sizeof(signed char *));
	scores = (int **)malloc(SIZE * sizeof(int *));
	cbuf = (signed char *)calloc(SIZE * SIZE, sizeof(signed char));
	ibuf = (int *)calloc(SIZE * SIZE, sizeof(int));
	if(board == NULL || scores == NULL || cbuf == NULL || ibuf == NULL) {
		print_error("malloc() failure");
		exit(1);
	}

	for(row=0; row<SIZE; row++) {
		board[row] = &cbuf[SIZE * row];
		scores[row] = &ibuf[SIZE * row];
	}
}

void set_params(int argc, char *argv[]) {
	int i;
	int b_size;

	if(argc==1) 
		fprintf(stderr,"\nUse --help flag to get help\n\n");
	else
		for(i=1; i<argc; i++)
			if(!strcmp(argv[i], "--debug"))
				debug=1;
			else if(!strcmp(argv[i], "--help")) 
				fprintf(stderr, "\n\nTicTacToe v 1.new\n---------------\nCopyright (c) 2001 Philip S Tellis\n\nUsage: %s [--help] [--debug] [X|O] [size]\n\n-------------------------------------------------------------\n\nOptions:\n\n   --help\t\tprint this message\n   --debug\t\tprint debugging information to stderr\n     X\t\t\tcomputer plays first\n     O\t\t\tuser plays first (default)\n     size\t\tdesired board size, non-negative, odd integer (default: 3)\n\n--------------------------------------------------------------\n\n\n", argv[0]);
			else if(!strcmp(argv[i], "X") && !YOU)
				YOU=X, ME=O;
			else if(!strcmp(argv[i], "O") && !YOU)
				YOU=O, ME=X;
			else if(sscanf(argv[i], "%d", &b_size) == 1) {
				if(b_size < 0 || (b_size%2==0 && b_size!=0)) {
					print_error("board size must be positive, odd integer\n");
					exit(1);
				}
				SIZE = b_size;
			}

	if(!YOU)
		YOU=O, ME=X;
}

void make_move(int pos, int who) {
	board[pos/SIZE][pos%SIZE]=who;
}

enum players play_game() {
	enum players result=NONE;
	int (*_get_move[3])()={get_your_move, NULL, get_my_move};
	int (**get_move)();
	int who=NONE;
	
	print_debug("Let's play");

	get_move = &_get_move[1];	/* so that I can subscript
					   get_move from -1 to +1 */

	who=YOU;	/* If YOU == O (-1), then get_your_move is first
			   If YOU == X (+1), then get_my_move is first */

	show_board();
	for(; !(result=end_of_game()); who*=-1) {
		make_move(get_move[who](), who);
		show_board();
	} 

	return result;
}

int main(int argc, char *argv[]) {
	enum players result=NONE;

	set_params(argc, argv);
	create_board();

	result = play_game();
	show_result(result);

	return (int)result;
}
