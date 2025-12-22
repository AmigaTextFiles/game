#ifdef WIN32
#include <windows.h>
#endif
#include <GL/gl.h>
#include <GL/glu.h>
#include <SDL/SDL.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <errno.h>

#include <SDL/SDL_ttf.h>

#include "share.h"
#include "polices.h"
#include "volet.h"
#include "carte.h"
#include "editeur.h"
#include "ch_tout.h"

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

extern int TabParamBonus[NUM_BONUS];

void fill_default_options()
{

}

int read_config_file()
{
  FILE *cfg_file;
  char buff[512];

  printf("Reading configuration file...\n");
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

	  if (strstr(buff, "shmixgum=") == buff)
	    {
	      TabParamBonus[0] = atoi(buff + 9);
	      if (TabParamBonus[0] < 0)
		TabParamBonus[0] = 10;
	    }

	  else if (strstr(buff, "shield=") == buff)
	    {
	      TabParamBonus[2] = atoi(buff + 7);
	      if (TabParamBonus[2] < 0)
		TabParamBonus[2] = 10;
	    }

	  else if (strstr(buff, "shockwave=") == buff)
	    {
	      TabParamBonus[4] = atoi(buff + 10);
	      if (TabParamBonus[4] < 0)
		TabParamBonus[4] = 6;
	    }

	  else if (strstr(buff, "stoptime=") == buff)
	    {
	      TabParamBonus[5] = atoi(buff + 9);
	      if (TabParamBonus[5] < 0)
		TabParamBonus[5] = 10;
	    }

	  else if (strstr(buff, "ultrapoints=") == buff)
	    {
	      TabParamBonus[6] = atoi(buff + 12);
	      if (TabParamBonus[6] < 0)
		TabParamBonus[6] = 10;
	    }

	  else if (strstr(buff, "freeze=") == buff)
	    {
	      TabParamBonus[7] = atoi(buff + 7);
	      if (TabParamBonus[7] < 0)
		TabParamBonus[7] = 10;
	    }

	  else if (strstr(buff, "highspeed=") == buff)
	    {
	      TabParamBonus[8] = atoi(buff + 10);
	      if (TabParamBonus[8] < 0)
		TabParamBonus[8] = 10;
	    }

	  else if (strstr(buff, "luck=") == buff)
	    {
	      TabParamBonus[9] = atoi(buff + 5);
	      if (TabParamBonus[9] < 0)
		TabParamBonus[9] = 10;
	    }

	  else if (strstr(buff, "night=") == buff)
	    {
	      TabParamBonus[10] = atoi(buff + 6);
	      if (TabParamBonus[10] < 0)
		TabParamBonus[10] = 10;
	    }

	  else if (strstr(buff, "loosebonus=") == buff)
	    {
	      TabParamBonus[11] = atoi(buff + 11);
	      if (TabParamBonus[11] < 0)
		TabParamBonus[11] = 10;
	    }

	  else if (strstr(buff, "invertkeys=") == buff)
	    {
	      TabParamBonus[12] = atoi(buff + 11);
	      if (TabParamBonus[12] < 0)
		TabParamBonus[12] = 10;
	    }

	  else if (strstr(buff, "ceiling=") == buff)
	    {
	      TabParamBonus[13] = atoi(buff + 8);
	      if (TabParamBonus[13] < 0)
		TabParamBonus[13] = 10;
	    }

	  else if (strstr(buff, "fog=") == buff)
	    {
	      TabParamBonus[14] = atoi(buff + 4);
	      if (TabParamBonus[14] < 0)
		TabParamBonus[14] = 10;
	    }

	  else if (strstr(buff, "malusmap=") == buff)
	    {
	      TabParamBonus[15] = atoi(buff + 9);
	      if (TabParamBonus[15] < 0)
		TabParamBonus[15] = 10;
	    }

	  else if (strstr(buff, "negativeboxes=") == buff)
	    {
	      TabParamBonus[16] = atoi(buff + 14);
	      if (TabParamBonus[16] < 0)
		TabParamBonus[16] = 10;
	    }

	  else if (strstr(buff, "freezeshx=") == buff)
	    {
	      TabParamBonus[17] = atoi(buff + 10);
	      if (TabParamBonus[17] < 0)
		TabParamBonus[17] = 10;
	    }

	  else if (strstr(buff, "lowspeed=") == buff)
	    {
	      TabParamBonus[18] = atoi(buff + 9);
	      if (TabParamBonus[18] < 0)
		TabParamBonus[18] = 10;
	    }

	  else if (strstr(buff, "hazard=") == buff)
	    {
	      TabParamBonus[19] = atoi(buff + 7);
	      if (TabParamBonus[19] < 0)
		TabParamBonus[19] = 10;
	    }

	  else if (strstr(buff, "num_lives=") == buff)
	    {
	      //TabParamBonus[19] = atoi(buff + 10);
	      //if (TabParamBonus[19] < 0)
		//TabParamBonus[19] = 10;
	    }

	  else if (strstr(buff, "time_limit=") == buff)
	    {
	      //TabParamBonus[19] = atoi(buff + 11);
	      //if (TabParamBonus[19] < 0)
		//TabParamBonus[19] = 10;
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

    fprintf(cfg_file, "# MangoPeeler (MangoQuest map editor) options file\n\n");

    fprintf(cfg_file, "# Bonus parameters : default values\n\n# bonus\n");
    fprintf(cfg_file,"shmixgum=%d\n",TabParamBonus[0]);
//    fprintf(cfg_file,"life=%d\n",TabParamBonus[1]);
    fprintf(cfg_file,"shield=%d\n",TabParamBonus[2]);
//    fprintf(cfg_file,"armaggedon=%d\n",TabParamBonus[3]);
    fprintf(cfg_file,"shockwave=%d\n",TabParamBonus[4]);
    fprintf(cfg_file,"stoptime=%d\n",TabParamBonus[5]);
    fprintf(cfg_file,"ultrapoints=%d\n",TabParamBonus[6]);
    fprintf(cfg_file,"freeze=%d\n",TabParamBonus[7]);
    fprintf(cfg_file,"highspeed=%d\n",TabParamBonus[8]);
    fprintf(cfg_file,"luck=%d\n\n",TabParamBonus[9]);

    fprintf(cfg_file,"# malus\n");
    fprintf(cfg_file,"night=%d\n",TabParamBonus[10]);
//    fprintf(cfg_file,"loosebonus=%d\n",TabParamBonus[11]);
    fprintf(cfg_file,"invertkeys=%d\n",TabParamBonus[12]);
    fprintf(cfg_file,"ceiling=%d\n",TabParamBonus[13]);
    fprintf(cfg_file,"fog=%d\n",TabParamBonus[14]);
    fprintf(cfg_file,"malusmap=%d\n",TabParamBonus[15]);
    fprintf(cfg_file,"negativeboxes=%d\n",TabParamBonus[16]);
    fprintf(cfg_file,"freezeshx=%d\n",TabParamBonus[17]);
    fprintf(cfg_file,"lowspeed=%d\n",TabParamBonus[18]);
    fprintf(cfg_file,"hazard=%d\n",TabParamBonus[19]);

    //fprintf(cfg_file, "# Other parameters : default values\n\n");
    //fprintf(cfg_file,"num_lives=%d\n",3);
    //fprintf(cfg_file,"time_limit=%d\n",0);
    fclose (cfg_file); 
  }
  return 0;
}
