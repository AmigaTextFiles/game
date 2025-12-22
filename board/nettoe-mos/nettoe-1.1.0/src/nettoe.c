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

#include "terminal.h"
/* #include "matrices.h" New Code for the nettoe board matrix, not used yet */
#include "misc.h"
#include "network.h"
#include "game.h"


char c11, c12, c13;
char c21, c22, c23;
char c31, c32, c33;

char player1_name[20];
char player2_name[20];

int game_mode = 0;
int who_starts = 0;
int computer_AI = 0;
int winner = 0;

int player1_status  = 0;
int player2_status  = 0;
int computer_status = 0;

int server_write_sock;
int server_read_sock;
int client_write_sock;
int client_read_sock;

void main_menu (void);
void print_header (int type);
void init_matrix (void);
void init_1_player_game (void);
void init_2_player_game (void);
void show_game (void);
void get_player1_move (void);
void get_player2_move (void);
void get_cpu_AI (void);
void get_cpu_normal_move (void);
void get_cpu_hard_move (void);
int game_check (void);
void network_options (void);
int server_start (void);
void client_start (void);
void init_server_network_game (void);
void init_client_network_game (void);

void net_game_send_server_matrix ( void );
void net_game_recv_server_matrix ( void );
void net_game_send_client_matrix ( void );
void net_game_recv_client_matrix ( void );

void quit_game (void);



int main (int argc, char *argv[])
{

  NO_BEEP   = 0; /* beeps are enabled by default */
                 /* --no-beep disable beeps      */
  NO_COLORS = 0; /* colors are enabled by default */
                 /* --no-colors disable colors    */

  parse_cmd_args(argc, argv);


  main_menu ();

  quit_game ();

  return 0;
}


void print_header (int type)
{
  nettoe_term_clear ();

  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("+-----------------------------------------------------------+\n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("|");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" netToe %s ", VERSION);
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("|-XOX-OXO-OOO-XXX-|");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" The Net Tic Tac Toe Game ");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("|\n");

  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  if (type == 0)
     printf ("+-----------------------------------------------------------+\n");
  else
     printf ("+--------------------------+--------------------------------+\n");
     
  nettoe_term_set_default_color();
}

void main_menu (void)
{
  int selection;

  print_header (0);
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("\n       [ ");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("Main Menu");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" ]\n\n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("   (");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("1");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (")");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" Player VS CPU\n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("   (");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("2");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (")");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" Player VS Player\n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("   (");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("3");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (")");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" Two players over network\n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("   (");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("4");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (")");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" Infos\n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("   (");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("5");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (")");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" Quit\n");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("\n Selection: ");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  scanf ("%d", &selection);
  nettoe_term_set_default_color ();

  if (selection == 1)
    {
      get_cpu_AI ();

      who_starts = who_start_first ();
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf ("\n Player 1 please type your name: ");
      nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
      scanf ("%s", player1_name);
      nettoe_term_set_default_color ();

      while ((check_pname(player1_name, MAX_PNAME_LEN)) != 0) {
	 printf(" Error: name cannot be more than %d chars long.\n", MAX_PNAME_LEN);
	 printf("\n Player 1 please type your name: ");
	 scanf("%s", player1_name);
      }
	  
      if (who_starts == 1)
	{
	  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
	  printf ("\n Who will start first ? (random selection)\n");
	  printf ("\n %s will start first !\n", player1_name);
	  nettoe_term_set_default_color ();
	  sleep ( 2 );
	}
      else if (who_starts == 2)
	{
	  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
	  printf ("\n Who will start first ? (random selection)\n");
	  printf ("\n Computer will start first !\n");
	  nettoe_term_set_default_color ();
	  sleep ( 2 );
	}
      init_1_player_game ();
    }
  else if (selection == 2)
    {
      print_header (0);
      who_starts = who_start_first ();
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf ("\n Player 1 please type your name: ");
      nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
      scanf ("%s", player1_name);
      nettoe_term_set_default_color ();
       
      while ((check_pname(player1_name, MAX_PNAME_LEN)) != 0) {
	 printf(" Error: name cannot be more than %d chars long.\n", MAX_PNAME_LEN);
	 printf("\n Player 1 please type your name: ");
	 scanf("%s", player1_name);
      }
       
      printf ("\n Player 2 please type your name: ");
      scanf ("%s", player2_name);

      while ((check_pname(player2_name, MAX_PNAME_LEN)) != 0) {
	 printf(" Error: name cannot be more than %d chars long.\n", MAX_PNAME_LEN);
	 printf("\n Player 2 please type your name: ");
	 scanf("%s", player2_name);
      }       
       
      if (who_starts == 1)
	{
	  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
	  printf ("\n Who will start first ? (random selection)\n");
	  printf ("\n %s will start first !\n", player1_name);
	  nettoe_term_set_default_color ();
	  sleep ( 2 );
	}
      else if (who_starts == 2)
	{
	  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
	  printf ("\n Who will start first ? (random selection)\n");
	  printf ("\n %s will start first !\n", player2_name);
	  nettoe_term_set_default_color ();
	  sleep ( 2 );
	}

      init_2_player_game ();
    }
  else if (selection == 3)
    {
      network_options ();
    }
  else if (selection == 4)
    {
      print_header (0);
      print_infos_screen ();
      main_menu();
    }

  else if (selection == 5)
    {
      quit_game ();
    }
  else
    {
      nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
      printf ("\nError:");
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf (" wrong selection.\n");
      nettoe_term_set_default_color ();
      quit_game ();
    }
}

void init_matrix (void)
{
  c11 = ' ', c12 = ' ', c13 = ' ';
  c21 = ' ', c22 = ' ', c23 = ' ';
  c31 = ' ', c32 = ' ', c33 = ' ';
}

