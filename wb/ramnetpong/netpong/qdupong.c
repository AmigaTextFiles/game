#include <stdio.h>
#include <SDL.h>

#define TRUE	1	
#define FALSE 	0	
//#define PADDLE_SPEED	10
//#define BALL_SPEED	6
#define PADDLE_SPEED	1
#define BALL_SPEED	    1

//#define TICKS_PER_FRAME (1000/75)   /* ~75 FPS */
#define TICKS_PER_FRAME 0

#define NOHITYET	0
#define EDGE1		1
#define EDGE2		2
#define	PADDLE1		3
#define PADDLE2		4
#define NONE		100

int player1_digit1 = 0;
int player1_digit2 = 0; 

int player2_digit1 = 0;
int player2_digit2 = 0;

SDL_Surface *screen, *image;
SDL_Rect dest;

SDL_Event event;
Uint8 *keys;

void init_video()
{
    if ( SDL_Init(SDL_INIT_VIDEO) < 0 ) {
		printf("Unable to init SDL: %s\n", SDL_GetError());
		exit(1);
	}
	atexit(SDL_Quit);
		 
	screen = SDL_SetVideoMode(640,480,16,SDL_HWSURFACE|SDL_DOUBLEBUF);
	if ( screen == NULL ) {
		printf("Unable to set 640x480 video: %s\n", SDL_GetError());
		exit(1);
	}                                                                                                                                         
}

void sdl_logo()
{
	 SDL_FillRect(screen,0,SDL_MapRGB(screen->format,0,0,0));
	 image = SDL_LoadBMP("graphics/intro.dat");
	 if ( image == NULL ) {
	 	printf("Couldn't load intro screen: %s", SDL_GetError());
	 	exit(1);
	 }        
	
	 dest.x = (screen->w - image->w)/2;
	 dest.y = (screen->h - image->h)/2;
	 dest.w = image->w;
	 dest.h = image->h;
	 SDL_BlitSurface(image, NULL, screen, &dest);
	 SDL_Flip(screen);                           	   
}

int collide (SDL_Surface *sprite1, SDL_Surface *sprite2, SDL_Rect dest1, SDL_Rect dest2) {
	if ( (dest1.y >= (dest2.y + sprite2->h)) ||
	     (dest1.x >= (dest2.x + sprite2->w)) ||
	     (dest2.y >= (dest1.y + sprite1->h)) ||
	     (dest2.x >= (dest1.x + sprite1->w)) ) {    	  
		return(FALSE);
	}
	return(TRUE);	
}	
	
