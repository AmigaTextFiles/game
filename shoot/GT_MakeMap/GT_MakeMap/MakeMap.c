/****h* GalaxyTools/MakeMap.c [1.0b] *
*   NAME
*     MakeMap.c -- Create a map of the Galaxy (v1.0b)
*
*  COPYRIGHT
*    (c) Maverick Software Development 1995.
*    This software is public domain and can be freely redistributed as
*    long as it is in it's original state.
*
*  SYNOPSIS
*    MakeMap  <turn-report>  <Width-of-Galaxy>  <Height-of-Galaxy>
*
*  INPUTS
*    turn_report          -- a turn report file.
*    Width-of-Galaxy      -- with of the galaxy (in ly)
*    Height-of-Galaxy     -- height of the galaxy (in ly)
*
*  FUNCTION
*    This is a galaxy tool that given a turn report creates
*    a gnuplot program that makes a map of your current situation
*    in the galaxy.
*
*    The map includes:
*    o Your Planets
*    o Your Enemies Planets
*    o All  Uninhabited planets.
*    o Your Ships
*    o Your Enemies Ships.
*
*    MakeMap creates six files:
*    1 planets.mine   a list of all your planets.
*    2 planets.full   a list of all planets of your enemies.
*    3 planets.empty  a list of all Uninhabited planets.
*    4 ships.mine     a list with all your ships.
*    5 ships.enem     a list with all your enemies ships.
*    6 galaxy.map     the gnuplot file.
*
*    If you provide the MakeMap with an additional circ.planets file
*    it will also draw a 20 ly circle around all the planets
*    that you put in this file.
*    Each entry in this file should have the format:
*    <name>  <x-coordinate> <y-coordinate>
*    (You can cut this information from your turn report)
*
*    In addition if you have use the program Dist to compute the
*    various distances between planets, you can create an input
*    file for this program from the output files of makemap,
*    using:
*
*       cat pl* >>all_planets         (UNIX)
*       join pl#? to all_planets      (Amiga)
*
*  RESULT
*    A GNUPLOT file that will make the map of the galaxy.
*    To view the map, just say  gnuplot galaxy_map
*
*  AUTHOR
*    Frans Slothouber
*
*  CREATION DATE
*    9-June-1995
*
*  MODIFICATION HISTORY
*    9-June-1995  - version 1.0a
*   27-June-1195  - version 1.0b
*
*  NOTES
*    !!! IMPORTANT !!!
*    This program only works with turn reports that were generated
*    with the option UNDERSCORES on.
*
*    Has been successfully compiled with SAS 6.50 and DICE.
*
*  BUGS
*    o !!Sometimes a mail program will split lines that are longer than
*      80 chars. This causes the information about your planets in the turn
*      report to be split in two lines. You have to fix this first before
*      you can use MakeMap!!
*
*    o This program fails when you don't have any own planets.
*
*    Found other bugs?
*    Catch them in a jar and send them to slothoub@xs4all.nl.
*
**********
*/


#include <stdio.h>
#include <strings.h>
#include <ctype.h>
#include <stdlib.h>

#define LINE_BUFFER_LENGTH 100
#define TRUE 1
#define FALSE 0
#define MAP_ROWS 40
#define MAP_COLS 80

int map_width ;
int map_height ;

FILE *report_file = NULL ;
FILE *gnu_file    = NULL ;
FILE *circ_file   = NULL ;

char line_buffer1[LINE_BUFFER_LENGTH] ;
char line_buffer2[LINE_BUFFER_LENGTH] ;

void Get_Ships   (void) ;
void Get_Planets (char *file_name, char *mode) ;
int  Find_Marker (char *buffer,    char *Marker) ;

main (int arg_count, char **av)
{
  int return_code = 0 ;
  printf ("MakeMap -- galaxy map constructor version 1.0\n") ;
  printf ("           (c) 1995 Maverick Software Development\n") ;
  if (arg_count == 4)
  {
    if (report_file = fopen(av[1],"r"))
    {
      map_width  = atoi (av[2]) ;
      map_height = atoi (av[3]) ;
      if (gnu_file = fopen("galaxy_map","w"))
      {
        fprintf (gnu_file, "set nokey\n") ;
        fprintf (gnu_file, "set parametric\n") ;
        fprintf (gnu_file, "c1(x1,t) = x1+20*sin(t)\n") ;
        fprintf (gnu_file, "c2(x2,t) = %d-x2+20*cos(t)\n", map_height) ;
        Find_Marker (line_buffer1, "Status of Players") ;
        Get_Ships   () ;
        Find_Marker (line_buffer1, "Your") ;
        Get_Planets ("planets.mine","w") ;
        Find_Marker (line_buffer1, "Planets") ;
        Get_Planets ("planets.full","w") ;
        for (Find_Marker (line_buffer1, "Planets") ;
             !strstr     (line_buffer1, "Uninhabited") ;
             Find_Marker (line_buffer1, "Planets"))
        {
          Get_Planets ("planets.full","a") ;
        }
        Get_Planets ("planets.empty","w") ;
        fprintf (gnu_file, "plot \"planets.empty\" using 2:3, \\\n") ;
        if (circ_file = fopen("circ.planets","r"))
        {
          for (; !feof(circ_file) ; )
          {
            float x,y ;
            fgets(line_buffer1, LINE_BUFFER_LENGTH-2, circ_file) ;
            sscanf (line_buffer1, "%*s%f%f", &x, &y) ;
            fprintf (gnu_file, " c1(%f,t),c2(%f,t),\\\n", x, y) ;
          }
          fclose (circ_file) ;
        }
        fprintf (gnu_file, "   \"planets.mine\" using 2:3, \\\n") ;
        fprintf (gnu_file, "   \"planets.full\" using 2:3, \\\n") ;
        fprintf (gnu_file, "   \"ships.mine\", \\\n") ;
        fprintf (gnu_file, "   \"ships.enem\"\n") ;
      }
      else
      {
        printf ("ERROR: couldn't open gnuplot file\n") ;
        return_code = 101 ;
      }
    }
    else
    {
      printf ("ERROR: couldn't turn report.\n") ;
      return_code = 100 ;
    }
  }
  else
  {
    printf ("ERROR: incorrect number of parameters.\n") ;
    printf ("Usage: MakeMap <turn-report> <Width-of-Galaxy-Map> ") ;
    printf ("<Height-of-Galaxy-Map>\n") ;
    return_code = 100 ;
  }
  if (report_file) fclose (report_file) ;
  if (gnu_file)    fclose (gnu_file) ;
  return (return_code) ;
}