void init_1_player_game (void)
{
  char y_n[2];
  winner = 0;
  game_mode = 1;
  init_matrix ();

  if (who_starts == 1)
    {
      do
	{
	  who_starts = 2;
	  show_game ();
	  get_player1_move ();
	  show_game ();
	  winner = game_check ();
	  if (winner == 1)
	    break;
	  else if (winner == 3)
	    break;
	  if (computer_AI == 1)
	    {
	      get_cpu_normal_move ();
	    }
	  else if (computer_AI == 2)
	    {
	      get_cpu_hard_move ();
	    }


	  show_game ();
	  winner = game_check ();
	  if (winner == 2)
	    break;
	  else if (winner == 3)
	    break;
	}
      while (winner == 0);
    }
  else if (who_starts == 2)
    {
      do
	{
	  who_starts = 1;
	  show_game ();
	  if (computer_AI == 1)
	    {
	      get_cpu_normal_move ();
	    }
	  else if (computer_AI == 2)
	    {
	      get_cpu_hard_move ();
	    }

	  show_game ();
	  winner = game_check ();
	  if (winner == 2)
	    break;
	  else if (winner == 3)
	    break;
	  get_player1_move ();
	  show_game ();
	  winner = game_check ();
	  if (winner == 1)
	    break;
	  else if (winner == 3)
	    break;
	}
      while (winner == 0);
    }
  if (winner == 1)
    {
      nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
      printf ("\n%s wins !\n\n", player1_name);
      nettoe_term_set_default_color ();
      player1_status++;
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf ("do you want to play again ? [y/n]: ");
      scanf ("%s", y_n);
      nettoe_term_set_default_color ();
      if (!strcmp (y_n, "y"))
	{
	  init_1_player_game ();
	}
      else if (!strcmp (y_n, "n"))
	{
	  main_menu ();
	}
      else
	{
	  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
	  printf ("wrong answer I suppose you want to play again...\n");
	  nettoe_term_set_default_color ();
	  sleep ( 2 );
	  init_1_player_game ();
	}
    }
  else if (winner == 2)
    {
      nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
      printf ("\nComputer wins !\n\n");
      nettoe_term_set_default_color ();
      computer_status++;
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf ("do you want to play again ? [y/n]: ");
      nettoe_term_set_default_color ();
      scanf ("%s", y_n);
      nettoe_term_set_default_color ();
      if (!strcmp (y_n, "y"))
	{
	  init_1_player_game ();
	}
      else if (!strcmp (y_n, "n"))
	{
	  main_menu ();
	}
      else
	{
	  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
	  printf ("wrong answer I suppose you want to play again...\n");
	  nettoe_term_set_default_color ();
	  sleep ( 2 );
	  init_1_player_game ();
	}
    }
  else if (winner == 3)
    {
      printf ("\nThere is no winner !\n\n");
      printf ("do you want to play again ? [y/n]: ");
      scanf ("%s", y_n);
      if (!strcmp (y_n, "y"))
	{
	  init_1_player_game ();
	}
      else if (!strcmp (y_n, "n"))
	{
	  main_menu ();
	}
      else
	{
	  printf ("wrong answer I suppose you want to play again...\n");
	  sleep ( 2 );
	  init_1_player_game ();
	}
    }
}

void init_2_player_game (void)
{
  char y_n[2];
  winner = 0;
  game_mode = 2;
  init_matrix ();

  if (who_starts == 1)
    {
      do
	{
	  who_starts = 2;
	  show_game ();
	  get_player1_move ();
	  show_game ();
	  winner = game_check ();
	  if (winner == 1)
	    break;
	  else if (winner == 3)
	    break;
	  get_player2_move ();
	  show_game ();
	  winner = game_check ();
	  if (winner == 2)
	  break;
	  else if (winner == 3)
	  break;
	}
      while (winner == 0);
    }
  else if (who_starts == 2)
    {
      do
	{
	  who_starts = 1;
	  show_game ();
	  get_player2_move ();
	  show_game ();
	  winner = game_check ();
	  if (winner == 2)
	    break;
	  if (winner == 3)
	    break;
	  get_player1_move ();
	  show_game ();
	  winner = game_check ();
	  if (winner == 1)
	    break;
	  if (winner == 3)
	    break;
	}
      while (winner == 0);
    }

  if (winner == 1)
    {
      printf ("\n%s wins !\n\n", player1_name);
      player1_status++;
      printf ("do you want to play again ? [y/n]: ");
      scanf ("%s", y_n);
      if (!strcmp (y_n, "y"))
	{
	  init_2_player_game ();
	}
      else if (!strcmp (y_n, "n"))
	{
	  main_menu ();
	}
      else
	{
	  printf ("wrong answer I suppose you want to play again...\n");
	  sleep ( 2 );
	  init_2_player_game ();
	}
    }

  if (winner == 2)
    {
      printf ("\n%s wins !\n\n", player2_name);
      player2_status++;
      printf ("do you want to play again ? [y/n]: ");
      scanf ("%s", y_n);
      if (!strcmp (y_n, "y"))
	{
	  init_2_player_game ();
	}
      else if (!strcmp (y_n, "n"))
	{
	  main_menu ();
	}
      else
	{
	  printf ("wrong answer I suppose you want to play again...\n");
	  sleep ( 2 );
	  init_2_player_game ();
	}
    }
  else if (winner == 3)
    {
      printf ("\nThere is no winner !\n\n");
      printf ("do you want to play again ? [y/n]: ");
      scanf ("%s", y_n);
      if (!strcmp (y_n, "y"))
	{
	  init_2_player_game ();
	}
      else if (!strcmp (y_n, "n"))
	{
	  main_menu ();
	}
      else
	{
	  printf ("wrong answer I suppose you want to play again...\n");
	  sleep ( 2 );
	  init_1_player_game ();
	}
    }
}

void show_game (void)
{
  print_header (1);

  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("    Current Game");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("           |      ");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("Coordinates scheme\n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("                           |                        \n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("       |   |               |            |    |    \n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("     %c | %c | %c             |", c11, c12, c13);
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("         a1");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" |");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" a2");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" |");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" a3 \n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("    ---|---|---            |        ----|----|---- \n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("     %c | %c | %c             |",c21, c22, c23);
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("         b1");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" |");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" b2");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" |");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" b3 \n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("    ---|---|---            |        ----|----|---- \n");
  printf ("     %c | %c | %c             |", c31, c32, c33);
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("         c1");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" |");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" c2");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" |");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" c3 \n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("       |   |               |            |    |    \n");
  nettoe_term_set_default_color();

  if (game_mode == 1)
    {
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf ("+--------------------------+--------------------------------+\n");
      nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
      printf (" Score:");
      nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf (" %s", player1_name);
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf (" %d", player1_status);
      nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf (" Computer");
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf (" %d\n", computer_status);
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf ("+-----------------------------------------------------------+\n");
      nettoe_term_set_default_color();
    }
  else if (game_mode == 2)
    {
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf ("+--------------------------+--------------------------------+\n");
      nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
      printf (" Score:");
      nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf (" %s", player1_name);
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf (" %d", player1_status);
      nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf (" %s", player2_name);
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf (" %d\n", player2_status);
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf ("+-----------------------------------------------------------+\n");
      nettoe_term_set_default_color();
    }
  else if (game_mode == 3)
    {
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf ("+--------------------------+--------------------------------+\n");
      nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
      printf (" Score:");
      nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf (" %s", player1_name);
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf (" %d", player1_status);
      nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf (" %s", player2_name);
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf (" %d\n", player2_status);
      nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
      printf ("+-----------------------------------------------------------+\n");
      nettoe_term_set_default_color();
    }
}


