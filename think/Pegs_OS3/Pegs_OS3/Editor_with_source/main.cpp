
/*********************************************************************
 *
 *
 *  Map Editor Version 0.2
 * 
 *  Code by: Fredrik Stridh
 *           Eric Johansson
 *
 *  Last update: 04 04 18
 *
 ********************************************************************/


#include "SDL.h"

#include "map.h"
#include "tileset.h"
#include "guiO.h"

#include <iostream>
#include <fstream>


using namespace std;


// Gfx

SDL_Surface *screen;  
SDL_Surface *tiles;
SDL_Surface *pointer;
SDL_Surface *logo;
SDL_Surface *intrologo;

SDL_Surface *load;
SDL_Surface *save;

// Objekt

map map1(100,30);
tileset tileset1(32, 32, 8);
guiO guiobjects[10];


// Globala variabler

int editor_state = 1;  // 1 = editor, 2 = tile editor
int active_tile = 1;
int st = 0;            // st to draw in menu

Uint16 mouse_x;
Uint16 mouse_y;

int scrollx = 0;
int scrolly = 0;

// Funktions Prototyper

void main_loop();
int check_input();
void blit_image(SDL_Surface *img, int x, int y);
void blit_image(SDL_Surface *img, int x1, int y1, int w, int h, int x2, int y2);
void draw_tile(int x, int y, int tile);
void draw_map();
void draw_tilescreen();
int calc_curs(Uint16 mousex, Uint16 mousey);
void save_map(char *filename);
void load_map(char *filename);
void load_gui();
void draw_gui();
int check_gui(int pos);
void draw_mtiles(int start_tile);


/******************************************************************************
*
*	Main        
*
******************************************************************************/


int main(int argc, char *argv[] )
{


  //atexit(SDL_Quit); 


  if (SDL_Init (SDL_INIT_VIDEO | SDL_INIT_AUDIO  ) == -1)
    {
      cout << "SDL init failed\n";
      exit(1);
    }
 
  screen = SDL_SetVideoMode(640,480,16,SDL_HWSURFACE | SDL_DOUBLEBUF);

  if (screen == NULL)
    {
      cout << "SDL failed\n";
    }
  
  
  map1.clear_map(20);

  SDL_WM_SetCaption("Map Editor Version 0.2 - Code by Fredrik Stridh 2004,  Eric Johansson 2005,     Gfx by Eric Johansson", "Map Editor");  
  
tiles = SDL_LoadBMP("gfx/tiles.bmp");
      
  if (tiles == NULL)
    cout << "Tiles file not found, error\n";

  pointer = SDL_LoadBMP("gfx/pointer.bmp");
  SDL_SetColorKey(pointer, SDL_SRCCOLORKEY,0);
  if (pointer == NULL)
    cout << "Pointer gfx  file not found, error\n";
   

  logo = SDL_LoadBMP("gfx/logo.bmp");
  intrologo = SDL_LoadBMP("gfx/intrologo.bmp");	
  
  load_gui();


  SDL_ShowCursor(SDL_DISABLE);
  blit_image(intrologo, 0, 0);
 
 
   SDL_FreeSurface(intrologo);
   

	int tp = map1.get_mapsizeY();
	scrolly = (tp-14); // start för yscrollen

   map1.clear_map(7);
   main_loop();


  return 0;
}

/******************************************************************************
*
*	Main Loop
*
******************************************************************************/
  

