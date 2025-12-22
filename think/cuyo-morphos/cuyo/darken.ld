#
#   Copyright <=2004 by Bernhard R. Link
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

Darken={
  name="Darken"
  author="brl"
  description="The less you know..."
  numexplode=6
  chaingrass=1
  pics=dnGreen,dnRed,dnBlue
  bgcolor=35,35,35
  topcolor=90,90,90
  textcolor=255,255,255
  toptime=90
  greypic=dnGray.xpm
  startpic=dnStart
  startdist="AAAAAAAAAA","AAAAAAAAAA"

  dnStart={
    pics=dnBlack2.xpm
    pics[1]=dnBlack.xpm
    schema=0
  }
  #dnGray={
  #pics="dnGray.xpm"
  #schema=0
  #}
  <<
  darken={
    switch {
      size == ..1 -> 0;
      size == 2   -> 1;
      size == 3   -> 2;
      size == 4.. -> 3;
    };
    schema16;
  };
  >>
  
  dnGreen={
    pics=dnGreen1.xpm,dnGreen2.xpm,dnGreen3.xpm,dnBlack.xpm
    << dnGreen=darken; >>
  }
  dnBlue={
    pics="dnBlue.xpm",dnBlue2.xpm,dnBlue3.xpm,dnBlack.xpm
    << dnBlue=darken; >>
  }
  dnRed={
    pics=dnRed1.xpm,dnRed2.xpm,dnRed3.xpm,dnBlack.xpm
    << dnRed=darken; >>
  }
}