void get_player1_move (void)
{
  char p1move[4];
  
  beep();

  printf ("\n%s, it's your turn: ", player1_name);
  scanf ("%s", p1move);
  if (!strcmp (p1move, "a1"))
    {
      if (c11 == ' ')
	{
	  c11 = 'X';
	}
      else if (c11 != ' ')
	{
	  get_player1_move ();
	}
    }
  else if (!strcmp (p1move, "a2"))
    {
      if (c12 == ' ')
	{
	  c12 = 'X';
	}
      else if (c12 != ' ')
	{
	  get_player1_move ();
	}
    }
  else if (!strcmp (p1move, "a3"))
    {
      if (c13 == ' ')
	{
	  c13 = 'X';
	}
      else if (c13 != ' ')
	{
	  get_player1_move ();
	}
    }
  else if (!strcmp (p1move, "b1"))
    {
      if (c21 == ' ')
	{
	  c21 = 'X';
	}
      else if (c21 != ' ')
	{
	  get_player1_move ();
	}
    }
  else if (!strcmp (p1move, "b2"))
    {
      if (c22 == ' ')
	{
	  c22 = 'X';
	}
      else if (c22 != ' ')
	{
	  get_player1_move ();
	}
    }
  else if (!strcmp (p1move, "b3"))
    {
      if (c23 == ' ')
	{
	  c23 = 'X';
	}
      else if (c23 != ' ')
	{
	  get_player1_move ();
	}
    }
  else if (!strcmp (p1move, "c1"))
    {
      if (c31 == ' ')
	{
	  c31 = 'X';
	}
      else if (c31 != ' ')
	{
	  get_player1_move ();
	}
    }
  else if (!strcmp (p1move, "c2"))
    {
      if (c32 == ' ')
	{
	  c32 = 'X';
	}
      else if (c32 != ' ')
	{
	  get_player1_move ();
	}
    }
  else if (!strcmp (p1move, "c3"))
    {
      if (c33 == ' ')
	{
	  c33 = 'X';
	}
      else if (c33 != ' ')
	{
	  get_player1_move ();
	}
    }
  else
    {
      get_player1_move ();
    }
}

void get_player2_move (void)
{
  char p2move[4];

  beep();

  printf ("\n%s, it's your turn: ", player2_name);
  scanf ("%s", p2move);
  if (!strcmp (p2move, "a1"))
    {
      if (c11 == ' ')
	{
	  c11 = '0';
	}
      else if (c11 != ' ')
	{
	  get_player2_move ();
	}
    }
  else if (!strcmp (p2move, "a2"))
    {
      if (c12 == ' ')
	{
	  c12 = '0';
	}
      else if (c12 != ' ')
	{
	  get_player2_move ();
	}
    }
  else if (!strcmp (p2move, "a3"))
    {
      if (c13 == ' ')
	{
	  c13 = '0';
	}
      else if (c13 != ' ')
	{
	  get_player2_move ();
	}
    }
  else if (!strcmp (p2move, "b1"))
    {
      if (c21 == ' ')
	{
	  c21 = '0';
	}
      else if (c21 != ' ')
	{
	  get_player2_move ();
	}
    }
  else if (!strcmp (p2move, "b2"))
    {
      if (c22 == ' ')
	{
	  c22 = '0';
	}
      else if (c22 != ' ')
	{
	  get_player2_move ();
	}
    }
  else if (!strcmp (p2move, "b3"))
    {
      if (c23 == ' ')
	{
	  c23 = '0';
	}
      else if (c23 != ' ')
	{
	  get_player2_move ();
	}
    }
  else if (!strcmp (p2move, "c1"))
    {
      if (c31 == ' ')
	{
	  c31 = '0';
	}
      else if (c31 != ' ')
	{
	  get_player2_move ();
	}
    }
  else if (!strcmp (p2move, "c2"))
    {
      if (c32 == ' ')
	{
	  c32 = '0';
	}
      else if (c32 != ' ')
	{
	  get_player2_move ();
	}
    }
  else if (!strcmp (p2move, "c3"))
    {
      if (c33 == ' ')
	{
	  c33 = '0';
	}
      else if (c33 != ' ')
	{
	  get_player2_move ();
	}
    }
  else
    {
      get_player2_move ();
    }
}

void get_cpu_AI (void)
{
  int selection;

  print_header (0);

  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("\n   [ ");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("Choose a difficult level");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" ]\n\n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("    (");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("1");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (")");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" Normal \n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("    (");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("2");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (")");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" Hard   \n");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("\n Selection: ");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  scanf ("%d", &selection);
  nettoe_term_set_default_color ();

  if (selection == 1)
    {
      computer_AI = 1;
    }
  else if (selection == 2)
    {
      computer_AI = 2;
    }
    
  else 
    {
      get_cpu_AI();
    }
}

