
/*********************************************************************
 *
 *
 *         PEGS
 * 
 *  Code by: Eric Johansson    
 *           Fredrik Stridh
 *
 *           Created:     05 03 31
 *           Last update: 05 10 17
 *
 ********************************************************************/


#include "SDL.h"
#include "SDL_mixer.h"

#include "map.h"
#include "tileset.h"
#include "sprite.h"
#include <iostream>
#include <fstream>

using namespace std;

//Sounds

Mix_Music *Pegs;          // musik
Mix_Chunk *push;          //ljudeffekt
Mix_Chunk *restart_level; //ljudeffekter
Mix_Chunk *colli;         //ljudeffekter
Mix_Chunk *next;          //ljudeffekter
Mix_Chunk *rot;           //ljudeffekter

// Gfx

SDL_Surface *screen;  
SDL_Surface *tiles;

//   Variabler   

int done = 0;     
int tileSelected = 0;  
unsigned int level = 1;

// Objekt

map map1(100,30);
tileset tileset1(32, 32, 8);

// Funktions Prototyper

void controll_SDL();
void game_loop();
int check_input();
void blit_image(SDL_Surface *img, int x, int y);
void blit_image(SDL_Surface *img, int x1, int y1, int w, int h, int x2, int y2);
void draw_tile(int x, int y, int tile);
void draw_map();
void draw_tilescreen();
void load_BMP();
void load_sounds();
void window_text(); 
void load_map(int number);
void player_controll(); 
void collisions(); 
void check_down(); 
void check_up();
void check_right();
void check_left();
void move_block_down(unsigned int tilenr);
void move_block_up(unsigned int tilenr); 
void move_block_right(unsigned int tilenr); 
void move_block_left(unsigned int tilenr); 
int check_tile_select_input(); 
void restart();
void select_tile(int posX, int posY);
void level_completed();
void play_pegs_song(); 

/******************************************************************************
*
*	Main        
*
******************************************************************************/


int main(int argc, char *argv[] )
{ 
    controll_SDL(); 
    window_text();
    load_BMP();
    load_sounds();
    load_map(level);
    game_loop();
  
return 0;
}

/******************************************************************************
*
*	Game Loop
*
******************************************************************************/
  

void game_loop()
{
  done = 0;
  Uint32 black = 0;

  while( ! done)
  {
      play_pegs_song();
      done = check_input();  // Returnera 1 ifall programmet ska avslutas
      draw_map();
      player_controll();
      SDL_Flip(screen);  // double buf, swappar skärmar
      level_completed();
  }
}
/******************************************************************************
*
*       Check Input
*
******************************************************************************/
int check_input()
{
  int done = 0;
  Uint8* keys;
  
  SDL_Event event;
  keys = SDL_GetKeyState(NULL);
             
  while(SDL_PollEvent(&event))
  {
  //flyttar på player efter önskemål
              if ( keys[SDLK_UP] ) { player.y -= 32 ; check_up(); return done; }
			  if ( keys[SDLK_DOWN] ) { player.y += 32; check_down(); return done;}
              if ( keys[SDLK_RIGHT] ) { player.x += 32; check_right(); return done;}
              if ( keys[SDLK_LEFT] ) { player.x -= 32; check_left();return done;}
              if ( keys[SDLK_r] ) { restart();}
      
      if (event.type == SDL_QUIT)
      done = 1;

      if (event.type == SDL_KEYDOWN)
    {
       if (event.key.keysym.sym == SDLK_ESCAPE)
       {
          done = 1;
       }
    }
  }
  return done;
}

/******************************************************************************
*
* 	Blit Image  
*
******************************************************************************/
void blit_image(SDL_Surface *img, int x, int y)
{
  SDL_Rect dest;
  dest.x = x;
  dest.y = y;
		
  SDL_BlitSurface(img,NULL,screen,&dest);
}

void blit_image(SDL_Surface *img, int x1, int y1, int w, int h, int x2, int y2)
{
  SDL_Rect source;
  source.x = x1;
  source.y = y1;
  source.w = w;
  source.h = h;

  SDL_Rect dest;
  dest.x = x2;
  dest.y = y2;
			
  SDL_BlitSurface(img, &source, screen, &dest);
}

