/*
  Diamond Girl - Game where player collects diamonds.
  Copyright (C) 2005  Joni Yrjana
  
  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.
  
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  
  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA


  Complete license can be found in the LICENSE file.
*/

#include <stdlib.h>

#include "version.h"

#if !defined(DIAMOND_GIRL_VERSION)
# define DIAMOND_GIRL_VERSION 0
#endif
#if !defined(DIAMOND_GIRL_REVISION)
# define DIAMOND_GIRL_REVISION 0
#endif

int main(void)
{
  printf("#ifndef DIAMOND_GIRL_VERSION_H\n");
  printf("#define DIAMOND_GIRL_VERSION_H\n");
  printf("\n");
  printf("#define DIAMOND_GIRL_VERSION %d\n", (int) DIAMOND_GIRL_VERSION);
  printf("#define DIAMOND_GIRL_REVISION %d\n", (int) DIAMOND_GIRL_REVISION + 1);
  printf("\n");
  printf("#endif\n");
  
  return EXIT_SUCCESS;
}