void get_cpu_normal_move (void)
{
  printf ("\nComputer turn...\n");
  sleep ( 1 );

  if ((c11 == 'X') & (c12 == 'X') & (c13 == ' '))
    {
      c13 = '0';
      return;
    }
  else if ((c33 == 'X') & (c32 == 'X') & (c31 == ' '))
    {
      c31 = '0';
      return;
    }
  else if ((c11 == 'X') & (c21 == 'X') & (c31 == ' '))
    {
      c31 = '0';
      return;
    }
  else if ((c13 == 'X') & (c23 == 'X') & (c33 == ' '))
    {
      c33 = '0';
      return;
    }
  else if ((c13 == 'X') & (c22 == 'X') & (c31 == ' '))
    {
      c31 = '0';
      return;
    }
  else if ((c21 == 'X') & (c22 == 'X') & (c23 == ' '))
    {
      c23 = '0';
      return;
    }
  else if ((c23 == 'X') & (c22 == 'X') & (c21 == ' '))
    {
      c21 = '0';
      return;
    }
  else if ((c11 == 'X') & (c13 == 'X') & (c12 == ' '))
    {
      c12 = '0';
      return;
    }
  else if (c22 == ' ')
    {
      c22 = '0';
      return;
    }
  else if (c31 == ' ')
    {
      c31 = '0';
      return;
    }
  else if ((c31 == '0') & (c22 == '0') & (c13 == ' '))
    {
      c13 = '0';
      return;
    }
  else if (c12 == ' ')
    {
      c12 = '0';
      return;
    }

  else if ((c22 == '0') & (c11 == ' ') & (c33 == '0'))
    {
      c11 = '0';
      return;
    }
  else if ((c32 == '0') & (c22 == '0') & (c12 == ' '))
    {
      c12 = '0';
      return;
    }
  else if ((c12 == '0') & (c22 == '0') & (c32 == ' '))
    {
      c32 = '0';
      return;
    }
  else if (c33 == ' ')
    {
      c33 = '0';
      return;
    }
  else if (c23 == ' ')
    {
      c23 = '0';
      return;
    }
  else if (c21 == ' ')
    {
      c21 = '0';
      return;
    }
  else if (c13 == ' ')
    {
      c13 = '0';
      return;
    }
  else if (c11 == ' ')
    {
      c11 = '0';
      return;
    }
  else if (c32 == ' ')
    {
      c32 = '0';
      return;
    }
}

void get_cpu_hard_move (void)
{
  printf ("\nComputer turn...\n");
  sleep ( 1 );

  if ((c11 == 'X') & (c12 == 'X') & (c13 == ' '))
    {
      c13 = '0';
      return;
    }
  else if ((c33 == 'X') & (c32 == 'X') & (c31 == ' '))
    {
      c31 = '0';
      return;
    }
  else if ((c11 == 'X') & (c21 == 'X') & (c31 == ' '))
    {
      c31 = '0';
      return;
    }
  else if ((c13 == 'X') & (c23 == 'X') & (c33 == ' '))
    {
      c33 = '0';
      return;
    }
  else if ((c13 == 'X') & (c22 == 'X') & (c31 == ' '))
    {
      c31 = '0';
      return;
    }
  else if ((c21 == 'X') & (c22 == 'X') & (c23 == ' '))
    {
      c23 = '0';
      return;
    }
  else if ((c23 == 'X') & (c22 == 'X') & (c21 == ' '))
    {
      c21 = '0';
      return;
    }
  else if ((c11 == 'X') & (c13 == 'X') & (c12 == ' '))
    {
      c12 = '0';
      return;
    }
  else if ((c22 == 'X') & (c32 == ' ') & (c12 == 'X'))
    {
      c32 = '0';
      return;
    }
  else if (( c22 == ' ') & (c33 == ' '))
    {
      c22 = '0';
    }
  else if ((c22 == '0') & (c11 == '0') & (c33 == ' '))
    {
      c33 = '0';
    }
  else if ((c33 == ' ') & (c22 == ' '))
    {
      c22 = '0';
    }
  else if ((c31 == '0') & (c33 == '0') & (c32 == ' '))
    {
      c32 = '0';
    }
  else if ((c23 == '0') & (c22 == '0') & (c21 == ' '))
    {
      c21 = '0';
    }
  else if ((c12 == '0') & (c22 == '0') & (c32 == ' '))
    {
      c32 = '0';
    }
  else if ((c11 == '0') & (c33 == '0') & (c22 == ' '))
    {
    	c22 = '0';
    }		
  else if (c31 == ' ')
    {
      c31 = '0';
      return;
    }
  else if ((c31 == '0') & (c22 == '0') & (c13 == ' '))
    {
      c13 = '0';
      return;
    }
  else if (c12 == ' ')
    {
      c12 = '0';
      return;
    }

  else if ((c22 == '0') & (c11 == ' ') & (c33 == '0'))
    {
      c11 = '0';
      return;
    }
  else if ((c32 == '0') & (c22 == '0') & (c12 == ' '))
    {
      c12 = '0';
      return;
    }
  else if ((c12 == '0') & (c22 == '0') & (c32 == ' '))
    {
      c32 = '0';
      return;
    }
  else if (c33 == ' ')
    {
      c33 = '0';
      return;
    }
  else if (c23 == ' ')
    {
      c23 = '0';
      return;
    }
  else if (c21 == ' ')
    {
      c21 = '0';
      return;
    }
  else if (c13 == ' ')
    {
      c13 = '0';
      return;
    }
  else if (c11 == ' ')
    {
      c11 = '0';
      return;
    }
  else if (c32 == ' ')
    {
      c32 = '0';
      return;
    }
}

int game_check (void)
{

  if ((c11 == 'X') & (c12 == 'X') & (c13 == 'X'))
    {
      return 1;
    }
  if ((c21 == 'X') & (c22 == 'X') & (c23 == 'X'))
    {
      return 1;
    }
  if ((c31 == 'X') & (c32 == 'X') & (c33 == 'X'))
    {
      return 1;
    }

  if ((c11 == 'X') & (c21 == 'X') & (c31 == 'X'))
    {
      return 1;
    }
  if ((c12 == 'X') & (c22 == 'X') & (c32 == 'X'))
    {
      return 1;
    }
  if ((c13 == 'X') & (c23 == 'X') & (c33 == 'X'))
    {
      return 1;
    }

  if ((c11 == 'X') & (c22 == 'X') & (c33 == 'X'))
    {
      return 1;
    }
  if ((c13 == 'X') & (c22 == 'X') & (c31 == 'X'))
    {
      return 1;
    }

  if ((c11 == '0') & (c12 == '0') & (c13 == '0'))
    {
      return 2;
    }
  if ((c21 == '0') & (c22 == '0') & (c23 == '0'))
    {
      return 2;
    }
  if ((c31 == '0') & (c32 == '0') & (c33 == '0'))
    {
      return 2;
    }

  if ((c11 == '0') & (c21 == '0') & (c31 == '0'))
    {
      return 2;
    }
  if ((c12 == '0') & (c22 == '0') & (c32 == '0'))
    {
      return 2;
    }
  if ((c13 == '0') & (c23 == '0') & (c33 == '0'))
    {
      return 2;
    }

  if ((c11 == '0') & (c22 == '0') & (c33 == '0'))
    {
      return 2;
    }
  if ((c13 == '0') & (c22 == '0') & (c31 == '0'))
    {
      return 2;
    }

  if ((c11 != ' ') && (c12 != ' ') && (c13 != ' ') && (c21 != ' ') && (c22 != ' ') && (c23 != ' ') && (c31 != ' ') && (c32 != ' ') & (c33 != ' '))
    {
      return 3;
    }

  return 0;
}