/******************************************************************************
*
*	Draw Tile  
*
*******************************************************************************/
void draw_tile(int x, int y, int tile)
{
  int tile_offset_x = tileset1.tile_widht  * (tile % (tileset1.tile_file_widht / tileset1.tile_widht));  
  int tile_offset_y = tileset1.tile_height * (tile / (tileset1.tile_file_widht / tileset1.tile_widht));
  
  blit_image(tiles, tile_offset_x , tile_offset_y, tileset1.tile_widht, tileset1.tile_height, x, y);
}


/******************************************************************************
*
*	Draw Map  
*
*******************************************************************************/
void draw_map()
{
   for (int y = 0; y < 10; y++)
   {
      for (int x = 0; x < 14; x++)
	  {
       	  draw_tile(x * tileset1.tile_widht, (y * tileset1.tile_height), map1.get_tilenr(x, y));
      }  
   }     
}

/******************************************************************************
*
*	PLAYER CONTROLL!! 
*
*******************************************************************************/
void player_controll()
{    
      draw_tile(player.x, player.y, 5-1);
}

/******************************************************************************
*
*	Loading the Pitcures ( BMP ) 
*
*******************************************************************************/
void load_BMP()
{
   	
     tiles     = SDL_LoadBMP("gfx/tiles.bmp");
     
     if (tiles == NULL)
    cout << "Tiles file not found, error\n";
}
/******************************************************************************
*
*	Loading Sounds 
*
*******************************************************************************/
void load_sounds()
{
     // Laddar in musiken
     Pegs               = Mix_LoadMUS("sounds/Pegs.xm");
     //  ljudeffekter
     push                = Mix_LoadWAV("sounds/push.wav");        
     restart_level       = Mix_LoadWAV("sounds/restart.wav");
     colli               = Mix_LoadWAV("sounds/colli.wav");          
     next                = Mix_LoadWAV("sounds/next.wav");
     rot                 = Mix_LoadWAV("sounds/rotate.wav");  
  
}
/******************************************************************************
*
*	Controller for SDL 
*
*******************************************************************************/
void controll_SDL()
{
     atexit(SDL_Quit); 


  if (SDL_Init (SDL_INIT_VIDEO | SDL_INIT_AUDIO  ) == -1)
    {
      cout << "SDL init failed\n";
      exit(1);
    }
 
  screen = SDL_SetVideoMode(448,320,16,SDL_HWSURFACE | SDL_DOUBLEBUF);

  if (screen == NULL)
    {
      cout << "SDL failed\n";
    }
  
  if(Mix_OpenAudio( 22050, AUDIO_S16SYS, 2, 2048) < 0)
  {
    cout << "Warning: Couldn't set 44100 Hz 16-bit audio\n- Reason: %s\n",
							SDL_GetError();
  }
}

/******************************************************************************
*
*	Windowtext
*
*******************************************************************************/
void window_text()
{
     SDL_WM_SetCaption("AmigaOS4 PEGS  -  By Fredrik Stridh & Eric Johansson 2005", "PEGS");  
}

/******************************************************************************
*
*	Level completed and Load a map
*
*******************************************************************************/
void level_completed()
{
  bool temp = true;

  for(int y = 0; y < 10;y++)
  {
      for(int x = 0;x < 14;x++)
	  {
           if(map1.get_tilenr(x,y) == 0 || (map1.get_tilenr(x,y) == 1 || map1.get_tilenr(x,y) == 2 || map1.get_tilenr(x,y) == 3))
	       temp = false;
      }	    
   }
  
  if(temp == true)
  {
		level = level + 1;
		
        if ( level == 16 )
		{
           exit(1);
        }
		
        load_map(level);
        cout << "level complete\n";
  }

}

