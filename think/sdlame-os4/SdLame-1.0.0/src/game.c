#include <SDL.h>
#include <SDL_events.h>
#include <SDL_image.h>
#include <SDL_ttf.h>
#include <SDL_mixer.h>
#include <SDL_thread.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "sdlame.h"
#include "vars.h"

void fill_array(int number)
{
  int x=1;   //counter row (-)
  int y=1;   //counter col (|)

  while(y <= 8)
  {
    field[x][y] = number;
    x++;

    if(x > 8)
    {
      y++;
      x = 1;
    }
  }
}

void new_game()
{
  fill_array(0);

  //player White
  field[2][1] = 1;
  field[4][1] = 1;
  field[6][1] = 1;
  field[8][1] = 1;
  field[1][2] = 1;
  field[3][2] = 1;
  field[5][2] = 1;
  field[7][2] = 1;
  field[2][3] = 1;
  field[4][3] = 1;
  field[6][3] = 1;
  field[8][3] = 1;

  //player Black
  field[1][6] = 3;
  field[3][6] = 3;
  field[5][6] = 3;
  field[7][6] = 3;
  field[2][7] = 3;
  field[4][7] = 3;
  field[6][7] = 3;
  field[8][7] = 3;
  field[1][8] = 3;
  field[3][8] = 3;
  field[5][8] = 3;
  field[7][8] = 3;

  //other data
  player = 1;        //player white begins (white = user)
  player_white = 8;  //Player 1: Unit numbers
  player_black = 8;  //Player 2: Unit numbers
  cursor_x = 1;      //set the cursor
  cursor_y = 1;      //set the cursor
  moved_k  = 0;      //no unit moved so far
}

void move_cursor(char direction)
{
  if(direction == 'l')
  {
    if(cursor_x > 1)
    {
      cursor_x--;
    }
    else
    {
      cursor_x = 8;
    }
  }
  else if(direction == 'd')
  {
    if(cursor_y > 8)
    {
      cursor_y = 1;
    }
    else
    {
      cursor_y++;
    }
  }
  else if(direction == 'r')
  {
    if(cursor_x < 8)
    {
      cursor_x++;
    }
    else
    {
      cursor_x = 1;
    }
  }
  else if(direction == 'u')
  {
    if(cursor_y > 1)
    {
      cursor_y--;
    }
    else
    {
      cursor_y = 8;
    }
  }
}

int unit_info(int id)
{
  int x=0, y=0;
  x = id % 8;
  if(x == 0){x = 8;}
  y = ((id - x) / 8) +1;

  int move = 0;

  /* Test if unit can move to the next field */

  if(x != 8 && x != 1)
  {
    if((field[(x+1)][(y-1)] == 0) || (field[(x-1)][(y-1)] == 0))
    {
      move = 1;
    }
    else
    {
      move = 0;
    }
  }
  else if(x == 1)
  {
    if((field[(x+1)][(y-1)] == 0))
    {
      move = 1;
    }
    else
    {
      move = 0;
    }
  }
  else
  {
    if((field[(x-1)][(y-1)] == 0))
    {
      move = 1;
    }
    else
    {
      move = 0;
    }
  }

  return move;
}

void nexit()
{
  SDL_Quit();

  if(GP2X_MODE == 0)
  {
    exit(EXIT_SUCCESS);
  }
  else
  {
    chdir("/usr/gp2x");
    execl("/usr/gp2x/gp2xmenu", "/usr/gp2x/gp2xmenu", NULL);
    exit(EXIT_SUCCESS);
  }
}

void save()
{
  FILE *fh;
  char tmp[2];
  int x=1, y=1;

  fh = fopen(SAVEFILE, "w");

  /* Save field data */
  while(y <= 8)
  {
    sprintf(tmp,"%d",field[x][y]);
    fputs(tmp, fh);
    x++;

    if(x > 8)
    {
      x = 1;
      y++;
      fputs("\n", fh);
    }
  }

  sprintf(tmp,"%d",player);
  fputs(tmp, fh);

  sprintf(tmp,"%d",player_white);
  fputs(tmp, fh);

  sprintf(tmp,"%d",player_black);
  fputs(tmp, fh);

  sprintf(tmp,"%d",moved_x);
  fputs(tmp, fh);

  sprintf(tmp,"%d",moved_y);
  fputs(tmp, fh);

  sprintf(tmp,"%d",moved_k);
  fputs(tmp, fh);

  sprintf(tmp,"%d",beat_k);
  fputs(tmp, fh);

  fclose(fh);
  printf("OK!\n");
  return;
}

