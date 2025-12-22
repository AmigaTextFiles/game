#include <stdio.h>
#include "t3types.h"
#include "messages.h"

void show_scores() {
	int row, col;

	fprintf(stderr, "\n\n");
	for(row=0; row<SIZE; row++) {
		fprintf(stderr, "\t");
		for(col=0; col<SIZE; col++)
			fprintf(stderr, "%3d\t", scores[row][col]);
		fprintf(stderr, "\n");
	}
	fprintf(stderr, "\n\n");
}

void show_board() {
	int row, col;

	for(row=0; row<SIZE; row++) {
		for(col=0; col<SIZE; col++)
			printf("%c ", piece[board[row][col]]);
		printf("\n");
	}
}

void show_result(enum players result) {
	print_msg("Game over - ");
	switch(result) {
		case O:
			print_msg("O wins\n");
			break;
		case X:
			print_msg("X wins\n");
			break;
		case DRAW:
			print_msg("Drawn\n");
			break;
		case NONE:
			print_msg("No winner\n");
			break;
		default:
			printf("no result\n");
	}
}