void load_map(int number)
{
    
    if (level == 1)
    {
       playerWorldPos.x = 5,
       playerWorldPos.y = 3; 
       player.x = 160;
       player.y = 96; 
       map1.lmap("maps/map_01.dat");
    }
    if (level == 2)
    {
       Mix_PlayChannel(0,next,0);
       map1.lmap("maps/map_02.dat");
       playerWorldPos.x = 1,
       playerWorldPos.y = 5; 
       player.x = 32;
       player.y = 160;     
    }
    if (level == 3)
    {
       Mix_PlayChannel(0,next,0);
       map1.lmap("maps/map_03.dat");
       playerWorldPos.x = 2,
       playerWorldPos.y = 2; 
       player.x = 64;
       player.y = 64;     
    }
    if (level == 4)
    {
       Mix_PlayChannel(0,next,0);
       map1.lmap("maps/map_04.dat");
       playerWorldPos.x = 6,
       playerWorldPos.y = 3; 
       player.x = 192;
       player.y = 96;         
    }
    if (level == 5)
    {
       Mix_PlayChannel(0,next,0);
       map1.lmap("maps/map_05.dat");
       playerWorldPos.x = 6,
       playerWorldPos.y = 5; 
       player.x = 192;
       player.y = 160;     
    }
    if (level == 6)
    {
       Mix_PlayChannel(0,next,0);
       map1.lmap("maps/map_06.dat");
       playerWorldPos.x = 1,
       playerWorldPos.y = 1; 
       player.x = 32;
       player.y = 32;     
    }
    if (level == 7)
    {
       Mix_PlayChannel(0,next,0);
       map1.lmap("maps/map_07.dat");
       playerWorldPos.x = 7,
       playerWorldPos.y = 4; 
       player.x = 224;
       player.y = 128;
    }
    if (level == 8)
    {
       Mix_PlayChannel(0,next,0);
       map1.lmap("maps/map_08.dat");
       playerWorldPos.x = 1,
       playerWorldPos.y = 4; 
       player.x = 32;
       player.y = 128;
    }
    if (level == 9)
    {
       Mix_PlayChannel(0,next,0);
       map1.lmap("maps/map_09.dat");
       playerWorldPos.x = 6,
       playerWorldPos.y = 5; 
       player.x = 192;
       player.y = 160;
    }
    if (level == 10)
    {
       Mix_PlayChannel(0,next,0);
       map1.lmap("maps/map_10.dat");
       playerWorldPos.x = 12,
       playerWorldPos.y = 2; 
       player.x = 384;
       player.y = 64;
    }
    if (level == 11)
    {
       Mix_PlayChannel(0,next,0);
       map1.lmap("maps/map_11.dat");
       playerWorldPos.x = 2,
       playerWorldPos.y = 1; 
       player.x = 64;
       player.y = 32;
    }
    if (level == 12)
    {
       Mix_PlayChannel(0,next,0);
       map1.lmap("maps/map_12.dat");
       playerWorldPos.x = 1,
       playerWorldPos.y = 1; 
       player.x = 32;
       player.y = 32;
    }
    if (level == 13)
    {
       Mix_PlayChannel(0,next,0);
       map1.lmap("maps/map_13.dat");
       playerWorldPos.x = 1,
       playerWorldPos.y = 4; 
       player.x = 32;
       player.y = 128;
    }
    if (level == 14)
    {
       Mix_PlayChannel(0,next,0);
       map1.lmap("maps/map_14.dat");
       playerWorldPos.x = 11,
       playerWorldPos.y = 6; 
       player.x = 352;
       player.y = 192;
    }
    if (level == 15)
    {
       Mix_PlayChannel(0,next,0);
       map1.lmap("maps/map_15.dat");
       playerWorldPos.x = 1,
       playerWorldPos.y = 6; 
       player.x = 32;
       player.y = 192;
    }
}

/******************************************************************************
*
*	CHECK
*
*******************************************************************************/
void check_down()
{
     playerWorldPos.y++; 
     int tile_check = map1.get_tilenr(playerWorldPos.x, playerWorldPos.y); 
     if(tile_check == 0) { Mix_PlayChannel(0,push,0); move_block_down(0);} // trekant
     if(tile_check == 1) { Mix_PlayChannel(0,push,0); move_block_down(1);} // kvadrat
     if(tile_check == 2) { Mix_PlayChannel(0,push,0); move_block_down(2);} // kors
     if(tile_check == 3) { Mix_PlayChannel(0,push,0); move_block_down(3);} // ring
     if(tile_check == 5) { restart(); } // hål
     if(tile_check == 6) { player.y -= 32; playerWorldPos.y--; } // isblock
}

void check_up()
{
     playerWorldPos.y--; 
     int tile_check = map1.get_tilenr(playerWorldPos.x, playerWorldPos.y);
     if(tile_check == 0) { Mix_PlayChannel(0,push,0); move_block_up(0); } // trekant
     if(tile_check == 1) { Mix_PlayChannel(0,push,0); move_block_up(1); } // kvadrat
     if(tile_check == 2) { Mix_PlayChannel(0,push,0); move_block_up(2); } // kors
     if(tile_check == 3) { Mix_PlayChannel(0,push,0); move_block_up(3); } // ring
     if(tile_check == 5) { restart(); } // hål
     if(tile_check == 6) { player.y += 32; playerWorldPos.y++; } // isblock
}

