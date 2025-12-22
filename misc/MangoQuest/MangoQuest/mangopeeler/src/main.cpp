/*  The Blue Mango Quest : Mango Peeler
 *  Copyright (c) Clément 'phneutre' Bourdarias (code)
 *                   email: phneutre@users.sourceforge.net
 *                Guillaume 'GuBuG' Burlet (graphics)
 *                   email: gubug@users.sourceforge.net
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Library General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#ifdef WIN32
#include <windows.h>
#include "shxedit_win32.h"
#endif
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <SDL/SDL.h>
#include <SDL/SDL_ttf.h>

#include "share.h"
#include "main.h"
#include "polices.h"
#include "volet.h"
#include "carte.h"

#include "editeur.h"
#include "ch_tout.h"

#include "file_utils.h"

int set_size = 0, size = 0;
int set_world = 0, world = 0;
char *nomFichier = 0;

void usage_error(void)
{
  fprintf(stderr, "Usage:  shxedit  [options] [fichier] ..\n\n");
  fprintf(stderr,
          "Options:\n" " -s    size of the map (14/20/28)\n"
          " -w    world of the map (0/1/2/3)\n\n");
  exit(1);
}

#define GET_NUMBER(flag,num)	num = 0; \
				if (!*p && argc && isdigit(**argv)) \
					p = *argv++, --argc; \
				while (isdigit(*p)) { \
					flag = 1; \
					num = (num * 10) + (*p++ - '0'); \
				}

SDL_Surface *ecran;

void analyseArguments(int argc, char *argv[])
{
  char c, *p;

  ++argv;

  if (!--argc)
  {
    // Aucun argument donné 
    nomFichier = new char[MAX_PATH];
    printf("No filename given, we use default.bmq for basename...\n");
    get_private_map_file_name( nomFichier, "default.bmq", MAX_PATH );
    printf("Using %s for complete file path.\n", nomFichier);

    size = 20;
    world = 0;
  }
  while (argc--)
  {
    p = *argv++;
    if (*p == '-')
    {
      if (!*++p)                // argument incomplet
        usage_error();
      while ((c = *p++))
      {
        switch (c)
        {

        case 'v':
          fprintf(stdout, "MangoPeeler version %s\n", VERSION);
          exit(0);
          break;

        case 's':
          GET_NUMBER(set_size, size);
          if ((size != 14) && (size != 20) && (size != 28))
          {
            usage_error();
          }
          break;

        case 'w':
          GET_NUMBER(set_world, world);
          if ((world != 0) && (world != 1) && (world != 2)&& (world != 3))
          {
            usage_error();
          }
          break;

        case 'h':

        default:
          usage_error();
        }
      }
      if (!argc)
      {
        // Aucun nom du fichier donné
        nomFichier = new char[MAX_PATH];
	printf("No filename given, we use default.bmq for basename...\n");
	get_private_map_file_name( nomFichier, "default.bmq", MAX_PATH );
	printf("Using %s for complete file path.\n", nomFichier);

      }

    }
    else
    {
      nomFichier = new char[MAX_PATH];
      printf("Filename is given.\n");
      search_map_file( nomFichier, p, MAX_PATH );
    }
  }

  if (!(set_size))
  {                             // la taille n'a pas été définie
    size = 20;
    set_size = 1;
  }

  if (!(set_world))
  {                             // monde pas defini
    world = 0;
    set_world = 1;
  }
}

int main(int argc, char *argv[])
{
  printf
    ("\nMangoPeeler - Level editor for MangoQuest - version %s\n\n",
     VERSION);

  analyseArguments(argc, argv);

  SDL_Surface *icone;

  initialise_sdl();
  atexit(SDL_Quit);
  check_private_dir();

  mode_video();

  icone = SDL_LoadBMP(SHXEDIT_DATA "icone.bmp");
  SDL_WM_SetIcon(icone, NULL);

  charge_tout(size, world, nomFichier);
  loop_moi_ca();
  detruit_tout();

  TTF_Quit();
  SDL_Quit();
  return 0;
}

void initialise_sdl()
{
  if (SDL_Init(SDL_INIT_VIDEO) < 0)
  {
    fprintf(stderr, "Erreur (SDL) : %s\n", SDL_GetError());
    exit(1);
  }
  SDL_WM_SetCaption("MangoPeeler v." VERSION
                    " - Level editor for MangoQuest", 0);

  if (TTF_Init() < 0)
  {
    fprintf(stderr, "Erreur (TTF) : %s\n", SDL_GetError());
    exit(2);
  }

  if ( ( SDL_EnableKeyRepeat( 100, SDL_DEFAULT_REPEAT_INTERVAL ) ) )
    {
      fprintf( stderr, "Setting keyboard repeat failed: %s\n",
	       SDL_GetError( ) );
      exit( 1 );
    }

}

void mode_video()
{
  if (!(ecran = SDL_SetVideoMode(1024, 768, 16, SDL_HWSURFACE)))
  {
    fprintf(stderr, "Erreur (SDL) : %s\n", SDL_GetError());
    exit(1);
  }
}
