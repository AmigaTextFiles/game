/*

Mures
Copyright (C) 2001 Adam D'Angelo

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

Contact information:

Adam D'Angelo
dangelo@ntplx.net
P.O. Box 1155
Redding, CT 06875-1155
USA

*/

#ifdef __MORPHOS__
const char *version_tag = "$VER: Mures 0.5a (19.09.2005)";
#endif

#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "SDL.h"
#include "types.h"
#include "map.h"
#include "output.h"
#include "main.h"
#include "pregame.h"
#include "game.h"
#include "root.h"
#include "game_output.h"
#include "game_input.h"
#include "gui.h"
#include "lua.h"

root_type root;

void root_quit()
{
  root.finished = 1;
}

Uint32 wait_frame(void)
{
  static Uint32 next_tick = 0;
  static Uint32 last_tick = 0;
  Uint32 this_tick, diff;
  
  this_tick = SDL_GetTicks();

  if(last_tick == 0)
    last_tick = this_tick;

  diff = this_tick - last_tick;
  last_tick = this_tick;

  if ( this_tick < next_tick )
    SDL_Delay(next_tick-this_tick);

  next_tick = this_tick + (1000/FRAMES_PER_SEC);

  return diff;
}

void run_game()
{
  Uint32 diff=0;
  int start_time, frame_count=0;
  int total_time=0, output_time=0, ai_time=0, sim_time=0;
  SDL_Event event;
  
  printf("Size of root is %d\n", sizeof(root));
  
  /*
    order:
    1. gui to select game options
     choose host
    2. gui for game room
     [connect to host]
     chat, form teams, etc.
     send game info, map
     wait for enough clients
     54321 countdown
     establish game connections
    3. start game
  */
  
  if(!lua_init()) {
    fprintf(stderr, "Unable to initialize lua.\n");
    exit(1);
  }
  
  if(!map_init()) {
    fprintf(stderr, "Couldn't initialize maps.\n");
    exit(1);
  }
  
  if(!game_input_init()) {
    fprintf(stderr, "Couldn't initialize game input.\n");
    exit(1);
  }
  
  /* start game */
  
  root.option.daemon = root.arg_option.daemon;
  root.option.fullscreen = root.arg_option.fullscreen;
  
  root.state = MENU;
  root.finished = 0;
  
  /* menu defaults */
  
  root.menu.ps.client = root.arg_option.client;
  root.menu.ps.host   = root.arg_option.host;
  root.menu.ps.server = root.arg_option.server;
  root.menu.ps.daemon = root.arg_option.daemon;
  root.menu.ps.teams  = root.arg_option.teams;
  root.menu.ps.local_player_count = root.arg_option.local_player_count;
  root.menu.ps.local_ai_count     = root.arg_option.local_ai_count;
  root.menu.ps.map = &(first_map(BATTLE)->map);
  root.menu.ps.type = BATTLE;
  
  menu_start(&root.menu);
  
  /*  root.menu.finished = 1;*/
  
  start_time = SDL_GetTicks();
  
  while(1) {
    diff = wait_frame();
    
    if(diff > MAX_STEP_SIZE)
      diff = MAX_STEP_SIZE;
    
    /* input */
    
    while(SDL_PollEvent(&event)) {
      if(event.type == SDL_QUIT)
	goto QUIT;
      
      if(event.type == SDL_KEYUP && event.key.keysym.sym == SDLK_q)
	goto QUIT;
      
      if(event.type == SDL_VIDEORESIZE) {
	output_resize_command(&root, event.resize.w, event.resize.h);
	continue;
      }
      
      if(event.type == SDL_KEYUP && event.key.keysym.sym == SDLK_PRINT) {
	output_screenshot();
	continue;
      }
      
      if(event.type == SDL_KEYUP && event.key.keysym.sym == SDLK_F4) {
	output_toggle_fs();
	continue;
      }
      
      gui_handle_event(event);
      
      if(root.state == GAME && !root.game.finished && !root.game.restart)
	game_handle_event(&root.game, event);

    }
    
    if(root.finished)
      goto QUIT;
    
    frame_count++;
    
    /* game step */
    
    if(root.state == GAME)
      game_step(&root.game, diff);
    
    if(root.state == GAME) {
      if(root.game.finished) {
	menu_start(&root.menu);
	root.state = MENU;
      }
	
      if(root.game.restart) {
	game_start(&root.game, &root.pregame.gs);
	root.state = GAME;
      }
    }
    
    if(root.state == PREGAME) {
      pregame_step(&root.pregame, diff);
      
      if(root.pregame.finished) {
	game_start(&root.game, &root.pregame.gs);
	root.state = GAME;
      }
    }
    
    if(root.state == MENU) {
      if(root.menu.finished) {
        pregame_start(&root.pregame, &root.menu.ps);
	root.state = PREGAME;
      }
    }
    
    /* output */
    
    if(!root.option.daemon)
      output_refresh(&root);
  }
  
 QUIT:

  total_time = SDL_GetTicks() - start_time;

  printf("took %.2f sec, %.1f%% output, %.1f%% ai, %.1f%% sim.\n", ((double)total_time)/1000, ((double)output_time*100)/total_time, ((double)ai_time*100)/total_time, ((double)sim_time*100)/total_time);
  printf(" %.1f fps\n", ((float)frame_count*1000)/total_time);

  game_input_exit();

  map_exit();

  lua_exit();

}