void check_right()
{
     playerWorldPos.x++; 
     int tile_check = map1.get_tilenr(playerWorldPos.x, playerWorldPos.y);
     if(tile_check == 0) { Mix_PlayChannel(0,push,0); move_block_right(0); } // trekant
     if(tile_check == 1) { Mix_PlayChannel(0,push,0); move_block_right(1); } // kvadrat
     if(tile_check == 2) { Mix_PlayChannel(0,push,0); move_block_right(2); } // kors
     if(tile_check == 3) { Mix_PlayChannel(0,push,0); move_block_right(3); } // ring
     if(tile_check == 5) { restart(); } // hål
     if(tile_check == 6) { player.x -= 32; playerWorldPos.x--; } // isblock
}

void check_left()
{
     playerWorldPos.x--;
     int tile_check = map1.get_tilenr(playerWorldPos.x, playerWorldPos.y); 
     if(tile_check == 0) { Mix_PlayChannel(0,push,0); move_block_left(0); } // trekant
     if(tile_check == 1) { Mix_PlayChannel(0,push,0); move_block_left(1); } // kvadrat
     if(tile_check == 2) { Mix_PlayChannel(0,push,0); move_block_left(2); } // kors
     if(tile_check == 3) { Mix_PlayChannel(0,push,0); move_block_left(3); } // ring
     if(tile_check == 5) { restart(); } // hål
     if(tile_check == 6) { player.x += 32; playerWorldPos.x++; } // isblock
}
/******************************************************************************
*
*	Move Blocks
*
*******************************************************************************/
void move_block_down(unsigned int tilenr)
{

     // trekant
	if ( tilenr == 0 )
    {
        
        int temp = map1.get_tilenr(playerWorldPos.x, playerWorldPos.y+1);
        
        if(temp == 7) // kollar fri väg framför blocket som man styr
		{
			map1.set_tilenr(playerWorldPos.x, playerWorldPos.y,7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y+1, tilenr);  
		}
	    else if (temp == 1) // om man knuffar en trekant på en kvadrat
	    {
             restart();
        }
        else if (temp == 2) // om man knuffar en trekant på ett kors
	    {
             restart();
        }
        else if (temp == 3) // om man knuffar en trekant på en ring
	    {
             restart();
        }
        else if (temp == 0) // Förvandlar trekanter till isblock om de knuffas ihop
		{
            Mix_PlayChannel(0,colli,0);
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y+1, 6);  
        }
        else if (temp == 5) // OM man knuffar ner en trekant i hålet ska den försvinna
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y+1, 5);  
        }
        else // om det inte finns något framför blocket
		{
			playerWorldPos.y--;
			player.y -= 32;
		}
     }
     // kvadrat
     if ( tilenr == 1 )
     {
        int temp = map1.get_tilenr(playerWorldPos.x, playerWorldPos.y+1);
        
        if(temp == 7) // kollar fri väg framför blocket som man styr
		{
			map1.set_tilenr(playerWorldPos.x, playerWorldPos.y,7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y+1, tilenr);  
		}
        else if (temp == 0) // om man knuffar en kvadrat på en trekant
	    {
             restart();
        }
        else if (temp == 2) // m man knuffar en kvadrat på ett kors 
	    {
             restart();
        }
        else if (temp == 3) // om man knuffar en kvadrat på en ring
	    {
             restart();
        }
        else if (temp == 1) // tar bort kvadraterna om du stöter ihop
		{
            Mix_PlayChannel(0,colli,0);
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y+1, 7);  
        }
        else if (temp == 5) // om kvadraten hamnar i hålet så försvinner hålet
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y+1, 7);
        }
        else // om det inte finns något framför blocket
		{
			playerWorldPos.y--;
			player.y -= 32;
		}
     }
     // kors
     if ( tilenr == 2 )
     {
        int temp = map1.get_tilenr(playerWorldPos.x, playerWorldPos.y+1);
        
        if(temp == 7) // kollar fri väg framför blocket som man styr
		{
			map1.set_tilenr(playerWorldPos.x, playerWorldPos.y,7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y+1, tilenr);  
		}
	    else if (temp == 0) // om man knuffar ett kors på en trekant
	    {
             restart();
        }
        else if (temp == 1) // om man knuffar ett kors på en kvadrat
	    {
             restart();
        }
        else if (temp == 3) // om man knuffar ett kors på en ring
	    {
             restart();
        }
        else if (temp == 2) // Om två kors puttas ihop ska man kunna välja tile med funktionen choose_tile();
		{
            Mix_PlayChannel(0,colli,0);
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 		
            select_tile(playerWorldPos.x, playerWorldPos.y+1); 
        }
        else if (temp == 5) // OM man knuffar ner ett kors i hålet ska den försvinna
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y+1, 5);  
        }
        else // om det inte finns något framför blocket
		{
			playerWorldPos.y--;
			player.y -= 32;
		}
     }
     // ring
     if ( tilenr == 3 )
     {
        int temp = map1.get_tilenr(playerWorldPos.x, playerWorldPos.y+1);
        
        if(temp == 7) // kollar fri väg framför blocket som man styr
		{
			map1.set_tilenr(playerWorldPos.x, playerWorldPos.y,7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y+1, tilenr);  
		}
	    else if (temp == 0) // om man knuffar en ring på en trekant
	    {
             restart();
        }
        else if (temp == 1) // om man knuffar en ring på en kvadrat
	    {
             restart();
        }
        else if (temp == 2) // om man knuffar en ring på ett kors
	    {
             restart();
        }
        else if (temp == 3) // tar bort ringar om de puttas ihop 
		{
            Mix_PlayChannel(0,colli,0);
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y+1, 7);  
        }
        else if (temp == 5) // OM man knuffar ner ringen i hålet ska den försvinna
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y+1, 5);  
        }
        else // om det inte finns något framför blocket
		{
			playerWorldPos.y--;
			player.y -= 32;
		}
     }
}
void move_block_up(unsigned int tilenr)
{
     // trekant
	if ( tilenr == 0 )
     {
        int temp = map1.get_tilenr(playerWorldPos.x, playerWorldPos.y-1);
	
		if(temp == 7) // kollar fri väg framför blocket som man styr
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y-1, tilenr);  
		}
        else if (temp == 1) // om man knuffar en trekant på en kvadrat
	    {
             restart();
        }
        else if (temp == 2) // om man knuffar en trekant på ett kors
	    {
             restart();
        }
        else if (temp == 3) // om man knuffar en trekant på en ring
	    {
             restart();
        }
        else if ( temp == 0 ) // Förvandlar trekanter till isblock om de knuffas ihop
		{
            Mix_PlayChannel(0,colli,0);
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y-1, 6); 
        }
        else if (temp == 5) // OM man knuffar ner en kvadrat i hålet ska den försvinna
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y-1, 5); 
        }
        else // om det inte finns något framför blocket
		{
			playerWorldPos.y++;
			player.y += 32;
		}
     }
     // kvadrat
     if ( tilenr == 1 )
     {
        int temp = map1.get_tilenr(playerWorldPos.x, playerWorldPos.y-1);
	
		if(temp == 7) // kollar fri väg framför blocket som man styr
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y-1, tilenr);  
		}
        else if (temp == 0) // om man knuffar en kvadrat på en trekant
	    {
             restart();
        }
        else if (temp == 2) // m man knuffar en kvadrat på ett kors 
	    {
             restart();
        }
        else if (temp == 3) // om man knuffar en kvadrat på en ring
	    {
             restart();
        }
        else if ( temp == 1 ) // tar bort kvadraterna om du stöter ihop
		{
            Mix_PlayChannel(0,colli,0);
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y-1, 7); 
        }
        else if (temp == 5) // om kvadraten hamnar i hålet så försvinner hålet
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y-1, 7); 
        }
        else // om det inte finns något framför blocket
		{
			playerWorldPos.y++;
			player.y += 32;
		}
     }
     // kors
     if ( tilenr == 2 )
     {
        int temp = map1.get_tilenr(playerWorldPos.x, playerWorldPos.y-1);
	
		if(temp == 7) // kollar fri väg framför blocket som man styr
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y-1, tilenr);  
		}
        else if (temp == 0) // om man knuffar ett kors på en trekant
	    {
             restart();
        }
        else if (temp == 1) // om man knuffar ett kors på en kvadrat
	    {
             restart();
        }
        else if (temp == 3) // om man knuffar ett kors på en ring
	    {
             restart();
        }
        else if ( temp == 2 ) // Om två kors puttas ihop ska man kunna välja tile med funktionen choose_tile();
		{
            Mix_PlayChannel(0,colli,0);
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 		
            select_tile(playerWorldPos.x, playerWorldPos.y-1); 
        }
        else if (temp == 5) // OM man knuffar ner ett kors i hålet ska det försvinna
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y-1, 5); 
        }
        else // om det inte finns något framför blocket
		{
			playerWorldPos.y++;
			player.y += 32;
		}
      }
      // RING
      if ( tilenr == 3 )
      {
        int temp = map1.get_tilenr(playerWorldPos.x, playerWorldPos.y-1);
	
		if(temp == 7) // kollar fri väg framför blocket som man styr
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y-1, tilenr);  
		}
        else if (temp == 0) // om man knuffar en ring på en trekant
	    {
             restart();
        }
        else if (temp == 1) // om man knuffar en ring på en kvadrat
	    {
             restart();
        }
        else if (temp == 2) // om man knuffar en ring på ett kors
	    {
             restart();
        }
        else if ( temp == 3 ) // tar bort ringar om de puttas ihop 
		{
            Mix_PlayChannel(0,colli,0);
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y-1, 7); 
        }
        else if (temp == 5) // OM man knuffar ner ringen i hålet ska den försvinna
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y-1, 5); 
        }
        else // om det inte finns något framför blocket
		{
			playerWorldPos.y++;
			player.y += 32;
		}
     }
}