void main_loop()
{
  int done = 0;
  Uint32 black = 0;

  while( ! done)
    {
      done = check_input();  // Returnera 1 ifall programmet ska avslutas
      if (editor_state == 1)
         draw_map();
         
      
      if (editor_state == 2)
         draw_tilescreen();
	  
      draw_mtiles(st);
      draw_gui();

      // Mouse Pointer
      blit_image(pointer, mouse_x, mouse_y);
          
      SDL_Flip(screen);  // double buf, swappar skärmar
    SDL_FillRect(screen, NULL, black);  // rensar draw skärmen 
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
  int mouse_pos = 0;
  
  SDL_Event event;
  
  

  while(SDL_PollEvent(&event))
    {
      
      if (event.type == SDL_QUIT)
	done = 1;

      if (event.type == SDL_MOUSEMOTION)
	{
	  mouse_x = event.motion.x;
	  mouse_y = event.motion.y;
	}


      // Check if mouse button press

      if (event.type == SDL_MOUSEBUTTONDOWN )
	{
		
	  if (event.button.state == SDL_PRESSED)
	    {
		  mouse_pos = (mouse_x / tileset1.tile_widht) + ((mouse_y / tileset1.tile_height * 25));
		  				  

	      if(event.button.button == SDL_BUTTON_LEFT)
		{
		  if (editor_state == 1)

			// Kollar gui funktioner

			if (mouse_pos < 50)
			done = check_gui(mouse_pos);

		   	if (mouse_pos > 49)
			  map1.set_tilenr((mouse_x / tileset1.tile_widht)+scrollx, ((mouse_y-64) / tileset1.tile_height)+scrolly, active_tile);

		  if (editor_state == 2)
		    {

				// ingen koll om man skriver utanför tillåtet område

		      active_tile = calc_curs(mouse_x, mouse_y);
		      cout << calc_curs(mouse_x, mouse_y);
		    }
		}

	      if(event.button.button == SDL_BUTTON_RIGHT)
		{
		  active_tile++;
		  if (active_tile == 21) {active_tile = 1;}
		}
     	    }	
	}

	// Check if key down	

	if (event.type == SDL_KEYDOWN)
	  {

	    if (event.key.keysym.sym == SDLK_ESCAPE)
	      {
		done = 1;
	      }
	    
	    if (event.key.keysym.sym == SDLK_t)
	      {
		editor_state++;
		if (editor_state == 3)
		  editor_state = 1;
	      }

	    if (event.key.keysym.sym == SDLK_F1)
	      {
		load_map("map_01.dat");
	      }
			
	    if (event.key.keysym.sym == SDLK_F5)
	      {
	     	save_map("map_01.dat");
	      }

	    if (event.key.keysym.sym == SDLK_RIGHT)
	      {
			int tmp = map1.get_mapsizeX();
	     	scrollx++;
			if (scrollx == (tmp - 25)+1)
				scrollx--;
	      }
		
		if (event.key.keysym.sym == SDLK_LEFT)
	      {
	     	scrollx--;
			if (scrollx == -1)
				scrollx = 0;
	      }

		if (event.key.keysym.sym == SDLK_DOWN)
		{
			scrolly++;
			int tmp = map1.get_mapsizeY();
			if (scrolly == (tmp-14)+1)
				scrolly--;
		}

		if (event.key.keysym.sym == SDLK_UP)
		{
			scrolly--;
			if (scrolly == -1)
				scrolly = 0;
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
   for (int y = 0; y < 8; y++)
    {
      for (int x = 0; x < 12; x++)
	{
       	  draw_tile(x * tileset1.tile_widht, (y * tileset1.tile_height)+64, map1.get_tilenr(x+scrollx, y+scrolly));
	}  
    }     
}


/******************************************************************************
*
*	Draw Tile Screen   
*
*******************************************************************************/


void draw_tilescreen()
{
  int x = 0;
  int y = 0;

  for(int a=0; a < 8 ;a++) // 8 st tiles
    {
      draw_tile(x, y, a);
      x = x + tileset1.tile_widht;

      if(x == 384) // 384 pixlar till nästa rad
        {
	  x = 0;
	  y = y + tileset1.tile_height;
        }
    }
}



/******************************************************************************
*
*	Calc Curs  
*
*******************************************************************************/


int calc_curs(Uint16 mousex, Uint16 mousey)
{
	int mx, my;

	mx = mousex / tileset1.tile_widht; 
	my = mousey / tileset1.tile_widht; 
	return mx + (my * 25);
}	


/******************************************************************************
*
*	Save Map
*
*******************************************************************************/


void save_map(char *filename)
{
  cout << "Saving map " << filename << "\n";
 
  ofstream fout(filename);

  int map_sizeX = map1.get_mapsizeX();
  int map_sizeY = map1.get_mapsizeY();

  fout << map_sizeX << "\n";
  fout << map_sizeY << "\n";

   for (int y = 0; y < map_sizeY; y++)
     {
       for (int x = 0; x < map_sizeX; x++)
	 {
	   fout << map1.get_tilenr(x, y) << "\n"; 
	 }  
     }
   fout.close();
}     


/******************************************************************************
*
*	Load Map
*
*******************************************************************************/

void load_map(char *filename)
{
  cout << "Loading map " << filename << "\n";
 
  ifstream infile(filename);
  
  int map_sizeX = 0; 
  int map_sizeY = 0;

  infile >> map_sizeX;
  infile >> map_sizeY;
  
int temp;
  
  for (int y = 0; y < map_sizeY; y++)
    {
      for (int x = 0; x < map_sizeX; x++)
	{
	  infile >> temp; 
	  map1.set_tilenr(x, y, temp); 
	}  
    }


  infile.close();
}

void load_gui()
{

  guiobjects[0].setcoords(0,0);
  guiobjects[0].image = SDL_LoadBMP("gui/load.bmp");

  guiobjects[1].image = SDL_LoadBMP("gui/save.bmp");
  guiobjects[1].setcoords(32,0);
 
  guiobjects[2].image = SDL_LoadBMP("gui/quit.bmp");
  guiobjects[2].setcoords(608,0);

  guiobjects[3].image = SDL_LoadBMP("gui/left.bmp");
  guiobjects[3].setcoords(128,0);

  guiobjects[4].image = SDL_LoadBMP("gui/right.bmp");
  guiobjects[4].setcoords(416,0);

}

void draw_gui()
{ 
	for (int a = 0; a < 5; a++)
	{
		blit_image (guiobjects[a].image, guiobjects[a].xpos, guiobjects[a].ypos );
	}
}


int check_gui(int pos)
{
	switch (pos)
	{
	case 0:
		cout << "load\n";
		map1.lmap("map_01.dat");
		
		break;

	case 1:
		cout << "save\n";
		map1.smap("map_01.dat");
		break;

	case 4:
		cout << "left arrow\n";
		st = st - 1;
		if (st == -1)
			st = 0;
		break;

	case 20:
		cout << "righ arrow\n";
		st++;
		if (st == 301)
			st = 300;
		break;

	case 24:
		cout << "quit\n";
		   exit(1);
		break;

	default :
		cout << "ingen funktion vald\n";
	}

	if (pos > 4 && pos < 20)
		active_tile = (pos - 4) + st - 1;


	return 0;
}

void draw_mtiles(int start_tile)
{
	int x = 32 * 5;
		for (int a = 0; a < 8; a++)
	{
		draw_tile(x, 0, start_tile);
			x = x + 32;
			start_tile++;
	}
}