void show_scores() {
	SDL_Rect box;

	SDL_Surface	*player1_digit1_font,
				*player1_digit2_font,
				*player2_digit1_font,
				*player2_digit2_font,
				*player1_logo,
				*player2_logo,
				*continue_logo;

	char player1_digit1_digit[8],
		 player1_digit2_digit[8],
		 player2_digit1_digit[8],
		 player2_digit2_digit[8];

	box.w = 400;
	box.h = 350;
	box.x = (screen->w - box.w)/2;
	box.y = (screen->h - box.h)/2;
	SDL_FillRect(screen, &box, SDL_MapRGB(screen->format,85,150,69));

	box.w = 350;
	box.h = 275;
    box.x = box.x + 25; 
	box.y = box.y + 50;
	SDL_FillRect(screen, &box, SDL_MapRGB(screen->format,255,255,255));

	sprintf(player1_digit1_digit, "font/%d", player1_digit1);
	sprintf(player1_digit2_digit, "font/%d", player1_digit2);
	sprintf(player2_digit1_digit, "font/%d", player2_digit1);
	sprintf(player2_digit2_digit, "font/%d", player2_digit2);

	player1_digit1_font = SDL_LoadBMP(player1_digit1_digit);
	player1_digit2_font = SDL_LoadBMP(player1_digit2_digit);
	player2_digit1_font = SDL_LoadBMP(player2_digit1_digit);
	player2_digit2_font = SDL_LoadBMP(player2_digit2_digit);
	player1_logo = SDL_LoadBMP("font/p1");
	player2_logo = SDL_LoadBMP("font/p2");
	continue_logo = SDL_LoadBMP("font/cont");
	if ( player1_digit1_font == NULL || player1_digit2_font == NULL || 
		 player2_digit1_font == NULL || player2_digit2_font == NULL ||
		 player1_logo == NULL || player2_logo == NULL ||
		 continue_logo == NULL) {
		printf("Couldn't load font data: %s", SDL_GetError());
		exit(1);
	}

	// Display Player 1
	box.w = player1_logo->w;
	box.h = player1_logo->h;
	box.x = (screen->w - box.w)/2 - 75;
	box.y = (screen->h - box.h)/2 - 75;
	SDL_BlitSurface(player1_logo, NULL, screen, &box);

	// Display Player 2
	box.w = player2_logo->w;
	box.h = player2_logo->h;
	box.x = (screen->w - box.w)/2 - 75;
	box.y = (screen->h - box.h)/2 + 25;
	SDL_BlitSurface(player2_logo, NULL, screen, &box);

	// Display Continue Logo
	box.w = continue_logo->w;
	box.h = continue_logo->h;
	box.x = (screen->w - box.w)/2;
	box.y = (screen->w - box.h)/2 + 50;
	SDL_BlitSurface(continue_logo, NULL, screen, &box);

	// Display Player 1 Digit 1
	box.w = 30;
	box.h = 30;
	box.x = (screen->w - box.w)/2 + 100;
    box.y = (screen->h - box.h)/2 - 75;
	SDL_BlitSurface(player1_digit1_font, NULL, screen, &box);

	// Display Player 1 Digit 2
	box.w = 30;
	box.h = 30;
	box.x = (screen->w - box.w)/2 + 125;
    box.y = (screen->h - box.h)/2 - 75;
	SDL_BlitSurface(player1_digit2_font, NULL, screen, &box);

	// Display Player 2 Digit 1
	box.w = 30;
	box.h = 30;
	box.x = (screen->w - box.w)/2 + 100;
    box.y = (screen->h - box.h)/2 + 25;
	SDL_BlitSurface(player2_digit1_font, NULL, screen, &box);
	
	// Display Player 2 Digit 2
	box.w = 30;
	box.h = 30;
	box.x = (screen->w - box.w)/2 + 125;
    box.y = (screen->h - box.h)/2 + 25;
	SDL_BlitSurface(player2_digit2_font, NULL, screen, &box);
	
	SDL_Flip(screen);
	
	do {
		while ( SDL_PollEvent(&event) ) { };
		keys = SDL_GetKeyState(NULL);
	} while ( keys[SDLK_SPACE] != SDL_PRESSED );
}		

