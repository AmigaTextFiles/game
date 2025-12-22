/*Nathaniel Hirsch
 *nh2@njit.edu
 *
 *
 *
 *
 */
#include <stdlib.h>
#include <time.h>
#include <sys/stat.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>

extern int PutString();
extern int InitFont();

void end(SDL_Surface *screen, int master[2][4],Uint32 color[8])
{
	int i,cnt=0;
	SDL_Rect rct;
	for(i=115;i<=295;i+=60)
	{
		rct.x=i+1;
		rct.y=42;
		rct.w=39;
		rct.h=24;
		SDL_FillRect(screen, &rct, color[master[0][cnt]-1]);
		SDL_BlitSurface(screen, &rct , screen, &rct);
		SDL_UpdateRect(screen,0,0,0,0);
		cnt++;
	}
}
int chck(SDL_Surface *screen, int master[2][4],int guess[2][4],Uint32 cblock[8],int k)
{
	int i,j,rs,rc;
	SDL_Rect rct;
	rs=0;
	rc=0;
	for(i=0;i<=3;i++)
	{
		for(j=0;j<=3;j++)
		{
			if(guess[0][j]==master[0][j]&&master[1][j]!=1&&guess[1][j]!=1)
			{
				rs++;
				master[1][j]=1;
				guess[1][j]=1;
			}
			if(guess[0][j]==master[0][i]&&master[1][i]!=1&&guess[1][j]!=1&&j!=i)
			{
				rc++;
				master[1][i]=1;
				guess[1][j]=1;
			}
		}
	}
	rct.y=k+8;
	rct.h=4;
	rct.x=23;
	rct.w=4;
	if(rs==0)
	{
		PutString(screen,22,k+5,"X");
	}
	if(rs>=1)
	{
		SDL_FillRect(screen, &rct, cblock[0]);
	}
	if(rs>=2)
	{
		rct.x+=10;
		SDL_FillRect(screen, &rct, cblock[0]);
	}
	if(rs>=3)
	{
		rct.x-=10;
		rct.y+=10;
		SDL_FillRect(screen, &rct, cblock[0]);
	}
	if(rs==4)
	{
		rct.x+=10;
		SDL_FillRect(screen, &rct,cblock[0]);
		PutString(screen,360,40,"You WIN!!!");
		end(screen,master,cblock);
		return(1);
	}
	rct.x=63;
	if(rc==0)
	{
		PutString(screen,62,k+5,"X");
	}
	if(rc>=1)
	{
		SDL_FillRect(screen, &rct, cblock[1]);
	}
	if(rc>=2)
	{
		rct.x+=10;
		SDL_FillRect(screen, &rct, cblock[1]);
	}
	if(rc>=3)
	{
		rct.x-=10;
		rct.y+=10;
		SDL_FillRect(screen, &rct, cblock[1]);
	}
	if(rc==4)
	{
		rct.x+=10;
		SDL_FillRect(screen, &rct,cblock[1]);
	}
	SDL_BlitSurface(screen, &rct , screen, &rct);
	SDL_UpdateRect(screen,0,0,0,0);
	for(i=0;i<=3;i++)
	{
		guess[0][i]=0;
		guess[1][i]=0;
		master[1][i]=0;
	}
return(0);
}
int main()
{
	SDL_Surface *screen,*Font, *board;// whole screen
	SDL_Event event;	// sdl events
	SDL_Rect brdd, rct;
	Uint8 *keystate;
	Uint32 cblock[8];
	int master[2][4];	// code to break
	int guess[2][4];	// guesses for code
	int i,k;		// random counters
	int tries;		// tries left
	int rs;			// right color right spot
	int rc;			// just right color
	int x,y;		// mouse locations for x and y 
	int win=0;
	long seed[0];
	char * base = "/usr/local/share/games/naster/board.png";
	char * font = "/usr/local/share/games/naster/14P_Copperplate_Blue.png";
	int tmp=1;
	struct stat stbuf;
	
	if(stat(base, &stbuf)==-1||stat(font, &stbuf)==-1)
	{
		base="board.png\0";
		font="14P_Copperplate_Blue.png\0";
	}
	if( SDL_Init(SDL_INIT_VIDEO) < 0 ) 
	{
		fprintf(stderr, "Could not initialize SDL: %s\n",
		SDL_GetError());
		return -1;
	}
	atexit(SDL_Quit);
	screen = SDL_SetVideoMode(480, 480, 8, SDL_SWSURFACE|SDL_ANYFORMAT/*|SDL_FULLSCREEN*/);
	if( !screen ) 
	{
		fprintf(stderr, "Couldn't create a surface: %s\n",
		SDL_GetError());
		return -1;
	}
	cblock[0] = SDL_MapRGB( screen->format, 0, 0, 0 ); 	// black
	cblock[1] = SDL_MapRGB( screen->format, 255, 255, 255 );// white
	cblock[2] = SDL_MapRGB( screen->format, 255, 0, 0 );	// red
	cblock[3] = SDL_MapRGB( screen->format, 0, 255, 0 );	// green
	cblock[4] = SDL_MapRGB( screen->format, 255, 255, 0 );	// yellow
	cblock[5] = SDL_MapRGB( screen->format, 0, 0, 255 );	// blue
	cblock[6] = SDL_MapRGB( screen->format, 0, 255, 255 );	// aqua
	cblock[7] = SDL_MapRGB( screen->format, 255, 0, 255 );	// magenta

	Font=IMG_Load(font);
	if(Font==NULL)
	{
		printf("font didnt load: %s",SDL_GetError());
		return -1;
	}
	InitFont(Font);
	SDL_WM_SetCaption("Naster Mind", "Naster Mind");
start:
	time(seed);
	srand(*seed);
	k=screen->w;
	board=IMG_Load(base);
	if(board==NULL)
	{
		printf("Board didnt load: %s\n",SDL_GetError());
		return -1;
	}
	brdd.x=0;
	brdd.y=0;
	brdd.w=screen->w;
	brdd.h=screen->h;
	for(i=0;i<=255;i+=15)
	{
		SDL_SetAlpha(board, SDL_SRCALPHA,i);
		SDL_BlitSurface(board , &brdd , screen , &brdd);
		SDL_UpdateRect(screen ,  0, 0 , 0 , 0 );
	}
	SDL_FreeSurface(board);
	tries=10;
	tmp=1;
	rs=rc=win=0;
	for(i=0;i<=3;i++)
	{
		master[0][i]=1+(int) (8.0*rand()/(RAND_MAX+1.0));
		guess[0][i]=0;
		guess[1][i]=0;
		master[1][i]=0;
	}

	while ( SDL_WaitEvent(&event) >= 0 ) 
	{
		switch (event.type)
		{
	        	case SDL_ACTIVEEVENT: 
			{
        	        	if ( event.active.state & SDL_APPACTIVE ) 
				{
	                		if ( event.active.gain ) 
					{
		                    		printf("App activated\n");
				        } 
					else 
					{
                	        		printf("App iconified\n");
		        	        }
        	        	}
		        }
        		break;
		        case SDL_MOUSEBUTTONDOWN: 
			{
        			SDL_GetMouseState(&x,&y);
				if(x>=360&&x<=470&&y>=110&&y<=150)
				{
					goto start;
				}
				if( x>=360&&x<=470&&y>=210&&y<=250&&guess[0][0]!=0&&guess[0][1]!=0&&guess[0][2]!=0&&guess[0][3]!=0&&win!=1)
				{
					tries--;
					win=chck(screen,master,guess,cblock,i);
					if(tries==0&&win!=1)
					{
						end(screen,master,cblock);
						PutString(screen,360,40,"You Lose!");
					}
	
				}
				rct.x=361;
				rct.y=437;
				rct.w=109;
				rct.h=24;
				if( x>=360 && x<=410 && y>=300 && y<=325 && win!=1) // Black 1
				{
					tmp=1;
				}
				if( x>=420 && x<=470 && y>=300 && y<=325 && win !=1) //white 2
				{
					tmp=2;
				}
				if( x>=360 && x<=410 && y>=330 && y<=355&& win!=1) // red3
				{
					tmp=3;
				}
				if( x>=420 && x<=470 && y>=330 && y<=355&& win!=1) // green 4
				{
					tmp=4;
				}
				if( x>=360 && x<=410 && y>=360 && y<=385&& win!=1) // yellow 5
				{
					tmp=5;
				}
				if( x>=420 && x<=470 && y>=360 && y<=385&& win!=1) // blue 6
				{
					tmp=6;
				}
				if( x>=360 && x<=410 && y>=390 && y<=415&& win!=1) // aqua 7
				{
					tmp=7;
				}
				if( x>=420 && x<=470 && y>=390 && y<=415&& win!=1) // magenta 8
				{
					tmp=8;
				}
				i=60+(36*tries);
				if(x>115&&x<155&&y>i&&y<i+30&& win!=1)
				{
					guess[0][0]=tmp;
					rct.x=116;
					rct.y=i+1;
					rct.w=39;
					rct.h=29;
				}
				if(x>175&&x<215&&y>i&&y<i+30&& win!=1)
				{
					guess[0][1]=tmp;		
					rct.x=176;
					rct.y=i+1;
					rct.w=39;
					rct.h=29;
				}
				if(x>235&&x<275&&y>i&&y<i+30&& win!=1)
				{
					guess[0][2]=tmp;
					rct.x=236;
					rct.y=i+1;
					rct.w=39;
					rct.h=29;
				}
				if(x>295&&x<335&&y>i&&y<i+30&& win!=1)
				{
					guess[0][3]=tmp;
					rct.x=296;
					rct.y=i+1;
					rct.w=39;
					rct.h=29;
				}
				SDL_FillRect(screen, &rct, cblock[tmp-1]);
				SDL_BlitSurface(screen, &rct , screen, &rct);
				SDL_UpdateRect(screen,0,0,0,0);
		        }
		        break;
			case SDL_KEYDOWN:
			{
				keystate = SDL_GetKeyState(NULL);
				i=60+(36*tries);
				if(keystate[SDLK_n])
				{
					goto start;
				}
				rct.x=361;
				rct.y=437;
				rct.w=109;
				rct.h=24;
				if(keystate[SDLK_a]&&win!=1)
				{
					tmp=1;
				}
				if(keystate[SDLK_z]&&win!=1)
				{
					tmp=2;
				}
				if(keystate[SDLK_s]&&win!=1)
				{
					tmp=3;
				}
				if(keystate[SDLK_x]&&win!=1)
				{
					tmp=4;
				}
				if(keystate[SDLK_d]&&win!=1)
				{
					tmp=5;
				}
				if(keystate[SDLK_c]&&win!=1)
				{
					tmp=6;
				}
				if(keystate[SDLK_f]&&win!=1)
				{
					tmp=7;
				}
				if(keystate[SDLK_v]&&win!=1)	
				{
					tmp=8;
				}
				if(keystate[SDLK_1]&&win!=1)
				{
					guess[0][0]=tmp;
					rct.x=116;
					rct.y=i+1;
					rct.w=39;
					rct.h=29;
				}
				if(keystate[SDLK_2]&&win!=1)
				{
					guess[0][1]=tmp;
					rct.x=176;
					rct.y=i+1;
					rct.w=39;
					rct.h=29;
				}
				if(keystate[SDLK_3]&&win!=1)
				{
					guess[0][2]=tmp;
					rct.x=236;
					rct.y=i+1;
					rct.w=39;
					rct.h=29;
				}
				if(keystate[SDLK_4]&&win!=1)
				{
					guess[0][3]=tmp;
					rct.x=296;
					rct.y=i+1;
					rct.w=39;
					rct.h=29;
				}
				SDL_FillRect(screen, &rct, cblock[tmp-1]);
				SDL_BlitSurface(screen, &rct , screen, &rct);
				SDL_UpdateRect(screen,0,0,0,0);
				if(keystate[SDLK_RETURN]&&win!=1&&guess[0][0]!=0&&guess[0][1]!=0&&guess[0][2]!=0&&guess[0][3]!=0)
				{
					tries--;
					win=chck(screen,master,guess,cblock,i);
					if(tries==0&&win!=1)
					{
						end(screen,master,cblock);
						PutString(screen,360,40,"You Lose!");
					}


				}
				if(keystate[SDLK_ESCAPE])
				{
					SDL_FreeSurface(Font);
					SDL_FreeSurface(screen);
					return(0);
				}
			}
			case SDL_MOUSEMOTION:
			{
				SDL_GetMouseState(&x,&y);
//				printf("%d\t%d\n",x,y);
				rct.x=361;
				rct.y=212;
				rct.w=108;
				rct.h=38;
				if(x>360&&x<470&&y>210&&y<250&&win!=1)
				{
					SDL_FillRect(screen, &rct, SDL_MapRGB( screen->format, 240, 240, 240 ));
				}
				else
				{
					SDL_FillRect(screen, &rct, SDL_MapRGB( screen->format, 200, 200, 200 ));
				}
				rct.y=112;
				if(x>360&&x<470&&y>110&&y<150)
				{
					SDL_FillRect(screen, &rct, SDL_MapRGB( screen->format, 240, 240, 240 ));
				}
				else
				{
					SDL_FillRect(screen, &rct, SDL_MapRGB( screen->format, 200, 200, 200 ));
				}
				PutString(screen,380,112,"New");
				PutString(screen,380,132,"Game");
				PutString(screen,380,212,"Make");
				PutString(screen,380,232,"Guess");
				SDL_UpdateRect(screen,360,110,120,200);
			}
			break;
			case SDL_QUIT: 
			{
        			printf("Quit requested, quitting.\n");
			        exit(0);
		        }
		        break;
	        }
	}
	printf("SDL_WaitEvent error: %s\n", SDL_GetError());
	exit(1);
return(0);
}
