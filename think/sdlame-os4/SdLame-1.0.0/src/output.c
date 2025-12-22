#include <SDL.h>
#include <SDL_events.h>
#include <SDL_image.h>
#include <SDL_ttf.h>
#include <SDL_mixer.h>
#include <SDL_thread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "sdlame.h"
#include "vars.h"

void draw_field()
{
  SDL_Surface *img = NULL;
  SDL_Surface *output = NULL;
  SDL_RWops *rwop = NULL;
  SDL_Rect cursor;
  SDL_Rect units;
  SDL_Rect rect;
  Uint32 color;

  int x = 1, y = 1, z = 1, id = 1;

  background(3);
  SDL_Flip(screen);

  output = IMG_Load("background.png");

  color = SDL_MapRGB(screen->format, 0x00, 0xFF, 0x00);

  while(y <= 8)
  {
    z = field[x][y];

    if(
       ((((x + (8 * y)) % 2) != 0) && ((y % 2) == 0)) || 
       ((((x + (8 * y)) % 2) == 0) && ((y % 2) != 0)) 
      )
    {
      switch(z)
      {
        case 1:
          rwop = SDL_RWFromFile("unit_1.png", "rb");
          break;
        case 2:
          rwop = SDL_RWFromFile("unit_2.png", "rb");
          break;
        case 3:
          rwop = SDL_RWFromFile("unit_3.png", "rb");
          break;
        case 4:
          rwop = SDL_RWFromFile("unit_4.png", "rb");
          break;
        default:
          rwop = SDL_RWFromFile("black.png", "rb");
          break;
      }
    }
    else
    {
      rwop = SDL_RWFromFile("white.png", "rb");
    }

    img = IMG_LoadPNG_RW(rwop);

    units.x = field_start_x + (place_size * x) - place_size;
    units.y = field_start_y + (place_size * y) - place_size;
    units.w = place_size;
    units.h = place_size;

    SDL_BlitSurface(img, NULL, output, &units);
    SDL_FreeSurface(img);

    rect.x = loading_x;
    rect.y = loading_y;
    rect.w = loading_w * id;
    rect.h = loading_h;

    SDL_FillRect(screen, &rect, color);
    SDL_Flip(screen);

    x++;
    id++;

    if(x > 8)
    {
      y++;
      x = 1;
    }
  }

  /* Draw Cursor */
  x = (place_size * (cursor_x - 1));
  y = (place_size * (cursor_y - 1));

  rwop = SDL_RWFromFile("cursor.png", "rb");
  img = IMG_LoadPNG_RW(rwop);

  cursor.x = field_start_x + x;
  cursor.y = field_start_y + y;

  SDL_BlitSurface(img, NULL, output, &cursor);
  SDL_FreeSurface(img);

  rect.x = loading_x;
  rect.y = loading_y;
  rect.w = loading_w * 66;
  rect.h = loading_h;

  SDL_FillRect(screen, &rect, color);
  SDL_Flip(screen);

  if(SDL_BlitSurface(output, NULL, screen, NULL) < 0)
  {
    printf("Error: Couldn't load output: %s\n", SDL_GetError());
  }

  SDL_Flip(screen);
  SDL_FreeSurface(output);
}

void draw_place(int x, int y)
{
  SDL_Surface *img = NULL;
  SDL_RWops   *rwop = NULL;
  SDL_Rect    backgroundarea;

  if(x >= 1 && x <= 8 && y >= 1 && y <= 8)
  {
    //draw a single place
    if(
     ((((x + (8 * y)) % 2) != 0) && ((y % 2) == 0)) || 
     ((((x + (8 * y)) % 2) == 0) && ((y % 2) != 0)) 
    )
    {
      //place is black
      switch(field[x][y])
      {
        case 0:
          rwop = SDL_RWFromFile("black.png", "rb");
          break;
        case 1:
          rwop = SDL_RWFromFile("unit_1.png", "rb");
          break;
        case 2:
          rwop = SDL_RWFromFile("unit_2.png", "rb");
          break;
        case 3:
          rwop = SDL_RWFromFile("unit_3.png", "rb");
          break;
        case 4:
          rwop = SDL_RWFromFile("unit_4.png", "rb");
          break;
      }
    }
    else
    {
      //place is white + empty because no unit can enter a white field
      rwop = SDL_RWFromFile("white.png", "rb");
    }

    img = IMG_LoadPNG_RW(rwop);

    backgroundarea.x = field_start_x + (x * place_size) - place_size;
    backgroundarea.y = field_start_y + (y * place_size) - place_size;

    SDL_BlitSurface(img, NULL, screen, &backgroundarea);
    SDL_Flip(screen);
    SDL_FreeSurface(img);
  }
}