void network_options (void)
{
  int selection;

  print_header (0);
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("\n   [ ");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("Network game options");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" ]\n\n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("    (");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("1");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (")");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" Host the game\n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("    (");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("2");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (")");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" Connect to host\n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("    (");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("3");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (")");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" Back to main menu\n");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("\n Selection: ");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  scanf ("%d", &selection);
  nettoe_term_set_default_color ();

  if (selection == 1)
    {
      server_start ();
    }
  else if (selection == 2)
    {
      client_start ();
    }
  else if (selection == 3)
    {
      main_menu ();
    }
  else
    {
      printf ("\nError: wrong selection\n");
      sleep ( 2 );
      network_options ();
    }
}

int server_start (void)
{
  int transf_bytes;
  char buf[MAXDATASIZE];
  char local_ip_address[20];
  char peer_ip_address[20];

  print_header (0);

  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("\n   [ ");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("Host the game");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" ]\n\n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("    Player name: ");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  scanf ("%s", player1_name);
  strcpy (local_ip_address, give_local_IP ());
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("\n    You should now tell your IP address to the 2nd player\n");
  printf ("\n   Connected players:\n");
  printf ("   ------------------\n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("   -");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" %s", player1_name);
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" (");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("you");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (")\n");

  server_write_sock = establish_listening_socket (SERVER_PORT_NUMBER, peer_ip_address);
  transf_bytes = write_to_socket (server_write_sock, player1_name, 20);

  sleep ( 2 );

  server_read_sock = connect_to_socket (peer_ip_address, CLIENT_PORT_NUMBER);

  transf_bytes = read (server_read_sock, player2_name, 20);
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("   -");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" %s", player2_name);
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" (");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("player 2");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (")\n");

  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("\n   found 2 players, starting game...\n");
  sleep ( 3 );

  print_header (0);
  printf ("\n   Who will start first ? (random selection)\n\n");

  who_starts = who_start_first ();

  if (who_starts == 1)
    {
      printf ("   %s will start first !\n", player1_name);
      transf_bytes = write_to_socket (server_write_sock, player1_name, 20);
    }

  else if (who_starts == 2)
    {
      printf ("   %s will start first !\n", player2_name);
      transf_bytes = write_to_socket (server_write_sock, player2_name, 20);
    }

  printf ("\n   Starting game...\n");

  nettoe_term_set_default_color ();

  sleep ( 2 );

  init_server_network_game ();

  return 0;
}

void client_start (void)
{
  int transf_bytes;
  char buf[MAXDATASIZE];
  char host_ip_number[20];
  char peer_ip_address[20];

  print_header (0);

  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("\n   [ ");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("Connect to host");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" ]\n\n");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("    Player name: ");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  scanf ("%s", player2_name);
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("    Host to connect to (IP or hostname): ");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  scanf ("%s", host_ip_number);
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("\n   Connecting....\n");
  printf ("   -------------------------\n");

  client_read_sock = connect_to_socket (host_ip_number, SERVER_PORT_NUMBER);

  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("   connected !");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" players are:\n\n");
  transf_bytes = read_from_socket (client_read_sock, player1_name, 20);

  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("   -");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" %s", player1_name);
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" (");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("player 1");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (")\n");

  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("   -");
  nettoe_term_set_color (COLOR_BLUE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" %s", player2_name);
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (" (");
  nettoe_term_set_color (COLOR_RED, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("you");
  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf (")\n");


  client_write_sock = establish_listening_socket (CLIENT_PORT_NUMBER, peer_ip_address);
  transf_bytes = write_to_socket (client_write_sock, player2_name, 20);

  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);
  printf ("\n   found 2 players, starting game...\n");
  sleep ( 3 );

  print_header (0);
  printf ("\n   Who will start first ? (random selection)\n\n");

  transf_bytes = read_from_socket (client_read_sock, buf, 20);
  printf ("   %s will start first !\n", buf);
  printf ("\n   Starting game...\n");

  nettoe_term_set_default_color ();

  sleep ( 2 );

  init_client_network_game ();

}

