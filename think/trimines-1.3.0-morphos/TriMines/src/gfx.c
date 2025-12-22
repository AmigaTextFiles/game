/*
##########################################
#         TriMines version 1.3.0         #
#                                        #
#         gfx.c - deals with graphics.   #
#                                        #
##########################################
*/

void ShowBMP(SDL_Surface *image, SDL_Surface *screen, int x, int y)
{
SDL_Rect dest;

SDL_SetColorKey(image, SDL_SRCCOLORKEY, SDL_MapRGB(image->format, 11, 255, 241));

    /* Blit onto the screen surface.
       The surfaces should not be locked at this point.
     */
    dest.x = x;
    dest.y = y;
    dest.w = image->w;
    dest.h = image->h;
    SDL_BlitSurface(image, NULL, screen, &dest);

    /* Update the changed portion of the screen */
    SDL_UpdateRects(screen, 1, &dest);
}

void load_images()
{
Ibutton = SDL_LoadBMP("data/triangles/button.bmp");
Ibutton2 = SDL_LoadBMP("data/triangles/button2.bmp");
Iflag = SDL_LoadBMP("data/triangles/flag.bmp");
Iflag2 = SDL_LoadBMP("data/triangles/flag2.bmp");
Ifalse = SDL_LoadBMP("data/triangles/false.bmp");
Ifalse2 = SDL_LoadBMP("data/triangles/false2.bmp");
Iclicked = SDL_LoadBMP("data/triangles/clicked.bmp");
Iclicked2 = SDL_LoadBMP("data/triangles/clicked2.bmp");
Iquestion = SDL_LoadBMP("data/triangles/question.bmp");
Iquestion2 = SDL_LoadBMP("data/triangles/question2.bmp");
Imine = SDL_LoadBMP("data/triangles/mine.bmp");
Imine2 = SDL_LoadBMP("data/triangles/mine2.bmp");
Iredmine = SDL_LoadBMP("data/triangles/redmine.bmp");
Iredmine2 = SDL_LoadBMP("data/triangles/redmine2.bmp");
I1 = SDL_LoadBMP("data/triangles/1.bmp");
I1_2 = SDL_LoadBMP("data/triangles/1_2.bmp");
I2 = SDL_LoadBMP("data/triangles/2.bmp");
I2_2 = SDL_LoadBMP("data/triangles/2_2.bmp");
I3 = SDL_LoadBMP("data/triangles/3.bmp");
I3_2 = SDL_LoadBMP("data/triangles/3_2.bmp");
I4 = SDL_LoadBMP("data/triangles/4.bmp");
I4_2 = SDL_LoadBMP("data/triangles/4_2.bmp");
I5 = SDL_LoadBMP("data/triangles/5.bmp");
I5_2 = SDL_LoadBMP("data/triangles/5_2.bmp");
I6 = SDL_LoadBMP("data/triangles/6.bmp");
I6_2 = SDL_LoadBMP("data/triangles/6_2.bmp");
I7 = SDL_LoadBMP("data/triangles/7.bmp");
I7_2 = SDL_LoadBMP("data/triangles/7_2.bmp");
I8 = SDL_LoadBMP("data/triangles/8.bmp");
I8_2 = SDL_LoadBMP("data/triangles/8_2.bmp");
I9 = SDL_LoadBMP("data/triangles/9.bmp");
I9_2 = SDL_LoadBMP("data/triangles/9_2.bmp");
I10 = SDL_LoadBMP("data/triangles/10.bmp");
I10_2 = SDL_LoadBMP("data/triangles/10_2.bmp");
I11 = SDL_LoadBMP("data/triangles/11.bmp");
I11_2 = SDL_LoadBMP("data/triangles/11_2.bmp");
I12 = SDL_LoadBMP("data/triangles/12.bmp");
I12_2 = SDL_LoadBMP("data/triangles/12_2.bmp");


Icounter0 = SDL_LoadBMP("data/counter/counter_0.bmp");
Icounter1 = SDL_LoadBMP("data/counter/counter_1.bmp");
Icounter2 = SDL_LoadBMP("data/counter/counter_2.bmp");
Icounter3 = SDL_LoadBMP("data/counter/counter_3.bmp");
Icounter4 = SDL_LoadBMP("data/counter/counter_4.bmp");
Icounter5 = SDL_LoadBMP("data/counter/counter_5.bmp");
Icounter6 = SDL_LoadBMP("data/counter/counter_6.bmp");
Icounter7 = SDL_LoadBMP("data/counter/counter_7.bmp");
Icounter8 = SDL_LoadBMP("data/counter/counter_8.bmp");
Icounter9 = SDL_LoadBMP("data/counter/counter_9.bmp");
Icounterm = SDL_LoadBMP("data/counter/counter_m.bmp");
Icounterclear = SDL_LoadBMP("data/counter/counter_clear.bmp");

Imenu = SDL_LoadBMP("data/menu/menu.bmp");
Imenu_newgame = SDL_LoadBMP("data/menu/newgame.bmp");
Imenu_options = SDL_LoadBMP("data/menu/options.bmp");
Imenu_quit = SDL_LoadBMP("data/menu/quit.bmp");
Imenu_width = SDL_LoadBMP("data/menu/width.bmp");
Imenu_height = SDL_LoadBMP("data/menu/height.bmp");
Imenu_mines = SDL_LoadBMP("data/menu/mines.bmp");


Ipointer = SDL_LoadBMP("data/misc/pointer.bmp");
Ipointer2 = SDL_LoadBMP("data/misc/pointer2.bmp");
Ibar = SDL_LoadBMP("data/misc/bar.bmp");
Ibar2 = SDL_LoadBMP("data/misc/bar2.bmp");
Ismile = SDL_LoadBMP("data/misc/smile.bmp");
Ismile2 = SDL_LoadBMP("data/misc/smile2.bmp");
Ismile3 = SDL_LoadBMP("data/misc/smile3.bmp");
Ismile4 = SDL_LoadBMP("data/misc/smile4.bmp");

loadimgs = 0;
}