int main(int argc, char *argv[])
{
  int i;
  Uint32 sdl_options;

  root.arg_option.daemon = 0;
  root.arg_option.fullscreen = 1;
  root.arg_option.local_player_count = 1;
  root.arg_option.local_ai_count = 1;

#ifdef HAVE_GL
  opengl = 1;
#else
  opengl = 0;
#endif
  
  printf("Mures v.%s\n", VERSION);
  
  for(i=1; i<argc; i++) {
    if(!strcmp(argv[i], "--help")) {
      printf("Usage: %s [-s|-c host] [-d] [-nofs] [-hN] [-aiN] [-t] [--no3d]\n", argv[0]);
      exit(1);
    }
    
    if(!strcmp(argv[i], "--server") || !strcmp(argv[i], "-s")) {
      printf("Running server.\n");
      root.arg_option.server = 1;
    }
    
    if(i+1<argc)
      if(!strcmp(argv[i], "--client") || !strcmp(argv[i], "-c")) {
	root.arg_option.client = 1;
	root.arg_option.host = argv[i+1];
	printf("Being client to %s.\n", root.arg_option.host);
	i++;
      }
    
    if(!strcmp(argv[i], "--daemon") || !strcmp(argv[i], "-d")) {
      printf("Running as daemon.\n");
      root.arg_option.daemon = 1;
    }
    
    if(!strcmp(argv[i], "--nofullscreen") || !strcmp(argv[i], "-nofs")) {
      printf("Fullscreen disabled.\n");
      root.arg_option.fullscreen = 0;
    }
    
    if(!strcmp(argv[i], "--teams") || !strcmp(argv[i], "-t")) {
      printf("Using teams.\n");
      root.arg_option.teams = 1;
    }
    
    if(!strncmp(argv[i], "-h", 2))
      if(*(argv[i]+2)-'0' <= MAX_PLAYER && *(argv[i]+2)-'0' >= 0) {
	printf("Using %d humans.\n", *(argv[i]+2)-'0');
	root.arg_option.local_player_count = *(argv[i]+2)-'0';
      }
    
    if(!strncmp(argv[i], "-ai", 3))
      if(*(argv[i]+3)-'0' <= MAX_PLAYER && *(argv[i]+3)-'0' >= 0) {
	printf("Using %d computers.\n", *(argv[i]+3)-'0');
	root.arg_option.local_ai_count = *(argv[i]+3)-'0';
      }
    
    if(!strcmp(argv[i], "--no3d")) {
      printf("3D/OpenGL disabled.");
      opengl = 0;
    }
  }
  
  sdl_options = SDL_INIT_TIMER;
  sdl_options |= SDL_INIT_VIDEO; /* this is needed to pick up quit msgs from ctrl+c */
  sdl_options |= SDL_INIT_JOYSTICK;
  
  if(!root.arg_option.daemon) {
    sdl_options |= SDL_INIT_AUDIO;
  }
  
  if(SDL_Init(sdl_options) < 0) {
    fprintf(stderr, "Unable to initialize SDL: %s\n", SDL_GetError());
    exit(1);
  }
  atexit(SDL_Quit);
  
  if(!root.arg_option.daemon) {
    SDL_WM_SetCaption(APPNAME, APPNAME);
  }
  
  srand(time(NULL));
  
  if(!root.arg_option.daemon)
    output_init(root.arg_option.fullscreen);
  
  run_game();
  
  if(!root.arg_option.daemon)
    output_exit();
  
  return 0;
}
