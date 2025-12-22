#
#   Copyright 2005 by Mark Weyer
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

Baender = {
  name = "Ribbons"
  name[de] = "Bänder"
  author = "Mark Weyer"
  description = "Ribbons connect diagonally. They also kill the red ribbons diagonally."
  description[de] = "Bänder verbinden sich diagonal. Auch die roten Bänder werden diagonal gesprengt."
  neighbours = <neighbours_diagonal>
  numexplode[1] = 5
  numexplode[2] = 4
  startpic = Gras
  startdist = "A.........","AA...A....","AAA.AAA..A","AAAAAAAAAA"
  greypic = Grau
  emptypic = Hinter
  pics[1] = Band * 5
  pics[2] = Band * 4

  <<
    Malen = {
      qu=Q_TL;
      if kind@(-1,-1)==kind -> A else B;
      *;
      if kind@(1,-1)==kind -> {C; *@(1,0)};
      qu=Q_TR;
      if kind@(1,-1)==kind -> A else B;
      *;
      if kind@(-1,-1)==kind -> {C; @(-1,0)*};
      qu=Q_BL;
      if kind@(-1,1)==kind -> A else B;
      *;
      if kind@(1,1)==kind -> {C; @(1,0)*};
      qu=Q_BR;
      if kind@(1,1)==kind -> A else B;
      *;
      if kind@(-1,1)==kind -> {C; *@(-1,0)};
    };
  >>

  Band = {
    pics = mbaBand1.xpm, mbaBand2.xpm, mbaBand3.xpm, mbaBand4.xpm, mbaBand5.xpm
    <<
      Band = {file=kind-Band; Malen;};
    >>
  }

  Gras = {
    pics = mbaGras.xpm
    <<
      Gras = Malen;
    >>
  }

  Grau = {
    pics = mbaGrau.xpm
    <<
      Grau = Malen;
    >>
  }

  Hinter = {
    pics = mbaHinter.xpm, mbaHinter2.xpm
    <<
      Hinter = {file=(loc_x+loc_y)%2; B; *};
    >>
  }

}
