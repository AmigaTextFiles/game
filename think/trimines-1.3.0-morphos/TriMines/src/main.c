/*
##########################################
#         TriMines version 1.3.0         #
#                                        #
#         main.c - deals with mouse      #
#         clicks and mouse movement.     #
##########################################
*/

#ifdef __MORPHOS__
const char *version_tag = "$VER: TriMines 1.3.0 (14.07.2006)";
#endif


/* board values:
 * 0 = clicked button
 * 1 = 1
 * 2 = 2
 * 3 = 3
 * 4 = 4
 * 5 = 5
 * 6 = 6
 * 7 = 7
 * 8 = 8
 * 9 = 9
 * 10 = 10
 * 11 = 11
 * 12 = 12
 * 13 = red mine
 * 14 = mine
 * 15 =
 * 16 = pointer
 */

/* board2 values:
 * 0 = show unpressed button
 * 1 = show as it was pressed
 * 2 = show flag
 * 3 = show question mark
 * 4 = false flagging
*/


/* gamestatus values:
 * 0 = new game or during game
 * 1 = win
 * 2 = game over
*/

/* firstclick values:
 * 0 = not first click
 * 1 = first click 
*/


#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "SDL.h"

int mouse_x, mouse_y;
int boardx = 50; // max 66
int boardy = 20; // max 26
int mines = 120; //(boardx * boardy) * minesprecents;
int flags,gamestatus,firstclick;
int board[66][26];
int board2[66][26];
SDL_Surface *screen;
SDL_Surface *Ibutton;
SDL_Surface *Ibutton2;
SDL_Surface *Iflag;
SDL_Surface *Ifalse;
SDL_Surface *Ifalse2;
SDL_Surface *Iflag2;
SDL_Surface *Iclicked;
SDL_Surface *Iclicked2;
SDL_Surface *Iquestion;
SDL_Surface *Iquestion2;
SDL_Surface *Imine;
SDL_Surface *Iredmine;
SDL_Surface *Iredmine2;
SDL_Surface *Imine2;
SDL_Surface *Ipointer;
SDL_Surface *Ipointer2;
SDL_Surface *I1;
SDL_Surface *I1_2;
SDL_Surface *I2;
SDL_Surface *I2_2;
SDL_Surface *I3;
SDL_Surface *I3_2;
SDL_Surface *I4;
SDL_Surface *I4_2;
SDL_Surface *I5;
SDL_Surface *I5_2;
SDL_Surface *I6;
SDL_Surface *I6_2;
SDL_Surface *I7;
SDL_Surface *I7_2;
SDL_Surface *I8;
SDL_Surface *I8_2;
SDL_Surface *I9;
SDL_Surface *I9_2;
SDL_Surface *I10;
SDL_Surface *I10_2;
SDL_Surface *I11;
SDL_Surface *I11_2;
SDL_Surface *I12;
SDL_Surface *I12_2;
SDL_Surface *Ibar;
SDL_Surface *Ibar2;
SDL_Surface *Ismile;
SDL_Surface *Ismile2;
SDL_Surface *Ismile3;
SDL_Surface *Ismile4;
SDL_Surface *Icounter0;
SDL_Surface *Icounter1;
SDL_Surface *Icounter2;
SDL_Surface *Icounter3;
SDL_Surface *Icounter4;
SDL_Surface *Icounter5;
SDL_Surface *Icounter6;
SDL_Surface *Icounter7;
SDL_Surface *Icounter8;
SDL_Surface *Icounter9;
SDL_Surface *Icounterm;
SDL_Surface *Icounterclear;
SDL_Surface *Imenu;
SDL_Surface *Imenu_select;
SDL_Surface *Imenu_select_clear;
SDL_Surface *Imenu_newgame,*Imenu_options,*Imenu_quit,*Imenu_width,*Imenu_height,*Imenu_mines;
float minesprecents = 0.15; // max precentes of mines
int flagcounterx,flagcountery,smileyposx,smileyposy,timercounterx,timercountery;
int window_width, window_height;
int l_timer = 0;
int out;
int loadimgs = 1;

#include "boardinit.c"
#include "counters.c"
#include "gfx.c"
#include "gamestatus.c"
#include "uncover.c"
#include "menu.c"

