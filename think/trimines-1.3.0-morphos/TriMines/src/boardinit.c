/*
##########################################
#         TriMines version 1.3.0         #
#                                        #
#         boardinit.c - clear the board  #
#         and generate new mines.        #
##########################################
*/

void clearboard()
{
int i,j;

for (i=0;i < boardx;i++){
for (j=0;j < boardy;j++){
board[i][j] = 0;
board2[i][j] = 0;
}
}

}

void genrandmines(int ex, int ey)
{
int rx,ry,count,z,i,j;

// generate random mines + (ex,ey) will never be a mine

srand ( time(NULL) );

count = mines;

while (count != 0) {


rx = rand()%(boardx);
ry = rand()%(boardy);

if ((board[rx][ry] == 0) && ((ex != rx) || (ey != ry)))
{
board[rx][ry] = 14;
count = count - 1;
}

}


//count mines:

for (i=0;i < boardx;i++){
	for (j=0;j < boardy;j++){
		if (board[i][j] != 14) {board[i][j] = countsomething(i,j,14,board);}
	}
}

}
