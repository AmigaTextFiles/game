/*
##########################################
#         TriMines version 1.3.0         #
#                                        #
#         gamestatus.c - deals with      #
#         wining, losing, etc.           #
##########################################
*/

void gameover()
{
int i,j;

for (i=0;i < boardx;i++){
for (j=0;j < boardy;j++){

if (board[i][j] != 14) {

	if (board2[i][j] == 2) {
	board2[i][j] = 4;
	drawb(123, i, j);}

} else {

	if (board2[i][j] != 2) {
	board2[i][j] = 1;
	drawb(board[i][j], i, j);
	}	
	
}



}}
gamestatus = 2;
ShowBMP(Ismile2, screen, smileyposx,smileyposy);

} // end of function



int checkwining()
{
int i,j,win;

win = 1;


for (i=0;i < boardx;i++){
	for (j=0;j < boardy;j++){
//if ((board[i][j] == 14 && board2[i][j] != 2) || (board2[i][j] == 0) || (board2[i][j] == 3)) {win = 0;}

		if (board[i][j] != 14 && board2[i][j] != 1) {win = 0;}


}}

//if (flags != 0){win = 0;}
return win;

} // end of function


void won()
{
int i,j;

for (i=0;i < boardx;i++){
	for (j=0;j < boardy;j++){
		if (board[i][j] == 14 && board2[i][j] != 2) {
				board2[i][j] = 2;
				drawb(123,i,j);
								}

}}

drawcounter(0,flagcounterx,flagcountery);
ShowBMP(Ismile3, screen, smileyposx,smileyposy);
gamestatus = 1;

}


void solve()
{
int i,j;

for (i=0;i < boardx;i++){
	for (j=0;j < boardy;j++){

if (board[i][j] == 14) {
		board2[i][j] = 2;
		drawb(123, i, j);
		} else {
			board2[i][j] = 1;
			drawb(board[i][j], i, j);
									}
		
	}}

won();
}

void newgame()
{
l_timer = 0;
flags = mines;
gamestatus = 0;
firstclick = 1;
ShowBMP(Ismile, screen, smileyposx,smileyposy);
drawcounter(flags,flagcounterx,flagcountery);
drawcounter(0 ,timercounterx,timercountery);
clearboard();
draw_board();
} // end of function