void init_server_network_game (void)
{
  char y_n[2];
  char yes_no[2];
  int transf_bytes;
  char buf[MAXDATASIZE];
  char move_done[2];

  game_mode = 3;

  init_matrix ();

  if (who_starts == 1)
    {	
      transf_bytes = write_to_socket (server_write_sock, "1", 1);
    }
  else if (who_starts == 2)
    {	
      transf_bytes = write_to_socket (server_write_sock, "2", 1);
    }

  if (who_starts == 1)
    {
      do
	{
	  who_starts = 2;
	  show_game ();
	  get_player1_move ();
	  show_game ();
	  transf_bytes = write_to_socket (server_write_sock, move_done, 2);
	  net_game_send_server_matrix ();
	  transf_bytes = write_to_socket (server_write_sock, move_done, 2);
	  winner = game_check ();
	  if (winner == 1)
	    {
	      show_game ();
	      break;
	    }
	  if (winner == 2)
	    {
	      show_game ();
	      break;
	    }
	  if (winner == 3)
	    {
	      show_game ();
	      break;
	    }
	  printf ("\nwaiting for %s's move...\n", player2_name);
	  for (move_done[2] = 'y'; strcmp (buf, move_done);)
	    transf_bytes = read_from_socket (server_read_sock, buf, 2);
	  net_game_recv_server_matrix ();
	  move_done[20] = 'n';
	  for (move_done[2] = 'y'; strcmp (buf, move_done);)
	    transf_bytes = read_from_socket (server_read_sock, buf, 2);
	  winner = game_check ();
	  if (winner == 1)
	    {
	      show_game ();
	      break;
	    }
	  if (winner == 2)
	    {
	      show_game ();
	      break;
	    }
	  if (winner == 3)
	    {
	      show_game ();
	      break;
	    }
	}
      while (winner == 0);
    }

  else if (who_starts == 2)
    {
      do
	{
	  who_starts = 1;
	  show_game ();
	  printf ("\nwaiting for %s's move...\n", player2_name);
	  for (move_done[2] = 'y'; strcmp (buf, move_done);)
	    transf_bytes = read_from_socket (server_read_sock, buf, 2);
	  net_game_recv_server_matrix ();
	  move_done[20] = 'n';
	  for (move_done[2] = 'y'; strcmp (buf, move_done);)
	    transf_bytes = read_from_socket (server_read_sock, buf, 2);
	  show_game ();
	  winner = game_check ();
	  if (winner == 1)
	    {
	      show_game ();
	      break;
	    }
	  if (winner == 2)
	    {
	      show_game ();
	      break;
	    }
	  if (winner == 3)
	    {
	      show_game ();
	      break;
	    }
	  get_player1_move ();
	  show_game ();
	  transf_bytes = write_to_socket (server_write_sock, move_done, 2);
	  net_game_send_server_matrix ();
	  transf_bytes = write_to_socket (server_write_sock, move_done, 2);
	  winner = game_check ();
	  if (winner == 1)
	    {
	      show_game ();
	      break;
	    }
	  if (winner == 2)
	    {
	      show_game ();
	      break;
	    }
	  if (winner == 3)
	    {
	      show_game ();
	      break;
	    }
	}
      while (winner == 0);
    }
  if (winner == 1)
    {
      printf ("\n%s wins !\n\n", player1_name);
      player1_status++;
      beep();
      printf ("do you want to play again ? [y/n]: ");
      scanf ("%s", y_n);
      if (!strcmp (y_n, "y"))
	{
	  transf_bytes = write_to_socket (server_write_sock, move_done, 2);
	  transf_bytes = write_to_socket (server_write_sock, "y", 2);
	  printf ("Waiting for %s to choose if play again or not...\n",
		  player2_name);
	  for (move_done[2] = 'y'; strcmp (buf, move_done);)
	    transf_bytes = read_from_socket (server_read_sock, buf, 2);
	  transf_bytes = read_from_socket (server_read_sock, yes_no, 2);
	  if (!strcmp (yes_no, "y"))
	    {
	      printf ("\n%s wants to play again.\n", player2_name);
	      printf ("Starting...\n");
	      sleep ( 4 );
	      init_server_network_game ();
	    }
	}
      else if (!strcmp (y_n, "n"))
	{
	  transf_bytes = write_to_socket (server_write_sock, move_done, 2);
	  transf_bytes = write_to_socket (server_write_sock, "n", 2);
	  sleep ( 2 );
	  quit_game ();
	}
      else
	{
	  printf ("wrong answer I suppose you want to play again...\n");
	  sleep ( 2 );
	  transf_bytes = write_to_socket (server_write_sock, move_done, 2);
	  transf_bytes = write_to_socket (server_write_sock, "y", 2);
	  printf ("Waiting for %s to choose if play again or not...\n", player2_name);
	  for (move_done[2] = 'y'; strcmp (buf, move_done);)
	    transf_bytes = read_from_socket (server_read_sock, buf, 2);
	  transf_bytes = read_from_socket (server_read_sock, yes_no, 2);
	  if (!strcmp (yes_no, "y"))
	    {
	      printf ("\n%s wants to play again.\n", player2_name);
	      printf ("Starting...\n");
	      sleep ( 4 );
	      init_server_network_game ();
	    }	
	}
    }

  if (winner == 2)
    {
      printf ("\n%s wins !\n\n", player2_name);
      player2_status++;
      beep();
      printf ("do you want to play again ? [y/n]: ");
      scanf ("%s", y_n);
      if (!strcmp (y_n, "y"))
	{
	  transf_bytes = write_to_socket (server_write_sock, move_done, 2);
	  transf_bytes = write_to_socket (server_write_sock, "y", 2);
	  printf ("Waiting for %s to choose if play again or not...\n",
		  player2_name);
	  for (move_done[2] = 'y'; strcmp (buf, move_done);)
	    transf_bytes = read_from_socket (server_read_sock, buf, 2);
	  transf_bytes = read_from_socket (server_read_sock, yes_no, 2);
	  if (!strcmp (yes_no, "y"))
	    {
	      printf ("\n%s wants to play again.\n", player2_name);
	      printf ("Starting...\n");
	      sleep ( 4 );
	      init_server_network_game ();
	    }
	}
      else if (!strcmp (y_n, "n"))
	{
	  transf_bytes = write_to_socket (server_write_sock, move_done, 2);
	  transf_bytes = write_to_socket (server_write_sock, "n", 2);
	  sleep ( 3 );
	  quit_game ();
	}
      else
	{
	  printf ("wrong answer I suppose you want to play again...\n");	
	  sleep ( 2 );
	  transf_bytes = write_to_socket (server_write_sock, move_done, 2);
	  transf_bytes = write_to_socket (server_write_sock, "y", 2);
	  printf ("Waiting for %s to choose if play again or not...\n", player2_name);
	  for (move_done[2] = 'y'; strcmp (buf, move_done);)
	    transf_bytes = read_from_socket (server_read_sock, buf, 2);
	  transf_bytes = read_from_socket (server_read_sock, yes_no, 2);
	  if (!strcmp (yes_no, "y"))
	    {
	      printf ("\n%s wants to play again.\n", player2_name);
	      printf ("Starting...\n");
	      sleep ( 4 );
	      init_server_network_game ();
	    }	
	}
    }
  else if (winner == 3)
    {
      printf ("\nThere is no winner !\n\n");
      beep();
      printf ("do you want to play again ? [y/n]: ");
      scanf ("%s", y_n);
      if (!strcmp (y_n, "y"))
	{
	  transf_bytes = write_to_socket (server_write_sock, move_done, 2);
	  transf_bytes = write_to_socket (server_write_sock, "y", 2);
	  printf ("Waiting for %s to choose if play again or not...\n", player2_name);
	  for (move_done[2] = 'y'; strcmp (buf, move_done);)
	    transf_bytes = read_from_socket (server_read_sock, buf, 2);
	  transf_bytes = read_from_socket (server_read_sock, yes_no, 2);
	  if (!strcmp (yes_no, "y"))
	    {
	      printf ("\n%s wants to play again.\n", player2_name);
	      printf ("Starting...\n");
	      sleep ( 4 );
	      init_server_network_game ();
	    }
	}
      else if (!strcmp (y_n, "n"))
	{
	  transf_bytes = write_to_socket (server_write_sock, move_done, 2);
	  transf_bytes = write_to_socket (server_write_sock, "n", 2);
	  sleep ( 2 );
	  quit_game ();
	}
      else
	{
	  printf ("wrong answer I suppose you want to play again...\n");
	  sleep ( 2 );
	  transf_bytes = write_to_socket (server_write_sock, move_done, 2);
	  transf_bytes = write_to_socket (server_write_sock, "y", 2);
	  printf ("Waiting for %s to choose if play again or not...\n", player2_name);
	  for (move_done[2] = 'y'; strcmp (buf, move_done);)
	    transf_bytes = read_from_socket (server_read_sock, buf, 2);
	  transf_bytes = read_from_socket (server_read_sock, yes_no, 2);
	  if (!strcmp (yes_no, "y"))
	    {
	      printf ("\n%s wants to play again.\n", player2_name);
	      printf ("Starting...\n");
	      sleep ( 4 );
	      init_server_network_game ();
	    }	
	}
    }

  quit_game ();
}

