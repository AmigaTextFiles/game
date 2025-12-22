#
#   Copyright 2006 by Bernhard Seckinger
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#

# Status: (M=Muss, S=Soll, K=Kann, F=Feature, B=Bugs)
#
# Fertig.

Disco =
{
  #------------------------------------#
  # Allgemeine Beschreibung des Levels #
  #------------------------------------#

  name     = "Disco"
  name[de] = "Disko"
  author   = "Berni"
  description     = "Get rid of the strobos!"
  description[de] = "Werde die Strobos los!"

  pics = All,All,All,All

  greypic   = Grey
  startpic  = Start
  startdist = "..FE.FF...",
	      ".EFE.FEFE.",
	      "FFEE.EFEFF",
	      "FEEEFFEFEF"

  numexplode = 6

  bgcolor    = 128,128,128
  topcolor   = 0,0,0
  topoverlap = 0
  toptime    = 5
  textcolor  = 60,60,255

  randomgreys[1] = 25
  randomgreys = 50

  Grey =
  {
    pics = bddisco.xpm
    
    <<
      Grey =
        {
	  G*;
	};
    >>
  }

  Start =
  {
    pics = bddisco.xpm

    <<
      Start =
	{
	  version = 9-version;
	  pos = version;*;
	};
    >>
  }

  All = 
  {
    pics = bddisco.xpm

    <<
      All = 
        {
          if !falling =>
            if 1:3 => kind = rnd(4);

	  pos=kind;*;
	};
    >>
  }
}
