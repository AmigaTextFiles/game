#ifdef WIN32
#include <windows.h>
#endif
#include <GL/gl.h>
#include <GL/glu.h>
#include <SDL/SDL.h>

#ifdef HAVE_SDL_MIXER
# include <SDL/SDL_mixer.h>
# include "sounds.h"
#endif

#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <errno.h>

#include "world_geometry.h"
#include "world_building.h"
#include "map.h"
#include "timers.h"
#include "hut.h"
#include "bonus.h"
#include "mango.h"
#include "game_loop.h"
#include "system_gl.h"

#ifndef WIN32
#   include <unistd.h>
#   include <sys/types.h>
#   include <pwd.h>
#   include <dirent.h>
#   include <sys/time.h>
#   include <sys/types.h>
#   include <dirent.h>
#endif

#include "file_utils.h"
#include "config_file.h"

extern options_t *options;
extern int nosound_flag;

void fill_default_options()
{
  options->proximity_setting=5;

  options->mouse_smooth=20;
  options->mouse_sens_pre = 3;
  options->mouse_sens_post = 1;
  options->is_mouse_y = 0;

  if (nosound_flag) 
    options->use_sound=0;
  else options->use_sound=1;
  options->sound_volume = 100;
  options->music_volume = 80;

#ifdef WIN32
  options->fullscreen = 1;
#else
  options->fullscreen = 1;
#endif

  options->alternate_controls=0;
}

int read_config_file()
{
  FILE *cfg_file;
  char buff[512];

  cfg_file = open_config_file("r");
  
  if (cfg_file == NULL) {
    printf("file does not exist.\n");
    printf(" Creating default configuration file... ");
    write_config_file();
    printf("done!\n");
    return 0;
  }

  else {
    do {
      fgets(buff, sizeof(buff), cfg_file);
      if (!feof(cfg_file))
	{
	  buff[strlen(buff)-1] = '\0';

	  if (strstr(buff, "proximity_warning=") == buff)
		{
		  options->proximity_setting = atoi(buff + 18);
		  if (options->proximity_setting < 0 || options->proximity_setting > 15 )
		    options->proximity_setting = 0;
		}

	  else if (strstr(buff, "fullscreen=") == buff)
		{
		  options->fullscreen = atoi(buff + 11);
		  if (options->fullscreen < 0 || options->fullscreen > 1 )
		    options->fullscreen = 0;
		}

	  else if (strstr(buff, "mouse_smooth=") == buff)
		{
		  options->mouse_smooth = atoi(buff + 13);
		  if (options->mouse_smooth < 0 || options->mouse_smooth > 50)
		    options->mouse_smooth = 25;
		}

	  else if (strstr(buff, "mouse_sensivity=") == buff)
		{
		  options->mouse_sens_pre = atoi(buff + 16);
		  if (options->mouse_sens_pre <= 0)
		    options->mouse_sens_pre = 1;
		}

	  else if (strstr(buff, "mouse_y_axis=") == buff)
	    {
	      options->is_mouse_y = atoi(buff + 13);
	      if ((options->is_mouse_y != 0)&&(options->is_mouse_y != 1))
		    options->is_mouse_y = 0;
	    }

	  else if (strstr(buff, "sound_volume=") == buff)
		{
		  options->sound_volume = atoi(buff + 13);
		  if (options->sound_volume < 0 || options->sound_volume > 100 )
		    options->sound_volume = 100;
		}

	  else if (strstr(buff, "music_volume=") == buff)
		{
		  options->music_volume = atoi(buff + 13);
		  if (options->music_volume < 0 || options->music_volume > 100 )
		    options->music_volume = 80;
		}

	  else if (strstr(buff, "alternate_controls=") == buff)
		{
		  options->alternate_controls = atoi(buff + 19);
		  if (options->alternate_controls < 0 
		      || options->alternate_controls > 1 )
		    options->alternate_controls=0;;
		}

	}

    }
    while(!feof(cfg_file));


    fclose (cfg_file);

    write_config_file();
  }
  return 0;
}

int write_config_file()
{
  FILE *cfg_file;
  cfg_file = open_config_file("w");
  if (cfg_file == NULL) {
    fprintf(stderr, " Error: couldn't open config file for writing\n");
    return 1;
  }
  else {

    fprintf(cfg_file, "# MangoQuest options file\n\n");

    fprintf(cfg_file, "# Gameplay options\n");
    fprintf(cfg_file, "# Proximity warning : be warned when a nasty shmollux is too close to you\n");
    fprintf(cfg_file, "# Specify the value in game units (1 square <-> 3 game units x 3 game units)\n");
    fprintf(cfg_file, "# A value of 0 means that it is disabled\n");
    fprintf(cfg_file, "proximity_warning=%d\n\n",options->proximity_setting);

    fprintf(cfg_file, "# Video options\n");
    fprintf(cfg_file, "fullscreen=%d\n\n",options->fullscreen);

    fprintf(cfg_file, "# Mouse options\n");
    fprintf(cfg_file, "# Smoothed mouse : recommended (between 0 and 50)\n");
    fprintf(cfg_file, "mouse_smooth=%d\n",options->mouse_smooth);

    fprintf(cfg_file, "# X-axis and Y-axis sensitivity\n");
    fprintf(cfg_file, "mouse_sensivity=%d\n",options->mouse_sens_pre);

    fprintf(cfg_file, "# Do we use Y axis for up/down freelook ? 0:no, 1:yes\n");
    fprintf(cfg_file, "mouse_y_axis=%d\n\n",options->is_mouse_y);
    
    fprintf(cfg_file, "# Audio options : values between 0%% and 100%%\n");
    fprintf(cfg_file, "sound_volume=%d\n",options->sound_volume);
    fprintf(cfg_file, "music_volume=%d\n\n",options->music_volume);

    fprintf(cfg_file, "# Alternate controls: use arrows to rotate instead of sideways\n");
    fprintf(cfg_file, "# Use Alt+arrows for sideways\n");
    fprintf(cfg_file, "# 1: enabled, 0: disabled\n");
    fprintf(cfg_file, "# Controls will be customizable in future versions in Options menu\n");
    fprintf(cfg_file, "alternate_controls=%d\n",options->alternate_controls);

    fclose (cfg_file); 
    printf("Config file wrote successfully\n");
  
  }
  return 0;
}