void move_block_right(unsigned int tilenr)
{
	// trekant
	if ( tilenr == 0 ) 
    {
	    int temp = map1.get_tilenr(playerWorldPos.x+1, playerWorldPos.y);
	
		if(temp == 7) // kollar fri väg framför blocket som man styr
		{
			map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
			map1.set_tilenr(playerWorldPos.x+1, playerWorldPos.y, tilenr); 
		}
        else if (temp == 1) // om man knuffar en trekant på en kvadrat
	    {
             restart();
        }
        else if (temp == 2) // om man knuffar en trekant på ett kors
	    {
             restart();
        }
        else if (temp == 3) // om man knuffar en trekant på en ring
	    {
             restart();
        }
        else if(temp == 0) // Förvandlar trekanter till isblock om de knuffas ihop
        {
			Mix_PlayChannel(0,colli,0);
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
			map1.set_tilenr(playerWorldPos.x+1, playerWorldPos.y, 6); 
		}
        else if (temp == 5) // OM man knuffar ner en trekant i hålet ska den försvinna
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
			map1.set_tilenr(playerWorldPos.x+1, playerWorldPos.y, 5);  
        }
        
        else // om det inte finns något framför blocket
		{
			playerWorldPos.x--;
			player.x -= 32;
		}
	}

	// kvadrat
	if ( tilenr == 1 )
    {
	    int temp = map1.get_tilenr(playerWorldPos.x+1, playerWorldPos.y);
	
		if(temp == 7) // kollar fri väg framför blocket som man styr
		{
			map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
			map1.set_tilenr(playerWorldPos.x+1, playerWorldPos.y, tilenr); 
		}
		else if (temp == 0) // om man knuffar en kvadrat på en trekant
	    {
             restart();
        }
        else if (temp == 2) // m man knuffar en kvadrat på ett kors 
	    {
             restart();
        }
        else if (temp == 3) // om man knuffar en kvadrat på en ring
	    {
             restart();
        }
        else if(temp == 1) // tar bort kvadraterna om du stöter ihop 
        {
			Mix_PlayChannel(0,colli,0);
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
			map1.set_tilenr(playerWorldPos.x+1, playerWorldPos.y, 7);
        }
        else if (temp == 5) // om kvadraten hamnar i hålet så försvinner hålet
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
			map1.set_tilenr(playerWorldPos.x+1, playerWorldPos.y, 7);
        }
        else // om det inte finns något framför blocket
		{
			playerWorldPos.x--;
			player.x -= 32;
		}	
	}

     // kors
     if ( tilenr == 2 )
     {
		int	 temp = map1.get_tilenr(playerWorldPos.x+1, playerWorldPos.y);
	
		if(temp == 7) // kollar fri väg framför blocket som man styr
		{
			map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
			map1.set_tilenr(playerWorldPos.x+1, playerWorldPos.y, tilenr); 
		}
		else if (temp == 0) // om man knuffar ett kors på en trekant
	    {
             restart();
        }
        else if (temp == 1) // om man knuffar ett kors på en kvadrat
	    {
             restart();
        }
        else if (temp == 3) // om man knuffar ett kors på en ring
	    {
             restart();
        }
        else if(temp == 2) // Om två kors puttas ihop ska man kunna välja tile med funktionen choose_tile();
        {
			Mix_PlayChannel(0,colli,0);
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 		
            select_tile(playerWorldPos.x+1, playerWorldPos.y); 
        }
        else if (temp == 5) // OM man knuffar ner ett kors i hålet ska det försvinna
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
			map1.set_tilenr(playerWorldPos.x+1, playerWorldPos.y, 5);  
        }
        else // om det inte finns något framför blocket
		{
			playerWorldPos.x--;
			player.x -= 32;
		}	
	}
    // ring
     if ( tilenr == 3 )
     {
		int temp = map1.get_tilenr(playerWorldPos.x+1, playerWorldPos.y);
	
		if(temp == 7) // kollar fri väg framför blocket som man styr
		{
			map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
			map1.set_tilenr(playerWorldPos.x+1, playerWorldPos.y, tilenr); 
		}
		else if (temp == 0) // om man knuffar en ring på en trekant
	    {
             restart();
        }
        else if (temp == 1) // om man knuffar en ring på en kvadrat
	    {
             restart();
        }
        else if (temp == 2) // om man knuffar en ring på ett kors
	    {
             restart();
        }
        else if(temp == 3) // tar bort ringar om de puttas ihop 
        {
			Mix_PlayChannel(0,colli,0);
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
			map1.set_tilenr(playerWorldPos.x+1, playerWorldPos.y, 7);
        }
        else if (temp == 5) // OM man knuffar ner ringen i hålet ska den försvinna
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
			map1.set_tilenr(playerWorldPos.x+1, playerWorldPos.y, 5);  
        }
        else // om det inte finns något framför blocket
		{
			playerWorldPos.x--;
			player.x -= 32;
		}	
	}

}