void draw_cursor(int x, int y, int cursor)
{
  SDL_Surface *img = NULL;
  SDL_RWops   *rwop = NULL;
  SDL_Rect    backgroundarea;

  if(x >= 1 && x <= 8 && y >= 1 && y <= 8)
  {
    if(cursor == 1)
    {
      rwop = SDL_RWFromFile("cursor.png", "rb");
    }
    else
    {
      rwop = SDL_RWFromFile("unit.png", "rb"); 
    }

    img = IMG_LoadPNG_RW(rwop);

    backgroundarea.x = field_start_x + (x * place_size) - place_size;
    backgroundarea.y = field_start_y + (y * place_size) - place_size;

    SDL_BlitSurface(img, NULL, screen, &backgroundarea);
    SDL_Flip(screen);
    SDL_FreeSurface(img);
  }
}

void output(char str[255])
{
  SDL_Surface *text_surface;
  SDL_Rect    textarea;
  SDL_Color   color={255,255,255}, bgcolor={0,0,0};
  SDL_Surface *img = NULL;
  SDL_RWops   *rwop = NULL;

  /* Render Text */
  text_surface = TTF_RenderUTF8_Shaded(font,str,color,bgcolor);

  /* Draw Informations */
  textarea.x = info_text_x;
  textarea.y = info_text_y;
  textarea.w = info_text_w;
  textarea.h = info_text_h;

  /* Delete Old Text with the background picture 2 */
  rwop = SDL_RWFromFile("delete_text.png", "rb");
  img  = IMG_LoadPNG_RW(rwop);

  SDL_BlitSurface(img, NULL, screen, &textarea);
  SDL_Flip(screen);
  SDL_FreeSurface(img);

  /* Draw Text onto the screen */
  SDL_BlitSurface(text_surface,NULL,screen,&textarea);
  SDL_Flip(screen);

  /* Free the memory */
  SDL_FreeSurface(text_surface);
}

void background(int picture)
{
  SDL_Surface *img = NULL;

  switch(picture)
  {
    case 1:
        img = IMG_Load("title.png");
        break;
    case 2:
        img = IMG_Load("background.png");
        break;
    case 3:
        img = IMG_Load("loading.png");
        break;
  }

  SDL_BlitSurface(img, NULL, screen, NULL);
  SDL_FreeSurface(img);
}

void menu()
{
  SDL_Surface *menu = NULL;
  SDL_Surface *arrow = NULL;
  SDL_Rect arrow_rect;

  /* If this var is set to 1 the game will return */
  int exit = 0;

  /* If this var is set to 1 enter was pressed */
  int enter = 0;

  /* load menu and arrow pictures */
  menu = IMG_Load("menu.png");
  arrow = IMG_Load("arrow.png");

  while(exit != 1)
  {
    switch(menu_position)
    {
      case 1: arrow_rect.y = menu_arrow_1_y;
              arrow_rect.x = menu_arrow_1_x;
              break;
      case 2: arrow_rect.y = menu_arrow_2_y;
              arrow_rect.x = menu_arrow_2_x;
              break;
      case 3: arrow_rect.y = menu_arrow_3_y;
              arrow_rect.x = menu_arrow_3_x;
              break;
      case 4: arrow_rect.y = menu_arrow_4_y;
              arrow_rect.x = menu_arrow_4_x;
              break;
      case 5: arrow_rect.y = menu_arrow_5_y;
              arrow_rect.x = menu_arrow_5_x;
              break;
      case 6: arrow_rect.y = menu_arrow_6_y;
              arrow_rect.x = menu_arrow_6_x;
              break;
    }

    SDL_BlitSurface(menu, NULL, screen, NULL);
    SDL_BlitSurface(arrow, NULL, screen, &arrow_rect);
    SDL_Flip(screen);

    enter = input_menu();

    if(menu_position < 1)
    {
      menu_position = 6;
    }
    else if(menu_position > 6)
    {
      menu_position = 1;
    }

    if(enter == 1)
    {
      switch(menu_position)
      {
        case 1: printf("Menu: Return to Game\n");
                draw_field();
                exit = 1;
                break;
        case 2: printf("Menu: New Game\n");
                new_game();
                draw_field();
                exit = 1;
                break;
        case 3: printf("Menu: Save Game: ");
                save();
                draw_field();
                exit = 1;
                break;
        case 4: printf("Menu: Load Game: ");
                load();
                draw_field();
                exit = 1;
                break;
        case 5: printf("Menu: Config\n");
                config();
                menu = IMG_Load("menu.png");
                arrow = IMG_Load("arrow.png");
                break;
        case 6: printf("Menu: Exit Game\n");
                SDL_FreeSurface(menu);
                SDL_FreeSurface(arrow);
                nexit();
                break;
      }
    }
  }

  SDL_FreeSurface(menu);
  SDL_FreeSurface(arrow);
  return;
}

