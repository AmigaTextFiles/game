/*
##########################################
#         TriMines version 1.3.0         #
#                                        #
#         uncover.c - uncover triangles  #
#         with recursion and stuff.      #
##########################################
*/

void showarea(int i, int j)
{
int z;

if (i == 1) {
if (board[i-1][j] != 14 && (board2[i-1][j] == 0 || board2[i-1][j] == 3)){board2[i-1][j] = 1; drawb(board[i-1][j], i-1, j); if(board[i-1][j] == 0){showarea(i-1, j);}}
if (board[i+1][j] != 14 && (board2[i+1][j] == 0 || board2[i+1][j] == 3)){board2[i+1][j] = 1; drawb(board[i+1][j], i+1, j); if(board[i+1][j] == 0){showarea(i+1, j);}}
if (board[i+2][j] != 14 && (board2[i+2][j] == 0 || board2[i+2][j] == 3)){board2[i+2][j] = 1; drawb(board[i+2][j], i+2, j); if(board[i+2][j] == 0){showarea(i+2, j);}}
} else {
if (i == 0) {
if (board[i+1][j] != 14 && (board2[i+1][j] == 0 || board2[i+1][j] == 3)){board2[i+1][j] = 1; drawb(board[i+1][j], i+1, j); if(board[i+1][j] == 0){showarea(i+1, j);}}
if (board[i+2][j] != 14 && (board2[i+2][j] == 0 || board2[i+2][j] == 3)){board2[i+2][j] = 1; drawb(board[i+2][j], i+2, j); if(board[i+2][j] == 0){showarea(i+2, j);}}
			} else {
				if (i == (boardx-1 - 1)) {
if (board[i-1][j] != 14 && (board2[i-1][j] == 0 || board2[i-1][j] == 3)){board2[i-1][j] = 1; drawb(board[i-1][j], i-1, j); if(board[i-1][j] == 0){showarea(i-1, j);}}
if (board[i-2][j] != 14 && (board2[i-2][j] == 0 || board2[i-2][j] == 3)){board2[i-2][j] = 1; drawb(board[i-2][j], i-2, j); if(board[i-2][j] == 0){showarea(i-2, j);}}
if (board[i+1][j] != 14 && (board2[i+1][j] == 0 || board2[i+1][j] == 3)){board2[i+1][j] = 1; drawb(board[i+1][j], i+1, j); if(board[i+1][j] == 0){showarea(i+1, j);}}
							} else {
								if (i == boardx-1) {
if (board[i-1][j] != 14 && (board2[i-1][j] == 0 || board2[i-1][j] == 3)){board2[i-1][j] = 1; drawb(board[i-1][j], i-1, j); if(board[i-1][j] == 0){showarea(i-1, j);}}
if (board[i-2][j] != 14 && (board2[i-2][j] == 0 || board2[i-2][j] == 3)){board2[i-2][j] = 1; drawb(board[i-2][j], i-2, j); if(board[i-2][j] == 0){showarea(i-2, j);}}
										} else {
if (board[i-1][j] != 14 && (board2[i-1][j] == 0 || board2[i-1][j] == 3)){board2[i-1][j] = 1; drawb(board[i-1][j], i-1, j); if(board[i-1][j] == 0){showarea(i-1, j);}}
if (board[i-2][j] != 14 && (board2[i-2][j] == 0 || board2[i-2][j] == 3)){board2[i-2][j] = 1; drawb(board[i-2][j], i-2, j); if(board[i-2][j] == 0){showarea(i-2, j);}}
if (board[i+1][j] != 14 && (board2[i+1][j] == 0 || board2[i+1][j] == 3)){board2[i+1][j] = 1; drawb(board[i+1][j], i+1, j); if(board[i+1][j] == 0){showarea(i+1, j);}}
if (board[i+2][j] != 14 && (board2[i+2][j] == 0 || board2[i+2][j] == 3)){board2[i+2][j] = 1; drawb(board[i+2][j], i+2, j); if(board[i+2][j] == 0){showarea(i+2, j);}}
											}}}}



z = 0;
if ((j % 2) != 0){z = 1;}

if ((i % 2) == z){
// image

if (j > 0) {
		if (i == 0) {
if (board[i][j-1] != 14 && (board2[i][j-1] == 0 || board2[i][j-1] == 3))
{board2[i][j-1] = 1; drawb(board[i][j-1], i, j-1); if(board[i][j-1] == 0){showarea(i, j-1);}}
if (board[i+1][j-1] != 14 && (board2[i+1][j-1] == 0 || board2[i+1][j-1] == 3))
{board2[i+1][j-1] = 1; drawb(board[i+1][j-1], i+1, j-1);if(board[i+1][j-1]==0){showarea(i+1, j-1);}}
				} else {
					if (i == boardx-1) {
if (board[i][j-1] != 14 && (board2[i][j-1] == 0 || board2[i][j-1] == 3))
{board2[i][j-1] = 1; drawb(board[i][j-1], i, j-1);if(board[i][j-1] == 0){showarea(i, j-1);}}
if (board[i-1][j-1] != 14 && (board2[i-1][j-1] == 0 || board2[i-1][j-1] == 3))
{board2[i-1][j-1] = 1; drawb(board[i-1][j-1], i-1, j-1);if(board[i-1][j-1]==0){showarea(i-1, j-1);}}
							} else {
if (board[i][j-1] != 14 && (board2[i][j-1] == 0 || board2[i][j-1] == 3))
{board2[i][j-1] = 1; drawb(board[i][j-1], i, j-1);if(board[i][j-1] == 0){showarea(i, j-1);}}
if (board[i-1][j-1] != 14 && (board2[i-1][j-1] == 0 || board2[i-1][j-1] == 3))
{board2[i-1][j-1] = 1; drawb(board[i-1][j-1], i-1, j-1);if(board[i-1][j-1]==0){showarea(i-1, j-1);}}
if (board[i+1][j-1] != 14 && (board2[i+1][j-1] == 0 || board2[i+1][j-1] == 3))
{board2[i+1][j-1] = 1; drawb(board[i+1][j-1], i+1, j-1);if(board[i+1][j-1]==0){showarea(i+1, j-1);}}
								}
									}
										}

if (j < boardy-1) {
		if (i == 0) {
if (board[i][j+1] != 14 && (board2[i][j+1] == 0 || board2[i][j+1] == 3))
{board2[i][j+1] = 1; drawb(board[i][j+1], i, j+1);if(board[i][j+1] == 0){showarea(i, j+1);}}
if (board[i+1][j+1] != 14 && (board2[i+1][j+1] == 0 || board2[i+1][j+1] == 3))
{board2[i+1][j+1] = 1; drawb(board[i+1][j+1], i+1, j+1);if(board[i+1][j+1]==0){showarea(i+1, j+1);}}
if (board[i+2][j+1] != 14 && (board2[i+2][j+1] == 0 || board2[i+2][j+1] == 3))
{board2[i+2][j+1] = 1; drawb(board[i+2][j+1], i+2, j+1);if(board[i+2][j+1]==0){showarea(i+2, j+1);}}
				} else {
				if (i == boardx-1) {
if (board[i][j+1] != 14 && (board2[i][j+1] == 0 || board2[i][j+1] == 3))
{board2[i][j+1] = 1; drawb(board[i][j+1], i, j+1);if(board[i][j+1] == 0){showarea(i, j+1);}}
if (board[i-1][j+1] != 14 && (board2[i-1][j+1] == 0 || board2[i-1][j+1] == 3))
{board2[i-1][j+1] = 1; drawb(board[i-1][j+1], i-1, j+1);if(board[i-1][j+1]==0){showarea(i-1, j+1);}}
if (board[i-2][j+1] != 14 && (board2[i-2][j+1] == 0 || board2[i-2][j+1] == 3))
{board2[i-2][j+1] = 1; drawb(board[i-2][j+1], i-2,j+1);if(board[i-2][j+1]==0){showarea(i-2,j+1);}}
						} else {
				if (i == (boardx-1-1)) {
if (board[i][j+1] != 14 && (board2[i][j+1] == 0 || board2[i][j+1] == 3))
{board2[i][j+1] = 1; drawb(board[i][j+1], i, j+1);if(board[i][j+1] == 0){showarea(i, j+1);}}
if (board[i+1][j+1] != 14 && (board2[i+1][j+1] == 0 || board2[i+1][j+1] == 3))
{board2[i+1][j+1] = 1; drawb(board[i+1][j+1], i+1, j+1);if(board[i+1][j+1]==0){showarea(i+1, j+1);}}
if (board[i-1][j+1] != 14 && (board2[i-1][j+1] == 0 || board2[i-1][j+1] == 3))
{board2[i-1][j+1] = 1; drawb(board[i-1][j+1], i-1, j+1);if(board[i-1][j+1]==0){showarea(i-1, j+1);}}
if (board[i-2][j+1] != 14 && (board2[i-2][j+1] == 0 || board2[i-2][j+1] == 3))
{board2[i-2][j+1] = 1; drawb(board[i-2][j+1], i-2, j+1);if(board[i-2][j+1]==0){showarea(i-2, j+1);}}
								} else {
									if (i == 1) {
if (board[i][j+1] != 14 && (board2[i][j+1] == 0 || board2[i][j+1] == 3))
{board2[i][j+1] = 1; drawb(board[i][j+1], i, j+1);if(board[i][j+1] == 0){showarea(i, j+1);}}
if (board[i-1][j+1] != 14 && (board2[i-1][j+1] == 0 || board2[i-1][j+1] == 3))
{board2[i-1][j+1] = 1; drawb(board[i-1][j+1], i-1, j+1);if(board[i-1][j+1]==0){showarea(i-1, j+1);}}
if (board[i+1][j+1] != 14 && (board2[i+1][j+1] == 0 || board2[i+1][j+1] == 3))
{board2[i+1][j+1] = 1; drawb(board[i+1][j+1], i+1, j+1);if(board[i+1][j+1]==0){showarea(i+1, j+1);}}
if (board[i+2][j+1] != 14 && (board2[i+2][j+1] == 0 || board2[i+2][j+1] == 3))
{board2[i+2][j+1] = 1; drawb(board[i+2][j+1], i+2, j+1);if(board[i+2][j+1]==0){showarea(i+2, j+1);}}
										} else {
if (board[i][j+1] != 14 && (board2[i][j+1] == 0 || board2[i][j+1] == 3))
{board2[i][j+1] = 1; drawb(board[i][j+1], i, j+1);if(board[i][j+1] == 0){showarea(i, j+1);}}
if (board[i-1][j+1] != 14 && (board2[i-1][j+1] == 0 || board2[i-1][j+1] == 3))
{board2[i-1][j+1] = 1; drawb(board[i-1][j+1], i-1, j+1);if(board[i-1][j+1]==0){showarea(i-1, j+1);}}
if (board[i-2][j+1] != 14 && (board2[i-2][j+1] == 0 || board2[i-2][j+1] == 3))
{board2[i-2][j+1] = 1; drawb(board[i-2][j+1], i-2, j+1);if(board[i-2][j+1]==0){showarea(i-2, j+1);}}
if (board[i+1][j+1] != 14 && (board2[i+1][j+1] == 0 || board2[i+1][j+1] == 3))
{board2[i+1][j+1] = 1; drawb(board[i+1][j+1], i+1, j+1);if(board[i+1][j+1]==0){showarea(i+1, j+1);}}
if (board[i+2][j+1] != 14 && (board2[i+2][j+1] == 0 || board2[i+2][j+1] == 3))
{board2[i+2][j+1] = 1; drawb(board[i+2][j+1], i+2, j+1);if(board[i+2][j+1]==0){showarea(i+2, j+1);}}
											}
													}}}}

								
}
else
{
//image2

if (j < boardy-1) {
		if (i == 0) {
if (board[i][j+1] != 14 && (board2[i][j+1] == 0 || board2[i][j+1] == 3))
{board2[i][j+1] = 1; drawb(board[i][j+1], i, j+1); if(board[i][j+1] == 0){showarea(i, j+1);}}
if (board[i+1][j+1] != 14 && (board2[i+1][j+1] == 0 || board2[i+1][j+1] == 3))
{board2[i+1][j+1] = 1; drawb(board[i+1][j+1], i+1, j+1);if(board[i+1][j+1]==0){showarea(i+1, j+1);}}
				} else {
			if (i == boardx-1) {
if (board[i][j+1] != 14 && (board2[i][j+1] == 0 || board2[i][j+1] == 3))
{board2[i][j+1] = 1; drawb(board[i][j+1], i, j+1);if(board[i][j+1] == 0){showarea(i, j+1);}}
if (board[i-1][j+1] != 14 && (board2[i-1][j+1] == 0 || board2[i-1][j+1] == 3))
{board2[i-1][j+1] = 1; drawb(board[i-1][j+1], i-1, j+1);if(board[i-1][j+1]==0){showarea(i-1, j+1);}}
							} else {
if (board[i][j+1] != 14 && (board2[i][j+1] == 0 || board2[i][j+1] == 3))
{board2[i][j+1] = 1; drawb(board[i][j+1], i, j+1);if(board[i][j+1] == 0){showarea(i, j+1);}}
if (board[i-1][j+1] != 14 && (board2[i-1][j+1] == 0 || board2[i-1][j+1] == 3))
{board2[i-1][j+1] = 1; drawb(board[i-1][j+1], i-1, j+1);if(board[i-1][j+1]==0){showarea(i-1, j+1);}}
if (board[i+1][j+1] != 14 && (board2[i+1][j+1] == 0 || board2[i+1][j+1] == 3))
{board2[i+1][j+1] = 1; drawb(board[i+1][j+1], i+1, j+1);if(board[i+1][j+1]==0){showarea(i+1, j+1);}}
								}
									}
										}

if (j > 0) {
		if (i == 0) {
if (board[i][j-1] != 14 && (board2[i][j-1] == 0 || board2[i][j-1] == 3))
{board2[i][j-1] = 1; drawb(board[i][j-1], i, j-1);if(board[i][j-1] == 0){showarea(i, j-1);}}
if (board[i+1][j-1] != 14 && (board2[i+1][j-1] == 0 || board2[i+1][j-1] == 3))
{board2[i+1][j-1] = 1; drawb(board[i+1][j-1], i+1, j-1);if(board[i+1][j-1]==0){showarea(i+1, j-1);}}
if (board[i+2][j-1] != 14 && (board2[i+2][j-1] == 0 || board2[i+2][j-1] == 3))
{board2[i+2][j-1] = 1; drawb(board[i+2][j-1], i+2, j-1);if(board[i+2][j-1]==0){showarea(i+2, j-1);}}
				} else {
					if (i == boardx-1) {
if (board[i][j-1] != 14 && (board2[i][j-1] == 0 || board2[i][j-1]  == 3))
{board2[i][j-1] = 1; drawb(board[i][j-1], i, j-1);if(board[i][j-1] == 0){showarea(i, j-1);}}
if (board[i-1][j-1] != 14 && (board2[i-1][j-1] == 0 || board2[i-1][j-1] == 3))
{board2[i-1][j-1] = 1; drawb(board[i-1][j-1], i-1, j-1);if(board[i-1][j-1]==0){showarea(i-1, j-1);}}
if (board[i-2][j-1] != 14 && (board2[i-2][j-1] == 0 || board2[i-2][j-1] == 3))
{board2[i-2][j-1] = 1; drawb(board[i-2][j-1], i-2, j-1);if(board[i-2][j-1]==0){showarea(i-2, j-1);}}
							} else {
								if (i == (boardx-1-1)) {
if (board[i][j-1] != 14 && (board2[i][j-1] == 0 || board2[i][j-1] == 3))
{board2[i][j-1] = 1; drawb(board[i][j-1], i, j-1);if(board[i][j-1] == 0){showarea(i, j-1);}}
if (board[i+1][j-1] != 14 && (board2[i+1][j-1] == 0 || board2[i+1][j-1] == 3))
{board2[i+1][j-1] = 1; drawb(board[i+1][j-1], i+1, j-1);if(board[i+1][j-1]==0){showarea(i+1, j-1);}}
if (board[i-1][j-1] != 14 && (board2[i-1][j-1] == 0 || board2[i-1][j-1] == 3))
{board2[i-1][j-1] = 1; drawb(board[i-1][j-1], i-1, j-1);if(board[i-1][j-1]==0){showarea(i-1, j-1);}}
if (board[i-2][j-1] != 14 && (board2[i-2][j-1] == 0 || board2[i-2][j-1] == 3))
{board2[i-2][j-1] = 1; drawb(board[i-2][j-1], i-2, j-1);if(board[i-2][j-1]==0){showarea(i-2, j-1);}}
							} else {
									if (i == 1) {
if (board[i][j-1] != 14 && (board2[i][j-1] == 0 || board2[i][j-1] == 3))
{board2[i][j-1] = 1; drawb(board[i][j-1], i, j-1);if(board[i][j-1] == 0){showarea(i, j-1);}}
if (board[i-1][j-1] != 14 && (board2[i-1][j-1] == 0 || board2[i-1][j-1] == 3))
{board2[i-1][j-1] = 1; drawb(board[i-1][j-1], i-1, j-1);if(board[i-1][j-1]==0){showarea(i-1, j-1);}}
if (board[i+1][j-1] != 14 && (board2[i+1][j-1] == 0 || board2[i+1][j-1] == 3))
{board2[i+1][j-1] = 1; drawb(board[i+1][j-1], i+1, j-1);if(board[i+1][j-1]==0){showarea(i+1, j-1);}}
if (board[i+2][j-1] != 14 && (board2[i+2][j-1] == 0 || board2[i+2][j-1] == 3))
{board2[i+2][j-1] = 1; drawb(board[i+2][j-1], i+2, j-1);if(board[i+2][j-1]==0){showarea(i+2, j-1);}}
						} else {
if (board[i][j-1] != 14 && (board2[i][j-1] == 0 || board2[i][j-1] == 3))
{board2[i][j-1] = 1; drawb(board[i][j-1], i, j-1);if(board[i][j-1] == 0){showarea(i, j-1);}}
if (board[i-1][j-1] != 14 && (board2[i-1][j-1] == 0 || board2[i-1][j-1] == 3))
{board2[i-1][j-1] = 1; drawb(board[i-1][j-1], i-1, j-1);if(board[i-1][j-1]==0){showarea(i-1, j-1);}}
if (board[i-2][j-1] != 14 && (board2[i-2][j-1] == 0 || board2[i-2][j-1] == 3))
{board2[i-2][j-1] = 1; drawb(board[i-2][j-1], i-2, j-1);if(board[i-2][j-1]==0){showarea(i-2, j-1);}}
if (board[i+1][j-1] != 14 && (board2[i+1][j-1] == 0 || board2[i+1][j-1] == 3))
{board2[i+1][j-1] = 1; drawb(board[i+1][j-1], i+1, j-1);if(board[i+1][j-1]==0){showarea(i+1, j-1);}}
if (board[i+2][j-1] != 14 && (board2[i+2][j-1] == 0 || board2[i+2][j-1] == 3))
{board2[i+2][j-1] = 1; drawb(board[i+2][j-1], i+2, j-1);if(board[i+2][j-1]==0){showarea(i+2, j-1);}}
												}
													}}}}



}

} // end of function