void drawb(int q,int x, int y)
{
SDL_Surface *image, *image2;
int z;

if ((board2[x][y] == 0) && (q != 16)){
image = Ibutton; 
image2 = Ibutton2;
} else {


if ((board2[x][y] == 2) && (q != 16)){
image = Iflag; 
image2 = Iflag2;
} else {

if ((board2[x][y] == 3) && (q != 16)){
image = Iquestion;
image2 = Iquestion2;
} else {

if ((board2[x][y] == 4) && (q != 16)){
image = Ifalse;
image2 = Ifalse2;
} else {

switch (q)
{
	case 0: image = Iclicked;
		image2 = Iclicked2;
		break;
	case 1: image = I1;
		image2 = I1_2;
		break;
	case 2: image = I2;
		image2 = I2_2;
		break;
	case 3: image = I3;
		image2 = I3_2;
		break;
	case 4: image = I4;
		image2 = I4_2;
		break;
	case 5: image = I5;
		image2 = I5_2;
		break;
	case 6: image = I6;
		image2 = I6_2;
		break;
	case 7: image = I7;
		image2 = I7_2;
		break;
	case 8: image = I8;
		image2 = I8_2;
		break;
	case 9: image = I9;
		image2 = I9_2;
		break;
	case 10: image = I10;
		image2 = I10_2;
		break;
	case 11: image = I11;
		image2 = I11_2;
		break;
	case 12: image = I12;
		image2 = I12_2;
		break;		
	case 13: image = Iredmine;
		image2 = Iredmine2;
		break;
	case 14: image = Imine;
		image2 = Imine2;
		break;
	//case 15: image = Iquestion;
		//image2 = Iquestion2;
		//break;
	case 16: image = Ipointer;
		image2 = Ipointer2;
		break;

} // end switch



}}}}




z = 0;
if ((y % 2) != 0){z = 1;}


if ((x % 2) == z){
ShowBMP(image, screen, x*12,y*20);
}
else
{
ShowBMP(image2, screen, x*12,y*20);
}


}

void draw_board()
{
int i,j;

for (i=0;i < boardx;i++){
for (j=0;j < boardy;j++){drawb(board[i][j],i,j);}
}

}

void drawcounter(int n,int posx, int posy)
{
SDL_Surface *p1, *p2, *p3, *p4;
int n1,n2,n3,num;


num = n;
if (num < 0){num = num * -1;}

if (num > 99) {
n1 = num / 100;
n2 = (num / 10) % 10;
n3 = num % 10;
} else {
	if (num > 9) {
	n1 = 0;
	n2 = num / 10;
	n3 = num % 10;
	} else {
		n1 = 0;
		n2 = 0;
		n3 = num;
				}}



if (n < 0){ShowBMP(Icounterm, screen, posx, posy);} else {ShowBMP(Icounterclear, screen, posx, posy);}



switch (n1)
{
case 0: p2 = Icounter0; break;
case 1: p2 = Icounter1; break;
case 2: p2 = Icounter2; break;
case 3: p2 = Icounter3; break;
case 4: p2 = Icounter4; break;
case 5: p2 = Icounter5; break;
case 6: p2 = Icounter6; break;
case 7: p2 = Icounter7; break;
case 8: p2 = Icounter8; break;
case 9: p2 = Icounter9; break;
}

switch (n2)
{
case 0: p3 = Icounter0; break;
case 1: p3 = Icounter1; break;
case 2: p3 = Icounter2; break;
case 3: p3 = Icounter3; break;
case 4: p3 = Icounter4; break;
case 5: p3 = Icounter5; break;
case 6: p3 = Icounter6; break;
case 7: p3 = Icounter7; break;
case 8: p3 = Icounter8; break;
case 9: p3 = Icounter9; break;
}

switch (n3)
{
case 0: p4 = Icounter0; break;
case 1: p4 = Icounter1; break;
case 2: p4 = Icounter2; break;
case 3: p4 = Icounter3; break;
case 4: p4 = Icounter4; break;
case 5: p4 = Icounter5; break;
case 6: p4 = Icounter6; break;
case 7: p4 = Icounter7; break;
case 8: p4 = Icounter8; break;
case 9: p4 = Icounter9; break;
}



ShowBMP(p2, screen, posx+15, posy);
ShowBMP(p3, screen, posx+30, posy);
ShowBMP(p4, screen, posx+45, posy);



}