void config()
{
  SDL_Surface *background = NULL;
  SDL_Surface *arrow      = NULL;
  SDL_Surface *img        = NULL;
  SDL_Rect arrow_rect;
  SDL_Rect img_rect;

  /* This is the arrow position */
  int menu_position_old = menu_position;

  /* If this var is set to 1 enter was pressed */
  int enter = 0;

  /* If this var is set to 1 the config menu will be quited */
  int exit = 0;

  /* set menu_position to 1 */
  menu_position = 1;

  /* Load arrow picture */
  arrow      = IMG_Load("arrow.png");

  /* Create Background picture */
  background = IMG_Load("config.png");
  img = IMG_Load("mode.png");
  img_rect.y = config_text_mode_y;
  img_rect.x = config_text_mode_x;
  SDL_BlitSurface(img, NULL, background, &img_rect);
  img = IMG_Load("resolution.png");
  img_rect.y = config_text_resolution_y;
  img_rect.x = config_text_resolution_x;
  SDL_BlitSurface(img, NULL, background, &img_rect);
  img = IMG_Load("fullscreen.png");
  img_rect.y = config_text_fullscreen_y;
  img_rect.x = config_text_fullscreen_x;
  SDL_BlitSurface(img, NULL, background, &img_rect);
  img = IMG_Load("exit.png");
  img_rect.y = config_text_exit_y;
  img_rect.x = config_text_exit_x;
  SDL_BlitSurface(img, NULL, background, &img_rect);

  while(exit == 0)
  {
    switch(menu_position)
    {
      case 1: arrow_rect.y = config_arrow_y_mode;
              arrow_rect.x = config_arrow_x_mode;
              break;
      case 2: arrow_rect.y = config_arrow_y_resolution;
              arrow_rect.x = config_arrow_x_resolution;
              break;
      case 3: arrow_rect.y = config_arrow_y_fullscreen;
              arrow_rect.x = config_arrow_x_fullscreen;
              break;
      case 4: arrow_rect.y = config_arrow_y_exit;
              arrow_rect.x = config_arrow_x_exit;
              break;
    }
    SDL_BlitSurface(background, NULL, screen, NULL);
    SDL_BlitSurface(arrow, NULL, screen, &arrow_rect);

    if(mode == 1)
    {
      img = IMG_Load("singleplayer.png");
    }
    else
    {
      img = IMG_Load("multiplayer.png");
    }

    img_rect.y = config_text_player_y;
    img_rect.x = config_text_player_x;
    SDL_BlitSurface(img, NULL, screen, &img_rect);
    SDL_Flip(screen);

    if(screen_width == 800)
    {
      img = IMG_Load("800x600.png");
    }
    else if(screen_width == 320)
    {
      img = IMG_Load("320x240.png");
    }

    img_rect.y = config_text_resolution_info_y;
    img_rect.x = config_text_resolution_info_x;
    SDL_BlitSurface(img, NULL, screen, &img_rect);
    SDL_Flip(screen);

    if(fullscreen == 1)
    {
      img = IMG_Load("on.png");
    }
    else if(fullscreen == 0)
    {
      img = IMG_Load("off.png");
    }

    img_rect.y = config_text_fullscreen_info_y;
    img_rect.x = config_text_fullscreen_info_x;
    SDL_BlitSurface(img, NULL, screen, &img_rect);
    SDL_Flip(screen);

    enter = input_menu();

    if(menu_position < 1)
    {
      menu_position = 4;
    }
    else if(menu_position > 4)
    {
      menu_position = 1;
    }

    if(enter == 1)
    {
      switch(menu_position)
      {
        case 1: printf("Conf: Switch Mode to ");
                if(mode == 1)
                {
                  mode = 2;
                  printf("Multiplayer\n");
                }
                else
                {
                  mode = 1;
                  printf("Singleplayer\n");
                }
                break;
        case 2: printf("Conf: Switch Resolution to ");
                if(screen_width == 320)
                {
                  printf("800 * 600\n");
                  chdir("../../");
                  switch_resolution();
                  config();
                  return;
                }
                else
                {
                  printf("320 * 240\n");
                  chdir("../../");
                  switch_resolution();
                  config();
                  return;
                }
                break;
        case 3: printf("Conf: Switch Fullscreen ");
                if(fullscreen == 0)
                {
                  if(SDL_WM_ToggleFullScreen(screen) == 1)
                  {
                    fullscreen = 1;
                  }
                  printf("On\n");
                }
                else
                {
                  if(SDL_WM_ToggleFullScreen(screen) == 1)
                  {
                    fullscreen = 0;
                  }
                  printf("Off\n");
                }
                break;
        case 4: exit = 1;
                break;
      }
    }

  }

  printf("Conf: Exit\n");
  menu_position = menu_position_old;
  img = IMG_Load("menu.png");
  SDL_BlitSurface(img, NULL, screen, NULL);
  SDL_Flip(screen);
  SDL_FreeSurface(background);
  SDL_FreeSurface(arrow);
  SDL_FreeSurface(img);
  return;
}