void move_block_left(unsigned int tilenr)
{
     // trekant
     if ( tilenr == 0 ) 
     {
        int temp = map1.get_tilenr(playerWorldPos.x-1, playerWorldPos.y);
        
        if(temp == 7) // kollar fri väg framför blocket som man styr
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x-1, playerWorldPos.y, tilenr); 
        }     
        else if (temp == 1) // om man knuffar en trekant på en kvadrat
	    {
             restart();
        }
        else if (temp == 2) // om man knuffar en trekant på ett kors
	    {
             restart();
        }
        else if (temp == 3) // om man knuffar en trekant på en ring
	    {
             restart();
        }
        else if (temp == 0) // Förvandlar trekanter till isblock om de knuffas ihop
        {
             Mix_PlayChannel(0,colli,0);
             map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
             map1.set_tilenr(playerWorldPos.x-1, playerWorldPos.y, 6); 
        }
        else if (temp == 5) // OM man knuffar ner en trekant i hålet ska den försvinna
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x-1, playerWorldPos.y, 5);   
        }
        else // om det inte finns något framför blocket
		{
            playerWorldPos.x++;
			player.x += 32;
        }
     }  
     // kvadrat
     if ( tilenr == 1 ) 
     {
        int temp = map1.get_tilenr(playerWorldPos.x-1, playerWorldPos.y);
        
        if(temp == 7) // kollar fri väg framför blocket som man styr
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x-1, playerWorldPos.y, tilenr); 
        }     
        else if (temp == 0) // om man knuffar en kvadrat på en trekant
	    {
             restart();
        }
        else if (temp == 2) // m man knuffar en kvadrat på ett kors 
	    {
             restart();
        }
        else if (temp == 3) // om man knuffar en kvadrat på en ring
	    {
             restart();
        }
        else if (temp == 1) // tar bort kvadraterna om du stöter ihop
        {
             Mix_PlayChannel(0,colli,0);
             map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
             map1.set_tilenr(playerWorldPos.x-1, playerWorldPos.y, 7); 
        }
        else if (temp == 5) // om kvadraten hamnar i hålet ska hålet försvinna
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
             map1.set_tilenr(playerWorldPos.x-1, playerWorldPos.y, 7); 
        }
        else // om det inte finns något framför blocket
		{
            playerWorldPos.x++;
			player.x += 32;
        }
     }   
     // kors
     if ( tilenr == 2 ) 
     {
        int temp = map1.get_tilenr(playerWorldPos.x-1, playerWorldPos.y);
        
        if(temp == 7) // kollar fri väg framför blocket som man styr
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x-1, playerWorldPos.y, tilenr); 
        }     
        else if (temp == 0) // om man knuffar ett kors på en trekant
	    {
             restart();
        }
        else if (temp == 1) // om man knuffar ett kors på en kvadrat
	    {
             restart();
        }
        else if (temp == 3) // om man knuffar ett kors på en ring
	    {
             restart();
        }
        else if (temp == 2) // Om två kors puttas ihop ska man kunna välja tile med funktionen choose_tile();
        {
             Mix_PlayChannel(0,colli,0);
             map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
             select_tile(playerWorldPos.x-1, playerWorldPos.y); 
        }
        else if (temp == 5) // OM man knuffar ner ett kors i hålet ska det försvinna
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x-1, playerWorldPos.y, 5);   
        }
        else // om det inte finns något framför blocket
		{
            playerWorldPos.x++;
			player.x += 32;
        }
     }  
     // ring
     if ( tilenr == 3 ) 
     {
        int temp = map1.get_tilenr(playerWorldPos.x-1, playerWorldPos.y);
        
        if(temp == 7) // kollar fri väg framför blocket som man styr
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x-1, playerWorldPos.y, tilenr); 
        }     
        else if (temp == 0) // om man knuffar en ring på en trekant
	    {
             restart();
        }
        else if (temp == 1) // om man knuffar en ring på en kvadrat
	    {
             restart();
        }
        else if (temp == 2) // om man knuffar en ring på ett kors
	    {
             restart();
        }
        else if (temp == 3) // tar bort ringar om de puttas ihop 
        {
             Mix_PlayChannel(0,colli,0);
             map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
             map1.set_tilenr(playerWorldPos.x-1, playerWorldPos.y, 7); 
        }
        else if (temp == 5) // OM man knuffar ner ringen i hålet ska den försvinna
		{
            map1.set_tilenr(playerWorldPos.x, playerWorldPos.y, 7); 
            map1.set_tilenr(playerWorldPos.x-1, playerWorldPos.y, 5);   
        }
        else // om det inte finns något framför blocket
		{
            playerWorldPos.x++;
			player.x += 32;
        }
 
     }
}
/******************************************************************************
*
*	Väljer Tile vid kollision av två kors
*
*******************************************************************************/
void select_tile(int posX, int posY)
{
	
  while( ! done)
  {
      
      done = check_tile_select_input();  // Returnera 1 ifall funktioben ska avslutas
      
      draw_map();
      player_controll();
      draw_tile(posX*32, posY*32, tileSelected); // ritar upp tile:n medans man väljer
      SDL_Flip(screen);  // double buf, swappar skärmar
  }
  // ritar ut den valde tile:n på kartan
  map1.set_tilenr(posX, posY, tileSelected); 

}  