void init_client_network_game (void)
{
  char y_n[2];
  char yes_no[2];
  int transf_bytes;
  char buf[MAXDATASIZE];
  char move_done[2];

  game_mode = 3;
  init_matrix ();

  transf_bytes = read_from_socket (client_read_sock, buf, 1);

  if (!strcmp (buf, "1"))
    {				
      who_starts = 1;
    }
  else if (!strcmp (buf, "2"))
    {				
      who_starts = 2;
    }

  if (who_starts == 1)
    {
      do
	{
	  who_starts = 2;
	  show_game ();
	  printf ("\nwaiting for %s's move...\n", player1_name);
	  for (move_done[2] = 'y'; strcmp (buf, move_done);)
	    transf_bytes = read_from_socket (client_read_sock, buf, 2);
	  net_game_recv_client_matrix ();
	  move_done[20] = 'n';
	  for (move_done[2] = 'y'; strcmp (buf, move_done);)
	    transf_bytes = read_from_socket (client_read_sock, buf, 2);
	  show_game ();
	  winner = game_check ();
	  if (winner == 1)
	    {
	      show_game ();
	      break;
	    }
	  if (winner == 2)
	    {
	      show_game ();
	      break;
	    }
	  if (winner == 3)
	    {
	      show_game ();
	      break;
	    }
	  get_player2_move ();
	  show_game ();
	  transf_bytes = write_to_socket (client_write_sock, move_done, 2);
	  net_game_send_client_matrix ();
	  transf_bytes = write_to_socket (client_write_sock, move_done, 2);
	  winner = game_check ();
	  if (winner == 1)
	    {
	      show_game ();
	      break;
	    }
	  if (winner == 2)
	    {
	      show_game ();
	      break;
	    }
	  if (winner == 3)
	    {
	      show_game ();
	      break;
	    }
	}
      while (winner == 0);
    }

  else if (who_starts == 2)
    {
      do
	{
	  who_starts = 1;
	  show_game ();
	  get_player2_move ();
	  show_game ();
	  transf_bytes = write_to_socket (client_write_sock, move_done, 2);
	  net_game_send_client_matrix ();
	  transf_bytes = write_to_socket (client_write_sock, move_done, 2);
	  winner = game_check ();
	  if (winner == 1)
	    {
	      show_game ();
	      break;
	    }
	  if (winner == 2)
	    {
	      show_game ();
	      break;
	    }
	  if (winner == 3)
	    {
	      show_game ();
	      break;
	    }
	  printf ("\nwaiting for %s's move...\n", player2_name);
	  for (move_done[2] = 'y'; strcmp (buf, move_done);)
	    transf_bytes = read_from_socket (client_read_sock, buf, 2);
	  net_game_recv_client_matrix ();
	  move_done[20] = 'n';
	  for (move_done[2] = 'y'; strcmp (buf, move_done);)
	    transf_bytes = read_from_socket (client_read_sock, buf, 2);
	  winner = game_check ();
	  if (winner == 1)
	    {
	      show_game ();
	      break;
	    }
	  if (winner == 2)
	    {
	      show_game ();
	      break;
	    }
	  if (winner == 3)
	    {
	      show_game ();
	      break;
	    }
	}
      while (winner == 0);
    }
  if (winner == 1)
    {
      printf ("\n%s wins !\n\n", player1_name);
      player1_status++;
      printf ("waiting for %s to choose if to play again or not...\n", player1_name);
      for (move_done[2] = 'y'; strcmp (buf, move_done);)
	transf_bytes = read_from_socket (client_read_sock, buf, 2);
      transf_bytes = read_from_socket (client_read_sock, yes_no, 2);
      if (!strcmp (yes_no, "y"))
	{
	  printf ("\n%s wants to play again. What about you ?\n", player1_name);
          beep();
	  printf ("do you want to play again ? [y/n]: ");
	  scanf ("%s", y_n);

	  if (!strcmp (y_n, "y"))
	    {
	      transf_bytes = write_to_socket (client_write_sock, move_done, 2);
	      transf_bytes = write_to_socket (client_write_sock, "y", 2);
	      printf ("Starting...\n");
	      sleep ( 4 );
	      init_client_network_game ();
	    }
	}
      else if (!strcmp (yes_no, "n"))
	{
	  printf ("\n%s doesn't want to play again. Sorry.\n", player1_name);
	  sleep ( 3 );
	  close (client_read_sock);
	  close (client_write_sock);
	  exit (EXIT_SUCCESS);
	}
      else {
	     printf ("wrong answer I suppose you want to play again...\n");
             sleep ( 2 );
             transf_bytes = write_to_socket (client_write_sock, move_done, 2);
	     transf_bytes = write_to_socket (client_write_sock, "y", 2);
	     printf ("Starting...\n");
	     sleep ( 4 );
	     init_client_network_game ();
           }
    }

  if (winner == 2)
    {
      printf ("\n%s wins !\n\n", player2_name);
      player2_status++;
      printf ("waiting for %s to choose if to play again or not...\n", player1_name);
      for (move_done[2] = 'y'; strcmp (buf, move_done);)
      transf_bytes = read_from_socket (client_read_sock, buf, 2);
      transf_bytes = read_from_socket (client_read_sock, yes_no, 2);
      if (!strcmp (yes_no, "y"))
	{
	  printf ("\n%s wants to play again. What about you ?\n", player1_name);
          beep();
	  printf ("do you want to play again ? [y/n]: ");
	  scanf ("%s", y_n);

	  if (!strcmp (y_n, "y"))
	    {
	      transf_bytes = write_to_socket (client_write_sock, move_done, 2);
	      transf_bytes = write_to_socket (client_write_sock, "y", 2);
	      printf ("Starting...\n");
	      sleep ( 4 );
	      init_client_network_game ();
	    }
	}
      else if (!strcmp (yes_no, "n"))
	{
	  printf ("\n%s doesn't want to play again. Sorry.\n", player1_name);
	  sleep ( 3 );
	  quit_game ();
	}
      else {
	     printf ("wrong answer I suppose you want to play again...\n");
             sleep ( 2 );
             transf_bytes = write_to_socket (client_write_sock, move_done, 2);
	     transf_bytes = write_to_socket (client_write_sock, "y", 2);
	     printf ("Starting...\n");
	     sleep ( 4 );
	     init_client_network_game ();
           }
    }
  else if (winner == 3)
    {
      printf ("\nThere is no winner !\n\n");
      printf ("waiting for %s to choose if to play again or not...\n", player1_name);
      for (move_done[2] = 'y'; strcmp (buf, move_done);)
      transf_bytes = read_from_socket (client_read_sock, buf, 2);
      transf_bytes = read_from_socket (client_read_sock, yes_no, 2);
      if (!strcmp (yes_no, "y"))
	{
	  printf ("\n%s wants to play again. What about you ?\n", player1_name);
          beep();
	  printf ("do you want to play again ? [y/n]: ");
	  scanf ("%s", y_n);

	  if (!strcmp (y_n, "y"))
	    {
	      transf_bytes = write_to_socket (client_write_sock, move_done, 2);
	      transf_bytes = write_to_socket (client_write_sock, "y", 2);
	      printf ("Starting...\n");
	      sleep ( 4 );
	      init_client_network_game ();
	    }
	}
      else if (!strcmp (yes_no, "n"))
	{
	  printf ("\n%s doesn't want to play again. Sorry.\n", player1_name);
	  sleep ( 3 );
          quit_game ();
	}
     else {
	     printf ("wrong answer I suppose you want to play again...\n");
             sleep ( 2 );
             transf_bytes = write_to_socket (client_write_sock, move_done, 2);
	     transf_bytes = write_to_socket (client_write_sock, "y", 2);
	     printf ("Starting...\n");
	     sleep ( 4 );
	     init_client_network_game ();
           }
      quit_game ();
    }
}