main(int argc, char *argv[])
{
SDL_Event event;

int x,y,x2,y2,mx,my,i,j;


    if ( SDL_Init(SDL_INIT_VIDEO) < 0 ) {
        fprintf(stderr, "Unable to init SDL: %s\n", SDL_GetError());
        exit(1);
    }

// GAME TITLEBAR TEXT:
SDL_WM_SetCaption("TriMines","TriMines");

// LOAD ALL GAME IMAGES INTO VARS:
if (loadimgs == 1) {load_images();}

// ENABLE KEYPRESS REPEAT:
SDL_EnableKeyRepeat(SDL_DEFAULT_REPEAT_DELAY,SDL_DEFAULT_REPEAT_INTERVAL);

// START THE GAME MENU:
menu();

// SET WINDOW SIZE:
window_width = (boardx * 12) + 8;
window_height = (boardy*20) + 80;


timercounterx = window_width - 91;
timercountery = window_height - 48;
flagcounterx = 15;
flagcountery = window_height - 48;
smileyposy = window_height - 75;
smileyposx = (window_width / 2) - 40;


// START GAME:
screen = SDL_SetVideoMode(window_width,window_height , 24, SDL_SWSURFACE);
    if ( screen == NULL ) {
        fprintf(stderr, "Unable to set video: %s\n", SDL_GetError());
        exit(1);
    }


// DRAW BAR:
ShowBMP(Ibar, screen, 0,(boardy*20));
ShowBMP(Ibar2, screen, window_width - 112,(boardy*20));

// START A NEW GAME:
newgame();


x2 = -1;

while (out == 1) {
SDL_Delay(1);

// TIMER:
if (l_timer != 0 && gamestatus == 0 && ((SDL_GetTicks() - l_timer) / 1000) < 1000) {
		drawcounter((SDL_GetTicks() - l_timer) / 1000,timercounterx,timercountery);}
			
//while (SDL_WaitEvent(&event) != 0) {
if (SDL_PollEvent(&event)) {

	switch (event.type) {
	
	//  KEYBOARD:
	case SDL_KEYDOWN:

			switch (event.key.keysym.sym) {
			case SDLK_RIGHT:
					if (firstclick == 1 && mines < ((boardx * boardy) * minesprecents)-1) {
					mines++;
					flags = mines;
					drawcounter(flags,flagcounterx,flagcountery);
					}
					break;
			case SDLK_LEFT:
					if (firstclick == 1 && mines > 1) {
					mines--;
					flags = mines;
					drawcounter(flags,flagcounterx,flagcountery);
					}
					break;
			case SDLK_ESCAPE:
					SDL_ShowCursor(SDL_ENABLE); main(0,0);
					break;
			case SDLK_F1: if (firstclick == 0 && gamestatus == 0) {solve();}
					break;
			default:
					break;
			}
			
	break; // end case SDL_KEYDOWN		
			
	// MOUSE MOVEMENT:
	case SDL_MOUSEMOTION:
	SDL_GetMouseState(&mouse_x, &mouse_y);
	x = mouse_x / 12;
	y = mouse_y / 20;

	if ((mouse_y >=  smileyposy && mouse_y <= smileyposy+71) && (mouse_x >= smileyposx && mouse_x <= smileyposx+81)) {ShowBMP(Ismile4, screen, smileyposx,smileyposy);} else {

	switch (gamestatus) {
	case 0: ShowBMP(Ismile, screen, smileyposx,smileyposy); break;
	case 1: ShowBMP(Ismile3, screen, smileyposx,smileyposy); break;
	case 2: ShowBMP(Ismile2, screen, smileyposx,smileyposy); break;
	}

	}


	if ((x < boardx) && (y < boardy) && (gamestatus == 0)) {
		SDL_ShowCursor(SDL_DISABLE);
		if (x2 != -1){drawb(board[x2][y2], x2, y2);}
		drawb(16, x, y);
		x2 = x;
		y2 = y; 
		}
	
		else {
		if (x2 != -1){drawb(board[x2][y2], x2, y2);}
		SDL_ShowCursor(SDL_ENABLE);
		}



		break; // end case SDL_MOUSEMOTION

		// MOUSE CLICKS:

      case SDL_MOUSEBUTTONDOWN:
		SDL_GetMouseState(&mouse_x, &mouse_y);
		mx = mouse_x / 12;
		my = mouse_y / 20;
		
		

		if ((mx < boardx) && (my < boardy)) { // WHEN YOU CLICK ON THE BOARD:

		// CHECK IF THIS IS THE FIRST CLICK OR NOT FOR GENERATING MINES ONLY AFTER THE FIRST CLICK IS MADE.
		if ((firstclick == 1) && (event.button.button != SDL_BUTTON_MIDDLE) && (event.button.button != SDL_BUTTON_WHEELUP)
		&& (event.button.button != SDL_BUTTON_WHEELDOWN))
		{
		genrandmines(mx,my);
		// start the timer:
		l_timer = SDL_GetTicks();
		firstclick = 0;
		}

		switch (event.button.button) { // CHECK WHICH MOUSE KEY WAS PRESSED:

		case SDL_BUTTON_RIGHT: // RIGHT BUTTON:

		if (gamestatus == 0) {
		if (board2[mx][my] == 0 && flags != -999) {
					board2[mx][my] = 2;
					drawb(123, mx, my);
					flags = flags - 1; drawcounter(flags,flagcounterx,flagcountery);
					} else {
						if (board2[mx][my] == 2) {
							 		board2[mx][my] = 3;
							 		drawb(123, mx, my);
									flags = flags + 1; drawcounter(flags,flagcounterx,flagcountery);
									} else {
									if (board2[mx][my] == 3) {
												board2[mx][my] = 0;
												drawb(123, mx, my);}
															} }
		}
		break; // end case SDL_BUTTON_RIGHT

		case SDL_BUTTON_LEFT: // LEFT BUTTON:

		if (((board2[mx][my] == 0) || (board2[mx][my] == 3)) && (gamestatus == 0)){



		if (board[mx][my] == 14) {
		// GAME OVER!
		board2[mx][my] = 1;
		board[mx][my] = 13;
		drawb(board[mx][my], mx, my);
		gameover();
		} else {
			if (board[mx][my] == 0) {
				board2[mx][my] = 1;
				drawb(board[mx][my], mx, my);
				showarea(mx,my);
						} else {
							board2[mx][my] = 1;
							drawb(board[mx][my], mx, my);
											}}

		}

		break; // end case SDL_BUTTON_LEFT

		case SDL_BUTTON_MIDDLE: // MIDDLE BUTTON:

		if ((board[mx][my] == countsomething(mx,my,2,board2)) && (board[mx][my] >= 1 && board[mx][my] <= 12) && (board2[mx][my] == 1))
								{middleclick(mx,my);}



		break; // end case SDL_BUTTON_MIDDLE

		} // end switch


		if (gamestatus == 0){drawb(16, x, y);}
		
		} else { // WHEN YOU CLICK OUTSIDE THE BOARD:

		switch (event.button.button) {
		case SDL_BUTTON_WHEELUP: // WHEELUP BUTTON:
		if (firstclick == 1 && mines < ((boardx * boardy) * minesprecents)-1) {
		mines++;
		flags = mines;
		drawcounter(flags,flagcounterx,flagcountery);
		}
		break; // end case SDL_BUTTON_WHEELUP

		case SDL_BUTTON_WHEELDOWN: // WHEELDOWN BUTTON:
		if (firstclick == 1 && mines > 1) {
		mines--;
		flags = mines;
		drawcounter(flags,flagcounterx,flagcountery);
		}
		break; // end case SDL_BUTTON_WHEELDOWN

		// LEFT BUTTON (OUTSIDE THE BOARD):
		case SDL_BUTTON_LEFT: if ((mouse_y >=  smileyposy && mouse_y <= smileyposy+71) && (mouse_x >= smileyposx && mouse_x <= smileyposx+81)) {newgame();} break;
			}
		}
		
		// CHECK WINING:
		if (checkwining() == 1){won();}
		
		
		break; // end case SDL_MOUSEBUTTONDOWN
      
      case SDL_QUIT: SDL_ShowCursor(SDL_ENABLE); main(0,0);
      
        } // end switch (event.type)
  
  } }// end whiles

    atexit(SDL_Quit);

}