void load()
{
  FILE *fh;
  int x=1, y=1;
  char puffer[1];
  int test = 0;

  fh = fopen(SAVEFILE, "r");

  /* Load field data */
  while(y <= 8)
  {
    fread(&puffer, sizeof(char), 1, fh);

    if(x <= 8)
    {
      sscanf(puffer, "%d", &test);
      field[x][y] = test;
    }

    x++;

    if(x > 9)
    {
      x = 1;
      y++;
    }
  }

  fread(&puffer, sizeof(char), 1, fh);
  sscanf(puffer, "%d", &test);
  player = test;

  fread(&puffer, sizeof(char), 1, fh);
  sscanf(puffer, "%d", &test);
  player_white = test;

  fread(&puffer, sizeof(char), 1, fh);
  sscanf(puffer, "%d", &test);
  player_black = test;

  fread(&puffer, sizeof(char), 1, fh);
  sscanf(puffer, "%d", &test);
  moved_x = test;

  fread(&puffer, sizeof(char), 1, fh);
  sscanf(puffer, "%d", &test);
  moved_y = test;

  fread(&puffer, sizeof(char), 1, fh);
  sscanf(puffer, "%d", &test);
  moved_k = test;

  fread(&puffer, sizeof(char), 1, fh);
  sscanf(puffer, "%d", &test);
  beat_k = test;

  fclose(fh);
  printf("OK!\n");
  return;
}

int is_black(int x, int y)
{
  if(
    ((((x + 8 * y) % 2) != 0) && ((y % 2) == 0)) || 
    ((((x + 8 * y) % 2) == 0) && ((y % 2) != 0)) 
  )
  {
    return 1;
  }
  else
  {
    return 0;
  }
}

int is_diagonally(int start_x, int start_y, int end_x, int end_y)
{
  int a, b;

  if(start_x > end_x)
  {
    a = start_x - end_x;
  }
  else
  {
    a = end_x - start_x;
  }

  if(start_y > end_y)
  {
    b = start_y - end_y;
  }
  else
  {
    b = end_y - start_y;
  }

  if(a == b)
  {
    return TRUE;
  }
  else
  {
    return FALSE;
  }
}

BOOL is_moveable(int start_x, int start_y, int end_x, int end_y, int count,
                 int last)
{
  int tmp;
  int sign_x = end_x - start_x;
  int sign_y = end_y - start_y;

  count++;

  if(sign_x < 0)
  {
    sign_x = -1 * count;
  }
  else if(sign_x > 0)
  {
    sign_x = count;
  }

  if(sign_y < 0)
  {
    sign_y = -1 * count;
  }
  else if(sign_y > 0)
  {
    sign_y = count;
  }

  tmp = field[(start_x + sign_x)][(start_y + sign_y)];

  if((player == 1) && (tmp == 1 || tmp == 2))
  {
    output("You can't beat your units!");
    return FALSE;
  }
  else if((player == 2) && (tmp == 3 || tmp == 4))
  {
    output("You can't beat your units!");
    return FALSE;
  }

  if(last != 0 && tmp != 0)
  {
    output("You can't beat units tandemly!");
    return FALSE;
  }

  if((start_x + sign_x) == end_x)
  {
    return TRUE;
  }

  return is_moveable(start_x, start_y, end_x, end_y, count, tmp);
}

