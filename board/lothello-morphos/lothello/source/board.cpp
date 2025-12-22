#include "board.h"
#include "defs.h"

board::board()
{
   int x,y;
	char tmp[25];
   
   /* Load Images */
   boardImage = IMG_Load("data/game/tabuleiro.png");
   flipImage = IMG_Load("data/game/flip.png");
 
	/* Load animation images */
	for(x=0; x<10; x++)
	{
	   sprintf(tmp, "data/bolinha/%d.png", x+1);
		pieces[x] = IMG_Load(tmp);
	}	

   /* Init Board */
   for(x=0; x<8; x++)
   {
      for(y=0;y<8;y++)
      {
         grid[x][y] = NOBODY;
      }
   }
   grid[3][3] = GREEN_PLAYER;
   grid[4][4] = GREEN_PLAYER;
   grid[4][3] = RED_PLAYER;
   grid[3][4] = RED_PLAYER;
}

board::board(board& initialBoard)
{
   int x,y,i;
   boardImage = NULL;
   flipImage = NULL;
	
   for(x=0; x<8; x++)
   {
      for(y=0; y<8; y++)
      {
         grid[x][y] = initialBoard.getOwner(x,y);
      }
   }
	for(i=0; i<10; i++)
	{
		pieces[i] = NULL;
	}
}

board::~board()
{
	int i;
   if(boardImage)
      SDL_FreeSurface(boardImage);
   if(flipImage)
      SDL_FreeSurface(flipImage);
   //if(redPiece)
   //   SDL_FreeSurface(redPiece);
	for(i=0; i<10; i++)
	{
		if(pieces[i])
		{
			SDL_FreeSurface(pieces[i]);
		}	
	}
}

int board::getOwner(int x, int y)
{
   if( (x >= 0) && (x <= 8) && (y >= 0) && (y <= 8))
      return(grid[x][y]);
   else
      return(NOBODY);
}

void board::setOwner(int x, int y, int player)
{
   if( (x >= 0) && (x <= 8) && (y >= 0) && (y <= 8))
      grid[x][y] = player;
}

void board::draw(SDL_Surface* screen)
{
   SDL_Rect ret;
   int x,y;

   /* Draw Board Grid */
   SDL_BlitSurface(boardImage,NULL,screen,NULL);
   
   /* Draw Pieces */
   for(x=0; x<8; x++)
   {
      for(y=0; y<8; y++)
      {
         if(grid[x][y] == RED_PLAYER) 
         {
            ret.x = 41 + x*40;
            ret.y = 41 + y*40;
            SDL_BlitSurface(pieces[0], NULL, screen, &ret);
         }
         else if(grid[x][y] == GREEN_PLAYER)
         {
            ret.x = 41 + x*40;
            ret.y = 41 + y*40;
            SDL_BlitSurface(pieces[9], NULL, screen, &ret);
         }
      }
   }
}

void board::calculateTotals()
{
   int x,y;
   totalRed = 0;
   totalGreen = 0;
   for(x=0;x<8;x++)
   {
      for(y=0;y<8;y++)
      {
         if(grid[x][y] == RED_PLAYER)
         {
            totalRed++;
         }
         else if(grid[x][y] == GREEN_PLAYER)
         {
            totalGreen++;
         }
      }
   }
}

int board::getTotalRed()
{
   return(totalRed);
}

int board::getTotalGreen()
{
   return(totalGreen);
}

bool board::isValid(int x, int y)
{
   if((x >= 0) && (x <= 7) && (y >= 0) && (y <= 7))
   {
      return(true);
   }
   else 
   {
      return(false);
   }
}	

void board::gridBackup()
{
	int x, y;
	for(x=0; x<8; x++)
	{
		for(y=0; y<8; y++)
		{
			prevGrid[x][y] = grid[x][y];
		}
	}
}

void board::drawAnimation(SDL_Surface* screen)
{
   SDL_Rect ret;
   int x,y,anim;

   /* Draw Board Grid */
   SDL_BlitSurface(boardImage,NULL,screen,NULL);
	ret.x = 5;
	ret.y = 10;
	SDL_BlitSurface(flipImage, NULL, screen, &ret);
   
	for(anim=0; anim<10; anim++)
	{
	   /* Draw Pieces */
   	for(x=0; x<8; x++)
	   {
   	   for(y=0; y<8; y++)
      	{
            ret.x = 41 + x*40;
  	         ret.y = 41 + y*40;
	         if((grid[x][y] == RED_PLAYER) && 
				   ((prevGrid[x][y] == RED_PLAYER) ||
					 (prevGrid[x][y] == NOBODY))) 
   	      {
	            SDL_BlitSurface(pieces[0], NULL, screen, &ret);
   	      }
      	   else if((grid[x][y] == GREEN_PLAYER) && 
				        ((prevGrid[x][y] == GREEN_PLAYER) ||
						   (prevGrid[x][y] == NOBODY)))
         	{
      	      SDL_BlitSurface(pieces[9], NULL, screen, &ret);
         	}
				else if((grid[x][y] == RED_PLAYER) && 
				        (prevGrid[x][y] == GREEN_PLAYER))
				{
					SDL_BlitSurface(pieces[9-anim], NULL, screen, &ret);
				}
				else if((grid[x][y] == GREEN_PLAYER) && 
				        (prevGrid[x][y] == RED_PLAYER))
				{
					SDL_BlitSurface(pieces[anim], NULL, screen, &ret);
				}		
			}
		}
		SDL_Flip(screen);
		SDL_Delay(40);
	}
}

	