void net_game_send_server_matrix ( void )
{
  int transf_bytes;
  transf_bytes = write_to_socket (server_write_sock, &c11, 1);
  transf_bytes = write_to_socket (server_write_sock, &c12, 1);
  transf_bytes = write_to_socket (server_write_sock, &c13, 1);
  transf_bytes = write_to_socket (server_write_sock, &c21, 1);
  transf_bytes = write_to_socket (server_write_sock, &c22, 1);
  transf_bytes = write_to_socket (server_write_sock, &c23, 1);
  transf_bytes = write_to_socket (server_write_sock, &c31, 1);
  transf_bytes = write_to_socket (server_write_sock, &c32, 1);
  transf_bytes = write_to_socket (server_write_sock, &c33, 1);
}

void net_game_recv_server_matrix ( void )
{
  int transf_bytes;
  transf_bytes = read_from_socket (server_read_sock, &c11, 1);
  transf_bytes = read_from_socket (server_read_sock, &c12, 1);
  transf_bytes = read_from_socket (server_read_sock, &c13, 1);
  transf_bytes = read_from_socket (server_read_sock, &c21, 1);
  transf_bytes = read_from_socket (server_read_sock, &c22, 1);
  transf_bytes = read_from_socket (server_read_sock, &c23, 1);
  transf_bytes = read_from_socket (server_read_sock, &c31, 1);
  transf_bytes = read_from_socket (server_read_sock, &c32, 1);
  transf_bytes = read_from_socket (server_read_sock, &c33, 1);
}

void net_game_send_client_matrix ( void )
{
  int transf_bytes;
  transf_bytes = write_to_socket (client_write_sock, &c11, 1);
  transf_bytes = write_to_socket (client_write_sock, &c12, 1);
  transf_bytes = write_to_socket (client_write_sock, &c13, 1);
  transf_bytes = write_to_socket (client_write_sock, &c21, 1);
  transf_bytes = write_to_socket (client_write_sock, &c22, 1);
  transf_bytes = write_to_socket (client_write_sock, &c23, 1);
  transf_bytes = write_to_socket (client_write_sock, &c31, 1);
  transf_bytes = write_to_socket (client_write_sock, &c32, 1);
  transf_bytes = write_to_socket (client_write_sock, &c33, 1);
}

void net_game_recv_client_matrix ( void )
{
  int transf_bytes;
  transf_bytes = read_from_socket (client_read_sock, &c11, 1);
  transf_bytes = read_from_socket (client_read_sock, &c12, 1);
  transf_bytes = read_from_socket (client_read_sock, &c13, 1);
  transf_bytes = read_from_socket (client_read_sock, &c21, 1);
  transf_bytes = read_from_socket (client_read_sock, &c22, 1);
  transf_bytes = read_from_socket (client_read_sock, &c23, 1);
  transf_bytes = read_from_socket (client_read_sock, &c31, 1);
  transf_bytes = read_from_socket (client_read_sock, &c32, 1);
  transf_bytes = read_from_socket (client_read_sock, &c33, 1);
}

void quit_game (void)
{

  nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_BRIGHT);

  printf("\n Goodbye !\n\n");

  nettoe_term_reset_color ();

  printf("netToe Copyright 2000,2001 Gabriele Giorgetti %s\n", AUTHOR_EMAIL);
  printf("netToe project homepage: %s\n\n", HOMEPAGE);

  close (server_read_sock);
  close (server_write_sock);
  close (client_read_sock);
  close (client_write_sock);

  exit (EXIT_SUCCESS);
}