void middleclick(int i, int j)
{
int z;

if (i == 1) {
if (board2[i-1][j] != 2)
{board2[i-1][j] = 1; drawb(board[i-1][j], i-1, j); if(board[i-1][j] == 14){gameover();} else {if(board[i-1][j] == 0){showarea(i-1, j);}}}
if (board2[i+1][j] != 2)
{board2[i+1][j] = 1; drawb(board[i+1][j], i+1, j); if(board[i+1][j] == 14){gameover();} else {if(board[i+1][j] == 0){showarea(i+1, j);}}}
if (board2[i+2][j] != 2)
{board2[i+2][j] = 1; drawb(board[i+2][j], i+2, j); if(board[i+2][j] == 14){gameover();} else {if(board[i+2][j] == 0){showarea(i+2, j);}}}
} else {
if (i == 0) {
if (board2[i+1][j] != 2)
{board2[i+1][j] = 1; drawb(board[i+1][j], i+1, j); if(board[i+1][j] == 14){gameover();} else {if(board[i+1][j] == 0){showarea(i+1, j);}}}
if (board2[i+2][j] != 2)
{board2[i+2][j] = 1; drawb(board[i+2][j], i+2, j); if(board[i+2][j] == 14){gameover();} else {if(board[i+2][j] == 0){showarea( i+2, j);}}}
			} else {
				if (i == (boardx-1 - 1)) {
if (board2[i-1][j] != 2)
{board2[i-1][j] = 1; drawb(board[i-1][j], i-1, j); if(board[i-1][j] == 14){gameover();} else {if(board[i-1][j] == 0){showarea(i-1, j);}}}
if (board2[i-2][j] != 2)
{board2[i-2][j] = 1; drawb(board[i-2][j], i-2, j); if(board[i-2][j] == 14){gameover();} else {if(board[i-2][j] == 0){showarea(i-2, j);}}}
if (board2[i+1][j] != 2)
{board2[i+1][j] = 1; drawb(board[i+1][j], i+1, j); if(board[i+1][j] == 14){gameover();} else {if(board[i+1][j] == 0){showarea(i+1, j);}}}
							} else {
								if (i == boardx-1) {
if (board2[i-1][j] != 2)
{board2[i-1][j] = 1; drawb(board[i-1][j], i-1, j); if(board[i-1][j] == 14){gameover();} else {if(board[i-1][j] == 0){showarea(i-1, j);}}}
if (board2[i-2][j] != 2)
{board2[i-2][j] = 1; drawb(board[i-2][j], i-2, j); if(board[i-2][j] == 14){gameover();} else {if(board[i-2][j] == 0){showarea(i-2, j);}}}
										} else {
if (board2[i-1][j] != 2)
{board2[i-1][j] = 1; drawb(board[i-1][j], i-1, j); if(board[i-1][j] == 14){gameover();} else {if(board[i-1][j] == 0){showarea(i-1, j);}}}
if (board2[i-2][j] != 2)
{board2[i-2][j] = 1; drawb(board[i-2][j], i-2, j); if(board[i-2][j] == 14){gameover();} else {if(board[i-2][j] == 0){showarea(i-2, j);}}}
if (board2[i+1][j] != 2)
{board2[i+1][j] = 1; drawb(board[i+1][j], i+1, j); if(board[i+1][j] == 14){gameover();} else {if(board[i+1][j] == 0){showarea(i+1, j);}}}
if (board2[i+2][j] != 2)
{board2[i+2][j] = 1; drawb(board[i+2][j], i+2, j); if(board[i+2][j] == 14){gameover();} else {if(board[i+2][j] == 0){showarea(i+2, j);}}}
											}}}}



z = 0;
if ((j % 2) != 0){z = 1;}

if ((i % 2) == z){
// image

if (j > 0) {
		if (i == 0) {
if (board2[i][j-1] != 2)
{board2[i][j-1] = 1; drawb(board[i][j-1], i, j-1); if(board[i][j-1] == 14){gameover();} else {if(board[i][j-1] == 0){showarea(i, j-1);}}}
if (board2[i+1][j-1] != 2)
{board2[i+1][j-1] = 1; drawb(board[i+1][j-1], i+1, j-1);if(board[i+1][j-1] == 14){gameover();}else{if(board[i+1][j-1]==0){showarea(i+1,j-1);}}}
				} else {
					if (i == boardx-1) {
if (board2[i][j-1] != 2)
{board2[i][j-1] = 1; drawb(board[i][j-1], i, j-1);if(board[i][j-1] == 14){gameover();} else {if(board[i][j-1] == 0){showarea(i, j-1);}}}
if (board2[i-1][j-1] != 2)
{board2[i-1][j-1] = 1; drawb(board[i-1][j-1], i-1, j-1);if(board[i-1][j-1] == 14){gameover();} else {if(board[i-1][j-1] == 0){showarea(i-1, j-1);}}}
							} else {
if (board2[i][j-1] != 2)
{board2[i][j-1] = 1; drawb(board[i][j-1], i, j-1);if(board[i][j-1] == 14){gameover();} else {if(board[i][j-1] == 0){showarea(i, j-1);}}}
if (board2[i-1][j-1] != 2)
{board2[i-1][j-1] = 1; drawb(board[i-1][j-1], i-1, j-1);if(board[i-1][j-1] == 14){gameover();}else{if(board[i-1][j-1]==0){showarea(i-1,j-1);}}}
if (board2[i+1][j-1] != 2)
{board2[i+1][j-1] = 1; drawb(board[i+1][j-1], i+1, j-1);if(board[i+1][j-1] == 14){gameover();} else {if(board[i+1][j-1] == 0){showarea(i+1, j-1);}}}
								}
									}
										}

if (j < boardy-1) {
		if (i == 0) {
if (board2[i][j+1] != 2)
{board2[i][j+1] = 1; drawb(board[i][j+1], i, j+1);if(board[i][j+1] == 14){gameover();} else {if(board[i][j+1] == 0){showarea(i, j+1);}}}
if (board2[i+1][j+1] != 2)
{board2[i+1][j+1] = 1; drawb(board[i+1][j+1], i+1, j+1);if(board[i+1][j+1] == 14){gameover();} else {if(board[i+1][j+1] == 0){showarea(i+1, j+1);}}}
if (board2[i+2][j+1] != 2)
{board2[i+2][j+1] = 1; drawb(board[i+2][j+1], i+2, j+1);if(board[i+2][j+1] == 14){gameover();} else {if(board[i+2][j+1] == 0){showarea(i+2, j+1);}}}
				} else {
				if (i == boardx-1) {
if (board2[i][j+1] != 2)
{board2[i][j+1] = 1; drawb(board[i][j+1], i, j+1);if(board[i][j+1] == 14){gameover();} else {if(board[i][j+1] == 0){showarea(i, j+1);}}}
if (board2[i-1][j+1] != 2)
{board2[i-1][j+1] = 1; drawb(board[i-1][j+1], i-1, j+1);if(board[i-1][j+1] == 14){gameover();} else {if(board[i-1][j+1] == 0){showarea(i-1, j+1);}}}
if (board2[i-2][j+1] != 2)
{board2[i-2][j+1] = 1; drawb(board[i-2][j+1], i-2,j+1);if(board[i-2][j+1] == 14){gameover();} else {if(board[i-2][j+1] == 0){showarea(i-2,j+1);}}}
						} else {
				if (i == (boardx-1-1)) {
if (board2[i][j+1] != 2)
{board2[i][j+1] = 1; drawb(board[i][j+1], i, j+1);if(board[i][j+1] == 14){gameover();} else {if(board[i][j+1] == 0){showarea(i, j+1);}}}
if (board2[i+1][j+1] != 2)
{board2[i+1][j+1] = 1; drawb(board[i+1][j+1], i+1, j+1);if(board[i+1][j+1] == 14){gameover();} else {if(board[i+1][j+1] == 0){showarea(i+1, j+1);}}}
if (board2[i-1][j+1] != 2)
{board2[i-1][j+1] = 1; drawb(board[i-1][j+1], i-1, j+1);if(board[i-1][j+1] == 14){gameover();} else {if(board[i-1][j+1] == 0){showarea(i-1, j+1);}}}
if (board2[i-2][j+1] != 2)
{board2[i-2][j+1] = 1; drawb(board[i-2][j+1], i-2, j+1);if(board[i-2][j+1] == 14){gameover();} else {if(board[i-2][j+1] == 0){showarea(i-2, j+1);}}}
								} else {
									if (i == 1) {
if (board2[i][j+1] != 2)
{board2[i][j+1] = 1; drawb(board[i][j+1], i, j+1);if(board[i][j+1] == 14){gameover();} else {if(board[i][j+1] == 0){showarea(i, j+1);}}}
if (board2[i-1][j+1] != 2)
{board2[i-1][j+1] = 1; drawb(board[i-1][j+1], i-1, j+1);if(board[i-1][j+1] == 14){gameover();} else {if(board[i-1][j+1] == 0){showarea(i-1, j+1);}}}
if (board2[i+1][j+1] != 2)
{board2[i+1][j+1] = 1; drawb(board[i+1][j+1], i+1, j+1);if(board[i+1][j+1] == 14){gameover();} else {if(board[i+1][j+1] == 0){showarea(i+1, j+1);}}}
if (board2[i+2][j+1] != 2)
{board2[i+2][j+1] = 1; drawb(board[i+2][j+1], i+2, j+1);if(board[i+2][j+1] == 14){gameover();} else {if(board[i+2][j+1] == 0){showarea(i+2, j+1);}}}
										} else {
if (board2[i][j+1] != 2)
{board2[i][j+1] = 1; drawb(board[i][j+1], i, j+1);if(board[i][j+1] == 14){gameover();} else {if(board[i][j+1] == 0){showarea(i, j+1);}}}
if (board2[i-1][j+1] != 2)
{board2[i-1][j+1] = 1; drawb(board[i-1][j+1], i-1, j+1);if(board[i-1][j+1] == 14){gameover();} else {if(board[i-1][j+1] == 0){showarea(i-1, j+1);}}}
if (board2[i-2][j+1] != 2)
{board2[i-2][j+1] = 1; drawb(board[i-2][j+1], i-2, j+1);if(board[i-2][j+1] == 14){gameover();} else {if(board[i-2][j+1] == 0){showarea(i-2, j+1);}}}
if (board2[i+1][j+1] != 2)
{board2[i+1][j+1] = 1; drawb(board[i+1][j+1], i+1, j+1);if(board[i+1][j+1] == 14){gameover();} else {if(board[i+1][j+1] == 0){showarea(i+1, j+1);}}}
if (board2[i+2][j+1] != 2)
{board2[i+2][j+1] = 1; drawb(board[i+2][j+1], i+2, j+1);if(board[i+2][j+1] == 14){gameover();} else {if(board[i+2][j+1] == 0){showarea(i+2, j+1);}}}
											}
													}}}}

								
}
else
{
//image2

if (j < boardy-1) {
		if (i == 0) {
if (board2[i][j+1] != 2)
{board2[i][j+1] = 1; drawb(board[i][j+1], i, j+1); if(board[i][j+1] == 14){gameover();} else {if(board[i][j+1] == 0){showarea(i, j+1);}}}
if (board2[i+1][j+1] != 2)
{board2[i+1][j+1] = 1; drawb(board[i+1][j+1], i+1, j+1);if(board[i+1][j+1] == 14){gameover();} else {if(board[i+1][j+1] == 0){showarea(i+1, j+1);}}}
				} else {
			if (i == boardx-1) {
if (board2[i][j+1] != 2)
{board2[i][j+1] = 1; drawb(board[i][j+1], i, j+1);if(board[i][j+1] == 14){gameover();} else {if(board[i][j+1] == 0){showarea(i, j+1);}}}
if (board2[i-1][j+1] != 2)
{board2[i-1][j+1] = 1; drawb(board[i-1][j+1], i-1, j+1);if(board[i-1][j+1] == 14){gameover();} else {if(board[i-1][j+1] == 0){showarea(i-1, j+1);}}}
							} else {
if (board2[i][j+1] != 2)
{board2[i][j+1] = 1; drawb(board[i][j+1], i, j+1);if(board[i][j+1] == 14){gameover();} else {if(board[i][j+1] == 0){showarea(i, j+1);}}}
if (board2[i-1][j+1] != 2)
{board2[i-1][j+1] = 1; drawb(board[i-1][j+1], i-1, j+1);if(board[i-1][j+1] == 14){gameover();} else {if(board[i-1][j+1] == 0){showarea(i-1, j+1);}}}
if (board2[i+1][j+1] != 2)
{board2[i+1][j+1] = 1; drawb(board[i+1][j+1], i+1, j+1);if(board[i+1][j+1] == 14){gameover();} else {if(board[i+1][j+1] == 0){showarea(i+1, j+1);}}}
								}
									}
										}

if (j > 0) {
		if (i == 0) {
if (board2[i][j-1] != 2)
{board2[i][j-1] = 1; drawb(board[i][j-1], i, j-1);if(board[i][j-1] == 14){gameover();} else {if(board[i][j-1] == 0){showarea(i, j-1);}}}
if (board2[i+1][j-1] != 2)
{board2[i+1][j-1] = 1; drawb(board[i+1][j-1], i+1, j-1);if(board[i+1][j-1] == 14){gameover();} else {if(board[i+1][j-1] == 0){showarea(i+1, j-1);}}}
if (board2[i+2][j-1] != 2)
{board2[i+2][j-1] = 1; drawb(board[i+2][j-1], i+2, j-1);if(board[i+2][j-1] == 14){gameover();} else {if(board[i+2][j-1] == 0){showarea(i+2, j-1);}}}
				} else {
					if (i == boardx-1) {
if (board2[i][j-1] != 2)
{board2[i][j-1] = 1; drawb(board[i][j-1], i, j-1);if(board[i][j-1] == 14){gameover();} else {if(board[i][j-1] == 0){showarea(i, j-1);}}}
if (board2[i-1][j-1] != 2)
{board2[i-1][j-1] = 1; drawb(board[i-1][j-1], i-1, j-1);if(board[i-1][j-1] == 14){gameover();} else {if(board[i-1][j-1] == 0){showarea(i-1, j-1);}}}
if (board2[i-2][j-1] != 2)
{board2[i-2][j-1] = 1; drawb(board[i-2][j-1], i-2, j-1);if(board[i-2][j-1] == 14){gameover();} else {if(board[i-2][j-1] == 0){showarea(i-2, j-1);}}}
							} else {
								if (i == (boardx-1-1)) {
if (board2[i][j-1] != 2)
{board2[i][j-1] = 1; drawb(board[i][j-1], i, j-1);if(board[i][j-1] == 14){gameover();} else {if(board[i][j-1] == 0){showarea( i, j-1);}}}
if (board2[i+1][j-1] != 2)
{board2[i+1][j-1] = 1; drawb(board[i+1][j-1], i+1, j-1);if(board[i+1][j-1] == 14){gameover();} else {if(board[i+1][j-1] == 0){showarea(i+1, j-1);}}}
if (board2[i-1][j-1] != 2)
{board2[i-1][j-1] = 1; drawb(board[i-1][j-1], i-1, j-1);if(board[i-1][j-1] == 14){gameover();} else {if(board[i-1][j-1] == 0){showarea(i-1, j-1);}}}
if (board2[i-2][j-1] != 2)
{board2[i-2][j-1] = 1; drawb(board[i-2][j-1], i-2, j-1);if(board[i-2][j-1] == 14){gameover();} else {if(board[i-2][j-1] == 0){showarea(i-2, j-1);}}}
							} else {
									if (i == 1) {
if (board2[i][j-1] != 2)
{board2[i][j-1] = 1; drawb(board[i][j-1], i, j-1);if(board[i][j-1] == 14){gameover();} else {if(board[i][j-1] == 0){showarea(i, j-1);}}}
if (board2[i-1][j-1] != 2)
{board2[i-1][j-1] = 1; drawb(board[i-1][j-1], i-1, j-1);if(board[i-1][j-1] == 14){gameover();} else {if(board[i-1][j-1] == 0){showarea(i-1, j-1);}}}
if (board2[i+1][j-1] != 2)
{board2[i+1][j-1] = 1; drawb(board[i+1][j-1], i+1, j-1);if(board[i+1][j-1] == 14){gameover();} else {if(board[i+1][j-1] == 0){showarea(i+1, j-1);}}}
if (board2[i+2][j-1] != 2)
{board2[i+2][j-1] = 1; drawb(board[i+2][j-1], i+2, j-1);if(board[i+2][j-1] == 14){gameover();} else {if(board[i+2][j-1] == 0){showarea(i+2, j-1);}}}
						} else {
if (board2[i][j-1] != 2)
{board2[i][j-1] = 1; drawb(board[i][j-1], i, j-1);if(board[i][j-1] == 14){gameover();} else {if(board[i][j-1] == 0){showarea(i, j-1);}}}
if (board2[i-1][j-1] != 2)
{board2[i-1][j-1] = 1; drawb(board[i-1][j-1], i-1, j-1);if(board[i-1][j-1] == 14){gameover();} else {if(board[i-1][j-1] == 0){showarea(i-1, j-1);}}}
if (board2[i-2][j-1] != 2)
{board2[i-2][j-1] = 1; drawb(board[i-2][j-1], i-2, j-1);if(board[i-2][j-1] == 14){gameover();} else {if(board[i-2][j-1] == 0){showarea(i-2, j-1);}}}
if (board2[i+1][j-1] != 2)
{board2[i+1][j-1] = 1; drawb(board[i+1][j-1], i+1, j-1);if(board[i+1][j-1] == 14){gameover();} else {if(board[i+1][j-1] == 0){showarea(i+1, j-1);}}}
if (board2[i+2][j-1] != 2)
{board2[i+2][j-1] = 1; drawb(board[i+2][j-1], i+2, j-1);if(board[i+2][j-1] == 14){gameover();} else {if(board[i+2][j-1] == 0){showarea(i+2, j-1);}}}
												}
													}}}}



}





} // end of function