void Get_Ships ()
{
  char  *prev_line, *new_line ;
  int    found, line_nr ;
  float  x, y, deltax, deltay, xmin, ymin, xmax, ymax ;
  long   cur_file_pos ;
  FILE  *my_ships, *enemy_ships ;

  if (my_ships = fopen ("ships.mine", "w"))
  {
    if (enemy_ships = fopen ("ships.enem", "w"))
    {
      new_line  = line_buffer1 ; prev_line = line_buffer2 ;
      for (found = FALSE ;
           !found &&
           !feof(report_file) ; )
      {
         char *temp ;
        temp = new_line ; new_line = prev_line ; prev_line = temp ;
        fgets(new_line, LINE_BUFFER_LENGTH-2, report_file) ;
        found = !strncmp("----------", new_line, 10) ;
      }
      sscanf (prev_line, "%f,%f%f", &xmin, &ymin, &xmax) ;
      cur_file_pos = (long)ftell (report_file) ;
      Find_Marker (new_line, "---------------") ;
      fgets(new_line, LINE_BUFFER_LENGTH-2, report_file) ;
      sscanf (new_line, "%f,%f", &xmin, &ymax) ;

      fprintf (gnu_file, "set xrange[%f:%f]\n", xmin, xmax) ;
      fprintf (gnu_file, "set yrange[%f:%f]\n", map_height-ymax, map_height-ymin) ;

      fseek (report_file, cur_file_pos ,0) ;
      deltay = (ymax - ymin)/(float)MAP_ROWS ;
      deltax = (xmax - xmin)/(float)MAP_COLS ;
      for (line_nr = 0, y = ymin ;
           line_nr < MAP_ROWS && !(feof(report_file)) ;
           line_nr++ )
      {
        char *cur_char ;
        int tb ;
        fgets (new_line, LINE_BUFFER_LENGTH-2, report_file) ;
        y += deltay ;
        for (cur_char = new_line, x = xmin, tb = 8 ;
             *cur_char ;
             cur_char++)
        {
          if (*cur_char == '-') fprintf (enemy_ships, "%3.2f %3.2f\n", x, (float)map_height - y) ;
          if (*cur_char == '.') fprintf (my_ships, "%3.2f %3.2f\n", x, (float)map_height - y) ;
          if (*cur_char == '\t')
            { for (;tb > 0; tb--, x += deltax ) ; tb = 8 ; }
          else
            { tb-- ; if (tb == 0) tb = 8 ; x += deltax ; }
        }
      }
      fclose (enemy_ships) ;

    }
    else printf ("Warning can't open ships.enem\n") ;
    fclose (my_ships) ;
  }
  else printf ("Warning can't open ships.mine\n") ;
}


void Get_Planets (char *file_name, char *mode)
{
  FILE *dest ;
  float x,y ;
  char name[40] ;
  if (dest = fopen (file_name, mode))
  {
    fgets(line_buffer1, LINE_BUFFER_LENGTH-2, report_file) ;
    fgets(line_buffer1, LINE_BUFFER_LENGTH-2, report_file) ;
    for (;
         !isspace(*line_buffer1) && !feof(report_file) ;
        )
    {
      fgets(line_buffer1, LINE_BUFFER_LENGTH-2, report_file) ;
      if (!isspace(*line_buffer1))
      {
        sscanf (line_buffer1, "%s%f%f", name, &x, &y) ;
        fprintf (gnu_file, "set label \" %s\" at %f, %f\n",
                 name, x, (float)map_height - y) ;
        fprintf (dest, "%s %f %f\n",
                 name, x, (float)map_height - y) ;
      }
    }
    fclose (dest) ;
  }
  else printf ("Warning can't open %s\n", file_name) ;
}


int Find_Marker (char *buffer, char *Marker)
{
  char *found ;
  for (found = NULL ;
       !found && !feof(report_file) ;
      )
  {
    fgets(buffer, LINE_BUFFER_LENGTH-2, report_file) ;
    found = strstr (buffer, Marker) ;
  }
  return 0 ;
}