void switch_resolution()
{
  if(screen_width == 320)
  {
    /* Screen info */
    screen_width = 800;
    screen_height = 600;
    screen_depth = 16;

    /* field info */
    field_start_x = 200;
    field_start_y = 100;
    place_size = 50;

    /* menu positions */
    menu_arrow_1_x = 240;
    menu_arrow_1_y = 325;
    menu_arrow_2_x = 240;
    menu_arrow_2_y = 358;
    menu_arrow_3_x = 240;
    menu_arrow_3_y = 385;
    menu_arrow_4_x = 240;
    menu_arrow_4_y = 410;
    menu_arrow_5_x = 240;
    menu_arrow_5_y = 440;
    menu_arrow_6_x = 240;
    menu_arrow_6_y = 495;

    /* loading positions */
    loading_y = 475;
    loading_h = 80;
    loading_x = 152;
    loading_w = 7;

    /* config positions */
    config_arrow_x_mode = 125;
    config_arrow_y_mode = 130;
    config_arrow_x_resolution = 125;
    config_arrow_y_resolution = 160;
    config_arrow_x_fullscreen = 125;
    config_arrow_y_fullscreen = 190;
    config_arrow_x_exit = 125;
    config_arrow_y_exit = 500;
    config_text_mode_x = 160;
    config_text_mode_y = 135;
    config_text_resolution_x = 160;
    config_text_resolution_y = 165;
    config_text_fullscreen_x = 160;
    config_text_fullscreen_y = 195;
    config_text_exit_x = 160;
    config_text_exit_y = 505;
    config_text_player_x = 480;
    config_text_player_y = 135;
    config_text_resolution_info_x = 480;
    config_text_resolution_info_y = 160;
    config_text_fullscreen_info_x = 480;
    config_text_fullscreen_info_y = 190;

    /* ingame textbox */
    info_text_x = 0;
    info_text_w = 800;
    info_text_y = 575;
    info_text_h = 20;
    font_size = 16;

    chdir("img/800x600/");
    screen = SDL_SetVideoMode(screen_width, screen_height, screen_depth, SDL_SWSURFACE);
    font = TTF_OpenFont("font.ttf", font_size);
  }
  else //set to 320x240
  {
    /* Screen info */
    screen_width = 320;
    screen_height = 240;
    screen_depth = 16;

    /* field info */
    field_start_x = 110;
    field_start_y = 10;
    place_size = 25;

    /* menu positions */
    menu_arrow_1_x = 70;
    menu_arrow_1_y = 122;
    menu_arrow_2_x = 70;
    menu_arrow_2_y = 138;
    menu_arrow_3_x = 70;
    menu_arrow_3_y = 154;
    menu_arrow_4_x = 70;
    menu_arrow_4_y = 169;
    menu_arrow_5_x = 70;
    menu_arrow_5_y = 186;
    menu_arrow_6_x = 70;
    menu_arrow_6_y = 202;

    /* loading positions */
    loading_y = 190;
    loading_h = 32;
    loading_x = 61;
    loading_w = 3;

    /* config positions */
    config_arrow_x_mode = 50;
    config_arrow_y_mode = 50;
    config_arrow_x_resolution = 50;
    config_arrow_y_resolution = 70;
    config_arrow_x_fullscreen = 50;
    config_arrow_y_fullscreen = 90;
    config_arrow_x_exit = 50;
    config_arrow_y_exit = 190;
    config_text_mode_x = 90;
    config_text_mode_y = 61;
    config_text_resolution_x = 90;
    config_text_resolution_y = 81;
    config_text_fullscreen_x = 90;
    config_text_fullscreen_y = 101;
    config_text_exit_x = 90;
    config_text_exit_y = 200;
    config_text_player_x = 150;
    config_text_player_y = 61;
    config_text_resolution_info_x = 180;
    config_text_resolution_info_y = 81;
    config_text_fullscreen_info_x = 180;
    config_text_fullscreen_info_y = 101;

    /* ingame textbox */
    info_text_x = 0;
    info_text_w = 320;
    info_text_y = 220;
    info_text_h = 20;
    font_size = 16;

    chdir("img/320x240/");
    screen = SDL_SetVideoMode(screen_width, screen_height, screen_depth, SDL_SWSURFACE);
    font = TTF_OpenFont("font.ttf", font_size);
  }
}

int id_to_y_cord(int id)
{
  return ((int) id / 8) +1;
}
int id_to_x_cord(int id)
{
  return (id % 8);
}
