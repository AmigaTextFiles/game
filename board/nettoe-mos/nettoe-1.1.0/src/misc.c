/* netToe Version 1.1.0
 * Release date: 22 July 2001
 * Copyright 2000,2001 Gabriele Giorgetti <g.gabriele@europe.com>
 *		
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#ifdef HAVE_CONFIG_H
#  include <config.h>
#endif
 

#include "game.h"
#include "misc.h"
#include "terminal.h"


int who_start_first (void)
{
  int generated_number;

  srand (time (0));
  generated_number = 1 + (int) (10.0 * rand () / (RAND_MAX + 1.0));

  if ((generated_number == 2) | (generated_number == 4) | (generated_number == 6) | (generated_number == 8) | (generated_number == 10))
    {
      return 1;
    }
 
  return 2;
}

int check_pname(const char *pname, int maxlen)
{
   if((strlen(pname)) > maxlen)
     return 1;
   
   if(pname == NULL)
     return 1;
   
   return 0;
}

void beep ( void )
{

   if (NO_BEEP != 1)
      printf("\a");

}
   

void print_infos_screen (void)
{
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf(" netToe is a Tic Tac Toe-like game for Linux and UNIX.    \n");
  printf(" It is possible to play it against the computer, another  \n");
  printf(" player on the same PC, or against another player over the\n");
  printf(" Net (Internet, and everything that uses TCP/IP).         \n");
  printf(" To play it over the network you must first set up a host.\n");
  printf(" This is done in the network game options menu, selecting \n");
  printf(" \"Host the game\". Now the second player on the otherside\n");
  printf(" must connect to the host typing the host's IP address.   \n");
  printf(" That should be enought for you to have (i hope) fun with.\n");
  printf(" For a detailed guide on HOW TO PLAY and other infos type:\n");
  printf(" man nettoe 						    \n\n");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf(" ------                                                   \n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf(" netToe %s                                                \n", VERSION);
  printf(" Copyright 2000,2001 Gabriele Giorgetti %s\n", AUTHOR_EMAIL);
  printf(" %s                           \n", HOMEPAGE);
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf("\nPress");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf(" enter");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf(" to go back to the main menu.\n");
   
  fflush (stdin);

  getchar ();
  getchar ();

  nettoe_term_set_default_color();
}

void parse_cmd_args (int argc, char *argv[])
{
   int i;

   if (argc < 2)
     return;

  for (i = 1; i <= argc - 1; i++)
    {

 if ( (!strcmp(argv[i], "-h")) || (!strcmp(argv[i], "--help")) )
     {
         fprintf(stdout, "netToe %s the enhanced, networked, Tic Tac Toe game.\n", VERSION);
         fprintf(stdout, "\n");
         fprintf(stdout, "usage: nettoe [OPTIONS]\n");
         fprintf(stdout, "\n");
         fprintf(stdout, "-nb, --no-beep   disable beeps\n");
	 fprintf(stdout, "-nc, --no-colors disable colors\n");
         fprintf(stdout, "-h,  --help      display this help and exit\n");
         fprintf(stdout, "-v,  --version   output version information and exit\n");
         fprintf(stdout, "\n");
         fprintf(stdout, "The netToe project can be found at: %s\n", HOMEPAGE);
         fprintf(stdout, "\n");
         fprintf(stdout, "Please send any bug reports, or comments to:\n");
         fprintf(stdout, "Gabriele Giorgetti %s\n", AUTHOR_EMAIL);
         
         exit(EXIT_SUCCESS);
     }

  else if ( (!strcmp(argv[i], "-v")) || (!strcmp(argv[i], "--version")) )
    {
         fprintf(stdout, "netToe %s (%s)\n", VERSION, RELEASE_DATE);
         fprintf(stdout, "\n");
         fprintf(stdout, "Written by Gabriele Giorgetti %s\n", AUTHOR_EMAIL);
         fprintf(stdout, "Copyright 2000,2001 Gabriele Giorgetti\n");
         fprintf(stdout, "\n");
         fprintf(stdout, "This software is released under the GNU GPL.\n");

         exit(EXIT_SUCCESS);
    }

  else if ( (!strcmp(argv[i], "-nb"))  || (!strcmp(argv[i], "--no-beep")) )
    {
       NO_BEEP = 1;
       return;
    }
  else if ( (!strcmp(argv[i], "-nc"))  || (!strcmp(argv[i], "--no-colors")) )
    {
       NO_COLORS = 1;
       return;
    }

  else
    {
       fprintf(stdout, "%s: unrecognized option `%s'\n", argv[0], argv[i]);
       fprintf(stdout, "Try `%s --help' for more information.\n", argv[0]);

       exit (EXIT_SUCCESS);
    }
  }

  return;
}