int main (int argc, char *argv[])
{
	SDL_Surface *edge1, *edge2, 
				*paddle1, *paddle2,
				*title, *ball;
	SDL_Rect	edge1_dest, edge2_dest,
				paddle1_dest, paddle2_dest,
				title_src, title_dest,
                ball_dest, overlaprect;

    int paddle1_y, paddle2_y;
    int ball_x, ball_y, ball_dx, ball_dy;
    int nrects;
    SDL_Rect rects[8];
    Uint32 next_frame;
		
	int game = FALSE;
	int exit_pong = FALSE;
	int ball_status = 0;
	
	int BALL_STARTX =	BALL_SPEED;
    int BALL_STARTY =	BALL_SPEED;	

	/* Initalize the video */
	init_video();

	/* Setup the title bar */
	SDL_WM_SetCaption("Qdu netPONG",NULL);

	/* Display SDL Logo and wait 3 secs */
	sdl_logo();
	SDL_Delay(3000);
	SDL_FillRect(screen,0,SDL_MapRGB(screen->format,0,0,0));

	/* Load all the graphics and give errors if any */
	title = SDL_LoadBMP("graphics/title.dat");
	if ( title == NULL ) {
		printf("Couldn't load title screen: %s", SDL_GetError());
		exit(1);
	}
	
	edge1 = SDL_LoadBMP("graphics/edge.dat");
	edge2 = SDL_LoadBMP("graphics/edge.dat");
	if ( edge1 == NULL || edge2 == NULL ) {
		printf("Couldn't load edge data: %s", SDL_GetError());
		exit(1);
	}

	paddle1 = SDL_LoadBMP("graphics/paddle.dat");
	paddle2 = SDL_LoadBMP("graphics/paddle.dat");
	if (paddle1 == NULL || paddle2 == NULL) {
		printf("Couldn't load paddle data: %s", SDL_GetError());
		exit(1);
	}

	ball = SDL_LoadBMP("graphics/ball.dat");
	if (ball == NULL) {
		printf("Couldn't load ball data: %s", SDL_GetError());
		exit(1);
	}
	SDL_SetColorKey(ball, (SDL_SRCCOLORKEY|SDL_RLEACCEL), *(Uint8 *)ball->pixels);

	/* Go into main loop */
next_frame = 0;
while ( exit_pong == FALSE ) {	

    /* Hold down the framerate, or the game is way too fast */
    do {
	    SDL_PollEvent(&event);
    } while ( SDL_GetTicks() < next_frame );

    next_frame = SDL_GetTicks() + TICKS_PER_FRAME;

	keys = SDL_GetKeyState(NULL);
	if ( keys[SDLK_ESCAPE] == SDL_PRESSED ) {
		exit_pong = TRUE;
	}

	if (game == FALSE) {
		/* Setup title screen */
		title_dest.w = title->w;
		title_dest.h = title->h;
		title_dest.x = (screen->w/2) - (title->w/2);
		title_dest.y = (screen->h/2) - (title->h/2);
		SDL_BlitSurface(title, NULL, screen, &title_dest);
		
		edge1_dest.w = edge1->w;
		edge1_dest.h = edge1->h;
		edge1_dest.x = 0;
		edge1_dest.y = 0;
		SDL_BlitSurface(edge1, NULL, screen, &edge1_dest);
	
		edge2_dest.w = edge2->w;
		edge2_dest.h = edge2->h;
		edge2_dest.x = 0;
		edge2_dest.y = screen->h - edge2->h;
		SDL_BlitSurface(edge2, NULL, screen, &edge2_dest);
		
		paddle1_dest.w = paddle1->w;
		paddle1_dest.h = paddle1->h;
		paddle1_dest.x = 5;
		paddle1_dest.y = (screen->h/2) - (paddle1->h/2); 		
		SDL_BlitSurface(paddle1, NULL, screen, &paddle1_dest);
		
		paddle2_dest.w = paddle2->w;
		paddle2_dest.h = paddle2->h;
		paddle2_dest.x = (screen->w - paddle2->w) - 5;
		paddle2_dest.y = (screen->h/2) - (paddle2->h/2); 		
		SDL_BlitSurface(paddle2, NULL, screen, &paddle2_dest);
		
		ball_dest.w = ball->w;
		ball_dest.h = ball->h;
		ball_dest.x = (screen->w/2) - (ball->w/2);
		ball_dest.y = (screen->h/2) - (ball->h/2);
		SDL_BlitSurface(ball, NULL, screen, &ball_dest);
		
		SDL_UpdateRect(screen, 0, 0, 0, 0);
		
		if ( keys[SDLK_RETURN] ) {
			game = TRUE;
		}
	} else if (game == TRUE) {

			/* Check for key presses */
			paddle1_y = paddle1_dest.y;
			if ( keys[SDLK_r] == SDL_PRESSED ) { 
				paddle1_y -= PADDLE_SPEED;
			}
		 	
			if ( keys[SDLK_f] == SDL_PRESSED ) {
				paddle1_y += PADDLE_SPEED;
			}

			paddle2_y = paddle2_dest.y;
			if ( keys[SDLK_UP] == SDL_PRESSED ) {
				paddle2_y -= PADDLE_SPEED;
			}
			
			if ( keys[SDLK_DOWN] == SDL_PRESSED ) {
				paddle2_y += PADDLE_SPEED;
			}

			/* Move the ball */
			if (ball_status == EDGE2) {
				BALL_STARTY = -(BALL_STARTY); 	
				ball_status = NONE;
			}

			if (ball_status == EDGE1) {
				BALL_STARTY = -(BALL_STARTY);
				ball_status = NONE;
			}

			if (ball_status == PADDLE2) {
				BALL_STARTX = -(BALL_STARTX);
				ball_status = NONE;
			}

			if (ball_status == PADDLE1) {
				BALL_STARTX = -(BALL_STARTX);
				ball_status = NONE;
			}
			
			ball_x = ball_dest.x + BALL_STARTX;
			ball_y = ball_dest.y + BALL_STARTY;

			/* Check for any collides */
			if ( collide(paddle1, edge1, paddle1_dest, edge1_dest) == TRUE) {
				paddle1_y = edge1_dest.y + edge1->h;
			}
			
			if ( collide(paddle1, edge2, paddle1_dest, edge2_dest) == TRUE) {
				paddle1_y = edge2_dest.y - paddle1->h;
			}

			if ( collide(paddle2, edge1, paddle2_dest, edge1_dest) == TRUE) {
				paddle2_y = edge1_dest.y + edge1->h;
			}

			if ( collide(paddle2, edge2, paddle2_dest, edge2_dest) == TRUE) {
				paddle2_y = edge2_dest.y - paddle2->h;
			}

			if ( collide(ball, edge2, ball_dest, edge2_dest) == TRUE) {
				ball_y = edge2_dest.y - ball->h;
				ball_status = EDGE2;
			}

			if ( collide(ball, edge1, ball_dest, edge1_dest) == TRUE) {
				ball_y = edge1->h;
				ball_status = EDGE1;
			}

			if ( collide(ball, paddle2, ball_dest, paddle2_dest) == TRUE) {
				ball_x = paddle2_dest.x - ball->w;
				ball_status = PADDLE2;
			}

			if ( collide(ball, paddle1, ball_dest, paddle1_dest) == TRUE) {
				ball_x = paddle1->w + 5;
				ball_status = PADDLE1;
			}

			/* Check to see if player scored */
			if ( ball_dest.x <= 0 ) {
				game = FALSE;
	
				if (player2_digit2 == 9) {
						player2_digit1++;
						player2_digit2 = 0;
				} else {
						player2_digit2 = player2_digit2 + 1;
				}

				show_scores();
	 			SDL_FillRect(screen,0,SDL_MapRGB(screen->format,0,0,0));
			}
			
			if ( ball_dest.x >= (screen->w - ball->w) ) {
				game = FALSE;
				
				if (player1_digit2 == 9) {
						player1_digit1++;
						player1_digit2 = 0;
				} else {
						player1_digit2 = player1_digit2 + 1;
				}

				show_scores();
				SDL_FillRect(screen,0,SDL_MapRGB(screen->format,0,0,0));
			}

			/* Blit it to the screen and update if the game is true */
			if ( game == TRUE ) {
                nrects = 0;

                /* Show area behind ball */
                SDL_FillRect(screen, &ball_dest, 0);
                title_src.x = ball_dest.x - title_dest.x;
                title_src.y = ball_dest.y - title_dest.y;
                title_src.w = ball_dest.w;
                title_src.h = ball_dest.h;
                overlaprect = ball_dest;
				SDL_BlitSurface(title, &title_src, screen, &overlaprect);

                /* Move the paddle (1) */
                if ( paddle1_y != paddle1_dest.y ) {
                    SDL_FillRect(screen, &paddle1_dest, 0);
                    rects[nrects++] = paddle1_dest;
                    paddle1_dest.y = paddle1_y;
                }
				SDL_BlitSurface(paddle1, NULL, screen, &paddle1_dest);
                rects[nrects++] = paddle1_dest;

                /* Move the paddle (2) */
                if ( paddle2_y != paddle2_dest.y ) {
                    SDL_FillRect(screen, &paddle2_dest, 0);
                    rects[nrects++] = paddle2_dest;
                    paddle2_dest.y = paddle2_y;
                }
				SDL_BlitSurface(paddle2, NULL, screen, &paddle2_dest);
                rects[nrects++] = paddle2_dest;

                /* Fill in the edges */
		        SDL_BlitSurface(edge1, NULL, screen, &edge1_dest);
                rects[nrects++] = edge1_dest;
		        SDL_BlitSurface(edge2, NULL, screen, &edge2_dest);
                rects[nrects++] = edge2_dest;

                /* Show the ball */
                ball_dx = ball_x - ball_dest.x;
                ball_dy = ball_y - ball_dest.y;
                ball_dest.x = ball_x;
                ball_dest.y = ball_y;
				SDL_BlitSurface(ball, NULL, screen, &ball_dest);
                rects[nrects] = ball_dest;

                /* Catch erased ball area in a single update */
                if ( ball_dx < 0 ) {
                    rects[nrects].w -= ball_dx;
                } else {
                    rects[nrects].x -= ball_dx;
                    rects[nrects].w += ball_dx;
                }
                if ( ball_dy < 0 ) {
                    rects[nrects].h -= ball_dy;
                } else {
                    rects[nrects].y -= ball_dy;
                    rects[nrects].h += ball_dy;
                }
                ++nrects;

                SDL_UpdateRects(screen, nrects, rects);
			}
	}
}
	return(0);
}