int check_tile_select_input()
{
  int done = 0;
  Uint8* keys;
  
  SDL_Event event;
  keys = SDL_GetKeyState(NULL);
             
  while(SDL_PollEvent(&event))
  {
       //Väljer vilken tile man vill ha
      if ( keys[SDLK_UP] ) {tileSelected++; Mix_PlayChannel(0,rot,0);}
      if ( keys[SDLK_DOWN]) {tileSelected--;Mix_PlayChannel(0,rot,0);}
             
	  if(tileSelected < 0)
		  tileSelected = 3;
	  
      if (tileSelected == 4)
		  tileSelected = 0;
      
      if (event.type == SDL_QUIT)
          done = 1;

      if (event.type == SDL_KEYDOWN)
      {
         if (event.key.keysym.sym == SDLK_RETURN)
         {
            done = 1;
         }
      }
   }
  
  return done;
}

 
/******************************************************************************
*
*	Restart
*
*******************************************************************************/      
void restart()
{
  
 
  playerWorldPos.x = 1,
  playerWorldPos.y = 1; 
  player.y = 32;
  player.x = 32; 
   load_map(level);
  Mix_PlayChannel(0,restart_level,0);
}             
/******************************************************************************
*
*	Sounds and Music
*
*******************************************************************************/      
void play_pegs_song()
{
     if(!Mix_PlayingMusic())
     {
         // startar musiken
         Mix_PlayMusic(Pegs, 1);
     }
}  
  

