/*
    Amiga port by Oliver Gantert

    27.04.2000 - fixed some compiler warnings
    18.06.2000 - char *screen was changed and later passed
                 to free() - fixed, picture was saved vertically
                 mirrored - fixed, function rewritten.
*/
/*

ORBIT, a freeware space combat simulator
Copyright (C) 1999  Steve Belczyk <steve1@genesis.nred.ma.us>

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

*/

#include "orbit.h"

void ScreenShot()
{
  char fname[32];
  char *screen,
  *work,
  *line;
  FILE *fd;
  int  x,
  y,
  linelen = ScreenWidth * 3;

  /* Construct file name */
  sprintf (fname, "orbit%03d.ppm", screen_shot_num);

  /* Allocate space for screen */
  if (screen = (char *)malloc(linelen*ScreenHeight))
  {
    /* Get frame buffer */
    glReadPixels (0, 0, ScreenWidth, ScreenHeight, GL_RGB,
    GL_UNSIGNED_BYTE, screen);

    if (line = (char *)malloc(linelen))
    {
      /* Open the file */
      if (fd = fopen(fname, "wb"))
      {
        /* Write the PPM file */
        fprintf (fd, "P6\n%d %d\n255\n", ScreenWidth, ScreenHeight);

        work = screen + linelen*ScreenHeight;
        for (y=0; y<ScreenHeight; y++)
        {
          for (x=0; x<linelen; x+=3)
          {
            line[x+2] = 0xff & *--work;
            line[x+1] = 0xff & *--work;
            line[x]   = 0xff & *--work;
          }
          fwrite(line, linelen, 1, fd);
        }
        fclose(fd);
        screen_shot_num++;
        Cprint ("Screen shot saved in %s", fname);
      }
      else
      {
        Cprint ("Can't open screen shot file");
      }
      free(line);
    }
    else
    {
      Cprint ("Can't allocate memory for screen shot");
    }
    free(screen);
  }
  else
  {
    Cprint ("Can't allocate memory for screen shot");
  }
}
