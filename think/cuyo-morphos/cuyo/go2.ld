#
#   Copyright 2006 by Mark Weyer
#   contains code by Immanuel Halupczok
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

GoII={
  name = "Go"
  author = "Mark Weyer"
  description = "Why to place your goban horizontally"
  description[de] = "Warum man den Goban nicht hochkant verwendet"
  pics = Stein*2
  startpic = igGo.xpm
  startdist = "A........A","AA......AA","AAA....AAA","AAAA..AAAA"
  emptypic = Rand
  chaingrass = 1

  Stein = {
    numexplode = 0
    pics = igSchwarz.xpm,igWeiss.xpm
    greyprob = 1

    <<
      Stein = {
        weight = -(falling
          || (kind@(1,0)==Rand) || (kind@(-1,0)==Rand)
          || (kind@(0,1)==Rand) || (kind@(0,-1)==Rand));
            # -1, wenn der Stein Freiheiten hat
        if falling -> C else A;
        file=kind-Stein;
        *;
      };
    >>
  }

  Rand = {
    pics = mgRand.xpm
    <<
      Rand = {
      switch {
        11111111 -> A;
        1?111111 -> M;
        111?1111 -> B;
        11111?11 -> E;
        1111111? -> D;
        111?111? -> I;
        1?111?11 -> C;
        ??11111? -> N;
        1???1111 -> F;
        111???11 -> H;
        11111??? -> P;
        ????111? -> O;
        1?????11 -> J;
        111????? -> G;
        ??111??? -> L;
        ???????? -> K;
      };
      if (pos>0) -> *;
      };
    >>
  }
}
